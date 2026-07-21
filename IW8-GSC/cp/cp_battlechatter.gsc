/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_battlechatter.gsc
***********************************************/

manualinitbattlechatter() {
  if(scripts\engine\utility::flag_exist("_encstr_A2D20FE4880D52A426C867576878654BD3"))
    scripts\engine\utility::flag_wait_all("_encstr_A2D20FE4880D52A426C867576878654BD3", "_encstr_A65211EB562BA098E71253B95ABB589043B525");

  if(!isDefined(anim.chatinitialized)) {
    anim.player = getEntArray("_encstr_8BB007E03658CBCAE4", "_encstr_AC110A7F14873B5B3D073009")[0];

    while(!isDefined(anim.player)) {
      anim.player = getEntArray("_encstr_8BB007E03658CBCAE4", "_encstr_AC110A7F14873B5B3D073009")[0];
      wait 5;
    }
  }

  if(!isDefined(anim.player.team))
    anim.player.team = "_encstr_9A8507BA4040188D08";

  level._battlechatter = spawnStruct();
  level._battlechatter.fnevaluatemoveevent = scripts\cp\cp_battlechatter_ai::evaluatemoveevent;
  level._battlechatter.fnevaluatereloadevent = scripts\cp\cp_battlechatter_ai::evaluatereloadevent;
  level._battlechatter.fnaddthreatevent = scripts\cp\cp_battlechatter_ai::addthreatevent;
  level._battlechatter.fnevaluateattackevent = scripts\cp\cp_battlechatter_ai::evaluateattackevent;
  level._battlechatter.fnplaybattlechatter = ::playbattlechatter;
  _encstr_842518E6D8395A38A3B9BC0B73B4AD5EB9862CE4AC8CE23BDC1B::init_squadmanager();
  init_battlechatter();
  scripts\cp\cp_playerchatter::init_playerchatter();
  anim thread bcsdebugwaiter();
  scripts\cp\utility::battlechatter_on("_encstr_8E8405EA382B2A");
}

init_battlechatter() {
  if(isDefined(anim.chatinitialized) && anim.chatinitialized) {
    return;
  }
  setdvarifuninitialized("_encstr_BEFC0B0DAB1A390D03A2E128CA", 1);

  if(getdvarint("_encstr_BEFC0B0DAB1A390D03A2E128CA") == 0) {
    anim.chatinitialized = 0;
    anim.player.chatinitialized = 0;
    return;
  }

  anim.bcs_enabled = 0;
  anim.chatinitialized = 1;
  anim.player.chatinitialized = 0;

  if(!isDefined(level.friendlyfire_warnings))
    level.friendlyfire_warnings = 1;

  setdvarifuninitialized("_encstr_B86D11F553F2D11487DA9BA123ABDB708FA951", "_encstr_BA19049F4B2D");
  setdvarifuninitialized("_encstr_A69511EE832F0E25B43258282B44FDE1873AE1", "_encstr_BA19049F4B2D");
  setdvarifuninitialized("_encstr_957110551FA338A8C9BD2319228740EDBA33", "_encstr_BA19049F4B2D");
  setdvarifuninitialized("_encstr_9B4A134B1FA060F7089D634BCE13AF21F719C0488D", "_encstr_BA19049F4B2D");
  setdvarifuninitialized("_encstr_9A8D13898DE6F599B48DD12B39A4B2DC83DEE6E6AC", "_encstr_BA19049F4B2D");
  setdvarifuninitialized("_encstr_934E0F96CB67466FAB5A59688286317BA3", "_encstr_AF1904A7F929");
  setdvarifuninitialized("_encstr_A2140ED2994E8725A0D55377FB386E93", "_encstr_BA19049F4B2D");
  setdvarifuninitialized("_encstr_ACCE11131B37AFCCDB396C5654733BB1D23734", "_encstr_BA19049F4B2D");
  setdvarifuninitialized("_encstr_B6461BDB66A3E95071EB4083674F25FD65F55B710F5AA37F796D206F6A", "_encstr_BA19049F4B2D");
  setdvarifuninitialized("_encstr_83071206F19BC7A2385337FFAD550A22B9D8BF8F", "_encstr_B40101");
  setdvarifuninitialized("_encstr_86F11298C637F59C1619D2DEAC6CD0DEAFED33CC", "_encstr_B40101");
  setdvarifuninitialized("_encstr_88BC0EFC193A539C31217072A5B05BBC", "_encstr_BA19049F4B2D");
  setdvarifuninitialized("_encstr_BAC4147FE778CB47F1E6812B92044503A00306C7A740", "_encstr_BA19049F4B2D");
  setdvarifuninitialized("_encstr_844F1299C772ED603FFE017BE2E1E0A5EA6F1339", "_encstr_BA19049F4B2D");
  setdvarifuninitialized("_encstr_BD7616AC03D8934F7891D2EBBB4BB30B23DB2D2089B89A0F", "_encstr_AC190457E313");
  setdvarifuninitialized("_encstr_BE741267D1680D02C0ADEF9781F04B4188B95BAF", "_encstr_BA19049F4B2D");
  anim.bcprintfailprefix = "_encstr_AF4516DE0F028272F234203D2E6E7EC5E36F74D1A54D2D0F";
  anim.bcprintwarnprefix = "_encstr_A93216981B0C40CDAA120901DBE706CFE909E46B23694AEE";
  bcs_setup_teams_array();
  bcs_setup_countryids();
  anim.playernameids["_encstr_8A390E2F88D07452C1384E0393EFDA3B"] = "_encstr_A34C02BB";
  anim.playernameids["_encstr_BAA814DBED11D8CDC2335371075A8058B88760505754"] = "_encstr_A34C02BB";
  anim.playernameids["_encstr_AF5E14AB37A5A3AC237316E82DB737B96659AD851B95"] = "_encstr_A34C02BB";
  anim.playernameids["_encstr_8BD90D13804B3C120DDFE3AFC9A53B"] = "_encstr_A34C02BB";
  anim.playernameids["_encstr_A67A134BD0ABF37F08D74C21A17882F3C528826219"] = "_encstr_A34C02BB";
  anim.playernameids["_encstr_9A01098842DA4B0317F42F"] = "_encstr_A34C02BB";
  anim.playernameids["_encstr_8A500F91A5B1C8FDDA631B2D7F224F687D"] = "_encstr_A34C02BB";
  anim.playernameids["_encstr_964A08F5B3EE7B335128"] = "_encstr_A34C02BB";
  anim.playernameids["_encstr_81190403AE66"] = "_encstr_A34C02BB";
  anim.playernameids["_encstr_978D0A1B20CFBFB7B0A77C6D"] = "_encstr_A34C02BB";
  anim.playernameids["_encstr_841804CCB9B0"] = "_encstr_A34C02BB";
  anim.playernameids["_encstr_A1440A8C62AA7519DD2FC0B0"] = "_encstr_A34C02BB";
  thread setplayerbcnameid();
  init_flavorbursts();
  anim.eventtypeminwait = [];
  anim.eventtypeminwait["_encstr_85CB07BDE04321538B"] = [];
  anim.eventtypeminwait["_encstr_840709B34F76BBF8F072C7"] = [];
  anim.eventtypeminwait["_encstr_8A66099C590B3647D2B79B"] = [];
  anim.eventtypeminwait["_encstr_88720627AD68179B"] = [];
  anim.eventtypeminwait["_encstr_85E507408AF3D0F005"] = [];
  anim.eventtypeminwait["_encstr_BD34078D57B9A37BD6"] = [];
  anim.eventtypeminwait["_encstr_82EB0A84EB2E13A2C073483D"] = [];
  anim.eventtypeminwait["_encstr_830E086EE82B0B361D86"] = [];

  if(isDefined(level._stealth)) {
    anim.eventactionminwait["_encstr_85CB07BDE04321538B"]["_encstr_831805DFAF3BF3"] = 20000;
    anim.eventactionminwait["_encstr_85CB07BDE04321538B"]["_encstr_8C950626C2CB5B19"] = 30000;
  } else {
    anim.eventactionminwait["_encstr_85CB07BDE04321538B"]["_encstr_831805DFAF3BF3"] = 9000;
    anim.eventactionminwait["_encstr_85CB07BDE04321538B"]["_encstr_8C950626C2CB5B19"] = 5000;
  }

  anim.eventactionminwait["_encstr_85CB07BDE04321538B"]["_encstr_95861001B70ED8F56F32705E8B37AFA02604"] = 15000;
  anim.eventactionminwait["_encstr_840709B34F76BBF8F072C7"]["_encstr_831805DFAF3BF3"] = 1400;
  anim.eventactionminwait["_encstr_840709B34F76BBF8F072C7"]["_encstr_8C950626C2CB5B19"] = 1400;
  anim.eventactionminwait["_encstr_8A66099C590B3647D2B79B"]["_encstr_831805DFAF3BF3"] = 1400;
  anim.eventactionminwait["_encstr_8A66099C590B3647D2B79B"]["_encstr_8C950626C2CB5B19"] = 1400;
  anim.eventactionminwait["_encstr_88720627AD68179B"]["_encstr_831805DFAF3BF3"] = 7000;
  anim.eventactionminwait["_encstr_88720627AD68179B"]["_encstr_8C950626C2CB5B19"] = 6000;
  anim.eventactionminwait["_encstr_85E507408AF3D0F005"]["_encstr_831805DFAF3BF3"] = 4000;
  anim.eventactionminwait["_encstr_85E507408AF3D0F005"]["_encstr_8C950626C2CB5B19"] = 6000;
  anim.eventactionminwait["_encstr_BD34078D57B9A37BD6"]["_encstr_831805DFAF3BF3"] = 0;
  anim.eventactionminwait["_encstr_BD34078D57B9A37BD6"]["_encstr_8C950626C2CB5B19"] = 0;
  anim.eventactionminwait["_encstr_830E086EE82B0B361D86"]["_encstr_831805DFAF3BF3"] = 9000;
  anim.eventactionminwait["_encstr_830E086EE82B0B361D86"]["_encstr_8C950626C2CB5B19"] = 5000;
  anim.eventactionminwait["_encstr_830E086EE82B0B361D86"]["_encstr_95861001B70ED8F56F32705E8B37AFA02604"] = 45000;
  anim.eventtypeminwait["_encstr_A9900BF17C56C0B5CB1AD940B2"] = 50000;
  anim.eventtypeminwait["_encstr_8A66099C590B3647D2B79B"]["_encstr_8A3C092767D35DE09CEBD2"] = 14000;
  anim.eventtypeminwait["_encstr_8A66099C590B3647D2B79B"]["_encstr_A54E0D719B1F05C0B7C45355F91A50"] = 5000;
  anim.eventtypeminwait["_encstr_8A66099C590B3647D2B79B"]["_encstr_81B70B13BFC78276F1108FFB10"] = 5000;
  anim.eventtypeminwait["_encstr_8A66099C590B3647D2B79B"]["_encstr_8EBB09D658CD56D5672B39"] = 4000;
  anim.eventtypeminwait["_encstr_8A66099C590B3647D2B79B"]["_encstr_B18F09518733412BAF1AA0"] = 4000;
  anim.eventtypeminwait["_encstr_8A66099C590B3647D2B79B"]["_encstr_AA580ADB1DA80886FB3AC320"] = 4000;
  anim.eventtypeminwait["_encstr_8A66099C590B3647D2B79B"]["_encstr_83A107A3F3185A4DB0"] = 4000;
  anim.eventtypeminwait["_encstr_8A66099C590B3647D2B79B"]["_encstr_A7F7070BB9D67DED6D"] = 4000;
  anim.eventtypeminwait["_encstr_8A66099C590B3647D2B79B"]["_encstr_AD2906FBFA7593E3"] = 5000;
  anim.eventtypeminwait["_encstr_85E507408AF3D0F005"]["_encstr_878B0A2323D11281F8F8551F"] = 5000;
  anim.eventtypeminwait["_encstr_85E507408AF3D0F005"]["_encstr_86B209B07AF529395F72B1"] = 4000;
  anim.eventtypeminwait["_encstr_85E507408AF3D0F005"]["_encstr_999A07C61338F9A23A"] = 5000;
  anim.eventtypeminwait["_encstr_85CB07BDE04321538B"]["_encstr_82F309E237DB1B6B6367E9"] = 7000;
  anim.eventtypeminwait["_encstr_85CB07BDE04321538B"]["_encstr_B2BC08303A77613B2FA4"] = 7000;
  anim.eventtypeminwait["_encstr_8A66099C590B3647D2B79B"]["_encstr_8EBB09D658CD56D5672B39"] = 5000;
  anim.eventtypeminwait["_encstr_8A66099C590B3647D2B79B"]["_encstr_AA580ADB1DA80886FB3AC320"] = 2000;
  anim.eventtypeminwait["_encstr_88720627AD68179B"]["_encstr_B40B07666F8BC31783"] = 5000;
  anim.eventtypeminwait["_encstr_840709B34F76BBF8F072C7"]["_encstr_A99B08D609DBE0AF2B3B"] = 7000;
  anim.eventtypeminwait["_encstr_840709B34F76BBF8F072C7"]["_encstr_AC6E09881A36337B5F6F30"] = 7000;
  anim.eventtypeminwait["_encstr_830E086EE82B0B361D86"]["_encstr_A7C5056BD931D1"] = 27500;
  anim.eventtypeminwait["_encstr_830E086EE82B0B361D86"]["_encstr_A16D0B492D908FC1D36852DB50"] = 25000;
  anim.eventtypeminwait["_encstr_830E086EE82B0B361D86"]["_encstr_BE1A0C5ADCD9569B3A96CEB0A3B2"] = 12000;
  anim.eventtypeminwait["_encstr_830E086EE82B0B361D86"]["_encstr_9ACC05B4156DF3"] = 500;
  anim.eventtypeminwait["_encstr_830E086EE82B0B361D86"]["_encstr_AA7C07466F9DA30713"] = 15000;
  anim.eventtypeminwait["_encstr_830E086EE82B0B361D86"]["_encstr_873E0AB31EF510DDDB6AF96B"] = 500;
  anim.eventtypeminwait["_encstr_830E086EE82B0B361D86"]["_encstr_813E0A9B36CD28F5F3729173"] = 3000;
  anim.eventtypeminwait["_encstr_830E086EE82B0B361D86"]["_encstr_883E0A30DAA59FEBF333E5C6"] = 3000;
  anim.eventtypeminwait["_encstr_830E086EE82B0B361D86"]["_encstr_923E0AB31EF510DDDB6AF9CB"] = 3000;
  anim.eventtypeminwait["_encstr_830E086EE82B0B361D86"]["_encstr_BE3E0AF35EB5509D9B2AB9AB"] = 3000;
  anim.eventpriority["_encstr_85CB07BDE04321538B"]["_encstr_A20C099FE504225E886B40"] = 0.6;
  anim.eventpriority["_encstr_85CB07BDE04321538B"]["_encstr_9A50080BA7292FFA0DA2"] = 0.7;
  anim.eventpriority["_encstr_85CB07BDE04321538B"]["_encstr_B2BC08303A77613B2FA4"] = 0.6;
  anim.eventpriority["_encstr_85CB07BDE04321538B"]["_encstr_82F309E237DB1B6B6367E9"] = 0.6;
  anim.eventpriority["_encstr_840709B34F76BBF8F072C7"]["_encstr_A71904605AB4"] = 0.9;
  anim.eventpriority["_encstr_840709B34F76BBF8F072C7"]["_encstr_8E2508591EE07BE6B246"] = 0.8;
  anim.eventpriority["_encstr_840709B34F76BBF8F072C7"]["_encstr_A99B08D609DBE0AF2B3B"] = 0.9;
  anim.eventpriority["_encstr_840709B34F76BBF8F072C7"]["_encstr_AC6E09881A36337B5F6F30"] = 0.9;
  anim.eventpriority["_encstr_840709B34F76BBF8F072C7"]["_encstr_8B60059536347B"] = 0.9;
  anim.eventpriority["_encstr_840709B34F76BBF8F072C7"]["_encstr_84C909D2980D8713F8F8AF"] = 0.9;
  anim.eventpriority["_encstr_840709B34F76BBF8F072C7"]["_encstr_8707037979"] = 0.9;
  anim.eventpriority["_encstr_8A66099C590B3647D2B79B"]["_encstr_8A3C092767D35DE09CEBD2"] = 0.5;
  anim.eventpriority["_encstr_8A66099C590B3647D2B79B"]["_encstr_A54E0D719B1F05C0B7C45355F91A50"] = 1.0;
  anim.eventpriority["_encstr_8A66099C590B3647D2B79B"]["_encstr_81B70B13BFC78276F1108FFB10"] = 1.0;
  anim.eventpriority["_encstr_8A66099C590B3647D2B79B"]["_encstr_8EBB09D658CD56D5672B39"] = 0.8;
  anim.eventpriority["_encstr_8A66099C590B3647D2B79B"]["_encstr_B18F09518733412BAF1AA0"] = 0.8;
  anim.eventpriority["_encstr_8A66099C590B3647D2B79B"]["_encstr_AA580ADB1DA80886FB3AC320"] = 0.8;
  anim.eventpriority["_encstr_8A66099C590B3647D2B79B"]["_encstr_83A107A3F3185A4DB0"] = 0.8;
  anim.eventpriority["_encstr_8A66099C590B3647D2B79B"]["_encstr_A7F7070BB9D67DED6D"] = 1.0;
  anim.eventpriority["_encstr_8A66099C590B3647D2B79B"]["_encstr_AD2906FBFA7593E3"] = 0.9;
  anim.eventpriority["_encstr_88720627AD68179B"]["_encstr_B40B07666F8BC31783"] = 0.3;
  anim.eventpriority["_encstr_88720627AD68179B"]["_encstr_ACA20538F84D39"] = 0.3;
  anim.eventpriority["_encstr_88720627AD68179B"]["_encstr_933609192D9B8363C2B156"] = 0.5;
  anim.eventpriority["_encstr_85E507408AF3D0F005"]["_encstr_999A07C61338F9A23A"] = 0.9;
  anim.eventpriority["_encstr_85E507408AF3D0F005"]["_encstr_8A4F099025A3B8715A6B17"] = 0.9;
  anim.eventpriority["_encstr_85E507408AF3D0F005"]["_encstr_878B0A2323D11281F8F8551F"] = 0.2;
  anim.eventpriority["_encstr_85E507408AF3D0F005"]["_encstr_8E950B26FDE7F283FFA3F77B77"] = 0.2;
  anim.eventpriority["_encstr_85E507408AF3D0F005"]["_encstr_86B209B07AF529395F72B1"] = 0.4;
  anim.eventpriority["_encstr_BD34078D57B9A37BD6"]["_encstr_979608DF73C8E70B73A1"] = 1.0;
  anim.eventpriority["_encstr_830E086EE82B0B361D86"]["_encstr_A7C5056BD931D1"] = 0.6;
  anim.eventpriority["_encstr_830E086EE82B0B361D86"]["_encstr_A16D0B492D908FC1D36852DB50"] = 0.6;
  anim.eventpriority["_encstr_830E086EE82B0B361D86"]["_encstr_BE1A0C5ADCD9569B3A96CEB0A3B2"] = 0.6;
  anim.eventpriority["_encstr_830E086EE82B0B361D86"]["_encstr_9ACC05B4156DF3"] = 0.9999;
  anim.eventpriority["_encstr_830E086EE82B0B361D86"]["_encstr_AA7C07466F9DA30713"] = 0.6;
  anim.eventpriority["_encstr_830E086EE82B0B361D86"]["_encstr_873E0AB31EF510DDDB6AF96B"] = 0.999999;
  anim.eventpriority["_encstr_830E086EE82B0B361D86"]["_encstr_813E0A9B36CD28F5F3729173"] = 0.99999;
  anim.eventpriority["_encstr_830E086EE82B0B361D86"]["_encstr_883E0A30DAA59FEBF333E5C6"] = 0.9999;
  anim.eventpriority["_encstr_830E086EE82B0B361D86"]["_encstr_923E0AB31EF510DDDB6AF9CB"] = 0.999;
  anim.eventpriority["_encstr_830E086EE82B0B361D86"]["_encstr_BE3E0AF35EB5509D9B2AB9AB"] = 0.99;
  anim.eventduration["_encstr_85CB07BDE04321538B"]["_encstr_A20C099FE504225E886B40"] = 10000;
  anim.eventduration["_encstr_85CB07BDE04321538B"]["_encstr_9A50080BA7292FFA0DA2"] = 10000;
  anim.eventduration["_encstr_85CB07BDE04321538B"]["_encstr_B2BC08303A77613B2FA4"] = 15000;
  anim.eventduration["_encstr_85CB07BDE04321538B"]["_encstr_82F309E237DB1B6B6367E9"] = 15000;
  anim.eventduration["_encstr_840709B34F76BBF8F072C7"]["_encstr_8E2508591EE07BE6B246"] = 10000;
  anim.eventduration["_encstr_840709B34F76BBF8F072C7"]["_encstr_A99B08D609DBE0AF2B3B"] = 20000;
  anim.eventduration["_encstr_840709B34F76BBF8F072C7"]["_encstr_AC6E09881A36337B5F6F30"] = 20000;
  anim.eventduration["_encstr_840709B34F76BBF8F072C7"]["_encstr_8B60059536347B"] = 20000;
  anim.eventduration["_encstr_840709B34F76BBF8F072C7"]["_encstr_A71904605AB4"] = 10000;
  anim.eventduration["_encstr_840709B34F76BBF8F072C7"]["_encstr_84C909D2980D8713F8F8AF"] = 15000;
  anim.eventduration["_encstr_840709B34F76BBF8F072C7"]["_encstr_8707037979"] = 15000;
  anim.eventduration["_encstr_8A66099C590B3647D2B79B"]["_encstr_8A3C092767D35DE09CEBD2"] = 10000;
  anim.eventduration["_encstr_8A66099C590B3647D2B79B"]["_encstr_A54E0D719B1F05C0B7C45355F91A50"] = 10000;
  anim.eventduration["_encstr_8A66099C590B3647D2B79B"]["_encstr_81B70B13BFC78276F1108FFB10"] = 15000;
  anim.eventduration["_encstr_8A66099C590B3647D2B79B"]["_encstr_8EBB09D658CD56D5672B39"] = 15000;
  anim.eventduration["_encstr_8A66099C590B3647D2B79B"]["_encstr_B18F09518733412BAF1AA0"] = 15000;
  anim.eventduration["_encstr_8A66099C590B3647D2B79B"]["_encstr_AA580ADB1DA80886FB3AC320"] = 15000;
  anim.eventduration["_encstr_8A66099C590B3647D2B79B"]["_encstr_83A107A3F3185A4DB0"] = 15000;
  anim.eventduration["_encstr_8A66099C590B3647D2B79B"]["_encstr_A7F7070BB9D67DED6D"] = 15000;
  anim.eventduration["_encstr_8A66099C590B3647D2B79B"]["_encstr_AD2906FBFA7593E3"] = 20000;
  anim.eventduration["_encstr_88720627AD68179B"]["_encstr_B40B07666F8BC31783"] = 30000;
  anim.eventduration["_encstr_88720627AD68179B"]["_encstr_ACA20538F84D39"] = 30000;
  anim.eventduration["_encstr_88720627AD68179B"]["_encstr_933609192D9B8363C2B156"] = 30000;
  anim.eventduration["_encstr_85E507408AF3D0F005"]["_encstr_999A07C61338F9A23A"] = 10000;
  anim.eventduration["_encstr_85E507408AF3D0F005"]["_encstr_8A4F099025A3B8715A6B17"] = 15000;
  anim.eventduration["_encstr_85E507408AF3D0F005"]["_encstr_878B0A2323D11281F8F8551F"] = 10000;
  anim.eventduration["_encstr_85E507408AF3D0F005"]["_encstr_8E950B26FDE7F283FFA3F77B77"] = 20000;
  anim.eventduration["_encstr_85E507408AF3D0F005"]["_encstr_86B209B07AF529395F72B1"] = 20000;
  anim.eventduration["_encstr_BD34078D57B9A37BD6"]["_encstr_979608DF73C8E70B73A1"] = 10000;
  anim.eventduration["_encstr_830E086EE82B0B361D86"]["_encstr_A7C5056BD931D1"] = 5000;
  anim.eventduration["_encstr_830E086EE82B0B361D86"]["_encstr_A16D0B492D908FC1D36852DB50"] = 5000;
  anim.eventduration["_encstr_830E086EE82B0B361D86"]["_encstr_BE1A0C5ADCD9569B3A96CEB0A3B2"] = 15000;
  anim.eventduration["_encstr_830E086EE82B0B361D86"]["_encstr_9ACC05B4156DF3"] = 15000;
  anim.eventduration["_encstr_830E086EE82B0B361D86"]["_encstr_AA7C07466F9DA30713"] = 15000;
  anim.eventduration["_encstr_830E086EE82B0B361D86"]["_encstr_873E0AB31EF510DDDB6AF96B"] = 15000;
  anim.eventduration["_encstr_830E086EE82B0B361D86"]["_encstr_813E0A9B36CD28F5F3729173"] = 15000;
  anim.eventduration["_encstr_830E086EE82B0B361D86"]["_encstr_883E0A30DAA59FEBF333E5C6"] = 15000;
  anim.eventduration["_encstr_830E086EE82B0B361D86"]["_encstr_923E0AB31EF510DDDB6AF9CB"] = 15000;
  anim.eventduration["_encstr_830E086EE82B0B361D86"]["_encstr_BE3E0AF35EB5509D9B2AB9AB"] = 15000;
  anim.eventchance["_encstr_840709B34F76BBF8F072C7"]["_encstr_8E2508591EE07BE6B246"] = 85;
  anim.eventchance["_encstr_840709B34F76BBF8F072C7"]["_encstr_AF4D07932B1BDE5846"] = 80;
  anim.eventchance["_encstr_840709B34F76BBF8F072C7"]["_encstr_AC6E09881A36337B5F6F30"] = 75;
  anim.eventchance["_encstr_840709B34F76BBF8F072C7"]["_encstr_A99B08D609DBE0AF2B3B"] = 75;
  anim.eventchance["_encstr_840709B34F76BBF8F072C7"]["_encstr_86E6112FA828C45A5B8D695D7D17F284D0B88F"] = 60;
  anim.eventchance["_encstr_840709B34F76BBF8F072C7"]["_encstr_88720627AD68179B"] = 80;
  anim.eventchance["_encstr_BA630AF5205B07DF65A89A33"]["_encstr_AD6908D8F63B2BE46B56"] = 70;
  anim.eventchance["_encstr_BA630AF5205B07DF65A89A33"]["_encstr_BEDD0EFD1EE17A42BB4083FB58720D53"] = 50;
  anim.fbt_desireddistmax = 620;
  anim.fbt_waitmin = 12;
  anim.fbt_waitmax = 24;
  anim.fbt_linebreakmin = 2;
  anim.fbt_linebreakmax = 5;
  anim.moveorigin = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (0, 0, 0));

  if(!isDefined(level.bcs_maxtalkingdistsqrdfromplayer))
    level.bcs_maxtalkingdistsqrdfromplayer = squared(3000);

  if(!isDefined(level.bcs_maxthreatdistsqrdfromplayer))
    level.bcs_maxthreatdistsqrdfromplayer = squared(5000);

  if(!isDefined(level.bcs_maxstealthdistsqrdfromplayer))
    level.bcs_maxstealthdistsqrdfromplayer = squared(1500);

  level.heightforhighcallout = 96.0;
  level.mindistancecallout = 10.0;
  level.maxdistancecallout = 45.0;

  if(!isDefined(anim.bcs_locations))
    scripts\common\bcs_location_trigs::bcs_location_trigs_init();

  anim.scripteddialoguebuffertime = 4000;
  anim.bcs_threatresettime = 3000;
  anim.squadcreatefuncs[anim.squadcreatefuncs.size] = ::init_squadbattlechatter;
  anim.squadcreatestrings[anim.squadcreatestrings.size] = "_encstr_817A1AF78283D5EFCB904B419D3183963B489B0A902F8C07E36D255A";

  foreach(var_1 in anim.teams) {
    anim.isteamspeaking[var_1] = 0;
    anim.isteamsaying[var_1]["_encstr_85CB07BDE04321538B"] = 0;
    anim.isteamsaying[var_1]["_encstr_88720627AD68179B"] = 0;
    anim.isteamsaying[var_1]["_encstr_8A66099C590B3647D2B79B"] = 0;
    anim.isteamsaying[var_1]["_encstr_840709B34F76BBF8F072C7"] = 0;
    anim.isteamsaying[var_1]["_encstr_85E507408AF3D0F005"] = 0;
    anim.isteamsaying[var_1]["_encstr_BD34078D57B9A37BD6"] = 0;
    anim.isteamsaying[var_1]["_encstr_830E086EE82B0B361D86"] = 0;
  }

  bcs_setup_chatter_toggle_array();
  bcs_setup_flavorburst_toggle_array();
  anim.lastteamspeaktime = [];
  anim.lastnamesaid = [];
  anim.lastnamesaidtime = [];

  foreach(var_1 in anim.teams) {
    anim.lastteamspeaktime[var_1] = -50000;
    anim.lastnamesaid[var_1] = "_encstr_8BBA05185F8B99";
    anim.lastnamesaidtime[var_1] = -100000;
  }

  anim.lastnamesaidtimeout = 120000;

  for(var_5 = 0; var_5 < anim.squadindex.size; var_5++) {
    if(isDefined(anim.squadindex[var_5].chatinitialized) && anim.squadindex[var_5].chatinitialized) {
      continue;
    }
    anim.squadindex[var_5] init_squadbattlechatter();
  }

  anim.threatcallouts = [];
  anim.threatcallouts["_encstr_8E2508591EE07BE6B246"] = 25;
  anim.threatcallouts["_encstr_B2BC08303A77613B2FA4"] = 25;
  anim.threatcallouts["_encstr_82F309E237DB1B6B6367E9"] = 50;
  anim.threatcallouts["_encstr_8B3C1059F1C7C3CB83782CDF93CB39B2D39D"] = 20;
  anim.threatcallouts["_encstr_855D0FC1B185F2AC9C7DF64C3BA5DEBA37"] = 25;
  anim.threatcallouts["_encstr_8C631507D8165EB24EAFB1F69B1D588DA3FAD88DDEC6B6"] = 25;
  anim.threatcallouts["_encstr_8F4914586BB9FA1BEB11850732D25303DFFF6328CF5B"] = 25;
  anim.threatcallouts["_encstr_834E19FFA24A713DA2FF4372FDC85F93AF4E70CA1938D720BF1768"] = 25;
  anim.threatcallouts["_encstr_8FE6108308376FD79327C3C955989C6B6F60"] = 20;
  anim.threatcallouts["_encstr_9B7F0C0BD2EB46D29B8EC2CD8DAC"] = 25;
  anim.threatcallouts["_encstr_B1610BB3D781C068F6DC603B42"] = 25;
  anim.threatcallouts["_encstr_86A411B288082775C051A1AB39213E434861AA"] = 20;
  anim.threatcallouts["_encstr_B4731043E9A960C7BF3B49D0A1C70948FE73"] = 20;
  anim.threatcallouts["_encstr_962A100B96EBE816E4CE5947EBD863DBB1AD"] = 20;
  anim.threatcallouts["_encstr_B6B7158596FAE8B09CCE2B1DEB1B8D7BB16DBED096B386"] = 25;
  anim.threatcallouts["_encstr_83240CF857AF812BC3C763F89E7A"] = 10;
  anim.threatcallouts["_encstr_A3731036F6731B168EAFD87BD816A3A5DECD"] = 90;
  anim.threatcallouts["_encstr_9A7C100ED80B5E56E47D63DB1BC23AB47BCD"] = 90;
  anim.threatcallouts["_encstr_8F100C0BD2D763EDB116D15ABD9B"] = 100;
  anim.threatcallouts["_encstr_9A0E11705DF51B9A64698799D0E6A1ABFB388D"] = 95;
  anim.lastteamthreatcallout = [];
  anim.lastteamthreatcallouttime = [];

  foreach(var_1 in anim.teams) {
    anim.lastteamthreatcallout[var_1] = undefined;
    anim.lastteamthreatcallouttime[var_1] = undefined;
  }

  anim.teamthreatcalloutlimittimeout = 120000;
  level notify("_encstr_A15C1A0659EBB3991F7A10502373B3CB12C9980BA447D9D144936040");
  anim notify("_encstr_A15C1A0659EBB3991F7A10502373B3CB12C9980BA447D9D144936040");
}

