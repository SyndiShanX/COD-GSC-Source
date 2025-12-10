/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\2935.gsc
************************/

main() {
  level.var_10707 = [];
  level.var_10707["allies"] = [];
  level.var_10707["axis"] = [];
  level.var_10707["team3"] = [];
  level.var_10707["neutral"] = [];
  thread enableoffhandsecondaryweapons();
  var_00 = getEntArray("flood_and_secure", "targetname");
  scripts\engine\utility::array_thread(var_00, ::func_6F4C);
  if(!isDefined(level.var_19C9)) {
    level.var_19C9 = 0;
  }

  if(getdvar("fallback") == "") {
    setdvar("fallback", "0");
  }

  if(getdvar("noai") == "") {
    setdvar("noai", "off");
  }

  precachemodel("grenade_bag");
  createthreatbiasgroup("allies");
  createthreatbiasgroup("axis");
  createthreatbiasgroup("team3");
  createthreatbiasgroup("civilian");
  createthreatbiasgroup("equipment");
  setthreatbias("axis", "equipment", 250);
  setthreatbias("allies", "equipment", 250);
  setthreatbias("team3", "equipment", -1000);
  lib_0B5F::func_965A();
  foreach(var_02 in level.players) {
    var_02 give_zombies_perk("allies");
  }

  level.var_1162 = [];
  level.var_76F3 = [];
  if(!isDefined(level.var_4E3F)) {
    level.var_4E3F = [];
  }

  level.var_1086A = 0;
  if(!isDefined(level.var_12BA5)) {
    level.var_12BA5 = [];
  }

  var_04 = getspawnerarray();
  foreach(var_06 in var_04) {}

  level.var_12BA5["soldier"] = ::func_10804;
  level.var_12BA5["c8"] = ::func_10803;
  level.var_115BE = [];
  level.var_115BE["axis"] = ::func_107ED;
  level.var_115BE["allies"] = ::func_107EC;
  level.var_115BE["team3"] = ::func_107EF;
  level.var_115BE["neutral"] = ::func_107EE;
  if(!isDefined(level.var_4FF6)) {
    level.var_4FF6 = 2048;
  }

  if(!isDefined(level.var_4FF5)) {
    level.var_4FF5 = 512;
  }

  level.var_D66F = "J_Shoulder_RI";
  level.var_1349 = 0;
  var_08 = getaispeciesarray();
  scripts\engine\utility::array_thread(var_08, ::func_AD8E);
  level.var_1923 = [];
  level.var_5C63 = [];
  var_09 = getspawnerarray();
  for(var_0A = 0; var_0A < var_09.size; var_0A++) {
    var_09[var_0A] thread func_107AB();
  }

  level.var_5C63 = undefined;
  scripts\sp\utility::func_9189("tracker", 1, "default");
  thread func_D970();
  scripts\engine\utility::array_thread(var_08, ::func_107F2);
  var_0B = getarraykeys(level.var_1923);
  for(var_0A = 0; var_0A < var_0B.size; var_0A++) {
    var_0C = tolower(var_0B[var_0A]);
    if(!issubstr(var_0C, "rpg")) {
      continue;
    }

    var_0D = "iw7_lockon";
    precacheitem(var_0D);
    break;
  }

  var_0B = undefined;
}

func_1B09() {}

func_D970() {
  foreach(var_02, var_01 in level.var_4E3F) {
    if(!isDefined(level.flag[var_02])) {
      scripts\engine\utility::flag_init(var_02);
    }
  }
}

func_10729() {
  self endon("death");
  for(;;) {
    if(self.var_C1 > 0) {
      self waittill("spawned");
    }

    waittillframeend;
    if(!self.var_C1) {
      return;
    }
  }
}

func_1936() {
  level.var_4E3F[self.var_ED48]["ai"][self.unique_id] = self;
  var_00 = self.unique_id;
  var_01 = self.var_ED48;
  if(isDefined(self.var_ED49)) {
    func_1382D();
  } else {
    self waittill("death");
  }

  level.var_4E3F[var_01]["ai"][var_00] = undefined;
  func_12DAA(var_01);
}

func_131C1() {
  var_00 = self.unique_id;
  var_01 = self.var_ED48;
  if(!isDefined(level.var_4E3F) || !isDefined(level.var_4E3F[self.var_ED48])) {
    waittillframeend;
    if(!isDefined(self)) {
      return;
    }
  }

  level.var_4E3F[var_01]["vehicles"][var_00] = self;
  self waittill("death");
  level.var_4E3F[var_01]["vehicles"][var_00] = undefined;
  func_12DAA(var_01);
}

func_1085A() {
  level.var_4E3F[self.var_ED48] = [];
  waittillframeend;
  if(!isDefined(self) || self.var_C1 == 0) {
    return;
  }

  self.var_1086A = level.var_1086A;
  level.var_1086A++;
  level.var_4E3F[self.var_ED48]["spawners"][self.var_1086A] = self;
  var_00 = self.var_ED48;
  var_01 = self.var_1086A;
  func_10729();
  level.var_4E3F[var_00]["spawners"][var_01] = undefined;
  func_12DAA(var_00);
}

func_1323D() {
  level.var_4E3F[self.var_ED48] = [];
  waittillframeend;
  if(!isDefined(self)) {
    return;
  }

  self.var_1086A = level.var_1086A;
  level.var_1086A++;
  level.var_4E3F[self.var_ED48]["vehicle_spawners"][self.var_1086A] = self;
  var_00 = self.var_ED48;
  var_01 = self.var_1086A;
  func_10729();
  level.var_4E3F[var_00]["vehicle_spawners"][var_01] = undefined;
  func_12DAA(var_00);
}

func_12DAA(param_00) {
  level notify("updating_deathflag_" + param_00);
  level endon("updating_deathflag_" + param_00);
  waittillframeend;
  foreach(var_02 in level.var_4E3F[param_00]) {
    if(getarraykeys(var_02).size > 0) {
      return;
    }
  }

  scripts\engine\utility::flag_set(param_00);
}

func_C75A(param_00) {
  param_00 endon("death");
  for(;;) {
    param_00 waittill("trigger", var_01);
    if(!isai(var_01)) {
      continue;
    }

    var_01 thread scripts\sp\utility::func_931D(0.15);
    var_01 scripts\sp\utility::func_5514();
  }
}

func_9409(param_00) {
  param_00 endon("death");
  for(;;) {
    param_00 waittill("trigger", var_01);
    if(!isai(var_01)) {
      continue;
    }

    var_01 thread scripts\sp\utility::func_931D(0.15);
    var_01 scripts\sp\utility::func_61E7();
  }
}

func_12797(param_00) {
  param_00 waittill("trigger");
  var_01 = param_00.var_DC8F;
  var_02 = param_00.target;
  param_00 scripts\sp\utility::script_delay();
  if(isDefined(var_01)) {
    waittillframeend;
  }

  var_03 = scripts\engine\utility::array_combine(getspawnerarray(var_02), vehicle_getspawnerarray(var_02));
  foreach(var_05 in var_03) {
    if(!isnonentspawner(var_05) && var_05.var_9F == "script_vehicle") {
      if((isDefined(var_05.var_EE2B) && var_05.var_EE2B == 1) || !isDefined(var_05.target)) {
        thread scripts\sp\vehicle::func_13237(var_05);
      } else {
        var_05 thread scripts\sp\vehicle::func_1080B();
      }

      continue;
    }

    var_05 thread func_12799();
  }

  if(isDefined(level.var_107A7)) {
    func_12781(var_02);
  }
}

func_12781(param_00) {
  var_01 = scripts\engine\utility::getstructarray(param_00, "targetname");
  if(getEntArray(param_00, "target").size <= 1) {
    scripts\sp\utility::func_51D6(var_01);
  }

  var_02 = func_7BC6(var_01);
  scripts\engine\utility::array_thread(var_02, ::func_12799);
}

func_7BC6(param_00) {
  var_01 = [];
  var_02 = [];
  foreach(var_04 in param_00) {
    if(!isDefined(var_04.var_EEB6)) {
      continue;
    }

    if(!isDefined(var_02[var_04.var_EEB6])) {
      var_02[var_04.var_EEB6] = [];
    }

    var_02[var_04.var_EEB6][var_02[var_04.var_EEB6].size] = var_04;
  }

  foreach(var_07 in var_02) {
    foreach(var_04 in var_07) {
      var_09 = func_7C86(var_04, var_07.size);
      var_01[var_01.size] = var_09;
    }
  }

  return var_01;
}

func_7C86(param_00, param_01) {
  if(!isDefined(level.var_1086B)) {
    level.var_1086B = [];
  }

  if(!isDefined(level.var_1086B[param_00.var_EEB6])) {
    level.var_1086B[param_00.var_EEB6] = func_492A(param_00.var_EEB6);
  }

  var_02 = level.var_1086B[param_00.var_EEB6];
  var_03 = var_02.pool[var_02.var_D653];
  var_02.var_D653++;
  var_02.var_D653 = var_02.var_D653 % var_02.pool.size;
  var_03.origin = param_00.origin;
  if(isDefined(param_00.angles)) {
    var_03.angles = param_00.angles;
  } else if(isDefined(param_00.target)) {
    var_04 = getnode(param_00.target, "targetname");
    if(isDefined(var_04)) {
      var_03.angles = vectortoangles(var_04.origin - var_03.origin);
    }
  }

  if(isDefined(level.var_107A6)) {
    var_03[[level.var_107A6]](param_00);
  }

  if(isDefined(param_00.target)) {
    var_03.target = param_00.target;
  }

  var_03.var_C1 = 1;
  return var_03;
}

func_492A(param_00) {
  var_01 = getspawnerarray();
  var_02 = spawnStruct();
  var_03 = [];
  foreach(var_05 in var_01) {
    if(!isDefined(var_05.var_EEB6)) {
      continue;
    }

    if(var_05.var_EEB6 != param_00) {
      continue;
    }

    var_03[var_03.size] = var_05;
  }

  var_02.var_D653 = 0;
  var_02.pool = var_03;
  return var_02;
}

func_12799() {
  self endon("death");
  scripts\sp\utility::script_delay();
  if(!isDefined(self)) {
    return undefined;
  }

  if(isDefined(self.var_ED6E)) {
    var_00 = scripts\sp\utility::func_5CC8(self);
    return undefined;
  } else if(isDefined(self.var_ED8A)) {
    var_00 = scripts\sp\utility::func_6B47(self);
    return undefined;
  } else if(isDefined(self.var_ED1B)) {
    var_00 = scripts\sp\utility::func_2C17(self);
    return undefined;
  } else if(!issubstr(self.classname, "actor")) {
    return undefined;
  }

  var_01 = isDefined(self.var_EED1) && scripts\engine\utility::flag("stealth_enabled") && !scripts\engine\utility::flag("stealth_spotted");
  if(isDefined(self.var_EDB3)) {
    var_00 = self _meth_8393(var_01);
  } else {
    var_00 = self dospawn(var_01);
  }

  if(!scripts\sp\utility::func_106ED(var_01)) {
    if(isDefined(self.var_ED39)) {
      if(self.var_ED39 == "heat") {
        var_01 scripts\sp\utility::func_61FF();
      }

      if(self.var_ED39 == "cqb") {
        var_01 scripts\sp\utility::func_61E7();
      }
    }
  }

  return var_01;
}

