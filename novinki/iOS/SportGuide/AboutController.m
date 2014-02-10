//
//  AboutController.m
//  SportGuide
//
//  Created by admin on 30.12.13.
//  Copyright (c) 2013 StexGroup. All rights reserved.
//

#import "AboutController.h"
#import "Flurry.h"

@interface AboutController ()

@end

@implementation AboutController

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

- (IBAction)donePressed
{
	[self.presentingViewController dismissModalViewControllerAnimated:YES];
}

- (IBAction)callPressed
{
	[[[UIAlertView alloc] initWithTitle:@"Позвонить в Stex Group?" message:@"8 (831) 218-69-19" delegate:self cancelButtonTitle:@"Отмена" otherButtonTitles:@"Позвонить", nil] show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(buttonIndex > 0)
	{
		[Flurry logEvent:@"Звонок в Stex Group"];
		
		NSString *phone = @"tel://+78312186919";
		
		NSLog(@"Dialing %@", phone);
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:phone]];
	}
}

- (IBAction)httpPressed
{
	[Flurry logEvent:@"Сайт Stex Group"];
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://stexgroup.ru/"]];
}

@end
