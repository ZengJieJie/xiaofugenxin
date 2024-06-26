//
//  RumViewController.m
//  HomeRummygames
//
//  Created by adin on 2024/6/13.
//

#import "RumViewController.h"
#import "CardButton.h"
#import "Card.h"
#import "Deck.h"
@interface RumViewController ()


@property (nonatomic, strong) NSMutableArray *players;
@property (weak, nonatomic) IBOutlet UIView *topview;
@property (weak, nonatomic) IBOutlet UIView *leftview;
@property (weak, nonatomic) IBOutlet UIView *rhitview;

@property (weak, nonatomic) IBOutlet UIView *theview;

@property (weak, nonatomic) IBOutlet UILabel *leftlab;


@property (weak, nonatomic) IBOutlet UILabel *toplab;


@property (weak, nonatomic) IBOutlet UILabel *thelab;


@property (weak, nonatomic) IBOutlet UILabel *rhghtlab;


@property (weak, nonatomic) IBOutlet UIView *yourview;

@property (weak, nonatomic) IBOutlet UIImageView *topimage;
@property (weak, nonatomic) IBOutlet UIImageView *leftimage;

@property (weak, nonatomic) IBOutlet UIImageView *rightimage;
@property (weak, nonatomic) IBOutlet UIImageView *theimage;

@property (nonatomic, strong) NSMutableArray<CardButton *> *handCards;

@property (nonatomic, strong) NSMutableArray *topparry;

@property (nonatomic, strong) NSMutableArray *leftparry;


@property (nonatomic, strong) NSMutableArray *rightparry;


@property (nonatomic, strong) NSMutableArray *thehtparry;

@property (nonatomic,assign) NSInteger Windint;//谁的牌最大

@property (nonatomic,assign) NSInteger statints;//是否 我先出牌

@property (nonatomic,strong) NSString * huase;//当前花色

@property (nonatomic, strong) NSMutableArray *yourarray; //保存不是我出牌的 牌数组
@end

@implementation RumViewController


-(void)updategame{
    //    @property (nonatomic, strong) NSMutableArray<CardButton *> *handCards;
    //
    //    @property (nonatomic, strong) NSMutableArray *topparry;
    //
    //    @property (nonatomic, strong) NSMutableArray *leftparry;
    //
    //
    //    @property (nonatomic, strong) NSMutableArray *rightparry;
    //
    //
    //    @property (nonatomic, strong) NSMutableArray *thehtparry;
    //
    //    @property (nonatomic,assign) NSInteger Windint;//谁的牌最大
    //
    //    @property (nonatomic,assign) NSInteger statints;//是否 我先出牌
    //
    //    @property (nonatomic,strong) NSString * huase;//当前花色
    //
    //    @property (nonatomic, strong) NSMutableArray *yourarray; //保存不是我出牌的 牌数组
    //
    
    [self.handCards removeAllObjects];
    [self.topparry removeAllObjects];
    [self.leftparry removeAllObjects];
    [self.rightparry removeAllObjects];
    [self.thehtparry removeAllObjects];
    
    self.Windint=1;
    self.statints=1;
    self.huase=@"";
    [self.yourarray removeAllObjects];
    [self.leftimage setImage:[UIImage imageNamed:@""]];
    [self.rightimage setImage:[UIImage imageNamed:@""]];
    [self.theimage setImage:[UIImage imageNamed:@""]];
    [self.topimage setImage:[UIImage imageNamed:@""]];
    [self dealCards];
    // 初始化手牌
    [self updateHandCardsDisplay];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.handCards = [NSMutableArray array];
    self.statints=1;
    self.yourarray=[[NSMutableArray alloc]init];
    // 设置背景颜色和透明度
    self.topview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
    // 设置圆角
    self.topview.layer.cornerRadius =  self.topview.frame.size.width / 2;
    self.topview.layer.masksToBounds = YES;
    
    
    // 设置背景颜色和透明度
    self.leftview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
    // 设置圆角
    self.leftview.layer.cornerRadius =  self.leftview.frame.size.width / 2;
    self.leftview.layer.masksToBounds = YES;
    
    // 设置背景颜色和透明度
    self.rhitview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
    // 设置圆角
    self.rhitview.layer.cornerRadius =  self.rhitview.frame.size.width / 2;
    self.rhitview.layer.masksToBounds = YES;
    
    
    
    
    
    // 设置背景颜色和透明度
    self.theview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
    // 设置圆角
    self.theview.layer.cornerRadius =  self.theview.frame.size.width / 2;
    self.theview.layer.masksToBounds = YES;
    
    
    
    
    [self dealCards];
    // 初始化手牌
    [self updateHandCardsDisplay];
    // 显示手牌
  
    
    
    
    // Do any additional setup after loading the view from its nib.
}


//
-(void)jieshuyouxi{
   
    // 创建UIAlertController对象，设置标题和消息
       UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Tips"
                                                                                message:@"I'm sorry you lost"
                                                                         preferredStyle:UIAlertControllerStyleAlert];

       // 创建确定按钮的UIAlertAction
       UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"OK"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * _Nonnull action) {
           [self dismissViewControllerAnimated:YES completion:nil];
                                                             }];

       // 将确定按钮添加到UIAlertController
       [alertController addAction:confirmAction];

       // 显示UIAlertController
       // self是一个UIViewController的实例
       [self presentViewController:alertController animated:YES completion:nil];
}

-(void)jieshuyouxiwind{
    // 创建UIAlertController对象，设置标题和消息
       UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Tips"
                                                                                message:@"Congratulations on winning the game"
                                                                         preferredStyle:UIAlertControllerStyleAlert];

       // 创建确定按钮的UIAlertAction
       UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"OK"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * _Nonnull action) {
           [self dismissViewControllerAnimated:YES completion:nil];
                                                             }];

       // 将确定按钮添加到UIAlertController
       [alertController addAction:confirmAction];

       // 显示UIAlertController
       // self是一个UIViewController的实例
       [self presentViewController:alertController animated:YES completion:nil];
}

