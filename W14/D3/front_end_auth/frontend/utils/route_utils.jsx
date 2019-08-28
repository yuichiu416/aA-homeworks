import React from 'react';
import { connect} from 'react-redux';
import { Redirect, Route, withRouter} from 'react-router-dom';

const mapStateToProps = state => ({
    loggedIn: Boolean(state.session.currentUser)
});

// <AuthRoute pah="" component={ }/>

const Auth = ({ loggedIn, path, component: Component}) => (
    <Route
        path={path}
        render={props => (
            loggedIn ? <Redirect to="/" /> : <Component {...props} />
        )}
    />
);

const Protected = ({ loggedIn, path, component: Component}) => (
    <Route
        path={path}
        render={props => (
            loggedIn ? <Component {...props}/> : <Redirect to="/sign/up" />

        )}
    />
);

export const AuthRoute = WithRouter(connect(mapStateToProps)(Auth));
export const protectedRoute = withRouter(connect(mapStateToProps)(Protected));