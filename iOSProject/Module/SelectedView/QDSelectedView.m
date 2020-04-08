//
//  QDSelectedView.m
//  iOSProject
//
//  Created by 苏秋东 on 2019/4/7.
//  Copyright © 2019 苏秋东. All rights reserved.
//

#import "QDSelectedView.h"

@implementation QDSelectedView{
    UIButton *_selectedBtn;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self loadDefault];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadDefault];
    }
    return self;
}

- (void)loadDefault{
    self.titleWidth = 50;
    self.buttonBackGroundColor = QDGetColor(@"20B2AA");
    self.buttonTitleColor = QDGetColor(@"000000");
    self.buttonSelectedTitleColor = QDGetColor(@"FF4500");
}

- (void)loadTitle{
    self.scrollView.contentSize = CGSizeMake(self.titleWidth * self.titleArray.count, self.height);
    for (NSInteger index = 0; index < self.titleArray.count; index++) {
        UIButton *button = [[UIButton alloc] init];
        button.frame = CGRectMake(self.titleWidth * index, 0, self.titleWidth, _scrollView.height);
        button.backgroundColor = self.buttonBackGroundColor;
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:self.titleArray[index] forState:UIControlStateNormal];
        [button setTitleColor:self.buttonTitleColor forState:UIControlStateNormal];
        [button setTitleColor:self.buttonSelectedTitleColor forState:UIControlStateSelected];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 10000 + index;
        [_scrollView addSubview:button];
        if (index == 0) {
            button.selected = YES;
            _selectedBtn = button;
        }
    }
}

- (void)buttonClicked:(UIButton *)btn{
    NSLog(@"btn.tag--%ld",(long)btn.tag);
    _selectedBtn.selected = !_selectedBtn.isSelected;
    _selectedBtn = btn;
    _selectedBtn.selected = YES;
    if (self.selectedTitleBlock) {
        self.selectedTitleBlock(btn.tag - 10000,btn.currentTitle);
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _scrollView.delegate = self;
        _scrollView.backgroundColor = QDColorWhite;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
        [self addSubview:_scrollView];
    }
    return _scrollView;
}


@end
