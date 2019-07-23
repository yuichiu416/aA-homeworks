# == Schema Information
#
# Table name: cats
#
#  id          :integer      not null, primary key
#  name        :string
#  color       :string
#  breed       :string
#
# Table name: toys
#
#  id          :integer      not null, primary key
#  name        :string
#  color       :string
#  price       :integer
#
# Table name: cattoys
#
#  id          :integer      not null, primary key
#  cat_id      :integer      not null, foriegn key
#  toy_id      :integer      not null, foreign key

require_relative '../data/query_tuning_setup.rb'

# For this part of the project you'll be be asking yourself:
# TO QUERY OR NOT TO QUERY? 

# For that is the question!
# For each of the following problems you will try to write each
# problem WITH and WITHOUT subqueries, testing the efficiency
# of each query as you go. 

def frey_example
  # Find all the cats that are the same color as the cat named 'Freyja'.
  # Including 'Freyja' in the results.
  # DO NOT USE A SUBQUERY

  execute(<<-SQL)
    SELECT
      color_cats.name
    FROM
      cats AS freyja_cats
    JOIN
      cats AS color_cats ON freyja_cats.color = color_cats.color
    WHERE
      freyja_cats.name = 'Freyja';
  SQL
end

def frey_example_sub
  # Find all the cats that are the same color as the cat named 'Freyja'.
  # Including 'Freyja' in the results.

  # Using Explain you can see these queries are very similiar! Since our 
  # subquery is only performed on one table it is more efficient to use a subquery 
  # in this scenario instead of building the larger table.
  execute(<<-SQL)
    EXPLAIN
    SELECT
      cats.name
    FROM
      cats
    WHERE
      cats.color = (
                    SELECT  
                      cats.color
                    FROM
                      cats
                    WHERE
                      name = 'Freyja'
                    );
  SQL
end

def harder_example
  # Find the toys and price for all the cats with the 
  # breed 'British Shorthair'.
  # Order alphabetically by toys name. 
  # DO NOT USE A SUBQUERY

  # Whereas in this query it is more efficient to not perform a subquery 
  # because we don't have to do the extra cost of a large subquery.
  execute(<<-SQL)
    SELECT
      toys.name, toys.price
    FROM
      cats
    JOIN
      cattoys ON cats.id = cattoys.cat_id
    JOIN
      toys ON toys.id = cattoys.toy_id
    WHERE
      cats.breed = 'British Shorthair'
    ORDER BY
      toys.name ASC;
  SQL
end

def harder_example_sub
  # Find the toys and price for all the cats with the 
  # breed 'British Shorthair'.
  # Order alphabetically by toys name. 

  # USE A SUBQUERY
  execute(<<-SQL)
    SELECT
      toys.name, toys.price
    FROM
      toys
    WHERE 
      toys.id IN (SELECT
                    toys.id
                  FROM 
                    toys
                  JOIN 
                    cattoys ON toys.id = cattoys.toy_id
                  JOIN 
                    cats ON cats.id = cattoys.cat_id
                  WHERE
                    cats.breed = 'British Shorthair')
    ORDER BY
      toys.name ASC;
  SQL
end


def no_apples_for_blair
  # Blair has was too many apple toys! Find the name of all the cats that
  # own toys named `Apple` that aren't `Blair`. 
  # Order by cat name alphabetically.

  # DO NOT USE A SUBQUERY
  execute(<<-SQL)
  SELECT cats.name
  FROM cats
  JOIN cattoys ON cattoys.cat_id = cats.id
  JOIN toys ON toys.id = cattoys.toy_id
  WHERE toys.name = 'Apple' AND cats.name != 'Blair'
  ORDER BY cats.name;

  SQL
end


def no_apples_for_blair_sub
  # Blair has was too many apple toys! Find the name of all the cats that
  # own toys named `Apple` that aren't `Blair`. 
  # Order by cat name alphabetically.

  # USE A SUBQUERY
  execute(<<-SQL)
  SELECT cats.name
  FROM cats
  WHERE cats.id IN (
        SELECT cat_id
        FROM cattoys
        WHERE toy_id IN (
          SELECT id
          FROM toys
          WHERE toys.name = 'Apple'
        )
  ) AND cats.name != 'Blair'
  ORDER BY cats.name;

  SQL
end


def toys_that_brendon_owns
  # List the all the toy names for all the cats named 'Brendon'.
  # Order alphabetically by toy name. 

  # DO NOT USE A SUBQUERY
  execute(<<-SQL)
  SELECT toys.name
  FROM toys
  JOIN cattoys ON cattoys.toy_id = toys.id
  JOIN cats ON cattoys.cat_id = cats.id
  WHERE cats.name = 'Brendon'
  ORDER BY toys.name;
  SQL
end

