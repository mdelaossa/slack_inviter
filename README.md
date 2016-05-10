# slack_inviter
Quick inviter for Slack

## Usage
- Clone the repo
- rename `config.yml.dist` to `config.yml`
- edit config.yml, add your team name, api key, and channels you want your users to join
- run `bundler install`
- start the server by running `rackup config.ru -p PORT` (you can omit
  -p, it'll default to port 9292)

### How to get a Slack API Token
- Visit https://api.slack.com/docs/oauth-test-tokens and generate a test token

### How to get Channel IDs
```
curl -X POST 'https://YOURTEAM.slack.com/api/channels.list' --data 'token=YOUR SLACK TOKEN' --compressed
```
