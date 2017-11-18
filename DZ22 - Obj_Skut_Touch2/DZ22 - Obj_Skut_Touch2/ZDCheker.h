//
//  ZDCheker.h
//  DZ22 - Obj_Skut_Touch2
//
//  Created by mac on 18.11.17.
//  Copyright © 2017 Dima Zgera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#
@class ZDCell;

typedef enum {
    checkerTypeClear = 0,
    checkerTypeWhite = 1,
    checkerTypeBlack = 2
} ZDCheckerType ;

@interface ZDChecker : NSObject

@property (strong, nonatomic) UIImageView* checkerImage;
@property (assign, nonatomic) ZDCheckerType checkerType;
@property (assign, nonatomic) CGPoint checkerCord;
@property (strong, nonatomic) NSMutableArray* whereToGo;

- (instancetype) initWithColor:(ZDCheckerType)color inCell:(ZDCell*)cell;

- (void) clear;     //NOT CALLED

@end
