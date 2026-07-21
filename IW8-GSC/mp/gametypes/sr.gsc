/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\sr.gsc
***********************************************/

main() {
  if(getDvar("_encstr_9570084B1793A090CDFF") == "_encstr_8D510E52E3A7C6985EB7B9BE2F35C690") {
    return;
  }
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  var_0[0] = "_encstr_B807035284";
  var_0[1] = "_encstr_979A09DA67D0262B70CD82";
  var_0[2] = "_encstr_A65908C41BED1BD62B4E";
  scripts\mp\gameobjects::main(var_0);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 3, 0, 12);
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 150);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 4);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerwinbytwoenableddvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerwinbytwomaxroundsdvar(scripts\mp\utility\game::getgametype(), 4);
    scripts\mp\utility\game::registerdogtagsenableddvar(scripts\mp\utility\game::getgametype(), 1);
  }

  updategametypedvars();
  level.laststandrequiresmelee = getdvarint("_encstr_A54014F3A9FEB7D5D83F949B19F09D83B0806A8AF1DD", 0);
  level.objectivebased = 1;
  level.teambased = 1;
  level.nobuddyspawns = 1;
  level.onprecachegametype = ::onprecachegametype;
  level.onstartgametype = ::onstartgametype;
  level.getspawnpoint = ::getspawnpoint;
  level.modeonspawnplayer = ::onspawnplayer;
  level.onplayerkilled = ::onplayerkilled;
  level.ondeadevent = ::ondeadevent;
  level.ononeleftevent = ::ononeleftevent;
  level.ontimelimit = ::ontimelimit;
  level.onnormaldeath = ::onnormaldeath;
  level.gamemodemaydropweapon = scripts\mp\utility\game::isplayeroutsideofanybombsite;
  level.onobjectivecomplete = ::onbombexploded;
  level.resetuiomnvargamemode = _encstr_A9042687EF43D3E804AA982892B7981F6A5F311B3B5AA64A27C638663EAFB0C6B38F8DBB2AC26EE0::resetuiomnvargamemode;
  level.allowlatecomers = 0;
  level.bombsplanted = 0;
  level.nofriendlytags = 1;
  level.aplanted = 0;
  level.bplanted = 0;
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_92110D670F1B92BCE2504F9F703872";

  if(getdvarint("_encstr_B2020AE1F36BF74429D93F01"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_8A19042AB017" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];
  else if(getdvarint("_encstr_82570B397A4D3192935192A562"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_979708CC69F02253FF26" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];

  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_95240C659372588E43623137DE6C"] = "_encstr_ADEB0C27227298E09388E4239D07";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_93420C4255FBEA5D408FD1FD2A62"] = "_encstr_91200B458012D6016F90DA1EBA";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B2C30DC06FBD8177D266831BFFFB5B"] = "_encstr_B2C30DC06FBD8177D266831BFFFB5B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B6260B26DB5B98F51D16DAAC73"] = "_encstr_B6260B26DB5B98F51D16DAAC73";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8F850A13DBDA31AF8DED6E1D"] = "_encstr_957D0F22AF0F26E910DDF7B8E7A23B2DE0";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_ACA10DAE80E31A1FC960CB8FF8C11C"] = "_encstr_ACA10DAE80E31A1FC960CB8FF8C11C";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AB3D0DE25FE81EF7B7188A42230553"] = "_encstr_AB3D0DE25FE81EF7B7188A42230553";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BA920D59E6CA6B2FAF4CDBD631FAB0"] = "_encstr_96D50DB638514326450683D863A990";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_95920D7910C5AB2FB9D6A72D9ABFED"] = "_encstr_88D50D4CF6B626BE59CDB2AD2FAFC4";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_93E61365C8514FA84FF8120AC077A727692DFB1D55"] = "_encstr_8E061206578F71FF1FAA7830F377B34947D31D8D";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_84B513CA73CADABC7D98BDDAC4AF0E63B0B9D156C8"] = "_encstr_BDAF1226DED613FA959BAC6BF20E8D16DC472B91";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_91BA0FB5D21BB1AF36DB37995AE4DACA8C"] = "_encstr_91BA0FB5D21BB1AF36DB37995AE4DACA8C";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9A06111B0B6EA316C64B3BACFA9C599D2DEC59"] = "_encstr_9A06111B0B6EA316C64B3BACFA9C599D2DEC59";
  setomnvar("_encstr_950418EAD2F5C47BAD13AFD14BDAB2E4BEACCD231D2DD6B2D70B", 0);
  setomnvar("_encstr_BA0418D5D2FA98BDB698BE3A4BD6B227F556E6231D5ADA56FAC4", 0);
  setomnvar("_encstr_B47A12BBF4378A8F5573A12B03F138F30588CED7", 0);
  setomnvar("_encstr_B67A125D2DF589F65B31D78363B0DCE8AC8CBE4C", 0);
  setomnvar("_encstr_9131145D2DFA31DBD698BED2B9E82B4E581B8EA5B9EC", 0);
  level.conf_fx["_encstr_8BE007AB0FE8607F9B"] = loadfx("_encstr_AB531FCE99C3CB1BDEE456F25AB51CC26CE8CDBC9BDA2CC636F5CD73B777865AE8");
  level thread laststandmonitor();
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("_encstr_A70911FF7B8AE9B6C3F1B1183A6BED80E5D545", getmatchrulesdata("_encstr_ACED09DB8FF96A0C48B36E", "_encstr_912A0A13AF7D41A192A545D6"));
  setdynamicdvar("_encstr_ABA011C39A63083802C77151E1EDC865F79299", getmatchrulesdata("_encstr_ACED09DB8FF96A0C48B36E", "_encstr_85980AF3784743E3A1DB7D7D"));
  setdynamicdvar("_encstr_8B9A12DC369CD7DC9CBE46AC33AE37B23A5AB595", getmatchrulesdata("_encstr_ACED09DB8FF96A0C48B36E", "_encstr_87B30B90E22F53D3579C7B6185"));
  setdynamicdvar("_encstr_ABA411DC3693BEE639FADA57C61D4BC4B75B31", getmatchrulesdata("_encstr_ACED09DB8FF96A0C48B36E", "_encstr_AD4D0AD6AB368E5A24EDDA31"));
  setdynamicdvar("_encstr_B8B213422682F7821BDFE3929980A6EBD21A0F4B70", getmatchrulesdata("_encstr_ACED09DB8FF96A0C48B36E", "_encstr_866A0CDCD2D8569B8E058D0BCD3A"));
  setdynamicdvar("_encstr_AA62106E36C9FA9BC9D7D0851B99E84B6BAC", 0);
  scripts\mp\utility\game::registerhalftimedvar("_encstr_9B0703CD93", 0);
  setdynamicdvar("_encstr_ADF30F90877AEEE7DB21D7DE05021731D5", 0);
}

