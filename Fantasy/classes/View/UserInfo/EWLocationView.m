//
//  EWLocationView.m
//  Fantasy
//
//  Created by wansy on 15/6/1.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import "EWLocationView.h"


@interface EWLocationView ()

- (IBAction)cancel:(id)sender;
- (IBAction)sure:(id)sender;

@end

@implementation EWLocationView

+(instancetype)location{
    return [[[NSBundle mainBundle] loadNibNamed:@"EWLocationView" owner:nil options:nil] lastObject];
}

- (IBAction)sure:(UIButton *)sender {
}
- (IBAction)cancel:(id)sender {
}

@end
