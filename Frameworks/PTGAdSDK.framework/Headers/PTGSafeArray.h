//
//  PTGSafeArray.h
//  PTGAdSDK
//
//  Created by PTG on 2024/01/01.
//  Copyright © 2024 PTG. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * 线程安全的数组封装类
 * 特性：
 * 1. 线程安全 - 使用串行队列保护所有操作
 * 2. 边界安全 - 自动检查越界、空值、空key
 * 3. KVO支持 - 支持键值观察
 * 4. 下标操作 - 支持[]语法
 * 5. 拷贝支持 - 实现NSCopying协议
 * 6. 序列化安全 - 实现NSCoding协议
 * 7. 高性能 - 读写分离优化
 */
@interface PTGSafeArray<ObjectType> : NSObject <NSCopying, NSMutableCopying, NSCoding, NSSecureCoding>

#pragma mark - 初始化方法

/**
 * 创建空数组
 */
+ (instancetype)array;

/**
 * 使用现有数组创建
 */
+ (instancetype)arrayWithArray:(NSArray<ObjectType> *)array;

/**
 * 使用对象创建
 */
+ (instancetype)arrayWithObjects:(ObjectType)firstObj, ... NS_REQUIRES_NIL_TERMINATION;

/**
 * 指定初始化方法
 */
- (instancetype)initWithArray:(nullable NSArray<ObjectType> *)array;

#pragma mark - 基础属性

/**
 * 数组元素个数
 */
@property (nonatomic, readonly) NSUInteger count;

/**
 * 是否为空
 */
@property (nonatomic, readonly) BOOL isEmpty;

#pragma mark - 访问方法

/**
 * 安全获取指定索引的对象
 * @param index 索引
 * @return 对象，越界返回nil
 */
- (nullable ObjectType)objectAtIndex:(NSUInteger)index;

/**
 * 下标访问（只读）
 */
- (nullable ObjectType)objectAtIndexedSubscript:(NSUInteger)index;

/**
 * 获取第一个对象
 */
- (nullable ObjectType)firstObject;

/**
 * 获取最后一个对象
 */
- (nullable ObjectType)lastObject;

#pragma mark - 查找方法

/**
 * 查找对象索引
 */
- (NSUInteger)indexOfObject:(ObjectType)anObject;

/**
 * 是否包含对象
 */
- (BOOL)containsObject:(ObjectType)anObject;

#pragma mark - 修改方法

/**
 * 安全添加对象
 * @param anObject 要添加的对象，nil会被忽略
 */
- (void)addObject:(nullable ObjectType)anObject;

/**
 * 安全插入对象
 * @param anObject 要插入的对象，nil会被忽略
 * @param index 插入位置，越界会调整到边界
 */
- (void)insertObject:(nullable ObjectType)anObject atIndex:(NSUInteger)index;

/**
 * 安全移除指定索引的对象
 * @param index 索引，越界会被忽略
 */
- (void)removeObjectAtIndex:(NSUInteger)index;

/**
 * 移除对象
 */
- (void)removeObject:(ObjectType)anObject;

/**
 * 移除最后一个对象
 */
- (void)removeLastObject;

/**
 * 清空数组
 */
- (void)removeAllObjects;

/**
 * 下标赋值
 */
- (void)setObject:(nullable ObjectType)obj atIndexedSubscript:(NSUInteger)index;

#pragma mark - 同步修改方法（解决异步写操作时序问题）

/**
 * 同步添加对象（立即生效）
 * @param anObject 要添加的对象，nil会被忽略
 */
- (void)addObjectSync:(nullable ObjectType)anObject;

/**
 * 同步插入对象（立即生效）
 * @param anObject 要插入的对象，nil会被忽略
 * @param index 插入位置，越界会调整到边界
 */
- (void)insertObjectSync:(nullable ObjectType)anObject atIndex:(NSUInteger)index;

/**
 * 同步移除指定索引的对象（立即生效）
 * @param index 索引，越界会被忽略
 */
- (void)removeObjectAtIndexSync:(NSUInteger)index;

/**
 * 同步移除对象（立即生效）
 */
- (void)removeObjectSync:(ObjectType)anObject;

/**
 * 同步下标赋值（立即生效）
 */
- (void)setObjectSync:(nullable ObjectType)obj atIndexedSubscript:(NSUInteger)index;

#pragma mark - 批量操作

/**
 * 添加数组
 */
- (void)addObjectsFromArray:(NSArray<ObjectType> *)otherArray;

/**
 * 替换为新数组
 */
- (void)setArray:(NSArray<ObjectType> *)otherArray;

#pragma mark - 转换方法

/**
 * 转换为不可变数组
 */
- (NSArray<ObjectType> *)toArray;

/**
 * 转换为可变数组
 */
- (NSMutableArray<ObjectType> *)toMutableArray;

#pragma mark - 枚举方法

/**
 * 枚举对象
 */
- (void)enumerateObjectsUsingBlock:(void (^)(ObjectType obj, NSUInteger idx, BOOL *stop))block;

/**
 * 安全枚举（在枚举过程中允许修改）
 */
- (void)safeEnumerateObjectsUsingBlock:(void (^)(ObjectType obj, NSUInteger idx, BOOL *stop))block;

/**
 * 获取线程安全的对象枚举器
 * @return NSEnumerator 实例，用于安全枚举数组中的对象
 */
- (NSEnumerator<ObjectType> *)objectEnumerator;

#pragma mark - 函数式方法

/**
 * 过滤
 */
- (PTGSafeArray<ObjectType> *)filteredArrayUsingPredicate:(NSPredicate *)predicate;

/**
 * 映射
 */
- (PTGSafeArray *)mappedArrayUsingBlock:(id (^)(ObjectType obj, NSUInteger idx))block;

#pragma mark - 序列化

/**
 * 安全的JSON序列化
 */
- (nullable NSData *)safeJSONData;

/**
 * 从JSON数据创建
 */
+ (nullable instancetype)arrayWithJSONData:(NSData *)jsonData;

@end

NS_ASSUME_NONNULL_END