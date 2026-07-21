/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\cranked.gsc
***********************************************/

main() {
  if(getDvar("_encstr_9570084B1793A090CDFF") == "_encstr_8D510E52E3A7C6985EB7B9BE2F35C690") {
    return;
  }
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  var_0[0] = scripts\mp\utility\game::getgametype();
  scripts\mp\gameobjects::main(var_0);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 0, 0, 9);
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 10);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 100);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  }

  level.teambased = getdvarint("_encstr_92DA169B20BBF093FDE77017333B91D9C3F091DD0E7BBDA2", 1) == 1;
  level.onstartgametype = ::onstartgametype;
  level.onplayerconnect = ::onplayerconnect;
  level.getspawnpoint = ::getspawnpoint;
  level.onnormaldeath = ::onnormaldeath;

  if(!level.teambased) {
    level.onplayerscore = ::onplayerscore;
    setDvar("_encstr_B65C179BC639AFB14EC29B6D5919EB9BC6BD4E2BC65ADA4B1D", getdvarint("_encstr_934E1B1ECB6346772AAAB09082C7579B8F7F269D2CF7C8AB935188E0FA", 60));
    setteammode("_encstr_AC18045DF6D6");
  }

  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_8E9E088D9C58E65B2B19";

  if(getdvarint("_encstr_B2020AE1F36BF74429D93F01"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_8A19042AB017" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];
  else if(getdvarint("_encstr_82570B397A4D3192935192A562"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_979708CC69F02253FF26" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];
  else if(getdvarint("_encstr_96050CDCD839EB46B4560D58938C"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_B21804C8D0D7" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];
  else if(getdvarint("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_95B909F7CB45A81F58EF63"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] + "_encstr_824305B93705A7";

  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_95240C659372588E43623137DE6C"] = "_encstr_B2A90A2ECDD597D791BF80E5";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A9800ED8CB3867550156E23BC67AD9CB"] = "_encstr_84320D0EB27BA87716F3D0905AAFC9";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AAA71213C043F5617F2D7E758009FB8768D89BC3"] = "_encstr_BA1509699A6650A0528FC9";
  game["_encstr_A1B10847BD1A23B8FA8B"]["_encstr_A5EE0E780BFD08A5321F7B07635AE040"] = &"_encstr_8F180FE58F40BBCC3D09C97169E9B567C5";
}

onplayerconnect(var_0) {
  var_0 thread onplayerspawned();
}

onplayerspawned() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;)
    self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("_encstr_AB591886E61B875942AF5040876C1615128BF0857AE353E33BE3", 0);
  scripts\mp\utility\game::registerroundswitchdvar("_encstr_8E9E088D9C58E65B2B19", 0, 0, 9);
  setdynamicdvar("_encstr_8B1D178750030F62BDEFFDB4C54979EA48187B4380D8658AD9", 1);
  scripts\mp\utility\game::registerroundlimitdvar("_encstr_8E9E088D9C58E65B2B19", 1);
  setdynamicdvar("_encstr_B13715BFD77BF0781A36B810DFF4611C227B093347922D", 1);
  scripts\mp\utility\game::registerwinlimitdvar("_encstr_8E9E088D9C58E65B2B19", 1);
  setdynamicdvar("_encstr_A6FD154771E851115BB9804AE1C4CE9C0FE9EA83074845", 0);
  scripts\mp\utility\game::registerhalftimedvar("_encstr_8E9E088D9C58E65B2B19", 0);
  setdynamicdvar("_encstr_8864147B50AD91CF73875E43AD9977E215980232906B", 0);
}

onstartgametype() {
  setclientnamemode("_encstr_B6900C7BCDABC8AF2722B158FA17");

  if(!isDefined(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]))
    game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"] = 0;

  if(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]) {
    var_0 = game["_encstr_991C0AB9ED5B57161FE89B83"];
    var_1 = game["_encstr_B6A70A23CA6659DC91CAE4DC"];
    game["_encstr_991C0AB9ED5B57161FE89B83"] = var_1;
    game["_encstr_B6A70A23CA6659DC91CAE4DC"] = var_0;
  }

  var_2 = &"_encstr_A5660F7F6E627D337D2B17E9A21DD98F75";
  var_3 = &"_encstr_8E0115EFFEFCF57FDDF961736767B9353A5927B7BFB66F";
  var_4 = &"_encstr_9A1A147A4825518645A495A2A6BCD50A92BE09A49C8A";

  if(!level.teambased) {
    var_2 = &"_encstr_8B3F0E27AD52BB87E1731E6F917E1C80";
    var_3 = &"_encstr_8DE9146F1A5030357961F45DAF3727203969A6B4F14F";
    var_4 = &"_encstr_95BF13F448528A348A2565A86AF2449AF5844A278A";
  }

  foreach(var_6 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var_6, var_2);

    if(level.splitscreen)
      scripts\mp\utility\game::setobjectivescoretext(var_6, var_2);
    else
      scripts\mp\utility\game::setobjectivescoretext(var_6, var_3);

    scripts\mp\utility\game::setobjectivehinttext(var_6, var_4);
  }

  initspawns();
  cranked();
}

initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);

  if(level.teambased) {
    scripts\mp\spawnlogic::setactivespawnlogic("_encstr_8B1608CC43B8D647A113", "_encstr_A6E80F61DA270BDE09B2C8C33B40AB859D");
    scripts\mp\spawnlogic::addstartspawnpoints("_encstr_A1C01A915857A3F96DC9D8C84283B59E07FCA91BA51F0E1F1332A8F0");
    scripts\mp\spawnlogic::addstartspawnpoints("_encstr_8AF71849707F8BC155E180A03AEB9DA6DF10C33EC76733137ABB");
    scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD");
    scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD");
    scripts\mp\spawnlogic::registerspawnset("_encstr_820E07FAE8780B3A4C", "_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD");
    scripts\mp\spawnlogic::registerspawnset("_encstr_AD0C095DF195E8B6074A18", "_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318");
  } else {
    scripts\mp\spawnlogic::setactivespawnlogic("_encstr_838B0B942AE27B65C76B91F03B", "_encstr_829A0D0F1AF8FB5ED127855073F940");
    scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_8A550CA8037FCD9021830923AF55");
    scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_8A550CA8037FCD9021830923AF55");
    scripts\mp\spawnlogic::registerspawnset("_encstr_820E07FAE8780B3A4C", "_encstr_8A550CA8037FCD9021830923AF55");
    scripts\mp\spawnlogic::registerspawnset("_encstr_AD0C095DF195E8B6074A18", "_encstr_BA891631A8D8EDA759B36AC36B3A1F3E62C34FBB35138B50");
  }

  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

getspawnpoint() {
  if(level.teambased) {
    var_0 = self.pers["_encstr_8AEF05472BC2D6"];

    if(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"])
      var_0 = scripts\mp\utility\game::getotherteam(var_0)[0];

    if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
      var_1 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_A1BD0E5B07D7E823D6D7371C58BB37F5" + var_0 + "_encstr_B4810709B378B9F3F5");
      var_2 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_1);
    } else
      var_2 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, "_encstr_820E07FAE8780B3A4C", "_encstr_AD0C095DF195E8B6074A18");
  } else if(level.ingraceperiod) {
    var_1 = scripts\mp\spawnlogic::getteamspawnpoints(self.team);
    var_2 = scripts\mp\spawnlogic::getspawnpoint_random(var_1);
  } else
    var_2 = scripts\mp\spawnlogic::getspawnpoint(self, "_encstr_8BBA05185F8B99", "_encstr_820E07FAE8780B3A4C", "_encstr_AD0C095DF195E8B6074A18");

  return var_2;
}

onnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 cleanupcrankedtimer();
  var_6 = scripts\mp\rank::getscoreinfovalue("_encstr_A68210DFBFAF8BEFB7C7E03172C73B106349");

  if(isDefined(var_1.cranked)) {
    var_6 = var_6 * 2;
    var_7 = "_encstr_856A0D6A9001CDAFA1FEA1D61A090B";
    var_1 thread onkill(var_7);
    var_1.pers["_encstr_8B560B62B16B5067FCFAB88833"]++;
    var_1 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_8B560B62B16B5067FCFAB88833", var_1.pers["_encstr_8B560B62B16B5067FCFAB88833"]);
  } else if(scripts\mp\utility\player::isreallyalive(var_1))
    var_1 makecranked("_encstr_A9800ED8CB3867550156E23BC67AD9CB");

  if(isDefined(var_0.attackers) && !isDefined(level.assists_disabled)) {
    foreach(var_9 in var_0.attackers) {
      if(!isDefined(scripts\mp\utility\damage::_validateattacker(var_9))) {
        continue;
      }
      if(var_9 == var_1) {
        continue;
      }
      if(var_0 == var_9) {
        continue;
      }
      if(!isDefined(var_9.cranked)) {
        continue;
      }
      var_9 thread onassist("_encstr_9B300F177E2B736E533F69D3910E3AB191");
    }
  }

  if(level.teambased)
    level scripts\mp\gamescore::giveteamscoreforobjective(var_1.pers["_encstr_8AEF05472BC2D6"], var_6, 0);
  else {
    var_11 = 0;

    foreach(var_9 in level.players) {
      if(isDefined(var_9.score) && var_9.score > var_11)
        var_11 = var_9.score;
    }
  }
}

cleanupcrankedtimer() {
  self setclientomnvar("_encstr_A74C2765C3E9CED3AFE89A62B1E8DB856BBDD7EC7BD0972B58A1C27ABED92FBDA033734587181D3B76", 0);
  self.cranked = undefined;
  self.cranked_end_time = undefined;
}

ontimelimit() {
  var_0 = scripts\mp\gamescore::gethighestscoringteam();

  if(game["_encstr_A16D07532531CB4BF7"] == "_encstr_8B6D0940CC35339149DA08")
    var_0 = "_encstr_91AB08AC45BB5539F95B";
  else if(var_0 == "_encstr_8D19048EA595")
    var_0 = "_encstr_8B6D0940CC35339149DA08";

  thread scripts\mp\gamelogic::endgame(var_0, game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_B40B13237BEFC5278BC385D3C98FEA8518524C203D"]);
}

onplayerscore(var_0, var_1) {
  if(var_0 != "_encstr_B66D0B6EEA0ECAC9EB6DA536B1" && issubstr(var_0, "_encstr_ABD70578F3D02C")) {
    var_2 = scripts\mp\rank::getscoreinfovalue("_encstr_A68210DFBFAF8BEFB7C7E03172C73B106349");

    if(isDefined(var_1.cranked))
      var_2 = var_2 * 2;

    return var_2;
  }

  return 0;
}

cranked() {
  level.crankedbombtimer = 30;
}

makecranked(var_0) {
  scripts\mp\utility\dialog::leaderdialogonplayer(var_0);
  thread scripts\mp\rank::scoreeventpopup(var_0);
  setcrankedbombtimer("_encstr_ABD70578F3D02C");
  self.cranked = 1;
  scripts\mp\utility\perk::giveperk("_encstr_ACFE154BF8B3AED741511421E089BFF2C98052329813A7");
  scripts\mp\utility\perk::giveperk("_encstr_95291462CB42688901F2836F40AADF6F1E5B49EDAB27");
  scripts\mp\utility\perk::giveperk("_encstr_914F16A370BF7614A9F38B9F993B399B21980493A0CF2045");
  scripts\mp\utility\perk::giveperk("_encstr_92891DBB833D1FCC9079DCC907F09617DD9B033308379BC2584FCFCE1B7858");
  scripts\mp\utility\perk::giveperk("_encstr_83121363D8BDF7A3B9CD7BDBC7D1398248FB828218");
  scripts\mp\utility\perk::giveperk("_encstr_A5AC149BA31D3FECB019BCA96768B35FB6781343696F");
  scripts\mp\utility\perk::giveperk("_encstr_AB6D127F07796F1BA8D24DDF5FB80B504DC2B392");
  self.movespeedscaler = 1.2;
  scripts\mp\weapons::updatemovespeedscale();
}

onkill(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  while(!isDefined(self.pers))
    waitframe();

  thread scripts\mp\utility\points::giveunifiedpoints(var_0);
  setcrankedbombtimer("_encstr_ABD70578F3D02C");
}

onassist(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  thread scripts\mp\rank::scoreeventpopup(var_0);
  setcrankedbombtimer("_encstr_A1BD075837DCD29B47");
}

watchbombtimer(var_0) {
  self notify("_encstr_97CE0FD3A849463BDD38E5E25D40D70FAD");
  self endon("_encstr_97CE0FD3A849463BDD38E5E25D40D70FAD");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = 5;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0 - var_1 - 1);
  scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_AAA71213C043F5617F2D7E758009FB8768D89BC3");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.0);

  while(var_1 > 0) {
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.0);
    var_1--;
  }

  if(isDefined(self) && scripts\mp\utility\player::isreallyalive(self)) {
    self playSound("_encstr_AF36183D3BE24401679AA1D8464C18901ABB89A1F7DB96C8B632");
    scripts\mp\utility\damage::_suicide();
    self setclientomnvar("_encstr_A74C2765C3E9CED3AFE89A62B1E8DB856BBDD7EC7BD0972B58A1C27ABED92FBDA033734587181D3B76", 0);
  }
}

