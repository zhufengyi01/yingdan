//
//  MovieCollectionViewCell.m
//  movienext
//
//  Created by 风之翼 on 15/3/2.
//  Copyright (c) 2015年 redianying. All rights reserved.
//

#import "MovieCollectionViewCell.h"
#import "Constant.h"
#import "ZCControl.h"
#import "UIImageView+WebCache.h"
#import "UserDataCenter.h"
@implementation MovieCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        m_frame=frame;
        [self createUI];
    }
    return self;
}
-(void)createUI
{
 
    self.backgroundColor=[UIColor redColor];
    LogoImage =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,m_frame.size.width, m_frame.size.height-30)];
    [self.contentView addSubview:LogoImage];
    
 
    TitleLable =[[UILabel alloc]initWithFrame:CGRectMake(0, LogoImage.frame.origin.y+LogoImage.frame.size.height+5, LogoImage.frame.size.width, 20)];
    TitleLable.textAlignment=NSTextAlignmentCenter;
    TitleLable.textColor=VGray_color;
    TitleLable.lineBreakMode=NSLineBreakByTruncatingTail;
    TitleLable.font=[UIFont boldSystemFontOfSize:12];
    [self.contentView addSubview:TitleLable];
    
    //只有管理员才能删除
    UserDataCenter  *userCenter =[UserDataCenter shareInstance];
    if ([userCenter.is_admin intValue]>0) {
        //添加手势
    UILongPressGestureRecognizer  *longPress =[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    [self addGestureRecognizer:longPress];
    }
}
-(void)setValueforCell:(NSDictionary *)dict inRow:(NSInteger)inrow
{
    if ([dict objectForKey:@"photo"])
    {
        NSURL *urlString=[NSURL URLWithString:  [NSString stringWithFormat:@"%@%@!poster",kUrlFeed,[dict objectForKey:@"photo"]]];
        [LogoImage sd_setImageWithURL:urlString placeholderImage:[UIImage imageNamed:@"loading_image_all.png"]];
    }
    if ([dict objectForKey:@"title"]) {
        TitleLable.text=[NSString stringWithFormat:@"%@",[dict objectForKey:@"title"]];
    }
}
//长按删除
-(void)longPress:(UILongPressGestureRecognizer *) longPress
{
    
    if (longPress.state==UIGestureRecognizerStateBegan) {
        if (self.delegate &&[self.delegate respondsToSelector:@selector(MovieCollectionViewlongPress:)]) {
            [self.delegate MovieCollectionViewlongPress:self.Cellindex];
        }
        
    }
}


@end
