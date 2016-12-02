//
//  KBCreateQRCode.h
//  CreateQRCode
//
//  Created by kobe on 16/3/14.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface KBCreateQRCode : NSObject

/**
 *  create a QRCodeImage With String
 *
 *  @param string String
 *
 *  @return UIImage
 */
+(UIImage *)createQRCodeFromString:(NSString *)string;

/**
 *  create a QRCodeImage With String Size
 *
 *  @param string    String
 *  @param codesize  Size
 *
 *  @return UIImage
 */

+(UIImage *)createQRCodeFromString:(NSString *)string
                          codeSize:(CGFloat)codesize;
/**
 *  create a QRCodeImage With String Size RGB
 *
 *  @param string   String
 *  @param codesize Size
 *  @param red      R
 *  @param green    G
 *  @param blue     B
 *
 *  @return UIImage
 */
+(UIImage *)createQRCodeFromString:(NSString *)string
                          codeSize:(CGFloat)codesize
                               red:(NSUInteger)red
                             green:(NSUInteger)green
                              blue:(NSUInteger)blue;
/**
 *  create a QRCodeImage With String Size RGB Image
 *
 *  @param string   String
 *  @param codesize Code
 *  @param red      R
 *  @param green    G
 *  @param blue     B
 *  @param image    Image
 *
 *  @return UIImage
 */
+(UIImage *)createQRCodeFromString:(NSString *)string
                          codeSize:(CGFloat)codesize
                               red:(NSUInteger)red
                             green:(NSUInteger)green
                              blue:(NSUInteger)blue
                       insertImage:(UIImage *)image;

/**
 *  create a QRCodeImage With String,Size,RGB,Image,Radius
 *
 *  @param string   String
 *  @param codesize Size
 *  @param red      R
 *  @param green    G
 *  @param blue     B
 *  @param image    Image
 *  @param radius   Radius
 *
 *  @return UIImage
 */
+(UIImage *)createQRCodeFromString:(NSString *)string
                          codeSize:(CGFloat)codesize
                               red:(NSUInteger)red
                             green:(NSUInteger)green
                              blue:(NSUInteger)blue
                       insertImage:(UIImage *)image
                       roundRadius:(CGFloat)radius;



/**
 *  create a Radius Image
 *
 *  @param image  Image
 *  @param size   Size
 *  @param radius Radius
 *
 *  @return UIImage
 */
+(UIImage *)createCornerImage:(UIImage *)image
                         size:(CGSize)size
                       radius:(CGFloat)radius;


@end
