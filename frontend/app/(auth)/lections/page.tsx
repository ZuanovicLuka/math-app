"use client";

import { useRouter } from "next/navigation";

export default function Lections() {
  const router = useRouter();

  return (
    <div className="h-full flex flex-col items-center justify-center bg-blue-100 p-6 pb-40 md:pb-0">
      <p className="text-2xl font-bold mb-6">Lections...</p>
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
