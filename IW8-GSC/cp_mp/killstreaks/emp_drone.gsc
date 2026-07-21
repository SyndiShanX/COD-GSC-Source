/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\killstreaks\emp_drone.gsc
***********************************************/

init() {
  level._effects["_encstr_AB693454F7EB374817BAA920831723EB33DC60DC4F430F31E5B3A160E37F381349C74367E97A2B79DC1BC8B88F9A915932EA10EC3FF3"] = loadfx("_encstr_AB693454F7EB374817BAA920831723EB33DC60DC4F430F31E5B3A160E37F381349C74367E97A2B79DC1BC8B88F9A915932EA10EC3FF3");
  level._effects["_encstr_8C992967333CF25ABB83D7DAE0E51C59E45B79ECCCF0FA56DAE0EB199CEDE656F5584B39CAE107E2EC99C3"] = loadfx("_encstr_8C992967333CF25ABB83D7DAE0E51C59E45B79ECCCF0FA56DAE0EB199CEDE656F5584B39CAE107E2EC99C3");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8F2C0AB2DA1CD74639B7372B", "_encstr_88C5055208731B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8F2C0AB2DA1CD74639B7372B", "_encstr_88C5055208731B")]]();
}

empdrone_beginsuper() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_9196100D8D3E98E8CBF32008EAA790B8D7E4");
  self endon("_encstr_9969107307C2C01041C528880BE9703B35B3");

  if(!scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle())
    return 0;

  thread empdrone_superusethink();
  return 1;
}

empdrone_superusethink() {
  var_0 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("_encstr_8F2C0AB2DA1CD74639B7372B", self);
  var_1 = empdrone_tryuse(var_0);

  if(!var_1)
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();

  wait 0.05;

  if(var_1) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BEF4071AA87BDF5220", "_encstr_ABA011C3FB6B1530CBEB5B05E9ED20E6F312B9"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BEF4071AA87BDF5220", "_encstr_ABA011C3FB6B1530CBEB5B05E9ED20E6F312B9")]]();

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8260069BDBBACD46", "_encstr_8E8311D9FBA39E303955A0390604E9C8DB2361"))
      level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8260069BDBBACD46", "_encstr_8E8311D9FBA39E303955A0390604E9C8DB2361")]](self, "_encstr_A51D0E77F3E57F0AA5D86F85E2D5B5C5");
  } else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BEF4071AA87BDF5220", "_encstr_ABA011C3FB6B1530CBEB5B05E9ED20E6F312B9"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BEF4071AA87BDF5220", "_encstr_ABA011C3FB6B1530CBEB5B05E9ED20E6F312B9")]](1);
}

empdrone_tryuse(var_0) {
  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var_0))
      return 0;
  }

  var_1 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweapontabletdeploy(var_0, ::empdrone_weapongiven);

  if(!istrue(var_1))
    return 0;

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var_0))
      return 0;
  }

  thread empdrone_rundrone(var_0);
  return 1;
}

empdrone_equipment_wrapper(var_0, var_1, var_2) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BE8F0A272F9B2BE97268AE8B", "_encstr_8E180EA47FA05F97231022ABC8531553"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BE8F0A272F9B2BE97268AE8B", "_encstr_8E180EA47FA05F97231022ABC8531553")]](var_1);

  var_3 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("_encstr_8F2C0AB2DA1CD74639B7372B", self);
  var_4 = empdrone_tryuse(var_3);

  if(!var_4) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BE8F0A272F9B2BE97268AE8B", "_encstr_8D400E8C645BF39D41FF6898A76D3019"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BE8F0A272F9B2BE97268AE8B", "_encstr_8D400E8C645BF39D41FF6898A76D3019")]]("_encstr_A6330FC0FBB323FB8765B1377CEBC0E51F", var_1);
  }
}

empdrone_weapongiven(var_0) {
  return 1;
}

empdrone_rundrone(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self disablephysicaldepthoffieldscripting();
  scripts\common\utility::allow_fire(0);
  scripts\common\utility::allow_melee(0);
  scripts\common\utility::allow_weapon_switch(0);
  scripts\common\utility::allow_usability(0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_964E0DB08D63B7BB742BE61DD59C56"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_964E0DB08D63B7BB742BE61DD59C56")]](0);

  var_1 = empdrone_createdrone(var_0);
  var_1.iscontrolled = 1;
  var_1.usedcount = 0;
  var_1.superid = level.superglobals.staticsuperdata["_encstr_995B109BAB0756E47DCA5B837D914EEDB995"].id;
  self controlslinkTo(var_1);
  self cameralinkTo(var_1, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  self setplayerangles(var_1.angles);
  self painvisionoff();
  scripts\cp_mp\utility\killstreak_utility::killstreak_savenvgstate();
  self setclientomnvar("_encstr_AA89151DFC516B30E8EFA810C71EC9E7BAA39D2615EA1B", 1);
}

