#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSString *selectedCategory;
@property (nonatomic, assign) NSInteger factIndex;

@property (nonatomic, strong) UILabel *factLabel;
@property (nonatomic, strong) UILabel *factSubtitleLabel;

@end

@implementation ViewController

#pragma mark - Colores de la aplicación

- (UIColor *)oliveColor {
    return [UIColor colorWithRed:82.0/255.0
                           green:100.0/255.0
                            blue:72.0/255.0
                           alpha:1.0];
}

- (UIColor *)beigeColor {
    return [UIColor colorWithRed:244.0/255.0
                           green:241.0/255.0
                            blue:232.0/255.0
                           alpha:1.0];
}

- (UIColor *)lightGreenColor {
    return [UIColor colorWithRed:229.0/255.0
                           green:233.0/255.0
                            blue:220.0/255.0
                           alpha:1.0];
}

- (UIColor *)darkGreenColor {
    return [UIColor colorWithRed:52.0/255.0
                           green:70.0/255.0
                            blue:50.0/255.0
                           alpha:1.0];
}

#pragma mark - Inicio

- (void)viewDidLoad {
    [super viewDidLoad];

    self.factIndex = -1;
    self.view.backgroundColor = [self beigeColor];

    [self showWelcomeScreen];
}

#pragma mark - Elementos reutilizables

- (UILabel *)createHeaderWithTitle:(NSString *)title {

    UILabel *header = [[UILabel alloc] init];

    header.text = title;
    header.textColor = [UIColor whiteColor];
    header.font = [UIFont boldSystemFontOfSize:24];
    header.textAlignment = NSTextAlignmentCenter;
    header.numberOfLines = 0;

    header.backgroundColor = [self oliveColor];
    header.layer.cornerRadius = 20;
    header.layer.masksToBounds = YES;

    header.translatesAutoresizingMaskIntoConstraints = NO;

    [header.heightAnchor constraintEqualToConstant:115].active = YES;

    return header;
}

- (UIButton *)createButtonWithTitle:(NSString *)title
                             action:(SEL)action {

    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];

    [button setTitle:title forState:UIControlStateNormal];

    [button setTitleColor:[UIColor whiteColor]
                 forState:UIControlStateNormal];

    button.titleLabel.font = [UIFont boldSystemFontOfSize:17];

    button.backgroundColor = [self oliveColor];
    button.layer.cornerRadius = 10;

    [button addTarget:self
               action:action
     forControlEvents:UIControlEventTouchUpInside];

    button.translatesAutoresizingMaskIntoConstraints = NO;

    [button.heightAnchor constraintEqualToConstant:54].active = YES;

    return button;
}

- (UIButton *)createCategoryButtonWithTitle:(NSString *)title
                                     action:(SEL)action {

    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];

    [button setTitle:title forState:UIControlStateNormal];

    [button setTitleColor:[self darkGreenColor]
                 forState:UIControlStateNormal];

    button.titleLabel.font = [UIFont boldSystemFontOfSize:16];

    button.backgroundColor = [self lightGreenColor];
    button.layer.cornerRadius = 15;

    [button addTarget:self
               action:action
     forControlEvents:UIControlEventTouchUpInside];

    button.translatesAutoresizingMaskIntoConstraints = NO;

    [button.heightAnchor constraintEqualToConstant:72].active = YES;

    return button;
}

- (UIStackView *)createVerticalStack {

    UIStackView *stack = [[UIStackView alloc] init];

    stack.axis = UILayoutConstraintAxisVertical;
    stack.spacing = 20;
    stack.alignment = UIStackViewAlignmentFill;
    stack.distribution = UIStackViewDistributionFill;

    stack.translatesAutoresizingMaskIntoConstraints = NO;

    return stack;
}

- (void)installStack:(UIStackView *)stack {

    [self.view addSubview:stack];

    [NSLayoutConstraint activateConstraints:@[
        [stack.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:28],
        [stack.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-28],
        [stack.centerYAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.centerYAnchor]
    ]];
}

- (void)clearScreen {

    for (UIView *subview in [self.view.subviews copy]) {
        [subview removeFromSuperview];
    }

    self.view.backgroundColor = [self beigeColor];
}

#pragma mark - Pantalla 1: Bienvenida

