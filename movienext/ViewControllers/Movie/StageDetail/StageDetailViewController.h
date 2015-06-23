//
//  StageDetailViewController.h
//  movienext
//
//  Created by 朱封毅 on 18/06/15.
//  Copyright (c) 2015年 redianying. All rights reserved.
//

#import "RootViewController.h"
#import "weiboInfoModel.h"

typedef NS_ENUM(NSInteger, NSStageDetailSourcePgae)
{
    NSStageDetailSourcePgaeDefault, //普通入口
    NSStageDetailSourcePgaeAdminOperation  //管理员操作页面
};
@interface StageDetailViewController : RootViewController

@property(nonatomic,strong) weiboInfoModel     *weiboInfo;  // 初始化的时候，需要把weiboinfo设置成数组的第几个

//@property(nonatomic,strong) NSString              *index;                //页的下标

@property(nonatomic,strong)     NSMutableArray  *upWeiboArray;           //点赞的数组

@property(nonatomic,strong) UIView             *ShareView;   // 最终分享出去的图


@property(nonatomic,assign)  NSStageDetailSourcePgae  pageType;


@end