empdrone_createdrone(var_0) {
  var_1 = empdrone_findstartposition();
  var_2 = vectortoangles(var_1.targetpos - var_1.startpos);
  scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
  var_3 = spawnStruct();
  var_3.origin = var_1.startpos;
  var_3.angles = var_2;
  var_3.modelname = "_encstr_8E3A1BFD7514CAA8A71A7906F27FF6392EC7434D11FD6890BB3310289A";
  var_3.vehicletype = "_encstr_99941336D60BD1296E6F096843A1A313827A38316A";
  var_3.targetname = "_encstr_9B47087BFE3354A92D42";
  var_3.cannotbesuspended = 1;
  var_4 = spawnStruct();
  var_5 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var_3, var_4);

  if(!isDefined(var_5)) {
    return;
  }
  var_5 setotherent(self);
  var_5 setentityowner(self);
  var_5.owner = self;
  var_5.ownerid = self getentitynumber();
  var_5.team = self.team;
  var_5.streakinfo = var_0;
  var_5 setCanDamage(1);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A76B16AD2D1B366EE8279558AD6A586D2B65B24396368D2B"))
    var_5[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A76B16AD2D1B366EE8279558AD6A586D2B65B24396368D2B")]](var_0.streakname);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_BA2C22DA4B1B636E3A4EACB05BA959D1824EAC35DE3211C2ADC2ECB2A1161BD83116D8AD"))
    var_5[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_BA2C22DA4B1B636E3A4EACB05BA959D1824EAC35DE3211C2ADC2ECB2A1161BD83116D8AD")]](var_0.streakname);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_8B8E23648C086413B108EF30B3A2C961BF8722F3617FE2ECDF5B3AC730C7790D109589A9B8"))
    var_5[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_8B8E23648C086413B108EF30B3A2C961BF8722F3617FE2ECDF5B3AC730C7790D109589A9B8")]](var_0.streakname);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_88C31B72E8F17B12703D858927615FC33D812A0B50CE078DC805B993DF"))
    var_5[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_88C31B72E8F17B12703D858927615FC33D812A0B50CE078DC805B993DF")]](var_0.streakname, ::empdrone_handledeathdamage);

  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance(var_5, var_5.vehiclename);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_921B1AD3D478AF17A073A49C55D25C7018C9524B4648513A43281F23"))
    var_5[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_921B1AD3D478AF17A073A49C55D25C7018C9524B4648513A43281F23")]](var_0.streakname, "_encstr_81860F1741A58ADBBB43D3B36C79AF3083", self, 0, 1, 25);

  self notifyonplayercommand("_encstr_95B5131F1A41293BD62D75CF50947090E898F3635B", "_encstr_A9E60828803C73F11780");
  var_5 playLoopSound("_encstr_836814BF0B282F8E4968C3DBA72863716FE01F844695");
  var_5 thread empdrone_timeoutthink();
  var_5 thread empdrone_collidethink();
  var_5 thread empdrone_watchearlyexit();
  var_5 thread empdrone_watchdetonate();
  var_5 scripts\cp_mp\emp_debuff::set_apply_emp_callback(::empdrone_empapplied);
  return var_5;
}

empdrone_findstartposition() {
  var_0 = scripts\cp_mp\utility\killstreak_utility::removeextracthelipad();
  var_1 = (0, 0, 600);

  if(isDefined(var_0)) {
    var_2 = var_0.origin[2] + -100;
    var_1 = (0, 0, var_2);
  }

  var_3 = anglesToForward(self.angles);
  var_4 = var_1 + self.origin;
  var_5 = var_4 - var_3 * 4000;
  var_6 = var_4;
  var_7 = spawnStruct();
  var_7.startpos = var_5;
  var_7.targetpos = var_6;
  return var_7;
}

empdrone_timeoutthink() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  var_0 = 20;

  while(var_0 > 0) {
    self.owner setclientomnvar("_encstr_B42D181FA4C122A3EC31C0BB932B52E26F3B600BD68C2B3F4738", gettime() + int(var_0 * 1000));
    var_0 = var_0 - 0.05;
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.05);
  }

  thread empdrone_destroy();
}

empdrone_collidethink() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  self vehphys_enablecollisioncallback(1);
  self waittill("_encstr_93510A16C71B20636A2AB8B8", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
  thread empdrone_explode();
}

