//
//  PTGThreadSafeUtils.h
//  PTGAdSDK
//
//  Created by PTG on 2024/01/01.
//  Copyright © 2024 PTG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <os/lock.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * 线程安全工具类
 * 提供常用的线程安全操作和性能优化工具
 */
@interface PTGThreadSafeUtils : NSObject

#pragma mark - 主线程检查

/**
 * 检查是否在主线程
 */
+ (BOOL)isMainThread;

/**
 * 确保在主线程执行
 */
+ (void)ensureMainThread:(void (^)(void))block;

/**
 * 异步在主线程执行
 */
+ (void)asyncMainThread:(void (^)(void))block;

/**
 * 同步在主线程执行（非主线程调用时）
 */
+ (void)syncMainThread:(void (^)(void))block;

#pragma mark - 后台线程执行

/**
 * 异步在后台线程执行
 */
+ (void)asyncBackgroundThread:(void (^)(void))block;

/**
 * 在指定队列执行
 */
+ (void)asyncQueue:(dispatch_queue_t)queue block:(void (^)(void))block;

#pragma mark - 延迟执行

/**
 * 延迟执行（主线程）
 */
+ (void)delayMainThread:(NSTimeInterval)delay block:(void (^)(void))block;

/**
 * 延迟执行（后台线程）
 */
+ (void)delayBackgroundThread:(NSTimeInterval)delay block:(void (^)(void))block;

#pragma mark - 队列创建

/**
 * 创建串行队列
 */
+ (dispatch_queue_t)createSerialQueue:(NSString *)name;

/**
 * 创建并发队列
 */
+ (dispatch_queue_t)createConcurrentQueue:(NSString *)name;

/**
 * 创建高优先级队列
 */
+ (dispatch_queue_t)createHighPriorityQueue:(NSString *)name;

/**
 * 创建低优先级队列
 */
+ (dispatch_queue_t)createLowPriorityQueue:(NSString *)name;

#pragma mark - 队列池管理

/**
 * 获取基于hash的共享并发队列
 * 使用对象指针的hash值分配到固定数量的队列池中
 * @param object 用于计算hash的对象
 * @return 分配的并发队列
 */
+ (dispatch_queue_t)sharedConcurrentQueueForObject:(id)object;

/**
 * 获取基于hash的共享串行队列
 * 使用对象指针的hash值分配到固定数量的队列池中
 * @param object 用于计算hash的对象
 * @return 分配的串行队列
 */
+ (dispatch_queue_t)sharedSerialQueueForObject:(id)object;

/**
 * 获取队列池统计信息
 * @return 包含队列池使用情况的字典
 */
+ (NSDictionary *)queuePoolStatistics;

#pragma mark - 锁工具

/**
 * 使用os_unfair_lock执行代码块
 */
+ (void)withUnfairLock:(os_unfair_lock_t)lock block:(void (^)(void))block;

/**
 * 使用NSLock执行代码块
 */
+ (void)withLock:(NSLock *)lock block:(void (^)(void))block;

/**
 * 使用@synchronized执行代码块
 */
+ (void)withSynchronized:(id)obj block:(void (^)(void))block;

#pragma mark - 性能监控

/**
 * 测量代码块执行时间
 */
+ (NSTimeInterval)measureTime:(void (^)(void))block;

/**
 * 测量代码块执行时间并输出日志
 */
+ (NSTimeInterval)measureTimeWithLog:(NSString *)description block:(void (^)(void))block;

#pragma mark - 内存管理

/**
 * 创建弱引用包装器
 */
+ (id)weakWrapper:(id)object;

/**
 * 从弱引用包装器获取对象
 */
+ (nullable id)objectFromWeakWrapper:(id)wrapper;

/**
 * 安全执行block（检查对象是否存在）
 */
+ (void)safeExecute:(id)target block:(void (^)(id strongTarget))block;

#pragma mark - 异常处理

/**
 * 安全执行代码块（捕获异常）
 */
+ (BOOL)safeExecuteBlock:(void (^)(void))block;

/**
 * 安全执行代码块并返回结果
 */
+ (nullable id)safeExecuteBlockWithReturn:(id (^)(void))block;

/**
 * 安全执行代码块（带异常处理回调）
 */
+ (BOOL)safeExecuteBlock:(void (^)(void))block exceptionHandler:(nullable void (^)(NSException *exception))exceptionHandler;

#pragma mark - 快照清理（NSFastEnumeration内存管理）

/**
 * 清理可能泄漏的NSFastEnumeration快照
 * 注意：这是一个兜底机制，正常情况下快照会在枚举结束时自动释放
 */
+ (void)cleanupOrphanedEnumerationSnapshots;

/**
 * 注册NSFastEnumeration快照（用于跟踪）
 * @param snapshot 快照对象
 * @param identifier 唯一标识符
 */
+ (void)registerEnumerationSnapshot:(id)snapshot withIdentifier:(NSString *)identifier;

/**
 * 注销NSFastEnumeration快照
 * @param identifier 唯一标识符
 */
+ (void)unregisterEnumerationSnapshotWithIdentifier:(NSString *)identifier;

@end

#pragma mark - 便利宏定义

/**
 * 主线程执行宏
 */
#define PTG_MAIN_THREAD(block) [PTGThreadSafeUtils ensureMainThread:block]

/**
 * 异步主线程执行宏
 */
#define PTG_ASYNC_MAIN(block) [PTGThreadSafeUtils asyncMainThread:block]

/**
 * 后台线程执行宏
 */
#define PTG_ASYNC_BACKGROUND(block) [PTGThreadSafeUtils asyncBackgroundThread:block]

/**
 * 弱引用宏
 */
#define PTG_WEAK(obj) __weak typeof(obj) weak##obj = obj

/**
 * 强引用宏
 */
#define PTG_STRONG(obj) __strong typeof(weak##obj) obj = weak##obj; if (!obj) return

/**
 * 强引用宏（带返回值）
 */
#define PTG_STRONG_RETURN(obj, ret) __strong typeof(weak##obj) obj = weak##obj; if (!obj) return ret

/**
 * 安全执行宏
 */
#define PTG_SAFE_EXECUTE(block) [PTGThreadSafeUtils safeExecuteBlock:block]

/**
 * 性能测量宏
 */
#define PTG_MEASURE_TIME(desc, block) [PTGThreadSafeUtils measureTimeWithLog:desc block:block]

NS_ASSUME_NONNULL_END