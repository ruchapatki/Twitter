//
//  DetailsViewController.m
//  twitter
//
//  Created by Rucha Patki on 7/3/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface DetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenName;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;


@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.authorLabel.text = self.tweet.user.name;
    NSString *atSign = @"@";
    self.screenName.text = [atSign stringByAppendingString:self.tweet.screenName];
    self.tweetLabel.text = self.tweet.text;
    //TODO: SET IMAGE!!
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