- (void)dealCards {
    Deck *deck = [[Deck alloc] init];
    [deck shuffle];
    
    // Initialize players
    self.players = [NSMutableArray array];
    for (int i = 0; i < 4; i++) {
        NSMutableArray *suitsArray = [NSMutableArray array];
        for (int j = 0; j < 4; j++) {
            [suitsArray addObject:[NSMutableArray array]];
        }
        [self.players addObject:suitsArray];
    }
    
    // Deal cards to each player
    for (int i = 0; i < 13; i++) {
        for (int j = 0; j < 4; j++) {
            Card *card = [deck drawCard];
            NSUInteger suitIndex = [[Card suits] indexOfObject:card.suit];
            NSMutableArray *playerSuitArray = self.players[j][suitIndex];
            [playerSuitArray addObject:card];
        }
    }
    
    
    
    
    
    
    NSMutableArray *cardsArray = self.players[0];
    self.thehtparry=[[NSMutableArray alloc]init];
    for (int i = 0; i < cardsArray.count; i++) {
        NSMutableArray *cardsArray1 = self.players[0][i];
        for (int j = 0; j < cardsArray1.count; j++) {
            Card * bar=self.players[0][i][j];
            [self.thehtparry addObject:bar];
        }
    }
    
    
    
    NSMutableArray *cardsArray2 = self.players[1];
    self.topparry=[[NSMutableArray alloc]init];
    for (int i = 0; i < cardsArray2.count; i++) {
        
        NSMutableArray *cardsArray3 = self.players[1][i];
        for (int j = 0; j < cardsArray3.count; j++) {
            Card * bar=self.players[1][i][j];
            [self.topparry addObject:bar];
        }
        
    }
    
    self.leftparry=[[NSMutableArray alloc]init];
    NSMutableArray *cardsArray4 = self.players[2];
    
    for (int i = 0; i < cardsArray4.count; i++) {
        
        NSMutableArray *cardsArray5 = self.players[2][i];
        for (int j = 0; j < cardsArray5.count; j++) {
            Card * bar=self.players[2][i][j];
            [self.leftparry addObject:bar];
        }
        
    }
    self.rightparry=[[NSMutableArray alloc]init];
    NSMutableArray *cardsArray6 = self.players[3];
    for (int i = 0; i < cardsArray6.count; i++) {
        NSMutableArray *cardsArray7 = self.players[3][i];
        for (int j = 0; j < cardsArray7.count; j++) {
            Card * bar=self.players[3][i][j];
            [self.rightparry addObject:bar];
        }
    }
}



//创建but

