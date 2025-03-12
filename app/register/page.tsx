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

  const handleRegister = () => {
    if (firstName && lastName && username && email && password) {
      alert("Registracija uspješna!");
      router.push("/login");
    } else {
      alert("Molimo unesite sve podatke");
    }
  };

  return (
    <div
      className="min-h-screen flex flex-col items-center justify-center"
      style={{
        background:
          "linear-gradient(to right, #0a42e0 2%, #3661da 10%, #3b82f6 30%, #60a5fa 40%, #93c5fd 50%, #bfdbfe 60%, #dbeafe 70%, #ffffff 90%)",
      }}
    >
      <div className="bg-white p-6 rounded-2xl shadow-gray-900 shadow-2xl w-1/3">
        <h2 className="text-3xl font-bold mb-4 text-center">Registracija</h2>
        <div className="mb-4">
          <input
            type="text"
            placeholder="Ime"
            className="w-full p-3 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
            value={firstName}
            onChange={(e) => setFirstName(e.target.value)}
          />
        </div>
        <div className="mb-4">
          <input
            type="text"
            placeholder="Prezime"
            className="w-full p-3 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
            value={lastName}
            onChange={(e) => setLastName(e.target.value)}
          />
        </div>
        <div className="mb-4">
          <input
            type="text"
            placeholder="Korisničko ime"
            className="w-full p-3 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
            value={username}
            onChange={(e) => setUsername(e.target.value)}
          />
        </div>
        <div className="mb-4">
          <input
            type="email"
            placeholder="Email"
            className="w-full p-3 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
          />
        </div>
        <div className="mb-4">
          <input
            type="password"
            placeholder="Lozinka"
            className="w-full p-3 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
          />
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
