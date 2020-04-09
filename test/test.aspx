<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="test.aspx.cs" Inherits="test.test" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <!-- 这里是extjs的文件引用 -->
    <script type="text/javascript" src="Script/Extjs/ext-all.js"></script>
    <script type="text/javascript" src="Scripts/Shared/extensible-all.js"></script>
    <script type="text/javascript" src="Scripts/Shared/extensible-lang-zh_CN.js"></script>
    <link href="Content/theme/ext-theme-neptune/ext-theme-neptune-all-debug.css" rel="stylesheet" />
    <!-- extjs文件引用结束咯 -->


    <script type="text/javascript">
        //Ext.onReady(function () {
        //    Ext.MessageBox.alert('标题', 'hello world !');
        //});
        Ext.onReady(function () {
            Ext.create('Ext.data.Store', {
                storeId: 'simpsonsStore',
                fields: ['name', 'email', 'phone'],
                data: {
                    'items': [
                        { 'name': 'Lisa', "email": "lisa@simpsons.com", "phone": "555-111-1224" },
                        { 'name': 'Bart', "email": "bart@simpsons.com", "phone": "555-222-1234" },
                        { 'name': 'Homer', "email": "home@simpsons.com", "phone": "555-222-1244" },
                        { 'name': 'Marge', "email": "marge@simpsons.com", "phone": "555-222-1254" }
                    ]
                },
                proxy: {
                    type: 'memory',
                    reader: {
                        type: 'json',
                        root: 'items'
                    }
                }
            });

            Ext.create('Ext.grid.Panel', {
                layout: "fit",
                border: false,
                title: 'test',
                store: Ext.data.StoreManager.lookup('simpsonsStore'),
                selModel: {
                    injectCheckbox: 0,
                    mode: "SIMPLE",     //"SINGLE"/"SIMPLE"/"MULTI"
                    checkOnly: true     //只能通过checkbox选择
                },
                selType: "checkboxmodel",
                columns: [
                    { text: 'Name', dataIndex: 'name', flex: 1 },
                    { text: 'Email', dataIndex: 'email', flex: 1 },
                    { text: 'Phone', dataIndex: 'phone', flex: 2 }
                ],
                listeners: {
                    itemdblclick: function (me, record, item, index, e, eOpts) {
                        //双击事件的操作
                    }
                }, tbar: [{
                    text: '按钮',
                    xtype: 'button',
                    name: "btnAdd",
                    handler: function () {
                        Ext.Ajax.request({
                            //被用来向服务器发起请求默认的url  
                            url: "test.aspx",
                            //请求时发送后台的参数,既可以是Json对象，也可以直接使用“name = value”形式的字符串  
                            params: {
                                action: "add",
                                name: '12313131321'
                            },
                            //请求时使用的默认的http方法  
                            method: "post",
                            //请求成功时回调函数  
                            success: function (response) {
                                debugger
                                var obj = Ext.decode(response.responseText);
                                if (obj.success) {
                                    Ext.Msg.alert('提示', obj.msg);
                                }
                            },
                            //请求失败时回调函数  
                            failure: function () {
                                Ext.Msg.alert("信息提示", "出错！");
                            }
                        }
);
                    }
                }],
                renderTo: Ext.getBody()
            });
        });
    </script>
</head>

<body>
</body>
</html>
