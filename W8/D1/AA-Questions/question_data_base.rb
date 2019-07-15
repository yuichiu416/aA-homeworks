require 'sqlite3'
require 'singleton'

class AAQuestionDatabase < SQLite3::Database
    include Singleton
    def initialize
        super('aaquestion.db')
        self.type_translation = true
        self.results_as_hash = true
    end
    # I don't think we should add anything here
    #agreed
           
end

class Question
    attr_accessor :id, :title, :body, :user_id
    def self.all
        table = AAQuestionDatabase.instance.execute("SELECT * FROM questions")
        table.map { |row| Question.new(row) }
    end

    def self.find_by_author_id(author_id)
        entries = AAQuestionDatabase.instance.execute(<<-SQL, author_id)
            SELECT * 
            FROM questions
            WHERE user_id = ?
        SQL
        entries.map{ |entry| Question.new(entry)}
    end

    def initialize(hash_options)
        @id = hash_options['id']
        @title = hash_options['title']
        @body = hash_options['body']
        @user_id = hash_options['user_id']
    end

    def author
        entries = AAQuestionDatabase.instance.execute(<<-SQL, @user_id)
            SELECT *
            FROM users
            WHERE id = ?
        SQL
        entries.map { |entry| User.new(entry)}
    end

    def replies
        Reply.find_by_question_id(@id)
    end

    
    def insert
        AAQuestionDatabase.instance.execute(<<-SQL, @title, @body, @user_id)
            INSERT INTO
                questions (title, body, user_id)
            VALUES
                (?, ?, ?)
        SQL
    end  
    #q1 = Question.new(id=> 1,body=> 'you think it will work?', title=> '???','user_id' =>1)

    def update
        AAQuestionDatabase.instance.execute(<<-SQL, @title, @body, @user_id, @id)
            UPDATE
                questions
            SET
                title = ?,
                body = ?,
                user_id = ?
            WHERE
                id = ?
        SQL
    end  

    def followers
        QuestionFollow.followers_for_question_id(@id)    
    end
    
end

class User
    attr_accessor :id, :fname, :lname

    def self.find_by_name(fname, lname)
        AAQuestionDatabase.instance.execute(<<-SQL, fname, lname)
            SELECT *
            FROM Users
            WHERE fname = ? AND lname = ? 
        SQL
            
    end

    def initialize(hash_options)
        @id = hash_options['id']
        @fname = hash_options['fname']
        @lname = hash_options['lname']
    end

    def insert
        AAQuestionDatabase.instance.execute(<<-SQL, @fname, @lname)
            INSERT INTO 
                users (fname, lname)
            VALUES
                (?, ?)
        SQL
    end  

    def update
        AAQuestionDatabase.instance.execute(<<-SQL, @fname, @lname, @id)
            UPDATE
                users
            SET
                fname = ?,
                lname = ?
            WHERE
                id = ?
        SQL
    end

    def authored_questions
        Question.find_by_author_id(@id)
    end

    def authored_replies
        Reply.find_by_user_id(@id)
    end

    def followed_questions
        QuestionFollow.followed_questions_for_user_id(@user_id)
    end
end

class QuestionFollow
    attr_accessor :user_id, :question_id
    def self.followers_for_question_id(question_id)
        users = []
        entries = AAQuestionDatabase.instance.execute(<<-SQL, question_id)
            SELECT *
            FROM users
            INNER JOIN questions_follows ON users.id = questions_follows.user_id
            WHERE question_id = ?
        SQL
        entries.each{ |entry| users << User.new(entry)}
        users
    end

    def self.followed_questions_for_user_id(user_id)
        questions = []
        entries = AAQuestionDatabase.instance.execute(<<-SQL, user_id)
            SELECT DISTINCT questions.title, (users.fname || ' ' || users.lname) as follower
            FROM questions_follows
            INNER JOIN questions ON questions_follows.user_id = questions.user_id
            JOIN users ON users.id = questions_follows.user_id
            WHERE questions_follows.user_id = ?;
        SQL
        entries.each{ |entry| questions << Question.new(entry)}
        questions
    end
    
    def self.most_followed_questions(n)
       questions = []
        entries = AAQuestionDatabase.instance.execute(<<-SQL, n)
            SELECT questions.title, Count(DISTINCT questions_follows.question_id) as Followers
            FROM questions_follows
            INNER JOIN questions ON questions_follows.user_id = questions.user_id
            JOIN users ON users.id = questions_follows.user_id
            GROUP BY questions_follows.user_id
            ORDER BY Count(questions_follows.question_id) DESC
            LIMIT ?
        SQL
        
        entries.each{ |entry| questions << Question.new(entry)}
        questions
    end
    def initialize(hash_options)
        @user_id = hash_options['user_id']
        @question_id = hash_options['question_id']
    end

    def insert
        AAQuestionDatabase.instance.execute(<<-SQL, @user_id, @question_id)
            INSERT INTO 
                question_follows (user_id, question_id)
            VALUES
                (?, ?)
        SQL
    end  
    # def update
    #     AAQuestionDatabase.instance.execute(<<-SQL, @user_id, @question_id)
    #         UPDATE
    #             question_follows (user_id, question_id)
    #         SET
    #             user_id = ?
    #             question_id = ?
    #     SQL
    # end
