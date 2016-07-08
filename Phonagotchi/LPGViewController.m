//
//  LPGViewController.m
//  Phonagotchi
//
//  Created by Steven Masuch on 2014-07-26.
//  Copyright (c) 2014 Lighthouse Labs. All rights reserved.
//

#import "LPGViewController.h"
#import "Pet.h"


@interface LPGViewController ()

@property (nonatomic) UIImageView *petImageView;
@property (nonatomic) UIImageView *appleImageView;
@property (nonatomic) UIImageView *bucketImageView;
@property (nonatomic) UIImageView *otherAppleImageView;

@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
@property (nonatomic, strong) UIPanGestureRecognizer *dragPanGesture;
@property BOOL isPressed;

@property (nonatomic, strong) Pet *pet;



@end

@implementation LPGViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Pet *pet = [[Pet alloc] init];
    self.pet = pet;
    
    [self initView];

}


- (void)preparePetImageView {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    self.petImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.petImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.petImageView.image = [UIImage imageNamed:@"default"];
    
    [self.view addSubview:self.petImageView];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.petImageView
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.petImageView
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.0
                                                           constant:0.0]];
    
}


- (void)prepareBucketImageView {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    self.bucketImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.bucketImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.bucketImageView.image = [UIImage imageNamed:@"bucket"];
    
    [self.view addSubview:self.bucketImageView];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bucketImageView
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.5
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bucketImageView
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:0.5
                                                           constant:0.0]];
    
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bucketImageView
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:1
                                                           constant:100]];
    
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bucketImageView
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:1
                                                           constant:100]];
    
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panned)];
    
    self.petImageView.userInteractionEnabled = YES;
    [self.petImageView addGestureRecognizer:self.panGesture];

}

-(void)prepareAppleImageView {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    self.appleImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.appleImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.appleImageView.image = [UIImage imageNamed:@"apple"];
    [self.view addSubview:self.appleImageView];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.appleImageView
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.5
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.appleImageView
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:0.5
                                                           constant:0.0]];
    
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.appleImageView
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:1
                                                           constant:50]];
    
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.appleImageView
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:1
                                                           constant:50]];

}

- (void)prepareOtherAppleImageView {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    //self.otherAppleImageView = [[UIImageView alloc] initWithFrame:self.appleImageView.frame];
    self.otherAppleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.center.x*1.35, self.view.center.y/2.55, 50 , 50)];
    self.otherAppleImageView.translatesAutoresizingMaskIntoConstraints = YES;
    self.otherAppleImageView.image = [UIImage imageNamed:@"apple"];
    self.otherAppleImageView.userInteractionEnabled = YES;
    [self.view addSubview:self.otherAppleImageView];

    self.dragPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragged:)];
    [self.otherAppleImageView addGestureRecognizer:self.dragPanGesture];

}



- (void)initView {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    self.view.backgroundColor = [UIColor colorWithRed:(252.0/255.0) green:(240.0/255.0) blue:(228.0/255.0) alpha:1.0];
    
    [self preparePetImageView];
    [self prepareBucketImageView];
    [self prepareAppleImageView];
    [self prepareOtherAppleImageView];
    
}


#pragma mark - Gesture Recognizer Handlers


-(void) panned {
    
    CGPoint vel = [self.panGesture velocityInView:self.petImageView];
    float velocity = sqrt((vel.x * vel.x) + (vel.y * vel.y ));
    
    if (velocity > 1750) {
    
        self.pet.isGrumpy = true;
        
        self.petImageView.image = [UIImage imageNamed:@"grumpy.png"];
    
    }

}



-(void) dragged:(UIPanGestureRecognizer *) gesture {

    NSLog(@"%s", __PRETTY_FUNCTION__);
    
     //       [self prepareOtherAppleImageView];
    
    CGPoint translation = [gesture locationInView:self.view];
    
    if(gesture.state == UIGestureRecognizerStateBegan){
        

    
    } else if (gesture.state == UIGestureRecognizerStateChanged) {
        
            self.otherAppleImageView.center = translation;
    
    } else if (UIGestureRecognizerStateEnded){
    
        
        [UIView animateWithDuration:0.7f
                         animations:^{
                             
             [self.otherAppleImageView setCenter: CGPointMake ( self.otherAppleImageView.center.x,self.petImageView.center.y)];
             
         }
                         completion:^(BOOL finished) {
             //[self.otherAppleImageView removeFromSuperview];
             
            [self.otherAppleImageView setCenter: CGPointMake ( self.appleImageView.center.x,self.petImageView.center.y)];
            self.otherAppleImageView.hidden = true;
            [self.otherAppleImageView setFrame:self.appleImageView.frame];
            self.otherAppleImageView.hidden = false;
         }
         ];
        
        
        
        
    
    }
    

}
    


@end
