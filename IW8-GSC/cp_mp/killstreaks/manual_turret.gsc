/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\killstreaks\manual_turret.gsc
***********************************************/

init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4", "_encstr_88C5055208731B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4", "_encstr_88C5055208731B")]]();

  scripts\cp_mp\utility\killstreak_utility::registervisibilityomnvarforkillstreak("_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4", "_encstr_AB0703DBB9", 10);
}

weaponcleanupmanualturret(var_0, var_1, var_2) {
  if(!istrue(var_1))
    scripts\cp_mp\killstreaks\killstreakdeploy::rocket_fuel(var_2);
}

tryusemanualturret(var_0) {
  var_1 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo(var_0, self);
  return tryusemanualturretfromstruct(var_1);
}

tryusemanualturretfromstruct(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var_0))
      return 0;
  }

  scripts\cp_mp\utility\weapon_utility::_id_12EB2();
  var_1 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponswitchdeploy(var_0, getcompleteweaponname("_encstr_BEBE18E1377010C0EBFF535323F31FD897CB4BBB9A7D889082AB"), 1, undefined, undefined, ::weaponcleanupmanualturret);

  if(!istrue(var_1))
    return 0;

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var_0))
      return 0;
  }

  _id_11ACC(0);
  var_2 = manualturret_create("_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4", var_0);

  if(!isDefined(var_2)) {
    _id_11ACC(1);
    return 0;
  }

  var_3 = manualturret_watchplacement(var_2, var_0, 0, 1.25);

  if(!isDefined(var_3)) {
    _id_11ACC(1);
    var_2 delete();
    return 0;
  }

  _id_11ACC(1);
  manualturret_setplaced(var_2, var_3);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4", "_encstr_8B330D3ADBD0F47B4B9536570725A8"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4", "_encstr_8B330D3ADBD0F47B4B9536570725A8")]]();

  return 1;
}

manualturret_watchplacement(var_0, var_1, var_2, var_3) {
  thread manualturret_delayplacementinstructions(var_3);
  var_4 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4", "_encstr_B6F720D3A849463B5D38FAD04141870FAD11CA5B201DBC6B5181F10B652FFB562DF0"))
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4", "_encstr_B6F720D3A849463B5D38FAD04141870FAD11CA5B201DBC6B5181F10B652FFB562DF0")]]();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4", "_encstr_BDEC10D7BDF951795318BFE3516922EAA34E"))
    var_4 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4", "_encstr_BDEC10D7BDF951795318BFE3516922EAA34E")]](var_1, var_2);

  self notify("_encstr_B4F71A4B9BBA587D93A7013177CAB57845B5B3A6C719F0239B631339");

  if(!isDefined(var_4) || !isDefined(var_4.location)) {
    if(istrue(self.inlaststand))
      scripts\cp_mp\utility\inventory_utility::_takeweapon("_encstr_BEBE18E1377010C0EBFF535323F31FD897CB4BBB9A7D889082AB");
    else if(scripts\cp_mp\utility\player_utility::_isalive())
      manualturret_switchbacklastweapon("_encstr_BEBE18E1377010C0EBFF535323F31FD897CB4BBB9A7D889082AB");

    return undefined;
  }

  var_0 thread manualturret_disablefire(self, 1, 1);

  if(self hasweapon("_encstr_BEBE18E1377010C0EBFF535323F31FD897CB4BBB9A7D889082AB"))
    thread manualturret_switchbacklastweapon("_encstr_BEBE18E1377010C0EBFF535323F31FD897CB4BBB9A7D889082AB", 1, 1);

  var_5 = 0.85;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_5);
  return var_4;
}

manualturret_delayplacementinstructions(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_B4F71A4B9BBA587D93A7013177CAB57845B5B3A6C719F0239B631339");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  self setclientomnvar("_encstr_A77514BF208604239D46DF9338416AD9A9F85767709B", 1);
  thread _id_11AC6("_encstr_AD75063D571AE108");
  thread _id_11AC6("_encstr_B4F71A4B9BBA587D93A7013177CAB57845B5B3A6C719F0239B631339");
}

_id_11AC6(var_0) {
  self endon("_encstr_B6F91292C06BC65339BDD7F04141EF0F9310CA5B");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill(var_0);
  self setclientomnvar("_encstr_A77514BF208604239D46DF9338416AD9A9F85767709B", 0);
  self notify("_encstr_B6F91292C06BC65339BDD7F04141EF0F9310CA5B");
}

manualturret_create(var_0, var_1) {
  var_2 = level.sentrysettings[var_0];
  var_3 = spawnturret("_encstr_97710C6B2DCD1BAF3AD54E4E598E", self.origin, level.sentrysettings[var_0].weaponinfo);
  var_3.owner = self;
  var_3.team = self.team;
  var_3.angles = self.angles;
  var_3.health = 9999;
  var_3.maxhealth = var_2.maxhealth;
  var_3.streakinfo = var_1;
  var_3.turrettype = var_0;
  var_3.shouldsplash = 1;
  var_3.ammocount = var_2.ammo;
  var_3.reticlestate = "_encstr_8D370BB6D7CB5BE9ECEF8910DB";
  var_3.timeout = var_2.timeout;
  var_3.carriedby = self;
  var_3 manualturret_setturretmodel("_encstr_B8B00782A191CB07D9");
  var_3 makeunusable();
  var_3 setnodeploy(1);
  var_3 setdefaultdroppitch(0);
  var_3 hide();
  var_3 scripts\cp_mp\emp_debuff::allow_emp(0);
  var_5 = anglesToForward(var_3.angles);
  var_6 = var_3 gettagorigin("_encstr_9A1E0A3A85B3F5632CB9954E") + (0, 0, 10);
  var_6 = var_6 - var_5 * 20;
  var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_6);
  var_7 linkTo(var_3);
  var_3.killcament = var_7;
  var_3.helperdrone_isbeingpingedbydrone = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_3.origin);
  var_3.helperdrone_isbeingpingedbydrone.team = var_3.team;
  var_3.helperdrone_isbeingpingedbydrone.owner = var_3.owner;
  var_3.helperdrone_isbeingpingedbydrone setModel("_encstr_82EE2697EDA73962101FC4FD3F714F280B9760DB43D099E345B38BD5F1C144204D403FCF8AF9E665");
  var_3.helperdrone_isbeingpingedbydrone dontinterpolate();
  var_3.helperdrone_isbeingpingedbydrone hide();
  var_3.helperdrone_isbeingpingedbydrone.moverdoesnotkill = 1;
  var_3.helperdrone_isbeingpingedbydrone._id_13E8D = var_3;
  return var_3;
}

