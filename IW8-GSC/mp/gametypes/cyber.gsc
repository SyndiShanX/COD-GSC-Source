/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\cyber.gsc
***********************************************/

main() {
  if(getDvar("_encstr_9570084B1793A090CDFF") == "_encstr_8D510E52E3A7C6985EB7B9BE2F35C690") {
    return;
  }
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  var_0[0] = scripts\mp\utility\game::getgametype();
  var_0[1] = "_encstr_A65908C41BED1BD62B4E";
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
  }

  updategametypedvars();
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
  level.onexfilstarted = ::onexfilstarted;
  level.resetuiomnvargamemode = _encstr_A9042687EF43D3E804AA982892B7981F6A5F311B3B5AA64A27C638663EAFB0C6B38F8DBB2AC26EE0::resetuiomnvargamemode;
  level.emplightsoff = ::emplightsoff;
  level.allowlatecomers = 0;
  level.bombplanted = 0;
  level.bombplantedteam = undefined;
  level.bombexploded = 0;
  game["_encstr_AD3F0EB158739AC6EDE456F43751B495"] = 1;
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_A6AF150490C707ADA0A1FDF93BAB13054DDE33A4D9F3D4";

  if(getdvarint("_encstr_B2020AE1F36BF74429D93F01"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_8A19042AB017" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];
  else if(getdvarint("_encstr_82570B397A4D3192935192A562"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_979708CC69F02253FF26" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];

  if(!isDefined(game["_encstr_8DC30DAA0285FD69FAE113371B1934"]))
    var_1 = "_encstr_AA0B124CB77BDCE8AF1B2F2656C9858E47B0D8B5";
  else
    var_1 = "_encstr_8E4D18AECF1FCB41798270D09A4A23632B69A692678750AF1ADB";

  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_95240C659372588E43623137DE6C"] = var_1;
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_93420C4255FBEA5D408FD1FD2A62"] = var_1;
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B8561335DD8361501BDFC0E027360BEB7A853DC9B0"] = "_encstr_B8561335DD8361501BDFC0E027360BEB7A853DC9B0";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_87761995DAE00E2DC65BD51C7D339CB4599B32D8CBAFCC9693CDA3"] = "_encstr_87761995DAE00E2DC65BD51C7D339CB4599B32D8CBAFCC9693CDA3";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_84A41021D5E01023AA0F4351C792F8F085A8"] = "_encstr_84A41021D5E01023AA0F4351C792F8F085A8";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_93861495ADC1235633D56EAC91D7CC4EA52BB99163E5"] = "_encstr_93861495ADC1235633D56EAC91D7CC4EA52BB99163E5";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_82B71A78824A91F1FB1DD6C5E4F7597335AAA8218A62C389833451C3"] = "_encstr_82B71A78824A91F1FB1DD6C5E4F7597335AAA8218A62C389833451C3";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_ACD6114D912BB347D5B83B52D84FBF636109C9"] = "_encstr_ACD6114D912BB347D5B83B52D84FBF636109C9";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A25C1718E22AF191DB3DF6E50417B953158AC8419A453BA8FF"] = "_encstr_A25C1718E22AF191DB3DF6E50417B953158AC8419A453BA8FF";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_87E51456DA83C11BB0DCE8CAC8F59993A5CA7391D8E5"] = "_encstr_87E51456DA83C11BB0DCE8CAC8F59993A5CA7391D8E5";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_87C8115F13FFC3ACB078B3FF1169ED9ADDBBB7"] = "_encstr_87C8115F13FFC3ACB078B3FF1169ED9ADDBBB7";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A3C70A9AF1EFF3B108AF0BF4"] = "_encstr_A3BA05E0735C50";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A2E60BEA819FA3E19883233585"] = "_encstr_A3BA05E0735C50";
  setomnvar("_encstr_A55A105862213D10B76AA0A641E37B93177B", -1);
  setomnvar("_encstr_8AAD13574BF54CB7DAC4EBDEBBB959C9BE1D9516B6", -1);
  setomnvar("_encstr_9131145D2DFA31DBD698BED2B9E82B4E581B8EA5B9EC", 0);
  setomnvar("_encstr_950418EAD2F5C47BAD13AFD14BDAB2E4BEACCD231D2DD6B2D70B", 0);
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("_encstr_B8A213C0C63A894AEBC057EA4E9885C3F09B61F7B5", getmatchrulesdata("_encstr_A9E40A21402A37E259D0B456", "_encstr_97E4095FA0C383D31B647D"));
  setdynamicdvar("_encstr_9B6A18EB7FBB8E7E77D647BAE7D3898CF9EB975B70BCABF413CA", getmatchrulesdata("_encstr_A9E40A21402A37E259D0B456", "_encstr_8FE50EA3A9B50F12114BCECF19F09D47"));
  setdynamicdvar("_encstr_8CC1189BB19CBED82F13599CD71C9527B94CBDB526D12DD6594E", getmatchrulesdata("_encstr_A9E40A21402A37E259D0B456", "_encstr_B67A0E1CAC27CD24DBB698A24BB6CAE4"));
  setdynamicdvar("_encstr_BE2E182BE61B2F96BB506A13D1E94FDB10D881A40DC3175D9570", getmatchrulesdata("_encstr_A9E40A21402A37E259D0B456", "_encstr_BDE90E11CA4B20E0D6FC4BDF13BDC8FD"));
  setdynamicdvar("_encstr_AC9C18EA86DDC9236A58C79399C116D24B23B7E77F097264F028", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_923F0EBB1E376BDB730A79C3C20B9838"));
  setdynamicdvar("_encstr_AABA14C862CAE731870ADD4EDF03787B36FB80B0BA62", getmatchrulesdata("_encstr_ACED09DB8FF96A0C48B36E", "_encstr_912A0A13AF7D41A192A545D6"));
  setdynamicdvar("_encstr_B4C414BBE21B60D098A27355F782F037C32BD360EABF", getmatchrulesdata("_encstr_ACED09DB8FF96A0C48B36E", "_encstr_85980AF3784743E3A1DB7D7D"));
  setdynamicdvar("_encstr_8A92158BAB6B995A2B3A754B815BAA10F3DB98B35C45A2", getmatchrulesdata("_encstr_ACED09DB8FF96A0C48B36E", "_encstr_87B30B90E22F53D3579C7B6185"));
  setdynamicdvar("_encstr_A1421406669B07D9C9238808EFE5D3A9230C76807D32", getmatchrulesdata("_encstr_ACED09DB8FF96A0C48B36E", "_encstr_AD4D0AD6AB368E5A24EDDA31"));
  setdynamicdvar("_encstr_8A9A1B4EFF9A41917FF9DD0BB06319652B7502E720D3B79965FB9F6DDE", getmatchrulesdata("_encstr_AA0E0AC857A2833B80E68D1F", "_encstr_AF3F11AE30F788BD866368D8E7575B8A40125B"));
  setdynamicdvar("_encstr_A140189BC6E4AF8D9713B2C97DA519C656922B372B8EA8B46B59", getmatchrulesdata("_encstr_AA0E0AC857A2833B80E68D1F", "_encstr_83FA0E968C63594A9537B2A38A96D6CA"));
  setdynamicdvar("_encstr_9AD015721E5541DB92D05F1B21EB99CADFAD3A23F3833A", getmatchrulesdata("_encstr_AA0E0AC857A2833B80E68D1F", "_encstr_B6460B9363B348F07F0B43053F"));
  setdynamicdvar("_encstr_BD621393CA3358E8B08A2B3D8FDCB0993BD3A8D832", 0);
  scripts\mp\utility\game::registerhalftimedvar("_encstr_ACF906B79752C5E8", 0);
}

waittooverridegraceperiod() {
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  level.overrideingraceperiod = 1;
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
  level._effect["_encstr_AF160F08F23A97A1A74C8870318B48AFE5"] = loadfx("_encstr_A16C30562C12A64CFFCAF12A70B787176B03D8F535B8B385F3480B06680DB8F7C1F9404F59E10F1DDF28D2FA5871E59BD9DB");
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
  cyberattack();
  initspawns();
  thread _id_13862();
  thread waittooverridegraceperiod();
  setupwaypointicons();
}

updategametypedvars() {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::updatecommongametypedvars();
  level.empspawnindex = scripts\mp\utility\dvars::dvarintvalue("_encstr_97E4095FA0C383D31B647D", 0, 0, 4);
  level.radarpingtime = 4;
  level.persbombtimer = scripts\mp\utility\dvars::dvarintvalue("_encstr_B67A0E1CAC27CD24DBB698A24BB6CAE4", 0, 0, 1);
  level.detonatescore = scripts\mp\utility\dvars::dvarintvalue("_encstr_BDE90E11CA4B20E0D6FC4BDF13BDC8FD", 1, 0, 5);
  level.bombtimer = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_912A0A13AF7D41E192A545D6", 30, 1, 300);
  level.planttime = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_85980AF3784743E3A0DB7D7D", 1, 0, 20);
  level.defusetime = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_87B30B90E22F53D357BC7B6185", 1, 0, 20);
  level.multibomb = scripts\mp\utility\dvars::dvarintvalue("_encstr_AD4D0AD6AB368E5A26EDDA31", 0, 0, 1);
  level.showenemycarrier = scripts\mp\utility\dvars::dvarintvalue("_encstr_AF3F11AE30F788BD866368D8E7575B8A40125B", 5, 0, 6);
  level.idleresettime = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_83FA0E968C63594A9537B2A38A96D6CA", 0, 0, 60);
  level.pickuptime = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_B6460B9363B348F07F0B43053F", 0, 0, 10);
}

initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addspawnpoints(game["_encstr_991C0AB9ED5B57161FE89B83"], "_encstr_BD801668DA97D073F24F05573FFBB7A84EF911C04519A82E");
  scripts\mp\spawnlogic::addspawnpoints(game["_encstr_B6A70A23CA6659DC91CAE4DC"], "_encstr_BD801468DA97D073F24F05573FFBB7A84EF911420403");
  var_0 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_BD801668DA97D073F24F05573FFBB7A84EF911C04519A82E");
  var_1 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_BD801468DA97D073F24F05573FFBB7A84EF911420403");
  scripts\mp\spawnlogic::registerspawnset("_encstr_8203101FF33885AB060225CD31A68A4B6AD7", var_0);
  scripts\mp\spawnlogic::registerspawnset("_encstr_9AE3109755F34D5879256960F390C8FFD207", var_1);
  scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_8EE60D40EB97564047873729A16BD8");
  scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_8EE60D40EB97564047873729A16BD8");

  if(scripts\mp\utility\game::getgametypenumlives() != 1) {
    assignteamspawns();
    level.introcinematic["_encstr_9A8507BA4040188D08"] = "_encstr_9A8507BA4040188D08";
    level.introcinematic["_encstr_8E8405EA382B2A"] = "_encstr_8E8405EA382B2A";
    scripts\mp\spawnlogic::registerspawnset("_encstr_9A8507BA4040188D08", level.teamspawnpoints["_encstr_9A8507BA4040188D08"]);
    scripts\mp\spawnlogic::registerspawnset("_encstr_8E8405EA382B2A", level.teamspawnpoints["_encstr_8E8405EA382B2A"]);
    scripts\mp\spawnlogic::registerspawnset("_encstr_A7A408B9CA5D1D4E2C63", level.teamspawnpoints["_encstr_A7A408B9CA5D1D4E2C63"]);
  }

  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

