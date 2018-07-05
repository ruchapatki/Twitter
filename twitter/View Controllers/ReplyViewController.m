//
//  ReplyViewController.m
//  twitter
//
//  Created by Rucha Patki on 7/5/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "ReplyViewController.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"

@interface ReplyViewController ()

@property (weak, nonatomic) IBOutlet UILabel *replyingToLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UITextView *tweetText;


@end

@implementation ReplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString* temporaryText = @"Replying to @";
    self.replyingToLabel.text = [temporaryText stringByAppendingString:self.tweet.user.screenName];
    
    NSString *fullImageURLString = self.tweet.imageURL;
    
    NSURL *url = [NSURL URLWithString:fullImageURLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.userImage setImageWithURLRequest: request placeholderImage:nil success:^(NSURLRequest * imageRequest, NSHTTPURLResponse *  imageResponse, UIImage * image) {
        //success
        self.userImage.image = image;
    } failure:^(NSURLRequest * request, NSHTTPURLResponse * response, NSError * error) {
        NSLog(@"Error: %@", error);
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)replyPressed:(id)sender {
    
    [[APIManager shared] replyToTweet:self.tweetText.text reply:self.tweet.idStr username:self.tweet.screenName completion:^(Tweet *tweet, NSError *error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
        } else {
            [self.delegate didTweet:tweet];
            NSLog(@"%@", @"Successfully replied to tweet");
        }
    }];
    
    //manually dismiss this controller
    [self dismissViewControllerAnimated:YES completion:nil];
    
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
