/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\inventory\cp_ac130.gsc
***********************************************/

init() {
  level._effect["_encstr_918B15859BCEB236D79963C2392BAF7656BDE84E0BA563"] = loadfx("_encstr_85651E0758E5F66D35C7C518B12D8CD193575D3B82D20127379F2FDBFE1320AB");
  level._effect["_encstr_8A7812DFB5788D605111887F136F4002FFB03BC0"] = loadfx("_encstr_B2982270A36F53E3C2F495884EEACF5984A7F8D82FEA29CF6B9B9B2EE5112D03FECB78A0");
  level._effect["_encstr_9A5007A9E5275F8ACA"] = loadfx("_encstr_8B7C3084124B4F036FB2FFC8E0AEFFF80C9906CB90C3AE276D7EB0CB6E69A7FF12B8F76B878FCBAFB3556D7752A758EE4153");
  level._effect["_encstr_83380768EF1919AF8A"] = loadfx("_encstr_A39318E38B78EE3DDA97DB687B9329E24528C73F60293F32756B");
  level._effect["_encstr_831C0EFBB74EA61FB91DBA8B40F8CD77"] = loadfx("_encstr_96BA250BA22328A06DC263FFFD908341D64AE173BA9F310987B05141EFBA4B98AB015899B3EFFD");
  level._effect["_encstr_AFD010B0C6C466037D8D5A9D34E8F593B291"] = loadfx("_encstr_B18F2DDC8E0B08372DDB28727347F918CF3CEDD6AF17885D16C3F0206B91B95007D0ED586F9F904FBB5A70E1633751");
  level._effect["_encstr_A5221887514BD79F31207B77142B086361FFA9C909EDCC51A072"] = loadfx("_encstr_86E02D6733E197C6ED93AC5EB32B0DD21B63B2B9F21696E436C9C266E8EBC6D2ECD0A3AFDD1A4BE859BE268DA573D6");
  level._effect["_encstr_B8A21650C6EAEA7FF8B067FFA810B7CB40CB5FE2B1B278B0"] = loadfx("_encstr_BED32BFC5F439FD1D77B80DA43F588AB5A45FD86E50ADBBB8303B8A85337C0E362ECED180A2299C66A53F0E0C7");
  level._effect["_encstr_810C0FAA9043CF5BA128F310D5EB8B17A5"] = loadfx("_encstr_AC403060B2C887F03FD0404170B678F335FAD0F84B2753C806A6D4C347E760D75EB2A8C8237EF70333CDE53D5593405D478B");
  level._effect["_encstr_82D617B1DBF6C1D7ADBAD3A78DB2CC638537867D13034DB5B6"] = loadfx("_encstr_AB931E740998F73E4F6807AF089D68F0980E6E121FE9B1C6737B37C1AF9B118B");
  level._effect["_encstr_8170161E9F5059907D5F4390BC4F35FAEF7B18210D50957D"] = loadfx("_encstr_BAA01DD9331E5E6CF69C2BBCB5AEE933B116E6435EC28D4C3360D768065BAD");
  level.radioforcedtransmissionqueue = [];
  level.enemieskilledintimewindow = 0;
  level.lastradiotransmission = gettime();
  level.color["_encstr_998806DD1A96D12B"] = (1, 1, 1);
  level.color["_encstr_8419044EB232"] = (1, 0, 0);
  level.color["_encstr_B29B0550F33591"] = (0.1, 0.3, 1);
  level.cosine = [];
  level.cosine["_encstr_960703127A"] = cos(45);
  level.cosine["_encstr_B84C027E"] = cos(5);
  level.physicssphereradius["_encstr_88F90EF65F8E7A1AEED5251AE97F9788"] = 60;
  level.physicssphereradius["_encstr_88710EC26CC49918FA1A815BB5AFADC1"] = 600;
  level.physicssphereradius["_encstr_A7BC0FA2A8D3626A4E07A8A531D00F3DB9"] = 1000;
  level.physicssphereforce["_encstr_88F90EF65F8E7A1AEED5251AE97F9788"] = 0;
  level.physicssphereforce["_encstr_88710EC26CC49918FA1A815BB5AFADC1"] = 3.0;
  level.physicssphereforce["_encstr_A7BC0FA2A8D3626A4E07A8A531D00F3DB9"] = 6.0;
  level.weaponreloadtime["_encstr_88F90EF65F8E7A1AEED5251AE97F9788"] = 2.0;
  level.weaponreloadtime["_encstr_88710EC26CC49918FA1A815BB5AFADC1"] = 3.5;
  level.weaponreloadtime["_encstr_A7BC0FA2A8D3626A4E07A8A531D00F3DB9"] = 5.5;
  level.ac130_speed["_encstr_ACA20538F84D39"] = 1000;
  level.ac130_speed["_encstr_88CE102BF0A5214087D72F51091B07889519"] = 5000;
  level.ac130_speed["_encstr_B4F507E4BD4785E856"] = 70;
  scripts\engine\utility::flag_init("_encstr_A93A1F6AC305183BE903B72B252F48ABA79EDFF5171B332D133F9032923F05A7BA");
  scripts\engine\utility::flag_set("_encstr_A93A1F6AC305183BE903B72B252F48ABA79EDFF5171B332D133F9032923F05A7BA");
  var_0 = getEntArray("_encstr_A6BC0F4183703022A7E3EFDE40DB48380B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = level.mapcenter;

  if(var_0.size)
    var_1 = scripts\cp\cp_globallogic::findboxcenter(var_0[0].origin, var_0[1].origin);

  if(isDefined(level.ac130_location))
    var_1 = level.ac130_location;

  level.ac130 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1);
  level.ac130 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  level.ac130.angles = (0, 115, 0);
  level.ac130.owner = undefined;
  level.ac130.thermal_vision = "_encstr_B1251107DB7EDBA1118B90F0C3B53B886F4D17";
  level.ac130.enhanced_vision = "_encstr_A13E120BC66299C0F52B37A185B9D85646FA6B07";
  level.ac130.targetname = "_encstr_BEF2169E18534A1028AB48C963486B20F3E5A103C7CB7858";
  level.ac130 hide();
  level.ac130inuse = 0;
  thread rotateplane(level.ac130, "_encstr_AB0703DBB9");
  level.ac130_activate_function = scripts\cp_mp\killstreaks\gunship::tryusegunship;
  level.ac130queue = [];
  init_ac130_vo();
}

ac130activatefunc(var_0) {
  var_1 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("_encstr_A937066AFF52FA4F", var_0);
  thread tryuseac130(var_1);
}

forceac130onplayernow(var_0) {
  var_1 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("_encstr_A937066AFF52FA4F", var_0);
  var_2 = "_encstr_979914D35F4122577120938A0EDD6F9B58E7551F8BE0";
  var_0 scripts\cp\utility::_giveweapon(var_2, 0, 0, 1);
  var_3 = int(tablelookup("_encstr_AB7A17451FC08F44C1703B43683BBE77430FD2CC3DB8E78AAD", 1, var_1.streakname, 0));
  var_0 setclientomnvar("_encstr_86601BAE2D7D9C95AD7B8E59D76CBDCD8E93BDD8EBCD59B8AE95CD1BB2", var_3);
  var_4 = var_0 scripts\cp\cp_weapons::switchtoweaponreliable(var_2);
  var_0 scripts\cp\utility::setusingremote(var_1.streakname);
  var_0 notify("_encstr_8A7B0EDA8FB90C908071386FC16FD8C7");
  var_0 setclientomnvar("_encstr_86601BAE2D7D9C95AD7B8E59D76CBDCD8E93BDD8EBCD59B8AE95CD1BB2", 0);
  var_0 scripts\cp\utility::clearusingremote();
  var_0 scripts\cp_mp\utility\killstreak_utility::stoptabletscreen();

  if(isDefined(var_2))
    var_0 takeweapon(var_2);

  var_0 setclientomnvar("_encstr_86601BAE2D7D9C95AD7B8E59D76CBDCD8E93BDD8EBCD59B8AE95CD1BB2", 0);
  var_5 = ac130_startuse(var_0, var_1);

  if(!istrue(var_5))
    return 0;
}

spawn_ambient_ac130(var_0) {
  var_1 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("_encstr_A937066AFF52FA4F", var_0);
  var_2 = ac130_spawn(var_0, var_1);
  return var_2;
}

weapongivenac130(var_0) {}

init_ac130_vo() {
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A7080CDB7B5A8A177792307BCB5F"] = "_encstr_A7080CDB7B5A8A177792307BCB5F";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BEFD150BAB8A5AA7C7A7AB034A2728E8370C8F83544728"] = "_encstr_8CAE13EF03A60309B95350E07ACE69467EF84D5195";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_ADA014E067D9838129DBD771E5414D31FC3F7840C724"] = "_encstr_B4CE12C28D896606F5E495367B588CEB680CDAB5";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9A1414588D133360EB199A6BDAAF9C2B63B716465946"] = "_encstr_97DD1206EE03575886E0EF33F0B9C459DD5D8DBD";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AA5B0EF13EAB468A3F68622A99891493"] = "_encstr_AA5B0EF13EAB468A3F68622A99891493";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AD130F58C61399C0AFD9EDF623F543961D"] = "_encstr_AD130F58C61399C0AFD9EDF623F543961D";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B8E51A9E76ABFFE03E786747B8306FE1E99F6516ECBB71F480F87B23"] = "_encstr_83F31C46AE431718C610BFF740B905999D35CE7E8D1B2A9EEE7897D720F3";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_95611B58B12666C0F58E165BB437CEF5C8B0DA16D9597D5BB2465A575B"] = "_encstr_93EA1D2FB08B83B7078D9E95672FBAA74B38A7BFE078079A2F11E7CF5BE3F2";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_81C81A0E39DA634FE8A9BF9FFB286257D8C185965180C702DD9B9BCF"] = "_encstr_B62C1CFB4EAAB370802C5F9DE701780708DD36220D01B56BF780BD6240D0";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A7C00F7B399F1B52F78A9848D8A3140850"] = "_encstr_8CF20C9017A9F3F1795E46C7B2E2";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B8860D3249BFE622C9F52C29B570BA"] = "_encstr_9B7C14B65E93C7C816608FC7684958C985613EEA357F";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BAF913C21B1333037DB64BDC37D2B195FAB1B76CDA"] = "_encstr_BAF913C21B1333037DB64BDC37D2B195FAB1B76CDA";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8F73140631D26B57E093978BD993E9638018FBCB6990"] = "_encstr_8C3E1A08324A6F0B6F75A511449FAE9BC53A1040697221383B74A51D";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8E5B15B0C62699C0FA9B4BDCD96359AFE607DB1DA359C8"] = "_encstr_8D371B3F569FEF83DFB73818FF34E1FF62BDA5B1A81137B3C743D848DB";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AD070D4AB08FE2B897D370B1ADDAF9"] = "_encstr_AD070D4AB08FE2B897D370B1ADDAF9";
}

