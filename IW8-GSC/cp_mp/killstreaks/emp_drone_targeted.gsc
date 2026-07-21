/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\killstreaks\emp_drone_targeted.gsc
****************************************************/

init() {
  level._effect["_encstr_9BE247F45593188137313DB8FD4C853B28E3BF518763AD380643E723B948470B4005378C4DCDC7DB6FC26A781199AB4FCCD25040C29F43E2B03FD438D7A60A5DE76801BB101063D75A"] = loadfx("_encstr_9BE247F45593188137313DB8FD4C853B28E3BF518763AD380643E723B948470B4005378C4DCDC7DB6FC26A781199AB4FCCD25040C29F43E2B03FD438D7A60A5DE76801BB101063D75A");
  level._effect["_encstr_8EF1418C96D82732BC9BFF1DC06675B44688C70F35E25A83437FA796A3C3F966869B3024A8630395998AB8661F107507D13B70CDDDA90E3F48496298E86032C5F8D828"] = loadfx("_encstr_8EF1418C96D82732BC9BFF1DC06675B44688C70F35E25A83437FA796A3C3F966869B3024A8630395998AB8661F107507D13B70CDDDA90E3F48496298E86032C5F8D828");
  level._effect["_encstr_972741962D202D4F54F20EC2A12CB73542AF390EB3C845677E71066BE90327AA987DB598CF988AEF30097AF211510769C8FD2716632114D7C723115A78361B8DF04DB8"] = loadfx("_encstr_972741962D202D4F54F20EC2A12CB73542AF390EB3C845677E71066BE90327AA987DB598CF988AEF30097AF211510769C8FD2716632114D7C723115A78361B8DF04DB8");
  level._effect["_encstr_A9032D8DFBE3F0200778962892B7F81B7A7B3F01335AAF6867C3B98271B2C058138393AD0741EE80549D2350238ED0"] = loadfx("_encstr_A9032D8DFBE3F0200778962892B7F81B7A7B3F01335AAF6867C3B98271B2C058138393AD0741EE80549D2350238ED0");
  level._effect["_encstr_AB693454F7EB374817BAA920831723EB33DC60DC4F430F31E5B3A160E37F381349C74367E97A2B79DC1BC8B88F9A915932EA10EC3FF3"] = loadfx("_encstr_AB693454F7EB374817BAA920831723EB33DC60DC4F430F31E5B3A160E37F381349C74367E97A2B79DC1BC8B88F9A915932EA10EC3FF3");
  level._effect["_encstr_8C992967333CF25ABB83D7DAE0E51C59E45B79ECCCF0FA56DAE0EB199CEDE656F5584B39CAE107E2EC99C3"] = loadfx("_encstr_8C992967333CF25ABB83D7DAE0E51C59E45B79ECCCF0FA56DAE0EB199CEDE656F5584B39CAE107E2EC99C3");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8E1413A9D2C350D86A9F352B87D3C88E37CA03D12A", "_encstr_88C5055208731B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8E1413A9D2C350D86A9F352B87D3C88E37CA03D12A", "_encstr_88C5055208731B")]]();
}

empdrone_beginsuper() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_9196100D8D3E98E8CBF32008EAA790B8D7E4");
  self endon("_encstr_9969107307C2C01041C528880BE9703B35B3");
  thread empdrone_superusethink();
  return 1;
}

empdrone_superusethink() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("_encstr_8F2C0AB2DA1CD74639B7372B", self);
  var_1 = empdrone_tryuse(var_0);
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
  scripts\cp_mp\killstreaks\killstreakdeploy::ondeploystart(var_0);
  var_1 = getcompleteweaponname("_encstr_B42011379B76D2F27318ABE7680BCA981E68D3");
  var_2 = scripts\cp_mp\killstreaks\killstreakdeploy::waituntilfinishedwithdeployweapon;
  var_3 = ::empdrone_weapongiven;
  var_4 = scripts\cp_mp\killstreaks\killstreakdeploy::switchtodeployweapon(var_1, var_0, var_2, var_3);
  scripts\cp_mp\killstreaks\killstreakdeploy::ondeployfinished(var_0, istrue(var_4));

  if(!istrue(var_4))
    return 0;

  var_5 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_AAD211CADA1C8839B79BCA1558E4D9953A5932", "_encstr_B86B122720C9FFAA9C813F4CB0CF03D14F83D0DB"))
    var_5 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_AAD211CADA1C8839B79BCA1558E4D9953A5932", "_encstr_B86B122720C9FFAA9C813F4CB0CF03D14F83D0DB")]](var_0, 1);
  else
    return 0;

  if(!isDefined(var_5))
    return 0;

  thread empdrone_createdrone(var_0, var_5[0].location);
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
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_AAD211CADA1C8839B79BCA1558E4D9953A5932", "_encstr_933717DC8E0B93A39AB007A9561B596C8EA62BB8BAAC733656"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_AAD211CADA1C8839B79BCA1558E4D9953A5932", "_encstr_933717DC8E0B93A39AB007A9561B596C8EA62BB8BAAC733656")]](0, 0, undefined, 3);
  else
    return 0;

  return 1;
}

