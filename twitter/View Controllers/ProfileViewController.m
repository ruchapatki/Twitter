//
//  ProfileViewController.m
//  twitter
//
//  Created by Rucha Patki on 7/5/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "ProfileViewController.h"
#import "APIManager.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"
#import "TweetCell.h"

@interface ProfileViewController ()



@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UILabel *screenName;
@property (weak, nonatomic) IBOutlet UILabel *bio;


@property (weak, nonatomic) IBOutlet UILabel *numberFollowing;
@property (weak, nonatomic) IBOutlet UILabel *numberFollowers;
@property (weak, nonatomic) IBOutlet UILabel *numberTweets;




@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(self.user == nil){
        [[APIManager shared] getProfileInfo:^(NSDictionary *accountInfo, NSError *error) {
            if (accountInfo) {
                NSLog(@"😎😎😎 Successfully loaded profile info");
                NSLog(@"%@", accountInfo);
                
                User *user = [[User alloc]initWithDictionary:accountInfo];
                self.user = user;
                [self setViews];
            } else {
                NSLog(@"😫😫😫 Error loading profile info: %@", error.localizedDescription);
            }
        }];
    }
    else{
        [self setViews];
    }
}

- (void)setViews{
    self.nameLabel.text = self.user.name;
    NSString *incompleteString = @"@";
    self.screenName.text = [incompleteString stringByAppendingString:self.user.screenName];
    self.numberFollowing.text = [self.user.numberFollowing stringValue];
    self.numberFollowers.text = [self.user.numberFollowers stringValue];
    self.numberTweets.text = [self.user.numberTweets stringValue];
    self.bio.text = self.user.bio;
    
    //set profile image
    NSURL *profileUrl = [NSURL URLWithString:self.user.profileImageURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:profileUrl];
    
    [self.profileImage setImageWithURLRequest: request placeholderImage:nil success:^(NSURLRequest * imageRequest, NSHTTPURLResponse *  imageResponse, UIImage * image) {
        //success
        self.profileImage.image = image;
    } failure:^(NSURLRequest * request, NSHTTPURLResponse * response, NSError * error) {
        NSLog(@"Error: %@", error);
    }];
    
    //set banner image
    NSURL *bannerURL = [NSURL URLWithString:self.user.backgroundImageURL];
    NSURLRequest *request2 = [NSURLRequest requestWithURL:bannerURL];
    
    [self.backgroundImage setImageWithURLRequest: request2 placeholderImage:nil success:^(NSURLRequest * imageRequest, NSHTTPURLResponse *  imageResponse, UIImage * image) {
        //success
        self.backgroundImage.image = image;
    } failure:^(NSURLRequest * request, NSHTTPURLResponse * response, NSError * error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
