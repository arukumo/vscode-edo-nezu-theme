/**
 * 江戸伝統色テーマ - Objective-C 構文解析検証
 * 角括弧メッセージ構文（[obj method]）、NSStringリテラル（@""）、プロパティ宣言（@property）、プロトコル（@interface / @implementation）の確認用
 */

#import <Foundation/Foundation.h>

@interface EdoColorToken : NSObject

@property (nonatomic, assign) NSInteger colorId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *hexCode;

- (instancetype)initWithId:(NSInteger)cId name:(NSString *)name hex:(NSString *)hex;
- (void)logOpticalDetails;

@end

@implementation EdoColorToken

- (instancetype)initWithId:(NSInteger)cId name:(NSString *)name hex:(NSString *)hex {
    self = [super init];
    if (self) {
        _colorId = cId;
        _name = [name copy];
        _hexCode = [hex copy];
    }
    return self;
}

- (void)logOpticalDetails {
    NSLog(@"[EdoNezu] ID: %ld | Color: %@ | HEX: %@", (long)self.colorId, self.name, self.hexCode);
}

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        EdoColorToken *token1 = [[EdoColorToken alloc] initWithId:1 name:@"白鼠" hex:@"#dcdddd"];
        EdoColorToken *token2 = [[EdoColorToken alloc] initWithId:2 name:@"舛花色" hex:@"#567a98"];

        NSArray *tokens = @[token1, token2];
        for (EdoColorToken *token in tokens) {
            [token logOpticalDetails];
        }
    }
    return 0;
}
