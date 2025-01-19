import Grammar

extension UA
{
    enum HeaderRule:ParsingRule
    {
        typealias Location = String.Index
        typealias Terminal = UInt8

        static func parse<Source>(
            _ input:inout ParsingInput<some ParsingDiagnostics<Source>>) throws -> [Component]
            where Source:Collection<UInt8>, Source.Index == Location
        {
            try input.parse(as: Pattern.Join<ComponentRule, Separator, [Component]>.self)
        }
    }
}
