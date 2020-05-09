//
//  HHXibViewController.m
//  VKDemoProject
//
//  Created by XXXXX on 2018/7/14.
//  Copyright © 2018年 Evan. All rights reserved.
//

#import "HHXibViewController.h"
#import "HHXibViewCell.h"
#import "HHBookModel.h"
@interface HHXibViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *books;
@end

@implementation HHXibViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    /*
     * *自定义Cell步骤 1. 新建XIB Cell 2.TableView注册Cell  3.TableView直接复用Cell
     */
    /*
     * Mock数据测试Cell在自动布局下面自适应特性
     * 如果需要UILabel自适应，需要注意下面几点:
     * tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
       返回一个类似的高度
     * tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
       返回自动计算 UITableViewAutomaticDimension;
     * cell中的元素，必须相对于cell的顶部和底部布局，这样在元素中的内容动态变化的时候，才能撑开cell
     * cell中的元素，必须相对于cell的顶部和底部布局，这样在元素中的内容动态变化的时候，才能撑开cell
     * cell中的元素，必须相对于cell的顶部和底部布局，这样在元素中的内容动态变化的时候，才能撑开cell
     * cell中的元素，必须相对于cell的顶部和底部布局，这样在元素中的内容动态变化的时候，才能撑开cell
     * cell中的元素，必须相对于cell的顶部和底部布局，这样在元素中的内容动态变化的时候，才能撑开cell

     * UILabel numberOfLine = 0
     */
    NSArray *bookContents = @[@"随着跨越2018演习第一场开打，被网友简称为“朱日和”的对抗演习正式拉开帷幕。拥有着32胜1负传奇战绩的蓝军，一直是被网友调侃的对象，各个红军单位也对其“咬牙切齿” 力求在今年的演习中战胜满广志带领的红军。",
                              @"而这次朱日和演习第一场，蓝军旅就迎来了这几年第一个能与其“肛正面”的对手。参加演习的某数字化机械旅是人民陆军新晋的“土豪旅”，比较巧合的是，该旅和满广志的蓝军旅都是由之前撤编的某坦克师改编而来，可以说是“亲兄弟”。当然“亲兄弟明算账”，此次朱日和演习两旅自然要分出一个高下。该旅之所以被称为“土豪”，不仅是因为是全军第三个装备99A式主战坦克的旅级单位，而且也是还率先采用了14车连的布置，比起原先的10车连，每旅的坦克数量由80辆提高到112辆，步兵战车的数量也相应增多，这也意味着该旅扮演着担负装甲兵战术试验的任务，希望借朱日和演习检验新的编制是否合理",
                              @"除了99A式主战坦克和04A式步兵战车外，该旅的防空营还装备了最新的07式自行高炮和HQ-17防空导弹这一顶配防空装备，其中07式自行高炮的价格不菲，据说一辆的价格相当于5辆99A坦克，而下发到旅级的HQ-17则是我国基于道尔M-1系统研发的新一代野战防空导弹系统",
                              @"该旅的武器配置可以说是国内陆军最顶级的配置了，不仅优于其他部队，比起美军的ABCT也毫不逊色，也有着和蓝军旅正面硬干的底气，从过去靠利用小分队化妆偷袭“活捉满广志”转变为在“决战”中击败满广志。此次演习前，该旅士气高昂，专门组织了动员仪式和誓师大会，力求成为第二支击败蓝军旅的部队。",
                              @"当然蓝军旅也没有“坐以待毙”，不仅能在演习开始阶段利用“空袭”，“核生化打击”等先手削弱参演部队，今年还首次加入了J-20战机配合蓝军旅作战。蓝军旅不仅在空中打击能力上得到进一步提高，而且还能依靠自身先进传感器，作为重要的网络信息节点使用，强化蓝军的信息化作战能力。鉴于以F-35为代表的五代机在亚太地区呈现扩散化的趋势五代机的参演，也能提升参演红军部队对抗高性能隐身战机的经验。",
                              @"今年的朱日和演习除了传统的对抗项目外，蓝军旅还有可能放弃主场优势，主动走出去。此前蓝军旅的炮兵和防空兵部队首次离开朱日和训练场，前往外地参加演习。",
                              @"而在未来，蓝军旅也很有可能成建制走出去，在不同地理和气象环境下对抗红军，提高红军部队的全地形适应能力。而随着朱日和演习加入的新色彩，这场演习不仅会更精彩，对于提高军队战斗力的帮助也会越来越大"];
    
    _books = [NSMutableArray arrayWithCapacity:5];
    for (int i = 0; i < 5; i++) {
        HHBookModel *model = [[HHBookModel alloc] init];
        model.content = bookContents[i];
        model.avatorName = @"avator";
        [_books addObject:model];
    }
    
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HHXibViewCell" bundle:nil] forCellReuseIdentifier:@"HHXibViewCell"];
}



- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    HHBookModel *model = _books[indexPath.row];
    HHXibViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"HHXibViewCell"];
    [cell configCellWithModel:model];
    return cell;
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}


@end
