//
//  RechargeCollectionViewController.m
//  LifeHelper
//
//  Created by AEF-RD-1 on 16/3/18.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#import "RechargeCollectionViewController.h"
#import "RechargeCollectionViewCell.h"
#import "RechargeCollectionHeaderView.h"
#import "YIMKeyboardView.h"
#import "NSString+MD5.h"

#import <AddressBookUI/AddressBookUI.h>

// 系统版本大于 9.0 才能导入此框架
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
// This code will only compile on versions >= iOS 9.0
#import <ContactsUI/ContactsUI.h>

#endif


@interface RechargeCollectionViewController ()<CNContactPickerDelegate,
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
CNContactViewControllerDelegate,
#endif
ABPeoplePickerNavigationControllerDelegate,UINavigationControllerDelegate>

{
    /**
     *  充值金额
     */
    NSMutableArray *_rechargeAmountList;
    /**
     *  支付金额
     */
    NSMutableArray *_rechargePaymentList;
    
    NSString *_textFieldPhoneNumString;
    
    BOOL _showPayment;
    
    UITextField *_phoneNumberField;
    
    #if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
    // CNContact *_contact;
    #endif
}

@property (strong,nonatomic) YIMKeyboardView *keyboardView;


@end

@implementation RechargeCollectionViewController

