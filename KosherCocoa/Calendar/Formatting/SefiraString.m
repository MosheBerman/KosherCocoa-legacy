//
//  SefiraString.m
//  UltimateOmer2
//
//  Created by Moshe Berman on 3/21/11.
//  Copyright 2011 MosheBerman.com. All rights reserved.
//

#import "SefiraString.h"
#import "KosherCocoaConstants.h"

@implementation SefiraString
@synthesize day;

- (id)initWithDay:(NSInteger)tempDay{
    
    if (self == [super init]) {

        self.day = tempDay;
        
    }
    return self;
}


//
// This method returns the text for the day, with HTML formatting
//

- (NSString *)omerTextForDay:(NSInteger)tempDay{
	
	NSString *leshaim, *bracha, *omer, *harachaman, *lamnaztaiach, *ribono, *ana, *alainu;
	
    /*
	NSString *bracha = [self stringForBracha];
    
	NSString *omer = [self dayStringInHebrew:tempDay];
	
	NSString *harachaman = [self stringForHarachman];
    
	NSString *lamnaztaiach = [self stringForLamnatzaiach];
	
	NSString *ribono = [self stringForRibono];
    
	NSString *ana = [self stringForAna];
    
	NSString *alainu = [self stringForAleinu];
     */
    
    if(kShowBracha == YES){
        bracha = @"<h3 style='text-align: center;'>בָּרוּךְ אַתָּה יְיָ אֱלֹהֵֽינוּ מֶֽלֶךְ הָעוֹלָם, אֲשֶׁר קִדְּשָֽׁנוּ בְּמִצְוֹתָיו, וְצִוָּֽנוּ עַל סְפִירַת הָעֹֽמֶר</h3>";
	}else{
        bracha = @"";
	}
    
    if(kShowLeshaimYichud == YES){
		leshaim = @"<p style='text-align: justify;'><h1 style='display: inline; clear: none;'>לְשֵׁם</h1> <p style='display: inline; clear: none;'>יִחוּד קֻדְשָׁא בְּרִיךְ הוּא וּשְׁכִינְתֵּהּ, בִּדְחִילוּ וּרְחִימוּ, לְיַחֵד שֵׁם י\"ה בְּו\"ה בְּיִחוּדָא שְׁלִים, בְֹּשֵם כָּל יִשְׂרָאֵל. הִנְנִי מוּכָן וּמְזֻמָּן לְקַיֵּם מִצְוַת עֲשֵׂה שֶׁל סְפִירַת הָעֹֽמֶר, כְּמוֹ שֶׁכָּתוּב בַּתּוֹרָה: וּסְפַרְתֶּם לָכֶם מִמָּחֳרַת הַשַּׁבָּת מִיּוֹם הֲבִיאֲכֶם אֶת עֹֽמֶר הַתְּנוּפָה, שֶֽׁבַע שַׁבָּתוֹת תְּמִימֹת תִּהְיֶֽינָה. עַד מִמָּחֳרַת הַשַּׁבָּת הַשְּׁבִיעִת תִּסְפְּרוּ חֲמִשִּׁים יוֹם, וְהִקְרַבְתֶּם מִנְחָה חֲדָשָׁה לַייָ. וִיהִי נֹֽעַם אֲדֹנָי אֱלֹהֵֽינוּ עָלֵֽינוּ, וּמַעֲשֵׂה יָדֵֽינוּ כּוֹנְנָה עָלֵֽינוּ, וּמַעֲשֵׂה יָדֵֽינוּ כּוֹנְנֵֽהוּ.</p><p>";
	}else{
        
		leshaim = @"";	
	}
    

    //
    //  Omer
    //
    
    omer = [NSString stringWithFormat: @"<h2 style='text-align: center;'>%@</h2>", [self dayStringInHebrew:self.day]];
    
    
    if(kShowHarachaman == YES){
        harachaman =  @"<h2 style='display: inline;'>הָרַחֲמָן</h2><p style='display: inline; clear: none; direction: rtl; text-align: justify center;'> הוּא יַחֲזִיר לָֽנוּ עֲבוֹדַת בֵּית הַמִּקְדָּשׁ לִמְקוֹמָהּ, בִּמְהֵרָה בְיָמֵֽינוּ אָמֵן סֶֽלָה.</p>";
	}else{
        
		harachaman = @"";
	}
    
    //
    //
    //
    
    if(kShowLamnatzaiach == YES){
        lamnaztaiach =  @"<br /><h2 style='display: inline;'>לַמְנַצֵּֽחַ </h2><p style='display: inline; clear: none; direction: rtl; text-align: justify center;'>בִּנְגִינוֹת מִזְמוֹר שִׁיר. אֱלֹהִים יְחָנֵּֽנוּ וִיבָרְכֵֽנוּ, יָאֵר פָּנָיו אִתָּֽנוּ סֶֽלָה. לָדַֽעַת בָּאָֽרֶץ דַּרְכֶּֽךָ, בְּכָל גּוֹיִם יְשׁוּעָתֶֽךָ. יוֹדֽוּךָ עַמִּים, אֱלֹהִים, יוֹדֽוּךָ עַמִּים כֻּלָּם. יִשְׂמְחוּ וִירַנְּנוּ לְאֻמִּים, כִּי תִשְׁפּוֹט עַמִּים מִישׁוֹר, וּלְאֻמִּים בָּאָֽרֶץ תַּנְחֵם סֶֽלָה. יוֹדֽוּךָ עַמִּים, אֱלֹהִים, יוֹדֽוּךָ עַמִּים כֻּלָּם. אֶֽרֶץ נָתְנָה יְבוּלָהּ, יְבָרְכֵֽנוּ אֱלֹהִים אֱלֹהֵֽינוּ. יְבָרְכֵֽנוּ אֱלֹהִים, וְיִירְאוּ אוֹתוֹ כָּל אַפְסֵי אָֽרֶץ. </p>";
	}else{
		lamnaztaiach = @"";
	}
    
    //
    //
    //
    
    if(kShowAna == YES){
		ana = @"<br /><br /><h2 style='display: inline; clear: none; margin: 0; width: 100%'>אָנָּא</h2><p id='ana' style='clear: none; display: inline;'>, בְּכֹֽחַ גְּדֻלַּת יְמִינְךָ, תַּתִּיר צְרוּרָה.<span>אב\"ג ית\"ץ</span>קַבֵּל רִנַּת עַמְּךָ, שַׂגְּבֵֽנוּ, טַהֲרֵֽנוּ, נוֹרָא.<span>קר\"ע שט\"ן</span>נָא גִבּוֹר, דּוֹרְשֵׁי יִחוּדְךָ, כְּבָבַת שָׁמְרֵם.<span>נג\"ד יכ\"ש</span>בָּרְכֵם, טַהֲרֵם, רַחֲמֵם, צִדְקָתְךָ תָּמִיד גָּמְלֵם.<span>בט\"ר צת\"ג</span>חֲסִין קָדוֹשׁ, בְּרוֹב טוּבְךָ, נַהֵל עֲדָתֶֽךָ.<span>חק\"ב טנ\"ע</span>יָחִיד גֵּאֶה, לְעַמְּךָ פְּנֵה, זוֹכְרֵי קְדֻשָּׁתֶֽךָ.<span>יג\"ל פז\"ק</span>שַׁוְעָתֵֽנוּ קַבֵּל, וּשְׁמַע צַעֲקָתֵֽנוּ, יוֹדֵֽעַ תַּעֲלֻמוֹת.<span>שק\"ו צי\"ת</span></p><h4 style='text-align:center;'>בָּרוּךְ שֵׁם כְּבוֹד מַלְכוּתוֹ לְעוֹלָם וָעֶד.</h4>";
	}else{
        ana = @"";
	}
    
    //
    //
    //
    
    if(kShowRibono == YES){
		ribono = [NSString stringWithFormat:@"<h3 style='display: inline; clear: none;'>רִבּוֹנוֹ</h3><p style='display: inline; clear: none;'> שֶׁל עוֹלָם, אַתָּה צִוִּיתָֽנוּ עַל יְדֵי מֹשֶׁה עַבְדֶּֽךָ לִסְפּוֹר סְפִירַת הָעֹֽמֶר, כְּדֵי לְטַהֲרֵֽנוּ מִקְּלִפּוֹתֵֽינוּ וּמִטֻּמְאוֹתֵֽינוּ, כְּמוֹ שֶׁכָּתַֽבְתָּ בְּתוֹרָתֶֽךָ: וּסְפַרְתֶּם לָכֶם מִמָּחֳרַת הַשַּׁבָּת מִיּוֹם הֲבִיאֲכֶם אֶת עֹֽמֶר הַתְּנוּפָה, שֶֽׁבַע שַׁבָּתוֹת תְּמִימֹת תִּהְיֶֽינָה, עַד מִמָּחֳרַת הַשַּׁבָּת הַשְּׁבִיעִת תִּסְפְּרוּ חֲמִשִּׁים יוֹם, כְּדֵי שֶׁיִּטָּהֲרוּ נַפְשׁוֹת עַמְּךָ יִשְׂרָאֵל מִזֻּהֲמָתָם. וּבְכֵן יְהִי רָצוֹן מִלְּפָנֶֽיךָ יְיָ אֱלֹהֵֽינוּ וֵאלֹהֵי אֲבוֹתֵֽינוּ, שֶׁבִּזְכוּת סְפִירַת הָעֹֽמֶר שֶׁסָּפַֽרְתִּי הַיּוֹם, יְתֻקַּן מַה שֶּׁפָּגַֽמְתִּי בִּסְפִירָה <span style='font-weight: bold;'>%@</span> וְאֶטָּהֵר וְאֶתְקַדֵּשׁ בִּקְדֻשָּׁה שֶׁל מַֽעְלָה, וְעַל יְדֵי זֶה יֻשְׁפַּע שֶֽׁפַע רַב בְּכָל הָעוֹלָמוֹת, וּלְתַקֵּן אֶת נַפְשׁוֹתֵֽינוּ וְרוּחוֹתֵֽינוּ וְנִשְׁמוֹתֵֽינוּ מִכָּל סִיג וּפְגַם, וּלְטַהֲרֵֽנוּ וּלְקַדְּשֵֽׁנוּ בִּקְדֻשָּׁתְךָ הָעֶלְיוֹנָה, אָמֵן סֶֽלָה.</p>", [self middahStringInHebrew:day]];
	}else{
		ribono =  @"";	
	}
    
    //
    //
    //
    
    if(kShowAleinu== YES){
		alainu = [NSString stringWithFormat:@" <h2 style='display: inline; '>עָלֵינוּ</h2> לְשַׁבֵּחַ לַאֲדון הַכּל. לָתֵת גְּדֻלָּה לְיוצֵר בְּרֵאשִׁית. שֶׁלּא עָשנוּ כְּגויֵי הָאֲרָצות. וְלא שמָנוּ כְּמִשְׁפְּחות הָאֲדָמָה. שֶׁלּא שם חֶלְקֵנוּ כָּהֶם וְגורָלֵנוּ כְּכָל הֲמונָם. שֶׁהֵם מִשְׁתַּחֲוִים לְהֶבֶל וָרִיק וּמִתְפַּלְלִים אֶל אֵל לא יושִׁיעַ וַאֲנַחְנוּ כּורְעִים וּמִשְׁתַּחֲוִים וּמודִים לִפְנֵי מֶלֶךְ מַלְכֵי הַמְּלָכִים הַקָּדושׁ בָּרוּךְ הוּא. שֶׁהוּא נוטֶה שָׁמַיִם וְיוסֵד אָרֶץ. וּמושַׁב יְקָרו בַּשָּׁמַיִם מִמַּעַל. וּשְׁכִינַת עֻזּו בְּגָבְהֵי מְרומִים. הוּא אֱלהֵינוּ אֵין עוד. אֱמֶת מַלְכֵּנוּ. אֶפֶס זוּלָתו. כַּכָּתוּב בְּתורָתו. וְיָדַעְתָּ הַיּום וַהֲשֵׁבתָ אֶל לְבָבֶךָ. כִּי ה' הוּא הָאֱלהִים בַּשָּׁמַיִם מִמַּעַל וְעַל הָאָרֶץ מִתָּחַת. אֵין עוד: וְעַל כֵּן נְקַוֶּה לְּךָ ה' אֱלהֵינוּ לִרְאות מְהֵרָה בְּתִפְאֶרֶת עֻזֶּךָ. לְהַעֲבִיר גִּלּוּלִים מִן הָאָרֶץ. וְהָאֱלִילִים כָּרות יִכָּרֵתוּן. לְתַקֵּן עולָם בְּמַלְכוּת שַׁדַּי. וְכָל בְּנֵי בָשר יִקְרְאוּ בִשְׁמֶךָ לְהַפְנות אֵלֶיךָ כָּל רִשְׁעֵי אָרֶץ. יַכִּירוּ וְיֵדְעוּ כָּל יושְׁבֵי תֵבֵל. כִּי לְךָ תִּכְרַע כָּל בֶּרֶךְ. תִּשָּׁבַע כָּל לָשׁון. לְפָנֶיךָ ה' אֱלהֵינוּ יִכְרְעוּ וְיִפּלוּ. וְלִכְבוד שִׁמְךָ יְקָר יִתֵּנוּ. וִיקַבְּלוּ כֻלָּם אֶת על מַלְכוּתֶךָ. וְתִמְלךְ עֲלֵיהֶם מְהֵרָה לְעולָם וָעֶד. כִּי הַמַּלְכוּת שֶׁלְּךָ הִיא וּלְעולְמֵי עַד תִּמְלךְ בְּכָבוד. כַּכָּתוּב בְּתורָתֶךָ. ה' יִמְלךְ לְעולָם וָעֶד: וְנֶאֱמַר. וְהָיָה ה' לְמֶלֶךְ עַל כָּל הָאָרֶץ. בַּיּום הַהוּא יִהְיֶה ה' אֶחָד וּשְׁמו אֶחָד.<br /><br />"];
	}else{
        alainu = @"";
	}
    
    //
    //
    //
    
	NSString * html = [NSString stringWithFormat:@"<html><head><title></title><style> * {line-height: %@em; } #ana span{display: block; clear: both; text-align: left; font-size: 0.45em; font-weight:bold; line-height: 1.1em;}</style><body style='direction: rtl; background-color: transparent; font-size: %@px; font-family: \"%@\"; text-align: justify; '>%@ %@ <h3>%@</h3> %@ <br /> %@ %@ %@<br /><br />%@</body></html>", kLineHeight, kFontSize, kFontStyle,leshaim, bracha, omer, harachaman, lamnaztaiach, ana, ribono, alainu];
    
    return html;

}


