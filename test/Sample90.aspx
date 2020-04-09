<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sample90.aspx.cs" Inherits="test.Sample90" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <!-- 这里是extjs的文件引用 -->
    <script type="text/javascript" src="Script/Extjs/ext-all.js"></script>
    <script type="text/javascript" src="Scripts/Shared/extensible-all.js"></script>
    <script type="text/javascript" src="Scripts/Shared/extensible-lang-zh_CN.js"></script>
    <link href="Content/theme/ext-theme-neptune/ext-theme-neptune-all-debug.css" rel="stylesheet" />
    <!-- extjs文件引用结束咯 -->
    
    
    <script type="text/javascript">
        Ext.onReady(function () {
            var myStore = Ext.create('Ext.data.ArrayStore',
                {
                    fields: [
                        //没有float 排序会混乱掉
                        { name: 'NO' ,type:'float'},
                        { name: 'NAME' },
                        { name: 'PHONE' },
                        { name: 'SEX' },   
                    ]
                });

            var myData = [
                ['1', 'Canred Chen1', '0982*****1', '1'],
                ['2', 'Canred Chen2', '0982*****1', '0'],
                ['3', 'Canred Chen3', '0982*****1', '1'],
                ['4', 'Canred Chen4', '0982*****1', '0'],
                ['5', 'Canred Chen5', '0982*****1', '0'],
                ['6', 'Canred Chen6', '0982*****1', '1'],
                ['7', 'Canred Chen7', '0982*****1', '0'],
                ['8', 'Canred Chen8', '0982*****1', '0'],
                ['9', 'Canred Chen9', '0982*****1', '0'],
                ['10', 'Canred Chen10', '0982*****1', '1'],
                ['11', 'Canred Chen11', '0982*****1', '1'],
                ['12', 'Canred Chen12', '0982*****1', '0'],
                ['13', 'Canred Chen13', '0982*****1', '0'],
                ['14', 'Canred Chen14', '0982*****1', '1'],
                ['15', 'Canred Chen15', '0982*****1', '0'],
                ['16', 'Canred Chen16', '0982*****1', '1'],
                ['17', 'Canred Chen17', '0982*****1', '1'],
                ['18', 'Canred Chen18', '0982*****1', '0'],
                ['19', 'Canred Chen19', '0982*****1', '0'],
                ['20', 'Canred Chen20', '0982*****1', '1']
            ];

            myStore.loadData(myData);

            var myGrid = new Ext.grid.GridPanel({
                title: "My Grid",
                autoWidth: true,
                height: 1200,
                store:myStore,
                renderTo: 'divPhone',
                columns: [

                    new Ext.grid.RowNumberer(),
                    {
                        header: '编号', dataIndex: 'NO',flex:1
                    },
                    {
                        header: '姓名', dataIndex: 'NAME',flex:2
                    },
                    {   
                        header: '电话', dataIndex: 'PHONE',flex:2
                    },
                    {
                        header: '性别', dataIndex: 'SEX',flex:1,
                        align: 'center',
                        renderer: function(value, record) {
                            if (value == 1) {
                                return "男";
                            } else {
                                return "女";
                            };
                        }
                    }
                ],

                listeners: {
                    'celldblclick': function (me, td, cellIndex, record, tr, rowIndex, e, eOpts) {
                        if (cellIndex != 0) {
                            var info = me.up('grid').columns[cellIndex].text;
                            Ext.MessageBox.alert({
                                title: '你点击的是'+info,
                                msg:'名字是：'+ record.data.NAME,
                                buttons: Ext.MessageBox.OK,
                        })
                        }
                    }
                }
            })

        })

    </script>
</head>
<body>
    <div id="divPhone"></div>
</body>
</html>
