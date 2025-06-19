"use client";

import { useParams } from "next/navigation";
import { useEffect, useState } from "react";
import { apiCall } from "~/api";

interface Task {
  taskId: number;
  questionText: string;
  options: string;
  correctAnswerIndex: number;
}

export default function LectionPage() {
  const params = useParams();
  const lectionId = params.id;

  const [tasks, setTasks] = useState<Task[]>([]);
  const [lectionTitle, setLectionTitle] = useState("");
  const [loading, setLoading] = useState(false);
  const [currentTaskIndex, setCurrentTaskIndex] = useState(0);
  const [selectedOption, setSelectedOption] = useState<number | null>(null);
  const [showFeedback, setShowFeedback] = useState(false);
  const [isTaskCompleted, setIsTaskCompleted] = useState(false);
  const [completedTaskIds, setCompletedTaskIds] = useState<number[]>([]);

  useEffect(() => {
    if (lectionId) {
      fetchTasks().then(() => {
        fetchCompletedTasks();
      });
    }
  }, [lectionId]);

  useEffect(() => {
    if (tasks.length > 0) {
      fetchUserTaskStatus(currentTask.taskId);
    }
  }, [currentTaskIndex, tasks]);

  const fetchTasks = async () => {
    setLoading(true);
    try {
      const [tasksData] = await apiCall(`/tasks/by-lection/${lectionId}`, {
        method: "GET",
      });

      if (tasksData?.tasks) {
        setTasks(tasksData.tasks);
        setLectionTitle(tasksData.lectionTitle || "");
      }
    } catch (error) {
      console.error("Error fetching tasks:", error);
    } finally {
      setLoading(false);
    }
  };

  const fetchCompletedTasks = async () => {
    try {
      const [response, status] = await apiCall(
        `/tasks/completed-tasks/${lectionId}`,
        {
          method: "GET",
        }
      );

      if (status == 200) {
        setCompletedTaskIds(response.completedTaskIds);
      }
    } catch (error) {
      console.error("Error fetching completed tasks:", error);
    }
  };

  const fetchUserTaskStatus = async (taskId: number) => {
    try {
      const [statusData, status] = await apiCall(
        `/tasks/user-task-status/${taskId}`,
        {
          method: "GET",
        }
      );

      if (status == 200) {
        setIsTaskCompleted(statusData.isCompleted);
        setShowFeedback(statusData.isCompleted);
        setSelectedOption(statusData.selectedOption);
      }
    } catch (error) {
      console.error("Error fetching task status:", error);
    }
  };

  const handleOptionSelect = (optionIndex: number) => {
    setSelectedOption(optionIndex);
    setShowFeedback(false);
  };

  const checkAnswer = () => {
    if (selectedOption !== null) {
      setShowFeedback(true);
    }
  };

  const toggleTaskCompletion = async () => {
    try {
      if (selectedOption === null) return;

      const [response, status] = await apiCall(
        `/tasks/toggle-completion/${currentTask.taskId}/${selectedOption}`,
        {
          method: "POST",
        }
      );

      if (status === 200) {
        const newCompletionStatus = !isTaskCompleted;
        setIsTaskCompleted(newCompletionStatus);
        setShowFeedback(newCompletionStatus);

        await fetchCompletedTasks();
      }
    } catch (error) {
      console.error("Error toggling task completion:", error);
    }
  };

  const currentTask = tasks[currentTaskIndex];
  const hasSelectedOption = selectedOption !== null;

  if (loading) {
    return (
      <div className="h-full flex flex-col items-center justify-center bg-blue-100 p-6">
        <div className="w-12 h-12 border-4 border-blue-500 border-t-transparent rounded-full animate-spin mb-4"></div>
        <p className="text-gray-700">Učitavanje...</p>
      </div>
    );
  }

  if (tasks.length === 0) {
    return (
      <div className="h-full flex flex-col items-center justify-center bg-blue-100 p-6">
        <p className="text-gray-700">Nema dostupnih zadataka za ovu lekciju</p>
      </div>
    );
  }

  return (
    <div className="h-full flex flex-col items-center bg-blue-100 p-6 pb-40 md:pb-0">
      <h1 className="text-2xl font-semibold mb-6">
        Zadaci iz lekcije: <b>{lectionTitle}</b>
      </h1>

      <div className="w-full max-w-2xl space-y-4 bg-white p-6 rounded-lg shadow-md">
        <h2 className="font-semibold text-lg mb-4">
          {currentTaskIndex + 1}. {currentTask.questionText}
        </h2>

        <div className="space-y-2">
          {currentTask.options.split("@").map((option, index) => {
            const isSelected = selectedOption === index;
            const isCorrectAnswer = index === currentTask.correctAnswerIndex;
            const optionLetter = String.fromCharCode(97 + index);
            let bgClass = "bg-white";
            let borderClass = "border-gray-300";

            if (showFeedback) {
              if (isCorrectAnswer) {
                bgClass = "bg-green-100";
                borderClass = "border-green-500";
              } else if (isSelected && !isCorrectAnswer) {
                bgClass = "bg-red-100";
                borderClass = "border-red-500";
              }
            } else if (isSelected) {
              bgClass = "bg-blue-100";
              borderClass = "border-blue-500";
            }

            return (
              <button
                key={index}
                onClick={() => handleOptionSelect(index)}
                className={`w-full text-left p-3 rounded border transition-colors duration-200 ${bgClass} ${borderClass} ${
                  !showFeedback && !isSelected ? "hover:bg-gray-100" : ""
                }`}
                disabled={isTaskCompleted}
              >
                <span className="font-semibold mr-2">{optionLetter}.</span>
                {option}
                {showFeedback && isCorrectAnswer && (
                  <span className="ml-2 text-green-600 text-sm">
                    (Točan odgovor)
                  </span>
                )}
                {showFeedback && isSelected && !isCorrectAnswer && (
                  <span className="ml-2 text-red-500 text-sm">
                    (Vaš odgovor)
                  </span>
                )}
              </button>
            );
          })}
        </div>

        <div className="flex justify-between mt-6">
          <button
            onClick={checkAnswer}
            disabled={!hasSelectedOption || isTaskCompleted}
            className={`px-4 py-2 rounded ${
              !hasSelectedOption || isTaskCompleted
                ? "bg-gray-300 cursor-not-allowed text-gray-500"
                : "bg-blue-600 text-white hover:bg-blue-700"
            }`}
          >
            Provjeri
          </button>

          <button
            onClick={toggleTaskCompletion}
            disabled={!hasSelectedOption}
            className={`px-4 py-2 rounded ${
              !hasSelectedOption
                ? "bg-gray-300 text-gray-500 cursor-not-allowed"
                : isTaskCompleted
                  ? "bg-green-300 text-green-800 hover:bg-green-400"
                  : "bg-gray-100 text-gray-800 hover:bg-gray-200"
            }`}
          >
            {isTaskCompleted ? "Naučeno ✓" : "Označi kao naučeno"}
          </button>
        </div>
      </div>

      <div className="mt-8 w-full max-w-2xl">
        <h3 className="font-semibold mb-4">
          Redni brojevi zadataka unutar lekcije:
        </h3>
        <div className="flex flex-wrap gap-2">
          {tasks.map((task, index) => {
            const isCurrent = currentTaskIndex === index;
            const isCompleted = completedTaskIds.includes(task.taskId);

            let bgClass = "bg-gray-200";
            let textClass = "text-gray-800";
            let borderClass = "border-gray-400";

            if (isCurrent) {
              bgClass = "bg-blue-600";
              textClass = "text-white";
              borderClass = "border-blue-700";
            } else if (isCompleted) {
              bgClass = "bg-green-300";
              textClass = "text-green-800";
              borderClass = "border-green-700";
            }

            return (
              <button
                key={index}
                onClick={() => {
                  setCurrentTaskIndex(index);
                }}
                className={`relative w-12 h-12 rounded-full flex items-center justify-center font-semibold border-1 ${bgClass} ${textClass} ${borderClass}`}
              >
                {index + 1}
                {isCompleted && (
                  <span className="absolute text-md ml-6 mt-2">✓</span>
                )}
              </button>
            );
          })}
        </div>
      </div>
    </div>
  );
}
