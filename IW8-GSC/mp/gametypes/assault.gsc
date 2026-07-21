/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\assault.gsc
***********************************************/

main() {
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  var_0[0] = scripts\mp\utility\game::getgametype();
  var_0[1] = "_encstr_B807035284";
  var_0[2] = "_encstr_979A09DA67D0262B70CD82";
  var_0[3] = "_encstr_A65908C41BED1BD62B4E";
  scripts\mp\gameobjects::main(var_0);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 1, 0, 9);
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 3.0);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 3);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  }

  var_1 = scripts\mp\utility\dvars::getwatcheddvar("_encstr_8B250A53848DC8D17A472BE9");
  scripts\mp\utility\dvars::registerwatchdvarint("_encstr_8F1C11C995299F064DB8BAC3309D3F0B608955", var_1);
  updategametypedvars();
  level.objectivebased = 1;
  level.teambased = 1;
  level.nobuddyspawns = 1;
  level.onprecachegametype = ::onprecachegametype;
  level.onstartgametype = ::onstartgametype;
  level.getspawnpoint = ::getspawnpoint;
  level.modeonspawnplayer = ::onspawnplayer;
  level.onplayerkilled = ::onplayerkilled;
  level.ontimelimit = ::ontimelimit;
  level.onnormaldeath = ::onnormaldeath;
  level.onobjectivecomplete = ::onobjectivecomplete;
  level.resetuiomnvargamemode = _encstr_A9042687EF43D3E804AA982892B7981F6A5F311B3B5AA64A27C638663EAFB0C6B38F8DBB2AC26EE0::resetuiomnvargamemode;
  level.allowlatecomers = 0;
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_95240C659372588E43623137DE6C"] = "_encstr_ADEB0C27227298E09388E4239D07";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_93420C4255FBEA5D408FD1FD2A62"] = "_encstr_91200B458012D6016F90DA1EBA";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A3C70A9AF1EFF3B108AF0BF4"] = "_encstr_A3BA05E0735C50";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A3FC0AB4B179212963F905F2"] = "_encstr_A3BA05E0735C50";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A2E60BEA819FA3E19883233585"] = "_encstr_A3BA05E0735C50";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AD68071BF6B9A3BE0B"] = "_encstr_AD68071BF6B9A3BE0B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_976807690FAFEBD7F6"] = "_encstr_976807690FAFEBD7F6";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AA68071BD0C3C4417F"] = "_encstr_AA68071BD0C3C4417F";
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  var_0 = getmatchrulesdata("_encstr_8DD20CA127589E1FF95B98F26347", "_encstr_8B7F0CC9F6BA7319132BB9EC3A86");
  setdynamicdvar("_encstr_868B16B8AF52F6DB23D2B745EDAB5F5BA10F80F82F1548B9", var_0);
  scripts\mp\utility\game::registertimelimitdvar("_encstr_AB3508737F830710ACDB", var_0);
  var_1 = getmatchrulesdata("_encstr_8DD20CA127589E1FF95B98F26347", "_encstr_AB460CD345D5D095996F6B294752");
  setdynamicdvar("_encstr_BD1B18CB7F2869477EA3C28B68D5879A68CB5E24B7D82C5B2EB8", var_1);
  scripts\mp\utility\game::registerroundswitchdvar("_encstr_AB3508737F830710ACDB", var_1, 0, 9);
  var_2 = getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_B6FB0B93B87F020F1C3BE5E94D");
  setdynamicdvar("_encstr_9A32159BAA021F8967C30705A4033607ACE27068E21CB1", var_2);
  scripts\mp\utility\game::registerwinlimitdvar("_encstr_AB3508737F830710ACDB", var_2);
  setdynamicdvar("_encstr_8D4616AFE0F369BA474AC82BC0C47851C2D2A2FBFB7DFFF2", getmatchrulesdata("_encstr_8DD20CA127589E1FF95B98F26347", "_encstr_912A0A13AF7D41A192A545D6"));
  setdynamicdvar("_encstr_ABF8166E8D93AFC29B3785D563E8F5E0D885CD1D475A5BB2", getmatchrulesdata("_encstr_8DD20CA127589E1FF95B98F26347", "_encstr_85980AF3784743E3A1DB7D7D"));
  setdynamicdvar("_encstr_8B1D178750030F42BFE63E33416979FC0980171FC87B61CAFB", getmatchrulesdata("_encstr_8DD20CA127589E1FF95B98F26347", "_encstr_87B30B90E22F53D3579C7B6185"));
  setdynamicdvar("_encstr_A7E416187860C7E236FA7F0351E391554DB3FDE886C821FE", getmatchrulesdata("_encstr_8DD20CA127589E1FF95B98F26347", "_encstr_AD4D0AD6AB368E5A24EDDA31"));
  setdynamicdvar("_encstr_99B41B4BFFA8E9C7FE23420BE855071EE87BD2921B78AFDB35189A3233", getmatchrulesdata("_encstr_8DD20CA127589E1FF95B98F26347", "_encstr_B6CA0FC4EDDA3149CA372B47A82DB5959C"));
  setdynamicdvar("_encstr_8E4E17B30EF3C7EE5730B2CBF061A9BB88ED265C1138B7B431", 0);
  scripts\mp\utility\game::registerroundlimitdvar("_encstr_AB3508737F830710ACDB", 0);
  setdynamicdvar("_encstr_9104171BB71B4F917AC869D57A33C7AA8EEF703B61176B2831", 1);
  scripts\mp\utility\game::registerscorelimitdvar("_encstr_AB3508737F830710ACDB", 1);
  setdynamicdvar("_encstr_9A8A15CD8DE4F558B96E85AB36E8AF1A0BD866E82DD659", 0);
  scripts\mp\utility\game::registerhalftimedvar("_encstr_AB3508737F830710ACDB", 0);
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
  level._effect["_encstr_9A8C0F89BDDA26D7B20FC163B7E6B4DB73"] = loadfx("_encstr_B6F42B9E9FCBAE0CD8C23829EBC1635B8797C0FF2802D7C77BD340067187115D803184BE9535896889EA9B0AC3");
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
  setspecialloadout();
  thread initializeobjectives();
}

initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addstartspawnpoints("_encstr_AADB20C703E90A9312B6A318438942F3C997F81130C52B2BCA50DD4D9F426B4FBA6D");
  scripts\mp\spawnlogic::addstartspawnpoints("_encstr_BD1920D55941E60F7EE1831A6B40371A18CF5E1F9948EF1FA8399AC316AEE316F861");
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  level.assaultspawns = [];
  initbombsitespawns("_encstr_AA7B09475984AF0F6F0F0B");
  initbombsitespawns("_encstr_8E460991ACCC59378C56C9");
}

initbombsitespawns(var_0) {
  level.assaultspawns[var_0] = [];
  var_1 = "_encstr_9A81129A712F9176FB9BBB4814D646331F03FBF1" + var_0;
  var_2 = scripts\mp\spawnlogic::getspawnpointarray(var_1);

  foreach(var_4 in var_2) {
    var_5 = var_4.script_noteworthy;

    if(!isDefined(level.assaultspawns[var_0][var_5]))
      level.assaultspawns[var_0][var_5] = [];

    level.assaultspawns[var_0][var_5][level.assaultspawns[var_0][var_5].size] = var_4;
  }
}

getspawnpoint() {
  var_0 = self.pers["_encstr_8AEF05472BC2D6"];
  var_1 = "_encstr_8E460991ACCC59378C56C9";

  if(var_0 == game["_encstr_991C0AB9ED5B57161FE89B83"])
    var_1 = "_encstr_AA7B09475984AF0F6F0F0B";

  if(level.ingraceperiod) {
    var_2 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_9A81129A712F9176FB9BBB4814D646331F03FBF1" + var_1 + "_encstr_B4810709B378B9F3F5");
    var_3 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_2);
  } else {
    var_4 = level.curobj.label;
    var_5 = level.assaultspawns[var_1][var_4];
    var_3 = scripts\mp\spawnlogic::getspawnpoint_random(var_5);
  }

  return var_3;
}

