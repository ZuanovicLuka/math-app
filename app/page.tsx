"use client";

import Logo from "./components/Logo";
import { useEffect } from "react";
import { redirect } from "next/navigation";

export default function Home() {
  useEffect(() => {
    const token = localStorage.getItem("token");
    if (token) {
      redirect("/home");
    }
  }, []);

  return (
    <div
      className="min-h-screen flex"
      style={{
        background:
          "linear-gradient(to right, #0a42e0 2%, #3661da 10%, #3b82f6 30%, #60a5fa 40%, #93c5fd 50%, #bfdbfe 60%, #dbeafe 70%, #ffffff 90%)",
      }}
    >
      {/* Left Section with Logo and Blue Background transitioning to White */}
      <div className="flex-1 flex items-center justify-center">
        <Logo />
      </div>

      {/* Right Section with White Background */}
      <div className="flex-1 flex items-center justify-center text-center">
        <div>
          <h2 className="text-4xl font-bold mb-5">Kreiraj račun</h2>
          <p className="text-xl mb-3">Already have an account?</p>
          <button className="bg-blue-500 text-white py-2 px-4 rounded-full hover:bg-blue-600 transition-colors">
            Ulogiraj se
          </button>
        </div>
      </div>
    </div>
  );
}