- (void)updateHandCardsDisplay {
   
    for (UIView *subview in [self.yourview subviews]) {
        if ([subview isKindOfClass:[UIButton class]]) {
            [subview removeFromSuperview];
        }
    }
    [self.handCards removeAllObjects];
    
    CGFloat cardWidth = 50.0;
    CGFloat cardHeight = 70.0;
    
    
    CGFloat overlap = (self.yourview.bounds.size.width-(self.thehtparry.count*30)+20)/2;
    
    
    for (int j = 0; j < self.thehtparry.count; j++) {
        Card * bar=self.thehtparry[j];
        CardButton *card = [[CardButton alloc] initWithSuit:bar.suit rank:bar.rank];
        card.tag=j;
        card.frame = CGRectMake((j * 30)+overlap, 0, cardWidth, cardHeight);
        [card addTarget:self action:@selector(cardTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self.handCards addObject:card];
        [self.yourview addSubview:card];
    }
  
    self.thelab.text=[NSString stringWithFormat:@"%lu",(unsigned long)self.handCards.count];
}

//点击事件
- (void)cardTapped:(CardButton *)sender {
    //自己出牌
    if  (self.statints==1){
        
        if (self.thehtparry.count==0||self.thehtparry.count==1) {
            [self jieshuyouxiwind];
        }else if(self.rightparry.count==0||self.leftparry.count==0||self.topparry.count==0){
            [self jieshuyouxi];
            
        }
      
      
        [self yourchupai:self.thehtparry[sender.tag] buttag:sender.tag];
        [self updateHandCardsDisplay];
        for (int i=0; i<self.handCards.count; i++) {
            CardButton *card = self.handCards[i];
            card.userInteractionEnabled=NO;
        }
        
        
        //对方出牌
    }else if  (self.statints>=2){
        Card * yourdsa=self.thehtparry[sender.tag];
        Card * yourdsa2=self.yourarray[0];
        if  ([yourdsa.suit isEqual:yourdsa2.suit]){
            if (self.thehtparry.count==0||self.thehtparry.count==1) {
                [self jieshuyouxiwind];
            }else if(self.rightparry.count==0||self.leftparry.count==0||self.topparry.count==0){
                [self jieshuyouxi];
                
            }
         
            [self yourpxarray:self.thehtparry[sender.tag] buttag:sender.tag];
            [self updateHandCardsDisplay];
            for (int i=0; i<self.handCards.count; i++) {
                CardButton *card = self.handCards[i];
                card.userInteractionEnabled=NO;
            }
         
        }
    }
}

//不是自己出牌 计算谁先出牌
-(void)yourpxarray:(Card *)yourcard buttag:(NSInteger)buttag{
    //left先出牌
    if (self.yourarray.count==1){
        Card * value=self.yourarray[0];
        if ([yourcard.suit isEqual:value.suit]){
            if ([yourcard.rank intValue]>[value.rank intValue]) {
                self.Windint=1;
            }
        }
        if([yourcard.rank isEqual:@"11"]){
            [self.theimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"J-%@",yourcard.suit]]];
        }else if([yourcard.rank isEqual:@"12"]){
            [self.theimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"Q-%@",yourcard.suit]]];
            
        }else if([yourcard.rank isEqual:@"13"]){
            [self.theimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"K-%@",yourcard.suit]]];
        }else if([yourcard.rank isEqual:@"14"]){
            [self.theimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"A-%@",yourcard.suit]]];
            
        }else{
            [self.theimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@-%@",yourcard.rank,yourcard.suit]]];
        }
        [self.thehtparry removeObjectAtIndex:buttag];
        self.thelab.text=[NSString stringWithFormat:@"%lu",(unsigned long)self.thehtparry.count];
        [self.yourarray addObject:yourcard];
        [self performSelector:@selector(diaoyongfangf) withObject:nil afterDelay:1.0];
    //top 先出牌
    } else  if (self.yourarray.count==2){
        Card * value0=self.yourarray[0];
        Card * value1=self.yourarray[1];
       
        if ([yourcard.suit isEqual:value0.suit]){
            if ([yourcard.rank intValue]>[value0.rank intValue]&&[yourcard.rank intValue]>[value1.rank intValue]) {
                self.Windint=1;
            }
        }
        if([yourcard.rank isEqual:@"11"]){
            
            [self.theimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"J-%@",yourcard.suit]]];
        }else if([yourcard.rank isEqual:@"12"]){
            [self.theimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"Q-%@",yourcard.suit]]];
            
        }else if([yourcard.rank isEqual:@"13"]){
            [self.theimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"K-%@",yourcard.suit]]];
        }else if([yourcard.rank isEqual:@"14"]){
            [self.theimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"A-%@",yourcard.suit]]];
            
        }else{
            [self.theimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@-%@",yourcard.rank,yourcard.suit]]];
        }
        [self.thehtparry removeObjectAtIndex:buttag];
        
        
     
        
        self.thelab.text=[NSString stringWithFormat:@"%lu",(unsigned long)self.thehtparry.count];
        
        
        [self.yourarray addObject:yourcard];
        [self performSelector:@selector(diaoyongtop) withObject:nil afterDelay:1.0];
        
       
      //自己出牌
    }else  if (self.yourarray.count==3){
        Card * value1=self.yourarray[1];
         Card * value2=self.yourarray[2];
        Card * value0=self.yourarray[0];
        if ([yourcard.rank intValue]>[value0.rank intValue]&&[yourcard.rank intValue]>[value1.rank intValue]&&[yourcard.rank intValue]>[value2.rank intValue]) {
            self.Windint=1;
        }
        if([yourcard.rank isEqual:@"11"]){
            [self.theimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"J-%@",yourcard.suit]]];
        }else if([yourcard.rank isEqual:@"12"]){
            [self.theimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"Q-%@",yourcard.suit]]];
        }else if([yourcard.rank isEqual:@"13"]){
            [self.theimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"K-%@",yourcard.suit]]];
        }else if([yourcard.rank isEqual:@"14"]){
            [self.theimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"A-%@",yourcard.suit]]];
        }else{
            [self.theimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@-%@",yourcard.rank,yourcard.suit]]];
        }
        
        [self.thehtparry removeObjectAtIndex:buttag];
        self.thelab.text=[NSString stringWithFormat:@"%lu",(unsigned long)self.thehtparry.count];
        
        [self performSelector:@selector(gamedelayedMethod:) withObject:[NSString stringWithFormat:@"%ld",(long)self.Windint] afterDelay:1.0];
        
        }
}



//top先出牌 的right出牌
-(void)diaoyongtop{
    Card * value1=self.yourarray[1];
     Card * value0=self.yourarray[0];
    Card * value2=self.yourarray[2];
    NSInteger stat=-1;
    Card *cardstat=nil;
    for (int i=0; i<self.rightparry.count; i++) {
        Card * butarc=self.rightparry[i];
        if ([butarc.suit isEqual:value1.suit]){
           
            cardstat=butarc;
            stat=i;
            break;
        }
    }
    if(stat>-1){
        if ([cardstat.rank intValue]>[value0.rank intValue]&&[cardstat.rank intValue]>[value1.rank intValue]&&[cardstat.rank intValue]>[value2.rank intValue]) {
            self.Windint=2;
        }
        if([cardstat.rank isEqual:@"11"]){
            
            [self.rightimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"J-%@",cardstat.suit]]];
        }else if([cardstat.rank isEqual:@"12"]){
            [self.rightimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"Q-%@",cardstat.suit]]];
            
        }else if([cardstat.rank isEqual:@"13"]){
            [self.rightimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"K-%@",cardstat.suit]]];
        }else if([cardstat.rank isEqual:@"14"]){
            [self.rightimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"A-%@",cardstat.suit]]];
            
        }else{
            [self.rightimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@-%@",cardstat.rank,cardstat.suit]]];
        }
        
        [self.rightparry removeObjectAtIndex:stat];
        
        self.rhghtlab.text=[NSString stringWithFormat:@"%lu",(unsigned long)self.rightparry.count];
      
        if (self.thehtparry.count==0) {
            [self jieshuyouxiwind];
        }else if(self.rightparry.count==0||self.leftparry.count==0||self.topparry.count==0){
            [self jieshuyouxi];
            
        }
        [self performSelector:@selector(gamedelayedMethod:) withObject:[NSString stringWithFormat:@"%ld",(long)self.Windint] afterDelay:1.0];
        
    }else{
        
        [self.rightparry addObject:self.yourarray[0]];
        [self.rightparry addObject:self.yourarray[1]];
        [self.rightparry addObject:self.yourarray[2]];
        self.rhghtlab.text=[NSString stringWithFormat:@"%lu",(unsigned long)self.rightparry.count];
        [self performSelector:@selector(gamedelayedMethod:) withObject:@"2" afterDelay:1.0];
    }
}



