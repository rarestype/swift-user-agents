import UA

extension UA
{
    @frozen public
    struct Google
    {
        public
        let chrome:ChromeVersion?
        public
        let type:CrawlerType

        @inlinable public
        init(chrome:ChromeVersion?, type:CrawlerType)
        {
            self.chrome = chrome
            self.type = type
        }
    }
}
extension UA.Google:UA.VendorFormat
{
    public
    init?(ua:borrowing UA)
    {
        var chrome:ChromeVersion?
        var type:CrawlerType?
        for component:UA.Component in ua.components
        {
            switch component
            {
            case .product(let product):
                if  case nil = chrome,
                    case "Chrome" = product.name,
                    case (let w, let x, let y, let z)? = product.version.quadruple
                {
                    chrome = .init(major: w, minor: x, build: y, patch: z)
                }
                //  This is a special case for very old Googlebot crawlers.
                else if
                    case nil = type,
                    let crawler:CrawlerType = .init(prefix: product.name.prefix { $0 != "/" })
                {
                    type = crawler
                }

            case .comment(let comment):
                guard case nil = type
                else
                {
                    continue
                }

                for clause:String in comment
                {
                    if  let crawler:CrawlerType = .init(prefix: clause.prefix { $0 != "/" })
                    {
                        type = crawler
                        break
                    }
                }
            }
        }

        guard
        let type:CrawlerType
        else
        {
            return nil
        }

        self.init(chrome: chrome, type: type)
    }
}
