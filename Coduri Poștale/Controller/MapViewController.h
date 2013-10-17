//
//  MapViewController.h
//  Coduri Poștale
//
//  Created by Vlad Stoica on 10/17/13.
//  Copyright (c) 2013 Vlad Stoica. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface MapViewController : UIViewController <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
