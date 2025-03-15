import React from "react";

interface CircleWithContentProps {
  children: React.ReactNode;
}

const CircleWithContent: React.FC<CircleWithContentProps> = ({ children }) => {
  return (
    <div className="w-24 h-24 rounded-full border-3 border-gray-700 flex justify-center items-center text-5xl text-black">
      {children}
    </div>
  );
};

export default CircleWithContent;
