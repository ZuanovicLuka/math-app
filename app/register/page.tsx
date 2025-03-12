"use client";

import { useEffect, useState, useRef } from "react";
import { useRouter } from "next/navigation";
import { useInView } from "framer-motion";

export default function Home() {
  const router = useRouter();
  const [username, setUsername] = useState("");

  return (
    <div className="min-h-screen flex flex-col items-center">
      <div
        className="w-full flex min-h-screen"
        style={{
          background:
            "linear-gradient(to right, #0a42e0 2%, #3661da 10%, #3b82f6 30%, #60a5fa 40%, #93c5fd 50%, #bfdbfe 60%, #dbeafe 70%, #ffffff 90%)",
        }}
      >
        aaa
      </div>
    </div>
  );
}
