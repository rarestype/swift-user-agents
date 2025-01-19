import UA

extension UA.Product.Version
{
    public
    var quadruple:(Int, Int, Int, Int)?
    {
        let string:String = self.rawValue
        var i:String.Index = string.startIndex

        guard
        let w:String.Index = string[i...].firstIndex(of: "."),
        let wc:Int = .init(string[i ..< w])
        else
        {
            return nil
        }

        i = string.index(after: w)

        guard
        let x:String.Index = string[i...].firstIndex(of: "."),
        let xc:Int = .init(string[i ..< x])
        else
        {
            return nil
        }

        i = string.index(after: x)

        guard
        let y:String.Index = string[i...].firstIndex(of: "."),
        let yc:Int = .init(string[i ..< y])
        else
        {
            return nil
        }

        i = string.index(after: y)

        guard
        let zc:Int = .init(string[i...])
        else
        {
            return nil
        }

        return (wc, xc, yc, zc)
    }
}
