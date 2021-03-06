//
//  UMShareViewController2.h
//  movienext
//
//  Created by 风之翼 on 15/4/30.
//  Copyright (c) 2015年 redianying. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "stageInfoModel.h"
#import "weiboInfoModel.h"
#import "M80AttributedLabel.h"
#define  Tag_View_Color [UIColor colorWithRed:155.0/255 green:155.0/255 blue:155.0/255 alpha:1]
typedef NS_ENUM(NSInteger,NSSharePageType)
{
    NSSharePageTypeDefault,  //默认返回到根视图控制器
    NSSharePageTypeDoubanUploadImage,  //从豆瓣的网上图片过来
    NSSharePageTypeLoadUploadImage      //从本地分享过来
    
};



@protocol UMShareViewController2Delegate <NSObject>

-(void)UMShareViewController2HandClick:(UIButton *) button ShareImage:(UIImage *)shareImage StageInfoModel :(stageInfoModel *) StageInfo;

@end
@interface UMShareViewController2 : UIViewController
{
    CGRect  m_frame;
    //UILabel  *logoLable;
    UIButton  *wechatSessionBtn;
    UIButton  *wechatTimelineBtn;
    UIButton  *qzoneBtn;
    UIButton  *weiboBtn;
    UIImageView *_ShareimageView;
    UILabel  *_moviewName;
    //上部的view
    //UIView  *topView;
    //底部视图
    UIView  *buttomView;
    UIImage   *shareImage;
    UIView  *logoView;

}
@property(nonatomic,assign)id<UMShareViewController2Delegate> delegate;
@property(nonatomic,strong) stageInfoModel  *StageInfo;
@property(nonatomic,strong) weiboInfoModel  *weiboInfo;
@property(nonatomic,assign) NSSharePageType   pageType;

@end