init_flavorbursts() {
  anim.flavorbursts["_encstr_8A390E2F88D07452C1384E0393EFDA3B"] = [];
  var_0 = 41;

  for(var_1 = 0; var_1 < var_0; var_1++)
    anim.flavorbursts["_encstr_8A390E2F88D07452C1384E0393EFDA3B"][var_1] = scripts\engine\utility::string(var_1 + 1);

  anim.flavorbursts["_encstr_BAA814DBED11D8CDC2335371075A8058B88760505754"] = [];
  var_0 = 41;

  for(var_1 = 0; var_1 < var_0; var_1++)
    anim.flavorbursts["_encstr_BAA814DBED11D8CDC2335371075A8058B88760505754"][var_1] = scripts\engine\utility::string(var_1 + 1);

  anim.flavorbursts["_encstr_AF5E14AB37A5A3AC237316E82DB737B96659AD851B95"] = [];
  var_0 = 41;

  for(var_1 = 0; var_1 < var_0; var_1++)
    anim.flavorbursts["_encstr_AF5E14AB37A5A3AC237316E82DB737B96659AD851B95"][var_1] = scripts\engine\utility::string(var_1 + 1);

  anim.flavorbursts["_encstr_8BD90D13804B3C120DDFE3AFC9A53B"] = [];
  var_0 = 41;

  for(var_1 = 0; var_1 < var_0; var_1++)
    anim.flavorbursts["_encstr_8BD90D13804B3C120DDFE3AFC9A53B"][var_1] = scripts\engine\utility::string(var_1 + 1);

  anim.flavorbursts["_encstr_A67A134BD0ABF37F08D74C21A17882F3C528826219"] = [];
  var_0 = 41;

  for(var_1 = 0; var_1 < var_0; var_1++)
    anim.flavorbursts["_encstr_A67A134BD0ABF37F08D74C21A17882F3C528826219"][var_1] = scripts\engine\utility::string(var_1 + 1);

  anim.flavorbursts["_encstr_81190403AE66"] = [];
  var_0 = 41;

  for(var_1 = 0; var_1 < var_0; var_1++)
    anim.flavorbursts["_encstr_81190403AE66"][var_1] = scripts\engine\utility::string(var_1 + 1);

  anim.flavorbursts["_encstr_978D0A1B20CFBFB7B0A77C6D"] = [];
  var_0 = 41;

  for(var_1 = 0; var_1 < var_0; var_1++)
    anim.flavorbursts["_encstr_978D0A1B20CFBFB7B0A77C6D"][var_1] = scripts\engine\utility::string(var_1 + 1);

  anim.flavorbursts["_encstr_841804CCB9B0"] = [];
  var_0 = 41;

  for(var_1 = 0; var_1 < var_0; var_1++)
    anim.flavorbursts["_encstr_841804CCB9B0"][var_1] = scripts\engine\utility::string(var_1 + 1);

  anim.flavorbursts["_encstr_A1440A8C62AA7519DD2FC0B0"] = [];
  var_0 = 41;

  for(var_1 = 0; var_1 < var_0; var_1++)
    anim.flavorbursts["_encstr_A1440A8C62AA7519DD2FC0B0"][var_1] = scripts\engine\utility::string(var_1 + 1);

  anim.flavorburstsused = [];
}

init_squadbattlechatter() {
  var_0 = self;
  var_0.numspeakers = 0;
  var_0.maxspeakers = 1;
  var_0.nextsaytime = gettime() + 50;
  var_0.nextsaytimes["_encstr_85CB07BDE04321538B"] = gettime() + 50;
  var_0.nextsaytimes["_encstr_88720627AD68179B"] = gettime() + 50;
  var_0.nextsaytimes["_encstr_8A66099C590B3647D2B79B"] = gettime() + 50;
  var_0.nextsaytimes["_encstr_840709B34F76BBF8F072C7"] = gettime() + 50;
  var_0.nextsaytimes["_encstr_85E507408AF3D0F005"] = gettime() + 50;
  var_0.nextsaytimes["_encstr_BD34078D57B9A37BD6"] = gettime() + 50;
  var_0.nextsaytimes["_encstr_830E086EE82B0B361D86"] = gettime() + 50;
  var_0.nexttypesaytimes["_encstr_85CB07BDE04321538B"] = [];
  var_0.nexttypesaytimes["_encstr_88720627AD68179B"] = [];
  var_0.nexttypesaytimes["_encstr_8A66099C590B3647D2B79B"] = [];
  var_0.nexttypesaytimes["_encstr_840709B34F76BBF8F072C7"] = [];
  var_0.nexttypesaytimes["_encstr_85E507408AF3D0F005"] = [];
  var_0.nexttypesaytimes["_encstr_BD34078D57B9A37BD6"] = [];
  var_0.nexttypesaytimes["_encstr_830E086EE82B0B361D86"] = [];
  var_0.ismembersaying["_encstr_85CB07BDE04321538B"] = 0;
  var_0.ismembersaying["_encstr_88720627AD68179B"] = 0;
  var_0.ismembersaying["_encstr_8A66099C590B3647D2B79B"] = 0;
  var_0.ismembersaying["_encstr_840709B34F76BBF8F072C7"] = 0;
  var_0.ismembersaying["_encstr_85E507408AF3D0F005"] = 0;
  var_0.ismembersaying["_encstr_BD34078D57B9A37BD6"] = 0;
  var_0.ismembersaying["_encstr_830E086EE82B0B361D86"] = 0;
  var_0.lastdirection = "_encstr_B40101";
  var_0.memberaddfuncs[var_0.memberaddfuncs.size] = scripts\cp\cp_battlechatter_ai::addtosystem;
  var_0.memberremovefuncs[var_0.memberremovefuncs.size] = scripts\cp\cp_battlechatter_ai::removefromsystem;
  var_0.squadupdatefuncs[var_0.squadupdatefuncs.size] = ::initcontact;
  var_0.fbt_firstburst = 1;
  var_0.fbt_lastbursterid = undefined;

  for(var_1 = 0; var_1 < anim.squadindex.size; var_1++)
    var_0 thread initcontact(anim.squadindex[var_1].squadname);

  var_0 thread scripts\cp\cp_battlechatter_ai::squadthreatwaiter();
  var_0 thread squadflavorbursttransmissions();
  var_0.chatinitialized = 1;
  var_0 notify("_encstr_ACB917436308D6FCB259DC42BBF119B8D1BB9177E912BAF809");
}

is_in_callable_location() {
  var_0 = get_all_my_locations();

  foreach(var_2 in var_0) {
    if(!location_called_out_recently(var_2))
      return 1;
  }

  return 0;
}

entinfrontarc(var_0) {
  return scripts\engine\utility::within_fov(self.origin, self.angles, var_0.origin, 0);
}

initcontact(var_0) {
  if(!isDefined(self.squadlist[var_0].calledout))
    self.squadlist[var_0].calledout = 0;

  if(!isDefined(self.squadlist[var_0].firstcontact))
    self.squadlist[var_0].firstcontact = 2000000000;

  if(!isDefined(self.squadlist[var_0].lastcontact))
    self.squadlist[var_0].lastcontact = 0;
}

setplayerbcnameid(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1)) {
    anim.player.bcnameid = var_0;
    anim.player.bccountryid = var_1;
    return;
  }

  while(!isDefined(level.campaign))
    wait 0.1;

  var_2 = level.campaign;
  var_3 = anim.playernameids[var_2];
  var_4 = anim.countryids[var_2];

  if(isDefined(var_3))
    anim.player.bcnameid = var_3;

  if(isDefined(var_4))
    anim.player.bccountryid = var_4;
}

squadflavorbursttransmissions() {
  anim endon("_encstr_AAED17080A03C9A8BF53038F3C83F18D7EC2D838A25E014193");
  self endon("_encstr_964C0FF733ED392996690F3C6BE3832D97");

  if(self.squadname != "_encstr_8E700E721E729711544F2040AB79A91F") {
    return;
  }
  while(self.membercount <= 0)
    wait 0.5;

  wait 0.5;
  var_0 = 0;

  while(isDefined(self)) {
    if(!squadcanburst(self)) {
      var_0 = 1;
      wait 1;
      continue;
    } else if(self.fbt_firstburst) {
      if(!var_0)
        wait(randomfloat(anim.fbt_waitmin));

      if(var_0)
        var_0 = 0;

      self.fbt_firstburst = 0;
    } else {
      if(!var_0)
        wait(randomfloatrange(anim.fbt_waitmin, anim.fbt_waitmax));

      if(var_0)
        var_0 = 0;
    }

    var_1 = getburster(self);

    if(!isDefined(var_1)) {
      continue;
    }
    var_2 = var_1.voice;
    var_3 = getflavorburstid(self, var_2);
    var_4 = getflavorburstaliases(var_2, var_3);

    foreach(var_8, var_6 in var_4) {
      if(!var_1 candoflavorburst() || distance(anim.player.origin, var_1.origin) > anim.fbt_desireddistmax && !isDefined(var_1.bcs_jackal)) {
        for(var_7 = 0; var_7 < self.members.size; var_7++) {
          var_1 = getburster(self);

          if(!isDefined(var_1)) {
            continue;
          }
          if(var_1.voice == var_2) {
            break;
          }
        }

        if(!isDefined(var_1) || var_1.voice != var_2) {
          break;
        }
      }

      thread playflavorburstline(var_1, var_6);
      self waittill("_encstr_8CF410884FEAFB79799DCB40379191A02EA7");

      if(var_8 != var_4.size - 1)
        wait(randomfloatrange(anim.fbt_linebreakmin, anim.fbt_linebreakmax));
    }
  }
}

getburster(var_0) {
  var_1 = undefined;
  var_2 = scripts\engine\utility::get_array_of_farthest(anim.player.origin, var_0.members);

  foreach(var_4 in var_2) {
    if(var_4 candoflavorburst()) {
      var_1 = var_4;

      if(!isDefined(var_0.fbt_lastbursterid)) {
        break;
      }

      if(isDefined(var_0.fbt_lastbursterid) && var_0.fbt_lastbursterid == var_1.unique_id)
        continue;
    }
  }

  if(isDefined(var_1))
    var_0.fbt_lastbursterid = var_1.unique_id;

  return var_1;
}

getflavorburstid(var_0, var_1) {
  var_2 = scripts\engine\utility::array_randomize(anim.flavorbursts[var_1]);

  if(anim.flavorburstsused.size >= var_2.size)
    anim.flavorburstsused = [];

  var_3 = undefined;

  foreach(var_5 in var_2) {
    var_3 = var_5;

    if(!flavorburstwouldrepeat(var_3)) {
      break;
    }
  }

  anim.flavorburstsused[anim.flavorburstsused.size] = var_3;
  return var_3;
}

flavorburstwouldrepeat(var_0) {
  if(!anim.flavorburstsused.size)
    return 0;

  var_1 = 0;

  foreach(var_3 in anim.flavorburstsused) {
    if(var_3 == var_0) {
      var_1 = 1;
      break;
    }
  }

  return var_1;
}

getflavorburstaliases(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 1;

  var_3 = var_2;
  var_4 = [];

  for(;;) {
    var_5 = var_3;
    var_6 = "_encstr_95180459DA99" + anim.countryids[var_0] + "_encstr_BA4C02DF" + var_1 + "_encstr_BA4C02DF" + var_5;
    var_3++;

    if(soundexists(var_6)) {
      var_4[var_4.size] = var_6;
      continue;
    }

    break;
  }

  return var_4;
}

voicecanburst() {
  if(isDefined(anim.flavorburstvoices) && isDefined(anim.flavorburstvoices[self.voice]) && anim.flavorburstvoices[self.voice])
    return 1;

  return 0;
}

candoflavorburst() {
  var_0 = 0;

  if(self != anim.player && isalive(self) && level.flavorbursts[self.team] && voicecanburst() && isDefined(self.flavorbursts) && self.flavorbursts)
    var_0 = 1;

  return var_0;
}

squadcanburst(var_0) {
  var_1 = 0;

  foreach(var_3 in var_0.members) {
    if(var_3 == anim.player) {
      continue;
    }
    if(!isDefined(var_3.team))
      return var_1;

    if(var_3 candoflavorburst()) {
      var_1 = 1;
      break;
    }
  }

  return var_1;
}

flavorburstlinedebug(var_0, var_1) {
  self endon("_encstr_8CF410884FEAFB79799DCB40379191A02EA7");

  for(;;)
    wait 0.05;
}

playflavorburstline(var_0, var_1) {
  anim endon("_encstr_AAED17080A03C9A8BF53038F3C83F18D7EC2D838A25E014193");
  var_2 = undefined;
  var_2 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_0 gettagorigin("_encstr_AADA07DBF19A4A81D7"));
  var_2 linkTo(var_0);

  if(battlechatter_canprint())
    battlechatter_print([var_1]);

  var_2 playSound(var_1);
  wait(lookupsoundlength(var_1) / 1000);
  var_2 delete();

  if(isDefined(self))
    self notify("_encstr_8CF410884FEAFB79799DCB40379191A02EA7");
}

createchatevent(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.owner = self;
  var_3.eventtype = var_1;
  var_3.eventaction = var_0;

  if(isDefined(var_2))
    var_3.priority = var_2;
  else
    var_3.priority = anim.eventpriority[var_0][var_1];

  var_3.expiretime = gettime() + anim.eventduration[var_0][var_1];
  return var_3;
}

isspeakingfailsafe(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");
  wait 25;
  clearisspeaking(var_0);
}

lockaction(var_0, var_1, var_2) {
  anim endon("_encstr_AAED17080A03C9A8BF53038F3C83F18D7EC2D838A25E014193");
  var_3 = var_0.squad;
  var_4 = var_0.team;
  var_0.battlechatter.isspeaking = 1;
  var_0 thread isspeakingfailsafe(var_1);
  var_3.ismembersaying[var_1] = 1;
  var_3.numspeakers++;
  anim.isteamspeaking[var_4] = 1;
  anim.isteamsaying[var_4][var_1] = 1;
  var_5 = var_0 scripts\engine\utility::_id_143AE("_encstr_AD75063D571AE108", "_encstr_B4650E6A50F57FA2732F75694AD85307", "_encstr_BD4C109A81983FEFD881BBA013E8345F30F9");
  var_3.ismembersaying[var_1] = 0;
  var_3.numspeakers--;
  anim.isteamspeaking[var_4] = 0;
  anim.isteamsaying[var_4][var_1] = 0;

  if(var_5 == "_encstr_BD4C109A81983FEFD881BBA013E8345F30F9") {
    return;
  }
  anim.lastteamspeaktime[var_4] = gettime();

  if(isalive(var_0))
    var_0 clearisspeaking(var_1);

  var_3.nextsaytimes[var_1] = gettime() + anim.eventactionminwait[var_1]["_encstr_8C950626C2CB5B19"];
}

clearisspeaking(var_0) {
  self.battlechatter.isspeaking = 0;
  self.battlechatter.chatqueue[var_0].expiretime = 0;
  self.battlechatter.chatqueue[var_0].priority = 0.0;
  self.battlechatter.nextsaytimes[var_0] = gettime() + anim.eventactionminwait[var_0]["_encstr_831805DFAF3BF3"];
}

playstealthevent() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");

  if(!isDefined(self.battlechatter.chatqueue["_encstr_830E086EE82B0B361D86"].eventtype)) {
    iprintln("_encstr_AB5A2AA54A4FFD49E3DD5B6380CC106FA782D9E9528738D0FFFEF9E1DF74580D86CBD9516ADF600806871DE7");
    return;
  }

  self.curevent = self.battlechatter.chatqueue["_encstr_830E086EE82B0B361D86"];
  var_0 = self.battlechatter.chatqueue["_encstr_830E086EE82B0B361D86"].modifier;
  anim thread lockaction(self, "_encstr_830E086EE82B0B361D86");

  switch (self.battlechatter.chatqueue["_encstr_830E086EE82B0B361D86"].eventtype) {
    case "_encstr_A7C5056BD931D1":
      stealthidle(var_0);
      break;
    case "_encstr_A16D0B492D908FC1D36852DB50":
      stealthidlealert(var_0);
      break;
    case "_encstr_BE1A0C5ADCD9569B3A96CEB0A3B2":
      stealthinvestigate(var_0);
      break;
    case "_encstr_9ACC05B4156DF3":
      stealthhunt(var_0);
      break;
    case "_encstr_AA7C07466F9DA30713":
      break;
    case "_encstr_BE3E0AF35EB5509D9B2AB9AB":
    case "_encstr_923E0AB31EF510DDDB6AF9CB":
    case "_encstr_883E0A30DAA59FEBF333E5C6":
    case "_encstr_813E0A9B36CD28F5F3729173":
    case "_encstr_873E0AB31EF510DDDB6AF96B":
      stealthannounce(var_0);
      break;
  }

  self notify("_encstr_B4650E6A50F57FA2732F75694AD85307");
}

stealthinvestigate(var_0) {
  var_1 = self;
  var_1 endon("_encstr_AD75063D571AE108");
  var_1 endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");
  var_2 = var_1 createchatphrase();
  var_2 addstealthalias("_encstr_BE1A0C5ADCD9569B3A96CEB0A3B2", var_0);
  var_3 = var_1 playphrase(var_2, self);

  if(stealthdocustombc(var_3)) {
    return;
  }
  if(var_3 && (isDefined(var_2.callin) || isDefined(var_2.update))) {
    if(isDefined(var_2.responsealiases[0]) && randomint(4))
      var_1 childthread stealthcommander(var_2.responsealiases[0]);
  } else {}
}

stealthhunt(var_0) {
  var_1 = self;
  var_1 endon("_encstr_AD75063D571AE108");
  var_1 endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");
  var_2 = var_1 createchatphrase();
  var_2 addstealthalias("_encstr_9ACC05B4156DF3", var_0);
  var_3 = var_1 playphrase(var_2, self);

  if(stealthdocustombc(var_3)) {
    return;
  }
  if(var_3 && isDefined(var_2.responsealiases[0])) {
    if(randomint(4))
      var_1 childthread stealthcommander(var_2.responsealiases[0]);
  } else {}
}

stealthannounce(var_0) {
  var_1 = self;
  var_1 endon("_encstr_AD75063D571AE108");
  var_1 endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");
  var_2 = var_1 createchatphrase();
  var_2 addstealthalias("_encstr_B8AA096B134A1818D66669", var_0);
  var_3 = var_1 playphrase(var_2, self);

  if(var_3 && isDefined(var_2.responsealiases[0])) {
    if(randomint(4))
      var_1 childthread stealthcommander(var_2.responsealiases[0]);
  }
}

stealthdocustombc(var_0) {
  if(isDefined(self.battlechatter.custombc_alias2) && self.battlechatter.custombc_alias2 == "_encstr_B40101") {
    self.battlechatter.custombc_alias2 = undefined;
    return 1;
  } else if(var_0 && isDefined(self.battlechatter.custombc_alias2)) {
    childthread stealthcustombc(self.battlechatter.custombc_alias2);
    self.battlechatter.custombc_alias2 = undefined;
    return 1;
  }

  return 0;
}

stealthcustombc(var_0) {
  wait(randomfloatrange(0.3, 0.4));

  if(isradioline(var_0)) {
    thread playradioecho(var_0, undefined, 1);
    thread playradio(var_0);
  } else {
    thread playradioecho(var_0, 1);
    var_1 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", self gettagorigin("_encstr_AADA07DBF19A4A81D7"));
    var_1 linkTo(self);

    if(battlechatter_canprint())
      battlechatter_print([var_0 + "_encstr_B1AE07F1D3F33086AF"]);

    if(soundexists(var_0)) {
      var_1 playSound(var_0);
      wait(lookupsoundlength(var_0) / 1000);
    } else
      battlechatter_printwarning("_encstr_92C72D514EB42B9110A3BD0438D816BC02B037080B63D258B904E8D02C1D0246DECADCB94EA30456E12DDC8E7401E4" + var_0 + "_encstr_850703A665");

    var_1 delete();
  }
}