static NSString * const reuseIdentifier = @"Cell";
static NSString * const reuseHeaderViewId = @"reuseHeaderViewId";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _rechargePaymentList = [[NSMutableArray alloc] init];
    _rechargeAmountList = [[NSMutableArray alloc] initWithObjects:@"1",@"2",@"5",@"10",@"20",@"30",@"50",@"100",@"200",@"300",@"500", nil];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    // Register cell classes
    [self.collectionView registerClass:[RechargeCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerClass:[RechargeCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseHeaderViewId];
    // Do any additional setup after loading the view.
    
    self.keyboardView = [[YIMKeyboardView alloc] initWithFrame:CGRectMake(0, DEVICE_HEIGHT - 270, DEVICE_WIDTH, 270)];
    self.keyboardView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.keyboardView.downButtonActionBlock = ^(UIButton *btn){
        
        NNLog(@"...........down btn click");
        
    };
//    [self.view addSubview:self.keyboardView];
    
}

- (void)dismissKeyboardView {
    [UIView animateWithDuration:.25 animations:^{
        //
        self.keyboardView.frame = CGRectMake(0, DEVICE_HEIGHT, DEVICE_WIDTH, 270);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return _rechargeAmountList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RechargeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    cell.layer.cornerRadius = 5.f;
    cell.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    cell.layer.borderWidth = 1.f;
    cell.layer.masksToBounds = YES;
    cell.rechargeAmountLabel.text = [NSString stringWithFormat:@"%@元",_rechargeAmountList[indexPath.row]];
    if (_showPayment) {
        NSDictionary *paymentInfo = _rechargePaymentList[indexPath.row];
        NSString *rechargePayment = [NSString stringWithFormat:@"售价:%.2f元",[paymentInfo[@"Data"][@"Inprice"] floatValue]];
        NSInteger code = -1;
        if ([[paymentInfo allKeys] containsObject:@"Code"]) {
            code = [paymentInfo[@"Code"] integerValue];
        }
        if (code != 0) {
            //不可以充值
            rechargePayment = @"备货中";
        }
        cell.rechargePaymentLabel.text = rechargePayment;
    }else {
        cell.rechargePaymentLabel.text = [NSString stringWithFormat:@"%@元",_rechargeAmountList[indexPath.row]];
    }
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((DEVICE_WIDTH - 30)/3, (DEVICE_WIDTH - 40)/4);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

// 添加头视图
// 1.实现方法 [collectionView:viewForSupplementaryElementOfKind:atIndexPath]
// 2.实现方法 [collectionView:layout:referenceSizeForHeaderInSection:]
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        //
        RechargeCollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader  withReuseIdentifier:reuseHeaderViewId forIndexPath:indexPath];
        
        _phoneNumberField = headerView.phoneNumField;
        
        headerView.checkContactClickBlock = ^(){
            NNLog(@"check contact ..............");
            [self createContactsUI];
//            [self getLocalContacts];
        };
//        __weak typeof(RechargeCollectionHeaderView)  *header;
        headerView.inputPhoneNumberFinishBlock = ^(NSString *text){
            _showPayment = NO;
            _textFieldPhoneNumString = [text purify];
            [self getWillPaymentWithPrice:nil getAll:YES phone:_textFieldPhoneNumString];
//            NNLog(@"................inputPhoneNumberFinishBlock-text:%@",text);
        };
        if (indexPath.section == 0) {
            reusableView = headerView;
        }
        
    }
    
    return reusableView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    return CGSizeMake(DEVICE_WIDTH, 70);
}

#pragma mark - <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    RechargeCollectionViewCell *cell = (RechargeCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    cell.layer.cornerRadius = 5.f;
    cell.layer.borderColor = [cell.rechargeAmountLabel textColor].CGColor;
    cell.layer.borderWidth = 1.f;
    cell.layer.masksToBounds = YES;
    
    [self getWillPaymentWithPrice:_rechargeAmountList[indexPath.row] getAll:NO phone:_textFieldPhoneNumString];
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
#pragma mark - 根据价格和手机号获取商品
/**
 *  根据价格和手机号获取商品
 *
 *  @param price 充值金额
 *  @param all   是否所有商品
 */
- (void)getWillPaymentWithPrice:(NSString *)price getAll:(BOOL)all phone:(NSString *)phone{
    
    NNLog(@"_textFieldPhoneNum.text.length:%lu",phone.length);
    
    if (phone.length == 0) {
        NNLog(@"................请输入手机号码");
        return;
    }else if (phone.length != 11 || ![GlobalTool isValidateMobile:phone]){
        NNLog(@"................请输入正确的手机号码");
        return;
    } else{
        NNLog(@"_textFieldPhoneNum.text:%@",phone);
    }

    if (all) {
        [_rechargePaymentList removeAllObjects];
        
        for (int i=0; i<_rechargeAmountList.count; i++) {
            
            [HttpRequestObj rechargeGetGoodsInfoWithPrice:_rechargeAmountList[i] phone:phone showSVP:NO result:^(NSDictionary *result, NSError *error) {
                
                if (!error) {
                    NSMutableDictionary *mutDic = [NSMutableDictionary dictionaryWithDictionary:result];
                    [mutDic setObject:[NSString stringWithFormat:@"%.2f",i * 0.1f] forKey:@"resultid"];

                    [_rechargePaymentList addObject:mutDic];
                    if (i==_rechargeAmountList.count -1) {
                        //NSLog(@"_rechargePaymentList:%@",_rechargePaymentList);
                        _showPayment = YES;
                        
                        _rechargePaymentList  = [self sortedWithMutArray:_rechargePaymentList key:@"resultid"];
                        NNLog(@"sorted _rechargePaymentList:%@",_rechargePaymentList);
                        dispatch_main(^{
                            [self.collectionView reloadData];
                            
                        });
                    }
                }
            }];
            
        }
        

    }else {
        
        [HttpRequestObj rechargeGetGoodsInfoWithPrice:price phone:phone showSVP:NO result:^(NSDictionary *result, NSError *error) {
            /**
             *   Code = 0;
             Data =     {
             Cardid = 151305;
             Cardname = "\U5e7f\U4e1c\U8054\U901a\U624b\U673a\U5feb\U5145300\U5143";
             GameArea = "\U5e7f\U4e1c\U6df1\U5733\U8054\U901a";
             Inprice = "298.74";
             };
             Msg = success;
             */
            if (!error) {
                NSLog(@"result:%@",result);
                
            }
        }];
        
    }
    
}

//- (UITextField *)phoneNumField {
//
//    if (_phoneNumField == nil) {
//        _phoneNumField = [[UITextField alloc] initWithFrame:CGRectMake(10, 5, DEVICE_WIDTH-20, 45)];
//        _phoneNumField.placeholder = @"请输入充值手机号";
//        _phoneNumField.font = [UIFont systemFontOfSize:20];
//    }
//    
//    return _phoneNumField;
//}

#pragma mark - 数组排序
//  1.普通数组
- (NSArray<NSString *> *)sortedWithArray:(NSArray<NSString *> *)arr {
    
    NSArray *sortedArray = [arr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        if ([obj1 intValue] > [obj2 intValue]){
            return NSOrderedDescending;
        }
        if ([obj1 intValue] < [obj2 intValue]){
            return NSOrderedAscending;
        }
        return NSOrderedSame;
    }];
    
    return sortedArray;
}