empdrone_watchdetonate() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_88F611F7438B194B4B6F889AF045C340C13991");
  self.owner waittill("_encstr_95B5131F1A41293BD62D75CF50947090E898F3635B");
  thread empdrone_explode();
}

empdrone_watchearlyexit() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_88F611F7438B194B4B6F889AF045C340C13991");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_99CC1EFA6008DF6BF748AF2BD457D995CE05C3E9AA98AB22E88B217B088B128B"))
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_99CC1EFA6008DF6BF748AF2BD457D995CE05C3E9AA98AB22E88B217B088B128B")]]("_encstr_AD75063D571AE108");

  self waittill("_encstr_A2DA0F6DD2B136CDD1275958B5A8E1D2A3");
  self setotherent(undefined);
  self setentityowner(undefined);
  thread empdrone_exit();
}

empdrone_handledeathdamage(var_0) {
  var_1 = var_0.attacker;
  empdrone_givepointsfordeath(var_1);
  empdrone_destroy();
}

empdrone_explode() {
  self playSound("_encstr_A5AD183A43B3CF2AA07FB8BC1B90B787B5D852A288E517275049");
  var_0 = anglesToForward(self.angles);
  playFX(level._effects["_encstr_AB693454F7EB374817BAA920831723EB33DC60DC4F430F31E5B3A160E37F381349C74367E97A2B79DC1BC8B88F9A915932EA10EC3FF3"], self.origin, var_0);
  empdrone_explodeemp();
  empdrone_delete();
}

empdrone_destroy() {
  self playSound("_encstr_AF911315953690D073FB38CD92C79DA8CDE9B7A33C");
  var_0 = anglesToForward(self.angles);
  playFX(level._effects["_encstr_8C992967333CF25ABB83D7DAE0E51C59E45B79ECCCF0FA56DAE0EB199CEDE656F5584B39CAE107E2EC99C3"], self.origin, var_0);
  empdrone_delete();
}

empdrone_exit() {
  self.owner empdrone_returnplayer(self);
}

empdrone_delete() {
  self.owner empdrone_returnplayer(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8A6705191B7B76", "_encstr_8703140952578998E3C06745F997A8D58B5B60737A8B"))
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8A6705191B7B76", "_encstr_8703140952578998E3C06745F997A8D58B5B60737A8B")]](self.owner, self.superid, self.usedcount, 0);

  self stoploopsound("_encstr_836814BF0B282F8E4968C3DBA72863716FE01F844695");
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_deregisterinstance(self);
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}

empdrone_returnplayer(var_0) {
  if(!istrue(var_0.iscontrolled)) {
    return;
  }
  if(isDefined(level.killstreakfinishusefunc))
    level thread[[level.killstreakfinishusefunc]](var_0.streakinfo);

  self painvisionon();
  scripts\cp_mp\utility\killstreak_utility::killstreak_restorenvgstate();
  self controlsunlink();
  self cameraunlink(var_0);
  empdrone_clearomnvars();
  scripts\common\utility::allow_fire(1);
  scripts\common\utility::allow_melee(1);
  scripts\common\utility::allow_weapon_switch(1);
  scripts\common\utility::allow_usability(1);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_964E0DB08D63B7BB742BE61DD59C56"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_964E0DB08D63B7BB742BE61DD59C56")]](1);

  var_0 stoploopsound("_encstr_836814BF0B282F8E4968C3DBA72863716FE01F844695");
  self notifyonplayercommandremove("_encstr_95B5131F1A41293BD62D75CF50947090E898F3635B", "_encstr_9B0D065699E485D9");
  var_0.iscontrolled = undefined;
  var_0.streakinfo notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
  var_0 notify("_encstr_88F611F7438B194B4B6F889AF045C340C13991");
}

empdrone_clearomnvars() {
  self setclientomnvar("_encstr_AA89151DFC516B30E8EFA810C71EC9E7BAA39D2615EA1B", 0);
}

empdrone_empapplied(var_0) {
  var_1 = var_0.attacker;
  empdrone_givepointsfordeath(var_1);
  empdrone_destroy();
}

empdrone_givepointsfordeath(var_0) {
  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_0))) {
    var_0 notify("_encstr_85BB142A408F7BABB0EB352C9099EF43C38022B2A029");

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_AA8E12846C53FB87468728589F64FF374A558516"))
      var_0 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_AA8E12846C53FB87468728589F64FF374A558516")]]("_encstr_85BB142A408F7BABB0EB352C9099EF43C38022B2A029");
  }
}