func_12798(param_00) {
  var_01 = param_00.target;
  var_02 = 0;
  var_03 = getspawnerarray(var_01);
  foreach(var_05 in var_03) {
    if(!isDefined(var_05.target)) {
      continue;
    }

    var_06 = getspawner(var_05.target, "targetname");
    if(!isDefined(var_06)) {
      if(!isDefined(var_05.script_linkto)) {
        continue;
      }

      var_06 = getspawner(var_05.script_linkto, "script_linkname");
      if(!isDefined(var_06)) {
        var_06 = var_05 scripts\sp\utility::func_7A8E();
      }

      if(!isDefined(var_06)) {
        continue;
      }

      if(!isspawner(var_06)) {
        continue;
      }
    }

    var_02 = 1;
    break;
  }

  param_00 waittill("trigger");
  param_00 scripts\sp\utility::script_delay();
  var_03 = getspawnerarray(var_01);
  foreach(var_05 in var_03) {
    var_05 thread func_1278A();
  }
}

func_1278A() {
  var_00 = func_12789();
  var_01 = func_12799();
  if(!isDefined(var_01)) {
    self delete();
    if(isDefined(var_00)) {
      var_01 = var_00 func_12799();
      var_00 delete();
      if(!isDefined(var_01)) {
        return;
      }
    } else {
      return;
    }
  }

  if(!isDefined(var_00)) {
    return;
  }

  var_01 waittill("death");
  if(!isDefined(var_00)) {
    return;
  }

  if(!isDefined(var_00.var_C1)) {
    var_00.var_C1 = 1;
  }

  for(;;) {
    if(!isDefined(var_00)) {
      break;
    }

    var_02 = var_00 func_12799();
    if(!isDefined(var_02)) {
      var_00 delete();
      break;
    }

    var_02 thread func_DF23(var_00);
    var_02 waittill("death", var_03);
    if(!func_D27A(var_02, var_03)) {
      if(!isDefined(var_00)) {
        break;
      }

      var_00.var_C1++;
    }

    if(!isDefined(var_02)) {
      continue;
    }

    if(!isDefined(var_00)) {
      break;
    }

    if(!isDefined(var_00.var_C1)) {
      break;
    }

    if(var_00.var_C1 <= 0) {
      break;
    }

    if(!scripts\sp\utility::func_EF15()) {
      wait(randomfloatrange(1, 3));
    }
  }

  if(isDefined(var_00)) {
    var_00 delete();
  }
}

func_12789() {
  if(isDefined(self.target)) {
    var_00 = getspawner(self.target, "targetname");
    if(isDefined(var_00) && isspawner(var_00)) {
      return var_00;
    }
  }

  if(isDefined(self.script_linkto)) {
    var_00 = getspawner(self.script_linkto, "script_linkname");
    if(!isDefined(var_00)) {
      var_00 = scripts\sp\utility::func_7A8E();
    }

    if(isDefined(var_00) && isspawner(var_00)) {
      return var_00;
    }
  }

  return undefined;
}

func_6F5A(param_00) {
  scripts\engine\utility::array_thread(param_00, ::func_6F59);
  scripts\engine\utility::array_thread(param_00, ::func_6F5C);
}

func_DF23(param_00) {
  param_00 endon("death");
  if(isDefined(self.var_EDAA)) {
    if(self.var_EDAA) {
      return;
    }
  }

  self waittill("death");
  if(!isDefined(self)) {
    param_00.var_C1++;
  }
}

func_A617(param_00) {
  var_01 = param_00.var_EDF7;
  param_00 waittill("trigger");
  waittillframeend;
  waittillframeend;
  func_A67F(var_01);
  func_A622(param_00);
}

func_A67F(param_00) {
  var_01 = getspawnerarray();
  var_02 = vehicle_getspawnerarray();
  var_03 = scripts\engine\utility::array_combine(var_01, var_02);
  for(var_04 = 0; var_04 < var_03.size; var_04++) {
    if(isDefined(var_03[var_04].var_EDF7) && param_00 == var_03[var_04].var_EDF7) {
      if(isnonentspawner(var_03[var_04])) {
        var_03[var_04] notify("death");
      }

      var_03[var_04] delete();
    }
  }
}

func_A622(param_00) {
  if(!isDefined(param_00)) {
    return;
  }

  if(isDefined(param_00.var_336) && param_00.var_336 != "flood_spawner") {
    return;
  }

  param_00 delete();
}

func_DC8F(param_00) {
  param_00 endon("death");
  var_01 = param_00.var_EE90;
  waittillframeend;
  if(!isDefined(level.var_A67E)) {
    level.var_A67E = [];
  }

  if(!isDefined(level.var_A67E[var_01])) {
    return;
  }

  param_00 waittill("trigger");
  func_4B09(var_01);
}

func_4B09(param_00) {
  if(!isDefined(level.var_A67E)) {
    level.var_A67E = [];
  }

  if(!isDefined(level.var_A67E[param_00])) {
    return;
  }

  var_01 = level.var_A67E[param_00];
  var_02 = getarraykeys(var_01);
  if(var_02.size <= 1) {
    return;
  }

  var_03 = scripts\engine\utility::random(var_02);
  var_01[var_03] = undefined;
  foreach(var_09, var_05 in var_01) {
    foreach(var_07 in var_05) {
      if(isDefined(var_07)) {
        var_07 delete();
      }
    }

    level.var_A67E[param_00][var_09] = undefined;
  }
}

func_61BD(param_00) {
  var_01 = param_00.script_emptyspawner;
  param_00 waittill("trigger");
  var_02 = getspawnerarray();
  for(var_03 = 0; var_03 < var_02.size; var_03++) {
    if(!isDefined(var_02[var_03].script_emptyspawner)) {
      continue;
    }

    if(var_01 != var_02[var_03].script_emptyspawner) {
      continue;
    }

    var_02[var_03] scripts\sp\utility::func_F311(0);
    var_02[var_03] notify("emptied spawner");
  }

  param_00 notify("deleted spawners");
}

func_A618(param_00) {
  var_01 = getspawnerarray();
  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    if(!isDefined(var_01[var_02].var_EDF7)) {
      continue;
    }

    if(param_00 != var_01[var_02].var_EDF7) {
      continue;
    }

    var_01[var_02] delete();
  }
}

spawn_grenade(param_00, param_01) {
  var_02 = spawn("weapon_frag", param_00);
  var_02 thread add_to_grenade_cache(param_01);
  return var_02;
}

add_to_grenade_cache(param_00) {
  if(!isDefined(level._meth_8580) || !isDefined(level._meth_8580[param_00])) {
    level._meth_8581[param_00] = 0;
    level._meth_8580[param_00] = [];
  }

  var_01 = level._meth_8581[param_00];
  var_02 = level._meth_8580[param_00][var_01];
  if(isDefined(var_02)) {
    var_02 delete();
  }

  level._meth_8580[param_00][var_01] = self;
  level._meth_8581[param_00] = var_01 + 1 % 16;
}

func_1382D() {
  self endon("death");
  self waittill("pain_death");
}

func_5CEE() {
  func_1382D();
  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.var_C05C)) {
    return;
  }

  self.precachemodel = 1;
  if(scripts\sp\utility::func_93A6()) {
    if(scripts\sp\specialist_MAYBE::spawn_nanoshot()) {
      return;
    }
  }

  if(self.objective_state <= 0) {
    return;
  }

  if(level.player scripts\sp\utility::func_65DF("zero_gravity") && level.player scripts\sp\utility::func_65DB("zero_gravity")) {
    return;
  }

  level.var_BF83--;
  if(level.var_BF83 > 0) {
    return;
  }

  level.var_BF83 = 2 + randomint(2);
  var_00 = 25;
  var_01 = 12;
  var_02 = self.origin + (randomint(var_00) - var_01, randomint(var_00) - var_01, 2) + (0, 0, 42);
  var_03 = (0, randomint(360), 90);
  thread func_10720(var_02, var_03, self.team);
}

func_10720(param_00, param_01, param_02) {
  if(isDefined(level.var_D9E5["mandatoryunlocks"]) && scripts\engine\utility::array_contains(level.var_D9E5["mandatoryunlocks"], "frag")) {
    return;
  }

  var_03 = spawn_grenade(param_00, param_02);
  var_03 setModel("grenade_bag");
  var_03.angles = param_01;
  var_03 hide();
  wait(0.7);
  if(!isDefined(var_03)) {
    return;
  }

  var_03 show();
}

func_5CCA() {
  scripts\sp\drone_base::func_5C3A();
}

func_6B48() {
  scripts\sp\fakeactor::func_6B44();
}

func_107AB() {
  level.var_1923[self.classname] = 1;
  if(isDefined(self.var_ED5B)) {
    switch (self.var_ED5B) {
      case "easy":
        if(level.var_7683 > 1) {
          scripts\sp\utility::func_F311(0);
        }
        break;

      case "hard":
        if(level.var_7683 < 2) {
          scripts\sp\utility::func_F311(0);
        }
        break;
    }
  }

  func_9769();
  if(isDefined(self.var_ED6E)) {
    thread func_5CCA();
  }

  if(isDefined(self.var_ED8A)) {
    thread func_6B48();
  }

  if(isDefined(self.var_ECE7)) {
    var_00 = self.var_ECE7;
    if(!isDefined(level.var_1162[var_00])) {
      func_1A12(var_00);
    }

    thread func_1A17(level.var_1162[var_00]);
  }

  if(isDefined(self.var_ED54)) {
    var_01 = 0;
    if(isDefined(level.var_1160)) {
      if(isDefined(level.var_1160[self.var_ED54])) {
        var_01 = level.var_1160[self.var_ED54].size;
      }
    }

    level.var_1160[self.var_ED54][var_01] = self;
  }

  if(isDefined(self.var_EDD7)) {
    if(self.var_EDD7 > level.var_1349) {
      level.var_1349 = self.var_EDD7;
    }

    var_01 = 0;
    if(isDefined(level.var_1164)) {
      if(isDefined(level.var_1164[self.var_EDD7])) {
        var_01 = level.var_1164[self.var_EDD7].size;
      }
    }

    level.var_1164[self.var_EDD7][var_01] = self;
  }

  if(isDefined(self.var_ED48)) {
    thread func_1085A();
  }

  if(isDefined(self.target)) {
    func_486E(self.target);
  }

  if(isDefined(self.var_EEBA)) {
    func_177E();
  }

  if(isDefined(self.var_EE90)) {
    func_1732();
  }

  if(!isDefined(self.var_10708)) {
    self.var_10708 = [];
  }

  for(;;) {
    self waittill("spawned", var_02);
    if(!isalive(var_02)) {
      continue;
    }

    if(isDefined(level.var_10877)) {
      self thread[[level.var_10877]](var_02);
    }

    if(isDefined(self.var_ED54)) {
      for(var_03 = 0; var_03 < level.var_1160[self.var_ED54].size; var_03++) {
        if(level.var_1160[self.var_ED54][var_03] != self) {
          level.var_1160[self.var_ED54][var_03] delete();
        }
      }
    }

    var_02.var_10707 = self.var_10708;
    var_02.var_10708 = undefined;
    var_02.spawner = self;
    if(isDefined(self.var_336)) {
      var_02 thread func_107F2(self.var_336);
      continue;
    }

    var_02 thread func_107F2();
  }
}