setcrankedbombtimer(var_0) {
  var_1 = level.crankedbombtimer;

  if(var_0 == "_encstr_A1BD075837DCD29B47")
    var_1 = int(min((self.cranked_end_time - gettime()) / 1000 + level.crankedbombtimer * 0.5, level.crankedbombtimer));

  var_2 = var_1 * 1000 + gettime();
  self setclientomnvar("_encstr_A74C2765C3E9CED3AFE89A62B1E8DB856BBDD7EC7BD0972B58A1C27ABED92FBDA033734587181D3B76", var_2);
  self.cranked_end_time = var_2;
  thread watchcrankedhostmigration();
  thread watchbombtimer(var_1);
  thread watchendgame();
}

watchcrankedhostmigration() {
  self notify("_encstr_AF911A1F91F3F0D3EFFBF9CD722F9DE14DFB91F3319FA0AFDB623008");
  self endon("_encstr_AF911A1F91F3F0D3EFFBF9CD722F9DE14DFB91F3319FA0AFDB623008");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level waittill("_encstr_AD3F1534DB9BA3BEADD27627B0D1B4BDCDAFC495EC2DCD");
  self setclientomnvar("_encstr_BD0619A321915806BFD240895A6F3DB0B585357FC383F04FA31AB9", 1);
  var_0 = scripts\mp\hostmigration::waittillhostmigrationdone();
  self setclientomnvar("_encstr_BD0619A321915806BFD240895A6F3DB0B585357FC383F04FA31AB9", 0);

  if(var_0 > 0)
    self setclientomnvar("_encstr_A74C2765C3E9CED3AFE89A62B1E8DB856BBDD7EC7BD0972B58A1C27ABED92FBDA033734587181D3B76", self.cranked_end_time + var_0);
  else
    self setclientomnvar("_encstr_A74C2765C3E9CED3AFE89A62B1E8DB856BBDD7EC7BD0972B58A1C27ABED92FBDA033734587181D3B76", self.cranked_end_time);
}

watchendgame() {
  self notify("_encstr_AA470D6B3125AF3C01ED5C078B3807");
  self endon("_encstr_AA470D6B3125AF3C01ED5C078B3807");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  for(;;) {
    if(game["_encstr_A1AD062E09D98338"] == "_encstr_ACE709DA22939BA8075060" || level.gameended) {
      self setclientomnvar("_encstr_A74C2765C3E9CED3AFE89A62B1E8DB856BBDD7EC7BD0972B58A1C27ABED92FBDA033734587181D3B76", 0);
      break;
    }

    wait 0.1;
  }
}