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
            if  let name:String = input.parse(as: TokenRule?.self)
            {
                return .product(name, input.parse(as: VersionRule?.self))
            }
            else
            {
                return .comment(try input.parse(as: CommentRule.self))
            }
        }
    }
}