isfiltered(var_0) {
  if(getDvar("_encstr_97010B83CFBEF166B078F3BF93" + var_0, "_encstr_BA19049F4B2D") == "_encstr_AB0703DBB9" || getDvar("_encstr_97010B83CFBEF166B078F3BF93" + var_0, "_encstr_BA19049F4B2D") == "_encstr_A34C02BB")
    return 1;

  switch (var_0) {
    case "_encstr_85CB07BDE04321538B":
      if(istrue(self.battlechatter.filterthreat))
        return 1;

      break;
    case "_encstr_85E507408AF3D0F005":
      if(istrue(self.battlechatter.filterinform))
        return 1;

      break;
    case "_encstr_88720627AD68179B":
      if(istrue(self.battlechatter.filterorder))
        return 1;

      break;
    case "_encstr_8A66099C590B3647D2B79B":
      if(istrue(self.battlechatter.filterreaction))
        return 1;

      break;
    case "_encstr_840709B34F76BBF8F072C7":
      if(istrue(self.battlechatter.filterresponse))
        return 1;

      break;
    case "_encstr_830E086EE82B0B361D86":
      if(istrue(self.battlechatter.filterstealth))
        return 1;

      break;
  }

  return 0;
}

battlechatter_canprintdump() {
  return 0;
}

playphrase(var_0, var_1, var_2) {
  anim endon("_encstr_AAED17080A03C9A8BF53038F3C83F18D7EC2D838A25E014193");
  self endon("_encstr_85180FA487BC1720A4BB20EAC25351FF30");
  self endon("_encstr_AD75063D571AE108");
  var_3 = 0;

  if(isDefined(var_2))
    return var_3;

  if(battlechatter_canprint() || battlechatter_canprintdump()) {
    if(isfiltered(var_1.curevent.eventaction)) {
      if(battlechatter_canprint())
        battlechatter_print([var_1.curevent.eventaction + "_encstr_AD1D0D015C7B0A3C82ABC9E3FB6A75"]);
    } else {
      var_4 = [];

      for(var_5 = 0; var_5 < var_0.soundaliases.size; var_5++) {
        var_6 = "_encstr_B40101";

        if(isDefined(var_0.soundevents[var_5]))
          var_6 = "_encstr_974C0246" + var_0.soundevents[var_5];

        var_4[var_5] = var_0.soundaliases[var_5] + var_6;
      }

      if(battlechatter_canprint())
        battlechatter_print(var_4);

      if(battlechatter_canprintdump()) {
        var_7 = self.curevent.eventaction + "_encstr_BA4C02DF" + self.curevent.eventtype;

        if(isDefined(self.curevent.modifier))
          var_7 = var_7 + ("_encstr_BA4C02DF" + self.curevent.modifier);

        thread battlechatter_printdump(var_4, var_7);
      }
    }
  }

  for(var_5 = 0; var_5 < var_0.soundaliases.size; var_5++) {
    if(!self.battlechatterallowed) {
      if(!is_friendlyfire_event(self.curevent))
        continue;
      else if(!can_say_friendlyfire(0))
        continue;
    }

    if(!isDefined(self._animactive) && self != anim.player || isDefined(self._animactive) && self._animactive > 0) {
      continue;
    }
    if(isfiltered(var_1.curevent.eventaction)) {
      wait 0.85;
      continue;
    }

    if(!soundexists(var_0.soundaliases[var_5])) {
      battlechatter_printwarning("_encstr_92C72D514EB42B9110A3BD0438D816BC02B037080B63D258B904E8D02C1D0246DECADCB94EA30456E12DDC8E7401E4" + var_0.soundaliases[var_5] + "_encstr_850703A665");
      continue;
    }

    var_8 = gettime();

    if(self == anim.player) {
      var_9 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", anim.player getEye());
      var_9 linkTo(self);
    } else if(isradioline(var_0.soundaliases[var_5])) {
      var_9 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", self gettagorigin("_encstr_AFDD09A4FA844B1CBE4994"));
      var_9 linkTo(var_1);
    } else {
      var_9 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", self gettagorigin("_encstr_AADA07DBF19A4A81D7"));
      var_9 linkTo(var_1);
    }

    thread stop_speaking(var_0.soundaliases[var_5], var_9);
    set_battlechatter_reaction_alias(var_0.soundaliases[var_5]);

    if(var_0.master && self.team == "_encstr_9A8507BA4040188D08") {
      if(isDefined(self.classname) && self.classname == "_encstr_8BB007E03658CBCAE4") {
        self notify(var_0.soundaliases[var_5] + "_encstr_8F1F0907DBD1F2F84D395C");
        var_3 = 1;
        var_9 playSound(var_0.soundaliases[var_5]);
      } else {
        self notify(var_0.soundaliases[var_5] + "_encstr_8F1F0907DBD1F2F84D395C");
        var_3 = 1;
        var_9 playSound(var_0.soundaliases[var_5]);
      }

      wait(lookupsoundlength(var_0.soundaliases[var_5]) / 1000);
      self notify(var_0.soundaliases[var_5]);
    } else {
      if(isDefined(self.classname) && self.classname == "_encstr_8BB007E03658CBCAE4") {
        self notify(var_0.soundaliases[var_5] + "_encstr_8F1F0907DBD1F2F84D395C");
        var_3 = 1;
        var_9 playSound(var_0.soundaliases[var_5]);
      } else {
        self notify(var_0.soundaliases[var_5] + "_encstr_8F1F0907DBD1F2F84D395C");
        var_3 = 1;
        var_9 playSound(var_0.soundaliases[var_5]);
      }

      wait(lookupsoundlength(var_0.soundaliases[var_5]) / 1000);
      self notify(var_0.soundaliases[var_5]);
    }

    var_9 delete();

    if(gettime() < var_8 + 250) {}
  }

  self notify("_encstr_9710106133923B09F80AB1CBF7E7E0783A7F");

  if(self != anim.player) {
    self._blackboard.battlechatter_target = undefined;
    self._blackboard.battlechatter_alias = undefined;
  }

  var_1 dotypelimit(var_1.curevent.eventaction, var_1.curevent.eventtype);
  return var_3;
}

battlechatter_printdump(var_0, var_1) {}

getaliastypefromsoundalias(var_0) {
  if(getsubstr(var_0, 0, 6) == "_encstr_B444074120C7C50F4D")
    var_1 = getsubstr(var_0, 7, var_0.size);
  else {
    if(self == anim.player)
      var_2 = self.battlechatter.countryid + "_encstr_BA4C02DF";
    else if(getsubstr(var_0, 0, 6) == "_encstr_844407C9E3F1BE1873")
      var_2 = bc_prefix("_encstr_830E086EE82B0B361D86");
    else
      var_2 = bc_prefix();

    var_1 = getsubstr(var_0, var_2.size, var_0.size);
  }

  return var_1;
}

battlechatter_printdumpline(var_0, var_1, var_2) {
  if(scripts\engine\utility::flag(var_2))
    scripts\engine\utility::flag_wait(var_2);

  scripts\engine\utility::flag_set(var_2);
  scripts\engine\utility::flag_clear(var_2);
}

is_friendlyfire_event(var_0) {
  if(!isDefined(var_0.eventaction) || !isDefined(var_0.eventtype))
    return 0;

  if(var_0.eventaction == "_encstr_8A66099C590B3647D2B79B" && var_0.eventtype == "_encstr_A54E0D719B1F05C0B7C45355F91A50")
    return 1;

  return 0;
}

stop_speaking(var_0, var_1) {
  var_1 endon("_encstr_AD75063D571AE108");
  self waittill("_encstr_AD75063D571AE108");

  if(isDefined(var_1)) {
    var_1 stopsounds();
    waitframe();

    if(isDefined(var_1)) {
      var_1 notify(var_0);
      var_1 delete();
    }
  }
}

set_battlechatter_reaction_alias(var_0) {
  var_1 = strtok(var_0, "_encstr_BA4C02DF");

  if(!isDefined(self._blackboard)) {
    return;
  }
  if(scripts\engine\utility::array_contains(var_1, "_encstr_86B209B07AF529395F72B1") || scripts\engine\utility::array_contains(var_1, "_encstr_AD6908D8F63B2BE46B56") || scripts\engine\utility::array_contains(var_1, "_encstr_958B09CD5DE0389C95DCE6"))
    self._blackboard.battlechatter_alias = "_encstr_B40B07666F8BC31783";
  else if(scripts\engine\utility::array_contains(var_1, "_encstr_999A07C61338F9A23A") && !scripts\engine\utility::array_contains(var_1, "_encstr_8C8D08671D451291C849"))
    self._blackboard.battlechatter_alias = "_encstr_992811497B1C60DEC2DF5D47EF8A1610A91510";
  else if(scripts\engine\utility::array_contains(var_1, "_encstr_8C8D08671D451291C849") || scripts\engine\utility::array_contains(var_1, "_encstr_85E507408AF3D0F005") && !scripts\engine\utility::array_contains(var_1, "_encstr_A32407E37AC7D31087"))
    self._blackboard.battlechatter_alias = "_encstr_858B118B5FD3BB9B30B0B077098A6A134B7815";
  else if(scripts\engine\utility::array_contains(var_1, "_encstr_88720627AD68179B"))
    self._blackboard.battlechatter_alias = "_encstr_A7EE0DCF955D3A1A99718E5368405E";
  else if(scripts\engine\utility::array_contains(var_1, "_encstr_AC6E09881A36337B5F6F30") || scripts\engine\utility::array_contains(var_1, "_encstr_91B508B1DE9BA358D8A3") || scripts\engine\utility::array_contains(var_1, "_encstr_A16007A921A23B85E3") || scripts\engine\utility::array_contains(var_1, "_encstr_8E2508591EE07BE6B246") && !scripts\engine\utility::array_contains(var_1, "_encstr_82F309E237DB1B6B6367E9"))
    self._blackboard.battlechatter_alias = "_encstr_A5ED101B8CEAB02FE3D763655BDAE04082A0";
  else if(scripts\engine\utility::array_contains(var_1, "_encstr_A32407E37AC7D31087"))
    self._blackboard.battlechatter_alias = "_encstr_81B70B13BFC78276F1108FFB10";
  else if(scripts\engine\utility::array_contains(var_1, "_encstr_840709B34F76BBF8F072C7") || scripts\engine\utility::array_contains(var_1, "_encstr_8CAB07EF58A11953A3") || scripts\engine\utility::array_contains(var_1, "_encstr_82F309E237DB1B6B6367E9"))
    self._blackboard.battlechatter_alias = "_encstr_840709B34F76BBF8F072C7";
}

getcustombc(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = bc_prefix("_encstr_BD34078D57B9A37BD6");
  var_6 = bc_prefix("_encstr_A22F0DC6AB6E477BAD01932C23B4B7");
  var_7 = var_5;
  var_8 = getarraykeys(level.battlechattercustom[var_0]);

  for(var_9 = 0; var_9 < var_8.size; var_9++) {
    if(!isDefined(level.battlechattercustom[var_0]["_encstr_85C60936FD43257DCF7AA3"]) || !scripts\engine\utility::array_contains(var_8, level.battlechattercustom[var_0]["_encstr_85C60936FD43257DCF7AA3"]) || var_8[var_9] != level.battlechattercustom[var_0]["_encstr_85C60936FD43257DCF7AA3"]) {
      continue;
    }
    if(isarray(level.battlechattercustom[var_0][var_8[var_9]])) {
      for(var_10 = 0; var_10 < level.battlechattercustom[var_0][var_8[var_9]].size; var_10++) {
        if(isarray(level.battlechattercustom[var_0][var_8[var_9]][var_10])) {
          for(var_11 = 0; var_11 < level.battlechattercustom[var_0][var_8[var_9]][var_10].size; var_11++) {
            if(isradioline(level.battlechattercustom[var_0][var_8[var_9]][var_10][var_11]))
              var_7 = var_6 + getcustombcradioprefix(level.battlechattercustom[var_0][var_8[var_9]][var_10][var_11]);
            else
              var_7 = var_5;

            if(!isDefined(var_1)) {
              var_1 = var_7 + level.battlechattercustom[var_0][var_8[var_9]][var_10][var_11];
              var_3 = var_11;
              continue;
            }

            var_4 = 1;
            var_2 = var_7 + level.battlechattercustom[var_0][var_8[var_9]][var_10][var_11];
          }

          if(isDefined(var_2)) {
            cleancustombc(var_8[var_9], var_0, var_10, var_3, 0);
            cleancustombc(var_8[var_9], var_0, var_10, var_3);
          } else
            cleancustombc(var_8[var_9], var_0, var_10, var_3);

          break;
        } else {
          var_7 = scripts\engine\utility::ter_op(isradioline(level.battlechattercustom[var_0][var_8[var_9]][var_10]), var_6, var_5);
          var_1 = var_7 + level.battlechattercustom[var_0][var_8[var_9]][var_10];
          cleancustombc(var_8[var_9], var_0, var_10, var_3);
          break;
        }
      }

      break;
    } else {
      var_7 = scripts\engine\utility::ter_op(isradioline(level.battlechattercustom[var_0][var_8[var_9]]), var_6, var_5);
      var_1 = var_7 + level.battlechattercustom[var_0][var_8[var_9]];
      break;
    }
  }

  if(isDefined(var_4))
    return [var_1, var_2];
  else
    return var_1;
}

getcustombcradioprefix(var_0) {
  return isradioline(var_0, 1);
}

cleancustombc(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4))
    var_4 = 1;

  if(istrue(level.battlechattercustom[var_1][var_0]["_encstr_96680850058F60530A6F"])) {
    if(var_4)
      level.battlechattercustom[var_1][var_0] = custombcshiftarray(level.battlechattercustom[var_1][var_0]);
  } else {
    level.battlechattercustom[var_1][var_0][var_2] = scripts\engine\utility::array_remove_index(level.battlechattercustom[var_1][var_0][var_2], var_3);

    if(level.battlechattercustom[var_1][var_0][var_2].size < 1)
      level.battlechattercustom[var_1][var_0] = scripts\engine\utility::array_remove_index(level.battlechattercustom[var_1][var_0], var_2);
  }

  if(level.battlechattercustom[var_1][var_0].size < 1)
    level.battlechattercustom[var_1] = scripts\engine\utility::array_remove_key(level.battlechattercustom[var_1], var_0);
}

custombcshiftarray(var_0) {
  if(!isDefined(var_0["_encstr_A28E061BDE5DB9D1"]))
    var_0["_encstr_A28E061BDE5DB9D1"] = 1;

  var_1 = [];
  var_2 = [];
  var_3 = getarraykeys(var_0);

  foreach(var_5 in var_3) {
    if(isnumber(var_5)) {
      if(var_5 != 0)
        var_1[var_5 - 1] = var_0[var_5];

      continue;
    }

    var_2[var_5] = var_0[var_5];
  }

  var_1[var_1.size] = var_0[0];

  if(var_0["_encstr_A28E061BDE5DB9D1"] == var_1.size) {
    for(var_1 = scripts\engine\utility::array_randomize(var_1); var_1[0][0] == var_0[0][0]; var_1 = scripts\engine\utility::array_randomize(var_1)) {}

    var_0["_encstr_A28E061BDE5DB9D1"] = 1;
  } else
    var_0["_encstr_A28E061BDE5DB9D1"] = var_0["_encstr_A28E061BDE5DB9D1"] + 1;

  var_3 = getarraykeys(var_2);

  foreach(var_5 in var_3)
  var_1[var_5] = var_2[var_5];

  var_1["_encstr_A28E061BDE5DB9D1"] = var_0["_encstr_A28E061BDE5DB9D1"];
  return var_1;
}

addcustombcstealthalias(var_0) {
  var_1 = getcustombc(var_0);
  self.battlechatter.custombc_alias2 = "_encstr_B40101";

  if(isarray(var_1)) {
    self.battlechatter.custombc_alias2 = var_1[1];
    var_1 = var_1[0];
  }

  if(isradioline(var_1))
    thread playradioecho(var_1);
  else {
    var_2 = "_encstr_B40101";
    var_3 = strtok(var_1, "_encstr_BA4C02DF");

    for(var_4 = 0; var_4 < var_3.size; var_4++) {
      if(var_4 == var_3.size - 1) {
        var_2 = var_2 + "_encstr_9507034EBE" + var_3[var_4];
        continue;
      }

      var_2 = var_2 + var_3[var_4] + "_encstr_BA4C02DF";
    }

    if(soundexists(var_2))
      thread playradioecho(var_1, undefined, undefined, var_2);
    else
      battlechatter_printwarning("_encstr_857D196F68A84F2B3144241DBDD983D13180676AF0804922AF4FBF" + var_2 + "_encstr_8CE9339CB84004154396B910B60B97049895044B731D56B91D4BBDB9B0C680B4334047C236B5A5B99D028E7B80D096B537CA369917");
  }

  return var_1;
}

usecustombc(var_0) {
  if(!isDefined(level.battlechattercustom) || !isDefined(level.battlechattercustom[var_0]))
    return 0;
  else {
    var_1 = getarraykeys(level.battlechattercustom[var_0]);

    if(var_1.size > 0 && isDefined(level.battlechattercustom[var_0]["_encstr_85C60936FD43257DCF7AA3"]) && scripts\engine\utility::array_contains(var_1, level.battlechattercustom[var_0]["_encstr_85C60936FD43257DCF7AA3"]))
      return 1;
    else
      return 0;
  }
}

addstealthalias(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;

  if(self.owner == anim.player) {} else {
    switch (var_0) {
      case "_encstr_A16D0B492D908FC1D36852DB50":
      case "_encstr_A7C5056BD931D1":
        self.owner.battlechatter.investigatecallin = 0;

        if(usecustombc(var_0))
          var_2 = self.owner addcustombcstealthalias(var_0);
        else if(scripts\engine\utility::cointoss()) {
          if(self.owner uselocationbc("_encstr_A521088F30C1D2328060")) {
            var_4 = self.owner getstealthlocationalias("_encstr_A521088F30C1D2328060");
            var_2 = var_4[0];
            var_3 = scripts\engine\utility::array_remove_index(var_4, 0);
          } else {
            var_5 = randomintrange_otn(1);
            var_6 = self.owner bc_prefix("_encstr_830E086EE82B0B361D86") + self.owner getbcstate() + "_encstr_BA6509C7269807565FC89A";
            var_2 = self.owner createleaderalias(var_6, var_5);
            var_3[0] = var_6 + "_encstr_A6AB07C9D3CF9757E1" + var_5;
            var_3[1] = self.owner createleaderalias(var_6 + "_encstr_8D5C06F54E59B90E", var_5);
          }

          self.checkin = 1;
          self.owner thread playradioecho(var_2);
        } else {
          if(self.owner uselocationbc("_encstr_8B9907D8161B1B5A9B")) {
            var_4 = self.owner getstealthlocationalias("_encstr_8B9907D8161B1B5A9B");
            var_2 = var_4[0];
            var_3 = scripts\engine\utility::array_remove_index(var_4, 0);
          } else {
            var_5 = randomintrange_otn(1);
            var_6 = self.owner bc_prefix("_encstr_830E086EE82B0B361D86") + self.owner getbcstate() + "_encstr_A2F609F961BFA30D50FD77";
            var_2 = var_6 + var_5;
            var_3[0] = self.owner createleaderalias(var_6 + "_encstr_8E1F05C9AC6E07", var_5);
          }

          self.callin = 1;
          self.owner thread playradioecho(var_2, 1);
        }

        break;
      case "_encstr_BE1A0C5ADCD9569B3A96CEB0A3B2":
        if(usecustombc(var_0))
          var_2 = self.owner addcustombcstealthalias(var_0);
        else if(!istrue(self.owner.battlechatter.investigatecallin)) {
          if(self.owner uselocationbc("_encstr_8B9907D8161B1B5A9B")) {
            var_4 = self.owner getstealthlocationalias("_encstr_8B9907D8161B1B5A9B");
            var_2 = var_4[0];
            var_3 = scripts\engine\utility::array_remove_index(var_4, 0);
          } else {
            var_5 = randomintrange_otn(1);
            var_6 = self.owner bc_prefix("_encstr_830E086EE82B0B361D86") + self.owner getbcstate() + "_encstr_A2F609F961BFA30D50FD77";
            var_2 = var_6 + var_5;
            var_3[0] = self.owner createleaderalias(var_6 + "_encstr_8E1F05C9AC6E07", var_5);
          }

          self.owner.battlechatter.investigatecallin = 1;
          self.callin = 1;
        } else {
          if(self.owner uselocationbc("_encstr_BD3107D507320BA356")) {
            var_4 = self.owner getstealthlocationalias("_encstr_BD3107D507320BA356");
            var_2 = var_4[0];
            var_3 = scripts\engine\utility::array_remove_index(var_4, 0);
          } else {
            var_5 = randomintrange_otn(1);
            var_6 = self.owner bc_prefix("_encstr_830E086EE82B0B361D86") + self.owner getbcstate() + "_encstr_A307097717E0D55E880AB0";
            var_2 = var_6 + var_5;
            var_3[0] = self.owner createleaderalias(var_6 + "_encstr_8E1F05C9AC6E07", var_5);
          }

          self.update = 1;
        }

        self.owner thread playradioecho(var_2, 1);
        break;
      case "_encstr_9ACC05B4156DF3":
        self.owner.battlechatter.investigatecallin = 0;

        if(usecustombc(var_0))
          var_2 = self.owner addcustombcstealthalias(var_0);
        else {
          switch (var_1) {
            case "_encstr_AC2C0C3ACA85B6B4DC17D5B44EE5":
              var_2 = self.owner bc_prefix("_encstr_830E086EE82B0B361D86") + "_encstr_82CF0E50A2AE2316A766B7AD49E31AFF" + randomintrange_otn(1);
              self.owner thread playradioecho(var_2, 1);
              break;
            case "_encstr_8B0A0BCCA54EE6A3EBB17B9B47":
              var_5 = randomintrange_otn(1);
              var_6 = self.owner bc_prefix("_encstr_830E086EE82B0B361D86") + "_encstr_AB011020735E90985AE7ADB78BA2D8E0FC41";
              var_2 = var_6 + var_5;
              self.owner thread playradioecho(var_2, 1);
              var_3[0] = self.owner createleaderalias(var_6 + "_encstr_8E1F05C9AC6E07", var_5);
              break;
            case "_encstr_85030B637B9B1DBE9BA5B33447":
              var_5 = randomintrange_otn(1);
              var_6 = self.owner bc_prefix("_encstr_830E086EE82B0B361D86") + "_encstr_831F0C7B177E839F209877BC1369";
              var_2 = var_6 + var_5;
              self.owner thread playradioecho(var_2, 1);
              var_3[0] = self.owner createleaderalias(var_6 + "_encstr_8E1F05C9AC6E07", var_5);
              break;
            default:
          }
        }

        break;
      case "_encstr_AA7C07466F9DA30713":
        break;
      case "_encstr_B8AA096B134A1818D66669":
        switch (var_1) {
          case "_encstr_BE1A0C5ADCD9569B3A96CEB0A3B2":
            var_2 = self.owner bc_prefix("_encstr_830E086EE82B0B361D86") + "_encstr_8D32152D733B9537E82DB3B03AACFA9DAC9B95272D6C7D" + randomintrange_otn(1);
            break;
          case "_encstr_82110B2AE8581B0B42C5D8CFB8":
            var_2 = self.owner bc_prefix("_encstr_830E086EE82B0B361D86") + "_encstr_879414B17BEC95C9C463EDEEDCF59DCA37AC272DB17D" + randomintrange_otn(1);
            break;
          case "_encstr_AA7C07466F9DA30713":
            var_2 = self.owner bc_prefix("_encstr_830E086EE82B0B361D86") + "_encstr_BA6510FB20381BD661790A2218ABCAEF5180" + randomintrange_otn(1);
            break;
          case "_encstr_B81D0CB08D63977DB65AB18D5932":
            var_2 = self.owner bc_prefix("_encstr_830E086EE82B0B361D86") + "_encstr_8F0A0DC00AD5233E7789D1D99D93E6" + randomintrange_otn(1);
            break;
          case "_encstr_B2BE0788BAF573592F":
            var_2 = self.owner bc_prefix("_encstr_830E086EE82B0B361D86") + "_encstr_8FFB10EB70D0E1F243204FC7907B9BA1B919" + randomintrange_otn(1);
            break;
          case "_encstr_96B00E6CC6A2C01B390B192F6B482748":
            var_2 = self.owner bc_prefix("_encstr_830E086EE82B0B361D86") + "_encstr_ABFA0F8CC97B37CAFA37C1BDA3E856C8BE" + randomintrange_otn(1);
            self.owner thread playradioecho(var_2, 1);
            break;
          case "_encstr_8E440A950FE01BB76E96BDE6":
            var_2 = self.owner bc_prefix("_encstr_830E086EE82B0B361D86") + "_encstr_B1EB13B3C30A08F8AF4AC765118FD9FDE35D78DEF1" + randomintrange_otn(1);
            self.owner thread playradioecho(var_2, 1);
            break;
          case "_encstr_AA140ECCF6BD3A9BA35983D7BB1663DA":
          case "_encstr_8C8E09632740B3834849C2":
            var_2 = self.owner bc_prefix("_encstr_830E086EE82B0B361D86") + "_encstr_9322122CC5EAF17B649F80016F8D101BE3EC1638" + randomintrange_otn(1);
            break;
          case "_encstr_91A3101DBF15687E13EABB46935BB6C8ED1C":
            var_2 = self.owner bc_prefix("_encstr_830E086EE82B0B361D86") + "_encstr_872511B3F7906353B8B912D193709A4AF829CF" + randomintrange_otn(1);
            break;
          case "_encstr_A59A0DF1E5353075B9DF8785AB43CD":
            var_2 = self.owner bc_prefix("_encstr_830E086EE82B0B361D86") + "_encstr_BA160EC9DD7D783DE197FFCDF30BF5A9" + randomintrange_otn(1);
            self.owner thread playradioecho(var_2, 1);
            break;
          case "_encstr_B45E1007B968BAA7C0F92AB303AE1FF09001":
            var_2 = self.owner bc_prefix("_encstr_830E086EE82B0B361D86") + "_encstr_BD33119DC6B09B9BF5C895E6D127B75E568CD7" + randomintrange_otn(1);
            break;
          case "_encstr_A52C0FB108673D1145651EC2A1C3BF659D":
            var_2 = self.owner bc_prefix("_encstr_830E086EE82B0B361D86") + "_encstr_ADFB1037D63B12997128778310E8576AADF8" + randomintrange_otn(1);
            break;
          case "_encstr_92FD082A30066B713094":
            var_2 = self.owner bc_prefix("_encstr_830E086EE82B0B361D86") + "_encstr_BAC511BFE3180B84F263065A57C58763700390" + randomintrange_otn(1);
            self.owner thread playradioecho(var_2, 1);
            break;
          case "_encstr_928E112F37025EA89FEB168B577948992A9B93":
            var_2 = self.owner bc_prefix("_encstr_830E086EE82B0B361D86") + "_encstr_AA2E12E95B66903BE2CB9FC1A72AF1380173D166" + randomintrange_otn(1);
            self.owner thread playradioecho(var_2, 1);
            break;
          case "_encstr_BA560BB0B1594EA34E59CD5647":
            var_2 = self.owner bc_prefix("_encstr_830E086EE82B0B361D86") + "_encstr_BDB60D20EA77D5BB4732F5F63DB386" + randomintrange_otn(1);
            self.owner thread playradioecho(var_2, 1);
            break;
          case "_encstr_AC2C0C3ACA85B6B4DC17D5B44EE5":
            var_2 = self.owner bc_prefix("_encstr_830E086EE82B0B361D86") + "_encstr_82CF0E50A2AE2316A766B7AD49E31AFF" + randomintrange_otn(1);
            self.owner thread playradioecho(var_2, 1);
            break;
          case "_encstr_93380D1B2D3B43A3BEB59636C65919":
            var_2 = self.owner bc_prefix("_encstr_830E086EE82B0B361D86") + "_encstr_96780EB196D9D08EF5DA5A8DC65919EB" + randomintrange_otn(1);
            break;
          case "_encstr_8B0A0BCCA54EE6A3EBB17B9B47":
            var_5 = randomintrange_otn(1);
            var_6 = self.owner bc_prefix("_encstr_830E086EE82B0B361D86") + "_encstr_AB011020735E90985AE7ADB78BA2D8E0FC41";
            var_2 = var_6 + var_5;
            self.owner thread playradioecho(var_2, 1);
            var_3[0] = self.owner createleaderalias(var_6 + "_encstr_8E1F05C9AC6E07", var_5);
            break;
          case "_encstr_85030B637B9B1DBE9BA5B33447":
            var_5 = randomintrange_otn(1);
            var_6 = self.owner bc_prefix("_encstr_830E086EE82B0B361D86") + "_encstr_831F0C7B177E839F209877BC1369";
            var_2 = var_6 + var_5;
            self.owner thread playradioecho(var_2, 1);
            var_3[0] = self.owner createleaderalias(var_6 + "_encstr_8E1F05C9AC6E07", var_5);
            break;
          case "_encstr_83650AB19BA26B100D3CE35A":
            var_2 = self.owner bc_prefix("_encstr_830E086EE82B0B361D86") + "_encstr_BD1913C85DC0A06771E0934B0E5C6F9D38C55923EF" + randomintrange_otn(1);
            break;
          case "_encstr_AB180B9B2B50397F40B3033BB9":
            var_2 = self.owner bc_prefix("_encstr_830E086EE82B0B361D86") + "_encstr_81FD0C3F5FAB70F88772FB935F4F" + randomintrange_otn(1);
            break;
          case "_encstr_AB130CB9AC56DA7D31C2C6B5D507":
            var_2 = self.owner bc_prefix("_encstr_830E086EE82B0B361D86") + "_encstr_A6630D833BD82C87CE293AA2B31F4F" + randomintrange_otn(1);
            self.owner thread playradioecho(var_2, 1);
            break;
          case "_encstr_B84F06CBD04CA31B":
            var_2 = self.owner bc_prefix("_encstr_830E086EE82B0B361D86") + "_encstr_A5200FCF108162BD31416335574B13660F" + randomintrange_otn(1);
            break;
          case "_encstr_8ECE1603386D65B748BF059EDC15C90F01409FF07BC71495":
            var_2 = self.owner bc_prefix("_encstr_830E086EE82B0B361D86") + "_encstr_A9811760DD90576FF350E51FC1ABD927BB0DA6F04DEB938DEE" + randomintrange_otn(1);
            self.owner thread playradioecho(var_2, 1);
            break;
          case "_encstr_A5490D5E05C3F8B363F3C8D83B3E43":
            var_2 = self.owner bc_prefix("_encstr_830E086EE82B0B361D86") + "_encstr_B2A516E2C5F0CB2F99D0E2CA808D604FC9A5669DDEF84F79" + randomintrange_otn(1);
          case "_encstr_AA300EBF415D43B0F85A6159731058AB":
            var_2 = self.owner bc_prefix("_encstr_830E086EE82B0B361D86") + "_encstr_84300F06A97369151682F819DBECDF8367" + randomintrange_otn(1);
            break;
          case "_encstr_AC360CDD2DDC91F677F57B1C59DC":
            var_2 = self.owner bc_prefix("_encstr_830E086EE82B0B361D86") + "_encstr_B11E0DCBA3C55A4FCBD18FFB688007" + randomintrange_otn(1);
            break;
        }

        break;
    }
  }

  if(!isDefined(var_2))
    return 0;

  self.soundevents[self.soundaliases.size] = var_0;

  if(isDefined(var_1))
    self.soundevents[self.soundaliases.size] = var_0 + "_encstr_974C0246" + var_1;

  self.soundaliases[self.soundaliases.size] = var_2;

  if(isDefined(var_3))
    self.responsealiases = var_3;

  return 1;
}