onprecachegametype() {
  game["_encstr_BE9B13E59FF216D154AAD04B523D40C04B3773752B"] = "_encstr_A76F166B1CF5BBB039F57B89A6568DD196D995F5D8F6E61D";
  game["_encstr_BA2A15987B5B13EB39AC6CB7B3B29C9523EB6EBDEA3719"] = "_encstr_87ED1717204EDFBA5518655EFA13D284D0B88F5798610B2255";
}

onstartgametype() {
  if(!isDefined(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]))
    game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"] = 0;

  if(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]) {
    var_0 = game["_encstr_991C0AB9ED5B57161FE89B83"];
    var_1 = game["_encstr_B6A70A23CA6659DC91CAE4DC"];
    game["_encstr_991C0AB9ED5B57161FE89B83"] = var_1;
    game["_encstr_B6A70A23CA6659DC91CAE4DC"] = var_0;
  }

  setclientnamemode("_encstr_8B070EAD85CDEA0B8D7D1B4316E63B2B");
  level._effect["_encstr_9A8C0F89BDDA26D7B20FC163B7E6B4DB73"] = loadfx("_encstr_A7CE3453FC2126B13322974778E0770AF3851D8D55B37ED679089F3738013A525130260549E573010398A7932B3BF48B07BBBDFBA439");
  level._effect["_encstr_9BF6123B2B1A5A8DC62B7DB20F0736BD6E96F6B9"] = loadfx("_encstr_99452E086F5158BE68AB4DBF6060FAEC0617407163328FFB6AD87A1FF05101E3028A6A5F5B7FB7C8DF603563D284C883");
  level._effect["_encstr_92901389CBAB79F5D84E615738AB8B589067B4EA88"] = loadfx("_encstr_B6F42B9E9FCBAE0CD8C23829EBC1635B8797C0FF2802D7C77BD340067187115D803184BE9535896889EA9B0AC3");
  scripts\mp\utility\game::setobjectivetext(game["_encstr_991C0AB9ED5B57161FE89B83"], &"_encstr_926817D78B129F25FB3CAB45DE473F74A6D37965D92BE918D6");
  scripts\mp\utility\game::setobjectivetext(game["_encstr_B6A70A23CA6659DC91CAE4DC"], &"_encstr_8F1B17E786ECB74E31D9E9D0E12FB24BA61D7566AD34FB8765");

  if(level.splitscreen) {
    scripts\mp\utility\game::setobjectivescoretext(game["_encstr_991C0AB9ED5B57161FE89B83"], &"_encstr_926817D78B129F25FB3CAB45DE473F74A6D37965D92BE918D6");
    scripts\mp\utility\game::setobjectivescoretext(game["_encstr_B6A70A23CA6659DC91CAE4DC"], &"_encstr_8F1B17E786ECB74E31D9E9D0E12FB24BA61D7566AD34FB8765");
  } else {
    scripts\mp\utility\game::setobjectivescoretext(game["_encstr_991C0AB9ED5B57161FE89B83"], &"_encstr_97481DB00D625F9EF1CB362DD70252833085F989F54E2F47B9FF0B331731EF");
    scripts\mp\utility\game::setobjectivescoretext(game["_encstr_B6A70A23CA6659DC91CAE4DC"], &"_encstr_A9FD1D7FA24CF17683580F15811636B1513CE3D50DA501ADB311A7DD68CBC5");
  }

  scripts\mp\utility\game::setobjectivehinttext(game["_encstr_991C0AB9ED5B57161FE89B83"], &"_encstr_97AF1CF4842951688A4A59159ACB3588FAA051455068B454A4EB24A4E48A");
  scripts\mp\utility\game::setobjectivehinttext(game["_encstr_B6A70A23CA6659DC91CAE4DC"], &"_encstr_AB4F1CE99052511AA8926554D4BCD488EB8815192A9C885429F5214A2745");
  initspawns();
  level.dogtagallyonusecb = ::dogtagallyonusecb;
  setspecialloadout();
  thread bombs();
}

