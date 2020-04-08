//
//  QDHomeSectionView.m
//  iOSProject
//
//  Created by 苏秋东 on 2020/2/4.
//  Copyright © 2020 苏秋东. All rights reserved.
//

#import "QDHomeSectionView.h"
#import "UIButton+QDExtension.h"
@implementation QDHomeSectionView

- (void)awakeFromNib{
    [super awakeFromNib];
    CGFloat wh = (QDScreen_Width - 40 * 3 - 20 * 2) * 0.25;
    self.movieBtn.frame = CGRectMake(self.movieBtn.left, self.movieBtn.top, wh, wh);
    
    self.tvBtn.bounds = self.movieBtn.bounds;
    self.varietyBtn.bounds = self.movieBtn.bounds;
    self.animeBtn.bounds = self.movieBtn.bounds;
    
    self.movieBtn.backgroundColor = QDGetColor(@"FF6347");
    
    [self.movieBtn setImage:QDGetImage(@"电影") forState:UIControlStateNormal];
    [self.movieBtn setImage:QDGetImage(@"电影") forState:UIControlStateHighlighted];
    [self.movieBtn cornerAllCornersWithCornerRadius:self.movieBtn.height * 0.5];
    self.movieBtn.tag = 10001;
    [self.movieBtn addTarget:self action:@selector(cateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tvBtn setImage:QDGetImage(@"电视剧") forState:UIControlStateNormal];
    [self.tvBtn setImage:QDGetImage(@"电视剧") forState:UIControlStateHighlighted];
    [self.tvBtn cornerAllCornersWithCornerRadius:self.tvBtn.height * 0.5];
    self.tvBtn.backgroundColor = QDGetColor(@"4169E1");
    self.tvBtn.tag = 10002;
    [self.tvBtn addTarget:self action:@selector(cateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.varietyBtn setImage:QDGetImage(@"综艺") forState:UIControlStateNormal];
    [self.varietyBtn setImage:QDGetImage(@"综艺") forState:UIControlStateHighlighted];
    [self.varietyBtn cornerAllCornersWithCornerRadius:self.varietyBtn.height * 0.5];
    self.varietyBtn.backgroundColor = QDGetColor(@"20B2AA");
    self.varietyBtn.tag = 10003;
    [self.varietyBtn addTarget:self action:@selector(cateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.animeBtn setImage:QDGetImage(@"动漫") forState:UIControlStateNormal];
    [self.animeBtn setImage:QDGetImage(@"动漫") forState:UIControlStateHighlighted];
    [self.animeBtn cornerAllCornersWithCornerRadius:self.animeBtn.height * 0.5];
    self.animeBtn.backgroundColor = QDGetColor(@"FF69B4");
    self.animeBtn.tag = 10004;
    [self.animeBtn addTarget:self action:@selector(cateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)cateBtnClick:(UIButton *)btn{
    if (self.cateBtnClickBlock) {
        self.cateBtnClickBlock(btn.tag - 10000);
    }
}

@end
