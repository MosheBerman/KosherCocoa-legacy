//
//  SefiraString.m
//  UltimateOmer2
//
//  Created by Moshe Berman on 3/21/11.
//  Copyright 2011 MosheBerman.com. All rights reserved.
//

#import "SefiraString.h"
#import "Constants.h"

#ifndef kShowBracha
#define kShowBracha YES
#endif

#ifndef kShowLeshaimYichud
#define kShowLeshaimYichud YES
#endif

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
		alainu = [NSString stringWithFormat:@" <h2 style='display: inline; '>עָלֵינוּ</h2> לְשַׁבֵּחַ לַאֲדון הַכּל. לָתֵת גְּדֻלָּה לְיוצֵר בְּרֵאשִׁית. שֶׁלּא עָשנוּ כְּגויֵי הָאֲרָצות. וְלא שמָנוּ כְּמִשְׁפְּחות הָאֲדָמָה. שֶׁלּא שם חֶלְקֵנוּ כָּהֶם וְגורָלֵנוּ כְּכָל הֲמונָם. שֶׁהֵם מִשְׁתַּחֲוִים לְהֶבֶל וָרִיק וּמִתְפַּלְלִים אֶל אֵל לא יושִׁיעַ וַאֲנַחְנוּ כּורְעִים וּמִשְׁתַּחֲוִים וּמודִים לִפְנֵי מֶלֶךְ מַלְכֵי הַמְּלָכִים הַקָּדושׁ בָּרוּךְ הוּא. שֶׁהוּא נוטֶה שָׁמַיִם וְיוסֵד אָרֶץ. וּמושַׁב יְקָרו בַּשָּׁמַיִם מִמַּעַל. וּשְׁכִינַת עֻזּו בְּגָבְהֵי מְרומִים. הוּא אֱלהֵינוּ אֵין עוד. אֱמֶת מַלְכֵּנוּ. אֶפֶס זוּלָתו. כַּכָּתוּב בְּתורָתו. וְיָדַעְתָּ הַיּום וַהֲשֵׁבתָ אֶל לְבָבֶךָ. כִּי ה' הוּא הָאֱלהִים בַּשָּׁמַיִם מִמַּעַל וְעַל הָאָרֶץ מִתָּחַת. אֵין עוד:<br /><h2 style='display: inline; '>וְעַל כֵּן</h2> נְקַוֶּה לְּךָ ה' אֱלהֵינוּ לִרְאות מְהֵרָה בְּתִפְאֶרֶת עֻזֶּךָ. לְהַעֲבִיר גִּלּוּלִים מִן הָאָרֶץ. וְהָאֱלִילִים כָּרות יִכָּרֵתוּן. לְתַקֵּן עולָם בְּמַלְכוּת שַׁדַּי. וְכָל בְּנֵי בָשר יִקְרְאוּ בִשְׁמֶךָ לְהַפְנות אֵלֶיךָ כָּל רִשְׁעֵי אָרֶץ. יַכִּירוּ וְיֵדְעוּ כָּל יושְׁבֵי תֵבֵל. כִּי לְךָ תִּכְרַע כָּל בֶּרֶךְ. תִּשָּׁבַע כָּל לָשׁון. לְפָנֶיךָ ה' אֱלהֵינוּ יִכְרְעוּ וְיִפּלוּ. וְלִכְבוד שִׁמְךָ יְקָר יִתֵּנוּ. וִיקַבְּלוּ כֻלָּם אֶת על מַלְכוּתֶךָ. וְתִמְלךְ עֲלֵיהֶם מְהֵרָה לְעולָם וָעֶד. כִּי הַמַּלְכוּת שֶׁלְּךָ הִיא וּלְעולְמֵי עַד תִּמְלךְ בְּכָבוד. כַּכָּתוּב בְּתורָתֶךָ. ה' יִמְלךְ לְעולָם וָעֶד: וְנֶאֱמַר. וְהָיָה ה' לְמֶלֶךְ עַל כָּל הָאָרֶץ. בַּיּום הַהוּא יִהְיֶה ה' אֶחָד וּשְׁמו אֶחָד.<br /><br />"];
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
//  Return a Nusach Ashkenaz or Sefard (not sefardi) string for the day
//

