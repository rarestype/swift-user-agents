import Grammar

extension UA
{
    enum ComponentRule:ParsingRule
    {
        typealias Location = String.Index
        typealias Terminal = UInt8

        static func parse<Source>(
            _ input:inout ParsingInput<some ParsingDiagnostics<Source>>) throws -> Component
            where Source:Collection<UInt8>, Source.Index == Location
        {
            if  let comment:[String] = input.parse(as: CommentRule?.self)
            {
                return .comment(comment)
            }
            else
            {
                return .product(try input.parse(as: ProductRule.self))
            }
        }
    }
}