manualturret_setplaced(var_0, var_1) {
  var_2 = level.sentrysettings[var_0.turrettype];
  var_0 manualturret_setturretmodel("_encstr_B8B00782A191CB07D9");

  if(!isDefined(self.placedsentries))
    self.placedsentries = [];

  if(!isDefined(self.placedsentries[var_0.turrettype]))
    self.placedsentries[var_0.turrettype] = [];

  if(istrue(var_0.shouldsplash)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8260069BDBBACD46", "_encstr_83011BC11B0B5E2D5AD8B1373A395916B688CA83B17BE5444B16D8F6D9"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8260069BDBBACD46", "_encstr_83011BC11B0B5E2D5AD8B1373A395916B688CA83B17BE5444B16D8F6D9")]](self, var_0.streakinfo.streakname);

    var_3 = var_2.teamsplash;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B675156D3DDFF0C17D7AB850A35E5BEB2393F7E991CF18"))
      level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B675156D3DDFF0C17D7AB850A35E5BEB2393F7E991CF18")]](var_3, self);

    var_0.shouldsplash = 0;
  }

  var_0 show();
  var_0 dontinterpolate();
  var_0.angles = var_1.angles;
  var_0.carriedby = undefined;

  if(isDefined(var_1.moving_platform)) {
    var_0.moving_platform = var_1.moving_platform;
    var_0._id_11DBE = var_1._id_11DBE;
    var_0._id_11DBD = var_1._id_11DBD;
  }

  if(isDefined(self.hideammoindex)) {
    for(var_4 = self.hideammoindex; var_4 >= 1; var_4--)
      var_0 setscriptablepartstate("_encstr_8D2E0B6828BD35066967B79F1F" + var_4, "_encstr_AB0703DBB9", 0);
  }

  var_5 = "_encstr_BA19049F4B2D";

  if(var_0.reticlestate == "_encstr_8DC60C65E56330C6C33A8EB032D3")
    var_5 = "_encstr_AB0703DBB9";

  var_0 setscriptablepartstate("_encstr_A3880DF0A46428A82B87F1F3A7F28D", var_5, 0);
  var_0.origin = var_1.location;
  var_0 playSound("_encstr_931A11C275C203937A69DC3F0D89CB65633853");
  var_0.helperdrone_isbeingpingedbydrone show();
  var_0.helperdrone_isbeingpingedbydrone.angles = var_0.angles;
  var_0.helperdrone_isbeingpingedbydrone.origin = var_0.origin;
  var_0.helperdrone_isbeingpingedbydrone linkTo(var_0, "_encstr_8AFF0E7BE26F40E0BC8D6731A123C89D");
  var_6 = scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB")]]() == "_encstr_B607038AAB";

  if(!var_6) {
    var_7 = "_encstr_AAB81AB436DBCDAFDAD29B2DB6160E7D5BBD13D2C6ACD1AE4EE456A3";

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_A5B0108E1B78310BF5DFB39BE3AE53614841"))
      var_0.minimapid = var_0.helperdrone_isbeingpingedbydrone[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_A5B0108E1B78310BF5DFB39BE3AE53614841")]](var_7, var_0.team, undefined, 1, 1);
  }

  var_8 = self.placedsentries[var_0.turrettype].size;
  self.placedsentries[var_0.turrettype][var_8] = var_0;

  if(var_8 + 1 > 1)
    self.placedsentries[var_0.turrettype][0] notify("_encstr_932D0C087BD23CA6CBBB553A4DE8", 0, 0);

  var_9 = 70;

  if(var_0.model == level.sentrysettings[var_0.turrettype].modelbasecover)
    var_9 = 35;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_921B1AD3D478AF17A073A49C55D25C7018C9524B4648513A43281F23"))
    var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_921B1AD3D478AF17A073A49C55D25C7018C9524B4648513A43281F23")]](var_0.turrettype, "_encstr_912912A962ED2193D37ABDA74B57DDA5950B1858", self, 0, 1, var_9, "_encstr_8C900F2EC6BB7DB8F51B79D8A71A139B03");

  var_0 setmode(level.sentrysettings[var_0.turrettype].sentrymodeon);
  var_10 = "_encstr_97B00AA6BED19C2DEC3B95C9";

  if(!isDefined(var_0.useownerobj)) {
    var_11 = var_0 gettagorigin(var_10);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4", "_encstr_BEDD11FE1EE33A449979E7F3F0B40AD24B3E83"))
      var_0.useownerobj = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4", "_encstr_BEDD11FE1EE33A449979E7F3F0B40AD24B3E83")]](var_11, "_encstr_BA110C20C7C0F307EDF9111CB7A1", undefined, var_2.ownerusehintstring, -1, "_encstr_97C20EB5FD43A179CC6AD05152651579", undefined, 17, undefined, 17);
  } else {
    var_11 = var_0 gettagorigin(var_10);
    var_0.useownerobj makeusable();
    var_0.useownerobj dontinterpolate();
    var_0.useownerobj.origin = var_11;
  }

  var_0.useownerobj linkTo(var_0, var_10);

  if(!isDefined(var_0.useotherobj)) {
    var_11 = var_0 gettagorigin(var_10);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4", "_encstr_BEDD11FE1EE33A449979E7F3F0B40AD24B3E83"))
      var_0.useotherobj = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4", "_encstr_BEDD11FE1EE33A449979E7F3F0B40AD24B3E83")]](var_11, "_encstr_BA110C20C7C0F307EDF9111CB7A1", undefined, var_2.otherusehintstring, -1, "_encstr_97C20EB5FD43A179CC6AD05152651579", undefined, 17, undefined, 17);
  } else {
    var_11 = var_0 gettagorigin(var_10);
    var_0.useotherobj makeusable();
    var_0.useotherobj dontinterpolate();
    var_0.useotherobj.origin = var_11;
  }

  var_0.useotherobj linkTo(var_0, var_10);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4", "_encstr_824D15630388FAD498047D03B8F8E771519B9BA3F72ED2"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4", "_encstr_824D15630388FAD498047D03B8F8E771519B9BA3F72ED2")]](var_0);

  var_0 scripts\cp_mp\emp_debuff::allow_emp(1);
  var_0 scripts\mp\sentientpoolmanager::registersentient("_encstr_B1B01227D9B5C81E73BB39A13207C6C00E3CEBEF", self);
  var_0 thread manualturret_delaydeletemarker(self, var_1);
  var_0 thread manualturret_watchuse(self, var_0.useownerobj);
  var_0 thread manualturret_watchuse(self, var_0.useotherobj);
  var_0 thread manualturret_watchpickup(self);
  var_0 thread manualturret_watchdamage(self);
  var_0 thread manualturret_watchdeath(self);
  var_0 thread _id_11ACE();
  var_0 thread manualturret_watchtimeout(self);
  var_0 thread manualturret_watchdisown(self);
}

