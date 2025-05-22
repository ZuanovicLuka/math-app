"use client";

import { useRouter } from "next/navigation";
import { useEffect, useState } from "react";
import { apiCall } from "~/api";
import { useGetUser } from "~/queries/getUser";

export default function Quiz() {
  const router = useRouter();
  const userQuery = useGetUser();
  const razinaKviza = userQuery.data?.user?.schoolLevel || "";
  const [currentDate, setCurrentDate] = useState("");
  const [started, setStarted] = useState(false);
  const [completed, setCompleted] = useState(false);
  const [isLoading, setIsLoading] = useState(true);
  const [timeExpired, setTimeExpired] = useState(false);

  // funkcija koja iz localstorage-a dohvaća vrijeme kada je kviz bio započet i
  // ako je sada kada smo load-ali stranicu prošlo više od 60 minuta od kada smo započeli kviz idemo na page
  const checkTimeExpired = () => {
    if (typeof window !== "undefined") {
      const startTime = localStorage.getItem("startTime");
      if (startTime) {
        const now = Date.now();
        const elapsedSeconds = Math.floor((now - Number(startTime)) / 1000);
        return elapsedSeconds >= 60 * 60;
      }
    }
    return false;
  };

  const getQuizStatus = async () => {
    try {
      setIsLoading(true);
      const data = await apiCall(`/quizzes/status`, {
        method: "GET",
      });

      if (data[1] == 200) {
        setStarted(data[0].started);
        setCompleted(data[0].completed);
      }
    } catch (error) {
      console.error("Error getting quiz status:", error);
    } finally {
      setIsLoading(false);
    }
  };

  useEffect(() => {
    getQuizStatus();
    const options: Intl.DateTimeFormatOptions = {
      weekday: "long",
      day: "numeric",
      month: "long",
      year: "numeric",
    };
    const formattedDate = new Date().toLocaleDateString("hr-HR", options);
    setCurrentDate(formattedDate);

    if (checkTimeExpired()) {
      setTimeExpired(true);
    }
  }, []);

  useEffect(() => {
    if (completed) {
      router.push("/quiz/finished");
    } else if (timeExpired) {
      router.push("/quiz/start");
    }
  }, [completed, timeExpired]);

  // svaki user ce pokusati generirati kviz za taj dan, svakako se moze samo jednom generirati cim neki user
  // to napravi drugi nece morati
  const generateQuizzes = async () => {
    try {
      const data = await apiCall(`/quizzes/generate-daily-quizzes`, {
        method: "POST",
      });
      console.log(data);
      router.push("/quiz/start");
    } catch (error) {
      console.error("Error generating quizzes:", error);
    }
  };

  const startQuiz = () => {
    router.push("/quiz/start");
  };

  return (
    <div className="h-full flex flex-col items-center justify-center bg-blue-100 p-6 pb-40 md:pb-0">
      {isLoading ? (
        <>
          <div className="w-12 h-12 border-4 border-blue-500 border-t-transparent rounded-full animate-spin mb-4"></div>
          <p className="text-gray-700">Loading...</p>
        </>
      ) : completed ? (
        <>
          <div className="w-12 h-12 border-4 border-blue-500 border-t-transparent rounded-full animate-spin mb-4"></div>
          <p className="text-gray-700">Loading...</p>
        </>
      ) : (
        <div className="max-w-xl w-full bg-white rounded-xl shadow-lg overflow-hidden p-8 text-center">
          <div className="mb-6">
            <h1 className="text-4xl font-bold text-blue-700 mb-3">
              Dnevni Kviz
            </h1>
            <p className="text-gray-700 animate-bounce">
              🔥 Svaki dan novi matematički izazov! 🔥
            </p>
          </div>

          <div className="mb-8 p-4 bg-blue-50 rounded-lg">
            <p className="text-md text-gray-700 mb-1">Današnji datum:</p>
            <p className="text-xl font-semibold text-blue-700">{currentDate}</p>
          </div>

          <div className="mb-8">
            <p className="text-gray-700 mb-4 text-justify">
              Dnevni kviz sastoji se od{" "}
              <span className="font-bold text-gray-700">20</span> raznovrsnih
              pitanja iz područja matematike za vašu razinu obrazovanja:{" "}
              <span className="font-bold text-gray-700">{razinaKviza}</span>.
              Imate točno{" "}
              <span className="font-bold text-gray-700">60 minuta</span> da
              riješite cijeli kviz. Vaš rezultat će ovisiti i o točnosti
              odgovora i o brzini rješavanja -{" "}
              <span className="font-bold text-gray-700">
                što točniji i brži budete, to bolji rezultat postižete!
              </span>{" "}
              Pogrešni odgovori ne smanjuju bodove, pa slobodno pokušajte
              odgovoriti na sva pitanja.
            </p>
          </div>

          {!started ? (
            <button
              onClick={generateQuizzes}
              className="w-4/5 bg-blue-600 hover:bg-blue-700 text-white font-bold py-3 px-4 rounded-lg transition duration-300 transform hover:scale-105"
            >
              Započni Kviz
            </button>
          ) : (
            <button
              onClick={startQuiz}
              className="w-4/5 bg-green-600 hover:bg-green-700 text-white font-bold py-3 px-4 rounded-lg transition duration-300 transform hover:scale-105"
            >
              Nastavi sa rješavanjem
            </button>
          )}

          <div className="mt-6 pt-6 border-t border-gray-200">
            <p className="text-sm text-gray-500">
              Kviz se resetira u ponoć. Vratite se sutra za novi izazov!
            </p>
          </div>
        </div>
      )}
    </div>
  );
}
