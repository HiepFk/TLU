import styled from "styled-components";

export const Wrapper = styled.div`
  width: 9em;
  height: 100vh;
  color: black;
  font-size: 23px;
  font-weight: bold;
  display: flex;
  justify-content: flex-start;
  align-items: center;
  flex-direction: column;
  background: #ccc;
`;

export const Avatar = styled.img`
  width: 6em;
  margin-top: 1em;
`;

export const TextField = styled.div`
  margin-top: 0.3em;
  width: 100%;
  padding-left: 1em;
  box-sizing: border-box;
  font-size: 0.7em;
  font-weight: 600;
`;

export const ButtonLogout = styled.button`
  width: 75%;
  height: 2em;
  width: 75%;
  height: 2em;
  margin-bottom: 0.5em;
  font-size: 1em;
  font-weight: bold;
  cursor: pointer;
  background-color: white;
`;

export const Blank = styled.div`
  flex: 1;
`;