manualturret_setcarried(var_0) {
  self endon("_encstr_932D0C087BD23CA6CBBB553A4DE8");
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 endon("_encstr_A54E11D3FB3F8E1079DC4B7DE2DFD8C0B763E9");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(istrue(self.inuse)) {
    self.inuse = undefined;
    var_0 _id_11ACD(1);
  }

  if(isDefined(self.moving_platform)) {
    self.moving_platform = undefined;
    self._id_11DBE = undefined;
    self._id_11DBD = undefined;
    self unlink();
  }

  scripts\cp_mp\emp_debuff::allow_emp(0);
  scripts\mp\sentientpoolmanager::unregistersentient(self.sentientpool, self.sentientpoolindex);
  var_1 = self getlinkedchildren();

  foreach(var_3 in var_1) {
    if(isDefined(var_3))
      var_3 unlink();
  }

  if(isDefined(self.minimapid)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_867712AA1378832BD004D25AA9BECB7C808B1924"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_867712AA1378832BD004D25AA9BECB7C808B1924")]](self.minimapid);

    self.minimapid = undefined;
  }

  self.helperdrone_isbeingpingedbydrone hide();
  var_0 manualturret_setinactive(self);
  self hide();
  self.carriedby = var_0;
  self notify("_encstr_8C900F2EC6BB7DB8F51B79D8A71A139B03");
  self playSound("_encstr_8AF00E9BACCDE8C9BCEB384B36ADAE83");
  var_0 scripts\cp_mp\utility\weapon_utility::_id_12EB2();
  var_0 scripts\cp_mp\utility\inventory_utility::_giveweapon("_encstr_BEBE18E1377010C0EBFF535323F31FD897CB4BBB9A7D889082AB");
  var_0 scripts\cp_mp\utility\inventory_utility::_switchtoweapon("_encstr_BEBE18E1377010C0EBFF535323F31FD897CB4BBB9A7D889082AB");
  var_0 _id_11ACC(0);
  var_5 = var_0 manualturret_watchplacement(self, self.streakinfo, 1, 2);

  if(!isDefined(var_5)) {
    var_0 _id_11ACC(1);
    return 0;
  }

  var_0 _id_11ACC(1);
  var_0 manualturret_setplaced(self, var_5);
}

manualturret_switchbacklastweapon(var_0, var_1, var_2) {
  if(isDefined(var_2) && var_2 > 0) {
    self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
    level endon("_encstr_9B1D0BC7932875276230426AA1");
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_2);
  }

  var_3 = scripts\cp_mp\utility\weapon_utility::_id_12CC7(self.lastdroppableweaponobj);

  if(istrue(var_1))
    scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var_3);
  else
    scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var_3);

  scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0);
}

manualturret_setinactive(var_0) {
  var_0 setmode(level.sentrysettings[var_0.turrettype].sentrymodeoff);
  var_0 setturretminimapvisible(0);
  var_0 manualturret_makealltriggersusable(0);
  var_0.useownerobj unlink();
  var_0.useotherobj unlink();
}

manualturret_delaydeletemarker(var_0, var_1) {
  self endon("_encstr_932D0C087BD23CA6CBBB553A4DE8");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 0.25;

  if(isDefined(var_1.visual))
    var_1.visual delete();
}

