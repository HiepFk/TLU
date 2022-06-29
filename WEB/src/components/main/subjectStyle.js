import styled from "styled-components";

export const Wrapper = styled.div`
  width: 15em;
  min-height: 6.5em;
  color: black;
  display: flex;
  justify-content: flex-start;
  align-items: center;
  flex-direction: column;
  background-color: white;
  box-shadow: 0 0 10px 10px rgba(0, 0, 0, 0.1);
`;

export const Row = styled.div`
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-direction: row;
  width: 100%;
`;

export const Column = styled.div`
  display: flex;
  justify-content: center;
  align-items: flex-start;
  flex-direction: column;
  height: 100%;
  margin-left: 1.5em;
`;

export const TextField = styled.div`
  font-size: 16px;
  margin-left: 0.5em;
  margin-top: 0.5em;
`;

export const CheckBox = styled.input`
  margin-right: 0.5em;
  margin-top: 0.5em;
`;

export const ButtonWrapper = styled.div`
  flex: 1;
  height: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
`;

export const ButtonStart = styled.button`
  font-size: 20px;
  font-weight: bold;
  padding: 0.5em;
  border-radius: 0.25em;
`;

export const Star = styled.img`
  width: 1em;
  margin-left: 0.2em;
  margin-top: 0.5em;
  margin-bottom: 0.2em;
`;
export const Star_not = styled.img`
  width: 1em;
  margin-left: 0.2em;
  filter: grayscale(100%);
  margin-top: 0.5em;
  margin-bottom: 0.2em;
`;

export const RowLeft = styled.div`
  display: flex;
  justify-content: flex-start;
  align-items: center;
  flex-direction: row;
  width: 100%;
  margin-left: 10px;
`;
