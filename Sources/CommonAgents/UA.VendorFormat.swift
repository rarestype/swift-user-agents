import UA

extension UA
{
    public
    protocol VendorFormat
    {
        init?(ua:borrowing UA)
    }
}
extension UA.VendorFormat
{
    @inlinable public
    init?(detecting string:Substring)
    {
        guard
        let ua:UA = .init(string)
        else
        {
            return nil
        }

        self.init(ua: ua)
    }

    @inlinable public
    init?(detecting string:String)
    {
        guard
        let ua:UA = .init(string)
        else
        {
            return nil
        }

        self.init(ua: ua)
    }
}
