//
//  KBCreateQRCode.m
//  CreateQRCode
//
//  Created by kobe on 16/3/14.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "KBCreateQRCode.h"

@implementation KBCreateQRCode


+(UIImage *)createQRCodeFromString:(NSString *)string
{
    return [self createQRCodeFromString:string codeSize:100.0f red:0 green:0 blue:0 insertImage:nil roundRadius:0.f];
}

+(UIImage *)createQRCodeFromString:(NSString *)string
                          codeSize:(CGFloat)codesize
{
    return [self createQRCodeFromString:string codeSize:codesize red:0 green:0 blue:0 insertImage:nil];
    
}

+(UIImage *)createQRCodeFromString:(NSString *)string
                          codeSize:(CGFloat)codesize
                               red:(NSUInteger)red
                             green:(NSUInteger)green
                              blue:(NSUInteger)blue
{
    return [self createQRCodeFromString:string codeSize:codesize red:red green:green blue:blue insertImage:nil roundRadius:0.f];
}


+(UIImage *)createQRCodeFromString:(NSString *)string
                          codeSize:(CGFloat)codesize
                               red:(NSUInteger)red
                             green:(NSUInteger)green
                              blue:(NSUInteger)blue
                       insertImage:(UIImage *)image
{
    return [self createQRCodeFromString:string codeSize:codesize red:red green:green blue:blue insertImage:image roundRadius:0.f];
}

/*
 *Use String Size RGB Image Radius To Create a QRCode
 */
+(UIImage *)createQRCodeFromString:(NSString *)string
                          codeSize:(CGFloat)codesize
                               red:(NSUInteger)red
                             green:(NSUInteger)green
                              blue:(NSUInteger)blue
                       insertImage:(UIImage *)image
                       roundRadius:(CGFloat)radius
{
    if (!string || (NSNull *)string==[NSNull null]) {
        return nil;
    }
    
    NSUInteger rgb=(red<<16)+(green<<8)+blue;
   
     NSAssert((rgb & 0xffffff00) <= 0xd0d0d000, @"The color of QR code is two close to white color than it will diffculty to scan");
     codesize=[self validateCodeSize:codesize];
    
    //create a QRCodeImage
    CIImage *originImage=[self createQRCode:string];
    //progress QRCodeImage
    UIImage *progressImage=[self excludeFuzzyImageFromCIImage:originImage size:codesize];
    
    UIImage *effectiveImage=[self imageFillBlackColorAndTransparent:progressImage red:red green:green blue:blue];
    
    return [self insertImage:effectiveImage insertImage:image radius:radius];
    
}


#pragma mark-private
/**
 *  control the codeSize to fit
 *
 *  @param codeSize Size
 *
 *  @return fit size
 */
+(CGFloat)validateCodeSize:(CGFloat)codeSize
{
    //Max
    codeSize=MAX(160, codeSize);
    //Min
    codeSize=MIN(CGRectGetWidth([UIScreen mainScreen].bounds)-80, codeSize);
    
    return codeSize;
}

/**
 *  Use CIFilter Create a QRCodeImage
 *
 *  @param string String
 *
 *  @return CIImage
 */
+(CIImage *)createQRCode:(NSString *)string
{
    NSData *dataString=[string dataUsingEncoding:NSUTF8StringEncoding];
    //创建滤镜
    CIFilter *filter=[CIFilter filterWithName:@"CIQRCodeGenerator"];
    //设置数据KVC
    [filter setValue:dataString forKey:@"inputMessage"];
    //设置纠错级别
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
    //输出CIImage
    return filter.outputImage;
}
/**
 *  progress CIImage
 *
 *  @param image CIImage
 *  @param size  Size
 *
 *  @return UIImage
 */