- (NSString *)dayStringInHebrew:(NSInteger)tempDay{
    
    NSMutableString * kNusachPrefixString;    

    //
    //  Choose the "beiz" or "lamed" depending on
    //  the user's nusach
    //
	
    if(kNusach == YES){
		kNusachPrefixString =  [NSMutableString stringWithFormat:@"בְּ"];
	}else{
		kNusachPrefixString = [NSMutableString stringWithFormat:@"לָ"];
	}
    
    NSArray *strings = [NSArray  arrayWithObjects:[NSString stringWithFormat:@"הַיוֹם יוֹם אֶחָד %@עוֹמֶר", kNusachPrefixString],
                        [NSString stringWithFormat:@"הַיוֹם שְׁנֵי יָמִים %@עוֹמֶר", kNusachPrefixString],
                        [NSString stringWithFormat:@"הַיוֹם שְׁלֹשָׁה יָמִים %@עוֹמֶר", kNusachPrefixString],
                        [NSString stringWithFormat:@"הַיוֹם אַרְבָּעָה יָמִים %@עוֹמֶר", kNusachPrefixString],
                        [NSString stringWithFormat:@"הַיוֹם חַמִשָׁה יָמִים %@עוֹמֶר", kNusachPrefixString],
                        [NSString stringWithFormat:@"הַיוֹם שִׁשָׁה יָמִים %@עוֹמֶר", kNusachPrefixString],
                        [NSString stringWithFormat:@"הַיוֹם שׁבְעָה יָמִים שֶׁהֵם שׁבוּעַ אֶחָד %@עוֹמֶר", kNusachPrefixString],          //7
                        [NSString stringWithFormat:@"הַיוֹם שְׁמוֹנָה יָמִים שֶׁהֵם שׁבוּעַ אֶחָד וְיוֹם אֶחָד %@עוֹמֶר", kNusachPrefixString],         //8
                        [NSString stringWithFormat:@"הַיוֹם תּשְׁעָה יָמִים שֶׁהֵם שׁבוּעַ אֶחָד וּשְׁנֵי יָמִים %@עוֹמֶר", kNusachPrefixString],         //9
                        [NSString stringWithFormat:@"הַיוֹם עֵָשָׂרה יָמִים שֶׁהֵם שׁבוּעַ אֶחָד וּשְׁלֹשָׁה יָמִים %@עוֹמֶר", kNusachPrefixString],       //10
                        [NSString stringWithFormat:@"הַיוֹם אֶחָד עֵָשָׂר יוֹם שֶׁהֵם שׁבוּעַ אֶחָד ואַרְבָּעָה יָמִים %@עוֹמֶר", kNusachPrefixString],     //11
                        [NSString stringWithFormat:@"הַיוֹם שְׁנַיִם עֵָשָׂר יוֹם שֶׁהֵם שׁבוּעַ אֶחָד וַחַמִשָׁה יָמִים %@עוֹמֶר", kNusachPrefixString],     //12
                        [NSString stringWithFormat:@"הַיוֹם שְׁלֹשָׁה עֵָשָׂר יוֹם שֶׁהֵם שׁבוּעַ אֶחָד ושִׁשָׁה יָמִים %@עוֹמֶר", kNusachPrefixString],     //13
                        [NSString stringWithFormat:@"הַיוֹם אַרְבָּעָה עֵָשָׂר יוֹם שֶׁהֵם שְׁנֵי שָׁבוּעוֹת %@עוֹמֶר", kNusachPrefixString],       //14
                        [NSString stringWithFormat:@"הַיוֹם חַמִשָׁה עֵָשָׂר יוֹם שֶׁהֵם שְׁנֵי שָׁבוּעוֹת וְיוֹם אֶחָד %@עוֹמֶר", kNusachPrefixString],      //15
                        [NSString stringWithFormat:@"הַיוֹם שִׁשָׁה עֵָשָׂר יוֹם שֶׁהֵם שְׁנֵי שָׁבוּעוֹת וּשְׁנֵי יָמִים %@עוֹמֶר", kNusachPrefixString],       //16
                        [NSString stringWithFormat:@"הַיוֹם שׁבְעָה עֵָשָׂר יוֹם שֶׁהֵם שְׁנֵי שָׁבוּעוֹת וּשְׁלֹשָׁה יָמִים %@עוֹמֶר", kNusachPrefixString],    //17
                        [NSString stringWithFormat:@"הַיוֹם שְׁמוֹנָה עֵָשָׂר יוֹם שֶׁהֵם שְׁנֵי שָׁבוּעוֹת ואַרְבָּעָה יָמִים %@עוֹמֶר", kNusachPrefixString],   //18
                        [NSString stringWithFormat:@"הַיוֹם תּשְׁעָה עֵָשָׂר יוֹם שֶׁהֵם שְׁנֵי שָׁבוּעוֹת וַחַמִשָׁה יָמִים %@עוֹמֶר", kNusachPrefixString],    //19
                        [NSString stringWithFormat:@"הַיוֹם עֵָשָׂרִים יוֹם שֶׁהֵם שְׁנֵי שָׁבוּעוֹת ושִׁשָׁה יָמִים %@עוֹמֶר", kNusachPrefixString],         //20
                        [NSString stringWithFormat:@"הַיוֹם אֶחָד וְעֶשְׂרִים יוֹם שֶׁהֵם שְׁלֹשָׁה שָׁבוּעוֹת %@עוֹמֶר", kNusachPrefixString],       //21
                        [NSString stringWithFormat:@"הַיוֹם שְׁנַיִם וְעֶשְׂרִים יוֹם שֶׁהֵם שְׁלֹשָׁה שָׁבוּעוֹת וְיוֹם אֶחָד %@עוֹמֶר", kNusachPrefixString],   //22
                        [NSString stringWithFormat:@"הַיוֹם שְׁלֹשָׁה וְעֶשְׂרִים יוֹם שֶׁהֵם שְׁלֹשָׁה שָׁבוּעוֹת וּשְׁנֵי יָמִים %@עוֹמֶר", kNusachPrefixString],    //23
                        [NSString stringWithFormat:@"הַיוֹם אַרְבָּעָה וְעֶשְׂרִים יוֹם שֶׁהֵם שְׁלֹשָׁה שָׁבוּעוֹת וּשְׁלֹשָׁה יָמִים %@עוֹמֶר", kNusachPrefixString],  //24
                        [NSString stringWithFormat:@"הַיוֹם חַמִשָׁה וְעֶשְׂרִים יוֹם שֶׁהֵם שְׁלֹשָׁה שָׁבוּעוֹת ואַרְבָּעָה יָמִים %@עוֹמֶר", kNusachPrefixString],  //25
                        [NSString stringWithFormat:@"הַיוֹם שִׁשָׁה וְעֶשְׂרִים יוֹם שֶׁהֵם שְׁלֹשָׁה שָׁבוּעוֹת וַחַמִשָׁה יָמִים %@עוֹמֶר", kNusachPrefixString],    //26
                        [NSString stringWithFormat:@"הַיוֹם שׁבְעָה וְעֶשְׂרִים יוֹם שֶׁהֵם שְׁלֹשָׁה שָׁבוּעוֹת ושִׁשָׁה יָמִים %@עוֹמֶר", kNusachPrefixString],    //27
                        [NSString stringWithFormat:@"הַיוֹם שְׁמוֹנָה וְעֶשְׂרִים יוֹם שֶׁהֵם אַרְבָּעָה שָׁבוּעוֹת %@עוֹמֶר", kNusachPrefixString],    //28
                        [NSString stringWithFormat:@"הַיוֹם תּשְׁעָה וְעֶשְׂרִים יוֹם שֶׁהֵם אַרְבָּעָה שָׁבוּעוֹת וְיוֹם אֶחָד %@עוֹמֶר", kNusachPrefixString],     //29
                        [NSString stringWithFormat:@"הַיוֹם שְׁלֹשִׁים יוֹם שֶׁהֵם אַרְבָּעָה שָׁבוּעוֹת וּשְׁנֵי יָמִים %@עוֹמֶר", kNusachPrefixString],         //30
                        [NSString stringWithFormat:@"הַיוֹם אֶחָד וּשְׁלֹשִׁים יוֹם שֶׁהֵם אַרְבָּעָה שָׁבוּעוֹת וּשְׁלֹשָׁה יָמִים %@עוֹמֶר", kNusachPrefixString],   //31
                        [NSString stringWithFormat:@"הַיוֹם שְׁנַיִם וּשְׁלֹשִׁים יוֹם שֶׁהֵם אַרְבָּעָה שָׁבוּעוֹת ואַרְבָּעָה יָמִים %@עוֹמֶר", kNusachPrefixString],  //32
                        [NSString stringWithFormat:@"הַיוֹם שְׁלֹשָׁה וּשְׁלֹשִׁים יוֹם שֶׁהֵם אַרְבָּעָה שָׁבוּעוֹת וַחַמִשָׁה יָמִים %@עוֹמֶר", kNusachPrefixString],  //33
                        [NSString stringWithFormat:@"הַיוֹם אַרְבָּעָה וּשְׁלֹשִׁים יוֹם שֶׁהֵם אַרְבָּעָה שָׁבוּעוֹת ושִׁשָׁה יָמִים %@עוֹמֶר", kNusachPrefixString],  //34
                        [NSString stringWithFormat:@"הַיוֹם חַמִשָׁה וּשְׁלֹשִׁים יוֹם שֶׁהֵם חַמִשָׁה שָׁבוּעוֹת %@עוֹמֶר", kNusachPrefixString], //35
                        [NSString stringWithFormat:@"הַיוֹם שִׁשָׁה וּשְׁלֹשִׁים יוֹם שֶׁהֵם חַמִשָׁה שָׁבוּעוֹת וְיוֹם אֶחָד %@עוֹמֶר", kNusachPrefixString],      //36
                        [NSString stringWithFormat:@"הַיוֹם שׁבְעָה וּשְׁלֹשִׁים יוֹם שֶׁהֵם חַמִשָׁה שָׁבוּעוֹת וּשְׁנֵי יָמִים %@עוֹמֶר", kNusachPrefixString],    //37
                        [NSString stringWithFormat:@"הַיוֹם שְׁמוֹנָה וּשְׁלֹשִׁים יוֹם שֶׁהֵם חַמִשָׁה שָׁבוּעוֹת וּשְׁלֹשָׁה יָמִים %@עוֹמֶר", kNusachPrefixString],  //38
                        [NSString stringWithFormat:@"הַיוֹם תּשְׁעָה וּשְׁלֹשִׁים יוֹם שֶׁהֵם חַמִשָׁה שָׁבוּעוֹת ואַרְבָּעָה יָמִים %@עוֹמֶר", kNusachPrefixString],  //39
                        [NSString stringWithFormat:@"הַיוֹם אַרְבָּעִים יוֹם שֶׁהֵם חַמִשָׁה שָׁבוּעוֹת וַחַמִשָׁה יָמִים %@עוֹמֶר", kNusachPrefixString],       //40
                        [NSString stringWithFormat:@"הַיוֹם אֶחָד וְאַרְבָּעִים יוֹם שֶׁהֵם חַמִשָׁה שָׁבוּעוֹת ושִׁשָׁה יָמִים %@עוֹמֶר", kNusachPrefixString],    //41
                        [NSString stringWithFormat:@"הַיוֹם שְׁנַיִם וְאַרְבָּעִים יוֹם שֶׁהֵם שִׁשָׁה שָׁבוּעוֹת %@עוֹמֶר", kNusachPrefixString],      //42
                        [NSString stringWithFormat:@"הַיוֹם שְׁלֹשָׁה וְאַרְבָּעִים יוֹם שֶׁהֵם שִׁשָׁה שָׁבוּעוֹת וְיוֹם אֶחָד %@עוֹמֶר", kNusachPrefixString],     //43
                        [NSString stringWithFormat:@"הַיוֹם אַרְבָּעָה וְאַרְבָּעִים יוֹם שֶׁהֵם שִׁשָׁה שָׁבוּעוֹת וּשְׁנֵי יָמִים %@עוֹמֶר", kNusachPrefixString],     //44
                        [NSString stringWithFormat:@"הַיוֹם חַמִשָׁה וְאַרְבָּעִים יוֹם שֶׁהֵם שִׁשָׁה שָׁבוּעוֹת וּשְׁלֹשָׁה יָמִים %@עוֹמֶר", kNusachPrefixString],    //45
                        [NSString stringWithFormat:@"הַיוֹם שִׁשָׁה וְאַרְבָּעִים יוֹם שֶׁהֵם שִׁשָׁה שָׁבוּעוֹת ואַרְבָּעָה יָמִים %@עוֹמֶר", kNusachPrefixString],   //46
                        [NSString stringWithFormat:@"הַיוֹם שׁבְעָה וְאַרְבָּעִים יוֹם שֶׁהֵם שִׁשָׁה שָׁבוּעוֹת וַחַמִשָׁה יָמִים %@עוֹמֶר", kNusachPrefixString],   //47
                        [NSString stringWithFormat:@"הַיוֹם שְׁמוֹנָה וְאַרְבָּעִים יוֹם שֶׁהֵם שִׁשָׁה שָׁבוּעוֹת ושִׁשָׁה יָמִים %@עוֹמֶר", kNusachPrefixString],    //48
                        [NSString stringWithFormat:@"הַיוֹם תּשְׁעָה וְאַרְבָּעִים יוֹם שֶׁהֵם שׁבְעָה שָׁבוּעוֹת %@עוֹמֶר", kNusachPrefixString],
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
    
    //NSArray * middah = [[NSArray alloc] initWithObjects: @"חֶסֶד", @"גְבוּרָה", @"תִּפֶארֶת", @"נ‎‎ֶ‎צַח", @"הוֹד", @"יְסֹוד", @"מַלְכוּת" , nil];
	
    //return [NSString stringWithFormat:@"%@ שֶבְּ%@",[middah objectAtIndex:tempDay%7], [middah objectAtIndex:tempDay/7]];
    
    NSArray *middahs = [NSArray arrayWithObjects:@"חֶסֶד שֶבְּחֶסֶד", @"גְבוּרָה שֶבְּחֶסֶד", @"תִּפֶארֶת שֶבְּחֶסֶד",
                        @"נ‎‎ֶ‎צַח שֶבְּחֶסֶד", @"הוֹד שֶבְּחֶסֶד", @"יְסֹוד שֶבְּחֶסֶד", @"מַלְכוּת שֶבְּחֶסֶד", @"חֶסֶד שֶבְּגְבוּרָה", 
                        @"גְבוּרָה שֶבְּגְבוּרָה", @"תִּפֶארֶת שֶבְּגְבוּרָה", @"נ‎‎ֶ‎צַח שֶבְּגְבוּרָה", @"הוֹד שֶבְּגְבוּרָה", @"יְסֹוד שֶבְּגְבוּרָה",
                        @"מַלְכוּת שֶבְּגְבוּרָה", @"חֶסֶד שֶבְּתִּפֶארֶת", @"גְבוּרָה שֶבְּתִּפֶארֶת", @"תִּפֶארֶת שֶבְּתִּפֶארֶת", @"נ‎‎ֶ‎צַח שֶבְּתִּפֶארֶת",
                        @"הוֹד שֶבְּתִּפֶארֶת", @"יְסֹוד שֶבְּתִּפֶארֶת", @"מַלְכוּת שֶבְּתִּפֶארֶת", @"חֶסֶד שֶבְּנ‎‎ֶ‎צַח", @"גְבוּרָה שֶבְּנ‎‎ֶ‎צַח", 
                        @"תִּפֶארֶת שֶבְּנ‎‎ֶ‎צַח", @"נ‎‎ֶ‎צַח שֶבְּנ‎‎ֶ‎צַח", @"הוֹד שֶבְּנ‎‎ֶ‎צַח", @"יְסֹוד שֶבְּנ‎‎ֶ‎צַח", @"מַלְכוּת שֶבְּנ‎‎ֶ‎צַח", @"חֶסֶד שֶבְּהוֹד",
                        @"גְבוּרָה שֶבְּהוֹד", @"תִּפֶארֶת שֶבְּהוֹד", @"נ‎‎ֶ‎צַח שֶבְּהוֹד", @"הוֹד שֶבְּהוֹד", @"יְסֹוד שֶבְּהוֹד", @"מַלְכוּת שֶבְּהוֹד",
                        @"חֶסֶד שֶבְּיְסֹוד", @"גְבוּרָה שֶבְּיְסֹוד", @"תִּפֶארֶת שֶבְּיְסֹוד", @"נ‎‎ֶ‎צַח שֶבְּיְסֹוד", @"הוֹד שֶבְּיְסֹוד", @"יְסֹוד שֶבְּיְסֹוד",
                        @"מַלְכוּת שֶבְּיְסֹוד", @"חֶסֶד שֶבְּמַלְכוּת", @"גְבוּרָה שֶבְּמַלְכוּת", @"תִּפֶארֶת שֶבְּמַלְכוּת", @"נ‎‎ֶ‎צַח שֶבְּמַלְכוּת", 
                        @"הוֹד שֶבְּמַלְכוּת", @"יְסֹוד שֶבְּמַלְכוּת", @"מַלְכוּת שֶבְּמַלְכוּת",  nil];
    
    return [middahs objectAtIndex:tempDay-1];
    
    /*
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
    */
}




@end
