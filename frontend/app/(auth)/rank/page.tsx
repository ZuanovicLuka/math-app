"use client";

import { useRouter } from "next/navigation";
import { useEffect, useState } from "react";
import { apiCall } from "~/api";
import { format } from "date-fns";
import { useGetUser } from "~/queries/getUser";
import React from "react";

interface Player {
  position: number;
  user: {
    userId: string;
    username: string;
    firstName: string;
    lastName: string;
    profilePicture?: string;
    initials: string;
  };
  score: number;
  timeTakenSeconds: number;
  endTime: string;
}

export default function Rank() {
  const router = useRouter();
  const userQuery = useGetUser();
  const [players, setPlayers] = useState<Player[]>([]);
  const [loading, setLoading] = useState(false);
  const [date, setDate] = useState(new Date());

  // ovo sluzi da pratimo je li osoba zapocela kviz i je li ga zavrsila (za footer)
  const [started, setStarted] = useState(false);
  const [completed, setCompleted] = useState(false);
  const [userRank, setUserRank] = useState<Player | null>(null); // sluzi ako nisi u top 50

  const fetchTopUsers = async (selectedDate: Date) => {
    try {
      const formattedDate = format(selectedDate, "yyyy-MM-dd");
      const [data, status] = await apiCall(
        `/rank/top-users?date=${formattedDate}`,
        {
          method: "GET",
        }
      );
      console.log(data);

      if (status === 200) {
        const transformedPlayers = data.data.map((player: any) => ({
          position: player.position,
          user: {
            userId: player.userId,
            username: player.username,
            firstName: player.firstName,
            lastName: player.lastName,
            profilePicture: player.profilePicture,
            initials:
              `${player.firstName.charAt(0)}${player.lastName.charAt(0)}`.toUpperCase(),
          },
          score: player.score,
          timeTakenSeconds: player.timeTakenSeconds,
          endTime: player.endTime,
        }));

        setPlayers(transformedPlayers);
      }
    } catch (err) {
      console.error("Error fetching leaderboard:", err);
    }
  };

  const getQuizStatus = async () => {
    try {
      const data = await apiCall(`/quizzes/status`, {
        method: "GET",
      });

      if (data[1] == 200) {
        setStarted(data[0].started);
        setCompleted(data[0].completed);
      }
    } catch (error) {
      console.error("Error getting quiz status:", error);
    }
  };

  const fetchUserRank = async (selectedDate: Date) => {
    try {
      const formattedDate = format(selectedDate, "yyyy-MM-dd");
      const [data, status] = await apiCall(
        `/rank/user-rank?date=${formattedDate}`,
        {
          method: "GET",
        }
      );

      if (status === 200 && data.data) {
        const transformedPlayer = {
          position: data.data.position,
          user: {
            userId: data.data.userId,
            username: data.data.username,
            firstName: data.data.firstName,
            lastName: data.data.lastName,
            profilePicture: data.data.profilePicture,
            initials:
              `${data.data.firstName.charAt(0)}${data.data.lastName.charAt(0)}`.toUpperCase(),
          },
          score: data.data.score,
          timeTakenSeconds: data.data.timeTakenSeconds,
          endTime: data.data.endTime,
        };
        setUserRank(transformedPlayer);
      }
    } catch (err) {
      console.error("Error fetching user rank:", err);
    }
  };

  const fetchData = async () => {
    setLoading(true);
    try {
      await Promise.all([getQuizStatus(), fetchTopUsers(date)]);
      if (completed) {
        await fetchUserRank(date);
      }
    } catch (error) {
      console.error("Error fetching data:", error);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchData();
  }, [date]);

  useEffect(() => {
    if (completed) {
      fetchUserRank(date);
    }
  }, [completed, date]);

  const getMedal = (rank: number) => {
    switch (rank) {
      case 1:
        return "🥇";
      case 2:
        return "🥈";
      case 3:
        return "🥉";
      default:
        return rank;
    }
  };

  const formatTime = (seconds: number) => {
    const mins = Math.floor(seconds / 60);
    const secs = seconds % 60;
    return `${mins}:${secs < 10 ? "0" : ""}${secs}`;
  };

  const getBackgroundColor = (firstName: string, lastName: string) => {
    const fullName = `${firstName}${lastName}`;
    let hash = 0;
    for (let i = 0; i < fullName.length; i++) {
      hash = fullName.charCodeAt(i) + ((hash << 5) - hash);
    }
    const hue = Math.abs(hash) % 360;
    return `hsl(${hue}, 70%, 50%)`;
  };

  return (
    <div className="h-full bg-blue-100 p-6 pb-40 md:pb-6">
      <div className="max-w-4xl mx-auto flex flex-col">
        <div className="bg-white rounded-xl shadow-xl flex flex-col overflow-hidden">
          {/*HEADER*/}
          <div className="bg-blue-700 p-3 text-white rounded-lg shadow-lg">
            <div className="max-w-3xl mx-auto">
              <h1 className="text-3xl font-bold text-center mb-2">
                Dnevna Rang Lista
              </h1>

              <div className="text-center mb-2">
                <p className="text-blue-100 italic">
                  "Poredak 20 najboljih učenika na današnjem kvizu"
                </p>
              </div>

              <div className="bg-blue-600 p-4 rounded-md">
                <p className="text-center text-blue-50 font-medium">
                  Kriteriji rangiranja:
                  <br />
                  <span className="text-yellow-200">
                    1. Točnost odgovora (broj bodova)
                  </span>
                  <br />
                  <span className="text-yellow-200">
                    2. Brzina rješavanja (kraće vrijeme = bolji rang)
                  </span>
                  <br />
                  <span className="text-yellow-200">
                    3. Rangiranje se vrši unutar istog razreda (
                    {userQuery.data.user.schoolLevel} -{" "}
                    {userQuery.data.user.grade}. razred)
                  </span>
                  <br />
                  <span className="text-yellow-200">
                    **U slučaju istog broja bodova i vremena, korisnici dijele
                    mjesto**
                  </span>
                </p>
              </div>

              <div className="flex justify-between items-center mt-2 text-base">
                <div className="text-blue-200 font-medium">
                  <p>
                    {userQuery.data.user.schoolLevel} -{" "}
                    {userQuery.data.user.grade}. razred
                  </p>
                </div>
                <div className="text-blue-100 font-medium">
                  <p>
                    {date.toLocaleDateString("hr-HR", {
                      day: "numeric",
                      month: "long",
                      year: "numeric",
                    })}
                  </p>
                </div>
              </div>
            </div>
          </div>

          {loading ? (
            <div className="flex flex-col items-center justify-center h-96">
              <div className="w-12 h-12 border-4 border-blue-500 border-t-transparent rounded-full animate-spin mb-4"></div>
              <p className="text-center text-gray-700">Loading...</p>
            </div>
          ) : (
            <>
              {/*SREDNJI DIO*/}
              <div
                className={`p-6 ${
                  players.length === 0
                    ? "h-56"
                    : players.length <= 3
                      ? "h-70"
                      : "h-[33.5rem]"
                } overflow-y-auto scrollbar-thin scrollbar-thumb-blue-500 scrollbar-track-white`}
              >
                {players.length === 0 ? (
                  <div className="text-center py-10">
                    <p className="text-gray-700 text-lg">
                      Nema rezultata za prikaz
                    </p>
                    <button
                      onClick={() => fetchData()}
                      className="mt-4 px-4 py-2 bg-blue-100 text-blue-700 rounded hover:bg-blue-200"
                    >
                      Pokušaj ponovno
                    </button>
                  </div>
                ) : (
                  <div className="space-y-4">
                    {players.map((player, index, array) => {
                      const isLastThirdPlace =
                        player.position === 3 &&
                        (index === array.length - 1 ||
                          array[index + 1].position > 3);

                      return (
                        <React.Fragment key={player.user.userId}>
                          <div
                            id={
                              player.user.userId ===
                              userQuery.data?.user?.userId
                                ? "user-rank-section"
                                : undefined
                            }
                            className={`flex items-center px-3 py-4 rounded-lg ${
                              player.position === 1
                                ? "bg-gradient-to-r from-yellow-200 to-yellow-100 border-2 border-yellow-400"
                                : player.position === 2
                                  ? "bg-gradient-to-r from-gray-200 to-gray-50 border-2 border-gray-400"
                                  : player.position === 3
                                    ? "bg-gradient-to-r from-amber-200 to-amber-100 border-2 border-amber-500"
                                    : "flex items-center p-3 rounded-lg hover:bg-gray-50"
                            }`}
                          >
                            <div
                              className={`${player.position <= 3 ? "text-3xl font-bold w-12 text-center" : "w-12 text-center text-gray-500 text-lg"}`}
                            >
                              {player.position <= 3
                                ? getMedal(player.position)
                                : `${player.position}.`}
                            </div>
                            <div className="flex-shrink-0 ml-4">
                              {player.user.profilePicture ? (
                                <img
                                  src={player.user.profilePicture}
                                  alt={player.user.username}
                                  className="w-16 h-16 rounded-full object-cover border-3 border-gray-700 shadow-md"
                                />
                              ) : (
                                <div
                                  className="w-16 h-16 rounded-full flex text-lg items-center justify-center text-white font-bold shadow-md border-3 border-gray-700"
                                  style={{
                                    backgroundColor: getBackgroundColor(
                                      player.user.firstName,
                                      player.user.lastName
                                    ),
                                  }}
                                >
                                  {player.user.initials}
                                </div>
                              )}
                            </div>
                            <div className="ml-4 flex-grow">
                              <h3
                                className={`text-lg text-gray-700 ${player.position <= 3 ? "font-bold" : ""}`}
                              >
                                {player.user.username}
                                {player.user.username ===
                                  userQuery.data?.user?.username && (
                                  <span className="ml-4 px-3 py-1 bg-red-700 text-white text-xs font-medium rounded-full">
                                    Vi
                                  </span>
                                )}
                              </h3>
                              <div className="flex justify-between text-sm text-gray-700">
                                <span>
                                  Rezultat: <strong>{player.score} / 20</strong>
                                </span>
                                <span>
                                  Vrijeme:{" "}
                                  <strong>
                                    {formatTime(player.timeTakenSeconds)}
                                  </strong>
                                </span>
                              </div>
                            </div>
                          </div>

                          {isLastThirdPlace && index !== array.length - 1 && (
                            <div className="border-t-2 border-gray-300 pt-2"></div>
                          )}
                        </React.Fragment>
                      );
                    })}

                    {/* ako nisi u top 50 */}
                    {userRank &&
                      !players.some(
                        (p) => p.user.userId === userRank.user.userId
                      ) && (
                        <div className="mt-8 border-t-2 pt-6">
                          <h3 className="text-xl font-bold text-center mb-4">
                            Vaš rezultat
                          </h3>
                          <div
                            id="user-rank-section"
                            className="flex items-center p-3 rounded-lg bg-blue-50"
                          >
                            <div className="w-12 text-center text-gray-700 text-lg font-bold">
                              {userRank.position}.
                            </div>
                            <div className="flex-shrink-0 ml-2">
                              {userRank.user.profilePicture ? (
                                <img
                                  src={userRank.user.profilePicture}
                                  alt={userRank.user.username}
                                  className="w-16 h-16 rounded-full object-cover border-3 border-gray-700 shadow-md"
                                />
                              ) : (
                                <div
                                  className="w-16 h-16 rounded-full flex text-lg items-center justify-center text-white font-bold shadow-md border-3 border-gray-700"
                                  style={{
                                    backgroundColor: getBackgroundColor(
                                      userRank.user.firstName,
                                      userRank.user.lastName
                                    ),
                                  }}
                                >
                                  {userRank.user.initials}
                                </div>
                              )}
                            </div>
                            <div className="ml-3 flex-grow">
                              <h3 className="text-lg text-gray-700 font-semibold">
                                {userRank.user.username}
                                <span className="ml-4 px-3 py-1 bg-red-700 text-white text-xs font-medium rounded-full">
                                  Vi
                                </span>
                              </h3>
                              <div className="flex justify-between text-sm text-gray-700">
                                <span>
                                  Rezultat:{" "}
                                  <strong>{userRank.score} / 20</strong>
                                </span>
                                <span>
                                  Vrijeme:{" "}
                                  <strong>
                                    {formatTime(userRank.timeTakenSeconds)}
                                  </strong>
                                </span>
                              </div>
                            </div>
                          </div>
                        </div>
                      )}
                  </div>
                )}
              </div>

              {/*FOOTER*/}
              <div className="bg-gray-50 p-6 text-center border-t">
                {completed ? (
                  <>
                    <h3 className="text-lg font-semibold text-gray-800">
                      Već ste završili današnji kviz!
                    </h3>
                    {(userRank ||
                      players.some(
                        (p) => p.user.userId === userQuery.data?.user?.userId
                      )) && (
                      <button
                        onClick={() => {
                          const element =
                            document.getElementById("user-rank-section");
                          if (element) {
                            element.scrollIntoView({
                              behavior: "smooth",
                            });

                            element.classList.add(
                              "transition-all",
                              "duration-1000",
                              "bg-blue-100",
                              "border-blue-200",
                              "border-2"
                            );

                            setTimeout(() => {
                              element.classList.add(
                                "bg-blue-200",
                                "border-blue-300"
                              );
                            }, 500);

                            setTimeout(() => {
                              element.classList.remove(
                                "bg-blue-100",
                                "bg-blue-200",
                                "border-blue-300",
                                "border-blue-200",
                                "border-2"
                              );
                            }, 2000);
                          }
                        }}
                        className="text-blue-600 hover:text-blue-800 underline font-medium"
                      >
                        Prikaži moj rezultat na rang listi.
                      </button>
                    )}
                  </>
                ) : started ? (
                  <>
                    <h3 className="text-lg font-semibold text-gray-800">
                      Nastavite svoj kviz!
                    </h3>
                    <p className="text-gray-600 mt-1 mb-4">
                      Imate započet kviz koji možete nastaviti.
                    </p>
                    <button
                      onClick={() => router.push("/quiz")}
                      className="px-6 py-[0.6rem] bg-blue-700 text-white font-medium rounded-lg shadow-md hover:bg-blue-900"
                    >
                      Nastavi Kviz
                    </button>
                  </>
                ) : (
                  <>
                    <h3 className="text-lg font-semibold text-gray-800">
                      Želiš li se i ti natjecati?
                    </h3>
                    <p className="text-gray-600 mt-1 mb-4">
                      Pridruži se dnevnom kvizu i probaj dostići vrh!
                    </p>
                    <button
                      onClick={() => router.push("/quiz")}
                      className="px-6 py-[0.6rem] bg-blue-700 text-white font-medium rounded-lg shadow-md hover:bg-blue-900"
                    >
                      Igraj Kviz Sada
                    </button>
                  </>
                )}
              </div>
            </>
          )}
        </div>
      </div>
    </div>
  );
}
