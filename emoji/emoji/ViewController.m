//
//  ViewController.m
//  emoji
//
//  Created by deerwang(王东东) on 2019/9/2.
//  Copyright © 2019 deerwang. All rights reserved.
//
/*1、点加号添加图片，随机添加
 *2、不用boole类型参数判断 看是否是uisegmentControl的自己方法改变。block。segmental自带功能,进行判断. 首次加载进行判断
 */
#import "ViewController.h"
#define whight 60
@interface ViewController ()
//记录子控件的个数
@property (assign, nonatomic) int total;
@end

@implementation ViewController

//首次加载
- (void)viewDidLoad {
    [super viewDidLoad];
    self.total = 10;
    [self adjustImagePosWithColumns:2 add:true];
}

//添加图片，和图片位置
-(void) addImg:(NSString *)icon x:(CGFloat)x y:(CGFloat)y {
    UIImageView *img = [[UIImageView alloc] init];
    img.image = [UIImage imageNamed:icon];
    img.frame = CGRectMake(x, y, whight, whight);
    [self.view addSubview:img];
}

/*根据列数来调整图片位置
 *如果是首次，则加载图片
 *非首次，则直接移动图片的位置
 */
-(void) adjustImagePosWithColumns:(int)column add:(BOOL)add {
    CGFloat margin = (self.view.frame.size.width - column * whight) / (column + 1);
    CGFloat y= 150;
    CGFloat x= margin;
    
    NSLog(@"total = %d", _total);
    for (int i = 0; i < _total; i++) {
        CGFloat xPos = x + i%column * (margin + whight);
        CGFloat yPos = y + i/column * (margin + whight);
        if (add) {
            if(i == _total-1) {
                //在末尾添加按钮
                UIButton *btn = [[UIButton alloc] init];
                btn.frame = CGRectMake(xPos, yPos, whight, whight);
                UIImage *image = [UIImage imageNamed:@"addBtn.jpg"];
                [btn setImage:image forState:UIControlStateNormal];
                
                //[btn setBackgroundColor:[UIColor redColor]];
                [self.view addSubview:btn];
                
                //添加按监听艇事件
                [btn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
            } else {
                NSString *img = [NSString stringWithFormat:@"01%d.png", i];
                [self addImg:img x:xPos y:yPos];
            }
        } else {
            //取出i+1位置对应的imageView，设置x，y
            //+1是为了跳过第一个UISegmentControl
            UIView *child = self.view.subviews[i + 1];
            CGRect temp = child.frame;
            temp.origin = CGPointMake(xPos, yPos);
            child.frame = temp;
            
            //NSLog(@"for ----%@",child.class); //打印所有子控件
        }
    }
}

//按钮添加图片
- (void)addBtnClick {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    _total = _total + 1;
    
    //将新添加emoji放在按钮的位置
    UIView *childBtn = self.view.subviews[_total - 1];
    CGRect temp = childBtn.frame;
    
    //随机放一张图片 010.png-018.png [0,9)
    NSString *image = [NSString stringWithFormat:@"01%d.png",arc4random() % 9];
    [self addImg:image x:temp.origin.x y:temp.origin.y];
    
    //通过UISegmentedControl获取column
    UISegmentedControl *sc = self.view.subviews[0];
    int column = (int)sc.selectedSegmentIndex+2;
    CGFloat margin = (self.view.frame.size.width - column * whight) / (column + 1);
    CGFloat y= 150;
    CGFloat x= margin;
    CGFloat xPos = x + (_total-1)%column * (margin + whight);
    CGFloat yPos = y + (_total-1)/column * (margin + whight);
    //改变childBtn的位置，移动到最后一个
    temp.origin = CGPointMake(xPos, yPos);
    childBtn.frame = temp;
    
    //交换view下子控件位置，不然每次segmentedContol值变化时获取控件打印的顺序有问题。
    [self.view exchangeSubviewAtIndex:_total withSubviewAtIndex:_total-1];
    
    [UIView commitAnimations];
}

//当UISegmentedControl值改变,移动图片位置
- (IBAction)indexChange:(UISegmentedControl *)sender {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    int column = (int)sender.selectedSegmentIndex + 2;
    [self adjustImagePosWithColumns:column add:false];
   
    [UIView commitAnimations];
}

@end