manualturret_watchuse(var_0, var_1) {
  self endon("_encstr_932D0C087BD23CA6CBBB553A4DE8");
  self endon("_encstr_8C900F2EC6BB7DB8F51B79D8A71A139B03");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  foreach(var_3 in level.players) {
    var_1 enableplayeruse(var_3);

    if(var_1 == self.useownerobj) {
      if(var_3 == var_0)
        continue;
    } else if(level.teambased && var_3.team == var_0.team && var_3 != var_0) {
      continue;
    }
    var_1 disableplayeruse(var_3);
  }

  thread manualturret_disableplayeruseonconnect(var_0, var_1);

  for(;;) {
    var_1 waittill("_encstr_8F5C086405E70FBA4B4A", var_3);

    if(istrue(self.inuse)) {
      continue;
    }
    if(istrue(self._id_138E0)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
        var_3[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_AB9619B11B4B4C8B3CC2F56DF11F4014A3F52FA12B97C178791E31");

      continue;
    }

    if(var_3 isonladder() || !var_3 isonground() || var_3 ismantling()) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
        var_3[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_AD481BB44A2689D4454A8AA02DD4CB3482C99C3D45BE908AFA55A9A888");

      continue;
    }

    if(istrue(var_3.isjuggernaut)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
        var_3[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_A22320B8F7B4381163A5E1A3F80F0804B76777CF487F36C40FB7BF7508487F19236F");

      continue;
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4", "_encstr_8CDE1476A048475337CB9FA7EBCF1886716B2A3A3920")) {
      if(!var_3[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4", "_encstr_8CDE1476A048475337CB9FA7EBCF1886716B2A3A3920")]]())
        continue;
    }

    self.inuse = 1;
    var_3 _id_11ACD(0);
    var_3 disableturretdismount();

    if(var_3 == var_0) {
      for(var_5 = 0; isDefined(var_3) && var_3 useButtonPressed() && var_5 < 0.25; var_5 = var_5 + level.framedurationseconds)
        waitframe();

      if(var_5 >= 0.25) {
        self.inuse = undefined;

        if(isDefined(var_3)) {
          var_3 enableturretdismount();

          if(var_3 scripts\cp_mp\utility\player_utility::_isalive())
            var_3 _id_11ACD(1);
        }

        continue;
      }
    }

    var_3 notify("_encstr_A54E11D3FB3F8E1079DC4B7DE2DFD8C0B763E9");
    self._id_126E2 = var_3;
    manualturret_makealltriggersusable(0);
    var_3 scripts\cp_mp\utility\weapon_utility::_id_12EB2();
    var_3.useweapon = level.sentrysettings[self.turrettype].playerweaponinfo;
    var_3 scripts\cp_mp\utility\inventory_utility::_giveweapon(var_3.useweapon, undefined, undefined, 1);
    var_6 = gettime();
    var_7 = undefined;

    while(gettime() - var_6 < 1000.0) {
      var_7 = _id_11AC8(var_3, var_3.useweapon);

      if(!isDefined(var_7) || istrue(var_7)) {
        break;
      }

      waitframe();
    }

    if(!istrue(var_7)) {
      self.inuse = undefined;
      self._id_126E2 = undefined;
      manualturret_makealltriggersusable(1);

      if(isDefined(var_3)) {
        if(var_3 scripts\cp_mp\utility\player_utility::_isalive()) {
          var_3 _id_11ACD(1);
          var_8 = var_3 scripts\cp_mp\utility\weapon_utility::_id_12CC7(var_3.lastdroppableweaponobj);
          var_3 switchtoweaponimmediate(var_8);
        }

        var_3 clearhighpriorityweapon(var_3.useweapon);
        var_3 scripts\cp_mp\utility\inventory_utility::_takeweapon(var_3.useweapon);
      }

      continue;
    }

    var_3.currentturret = self;
    var_3 controlturreton(self);

    if(scripts\cp_mp\utility\game_utility::isnightmap())
      var_3 scripts\common\utility::brjugg_oncrateuse(0);

    manualturret_applyoverlay(var_3);
    thread manualturret_disablefire(var_3, 0.5, 1);
    thread manualturret_watchammotracker(var_3);
    thread _id_11AC9(var_3);
    thread _id_11ACA(var_3);
    thread manualturret_endturretusewatch(var_3);
    thread manualturret_endturretonplayer(var_3);
    thread manualturret_watchplayerangles(var_3);
  }
}

_id_11AC8(var_0, var_1) {
  self endon("_encstr_932D0C087BD23CA6CBBB553A4DE8");
  self endon("_encstr_8EDB1D9BE39503BB7931B3BB77AB9E89290B07204070E3AFD4F83D8560CB68");
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  thread _id_11ACF(1.0);
  var_2 = var_0 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_1, 1);
  self notify("_encstr_88A41B5BDF93DA570B10331C7329EAB349FFF709F2F5FA277D930AB8CD");
  return var_2;
}

_id_11ACF(var_0) {
  self endon("_encstr_932D0C087BD23CA6CBBB553A4DE8");
  self endon("_encstr_88A41B5BDF93DA570B10331C7329EAB349FFF709F2F5FA277D930AB8CD");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  self notify("_encstr_8EDB1D9BE39503BB7931B3BB77AB9E89290B07204070E3AFD4F83D8560CB68");
}

manualturret_watchdismantle(var_0, var_1) {
  self endon("_encstr_932D0C087BD23CA6CBBB553A4DE8");
  self endon("_encstr_8C900F2EC6BB7DB8F51B79D8A71A139B03");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  foreach(var_3 in level.players) {
    var_1 enableplayeruse(var_3);

    if(level.teambased && var_3.team != var_0.team)
      continue;
    else if(!level.teambased) {
      if(var_3 != var_0)
        continue;
    }

    var_1 disableplayeruse(var_3);
  }

  thread manualturret_disableplayerdismantleonconnect(var_0);

  for(;;) {
    var_1 waittill("_encstr_8F5C086405E70FBA4B4A", var_3);
    self notify("_encstr_932D0C087BD23CA6CBBB553A4DE8", 0, 1);
    break;
  }
}

manualturret_applyoverlay(var_0) {
  var_0 scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(self.streakinfo.streakname, "_encstr_AB0703DBB9");
  var_0 setclientomnvar("_encstr_954F1A83F8786F05F03B9C9DBFA84BEB16910BA901C82BBB280F8473", 1);
  var_0 setclientomnvar("_encstr_85AC1CF0D081B7D4BAAB277983AFCBFF5F6B9FDFE32F4DFFCB903E218045", self.ammocount);
}

manualturret_removeoverlay(var_0) {
  var_0 scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(self.streakinfo.streakname, "_encstr_BA19049F4B2D");
  var_0 setclientomnvar("_encstr_954F1A83F8786F05F03B9C9DBFA84BEB16910BA901C82BBB280F8473", 0);
}

manualturret_disablefire(var_0, var_1, var_2) {
  if(istrue(var_2)) {
    var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
    level endon("_encstr_9B1D0BC7932875276230426AA1");
  }

  if(isDefined(var_0) && scripts\cp_mp\utility\player_utility::_isalive())
    var_0 freezecontrols(1);
  else
    return;

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_1);

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(var_0) && scripts\cp_mp\utility\player_utility::_isalive())
    var_0 freezecontrols(0);
  else
    return;
}

manualturret_enableenemyoutlines(var_0) {
  if(!isDefined(self.enemyoutlineinfos))
    self.enemyoutlineinfos = [];

  thread manualturret_enableenemyoutlinesonconnect(var_0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4", "_encstr_8109104A2DEB99C539550A3A11D1D2ADA52A")) {
    foreach(var_2 in [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4", "_encstr_8109104A2DEB99C539550A3A11D1D2ADA52A")]](var_0.team)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")) {
        if(var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")]]("_encstr_AF36191733A246B0611D833AC94648867AE789B337CB95A0B175A9")) {
          if(!var_2 scripts\cp_mp\utility\player_utility::_isalive())
            thread manualturret_enableenemyoutlineafterprotection(var_0, var_2, 1);
          else if(isDefined(var_2.avoidkillstreakonspawntimer) && var_2.avoidkillstreakonspawntimer > 0)
            thread manualturret_enableenemyoutlineafterprotection(var_0, var_2);

          continue;
        }
      }

      manualturret_addtooutlinelist(var_0, var_2);
    }
  }
}