empdrone_explodeemp() {
  var_0 = getcompleteweaponname("_encstr_AB64181DDD735E712232B8F8297D2F307768118731CF233FCDAB");
  var_1 = getcompleteweaponname("_encstr_A90D1FCAAD38AF1927B7B92B7DB9DEE67D0E63C22FB239D7465A93561B3AEBD60E");
  var_2 = scripts\cp_mp\emp_debuff::get_emp_ents();

  foreach(var_4 in var_2) {
    if(var_4 == self) {
      continue;
    }
    var_5 = var_4.owner;

    if(isDefined(var_5)) {
      if(var_5 != self.owner && !scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_5))
        continue;
    }

    var_6 = distancesquared(self.origin, var_4.origin);

    if(var_6 > 589824) {
      continue;
    }
    var_7 = scripts\engine\utility::ter_op(var_6 > 4096, var_0, var_1);
    var_4 dodamage(1, self.origin, self.owner, self, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", var_7);
    var_8 = scripts\cp_mp\utility\damage_utility::packdamagedata(self.owner, var_4, 1, var_7, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", self, self.origin);
    thread empdrone_applyemp(var_8);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_AC0D05331DCB3B", "_encstr_8D310C2D73B14156E46EA93AB08E"))
      self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_AC0D05331DCB3B", "_encstr_8D310C2D73B14156E46EA93AB08E")]]("_encstr_AF9E0D1F713079F33FEAF51188389A", 1);

    self.usedcount++;
  }

  var_10 = getcompleteweaponname("_encstr_81931411E5B039F5EB6F052B97F3C90B617F7BAE0D18");
  radiusdamage(self.origin, 64, 60, 1, self.owner, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", var_10);
  var_11 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_AAC0133C589B026BE92A5D0A9BF4B6AA4FC4B48B53"))
    var_11 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_AAC0133C589B026BE92A5D0A9BF4B6AA4FC4B48B53")]](self.origin, 768);

  foreach(var_13 in var_11) {
    if(!var_13 scripts\cp_mp\emp_debuff::can_emp_player()) {
      continue;
    }
    if(var_13 != self.owner && !scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_13)) {
      continue;
    }
    var_13 dodamage(1, self.origin, self.owner, self, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", var_10);
    var_8 = scripts\cp_mp\utility\damage_utility::packdamagedata(self.owner, var_13, 1, var_10, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", self, self.origin);
    thread empdrone_applyemp(var_8);
  }
}

empdrone_applyemp(var_0) {
  scripts\cp_mp\emp_debuff::apply_emp_struct(var_0);
  var_1 = 8;

  if(isPlayer(var_0.victim)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")) {
      if(var_0.victim != self.owner && var_0.victim[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")]]("_encstr_9733153383D563C1D1CA237FE6259ACFE7E085E20FEE93")) {
        var_1 = 2;

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B2BE0788BAF573592F", "_encstr_B8BD15933BAB8790776CE3C371DFD0CC778249F9B21FCA"))
          self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B2BE0788BAF573592F", "_encstr_B8BD15933BAB8790776CE3C371DFD0CC778249F9B21FCA")]]("_encstr_8D760DB8F77343CF62BEB7E3D01013");
      }
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A7220A9F3B90A7CFB6E0334A", "_encstr_869E12CD6AE23780AC77C87853A69D4FABD4C655"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A7220A9F3B90A7CFB6E0334A", "_encstr_869E12CD6AE23780AC77C87853A69D4FABD4C655")]](var_0.attacker, var_0.victim, var_0.objweapon.basename);
  }

  empdrone_empendearly(var_0, var_1);

  if(isDefined(var_0.victim)) {
    var_0.victim scripts\cp_mp\emp_debuff::remove_emp();

    if(isDefined(var_0.attacker) && isPlayer(var_0.victim)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A7220A9F3B90A7CFB6E0334A", "_encstr_A50414ABE6E893858D5B885613D59999A0E69B2DCDD1"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A7220A9F3B90A7CFB6E0334A", "_encstr_A50414ABE6E893858D5B885613D59999A0E69B2DCDD1")]](var_0.attacker, var_0.victim, var_0.objweapon.basename);
    }
  }
}

empdrone_empendearly(var_0, var_1) {
  var_0.victim endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = scripts\engine\utility::waittill_notify_or_timeout_return("_encstr_99C40CA749E1F16B80389FEB2BB9", var_1);

  if(var_2 != "_encstr_99C40CA749E1F16B80389FEB2BB9")
    var_0.empremoved = 1;
}