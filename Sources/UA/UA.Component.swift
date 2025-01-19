extension UA
{
    @frozen public
    enum Component:Equatable, Hashable, Sendable
    {
        case product(String, Version? = nil)
        case comment([String])
    }
}

@_spi(testable)
extension UA.Component
{
    @inlinable public
    static func product(_ name:String, _ major:Int, _ minor:String? = nil) -> Self
    {
        .product(name, .numeric(major, minor))
    }

    @inlinable public
    static func comment(_ components:String...) -> Self
    {
        .comment(components)
    }
}
