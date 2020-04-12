<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sample11.aspx.cs" Inherits="test.Sample11" %>

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
        Ext.onReady(function() {
                var myStore = Ext.create('Ext.data.ArrayStore',
                    {
                        fields: [
                            //没有float 排序会混乱掉
                            { name: 'NO', type: 'float' },
                            { name: 'NAME' },
                            { name: 'PHONE' },
                            { name: 'SEX' },
                            { name: 'BIRTHDAY', type: 'date' }
                        ],
                        sorters: [
                            {
                                //预排序，在store中加入sorters,给NO添加DESC排序
                                property: 'NO',
                                direction: 'DESC'

                            }
                        ]
                    });

                var myData = [
                    ['1', 'Canred Chen1', '0982*****1', '1', '1980/5/1'],
                    ['2', 'Canred Chen2', '0982*****1', '0', '1980/5/2'],
                    ['3', 'Canred Chen3', '0982*****1', '1', '1980/5/3'],
                    ['4', 'Canred Chen4', '0982*****1', '0', '1980/5/4'],
                    ['5', 'Canred Chen5', '0982*****1', '0', '1980/5/5'],
                    ['6', 'Canred Chen6', '0982*****1', '1', '1980/5/6'],
                    ['7', 'Canred Chen7', '0982*****1', '0', '1980/5/7'],
                    ['8', 'Canred Chen8', '0982*****1', '0', '1980/5/8'],
                    ['9', 'Canred Chen9', '0982*****1', '0', '1980/5/9'],
                    ['10', 'Canred Chen10', '0982*****1', '1', '1980/5/1'],
                    ['11', 'Canred Chen11', '0982*****1', '1', '1980/5/2'],
                    ['12', 'Canred Chen12', '0982*****1', '0', '1980/5/3'],
                    ['13', 'Canred Chen13', '0982*****1', '0', '1980/5/4'],
                    ['14', 'Canred Chen14', '0982*****1', '1', '1980/5/5'],
                    ['15', 'Canred Chen15', '0982*****1', '0', '1980/5/6'],
                    ['16', 'Canred Chen16', '0982*****1', '1', '1980/5/7'],
                    ['17', 'Canred Chen17', '0982*****1', '1', '1980/5/8'],
                    ['18', 'Canred Chen18', '0982*****1', '0', '1980/5/9'],
                    ['19', 'Canred Chen19', '0982*****1', '0', '1980/5/1'],
                    ['20', 'Canred Chen20', '0982*****1', '1', '1980/5/2']
                ];

                myStore.loadData(myData);

            var myCheckbox = new Ext.selection.CheckboxModel({
                listeners: {
                    selectionChange: function(me, selected, eOpts) {
                        if (selected.length > 0) {
                            Ext.MessageBox.alert("提示",selected[0].data.NAME);
                        }
                    }
                }

            })

                var myGrid = new Ext.grid.GridPanel({
                    title: "My Grid",
                    autoWidth: true,
                    height: 1200,
                    store: myStore,
                    selModel:myCheckbox,
                    //enableColumnsMove: false,
                    //enableColumnsResize: false,
                    renderTo: 'divPhone',
                    columns: [
                        new Ext.grid.RowNumberer(),
                        {
                            header: '编号',
                            dataIndex: 'NO',
                            width: 80
                        },
                        {
                            header: '姓名',
                            dataIndex: 'NAME',
                            flex: 2
                        },
                        {
                            header: '电话',
                            dataIndex: 'PHONE',
                            flex: 2
                        },
                        {
                            header: '性别',
                            dataIndex: 'SEX',
                            flex: 1,
                            align: 'center',
                            sortable: false,
                            renderer: function(value, record) {
                                if (value == 1) {
                                    return "男";
                                } else {
                                    return "女";
                                };
                            }
                        },
                        {
                            header: '生日',
                            dataIndex: 'BIRTHDAY',
                            type: 'date',
                            renderer: Ext.util.Format.dateRenderer('Y年m月d日'),
                            flex: 2,
                            //renderer: function (value) {
                            //    //Ext.util.Format.dateRenderer('Y年m月d日')
                            //    return "我得生日是" + value;
                            //}
                        }
                    ],
                    tbar:[{
                        xtype: 'button',    
                        text: '改变第二行的颜色',
                        handler: function() {
                            myGrid.getView().addRowCls(1, 'class3')
                        }
            },
            {
                xtype: 'button',
                text: '改变第三行第三个栏位的颜色',
                handler: function() {
                    //grid.getView().addRowCls(1, 'class3')
                    Ext.get(myGrid.getView().getCellByPosition({ row: 2, column: 2 })).dom.style.background = "blue";
                }
                }
                ],
                viewConfig: {
                    getRowClass: function(record, rowIndex, rowParams, store) {
                        //if (rowIndex % 2 == 0) {
                        //    return 'class2';
                        //}else {
                        //    return 'class1';
                        //}

                    }
                },


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
<style>
    .class1 .x-grid-cell { background:#FF0000;}
    .class2 .x-grid-cell { background:yellow;}
    .class3 .x-grid-cell { background:green;}
    .class4 .x-grid-cell { background:gray;}



</style>
    <div id="divPhone"></div>
</body>
</html>
