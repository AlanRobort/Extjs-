using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace test
{
    public partial class test : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var action = Request["action"]; //外部请求
            if (action != null)
            {
                if (action == "add")
                {
                    Add();
                }
            }
        }

        private void Add()
        {
            string name = Request["name"];
            string strResult = "{success:true,msg:'" + name + "'}";

            Response.Write(strResult);
            Response.End();
        }


    }
}