extension UA
{
    @frozen public
    enum Component:Equatable, Hashable, Sendable
    {
        case product(Product)
        case comment([String])
    }
}
extension UA.Component
{
    @inlinable public
    static func comment(_ clauses:String...) -> Self { .comment(clauses) }
}
