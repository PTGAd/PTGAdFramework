//
//  PTGSafeDictionary.h
//  PTGAdSDK
//
//  Created by PTG on 2024/01/01.
//  Copyright © 2024 PTG. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * 线程安全的字典封装类
 * 特性：
 * 1. 线程安全 - 使用串行队列保护所有操作
 * 2. 边界安全 - 自动检查空值、空key
 * 3. KVO支持 - 支持键值观察
 * 4. 下标操作 - 支持[]语法
 * 5. 拷贝支持 - 实现NSCopying协议
 * 6. 序列化安全 - 实现NSCoding协议
 * 7. 高性能 - 读写分离优化
 */
@interface PTGSafeDictionary<KeyType, ObjectType> : NSObject <NSCopying, NSMutableCopying, NSCoding, NSSecureCoding>

#pragma mark - 初始化方法

/**
 * 创建空字典
 */
+ (instancetype)dictionary;

/**
 * 使用现有字典创建
 */
+ (instancetype)dictionaryWithDictionary:(NSDictionary<KeyType, ObjectType> *)dict;

/**
 * 使用键值对创建
 */
+ (instancetype)dictionaryWithObject:(ObjectType)object forKey:(KeyType <NSCopying>)key;

/**
 * 使用对象和键数组创建
 */
+ (instancetype)dictionaryWithObjects:(NSArray<ObjectType> *)objects forKeys:(NSArray<KeyType <NSCopying>> *)keys;

/**
 * 指定初始化方法
 */
- (instancetype)initWithDictionary:(nullable NSDictionary<KeyType, ObjectType> *)dict;

#pragma mark - 基础属性

/**
 * 字典元素个数
 */
@property (nonatomic, readonly) NSUInteger count;

/**
 * 是否为空
 */
@property (nonatomic, readonly) BOOL isEmpty;

/**
 * 所有键
 */
@property (nonatomic, readonly) NSArray<KeyType> *allKeys;

/**
 * 所有值
 */
@property (nonatomic, readonly) NSArray<ObjectType> *allValues;

#pragma mark - 访问方法

/**
 * 安全获取指定键的对象
 * @param aKey 键，nil返回nil
 * @return 对象，不存在返回nil
 */
- (nullable ObjectType)objectForKey:(KeyType)aKey;

/**
 * 下标访问（只读）
 */
- (nullable ObjectType)objectForKeyedSubscript:(KeyType)key;

/**
 * 获取多个键对应的对象
 */
- (NSArray<ObjectType> *)objectsForKeys:(NSArray<KeyType> *)keys notFoundMarker:(ObjectType)marker;

#pragma mark - 查找方法

/**
 * 查找对象对应的键
 */
- (nullable KeyType)keyForObject:(ObjectType)anObject;

/**
 * 查找所有对象对应的键
 */
- (NSArray<KeyType> *)allKeysForObject:(ObjectType)anObject;

#pragma mark - 修改方法

/**
 * 安全设置键值对
 * @param anObject 对象，nil会移除对应键
 * @param aKey 键，nil会被忽略
 */
- (void)setObject:(nullable ObjectType)anObject forKey:(KeyType <NSCopying>)aKey;

/**
 * 下标赋值
 */
- (void)setObject:(nullable ObjectType)obj forKeyedSubscript:(KeyType <NSCopying>)key;

/**
 * 安全移除指定键的对象
 * @param aKey 键，nil会被忽略
 */
- (void)removeObjectForKey:(KeyType)aKey;

/**
 * 移除多个键的对象
 */
- (void)removeObjectsForKeys:(NSArray<KeyType> *)keyArray;

/**
 * 清空字典
 */
- (void)removeAllObjects;

#pragma mark - 同步修改方法（解决异步写操作时序问题）

/**
 * 同步设置键值对（立即生效）
 * @param anObject 对象，nil会移除对应键
 * @param aKey 键，nil会被忽略
 */
