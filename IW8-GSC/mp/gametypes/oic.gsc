/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\oic.gsc
***********************************************/

main() {
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  var_0[0] = scripts\mp\utility\game::getgametype();
  scripts\mp\gameobjects::main(var_0);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registertimelimitdvar(level.gametype, 10);
    scripts\mp\utility\game::registerscorelimitdvar(level.gametype, 0);
    scripts\mp\utility\game::registerroundlimitdvar(level.gametype, 1);
    scripts\mp\utility\game::registerwinlimitdvar(level.gametype, 1);
    scripts\mp\utility\game::registernumlivesdvar(level.gametype, 3);
    scripts\mp\utility\game::registerhalftimedvar(level.gametype, 0);
    level._id_11B3B = 1;
    level._id_11B39 = 1;
    level._id_11B3C = 1;
  }

  updategametypedvars();
  setteammode("_encstr_AC18045DF6D6");
  level.ignorekdrstats = 1;
  level.loadoutdefaultfiresalediscount = 1;
  level.teambased = 0;
  thread waitthensetstatgroupreadonly();
  level.onstartgametype = ::onstartgametype;
  level.onspawnplayer = ::onspawnplayer;
  level.getspawnpoint = ::getspawnpoint;
  level.onnormaldeath = ::onnormaldeath;
  level.onplayerkilled = ::onplayerkilled;
  level.ononeleftevent = ::ononeleftevent;
  level.modeonsuicidedeath = ::onsuicidedeath;
  level.onplayerscore = ::onplayerscore;
  level.bypassclasschoicefunc = ::alwaysgamemodeclass;

  if(level._id_11B3B)
    level.modifyplayerdamage = ::modifyplayerdamage;

  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_A2110DA7FB816244E02B47C1E0489B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_91B2067E0898939B"] = "_encstr_91650A1AD53F5A7B6757676B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_95240C659372588E43623137DE6C"] = "_encstr_91650A1AD53F5A7B6757676B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_93420C4255FBEA5D408FD1FD2A62"] = "_encstr_91650A1AD53F5A7B6757676B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AF131558B2FE97818B5D89FB0FCFE8A3251AE8A0FB9729"] = "_encstr_928210A773A9BFE761F87A32E8539BDF8068";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9A420E58B2FE97A0974E8DFE0F8B8BAF"] = "_encstr_9A420E58B2FE97A0974E8DFE0F8B8BAF";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A7A20FBDD2D8D78D2DB3CA9BD7632C6EA3"] = "_encstr_A7A20FBDD2D8D78D2DB3CA9BD7632C6EA3";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_81F213DF7BEED71B5C539DCBA751F2B2B451C11860"] = "_encstr_A5850952DA9B77FFC866C9";
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
  setdynamicdvar("_encstr_A3EB194B867B4FF5FB38E98278D3EB4FF1F981DD296077BDBB4863", getmatchrulesdata("_encstr_84FF081FA36867FF45A9", "_encstr_B16A11C3AB822D50413D0598652749E83BC361"));
  setdynamicdvar("_encstr_AB741C43F70D790D6937B0127175A0621517A2862F83EAD510B77D63F8AC", getmatchrulesdata("_encstr_84FF081FA36867FF45A9", "_encstr_BA5B14B6D263D849B2BB859319A0B55BED34B75D73A3"));
  setdynamicdvar("_encstr_8F0C149BC69CFAEDB4367DDBB959D4867BE896961B63", getmatchrulesdata("_encstr_84FF081FA36867FF45A9", "_encstr_87B20CC852EF1FB07FBC6A638C5B"));
  setdynamicdvar("_encstr_91FD0FD6B64BD78809D7A9F0D75923FFF2", getmatchrulesdata("_encstr_84FF081FA36867FF45A9", "_encstr_AC20072B9FA9487832"));
  setdynamicdvar("_encstr_AF1410B812BA97C0975B907F22E7C8AF67DA", 0);
}