getstealthlocationalias(var_0) {
  if(!isDefined(var_0))
    var_0 = "_encstr_B40101";

  var_1 = getvalidlocation(self, "_encstr_830E086EE82B0B361D86", var_0);
  location_add_last_callout_time(var_1);

  switch (var_0) {
    case "_encstr_8B9907D8161B1B5A9B":
    case "_encstr_BD3107D507320BA356":
      var_2 = randomintrange_otn(1);
      var_3 = getloccalloutalias(getbcstate() + "_encstr_B6B70B7DC67BC6B01DD27B9BEB" + var_0 + "_encstr_BA4C02DF" + var_1.locationaliases[0] + "_encstr_BA4C02DF");
      var_4[0] = var_3 + var_2;
      var_4[1] = createleaderalias(var_3 + "_encstr_8E1F05C9AC6E07", var_2);
      return var_4;
    case "_encstr_A521088F30C1D2328060":
      var_2 = randomintrange_otn(1);
      var_3 = getloccalloutalias(getbcstate() + "_encstr_B6B70B7DC67BC6B01DD27B9BEB" + var_0 + "_encstr_BA4C02DF" + var_1.locationaliases[0] + "_encstr_BA4C02DF");
      var_4[0] = createleaderalias(var_3, var_2);
      var_4[1] = var_3 + "_encstr_A2F2068DFF5B5789" + var_2;
      var_4[2] = createleaderalias(var_3 + "_encstr_8E1F05C9AC6E07", var_2);
      return var_4;
  }
}

createchatphrase() {
  var_0 = spawnStruct();
  var_0.owner = self;
  var_0.soundevents = [];
  var_0.soundaliases = [];
  var_0.responsealiases = [];
  var_0.master = 0;
  return var_0;
}

stealthidle(var_0) {
  var_1 = self;
  var_1 endon("_encstr_AD75063D571AE108");
  var_1 endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");

  if(isDefined(self.battlechatter.stealthidledelay) && self.battlechatter.stealthidledelay > gettime()) {
    return;
  }
  var_2 = var_1 createchatphrase();
  var_2 addstealthalias("_encstr_A7C5056BD931D1", var_0);
  var_3 = var_1 playphrase(var_2, self);

  if(stealthdocustombc(var_3)) {
    return;
  }
  if(var_3 && isDefined(var_2.checkin) && var_1 getbcstate() == "_encstr_A7C5056BD931D1") {
    foreach(var_5 in var_2.responsealiases) {
      var_2.soundaliases = [];
      var_2.soundaliases[0] = var_5;

      if(isradioline(var_5))
        var_3 = var_1 stealthcommander(var_2.soundaliases[0]);
      else {
        var_1 commander_delay();
        var_1 childthread playradioecho(var_2.soundaliases[0], 1, 1);
        var_3 = var_1 playphrase(var_2, self);
      }

      if(!var_3 || var_1 getbcstate() != "_encstr_A7C5056BD931D1") {
        break;
      }
    }
  } else if(var_3 && isDefined(var_2.callin)) {
    if(isDefined(var_2.responsealiases[0]) && randomint(3))
      var_1 childthread stealthcommander(var_2.responsealiases[0]);
  } else if(var_3 && randomint(3)) {
    var_7 = ["_encstr_AFDC1746C3F513D8E67D27D563EBB17BB98E9B772B561CEB26", "_encstr_86DC17320FBE261B37BEC9BAB1BEB1DB73E8E6EEB259E0FA91", "_encstr_A5DC17461ED726D89BAFC9ABB1D76CED37A3B9DDCA56C1F566", "_encstr_832619D013AFA12FD309EE75DD497748F65BE0D0CF2D3B9FEA2147", "_encstr_872719BBD988024380FE925B70098B2AF8297F7F5BCD6B07D8C65A", "_encstr_8C26191A52F0EBBEF0CF0AF551694617804BE39359B5DBF968E741", "_encstr_AD2719FA6B60A326676F0383B12F8F62403B9AD71D70C37693A1F7"];

    if(issubstr(var_2.soundaliases[0], "_encstr_AB1A04B73511"))
      var_7 = scripts\engine\utility::array_remove(var_7, "_encstr_832619D013AFA12FD309EE75DD497748F65BE0D0CF2D3B9FEA2147");
    else if(issubstr(var_2.soundaliases[0], "_encstr_991A04876E3E"))
      var_7 = scripts\engine\utility::array_remove(var_7, "_encstr_872719BBD988024380FE925B70098B2AF8297F7F5BCD6B07D8C65A");
    else if(issubstr(var_2.soundaliases[0], "_encstr_841A04EBB2AF"))
      var_7 = scripts\engine\utility::array_remove(var_7, "_encstr_8C26191A52F0EBBEF0CF0AF551694617804BE39359B5DBF968E741");
    else if(issubstr(var_2.soundaliases[0], "_encstr_961A04A0D3F9"))
      var_7 = scripts\engine\utility::array_remove(var_7, "_encstr_AD2719FA6B60A326676F0383B12F8F62403B9AD71D70C37693A1F7");

    var_1 childthread stealthcommander(scripts\engine\utility::random(var_7));
  } else {}
}

isradioline(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 0;

  if(getsubstr(var_0, var_0.size - 2, var_0.size) == "_encstr_9207034F36")
    return 1;

  if(issubstr(var_0, "_encstr_A21A04F54EEB"))
    return 1;

  if(issubstr(var_0, "_encstr_8DCA083FE12218EFBB99"))
    return scripts\engine\utility::ter_op(var_1, "_encstr_962407F798BB453A39", 1);

  if(issubstr(var_0, "_encstr_96CA087FDBB73475B3A9"))
    return scripts\engine\utility::ter_op(var_1, "_encstr_8F2407590712215AF0", 1);

  if(issubstr(var_0, "_encstr_B6C5089976BB92691399"))
    return scripts\engine\utility::ter_op(var_1, "_encstr_A2280749D330F48720", 1);

  if(issubstr(var_0, "_encstr_96C50801601BF522AB70"))
    return scripts\engine\utility::ter_op(var_1, "_encstr_AB2807DF46D3CBFACF", 1);

  return 0;
}

playradioecho(var_0, var_1, var_2, var_3) {
  anim endon("_encstr_AAED17080A03C9A8BF53038F3C83F18D7EC2D838A25E014193");
  self endon("_encstr_85180FA487BC1720A4BB20EAC25351FF30");
  self endon("_encstr_AD75063D571AE108");

  if(getDvar("_encstr_86F11298C637F59C1619D2DEAC6CD0DEAFED33CC") == self.team || getDvar("_encstr_86F11298C637F59C1619D2DEAC6CD0DEAFED33CC") == "_encstr_AF1904A7F929") {
    return;
  }
  if(isDefined(self.battlechatter.customgroup)) {
    var_4 = self.battlechatter.customgroup;
    self.battlechatter.customgroup = undefined;
  } else if(isDefined(scripts\stealth\group::getgroup(self.script_stealthgroup)))
    var_4 = level.stealth.groupdata.groups[self.script_stealthgroup].members;
  else
    var_4 = anim.squads[self.team].members;

  var_4 = scripts\engine\utility::array_remove(var_4, self);

  foreach(var_6 in var_4) {
    if(isDefined(var_6.unittype) && var_6.unittype == "_encstr_AA180446F6EC")
      var_4 = scripts\engine\utility::array_remove(var_4, var_6);
  }

  var_4 = scripts\engine\utility::array_removeundefined(var_4);

  if(var_4.size == 0) {
    return;
  }
  var_8 = scripts\cp\utility::get_within_range(level.players[0].origin, var_4, sqrt(level.bcs_maxstealthdistsqrdfromplayer));

  foreach(var_6 in var_8)
  var_6 thread _playradioecho(var_0, var_1, self, var_2, var_3);
}

uselocationbc(var_0) {
  var_1 = getvalidlocation(self, "_encstr_830E086EE82B0B361D86", var_0);

  if(isDefined(var_1))
    return 1;

  return 0;
}

_playradioecho(var_0, var_1, var_2, var_3, var_4) {
  anim endon("_encstr_AAED17080A03C9A8BF53038F3C83F18D7EC2D838A25E014193");
  self endon("_encstr_85180FA487BC1720A4BB20EAC25351FF30");
  self endon("_encstr_AD75063D571AE108");
  var_2 endon("_encstr_AD75063D571AE108");

  if(!istrue(var_3)) {
    var_5 = var_0 + "_encstr_8F1F0907DBD1F2F84D395C";
    var_6 = var_2 scripts\engine\utility::waittill_notify_or_timeout_return(var_5, 2);

    if(var_6 == var_5)
      return;
  }

  wait 0.15;

  if(isDefined(var_4))
    var_0 = var_4;
  else if(isDefined(var_1)) {
    var_7 = strtok(var_0, "_encstr_BA4C02DF");
    var_0 = "_encstr_B40101";

    for(var_8 = 0; var_8 < var_7.size; var_8++) {
      if(var_8 == var_7.size - 1) {
        var_0 = var_0 + "_encstr_9507034EBE" + var_7[var_8];
        continue;
      }

      var_0 = var_0 + var_7[var_8] + "_encstr_BA4C02DF";
    }
  }

  thread playradio(var_0);
}

stealthidlealert(var_0) {
  var_1 = self;
  var_1 endon("_encstr_AD75063D571AE108");
  var_1 endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");
  var_2 = var_1 createchatphrase();
  var_2 addstealthalias("_encstr_A16D0B492D908FC1D36852DB50", var_0);
  var_3 = var_1 playphrase(var_2, self);

  if(stealthdocustombc(var_3)) {
    return;
  }
  if(var_3 && isDefined(var_2.checkin) && var_1 getbcstate() == "_encstr_85BB067A08A3FAB3") {
    foreach(var_5 in var_2.responsealiases) {
      var_2.soundaliases = [];
      var_2.soundaliases[0] = var_5;

      if(isradioline(var_5))
        var_3 = var_1 stealthcommander(var_2.soundaliases[0]);
      else {
        var_1 commander_delay();
        var_1 childthread playradioecho(var_2.soundaliases[0], 1, 1);
        var_3 = var_1 playphrase(var_2, self);
      }

      if(!var_3 || var_1 getbcstate() != "_encstr_85BB067A08A3FAB3") {
        break;
      }
    }
  } else if(var_3 && isDefined(var_2.callin)) {
    if(isDefined(var_2.responsealiases[0]) && randomint(4))
      var_1 childthread stealthcommander(var_2.responsealiases[0]);
  } else {}
}

stealthcommander(var_0) {
  if(getDvar("_encstr_83071206F19BC7A2385337FFAD550A22B9D8BF8F") == self.team || getDvar("_encstr_83071206F19BC7A2385337FFAD550A22B9D8BF8F") == "_encstr_AF1904A7F929")
    return 0;

  commander_delay();
  childthread playradioecho(var_0, undefined, 1);
  playradio(var_0);
  return 1;
}

playradio(var_0) {
  if(self == anim.player) {
    var_1 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", anim.player getEye());
    var_1 linkTo(self);
  } else {
    var_1 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", self gettagorigin("_encstr_AFDD09A4FA844B1CBE4994"));
    var_1 linkTo(self);
  }

  if(battlechatter_canprint())
    battlechatter_print([var_0 + "_encstr_88CA0702390B234BDB"]);

  if(soundexists(var_0)) {
    var_1 playSound(var_0);
    wait(lookupsoundlength(var_0) / 1000);
  } else
    battlechatter_printwarning("_encstr_92C72D514EB42B9110A3BD0438D816BC02B037080B63D258B904E8D02C1D0246DECADCB94EA30456E12DDC8E7401E4" + var_0 + "_encstr_850703A665");

  var_1 delete();
}

bcs_setup_teams_array() {
  if(!isDefined(anim.teams)) {
    anim.teams = [];
    anim.teams[anim.teams.size] = "_encstr_8E8405EA382B2A";
    anim.teams[anim.teams.size] = "_encstr_9A8507BA4040188D08";
    anim.teams[anim.teams.size] = "_encstr_B848067B63177293";
    anim.teams[anim.teams.size] = "_encstr_A7A408B9CA5D1D4E2C63";
  }
}

bcs_setup_countryids() {
  if(!isDefined(anim.usedids)) {
    anim.usedids = [];
    anim.flavorburstvoices = [];
    anim.countryids = [];
    bcs_setup_voice("_encstr_8A390E2F88D07452C1384E0393EFDA3B", "_encstr_B407036B35", 6, 1);
    bcs_setup_voice("_encstr_BAA814DBED11D8CDC2335371075A8058B88760505754", "_encstr_B407036B35", 6, 1);
    bcs_setup_voice("_encstr_AF5E14AB37A5A3AC237316E82DB737B96659AD851B95", "_encstr_B407036B35", 3, 1);
    bcs_setup_voice("_encstr_834D07DCACE823CA33", "_encstr_B807035AA4", 5);
    bcs_setup_voice("_encstr_8BD90D13804B3C120DDFE3AFC9A53B", "_encstr_B81904AA6A6A", 3, 1);
    bcs_setup_voice("_encstr_A67A134BD0ABF37F08D74C21A17882F3C528826219", "_encstr_A1E405C39E7441", 1, 1);
    bcs_setup_voice("_encstr_81190403AE66", "_encstr_B81904AA6A6A", 3, 1);
    bcs_setup_voice("_encstr_978D0A1B20CFBFB7B0A77C6D", "_encstr_A1E405C39E7441", 1, 1);
    bcs_setup_voice("_encstr_841804CCB9B0", "_encstr_841804C8A9A0", 3, 1);
    bcs_setup_voice("_encstr_A1440A8C62AA7519DD2FC0B0", "_encstr_99780523350A19", 1, 1);

    switch (getDvar("_encstr_ACCE11131B37AFCCDB396C5654733BB1D23734")) {
      case "_encstr_AF1904A7F929":
      case "_encstr_8E8405EA382B2A":
        bcs_setup_voice("_encstr_9A01098842DA4B0317F42F", "_encstr_B81904AA6A6A", 3);
        bcs_setup_voice("_encstr_8A500F91A5B1C8FDDA631B2D7F224F687D", "_encstr_A1E405C39E7441", 1);
        bcs_setup_voice("_encstr_964A08F5B3EE7B335128", "_encstr_B81904AA6A6A", 3);
        break;
      default:
        bcs_setup_voice("_encstr_9A01098842DA4B0317F42F", "_encstr_8507033F9B", 3);
        bcs_setup_voice("_encstr_8A500F91A5B1C8FDDA631B2D7F224F687D", "_encstr_8D1904284519", 1);
        bcs_setup_voice("_encstr_964A08F5B3EE7B335128", "_encstr_91070355A5", 3);
        break;
    }
  }
}

bcs_setup_voice(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3))
    var_3 = 0;

  anim.usedids[var_0] = [];

  for(var_4 = 0; var_4 < var_2; var_4++) {
    anim.usedids[var_0][var_4] = spawnStruct();
    anim.usedids[var_0][var_4].count = 0;
    anim.usedids[var_0][var_4].npcid = "_encstr_B40101" + (var_4 + 1);
  }

  anim.countryids[var_0] = var_1;
  anim.flavorburstvoices[var_0] = var_3;
}

bcs_setup_chatter_toggle_array() {
  bcs_setup_teams_array();

  if(!isDefined(level.battlechatter)) {
    level.battlechatter = [];

    foreach(var_1 in anim.teams)
    set_battlechatter_variable(var_1, 0);
  }
}

bcs_setup_flavorburst_toggle_array() {
  bcs_setup_teams_array();

  if(!isDefined(level.flavorbursts)) {
    level.flavorbursts = [];

    foreach(var_1 in anim.teams)
    level.flavorbursts[var_1] = 0;
  }
}

battlechatter_canprint() {
  return 0;
}

battlechatter_print(var_0) {
  if(var_0.size <= 0) {
    return;
  }
  if(!battlechatter_canprint()) {
    return;
  }
  var_1 = "_encstr_B41A04F2D401";

  if(enemy_team_name())
    var_1 = "_encstr_8C1A049B52E1";

  var_2 = (0, 0, -7);

  foreach(var_4 in var_0) {}
}

battlechatter_draw_arrow(var_0, var_1, var_2, var_3) {
  var_4 = var_1 + anglesToForward(vectortoangles(var_1 - var_0)) * -40;
  var_4 = var_4 + anglestoright(vectortoangles(var_1 - var_0)) * 18;
  var_4 = var_1 + anglesToForward(vectortoangles(var_1 - var_0)) * -40;
  var_4 = var_4 + anglestoright(vectortoangles(var_1 - var_0)) * -18;
}

battlechatter_canprintscreen() {
  return 0;
}

battlechatter_printscreenadd(var_0, var_1) {
  if(!isDefined(level.battlechatter))
    level.battlechatter = [];

  if(!isDefined(level.battlechatter["_encstr_86A00CCF6A622D639B6F48F85FAE"]))
    level.battlechatter["_encstr_86A00CCF6A622D639B6F48F85FAE"] = [];

  if(!isDefined(level.battlechatter["_encstr_86A00CCF6A622D639B6F48F85FAE"]["_encstr_8E8405EA382B2A"]))
    level.battlechatter["_encstr_86A00CCF6A622D639B6F48F85FAE"]["_encstr_8E8405EA382B2A"] = [];

  if(!isDefined(level.battlechatter["_encstr_86A00CCF6A622D639B6F48F85FAE"]["_encstr_9A8507BA4040188D08"]))
    level.battlechatter["_encstr_86A00CCF6A622D639B6F48F85FAE"]["_encstr_9A8507BA4040188D08"] = [];

  if(!isDefined(level.battlechatter["_encstr_86A00CCF6A622D639B6F48F85FAE"]["_encstr_B848067B63177293"]))
    level.battlechatter["_encstr_86A00CCF6A622D639B6F48F85FAE"]["_encstr_B848067B63177293"] = [];

  var_2 = level.battlechatter["_encstr_86A00CCF6A622D639B6F48F85FAE"][self.team].size;

  if(var_2 > 40) {
    level.battlechatter["_encstr_86A00CCF6A622D639B6F48F85FAE"][self.team] = scripts\engine\utility::array_remove_index(level.battlechatter["_encstr_86A00CCF6A622D639B6F48F85FAE"][self.team], 0);
    var_2 = level.battlechatter["_encstr_86A00CCF6A622D639B6F48F85FAE"][self.team].size;
  }

  level.battlechatter["_encstr_86A00CCF6A622D639B6F48F85FAE"][self.team][var_2]["_encstr_B1BB065693AAAAB7"] = var_0;
  level.battlechatter["_encstr_86A00CCF6A622D639B6F48F85FAE"][self.team][var_2]["_encstr_A18E06C6F663DB9C"] = var_1;
  level thread battlechatter_printscreen();
}

battlechatter_printscreen() {
  self notify("_encstr_86311133A0E3B5FB4BAE6A75B5308F3A31B0BB");
  self endon("_encstr_86311133A0E3B5FB4BAE6A75B5308F3A31B0BB");

  if(!isDefined(level.battlechatter))
    level.battlechatter = [];

  if(!isDefined(level.battlechatter["_encstr_86A00CCF6A622D639B6F48F85FAE"]))
    level.battlechatter["_encstr_86A00CCF6A622D639B6F48F85FAE"] = [];

  var_0 = 220;
  var_1 = 30;
  var_2 = 600;
  var_3 = 1170;

  for(;;) {
    var_4 = var_0;

    for(var_5 = 0; var_5 < level.battlechatter["_encstr_86A00CCF6A622D639B6F48F85FAE"]["_encstr_8E8405EA382B2A"].size; var_5++)
      var_4 = var_4 + 18;

    var_4 = var_0;

    for(var_5 = 0; var_5 < level.battlechatter["_encstr_86A00CCF6A622D639B6F48F85FAE"]["_encstr_9A8507BA4040188D08"].size; var_5++)
      var_4 = var_4 + 18;

    var_4 = var_0;

    for(var_5 = 0; var_5 < level.battlechatter["_encstr_86A00CCF6A622D639B6F48F85FAE"]["_encstr_B848067B63177293"].size; var_5++)
      var_4 = var_4 + 18;

    waitframe();
  }
}

commander_delay() {
  wait(randomfloatrange(0.3, 0.4));
}