tryuseac130(var_0) {
  if(isDefined(level.ac130player) || level.ac130inuse) {
    self iprintlnbold(&"_encstr_819B225BAB843BD2A969A0F8B97F05C79C8EC7DB5F4D5F6F97B1081031370247B71D6544");
    return 0;
  }

  var_1 = scripts\cp\cp_drone_strike::playremotesequence(var_0);

  if(!var_1) {
    self notify("_encstr_95E2216DD2631BE61DE4B20BB6F5995ADC9637A12B32AFDD4BE834AFEEB2C21CBD37AF" + var_0.weaponname);
    return 0;
  }

  var_1 = ac130_startuse(self, var_0);

  if(!istrue(var_1))
    return 0;

  if(isDefined(level.ac130player) || istrue(level.ac130inuse)) {
    self iprintlnbold(&"_encstr_819B225BAB843BD2A969A0F8B97F05C79C8EC7DB5F4D5F6F97B1081031370247B71D6544");
    return 0;
  }

  foreach(var_3 in level.players) {
    if(var_3 != self)
      var_3 thread scripts\cp\cp_hud_message::showsplash("_encstr_8C480EEAD370373AC039A761CF9AD2EA", undefined, self);
  }

  level.ac130inuse = 1;
  level notify("_encstr_BEB60B605A2217735FEE2D36FD", self);
  return var_1;
}

