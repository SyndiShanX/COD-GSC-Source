/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\dd.gsc
***********************************************/

main() {
  if(getDvar("_encstr_9570084B1793A090CDFF") == "_encstr_8D510E52E3A7C6985EB7B9BE2F35C690") {
    return;
  }
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  var_0[0] = scripts\mp\utility\game::getgametype();
  var_0[1] = "_encstr_844E0C99C3A166200DFE2298E5ED";
  var_0[2] = "_encstr_A65908C41BED1BD62B4E";
  scripts\mp\gameobjects::main(var_0);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 1, 0, 9);
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 180);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 3);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 2);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::setovertimelimitdvar(180);
  }

  updategametypedvars();
  level.objectivebased = 1;
  level.teambased = 1;
  level.onprecachegametype = ::onprecachegametype;
  level.onstartgametype = ::onstartgametype;
  level.getspawnpoint = ::getspawnpoint;
  level.modeonspawnplayer = ::onspawnplayer;
  level.ondeadevent = ::ondeadevent;
  level.ontimelimit = ::ontimelimit;
  level.onnormaldeath = ::onnormaldeath;
  level.gamemodemaydropweapon = scripts\mp\utility\game::isplayeroutsideofanybombsite;
  level.resetuiomnvargamemode = _encstr_A9042687EF43D3E804AA982892B7981F6A5F311B3B5AA64A27C638663EAFB0C6B38F8DBB2AC26EE0::resetuiomnvargamemode;
  level.dd = 1;
  level.bombsplanted = 0;
  level.ddbombmodel = [];
  level.aplanted = 0;
  level.bplanted = 0;
  _encstr_A9042687EF43D3E804AA982892B7981F6A5F311B3B5AA64A27C638663EAFB0C6B38F8DBB2AC26EE0::setbombtimeromnvars();
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_B49E0E7C961A034BB97B985133FD205F";

  if(getdvarint("_encstr_B2020AE1F36BF74429D93F01"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_8A19042AB017" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];
  else if(getdvarint("_encstr_82570B397A4D3192935192A562"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_979708CC69F02253FF26" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];
  else if(getdvarint("_encstr_96050CDCD839EB46B4560D58938C"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_B21804C8D0D7" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];
  else if(getdvarint("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_95B909F7CB45A81F58EF63"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] + "_encstr_824305B93705A7";

  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B2C30DC06FBD8177D266831BFFFB5B"] = "_encstr_B2C30DC06FBD8177D266831BFFFB5B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B6260B26DB5B98F51D16DAAC73"] = "_encstr_B6260B26DB5B98F51D16DAAC73";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8F850A13DBDA31AF8DED6E1D"] = "_encstr_957D0F22AF0F26E910DDF7B8E7A23B2DE0";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_ACA10DAE80E31A1FC960CB8FF8C11C"] = "_encstr_ACA10DAE80E31A1FC960CB8FF8C11C";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AB3D0DE25FE81EF7B7188A42230553"] = "_encstr_AB3D0DE25FE81EF7B7188A42230553";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BA920D59E6CA6B2FAF4CDBD631FAB0"] = "_encstr_96D50DB638514326450683D863A990";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_95920D7910C5AB2FB9D6A72D9ABFED"] = "_encstr_88D50D4CF6B626BE59CDB2AD2FAFC4";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_93E61365C8514FA84FF8120AC077A727692DFB1D55"] = "_encstr_8E061206578F71FF1FAA7830F377B34947D31D8D";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_84B513CA73CADABC7D98BDDAC4AF0E63B0B9D156C8"] = "_encstr_BDAF1226DED613FA959BAC6BF20E8D16DC472B91";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A1DC0E3527D2B6C75F8D09559BBCF6F8"] = "_encstr_A1DC0E3527D2B6C75F8D09559BBCF6F8";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_882910B9EF9318381B78FF65795720BA99F7"] = "_encstr_882910B9EF9318381B78FF65795720BA99F7";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_972910823F887E97D778EAE283A39BF7C18D"] = "_encstr_972910823F887E97D778EAE283A39BF7C18D";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8BEF12016AC8A909A8A7AA412D37E0FB08B6E3E8"] = "_encstr_AABF142872CC9331B30154C5DF1B3947B39BB010BAE7";

  if(!isDefined(game["_encstr_8DC30DAA0285FD69FAE113371B1934"])) {
    var_1 = "_encstr_87D01189BDDE9B47EB8C59B67BC247E8B0B1B6";
    var_2 = "_encstr_BE1E114A8010581B09317D1817549F9B25B55B";
  } else if(game["_encstr_8DC30DAA0285FD69FAE113371B1934"] == 2) {
    var_1 = "_encstr_AFAB0E3640D0DBE33051073F5FD89A14";
    var_2 = "_encstr_AFAB0E3640D0DBE33051073F5FD89A14";
  } else {
    var_1 = "_encstr_99A21789B7DEB9E8F519B2ADB70BD1D1B08DADBECD437BC91D";
    var_2 = "_encstr_AD75173ED5FAEF8B5F6BD8805FBC610DE23DA528AAE28F735C";
  }

  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_95240C659372588E43623137DE6C"] = var_1;
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_93420C4255FBEA5D408FD1FD2A62"] = var_2;
  return isDefined(game["_encstr_A16D07532531CB4BF7"]) && game["_encstr_A16D07532531CB4BF7"] == "_encstr_8B6D0940CC35339149DA08";
  setomnvar("_encstr_950418EAD2F5C47BAD13AFD14BDAB2E4BEACCD231D2DD6B2D70B", 0);
  setomnvar("_encstr_BA0418D5D2FA98BDB698BE3A4BD6B227F556E6231D5ADA56FAC4", 0);
  setomnvar("_encstr_B47A12BBF4378A8F5573A12B03F138F30588CED7", 0);
  setomnvar("_encstr_B67A125D2DF589F65B31D78363B0DCE8AC8CBE4C", 0);
  setomnvar("_encstr_9131145D2DFA31DBD698BED2B9E82B4E581B8EA5B9EC", 0);
  level.nosuspensemusic = 1;
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("_encstr_BA0111CDC693D79132D7C4B76B263A96D65627", getmatchrulesdata("_encstr_ACED09DB8FF96A0C48B36E", "_encstr_912A0A13AF7D41A192A545D6"));
  setdynamicdvar("_encstr_8DB01137B127EB8C91EB0E360B371D1D2DDA95", getmatchrulesdata("_encstr_ACED09DB8FF96A0C48B36E", "_encstr_85980AF3784743E3A1DB7D7D"));
  setdynamicdvar("_encstr_9765120BBFE8A913B566D2CA6915779F70339D65", getmatchrulesdata("_encstr_ACED09DB8FF96A0C48B36E", "_encstr_87B30B90E22F53D3579C7B6185"));
  setdynamicdvar("_encstr_9B9613B30750115BFD3EEB726045BB1399F15926B1", getmatchrulesdata("_encstr_ACED09DB8FF96A0C48B36E", "_encstr_866A0CDCD2D8569B8E058D0BCD3A"));
  setdynamicdvar("_encstr_9A7E117B570256FDECE79BE814734F233F85D7", getmatchrulesdata("_encstr_9BAB0891566B1185E8B0", "_encstr_82610A2B1E3A4E16152DDACA"));
  setdynamicdvar("_encstr_9192154B1146FF9FA82FF7D66320A36F61493092B893EB", getmatchrulesdata("_encstr_9BAB0891566B1185E8B0", "_encstr_85ED0E179550E2533320C25888191FDB"));
  setdynamicdvar("_encstr_B16E10A211E827325DD7C3DF89747B5948B9", 0);
  scripts\mp\utility\game::registerhalftimedvar("_encstr_B60703EACA", 0);
  setdynamicdvar("_encstr_8CBD0F5E3EC35F51BCAF485007DD4851DA", 0);
}

