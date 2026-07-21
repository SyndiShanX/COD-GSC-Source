/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\gestures.gsc
***********************************************/

init() {
  level.gestureinfo = [];
  level.gestureinfobyindex = [];
  level.predictandclearintermissionstreaming = [];
  var_0 = 0;

  for(;;) {
    var_1 = tablelookupbyrow("_encstr_8AE414B5385EEC59CD47D5C9CAD1B0261BB2C58DE69D", var_0, 0);

    if(!isDefined(var_1) || var_1 == "_encstr_B40101") {
      break;
    }

    var_2 = tablelookupbyrow("_encstr_8AE414B5385EEC59CD47D5C9CAD1B0261BB2C58DE69D", var_0, 1);

    if(!isDefined(var_2) || var_2 == "_encstr_B40101") {
      break;
    }

    var_3 = int(tablelookupbyrow("_encstr_8AE414B5385EEC59CD47D5C9CAD1B0261BB2C58DE69D", var_0, 8));

    if(isDefined(var_3))
      level.gestureinfobyindex[var_3] = var_2;

    var_4 = tablelookupbyrow("_encstr_8AE414B5385EEC59CD47D5C9CAD1B0261BB2C58DE69D", var_0, 15);

    if(isDefined(var_3) && isDefined(var_4) && var_4 != "_encstr_B40101")
      level.predictandclearintermissionstreaming[var_3] = var_4;

    level.gestureinfo[var_1] = var_2;
    var_0++;
  }

  level.rockpaperscissors = ["_encstr_972A14B356B97D83D8F293AFD9AC9B8ED53995060D99", "_encstr_822A14BC75DFFEF905B3B8C94A1FB7D3BF0A350F996A", "_encstr_922A1417BD0A29F77B53F35EDA372E282302AB337163"];
}

getgesturedata(var_0) {
  if(isbot(self) && var_0 == "_encstr_8E550E681AD383D8FB0F5E580BFF2079")
    var_0 = "_encstr_A6A50BECB29BA3EA932B060372";

  return level.gestureinfo[var_0];
}

getgesturedatabyindex(var_0) {
  return level.gestureinfobyindex[var_0];
}

remapobjkeysandscriptlabels(var_0) {
  return level.predictandclearintermissionstreaming[var_0];
}

cleargesture() {
  self notify("_encstr_88250D99EC830BAEC759F6517B3B41");

  if(isDefined(self.gestureweapon) && self.gestureweapon != "_encstr_8BBA05185F8B99") {
    if(scripts\engine\utility::is_player_gamepad_enabled())
      self setactionslot(1, "_encstr_B40101");
    else
      self setactionslot(7, "_encstr_B40101");

    if(self hasweapon(self.gestureweapon))
      scripts\cp_mp\utility\inventory_utility::_takeweapon(self.gestureweapon);

    self.gestureweapon = "_encstr_8BBA05185F8B99";
  }
}

givegesture(var_0) {
  if(scripts\engine\utility::is_player_gamepad_enabled())
    self setactionslot(1, "_encstr_AD2906FBFA7593E3");
  else
    self setactionslot(7, "_encstr_AD2906FBFA7593E3");

  scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0);
  self assignweaponoffhandtaunt(var_0);
  self.gestureweapon = var_0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_9579102CD3372F4A305BB75B9720F9AB50F0")) {
    if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_9579102CD3372F4A305BB75B9720F9AB50F0")]]()) {
      switch (var_0) {
        case "_encstr_972A14B356B97D83D8F293AFD9AC9B8ED53995060D99":
          thread gesture_rockpaperscissorsthink();
          var_0 = gesture_pickrockpaperscissors();
          break;
        case "_encstr_952A14EC076BE75B3CAFD0C1AF4D73F9536A55CF8BB7":
          var_1 = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), "_encstr_952A14EC076BE75B3CAFD0C1AF4D73F9536A55CF8BB7", "_encstr_B12A1480EA627FCB7BA9EE708F6793E14B0318C207EA");
          thread gesture_coinflipthink(var_1);
          var_0 = var_1;
          break;
      }

      if(!self isconsoleplayer())
        thread monitorgamepadswitch();

      thread gesture_manage3rdperson();
    }
  }
}

monitorgamepadswitch() {
  self endon("_encstr_88250D99EC830BAEC759F6517B3B41");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 = scripts\engine\utility::is_player_gamepad_enabled();

  for(;;) {
    if(isDefined(self.disabledgesture) && self.disabledgesture > 0) {
      waitframe();
      continue;
    }

    var_1 = scripts\engine\utility::is_player_gamepad_enabled();

    if(var_1 != var_0) {
      if(var_0) {
        self setactionslot(1, "_encstr_B40101");
        self setactionslot(7, "_encstr_AD2906FBFA7593E3");
      } else {
        self setactionslot(1, "_encstr_AD2906FBFA7593E3");
        self setactionslot(7, "_encstr_B40101");
      }
    }

    var_0 = var_1;
    waitframe();
  }
}

gesture_manage3rdperson() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;)
    self waittill("_encstr_883711F0997028D145335138C3FA58461872C3", var_0);
}

gesture_pickrockpaperscissors() {
  return level.rockpaperscissors[randomintrange(0, level.rockpaperscissors.size)];
}

