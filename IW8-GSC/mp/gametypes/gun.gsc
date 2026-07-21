/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\gun.gsc
***********************************************/

main() {
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  var_0 = [];
  scripts\mp\gameobjects::main(var_0);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 600);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  }

  setspecialloadout();
  updategametypedvars();
  setgunladder();
  setteammode("_encstr_AC18045DF6D6");
  level.teambased = 0;
  level.ignorekdrstats = 1;
  level.loadoutdefaultfiresalediscount = 1;
  thread waitthensetstatgroupreadonly();
  level.doprematch = 1;
  level.supportintel = 0;
  level.supportnuke = 0;
  level.disablecopycatloadout = 1;
  setomnvar("_encstr_88D613AE96AFB6D21B8DB12CADAFC6DBC15E1BB0A3", 0);
  level.onprecachegametype = ::onprecachegametype;
  level.onstartgametype = ::onstartgametype;
  level.onplayerconnect = ::onplayerconnect;
  level.modeonspawnplayer = ::onspawnplayer;
  level.getspawnpoint = ::getspawnpoint;
  level.onplayerkilled = ::onplayerkilled;
  level.ontimelimit = ::ontimelimit;
  level.onplayerscore = ::onplayerscore;
  level.bypassclasschoicefunc = ::alwaysgamemodeclass;
  level.modifyunifiedpointscallback = ::modifyunifiedpointscallback;
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_99A1111731E22F9D58834D8932B36EF7877D10";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_91B2067E0898939B"] = "_encstr_9B3D0E89BDDBB9A3EB3BAEE69DC25BB2";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_95240C659372588E43623137DE6C"] = "_encstr_9B3D0E89BDDBB9A3EB3BAEE69DC25BB2";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_93420C4255FBEA5D408FD1FD2A62"] = "_encstr_9B3D0E89BDDBB9A3EB3BAEE69DC25BB2";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_87F10F780AC2C9AB8F550E902DEBF1B328"] = "_encstr_87F10F780AC2C9AB8F550E902DEBF1B328";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BED512F19EF32933D127385903E2A8B38A477983"] = "_encstr_BED512F19EF32933D127385903E2A8B38A477983";
}

waitthensetstatgroupreadonly() {
  self endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 1;

  if(isDefined(level.playerstats)) {
    scripts\mp\playerstats_interface::makeplayerstatgroupreadonly("_encstr_931904C47403");
    scripts\mp\playerstats_interface::makeplayerstatgroupreadonly("_encstr_956807294FC34ED073");
    scripts\mp\playerstats_interface::makeplayerstatgroupreadonly("_encstr_95FF08BB2D73137BDCE6");
  }
}

alwaysgamemodeclass() {
  return "_encstr_AAAC09D09972B9C83F2B7F";
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata(1);
  setdynamicdvar("_encstr_A69F106B46DACF57DFABD8676F1521362670", getmatchrulesdata("_encstr_9A4C082785F02B6ED920", "_encstr_AD30089B2B8E26588DD6"));
  setdynamicdvar("_encstr_920116BFD77BF0581DF59E13DFE48817826F77093B52A770", getmatchrulesdata("_encstr_9A4C082785F02B6ED920", "_encstr_8D6B0EE6ACE8C40B6CAD4D8E3995855B"));
  setdynamicdvar("_encstr_A26B1738923A174167D61072B96B6817EA5A88916A16819833", getmatchrulesdata("_encstr_9A4C082785F02B6ED920", "_encstr_86BE0FC00A8579CBEBD58E14AD57D3376D"));
  setdynamicdvar("_encstr_A3511496F60B97C955A3E968879C612BF3948095CF03", getmatchrulesdata("_encstr_9A4C082785F02B6ED920", "_encstr_B2F30C08DEECA83DB3BF7D61273B"));
  setdynamicdvar("_encstr_BA0310CDC693D79DBA9BBE3893F6B6F64656", 0);
}

onprecachegametype() {}

onstartgametype() {
  setclientnamemode("_encstr_B6900C7BCDABC8AF2722B158FA17");

  foreach(var_1 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var_1, &"_encstr_8B3F0E27AD52BB87E1731E6F917E1C80");

    if(level.splitscreen)
      scripts\mp\utility\game::setobjectivescoretext(var_1, &"_encstr_8B3F0E27AD52BB87E1731E6F917E1C80");
    else
      scripts\mp\utility\game::setobjectivescoretext(var_1, &"_encstr_8DE9146F1A5030357961F45DAF3727203969A6B4F14F");

    scripts\mp\utility\game::setobjectivehinttext(var_1, &"_encstr_95BF13F448528A348A2565A86AF2449AF5844A278A");
  }

  setgunsfinal();
  scripts\mp\spawnlogic::setactivespawnlogic("_encstr_838B0B942AE27B65C76B91F03B", "_encstr_829A0D0F1AF8FB5ED127855073F940");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addstartspawnpoints("_encstr_858C12AF1A37B997E9607371037AA963717F2D9B", 1);
  scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_8A550CA8037FCD9021830923AF55");
  scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_BA891631A8D8EDA759B36AC36B3A1F3E62C34FBB35138B50", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_8A550CA8037FCD9021830923AF55");
  scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_BA891631A8D8EDA759B36AC36B3A1F3E62C34FBB35138B50", 1, 1);
  var_3 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_8A550CA8037FCD9021830923AF55");
  var_4 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_BA891631A8D8EDA759B36AC36B3A1F3E62C34FBB35138B50");
  scripts\mp\spawnlogic::registerspawnset("_encstr_820E07FAE8780B3A4C", var_3);
  scripts\mp\spawnlogic::registerspawnset("_encstr_AD0C095DF195E8B6074A18", var_4);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  level.quickmessagetoall = 1;
  level.blockweapondrops = 1;
}

updategametypedvars() {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::updatecommongametypedvars();
  level.setback = scripts\mp\utility\dvars::dvarintvalue("_encstr_AD30089B2B8E26588DD6", 1, 0, 5);
  level.setbackstreak = scripts\mp\utility\dvars::dvarintvalue("_encstr_8D6B0EE6ACE8C40B6CAD4D8E3995855B", 0, 0, 5);
  level.killsperweapon = scripts\mp\utility\dvars::dvarintvalue("_encstr_86BE0FC00A8579CBEBD58E14AD57D3376D", 1, 1, 5);
  level.ladderindex = scripts\mp\utility\dvars::dvarintvalue("_encstr_B2F30C08DEECA83DB3BF7D61273B", 1, 1, 6);
}

