//
//  Ball.h
//  minigame
//
//  Created by Christoph Jerolimov on 09.01.2013.
//  Copyright (c) 2013 buenocode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Ball : UIView

- (void) start;
- (void) pause;
- (void) stop;
- (BOOL) checkTopCollisionOf:(CGRect)rect1 in:(CGRect)rect2;
- (BOOL) checkBottomCollisionOf:(CGRect)rect1 in:(CGRect)rect2;
- (BOOL) checkRightCollisionOf:(CGRect)rect1 in:(CGRect)rect2;
- (BOOL) checkLeftCollisionOf:(CGRect)rect1 in:(CGRect)rect2;

@end