init_sounds() {
  level.scr_sound["_encstr_8B1804D330A0"]["_encstr_B61904310B39"] = "_encstr_B40101";
  add_context_sensitive_dialog("_encstr_A107039AA0", "_encstr_B1C4094B73BECD96B3431D", 0, "_encstr_A1FD140B1B8966187D338DB77D6BED9359B27359D697");
  add_context_sensitive_dialog("_encstr_A107039AA0", "_encstr_B1C4094B73BECD96B3431D", 1, "_encstr_A3A215586CC49918FA996CBDD73B5647E81A853AECBACB");
  add_context_sensitive_dialog("_encstr_A107039AA0", "_encstr_B1C4094B73BECD96B3431D", 2, "_encstr_B63D13DFB67F0F633FC348303F5F83D3C2DDCC534D");
  add_context_sensitive_dialog("_encstr_A107039AA0", "_encstr_B1C4094B73BECD96B3431D", 3, "_encstr_92C814856C9899C0AF338DEDAFCE563A07B239DC7B73");
  add_context_sensitive_dialog("_encstr_A107039AA0", "_encstr_B1C4094B73BECD96B3431D", 4, "_encstr_A51314EE06DB8FF02EF85F6719018D93F5A5B5A5FBBD");
  add_context_sensitive_dialog("_encstr_A107039AA0", "_encstr_B1C4094B73BECD96B3431D", 5, "_encstr_BAFC1585B189CC0CFA33B17BFA76F6E85827BA9B9B594E");
  add_context_sensitive_dialog("_encstr_A107039AA0", "_encstr_B1C4094B73BECD96B3431D", 6, "_encstr_881A1616B1989918FA668DBDAF4C58C6D67BE6D11AB737CA");
  add_context_sensitive_dialog("_encstr_A107039AA0", "_encstr_B1C4094B73BECD96B3431D", 7, "_encstr_856D16C28D89CC60BE33C6F6AF3BDEE63785EC2B8EA1B4AD");
  add_context_sensitive_dialog("_encstr_A107039AA0", "_encstr_B1C4094B73BECD96B3431D", 8, "_encstr_ADDD199B3B1ACA57372251D8D9E3A598229F3D0DA5B538B3E77BE9");
  add_context_sensitive_dialog("_encstr_A107039AA0", "_encstr_B1C4094B73BECD96B3431D", 9, "_encstr_B29318DAC8E7BFBFA18CEF508F7A2A4F1981B09FB3B3A7870BA7");
  add_context_sensitive_dialog("_encstr_A107039AA0", "_encstr_B1C4094B73BECD96B3431D", 11, "_encstr_82BE14C93ED972F70163C7D76FDA93082853F1C023E0");
  add_context_sensitive_dialog("_encstr_A107039AA0", "_encstr_B1C4094B73BECD96B3431D", 12, "_encstr_AC0715733FA72E3A9F5FA138099CF84A5ABBFBE3F70B55");
  add_context_sensitive_dialog("_encstr_A107039AA0", "_encstr_B1C4094B73BECD96B3431D", 14, "_encstr_93A6166E59BA032F88C1ABC3B743A28998A1A5F7B1181D22");
  add_context_sensitive_dialog("_encstr_A107039AA0", "_encstr_B1C4094B73BECD96B3431D", 15, "_encstr_86B014E0DAA297F38770313547AFC0D91863080832CF");
  add_context_sensitive_dialog("_encstr_A107039AA0", "_encstr_B1C4094B73BECD96B3431D", 16, "_encstr_838E15076EA7D7ABF73B80E8F7F258A7DA53051B472B33");
  add_context_sensitive_dialog("_encstr_A107039AA0", "_encstr_B1C4094B73BECD96B3431D", 17, "_encstr_8DA513B036989903BE66B1DE7DE8392C6CD62D9BD9");
  add_context_sensitive_dialog("_encstr_A107039AA0", "_encstr_B1C4094B73BECD96B3431D", 0, "_encstr_A3A215586CC49918FA996CBDD73B5647E81A853AECBACB");
  add_context_sensitive_dialog("_encstr_A107039AA0", "_encstr_B1C4094B73BECD96B3431D", 1, "_encstr_B63D13DFB67F0F633FC348303F5F83D3C2DDCC534D");
  add_context_sensitive_dialog("_encstr_A107039AA0", "_encstr_B1C4094B73BECD96B3431D", 2, "_encstr_92C814856C9899C0AF338DEDAFCE563A07B239DC7B73");
  add_context_sensitive_dialog("_encstr_A107039AA0", "_encstr_B1C4094B73BECD96B3431D", 3, "_encstr_A51314EE06DB8FF02EF85F6719018D93F5A5B5A5FBBD");
  add_context_sensitive_dialog("_encstr_A107039AA0", "_encstr_B1C4094B73BECD96B3431D", 4, "_encstr_BAFC1585B189CC0CFA33B17BFA76F6E85827BA9B9B594E");
  add_context_sensitive_dialog("_encstr_A107039AA0", "_encstr_B1C4094B73BECD96B3431D", 5, "_encstr_881A1616B1989918FA668DBDAF4C58C6D67BE6D11AB737CA");
  add_context_sensitive_dialog("_encstr_A107039AA0", "_encstr_B1C4094B73BECD96B3431D", 6, "_encstr_856D16C28D89CC60BE33C6F6AF3BDEE63785EC2B8EA1B4AD");
  add_context_sensitive_dialog("_encstr_A107039AA0", "_encstr_B1C4094B73BECD96B3431D", 7, "_encstr_B29318DAC8E7BFBFA18CEF508F7A2A4F1981B09FB3B3A7870BA7");
  add_context_sensitive_dialog("_encstr_A107039AA0", "_encstr_B1C4094B73BECD96B3431D", 8, "_encstr_82BE14C93ED972F70163C7D76FDA93082853F1C023E0");
  add_context_sensitive_dialog("_encstr_A107039AA0", "_encstr_B1C4094B73BECD96B3431D", 9, "_encstr_AC0715733FA72E3A9F5FA138099CF84A5ABBFBE3F70B55");
  add_context_sensitive_dialog("_encstr_A107039AA0", "_encstr_B1C4094B73BECD96B3431D", 10, "_encstr_93A6166E59BA032F88C1ABC3B743A28998A1A5F7B1181D22");
  add_context_sensitive_dialog("_encstr_A107039AA0", "_encstr_B1C4094B73BECD96B3431D", 11, "_encstr_86B014E0DAA297F38770313547AFC0D91863080832CF");
  add_context_sensitive_dialog("_encstr_A107039AA0", "_encstr_B1C4094B73BECD96B3431D", 0, "_encstr_A1FD140B1B8966187D338DB77D6BED9359B27359D697");
  add_context_sensitive_dialog("_encstr_A107039AA0", "_encstr_B1C4094B73BECD96B3431D", 1, "_encstr_A3A215586CC49918FA996CBDD73B5647E81A853AECBACB");
  add_context_sensitive_dialog("_encstr_A107039AA0", "_encstr_B1C4094B73BECD96B3431D", 2, "_encstr_B63D13DFB67F0F633FC348303F5F83D3C2DDCC534D");
  add_context_sensitive_dialog("_encstr_A107039AA0", "_encstr_B1C4094B73BECD96B3431D", 3, "_encstr_92C814856C9899C0AF338DEDAFCE563A07B239DC7B73");
  add_context_sensitive_dialog("_encstr_A107039AA0", "_encstr_B1C4094B73BECD96B3431D", 4, "_encstr_A51314EE06DB8FF02EF85F6719018D93F5A5B5A5FBBD");
  add_context_sensitive_dialog("_encstr_A107039AA0", "_encstr_B1C4094B73BECD96B3431D", 5, "_encstr_BAFC1585B189CC0CFA33B17BFA76F6E85827BA9B9B594E");
  add_context_sensitive_dialog("_encstr_A107039AA0", "_encstr_B1C4094B73BECD96B3431D", 6, "_encstr_881A1616B1989918FA668DBDAF4C58C6D67BE6D11AB737CA");
  add_context_sensitive_dialog("_encstr_A107039AA0", "_encstr_B1C4094B73BECD96B3431D", 7, "_encstr_856D16C28D89CC60BE33C6F6AF3BDEE63785EC2B8EA1B4AD");
  add_context_sensitive_dialog("_encstr_A107039AA0", "_encstr_B1C4094B73BECD96B3431D", 8, "_encstr_ADDD199B3B1ACA57372251D8D9E3A598229F3D0DA5B538B3E77BE9");
  add_context_sensitive_dialog("_encstr_A107039AA0", "_encstr_B1C4094B73BECD96B3431D", 9, "_encstr_B29318DAC8E7BFBFA18CEF508F7A2A4F1981B09FB3B3A7870BA7");
  add_context_sensitive_dialog("_encstr_A107039AA0", "_encstr_B1C4094B73BECD96B3431D", 11, "_encstr_82BE14C93ED972F70163C7D76FDA93082853F1C023E0");
  add_context_sensitive_dialog("_encstr_A107039AA0", "_encstr_B1C4094B73BECD96B3431D", 12, "_encstr_AC0715733FA72E3A9F5FA138099CF84A5ABBFBE3F70B55");
  add_context_sensitive_dialog("_encstr_A107039AA0", "_encstr_B1C4094B73BECD96B3431D", 14, "_encstr_93A6166E59BA032F88C1ABC3B743A28998A1A5F7B1181D22");
  add_context_sensitive_dialog("_encstr_A107039AA0", "_encstr_B1C4094B73BECD96B3431D", 15, "_encstr_86B014E0DAA297F38770313547AFC0D91863080832CF");
  add_context_sensitive_dialog("_encstr_A107039AA0", "_encstr_B1C4094B73BECD96B3431D", 16, "_encstr_838E15076EA7D7ABF73B80E8F7F258A7DA53051B472B33");
  add_context_sensitive_dialog("_encstr_A107039AA0", "_encstr_B1C4094B73BECD96B3431D", 17, "_encstr_8DA513B036989903BE66B1DE7DE8392C6CD62D9BD9");
  add_context_sensitive_dialog("_encstr_A107039AA0", "_encstr_A93A0E0BCF43100A4A04771F263F30A8", 0, "_encstr_B4A21648FA53AE7FCF971E020F99A84BE0E201C022DB69CE");
  add_context_sensitive_timeout("_encstr_A107039AA0", "_encstr_A93A0E0BCF43100A4A04771F263F30A8", undefined, 6);
  add_context_sensitive_dialog("_encstr_A107039AA0", "_encstr_9A430D98D27BF5A1A75C907F31FFA8", 0, "_encstr_9A421728126A4F2B4F5E8EF00FCB889D277AE8909B150B389B");
  add_context_sensitive_dialog("_encstr_A107039AA0", "_encstr_9A430D98D27BF5A1A75C907F31FFA8", 1, "_encstr_B26F16DEE90AB37FD8BDE7DFE7FAA257307057E70390A6F2");
  add_context_sensitive_dialog("_encstr_A107039AA0", "_encstr_9A430D98D27BF5A1A75C907F31FFA8", 2, "_encstr_B1831AF077C99391197F6E6019826743CE5F2038D33C90F773A4D07C");
  add_context_sensitive_dialog("_encstr_A107039AA0", "_encstr_9A430D98D27BF5A1A75C907F31FFA8", 3, "_encstr_83DE17C2C626CC03EBCC6CF6AFCE56E83A96CD130B6CAD57E0");
  add_context_sensitive_dialog("_encstr_A107039AA0", "_encstr_9A430D98D27BF5A1A75C907F31FFA8", 4, "_encstr_B4B419300A7227433736E6E83797D1694AE3F8A012BD27C38756FC");
  add_context_sensitive_dialog("_encstr_A107039AA0", "_encstr_9A430D98D27BF5A1A75C907F31FFA8", 5, "_encstr_B8AC166B27BF3632E727A92001934843C2A3FBEF9BC25040");
  add_context_sensitive_timeout("_encstr_A107039AA0", "_encstr_9A430D98D27BF5A1A75C907F31FFA8", undefined, 12);
  add_context_sensitive_dialog("_encstr_A30108473FBA97C8D662", "_encstr_8CCD0C26186AB65BD74E591623CB", 0, "_encstr_BDFB14499603EE12A728EA23013FBB63830DD1C4335B");
  add_context_sensitive_dialog("_encstr_A30108473FBA97C8D662", "_encstr_935A0C890C535BADD733B44EAC19", 0, "_encstr_A22510C6F112AB9720473BB3CFDEDA3FE013");
  add_context_sensitive_dialog("_encstr_824E060F2147FBB8", "_encstr_85D30BBAC26239805D4F4F51A0", 0, "_encstr_95F913856C98990CF51C633AEB39DBC68DA5379637");
  add_context_sensitive_dialog("_encstr_8E440A950FE01BB76E96BDE6", "_encstr_AC8F0AE74163F85AAA380AD8", 0, "_encstr_A1A917272789F792B018C6B3100722114758136FC34405C7D1");
  add_context_sensitive_timeout("_encstr_8E440A950FE01BB76E96BDE6", "_encstr_AC8F0AE74163F85AAA380AD8", undefined, 7);
  add_context_sensitive_dialog("_encstr_ABD70578F3D02C", "_encstr_BDDC07EBCCB5CA4BED", 0, "_encstr_8E1F14856C263303D7C1361DFAD9F61DD12C34BAE4A3");
  add_context_sensitive_dialog("_encstr_ABD70578F3D02C", "_encstr_BDDC07EBCCB5CA4BED", 1, "_encstr_816315BE896AD3DF781D477F071B93FDA073340721105B");
  add_context_sensitive_dialog("_encstr_ABD70578F3D02C", "_encstr_BDDC07EBCCB5CA4BED", 2, "_encstr_ABC316C236C4990CD7CCB1B7EBDEBD1C374B5632B02D6EF2");
  add_context_sensitive_dialog("_encstr_ABD70578F3D02C", "_encstr_BDDC07EBCCB5CA4BED", 3, "_encstr_9588131BBB9A4AD7B7A2D158593F20F0671BB3892C");
  add_context_sensitive_dialog("_encstr_ABD70578F3D02C", "_encstr_BDDC07EBCCB5CA4BED", 4, "_encstr_AFA41449D156DB4211F7FA8FD1F157E8DF9FD3F3A0E2");
  add_context_sensitive_dialog("_encstr_ABD70578F3D02C", "_encstr_BDDC07EBCCB5CA4BED", 5, "_encstr_ABD31528F63A73118E0D1FFD0917C005E7603CEA033B02");
  add_context_sensitive_dialog("_encstr_ABD70578F3D02C", "_encstr_BDDC07EBCCB5CA4BED", 6, "_encstr_83CD14583698CC03AF9936BDD78E0DB03A3716D04B8E");
  add_context_sensitive_dialog("_encstr_ABD70578F3D02C", "_encstr_BDDC07EBCCB5CA4BED", 7, "_encstr_9A58146BCBEA3A87E7F2E16889E3D3C81723D9F179E3");
  add_context_sensitive_dialog("_encstr_ABD70578F3D02C", "_encstr_BDDC07EBCCB5CA4BED", 8, "_encstr_B695187BDBFA2AB7D7C2F178794BC35044249FED5456685447FB");
  add_context_sensitive_dialog("_encstr_ABD70578F3D02C", "_encstr_BDDC07EBCCB5CA4BED", 9, "_encstr_8DC91643E332E26F0F0A09B0A1F78AF8FD6DC7279CCC8819");
  add_context_sensitive_dialog("_encstr_ABD70578F3D02C", "_encstr_BDDC07EBCCB5CA4BED", 10, "_encstr_A7D616B06C13990CBE99C6B7D7BB5AD143D29B6433ACACE8");
  add_context_sensitive_dialog("_encstr_ABD70578F3D02C", "_encstr_B2A80C2AF3CB991BFF87036808F9", 0, "_encstr_A57E0F2EC61B4FB06EB81F275960D1F21B");
  add_context_sensitive_dialog("_encstr_ABD70578F3D02C", "_encstr_B2A80C2AF3CB991BFF87036808F9", 1, "_encstr_BE71152CB1896603FA66C6DEFA464B9CACB1D186D28EDC");
  add_context_sensitive_dialog("_encstr_ABD70578F3D02C", "_encstr_B2A80C2AF3CB991BFF87036808F9", 2, "_encstr_816315BE896AD3DF781D477F071B93FDA073340721105B");
  add_context_sensitive_dialog("_encstr_ABD70578F3D02C", "_encstr_B2A80C2AF3CB991BFF87036808F9", 3, "_encstr_9588131BBB9A4AD7B7A2D158593F20F0671BB3892C");
  add_context_sensitive_dialog("_encstr_ABD70578F3D02C", "_encstr_B2A80C2AF3CB991BFF87036808F9", 4, "_encstr_AFA41449D156DB4211F7FA8FD1F157E8DF9FD3F3A0E2");
  add_context_sensitive_dialog("_encstr_ABD70578F3D02C", "_encstr_B2A80C2AF3CB991BFF87036808F9", 5, "_encstr_ABD31528F63A73118E0D1FFD0917C005E7603CEA033B02");
  add_context_sensitive_dialog("_encstr_ABD70578F3D02C", "_encstr_B2A80C2AF3CB991BFF87036808F9", 6, "_encstr_83CD14583698CC03AF9936BDD78E0DB03A3716D04B8E");
  add_context_sensitive_dialog("_encstr_ABD70578F3D02C", "_encstr_B2A80C2AF3CB991BFF87036808F9", 7, "_encstr_9A58146BCBEA3A87E7F2E16889E3D3C81723D9F179E3");
  add_context_sensitive_dialog("_encstr_ABD70578F3D02C", "_encstr_B2A80C2AF3CB991BFF87036808F9", 8, "_encstr_B695187BDBFA2AB7D7C2F178794BC35044249FED5456685447FB");
  add_context_sensitive_dialog("_encstr_ABD70578F3D02C", "_encstr_B2A80C2AF3CB991BFF87036808F9", 9, "_encstr_8DC91643E332E26F0F0A09B0A1F78AF8FD6DC7279CCC8819");
  add_context_sensitive_dialog("_encstr_B6A2056BD237D8", "_encstr_B40B07666F8BC31783", 0, "_encstr_8DA513B036989903BE66B1DE7DE8392C6CD62D9BD9");
  add_context_sensitive_timeout("_encstr_B6A2056BD237D8", "_encstr_B40B07666F8BC31783", 0, 70);
  add_context_sensitive_dialog("_encstr_B6A2056BD237D8", "_encstr_B40B07666F8BC31783", 1, "_encstr_A1FD140B1B8966187D338DB77D6BED9359B27359D697");
  add_context_sensitive_timeout("_encstr_B6A2056BD237D8", "_encstr_B40B07666F8BC31783", 1, 80);
  add_context_sensitive_dialog("_encstr_B6A2056BD237D8", "_encstr_B40B07666F8BC31783", 2, "_encstr_A6DF0D16D86299C0F53916B9C8DEAD");
  add_context_sensitive_timeout("_encstr_B6A2056BD237D8", "_encstr_B40B07666F8BC31783", 2, 55);
  add_context_sensitive_dialog("_encstr_B6A2056BD237D8", "_encstr_B40B07666F8BC31783", 3, "_encstr_838E15076EA7D7ABF73B80E8F7F258A7DA53051B472B33");
  add_context_sensitive_timeout("_encstr_B6A2056BD237D8", "_encstr_B40B07666F8BC31783", 3, 100);
}