gesture_rockpaperscissorsthink() {
  self endon("_encstr_88250D99EC830BAEC759F6517B3B41");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_97FA219DB26EA3ABE42BBE93BDB1DA05581C5639D4B14B9BB9DE27B95186B473DA0A92");
  self endon("_encstr_97FA219DB26EA3ABE42BBE93BDB1DA05581C5639D4B14B9BB9DE27B95186B473DA0A92");

  for(;;) {
    self waittill("_encstr_BA88163DABC5ED6F9A72AADB299B2936C1C745CF3D3B8BB0");
    var_0 = undefined;

    if(scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B") && getdvarint("_encstr_A6B20D0E80BB89AD40A7ECF92AB988", 0) == 0) {
      self[[level.showerrormessagefunc]]("_encstr_A5BA1C9D9797C90560E9E55D6F2FD8C5864EDB09416F5947C0D751710CED");
      var_0 = 0;
    } else {
      self[[level.showerrormessagefunc]]("_encstr_8A1C19782917F49B7537DDCDD09C534DE33A112189BF3A8BED86CC");
      var_0 = 1;
    }

    self waittill("_encstr_A2600E386AB2399AF3D9B99FA3BDBAA0");

    if(var_0)
      thread gesture_playrockpaperscissors();

    self waittill("_encstr_9A630C851C886BC33D8221E3EEB1");
    thread gesture_resetrockpaperscissorsgesture();
  }
}

gesture_resetrockpaperscissorsgesture() {
  cleargesture();
  givegesture("_encstr_972A14B356B97D83D8F293AFD9AC9B8ED53995060D99");
}

gesture_playrockpaperscissors() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8B761A7BED5B6017528B9BBD2F5AC318E345E3D35F8980B32B9383A9");
  self notify("_encstr_8815200FB8FBECCB451579AA890B43B2EDE0A75B20333543DF3EFC626E2F2B5B402A");
  self endon("_encstr_8815200FB8FBECCB451579AA890B43B2EDE0A75B20333543DF3EFC626E2F2B5B402A");
  var_0 = gesture_getrockpaperscissorsplayers();

  if(isDefined(var_0)) {
    var_1 = gesture_determinerockpaperscissorswinner(self, self.gestureweapon, var_0, var_0.rockpaperscissorschoice);

    if(isDefined(var_1)) {
      var_1[[level.showerrormessagefunc]]("_encstr_BDF517A877D0A715B113D5E517C92DFB7BE5D1017F88671C11");
      var_1 thread[[level.givemidmatchawardfunc]]("_encstr_97C318BEE707E02F8A8A208093692FB9478346B852FFAEB73462");
      var_2 = scripts\engine\utility::ter_op(var_1 == self, var_0, self);
      var_2[[level.showerrormessagefunc]]("_encstr_BAEE1851A887D49DD7187931D1FDA5CC374F4657C3DF3C570AA0");
    } else {
      self[[level.showerrormessagefunc]]("_encstr_A33018315989F3AC7731D1DDD7AF5431E0364161C1D19167470F");
      var_0[[level.showerrormessagefunc]]("_encstr_A33018315989F3AC7731D1DDD7AF5431E0364161C1D19167470F");
    }

    var_0 notify("_encstr_8B761A7BED5B6017528B9BBD2F5AC318E345E3D35F8980B32B9383A9");
    var_0.rockpaperscissorschoice = undefined;
    return;
  }

  self.rockpaperscissorschoice = self.gestureweapon;
  wait 3;
  self.rockpaperscissorschoice = undefined;
}

gesture_getrockpaperscissorsplayers() {
  var_0 = anglesToForward(self getplayerangles());
  var_1 = scripts\common\utility::playersinsphere(self.origin, 500);

  foreach(var_3 in var_1) {
    if(!isDefined(var_3) || var_3 == self) {
      continue;
    }
    if(!isDefined(var_3.rockpaperscissorschoice)) {
      continue;
    }
    var_4 = var_3.origin - self.origin;
    var_4 = vectorNormalize(var_4);
    var_5 = vectordot(var_4, var_0);

    if(var_5 < 0.707107) {
      continue;
    }
    var_6 = anglesToForward(var_3 getplayerangles());
    var_7 = var_4 * -1;
    var_8 = vectordot(var_7, var_6);

    if(var_8 < 0.707107) {
      continue;
    }
    return var_3;
  }
}

gesture_determinerockpaperscissorswinner(var_0, var_1, var_2, var_3) {
  if(var_1 == var_3)
    return undefined;

  switch (var_1) {
    case "_encstr_972A14B356B97D83D8F293AFD9AC9B8ED53995060D99":
      return scripts\engine\utility::ter_op(var_3 == "_encstr_822A14BC75DFFEF905B3B8C94A1FB7D3BF0A350F996A", var_2, var_0);
    case "_encstr_822A14BC75DFFEF905B3B8C94A1FB7D3BF0A350F996A":
      return scripts\engine\utility::ter_op(var_3 == "_encstr_922A1417BD0A29F77B53F35EDA372E282302AB337163", var_2, var_0);
    case "_encstr_922A1417BD0A29F77B53F35EDA372E282302AB337163":
      return scripts\engine\utility::ter_op(var_3 == "_encstr_972A14B356B97D83D8F293AFD9AC9B8ED53995060D99", var_2, var_0);
  }
}

gesture_coinflipthink(var_0) {
  self endon("_encstr_88250D99EC830BAEC759F6517B3B41");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_91C118C8A22A1153CB6DA0A64F8FF8CD55CAE8D90AC46DA87AD9");
  self endon("_encstr_91C118C8A22A1153CB6DA0A64F8FF8CD55CAE8D90AC46DA87AD9");

  for(;;) {
    self waittill("_encstr_BA88163DABC5ED6F9A72AADB299B2936C1C745CF3D3B8BB0");

    for(;;) {
      if(!self isgestureplaying(var_0)) {
        break;
      }

      waitframe();
    }

    thread gesture_resetcoinflipgesture();
  }
}

