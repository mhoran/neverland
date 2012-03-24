require 'spec_helper'

describe 'neverland' do
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
    visit '/'
    cookie 'mock_latitude', '37.2630556'
    cookie 'mock_longitude', '-115.7930198'

    visit '/'

    find('#latitude').should have_content('37.2630556')
    find('#longitude').should have_content('-115.7930198')
  end

  it "should not mock on an error response" do
    lambda { visit '/nonexistent' }.should raise_error(ActionController::RoutingError)

    page.should_not have_selector('head script[src="/javascripts/neverland.js"]')
  end
end

def cookie(name, value)
  Capybara.current_session.driver.browser.manage.add_cookie(:name => name, :value => value)
end
