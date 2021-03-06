import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/common/Page.dart';
import 'package:flutter_wanandroid/common/application.dart';
import 'package:flutter_wanandroid/common/constants.dart';
import 'package:flutter_wanandroid/components/main_app_bar.dart';
import 'package:flutter_wanandroid/model/route_page_data.dart';
import 'package:flutter_wanandroid/routers/routes.dart';
import 'package:flutter_wanandroid/utils/tool_utils.dart';
import 'package:flutter_wanandroid/views/drawer/drawer_page.dart';
import 'package:flutter_wanandroid/views/home/page/first_page.dart';
import 'package:flutter_wanandroid/views/home/page/latest_project_page.dart';

/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/10/31 0031
/// email: maoqitian068@163.com
/// des:  首页 widget  TabBar 、Tab、TabBarView 结合实现 选项卡


//用于控制/监听Tab菜单切换
//TabBar和TabBarView正是通过同一个controller来实现菜单切换和滑动状态同步的。
TabController _tabController;

class HomePage extends StatefulWidget {

  /*@override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }*/

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{


  
  //构造方法
  _HomePageState();

  ///初始化，这个函数在生命周期中只调用一次
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: Constants.allPages.length,vsync: this);
  }



  @override
  Widget build(BuildContext context) {
    return buildTabScaffold();
  }

  //当整个页面dispose时，记得把控制器也dispose掉，释放内存
  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  Widget buildTabScaffold() {
    return new Scaffold(
      appBar: MyAppBar(
        leading: Container(
          child: Icon(Icons.menu,color: Colors.white),
        ),
        centerTitle: true,
        //设置title 形式嵌入 tabbar 也可以 通过“bottom”属性在AppBar下方来添加一个导航栏底部tab按钮组
        title: buildTabBar(),
        actions: <Widget>[
          IconButton(
              icon:  Icon(Icons.search),
              color: Colors.white,
              onPressed: () {
                RoutePageData routePageData = new RoutePageData(0, "","",Constants.NORMAL_SEARCH_PAGE_TYPE , false);
                Application.router.navigateTo(context, '${Routes.searchPage}?routePageJson=${ToolUtils.object2string(routePageData)}');
              })
        ],
      ),
      body: HomePageTabBarViewLayout(),
      //侧边栏
      drawer: Drawer(
        child: DrawerPage(),
      ),
    );
  }

  //构造 TabBar
  buildTabBar() {
    return new TabBar(
      //构造Tab集合
      tabs: Constants.allPages.map((Page page){
        return Tab(
          text: page.labelId,
        );
      }).toList(),

        //tabs 的长度超出屏幕宽度后，TabBar，是否可滚动
        //设置为false tab 将平分宽度，为true tab 将会自适应宽度
        isScrollable: true,
        //设置tab文字得类型
        labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        labelPadding: EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
        ///指示器大小计算方式，TabBarIndicatorSize.label跟文字等宽,TabBarIndicatorSize.tab跟每个tab等宽
        indicatorSize: TabBarIndicatorSize.label,
        //设置tab选中得颜色
        labelColor: Colors.white,
        //设置tab未选中得颜色
        unselectedLabelColor: Colors.white54,
        indicatorColor: Colors.white,
        //设置自定义tab的指示器，CustomUnderlineTabIndicator
        //若不需要自定义，可直接通过
        //indicatorColor 设置指示器颜色
        //indicatorWight 设置指示器厚度
        //indicatorPadding
        //indicatorSize  设置指示器大小计算方式
        controller: _tabController,
        //构造Tab集合
    );

  }

}

// TabBarView Widget
class HomePageTabBarViewLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    print("TabBarViewLayout build.......");
    return TabBarView(
        controller: _tabController,
        children: Constants.allPages.map((Page page){
          return buildTabView(context, page);
        }).toList(),
    );
  }

  Widget buildTabView(BuildContext context, Page page) {
    int labelIndex = page.labelIndex;
    switch(labelIndex){
      case 1:
        //最新博文
        return FirstPage();
        break;
      case 2:
        //最新项目
        return LatestProjectPage();
        break;
      default:
        return  Container(
          child: new Center(
            child: new Text("暂未实现 Page"),
          ),
        );
        break;
    }
  }
}