cansay(var_0, var_1, var_2) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");

  if(!isDefined(anim.player))
    return 0;

  if(isPlayer(self)) {
    if(!isDefined(anim.player.battlechatterallowed) || isDefined(anim.player.battlechatterallowed) && !anim.player.battlechatterallowed)
      return 0;
  }

  if(var_0 == "_encstr_830E086EE82B0B361D86") {
    if(distancesquared(anim.player.origin, self.origin) > level.bcs_maxstealthdistsqrdfromplayer)
      return 0;
  } else if(distancesquared(anim.player.origin, self.origin) > level.bcs_maxtalkingdistsqrdfromplayer)
    return 0;

  if(!isDefined(self.battlechatterallowed) || !self.battlechatterallowed || !isDefined(self.battlechatter.nextsaytimes))
    return 0;

  if(isDefined(var_2) && var_2 >= 1)
    return 1;

  if(gettime() + anim.eventactionminwait[var_0]["_encstr_831805DFAF3BF3"] < self.battlechatter.nextsaytimes[var_0])
    return 0;

  if(gettime() + anim.eventactionminwait[var_0]["_encstr_8C950626C2CB5B19"] < self.squad.nextsaytimes[var_0])
    return 0;

  if(isDefined(var_1) && typelimited(var_0, var_1))
    return 0;

  if(isDefined(var_1) && anim.eventpriority[var_0][var_1] < self.battlechatter.minpriority)
    return 0;

  if(issentient(self) && self.ignoreall)
    return 0;

  if(isDefined(self.fnisinstealthidlescriptedanim) && self[[self.fnisinstealthidlescriptedanim]]())
    return 0;

  if(!isPlayer(self) && self isinscriptedstate())
    return 0;

  return 1;
}

getresponder(var_0, var_1, var_2) {
  var_3 = undefined;

  if(!isDefined(var_2))
    var_2 = "_encstr_840709B34F76BBF8F072C7";

  if(!isDefined(self.squad)) {
    return;
  }
  var_4 = scripts\engine\utility::array_randomize(self.squad.members);
  var_0 = var_0 * var_0;
  var_1 = var_1 * var_1;

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    if(var_4[var_5] == self) {
      continue;
    }
    if(!isalive(var_4[var_5])) {
      continue;
    }
    var_6 = distancesquared(self.origin, var_4[var_5].origin);

    if(var_6 < var_0) {
      continue;
    }
    if(var_6 > var_1) {
      continue;
    }
    if(isusingsamevoice(var_4[var_5])) {
      continue;
    }
    if(!var_4[var_5] cansay(var_2)) {
      continue;
    }
    var_3 = var_4[var_5];

    if(cansayname(var_3)) {
      break;
    }
  }

  return var_3;
}

isnodecoverorconceal() {
  var_0 = self.node;

  if(!isDefined(var_0))
    return 0;

  if(issubstr(var_0.type, "_encstr_B68E06D0F6B3CA27") || issubstr(var_0.type, "_encstr_8BF608EDC8D8CFD8F9A8"))
    return 1;

  return 0;
}

bcsenabled() {
  if(isDefined(anim.chatinitialized))
    return anim.chatinitialized;

  return 0;
}

cansayname(var_0) {
  if(enemy_team_name())
    return 0;

  if(!isDefined(var_0.bcname))
    return 0;

  if(var_0.battlechatterallowed == 0)
    return 0;

  if(!isDefined(var_0.battlechatter.countryid))
    return 0;

  if(!isDefined(self.battlechatter.countryid))
    return 0;

  if(self.battlechatter.countryid != var_0.battlechatter.countryid)
    return 0;

  if(namesaidrecently(var_0))
    return 0;

  var_1 = undefined;

  if(isPlayer(self))
    var_1 = "_encstr_BD790D05B4D869195BF14DF1A5F8AE" + var_0.bcname;
  else
    var_1 = bc_prefix() + "_encstr_AAFF0652B86BF7D7" + var_0.bcname;

  if(soundexists(var_1))
    return 1;

  return 0;
}

bc_prefix(var_0) {
  if(!isDefined(self.battlechatter.npcid))
    self.battlechatter.npcid = "_encstr_B40101";

  if(self == anim.player)
    return "_encstr_A75308073DEF30819BBF";

  if(isDefined(var_0) && var_0 == "_encstr_830E086EE82B0B361D86") {
    if(getDvar("_encstr_934E0F96CB67466FAB5A59688286317BA3") != "_encstr_BA19049F4B2D")
      return tolower("_encstr_A1580819F0D7DB1D73FA" + self.battlechatter.countryid + self.battlechatter.npcid + "_encstr_BA4C02DF");
    else
      return tolower("_encstr_927B08CBA9F86223E8AE" + self.battlechatter.countryid + self.battlechatter.npcid + "_encstr_BA4C02DF");
  } else if(isDefined(var_0) && var_0 == "_encstr_BD34078D57B9A37BD6")
    return tolower("_encstr_B21C08C8F0D7CEB75BF5" + self.battlechatter.countryid + self.battlechatter.npcid + "_encstr_BA4C02DF");
  else if(isDefined(var_0) && var_0 == "_encstr_A22F0DC6AB6E477BAD01932C23B4B7")
    return tolower("_encstr_B444074120C7C50F4D");
  else if(getDvar("_encstr_A2140ED2994E8725A0D55377FB386E93") != "_encstr_BA19049F4B2D") {
    if(isarray(getDvar("_encstr_A2140ED2994E8725A0D55377FB386E93"))) {
      if(isDefined(self.team) && scripts\engine\utility::array_contains(getDvar("_encstr_A2140ED2994E8725A0D55377FB386E93"), self.team))
        return tolower("_encstr_A1580819F0D7DB1D73FA" + self.battlechatter.countryid + self.battlechatter.npcid + "_encstr_BA4C02DF");
    } else if(isDefined(self.team) && self.team == getDvar("_encstr_A2140ED2994E8725A0D55377FB386E93"))
      return tolower("_encstr_A1580819F0D7DB1D73FA" + self.battlechatter.countryid + self.battlechatter.npcid + "_encstr_BA4C02DF");
    else
      return tolower("_encstr_8D7B08B073CFE14DB2A9" + self.battlechatter.countryid + self.battlechatter.npcid + "_encstr_BA4C02DF");
  } else
    return tolower("_encstr_8D7B08B073CFE14DB2A9" + self.battlechatter.countryid + self.battlechatter.npcid + "_encstr_BA4C02DF");
}

namesaidrecently(var_0) {
  if(anim.lastnamesaid[self.team] == var_0.bcname || gettime() - anim.lastnamesaidtime[self.team] < anim.lastnamesaidtimeout)
    return 1;

  return 0;
}

enemy_team_name() {
  if(issentient(self) && self isbadguy())
    return 1;
  else
    return 0;
}

isusingsamevoice(var_0) {
  if(!isDefined(var_0.battlechatter))
    return 0;

  if(isstring(self.battlechatter.npcid) && isstring(var_0.battlechatter.npcid) && self.battlechatter.npcid == var_0.battlechatter.npcid)
    return 1;
  else if(!isstring(self.battlechatter.npcid) && !isstring(var_0.battlechatter.npcid) && self.battlechatter.npcid == var_0.battlechatter.npcid)
    return 1;
  else
    return 0;
}

typelimited(var_0, var_1) {
  if(!isDefined(anim.eventtypeminwait[var_0][var_1]))
    return 0;

  if(!isDefined(self.squad.nexttypesaytimes[var_0][var_1]))
    return 0;

  if(gettime() > self.squad.nexttypesaytimes[var_0][var_1])
    return 0;

  return 1;
}

updatecontact(var_0, var_1) {
  if(gettime() - self.squadlist[var_0].lastcontact > 10000) {
    var_2 = 0;

    for(var_3 = 0; var_3 < self.members.size; var_3++) {
      if(self.members[var_3] != var_1 && isalive(self.members[var_3].enemy) && isDefined(self.members[var_3].enemy.squad) && self.members[var_3].enemy.squad.squadname == var_0)
        var_2 = 1;
    }

    if(!var_2) {
      self.squadlist[var_0].firstcontact = gettime();
      self.squadlist[var_0].calledout = 0;
    }
  }

  self.squadlist[var_0].lastcontact = gettime();
}

threatwasalreadycalledout(var_0) {
  if(isDefined(var_0.battlechatter.calledout) && isDefined(var_0.battlechatter.calledout[self.squad.squadname])) {
    if(var_0.battlechatter.calledout[self.squad.squadname].expiretime > gettime())
      return 1;
  }

  return 0;
}

playbattlechatter(var_0) {
  if(!isalive(self)) {
    return;
  }
  if(!isDefined(self.team)) {
    return;
  }
  if(!bcsenabled()) {
    return;
  }
  if(isDefined(self._animactive) && self._animactive > 0) {
    self.battlechatter.stealthidledelay = 4000 + gettime();
    return;
  }

  if(isDefined(self._blackboard) && isDefined(self._blackboard.idlenode)) {
    self.battlechatter.stealthidledelay = 5500 + gettime();
    return;
  }

  if(isDefined(self.battlechatter.isspeaking) && self.battlechatter.isspeaking) {
    return;
  }
  if(!isDefined(self.team) || isDefined(self.team) && self.team == "_encstr_9A8507BA4040188D08" && isDefined(anim.scripteddialoguestarttime)) {
    if(anim.scripteddialoguestarttime + anim.scripteddialoguebuffertime > gettime())
      return;
  }

  if(friendlyfire_warning()) {
    return;
  }
  if(!isDefined(self.battlechatterallowed) || !self.battlechatterallowed) {
    return;
  }
  if(anim.isteamspeaking[self.team]) {
    return;
  }
  self endon("_encstr_AD75063D571AE108");

  if(!isDefined(var_0))
    var_0 = gethighestpriorityevent();

  if(isDefined(self.bc_event_override))
    var_0 = self.bc_event_override;

  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(self.melee)) {
    if(isDefined(self.melee.inprogress)) {
      if(self.melee.inprogress)
        return;
    }
  }

  if(self == anim.player) {
    if(!isDefined(anim.player.battlechatterallowed) || isDefined(anim.player.battlechatterallowed) && !anim.player.battlechatterallowed) {
      return;
    }
    if(!isDefined(anim.player.bcscooldown) || anim.player.bcscooldown != 0)
      return;
    else
      level notify("_encstr_BEF31DDA6059D84528C7604683F013A1C2EB4231ABCFC03E8E2F9A30052B20");
  }

  switch (var_0) {
    case "_encstr_BD34078D57B9A37BD6":
      thread playcustomevent();
      break;
    case "_encstr_840709B34F76BBF8F072C7":
      thread playresponseevent();
      break;
    case "_encstr_88720627AD68179B":
      thread playorderevent();
      break;
    case "_encstr_85CB07BDE04321538B":
      thread playthreatevent();
      break;
    case "_encstr_8A66099C590B3647D2B79B":
      thread playreactionevent();
      break;
    case "_encstr_85E507408AF3D0F005":
      thread playinformevent();
      break;
    case "_encstr_830E086EE82B0B361D86":
      thread playstealthevent();
      break;
  }
}

can_say_friendlyfire(var_0) {
  if(isDefined(self.friendlyfire_warnings_disable))
    return 0;

  if(isDefined(self.melee)) {
    if(isDefined(self.melee.inprogress)) {
      if(self.melee.inprogress)
        return 0;
    }
  }

  if(!isDefined(self.battlechatter.chatqueue))
    return 0;

  if(!isDefined(self.battlechatter.chatqueue["_encstr_8A66099C590B3647D2B79B"]) || !isDefined(self.battlechatter.chatqueue["_encstr_8A66099C590B3647D2B79B"].eventtype))
    return 0;

  if(self.battlechatter.chatqueue["_encstr_8A66099C590B3647D2B79B"].eventtype != "_encstr_A54E0D719B1F05C0B7C45355F91A50")
    return 0;

  if(gettime() > self.battlechatter.chatqueue["_encstr_8A66099C590B3647D2B79B"].expiretime)
    return 0;

  if(!isDefined(var_0))
    var_0 = 1;

  if(var_0) {
    if(isDefined(self.squad.nexttypesaytimes["_encstr_8A66099C590B3647D2B79B"]["_encstr_A54E0D719B1F05C0B7C45355F91A50"])) {
      if(gettime() < self.squad.nexttypesaytimes["_encstr_8A66099C590B3647D2B79B"]["_encstr_A54E0D719B1F05C0B7C45355F91A50"])
        return 0;
    }
  }

  return 1;
}

friendlyfire_warning() {
  if(!can_say_friendlyfire())
    return 0;

  dotypelimit("_encstr_8A66099C590B3647D2B79B", "_encstr_A54E0D719B1F05C0B7C45355F91A50");
  thread playreactionevent();
  return 1;
}

dotypelimit(var_0, var_1) {
  if(!isDefined(anim.eventtypeminwait[var_0][var_1])) {
    return;
  }
  self.squad.nexttypesaytimes[var_0][var_1] = gettime() + anim.eventtypeminwait[var_0][var_1];
}

isvalidevent(var_0) {
  var_1 = gettime();

  if(!self.squad.ismembersaying[var_0] && !anim.isteamsaying[anim.teams[0]][var_0] && !anim.isteamsaying[anim.teams[1]][var_0] && !anim.isteamsaying[anim.teams[2]][var_0] && !anim.isteamsaying[anim.teams[3]][var_0] && gettime() < self.battlechatter.chatqueue[var_0].expiretime && gettime() > scaledsaytime(self.squad.nextsaytimes[var_0])) {
    if(!typelimited(var_0, self.battlechatter.chatqueue[var_0].eventtype))
      return 1;
  }

  return 0;
}

scaledsaytime(var_0) {
  if(!isDefined(self.battlechatter_saytimescaled))
    return var_0;

  var_1 = var_0 - gettime();

  if(var_1 <= 0)
    return var_0;
  else {
    var_1 = var_1 - var_1 * self.battlechatter_saytimescaled;
    var_1 = var_1 + gettime();
  }

  return var_1;
}

gethighestpriorityevent() {
  var_0 = undefined;
  var_1 = -999999999;

  foreach(var_4, var_3 in self.battlechatter.chatqueue) {
    if(isvalidevent(var_4)) {
      if(var_3.priority > var_1) {
        var_0 = var_4;
        var_1 = var_3.priority;
      }
    }
  }

  return var_0;
}

playcustomevent() {
  var_0 = self.battlechatter.chatqueue["_encstr_BD34078D57B9A37BD6"];
  self.curevent = self.battlechatter.chatqueue["_encstr_BD34078D57B9A37BD6"];
  self.curevent.eventaction = "_encstr_BD34078D57B9A37BD6";
  self.curevent.eventtype = "_encstr_979608DF73C8E70B73A1";
  var_1 = self;
  var_1 endon("_encstr_AD75063D571AE108");
  var_1 endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");
  anim thread lockaction(var_1, "_encstr_BD34078D57B9A37BD6", 1);
  var_2 = var_1 createchatphrase();
  var_2.soundaliases[0] = var_1.customchatphrase;
  var_1 playphrase(var_2, self);
  var_1 notify("_encstr_B4650E6A50F57FA2732F75694AD85307");
  var_1.customchatevent = undefined;
  var_1.customchatphrase = undefined;
}

playresponseevent() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");
  self.curevent = self.battlechatter.chatqueue["_encstr_840709B34F76BBF8F072C7"];
  var_0 = self.battlechatter.chatqueue["_encstr_840709B34F76BBF8F072C7"].modifier;
  var_1 = self.battlechatter.chatqueue["_encstr_840709B34F76BBF8F072C7"].respondto;

  if(!isalive(var_1)) {
    return;
  }
  if(self.battlechatter.chatqueue["_encstr_840709B34F76BBF8F072C7"].modifier == "_encstr_8A7C075CB720097810" && !scripts\asm\asm_bb::bb_moverequested()) {
    return;
  }
  anim thread lockaction(self, "_encstr_840709B34F76BBF8F072C7");

  switch (self.battlechatter.chatqueue["_encstr_840709B34F76BBF8F072C7"].eventtype) {
    case "_encstr_8E2508591EE07BE6B246":
      responsethreatexposed(var_1, var_0);
      break;
    case "_encstr_A99B08D609DBE0AF2B3B":
      responsethreatcallout(var_1, var_0, self.enemy);
      break;
    case "_encstr_A71904605AB4":
      responsegeneric(var_1, var_0);
      break;
    case "_encstr_AC6E09881A36337B5F6F30":
      responselocationcallout(var_1, var_0, self.enemy);
      break;
    default:
      responsegeneric(var_1, var_0);
      break;
  }

  self notify("_encstr_B4650E6A50F57FA2732F75694AD85307");
}

responsethreatexposed(var_0, var_1) {
  var_2 = self;
  var_2 endon("_encstr_AD75063D571AE108");
  var_2 endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");

  if(!isalive(var_0)) {
    return;
  }
  var_3 = var_2 createchatphrase();
  var_3 addthreatexposedalias(var_1);
  var_3.bc_looktarget = var_0;
  var_3.master = 1;
  var_2 playphrase(var_3, self);
}

addthreatcalloutecho(var_0, var_1) {
  var_2 = createechoalias(var_0, var_1);

  if(!soundexists(var_2)) {
    battlechatter_printwarning("_encstr_957318FD822B1C288EE6ABAD0C5678F69BDA19213A4F6758A6BF" + var_2 + "_encstr_850703A665");
    return 0;
  }

  self.soundaliases[self.soundaliases.size] = var_2;
  return 1;
}

createechoalias(var_0, var_1) {
  var_2 = "_encstr_8D6308CF75B88A27A62B";
  var_3 = "_encstr_A2D206690D0742A7";
  var_4 = undefined;

  if(var_1 == anim.player)
    var_5 = "_encstr_881904073639";
  else
    var_5 = var_1.battlechatter.npcid;

  if(self.owner == anim.player)
    var_4 = self.owner.battlechatter.countryid + "_encstr_866E063902AD8677";
  else
    var_4 = self.owner bc_prefix() + "_encstr_B40101";

  var_6 = var_0.size - var_2.size;

  if(self.owner == anim.player) {
    var_7 = self.owner.battlechatter.countryid + "_encstr_866E063902AD8677";
    var_8 = var_7.size;
  } else {
    var_7 = self.owner.battlechatter.countryid + "_encstr_BA4C02DF" + var_5 + "_encstr_BA4C02DF";
    var_8 = var_7.size;
  }

  var_9 = getsubstr(var_0, var_8, var_6);
  var_10 = var_4 + var_9 + var_3;
  return var_10;
}

responsethreatcallout(var_0, var_1, var_2) {
  var_3 = self.curevent.reportalias;
  var_4 = self.curevent.location;
  var_5 = self;
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");

  if(!isalive(var_0)) {
    return;
  }
  var_6 = var_5 createchatphrase();
  var_7 = 0;

  if(var_1 == "_encstr_8B60059536347B")
    var_7 = var_6 addthreatcalloutecho(var_3, var_0);
  else if(var_1 == "_encstr_8507037FBB")
    var_7 = var_6 addthreatcalloutqa_nextline(var_0, var_3, var_4);
  else
    var_7 = var_6 addthreatcalloutresponsealias(var_1, var_2);

  if(!var_7) {
    return;
  }
  var_6.bc_looktarget = var_0;
  var_6.master = 1;
  var_5 playphrase(var_6, self);
}

addthreatcalloutqa_nextline(var_0, var_1, var_2) {
  var_3 = undefined;

  foreach(var_5 in var_2.locationaliases) {
    if(issubstr(var_1, var_5)) {
      var_3 = var_5;
      break;
    }
  }

  var_7 = self.owner bc_prefix() + "_encstr_B40101";
  var_8 = getsubstr(var_1, var_1.size - 1, var_1.size);
  var_9 = int(var_8) + 1;
  var_10 = var_7 + getbcstate() + "_encstr_B6B70B7DC67BC6B01DD27B9BEB" + var_3 + "_encstr_AA1A04F5172C" + var_9;

  if(!soundexists(var_10)) {
    if(randomint(100) < anim.eventchance["_encstr_840709B34F76BBF8F072C7"]["_encstr_86E6112FA828C45A5B8D695D7D17F284D0B88F"])
      var_0 scripts\cp\cp_battlechatter_ai::addresponseevent("_encstr_A99B08D609DBE0AF2B3B", "_encstr_B61904372BB3", self.owner, 0.9);
    else
      var_0 scripts\cp\cp_battlechatter_ai::addresponseevent("_encstr_8E2508591EE07BE6B246", "_encstr_82F309E237DB1B6B6367E9", self.owner, 0.9);

    var_2.qafinished = 1;
    return 0;
  }

  var_0 scripts\cp\cp_battlechatter_ai::addresponseevent("_encstr_A99B08D609DBE0AF2B3B", "_encstr_8507037FBB", self.owner, 0.9, var_10, var_2);
  self.soundaliases[self.soundaliases.size] = var_10;
  return 1;
}

addthreatcalloutresponsealias(var_0, var_1) {
  var_2 = undefined;

  if(!isDefined(var_0))
    var_0 = "_encstr_B40101";
  else
    var_0 = "_encstr_BA4C02DF" + var_0;

  var_2 = self.owner getbattlechatteralias("_encstr_BDF5105BD1C6435DF877FDFF41F0225F676B" + var_0);

  if(!soundexists(var_2)) {
    battlechatter_printwarning("_encstr_996824B70612825362ED2B8809BED179B1D3387D257F32208818EDC08BC99E910853BF8331D6" + var_2 + "_encstr_850703A665");
    return 0;
  }

  self.soundaliases[self.soundaliases.size] = var_2;
  return 1;
}

responsegeneric(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");

  if(!isalive(var_0)) {
    return;
  }
  var_2 = self.battlechatter.chatqueue["_encstr_840709B34F76BBF8F072C7"].eventtype;
  var_3 = self;
  var_4 = var_3 createchatphrase();
  var_4 addresponsealias(var_2, var_1);
  var_4.bc_looktarget = var_0;
  var_4.master = 1;
  var_3 playphrase(var_4, self);
}

responselocationcallout(var_0, var_1, var_2) {
  var_3 = self.curevent.reportalias;
  var_4 = self.curevent.location;
  var_5 = self;
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");

  if(!isalive(var_0)) {
    return;
  }
  var_6 = var_5 createchatphrase();
  var_7 = var_6 addlocationresponsealias(var_1, var_2);

  if(!var_7) {
    return;
  }
  var_6.bc_looktarget = var_0;
  var_6.master = 1;
  var_5 playphrase(var_6, self);
}

addlocationresponsealias(var_0, var_1) {
  var_2 = undefined;

  if(!isDefined(var_0))
    var_0 = "_encstr_B40101";
  else
    var_0 = "_encstr_BA4C02DF" + var_0;

  var_2 = self.owner getbattlechatteralias("_encstr_B68D121BF61BC247D2F6377D27ACCD83F673B9B2") + var_0;

  if(!soundexists(var_2)) {
    battlechatter_printwarning("_encstr_A25F252922AD77B3C22EFB6004EAF85F568A08F03A45B14B8F437FE8165F0189BEC26848538EE7" + var_2 + "_encstr_850703A665");
    return 0;
  }

  self.soundaliases[self.soundaliases.size] = var_2;
  return 1;
}

playorderevent() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");
  self.curevent = self.battlechatter.chatqueue["_encstr_88720627AD68179B"];
  var_0 = self.battlechatter.chatqueue["_encstr_88720627AD68179B"].modifier;
  var_1 = self.battlechatter.chatqueue["_encstr_88720627AD68179B"].orderto;
  anim thread lockaction(self, "_encstr_88720627AD68179B");

  switch (self.battlechatter.chatqueue["_encstr_88720627AD68179B"].eventtype) {
    case "_encstr_B40B07666F8BC31783":
      if(isDefined(self._blackboard))
        self._blackboard.battlechatter_target = anim.player;

      orderaction(var_0, var_1);
      break;
    case "_encstr_ACA20538F84D39":
      ordermove(var_0, var_1);
      break;
    case "_encstr_933609192D9B8363C2B156":
      orderdisplace(var_0);
      break;
  }

  if(isDefined(self._blackboard)) {
    self._blackboard.battlechatter_alias = undefined;
    self._blackboard.battlechatter_target = undefined;
  }

  self notify("_encstr_B4650E6A50F57FA2732F75694AD85307");
}

orderaction(var_0, var_1) {
  var_2 = self;
  var_2 endon("_encstr_AD75063D571AE108");
  var_2 endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");
  var_3 = var_2 createchatphrase();
  var_2 tryorderto(var_3, var_1);
  var_3 addorderalias("_encstr_B40B07666F8BC31783", var_0);
  var_2 playphrase(var_3, self);
}

ordermove(var_0, var_1) {
  var_2 = self;
  var_2 endon("_encstr_AD75063D571AE108");
  var_2 endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");
  var_3 = var_2 createchatphrase();
  var_2 tryorderto(var_3, var_1);
  var_3 addorderalias("_encstr_ACA20538F84D39", var_0);
  var_2 playphrase(var_3, self);
}

tryorderto(var_0, var_1) {
  if(randomint(100) > anim.eventchance["_encstr_840709B34F76BBF8F072C7"]["_encstr_88720627AD68179B"]) {
    if(!isDefined(var_1) || isDefined(var_1) && !isPlayer(var_1))
      return;
  }

  if(isDefined(var_1) && isPlayer(var_1) && isDefined(anim.player.bcnameid)) {
    var_0 addplayernamealias();
    var_0.bc_looktarget = anim.player;
  } else if(isDefined(var_1) && cansayname(var_1)) {
    var_0 addnamealias(var_1.bcname);
    var_0.bc_looktarget = var_1;
    var_1 scripts\cp\cp_battlechatter_ai::addresponseevent("_encstr_A71904605AB4", "_encstr_8CAB07EF58A11953A3", self, 0.9);
  } else
    level notify("_encstr_8D970D2C857BD827A72E705DE965B0", self);
}

orderdisplace(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");
  var_1 = self;
  var_2 = var_1 createchatphrase();
  var_2 addorderalias("_encstr_933609192D9B8363C2B156", var_0);
  var_1 playphrase(var_2, self, 1);
}

addorderalias(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = "_encstr_B40101";
  else
    var_1 = "_encstr_BA4C02DF" + var_1;

  var_2 = self.owner getbattlechatteralias("_encstr_88720627AD68179B" + var_1);

  if(!isDefined(var_2))
    return 0;

  self.soundaliases[self.soundaliases.size] = var_2;
  return 1;
}