manualturret_enableenemyoutlinesonconnect(var_0) {
  self endon("_encstr_932D0C087BD23CA6CBBB553A4DE8");
  var_0 endon("_encstr_8C850F1558E1177B8BC8731AE08773EFB9");

  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_1);
    thread manualturret_enableenemyoutlineafterprotection(var_0, var_1, 1);
  }
}

manualturret_removeoutlineondeath(var_0, var_1, var_2) {
  self endon("_encstr_932D0C087BD23CA6CBBB553A4DE8");
  var_0 endon("_encstr_8C850F1558E1177B8BC8731AE08773EFB9");
  var_1 waittill("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  manualturret_removefromoutlinelist(var_1, var_2);

  if(isDefined(var_1))
    thread manualturret_restoreoutlineonspawn(var_0, var_1);
}

manualturret_restoreoutlineonspawn(var_0, var_1) {
  self endon("_encstr_932D0C087BD23CA6CBBB553A4DE8");
  var_0 endon("_encstr_8C850F1558E1177B8BC8731AE08773EFB9");
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    level waittill("_encstr_957F0FC1B1C22FCAC9AFE6E016EEB9CA23", var_2);

    if(var_2 != var_1) {
      continue;
    }
    thread manualturret_enableenemyoutlineafterprotection(var_0, var_2);
  }
}

manualturret_enableenemyoutlineafterprotection(var_0, var_1, var_2) {
  self endon("_encstr_932D0C087BD23CA6CBBB553A4DE8");
  var_0 endon("_encstr_8C850F1558E1177B8BC8731AE08773EFB9");

  if(istrue(var_2))
    var_1 waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");

  if(isDefined(var_1.avoidkillstreakonspawntimer) && var_1.avoidkillstreakonspawntimer > 0)
    var_1 waittill("_encstr_939B1482339AFF05D9613947D0D1CCCA972BF56DB222");

  if(level.teambased && var_1.team == var_0.team) {
    return;
  }
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")) {
    if(var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")]]("_encstr_AF36191733A246B0611D833AC94648867AE789B337CB95A0B175A9"))
      return;
  }

  manualturret_addtooutlinelist(var_0, var_1);
}

manualturret_addtooutlinelist(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.ent = var_1;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8D360838D3CB51A8EEEF", "_encstr_974217BDCBC00CCA609B5FFBFB1EE27D391072CA40B0D1C246"))
    var_2.entoutlineid = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8D360838D3CB51A8EEEF", "_encstr_974217BDCBC00CCA609B5FFBFB1EE27D391072CA40B0D1C246")]](var_1, var_0, "_encstr_A2A117F6AB471B5AE656AFE6DB199583D134FADB930BCD76CA", "_encstr_AC760D7A6AE6A9501F43EF73238A0C");

  self.enemyoutlineinfos[self.enemyoutlineinfos.size] = var_2;
  thread manualturret_removeoutlineondeath(var_0, var_1, var_2.entoutlineid);
  return var_2;
}

manualturret_removefromoutlinelist(var_0, var_1) {
  if(!isDefined(self.enemyoutlineinfos)) {
    return;
  }
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8D360838D3CB51A8EEEF", "_encstr_BABB0FDED51D632DE62B11A5B90BC4D8CA"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8D360838D3CB51A8EEEF", "_encstr_BABB0FDED51D632DE62B11A5B90BC4D8CA")]](var_1, var_0);

  var_2 = [];

  foreach(var_4 in self.enemyoutlineinfos) {
    if(var_4.ent == var_0) {
      continue;
    }
    var_2[var_2.size] = var_4;
  }

  self.enemyoutlineinfos = var_2;
}

