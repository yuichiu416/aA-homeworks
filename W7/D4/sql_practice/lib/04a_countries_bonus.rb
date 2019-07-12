# == Schema Information
#
# Table name: countries
#
#  name        :string       not null, primary key
#  continent   :string
#  area        :integer
#  population  :integer
#  gdp         :integer

require_relative './sqlzoo.rb'

# BONUS QUESTIONS: These problems require knowledge of aggregate
# functions. Attempt them after completing section 05.

def highest_gdp
  # Which countries have a GDP greater than every country in Europe? (Give the
  # name only. Some countries may have NULL gdp values)
  
  #part 1: pull out the country in EU that has the highest GDP
  #part 2: pull out all countries that has higher GDP than the country
  execute(<<-SQL)
  SELECT *
  FROM countries
  WHERE gdp > (
    SELECT gdp
    FROM countries
    WHERE GDP > 0 AND continent = 'Europe'
    ORDER BY GDP DESC
    LIMIT 1
  );

  SELECT max(gdp) AS MaxPrice
  FROM countries
  WHERE continent = 'Europe';

  SELECT gdp
  FROM countries
  WHERE continent = 'Europe'
  AND gdp >= MaxPrice
  ORDER BY gdp ASC;
  # 
  SQL
end

def largest_in_continent
  # Find the largest country (by area) in each continent. Show the continent,
  # name, and area.
  execute(<<-SQL)
  SELECT c1.continent, c1.name, c1.area
  FROM countries as c1
  WHERE c1.area = (
    SELECT MAX(c2.area)
    FROM countries as c2
    WHERE c1.continent = c2.continent
  ) ;
  
  SQL
end

def large_neighbors
  # Some countries have populations more than three times that of any of their
  # neighbors (in the same continent). Give the countries and continents.
  execute(<<-SQL)
  SELECT name, continent
  FROM countries AS c1
  WHERE c1.population >= 3 * (
    SELECT MAX(population) 
    FROM countries AS c2
    WHERE c1.name != c2.name AND c1.continent = c2.continent
  );
  SQL
end