getspawnpoint() {
  scripts\mp\spawnlogic::setactivespawnlogic("_encstr_8AEF0B35A3C227D19A38C2BBCD", "_encstr_829A0D0F1AF8FB5ED127855073F940");
  var_0 = self.pers["_encstr_8AEF05472BC2D6"];

  if(scripts\mp\utility\game::getgametypenumlives() != 1) {
    if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
      if(var_0 == game["_encstr_991C0AB9ED5B57161FE89B83"]) {
        scripts\mp\spawnlogic::activatespawnset("_encstr_8203101FF33885AB060225CD31A68A4B6AD7", 1);
        var_1 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, undefined, "_encstr_8203101FF33885AB060225CD31A68A4B6AD7");
      } else {
        scripts\mp\spawnlogic::activatespawnset("_encstr_9AE3109755F34D5879256960F390C8FFD207", 1);
        var_1 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, undefined, "_encstr_9AE3109755F34D5879256960F390C8FFD207");
      }
    } else
      var_1 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, level.introcinematic[var_0], "_encstr_A7A408B9CA5D1D4E2C63");
  } else if(var_0 == game["_encstr_991C0AB9ED5B57161FE89B83"]) {
    scripts\mp\spawnlogic::activatespawnset("_encstr_8203101FF33885AB060225CD31A68A4B6AD7", 1);
    var_1 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, undefined, "_encstr_8203101FF33885AB060225CD31A68A4B6AD7");
  } else {
    scripts\mp\spawnlogic::activatespawnset("_encstr_9AE3109755F34D5879256960F390C8FFD207", 1);
    var_1 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, undefined, "_encstr_9AE3109755F34D5879256960F390C8FFD207");
  }

  return var_1;
}

assignteamspawns() {
  level.spawnnodetype = "_encstr_8EE60D40EB97564047873729A16BD8";
  var_0 = scripts\mp\spawnlogic::getspawnpointarray(level.spawnnodetype);
  var_1 = scripts\mp\spawnlogic::ispathdataavailable();
  level.teamspawnpoints["_encstr_8E8405EA382B2A"] = [];
  level.teamspawnpoints["_encstr_9A8507BA4040188D08"] = [];
  level.teamspawnpoints["_encstr_A7A408B9CA5D1D4E2C63"] = [];

  if(level.objectives.size == 2) {
    var_2 = level.objectives["_encstr_8E8405EA382B2A"];
    var_3 = level.objectives["_encstr_9A8507BA4040188D08"];
    var_4 = (var_2.curorigin[0], var_2.curorigin[1], 0);
    var_5 = (var_3.curorigin[0], var_3.curorigin[1], 0);
    var_6 = var_5 - var_4;
    var_7 = length2d(var_6);

    foreach(var_9 in var_0) {
      var_10 = (var_9.origin[0], var_9.origin[1], 0);
      var_11 = var_10 - var_4;
      var_12 = vectordot(var_11, var_6);
      var_13 = var_12 / (var_7 * var_7);

      if(var_13 < 0.33) {
        var_9.teambase = var_2.ownerteam;
        level.teamspawnpoints[var_9.teambase][level.teamspawnpoints[var_9.teambase].size] = var_9;
        continue;
      }

      if(var_13 > 0.67) {
        var_9.teambase = var_3.ownerteam;
        level.teamspawnpoints[var_9.teambase][level.teamspawnpoints[var_9.teambase].size] = var_9;
        continue;
      }

      var_14 = undefined;
      var_15 = undefined;

      if(var_1)
        var_14 = getpathdist(var_9.origin, var_2.curorigin, 999999);

      if(isDefined(var_14) && var_14 != -1)
        var_15 = getpathdist(var_9.origin, var_3.curorigin, 999999);

      if(!isDefined(var_15) || var_15 == -1) {
        var_14 = distance2d(var_2.curorigin, var_9.origin);
        var_15 = distance2d(var_3.curorigin, var_9.origin);
      }

      var_16 = max(var_14, var_15);
      var_17 = min(var_14, var_15);
      var_18 = var_17 / var_16;

      if(var_18 > 0.5)
        level.teamspawnpoints["_encstr_A7A408B9CA5D1D4E2C63"][level.teamspawnpoints["_encstr_A7A408B9CA5D1D4E2C63"].size] = var_9;
    }
  } else {
    foreach(var_9 in var_0) {
      var_9.teambase = reset_doors(var_9);

      if(var_9.teambase == "_encstr_8E8405EA382B2A") {
        level.teamspawnpoints["_encstr_8E8405EA382B2A"][level.teamspawnpoints["_encstr_8E8405EA382B2A"].size] = var_9;
        continue;
      }

      level.teamspawnpoints["_encstr_9A8507BA4040188D08"][level.teamspawnpoints["_encstr_9A8507BA4040188D08"].size] = var_9;
    }
  }
}

reset_doors(var_0) {
  var_1 = scripts\mp\spawnlogic::ispathdataavailable();
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_5 in level.objectives) {
    var_6 = undefined;

    if(var_1)
      var_6 = getpathdist(var_0.origin, var_5.curorigin, 999999);

    if(!isDefined(var_6) || var_6 == -1)
      var_6 = distancesquared(var_5.curorigin, var_0.origin);

    if(!isDefined(var_2) || var_6 < var_3) {
      var_2 = var_5;
      var_3 = var_6;
    }
  }

  return scripts\mp\utility\game::getotherteam(var_2.ownerteam)[0];
}

