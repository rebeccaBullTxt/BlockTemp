//
//  ViewController.m
//  Block使用
//
//  Created by 刘渊 on 2019/9/26.
//  Copyright © 2019 刘渊. All rights reserved.
//

#import "ViewController.h"
typedef void(^MyBlock) (void);
typedef int(^SimpleBlock)(int , int);
@interface ViewController ()
@property (nonatomic, copy) MyBlock block;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self test5];
}

#pragma mark - block作为函数参数
- (void)test1{
    useBlockForC(^(int a, int b) {
        NSLog(@"a + b = %d", a+b);
    });
}

void useBlockForC(void(^aBlock)(int, int)){
    aBlock(20, 30);
//    NSLog(@"123 = %d",aBlock(20, 30));
}

#pragma mark - 声明并赋值定义一个Block变量
- (void)test2{
    //block复制
    _block = ^{
        
    };
    int(^tempBlock)(int) = ^(int num){
        return num * 7;
    };
    tempBlock(20);
}

#pragma mark - 内联block
- (void)test3{
    //声明并赋值
    int(^addBlock)(int, int) = ^(int x, int y){
        return x+y;
    };
    useBlockForC1(addBlock);
    
    //合并以上两种
    useBlockForC1(^int(int a, int b) {
        return a + b;
    });
}

void useBlockForC1 (int(^aBlock)(int, int)) {
    NSLog(@"x + y = %d", aBlock (20, 40));
}

#pragma mark - block作为OC参数
- (void)useBlockForOC:(SimpleBlock)aBlock{
    NSLog(@"result = %d",aBlock(20, 30));
}

- (void)test4{
    SimpleBlock addBlock = ^(int x, int y){
        return x + y;
    };
    [self useBlockForOC:addBlock];
    
    //合并以上两句
    [self useBlockForOC:^int(int x, int y) {
        return  x + y;
    }];
}

#pragma mark - block内访问局部变量
- (void)test5{
    int global = 100;
    MyBlock tempBlock = ^{
        //global ++;
        //报错
        
        NSLog(@"tempBlock = %d",global);
    };
    global = 101;
    tempBlock();
    //在声明Block之后、调用Block之前对局部变量进行修改,在调用Block时局部变量值是修改之前的旧值
    //需要修改局部变量，需要在局部变量前加 __block
    //    __block
}

@end
