//
//  CGButton.m
//  SportGuide
//
//  Created by admin on 10.01.14.
//  Copyright (c) 2014 StexGroup. All rights reserved.
//

#import "CGButton.h"

@implementation CGButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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

-(void)awakeFromNib
{
	if([self.titleLabel.font.fontName isEqualToString:[UIFont systemFontOfSize:17].fontName])
		self.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:self.titleLabel.font.pointSize];
	else if([self.titleLabel.font.fontName isEqualToString:[UIFont boldSystemFontOfSize:17].fontName])
		self.titleLabel.font = [UIFont fontWithName:@"CenturyGothic-Bold" size:self.titleLabel.font.pointSize];
	else if([self.titleLabel.font.fontName isEqualToString:[UIFont italicSystemFontOfSize:17].fontName])
		self.titleLabel.font = [UIFont fontWithName:@"CenturyGothic-Italic" size:self.titleLabel.font.pointSize];
	else
		self.titleLabel.font = [UIFont fontWithName:@"CenturyGothic-BoldItalic" size:self.titleLabel.font.pointSize];
}

@end