onplayerconnect(var_0) {
  var_0 thread keepweaponsloaded();
  var_0.pers["_encstr_959506B911C79707"] = "_encstr_AAAC09D09972B9C83F2B7F";
  var_0.pers["_encstr_92690A5B078ED325F539E25E"] = "_encstr_B40101";
  var_0.class = var_0.pers["_encstr_959506B911C79707"];
  var_0.lastclass = var_0.pers["_encstr_92690A5B078ED325F539E25E"];
  var_0.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"] = level.gun_loadouts["_encstr_8E8405EA382B2A"];
  var_0.gungamegunindex = 0;
  var_0.gungameprevgunindex = 0;
  var_0 thread refillammo();
  var_0 thread refillsinglecountammo();
}

keepweaponsloaded() {
  self loadweaponsforplayer([level.gun_guns[0], level.gun_guns[1]], 1);
  var_0 = [];

  for(;;) {
    self waittill("_encstr_95481357388C581D59AF1BBDC291BB56C207EDCDDC");
    var_0[0] = level.gun_guns[int(max(0, self.gungamegunindex - level.setback))];
    var_0[1] = level.gun_guns[self.gungamegunindex];
    var_0[2] = level.gun_guns[self.gungamegunindex + 1];
    self loadweaponsforplayer(var_0, 1);
  }
}

getspawnpoint() {
  if(level.ingraceperiod) {
    var_0 = undefined;
    var_1 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_858C12AF1A37B997E9607371037AA963717F2D9B");

    if(var_1.size > 0) {
      if(!isDefined(level.requiresminstartspawns)) {}

      var_0 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_1, 1);
    }

    if(!isDefined(var_0)) {
      var_1 = scripts\mp\spawnlogic::getteamspawnpoints(self.team);
      var_0 = scripts\mp\spawnscoring::getstartspawnpoint_freeforall(var_1);
    }

    return var_0;
  }

  var_0 = scripts\mp\spawnlogic::getspawnpoint(self, "_encstr_8BBA05185F8B99", "_encstr_820E07FAE8780B3A4C", "_encstr_AD0C095DF195E8B6074A18");
  return var_0;
}

onspawnplayer() {
  self setclientomnvar("_encstr_9B061AD54B7D5B0B3AC61A7DE6D1C247ABDC7DA1B4DC1DD78ECA87E8", 0);
  thread waitloadoutdone();
  level notify("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
}

waitloadoutdone() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");

  if(level.gameended && self.gungamegunindex == level.gun_guns.size)
    self.gungamegunindex = self.gungameprevgunindex;

  scripts\mp\utility\perk::giveperk("_encstr_BE13109B83ACC6B40BC6E85E7DC41B2DCD3B");
  thread givenextgun(1);
}

onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(level.gameended) {
    return;
  }
  if(var_3 == "_encstr_87A10C9D24E997A01F21838F3D34" || isDefined(var_1) && isPlayer(var_1)) {
    var_10 = scripts\mp\riotshield::isriotshield(var_4.basename);
    var_11 = scripts\mp\utility\weapon::isknifeonly(var_4.basename) || scripts\mp\utility\weapon::turret_aimed_at_last_known(var_4.basename) || scripts\mp\utility\weapon::isaxeweapon(var_4.basename) || scripts\mp\utility\weapon::update_health_bar_to_player(var_4);
    var_12 = isDefined(var_3) && var_3 == "_encstr_AA230E8CF56CD18DB12FC7E303C8C001";

    if(!isDefined(self.ladderdeathsthisweapon))
      self.ladderdeathsthisweapon = 1;
    else
      self.ladderdeathsthisweapon++;

    if(var_3 == "_encstr_87A10C9D24E997A01F21838F3D34" || var_1 == self || var_3 == "_encstr_8DED0A21C79B660BC7588981" && var_11 || self.ladderdeathsthisweapon == level.setbackstreak || var_12) {
      self.ladderdeathsthisweapon = 0;
      self playlocalsound("_encstr_A76F166B1CF5BBB039F57B89A6568DD196D995F5D8F6E61D");
      self notify("_encstr_95481357388C581D59AF1BBDC291BB56C207EDCDDC");
      self.gungameprevgunindex = self.gungamegunindex;
      self.gungamegunindex = int(max(0, self.gungamegunindex - level.setback));

      if(self.gungameprevgunindex > self.gungamegunindex) {
        scripts\mp\gamescore::giveplayerscore("_encstr_A1DB11391DF2BF99D501CE179F7DC750A7755B", 1);
        thread scripts\mp\rank::scoreeventpopup("_encstr_A1DB11391DF2BF99D501CE179F7DC750A7755B");
        scripts\mp\utility\stats::incpersstat("_encstr_AD7F0937568E890B1B6D37", 1);
        scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_AD7F0937568E890B1B6D37", self.pers["_encstr_AD7F0937568E890B1B6D37"]);

        if(isPlayer(self))
          scripts\mp\utility\stats::setextrascore1(self.pers["_encstr_AD7F0937568E890B1B6D37"]);
      }

      if(var_3 == "_encstr_8DED0A21C79B660BC7588981") {
        if(self.gungameprevgunindex)
          var_1 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_AFA217E9F32FB3409F7739A79DED53883F8FD7EB66133F152A");

        var_1 updateknivesperminute();
        var_1 scripts\mp\awards::givemidmatchaward("_encstr_958A0FB5DBC8B2D79D5DDCEB6BB2B19595");
        var_1 scripts\mp\utility\stats::incpersstat("_encstr_AAAD06703BB2590B", 1);
        var_1 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_AAAD06703BB2590B", var_1.pers["_encstr_AAAD06703BB2590B"]);

        if(isPlayer(var_1))
          var_1 scripts\mp\utility\stats::setextrascore0(var_1.pers["_encstr_AAAD06703BB2590B"]);
      }

      if(var_1 == self)
        return;
    }

    if(var_1 != self && var_3 == "_encstr_950A12A99E887D284AD42A7A31D748AA98C4A215" || var_3 == "_encstr_A68211A30F035922EF7BF1F55F0E4B59EB2BB9" || var_3 == "_encstr_87280E1FB705D168313D1FD197B1A799" || var_3 == "_encstr_84670F0D974DCF124E3F7A931851A1FB9F" || var_3 == "_encstr_8E39168B5F1FF12F4B08BC45D08B6BA1E7F73F293436C91B" || var_3 == "_encstr_A1ED0BA9FF84562B60BA073E83" || var_3 == "_encstr_911B0C7DA090E9A7F799FD50DD48" || var_3 == "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421" || var_3 == "_encstr_B45C0E2DFF41B17F437FB870E733FBFF" || var_3 == "_encstr_9B0D099AD3887D91252954" || var_3 == "_encstr_8DED0A21C79B660BC7588981" && !var_11 || var_12) {
      var_13 = getweaponbasename(var_1.primaryweapon);

      if(!var_1 get_available_unique_id(var_4, var_13, var_12)) {
        return;
      }
      if(!isDefined(var_1.ladderkillsthisweapon))
        var_1.ladderkillsthisweapon = 1;
      else
        var_1.ladderkillsthisweapon++;

      if(var_1.ladderkillsthisweapon != level.killsperweapon) {
        return;
      }
      var_1.ladderkillsthisweapon = 0;
      var_1.ladderdeathsthisweapon = 0;
      var_1.gungameprevgunindex = var_1.gungamegunindex;
      var_1.gungamegunindex++;
      var_1 notify("_encstr_95481357388C581D59AF1BBDC291BB56C207EDCDDC");
      var_1 scripts\mp\gamescore::giveplayerscore("_encstr_847510CE1696DCCA32D7B3D573D7C9B0CDB5", 1);

      if(var_1.gungamegunindex == level.gun_guns.size - 2)
        level.kick_afk_check = 1;

      if(var_1 update_readings()) {
        var_14 = [];

        foreach(var_16 in level.players) {
          if(var_16 != var_1)
            var_14[var_14.size] = var_16;
        }

        scripts\mp\utility\dialog::leaderdialogonplayers("_encstr_87F10F780AC2C9AB8F550E902DEBF1B328", var_14);
        var_1 scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_BED512F19EF32933D127385903E2A8B38A477983");
        scripts\mp\utility\sound::playsoundonplayers("_encstr_8B78160973D7050D4BE7D98E187AFB3E038387CBA8EDAF39");
        level thread scripts\mp\hud_util::teamplayercardsplash("_encstr_A9711599AE94984853DBAFF19F2B987825C58633D6CEE8", var_1);
      }

      if(var_1.gungamegunindex < level.gun_guns.size) {
        var_18 = scripts\mp\rank::getscoreinfovalue("_encstr_847510CE1696DCCA32D7B3D573D7C9B0CDB5");
        var_1 thread scripts\mp\rank::scorepointspopup(var_18);
        var_1 thread scripts\mp\rank::scoreeventpopup("_encstr_847510CE1696DCCA32D7B3D573D7C9B0CDB5");
        var_1 playlocalsound("_encstr_87ED1717204EDFBA5518655EFA13D284D0B88F5798610B2255");
        var_1 thread givenextgun(0);
      }

      if(isDefined(var_1.lastgunrankincreasetime) && gettime() - var_1.lastgunrankincreasetime < 5000)
        var_1 scripts\mp\awards::givemidmatchaward("_encstr_974E14ADB7192BAFCED5B9EB17BAA58DB6BEDAB4C6D8");

      var_1.lastgunrankincreasetime = gettime();
    }
  }
}

