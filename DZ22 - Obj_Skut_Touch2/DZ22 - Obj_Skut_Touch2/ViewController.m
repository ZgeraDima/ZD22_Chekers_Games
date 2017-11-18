//
//  ViewController.m
//  DZ22 - Obj_Skut_Touch2
//
//  Created by mac on 18.11.17.
//  Copyright © 2017 Dima Zgera. All rights reserved.
//

#import "ViewController.h"
#
#import "ZDChessboard.h"


@interface ViewController ()

@property (strong, nonatomic) ZDChessboard* chessboard;

@property (weak, nonatomic) ZDChecker* draggingChecker;
@property (assign, nonatomic) CGPoint memoryPoint;
@property (assign, nonatomic) CGPoint correctedPoint;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self createTable];
    
    self.chessboard = [[ZDChessboard alloc] init];
    [self.chessboard createChessboardInView:self.view];
    
    [self.chessboard startGame];
    
}

#pragma mark - Support

- (NSUInteger)supportedInterfaceOrientations {
    
    return  UIInterfaceOrientationMaskAll;
}

- (BOOL) prefersStatusBarHidden {
    return YES;
}

#pragma mark - Table

- (void) createTable {
    
    UIImageView* tableView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    tableView.image = [UIImage imageNamed:@"table.png"];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:tableView];
    
}

#pragma mark - Touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    CGPoint touchPoint = [[touches anyObject] locationInView:self.chessboard.chessView];
    
    self.draggingChecker = [self checkerInPoint:touchPoint];
    
    if (self.draggingChecker) {
        CGPoint touchPoint = [[touches anyObject] locationInView:self.draggingChecker.checkerImage];
        
        self.memoryPoint = self.draggingChecker.checkerImage.center;
        self.correctedPoint = CGPointMake(CGRectGetMidX(self.draggingChecker.checkerImage.bounds) - touchPoint.x,
                                          CGRectGetMidY(self.draggingChecker.checkerImage.bounds) - touchPoint.y);
        
        //[self.chessboard navigation:YES inChecker:self.draggingChecker];
        
        [UIView animateWithDuration:0.3
                         animations:^{
                             [self.chessboard.chessView bringSubviewToFront:self.draggingChecker.checkerImage];
                             self.draggingChecker.checkerImage.transform = CGAffineTransformMakeScale(1.3, 1.3);
                             self.draggingChecker.checkerImage.alpha = 0.7;
                         }];
    }
}



- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    CGPoint movePoint = [[touches anyObject] locationInView:self.chessboard.chessView];
    
    self.draggingChecker.checkerImage.center = CGPointMake(movePoint.x + self.correctedPoint.x,
                                                           movePoint.y + self.correctedPoint.y);
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    //[self.chessboard navigation:NO inChecker:self.draggingChecker];
    
    CGPoint lastPoint = [[touches anyObject] locationInView:self.chessboard.chessView];
    CGPoint lastPointCorrect = CGPointMake(lastPoint.x + self.correctedPoint.x,
                                           lastPoint.y + self.correctedPoint.y);
    
    ZDCell* nowCell = [self cellInPoint:lastPointCorrect];
    
    if ( [self.chessboard step:self.draggingChecker inCell:nowCell] )
        
        self.draggingChecker.checkerImage.center = nowCell.cellView.center;
    else
        [UIView animateWithDuration:0.3 animations:^{
            self.draggingChecker.checkerImage.center = self.memoryPoint;
        }];
    
    
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.draggingChecker.checkerImage.transform = CGAffineTransformMakeScale(1, 1);
                         self.draggingChecker.checkerImage.alpha = 1;
                     }];
    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesEnded:touches withEvent:event];
}

- (ZDChecker*) checkerInPoint:(CGPoint)touchPoint {
    
    for (ZDCell* cell in self.chessboard.cellArr)
        if ( CGRectContainsPoint(cell.cellChecker.checkerImage.frame, touchPoint) ) {
            if (cell.cellChecker.checkerType == self.chessboard.round)
                return cell.cellChecker;
            else
                return nil;
        }
    
    return nil;
}

- (ZDCell*) cellInPoint:(CGPoint)touchPoint {
    
    for (ZDCell* cell in self.chessboard.cellArr)
        if ( CGRectContainsPoint(cell.cellView.frame, touchPoint) ) {
            if (cell.cellType == checkerTypeWhite)
                return cell;
            else
                return nil;
        }
    
    return nil;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
