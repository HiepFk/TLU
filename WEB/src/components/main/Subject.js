import React, { Component } from "react";
import {
  Wrapper,
  Row,
  TextField,
  CheckBox,
  Column,
  ButtonWrapper,
  Star,
  Star_not,
  ButtonStart,
  RowLeft,
} from "./subjectStyle";
import StarImg from "../../asset/images/star.png";
import "./app.css";
class Subject extends Component {
  constructor(props) {
    super(props);
  }
  renderStars() {
    const stars = [];
    for (let i = 0; i < this.props.diff; i++) {
      const item = <Star src={StarImg} />;
      stars.push(item);
    }
    for (let i = 0; i < 5 - this.props.diff; i++) {
      const item = <Star_not src={StarImg} />;
      stars.push(item);
    }
    return stars;
  }
  render() {
    return (
      <Wrapper>
        <Row>
          <TextField className="name">{this.props.name}</TextField>
          <CheckBox type="checkbox" checked={this.props.past} />
        </Row>
        <Row>
          <Column>
            <TextField>Time: {this.props.time}</TextField>
            <TextField>Point: {this.props.point}</TextField>
            <TextField>Difficult: {this.props.diff}</TextField>
          </Column>
          <ButtonWrapper>
            <ButtonStart className="button">START</ButtonStart>
          </ButtonWrapper>
        </Row>
        <RowLeft>{this.renderStars()}</RowLeft>
      </Wrapper>
    );
  }
}

export default Subject;