//left 先出牌的 tight边出牌
-(void)diaoyongfangf{
    
    Card * value1=self.yourarray[1];
    Card * value0=self.yourarray[0];
    NSInteger stat=-1;
    Card *cardstat=nil;
    for (int i=0; i<self.rightparry.count; i++) {
        Card * butarc=self.rightparry[i];
        if ([butarc.suit isEqual:value1.suit]){
          
            cardstat=butarc;
            stat=i;
            break;
        }
    }
    
    if(stat>-1){
        if ([cardstat.rank intValue]>[value0.rank intValue]&&[cardstat.rank intValue]>[value1.rank intValue]) {
            self.Windint=2;
        }
        if([cardstat.rank isEqual:@"11"]){
            
            [self.rightimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"J-%@",cardstat.suit]]];
        }else if([cardstat.rank isEqual:@"12"]){
            [self.rightimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"Q-%@",cardstat.suit]]];
            
        }else if([cardstat.rank isEqual:@"13"]){
            [self.rightimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"K-%@",cardstat.suit]]];
        }else if([cardstat.rank isEqual:@"14"]){
            [self.rightimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"A-%@",cardstat.suit]]];
            
        }else{
            [self.rightimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@-%@",cardstat.rank,cardstat.suit]]];
        }
        
        [self.rightparry removeObjectAtIndex:stat];
        
        self.rhghtlab.text=[NSString stringWithFormat:@"%lu",(unsigned long)self.rightparry.count];
        
        
        [self.yourarray addObject:cardstat];
        // 调用延迟方法并传递值
        
        if (self.thehtparry.count==0) {
            [self jieshuyouxiwind];
        }else if(self.rightparry.count==0||self.leftparry.count==0||self.topparry.count==0){
            [self jieshuyouxi];
            
        }
        [self performSelector:@selector(rightpaixfangf) withObject:nil afterDelay:1.0];
        
    }else{
        
        [self.rightparry addObject:self.yourarray[0]];
        [self.rightparry addObject:self.yourarray[1]];
        self.rhghtlab.text=[NSString stringWithFormat:@"%lu",(unsigned long)self.rightparry.count];
        [self performSelector:@selector(gamedelayedMethod:) withObject:@"2" afterDelay:1.0];
    }
    
}

//left 先出牌的 top边出牌

-(void)rightpaixfangf{
    Card * value1=self.yourarray[1];
    Card * value2=self.yourarray[2];
    Card * value0=self.yourarray[0];
    NSInteger stat=-1;
    Card *cardstat=nil;
    for (int i=0; i<self.topparry.count; i++) {
        Card * butarc=self.topparry[i];
        if ([butarc.suit isEqual:value0.suit]){
          
            cardstat=butarc;
            stat=i;
            break;
        }
    }
    if(stat>-1){
        
        if ([cardstat.rank intValue]>[value0.rank intValue]&&[cardstat.rank intValue]>[value1.rank intValue]&&[cardstat.rank intValue]>[value2.rank intValue]) {
            self.Windint=3;
        }
        if([cardstat.rank isEqual:@"11"]){
            
            [self.topimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"J-%@",cardstat.suit]]];
        }else if([cardstat.rank isEqual:@"12"]){
            [self.topimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"Q-%@",cardstat.suit]]];
            
        }else if([cardstat.rank isEqual:@"13"]){
            [self.topimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"K-%@",cardstat.suit]]];
        }else if([cardstat.rank isEqual:@"14"]){
            [self.topimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"A-%@",cardstat.suit]]];
            
        }else{
            [self.topimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@-%@",cardstat.rank,cardstat.suit]]];
        }
        
        [self.topparry removeObjectAtIndex:stat];
        
        self.toplab.text=[NSString stringWithFormat:@"%lu",(unsigned long)self.topparry.count];
        if (self.thehtparry.count==0) {
            [self jieshuyouxiwind];
        }else if(self.rightparry.count==0||self.leftparry.count==0||self.topparry.count==0){
            [self jieshuyouxi];
            
        }
        [self performSelector:@selector(gamedelayedMethod:) withObject:[NSString stringWithFormat:@"%ld",(long)self.Windint] afterDelay:1.0];
       
        
    }else{
        
        [self.topparry addObject:self.yourarray[0]];
        [self.topparry addObject:self.yourarray[1]];
        [self.topparry addObject:self.yourarray[2]];
        self.toplab.text=[NSString stringWithFormat:@"%lu",(unsigned long)self.topparry.count];
        [self performSelector:@selector(gamedelayedMethod:) withObject:@"3" afterDelay:1.0];
    }
    
}


//更新自己出牌
-(void)yourchupai:(Card *)yourcard buttag:(NSInteger)buttag{
    
    self.huase=yourcard.suit;
    self.Windint=1;
    if([yourcard.rank isEqual:@"11"]){
        
        [self.theimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"J-%@",yourcard.suit]]];
    }else if([yourcard.rank isEqual:@"12"]){
        [self.theimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"Q-%@",yourcard.suit]]];
        
    }else if([yourcard.rank isEqual:@"13"]){
        [self.theimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"K-%@",yourcard.suit]]];
    }else if([yourcard.rank isEqual:@"14"]){
        [self.theimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"A-%@",yourcard.suit]]];
        
    }else{
        [self.theimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@-%@",yourcard.rank,yourcard.suit]]];
    }
    [self.thehtparry removeObjectAtIndex:buttag];
    
    // 调用延迟方法并传递值
    [self performSelector:@selector(rirhtdelayedMethod:) withObject:yourcard afterDelay:1.0];
    
    
}

