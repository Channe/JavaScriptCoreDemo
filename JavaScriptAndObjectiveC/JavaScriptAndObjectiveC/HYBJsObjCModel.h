//
//  HYBJsObjCModel.h
//  JavaScriptAndObjectiveC
//
//  Created by QianLei on 16/2/25.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import <UIKit/UIKit.h>

//供JS调用的OC方法,在这些方法的实现里可以调用JS方法
@protocol JSCallObjectiveCDelegate <JSExport>

// JS调用此方法来调用OC，参数通过JSON传到OC
- (void)callWithDict:(NSDictionary *)params;

// JS调用此方法来调用OC的方法
- (void)callSystemCamera;

// JS调用OC，然后在OC中通过调用JS方法来传值给JS
- (void)jsCallObjcAndObjcCallJsWithDict:(NSDictionary *)params;

// 在JS中调用下面两个参数的OC方法时，函数名应该为showAlertMsg(arg1, arg2)
- (void)showAlert:(NSString *)title msg:(NSString *)msg;

@end

// 此模型用于注入JS的模型，这样就可以通过模型来调用方法。
@interface HYBJsObjCModel : NSObject <JSCallObjectiveCDelegate>

@property (nonatomic, weak) JSContext *jsContext;
@property (nonatomic, weak) UIWebView *webView;

@end
