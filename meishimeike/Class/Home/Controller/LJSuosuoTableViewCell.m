//
//  LJSuosuoTableViewCell.m
//  meishimeike
//
//  Created by zhenglong duan on 27/03/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import "LJSuosuoTableViewCell.h"
#import "LJcommentTableViewCell.h"
@interface LJSuosuoTableViewCell ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIImageView *userimageView;
@property (nonatomic,strong) UILabel *userNameLabel;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UIView *bgView;

@property (nonatomic,strong) UITableView *commentTableView;
@property (nonatomic,strong) NSMutableArray *commetnArr;
@end
@implementation LJSuosuoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = LJCommonBgColor;
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
        bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:bgView];
        self.bgView = bgView;
        
        self.userimageView = [[UIImageView alloc] initWithFrame:CGRectMake(10 , 10, 40, 40)];
        [self.userimageView setLayerWithCr:20];
        self.userimageView.backgroundColor = LJRandomColor;
        [bgView addSubview:self.userimageView];
        
        self.userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.userimageView.lj_right + 10, 0, 80, 15)];
        self.userNameLabel.textColor = LJFontColor39;
        self.userNameLabel.font = LJFontSize15;
        self.userNameLabel.text = @"郭笑林";
        self.userNameLabel.lj_centerY = self.userimageView.lj_centerY;
        [bgView addSubview:self.userNameLabel];
        
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.userNameLabel.lj_x - 10, self.userimageView.lj_bottom + 5, 250, 0)];
        self.contentLabel.textColor = LJFontColor4c;
        self.contentLabel.font = LJFontSize14;
        self.contentLabel.text = @"私家菜是我们日常生活中得常用菜式,私家菜菜谱虽菜式多样,但私家菜的做法还是比较简单得,美食杰教您私家菜怎么做最简单";
        self.contentLabel.numberOfLines = 0;
        [bgView addSubview:self.contentLabel];
        
        self.commetnArr = [NSMutableArray array];
    }
    return self;
}

- (UITableView *)commentTableView {
    if (!_commentTableView) {
        _commentTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, 100, SCREEN_WIDTH, 0)];
        _commentTableView.dataSource = self;
        _commentTableView.delegate = self;
        [_commentTableView registerClass:[LJcommentTableViewCell class] forCellReuseIdentifier:@"LJcommentTableViewCell"];
    }
    return _commentTableView;
}

- (void)zanClick:(UIButton *)sender {
    if (sender.tag ==1000) {
        
    }else if (sender.tag == 1001) {
        if (self.backCellIndex) {
            self.backCellIndex(self.cell);
        }
    }
}

-(void)layoutSubviews {
    [super layoutSubviews];
    [self.bgView addSubview:self.commentTableView];
    self.commentTableView.lj_bottom = self.bgView.lj_bottom - 10;
    
}

- (void)setSuosuoModel:(LJSuoSuoModel *)suosuoModel {
    _suosuoModel = suosuoModel;
    NSString *url1 = [NSString stringWithFormat:@"%@%@",headerUrl,suosuoModel.user_headimage];
    [self.userimageView sd_setImageWithURL:[NSURL URLWithString:url1]];
    self.userNameLabel.text =suosuoModel.user_name;
    self.contentLabel.text = suosuoModel.suosuo_conent;
    [self.contentLabel sizeToFit];
    
    self.bgView.lj_height = suosuoModel.cellHight - 10;
    
    NSArray *strArr = [suosuoModel.suosuo_image componentsSeparatedByString:@"jpg"];
    for (int i=0; i<strArr.count; i++) {
        NSString *url = [NSString stringWithFormat:@"%@%@jpg",suosuoUrl,strArr[i]];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10 * (i+1) + i * 80, self.contentLabel.lj_bottom + 8, 80, 80)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:url]];
        [self.bgView addSubview:imageView];
    }
    CGFloat h = self.contentLabel.lj_bottom + 2;
    if (strArr.count >0) {
        h += 88;
    }
    UIButton *zan = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 55, h, 15, 15)];
    [zan setImage:[UIImage imageNamed:@"home_shoucang_icon"] forState:UIControlStateNormal];
    [zan addTarget:self action:@selector(zanClick:) forControlEvents:UIControlEventTouchUpInside];
    zan.tag = 1000;
    [self.contentView addSubview:zan];
    
    UIButton *comment = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 25, h, 15, 15)];
    [comment setImage:[UIImage imageNamed:@"home_shoucang_icon"] forState:UIControlStateNormal];
    [comment addTarget:self action:@selector(zanClick:) forControlEvents:UIControlEventTouchUpInside];
    comment.tag = 1001;
    [self.contentView addSubview:comment];
    
    if (suosuoModel.comment.count > 0) {
        self.commentTableView.lj_height = suosuoModel.comment.count * 15;
        for (int i = 0; i <suosuoModel.comment.count; i++) {
        LJCommentModel *comment = [LJCommentModel mj_objectWithKeyValues:suosuoModel.comment[i]];
        [self.commetnArr addObject:comment];
       }
        [self.commentTableView reloadData];
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.commetnArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    LJCommentModel *commentModel = self.commetnArr[indexPath.row];
    return commentModel.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LJcommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LJcommentTableViewCell"];
    cell.commentModel = self.commetnArr[indexPath.row];
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
