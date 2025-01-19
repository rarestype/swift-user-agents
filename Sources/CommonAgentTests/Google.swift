import CommonAgents
import Testing
import UA

@Suite
struct Google
{
    @Test
    static func Googlebot1() throws
    {
        let crawler:UA.Google = try #require(.init(detecting: """
            Mozilla/5.0 AppleWebKit/537.36 \
            (KHTML, like Gecko; compatible; Googlebot/2.1; +http://www.google.com/bot.html) \
            Chrome/132.0.6834.83 Safari/537.36
            """))
        let chrome:UA.Google.ChromeVersion = try #require(crawler.chrome)
        #expect(chrome.components == (132, 0, 6834, 83))
        #expect(crawler.type == .googlebot)
    }
    @Test
    static func Googlebot2() throws
    {
        let crawler:UA.Google = try #require(.init(detecting: """
            Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)
            """))
        #expect(crawler.chrome == nil)
        #expect(crawler.type == .googlebot)
    }
    @Test
    static func Googlebot3() throws
    {
        let crawler:UA.Google = try #require(.init(detecting: """
            Googlebot/2.1 (+http://www.google.com/bot.html)
            """))
        #expect(crawler.chrome == nil)
        #expect(crawler.type == .googlebot)
    }
    @Test
    static func GooglebotMobile() throws
    {
        let crawler:UA.Google = try #require(.init(detecting: """
            Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) \
            AppleWebKit/537.36 (KHTML, like Gecko) \
            Chrome/132.0.6834.83 Mobile Safari/537.36 \
            (compatible; Googlebot/2.1; +http://www.google.com/bot.html)
            """))
        let chrome:UA.Google.ChromeVersion = try #require(crawler.chrome)
        #expect(chrome.components == (132, 0, 6834, 83))
        #expect(crawler.type == .googlebot)
    }

    @Test
    static func Storebot() throws
    {
        let crawler:UA.Google = try #require(.init(detecting: """
            Mozilla/5.0 (X11; Linux x86_64; Storebot-Google/1.0) \
            AppleWebKit/537.36 (KHTML, like Gecko) \
            Chrome/132.0.6834.83 Safari/537.36
            """))
        let chrome:UA.Google.ChromeVersion = try #require(crawler.chrome)
        #expect(chrome.components == (132, 0, 6834, 83))
        #expect(crawler.type == .storebot)
    }
    @Test
    static func StorebotMobile() throws
    {
        let crawler:UA.Google = try #require(.init(detecting: """
            Mozilla/5.0 \
            (Linux; Android 8.0; Pixel 2 Build/OPD3.170816.012; Storebot-Google/1.0) \
            AppleWebKit/537.36 (KHTML, like Gecko) \
            Chrome/132.0.6834.83 Mobile Safari/537.36
            """))
        let chrome:UA.Google.ChromeVersion = try #require(crawler.chrome)
        #expect(chrome.components == (132, 0, 6834, 83))
        #expect(crawler.type == .storebot)
    }

    @Test
    static func InspectionTool() throws
    {
        let crawler:UA.Google = try #require(.init(detecting: """
            Mozilla/5.0 (compatible; Google-InspectionTool/1.0;)
            """))
        #expect(crawler.chrome == nil)
        #expect(crawler.type == .inspectionTool)
    }
    @Test
    static func InspectionToolMobile() throws
    {
        let crawler:UA.Google = try #require(.init(detecting: """
            Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) \
            AppleWebKit/537.36 (KHTML, like Gecko) \
            Chrome/132.0.6834.83 Mobile Safari/537.36 \
            (compatible; Google-InspectionTool/1.0;)
            """))
        let chrome:UA.Google.ChromeVersion = try #require(crawler.chrome)
        #expect(chrome.components == (132, 0, 6834, 83))
        #expect(crawler.type == .inspectionTool)
    }

    @Test
    static func GoogleOther() throws
    {
        let crawler:UA.Google = try #require(.init(detecting: """
            Mozilla/5.0 AppleWebKit/537.36 \
            (KHTML, like Gecko; compatible; GoogleOther) \
            Chrome/132.0.6834.83 Safari/537.36
            """))
        let chrome:UA.Google.ChromeVersion = try #require(crawler.chrome)
        #expect(chrome.components == (132, 0, 6834, 83))
        #expect(crawler.type == .other)
    }
    @Test
    static func GoogleOtherMobile() throws
    {
        let crawler:UA.Google = try #require(.init(detecting: """
            Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) \
            AppleWebKit/537.36 (KHTML, like Gecko) \
            Chrome/132.0.6834.83 Mobile Safari/537.36 \
            (compatible; GoogleOther)
            """))
        let chrome:UA.Google.ChromeVersion = try #require(crawler.chrome)
        #expect(chrome.components == (132, 0, 6834, 83))
        #expect(crawler.type == .other)
    }

    @Test
    static func GoogleOtherImage() throws
    {
        let crawler:UA.Google = try #require(.init(detecting: """
            GoogleOther-Image/1.0
            """))
        #expect(crawler.chrome == nil)
        #expect(crawler.type == .otherImage)
    }

    @Test
    static func GoogleOtherVideo() throws
    {
        let crawler:UA.Google = try #require(.init(detecting: """
            GoogleOther-Video/1.0
            """))
        #expect(crawler.chrome == nil)
        #expect(crawler.type == .otherVideo)
    }

    @Test
    static func GoogleCloudVertexBot() throws
    {
        let crawler:UA.Google = try #require(.init(detecting: """
            Google-CloudVertexBot
            """))
        #expect(crawler.chrome == nil)
        #expect(crawler.type == .cloudVertexBot)
    }
}