gesture_resetcoinflipgesture() {
  cleargesture();
  givegesture("_encstr_952A14EC076BE75B3CAFD0C1AF4D73F9536A55CF8BB7");
}

getbodymodel() {
  if(!isPlayer(self) || isai(self))
    return undefined;

  var_0 = self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_AD9B0589ED9197");
  return tablelookupbyrow("_encstr_8EB912CDAFC7AAC1C9D23B07E0E0BDD3AD4ED283", var_0, 1);
}

haschangedarchetype() {
  if(isDefined(self.changedarchetypeinfo)) {
    if(!isDefined(self.lastarchetypeinfo))
      return 1;

    if(self.changedarchetypeinfo != self.lastarchetypeinfo)
      return 1;
  }

  return 0;
}

monitorcontextualcallout() {
  if(isai(self)) {
    return;
  }
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8B3515BBB85EF77BD9953B871B23F01DAC51A207C98881");
  self notify("_encstr_AFA31209502B33E8D8739BB71DCB4B20F39FD783");
  self endon("_encstr_AFA31209502B33E8D8739BB71DCB4B20F39FD783");

  if(scripts\engine\utility::is_player_gamepad_enabled())
    self notifyonplayercommand("_encstr_8ABF10CA6989534CC8989087CD7BA3979ABF", "_encstr_AF5C0E59B08DA32D7B7337D8ED3A1098");
  else
    self notifyonplayercommand("_encstr_8ABF10CA6989534CC8989087CD7BA3979ABF", "_encstr_A55C0EAAE22E11D0BF66B6214FFB312F");

  waitframe();
  cleargesture();

  for(;;) {
    self waittill("_encstr_8ABF10CA6989534CC8989087CD7BA3979ABF");
    processcontext();
  }
}

processcontext() {
  var_0 = self getEye();
  var_1 = self getplayerangles();
  var_2 = anglesToForward(var_1);
  var_3 = cos(10);
  var_4 = undefined;
  var_5 = undefined;
  var_6 = [];

  if(isDefined(self.engstructks)) {
    foreach(var_8 in self.engstructks.outlinedents)
    var_6[var_6.size] = var_8;
  }

  if(isDefined(self.locationmarking_structveh)) {
    foreach(var_8 in self.locationmarking_structveh.outlinedents)
    var_6[var_6.size] = var_8;
  }

  if(isDefined(self.locationmarking_structeqp)) {
    foreach(var_8 in self.locationmarking_structeqp.outlinedents)
    var_6[var_6.size] = var_8;
  }

  foreach(var_8 in var_6) {
    var_15 = vectordot(var_2, vectorNormalize(var_8.origin - var_0));

    if(!isDefined(var_4) || var_4 < var_15) {
      var_4 = var_15;
      var_5 = var_8;
    }
  }

  if(isDefined(var_5) && var_4 > var_3) {
    if(isDefined(var_5.vehicle))
      var_5 = var_5.vehicle;

    thread applyoutlinecalloutsource(var_5);
  } else {
    if(isDefined(level.gamemodegesturecalloutassign) && self thread[[level.gamemodegesturecalloutassign]]()) {
      return;
    }
    var_17 = ["_encstr_BAC1197AA4A00BC432A281DA954387A2981390DFE5A0239BC8E8E4", "_encstr_B8431C7754DBAF6823F728509B6CA1DDB33A7871EC93775004C72040AF80", "_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA", "_encstr_925717EBF99B13491B7BD6DD30508D3AF527CF6349CFFB3DD0", "_encstr_B2741680E3403FEBF1A319E7C24393FD73AB51792F157763", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_A60119487802A71B0FC0568F305BCBE829E016EA88DA307605DCD9"];
    var_18 = physics_createcontents(var_17);
    var_19 = var_0 + var_2 * 10000;
    var_20 = scripts\engine\trace::sphere_trace(var_0, var_19, 0.1, self, var_18, 0);

    if(var_20["_encstr_A53009A25003666B9818C6"] < 0.99)
      thread markworldposition(var_20["_encstr_BD260953AA97E3F014279D"]);
    else {}
  }
}

markworldposition(var_0) {
  self.worldmarkerpos = var_0;

  if(!isDefined(self.worldmarkerid)) {
    self.worldmarkerid = scripts\mp\objidpoolmanager::requestobjectiveid(1);

    if(self.worldmarkerid != -1) {
      scripts\mp\objidpoolmanager::objective_add_objective(self.worldmarkerid, "_encstr_A2BE0AB4DC3BB46E5A981BAC", var_0, "_encstr_AFD015B4C6BDDCF5DD2C5EC1B7D2E6A3AFB516276DACC9");
      scripts\mp\objidpoolmanager::objective_teammask_single(self.worldmarkerid, self.team);
      scripts\mp\objidpoolmanager::update_objective_setbackground(self.worldmarkerid, 1);
      scripts\mp\objidpoolmanager::objective_set_play_intro(self.worldmarkerid, 0);
      scripts\mp\objidpoolmanager::objective_set_play_outro(self.worldmarkerid, 0);
    } else {
      self.worldmarkerid = undefined;
      return;
    }
  } else
    scripts\mp\objidpoolmanager::update_objective_position(self.worldmarkerid, var_0);

  var_1 = self.worldmarkerid;
  self notify("_encstr_AB7F1272899E077BC85DACAC71A03A57C520EACA");
  self endon("_encstr_AB7F1272899E077BC85DACAC71A03A57C520EACA");
  scripts\mp\objidpoolmanager::objective_set_pulsate(var_1, 1);
  wait 3.0;
  scripts\mp\objidpoolmanager::objective_set_pulsate(var_1, 0);
  wait 5.0;
  scripts\mp\objidpoolmanager::returnobjectiveid(var_1);
  self.worldmarkerid = undefined;
  self.worldmarkerpos = undefined;
}

applyoutlinecalloutsource(var_0) {
  if(!isDefined(var_0.outlinecalloutsource))
    var_0.outlinecalloutsource = [];

  foreach(var_2 in var_0.outlinecalloutsource) {
    if(var_2 == self)
      return;
  }

  var_4 = "_encstr_87250CAFCF9EB253B8FE125C30C8";
  var_5 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A51F05CB11A052", "_encstr_B1CA125C95239F3F25232059FABFEFF7CF34DDC5"))
    var_5 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A51F05CB11A052", "_encstr_B1CA125C95239F3F25232059FABFEFF7CF34DDC5")]](var_4);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A51F05CB11A052", "_encstr_8FFA0BE730B3E5A14BB84C888F"))
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A51F05CB11A052", "_encstr_8FFA0BE730B3E5A14BB84C888F")]](var_4, var_5);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BEF4071AA87BDF5220", "_encstr_86D01020A8A31A27783BBDB2F1E7BB852CE2"))
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BEF4071AA87BDF5220", "_encstr_86D01020A8A31A27783BBDB2F1E7BB852CE2")]](var_5);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A51F05CB11A052", "_encstr_A71810F05AB595D96FF635B8ECE340599BD3"))
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A51F05CB11A052", "_encstr_A71810F05AB595D96FF635B8ECE340599BD3")]](var_4);

  var_6 = [];
  var_7 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8D360838D3CB51A8EEEF", "_encstr_ABFE150D7B70BC5AF00BAF0B6BAE52ED4980C25B912075"))
    var_7 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8D360838D3CB51A8EEEF", "_encstr_ABFE150D7B70BC5AF00BAF0B6BAE52ED4980C25B912075")]](var_0, self.team, "_encstr_B89614B7ABE88DD2DC59AF73F623AC833AA1BE27B246", "_encstr_849E0E70308587819F95CBA0EE30483B");

  var_0.outlinecalloutsource[var_0.outlinecalloutsource.size] = self;
  var_6[var_7] = var_0;
  var_8 = 0;

  if(isDefined(var_0.turret)) {
    var_7 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8D360838D3CB51A8EEEF", "_encstr_ABFE150D7B70BC5AF00BAF0B6BAE52ED4980C25B912075"))
      var_7 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8D360838D3CB51A8EEEF", "_encstr_ABFE150D7B70BC5AF00BAF0B6BAE52ED4980C25B912075")]](var_0.turret, self.team, "_encstr_B89614B7ABE88DD2DC59AF73F623AC833AA1BE27B246", "_encstr_849E0E70308587819F95CBA0EE30483B");

    var_6[var_7] = var_0.turret;
    var_8 = 1;
  }

  if(var_8)
    var_0 thread processtimeout(self, var_6);
}

