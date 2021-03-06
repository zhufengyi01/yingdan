//
//  StageView.h
//  movienext
//
//  Created by 杜承玖 on 3/6/15.
//  Copyright (c) 2015 redianying. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MarkView.h"
#import "weiboInfoModel.h"
#import "stageInfoModel.h"
@protocol StageViewDelegate <NSObject>
//把信息又返回，给controller
-(void)StageViewHandClickMark:(weiboInfoModel  *) weiboDict withmarkView:(id) markView StageInfoDict:(stageInfoModel *)stageInfoDict;
@end
@interface StageView : UIView  <MarkViewDelegate>   // 遵守
{
    UIImageView   *_MovieImageView;
    NSInteger currentMarkIndex;
    NSTimer *_timer;
   // UIImageView  *tanimageView;
}
@property (nonatomic,strong ) NSArray    *weibosArray;   //小标签的数组，在多个标签的时候使用这个

@property (nonatomic,strong ) weiboInfoModel      *weiboinfo;     //只有一个标签的时候传递这个参数

//设置气泡是否可以移动，这个在cell 里面进行了设置
@property (nonatomic,assign) BOOL isAnimation;   //子视图是否是可以动的动画

@property(nonatomic,strong) stageInfoModel   *stageInfo;

@property (nonatomic,assign )id <StageViewDelegate> delegate;

@property(nonatomic,strong)     UIButton      *tanlogoButton;

-(void)showAndHidenMarkView:(BOOL) isShow;

-(void)configStageViewforStageInfoDict;
/**
 *  开始动画
 */
-(void)startAnimation; //在celldisplay执行的方法

/**
 *  结束动画
 */
- (void)stopAnimation;   //在cellenddisplay 执行的方法
//点击cell隐藏弹幕，再点击显示弹幕
//-(void)hidenAndShowMarkView:(BOOL) isShow;
//
@end