- (void)showWelcomeScreen {

    [self clearScreen];

    UIStackView *stack = [self createVerticalStack];

    UILabel *header = [self createHeaderWithTitle:@"¿Sabías qué?"];

    UILabel *welcome = [[UILabel alloc] init];
    welcome.text = @"¡Hola!";
    welcome.font = [UIFont boldSystemFontOfSize:25];
    welcome.textColor = [self darkGreenColor];
    welcome.textAlignment = NSTextAlignmentCenter;

    UILabel *subtitle = [[UILabel alloc] init];
    subtitle.text = @"Descubre algo nuevo hoy.";
    subtitle.font = [UIFont boldSystemFontOfSize:17];
    subtitle.textColor = [self darkGreenColor];
    subtitle.textAlignment = NSTextAlignmentCenter;

    UILabel *description = [[UILabel alloc] init];
    description.text = @"Pequeñas curiosidades, grandes descubrimientos.";
    description.font = [UIFont systemFontOfSize:13];
    description.textColor = [self darkGreenColor];
    description.textAlignment = NSTextAlignmentCenter;
    description.numberOfLines = 0;

    UIButton *startButton =
    [self createButtonWithTitle:@"Comenzar →"
                         action:@selector(showCategoryScreen)];

    [stack addArrangedSubview:header];
    [stack addArrangedSubview:welcome];
    [stack addArrangedSubview:subtitle];
    [stack addArrangedSubview:description];
    [stack addArrangedSubview:startButton];

    [self installStack:stack];
}

#pragma mark - Pantalla 2: Categorías

- (void)showCategoryScreen {

    [self clearScreen];

    UIStackView *stack = [self createVerticalStack];

    UILabel *header =
    [self createHeaderWithTitle:@"Elige una categoría"];

    UILabel *question = [[UILabel alloc] init];
    question.text = @"¿Qué te gustaría descubrir hoy?";
    question.font = [UIFont boldSystemFontOfSize:18];
    question.textColor = [self darkGreenColor];
    question.textAlignment = NSTextAlignmentCenter;
    question.numberOfLines = 0;

    UIButton *sportsButton =
    [self createCategoryButtonWithTitle:@"🏆  DEPORTES"
                                 action:@selector(selectSports)];

    UIButton *scienceButton =
    [self createCategoryButtonWithTitle:@"🌿  CIENCIA Y NATURALEZA"
                                 action:@selector(selectScience)];

    UIButton *technologyButton =
    [self createCategoryButtonWithTitle:@"💻  TECNOLOGÍA"
                                 action:@selector(selectTechnology)];

    [stack addArrangedSubview:header];
    [stack addArrangedSubview:question];
    [stack addArrangedSubview:sportsButton];
    [stack addArrangedSubview:scienceButton];
    [stack addArrangedSubview:technologyButton];

    [self installStack:stack];
}

#pragma mark - Selección de categorías

- (void)selectSports {
    [self selectCategory:@"Deportes"];
}

- (void)selectScience {
    [self selectCategory:@"Ciencia y naturaleza"];
}

- (void)selectTechnology {
    [self selectCategory:@"Tecnología"];
}

- (void)selectCategory:(NSString *)category {

    self.selectedCategory = category;
    self.factIndex = -1;

    [self showFactScreen];
}

#pragma mark - Pantalla 3: Datos curiosos