processtimeout(var_0, var_1) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  var_2 = 30.0;
  wait(var_2);

  for(var_3 = 0; var_3 < self.outlinecalloutsource.size; var_3++) {
    if(self.outlinecalloutsource[var_3] == var_0)
      self.outlinecalloutsource[var_3] = undefined;
  }

  foreach(var_6, var_5 in var_1) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8D360838D3CB51A8EEEF", "_encstr_BABB0FDED51D632DE62B11A5B90BC4D8CA"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8D360838D3CB51A8EEEF", "_encstr_BABB0FDED51D632DE62B11A5B90BC4D8CA")]](var_6, var_5);
  }
}

processcalloutdeath(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }
  if(!isDefined(var_0.outlinecalloutsource)) {
    return;
  }
  foreach(var_3 in var_0.outlinecalloutsource) {
    if(!isDefined(var_3)) {
      continue;
    }
    if(var_3 == var_1) {
      continue;
    }
    if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(var_3, var_1))) {
      continue;
    }
    var_4 = "_encstr_B2A40EE1C613DFAA9991B24AC09F67A3";
    var_5 = 0;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A51F05CB11A052", "_encstr_B1CA125C95239F3F25232059FABFEFF7CF34DDC5"))
      var_5 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A51F05CB11A052", "_encstr_B1CA125C95239F3F25232059FABFEFF7CF34DDC5")]](var_4);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A51F05CB11A052", "_encstr_8FFA0BE730B3E5A14BB84C888F"))
      var_3 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A51F05CB11A052", "_encstr_8FFA0BE730B3E5A14BB84C888F")]](var_4, var_5);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BEF4071AA87BDF5220", "_encstr_86D01020A8A31A27783BBDB2F1E7BB852CE2"))
      var_3 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BEF4071AA87BDF5220", "_encstr_86D01020A8A31A27783BBDB2F1E7BB852CE2")]](var_5);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A51F05CB11A052", "_encstr_A71810F05AB595D96FF635B8ECE340599BD3"))
      var_3 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A51F05CB11A052", "_encstr_A71810F05AB595D96FF635B8ECE340599BD3")]](var_4);

    var_5 = 25;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A51F05CB11A052", "_encstr_8FFA0BE730B3E5A14BB84C888F"))
      var_1 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A51F05CB11A052", "_encstr_8FFA0BE730B3E5A14BB84C888F")]](var_4, var_5);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BEF4071AA87BDF5220", "_encstr_86D01020A8A31A27783BBDB2F1E7BB852CE2"))
      var_1 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BEF4071AA87BDF5220", "_encstr_86D01020A8A31A27783BBDB2F1E7BB852CE2")]](var_5);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A51F05CB11A052", "_encstr_A71810F05AB595D96FF635B8ECE340599BD3"))
      var_1 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A51F05CB11A052", "_encstr_A71810F05AB595D96FF635B8ECE340599BD3")]](var_4);
  }
}

