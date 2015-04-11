//
//  BigImageCollectionViewCell.m
//  movienext
//
//  Created by 风之翼 on 15/3/7.
//  Copyright (c) 2015年 redianying. All rights reserved.
//

#import "BigImageCollectionViewCell.h"
#import "Constant.h"
#import "UIImageView+WebCache.h"
//#import "UIButton+WebCache.h"
#import "Function.h"
#import "ZCControl.h"
@implementation BigImageCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame:frame]) {
        m_frame=frame;
        [self CreateUI];
    }
    return self;
}
-(void)CreateUI
{
    self.backgroundColor =[UIColor blackColor];
    [self CreateTopView];
    [self createButtonView];

}
-(void)CreateTopView
{
    _StageView=[[StageView alloc]initWithFrame:CGRectMake(0, 45, kDeviceWidth, 200)];
    _StageView.backgroundColor=VStageView_color;
    [self.contentView addSubview:_StageView];
    
}

-(void)createButtonView
{
    BgView2=[[UIView alloc]initWithFrame:CGRectMake(0, kDeviceWidth, kDeviceWidth, 45)];
    BgView2.backgroundColor=View_ToolBar;
    [self.contentView addSubview:BgView2];
    
    
    ScreenButton =[ZCControl createButtonWithFrame:CGRectMake(kDeviceWidth-140,10,60,26) ImageName:@"screen_shot share.png" Target:self Action:@selector(cellButtonClick:) Title:@""];
    ScreenButton.tag=2000;
    [BgView2 addSubview:ScreenButton];
    
    addMarkButton =[ZCControl createButtonWithFrame:CGRectMake(kDeviceWidth-70,10,60,26) ImageName:@"btn_add_default.png" Target:self Action:@selector(cellButtonClick:) Title:@""];
    addMarkButton.tag=3000;
    [BgView2 addSubview:addMarkButton];
    
    
}
- (void)awakeFromNib {
    // Initialization code
}
-(void)ConfigCellWithIndexPath:(NSInteger)row{
    self.Cellindex=row;
    if (self.weibosArray) {
        _StageView.weibosArray = self.weibosArray;
    }
    _StageView.stageInfo=self.stageInfo;
    [_StageView configStageViewforStageInfoDict];
    _StageView.frame=CGRectMake(0, 0, kDeviceWidth, kDeviceWidth);
    BgView2.frame=CGRectMake(0, kDeviceWidth, kDeviceWidth, 45);
    _StageView.isAnimation = YES;
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
      BgView2.frame=CGRectMake(0, kDeviceWidth, kDeviceWidth, 45);
    
}

#pragma mark ---
#pragma mark ------下方按钮点击事件
#pragma mark ------

#pragma mark ---
#pragma mark ------下方按钮点击事件 ,在父视图中实现具体的方法
-(void)cellButtonClick:(UIButton*)button
{
  
    if (self.delegate &&[self.delegate respondsToSelector:@selector(BigImageCollectionViewCellToolButtonClick:Rowindex:)]) {
        [self.delegate BigImageCollectionViewCellToolButtonClick:button Rowindex:self.Cellindex];
    }
    
}



-(void)ScreenButtonClick:(UIButton  *) button
{
   //分享
}
-(void)addMarkButtonClick:(UIButton  *) button
{
    //添加弹幕
    
}

@end