add_context_sensitive_dialog(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.scr_sound[var_0]) || !isDefined(level.scr_sound[var_0][var_1]) || !isDefined(level.scr_sound[var_0][var_1][var_2])) {
    level.scr_sound[var_0][var_1][var_2] = spawnStruct();
    level.scr_sound[var_0][var_1][var_2].played = 0;
    level.scr_sound[var_0][var_1][var_2].sounds = [];
  }

  var_4 = level.scr_sound[var_0][var_1][var_2].sounds.size;
  level.scr_sound[var_0][var_1][var_2].sounds[var_4] = var_3;
}

add_context_sensitive_timeout(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.context_sensative_dialog_timeouts))
    level.context_sensative_dialog_timeouts = [];

  var_4 = 0;

  if(!isDefined(level.context_sensative_dialog_timeouts[var_0]))
    var_4 = 1;
  else if(!isDefined(level.context_sensative_dialog_timeouts[var_0][var_1]))
    var_4 = 1;

  if(var_4)
    level.context_sensative_dialog_timeouts[var_0][var_1] = spawnStruct();

  if(isDefined(var_2)) {
    level.context_sensative_dialog_timeouts[var_0][var_1].groups = [];
    level.context_sensative_dialog_timeouts[var_0][var_1].groups[scripts\engine\utility::string(var_2)] = spawnStruct();
    level.context_sensative_dialog_timeouts[var_0][var_1].groups[scripts\engine\utility::string(var_2)].v["_encstr_8B44108BE079470D7009AC851D0813BF90F8"] = var_3 * 1000;
    level.context_sensative_dialog_timeouts[var_0][var_1].groups[scripts\engine\utility::string(var_2)].v["_encstr_B8680B310BC763F99C010B5D22"] = var_3 * -1000;
  } else {
    level.context_sensative_dialog_timeouts[var_0][var_1].v["_encstr_8B44108BE079470D7009AC851D0813BF90F8"] = var_3 * 1000;
    level.context_sensative_dialog_timeouts[var_0][var_1].v["_encstr_B8680B310BC763F99C010B5D22"] = var_3 * -1000;
  }
}

ac130_monitormanualplayerexit(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  thread scripts\cp\utility::allowridekillstreakplayerexit();
  self waittill("_encstr_A2DA0F6DD2B136CDD1275958B5A8E1D2A3");
  thread ac130_leave(var_0);
}

ac130_startuse(var_0, var_1) {
  self endon("_encstr_B87314472EE797EB9853D0185FB25E4DCAD5C854070A");

  if(isDefined(level.ac130player))
    return 0;

  var_2 = ac130_spawn(var_0, var_1);

  if(!isDefined(var_2))
    return 0;

  if(getdvarint("_encstr_82570B397A4D3192935192A562"))
    var_0 scripts\cp\utility::setthirdpersondof(0);

  var_0.gunship = var_2;
  var_2 thread ac130_attachgunner(var_0);
  var_2 thread ac130_watchchangeweapons(var_0);
  var_2 thread ac130_watchweaponfired(var_0);
  var_2 thread ac130_watchdamage(var_0);

  if(!istrue(var_0.no_ac130_timeout))
    var_2 thread ac130_watchtimeout(var_0);

  var_2 thread ac130_watchowner(var_0);
  var_2 thread ac130_playpilotfx(var_0);
  var_2 thread ac130_monitormanualplayerexit(var_0);
  var_0 scripts\cp\utility::setusingremote(var_1.streakname);
  return 1;
}

ac130_returnplayer(var_0, var_1) {
  var_0 notify("_encstr_B87314472EE797EB9853D0185FB25E4DCAD5C854070A");
  level notify("_encstr_B87314472EE797EB9853D0185FB25E4DCAD5C854070A");

  if(isDefined(var_0) && !istrue(var_1)) {
    var_0 setclientomnvar("_encstr_8DE30DAE96D70B1BC49903FA0DD5C8", 0);
    var_0 stoploopsound();
    var_0 visionsetkillstreakforplayer("_encstr_B40101");
    var_0 unlink();

    if(getdvarint("_encstr_82570B397A4D3192935192A562"))
      var_0 scripts\cp\utility::setthirdpersondof(1);

    if(var_0 scripts\cp_mp\utility\player_utility::_isalive())
      var_0 scripts\cp\cp_weapons::_switchtoweapon(var_0.lastdroppableweaponobj);

    var_2 = undefined;

    if(!isDefined(var_2) || !var_2) {
      var_0 scripts\cp\cp_weapons::_takeweapon("_encstr_A7BC0FA2A8D3626A4E07A8A531D00F3DB9");
      var_0 scripts\cp\cp_weapons::_takeweapon("_encstr_88710EC26CC49918FA1A815BB5AFADC1");
      var_0 scripts\cp\cp_weapons::_takeweapon("_encstr_88F90EF65F8E7A1AEED5251AE97F9788");
      var_0 scripts\common\utility::allow_weapon_switch(1);
    }

    if(isDefined(var_0.ac130_cloudsfx))
      var_0.ac130_cloudsfx delete();

    var_0 thread scripts\cp\cp_drone_strike::stopremotesequence();
  }

  if(isDefined(self.enemytargetmarkergroup))
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(self.enemytargetmarkergroup);

  if(isDefined(self.friendlytargetmarkergroup))
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(self.friendlytargetmarkergroup);

  level.ac130inuse = 0;
  var_0 scripts\cp\utility::clearusingremote();
}

ac130_watchdamage(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_B87314472EE797EB9853D0185FB25E4DCAD5C854070A");
  self.damagetaken = 0;
  self.attractor = missile_createattractorent(self, 1000, 4096);

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    var_11 = undefined;

    if(isDefined(level.teambased) && isPlayer(var_2) && (var_2.team == self.team && (!isDefined(var_11) || !var_11))) {
      continue;
    }
    if(var_5 == "_encstr_A68211A30F035922EF7BF1F55F0E4B59EB2BB9" || var_5 == "_encstr_950A12A99E887D284AD42A7A31D748AA98C4A215" || var_5 == "_encstr_A7E3151D0854967FE86A69475ED92EC387C0A129A1BFE5") {
      continue;
    }
    self.wasdamaged = 1;

    if(isPlayer(var_2)) {}

    if(isDefined(var_2.owner) && isPlayer(var_2.owner)) {}

    var_12 = 0;
    self.damagetaken = self.damagetaken + var_12;
    var_13 = self.maxhealth - self.damagetaken;
    var_0 setclientomnvar("_encstr_8B4F1557D2F5B6D236C637E839AC2CDABE0DB2B0B11D1A", var_13 / self.maxhealth);

    if(self.damagetaken >= self.maxhealth) {
      if(isPlayer(var_2)) {}

      thread ac130_crash(5, var_0);
    }
  }
}

ac130_watchtimeout(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_B87314472EE797EB9853D0185FB25E4DCAD5C854070A");
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(self.timeout);
  thread ac130_leave(var_0);
}

ac130_leave(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self unlink();
  var_1 = self.angles;
  var_2 = anglesToForward(var_1);
  ac130_returnplayer(var_0, 0);
  self moveTo(self.origin + var_2 * 50000, 10, 5);
  ac130_waittilldestination(self.origin + var_2 * 50000);
  ac130_removeplane();
}

ac130_waittilldestination(var_0) {
  while(isDefined(self) && self.origin != var_0)
    waitframe();
}