func_9769() {
  if(!isDefined(self.var_EECE) && !isDefined(self.var_EED1)) {
    return;
  }

  if(isDefined(self.var_EECE) && !isDefined(self.var_EED1)) {
    self.var_EED1 = self.var_EECE;
  }

  self.var_EECE = undefined;
}

func_107F2(param_00) {
  level.var_1923[self.classname] = 1;
  if(isDefined(self.asmname) && self.asmname == "seeker") {
    return;
  }

  func_107F3(param_00);
  self endon("death");
  if(func_1003C()) {
    self delete();
  }

  thread func_E81A();
  self.var_6CDA = 1;
  self notify("finished spawning");
}

func_1003C() {
  if(!isDefined(self.var_ED5B)) {
    return 0;
  }

  var_00 = 0;
  switch (self.var_ED5B) {
    case "easy":
      if(level.var_7683 > 1) {
        var_00 = 1;
      }
      break;

    case "hard":
      if(level.var_7683 < 2) {
        var_00 = 1;
      }
      break;
  }

  return var_00;
}

func_E81A() {
  if(!isDefined(self.var_10707)) {
    self.spawner = undefined;
    return;
  }

  for(var_00 = 0; var_00 < self.var_10707.size; var_00++) {
    var_01 = self.var_10707[var_00];
    if(isDefined(var_01["param5"])) {
      thread[[var_01["function"]]](var_01["param1"], var_01["param2"], var_01["param3"], var_01["param4"], var_01["param5"]);
      continue;
    }

    if(isDefined(var_01["param4"])) {
      thread[[var_01["function"]]](var_01["param1"], var_01["param2"], var_01["param3"], var_01["param4"]);
      continue;
    }

    if(isDefined(var_01["param3"])) {
      thread[[var_01["function"]]](var_01["param1"], var_01["param2"], var_01["param3"]);
      continue;
    }

    if(isDefined(var_01["param2"])) {
      thread[[var_01["function"]]](var_01["param1"], var_01["param2"]);
      continue;
    }

    if(isDefined(var_01["param1"])) {
      thread[[var_01["function"]]](var_01["param1"]);
      continue;
    }

    thread[[var_01["function"]]]();
  }

  var_02 = scripts\engine\utility::ter_op(isDefined(level.vehicle.var_10709) && level.vehicle.var_10709 && self.var_9F == "script_vehicle", self.script_team, self.team);
  if(isDefined(var_02)) {
    for(var_00 = 0; var_00 < level.var_10707[var_02].size; var_00++) {
      var_01 = level.var_10707[var_02][var_00];
      if(isDefined(var_01["param5"])) {
        thread[[var_01["function"]]](var_01["param1"], var_01["param2"], var_01["param3"], var_01["param4"], var_01["param5"]);
        continue;
      }

      if(isDefined(var_01["param4"])) {
        thread[[var_01["function"]]](var_01["param1"], var_01["param2"], var_01["param3"], var_01["param4"]);
        continue;
      }

      if(isDefined(var_01["param3"])) {
        thread[[var_01["function"]]](var_01["param1"], var_01["param2"], var_01["param3"]);
        continue;
      }

      if(isDefined(var_01["param2"])) {
        thread[[var_01["function"]]](var_01["param1"], var_01["param2"]);
        continue;
      }

      if(isDefined(var_01["param1"])) {
        thread[[var_01["function"]]](var_01["param1"]);
        continue;
      }

      thread[[var_01["function"]]]();
    }
  }

  self.var_10707 = undefined;
  self.spawner = undefined;
}

func_4E47() {
  self waittill("death", var_00, var_01, var_02);
  level notify("ai_killed", self, var_00, var_01, var_02);
  if(!isDefined(self)) {
    return;
  }

  if(isDefined(var_00)) {
    scripts\anim\utility_common::repeater_headshot_ammo_passive(var_02, var_00, self);
    if(self.team == "axis" || self.team == "team3") {
      var_03 = undefined;
      if(isDefined(var_00.var_4F)) {
        if(isDefined(var_00.var_9F45) && var_00.var_9F45) {
          var_03 = "sentry";
        }

        if(isDefined(var_00.var_ED)) {
          var_03 = "destructible";
        }

        var_00 = var_00.var_4F;
      } else if(isDefined(var_00.triggerportableradarping)) {
        if(isai(var_00) && isplayer(var_00.triggerportableradarping)) {
          var_03 = "friendly";
        }

        var_00 = var_00.triggerportableradarping;
      } else if(isDefined(var_00.damageowner)) {
        if(isDefined(var_00.var_ED)) {
          var_03 = "destructible";
        }

        var_00 = var_00.damageowner;
      }

      var_04 = 0;
      if(isplayer(var_00)) {
        var_04 = 1;
      }

      if(isDefined(level.var_D5ED) && level.var_D5ED) {
        var_04 = 1;
      }

      if(var_04) {
        var_00 scripts\sp\player_stats::func_DEBD(self, var_01, var_02, var_03);
        return;
      }
    }
  }
}

func_1931() {
  self.var_4CF5 = [];
  for(;;) {
    self waittill("damage", var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);
    self.var_C873 = var_00;
    if(isDefined(var_01) && isplayer(var_01)) {
      var_0A = var_01 getcurrentweapon();
      if(isDefined(var_0A) && scripts\sp\utility::isprimaryweapon(var_0A) && isDefined(var_04) && var_04 == "MOD_PISTOL_BULLET" || var_04 == "MOD_RIFLE_BULLET") {
        var_01 thread scripts\sp\player_stats::func_DED8();
      }

      var_0B = getweaponbasename(var_0A);
      if(isDefined(var_0B) && var_0B == "iw7_m4" && scripts\sp\utility::func_9FFE(var_0A)) {
        thread func_11AD7(var_03);
      }
    }

    foreach(var_0D in self.var_4CF5) {
      thread[[var_0D]](var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);
    }

    if(!isalive(self) || self.var_EB) {
      break;
    }
  }
}

func_AD8E() {
  func_9769();
  if(isDefined(self.target)) {
    func_486E(self.target);
  }
}

func_486E(param_00) {
  var_01 = func_7CDA(param_00);
  if(var_01.size == 0) {
    return;
  }

  var_02 = -1;
  for(;;) {
    var_02++;
    if(var_02 >= var_01.size) {
      break;
    }

    var_03 = var_01[var_02];
    if(isDefined(var_03.var_4871)) {
      continue;
    }

    var_03.var_4871 = 1;
    level thread func_DFE2(var_03);
    if(isDefined(var_03.var_ED9E)) {
      if(!isDefined(level.flag[var_03.var_ED9E])) {
        scripts\engine\utility::flag_init(var_03.var_ED9E);
      }
    }

    if(isDefined(var_03.var_EDA0)) {
      if(!isDefined(level.flag[var_03.var_EDA0])) {
        scripts\engine\utility::flag_init(var_03.var_EDA0);
      }
    }

    if(isDefined(var_03.var_ED9B)) {
      if(!isDefined(level.flag[var_03.var_ED9B])) {
        scripts\engine\utility::flag_init(var_03.var_ED9B);
      }
    }

    if(isDefined(var_03.target)) {
      var_04 = func_7CDA(var_03.target);
      foreach(var_06 in var_04) {
        if(!isDefined(var_06.var_4871)) {
          var_01[var_01.size] = var_06;
        }
      }
    }
  }
}

func_DFE2(param_00) {
  waittillframeend;
  if(isDefined(param_00)) {
    param_00.var_4871 = undefined;
  }
}

func_107EC() {
  self.var_36B = 0;
  func_3DF4();
}

func_107ED() {
  if(self.unittype == "soldier" && !isDefined(level.var_55F0)) {
    thread func_5CEE();
  }

  func_3DF4();
  scripts\sp\utility::func_16B7(::scripts\sp\gameskill::func_2627);
  if(isDefined(self.var_ED3A)) {
    self.var_BC = self.var_ED3A;
  }
}

func_3DF4() {
  var_00["crew"] = 1;
  var_00["no_boost"] = 1;
  if(isDefined(self.subclass) && isDefined(var_00[self.subclass])) {
    self _meth_8504(0, "soldier_boost");
  }
}

func_107EF() {
  func_107ED();
  func_3DF4();
}

func_107EE() {
  func_3DF4();
}

func_10804() {}

func_10803() {
  self.var_C05C = 1;
  self.var_2894 = 1000;
  self.var_50 = 0.1;
}

func_107F4() {
  scripts\sp\gameskill::func_4FE9();
  scripts\sp\gameskill::objective_state_nomessage();
}

func_19BB() {
  if(!isalive(self)) {
    return;
  }

  if(self.health <= 1) {
    return;
  }

  self _meth_81D6();
  self waittill("death");
  if(!isDefined(self)) {
    return;
  }

  self _meth_81D5();
}

