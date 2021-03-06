//
//  ButtomToolView.m
//  movienext
//
//  Created by 风之翼 on 15/3/11.
//  Copyright (c) 2015年 redianying. All rights reserved.
//

#import "ButtomToolView.h"
#import "Constant.h"
#import "ZCControl.h"
#import "UIButton+WebCache.h"
#import "Function.h"
#import "UserDataCenter.h"
#import "UpweiboModel.h"
#import "Function.h"
#import "NSDate+Extension.h"
#import "UIButton+WebCache.h"

@implementation ButtomToolView 

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame:frame]) {
        m_frame=frame;
        self.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.4];
        [self createButtomView];
    }
    return self;
}
-(void)createButtomView
{
    //添加手势去回收alertview
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeAlertViewClick)];
    [self addGestureRecognizer:tap];
    
    //弹出框
    _alertView =[[UIView alloc]initWithFrame:CGRectMake(15,0, kDeviceWidth-30, 50)];
    _alertView.backgroundColor=[UIColor whiteColor];
    _alertView.alpha=1;
    _alertView.layer.cornerRadius=8;
    _alertView.clipsToBounds=YES;
    _alertView.userInteractionEnabled=YES;
    [self addSubview:_alertView];
    
    closealertView=[[UIButton alloc]initWithFrame:CGRectMake(_alertView.frame.size.width-36,0, 36, 36)];
    //closealertView.image=[UIImage imageNamed:@"alert_close"];
    [closealertView setImage:[UIImage imageNamed:@"alert_close"] forState:UIControlStateNormal];
    [closealertView addTarget:self action:@selector(closeAlertViewClick) forControlEvents:UIControlEventTouchUpInside];
    [_alertView addSubview:closealertView];
    
    
    
    //在alertview上添加手势用来截获点击屏幕事件
    UITapGestureRecognizer  *tapalert =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(alertViewTap:)];
    [_alertView addGestureRecognizer:tapalert];

    
    //头像
    headButton=[UIButton buttonWithType:UIButtonTypeCustom];
    headButton.frame=CGRectMake(10,10, 35, 35);
    headButton.layer.cornerRadius=4;
    headButton.clipsToBounds=YES;
    [headButton addTarget:self action:@selector(dealButtomClick:) forControlEvents:UIControlEventTouchUpInside];
    headButton.tag=10000;
    [_alertView addSubview:headButton];
    
     userNamelabel =[ZCControl createLabelWithFrame:CGRectMake(headButton.frame.origin.x+headButton.frame.size.width+10,headButton.frame.origin.y, 200, 20) Font:14 Text:@"名字"];
    userNamelabel.textColor=VBlue_color;
    userNamelabel.adjustsFontSizeToFitWidth=NO;
    userNamelabel.lineBreakMode=NSLineBreakByTruncatingTail;
    [_alertView addSubview:userNamelabel];
    
    
    
    
    timelabel =[ZCControl createLabelWithFrame:CGRectMake(userNamelabel.frame.origin.x,userNamelabel.frame.origin.y+userNamelabel.frame.size.height,200, 20) Font:12 Text:@"刚刚"];
    timelabel.textColor=VGray_color;
    [_alertView addSubview:timelabel];
    
    
    
    contentLable =[ZCControl createLabelWithFrame:CGRectMake(headButton.frame.origin.x,headButton.frame.origin.y+headButton.frame.size.height+0,_alertView.frame.size.width-20, 0) Font:16 Text:@"内容"];
    //contentLable.numberOfLines=0;
   contentLable.adjustsFontSizeToFitWidth=NO;
   // contentLable.lineBreakMode=NSLineBreakByTruncatingTail;
    contentLable.textColor=VGray_color;
    [_alertView addSubview:contentLable];
    
    
    //放置分享点赞按钮
    buttomShareView= [[UIView alloc]initWithFrame:CGRectMake(0, _alertView.frame.size.height-40, _alertView.frame.size.width, 45)];
    buttomShareView.userInteractionEnabled=YES;
    [_alertView addSubview:buttomShareView];
    
    
    
    shareButton =[ZCControl createButtonWithFrame:CGRectMake(0,0,_alertView.frame.size.width/2,45) ImageName:nil Target:self Action:@selector(dealButtomClick:) Title:@""];
    [shareButton setTitleColor:VBlue_color forState:UIControlStateNormal];
    shareButton.titleLabel.font=[UIFont systemFontOfSize:14];
    [shareButton setTitleEdgeInsets:UIEdgeInsetsMake(10, 25, 10, 10)];

    [shareButton setImage:[UIImage imageNamed:@"btn_share_default.png"] forState:UIControlStateNormal];
    shareButton.backgroundColor=View_ToolBar;
    //[shareButton setBackgroundImage:[UIImage imageNamed:@"login_alpa_backgroundcolor.png"] forState:UIControlStateNormal];
    shareButton.tag=10001;
    [buttomShareView addSubview:shareButton];
    
    zanbutton =[ZCControl createButtonWithFrame:CGRectMake(_alertView.frame.size.width/2, 0,_alertView.frame.size.width/2, 45) ImageName:nil Target:self Action:@selector(dealButtomClick:) Title:@""];
    [zanbutton setTitleColor:VBlue_color forState:UIControlStateNormal];
    zanbutton.tag=10002;
    zanbutton.backgroundColor=View_ToolBar;
    [zanbutton setTitleEdgeInsets:UIEdgeInsetsMake(10, 25, 10, 10)];
    zanbutton.titleLabel.font=[UIFont systemFontOfSize:14];
    
    // 在赞上面添加一个大拇指
    likeimageview=[[UIImageView alloc]initWithFrame:CGRectMake((zanbutton.frame.size.width)/2-15,zanbutton.frame.size.height/2-10, 25, 25)];
    likeimageview.image=[UIImage imageNamed:@"opened_like_icon.png"];
    [zanbutton addSubview:likeimageview];

    //高亮显示
    [buttomShareView addSubview:zanbutton];
    
