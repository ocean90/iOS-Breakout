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
			[UIView animateWithDuration:1.0
							 animations:^{
								 [block setAlpha:0.0f]; // Doesn't work?
								 [block setCenter:CGPointMake(block.center.x, 500)];
							 }
							 completion:^(BOOL finished){ [block removeFromSuperview]; }];

		}

	}
}


@end
