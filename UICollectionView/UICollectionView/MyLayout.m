//
//  MyLayout.m
//  UICollectionView
//
//  Created by Hsiao on 16/9/20.
//  Copyright © 2016年 HS. All rights reserved.
//

#import "MyLayout.h"

@implementation MyLayout


// 重写父类方法


// 返回一个数组，里面保存了所有Cell的设置,指定区域的cell
// 实现了每一个cell的缩放
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    
    // 获取每一个cell，获取当前可视区域
    NSArray *attrs =  [super layoutAttributesForElementsInRect:self.collectionView.bounds];
    
    // 获取屏幕偏移量
    CGPoint viewOffset = self.collectionView.contentOffset;
    
    // 获取屏幕中心点
    CGFloat with = [UIScreen mainScreen].bounds.size.width * 0.5;
    

    // 取出每一个cell
    for ( UICollectionViewLayoutAttributes *attr in attrs)
    {
        
        // 获取每一个cell中心点的坐标
        // NSLog(@"%@", NSStringFromCGPoint(attr.center));
        
        // fabs()取绝对值
        CGFloat scale = 1.2 - (fabs(attr.center.x - viewOffset.x - with) / with * 0.3);
        
        // 进行缩放
        attr.transform = CGAffineTransformMakeScale(scale, scale);
        
        
    }
    
    return attrs;
}


# if 1
// 只要拖动就重新计算布局，默认是NO
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

// 确定最终偏移量，可以指定位置，返回值是最终的位置
/*
 手指一松开就会调用
 velocity 滚动速度
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    
    // 获取当前显示cell的中心点，然后再比较哪一个cell与中心点的位置最接近
    
    /* 
     proposedContentOffset 最终偏移的坐标
     
     self.collectionView.contentOffset 这是手指离开时的坐标
     */
    NSLog(@"%@  %@", NSStringFromCGPoint(proposedContentOffset), NSStringFromCGPoint(self.collectionView.contentOffset));
    
    
    // 获取屏幕最后的偏移量
    CGPoint viewOffset = [super targetContentOffsetForProposedContentOffset:proposedContentOffset withScrollingVelocity:velocity];
    
    
    // 获取每一个cell，获取当前可视区域
    
    CGRect rect = CGRectMake(viewOffset.x, 0, [UIScreen mainScreen].bounds.size.width, MAXFLOAT);
    
    
    NSArray *attrs =  [super layoutAttributesForElementsInRect:rect];
    
    // 获取屏幕中心点
    CGFloat with = [UIScreen mainScreen].bounds.size.width * 0.5;
    
    CGFloat delta = MAXFLOAT;
    // 取出每一个cell
    for ( UICollectionViewLayoutAttributes *attr in attrs)
    {
        //
        CGFloat minus = attr.center.x - viewOffset.x - with;
        
        // 用绝对值来做比较
        if (fabs(minus) < fabs(delta))
        {
            // 赋值可以是负数
            delta = minus;
        }
        
    }
    
    // 偏移量 或增 或减
    viewOffset.x += delta;
    
    NSLog(@"%f", viewOffset.x);
    
    return viewOffset;
}

#endif

@end
