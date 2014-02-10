//
//  WeatherController.m
//  SportGuide
//
//  Created by admin on 10.01.14.
//  Copyright (c) 2014 StexGroup. All rights reserved.
//

#import "WeatherController.h"
#import <libxml2/libxml/HTMLparser.h>
#import "CGLabel.h"

@interface WeatherController ()
{
	IBOutlet CGLabel *day1;
	IBOutlet CGLabel *day2;
	IBOutlet CGLabel *day3;
	IBOutlet UIImageView *image1;
	IBOutlet UIImageView *image2;
	IBOutlet UIImageView *image3;
	IBOutlet CGLabel *temp1;
	IBOutlet CGLabel *temp2;
	IBOutlet CGLabel *temp3;
	IBOutlet CGLabel *relwet1;
	IBOutlet CGLabel *relwet2;
	IBOutlet CGLabel *relwet3;
	IBOutlet CGLabel *winddir1;
	IBOutlet CGLabel *winddir2;
	IBOutlet CGLabel *winddir3;
	IBOutlet CGLabel *windspd1;
	IBOutlet CGLabel *windspd2;
	IBOutlet CGLabel *windspd3;
	IBOutlet UIImageView *roza1;
	IBOutlet UIImageView *roza2;
	IBOutlet UIImageView *roza3;
	
	NSArray * windDir;
	
	CGAffineTransform rotation1;
	CGAffineTransform rotation2;
	CGAffineTransform rotation3;
}

@end