initspawns() {
  scripts\mp\spawnlogic::setactivespawnlogic("_encstr_922D107FBD8E407E6BD0703989372E902315", "_encstr_A6E80F61DA270BDE09B2C8C33B40AB859D");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addstartspawnpoints("_encstr_8C0515DA83BEB991BEB9C1B0BBDCFA581D8EC2B1ADCA39");
  scripts\mp\spawnlogic::addstartspawnpoints("_encstr_AC9A15250B91A8BDA6E3404BD38E405F4178BFF233D550");
  scripts\mp\spawnlogic::addspawnpoints("_encstr_AA7B09475984AF0F6F0F0B", "_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD");
  scripts\mp\spawnlogic::addspawnpoints("_encstr_AA7B09475984AF0F6F0F0B", "_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("_encstr_8E460991ACCC59378C56C9", "_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD");
  scripts\mp\spawnlogic::addspawnpoints("_encstr_8E460991ACCC59378C56C9", "_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", 1, 1);
  scripts\mp\spawnlogic::registerspawnpoints("_encstr_820E07FAE8780B3A4C", "_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD");
  scripts\mp\spawnlogic::registerspawnpoints("_encstr_AD0C095DF195E8B6074A18", "_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318");
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

getspawnpoint() {
  var_0 = "_encstr_8E460991ACCC59378C56C9";

  if(self.pers["_encstr_8AEF05472BC2D6"] == game["_encstr_991C0AB9ED5B57161FE89B83"])
    var_0 = "_encstr_AA7B09475984AF0F6F0F0B";

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    var_1 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_975D0D9AC1371361E716CB30F730E7" + var_0);
    var_2 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_1);
  } else
    var_2 = scripts\mp\spawnlogic::getspawnpoint(self, self.pers["_encstr_8AEF05472BC2D6"], "_encstr_820E07FAE8780B3A4C", "_encstr_AD0C095DF195E8B6074A18");

  return var_2;
}