onstartgametype() {
  setclientnamemode("_encstr_B6900C7BCDABC8AF2722B158FA17");
  scripts\mp\utility\game::setobjectivetext("_encstr_9A8507BA4040188D08", &"_encstr_97660FF8224BCDEF7BE0C9A9B95D3F84B7");
  scripts\mp\utility\game::setobjectivetext("_encstr_8E8405EA382B2A", &"_encstr_97660FF8224BCDEF7BE0C9A9B95D3F84B7");

  if(level.splitscreen) {
    scripts\mp\utility\game::setobjectivescoretext("_encstr_9A8507BA4040188D08", &"_encstr_97660FF8224BCDEF7BE0C9A9B95D3F84B7");
    scripts\mp\utility\game::setobjectivescoretext("_encstr_8E8405EA382B2A", &"_encstr_97660FF8224BCDEF7BE0C9A9B95D3F84B7");
  } else {
    scripts\mp\utility\game::setobjectivescoretext("_encstr_9A8507BA4040188D08", &"_encstr_A75815BD614240631BA84BA8078FC7FC384F8936D729D5");
    scripts\mp\utility\game::setobjectivescoretext("_encstr_8E8405EA382B2A", &"_encstr_A75815BD614240631BA84BA8078FC7FC384F8936D729D5");
  }

  scripts\mp\utility\game::setobjectivehinttext("_encstr_9A8507BA4040188D08", &"_encstr_991214C04D98D503D18B23E9FF9EE81750F0B81B34AB");
  scripts\mp\utility\game::setobjectivehinttext("_encstr_8E8405EA382B2A", &"_encstr_991214C04D98D503D18B23E9FF9EE81750F0B81B34AB");
  _id_13158();
  setspecialloadouts();
  scripts\mp\spawnlogic::setactivespawnlogic("_encstr_838B0B942AE27B65C76B91F03B", "_encstr_829A0D0F1AF8FB5ED127855073F940");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addstartspawnpoints("_encstr_858C12AF1A37B997E9607371037AA963717F2D9B", 1);
  scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_8A550CA8037FCD9021830923AF55");
  scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_BA891631A8D8EDA759B36AC36B3A1F3E62C34FBB35138B50", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_8A550CA8037FCD9021830923AF55");
  scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_BA891631A8D8EDA759B36AC36B3A1F3E62C34FBB35138B50", 1, 1);
  var_0 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_8A550CA8037FCD9021830923AF55");
  var_1 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_BA891631A8D8EDA759B36AC36B3A1F3E62C34FBB35138B50");
  scripts\mp\spawnlogic::registerspawnset("_encstr_9707038CB6", var_0);
  scripts\mp\spawnlogic::registerspawnset("_encstr_ADF50C28BF57C9C33AEDDE570662", var_1);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  level.blockweapondrops = 1;
  level thread _id_12028();
  level thread play_player_disguise_vo();
  level thread onplayerconnect();
}

updategametypedvars() {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::updatecommongametypedvars();
  level._id_11B39 = scripts\mp\utility\dvars::dvarintvalue("_encstr_B16A11C3AB822D50413D0598652749E83BC361", 1, 0, 15);
  level._id_11B3C = scripts\mp\utility\dvars::dvarintvalue("_encstr_BA5B14B6D263D849B2BB859319A0B55BED34B75D73A3", 1, 0, 15);
  level._id_11B3B = scripts\mp\utility\dvars::dvarintvalue("_encstr_87B20CC852EF1FB07FBC6A638C5B", 1, 0, 1);
  level._id_11B3A = spawnStruct();
  var_0 = getDvar("_encstr_91FD0FD6B64BD78809D7A9F0D75923FFF2");
  level._id_11B3A._id_11DF4 = var_0;
  level._id_11B3A.weapon = scripts\mp\utility\weapon::getweaponrootname(var_0);
  level._id_11B3A._id_11FBA = 0;
}

onplayerconnect() {
  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);
    var_0.pers["_encstr_959506B911C79707"] = "_encstr_AAAC09D09972B9C83F2B7F";
    var_0.pers["_encstr_92690A5B078ED325F539E25E"] = "_encstr_B40101";
    var_0.class = var_0.pers["_encstr_959506B911C79707"];
    var_0.lastclass = var_0.pers["_encstr_92690A5B078ED325F539E25E"];
    var_0.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"] = level._id_11FB8["_encstr_8E8405EA382B2A"];
    var_0 loadweaponsforplayer([level._id_11B3A._id_11DF4], 1);
    var_0._id_11FB5 = 1;
    var_0._id_11FB7 = 0;
  }
}

getspawnpoint() {
  if(self._id_11FB5)
    thread _id_11DA5();

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

  var_0 = scripts\mp\spawnlogic::getspawnpoint(self, "_encstr_8BBA05185F8B99", "_encstr_9707038CB6", "_encstr_ADF50C28BF57C9C33AEDDE570662");
  return var_0;
}

_id_11DA5() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  scripts\mp\flags::gameflagwait("_encstr_A75411B7E0D72245126A426A8019D7B7FA7EEA");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(5);

  if(!self._id_11FB7)
    scripts\mp\menus::addtoteam("_encstr_AF8C0A1B6A1D6045925B4F7D", 1);
}

onspawnplayer() {
  if(isDefined(self._id_11FB9) && self._id_11FB9)
    scriptablenousestate();
  else
    self._id_11FB9 = 0;

  thread waitloadoutdone();
  level notify("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");

  if(scripts\mp\utility\game::getgametypenumlives() != 0)
    thread _id_12606();
}