def toys_that_brendon_owns_sub
  # List the all the toy names for all the cats named 'Brendon'.
  # Order alphabetically by toy name. 

  # USE A SUBQUERY
  execute(<<-SQL)
  SELECT toys.name
  FROM toys
  WHERE toys.id in (
    SELECT toy_id
    FROM cattoys
    WHERE cat_id in (
      SELECT cats.id
      FROM cats
      WHERE cats.name = 'Brendon'
    )
  )
  ORDER BY toys.name;
  SQL
end

def price_like_shiny_mouse
  # There are multiple 'Shiny Mouse' toys that all have different prices.
  # Your goal is to list all names and prices of the toys with the same prices 
  # as the different 'Shiny Mouse' toys. 

  # Exclude the 'Shiny Mouse' toy from your results.
  # Order your alphabetically by toy name.

  # DO NOT USE A SUBQUERY
  execute(<<-SQL) 
  SELECT others.name, shiny_mouse.price
  FROM toys AS shiny_mouse
  JOIN toys AS others ON shiny_mouse.price = others.price
  WHERE shiny_mouse.name = 'Shiny Mouse' AND others.name != 'Shiny Mouse';
  
  SQL
end

def price_like_shiny_mouse_sub
  # There are multiple 'Shiny Mouse' toys that all have different prices.
  # Your goal is to list all names and prices of the toys with the same prices 
  # as the different 'Shiny Mouse' toys. 

  # Exclude the 'Shiny Mouse' toy from your results.
  # Order your alphabetically by toy name.

  # USE A SUBQUERY
  execute(<<-SQL)
    SELECT toys.name, toys.price
    FROM toys
    WHERE toys.price in (
      SELECT toys.price
      FROM toys
      WHERE toys.name = 'Shiny Mouse'
    ) AND toys.name != 'Shiny Mouse'
    ORDER BY toys.name ASC;
  SQL
end

def just_like_orange
  # Find the breed of the cat named 'Orange'. 
  # Then list the cats names and the breed of all the cats of Orange's breed.
  # Exclude the cat named 'Orange' from your results.
  # Order by cats name alphabetically.

  # DO NOT USE A SUBQUERY
  execute(<<-SQL)
  SELECT breed.name, breed.breed
  FROM cats AS orange
  JOIN cats AS breed ON orange.breed = breed.breed
  WHERE orange.name = 'Orange' AND breed.name != 'Orange'
  ORDER BY breed.name ASC;
  SQL
end

def just_like_orange_sub
  # Find the breed of the cat named 'Orange'. 
  # Then list the cats names and the breed of all the cats of Orange's  breed.
  # Exclude the cat named 'Orange' from your results.
  # Order by cats name alphabetically.

  # USE A SUBQUERY
  execute(<<-SQL)
  SELECT cats.name, cats.breed
  FROM cats
  WHERE breed = (
    SELECT breed
    FROM cats
    WHERE name = 'Orange'
  ) AND name != 'Orange'
  ORDER BY name;
  SQL
end



def toys_that_jet_owns
  # Find all of the toys that Jet owns. Then list the the names of all 
  # the other cats that own those toys as well as the toys names.
  # Exclude Jet from the results.
  # Order alphabetically by cat name. 

  # DO NOT USE A SUBQUERY
  execute(<<-SQL)
    SELECT DISTINCT
      notjetcats.name, toys.name 
    FROM 
      toys 
    JOIN 
      cattoys as jetcatjoins ON toys.id = jetcatjoins.toy_id 
    JOIN 
      cats as jetcats ON jetcats.id = jetcatjoins.cat_id 
    JOIN 
      cattoys as notjetjoins ON toys.id = notjetjoins.toy_id 
    JOIN 
      cats as notjetcats ON notjetcats.id = notjetjoins.cat_id  
    WHERE 
      jetcats.name = 'Jet' AND notjetcats.name != 'Jet'
    ORDER BY
      notjetcats.name ASC;
  SQL
end

def toys_that_jet_owns_sub
  # Find all of the toys that Jet owns. Then list the the names of all 
  # the other cats that own those toys as well as the toys names.
  # Exclude Jet from the results.
  # Order alphabetically by cat name. 

  # USE A SUBQUERY
  execute(<<-SQL)
  SELECT cats.name, toys.name
  FROM toys 
  JOIN cattoys ON cattoys.toy_id = toys.id
  JOIN cats ON cattoys.cat_id = cats.id 
  WHERE cats.name != 'Jet' AND toys.id IN (
    SELECT id
    FROM toys
    WHERE toys.id in (
      SELECT toy_id
      FROM cattoys
      WHERE cat_id = (
        SELECT id
        FROM cats
        WHERE cats.name = 'Jet'
      )
    )
  )
  ORDER BY cats.name;
  SQL
end