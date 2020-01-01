/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/12/24 0024
/// email: maoqitian068@163.com
/// des:  收藏网站 view item
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/common/MyIcons.dart';
import 'package:flutter_wanandroid/common/application.dart';
import 'package:flutter_wanandroid/common/event/cancel_event.dart';
import 'package:flutter_wanandroid/http/data_utils.dart';
import 'package:flutter_wanandroid/model/collect/collect_web_data.dart';
import 'package:flutter_wanandroid/routers/routes.dart';
import 'package:flutter_wanandroid/utils/tool_utils.dart';

class CollectWebViewItem extends StatefulWidget {

  final CollectWebData collectWebData;

  CollectWebViewItem({Key key,this.collectWebData}):super(key : key);

  @override
  _CollectWebViewItemState createState() => _CollectWebViewItemState();
}

class _CollectWebViewItemState extends State<CollectWebViewItem> {


  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0,vertical: 6.0),
      child: ListTile(
        onTap: (){ //link 跳转  webview
          Application.router.navigateTo(context, '${Routes.webViewPage}?title=${Uri.encodeComponent(widget.collectWebData.name)}&url=${Uri.encodeComponent(widget.collectWebData.link)}');
        },
        title: Padding( //文章标题
          padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
          child: Text(
              ToolUtils.signToStr(widget.collectWebData.name),
              style: TextStyle(color: Colors.black, fontSize: 15.0),
              maxLines: 1, // title 只显示一行
              overflow: TextOverflow.ellipsis //超出一行 显示 ...
          )
        ),
        subtitle: Row(
          children: <Widget>[
              Expanded(
                child: IconButton(icon: Icon(Icons.edit,size: 20.0),onPressed: (){
                   //编辑 收藏网站
                },),
              ),
              Expanded( //占位
                flex: 2,
                child: Container(),
              ),
              Expanded(
                child: IconButton(icon: Icon(MyIcons.delete,size: 20.0),onPressed: (){

                  ToolUtils.showAlertDialog(context, "确定删除收藏网站"+widget.collectWebData.name+"?",
                      confirmCallback: ()async{
                        // 删除收藏网站
                        await dataUtils.getDeleteCollectWeb(widget.collectWebData.id);
                        Application.eventBus.fire(new CollectEvent());
                        ToolUtils.showToast(msg: "删除收藏网站成功");
                  },confirmText: "确定");
                },),
              ),

          ],
        ),
      ),
    );
  }
}