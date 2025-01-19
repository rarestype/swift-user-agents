import UA

extension UA.Google
{
    /// A version of [Google Chrome](https://www.chromium.org/developers/version-numbers/).
    ///
    /// The format may be slightly surprising to those used to semantic versioning; the third
    /// component is the build number, and the fourth component is the patch number.
    @frozen public
    struct ChromeVersion
    {
        public
        var major:Int
        public
        var minor:Int
        public
        var build:Int
        public
        var patch:Int

        @inlinable public
        init(major:Int, minor:Int, build:Int, patch:Int)
        {
            self.major = major
            self.minor = minor
            self.build = build
            self.patch = patch
        }
    }
}
extension UA.Google.ChromeVersion
{
    @inlinable public
    var components:(Int, Int, Int, Int) { (self.major, self.minor, self.build, self.patch) }
}
