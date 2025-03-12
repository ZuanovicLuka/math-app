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
  const [schoolLevel, setSchoolLevel] = useState(""); // Ensure the correct state name

  const handleRegister = () => {
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
      <div className="bg-white p-6 rounded-2xl shadow-gray-900 shadow-2xl w-1/3">
        <h2 className="text-3xl font-bold mb-4 text-center text-textColor">
          Registracija
        </h2>
        <div className="mb-3">
          <input
            type="text"
            placeholder="Ime"
            className="w-full p-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
            value={firstName}
            onChange={(e) => setFirstName(e.target.value)}
            maxLength={20}
            required
          />
        </div>
        <div className="mb-3">
          <input
            type="text"
            placeholder="Prezime"
            className="w-full p-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
            value={lastName}
            onChange={(e) => setLastName(e.target.value)}
            maxLength={20}
            required
          />
        </div>
        <div className="mb-3">
          <input
            type="text"
            placeholder="Korisničko ime"
            className="w-full p-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
            value={username}
            onChange={(e) => setUsername(e.target.value)}
            maxLength={30}
            required
          />
        </div>
        <div className="mb-3">
          <input
            type="email"
            placeholder="Email"
            className="w-full p-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            maxLength={50}
            required
          />
        </div>
        <div className="mb-3">
          <input
            type="password"
            placeholder="Lozinka"
            className="w-full p-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            maxLength={20}
            required
          />
        </div>

        <div className="mb-4 text-center">
          <p className="text-lg text-textColor">
            Odaberite razinu svojeg obrazovanja:
          </p>
        </div>

        <div className="flex justify-center gap-2 mb-4">
          <label className="hover:cursor-pointer has-[:checked]:bg-[#1f3088] has-[:checked]:text-gray-100 bg-[#ffff] border-1 border-gray-400 rounded-md  w-50 h-9 flex justify-center items-center text-textColor">
            <input
              type="radio"
              className="opacity-0 absolute"
              onChange={() => setSchoolLevel("Osnovna škola")}
              name="schoolLevel"
              checked={schoolLevel === "Osnovna škola"}
              required
            />
            Osnovna škola
          </label>

          <label className="hover:cursor-pointer has-[:checked]:bg-[#1f3088] has-[:checked]:text-gray-100 bg-[#ffff] border-1 border-gray-400 rounded-md  w-50 h-9 flex justify-center items-center text-textColor">
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
          className="bg-blue-500 text-white w-full py-3 rounded-lg hover:bg-blue-600 transition-colors"
          onClick={handleRegister}
        >
          Registriraj se
        </button>
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
