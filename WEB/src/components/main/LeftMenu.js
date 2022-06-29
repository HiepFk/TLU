import React, { Component } from "react";
import {
  Wrapper,
  Avatar,
  TextField,
  ButtonLogout,
  Blank,
} from "./leftMenuStyle";
import Images from "../../asset/images";
import "./app.css";

class LeftMenu extends Component {
  constructor(props) {
    super(props);
    this.state = {};
  }
  logout() {
    window.location.replace("/");
  }

  render() {
    const { userName, totalPoint, testComplete, testNotComplete } = this.props;
    return (
      <Wrapper id="LeftMenu">
        <Avatar src={Images.avataDefault} alt="avata" />
        <TextField>{userName}</TextField>
        <TextField>Point: {totalPoint}</TextField>
        <TextField>Test complete: {testComplete}</TextField>
        <TextField>Test not complete: {testNotComplete}</TextField>
        <Avatar src={Images.avataDefault2} alt="avata" />
        <Blank />
        <ButtonLogout className="button" onClick={() => this.logout()}>
          Log out
        </ButtonLogout>
      </Wrapper>
    );
  }
}

export default LeftMenu;
