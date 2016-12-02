//
//  KBScanViewController.m
//  CreateQRCode
//
//  Created by kobe on 16/3/14.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "KBScanViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "UIView+Extension.h"
#import "TMXAddPrinterVC.h"

@interface KBScanViewController()<AVCaptureMetadataOutputObjectsDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

/** 获取AVCaptureDevice的实例 */
@property(nonatomic,strong)AVCaptureDevice *device;
/** 输入流 */
@property(nonatomic,strong)AVCaptureDeviceInput *input;
/** 输出流 */
@property(nonatomic,strong)AVCaptureMetadataOutput *output;
/** 执行输入和输出流之间的数据传递 */
@property(nonatomic,strong)AVCaptureSession *session;
/** 显示相机捕获到的图层 */
@property(nonatomic,strong)AVCaptureVideoPreviewLayer *previewLayer;
/** 专门用于描边的图层 */
@property(nonatomic,strong)CALayer *containerLayer;


@property(nonatomic,strong)UIImageView *qRCodeImageView;
@property(nonatomic,strong)UIImageView *qRCodeImageViewLine;
@property(nonatomic,strong)NSTimer *timer;

@end

@interface KBScanViewController ()

{
    CGFloat num;
}
@end

@implementation KBScanViewController


#pragma mark-lazyload
-(AVCaptureDevice *)device{
    if (!_device) {
        //创建实例
        _device=[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    return _device;
}

-(AVCaptureDeviceInput *)input{
    if (!_input) {
        //输入
        _input=[AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    }
    return _input;
}

// 设置输出对象解析数据时感兴趣的范围
// 默认值是 CGRect(x: 0, y: 0, width: 1, height: 1)
// 通过对这个值的观察, 我们发现传入的是比例
// 注意: 参照是以横屏的左上角作为, 而不是以竖屏
//        out.rectOfInterest = CGRect(x: 0, y: 0, width: 0.5, height: 0.5)
-(AVCaptureMetadataOutput *)output{
    
    if (!_output) {
        //输出
        _output=[[AVCaptureMetadataOutput alloc]init];
        
        CGFloat x=_qRCodeImageView.frame.origin.y/self.view.size.height;
        CGFloat y=_qRCodeImageView.frame.origin.x/self.view.size.width;
        CGFloat w=_qRCodeImageView.frame.size.height/self.view.size.height;
        CGFloat h=_qRCodeImageView.frame.size.width/self.view.size.width;
        
//        CGRect outRect=CGRectMake(x, y, w, h);
//        [_output rectForMetadataOutputRectOfInterest:outRect];
        _output.rectOfInterest=CGRectMake(x, y, w, h);
    }
    
    return _output;
}

-(AVCaptureSession *)session{
    //执行输入和输出流之间的数据传递
    if (!_session) {
        _session=[[AVCaptureSession alloc]init];
        //高质量采集
        [_session setSessionPreset:AVCaptureSessionPresetHigh];
    }
    return _session;
}

-(AVCaptureVideoPreviewLayer *)previewLayer{
    //预览相机捕获到的图层
    if (!_previewLayer) {
        _previewLayer=[AVCaptureVideoPreviewLayer layerWithSession:self.session];
        _previewLayer.videoGravity=AVLayerVideoGravityResize;
    }
    return _previewLayer;
}


-(CALayer *)containerLayer{
    if (!_containerLayer) {
        _containerLayer=[[CALayer alloc]init];
    }
    return _containerLayer;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self.navigationItem setTitle:NSLocalizedString(@"QrCode_Scan", nil)];
    [self initWithUI];
    [self startScan];
    
}

//注意，在界面消失的时候关闭session
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.session stopRunning];
}

// 界面显示,开始动画
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}


/**
 *  init UI
 */
