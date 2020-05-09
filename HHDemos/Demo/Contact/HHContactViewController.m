//
//  TTContactViewController.m
//  TTProject
//
//  Created by XXXXX on 2017/10/19.
//  Copyright © 2017年 Evan. All rights reserved.
//

#import "HHContactViewController.h"
#import <AddressBook/AddressBook.h>
#import <Contacts/Contacts.h>

@interface HHContactViewController ()
@property (nonatomic, assign) ABAddressBookRef addressBookRef; //通讯录
@property (nonatomic, strong) NSArray *contacts;  //联系人
@property (nonatomic, strong) CNContactStore *contact;
@end

@implementation HHContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getContactsFromAddressBook];
}

//iOS9.0 及以上
- (void)getContactsFromAddressBook {
    
    // 1.获取授权状态
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    
    // 2.判断授权状态,如果不是已经授权,则直接返回
    //    if (status != CNAuthorizationStatusAuthorized) return;
    
    // 3.创建通信录对象
    CNContactStore *contactStore = [[CNContactStore alloc] init];
    
    // 4.创建获取通信录的请求对象
    // 4.1.拿到所有打算获取的属性对应的key
    NSArray *keys = @[CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey];
    
    // 4.2.创建CNContactFetchRequest对象
    CNContactFetchRequest *request = [[CNContactFetchRequest alloc] initWithKeysToFetch:keys];
    
    // 5.遍历所有的联系人
    [contactStore enumerateContactsWithFetchRequest:request error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
        // 1.获取联系人的姓名
        NSString *lastname = contact.familyName;
        NSString *firstname = contact.givenName;
        NSLog(@"%@ %@", lastname, firstname);
        
        // 2.获取联系人的电话号码
        NSArray *phoneNums = contact.phoneNumbers;
        for (CNLabeledValue *labeledValue in phoneNums) {
            // 2.1.获取电话号码的KEY
            //            NSString *phoneLabel = labeledValue.label;
            
            // 2.2.获取电话号码
            CNPhoneNumber *phoneNumer = labeledValue.value;
            NSString *phoneValue = phoneNumer.stringValue;
            NSString *phone = [phoneValue stringByReplacingOccurrencesOfString:@"-" withString:@""];
            NSLog(@"%@", phone);
        }
    }];
    
}

- (void)getContact {
    
    // 1.获取授权状态
    ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
    
    // 2.如果是已经授权,才能获取联系人
    if (status != kABAuthorizationStatusAuthorized) return;
    
    // 3.创建通信录对象
    ABAddressBookRef addressBook = ABAddressBookCreate();
    
    // 4.获取所有的联系人
    CFArrayRef peopleArray = ABAddressBookCopyArrayOfAllPeople(addressBook);
    CFIndex peopleCount = CFArrayGetCount(peopleArray);
    
    // 5.遍历所有的联系人
    for (int i = 0; i < peopleCount; i++) {
        // 5.1.获取某一个联系人
        ABRecordRef person = CFArrayGetValueAtIndex(peopleArray, i);
        // 5.2.获取联系人的姓名
        NSString *lastName = (__bridge_transfer NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
        NSString *firstName = (__bridge_transfer NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
        NSLog(@"%@ %@", lastName, firstName);
        
        // 5.3.获取电话号码
        // 5.3.1.获取所有的电话号码
        ABMultiValueRef phones = ABRecordCopyValue(person, kABPersonPhoneProperty);
        CFIndex phoneCount = ABMultiValueGetCount(phones);
        
        // 5.3.2.遍历拿到每一个电话号码
        for (int i = 0; i < phoneCount; i++) {
            // 1.获取电话对应的key
            NSString *phoneLabel = (__bridge_transfer NSString *)ABMultiValueCopyLabelAtIndex(phones, i);
            
            // 2.获取电话号码
            NSString *phoneValue = (__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(phones, i);
            
            NSLog(@"%@ %@", phoneLabel, phoneValue);
        }
        
        CFRelease(phones);
    }
    
    CFRelease(addressBook);
    CFRelease(peopleArray);
    
}


@end