waitloadoutdone() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  var_0 = weaponclipsize(self.primaryweapon);

  if(level._id_11B39 > var_0) {
    self setweaponammoclip(self.primaryweapon, var_0);
    self setweaponammostock(self.primaryweapon, level._id_11B39 - var_0);

    if(self.primaryweapons[0] hasattachment("_encstr_AD9C07E0478148252A", 1))
      self setweaponammoclip(self.primaryweapon, level._id_11B39 - var_0, "_encstr_A5AD056A019C63");
  } else {
    self setweaponammoclip(self.primaryweapon, level._id_11B39);
    self setweaponammostock(self.primaryweapon, 0);

    if(self.primaryweapons[0] hasattachment("_encstr_AD9C07E0478148252A", 1))
      self setweaponammoclip(self.primaryweapon, level._id_11B39, "_encstr_A5AD056A019C63");
  }

  scripts\cp_mp\utility\inventory_utility::takeweaponwhensafe("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C");
  var_1 = getcompleteweaponname("_encstr_AFBB115ADD1CD75BDCA5CC56DC1D2CC4D7DAC1");
  self giveweapon(var_1);
  self assignweaponmeleeslot(var_1);
  self._id_11FB7 = 1;
  self setclientomnvar("_encstr_A2100DEFEB98C25930CE054CC3288B", self.pers["_encstr_8CAA06DB20A31543"] + 1);
}

_id_12606() {
  var_0 = self.pers["_encstr_8CAA06DB20A31543"];

  if(var_0 == 1)
    scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_9A420E58B2FE97A0974E8DFE0F8B8BAF");
  else if(var_0 == 0) {
    var_1 = scripts\engine\utility::ter_op(randomint(100) < 30, "_encstr_81F213DF7BEED71B5C539DCBA751F2B2B451C11860", "_encstr_A7A20FBDD2D8D78D2DB3CA9BD7632C6EA3");
    scripts\mp\utility\dialog::leaderdialogonplayer(var_1);
  }
}

modifyplayerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(var_4 == "_encstr_950A12A99E887D284AD42A7A31D748AA98C4A215" || var_4 == "_encstr_A68211A30F035922EF7BF1F55F0E4B59EB2BB9" || var_4 == "_encstr_87280E1FB705D168313D1FD197B1A799")
    var_3 = 999;

  return var_3;
}

onnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5) {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::oncommonnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5);
  level._id_13B93 = gettime();

  if(var_1.pers["_encstr_84C910D248050977F8F9A49F0E236BCF4B20"] > var_1 scripts\mp\utility\stats::getpersstat("_encstr_8B560B62B16B5067FCFAB88833")) {
    var_1.pers["_encstr_8B560B62B16B5067FCFAB88833"] = var_1.pers["_encstr_84C910D248050977F8F9A49F0E236BCF4B20"];
    var_1 scripts\mp\utility\stats::setextrascore1(var_1.pers["_encstr_84C910D248050977F8F9A49F0E236BCF4B20"]);
  }
}

onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_1) && isPlayer(var_1) && self != var_1) {
    if(isDefined(var_3) && var_3 == "_encstr_AA230E8CF56CD18DB12FC7E303C8C001")
      var_1._id_11FB9 = var_1._id_11FB9 + (level._id_11B3C + 2);
    else
      var_1._id_11FB9 = var_1._id_11FB9 + level._id_11B3C;

    if(var_1 attackButtonPressed())
      var_1 thread _id_14383();
    else
      var_1 scriptablenousestate();

    if(scripts\mp\utility\game::getgametypenumlives() && self.pers["_encstr_8E0607055DBFB3919A"] == scripts\mp\utility\game::getgametypenumlives())
      monitor_victim_cash_drops(var_1);

    if(var_3 == "_encstr_8DED0A21C79B660BC7588981") {
      var_1 scripts\mp\utility\stats::incpersstat("_encstr_AAAD06703BB2590B", 1);
      var_1 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_AAAD06703BB2590B", var_1.pers["_encstr_AAAD06703BB2590B"]);

      if(isPlayer(var_1))
        var_1 scripts\mp\utility\stats::setextrascore0(var_1.pers["_encstr_AAAD06703BB2590B"]);
    }

    if(scripts\mp\utility\game::matchmakinggame()) {
      foreach(var_11 in level.players) {
        if(isDefined(var_11.sessionstate) && (var_11.sessionstate == "_encstr_AF8C0A1B6A1D6045925B4F7D" || var_11.sessionstate == "_encstr_B6BB0B235235486D4AB3BBADE7")) {
          var_12 = var_11 getspectatingplayer();

          if(isDefined(var_12) && isDefined(var_1) && var_12 == var_1) {
            var_11 playlocalsound("_encstr_87DD17AA704109D7595E50511A529DF9DFEAA8E4EDD58398FA");
            var_13 = scripts\mp\rank::getscoreinfovalue("_encstr_86BD0BC00A85794E23DF8005BB");
            var_11 thread scripts\mp\rank::giverankxp("_encstr_86BD0BC00A85794E23DF8005BB", var_13);
            var_11 setclientomnvar("_encstr_88800D574B7DBD5A1BF57716D99527", gettime());
          }
        }
      }
    }
  }
}

