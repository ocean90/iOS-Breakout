//
//  Block.m
//  minigame
//
//  Created by Christoph Jerolimov on 09.01.2013.
//  Copyright (c) 2013 buenocode. All rights reserved.
//

#import "Block.h"
#import <QuartzCore/QuartzCore.h>

@implementation Block

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
