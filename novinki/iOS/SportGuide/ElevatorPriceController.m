//
//  ElevatorPriceController.m
//  SportGuide
//
//  Created by admin on 10.01.14.
//  Copyright (c) 2014 StexGroup. All rights reserved.
//

#import "ElevatorPriceController.h"

enum priceMenu
{
	priceMenuElevator = 10,
	priceMenuInventory = 20,
	priceMenuSnowtube = 30,
	priceMenuStudy = 40,
	priceMenuSkiService = 50,
	priceMenuPenalty = 60,
	priceMenuHorse = 70,
	priceMenuCafe = 80,
	priceMenuHotel = 90
};

@interface ElevatorPriceController ()
{
	int type;
	IBOutlet UIScrollView *scrollView;
	UIView *contentView;
	IBOutlet UILabel *nameLabel;
	IBOutlet UIView *elevatorView;
	IBOutlet UIView *inventoryView;
	IBOutlet UIView *snowtubeView;
	IBOutlet UIView *studyView;
	IBOutlet UIView *skiServiceView;
	IBOutlet UIView *penaltyView;
	IBOutlet UIView *horseView;
	IBOutlet UIView *cafeView;
	IBOutlet UIView *hotelView;
}

@end

@implementation ElevatorPriceController

-(id)initWithType:(int)_type
{
	self = [super init];
    if (self) {
        // Custom initialization
		type = _type;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
	switch (type)
	{
		case priceMenuElevator:
			contentView = elevatorView;
			nameLabel.text = @"ПОДЪЕМНИКИ";
			break;
			
		case priceMenuInventory:
			contentView = inventoryView;
			nameLabel.text = @"ПРОКАТ ИНВЕНТАРЯ";
			break;
			
		case priceMenuSnowtube:
			contentView = snowtubeView;
			nameLabel.text = @"СНОУТЮБИНГ";
			break;
			
		case priceMenuStudy:
			contentView = studyView;
			nameLabel.text = @"ОБУЧЕНИЕ";
			break;
			
		case priceMenuSkiService:
			contentView = skiServiceView;
			nameLabel.text = @"SKI-СЕРВИС";
			break;
			
		case priceMenuPenalty:
			contentView = penaltyView;
			nameLabel.text = @"ПОЛОМКА ИНВЕНТАРЯ";
			break;
			
		case priceMenuHorse:
			contentView = horseView;
			nameLabel.text = @"КОННЫЕ ПРОГУЛКИ";
			break;
			
		case priceMenuCafe:
			contentView = cafeView;
			nameLabel.text = @"КАФЕ";
			break;
			
		case priceMenuHotel:
			contentView = hotelView;
			nameLabel.text = @"ГОСТИННИЦА";
			break;
			
		default:
			break;
	}
	
	[scrollView addSubview:contentView];
	
	scrollView.contentSize = contentView.frame.size;
}

- (IBAction)backPressed
{
	[self.navigationController popViewControllerAnimated:YES];
}

@end