onplayerscore(var_0, var_1, var_2, var_3) {
  var_1 scripts\mp\utility\stats::incpersstat("_encstr_A7E80EB868982F22383F6F4FD680F85D", var_2);
  var_4 = int(var_1 scripts\mp\utility\stats::getpersstat("_encstr_A7E80EB868982F22383F6F4FD680F85D"));
  var_1 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_A7E80EB868982F22383F6F4FD680F85D", var_4);

  if(issubstr(var_0, "_encstr_81F407AF432AED63D1"))
    return 0;

  if(issubstr(var_0, "_encstr_921208BB831008111EA3"))
    return 0;

  if(issubstr(var_0, "_encstr_ABD70578F3D02C")) {
    var_5 = scripts\mp\rank::getscoreinfovalue("_encstr_A68210DFBFAF8BEFB7C7E03172C73B106349");
    return var_5;
  } else if(var_0 == "_encstr_91A70B13A312807E13497961B2")
    var_1 scripts\mp\utility\script::bufferednotify("_encstr_AD7116B258277356C8BECDB17BE459AF26D566999593B232", var_2);

  return 0;
}

onsuicidedeath(var_0) {
  if(scripts\mp\utility\game::getgametypenumlives() && var_0.pers["_encstr_8E0607055DBFB3919A"] == scripts\mp\utility\game::getgametypenumlives())
    var_0 monitor_victim_cash_drops();
}

ononeleftevent(var_0) {
  var_1 = scripts\mp\utility\game::getlastlivingplayer();
  logstring("_encstr_AA2616021907B329C09E982829B833D5E71262A7E3B25F3F" + var_1.name);
  level.finalkillcam_winner = "_encstr_8BBA05185F8B99";
  level thread scripts\mp\gamelogic::endgame(var_1, game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_AF36133B4BA241B065DAE6B90541588BAADF81B31B"], game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_B2EB0EA2103F27CB58D9010EE7C3D72F"]);
}

_id_14383() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_A9AA1148FCCB5114A21F294777BB55F96D55F0");
  self endon("_encstr_A9AA1148FCCB5114A21F294777BB55F96D55F0");

  while(self attackButtonPressed())
    waitframe();

  scriptablenousestate();
}

scriptablenousestate() {
  var_0 = self.primaryweapon;
  var_1 = self getweaponammostock(var_0);
  var_2 = self getweaponammoclip(var_0);
  var_3 = weaponclipsize(var_0);

  if(var_2 + self._id_11FB9 > var_3) {
    self setweaponammoclip(var_0, var_3);
    self setweaponammostock(var_0, var_1 + var_2 + self._id_11FB9 - var_3);

    if(isDefined(self.primaryweapons[0]) && self.primaryweapons[0] hasattachment("_encstr_AD9C07E0478148252A", 1)) {
      var_4 = self getweaponammoclip(var_0, "_encstr_A5AD056A019C63");
      self setweaponammoclip(var_0, var_1 + var_4 + self._id_11FB9 - var_3, "_encstr_A5AD056A019C63");
    }
  } else {
    self setweaponammoclip(var_0, var_2 + self._id_11FB9);

    if(isDefined(self.primaryweapons[0]) && self.primaryweapons[0] hasattachment("_encstr_AD9C07E0478148252A", 1)) {
      var_4 = self getweaponammoclip(var_0, "_encstr_A5AD056A019C63");
      self setweaponammoclip(var_0, var_4 + self._id_11FB9, "_encstr_A5AD056A019C63");
    }
  }

  self playlocalsound("_encstr_B8151653D6C913796D7967FD87D8DF6FD2AFD28F9680955B");
  self._id_11FB9 = 0;
}