//自己出牌  right出牌
- (void)rirhtdelayedMethod:(Card * )value {
    
    NSInteger stat=-1;
    Card *cardstat=nil;
    for (int i=0; i<self.rightparry.count; i++) {
        Card * butarc=self.rightparry[i];
        if ([butarc.suit isEqual:value.suit]){
            
            cardstat=butarc;
            stat=i;
            break;
        }
    }
    if(stat>-1){
        if ([cardstat.rank intValue]>[value.rank intValue]) {
            self.Windint=2;
        }
        if([cardstat.rank isEqual:@"11"]){
            
            [self.rightimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"J-%@",cardstat.suit]]];
        }else if([cardstat.rank isEqual:@"12"]){
            [self.rightimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"Q-%@",cardstat.suit]]];
            
        }else if([cardstat.rank isEqual:@"13"]){
            [self.rightimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"K-%@",cardstat.suit]]];
        }else if([cardstat.rank isEqual:@"14"]){
            [self.rightimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"A-%@",cardstat.suit]]];
            
        }else{
            [self.rightimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@-%@",cardstat.rank,cardstat.suit]]];
        }
        
        [self.rightparry removeObjectAtIndex:stat];
        
        self.rhghtlab.text=[NSString stringWithFormat:@"%lu",(unsigned long)self.rightparry.count];
        
        if (self.thehtparry.count==0) {
            [self jieshuyouxiwind];
        }else if(self.rightparry.count==0||self.leftparry.count==0||self.topparry.count==0){
            [self jieshuyouxi];
            
        }
        NSMutableArray * cartdarray=[[NSMutableArray alloc]init];
        [cartdarray addObject:cardstat];
        [cartdarray addObject:value];
        // 调用延迟方法并传递值
        [self performSelector:@selector(topdelayedMethod:) withObject:cartdarray afterDelay:1.0];
        
    }else{
        
        [self.rightparry addObject:value];
        self.rhghtlab.text=[NSString stringWithFormat:@"%lu",(unsigned long)self.rightparry.count];
        
        [self performSelector:@selector(gamedelayedMethod:) withObject:@"2" afterDelay:1.0];
    }
    
    
}
//自己出牌 top自动出牌
- (void)topdelayedMethod:(NSMutableArray * )value {
    Card * right=value[0];
    Card * the=value[1];
    
    NSInteger stat=-1;
    Card *cardstat=nil;
    for (int i=0; i<self.topparry.count; i++) {
        Card * butarc=self.topparry[i];
        if ([butarc.suit isEqual:the.suit]){
            
         
            cardstat=butarc;
            stat=i;
            break;
        }
    }
    if(stat>-1){
        if ([cardstat.rank intValue]>[the.rank intValue]&&[cardstat.rank intValue]>[right.rank intValue]) {
            self.Windint=3;
        }
        if([cardstat.rank isEqual:@"11"]){
            
            [self.topimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"J-%@",cardstat.suit]]];
        }else if([cardstat.rank isEqual:@"12"]){
            [self.topimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"Q-%@",cardstat.suit]]];
            
        }else if([cardstat.rank isEqual:@"13"]){
            [self.topimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"K-%@",cardstat.suit]]];
        }else if([cardstat.rank isEqual:@"14"]){
            [self.topimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"A-%@",cardstat.suit]]];
            
        }else{
            [self.topimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@-%@",cardstat.rank,cardstat.suit]]];
        }
        
        [self.topparry removeObjectAtIndex:stat];
        
        self.toplab.text=[NSString stringWithFormat:@"%lu",(unsigned long)self.topparry.count];
        
        if (self.thehtparry.count==0) {
            [self jieshuyouxiwind];
        }else if(self.rightparry.count==0||self.leftparry.count==0||self.topparry.count==0){
            [self jieshuyouxi];
            
        }
        NSMutableArray * cartdarray=[[NSMutableArray alloc]init];
        [cartdarray addObject:cardstat];
        [cartdarray addObject:right];
        [cartdarray addObject:the];
        // 调用延迟方法并传递值
        [self performSelector:@selector(leftdelayedMethod:) withObject:cartdarray afterDelay:1.0];
        
    }else{
        
        [self.topparry addObject:the];
        [self.topparry addObject:right];
        self.toplab.text=[NSString stringWithFormat:@"%lu",(unsigned long)self.topparry.count];
        
        [self performSelector:@selector(gamedelayedMethod:) withObject:@"3" afterDelay:1.0];
    }
    
}

//自己出牌 left自动出牌
- (void)leftdelayedMethod:(NSMutableArray * )value {
    
    Card * top=value[0];
    Card * right=value[1];
    Card * the=value[2];
    
    NSInteger stat=-1;
    Card *cardstat=nil;
    for (int i=0; i<self.leftparry.count; i++) {
        Card * butarc=self.leftparry[i];
        if ([butarc.suit isEqual:the.suit]){
            cardstat=butarc;
            stat=i;
            break;
        }
    }
    
    
  
    
    if(stat>-1){
        if ([cardstat.rank intValue]>[the.rank intValue]&&[cardstat.rank intValue]>[right.rank intValue]&&[cardstat.rank intValue]>[top.rank intValue]) {
            self.Windint=4;
        }
        if([cardstat.rank isEqual:@"11"]){
            
            [self.leftimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"J-%@",cardstat.suit]]];
        }else if([cardstat.rank isEqual:@"12"]){
            [self.leftimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"Q-%@",cardstat.suit]]];
            
        }else if([cardstat.rank isEqual:@"13"]){
            [self.leftimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"K-%@",cardstat.suit]]];
        }else if([cardstat.rank isEqual:@"14"]){
            [self.leftimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"A-%@",cardstat.suit]]];
            
        }else{
            [self.leftimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@-%@",cardstat.rank,cardstat.suit]]];
        }
        
        [self.leftparry removeObjectAtIndex:stat];
        
        self.leftlab.text=[NSString stringWithFormat:@"%lu",(unsigned long)self.leftparry.count];
        if (self.thehtparry.count==0) {
            [self jieshuyouxiwind];
        }else if(self.rightparry.count==0||self.leftparry.count==0||self.topparry.count==0){
            [self jieshuyouxi];
            
        }

        [self performSelector:@selector(gamedelayedMethod:) withObject:[NSString stringWithFormat:@"%ld",(long)self.Windint] afterDelay:1.0];
 
    }else{
        
        [self.leftparry addObject:the];
        [self.leftparry addObject:right];
        [self.leftparry addObject:top];
        self.leftlab.text=[NSString stringWithFormat:@"%lu",(unsigned long)self.leftparry.count];
        
        [self performSelector:@selector(gamedelayedMethod:) withObject:@"4" afterDelay:1.0];
    }
    
}

