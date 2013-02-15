# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
  end
#  flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  #  flunk "Unimplemented"
  page.body.should match /#{e1}.*#{e2}/m
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|

  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(",").each do | rating |
    rating = "ratings_" + rating
    if uncheck
      uncheck(rating)
    else
      check(rating)
    end
  end
end

When /I (un)?check all the ratings$/ do |uncheck|
  Movie.all_ratings.each do |rating|
    rating = "ratings_" + rating
    if uncheck
      uncheck(rating)
    else
      check(rating)
    end
  end
end

Then /I should (not )?see movies rated: (.*)/ do |negation, rating_list|
  rating_list.split(",").each do |rating|
#    rating = "ratings_" + rating
#    puts rating
    if negation
      if page.respond_to? :should
        page.should have_no_xpath("//table[@id='#movies']/tbody/tr/td[2]", :text => rating)
      else
        assert page.has_no_xpath?("//table[@id='#movies']/tbody/tr/td[2]", :text => rating)
      end
    else
      if page.respond_to? :should
        page.should have_no_xpath("//table[@id='#movies']/tbody/tr/td[2]", :text => rating)
      else
        assert page.has_no_xpath?("//table[@id='#movies']/tbody/tr/td[2]", :text => rating)
      end
    end
  end
end


Then /I should see (.*) of the movies/ do |count|
  all_movies = Movie.find(:all).length
  if count == "none" or count == 0
    page.has_css?('tbody tr',:count => 0)
  elsif count == "all" or count == all_movies
    page.has_css?('tbody tr',:count => all_movies)
  else
    page.has_css?('tbody tr',:count => count)
  end
end


Then /the director of "(.*)" should be "(.*)"/ do |title, director|
  m = Movie.find_by_title(title)
  assert director == m.director
end

#When /^I check the following checkbox rating: 'PG', 'R'$/ do
#  pending # express the regexp above with the code you wish you had
  
#end
#
#  When /^I uncheck the following checkbox rating: 'G', 'PG\-(\d+)'$/ do |arg1|
#    pending # express the regexp above with the code you wish you had
#    end
#
#    Then /^I should see movies rated: PG, R$/ do
#      pending # express the regexp above with the code you wish you had
#      end
#
#      Then /^I should not see movies rated: G, PG\-(\d+)$/ do |arg1|
#        pending # express the regexp above with the code you wish you had
#        end
#
#        When /^I uncheck all the ratings$/ do
#          pending # express the regexp above with the code you wish you had
#          end
#
##          Then /^I should see none of the movies$/ do
#            pending # express the regexp above with the code you wish you had
#            end
#
#            When /^I check all the ratings$/ do
#              pending # express the regexp above with the code you wish you had
#              end
#
#              Then /^I should see all of the movies$/ do
#                pending # express the regexp above with the code you wish you had
#                end
#
