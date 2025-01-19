import Testing
import UA

@Suite
struct Google
{
    @Test
    static func GooglebotMobile() throws
    {
        """
        Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) \
        AppleWebKit/537.36 (KHTML, like Gecko) \
        Chrome/132.0.6834.83 Mobile Safari/537.36 \
        (compatible; Googlebot/2.1; +http://www.google.com/bot.html)
        """
    }

    @Test
    static func Googlebot1() throws
    {
        """
        Mozilla/5.0 AppleWebKit/537.36 \
        (KHTML, like Gecko; compatible; Googlebot/2.1; +http://www.google.com/bot.html) \
        Chrome/132.0.6834.83 Safari/537.36
        """
    }
    @Test
    static func Googlebot2() throws
    {
        """
        Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)
        """
    }
    @Test
    static func Googlebot3() throws
    {
        """
        Googlebot/2.1 (+http://www.google.com/bot.html)
        """
    }

    @Test
    static func GoogleOtherMobile() throws
    {
        """
        Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) \
        AppleWebKit/537.36 (KHTML, like Gecko) \
        Chrome/132.0.6834.83 Mobile Safari/537.36 \
        (compatible; GoogleOther)
        """
    }
    @Test
    static func GoogleOther() throws
    {
        """
        Mozilla/5.0 AppleWebKit/537.36 \
        (KHTML, like Gecko; compatible; GoogleOther) \
        Chrome/132.0.6834.83 Safari/537.36
        """
    }
}
