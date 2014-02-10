//
//  CGothicLabel.m
//  SportGuide
//
//  Created by admin on 10.01.14.
//  Copyright (c) 2014 StexGroup. All rights reserved.
//

#import "CGLabel.h"

@implementation CGLabel

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
	if([self.font.fontName isEqualToString:[UIFont systemFontOfSize:17].fontName])
		self.font = [UIFont fontWithName:@"CenturyGothic" size:self.font.pointSize];
	else if([self.font.fontName isEqualToString:[UIFont boldSystemFontOfSize:17].fontName])
		self.font = [UIFont fontWithName:@"CenturyGothic-Bold" size:self.font.pointSize];
	else if([self.font.fontName isEqualToString:[UIFont italicSystemFontOfSize:17].fontName])
		self.font = [UIFont fontWithName:@"CenturyGothic-Italic" size:self.font.pointSize];
	else
		self.font = [UIFont fontWithName:@"CenturyGothic-BoldItalic" size:self.font.pointSize];
}

@end
