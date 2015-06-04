//
//  NewAddViewController.m
//  movienext
//
//  Created by 风之翼 on 15/5/29.
//  Copyright (c) 2015年 redianying. All rights reserved.
//

#import "NewAddViewController.h"
//typedef NS_ENUM(<#_type#>, <#_name#>) <#name#>
#import "Function.h"
#import "UserDataCenter.h"

#import "ShowStageViewController.h"

#import "SmallImageCollectionViewCell.h"

#import "AFNetworking.h"

#import "ZCControl.h"

#import "Constant.h"

#import "LoadingView.h"

#import "MJRefresh.h"

#import "weiboInfoModel.h"

#import "UIImageView+WebCache.h"

@interface NewAddViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,LoadingViewDelegate>
{
    UICollectionViewFlowLayout    *layout;

    int pageSize;
    int page;
    int pageCount;
    LoadingView         *loadView;
    UserDataCenter     *userCenter;

    
}
@end

@implementation NewAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initUI];
    [self createNavigation];
    [self requestData];

}
-(void)createNavigation
{
    
   NSString  *titleString=@"最新添加";
    if (self.pageType==NSNewAddPageSoureTypeCloseWeiboList) {
        titleString =@"已屏蔽的微博";
    }
    UILabel  *titleLable=[ZCControl createLabelWithFrame:CGRectMake(0, 0, 100, 20) Font:16 Text:titleString];
    titleLable.textColor=VGray_color;
    
    titleLable.font=[UIFont boldSystemFontOfSize:18];
    titleLable.textAlignment=NSTextAlignmentCenter;
    self.navigationItem.titleView=titleLable;
    

}
-(void)initData
{
    page=1;
    pageSize=20;
    pageCount=1;
    userCenter=[UserDataCenter shareInstance];
    _dataArray =[[NSMutableArray alloc]init];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initUI
{
    layout=[[UICollectionViewFlowLayout alloc]init];
    //layout.minimumInteritemSpacing=10; //cell之间左右的
    //layout.minimumLineSpacing=10;      //cell上下间隔
    //layout.itemSize=CGSizeMake(80,140);  //cell的大小
         layout.sectionInset=UIEdgeInsetsMake(0,0,64, 0); //整个偏移量 上左下右
     _myConllectionView =[[UICollectionView alloc]initWithFrame:CGRectMake(0,0,kDeviceWidth, kDeviceHeight-20-0) collectionViewLayout:layout];
    //[layout setHeaderReferenceSize:CGSizeMake(_myConllectionView.frame.size.width, kDeviceHeight/3+64+110)];
    
    _myConllectionView.backgroundColor=View_BackGround;
    //注册大图模式
    //[_myConllectionView registerClass:[BigImageCollectionViewCell class] forCellWithReuseIdentifier:@"bigcell"];
    
    //注册小图模式
    [_myConllectionView registerClass:[SmallImageCollectionViewCell class] forCellWithReuseIdentifier:@"smallcell"];
    // 注册头部视图
    //[_myConllectionView registerClass:[MovieHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
    _myConllectionView.delegate=self;
    _myConllectionView.dataSource=self;
    
    [self.view addSubview:_myConllectionView];
    
    [self setupHeadView];
    [self setupFootView];
}

- (void)setupHeadView
{
    
    __unsafe_unretained typeof(self) vc = self;
    // 添加下拉刷新头部控件
    [_myConllectionView addHeaderWithCallback:^{
        page=1;
        if (self.dataArray.count>0) {
            [vc.dataArray removeAllObjects];
        }
        // 进入刷新状态就会回调这个Block
        [vc requestData];
        
        // 模拟延迟加载数据，因此2秒后才调用）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //[vc.myConllectionView reloadData];
            // 结束刷新
            [vc.myConllectionView headerEndRefreshing];
        });
    }];
#warning 自动刷新(一进入程序就下拉刷新)
    // [vc.myConllectionView headerBeginRefreshing];
}


- (void)setupFootView
{
    __unsafe_unretained typeof(self) vc = self;
    // 添加上拉刷新尾部控件
    [vc.myConllectionView addFooterWithCallback:^{
        // 进入刷新状态就会回调这个Block
        if (pageCount>page) {
            page=page+1;
            [vc requestData];
        }
        // 模拟延迟加载数据，因此2秒后才调用）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //  [vc.myConllectionView reloadData];
            // 结束刷新
            [vc.myConllectionView footerEndRefreshing];
        });
    }];
}