givenextgun(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!var_0)
    scripts\common\utility::allow_weapon_switch(0);

  var_1 = getnextgun();
  var_1 = scripts\mp\weapons::updatesavedaltstate(var_1);
  scripts\cp_mp\utility\inventory_utility::_giveweapon(var_1, undefined, undefined, 1);

  if(var_0) {
    self setspawnweapon(var_1);

    foreach(var_3 in self.weaponlist) {
      if(var_3 != var_1)
        thread scripts\cp_mp\utility\inventory_utility::takeweaponwhensafe(var_3);
    }
  }

  self.pers["_encstr_BE310E88C361A8C3DBA8445586D31770"] = var_1.basename;
  self.primaryweapon = var_1.basename;
  self.primaryweaponobj = var_1;
  scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var_1);
  var_5 = scripts\mp\utility\weapon::isaxeweapon(var_1);

  if(var_5) {
    self setweaponammoclip(var_1, 1);
    thread takeweaponwhensafegungame("_encstr_AFBB115ADD1CD75BDCA5CC56DC1D2CC4D7DAC1", 0);
  } else if(self.gungamegunindex != level.gun_guns.size - 1) {
    self givestartammo(var_1);
    var_6 = getcompleteweaponname("_encstr_AFBB115ADD1CD75BDCA5CC56DC1D2CC4D7DAC1");
    self giveweapon(var_6);
    self assignweaponmeleeslot(var_6);
  }

  if(!var_0) {
    var_7 = self.lastdroppableweaponobj;
    thread takeweaponwhensafegungame(var_7, 1);
  }

  giveortakethrowingknife(var_1.basename);
  scripts\mp\weapons::updatetogglescopestate(var_1);
  self.gungameprevgunindex = self.gungamegunindex;

  if(!isDefined(self.lastgunpromotiontime))
    self.lastgunpromotiontime = gettime();

  var_8 = (gettime() - self.lastgunpromotiontime) / 1000;
  self.lastgunpromotiontime = gettime();

  if(isDefined(self.pers["_encstr_8A271936DB9BECACB9D18A96B5593583569BD1E9E6D52B58C1DBE6"]) && var_8 > self.pers["_encstr_8A271936DB9BECACB9D18A96B5593583569BD1E9E6D52B58C1DBE6"])
    self.pers["_encstr_8A271936DB9BECACB9D18A96B5593583569BD1E9E6D52B58C1DBE6"] = var_8;
}

takeweaponwhensafegungame(var_0, var_1) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  for(;;) {
    if(!scripts\cp_mp\utility\inventory_utility::iscurrentweapon(var_0)) {
      break;
    }

    waitframe();
  }

  scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0);

  if(var_1)
    scripts\common\utility::allow_weapon_switch(1);
}

getnextgun(var_0) {
  var_1 = self.gungamegunindex;

  if(isDefined(var_0))
    var_1 = var_0;

  var_2 = level.gun_guns[var_1];
  return var_2;
}