monitor_victim_cash_drops(var_0) {
  thread scripts\mp\hud_message::showsplash("_encstr_A2ED0DC867C44677C249A13B1B2A97");
  thread scripts\mp\hud_util::teamplayercardsplash("_encstr_8F6313A0AAA519281FA4786D845750DB8D32906812", self);

  if(isDefined(var_0)) {
    var_0 thread scripts\mp\hud_message::showsplash("_encstr_A576126429C587C5315945A163B0527D37B16719");
    var_0 thread scripts\mp\events::killeventtextpopup("_encstr_A576126429C587C5315945A163B0527D37B16719", 0);
  }

  var_1 = [];

  foreach(var_3 in level.players) {
    if(var_3.pers["_encstr_8E0607055DBFB3919A"] < scripts\mp\utility\game::getgametypenumlives() && var_3._id_11FB7) {
      var_1[var_1.size] = var_3;
      var_3 scripts\mp\utility\points::giveunifiedpoints("_encstr_A52C093330A23B194C60BB");
    }
  }

  if(var_1.size > 2)
    scripts\mp\utility\sound::playsoundonplayers("_encstr_8B78160973D7050D4BE7D98E187AFB3E038387CBA8EDAF39");
  else if(var_1.size == 2) {
    scripts\mp\utility\sound::playsoundonplayers("_encstr_82C6102771207AEAD096AE366BF8256385E1");
    level thread scripts\mp\hud_util::teamplayercardsplash("_encstr_81D01736858DB1BDAE8E7D1BB09B3AACCDB2DA97851B4BB395", var_1[0], var_1[1].team);
    level thread scripts\mp\hud_util::teamplayercardsplash("_encstr_81D01736858DB1BDAE8E7D1BB09B3AACCDB2DA97851B4BB395", var_1[1], var_1[0].team);
  }

  scripts\mp\utility\dialog::leaderdialogonplayers("_encstr_AF131558B2FE97818B5D89FB0FCFE8A3251AE8A0FB9729", level.players);
}

_id_126E7(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  while(scripts\mp\utility\player::isinkillcam())
    waitframe();

  self notifyonplayercommand("_encstr_B6F5109B5F9B878EC0509D29ABE0619B8793", "_encstr_97410B23BD6B976233901AF2F8");
  self notifyonplayercommand("_encstr_B6F5109B5F9B878EC0509D29ABE0619B8793", "_encstr_B4C60AD707B2BDC0E6CE1309");

  for(;;) {
    self waittill("_encstr_B6F5109B5F9B878EC0509D29ABE0619B8793");
    var_1 = self getspectatingplayer();

    if(isDefined(var_1)) {
      self._id_14314 = var_1.name;
      self playlocalsound("_encstr_8D6A13E4ACC6DE738CC9BDCDB27DD10BCEF50E8D39");
    }
  }
}

play_player_disguise_vo() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  scripts\mp\flags::gameflagwait("_encstr_A75411B7E0D72245126A426A8019D7B7FA7EEA");
  var_0 = undefined;

  if(scripts\mp\utility\game::matchmakinggame())
    var_0 = getdvarint("_encstr_8B08156E8D4EBE7B2D8DFA3396E60B63AA1459514BAD95", 5);

  for(;;) {
    var_1 = [];

    foreach(var_3 in level.players) {
      if(var_3.pers["_encstr_8E0607055DBFB3919A"] < scripts\mp\utility\game::getgametypenumlives() && var_3._id_11FB7)
        var_1[var_1.size] = var_3;
    }

    if(var_1.size < 4) {
      level notify("_encstr_B47913BF3541598F956FA1C82BF6B1EF0C80895FEE");

      foreach(var_3 in level.players) {
        if(scripts\mp\utility\player::isreallyalive(var_3))
          triggeroneoffradarsweep(var_3);
      }

      wait(scripts\engine\utility::ter_op(isDefined(var_0), var_0, 5));
    }

    wait 0.5;
  }
}

_id_12028() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_B47913BF3541598F956FA1C82BF6B1EF0C80895FEE");
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  level._id_13B93 = gettime();
  var_0 = undefined;
  var_1 = undefined;

  if(scripts\mp\utility\game::matchmakinggame()) {
    var_0 = getdvarint("_encstr_B28B17B91B4E7DBDB4C6EBDCED2DB48DC637550A59A8966BCA", 15);
    var_1 = getdvarint("_encstr_99471A202E4556B8588977094BC8BFC2A21990F14712BFEB6A79EB5F", 5);
  }

  var_2 = scripts\engine\utility::ter_op(isDefined(var_0), var_0, 30);
  var_2 = var_2 * 1000;
  var_3 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, 15);

  for(;;) {
    if(gettime() > level._id_13B93 + var_2) {
      foreach(var_5 in level.players) {
        if(scripts\mp\utility\player::isreallyalive(var_5))
          triggeroneoffradarsweep(var_5);
      }

      wait(var_3);
    }

    wait 1;
  }
}

_id_13158() {
  if(scripts\mp\utility\game::matchmakinggame() && getdvarint("_encstr_8EDB15878295B7AF433E3628570A1D87B80307204070E3", 2) > 0) {
    var_0 = getrandomweapon(getdvarint("_encstr_8EDB15878295B7AF433E3628570A1D87B80307204070E3", 2));
    level._id_11B3A.weapon = var_0["_encstr_AC20072B9FA9487832"];
    level._id_11B3A._id_11FBA = var_0["_encstr_8A3E0A0D67C353E09EEBD48D"];
  }

  if(!isDefined(level._id_11B3A.weapon) || level._id_11B3A.weapon == "_encstr_8BBA05185F8B99")
    level._id_11B3A.weapon = "_encstr_8BE20ED75722A6731BF84F3064CA126B";

  var_1 = tv_station_boss_should_break_stealth_immediately();

  if(var_1 > 1) {
    level._id_11B39 = level._id_11B39 * var_1;
    level._id_11B3C = level._id_11B3C * var_1;
  }
}