//    UIView  *lineView1=[[UIView alloc]initWithFrame:CGRectMake(alertView.frame.size.width/2, 0,1,buttomShareView.frame.size.height)];
//    lineView1.backgroundColor=VLight_GrayColor;
//    [buttomShareView addSubview:lineView1];
//    
    
    morebuton=[ZCControl createButtonWithFrame:CGRectMake(0,0,30,45) ImageName:nil Target:self Action:@selector(dealButtomClick:) Title:@""];
    [morebuton setImage:[UIImage imageNamed:@"alert_more"] forState:UIControlStateNormal];
    morebuton.tag=10003;
    [buttomShareView addSubview:morebuton];


}
// 设置toolbar 的值
-(void)configToolBar
{
    //获取了当前微博对象，如果当前的微博对象在数组中有的话，那就需要显示为已赞

    //头像
    NSURL  *headURL =[NSURL URLWithString:[NSString stringWithFormat:@"%@%@!thumb",kUrlAvatar,self.weiboInfo.uerInfo.logo]];
    [headButton sd_setBackgroundImageWithURL:headURL forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"user_normal.png"]];
    //名字
    userNamelabel.text =self.weiboInfo.uerInfo.username;
    
    //时间
    //NSString *timeStr =[Function getTimeIntervalfromInerterval:self.weiboInfo.created_at];
    
   //根据时间戳转化成时间
    NSDate  *comfromTimesp =[NSDate dateWithTimeIntervalSince1970:[self.weiboInfo.created_at intValue]];
    NSString  *da = [NSDate timeInfoWithDate:comfromTimesp];
    timelabel.text=da;
    
   // //内容
    contentLable.text =self.weiboInfo.content;
    
   ////标签
    [self removeTagViewFromSuperView];
    leadWidth=0;
    
    if (self.weiboInfo.tagArray&&self.weiboInfo.tagArray.count) {
        tagLable=[[M80AttributedLabel alloc]initWithFrame:CGRectZero];
        tagLable.backgroundColor =[UIColor clearColor];
        for (int i=0; i<self.weiboInfo.tagArray.count; i++) {
            TagView *tagview = [self createTagViewWithtagInfo:self.weiboInfo.tagArray[i] andIndex:i];
            [tagLable appendView:tagview margin:UIEdgeInsetsMake(0, 0, 0, 10)];
            tagLable.lineSpacing=5;
            tagLable.numberOfLines=0;
         }
      
        [_alertView addSubview:tagLable];
     }
    
    for (int i=0; i<self.upweiboArray.count; i++) {
        UpweiboModel *upmodel=self.upweiboArray[i];
        if ([upmodel.weibo_id intValue]==[self.weiboInfo.Id intValue]) {
            zanbutton.selected=YES;
            likeimageview.image=[UIImage imageNamed:@"opened_liked_icon.png"];
            break;
        }
        else{
            zanbutton.selected=NO;
            likeimageview.image=[UIImage imageNamed:@"opened_like_icon.png"];
        }
    }
    
}
//创建标签的方法
-(TagView *)createTagViewWithtagInfo:(TagModel *) tagmodel andIndex:(NSInteger ) index
{
    
    TagView *tagview =[[TagView alloc]initWithWeiboInfo:self.weiboInfo AndTagInfo:tagmodel delegate:self isCanClick:YES backgoundImage:nil isLongTag:YES];
    [tagview setbigTag:YES];
    //tagview.frame=CGRectMake(0, 0, 0, 0);
//    tagview.tag=1000+index;
//    tagview.delegete=self;
//    //设置是否可以点击
//    [tagview setTagViewIsClick:YES];
//    tagview.tagInfo=tagmodel;
//    tagview.weiboInfo=self.weiboInfo;
//    NSString *titleStr = tagmodel.tagDetailInfo.title;
//    tagview.titleLable.text=titleStr;
//    CGSize  Tsize =[titleStr boundingRectWithSize:CGSizeMake(MAXFLOAT, TagHeight) options:(NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin) attributes:[NSDictionary dictionaryWithObject:tagview.titleLable.font forKey:NSFontAttributeName] context:nil].size;
//     tagview.frame=CGRectMake(0,0, Tsize.width+10, TagHeight+10);
    return tagview;
}


