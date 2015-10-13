

Given /^I am on the RottenPotatoes home page$/ do
  visit movies_path
 end


 When /^I have added a movie with title "(.*?)" and rating "(.*?)"$/ do |title, rating|
  visit new_movie_path
  fill_in 'Title', :with => title
  select rating, :from => 'Rating'
  click_button 'Save Changes'
 end

 Then /^I should see a movie list entry with title "(.*?)" and rating "(.*?)"$/ do |title, rating| 
   result=false
   all("tr").each do |tr|
     if tr.has_content?(title) && tr.has_content?(rating)
       result = true
       break
     end
   end  
  expect(result).to be_truthy
 end

 When /^I have visited the Details about "(.*?)" page$/ do |title|
   visit movies_path
   click_on "More about #{title}"
 end

 Then /^(?:|I )should see "([^"]*)$/ do |text|
    expect(page).to have_content(text)
 end

 When /^I have edited the movie "(.*?)" to change the rating to "(.*?)"$/ do |movie, rating|
  click_on "Edit"
  select rating, :from => 'Rating'
  click_button 'Update Movie Info'
 end



Given /the following movies have been added to RottenPotatoes:/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create movie
  end
end

When /^I have opted to see movies rated: "(.*?)"$/ do |arg1|
    arg1.split(',').each do |rating|
        check "ratings_#{rating.strip}"
    end
end

Then /^I should see only movies rated: "(.*?)"$/ do |arg1|
   arg1.split(',').each do |rating|
        page.body.should match(/<td>#{rating.strip}<\/td>/)
    end
end


Then /^I should see all of the movies$/ do
  movies = Movie.all
    if movies.size == 20
    movies.each do |movie|
      assert page.body =~ /#{movie.title}/m, "#{movie.title} did not appear"
    end
  else
    false
  end
end


When /^I click on "(.*)"/ do |link|
    click_on link
end

Then /^I should see "(.*)" before "(.*)"/ do |string1, string2|
    page.body.should match(/#{string1}.*#{string2}/m)
end




