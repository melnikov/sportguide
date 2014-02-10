//
//  ViewController.m
//  SportGuide
//
//  Created by admin on 30.12.13.
//  Copyright (c) 2013 StexGroup. All rights reserved.
//

#import "MenuController.h"
#import "AboutController.h"
#import "TimeTableController.h"
#import "WeatherController.h"
#import "ElevatorPriceController.h"
#import "MapController.h"
#import "Flurry.h"

#define ANIM_DURATION 0.3f

@interface MenuController ()
{
	IBOutlet UIButton *contactsViewBackground;
	IBOutlet UIView *contactsView;
	IBOutlet UIButton *priceViewBackground;
	IBOutlet UIView *pricesView;
	IBOutlet UIButton *contactsButton;
	IBOutlet UIButton *pricesButton;
}

@end

@implementation MenuController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	[self.view addSubview:contactsView];
	[self.view addSubview:pricesView];
	
	contactsView.alpha = 0;
	pricesView.alpha = 0;
	
	//chooseServicesView.center = servicesButton.center;
}

-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	UIImage *image = [[UIImage imageNamed:@"box_arrow_light.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
	
	[contactsViewBackground setBackgroundImage:image forState:UIControlStateNormal];
	
	contactsView.frame = CGRectMake(self.view.frame.size.width - contactsView.frame.size.width - 10, contactsButton.frame.origin.y + contactsButton.frame.size.height / 2 - contactsView.frame.size.height / 2 , contactsView.frame.size.width, contactsView.frame.size.height);
	
	image = [[UIImage imageNamed:@"box_arrow_light.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
	
	[priceViewBackground setBackgroundImage:image forState:UIControlStateNormal];
	
	pricesView.frame = CGRectMake(self.view.frame.size.width - pricesView.frame.size.width - 10, pricesButton.frame.origin.y + pricesButton.frame.size.height / 2 - pricesView.frame.size.height / 2 , pricesView.frame.size.width, pricesView.frame.size.height);
}

- (IBAction)weatherButtonPressed
{
	[self hidePopups];
	
	[self.navigationController pushViewController:[WeatherController new] animated:YES];
	
	[Flurry logEvent:@"Погода"];
}

- (IBAction)workingTimeButtonPressed
{
	[self hidePopups];
	
	[self.navigationController pushViewController:[TimeTableController new] animated:YES];
	
	[Flurry logEvent:@"Часы работы"];
}

#pragma mark
#pragma mark CONTACTS

- (IBAction)contactsPressed
{
	[Flurry logEvent:@"Карта"];
	
	if(contactsView.alpha == 0)
		[UIView animateWithDuration:ANIM_DURATION animations:^{
			pricesView.alpha = 0;
			contactsView.alpha = 1;
		}];
	else
		[UIView animateWithDuration:ANIM_DURATION animations:^{
			pricesView.alpha = 0;
			contactsView.alpha = 0;
		}];
}

- (IBAction)contactsSectionPressed:(UIButton *)sender
{
	UIViewController * contr = [[MapController alloc] initWithType:sender.tag];
	
	[self.navigationController pushViewController:contr animated:YES];
}


#pragma mark
#pragma mark PRICES

- (IBAction)servicesButtonPressed
{
	[Flurry logEvent:@"Цены"];
	
	if(pricesView.alpha == 0)
		[UIView animateWithDuration:ANIM_DURATION animations:^{
			contactsView.alpha = 0;
			pricesView.alpha = 1;
		}];
	else
		[UIView animateWithDuration:ANIM_DURATION animations:^{
			contactsView.alpha = 0;
			pricesView.alpha = 0;
		}];
}

- (IBAction)pricesSectionPressed:(UIButton*)sender
{
	UIViewController * contr = [[ElevatorPriceController alloc] initWithType:sender.tag];
	
	[self.navigationController pushViewController:contr animated:YES];
}

- (IBAction)photosButtonPressed
{
	[self hidePopups];
}

- (IBAction)aboutButtonPressed
{
	[Flurry logEvent:@"О программе"];
	
	[self hidePopups];
	
	AboutController * ac = [AboutController new];
	
	ac.modalTransitionStyle = UIModalTransitionStylePartialCurl;
	
	[self presentModalViewController:ac animated:YES];
}

-(IBAction)hidePopups
{
	[UIView animateWithDuration:ANIM_DURATION animations:^{
		contactsView.alpha = 0;
		pricesView.alpha = 0;
	}];
}

- (IBAction)showStoreView:(id)sender {
	
	SKStoreProductViewController *storeViewController =
	[[SKStoreProductViewController alloc] init];
	
	storeViewController.delegate = self;
	
	NSNumber * number = [NSNumber numberWithInteger:333700869];
	
	NSDictionary *parameters = [NSDictionary dictionaryWithObject:number forKey:SKStoreProductParameterITunesItemIdentifier];
	
	[storeViewController loadProductWithParameters:parameters
								   completionBlock:^(BOOL result, NSError *error) {
									   if (result)
										   [self presentViewController:storeViewController
															  animated:YES
															completion:nil];
								   }];
	
}

@end