-(void)alertViewTap:(UITapGestureRecognizer *) tap
{
    
    
    //
}

#pragma mark
#pragma mark  －－－－底部视图的点击事件
//底部视图的点击事件
-(void)dealButtomClick:(UIButton  *) button
{
    
    
    if (button.tag==10002) {
      if (zanbutton.selected==YES) {
        zanbutton.selected=NO;
        likeimageview.image=[UIImage imageNamed:@"opened_like_icon.png"];
      }
      else if (zanbutton.selected==NO)
      {
        zanbutton.selected=YES;
        //如果按钮点击的是赞的话
        if (button==zanbutton) {
        //执行放大动画又缩小回去
           likeimageview.image=[UIImage imageNamed:@"opened_liked_icon.png"];
            [Function BasicAnimationwithkey:@"transform.scale" Duration:0.25 repeatcont:1 autoresverses:YES fromValue:1.0 toValue:1.5 View:likeimageview];
        }
        
    }
    }
    if (self.delegete &&[self.delegete respondsToSelector:@selector(ToolViewHandClick::weiboDict:StageInfo:)]) {
        [self.delegete ToolViewHandClick:button :_markView weiboDict:self.weiboInfo StageInfo:self.stageInfo];
    }
   // [self removeFromSuperview];
}


//显示底部试图
-(void)ShowButtomView;
{
    
     [AppView addSubview:self];
   /* [UIView animateWithDuration:0.1 animations:^{
        _alertView.alpha=1;
        
    } completion:^(BOOL finished) {
        [Function BasicAnimationwithkey:@"transform.scale" Duration:0.20 repeatcont:1 autoresverses:YES fromValue:1.0 toValue:1.02 View:self.alertView];
    }];*/
    //[self.alertView.layer addAnimation:[self getKeyframeAni] forKey:@"popView"];
    [self.alertView.layer addAnimation:[Function getKeyframeAni] forKey:@"popAnimition"];
    
}

