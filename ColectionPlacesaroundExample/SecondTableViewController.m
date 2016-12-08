//
//  SecondTableViewController.m
//  ColectionPlacesaroundExample
//
//  Created by Student on 08/11/16.
//  Copyright (c) 2016 Abhijit. All rights reserved.
//
#import "FirstCollectionViewController.h"
#import "SecondTableViewController.h"
#import <MapKit/MapKit.h>


@interface SecondTableViewController ()

@end

@implementation SecondTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _newsarray=[[NSMutableArray alloc]init];
    
    _buffer=[[NSMutableData alloc]init];
    _manager=[[CLLocationManager alloc]init];
    _manager.desiredAccuracy=kCLLocationAccuracyBest;
    _manager.delegate=self;
    [_manager startUpdatingLocation];
    
    _geocoder=[[CLGeocoder alloc]init];
      NSString *address=@"Kothrud , Pune, Maharashtra, India, 411038";
    
    [_geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *mylatlong=[placemarks objectAtIndex:0];
        
        CLLocation *location=mylatlong.location;
        
        NSLog(@"%f   %f",location.coordinate.latitude,location.coordinate.longitude);
        
   NSString  *StrCurrentLongitude=[NSString stringWithFormat: @"%f", location.coordinate.longitude];
   NSString   *StrCurrentLatitude=[NSString stringWithFormat: @"%f", location.coordinate.latitude];
        NSLog(@"%@",_tempstring);
        

        NSString *url =[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%@,%@&radius=500&type=%@&key=AIzaSyBTPh6eJQdLel0dW3DLDDf-8n450m0CaFk",StrCurrentLatitude,StrCurrentLongitude,_tempstring];
        
        NSLog(@"%@",url);
        NSURL *url1=[NSURL URLWithString:url];
                         
        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url1];
        [NSURLConnection connectionWithRequest:request delegate:self];

    }];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];

}


-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [_buffer setLength:0];
    
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_buffer appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:_buffer options:NSJSONReadingAllowFragments error:nil];
   
    
    NSArray *resultsarray=[outerdic objectForKey:@"results"];
    
    
    for(NSDictionary *zero in resultsarray)
    {
        NSString *str=[zero objectForKey:@"name"];
              [_newsarray addObject:str];
       
    }
    
    [self.tableView reloadData];
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return _newsarray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text=[_newsarray objectAtIndex:indexPath.row];
    cell.textLabel.numberOfLines=5;

    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
