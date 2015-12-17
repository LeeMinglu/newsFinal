//
//  MLSocietyCell.m
//  高仿网易新闻案例
//
//  Created by apple on 15/11/17.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "MLSocietyCell.h"
#import "MLSociety.h"
#import "UIImageView+WebCache.h"

@interface MLSocietyCell ()
// storyboard中的子控件
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *replyCountLabel;

@end

@implementation MLSocietyCell

- (void)setSociety:(MLSociety *)society
{
    _society = society;
    
    if (society.hasHead) {
        self.titleLabel.text = society.title;
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:society.imgsrc] placeholderImage:[UIImage imageNamed:@"loading"]];
        return;
    }
    
    // 为子控件设置数据
    self.titleLabel.text = society.title;
    self.descLabel.text = society.digest;
    self.replyCountLabel.text = [NSString stringWithFormat:@"%d跟帖",society.replyCount];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:society.imgsrc] placeholderImage:[UIImage imageNamed:@"loading"]];
}


+ (NSString *)societyCellWithIdentifier:(MLSociety *)society
{
    if (society.hasHead) {
        return @"BigImage_cell";
    } else {
        return @"Society_cell";
    }
}






- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
