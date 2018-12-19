//
//  ViewController.m
//  test1218
//
//  Created by xialan on 2018/12/18.
//  Copyright © 2018 HARAM. All rights reserved.
//

#import "ViewController.h"
#import "SDTableView.h"
#import "SDPanGestureRecognizer.h"

#define KHeaderHeight ([UIScreen mainScreen].bounds.size.height - 150)

@interface ViewController ()<UITableViewDelegate,
                            UITableViewDataSource,
                            UIGestureRecognizerDelegate>

/**              */
@property (nonatomic, strong) UIScrollView *scrollView;
/**              */
@property (nonatomic, strong) UITableView *tableView;

/** 轮播图数组 */
@property (nonatomic, strong) NSArray *imagesArray;

/** 轮播图的可视高度 */
@property (nonatomic, assign) CGFloat loopHeight;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
  
    [self setupUI];
    
    [self settingTableView];
    
}

-(void)setupUI{
    
    
    
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,KHeaderHeight )];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    [self.view addSubview:_scrollView];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < 4; i++) {
        NSString *img = [NSString stringWithFormat:@"00%zd",i+1];
        [array addObject:[UIImage imageNamed:img]];
        
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.image = [UIImage imageNamed:img];
        
        imgView.frame = CGRectMake(i*self.view.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height);
        [_scrollView addSubview:imgView];
    }
    
    _imagesArray = array.copy;
    
    [_scrollView setContentSize:CGSizeMake(_imagesArray.count*self.view.frame.size.width, 0)];
    
    
    SDPanGestureRecognizer *pan = [[SDPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:) inview:self.view];
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];


}


#pragma mark - 创建TableView
-(void)settingTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.contentInset = UIEdgeInsetsMake(KHeaderHeight, 0, 0, 0);
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    

    
    _tableView.rowHeight = 30;
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
   
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellid"];
    
    [self.view addSubview:_tableView];
   
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 30;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid" forIndexPath:indexPath];
    
    cell.textLabel.text = @(indexPath.row).description;
    
    return cell;
    
    
    
}




-(void)pan:(SDPanGestureRecognizer *)pan{
    
    
    CGRect loopRect = CGRectMake(0, 0, self.scrollView.frame.size.width, _loopHeight);
    
    if (CGRectContainsPoint(loopRect, pan.beginPoint)) {
        NSLog(@"----触摸点在视图内");
        
        switch (pan.state) {
            case UIGestureRecognizerStateBegan:
                
            case UIGestureRecognizerStateChanged:
            {
                CGPoint p = [pan translationInView:self.view];
                CGFloat offsetX = _scrollView.contentOffset.x;
                offsetX = offsetX - p.x;
                
                //当图片已经滑动到最后一张时,继续向左滑动时,不允许最后一张继续移动
                if (offsetX > (_imagesArray.count-1)*_scrollView.frame.size.width) {
                    offsetX = (_imagesArray.count-1)*_scrollView.frame.size.width;
                }
                //当图片已经滑动到第一张,继续向右滑动时,不允许第一张继续移动
                if (offsetX < 0) {
                    offsetX = 0;
                }
                
                
                _scrollView.contentOffset = CGPointMake(offsetX, 0);
                [pan setTranslation:CGPointZero inView:self.view];
                
            }
                
                break;
                
            case UIGestureRecognizerStateFailed:
            case UIGestureRecognizerStateEnded:
            {
                [self scrollViewDidEndScrollingAnimation:self.scrollView];
            }
                
            default:
                break;
        }
        
        
        
        
    }

    
    
    
    
    
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    CGFloat contentOffsetX = scrollView.contentOffset.x;
    
    CGFloat page =  (CGFloat)(int)(contentOffsetX / self.scrollView.bounds.size.width);
    NSLog(@"%lf",page);
    
    
    if (contentOffsetX > (page + 0.5)*scrollView.bounds.size.width) {
        
        CGFloat currentPage = (page+1) >= _imagesArray.count ?
        (_imagesArray.count-1): (page+1);
        
        [scrollView setContentOffset:CGPointMake(currentPage*scrollView.bounds.size.width, 0) animated:YES];
    }else{
        [scrollView setContentOffset:CGPointMake(page*scrollView.bounds.size.width, 0) animated:YES];
    }
    
    
    
    
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    NSLog(@"====%lf",offsetY);
    
    //0-300(轮播图的高度)
    if (offsetY < 0 ) {
        _loopHeight = fabs(offsetY);
    }
}

@end
