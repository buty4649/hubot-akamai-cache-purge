# hubot-akamai-cache-purge

A hubot script that provides purge edge content

See [`src/akamai-cache-purge.coffee`](src/akamai-cache-purge.coffee) for full documentation.

## Installation

In hubot project repo, run:

`npm install hubot-akamai-cache-purge --save`

Then add **hubot-akamai-cache-purge** to your `external-scripts.json`:

```json
[
  "hubot-akamai-cache-purge"
]
```

## Sample Interaction

```
user1>> hubot akamai purge cache http://example.com/path/to/contents.jpg
hubot>> Success: estimated time 5 sec
```

## Configuration

This script need api credentials.
see. https://developer.akamai.com/introduction/Prov_Creds.html

* `HUBOT_AKAMAI_CLIENT_SECRET`
* `HUBOT_AKAMAI_HOST`
* `HUBOT_AKAMAI_ACCESS_TOKEN`
* `HUBOT_AKAMAI_CLIENT_TOKEN`
