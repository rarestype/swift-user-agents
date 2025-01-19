extension UA
{
    @frozen public
    struct Product:Equatable, Hashable, Sendable
    {
        public
        let name:String
        public
        let version:Version

        @inlinable
        init(name:String, version:Version = "")
        {
            self.name = name
            self.version = version
        }
    }
}
extension UA.Product:CustomStringConvertible
{
    @inlinable public
    var description:String { "\(self.name)\(self.version)" }
}
