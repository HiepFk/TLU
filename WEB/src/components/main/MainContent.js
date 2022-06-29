import React, { Component, useState, useEffect } from "react";
import { Wrapper, Blank, Sort } from "./mainContentStyle";
import Header from "./Header";
import Subject from "./Subject";
import Pagination from "@material-ui/lab/Pagination";

class MainContent extends Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  renderListItem(currentPage, perPage) {
    const { listItem } = this.props;
    const indexOfLastPost = currentPage * perPage;
    const indexOfFirstPost = indexOfLastPost - perPage;
    const currentPosts = listItem.slice(indexOfFirstPost, indexOfLastPost);
    const items = [];
    for (let i = 0; i < currentPosts.length; i++) {
      const item = (
        <Subject
          name={currentPosts[i].name}
          point={currentPosts[i].point}
          time={currentPosts[i].time}
          diff={currentPosts[i].diff}
          past={currentPosts[i].past}
        />
      );
      items.push(item);
    }
    return <Sort>{items}</Sort>;
  }
  render() {
    const {
      searchKeyword,
      sortFilter,
      currentPage,
      perPage,
      totalPosts,
      searchOnClick,
      searchKeywordOnChange,
      sortFilterOnChange,
      listItem,
      changePage,
    } = this.props;
    return (
      <Wrapper>
        <Header
          searchKeyword={searchKeyword}
          sortFilter={sortFilter}
          searchOnClick={searchOnClick}
          searchKeywordOnChange={searchKeywordOnChange}
          sortFilterOnChange={sortFilterOnChange}
        />
        <Blank>{this.renderListItem(currentPage, perPage)}</Blank>
        <Pagination
          count={Math.ceil(listItem.length / perPage)}
          variant="outlined"
          shape="rounded"
          onChange={(event, value) => {
            changePage(value);
            console.log(value);
          }}
          style={{
            marginBottom: "1em",
          }}
        />
      </Wrapper>
    );
  }
}

export default MainContent;
