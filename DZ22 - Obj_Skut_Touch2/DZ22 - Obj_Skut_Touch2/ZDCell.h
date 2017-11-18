//
//  ZDCell.h
//  DZ22 - Obj_Skut_Touch2
//
//  Created by mac on 18.11.17.
//  Copyright © 2017 Dima Zgera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#
#import "ZDCheker.h"

@interface ZDCell : NSObject

@property (strong, nonatomic) UIImageView* cellView;
@property (assign, nonatomic) ZDCheckerType cellType;
@property (assign, nonatomic) CGPoint cellCord;
@property (strong, nonatomic) ZDChecker* cellChecker;

- (instancetype)initCellWithPoint:(CGPoint)point cellPoint:(CGPoint)cellPoint size:(CGFloat)rectSize color:(ZDCheckerType)color;

- (void) clear;


@end