//隐藏底部试图
-(void)HidenButtomView;
{
    [UIView animateWithDuration:0.2 animations:^{
        _alertView.alpha=1;
    } completion:^(BOOL finished) {
        
    }];
}


//创建标签之前移除标签
-(void)removeTagViewFromSuperView
{
    //移除标签
    for (id view in _alertView.subviews) {
        if ([view isKindOfClass:[M80AttributedLabel class]]) {
            [view removeFromSuperview];
            
        }
    }
    
}
#pragma mark -------TapViewClickDelegete---------------------------------------------
-(void)TapViewClick:(id)tagView Withweibo:(weiboInfoModel *)weiboInfo withTagInfo:(TagModel *)tagInfo
{
    if (self.delegete &&[self.delegete respondsToSelector:@selector(ToolViewTagHandClickTagView:withweiboinfo:WithTagInfo:)]) {
        [self.delegete ToolViewTagHandClickTagView:tagView withweiboinfo:weiboInfo WithTagInfo:tagInfo];
    }
}

-(void)closeAlertViewClick
{
    [self.markView CancelMarksetSelect];
    [self removeFromSuperview];
}

//布局子视图
-(void)layoutSubviews
{
    [super layoutSubviews];
    //文字的高度
    CGFloat wheight=kDeviceWidth-30-headButton.frame.size.width-headButton.frame.origin.x-10-10;
    if (IsIphone6) {
        wheight=wheight-20;
    }
    if (IsIphone6plus) {
        wheight=wheight-40;
    }
    //计算文字的高度
    NSString *weiboString = self.weiboInfo.content;
    CGSize  Wsize=[weiboString boundingRectWithSize:CGSizeMake(wheight, MAXFLOAT) options:(NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin) attributes:[NSDictionary dictionaryWithObject:contentLable.font forKey:NSFontAttributeName] context:nil].size;
    float  x=15;
    if (IsIphone6) {
        x=25;
    }
    if (IsIphone6plus) {
        x=35;
    }
    //ji 算标签的高度
    CGSize  Tsize=CGSizeMake(0.1, 0.1);
    //10+头像高度＋文字高度＋10+标签高度＋10+分享的高度
    float  tagHeight=0;
    if (self.weiboInfo.tagArray.count>0) {
        //计算tag的高度
         Tsize =[tagLable sizeThatFits:CGSizeMake(kDeviceWidth-(2*x)-35-20, CGFLOAT_MAX)];
         tagHeight=Tsize.height+0;
    }


    float  alertHeight = 10+headButton.frame.size.height+10+Wsize.height+tagHeight+buttomShareView.frame.size.height+15;
    float  y=(self.frame.size.height-alertHeight)/2;
    _alertView.frame=CGRectMake(x,y,kDeviceWidth-(2*x), alertHeight+0);
    

    
    
    //关闭按钮
    closealertView.frame=CGRectMake(_alertView.frame.size.width-36,0, 36, 36);
     //文字的高度
    contentLable.frame=CGRectMake(userNamelabel.frame.origin.x, headButton.frame.origin.y+headButton.frame.size.height+10, _alertView.frame.size.width-userNamelabel.frame.origin.x-10, Wsize.height);
    
    tagLable.frame=CGRectMake(userNamelabel.frame.origin.x, contentLable.frame.origin.y+contentLable.frame.size.height+5,contentLable.frame.size.width, Tsize.height+0);
    
    buttomShareView.frame=CGRectMake(buttomShareView.frame.origin.x, _alertView.frame.size.height-45,_alertView.frame.size.width, 45);
    shareButton.frame=CGRectMake(0,0,buttomShareView.frame.size.width/2, 45);
    zanbutton.frame=CGRectMake(buttomShareView.frame.size.width/2, 0, buttomShareView.frame.size.width/2, 45);
    
}

-(void)dealloc
{
    
}
@end
