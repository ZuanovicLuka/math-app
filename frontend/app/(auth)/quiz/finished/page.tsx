"use client";

import { useRouter } from "next/navigation";
import { useEffect, useState } from "react";
import { apiCall } from "~/api";

interface Question {
  id: number;
  text: string;
  options: string[];
  correctAnswerIndex: number;
}

interface QuizData {
  quizId: number;
  date: string;
  schoolLevel: string;
  questions: Question[];
}

export default function QuizFinish() {
  const router = useRouter();
  const [quizData, setQuizData] = useState<QuizData | null>(null);
  const [quizScore, setQuizScore] = useState<number | null>(null);
  const [timeTakenSeconds, setTimeTakenSeconds] = useState<number>(0);
  const [started, setStarted] = useState(false);
  const [completed, setCompleted] = useState(false);
  const [isFlipped, setIsFlipped] = useState(false);
  const [userAnswers, setUserAnswers] = useState<string>("");
  const [isLoading, setIsLoading] = useState(true);

  const getDailyQuiz = async () => {
    try {
      const [data, status] = await apiCall(`/quizzes/get-daily-quiz`, {
        method: "GET",
      });

      if (status === 200) {
        const quiz = data.quiz;
        const questions = quiz.questions;

        const formattedQuestions = questions.map((q: any, index: number) => ({
          id: index,
          text: q.text,
          options: q.options,
          correctAnswerIndex: q.correctAnswerIndex,
        }));

        const quizData: QuizData = {
          quizId: quiz.quizId,
          date: quiz.quizDate,
          schoolLevel: quiz.schoolLevel,
          questions: formattedQuestions,
        };

        setQuizData(quizData);
        console.log("data:", quizData);
      }
    } catch (error) {
      console.error("Error getting quiz status:", error);
    }
  };

  const getQuizResult = async () => {
    try {
      // formatiramo datum kao YYYY-MM-DD
      const todayDate = new Date();
      const today = `${todayDate.getFullYear()}-${String(todayDate.getMonth() + 1).padStart(2, "0")}-${String(todayDate.getDate()).padStart(2, "0")}`;

      const [data, status] = await apiCall(
        `/quizzes/result-by-date?date=${today}`,
        { method: "GET" }
      );

      if (status === 200) {
        console.log("Quiz result:", data);
        setQuizScore(data.score);
        setTimeTakenSeconds(data.timeTakenSeconds);
        setUserAnswers(data.userAnswers || "");
      }
    } catch (error) {
      console.error("Error getting quiz result:", error);
    }
  };

  useEffect(() => {
    const checkAndLoadQuizData = async () => {
      setIsLoading(true);
      try {
        // Prvo provjeri status kviza
        const [statusData, status] = await apiCall(`/quizzes/status`, {
          method: "GET",
        });

        if (status === 200) {
          setStarted(statusData.started);
          setCompleted(statusData.completed);

          // Ako kviz nije završen, preusmjeri na /quiz
          if (!statusData.completed) {
            router.push("/quiz");
            return;
          }

          // Samo ako je kviz završen, dohvati ostale podatke
          await getDailyQuiz();
          await getQuizResult();
        }
      } catch (error) {
        console.error("Error checking quiz status:", error);
      } finally {
        setIsLoading(false);
      }
    };

    checkAndLoadQuizData();
  }, [router]);

  const formatTime = (seconds: number) => {
    const mins = Math.floor(seconds / 60);
    const secs = seconds % 60;
    return `${mins.toString().padStart(2, "0")}:${secs.toString().padStart(2, "0")}`;
  };

  const parseUserAnswer = (questionIndex: number): number | null => {
    if (!userAnswers) return null;
    const answers = userAnswers.split(",");
    if (questionIndex >= answers.length) return null;
    const answer = answers[questionIndex].trim();
    return answer === "" ? null : parseInt(answer);
  };

  const renderQuestionResult = (question: Question, index: number) => {
    const userAnswerIndex = parseUserAnswer(index);
    const isCorrect = userAnswerIndex == question.correctAnswerIndex;
    const hasAnswered = userAnswerIndex !== null;

    return (
      <div
        key={index}
        className={`mb-4 p-3 rounded-lg border-1 ${
          !hasAnswered
            ? "border-gray-300 bg-gray-100"
            : isCorrect
              ? "border-green-500 bg-green-200"
              : "border-red-500 bg-red-200"
        }`}
      >
        <h3 className="font-semibold text-lg mb-2">
          {index + 1}. {question.text}
        </h3>
        <div className="mb-2">
          <p>
            Točan odgovor:{" "}
            <b>{question.options[question.correctAnswerIndex]}</b>
          </p>
        </div>
        <div>
          <p
            className={
              !hasAnswered
                ? "text-gray-800"
                : isCorrect
                  ? "text-green-800"
                  : "text-red-800"
            }
          >
            Tvoj odgovor:{" "}
            <b>
              {hasAnswered
                ? question.options[userAnswerIndex]
                : "Nije odgovoreno"}
            </b>
          </p>
        </div>
      </div>
    );
  };

  return (
    <div className="h-full flex flex-col items-center justify-center bg-blue-100 p-6 pb-40 md:pb-0">
      {isLoading ? (
        <>
          <div className="w-12 h-12 border-4 border-blue-500 border-t-transparent rounded-full animate-spin mb-4"></div>
          <p className="text-gray-700">Loading...</p>
        </>
      ) : !completed ? (
        <>
          <div className="w-12 h-12 border-4 border-blue-500 border-t-transparent rounded-full animate-spin mb-4"></div>
          <p className="text-gray-700">Loading...</p>
        </>
      ) : (
        <div
          className={`relative w-full max-w-[28rem] h-[70%] [transform-style:preserve-3d] transition-transform duration-500 ${
            isFlipped ? "rotate-y-180" : ""
          }`}
        >
          {/* Front Side */}
          <div className="absolute w-full h-full backface-hidden bg-white rounded-xl shadow-lg p-8 text-center flex flex-col justify-center z-20">
            <h1 className="text-3xl font-bold text-blue-600 mb-6 animate-bounce">
              Kviz završen!
            </h1>
            <div className="mb-8 p-6 bg-blue-50 rounded-lg">
              <p className="text-2xl font-bold text-blue-700 mb-2">
                {quizScore} / {quizData?.questions.length}
              </p>
              <p className="text-gray-600">Točnih odgovora</p>
            </div>
            <div className="mb-8">
              <p className="text-lg font-semibold text-gray-700 mb-1">
                Vrijeme rješavanja:
              </p>
              <p className="text-xl text-blue-600">
                {formatTime(timeTakenSeconds)}
              </p>
            </div>
            <button
              onClick={() => setIsFlipped(true)}
              className="w-full bg-gray-600 hover:bg-gray-700 text-white font-bold py-3 px-4 rounded-lg transition duration-300 mb-4"
            >
              Prikaži detalje
            </button>
            <button
              onClick={() => router.push("/rank")}
              className="w-full bg-blue-600 hover:bg-blue-700 text-white font-bold py-3 px-4 rounded-lg transition duration-300"
            >
              Provjeri rang-listu
            </button>
          </div>

          {/* Back Side */}
          <div className="absolute w-full h-full backface-hidden bg-white rounded-xl shadow-lg p-8 text-center flex flex-col justify-center rotate-y-180">
            <h1 className="text-3xl font-bold text-blue-600 mb-6">
              Rezultati po pitanjima:
            </h1>

            <div className="mb-6">
              <div className="h-80 overflow-y-auto pr-2 space-y-4">
                {quizData?.questions.map((question, index) =>
                  renderQuestionResult(question, index)
                )}
              </div>
            </div>

            <button
              onClick={() => setIsFlipped(false)}
              className="w-full bg-gray-600 hover:bg-gray-700 text-white font-bold py-3 px-4 rounded-lg transition duration-300"
            >
              Natrag na rezultate
            </button>
          </div>
        </div>
      )}
    </div>
  );
}
