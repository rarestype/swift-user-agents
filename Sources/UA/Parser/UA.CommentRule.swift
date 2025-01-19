import Grammar

extension UA
{
    struct CommentRule:ParsingRule
    {
        typealias Location = String.Index
        typealias Terminal = UInt8

        static func parse<Source>(
            _ input:inout ParsingInput<some ParsingDiagnostics<Source>>) throws -> [String]
            where Source:Collection<UInt8>, Source.Index == Location
        {
            try input.parse(as: UnicodeEncoding.ParenthesisLeft.self)

            /// Trailing semicolon is optional.
            var clauses:[String] = []
            while let next:String = input.parse(as: ClauseRule?.self)
            {
                clauses.append(next)

                guard case ()? = input.parse(as: Separator?.self)
                else
                {
                    break
                }
            }

            try input.parse(as: UnicodeEncoding.ParenthesisRight.self)

            return clauses
        }
    }
}
