# picked & tweaked from https://ronnieroller.com/Gollum
Gollum::Page.send :remove_const, :FORMAT_NAMES if defined? Gollum::Page::FORMAT_NAMES

# Specify the path to the Wiki.
gollum_path = '/home/wiki'
Precious::App.set(:gollum_path, gollum_path)

## Omni Auth
require 'omnigollum'
require 'omniauth/strategies/github'

## configs for Gollum
wiki_options = {
  :h1_title => true,
  :user_icons => 'gravatar',
  :live_preview => false,
  :allow_uploads => true,
  :per_page_uploads => true,
  :allow_editing => true,
  :mathjax => true,
  :emoji => true,
  :show_all => true
}
Precious::App.set(:wiki_options, wiki_options)

# Set as Sinatra environment as production (no stack traces)
Precious::App.set(:environment, :production)

options = {
  # OmniAuth::Builder block is passed as a proc
  :providers => Proc.new do
    # Found https://github.com/settings/applications/
    provider :github, ENV['CLIENT_ID'], ENV['CLIENT_SECRET']
  end,
  :dummy_auth => false,
  # protect all routes
  :protected_routes => [
    '*/private/*',
    '*/private',
    '*/revert/*',
    '*/revert',
    '*/create/*',
    '*/create',
    '*/edit/*',
    '*/edit',
    '*/history/*',
    '*/history',
    '*/latest_changes',
    '*/rename/*',
    '*/rename/',
    '*/upload/*',
    '*/upload/',
    '*/delete/*',
    '*/delete'],
  # Specify committer name as just the user name
  :author_format => Proc.new { |user| user.name },
  # Specify committer e-mail as just the user e-mail
  :author_email => Proc.new { |user| user.email },
  # Authorized users
  :authorized_users => ENV['AUTH_EMAILS'].split(","),
}

## :omnigollum options *must* be set before the Omnigollum extension is registered
Precious::App.set(:omnigollum, options)
Precious::App.register Omnigollum::Sinatra