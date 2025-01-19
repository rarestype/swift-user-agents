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

do
{
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
}