func_107F5() {
  if(isDefined(self.var_ED6B)) {
    self.var_596C = 1;
    self.var_ED6B = undefined;
  }

  if(isDefined(self.var_ED48)) {
    thread func_1936();
  }

  if(isDefined(self.var_ECFD)) {
    self.var_50 = self.var_ECFD;
    self.var_ECFD = undefined;
  }

  if(isDefined(self.var_EECC)) {
    thread func_10CC6();
    self.var_EECC = undefined;
  }

  if(isDefined(self.var_ED4B)) {
    thread deathtime();
  }

  if(isDefined(self.var_EE62)) {
    scripts\sp\utility::func_558D();
    self.var_EE62 = undefined;
  }

  if(isDefined(self.var_EE57)) {
    self.var_10264 = 1;
    self.var_EE57 = undefined;
  }

  if(isDefined(self.var_ECF8)) {
    self.var_1FBB = self.var_ECF8;
    self.var_ECF8 = undefined;
  }

  if(isDefined(self.var_EDFC)) {
    thread func_19BB();
  }

  if(isDefined(self.var_ED42)) {
    var_00 = self.var_ED42;
    if(var_00 == 1) {
      var_00 = 8;
    }

    scripts\sp\utility::func_61EB(var_00);
  }

  if(isDefined(self.var_ED89)) {
    self.setthermalbodymaterial = self.var_ED89;
  } else if(!self.isent) {
    self.setthermalbodymaterial = 512;
  }

  if(isDefined(self.var_EDAD)) {
    scripts\sp\utility::func_F3B5(self.var_EDAD);
  }

  if(isDefined(self.var_595C)) {
    self.iscinematicplaying = 0;
  }

  if(isDefined(self.var_ED99)) {
    self.logstring = self.var_ED99 == 1;
    self.var_ED99 = undefined;
  } else {
    self.logstring = self.team == "allies";
  }

  if(isDefined(self.var_EE54) && self.var_EE54 == 1) {
    self.var_C010 = 1;
    self.var_EE54 = undefined;
  }

  self.assertmsg = self.team == "allies" && self.logstring;
  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "mgpair") {
    thread scripts\sp\mg_penetration::func_491C();
  }

  if(isDefined(self.var_EDCF) && !(isDefined(self.var_EE2B) && self.var_EE2B == 1) || isDefined(self.var_EED1)) {
    thread func_F3DE();
  }

  if(isDefined(self.var_EEE2)) {
    self give_zombies_perk(self.var_EEE2);
  } else if(self.team == "neutral") {
    self give_zombies_perk("civilian");
  } else {
    self give_zombies_perk(self.team);
  }

  if(isDefined(self.var_ED17)) {
    scripts\sp\utility::func_F2DA(self.var_ED17);
  }

  if(isDefined(self.var_ECE5)) {
    self.var_2894 = self.var_ECE5;
    self.var_ECE5 = undefined;
  }

  if(isDefined(self.var_EDE4)) {
    self.ignoreme = 1;
    self.var_EDE4 = undefined;
  }

  if(isDefined(self.var_EDE2)) {
    self.precacherumble = 1;
    self.var_EDE2 = undefined;
  }

  if(isDefined(self.var_EDE3)) {
    self.precacheleaderboards = 1;
    self getplayerforguid();
  }

  if(isDefined(self.var_EE55)) {
    self.var_C012 = 1;
    self.var_EE55 = undefined;
  }

  if(isDefined(self.var_ED90)) {
    if(self.var_ED90 == "player") {
      self.loadstartpointtransients = level.player;
      level.player.var_336 = "player";
    }
  }

  if(isDefined(self.var_EEAA)) {
    self.maxsightdistsqrd = self.var_EEAA;
    self.var_EEAA = undefined;
  }

  if(isDefined(self.var_ED92)) {
    self.vectortoyaw = self.var_ED92;
    self.var_ED92 = undefined;
  }

  if(isDefined(self.var_EE10)) {
    self.vehicle_getarray = self.var_EE10;
    self.var_EE10 = undefined;
  }

  if(isDefined(self.var_EE05)) {
    self.a.disablelongdeath = 1;
    self.var_EE05 = undefined;
  }

  if(isDefined(self.var_ED5A)) {
    self.var_EF = 1;
    self.var_ED5A = undefined;
  }

  if(isDefined(self.var_EE5F)) {
    self.noragdoll = 1;
    self.var_EE5F = undefined;
  }

  if(isDefined(self.var_EE71)) {
    self.triggeroneoffradarsweep = 1;
    self.var_EE71 = undefined;
  }

  if(isDefined(self.var_ED22)) {
    scripts\sp\utility::func_B14F();
    self.var_ED22 = undefined;
  }

  if(isDefined(self.var_EEC8)) {
    self.health = self.var_EEC8;
    self.var_EEC8 = undefined;
  }

  if(isDefined(self.var_EE5A)) {
    self.var_C05C = self.var_EE5A;
    self.var_EE5A = undefined;
  }

  if(isDefined(self.var_ED56)) {
    scripts\sp\utility::func_51E1(self.var_ED56);
    self.var_ED56 = undefined;
  }

  if(scripts\sp\utility::func_93A6() && self.team == "axis") {
    self.var_2894 = self.var_2894 * 3.25;
    self.accuracy = self.accuracy * 3.25;
  }
}

func_10662() {
  if(isDefined(self.var_EEA6)) {
    self.var_3135.forceselfdestructtimer = gettime() + self.var_EEA6 * 1000;
    self.var_EEA6 = undefined;
    return;
  }

  if(isDefined(self.var_EEA5)) {
    self.var_3135.forceselfdestructtimer = 1;
    self.var_EEA5 = undefined;
  }
}

func_107F3(param_00) {
  thread func_1931();
  thread func_114E6();
  if(!isDefined(level.var_193D)) {
    self thermaldrawenable();
  }

  self.var_1086A = undefined;
  if(!isDefined(self.unique_id)) {
    scripts\sp\utility::func_F294();
  }

  thread func_4E47();
  level thread scripts\sp\friendlyfire::func_73B1(self);
  self.var_391 = 16;
  func_9709();
  func_107F4();
  func_107F5();
  switch (self.unittype) {
    case "c6":
      func_10662();
      break;
  }

  [
    [level.var_115BE[self.team]]
  ]();
  if(isDefined(level.var_12BA5[self.unittype])) {
    self thread[[level.var_12BA5[self.unittype]]]();
  }

  thread scripts\sp\damagefeedback::monitordamage();
  func_F3D8();
  if(isDefined(self.var_EE87)) {
    self setgoalentity(level.player);
    return;
  }

  if(isDefined(self.var_EED1)) {
    lib_0F18::func_10E8B("do_stealth");
    return;
  }

  if(isDefined(self.var_EE7E) && !isDefined(self.var_EE2B)) {
    thread scripts\sp\patrol::func_C97C();
    return;
  }

  if(isDefined(self.var_EE93) && self.var_EE93 == 1) {
    scripts\sp\utility::func_622F();
  }

  if(isDefined(self.var_ED53)) {
    if(!isDefined(self.script_radius)) {
      self.objective_playermask_showto = 800;
    }

    self setgoalentity(level.player);
    level thread func_50F5(self);
    return;
  }

  if(isDefined(self.used_an_mg42)) {
    return;
  }

  if(isDefined(self.var_EE2B) && self.var_EE2B == 1) {
    func_F3D7();
    self give_mp_super_weapon(self.origin);
    return;
  }

  if(!isDefined(self.var_EED1)) {}

  func_F3D7();
  if(isDefined(self.target)) {
    thread worldpointinreticle_circle();
  }
}

func_9709() {
  scripts\sp\utility::func_F340();
  if(isDefined(self.var_EDD2)) {
    self.objective_state = self.var_EDD2;
  } else {
    self.objective_state = 3;
  }

  if(isDefined(self.primaryweapon)) {
    self.noattackeraccuracymod = scripts\anim\utility_common::isasniper();
  }

  self.var_BEFA = 1;
}

func_EF8C() {
  if(self.team == "neutral") {
    self give_zombies_perk("civilian");
  } else {
    self give_zombies_perk(self.team);
  }

  func_9709();
  self.var_2894 = 1;
  scripts\sp\gameskill::objective_state_nomessage();
  scripts\sp\utility::func_414F();
  self.queuedialog = 96;
  self.disablearrivals = undefined;
  self.ignoreme = 0;
  self.precacheleaderboards = 0;
  self.var_33F = 0;
  self.triggeroneoffradarsweep = 0;
  self.unblockteamradar = 20;
  self.precachenightvisioncodeassets = 0;
  self.closefile = 1;
  self.ispreloadzonescomplete = 1;
  self.var_30 = 0;
  self.var_40 = 540;
  self.var_5E = 0.75;
  self.var_FE = 0;
  self.iscinematicloaded = 1;
  self.iscinematicplaying = 1;
  self.objective_playermask_showto = level.var_4FF6;
  self.objective_playermask_hidefrom = level.var_4FF5;
  self.precacherumble = 0;
  self _meth_8250(0);
  if(isDefined(self.var_B14F) && self.var_B14F) {
    scripts\sp\utility::func_1101B();
  }

  scripts\sp\utility::func_5575();
  self.maxsightdistsqrd = 67108864;
  self.script_forcegrenade = 0;
  self.var_391 = 16;
  self.closefile = 1;
  self.ispreloadzonescomplete = 1;
  scripts\anim\init::func_F2B0();
  self.logstring = self.team == "allies";
}

func_50F5(param_00) {
  param_00 endon("death");
  while(isalive(param_00)) {
    if(param_00.objective_playermask_showto > 200) {
      param_00.objective_playermask_showto = param_00.objective_playermask_showto - 200;
    }

    wait(6);
  }
}

func_6E4B(param_00) {
  self endon("death");
  if(!self.var_6E66) {
    param_00.used_an_mg42 = 1;
    self.var_6E66 = 1;
    param_00 waittill("death");
    self.var_6E66 = 0;
    self notify("get new user");
  }
}

func_F3DE() {
  self endon("death");
  waittillframeend;
  if(isDefined(self.team) && self.team == "allies") {
    self.logstring = 0;
  }

  var_00 = level.enableoffhandsecondaryweapons[self.var_EDCF];
  if(!isDefined(var_00)) {
    return;
  }

  if(isDefined(var_00.target)) {
    var_01 = getnode(var_00.target, "targetname");
    var_02 = getent(var_00.target, "targetname");
    var_03 = scripts\engine\utility::getstruct(var_00.target, "targetname");
    var_04 = undefined;
    if(isDefined(var_01)) {
      var_04 = var_01;
      self give_more_perk(var_04);
    } else if(isDefined(var_02)) {
      var_04 = var_02;
      self give_mp_super_weapon(var_04.origin);
    } else if(isDefined(var_03)) {
      var_04 = var_03;
      self give_mp_super_weapon(var_04.origin);
    }

    if(isDefined(var_04.fgetarg) && var_04.fgetarg != 0) {
      self.objective_playermask_showto = var_04.fgetarg;
    }

    if(isDefined(var_04.objective_playermask_hidefrom) && var_04.objective_playermask_hidefrom != 0) {
      self.objective_playermask_hidefrom = var_04.objective_playermask_hidefrom;
    }
  }

  if(isDefined(self.target)) {
    self _meth_82F0(var_00);
    return;
  }

  self _meth_82F1(var_00);
}

func_7CDA(param_00) {
  var_01 = getnodearray(param_00, "targetname");
  var_02 = scripts\engine\utility::getstructarray(param_00, "targetname");
  foreach(var_04 in var_02) {
    var_01[var_01.size] = var_04;
  }

  var_02 = getEntArray(param_00, "targetname");
  foreach(var_04 in var_02) {
    if(isspawner(var_04) || var_04.var_9F == "trigger_multiple" || var_04.var_9F == "trigger_once" || var_04.var_9F == "trigger_radius") {
      continue;
    }

    var_01[var_01.size] = var_04;
  }

  return var_01;
}

func_C035(param_00) {
  return isDefined(param_00.fgetarg) && param_00.fgetarg != 0;
}

worldpointinreticle_circle(param_00, param_01, param_02, param_03, param_04) {
  if(isDefined(self.used_an_mg42)) {
    return;
  }

  if(!isDefined(param_00)) {
    var_05 = func_7CDA(self.target);
    if(var_05.size == 0) {
      self notify("reached_path_end");
      return;
    }
  } else if(isarray(param_01)) {
    var_05 = param_01;
  } else {
    param_00[0] = param_01;
  }

  allowboostjump(var_05, param_02, param_03, param_04);
}

func_7A7B(param_00) {
  if(param_00.size == 1) {
    return param_00[0];
  }

  param_00 = scripts\engine\utility::array_randomize(param_00);
  var_01 = param_00[0];
  if(!isDefined(var_01.var_13070)) {
    var_01.var_13070 = 0;
  }

  foreach(var_03 in param_00) {
    if(!isDefined(var_03.var_13070)) {
      var_03.var_13070 = 0;
    }

    if(var_03.var_13070 < var_01.var_13070) {
      var_01 = var_03;
    }
  }

  var_01.var_13070 = gettime();
  return var_01;
}

