//
//  gifKeyViewController.m
//  gifKey
//
//  Created by Daniel Glunz on 7/12/14.
//  Copyright (c) 2014 dglunz. All rights reserved.
//

#import "gifKeyViewController.h"
#import "UIImage+animatedGIF.h"

@interface gifKeyViewController ()

@end

@implementation gifKeyViewController
@synthesize enteredSearch = _enteredSearch;
@synthesize gifView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)search:(id)sender {
    // store search value
    self.enteredSearch = self.searchField.text;
    
    NSString *restCallString = @"http://api.giphy.com/v1/gifs/search?q=funny+cat&api_key=dc6zaTOxFJmzC";
    
    // Make the request, returning a JSON response, just as a plain old string.
    NSData *jsonDataString = [[NSString stringWithContentsOfURL:[NSURL URLWithString:restCallString] encoding:NSUTF8StringEncoding error: nil] dataUsingEncoding:NSUTF8StringEncoding];
    
    // Keep a reference to a nil error so we can pass it into a JSON parser and learn of any errors
    NSError *error = nil;
    
    // Now, using the JSON parser, we'll get a dictionary representing our parsed JSON data
    NSDictionary *results = [NSJSONSerialization JSONObjectWithData:jsonDataString options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:&error];
    
    // Now that we have an NSDictionary object containing the reconstituted results, we can obtain the objects we want from the dictionary using a key path like so...
    NSArray *myResults = [results valueForKeyPath:@"data"];
    
    // Just get the first element from the array
    NSDictionary *singleGif = (NSDictionary *)[myResults objectAtIndex:0];
    
    // Get image frames
    NSDictionary *singleGifFrame = (NSDictionary *)[singleGif valueForKeyPath:@"images"];
    NSDictionary *singleGifFrameOriginal = (NSDictionary *)[singleGifFrame valueForKeyPath:@"original"];
    
    //get URL and convert to string for some reason
    NSURL *gifURL = [NSURL URLWithString:[singleGifFrameOriginal valueForKeyPath:@"url"]];
    NSString *URLtext = [gifURL absoluteString];
    
    //pull in data from url
    NSData *gifData = [NSData dataWithContentsOfURL:[NSURL URLWithString:URLtext]];
    
    //apply data to custom UIimage method for animated gif
    UIImage *gifByData = [UIImage animatedImageWithAnimatedGIFData:gifData];
    
    //initialize an image view with the gif to view
    UIImageView *imageView = [[UIImageView alloc] initWithImage:gifByData];
    self.gifView = imageView;
    [self.view addSubview:gifView];
   
}


- (BOOL)textFieldShouldReturn:(UITextField *)searchTextField {
    
    [searchTextField resignFirstResponder];
    return YES;
    
}
@end
