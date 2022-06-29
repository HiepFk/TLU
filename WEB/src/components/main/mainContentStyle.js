import styled from "styled-components";

export const Wrapper = styled.div`
  flex: 1;
  height: 100vh;
  color: #fdf9ff;
  font-weight: bold;
  display: flex;
  align-items: center;
  flex-direction: column;
  background-color: white;
`;

export const Blank = styled.div`
  flex: 1;
  background-color: white;
`;

export const Sort = styled.div`
  margin-top: 2em;
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  grid-gap: 50px;
`;
