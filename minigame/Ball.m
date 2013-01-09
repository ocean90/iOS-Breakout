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
	CGFloat _velocityX;
	CGFloat _velocityY;
	CADisplayLink *_displayLink;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	if (self) {
		self.layer.cornerRadius = 10;
		
		_startPoint = self.center;
	}
	
	return self;
}

-(void)ballMoving:(CADisplayLink *)displayLink {
	if ( _displayLink == nil )
		_displayLink = displayLink;
	
	CGRect ballRect = self.frame;
	CGRect boxRect = self.superview.bounds;

	if ( [self checkTopCollisionOf:ballRect in:boxRect] ) {
		_velocityY = -_velocityY;
	} else if ( [self checkBottomCollisionOf:ballRect in:boxRect] ) {
		[self stop];
	}
	
	if ( [self checkLeftCollisionOf:ballRect in:boxRect] ) {
		_velocityX = -_velocityX;
	} else if ( [self checkRightCollisionOf:ballRect in:boxRect] ) {
		_velocityX = -_velocityX;
	};

	CGFloat x = _velocityX * _displayLink.duration * _displayLink.frameInterval;
	CGFloat y = -_velocityY * _displayLink.duration * _displayLink.frameInterval;
	
	self.frame = CGRectOffset(self.frame, x, y);
}

- (BOOL) checkTopCollisionOf:(CGRect)rect1 in:(CGRect)rect2 {
	CGFloat point1 = CGRectGetMinY(rect1);
	CGFloat point2 = CGRectGetMinY(rect2);
	return point1 < point2;
}

- (BOOL) checkBottomCollisionOf:(CGRect)rect1 in:(CGRect)rect2 {
	CGFloat point1 = CGRectGetMaxY(rect1);
	CGFloat point2 = CGRectGetMaxY(rect2);
	return point1 > point2;
}

- (BOOL) checkRightCollisionOf:(CGRect)rect1 in:(CGRect)rect2 {
	CGFloat point1 = CGRectGetMaxX(rect1);
	CGFloat point2 = CGRectGetMaxX(rect2);
	return point1 >= point2;
}

- (BOOL) checkLeftCollisionOf:(CGRect)rect1 in:(CGRect)rect2 {
	CGFloat point1 = CGRectGetMinX(rect1);
	CGFloat point2 = CGRectGetMinX(rect2);
	return point2 >= point1;
}

- (void) inverseY {
	_velocityY = -_velocityY;
}

- (void) start {
	NSLog(@"Start game");
	
	// We want only a 45 grad left and right
	double startDirection = (arc4random() % 90) + 45;
	startDirection = startDirection * 3.14 / 180;
	
	NSLog(@"start = %f", startDirection);
	NSLog(@"x = sin %lf", cos(startDirection));
	NSLog(@"y = cos %lf", sin(startDirection));
	
	_velocityX = cos(startDirection) * 80.0;
	_velocityY = sin(startDirection) * 80.0;
	NSLog(@"init velocity: %f %f", _velocityX, _velocityY);
}

- (void) pause {
	NSLog(@"Pause game");
	_displayLink.paused = YES;
}

- (void) stop {
	[self pause];
	NSLog(@"Stop game");
	self.center = _startPoint;
	// TODO Handler zurücksetzen
}

@end
