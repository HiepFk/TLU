import axios from "axios";
import StorageUtils from "../helpers/StorageUtils";

const defaultURL = "http://demo0495181.mockable.io//";

const headers = {
  "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
  "Access-Control-Allow-Origin": "my-authorized-proxy-or-domain",
  "Access-Control-Allow-Headers":
    "Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With",
};

const create = (baseUrl = null) => {
  const api = axios.create({
    baseURL: baseUrl === null ? defaultURL : baseUrl,
    timeout: 60000,
  });

  const sendGet = (path, options = { headers: headers }) =>
    api.get(path, options).then((response) => {
      const { code } = response.data || {};
      if (code === 503) {
        throw response;
      } else {
        return response;
      }
    });

  const sendPost = (path, params, options = { headers: headers }) =>
    api.post(path, params, options).then((res) => {
      const { code } = res.data || {};
      if (code === 503) {
        throw res;
      } else {
        return res;
      }
    });

  const sendPut = (path, params, options = {}) =>
    api.put(path, params, options).then((res) => {
      const { code } = res.data || {};
      if (code === 503) {
        throw res;
      } else {
        return res;
      }
    });

  const generateGet = (path, params = null) => {
    const options = {
      headers: {
        ...headers,
        Authorization: `Bearer ${StorageUtils.getToken()}`,
        params,
      },
    };
    return sendGet(path, options);
  };

  const generatePost = (path, params) => {
    const options = {
      headers: {
        ...headers,
        Authorization: `Bearer ${StorageUtils.getToken()}`,
      },
    };
    return sendPost(path, params, options);
  };

  const generatePut = (path, params) => {
    const options = {
      headers: {
        Authorization: `Bearer ${StorageUtils.getToken()}`,
      },
    };
    return sendPut(path, params, options);
  };

  const login = () => generateGet(`login`);
  const getUserInfo = () => generateGet(`login`);
  const fetchListTest = () => generateGet(`listExample`);
  return {
    login,
    getUserInfo,
    fetchListTest,
  };
};

export default {
  create,
};
