"use client";

import { useRouter } from "next/navigation";

export default function Rank() {
  const router = useRouter();

  return (
    <div className="min-h-screen flex flex-col items-center justify-center bg-white">
      <p className="text-2xl font-bold mb-6">Rank...</p>
      <button
        onClick={() => {
          router.push("/profile");
        }}
        className="bg-red-500 hover:bg-red-600 text-white font-semibold py-2 px-4 rounded-lg transition-colors"
      >
        Otidi na profil
      </button>
    </div>
  );
}