+(UIImage *)excludeFuzzyImageFromCIImage:(CIImage *)image
                                    size:(CGFloat)size
{
    //返回一个整数大小的尺寸
    CGRect extent=CGRectIntegral(image.extent);
    //缩放比例
    CGFloat scale=MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    //size_t类型返回缩放比例之后的尺寸
    size_t width=CGRectGetWidth(extent)*scale;
    size_t height=CGRectGetHeight(extent)*scale;
    
    //使用RGB颜色空间
    CGColorSpaceRef colorSpace=CGColorSpaceCreateDeviceGray();
    
    //创建一个bitmap上下文
    CGContextRef bitmapRef=CGBitmapContextCreate(nil, width, height, 8, 0, colorSpace,(CGBitmapInfo)kCGImageAlphaNone);
    //CIContext图形上下文
    CIContext *context=[CIContext contextWithOptions:nil];
    //创建一个extent大小的CGImageRef
    CGImageRef bitmapImage=[context createCGImage:image fromRect:extent];
    //生成图片的质量
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    //缩放
    CGContextScaleCTM(bitmapRef, scale, scale);
    //画图
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    //生成一张缩放后的bitmap图片
    CGImageRef scaleImage=CGBitmapContextCreateImage(bitmapRef);
    
    //释放内存
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    CGColorSpaceRelease(colorSpace);
    
    return [UIImage imageWithCGImage:scaleImage];
}


/**
 *  Fill Color And Transparent BackGround
 *
 *  @param image Image
 *  @param red   R
 *  @param green G
 *  @param blue  B
 *
 *  @return UIImage
 */
+(UIImage *)imageFillBlackColorAndTransparent:(UIImage *)image
                                          red:(NSUInteger)red
                                        green:(NSUInteger)green
                                         blue:(NSUInteger)blue
{
    //图片的大小
    const int imageWidth=image.size.width;
    const int imageHeight=image.size.height;
    
    size_t bytesPerRow=imageWidth*4;
    //缓存大小
    uint32_t *rgbImageBuf=(uint32_t *)malloc(bytesPerRow * imageHeight);
    
    //使用RGB颜色空间
    CGColorSpaceRef colorSpace=CGColorSpaceCreateDeviceRGB();
    CGContextRef context=CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    
    //绘制图像
    CGContextDrawImage(context, (CGRect){(CGPointZero),(image.size)},image.CGImage);
    
    //像素的个数
    int pixelNumber=imageWidth * imageHeight;
    
    //遍历像素
    [self fillWhiteToTransparentOnPixel:rgbImageBuf pixelNum:pixelNumber red:red green:green blue:blue];
    
    //释放内存的数据
    CGDataProviderRef dataProvider=CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow,ProviderReleaseData);
    //创建一张图片
    CGImageRef imageRef=CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace, kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,NULL, true, kCGRenderingIntentDefault);
    
    //转换成UIImage图片
    UIImage *resultImage=[UIImage imageWithCGImage:imageRef];
    
    //释放内存
    CGImageRelease(imageRef);
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    
    return resultImage;
}


/**
 *  Fill Color Pixel And Transparent BackGround
 *
 *  @param rgbImageBuf Buffer
 *  @param pixelNum    Number
 *  @param red         R
 *  @param green       G
 *  @param blue        B
 */
+(void)fillWhiteToTransparentOnPixel:(uint32_t *)rgbImageBuf
                            pixelNum:(int)pixelNum
                                 red:(NSUInteger)red
                               green:(NSUInteger)green
                                blue:(NSUInteger)blue
{
    //指针指向缓存区域的地址
    uint32_t *pCurPtr=rgbImageBuf;
    //遍历
    for (int i=0; i<pixelNum; i++,pCurPtr++) {
        if ((*pCurPtr & 0xffffff00) < 0x99999900) {
            //指针指向指针的地址
            uint8_t *ptr=(uint8_t *)pCurPtr;
            ptr[3]=red;
            ptr[2]=green;
            ptr[1]=blue;
        }else{
            uint8_t *ptr=(uint8_t *)pCurPtr;
            //透明颜色
            ptr[0]=0;
        }
    }
}


/**
 *  free Buffer
 *
 *  @param info info
 *  @param data data
 *  @param size size_t
 */
void ProviderReleaseData(void * info, const void * data, size_t size) {
    //释放内存数据
    free((void *)data);
}


/**
 *  insert Image
 *
 *  @param originImage origin Image
 *  @param insertImage insert Image
 *  @param radius      radius
 *
 *  @return UIImage
 */
