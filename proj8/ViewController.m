//
//  ViewController.m
//  proj8
//
//  Created by Admin on 1/22/13.
//  Copyright (c) 2013 Admin. All rights reserved.
//

#import "ViewController.h"
#define get_lang @"http://translate.yandex.net/api/v1/tr.json/detect?text"
#define transl @"http://translate.yandex.net/api/v1/tr.json/translate?lang"


@interface ViewController ()

@end

@implementation ViewController


@synthesize from_text, search_btn, result_text;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}


-(IBAction)close_text:(id)sender {
    [from_text resignFirstResponder];
    [result_text resignFirstResponder];
}

-(IBAction)begin_search:(id)sender {
    NSString *query = from_text.text;
    [from_text resignFirstResponder];
    query = [query stringByReplacingOccurrencesOfString:@" " withString:@"+"];

        query = [query stringByReplacingOccurrencesOfString:@" " withString:@"+"];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData *responseData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@=%@", get_lang, query]]];
            NSDictionary *json = nil;
            @try {
                json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self parseTranslate:json QueryString:query];
                });
            }
            @catch (NSException *exception) {

            }
        });
    
}
    

-(void)parseTranslate:(NSDictionary *) json QueryString:(NSString *) query {
    NSString *lang_from = [json valueForKey:@"lang"];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *translateData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@=%@-ru&text=%@", transl, lang_from, query]]];
        NSDictionary *resultCollection = nil;
        
        @try {
            resultCollection = [NSJSONSerialization JSONObjectWithData:translateData options:kNilOptions error:nil];
            dispatch_async(dispatch_get_main_queue(), ^{
                NSArray *encode = [resultCollection objectForKey:@"text"];
                
                NSLog(@"%@", resultCollection
                      );
                [result_text setText:[NSString stringWithFormat:@"%@", [encode objectAtIndex:0]]];
            });
        }
        @catch (NSException *exception) {
            
        }
    
    });
   
}


-(IBAction)selectFrom:(id)sender {
    
}
    

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