@implementation WeatherController

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
	
	windDir = @[@"С", @"С-В", @"В", @"Ю-В", @"Ю", @"Ю-З", @"З", @"С-З"];
	
	NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://informer.gismeteo.ru/xml/27553_1.xml"]];
	
	if(data == nil)
	{
		[[[UIAlertView alloc] initWithTitle:@"Ошибка" message:@"Нет соединения с интернет или сервер погоды не отвечает." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
	}
	
	NSArray * arr = [[[self xmlToDict:data] valueForKeyPath:@"child.child.child"][0][0] sortedByTodArray];
	
	NSDictionary * date1 =		  [arr[1] valueForKey:@"attr"];
	NSDictionary * phenomena1 =	  [[arr[1] valueForKey:@"child"][0] objectForKey:@"attr"];
	NSDictionary * temperature1 = [[arr[1] valueForKey:@"child"][2] objectForKey:@"attr"];
	NSDictionary * wind1 =		  [[arr[1] valueForKey:@"child"][3] objectForKey:@"attr"];
	NSDictionary * wet1 =	  [[arr[1] valueForKey:@"child"][4] objectForKey:@"attr"];
	
	NSDictionary * date2 =		  [arr[2] valueForKey:@"attr"];
	NSDictionary * phenomena2 =	  [[arr[2] valueForKey:@"child"][0] objectForKey:@"attr"];
	NSDictionary * temperature2 = [[arr[2] valueForKey:@"child"][2] objectForKey:@"attr"];
	NSDictionary * wind2 =		  [[arr[2] valueForKey:@"child"][3] objectForKey:@"attr"];
	NSDictionary * wet2 =	  [[arr[2] valueForKey:@"child"][4] objectForKey:@"attr"];
	
	NSDictionary * date3 =		  [arr[3] valueForKey:@"attr"];
	NSDictionary * phenomena3 =	  [[arr[3] valueForKey:@"child"][0] objectForKey:@"attr"];
	NSDictionary * temperature3 = [[arr[3] valueForKey:@"child"][2] objectForKey:@"attr"];
	NSDictionary * wind3 =		  [[arr[3] valueForKey:@"child"][3] objectForKey:@"attr"];
	NSDictionary * wet3 =	  [[arr[3] valueForKey:@"child"][4] objectForKey:@"attr"];
	
	temp1.text = [NSString stringWithFormat:@"%d° C", ([[temperature1 objectForKey:@"max"] intValue] + [[temperature1 objectForKey:@"min"] intValue]) / 2];
	temp2.text = [NSString stringWithFormat:@"%d° C", ([[temperature2 objectForKey:@"max"] intValue] + [[temperature2 objectForKey:@"min"] intValue]) / 2];
	temp3.text = [NSString stringWithFormat:@"%d° C", ([[temperature3 objectForKey:@"max"] intValue] + [[temperature3 objectForKey:@"min"] intValue]) / 2];
	
	relwet1.text = [NSString stringWithFormat:@"%d%%", ([[wet1 objectForKey:@"max"] intValue] + [[wet1 objectForKey:@"min"] intValue]) / 2];
	relwet2.text = [NSString stringWithFormat:@"%d%%", ([[wet2 objectForKey:@"max"] intValue] + [[wet2 objectForKey:@"min"] intValue]) / 2];
	relwet3.text = [NSString stringWithFormat:@"%d%%", ([[wet3 objectForKey:@"max"] intValue] + [[wet3 objectForKey:@"min"] intValue]) / 2];
	
	winddir1.text = [windDir objectAtIndex:[[wind1 objectForKey:@"direction"] intValue]];
	winddir2.text = [windDir objectAtIndex:[[wind2 objectForKey:@"direction"] intValue]];
	winddir3.text = [windDir objectAtIndex:[[wind3 objectForKey:@"direction"] intValue]];
	
	rotation1 = [self rotateRozaImage:roza1 toWindDirection:[[wind1 objectForKey:@"direction"] intValue]];
	rotation2 = [self rotateRozaImage:roza2 toWindDirection:[[wind2 objectForKey:@"direction"] intValue]];
	rotation3 = [self rotateRozaImage:roza3 toWindDirection:[[wind3 objectForKey:@"direction"] intValue]];
	
	windspd1.text = [NSString stringWithFormat:@"%d м/с", ([[wind1 objectForKey:@"max"] intValue] + [[wind1 objectForKey:@"min"] intValue]) / 2];
	windspd2.text = [NSString stringWithFormat:@"%d м/с", ([[wind2 objectForKey:@"max"] intValue] + [[wind2 objectForKey:@"min"] intValue]) / 2];
	windspd3.text = [NSString stringWithFormat:@"%d м/с", ([[wind3 objectForKey:@"max"] intValue] + [[wind3 objectForKey:@"min"] intValue]) / 2];
	
	int precipitation1 = [[phenomena1 objectForKey:@"precipitation"] intValue];
	int precipitation2 = [[phenomena2 objectForKey:@"precipitation"] intValue];
	int precipitation3 = [[phenomena3 objectForKey:@"precipitation"] intValue];
	
	int cloudiness1 = [[phenomena1 objectForKey:@"cloudiness"] intValue];
	int cloudiness2 = [[phenomena2 objectForKey:@"cloudiness"] intValue];
	int cloudiness3 = [[phenomena3 objectForKey:@"cloudiness"] intValue];
	
	image1.image = [self getWeatherImageForPrecipitation:precipitation1 andCloudiness:cloudiness1];
	image2.image = [self getWeatherImageForPrecipitation:precipitation2 andCloudiness:cloudiness2];
	image3.image = [self getWeatherImageForPrecipitation:precipitation3 andCloudiness:cloudiness3];
	
	image1.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
	image2.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
	image3.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
	
	day1.text = [self getStringFromDay:[[date1 objectForKey:@"day"] intValue]];
	day2.text = [self getStringFromDay:[[date2 objectForKey:@"day"] intValue]];
	day3.text = [self getStringFromDay:[[date3 objectForKey:@"day"] intValue]];
}

-(void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	
	[UIView animateWithDuration:0.5 animations:^{
		roza1.transform = rotation1;
		roza2.transform = rotation2;
		roza3.transform = rotation3;
	}];
	
	[UIView animateWithDuration:0.4 / 1.5 animations:^{
		image1.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
		image2.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
		image3.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
	}completion:^(BOOL finished) {
		[UIView animateWithDuration:0.3 / 2 animations:^{
			image1.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
			image2.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
			image3.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
		}completion:^(BOOL finished) {
			[UIView animateWithDuration:0.3 / 2 animations:^{
				image1.transform = CGAffineTransformIdentity;
				image2.transform = CGAffineTransformIdentity;
				image3.transform = CGAffineTransformIdentity;
			}];
		}];
	}];
}

-(CGAffineTransform)rotateRozaImage:(UIImageView*)image toWindDirection:(int)windDirection
{
	CGAffineTransform transf;
	
	switch (windDirection) {
		case 1:
			transf = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI_4);
			break;
			
		case 2:
			transf = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI_2);
			break;
			
		case 3:
			transf = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI_4 + M_PI_2);
			break;
			
		case 4:
			transf = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI);
			break;
			
		case 5:
			transf = CGAffineTransformRotate(CGAffineTransformIdentity, -(M_PI_4 + M_PI_2));
			break;
			
		case 6:
			transf = CGAffineTransformRotate(CGAffineTransformIdentity, -M_PI_2);
			break;
			
		case 7:
			transf = CGAffineTransformRotate(CGAffineTransformIdentity, -M_PI_4);
			break;
			
		default:
			transf = CGAffineTransformIdentity;
			break;
	}
	
	return transf;
}