ac130_watchowner(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_B87314472EE797EB9853D0185FB25E4DCAD5C854070A");
  var_1 = var_0 scripts\engine\utility::_id_143A6("_encstr_8D820B49520F0EC02DDE6367EC", "_encstr_81170C244F9CBDE72C01BB99A298", "_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  var_2 = 0;

  if(istrue(var_1) && var_1 == "_encstr_8D820B49520F0EC02DDE6367EC")
    var_2 = 1;

  thread ac130_crash(5, var_0);
}

ac130_spawn(var_0, var_1) {
  if(isDefined(level.ac130_gunship))
    return level.ac130_gunship;

  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", level.ac130.origin);
  var_2 setModel("_encstr_95F719D9AC34C1D7D65A63AF2CB49CF52C8D3416396396594C990C");
  var_2 setCanDamage(1);
  var_2.maxhealth = 1000;
  var_2.health = 99999;
  var_2.owner = var_0;
  var_2.team = var_0.team;
  var_2.timeout = 40;
  var_2.flaresreservecount = 2;
  var_2.streakinfo = var_1;
  var_2 scriptmoveroutline();
  var_2 scriptmoverthermal();
  var_4 = randomint(360);
  var_5 = 5000;
  var_6 = cos(var_4) * var_5;
  var_7 = sin(var_4) * var_5;
  var_8 = 10000;
  var_9 = vectorNormalize((var_6, var_7, var_8));
  var_9 = var_9 * var_8;
  var_2 linkTo(level.ac130, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", var_9, (0, var_4 + 90, 0));
  level notify("_encstr_993D15DA0BE1DEA3B3459387E6596F257F59934278BD17", var_2);
  level.ac130_gunship = var_2;
  return var_2;
}

debugview() {
  self endon("_encstr_AD75063D571AE108");

  for(;;)
    waitframe();
}

ac130_updateoverlaycoords(var_0) {
  level endon("_encstr_B87314472EE797EB9853D0185FB25E4DCAD5C854070A");
  self endon("_encstr_B87314472EE797EB9853D0185FB25E4DCAD5C854070A");
  wait 0.05;
  thread ac130_updateplanemodelcoords(var_0);
  thread ac130_updateplayerpositioncoords();
  thread ac130_updateaimingcoords();
}

ac130_updateplanemodelcoords(var_0) {
  level endon("_encstr_B87314472EE797EB9853D0185FB25E4DCAD5C854070A");
  self endon("_encstr_B87314472EE797EB9853D0185FB25E4DCAD5C854070A");

  for(;;) {
    self setclientomnvar("_encstr_AFE615AB96F5C236629981FA8DB7DEC91998F51CF637C3", int(var_0.origin[0]));
    self setclientomnvar("_encstr_9AE615808F7709E70FDA17A826023793B40649202FF342", int(var_0.origin[1]));
    self setclientomnvar("_encstr_8CE615D5A5BE2CD8893318AFB17BF64E19C4EB837BDCA7", int(var_0.origin[2]));
    wait 0.5;
  }
}

ac130_updateplayerpositioncoords() {
  level endon("_encstr_B87314472EE797EB9853D0185FB25E4DCAD5C854070A");
  self endon("_encstr_B87314472EE797EB9853D0185FB25E4DCAD5C854070A");
  waitframe();
  self setclientomnvar("_encstr_9127155862213B91C63B17B84397D8A5577F91F87A4241", int(self.origin[0]));
  self setclientomnvar("_encstr_AC271573F141983E4EB77B9E5ADFE0D827029FF16F3210", int(self.origin[1]));
  self setclientomnvar("_encstr_A32715C3FA17D778126B31F723ED502683271EEB220F92", int(self.origin[2]));
}

ac130_updateaimingcoords() {
  self endon("_encstr_B87314472EE797EB9853D0185FB25E4DCAD5C854070A");

  for(;;) {
    var_0 = self getvieworigin();
    var_1 = var_0 + anglesToForward(self getplayerangles()) * 15000;
    var_2 = physicstrace(var_0, var_1);
    self setclientomnvar("_encstr_92FF150BD0372967C2D3F3413708EA43BCD799334FF82B", int(var_2[0]));
    self setclientomnvar("_encstr_BEFF1523A111C80E7E87AB4EAA2F30E87753EFA15FC2C0", int(var_2[1]));
    self setclientomnvar("_encstr_BDFF158564C9FB5901E6A2E19F671015A21A688F7DA375", int(var_2[2]));
    wait 0.1;
  }
}

ac130shellshock() {
  self endon("_encstr_B87314472EE797EB9853D0185FB25E4DCAD5C854070A");
  level endon("_encstr_87C416E0F6CDA3BE2B99992BC63ACD7D19966E0BC41BACC8");
  var_0 = 5;

  for(;;) {
    self shellshock("_encstr_A937066AFF52FA4F", var_0);
    wait(var_0);
  }
}

rotateplane(var_0, var_1) {
  level notify("_encstr_B15F18D349D8BAD79658FBD24365A3F5F0D57D77D108C2E73711");
  level endon("_encstr_B15F18D349D8BAD79658FBD24365A3F5F0D57D77D108C2E73711");

  if(var_1 == "_encstr_AB0703DBB9") {
    var_2 = 10;
    var_3 = level.ac130_speed["_encstr_B4F507E4BD4785E856"] / 360 * var_2;
    var_0 rotateYaw(level.ac130.angles[2] + var_2, var_3, var_3, 0);

    for(;;) {
      var_0 rotateYaw(360, level.ac130_speed["_encstr_B4F507E4BD4785E856"]);
      wait(level.ac130_speed["_encstr_B4F507E4BD4785E856"]);
    }
  } else if(var_1 == "_encstr_BA19049F4B2D") {
    var_4 = 10;
    var_3 = level.ac130_speed["_encstr_B4F507E4BD4785E856"] / 360 * var_4;
    var_0 rotateYaw(level.ac130.angles[2] + var_4, var_3, 0, var_3);
  }
}

ac130_attachgunner(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_0 scripts\cp\utility::_giveweapon("_encstr_A7BC0FA2A8D3626A4E07A8A531D00F3DB9");
  var_0 scripts\cp\utility::_giveweapon("_encstr_88710EC26CC49918FA1A815BB5AFADC1");
  var_0 scripts\cp\utility::_giveweapon("_encstr_88F90EF65F8E7A1AEED5251AE97F9788");
  var_0 scripts\cp\cp_weapons::_switchtoweaponimmediate("_encstr_A7BC0FA2A8D3626A4E07A8A531D00F3DB9");
  waitframe();
  self.camera = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  self.camera setModel("_encstr_8E010B996FB7B6B3C1D1183343");
  self.camera.angles = vectortoangles(level.ac130.origin - self.camera.origin);
  self.camera linkTo(self);

  if(isbot(var_0))
    var_0 cameralinkTo(self.camera, "_encstr_8E010B996FB7B6B3C1D1183343");
  else {
    var_0 playerlinkweaponviewtodelta(self.camera, "_encstr_8E010B996FB7B6B3C1D1183343", 1.0, 100, 100, 25, 90, 0);
    var_0 playerlinkedsetviewznear(0);
    var_0 visionsetkillstreakforplayer("_encstr_AF500C2C1B136660BE8D7BC6F627");
    var_0 setplayerangles(self.camera.angles);
    var_0 setclientomnvar("_encstr_8DE30DAE96D70B1BC49903FA0DD5C8", 1);
    var_0 setclientomnvar("_encstr_9B0814D54B7D581B98660C7D62C06AD66BD785B5B6DE", var_0 getweaponammoclip("_encstr_A7BC0FA2A8D3626A4E07A8A531D00F3DB9"));
    var_0 setclientomnvar("_encstr_8B3313BB5848F60A6782687F1A8FE01BEE51650BCF", var_0 getweaponammoclip("_encstr_88710EC26CC49918FA1A815BB5AFADC1"));
    var_0 setclientomnvar("_encstr_BED9137B93973A5313A28237C2FB05A23F3FC5F508", var_0 getweaponammoclip("_encstr_88F90EF65F8E7A1AEED5251AE97F9788"));
    var_0 setclientomnvar("_encstr_B42D181FA4C122A3EC31C0BB932B52E26F3B600BD68C2B3F4738", gettime() + int(self.timeout * 1000));
    var_0 setclientomnvar("_encstr_8B4F1557D2F5B6D236C637E839AC2CDABE0DB2B0B11D1A", self.maxhealth);
    var_2 = [];

    foreach(var_4 in level.characters) {
      if(level.teambased && var_4.team == self.team) {
        continue;
      }
      if(var_4 == self.owner) {
        continue;
      }
      if(var_2.size >= 20) {
        continue;
      }
      var_2[var_2.size] = var_4;
    }

    self.enemytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("_encstr_85041AA3432B9CDA0BB13BB437A57B73AC73CA6B5E91AC33C25D8DA3", self.owner, var_2, self.owner, 1);
    self.friendlytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("_encstr_8AA71D73E46590B11AA3F5F3E7A288383EFA58290DCCD873A26FDDEB979A4D", self.owner, self.owner, self.owner);
    var_0 thread ac130_updateoverlaycoords(self);
  }
}

ac130_watchchangeweapons(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_B87314472EE797EB9853D0185FB25E4DCAD5C854070A");
  level endon("_encstr_B87314472EE797EB9853D0185FB25E4DCAD5C854070A");
  var_2 = ["_encstr_A7BC0FA2A8D3626A4E07A8A531D00F3DB9", "_encstr_88710EC26CC49918FA1A815BB5AFADC1", "_encstr_88F90EF65F8E7A1AEED5251AE97F9788"];
  var_0 scripts\common\utility::allow_weapon_switch(0);

  if(!isai(var_0)) {
    var_0 notifyonplayercommand("_encstr_A68A14C2D8986660EBE6EE5AA38D0DAFBB562C0E7B73", "_encstr_A6E60A229B175A3B48A543AB");
    var_0 setclientomnvar("_encstr_9B4110D5A5D7B01B269906F5DDCA58387BE6", 3);
  }

  var_3 = 3;

  for(;;) {
    var_0 waittill("_encstr_A68A14C2D8986660EBE6EE5AA38D0DAFBB562C0E7B73");
    var_4 = var_0 getcurrentweapon();
    var_5 = var_4;

    foreach(var_9, var_7 in var_2) {
      if(var_4.basename == var_7) {
        var_8 = var_9 + 1;

        if(var_8 > var_2.size - 1)
          var_8 = 0;

        var_5 = var_2[var_8];
        break;
      }
    }

    var_0 scripts\cp\cp_weapons::_switchtoweaponimmediate(var_5);
    var_3--;

    if(var_3 == 0)
      var_3 = 3;

    var_0 setclientomnvar("_encstr_9B4110D5A5D7B01B269906F5DDCA58387BE6", var_3);
    playfxontagforclients(scripts\engine\utility::getfx("_encstr_810C0FAA9043CF5BA128F310D5EB8B17A5"), var_0, "_encstr_A130084D2FDAD8AA8F62", var_0);
    var_0 thread ac130_playfocalfx();
  }
}

ac130_playfocalfx() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_92D4135FF0CEE03C2F62919E7AEFCFD2326FE9CF66");
  self endon("_encstr_92D4135FF0CEE03C2F62919E7AEFCFD2326FE9CF66");
  setdof_ac130_zoom();
  wait 0.5;
  setdof_ac130();
}

ac130_watchweaponimpact(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 waittill("_encstr_8DE90E4D31C35370B84D709B4B6DEE42", var_2, var_3, var_4, var_5, var_6, var_7);
  var_8 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_8 setModel("_encstr_A5A9131AC3AF376E32A7F88F31E87267B59BD1E24B");
  var_8.angles = vectortoangles(var_7);
  var_8 linkTo(var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, 0), (0, 0, 0));
  var_8 setotherent(self);
  var_9 = "_encstr_AB0703DBB9";
  var_8 setscriptablepartstate(var_0.weapon_name, var_9, 0);

  if(isDefined(self))
    var_0 detonate();
  else
    var_0 delete();

  var_10 = var_8.origin;
  var_11 = getmissileexplscale(var_0.weapon_name);
  var_12 = 0.75;
  var_13 = getmissileexplradius(var_0.weapon_name);
  var_8 thread deleteaftertime(5);
}

getmissileexplscale(var_0) {
  var_1 = 1.0;

  switch (var_0) {
    case "_encstr_A7BC0FA2A8D3626A4E07A8A531D00F3DB9":
      var_1 = 0.75;
      break;
    case "_encstr_88710EC26CC49918FA1A815BB5AFADC1":
      var_1 = 0.5;
      break;
    case "_encstr_88F90EF65F8E7A1AEED5251AE97F9788":
      var_1 = 0.15;
      break;
  }

  return var_1;
}

getmissileexplradius(var_0) {
  var_1 = 1.0;

  switch (var_0) {
    case "_encstr_A7BC0FA2A8D3626A4E07A8A531D00F3DB9":
      var_1 = 2000;
      break;
    case "_encstr_88710EC26CC49918FA1A815BB5AFADC1":
      var_1 = 1300;
      break;
    case "_encstr_88F90EF65F8E7A1AEED5251AE97F9788":
      var_1 = 700;
      break;
  }

  return var_1;
}

