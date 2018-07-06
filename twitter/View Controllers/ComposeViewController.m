//
//  ComposeViewController.m
//  twitter
//
//  Created by Rucha Patki on 7/3/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"

@interface ComposeViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *charCount;



@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.textView.delegate = self;

}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    // TODO: Check the proposed new text character count
    // Allow or disallow the new text
    
    // Set the max character limit
    int characterLimit = 140;
    
    // Construct what the new text would be if we allowed the user's latest edit
    NSString *newText = [self.textView.text stringByReplacingCharactersInRange:range withString:text];
    
    unsigned long count = characterLimit - newText.length;
    self.charCount.text = [NSString stringWithFormat:@"%ld", count];
    
    // The new text should be allowed? True/False
    return newText.length < characterLimit;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closePressed:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)tweetPressed:(id)sender {
    
    [[APIManager shared] postStatusWithText:self.textView.text completion:^(Tweet *tweet, NSError *error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
        } else {
            [self.delegate didTweet:tweet];
            NSLog(@"%@", @"Successfully posted tweet");
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