//
//
//

- (NSString *)dayStringInHebrew:(NSInteger)tempDay{
    
    NSMutableString * kNusachPrefixString = [NSMutableString stringWithFormat:@""];
	
    //
    //  Choose the "beiz" or "lamed" depending on
    //  the user's nusach
    //
	
    if(kNusach == YES){
		kNusachPrefixString =  [NSMutableString stringWithFormat:@"ב"];
	}else{
		kNusachPrefixString = [NSMutableString stringWithFormat:@"ל"];
	}
    
    NSArray *strings = [NSArray  arrayWithObjects:[NSString stringWithFormat:@"היום יום אחד %@עומר", kNusachPrefixString],
                        [NSString stringWithFormat:@"היום שני ימים %@עומר", kNusachPrefixString],
                        [NSString stringWithFormat:@"היום שלשה ימים %@עומר", kNusachPrefixString],
                        [NSString stringWithFormat:@"היום ארבעה ימים %@עומר", kNusachPrefixString],
                        [NSString stringWithFormat:@"היום חמשה ימים %@עומר", kNusachPrefixString],
                        [NSString stringWithFormat:@"היום ששה ימים %@עומר", kNusachPrefixString],
                        [NSString stringWithFormat:@"היום שבעה ימים שהם שבוע אחד %@עומר", kNusachPrefixString],          //7
                        [NSString stringWithFormat:@"היום שמונה ימים שהם שבוע אחד ויום אחד %@עומר", kNusachPrefixString],         //8
                        [NSString stringWithFormat:@"היום תשעה ימים שהם שבוע אחד ושני ימים %@עומר", kNusachPrefixString],         //9
                        [NSString stringWithFormat:@"היום עשרה ימים שהם שבוע אחד ושלשה ימים %@עומר", kNusachPrefixString],       //10
                        [NSString stringWithFormat:@"היום אחד עשר יום שהם שבוע אחד וארבעה ימים %@עומר", kNusachPrefixString],     //11
                        [NSString stringWithFormat:@"היום שנים עשר יום שהם שבוע אחד וחמשה ימים %@עומר", kNusachPrefixString],     //12
                        [NSString stringWithFormat:@"היום שלשה עשר יום שהם שבוע אחד וששה ימים %@עומר", kNusachPrefixString],     //13
                        [NSString stringWithFormat:@"היום ארבעה עשר יום שהם שני שבועות %@עומר", kNusachPrefixString],       //14
                        [NSString stringWithFormat:@"היום חמשה עשר יום שהם שני שבועות ויום אחד %@עומר", kNusachPrefixString],      //15
                        [NSString stringWithFormat:@"היום ששה עשר יום שהם שני שבועות ושני ימים %@עומר", kNusachPrefixString],       //16
                        [NSString stringWithFormat:@"היום שבעה עשר יום שהם שני שבועות ושלשה ימים %@עומר", kNusachPrefixString],    //17
                        [NSString stringWithFormat:@"היום שמונה עשר יום שהם שני שבועות וארבעה ימים %@עומר", kNusachPrefixString],   //18
                        [NSString stringWithFormat:@"היום תשעה עשר יום שהם שני שבועות וחמשה ימים %@עומר", kNusachPrefixString],    //19
                        [NSString stringWithFormat:@"היום עשרים יום שהם שני שבועות וששה ימים %@עומר", kNusachPrefixString],         //20
                        [NSString stringWithFormat:@"היום אחד ועשרים יום שהם שלשה שבועות %@עומר", kNusachPrefixString],       //21
                        [NSString stringWithFormat:@"היום שנים ועשרים יום שהם שלשה שבועות ויום אחד %@עומר", kNusachPrefixString],   //22
                        [NSString stringWithFormat:@"היום שלשה ועשרים יום שהם שלשה שבועות ושני ימים %@עומר", kNusachPrefixString],    //23
                        [NSString stringWithFormat:@"היום ארבעה ועשרים יום שהם שלשה שבועות ושלשה ימים %@עומר", kNusachPrefixString],  //24
                        [NSString stringWithFormat:@"היום חמשה ועשרים יום שהם שלשה שבועות וארבעה ימים %@עומר", kNusachPrefixString],  //25
                        [NSString stringWithFormat:@"היום ששה ועשרים יום שהם שלשה שבועות וחמשה ימים %@עומר", kNusachPrefixString],    //26
                        [NSString stringWithFormat:@"היום שבעה ועשרים יום שהם שלשה שבועות וששה ימים %@עומר", kNusachPrefixString],    //27
                        [NSString stringWithFormat:@"היום שמונה ועשרים יום שהם ארבעה שבועות %@עומר", kNusachPrefixString],    //28
                        [NSString stringWithFormat:@"היום תשעה ועשרים יום שהם ארבעה שבועות ויום אחד %@עומר", kNusachPrefixString],     //29
                        [NSString stringWithFormat:@"היום שלשים יום שהם ארבעה שבועות ושני ימים %@עומר", kNusachPrefixString],         //30
                        [NSString stringWithFormat:@"היום אחד ושלשים יום שהם ארבעה שבועות ושלשה ימים %@עומר", kNusachPrefixString],   //31
                        [NSString stringWithFormat:@"היום שנים ושלשים יום שהם ארבעה שבועות וארבעה ימים %@עומר", kNusachPrefixString],  //32
                        [NSString stringWithFormat:@"היום שלשה ושלשים יום שהם ארבעה שבועות וחמשה ימים %@עומר", kNusachPrefixString],  //33
                        [NSString stringWithFormat:@"היום ארבעה ושלשים יום שהם ארבעה שבועות וששה ימים %@עומר", kNusachPrefixString],  //34
                        [NSString stringWithFormat:@"היום חמשה ושלשים יום שהם חמשה שבועות %@עומר", kNusachPrefixString], //35
                        [NSString stringWithFormat:@"היום ששה ושלשים יום שהם חמשה שבועות ויום אחד %@עומר", kNusachPrefixString],      //36
                        [NSString stringWithFormat:@"היום שבעה ושלשים יום שהם חמשה שבועות ושני ימים %@עומר", kNusachPrefixString],    //37
                        [NSString stringWithFormat:@"היום שמונה ושלשים יום שהם חמשה שבועות ושלשה ימים %@עומר", kNusachPrefixString],  //38
                        [NSString stringWithFormat:@"היום תשעה ושלשים יום שהם חמשה שבועות וארבעה ימים %@עומר", kNusachPrefixString],  //39
                        [NSString stringWithFormat:@"היום ארבעים יום שהם חמשה שבועות וחמשה ימים %@עומר", kNusachPrefixString],       //40
                        [NSString stringWithFormat:@"היום אחד וארבעים יום שהם חמשה שבועות וששה ימים %@עומר", kNusachPrefixString],    //41
                        [NSString stringWithFormat:@"היום שנים וארבעים יום שהם ששה שבועות %@עומר", kNusachPrefixString],      //42
                        [NSString stringWithFormat:@"היום שלשה וארבעים יום שהם ששה שבועות ויום אחד %@עומר", kNusachPrefixString],     //43
                        [NSString stringWithFormat:@"היום ארבעה וארבעים יום שהם ששה שבועות ושני ימים %@עומר", kNusachPrefixString],     //44
                        [NSString stringWithFormat:@"היום חמשה וארבעים יום שהם ששה שבועות ושלשה ימים %@עומר", kNusachPrefixString],    //45
                        [NSString stringWithFormat:@"היום ששה וארבעים יום שהם ששה שבועות וארבעה ימים %@עומר", kNusachPrefixString],   //46
                        [NSString stringWithFormat:@"היום שבעה וארבעים יום שהם ששה שבועות וחמשה ימים %@עומר", kNusachPrefixString],   //47
                        [NSString stringWithFormat:@"היום שמונה וארבעים יום שהם ששה שבועות וששה ימים %@עומר", kNusachPrefixString],    //48
                        [NSString stringWithFormat:@"היום תשעה וארבעים יום שהם שבעה שבועות %@עומר", kNusachPrefixString],
                        nil];
    
    if (tempDay > 0) {
        return [strings objectAtIndex:day-1];
    }else{ 
        return @" ";
    }
}