-(NSString*)getStringFromDay:(int)_day
{
	NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit fromDate:[NSDate date]];
	
	int day = [components day];
	
	if(day == _day)
		return @"Сегодня";
	
	return @"Завтра";
}

-(UIImage*)getWeatherImageForPrecipitation:(int)precipitation andCloudiness:(int)cloudiness
{
	UIImage * image = nil;
	
	if(precipitation == 9 || precipitation == 10)
	{
		if(cloudiness == 0)
			image = [UIImage imageNamed:@"weather_sun.png"];
		else if(cloudiness == 3)
			image = [UIImage imageNamed:@"weather_cloudy.png"];
		else
			image = [UIImage imageNamed:@"weather_party_cloudy.png"];
	}
	else if(precipitation == 4 || precipitation == 5)
	{
		image = [UIImage imageNamed:@"weather_rain.png"];
	}
	else if(precipitation == 6 || precipitation == 7)
	{
		image = [UIImage imageNamed:@"weather_snow.png"];
	}
	else if(precipitation == 8)
	{
		image = [UIImage imageNamed:@"weather_storm.png"];
	}
	
	return image;
}

- (IBAction)backPressed
{
	[self.navigationController popViewControllerAnimated:YES];
}

- (NSDictionary *)xmlToDict:(NSData*)content {
    NSDictionary *resultDict = [NSDictionary dictionary];
    if (content != nil) {
        xmlDocPtr doc = xmlParseMemory([content bytes], [content length]);
        if (!doc) {
            // сообщение об ошибке
            NSLog(@"error");
        }
        else {
            xmlNode *root = NULL;
            root = xmlDocGetRootElement(doc);
            resultDict = [NSDictionary dictionaryWithDictionary:[self getNodeInfo:root]];
            xmlFree(root);
        }
    }
    return resultDict;
}

/* информация об xml объекте, рекурсия */
-(NSDictionary *)getNodeInfo:(xmlNode *)node {
    NSMutableDictionary *itemDict = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    xmlChar *value = NULL;
    xmlAttr *attribute = NULL;
    
    if (node && node->name && ![[NSString stringWithCString:(char *)node->name encoding:NSUTF8StringEncoding] isEqualToString:@"text"]) {
        /* имя объекта */
        value = (xmlChar*)node->name;
        [itemDict setObject:[NSString stringWithCString:(char *)value encoding:NSUTF8StringEncoding] forKey:@"name"];
        xmlFree(value);
		
        /* атрибуты объекта */
        attribute = node->properties;
        NSMutableDictionary *attrDict = [[NSMutableDictionary alloc] initWithCapacity:1];
        while(attribute && attribute->name && attribute->children)
        {
            value = xmlNodeListGetString(node->doc, attribute->children, 1);
            [attrDict setObject:[NSString stringWithCString:(char *)value encoding:NSUTF8StringEncoding]
						 forKey:[NSString stringWithCString:(char *)attribute->name encoding:NSUTF8StringEncoding]];
            xmlFree(value);
            attribute = attribute->next;
        }
        [itemDict setObject:attrDict forKey:@"attr"];
		
        /* значение объекта */
        value = xmlNodeGetContent(node);
        [itemDict setObject:[NSString stringWithCString:(char*)value encoding:NSUTF8StringEncoding] forKey:@"value"];
        xmlFree(value);
        
        /* дочерние объекты */
        NSMutableArray *childArray = [[NSMutableArray alloc] initWithCapacity:1];
        xmlNode *child = NULL;
        for (child = node->children; child != NULL; child = child->next)
        {
            NSDictionary *childDict = [self getNodeInfo:child];
            if ([childDict count]) {
                [childArray addObject:childDict];
            }
            
        }
        xmlFree(child);
        if ([childArray count])
            [itemDict setObject:childArray forKey:@"child"];
    }
    
    return (NSDictionary *)itemDict;
}

@end