applygamemodecallout(var_0, var_1, var_2) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(self.gamemodecalloutent)) {
    if(self.gamemodecalloutent == var_0) {
      return;
    }
    self notify("_encstr_B1541A87CF9AFD383747C986AEE1E8A15267296F2BA23F78519EF1F9");
  } else {
    var_3 = "_encstr_87250CAFCF9EB253B8FE125C30C8";
    var_4 = 0;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A51F05CB11A052", "_encstr_B1CA125C95239F3F25232059FABFEFF7CF34DDC5"))
      var_4 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A51F05CB11A052", "_encstr_B1CA125C95239F3F25232059FABFEFF7CF34DDC5")]](var_3);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A51F05CB11A052", "_encstr_8FFA0BE730B3E5A14BB84C888F"))
      self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A51F05CB11A052", "_encstr_8FFA0BE730B3E5A14BB84C888F")]](var_3, var_4);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BEF4071AA87BDF5220", "_encstr_86D01020A8A31A27783BBDB2F1E7BB852CE2"))
      self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BEF4071AA87BDF5220", "_encstr_86D01020A8A31A27783BBDB2F1E7BB852CE2")]](var_4);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A51F05CB11A052", "_encstr_A71810F05AB595D96FF635B8ECE340599BD3"))
      self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A51F05CB11A052", "_encstr_A71810F05AB595D96FF635B8ECE340599BD3")]](var_3);
  }

  self.gamemodecallouttime = gettime();
  self.gamemodecalloutent = var_0;
  var_5 = undefined;

  if(isDefined(var_0.outlineent)) {
    var_5 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8D360838D3CB51A8EEEF", "_encstr_ABFE150D7B70BC5AF00BAF0B6BAE52ED4980C25B912075"))
      var_5 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8D360838D3CB51A8EEEF", "_encstr_ABFE150D7B70BC5AF00BAF0B6BAE52ED4980C25B912075")]](var_0.outlineent, self.team, "_encstr_B89614B7ABE88DD2DC59AF73F623AC833AA1BE27B246", "_encstr_849E0E70308587819F95CBA0EE30483B");
  }

  foreach(var_7 in level.players) {
    if(var_7.team != self.team) {
      continue;
    }
    var_7 iprintlnbold(var_1);
  }

  thread waittillobjectiveevent(var_5, var_0, var_2);
  thread waittillobjectivereplaced(var_5, var_0, var_2);
  var_9 = 30.0;
  scripts\engine\utility::waittill_notify_or_timeout("_encstr_92AD137777BCC360756CC17AB0D50F0D131809EDE7" + var_2, var_9);
  self notify("_encstr_865B113A0BD11DBF53CDAF9C6B785F655BA361" + var_2);

  if(isDefined(var_0.outlineent)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8D360838D3CB51A8EEEF", "_encstr_BABB0FDED51D632DE62B11A5B90BC4D8CA"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8D360838D3CB51A8EEEF", "_encstr_BABB0FDED51D632DE62B11A5B90BC4D8CA")]](var_5, var_0.outlineent);
  }

  self.gamemodecalloutent = undefined;
}

waittillobjectiveevent(var_0, var_1, var_2) {
  self endon("_encstr_865B113A0BD11DBF53CDAF9C6B785F655BA361" + var_2);
  self endon("_encstr_B1541A87CF9AFD383747C986AEE1E8A15267296F2BA23F78519EF1F9");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_3 = self.team;

  for(;;) {
    var_1 waittill(var_2, var_4);
    var_5 = 0;

    if(isDefined(level.gamemodegesturecalloutverify))
      var_5 = self[[level.gamemodegesturecalloutverify]](var_2, var_4);

    if(var_5) {
      var_6 = "_encstr_B2A40EE1C613DFAA9991B24AC09F67A3";
      var_7 = 0;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A51F05CB11A052", "_encstr_B1CA125C95239F3F25232059FABFEFF7CF34DDC5"))
        var_7 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A51F05CB11A052", "_encstr_B1CA125C95239F3F25232059FABFEFF7CF34DDC5")]](var_6);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A51F05CB11A052", "_encstr_8FFA0BE730B3E5A14BB84C888F"))
        self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A51F05CB11A052", "_encstr_8FFA0BE730B3E5A14BB84C888F")]](var_6, var_7);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BEF4071AA87BDF5220", "_encstr_86D01020A8A31A27783BBDB2F1E7BB852CE2"))
        self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BEF4071AA87BDF5220", "_encstr_86D01020A8A31A27783BBDB2F1E7BB852CE2")]](var_7);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A51F05CB11A052", "_encstr_A71810F05AB595D96FF635B8ECE340599BD3"))
        self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A51F05CB11A052", "_encstr_A71810F05AB595D96FF635B8ECE340599BD3")]](var_6);

      var_7 = 25;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A51F05CB11A052", "_encstr_8FFA0BE730B3E5A14BB84C888F"))
        var_4 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A51F05CB11A052", "_encstr_8FFA0BE730B3E5A14BB84C888F")]](var_6, var_7);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BEF4071AA87BDF5220", "_encstr_86D01020A8A31A27783BBDB2F1E7BB852CE2"))
        var_4 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BEF4071AA87BDF5220", "_encstr_86D01020A8A31A27783BBDB2F1E7BB852CE2")]](var_7);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A51F05CB11A052", "_encstr_A71810F05AB595D96FF635B8ECE340599BD3"))
        var_4 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A51F05CB11A052", "_encstr_A71810F05AB595D96FF635B8ECE340599BD3")]](var_6);

      if(isDefined(var_1.outlineent)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8D360838D3CB51A8EEEF", "_encstr_BABB0FDED51D632DE62B11A5B90BC4D8CA"))
          [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8D360838D3CB51A8EEEF", "_encstr_BABB0FDED51D632DE62B11A5B90BC4D8CA")]](var_0, var_1.outlineent);
      }

      self notify("_encstr_92AD137777BCC360756CC17AB0D50F0D131809EDE7" + var_2);
      break;
    }
  }
}