onspawnplayer() {
  self.isplanting = 0;
  self.isdefusing = 0;
  self.isbombcarrier = 0;

  if(level.multibomb && self.pers["_encstr_8AEF05472BC2D6"] == game["_encstr_991C0AB9ED5B57161FE89B83"])
    self setclientomnvar("_encstr_845A1183746F28871B8BBB83E312C068E7CDE9", 1);
  else {
    self setclientomnvar("_encstr_845A1183746F28871B8BBB83E312C068E7CDE9", 0);

    foreach(var_1 in level.objectives)
    var_1.trigger disableplayeruse(self);
  }

  level notify("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");

  if(scripts\mp\utility\teams::isgameplayteam(self.sessionteam)) {
    level notify("_encstr_BA4F115ABE378BFCB950376349F0A7423D5DE7", self);
    scripts\mp\utility\stats::setextrascore0(0);

    if(isDefined(self.pers["_encstr_8FB00783D8C2CDE8DC"]))
      scripts\mp\utility\stats::setextrascore0(self.pers["_encstr_8FB00783D8C2CDE8DC"]);

    scripts\mp\utility\stats::setextrascore1(0);

    if(isDefined(self.pers["_encstr_8294083A0938C3CB2577"]))
      scripts\mp\utility\stats::setextrascore1(self.pers["_encstr_8294083A0938C3CB2577"]);
  }
}

laststandmonitor() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    waitframe();
    level thread laststandkillteamifdown();
  }
}

laststandkillteamifdown() {
  var_0 = [];

  foreach(var_2 in level.teamnamelist) {
    var_0[var_2] = [];
    var_3[var_2] = 0;
  }

  foreach(var_2 in level.teamnamelist) {
    var_6 = scripts\mp\utility\teams::getteamdata(var_2, "_encstr_9775086022BE1B413B8B");
    var_3 = 0;
    var_0 = [];

    foreach(var_8 in var_6) {
      if(scripts\mp\utility\player::isreallyalive(var_8)) {
        var_3++;

        if(istrue(var_8.inlaststand))
          var_0[var_0.size] = var_8;
      }
    }

    if(var_0.size > 0 && var_3 <= var_0.size) {
      level.laststandrequiresmelee = 0;

      foreach(var_8 in var_0)
      var_8 suicide();
    }
  }
}

onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  self setclientomnvar("_encstr_845A1183746F28871B8BBB83E312C068E7CDE9", 0);
  thread checkallowspectating();
}

checkallowspectating() {
  waitframe();
  var_0 = 0;

  if(!scripts\mp\utility\teams::getteamdata(game["_encstr_991C0AB9ED5B57161FE89B83"], "_encstr_8A2A0B936CCCC3078547970A8B")) {
    level.spectateoverride[game["_encstr_991C0AB9ED5B57161FE89B83"]].allowenemyspectate = 1;
    var_0 = 1;
  }

  if(!scripts\mp\utility\teams::getteamdata(game["_encstr_B6A70A23CA6659DC91CAE4DC"], "_encstr_8A2A0B936CCCC3078547970A8B")) {
    level.spectateoverride[game["_encstr_B6A70A23CA6659DC91CAE4DC"]].allowenemyspectate = 1;
    var_0 = 1;
  }

  if(var_0)
    scripts\mp\spectating::updatespectatesettings();
}