playinformevent() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");
  self.curevent = self.battlechatter.chatqueue["_encstr_85E507408AF3D0F005"];
  var_0 = self.battlechatter.chatqueue["_encstr_85E507408AF3D0F005"].modifier;

  if(var_0 == "_encstr_979608DF73C8E70B73A1")
    var_0 = undefined;

  anim thread lockaction(self, "_encstr_85E507408AF3D0F005");

  if(self != anim.player)
    self._blackboard.battlechatter_target = anim.player;

  switch (self.battlechatter.chatqueue["_encstr_85E507408AF3D0F005"].eventtype) {
    case "_encstr_8A4F099025A3B8715A6B17":
      informincoming(var_0);
      break;
    case "_encstr_999A07C61338F9A23A":
      informattacking(var_0);
      break;
    case "_encstr_878B0A2323D11281F8F8551F":
      informreloading(var_0);
      break;
    case "_encstr_8E950B26FDE7F283FFA3F77B77":
      informsuppressed(var_0);
      break;
    case "_encstr_86B209B07AF529395F72B1":
      informkillfirm(var_0);
      break;
  }

  self notify("_encstr_B4650E6A50F57FA2732F75694AD85307");
}

playthreatevent() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");
  self endon("_encstr_BD4C109A81983FEFD881BBA013E8345F30F9");
  self.curevent = self.battlechatter.chatqueue["_encstr_85CB07BDE04321538B"];
  var_0 = self.battlechatter.chatqueue["_encstr_85CB07BDE04321538B"].threat;

  if(!isalive(var_0)) {
    return;
  }
  if(threatwasalreadycalledout(var_0) && !isPlayer(var_0)) {
    return;
  }
  anim thread lockaction(self, "_encstr_85CB07BDE04321538B");
  var_1 = 0;
  var_2 = self.battlechatter.chatqueue["_encstr_85CB07BDE04321538B"].eventtype;

  switch (var_2) {
    case "_encstr_A20C099FE504225E886B40":
      if(isPlayer(var_0) || !isDefined(var_0 getturret())) {
        if(isDefined(self._blackboard))
          self._blackboard.battlechatter_target = var_0;

        var_1 = threatinfantry(var_0, undefined);
      } else {}

      break;
    case "_encstr_82F309E237DB1B6B6367E9":
    case "_encstr_9A50080BA7292FFA0DA2":
      self.callout_type_override = var_2;
      var_1 = threatinfantry(var_0, undefined);
      break;
    case "_encstr_B2BC08303A77613B2FA4":
      self.callout_type_override = var_2;
      var_1 = threatinfantry(var_0, undefined);
      break;
  }

  var_3 = self;
  var_3 notify("_encstr_B4650E6A50F57FA2732F75694AD85307");

  if(!var_1) {
    return;
  }
  if(!isalive(var_0)) {
    return;
  }
  var_0.battlechatter.calledout[var_3.squad.squadname] = spawnStruct();
  var_0.battlechatter.calledout[var_3.squad.squadname].spotter = var_3;
  var_0.battlechatter.calledout[var_3.squad.squadname].threattype = var_3.battlechatter.chatqueue["_encstr_85CB07BDE04321538B"].eventtype;
  var_0.battlechatter.calledout[var_3.squad.squadname].expiretime = gettime() + anim.bcs_threatresettime;

  if(isDefined(var_0.squad))
    var_3.squad.squadlist[var_0.squad.squadname].calledout = 1;
}

getthreatinfantrycallouttype(var_0) {
  var_1 = var_0 getvalidlocation(self);
  var_2 = getdirectionfacingclock(self.angles, self.origin, var_0.origin);
  var_3 = getresponder(64, 1024, "_encstr_840709B34F76BBF8F072C7");
  var_4 = undefined;

  if(isDefined(var_3))
    var_4 = getdirectionfacingclock(var_3.angles, var_3.origin, var_0.origin);

  var_5 = getdirectionfacingclock(anim.player.angles, anim.player.origin, var_0.origin);

  if(self.team == "_encstr_9A8507BA4040188D08") {
    var_6 = var_5;
    var_7 = anim.player;
  } else if(isDefined(var_3)) {
    var_6 = var_4;
    var_7 = var_3;
  } else {
    var_6 = var_2;
    var_7 = self;
  }

  var_8 = getdistancemeters(var_7.origin, var_0.origin);
  self.possiblethreatcallouts = [];

  if(!isDefined(var_1) && var_0 isexposed(0))
    addpossiblethreatcallout("_encstr_8E2508591EE07BE6B246");

  if(self.team == "_encstr_9A8507BA4040188D08") {
    var_9 = 0;

    if(var_0.origin[2] - var_7.origin[2] >= level.heightforhighcallout) {
      if(addpossiblethreatcallout("_encstr_834E19FFA24A713DA2FF4372FDC85F93AF4E70CA1938D720BF1768"))
        var_9 = 1;
    }

    if(!var_9) {
      if(var_6 == "_encstr_8C0703491D") {
        addpossiblethreatcallout("_encstr_855D0FC1B185F2AC9C7DF64C3BA5DEBA37");

        if(var_8 > level.mindistancecallout && var_8 < level.maxdistancecallout)
          addpossiblethreatcallout("_encstr_8B3C1059F1C7C3CB83782CDF93CB39B2D39D");
      }

      if(cansayplayername() && var_6 != "_encstr_8C0703491D") {
        addpossiblethreatcallout("_encstr_8C631507D8165EB24EAFB1F69B1D588DA3FAD88DDEC6B6");
        addpossiblethreatcallout("_encstr_8F4914586BB9FA1BEB11850732D25303DFFF6328CF5B");
        addpossiblethreatcallout("_encstr_8FE6108308376FD79327C3C955989C6B6F60");
      }
    }
  }

  var_9 = 0;

  if(var_0.origin[2] - var_7.origin[2] >= level.heightforhighcallout) {
    if(addpossiblethreatcallout("_encstr_B6B7158596FAE8B09CCE2B1DEB1B8D7BB16DBED096B386"))
      var_9 = 1;
  }

  addpossiblethreatcallout("_encstr_B4731043E9A960C7BF3B49D0A1C70948FE73");

  if(!var_9) {
    if(var_6 == "_encstr_8C0703491D") {
      addpossiblethreatcallout("_encstr_9B7F0C0BD2EB46D29B8EC2CD8DAC");

      if(var_8 > level.mindistancecallout && var_8 < level.maxdistancecallout)
        addpossiblethreatcallout("_encstr_B1610BB3D781C068F6DC603B42");
    }

    addpossiblethreatcallout("_encstr_86A411B288082775C051A1AB39213E434861AA");
    addpossiblethreatcallout("_encstr_962A100B96EBE816E4CE5947EBD863DBB1AD");
    addpossiblethreatcallout("_encstr_83240CF857AF812BC3C763F89E7A");
  }

  if(isDefined(var_1)) {
    if(canconcat(var_1) && scripts\engine\utility::cointoss())
      addpossiblethreatcallout("_encstr_A3731036F6731B168EAFD87BD816A3A5DECD");
    else if(isDefined(var_1 getcannedresponse(self))) {
      if(isDefined(var_3))
        addpossiblethreatcallout("_encstr_8F100C0BD2D763EDB116D15ABD9B");
      else {
        battlechatter_printwarning("_encstr_A62A2286E7819A09A850F2C72803B8B2F18915065FE98247F052EF539A58A27AC793DD6E" + var_1.origin + "_encstr_97763FE293BC01E07299EFB671A3E8FB274EC8404B927F780785E11F4A97D3398B32F860423E9B3337E8D8A0606FBC27E60A5818FAD6F9A8FAC255A6282FCDC1CD");

        if(cansayplayername())
          addpossiblethreatcallout("_encstr_9A7C100ED80B5E56E47D63DB1BC23AB47BCD");

        addpossiblethreatcallout("_encstr_9A0E11705DF51B9A64698799D0E6A1ABFB388D");
      }
    } else {
      if(isDefined(var_3))
        addpossiblethreatcallout("_encstr_8F100C0BD2D763EDB116D15ABD9B");

      if(cansayplayername() || isDefined(self.override_bc_playername))
        addpossiblethreatcallout("_encstr_9A7C100ED80B5E56E47D63DB1BC23AB47BCD");

      addpossiblethreatcallout("_encstr_9A0E11705DF51B9A64698799D0E6A1ABFB388D");
    }
  }

  if(!self.possiblethreatcallouts.size)
    return undefined;

  var_10 = getweightedchanceroll(self.possiblethreatcallouts, anim.threatcallouts);
  var_11 = spawnStruct();
  var_11.type = var_10;
  var_11.responder = var_3;
  var_11.responderclockdirection = var_4;
  var_11.playerclockdirection = var_5;

  if(isDefined(var_1))
    var_11.location = var_1;

  return var_11;
}

isexposed(var_0) {
  if(distancesquared(self.origin, anim.player.origin) > 2250000)
    return 0;

  if(isDefined(var_0) && var_0 && isDefined(getlocation()))
    return 0;

  var_1 = bcgetclaimednode();

  if(!isDefined(var_1))
    return 1;

  if(!isnodecoverorconceal())
    return 0;

  return 1;
}

getlocation() {
  var_0 = get_all_my_locations();
  var_0 = scripts\engine\utility::array_randomize(var_0);
  var_1 = undefined;

  if(var_0.size)
    var_1 = _getlocation(var_0);

  return var_1;
}

addpossiblethreatcallout(var_0) {
  var_1 = 0;

  if(isDefined(self.allowedcallouts)) {
    foreach(var_3 in self.allowedcallouts) {
      if(var_3 == var_0) {
        if(!callouttypewillrepeat(var_0))
          var_1 = 1;

        break;
      }
    }
  }

  if(!var_1)
    return var_1;

  self.possiblethreatcallouts[self.possiblethreatcallouts.size] = var_0;
  return var_1;
}

callouttypewillrepeat(var_0) {
  if(!isDefined(anim.lastteamthreatcallout[self.team]))
    return 0;

  if(!isDefined(anim.lastteamthreatcallouttime[self.team]))
    return 0;

  var_1 = anim.lastteamthreatcallout[self.team];
  var_2 = anim.lastteamthreatcallouttime[self.team];
  var_3 = anim.teamthreatcalloutlimittimeout;

  if(var_0 == var_1 && gettime() - var_2 < var_3)
    return 1;

  return 0;
}

canconcat(var_0) {
  var_1 = var_0.locationaliases;

  foreach(var_3 in var_1) {
    if(iscallouttypeconcat(var_3, self))
      return 1;
  }

  return 0;
}

iscallouttypeconcat(var_0, var_1) {
  var_0 = var_1 getloccalloutalias(getbcstate() + "_encstr_8E8B1247E18002518808C58DE618970A6E1313CF" + var_0);

  if(soundexists(var_0))
    return 1;

  return 0;
}

getweightedchanceroll(var_0, var_1) {
  var_2 = undefined;
  var_3 = -1;

  foreach(var_5 in var_0) {
    if(var_1[var_5] <= 0) {
      continue;
    }
    var_6 = randomint(var_1[var_5]);

    if(isDefined(var_2) && var_1[var_2] >= 100) {
      if(var_1[var_5] < 100)
        continue;
    } else {
      if(var_1[var_5] >= 100) {
        var_2 = var_5;
        var_3 = var_6;
        continue;
      }

      if(var_6 > var_3) {
        var_2 = var_5;
        var_3 = var_6;
      }
    }
  }

  return var_2;
}

threatinfantry(var_0, var_1) {
  self endon("_encstr_BD4C109A81983FEFD881BBA013E8345F30F9");
  var_2 = createchatphrase();
  var_2.master = 1;
  var_2.threatent = var_0;
  var_3 = getthreatinfantrycallouttype(var_0);

  if(!isDefined(var_3) || isDefined(var_3) && !isDefined(var_3.type))
    return 0;

  var_4 = undefined;

  if(isDefined(self.callout_type_override))
    var_4 = self.callout_type_override;
  else
    var_4 = var_3.type;

  switch (var_4) {
    case "_encstr_8E2508591EE07BE6B246":
      if(isDefined(self._blackboard))
        self._blackboard.battlechatter_target = var_3.responder;

      var_5 = doexposedcalloutresponse(var_3.responder);
      var_6 = self;

      if(var_5 && var_6 cansayname(var_3.responder)) {
        var_2 addnamealias(var_3.responder.bcname);
        var_2.bc_looktarget = var_3.responder;
      }

      var_2 threatinfantryexposed(var_0);

      if(var_5) {
        if(randomint(100) < anim.eventchance["_encstr_840709B34F76BBF8F072C7"]["_encstr_86E6112FA828C45A5B8D695D7D17F284D0B88F"])
          var_3.responder scripts\cp\cp_battlechatter_ai::addresponseevent("_encstr_A99B08D609DBE0AF2B3B", "_encstr_B61904372BB3", self, 0.9);
        else
          var_3.responder scripts\cp\cp_battlechatter_ai::addresponseevent("_encstr_8E2508591EE07BE6B246", "_encstr_82F309E237DB1B6B6367E9", self, 0.9);
      }

      break;
    case "_encstr_82F309E237DB1B6B6367E9":
      var_2 addplayernamealias();
      var_2 addthreatcalloutalias("_encstr_82F309E237DB1B6B6367E9", var_3.playerclockdirection);
      break;
    case "_encstr_B2BC08303A77613B2FA4":
      var_2 addplayernamealias();
      var_2 addthreatcalloutalias("_encstr_B2BC08303A77613B2FA4", var_3.playerclockdirection);
      break;
    case "_encstr_855D0FC1B185F2AC9C7DF64C3BA5DEBA37":
      if(isDefined(self._blackboard))
        self._blackboard.battlechatter_target = anim.player;

      var_2 addplayernamealias();
      var_2 addthreatobviousalias();
      break;
    case "_encstr_8B3C1059F1C7C3CB83782CDF93CB39B2D39D":
      if(isDefined(self._blackboard))
        self._blackboard.battlechatter_target = anim.player;

      var_7 = getdistancemetersnormalized(anim.player.origin, var_0.origin);
      var_2 addplayernamealias();
      var_2 addthreatdistancealias(var_7);
      break;
    case "_encstr_8C631507D8165EB24EAFB1F69B1D588DA3FAD88DDEC6B6":
      if(isDefined(self._blackboard))
        self._blackboard.battlechatter_target = var_0;

      var_2 addplayernamealias();
      var_2 addthreatcalloutalias("_encstr_A7700D1BDBE63AB0B1471BB1F636AD", var_3.playerclockdirection);
      break;
    case "_encstr_8F4914586BB9FA1BEB11850732D25303DFFF6328CF5B":
      if(isDefined(self._blackboard))
        self._blackboard.battlechatter_target = var_0;

      var_2 addplayernamealias();
      var_2 addthreatcalloutalias("_encstr_883E0C982AA28FE99B3361E80BDF", var_3.playerclockdirection);
      break;
    case "_encstr_834E19FFA24A713DA2FF4372FDC85F93AF4E70CA1938D720BF1768":
      if(isDefined(self._blackboard))
        self._blackboard.battlechatter_target = var_0;

      var_2 addplayernamealias();
      var_8 = getdegreeselevation(anim.player.origin, var_0.origin);

      if(var_8 >= 20 && var_8 <= 60) {
        var_2 addthreatcalloutalias("_encstr_BEAB117BF06B779934A6BB27EF90313891D073", var_3.playerclockdirection);
        var_2 addthreatelevationalias(var_8);
      } else
        return 0;

      break;
    case "_encstr_8FE6108308376FD79327C3C955989C6B6F60":
      if(isDefined(self._blackboard))
        self._blackboard.battlechatter_target = var_0;

      var_2 addplayernamealias();
      var_9 = getdirectioncompass(anim.player.origin, var_0.origin);
      var_10 = normalizecompassdirection(var_9);

      if(var_10 == "_encstr_82690B6911D828AB40A4F1B3DF")
        return 0;

      var_2 addthreatcalloutalias("_encstr_A5430986C0A24FB07069D1", var_10);
      break;
    case "_encstr_B1610BB3D781C068F6DC603B42":
      if(isDefined(var_3.responder) && cansayname(var_3.responder)) {
        var_2 addnamealias(var_3.responder.bcname);
        var_2.bc_looktarget = var_3.responder;
      }

      if(isDefined(self._blackboard))
        self._blackboard.battlechatter_target = var_0;

      var_2 addthreatobviousalias();
      var_2 addcalloutresponseevent(self, var_3, var_0);
      break;
    case "_encstr_9B7F0C0BD2EB46D29B8EC2CD8DAC":
      var_11 = self;

      if(self.team == "_encstr_9A8507BA4040188D08")
        var_11 = anim.player;
      else if(isDefined(var_3.responder) && randomint(100) < anim.eventchance["_encstr_840709B34F76BBF8F072C7"]["_encstr_A99B08D609DBE0AF2B3B"])
        var_11 = var_3.responder;

      var_7 = getdistancemetersnormalized(var_11.origin, var_0.origin);

      if(isDefined(self._blackboard))
        self._blackboard.battlechatter_target = var_0;

      var_2 addthreatdistancealias(var_7);
      var_2 addcalloutresponseevent(self, var_3, var_0);
      break;
    case "_encstr_86A411B288082775C051A1AB39213E434861AA":
      var_11 = self;

      if(self.team == "_encstr_9A8507BA4040188D08")
        var_11 = anim.player;
      else if(isDefined(var_3.responder) && randomint(100) < anim.eventchance["_encstr_840709B34F76BBF8F072C7"]["_encstr_A99B08D609DBE0AF2B3B"])
        var_11 = var_3.responder;

      var_12 = getrelativeangles(var_11);
      var_13 = getdirectionfacingclock(var_12, var_11.origin, var_0.origin);
      var_2 addthreatcalloutalias("_encstr_A7700D1BDBE63AB0B1471BB1F636AD", var_13);
      var_2 addcalloutresponseevent(self, var_3, var_0);

      if(isDefined(self._blackboard))
        self._blackboard.battlechatter_target = var_0;

      break;
    case "_encstr_B4731043E9A960C7BF3B49D0A1C70948FE73":
      var_11 = self;

      if(self.team == "_encstr_9A8507BA4040188D08")
        var_11 = anim.player;
      else if(isDefined(var_3.responder) && randomint(100) < anim.eventchance["_encstr_840709B34F76BBF8F072C7"]["_encstr_A99B08D609DBE0AF2B3B"])
        var_11 = var_3.responder;

      var_12 = getrelativeangles(var_11);
      var_13 = getdirectionfacingclock(var_12, var_11.origin, var_0.origin);
      var_2 addthreatcalloutalias("_encstr_A7700D1BDBE63AB0B1471BB1F636AD", var_13);
      var_2 addcalloutresponseevent(self, var_3, var_0);

      if(isDefined(self._blackboard))
        self._blackboard.battlechatter_target = var_0;

      break;
    case "_encstr_962A100B96EBE816E4CE5947EBD863DBB1AD":
      var_11 = self;

      if(self.team == "_encstr_9A8507BA4040188D08")
        var_11 = anim.player;
      else if(isDefined(var_3.responder) && randomint(100) < anim.eventchance["_encstr_840709B34F76BBF8F072C7"]["_encstr_A99B08D609DBE0AF2B3B"])
        var_11 = var_3.responder;

      var_12 = getrelativeangles(var_11);
      var_13 = getdirectionfacingclock(var_12, var_11.origin, var_0.origin);
      var_2 addthreatcalloutalias("_encstr_883E0C982AA28FE99B3361E80BDF", var_13);
      var_2 addcalloutresponseevent(self, var_3, var_0);

      if(isDefined(self._blackboard))
        self._blackboard.battlechatter_target = var_0;

      break;
    case "_encstr_B6B7158596FAE8B09CCE2B1DEB1B8D7BB16DBED096B386":
      var_11 = self;

      if(self.team == "_encstr_9A8507BA4040188D08")
        var_11 = anim.player;
      else if(isDefined(var_3.responder) && randomint(100) < anim.eventchance["_encstr_840709B34F76BBF8F072C7"]["_encstr_A99B08D609DBE0AF2B3B"])
        var_11 = var_3.responder;

      var_12 = getrelativeangles(var_11);
      var_13 = getdirectionfacingclock(var_12, var_11.origin, var_0.origin);
      var_8 = getdegreeselevation(var_11.origin, var_0.origin);

      if(var_8 >= 20 && var_8 <= 60) {
        var_2 addthreatcalloutalias("_encstr_BEAB117BF06B779934A6BB27EF90313891D073", var_13);
        var_2 addthreatelevationalias(var_8);
      } else
        return 0;

      var_2 addcalloutresponseevent(self, var_3, var_0);

      if(isDefined(self._blackboard))
        self._blackboard.battlechatter_target = var_0;

      break;
    case "_encstr_83240CF857AF812BC3C763F89E7A":
      var_11 = self;

      if(self.team == "_encstr_9A8507BA4040188D08")
        var_11 = anim.player;

      var_9 = getdirectioncompass(var_11.origin, var_0.origin);
      var_10 = normalizecompassdirection(var_9);

      if(var_10 == "_encstr_82690B6911D828AB40A4F1B3DF")
        return 0;

      var_2 addthreatcalloutalias("_encstr_A5430986C0A24FB07069D1", var_10);

      if(isDefined(self._blackboard))
        self._blackboard.battlechatter_target = var_0;

      break;
    case "_encstr_9A0E11705DF51B9A64698799D0E6A1ABFB388D":
      var_6 = self;
      var_11 = self;

      if(isDefined(self._blackboard))
        self._blackboard.battlechatter_target = var_0;

      var_14 = var_2 threatinfantry_docalloutlocation(var_3, undefined, var_6);

      if(!var_14)
        return 0;

      if(self.team == "_encstr_9A8507BA4040188D08")
        var_11 = anim.player;

      var_2 addconcatdirectionalias(var_11, var_0);
      var_2 addcalloutresponseevent(self, var_3, var_0);
      break;
    case "_encstr_9A7C100ED80B5E56E47D63DB1BC23AB47BCD":
      var_6 = self;
      var_2 addplayernamealias();

      if(isDefined(self._blackboard))
        self._blackboard.battlechatter_target = anim.player;

      var_14 = var_2 threatinfantry_docalloutlocation(var_3, undefined, var_6);

      if(!var_14)
        return 0;

      break;
    case "_encstr_A3731036F6731B168EAFD87BD816A3A5DECD":
      var_15 = 0;

      if(randomint(3)) {
        var_15 = 1;
        var_2 addconcattargetalias(var_0);
      }

      var_6 = self;
      var_11 = self;

      if(self.team == "_encstr_9A8507BA4040188D08")
        var_11 = anim.player;

      var_14 = var_2 threatinfantry_docalloutlocation(var_3, 1, var_6);

      if(!var_14)
        return 0;

      if(!var_15)
        var_2 addconcatdirectionalias(var_11, var_0);
      else if(randomint(3))
        var_2 addconcatdirectionalias(var_11, var_0);

      var_2 addcalloutresponseevent(self, var_3, var_0);

      if(isDefined(self._blackboard))
        self._blackboard.battlechatter_target = var_0;

      break;
    case "_encstr_8F100C0BD2D763EDB116D15ABD9B":
      var_6 = self;

      if(var_6 cansayname(var_3.responder)) {
        var_2 addnamealias(var_3.responder.bcname);
        var_2.bc_looktarget = var_3.responder;
      }

      var_14 = var_2 threatinfantry_docalloutlocation(var_3, undefined, var_6);

      if(!var_14)
        return 0;

      var_16 = var_2.soundaliases.size - 1;
      var_17 = var_2.soundaliases[var_16];

      if(iscallouttypereport(var_17))
        var_3.responder scripts\cp\cp_battlechatter_ai::addresponseevent("_encstr_A99B08D609DBE0AF2B3B", "_encstr_8B60059536347B", self, 0.9, var_17);
      else if(iscallouttypeqa(var_17, self))
        var_3.responder scripts\cp\cp_battlechatter_ai::addresponseevent("_encstr_A99B08D609DBE0AF2B3B", "_encstr_8507037FBB", self, 0.9, var_17, var_3.location);
      else if(randomint(100) < anim.eventchance["_encstr_840709B34F76BBF8F072C7"]["_encstr_86E6112FA828C45A5B8D695D7D17F284D0B88F"])
        var_3.responder scripts\cp\cp_battlechatter_ai::addresponseevent("_encstr_A99B08D609DBE0AF2B3B", "_encstr_B61904372BB3", self, 0.9);
      else
        var_3.responder scripts\cp\cp_battlechatter_ai::addresponseevent("_encstr_8E2508591EE07BE6B246", "_encstr_82F309E237DB1B6B6367E9", self, 0.9);

      if(isDefined(self._blackboard))
        self._blackboard.battlechatter_target = var_0;

      break;
  }

  setlastcallouttype(var_3.type);
  var_6 = self;

  if(isDefined(self._blackboard))
    self._blackboard.battlechatter_line_ok = 0;

  var_6 playphrase(var_2, self);

  if(isDefined(self._blackboard)) {
    self._blackboard.battlechatter_alias = undefined;
    self._blackboard.battlechatter_target = undefined;
  }

  return 1;
}

addthreatobviousalias() {
  var_0 = self.owner getbattlechatteralias("_encstr_8C700FD56074F3256E3FB5B7010B7F3B80");
  self.soundaliases[self.soundaliases.size] = var_0;
  return 1;
}

addthreatcalloutalias(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = "_encstr_B40101";

  var_2 = undefined;

  if(self.owner == anim.player) {
    if(var_0 == "_encstr_82F309E237DB1B6B6367E9" || var_0 == "_encstr_B2BC08303A77613B2FA4")
      var_2 = self.owner.battlechatter.countryid + "_encstr_8E290DD71CD893BE3A16273B95D1AF" + var_0;
    else
      var_2 = self.owner.battlechatter.countryid + "_encstr_92950E2E6B29456888418D31682D0BC1" + var_0 + var_1;
  } else
    var_2 = self.owner getbattlechatteralias("_encstr_95A9101D1AC9CA2CA3F5C6858D63EDBAA3FA" + var_0) + var_1;

  self.soundaliases[self.soundaliases.size] = var_2;
  return 1;
}

cansayplayername() {
  if(enemy_team_name())
    return 0;

  if(self == anim.player)
    return 0;

  if(!isDefined(anim.player.bcnameid) || !isDefined(anim.player.bccountryid))
    return 0;

  if(player_name_called_recently())
    return 0;

  var_0 = bc_prefix() + "_encstr_96CD0DB90BB659FAC1B116BC56E4D7" + anim.player.bccountryid + "_encstr_BA4C02DF" + anim.player.bcnameid;

  if(soundexists(var_0))
    return 1;

  return 0;
}

