//
//  YXNetWorking.swift
//  DownloadArtifact
//
//  Created by DZH_Louis on 2017/7/21.
//  Copyright © 2017年 DZH_Louis. All rights reserved.
//

import Foundation

enum requestType : String{   //请求类型
    case OPTIONS = "OPTIONS"
    case GET = "GET"
    case HEAD = "HEAD"
    case POST = "POST"
    case PUT = "PUT"
    case PATCH = "PATCH"
    case DELETE = "DELETE"
    case TRACE = "TRACE"
    case CONNECT = "CONNECT"
}

/** 请求成功的回调 */
typealias SucceedHandler = (NSData?,URLResponse?) ->Void
/** 请求失败的回调 */
typealias FailedHandler = (URLSessionTask?,NSError) ->Void
/** 下载进度回调 */
typealias DownloadProgressBlock = (URLSessionDownloadTask, Int64, Int64, Int64) -> Void
/** 上传进度回调 */
typealias UploadProgressBlock = (URLSessionDownloadTask, Int64,  Int64, Int64) -> Void
/** 完成下载回调 */
typealias FinishDownloadBlock = (URLSessionDownloadTask, NSURL) -> Void
/** 完成任务回调 */
typealias CompletionBlock = (URLSessionTask, AnyObject?, NSError?) -> Void

var successHandler:SucceedHandler?
var failHandler:FailedHandler?
var downloadProgressHandler:DownloadProgressBlock?
var uploadProgressHandler:UploadProgressBlock?
var finishHandler:FinishDownloadBlock?
var completionHandler:CompletionBlock?







