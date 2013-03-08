# TwitterFilter

## DESCRIPTION

TwitterFilter helps you access all the Tweets you want and nothing but those Tweets.

## REQUIREMENTS

TwitterFilter is a Ruby gem, so you will need to install it and its dependencies.

You must also save your Twitter OAuth credentials in a YAML file with contents like this fake example:

    ---
    consumer_key: Id254ZAzQJtF7ltUerYPw
    consumer_secret: fSuNNvlairlesqGDnasde58zib3hApHMTUnZ0J94jmw
    oauth_token: 938572174-ByY7Plbe1J4Dp5JSwZjmPowBwOr2VVjLA2Juxeqp
    oauth_token_secret: PrRwQVOgO2Sg0r4IOJPwQq95IqHieZeEnemxkiHKw

See [Twitter's GET oauth/authenticate page](https://dev.twitter.com/docs/api/1/get/oauth/authenticate) for instructions on getting your own credentials.

## USAGE

You create a GetTweets object by passing in the path to your Twitter OAuth credentials YAML file:

    gt = GetTweets.new(config_file_path)

You can then use your GetTweets object to get a random array of Tweets. To get an array with 30 Tweets:

    tweets = gt.sample(30)

If you just wish to get the array without also seeing each one, you can pass `{display: false}`:

    tweets = gt.sample(30, display: false)

## LEGAL DISCLAIMER

You use TwitterFilter at your own risk. I make no warrantees about anything relating to TwitterFilter.