ontimelimit() {
  var_0 = gethighestprogressedplayers();

  if(!isDefined(var_0) || !var_0.size)
    thread scripts\mp\gamelogic::endgame("_encstr_8D19048EA595", game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_B40B13237BEFC5278BC385D3C98FEA8518524C203D"]);
  else if(var_0.size == 1)
    thread scripts\mp\gamelogic::endgame(var_0[0], game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_B40B13237BEFC5278BC385D3C98FEA8518524C203D"]);
  else if(var_0[var_0.size - 1].gungamegunindex > var_0[var_0.size - 2].gungamegunindex)
    thread scripts\mp\gamelogic::endgame(var_0[var_0.size - 1], game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_B40B13237BEFC5278BC385D3C98FEA8518524C203D"]);
  else
    thread scripts\mp\gamelogic::endgame("_encstr_8D19048EA595", game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_B40B13237BEFC5278BC385D3C98FEA8518524C203D"]);
}

gethighestprogressedplayers() {
  var_0 = -1;
  var_1 = [];

  foreach(var_3 in level.players) {
    if(isDefined(var_3.gungamegunindex) && var_3.gungamegunindex >= var_0) {
      var_0 = var_3.gungamegunindex;
      var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

refillammo() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    self waittill("_encstr_AF4D07932B1BDE5846");
    var_0 = weaponstartammo(self.primaryweapon);
    var_1 = weaponclipsize(self.primaryweapon);
    var_2 = var_0 - var_1;
    self setweaponammostock(self.primaryweapon, var_2);
  }
}

refillsinglecountammo() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    if(scripts\mp\utility\player::isreallyalive(self) && self.team != "_encstr_AF8C0A1B6A1D6045925B4F7D" && isDefined(self.primaryweapon) && self getammocount(self.primaryweapon) == 0) {
      wait 2;
      self notify("_encstr_AF4D07932B1BDE5846");
      wait 1;
      continue;
    }

    waitframe();
  }
}

setgunladder() {
  level.gun_guns = [];
  level.selectedweapons = [];

  switch (level.ladderindex) {
    case 10:
    case 7:
    case 6:
    case 5:
    case 4:
    case 1:
      if(scripts\mp\utility\game::matchmakinggame() && getdvarint("_encstr_A937174BFF82993A4B0E771F293F104B7F9651755F11378112", 0) == 1) {
        level.gun_guns[0] = "_encstr_88870C93169BC8EB0EA56E47F663";
        level.gun_guns[1] = "_encstr_87F30D880A85E9CEE75880052F8790";
        level.gun_guns[2] = "_encstr_B4D90992BFCD52477348B7";
        level.gun_guns[3] = "_encstr_8B380D1AA9F0E489C797A7E7B37903";
        level.gun_guns[4] = "_encstr_96D809932CCDC8BE635B9D";
        level.gun_guns[5] = "_encstr_8B4C0C4EB0E68CF5DCE6A5C15693";
        level.gun_guns[6] = "_encstr_B4D90992BFCD52477348B7";
        level.gun_guns[7] = "_encstr_8B380D1AA9F0E489C797A7E7B37903";
        level.gun_guns[8] = "_encstr_96D809932CCDC8BE635B9D";
        level.gun_guns[9] = "_encstr_997C0E39167391D7B10BAE3736D0ACE4";
        level.gun_guns[10] = "_encstr_87F30D880A85E9CEE75880052F8790";
        level.gun_guns[11] = "_encstr_B4D90992BFCD52477348B7";
        level.gun_guns[12] = "_encstr_8B380D1AA9F0E489C797A7E7B37903";
        level.gun_guns[13] = "_encstr_87F30D880A85E9CEE75880052F8790";
        level.gun_guns[14] = "_encstr_8B380D1AA9F0E489C797A7E7B37903";
        level.gun_guns[15] = "_encstr_8B4C0C4EB0E68CF5DCE6A5C15693";
        level.gun_guns[16] = "_encstr_88870C93169BC8EB0EA56E47F663";
        level.gun_guns[17] = "_encstr_B63D0F56368AA18E0BE31878D76781FD52";
      } else {
        level.gun_guns[0] = "_encstr_8B380D1AA9F0E489C797A7E7B37903";
        level.gun_guns[1] = "_encstr_B4D90992BFCD52477348B7";
        level.gun_guns[2] = "_encstr_87F30D880A85E9CEE75880052F8790";
        level.gun_guns[3] = "_encstr_96D809932CCDC8BE635B9D";
        level.gun_guns[4] = "_encstr_8B380D1AA9F0E489C797A7E7B37903";
        level.gun_guns[5] = "_encstr_8B4C0C4EB0E68CF5DCE6A5C15693";
        level.gun_guns[6] = "_encstr_88870C93169BC8EB0EA56E47F663";
        level.gun_guns[7] = "_encstr_8B380D1AA9F0E489C797A7E7B37903";
        level.gun_guns[8] = "_encstr_B4D90992BFCD52477348B7";
        level.gun_guns[9] = "_encstr_997C0E39167391D7B10BAE3736D0ACE4";
        level.gun_guns[10] = "_encstr_87F30D880A85E9CEE75880052F8790";
        level.gun_guns[11] = "_encstr_96D809932CCDC8BE635B9D";
        level.gun_guns[12] = "_encstr_8B380D1AA9F0E489C797A7E7B37903";
        level.gun_guns[13] = "_encstr_B4D90992BFCD52477348B7";
        level.gun_guns[14] = "_encstr_87F30D880A85E9CEE75880052F8790";
        level.gun_guns[15] = "_encstr_8B4C0C4EB0E68CF5DCE6A5C15693";
        level.gun_guns[16] = "_encstr_88870C93169BC8EB0EA56E47F663";
        level.gun_guns[17] = "_encstr_B63D0F56368AA18E0BE31878D76781FD52";
      }

      break;
    case 8:
    case 2:
      level.gun_guns[0] = "_encstr_88870C93169BC8EB0EA56E47F663";
      level.gun_guns[1] = "_encstr_87F30D880A85E9CEE75880052F8790";
      level.gun_guns[2] = "_encstr_B4D90992BFCD52477348B7";
      level.gun_guns[3] = "_encstr_8B380D1AA9F0E489C797A7E7B37903";
      level.gun_guns[4] = "_encstr_88870C93169BC8EB0EA56E47F663";
      level.gun_guns[5] = "_encstr_87F30D880A85E9CEE75880052F8790";
      level.gun_guns[6] = "_encstr_B4D90992BFCD52477348B7";
      level.gun_guns[7] = "_encstr_8B380D1AA9F0E489C797A7E7B37903";
      level.gun_guns[8] = "_encstr_88870C93169BC8EB0EA56E47F663";
      level.gun_guns[9] = "_encstr_87F30D880A85E9CEE75880052F8790";
      level.gun_guns[10] = "_encstr_B4D90992BFCD52477348B7";
      level.gun_guns[11] = "_encstr_8B380D1AA9F0E489C797A7E7B37903";
      level.gun_guns[12] = "_encstr_88870C93169BC8EB0EA56E47F663";
      level.gun_guns[13] = "_encstr_87F30D880A85E9CEE75880052F8790";
      level.gun_guns[14] = "_encstr_B4D90992BFCD52477348B7";
      level.gun_guns[15] = "_encstr_8B380D1AA9F0E489C797A7E7B37903";
      level.gun_guns[16] = "_encstr_88870C93169BC8EB0EA56E47F663";
      level.gun_guns[17] = "_encstr_B63D0F56368AA18E0BE31878D76781FD52";
      break;
    case 9:
    case 3:
      level.gun_guns[0] = "_encstr_88870C93169BC8EB0EA56E47F663";
      level.gun_guns[1] = "_encstr_8B380D1AA9F0E489C797A7E7B37903";
      level.gun_guns[2] = "_encstr_96D809932CCDC8BE635B9D";
      level.gun_guns[3] = "_encstr_997C0E39167391D7B10BAE3736D0ACE4";
      level.gun_guns[4] = "_encstr_8B4C0C4EB0E68CF5DCE6A5C15693";
      level.gun_guns[5] = "_encstr_8B380D1AA9F0E489C797A7E7B37903";
      level.gun_guns[6] = "_encstr_96D809932CCDC8BE635B9D";
      level.gun_guns[7] = "_encstr_997C0E39167391D7B10BAE3736D0ACE4";
      level.gun_guns[8] = "_encstr_8B4C0C4EB0E68CF5DCE6A5C15693";
      level.gun_guns[9] = "_encstr_8B380D1AA9F0E489C797A7E7B37903";
      level.gun_guns[10] = "_encstr_96D809932CCDC8BE635B9D";
      level.gun_guns[11] = "_encstr_997C0E39167391D7B10BAE3736D0ACE4";
      level.gun_guns[12] = "_encstr_8B4C0C4EB0E68CF5DCE6A5C15693";
      level.gun_guns[13] = "_encstr_8B380D1AA9F0E489C797A7E7B37903";
      level.gun_guns[14] = "_encstr_8B4C0C4EB0E68CF5DCE6A5C15693";
      level.gun_guns[15] = "_encstr_8B380D1AA9F0E489C797A7E7B37903";
      level.gun_guns[16] = "_encstr_88870C93169BC8EB0EA56E47F663";
      level.gun_guns[17] = "_encstr_B63D0F56368AA18E0BE31878D76781FD52";
      break;
  }

  if(level.gametype == "_encstr_8A1804DAAB75") {
    var_0 = level.gun_guns.size;
    setdynamicdvar("_encstr_A65113DF5BAAC99CFFC2F67B3ABFCEC0C5B91B63D4", var_0);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), var_0);
  }
}

setgunsfinal() {
  level.selectedweapons = [];
  buildrandomweapontable();

  for(var_0 = 0; var_0 < level.gun_guns.size; var_0++) {
    var_1 = level.gun_guns[var_0];

    if(scripts\mp\utility\script::isstrstart(var_1, "_encstr_B4110642CA35DA11")) {
      var_2 = getrandomweaponfromcategory(var_1);

      if(level.ladderindex == 4 || level.ladderindex == 5)
        level.gun_guns[var_0] = scripts\mp\class::fixcollision(var_2["_encstr_AC20072B9FA9487832"], undefined, undefined, var_2["_encstr_8A3E0A0D67C353E09EEBD48D"], undefined, undefined, scripts\cp_mp\utility\game_utility::isnightmap());
      else
        level.gun_guns[var_0] = fixuppickuporigin(var_2);

      continue;
    }

    var_3 = scripts\mp\utility\weapon::getweaponrootname(level.gun_guns[var_0]);
    level.selectedweapons[var_3] = 1;
    var_4 = var_3;
    var_5 = 0;

    if(level.ladderindex == 4 || level.ladderindex == 5) {
      var_6 = remappedhpzoneorder(var_3);
      var_7 = scripts\mp\class::_id_139E7(var_3, var_6);
      var_4 = scripts\mp\class::fixcollision(var_3, undefined, undefined, var_7, undefined, undefined, scripts\cp_mp\utility\game_utility::isnightmap());
    } else {
      var_7 = 0;

      if(level.ladderindex == 6) {
        var_6 = remappedhpzoneorder(var_3);
        var_7 = scripts\mp\class::_id_139E7(var_3, var_6);
      }

      var_5 = randomintrange(2, 5);
      var_4 = set_station_track_available_time(var_3, var_5, var_7, scripts\cp_mp\utility\game_utility::isnightmap());
    }

    level.gun_guns[var_0] = var_4;
  }

  level.selectedweapons = undefined;
}

getrandomarchetype() {
  return "_encstr_AFB31216936C0DCAE8F283B2FA85CDE6B0578D1D";
}

setspecialloadout() {
  level.gun_loadouts["_encstr_8E8405EA382B2A"]["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"] = "_encstr_8D900DB477077D1C2DD736E0C28385";
  level.gun_loadouts["_encstr_8E8405EA382B2A"]["_encstr_9643193A25FBB9209BBB027A21C5C9FE9A07A8F86730C0DB505878"] = "_encstr_8BBA05185F8B99";
  level.gun_loadouts["_encstr_8E8405EA382B2A"]["_encstr_A1651A992F661880E76B2F5382BF4F60B8992151C94EC0D9CFA2A353"] = "_encstr_8BBA05185F8B99";
  level.gun_loadouts["_encstr_8E8405EA382B2A"]["_encstr_856C13D8BD0B19DEEAA3A027B46BC227BC0D2C6BED"] = "_encstr_8BBA05185F8B99";
  level.gun_loadouts["_encstr_8E8405EA382B2A"]["_encstr_AA0216B867B9590F9BDB978EF4725BC3F93B48F0E75390C3"] = "_encstr_8BBA05185F8B99";
  level.gun_loadouts["_encstr_8E8405EA382B2A"]["_encstr_935A1863DB1619ED5DA3284E2D5B85E4E52BB0935A5873E89222"] = 0;
  level.gun_loadouts["_encstr_8E8405EA382B2A"]["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"] = "_encstr_8BBA05185F8B99";
  level.gun_loadouts["_encstr_8E8405EA382B2A"]["_encstr_A96F1B782D99D84853DBB7D3AFDA376031C2425593D4B8765A47C3FDEB"] = "_encstr_8BBA05185F8B99";
  level.gun_loadouts["_encstr_8E8405EA382B2A"]["_encstr_B8DB1C1C17A137958B719F02564FF061B64E77B134A3D1DF58BF9BC633C7"] = "_encstr_8BBA05185F8B99";
  level.gun_loadouts["_encstr_8E8405EA382B2A"]["_encstr_8CEA1501B78EF0781F83D7199A1FA0A8260293D7217560"] = "_encstr_8BBA05185F8B99";
  level.gun_loadouts["_encstr_8E8405EA382B2A"]["_encstr_83B6181AA01BCF6F63FD93DD1E48239743E0F37168D94487786D"] = "_encstr_8BBA05185F8B99";
  level.gun_loadouts["_encstr_8E8405EA382B2A"]["_encstr_88531A48DA76F9D8EF34EEFD3BDFA0B1DEB36801D24A3BD1AB5C9B75"] = 0;
  level.gun_loadouts["_encstr_8E8405EA382B2A"]["_encstr_83BC1124F069D3E5D3907833B0C31A4F41E8A4"] = "_encstr_AC9C0FEA0FF30A29692883BF99A00D4249";
  level.gun_loadouts["_encstr_8E8405EA382B2A"]["_encstr_A9C30F63DE858CDB57E8F499991A2CDCC8"] = "_encstr_8BBA05185F8B99";
  level.gun_loadouts["_encstr_8E8405EA382B2A"]["_encstr_AD1B1288DD6928B843CB87C1FB6AF70834307321"] = "_encstr_AB3508737F830710ACDB";
  level.gun_loadouts["_encstr_8E8405EA382B2A"]["_encstr_8EE713601A6FD59883AC471BACAD30A55BD2590847"] = "_encstr_8BBA05185F8B99";
  level.gun_loadouts["_encstr_8E8405EA382B2A"]["_encstr_91E71336EDC291F6AE8E5A5AD88DB91DE456B05B8C"] = "_encstr_8BBA05185F8B99";
  level.gun_loadouts["_encstr_8E8405EA382B2A"]["_encstr_ACE713DD22D19AE80D98115804EB13E1D2D58F27C7"] = "_encstr_8BBA05185F8B99";
  level.gun_loadouts["_encstr_8E8405EA382B2A"]["_encstr_86CB0DFB97F7022F90BB3A7F53487B"] = [];
  level.gun_loadouts["_encstr_8E8405EA382B2A"]["_encstr_B4450F51E53FE10F4B0C1791B7ABED8085"] = "_encstr_A63C0B33252188F56B439B89EF";
  level.gun_loadouts["_encstr_9A8507BA4040188D08"] = level.gun_loadouts["_encstr_8E8405EA382B2A"];
}

buildrandomweapontable() {
  level.weaponcategories = [];
  var_0 = 0;

  for(;;) {
    var_1 = tablelookupbyrow("_encstr_BAB31677F99257E5785CF62080415FA71058F8B092EE175C", var_0, 0);

    if(var_1 == "_encstr_B40101") {
      break;
    }

    if(!isDefined(level.weaponcategories[var_1]))
      level.weaponcategories[var_1] = [];

    var_2 = tablelookupbyrow("_encstr_BAB31677F99257E5785CF62080415FA71058F8B092EE175C", var_0, 5);

    if(var_2 == "_encstr_B40101" || getdvarint(var_2, 0) == 1) {
      var_3 = [];
      var_3["_encstr_AC20072B9FA9487832"] = scripts\mp\utility\weapon::getweaponrootname(tablelookupbyrow("_encstr_BAB31677F99257E5785CF62080415FA71058F8B092EE175C", var_0, 1));
      var_3["_encstr_8719046B4BB9"] = int(tablelookupbyrow("_encstr_BAB31677F99257E5785CF62080415FA71058F8B092EE175C", var_0, 2));
      var_3["_encstr_B81904B62CC3"] = int(tablelookupbyrow("_encstr_BAB31677F99257E5785CF62080415FA71058F8B092EE175C", var_0, 3));
      var_3["_encstr_960D052F10EBF0"] = tablelookupbyrow("_encstr_BAB31677F99257E5785CF62080415FA71058F8B092EE175C", var_0, 4);
      var_3["_encstr_B11B0841F940FDF79DB9"] = int(tablelookupbyrow("_encstr_BAB31677F99257E5785CF62080415FA71058F8B092EE175C", var_0, 7));

      if((level.ladderindex == 4 || level.ladderindex == 6) && !var_3["_encstr_B11B0841F940FDF79DB9"]) {
        var_0++;
        continue;
      }

      if(!scripts\mp\weapons::vehicle_ai_avoidance_cleanup(var_3["_encstr_AC20072B9FA9487832"])) {
        var_0++;
        continue;
      }

      level.weaponcategories[var_1][level.weaponcategories[var_1].size] = var_3;
    }

    var_0++;
  }
}

getrandomweaponfromcategory(var_0) {
  var_1 = level.weaponcategories[var_0];

  if(isDefined(var_1) && var_1.size > 0) {
    var_2 = "_encstr_B40101";
    var_3 = undefined;
    var_4 = 0;

    for(;;) {
      var_5 = randomintrange(0, var_1.size);
      var_3 = var_1[var_5];
      var_6 = scripts\mp\utility\weapon::getweaponrootname(var_3["_encstr_AC20072B9FA9487832"]);
      var_7 = 1;

      if(level.ladderindex == 4 || level.ladderindex == 6)
        var_7 = var_3["_encstr_B11B0841F940FDF79DB9"];

      if(!isDefined(level.selectedweapons[var_6]) && var_7 || var_4 > var_1.size) {
        level.selectedweapons[var_6] = 1;

        for(var_8 = 0; var_8 < level.weaponcategories[var_0].size; var_8++) {
          if(level.weaponcategories[var_0][var_8]["_encstr_AC20072B9FA9487832"] == var_3["_encstr_AC20072B9FA9487832"]) {
            level.weaponcategories[var_0] = scripts\engine\utility::array_remove_index(level.weaponcategories[var_0], var_8);
            break;
          }
        }

        break;
      }

      var_4++;
    }

    if(level.ladderindex == 4 || level.ladderindex == 6) {
      var_9 = remappedhpzoneorder(var_3["_encstr_AC20072B9FA9487832"]);
      var_3["_encstr_8A3E0A0D67C353E09EEBD48D"] = scripts\mp\class::_id_139E7(var_3["_encstr_AC20072B9FA9487832"], var_9);
    } else if(level.ladderindex == 5)
      var_3["_encstr_8A3E0A0D67C353E09EEBD48D"] = scripts\mp\class::_id_139E7(var_3["_encstr_AC20072B9FA9487832"], "_encstr_B10703DD0F");

    return var_3;
  } else
    return "_encstr_8BBA05185F8B99";
}

fixuppickuporigin(var_0) {
  var_1 = randomintrange(var_0["_encstr_8719046B4BB9"], var_0["_encstr_B81904B62CC3"] + 1);
  var_2 = set_station_track_available_time(var_0["_encstr_AC20072B9FA9487832"], var_1, var_0["_encstr_8A3E0A0D67C353E09EEBD48D"], scripts\cp_mp\utility\game_utility::isnightmap());
  return var_2;
}

remappedhpzoneorder(var_0) {
  var_1 = [];
  var_2 = scripts\mp\utility\weapon::getweaponrootname(var_0);
  var_1 = tablelookup("_encstr_BAB31677F99257E5785CF62080415FA71058F8B092EE175C", 1, var_2, 6);
  return var_1;
}

modifyweapon(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = 0;
  var_5 = level.ladderindex == 4;
  var_6 = "_encstr_B40101";

  if(isDefined(var_2) && var_2["_encstr_B6A208B3C2275AC2B9E8"] != "_encstr_B40101")
    var_6 = var_2["_encstr_B6A208B3C2275AC2B9E8"];

  var_7 = var_6 != "_encstr_B40101";
  var_8 = "_encstr_85331038937FC097B223A0947F0AF1E89656" + var_0 + "_encstr_96A70506895E33";
  var_9 = scripts\mp\utility\weapon::getweapongunsmithattachmenttable(var_0);

  if(var_1 > 0) {
    var_10 = scripts\mp\utility\weapon::getweaponattachmentsbasenames(var_0);

    if(var_10.size > 0) {
      var_11 = scripts\mp\utility\weapon::register_wave_spawner(var_0);
      var_12 = var_11.size;

      for(var_13 = 0; var_13 < var_1; var_13++) {
        var_14 = "_encstr_B40101";

        while(var_14 == "_encstr_B40101" && var_12 > 0) {
          var_12--;
          var_15 = randomint(var_11.size);
          var_14 = var_11[var_15];

          if(attachmentcheck(var_14, var_3, var_9, var_0)) {
            var_3[var_3.size] = var_14;

            if(scripts\mp\utility\weapon::getattachmenttype(var_14) == "_encstr_851F05E3C813A5")
              var_4 = 1;
          }
        }
      }
    }
  }

  var_16 = "_encstr_8BBA05185F8B99";
  var_17 = "_encstr_8BBA05185F8B99";

  if(istrue(var_5) && var_7)
    var_18 = scripts\mp\class::buildweapon(var_0, var_3, var_16, var_17, int(var_6));
  else
    var_18 = scripts\mp\class::buildweapon(var_0, var_3, var_16, var_17);

  return var_18;
}

set_station_track_available_time(var_0, var_1, var_2, var_3) {
  if(level.ladderindex == 6) {
    if(!isDefined(var_1))
      var_1 = randomintrange(2, 5);

    var_4 = scripts\mp\class::buildweapon(var_0, undefined, undefined, undefined, undefined, undefined, undefined, undefined, var_3);
    var_5 = set_spawner_type(var_0);
    var_6 = [];

    for(var_7 = 0; var_7 < var_1; var_7++) {
      var_8 = scripts\mp\weapons::getrandomgraverobberattachment(var_4, var_5);

      if(!isDefined(var_8)) {
        break;
      } else {
        var_9 = scripts\mp\weapons::addattachmenttoweapon(var_4, var_8);

        if(isDefined(var_9))
          var_4 = var_9;

        var_6[var_6.size] = var_8;
      }
    }

    var_4 = scripts\mp\class::fixsuperforbr(var_0, var_6, undefined, undefined, var_2, undefined, undefined, undefined, var_3);
    return var_4;
  } else {
    if(isDefined(var_2) && var_2 != 0)
      var_4 = scripts\mp\class::fixcollision(var_0, undefined, undefined, var_2, undefined, undefined, var_3);
    else
      var_4 = scripts\mp\class::buildweapon(var_0, undefined, undefined, undefined, undefined, undefined, undefined, undefined, var_3);

    if(!isDefined(var_1))
      var_1 = randomintrange(2, 5);

    var_5 = set_spawner_type(var_4);

    for(var_7 = 0; var_7 < var_1; var_7++) {
      var_8 = scripts\mp\weapons::getrandomgraverobberattachment(var_4, var_5);

      if(!isDefined(var_8)) {
        break;
      }

      var_9 = scripts\mp\weapons::addattachmenttoweapon(var_4, var_8);

      if(isDefined(var_9))
        var_4 = var_9;
    }

    return var_4;
  }
}

set_spawner_type(var_0) {
  var_1 = scripts\mp\utility\weapon::register_wave_spawner(var_0);
  var_2 = [];

  foreach(var_4 in var_1) {
    if(isstartstr(var_4, "_encstr_8A07035972") || isstartstr(var_4, "_encstr_8B0703AE89") || isstartstr(var_4, "_encstr_A3CA081B50EDAB3D60A9") || var_4 == "_encstr_8C0308D0CBC439A5C899") {
      continue;
    }
    var_2[var_2.size] = var_4;
  }

  return var_2;
}

attachmentcheck(var_0, var_1, var_2, var_3) {
  var_4 = tablelookup(var_2, 0, var_0, 1);

  for(var_5 = 0; var_5 < var_1.size; var_5++) {
    var_6 = tablelookup(var_2, 0, var_1[var_5], 1);

    if(var_0 == var_1[var_5] || scripts\mp\utility\weapon::attachmentsconflict(var_0, var_1[var_5], var_3) != "_encstr_B40101" || var_4 == var_6)
      return 0;
  }

  return 1;
}

getvalidattachments(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];
  var_6 = [];
  var_7 = [];

  if(istrue(var_1) && var_4 != "_encstr_B40101") {
    var_6 = tablelookup(var_3, 0, int(var_4), 17);
    var_6 = strtok(var_6, "_encstr_BE4C0295");
    var_7 = tablelookup(var_3, 0, int(var_4), 18);
    var_7 = strtok(var_7, "_encstr_BE4C0295");

    for(var_8 = 0; var_8 < var_6.size; var_8++)
      var_6[var_8] = scripts\mp\utility\weapon::attachmentmap_tobase(var_6[var_8]);
  }

  foreach(var_10 in var_0) {
    var_11 = scripts\mp\utility\weapon::getattachmenttype(var_10);

    if(var_7.size > 0 && scripts\engine\utility::array_contains(var_7, var_11)) {
      continue;
    }
    if(var_6.size > 0 && scripts\engine\utility::array_contains(var_6, var_10)) {
      continue;
    }
    if(!scripts\mp\utility\weapon::carriedpunchcard(var_2, var_10)) {
      var_5[var_11] = undefined;
      continue;
    }

    switch (var_10) {
      case "_encstr_8E5F063CDA2C3BCD":
      case "_encstr_AD3E09B95A632BDC6CCA27":
        break;
      default:
        if(!issubstr(var_10, "_encstr_AD3E09B95A632BDC6CCA27"))
          var_5[var_5.size] = var_10;
    }
  }

  return var_5;
}