-(void)initWithUI{
    
    UIImageView *qRCodeImageView=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.center.x-120, self.view.center.y-120, 240, 240)];
    [qRCodeImageView setContentMode:UIViewContentModeScaleToFill];
    qRCodeImageView.image=[UIImage imageNamed:@"scanscanBg"];
    
    
    UIImageView *qRCodeImageViewLine=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.center.x-120, self.view.center.y-120, 240, 5)];
    [qRCodeImageViewLine setContentMode:UIViewContentModeScaleToFill];
    qRCodeImageViewLine.image=[UIImage imageNamed:@"scanLine@2x"];
    
    [self.view addSubview:qRCodeImageView];
    [self.view addSubview:qRCodeImageViewLine];
    self.qRCodeImageViewLine=qRCodeImageViewLine;
    self.qRCodeImageView=qRCodeImageView;
    
    [self setOverView];
    
    
    NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(scanLineAnimation) userInfo:nil repeats:YES];
    self.timer=timer;
    
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem normalImage:@"PhotoScan_white" selectImage:@"PhotoScan_white" target:self action:@selector(skipPhoto)];
    
}

//跳转相册
- (void)skipPhoto
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
    UIImagePickerController *picker=[[UIImagePickerController alloc]init];
    picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate=self;
    [self presentViewController:picker animated:YES completion:nil];
}


/**
 *  scanLine Animation
 */
-(void)scanLineAnimation{
    num++;
        if (num>235) {
        _qRCodeImageViewLine.frame=CGRectMake(self.view.center.x-120, self.view.center.y-120, 240, 5);
            num=0;
    }else{
        _qRCodeImageViewLine.frame=CGRectMake(self.view.center.x-120, self.view.center.y-120+num, 240, 5);
    }
}

/**
 *  overLayer
 */
- (void)setOverView {
    //获取屏幕的宽度和高度
    CGFloat width = CGRectGetWidth(self.view.frame);
    CGFloat height = CGRectGetHeight(self.view.frame);
    
    CGFloat x = CGRectGetMinX(_qRCodeImageView.frame);
    CGFloat y = CGRectGetMinY(_qRCodeImageView.frame);
    CGFloat w = CGRectGetWidth(_qRCodeImageView.frame);
    CGFloat h = CGRectGetHeight(_qRCodeImageView.frame);
    
    //顶部
    [self creatView:CGRectMake(0, 0, width, y)];
    //左边
    [self creatView:CGRectMake(0, y, x, h)];
    //底部
    [self creatView:CGRectMake(0, y + h, width, height - y - h)];
    //右边
    [self creatView:CGRectMake(x + w, y, width - x - w, h)];
}

/**
 *  create Rect
 *
 *  @param rect Rect
 */
- (void)creatView:(CGRect)rect {
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor =[UIColor grayColor];
    view.alpha = 0.5;
    
    [self.view addSubview:view];
}

/**
 *  start to Scan QRCode
 */
-(void)startScan{
    
    //判断输入是否添加到会话层中
    if (![self.session canAddInput:self.input]) return;
    [self.session addInput:self.input];
    
    //判断输入能否添加到会话层中
    if (![self.session canAddOutput:self.output]) return;
    [self.session addOutput:self.output];
    
    //设置输出能够解析的数据类型
    self.output.metadataObjectTypes=self.output.availableMetadataObjectTypes;
    
    //设置监听输出解析到的数据
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //添加预览图层
    [self.view.layer insertSublayer:self.previewLayer atIndex:0];
    self.previewLayer.frame=self.view.bounds;
    
    //添加容器图层
    [self.view.layer addSublayer:self.containerLayer];
    self.containerLayer.frame=self.view.bounds;
    
    
    //开始扫描
    [self.session startRunning];
}


