//
//  CommonStageCell.m
//  movienext
//
//  Created by 风之翼 on 15/3/3.
//  Copyright (c) 2015年 redianying. All rights reserved.
//

#import "CommonStageCell.h"
#import "Constant.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "Function.h"
#import "ZCControl.h"
//#import "MarkView.h"
@implementation CommonStageCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[ super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        m_frame=self.frame;
       // NSLog(@"=========打印cell 的frame ====%f");
        // 初始化放置标签的数组，每次创建的时候讲markview 添加到这个数组中
       // _MarkMuatableArray =[[NSMutableArray alloc]init];
        [self CreateUI];
    }
    return self;
}
-(void)CreateUI
{
    self.backgroundColor =[UIColor blackColor];
    //上部视图，包含头像，点赞
    [self CreateTopView];
    //中间的stageview 视图
    [self CreateSatageView];
      //底部视图
    [self createButtomView];
  
}
-(void)CreateTopView
{
    BgView0 =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 0)];
    BgView0.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:BgView0];
    
    UserLogoButton =[ZCControl createButtonWithFrame:CGRectMake(10, 8, 30, 30) ImageName:nil Target:self.superview Action:@selector(UserLogoButtonClick:) Title:@"头像"];
    UserLogoButton.layer.cornerRadius=4;
    UserLogoButton.layer.masksToBounds = YES;
    [BgView0 addSubview:UserLogoButton];
    
    UserNameLable =[ZCControl createLabelWithFrame:CGRectMake(UserLogoButton.frame.origin.x + UserLogoButton.frame.size.width + 5, 8, 180, 15) Font:14 Text:@"名字"];
    UserNameLable.textColor=VGray_color;
    UserNameLable.numberOfLines = 1;
    [BgView0 addSubview:UserNameLable];
    
    TimeLable =[ZCControl createLabelWithFrame:CGRectMake(UserNameLable.frame.origin.x, 23, 140, 15) Font:12 Text:@"时间"];
    TimeLable.textColor=VGray_color;
    [BgView0 addSubview:TimeLable];
    
    deletButton=[ZCControl createButtonWithFrame:CGRectMake(kDeviceWidth-50, 10, 40, 27) ImageName:@"btn_delete.png" Target:self.superview Action:@selector(delectButtonClick:) Title:@""];
    deletButton.layer.cornerRadius=2;
    //deletButton.backgroundColor=[UIColor redColor];
    deletButton.hidden=YES;
    //[ZanButton setBackgroundImage:[UIImage imageNamed:@"liked.png"] forState:UIControlStateSelected];
    [BgView0 addSubview:deletButton];
    
    
    ZanButton =[ZCControl createButtonWithFrame:CGRectMake(kDeviceWidth-55, 10, 45, 27) ImageName:@"btn_like_default.png" Target:self.superview Action:@selector(ZanButtonClick:) Title:@""];
    ZanButton.layer.cornerRadius=2;
    [ZanButton setBackgroundImage:[UIImage imageNamed:@"btn_like_select.png"] forState:UIControlStateSelected];
    //[BgView0 addSubview:ZanButton];
}

-(void)CreateSatageView
{
    _stageView=[[StageView alloc]initWithFrame:CGRectMake(0, 45, kDeviceWidth, 200)];
    _stageView.backgroundColor=[UIColor blackColor];
    _stageView.delegate=self;
    [self.contentView addSubview:_stageView];
    /*
    _MovieImageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 200)];
    [BgView1 addSubview:_MovieImageView];
    */
 
}