giveortakethrowingknife(var_0) {
  scripts\mp\equipment::takeequipment("_encstr_BA7F0830B3A7859B60B0");

  if(scripts\mp\utility\weapon::isknifeonly(var_0) || scripts\mp\utility\weapon::turret_aimed_at_last_known(var_0) || scripts\mp\utility\weapon::isaxeweapon(var_0)) {
    scripts\mp\utility\perk::giveperk("_encstr_95571436E007F94BC6620878491A17F1339D30A44DF3");
    scripts\mp\utility\perk::giveperk("_encstr_B4DD12D237DB22713140FBD7C14B391BAF43DF0A");
    scripts\mp\equipment::giveequipment("_encstr_841F1AB2B8AE5AE07D471A27EDDD5A7376F5B6B996CCB2D7669693AC", "_encstr_BA7F0830B3A7859B60B0");
    thread scripts\mp\equipment::incrementequipmentammo("_encstr_841F1AB2B8AE5AE07D471A27EDDD5A7376F5B6B996CCB2D7669693AC");
  }
}

isvalidthrowingknifekill(var_0) {
  return var_0 == "_encstr_8AF511A30D4EDEDDB4CDB35BE6A5CC2BFA5B83" || var_0 == "_encstr_960F162D78EBD03757808747D2441CF1E1F7D3A550F9BB83" || var_0 == "_encstr_BE851AF4BC20B024C3484117800164B0774058673AC34BF9AFF96170" || var_0 == "_encstr_8AF817C568CBE8E754F22078CA6C8DE1270C4E33F41B560BFA";
}

