//
//  YZYingKeMacro.m
//  yingke
//
//  Created by yanzhen on 16/12/7.
//  Copyright © 2016年 v2tech. All rights reserved.
//

//const CGFloat OTHERUSERTEXTLABELFONT = 17.0;
//https://github.com/liuyujiahuan/bjsxt_ios_inke

//http://service.ingkee.com/api/live/gettop?imsi=&uid=17800399&proto=20&idfa=A1205EB8-0C9A-4131-A2A2-27B9A1E06622&lc=0000000000000026&cc=TG0001&imei=&sid=20i0a3GAvc8ykfClKMAen8WNeIBKrUwgdG9whVJ0ljXi1Af8hQci3&cv=IK3.1.00_Iphone&devi=bcb94097c7a3f3314be284c8a5be2aaeae66d6ab&conn=Wifi&ua=iPhone&idfv=DEBAD23B-7C6A-4251-B8AF-A95910B778B7&osversion=ios_9.300000&count=20&multiaddr=1

#pragma mark - URL
//映客最新URL
//http://116.211.167.106/api/live/aggregation?uid=133825214&interest=1
NSString *const YK_Hot_URL = @"http://116.211.167.106/api/live/aggregation?uid=133825214&interest=1";
//图片URL-header
NSString *const YK_ImageURL_Header = @"http://img2.inke.cn";
//附近的人
//http://service.ingkee.com/api/live/near_recommend?uid=133825214&latitude=40.090562&longitude=116.413353
//http://service.ingkee.com/api/live/near_recommend?uid=85149891&latitude=40.090562&longitude=116.413353
//最新
//http://116.211.167.106/api/live/near_recommend?uid=133825214&latitude=40.090562&longitude=116.413353
NSString *const YK_Near_URL = @"http://116.211.167.106/api/live/near_recommend?uid=133825214&latitude=40.090562&longitude=116.413353";
NSString *const YK_Near_AppendingURL = @"http://116.211.167.106/api/live/near_recommend?uid=133825214&latitude=%@&longitude=%@";
//直播前缀，服务器未知
//rtmp://live.hkstv.hk.lxdns.com:1935/live/%@
NSString *const YK_Live_Header = @"rtmp://live.hkstv.hk.lxdns.com:1935/live/Funny_%@";
//Funny_Date_UUID

NSString *const YK_SERVER_HOST = @"http://service.ingkee.com";
NSString *const YK_IMAGE_HOST = @"http://img.meelive.cn/";
//http://service.ingkee.com/api/live/gettop
//首页数据
NSString *const YK_LiveGetTop = @"api/live/gettop";
//广告地址
NSString *const YK_Advertise = @"advertise/get";
//热门话题
NSString *const YK_TopicIndex = @"api/live/topicindex";
//


//附近的人--//?uid=85149891&latitude=40.090562&longitude=116.413353
NSString *const YK_NearLocation = @"api/live/near_recommend";

//直播地址
NSString *const YK_Dahuan = @"rtmp://live.hkstv.hk.lxdns.com:1935/live/dahuan";
