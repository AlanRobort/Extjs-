Ext.onReady(function () {
    //if (!Ext.isDefined('SinoydFramework.view.domain.SelectDomainWindow')) {
        Ext.define('SinoydFramework.model.domain.DomainModel', {
            extend: 'Ext.data.Model',
            fields: [
                { name: 'Id', type: 'string' },
                { name: 'ParentId', type: 'string' },
                { name: 'Name', type: 'string' },
                { name: 'Code', type: 'string' }
            ]
        });

        Ext.define('SinoydFramework.store.domain.noSelectDomainGridStore', {
            extend: 'Ext.data.Store',
            model: 'SinoydFramework.model.domain.DomainModel',
            autoLoad: false,
            proxy: {
                type: 'ajax',
                api: {
                    read: UrlConvert('Domain/GetNoSelectDomainGridPanel')
                },
                reader: {
                    type: 'json',
                    root: 'data',
                    successProperty: 'success'
                }
            }
        });
        Ext.define('SinoydFramework.store.domain.selectDomainGridStore', {
            extend: 'Ext.data.Store',
            model: 'SinoydFramework.model.domain.DomainModel',
            autoLoad: false,
            proxy: {
                type: 'ajax',
                api: {
                    read: UrlConvert('Domain/GetSelectDomainGridPanel')
                },
                reader: {
                    type: 'json',
                    root: 'data',
                    successProperty: 'success'
                }
            }
        });
        Ext.define('SinoydFramework.view.domain.SelectDomainGridPanel', {
            extend: 'Ext.grid.Panel',
            //store: 'domain.selectDomainGridStore',
            alias: 'widget.domainSelectDomainGridPanel',
            border: false,
            stripeRows: true,
            layout: 'fit',
            title: '已配置域',
            userId: '',
            multiSelect: true,
            margins: '0 0 0 3',
            viewConfig: {
                plugins: {
                    ptype: 'gridviewdragdrop',
                    ddGroup: 'ddGroup'
                }
                //        listeners: {
                //            drop: function (node, data, dropRec, dropPosition) {
                //                var dropOn = dropRec ? ' ' + dropPosition + ' ' + dropRec.get('name') : ' on empty view';
                //                Ext.example.msg("Drag from right to left", 'Dropped ' + data.records[0].get('name') + dropOn);
                //            }
                //        }
            },
            initComponent: function () {
                this.store = new SinoydFramework.store.domain.selectDomainGridStore({
                    storeId: 'grid.selectDomainGridStore.store'
                });
                this.columns = [
                { text: "Id", width: 120, dataIndex: 'Id', sortable: false, hidden: true },
                { text: "名称", width: 75, dataIndex: 'Name', sortable: false },
                { text: "编码", width: 75, dataIndex: 'Code', sortable: true }],
                this.callParent(arguments)
            }
        });
        Ext.define('SinoydFramework.view.domain.NoSelectDomainGridPanel', {
            extend: 'Ext.grid.Panel',
            //store: 'domain.noSelectDomainGridStore',
            alias: 'widget.domainNoSelectDomainGridPanel',
            border: false,
            stripeRows: true,
            layout: 'fit',
            title: '未配置域',
            multiSelect: true,
            margins: '0 2 0 0',
            viewConfig: {
                plugins: {
                    ptype: 'gridviewdragdrop',
                    ddGroup: 'ddGroup'
                }
                //        listeners: {
                //            drop: function (node, data, dropRec, dropPosition) {
                //                var dropOn = dropRec ? ' ' + dropPosition + ' ' + dropRec.get('name') : ' on empty view';
                //            }
                //        }
            },
            initComponent: function () {
                this.store = new SinoydFramework.store.domain.noSelectDomainGridStore({
                    storeId: 'grid.noSelectDomainGrid.store'
                });
                this.columns = [
                { text: "Id", width: 120, dataIndex: 'Id', sortable: false, hidden: true },
                { text: "名称", width: 75, dataIndex: 'Name', sortable: false },
                { text: "编码", width: 75, dataIndex: 'Code', sortable: true }],
                this.callParent(arguments)
            }
        });

        Ext.define('SinoydFramework.view.domain.SelectDomainWindow', {
            extend: 'Ext.window.Window',
            closable: true,
            closeAction: 'hide',
            iconCls: "icon-application",
            alias: 'widget.domainSelectDomainWindow',
            width: 520,
            height: 450,
            layout: 'fit',
            modal: true,
            border: false,
            bodyBorder: false,

            initComponent: function () {
                var panelwest = Ext.create('SinoydFramework.view.domain.SelectDomainGridPanel', {
                    region: 'west',
                    padding: '5 0 5 5',
                    border: true,
                    width: 200
                });
                var panelcenter = Ext.create('SinoydFramework.view.domain.NoSelectDomainGridPanel', {
                    region: 'center',
                    padding: '5 5 5 0',
                    border: true
                });

                this.items = Ext.create('Ext.panel.Panel', {
                    layout: 'border',
                    border: false,
                    items: [panelwest, panelcenter]
                }),
                this.callParent(arguments);
            },
            buttons: [{
                text: '保存',
                iconCls: 'icon-disk',
                action: 'saveDomainUser',
                handler: function (obj,event) {
                    var selectDomainIds = new Array();
                    var selectGrid = obj.up('panel').down('domainSelectDomainGridPanel');
                    var selectGridStoreCount = selectGrid.getStore().getCount();
                    for (var i = 0; i < selectGridStoreCount; i++) {
                        //selectDomainIds += selectGrid.getStore().getAt(i).data.Id + ":";
                        selectDomainIds.push(selectGrid.getStore().getAt(i).data.Id);
                    }
                    Ext.Ajax.request({
                        url: UrlConvert('Domain/SetDomain'),
                        params: {
                            userId: selectGrid.userId,
                            domainIds: selectDomainIds
                        },
                        success: function (resp, opts) {
                            obj.up('window').hide();
                        },
                        failure: function (response) {
                            Ext.MessageBox.alert('失败', '请求超时或网络故障,错误编号：' + response.status);
                        }
                    });
                }
            }, {
                text: '关闭',
                iconCls: 'icon-cancel',
                handler: function () {
                    this.up('window').close();
                }
            }]
        });
    //}
});