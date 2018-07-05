//
//  DetailsViewController.m
//  twitter
//
//  Created by Rucha Patki on 7/3/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"
#import "ReplyViewController.h"

@interface DetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenName;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;

@property (weak, nonatomic) IBOutlet UIButton *favIcon;
@property (weak, nonatomic) IBOutlet UIButton *retweetIcon;
@property (weak, nonatomic) IBOutlet UIButton *replyIcon;

- (void)refreshData: (Tweet *)tweet;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.authorLabel.text = self.tweet.user.name;
    NSString *atSign = @"@";
    self.screenName.text = [atSign stringByAppendingString:self.tweet.screenName];
    self.tweetLabel.text = self.tweet.text;
    
    NSString *fullImageURLString = self.tweet.imageURL;
    
    NSURL *url = [NSURL URLWithString:fullImageURLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.userImage setImageWithURLRequest: request placeholderImage:nil success:^(NSURLRequest * imageRequest, NSHTTPURLResponse *  imageResponse, UIImage * image) {
        //success
        self.userImage.image = image;
    } failure:^(NSURLRequest * request, NSHTTPURLResponse * response, NSError * error) {
        NSLog(@"Error: %@", error);
    }];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshData: (Tweet *)tweet{
    
    if(self.tweet.favorited){
        self.favIcon.imageView.image = [UIImage imageNamed: @"favor-icon-red"];
    }
    else{
        self.favIcon.imageView.image = [UIImage imageNamed:@"favor-icon"];
    }
    
    if(self.tweet.retweeted){
        self.retweetIcon.imageView.image = [UIImage imageNamed: @"retweet-icon-green"];
    }
    else{
        self.retweetIcon.imageView.image = [UIImage imageNamed: @"retween-icon"];
    }
}


- (IBAction)didTapFav:(id)sender {
    if(self.tweet.favorited == NO){
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
        
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
                [self refreshData:self.tweet];
            }
        }];
    }
    else{
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
        
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
                [self refreshData:self.tweet];
            }
        }];
    }
}

- (IBAction)didTapRetweet:(id)sender {
    if(self.tweet.retweeted == NO){
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
        
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
                [self refreshData:self.tweet];
            }
        }];
    }
    else{
        self.tweet.retweeted = NO;
        self.tweet.retweetCount -= 1;
        
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
                [self refreshData:self.tweet];
            }
        }];
    }
}







#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

    Tweet *tweet = self.tweet;
    ReplyViewController *replyViewController = [segue destinationViewController];
    replyViewController.tweet = tweet;
}


@end
