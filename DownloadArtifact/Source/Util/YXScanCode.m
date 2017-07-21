//
//  YXScanCode.m
//  DownloadArtifact
//
//  Created by DZH_Louis on 2017/7/21.
//  Copyright © 2017年 DZH_Louis. All rights reserved.
//
//提高扫描识别率的,思路 先捕获当前界面图片,然后对图像进行处理,处理之后再扫描
#import "YXScanCode.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

#define SelfW self.bounds.size.width
#define SelfH self.bounds.size.height 
#define ScanLineH 30 

@interface YXScanCode ()<AVCaptureMetadataOutputObjectsDelegate> // 用于处理采集信息的代理
{
    AVCaptureSession *session;// 输入输出的中间桥梁
    CAGradientLayer *scanLayer;
    UIView *scanBox;
}
@property (strong, nonatomic) AVCaptureSession *captureSession;
@property (strong, nonatomic) AVCaptureDeviceInput *videoInput;
@property (strong, nonatomic) AVCaptureStillImageOutput *stillImageOutput;

@end

@implementation YXScanCode

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createSession];
    } return self;
}

- (void)createSession
{
    // 获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    // 创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    // 创建输出流
    AVCaptureVideoDataOutput *output = [[AVCaptureVideoDataOutput alloc]init];
    output.videoSettings = @{(NSString *)kCVPixelBufferPixelFormatTypeKey : @(kCVPixelFormatType_32BGRA)};
    [output setSampleBufferDelegate:self queue:dispatch_get_main_queue()];
    // 初始化链接对象
    session = [[AVCaptureSession alloc]init];
    // 高质量采集率
    [session setSessionPreset:AVCaptureSessionPresetHigh];
    [session addInput:input];
    [session addOutput:output];
//    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc]init];
//    // 设置代理，在主线程里刷新
//    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    // 设置扫码支持的编码格式（如下设置条形码和二维码兼容）
//    output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode128Code];
    // 实例化预览图层
    AVCaptureVideoPreviewLayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    // 设置预览图层填充方式
    layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    layer.frame = self.layer.bounds;
    [self.layer insertSublayer:layer atIndex:0];
    UIView *maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SelfW,SelfH)];
    [maskView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.7]]; [self addSubview:maskView];
    // 运用贝塞尔曲线配合CAShapeLayer
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, SelfW, SelfH)];
    // MARK: circlePath 画圆
    // [path appendPath:[UIBezierPath bezierPathWithArcCenter:CGPointMake(SelfW / 2, 200) radius:100 startAngle:0 endAngle:2*M_PI clockwise:NO]];
    // MARK: roundRectanglePath 画矩形！
    [path appendPath:[[UIBezierPath bezierPathWithRoundedRect:CGRectMake(SelfW *0.2f, SelfH*0.35f, SelfW - SelfW*0.4f, SelfH - SelfH *0.7f) cornerRadius:0] bezierPathByReversingPath]];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath; [maskView.layer setMask:shapeLayer];
    //[self setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.7]];
    // 设置扫描范围
    // 注意，这个属性各个方向的取值范围为0-1，表示占layer层的长度比例，x对应的是距离左上角的垂直距离，y对应的是距离左上角的水平距离，w对应的是底部距离左上角的垂直距离，h对应的是最右边距离左上角的水平距离
//    output.rectOfInterest = CGRectMake(0.35f, 0.2f, 0.7f, 0.8f);
    // 设置扫描框
    scanBox = [[UIView alloc]initWithFrame:CGRectMake(SelfW *0.2f, SelfH*0.35f, SelfW - SelfW*0.4f, SelfH - SelfH *0.7f)];
    scanBox.layer.borderColor = [UIColor greenColor].CGColor; scanBox.layer.borderWidth = 1.0f; [self addSubview:scanBox];
    // 扫描线
    scanLayer = [[CAGradientLayer alloc]init];
    scanLayer.frame = CGRectMake(0, 0, scanBox.bounds.size.width, ScanLineH);
    [scanBox.layer addSublayer:scanLayer];
    // 设置渐变颜色方向
    scanLayer.startPoint = CGPointMake(0, 0);
    scanLayer.endPoint = CGPointMake(0, 1);
    // 设定颜色组
    scanLayer.colors = @[(__bridge id)[UIColor clearColor].CGColor,(__bridge id)[UIColor brownColor].CGColor]; NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(moveScanLayer:) userInfo:nil repeats:YES]; [timer fire];
    // 开始捕获
    [session startRunning];
}

