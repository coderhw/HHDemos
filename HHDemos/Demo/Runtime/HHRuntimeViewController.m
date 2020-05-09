//
//  TTRTViewController.m
//  TTProject
//
//  Created by Evan on 16/8/6.
//  Copyright © 2016年 Evan. All rights reserved.
//

/**
 *  runtime
 *  oc是动态语言， oc代码最终都会转换成底层runtime代码
 *  动态的创建类
 *  在程序运行时遍历类的实例变量，属性和方法
 *  在程序运行中动态的创建类、  在类中动态的添加属性和方法
 *  Method Swizzle
 */

#import "HHRuntimeViewController.h"
#import "HHPerson.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "Teacher.h"
#import "HHBook.h"
#import "HHChild.h"
#import "HHParent.h"

@implementation HHRuntimeViewController

- (void)hh_ViewDidLoad {
    [self hh_ViewDidLoad];
    
//    NSObject *obj = [NSObject new];
    //    NSLog(@"class-withOutKVO: %@ \n", object_getClass(obj));
    //    [self testMetaClass];


}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"runtime";
    
    self.view.backgroundColor = [UIColor whiteColor];
//    [self initSwizzLabel];
    
    [self testClassInfo];
}


- (void)initSwizzLabel {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 100, 30)];
    label.text = @"getMethod";
    [self.view addSubview:label];
}

//获取属性
- (IBAction)getIvar:(id)sender {
//    [self testProperties];
    HHBook *book = [[HHBook alloc] init];
    [book readBook];
}

//获取方法
- (IBAction)getMethod:(id)sender {
    
    //遍历对象方法  .cxx_destruct 隐藏的一个方法，和对象的销毁有关
    HHPerson *person = [HHPerson person];
    Class personClass = person.class;
    unsigned int outCount = 0;
    
    Method *methodPtr = class_copyMethodList(personClass, &outCount);
    for(NSInteger i = 0; i < outCount; i++) {
        Method method = methodPtr[i];
        SEL selector = method_getName(method);
        NSLog(@"method :%@", NSStringFromSelector(selector));
    }
}

//添加属性
- (IBAction)addProperty:(id)sender {
    /**
     objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy);
     object:保存到哪个对象中
     key:用什么属性保存传入的值
     value:需保存值
     policy:策略,strong,weak等
     
     // 获取值的方法:
     objc_getAssociatedObject(id object, const void *key);
     object:从哪个对象中获取值
     key: 用什么属性获取值
     */
    HHPerson *person = [HHPerson person];
    objc_setAssociatedObject(person, "weight", @"50KG", OBJC_ASSOCIATION_COPY);
    NSString *weight =  objc_getAssociatedObject(person, "weight");
    NSLog(@"weight: %@", weight);
    
}



//添加方法
- (IBAction)addMethod:(id)sender {
    [self testAddMethod];
}

- (IBAction)messageForward:(id)sender {
    [self testMethodForward];
    
}


- (void)testProperties {
    
    //遍历实例变量
    HHPerson *person = [HHPerson person];
    Class personClass = person.class;
    NSLog(@"class: %@", personClass);
    unsigned int outCount = 0;
    Ivar *ivarPtr = class_copyIvarList(personClass, &outCount);
    for (NSInteger i = 0; i < outCount; i++) {
        Ivar ivar = ivarPtr[i];
        NSLog(@"attribute: %s", ivar_getName(ivar));
    }
    
    //遍历属性
    objc_property_t *propertyPtr = class_copyPropertyList(personClass, &outCount);
    for (NSInteger i = 0; i < outCount; i++) {
        objc_property_t property = propertyPtr[i];
        NSLog(@"property: %s", property_getName(property));
    }
    
    
    [person setAge:@"18"];
    NSLog(@"age1:%@", person.age);
    
    objc_msgSend(person, @selector(setAge:), @"20");
    NSLog(@"age2:%@", person.age);
    
}

- (void)testAddMethod {
    HHPerson *person = [HHPerson person];
    [person performSelector:@selector(studyEngilsh)];
    
}

- (void)testMethodForward {
    Teacher *p = [[Teacher alloc] init];
    [p playPiano];
}