allowboostjump(param_00, param_01, param_02, param_03) {
  self notify("stop_going_to_node");
  self endon("stop_going_to_node");
  self endon("death");
  var_04 = scripts\engine\utility::ter_op(isDefined(param_02), param_02, 300);
  for(;;) {
    param_00 = func_7A7B(param_00);
    if(isDefined(param_00.var_EE95)) {
      if(param_00.var_EE95 > 1) {
        var_04 = param_00.var_EE95;
      }

      param_00.var_EE95 = 0;
    }

    if(func_C035(param_00)) {
      self.objective_playermask_showto = param_00.fgetarg;
    }

    if(isDefined(param_00.height)) {
      self.objective_playermask_hidefrom = param_00.height;
    }

    if(isDefined(param_00.var_ED56)) {
      scripts\sp\utility::func_51E1(param_00.var_ED56);
    }

    if(isDefined(param_00.var_EE71)) {
      self.triggeroneoffradarsweep = param_00.var_EE71;
    }

    if(isDefined(param_00.var_EDE3)) {
      self.precacheleaderboards = param_00.var_EDE3;
    }

    if(isDefined(param_00.var_EDE4)) {
      self.ignoreme = param_00.var_EDE4;
    }

    if(isDefined(self.var_10E6D)) {
      lib_0F18::func_10E8A("go_to_node_wait", ::_meth_840F, param_00);
    } else {
      _meth_840F(param_00);
      self waittill("goal");
    }

    param_00 notify("trigger", self);
    if(isDefined(self.var_10E6D)) {
      lib_0F18::func_10E8A("go_to_node_arrive", ::_meth_840F, param_00);
    }

    if(isDefined(param_01)) {
      [
        [param_01]
      ](param_00);
    }

    if(isDefined(param_00.var_ED9E)) {
      scripts\engine\utility::flag_set(param_00.var_ED9E);
    }

    if(isDefined(param_00.var_ED80)) {
      scripts\sp\utility::func_65E1(param_00.var_ED80);
    }

    if(isDefined(param_00.var_ED9B)) {
      scripts\engine\utility::flag_clear(param_00.var_ED9B);
    }

    if(func_1157F(param_00)) {
      return 1;
    }

    param_00 scripts\sp\utility::script_delay();
    if(isDefined(param_00.script_soundalias)) {
      self playSound(param_00.script_soundalias);
    }

    if(isDefined(param_00.var_EDC7)) {
      thread scripts\sp\utility::func_77B7(param_00.var_EDC7);
    }

    if(isDefined(param_00.var_EDA0)) {
      scripts\engine\utility::flag_wait(param_00.var_EDA0);
    }

    if(isDefined(param_00.var_ED81)) {
      scripts\sp\utility::func_65E3(param_00.var_ED81);
    }

    param_00 scripts\sp\utility::func_EF15();
    if(isDefined(self.var_D6EE)) {
      [
        [self.var_D6EE]
      ]();
    }

    if(isDefined(param_00.script_delay_post)) {
      wait(param_00.script_delay_post);
    }

    while(isDefined(param_00.var_EE95)) {
      param_00.var_EE95 = 0;
      if(ishighjumping(param_00, ::func_7CDA, var_04)) {
        param_00.var_EE95 = 1;
        param_00 notify("script_requires_player");
        break;
      }

      wait(0.1);
    }

    if(isDefined(param_00.var_ED57)) {
      scripts\sp\utility::func_51E1(param_00.var_ED57);
    }

    if(isDefined(param_03)) {
      [
        [param_03]
      ](param_00);
    }

    if(isDefined(param_00.var_ED43) && param_00.var_ED43) {
      scripts\sp\utility::func_54C6();
    }

    if(isDefined(param_00.var_ED54) && param_00.var_ED54) {
      if(isDefined(self.var_B14F)) {
        scripts\sp\utility::func_1101B();
      }

      self delete();
    }

    if(!isDefined(param_00.target)) {
      break;
    }

    var_05 = func_7CDA(param_00.target);
    if(!var_05.size) {
      break;
    }

    param_00 = var_05;
  }

  self notify("reached_path_end");
  if(isDefined(self.var_EDB0)) {
    return;
  }

  if(isDefined(self.var_527B) && self.var_527B == "patrol") {
    return;
  }

  if(isDefined(self _meth_812A())) {
    self _meth_82F1(self _meth_812A());
    return;
  }

  self.objective_playermask_showto = level.var_4FF6;
}

ishighjumping(param_00, param_01, param_02) {
  foreach(var_04 in level.players) {
    if(distancesquared(var_04.origin, param_00.origin) < distancesquared(self.origin, param_00.origin)) {
      return 1;
    }
  }

  if(!isDefined(param_00.var_ED5F)) {
    var_06 = anglesToForward(self.angles);
    if(isDefined(param_00.target)) {
      var_07 = [
        [param_01]
      ](param_00.target);
      if(var_07.size == 1) {
        var_06 = vectornormalize(var_07[0].origin - param_00.origin);
      } else if(isDefined(param_00.angles)) {
        var_06 = anglesToForward(param_00.angles);
      }
    } else if(isDefined(param_00.angles)) {
      var_06 = anglesToForward(param_00.angles);
    }

    var_08 = [];
    foreach(var_04 in level.players) {
      var_08[var_08.size] = vectornormalize(var_04.origin - self.origin);
    }

    foreach(var_0C in var_08) {
      if(vectordot(var_06, var_0C) > 0) {
        return 1;
      }
    }
  }

  var_0E = param_02 * param_02;
  foreach(var_04 in level.players) {
    if(distancesquared(var_04.origin, self.origin) < var_0E) {
      return 1;
    }
  }

  return 0;
}

allowhighjump(param_00) {
  if(!isDefined(param_00)) {
    return 1;
  }

  if(!isDefined(param_00.target)) {
    return 1;
  }

  if(isDefined(param_00.script_delay)) {
    return 1;
  }

  if(isDefined(param_00.var_EF15)) {
    return 1;
  }

  if(isDefined(param_00.var_EF1A)) {
    return 1;
  }

  if(isDefined(param_00.var_EF1C)) {
    return 1;
  }

  if(isDefined(param_00.var_EF1B)) {
    return 1;
  }

  if(isDefined(param_00.var_EDA0)) {
    return 1;
  }

  if(isDefined(param_00.var_ED81)) {
    return 1;
  }

  if(isDefined(param_00.script_delay_post)) {
    return 1;
  }

  if(isDefined(param_00.var_EE95)) {
    return 1;
  }

  return 0;
}

_meth_840F(param_00) {
  if(isnode(param_00)) {
    _meth_8411(param_00);
  } else if(isstruct(param_00)) {
    allowdodge(param_00);
  } else if(isent(param_00)) {
    _meth_8410(param_00);
  }

  if(isstruct(param_00) || isnode(param_00)) {
    param_00.var_C9A7 = allowhighjump(param_00);
  }
}

_meth_8410(param_00) {
  if(param_00.classname == "info_volume") {
    self _meth_82F1(param_00);
    self notify("go_to_node_new_goal");
    return;
  }

  allowdodge(param_00);
}

allowdodge(param_00) {
  scripts\sp\utility::func_F3D3(param_00);
  self notify("go_to_node_new_goal");
}

_meth_8411(param_00) {
  scripts\sp\utility::func_F3D9(param_00);
  self notify("go_to_node_new_goal");
}

func_1157F(param_00) {
  if(!isDefined(param_00.target)) {
    return 0;
  }

  var_01 = getEntArray(param_00.target, "targetname");
  if(!var_01.size) {
    return 0;
  }

  var_02 = var_01[0];
  if(!issubstr(var_02.classname, "misc_turret")) {
    return 0;
  }

  thread func_12F9C(var_02);
  return 1;
}

func_F3D8() {
  if(isDefined(self.var_EDCD)) {
    self.objective_playermask_hidefrom = self.var_EDCD;
    return;
  }

  self.objective_playermask_hidefrom = level.var_4FF5;
}

func_F3D7(param_00) {
  if(isDefined(self.script_radius)) {
    self.objective_playermask_showto = self.script_radius;
    return;
  }

  if(isDefined(self.var_EDB0)) {
    if(isDefined(param_00) && isDefined(param_00.fgetarg)) {
      self.objective_playermask_showto = param_00.fgetarg;
      return;
    }
  }

  if(!isDefined(self _meth_812A())) {
    if(self.type == "civilian") {
      self.objective_playermask_showto = 128;
      return;
    }

    self.objective_playermask_showto = level.var_4FF6;
  }
}

func_2697(param_00) {
  for(;;) {
    var_01 = self _meth_8165();
    if(!isalive(var_01)) {
      wait(1.5);
      continue;
    }

    if(!isDefined(var_01.isnodeoccupied)) {
      self settargetentity(scripts\engine\utility::random(param_00));
      self notify("startfiring");
      self _meth_8398();
    }

    wait(2 + randomfloat(1));
  }
}

func_B321(param_00) {
  for(;;) {
    self settargetentity(scripts\engine\utility::random(param_00));
    self notify("startfiring");
    self _meth_8398();
    wait(2 + randomfloat(1));
  }
}

func_12F9C(param_00) {
  self endon("stop_using_turret");
  self endon("death");
  if(self gettargetchargepos() && self.health == 150) {
    self.health = 100;
    self.a.disablelongdeath = 1;
  }

  scripts\asm\asm_bb::func_296E(param_00);
  while(!isDefined(self _meth_8164()) || self _meth_8164() != param_00) {
    wait(0.05);
  }

  if(isDefined(param_00.target) && param_00.target != param_00.var_336) {
    var_01 = getEntArray(param_00.target, "targetname");
    var_02 = [];
    for(var_03 = 0; var_03 < var_01.size; var_03++) {
      if(var_01[var_03].classname == "script_origin") {
        var_02[var_02.size] = var_01[var_03];
      }
    }

    if(isDefined(param_00.var_ED0F)) {
      param_00 thread func_2697(var_02);
    } else if(isDefined(param_00.var_EE07)) {
      param_00 give_player_session_tokens("manual_ai");
      param_00 thread func_B321(var_02);
    } else if(var_02.size > 0) {
      if(var_02.size == 1) {
        param_00.var_B319 = var_02[0];
        param_00 settargetentity(var_02[0]);
        thread scripts\sp\mgturret::func_B31A(param_00);
      } else {
        param_00 thread scripts\sp\mgturret::func_B6A8(var_02);
      }
    }
  }

  thread func_D31C(param_00);
  thread scripts\sp\mgturret::func_B6A3(param_00);
  param_00 notify("startfiring");
}

func_D31C(param_00) {
  self endon("death");
  if(self.team != "allies") {
    return;
  }

  var_01 = spawn("trigger_radius", param_00.origin, 0, 56, 56);
  thread scripts\engine\utility::delete_on_death(var_01);
  var_02 = 0;
  while(!var_02) {
    var_01 waittill("trigger");
    while(level.player istouching(var_01)) {
      if(level.player usebuttonpressed()) {
        var_02 = 1;
        break;
      }

      wait(0.05);
    }
  }

  var_01 delete();
  func_11054();
}