waittillobjectivereplaced(var_0, var_1, var_2) {
  self endon("_encstr_865B113A0BD11DBF53CDAF9C6B785F655BA361" + var_2);
  self endon("_encstr_92AD137777BCC360756CC17AB0D50F0D131809EDE7" + var_2);
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_B1541A87CF9AFD383747C986AEE1E8A15267296F2BA23F78519EF1F9");

  if(isDefined(var_1.outlineent)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8D360838D3CB51A8EEEF", "_encstr_BABB0FDED51D632DE62B11A5B90BC4D8CA"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8D360838D3CB51A8EEEF", "_encstr_BABB0FDED51D632DE62B11A5B90BC4D8CA")]](var_0, var_1.outlineent);
  }
}

_id_13850() {
  if(level.mapname == "_encstr_994B10FAA8973CA771A27E6D431E0F8635E0" || level.mapname == "_encstr_8E940C29F87032C3FF82F50F725A" || level.mapname == "_encstr_91B90DB6E0D7935D9B7356C9AF0EAD" || level.mapname == "_encstr_BDFF088922C9FF1946BF") {
    self setscriptablepartstate("_encstr_87200F3B5701DA983FC9634B70315162A5", "_encstr_B1DF1143ED36DE750B3A8DD0A7DC2796D9D047");
    self setclientomnvar("_encstr_A14D13F3CA276F785317AFFB44FE58A0CFB3C95B92", 1);
  } else {
    self setscriptablepartstate("_encstr_87200F3B5701DA983FC9634B70315162A5", "_encstr_85B50C9BAFB0AFEC2113529BA780");
    self setclientomnvar("_encstr_A14D13F3CA276F785317AFFB44FE58A0CFB3C95B92", 0);
  }

  thread _id_125D2();
}

_id_13851() {
  if(level.mapname == "_encstr_994B10FAA8973CA771A27E6D431E0F8635E0" || level.mapname == "_encstr_8E940C29F87032C3FF82F50F725A" || level.mapname == "_encstr_91B90DB6E0D7935D9B7356C9AF0EAD" || level.mapname == "_encstr_BDFF088922C9FF1946BF") {
    self setscriptablepartstate("_encstr_87200F3B5701DA983FC9634B70315162A5", "_encstr_81C7124CB8303F39F7A9B793B728F061C0E0C342");
    self setclientomnvar("_encstr_A14D13F3CA276F785317AFFB44FE58A0CFB3C95B92", 1);
  } else {
    self setscriptablepartstate("_encstr_87200F3B5701DA983FC9634B70315162A5", "_encstr_82C70D334FB97ADF88F3AE748C2862");
    self setclientomnvar("_encstr_A14D13F3CA276F785317AFFB44FE58A0CFB3C95B92", 0);
  }

  thread _id_125D2();
}

_id_13852() {
  if(level.mapname == "_encstr_994B10FAA8973CA771A27E6D431E0F8635E0" || level.mapname == "_encstr_8E940C29F87032C3FF82F50F725A" || level.mapname == "_encstr_91B90DB6E0D7935D9B7356C9AF0EAD" || level.mapname == "_encstr_BDFF088922C9FF1946BF") {
    self setscriptablepartstate("_encstr_87200F3B5701DA983FC9634B70315162A5", "_encstr_AAC7121AF636DE750B1DD843D3B9E4D2D9341DCC");
    self setclientomnvar("_encstr_A14D13F3CA276F785317AFFB44FE58A0CFB3C95B92", 1);
  } else {
    self setscriptablepartstate("_encstr_87200F3B5701DA983FC9634B70315162A5", "_encstr_BDC70D5BB5AAB78F018B48087F564B");
    self setclientomnvar("_encstr_A14D13F3CA276F785317AFFB44FE58A0CFB3C95B92", 0);
  }

  thread _id_125D2();
}

_id_125D2() {
  self notify("_encstr_978917A36A2F1B8802D04F51EFA36065DFC25F4883935B689F");
  self endon("_encstr_978917A36A2F1B8802D04F51EFA36065DFC25F4883935B689F");

  for(;;) {
    scripts\engine\utility::_id_143A6("_encstr_8D0118DCDAE523A59DB27D19CA0763DE5E0785270BC6435DA359", "_encstr_8C900C26440B51B8E61F7950CB0C", "_encstr_B45E1613B7A87FCF54D989A221240735882DBD8D350B0583");
    thread _id_13E1A();
  }
}

_id_13838() {
  if(istrue(self.convoy4_mortar_guys)) {
    return;
  }
  self setscriptablepartstate("_encstr_87200F3B5701DA983FC9634B70315162A5", "_encstr_A9250D1DA89B98EB174933CFD82726");
  self setclientomnvar("_encstr_A14D13F3CA276F785317AFFB44FE58A0CFB3C95B92", 0);
  self _meth_87A4(4, 20, 1);
  self.convoy4_mortar_guys = 1;
  thread convoy4_roof_jugg();
}

