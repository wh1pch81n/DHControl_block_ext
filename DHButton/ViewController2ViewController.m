//
//  ViewController2ViewController.m
//  DHButton
//
//  Created by Derrick  Ho on 9/3/16.
//  Copyright © 2016 Derrick  Ho. All rights reserved.
//

#import "ViewController2ViewController.h"
#import "DHButton-Swift.h"

@interface ViewController2ViewController ()

@end

@implementation ViewController2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	UIButton *b = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
	b.backgroundColor = [UIColor grayColor];
	[b setTitle:@"bye" forState:UIControlStateNormal];
	[self.view addSubview:b];
	
	[b callbackForControlEvents:(UIControlEventTouchUpInside) withAction:^(id _Nonnull button) {
		NSLog(@"lkjhkj");
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