manualturret_disableenemyoutlines(var_0) {
  if(!isDefined(self.enemyoutlineinfos)) {
    return;
  }
  foreach(var_2 in self.enemyoutlineinfos) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8D360838D3CB51A8EEEF", "_encstr_BABB0FDED51D632DE62B11A5B90BC4D8CA"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8D360838D3CB51A8EEEF", "_encstr_BABB0FDED51D632DE62B11A5B90BC4D8CA")]](var_2.entoutlineid, var_2.ent);
  }

  self.enemyoutlineinfos = undefined;
}

manualturret_endplayeruse(var_0) {
  if(isDefined(var_0)) {
    var_0.inuse = undefined;
    var_0._id_126E2 = undefined;
    var_0 manualturret_makealltriggersusable(1);
  }

  if(isDefined(self)) {
    if(!self usinggamepad())
      self enableturretdismount();

    if(isDefined(var_0)) {
      if(isDefined(self.currentturret) && self.currentturret != var_0) {
        return;
      }
      self controlturretoff(var_0);
      var_0 manualturret_removeoverlay(self);

      if(!istrue(var_0.usedropspawn))
        var_0 thread manualturret_watchpickup(var_0.owner);
    }

    self.currentturret = undefined;
    _id_11ACD(1);

    if(scripts\cp_mp\utility\game_utility::isnightmap())
      scripts\common\utility::brjugg_oncrateuse(1);

    if(level.gametype != "_encstr_B607038AAB" || level.gametype == "_encstr_B607038AAB" && !istrue(self.inlaststand)) {
      var_1 = scripts\cp_mp\utility\weapon_utility::_id_12CC7(self.lastdroppableweaponobj);
      self switchtoweaponimmediate(var_1);
    }

    scripts\cp_mp\utility\inventory_utility::_takeweapon(self.useweapon);
    thread _id_11AC7();

    if(scripts\cp_mp\utility\player_utility::_isalive()) {
      self setOrigin(var_0.lastuserpos, 1);
      self setplayerangles(var_0.lastuserangles);
    }

    self notify("_encstr_8C850F1558E1177B8BC8731AE08773EFB9");
  }
}

_id_11AC7() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  scripts\common\utility::allow_crouch(0, "_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4");
  scripts\common\utility::allow_prone(0, "_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4");
  scripts\common\utility::allow_mantle(0, "_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);
  scripts\common\utility::allow_crouch(1, "_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4");
  scripts\common\utility::allow_prone(1, "_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4");
  scripts\common\utility::allow_mantle(1, "_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4");
}

manualturret_disableplayeruseonconnect(var_0, var_1) {
  if(isDefined(self)) {
    self endon("_encstr_932D0C087BD23CA6CBBB553A4DE8");
    self endon("_encstr_8C900F2EC6BB7DB8F51B79D8A71A139B03");
  }

  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_2);
    var_1 disableplayeruse(var_2);
  }
}

_id_11AC9(var_0) {
  self endon("_encstr_932D0C087BD23CA6CBBB553A4DE8");
  self endon("_encstr_8C900F2EC6BB7DB8F51B79D8A71A139B03");
  var_0 endon("_encstr_8C850F1558E1177B8BC8731AE08773EFB9");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    if(var_0 isinexecutionvictim()) {
      var_0 manualturret_endplayeruse(self);
      break;
    }

    waitframe();
  }
}

_id_11ACA(var_0) {
  self endon("_encstr_932D0C087BD23CA6CBBB553A4DE8");
  self endon("_encstr_8C900F2EC6BB7DB8F51B79D8A71A139B03");
  var_0 endon("_encstr_8C850F1558E1177B8BC8731AE08773EFB9");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = 2500;

  if(isDefined(self.moving_platform))
    var_1 = 10000;

  for(;;) {
    if(distancesquared(self.origin, var_0.origin) >= var_1) {
      var_0 manualturret_endplayeruse(self);
      break;
    }

    waitframe();
  }
}

manualturret_endturretusewatch(var_0) {
  self endon("_encstr_932D0C087BD23CA6CBBB553A4DE8");
  self endon("_encstr_8C900F2EC6BB7DB8F51B79D8A71A139B03");
  var_0 endon("_encstr_8C850F1558E1177B8BC8731AE08773EFB9");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  while(var_0 useButtonPressed())
    waitframe();

  for(;;) {
    if(var_0 useButtonPressed()) {
      var_0 manualturret_endplayeruse(self);
      break;
    }

    waitframe();
  }
}

manualturret_endturretonplayer(var_0) {
  var_0 endon("_encstr_8C850F1558E1177B8BC8731AE08773EFB9");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 scripts\engine\utility::_id_143A5("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5", "_encstr_8FE01132F817F3978BE5B9BEF5567FBB5B183B");
  var_0 manualturret_endplayeruse(self);
}

manualturret_watchplayerangles(var_0) {
  self endon("_encstr_932D0C087BD23CA6CBBB553A4DE8");
  var_0 endon("_encstr_8C850F1558E1177B8BC8731AE08773EFB9");
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self.lastuserpos = var_0.origin;
    self.lastuserangles = var_0 getplayerangles();
    waitframe();
  }
}

manualturret_watchpickup(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  self endon("_encstr_932D0C087BD23CA6CBBB553A4DE8");
  self endon("_encstr_8C900F2EC6BB7DB8F51B79D8A71A139B03");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_A54E11D3FB3F8E1079DC4B7DE2DFD8C0B763E9");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  while(isDefined(self) && isDefined(self.useownerobj)) {
    self.useownerobj waittill("_encstr_93461143DEC7CA1FF04AD13A3A32EF6A5F700B", var_1);

    for(var_2 = 0; var_0 useButtonPressed() && var_2 < 0.25; var_2 = var_2 + level.framedurationseconds)
      waitframe();

    if(!isDefined(var_1)) {
      continue;
    }
    if(var_2 < 0.25) {
      continue;
    }
    if(istrue(self._id_138E0)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
        var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_AB9619B11B4B4C8B3CC2F56DF11F4014A3F52FA12B97C178791E31");

      continue;
    }

    if(istrue(var_1.isjuggernaut)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
        var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_A22320B8F7B4381163A5E1A3F80F0804B76777CF487F36C40FB7BF7508487F19236F");

      continue;
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4", "_encstr_8CDE1476A048475337CB9FA7EBCF1886716B2A3A3920")) {
      if(!var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4", "_encstr_8CDE1476A048475337CB9FA7EBCF1886716B2A3A3920")]]())
        continue;
    }

    manualturret_makealltriggersusable(0);
    self setmode(level.sentrysettings[self.turrettype].sentrymodeoff);
    var_0.placedsentries[self.turrettype] = scripts\engine\utility::array_remove(var_0.placedsentries[self.turrettype], self);
    thread manualturret_setcarried(var_0);
  }
}

