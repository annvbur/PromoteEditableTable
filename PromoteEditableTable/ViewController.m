//
//  ViewController.m
//  PromoteEditableTable
//
//  Created by Mac on 09.05.15.
//  Copyright (c) 2015 Mac. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Utils.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textEdit;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property NSMutableArray *data;

@end

@implementation ViewController

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        self.data = [NSMutableArray array];  // инициализация массива

    }

    return self;
}

- (void)viewDidLoad {

    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"identifier"];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;  //self,пока мы это не напишем, равен нулю
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier" forIndexPath:indexPath]; //метод смотрит есть ли у нас что - вызовет инициализатор для ячейки по идентификатору и смотрит что там есть, чтоб работало нужно добавть реджистер класс
    cell.textLabel.text = self.data[(NSUInteger) indexPath.row];
    if (indexPath.row<3){
        cell.backgroundColor = [UIColor purpleColor];
    } else{
        cell.backgroundColor = [UIColor whiteColor];
    }
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    //возможность редактировать ячейки
    if (indexPath.row<3) {
        return NO;
    }else{
        return YES;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if(editingStyle ==UITableViewCellEditingStyleDelete){   //что делать если мы удаляем
        [self.data removeObjectAtIndex:(NSUInteger) indexPath.row];  //удалять строку - которая юзеру не нравится  после 3 индекса

        [tableView beginUpdates];//всегда в паре с endUpdates - что делать когда идет update

        self.editButton.enabled = self.data.count>0; //делаем edit активной если хоть одна ячейка заполнена

        //если ни одна ячейка не заполнена - редактирование таблицы запрещенои кнока edit disabled
        if (self.data.count==0){
            self.editButton.selected = NO;
            self.tableView.editing = NO;
        }

        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];



        [tableView endUpdates];
    }
}

- (IBAction)onAddRowTap:(id)sender {
    NSUInteger currentIndex = self.data.count;  //индекс каждой ячейки
    // NSString *str= [NSString stringWithFormat:@"Data for row %d", currentIndex];  //создали строку

    NSString *str = self.textEdit.text;  //создаем str который равен тому, что ввели в поле


    self.textEdit.text = nil; //опустошаем поле после добавления
    self.addButton.enabled = NO; //+ изначально неактивен

    [self.data addObject:str];//добавили строку в массив


    self.editButton.enabled = self.data.count>0; //edit будет активен


    //[self.tableView reloadData];//метод каждый раз перегружает все данные при каждом нажатии- а нам надо перегружать одну - поэтому посмотрим еще методы

    [self.tableView beginUpdates]; //всегда в паре

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:currentIndex inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
}
- (IBAction)textChanged:(id)sender {
    [self validateInput:sender];


    //if(self.textEdit.text.length>0) {
        //self.addButton.enabled = YES;  //тоже самое что self.addButton
    //} else{
        //self.addButton.enabled = NO;
    //}
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];//спрятать клавиатуру
    return NO;
}

- (IBAction)onEditTapped:(id)sender {
    self.editButton.selected = !self.editButton.selected; //инверсия - когда она выбрана - сразу меняется состояние
    self.tableView.editing=!self.tableView.editing;
}

- (void)validateInput:(UITextField *)sender {


    BOOL isEmailValid = [self.textEdit.text validateEmail];

    self.textEdit.textColor = isEmailValid ? [UIColor blackColor] : [UIColor redColor];


    self.addButton.enabled = isEmailValid;

}

@end