//  2.数组中是字典
/**
 *  数组排序，数组中是字典（key的值大于10 貌似取1？）
 *
 *  @param mutArr 数据源
 *  @param key    以哪个key的值排序
 *
 *  @return 排序后的数组
 */
- (NSMutableArray<NSDictionary<NSString *, id> *> *)sortedWithMutArray:(NSMutableArray<NSDictionary<NSString *, id> *> *)mutArr key:(NSString *)key{
    
    NSMutableArray *sortMutArr = [[NSMutableArray alloc] initWithArray:mutArr];
    
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:key ascending:YES]];
    
    [sortMutArr sortUsingDescriptors:sortDescriptors];

    return  sortMutArr;
}

#pragma mark - 选择本地(通讯录)联系人
- (void)getLocalContacts {
    // 导入框架
    // 判断权限
    // 展示联系人列表
    ABPeoplePickerNavigationController *peoplePicker = [[ABPeoplePickerNavigationController alloc] init];
    peoplePicker.delegate = self;
    [self presentViewController:peoplePicker animated:YES completion:nil];

}

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker {

    NNLog(@" did cancel ");
}

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person {
    NNLog(@" did select person:%@ ",person);
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person {
 
    NNLog(@"shouldContinueAfterSelectingPerson");
    return NO;
}


- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier{
    
    NNLog(@" did select person:%@ property:%d",person,property);
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier{
    NNLog(@"shouldContinueAfterSelectingPerson:identifier:");
    
    return YES;
}

- (BOOL) authorizStatus {
    
    ABAuthorizationStatus authStatus = ABAddressBookGetAuthorizationStatus();
    if (authStatus == kABAuthorizationStatusAuthorized) {
        // ios 6.0 +
        ABAddressBookRef *addressBook;
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            dispatch_semaphore_signal(sema);
            if (error) {
                NNLog(@"error:%@",error);
                return ;
            }
        });
        
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        
        return YES;
    }
    
    return NO;
}

#pragma mark -  -----------ios 9.0 + 可用-----------------------
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0

#pragma mark - contactsUI
- (void)createContactsUI{
    
//    // 获取授权状态
//    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
//    // 2.判断授权状态,如果不是已经授权,则直接返回
//    if (status != CNAuthorizationStatusAuthorized) {
//        NNLog(@"........未授权2");
//        return;
//    }
    
    
    // 获取联系人列表
    CNContactPickerViewController *pickView = [[CNContactPickerViewController alloc] init];
    pickView.delegate = self;
    [self presentViewController:pickView animated:YES completion:nil ];
    
}

#pragma mark - <CNContactPickerDelegate>
- (void)contactPickerDidCancel:(CNContactPickerViewController *)picker {
    
    NSLog(@"..........cancel ");
    // http://192.168.1.27/www/index.php
    
}

