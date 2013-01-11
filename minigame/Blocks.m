//
//  Blocks.m
//  minigame
//
//  Created by Dominik Schilling on 11.01.13.
//  Copyright (c) 2013 buenocode. All rights reserved.
//

#import "Blocks.h"

@implementation Blocks


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

			
		}
		
	}
}


@end