//计算谁先开始出牌
- (void)gamedelayedMethod:(NSString * )value {
    if (self.thehtparry.count==0) {
        [self jieshuyouxiwind];
    }else if(self.rightparry.count==0||self.leftparry.count==0||self.topparry.count==0){
        [self jieshuyouxi];
        
    }
    self.huase=@"";
    self.Windint=0;
    self.statints=0;
    [self.leftimage setImage:[UIImage imageNamed:@""]];
    [self.rightimage setImage:[UIImage imageNamed:@""]];
    [self.theimage setImage:[UIImage imageNamed:@""]];
    [self.topimage setImage:[UIImage imageNamed:@""]];
    [self.yourarray removeAllObjects];
    self.yourarray=[[NSMutableArray alloc]init];
    if([value intValue]==1){
        self.statints=1;
        for (int i=0; i<self.handCards.count; i++) {
            CardButton *card = self.handCards[i];
            card.userInteractionEnabled=YES;
        }
        [self.leftimage setImage:[UIImage imageNamed:@""]];
        [self.rightimage setImage:[UIImage imageNamed:@""]];
        [self.theimage setImage:[UIImage imageNamed:@""]];
        [self.topimage setImage:[UIImage imageNamed:@""]];
    }else if ([value intValue]==2){
        self.statints=2;
        [self.leftimage setImage:[UIImage imageNamed:@""]];
        [self.rightimage setImage:[UIImage imageNamed:@""]];
        [self.theimage setImage:[UIImage imageNamed:@""]];
        [self.topimage setImage:[UIImage imageNamed:@""]];
        self.Windint=2;
        [self performSelector:@selector(rightdMethod:) withObject:@"" afterDelay:1.0];
        
    }else if ([value intValue]==3){
        self.statints=3;
        [self.leftimage setImage:[UIImage imageNamed:@""]];
        [self.rightimage setImage:[UIImage imageNamed:@""]];
        [self.theimage setImage:[UIImage imageNamed:@""]];
        [self.topimage setImage:[UIImage imageNamed:@""]];
        self.Windint=3;
        [self performSelector:@selector(topdMethod:) withObject:@"4" afterDelay:1.0];
        
    }else if ([value intValue]==4){
        self.statints=4;
        [self.leftimage setImage:[UIImage imageNamed:@""]];
        [self.rightimage setImage:[UIImage imageNamed:@""]];
        [self.theimage setImage:[UIImage imageNamed:@""]];
        [self.topimage setImage:[UIImage imageNamed:@""]];
        self.Windint=4;
        [self performSelector:@selector(leftdMethod:) withObject:@"4" afterDelay:1.0];
    }
    
    
}



//right先出牌
- (void)rightdMethod:(NSString * )value {
    Card * ritht=self.rightparry[0];
    self.Windint=2;
    [self.rightparry removeObjectAtIndex:0];
    self.rhghtlab.text=[NSString stringWithFormat:@"%lu",(unsigned long)self.rightparry.count];
    
    if([ritht.rank isEqual:@"11"]){
        [self.rightimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"J-%@",ritht.suit]]];
    }else if([ritht.rank isEqual:@"12"]){
        [self.rightimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"Q-%@",ritht.suit]]];
        
    }else if([ritht.rank isEqual:@"13"]){
        [self.rightimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"K-%@",ritht.suit]]];
    }else if([ritht.rank isEqual:@"14"]){
        [self.rightimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"A-%@",ritht.suit]]];
        
    }else{
        [self.rightimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@-%@",ritht.rank,ritht.suit]]];
    }
    if (self.thehtparry.count==0) {
        [self jieshuyouxiwind];
    }else if(self.rightparry.count==0||self.leftparry.count==0||self.topparry.count==0){
        [self jieshuyouxi];
        
    }
    NSMutableArray * cartdarray=[[NSMutableArray alloc]init];
    [cartdarray addObject:ritht];
    [self.yourarray addObject: ritht];
    
    // 调用延迟方法并传递值
    [self performSelector:@selector(righttoplayedMethod:) withObject:cartdarray afterDelay:1.0];
    
    
}

