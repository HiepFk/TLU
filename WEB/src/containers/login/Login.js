import React, { Component } from "react";
import {
  Wrapper,
  PopupLoginWrapper,
  Text,
  Row,
  Input,
  Button,
  Blank,
} from "./loginStyle";
import "./app.css";
import api from "../../services/api";
import anh from "../../asset/images/logo.png";
class Login extends Component {
  constructor(props) {
    super(props);
    this.state = {
      userName: "",
      passWord: "",
    };
    this.handleUserName = this.handleUserName.bind(this);
    this.handlePassWord = this.handlePassWord.bind(this);
  }

  login(event) {
    const params = {
      userName: this.state.userName,
      passWord: this.state.passWord,
    };
    console.log(params);

    api
      .create()
      .login()
      .then((response) => {
        console.log("data = ", response);
        if (
          params.userName === response.data.userName &&
          params.passWord === response.data.passWord
        ) {
          window.location.replace("/Main");
        } else {
          console.log("Sai");
          this.setState({ userName: "", passWord: "" });
        }
      })
      .catch((error) => {
        const { message } = error;
        console.log("error: ", message);
      });
  }
  getUserInfo() {
    api
      .create()
      .getUserInfo()
      .then((response) => {
        console.log("Name : ", response.data.Name);
        console.log("Class : ", response.data.Class);
      })
      .catch((error) => {
        const { message } = error;
        console.log("error: ", message);
      });
  }

  handleUserName(event) {
    this.setState({ userName: event.target.value });
  }

  handlePassWord(event) {
    this.setState({ passWord: event.target.value });
  }

  render() {
    return (
      <Wrapper className="Wrapper">
        <PopupLoginWrapper className="PopupLoginWrapper">
          <img src={anh} className="Logo"></img>
          <Text fontSize={25}>LOGIN</Text>
          <Row>
            <Text fontSize={20}>User name</Text>
            <Input
              value={this.state.userName}
              onChange={this.handleUserName}
              type="text"
              placeholder="A34729"
            />
          </Row>
          <Blank height={0.5} />
          <Row>
            <Text fontSize={20}>Password</Text>
            <Input
              value={this.state.passWord}
              onChange={this.handlePassWord}
              type="password"
              placeholder="1"
            />
          </Row>
          <Button className="Button" onClick={() => this.login()}>
            Login
          </Button>
          <Button className="Button" onClick={() => this.getUserInfo()}>
            Get User Info
          </Button>
        </PopupLoginWrapper>
      </Wrapper>
    );
  }
}

export default Login;