empdrone_createdrone(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = empdrone_calculatepositions(var_1);
  var_3 = scripts\cp_mp\utility\weapon_utility::_magicbullet(getcompleteweaponname("_encstr_842812CA5B38D73293B7B92BFA384EDE35F5ADE0"), var_2.startpos, var_2.targetpos, self);
  var_3 setentityowner(self);
  var_3.owner = self;
  var_3.ownerid = self getentitynumber();
  var_3.team = self.team;
  var_3.streakinfo = var_0;
  var_3.usedcount = 0;
  var_3.superid = level.superglobals.staticsuperdata["_encstr_995B109BAB0756E47DCA5B837D914EEDB995"].id;
  var_3 hidepart("_encstr_B63B0CD4FA839CDE38B2C61BCA9C");
  playFXOnTag(scripts\engine\utility::getfx("_encstr_9BE247F45593188137313DB8FD4C853B28E3BF518763AD380643E723B948470B4005378C4DCDC7DB6FC26A781199AB4FCCD25040C29F43E2B03FD438D7A60A5DE76801BB101063D75A"), var_3, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  playFXOnTag(scripts\engine\utility::getfx("_encstr_8EF1418C96D82732BC9BFF1DC06675B44688C70F35E25A83437FA796A3C3F966869B3024A8630395998AB8661F107507D13B70CDDDA90E3F48496298E86032C5F8D828"), var_3, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  playFXOnTag(scripts\engine\utility::getfx("_encstr_972741962D202D4F54F20EC2A12CB73542AF390EB3C845677E71066BE90327AA987DB598CF988AEF30097AF211510769C8FD2716632114D7C723115A78361B8DF04DB8"), var_3, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  playFXOnTag(scripts\engine\utility::getfx("_encstr_A9032D8DFBE3F0200778962892B7F81B7A7B3F01335AAF6867C3B98271B2C058138393AD0741EE80549D2350238ED0"), var_3, "_encstr_B63B0CD4FA839CDE38B2C61BCA9C");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_AAD211CADA1C8839B79BCA1558E4D9953A5932", "_encstr_93790EDAEDCDA5D1F6E4110BDA0B3B56"))
    var_3 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_AAD211CADA1C8839B79BCA1558E4D9953A5932", "_encstr_93790EDAEDCDA5D1F6E4110BDA0B3B56")]](25, "_encstr_A2FB098A2035874AB0F358", ::empdrone_handledeathdamage, undefined, 0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_921B1AD3D478AF17A073A49C55D25C7018C9524B4648513A43281F23"))
    var_3[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_921B1AD3D478AF17A073A49C55D25C7018C9524B4648513A43281F23")]](var_0.streakname, "_encstr_81860F1741A58ADBBB43D3B36C79AF3083", self, 0, 1, 25);

  var_3 playLoopSound("_encstr_836814BF0B282F8E4968C3DBA72863716FE01F844695");
  var_3 thread empdrone_timeoutthink();
  var_3 thread monitorweaponswitchbr();
  var_3 thread empdrone_collidethink();

  if(getdvarint("_encstr_994619202E4556BD78EB6C0530D0BFDFB333B8B147B38FDB6ABBAB", 0) == 0)
    var_3 thread empdrone_divebombthink(var_2);
  else
    var_3 thread morales_laptop_initted(var_2);

  var_3 scripts\cp_mp\emp_debuff::set_apply_emp_callback(::empdrone_empapplied);
  return var_3;
}

empdrone_calculatepositions(var_0) {
  var_1 = scripts\cp_mp\utility\killstreak_utility::removeextracthelipad();
  var_2 = (0, 0, 1500);

  if(isDefined(var_1)) {
    var_3 = var_1.origin[2] + -1500;
    var_2 = (0, 0, var_3);
  }

  var_4 = anglesToForward(self.angles);
  var_5 = undefined;
  var_6 = 0;
  var_7 = 0;
  var_8 = 0;

  for(;;) {
    var_9 = rotatevector(var_4, (0, var_7, 0));
    var_10 = var_2 + var_0;
    var_5 = var_10 - var_9 * 4500;
    var_11 = (0, 0, 1500);
    var_5 = var_5 + var_11;
    var_12 = physics_createcontents(["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_8DDD1C83862FCDA5D8DCD8ED371DCA73D16EAFB3AC34B46C8DB26C8D2D07", "_encstr_B8431C7754DBAF6823F728509B6CA1DDB33A7871EC93775004C72040AF80", "_encstr_BAC1197AA4A00BC432A281DA954387A2981390DFE5A0239BC8E8E4"]);
    var_6 = scripts\engine\trace::ray_trace_passed(var_5, var_10, undefined, var_12);
    var_8++;

    if(var_6) {
      break;
    }

    if(var_8 >= 13) {
      break;
    }

    wait 0.05;
    var_7 = var_7 + 55.3;
  }

  var_13 = vectorNormalize(var_5 - var_10) * 1000 + var_10;
  var_14 = spawnStruct();
  var_14.startpos = var_5;
  var_14.divebombpos = var_13;
  var_14.targetpos = var_0;
  return var_14;
}

empdrone_timeoutthink() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  var_0 = gettime() * 0.001;
  var_1 = var_0 + 20;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_1);
  thread empdrone_destroy();
}