convoy4_roof_jugg() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 4.2;
  self.convoy4_mortar_guys = undefined;
  self setscriptablepartstate("_encstr_87200F3B5701DA983FC9634B70315162A5", "_encstr_BA19049F4B2D");

  if(isDefined(self.accessorylogic))
    self _meth_87A5();
}

_id_13E1A() {
  self notify("_encstr_92B619E8C9CBA4CAACCD584C8D56A6364ED21C8E0B4C8D2BAC1985");
  self endon("_encstr_92B619E8C9CBA4CAACCD584C8D56A6364ED21C8E0B4C8D2BAC1985");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self setscriptablepartstate("_encstr_87200F3B5701DA983FC9634B70315162A5", "_encstr_BA19049F4B2D");
  var_0 = isDefined(self.accessorylogic) && self.accessorylogic == "_encstr_BACC05C9770D68";
  var_1 = isDefined(self.accessorylogic) && self.accessorylogic == "_encstr_877A067A5714507E";
  var_2 = isDefined(self.accessorylogic) && self.accessorylogic == "_encstr_967A06A1F61BDE66";

  if(var_0) {
    wait 0.2;
    var_3 = self hasweapon("_encstr_AB2936E9C47A072EB770912B788B228FE8B87F99DDB96379FDDAFA23FA9F5E67A1AFF104750187FC7FA8627A0847D70799F36C89816ED7C7") || self hasweapon("_encstr_A5403A522BDBB796C81FBF9F3BF01AAF28C64B5AD3DE23413A97B18779D966D7C67EA2937BA7B7447965B19BEBB16F077CD06B4A8D1077FFA155A167") || self hasweapon("_encstr_83613D838FD7F85003BE869B27E910284AC7271B3BCA3BD90A84489398EFC056325F838953B276A84FAF71E9F787209B2A2F512BABB9CF88B787F9209E6C10") || self hasweapon("_encstr_926C3CBDC87143111B0FD048DF20A8E5D9C3BFC5365A77D38B5BBAA1C74B614FC2ABADC78EB2AF21A92F50A9FB39D877BA95ACD6E68B890893C71040ABB3") || self hasweapon("_encstr_9A3740C9EB7E8A86BED1133DF99730EB0FC30A23113B112B980BDB5EE20F1621D1CB6D836EE41F19CEBB5021DC42149A78B7E7C2822081A37087357E2D88F1B9132F") || self hasweapon("_encstr_8CB14365591F49AFB681C0A89A8A7F60C7BF67DD9BABF6578C1BBA71B2661F1E974475DFF3133E3546724069FBA8C1D0DBF774CE499B80132ED9F09032D4F749576D8F49A5");

    if(var_3 && (!isDefined(self._id_13416) || !istrue(self._id_13416))) {
      if(var_3) {
        _id_13850();
        return;
      }

      return;
    }
  } else if(var_1) {
    wait 0.2;
    var_4 = self hasweapon("_encstr_92E338D45BDA2E415E234E87155E8BAF38C73F9101F0A0485376B938A3DFDE6A481FB6887841D70359843A9F42B8D87F975993B9EBA63E274106") || self hasweapon("_encstr_A9763C1B174F60D8BB060E03AF6188A0C24FAF93B342B361820CF01B0E7748EE4AE77B312B0A8E20D737F9917F0F5813A2A7D9A3233147103F0E2649641F") || self hasweapon("_encstr_8CE13F74C3EA7732AEDF6FD7CB47EB8FA02E6BFE1B9818A95E67BFDF9960A2FB60B6660373D0DB12C085A7771B083A3918D8DBCEE8C961BA38A5576B73C95264E0");

    if(var_4 && (!isDefined(self._id_13416) || !istrue(self._id_13416))) {
      if(var_4) {
        _id_13851();
        return;
      }

      return;
    }
  } else if(var_2) {
    wait 0.2;
    var_5 = self hasweapon("_encstr_B4613F6BE2977EAF71B8676D4FFB57456F78A2E38851B9962015215F57A13F41BBF87B0AE009610B41F645A7F582EB14EFB88382638FE47718E84F820773E35C0F") || self hasweapon("_encstr_B41E434B5276C1926FAF6BE777312A861EB897F32848075FD7ADE0116F3F226F61C85B2FD0E04F529BCEFF19CD530A114998D3B7637EA00AE9D0474ABFA902A991C1F31FC0") || self hasweapon("_encstr_A5484655490F59BFA67130B88ABA6F70B7AF57CD6BBBC6279C2B4A61A2162FEEA73465CFC3630EC5766250598BB8E960E7C1EDB75417900F1DCA4838F20289B85F4F7C3DBD97D853") || self hasweapon("_encstr_88C04183E2684F16C867978D3378DDABB0C32A0B315BFF5AF229E1AFCB38E627C71BF3C2992347C7886FB5A7C9826F077CD06B4A8D1067FF9071BC69FB737973932BF2") || self hasweapon("_encstr_AF68459443365F0E1731B3EAB849452B6ECC092CF6385FC2AF405F419047BE37013584B11E8017DFE3E08259202B37A739130C29210E27A7BB909B3260ED21235006659F4E1067") || self hasweapon("_encstr_AC024824FBC729218BB6BB054F5380BD49CF47631EF301EA2EC8BB8FBA60CE118943C45EFF8B69816F9647AF3BE61AE32FD3A3E3DCE112B1E3C0A0D87F9AE1FA2BDD4FCFD878D8EA9177");

    if(var_5 && (!isDefined(self._id_13416) || !istrue(self._id_13416))) {
      if(var_5)
        _id_13852();
    }
  }
}