onprecachegametype() {
  game["_encstr_BE9B13E59FF216D154AAD04B523D40C04B3773752B"] = "_encstr_A76F166B1CF5BBB039F57B89A6568DD196D995F5D8F6E61D";
  game["_encstr_BA2A15987B5B13EB39AC6CB7B3B29C9523EB6EBDEA3719"] = "_encstr_87ED1717204EDFBA5518655EFA13D284D0B88F5798610B2255";
}

onstartgametype() {
  if(game["_encstr_8DC30DAA0285FD69FAE113371B1934"] == 2) {
    game["_encstr_A16D07532531CB4BF7"] = "_encstr_8B6D0940CC35339149DA08";
    setDvar("_encstr_8ADD0CABA5AFEDECB2271D2DB6AC", 1);
  }

  if(scripts\mp\utility\game::inovertime()) {
    setomnvar("_encstr_BDDF21D55AFA93DEAEB919F5D04B9BE8FABDCEB2C9E42DC8CAFAB0A3D10BB15BAC39B9", 1);
    setomnvar("_encstr_BD3721E0DA99B5B88F0E55C010274071714270F8C36ADB91A7176DC5F63F0829A73BA0", 1);
  }

  if(!isDefined(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]))
    game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"] = 0;

  if(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]) {
    var_0 = game["_encstr_991C0AB9ED5B57161FE89B83"];
    var_1 = game["_encstr_B6A70A23CA6659DC91CAE4DC"];
    game["_encstr_991C0AB9ED5B57161FE89B83"] = var_1;
    game["_encstr_B6A70A23CA6659DC91CAE4DC"] = var_0;
  }

  level.usestartspawns = 1;
  setclientnamemode("_encstr_8B070EAD85CDEA0B8D7D1B4316E63B2B");

  if(scripts\mp\utility\game::inovertime())
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_93420C4255FBEA5D408FD1FD2A62"] = "_encstr_ADEB0C27227298E09388E4239D07";

  level._effect["_encstr_9A8C0F89BDDA26D7B20FC163B7E6B4DB73"] = loadfx("_encstr_A7CE3453FC2126B13322974778E0770AF3851D8D55B37ED679089F3738013A525130260549E573010398A7932B3BF48B07BBBDFBA439");
  level._effect["_encstr_9BF6123B2B1A5A8DC62B7DB20F0736BD6E96F6B9"] = loadfx("_encstr_99452E086F5158BE68AB4DBF6060FAEC0617407163328FFB6AD87A1FF05101E3028A6A5F5B7FB7C8DF603563D284C883");
  level._effect["_encstr_92901389CBAB79F5D84E615738AB8B589067B4EA88"] = loadfx("_encstr_B6F42B9E9FCBAE0CD8C23829EBC1635B8797C0FF2802D7C77BD340067187115D803184BE9535896889EA9B0AC3");
  scripts\mp\utility\game::setobjectivetext(game["_encstr_991C0AB9ED5B57161FE89B83"], &"_encstr_AFF517A8C6B8EFD379FC41CFCFE86DD5CE8BB73491B779A569");
  scripts\mp\utility\game::setobjectivetext(game["_encstr_B6A70A23CA6659DC91CAE4DC"], &"_encstr_8E57173168DCDB3D0B294CCD2B3E051171F0E9E1B06581B57B");

  if(level.splitscreen) {
    scripts\mp\utility\game::setobjectivescoretext(game["_encstr_991C0AB9ED5B57161FE89B83"], &"_encstr_AFF517A8C6B8EFD379FC41CFCFE86DD5CE8BB73491B779A569");
    scripts\mp\utility\game::setobjectivescoretext(game["_encstr_B6A70A23CA6659DC91CAE4DC"], &"_encstr_8E57173168DCDB3D0B294CCD2B3E051171F0E9E1B06581B57B");
  } else {
    scripts\mp\utility\game::setobjectivescoretext(game["_encstr_991C0AB9ED5B57161FE89B83"], &"_encstr_813A1DE41D20A5A601A9FD615FB799B92EDDFB39AE9DF155DB89190BB9D9D3");
    scripts\mp\utility\game::setobjectivescoretext(game["_encstr_B6A70A23CA6659DC91CAE4DC"], &"_encstr_A27C1D15E65D98935F91BBFF69184C509F0D6FDFFDEDC0DDE73997FF716F05");
  }

  if(scripts\mp\utility\game::inovertime()) {
    scripts\mp\utility\game::setobjectivehinttext(game["_encstr_991C0AB9ED5B57161FE89B83"], &"_encstr_81611C35ADB1A5E8FD4393D71F38E0DC7194FB0F079961C05D57F39F3DAD");
    scripts\mp\utility\game::setobjectivehinttext(game["_encstr_B6A70A23CA6659DC91CAE4DC"], &"_encstr_81611C35ADB1A5E8FD4393D71F38E0DC7194FB0F079961C05D57F39F3DAD");
  } else {
    scripts\mp\utility\game::setobjectivehinttext(game["_encstr_991C0AB9ED5B57161FE89B83"], &"_encstr_915D1C69308493757361049513F6DDE9B9682939B86E474DB34F039B1623");
    scripts\mp\utility\game::setobjectivehinttext(game["_encstr_B6A70A23CA6659DC91CAE4DC"], &"_encstr_8CE21CFD65796D10358B4B1FA760A8A4294DE7373DF134086E8F3B2775E5");
  }

  thread waittoprocess();
  setupobjectiveicons();
  thread bombs();
}

