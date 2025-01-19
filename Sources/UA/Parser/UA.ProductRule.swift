import Grammar

extension UA
{
    enum ProductRule:ParsingRule
    {
        typealias Location = String.Index
        typealias Terminal = UInt8

        static func parse<Source>(
            _ input:inout ParsingInput<some ParsingDiagnostics<Source>>) throws -> Product
            where Source:Collection<UInt8>, Source.Index == Location
        {
            let name:String = try input.parse(as: TokenRule.self)

            if  case ()? = input.parse(as: UnicodeEncoding.Slash?.self)
            {
                let version:String = try input.parse(as: TokenRule.self)
                return .init(name: name, version: .init(rawValue: version))
            }
            else
            {
                return .init(name: name)
            }
        }
    }
}
