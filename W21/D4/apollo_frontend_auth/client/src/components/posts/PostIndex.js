import React from "react";
import { Query } from "react-apollo";

import { FETCH_POSTS } from "../../graphql/queries";

const App = () => {
  return (
    <Query query={FETCH_POSTS}>
      {({ loading, error, data }) => {
        if (loading) return "Loading...";
        if (error) return `Error! ${error.message}`;

        return (
          <ul>
            {data.posts.map(post => (
              <li key={post.id}>
                <h2>{post.title}</h2>
                <p>{post.body}</p>
              </li>
            ))}
          </ul>
        );
      }}
    </Query>
  );
};

export default App;
