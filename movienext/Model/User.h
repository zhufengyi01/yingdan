//
//  User.h
//  movienext
//
//  Created by 杜承玖 on 14/11/22.
//  Copyright (c) 2014年 redianying. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  用户模型
 */
@interface User : NSObject
/** 用户ID */
@property (nonatomic, strong) NSString * user_id;
/** 头像 */
@property (nonatomic, strong) NSString * avatar;
/** 是否+V */
@property (nonatomic, strong) NSString * verified;
/** 用户名 */
@property (nonatomic, strong) NSString * username;
/** 是否为管理员 1-管理员 0-普通用户 */
@property (nonatomic, strong) NSString * is_admin;
/** 用户页面壁纸图片文件名 */
@property (nonatomic, strong) NSString * wallpaper;
/** 更新时间 */
@property (nonatomic, strong) NSString * update_time;
/** 用户签名 */
@property (nonatomic, strong) NSString * signature;
/** 用户的作品被喜欢的总数 */
@property (nonatomic, strong) NSString * like_count;
/** 用户的作品数量 */
@property (nonatomic, strong) NSString * product_count;
/** 用户绑定的类型：sina 或 qzone */
@property (nonatomic, strong) NSString * user_bind_type;
+(id)shareInstance;
-(id)initWithDictionary:(NSDictionary *)dict;

-(NSDictionary *)convertToDictionary;

@end
