DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS questions_follows;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;

CREATE TABLE users(
    id INTEGER PRIMARY KEY,
    fname TEXT NOT NULL,
    lname TEXT NOT NULL
);

CREATE TABLE questions(
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    user_id Integer NOT NULL,

    FOREIGN KEY(user_id) REFERENCES users(id)
);

CREATE TABLE questions_follows(
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,

    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(question_id) REFERENCES questions(id)
);

CREATE TABLE replies(
    id INTEGER PRIMARY KEY,
    question_id INTEGER NOT NULL,
    parent_id INTEGER,  
    user_id INTEGER NOT NULL,
    body TEXT NOT NULL,

    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE question_likes(
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,
    
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);


INSERT INTO 
    users
    (fname, lname)
VALUES
    ('senyo', 'a'),
    ('SWIM', 'anon'),
    ('rog', 'k');

INSERT INTO 
    questions
    (title, body, user_id)
VALUES
    ('How''s everyone going?', 'I''m the body', 1),
    ('Wooooo, our database created', 'Yay~~~~~', 2),
    ('qwerqwerwerwre', 'heeeeeeee', 2),
    ('Test question', 'Boom boom boom', 3);

INSERT INTO
    questions_follows
    (user_id, question_id)
VALUES
    (1, 1),
    (2, 1),
    (2, 2),
    (2, 3),
    (3, 1),
    (3, 4);

INSERT INTO
    replies
    (question_id, parent_id, user_id, body)
VALUES
    (1, NULL, 2, 'I''m doing well, thanks.'),
    (1, 1, 3, 'What''s up bro.'),
    (1, 2, 1, ';)');

INSERT INTO
    question_likes (user_id, question_id)
VALUES
    (1, 1),
    (1, 2),
    (2, 1),
    (2, 2),
    (2, 3),
    (3, 1),
    (3, 4);