initspawns() {
  scripts\mp\spawnlogic::setactivespawnlogic("_encstr_8B1608CC43B8D647A113", "_encstr_829A0D0F1AF8FB5ED127855073F940");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addstartspawnpoints("_encstr_B22F1B4823F1E1A14F4B07F727E38EB363CB90B00A97051EC75487761C");
  scripts\mp\spawnlogic::addstartspawnpoints("_encstr_A7E41BE8E0092BB220FA3B2BDCA0915C459B75D08598AEB1A360B603A3");
  scripts\mp\spawnlogic::addspawnpoints(game["_encstr_991C0AB9ED5B57161FE89B83"], "_encstr_B22F1B4823F1E1A14F4B07F727E38EB363CB90B00A97051EC75487761C");
  scripts\mp\spawnlogic::addspawnpoints(game["_encstr_B6A70A23CA6659DC91CAE4DC"], "_encstr_A7E41BE8E0092BB220FA3B2BDCA0915C459B75D08598AEB1A360B603A3");
  var_0 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_B22F1B4823F1E1A14F4B07F727E38EB363CB90B00A97051EC75487761C");
  var_1 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_A7E41BE8E0092BB220FA3B2BDCA0915C459B75D08598AEB1A360B603A3");
  scripts\mp\spawnlogic::registerspawnset("_encstr_8203101FF33885AB060225CD31A68A4B6AD7", var_0);
  scripts\mp\spawnlogic::registerspawnset("_encstr_9AE3109755F34D5879256960F390C8FFD207", var_1);
  scripts\mp\spawnlogic::addspawnpoints(game["_encstr_B6A70A23CA6659DC91CAE4DC"], "_encstr_84E71578D34F81C1F122CF5F3B3A6F49DD33B0F8EB0D1B");
  scripts\mp\spawnlogic::addspawnpoints(game["_encstr_B6A70A23CA6659DC91CAE4DC"], "_encstr_A94E17B6E0AF1919EB9B0E58EEE6FA19CACC953719CAC9F52C", 1);
  scripts\mp\spawnlogic::addspawnpoints(game["_encstr_B6A70A23CA6659DC91CAE4DC"], "_encstr_AF4E17AD83F58CC8BECD831677E6AF46AC992B9B192B27EB89", 1);
  scripts\mp\spawnlogic::addspawnpoints(game["_encstr_991C0AB9ED5B57161FE89B83"], "_encstr_A234156B734185989F1AC3F90386094F4BCBEBFFE70A56");
  scripts\mp\spawnlogic::addspawnpoints(game["_encstr_991C0AB9ED5B57161FE89B83"], "_encstr_87BE17ED61799F1B20FB9BB24380BF967801996BCF2BA22FD7", 1);
  scripts\mp\spawnlogic::addspawnpoints(game["_encstr_991C0AB9ED5B57161FE89B83"], "_encstr_81BE17D11817E1B9A14B8380E305179913A46F5E6B876B87D6", 1);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);

  if(istrue(level.binoculars_clearuidata)) {
    scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD");
    scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD");
    scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", 1, 1);
    scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", 1, 1);
    var_2 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD");
    var_3 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318");
    scripts\mp\spawnlogic::registerspawnset("_encstr_820E07FAE8780B3A4C", var_2);
    scripts\mp\spawnlogic::registerspawnset("_encstr_AD0C095DF195E8B6074A18", var_3);
    return;
  }

  level.spawn_defenders = scripts\mp\spawnlogic::getspawnpointarray("_encstr_84E71578D34F81C1F122CF5F3B3A6F49DD33B0F8EB0D1B");
  scripts\mp\spawnlogic::registerspawnset("_encstr_8E600D6BA06735ED9382C349F22243", level.spawn_defenders);
  level.spawn_defenders_a = scripts\mp\spawnlogic::getspawnpointarray("_encstr_A94E17B6E0AF1919EB9B0E58EEE6FA19CACC953719CAC9F52C");
  level.spawn_defenders_a = scripts\engine\utility::array_combine(level.spawn_defenders, level.spawn_defenders_a);
  scripts\mp\spawnlogic::registerspawnset("_encstr_8FD20F6FC829BCC0411FDEE12003236871", level.spawn_defenders_a);
  level.spawn_defenders_b = scripts\mp\spawnlogic::getspawnpointarray("_encstr_AF4E17AD83F58CC8BECD831677E6AF46AC992B9B192B27EB89");
  level.spawn_defenders_b = scripts\engine\utility::array_combine(level.spawn_defenders, level.spawn_defenders_b);
  scripts\mp\spawnlogic::registerspawnset("_encstr_91D20FD8BB89EAE70E27C8B7AADDF76722", level.spawn_defenders_b);
  level.spawn_defenders_fallback = scripts\engine\utility::array_combine(level.spawn_defenders, level.spawn_defenders_a, level.spawn_defenders_b);
  scripts\mp\spawnlogic::registerspawnset("_encstr_A915168B38F64472E59DAD27F5B56B37B9882313A0E9BB5A", level.spawn_defenders_fallback);
  level.spawn_attackers = scripts\mp\spawnlogic::getspawnpointarray("_encstr_A234156B734185989F1AC3F90386094F4BCBEBFFE70A56");
  scripts\mp\spawnlogic::registerspawnset("_encstr_97290D842919BE3BD5D9CAB2A12EEF", level.spawn_attackers);
  level.spawn_attackers_a = scripts\mp\spawnlogic::getspawnpointarray("_encstr_87BE17ED61799F1B20FB9BB24380BF967801996BCF2BA22FD7");
  level.spawn_attackers_a = scripts\engine\utility::array_combine(level.spawn_attackers, level.spawn_attackers_a);
  scripts\mp\spawnlogic::registerspawnset("_encstr_9AFD0F8CC8AF583A8EC21BB6CAE4DC7D58", level.spawn_attackers_a);
  level.spawn_attackers_b = scripts\mp\spawnlogic::getspawnpointarray("_encstr_81BE17D11817E1B9A14B8380E305179913A46F5E6B876B87D6");
  level.spawn_attackers_b = scripts\engine\utility::array_combine(level.spawn_attackers, level.spawn_attackers_b);
  scripts\mp\spawnlogic::registerspawnset("_encstr_AFFD0FA784A119D1F351178447A020B1B2", level.spawn_attackers_b);
  level.spawn_attackers_fallback = scripts\engine\utility::array_combine(level.spawn_attackers, level.spawn_attackers_a, level.spawn_attackers_b);
  scripts\mp\spawnlogic::registerspawnset("_encstr_A6BD16C599E870B3F3F21FDC01DBEBE95B4998DDE5F001EF", level.spawn_attackers_fallback);
  level.spawn_defenders_start = scripts\mp\spawnlogic::getspawnpointarray("_encstr_A7E41BE8E0092BB220FA3B2BDCA0915C459B75D08598AEB1A360B603A3");
  level.spawn_attackers_start = scripts\mp\spawnlogic::getspawnpointarray("_encstr_B22F1B4823F1E1A14F4B07F727E38EB363CB90B00A97051EC75487761C");
}

