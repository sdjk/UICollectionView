//
//  ViewController.m
//  UICollectionView
//
//  Created by Hsiao on 16/9/19.
//  Copyright © 2016年 HS. All rights reserved.
//

#import "ViewController.h"
#import "MyCell.h"

#import "MyLayout.h"

@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation ViewController

static NSString *const ID = @"cell";


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //
    
    // 创建一个布局
    MyLayout *flowLayout = ({
        
        
        MyLayout *flowLayout = [[MyLayout alloc] init];
        
        // UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        // 修改item的尺寸
        flowLayout.itemSize = CGSizeMake(150, 150);
        
        
        // 修改滚动方向,水平滚动
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        // 修改距离，最小值，每条滚动线上item距离的最小值
        flowLayout.minimumLineSpacing = 50;
        
        // 这个最小值不一定可以实现，还要考虑布局的问题
        // flowLayout.minimumInteritemSpacing = 0;
        
        // 最后进行赋值
        flowLayout;
    });
    
    // 在视图上添加一个collectionView
    UICollectionView *view = ({
    
       UICollectionView *view = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 150, [UIScreen mainScreen].bounds.size.width, 200) collectionViewLayout:flowLayout];
        
        view.backgroundColor = [UIColor redColor];
        
        
        // 两边的内缩量
        view.contentInset = UIEdgeInsetsMake(0, 100, 0, 100);
        
        
        // 隐藏滚动条
        view.showsHorizontalScrollIndicator = NO;
        
        
        // 设置数据源方法
        view.dataSource = self;
        
        
        // 设置代理方法
        // view.delegate = self;
        
        // 要注册cell
        // [view registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
        
        // 从Xib中注册
        [view registerNib:[UINib nibWithNibName:NSStringFromClass([MyCell class]) bundle:nil] forCellWithReuseIdentifier:ID];
        
    
        view;
    
    });
    
    // 添加子视图
    [self.view addSubview:view];
    
}


#pragma mark -
#pragma mark - UICollectionViewDataSource

// 返回每组有多少cell
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

// 返回cell
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    MyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    
    NSString *imageName = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
    
    UIImage *image = [UIImage imageNamed:imageName];
    
    cell.image = image;
    
    
    return cell;
}


#pragma mark -
#pragma mark - UICollectionViewDelegate

// 滚动会调用该方法，这个方法不行，打印的是cell生成时候，固定的值

/*
 这里可以获得每个单独cell的坐标，但是调用时间，和值都不好
 
*/
#if 0
-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@", NSStringFromCGPoint(cell.center));
    
    NSLog(@"%ld", indexPath.row);
    
    // 屏幕宽度的中心点
    CGFloat with = [UIScreen mainScreen].bounds.size.width * 0.5;
    NSLog(@"%f", with);
    
}


/*
 
 要实现图片的放大缩小功能，必须要监听每一次的滚动
 
 我想模仿之前的网易新闻，但是这里有cell重用的问题
 
 无法获得单独的每个cell，一共只有6个子视图
 
 collectionView有布局参数，应该修改布局
 
*/
// 只要一拖动就会调用该方法
// 这是 UICollectionView的父类UIScrollView的代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    for (UIView *subView in scrollView.subviews)
    {
        NSLog(@"%@", NSStringFromCGPoint(subView.center));
        
        
        subView.transform = CGAffineTransformMakeScale(1.2, 1.2);
    }

    // 只打印了六个子视图
    NSLog(@"%ld", scrollView.subviews.count);
    
}

#endif


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
