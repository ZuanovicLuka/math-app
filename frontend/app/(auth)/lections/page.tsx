"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import { apiCall } from "~/api";
import { useGetUser } from "~/queries/getUser";
import { FiArrowRight } from "react-icons/fi";

interface Lection {
  lectionId: number;
  title: string;
}

export default function Lections() {
  const router = useRouter();
  const userQuery = useGetUser();
  const [selectedSchoolLevel, setSelectedSchoolLevel] = useState(
    userQuery.data.user.schoolLevel
  );
  const [selectedGrade, setSelectedGrade] = useState(userQuery.data.user.grade);
  const [lections, setLections] = useState<Lection[]>([]);
  const [loading, setLoading] = useState(false);

  const [completedTasksCount, setCompletedTasksCount] = useState<
    Record<number, number>
  >({});

  useEffect(() => {
    if (selectedSchoolLevel && selectedGrade) {
      fetchLections();
    }
  }, [selectedSchoolLevel, selectedGrade]);

  const fetchLections = async () => {
    setLoading(true);
    try {
      const [data, status] = await apiCall(
        `/lections?schoolLevel=${selectedSchoolLevel}&grade=${selectedGrade}`,
        {
          method: "GET",
        }
      );

      if (status == 200) {
        const transformedLections = data.lections.map((lection: any) => ({
          lectionId: lection.lectionId,
          title: lection.title,
        }));

        setLections(transformedLections);

        const lectionIds = transformedLections.map((l: Lection) => l.lectionId);
        await fetchAllCompletedTasksCount(lectionIds);
      }
    } catch (error) {
      console.error("Error fetching lections:", error);
    } finally {
      setLoading(false);
    }
  };

  const fetchAllCompletedTasksCount = async (lectionIds: number[]) => {
    try {
      const [response] = await apiCall(
        `/tasks/completed-tasks-count?lectionIds=${lectionIds.join(",")}`,
        { method: "GET" }
      );

      if (response?.counts) {
        setCompletedTasksCount(response.counts);
      } else {
        const initialCounts = lectionIds.reduce(
          (acc, id) => ({ ...acc, [id]: 0 }),
          {}
        );
        setCompletedTasksCount(initialCounts);
      }
    } catch (error) {
      console.error("Error fetching completed tasks counts:", error);
      const initialCounts = lectionIds.reduce(
        (acc, id) => ({ ...acc, [id]: 0 }),
        {}
      );
      setCompletedTasksCount(initialCounts);
    }
  };

  const handleSchoolLevelChange = (level: string) => {
    setSelectedSchoolLevel(level);
    setSelectedGrade("");
  };

  const handleGradeChange = (grade: string) => {
    setSelectedGrade(grade);
  };

  const calculateProgressPercentage = (progress: number) => {
    const progressPercentage = (progress / 20) * 100;
    return progressPercentage;
  };

  const calculateProgressColor = (progress: number) => {
    const progressPercentage = calculateProgressPercentage(progress);

    let progressColor;
    if (progressPercentage < 25) {
      progressColor = "bg-red-500";
    } else if (progressPercentage < 50) {
      progressColor = "bg-orange-500";
    } else if (progressPercentage < 75) {
      progressColor = "bg-yellow-500";
    } else {
      progressColor = "bg-green-500";
    }

    return progressColor;
  };

  return (
    <div className="h-full flex flex-col items-center justify-center bg-blue-100 p-6 pb-40 md:pb-0">
      <div className="max-w-6xl mx-auto">
        <div className="bg-white rounded-lg shadow-md p-6 mb-8">
          <h2 className="text-xl font-semibold mb-4 text-gray-700">
            Odaberite razinu obrazovanja:
          </h2>
          <div className="flex gap-4">
            {["Osnovna škola", "Srednja škola"].map((level) => (
              <button
                key={level}
                onClick={() => handleSchoolLevelChange(level)}
                className={`px-6 py-2 rounded-lg transition-colors ${
                  selectedSchoolLevel === level
                    ? "bg-blue-600 text-white"
                    : "bg-gray-200 hover:bg-gray-300"
                }`}
              >
                {level}
              </button>
            ))}
          </div>
        </div>

        {selectedSchoolLevel && (
          <div className="bg-white rounded-lg shadow-md p-6 mb-8">
            <h2 className="text-xl font-semibold mb-4 text-gray-700">
              Odaberite razred:
            </h2>
            <div className="flex flex-wrap gap-2">
              {Array.from(
                {
                  length: selectedSchoolLevel === "Osnovna škola" ? 8 : 4,
                },
                (_, i) => i + 1
              ).map((grade) => (
                <button
                  key={grade}
                  onClick={() => handleGradeChange(grade.toString())}
                  className={`px-4 py-2 rounded-lg transition-colors ${
                    selectedGrade === grade.toString()
                      ? "bg-blue-600 text-white"
                      : "bg-gray-200 hover:bg-gray-300"
                  }`}
                >
                  {grade}. razred
                </button>
              ))}
            </div>
          </div>
        )}

        {selectedGrade && (
          <div className="bg-white rounded-lg shadow-md p-6">
            <h2 className="text-xl font-semibold mb-4 text-gray-700">
              Lekcije za: {selectedSchoolLevel} - {selectedGrade}. razred
            </h2>
            {loading ? (
              <div className="flex flex-col items-center justify-center py-8">
                <div className="w-12 h-12 border-4 border-blue-500 border-t-transparent rounded-full animate-spin mb-4"></div>
                <p className="text-gray-700">Loading...</p>
              </div>
            ) : lections.length === 0 ? (
              <p className="text-center text-gray-700 text-md py-8">
                Nema dostupnih lekcija za odabrani razred.
              </p>
            ) : (
              <div className="grid grid-cols-1 md:grid-cols-2 gap-6 max-h-[300px] overflow-y-auto pr-2">
                {lections.map((lection, index) => {
                  const progress = completedTasksCount[lection.lectionId] || 0;

                  return (
                    <div
                      key={lection.lectionId}
                      className="border border-gray-300 rounded-lg p-4 hover:shadow-md transition-all cursor-pointer flex flex-col relative min-h-[120px]"
                      onClick={() =>
                        router.push(
                          `/lections/${lection.lectionId}?title=${encodeURIComponent(lection.title)}`
                        )
                      }
                      onMouseEnter={(e) => {
                        const arrow = e.currentTarget.querySelector(
                          ".arrow-icon"
                        ) as HTMLElement;
                        if (arrow) {
                          arrow.style.opacity = "1";
                          arrow.style.transform = "translateX(4px)";
                        }
                      }}
                      onMouseLeave={(e) => {
                        const arrow = e.currentTarget.querySelector(
                          ".arrow-icon"
                        ) as HTMLElement;
                        if (arrow) {
                          arrow.style.opacity = "0";
                          arrow.style.transform = "translateX(0)";
                        }
                      }}
                    >
                      <div
                        className="arrow-icon"
                        style={{
                          position: "absolute",
                          right: "1.5rem",
                          top: "1.5rem",
                          color: "#2563eb",
                          opacity: 0,
                          transform: "translateX(0)",
                          transition: "opacity 300ms, transform 300ms",
                        }}
                      >
                        <FiArrowRight size={24} />
                      </div>

                      <h3 className="font-bold text-lg mb-2 pr-8 break-words line-clamp-2">
                        <span className="mr-2">{index + 1}.</span>
                        {lection.title}
                      </h3>

                      <div className="mt-auto">
                        <div className="flex justify-between text-sm mb-1">
                          <span className="text-gray-600">
                            Riješeni zadaci:
                          </span>
                          <span className="font-medium text-gray-800">
                            {progress} / 20
                          </span>
                        </div>

                        <div className="w-full bg-gray-200 rounded-full h-2.5">
                          <div
                            className={`h-2.5 rounded-full transition-all duration-300 ${calculateProgressColor(progress)}`}
                            style={{
                              width: `${calculateProgressPercentage(progress)}%`,
                            }}
                          ></div>
                        </div>
                      </div>
                    </div>
                  );
                })}
              </div>
            )}
          </div>
        )}
      </div>
    </div>
  );
}