-(void)creatLoadView
{
    loadView =[[LoadingView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
    loadView.delegate=self;
    [self.view addSubview:loadView];
}

-(void)requestData
{
    //UserDataCenter *userCenter =[UserDataCenter shareInstance];
    NSDictionary *parameters = @{@"user_id":userCenter.user_id};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString  *urlString;
    if (self.pageType==NSNewAddPageSoureTypeNewList) {
       urlString =[NSString stringWithFormat:@"%@/weibo/listrecently?per-page=%d&page=%d", kApiBaseUrl,pageSize,page];

    }
    else if(self.pageType==NSNewAddPageSoureTypeCloseWeiboList)
    {
        urlString =[NSString stringWithFormat:@"%@/weibo/block-list?per-page=%d&page=%d", kApiBaseUrl,pageSize,page];

    }
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([[responseObject  objectForKey:@"code"]  intValue]==0) {
            pageCount=[[responseObject objectForKey:@"pageCount"] intValue];
            NSMutableArray   *array  = [[NSMutableArray alloc]initWithArray:[responseObject objectForKey:@"models"]];
            for ( int i=0 ; i<array.count; i++) {
                NSDictionary  *newdict  =[array objectAtIndex:i];
                weiboInfoModel *weibomodel =[[weiboInfoModel alloc]init];
                if (weibomodel) {
                    [weibomodel setValuesForKeysWithDictionary:newdict];
                    //用户的信息
                    weiboUserInfoModel  *usermodel =[[weiboUserInfoModel alloc]init];
                    if (usermodel) {
                        if (![[newdict objectForKey:@"user"] isKindOfClass:[NSNull class]]) {
                            [usermodel setValuesForKeysWithDictionary:[newdict objectForKey:@"user"]];
                            weibomodel.uerInfo=usermodel;
                        }
                       
                    }
                // 剧情信息
                    stageInfoModel  *stagemodel =[[stageInfoModel alloc]init];
                    if (stagemodel) {
                        if (![[newdict objectForKey:@"stage"]  isKindOfClass:[NSNull class]]) {
                        [stagemodel setValuesForKeysWithDictionary:[newdict objectForKey:@"stage"]];
                        weibomodel.stageInfo=stagemodel;
                       }
                    }
                    NSMutableArray  *tagArray =[[NSMutableArray alloc]init];
              //标签数组
                    for ( NSDictionary  *tagdict in [newdict objectForKey:@"tags"]) {
                        TagModel *tagmodel=[[TagModel alloc]init];
                        if (tagmodel) {
                            [tagmodel setValuesForKeysWithDictionary:tagdict];
                            
                            TagDetailModel *tagdetail =[[TagDetailModel alloc]init];
                            if (tagdetail) {
                                [tagdetail setValuesForKeysWithDictionary:[tagdict objectForKey:@"tag"]];
                                tagmodel.tagDetailInfo=tagdetail;
                            }
                            [tagArray addObject:tagmodel];
                        }
                    }
                
                    weibomodel.tagArray=tagArray;
                    [self.dataArray addObject:weibomodel];
                }
                
            }
            
            [self.myConllectionView reloadData];
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}


#pragma  mark
#pragma mark - UICollectionViewDataSource ----

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (collectionView==_myConllectionView) {
        return 1;
    }
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView==_myConllectionView) {
        return _dataArray.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SmallImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"smallcell" forIndexPath:indexPath];
    //在这里先将内容给清除一下, 然后再加载新的, 添加完内容之后先动画, 在cell消失的时候做清理工作
    if (_dataArray.count>indexPath.row) {
        
        weiboInfoModel  *model=[_dataArray objectAtIndex:indexPath.row];
        cell.imageView.backgroundColor=VStageView_color;
        NSURL  *url =[NSURL URLWithString:[NSString stringWithFormat:@"%@%@!w340h340",kUrlStage,model.stageInfo.photo]];
       
        [cell.imageView sd_setImageWithURL:url placeholderImage:nil options:(SDWebImageRetryFailed|SDWebImageLowPriority)];
       cell.titleLab.text=[NSString stringWithFormat:@"%@",model.content];
         return cell;
    
    }
    return cell;
}
//点击小图模式的时候，跳转到大图模式
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
        ShowStageViewController *vc = [[ShowStageViewController alloc] init];
        weiboInfoModel *model=[_dataArray objectAtIndex:indexPath.row];
        //vc.upweiboArray=_upWeiboArray;
        vc.stageInfo = model.stageInfo;
       vc.weiboInfo=model;
        UIBarButtonItem  *item =[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.backBarButtonItem=item;
        
        [self.navigationController pushViewController:vc animated:YES];
    
}


//设置头尾部内容
/*-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
 {
 UICollectionReusableView *reusableView = nil;
 
 if (kind == UICollectionElementKindSectionHeader) {
 //定制头部视图的内容
 MovieHeadView *headerV = (MovieHeadView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView" forIndexPath:indexPath];
 headerV.delegate=self;
 headerV.movieInfo=moviedetailmodel;
 [headerV setCollectionHeaderValue];
 reusableView = headerV;
 }
 return reusableView;
 }*/
#pragma  mark ----
#pragma  mark -----UICollectionViewLayoutDelegate
#pragma  mark ----

// 设置每个item的尺寸
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((kDeviceWidth-5)/2,(kDeviceWidth-10)/3);
 }

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
     return UIEdgeInsetsMake(0,0, 5,0);
}
//左右间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
     return 0;
}
//上下
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
     return 5;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
