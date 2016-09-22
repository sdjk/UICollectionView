//
//  MyCell.m
//  UICollectionView
//
//  Created by Hsiao on 16/9/19.
//  Copyright © 2016年 HS. All rights reserved.
//

#import "MyCell.h"

@interface MyCell ()
@property (weak, nonatomic) IBOutlet UIImageView *cellImage;

@end


@implementation MyCell

// 重写setter方法 设置图片
- (void)setImage:(UIImage *)image
{
    _image = image;
    
    _cellImage.image = image;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