//right 先出牌   的top出牌
- (void)righttoplayedMethod:(NSMutableArray * )value {
    
   
    Card * right=value[0];
   
    
    NSInteger stat=-1;
    Card *cardstat=nil;
    for (int i=0; i<self.topparry.count; i++) {
        Card * butarc=self.topparry[i];
        if ([butarc.suit isEqual:right.suit]){
            
           
            cardstat=butarc;
            stat=i;
            break;
        }
    }
   
    
    if(stat>-1){
        if ([cardstat.rank intValue]>[right.rank intValue]) {
            self.Windint=3;
        }
        if([cardstat.rank isEqual:@"11"]){
            
            [self.topimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"J-%@",cardstat.suit]]];
        }else if([cardstat.rank isEqual:@"12"]){
            [self.topimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"Q-%@",cardstat.suit]]];
            
        }else if([cardstat.rank isEqual:@"13"]){
            [self.topimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"K-%@",cardstat.suit]]];
        }else if([cardstat.rank isEqual:@"14"]){
            [self.topimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"A-%@",cardstat.suit]]];
            
        }else{
            [self.topimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@-%@",cardstat.rank,cardstat.suit]]];
        }
        
        [self.topparry removeObjectAtIndex:stat];
        
        self.toplab.text=[NSString stringWithFormat:@"%lu",(unsigned long)self.topparry.count];
        
        if (self.thehtparry.count==0) {
            [self jieshuyouxiwind];
        }else if(self.rightparry.count==0||self.leftparry.count==0||self.topparry.count==0){
            [self jieshuyouxi];
            
        }
        NSMutableArray * cartdarray=[[NSMutableArray alloc]init];
        [cartdarray addObject:right];
        [cartdarray addObject:cardstat];
        
      
        [self.yourarray addObject: cardstat];
        // 调用延迟方法并传递值
        [self performSelector:@selector(rightleftlayedMethod:) withObject:cartdarray afterDelay:1.0];
    }else{
        [self.topparry addObject:right];
        self.toplab.text=[NSString stringWithFormat:@"%lu",(unsigned long)self.topparry.count];
        [self performSelector:@selector(gamedelayedMethod:) withObject:@"3" afterDelay:1.0];
    }
}


//right 出牌的  left自动出牌
- (void)rightleftlayedMethod:(NSMutableArray * )value {
    
   
    Card * right=value[0];
    Card * top=value[1];
    
    NSInteger stat=-1;//有没有这个花色的牌
    Card *cardstat=nil;
    for (int i=0; i<self.leftparry.count; i++) {
        Card * butarc=self.leftparry[i];
        if ([butarc.suit isEqual:right.suit]){
            
            cardstat=butarc;
            stat=i;
            break;
        }
    }
    
    
    if(stat>-1){
        if ([cardstat.rank intValue]>[right.rank intValue]&&[cardstat.rank intValue]>[top.rank intValue]) {
            self.Windint=4;
        }
        if([cardstat.rank isEqual:@"11"]){
            
            [self.leftimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"J-%@",cardstat.suit]]];
        }else if([cardstat.rank isEqual:@"12"]){
            [self.leftimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"Q-%@",cardstat.suit]]];
            
        }else if([cardstat.rank isEqual:@"13"]){
            [self.leftimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"K-%@",cardstat.suit]]];
        }else if([cardstat.rank isEqual:@"14"]){
            [self.leftimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"A-%@",cardstat.suit]]];
            
        }else{
            [self.leftimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@-%@",cardstat.rank,cardstat.suit]]];
        }
        
        [self.leftparry removeObjectAtIndex:stat];
        
        self.leftlab.text=[NSString stringWithFormat:@"%lu",(unsigned long)self.leftparry.count];
        if (self.thehtparry.count==0) {
            [self jieshuyouxiwind];
        }else if(self.rightparry.count==0||self.leftparry.count==0||self.topparry.count==0){
            [self jieshuyouxi];
            
        }
        
        [self.yourarray addObject:cardstat];
        
        self.statints=2;
        self.huase=right.suit;
        int stata=0;
        for (int i=0; i<self.thehtparry.count; i++) {
            Card * sfa=self.thehtparry[i];
            if ([sfa.suit isEqual:right.suit]) {
                stata=1;
            }
        }
        if (stata==0){
            [self.thehtparry addObject:right];
            [self.thehtparry addObject:cardstat];
            [self.thehtparry addObject:top];
            self.huase=@"";
            self.statints=1;
            [self updateHandCardsDisplay];
            self.thelab.text=[NSString stringWithFormat:@"%lu",(unsigned long)self.leftparry.count];
            [self performSelector:@selector(gamedelayedMethod:) withObject:@"1" afterDelay:1.0];
            
          
        }else{
            self.statints=2;
        }
        for (int i=0; i<self.handCards.count; i++) {
            CardButton *card = self.handCards[i];
            card.userInteractionEnabled=YES;
            
        }
    }else{
        [self.leftparry addObject:right];
        [self.leftparry addObject:top];
        self.leftlab.text=[NSString stringWithFormat:@"%lu",(unsigned long)self.leftparry.count];
        [self performSelector:@selector(gamedelayedMethod:) withObject:@"3" afterDelay:1.0];
    }
}

//top先出牌
- (void)topdMethod:(NSString * )value {
    Card * ritht=self.topparry[0];
    self.Windint=3;
    [self.topparry removeObjectAtIndex:0];
    self.toplab.text=[NSString stringWithFormat:@"%lu",(unsigned long)self.topparry.count];
    
    if([ritht.rank isEqual:@"11"]){
        
        [self.topimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"J-%@",ritht.suit]]];
    }else if([ritht.rank isEqual:@"12"]){
        [self.topimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"Q-%@",ritht.suit]]];
        
    }else if([ritht.rank isEqual:@"13"]){
        [self.topimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"K-%@",ritht.suit]]];
    }else if([ritht.rank isEqual:@"14"]){
        [self.topimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"A-%@",ritht.suit]]];
        
    }else{
        [self.topimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@-%@",ritht.rank,ritht.suit]]];
    }
    
    if (self.thehtparry.count==0) {
        [self jieshuyouxiwind];
    }else if(self.rightparry.count==0||self.leftparry.count==0||self.topparry.count==0){
        [self jieshuyouxi];
        
    }
    
    NSMutableArray * cartdarray=[[NSMutableArray alloc]init];
    [cartdarray addObject:ritht];
  
    [self.yourarray addObject: ritht];
    // 调用延迟方法并传递值
    [self performSelector:@selector(topleftlayedMethod:) withObject:cartdarray afterDelay:1.0];
}

