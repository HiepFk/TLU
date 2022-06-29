import styled from "styled-components";

export const Wrapper = styled.div`
  width: 100vw;
  height: 100vh;
  color: green;
  font-size: 23px;
  font-weight: bold;
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
`;

export const PopupLoginWrapper = styled.div`
  width: 15em;
  border-radius: 0.2em;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: flex-start;
  padding-top: 1em;
  padding-bottom: 1em;
`;

export const Text = styled.div`
  color: black;
  font-size: ${(props) => props.fontSize}px;
  margin-bottom: 0.5rem;
  letter-spacing: 1.1px;
`;

export const Row = styled.div`
  width: 100%;
  box-sizing: border-box;
  padding-left: 1em;
  padding-right: 1em;
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  justify-content: flex-start;
`;

export const Input = styled.input`
  width: 100%;
  font-size: 16px;
  height: 2rem;
  border-radius: 6px;
  background: white;
  outline: none;
  border: none;
  margin-bottom: 0.5rem;
`;

export const Button = styled.button`
  width: 10em;
  margin-top: 1rem;
  font-size: 18px;
  font-weight: bold;
  height: 2.2em;
  cursor: pointer;
  background: white;
  border-radius: 0.35em;
  outline: none;
  border: none;
  transition: all 0.25s linear;
`;

export const Blank = styled.div`
  width: ${(props) => props.width}em;
  height: ${(props) => props.height}em;
`;