- (void)showFactScreen {

    [self clearScreen];

    UIStackView *stack = [self createVerticalStack];

    UILabel *header =
    [self createHeaderWithTitle:@"¡Descubre algo nuevo!"];

    UILabel *categoryLabel = [[UILabel alloc] init];
    categoryLabel.text = [self.selectedCategory uppercaseString];
    categoryLabel.font = [UIFont boldSystemFontOfSize:16];
    categoryLabel.textColor = [self oliveColor];
    categoryLabel.textAlignment = NSTextAlignmentCenter;

    UIView *factCard = [[UIView alloc] init];
    factCard.backgroundColor = [self lightGreenColor];
    factCard.layer.cornerRadius = 24;
    factCard.translatesAutoresizingMaskIntoConstraints = NO;

    UILabel *questionLabel = [[UILabel alloc] init];
    questionLabel.text = @"💡  ¿Sabías qué?";
    questionLabel.font = [UIFont boldSystemFontOfSize:19];
    questionLabel.textColor = [self darkGreenColor];
    questionLabel.textAlignment = NSTextAlignmentCenter;

    self.factLabel = [[UILabel alloc] init];
    self.factLabel.font = [UIFont systemFontOfSize:18];
    self.factLabel.textColor = [self darkGreenColor];
    self.factLabel.textAlignment = NSTextAlignmentCenter;
    self.factLabel.numberOfLines = 0;

    self.factSubtitleLabel = [[UILabel alloc] init];
    self.factSubtitleLabel.font = [UIFont italicSystemFontOfSize:13];
    self.factSubtitleLabel.textColor = [self oliveColor];
    self.factSubtitleLabel.textAlignment = NSTextAlignmentCenter;
    self.factSubtitleLabel.numberOfLines = 0;

    UIStackView *cardStack = [self createVerticalStack];
    cardStack.spacing = 12;

    [cardStack addArrangedSubview:questionLabel];
    [cardStack addArrangedSubview:self.factLabel];
    [cardStack addArrangedSubview:self.factSubtitleLabel];

    [factCard addSubview:cardStack];

    [NSLayoutConstraint activateConstraints:@[
        [cardStack.topAnchor constraintEqualToAnchor:factCard.topAnchor constant:22],
        [cardStack.bottomAnchor constraintEqualToAnchor:factCard.bottomAnchor constant:-22],
        [cardStack.leadingAnchor constraintEqualToAnchor:factCard.leadingAnchor constant:18],
        [cardStack.trailingAnchor constraintEqualToAnchor:factCard.trailingAnchor constant:-18],
        [factCard.heightAnchor constraintGreaterThanOrEqualToConstant:220]
    ]];

    UIButton *nextButton =
    [self createButtonWithTitle:@"Descubrir otro dato →"
                         action:@selector(showNextFact)];

    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeSystem];

    [backButton setTitle:@"← Cambiar categoría"
                forState:UIControlStateNormal];

    [backButton setTitleColor:[self oliveColor]
                     forState:UIControlStateNormal];

    backButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];

    [backButton addTarget:self
                   action:@selector(showCategoryScreen)
         forControlEvents:UIControlEventTouchUpInside];

    [stack addArrangedSubview:header];
    [stack addArrangedSubview:categoryLabel];
    [stack addArrangedSubview:factCard];
    [stack addArrangedSubview:nextButton];
    [stack addArrangedSubview:backButton];

    [self installStack:stack];

    [self showNextFact];
}

#pragma mark - Información de las categorías

- (NSDictionary *)factsDictionary {

    return @{

        @"Deportes": @[
            @"El FC Barcelona fue fundado el 29 de noviembre de 1899 por un grupo de futbolistas liderado por Hans Gamper.",
            @"El FC Barcelona ha ganado cinco títulos de la UEFA Champions League masculina.",
            @"La distancia oficial de un maratón es de 42.195 kilómetros.",
            @"Los primeros Juegos Olímpicos de la era moderna se celebraron en Atenas en 1896."
        ],

        @"Ciencia y naturaleza": @[
            @"Los pulpos tienen tres corazones y su sangre es de color azul.",
            @"La luz del Sol tarda aproximadamente 8 minutos y 20 segundos en llegar a la Tierra.",
            @"Las abejas se comunican mediante movimientos conocidos como la danza de las abejas.",
            @"Los árboles pueden intercambiar sustancias y señales a través de redes subterráneas de hongos."
        ],

        @"Tecnología": @[
            @"El primer iPhone fue presentado por Steve Jobs en enero de 2007.",
            @"El código QR fue desarrollado en Japón en 1994 por la empresa Denso Wave.",
            @"El nombre Bluetooth está inspirado en el rey vikingo Harald Bluetooth.",
            @"Ada Lovelace es reconocida por escribir uno de los primeros algoritmos destinados a una máquina."
        ]
    };
}

#pragma mark - Cambiar dato curioso

- (void)showNextFact {

    NSArray *facts = [self factsDictionary][self.selectedCategory];

    if (facts.count == 0) {
        return;
    }

    self.factIndex++;

    if (self.factIndex >= facts.count) {
        self.factIndex = 0;
    }

    self.factLabel.text = facts[self.factIndex];

    self.factSubtitleLabel.text =
    @"¡Sigue descubriendo nuevas curiosidades!";
}

@end