getspawnpointdist(var_0, var_1) {
  var_2 = getpathdist(var_0.origin, var_1, 16000);

  if(var_2 < 0)
    var_2 = distance(var_0.origin, var_1);

  return var_2;
}

waittoprocess() {
  level endon("_encstr_842909CE58B659AF2B3791");

  for(;;) {
    if(level.ingraceperiod == 0) {
      break;
    }

    waitframe();
  }

  level.usestartspawns = 0;
}

getspawnpoint() {
  var_0 = self.pers["_encstr_8AEF05472BC2D6"];

  if(istrue(level.binoculars_clearuidata)) {
    if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
      if(var_0 == game["_encstr_991C0AB9ED5B57161FE89B83"]) {
        scripts\mp\spawnlogic::activatespawnset("_encstr_8203101FF33885AB060225CD31A68A4B6AD7", 1);
        var_1 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, undefined, "_encstr_8203101FF33885AB060225CD31A68A4B6AD7");
      } else {
        scripts\mp\spawnlogic::activatespawnset("_encstr_9AE3109755F34D5879256960F390C8FFD207", 1);
        var_1 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, undefined, "_encstr_9AE3109755F34D5879256960F390C8FFD207");
      }
    } else {
      scripts\mp\spawnlogic::activatespawnset("_encstr_820E07FAE8780B3A4C", 1);
      var_1 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, undefined, "_encstr_AD0C095DF195E8B6074A18");
    }
  } else if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    if(var_0 == game["_encstr_991C0AB9ED5B57161FE89B83"]) {
      scripts\mp\spawnlogic::activatespawnset("_encstr_8203101FF33885AB060225CD31A68A4B6AD7", 1);
      var_1 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, undefined, "_encstr_8203101FF33885AB060225CD31A68A4B6AD7");
    } else {
      scripts\mp\spawnlogic::activatespawnset("_encstr_9AE3109755F34D5879256960F390C8FFD207", 1);
      var_1 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, undefined, "_encstr_9AE3109755F34D5879256960F390C8FFD207");
    }
  } else {
    var_2 = undefined;
    var_3 = undefined;

    if(var_0 == game["_encstr_991C0AB9ED5B57161FE89B83"]) {
      if(scripts\mp\utility\game::inovertime())
        var_2 = "_encstr_97290D842919BE3BD5D9CAB2A12EEF";
      else if(!level.aplanted && !level.bplanted)
        var_2 = "_encstr_97290D842919BE3BD5D9CAB2A12EEF";
      else if(level.aplanted && !level.bplanted)
        var_2 = "_encstr_9AFD0F8CC8AF583A8EC21BB6CAE4DC7D58";
      else if(level.bplanted && !level.aplanted)
        var_2 = "_encstr_AFFD0FA784A119D1F351178447A020B1B2";
      else
        var_2 = "_encstr_97290D842919BE3BD5D9CAB2A12EEF";

      var_3 = "_encstr_A6BD16C599E870B3F3F21FDC01DBEBE95B4998DDE5F001EF";
    } else {
      if(scripts\mp\utility\game::inovertime())
        var_2 = "_encstr_8E600D6BA06735ED9382C349F22243";
      else if(!level.aplanted && !level.bplanted)
        var_2 = "_encstr_8E600D6BA06735ED9382C349F22243";
      else if(level.aplanted && !level.bplanted)
        var_2 = "_encstr_8FD20F6FC829BCC0411FDEE12003236871";
      else if(level.bplanted && !level.aplanted)
        var_2 = "_encstr_91D20FD8BB89EAE70E27C8B7AADDF76722";
      else
        var_2 = "_encstr_8E600D6BA06735ED9382C349F22243";

      var_3 = "_encstr_A915168B38F64472E59DAD27F5B56B37B9882313A0E9BB5A";
    }

    var_1 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, var_2, var_3);
  }

  return var_1;
}