tv_station_boss_should_break_stealth_immediately() {
  switch (level._id_11B3A.weapon) {
    case "_encstr_A9FA0E8BE3BF871942571010A378F033":
      return 3;
    case "_encstr_8FFC0D1F543049D2AB0740FA1B7F81":
      if(level._id_11B3A._id_11FBA == 1)
        return 3;
    case "_encstr_95FA0EA5EE1CFA5827D733B08DB45B16":
      if(level._id_11B3A._id_11FBA == 6 || level._id_11B3A._id_11FBA == 9)
        return 3;
    case "_encstr_A50910B4DD83D76ED6BE9BADECDB8D33A1A9":
      if(level._id_11B3A._id_11FBA == 2)
        return 2;
    default:
      return 1;
  }
}

getrandomweapon(var_0) {
  level._id_11FB6 = spawnStruct();
  level._id_11FB6._id_1457D = [];
  level._id_11FB6._id_1457D["_encstr_88870C93169BC8EB0EA56E47F663"] = 80;
  level._id_11FB6._id_1457D["_encstr_B4D90992BFCD52477348B7"] = 40;
  level._id_11FB6._id_1457D["_encstr_8B380D1AA9F0E489C797A7E7B37903"] = 40;
  level._id_11FB6._id_1457D["_encstr_96D809932CCDC8BE635B9D"] = 25;
  level._id_11FB6._id_1457D["_encstr_8B4C0C4EB0E68CF5DCE6A5C15693"] = 40;
  buildrandomweapontable();

  if(var_0 == 2) {
    level._id_11FB6._id_1457D["_encstr_88870C93169BC8EB0EA56E47F663"] = 100;
    level._id_11FB6._id_1457D["_encstr_B4D90992BFCD52477348B7"] = 0;
    level._id_11FB6._id_1457D["_encstr_8B380D1AA9F0E489C797A7E7B37903"] = 0;
    level._id_11FB6._id_1457D["_encstr_96D809932CCDC8BE635B9D"] = 0;
    level._id_11FB6._id_1457D["_encstr_8B4C0C4EB0E68CF5DCE6A5C15693"] = 0;
  } else if(var_0 == 3) {
    level._id_11FB6._id_1457D["_encstr_88870C93169BC8EB0EA56E47F663"] = 0;
    level._id_11FB6._id_1457D["_encstr_B4D90992BFCD52477348B7"] = 0;
    level._id_11FB6._id_1457D["_encstr_8B380D1AA9F0E489C797A7E7B37903"] = 0;
    level._id_11FB6._id_1457D["_encstr_96D809932CCDC8BE635B9D"] = 0;
    level._id_11FB6._id_1457D["_encstr_8B4C0C4EB0E68CF5DCE6A5C15693"] = 100;
  } else if(var_0 == 4) {
    level._id_11FB6._id_1457D["_encstr_88870C93169BC8EB0EA56E47F663"] = 0;
    level._id_11FB6._id_1457D["_encstr_B4D90992BFCD52477348B7"] = 100;
    level._id_11FB6._id_1457D["_encstr_8B380D1AA9F0E489C797A7E7B37903"] = 0;
    level._id_11FB6._id_1457D["_encstr_96D809932CCDC8BE635B9D"] = 0;
    level._id_11FB6._id_1457D["_encstr_8B4C0C4EB0E68CF5DCE6A5C15693"] = 0;
  } else if(var_0 == 5) {
    level._id_11FB6._id_1457D["_encstr_88870C93169BC8EB0EA56E47F663"] = 0;
    level._id_11FB6._id_1457D["_encstr_B4D90992BFCD52477348B7"] = 0;
    level._id_11FB6._id_1457D["_encstr_8B380D1AA9F0E489C797A7E7B37903"] = 100;
    level._id_11FB6._id_1457D["_encstr_96D809932CCDC8BE635B9D"] = 0;
    level._id_11FB6._id_1457D["_encstr_8B4C0C4EB0E68CF5DCE6A5C15693"] = 0;
  } else if(var_0 == 6) {
    level._id_11FB6._id_1457D["_encstr_88870C93169BC8EB0EA56E47F663"] = 0;
    level._id_11FB6._id_1457D["_encstr_B4D90992BFCD52477348B7"] = 0;
    level._id_11FB6._id_1457D["_encstr_8B380D1AA9F0E489C797A7E7B37903"] = 0;
    level._id_11FB6._id_1457D["_encstr_96D809932CCDC8BE635B9D"] = 100;
    level._id_11FB6._id_1457D["_encstr_8B4C0C4EB0E68CF5DCE6A5C15693"] = 0;
  } else if(var_0 == 7) {
    level._id_11FB6._id_1457D["_encstr_88870C93169BC8EB0EA56E47F663"] = 0;
    level._id_11FB6._id_1457D["_encstr_B4D90992BFCD52477348B7"] = 0;
    level._id_11FB6._id_1457D["_encstr_8B380D1AA9F0E489C797A7E7B37903"] = 0;
    level._id_11FB6._id_1457D["_encstr_96D809932CCDC8BE635B9D"] = 100;
    level._id_11FB6._id_1457D["_encstr_8B4C0C4EB0E68CF5DCE6A5C15693"] = 50;
  }

  var_1 = risk_flagspawnminradius(level._id_11FB6._id_1457D);
  var_2 = getrandomweaponfromcategory(var_1);
  return var_2;
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

    var_2 = [];
    var_2["_encstr_AC20072B9FA9487832"] = tablelookupbyrow("_encstr_BAB31677F99257E5785CF62080415FA71058F8B092EE175C", var_0, 1);
    var_2["_encstr_8719046B4BB9"] = int(tablelookupbyrow("_encstr_BAB31677F99257E5785CF62080415FA71058F8B092EE175C", var_0, 2));
    var_2["_encstr_B81904B62CC3"] = int(tablelookupbyrow("_encstr_BAB31677F99257E5785CF62080415FA71058F8B092EE175C", var_0, 3));
    var_2["_encstr_B11B0841F940FDF79DB9"] = int(tablelookupbyrow("_encstr_BAB31677F99257E5785CF62080415FA71058F8B092EE175C", var_0, 8));

    if(!var_2["_encstr_B11B0841F940FDF79DB9"]) {
      var_0++;
      continue;
    }

    var_3 = _encstr_BA5F1D37C693D2C13A9BBC6B1C979D58AD563A5E832BCD79B3BA3717766E1B::remappedhpzoneorder(var_2["_encstr_AC20072B9FA9487832"]);
    var_2["_encstr_8A3E0A0D67C353E09EEBD48D"] = scripts\mp\class::_id_139E7(var_2["_encstr_AC20072B9FA9487832"], var_3);
    level.weaponcategories[var_1][level.weaponcategories[var_1].size] = var_2;
    var_0++;
  }
}