player_name_called_recently() {
  if(!isDefined(anim.lastplayernamecalltime))
    return 0;

  if(gettime() - anim.lastplayernamecalltime >= anim.eventtypeminwait["_encstr_A9900BF17C56C0B5CB1AD940B2"])
    return 0;

  return 1;
}

addplayernamealias() {
  if(!self.owner cansayplayername()) {
    return;
  }
  anim.lastplayernamecalltime = gettime();
  var_0 = self.owner bc_prefix() + "_encstr_96CD0DB90BB659FAC1B116BC56E4D7" + anim.player.bccountryid + "_encstr_BA4C02DF" + anim.player.bcnameid;
  self.soundaliases[self.soundaliases.size] = var_0;
  self.bc_looktarget = anim.player;
}

getdistancemeters(var_0, var_1) {
  var_2 = distance2d(var_0, var_1);
  var_3 = 0.0254 * var_2;
  return var_3;
}

getdistancemetersnormalized(var_0, var_1) {
  var_2 = getdistancemeters(var_0, var_1);

  if(var_2 < 15.0)
    return "_encstr_AF0703133A";
  else if(var_2 < 25.0)
    return "_encstr_990703B2F9";
  else if(var_2 < 35.0)
    return "_encstr_8D070366C0";
  else if(var_2 < 45.0)
    return "_encstr_AA07038618";
  else if(var_2 < 55.0)
    return "_encstr_82070322E1";
  else if(var_2 < 65.0)
    return "_encstr_B107031B8F";
  else if(var_2 < 75.0)
    return "_encstr_B20703B767";
  else if(var_2 < 85.0)
    return "_encstr_840703171A";
  else if(var_2 < 95.0)
    return "_encstr_810703AF78";
  else
    return "_encstr_9A1804890618";
}

addthreatdistancealias(var_0) {
  var_1 = self.owner getbattlechatteralias("_encstr_AA9E0D9E5F8BBBFBE603B170CABA99") + var_0;
  self.soundaliases[self.soundaliases.size] = var_1;
  return 1;
}

addnamealias(var_0) {
  if(self.owner == anim.player) {} else
    self.soundaliases[self.soundaliases.size] = self.owner bc_prefix() + "_encstr_AAFF0652B86BF7D7" + var_0;

  anim.lastnamesaid[self.owner.team] = var_0;
  anim.lastnamesaidtime[self.owner.team] = gettime();
}

doexposedcalloutresponse(var_0) {
  if(!isDefined(var_0))
    return 0;

  switch (var_0.battlechatter.countryid) {
    case "_encstr_B47805777A0BD9":
    case "_encstr_AA180535146ABA":
    case "_encstr_81E4051511F5D7":
    case "_encstr_841804C8A9A0":
    case "_encstr_B81904AA6A6A":
    case "_encstr_81190407A676":
      break;
    default:
      return 0;
  }

  if(randomint(100) > anim.eventchance["_encstr_840709B34F76BBF8F072C7"]["_encstr_8E2508591EE07BE6B246"])
    return 0;

  return 1;
}

getdegreeselevation(var_0, var_1) {
  var_2 = var_1[2] - var_0[2];
  var_3 = distance2d(var_0, var_1);
  var_4 = atan(var_2 / var_3);

  if(var_4 < 15 || var_4 > 65)
    return var_4;
  else if(var_4 < 25)
    return 20;
  else if(var_4 < 35)
    return 30;
  else if(var_4 < 45)
    return 40;
  else if(var_4 < 55)
    return 50;
  else if(var_4 < 65)
    return 60;
}

addthreatelevationalias(var_0) {
  var_1 = self.owner getbattlechatteralias("_encstr_B1A40D1B7BCD47B08D1DD7CA632B3B") + var_0;
  self.soundaliases[self.soundaliases.size] = var_1;
  return 1;
}

getdirectioncompass(var_0, var_1) {
  var_2 = vectortoangles(var_1 - var_0);
  var_3 = var_2[1];
  var_4 = getnorthyaw();
  var_3 = var_3 - var_4;

  if(var_3 < 0)
    var_3 = var_3 + 360;
  else if(var_3 > 360)
    var_3 = var_3 - 360;

  if(var_3 < 22.5 || var_3 > 337.5)
    var_5 = "_encstr_887106DCEDC93A34";
  else if(var_3 < 67.5)
    var_5 = "_encstr_882B0A73DB9CD1D0DD95B98E";
  else if(var_3 < 112.5)
    var_5 = "_encstr_88F60573538740";
  else if(var_3 < 157.5)
    var_5 = "_encstr_99E40A0E08AB6BD2B725AED5";
  else if(var_3 < 202.5)
    var_5 = "_encstr_A76006DCF6EAE886";
  else if(var_3 < 247.5)
    var_5 = "_encstr_87790ACB570D8853BFD12E88";
  else if(var_3 < 292.5)
    var_5 = "_encstr_9A6005079F201B";
  else if(var_3 < 337.5)
    var_5 = "_encstr_99960A057008EC123D4B4FAB";
  else
    var_5 = "_encstr_82690B6911D828AB40A4F1B3DF";

  return var_5;
}

normalizecompassdirection(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "_encstr_887106DCEDC93A34":
      var_1 = "_encstr_AF4C0273";
      break;
    case "_encstr_882B0A73DB9CD1D0DD95B98E":
      var_1 = "_encstr_9A07039BBB";
      break;
    case "_encstr_88F60573538740":
      var_1 = "_encstr_954C0277";
      break;
    case "_encstr_99E40A0E08AB6BD2B725AED5":
      var_1 = "_encstr_8D07036EDD";
      break;
    case "_encstr_A76006DCF6EAE886":
      var_1 = "_encstr_B24C02EF";
      break;
    case "_encstr_87790ACB570D8853BFD12E88":
      var_1 = "_encstr_AC07035727";
      break;
    case "_encstr_9A6005079F201B":
      var_1 = "_encstr_934C02B2";
      break;
    case "_encstr_99960A057008EC123D4B4FAB":
      var_1 = "_encstr_AD0703BA80";
      break;
    case "_encstr_82690B6911D828AB40A4F1B3DF":
      var_1 = "_encstr_82690B6911D828AB40A4F1B3DF";
      break;
    default:
      return;
  }

  return var_1;
}

addcalloutresponseevent(var_0, var_1, var_2) {
  if(!isDefined(var_1.responder)) {
    return;
  }
  if(var_1.responder.team != var_0.team) {
    return;
  }
  if(randomint(100) > anim.eventchance["_encstr_840709B34F76BBF8F072C7"]["_encstr_A99B08D609DBE0AF2B3B"]) {
    return;
  }
  var_3 = "_encstr_B61904372BB3";
  var_4 = "_encstr_A99B08D609DBE0AF2B3B";

  if(!var_1.responder bccansee(var_2) && randomint(100) < anim.eventchance["_encstr_840709B34F76BBF8F072C7"]["_encstr_86E6112FA828C45A5B8D695D7D17F284D0B88F"]) {} else {
    var_3 = "_encstr_8CAB07EF58A11953A3";

    if(isDefined(var_1.location)) {
      var_5 = var_2 getvalidlocation(var_1.responder, "_encstr_840709B34F76BBF8F072C7");

      if(isDefined(var_5) && isDefined(var_5.locationaliases[0])) {
        var_3 = var_5.locationaliases[0];
        var_4 = "_encstr_AC6E09881A36337B5F6F30";
      }
    }
  }

  var_1.responder scripts\cp\cp_battlechatter_ai::addresponseevent(var_4, var_3, var_0, 0.9);
}

bccansee(var_0) {
  if(!isDefined(self))
    return 0;
  else if(isPlayer(self)) {
    if(_encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::player_can_see_ai(self, var_0))
      return 1;
  } else if(self cansee(var_0))
    return 1;

  return 0;
}

getvalidlocation(var_0, var_1, var_2) {
  var_3 = get_all_my_locations();
  var_3 = scripts\engine\utility::array_randomize(var_3);
  var_4 = undefined;

  if(var_3.size) {
    foreach(var_4 in var_3) {
      if(!var_0 cancalloutlocation(var_4, var_1, var_2))
        var_3 = scripts\engine\utility::array_remove(var_3, var_4);
    }

    var_4 = _getlocation(var_3, var_1);
  }

  return var_4;
}

get_all_my_locations() {
  var_0 = anim.bcs_locations;
  var_1 = self getistouchingentities(var_0);
  var_2 = [];

  foreach(var_4 in var_1) {
    if(isDefined(var_4.locationaliases)) {
      if(isDefined(var_4.islandmark) && anim.player istouching(var_4))
        continue;
      else
        var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

createleaderalias(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = "_encstr_B40101";
  else
    var_1 = "_encstr_BA4C02DF" + var_1;

  var_2 = strtok(var_0, "_encstr_BA4C02DF");
  var_2[2] = self.battlechatter.countryid + "_encstr_9707038D98";
  var_3 = undefined;

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    if(var_4 == 0) {
      var_3 = var_2[var_4];
      continue;
    }

    var_3 = var_3 + ("_encstr_BA4C02DF" + var_2[var_4]);
  }

  return tolower(var_3 + "_encstr_9207034F36" + var_1);
}

cancalloutlocation(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    var_1 = "_encstr_B40101";

  foreach(var_4 in var_0.locationaliases) {
    var_5 = undefined;

    if(var_1 == "_encstr_830E086EE82B0B361D86") {
      if(var_2 == "_encstr_A521088F30C1D2328060") {
        var_6 = randomintrange_otn(1);
        var_4 = getloccalloutalias(getbcstate() + "_encstr_B6B70B7DC67BC6B01DD27B9BEB" + var_2 + "_encstr_BA4C02DF" + var_4 + "_encstr_BA4C02DF");
        var_4 = createleaderalias(var_4, var_6);
      } else
        var_4 = getloccalloutalias(getbcstate() + "_encstr_B6B70B7DC67BC6B01DD27B9BEB" + var_2 + "_encstr_BA4C02DF" + var_4 + "_encstr_BA4C02DF" + randomintrange_otn(1));

      var_7 = soundexists(var_4);
    } else if(var_1 == "_encstr_840709B34F76BBF8F072C7") {
      var_5 = getloccalloutalias(getbcstate() + "_encstr_AB4C10CFD058DBAA2973154D700DA27303E1" + var_4);
      var_7 = soundexists(var_5);
    } else {
      var_5 = getloccalloutalias(getbcstate() + "_encstr_8F7A1358ED0237C19C47A0A0B7A399715A55C55589" + var_4);
      var_8 = getqacalloutalias(var_4, 0);
      var_9 = getloccalloutalias(getbcstate() + "_encstr_8E8B1247E18002518808C58DE618970A6E1313CF" + var_4);
      var_7 = soundexists(var_5) || soundexists(var_8) || soundexists(var_9);
    }

    if(var_7)
      return var_7;
    else {
      if(isDefined(var_5))
        var_4 = var_5;

      battlechatter_printwarning("_encstr_AAA1198959FF5BEBA5324A30AABEB3F32FF790A7A96BC0C3CA8F42" + var_4);
    }
  }

  return 0;
}

randomintrange_otn(var_0, var_1) {
  if(getDvar("_encstr_934E0F96CB67466FAB5A59688286317BA3") != "_encstr_BA19049F4B2D")
    return "_encstr_990703A2FB";

  if(isDefined(var_0)) {
    if(isDefined(var_1))
      return randomintrange(var_0, var_1) * 1;
    else
      return "_encstr_990703A2FB";
  }
}

location_called_out_ever(var_0) {
  var_1 = location_get_last_callout_time(var_0);

  if(!isDefined(var_1))
    return 0;

  return 1;
}

_getlocation(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(!location_called_out_ever(var_3)) {
      if(isDefined(var_3.islandmark))
        return var_3;
    }
  }

  foreach(var_3 in var_0) {
    if(!location_called_out_recently(var_3, var_1) && isDefined(var_3.islandmark) && randomint(3) == 0)
      return var_3;
    else if(!location_called_out_ever(var_3))
      return var_3;
  }

  foreach(var_3 in var_0) {
    if(!location_called_out_recently(var_3, var_1))
      return var_3;
  }

  return undefined;
}

location_called_out_recently(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = "_encstr_B40101";

  var_2 = location_get_last_callout_time(var_0);

  if(!isDefined(var_2))
    return 0;

  if(var_1 == "_encstr_830E086EE82B0B361D86")
    var_3 = var_2 + anim.eventactionminwait["_encstr_830E086EE82B0B361D86"]["_encstr_95861001B70ED8F56F32705E8B37AFA02604"];
  else
    var_3 = var_2 + anim.eventactionminwait["_encstr_85CB07BDE04321538B"]["_encstr_95861001B70ED8F56F32705E8B37AFA02604"];

  if(gettime() < var_3)
    return 1;

  return 0;
}

location_add_last_callout_time(var_0) {
  anim.locationlastcallouttimes[var_0.classname] = gettime();
}

location_get_last_callout_time(var_0) {
  if(isDefined(anim.locationlastcallouttimes[var_0.classname]))
    return anim.locationlastcallouttimes[var_0.classname];

  return undefined;
}

threatinfantryexposed(var_0) {
  var_1 = [];
  var_1 = scripts\engine\utility::array_add(var_1, "_encstr_ADB405071B8AE8");
  var_1 = scripts\engine\utility::array_add(var_1, "_encstr_AC7109F8CBB733985F6EB4");

  if(self.owner.team == "_encstr_9A8507BA4040188D08") {
    var_1 = scripts\engine\utility::array_add(var_1, "_encstr_B18F09518733412BAF1AA0");
    var_2 = getaicount("_encstr_8E8405EA382B2A");

    if(var_2 > 2)
      var_1 = scripts\engine\utility::array_add(var_1, "_encstr_852906B39CBD5D38");
  }

  var_3 = var_1[randomint(var_1.size)];
  addthreatexposedalias(var_3);
}

addthreatexposedalias(var_0) {
  if(var_0 == "_encstr_852906B39CBD5D38")
    var_0 = "_encstr_8C830F47883B9D2ACB3013C1ACCDC23543";

  var_1 = self.owner getbattlechatteralias("_encstr_93D4096861FB67FB2838E6" + var_0);
  self.soundaliases[self.soundaliases.size] = var_1;
  return 1;
}

getrelativeangles(var_0) {
  var_1 = var_0.angles;

  if(!isPlayer(var_0)) {
    var_2 = var_0 bcgetclaimednode();

    if(isDefined(var_2))
      var_1 = var_2.angles;
  }

  return var_1;
}

bcgetclaimednode() {
  if(isPlayer(self))
    return self.node;
  else
    return _encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::getclaimednode();
}

bcdrawobjects() {
  for(var_0 = 0; var_0 < anim.bcs_locations.size; var_0++) {
    var_1 = anim.bcs_locations[var_0].locationaliases;

    if(!isDefined(var_1)) {
      continue;
    }
    var_2 = "_encstr_B40101";

    foreach(var_4 in var_1)
    var_2 = var_2 + var_4;

    thread drawbcobject("_encstr_BAF10B31EDD8581DB4DECDA302" + var_2, anim.bcs_locations[var_0] getorigin(), (0, 0, 8), (1, 1, 1));
  }
}

drawbcobject(var_0, var_1, var_2, var_3) {
  for(;;) {
    if(distancesquared(anim.player.origin, var_1) > 4194304) {
      wait 0.1;
      continue;
    }

    wait 0.05;
  }
}

getdirectionfacingclock(var_0, var_1, var_2) {
  var_3 = anglesToForward(var_0);
  var_4 = vectorNormalize(var_3);
  var_5 = vectortoangles(var_4);
  var_6 = vectortoangles(var_2 - var_1);
  var_7 = var_5[1] - var_6[1];
  var_7 = var_7 + 360;
  var_7 = int(var_7) % 360;

  if(var_7 > 345 || var_7 < 15)
    var_8 = "_encstr_8C0703491D";
  else if(var_7 < 45)
    var_8 = "_encstr_A34C02BB";
  else if(var_7 < 75)
    var_8 = "_encstr_A74C0222";
  else if(var_7 < 105)
    var_8 = "_encstr_A14C023B";
  else if(var_7 < 135)
    var_8 = "_encstr_AC4C024A";
  else if(var_7 < 165)
    var_8 = "_encstr_B84C027E";
  else if(var_7 < 195)
    var_8 = "_encstr_8F4C026A";
  else if(var_7 < 225)
    var_8 = "_encstr_914C02DC";
  else if(var_7 < 255)
    var_8 = "_encstr_864C02F9";
  else if(var_7 < 285)
    var_8 = "_encstr_8B4C0227";
  else if(var_7 < 315)
    var_8 = "_encstr_AF0703133A";
  else
    var_8 = "_encstr_9A07034C89";

  return var_8;
}

threatinfantry_docalloutlocation(var_0, var_1, var_2) {
  var_3 = addthreatcalloutlocationalias(var_0.location, var_1, var_2);
  return var_3;
}

getcannedresponse(var_0) {
  var_1 = undefined;
  var_2 = self.locationaliases;

  foreach(var_4 in var_2) {
    if(iscallouttypeqa(var_4, var_0) && !isDefined(self.qafinished)) {
      var_1 = var_4;
      break;
    }

    if(iscallouttypereport(var_4))
      var_1 = var_4;
  }

  return var_1;
}

addthreatcalloutlocationalias(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = var_0.locationaliases;
  var_5 = var_4[0];

  if(var_4.size > 1) {
    var_6 = undefined;
    var_6 = var_0 getcannedresponse(var_2);

    if(isDefined(var_6))
      var_5 = var_6;
    else
      var_5 = scripts\engine\utility::random(var_4);
  }

  var_7 = undefined;

  if(isDefined(var_1) && var_1)
    var_7 = self.owner getloccalloutalias(getbcstate() + "_encstr_8E8B1247E18002518808C58DE618970A6E1313CF" + var_5);
  else if(!isDefined(var_0.qafinished) && iscallouttypeqa(var_5, self.owner))
    var_7 = self.owner getqacalloutalias(var_5, 0);
  else
    var_7 = self.owner getloccalloutalias(getbcstate() + "_encstr_8F7A1358ED0237C19C47A0A0B7A399715A55C55589" + var_5);

  if(soundexists(var_7))
    var_3 = var_7;

  if(!isDefined(var_3))
    return 0;

  location_add_last_callout_time(var_0);
  self.soundaliases[self.soundaliases.size] = var_3;
  return 1;
}

addconcatdirectionalias(var_0, var_1) {
  var_2 = undefined;
  var_3 = "_encstr_8C500ABA9B23CACC2D37AC8C";
  var_4 = scripts\engine\utility::random(["_encstr_AC310908CA85632B0FC605", "_encstr_9B84092C98DCDEC65D1DAC"]);

  switch (var_4) {
    case "_encstr_9B84092C98DCDEC65D1DAC":
      var_5 = getdirectioncompass(anim.player.origin, var_1.origin);
      var_6 = normalizecompassdirection(var_5);

      if(var_6 != "_encstr_82690B6911D828AB40A4F1B3DF" && var_6.size != 2) {
        var_2 = self.owner getbattlechatteralias("_encstr_8F3C0FCE27E01ADA809873BF67D2299FCF") + var_6;
        break;
      }

      var_3 = "_encstr_9B84092C98DCDEC65D1DAC";
    case "_encstr_AC310908CA85632B0FC605":
      var_7 = getrelativeangles(var_0);
      var_8 = getdirectionfacingclock(var_7, var_0.origin, var_1.origin);
      var_9 = int(var_8);

      if(scripts\engine\utility::cointoss()) {
        if(var_9 >= 2 && var_9 < 5) {
          var_2 = self.owner getbattlechatteralias("_encstr_97630D1BA708A607BD66B30A499B6B");
          break;
        } else if(var_9 >= 8 && var_9 < 11) {
          var_2 = self.owner getbattlechatteralias("_encstr_92200CB1BD9B8D58E8EBC69533A3");
          break;
        } else {}
      } else if(randomint(3) == 1) {
        var_10 = getdistancemetersnormalized(var_0.origin, var_1.origin);
        var_2 = self.owner getbattlechatteralias("_encstr_9BDD0C6C7BB936C247FA8C96E6D1") + var_10;
        break;
      } else if(randomint(3) == 1) {
        var_11 = getdegreeselevation(anim.player.origin, var_1.origin);

        if(var_11 >= 20 && var_11 <= 60) {
          var_2 = self.owner getbattlechatteralias("_encstr_97E90C47B0CDB3C23170BFF545ED") + var_11;
          break;
        }

        var_3 = "_encstr_A6490A81355580877BE7978D";
      } else if(self.owner.voice != "_encstr_841804CCB9B0" && self.owner.voice != "_encstr_A1440A8C62AA7519DD2FC0B0") {
        var_2 = self.owner getbattlechatteralias("_encstr_97BB0DB1F673D8851D7DD88D7B36B5") + var_8;
        break;
      }
  }

  if(isDefined(var_2))
    self.soundaliases[self.soundaliases.size] = var_2;
  else
    battlechatter_printwarning("_encstr_88AD1B9D4C5A7B23A8D79AB72F4E9E032C324D2CF35F83F168EABE6AE2" + var_3);
}

battlechatter_printwarning(var_0) {}

battlechatter_printerror(var_0) {}

addconcattargetalias(var_0) {
  var_1 = "_encstr_B40101";
  var_2 = undefined;

  if(var_0 _encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::usingrocketlauncher())
    var_1 = "_encstr_AC430588BA23EF";

  if(var_0 bcissniper())
    var_1 = "_encstr_921C08AFC3280829E262";

  var_2 = self.owner getbattlechatteralias("_encstr_87630EB1EDE61BC23AFAA385C9D995E8") + var_1;
  self.soundaliases[self.soundaliases.size] = var_2;
}

bcissniper() {
  if(!isDefined(self))
    return 0;

  if(!isalive(self))
    return 0;

  if(isPlayer(self))
    return 0;

  if(!isDefined(self.weapon))
    return 0;

  return _encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::issniperrifle(self.weapon);
}

iscallouttypereport(var_0) {
  return issubstr(var_0, "_encstr_8D6308CF75B88A27A62B");
}

iscallouttypeqa(var_0, var_1) {
  if(issubstr(var_0, "_encstr_AA1A04F5172C") && soundexists(var_0))
    return 1;

  var_2 = var_1 getqacalloutalias(var_0, 0);

  if(soundexists(var_2))
    return 1;

  return 0;
}

getloccalloutalias(var_0) {
  var_1 = undefined;

  if(self == anim.player) {
    var_1 = "_encstr_A75308073DEF30819BBF";
    var_1 = var_1 + var_0;
  } else {
    if(getbcstate() == "_encstr_AA7C07466F9DA30713")
      var_1 = bc_prefix();
    else
      var_1 = bc_prefix("_encstr_830E086EE82B0B361D86");

    var_1 = var_1 + var_0;
  }

  return var_1;
}

getqacalloutalias(var_0, var_1) {
  var_2 = getloccalloutalias(getbcstate() + "_encstr_8F7A1358ED0237C19C47A0A0B7A399715A55C55589" + var_0);
  var_2 = var_2 + ("_encstr_AA1A04F5172C" + var_1);
  return var_2;
}

setlastcallouttype(var_0) {
  anim.lastteamthreatcallout[self.team] = var_0;
  anim.lastteamthreatcallouttime[self.team] = gettime();
}

informreloading(var_0) {
  var_1 = self;
  var_1 endon("_encstr_AD75063D571AE108");
  var_1 endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");
  var_2 = var_1 createchatphrase();
  var_2 addinformalias("_encstr_878B0A2323D11281F8F8551F", var_0);
  var_1 playphrase(var_2, self);
}

informsuppressed(var_0) {
  var_1 = self;
  var_1 endon("_encstr_AD75063D571AE108");
  var_1 endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");
  var_2 = var_1 createchatphrase();
  var_2 addinformalias("_encstr_8E950B26FDE7F283FFA3F77B77", var_0);
  var_1 playphrase(var_2, self);
}

informincoming(var_0) {
  var_1 = self;
  var_1 endon("_encstr_AD75063D571AE108");
  var_1 endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");
  var_2 = var_1 createchatphrase();

  if(var_0 == "_encstr_8C8D08671D451291C849" || var_0 == "_encstr_9748067348F0C794" || var_0 == "_encstr_A31904C2731D" || var_0 == "_encstr_A9180527A5E7E0")
    var_2.master = 1;

  var_2 addinformalias("_encstr_8A4F099025A3B8715A6B17", var_0);
  var_1 playphrase(var_2, self);
}

informattacking(var_0) {
  var_1 = self;
  var_1 endon("_encstr_AD75063D571AE108");
  var_1 endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");
  var_2 = var_1 createchatphrase();
  var_2 addinformalias(var_0);
  var_1 playphrase(var_2, self);
}

informkillfirm(var_0) {
  var_1 = self;
  var_1 endon("_encstr_AD75063D571AE108");
  var_1 endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");
  var_2 = var_1 createchatphrase();
  var_2 addinformalias("_encstr_86B209B07AF529395F72B1", var_0, self.curevent.threat_type);
  var_1 playphrase(var_2, self);
}

addinformalias(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    var_1 = "_encstr_B40101";
  else
    var_1 = "_encstr_BA4C02DF" + var_1;

  if(!isDefined(var_2))
    var_2 = "_encstr_B40101";
  else
    var_2 = "_encstr_BA4C02DF" + var_2;

  if(!issubstr(var_1, "_encstr_AC20072B9FA9487832"))
    var_0 = "_encstr_8B2108C0E5D2D01BD07E" + var_0;
  else
    var_0 = "_encstr_B40101";

  var_3 = self.owner getbattlechatteralias(var_0 + var_1 + var_2);
  self.soundaliases[self.soundaliases.size] = var_3;
}

getbattlechatteralias(var_0) {
  var_1 = undefined;
  var_2 = bc_prefix();

  switch (var_0) {
    case "_encstr_A6B60B3FF019DB0A7FF4944A6D":
      var_1 = var_2 + "_encstr_A31514CBF52B133237DFC55E98EA92E1AA318D48B6E9";
      break;
    case "_encstr_97BB0DB1F673D8851D7DD88D7B36B5":
      var_1 = var_2 + getbcstate() + "_encstr_B66B0FEB6CBD376C1647FA36B1DE1B5BF5";
      break;
    case "_encstr_8F3C0FCE27E01ADA809873BF67D2299FCF":
      var_1 = var_2 + getbcstate() + "_encstr_86F511D7C6F6E6D8161DBEC6EDADE0C2B96EAF";
      break;
    case "_encstr_9BDD0C6C7BB936C247FA8C96E6D1":
      var_1 = var_2 + getbcstate() + "_encstr_ADE50ECF9F5F2DB3BA9BE0790AA39189";
      break;
    case "_encstr_97E90C47B0CDB3C23170BFF545ED":
      var_1 = var_2 + getbcstate() + "_encstr_8BFE0E9109D0D3B67891DFED49B03BCF";
      break;
    case "_encstr_92200CB1BD9B8D58E8EBC69533A3":
      var_1 = var_2 + getbcstate() + "_encstr_AFBF0DD78DB79B1BC2D1BEC659998E";
      break;
    case "_encstr_97630D1BA708A607BD66B30A499B6B":
      var_1 = var_2 + getbcstate() + "_encstr_85920E5136576AF3B938DF63F851A093";
      break;
    case "_encstr_87EF0E2FD868CBBA5918669FF831B282":
      var_1 = var_2 + getbcstate() + "_encstr_87060F4F7E5AF6CE699C81AE459633BD5B";
      break;
    case "_encstr_87630EB1EDE61BC23AFAA385C9D995E8":
      var_1 = var_2 + getbcstate() + "_encstr_84AC0F671BF04E12EB15E123F7B52A0DFB";
      break;
    case "_encstr_AA9E0D9E5F8BBBFBE603B170CABA99":
      var_1 = var_2 + "_encstr_91A10E8DEDCDD185C6D1F5C8A5371DEB";
      break;
    case "_encstr_B1A40D1B7BCD47B08D1DD7CA632B3B":
      var_1 = var_2 + "_encstr_A2B70E6CED73D15836A37D2B36CAB3AF";
      break;
    case "_encstr_8D4517EF8083A3BA678B391BA0C665B062E2C349FC627D336F":
      var_1 = var_2 + "_encstr_8D4517EF8083A3BA678B391BA0C665B062E2C349FC627D336F";
      break;
    case "_encstr_9A5E11E75289184BC21079F77EC337DA36F329":
      var_1 = var_2 + "_encstr_9A5E11E75289184BC21079F77EC337DA36F329";
      break;
    case "_encstr_8CCF11AC3CE0B7DC598CD726932B0BD65A9B9D":
      var_1 = var_2 + "_encstr_8CCF11AC3CE0B7DC598CD726932B0BD65A9B9D";
      break;
    case "_encstr_979511AB184220EEC70AAE90C2F3AD785F9601":
      var_1 = var_2 + "_encstr_979511AB184220EEC70AAE90C2F3AD785F9601";
      break;
    case "_encstr_B4B51710BB229F2BDF34F8E907ABD153CF421039A27A27A3E3":
      var_1 = var_2 + "_encstr_B4B51710BB229F2BDF34F8E907ABD153CF421039A27A27A3E3";
      break;
    case "_encstr_A9940DDB681270BE97BA1EEDE34FF8":
      var_1 = var_2 + "_encstr_A9940DDB681270BE97BA1EEDE34FF8";
      break;
    case "_encstr_A29D0F967366DB9CD6F5B327599B852395":
    case "_encstr_959B0CD29B66DE9CB6EB664EC29D":
      var_1 = var_2 + "_encstr_A29D0F967366DB9CD6F5B327599B852395";
      break;
    case "_encstr_A7C1186B9834905B93494030582015E81802519723BD30226022":
      var_1 = var_2 + "_encstr_A7C1186B9834905B93494030582015E81802519723BD30226022";
      break;
    case "_encstr_924E18D2E666DB4EB57D6D96C6C633A5E4B6BE37BD1B2396CA39":
    case "_encstr_B4601BBA58E5FDEBB0B87B61C978738435A84102384FB7CF0B187975DD":
      var_1 = var_2 + "_encstr_924E18D2E666DB4EB57D6D96C6C633A5E4B6BE37BD1B2396CA39";
      break;
    case "_encstr_BD870FA59BCCED27B6FAB67B8DDBE8DE3B":
      var_1 = var_2 + "_encstr_BD870FA59BCCED27B6FAB67B8DDBE8DE3B";
      break;
    case "_encstr_ADBF11F0C6A04FF20597433962025B7A2DB03F":
      var_1 = var_2 + "_encstr_ADBF11F0C6A04FF20597433962025B7A2DB03F";
      break;
    case "_encstr_ADE213F8324B78589D9F5173C3C4E034070A70036A":
      var_1 = var_2 + "_encstr_ADE213F8324B78589D9F5173C3C4E034070A70036A";
      break;
    case "_encstr_B68D121BF61BC247D2F6377D27ACCD83F673B9B2":
      var_1 = var_2 + getbcstate() + "_encstr_BA230FF1A858430A2DC3B7BB47D6B2AB48";
      break;
    case "_encstr_AD740EB8924AC34B5F77885877AA600B":
      var_1 = var_2 + "_encstr_AD740EB8924AC34B5F77885877AA600B";
      break;
    case "_encstr_8B86116A903927E3016028A8DD77FDC18E5B0D":
      var_1 = var_2 + "_encstr_83E6125F4BC23518CFCD706BF7E7D8780A633BE1";
      break;
    case "_encstr_B19814A81BB4612D31E5B794FF7A4F481BD73058BF5C":
      var_1 = var_2 + "_encstr_8B0E15ED9C232B39FAD6F6CE95BECD7B9BC6EDB5C416D1";
      break;
    case "_encstr_8C700FD56074F3256E3FB5B7010B7F3B80":
      var_1 = var_2 + "_encstr_8C700FD56074F3256E3FB5B7010B7F3B80";
      break;
    case "_encstr_BE7C12B281204B63ABC7AB77C747DB95D848ABF8":
      var_1 = var_2 + "_encstr_BE7C12B281204B63ABC7AB77C747DB95D848ABF8";
      break;
    case "_encstr_9565179CB22C6CD196EDE6FA34B7E647D236CAF5985DC9DC3A":
      var_1 = var_2 + "_encstr_9565179CB22C6CD196EDE6FA34B7E647D236CAF5985DC9DC3A";
      break;
    case "_encstr_9A311408CA42414813C30510A95FB057AE622068131D":
      var_1 = var_2 + "_encstr_9A311408CA42414813C30510A95FB057AE622068131D";
      break;
    case "_encstr_AC8E17E54173774A0AA81DE9E3C43AD8AFA487BBEA08039528":
      var_1 = var_2 + "_encstr_AC8E17E54173774A0AA81DE9E3C43AD8AFA487BBEA08039528";
      break;
    case "_encstr_8BA61432CA8373373002D59E930B3B83BFC191537D77":
      var_1 = var_2 + "_encstr_8BA61432CA8373373002D59E930B3B83BFC191537D77";
      break;
    case "_encstr_AD2906FBFA7593E3":
      var_1 = var_2 + "_encstr_AD2906FBFA7593E3";
      break;
    case "_encstr_8E8318D99313853034912179450408C5CBE76B7F0F8B5B907D37":
      var_1 = var_2 + "_encstr_B6110A798E29F0EB43FFB9C7";
      break;
    case "_encstr_96BA184B420B0DB0ABEF6F63F495F8CDBBA921110B8BB38086A4":
      var_1 = var_2 + "_encstr_96460ACAA6DDB9E0F8EA0D31";
      break;
    case "_encstr_BA1F1C3B28B0450A2DAF878721D912AD6856764540D8096205EFA3472772":
      var_1 = var_2 + "_encstr_99430FA02D7D33BF086B772728D83EEB01";
      break;
    case "_encstr_96A9174734392B853AF58D0BB18DB7EAA3F56EA5B3A1E8958C":
      var_1 = var_2 + "_encstr_A6950966897FE801B7B201";
      break;
    case "_encstr_A3421B05288BE98B53A14068AA6D5F234BF78D77AA7751F9FEFA287032":
      var_1 = var_2 + "_encstr_9B280EF3998E27E76077B3B43FF02C7F";
      break;
    case "_encstr_9A99200371DA9793F3604BFB55190AD0A459CCF813E7E7FB1080681024407B738C7A":
      var_1 = var_2 + "_encstr_B273138467826FF3136119E4D2A18F9FB20A9058DF";
      break;
    default:
  }

  return var_1;
}

playreactionevent() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");
  self.curevent = self.battlechatter.chatqueue["_encstr_8A66099C590B3647D2B79B"];
  var_0 = self.battlechatter.chatqueue["_encstr_8A66099C590B3647D2B79B"].reactto;
  var_1 = self.battlechatter.chatqueue["_encstr_8A66099C590B3647D2B79B"].modifier;
  anim thread lockaction(self, "_encstr_8A66099C590B3647D2B79B");

  if(isDefined(self._blackboard))
    self._blackboard.battlechatter_alias = undefined;

  var_2 = self.battlechatter.chatqueue["_encstr_8A66099C590B3647D2B79B"].eventtype;

  switch (var_2) {
    case "_encstr_AA580ADB1DA80886FB3AC320":
    case "_encstr_8EBB09D658CD56D5672B39":
    case "_encstr_83A107A3F3185A4DB0":
    case "_encstr_8A3C092767D35DE09CEBD2":
    case "_encstr_B18F09518733412BAF1AA0":
      reactioncasualty(var_0, var_1, var_2);
      break;
    case "_encstr_AD2906FBFA7593E3":
      reactiontaunt(var_0, var_1, var_2);
      break;
    case "_encstr_A54E0D719B1F05C0B7C45355F91A50":
      reactionfriendlyfire(var_0, var_1, var_2);
      break;
    case "_encstr_81B70B13BFC78276F1108FFB10":
      reactiontakingfire(var_0, var_1, var_2);

      if(scripts\engine\utility::cointoss()) {
        var_3 = getresponder(64, 1024, "_encstr_840709B34F76BBF8F072C7");

        if(isDefined(var_3)) {
          if(scripts\engine\utility::cointoss()) {
            if(var_3 cansay("_encstr_8A66099C590B3647D2B79B", "_encstr_A7F7070BB9D67DED6D", 1.0))
              var_3 scripts\cp\cp_battlechatter_ai::addreactionevent("_encstr_A7F7070BB9D67DED6D", undefined, self, 1.0);
          } else
            var_3 scripts\cp\cp_battlechatter_ai::addresponseevent("_encstr_84C909D2980D8713F8F8AF", "_encstr_88780599B4E495", self, 1.0);
        }
      }

      break;
    case "_encstr_A7F7070BB9D67DED6D":
      responsetakingfire(var_0, "_encstr_911904516362", "_encstr_860703DF6B");
      var_3 = getresponder(64, 1024, "_encstr_840709B34F76BBF8F072C7");

      if(isDefined(var_3))
        var_3 scripts\cp\cp_battlechatter_ai::addresponseevent("_encstr_8707037979", "_encstr_860703DF6B", self, 1.0);

      break;
  }

  if(isDefined(self._blackboard))
    self._blackboard.battlechatter_alias = undefined;

  self notify("_encstr_B4650E6A50F57FA2732F75694AD85307");
}

