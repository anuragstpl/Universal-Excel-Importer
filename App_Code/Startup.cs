using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(NetUtilities.Startup))]
namespace NetUtilities
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
