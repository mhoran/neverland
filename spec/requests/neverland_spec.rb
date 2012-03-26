require 'spec_helper'

describe 'neverland' do
  it "should not insert the mock JavaScript on an unsuccessful response" do
    lambda { visit '/nonexistent' }.should raise_error(ActionController::RoutingError)

    page.should_not have_selector('head script[src="/javascripts/neverland.js"]')
  end

  it "should not raise an error if the response has no head" do
    lambda { visit '/decapitated' }.should_not raise_error

    page.should_not have_selector('head script[src="/javascripts/neverland.js"]')
  end

  it 'should not insert the mock JavaScript if the response has no head' do
    visit '/decapitated'

    page.should_not have_selector('head script[src="/javascripts/neverland.js"]')
  end

  it 'should insert the mock JavaScript on a successful response' do
    visit '/'

    page.should have_selector('head script[src="/javascripts/neverland.js"]')
    find('head script[src="/javascripts/neverland.js"]')['type'].should == 'text/javascript'
  end

  it 'should mock the default coordinates on a successful response', :js => true do
    visit '/'

    find('#latitude').should have_content('42.31283')
    find('#longitude').should have_content('-71.114287')
  end

  it 'should mock the provided coordinates on a successful response', :js => true do
    latitude = '37.2630556'
    longitude = '-115.7930198'
    visit root_path(:neverland => {:latitude => latitude, :longitude => longitude})

    find('#latitude').should have_content(latitude)
    find('#longitude').should have_content(longitude)
  end

  it 'should display Permission Denied when the location request is denied', :js => true do
    visit root_path(:neverland => {:error_code => 1})

    find('#error').should have_content('Permission Denied')
  end
end
