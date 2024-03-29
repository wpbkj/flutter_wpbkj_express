// description: 主APP入口页面
// author: WPBKJ
// date: 2023-02-07

import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wpbkj_express/main.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:wpbkj_express/page/home.dart';
import 'package:wpbkj_express/page/user.dart';
import 'package:wpbkj_express/page/info.dart';
import 'package:wpbkj_express/page/splash.dart';
import 'package:wpbkj_express/page/error/db_error.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // 自定义primarySwatch方法
  MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }

  @override
  Widget build(BuildContext context) {
    final botToastBuilder = BotToastInit(); // 初始化toast组件
    // 取消Android状态栏默认黑色半透明样式
    if (Theme.of(context).platform == TargetPlatform.android) {
      SystemUiOverlayStyle style =
          const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(style);
    }
    return MaterialApp(
      builder: (context, child) {
        ResponsiveWrapper.builder(child,
            minWidth: 480,
            defaultScale: true,
            breakpoints: const [
              ResponsiveBreakpoint.autoScale(480, name: MOBILE),
              ResponsiveBreakpoint.autoScale(800, name: TABLET),
              ResponsiveBreakpoint.autoScale(1000, name: DESKTOP),
              ResponsiveBreakpoint.autoScale(2460, name: '4K'),
            ],
            background: Container(color: Colors.white)); // 自适应比例缩放
        child = botToastBuilder(context, child); // 初始化toast组件
        return child;
      },
      navigatorObservers: [BotToastNavigatorObserver()], // 初始化toast组件
      initialRoute: "/", // 初始路由(splash)
      routes: {
        // 绑定路由
        '/': (context) => const SplashPage(),
        '/home': (context) => const MyHomePage(),
        '/db_error': (context) => const DBErrorPage()
      },
      locale: const Locale('zh', 'CN'), // 本地化
      localizationsDelegates: const [
        //初始化默认的 Material 组件本地化
        GlobalMaterialLocalizations.delegate,
        //初始化默认的 通用 Widget 组件本地化
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('zh', 'CN'), Locale('en', 'US')], // 本地化
      title: appTitle, // 标题
      theme: ThemeData(
              primaryColor: Colors.blueAccent,
              visualDensity: VisualDensity.standard,
              primarySwatch: createMaterialColor(Colors.blueAccent))
          .useSystemChineseFont(), // 普通模式(浅色模式)样式
      darkTheme: ThemeData(
              brightness: Brightness.dark,
              primaryColor: Colors.grey.shade800,
              visualDensity: VisualDensity.standard,
              primarySwatch: Colors.grey)
          .useSystemChineseFont(), // 深色模式样式
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPage = 0; // 存储当前页面索引
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey =
      GlobalKey(); // 底部导航Key
  final pageController = PageController(); // 页面Controller

  // 页面列表
  final List<Widget> _pages = [
    const HomePage(),
    const UserPage(),
    const InfoPage()
  ];

  // 底部导航按钮列表
  final List<CurvedNavigationBarItem> _items = const [
    CurvedNavigationBarItem(
        child: Icon(
          Icons.home_outlined,
          size: 30,
        ),
        label: '主页',
        labelStyle: TextStyle(fontSize: 13)),
    CurvedNavigationBarItem(
        child: Icon(
          Icons.perm_identity,
          size: 30,
        ),
        label: '用户',
        labelStyle: TextStyle(fontSize: 13)),
    CurvedNavigationBarItem(
        child: Icon(
          Icons.info_outlined,
          size: 30,
        ),
        label: '关于',
        labelStyle: TextStyle(fontSize: 13)),
  ];

  // 点击底部导航方法(跳转页面)
  void onTap(int index) {
    pageController.jumpToPage(index);
  }

  // 页面转换方法(改变索引)
  void onPageChanged(int index) {
    // 所有setState都应包含对mounted的检查，若setState时页面不处于显示状态，则会引起异常
    if (mounted) {
      setState(() {
        currentPage = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // 底部导航栏
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 60,
          items: _items,
          color: Theme.of(context).primaryColor, // 主题色
          buttonBackgroundColor: Colors.black12, // 悬浮按钮背景色
          backgroundColor: Colors.transparent, // 背景色
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 600), // 底部导航动画切换时间
          onTap: onTap,
        ),
        body: PageView(
          controller: pageController,
          onPageChanged: onPageChanged,
          physics: const NeverScrollableScrollPhysics(),
          children: _pages,
        ));
  }
}