-(void)createButtomView
{
    BgView2=[[UIView alloc]initWithFrame:CGRectMake(0, kDeviceWidth, kDeviceWidth, 45)];
    //改变toolar 的颜色
    BgView2.backgroundColor=View_ToolBar;
    [self.contentView addSubview:BgView2];
    
    
    leftButtomButton=[UIButton buttonWithType:UIButtonTypeCustom];
    leftButtomButton.frame=CGRectMake(10, 10, 120, 26);
    [leftButtomButton setBackgroundImage:[[UIImage imageNamed:@"movie_icon_backgroud_color.png"]stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
    [leftButtomButton addTarget:self.superview action:@selector(dealMovieButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [leftButtomButton setTitleColor:VGray_color forState:UIControlStateNormal];
    [leftButtomButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 33, 0, 5)];
    leftButtomButton.titleLabel.font = [UIFont systemFontOfSize:13];
    leftButtomButton.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [BgView2 addSubview:leftButtomButton];
    
    MovieLogoImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0,0,30, 26)];
    MovieLogoImageView.layer.cornerRadius=5;
    MovieLogoImageView.layer.masksToBounds = YES;
    [leftButtomButton addSubview:MovieLogoImageView];
    
    
    ScreenButton =[ZCControl createButtonWithFrame:CGRectMake(kDeviceWidth-140,10,60,26) ImageName:@"btn_share_default.png" Target:self.superview Action:@selector(ScreenButtonClick:) Title:@""];
    [ScreenButton setBackgroundImage:[UIImage imageNamed:@"btn_share_select.png"] forState:UIControlStateHighlighted];
    [BgView2 addSubview:ScreenButton];
    
    addMarkButton =[ZCControl createButtonWithFrame:CGRectMake(kDeviceWidth-70,10,60,26) ImageName:@"btn_add_default.png" Target:self.superview Action:@selector(addMarkButtonClick:) Title:@""];
    [addMarkButton setBackgroundImage:[UIImage imageNamed:@"btn_add_select.png"] forState:UIControlStateHighlighted];
    [BgView2 addSubview:addMarkButton];
    
    
}
- (void)awakeFromNib {
    // Initialization code
}
-(void)ConfigsetCellindexPath:(NSInteger)row{
   // NSLog(@"=====在cell 里面打印  =WeibosArray==%p   index ===%ld",self.StageInfoDict,  row);
    //设置工具栏按钮的tag 值，可以根据tag值去获取点击按钮
    leftButtomButton.tag=1000+row;
    ScreenButton.tag=2000+row;
    addMarkButton.tag=3000+row;
    UserLogoButton.tag=4000+row;
    ZanButton.tag=5000+row;
    deletButton.tag=6000+row;

    
//   单个标签的时候用这个
     if (_weiboDict) {
         _stageView.weiboDict = _weiboDict;
     }
    // 多个标签用这个
     if (_WeibosArray.count>0) {
         _stageView.WeibosArray = _WeibosArray;
     }
    _stageView.StageInfoDict=self.StageInfoDict;
    [_stageView configStageViewforStageInfoDict];
    //这里计算hight 图片的高度，主要是为了计算toolbar 的y轴坐标，真实赋值是在stageview
    float  ImageWith=[self.StageInfoDict.w floatValue];//[[self.StageInfoDict objectForKey:@"w"]  floatValue];
    float  ImgeHight=[self.StageInfoDict.h floatValue];//[[self.StageInfoDict objectForKey:@"h"]  floatValue];
    float hight=0;
    hight= kDeviceWidth;  // 计算的事bgview1的高度
     if(ImgeHight>ImageWith)
    {
        hight=  (ImgeHight/ImageWith) *kDeviceWidth;
    }
#pragma mark 设置底部tool的图片，名字
    //设置底部
    if (self.StageInfoDict.movie_name) {  //电影名字，这里设置title 偏移
        [leftButtomButton setTitle:self.StageInfoDict.movie_name forState:UIControlStateNormal];
    }
    
    if (self.StageInfoDict.stage) {
        [MovieLogoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@!w100h100",kUrlMoviePoster,self.StageInfoDict.movie_poster] ] placeholderImage:[ UIImage imageNamed:@"loading_image_all.png"]];
    }
    
#pragma  mark  热门cell
    if (_pageType  ==NSPageSourceTypeMainHotController) {  //热门
         BgView0.frame=CGRectMake(0, 0, 0, 0);
        BgView0.hidden=YES;
        _stageView.frame=CGRectMake(0, 0, kDeviceWidth, hight);
        BgView2.frame=CGRectMake(0, kDeviceWidth, kDeviceWidth, 45);
        //这里设置为了表示气泡是可以移动的
        _stageView.isAnimation = YES;
    }
#pragma mark 首页最新,我的添加，赞 cell
    else if(_pageType==NSPageSourceTypeMainNewController || _pageType==NSPageSourceTypeMyAddedViewController || _pageType==NSPageSourceTypeMyupedViewController)  //最新
    {
        BgView0.hidden=NO;
        BgView0.frame=CGRectMake(0, 0, kDeviceWidth, 45);
        _stageView.frame=CGRectMake(0, 45, kDeviceWidth, hight);
        _stageView.isAnimation=NO;
        BgView2.frame=CGRectMake(0, hight+45,kDeviceWidth,45);
        [UserLogoButton sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@!thumb", kUrlAvatar, _weiboDict.avatar]] forState:UIControlStateNormal];
        UserNameLable.text = _weiboDict.username;
        TimeLable.text = [Function friendlyTime:_weiboDict.create_time];
        // 点赞按钮的状态
        if ([self.weiboDict.uped  intValue]==0) {
            ZanButton.selected=NO;
        }
        else
        {
            ZanButton.selected=YES;
        }
#pragma mark 区分于个人页面是来源于自己还是他人
        if (self.userPage==NSUserPageTypeMySelfController ) {  //进来的页面是从我自己的页面进来的
            deletButton.hidden=NO;
        }
        else
        {
            deletButton.hidden=YES;
        }
        
     
    }
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    
}

#pragma mark ---
#pragma mark ------下方按钮点击事件 ,在父视图中实现具体的方法
#pragma mark ------
-(void)dealMovieButtonClick:(UIButton  *) button{
    
}
-(void)ScreenButtonClick:(UIButton  *) button
{
    
}
-(void)addMarkButtonClick:(UIButton  *) button
{
    
}
-(void)UserLogoButtonClick:(UIButton *) button
{
    
}
-(void)ZanButtonClick:(UIButton *)button
{
    //点赞按钮
}
-(void)delectButtonClick:(UIButton *) button
{
    //删除按钮
   
}
#pragma mark   --
#pragma mark   --StageViewDelegate
#pragma mark   ---
//-(void)StageViewHandClickMark:(NSDictionary *)weiboDict withStageView:(id)stageView
//{

//}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
