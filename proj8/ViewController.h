//
//  ViewController.h
//  proj8
//
//  Created by Admin on 1/22/13.
//  Copyright (c) 2013 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property(nonatomic, retain) IBOutlet UIButton *search_btn;

@property(nonatomic, retain) IBOutlet UITextView *inpu_text;

@property(nonatomic, retain) IBOutlet UITextView *result;

-(IBAction)begin_search:(id)sender;

-(IBAction)close_text:(id)sender;

@end