monitorweaponswitchbr() {
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  level scripts\engine\utility::_id_143A5("_encstr_9B1D0BC7932875276230426AA1", "_encstr_AD9F1168238D48239B0EFB68667263B1FE57F0");
  thread empdrone_destroy();
}

empdrone_collidethink() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  self waittill("_encstr_8DE90E4D31C35370B84D709B4B6DEE42");
  thread empdrone_explode();
}

empdrone_divebombthink(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  self missile_settargetpos(var_0.divebombpos);
  var_1 = 50;

  while(distancesquared(var_0.divebombpos, self.origin) > var_1 * var_1)
    wait 0.05;

  var_2 = anglesToForward(self.angles);
  var_3 = distance(var_0.targetpos, self.origin);
  var_4 = self.origin + var_2 * var_3;
  var_5 = gettime();
  var_6 = 0;
  var_7 = 0;

  for(;;) {
    wait 0.05;
    var_6 = (gettime() - var_5) / 1300.0;
    var_6 = clamp(var_6, 0, 1);
    var_8 = var_4 * (1 - var_6) + var_0.targetpos * var_6;
    self missile_settargetpos(var_8);
  }
}

morales_laptop_initted(var_0) {}

empdrone_handledeathdamage(var_0, var_1, var_2) {
  empdrone_givepointsfordeath(var_0);
  empdrone_destroy();
}

empdrone_explode() {
  self playSound("_encstr_A5AD183A43B3CF2AA07FB8BC1B90B787B5D852A288E517275049");
  var_0 = anglesToForward(self.angles);
  playFX(scripts\engine\utility::getfx("_encstr_AB693454F7EB374817BAA920831723EB33DC60DC4F430F31E5B3A160E37F381349C74367E97A2B79DC1BC8B88F9A915932EA10EC3FF3"), self.origin, var_0);
  empdrone_explodeemp();
  empdrone_delete();
}

empdrone_destroy() {
  self playSound("_encstr_AF911315953690D073FB38CD92C79DA8CDE9B7A33C");
  var_0 = anglesToForward(self.angles);
  playFX(scripts\engine\utility::getfx("_encstr_8C992967333CF25ABB83D7DAE0E51C59E45B79ECCCF0FA56DAE0EB199CEDE656F5584B39CAE107E2EC99C3"), self.origin, var_0);
  empdrone_delete();
}

