//
//  ZDChessboard.m
//  DZ22 - Obj_Skut_Touch2
//
//  Created by mac on 18.11.17.
//  Copyright © 2017 Dima Zgera. All rights reserved.
//

#import "ZDChessboard.h"
#import "ZDCheker.h"
#import "ZDCell.h"


@implementation ZDChessboard

#pragma mark - createChessboard

-(void) createChessboardInView:(UIView*)view {
    
    [self createChessboardViewInView:view];
    [self createCell];
    
}

-(void) createChessboardViewInView:(UIView*)view {
    
    CGFloat rectSize = MIN(CGRectGetWidth(view.bounds), CGRectGetHeight(view.bounds));
    
    self.chessView = [[UIView alloc] initWithFrame:CGRectMake((CGRectGetWidth(view.bounds) - rectSize ) / 2,
                                                              (CGRectGetHeight(view.bounds) - rectSize ) / 2,
                                                              rectSize, rectSize)];
    
    self.chessView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    
    [view addSubview:self.chessView];
}

-(void) createCell {
    
    NSMutableArray* tempArr = [NSMutableArray array];
    
    CGFloat rectSize = CGRectGetWidth(self.chessView.bounds) / 8;
    
    for (int i = 0; i < 8; i++)
        for (int j = 0; j < 8; j++)
            [tempArr addObject:[[ZDCell alloc] initCellWithPoint:CGPointMake(rectSize * j, rectSize * i)
                                                       cellPoint:CGPointMake(j, i)
                                                            size:rectSize
                                                           color:(j+i)%2 ? checkerTypeBlack : checkerTypeWhite]];
    
    self.cellArr = [NSArray arrayWithArray:tempArr];
    
    for (ZDCell* cell in self.cellArr)
        [self.chessView addSubview:cell.cellView];
}


#pragma mark - createChecker

- (void) clearAllChecker {
    for (ZDCell* cell in self.cellArr)
        if (cell.cellChecker)
            cell.cellChecker = nil;         // (dealoc)_???
}

- (void) createChecker {
    
    for (ZDCell* cell in self.cellArr)
        if (cell.cellType == checkerTypeWhite) {
            if ( [self.cellArr indexOfObject:cell] < 24 ) {
                cell.cellChecker = [[ZDChecker alloc] initWithColor:checkerTypeWhite inCell:cell];
                [self.chessView addSubview:cell.cellChecker.checkerImage];
            }
            else if ( [self.cellArr indexOfObject:cell] > [self.cellArr count] - 24 ) {
                cell.cellChecker = [[ZDChecker alloc] initWithColor:checkerTypeBlack inCell:cell];
                [self.chessView addSubview:cell.cellChecker.checkerImage];
            }
        }
}

#pragma mark - roundStart

- (void) startGame {
    [self clearAllChecker];
    [self createChecker];
    
    self.round = checkerTypeWhite;
}

- (void) nextRound {
    self.round = ( self.round == checkerTypeWhite ? checkerTypeBlack : checkerTypeWhite );
    
    if ( ![self yetGame] )
        [self startGame];
}

- (BOOL) yetGame {
    
    ZDCheckerType tempFlag = checkerTypeClear;
    for (ZDCell* cell in self.cellArr)
        if (cell.cellChecker)
        {
            if (tempFlag == checkerTypeClear)
                tempFlag = cell.cellChecker.checkerType;
            
            else if ( cell.cellChecker.checkerType != tempFlag )
                return YES;
        }
    
    return NO;
    
}