sd_endgame(var_0, var_1) {
  setomnvarforallclients("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", 0);
  setomnvar("_encstr_9131145D2DFA31DBD698BED2B9E82B4E581B8EA5B9EC", 0);
  thread scripts\mp\gamelogic::endgame(var_0, var_1);
}

ondeadevent(var_0) {
  if(level.bombexploded > 0 || level.bombdefused) {
    return;
  }
  if(var_0 == "_encstr_AF1904A7F929") {
    if(level.bombplanted)
      sd_endgame(game["_encstr_991C0AB9ED5B57161FE89B83"], game["_encstr_99EA0B72AB022F6ED1CF9FC248"][tolower(game[game["_encstr_B6A70A23CA6659DC91CAE4DC"]]) + "_encstr_86E60CDF8828C17A6380E6DB7D11"]);
    else
      sd_endgame(game["_encstr_B6A70A23CA6659DC91CAE4DC"], game["_encstr_99EA0B72AB022F6ED1CF9FC248"][tolower(game[game["_encstr_991C0AB9ED5B57161FE89B83"]]) + "_encstr_86E60CDF8828C17A6380E6DB7D11"]);
  } else if(var_0 == game["_encstr_991C0AB9ED5B57161FE89B83"]) {
    if(level.bombplanted) {
      return;
    }
    level thread sd_endgame(game["_encstr_B6A70A23CA6659DC91CAE4DC"], game["_encstr_99EA0B72AB022F6ED1CF9FC248"][tolower(game[game["_encstr_991C0AB9ED5B57161FE89B83"]]) + "_encstr_86E60CDF8828C17A6380E6DB7D11"]);
  } else if(var_0 == game["_encstr_B6A70A23CA6659DC91CAE4DC"])
    level thread sd_endgame(game["_encstr_991C0AB9ED5B57161FE89B83"], game["_encstr_99EA0B72AB022F6ED1CF9FC248"][tolower(game[game["_encstr_B6A70A23CA6659DC91CAE4DC"]]) + "_encstr_86E60CDF8828C17A6380E6DB7D11"]);
}

ononeleftevent(var_0) {
  if(level.bombexploded > 0 || level.bombdefused) {
    return;
  }
  var_1 = scripts\mp\utility\game::getlastlivingplayer(var_0);
  var_1 thread givelastonteamwarning();
}

onnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5) {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::oncommonnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5);
  var_6 = scripts\mp\rank::getscoreinfovalue("_encstr_ABD70578F3D02C");
  var_7 = var_0.team;

  if(var_0.isplanting) {
    thread scripts\common\utility::_id_13E0A(level._id_11B30, var_2, "_encstr_8AD1096F4D428DC321FB3B");
    var_1 scripts\mp\utility\stats::incpersstat("_encstr_B1F7085B03F492AE98DB", 1);
    var_1 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_B1F7085B03F492AE98DB", var_1.pers["_encstr_B1F7085B03F492AE98DB"]);
  } else if(var_0.isbombcarrier)
    thread scripts\common\utility::_id_13E0A(level._id_11B30, var_2, "_encstr_852F09FA41FB7ADB3968C4");
  else if(var_0.isdefusing) {
    thread scripts\common\utility::_id_13E0A(level._id_11B30, var_2, "_encstr_B669098CAC99BA6E96E63B");
    var_1 scripts\mp\utility\stats::incpersstat("_encstr_B1F7085B03F492AE98DB", 1);
    var_1 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_B1F7085B03F492AE98DB", var_1.pers["_encstr_B1F7085B03F492AE98DB"]);
  }

  _encstr_A9042687EF43D3E804AA982892B7981F6A5F311B3B5AA64A27C638663EAFB0C6B38F8DBB2AC26EE0::bombzone_awardgenericbombzonemedals(var_1, var_0);
}

