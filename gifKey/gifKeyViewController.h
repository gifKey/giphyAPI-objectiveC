//
//  gifKeyViewController.h
//  gifKey
//
//  Created by Daniel Glunz on 7/12/14.
//  Copyright (c) 2014 dglunz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface gifKeyViewController : UIViewController <UITextFieldDelegate,NSURLConnectionDelegate,NSXMLParserDelegate>
{
    NSURLConnection *currentConnection;
    NSXMLParser *xmlParser;
}
- (IBAction)search:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *searchField;
@property (copy, nonatomic) NSString *enteredSearch;
@property (retain, nonatomic) NSMutableData *apiReturnXMLData;
@property (weak, nonatomic) UIImageView *gifView;


@property (copy, nonatomic) NSString *url;
@property (copy, nonatomic) NSString *currentElement;

@end
