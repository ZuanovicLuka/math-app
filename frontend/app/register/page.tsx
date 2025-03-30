"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { z } from "zod";

const signUpSchema = z.object({
  first_name: z
    .string()
    .min(2, "Ime mora imati barem 2 znaka!")
    .regex(/^[A-ZČĆŠĐŽ][a-zA-ZČĆŠĐŽčćšđž]*$/, "Neispravan format imena!"),
  last_name: z
    .string()
    .min(2, "Prezime mora imati barem 2 znaka!")
    .regex(/^[A-ZŠČĆĐŽ][a-zA-ZČĆŠĐŽčćšđž]*$/, "Neispravan format prezimena!"),
  username: z
    .string()
    .min(4, "Korisničko ime mora imati barem 4 znaka!")
    .regex(/^[a-zA-Z][a-zA-Z0-9._]*$/, "Neispravan format korisničkog imena!"),
  email: z.string().email("Neispravan email format!"),
  password: z.string().min(6, "Lozinka mora imati barem 6 znakova!"),
});

export default function Register() {
  const router = useRouter();

  const [formData, setFormData] = useState({
    first_name: "",
    last_name: "",
    username: "",
    email: "",
    password: "",
    schoolLevel: "",
  });

  const [errors, setErrors] = useState<any>({});

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setFormData({ ...formData, [name]: value });
  };

  const handleSubmit = async (e: any) => {
    e.preventDefault();

    try {
      signUpSchema.parse(formData);
      setErrors({});

      // Priprema podataka za backend
      const registrationData = {
        firstName: formData.first_name,
        lastName: formData.last_name,
        username: formData.username,
        email: formData.email,
        password: formData.password,
        schoolLevel: formData.schoolLevel,
      };

      // Slanje podataka na backend
      const response = await fetch("http://localhost:8080/api/users/register", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(registrationData),
      });

      if (!response.ok) {
        const errorData = await response.json();
        console.log("aaa bbbb " + errorData);
      } else {
        const data = await response.json();
        console.log(data);
      }

      // Uspješna registracija - preusmjeravanje korisnika
      router.push("/home");
    } catch (error) {
      if (error instanceof z.ZodError) {
        const formattedErrors = error.errors.reduce((acc: any, curr) => {
          acc[curr.path[0]] = curr.message;
          return acc;
        }, {});
        setErrors(formattedErrors);
      }
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
      <div className="absolute top-4 left-4 w-[9rem]">
        <img src="/images/logo.png" className="w-full" />
      </div>
      <div className="bg-white p-6 rounded-2xl shadow-gray-900 shadow-2xl w-11/12 sm:w-4/5 md:w-3/5 lg:w-1/2 mt-20">
        <h2 className="text-2xl md:text-3xl font-bold mb-4 text-center text-textColor">
          Registracija
        </h2>
        <form onSubmit={handleSubmit}>
          <div className="grid grid-cols-2 gap-4 mb-4">
            {["first_name", "last_name", "username", "email", "password"].map(
              (field) => (
                <div key={field} className="col-span-1">
                  <input
                    type={field === "password" ? "password" : "text"}
                    name={field}
                    value={formData[field as keyof typeof formData]}
                    onChange={handleChange}
                    placeholder={
                      field === "first_name"
                        ? "Ime"
                        : field === "last_name"
                          ? "Prezime"
                          : field === "username"
                            ? "Korisničko ime"
                            : field === "email"
                              ? "Email"
                              : "Lozinka"
                    }
                    title={
                      field === "first_name"
                        ? "Ime mora imati barem 2 znaka i početi velikim slovom!"
                        : field === "last_name"
                          ? "Prezime mora imati barem 2 znaka i početi velikim slovom!"
                          : field === "username"
                            ? "Korisničko ime mora početi slovom i imati barem 4 znaka!"
                            : field === "email"
                              ? "Unesite ispravan email format (npr. ime@domena.com)"
                              : "Lozinka mora imati barem 6 znakova!"
                    }
                    className={`p-2 border rounded-lg w-full focus:outline-none focus:ring-2 focus:ring-blue-500 ${errors[field] ? "ring-2 ring-red-500" : "focus:ring-blue-500"} text-sm md:text-base`}
                    maxLength={field === "email" ? 50 : 20}
                    required
                  />

                  {errors[field] && (
                    <div className="text-red-700 text-xs font-semibold mt-1">
                      {errors[field]}
                    </div>
                  )}
                </div>
              )
            )}
          </div>
          <div className="mb-4 text-center">
            <p className="text-base md:text-lg text-textColor">
              Odaberite razinu svojeg obrazovanja:
            </p>
          </div>
          <div className="flex justify-center gap-2 mb-4">
            {["Osnovna škola", "Srednja škola"].map((level) => (
              <label
                key={level}
                className="text-sm md:text-base hover:cursor-pointer has-[:checked]:bg-[#1f3088] has-[:checked]:text-gray-100 bg-[#ffff] border-1 border-gray-400 rounded-md w-50 h-9 flex justify-center items-center text-textColor"
              >
                <input
                  type="radio"
                  className="opacity-0 absolute"
                  onChange={handleChange}
                  name="schoolLevel"
                  value={level}
                  checked={formData.schoolLevel === level}
                  required
                />
                {level}
              </label>
            ))}
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