func_11054() {
  self notify("stop_using_turret");
  self notify("stop_using_built_in_burst_fire");
  var_00 = self _meth_8164();
  if(!isDefined(var_00)) {
    return;
  }

  self _meth_83AF();
  scripts\asm\asm_bb::func_296E(undefined);
  self givescorefortrophyblocks();
  var_00 givesentry();
}

func_73D9(param_00) {
  var_01 = getnode(param_00.target, "targetname");
  var_02 = getent(var_01.target, "targetname");
  var_02 give_player_session_tokens("auto_ai");
  var_02 cleartargetentity();
  var_03 = 0;
  for(;;) {
    param_00 waittill("trigger", var_04);
    if(!isai(var_04)) {
      continue;
    }

    if(!isDefined(var_04.team)) {
      continue;
    }

    if(var_04.team != "allies") {
      continue;
    }

    if(isDefined(var_04.var_EF00) && var_04.var_EF00 == 0) {
      continue;
    }

    if(var_04 thread func_73D7(var_02, var_01)) {
      var_04 thread func_73D6(var_02, var_01);
      var_02 waittill("friendly_finished_using_mg42");
      if(isalive(var_04)) {
        var_04.var_12A4D = gettime() + 10000;
      }
    }

    wait(1);
  }
}

func_73D2(param_00, param_01) {
  param_01 endon("friendly_finished_using_mg42");
  param_00 waittill("death");
  param_01 notify("friendly_finished_using_mg42");
}

func_73D8(param_00) {
  param_00 endon("friendly_finished_using_mg42");
  self.var_369 = 1;
  self setcursorhint("HINT_NOICON");
  self sethintstring(&"PLATFORM_USEAIONMG42");
  self waittill("trigger");
  self.var_369 = 0;
  self sethintstring("");
  self _meth_83AF();
  self notify("stopped_use_turret");
  param_00 notify("friendly_finished_using_mg42");
}

func_73D7(param_00, param_01) {
  if(self.var_369) {
    return 0;
  }

  if(isDefined(self.var_12A4D) && gettime() < self.var_12A4D) {
    return 0;
  }

  if(distance(level.player.origin, param_01.origin) < 100) {
    return 0;
  }

  return 1;
}

func_73D4(param_00, param_01) {
  param_00 endon("friendly_finished_using_mg42");
  self waittill("trigger");
  param_00 notify("friendly_finished_using_mg42");
}

func_73D5() {
  if(!isDefined(self.var_73D0)) {
    return;
  }

  self.var_73D0 notify("friendly_finished_using_mg42");
}

func_C05F() {
  self endon("death");
  self waittill("goal");
  self.objective_playermask_showto = self.oldradius;
  if(self.objective_playermask_showto < 32) {
    self.objective_playermask_showto = 400;
  }
}

func_73D6(param_00, param_01) {
  self endon("death");
  param_00 endon("friendly_finished_using_mg42");
  level thread func_73D2(self, param_00);
  self.oldradius = self.objective_playermask_showto;
  self.objective_playermask_showto = 28;
  thread func_C05F();
  self give_more_perk(param_01);
  self.precacherumble = 1;
  self waittill("goal");
  self.objective_playermask_showto = self.oldradius;
  if(self.objective_playermask_showto < 32) {
    self.objective_playermask_showto = 400;
  }

  self.precacherumble = 0;
  self.objective_playermask_showto = self.oldradius;
  if(distance(level.player.origin, param_01.origin) < 32) {
    param_00 notify("friendly_finished_using_mg42");
    return;
  }

  self.var_73D0 = param_00;
  thread func_73D8(param_00);
  thread func_73D1(param_00);
  self _meth_83D7(param_00);
  if(isDefined(param_00.target)) {
    var_02 = getent(param_00.target, "targetname");
    if(isDefined(var_02)) {
      var_02 thread func_73D4(param_00, self);
    }
  }

  for(;;) {
    if(distance(self.origin, param_01.origin) < 32) {
      self _meth_83D7(param_00);
    } else {
      break;
    }

    wait(1);
  }

  param_00 notify("friendly_finished_using_mg42");
}

func_73D1(param_00) {
  self endon("death");
  param_00 waittill("friendly_finished_using_mg42");
  func_73D3();
}

func_73D3() {
  self endon("death");
  var_00 = self.var_73D0;
  self.var_73D0 = undefined;
  self _meth_83AF();
  self notify("stopped_use_turret");
  self.var_369 = 0;
  self.objective_playermask_showto = self.oldradius;
  if(!isDefined(var_00)) {
    return;
  }

  if(!isDefined(var_00.target)) {
    return;
  }

  var_01 = getnode(var_00.target, "targetname");
  var_02 = self.objective_playermask_showto;
  self.objective_playermask_showto = 8;
  self give_more_perk(var_01);
  wait(2);
  self.objective_playermask_showto = 384;
  self waittill("goal");
  if(isDefined(self.target)) {
    var_01 = getnode(self.target, "targetname");
    if(isDefined(var_01.target)) {
      var_01 = getnode(var_01.target, "targetname");
    }

    if(isDefined(var_01)) {
      self give_more_perk(var_01);
    }
  }

  self.objective_playermask_showto = var_02;
}

func_114E6() {
  if(isDefined(level.var_C0B5)) {
    return;
  }

  if(isDefined(level.vehicle.var_8BBA) && !level.vehicle.var_8BBA) {
    return;
  }

  scripts\sp\utility::func_16B7(::func_114E7);
}

func_114E7(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  if(!isDefined(self)) {
    return;
  }

  if(isalive(self)) {
    return;
  }

  if(!isalive(param_01)) {
    return;
  }

  if(!isDefined(param_01.var_380)) {
    return;
  }

  if(param_01 scripts\sp\vehicle::func_9E2C()) {
    return;
  }

  if(!isDefined(self.noragdoll)) {
    if(isDefined(self.var_71C8)) {
      self[[self.var_71C8]]();
    }

    self giverankxp();
  }

  if(!isDefined(self)) {
    return;
  }

  scripts\sp\utility::func_DFE6(::func_114E7);
}

func_6F4C(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 0;
  }

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "instant_respawn") {
    param_00 = 1;
  }

  level.var_10881 = [];
  var_01 = getspawnerarray(self.target);
  scripts\engine\utility::array_thread(var_01, ::func_6F50, param_00);
  var_02 = 0;
  var_03 = 0;
  for(;;) {
    self waittill("trigger", var_04);
    if(!var_03) {
      var_03 = 1;
      scripts\sp\utility::script_delay();
    }

    if(self istouching(level.player)) {
      var_02 = 1;
    } else {
      if(!isalive(var_04)) {
        continue;
      }

      if(isplayer(var_04)) {
        var_02 = 1;
      } else if(!isDefined(var_04.var_9F73) || !var_04.var_9F73) {
        continue;
      }
    }

    var_01 = getspawnerarray(self.target);
    if(isDefined(var_01[0])) {
      if(isDefined(var_01[0].var_EE91)) {
        func_4B09(var_01[0].var_EE91);
      }
    }

    var_01 = getspawnerarray(self.target);
    for(var_05 = 0; var_05 < var_01.size; var_05++) {
      var_01[var_05].var_D43F = var_02;
      var_01[var_05] notify("flood_begin");
    }

    if(var_02) {
      wait(5);
      continue;
    }

    wait(0.1);
  }
}

func_6F50(param_00) {
  if(isDefined(self.var_F0DC)) {
    return;
  }

  self.var_F0DC = 1;
  self.var_127CC = 1;
  var_01 = self.target;
  var_02 = self.var_336;
  if(!isDefined(var_01) && !isDefined(self.var_EE2B)) {
    waittillframeend;
  }

  var_03 = [];
  if(isDefined(var_01)) {
    var_04 = getspawnerarray(var_01);
    for(var_05 = 0; var_05 < var_04.size; var_05++) {
      if(!issubstr(var_04[var_05].classname, "actor")) {
        continue;
      }

      var_03[var_03.size] = var_04[var_05];
    }
  }

  var_06 = spawnStruct();
  var_07 = self.origin;
  func_6F51(var_06, var_03.size > 0, param_00);
  if(isalive(var_06.var_1912)) {
    var_06.var_1912 waittill("death");
  }

  if(!isDefined(var_01)) {
    return;
  }

  var_04 = getspawnerarray(var_01);
  if(!var_04.size) {
    return;
  }

  for(var_05 = 0; var_05 < var_04.size; var_05++) {
    if(!issubstr(var_04[var_05].classname, "actor")) {
      continue;
    }

    var_04[var_05].var_336 = var_02;
    var_08 = var_01;
    if(isDefined(var_04[var_05].target)) {
      var_09 = getspawner(var_04[var_05].target, "targetname");
      if(!isDefined(var_09) || !issubstr(var_09.classname, "actor")) {
        var_08 = var_04[var_05].target;
      }
    }

    var_04[var_05].target = var_08;
    var_04[var_05] thread func_6F50(param_00);
    var_04[var_05].var_D43F = 1;
    var_04[var_05] notify("flood_begin");
  }
}

func_6F51(param_00, param_01, param_02) {
  self endon("death");
  var_03 = self.var_C1;
  if(!param_01) {
    param_01 = isDefined(self.script_noteworthy) && self.script_noteworthy == "delete";
  }

  scripts\sp\utility::func_F311(2);
  if(isDefined(self.script_delay)) {
    var_04 = self.script_delay;
  } else {
    var_04 = 0;
  }

  for(;;) {
    self waittill("flood_begin");
    if(self.var_D43F) {
      break;
    }

    if(var_04) {
      continue;
    }

    break;
  }

  var_05 = distance(level.player.origin, self.origin);
  while(var_03) {
    self.var_12844 = var_03;
    scripts\sp\utility::func_F311(2);
    wait(var_04);
    var_06 = isDefined(self.var_EED1) && scripts\engine\utility::flag("stealth_enabled") && !scripts\engine\utility::flag("stealth_spotted");
    if(isDefined(self.var_EDB3)) {
      var_07 = self _meth_8393(var_06);
    } else {
      var_07 = self dospawn(var_06);
    }

    if(scripts\sp\utility::func_106ED(var_07)) {
      var_08 = 0;
      if(var_04 < 2) {
        wait(2);
      }

      continue;
    } else {
      if(isDefined(self.var_ED39)) {
        if(self.var_ED39 == "heat") {
          var_07 scripts\sp\utility::func_61FF();
        }

        if(self.var_ED39 == "cqb") {
          var_07 scripts\sp\utility::func_61E7();
        }
      }

      thread func_1865(var_07);
      var_07 thread func_6F4D(self);
      if(isDefined(self.var_ECE5)) {
        var_07.var_2894 = self.var_ECE5;
      }

      param_00.var_1912 = var_07;
      param_00 notify("got_ai");
      self waittill("spawn_died", var_09, var_08);
      if(var_04 > 2) {
        var_04 = randomint(4) + 2;
      } else {
        var_04 = 0.5 + randomfloat(0.5);
      }
    }

    if(var_09) {
      func_13840(var_05);
      continue;
    }

    if(func_D462(var_08 || param_01, param_00.var_1912)) {
      var_03--;
    }

    if(!param_02) {
      func_13851();
    }
  }

  self delete();
}

