//
//  NotificationTableViewCell.h
//  movienext
//
//  Created by 风之翼 on 15/3/2.
//  Copyright (c) 2015年 redianying. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol NotificationTableViewCellDelegate <NSObject>
-(void)NotificationClick:(UIButton *) button indexPath:(NSInteger) index;
@end
@interface NotificationTableViewCell : UITableViewCell
{
    UIButton    *logoButton;  ///头像
    UILabel     *titleLable;  //标题
    UILabel     *dateLable;   //时间
    UIImageView   *stageImage;   // 剧情图片
    UILabel     *Zanlable;
    UIButton  *titleButon;
    NSInteger  _index;
}
@property (assign,nonatomic)id <NotificationTableViewCellDelegate> delegate;
-(void)setValueforCell:(NSDictionary  *) dict index: (NSInteger )index;
@end
