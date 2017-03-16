//
//  SSJStaticTavleviewDataSource.m
//  SSJStaticTableViewDemo
//
//  Created by Sun Shijie on 2017/3/14.
//  Copyright © 2017年 Shijie. All rights reserved.
//

#import "SSJStaticTavleviewDataSource.h"
#import "SSJStaticTableviewCellViewModel.h"
#import "SSJStaticTableviewSectionViewModel.h"
#import "SJStaticTableViewCell.h"




@interface SSJStaticTavleviewDataSource()

@property (nonatomic, copy) SJStaticCellConfigureBlock cellConfigureBlock;

@end

@implementation SSJStaticTavleviewDataSource

- (instancetype)initWithViewModelsArray:(NSArray *)viewModelsArray configureBlock:(SJStaticCellConfigureBlock)block
{
    self = [super init];
    if (self) {
        self.viewModelsArray = viewModelsArray;
        self.cellConfigureBlock = [block copy];
    }
    return self;
}

#pragma mark - Tableview data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.viewModelsArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    SSJStaticTableviewSectionViewModel *vm = self.viewModelsArray[section];
    return vm.itemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SSJStaticTableviewSectionViewModel *sectionViewModel = self.viewModelsArray[indexPath.section];
    SSJStaticTableviewCellViewModel *cellViewModel = sectionViewModel.itemArray[indexPath.row];
            
    SJStaticTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellViewModel.cellID];
    if (!cell) {
        cell = [[SJStaticTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellViewModel.cellID];
    }
    self.cellConfigureBlock(cell,cellViewModel);
    
    return cell;

}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    SSJStaticTableviewSectionViewModel *vm = self.viewModelsArray[section];
    return vm.sectionHeaderTitle;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    SSJStaticTableviewSectionViewModel *vm = self.viewModelsArray[section];
    return vm.sectionFooterTitle;    
}


@end