// top 先出牌 left 自动出牌

- (void)topleftlayedMethod:(NSMutableArray * )value {
    
    Card * top=value[0];
    NSInteger stat=-1;
    Card *cardstat=nil;
    for (int i=0; i<self.leftparry.count; i++) {
        Card * butarc=self.leftparry[i];
        if ([butarc.suit isEqual:top.suit]){
            
           
            cardstat=butarc;
            stat=i;
            break;
        }
    }
    if(stat>-1){
        if ([cardstat.rank intValue]>[top.rank intValue]) {
            self.Windint=4;
        }
        if([cardstat.rank isEqual:@"11"]){
            
            [self.leftimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"J-%@",cardstat.suit]]];
        }else if([cardstat.rank isEqual:@"12"]){
            [self.leftimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"Q-%@",cardstat.suit]]];
            
        }else if([cardstat.rank isEqual:@"13"]){
            [self.leftimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"K-%@",cardstat.suit]]];
        }else if([cardstat.rank isEqual:@"14"]){
            [self.leftimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"A-%@",cardstat.suit]]];
            
        }else{
            [self.leftimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@-%@",cardstat.rank,cardstat.suit]]];
        }
        
        [self.leftparry removeObjectAtIndex:stat];
        
        self.leftlab.text=[NSString stringWithFormat:@"%lu",(unsigned long)self.leftparry.count];
        
        if (self.thehtparry.count==0) {
            [self jieshuyouxiwind];
        }else if(self.rightparry.count==0||self.leftparry.count==0||self.topparry.count==0){
            [self jieshuyouxi];
            
        }
        [self.yourarray addObject:cardstat];
      
        
        self.statints=2;
        self.huase=top.suit;
        int stata=0;
        for (int i=0; i<self.thehtparry.count; i++) {
            Card * sfa=self.thehtparry[i];
            if ([sfa.suit isEqual:top.suit]) {
                stata=1;
            }
        }
        if (stata==0){
            [self.thehtparry addObject:cardstat];
            [self.thehtparry addObject:top];
            self.huase=@"";
            self.statints=1;
            [self updateHandCardsDisplay];
            [self performSelector:@selector(gamedelayedMethod:) withObject:@"1" afterDelay:1.0];
           
        }else {
            self.statints=2;
        }
        for (int i=0; i<self.handCards.count; i++) {
            CardButton *card = self.handCards[i];
            card.userInteractionEnabled=YES;
        }
    }else{
        [self.leftparry addObject:top];
        self.leftlab.text=[NSString stringWithFormat:@"%lu",(unsigned long)self.leftparry.count];
        [self performSelector:@selector(gamedelayedMethod:) withObject:@"3" afterDelay:1.0];
    }
}

//left 先出牌
- (void)leftdMethod:(NSString * )value {
    Card * ritht=self.leftparry[0];
    [self.leftparry removeObjectAtIndex:0];
    self.leftlab.text=[NSString stringWithFormat:@"%lu",(unsigned long)self.leftparry.count];
    
    if([ritht.rank isEqual:@"11"]){
        
        [self.leftimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"J-%@",ritht.suit]]];
    }else if([ritht.rank isEqual:@"12"]){
        [self.leftimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"Q-%@",ritht.suit]]];
        
    }else if([ritht.rank isEqual:@"13"]){
        [self.leftimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"K-%@",ritht.suit]]];
    }else if([ritht.rank isEqual:@"14"]){
        [self.leftimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"A-%@",ritht.suit]]];
        
    }else{
        [self.leftimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@-%@",ritht.rank,ritht.suit]]];
    }
    
    if (self.thehtparry.count==0) {
        [self jieshuyouxiwind];
    }else if(self.rightparry.count==0||self.leftparry.count==0||self.topparry.count==0){
        [self jieshuyouxi];
        
    }
    
    [self.yourarray addObject:ritht];
    self.statints=2;
    self.huase=ritht.suit;
    int stata=0;
    for (int i=0; i<self.thehtparry.count; i++) {
        Card * sfa=self.thehtparry[i];
        if ([sfa.suit isEqual:ritht.suit]) {
            stata=1;
        }
    }
    if (stata==0){
        [self.thehtparry addObject:ritht];
        self.huase=@"";
        self.statints=1;
        [self updateHandCardsDisplay];
        [self performSelector:@selector(gamedelayedMethod:) withObject:@"1" afterDelay:1.0];
    }else{
        self.statints=2;
    }
    
    for (int i=0; i<self.handCards.count; i++) {
        CardButton *card = self.handCards[i];
        card.userInteractionEnabled=YES;
    }
    
}
//更新界面
- (IBAction)honmeclick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


//重置游戏
- (IBAction)Refreshclick:(id)sender {
    
    // 创建UIAlertController对象，设置标题和消息
       UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Tips"
                                                                                message:@"Are you sure you want to reset the game"
                                                                         preferredStyle:UIAlertControllerStyleAlert];

       // 创建确认按钮的UIAlertAction
       UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"OK"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * _Nonnull action) {
           [NSObject cancelPreviousPerformRequestsWithTarget:self];                                     // 确认按钮点击后执行的代码
           [self updategame];
                                                             }];

       // 创建取消按钮的UIAlertAction
       UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                              style:UIAlertActionStyleCancel
                                                            handler:^(UIAlertAction * _Nonnull action) {
                                                           
                                                            }];

       // 将确认和取消按钮添加到UIAlertController
       [alertController addAction:confirmAction];
       [alertController addAction:cancelAction];

       // 显示UIAlertController
       // self是一个UIViewController的实例
       [self presentViewController:alertController animated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
