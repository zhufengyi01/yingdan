//
//  TagView.h
//  movienext
//
//  Created by 风之翼 on 15/4/26.
//  Copyright (c) 2015年 redianying. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "weiboInfoModel.h"
#import "TagModel.h"


@protocol TagViewDelegate <NSObject>

-(void)TapViewClick:(id) tagView Withweibo:(weiboInfoModel *) weiboInfo withTagInfo:(TagModel *) tagInfo;

@end
@interface TagView : UIView

@property (nonatomic,strong) UILabel  *titleLable;
@property(nonatomic,strong) UIImageView *tagBgImageview;  //标签的背景图片

@property(nonatomic,strong) weiboInfoModel  *weiboInfo;
@property(nonatomic,strong) TagModel   *tagInfo;
@property(nonatomic,strong) id<TagViewDelegate> delegete;

//custom init
-(instancetype)initWithWeiboInfo:(weiboInfoModel *) weiboInfo AndTagInfo :(TagModel *) tagInfo delegate:(id<TagViewDelegate>) delegate isCanClick:(BOOL) click  backgoundImage:(UIImage *) image;

///设置tag是否可以被点击
-(void)setTagViewIsClick:(BOOL) isCanClick;
@end