givelastonteamwarning() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\mp\utility\player::waittillrecoveredhealth(3);
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "_encstr_88101078BE5C37CD984FAC9EDB23672DB507");
  var_0 = scripts\mp\utility\game::getotherteam(self.pers["_encstr_8AEF05472BC2D6"])[0];
  level thread scripts\mp\hud_util::teamplayercardsplash("_encstr_AB591C8E66FAE1D845FBD978977B7319B28E7101FF4245C12AC748582385", self, self.pers["_encstr_8AEF05472BC2D6"]);
  level thread scripts\mp\hud_util::teamplayercardsplash("_encstr_81D01736858DB1BDAE8E7D1BB09B3AACCDB2DA97851B4BB395", self, var_0);

  foreach(var_2 in level.players) {
    if(var_2.pers["_encstr_8AEF05472BC2D6"] == self.pers["_encstr_8AEF05472BC2D6"]) {
      if(isDefined(var_2.tagavailable) && var_2.tagavailable)
        level.nofriendlytags = 0;
    }
  }

  level notify("_encstr_B6420BE367A3B0A1F7EB43C33F", self);
}

ontimelimit() {
  sd_endgame(game["_encstr_B6A70A23CA6659DC91CAE4DC"], game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_B40B13237BEFC5278BC385D3C98FEA8518524C203D"]);

  foreach(var_1 in level.players) {
    if(isDefined(var_1.bombplantweapon)) {
      var_1 scripts\cp_mp\utility\inventory_utility::_takeweapon(var_1.bombplantweapon);
      break;
    }
  }
}

updategametypedvars() {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::updatecommongametypedvars();
  level.planttime = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_85980AF3784743E3A0DB7D7D", 5, 0, 20);
  level.defusetime = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_87B30B90E22F53D357BC7B6185", 5, 0, 20);
  level.bombtimer = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_912A0A13AF7D41E192A545D6", 45, 1, 300);
  level.multibomb = scripts\mp\utility\dvars::dvarintvalue("_encstr_AD4D0AD6AB368E5A26EDDA31", 0, 0, 1);
  level.silentplant = scripts\mp\utility\dvars::dvarintvalue("_encstr_866A0CDCD2D8569B8E058D0BCD3A", 0, 0, 1);
}

removebombzonec(var_0) {
  var_1 = [];
  var_2 = getEntArray("_encstr_AFF5126B8E3BE4E07B3EE0130BC6E841C8C1910C", "_encstr_AC110A7F14873B5B3D073009");

  foreach(var_4 in var_2) {
    if(isDefined(var_4.script_gameobjectname) && var_4.script_gameobjectname == "_encstr_979A09DA67D0262B70CD82") {
      foreach(var_6 in var_0) {
        if(distance(var_4.origin, var_6.origin) < 100 && issubstr(tolower(var_6.script_label), "_encstr_834C02D8")) {
          var_6.relatedbrushmodel = var_4;
          var_1[var_1.size] = var_6;
          break;
        }
      }
    }
  }

  foreach(var_10 in var_1) {
    var_10.relatedbrushmodel delete();
    var_11 = getEntArray(var_10.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    foreach(var_13 in var_11)
    var_13 delete();

    var_10 delete();
  }

  return scripts\engine\utility::array_removeundefined(var_0);
}

bombs() {
  _encstr_A9042687EF43D3E804AA982892B7981F6A5F311B3B5AA64A27C638663EAFB0C6B38F8DBB2AC26EE0::bombzone_setupbombcase("_encstr_9B1308E20DFF6227E040");
  var_0 = getEntArray("_encstr_979A09DA67D0262B70CD82", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0 = removebombzonec(var_0);
  level.objectives = [];

  foreach(var_2 in var_0) {
    var_3 = _encstr_A9042687EF43D3E804AA982892B7981F6A5F311B3B5AA64A27C638663EAFB0C6B38F8DBB2AC26EE0::setupobjective(var_2, 1);
    var_3.onbeginuse = ::onbeginuse;
    var_3.onenduse = ::onenduse;
    var_3.onuse = ::onuseplantobject;
    level.objectives[var_3.objectivekey] = var_3;
  }
}

onbeginuse(var_0) {
  _encstr_A9042687EF43D3E804AA982892B7981F6A5F311B3B5AA64A27C638663EAFB0C6B38F8DBB2AC26EE0::bombzone_onbeginuse(var_0);

  if(!scripts\mp\gameobjects::isfriendlyteam(var_0.pers["_encstr_8AEF05472BC2D6"])) {
    if(level.multibomb) {
      if(self.objectivekey == "_encstr_B20703DFCF") {
        level.objectives["_encstr_B40703E96D"] scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");
        level.objectives["_encstr_B40703E96D"] scripts\mp\gameobjects::setvisibleteam("_encstr_ACFC091AE8AB2FCBE15119");
      } else {
        level.objectives["_encstr_B20703DFCF"] scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");
        level.objectives["_encstr_B20703DFCF"] scripts\mp\gameobjects::setvisibleteam("_encstr_ACFC091AE8AB2FCBE15119");
      }
    }
  }
}

onenduse(var_0, var_1, var_2) {
  _encstr_A9042687EF43D3E804AA982892B7981F6A5F311B3B5AA64A27C638663EAFB0C6B38F8DBB2AC26EE0::bombzone_onenduse(var_0, var_1, var_2);

  if(!scripts\mp\gameobjects::isfriendlyteam(var_1.pers["_encstr_8AEF05472BC2D6"])) {
    if(level.multibomb && !var_2) {
      if(self.objectivekey == "_encstr_B20703DFCF") {
        level.objectives["_encstr_B40703E96D"] scripts\mp\gameobjects::allowuse("_encstr_88BF06FD784A6393");
        level.objectives["_encstr_B40703E96D"] scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
      } else {
        level.objectives["_encstr_B20703DFCF"] scripts\mp\gameobjects::allowuse("_encstr_88BF06FD784A6393");
        level.objectives["_encstr_B20703DFCF"] scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
      }
    }
  }
}

onuseplantobject(var_0) {
  if(!scripts\mp\gameobjects::isfriendlyteam(var_0.pers["_encstr_8AEF05472BC2D6"])) {
    foreach(var_2 in level.objectives) {
      if(var_2 == self) {
        continue;
      }
      var_2 scripts\mp\gameobjects::disableobject();
    }
  }

  _encstr_A9042687EF43D3E804AA982892B7981F6A5F311B3B5AA64A27C638663EAFB0C6B38F8DBB2AC26EE0::bombzone_onuseplantobject(var_0);
}

onbombexploded(var_0, var_1, var_2, var_3, var_4) {
  if(var_3 == game["_encstr_991C0AB9ED5B57161FE89B83"]) {
    setgameendtime(0);
    wait 3;
    sd_endgame(game["_encstr_991C0AB9ED5B57161FE89B83"], game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_ABCA11472C9C3B56E8BE3295CD1D93B7E5CA91"]);
  } else {
    wait 1.5;
    setgameendtime(0);
    sd_endgame(game["_encstr_B6A70A23CA6659DC91CAE4DC"], game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_ACA10DAE80E31A1FC960CB8FF8C11C"]);
  }
}

setspecialloadout() {
  if(isusingmatchrulesdata() && scripts\mp\utility\game::getmatchrulesdatawithteamandindex("_encstr_84300F8DA55BE923D593C180FA2AE7A1D7", game["_encstr_991C0AB9ED5B57161FE89B83"], 5, "_encstr_959506B911C79707", "_encstr_8C8F065F255DC395"))
    level.sd_loadout[game["_encstr_991C0AB9ED5B57161FE89B83"]] = scripts\mp\utility\game::getmatchrulesspecialclass(game["_encstr_991C0AB9ED5B57161FE89B83"], 5);
}

dogtagallyonusecb(var_0) {
  var_0 scripts\mp\utility\stats::setextrascore1(var_0.pers["_encstr_8294083A0938C3CB2577"]);
}