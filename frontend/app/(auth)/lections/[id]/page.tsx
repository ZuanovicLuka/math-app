"use client";

import { useParams, useSearchParams, useRouter } from "next/navigation";
import { useEffect, useState } from "react";
import theoryLinks from "~/public/links.json";

type TheoryLinks = Record<string, string>;

export default function LectionLanding() {
  const params = useParams();
  const searchParams = useSearchParams();
  const router = useRouter();

  const lectionId = params.id as string;
  const lectionTitle = searchParams.get("title") || "Nepoznata lekcija";

  const [theoryLink, setTheoryLink] = useState<string | null>(null);

  useEffect(() => {
    const links = theoryLinks as TheoryLinks;
    const foundLink = lectionTitle in links ? links[lectionTitle] : null;
    setTheoryLink(foundLink);
  }, [lectionTitle]);

  return (
    <div className="min-h-screen flex flex-col items-center justify-center bg-gradient-to-b from-blue-100 to-white p-6">
      <div className="bg-white shadow-lg rounded-2xl p-8 max-w-2xl w-full text-center space-y-8">
        <h1 className="text-2xl font-semibold">
          Lekcija: <b>{lectionTitle}</b>
        </h1>

        <div className="space-y-4">
          <p className="text-lg text-gray-800">
            Smatraš da ti treba ponavljanje teorijskog gradiva za ovu lekciju?
          </p>

          {theoryLink ? (
            <a
              href={theoryLink}
              target="_blank"
              rel="noopener noreferrer"
              className="block bg-yellow-400 text-gray-900 font-semibold py-2 px-4 rounded-lg hover:bg-yellow-500 transition w-44 mx-auto"
            >
              Ponavljaj teoriju
            </a>
          ) : (
            <p className="text-red-500 font-medium">
              Nije pronađen link za teoriju ove lekcije.
            </p>
          )}
        </div>

        <hr className="my-4" />

        <div className="space-y-4">
          <p className="text-lg text-gray-800">
            Ako si spreman, provjeri svoje znanje:
          </p>
          <button
            onClick={() => router.push(`/lections/tasks/${lectionId}`)}
            className="bg-blue-600 text-white font-semibold py-2 px-4 rounded-lg hover:bg-blue-800 transition w-44"
          >
            Riješi zadatke
          </button>
        </div>
      </div>
    </div>
  );
}
