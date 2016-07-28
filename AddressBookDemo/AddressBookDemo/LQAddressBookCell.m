//
//  LQAddressBookCell.m
//  AddressBookDemo
//
//  Created by lizq on 16/7/26.
//  Copyright © 2016年 zqLee. All rights reserved.
//

#import "LQAddressBookCell.h"

@interface LQAddressBookCell ()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation LQAddressBookCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    [self.contentView addSubview:self.iconView];
    [self.contentView addSubview:self.nameLabel];
    return self;
}

#pragma mark getter or setter

- (void)setIconImage:(UIImage *)iconImage {
    self.iconView.image = iconImage;
}

- (void)setName:(NSString *)name {
    self.nameLabel.text = name;
}

- (UIImageView *)iconView {
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 5, 30, 30)];
    }
    return _iconView;
}

- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, SCREEN_WIDTH, self.height)];
        _nameLabel.font = [UIFont systemFontOfSize:14];
    }
    return _nameLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
