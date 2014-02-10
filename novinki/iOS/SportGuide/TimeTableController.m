//
//  TimeTableController.m
//  SportGuide
//
//  Created by admin on 10.01.14.
//  Copyright (c) 2014 StexGroup. All rights reserved.
//

#import "TimeTableController.h"

@interface TimeTableController ()
{
	IBOutletCollection(UIView) NSArray *weekDayViews;
	IBOutlet UIImageView *blueBackground;
}

@end

@implementation TimeTableController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	[calendar setFirstWeekday:2];
	
	NSUInteger day = [calendar ordinalityOfUnit:NSWeekdayCalendarUnit inUnit:NSWeekCalendarUnit forDate:[NSDate date]] - 1;
	
	blueBackground.center = CGPointMake(blueBackground.center.x, [weekDayViews[day] center].y);
	
	for(UILabel * label in [weekDayViews[day] subviews])
	{
		label.textColor = [UIColor whiteColor];
	}
}

- (IBAction)backPressed
{
	[self.navigationController popViewControllerAnimated:YES];
}

@end
