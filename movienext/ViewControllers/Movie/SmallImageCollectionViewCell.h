//
//  SmallImageCollectionViewCell.h
//  movienext
//
//  Created by 风之翼 on 15/3/7.
//  Copyright (c) 2015年 redianying. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef NS_ENUM(NSInteger,NSSmallCellPage)
//{
//    NSSmallCellPageMovieDetail =100,
//    NSSmallCellPageSelectPhoto  =101,
//};

@interface SmallImageCollectionViewCell : UICollectionViewCell
{
    CGRect   m_frame;
}

@property(strong,nonatomic)UIImageView *imageView;
@property(strong,nonatomic)UILabel *titleLab;
@end