manualturret_watchdelayedpickup(var_0) {
  self endon("_encstr_932D0C087BD23CA6CBBB553A4DE8");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.5);
  thread manualturret_watchpickup(var_0);
}

manualturret_disableplayerpickuponconnect(var_0) {
  var_0 endon("_encstr_932D0C087BD23CA6CBBB553A4DE8");
  var_0 endon("_encstr_8C900F2EC6BB7DB8F51B79D8A71A139B03");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_1);
    var_0.useownerobj disableplayeruse(var_1);
  }
}

manualturret_watchdamage(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4", "_encstr_93790EDAEDCDA5D1F6E4110BDA0B3B56"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4", "_encstr_93790EDAEDCDA5D1F6E4110BDA0B3B56")]](self.maxhealth, "_encstr_A2FB098A2035874AB0F358", ::manualturret_handledeathdamage, ::manualturret_modifydamage, 1);
}

manualturret_handledeathdamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflags;
  var_6 = level.sentrysettings[self.turrettype];
  var_7 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B2BE0788BAF573592F", "_encstr_8CED1307B60498F97BF333FBFA2722D1241CB99B24"))
    var_7 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B2BE0788BAF573592F", "_encstr_8CED1307B60498F97BF333FBFA2722D1241CB99B24")]](var_6.streakname, var_1, var_2, var_3, var_4, var_6.scorepopup, var_6.vodestroyed, var_6.destroyedsplash);

  if(var_7)
    var_1 notify("_encstr_85BB142A408F7BABB0EB352C9099EF43C38022B2A029");

  var_8 = 0;

  if(var_3 == "_encstr_B45C0E2DFF41B17F437FB870E733FBFF" || var_3 == "_encstr_84670F0D974DCF124E3F7A931851A1FB9F" || var_3 == "_encstr_8E39168B5F1FF12F4B08BC45D08B6BA1E7F73F293436C91B" || var_3 == "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421")
    var_8 = 1;

  self notify("_encstr_932D0C087BD23CA6CBBB553A4DE8", var_8, 1);
}

manualturret_modifydamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflags;
  var_6 = var_4;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A1F220D92BD1D4BD462D99B4B2910AE63A96D296D81BCDD1E42B16B58858B516ECB2"))
    var_6 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A1F220D92BD1D4BD462D99B4B2910AE63A96D296D81BCDD1E42B16B58858B516ECB2")]](var_1, var_2, var_3, var_6, self.maxhealth, 1, 1, 2, 7, 5);

  return var_6;
}

manualturret_disableplayerdismantleonconnect(var_0) {
  self endon("_encstr_932D0C087BD23CA6CBBB553A4DE8");
  self endon("_encstr_8C900F2EC6BB7DB8F51B79D8A71A139B03");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_1);
    var_1 waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");

    if(level.teambased) {
      if(var_1.team != var_0.team)
        continue;
    }

    self.dismantleobj disableplayeruse(var_1);
  }
}

manualturret_watchdeath(var_0) {
  self endon("_encstr_8C900F2EC6BB7DB8F51B79D8A71A139B03");
  self waittill("_encstr_932D0C087BD23CA6CBBB553A4DE8", var_1, var_2);
  self.usedropspawn = 1;

  if(isDefined(var_0)) {
    var_0.placedsentries[self.turrettype] = scripts\engine\utility::array_remove(var_0.placedsentries[self.turrettype], self);
    var_0 manualturret_setinactive(self);
    manualturret_disableenemyoutlines(var_0);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_841B100E39B49BA3A3B0B5B2A01B47D2DBDC"))
      var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_841B100E39B49BA3A3B0B5B2A01B47D2DBDC")]]("_encstr_880321D420686433C51D676F37C79AAE90098F8ED0623D2A10FB7F537795C30AC89103", var_0);

    self.streakinfo.onspray = istrue(var_2);
    var_0 scripts\cp_mp\utility\killstreak_utility::_id_12AA7(self.streakinfo);
  }

  if(isDefined(self._id_126E2))
    self._id_126E2 manualturret_endplayeruse(self);

  if(isDefined(self.useownerobj))
    self.useownerobj delete();

  if(isDefined(self.useotherobj))
    self.useotherobj delete();

  if(!istrue(var_1)) {
    self playSound("_encstr_ACB215AFFF55B3E84BB1C150DF9CAD986F9FA3737743FA");
    self setscriptablepartstate("_encstr_ABEF097343AB23ABD89446", "_encstr_AB0703DBB9");
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(2);
    self setscriptablepartstate("_encstr_860808CB78E2984063BA", "_encstr_813008928DA89D31A8CA");
  } else
    self setscriptablepartstate("_encstr_860808CB78E2984063BA", "_encstr_88B20850478F501332D3");

  self playSound("_encstr_9ACF13F5970FE2C913880BAFF84983BBEDA0786F75");

  if(isDefined(level.killstreakfinishusefunc))
    level thread[[level.killstreakfinishusefunc]](self.streakinfo);

  if(isDefined(self.killcament))
    self.killcament delete();

  if(isDefined(self.helperdrone_isbeingpingedbydrone))
    self.helperdrone_isbeingpingedbydrone delete();

  if(isDefined(self.minimapid)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_867712AA1378832BD004D25AA9BECB7C808B1924"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_867712AA1378832BD004D25AA9BECB7C808B1924")]](self.minimapid);

    self.minimapid = undefined;
  }

  wait 0.2;
  self delete();
}