// 若实现此方法，选择一个联系人后会关闭页面，并执行回调
// 不实现此方法，选择后会自动进入下一级页面，并执行- [contactPicker:didSelectContactProperty:]方法，
//- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact {
//    
//    NNLog(@"did select contact :%@",contact);
//    
//    _contact = contact;
//    
//    
//    if (!_contact) {
//        return;
//    }
//    
//    // 查看联系人
//    CNContactViewController *contactView = [CNContactViewController viewControllerForContact:_contact];
//    contactView.delegate = self;
//    contactView.allowsActions = NO;
//    contactView.allowsEditing = NO;
//    contactView.shouldShowLinkedContacts = YES;  //显示共享联系人
//    [self.navigationController pushViewController:contactView animated:YES];
//    
//}

// 选中联系人的某一项属性是回调
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty{
    
    NNLog(@"did select contactProperty :%@",contactProperty);
    // 获取手机号码
    if ([contactProperty.value isKindOfClass:[CNPhoneNumber class]]) {
        CNPhoneNumber *number = contactProperty.value;
        NNLog(@"phone:%@",number.stringValue);
        
        _phoneNumberField.text = [number.stringValue purify];
        [self getWillPaymentWithPrice:nil getAll:YES phone:[number.stringValue purify]];
    }else {
        NNLog(@"..请选择联系人号码号码");
        [AlertView showMessage:@"请选择联系人号码" time:1];
    }
    
    
}

// 实现多选时(会出现多选样式)，单选的(只能单选)协议可以不实现(实现了也无返回)，

//- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContacts:(NSArray<CNContact *> *)contacts {
//    
//    //NSLog(@"did select contacts :%@",contacts);
//    /**
//     *  <CNContact: 0x12e5c2100: identifier=DD54C771-65B9-4872-8141-BABD292808C1,
//         givenName=\U963f\U59e8,
//         familyName=,
//         organizationName=,
//         phoneNumbers=("<CNLabeledValue: 0x12e5fb780: identifier=DACB686C-8609-4FCA-97A8-926452EDDEA1,
//                            label=_$!<Home>!$_,
//                            value=<CNPhoneNumber: 0x12e5fb930: countryCode=cn, digits=13249513138>>\"\n),
//         emailAddresses=(\n),
//         postalAddresses=(\n)>
//     *
//     */
//    
//    for (CNContact *contact in contacts) {
//        
//        NNLog(@"name: %@ phones:%@ \n",[self nameWithContact:contact],[self phonesWithContact:contact]);
//        
//    }
//    /**
//     *
//     */
//    
//}

- (NSString *)nameWithContact:(CNContact *)contact {
    
    NSString *fullName = [[NSString alloc] initWithFormat:@"%@%@%@%@%@%@%@",contact.namePrefix,contact.givenName,contact.middleName,contact.familyName,contact.previousFamilyName,contact.nameSuffix,contact.nickname];
    
    return fullName;
}

- (NSArray *)phonesWithContact:(CNContact *)contact {
    
    NSArray *phoneNumbers = contact.phoneNumbers;
    NSMutableArray *phoneArray = [NSMutableArray new];
    for (CNLabeledValue *value in phoneNumbers) {
        CNPhoneNumber *number = value.value;
//        NNLog(@"value:%@,label:%@ value.value:%@",value,value.label,number.stringValue);
        [phoneArray addObject:number.stringValue];
    }
    
    return (NSArray *)phoneArray;
}
//- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperties:(NSArray<CNContactProperty *> *)contactProperties {
//    
//    NNLog(@"did select contactPropertys :%@",contactProperties);
//    
//}



#pragma mark - CNContactViewControllerDelegate
- (BOOL)contactViewController:(CNContactViewController *)viewController shouldPerformDefaultActionForContactProperty:(CNContactProperty *)property {
    
    NNLog(@"shouldPerformDefaultActionForContactProperty");
    return YES;
}

- (void)contactViewController:(CNContactViewController *)viewController didCompleteWithContact:(CNContact *)contact {
    
    NNLog(@"didCompleteWithContact");
    
}

#endif


@end
