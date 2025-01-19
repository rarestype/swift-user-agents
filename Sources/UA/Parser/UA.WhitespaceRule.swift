import Grammar

extension UA
{
    enum WhitespaceRule:TerminalRule
    {
        typealias Location = String.Index
        typealias Terminal = UInt8
        typealias Construction = Void

        static
        func parse(terminal:UInt8) -> Void?
        {
            switch terminal
            {
            case 0x20:  () // ' '
            case 0x09:  () // '\t'
            case 0x0d:  () // '\r'
            case 0x0a:  () // '\n'
            default:    nil
            }
        }
    }
}