empdrone_delete() {
  self stoploopsound("_encstr_836814BF0B282F8E4968C3DBA72863716FE01F844695");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A5580B6C43B0B163CA9BB395CD", "_encstr_A18C12DEE6325A59B18C550EB393B032598ACDC8"))
    self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A5580B6C43B0B163CA9BB395CD", "_encstr_A18C12DEE6325A59B18C550EB393B032598ACDC8")]]("_encstr_995B109BAB0756E47DCA5B837D914EEDB995", self.usedcount);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8A6705191B7B76", "_encstr_8703140952578998E3C06745F997A8D58B5B60737A8B"))
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8A6705191B7B76", "_encstr_8703140952578998E3C06745F997A8D58B5B60737A8B")]](self.owner, self.superid, self.usedcount, 0);

  self delete();
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
  var_2 = [];
  var_3 = scripts\cp_mp\emp_debuff::get_emp_ents();

  foreach(var_5 in var_3) {
    if(var_5 == self) {
      continue;
    }
    var_6 = var_5.owner;

    if(isDefined(var_6)) {
      if(var_6 != self.owner && !scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_6))
        continue;
    }

    var_7 = distancesquared(self.origin, var_5.origin);

    if(var_7 > 640000) {
      continue;
    }
    var_8 = var_5 scripts\cp_mp\vehicles\vehicle::isvehicle();
    var_9 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_141DE(var_5);

    if(var_8 && var_9) {
      var_10 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var_5);

      foreach(var_12 in var_10)
      var_2[var_2.size] = var_12;
    }

    var_14 = scripts\engine\utility::ter_op(var_7 > 6400, var_0, var_1);
    var_5 dodamage(1, self.origin, self.owner, self, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", var_14);
    var_15 = scripts\cp_mp\utility\damage_utility::packdamagedata(self.owner, var_5, 1, var_14, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", self, self.origin);
    thread empdrone_applyemp(var_15);
  }

  var_17 = getcompleteweaponname("_encstr_81931411E5B039F5EB6F052B97F3C90B617F7BAE0D18");
  self radiusdamage(self.origin, 80, 120, 80, self.owner, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", var_17);
  var_18 = scripts\common\utility::playersinsphere(self.origin, 800);
  var_18 = scripts\engine\utility::array_combine_unique(var_18, var_2);

  foreach(var_20 in var_18) {
    if(!isDefined(var_20)) {
      continue;
    }
    if(!var_20 scripts\cp_mp\emp_debuff::can_emp_player()) {
      continue;
    }
    if(var_20 != self.owner && !scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_20)) {
      continue;
    }
    var_20 dodamage(1, self.origin, self.owner, self, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", var_17);
    var_15 = scripts\cp_mp\utility\damage_utility::packdamagedata(self.owner, var_20, 1, var_17, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", self, self.origin);
    thread empdrone_applyemp(var_15);
  }

  var_22 = scripts\common\utility::playersinsphere(self.origin, 2000);
  var_22 = scripts\engine\utility::array_combine_unique(var_22, var_2);

  foreach(var_20 in var_22) {
    if(!isDefined(var_20)) {
      continue;
    }
    if(var_20 == self.owner) {
      continue;
    }
    var_20 earthquakeforplayer(0.3, 1, self.origin, 2000);
    var_20 setclientomnvar("_encstr_BA2A0D5D4BD743AE32EB6E340BB559", 1);
    var_20 playrumbleonpositionforclient("_encstr_97B91727302BC16A69052298603DB39DB1688F57586007F261", self.origin);
  }

  self.owner earthquakeforplayer(0.2, 1, self.owner.origin, 2000);
  self.owner setclientomnvar("_encstr_BA2A0D5D4BD743AE32EB6E340BB559", 1);
  self.owner playrumbleonpositionforclient("_encstr_97B91727302BC16A69052298603DB39DB1688F57586007F261", self.origin);
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

    if(isDefined(var_0.attacker))
      var_0.attacker scripts\cp\vehicles\vehicle_compass_cp::_id_12021(var_0.victim);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_AC0D05331DCB3B", "_encstr_8D310C2D73B14156E46EA93AB08E"))
    self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_AC0D05331DCB3B", "_encstr_8D310C2D73B14156E46EA93AB08E")]]("_encstr_AF9E0D1F713079F33FEAF51188389A", 1);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BEF4071AA87BDF5220", "_encstr_826B166310C589B9786A118FF71BCF8363A012FA706B1B0A"))
    self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BEF4071AA87BDF5220", "_encstr_826B166310C589B9786A118FF71BCF8363A012FA706B1B0A")]]("_encstr_995B109BAB0756E47DCA5B837D914EEDB995");

  self.usedcount++;
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