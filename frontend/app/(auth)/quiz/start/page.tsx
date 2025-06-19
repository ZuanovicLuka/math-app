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

export default function QuizStart() {
  const router = useRouter();
  const [started, setStarted] = useState(false);
  const [completed, setCompleted] = useState(false);

  // sva pitanja, tocni odgovori...
  const [quizData, setQuizData] = useState<QuizData | null>(null);
  const [currentQuestionIndex, setCurrentQuestionIndex] = useState(0);

  // ovo su odabrani odgovori koje se sprema i dohvaća iz localstorage-a sve dok se kviz ne završi
  // ili dok se korisnik ne odjavi
  const [selectedAnswers, setSelectedAnswers] = useState<number[]>(() => {
    if (typeof window !== "undefined") {
      const savedAnswers = localStorage.getItem("selectedAnswers");
      return savedAnswers ? JSON.parse(savedAnswers) : [];
    }
    return [];
  });

  const [startTime, setStartTime] = useState<number | null>(() => {
    if (typeof window !== "undefined") {
      const savedStartTime = localStorage.getItem("startTime");
      return savedStartTime ? Number(savedStartTime) : null;
    }
    return null;
  });

  // 20 minuta u sekundama
  const [timeLeft, setTimeLeft] = useState(20 * 60);

  // funkcija koja dohvaća stanje kviza (started i completed bools)
  const getQuizStatus = async () => {
    try {
      const [data, status] = await apiCall(`/quizzes/status`, {
        method: "GET",
      });

      if (status === 200) {
        setStarted(data.started);
        setCompleted(data.completed);
      }
    } catch (error) {
      console.error("Error getting quiz status:", error);
    }
  };

  // ovo započinje kviz, ako nije završen i ako nije već započet,
  // i vraća sve podatke o kvizu nazad
  const getDailyQuiz = async () => {
    try {
      const [data, status] = await apiCall(`/quizzes/daily`, {
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
      }
    } catch (error) {
      console.error("Error getting quiz status:", error);
    }
  };

  // funkcija koja završava kviz
  const finishQuiz = async () => {
    try {
      // format: YYYY-MM-DD, tako je na backendu
      // formatiramo datum kao YYYY-MM-DD
      const today = new Date();
      const quizDate = `${today.getFullYear()}-${String(today.getMonth() + 1).padStart(2, "0")}-${String(today.getDate()).padStart(2, "0")}`;

      // pretvaranje niza u string sa vrijednostima odvojenim zarezima
      const answersString = selectedAnswers.join(",");

      const requestBody = {
        quizDate: quizDate,
        answers: answersString,
      };

      const [data, status] = await apiCall(`/quizzes/finish`, {
        method: "POST",
        body: JSON.stringify(requestBody),
        headers: {
          "Content-Type": "application/json",
        },
      });

      if (status === 200) {
        setCompleted(true);
        setTimeLeft(0);

        // Očisti podatke iz localStorage-a
        if (typeof window !== "undefined") {
          localStorage.removeItem("selectedAnswers");
          localStorage.removeItem("startTime");
        }

        router.push("/quiz/finished");
      }
    } catch (error) {
      console.error("Error getting quiz status:", error);
    }
  };

  // na svaki refresh dohvatimo kviz, status kviza(zapocet, zavrsen) i samo postavimo trenutni datum
  useEffect(() => {
    getQuizStatus();

    if (!completed) {
      getDailyQuiz();
    }
  }, []);

  // efekt se pokreće prilikom prvog render-a
  useEffect(() => {
    // zapravo će se ovo obaviti prilikom prvog render-a
    if (!startTime) {
      const now = Date.now();
      setStartTime(now);
      if (typeof window !== "undefined") {
        localStorage.setItem("startTime", now.toString());
      }
      return;
    }

    // inače ako nije prvi render, računamo preostalo vrijeme
    const calculateRemainingTime = () => {
      const now = Date.now(); // u milisekundama
      const elapsedSeconds = Math.floor((now - startTime) / 1000); // zato dijelimo sa 1000 da dobijemo sekunde
      const remainingTime = 20 * 60 - elapsedSeconds;
      return remainingTime > 0 ? remainingTime : 0;
    };

    setTimeLeft(calculateRemainingTime());

    const timer = setInterval(() => {
      const remainingTime = calculateRemainingTime();
      setTimeLeft(remainingTime);

      if (remainingTime <= 0) {
        clearInterval(timer);
        finishQuiz();
      }
    }, 1000);

    return () => clearInterval(timer);
  }, [startTime, finishQuiz]);

  // u polje selectedAnswers stavlja index odgovora (0,1,2,3)
  // na poziciju u polju koja se odnosi na to pitanje
  const handleAnswerSelect = (answerIndex: number) => {
    const newAnswers = [...selectedAnswers];
    newAnswers[currentQuestionIndex] = answerIndex;
    setSelectedAnswers(newAnswers);

    // spremanje u localStorage
    if (typeof window !== "undefined") {
      localStorage.setItem("selectedAnswers", JSON.stringify(newAnswers));
    }
  };

  // funkcija koja nas vraca na prethodno pitanje
  const goToPreviousQuestion = () => {
    if (currentQuestionIndex > 0) {
      setCurrentQuestionIndex(currentQuestionIndex - 1);
    }
  };

  // funkcija koja odlazi na sljedeće pitanje, ako ne moze na sljedece onda zavrsi kviz
  const goToNextQuestion = () => {
    if (quizData && currentQuestionIndex < quizData.questions.length - 1) {
      setCurrentQuestionIndex(currentQuestionIndex + 1);
    } else {
      finishQuiz();
    }
  };

  // funkcija koja samo formatira vrijeme koje nam je preostalo
  const formatTime = (seconds: number) => {
    const mins = Math.floor(seconds / 60);
    const secs = seconds % 60;
    return `${mins.toString().padStart(2, "0")}:${secs.toString().padStart(2, "0")}`;
  };

  return (
    <div className="h-full flex flex-col items-center justify-center bg-blue-100 p-6 pb-40 md:pb-0">
      <div className="max-w-xl w-full bg-white rounded-xl shadow-lg overflow-hidden p-6">
        {/* Header s vremenom i brojem pitanja */}
        <div className="flex justify-between items-center mb-6">
          <div className="bg-blue-100 px-3 py-1 rounded-full">
            <span className="font-bold text-blue-700">
              {formatTime(timeLeft)}
            </span>
          </div>
          <div className="text-gray-600">
            Pitanje {currentQuestionIndex + 1}/{quizData?.questions.length}
          </div>
        </div>

        {/* Trenutno pitanje */}
        <h2 className="text-xl font-bold text-gray-800 mb-6">
          {quizData?.questions[currentQuestionIndex]?.text}
        </h2>

        {/* Ponuđeni odgovori */}
        <div className="space-y-3 mb-8">
          {quizData?.questions[currentQuestionIndex]?.options.map(
            (option, index) => (
              <button
                key={index}
                onClick={() => handleAnswerSelect(index)}
                className={`w-full text-left p-3 rounded-lg border-2 transition ${
                  selectedAnswers[currentQuestionIndex] === index
                    ? "bg-blue-100 border-blue-500 text-blue-700"
                    : "bg-gray-50 border-gray-200 hover:bg-gray-200"
                }`}
              >
                <span className="font-bold mr-2">
                  {String.fromCharCode(97 + index)}.
                </span>
                {option}
              </button>
            )
          )}
        </div>

        {/* Navigacijski gumbi */}
        <div className="flex justify-between">
          <button
            onClick={goToPreviousQuestion}
            disabled={currentQuestionIndex === 0}
            className={`px-4 py-2 rounded-lg ${
              currentQuestionIndex === 0
                ? "bg-gray-200 text-gray-500 cursor-not-allowed"
                : "bg-blue-100 text-blue-600 hover:bg-blue-200"
            }`}
          >
            Prethodno
          </button>

          <button
            onClick={goToNextQuestion}
            className="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700"
          >
            {quizData && currentQuestionIndex === quizData.questions.length - 1
              ? "Završi kviz"
              : "Sljedeće"}
          </button>
        </div>
      </div>
    </div>
  );
}
