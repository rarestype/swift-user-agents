import UA

extension UA.Google
{
    @frozen public
    enum CrawlerType:Equatable, Hashable, Sendable
    {
        case cloudVertexBot
        case extended
        case googlebot
        case googlebotImage
        case googlebotVideo
        case googlebotNews
        case inspectionTool
        case other
        case otherImage
        case otherVideo
        case storebot
    }
}
extension UA.Google.CrawlerType
{
    init?(prefix:Substring)
    {
        switch prefix
        {
        case "Google-CloudVertexBot":   self = .cloudVertexBot
        case "Google-Extended":         self = .extended
        case "Googlebot":               self = .googlebot
        case "Googlebot-Image":         self = .googlebotImage
        case "Googlebot-Video":         self = .googlebotVideo
        case "Googlebot-News":          self = .googlebotNews
        case "Google-InspectionTool":   self = .inspectionTool
        case "GoogleOther":             self = .other
        case "GoogleOther-Image":       self = .otherImage
        case "GoogleOther-Video":       self = .otherVideo
        case "Storebot-Google":         self = .storebot
        default:                        return nil
        }
    }
}
