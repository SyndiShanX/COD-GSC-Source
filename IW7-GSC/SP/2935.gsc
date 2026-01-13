/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: SP\2935.gsc
*********************************************/

main() {
  level.var_10707 = [];
  level.var_10707["allies"] = [];
  level.var_10707["axis"] = [];
  level.var_10707["team3"] = [];
  level.var_10707["neutral"] = [];
  thread enableoffhandsecondaryweapons();
  var_0 = getEntArray("flood_and_secure", "targetname");
  scripts\engine\utility::array_thread(var_0, ::func_6F4C);
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
  foreach(var_2 in level.players) {
    var_2 give_zombies_perk("allies");
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

  var_4 = getspawnerarray();
  foreach(var_6 in var_4) {}

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
  var_8 = getaispeciesarray();
  scripts\engine\utility::array_thread(var_8, ::func_AD8E);
  level.var_1923 = [];
  level.var_5C63 = [];
  var_9 = getspawnerarray();
  for(var_0A = 0; var_0A < var_9.size; var_0A++) {
    var_9[var_0A] thread func_107AB();
  }

  level.var_5C63 = undefined;
  scripts\sp\utility::func_9189("tracker", 1, "default");
  thread func_D970();
  scripts\engine\utility::array_thread(var_8, ::func_107F2);
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
  foreach(var_2, var_1 in level.var_4E3F) {
    if(!isDefined(level.flag[var_2])) {
      scripts\engine\utility::flag_init(var_2);
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
  var_0 = self.unique_id;
  var_1 = self.var_ED48;
  if(isDefined(self.var_ED49)) {
    func_1382D();
  } else {
    self waittill("death");
  }

  level.var_4E3F[var_1]["ai"][var_0] = undefined;
  func_12DAA(var_1);
}

func_131C1() {
  var_0 = self.unique_id;
  var_1 = self.var_ED48;
  if(!isDefined(level.var_4E3F) || !isDefined(level.var_4E3F[self.var_ED48])) {
    waittillframeend;
    if(!isDefined(self)) {
      return;
    }
  }

  level.var_4E3F[var_1]["vehicles"][var_0] = self;
  self waittill("death");
  level.var_4E3F[var_1]["vehicles"][var_0] = undefined;
  func_12DAA(var_1);
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
  var_0 = self.var_ED48;
  var_1 = self.var_1086A;
  func_10729();
  level.var_4E3F[var_0]["spawners"][var_1] = undefined;
  func_12DAA(var_0);
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
  var_0 = self.var_ED48;
  var_1 = self.var_1086A;
  func_10729();
  level.var_4E3F[var_0]["vehicle_spawners"][var_1] = undefined;
  func_12DAA(var_0);
}

func_12DAA(var_0) {
  level notify("updating_deathflag_" + var_0);
  level endon("updating_deathflag_" + var_0);
  waittillframeend;
  foreach(var_2 in level.var_4E3F[var_0]) {
    if(getarraykeys(var_2).size > 0) {
      return;
    }
  }

  scripts\engine\utility::flag_set(var_0);
}

func_C75A(var_0) {
  var_0 endon("death");
  for(;;) {
    var_0 waittill("trigger", var_1);
    if(!isai(var_1)) {
      continue;
    }

    var_1 thread scripts\sp\utility::func_931D(0.15);
    var_1 scripts\sp\utility::func_5514();
  }
}

func_9409(var_0) {
  var_0 endon("death");
  for(;;) {
    var_0 waittill("trigger", var_1);
    if(!isai(var_1)) {
      continue;
    }

    var_1 thread scripts\sp\utility::func_931D(0.15);
    var_1 scripts\sp\utility::func_61E7();
  }
}

func_12797(var_0) {
  var_0 waittill("trigger");
  var_1 = var_0.var_DC8F;
  var_2 = var_0.target;
  var_0 scripts\sp\utility::script_delay();
  if(isDefined(var_1)) {
    waittillframeend;
  }

  var_3 = scripts\engine\utility::array_combine(getspawnerarray(var_2), vehicle_getspawnerarray(var_2));
  foreach(var_5 in var_3) {
    if(!isnonentspawner(var_5) && var_5.var_9F == "script_vehicle") {
      if((isDefined(var_5.var_EE2B) && var_5.var_EE2B == 1) || !isDefined(var_5.target)) {
        thread scripts\sp\vehicle::func_13237(var_5);
      } else {
        var_5 thread scripts\sp\vehicle::func_1080B();
      }

      continue;
    }

    var_5 thread func_12799();
  }

  if(isDefined(level.var_107A7)) {
    func_12781(var_2);
  }
}

func_12781(var_0) {
  var_1 = scripts\engine\utility::getstructarray(var_0, "targetname");
  if(getEntArray(var_0, "target").size <= 1) {
    scripts\sp\utility::func_51D6(var_1);
  }

  var_2 = func_7BC6(var_1);
  scripts\engine\utility::array_thread(var_2, ::func_12799);
}

func_7BC6(var_0) {
  var_1 = [];
  var_2 = [];
  foreach(var_4 in var_0) {
    if(!isDefined(var_4.var_EEB6)) {
      continue;
    }

    if(!isDefined(var_2[var_4.var_EEB6])) {
      var_2[var_4.var_EEB6] = [];
    }

    var_2[var_4.var_EEB6][var_2[var_4.var_EEB6].size] = var_4;
  }

  foreach(var_7 in var_2) {
    foreach(var_4 in var_7) {
      var_9 = func_7C86(var_4, var_7.size);
      var_1[var_1.size] = var_9;
    }
  }

  return var_1;
}

func_7C86(var_0, var_1) {
  if(!isDefined(level.var_1086B)) {
    level.var_1086B = [];
  }

  if(!isDefined(level.var_1086B[var_0.var_EEB6])) {
    level.var_1086B[var_0.var_EEB6] = func_492A(var_0.var_EEB6);
  }

  var_2 = level.var_1086B[var_0.var_EEB6];
  var_3 = var_2.pool[var_2.var_D653];
  var_2.var_D653++;
  var_2.var_D653 = var_2.var_D653 % var_2.pool.size;
  var_3.origin = var_0.origin;
  if(isDefined(var_0.angles)) {
    var_3.angles = var_0.angles;
  } else if(isDefined(var_0.target)) {
    var_4 = getnode(var_0.target, "targetname");
    if(isDefined(var_4)) {
      var_3.angles = vectortoangles(var_4.origin - var_3.origin);
    }
  }

  if(isDefined(level.var_107A6)) {
    var_3[[level.var_107A6]](var_0);
  }

  if(isDefined(var_0.target)) {
    var_3.target = var_0.target;
  }

  var_3.var_C1 = 1;
  return var_3;
}

func_492A(var_0) {
  var_1 = getspawnerarray();
  var_2 = spawnStruct();
  var_3 = [];
  foreach(var_5 in var_1) {
    if(!isDefined(var_5.var_EEB6)) {
      continue;
    }

    if(var_5.var_EEB6 != var_0) {
      continue;
    }

    var_3[var_3.size] = var_5;
  }

  var_2.var_D653 = 0;
  var_2.pool = var_3;
  return var_2;
}

func_12799() {
  self endon("death");
  scripts\sp\utility::script_delay();
  if(!isDefined(self)) {
    return undefined;
  }

  if(isDefined(self.var_ED6E)) {
    var_0 = scripts\sp\utility::func_5CC8(self);
    return undefined;
  } else if(isDefined(self.var_ED8A)) {
    var_0 = scripts\sp\utility::func_6B47(self);
    return undefined;
  } else if(isDefined(self.var_ED1B)) {
    var_0 = scripts\sp\utility::func_2C17(self);
    return undefined;
  } else if(!issubstr(self.classname, "actor")) {
    return undefined;
  }

  var_1 = isDefined(self.var_EED1) && scripts\engine\utility::flag("stealth_enabled") && !scripts\engine\utility::flag("stealth_spotted");
  if(isDefined(self.var_EDB3)) {
    var_0 = self func_8393(var_1);
  } else {
    var_0 = self dospawn(var_1);
  }

  if(!scripts\sp\utility::func_106ED(var_1)) {
    if(isDefined(self.var_ED39)) {
      if(self.var_ED39 == "heat") {
        var_1 scripts\sp\utility::func_61FF();
      }

      if(self.var_ED39 == "cqb") {
        var_1 scripts\sp\utility::func_61E7();
      }
    }
  }

  return var_1;
}

func_12798(var_0) {
  var_1 = var_0.target;
  var_2 = 0;
  var_3 = getspawnerarray(var_1);
  foreach(var_5 in var_3) {
    if(!isDefined(var_5.target)) {
      continue;
    }

    var_6 = getspawner(var_5.target, "targetname");
    if(!isDefined(var_6)) {
      if(!isDefined(var_5.script_linkto)) {
        continue;
      }

      var_6 = getspawner(var_5.script_linkto, "script_linkname");
      if(!isDefined(var_6)) {
        var_6 = var_5 scripts\sp\utility::func_7A8E();
      }

      if(!isDefined(var_6)) {
        continue;
      }

      if(!isspawner(var_6)) {
        continue;
      }
    }

    var_2 = 1;
    break;
  }

  var_0 waittill("trigger");
  var_0 scripts\sp\utility::script_delay();
  var_3 = getspawnerarray(var_1);
  foreach(var_5 in var_3) {
    var_5 thread func_1278A();
  }
}

func_1278A() {
  var_0 = func_12789();
  var_1 = func_12799();
  if(!isDefined(var_1)) {
    self delete();
    if(isDefined(var_0)) {
      var_1 = var_0 func_12799();
      var_0 delete();
      if(!isDefined(var_1)) {
        return;
      }
    } else {
      return;
    }
  }

  if(!isDefined(var_0)) {
    return;
  }

  var_1 waittill("death");
  if(!isDefined(var_0)) {
    return;
  }

  if(!isDefined(var_0.var_C1)) {
    var_0.var_C1 = 1;
  }

  for(;;) {
    if(!isDefined(var_0)) {
      break;
    }

    var_2 = var_0 func_12799();
    if(!isDefined(var_2)) {
      var_0 delete();
      break;
    }

    var_2 thread func_DF23(var_0);
    var_2 waittill("death", var_3);
    if(!func_D27A(var_2, var_3)) {
      if(!isDefined(var_0)) {
        break;
      }

      var_0.var_C1++;
    }

    if(!isDefined(var_2)) {
      continue;
    }

    if(!isDefined(var_0)) {
      break;
    }

    if(!isDefined(var_0.var_C1)) {
      break;
    }

    if(var_0.var_C1 <= 0) {
      break;
    }

    if(!scripts\sp\utility::func_EF15()) {
      wait(randomfloatrange(1, 3));
    }
  }

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

func_12789() {
  if(isDefined(self.target)) {
    var_0 = getspawner(self.target, "targetname");
    if(isDefined(var_0) && isspawner(var_0)) {
      return var_0;
    }
  }

  if(isDefined(self.script_linkto)) {
    var_0 = getspawner(self.script_linkto, "script_linkname");
    if(!isDefined(var_0)) {
      var_0 = scripts\sp\utility::func_7A8E();
    }

    if(isDefined(var_0) && isspawner(var_0)) {
      return var_0;
    }
  }

  return undefined;
}

func_6F5A(var_0) {
  scripts\engine\utility::array_thread(var_0, ::func_6F59);
  scripts\engine\utility::array_thread(var_0, ::func_6F5C);
}

func_DF23(var_0) {
  var_0 endon("death");
  if(isDefined(self.var_EDAA)) {
    if(self.var_EDAA) {
      return;
    }
  }

  self waittill("death");
  if(!isDefined(self)) {
    var_0.var_C1++;
  }
}

func_A617(var_0) {
  var_1 = var_0.var_EDF7;
  var_0 waittill("trigger");
  waittillframeend;
  waittillframeend;
  func_A67F(var_1);
  func_A622(var_0);
}

func_A67F(var_0) {
  var_1 = getspawnerarray();
  var_2 = vehicle_getspawnerarray();
  var_3 = scripts\engine\utility::array_combine(var_1, var_2);
  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    if(isDefined(var_3[var_4].var_EDF7) && var_0 == var_3[var_4].var_EDF7) {
      if(isnonentspawner(var_3[var_4])) {
        var_3[var_4] notify("death");
      }

      var_3[var_4] delete();
    }
  }
}

func_A622(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  if(isDefined(var_0.var_336) && var_0.var_336 != "flood_spawner") {
    return;
  }

  var_0 delete();
}

func_DC8F(var_0) {
  var_0 endon("death");
  var_1 = var_0.var_EE90;
  waittillframeend;
  if(!isDefined(level.var_A67E)) {
    level.var_A67E = [];
  }

  if(!isDefined(level.var_A67E[var_1])) {
    return;
  }

  var_0 waittill("trigger");
  func_4B09(var_1);
}

func_4B09(var_0) {
  if(!isDefined(level.var_A67E)) {
    level.var_A67E = [];
  }

  if(!isDefined(level.var_A67E[var_0])) {
    return;
  }

  var_1 = level.var_A67E[var_0];
  var_2 = getarraykeys(var_1);
  if(var_2.size <= 1) {
    return;
  }

  var_3 = scripts\engine\utility::random(var_2);
  var_1[var_3] = undefined;
  foreach(var_9, var_5 in var_1) {
    foreach(var_7 in var_5) {
      if(isDefined(var_7)) {
        var_7 delete();
      }
    }

    level.var_A67E[var_0][var_9] = undefined;
  }
}

func_61BD(var_0) {
  var_1 = var_0.script_emptyspawner;
  var_0 waittill("trigger");
  var_2 = getspawnerarray();
  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(!isDefined(var_2[var_3].script_emptyspawner)) {
      continue;
    }

    if(var_1 != var_2[var_3].script_emptyspawner) {
      continue;
    }

    var_2[var_3] scripts\sp\utility::func_F311(0);
    var_2[var_3] notify("emptied spawner");
  }

  var_0 notify("deleted spawners");
}

func_A618(var_0) {
  var_1 = getspawnerarray();
  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(!isDefined(var_1[var_2].var_EDF7)) {
      continue;
    }

    if(var_0 != var_1[var_2].var_EDF7) {
      continue;
    }

    var_1[var_2] delete();
  }
}

spawn_grenade(var_0, var_1) {
  var_2 = spawn("weapon_frag", var_0);
  var_2 thread add_to_grenade_cache(var_1);
  return var_2;
}

add_to_grenade_cache(var_0) {
  if(!isDefined(level.func_8580) || !isDefined(level.func_8580[var_0])) {
    level.func_8581[var_0] = 0;
    level.func_8580[var_0] = [];
  }

  var_1 = level.func_8581[var_0];
  var_2 = level.func_8580[var_0][var_1];
  if(isDefined(var_2)) {
    var_2 delete();
  }

  level.func_8580[var_0][var_1] = self;
  level.func_8581[var_0] = var_1 + 1 % 16;
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
  var_0 = 25;
  var_1 = 12;
  var_2 = self.origin + (randomint(var_0) - var_1, randomint(var_0) - var_1, 2) + (0, 0, 42);
  var_3 = (0, randomint(360), 90);
  thread func_10720(var_2, var_3, self.team);
}

func_10720(var_0, var_1, var_2) {
  if(isDefined(level.var_D9E5["mandatoryunlocks"]) && scripts\engine\utility::array_contains(level.var_D9E5["mandatoryunlocks"], "frag")) {
    return;
  }

  var_3 = spawn_grenade(var_0, var_2);
  var_3 setModel("grenade_bag");
  var_3.angles = var_1;
  var_3 hide();
  wait(0.7);
  if(!isDefined(var_3)) {
    return;
  }

  var_3 show();
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
    var_0 = self.var_ECE7;
    if(!isDefined(level.var_1162[var_0])) {
      func_1A12(var_0);
    }

    thread func_1A17(level.var_1162[var_0]);
  }

  if(isDefined(self.var_ED54)) {
    var_1 = 0;
    if(isDefined(level.var_1160)) {
      if(isDefined(level.var_1160[self.var_ED54])) {
        var_1 = level.var_1160[self.var_ED54].size;
      }
    }

    level.var_1160[self.var_ED54][var_1] = self;
  }

  if(isDefined(self.var_EDD7)) {
    if(self.var_EDD7 > level.var_1349) {
      level.var_1349 = self.var_EDD7;
    }

    var_1 = 0;
    if(isDefined(level.var_1164)) {
      if(isDefined(level.var_1164[self.var_EDD7])) {
        var_1 = level.var_1164[self.var_EDD7].size;
      }
    }

    level.var_1164[self.var_EDD7][var_1] = self;
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
    self waittill("spawned", var_2);
    if(!isalive(var_2)) {
      continue;
    }

    if(isDefined(level.var_10877)) {
      self thread[[level.var_10877]](var_2);
    }

    if(isDefined(self.var_ED54)) {
      for(var_3 = 0; var_3 < level.var_1160[self.var_ED54].size; var_3++) {
        if(level.var_1160[self.var_ED54][var_3] != self) {
          level.var_1160[self.var_ED54][var_3] delete();
        }
      }
    }

    var_2.var_10707 = self.var_10708;
    var_2.var_10708 = undefined;
    var_2.spawner = self;
    if(isDefined(self.var_336)) {
      var_2 thread func_107F2(self.var_336);
      continue;
    }

    var_2 thread func_107F2();
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

func_107F2(var_0) {
  level.var_1923[self.classname] = 1;
  if(isDefined(self.asmname) && self.asmname == "seeker") {
    return;
  }

  func_107F3(var_0);
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

  var_0 = 0;
  switch (self.var_ED5B) {
    case "easy":
      if(level.var_7683 > 1) {
        var_0 = 1;
      }
      break;

    case "hard":
      if(level.var_7683 < 2) {
        var_0 = 1;
      }
      break;
  }

  return var_0;
}

func_E81A() {
  if(!isDefined(self.var_10707)) {
    self.spawner = undefined;
    return;
  }

  for(var_0 = 0; var_0 < self.var_10707.size; var_0++) {
    var_1 = self.var_10707[var_0];
    if(isDefined(var_1["param5"])) {
      thread[[var_1["function"]]](var_1["param1"], var_1["param2"], var_1["param3"], var_1["param4"], var_1["param5"]);
      continue;
    }

    if(isDefined(var_1["param4"])) {
      thread[[var_1["function"]]](var_1["param1"], var_1["param2"], var_1["param3"], var_1["param4"]);
      continue;
    }

    if(isDefined(var_1["param3"])) {
      thread[[var_1["function"]]](var_1["param1"], var_1["param2"], var_1["param3"]);
      continue;
    }

    if(isDefined(var_1["param2"])) {
      thread[[var_1["function"]]](var_1["param1"], var_1["param2"]);
      continue;
    }

    if(isDefined(var_1["param1"])) {
      thread[[var_1["function"]]](var_1["param1"]);
      continue;
    }

    thread[[var_1["function"]]]();
  }

  var_2 = scripts\engine\utility::ter_op(isDefined(level.vehicle.var_10709) && level.vehicle.var_10709 && self.var_9F == "script_vehicle", self.script_team, self.team);
  if(isDefined(var_2)) {
    for(var_0 = 0; var_0 < level.var_10707[var_2].size; var_0++) {
      var_1 = level.var_10707[var_2][var_0];
      if(isDefined(var_1["param5"])) {
        thread[[var_1["function"]]](var_1["param1"], var_1["param2"], var_1["param3"], var_1["param4"], var_1["param5"]);
        continue;
      }

      if(isDefined(var_1["param4"])) {
        thread[[var_1["function"]]](var_1["param1"], var_1["param2"], var_1["param3"], var_1["param4"]);
        continue;
      }

      if(isDefined(var_1["param3"])) {
        thread[[var_1["function"]]](var_1["param1"], var_1["param2"], var_1["param3"]);
        continue;
      }

      if(isDefined(var_1["param2"])) {
        thread[[var_1["function"]]](var_1["param1"], var_1["param2"]);
        continue;
      }

      if(isDefined(var_1["param1"])) {
        thread[[var_1["function"]]](var_1["param1"]);
        continue;
      }

      thread[[var_1["function"]]]();
    }
  }

  self.var_10707 = undefined;
  self.spawner = undefined;
}

func_4E47() {
  self waittill("death", var_0, var_1, var_2);
  level notify("ai_killed", self, var_0, var_1, var_2);
  if(!isDefined(self)) {
    return;
  }

  if(isDefined(var_0)) {
    scripts\anim\utility_common::repeater_headshot_ammo_passive(var_2, var_0, self);
    if(self.team == "axis" || self.team == "team3") {
      var_3 = undefined;
      if(isDefined(var_0.var_4F)) {
        if(isDefined(var_0.var_9F45) && var_0.var_9F45) {
          var_3 = "sentry";
        }

        if(isDefined(var_0.var_ED)) {
          var_3 = "destructible";
        }

        var_0 = var_0.var_4F;
      } else if(isDefined(var_0.triggerportableradarping)) {
        if(isai(var_0) && isplayer(var_0.triggerportableradarping)) {
          var_3 = "friendly";
        }

        var_0 = var_0.triggerportableradarping;
      } else if(isDefined(var_0.damageowner)) {
        if(isDefined(var_0.var_ED)) {
          var_3 = "destructible";
        }

        var_0 = var_0.damageowner;
      }

      var_4 = 0;
      if(isplayer(var_0)) {
        var_4 = 1;
      }

      if(isDefined(level.var_D5ED) && level.var_D5ED) {
        var_4 = 1;
      }

      if(var_4) {
        var_0 scripts\sp\player_stats::func_DEBD(self, var_1, var_2, var_3);
        return;
      }
    }
  }
}

func_1931() {
  self.var_4CF5 = [];
  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    self.var_C873 = var_0;
    if(isDefined(var_1) && isplayer(var_1)) {
      var_0A = var_1 getcurrentweapon();
      if(isDefined(var_0A) && scripts\sp\utility::isprimaryweapon(var_0A) && isDefined(var_4) && var_4 == "MOD_PISTOL_BULLET" || var_4 == "MOD_RIFLE_BULLET") {
        var_1 thread scripts\sp\player_stats::func_DED8();
      }

      var_0B = getweaponbasename(var_0A);
      if(isDefined(var_0B) && var_0B == "iw7_m4" && scripts\sp\utility::func_9FFE(var_0A)) {
        thread func_11AD7(var_3);
      }
    }

    foreach(var_0D in self.var_4CF5) {
      thread[[var_0D]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
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

func_486E(var_0) {
  var_1 = func_7CDA(var_0);
  if(var_1.size == 0) {
    return;
  }

  var_2 = -1;
  for(;;) {
    var_2++;
    if(var_2 >= var_1.size) {
      break;
    }

    var_3 = var_1[var_2];
    if(isDefined(var_3.var_4871)) {
      continue;
    }

    var_3.var_4871 = 1;
    level thread func_DFE2(var_3);
    if(isDefined(var_3.var_ED9E)) {
      if(!isDefined(level.flag[var_3.var_ED9E])) {
        scripts\engine\utility::flag_init(var_3.var_ED9E);
      }
    }

    if(isDefined(var_3.var_EDA0)) {
      if(!isDefined(level.flag[var_3.var_EDA0])) {
        scripts\engine\utility::flag_init(var_3.var_EDA0);
      }
    }

    if(isDefined(var_3.var_ED9B)) {
      if(!isDefined(level.flag[var_3.var_ED9B])) {
        scripts\engine\utility::flag_init(var_3.var_ED9B);
      }
    }

    if(isDefined(var_3.target)) {
      var_4 = func_7CDA(var_3.target);
      foreach(var_6 in var_4) {
        if(!isDefined(var_6.var_4871)) {
          var_1[var_1.size] = var_6;
        }
      }
    }
  }
}

func_DFE2(var_0) {
  waittillframeend;
  if(isDefined(var_0)) {
    var_0.var_4871 = undefined;
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
  var_0["crew"] = 1;
  var_0["no_boost"] = 1;
  if(isDefined(self.subclass) && isDefined(var_0[self.subclass])) {
    self func_8504(0, "soldier_boost");
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

  self func_81D6();
  self waittill("death");
  if(!isDefined(self)) {
    return;
  }

  self func_81D5();
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
    var_0 = self.var_ED42;
    if(var_0 == 1) {
      var_0 = 8;
    }

    scripts\sp\utility::func_61EB(var_0);
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
    self.bt.forceselfdestructtimer = gettime() + self.var_EEA6 * 1000;
    self.var_EEA6 = undefined;
    return;
  }

  if(isDefined(self.var_EEA5)) {
    self.bt.forceselfdestructtimer = 1;
    self.var_EEA5 = undefined;
  }
}

func_107F3(var_0) {
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

  [[level.var_115BE[self.team]]]();
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
  self func_8250(0);
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

func_50F5(var_0) {
  var_0 endon("death");
  while(isalive(var_0)) {
    if(var_0.objective_playermask_showto > 200) {
      var_0.objective_playermask_showto = var_0.objective_playermask_showto - 200;
    }

    wait(6);
  }
}

func_6E4B(var_0) {
  self endon("death");
  if(!self.var_6E66) {
    var_0.used_an_mg42 = 1;
    self.var_6E66 = 1;
    var_0 waittill("death");
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

  var_0 = level.enableoffhandsecondaryweapons[self.var_EDCF];
  if(!isDefined(var_0)) {
    return;
  }

  if(isDefined(var_0.target)) {
    var_1 = getnode(var_0.target, "targetname");
    var_2 = getent(var_0.target, "targetname");
    var_3 = scripts\engine\utility::getstruct(var_0.target, "targetname");
    var_4 = undefined;
    if(isDefined(var_1)) {
      var_4 = var_1;
      self give_more_perk(var_4);
    } else if(isDefined(var_2)) {
      var_4 = var_2;
      self give_mp_super_weapon(var_4.origin);
    } else if(isDefined(var_3)) {
      var_4 = var_3;
      self give_mp_super_weapon(var_4.origin);
    }

    if(isDefined(var_4.fgetarg) && var_4.fgetarg != 0) {
      self.objective_playermask_showto = var_4.fgetarg;
    }

    if(isDefined(var_4.objective_playermask_hidefrom) && var_4.objective_playermask_hidefrom != 0) {
      self.objective_playermask_hidefrom = var_4.objective_playermask_hidefrom;
    }
  }

  if(isDefined(self.target)) {
    self func_82F0(var_0);
    return;
  }

  self func_82F1(var_0);
}

func_7CDA(var_0) {
  var_1 = getnodearray(var_0, "targetname");
  var_2 = scripts\engine\utility::getstructarray(var_0, "targetname");
  foreach(var_4 in var_2) {
    var_1[var_1.size] = var_4;
  }

  var_2 = getEntArray(var_0, "targetname");
  foreach(var_4 in var_2) {
    if(isspawner(var_4) || var_4.var_9F == "trigger_multiple" || var_4.var_9F == "trigger_once" || var_4.var_9F == "trigger_radius") {
      continue;
    }

    var_1[var_1.size] = var_4;
  }

  return var_1;
}

func_C035(var_0) {
  return isDefined(var_0.fgetarg) && var_0.fgetarg != 0;
}

worldpointinreticle_circle(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(self.used_an_mg42)) {
    return;
  }

  if(!isDefined(var_0)) {
    var_5 = func_7CDA(self.target);
    if(var_5.size == 0) {
      self notify("reached_path_end");
      return;
    }
  } else if(isarray(var_1)) {
    var_5 = var_1;
  } else {
    var_0[0] = var_1;
  }

  allowboostjump(var_5, var_2, var_3, var_4);
}

func_7A7B(var_0) {
  if(var_0.size == 1) {
    return var_0[0];
  }

  var_0 = scripts\engine\utility::array_randomize(var_0);
  var_1 = var_0[0];
  if(!isDefined(var_1.var_13070)) {
    var_1.var_13070 = 0;
  }

  foreach(var_3 in var_0) {
    if(!isDefined(var_3.var_13070)) {
      var_3.var_13070 = 0;
    }

    if(var_3.var_13070 < var_1.var_13070) {
      var_1 = var_3;
    }
  }

  var_1.var_13070 = gettime();
  return var_1;
}

allowboostjump(var_0, var_1, var_2, var_3) {
  self notify("stop_going_to_node");
  self endon("stop_going_to_node");
  self endon("death");
  var_4 = scripts\engine\utility::ter_op(isDefined(var_2), var_2, 300);
  for(;;) {
    var_0 = func_7A7B(var_0);
    if(isDefined(var_0.var_EE95)) {
      if(var_0.var_EE95 > 1) {
        var_4 = var_0.var_EE95;
      }

      var_0.var_EE95 = 0;
    }

    if(func_C035(var_0)) {
      self.objective_playermask_showto = var_0.fgetarg;
    }

    if(isDefined(var_0.height)) {
      self.objective_playermask_hidefrom = var_0.height;
    }

    if(isDefined(var_0.var_ED56)) {
      scripts\sp\utility::func_51E1(var_0.var_ED56);
    }

    if(isDefined(var_0.var_EE71)) {
      self.triggeroneoffradarsweep = var_0.var_EE71;
    }

    if(isDefined(var_0.var_EDE3)) {
      self.precacheleaderboards = var_0.var_EDE3;
    }

    if(isDefined(var_0.var_EDE4)) {
      self.ignoreme = var_0.var_EDE4;
    }

    if(isDefined(self.var_10E6D)) {
      lib_0F18::func_10E8A("go_to_node_wait", ::func_840F, var_0);
    } else {
      func_840F(var_0);
      self waittill("goal");
    }

    var_0 notify("trigger", self);
    if(isDefined(self.var_10E6D)) {
      lib_0F18::func_10E8A("go_to_node_arrive", ::func_840F, var_0);
    }

    if(isDefined(var_1)) {
      [
        [var_1]
      ](var_0);
    }

    if(isDefined(var_0.var_ED9E)) {
      scripts\engine\utility::flag_set(var_0.var_ED9E);
    }

    if(isDefined(var_0.var_ED80)) {
      scripts\sp\utility::func_65E1(var_0.var_ED80);
    }

    if(isDefined(var_0.var_ED9B)) {
      scripts\engine\utility::flag_clear(var_0.var_ED9B);
    }

    if(func_1157F(var_0)) {
      return 1;
    }

    var_0 scripts\sp\utility::script_delay();
    if(isDefined(var_0.script_soundalias)) {
      self playSound(var_0.script_soundalias);
    }

    if(isDefined(var_0.var_EDC7)) {
      thread scripts\sp\utility::func_77B7(var_0.var_EDC7);
    }

    if(isDefined(var_0.var_EDA0)) {
      scripts\engine\utility::flag_wait(var_0.var_EDA0);
    }

    if(isDefined(var_0.var_ED81)) {
      scripts\sp\utility::func_65E3(var_0.var_ED81);
    }

    var_0 scripts\sp\utility::func_EF15();
    if(isDefined(self.var_D6EE)) {
      [
        [self.var_D6EE]
      ]();
    }

    if(isDefined(var_0.script_delay_post)) {
      wait(var_0.script_delay_post);
    }

    while(isDefined(var_0.var_EE95)) {
      var_0.var_EE95 = 0;
      if(ishighjumping(var_0, ::func_7CDA, var_4)) {
        var_0.var_EE95 = 1;
        var_0 notify("script_requires_player");
        break;
      }

      wait(0.1);
    }

    if(isDefined(var_0.var_ED57)) {
      scripts\sp\utility::func_51E1(var_0.var_ED57);
    }

    if(isDefined(var_3)) {
      [
        [var_3]
      ](var_0);
    }

    if(isDefined(var_0.var_ED43) && var_0.var_ED43) {
      scripts\sp\utility::func_54C6();
    }

    if(isDefined(var_0.var_ED54) && var_0.var_ED54) {
      if(isDefined(self.var_B14F)) {
        scripts\sp\utility::func_1101B();
      }

      self delete();
    }

    if(!isDefined(var_0.target)) {
      break;
    }

    var_5 = func_7CDA(var_0.target);
    if(!var_5.size) {
      break;
    }

    var_0 = var_5;
  }

  self notify("reached_path_end");
  if(isDefined(self.var_EDB0)) {
    return;
  }

  if(isDefined(self.var_527B) && self.var_527B == "patrol") {
    return;
  }

  if(isDefined(self func_812A())) {
    self func_82F1(self func_812A());
    return;
  }

  self.objective_playermask_showto = level.var_4FF6;
}

ishighjumping(var_0, var_1, var_2) {
  foreach(var_4 in level.players) {
    if(distancesquared(var_4.origin, var_0.origin) < distancesquared(self.origin, var_0.origin)) {
      return 1;
    }
  }

  if(!isDefined(var_0.var_ED5F)) {
    var_6 = anglesToForward(self.angles);
    if(isDefined(var_0.target)) {
      var_7 = [
        [var_1]
      ](var_0.target);
      if(var_7.size == 1) {
        var_6 = vectornormalize(var_7[0].origin - var_0.origin);
      } else if(isDefined(var_0.angles)) {
        var_6 = anglesToForward(var_0.angles);
      }
    } else if(isDefined(var_0.angles)) {
      var_6 = anglesToForward(var_0.angles);
    }

    var_8 = [];
    foreach(var_4 in level.players) {
      var_8[var_8.size] = vectornormalize(var_4.origin - self.origin);
    }

    foreach(var_0C in var_8) {
      if(vectordot(var_6, var_0C) > 0) {
        return 1;
      }
    }
  }

  var_0E = var_2 * var_2;
  foreach(var_4 in level.players) {
    if(distancesquared(var_4.origin, self.origin) < var_0E) {
      return 1;
    }
  }

  return 0;
}

allowhighjump(var_0) {
  if(!isDefined(var_0)) {
    return 1;
  }

  if(!isDefined(var_0.target)) {
    return 1;
  }

  if(isDefined(var_0.script_delay)) {
    return 1;
  }

  if(isDefined(var_0.var_EF15)) {
    return 1;
  }

  if(isDefined(var_0.var_EF1A)) {
    return 1;
  }

  if(isDefined(var_0.var_EF1C)) {
    return 1;
  }

  if(isDefined(var_0.var_EF1B)) {
    return 1;
  }

  if(isDefined(var_0.var_EDA0)) {
    return 1;
  }

  if(isDefined(var_0.var_ED81)) {
    return 1;
  }

  if(isDefined(var_0.script_delay_post)) {
    return 1;
  }

  if(isDefined(var_0.var_EE95)) {
    return 1;
  }

  return 0;
}

func_840F(var_0) {
  if(isnode(var_0)) {
    func_8411(var_0);
  } else if(isstruct(var_0)) {
    allowdodge(var_0);
  } else if(isent(var_0)) {
    func_8410(var_0);
  }

  if(isstruct(var_0) || isnode(var_0)) {
    var_0.var_C9A7 = allowhighjump(var_0);
  }
}

func_8410(var_0) {
  if(var_0.classname == "info_volume") {
    self func_82F1(var_0);
    self notify("go_to_node_new_goal");
    return;
  }

  allowdodge(var_0);
}

allowdodge(var_0) {
  scripts\sp\utility::func_F3D3(var_0);
  self notify("go_to_node_new_goal");
}

func_8411(var_0) {
  scripts\sp\utility::func_F3D9(var_0);
  self notify("go_to_node_new_goal");
}

func_1157F(var_0) {
  if(!isDefined(var_0.target)) {
    return 0;
  }

  var_1 = getEntArray(var_0.target, "targetname");
  if(!var_1.size) {
    return 0;
  }

  var_2 = var_1[0];
  if(!issubstr(var_2.classname, "misc_turret")) {
    return 0;
  }

  thread func_12F9C(var_2);
  return 1;
}

func_F3D8() {
  if(isDefined(self.var_EDCD)) {
    self.objective_playermask_hidefrom = self.var_EDCD;
    return;
  }

  self.objective_playermask_hidefrom = level.var_4FF5;
}

func_F3D7(var_0) {
  if(isDefined(self.script_radius)) {
    self.objective_playermask_showto = self.script_radius;
    return;
  }

  if(isDefined(self.var_EDB0)) {
    if(isDefined(var_0) && isDefined(var_0.fgetarg)) {
      self.objective_playermask_showto = var_0.fgetarg;
      return;
    }
  }

  if(!isDefined(self func_812A())) {
    if(self.type == "civilian") {
      self.objective_playermask_showto = 128;
      return;
    }

    self.objective_playermask_showto = level.var_4FF6;
  }
}

func_2697(var_0) {
  for(;;) {
    var_1 = self func_8165();
    if(!isalive(var_1)) {
      wait(1.5);
      continue;
    }

    if(!isDefined(var_1.isnodeoccupied)) {
      self settargetentity(scripts\engine\utility::random(var_0));
      self notify("startfiring");
      self func_8398();
    }

    wait(2 + randomfloat(1));
  }
}

func_B321(var_0) {
  for(;;) {
    self settargetentity(scripts\engine\utility::random(var_0));
    self notify("startfiring");
    self func_8398();
    wait(2 + randomfloat(1));
  }
}

func_12F9C(var_0) {
  self endon("stop_using_turret");
  self endon("death");
  if(self gettargetchargepos() && self.health == 150) {
    self.health = 100;
    self.a.disablelongdeath = 1;
  }

  scripts\asm\asm_bb::func_296E(var_0);
  while(!isDefined(self func_8164()) || self func_8164() != var_0) {
    wait(0.05);
  }

  if(isDefined(var_0.target) && var_0.target != var_0.var_336) {
    var_1 = getEntArray(var_0.target, "targetname");
    var_2 = [];
    for(var_3 = 0; var_3 < var_1.size; var_3++) {
      if(var_1[var_3].classname == "script_origin") {
        var_2[var_2.size] = var_1[var_3];
      }
    }

    if(isDefined(var_0.var_ED0F)) {
      var_0 thread func_2697(var_2);
    } else if(isDefined(var_0.var_EE07)) {
      var_0 give_player_session_tokens("manual_ai");
      var_0 thread func_B321(var_2);
    } else if(var_2.size > 0) {
      if(var_2.size == 1) {
        var_0.var_B319 = var_2[0];
        var_0 settargetentity(var_2[0]);
        thread scripts\sp\mgturret::func_B31A(var_0);
      } else {
        var_0 thread scripts\sp\mgturret::func_B6A8(var_2);
      }
    }
  }

  thread func_D31C(var_0);
  thread scripts\sp\mgturret::func_B6A3(var_0);
  var_0 notify("startfiring");
}

func_D31C(var_0) {
  self endon("death");
  if(self.team != "allies") {
    return;
  }

  var_1 = spawn("trigger_radius", var_0.origin, 0, 56, 56);
  thread scripts\engine\utility::delete_on_death(var_1);
  var_2 = 0;
  while(!var_2) {
    var_1 waittill("trigger");
    while(level.player istouching(var_1)) {
      if(level.player usebuttonpressed()) {
        var_2 = 1;
        break;
      }

      wait(0.05);
    }
  }

  var_1 delete();
  func_11054();
}

func_11054() {
  self notify("stop_using_turret");
  self notify("stop_using_built_in_burst_fire");
  var_0 = self func_8164();
  if(!isDefined(var_0)) {
    return;
  }

  self func_83AF();
  scripts\asm\asm_bb::func_296E(undefined);
  self givescorefortrophyblocks();
  var_0 givesentry();
}

func_73D9(var_0) {
  var_1 = getnode(var_0.target, "targetname");
  var_2 = getent(var_1.target, "targetname");
  var_2 give_player_session_tokens("auto_ai");
  var_2 cleartargetentity();
  var_3 = 0;
  for(;;) {
    var_0 waittill("trigger", var_4);
    if(!isai(var_4)) {
      continue;
    }

    if(!isDefined(var_4.team)) {
      continue;
    }

    if(var_4.team != "allies") {
      continue;
    }

    if(isDefined(var_4.var_EF00) && var_4.var_EF00 == 0) {
      continue;
    }

    if(var_4 thread func_73D7(var_2, var_1)) {
      var_4 thread func_73D6(var_2, var_1);
      var_2 waittill("friendly_finished_using_mg42");
      if(isalive(var_4)) {
        var_4.var_12A4D = gettime() + 10000;
      }
    }

    wait(1);
  }
}

func_73D2(var_0, var_1) {
  var_1 endon("friendly_finished_using_mg42");
  var_0 waittill("death");
  var_1 notify("friendly_finished_using_mg42");
}

func_73D8(var_0) {
  var_0 endon("friendly_finished_using_mg42");
  self.var_369 = 1;
  self setcursorhint("HINT_NOICON");
  self sethintstring(&"PLATFORM_USEAIONMG42");
  self waittill("trigger");
  self.var_369 = 0;
  self sethintstring("");
  self func_83AF();
  self notify("stopped_use_turret");
  var_0 notify("friendly_finished_using_mg42");
}

func_73D7(var_0, var_1) {
  if(self.var_369) {
    return 0;
  }

  if(isDefined(self.var_12A4D) && gettime() < self.var_12A4D) {
    return 0;
  }

  if(distance(level.player.origin, var_1.origin) < 100) {
    return 0;
  }

  return 1;
}

func_73D4(var_0, var_1) {
  var_0 endon("friendly_finished_using_mg42");
  self waittill("trigger");
  var_0 notify("friendly_finished_using_mg42");
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

func_73D6(var_0, var_1) {
  self endon("death");
  var_0 endon("friendly_finished_using_mg42");
  level thread func_73D2(self, var_0);
  self.oldradius = self.objective_playermask_showto;
  self.objective_playermask_showto = 28;
  thread func_C05F();
  self give_more_perk(var_1);
  self.precacherumble = 1;
  self waittill("goal");
  self.objective_playermask_showto = self.oldradius;
  if(self.objective_playermask_showto < 32) {
    self.objective_playermask_showto = 400;
  }

  self.precacherumble = 0;
  self.objective_playermask_showto = self.oldradius;
  if(distance(level.player.origin, var_1.origin) < 32) {
    var_0 notify("friendly_finished_using_mg42");
    return;
  }

  self.var_73D0 = var_0;
  thread func_73D8(var_0);
  thread func_73D1(var_0);
  self func_83D7(var_0);
  if(isDefined(var_0.target)) {
    var_2 = getent(var_0.target, "targetname");
    if(isDefined(var_2)) {
      var_2 thread func_73D4(var_0, self);
    }
  }

  for(;;) {
    if(distance(self.origin, var_1.origin) < 32) {
      self func_83D7(var_0);
    } else {
      break;
    }

    wait(1);
  }

  var_0 notify("friendly_finished_using_mg42");
}

func_73D1(var_0) {
  self endon("death");
  var_0 waittill("friendly_finished_using_mg42");
  func_73D3();
}

func_73D3() {
  self endon("death");
  var_0 = self.var_73D0;
  self.var_73D0 = undefined;
  self func_83AF();
  self notify("stopped_use_turret");
  self.var_369 = 0;
  self.objective_playermask_showto = self.oldradius;
  if(!isDefined(var_0)) {
    return;
  }

  if(!isDefined(var_0.target)) {
    return;
  }

  var_1 = getnode(var_0.target, "targetname");
  var_2 = self.objective_playermask_showto;
  self.objective_playermask_showto = 8;
  self give_more_perk(var_1);
  wait(2);
  self.objective_playermask_showto = 384;
  self waittill("goal");
  if(isDefined(self.target)) {
    var_1 = getnode(self.target, "targetname");
    if(isDefined(var_1.target)) {
      var_1 = getnode(var_1.target, "targetname");
    }

    if(isDefined(var_1)) {
      self give_more_perk(var_1);
    }
  }

  self.objective_playermask_showto = var_2;
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

func_114E7(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isDefined(self)) {
    return;
  }

  if(isalive(self)) {
    return;
  }

  if(!isalive(var_1)) {
    return;
  }

  if(!isDefined(var_1.var_380)) {
    return;
  }

  if(var_1 scripts\sp\vehicle::func_9E2C()) {
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

func_6F4C(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "instant_respawn") {
    var_0 = 1;
  }

  level.var_10881 = [];
  var_1 = getspawnerarray(self.target);
  scripts\engine\utility::array_thread(var_1, ::func_6F50, var_0);
  var_2 = 0;
  var_3 = 0;
  for(;;) {
    self waittill("trigger", var_4);
    if(!var_3) {
      var_3 = 1;
      scripts\sp\utility::script_delay();
    }

    if(self istouching(level.player)) {
      var_2 = 1;
    } else {
      if(!isalive(var_4)) {
        continue;
      }

      if(isplayer(var_4)) {
        var_2 = 1;
      } else if(!isDefined(var_4.var_9F73) || !var_4.var_9F73) {
        continue;
      }
    }

    var_1 = getspawnerarray(self.target);
    if(isDefined(var_1[0])) {
      if(isDefined(var_1[0].var_EE91)) {
        func_4B09(var_1[0].var_EE91);
      }
    }

    var_1 = getspawnerarray(self.target);
    for(var_5 = 0; var_5 < var_1.size; var_5++) {
      var_1[var_5].var_D43F = var_2;
      var_1[var_5] notify("flood_begin");
    }

    if(var_2) {
      wait(5);
      continue;
    }

    wait(0.1);
  }
}

func_6F50(var_0) {
  if(isDefined(self.var_F0DC)) {
    return;
  }

  self.var_F0DC = 1;
  self.var_127CC = 1;
  var_1 = self.target;
  var_2 = self.var_336;
  if(!isDefined(var_1) && !isDefined(self.var_EE2B)) {
    waittillframeend;
  }

  var_3 = [];
  if(isDefined(var_1)) {
    var_4 = getspawnerarray(var_1);
    for(var_5 = 0; var_5 < var_4.size; var_5++) {
      if(!issubstr(var_4[var_5].classname, "actor")) {
        continue;
      }

      var_3[var_3.size] = var_4[var_5];
    }
  }

  var_6 = spawnStruct();
  var_7 = self.origin;
  func_6F51(var_6, var_3.size > 0, var_0);
  if(isalive(var_6.var_1912)) {
    var_6.var_1912 waittill("death");
  }

  if(!isDefined(var_1)) {
    return;
  }

  var_4 = getspawnerarray(var_1);
  if(!var_4.size) {
    return;
  }

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    if(!issubstr(var_4[var_5].classname, "actor")) {
      continue;
    }

    var_4[var_5].var_336 = var_2;
    var_8 = var_1;
    if(isDefined(var_4[var_5].target)) {
      var_9 = getspawner(var_4[var_5].target, "targetname");
      if(!isDefined(var_9) || !issubstr(var_9.classname, "actor")) {
        var_8 = var_4[var_5].target;
      }
    }

    var_4[var_5].target = var_8;
    var_4[var_5] thread func_6F50(var_0);
    var_4[var_5].var_D43F = 1;
    var_4[var_5] notify("flood_begin");
  }
}

func_6F51(var_0, var_1, var_2) {
  self endon("death");
  var_3 = self.var_C1;
  if(!var_1) {
    var_1 = isDefined(self.script_noteworthy) && self.script_noteworthy == "delete";
  }

  scripts\sp\utility::func_F311(2);
  if(isDefined(self.script_delay)) {
    var_4 = self.script_delay;
  } else {
    var_4 = 0;
  }

  for(;;) {
    self waittill("flood_begin");
    if(self.var_D43F) {
      break;
    }

    if(var_4) {
      continue;
    }

    break;
  }

  var_5 = distance(level.player.origin, self.origin);
  while(var_3) {
    self.var_12844 = var_3;
    scripts\sp\utility::func_F311(2);
    wait(var_4);
    var_6 = isDefined(self.var_EED1) && scripts\engine\utility::flag("stealth_enabled") && !scripts\engine\utility::flag("stealth_spotted");
    if(isDefined(self.var_EDB3)) {
      var_7 = self func_8393(var_6);
    } else {
      var_7 = self dospawn(var_6);
    }

    if(scripts\sp\utility::func_106ED(var_7)) {
      var_8 = 0;
      if(var_4 < 2) {
        wait(2);
      }

      continue;
    } else {
      if(isDefined(self.var_ED39)) {
        if(self.var_ED39 == "heat") {
          var_7 scripts\sp\utility::func_61FF();
        }

        if(self.var_ED39 == "cqb") {
          var_7 scripts\sp\utility::func_61E7();
        }
      }

      thread func_1865(var_7);
      var_7 thread func_6F4D(self);
      if(isDefined(self.var_ECE5)) {
        var_7.var_2894 = self.var_ECE5;
      }

      var_0.var_1912 = var_7;
      var_0 notify("got_ai");
      self waittill("spawn_died", var_9, var_8);
      if(var_4 > 2) {
        var_4 = randomint(4) + 2;
      } else {
        var_4 = 0.5 + randomfloat(0.5);
      }
    }

    if(var_9) {
      func_13840(var_5);
      continue;
    }

    if(func_D462(var_8 || var_1, var_0.var_1912)) {
      var_3--;
    }

    if(!var_2) {
      func_13851();
    }
  }

  self delete();
}

func_1382E(var_0) {
  self endon("death");
  var_0 waittill("death");
}

func_1865(var_0) {
  var_1 = self.var_336;
  if(!isDefined(level.var_10881[var_1])) {
    level.var_10881[var_1] = spawnStruct();
    level.var_10881[var_1] scripts\sp\utility::func_F311(0);
    level.var_10881[var_1].var_11A1D = 0;
  }

  if(!isDefined(self.var_17C5)) {
    self.var_17C5 = 1;
    level.var_10881[var_1].var_11A1D++;
  }

  level.var_10881[var_1].var_C1++;
  func_1382E(var_0);
  level.var_10881[var_1].var_C1--;
  if(!isDefined(self)) {
    level.var_10881[var_1].var_11A1D--;
  }

  if(level.var_10881[var_1].var_11A1D) {
    if(level.var_10881[var_1].var_C1 / level.var_10881[var_1].var_11A1D < 0.32) {
      level.var_10881[var_1] notify("waveReady");
    }
  }
}

func_13851() {
  var_0 = self.var_336;
  if(level.var_10881[var_0].var_C1) {
    level.var_10881[var_0] waittill("waveReady");
  }
}

func_D462(var_0, var_1) {
  if(var_0) {
    return 1;
  }

  if(isDefined(var_1) && isDefined(var_1.origin)) {
    var_2 = var_1.origin;
  } else {
    var_2 = self.origin;
  }

  if(distance(level.player.origin, var_2) < 700) {
    return 1;
  }

  return bullettracepassed(level.player getEye(), var_1 getEye(), 0, undefined);
}

func_13840(var_0) {
  self endon("flood_begin");
  var_0 = var_0 * 0.75;
  while(distance(level.player.origin, self.origin) > var_0) {
    wait(1);
  }
}

func_6F4D(var_0) {
  thread func_6F4E();
  self waittill("death", var_1);
  var_2 = isalive(var_1) && isplayer(var_1);
  if(!var_2 && isDefined(var_1) && var_1.classname == "worldspawn") {
    var_2 = 1;
  }

  var_3 = !isDefined(self);
  var_0 notify("spawn_died", var_3, var_2);
}

func_6F4E() {
  if(isDefined(self.var_EE2B)) {
    return;
  }

  self endon("death");
  var_0 = getnode(self.target, "targetname");
  if(isDefined(var_0)) {
    self give_more_perk(var_0);
  } else {
    var_0 = getent(self.target, "targetname");
    if(isDefined(var_0)) {
      self give_mp_super_weapon(var_0.origin);
    }
  }

  if(isDefined(level.var_6BDF)) {
    self.vectortoyaw = level.var_6BDF;
    self.vehicle_getarray = level.var_B491;
  }

  if(isDefined(var_0.fgetarg) && var_0.fgetarg >= 0) {
    self.objective_playermask_showto = var_0.fgetarg;
  } else {
    self.objective_playermask_showto = 256;
  }

  self waittill("goal");
  while(isDefined(var_0.target)) {
    var_1 = getnode(var_0.target, "targetname");
    if(isDefined(var_1)) {
      var_0 = var_1;
    } else {
      break;
    }

    self give_more_perk(var_0);
    if(func_C035(var_0)) {
      self.objective_playermask_showto = var_0.fgetarg;
    } else {
      self.objective_playermask_showto = 256;
    }

    self waittill("goal");
  }

  if(isDefined(self.script_noteworthy)) {
    if(self.script_noteworthy == "delete") {
      self func_81D0();
      return;
    }
  }

  if(isDefined(var_0.target)) {
    var_2 = getent(var_0.target, "targetname");
    if(isDefined(var_2) && var_2.var_9F == "misc_turret") {
      self give_more_perk(var_0);
      self.objective_playermask_showto = 4;
      self waittill("goal");
      if(!isDefined(self.var_EDB0)) {
        self.objective_playermask_showto = level.var_4FF6;
      }

      func_12F9C(var_2);
    }
  }

  if(isDefined(self.script_noteworthy)) {
    if(self.script_noteworthy == "hide") {
      thread scripts\sp\utility::func_F2DA(0);
      return;
    }
  }

  if(!isDefined(self.var_EDB0) && !isDefined(self func_812A())) {
    self.objective_playermask_showto = level.var_4FF6;
  }
}

enableoffhandsecondaryweapons() {
  var_0 = getEntArray("info_volume", "classname");
  level.var_4E32 = [];
  level.enableoffhandsecondaryweapons = [];
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];
    if(isDefined(var_2.var_ED47)) {
      level.var_4E32[var_2.var_ED47] = var_2;
    }

    if(isDefined(var_2.var_EDCF)) {
      level.enableoffhandsecondaryweapons[var_2.var_EDCF] = var_2;
    }
  }
}

func_1A12(var_0) {
  level.var_1162[var_0] = spawnStruct();
  level.var_1162[var_0].var_1A09 = 0;
  level.var_1162[var_0].var_1A0D = 0;
  level.var_1162[var_0].var_10878 = 0;
  level.var_1162[var_0].var_1912 = [];
  level.var_1162[var_0].spawners = [];
}

func_1A17(var_0) {
  self endon("death");
  self.decremented = 0;
  var_0.var_10878++;
  var_0.spawners = scripts\engine\utility::array_add(var_0.spawners, self);
  thread func_1A15(var_0);
  thread func_1A16(var_0);
  while(self.var_C1) {
    self waittill("spawned", var_1);
    if(scripts\sp\utility::func_106ED(var_1)) {
      continue;
    }

    var_1 thread func_1A14(var_0);
  }

  waittillframeend;
  if(self.decremented) {
    return;
  }

  self.decremented = 1;
  var_0.var_10878--;
}

func_1A15(var_0) {
  self waittill("death");
  if(isDefined(self) && self.decremented) {
    return;
  }

  var_0.var_10878--;
}

func_1A16(var_0) {
  self endon("death");
  self waittill("emptied spawner");
  waittillframeend;
  if(self.decremented) {
    return;
  }

  self.decremented = 1;
  var_0.var_10878--;
}

func_1A14(var_0) {
  var_0.var_1A09++;
  var_0.var_1912[var_0.var_1912.size] = self;
  if(isDefined(self.var_ED49)) {
    func_1382D();
  } else {
    self waittill("death");
  }

  var_0.var_1A09--;
  var_0.var_1A0D++;
}

camper_trigger_think(var_0) {
  var_1 = strtok(var_0.script_linkto, " ");
  var_2 = [];
  var_3 = [];
  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    var_5 = var_1[var_4];
    var_6 = getspawner(var_5, "script_linkname");
    if(isDefined(var_6)) {
      var_2 = scripts\engine\utility::array_add_safe(var_2, var_6);
      continue;
    }

    var_7 = getnode(var_5, "script_linkname");
    if(!isDefined(var_7)) {
      continue;
    }

    var_3 = scripts\engine\utility::array_add_safe(var_3, var_7);
  }

  var_0 waittill("trigger");
  var_3 = scripts\engine\utility::array_randomize(var_3);
  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    var_3[var_4].claimed = 0;
  }

  var_8 = 0;
  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    var_9 = var_2[var_4];
    if(!isDefined(var_9)) {
      continue;
    }

    if(isDefined(var_9.var_EEB3)) {
      continue;
    }

    while(isDefined(var_3[var_8].script_noteworthy) && var_3[var_8].script_noteworthy == "dont_spawn") {
      var_8++;
    }

    var_9.origin = var_3[var_8].origin;
    var_9.angles = var_3[var_8].angles;
    var_9 scripts\sp\utility::func_1747(::func_3FEF, var_3[var_8]);
    var_8++;
  }

  scripts\engine\utility::array_thread(var_2, ::scripts\sp\utility::func_1747, ::func_37E9);
  scripts\engine\utility::array_thread(var_2, ::scripts\sp\utility::func_1747, ::func_BC9F, var_3);
  scripts\engine\utility::array_thread(var_2, ::scripts\sp\utility::func_10619);
}

func_37E9() {
  self.objective_playermask_showto = 8;
  self.logstring = 1;
}

func_BC9F(var_0) {
  self endon("death");
  var_1 = 0;
  for(;;) {
    if(!isalive(self.isnodeoccupied)) {
      self waittill("enemy");
      var_1 = 0;
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

    if(var_1) {
      if(self getpersstat(self.isnodeoccupied)) {
        wait(0.05);
        continue;
      }

      var_1 = 0;
    } else {
      if(self getpersstat(self.isnodeoccupied)) {
        var_1 = 1;
      }

      wait(0.05);
      continue;
    }

    if(randomint(3) > 0) {
      var_2 = func_6CA6(var_0);
      if(isDefined(var_2)) {
        func_3FEF(var_2, self.var_3FF3);
        self waittill("goal");
      }
    }
  }
}

func_3FEF(var_0, var_1) {
  self give_more_perk(var_0);
  self.var_3FF3 = var_0;
  var_0.claimed = 1;
  if(isDefined(var_1)) {
    var_1.claimed = 0;
  }
}

func_6CA6(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(var_0[var_1].claimed) {
      continue;
    } else {
      return var_0[var_1];
    }
  }

  return undefined;
}

func_6F5D(var_0) {
  var_1 = getspawnerarray(var_0.target);
  scripts\engine\utility::array_thread(var_1, ::func_6F59);
  var_0 waittill("trigger");
  var_1 = getspawnerarray(var_0.target);
  scripts\engine\utility::array_thread(var_1, ::func_6F5C, var_0);
}

func_6F59() {}

func_1278B(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  return isDefined(var_0.var_EE95);
}

func_6F5C(var_0) {
  if(!isDefined(level.var_107A7) || isspawner(self)) {
    self endon("death");
  }

  self notify("stop current floodspawner");
  self endon("stop current floodspawner");
  if(func_9C98()) {
    func_DB3D(var_0);
    return;
  }

  var_1 = func_1278B(var_0);
  scripts\sp\utility::script_delay();
  if(isDefined(level.var_107A7)) {
    if(!isspawner(self)) {
      self.var_C1 = 1;
    }
  }

  while(self.var_C1 > 0) {
    while(var_1 && !level.player istouching(var_0)) {
      wait(0.5);
    }

    var_2 = isDefined(self.var_EED1) && scripts\engine\utility::flag("stealth_enabled") && !scripts\engine\utility::flag("stealth_spotted");
    var_3 = self;
    if(isDefined(level.var_107A7)) {
      if(!isspawner(self)) {
        var_3 = func_7C86(self, 1);
      }
    }

    if(isDefined(self.var_EDB3)) {
      var_4 = var_3 func_8393(var_2);
    } else {
      var_4 = var_3 dospawn(var_2);
    }

    if(scripts\sp\utility::func_106ED(var_4)) {
      wait(2);
      continue;
    }

    if(isDefined(self.var_ED39)) {
      if(self.var_ED39 == "heat") {
        var_4 scripts\sp\utility::func_61FF();
      }

      if(self.var_ED39 == "cqb") {
        var_4 scripts\sp\utility::func_61E7();
      }
    }

    var_4 thread func_DF23(self);
    var_4 waittill("death", var_5);
    if(!func_D27A(var_4, var_5)) {
      self.var_C1++;
    }

    if(!isDefined(var_4)) {
      continue;
    }

    if(!scripts\sp\utility::func_EF15()) {
      wait(randomfloatrange(5, 9));
    }
  }
}

func_D27A(var_0, var_1) {
  if(isDefined(self.var_EDAA)) {
    if(self.var_EDAA) {
      return 1;
    }
  }

  if(!isDefined(var_0)) {
    return 0;
  }

  if(isalive(var_1)) {
    if(isplayer(var_1)) {
      return 1;
    }

    if(distance(var_1.origin, level.player.origin) < 200) {
      return 1;
    }
  } else if(isDefined(var_1)) {
    if(var_1.classname == "worldspawn") {
      return 0;
    }

    if(distance(var_1.origin, level.player.origin) < 200) {
      return 1;
    }
  }

  if(distance(var_0.origin, level.player.origin) < 200) {
    return 1;
  }

  return bullettracepassed(level.player getEye(), var_0 getEye(), 0, undefined);
}

func_9C98() {
  if(!isDefined(self.target)) {
    return 0;
  }

  var_0 = getspawnerarray(self.target);
  if(!var_0.size) {
    return 0;
  }

  return issubstr(var_0[0].classname, "actor");
}

func_DB3C(var_0) {
  var_0.var_1060E waittill("death");
  self notify("death_report");
}

func_DB3D(var_0) {
  self endon("death");
  var_1 = func_1278B(var_0);
  scripts\sp\utility::script_delay();
  if(var_1) {
    while(!level.player istouching(var_0)) {
      wait(0.5);
    }
  }

  var_2 = getspawnerarray(self.target);
  self.spawners = 0;
  scripts\engine\utility::array_thread(var_2, ::func_DB3F, self);
  var_4 = randomint(var_2.size);
  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(self.var_C1 <= 0) {
      return;
    }

    var_4++;
    if(var_4 >= var_2.size) {
      var_4 = 0;
    }

    var_5 = var_2[var_4];
    var_5 scripts\sp\utility::func_F311(1);
    var_6 = var_5 scripts\sp\utility::func_10619();
    if(scripts\sp\utility::func_106ED(var_6)) {
      wait(2);
      continue;
    }

    self.var_C1--;
    var_5.var_1060E = var_6;
    var_6 thread func_DF23(self);
    var_6 thread func_6985(var_0);
    thread func_DB3C(var_5);
  }

  var_7 = 0.01;
  while(self.var_C1 > 0) {
    self waittill("death_report");
    scripts\sp\utility::func_EF15();
    var_4 = randomint(var_2.size);
    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      var_2 = scripts\engine\utility::array_removeundefined(var_2);
      if(!var_2.size) {
        if(isDefined(self)) {
          self delete();
        }

        return;
      }

      var_4++;
      if(var_4 >= var_2.size) {
        var_4 = 0;
      }

      var_5 = var_2[var_4];
      if(isalive(var_5.var_1060E)) {
        continue;
      }

      if(isDefined(var_5.target)) {
        self.target = var_5.target;
      } else {
        self.target = undefined;
      }

      var_6 = scripts\sp\utility::func_10619();
      if(scripts\sp\utility::func_106ED(var_6)) {
        wait(2);
        continue;
      }

      var_6 thread func_DF23(self);
      var_6 thread func_6985(var_0);
      var_5.var_1060E = var_6;
      thread func_DB3C(var_5);
      if(self.var_C1 <= 0) {
        return;
      }
    }
  }
}

func_DB3F(var_0) {
  var_0 endon("death");
  var_0.spawners++;
  self waittill("death");
  var_0.spawners--;
  if(!var_0.spawners) {
    var_0 delete();
  }
}

func_6985(var_0) {
  if(isDefined(self.var_EDB0)) {
    return;
  }

  var_1 = level.var_4FF6;
  if(isDefined(var_0)) {
    if(isDefined(var_0.script_radius)) {
      if(var_0.script_radius == -1) {
        return;
      }

      var_1 = var_0.script_radius;
    }
  }

  if(isDefined(self.var_EDB0)) {
    return;
  }

  self endon("death");
  self waittill("goal");
  self.objective_playermask_showto = var_1;
}

func_100C6() {}

func_DC9B(var_0) {
  var_0 waittill("trigger");
  var_1 = getspawnerarray(var_0.target);
  if(!var_1.size) {
    return;
  }

  var_2 = scripts\engine\utility::random(var_1);
  var_1 = [];
  var_1[var_1.size] = var_2;
  if(isDefined(var_2.script_linkto)) {
    var_3 = strtok(var_2.script_linkto, " ");
    for(var_4 = 0; var_4 < var_3.size; var_4++) {
      var_1[var_1.size] = getspawner(var_3[var_4], "script_linkname");
    }
  }

  waittillframeend;
  scripts\engine\utility::array_thread(var_1, ::scripts\sp\utility::func_1747, ::func_2BD0);
  scripts\engine\utility::array_thread(var_1, ::scripts\sp\utility::func_10619);
}

func_2BD0() {
  if(isDefined(self.var_EDB0)) {
    return;
  }

  self endon("death");
  self waittill("reached_path_end");
  if(!isDefined(self func_812A())) {
    self.objective_playermask_showto = level.var_4FF6;
  }
}

func_1085E(var_0) {
  var_1 = var_0 giveplayeraccessory();
  if(var_1.var_394 != "none") {
    var_2 = getweaponmodel(var_1.var_394);
    var_1 attach(var_2, "tag_weapon_right");
    var_3 = getweaponhidetags(var_1.var_394);
    for(var_4 = 0; var_4 < var_3.size; var_4++) {
      var_1 hidepart(var_3[var_4], var_2);
    }
  }

  var_1.spawner = var_0;
  var_1.var_5BF2 = isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "drone_delete_on_unload";
  var_1.var_6CDA = 1;
  var_1 notify("finished spawning");
  var_0 notify("drone_spawned", var_1);
  return var_1;
}

func_10869(var_0, var_1) {
  if(!isDefined(var_0.spawner)) {}

  var_2 = var_0.spawner.origin;
  var_3 = var_0.spawner.angles;
  var_4 = var_0.spawner.target;
  var_0.spawner.origin = var_0.origin;
  var_0.spawner.angles = var_0.angles;
  if(isDefined(var_1)) {
    var_0.spawner.target = var_1;
  }

  var_0.spawner.var_C1 = var_0.spawner.var_C1 + 1;
  var_5 = var_0.spawner func_8393();
  var_6 = scripts\sp\utility::func_106ED(var_5);
  if(var_6) {}

  var_5.var_131F5 = var_0.var_131F5;
  var_5.var_1321D = var_0.var_1321D;
  var_5.var_10B71 = var_0.var_10B71;
  var_5.var_72A4 = var_0.var_72A4;
  var_0.spawner.origin = var_2;
  var_0.spawner.angles = var_3;
  var_0.spawner.target = var_4;
  var_0 delete();
  return var_5;
}

func_10868(var_0, var_1) {
  if(!isDefined(var_0.spawner)) {}

  var_2 = var_0.spawner.origin;
  var_3 = var_0.spawner.angles;
  var_4 = var_0.spawner.target;
  var_0.spawner.origin = var_0.origin;
  var_0.spawner.angles = var_0.angles;
  if(isDefined(var_1)) {
    var_0.spawner.target = var_1;
  }

  var_0.spawner.var_C1 = var_0.spawner.var_C1 + 1;
  var_5 = scripts\sp\utility::func_6B47(var_0.spawner);
  var_6 = scripts\sp\utility::func_106ED(var_5);
  if(var_6) {}

  var_5.var_131F5 = var_0.var_131F5;
  var_5.var_1321D = var_0.var_1321D;
  var_5.var_10B71 = var_0.var_10B71;
  var_5.var_72A4 = var_0.var_72A4;
  var_0.spawner.origin = var_2;
  var_0.spawner.angles = var_3;
  var_0.spawner.target = var_4;
  var_0 delete();
  return var_5;
}

func_1732() {
  var_0 = self.var_EE90;
  var_1 = self.var_EE91;
  if(!isDefined(level.var_A67E)) {
    level.var_A67E = [];
  }

  if(!isDefined(level.var_A67E[var_0])) {
    level.var_A67E[var_0] = [];
  }

  if(!isDefined(level.var_A67E[var_0][var_1])) {
    level.var_A67E[var_0][var_1] = [];
  }

  level.var_A67E[var_0][var_1][self.var_6A0B] = self;
}

func_177E() {
  var_0 = self.var_EEBA;
  var_1 = self.var_EEBB;
  if(!isDefined(level.var_10727[var_0])) {
    level.var_10727[var_0] = [];
  }

  if(!isDefined(level.var_10727[var_0][var_1])) {
    level.var_10727[var_0][var_1] = [];
  }

  level.var_10727[var_0][var_1][self.var_6A0B] = self;
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
  self func_81D0();
}

func_11AD7(var_0) {
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
    for(var_1 = 0; var_1 < 3; var_1++) {
      wait(0.2);
      scripts\sp\utility::func_9196(1, 0, 1, "tracker");
      wait(0.15);
      scripts\sp\utility::func_9193("tracker");
    }
  }
}