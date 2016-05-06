//
//  HYBJsObjCModel.m
//  JavaScriptAndObjectiveC
//
//  Created by QianLei on 16/2/25.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "HYBJsObjCModel.h"

@implementation HYBJsObjCModel

#pragma mark - JSCallObjectiveCDelegate

// JS调用此方法来调用OC，参数通过JSON传到OC
- (void)callWithDict:(NSDictionary *)params {
    NSLog(@"JS调用了OC的方法，参数为：%@", params);
}

// JS调用此方法来调用OC的方法
- (void)callSystemCamera {
    NSLog(@"JS调用了OC的方法，调起系统相册");
    
    // OC调用JS，没有传参数
    JSValue *jsFunc = self.jsContext[@"jsFunc"];
    [jsFunc callWithArguments:nil];
}

// JS调用OC，然后在OC中通过调用JS方法来传值给JS
- (void)jsCallObjcAndObjcCallJsWithDict:(NSDictionary *)params {
    NSLog(@"jsCallObjcAndObjcCallJsWithDict was called, params is %@", params);
    
    // OC调用JS的方法，传JSON参数
    JSValue *jsParamFunc = self.jsContext[@"jsParamFunc"];
    [jsParamFunc callWithArguments:@[@{@"age": @10, @"name": @"lili", @"height": @158}]];
}

// 在JS中调用下面两个参数的OC方法时，函数名应该为showAlertMsg(arg1, arg2)
- (void)showAlert:(NSString *)title msg:(NSString *)msg {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *a = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [a show];
    });
}


@end
