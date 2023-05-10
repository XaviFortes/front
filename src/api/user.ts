import axios from "axios";
import { baseUrl, baseUrl2 } from "./globals";

// Include credentials axios
const axiosConfig = {
  withCredentials: false,
};

export const getChatRooms = async () => {
  // Include cookies and token with request
  const res = await axios.get(baseUrl + "/api/chat/getChatRooms", axiosConfig);
  return res;
};

export const getUser = async (uid: string) => {
  const res = await axios.post(
    baseUrl + "/api/user/getUser/",
    {
      uuid: uid,
    },
    axiosConfig
  );
  return res;
};

export const createcoverletter = (dni: string) => {
  console.log("user_id" + dni);
  return axios.post(baseUrl2 + "/create_cover_letter", {
    user_id: dni
   }, axiosConfig);
};

export const register = (nick: string, email: string, password: string) => {
  return axios.post(baseUrl + "/api/auth/signup", { nick, email, password });
};
