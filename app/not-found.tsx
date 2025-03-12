import { TiArrowLeftOutline } from "react-icons/ti";
import { TiArrowLeftThick } from "react-icons/ti";

export default function NotFound() {
  return (
    <div
      className="flex h-screen flex-col items-center justify-center"
      style={{
        background:
          "linear-gradient(to right, #0a42e0 2%, #3661da 10%, #3b82f6 30%, #60a5fa 40%, #93c5fd 50%, #bfdbfe 60%, #dbeafe 70%, #ffffff 90%)",
      }}
    >
      <h1 className="text-4xl font-bold text-textColor">
        404 - Page Not Found
      </h1>
      <p className="text-lg text-gray-600 mt-2 font-semibold">
        Oops! The page you are looking for does not exist.
      </p>
      <a
        href="/"
        className="group mt-4 px-4 py-2 bg-blue-500 text-white rounded-lg hover:bg-blue-600 font-semibold flex gap-2 items-center"
      >
        <TiArrowLeftOutline size={22} className="group-hover:hidden" />
        <TiArrowLeftThick size={22} className="hidden group-hover:block" />
        Go Home
      </a>
    </div>
  );
}