cyberattack() {
  var_0 = getEntArray("_encstr_BE8D16A62BEA2DED5168AD8AC923D87222E7631750ABA481", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_0.size == 0) {
    scripts\engine\utility::error("_encstr_9A2A57E498A1063F997DBA9F05AD634169305AEAE0D9F1C3B353B798A5CBCF97FF38D3E3B25DB59FE8CDF8D9B059875E39DA7E497823EE4FE10782DDDC312BA453D80683F801E31BD93F84C56CA1737EE1F0BBAAD0451F3B58");
    return;
  }

  if(level.empspawnindex == 3) {
    if(isDefined(game["_encstr_97E4095FA0C383D31B647D"])) {
      var_1 = [0, 1, 2];
      var_1 = scripts\engine\utility::array_remove(var_1, game["_encstr_97E4095FA0C383D31B647D"]);
      level.empspawnindex = scripts\engine\utility::random(var_1);
      game["_encstr_97E4095FA0C383D31B647D"] = level.empspawnindex;
    } else {
      level.empspawnindex = randomintrange(0, 3);
      game["_encstr_97E4095FA0C383D31B647D"] = level.empspawnindex;
    }
  }

  if(level.empspawnindex == 4) {
    if(isDefined(game["_encstr_97E4095FA0C383D31B647D"])) {
      level.empspawnindex = game["_encstr_97E4095FA0C383D31B647D"] + 1;

      if(level.empspawnindex == 3)
        level.empspawnindex = 0;

      game["_encstr_97E4095FA0C383D31B647D"] = level.empspawnindex;
    } else {
      level.empspawnindex = 0;
      game["_encstr_97E4095FA0C383D31B647D"] = level.empspawnindex;
    }
  }

  var_2 = var_0[level.empspawnindex];
  var_3 = getEntArray("_encstr_889B0A6C97315993EB566B83", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_4[0] = var_3[level.empspawnindex];

  if(!isDefined(var_4[0])) {
    scripts\engine\utility::error("_encstr_ADA74F72DE101B9726ACE4AF59B61C80DC8DE4D2C1E8F5DADB4695D802CCB7D5378C104BDC04AD0BC171010AB1AC0BDCB2402657B380D1432D6E4047BD8047865940D8B26756B10423AC374BD9B92B9CC5");
    return;
  }

  var_4[0] setModel("_encstr_B1B00F6FD637E8171BDA7E635207DD084A");
  var_4[0].origin = var_4[0].origin;
  var_5 = var_4[0].origin + (0, 0, 32);
  var_6 = var_4[0].origin + (0, 0, -100);
  var_7 = scripts\engine\trace::create_contents(1, 1, 1, 1, 1, 1, 1);
  var_8 = [var_4[0]];
  var_9 = scripts\engine\trace::ray_trace(var_5, var_6, var_8, var_7);

  if(var_9["_encstr_A53009A25003666B9818C6"] < 1)
    var_4[0].origin = var_9["_encstr_BD260953AA97E3F014279D"] + (0, 0, 2);

  var_4[0].angles = vectortoangles(var_9["_encstr_820E07FAE8780B3A4C"]) + (180, 0, 0);

  for(var_10 = 0; var_10 < var_3.size; var_10++) {
    if(var_10 == level.empspawnindex) {
      continue;
    }
    var_3[var_10] delete();
  }

  var_2 enablelinkTo();
  var_2 linkTo(var_4[0]);
  var_2.no_moving_platfrom_unlink = 1;
  var_2.linktoenabledflag = 1;
  var_2.baseorigin = var_2.origin;
  var_2.no_moving_platfrom_unlink = 1;

  if(!level.multibomb) {
    level.cyberemp = scripts\mp\gameobjects::createcarryobject("_encstr_A7A408B9CA5D1D4E2C63", var_2, var_4, (0, 0, 16), undefined, 1);
    level.cyberemp.cancontestclaim = 1;
    level.cyberemp.stalemate = 0;
    level.cyberemp.wasstalemate = 1;
    level.cyberemp scripts\mp\gameobjects::allowuse("_encstr_9A19040BCDBC");
    level.cyberemp.curprogress = 0;
    level.cyberemp.usetime = 0.05;
    level.cyberemp.userate = 1;
    level.cyberemp.id = "_encstr_B40101";
    level.cyberemp.exclusiveuse = 0;
    level.cyberemp.skiptouching = 1;
    level.cyberemp.skipminimapids = 1;
    level.cyberemp.onuse = ::emptriggerholdonuse;
    level.cyberemp.trigger setCursorHint("_encstr_829A0C23D4C1F35E818FDB4134BD");
    level.cyberemp.trigger setHintString(&"_encstr_AA83127583F8F3B50BB199CF367421A968A926E5");
    level.cyberemp.trigger setusepriority(-3);
    level.cyberemp scripts\mp\gameobjects::setusetime(level.cyberemp.usetime);
    level.cyberemp scripts\mp\gameobjects::setwaitweaponchangeonuse(0);
    level.cyberemp.allowweapons = 1;
    level.cyberemp.onpickup = ::onpickup;
    level.cyberemp.ondrop = ::ondrop;
    level.cyberemp.firstpickup = 1;
    level thread empsitewatcher();
    level.bombrespawnpoint = level.cyberemp.visuals[0].origin;
    level.bombrespawnangles = level.cyberemp.visuals[0].angles;
    level.cyberemp.visualgroundoffset = (0, 0, 2);
  } else {
    var_2 delete();
    var_4[0] delete();
  }

  if(!isDefined(getEnt("_encstr_A3D2131BF213B29CEB955B38E9BD73B2EB0B3C2DDC", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"))) {
    scripts\engine\utility::error("_encstr_83BF5306F041CF60FD180BD130CB1A13EDE8B59F1F922FAA21E8138A3827977B9144374D207952F45562EA02689D9E2BB0BD81C3CD4993BB7F7A038A987F56F308B71C4055A1D34735B88A0698BBFA7F610895D258");
    return;
  }

  if(!isDefined(getEnt("_encstr_A279151E7B0D9AA23EF0572B201066429F9F2555EBBBB3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"))) {
    scripts\engine\utility::error("_encstr_8A8F55FDDF66D6A0122F336ED7F520924A7313577FCA29782D8271033AA9E04442FB11BD2FE3E0D8201CA091E58990286EDB1133AF6B3DC29A738999CB784B3EC6D39FC11382F58ABC4F9309F518A07D2BCF77D5CF8BE8");
    return;
  }

  if(!isDefined(getEnt("_encstr_8FBB163A223E878AE1EB4540876017C3DD1BD261898B6F02", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"))) {
    scripts\engine\utility::error("_encstr_AA7D56D06FD0A7674B0F0B88D319E37FCAB12E3B4F2B58AEEB80ABFEA3D870E71AFAADF22DDFB3201D81A94D52AD73B07EE0325045B3C315D68A536ADA535084EB61B34712D5543F826B4A80BA0B2A2A525EEF6FF8898230");
    return;
  }

  if(!isDefined(getEnt("_encstr_84DD1842035A5A2BF82020715F88A949A3B8C367BA737217AD8E", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"))) {
    scripts\engine\utility::error("_encstr_85DF58E4B7046CCB9859C9BE955B07FA4695995D9BB2BE0B8D1B5A596E04E8274B9DCE56390299BDAE9BC8024BDC10B65883C50182632B0B37B20498BAD90147D0A53701E8DB02E81A2B021BCA6759C6801959E65A9DDC959C5C");
    return;
  }

  if(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]) {
    level.objectives["_encstr_9A8507BA4040188D08"] = createbombzone("_encstr_9A8507BA4040188D08", getEnt("_encstr_A3D2131BF213B29CEB955B38E9BD73B2EB0B3C2DDC", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"), getEnt("_encstr_8FBB163A223E878AE1EB4540876017C3DD1BD261898B6F02", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"));
    level.objectives["_encstr_8E8405EA382B2A"] = createbombzone("_encstr_8E8405EA382B2A", getEnt("_encstr_A279151E7B0D9AA23EF0572B201066429F9F2555EBBBB3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"), getEnt("_encstr_84DD1842035A5A2BF82020715F88A949A3B8C367BA737217AD8E", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"));
  } else {
    level.objectives["_encstr_9A8507BA4040188D08"] = createbombzone("_encstr_9A8507BA4040188D08", getEnt("_encstr_A279151E7B0D9AA23EF0572B201066429F9F2555EBBBB3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"), getEnt("_encstr_84DD1842035A5A2BF82020715F88A949A3B8C367BA737217AD8E", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"));
    level.objectives["_encstr_8E8405EA382B2A"] = createbombzone("_encstr_8E8405EA382B2A", getEnt("_encstr_A3D2131BF213B29CEB955B38E9BD73B2EB0B3C2DDC", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"), getEnt("_encstr_8FBB163A223E878AE1EB4540876017C3DD1BD261898B6F02", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"));
  }

  level notify("_encstr_95FC182BCD0B986359BE07C658E5B2C9AFD5378598D2B15AA3BC");
  level.objectives["_encstr_8E8405EA382B2A"] thread data_center_sfx_loop();
  level.objectives["_encstr_9A8507BA4040188D08"] thread data_center_sfx_loop();

  if(level.mapname == "_encstr_994B10FAA8973CA771A27E6D431E0F8635E0")
    thread destroytvs();
}

_id_13862() {
  if(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
    level scripts\engine\utility::_id_143A5("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B", "_encstr_8F55118F8B711B6436974A09E1173783D313D9");

  level.objectives["_encstr_9A8507BA4040188D08"] scripts\mp\gameobjects::requestid(1, 1);
  level.objectives["_encstr_9A8507BA4040188D08"] scripts\mp\gameobjects::setobjectivestatusicons("_encstr_A9A41DBB73AFD8A7C332E0B0CA1C8DD3171C35A4CD03415FAFDAA0A0C27343", "_encstr_8FDD1D18D0F22D574737B88A3A1333B41F51477A5C63EB119DC88BD77C800D");
  level.objectives["_encstr_9A8507BA4040188D08"] scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
  level.objectives["_encstr_8E8405EA382B2A"] scripts\mp\gameobjects::requestid(1, 1);
  level.objectives["_encstr_8E8405EA382B2A"] scripts\mp\gameobjects::setobjectivestatusicons("_encstr_A9A41DBB73AFD8A7C332E0B0CA1C8DD3171C35A4CD03415FAFDAA0A0C27343", "_encstr_8FDD1D18D0F22D574737B88A3A1333B41F51477A5C63EB119DC88BD77C800D");
  level.objectives["_encstr_8E8405EA382B2A"] scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
  level thread hidebombsitesaftermatchstart();
  level.cyberemp scripts\mp\gameobjects::requestid(1, 1);
  level.cyberemp scripts\mp\gameobjects::setobjectivestatusicons("_encstr_8B0D122DD87B73AFBB16970EBDD2CDA3D7CAADC1");
  level.cyberemp scripts\mp\gameobjects::_id_13172("_encstr_8DA01EB51B767DA5C6B7E6BEDD2CCBC17BD2378EBECADA38D71CD816DCA3B219");
  level.cyberemp scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");

  if(isDefined(level.cyberemp.visuals[0])) {
    level.cyberemp.visuals[0] _encstr_A9042687EF43D3E804AA982892B7981F6A5F311B3B5AA64A27C638663EAFB0C6B38F8DBB2AC26EE0::setteaminhuddatafromteamname("_encstr_A7A408B9CA5D1D4E2C63");
    level.cyberemp.visuals[0] setasgametypeobjective();
  }

  scripts\mp\objidpoolmanager::objective_set_play_intro(level.cyberemp.objidnum, 0);
  scripts\mp\objidpoolmanager::objective_set_play_outro(level.cyberemp.objidnum, 0);
  hastacvis(level.cyberemp.objidnum, 1);
  var_0 = scripts\mp\objidpoolmanager::requestobjectiveid(99);
  level.cyberemp.pingobjidnum = var_0;
  scripts\mp\objidpoolmanager::objective_add_objective(var_0, "_encstr_8267056410C669", level.cyberemp.origin);
  level.cyberemp scripts\mp\gameobjects::setvisibleteam("_encstr_8BBA05185F8B99", var_0);
  objective_setownerteam(var_0, undefined);
  level.cyberemp scripts\mp\gameobjects::_id_1317F("_encstr_973F1961B6E8BB2917F87BE3A0035D6B462DE3E3D8139BE1EB60F3", "_encstr_82FD166339ABDBC568F5446787404AB3D533DA69C00B63FD", "_encstr_8DA01EB51B767DA5C6B7E6BEDD2CCBC17BD2378EBECADA38D71CD816DCA3B219", var_0);
  setcarriervisibility();
}

hidebombsitesaftermatchstart() {
  if(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
    level waittill("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  scripts\mp\objidpoolmanager::objective_set_play_intro(level.objectives["_encstr_9A8507BA4040188D08"].objidnum, 0);
  scripts\mp\objidpoolmanager::objective_set_play_outro(level.objectives["_encstr_9A8507BA4040188D08"].objidnum, 0);
  scripts\mp\objidpoolmanager::_id_11F84(level.objectives["_encstr_9A8507BA4040188D08"].objidnum, 1);
  scripts\mp\objidpoolmanager::objective_set_play_intro(level.objectives["_encstr_8E8405EA382B2A"].objidnum, 0);
  scripts\mp\objidpoolmanager::objective_set_play_outro(level.objectives["_encstr_8E8405EA382B2A"].objidnum, 0);
  scripts\mp\objidpoolmanager::_id_11F84(level.objectives["_encstr_8E8405EA382B2A"].objidnum, 1);
  level.objectives["_encstr_9A8507BA4040188D08"] scripts\mp\gameobjects::setvisibleteam("_encstr_8BBA05185F8B99");
  level.objectives["_encstr_8E8405EA382B2A"] scripts\mp\gameobjects::setvisibleteam("_encstr_8BBA05185F8B99");
}

emptriggerholdonuse(var_0) {}

createbombzone(var_0, var_1, var_2) {
  var_3 = getEntArray(var_1.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3[0].origin = var_1.origin;
  var_4 = scripts\mp\gameobjects::createuseobject(var_0, var_1, var_3, (0, 0, 64), undefined, 1);
  var_4.onuse = ::onuse;
  var_4.onbeginuse = ::onbeginuse;
  var_4.onenduse = ::onenduse;
  var_4.oncantuse = ::oncantuse;
  var_4.useweapon = getcompleteweaponname("_encstr_8F0A0CE01AD26F99678DD64095C3");
  var_4.id = "_encstr_BED80ABE90F30A6F7A40FBDF";
  var_4.trigger setusepriority(-3);
  var_4.trigger setuseholdduration("_encstr_97C20EB5FD43A179CC6AD05152651579");
  var_4.trigger setusehideprogressbar(1);
  var_4.bombplanted = 0;
  var_4.bombexploded = undefined;
  var_4 scripts\mp\gameobjects::setusetime(level.planttime);
  var_4 scripts\mp\gameobjects::setwaitweaponchangeonuse(0);
  var_4.objectivekey = "_encstr_BA4C02DF" + var_0;
  var_4.label = var_4.objectivekey;
  var_4 resetbombsite(1, undefined, 1);
  var_4 scripts\mp\gameobjects::setusetext(&"_encstr_85B116653F4A60E887BD4B37955C01AD19C7AD7DF7C12E30");
  var_4 scripts\mp\gameobjects::setusehinttext(&"_encstr_86521C40F31A48B789C00EA1E87719B36165B94985B9F1294046695955AA");

  for(var_5 = 0; var_5 < var_3.size; var_5++) {
    if(isDefined(var_3[var_5].script_exploder)) {
      var_4.exploderindex = var_3[var_5].script_exploder;
      var_3[var_5] thread setupkillcament(var_4);
      break;
    }
  }

  var_4.noweapondropallowedtrigger = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_4.trigger.origin, 0, 140, 100);
  var_4.defusetrig = var_2;
  return var_4;
}

setupkillcament(var_0) {
  var_1 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", self.origin);
  var_1.angles = self.angles;
  var_1 rotateYaw(-45, 0.05);
  waitframe();
  var_2 = undefined;
  var_3 = self.origin + (0, 0, 45);
  var_4 = self.origin + anglesToForward(var_1.angles) * 100 + (0, 0, 128);
  var_5 = ["_encstr_BAC1197AA4A00BC432A281DA954387A2981390DFE5A0239BC8E8E4", "_encstr_B8431C7754DBAF6823F728509B6CA1DDB33A7871EC93775004C72040AF80", "_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA"];
  var_6 = physics_createcontents(var_5);
  var_7 = scripts\engine\trace::ray_trace(var_3, var_4, self, var_6);
  var_2 = var_7["_encstr_BD260953AA97E3F014279D"];
  self.killcament = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2);
  self.killcament setscriptmoverkillcam("_encstr_AB440A3180D0C0109B17550B");
  var_0.killcamentnum = self.killcament getentitynumber();
  var_1 delete();
}

empsitewatcher() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    level waittill("_encstr_87010C8932778E41AAD96F77ED92");

    if(level.cyberemp.carrier.team == "_encstr_9A8507BA4040188D08")
      level.objectives["_encstr_8E8405EA382B2A"] setupforplanting();
    else
      level.objectives["_encstr_9A8507BA4040188D08"] setupforplanting();

    waitframe();
  }
}

data_center_sfx_loop() {
  var_0 = scripts\engine\utility::spawn_script_origin(self.trigger.origin, self.trigger.angles);
  var_0 thread scripts\engine\utility::play_loop_sound_on_entity("_encstr_B465156A20C17E5F71A57E7C4DBB970623D0E283695972");
  level waittill("_encstr_8F190ECD11ABDF8753307A6270993FCB");
  var_0 stopsounds("_encstr_B465156A20C17E5F71A57E7C4DBB970623D0E283695972");
  waitframe();
  var_0 delete();
}

onbeginuse(var_0) {
  if(!scripts\mp\gameobjects::isfriendlyteam(var_0.pers["_encstr_8AEF05472BC2D6"]) && !level.bombplanted) {
    var_0.isplanting = 1;
    setomnvar("_encstr_9131145D2DFA31DBD698BED2B9E82B4E581B8EA5B9EC", 1);
    scripts\mp\gameobjects::setobjectivestatusicons("_encstr_A9A41DBB73AFD8A7C332E0B0CA1C8DD3171C35A4CD03415FAFDAA0A0C27343", "_encstr_AA751B2DC67B73BEBB589783DBB4DCE8BECA6B07D7E036C237E82D739D");
  } else {
    var_0.isdefusing = 1;
    setomnvar("_encstr_9131145D2DFA31DBD698BED2B9E82B4E581B8EA5B9EC", 3);
    scripts\mp\utility\game::setmlgannouncement(2, var_0.team, var_0 getentitynumber());
    scripts\mp\gameobjects::setobjectivestatusicons("_encstr_A296208850B756B97B01938B9A0AD35BD1295F1FB76A0167B71F4B9888DB5BE95D9B", "_encstr_AD011BD21B7BB9EBEE585E38DEA5E6D1D795AD83F59156CCD537A5DC76");
    scripts\mp\objidpoolmanager::objective_teammask_removefrommask(self.radialtimeobjid, var_0.team);
  }

  var_0 thread allowedwhileplanting(0);

  if(level.bombplanted && !scripts\mp\gameobjects::isfriendlyteam(var_0.pers["_encstr_8AEF05472BC2D6"])) {
    var_0 scripts\mp\bots\bots_util::notify_enemy_bots_bomb_used("_encstr_830C078CCA33ABB959");
    var_0.isdefusing = 1;
    setomnvar("_encstr_9131145D2DFA31DBD698BED2B9E82B4E581B8EA5B9EC", 3);
    setomnvar("_encstr_BD7B101550D84D98AABE2F51A7E0EB1B6372", var_0 getentitynumber());

    if(isDefined(level.cyberemp.visuals[0]))
      level.cyberemp.visuals[0] hide();

    var_0 thread startnpcbombusesound("_encstr_B108190EAE4BCAC6C9A07F2F3981B732355017471CAB630D96F86B", "_encstr_8FB11CBBCAC20EBEDC5DD2E8B1B0B959AF4695CC5737ACFA13AB3A8E7B37");
  }
}

allowedwhileplanting(var_0) {
  scripts\common\utility::allow_melee(var_0);
  scripts\common\utility::allow_jump(var_0);
  scripts\mp\utility\player::allow_gesture(var_0);

  if(var_0) {
    scripts\engine\utility::_id_143B9(0.8, "_encstr_A5DB1426DB5B26D70B36B17BDDD7EDCC3343B0B9C837");
    scripts\common\utility::allow_melee(var_0);
    scripts\common\utility::allow_mantle(var_0);
  } else {
    scripts\common\utility::allow_melee(var_0);
    scripts\common\utility::allow_mantle(var_0);
  }

  scripts\common\utility::allow_offhand_weapons(var_0);
}

onenduse(var_0, var_1, var_2) {
  var_3 = self.objidnum;
  scripts\mp\objidpoolmanager::objective_set_progress(var_3, 0);
  scripts\mp\objidpoolmanager::objective_show_progress(var_3, 0);

  if(!var_2) {
    if(var_1.isdefusing)
      scripts\mp\gameobjects::_id_1317F("_encstr_883B20303938E81677276038F7AA18C3E902CDDBBBEB3D1779A3613B107B9587989B", "_encstr_A296208850B756B97B01938B9A0AD35BD1295F1FB76A0167B71F4B9888DB5BE95D9B", "_encstr_8DA01EB51B767DA5C6B7E6BEDD2CCBC17BD2378EBECADA38D71CD816DCA3B219");
    else
      scripts\mp\gameobjects::_id_1317F("_encstr_A9A41DBB73AFD8A7C332E0B0CA1C8DD3171C35A4CD03415FAFDAA0A0C27343", "_encstr_8FDD1D18D0F22D574737B88A3A1333B41F51477A5C63EB119DC88BD77C800D", "_encstr_8DA01EB51B767DA5C6B7E6BEDD2CCBC17BD2378EBECADA38D71CD816DCA3B219");

    if(isDefined(self.radialtimeobjid))
      scripts\mp\objidpoolmanager::objective_teammask_addtomask(self.radialtimeobjid, var_1.team);

    var_1 scripts\mp\utility\inventory::switchtolastweapon();
  }

  var_1.isplanting = 0;
  var_1.isdefusing = 0;
  setomnvar("_encstr_BD7B101550D84D98AABE2F51A7E0EB1B6372", -1);

  if(!isDefined(var_1)) {
    return;
  }
  var_1 thread allowedwhileplanting(1);
  var_1.bombplantweapon = undefined;

  if(isPlayer(var_1)) {
    var_1 setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", 0);
    var_1.ui_bomb_planting_defusing = undefined;
  }

  if(!scripts\mp\gameobjects::isfriendlyteam(var_1.pers["_encstr_8AEF05472BC2D6"])) {
    if(isDefined(level.cyberemp) && !var_2)
      level.cyberemp.visuals[0] show();
  }
}

startnpcbombusesound(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8A59116B43BFC789EA936D3FB55659B77F7A01");

  if(scripts\mp\utility\game::isanymlgmatch() || istrue(level.silentplant) || scripts\mp\utility\perk::_hasperk("_encstr_9B63139B09C036574770439BFEAD93EF088D051565")) {
    self setentitysoundcontext("_encstr_B8BA0D53AA8B85403377C1C1719D58", "_encstr_AB0703DBB9");
    return;
  }

  for(;;) {
    self waittill("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D", var_2);

    if(var_2.basename == var_0) {
      break;
    }
  }

  self playsoundtoteam(var_1, self.team, self);
  var_3 = scripts\mp\utility\game::getotherteam(self.team)[0];
  self playsoundtoteam(var_1, var_3);
  self waittill("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");
  self notify("_encstr_8A59116B43BFC789EA936D3FB55659B77F7A01");
}

onpickup(var_0, var_1, var_2) {
  level notify("_encstr_87010C8932778E41AAD96F77ED92");
  var_3 = var_0 getcurrentprimaryweapon();

  if(isDefined(var_3.basename) && var_3.basename == "_encstr_93BD10DAA3532F4D30DF0C12A1E857E711BB")
    var_0 notify("_encstr_8EE016B9EE2D8E6CA1AC32FA3327DBB6EBAD2DE64B9D5D37");

  var_0 scripts\cp_mp\utility\inventory_utility::_giveweapon("_encstr_976A10EB17828EAF30525010DACD41460FB8");

  if(!istrue(var_2) && !var_0 scripts\mp\utility\killstreak::isjuggernaut() && !isbot(var_0))
    var_0 scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate("_encstr_976A10EB17828EAF30525010DACD41460FB8");

  var_0 thread empradarwatcher();
  setomnvar("_encstr_A55A105862213D10B76AA0A641E37B93177B", var_0 getentitynumber());
  var_0 setclientomnvar("_encstr_8CEF1333B101F8790B31D1998B6B23A0E22FB1BB24", 1);
  scripts\mp\utility\game::setmlgannouncement(16, var_0.team, var_0 getentitynumber());

  if(self.firstpickup)
    var_0 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_8F6C09CAB5E0FACE4E8589");

  level.usestartspawns = 0;
  var_4 = var_0.pers["_encstr_8AEF05472BC2D6"];

  if(var_4 == "_encstr_9A8507BA4040188D08")
    var_5 = "_encstr_8E8405EA382B2A";
  else
    var_5 = "_encstr_9A8507BA4040188D08";

  var_0.isbombcarrier = 1;

  if(level.codcasterenabled)
    var_0 setgametypevip(1);

  if(!isDefined(var_2)) {
    if(self.firstpickup) {
      var_6 = "_encstr_87761995DAE00E2DC65BD51C7D339CB4599B32D8CBAFCC9693CDA3";
      self.firstpickup = 0;
    } else
      var_6 = "_encstr_B8561335DD8361501BDFC0E027360BEB7A853DC9B0";

    scripts\mp\utility\dialog::leaderdialog(var_6, var_4, "_encstr_999B050670F0FA");
    scripts\mp\utility\dialog::leaderdialog("_encstr_84A41021D5E01023AA0F4351C792F8F085A8", var_5, "_encstr_999B050670F0FA");
    scripts\mp\utility\sound::playsoundonplayers(game["_encstr_BA2A15987B5B13EB39AC6CB7B3B29C9523EB6EBDEA3719"], var_4);
    var_7 = scripts\mp\utility\teams::getteamdata(var_0.team, "_encstr_9775086022BE1B413B8B");
    level thread scripts\mp\hud_message::notifyteam("_encstr_ADFC0BE94DA348CAD0BB332FAF", "_encstr_BDA511037FCB6050B1068843EA5F20207287B3", var_0.team, var_7);
    var_0 thread scripts\mp\hud_message::showsplash("_encstr_ADFC0BE94DA348CAD0BB332FAF");
    level thread scripts\mp\hud_util::teamplayercardsplash("_encstr_A3B11286EFB9A207C3D00717E09BD03A7F728BFA", var_0, var_0.team, undefined, 1);
  }

  level thread scripts\mp\hud_message::updatematchstatushintforallplayers(var_0.team, 5, 6, var_0, 2);
  self.offset3d = (0, 0, 75);
  scripts\mp\gameobjects::setownerteam(var_4);
  scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");

  if(isDefined(level.showenemycarrier)) {
    if(level.showenemycarrier == 0) {
      scripts\mp\gameobjects::setvisibleteam("_encstr_ACFC091AE8AB2FCBE15119");
      objective_state(self.pingobjidnum, "_encstr_8267056410C669");
    } else {
      scripts\mp\gameobjects::setvisibleteam("_encstr_ACFC091AE8AB2FCBE15119");
      objective_state(self.pingobjidnum, "_encstr_AF5A081BBAC993AC73A3");
      scripts\mp\gameobjects::updatecompassicon("_encstr_88BF06FD784A6393", self.pingobjidnum);
      objective_icon(self.pingobjidnum, "_encstr_A6A2132DB17B73BEBB0B2F07DEB4B9D17DD64B8D36");
    }
  }

  scripts\mp\gameobjects::setobjectivestatusicons("_encstr_973F1961B6E8BB2917F87BE3A0035D6B462DE3E3D8139BE1EB60F3", "_encstr_82FD166339ABDBC568F5446787404AB3D533DA69C00B63FD");
  level.objectives[var_4] scripts\mp\gameobjects::setvisibleteam("_encstr_8BBA05185F8B99");
  level.objectives[var_5] scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
  scripts\mp\objidpoolmanager::_id_11F84(level.objectives["_encstr_9A8507BA4040188D08"].objidnum, 0);
  scripts\mp\objidpoolmanager::_id_11F84(level.objectives["_encstr_8E8405EA382B2A"].objidnum, 0);
  var_0 thread scripts\common\utility::_id_13E0A(level._id_11B29, "_encstr_A31C07E04BD8ADABE0", var_0.origin);
}

ondrop(var_0) {
  setomnvar("_encstr_A55A105862213D10B76AA0A641E37B93177B", -1);

  if(level.bombplanted) {
    scripts\mp\gameobjects::setownerteam(var_0.team);
    scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");
  } else {
    foreach(var_2 in level.objectives)
    var_2 resetbombsite(1);

    scripts\mp\gameobjects::allowuse("_encstr_9A19040BCDBC");
    scripts\mp\gameobjects::setobjectivestatusicons("_encstr_8B0D122DD87B73AFBB16970EBDD2CDA3D7CAADC1", "_encstr_8B0D122DD87B73AFBB16970EBDD2CDA3D7CAADC1");
    scripts\mp\gameobjects::setownerteam("_encstr_A7A408B9CA5D1D4E2C63");
    scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");

    if(isDefined(var_0))
      scripts\mp\utility\print::printonteamarg(&"_encstr_BD2F19752F5A65993F89374F6BC4B08B31353A4D87F92D1090AD77", scripts\mp\gameobjects::getownerteam(), var_0);

    scripts\mp\utility\sound::playsoundonplayers(game["_encstr_BE9B13E59FF216D154AAD04B523D40C04B3773752B"], scripts\mp\gameobjects::getownerteam());
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(var_0.team, 1, 1);

    if(level.idleresettime > 0)
      thread returnaftertime();
  }
}

returnaftertime() {
  level endon("_encstr_87010C8932778E41AAD96F77ED92");
  var_0 = 0.0;

  while(var_0 < level.idleresettime) {
    waitframe();

    if(self.ownerteam == "_encstr_A7A408B9CA5D1D4E2C63")
      var_0 = var_0 + level.framedurationseconds;
  }

  foreach(var_2 in level.teamnamelist)
  scripts\mp\utility\sound::playsoundonplayers(game["_encstr_BE9B13E59FF216D154AAD04B523D40C04B3773752B"], var_2);

  scripts\mp\gameobjects::returnhome();
}

onuse(var_0) {
  var_1 = var_0.pers["_encstr_8AEF05472BC2D6"];
  var_2 = scripts\mp\utility\game::getotherteam(var_1)[0];

  if(!scripts\mp\gameobjects::isfriendlyteam(var_0.pers["_encstr_8AEF05472BC2D6"]) && !level.bombplanted) {
    level thread empjamandrumbleclients(0);
    setomnvar("_encstr_950418EAD2F5C47BAD13AFD14BDAB2E4BEACCD231D2DD6B2D70B", int(scripts\mp\gamelogic::gettimeremaining()) + gettime());
    level notify("_encstr_AB3D0DE25FE81EF7B7188A42230553");
    var_0 notify("_encstr_AB3D0DE25FE81EF7B7188A42230553");
    var_0 notify("_encstr_9A2B0A12F03587575B7BBEA5", "_encstr_A24E069389FFAA3C");
    var_0 playSound("_encstr_9A730EB61C7D98BDB6137D07C6C2DC1D");
    scripts\mp\utility\game::setmlgannouncement(15, var_0.team, var_0 getentitynumber());
    var_3 = [];
    var_3[var_3.size] = var_0;
    level thread scripts\mp\hud_message::notifyteam("_encstr_A1320CC529ABD8FBDB229338D1AD", "_encstr_B23E12ACDA38F5C1362CCD3A5946F5569BAC5BF2", var_0.team, var_3);
    var_0 thread scripts\mp\hud_message::showsplash("_encstr_A1320CC529ABD8FBDB229338D1AD", scripts\mp\rank::getscoreinfovalue("_encstr_A24E069389FFAA3C"));
    level thread scripts\mp\hud_util::teamplayercardsplash("_encstr_B8C1135ADFB353C8080B48270ABB5A21B9C85B015A", var_0, undefined, undefined, 1);
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(var_0.team, 4, 3);
    var_0 setclientomnvar("_encstr_8CEF1333B101F8790B31D1998B6B23A0E22FB1BB24", 0);
    scripts\mp\utility\dialog::leaderdialog("_encstr_87E51456DA83C11BB0DCE8CAC8F59993A5CA7391D8E5", var_1);
    var_0 playsoundtoteam("_encstr_87DD17AA704109D7595E50511A529DF9DFEAA8E4EDD58398FA", var_1);
    scripts\mp\utility\dialog::leaderdialog("_encstr_87C8115F13FFC3ACB078B3FF1169ED9ADDBBB7", var_2);
    var_0 playsoundtoteam("_encstr_826E1485DF0E6B0503C0CB02B077FF0B66CD1E05F912", var_2);
    var_0 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_A24E069389FFAA3C");
    var_0 scripts\cp\vehicles\vehicle_compass_cp::_id_12062();
    var_0 thread scripts\common\utility::_id_13E0A(level._id_11B29, "_encstr_A24E069389FFAA3C", var_0.origin);
    var_0.bombplantedtime = gettime();
    var_0 scripts\mp\utility\stats::incpersstat("_encstr_8FB00783D8C2CDE8DC", 1);
    var_0 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_8FB00783D8C2CDE8DC", var_0.pers["_encstr_8FB00783D8C2CDE8DC"]);
    var_0 scripts\mp\utility\stats::setextrascore0(var_0.pers["_encstr_8FB00783D8C2CDE8DC"]);
    var_0 scripts\cp_mp\pet_watch::addplantingcharge();
    level.bombplanted = 1;
    scripts\mp\gameobjects::_id_13172("_encstr_8DA01EB51B767DA5C6B7E6BEDD2CCBC17BD2378EBECADA38D71CD816DCA3B219");
    level thread bombplanted(self, var_0.pers["_encstr_8AEF05472BC2D6"]);
    level.bombowner = var_0;
    level.bombowner.isbombcarrier = 0;

    if(level.codcasterenabled)
      var_0 setgametypevip(0);

    level.cyberemp scripts\mp\gameobjects::setdropped();
    level.cyberemp scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");
    level.cyberemp scripts\mp\gameobjects::setvisibleteam("_encstr_8BBA05185F8B99");
    var_0 scripts\cp_mp\utility\inventory_utility::_takeweapon("_encstr_976A10EB17828EAF30525010DACD41460FB8");
    var_0 scripts\mp\utility\inventory::switchtolastweapon();
    self.useweapon = getcompleteweaponname("_encstr_884B0EB25BE0BE91AC995DE62BF5B5E0");
    setupfordefusing(self, var_0);
  } else {
    var_0 notify("_encstr_ACA10DAE80E31A1FC960CB8FF8C11C");
    var_0 notify("_encstr_9A2B0A12F03587575B7BBEA5", "_encstr_830C078CCA33ABB959");
    var_4 = 0;

    if(scripts\mp\utility\teams::getenemycount(var_0.team, 1) == 0)
      var_4 = 1;

    if(var_4) {
      var_5 = "_encstr_82B71A78824A91F1FB1DD6C5E4F7597335AAA8218A62C389833451C3";
      var_6 = "_encstr_A25C1718E22AF191DB3DF6E50417B953158AC8419A453BA8FF";
    } else {
      var_5 = "_encstr_93861495ADC1235633D56EAC91D7CC4EA52BB99163E5";
      var_6 = "_encstr_ACD6114D912BB347D5B83B52D84FBF636109C9";
    }

    scripts\mp\utility\dialog::leaderdialog(var_5, var_1);
    scripts\mp\utility\dialog::leaderdialog(var_6, var_2);
    var_3 = [];
    var_3[var_3.size] = var_0;
    level thread scripts\mp\hud_message::notifyteam("_encstr_83190BF38F4B1735371E1B8761", "_encstr_BE80111FE083CFD253ACFB72057F9AB64998E7", var_0.team, var_3);
    level thread scripts\mp\hud_util::teamplayercardsplash("_encstr_877C13CA591448D0BB73382BF5835D1DB26BAA612F", var_0, undefined, undefined, 1);
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(var_0.team, 5, 6, var_0, 2);

    if(isDefined(level.bombowner) && level.bombowner.bombplantedtime + 3000 + level.defusetime * 1000 > gettime() && scripts\mp\utility\player::isreallyalive(level.bombowner)) {
      var_0 thread scripts\mp\rank::scoreeventpopup("_encstr_AF6F0D7833AAA51639898F5A40F28D");
      var_0 thread scripts\mp\hud_message::showsplash("_encstr_AF6F0D7833AAA51639898F5A40F28D", scripts\mp\rank::getscoreinfovalue("_encstr_830C078CCA33ABB959"));
    } else {
      var_0 thread scripts\mp\rank::scoreeventpopup("_encstr_830C078CCA33ABB959");
      var_0 thread scripts\mp\hud_message::showsplash("_encstr_83190BF38F4B1735371E1B8761", scripts\mp\rank::getscoreinfovalue("_encstr_830C078CCA33ABB959"));
    }

    var_0 thread scripts\mp\awards::givemidmatchaward("_encstr_8B6D0F5040346FC7534AD94AE3F6EB3FA9");
    var_0 scripts\mp\utility\stats::incpersstat("_encstr_817B0812789D1387E986", 1);
    var_0 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_817B0812789D1387E986", var_0.pers["_encstr_817B0812789D1387E986"]);
    var_0 scripts\cp\vehicles\vehicle_compass_cp::_id_1201F();
    var_0 thread scripts\common\utility::_id_13E0A(level._id_11B29, "_encstr_830C078CCA33ABB959", var_0.origin);
    level.bombplanted = 0;
    level thread bombdefused(self);
    resetbombsite(1, var_0);

    if(var_4)
      wait 3;

    level.cyberemp scripts\mp\gameobjects::allowuse("_encstr_9A19040BCDBC");
    level.cyberemp scripts\mp\gameobjects::setpickedup(var_0, 0, 1);
  }
}

empjamandrumbleclients(var_0, var_1) {
  foreach(var_3 in level.players) {
    var_3 setempjammed(1);

    if(istrue(var_0))
      var_3 playrumbleonpositionforclient("_encstr_A9D111B0278EA5D8D85939CBF5E4AED613D8B2", var_3.origin);
  }

  if(!istrue(var_1)) {
    wait 1;

    foreach(var_3 in level.players)
    var_3 setempjammed(0);
  }
}

resetbombsite(var_0, var_1, var_2) {
  if(!var_0) {
    scripts\mp\gameobjects::setobjectivestatusicons("_encstr_B6491EF2E00738510703477FB00BFDF317AB75D2DD33B57DD7756AFBCF393980", "_encstr_8FDD1D18D0F22D574737B88A3A1333B41F51477A5C63EB119DC88BD77C800D");
    scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
  } else {
    if(istrue(var_2)) {
      return;
    }
    if(isDefined(var_1))
      self.ownerteam = var_1.team;

    self.id = "_encstr_BED80ABE90F30A6F7A40FBDF";
    scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");
    scripts\mp\gameobjects::setvisibleteam("_encstr_8BBA05185F8B99");
    scripts\mp\objidpoolmanager::_id_11F84(level.objectives["_encstr_9A8507BA4040188D08"].objidnum, 1);
    scripts\mp\objidpoolmanager::_id_11F84(level.objectives["_encstr_8E8405EA382B2A"].objidnum, 1);
    return;
  }
}

setupforplanting() {
  self.trigger enableplayeruse(level.cyberemp.carrier);
  scripts\mp\gameobjects::allowuse("_encstr_88BF06FD784A6393");
  scripts\mp\gameobjects::setusetime(level.planttime);
  scripts\mp\gameobjects::setusetext(&"_encstr_85B116653F4A60E887BD4B37955C01AD19C7AD7DF7C12E30");
  scripts\mp\gameobjects::setusehinttext(&"_encstr_86BE15F19955314C9BF4189587AFD771A6E0B1D96015F9");
  scripts\mp\gameobjects::setkeyobject(level.cyberemp);
  self.useweapon = getcompleteweaponname("_encstr_8F0A0CE01AD26F99678DD64095C3");
  scripts\mp\gameobjects::setobjectivestatusicons("_encstr_A9A41DBB73AFD8A7C332E0B0CA1C8DD3171C35A4CD03415FAFDAA0A0C27343", "_encstr_8FDD1D18D0F22D574737B88A3A1333B41F51477A5C63EB119DC88BD77C800D");
  self.bombplanted = 0;
}

setupfordefusing(var_0, var_1) {
  self.trigger setusepriority(-3);
  self.ownerteam = var_1.team;
  scripts\mp\gameobjects::allowuse("_encstr_88BF06FD784A6393");
  scripts\mp\gameobjects::setusetime(level.defusetime);
  scripts\mp\gameobjects::setusetext(&"_encstr_BD3416350597222A64AA4D923974AF51850A13F4A625CA8A");
  scripts\mp\gameobjects::setusehinttext(&"_encstr_956C160BD366B3E1ECB7463F6D97F17D88AFAF935768E9E1");
  scripts\mp\gameobjects::setkeyobject(undefined);
  scripts\mp\gameobjects::setobjectivestatusicons("_encstr_A296208850B756B97B01938B9A0AD35BD1295F1FB76A0167B71F4B9888DB5BE95D9B", "_encstr_883B20303938E81677276038F7AA18C3E902CDDBBBEB3D1779A3613B107B9587989B");
  thread _encstr_A9042687EF43D3E804AA982892B7981F6A5F311B3B5AA64A27C638663EAFB0C6B38F8DBB2AC26EE0::current_carrier(var_1.team, "_encstr_B6491EF2E00738510703477FB00BFDF317AB75D2DD33B57DD7756AFBCF393980", "_encstr_8F8D1DB306777A19DFE303D06A0C0EECA1DA3A9B356BB987E5506B6760E3F2");
  scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC", self.radialtimeobjid);
  self.id = "_encstr_86DB0E32ACCC579B56BEBD31A9CAB11D";
  self.bombplanted = 1;
  var_2 = scripts\mp\utility\teams::getenemyteams(var_1.team);
  var_3 = var_2[0];

  foreach(var_5 in scripts\mp\utility\teams::getteamdata(var_3, "_encstr_9775086022BE1B413B8B"))
  self.trigger enableplayeruse(var_5);
}

bombdefused(var_0) {
  scripts\mp\gamelogic::resumetimer();
  level.timelimitoverride = 0;
  level.scorelimitoverride = 0;
  var_0.bombplanted = 0;
  setomnvar("_encstr_8AAD13574BF54CB7DAC4EBDEBBB959C9BE1D9516B6", -1);
  level thread[[level.updategameevents]]();
  var_0.visuals[0] scripts\mp\gamelogic::stoptickingsound();
  level notify("_encstr_ACA10DAE80E31A1FC960CB8FF8C11C");
}

oncantuse(var_0) {}

bombplanted(var_0, var_1) {
  level endon("_encstr_8B6D0940CC35339149DA08");
  scripts\mp\gamelogic::pausetimer();
  setomnvar("_encstr_B1CE17D55AAF6B85D13643F5E896AD2B39D76EE87BC1835932", 0);
  level.bombplantedteam = var_1;
  level.timelimitoverride = 1;
  level.scorelimitoverride = 1;

  if(isDefined(var_1)) {
    if(var_1 == "_encstr_9A8507BA4040188D08")
      setomnvar("_encstr_8AAD13574BF54CB7DAC4EBDEBBB959C9BE1D9516B6", 2);
    else
      setomnvar("_encstr_8AAD13574BF54CB7DAC4EBDEBBB959C9BE1D9516B6", 1);
  }

  setgameendtime(int(gettime() + level.bombtimer * 1000));
  var_0.visuals[0] thread scripts\mp\gamelogic::playtickingsound();
  var_2 = gettime();
  thread bomb_pre_exp_music();
  thread bomb_pre_exp_sfx_wait(var_0.visuals[0].origin);
  bombtimerwait();
  var_0.visuals[0] scripts\mp\gamelogic::stoptickingsound();

  if(!level.bombplanted) {
    if(level.persbombtimer) {
      var_3 = (gettime() - var_2) / 1000;
      level.bombtimer = level.bombtimer - var_3;
    }

    return;
  }

  var_4 = var_0.visuals[0].origin;
  level.bombexploded = 1;
  setDvar("_encstr_8CBA0F5DBC1129F1B64FE050C7C4095B5A", "_encstr_93C10D26B7639A85CA486367C0419C");

  if(isDefined(level.bombowner)) {
    var_0.visuals[0] radiusdamage(var_4, 512, 1, 1, level.bombowner, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_A9F00D4CBDAD4CEB9BD2E8957DAD0E");
    level.bombowner scripts\mp\utility\stats::incpersstat("_encstr_8B460D8A6176034A70279C992770D2", 1);
    level.bombowner scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_8B460D8A6176034A70279C992770D2", level.bombowner.pers["_encstr_8B460D8A6176034A70279C992770D2"]);
  } else
    var_0.visuals[0] radiusdamage(var_4, 512, 1, 1, undefined, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_A9F00D4CBDAD4CEB9BD2E8957DAD0E");

  var_5 = randomfloat(360);
  playsoundatpos(var_4, "_encstr_9705149FF93FF16330B9B77A36F8A5BBAF67233F97ED");
  var_6 = var_0.visuals[0] gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_7 = spawnfx(level._effect["_encstr_AF160F08F23A97A1A74C8870318B48AFE5"], var_6, (0, 0, 1), (cos(var_5), sin(var_5), 0));
  triggerfx(var_7);
  earthquake(0.6, 1.5, var_4, 10000);
  level thread empjamandrumbleclients(1, 1);
  level notify("_encstr_8F190ECD11ABDF8753307A6270993FCB");

  foreach(var_9 in level.objectives) {
    var_9 notify("_encstr_921D09D9D9C0090D7275B4");
    var_9.trigger scripts\mp\utility\usability::setallunusable();
  }

  if(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"])
    var_0.exploderindex = 200;
  else
    var_0.exploderindex = 201;

  if(isDefined(var_0.exploderindex))
    scripts\engine\utility::exploder(var_0.exploderindex);

  var_0.bombplanted = 0;
  level.cyberemp scripts\mp\gameobjects::setvisibleteam("_encstr_8BBA05185F8B99");
  level.objectives["_encstr_9A8507BA4040188D08"] scripts\mp\gameobjects::setvisibleteam("_encstr_8BBA05185F8B99");
  level.objectives["_encstr_8E8405EA382B2A"] scripts\mp\gameobjects::setvisibleteam("_encstr_8BBA05185F8B99");
  scripts\mp\objidpoolmanager::_id_11F84(level.objectives["_encstr_9A8507BA4040188D08"].objidnum, 0);
  scripts\mp\objidpoolmanager::_id_11F84(level.objectives["_encstr_8E8405EA382B2A"].objidnum, 0);
  setgameendtime(0);
  level.scorelimitoverride = 1;

  if(isDefined(level.bombowner))
    level thread scripts\mp\hud_util::teamplayercardsplash("_encstr_AD0120C60B63B1EDAE1DD732CACD47C9DBE5AC23F58D974C952789DED6C4E6A5D12B", level.bombowner);

  var_0 scripts\mp\gameobjects::releaseid();

  if(istrue(level.nukeincoming)) {
    return;
  }
  wait 3;
  thread scripts\mp\gamelogic::endgame(var_1, game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_ABCA11472C9C3B56E8BE3295CD1D93B7E5CA91"], undefined, undefined, level.detonatescore);
}

bombtimerwait() {
  level endon("_encstr_ACA10DAE80E31A1FC960CB8FF8C11C");
  level endon("_encstr_B29B0F389B2573D1A27595B04FEAC9598C");
  var_0 = int(level.bombtimer * 1000 + gettime());
  setomnvar("_encstr_8C831627B81E9A0ADB36D90BABF36232A670D3EB28B0DD92", var_0);
  level thread handlehostmigration(var_0);
  scripts\mp\hostmigration::waitlongdurationwithgameendtimeupdate(level.bombtimer);
}

bomb_pre_exp_music() {
  thread scripts\mp\music_and_dialog::stopsuspensemusic();
  thread scripts\mp\music_and_dialog::bombplanted_music();
}

bomb_pre_exp_sfx_wait(var_0) {
  level endon("_encstr_ACA10DAE80E31A1FC960CB8FF8C11C");
  level endon("_encstr_B29B0F389B2573D1A27595B04FEAC9598C");
  wait(max(level.bombtimer - 2, 0.1));
  playsoundatpos(var_0, "_encstr_8ECB1995E183AF8DE589AC27EB56AD83BE38C995CA870EB1BD2395");
}

handlehostmigration(var_0) {
  level endon("_encstr_ACA10DAE80E31A1FC960CB8FF8C11C");
  level endon("_encstr_B29B0F389B2573D1A27595B04FEAC9598C");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level waittill("_encstr_AD3F1534DB9BA3BEADD27627B0D1B4BDCDAFC495EC2DCD");
  var_1 = scripts\mp\hostmigration::waittillhostmigrationdone();

  if(var_1 > 0)
    setomnvar("_encstr_8C831627B81E9A0ADB36D90BABF36232A670D3EB28B0DD92", var_0 + var_1);
}

overtimethread(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level.inovertime = 1;
  wait 5.0;
  level.disablespawning = 1;
}

givelastonteamwarning() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\mp\utility\player::waittillrecoveredhealth(3);
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "_encstr_88101078BE5C37CD984FAC9EDB23672DB507");
  var_0 = scripts\mp\utility\game::getotherteam(self.pers["_encstr_8AEF05472BC2D6"])[0];
  level thread scripts\mp\hud_util::teamplayercardsplash("_encstr_AB591C8E66FAE1D845FBD978977B7319B28E7101FF4245C12AC748582385", self, self.pers["_encstr_8AEF05472BC2D6"]);
  level thread scripts\mp\hud_util::teamplayercardsplash("_encstr_81D01736858DB1BDAE8E7D1BB09B3AACCDB2DA97851B4BB395", self, var_0);
  level notify("_encstr_B6420BE367A3B0A1F7EB43C33F", self);
}

ontimelimit() {
  if(level.bombexploded) {
    return;
  }
  trial_race_lap_total();
  thread scripts\mp\gamelogic::endgame("_encstr_8D19048EA595", game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_AF9C0A077B223BF35F4BF34B"]);
}

onspawnplayer() {
  self setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 0);
  self setclientomnvar("_encstr_AAB915BA96D76EB2C6EA9C2D3776EBC19CBD3BE4566ECD", 0);
  self setclientomnvar("_encstr_9B061AD54B7D5B0B3AC61A7DE6D1C247ABDC7DA1B4DC1DD78ECA87E8", -1);

  if(level.multibomb)
    self setclientomnvar("_encstr_8CEF1333B101F8790B31D1998B6B23A0E22FB1BB24", 1);
  else {
    self setclientomnvar("_encstr_8CEF1333B101F8790B31D1998B6B23A0E22FB1BB24", 0);
    thread updatebombsiteusability();
  }

  self.isplanting = 0;
  self.isdefusing = 0;
  self.isbombcarrier = 0;

  if(scripts\mp\utility\game::inovertime() && !isDefined(self.otspawned))
    thread printothint();

  if(isDefined(self.pers["_encstr_8FB00783D8C2CDE8DC"]))
    scripts\mp\utility\stats::setextrascore0(self.pers["_encstr_8FB00783D8C2CDE8DC"]);

  if(isDefined(self.pers["_encstr_8294083A0938C3CB2577"]))
    scripts\mp\utility\stats::setextrascore1(self.pers["_encstr_8294083A0938C3CB2577"]);

  thread updatematchstatushintonspawn();
}

updatebombsiteusability() {
  if(!isDefined(level.objectives))
    level waittill("_encstr_95FC182BCD0B986359BE07C658E5B2C9AFD5378598D2B15AA3BC");

  foreach(var_1 in level.objectives) {
    if(var_1.bombplanted == 0)
      var_1.trigger disableplayeruse(self);
  }
}

updatematchstatushintonspawn() {
  if(level.bombplanted) {
    if(isDefined(level.bombplantedteam) && level.bombplantedteam == self.team)
      self setclientomnvar("_encstr_9B061AD54B7D5B0B3AC61A7DE6D1C247ABDC7DA1B4DC1DD78ECA87E8", 4);
    else
      self setclientomnvar("_encstr_9B061AD54B7D5B0B3AC61A7DE6D1C247ABDC7DA1B4DC1DD78ECA87E8", 3);
  } else if(isDefined(level.cyberemp) && isDefined(level.cyberemp.carrier)) {
    if(level.cyberemp.carrier.team == self.team) {
      if(level.cyberemp.carrier == self)
        self setclientomnvar("_encstr_9B061AD54B7D5B0B3AC61A7DE6D1C247ABDC7DA1B4DC1DD78ECA87E8", 2);
      else
        self setclientomnvar("_encstr_9B061AD54B7D5B0B3AC61A7DE6D1C247ABDC7DA1B4DC1DD78ECA87E8", 5);
    } else
      self setclientomnvar("_encstr_9B061AD54B7D5B0B3AC61A7DE6D1C247ABDC7DA1B4DC1DD78ECA87E8", 6);
  } else
    self setclientomnvar("_encstr_9B061AD54B7D5B0B3AC61A7DE6D1C247ABDC7DA1B4DC1DD78ECA87E8", 1);
}

trial_race_lap_total() {
  foreach(var_1 in level.players) {
    if(istrue(var_1.isplanting) && isDefined(var_1.lastnonuseweapon)) {
      var_1 scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var_1.lastnonuseweapon);
      break;
    }
  }
}

ondeadevent(var_0) {
  trial_race_lap_total();

  if(level.bombexploded > 0 && !level.postgameexfil) {
    return;
  }
  if(var_0 == "_encstr_AF1904A7F929") {
    if(level.bombplanted) {
      var_1 = scripts\mp\utility\game::getotherteam(level.bombplantedteam)[0];
      thread scripts\mp\gamelogic::endgame(level.bombplantedteam, game["_encstr_99EA0B72AB022F6ED1CF9FC248"][tolower(game[var_1]) + "_encstr_86E60CDF8828C17A6380E6DB7D11"], undefined, undefined, level.detonatescore);
    } else
      thread scripts\mp\gamelogic::endgame("_encstr_8D19048EA595", game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_8D19048EA595"]);
  } else if(level.bombplanted) {
    if(var_0 != level.bombplantedteam)
      thread scripts\mp\gamelogic::endgame(level.bombplantedteam, game["_encstr_99EA0B72AB022F6ED1CF9FC248"][tolower(game[var_0]) + "_encstr_86E60CDF8828C17A6380E6DB7D11"], undefined, undefined, level.detonatescore);
    else
      return;
  } else if(var_0 == game["_encstr_991C0AB9ED5B57161FE89B83"])
    level thread scripts\mp\gamelogic::endgame(game["_encstr_B6A70A23CA6659DC91CAE4DC"], game["_encstr_99EA0B72AB022F6ED1CF9FC248"][tolower(game[game["_encstr_991C0AB9ED5B57161FE89B83"]]) + "_encstr_86E60CDF8828C17A6380E6DB7D11"]);
  else if(var_0 == game["_encstr_B6A70A23CA6659DC91CAE4DC"])
    level thread scripts\mp\gamelogic::endgame(game["_encstr_991C0AB9ED5B57161FE89B83"], game["_encstr_99EA0B72AB022F6ED1CF9FC248"][tolower(game[game["_encstr_B6A70A23CA6659DC91CAE4DC"]]) + "_encstr_86E60CDF8828C17A6380E6DB7D11"]);
}

ononeleftevent(var_0) {
  if(level.bombexploded > 0) {
    return;
  }
  var_1 = scripts\mp\utility\game::getlastlivingplayer(var_0);

  if(isDefined(var_1)) {
    var_1.laststanding = 1;
    var_1 thread givelastonteamwarning();
  }
}

onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  self setclientomnvar("_encstr_8CEF1333B101F8790B31D1998B6B23A0E22FB1BB24", 0);
  thread checkallowspectating();

  if(!isPlayer(var_1) || var_1.team == self.team) {
    return;
  }
  if(self.isbombcarrier && level.codcasterenabled)
    self setgametypevip(0);

  awardgenericmedals(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
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

onnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5) {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::oncommonnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5);

  if(var_0.isplanting) {
    thread scripts\common\utility::_id_13E0A(level._id_11B30, var_2, "_encstr_8AD1096F4D428DC321FB3B");
    var_1 scripts\mp\utility\stats::incpersstat("_encstr_B1F7085B03F492AE98DB", 1);
    var_1 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_B1F7085B03F492AE98DB", var_1.pers["_encstr_B1F7085B03F492AE98DB"]);
  } else if(var_0.isbombcarrier)
    thread scripts\common\utility::_id_13E0A(level._id_11B30, var_2, "_encstr_852F09FA41FB7ADB3968C4");
  else if(var_0.isdefusing)
    thread scripts\common\utility::_id_13E0A(level._id_11B30, var_2, "_encstr_B669098CAC99BA6E96E63B");
}

printothint() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  wait 0.25;
  self.otspawned = 1;
}

awardgenericmedals(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = 0;
  var_11 = 0;
  var_12 = 0;
  var_13 = self;
  var_14 = var_13.origin;
  var_15 = var_1.origin;
  var_16 = 0;

  if(isDefined(var_0)) {
    var_15 = var_0.origin;
    var_16 = var_0 == var_1;
  }

  if(isDefined(level.cyberemp.carrier)) {
    if(isDefined(var_1) && isPlayer(var_1) && var_1.pers["_encstr_8AEF05472BC2D6"] != var_13.pers["_encstr_8AEF05472BC2D6"]) {
      if(isDefined(var_1.isbombcarrier) && var_16 && isDefined(var_4) && var_4.basename == "_encstr_976A10EB17828EAF30525010DACD41460FB8") {
        var_1 thread scripts\mp\rank::scoreeventpopup("_encstr_96DD112BAD0EBEC60B9CC9B45927FAB65AC68D");
        var_1 thread scripts\mp\awards::givemidmatchaward("_encstr_84D519FA50E17F5F71AB726DC61E478409A041D3D8697427E99968");
      } else if(istrue(var_13.isbombcarrier)) {
        var_13.isbombcarrier = 0;

        if(istrue(var_13._id_1334E))
          var_13 scripts\mp\utility\player::hideminimap();

        var_1 thread scripts\mp\rank::scoreeventpopup("_encstr_93A613EC18505C7A159F8FA7E950C2894883E4F7D3");
        var_1 thread scripts\mp\awards::givemidmatchaward("_encstr_8DDB186BF68C957DD85E98AC39D7D64BB18DAF1B2C39392DAC39");
        thread scripts\common\utility::_id_13E0A(level._id_11B30, var_9, "_encstr_852F09FA41FB7ADB3968C4");
      }

      if(var_1.pers["_encstr_8AEF05472BC2D6"] == level.cyberemp.ownerteam && var_1 != level.cyberemp.carrier) {
        var_17 = distancesquared(level.cyberemp.carrier.origin, var_15);

        if(var_17 < 105625) {
          var_1 thread scripts\mp\rank::scoreeventpopup("_encstr_A20C07ABF304625E08");
          var_1 thread scripts\mp\awards::givemidmatchaward("_encstr_93D80ED6F646B2AFF0EB1995CCCA3791");
          var_1 scripts\mp\utility\stats::incpersstat("_encstr_B1F7085B03F492AE98DB", 1);
          var_1 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_B1F7085B03F492AE98DB", var_1.pers["_encstr_B1F7085B03F492AE98DB"]);
          thread scripts\common\utility::_id_13E0A(level._id_11B30, var_9, "_encstr_ABA70A195633CADC324BDC76");
        }
      }
    }
  }

  foreach(var_19 in level.objectives) {
    if(istrue(var_19.trigger.trigger_off)) {
      continue;
    }
    var_20 = var_19 scripts\mp\gameobjects::getownerteam();

    if(var_20 != var_1.team) {
      var_21 = distsquaredcheck(var_19.trigger, var_15, var_14);

      if(var_21) {
        var_11 = 1;
        var_1 thread scripts\mp\rank::scoreeventpopup("_encstr_AB3508737F830710ACDB");
        var_1 thread scripts\mp\awards::givemidmatchaward("_encstr_8E020FAB6877F10FCBEFD81F63FB9B901C");
        var_19 notify("_encstr_AB3508737F830710ACDB", var_1);
        thread scripts\common\utility::_id_13E0A(level._id_11B26, var_9, "_encstr_9AD10BF61657A2CD30606F6BE0");
        continue;
      }
    } else {
      var_22 = distsquaredcheck(var_19.trigger, var_15, var_14);

      if(var_22) {
        var_12 = 1;
        var_1 thread scripts\mp\rank::scoreeventpopup("_encstr_A20C07ABF304625E08");
        var_1 thread scripts\mp\awards::givemidmatchaward("_encstr_93D80ED6F646B2AFF0EB1995CCCA3791");
        var_19 notify("_encstr_A20C07ABF304625E08", var_1);
        var_1 scripts\mp\utility\stats::incpersstat("_encstr_B1F7085B03F492AE98DB", 1);
        var_1 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_B1F7085B03F492AE98DB", var_1.pers["_encstr_B1F7085B03F492AE98DB"]);
        thread scripts\common\utility::_id_13E0A(level._id_11B26, var_9, "_encstr_ABA70A195633CADC324BDC76");
        continue;
      }
    }
  }
}

distsquaredcheck(var_0, var_1, var_2) {
  var_3 = distancesquared(var_0.origin, var_1);
  var_4 = distancesquared(var_0.origin, var_2);

  if(var_3 < 105625 || var_4 < 105625) {
    if(!isDefined(var_0.modifieddefendcheck))
      return 1;
    else if(var_1[2] - var_0.origin[2] < 100 || var_2[2] - var_0.origin[2] < 100)
      return 1;
    else
      return 0;
  } else
    return 0;
}

empradarwatcher() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_AB3D0DE25FE81EF7B7188A42230553");
  self endon("_encstr_8FE01132F817F3978BE5B9BEF5567FBB5B183B");
  self.radarpingtime = gettime();
  self.nextradarpingtime = self.radarpingtime;
  thread weaponswapwatcher();

  for(;;) {
    if(self.currentprimaryweapon.basename == "_encstr_976A10EB17828EAF30525010DACD41460FB8") {
      while(self.currentprimaryweapon.basename == "_encstr_976A10EB17828EAF30525010DACD41460FB8" && gettime() > self.nextradarpingtime) {
        triggeroneoffradarsweep(self);
        self.radarpingtime = gettime();
        self.nextradarpingtime = gettime() + level.radarpingtime * 1000;
        thread waitandwatchradarsweep();
        self waittill("_encstr_97C20CBEE91BA17541AAE0808264");
      }
    }

    waitframe();
  }
}

weaponswapwatcher() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_AB3D0DE25FE81EF7B7188A42230553");
  self._id_1334E = 0;

  for(;;) {
    if(self.currentprimaryweapon.basename == "_encstr_976A10EB17828EAF30525010DACD41460FB8") {
      if(!istrue(self._id_1334E)) {
        scripts\mp\utility\player::showminimap();
        self._id_1334E = 1;
      }
    } else if(istrue(self._id_1334E)) {
      scripts\mp\utility\player::hideminimap();
      self._id_1334E = 0;
    }

    waitframe();
  }
}

waitandwatchradarsweep() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_AB3D0DE25FE81EF7B7188A42230553");
  self endon("_encstr_8FE01132F817F3978BE5B9BEF5567FBB5B183B");
  var_0 = gettime() + level.radarpingtime * 1000;

  while(gettime() < var_0) {
    if(isDefined(level.cyberemp.carrier) && self == level.cyberemp.carrier && self.currentprimaryweapon.basename == "_encstr_976A10EB17828EAF30525010DACD41460FB8") {
      waitframe();
      continue;
    }

    break;
  }

  self notify("_encstr_97C20CBEE91BA17541AAE0808264");
}

applybombcarrierclass() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(self.iscarrying) && self.iscarrying == 1) {
    self notify("_encstr_A17817D81A7237598763B7387BB7A0875A926868D2CD637003");
    waitframe();
  }

  while(self ismantling())
    waitframe();

  while(!self isonground())
    waitframe();

  self.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"] = level.cyber_loadouts[self.team];
  scripts\mp\equipment\tac_insert::_id_13684(self.origin, self.angles);
  self.gamemode_chosenclass = self.class;
  self.pers["_encstr_959506B911C79707"] = "_encstr_AAAC09D09972B9C83F2B7F";
  self.pers["_encstr_92690A5B078ED325F539E25E"] = "_encstr_AAAC09D09972B9C83F2B7F";
  self.class = "_encstr_AAAC09D09972B9C83F2B7F";
  self.lastclass = "_encstr_AAAC09D09972B9C83F2B7F";
  self notify("_encstr_91D70BC8AF032B0F1B734F731A");
  self.gameobject_fauxspawn = 1;
  self.faux_spawn_stance = self getstance();
  thread scripts\mp\playerlogic::spawnplayer(1);
}

removebombcarrierclass() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(self.iscarrying) && self.iscarrying == 1) {
    self notify("_encstr_A17817D81A7237598763B7387BB7A0875A926868D2CD637003");
    waitframe();
  }

  while(self ismantling())
    waitframe();

  while(!self isonground())
    waitframe();

  self notify("_encstr_A94D10C67BDC3A7D53BACE7695E4E616BA1D");
  waitframe();
  self.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"] = undefined;
  scripts\mp\equipment\tac_insert::_id_13684(self.origin, self.angles);
  self notify("_encstr_91D70BC8AF032B0F1B734F731A");
  self.faux_spawn_stance = self getstance();
  thread scripts\mp\playerlogic::spawnplayer(1);
}

setcarriervisibility() {
  if(isDefined(level.showenemycarrier)) {
    switch (level.showenemycarrier) {
      case 0:
        level.cyberemp.objidpingfriendly = 1;
        level.cyberemp.objidpingenemy = 0;
        level.cyberemp.objpingdelay = 0.0;
        break;
      case 1:
        level.cyberemp.objidpingfriendly = 0;
        level.cyberemp.objidpingenemy = 0;
        level.cyberemp.objpingdelay = 0.05;
        break;
      case 2:
        level.cyberemp.objidpingfriendly = 1;
        level.cyberemp.objidpingenemy = 0;
        level.cyberemp.objpingdelay = 1.0;
        break;
      case 3:
        level.cyberemp.objidpingfriendly = 1;
        level.cyberemp.objidpingenemy = 0;
        level.cyberemp.objpingdelay = 1.5;
        break;
      case 4:
        level.cyberemp.objidpingfriendly = 1;
        level.cyberemp.objidpingenemy = 0;
        level.cyberemp.objpingdelay = 2.0;
        break;
      case 5:
        level.cyberemp.objidpingfriendly = 1;
        level.cyberemp.objidpingenemy = 0;
        level.cyberemp.objpingdelay = 3.0;
        break;
      case 6:
        level.cyberemp.objidpingfriendly = 1;
        level.cyberemp.objidpingenemy = 0;
        level.cyberemp.objpingdelay = 4.0;
        break;
    }
  } else {
    level.cyberemp.objidpingfriendly = 1;
    level.cyberemp.objidpingenemy = 0;
    level.cyberemp.objpingdelay = 3.0;
  }
}

onexfilstarted() {
  level.cyberemp scripts\mp\gameobjects::releaseid();

  if(isDefined(level.cyberemp.carrier)) {
    foreach(var_1 in level.objectives) {
      if(var_1.bombplanted == 0)
        var_1.trigger disableplayeruse(level.cyberemp.carrier);
    }
  }

  level.cyberemp.trigger delete();
  level.cyberemp.visuals[0] delete();
}

emplightsoff() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_8F190ECD11ABDF8753307A6270993FCB");

  for(;;) {
    foreach(var_1 in level.emplights) {
      var_1.switchstatus = "_encstr_BA19049F4B2D";
      handleemponoff(var_1);
    }

    wait 0.1;

    foreach(var_1 in level.emplights) {
      var_1.switchstatus = "_encstr_AB0703DBB9";
      handleemponoff(var_1);
    }

    wait 0.15;

    foreach(var_1 in level.emplights) {
      var_1.switchstatus = "_encstr_BA19049F4B2D";
      handleemponoff(var_1);
    }

    wait 0.1;

    foreach(var_1 in level.emplights) {
      var_1.switchstatus = "_encstr_AB0703DBB9";
      handleemponoff(var_1, 0.05);
    }

    wait 0.5;

    foreach(var_1 in level.emplights) {
      var_1.switchstatus = "_encstr_BA19049F4B2D";
      handleemponoff(var_1);
    }

    wait 10;
  }
}

destroytvs() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_8F190ECD11ABDF8753307A6270993FCB");
  var_0 = getEntArray("_encstr_A1AB10A52BCB8380A5B983CF8E7B22F735FB", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  foreach(var_2 in var_0) {
    var_3 = getscriptablearray(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    foreach(var_5 in var_3) {
      var_5 setscriptablepartstate("_encstr_9707038E3B", "_encstr_84670547C3E9F4");
      waitframe();
    }
  }
}

handleemponoff(var_0, var_1) {
  var_2 = 0.2;

  if(isDefined(var_1))
    var_2 = var_1;

  if(var_0.switchstatus == "_encstr_AB0703DBB9") {
    self notify("_encstr_95741038825FB5A01AD397A31C8610E887CA");

    if(!var_0.lightson) {
      foreach(var_4 in var_0.lights)
      var_4 thread scripts\mp\motiondetectors::lightonroutine(randomfloat(var_2));

      thread scripts\mp\motiondetectors::onoffmodelswap(var_0.models, "_encstr_AB0703DBB9");
      var_0.lightson = 1;
    }
  } else if(var_0.switchstatus == "_encstr_BA19049F4B2D") {
    if(var_0.lightson) {
      level scripts\mp\motiondetectors::lightoffroutine(var_0.lights);
      thread scripts\mp\motiondetectors::onoffmodelswap(var_0.models, "_encstr_BA19049F4B2D");
      var_0.lightson = 0;
    }

    if(isDefined(self.script_parameters) && self.script_parameters == "_encstr_8AB00750CA2393A8F3")
      var_0.switchstatus = "_encstr_8AB00750CA2393A8F3";

    self notify("_encstr_9AD50BF4237933936F798A1258");
  }
}

setupwaypointicons() {
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_8B0D122DD87B73AFBB16970EBDD2CDA3D7CAADC1", 2, "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_84F31C9459A9CBC8F549B91D263F9C20EB26B8124B991FA089B7FED72209", "_encstr_8A66141A5D23F596C6B79BF56CBCC495C9D74CBDB54C", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_973F1961B6E8BB2917F87BE3A0035D6B462DE3E3D8139BE1EB60F3", 1, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_A9D31F47930EB139D77635ABC658F021B92F1F7D34AF838F9BAF8901F14FE0FBDB", "_encstr_8A66141A5D23F596C6B79BF56CBCC495C9D74CBDB54C", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_A9A41DBB73AFD8A7C332E0B0CA1C8DD3171C35A4CD03415FAFDAA0A0C27343", 0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_ACB71FA04759DCD6891D9554091C3EFCE1D6B7E6FA7184F94D086C08079BEF0FCA", "_encstr_AD361D5AA1786B0160239180274895CB8859D372C94EF706C813828BC3881F", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_8FDD1D18D0F22D574737B88A3A1333B41F51477A5C63EB119DC88BD77C800D", 0, "_encstr_88BF06FD784A6393", "_encstr_B6C31F1D67EFC016B5695F67816CDE581B201546C2471874BF416F5769C589E1A7", "_encstr_AD361D5AA1786B0160239180274895CB8859D372C94EF706C813828BC3881F", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_B6491EF2E00738510703477FB00BFDF317AB75D2DD33B57DD7756AFBCF393980", 0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_ACB71FA04759DCD6891D9554091C3EFCE1D6B7E6FA7184F94D086C08079BEF0FCA", "_encstr_AD361D5AA1786B0160239180274895CB8859D372C94EF706C813828BC3881F", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_8F8D1DB306777A19DFE303D06A0C0EECA1DA3A9B356BB987E5506B6760E3F2", 0, "_encstr_88BF06FD784A6393", "_encstr_97851F04A9D703D14FD90B03DFA5197937B6DC6DB07FCDF157E53F0B379E393FB7", "_encstr_AD361D5AA1786B0160239180274895CB8859D372C94EF706C813828BC3881F", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_AA751B2DC67B73BEBB589783DBB4DCE8BECA6B07D7E036C237E82D739D", 0, "_encstr_88BF06FD784A6393", "_encstr_93B221C1EBF78C3DE8C62925A980F5D409FE49313B5FE741D03DBDDBF5388F7DB99B21", "_encstr_AD361D5AA1786B0160239180274895CB8859D372C94EF706C813828BC3881F", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_AD011BD21B7BB9EBEE585E38DEA5E6D1D795AD83F59156CCD537A5DC76", 0, "_encstr_88BF06FD784A6393", "_encstr_B494219439479341FF69BB934FD589C987262CFDA4EF5D41C7158F83B60F39068F6927", "_encstr_AD361D5AA1786B0160239180274895CB8859D372C94EF706C813828BC3881F", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_A296208850B756B97B01938B9A0AD35BD1295F1FB76A0167B71F4B9888DB5BE95D9B", 0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_B40101", "_encstr_AD361D5AA1786B0160239180274895CB8859D372C94EF706C813828BC3881F", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_883B20303938E81677276038F7AA18C3E902CDDBBBEB3D1779A3613B107B9587989B", 0, "_encstr_88BF06FD784A6393", "_encstr_B40101", "_encstr_AD361D5AA1786B0160239180274895CB8859D372C94EF706C813828BC3881F", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_8DA01EB51B767DA5C6B7E6BEDD2CCBC17BD2378EBECADA38D71CD816DCA3B219", 0, "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_B40101", "_encstr_913D2639FEA0F3919B70D2BA48DB127F18D6B2AD062B37E3A3A90AD228378E7713CD121F2E106F2E", 0);
}