"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";

export default function Register() {
  const router = useRouter();

  const [firstName, setFirstName] = useState("");
  const [lastName, setLastName] = useState("");
  const [username, setUsername] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [schoolLevel, setSchoolLevel] = useState("");

  const handleSubmit = (e: { preventDefault: () => void }) => {
    e.preventDefault();
    if (firstName && lastName && username && email && password && schoolLevel) {
      alert("Registracija uspješna!");
      router.push("/login");
    } else {
      alert("Molimo unesite sve podatke");
    }
  };

  return (
    <div
      className="min-h-screen flex flex-col items-center justify-center relative"
      style={{
        background:
          "linear-gradient(to right, #0a42e0 2%, #3661da 10%, #3b82f6 30%, #60a5fa 40%, #93c5fd 50%, #bfdbfe 60%, #dbeafe 70%, #ffffff 90%)",
      }}
    >
      <div className="absolute top-4 left-4 w-[8rem]">
        <img src="/images/logo.png" className="w-full" />
      </div>
      <div className="bg-white p-6 rounded-2xl shadow-gray-900 shadow-2xl md:w-3/5 lg:w-2/5 mt-5">
        <h2 className="text-2xl md:text-3xl font-bold mb-4 text-center text-textColor">
          Registracija
        </h2>
        <form onSubmit={handleSubmit}>
          <div className="grid grid-cols-2 gap-4 mb-4">
            <input
              type="text"
              placeholder="Ime"
              className="p-2 border rounded-lg w-full focus:outline-none focus:ring-2 focus:ring-blue-500 text-sm md:text-base"
              value={firstName}
              onChange={(e) => setFirstName(e.target.value)}
              maxLength={20}
              required
            />
            <input
              type="text"
              placeholder="Prezime"
              className="p-2 border rounded-lg w-full focus:outline-none focus:ring-2 focus:ring-blue-500 text-sm md:text-base"
              value={lastName}
              onChange={(e) => setLastName(e.target.value)}
              maxLength={20}
              required
            />
            <input
              type="text"
              placeholder="Korisničko ime"
              className="p-2 border rounded-lg w-full focus:outline-none focus:ring-2 focus:ring-blue-500 text-sm md:text-base"
              value={username}
              onChange={(e) => setUsername(e.target.value)}
              maxLength={30}
              required
            />
            <input
              type="text"
              placeholder="Email"
              className="p-2 border rounded-lg w-full focus:outline-none focus:ring-2 focus:ring-blue-500 text-sm md:text-base"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              maxLength={50}
              required
            />
            <input
              type="password"
              placeholder="Lozinka"
              className="p-2 border rounded-lg w-full focus:outline-none focus:ring-2 focus:ring-blue-500 text-sm md:text-base"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              maxLength={20}
              required
            />
          </div>
          <div className="mb-4 text-center">
            <p className="text-base md:text-lg text-textColor">
              Odaberite razinu svojeg obrazovanja:
            </p>
          </div>
          <div className="flex justify-center gap-2 mb-4">
            <label className="text-sm md:text-base hover:cursor-pointer has-[:checked]:bg-[#1f3088] has-[:checked]:text-gray-100 bg-[#ffff] border-1 border-gray-400 rounded-md w-50 h-9 flex justify-center items-center text-textColor">
              <input
                type="radio"
                className="opacity-0 absolute "
                onChange={() => setSchoolLevel("Osnovna škola")}
                name="schoolLevel"
                checked={schoolLevel === "Osnovna škola"}
                required
              />
              Osnovna škola
            </label>
            <label className="text-sm md:text-base hover:cursor-pointer has-[:checked]:bg-[#1f3088] has-[:checked]:text-gray-100 bg-[#ffff] border-1 border-gray-400 rounded-md w-50 h-9 flex justify-center items-center text-textColor">
              <input
                type="radio"
                className="opacity-0 absolute"
                onChange={() => setSchoolLevel("Srednja škola")}
                name="schoolLevel"
                checked={schoolLevel === "Srednja škola"}
                required
              />
              Srednja škola
            </label>
          </div>
          <button
            type="submit"
            className="bg-blue-500 text-white w-full py-3 rounded-lg hover:bg-blue-600 transition-colors text-sm md:text-base"
          >
            Registriraj se
          </button>
        </form>
        <div className="mt-4 flex justify-center items-center text-gray-600">
          <p className="mr-2">Već imate račun?</p>
          <button
            className="text-blue-500 hover:underline"
            onClick={() => router.push("/")}
          >
            Prijavi se
          </button>
        </div>
      </div>
    </div>
  );
}