_id_11ACE() {
  self endon("_encstr_932D0C087BD23CA6CBBB553A4DE8");
  self endon("_encstr_8C900F2EC6BB7DB8F51B79D8A71A139B03");
  level waittill("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_932D0C087BD23CA6CBBB553A4DE8", 0, 0);
}

manualturret_delayscriptabledelete() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(5);
  self delete();
}

manualturret_watchtimeout(var_0) {
  self endon("_encstr_932D0C087BD23CA6CBBB553A4DE8");
  self endon("_encstr_8C900F2EC6BB7DB8F51B79D8A71A139B03");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = self.timeout;

  if(!isDefined(self.timeelapsed))
    self.timeelapsed = 0;

  while(self.timeelapsed < var_1) {
    var_2 = (var_1 - self.timeelapsed) / var_1;
    var_2 = int(ceil(clamp(var_2, 0, 1) * 100));

    if(isDefined(self._id_126E2))
      self._id_126E2 setclientomnvar("_encstr_B42D181FA4C122A3EC31C0BB932B52E26F3B600BD68C2B3F4738", int(var_2));

    self.timeelapsed = self.timeelapsed + level.framedurationseconds;

    if(self.timeelapsed >= var_1 - 1.5 && !istrue(self._id_138E0))
      self._id_138E0 = 1;

    waitframe();
  }

  var_0 scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_A3C8091B70E9F7BDC09927" + self.streakinfo.streakname, 1);
  self notify("_encstr_932D0C087BD23CA6CBBB553A4DE8", 0, 0);
}

manualturret_watchammotracker(var_0) {
  self endon("_encstr_932D0C087BD23CA6CBBB553A4DE8");
  self endon("_encstr_8C900F2EC6BB7DB8F51B79D8A71A139B03");
  var_0 endon("_encstr_8C850F1558E1177B8BC8731AE08773EFB9");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = level.sentrysettings[self.turrettype];
  var_2 = weaponfiretime(var_1.weaponinfo);

  if(!isDefined(self.hideammoindex))
    self.hideammoindex = 1;

  while(var_0 isusingturret()) {
    while(var_0 attackButtonPressed()) {
      self.streakinfo.shots_fired++;
      self.ammocount--;
      var_0 setclientomnvar("_encstr_85AC1CF0D081B7D4BAAB277983AFCBFF5F6B9FDFE32F4DFFCB903E218045", self.ammocount);

      if(self.ammocount <= 12) {
        self setscriptablepartstate("_encstr_8D2E0B6828BD35066967B79F1F" + self.hideammoindex, "_encstr_AB0703DBB9", 0);
        self.hideammoindex++;
      }

      if(self.ammocount == 100)
        var_0 scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog(self.streakinfo.streakname + "_encstr_86B50A2EDDA77060C26F3B37");
      else if(self.ammocount <= 0) {
        var_0 scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog(self.streakinfo.streakname + "_encstr_8E1D098FF820B79E1BD042");
        self notify("_encstr_932D0C087BD23CA6CBBB553A4DE8", 0, 0);
        break;
      }

      wait(var_2);
    }

    waitframe();
  }
}

manualturret_watchdisown(var_0) {
  self endon("_encstr_932D0C087BD23CA6CBBB553A4DE8");
  self endon("_encstr_8C900F2EC6BB7DB8F51B79D8A71A139B03");
  var_0 thread manualturret_disownonaction(self, "_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 thread manualturret_disownonaction(self, "_encstr_81170C244F9CBDE72C01BB99A298");
  var_0 thread manualturret_disownonaction(self, "_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
}

manualturret_disownonaction(var_0, var_1) {
  var_0 endon("_encstr_932D0C087BD23CA6CBBB553A4DE8");
  self endon("_encstr_8C900F2EC6BB7DB8F51B79D8A71A139B03");
  self endon("_encstr_86361081EF7BF8E83607E9866BF518AEF263");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill(var_1);
  var_0 notify("_encstr_932D0C087BD23CA6CBBB553A4DE8", 0, 0);
  self notify("_encstr_86361081EF7BF8E83607E9866BF518AEF263");
}

manualturret_setturretmodel(var_0) {
  var_1 = undefined;

  if(var_0 == "_encstr_B8B00782A191CB07D9")
    var_1 = level.sentrysettings[self.turrettype].modelbaseground;
  else
    var_1 = level.sentrysettings[self.turrettype].modeldestroyedground;

  self setModel(var_1);
}

manualturret_makealltriggersusable(var_0) {
  if(!istrue(var_0)) {
    self.useownerobj makeunusable();
    self.useotherobj makeunusable();
  } else {
    self.useownerobj makeusable();
    self.useotherobj makeusable();
  }
}

_id_11ACC(var_0) {
  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    scripts\common\utility::allow_sprint(var_0);
    scripts\common\utility::allow_weapon_switch(var_0);
    scripts\common\utility::allow_offhand_weapons(var_0);
    scripts\common\utility::allow_melee(var_0);
    scripts\common\utility::allow_execution_attack(var_0);
    scripts\common\utility::allow_ladder_placement(var_0);
  }
}

_id_11ACD(var_0) {
  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    scripts\common\utility::allow_offhand_weapons(var_0);
    scripts\common\utility::allow_melee(var_0);
    scripts\common\utility::allow_supers(var_0);
    scripts\common\utility::allow_movement(var_0);
  }
}