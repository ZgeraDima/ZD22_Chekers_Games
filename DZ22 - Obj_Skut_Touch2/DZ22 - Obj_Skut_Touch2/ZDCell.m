//
//  ZDCell.m
//  DZ22 - Obj_Skut_Touch2
//
//  Created by mac on 18.11.17.
//  Copyright © 2017 Dima Zgera. All rights reserved.
//

#import "ZDCell.h"

@implementation ZDCell

- (instancetype)initCellWithPoint:(CGPoint)point cellPoint:(CGPoint)cellPoint size:(CGFloat)rectSize color:(ZDCheckerType)color
{
    self = [super init];
    if (self) {
        self.cellView = [[UIImageView alloc] initWithFrame:CGRectMake(point.x, point.y, rectSize, rectSize)];
        self.cellType = color;
        self.cellView.image = [UIImage imageNamed:(color == checkerTypeBlack) ? @"cellblack.png" : @"cellwhite.png" ];
        self.cellCord = CGPointMake(cellPoint.x, cellPoint.y);
    }
    return self;
}

- (void) clear {
    [self.cellChecker clear];
    self.cellChecker = nil;
}


@end