getrandomweaponfromcategory(var_0) {
  var_1 = [];
  var_2 = level.weaponcategories[var_0];

  if(isDefined(var_2) && var_2.size > 0) {
    var_3 = "_encstr_B40101";
    var_4 = undefined;
    var_5 = 0;

    for(;;) {
      var_6 = randomintrange(0, var_2.size);
      var_4 = var_2[var_6];
      var_7 = scripts\mp\utility\weapon::getweaponrootname(var_4["_encstr_AC20072B9FA9487832"]);

      if(!isDefined(var_1[var_7]) || var_5 > var_2.size) {
        var_1[var_7] = 1;

        for(var_8 = 0; var_8 < level.weaponcategories[var_0].size; var_8++) {
          if(level.weaponcategories[var_0][var_8]["_encstr_AC20072B9FA9487832"] == var_4["_encstr_AC20072B9FA9487832"]) {
            level.weaponcategories[var_0] = scripts\engine\utility::array_remove_index(level.weaponcategories[var_0], var_8);
            break;
          }
        }

        break;
      }

      var_5++;
    }

    return var_4;
  } else
    return "_encstr_8BBA05185F8B99";
}

setspecialloadouts() {
  level._id_11FB8["_encstr_9A8507BA4040188D08"]["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"] = level._id_11B3A.weapon;
  level._id_11FB8["_encstr_9A8507BA4040188D08"]["_encstr_9643193A25FBB9209BBB027A21C5C9FE9A07A8F86730C0DB505878"] = "_encstr_8BBA05185F8B99";
  level._id_11FB8["_encstr_9A8507BA4040188D08"]["_encstr_A1651A992F661880E76B2F5382BF4F60B8992151C94EC0D9CFA2A353"] = "_encstr_8BBA05185F8B99";
  level._id_11FB8["_encstr_9A8507BA4040188D08"]["_encstr_856C13D8BD0B19DEEAA3A027B46BC227BC0D2C6BED"] = "_encstr_8BBA05185F8B99";
  level._id_11FB8["_encstr_9A8507BA4040188D08"]["_encstr_AA0216B867B9590F9BDB978EF4725BC3F93B48F0E75390C3"] = "_encstr_8BBA05185F8B99";
  level._id_11FB8["_encstr_9A8507BA4040188D08"]["_encstr_B805263D90EB6A5F9B98038318F00953732F87B79E09B39D03B09FEBC8ADD4FB1B460C6DE5A5DBB3"] = scripts\engine\utility::ter_op(level._id_11B3A._id_11FBA != 0, 1, 0);
  level._id_11FB8["_encstr_9A8507BA4040188D08"]["_encstr_935A1863DB1619ED5DA3284E2D5B85E4E52BB0935A5873E89222"] = level._id_11B3A._id_11FBA;
  level._id_11FB8["_encstr_9A8507BA4040188D08"]["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"] = "_encstr_8BBA05185F8B99";
  level._id_11FB8["_encstr_9A8507BA4040188D08"]["_encstr_A96F1B782D99D84853DBB7D3AFDA376031C2425593D4B8765A47C3FDEB"] = "_encstr_8BBA05185F8B99";
  level._id_11FB8["_encstr_9A8507BA4040188D08"]["_encstr_B8DB1C1C17A137958B719F02564FF061B64E77B134A3D1DF58BF9BC633C7"] = "_encstr_8BBA05185F8B99";
  level._id_11FB8["_encstr_9A8507BA4040188D08"]["_encstr_8CEA1501B78EF0781F83D7199A1FA0A8260293D7217560"] = "_encstr_8BBA05185F8B99";
  level._id_11FB8["_encstr_9A8507BA4040188D08"]["_encstr_83B6181AA01BCF6F63FD93DD1E48239743E0F37168D94487786D"] = "_encstr_8BBA05185F8B99";
  level._id_11FB8["_encstr_9A8507BA4040188D08"]["_encstr_88531A48DA76F9D8EF34EEFD3BDFA0B1DEB36801D24A3BD1AB5C9B75"] = 0;
  level._id_11FB8["_encstr_9A8507BA4040188D08"]["_encstr_93A4182DD83854DA9DC90FD7E34BF385F0CDA3BAD3C0157276CB"] = "_encstr_8BBA05185F8B99";
  level._id_11FB8["_encstr_9A8507BA4040188D08"]["_encstr_8B781A89822F040F6B83E54BC8CA9378059D855728CF2D2DBF69104B"] = "_encstr_8BBA05185F8B99";
  level._id_11FB8["_encstr_9A8507BA4040188D08"]["_encstr_AD1B1288DD6928B843CB87C1FB6AF70834307321"] = "_encstr_AB3508737F830710ACDB";
  level._id_11FB8["_encstr_9A8507BA4040188D08"]["_encstr_8EE713601A6FD59883AC471BACAD30A55BD2590847"] = "_encstr_8BBA05185F8B99";
  level._id_11FB8["_encstr_9A8507BA4040188D08"]["_encstr_91E71336EDC291F6AE8E5A5AD88DB91DE456B05B8C"] = "_encstr_8BBA05185F8B99";
  level._id_11FB8["_encstr_9A8507BA4040188D08"]["_encstr_ACE713DD22D19AE80D98115804EB13E1D2D58F27C7"] = "_encstr_8BBA05185F8B99";
  level.aon_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_86CB0DFB97F7022F90BB3A7F53487B"] = ["_encstr_963D111F88AFE85B6F2253FA39630D3083FC4B"];
  level._id_11FB8["_encstr_9A8507BA4040188D08"]["_encstr_B4450F51E53FE10F4B0C1791B7ABED8085"] = "_encstr_A63C0B33252188F56B439B89EF";
  level._id_11FB8["_encstr_9A8507BA4040188D08"]["_encstr_91C8151BEDB08C7BAEE891B4B28D91550E9DC9588CAC62"] = "_encstr_A66C12DE3B63AB1307C36048AB4308C15A655E6D";
  level._id_11FB8["_encstr_9A8507BA4040188D08"]["_encstr_ACC815D8F62C23F6BAD19196598DC8AA387693C2C8598C"] = "_encstr_8BBA05185F8B99";
  level._id_11FB8["_encstr_8E8405EA382B2A"] = level._id_11FB8["_encstr_9A8507BA4040188D08"];
}

risk_flagspawnminradius(var_0) {
  var_1 = [];
  var_2 = [];
  var_3 = 0;

  foreach(var_7, var_5 in var_0) {
    if(var_5 > 0) {
      var_6 = 0;

      if(!var_6) {
        var_3 = var_3 + var_5;
        var_1[var_1.size] = var_7;
        var_2[var_2.size] = var_3;
      }
    }
  }

  var_8 = randomint(var_3);
  var_7 = undefined;

  for(var_9 = 0; var_9 < var_1.size; var_9++) {
    var_3 = var_2[var_9];

    if(var_8 < var_3) {
      var_7 = var_1[var_9];
      break;
    }
  }

  return var_7;
}