func_1382E(param_00) {
  self endon("death");
  param_00 waittill("death");
}

func_1865(param_00) {
  var_01 = self.var_336;
  if(!isDefined(level.var_10881[var_01])) {
    level.var_10881[var_01] = spawnStruct();
    level.var_10881[var_01] scripts\sp\utility::func_F311(0);
    level.var_10881[var_01].var_11A1D = 0;
  }

  if(!isDefined(self.var_17C5)) {
    self.var_17C5 = 1;
    level.var_10881[var_01].var_11A1D++;
  }

  level.var_10881[var_01].var_C1++;
  func_1382E(param_00);
  level.var_10881[var_01].var_C1--;
  if(!isDefined(self)) {
    level.var_10881[var_01].var_11A1D--;
  }

  if(level.var_10881[var_01].var_11A1D) {
    if(level.var_10881[var_01].var_C1 / level.var_10881[var_01].var_11A1D < 0.32) {
      level.var_10881[var_01] notify("waveReady");
    }
  }
}

func_13851() {
  var_00 = self.var_336;
  if(level.var_10881[var_00].var_C1) {
    level.var_10881[var_00] waittill("waveReady");
  }
}

func_D462(param_00, param_01) {
  if(param_00) {
    return 1;
  }

  if(isDefined(param_01) && isDefined(param_01.origin)) {
    var_02 = param_01.origin;
  } else {
    var_02 = self.origin;
  }

  if(distance(level.player.origin, var_02) < 700) {
    return 1;
  }

  return bullettracepassed(level.player getEye(), param_01 getEye(), 0, undefined);
}

func_13840(param_00) {
  self endon("flood_begin");
  param_00 = param_00 * 0.75;
  while(distance(level.player.origin, self.origin) > param_00) {
    wait(1);
  }
}

func_6F4D(param_00) {
  thread func_6F4E();
  self waittill("death", var_01);
  var_02 = isalive(var_01) && isplayer(var_01);
  if(!var_02 && isDefined(var_01) && var_01.classname == "worldspawn") {
    var_02 = 1;
  }

  var_03 = !isDefined(self);
  param_00 notify("spawn_died", var_03, var_02);
}

func_6F4E() {
  if(isDefined(self.var_EE2B)) {
    return;
  }

  self endon("death");
  var_00 = getnode(self.target, "targetname");
  if(isDefined(var_00)) {
    self give_more_perk(var_00);
  } else {
    var_00 = getent(self.target, "targetname");
    if(isDefined(var_00)) {
      self give_mp_super_weapon(var_00.origin);
    }
  }

  if(isDefined(level.var_6BDF)) {
    self.vectortoyaw = level.var_6BDF;
    self.vehicle_getarray = level.var_B491;
  }

  if(isDefined(var_00.fgetarg) && var_00.fgetarg >= 0) {
    self.objective_playermask_showto = var_00.fgetarg;
  } else {
    self.objective_playermask_showto = 256;
  }

  self waittill("goal");
  while(isDefined(var_00.target)) {
    var_01 = getnode(var_00.target, "targetname");
    if(isDefined(var_01)) {
      var_00 = var_01;
    } else {
      break;
    }

    self give_more_perk(var_00);
    if(func_C035(var_00)) {
      self.objective_playermask_showto = var_00.fgetarg;
    } else {
      self.objective_playermask_showto = 256;
    }

    self waittill("goal");
  }

  if(isDefined(self.script_noteworthy)) {
    if(self.script_noteworthy == "delete") {
      self _meth_81D0();
      return;
    }
  }

  if(isDefined(var_00.target)) {
    var_02 = getent(var_00.target, "targetname");
    if(isDefined(var_02) && var_02.var_9F == "misc_turret") {
      self give_more_perk(var_00);
      self.objective_playermask_showto = 4;
      self waittill("goal");
      if(!isDefined(self.var_EDB0)) {
        self.objective_playermask_showto = level.var_4FF6;
      }

      func_12F9C(var_02);
    }
  }

  if(isDefined(self.script_noteworthy)) {
    if(self.script_noteworthy == "hide") {
      thread scripts\sp\utility::func_F2DA(0);
      return;
    }
  }

  if(!isDefined(self.var_EDB0) && !isDefined(self _meth_812A())) {
    self.objective_playermask_showto = level.var_4FF6;
  }
}

enableoffhandsecondaryweapons() {
  var_00 = getEntArray("info_volume", "classname");
  level.var_4E32 = [];
  level.enableoffhandsecondaryweapons = [];
  for(var_01 = 0; var_01 < var_00.size; var_01++) {
    var_02 = var_00[var_01];
    if(isDefined(var_02.var_ED47)) {
      level.var_4E32[var_02.var_ED47] = var_02;
    }

    if(isDefined(var_02.var_EDCF)) {
      level.enableoffhandsecondaryweapons[var_02.var_EDCF] = var_02;
    }
  }
}

func_1A12(param_00) {
  level.var_1162[param_00] = spawnStruct();
  level.var_1162[param_00].var_1A09 = 0;
  level.var_1162[param_00].var_1A0D = 0;
  level.var_1162[param_00].var_10878 = 0;
  level.var_1162[param_00].var_1912 = [];
  level.var_1162[param_00].spawners = [];
}

func_1A17(param_00) {
  self endon("death");
  self.decremented = 0;
  param_00.var_10878++;
  param_00.spawners = scripts\engine\utility::array_add(param_00.spawners, self);
  thread func_1A15(param_00);
  thread func_1A16(param_00);
  while(self.var_C1) {
    self waittill("spawned", var_01);
    if(scripts\sp\utility::func_106ED(var_01)) {
      continue;
    }

    var_01 thread func_1A14(param_00);
  }

  waittillframeend;
  if(self.decremented) {
    return;
  }

  self.decremented = 1;
  param_00.var_10878--;
}

func_1A15(param_00) {
  self waittill("death");
  if(isDefined(self) && self.decremented) {
    return;
  }

  param_00.var_10878--;
}

func_1A16(param_00) {
  self endon("death");
  self waittill("emptied spawner");
  waittillframeend;
  if(self.decremented) {
    return;
  }

  self.decremented = 1;
  param_00.var_10878--;
}

func_1A14(param_00) {
  param_00.var_1A09++;
  param_00.var_1912[param_00.var_1912.size] = self;
  if(isDefined(self.var_ED49)) {
    func_1382D();
  } else {
    self waittill("death");
  }

  param_00.var_1A09--;
  param_00.var_1A0D++;
}

camper_trigger_think(param_00) {
  var_01 = strtok(param_00.script_linkto, " ");
  var_02 = [];
  var_03 = [];
  for(var_04 = 0; var_04 < var_01.size; var_04++) {
    var_05 = var_01[var_04];
    var_06 = getspawner(var_05, "script_linkname");
    if(isDefined(var_06)) {
      var_02 = scripts\engine\utility::array_add_safe(var_02, var_06);
      continue;
    }

    var_07 = getnode(var_05, "script_linkname");
    if(!isDefined(var_07)) {
      continue;
    }

    var_03 = scripts\engine\utility::array_add_safe(var_03, var_07);
  }

  param_00 waittill("trigger");
  var_03 = scripts\engine\utility::array_randomize(var_03);
  for(var_04 = 0; var_04 < var_03.size; var_04++) {
    var_03[var_04].claimed = 0;
  }

  var_08 = 0;
  for(var_04 = 0; var_04 < var_02.size; var_04++) {
    var_09 = var_02[var_04];
    if(!isDefined(var_09)) {
      continue;
    }

    if(isDefined(var_09.var_EEB3)) {
      continue;
    }

    while(isDefined(var_03[var_08].script_noteworthy) && var_03[var_08].script_noteworthy == "dont_spawn") {
      var_08++;
    }

    var_09.origin = var_03[var_08].origin;
    var_09.angles = var_03[var_08].angles;
    var_09 scripts\sp\utility::func_1747(::func_3FEF, var_03[var_08]);
    var_08++;
  }

  scripts\engine\utility::array_thread(var_02, ::scripts\sp\utility::func_1747, ::func_37E9);
  scripts\engine\utility::array_thread(var_02, ::scripts\sp\utility::func_1747, ::func_BC9F, var_03);
  scripts\engine\utility::array_thread(var_02, ::scripts\sp\utility::func_10619);
}

func_37E9() {
  self.objective_playermask_showto = 8;
  self.logstring = 1;
}

func_BC9F(param_00) {
  self endon("death");
  var_01 = 0;
  for(;;) {
    if(!isalive(self.isnodeoccupied)) {
      self waittill("enemy");
      var_01 = 0;
      continue;
    }

    if(isplayer(self.isnodeoccupied)) {
      if(self.isnodeoccupied scripts\sp\utility::func_65DB("player_has_red_flashing_overlay") || scripts\engine\utility::flag("player_flashed")) {
        self.logstring = 0;
        for(;;) {
          self.objective_playermask_showto = 180;
          self give_mp_super_weapon(level.player.origin);
          wait(1);
        }

        return;
      }
    }

    if(var_01) {
      if(self getpersstat(self.isnodeoccupied)) {
        wait(0.05);
        continue;
      }

      var_01 = 0;
    } else {
      if(self getpersstat(self.isnodeoccupied)) {
        var_01 = 1;
      }

      wait(0.05);
      continue;
    }

    if(randomint(3) > 0) {
      var_02 = func_6CA6(param_00);
      if(isDefined(var_02)) {
        func_3FEF(var_02, self.var_3FF3);
        self waittill("goal");
      }
    }
  }
}

func_3FEF(param_00, param_01) {
  self give_more_perk(param_00);
  self.var_3FF3 = param_00;
  param_00.claimed = 1;
  if(isDefined(param_01)) {
    param_01.claimed = 0;
  }
}

func_6CA6(param_00) {
  for(var_01 = 0; var_01 < param_00.size; var_01++) {
    if(param_00[var_01].claimed) {
      continue;
    } else {
      return param_00[var_01];
    }
  }

  return undefined;
}

func_6F5D(param_00) {
  var_01 = getspawnerarray(param_00.target);
  scripts\engine\utility::array_thread(var_01, ::func_6F59);
  param_00 waittill("trigger");
  var_01 = getspawnerarray(param_00.target);
  scripts\engine\utility::array_thread(var_01, ::func_6F5C, param_00);
}

func_6F59() {}

func_1278B(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  return isDefined(param_00.var_EE95);
}

