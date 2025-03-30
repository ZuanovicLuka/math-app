import { useQuery } from "@tanstack/react-query";
import { useRouter } from "next/navigation";
import { apiCall } from "~/api";

export const useGetUser = () => {
  const router = useRouter();

  return useQuery({
    queryKey: ["user"],
    retry: false, // ako je false onda ako query fail-a nece se opet slati
    queryFn: async () => {
      const [data, status] = await apiCall(`/users/info`, { method: "GET" });

      if (status !== 200) {
        localStorage.removeItem("token");
        router.push("/");
        return null;
      }

      return data;
    },
  });
};