setdof_ac130() {
  self.usingcustomdof = 1;
  scripts\cp\utility::_setdof_internal(10, 80, 1000, 1000, 7, 0);
}

setdof_ac130_zoom() {
  self.usingcustomdof = 1;
  scripts\cp\utility::_setdof_internal(10, 80, 1000, 6500, 10, 5);
}

ac130_watchweaponfired(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_B87314472EE797EB9853D0185FB25E4DCAD5C854070A");
  var_0 endon("_encstr_B87314472EE797EB9853D0185FB25E4DCAD5C854070A");
  thread ac130_track105mmmissile(var_0);

  for(;;) {
    var_0 waittill("_encstr_ACA30D383847FB93AAFF7705139D4B", var_2);
    var_3 = var_0 getcurrentweapon();
    var_4 = var_0 getweaponammoclip(var_3);

    switch (var_3.basename) {
      case "_encstr_A7BC0FA2A8D3626A4E07A8A531D00F3DB9":
        earthquake(0.2, 1, self.origin, 1000);
        var_0 setclientomnvar("_encstr_9B0814D54B7D581B98660C7D62C06AD66BD785B5B6DE", var_4);
        break;
      case "_encstr_88710EC26CC49918FA1A815BB5AFADC1":
        earthquake(0.1, 0.5, self.origin, 1000);
        var_0 setclientomnvar("_encstr_8B3313BB5848F60A6782687F1A8FE01BEE51650BCF", var_4);
        break;
      case "_encstr_88F90EF65F8E7A1AEED5251AE97F9788":
        var_0 setclientomnvar("_encstr_BED9137B93973A5313A28237C2FB05A23F3FC5F508", var_4);
        break;
    }

    if(var_4 == 0)
      var_0 thread ac130_weaponreload(var_3);

    var_0 thread ac130_watchweaponimpact(var_2, self);
  }
}

ac130_track105mmmissile(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_B87314472EE797EB9853D0185FB25E4DCAD5C854070A");
  var_0 endon("_encstr_B87314472EE797EB9853D0185FB25E4DCAD5C854070A");

  for(;;) {
    var_0 waittill("_encstr_ACA30D383847FB93AAFF7705139D4B", var_1, var_2);

    if(var_2.basename == "_encstr_A7BC0FA2A8D3626A4E07A8A531D00F3DB9")
      var_1 thread ac130_watch105mmexplosion(self, var_0);
  }
}

ac130_watch105mmexplosion(var_0, var_1) {
  level endon("_encstr_B87314472EE797EB9853D0185FB25E4DCAD5C854070A");
  var_1 endon("_encstr_B87314472EE797EB9853D0185FB25E4DCAD5C854070A");
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_AD75063D571AE108");
  earthquake(0.125, 0.5, var_0.origin, 1000);
  var_1 visionsetkillstreakforplayer("_encstr_882F130BD84CCC60D78DB78DDB9CEBEC1BA5D11B86");
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(0.1);
  var_1 visionsetkillstreakforplayer("_encstr_AF500C2C1B136660BE8D7BC6F627");
}

ac130_weaponreload(var_0) {
  self endon("_encstr_B87314472EE797EB9853D0185FB25E4DCAD5C854070A");
  level endon("_encstr_B87314472EE797EB9853D0185FB25E4DCAD5C854070A");
  var_1 = getac130weaponrootname(var_0);
  self playlocalsound(var_1 + "_encstr_A9C50BFADAC1EB9C56D8F68519");
  ac130_waitforweaponreloadtime(var_0, var_1);
  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog(var_1 + "_encstr_B1DC0A77EDB5C26FF079B7FF");
  var_2 = weaponmaxammo(var_0);
  self setweaponammoclip(var_0, var_2);
  self setclientomnvar("_encstr_8C190437A80E" + var_1 + "_encstr_85F10630C64A4378", var_2);
}

ac130_waitforweaponreloadtime(var_0, var_1) {
  var_2 = level.weaponreloadtime[var_0.basename];
  self setclientomnvar("_encstr_8C190437A80E" + var_1 + "_encstr_B2AA0C21CDC39917838BC36BC8D3", gettime() + int(var_2 * 1000));

  for(;;) {
    wait 0.05;
    var_2 = var_2 - 0.05;

    if(var_2 <= 0) {
      break;
    }
  }
}

getac130weaponrootname(var_0) {
  var_1 = 0;
  var_2 = var_0.basename;
  var_3 = strtok(var_2, "_encstr_BA4C02DF");
  return var_3[var_1] + "_encstr_BA4C02DF" + var_3[var_1 + 1];
}

playsound25mm() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_B87314472EE797EB9853D0185FB25E4DCAD5C854070A");
  self endon("_encstr_AA9C0B1655FF99D1E967E2388A");
  var_0 = self getcurrentweapon();

  for(;;) {
    self waittill("_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19");
    self stoplocalsound("_encstr_8FA021E2E893222AC864EE8FDE1B07FD27B8EA4B70F72D9FE0CFBFAB1878CB479F98E2");
    self playLoopSound("_encstr_8EC318175717BFB8C893FBB923F23D9298E5BFC3334812AFD09B");

    while(self attackButtonPressed() && self getweaponammoclip(var_0))
      waitframe();

    self stoploopsound();
    self playlocalsound("_encstr_8FA021E2E893222AC864EE8FDE1B07FD27B8EA4B70F72D9FE0CFBFAB1878CB479F98E2");
  }
}

thermalvision() {
  self endon("_encstr_B87314472EE797EB9853D0185FB25E4DCAD5C854070A");
  self thermalvisionon();
  self visionsetthermalforplayer(level.ac130.enhanced_vision, 1);
  self.lastvisionsetthermal = level.ac130.enhanced_vision;
  self visionsetthermalforplayer(level.ac130.thermal_vision, 0.62);
  self.lastvisionsetthermal = level.ac130.thermal_vision;
  self setclientdvar("_encstr_838A110DEC4173C1996E1A695BE8D98D8A1609", 1);
}

ac130_playpilotfx(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  var_0.ac130_cloudsfx = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0 getEye());
  var_0.ac130_cloudsfx setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_0.ac130_cloudsfx linkTo(var_0, "_encstr_A130084D2FDAD8AA8F62");
  waitframe();
  playfxontagforclients(scripts\engine\utility::getfx("_encstr_9A5007A9E5275F8ACA"), var_0.ac130_cloudsfx, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", var_0);
}

gun_fired_and_ready_105mm() {
  self endon("_encstr_B87314472EE797EB9853D0185FB25E4DCAD5C854070A");
  level notify("_encstr_87D01A9DD5DCFA662D4E5932FAC2E6C8AF39560B8CF27D266053B56B");
  level endon("_encstr_87D01A9DD5DCFA662D4E5932FAC2E6C8AF39560B8CF27D266053B56B");
  wait 0.5;

  if(randomint(2) == 0)
    thread context_sensative_dialog_play_random_group_sound("_encstr_A30108473FBA97C8D662", "_encstr_935A0C890C535BADD733B44EAC19");

  wait 5.0;
  thread context_sensative_dialog_play_random_group_sound("_encstr_A30108473FBA97C8D662", "_encstr_8CCD0C26186AB65BD74E591623CB");
}

shotfired() {
  self endon("_encstr_B87314472EE797EB9853D0185FB25E4DCAD5C854070A");

  for(;;) {
    self waittill("_encstr_8A21128393F64D2BB13A4B1BB2F55AD60E85C61D", var_0, var_1, var_2);

    if(issubstr(tolower(var_0.basename), "_encstr_A5180466C7CD")) {
      earthquake(0.4, 1.0, var_1, 3500);
      self setclientomnvar("_encstr_AB8F101368E8CF96DA3F5037B9701A3F2D60", 1);
    } else if(issubstr(tolower(var_0.basename), "_encstr_AA07038618"))
      earthquake(0.2, 0.5, var_1, 2000);

    if(scripts\cp\utility::getintproperty("_encstr_A63F1511E671DA5FB99B9BAFFB8249E8C7BF19E9CB8060", 0))
      thread shotfiredphysicssphere(var_1, var_0.basename);

    waitframe();
  }
}

shotfiredphysicssphere(var_0, var_1) {
  wait 0.1;
  physicsexplosionsphere(var_0, level.physicssphereradius[var_1], level.physicssphereradius[var_1] / 2, level.physicssphereforce[var_1]);
}

add_beacon_effect() {
  self endon("_encstr_AD75063D571AE108");
  var_0 = 0.75;
  wait(randomfloat(3.0));

  for(;;) {
    if(level.ac130player)
      playfxontagforclients(level._effect["_encstr_83380768EF1919AF8A"], self, "_encstr_8EEC09159F6238030BFA23", level.ac130player);

    wait(var_0);
  }
}

context_sensative_dialog() {
  thread enemy_killed_thread();
  thread context_sensative_dialog_guy_in_sight();
  thread context_sensative_dialog_guy_crawling();
  thread context_sensative_dialog_guy_pain();
  thread context_sensative_dialog_secondary_explosion_vehicle();
  thread context_sensative_dialog_kill_thread();
  thread context_sensative_dialog_locations();
  thread context_sensative_dialog_filler();
}

context_sensative_dialog_guy_in_sight() {
  self endon("_encstr_B87314472EE797EB9853D0185FB25E4DCAD5C854070A");

  for(;;) {
    if(context_sensative_dialog_guy_in_sight_check())
      thread context_sensative_dialog_play_random_group_sound("_encstr_A107039AA0", "_encstr_B1C4094B73BECD96B3431D");

    wait(randomfloatrange(1, 3));
  }
}

context_sensative_dialog_guy_in_sight_check() {
  var_0 = [];

  foreach(var_2 in level.players) {
    if(!var_2 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }
    if(var_2.team == level.ac130player.team) {
      continue;
    }
    if(var_2.team == "_encstr_AF8C0A1B6A1D6045925B4F7D") {
      continue;
    }
    var_0[var_0.size] = var_2;
  }

  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    if(!isDefined(var_0[var_4])) {
      continue;
    }
    if(!isalive(var_0[var_4])) {
      continue;
    }
    if(scripts\engine\utility::within_fov(level.ac130player getEye(), level.ac130player getplayerangles(), var_0[var_4].origin, level.cosine["_encstr_B84C027E"]))
      return 1;

    wait 0.05;
  }

  return 0;
}

