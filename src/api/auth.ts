import axios from "axios";

// Import the API URL from the globals.
import { baseUrl, baseUrl2 } from "./globals";

const axiosConfig = {
  withCredentials: true,
};


//utilizamos esta funcion para enviar una solicitud de inicio de sesion a la API utilizando el metodo POST y devuelve una promesa que se resuelve con la respuesta a esa solicitud
export const login = async (email: string, password: string) => {
  // Send cookie with x-access-token response header
  axios.defaults.withCredentials = true;
  //pasamos la url de la api, con la url exacta de la parte de la api y el cuerpo de la solicitud es un objeto con dos propiedades cuyos valores son los argumentos de esta funcion
  const res = axios.post(baseUrl + "/api/auth/signin", { email, password });
  return res;
};

export const register = (user_id: string, username: string, email: string, password: string) => {
  axios.defaults.withCredentials = false;
  return axios.post( baseUrl2 + "/create_user", { user_id, username, email, password });
};

export const modify_user = (user_id: string, password: string, full_name: string, visual_disability: number, mental_disability: number, deaf_disability: number, birth_date: string, description: string, abilities: string, specific_disability: string) => {
  axios.defaults.withCredentials = false;
  return axios.put(baseUrl2 + "/modify_user",{user_id, password, full_name, visual_disability, mental_disability, deaf_disability, birth_date, description, abilities, specific_disability });
};


export const checkAuth = () => {
  axios.defaults.withCredentials = true;
  return axios.get(baseUrl + "/api/user/checkJWT", axiosConfig);
};

export const isLogged = async () => {
  axios.defaults.withCredentials = true;
  return axios.get(baseUrl + "/api/user/isLogged", axiosConfig);
};

export const logout = () => {
  axios.defaults.withCredentials = true;
  return axios.get(baseUrl + "/api/auth/logout", axiosConfig);
};

export const activate = (user_id: string, code: string) => {
  return axios.post(
    baseUrl + "/api/auth/verify",
    {
      user_id: user_id,
      code,
    },
    axiosConfig
  );
};

export const resendActivation = (email: string) => {
  return axios.post(
    baseUrl + "/api/mail/resend",
    {
      email,
    },
    axiosConfig
  );
};
