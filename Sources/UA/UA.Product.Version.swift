extension UA.Product
{
    @frozen public
    struct Version:RawRepresentable, Equatable, Hashable, Sendable
    {
        public
        let rawValue:String

        @inlinable public
        init(rawValue:String)
        {
            self.rawValue = rawValue
        }
    }
}
extension UA.Product.Version:CustomStringConvertible
{
    @inlinable public
    var description:String
    {
        self.rawValue.isEmpty ? "" : "/\(self.rawValue)"
    }
}
extension UA.Product.Version:ExpressibleByStringLiteral
{
    @inlinable public
    init(stringLiteral:String) { self.init(rawValue: stringLiteral) }
}
extension UA.Product.Version
{
    @inlinable public
    static func / (name:String, self:Self) -> UA.Product
    {
        .init(name: name, version: self)
    }
}
extension UA.Product.Version
{
    /// Returns the major version number, if one can be found.
    @inlinable public
    var major:Int?
    {
        .init(self.rawValue.prefix(while: { $0 != "." }))
    }
}