#pragma mark-AVCaptureMetadataOutputObjectsDelegate

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    //取出数组对象
    AVMetadataMachineReadableCodeObject *object=[metadataObjects lastObject];
    if (object==nil) return;
    NSLog(@"输出%@",object.stringValue);
    //清空Layer
    [self clearLayers];
    
    //对扫描到的二维码进行描边
    AVMetadataMachineReadableCodeObject *obj=(AVMetadataMachineReadableCodeObject *)[self.previewLayer transformedMetadataObjectForMetadataObject:object];
    [self drawLine:obj];
    
    //解析数据
    NSDictionary *dict=[NSDictionary dictionaryWithDictionary:[self parseJSONStringToNSDictionary:[NSObject jsonTypeStringWithString:object.stringValue]]];
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"code"]=dict[@"code"];
    params[@"printerId"]=dict[@"printerId"];
    [self.session stopRunning];
    TMXAddPrinterVC *addPrnterVC=[TMXAddPrinterVC new];
    addPrnterVC.requestParams = params;
    [self.navigationController pushViewController:addPrnterVC animated:YES];
   
}

-(NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString {
    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
    return responseJSON;
}
// 绘制描边
- (void)drawLine:(AVMetadataMachineReadableCodeObject *)objc
{
    NSArray *array = objc.corners;
    
    // 1.创建形状图层, 用于保存绘制的矩形
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    
    // 设置线宽
    layer.lineWidth = 2;
    layer.strokeColor = [UIColor greenColor].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    
    // 2.创建UIBezierPath, 绘制矩形
    UIBezierPath *path = [[UIBezierPath alloc] init];
    CGPoint point = CGPointZero;
    int index = 0;
    
    CFDictionaryRef dict = (__bridge CFDictionaryRef)(array[index++]);
    // 把点转换为不可变字典
    // 把字典转换为点，存在point里，成功返回true 其他false
    CGPointMakeWithDictionaryRepresentation(dict, &point);
    
    [path moveToPoint:point];
    
    // 2.2连接其它线段
    for (int i = 1; i<array.count; i++) {
        CGPointMakeWithDictionaryRepresentation((__bridge CFDictionaryRef)array[i], &point);
        [path addLineToPoint:point];
    }
    // 2.3关闭路径
    [path closePath];
    
    layer.path = path.CGPath;
    // 3.将用于保存矩形的图层添加到界面上
    [self.containerLayer addSublayer:layer];
    
}


/**
 *  Clear Layer
 */
- (void)clearLayers
{
    if (self.containerLayer.sublayers)
    {
        for (CALayer *subLayer in self.containerLayer.sublayers)
        {
            [subLayer removeFromSuperlayer];
        }
    }
}



/**
 *  Scan Photo QRCode
 */
-(void)ScanPictureCode{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
    UIImagePickerController *picker=[[UIImagePickerController alloc]init];
    picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate=self;
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark-UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //取出选中的图片
    UIImage *pickerImage=info[UIImagePickerControllerOriginalImage];
    NSData *dataImage=UIImagePNGRepresentation(pickerImage);
    
    //读取图片的二维码数据
    CIImage *ciImage=[CIImage imageWithData:dataImage];
    
    //创建一个探测器
    CIDetector *dector=[CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy:CIDetectorAccuracyLow}];
    
    //利用探测器探测数据
    NSArray *feture=[dector featuresInImage:ciImage];
    
    //取出探测器的数据
    for (CIQRCodeFeature *result in feture) {
        NSString *url=result.messageString;
        [[UIApplication sharedApplication]openURL:[NSURL  URLWithString:url]];
        
        NSDictionary *dict=[NSDictionary dictionaryWithDictionary:[self parseJSONStringToNSDictionary:[NSObject jsonTypeStringWithString:url]]];
        NSMutableDictionary *needParams=[NSMutableDictionary dictionary];
        needParams[@"code"]=dict[@"code"];
        needParams[@"printerId"]=dict[@"printerId"];
        TMXAddPrinterVC *addPrnterVC=[TMXAddPrinterVC new];
        addPrnterVC.requestParams=needParams;
        [self.navigationController pushViewController:addPrnterVC animated:YES];
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
