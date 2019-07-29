//
//  TrPay.h
//  trpaysdk
//
//  Created by wubangjun on 2017/12/27.
//  Copyright © 2017年 wubangjun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol TrPayDelegate <NSObject>

/**
 * @param tradename 商品名称
 * @param outtradeno 订单号，商户需要保证自己系统中唯一
 * @param amount 金额单位分 如：1.5元需要传 150
 * @param payType 支付类型1支付宝2微信3银联
 * @param resultCode 支付状态码1成功2失败
 * @param resultString 支付结果消息
 */
-(void)onPayFinish:(NSString *)outtradeno resultCode:(int )resultCode resultString:(NSString *)resultString payType:(NSInteger)payType amount:(NSInteger)amount tradename:(NSString *)tradename;

@end

@interface TrPay : NSObject

/**
 * 实例化支付对象
 */
+(instancetype) shareInstance;

/**
 * 初始化sdk ,需要传入appkey,channel渠道可不传，尽量传入
 */
-(void)initPaySdk:(NSString *)appKey withChanel:(NSString *)channel;


/**
 * 初始化sdk ,需要传入appkey,channel渠道可不传，尽量传入 收银台导航颜色
 * appKey appKey
 * chanel 渠道
 * navColor 收银台导航颜色
 */
-(void)initPaySdk:(NSString *)appKey withChanel:(NSString *)channel withNavColor:(UIColor *)navColor;

/**
 * 初始化sdk ,需要传入appkey,channel渠道可不传，尽量传入 收银台导航颜色
 * appKey appKey
 * chanel 渠道
 * navColor 收银台导航颜色
 * showDialog 是否显示支付结果提示框
 */
-(void)initPaySdk:(NSString *)appKey withChanel:(NSString *)channel withNavColor:(UIColor *)navColor showDialog:(BOOL)showDialog;

/**
 * 关闭支付页面
 */
-(void)closePayView;
/**
 *
 */
-(void)closePayViewWithCompletion:(void (^)(void))completion;

/**
 *
 * @param tradename 商品名称
 * @param outtradeno 订单号，商户需要保证自己系统中唯一
 * @param amount 金额单位分 如：1.5元需要传 150
 * @param backparams 回传参数，该参数会原样通过支付通知地址，回传给商户后台
 * @param notifyurl 支付异步通知地址
 * @param payuserid 商户系统用户唯一标识
 */
-(void)callPay:(NSString *)tradename
withOutTradeno:(NSString *)outtradeno
    withAmount:(NSInteger )amount
withBackparams:(NSString *)backparams
 withNotifyurl:(NSString *)notifyurl
     payuserid:(NSString *)payuserid
withTrPayDelegate:(id<TrPayDelegate>)trPayDelegate;


-(id<TrPayDelegate>) trPayDelegateOut;

@end
