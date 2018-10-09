//
//  ViewController.m
//  WenMemory
//
//  Created by LHWen on 2018/9/23.
//  Copyright © 2018年 LHWen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

// 队列汇总处理
- (void)testDispatchQueue {
    
    NSLog(@"----------* queue *-----------");
    /**创建自己的队列*/
    dispatch_queue_t dispatchQueue = dispatch_queue_create("com.wen.t", DISPATCH_QUEUE_CONCURRENT);
    /**创建一个队列组*/
    dispatch_group_t dispatchGroup = dispatch_group_create();
    /**将队列任务添加到队列组中*/
    dispatch_group_async(dispatchGroup, dispatchQueue, ^(){
        NSLog(@"dispatch - 1");
    });
    /**将队列任务添加到队列组中*/
    dispatch_group_async(dispatchGroup, dispatchQueue, ^(){
        NSLog(@"dspatch - 2");
    });
    /**队列组完成调用函数*/
    dispatch_group_notify(dispatchGroup, dispatch_get_main_queue(), ^(){
        NSLog(@"end");
    });
}

// 栅栏
- (void)testBarrier {
    
    /** 并发队列
     遇到 dispatch_barrier_async 栅栏 在执行 1 2（1 2 并发） 后先执行 barrier 再执行 3 4（3 4 并发）
     如果 没有 barrier 1 2 3 4 全部一起并发
     */
    NSLog(@"---------* barrier *----------");
    dispatch_queue_t concurrentQueue = dispatch_queue_create("wen.barrier.queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(concurrentQueue, ^(){
        NSLog(@"dispatch-1");
    });
    dispatch_async(concurrentQueue, ^(){
        NSLog(@"dispatch-2");
    });
    dispatch_barrier_async(concurrentQueue, ^(){
        NSLog(@"dispatch-barrier");
    });
    dispatch_async(concurrentQueue, ^(){
        NSLog(@"dispatch-3");
    });
    dispatch_async(concurrentQueue, ^(){
        NSLog(@"dispatch-4");
    });
    
    // 异步 加入队列  实现线程的同步的方法：串行队列、分组 也是可以使用并发队列
    dispatch_async(concurrentQueue, ^{
        //1 网络 处理
        dispatch_sync(concurrentQueue, ^{
            
        });
        //2 主线程UI 处理
        dispatch_sync(dispatch_get_main_queue(), ^{
            
        });
    });
    
}

@end
