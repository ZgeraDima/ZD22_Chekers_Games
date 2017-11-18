//
//  ZDCheker.m
//  DZ22 - Obj_Skut_Touch2
//
//  Created by mac on 18.11.17.
//  Copyright © 2017 Dima Zgera. All rights reserved.
//

#import "ZDCheker.h"
#import "ZDCell.h"


@implementation ZDChecker

- (instancetype)initWithColor:(ZDCheckerType)color inCell:(ZDCell*)cell
{
    self = [super init];
    if (self) {
        self.checkerImage = [[UIImageView alloc] initWithFrame:cell.cellView.frame];
        self.checkerImage.image = [UIImage imageNamed:(color == checkerTypeBlack) ?  @"black.png" : @"white.png"];
        self.checkerType = color;
        self.checkerCord = CGPointMake(cell.cellCord.x, cell.cellCord.y);
    }
    return self;
}

- (void) clear {
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.checkerImage.alpha = 0;
                         self.checkerImage.transform = CGAffineTransformMakeScale(0.5, 0.5);
                     }
                     completion:^(BOOL finished) {
                         self.checkerType = checkerTypeClear;
                         self.checkerImage.image = nil;
                         self.checkerImage = nil;
                         self.checkerCord = CGPointZero;
                     }];
}


@end