//
//
//

- (NSString *)middahStringInHebrew:(NSInteger)tempDay{
    
    //
    //  TODO: refactor this so that it doesn't
    //  require this whole nasty checking logic...
    //
    
	NSArray * middah = [[NSArray alloc] initWithObjects: @"חֶסֶד", @"גְבוּרָה", @"תִּפֶרֶאת", @"נ‎‎ֶ‎צַח", @"הוֹד", @"יְסֹוד", @"מַלְכוּת" , nil];
	NSString *firstPartOfMiddah;
	NSString *secondPartOfMiddah;
	
    
	//NSLog(@"Day: %i", day);
	if(tempDay % 7 != 0){
		//NSLog(@"First part - day is not perfectly divisible by seven.");
		firstPartOfMiddah = [NSString stringWithFormat: @"%@", [middah objectAtIndex: (tempDay % 7 - 1)]];
	}else{
		if(tempDay == 49){
			firstPartOfMiddah = [NSString stringWithFormat: @"%@", [middah objectAtIndex: 6]];
		}else{
			//NSLog(@"First part - perfectly divisible by seven... now what?!");
			//NSLog(@"%i Days remainder", day % 7);
			firstPartOfMiddah = [NSString stringWithFormat: @"%@", [middah objectAtIndex: (tempDay % 7)]];
		}
	}
	
	if(tempDay == 49){
		secondPartOfMiddah = [NSString stringWithFormat: @"%@", [middah objectAtIndex: 6]];
	}else{
		//
        //NSLog(@"Week #%i", tempDay / 7);
		secondPartOfMiddah = [NSString stringWithFormat: @"%@", [middah objectAtIndex: (tempDay / 7)]];
	}
    
	NSString * middahStr = [NSString stringWithFormat:@"%@ שֶׁבְּ%@", firstPartOfMiddah, secondPartOfMiddah];
    
    
	[middah release];
	
	return middahStr;
}




@end
