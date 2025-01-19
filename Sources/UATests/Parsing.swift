import Testing
@_spi(testable) import UA

@Suite
struct Parsing
{
    @Test
    static func iPhoneSafari() throws
    {
        let parsed:UA = try #require(.init("""
            Mozilla/5.0 (iPhone; CPU iPhone OS 17_1_2 like Mac OS X) \
            AppleWebKit/605.1.15 (KHTML, like Gecko) \
            Version/17.1.2 Mobile/15E148 Safari/604.1
            """))
        #expect(parsed == [
                .product("Mozilla" / "5.0"),
                .comment("iPhone", "CPU iPhone OS 17_1_2 like Mac OS X"),
                .product("AppleWebKit" / "605.1.15"),
                .comment("KHTML, like Gecko"),
                .product("Version" / "17.1.2"),
                .product("Mobile" / "15E148"),
                .product("Safari" / "604.1"),
            ])
    }
    @Test
    static func macSafariWithPrivacyGuard() throws
    {
        let parsed:UA = try #require(.init("""
            Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) \
            AppleWebKit/605.1.15 (KHTML, like Gecko) \
            Version/14.0 Safari/605.1.15
            """))
        #expect(parsed == [
                .product("Mozilla" / "5.0"),
                .comment("Macintosh", "Intel Mac OS X 10_15_7"),
                .product("AppleWebKit" / "605.1.15"),
                .comment("KHTML, like Gecko"),
                .product("Version" / "14.0"),
                .product("Safari" / "605.1.15"),
            ])
    }
    @Test
    static func Bingbot() throws
    {
        let parsed:UA = try #require(.init("""
            Mozilla/5.0 AppleWebKit/537.36 \
            (KHTML, like Gecko; compatible; bingbot/2.0; \
            +http://www.bing.com/bingbot.htm) \
            Chrome/103.0.5060.134 Safari/537.36
            """))
        #expect(parsed == [
                .product("Mozilla" / "5.0"),
                .product("AppleWebKit" / "537.36"),
                .comment(
                    "KHTML, like Gecko",
                    "compatible",
                    "bingbot/2.0",
                    "+http://www.bing.com/bingbot.htm"),
                .product("Chrome" / "103.0.5060.134"),
                .product("Safari" / "537.36"),
            ])
    }
    @Test
    static func Slurpbot() throws
    {
        let parsed:UA = try #require(.init("""
            Mozilla/5.0 \
            (compatible; Yahoo! Slurp; http://help.yahoo.com/help/us/ysearch/slurp)
            """))
        #expect(parsed == [
                .product("Mozilla" / "5.0"),
                .comment(
                    "compatible",
                    "Yahoo! Slurp",
                    "http://help.yahoo.com/help/us/ysearch/slurp"),
            ])
    }
    @Test
    static func Edge() throws
    {
        let parsed:UA = try #require(.init("""
            Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 \
            (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36 Edg/116.0.1938.76
            """))
        #expect(parsed == [
                .product("Mozilla" / "5.0"),
                .comment("Windows NT 10.0", "Win64", "x64"),
                .product("AppleWebKit" / "537.36"),
                .comment("KHTML, like Gecko"),
                .product("Chrome" / "116.0.0.0"),
                .product("Safari" / "537.36"),
                .product("Edg" / "116.0.1938.76"),
            ])
    }
    @Test
    static func Censys() throws
    {
        let parsed:UA = try #require(.init("""
            Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)
            """))
        #expect(parsed == [
                .product("Mozilla" / "5.0"),
                .comment("compatible", "CensysInspect/1.1", "+https://about.censys.io/"),
            ])
    }
    @Test
    static func TikTok() throws
    {
        let parsed:UA = try #require(.init("""
            Mozilla/5.0 (Linux; Android 5.0) AppleWebKit/537.36 (KHTML, like Gecko) \
            Mobile Safari/537.36 (compatible; Bytespider; spider-feedback@bytedance.com)
            """))
        #expect(parsed == [
                .product("Mozilla" / "5.0"),
                .comment("Linux", "Android 5.0"),
                .product("AppleWebKit" / "537.36"),
                .comment("KHTML, like Gecko"),
                .product("Mobile" / ""),
                .product("Safari" / "537.36"),
                .comment(
                    "compatible",
                    "Bytespider",
                    "spider-feedback@bytedance.com"),
            ])
    }
    @Test
    static func Semrush() throws
    {
        let parsed:UA = try #require(.init("""
            Mozilla/5.0 (compatible; SemrushBot/7~bl; +http://www.semrush.com/bot.html)
            """))
        #expect(parsed == [
                .product("Mozilla" / "5.0"),
                .comment(
                    "compatible",
                    "SemrushBot/7~bl",
                    "+http://www.semrush.com/bot.html"),
            ])
    }
    @Test
    static func PixelImposter() throws
    {
        let parsed:UA = try #require(.init("""
            Mozilla/5.0 (Linux; Android 8.0; Pixel 2 Build/OPD3.170816.012) \
            AppleWebKit/537.36 (KHTML, like Gecko) \
            Chrome/47.0.1610.1769 Mobile Safari/537.36
            """))
        #expect(parsed == [
                .product("Mozilla" / "5.0"),
                .comment("Linux", "Android 8.0", "Pixel 2 Build/OPD3.170816.012"),
                .product("AppleWebKit" / "537.36"),
                .comment("KHTML, like Gecko"),
                .product("Chrome" / "47.0.1610.1769"),
                .product("Mobile" / ""),
                .product("Safari" / "537.36"),
            ])
    }
    @Test
    static func iPhoneImposter() throws
    {
        let parsed:UA = try #require(.init("""
            Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/537.36 \
            (KHTML, like Gecko) Chrome/53.0.2012.1059 Mobile Safari/537.36
            """))
        #expect(parsed == [
                .product("Mozilla" / "5.0"),
                .comment("iPhone", "CPU iPhone OS 11_0 like Mac OS X"),
                .product("AppleWebKit" / "537.36"),
                .comment("KHTML, like Gecko"),
                .product("Chrome" / "53.0.2012.1059"),
                .product("Mobile" / ""),
                .product("Safari" / "537.36"),
            ])
    }
    @Test
    static func WindowsImposter() throws
    {
        let parsed:UA = try #require(.init("""
            Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 \
            (KHTML, like Gecko) Chrome/76.0.2822.46 Safari/537.36
            """))
        #expect(parsed == [
                .product("Mozilla" / "5.0"),
                .comment("Windows NT 6.3", "Win64", "x64"),
                .product("AppleWebKit" / "537.36"),
                .comment("KHTML, like Gecko"),
                .product("Chrome" / "76.0.2822.46"),
                .product("Safari" / "537.36"),
            ])
    }
}