onplayerscore(var_0, var_1, var_2, var_3) {
  var_1 scripts\mp\utility\stats::incpersstat("_encstr_A7E80EB868982F22383F6F4FD680F85D", var_2);
  var_4 = var_1 scripts\mp\utility\stats::getpersstat("_encstr_A7E80EB868982F22383F6F4FD680F85D");
  var_1 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_A7E80EB868982F22383F6F4FD680F85D", var_4);
  var_5 = 0;

  if(var_0 == "_encstr_847510CE1696DCCA32D7B3D573D7C9B0CDB5")
    var_5 = 1;
  else if(var_0 == "_encstr_A1DB11391DF2BF99D501CE179F7DC750A7755B") {
    var_6 = level.setback;
    var_5 = var_6 * -1;
  } else if(var_0 == "_encstr_91A70B13A312807E13497961B2" || var_0 == "_encstr_ABD70578F3D02C")
    var_1 scripts\mp\utility\script::bufferednotify("_encstr_AD7116B258277356C8BECDB17BE459AF26D566999593B232", var_2);

  return var_5;
}

updateknivesperminute() {
  if(!isDefined(self.knivesperminute)) {
    self.numknives = 0;
    self.knivesperminute = 0;
  }

  self.numknives++;

  if(scripts\mp\utility\game::getminutespassed() < 1) {
    return;
  }
  self.knivesperminute = self.numknives / scripts\mp\utility\game::getminutespassed();
}

