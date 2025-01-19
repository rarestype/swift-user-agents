<div align="center">

***`user-agents`***

[![Tests](https://github.com/tayloraswift/swift-user-agents/actions/workflows/Tests.yml/badge.svg)](https://github.com/tayloraswift/swift-user-agents/actions/workflows/Tests.yml)
[![Documentation](https://github.com/tayloraswift/swift-user-agents/actions/workflows/Documentation.yml/badge.svg)](https://github.com/tayloraswift/swift-user-agents/actions/workflows/Documentation.yml)

</div>

The ***swift-user-agents*** library dedicated to parsing the `user-agent` HTTP header field, and matching it against formats of known vendors.

<div align="center">

[documentation](https://swiftinit.org/docs/swift-user-agents) ·
[license](LICENSE)

</div>


## Requirements

The swift-user-agents library requires Swift 6.0 or later.


| Platform | Status |
| -------- | ------ |
| 🐧 Linux | [![Tests](https://github.com/tayloraswift/swift-user-agents/actions/workflows/Tests.yml/badge.svg)](https://github.com/tayloraswift/swift-user-agents/actions/workflows/Tests.yml) |
| 🍏 Darwin | [![Tests](https://github.com/tayloraswift/swift-user-agents/actions/workflows/Tests.yml/badge.svg)](https://github.com/tayloraswift/swift-user-agents/actions/workflows/Tests.yml) |
| 🍏 Darwin (iOS) | [![iOS](https://github.com/tayloraswift/swift-user-agents/actions/workflows/iOS.yml/badge.svg)](https://github.com/tayloraswift/swift-user-agents/actions/workflows/iOS.yml) |
| 🍏 Darwin (tvOS) | [![tvOS](https://github.com/tayloraswift/swift-user-agents/actions/workflows/tvOS.yml/badge.svg)](https://github.com/tayloraswift/swift-user-agents/actions/workflows/tvOS.yml) |
| 🍏 Darwin (visionOS) | [![visionOS](https://github.com/tayloraswift/swift-user-agents/actions/workflows/visionOS.yml/badge.svg)](https://github.com/tayloraswift/swift-user-agents/actions/workflows/visionOS.yml) |
| 🍏 Darwin (watchOS) | [![watchOS](https://github.com/tayloraswift/swift-user-agents/actions/workflows/watchOS.yml/badge.svg)](https://github.com/tayloraswift/swift-user-agents/actions/workflows/watchOS.yml) |


[Check deployment minimums](https://swiftinit.org/docs/swift-user-agents#ss:platform-requirements)


## What are User Agents?

A user agent is a string that an HTTP client sends to a web server to identify itself. User agent strings are completely controlled by the client, and cannot be trusted on their own.

A “typical” iOS Safari user agent with privacy protections enabled resembles this:

```
Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7)
AppleWebKit/605.1.15 (KHTML, like Gecko)
Version/18.1.1 Safari/605.1.15
```

Bad actors often forge user agents to mimic legitimate clients. The following is a fradulent iOS user agent string that was captured from a bot operating in January 2025:

```
Mozilla/5.0 (iPhone; CPU iPhone OS 16_6 like Mac OS X)
AppleWebKit/605.1.15 (KHTML, like Gecko)
Version/16.6 Mobile/15E148 Safari/604.1
```

### Impersonation of Human Users

The most common economic purpose for impersonating human users is to scrape data from websites in order to perform sentiment analysis for predicting changes in stock prices. AI model training is also a rapidly growing motivator for fradulent web scraping.

Economic attrition is another use case for user agent spoofing. For example, a business can heavily scrape a competitor’s website to drive up their hosting costs. Unlike DoS attacks, the goal is usually not to take the website offline, but to simply make it more expensive to operate. Sadly, this type of attack is rarely prosecuted due to the high costs of collecting the necessary evidence to prove that an attack even occurred.


### Impersonation of Robotic Users

Human users also occasionally spoof their user agents to impersonate bots. One common use case is to send a user agent string that resembles Googlebot or Bingbot to bypass paywalls, as most newspapers explicitly whitelist search engine crawlers. However, this is almost always done on an individual basis and there are very few industrial-scale applications for this behavior. Therefore, there is rarely a need to worry about this type of spoofing.


## Isn’t this Cloudflare’s Job?

Cloudflare can only protect you against the scraping of static content. If you have any type of dynamic content on your website, you will pay for data transfer from your hosting provider (e.g. AWS) to Cloudflare, even though the transfer from Cloudflare to the client is free.

This means that if one robot requests a 1 MB dynamic page once every second for a month, you will pay for approximately 2.6 TB of outgoing data transfer to Cloudflare.

Keep in mind that data transfer in from the internet to AWS is **free and unlimited**, which means there are effectively **no economic constraints** on this type of attack from the perspective of the bot operator. Thus, industry standard pricing structures currently strongly favor the attacker over the defender.


## What can this library do for me?

User agent parsing by itself is not a security feature. To provide security value, it must be used in conjunction with [IP verification](https://github.com/tayloraswift/swift-ip).

This library implements a general user agent parser that extracts information from user agent strings that follow the [standard RFC9110 browser format](https://stackoverflow.com/questions/2601372/what-is-the-standard-format-for-a-browsers-user-agent-string). You could use this to inspect the version numbers of the various technologies referenced in the user agent string, which is a historically effective discriminator between legitimate and fradulent user agents.

Because you cannot reliably discriminate on “version scores” alone, to apply this as a meaningful security strategy, you would aggregate statistics about the trustworthiness of user agents originating from IP autonomous systems, and use that information to rate the trustworthiness of those IP ranges. You would then apply access policies based on the IP addresses, rather than the user agents themselves.


### Throttling specific technologies from Known Vendors

Although not malicious, some organizations deploy software that is known to be particularly resource-intensive. One example is the [GoogleOther](https://developers.google.com/search/docs/crawling-indexing/google-common-crawlers) crawler, which (as of January 2025) does not respect robots.txt and is believed to be the intake mechanism for Google’s AI training operations.

Since GoogleOther originates from official Google IP addresses, which it shares with the beneficial [Googlebot](https://developers.google.com/search/docs/crawling-indexing/googlebot) crawler, you cannot block GoogleOther by IP address without also blocking Googlebot. Therefore, you must inspect the user agent string to determine what type of Google client is accessing your website.

This library provides the [`UA.Google`](https://swiftinit.org/docs/swift-user-agents/ua/ua/google) type, which can be used to distinguish between various Google clients.

Parsers for other known vendors are WIP.


## Show me the code!

```swift
import CommonAgents
import UA

func detect(userAgent:String)
{
    guard
    let crawler:UA.Google = .init(detecting: userAgent)
    else
    {
        print("Not a Google Crawler")
        return
    }

    if  case .googlebot = crawler.type,
        let chrome:UA.Google.ChromeVersion = crawler.chrome
    {
        print("This is a Googlebot (Chrome/\(chrome))")
    }
    else if
        case .other = crawler.type,
        let chrome:UA.Google.ChromeVersion = crawler.chrome
    {
        print("This is an AI data harvester (Chrome/\(chrome))")
    }
    else
    {
        print("This some other Google script")
    }
}

let userAgent:(String, String)

userAgent.0 = """
Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) \
AppleWebKit/537.36 (KHTML, like Gecko) \
Chrome/132.0.6834.83 Mobile Safari/537.36 \
(compatible; Googlebot/2.1; +http://www.google.com/bot.html)
"""

userAgent.1 = """
Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) \
AppleWebKit/537.36 (KHTML, like Gecko) \
Chrome/132.0.6834.83 Mobile Safari/537.36 \
(compatible; GoogleOther)
"""

detect(userAgent: userAgent.0)
detect(userAgent: userAgent.1)
```

## License

The swift-user-agents library is Apache 2.0 licensed.