watchradialgestureactivation(var_0, var_1) {
  if((level.gametype == "_encstr_B607038AAB" || level.gametype == "_encstr_BE180419DAE9" || level.gametype == "_encstr_8AE1099A0B999F2D28AF15" || level.gametype == "_encstr_866209ECEDB1197DEE0B4E") && self hasweapon("_encstr_B60816BAAB286D9BE1BF79AE2BC31FB38B8B856008975D73")) {
    return;
  }
  if(var_0 == "_encstr_8A4E1EF3E6A488770AAF032B53A350907D3D99294B017BB851271B0FD34B0E78") {
    var_2 = getgesturedatabyindex(var_1);

    if(isDefined(var_2)) {
      if(var_2 == "_encstr_9107182387E0115477EB3EC3025F96594FED9F812DDA1807C2B7") {
        if(!isDefined(self._id_13416))
          self._id_13416 = 0;

        self._id_13416 = !self._id_13416;
        self setclientomnvar("_encstr_853D183340911BB2EFBD8337AF876B4350EEAC7D5BE8C28A3699", self._id_13416);

        if(isDefined(self.accessorylogic)) {
          if(self.accessorylogic == "_encstr_BACC05C9770D68") {
            if(!self._id_13416)
              _id_13850();
            else
              self setscriptablepartstate("_encstr_87200F3B5701DA983FC9634B70315162A5", "_encstr_BA19049F4B2D");
          } else if(self.accessorylogic == "_encstr_877A067A5714507E") {
            if(!self._id_13416)
              _id_13851();
            else
              self setscriptablepartstate("_encstr_87200F3B5701DA983FC9634B70315162A5", "_encstr_BA19049F4B2D");
          } else if(self.accessorylogic == "_encstr_967A06A1F61BDE66") {
            if(!self._id_13416)
              _id_13852();
            else
              self setscriptablepartstate("_encstr_87200F3B5701DA983FC9634B70315162A5", "_encstr_BA19049F4B2D");
          } else if(self.accessorylogic == "_encstr_A1FA07287D73E64F48")
            scripts\cp_mp\utility\callback_group::_id_144E1();
        }
      } else if(var_2 == "_encstr_8F071880BBC06F394F9348D794E743A7FF62D8F033EA439B7AFB") {
        if(!isDefined(self._id_14496))
          self._id_14496 = 0;

        self._id_14496 = !self._id_14496;
        self setclientomnvar("_encstr_87A8157DDBF1D2A7A75363D9DB8F9B8E20CFE3F86BA81C", self._id_14496);

        if(isDefined(self.accessorylogic)) {
          if(self.accessorylogic == "_encstr_8DAC068E58433705")
            _id_13838();
        }
      }

      var_3 = getcompleteweaponname(var_2);

      if(isDefined(var_3) && !nullweapon(var_3)) {
        var_4 = remapobjkeysandscriptlabels(var_1);

        if((self.operatorcustomization.voice == "_encstr_921904C5DAC8" || self.operatorcustomization.voice == "_encstr_881904D6B1B1") && isDefined(var_4) && issubstr(var_4, "_encstr_BDDB0E0A8B994967FB10C74B2EF3450B")) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8260069BDBBACD46", "_encstr_8E8311D9FBA39E303955A0390604E9C8DB2361"))
            level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8260069BDBBACD46", "_encstr_8E8311D9FBA39E303955A0390604E9C8DB2361")]](self, "_encstr_A2271547319BC742B579FFAB03C81B31E8F83BC129908C");
        } else if(isDefined(var_4) && var_4 != "_encstr_B40101") {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8260069BDBBACD46", "_encstr_8E8311D9FBA39E303955A0390604E9C8DB2361"))
            level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8260069BDBBACD46", "_encstr_8E8311D9FBA39E303955A0390604E9C8DB2361")]](self, var_4);
        }

        scripts\cp\vehicles\vehicle_compass_cp::_encstr_9A6C0AFFB8611F5A69D0533A();
        watchradialgesture(var_3);
        return;
      }

      return;
    }
  } else if(var_0 == "_encstr_81AC1C7AB789A7A621093AB2A83B117701A9F5E35570F7AD9F90F3FBC85B") {
    var_3 = getcompleteweaponname("_encstr_ACBF13E9C47A07AFBBF0915B30BBA24F4B2F7A995B");

    if(isDefined(var_3) && !nullweapon(var_3)) {
      thread _id_144F7(var_1);
      watchradialgesture(var_3);
    } else {}
  }
}

_id_144F7(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_B2601ED8FF3B77506F030A679758DFB3C93DBEFD3D70018312923067B4902D80");
  self endon("_encstr_B2601ED8FF3B77506F030A679758DFB3C93DBEFD3D70018312923067B4902D80");
  var_1 = gettime() + 200;

  while(gettime() < var_1) {
    waitframe();

    if(self isgestureplaying("_encstr_ACBF13E9C47A07AFBBF0915B30BBA24F4B2F7A995B")) {
      self sprayevent(var_0);
      scripts\cp\vehicles\vehicle_compass_cp::_id_1208F();
      return;
    }
  }
}

watchradialgesture(var_0) {
  self giveandfireoffhand(var_0);
  var_1 = gettime() + 5000;

  while(gettime() < var_1) {
    if(!self hasweapon(var_0)) {
      break;
    }

    waitframe();
  }

  if(self hasweapon(var_0))
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0);

  cleargesture();
  waitframe();
  self.gestureweapon = var_0.basename;
}