modifyunifiedpointscallback(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3) && (var_3.basename == "_encstr_BED80D7C9C59D95BF870DBDFA9F018" || var_3.basename == "_encstr_9BE916CAE02981E7E1E821539B8893D5C590B332600FC54B" || var_3.basename == "_encstr_A51417EC0CC949AD69315777A8409AF2D5297627FD8781E593")) {
    if(isDefined(var_2) && isDefined(var_2.knivesperminute) && var_2.knivesperminute >= 10)
      return 0;
  }

  return var_0;
}

get_available_unique_id(var_0, var_1, var_2) {
  if(var_0.basename == var_1)
    return 1;

  if(var_1 == "_encstr_88AC1394CB88B917A8A797F32F539A05376FD02DD3") {
    if(issubstr(var_0.basename, "_encstr_A69B053982C355"))
      return 1;
  }

  if(var_0.basename == "_encstr_AB45111102C198104A7F7D255FC2E5A8A75D1B")
    return 1;

  if(var_1 == "_encstr_99511344F3DA472338B7E34F23528AE1429271CD8B" || var_1 == "_encstr_A1E413BB8CDA89535851EB87D4EB24F9624ED9B5A3")
    return 1;

  if(update_readings()) {
    if(isvalidthrowingknifekill(var_0.basename))
      return 1;

    if(var_2)
      return 1;
  }

  return 0;
}

update_readings() {
  return self.gungamegunindex == level.gun_guns.size - 1;
}