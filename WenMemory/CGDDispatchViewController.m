//
//  CGDDispatchViewController.m
//  WenMemory
//
//  Created by LHWen on 2018/9/23.
//  Copyright © 2018年 LHWen. All rights reserved.
//

#import "CGDDispatchViewController.h"

/** GCD 系统提供 dispatch */

@interface CGDDispatchViewController ()

@end

@implementation CGDDispatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 后台执行
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       // 后台执行代码
        
    });
    
    // 主线程执行
    dispatch_async(dispatch_get_main_queue(), ^{
       // 主线程执行代码，注意 iOS11 之后所有跟UI相关代码处理 需要在主线程执行
        
    });
    
    // 一次性执行  慎用
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       // 需要执行一次的代码
        
    });
    
    // 延迟执行
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        // 延迟后代码需要在主线程执行
        // background模式下是使用，在应用唤醒时才会执行这部分代码，原因 background模式 主线程休眠
        
    });
    
    // dispatch_queue_t 也可以自己定义，如果自定义queue，可使用dispatch_queue_create 方法
    dispatch_queue_t urls_queue = dispatch_queue_create("github.com", NULL);
    dispatch_async(urls_queue, ^{
        // 执行代码
    });
    //MRC 下需要自主调用 dispatch_release(urls_queue); 释放，ARC下不需要自主管理
    
    // 让后台两个线程 并行执行，等两个线程都结束后，在汇总执行结果
    // 可使用 dispatch_group dispatch_group_async dispatch_group_notify 来实现
    // 使用场景：一个页面需要多个网络请求数据后渲染页面的，可等待所有数据请求完回来汇总时进行UI渲染
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
       // 并行执行线程一
        
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        // 并行执行线程二
        
    });
    
    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
        // 进行结果汇总
        
    });
    
    /** block 修改外部变量 */
    __block int a = 0;
    void (^foo)(void) = ^{
        a = 2;
    };
    foo();
    // a 的值被修改为 2
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
