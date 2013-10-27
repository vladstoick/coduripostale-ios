//
//  MapViewController.m
//  Coduri Poștale
//
//  Created by Vlad Stoica on 10/17/13.
//  Copyright (c) 2013 Vlad Stoica. All rights reserved.
//

#import "MapViewController.h"
#import "StradaResultsViewController.h"
@interface MapViewController ()
@property BOOL hasUpdatedCurrentLocation;
@property CLGeocoder *geocoder;
@property NSString *streetName;
@end

@implementation MapViewController

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
    self.mapView.showsUserLocation = YES;
    self.hasUpdatedCurrentLocation = NO;
    self.geocoder = [[CLGeocoder alloc] init];
    //setting UILongPressGestureRecognizer on map for drop pin
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 1.0; //user needs to press for 2 seconds
    [self.mapView addGestureRecognizer:lpgr];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark MKMapViewDelegate

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    if(self.hasUpdatedCurrentLocation == NO ){
        mapView.showsUserLocation = YES;
        MKCoordinateRegion mapRegion;
        mapRegion.center = mapView.userLocation.coordinate;
        mapRegion.span.latitudeDelta = 0.05;
        mapRegion.span.longitudeDelta = 0.05;
        [mapView setRegion:mapRegion animated: YES];
        self.hasUpdatedCurrentLocation = YES;
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    
    MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"String"];
    if(!annotationView) {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"String"];
        annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    }
    
    annotationView.enabled = YES;
    annotationView.canShowCallout = YES;
    
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    [self performSegueWithIdentifier:@"showResultsFromMap" sender:self];
}

#pragma mark UI Touch Event Handlers

- (void)handleLongPress:(UIGestureRecognizer *)gestureRecognizer
{
    if(gestureRecognizer.state == UIGestureRecognizerStateBegan){
    [self.mapView removeAnnotations:self.mapView.annotations];
    if (gestureRecognizer.state != UIGestureRecognizerStateBegan)
        return;
    CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];
    CLLocationCoordinate2D touchMapCoordinate = [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
    MKPointAnnotation *annot = [[MKPointAnnotation alloc] init];
    annot.coordinate = touchMapCoordinate;
    [self.mapView addAnnotation:annot];
        
    CLLocation *pinLocation = [[CLLocation alloc] initWithLatitude:touchMapCoordinate.latitude longitude:touchMapCoordinate.longitude];
    [self.geocoder reverseGeocodeLocation:pinLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark = [placemarks objectAtIndex:0];
        self.streetName = [[placemark valueForKey:@"addressDictionary"]valueForKey:@"Thoroughfare"];
        annot.title = self.streetName;
        [self.mapView selectAnnotation:annot animated:NO];
          }];
    }
}

#pragma mark Segue handler
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"showResultsFromMap"]){
        StradaResultsViewController *destinationViewController = segue.destinationViewController;
        destinationViewController.querry = self.streetName;
    }
}


@end