onspawnplayer() {
  if(scripts\mp\utility\entity::isgameparticipant(self)) {
    self.isplanting = 0;
    self.isdefusing = 0;
    self.isbombcarrier = 0;
  }

  if(level.multibomb && self.pers["_encstr_8AEF05472BC2D6"] == game["_encstr_991C0AB9ED5B57161FE89B83"])
    self setclientomnvar("_encstr_845A1183746F28871B8BBB83E312C068E7CDE9", 1);
  else
    self setclientomnvar("_encstr_845A1183746F28871B8BBB83E312C068E7CDE9", 0);

  scripts\mp\utility\stats::setextrascore0(0);

  if(isDefined(self.pers["_encstr_8FB00783D8C2CDE8DC"]))
    scripts\mp\utility\stats::setextrascore0(self.pers["_encstr_8FB00783D8C2CDE8DC"]);

  level notify("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  setuppingwatcher();
  var_0 = getdvarint("_encstr_AB51136ED893D70BD8D8F677D7A15ACE0DD4D5B583");
  self allowhighjump(var_0);
  self allowhighjump(var_0);
  self allowboostjump(var_0);
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
  foreach(var_3 in level.players) {
    if(!isai(var_3))
      var_3 setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", 0);
  }

  level.finalkillcam_winner = var_0;

  if(var_1 == game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_ABCA11472C9C3B56E8BE3295CD1D93B7E5CA91"] || var_1 == game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_ACA10DAE80E31A1FC960CB8FF8C11C"]) {
    if(!isDefined(level.finalkillcam_killcamentityindex[var_0]) || level.finalkillcam_killcamentityindex[var_0] != level.curobj.killcamentnum)
      scripts\mp\final_killcam::erasefinalkillcam();
  }

  thread scripts\mp\gamelogic::endgame(var_0, var_1);
}

onnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5) {
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
  level.bombresettimer = scripts\mp\utility\dvars::dvarintvalue("_encstr_B6CA0FC4EDDA3149CA372B47A82DB5959C", 60, 0, 180);
}

setspecialloadout() {
  if(isusingmatchrulesdata() && scripts\mp\utility\game::getmatchrulesdatawithteamandindex("_encstr_84300F8DA55BE923D593C180FA2AE7A1D7", game["_encstr_991C0AB9ED5B57161FE89B83"], 5, "_encstr_959506B911C79707", "_encstr_8C8F065F255DC395"))
    level.sd_loadout[game["_encstr_991C0AB9ED5B57161FE89B83"]] = scripts\mp\utility\game::getmatchrulesspecialclass(game["_encstr_991C0AB9ED5B57161FE89B83"], 5);
}

isplayeroutsideofcurbombsite(var_0) {
  if(isDefined(level.curbombzone))
    return self istouching(level.curbombzone.trigger);

  return 0;
}

