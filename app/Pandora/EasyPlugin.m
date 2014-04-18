//
//  EasyPlugin.m
//  PandoraDev
//
//  Created by Wu Moor on 4/18/14.
//
//

#import "EasyPlugin.h"

@implementation EasyPlugin

- (NSData*)getString:(PGMethod*)command {
    return [self resultWithString:@"Hello Plugin from Objective-C code"];
}

@end
