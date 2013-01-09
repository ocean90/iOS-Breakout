//
//  Ball.m
//  minigame
//
//  Created by Christoph Jerolimov on 09.01.2013.
//  Copyright (c) 2013 buenocode. All rights reserved.
//

#import "Ball.h"
#import <QuartzCore/QuartzCore.h>


@implementation Ball {
	CGPoint _startPoint;
	CADisplayLink *_displayLink;
	CGFloat _velocityX;
	CGFloat _velocityY;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	if (self) {
		self.layer.cornerRadius = 10;
		
		_startPoint = self.center;
		
		_displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(ballMoving:)];
		_displayLink.paused = YES;
		_displayLink.frameInterval = 5;
		[_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
		
		// We want only a 45 grad left and right
		double startDirection = (arc4random() % 90) + 45;
		startDirection = startDirection * 3.14 / 180;
		
		NSLog(@"start = %f", startDirection);
		NSLog(@"x = sin %lf", cos(startDirection));
		NSLog(@"y = cos %lf", sin(startDirection));
		
		_velocityX = cos(startDirection) * 40.0;
		_velocityY = sin(startDirection) * 40.0;
		
		NSLog(@"init velocity: %f %f", _velocityX, _velocityY);
	}
	
	return self;
}

-(void)ballMoving:(CADisplayLink *)displayLink {
	CGFloat x = self.center.x + _velocityX * displayLink.duration * displayLink.frameInterval;
	CGFloat y = self.center.y - _velocityY * displayLink.duration * displayLink.frameInterval;
	
	CGRect rect1 = self.frame;
	CGRect rect2 = self.superview.bounds;

	if ( [self checkTopCollisionOf:rect1 in:rect2] ) {
		_velocityY = -_velocityY;
	};

	if ( [self checkBottomCollisionOf:rect1 in:rect2] ) {
		_velocityY = -_velocityY;
	};

	if ( [self checkLeftCollisionOf:rect1 in:rect2] ) {
		_velocityX = -_velocityX;
	};

	if ( [self checkRightCollisionOf:rect1 in:rect2] ) {
		_velocityX = -_velocityX;
	};

	/*if ( ! CGRectIntersectsRect( self.superview.bounds, self.frame ) ) {
		NSLog(@"Intersection: %@", NSStringFromCGRect( CGRectIntersection( self.superview.bounds, self.frame ) ));
		[self stop];
	}*/

	self.center = CGPointMake(x, y);
}
		
		

- (BOOL) checkTopCollisionOf:(CGRect)rect1 in:(CGRect)rect2 {
	CGFloat point1 = CGRectGetMinY(rect1);
	CGFloat point2 = CGRectGetMinY(rect2);
	NSLog(@"%f - %f", point1, point2);

	return point2 >= point1;
}

- (BOOL) checkBottomCollisionOf:(CGRect)rect1 in:(CGRect)rect2 {
	CGFloat point1 = CGRectGetMaxY(rect1);
	CGFloat point2 = CGRectGetMaxY(rect2);
	NSLog(@"%f - %f", point1, point2);

	return point2 <= point1;
}

- (BOOL) checkRightCollisionOf:(CGRect)rect1 in:(CGRect)rect2 {
	CGFloat point1 = CGRectGetMaxX(rect1);
	CGFloat point2 = CGRectGetMaxX(rect2);

	NSLog(@"%f - %f", point1, point2);

	return point2 <= point1;
}

- (BOOL) checkLeftCollisionOf:(CGRect)rect1 in:(CGRect)rect2 {
	CGFloat point1 = CGRectGetMinX(rect1);
	CGFloat point2 = CGRectGetMinX(rect2);

	NSLog(@"%f - %f", point1, point2);

	return point2 >= point1;
}

- (void) start {
	NSLog(@"Start game");
	_displayLink.paused = NO;
}

- (void) pause {
	NSLog(@"Pause game");
	_displayLink.paused = YES;
//	[_displayLink removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void) stop {
	[self pause];
	NSLog(@"Stop game");
	self.center = _startPoint;
}

@end