initializeobjectives() {
  level.firsttimebomb = 1;
  var_0 = getEntArray("_encstr_979A09DA67D0262B70CD82", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.objectives = var_0;
  level.curobjectiveindex = 0;
  level.curobj = setupnextobjective(level.curobjectiveindex);
}

setupnextobjective(var_0) {
  var_1 = level.objectives[var_0];
  var_2 = var_1.script_noteworthy;

  if(!isDefined(var_2))
    var_2 = "_encstr_979A09DA67D0262B70CD82";

  var_3 = undefined;

  switch (var_2) {
    case "_encstr_979A09DA67D0262B70CD82":
      if(isDefined(level.firsttimebomb)) {
        _encstr_A9042687EF43D3E804AA982892B7981F6A5F311B3B5AA64A27C638663EAFB0C6B38F8DBB2AC26EE0::bombzone_setupbombcase("_encstr_9B1308E20DFF6227E040");
        level.firsttimebomb = undefined;
      } else
        _encstr_A9042687EF43D3E804AA982892B7981F6A5F311B3B5AA64A27C638663EAFB0C6B38F8DBB2AC26EE0::advancebombcase();

      var_3 = _encstr_A9042687EF43D3E804AA982892B7981F6A5F311B3B5AA64A27C638663EAFB0C6B38F8DBB2AC26EE0::setupobjective(var_0);
      scripts\mp\utility\dialog::leaderdialog("_encstr_95240C659372588E43623137DE6C", game["_encstr_991C0AB9ED5B57161FE89B83"]);
      scripts\mp\utility\dialog::leaderdialog("_encstr_93420C4255FBEA5D408FD1FD2A62", game["_encstr_B6A70A23CA6659DC91CAE4DC"]);
      break;
    case "_encstr_ABED0902389B228718185C":
      var_3 = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::setupobjective(level.objectives[var_0]);
      break;
    case "_encstr_A1D0081CC297B1EDB08C":
      break;
    case "_encstr_8E1904B3F501":
      break;
  }

  return var_3;
}

onobjectivecomplete(var_0, var_1, var_2, var_3, var_4) {
  switch (var_0) {
    case "_encstr_ABED0902389B228718185C":
      ondompointobjectivecomplete(var_1, var_2, var_3, var_4);
      break;
    case "_encstr_979A09DA67D0262B70CD82":
      onbombzoneobjectivecomplete(var_1, var_2, var_3, var_4);
      break;
  }

  if(var_3 == game["_encstr_991C0AB9ED5B57161FE89B83"]) {
    level.curobjectiveindex++;

    if(level.curobjectiveindex < level.objectives.size) {
      var_5 = scripts\mp\utility\dvars::getwatcheddvar("_encstr_8F1C11C995299F064DB8BAC3309D3F0B608955");
      scripts\mp\utility\dvars::setoverridewatchdvar("_encstr_8B250A53848DC8D17A472BE9", scripts\mp\utility\game::gettimelimit() + var_5);
      restarttimer();
      level.curobj = setupnextobjective(level.curobjectiveindex);
    } else {
      setgameendtime(0);
      wait 3;
      sd_endgame(game["_encstr_991C0AB9ED5B57161FE89B83"], game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_ABCA11472C9C3B56E8BE3295CD1D93B7E5CA91"]);
    }
  }
}

ondompointobjectivecomplete(var_0, var_1, var_2, var_3) {
  var_4 = var_1.team;

  if(var_3 == "_encstr_A7A408B9CA5D1D4E2C63") {
    var_5 = scripts\mp\utility\game::getotherteam(var_4)[0];
    thread scripts\mp\utility\print::printandsoundoneveryone(var_4, var_5, undefined, undefined, "_encstr_AF841588B30FD127CB0E030550B7FEB7F82ACBD80E0DC1", undefined, var_1);
    scripts\mp\utility\dialog::statusdialog("_encstr_AAE70838F27E43E327DC" + self.label, var_4, 1);
    scripts\mp\utility\dialog::statusdialog("_encstr_97B70613D8CBDC59" + self.label, var_5, 1);
  }
}

onbombzoneobjectivecomplete(var_0, var_1, var_2, var_3) {
  if(var_2 == game["_encstr_B6A70A23CA6659DC91CAE4DC"]) {
    restarttimer();
    thread _encstr_A9042687EF43D3E804AA982892B7981F6A5F311B3B5AA64A27C638663EAFB0C6B38F8DBB2AC26EE0::respawnbombcase();
    level.curobj = _encstr_A9042687EF43D3E804AA982892B7981F6A5F311B3B5AA64A27C638663EAFB0C6B38F8DBB2AC26EE0::setupobjective(level.curobjectiveindex);
  }
}

restarttimer() {
  scripts\mp\gamelogic::resumetimer();
  level.timepaused = gettime() - level.timepausestart;
  level.timelimitoverride = 0;
}

setuppingwatcher() {
  if(isai(self)) {
    return;
  }
  self notifyonplayercommand("_encstr_83A20B83C6C2BCAC93824B9B9D", "_encstr_977F0F954CE4B20BE8867D9B07935A37D1");
  thread waitforplayerping();
}

waitforplayerping() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self waittill("_encstr_83A20B83C6C2BCAC93824B9B9D");

    if(scripts\mp\utility\player::isreallyalive(self) && !scripts\mp\utility\player::isusingremote()) {
      if(self adsButtonPressed()) {
        doping();
        wait 0.5;
      }
    }

    wait 0.1;
  }
}

doping() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = self getEye();
  var_1 = var_0 + anglesToForward(self getplayerangles()) * 2000;
  var_2 = scripts\engine\trace::ray_trace(var_0, var_1, self);
  var_3 = var_2["_encstr_850E077B0BF30318B9"];
  var_4 = "_encstr_9372093987D977E7E0FD4D";
  var_5 = (1, 1, 1);

  if(isDefined(var_3)) {
    if(isDefined(var_3.team) && var_3.team != self.team) {
      var_5 = (1, 0, 0);

      if(isPlayer(var_3)) {
        var_4 = "_encstr_ABD70579E3D10C";
        self notify("_encstr_8C060E1DA550256728E302EAA8952FDF");
      } else
        var_4 = "_encstr_AFCB0828C5C623E20133";
    } else if(isDefined(var_3.script_gameobjectname)) {
      if(var_3.script_gameobjectname == "_encstr_979A09DA67D0262B70CD82") {
        if(self.team == game["_encstr_991C0AB9ED5B57161FE89B83"]) {
          var_4 = "_encstr_999A07CE1739D9A02A";
          var_5 = (1, 1, 0);
        } else {
          var_4 = "_encstr_A20C072BB314607E09";
          var_5 = (0, 0, 1);
        }
      } else if(var_3.script_gameobjectname == "_encstr_B807035284") {
        if(self.team == game["_encstr_991C0AB9ED5B57161FE89B83"]) {
          var_4 = "_encstr_9A2B0A10F1758FD75F6B9E85";
          var_5 = (1, 1, 0);
        }
      }
    }
  }
}