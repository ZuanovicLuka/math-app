"use client";

import { useRouter } from "next/navigation";
import { useGetUser } from "~/queries/getUser";
import { useEffect, useState } from "react";
import {
  PencilIcon,
  CheckIcon,
  XMarkIcon,
  ArrowLeftOnRectangleIcon,
} from "@heroicons/react/24/outline";
import { apiCall } from "~/api";
import { z } from "zod";

const profileUpdateSchema = z.object({
  firstName: z
    .string()
    .min(2, "Ime mora imati barem 2 znaka!")
    .regex(/^[A-ZČĆŠĐŽ][a-zA-ZČĆŠĐŽčćšđž]*$/, "Neispravan format imena!"),
  lastName: z
    .string()
    .min(2, "Prezime mora imati barem 2 znaka!")
    .regex(/^[A-ZŠČĆĐŽ][a-zA-ZČĆŠĐŽčćšđž]*$/, "Neispravan format prezimena!"),
  username: z
    .string()
    .min(4, "Korisničko ime mora imati barem 4 znaka!")
    .regex(/^[a-zA-Z][a-zA-Z0-9._]*$/, "Neispravan format korisničkog imena!"),
  email: z.string().email("Neispravan email format!"),
});

export default function ProfilePage() {
  const router = useRouter();
  const userQuery = useGetUser();

  const initials =
    `${userQuery.data.user.firstName.charAt(0)}${userQuery.data.user.lastName.charAt(0)}`.toUpperCase();

  const [isEditing, setIsEditing] = useState(false);

  const [editData, setEditData] = useState({
    firstName: "",
    lastName: "",
    username: "",
    email: "",
  });

  const [errors, setErrors] = useState<any>({});

  // potrebne stvari za logout vezane uz aktivan kviz
  const [showLogoutModal, setShowLogoutModal] = useState(false);
  const [hasActiveQuiz, setHasActiveQuiz] = useState(false);

  // na svaki refresh se provjeri postoji li aktivan kviz
  useEffect(() => {
    const checkActiveQuiz = async () => {
      try {
        const [data, status] = await apiCall("/quizzes/status", {
          method: "GET",
        });

        if (status == 200) {
          setHasActiveQuiz(data.started && !data.completed); // ako je kviz započet i nije završen => true
        }
      } catch (error) {
        console.error("Error checking quiz status:", error);
      }
    };

    checkActiveQuiz();
  }, []);

  const handleImageUpload = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (!file) return;

    const formData = new FormData();
    formData.append("file", file);

    try {
      const dataPicture = await apiCall(`/users/update-profile-picture`, {
        method: "POST",
        body: formData,
      });

      userQuery.refetch();
    } catch (error) {
      console.error("Error updating avatar:", error);
    }
  };

  const handleEditClick = () => {
    if (userQuery.data?.user) {
      setEditData({
        firstName: userQuery.data.user.firstName,
        lastName: userQuery.data.user.lastName,
        username: userQuery.data.user.username,
        email: userQuery.data.user.email,
      });
    }
    setIsEditing(true);
  };

  const handleCancel = () => {
    setErrors({});
    setIsEditing(false);
  };

  const handleSave = async (e: any) => {
    e.preventDefault();

    try {
      profileUpdateSchema.parse(editData);
      setErrors({});

      // Priprema podataka za backend
      const updateData = {
        firstName: editData.firstName,
        lastName: editData.lastName,
        username: editData.username,
        email: editData.email,
      };

      // Slanje podataka na backend koristeći apiCall
      const [data, status] = await apiCall("/users/update-profile", {
        method: "PATCH",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(updateData),
      });

      if (status >= 400) {
        // ako je doslo do greske (username ili email postoje onda to ovdje obradimo)
        if (data.errors) {
          const backendErrors: any = {};

          if (data.errors.usernameError) {
            backendErrors.username = data.errors.usernameError;
          }

          if (data.errors.emailError) {
            backendErrors.email = data.errors.emailError;
          }

          setErrors(backendErrors);
        }
      } else {
        // dohvatimo updateanog user-a i izlazimo iz editiranja
        userQuery.refetch();
        setIsEditing(false);
      }
    } catch (error) {
      if (error instanceof z.ZodError) {
        const formattedErrors = error.errors.reduce((acc: any, curr) => {
          acc[curr.path[0]] = curr.message;
          return acc;
        }, {});
        setErrors(formattedErrors);
      } else {
        console.error("Došlo je do greške:", error);
      }
    }
  };

  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setEditData((prev) => ({ ...prev, [name]: value }));
  };

  if (userQuery.isLoading) {
    return (
      <div className="min-h-screen flex flex-col items-center justify-center">
        <div className="animate-pulse flex flex-col items-center">
          <div className="h-24 w-24 bg-gray-300 rounded-full mb-6"></div>
          <div className="h-8 w-32 bg-gray-300 rounded mb-6"></div>
          <div className="h-6 w-48 bg-gray-200 rounded mb-4"></div>
          <div className="h-10 w-32 bg-gray-400 rounded"></div>
        </div>
      </div>
    );
  }

  if (userQuery.isError || !userQuery.data) {
    return (
      <div className="min-h-screen flex flex-col items-center justify-center">
        <p className="text-red-500 text-lg mb-4">
          Došlo je do greške pri učitavanju profila
        </p>
        <button
          onClick={() => router.push("/")}
          className="bg-blue-500 hover:bg-blue-600 text-white font-semibold py-2 px-4 rounded-lg transition-colors"
        >
          Povratak na početnu
        </button>
      </div>
    );
  }

  const LogoutConfirmationModal = () => {
    const handleLogout = async () => {
      if (hasActiveQuiz) {
        try {
          // dohvati odgovore iz localStorage-a
          const savedAnswers = localStorage.getItem("selectedAnswers");
          const selectedAnswers = savedAnswers ? JSON.parse(savedAnswers) : [];

          // formatiramo datum kao YYYY-MM-DD
          const today = new Date();
          const quizDate = `${today.getFullYear()}-${String(today.getMonth() + 1).padStart(2, "0")}-${String(today.getDate()).padStart(2, "0")}`;
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
            // ako je kviz uspješno završen, nastavi s odjavom
            console.log(data);
            localStorage.clear();
            router.push("/");
          } else {
            console.error("Greška pri završetku kviza:", data);
            setShowLogoutModal(false);
          }
        } catch (error) {
          console.error("Greška pri završetku kviza:", error);
          setShowLogoutModal(false);
        }
      } else {
        // ako nema aktivnog kviza, samo odjavi korisnika
        localStorage.clear();
        router.push("/");
      }
    };

    return (
      <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
        <div className="bg-white rounded-xl p-6 max-w-md w-full">
          <h3 className="text-xl font-bold text-gray-800 mb-4">
            Potvrda odjave
          </h3>
          <div className="text-gray-600 mb-6">
            <p className="text-gray-700 mb-2">
              Jeste li sigurni da se želite odjaviti?
            </p>
            {hasActiveQuiz && (
              <p className="text-gray-700">
                Ako se odjavite sa započetim kvizom, bit će poslani odgovori
                koje ste zadnje riješili i više nećete moći pristupiti današnjem
                kvizu.
              </p>
            )}
          </div>
          <div className="flex space-x-4">
            <button
              onClick={handleLogout}
              className="flex-1 bg-red-500 hover:bg-red-600 text-white font-semibold py-2 px-4 rounded-lg transition-colors"
            >
              Da, odjavi me
            </button>
            <button
              onClick={() => setShowLogoutModal(false)}
              className="flex-1 bg-gray-500 hover:bg-gray-600 text-white font-semibold py-2 px-4 rounded-lg transition-colors"
            >
              Odustani
            </button>
          </div>
        </div>
      </div>
    );
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
    <div className="h-full flex flex-col items-center justify-center bg-blue-100 p-6 pb-40 md:pb-0">
      <div className="bg-white p-8 rounded-2xl shadow-xl w-full max-w-lg lg:max-w-xl">
        <div className="flex flex-col items-center mb-8">
          <div className="relative mb-3">
            {userQuery.data.user.profilePicture ? (
              <img
                src={userQuery.data.user.profilePicture}
                alt="Profilna slika"
                className="w-32 h-32 rounded-full object-cover shadow-md"
              />
            ) : (
              <div
                className="w-32 h-32 rounded-full flex items-center justify-center text-white text-4xl font-bold shadow-md"
                style={{
                  backgroundColor: getBackgroundColor(
                    userQuery.data.user.firstName,
                    userQuery.data.user.lastName
                  ),
                }}
              >
                {initials}
              </div>
            )}
            <label className="absolute bottom-0 right-0 bg-[#ffff] p-2 rounded-full shadow-md hover:bg-blue-100 transition-colors cursor-pointer">
              <PencilIcon className="h-5 w-5 text-blue-700" />
              <input
                type="file"
                accept="image/*"
                onChange={handleImageUpload}
                className="hidden"
                id="profileImageInput"
              />
            </label>
          </div>

          <h1 className="text-xl md:text-2xl lg:text-3xl font-bold text-center text-gray-600 mb-1">
            {userQuery.data.user.firstName} {userQuery.data.user.lastName}
          </h1>
          <p className="text-blue-700 font-medium text-md lg:text-lg">
            @{userQuery.data.user.username}
          </p>
        </div>

        <div className={`${isEditing ? "space-y-2" : "space-y-5"} mb-8`}>
          <div className="flex items-start justify-between">
            <span className="text-gray-600 font-medium w-32 lg:w-40 text-md lg:text-xl mt-1">
              Ime:
            </span>
            {isEditing ? (
              <div className="flex-1">
                <div className="flex flex-col">
                  <input
                    type="text"
                    name="firstName"
                    value={editData.firstName}
                    onChange={handleInputChange}
                    className={`p-2 border rounded-lg w-full focus:outline-none focus:ring-2 focus:ring-blue-700 ${errors["firstName"] ? "ring-2 ring-red-500" : "focus:ring-blue-700"} text-sm md:text-base`}
                  />
                  <div className="min-h-[20px]">
                    {errors["firstName"] && (
                      <p className="text-sm text-red-600 mt-1 font-semibold">
                        {errors["firstName"]}
                      </p>
                    )}
                  </div>
                </div>
              </div>
            ) : (
              <span className="text-gray-800 font-semibold flex-1 text-md lg:text-lg mt-1">
                {userQuery.data.user.firstName}
              </span>
            )}
          </div>

          <div className="flex items-start justify-between">
            <span className="text-gray-600 font-medium w-32 lg:w-40 text-md lg:text-xl mt-1">
              Prezime:
            </span>
            {isEditing ? (
              <div className="flex-1">
                <div className="flex flex-col">
                  <input
                    type="text"
                    name="lastName"
                    value={editData.lastName}
                    onChange={handleInputChange}
                    className={`p-2 border rounded-lg w-full focus:outline-none focus:ring-2 focus:ring-blue-700 ${errors["lastName"] ? "ring-2 ring-red-500" : "focus:ring-blue-700"} text-sm md:text-base`}
                  />
                  <div className="min-h-[20px]">
                    {errors["lastName"] && (
                      <p className="text-sm text-red-600 mt-1 font-semibold">
                        {errors["lastName"]}
                      </p>
                    )}
                  </div>
                </div>
              </div>
            ) : (
              <span className="text-gray-800 font-semibold flex-1 text-md lg:text-lg mt-1">
                {userQuery.data.user.lastName}
              </span>
            )}
          </div>

          <div className="flex items-start justify-between">
            <span className="text-gray-600 font-medium w-32 lg:w-40 text-md lg:text-xl mt-1">
              Korisničko ime:
            </span>
            {isEditing ? (
              <div className="flex-1">
                <div className="flex flex-col">
                  <input
                    type="text"
                    name="username"
                    value={editData.username}
                    onChange={handleInputChange}
                    className={`p-2 border rounded-lg w-full focus:outline-none focus:ring-2 focus:ring-blue-700 ${errors["username"] ? "ring-2 ring-red-500" : "focus:ring-blue-700"} text-sm md:text-base`}
                  />
                  <div className="min-h-[20px]">
                    {errors["username"] && (
                      <p className="text-sm text-red-600 mt-1 font-semibold">
                        {errors["username"]}
                      </p>
                    )}
                  </div>
                </div>
              </div>
            ) : (
              <span className="text-gray-800 font-semibold flex-1 text-md lg:text-lg mt-1">
                {userQuery.data.user.username}
              </span>
            )}
          </div>

          <div className="flex items-start justify-between">
            <span className="text-gray-600 font-medium w-32 lg:w-40 text-md lg:text-xl mt-1">
              Email:
            </span>
            {isEditing ? (
              <div className="flex-1">
                <div className="flex flex-col">
                  <input
                    type="email"
                    name="email"
                    value={editData.email}
                    onChange={handleInputChange}
                    className={`p-2 border rounded-lg w-full focus:outline-none focus:ring-2 focus:ring-blue-700 ${errors["email"] ? "ring-2 ring-red-500" : "focus:ring-blue-700"} text-sm md:text-base`}
                  />
                  <div className="min-h-[20px]">
                    {errors["email"] && (
                      <p className="text-sm text-red-600 mt-1 font-semibold">
                        {errors["email"]}
                      </p>
                    )}
                  </div>
                </div>
              </div>
            ) : (
              <span className="text-gray-800 font-semibold flex-1 text-md lg:text-lg mt-1">
                {userQuery.data.user.email}
              </span>
            )}
          </div>

          <div className="flex items-center justify-between">
            {isEditing ? (
              <></>
            ) : (
              <>
                <span className="text-gray-600 font-medium w-32 lg:w-40 text-md lg:text-xl">
                  Razina:
                </span>
                <span className="text-gray-800 font-semibold flex-1 text-md lg:text-lg">
                  {userQuery.data.user.schoolLevel}, {userQuery.data.user.grade}
                  . razred
                </span>
              </>
            )}
          </div>
        </div>

        <div className="flex space-x-4">
          {isEditing ? (
            <>
              <button
                onClick={handleSave}
                className="flex-1 bg-green-500 hover:bg-green-600 text-white font-semibold py-2 px-4 rounded-lg transition-colors flex items-center justify-center"
              >
                <CheckIcon className="h-5 w-5 mr-2" />
                Sačuvaj
              </button>
              <button
                onClick={handleCancel}
                className="flex-1 bg-gray-500 hover:bg-gray-600 text-white font-semibold py-2 px-4 rounded-lg transition-colors flex items-center justify-center"
              >
                <XMarkIcon className="h-5 w-5 mr-2" />
                Otkaži
              </button>
            </>
          ) : (
            <>
              <button
                onClick={handleEditClick}
                className="flex-1 bg-blue-700 hover:bg-blue-800 text-white font-semibold py-2 px-4 rounded-lg transition-colors flex items-center justify-center"
              >
                <PencilIcon className="h-5 w-5 mr-2" />
                Uredi profil
              </button>
              <button
                onClick={() => setShowLogoutModal(true)}
                className="flex-1 bg-red-500 hover:bg-red-600 text-white font-semibold py-2 px-4 rounded-lg transition-colors flex items-center justify-center"
              >
                <ArrowLeftOnRectangleIcon className="h-5 w-5 mr-2" />
                Odjavi se
              </button>
            </>
          )}
        </div>
      </div>
      {showLogoutModal && <LogoutConfirmationModal />}
    </div>
  );
}
