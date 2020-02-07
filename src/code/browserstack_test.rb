require 'watir'

Before do
  $start_time = Time.now
end

After do |scenario|
  elapsed_seconds = Time.now - $start_time
  puts "Scenario execution duration: #{Time.at(elapsed_seconds).utc.strftime("%H:%M:%S")}"
  Browser.current.screenshot.save "potato.png" unless scenario.passed?
  Browser.close unless scenario.passed?
end

Given(/^I open a browser$/i) do
  Browser.open
end

Then(/^I close the browser$/) do
  Browser.close
end

And(/^I open browser "([^"]*)" on version "([^"]*)" with operative system "([^"]*)" version "([^"]*)"$/) do |browser,brVersion,os,osVersion|
  Browser.open_in_browserstack(browser: browser, browser_version: brVersion, os: os, os_version: osVersion)
end

Then(/^I go to the Google url$/) do
  Browser.current.goto 'https://google.com'
  sleep 3
end

And(/^I enter "([^"]*)" in the Google input field$/) do |value|
  input = Browser.current.element(:xpath, "(//input)[4]").to_subtype
  raise "Couldn't find Google input field" if input.nil?

  clear_input(input)
  input.send_keys(value)
  sleep(0.1)
end

Then(/^I take a screenshot$/) do
  Browser.current.screenshot.save "potato.png"
end

def clear_input(input)
  length = nil
  while input.value.length != length
    length = input.value.length
    input.send_keys :backspace
  end
end