responsetakingfire(var_0, var_1, var_2) {
  var_3 = self;
  var_3 endon("_encstr_AD75063D571AE108");
  var_3 endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");
  var_4 = var_3 createchatphrase();
  var_4 addresponsealias(var_1, var_2);
  var_3 playphrase(var_4, self);
}

addresponsealias(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = "_encstr_B40101";
  else
    var_1 = "_encstr_BA4C02DF" + var_1;

  var_2 = self.owner getbattlechatteralias("_encstr_B48A0A0A3908E07AB067EF0F" + var_0 + var_1);
  self.soundaliases[self.soundaliases.size] = var_2;
  return 1;
}

reactioncasualty(var_0, var_1, var_2) {
  if(isDefined(var_0) && !scripts\engine\trace::can_see_origin(var_0.origin)) {
    return;
  }
  var_3 = self;
  var_3 endon("_encstr_AD75063D571AE108");
  var_3 endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");
  var_4 = var_3 createchatphrase();
  var_4 addreactionalias("_encstr_8A3C092767D35DE09CEBD2");
  var_3 playphrase(var_4, self);
}

addreactionalias(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = "_encstr_B40101";
  else
    var_1 = "_encstr_BA4C02DF" + var_1;

  var_2 = self.owner getbattlechatteralias("_encstr_B28B0A392B2C8DD1B4DECDBE" + var_0 + var_1);
  self.soundaliases[self.soundaliases.size] = var_2;
  return 1;
}

reactiontaunt(var_0, var_1, var_2) {
  var_3 = self;
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");
  var_4 = var_3 createchatphrase();

  if(isDefined(var_1) && var_1 == "_encstr_8D960D2B8507182BBC7FD153C57380")
    var_4 addhostileburstalias();
  else
    var_4 addtauntalias("_encstr_AD2906FBFA7593E3");

  var_3 playphrase(var_4, self);
}

addhostileburstalias() {
  var_0 = self.owner getbattlechatteralias("_encstr_9565179CB22C6CD196EDE6FA34B7E647D236CAF5985DC9DC3A");

  if(soundexists(var_0))
    self.soundaliases[self.soundaliases.size] = var_0;

  return 1;
}

addtauntalias(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = "_encstr_B40101";
  else
    var_1 = "_encstr_BA4C02DF" + var_1;

  var_2 = self.owner getbattlechatteralias("_encstr_AD2906FBFA7593E3");
  self.soundaliases[self.soundaliases.size] = var_2;
  return 1;
}

reactionfriendlyfire(var_0, var_1, var_2) {
  var_3 = self;
  var_3 endon("_encstr_AD75063D571AE108");
  var_3 endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");
  var_4 = var_3 createchatphrase();
  var_4 addcheckfirealias();
  var_3 playphrase(var_4, self);
}

reactiontakingfire(var_0, var_1, var_2) {
  var_3 = self;
  var_3 endon("_encstr_AD75063D571AE108");
  var_3 endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");
  var_4 = var_3 createchatphrase();
  var_4 addtakingfirealias();
  var_3 playphrase(var_4, self);
}

addcheckfirealias() {
  var_0 = self.owner getbattlechatteralias("_encstr_A6B60B3FF019DB0A7FF4944A6D");
  self.soundaliases[self.soundaliases.size] = var_0;
  return 1;
}

addtakingfirealias() {
  var_0 = self.owner getbattlechatteralias("_encstr_ADE213F8324B78589D9F5173C3C4E034070A70036A");
  self.soundaliases[self.soundaliases.size] = var_0;
  return 1;
}

getqueueevents() {
  var_0 = [];
  var_1 = [];
  var_0[0] = "_encstr_BD34078D57B9A37BD6";
  var_0[1] = "_encstr_840709B34F76BBF8F072C7";
  var_0[2] = "_encstr_88720627AD68179B";
  var_0[3] = "_encstr_85CB07BDE04321538B";
  var_0[4] = "_encstr_85E507408AF3D0F005";
  var_0[5] = "_encstr_830E086EE82B0B361D86";

  for(var_2 = var_0.size - 1; var_2 >= 0; var_2--) {
    for(var_3 = 1; var_3 <= var_2; var_3++) {
      if(self.battlechatter.chatqueue[var_0[var_3 - 1]].priority < self.battlechatter.chatqueue[var_0[var_3]].priority) {
        var_4 = var_0[var_3 - 1];
        var_0[var_3 - 1] = var_0[var_3];
        var_0[var_3] = var_4;
      }
    }
  }

  var_5 = 0;

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_6 = geteventstate(var_0[var_2]);

    if(var_6 == "_encstr_83F2071624E3E241A1" && !var_5) {
      var_5 = 1;
      var_1[var_2] = "_encstr_A307039742" + var_0[var_2] + var_6 + "_encstr_974C0246" + self.battlechatter.chatqueue[var_0[var_2]].priority;
      continue;
    }

    if(var_6 == "_encstr_83F2071624E3E241A1") {
      var_1[var_2] = "_encstr_A60703FB69" + var_0[var_2] + var_6 + "_encstr_974C0246" + self.battlechatter.chatqueue[var_0[var_2]].priority;
      continue;
    }

    if(self.battlechatter.chatqueue[var_0[var_2]].expiretime == 0) {
      var_1[var_2] = "_encstr_8A0703F9B6" + var_0[var_2] + var_6 + "_encstr_974C0246" + self.battlechatter.chatqueue[var_0[var_2]].priority;
      continue;
    }

    var_1[var_2] = "_encstr_AC07035532" + var_0[var_2] + var_6 + "_encstr_974C0246" + self.battlechatter.chatqueue[var_0[var_2]].priority;
  }

  return var_1;
}

geteventstate(var_0) {
  var_1 = "_encstr_B40101";

  if(self.squad.ismembersaying[var_0])
    var_1 = var_1 + "_encstr_81A70928E96856F7A3D052";

  if(gettime() > self.battlechatter.chatqueue[var_0].expiretime)
    var_1 = var_1 + "_encstr_A3AD09489DF843EB13DDA3";

  if(gettime() < self.squad.nextsaytimes[var_0])
    var_1 = var_1 + "_encstr_9BDB0B041B85E6E83783AC16D6";

  if(var_1 == "_encstr_B40101")
    var_1 = "_encstr_83F2071624E3E241A1";

  return var_1;
}

debugprintevents() {
  if(!isalive(self)) {
    return;
  }
  if(getDvar("_encstr_BE741267D1680D02C0ADEF9781F04B4188B95BAF") != self.team && getDvar("_encstr_BE741267D1680D02C0ADEF9781F04B4188B95BAF") != "_encstr_AF1904A7F929") {
    return;
  }
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_AC3C11F0824E3331A39A5BC0741FDBEBB57BD0");
  self endon("_encstr_AC3C11F0824E3331A39A5BC0741FDBEBB57BD0");
  var_0 = getqueueevents();
  var_1["_encstr_A74C0277"] = (0, 1, 0);
  var_1["_encstr_AA4C0279"] = (1, 1, 0);
  var_1["_encstr_844C029C"] = (1, 0, 0);
  var_1["_encstr_8B4C024C"] = (0, 0, 0);

  for(;;) {
    var_2 = self getshootatpos() + (0, 0, 10);

    for(var_3 = 0; var_3 < var_0.size; var_3++)
      var_2 = var_2 + (0, 0, 5);

    wait 0.05;
  }
}

debugqueueevents() {
  if(getDvar("_encstr_ACE411DF82B18BA81828503B0D9723D7CEC39F") == "_encstr_AB0703DBB9")
    thread printqueueevent("_encstr_840709B34F76BBF8F072C7");

  if(getDvar("_encstr_B8830FF82F43C33F40F25F9C236B6F12B3") == "_encstr_AB0703DBB9")
    thread printqueueevent("_encstr_85CB07BDE04321538B");

  if(getDvar("_encstr_A96A0F19B226AEB37D4C6C2D9B33BD27D6") == "_encstr_AB0703DBB9")
    thread printqueueevent("_encstr_85E507408AF3D0F005");

  if(getDvar("_encstr_B4F50EC89526D5CEF5891BB793C82B9C") == "_encstr_AB0703DBB9")
    thread printqueueevent("_encstr_88720627AD68179B");

  if(getDvar("_encstr_998610915926D53BEB988DE61D950B8D1D43") == "_encstr_AB0703DBB9")
    thread printqueueevent("_encstr_830E086EE82B0B361D86");
}

printqueueevent(var_0) {
  var_1 = gettime();

  if(self.battlechatter.chatqueue[var_0].expiretime > 0 && !isDefined(self.battlechatter.chatqueue[var_0].printed)) {
    if(var_1 > self.battlechatter.chatqueue[var_0].expiretime) {} else {}

    self.battlechatter.chatqueue[var_0].printed = 1;
  }
}

getbcstate() {
  if(isDefined(self.fnisinstealthidle) && [[self.fnisinstealthidle]]()) {
    if(isDefined(self.demeanoroverride) && self.demeanoroverride == "_encstr_85BB067A08A3FAB3")
      return "_encstr_85BB067A08A3FAB3";
    else
      return "_encstr_A7C5056BD931D1";
  } else if(isDefined(self.fnisinstealthinvestigate) && [[self.fnisinstealthinvestigate]]())
    return "_encstr_BE1A0C5ADCD9569B3A96CEB0A3B2";
  else if(isDefined(self.fnisinstealthhunt) && [[self.fnisinstealthhunt]]())
    return "_encstr_9ACC05B4156DF3";
  else if(isDefined(self.fnisinstealthcombat) && [[self.fnisinstealthcombat]]())
    return "_encstr_AA7C07466F9DA30713";
  else
    return "_encstr_AA7C07466F9DA30713";
}

set_battlechatter_variable(var_0, var_1) {
  level.battlechatter[var_0] = var_1;
  update_battlechatter_hud();
}

update_battlechatter_hud() {}

bcprint_info() {
  self endon("_encstr_AD75063D571AE108");
}

getname() {
  if(enemy_team_name())
    var_0 = self.ainame;
  else if(self.team == "_encstr_9A8507BA4040188D08")
    var_0 = self.name;
  else
    var_0 = undefined;

  if(!isDefined(var_0))
    return undefined;

  var_1 = strtok(var_0, "_encstr_974C0246");

  if(var_1.size < 2)
    return var_0;

  return var_1[1];
}

isofficer() {
  var_0 = getrank();

  if(!isDefined(var_0))
    return 0;

  if(var_0 == "_encstr_99D409D3FF56E897A1EEFB" || var_0 == "_encstr_B4DF0B8D4BCAAB47B2DC0B9B1D" || var_0 == "_encstr_A6EB08E74102B8A7B7EA" || var_0 == "_encstr_99D409D3FF56E897A1EEFB")
    return 1;

  return 0;
}

bcsdebugwaiter() {
  var_0 = getdvarint("_encstr_BEFC0B0DAB1A390D03A2E128CA");

  for(;;) {
    var_1 = getdvarint("_encstr_BEFC0B0DAB1A390D03A2E128CA");

    if(var_1 != var_0) {
      switch (var_1) {
        case 1:
          if(!anim.chatinitialized)
            enablebattlechatter();

          break;
        case 0:
          if(anim.chatinitialized)
            disablebattlechatter();

          break;
      }

      var_0 = var_1;
    }

    wait 1.0;
  }
}

enablebattlechatter() {
  init_battlechatter();
  anim.player thread scripts\cp\cp_battlechatter_ai::addtosystem();
  var_0 = getaiarray();

  for(var_1 = 0; var_1 < var_0.size; var_1++)
    var_0[var_1] scripts\cp\cp_battlechatter_ai::addtosystem();
}

disablebattlechatter() {
  if(!isDefined(anim.chatinitialized)) {
    return;
  }
  shutdown_battlechatter();
  var_0 = getaiarray();

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(isDefined(var_0[var_1].squad) && var_0[var_1].squad.chatinitialized)
      var_0[var_1].squad shutdown_squadbattlechatter();

    var_0[var_1] scripts\cp\cp_battlechatter_ai::removefromsystem();
  }
}

shutdown_battlechatter() {
  anim.countryids = undefined;
  anim.eventtypeminwait = undefined;
  anim.eventactionminwait = undefined;
  anim.eventtypeminwait = undefined;
  anim.eventpriority = undefined;
  anim.eventduration = undefined;
  anim.moveorigin = undefined;
  anim.scripteddialoguebuffertime = undefined;
  anim.bcs_threatresettime = undefined;
  anim.locationlastcallouttimes = undefined;
  anim.usedids = undefined;
  anim.flavorburstsused = undefined;
  anim.lastteamthreatcallout = undefined;
  anim.lastteamthreatcallouttime = undefined;
  anim.lastnamesaidtimeout = undefined;
  anim.lastnamesaid = undefined;
  anim.lastnamesaidtime = undefined;
  anim.chatinitialized = 0;
  anim.player.chatinitialized = 0;
  level.battlechatter = undefined;
  anim.bcs_locations = undefined;

  for(var_0 = 0; var_0 < anim.squadcreatefuncs.size; var_0++) {
    if(anim.squadcreatestrings[var_0] != "_encstr_817A1AF78283D5EFCB904B419D3183963B489B0A902F8C07E36D255A") {
      continue;
    }
    if(var_0 != anim.squadcreatefuncs.size - 1) {
      anim.squadcreatefuncs[var_0] = anim.squadcreatefuncs[anim.squadcreatefuncs.size - 1];
      anim.squadcreatestrings[var_0] = anim.squadcreatestrings[anim.squadcreatestrings.size - 1];
    }

    anim.squadcreatefuncs[anim.squadcreatefuncs.size - 1] = undefined;
    anim.squadcreatestrings[anim.squadcreatestrings.size - 1] = undefined;
  }

  level notify("_encstr_AAED17080A03C9A8BF53038F3C83F18D7EC2D838A25E014193");
  anim notify("_encstr_AAED17080A03C9A8BF53038F3C83F18D7EC2D838A25E014193");
}

shutdown_squadbattlechatter() {
  var_0 = self;
  var_0.numspeakers = undefined;
  var_0.maxspeakers = undefined;
  var_0.nextsaytime = undefined;
  var_0.nextsaytimes = undefined;
  var_0.nexttypesaytimes = undefined;
  var_0.ismembersaying = undefined;
  var_0.fbt_firstburst = undefined;
  var_0.fbt_lastbursterid = undefined;

  for(var_1 = 0; var_1 < var_0.memberaddfuncs.size; var_1++)
    var_0.memberaddfuncs[var_1] = undefined;

  for(var_1 = 0; var_1 < var_0.memberremovefuncs.size; var_1++)
    var_0.memberremovestrings[var_1] = undefined;

  for(var_1 = 0; var_1 < var_0.squadupdatefuncs.size; var_1++)
    var_0.squadupdatefuncs[var_1] = undefined;

  for(var_1 = 0; var_1 < anim.squadindex.size; var_1++)
    var_0 shutdowncontact(anim.squadindex[var_1].squadname);

  var_0.chatinitialized = 0;
}

shutdowncontact(var_0) {
  self.squadlist[var_0].calledout = undefined;
  self.squadlist[var_0].firstcontact = undefined;
  self.squadlist[var_0].lastcontact = undefined;
}

getrank() {
  return self.airank;
}

pointinfov(var_0) {
  return scripts\engine\utility::within_fov(self.origin, self.angles, var_0, 0.766);
}