- (void)setObjectSync:(nullable ObjectType)anObject forKey:(KeyType <NSCopying>)aKey;

/**
 * 同步下标赋值（立即生效）
 */
- (void)setObjectSync:(nullable ObjectType)obj forKeyedSubscript:(KeyType <NSCopying>)key;

/**
 * 同步移除指定键的对象（立即生效）
 * @param aKey 键，nil会被忽略
 */
- (void)removeObjectForKeySync:(KeyType)aKey;

#pragma mark - 批量操作

/**
 * 添加字典
 */
- (void)addEntriesFromDictionary:(NSDictionary<KeyType, ObjectType> *)otherDictionary;

/**
 * 设置字典内容
 */
- (void)setDictionary:(NSDictionary<KeyType, ObjectType> *)otherDictionary;

/**
 * 批量设置键值对
 */
- (void)setObjects:(NSArray<ObjectType> *)objects forKeys:(NSArray<KeyType <NSCopying>> *)keys;

#pragma mark - 转换方法

/**
 * 转换为不可变字典
 */
- (NSDictionary<KeyType, ObjectType> *)toDictionary;

/**
 * 转换为可变字典
 */
- (NSMutableDictionary<KeyType, ObjectType> *)toMutableDictionary;

#pragma mark - 枚举方法

/**
 * 枚举键值对
 */
- (void)enumerateKeysAndObjectsUsingBlock:(void (^)(KeyType key, ObjectType obj, BOOL *stop))block;

/**
 * 安全枚举（在枚举过程中允许修改）
 */
- (void)safeEnumerateKeysAndObjectsUsingBlock:(void (^)(KeyType key, ObjectType obj, BOOL *stop))block;

/**
 * 并发枚举
 */
- (void)enumerateKeysAndObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(KeyType key, ObjectType obj, BOOL *stop))block;

/**
 * 获取线程安全的键枚举器
 * @return NSEnumerator 实例，用于安全枚举字典中的键
 */
- (NSEnumerator<KeyType> *)keyEnumerator;

/**
 * 获取线程安全的对象枚举器
 * @return NSEnumerator 实例，用于安全枚举字典中的对象
 */
- (NSEnumerator<ObjectType> *)objectEnumerator;

#pragma mark - 函数式方法

/**
 * 过滤键
 */
- (NSSet<KeyType> *)keysOfEntriesPassingTest:(BOOL (^)(KeyType key, ObjectType obj, BOOL *stop))predicate;

/**
 * 映射值
 */
- (PTGSafeDictionary<KeyType, id> *)mappedDictionaryUsingBlock:(id (^)(KeyType key, ObjectType obj))block;

/**
 * 过滤字典
 */
- (PTGSafeDictionary<KeyType, ObjectType> *)filteredDictionaryUsingBlock:(BOOL (^)(KeyType key, ObjectType obj))block;

#pragma mark - 序列化

/**
 * 安全的JSON序列化
 */
- (nullable NSData *)safeJSONData;

/**
 * 从JSON数据创建
 */
+ (nullable instancetype)dictionaryWithJSONData:(NSData *)jsonData;

#pragma mark - 类型安全的便利方法

/**
 * 安全获取字符串值
 */
- (nullable NSString *)stringForKey:(KeyType)key;

/**
 * 安全获取数字值
 */
- (nullable NSNumber *)numberForKey:(KeyType)key;

/**
 * 安全获取数组值
 */
- (nullable NSArray *)arrayForKey:(KeyType)key;

/**
 * 安全获取字典值
 */
- (nullable NSDictionary *)dictionaryForKey:(KeyType)key;

/**
 * 安全获取布尔值
 */
- (BOOL)boolForKey:(KeyType)key;

/**
 * 安全获取整数值
 */
- (NSInteger)integerForKey:(KeyType)key;

/**
 * 安全获取浮点值
 */
- (double)doubleForKey:(KeyType)key;

@end

NS_ASSUME_NONNULL_END