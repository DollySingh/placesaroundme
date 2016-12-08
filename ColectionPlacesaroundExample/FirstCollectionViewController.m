//
//  FirstCollectionViewController.m
//  ColectionPlacesaroundExample
//
//  Created by Student on 08/11/16.
//  Copyright (c) 2016 Abhijit. All rights reserved.
//

#import "FirstCollectionViewController.h"
#import "CellCollectionViewCell.h"
#import "SecondTableViewController.h"


@interface FirstCollectionViewController ()

@end

@implementation FirstCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

//int SelectedRow=0;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _lablearray=[[NSArray alloc]initWithObjects:@"hospital",@"restaurant",@"bakery",@"bank",@"atm",@"gym", nil];
    
    _imagearray=[[NSArray alloc]initWithObjects:@"atm",@"college",@"coffeeshop",@"bank",@"railwaystation",@"busstop",nil];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    
    [tapGesture setNumberOfTapsRequired:1];
    [self.collectionView addGestureRecognizer:tapGesture];

    // Register cell classes
  //  [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];


}

-(void) handleTap:(UIGestureRecognizer*) gesture {
    if (gesture.state == UIGestureRecognizerStateEnded) {
        _tp = [gesture locationInView:self.view];
        
        NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:_tp];
        
        CellCollectionViewCell *cell = (CellCollectionViewCell*)[self.collectionView cellForItemAtIndexPath:indexPath];
        
        _pointWRTCell = [cell convertPoint:_tp fromView:self.collectionView];
        
        NSLog(@"collectionView point(%1.1f,%1.1f); cell point (%1.1f,%1.1f)",
              _tp.x,_tp.y,_pointWRTCell.x,_pointWRTCell.y);
    
}
    [self performSegueWithIdentifier:@"userSelectSegue" sender:nil];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    
//    UITouch *t=[[event allTouches] anyObject];
//    
//    _p=[t locationInView:t.view];
//    NSLog(@"X location: %f",_p.x);
//    NSLog(@"Y Location: %f",_p.y);

//}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"userSelectSegue"]){
    
        
        NSIndexPath *indexpath1=[self.collectionView indexPathForItemAtPoint:_tp];
        
        SecondTableViewController *controller=(SecondTableViewController *)segue.destinationViewController;
        
        controller.tempstring=[_lablearray objectAtIndex:indexpath1.row];
        
    }
 
}


//#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//#warning Incomplete method implementation -- Return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//#warning Incomplete method implementation -- Return the number of items in the section
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CellCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.image1.image=[UIImage imageNamed:[_imagearray objectAtIndex:indexPath.row]];
    cell.textlabel.text=[_lablearray objectAtIndex:indexPath.row];
   
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/


// Uncomment this method to specify if the specified item should be selected
//- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//   SelectedRow=indexPath.row;
//    
//    [self performSegueWithIdentifier:@"userSelectSegue" sender:self];
//    
//    
//    
//    return YES;
//}

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