context_sensative_dialog_guy_crawling() {
  self endon("_encstr_B87314472EE797EB9853D0185FB25E4DCAD5C854070A");

  for(;;) {
    level waittill("_encstr_B6790C582DF58D2758BB1B4B73B3", var_0);
    thread context_sensative_dialog_play_random_group_sound("_encstr_A107039AA0", "_encstr_A93A0E0BCF43100A4A04771F263F30A8");
  }
}

context_sensative_dialog_guy_pain() {
  self endon("_encstr_B87314472EE797EB9853D0185FB25E4DCAD5C854070A");

  for(;;) {
    level waittill("_encstr_977F08B02DBE380BD2E6", var_0);
    thread context_sensative_dialog_play_random_group_sound("_encstr_A107039AA0", "_encstr_9A430D98D27BF5A1A75C907F31FFA8");
  }
}

context_sensative_dialog_secondary_explosion_vehicle() {
  self endon("_encstr_B87314472EE797EB9853D0185FB25E4DCAD5C854070A");

  for(;;) {
    level waittill("_encstr_853415D0E331628363E9059DFA5BF5E8817FF83137C9DB", var_0, var_1);
    wait 1;
    thread context_sensative_dialog_play_random_group_sound("_encstr_8E440A950FE01BB76E96BDE6", "_encstr_AC8F0AE74163F85AAA380AD8");
  }
}

enemy_killed_thread() {
  self endon("_encstr_B87314472EE797EB9853D0185FB25E4DCAD5C854070A");

  for(;;) {
    level waittill("_encstr_A2300A73174102F0ACDD6159", var_0);
    thread context_sensative_dialog_kill(var_0, level.ac130player);
  }
}

context_sensative_dialog_kill(var_0, var_1) {
  if(!isDefined(var_1)) {
    return;
  }
  if(!isPlayer(var_1)) {
    return;
  }
  level.enemieskilledintimewindow++;
  level notify("_encstr_85980DA238454FA0F9DF7974F92B2F");
}

context_sensative_dialog_kill_thread() {
  self endon("_encstr_B87314472EE797EB9853D0185FB25E4DCAD5C854070A");
  var_0 = 1;

  for(;;) {
    level waittill("_encstr_85980DA238454FA0F9DF7974F92B2F");
    wait(var_0);
    var_1 = "_encstr_ABD70578F3D02C";
    var_2 = undefined;

    if(level.enemieskilledintimewindow >= 2)
      var_2 = "_encstr_B2A80C2AF3CB991BFF87036808F9";
    else {
      var_2 = "_encstr_BDDC07EBCCB5CA4BED";

      if(randomint(3) != 1) {
        level.enemieskilledintimewindow = 0;
        continue;
      }
    }

    level.enemieskilledintimewindow = 0;
    thread context_sensative_dialog_play_random_group_sound(var_1, var_2, 1);
  }
}

