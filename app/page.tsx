"use client";

import Logo from "./components/Logo";
import CircleWithContent from "./components/CircleWithContent";
import { GiPodium } from "react-icons/gi";
import { TiTickOutline } from "react-icons/ti";
import { useEffect, useState, useRef, FormEvent } from "react";
import { useRouter } from "next/navigation";
import { motion } from "framer-motion";
import Image from "next/image";
import { Typewriter } from "react-simple-typewriter";
import { useInView } from "framer-motion";

export default function Home() {
  const router = useRouter();
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [serverErrorMessage, setServerErrorMessage] = useState("");

  const typingRef = useRef(null);
  const typingRefAbout = useRef(null);
  const typingRefContact = useRef(null);

  const isTypingVisible = useInView(typingRef, { once: true });
  const isTypingVisibleAbout = useInView(typingRefAbout, { once: true });
  const isTypingVisibleContact = useInView(typingRefContact, { once: true });

  useEffect(() => {
    const token = localStorage.getItem("token");
    if (token) {
      router.push("/home");
    }
  }, []);

  // ovu funkciju jos treba zavrsiti (radi login)
  function handleSubmit(event: FormEvent<HTMLFormElement>): void {
    console.log(username);
    console.log(password);
    throw new Error("Function not implemented.");
  }

  return (
    <div className="min-h-screen flex flex-col items-center">
      <div
        className="w-full md:flex min-h-screen"
        style={{
          background:
            "linear-gradient(to right, #0a42e0 2%, #3661da 10%, #3b82f6 30%, #60a5fa 40%, #93c5fd 50%, #bfdbfe 60%, #dbeafe 70%, #ffffff 90%)",
        }}
      >
        <div className="flex-1 flex items-center justify-center mt-4 md:mt-0">
          <Logo />
        </div>

        <div className="flex-1 flex items-center justify-center text-center mt-14 sm:mt-10 md:mt-0">
          <div className="bg-white p-8 rounded-2xl shadow-gray-900 shadow-2xl lg:w-96">
            <h2 className="text-2xl md:text-3xl font-bold mb-5">Prijava</h2>
            <form onSubmit={handleSubmit}>
              <div className="mb-4">
                <input
                  type="text"
                  placeholder="Korisničko ime"
                  className={`w-full p-3 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 ${
                    serverErrorMessage
                      ? "ring-2 ring-red-500"
                      : "focus:ring-blue-500"
                  }`}
                  value={username}
                  onChange={(e) => setUsername(e.target.value)}
                  maxLength={30}
                  required
                />
              </div>
              <div className="mb-4">
                <input
                  type="password"
                  placeholder="Lozinka"
                  className={`w-full p-3 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 ${
                    serverErrorMessage
                      ? "ring-2 ring-red-500"
                      : "focus:ring-blue-500"
                  }`}
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                  maxLength={20}
                  required
                />
              </div>

              {serverErrorMessage && (
                <div
                  style={{ color: "red" }}
                  className="lg:text-[15px] mb-4 font-semibold"
                >
                  {serverErrorMessage}
                </div>
              )}

              <button
                type="submit"
                className="bg-blue-500 text-white w-full py-3 rounded-lg hover:bg-blue-600 transition-colors"
              >
                Prijavi se
              </button>
            </form>
            <div className="mt-4 flex justify-center items-center text-gray-600">
              <p className="mr-2">Još uvijek nemate račun?</p>
              <button
                className="text-blue-500 hover:underline"
                onClick={() => router.push("/register")}
              >
                Registriraj se
              </button>
            </div>
          </div>
        </div>
      </div>

      <motion.div
        ref={typingRef}
        className="w-full text-center pb-20 pt-[19px] bg-gray-100"
        initial={{ opacity: 0, y: 50 }}
        whileInView={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.8 }}
        viewport={{ once: true }}
      >
        <svg width="100%" height="12" viewBox="0 0 100 10">
          <line
            x1="0"
            y1="5"
            x2="100"
            y2="5"
            stroke="#4b5563"
            strokeWidth="8"
            strokeLinecap="round"
          />
        </svg>
        <h2 className="text-2xl md:text-3xl lg:text-4xl font-bold text-textColor mt-4">
          {isTypingVisible && (
            <Typewriter
              words={["Imaš problema s učenjem matematike?"]}
              loop={1}
              typeSpeed={50}
              deleteSpeed={30}
            />
          )}
        </h2>
        <p className="text-base sm:text-lg md:text-xl max-w-3xl mx-auto text-textColor mt-3 mb-6 text-justify px-4">
          Ako tvoje učenje matematike izgleda ovako – dosadno, zbunjujuće i bez
          prave motivacije – onda imamo rješenje za tebe! Naša platforma ti
          pomaže kroz interaktivne lekcije, zabavne zadatke i personalizirano
          učenje. Uz razne vizualne i praktične primjere, moći ćeš brzo
          napredovati i usvojiti nova znanja na jednostavan način. Kroz igru i
          izazove, učenje postaje zabavno, a naš sustav praćenja napretka
          omogućuje ti da uvijek znaš koliko si daleko stigao. Pridruži se i
          otkrij kako učenje može biti lako i inspirativno!
        </p>

        <Image
          src="/images/kid-struggle.jpg"
          alt="Dijete koje uči matematiku"
          width={500}
          height={300}
          className="mx-auto rounded-lg shadow-md w-full max-w-sm md:max-w-md lg:max-w-lg h-auto"
        />
      </motion.div>

      <motion.div
        ref={typingRefAbout}
        className="w-full text-center pb-20 pt-[19px] flex flex-col items-center justify-center"
        style={{ backgroundColor: "#b5d3f0" }}
        initial={{ opacity: 0, y: 50 }}
        whileInView={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.8 }}
        viewport={{ once: true }}
      >
        <svg width="100%" height="12" viewBox="0 0 100 10">
          <line
            x1="0"
            y1="5"
            x2="100"
            y2="5"
            stroke="#4b5563"
            strokeWidth="8"
            strokeLinecap="round"
          />
        </svg>

        <h2 className="font-bold mb-6 mt-4 text-2xl md:text-3xl lg:text-4xl">
          {isTypingVisibleAbout && (
            <Typewriter
              words={["O našoj aplikaciji"]}
              loop={1}
              typeSpeed={50}
              deleteSpeed={30}
            />
          )}
        </h2>

        <p className="text-base sm:text-lg md:text-xl max-w-3xl mx-auto text-textColor mt-3 mb-6 text-justify px-4">
          Naša aplikacija je zabavan i interaktivan alat koji omogućava
          učenicima osnovnih i srednjih škola da uče matematiku na potpuno nov i
          uzbudljiv način! Kroz <b>sortirane lekcije</b>,{" "}
          <b> dnevne kvizove </b> i <b> takmičenja</b>, učenici mogu vježbati
          osnovne matematičke vještine, rješavati zadatke i razvijati logičko
          razmišljanje. Aplikacija omogućava <b>rangiranje</b> korisnika prema
          uspješnosti na natjecanjima, što stvara dodatnu motivaciju za napredak
          i postizanje boljih rezultata. Također, svaki učenik može{" "}
          <b>pratiti svoj napredak</b> i vidjeti kako se poboljšava iz dana u
          dan. Na ovaj način, učenici mogu biti sigurni da napreduju, dok se
          zabavljaju u procesu učenja!
        </p>

        <div className="flex flex-col items-center gap-4 mt-6 max-w-xs w-full relative">
          <div className="flex justify-start w-full items-center gap-2">
            <CircleWithContent>📚</CircleWithContent>
            <span className="text-textColor font-bold text-sm md:text-base lg:text-lg">
              Sortirane lekcije
            </span>
          </div>

          {/* Prva linija */}
          <svg
            className="absolute top-12"
            height="100"
            width="100%"
            style={{ zIndex: 10 }}
          >
            <line
              x1="23%"
              y1="15%"
              x2="72%"
              y2="10%"
              stroke="#4b5563"
              strokeWidth="3"
              strokeLinecap="round"
              transform="rotate(30, 60, 50)"
              strokeDasharray="5,5"
            />
          </svg>

          <div className="flex justify-end w-full items-center gap-2">
            <span className="text-textColor font-bold text-sm md:text-base lg:text-lg">
              Dnevni kvizovi
            </span>
            <CircleWithContent>📅</CircleWithContent>
          </div>

          {/* Druga linija */}
          <svg
            className="absolute top-[169px]"
            height="100"
            width="100%"
            style={{ zIndex: 10 }}
          >
            <line
              x1="58%"
              y1="-67%"
              x2="23.5%"
              y2="154%"
              stroke="#4b5563"
              strokeWidth="3"
              strokeLinecap="round"
              transform="rotate(35, 60, 50)"
              strokeDasharray="5,5"
            />
          </svg>

          <div className="flex justify-start w-full items-center gap-2">
            <CircleWithContent>🏆</CircleWithContent>
            <span className="text-textColor font-bold text-sm md:text-base lg:text-lg">
              Takmičenja
            </span>
          </div>

          {/* Treca linija */}
          <svg
            className="absolute top-72"
            height="100"
            width="100%"
            style={{ zIndex: 10 }}
          >
            <line
              x1="23%"
              y1="15%"
              x2="72%"
              y2="10%"
              stroke="#4b5563"
              strokeWidth="3"
              strokeLinecap="round"
              transform="rotate(30, 60, 50)"
              strokeDasharray="5,5"
            />
          </svg>

          <div className="flex justify-end w-full items-center gap-2">
            <span className="text-textColor font-bold text-sm md:text-base lg:text-lg">
              Rangiranje korisnika
            </span>
            <CircleWithContent>
              <GiPodium className="text-gray-700" />
            </CircleWithContent>
          </div>

          {/* Cetvrta linija */}
          <svg
            className="absolute top-[411px]"
            height="100"
            width="100%"
            style={{ zIndex: 10 }}
          >
            <line
              x1="58%"
              y1="-67%"
              x2="23.5%"
              y2="154%"
              stroke="#4b5563"
              strokeWidth="3"
              strokeLinecap="round"
              transform="rotate(35, 60, 50)"
              strokeDasharray="5,5"
            />
          </svg>
          <div className="flex justify-start w-full items-center gap-2">
            <CircleWithContent>
              <TiTickOutline className="text-green-700" />
            </CircleWithContent>
            <span className="text-textColor font-bold text-sm md:text-base lg:text-lg">
              Praćenje napretka
            </span>
          </div>
        </div>
      </motion.div>

      <motion.div
        ref={typingRefContact}
        className="w-full text-center pb-16 pt-[19px] text-white"
        style={{ backgroundColor: "#094e93" }}
        initial={{ opacity: 0, y: 50 }}
        whileInView={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.8 }}
        viewport={{ once: true }}
      >
        <svg width="100%" height="12" viewBox="0 0 100 10">
          <line
            x1="0"
            y1="5"
            x2="100"
            y2="5"
            stroke="#ffffff"
            strokeWidth="8"
            strokeLinecap="round"
          />
        </svg>
        <h2 className="text-2xl md:text-3xl lg:text-4xl font-bold mb-6 mt-4">
          {isTypingVisibleContact && (
            <Typewriter
              words={["Kontaktirajte nas"]}
              loop={1}
              typeSpeed={50}
              deleteSpeed={30}
            />
          )}
        </h2>
        <p className="text-base md:text-lg">Imate pitanja? Javite nam se na:</p>
        <p className="text-base md:text-lg font-semibold">
          <a href="mailto:official.mathplusplus@gmail.com">
            official.mathplusplus@gmail.com
          </a>
        </p>
      </motion.div>
    </div>
  );
}