// 以上之后我们的UI上已经可以看到摄像头捕获的内容，只要实现代理中的方法，就可以完成二维码条形码的扫描：
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects.count>0) {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex : 0 ];
        [session stopRunning];
        //输出扫描字符串
        NSLog(@"%@",metadataObject.stringValue);
        [scanLayer removeFromSuperlayer];
    }
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    UIImage *image = [self imageFromSampleBuffer:sampleBuffer];
    CIImage *ciImage = [CIImage imageWithCGImage:image.CGImage];
    
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:nil];
    NSArray *feature = [detector featuresInImage:ciImage];
    
    //取出探测到的数据
    for (CIQRCodeFeature *result in feature)
    {
        NSString  *content = result.messageString;
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"扫描结果" message:content delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alert show];
    }
}

// 通过抽样缓存数据创建一个UIImage对象
- (UIImage *) imageFromSampleBuffer:(CMSampleBufferRef) sampleBuffer
{
    // 为媒体数据设置一个CMSampleBuffer的Core Video图像缓存对象
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    // 锁定pixel buffer的基地址
    CVPixelBufferLockBaseAddress(imageBuffer, 0);
    // 得到pixel buffer的基地址
    void *baseAddress = CVPixelBufferGetBaseAddress(imageBuffer);
    // 得到pixel buffer的行字节数
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    // 得到pixel buffer的宽和高
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    // 创建一个依赖于设备的RGB颜色空间
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    // 用抽样缓存的数据创建一个位图格式的图形上下文（graphics context）对象
    CGContextRef context = CGBitmapContextCreate(baseAddress, width, height, 8,
                                                 bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    // 根据这个位图context中的像素数据创建一个Quartz image对象
    CGImageRef quartzImage = CGBitmapContextCreateImage(context);
    // 解锁pixel buffer
    CVPixelBufferUnlockBaseAddress(imageBuffer,0);
    // 释放context和颜色空间
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    // 用Quartz image创建一个UIImage对象image
    UIImage *image = [UIImage imageWithCGImage:quartzImage];
    // 释放Quartz image对象
    CGImageRelease(quartzImage);
    return (image);
}

// 实现计时器方法moveScanLayer:
- (void)moveScanLayer:(NSTimer *)timer {
    CGRect frame = scanLayer.frame;
    if (scanBox.frame.size.height < (scanLayer.frame.origin.y+ScanLineH + 5))
    { frame.origin.y = -5; scanLayer.frame = frame; }
    else{ frame.origin.y += 5; [UIView animateWithDuration:0.1 animations:^{ scanLayer.frame = frame; }];
    }
}


- (void)createCaptureSession
{
    self.captureSession = [[AVCaptureSession alloc] init];
    //Optional: self.captureSession.sessionPreset = AVCaptureSessionPresetMedium;
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError * error = nil;
    self.videoInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    if (self.videoInput)
    {
        [self.captureSession addInput:self.videoInput];
    }
    self.stillImageOutput = [[AVCaptureStillImageOutput alloc] init];//AVCaptureMovieFileOutput、AVCaptureVideoDataOutput、AVCaptureAudioFileOutput、AVCaptureAudioDataOutput
    NSDictionary *stillImageOutputSettings = [[NSDictionary alloc] initWithObjectsAndKeys: AVVideoCodecJPEG, AVVideoCodecKey, nil];
    [self.stillImageOutput setOutputSettings:stillImageOutputSettings];
    [self.captureSession addOutput:self.stillImageOutput];
    AVCaptureVideoPreviewLayer *previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
    UIView *aView = self;
    previewLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [aView.layer addSublayer:previewLayer];
}

- (void)captureAction
{
    if (self.stillImageOutput.connections.count <= 0) {
        return;
    }
    AVCaptureConnection *stillImageConnection = [self.stillImageOutput.connections objectAtIndex:0];
    for (AVCaptureConnection* connection in _stillImageOutput.connections) {
        for (AVCaptureInputPort *port in [connection inputPorts]) {
            if ([[port mediaType] isEqual:AVMediaTypeVideo] ) {
                stillImageConnection = connection;
                break;
            }
        }
        if (stillImageConnection) { break; }
    }

    if ([stillImageConnection isVideoOrientationSupported]){
        [stillImageConnection setVideoOrientation:AVCaptureVideoOrientationPortrait];
    }
    [self.stillImageOutput captureStillImageAsynchronouslyFromConnection:stillImageConnection
                                                         completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error)
     {
         if (imageDataSampleBuffer != NULL)
         {
             NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
//             UIImage *image = [[UIImage alloc] initWithData:imageData];

             CIImage *ciImage = [CIImage imageWithData:imageData];
             CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:nil];
             NSArray *feature = [detector featuresInImage:ciImage];
             
             //取出探测到的数据
             for (CIQRCodeFeature *result in feature) {
                NSString  *content = result.messageString;
                 UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"扫描结果" message:content delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
                 [alert show];
             }
         }
         else
             NSLog(@"Error capturing still image: %@", error);
     }];
}
@end