context_sensative_dialog_locations() {
  scripts\engine\utility::array_thread(getEntArray("_encstr_9B5C131E754A4109D84B69A82719E0BF229186978A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"), ::context_sensative_dialog_locations_add_notify_event, "_encstr_AF1904AFE326");
  scripts\engine\utility::array_thread(getEntArray("_encstr_9B29158258806BE7C3218FBC33E0EDBFBCF66B1BE3EEDF", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"), ::context_sensative_dialog_locations_add_notify_event, "_encstr_ADA706A3E4BA1BB6");
  scripts\engine\utility::array_thread(getEntArray("_encstr_B62318717870A5633058DFB53CCF283FDF39CE4303483DE9BBD7", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"), ::context_sensative_dialog_locations_add_notify_event, "_encstr_86BA0988CBC479290FDE04");
  scripts\engine\utility::array_thread(getEntArray("_encstr_81F61463DF701B9F339BE9622D87F39560D70FE941C8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"), ::context_sensative_dialog_locations_add_notify_event, "_encstr_AFF605A3F9E16B");
  scripts\engine\utility::array_thread(getEntArray("_encstr_8180150A40E52BA7221D7F7CBB294B352F29A222884967", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"), ::context_sensative_dialog_locations_add_notify_event, "_encstr_8A7F06F0C07A9183");
  scripts\engine\utility::array_thread(getEntArray("_encstr_960E14A6406808131350677BA24619B020B9E59F7020", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"), ::context_sensative_dialog_locations_add_notify_event, "_encstr_AB1F058B9F8F7A");
  scripts\engine\utility::array_thread(getEntArray("_encstr_AA1A1636F6CDA3ACF047F5195A0BD87BECAFD8D0AB27C6D0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"), ::context_sensative_dialog_locations_add_notify_event, "_encstr_8A6707D81AAB2736D0");
  scripts\engine\utility::array_thread(getEntArray("_encstr_A1EA15D87FAE337333B308ADCC9A59980F276870FB7B08", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"), ::context_sensative_dialog_locations_add_notify_event, "_encstr_A59906B164345873");
  thread context_sensative_dialog_locations_thread();
}

context_sensative_dialog_locations_thread() {
  self endon("_encstr_B87314472EE797EB9853D0185FB25E4DCAD5C854070A");

  for(;;) {
    level waittill("_encstr_931F11AEC5FAF1B968DBF9984F8BF139526D90", var_0);

    if(!isDefined(var_0)) {
      continue;
    }
    if(!scripts\engine\utility::flag("_encstr_A93A1F6AC305183BE903B72B252F48ABA79EDFF5171B332D133F9032923F05A7BA")) {
      continue;
    }
    thread context_sensative_dialog_play_random_group_sound("_encstr_AC6E09881A36337B5F6F30", var_0);
    wait(5 + randomfloat(10));
  }
}

context_sensative_dialog_locations_add_notify_event(var_0) {
  self endon("_encstr_B87314472EE797EB9853D0185FB25E4DCAD5C854070A");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(!isDefined(var_1)) {
      continue;
    }
    if(!isDefined(var_1.team) || var_1.team != "_encstr_8E8405EA382B2A") {
      continue;
    }
    level notify("_encstr_931F11AEC5FAF1B968DBF9984F8BF139526D90", var_0);
    wait 5;
  }
}

context_sensative_dialog_vehiclespawn(var_0) {
  if(var_0.script_team != "_encstr_8E8405EA382B2A") {
    return;
  }
  thread context_sensative_dialog_vehicledeath(var_0);
  var_0 endon("_encstr_AD75063D571AE108");

  while(!scripts\engine\utility::within_fov(level.ac130player getEye(), level.ac130player getplayerangles(), var_0.origin, level.cosine["_encstr_960703127A"]))
    wait 0.5;

  context_sensative_dialog_play_random_group_sound("_encstr_9A50080BA7292FFA0DA2", "_encstr_8A4F099025A3B8715A6B17");
}

context_sensative_dialog_vehicledeath(var_0) {
  var_0 waittill("_encstr_AD75063D571AE108");
  thread context_sensative_dialog_play_random_group_sound("_encstr_9A50080BA7292FFA0DA2", "_encstr_AD75063D571AE108");
}

context_sensative_dialog_filler() {
  self endon("_encstr_B87314472EE797EB9853D0185FB25E4DCAD5C854070A");

  for(;;) {
    if(isDefined(level.radio_in_use) && level.radio_in_use == 1)
      level waittill("_encstr_AC3B119C2CC8A5F6F5E67B1DD7D273D7BA9B2B");

    var_0 = gettime();

    if(var_0 - level.lastradiotransmission >= 3000) {
      level.lastradiotransmission = var_0;
      thread context_sensative_dialog_play_random_group_sound("_encstr_B6A2056BD237D8", "_encstr_B40B07666F8BC31783");
    }

    wait 0.25;
  }
}

context_sensative_dialog_play_random_group_sound(var_0, var_1, var_2) {
  level endon("_encstr_B87314472EE797EB9853D0185FB25E4DCAD5C854070A");

  if(!isDefined(var_2))
    var_2 = 0;

  if(!scripts\engine\utility::flag("_encstr_A93A1F6AC305183BE903B72B252F48ABA79EDFF5171B332D133F9032923F05A7BA")) {
    if(var_2)
      scripts\engine\utility::flag_wait("_encstr_A93A1F6AC305183BE903B72B252F48ABA79EDFF5171B332D133F9032923F05A7BA");
    else
      return;
  }

  var_3 = undefined;
  var_4 = randomint(level.scr_sound[var_0][var_1].size);

  if(level.scr_sound[var_0][var_1][var_4].played == 1) {
    for(var_5 = 0; var_5 < level.scr_sound[var_0][var_1].size; var_5++) {
      var_4++;

      if(var_4 >= level.scr_sound[var_0][var_1].size)
        var_4 = 0;

      if(level.scr_sound[var_0][var_1][var_4].played == 1) {
        continue;
      }
      var_3 = var_4;
      break;
    }

    if(!isDefined(var_3)) {
      for(var_5 = 0; var_5 < level.scr_sound[var_0][var_1].size; var_5++)
        level.scr_sound[var_0][var_1][var_5].played = 0;

      var_3 = randomint(level.scr_sound[var_0][var_1].size);
    }
  } else
    var_3 = var_4;

  if(context_sensative_dialog_timedout(var_0, var_1, var_3)) {
    return;
  }
  level.scr_sound[var_0][var_1][var_3].played = 1;
  var_6 = randomint(level.scr_sound[var_0][var_1][var_3].size);
  playsoundoverradio(level.scr_sound[var_0][var_1][var_3].sounds[var_6], var_2);
}

context_sensative_dialog_timedout(var_0, var_1, var_2) {
  if(!isDefined(level.context_sensative_dialog_timeouts))
    return 0;

  if(!isDefined(level.context_sensative_dialog_timeouts[var_0]))
    return 0;

  if(!isDefined(level.context_sensative_dialog_timeouts[var_0][var_1]))
    return 0;

  if(isDefined(level.context_sensative_dialog_timeouts[var_0][var_1].groups) && isDefined(level.context_sensative_dialog_timeouts[var_0][var_1].groups[scripts\engine\utility::string(var_2)])) {
    var_3 = gettime();

    if(var_3 - level.context_sensative_dialog_timeouts[var_0][var_1].groups[scripts\engine\utility::string(var_2)].v["_encstr_B8680B310BC763F99C010B5D22"] < level.context_sensative_dialog_timeouts[var_0][var_1].groups[scripts\engine\utility::string(var_2)].v["_encstr_8B44108BE079470D7009AC851D0813BF90F8"])
      return 1;

    level.context_sensative_dialog_timeouts[var_0][var_1].groups[scripts\engine\utility::string(var_2)].v["_encstr_B8680B310BC763F99C010B5D22"] = var_3;
  } else if(isDefined(level.context_sensative_dialog_timeouts[var_0][var_1].v)) {
    var_3 = gettime();

    if(var_3 - level.context_sensative_dialog_timeouts[var_0][var_1].v["_encstr_B8680B310BC763F99C010B5D22"] < level.context_sensative_dialog_timeouts[var_0][var_1].v["_encstr_8B44108BE079470D7009AC851D0813BF90F8"])
      return 1;

    level.context_sensative_dialog_timeouts[var_0][var_1].v["_encstr_B8680B310BC763F99C010B5D22"] = var_3;
  }

  return 0;
}

playsoundoverradio(var_0, var_1, var_2) {
  if(!isDefined(level.radio_in_use))
    level.radio_in_use = 0;

  if(!isDefined(var_1))
    var_1 = 0;

  if(!isDefined(var_2))
    var_2 = 0;

  var_2 = var_2 * 1000;
  var_3 = gettime();
  var_4 = 0;
  var_4 = playaliasoverradio(var_0);

  if(var_4) {
    return;
  }
  if(!var_1) {
    return;
  }
  level.radioforcedtransmissionqueue[level.radioforcedtransmissionqueue.size] = var_0;

  while(!var_4) {
    if(level.radio_in_use)
      level waittill("_encstr_AC3B119C2CC8A5F6F5E67B1DD7D273D7BA9B2B");

    if(var_2 > 0 && gettime() - var_3 > var_2) {
      break;
    }

    if(!isDefined(level.ac130player)) {
      break;
    }

    var_4 = playaliasoverradio(level.radioforcedtransmissionqueue[0]);

    if(!level.radio_in_use && isDefined(level.ac130player) && !var_4) {}
  }

  level.radioforcedtransmissionqueue = scripts\engine\utility::array_remove_index(level.radioforcedtransmissionqueue, 0);
}

playaliasoverradio(var_0) {
  if(level.radio_in_use)
    return 0;

  if(!isDefined(level.ac130player))
    return 0;

  level.radio_in_use = 1;
  level.ac130player playlocalsound(var_0);
  wait 4.0;
  level.radio_in_use = 0;
  level.lastradiotransmission = gettime();
  level notify("_encstr_AC3B119C2CC8A5F6F5E67B1DD7D273D7BA9B2B");
  return 1;
}

handleincomingmissiles() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level.ac130.planemodel thread flares_monitor(1);
}

flares_monitor(var_0) {
  self.flaresreservecount = var_0;
  self.flareslive = [];
  thread ks_laserguidedmissile_handleincoming();
  thread ks_airsuperiority_handleincoming();
}

playflarefx(var_0) {
  for(var_1 = 0; var_1 < var_0; var_1++) {
    thread ac130_playflares();
    wait(randomfloatrange(0.1, 0.25));
  }
}

deployflares(var_0) {
  self playSound("_encstr_B85915375E97E77B11AFDA99C33C69DD7AC93E4572EB21");

  if(!isDefined(var_0)) {
    var_1 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", level.ac130.planemodel.origin);
    var_1.angles = level.ac130.planemodel.angles;
    var_1 movegravity((0, 0, 0), 5.0);
    thread playflarefx(10);
    self.flareslive[self.flareslive.size] = var_1;
    var_1 thread deleteaftertime(5.0);
    return var_1;
  } else
    thread playflarefx(5);
}

flares_getnumleft(var_0) {
  return var_0.flaresreservecount;
}

flares_areavailable(var_0) {
  flares_cleanflareslivearray(var_0);
  return var_0.flaresreservecount > 0 || var_0.flareslive.size > 0;
}

flares_getflarereserve(var_0) {
  var_0.flaresreservecount--;
  var_1 = var_0 deployflares();
  return var_1;
}

flares_cleanflareslivearray(var_0) {
  var_0.flareslive = scripts\engine\utility::array_removeundefined(var_0.flareslive);
}

flares_getflarelive(var_0) {
  flares_cleanflareslivearray(var_0);
  var_1 = undefined;

  if(var_0.flareslive.size > 0)
    var_1 = var_0.flareslive[var_0.flareslive.size - 1];

  return var_1;
}

ks_laserguidedmissile_handleincoming() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_A697107822C3DB70BD10B19B3AE91090A35A");

  while(flares_areavailable(self)) {
    level waittill("_encstr_BA531D9D376FDAE27D30073B983185420756A415ADD7B131A0982707802867", var_0, var_1, var_2);

    if(!isDefined(var_2) || var_2 != self) {
      continue;
    }
    level.ac130player thread ks_watch_death_stop_sound(self, "_encstr_977B11658A62420AACBFF928F8799F79070A48");

    foreach(var_4 in var_1) {
      if(isvalidmissile(var_4))
        level thread ks_laserguidedmissile_monitorproximity(var_4, var_0, var_0.team, var_2);
    }
  }
}

ks_laserguidedmissile_monitorproximity(var_0, var_1, var_2, var_3) {
  var_3 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_A968165BB4376EB4B1ACEB8E58939D564768D0859BCE5623");

  while(flares_areavailable(var_3)) {
    if(!isDefined(var_3) || !isvalidmissile(var_0)) {
      break;
    }

    var_4 = var_3 getpointinbounds(0, 0, 0);

    if(distancesquared(var_0.origin, var_4) < 4000000) {
      var_5 = flares_getflarelive(var_3);

      if(!isDefined(var_5))
        var_5 = flares_getflarereserve(var_3);

      var_0 missile_settargetEnt(var_5);
      var_0 notify("_encstr_922018B6A5DCCD5AD8ACF5C1B04B4E2B46BA2D1DA1916385392B");
      level.ac130player stoplocalsound("_encstr_977B11658A62420AACBFF928F8799F79070A48");
      break;
    }

    waitframe();
  }
}

ks_airsuperiority_handleincoming() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_A697107822C3DB70BD10B19B3AE91090A35A");

  while(flares_areavailable(self)) {
    self waittill("_encstr_84521DB9D773E470143FE19EE6F1692B4A3717034F1ABCD955140B13CCDCE0", var_0);

    if(!isDefined(var_0)) {
      continue;
    }
    level.ac130player thread ks_watch_death_stop_sound(self, "_encstr_977B11658A62420AACBFF928F8799F79070A48");

    foreach(var_2 in var_0) {
      if(isvalidmissile(var_2))
        thread ks_airsuperiority_monitorproximity(var_2);
    }
  }
}

ks_airsuperiority_monitorproximity(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_AD75063D571AE108");

  for(;;) {
    if(!isDefined(self) || !isvalidmissile(var_0)) {
      break;
    }

    var_1 = self getpointinbounds(0, 0, 0);

    if(distancesquared(var_0.origin, var_1) < 4000000) {
      var_2 = flares_getflarelive(self);

      if(!isDefined(var_2) && self.flaresreservecount > 0)
        var_2 = flares_getflarereserve(self);

      if(isDefined(var_2)) {
        var_0 missile_settargetEnt(var_2);
        var_0 notify("_encstr_922018B6A5DCCD5AD8ACF5C1B04B4E2B46BA2D1DA1916385392B");
        level.ac130player stoplocalsound("_encstr_977B11658A62420AACBFF928F8799F79070A48");
        break;
      }
    }

    waitframe();
  }
}

ks_watch_death_stop_sound(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 waittill("_encstr_AD75063D571AE108");
  self stoplocalsound(var_1);
}

deleteaftertime(var_0) {
  wait(var_0);
  self delete();
}

ac130_crash(var_0, var_1) {
  self notify("_encstr_86BD0980BBC647A80FDE04");
  self.crashed = 1;
  ac130_returnplayer(var_1, 0);
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  ac130_removeplane();
}

ac130_removeplane() {
  if(isDefined(self.camera))
    self.camera delete();

  level.ac130_gunship = undefined;
  self delete();
}

ac130_playflares() {
  var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  var_0 setModel("_encstr_9184100BCDB3B236BE99D8B0C9ACBEC9B49D");
  var_0.origin = self gettagorigin("_encstr_83B011E336178944BA076F41E7C299B0BA8F8B");
  var_0.angles = self gettagangles("_encstr_83B011E336178944BA076F41E7C299B0BA8F8B");
  var_0.angles = (var_0.angles[0], var_0.angles[1] + 180, var_0.angles[2] + -90);
  var_1 = level._effect["_encstr_918B15859BCEB236D79963C2392BAF7656BDE84E0BA563"];
  var_0 scriptmodelplayanim("_encstr_86EC14276707AFA869A11DA7D9083F3271FBE38FEFEF" + (randomint(3) + 1));
  wait 0.1;
  playFXOnTag(var_1, var_0, "_encstr_953E0F998D859356BE6359661DBE3ADEE0");
  playFXOnTag(var_1, var_0, "_encstr_8ED7103C7B2193C8374AD8DA7B636788152F");
  wait 0.05;
  playFXOnTag(var_1, var_0, "_encstr_A23D0F446D6295C137D370609B1F79F75B");
  playFXOnTag(var_1, var_0, "_encstr_99D610C6BDDF409766F258DFBA8BE863D8D8");
  wait 3.0;
  stopFXOnTag(var_1, var_0, "_encstr_953E0F998D859356BE6359661DBE3ADEE0");
  stopFXOnTag(var_1, var_0, "_encstr_8ED7103C7B2193C8374AD8DA7B636788152F");
  stopFXOnTag(var_1, var_0, "_encstr_A23D0F446D6295C137D370609B1F79F75B");
  stopFXOnTag(var_1, var_0, "_encstr_99D610C6BDDF409766F258DFBA8BE863D8D8");
  var_0 delete();
}

objectivewmdthink(var_0) {
  var_1 = 0;

  while(!var_1) {
    var_1 = istargetinreticle(level.objective_nuke, 70, 50);
    wait 0.5;
  }
}

istargetinreticle(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = [var_0.origin];

  if(isPlayer(var_0))
    var_4 = [var_0.origin, var_0 gettagorigin("_encstr_8FE10B52092BB64F28E6B7BFFD"), var_0 gettagorigin("_encstr_A130084D2FDAD8AA8F62")];

  foreach(var_6 in var_4) {
    if(self worldpointinreticle_circle(var_6, var_1, var_2)) {
      var_3 = 1;
      break;
    }
  }

  return var_3;
}