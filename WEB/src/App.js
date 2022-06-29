import React, { Component } from "react";
import { BrowserRouter, Switch, Route } from "react-router-dom";
import PrivateRoute from "./PrivateRoute";
import Login from "./containers/login/Login";
import NotFound from "./containers/notFound/NotFound";
import Main from "./containers/main/Main";

const App = () => {
  return (
    <BrowserRouter>
      <Switch>
        <PrivateRoute exact path="/Main" component={Main} />
        <Route exact path="/" component={Login} />
        <Route component={NotFound} />
      </Switch>
    </BrowserRouter>
  );
};

export default App;
