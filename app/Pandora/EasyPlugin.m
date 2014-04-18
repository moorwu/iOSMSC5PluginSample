//
//  EasyPlugin.m
//  PandoraDev
//
//  Created by Wu Moor on 4/18/14.
//
//

#import "EasyPlugin.h"

@implementation EasyPlugin

@synthesize isShow, cbID;

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    PDRPluginResult *result = [PDRPluginResult resultWithStatus:PDRCommandStatusOK messageAsString:buttonIndex==0?@"Ok's clicked":@"Cancel's clicked"];
    [self toCallback:self.cbID withReslut:[result toJSONString]];
    alertView.delegate = nil;
    self.isShow = false;
    self.cbID = nil;
}

- (void)show:(PGMethod*)command {
    NSArray *args = command.arguments;
    NSString *message = [args objectAtIndex:0];
    NSString *callbackID = [args objectAtIndex:1];
    
    if ( !self.isShow ) {
        if ( ![message isKindOfClass:[NSString class]] ) {
            message = @"你好像没有输入内容奥";
        }
        
        if ( [callbackID isKindOfClass:[NSString class]] ) {
            self.cbID = callbackID;
        }
        
        UIAlertView *popMessage = [[UIAlertView alloc]
                                   initWithTitle:@"Plugin1"
                                   message:message
                                   delegate:self cancelButtonTitle:@"确认"
                                   otherButtonTitles:@"取消", nil];
        [popMessage show];
        self.isShow = TRUE;
    }
}



- (NSData*)getString:(PGMethod*)command {
    return [self resultWithString:@"Hello Plugin from Objective-C code"];
}

@end