+ (void)load {
    
    //获取有的Method
    Method fromMethod = class_getInstanceMethod([self class], @selector(viewDidLoad));
    
    //获取将要被swizzle的method
    Method toMethod = class_getInstanceMethod([self class], @selector(hh_ViewDidLoad));

    //给当前类添加新的方法
    if(!class_addMethod([self class], @selector(hh_ViewDidLoad),
                        method_getImplementation(toMethod),
                        method_getTypeEncoding(toMethod))){
        method_exchangeImplementations(fromMethod, toMethod);
    }
    
}

- (IBAction)methodSwizzle:(id)sender {
    
}



//
- (void)testMetaClass {
    
    // 分别创建一个可变数组对象mutArray和不可变数组对象array
    NSMutableArray *mutArray = [NSMutableArray arrayWithObjects:@"a", @"b", nil]; // 1
    NSArray *array = @[@"c", @"d"]; // 2
    
  
    // 获取这两个对象mutArray和array的类并打印
    Class mutArrayClassBefore = object_getClass(mutArray); // 3
    Class arrayClassBefore = object_getClass(array); // 4
    NSLog(@"5--%@ -- %@", NSStringFromClass(mutArrayClassBefore), NSStringFromClass(arrayClassBefore)); // 5
   
    //The previous value of object‘s class
    Class setclass = object_setClass(mutArray, arrayClassBefore); // 6
    NSLog(@"7--%@", NSStringFromClass(setclass)); // 7
    
    Class mutArrayClassNow = object_getClass(mutArray); // 8
    Class arrayClassNow = object_getClass(array); // 9
    

    NSLog(@"10--%@ -- %@", NSStringFromClass(mutArrayClassNow), NSStringFromClass(arrayClassNow)); // 10
    
    Class setClass2 = object_setClass(mutArray, mutArrayClassBefore); //11
    NSLog(@"14--mutArray:%@ -- %@", mutArray, NSStringFromClass(setClass2)); //14

    [mutArray addObject:@"c"];
    Class setClass3 = object_setClass(mutArray, mutArrayClassBefore); //12
    NSLog(@"15--mutArray:%@ -- %@", mutArray,  NSStringFromClass(setClass3)); //15
    
}

- (IBAction)isaProperty:(id)sender {
    
//    Class clazz = [self class];
//    Class clarr = [HHRuntimeViewController class];
//
//    Class metaClazz = objc_getMetaClass("HHRuntimeViewController");
//    if(class_respondsToSelector(metaClazz, @selector(viewWillAppear:))){
//        NSLog(@"ok");
//    }
//
//    if(clarr == clazz){
//        NSLog(@"2 ok");
//    }
    
    HHChild *child = [HHChild new];
    [child class];
    
}

- (void)testClassInfo {
    
    //实例对象
    NSObject *object1 = [[NSObject alloc] init];
    NSObject *object2 = [[NSObject alloc] init];
    
    //类对象
    //class方法返回的始终是class对象
    /*
     * class对象在内存中存储的信息主要包括
     * isa指针 superclass指针 类的属性信息(@proerty) 类的对象方法信息(instance method)
     * 类的协议信息(protocol)、类的成员变量信息(ivar)
     * 每个类在内存中有且只有一个class对象
     */
    Class objectClass1 = [object1 class];
    Class objectClass2 = [object2 class];
    Class objectClass3 = object_getClass(object1);
    Class objectClass4 = object_getClass(object2);
    Class objectClass5 = [NSObject class];
    
    //元类对象:将类对象当做参数传入 如果将实例对象当做参数传入，返回的则是类对象
    /*
     * 静态方法存在metaClass中
     * isa指针 superclass指针 类的方法信息(class method)
     * class_isMetaClass 判断是否是一个Meta对象
     */
    Class objectMetaClass = object_getClass(objectClass1);
    Class objectMetaClass2 = object_getClass(object1);

    NSLog(@"instance-%p %p", object1, object2);
    NSLog(@"class-%p %p %p %p %p",
          objectClass1,
          objectClass2,
          objectClass3,
          objectClass4,
          objectClass5);
    NSLog(@"objectMetaClass-%p", objectMetaClass);
    
    
    
    
}


@end


