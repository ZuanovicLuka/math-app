"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import React from "react";
import { useGetUser } from "~/queries/getUser";
import { PiBooks, PiBooksFill } from "react-icons/pi";
import { MdQuestionMark } from "react-icons/md";
import { HiOutlineTrophy, HiTrophy } from "react-icons/hi2";
import { IoPersonOutline, IoPerson } from "react-icons/io5";

export default function AuthLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const userQuery = useGetUser();
  const pathname = usePathname();

  const isActive = (path: string) => {
    return pathname === path;
  };

  const isQuizActive = (pathname: string) => {
    return (
      pathname === "/quiz" ||
      pathname.startsWith("/quiz/start") ||
      pathname.startsWith("/quiz/finished")
    );
  };

  if (userQuery.isLoading) {
    return (
      <div className="flex flex-col gap-1 justify-center items-center bg-stone-100 min-h-screen text-gray-700">
        <div className="spinner-border border-2" role="status" />
        <h1>Loading...</h1>
      </div>
    );
  }

  if (userQuery.isError || !userQuery.data) {
    return (
      <div className="flex flex-col gap-1 justify-center items-center bg-stone-100 min-h-screen text-gray-700">
        <div className="spinner-border border-2" role="status" />
        <h1>Error...</h1>
      </div>
    );
  }

  return (
    <div className="flex min-h-screen bg-stone-200">
      <aside className="w-1/4 p-2 hidden md:block border-r border-gray-400">
        <nav className="h-full flex flex-col items-center gap-4">
          <img src="/images/logo.png" alt="Logo" className="mt-8 mb-8 w-40" />

          <div className="w-3/5">
            <Link
              href={"/lections"}
              className={`group flex flex-col items-center gap-3 p-1 rounded-xl transition-all ${
                isActive("/lections")
                  ? "bg-blue-100/80 shadow-md border border-blue-200"
                  : "hover:bg-gray-100"
              }`}
            >
              {isActive("/lections") ? (
                <>
                  <PiBooksFill size={55} className="text-blue-700" />
                  <p className="font-medium font-sans text-xl lg:text-2xl text-blue-700">
                    Lekcije
                  </p>
                </>
              ) : (
                <>
                  <PiBooks size={55} className="text-gray-600" />
                  <p className="font-medium font-sans text-xl lg:text-2xl text-gray-600">
                    Lekcije
                  </p>
                </>
              )}
            </Link>
          </div>

          <div className="w-3/5">
            <Link
              href={"/quiz"}
              className={`group flex flex-col items-center gap-3 p-1 rounded-xl transition-all ${
                isQuizActive(pathname)
                  ? "bg-blue-100/80 shadow-md border border-blue-200"
                  : "hover:bg-gray-100"
              }`}
            >
              {isQuizActive(pathname) ? (
                <>
                  <MdQuestionMark size={55} className="text-blue-700" />
                  <p className="font-medium font-sans text-xl lg:text-2xl text-blue-700">
                    Kviz
                  </p>
                </>
              ) : (
                <>
                  <MdQuestionMark size={55} className="text-gray-600" />
                  <p className="font-medium font-sans text-xl lg:text-2xl text-gray-600">
                    Kviz
                  </p>
                </>
              )}
            </Link>
          </div>

          <div className="w-3/5">
            <Link
              href={"/rank"}
              className={`group flex flex-col items-center gap-3 p-1 rounded-xl transition-all ${
                isActive("/rank")
                  ? "bg-blue-100/80 shadow-md border border-blue-200"
                  : "hover:bg-gray-100"
              }`}
            >
              {isActive("/rank") ? (
                <>
                  <HiTrophy size={55} className="text-blue-700" />
                  <p className="font-medium font-sans text-xl lg:text-2xl text-blue-700">
                    Rang-lista
                  </p>
                </>
              ) : (
                <>
                  <HiOutlineTrophy size={55} className="text-gray-600" />
                  <p className="font-medium font-sans text-xl lg:text-2xl text-gray-600">
                    Rang-lista
                  </p>
                </>
              )}
            </Link>
          </div>

          <div className="w-3/5">
            <Link
              href={"/profile"}
              className={`group flex flex-col items-center gap-3 p-1 rounded-xl transition-all ${
                isActive("/profile")
                  ? "bg-blue-100/80 shadow-md border border-blue-200"
                  : "hover:bg-gray-100"
              }`}
            >
              {isActive("/profile") ? (
                <>
                  <IoPerson size={55} className="text-blue-700" />
                  <p className="font-medium font-sans text-xl lg:text-2xl text-blue-700">
                    Profil
                  </p>
                </>
              ) : (
                <>
                  <IoPersonOutline size={55} className="text-gray-600" />
                  <p className="font-medium font-sans text-xl lg:text-2xl text-gray-600">
                    Profil
                  </p>
                </>
              )}
            </Link>
          </div>
        </nav>
      </aside>

      <nav className="md:hidden w-full z-30 fixed bottom-0 flex justify-around items-center h-24 bg-stone-200 border-t border-gray-400">
        <Link
          href={"/lections"}
          className={`flex flex-col items-center justify-center rounded-lg transition-all py-2 w-24 ${
            isActive("/lections") ? "bg-blue-200" : "hover:bg-gray-100"
          }`}
        >
          {isActive("/lections") ? (
            <PiBooksFill size={38} className="text-blue-700" />
          ) : (
            <PiBooks size={38} className="text-gray-600" />
          )}
          <p
            className={`mt-1 font-medium font-sans ${
              isActive("/lections") ? "text-blue-700" : "text-gray-600"
            }`}
          >
            Lekcije
          </p>
        </Link>

        <Link
          href={"/quiz"}
          className={`flex flex-col items-center justify-center rounded-lg transition-all py-2 w-24 ${
            isQuizActive(pathname) ? "bg-blue-100/80" : "hover:bg-gray-100"
          }`}
        >
          {isQuizActive(pathname) ? (
            <MdQuestionMark size={38} className="text-blue-700" />
          ) : (
            <MdQuestionMark size={38} className="text-gray-600" />
          )}
          <p
            className={`mt-1 font-medium font-sans ${
              isQuizActive(pathname) ? "text-blue-700" : "text-gray-600"
            }`}
          >
            Kviz
          </p>
        </Link>

        <Link
          href={"/rank"}
          className={`flex flex-col items-center justify-center rounded-lg transition-all py-2 w-24 ${
            isActive("/rank") ? "bg-blue-100/80" : "hover:bg-gray-100"
          }`}
        >
          {isActive("/rank") ? (
            <HiTrophy size={38} className="text-blue-700" />
          ) : (
            <HiOutlineTrophy size={38} className="text-gray-600" />
          )}
          <p
            className={`mt-1 font-medium font-sans ${
              isActive("/rank") ? "text-blue-700" : "text-gray-600"
            }`}
          >
            Rang-lista
          </p>
        </Link>

        <Link
          href={"/profile"}
          className={`flex flex-col items-center justify-center rounded-lg transition-all py-2 w-24 ${
            isActive("/profile") ? "bg-blue-100/80" : "hover:bg-gray-100"
          }`}
        >
          {isActive("/profile") ? (
            <IoPerson size={38} className="text-blue-700" />
          ) : (
            <IoPersonOutline size={38} className="text-gray-600" />
          )}
          <p
            className={`mt-1 font-medium font-sans ${
              isActive("/profile") ? "text-blue-700" : "text-gray-600"
            }`}
          >
            Profil
          </p>
        </Link>
      </nav>

      <main className="w-full md:w-3/4 flex flex-col">
        <div className="flex-grow overflow-auto">{children}</div>
      </main>
    </div>
  );
}
