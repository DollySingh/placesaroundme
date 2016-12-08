//
//  SecondTableViewController.h
//  ColectionPlacesaroundExample
//
//  Created by Student on 08/11/16.
//  Copyright (c) 2016 Abhijit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface SecondTableViewController : UITableViewController<NSURLConnectionDelegate,NSURLConnectionDataDelegate>
@property(nonatomic,retain)NSString *tempstring;
@property(nonatomic,retain)CLLocationManager *manager;
@property(nonatomic,retain)CLGeocoder *geocoder;

@property(nonatomic,retain)NSMutableArray *newsarray;
@property(nonatomic,retain)NSMutableData *buffer;

@end
