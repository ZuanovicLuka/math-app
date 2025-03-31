"use client";

import { useRouter } from "next/navigation";
import { useGetUser } from "~/queries/getUser";

export default function ProfilePage() {
  const router = useRouter();
  const { data, isLoading, isError } = useGetUser();

  if (isLoading) {
    return (
      <div className="min-h-screen flex flex-col items-center justify-center">
        <div className="animate-pulse flex flex-col items-center">
          <div className="h-8 w-32 bg-gray-300 rounded mb-6"></div>
          <div className="h-6 w-48 bg-gray-200 rounded mb-4"></div>
          <div className="h-10 w-32 bg-gray-400 rounded"></div>
        </div>
      </div>
    );
  }

  if (isError || !data) {
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

  return (
    <div className="min-h-screen flex flex-col items-center justify-center bg-white p-6">
      <div className="bg-white p-8 rounded-xl shadow-md w-full max-w-md">
        <h1 className="text-3xl font-bold text-center text-gray-800 mb-8">
          Moj Profil
        </h1>

        <div className="space-y-4 mb-8">
          <div className="flex items-center">
            <span className="text-gray-600 font-medium w-32">Ime:</span>
            <span className="text-gray-800 font-semibold">
              {data.user.firstName}
            </span>
          </div>

          <div className="flex items-center">
            <span className="text-gray-600 font-medium w-32">Prezime:</span>
            <span className="text-gray-800 font-semibold">
              {data.user.lastName}
            </span>
          </div>

          <div className="flex items-center">
            <span className="text-gray-600 font-medium w-32">
              Korisničko ime:
            </span>
            <span className="text-gray-800 font-semibold">
              {data.user.username}
            </span>
          </div>

          <div className="flex items-center">
            <span className="text-gray-600 font-medium w-32">Email:</span>
            <span className="text-gray-800 font-semibold">
              {data.user.email}
            </span>
          </div>

          <div className="flex items-center">
            <span className="text-gray-600 font-medium w-32">Razred:</span>
            <span className="text-gray-800 font-semibold">
              {data.user.schoolLevel}
            </span>
          </div>
        </div>

        <button
          onClick={() => {
            localStorage.clear();
            router.push("/");
          }}
          className="w-full bg-red-500 hover:bg-red-600 text-white font-semibold py-2 px-4 rounded-lg transition-colors"
        >
          Odjavi se
        </button>
      </div>
    </div>
  );
}
