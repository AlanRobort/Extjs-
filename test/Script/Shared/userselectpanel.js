/*!
 * sinoydframework.common
 * Copyright(c) Sinoyd
 * huangf@sinoyd.com
 */
Ext.ns('sinoydframework.common');

Ext.onReady(function () {
    Ext.define('sinoydframework.common.userselectmodel', {
        extend: 'Ext.data.Model',
        fields: ['id', 'cname', 'domainname']
    });
    Ext.define('sinoydframework.common.userselectpanel', {
        extend: 'Ext.Window',
        layout: 'border',
        border: false,
        frame: false,
        alias: 'widget.userselectpanel',
        callback: function (selections) { },
        initComponent: function () {
            var lefttree = Ext.create('Ext.tree.Panel', {
                region: 'center',
                padding: '5 0 5 5',
                border: false,
                rootVisible: false,
                split: true,
                store: new Ext.data.TreeStore({
                    root: {
                        text: 'Root',
                        expanded: true
                    }
                }),
                listeners: {
                    checkchange: function (node, checked, eOpts) {
                        Ext.suspendLayouts();
                        if (checked) {
                            rightgrid.getStore().add({ id: node.data.id, cname: node.data.text, domainname: node.parentNode.data.text });
                        }
                        else {
                            var theRecord = rightgrid.getStore().findRecord('id', node.data.id);
                            if (theRecord) rightgrid.getStore().remove(theRecord);
                        }
                        Ext.resumeLayouts(true);
                    }
                }
            });
            var rightgrid = Ext.create('Ext.grid.Panel', {
                region: 'east',
                layout: 'fit',
                width: 250,
                padding: '5 5 5 5',
                border: false,
                columns: [],
                listeners: {
                    itemdblclick: function (view, record, item, index, e, eOpts) {
                        rightgrid.getStore().remove(record);
                        var node = lefttree.getStore().getNodeById(record.data.id);
                        if (node) {
                            node.data.checked = false;
                            if (node.isVisible()) {
                                lefttree.collapseNode(node.parentNode);
                                new Ext.util.DelayedTask(function () {
                                    lefttree.expandNode(node.parentNode);
                                }).delay(500);
                            }
                        }
                    }
                }
            });
            this.items = [lefttree, rightgrid];
            var callback = this.callback;
            var emptyguid = '00000000-0000-0000-0000-000000000000';
            Ext.Ajax.request({
                url: UrlConvert('Auth/GetUserTree'),
                params: {
                    rootDomain: this.rootDomain || emptyguid,
                    roles: this.roles || [],
                    users: this.users || []
                },
                method: 'POST',
                callback: function (options, success, response) {
                    if (success) {
                        var rec = Ext.decode(response.responseText);
                        if (rec.success) {
                            lefttree.getRootNode().appendChild(rec.data.children);//.removeAll();
                            rightgrid.reconfigure(
                                new Ext.data.Store({ model: 'sinoydframework.common.userselectmodel', data: rec.data.users }),
                                [{
                                    text: '姓名',
                                    flex: true,
                                    dataIndex: 'cname'
                                }, {
                                    text: '区域',
                                    dataIndex: 'domainname'
                                }]
                            );
                        }
                    }
                }
            });
            var onCheckedNodesClick = function (obj, arg) {
                var records = lefttree.getView().getChecked(),
                    names = [],
                    ids = [];

                Ext.Array.each(records, function (rec) {
                    names.push(rec.get('text'));
                    ids.push(rec.get('id'));
                });

                if (callback) callback({ names: names, ids: ids });
            };
            this.buttons = [{ text: '选择', handler: onCheckedNodesClick }];
            this.callParent(arguments)
        }
    });
});