onspawnplayer() {
  var_0 = regroup_think();

  if(scripts\mp\utility\game::inovertime() || self.pers["_encstr_8AEF05472BC2D6"] == var_0) {
    self setclientomnvar("_encstr_845A1183746F28871B8BBB83E312C068E7CDE9", 1);
    self.isplanting = 0;
    self.isdefusing = 0;
    self.isbombcarrier = 1;
  } else {
    self.isplanting = 0;
    self.isdefusing = 0;
    self.isbombcarrier = 0;
  }

  if(isDefined(self.pers["_encstr_8FB00783D8C2CDE8DC"]))
    scripts\mp\utility\stats::setextrascore0(self.pers["_encstr_8FB00783D8C2CDE8DC"]);
  else
    scripts\mp\utility\stats::setextrascore0(0);

  if(isDefined(self.pers["_encstr_817B0812789D1387E986"]))
    scripts\mp\utility\stats::setextrascore1(self.pers["_encstr_817B0812789D1387E986"]);
  else
    scripts\mp\utility\stats::setextrascore1(0);

  level notify("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
}

regroup_think() {
  var_0 = game["_encstr_991C0AB9ED5B57161FE89B83"];

  if(level.mapname == "_encstr_A6640D9D1109AF2FC7082B029395FF") {
    if(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"])
      var_0 = game["_encstr_991C0AB9ED5B57161FE89B83"];
    else
      var_0 = game["_encstr_B6A70A23CA6659DC91CAE4DC"];
  }

  return var_0;
}

hidecarryiconongameend() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level waittill("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(self.carryicon))
    self.carryicon.alpha = 0;
}

dd_endgame(var_0, var_1) {
  setomnvar("_encstr_9131145D2DFA31DBD698BED2B9E82B4E581B8EA5B9EC", 0);
  thread scripts\mp\gamelogic::endgame(var_0, var_1);
}

ondeadevent(var_0) {
  if(level.bombexploded > 0 || level.bombdefused) {
    return;
  }
  if(var_0 == "_encstr_AF1904A7F929") {
    if(level.bombplanted)
      dd_endgame(game["_encstr_991C0AB9ED5B57161FE89B83"], game["_encstr_99EA0B72AB022F6ED1CF9FC248"][tolower(game[game["_encstr_B6A70A23CA6659DC91CAE4DC"]]) + "_encstr_86E60CDF8828C17A6380E6DB7D11"]);
    else
      dd_endgame(game["_encstr_B6A70A23CA6659DC91CAE4DC"], game["_encstr_99EA0B72AB022F6ED1CF9FC248"][tolower(game[game["_encstr_991C0AB9ED5B57161FE89B83"]]) + "_encstr_86E60CDF8828C17A6380E6DB7D11"]);
  } else if(var_0 == game["_encstr_991C0AB9ED5B57161FE89B83"]) {
    if(level.bombplanted) {
      return;
    }
    level thread dd_endgame(game["_encstr_B6A70A23CA6659DC91CAE4DC"], game["_encstr_99EA0B72AB022F6ED1CF9FC248"][tolower(game[game["_encstr_991C0AB9ED5B57161FE89B83"]]) + "_encstr_86E60CDF8828C17A6380E6DB7D11"]);
  } else if(var_0 == game["_encstr_B6A70A23CA6659DC91CAE4DC"])
    level thread dd_endgame(game["_encstr_991C0AB9ED5B57161FE89B83"], game["_encstr_99EA0B72AB022F6ED1CF9FC248"][tolower(game[game["_encstr_B6A70A23CA6659DC91CAE4DC"]]) + "_encstr_86E60CDF8828C17A6380E6DB7D11"]);
}

onnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5) {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::oncommonnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5);
  var_6 = var_0.team;

  if(var_0.isplanting) {
    thread scripts\common\utility::_id_13E0A(level._id_11B30, var_2, "_encstr_8AD1096F4D428DC321FB3B");
    var_1 scripts\mp\utility\stats::incpersstat("_encstr_B1F7085B03F492AE98DB", 1);
    var_1 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_B1F7085B03F492AE98DB", var_1.pers["_encstr_B1F7085B03F492AE98DB"]);
  } else if(var_0.isdefusing) {
    thread scripts\common\utility::_id_13E0A(level._id_11B30, var_2, "_encstr_B669098CAC99BA6E96E63B");
    var_1 scripts\mp\utility\stats::incpersstat("_encstr_B1F7085B03F492AE98DB", 1);
    var_1 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_B1F7085B03F492AE98DB", var_1.pers["_encstr_B1F7085B03F492AE98DB"]);
  }

  _encstr_A9042687EF43D3E804AA982892B7981F6A5F311B3B5AA64A27C638663EAFB0C6B38F8DBB2AC26EE0::bombzone_awardgenericbombzonemedals(var_1, var_0);
}

