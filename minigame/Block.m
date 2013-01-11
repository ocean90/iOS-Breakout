//
//  Block.m
//  minigame
//
//  Created by Christoph Jerolimov on 09.01.2013.
//  Copyright (c) 2013 buenocode. All rights reserved.
//

#import "Block.h"
#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation Block


- (id)init
{
    self = [super init];
    if (self) {
        CGFloat redColor = ((arc4random()>>24)&0xFF)/256.0;
		CGFloat greenColor = ((arc4random()>>24)&0xFF)/256.0;
        CGFloat blueColor = ((arc4random()>>24)&0xFF)/256.0;
		self.backgroundColor = [UIColor colorWithRed:redColor green:greenColor blue:blueColor alpha:1.0];
		self.layer.borderColor = [UIColor blackColor].CGColor;
		self.layer.borderWidth = 0.5;
		self.layer.cornerRadius = 3.0;
    }
    return self;
}

- (void) checkBlockCollisionWith:(Ball *)ball {
	CGRect ballRect = [ball frame];

	// Start with the bottom blocks
	for ( Block* block in [[self.subviews reverseObjectEnumerator] allObjects] ) {
		CGRect blockRect = block.frame;

		if ( CGRectIntersectsRect(ballRect, blockRect) ) {
			[UIView animateWithDuration:0.2
							 animations:^{
								 [block setAlpha:0.0f];
							 }
							 completion:^(BOOL finished){ [block removeFromSuperview]; }];

			// Top and bottom
			if ( CGRectGetMaxY(ballRect) >= CGRectGetMinY(blockRect)) {
				[ball inverseY];
			}

			// Right and left
			if ( CGRectGetMaxX(ballRect) >= CGRectGetMinX(blockRect)) {
				[ball inverseX];
			}

			UILabel *points = ((ViewController *)self.controller).points;
			int oldPoints = [points.text intValue];
			points.text = [NSString stringWithFormat:@"%d", oldPoints + 1];

		}
		
	}
}

@end
