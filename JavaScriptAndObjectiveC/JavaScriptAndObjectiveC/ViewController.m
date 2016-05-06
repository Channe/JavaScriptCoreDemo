//
//  ViewController.m
//  JavaScriptAndObjectiveC
//
//  Created by huangyibiao on 15/10/13.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//

#import "ViewController.h"
#import "HYBJsObjCModel.h"

@interface ViewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) JSContext *jsContext;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.webView];
    
    // 一个JSContext对象，就类似于Js中的window，只需要创建一次即可。
    self.jsContext = [[JSContext alloc] init];
    
    [self evaluateJavaScriptExample];
}

//直接执行JS代码
- (void)evaluateJavaScriptExample {
    //计算正方形的面积
    [self.jsContext evaluateScript:@"var num = 10"];
    [self.jsContext evaluateScript:@"var squareFunc = function(value) { return value * 2 }"];
    
    // 调用JS方式一：JSContext直接执行JS代码
    JSValue *square = [self.jsContext evaluateScript:@"squareFunc(num)"];
    NSLog(@"直接执行JS代码方式一:%@", square.toNumber);
    
    // 调用JS方式二：通过下标获取到JSContext中的JS方法，再传入参数调用JS方法
    JSValue *squareFunc = self.jsContext[@"squareFunc"];
    JSValue *value = [squareFunc callWithArguments:@[@"20"]];
    
    NSLog(@"直接执行JS代码方式二:%@", value.toNumber);
}

- (UIWebView *)webView {
    if (_webView == nil) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _webView.scalesPageToFit = YES;
        
//        NSURL *url = [[NSBundle mainBundle] URLForResource:@"dytest" withExtension:@"html"];
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"test" withExtension:@"html"];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:request];
        _webView.delegate = self;
    }
    
    return _webView;
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    // 通过模型调用方法，这种方式更好些。
    HYBJsObjCModel *model  = [[HYBJsObjCModel alloc] init];
    self.jsContext[@"ObjectiveCModel"] = model;

    model.jsContext = self.jsContext;
    model.webView = self.webView;
    
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
        NSLog(@"异常信息：%@", exceptionValue);
    };
}

@end
