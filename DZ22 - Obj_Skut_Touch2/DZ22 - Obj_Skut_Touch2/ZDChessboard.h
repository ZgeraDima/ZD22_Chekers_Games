//
//  ZDChessboard.h
//  DZ22 - Obj_Skut_Touch2
//
//  Created by mac on 18.11.17.
//  Copyright © 2017 Dima Zgera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#
#import "ZDCheker.h"
#import "ZDCell.h"


@interface ZDChessboard : NSObject

@property (strong, nonatomic) UIView* chessView;
@property (strong, nonatomic) NSArray* cellArr;
@property (assign, nonatomic) ZDCheckerType round;

-(void) createChessboardInView:(UIView*)view;
-(void) startGame;

-(BOOL) step:(ZDChecker*)checker inCell:(ZDCell*)cell;

-(void) nextRound;

//-(void) navigation:(BOOL)flag inChecker:(ZDChecker*)checker;


@end
