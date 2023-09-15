//
//  ViewController.m
//  Hw_objective_hw_6_final
//
//  Created by Alina on 11.09.2023.
//

#import "ViewController.h"
#import "Robot.h"

@interface ViewController ()
@property (weak, nonatomic) UITextField *textView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //чтение из userDefault
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDate *savedRobotData = [defaults objectForKey:@"robot"];
    Robot *savedRobot = [NSKeyedUnarchiver unarchiveObjectWithData:savedRobotData];
    
    //отображение инфы
    self.textView.text = [NSString stringWithFormat:@"Name: %@, Coordinates: (%ld, %ld)", savedRobot.name, (long)savedRobot.x, (long)savedRobot.y];
    
    //отображение инфы в консоли
    NSLog(@"Name: %@, Coordinates: (%ld, %ld)", savedRobot.name, (long)savedRobot.x, (long)savedRobot.y);
    
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // Создание и настройка объекта робота
        Robot *robot = [[Robot alloc] init];
        robot.x = 10;
        robot.y = 20;
        robot.name = @"Robot1";
        
        // Сохранение объекта робота в UserDefaults
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSData *robotData = [NSKeyedArchiver archivedDataWithRootObject:robot];
        [defaults setObject:robotData forKey:@"robot"];
        [defaults synchronize];
        
        // Чтение объекта робота из UserDefaults
        NSData *savedRobotData = [defaults objectForKey:@"robot"];
        Robot *savedRobot = [NSKeyedUnarchiver unarchiveObjectWithData:savedRobotData];
        
        // Отображение информации о роботе в консоли
        NSLog(@"Name: %@, Coordinates: (%ld, %ld)", savedRobot.name, (long)savedRobot.x, (long)savedRobot.y);
        
        // Сохранение информации о роботе в файл
        NSString *fileName = [NSString stringWithFormat:@"%@.txt", savedRobot.name];
        NSString *filePath = [NSString stringWithFormat:@"/Hw_objective_hw_6_final/%@", fileName];
        NSString *robotInfo = [NSString stringWithFormat:@"Name: %@, Coordinates: (%ld, %ld)", savedRobot.name, (long)savedRobot.x, (long)savedRobot.y];
        [robotInfo writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        
        // Чтение содержимого файла
        NSString *fileContent = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        
        // Отображение содержимого файла в консоли
        NSLog(@"%@", fileContent);
    }
    return 0;
}


@end