+(UIImage *)insertImage:(UIImage *)originImage
            insertImage:(UIImage *)insertImage
                 radius:(CGFloat)radius
{
    if (!insertImage) {
        return originImage;
    }
    
    insertImage=[self createRoundCornerImage:insertImage size:insertImage.size radius:radius];
    //背景图片
    UIImage *whiteBG=[UIImage imageNamed:@"whiteBG"];
    whiteBG=[self createRoundCornerImage:whiteBG size:whiteBG.size radius:radius];
    
    //白色边缘的宽度
    const CGFloat whiteSize=2.0f;
    CGSize brinkSize=CGSizeMake(originImage.size.width/4, originImage.size.height/4);
    CGFloat brinkX=(originImage.size.width-brinkSize.width)*0.5;
    CGFloat brinkY=(originImage.size.height-brinkSize.height)*0.5;
    
    CGSize imageSize=CGSizeMake(brinkSize.width-2*whiteSize, brinkSize.height-2*whiteSize);
    CGFloat imageX=brinkX+whiteSize;
    CGFloat imageY=brinkY+whiteSize;
    
    //开启图形上下文
    UIGraphicsBeginImageContext(originImage.size);
    //绘制
    [originImage drawInRect:(CGRect){0,0,(originImage.size)}];
    [whiteBG drawInRect:(CGRect){brinkX,brinkY,(brinkSize)}];
    [insertImage drawInRect:(CGRect){imageX,imageY,(imageSize)}];
    UIImage *resultImage=UIGraphicsGetImageFromCurrentImageContext();
    //关闭图形上下文
    UIGraphicsEndImageContext();
    
    return resultImage;
}

/**
 *  Setup Image Corner
 *
 *  @param image  Image
 *  @param size   Size
 *  @param radius Radius
 *
 *  @return UIImage
 */
+(UIImage *)createRoundCornerImage:(UIImage *)image
                              size:(CGSize)size
                            radius:(CGFloat)radius
{
    if (!image || (NSNull *)image==[NSNull null]) {
        return nil;
    }
    //图片的大小
    const CGFloat width=size.width;
    const CGFloat height=size.height;
    
    //Radius
    radius=MAX(5.0f,radius);
    radius=MIN(10.f, radius);
    
    UIImage *img=image;
    //使用RGB颜色空间
    CGColorSpaceRef colorSpace=CGColorSpaceCreateDeviceRGB();
    //创建一个Bitmap
    CGContextRef context=CGBitmapContextCreate(NULL, width, height, 8, 4*width, colorSpace,kCGImageAlphaPremultipliedFirst);
    CGRect rect=CGRectMake(0, 0, width, height);
    
    CGContextBeginPath(context);
    drawRoundPath(context,rect,radius,image.CGImage);
    CGImageRef imageMasked=CGBitmapContextCreateImage(context);
    img=[UIImage imageWithCGImage:imageMasked];
    
    //释放内存
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageMasked);
    
    return img;

}

/**
 *  drawRoundPath
 *
 *  @param context CGcontextRef
 *  @param rect    Size
 *  @param radius  Radius
 *  @param image   Image
 */
void drawRoundPath(CGContextRef context,CGRect rect,float radius,CGImageRef image)
{
    float width,height;
    if (radius==0) {
        CGContextAddRect(context, rect);
        return;
    }
    
    //保存当前图像的状态
    CGContextSaveGState(context);
    //位移
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    width=CGRectGetWidth(rect);
    height=CGRectGetHeight(rect);
    
    //绘制
    CGContextMoveToPoint(context, width, height/2);
    CGContextAddArcToPoint(context, width, height, width/2, height, radius);
    CGContextAddArcToPoint(context, 0, height, 0, height/2, radius);
    CGContextAddArcToPoint(context, 0, 0, width/2, 0, radius);
    CGContextAddArcToPoint(context, width, 0, width, height/2, radius);
    CGContextClosePath(context);
    CGContextClip(context);
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), image);
    //存储
    CGContextRestoreGState(context);
}


@end
