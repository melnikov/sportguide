//
//  MapController.m
//  SportGuide
//
//  Created by admin on 16.01.14.
//  Copyright (c) 2014 StexGroup. All rights reserved.
//

#import "MapController.h"

enum mapMenu
{
	mapMenuMap = 10,
	mapMenuComplex = 20
};

@interface MapController ()
{
	int type;
	IBOutlet UIScrollView *scroll;
	UIImageView * imageView;
}

@end

@implementation MapController

-(id)initWithType:(int)_type
{
	self = [super init];
    if (self) {
        // Custom initialization
		type = _type;
    }
    return self;
}

- (IBAction)backPressed
{
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
	UIImage * image;
	
	switch (type)
	{
		case mapMenuMap:
			image = [UIImage imageNamed:@"map2.png"];
			break;
			
		case mapMenuComplex:
			image = [UIImage imageNamed:@"map1.jpg"];
			break;
			
		default:
			break;
	}
	
	imageView = [[UIImageView alloc] initWithImage:image];
	
	scroll.contentSize = imageView.frame.size;
	
	[scroll addSubview:imageView];
	
	UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewDoubleTapped:)];
    doubleTapRecognizer.numberOfTapsRequired = 2;
    doubleTapRecognizer.numberOfTouchesRequired = 1;
    [scroll addGestureRecognizer:doubleTapRecognizer];
	
    UITapGestureRecognizer *twoFingerTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewTwoFingerTapped:)];
    twoFingerTapRecognizer.numberOfTapsRequired = 1;
    twoFingerTapRecognizer.numberOfTouchesRequired = 2;
    [scroll addGestureRecognizer:twoFingerTapRecognizer];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
	
    CGRect scrollViewFrame = scroll.frame;
    CGFloat scaleWidth = scrollViewFrame.size.width / scroll.contentSize.width;
    CGFloat scaleHeight = scrollViewFrame.size.height / scroll.contentSize.height;
    CGFloat minScale = MIN(scaleWidth, scaleHeight);
    scroll.minimumZoomScale = minScale;
    scroll.maximumZoomScale = 1.0f;
    scroll.zoomScale = minScale;
	
    [self centerScrollViewContents];
}

- (void)centerScrollViewContents
{
    CGSize boundsSize = scroll.bounds.size;
    CGRect contentsFrame = imageView.frame;
	
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    } else {
        contentsFrame.origin.x = 0.0f;
    }
	
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    } else {
        contentsFrame.origin.y = 0.0f;
    }
	
    imageView.frame = contentsFrame;
}

- (void)scrollViewDoubleTapped:(UITapGestureRecognizer*)recognizer
{
    CGPoint pointInView = [recognizer locationInView:imageView];
	
    CGFloat newZoomScale = scroll.zoomScale * 1.5f;
    newZoomScale = MIN(newZoomScale, scroll.maximumZoomScale);
	
    CGSize scrollViewSize = scroll.bounds.size;
	
    CGFloat w = scrollViewSize.width / newZoomScale;
    CGFloat h = scrollViewSize.height / newZoomScale;
    CGFloat x = pointInView.x - (w / 2.0f);
    CGFloat y = pointInView.y - (h / 2.0f);
	
    CGRect rectToZoomTo = CGRectMake(x, y, w, h);
	
    [scroll zoomToRect:rectToZoomTo animated:YES];
}

- (void)scrollViewTwoFingerTapped:(UITapGestureRecognizer*)recognizer {
    // Zoom out slightly, capping at the minimum zoom scale specified by the scroll view
    CGFloat newZoomScale = scroll.zoomScale / 1.5f;
    newZoomScale = MAX(newZoomScale, scroll.minimumZoomScale);
    [scroll setZoomScale:newZoomScale animated:YES];
}

- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    // Return the view that you want to zoom
    return imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    // The scroll view has zoomed, so you need to re-center the contents
    [self centerScrollViewContents];
}

@end