func_6F5C(param_00) {
  if(!isDefined(level.var_107A7) || isspawner(self)) {
    self endon("death");
  }

  self notify("stop current floodspawner");
  self endon("stop current floodspawner");
  if(func_9C98()) {
    func_DB3D(param_00);
    return;
  }

  var_01 = func_1278B(param_00);
  scripts\sp\utility::script_delay();
  if(isDefined(level.var_107A7)) {
    if(!isspawner(self)) {
      self.var_C1 = 1;
    }
  }

  while(self.var_C1 > 0) {
    while(var_01 && !level.player istouching(param_00)) {
      wait(0.5);
    }

    var_02 = isDefined(self.var_EED1) && scripts\engine\utility::flag("stealth_enabled") && !scripts\engine\utility::flag("stealth_spotted");
    var_03 = self;
    if(isDefined(level.var_107A7)) {
      if(!isspawner(self)) {
        var_03 = func_7C86(self, 1);
      }
    }

    if(isDefined(self.var_EDB3)) {
      var_04 = var_03 _meth_8393(var_02);
    } else {
      var_04 = var_03 dospawn(var_02);
    }

    if(scripts\sp\utility::func_106ED(var_04)) {
      wait(2);
      continue;
    }

    if(isDefined(self.var_ED39)) {
      if(self.var_ED39 == "heat") {
        var_04 scripts\sp\utility::func_61FF();
      }

      if(self.var_ED39 == "cqb") {
        var_04 scripts\sp\utility::func_61E7();
      }
    }

    var_04 thread func_DF23(self);
    var_04 waittill("death", var_05);
    if(!func_D27A(var_04, var_05)) {
      self.var_C1++;
    }

    if(!isDefined(var_04)) {
      continue;
    }

    if(!scripts\sp\utility::func_EF15()) {
      wait(randomfloatrange(5, 9));
    }
  }
}

func_D27A(param_00, param_01) {
  if(isDefined(self.var_EDAA)) {
    if(self.var_EDAA) {
      return 1;
    }
  }

  if(!isDefined(param_00)) {
    return 0;
  }

  if(isalive(param_01)) {
    if(isplayer(param_01)) {
      return 1;
    }

    if(distance(param_01.origin, level.player.origin) < 200) {
      return 1;
    }
  } else if(isDefined(param_01)) {
    if(param_01.classname == "worldspawn") {
      return 0;
    }

    if(distance(param_01.origin, level.player.origin) < 200) {
      return 1;
    }
  }

  if(distance(param_00.origin, level.player.origin) < 200) {
    return 1;
  }

  return bullettracepassed(level.player getEye(), param_00 getEye(), 0, undefined);
}

func_9C98() {
  if(!isDefined(self.target)) {
    return 0;
  }

  var_00 = getspawnerarray(self.target);
  if(!var_00.size) {
    return 0;
  }

  return issubstr(var_00[0].classname, "actor");
}

func_DB3C(param_00) {
  param_00.var_1060E waittill("death");
  self notify("death_report");
}

func_DB3D(param_00) {
  self endon("death");
  var_01 = func_1278B(param_00);
  scripts\sp\utility::script_delay();
  if(var_01) {
    while(!level.player istouching(param_00)) {
      wait(0.5);
    }
  }

  var_02 = getspawnerarray(self.target);
  self.spawners = 0;
  scripts\engine\utility::array_thread(var_02, ::func_DB3F, self);
  var_04 = randomint(var_02.size);
  for(var_03 = 0; var_03 < var_02.size; var_03++) {
    if(self.var_C1 <= 0) {
      return;
    }

    var_04++;
    if(var_04 >= var_02.size) {
      var_04 = 0;
    }

    var_05 = var_02[var_04];
    var_05 scripts\sp\utility::func_F311(1);
    var_06 = var_05 scripts\sp\utility::func_10619();
    if(scripts\sp\utility::func_106ED(var_06)) {
      wait(2);
      continue;
    }

    self.var_C1--;
    var_05.var_1060E = var_06;
    var_06 thread func_DF23(self);
    var_06 thread func_6985(param_00);
    thread func_DB3C(var_05);
  }

  var_07 = 0.01;
  while(self.var_C1 > 0) {
    self waittill("death_report");
    scripts\sp\utility::func_EF15();
    var_04 = randomint(var_02.size);
    for(var_03 = 0; var_03 < var_02.size; var_03++) {
      var_02 = scripts\engine\utility::array_removeundefined(var_02);
      if(!var_02.size) {
        if(isDefined(self)) {
          self delete();
        }

        return;
      }

      var_04++;
      if(var_04 >= var_02.size) {
        var_04 = 0;
      }

      var_05 = var_02[var_04];
      if(isalive(var_05.var_1060E)) {
        continue;
      }

      if(isDefined(var_05.target)) {
        self.target = var_05.target;
      } else {
        self.target = undefined;
      }

      var_06 = scripts\sp\utility::func_10619();
      if(scripts\sp\utility::func_106ED(var_06)) {
        wait(2);
        continue;
      }

      var_06 thread func_DF23(self);
      var_06 thread func_6985(param_00);
      var_05.var_1060E = var_06;
      thread func_DB3C(var_05);
      if(self.var_C1 <= 0) {
        return;
      }
    }
  }
}

func_DB3F(param_00) {
  param_00 endon("death");
  param_00.spawners++;
  self waittill("death");
  param_00.spawners--;
  if(!param_00.spawners) {
    param_00 delete();
  }
}

func_6985(param_00) {
  if(isDefined(self.var_EDB0)) {
    return;
  }

  var_01 = level.var_4FF6;
  if(isDefined(param_00)) {
    if(isDefined(param_00.script_radius)) {
      if(param_00.script_radius == -1) {
        return;
      }

      var_01 = param_00.script_radius;
    }
  }

  if(isDefined(self.var_EDB0)) {
    return;
  }

  self endon("death");
  self waittill("goal");
  self.objective_playermask_showto = var_01;
}

func_100C6() {}

func_DC9B(param_00) {
  param_00 waittill("trigger");
  var_01 = getspawnerarray(param_00.target);
  if(!var_01.size) {
    return;
  }

  var_02 = scripts\engine\utility::random(var_01);
  var_01 = [];
  var_01[var_01.size] = var_02;
  if(isDefined(var_02.script_linkto)) {
    var_03 = strtok(var_02.script_linkto, " ");
    for(var_04 = 0; var_04 < var_03.size; var_04++) {
      var_01[var_01.size] = getspawner(var_03[var_04], "script_linkname");
    }
  }

  waittillframeend;
  scripts\engine\utility::array_thread(var_01, ::scripts\sp\utility::func_1747, ::func_2BD0);
  scripts\engine\utility::array_thread(var_01, ::scripts\sp\utility::func_10619);
}

func_2BD0() {
  if(isDefined(self.var_EDB0)) {
    return;
  }

  self endon("death");
  self waittill("reached_path_end");
  if(!isDefined(self _meth_812A())) {
    self.objective_playermask_showto = level.var_4FF6;
  }
}

func_1085E(param_00) {
  var_01 = param_00 giveplayeraccessory();
  if(var_01.var_394 != "none") {
    var_02 = getweaponmodel(var_01.var_394);
    var_01 attach(var_02, "tag_weapon_right");
    var_03 = getweaponhidetags(var_01.var_394);
    for(var_04 = 0; var_04 < var_03.size; var_04++) {
      var_01 hidepart(var_03[var_04], var_02);
    }
  }

  var_01.spawner = param_00;
  var_01.var_5BF2 = isDefined(param_00.script_noteworthy) && param_00.script_noteworthy == "drone_delete_on_unload";
  var_01.var_6CDA = 1;
  var_01 notify("finished spawning");
  param_00 notify("drone_spawned", var_01);
  return var_01;
}

func_10869(param_00, param_01) {
  if(!isDefined(param_00.spawner)) {}

  var_02 = param_00.spawner.origin;
  var_03 = param_00.spawner.angles;
  var_04 = param_00.spawner.target;
  param_00.spawner.origin = param_00.origin;
  param_00.spawner.angles = param_00.angles;
  if(isDefined(param_01)) {
    param_00.spawner.target = param_01;
  }

  param_00.spawner.var_C1 = param_00.spawner.var_C1 + 1;
  var_05 = param_00.spawner _meth_8393();
  var_06 = scripts\sp\utility::func_106ED(var_05);
  if(var_06) {}

  var_05.var_131F5 = param_00.var_131F5;
  var_05.var_1321D = param_00.var_1321D;
  var_05.var_10B71 = param_00.var_10B71;
  var_05.var_72A4 = param_00.var_72A4;
  param_00.spawner.origin = var_02;
  param_00.spawner.angles = var_03;
  param_00.spawner.target = var_04;
  param_00 delete();
  return var_05;
}

func_10868(param_00, param_01) {
  if(!isDefined(param_00.spawner)) {}

  var_02 = param_00.spawner.origin;
  var_03 = param_00.spawner.angles;
  var_04 = param_00.spawner.target;
  param_00.spawner.origin = param_00.origin;
  param_00.spawner.angles = param_00.angles;
  if(isDefined(param_01)) {
    param_00.spawner.target = param_01;
  }

  param_00.spawner.var_C1 = param_00.spawner.var_C1 + 1;
  var_05 = scripts\sp\utility::func_6B47(param_00.spawner);
  var_06 = scripts\sp\utility::func_106ED(var_05);
  if(var_06) {}

  var_05.var_131F5 = param_00.var_131F5;
  var_05.var_1321D = param_00.var_1321D;
  var_05.var_10B71 = param_00.var_10B71;
  var_05.var_72A4 = param_00.var_72A4;
  param_00.spawner.origin = var_02;
  param_00.spawner.angles = var_03;
  param_00.spawner.target = var_04;
  param_00 delete();
  return var_05;
}

func_1732() {
  var_00 = self.var_EE90;
  var_01 = self.var_EE91;
  if(!isDefined(level.var_A67E)) {
    level.var_A67E = [];
  }

  if(!isDefined(level.var_A67E[var_00])) {
    level.var_A67E[var_00] = [];
  }

  if(!isDefined(level.var_A67E[var_00][var_01])) {
    level.var_A67E[var_00][var_01] = [];
  }

  level.var_A67E[var_00][var_01][self.var_6A0B] = self;
}

func_177E() {
  var_00 = self.var_EEBA;
  var_01 = self.var_EEBB;
  if(!isDefined(level.var_10727[var_00])) {
    level.var_10727[var_00] = [];
  }

  if(!isDefined(level.var_10727[var_00][var_01])) {
    level.var_10727[var_00][var_01] = [];
  }

  level.var_10727[var_00][var_01][self.var_6A0B] = self;
}

func_10CC6() {
  self endon("death");
  self.var_55ED = 1;
  wait(3);
  self.var_55ED = 0;
}

deathtime() {
  self endon("death");
  wait(self.var_ED4B);
  wait(randomfloat(10));
  self _meth_81D0();
}

func_11AD7(param_00) {
  self notify("tracker_bullet_hit");
  self endon("tracker_bullet_hit");
  if(self.team != "axis") {
    return;
  }

  if(!isalive(self)) {
    return;
  }

  scripts\sp\utility::func_9196(1, 0, 1, "tracker");
  scripts\engine\utility::waittill_notify_or_timeout("death", 5);
  scripts\sp\utility::func_9193("tracker");
  if(isalive(self)) {
    for(var_01 = 0; var_01 < 3; var_01++) {
      wait(0.2);
      scripts\sp\utility::func_9196(1, 0, 1, "tracker");
      wait(0.15);
      scripts\sp\utility::func_9193("tracker");
    }
  }
}