ontimelimit() {
  if(scripts\mp\utility\game::inovertime())
    dd_endgame("_encstr_8D19048EA595", game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_B40B13237BEFC5278BC385D3C98FEA8518524C203D"]);
  else
    dd_endgame(game["_encstr_B6A70A23CA6659DC91CAE4DC"], game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_B40B13237BEFC5278BC385D3C98FEA8518524C203D"]);
}

updategametypedvars() {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::updatecommongametypedvars();
  level.planttime = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_85980AF3784743E3A0DB7D7D", 5, 0, 20);
  level.defusetime = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_87B30B90E22F53D357BC7B6185", 5, 0, 20);
  level.bombtimer = scripts\mp\utility\dvars::dvarintvalue("_encstr_912A0A13AF7D41E192A545D6", 45, 1, 300);
  level.ddtimetoadd = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_82610A2B1E3A4E16152DDACA", 120, 0, 500);
  level.overtime = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_85ED0E179550E2533320C25888191FDB", 1, 0, 180);
  level.resetprogress = scripts\mp\utility\dvars::dvarintvalue("_encstr_8BEF0E03CA3849BB09FBAD672D3DB0D7", 1, 0, 1);
  scripts\mp\utility\game::setovertimelimitdvar(level.overtime);
  level.silentplant = scripts\mp\utility\dvars::dvarintvalue("_encstr_866A0CDCD2D8569B8E058D0BCD3A", 0, 0, 1);
}

verifybombzones(var_0) {
  var_1 = "_encstr_B40101";

  if(var_0.size != 3) {
    var_2 = 0;
    var_3 = 0;
    var_4 = 0;

    foreach(var_6 in var_0) {
      if(issubstr(tolower(var_6.script_label), "_encstr_994C023A")) {
        var_2 = 1;
        continue;
      }

      if(issubstr(tolower(var_6.script_label), "_encstr_8B4C024C")) {
        var_3 = 1;
        continue;
      }

      if(issubstr(tolower(var_6.script_label), "_encstr_834C02D8"))
        var_4 = 1;
    }

    if(!var_2)
      var_1 = var_1 + "_encstr_A917049A1119";

    if(!var_3)
      var_1 = var_1 + "_encstr_881704128191";

    if(!var_4)
      var_1 = var_1 + "_encstr_851704960656";
  }

  if(var_1 != "_encstr_B40101")
    return;
}

bombs() {
  waittillframeend;
  level.bombplanted = 0;
  level.bombdefused = 0;
  level.bombexploded = 0;
  level.multibomb = 1;
  var_0 = getEntArray("_encstr_844E0C99C3A166200DFE2298E5ED", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  verifybombzones(var_0);
  level.objectives = [];

  foreach(var_2 in var_0) {
    var_3 = _encstr_A9042687EF43D3E804AA982892B7981F6A5F311B3B5AA64A27C638663EAFB0C6B38F8DBB2AC26EE0::setupobjective(var_2, 1);

    if(isDefined(var_3)) {
      var_3.onbeginuse = ::onbeginuse;
      var_3.onenduse = ::onenduse;
      var_3.onuse = ::onuseplantobject;
      level.objectives[var_3.objectivekey] = var_3;
    }
  }

  initspawns();

  if(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
    level scripts\engine\utility::_id_143A5("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B", "_encstr_8F55118F8B711B6436974A09E1173783D313D9");

  foreach(var_3 in level.objectives) {
    var_3 scripts\mp\gameobjects::requestid(1, 1);

    if(scripts\mp\utility\game::inovertime())
      var_3 scripts\mp\gameobjects::setobjectivestatusicons("_encstr_ABB91854DF2F8748473DFB813B21E3481A8387AA676D9B883E0A");
    else
      var_3 scripts\mp\gameobjects::setobjectivestatusicons("_encstr_994B105B20DB3A9F30206457CD5973870DE0", "_encstr_8F361077FED381AD0833C589FCA8DA67776B");

    var_3 scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
  }
}

onbeginuse(var_0) {
  _encstr_A9042687EF43D3E804AA982892B7981F6A5F311B3B5AA64A27C638663EAFB0C6B38F8DBB2AC26EE0::bombzone_onbeginuse(var_0);
}

onenduse(var_0, var_1, var_2) {
  _encstr_A9042687EF43D3E804AA982892B7981F6A5F311B3B5AA64A27C638663EAFB0C6B38F8DBB2AC26EE0::bombzone_onenduse(var_0, var_1, var_2);
}

onuseplantobject(var_0) {
  var_1 = [];
  var_1[var_1.size] = var_0;
  level thread scripts\mp\hud_message::notifyteam("_encstr_A1320CC529ABD8FBDB229338D1AD", "_encstr_B23E12ACDA38F5C1362CCD3A5946F5569BAC5BF2", var_0.team, var_1);
  var_0 thread scripts\mp\hud_message::showsplash("_encstr_A1320CC529ABD8FBDB229338D1AD", scripts\mp\rank::getscoreinfovalue("_encstr_A24E069389FFAA3C"));
  _encstr_A9042687EF43D3E804AA982892B7981F6A5F311B3B5AA64A27C638663EAFB0C6B38F8DBB2AC26EE0::bombzone_onuseplantobject(var_0);

  if(level.bombexploded == 1)
    thread scripts\mp\music_and_dialog::bombplanted_music();
}

setupkillcament() {
  var_0 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", self.origin);
  var_0.angles = self.angles;
  var_0 rotateYaw(-45, 0.05);
  waitframe();
  var_1 = self.origin + (0, 0, 5);
  var_2 = self.origin + anglesToForward(var_0.angles) * 100 + (0, 0, 128);
  var_3 = scripts\engine\trace::ray_trace(var_1, var_2, self, scripts\engine\trace::create_default_contents(1));
  self.killcament = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_3["_encstr_BD260953AA97E3F014279D"]);
  self.killcament setscriptmoverkillcam("_encstr_AB440A3180D0C0109B17550B");
  var_0 delete();
}

resetbombzone(var_0) {
  if(scripts\mp\utility\game::inovertime()) {
    scripts\mp\gameobjects::setownerteam("_encstr_A7A408B9CA5D1D4E2C63");
    scripts\mp\gameobjects::setobjectivestatusicons("_encstr_8F361077FED381AD0833C589FCA8DA67776B");
  } else {
    scripts\mp\gameobjects::setownerteam(game["_encstr_B6A70A23CA6659DC91CAE4DC"]);
    scripts\mp\gameobjects::allowuse("_encstr_88BF06FD784A6393");
    scripts\mp\gameobjects::setobjectivestatusicons("_encstr_994B105B20DB3A9F30206457CD5973870DE0", "_encstr_8F361077FED381AD0833C589FCA8DA67776B");
  }

  scripts\mp\gameobjects::setusehinttext(&"_encstr_86521C40F31A48B789C00EA1E87719B36165B94985B9F1294046695955AA");
  self.id = "_encstr_BED80ABE90F30A6F7A40FBDF";
  scripts\mp\gameobjects::setusetime(level.planttime);
  scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
  self.useweapon = getcompleteweaponname("_encstr_812C128152B9F8E4EA670F3B8722B8704AE1E85B");
  self.bombexploded = undefined;
}

setupfordefusing() {
  scripts\mp\gameobjects::allowuse("_encstr_ACFC091AE8AB2FCBE15119");
  scripts\mp\gameobjects::setusetime(level.defusetime);
  scripts\mp\gameobjects::setkeyobject(undefined);
  scripts\mp\gameobjects::setobjectivestatusicons("_encstr_834B10DD2CF283DE4B9B3AFA19ACCC57DC95", "_encstr_994B105B20DB3A9F30206457CD5973870DE0");
  scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
}

oncantuse(var_0) {
  var_0 iprintlnbold(&"_encstr_B8731351E2067504A5EB41999B855E3B7859D5C60F");
}

onreset() {}

bombplanted(var_0, var_1) {
  var_0 endon("_encstr_9A7B088CCA335D37CA91");
  var_2 = var_1.team;
  level.bombsplanted = level.bombsplanted + 1;
  scripts\mp\gamelogic::pausetimer();
  level.timepausestart = gettime();
  level.timelimitoverride = 1;
  level.bombplanted = 1;
  level.destroyedobject = var_0;

  if(level.destroyedobject.objectivekey == "_encstr_B20703DFCF")
    level.aplanted = 1;
  else
    level.bplanted = 1;

  level.destroyedobject.bombplanted = 1;
  level.tickingobject = var_0.visuals[0];
  dropbombmodel(var_1, var_0.objectivekey);
  var_0.bombdefused = 0;
  var_0 scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");
  var_0 scripts\mp\gameobjects::setvisibleteam("_encstr_8BBA05185F8B99");

  if(scripts\mp\utility\game::inovertime())
    var_0 scripts\mp\gameobjects::setownerteam(scripts\mp\utility\game::getotherteam(var_1.team)[0]);

  var_0 setupfordefusing();
  var_0 bombtimerwait(var_0);
  var_0 thread bombhandler(var_1, "_encstr_860808CB78E2984063BA", var_2);
}

bombhandler(var_0, var_1, var_2) {
  level.bombsplanted = level.bombsplanted - 1;

  if(self.objectivekey == "_encstr_B20703DFCF")
    level.aplanted = 0;
  else
    level.bplanted = 0;

  restarttimer();
  _encstr_A9042687EF43D3E804AA982892B7981F6A5F311B3B5AA64A27C638663EAFB0C6B38F8DBB2AC26EE0::setbombtimeromnvars();

  if(level.gameended) {
    return;
  }
  if(var_1 == "_encstr_860808CB78E2984063BA") {
    self.bombexploded = 1;
    var_3 = scripts\mp\utility\dvars::getwatcheddvar("_encstr_8B250A53848DC8D17A472BE9");

    if(var_3 != 0 && !scripts\mp\utility\game::inovertime() && level.bombexploded < 2 && level.ddtimetoadd > 0) {
      level.extratime = level.bombexploded * level.ddtimetoadd;
      var_4 = scripts\mp\gamelogic::gettimeremaining();

      if(istrue(level.timerstoppedforgamemode))
        var_4 = var_4 - level.bombtimer * 1000;

      setgameendtime(gettime() + int(var_4));
    }

    wait 2;

    if(scripts\mp\utility\game::inovertime() || level.bombexploded > 1) {
      if(istrue(level.nukeincoming)) {
        return;
      }
      dd_endgame(var_2, game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_ABCA11472C9C3B56E8BE3295CD1D93B7E5CA91"]);
      return;
    }

    if(level.ddtimetoadd > 0) {
      scripts\mp\utility\dialog::statusdialog("_encstr_8BEF12016AC8A909A8A7AA412D37E0FB08B6E3E8", game["_encstr_B6A70A23CA6659DC91CAE4DC"]);
      level thread scripts\mp\hud_message::notifyteam("_encstr_824E13863B73F3E8859B67F1D070739EFFE15F4F39", "_encstr_824E13863B73F3E8859B67F1D070739EFFE15F4F39", var_0.team);
      return;
    }

    return;
  } else {
    var_0 notify("_encstr_ACA10DAE80E31A1FC960CB8FF8C11C" + self.objectivekey);
    self notify("_encstr_9A7B088CCA335D37CA91");
    resetbombzone(var_0);
  }
}

dropbombmodel(var_0, var_1) {
  var_2 = scripts\engine\trace::ray_trace(var_0.origin + (0, 0, 20), var_0.origin - (0, 0, 2000), var_0, scripts\engine\trace::create_default_contents(1));
  var_3 = randomfloat(360);
  var_4 = (cos(var_3), sin(var_3), 0);
  var_4 = vectorNormalize(var_4 - var_2["_encstr_820E07FAE8780B3A4C"] * vectordot(var_4, var_2["_encstr_820E07FAE8780B3A4C"]));
  var_5 = vectortoangles(var_4);
  level.ddbombmodel[var_1] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2["_encstr_BD260953AA97E3F014279D"]);
  level.ddbombmodel[var_1].angles = var_5;
  level.ddbombmodel[var_1] setModel("_encstr_8601133B681070F1EFB54C0396F30B2DBE70CF3780");
}

restarttimer() {
  if(scripts\mp\utility\game::inovertime()) {
    if(level.bombexploded == 1)
      return;
  } else if(level.bombexploded > 1) {
    return;
  }
  if(level.bombsplanted <= 0) {
    scripts\mp\gamelogic::resumetimer();
    level.timepaused = gettime() - level.timepausestart;
    level.timelimitoverride = 0;
  }
}

bombtimerwait(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_ACA10DAE80E31A1FC960CB8FF8C11C" + var_0.objectivekey);

  if(scripts\mp\utility\game::inovertime())
    var_0.waittime = level.bombtimer;
  else
    var_0.waittime = level.bombtimer;

  level thread update_ui_timers(var_0);

  while(var_0.waittime >= 0) {
    var_0.waittime--;

    if(var_0.waittime >= 0)
      wait 1;

    scripts\mp\hostmigration::waittillhostmigrationdone();
  }
}

update_ui_timers(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_ACA10DAE80E31A1FC960CB8FF8C11C" + var_0.objectivekey);
  level endon("_encstr_A36F0EC4EDDAC4AFB20F3836F623B246" + var_0.objectivekey);
  var_1 = var_0.waittime * 1000 + gettime();
  setDvar("_encstr_AB710D678B3E6D18C8324D9F3B088A" + var_0.objectivekey, var_1);
  level waittill("_encstr_AD3F1534DB9BA3BEADD27627B0D1B4BDCDAFC495EC2DCD");
  var_2 = scripts\mp\hostmigration::waittillhostmigrationdone();

  if(var_2 > 0)
    setDvar("_encstr_AB710D678B3E6D18C8324D9F3B088A" + var_0.objectivekey, var_1 + var_2);
}

bombdefused(var_0) {
  level.tickingobject scripts\mp\gamelogic::stoptickingsound();
  var_0.bombdefused = 1;
  level notify("_encstr_ACA10DAE80E31A1FC960CB8FF8C11C" + var_0.objectivekey);
}

setupobjectiveicons() {
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_97AE1A77C2E51CED2D73D17DA35827CE2B3A7DE659AE4727C28DAFB0", 0, "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_A3671F95FF3EF75D47C968E0513F05BB56F82F121AC64B5655E190E969FF0E034F", "_encstr_95F514A22F95A85940918328F0C452FCA95B4D4979B1", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_970712EEB0CB0E7B2D9B47BEC8CA335DE659D758", 0, "_encstr_88BF06FD784A6393", "_encstr_97851F04A9D703D14FD90B03DFA5197937B6DC6DB07FCDF157E53F0B379E393FB7", "_encstr_95F514A22F95A85940918328F0C452FCA95B4D4979B1", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_8A07125BA25797D0FCCE712FEC2740DD971AD661", 0, "_encstr_88BF06FD784A6393", "_encstr_97851F04A9D703D14FD90B03DFA5197937B6DC6DB07FCDF157E53F0B379E393FB7", "_encstr_BAF514A56CDB9BD7BBC22F07F62DCD8EEB46B7B6EB98", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_BE3F17DF5170A89087FA9BE6224759F001AC7365FD1D50F0CF", 0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_ACB71FA04759DCD6891D9554091C3EFCE1D6B7E6FA7184F94D086C08079BEF0FCA", "_encstr_95F514A22F95A85940918328F0C452FCA95B4D4979B1", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_AC3F1768C28839304786D55862B7B8E5F97A60683AE5594E33", 0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_ACB71FA04759DCD6891D9554091C3EFCE1D6B7E6FA7184F94D086C08079BEF0FCA", "_encstr_BAF514A56CDB9BD7BBC22F07F62DCD8EEB46B7B6EB98", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_AA9E159451D73BE764A2E8A91A3FBDD347FD0880BCA7C1", 0, "_encstr_88BF06FD784A6393", "_encstr_B40101", "_encstr_95F514A22F95A85940918328F0C452FCA95B4D4979B1", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_969E157716CBE07B2DE68EEB32563357CDB2D7378EF54C", 0, "_encstr_88BF06FD784A6393", "_encstr_B40101", "_encstr_BAF514A56CDB9BD7BBC22F07F62DCD8EEB46B7B6EB98", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_A1681AEE0B2F07DE2D9B3AFA31B7D689F5C8ACCCAC3719AFB9D1FAC2", 0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_B40101", "_encstr_95F514A22F95A85940918328F0C452FCA95B4D4979B1", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_A7681ADD2C5E38EDD2E6D1D7897B5B4CFA46B23356E68CFA733AEB13", 0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_B40101", "_encstr_BAF514A56CDB9BD7BBC22F07F62DCD8EEB46B7B6EB98", 0);
}