end


class Reply
    attr_accessor :id, :question_id, :parent_id, :user_id, :body

    def self.find_by_user_id(user_id)
        entries = AAQuestionDatabase.instance.execute(<<-SQL, user_id)
            SELECT *
            FROM replies
            WHERE user_id = ?
        SQL
        entries.map {|entry| Reply.new(entry)}
    end
    
    def self.find_by_question_id(question_id)
        entries = AAQuestionDatabase.instance.execute(<<-SQL, question_id)
            SELECT *
            FROM replies
            WHERE question_id = ?
        SQL
        entries.map {|entry| Reply.new(entry)}
    end
    
    def initialize(hash_options)
        @id = hash_options['id']
        @question_id = hash_options['question_id']
        @parent_id =  hash_options['parent_id']
        @user_id = hash_options['user_id']
        @body = hash_options['body']
    end

    def insert
        AAQuestionDatabase.instance.execute(<<-SQL, @question_id, @parent_id, @user_id, @body)
            INSERT INTO 
                replies(question_id, parent_id, user_id, body)
            VALUES
                (?, ?, ?, ?)
        SQL
    end

    def update
        AAQuestionDatabase.instance.execute(<<-SQL, @question_id, @parent_id, @user_id, @body, @id)
            UPDATE 
                replies(question_id, parent_id, user_id, body, id)
            SET
                question_ id = ?,
                parent_id = ?,
                user_id = ?,
                body = ?
            WHERE
                id = ?
        SQL
        #update the questionfollows(@user_id, question_id)
    end

    def author
        entries = AAQuestionDatabase.instance.execute(<<-SQL, @user_id)
            SELECT *
            FROM users
            WHERE user_id = ?
        SQL
        entries.map {|entry| User.new(entry)}
    end

    def question
        entries = AAQuestionDatabase.instance.execute(<<-SQL, @question_id)
            SELECT *
            FROM users
            WHERE question_id = ?
        SQL
        entries.map {|entry| Question.new(entry)}
    end

    def parent_reply
        entries = AAQuestionDatabase.instance.execute(<<-SQL, @parent_id)
            SELECT *
            FROM replies
            WHERE id = ?
        SQL
        entries.map {|entry| Reply.new(entry)}
    end

    def child_replies
        entries = AAQuestionDatabase.instance.execute(<<-SQL, @id)
            SELECT *
            FROM replies
            WHERE parent_id = ?
        SQL
        entries.map {|entry| Reply.new(entry)}
    end
end

class QuestionLike
    attr_accessor :user_id, :question_id

    def self.likers_for_question_id(question_id)
        entries = AAQuestionDatabase.instance.execute(<<-SQL, question_id)
            SELECT DISTINCT ( users.fname || ' ' || users.lname) as Liker(s)
            FROM questions
            INNER JOIN question_likes ON questions.id = question_likes.question_id
            JOIN users ON question_likes.user_id = users.id
            WHERE questions.id = ?   
        SQL
        entries
    end
    
    def self.num_likes_for_question_id(question_id)
        count = AAQuestionDatabase.instance.execute(<<-SQL, question_id)
            SELECT DISTINCT COUNT(question_likes.user_id)
            From question_likes
            GROUP BY question_likes.question_id
            HAVING question_likes.question_id = ?
        SQL
        count
    end

    def initialize(hash_options)
        @user_id = hash_options['user_id']
        @question_id = hash_options['question_id']
    end
    
    def insert
        AAQuestionDatabase.instance.execute(<<-SQL, @question_id, @user_id)
            INSERT INTO 
                question_likes(user_id, question_id)
            VALUES
                (?, ?)
        SQL
    end
end