#pragma mark - Navigation
/*
 -(void) navigation:(BOOL)flag inChecker:(PGChecker*)checker {
 
 if (!flag){
 for (PGCell* cell in checker.whereToGo)
 [cell.cellView.layer removeAllAnimations];
 }
 
 // method start
 NSInteger N = (checker.checkerType == checkerTypeBlack) ? 1 : -1;
 
 PGCell* leftWay = [[PGCell alloc] init];
 leftWay = [self findCellWithCord:CGPointMake(checker.checkerCord.x +(-9*N),
 checker.checkerCord.y +(11*N))];
 if (leftWay.cellChecker)
 leftWay = [self findCellWithCord:CGPointMake(leftWay.cellChecker.checkerCord.x +(-9*N),
 leftWay.cellChecker.checkerCord.y +(11*N))];
 if (leftWay.cellChecker)
 leftWay = nil;
 
 
 checker.whereToGo = [NSMutableArray arrayWithObjects:
 [self findCellWithCord:CGPointMake(checker.checkerCord.x +(-9*N),
 checker.checkerCord.y +(11*N))],
 [self findCellWithCord:CGPointMake(checker.checkerCord.x +(-9*N),
 checker.checkerCord.y +(11*N))],
 nil];
 
 PGCell* RightWay = [[PGCell alloc] init];
 RightWay = [self findCellWithCord:CGPointMake(checker.checkerCord.x +(-9*N),
 checker.checkerCord.y +(11*N))];
 if (RightWay.cellChecker)
 RightWay = [self findCellWithCord:CGPointMake(RightWay.cellChecker.checkerCord.x +(-9*N),
 RightWay.cellChecker.checkerCord.y +(11*N))];
 if (RightWay.cellChecker)
 RightWay = nil;
 
 // method end
 
 [UIView animateWithDuration:0.5
 delay:0
 options:UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat
 animations:^{
 for (PGCell* cell in checker.whereToGo)
 cell.cellView.alpha = 0.5;
 }
 completion:^(BOOL finished) { }];
 
 }
 */

#pragma mark - STEP

-(BOOL) step:(ZDChecker*)checker inCell:(ZDCell*)cell {             //Eesy specification
    
    if (cell == nil)
        return NO;
    
    if (checker == nil)
        return NO;
    
    if (CGPointEqualToPoint(checker.checkerCord, cell.cellCord))
        return NO;
    
    if (cell.cellChecker != nil)
        return NO;
    
    ZDCell* oldCell = [[ZDCell alloc] init];
    oldCell = [self findCellWithCord:checker.checkerCord];
    
    if ( ![self stepWith:oldCell.cellCord to:cell.cellCord color:checker.checkerType] )
        return NO;
    
    oldCell.cellChecker = nil;
    checker.checkerCord = cell.cellCord;
    cell.cellChecker = checker;
    
    [self nextRound];
    return YES;
}

- (bool) stepWith:(CGPoint)oldPoint to:(CGPoint)newPoint color:(ZDCheckerType)color {       //Hard specification
    
    NSInteger N = (color == checkerTypeBlack) ? 1 : -1;
    
    NSInteger diffirence = (oldPoint.x - newPoint.x) * 10 + (oldPoint.y - newPoint.y);
    
    if ( diffirence == (-9 * N) || diffirence == (11 * N) )     // -9||11 -- black ; 9||-11 -- white
        return YES;
    
    if ( [self abs:diffirence] == 18 || [self abs:diffirence] == 22 )  // -18||22 -- black ; 18||-22 -- white (kill revers)
        return [self killBetween:oldPoint and:newPoint color:color];
    
    return NO;
}

- (BOOL) killBetween:(CGPoint)oldPoint and:(CGPoint)newPoint color:(ZDCheckerType)color {
    
    ZDCell* deadCell = [self findCellWithCord:CGPointMake((oldPoint.x + newPoint.x) / 2,
                                                          (oldPoint.y + newPoint.y) / 2)];
    
    if (deadCell.cellChecker && deadCell.cellChecker.checkerType != color) {
        [deadCell clear];
        return YES;
    }
    
    return NO;
}

- (NSUInteger) abs:(NSInteger)N {
    return (N < 0) ? -N : N;
}

- (ZDCell*) findCellWithCord:(CGPoint)cord {
    for (ZDCell* cell in self.cellArr)
        if ( CGPointEqualToPoint(cell.cellCord, cord) )
            return  cell;
    
    return nil;
}






@end
