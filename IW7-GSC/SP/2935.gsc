/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2935.gsc
**************************************/

main() {
  level._id_10707 = [];
  level._id_10707["allies"] = [];
  level._id_10707["axis"] = [];
  level._id_10707["team3"] = [];
  level._id_10707["neutral"] = [];
  thread _id_8438();
  var_0 = getEntArray("flood_and_secure", "targetname");
  scripts\engine\utility::array_thread(var_0, ::_id_6F4C);

  if(!isDefined(level._id_19C9))
    level._id_19C9 = 0;

  if(getDvar("fallback") == "")
    setDvar("fallback", "0");

  if(getDvar("noai") == "")
    setDvar("noai", "off");

  precachemodel("grenade_bag");
  createthreatbiasgroup("allies");
  createthreatbiasgroup("axis");
  createthreatbiasgroup("team3");
  createthreatbiasgroup("civilian");
  createthreatbiasgroup("equipment");
  setthreatbias("axis", "equipment", 250);
  setthreatbias("allies", "equipment", 250);
  setthreatbias("team3", "equipment", -1000);
  _id_0B5F::_id_965A();

  foreach(var_2 in level.players)
  var_2 setthreatbiasgroup("allies");

  level._id_1162 = [];
  level._id_76F3 = [];

  if(!isDefined(level._id_4E3F))
    level._id_4E3F = [];

  level._id_1086A = 0;

  if(!isDefined(level._id_12BA5))
    level._id_12BA5 = [];

  var_4 = getspawnerarray();

  foreach(var_6 in var_4) {}

  level._id_12BA5["soldier"] = ::_id_10804;
  level._id_12BA5["c8"] = ::_id_10803;
  level._id_115BE = [];
  level._id_115BE["axis"] = ::_id_107ED;
  level._id_115BE["allies"] = ::_id_107EC;
  level._id_115BE["team3"] = ::_id_107EF;
  level._id_115BE["neutral"] = ::_id_107EE;

  if(!isDefined(level._id_4FF6))
    level._id_4FF6 = 2048;

  if(!isDefined(level._id_4FF5))
    level._id_4FF5 = 512;

  level._id_D66F = "J_Shoulder_RI";
  level._id_1349 = 0;
  var_8 = getaispeciesarray();
  scripts\engine\utility::array_thread(var_8, ::_id_AD8E);
  level._id_1923 = [];
  level._id_5C63 = [];
  var_9 = getspawnerarray();

  for(var_10 = 0; var_10 < var_9.size; var_10++)
    var_9[var_10] thread _id_107AB();

  level._id_5C63 = undefined;
  scripts\sp\utility::_id_9189("tracker", 1, "default");
  thread _id_D970();
  scripts\engine\utility::array_thread(var_8, ::_id_107F2);
  var_11 = getarraykeys(level._id_1923);

  for(var_10 = 0; var_10 < var_11.size; var_10++) {
    var_12 = tolower(var_11[var_10]);

    if(!issubstr(var_12, "rpg")) {
      continue;
    }
    var_13 = "iw7_lockon";
    precacheitem(var_13);
    break;
  }

  var_11 = undefined;
}

_id_1B09() {}

_id_D970() {
  foreach(var_2, var_1 in level._id_4E3F) {
    if(!isDefined(level.flag[var_2]))
      scripts\engine\utility::flag_init(var_2);
  }
}

_id_10729() {
  self endon("death");

  for(;;) {
    if(self.count > 0)
      self waittill("spawned");

    waittillframeend;

    if(!self.count)
      return;
  }
}

_id_1936() {
  level._id_4E3F[self._id_ED48]["ai"][self.unique_id] = self;
  var_0 = self.unique_id;
  var_1 = self._id_ED48;

  if(isDefined(self._id_ED49))
    _id_1382D();
  else
    self waittill("death");

  level._id_4E3F[var_1]["ai"][var_0] = undefined;
  _id_12DAA(var_1);
}

_id_131C1() {
  var_0 = self.unique_id;
  var_1 = self._id_ED48;

  if(!isDefined(level._id_4E3F) || !isDefined(level._id_4E3F[self._id_ED48])) {
    waittillframeend;

    if(!isDefined(self))
      return;
  }

  level._id_4E3F[var_1]["vehicles"][var_0] = self;
  self waittill("death");
  level._id_4E3F[var_1]["vehicles"][var_0] = undefined;
  _id_12DAA(var_1);
}

_id_1085A() {
  level._id_4E3F[self._id_ED48] = [];
  waittillframeend;

  if(!isDefined(self) || self.count == 0) {
    return;
  }
  self._id_1086A = level._id_1086A;
  level._id_1086A++;
  level._id_4E3F[self._id_ED48]["spawners"][self._id_1086A] = self;
  var_0 = self._id_ED48;
  var_1 = self._id_1086A;
  _id_10729();
  level._id_4E3F[var_0]["spawners"][var_1] = undefined;
  _id_12DAA(var_0);
}

_id_1323D() {
  level._id_4E3F[self._id_ED48] = [];
  waittillframeend;

  if(!isDefined(self)) {
    return;
  }
  self._id_1086A = level._id_1086A;
  level._id_1086A++;
  level._id_4E3F[self._id_ED48]["vehicle_spawners"][self._id_1086A] = self;
  var_0 = self._id_ED48;
  var_1 = self._id_1086A;
  _id_10729();
  level._id_4E3F[var_0]["vehicle_spawners"][var_1] = undefined;
  _id_12DAA(var_0);
}

_id_12DAA(var_0) {
  level notify("updating_deathflag_" + var_0);
  level endon("updating_deathflag_" + var_0);
  waittillframeend;

  foreach(var_3, var_2 in level._id_4E3F[var_0]) {
    if(getarraykeys(var_2).size > 0)
      return;
  }

  scripts\engine\utility::flag_set(var_0);
}

_id_C75A(var_0) {
  var_0 endon("death");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(!isai(var_1)) {
      continue;
    }
    var_1 thread scripts\sp\utility::_id_931D(0.15);
    var_1 scripts\sp\utility::_id_5514();
  }
}

_id_9409(var_0) {
  var_0 endon("death");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(!isai(var_1)) {
      continue;
    }
    var_1 thread scripts\sp\utility::_id_931D(0.15);
    var_1 scripts\sp\utility::_id_61E7();
  }
}

_id_12797(var_0) {
  var_0 waittill("trigger");
  var_1 = var_0._id_DC8F;
  var_2 = var_0.target;
  var_0 scripts\sp\utility::script_delay();

  if(isDefined(var_1))
    waittillframeend;

  var_3 = scripts\engine\utility::array_combine(getspawnerarray(var_2), vehicle_getspawnerarray(var_2));

  foreach(var_5 in var_3) {
    if(!isnonentspawner(var_5) && var_5.code_classname == "script_vehicle") {
      if(isDefined(var_5._id_EE2B) && var_5._id_EE2B == 1 || !isDefined(var_5.target))
        thread scripts\sp\vehicle::_id_13237(var_5);
      else
        var_5 thread scripts\sp\vehicle::_id_1080B();

      continue;
    }

    var_5 thread _id_12799();
  }

  if(isDefined(level._id_107A7))
    _id_12781(var_2);
}

_id_12781(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0, "targetname");

  if(getEntArray(var_0, "target").size <= 1)
    scripts\sp\utility::_id_51D6(var_1);

  var_2 = _id_7BC6(var_1);
  scripts\engine\utility::array_thread(var_2, ::_id_12799);
}

_id_7BC6(var_0) {
  var_1 = [];
  var_2 = [];

  foreach(var_4 in var_0) {
    if(!isDefined(var_4._id_EEB6)) {
      continue;
    }
    if(!isDefined(var_2[var_4._id_EEB6]))
      var_2[var_4._id_EEB6] = [];

    var_2[var_4._id_EEB6][var_2[var_4._id_EEB6].size] = var_4;
  }

  foreach(var_7 in var_2) {
    foreach(var_4 in var_7) {
      var_9 = _id_7C86(var_4, var_7.size);
      var_1[var_1.size] = var_9;
    }
  }

  return var_1;
}

_id_7C86(var_0, var_1) {
  if(!isDefined(level._id_1086B))
    level._id_1086B = [];

  if(!isDefined(level._id_1086B[var_0._id_EEB6]))
    level._id_1086B[var_0._id_EEB6] = _id_492A(var_0._id_EEB6);

  var_2 = level._id_1086B[var_0._id_EEB6];
  var_3 = var_2.pool[var_2._id_D653];
  var_2._id_D653++;
  var_2._id_D653 = var_2._id_D653 % var_2.pool.size;
  var_3.origin = var_0.origin;

  if(isDefined(var_0.angles))
    var_3.angles = var_0.angles;
  else if(isDefined(var_0.target)) {
    var_4 = getnode(var_0.target, "targetname");

    if(isDefined(var_4))
      var_3.angles = vectortoangles(var_4.origin - var_3.origin);
  }

  if(isDefined(level._id_107A6))
    var_3[[level._id_107A6]](var_0);

  if(isDefined(var_0.target))
    var_3.target = var_0.target;

  var_3.count = 1;
  return var_3;
}

_id_492A(var_0) {
  var_1 = getspawnerarray();
  var_2 = spawnStruct();
  var_3 = [];

  foreach(var_5 in var_1) {
    if(!isDefined(var_5._id_EEB6)) {
      continue;
    }
    if(var_5._id_EEB6 != var_0) {
      continue;
    }
    var_3[var_3.size] = var_5;
  }

  var_2._id_D653 = 0;
  var_2.pool = var_3;
  return var_2;
}

_id_12799() {
  self endon("death");
  scripts\sp\utility::script_delay();

  if(!isDefined(self))
    return undefined;

  if(isDefined(self._id_ED6E)) {
    var_0 = scripts\sp\utility::_id_5CC8(self);
    return undefined;
  } else if(isDefined(self._id_ED8A)) {
    var_0 = scripts\sp\utility::_id_6B47(self);
    return undefined;
  } else if(isDefined(self._id_ED1B)) {
    var_0 = scripts\sp\utility::_id_2C17(self);
    return undefined;
  } else if(!issubstr(self.classname, "actor"))
    return undefined;

  var_1 = isDefined(self._id_EED1) && scripts\engine\utility::flag("stealth_enabled") && !scripts\engine\utility::flag("stealth_spotted");

  if(isDefined(self._id_EDB3))
    var_0 = self _meth_8393(var_1);
  else
    var_0 = self dospawn(var_1);

  if(!scripts\sp\utility::_id_106ED(var_0)) {
    if(isDefined(self._id_ED39)) {
      if(self._id_ED39 == "heat")
        var_0 scripts\sp\utility::_id_61FF();

      if(self._id_ED39 == "cqb")
        var_0 scripts\sp\utility::_id_61E7();
    }
  }

  return var_0;
}

_id_12798(var_0) {
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

      if(!isDefined(var_6))
        var_6 = var_5 scripts\sp\utility::_id_7A8E();

      if(!isDefined(var_6)) {
        continue;
      }
      if(!isspawner(var_6))
        continue;
    }

    var_2 = 1;
    break;
  }

  var_0 waittill("trigger");
  var_0 scripts\sp\utility::script_delay();
  var_3 = getspawnerarray(var_1);

  foreach(var_5 in var_3)
  var_5 thread _id_1278A();
}

_id_1278A() {
  var_0 = _id_12789();
  var_1 = _id_12799();

  if(!isDefined(var_1)) {
    self delete();

    if(isDefined(var_0)) {
      var_1 = var_0 _id_12799();
      var_0 delete();

      if(!isDefined(var_1))
        return;
    } else
      return;
  }

  if(!isDefined(var_0)) {
    return;
  }
  var_1 waittill("death");

  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_0.count))
    var_0.count = 1;

  for(;;) {
    if(!isDefined(var_0)) {
      break;
    }

    var_2 = var_0 _id_12799();

    if(!isDefined(var_2)) {
      var_0 delete();
      break;
    }

    var_2 thread _id_DF23(var_0);
    var_2 waittill("death", var_3);

    if(!_id_D27A(var_2, var_3)) {
      if(!isDefined(var_0)) {
        break;
      }

      var_0.count++;
    }

    if(!isDefined(var_2)) {
      continue;
    }
    if(!isDefined(var_0)) {
      break;
    }

    if(!isDefined(var_0.count)) {
      break;
    }

    if(var_0.count <= 0) {
      break;
    }

    if(!scripts\sp\utility::_id_EF15())
      wait(randomfloatrange(1, 3));
  }

  if(isDefined(var_0))
    var_0 delete();
}

_id_12789() {
  if(isDefined(self.target)) {
    var_0 = getspawner(self.target, "targetname");

    if(isDefined(var_0) && isspawner(var_0))
      return var_0;
  }

  if(isDefined(self.script_linkto)) {
    var_0 = getspawner(self.script_linkto, "script_linkname");

    if(!isDefined(var_0))
      var_0 = scripts\sp\utility::_id_7A8E();

    if(isDefined(var_0) && isspawner(var_0))
      return var_0;
  }

  return undefined;
}

_id_6F5A(var_0) {
  scripts\engine\utility::array_thread(var_0, ::_id_6F59);
  scripts\engine\utility::array_thread(var_0, ::_id_6F5C);
}

_id_DF23(var_0) {
  var_0 endon("death");

  if(isDefined(self._id_EDAA)) {
    if(self._id_EDAA)
      return;
  }

  self waittill("death");

  if(!isDefined(self))
    var_0.count++;
}

_id_A617(var_0) {
  var_1 = var_0._id_EDF7;
  var_0 waittill("trigger");
  waittillframeend;
  waittillframeend;
  _id_A67F(var_1);
  _id_A622(var_0);
}

_id_A67F(var_0) {
  var_1 = getspawnerarray();
  var_2 = vehicle_getspawnerarray();
  var_3 = scripts\engine\utility::array_combine(var_1, var_2);

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    if(isDefined(var_3[var_4]._id_EDF7) && var_0 == var_3[var_4]._id_EDF7) {
      if(isnonentspawner(var_3[var_4]))
        var_3[var_4] notify("death");

      var_3[var_4] delete();
    }
  }
}

_id_A622(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.targetname) && var_0.targetname != "flood_spawner") {
    return;
  }
  var_0 delete();
}

_id_DC8F(var_0) {
  var_0 endon("death");
  var_1 = var_0._id_EE90;
  waittillframeend;

  if(!isDefined(level._id_A67E))
    level._id_A67E = [];

  if(!isDefined(level._id_A67E[var_1])) {
    return;
  }
  var_0 waittill("trigger");
  _id_4B09(var_1);
}

_id_4B09(var_0) {
  if(!isDefined(level._id_A67E))
    level._id_A67E = [];

  if(!isDefined(level._id_A67E[var_0])) {
    return;
  }
  var_1 = level._id_A67E[var_0];
  var_2 = getarraykeys(var_1);

  if(var_2.size <= 1) {
    return;
  }
  var_3 = scripts\engine\utility::random(var_2);
  var_1[var_3] = undefined;

  foreach(var_9, var_5 in var_1) {
    foreach(var_8, var_7 in var_5) {
      if(isDefined(var_7))
        var_7 delete();
    }

    level._id_A67E[var_0][var_9] = undefined;
  }
}

_id_61BD(var_0) {
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
    var_2[var_3] scripts\sp\utility::_id_F311(0);
    var_2[var_3] notify("emptied spawner");
  }

  var_0 notify("deleted spawners");
}

_id_A618(var_0) {
  var_1 = getspawnerarray();

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(!isDefined(var_1[var_2]._id_EDF7)) {
      continue;
    }
    if(var_0 != var_1[var_2]._id_EDF7) {
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
  if(!isDefined(level._id_8580) || !isDefined(level._id_8580[var_0])) {
    level._id_8581[var_0] = 0;
    level._id_8580[var_0] = [];
  }

  var_1 = level._id_8581[var_0];
  var_2 = level._id_8580[var_0][var_1];

  if(isDefined(var_2))
    var_2 delete();

  level._id_8580[var_0][var_1] = self;
  level._id_8581[var_0] = (var_1 + 1) % 16;
}

_id_1382D() {
  self endon("death");
  self waittill("pain_death");
}

_id_5CEE() {
  _id_1382D();

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self._id_C05C)) {
    return;
  }
  self.ignoreforfixednodesafecheck = 1;

  if(scripts\sp\utility::_id_93A6()) {
    if(scripts\sp\specialist_MAYBE::spawn_nanoshot())
      return;
  }

  if(self.grenadeammo <= 0) {
    return;
  }
  if(level.player scripts\sp\utility::_id_65DF("zero_gravity") && level.player scripts\sp\utility::_id_65DB("zero_gravity")) {
    return;
  }
  level._id_BF83--;

  if(level._id_BF83 > 0) {
    return;
  }
  level._id_BF83 = 2 + randomint(2);
  var_0 = 25;
  var_1 = 12;
  var_2 = self.origin + (randomint(var_0) - var_1, randomint(var_0) - var_1, 2) + (0, 0, 42);
  var_3 = (0, randomint(360), 90);
  thread _id_10720(var_2, var_3, self.team);
}

_id_10720(var_0, var_1, var_2) {
  if(isDefined(level._id_D9E5["mandatoryunlocks"]) && scripts\engine\utility::array_contains(level._id_D9E5["mandatoryunlocks"], "frag")) {
    return;
  }
  var_3 = spawn_grenade(var_0, var_2);
  var_3 setModel("grenade_bag");
  var_3.angles = var_1;
  var_3 hide();
  wait 0.7;

  if(!isDefined(var_3)) {
    return;
  }
  var_3 show();
}

_id_5CCA() {
  _id_0B24::_id_5C3A();
}

_id_6B48() {
  scripts\sp\fakeactor::_id_6B44();
}

_id_107AB() {
  level._id_1923[self.classname] = 1;

  if(isDefined(self._id_ED5B)) {
    switch (self._id_ED5B) {
      case "easy":
        if(level._id_7683 > 1)
          scripts\sp\utility::_id_F311(0);

        break;
      case "hard":
        if(level._id_7683 < 2)
          scripts\sp\utility::_id_F311(0);

        break;
    }
  }

  _id_9769();

  if(isDefined(self._id_ED6E))
    thread _id_5CCA();

  if(isDefined(self._id_ED8A))
    thread _id_6B48();

  if(isDefined(self._id_ECE7)) {
    var_0 = self._id_ECE7;

    if(!isDefined(level._id_1162[var_0]))
      _id_1A12(var_0);

    thread _id_1A17(level._id_1162[var_0]);
  }

  if(isDefined(self._id_ED54)) {
    var_1 = 0;

    if(isDefined(level._id_1160)) {
      if(isDefined(level._id_1160[self._id_ED54]))
        var_1 = level._id_1160[self._id_ED54].size;
    }

    level._id_1160[self._id_ED54][var_1] = self;
  }

  if(isDefined(self._id_EDD7)) {
    if(self._id_EDD7 > level._id_1349)
      level._id_1349 = self._id_EDD7;

    var_1 = 0;

    if(isDefined(level._id_1164)) {
      if(isDefined(level._id_1164[self._id_EDD7]))
        var_1 = level._id_1164[self._id_EDD7].size;
    }

    level._id_1164[self._id_EDD7][var_1] = self;
  }

  if(isDefined(self._id_ED48))
    thread _id_1085A();

  if(isDefined(self.target))
    _id_486E(self.target);

  if(isDefined(self._id_EEBA))
    _id_177E();

  if(isDefined(self._id_EE90))
    _id_1732();

  if(!isDefined(self._id_10708))
    self._id_10708 = [];

  for(;;) {
    self waittill("spawned", var_2);

    if(!isalive(var_2)) {
      continue;
    }
    if(isDefined(level._id_10877))
      self thread[[level._id_10877]](var_2);

    if(isDefined(self._id_ED54)) {
      for(var_3 = 0; var_3 < level._id_1160[self._id_ED54].size; var_3++) {
        if(level._id_1160[self._id_ED54][var_3] != self)
          level._id_1160[self._id_ED54][var_3] delete();
      }
    }

    var_2._id_10707 = self._id_10708;
    var_2._id_10708 = undefined;
    var_2.spawner = self;

    if(isDefined(self.targetname)) {
      var_2 thread _id_107F2(self.targetname);
      continue;
    }

    var_2 thread _id_107F2();
  }
}

_id_9769() {
  if(!isDefined(self._id_EECE) && !isDefined(self._id_EED1)) {
    return;
  }
  if(isDefined(self._id_EECE) && !isDefined(self._id_EED1))
    self._id_EED1 = self._id_EECE;

  self._id_EECE = undefined;
}

_id_107F2(var_0) {
  level._id_1923[self.classname] = 1;

  if(isDefined(self.asmname) && self.asmname == "seeker") {
    return;
  }
  _id_107F3(var_0);
  self endon("death");

  if(_id_1003C())
    self delete();

  thread _id_E81A();
  self._id_6CDA = 1;
  self notify("finished spawning");
}

_id_1003C() {
  if(!isDefined(self._id_ED5B))
    return 0;

  var_0 = 0;

  switch (self._id_ED5B) {
    case "easy":
      if(level._id_7683 > 1)
        var_0 = 1;

      break;
    case "hard":
      if(level._id_7683 < 2)
        var_0 = 1;

      break;
  }

  return var_0;
}

_id_E81A() {
  if(!isDefined(self._id_10707)) {
    self.spawner = undefined;
    return;
  }

  for(var_0 = 0; var_0 < self._id_10707.size; var_0++) {
    var_1 = self._id_10707[var_0];

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

  var_2 = scripts\engine\utility::ter_op(isDefined(level.vehicle._id_10709) && level.vehicle._id_10709 && self.code_classname == "script_vehicle", self.script_team, self.team);

  if(isDefined(var_2)) {
    for(var_0 = 0; var_0 < level._id_10707[var_2].size; var_0++) {
      var_1 = level._id_10707[var_2][var_0];

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

  self._id_10707 = undefined;
  self.spawner = undefined;
}

_id_4E47() {
  self waittill("death", var_0, var_1, var_2);
  level notify("ai_killed", self, var_0, var_1, var_2);

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(var_0)) {
    scripts\anim\utility_common::repeater_headshot_ammo_passive(var_2, var_0, self);

    if(self.team == "axis" || self.team == "team3") {
      var_3 = undefined;

      if(isDefined(var_0.attacker)) {
        if(isDefined(var_0._id_9F45) && var_0._id_9F45)
          var_3 = "sentry";

        if(isDefined(var_0._id_00ED))
          var_3 = "destructible";

        var_0 = var_0.attacker;
      } else if(isDefined(var_0.owner)) {
        if(isai(var_0) && isPlayer(var_0.owner))
          var_3 = "friendly";

        var_0 = var_0.owner;
      } else if(isDefined(var_0.damageowner)) {
        if(isDefined(var_0._id_00ED))
          var_3 = "destructible";

        var_0 = var_0.damageowner;
      }

      var_4 = 0;

      if(isPlayer(var_0))
        var_4 = 1;

      if(isDefined(level._id_D5ED) && level._id_D5ED)
        var_4 = 1;

      if(var_4)
        var_0 scripts\sp\player_stats::_id_DEBD(self, var_1, var_2, var_3);
    }
  }
}

_id_1931() {
  self._id_4CF5 = [];

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    self._id_C873 = var_0;

    if(isDefined(var_1) && isPlayer(var_1)) {
      var_10 = var_1 getcurrentweapon();

      if(isDefined(var_10) && scripts\sp\utility::isprimaryweapon(var_10) && isDefined(var_4) && (var_4 == "MOD_PISTOL_BULLET" || var_4 == "MOD_RIFLE_BULLET"))
        var_1 thread scripts\sp\player_stats::_id_DED8();

      var_11 = getweaponbasename(var_10);

      if(isDefined(var_11) && var_11 == "iw7_m4" && scripts\sp\utility::_id_9FFE(var_10))
        thread _id_11AD7(var_3);
    }

    foreach(var_13 in self._id_4CF5)
    thread[[var_13]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(!isalive(self) || self.delayeddeath) {
      break;
    }
  }
}

_id_AD8E() {
  _id_9769();

  if(isDefined(self.target))
    _id_486E(self.target);
}

_id_486E(var_0) {
  var_1 = _id_7CDA(var_0);

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

    if(isDefined(var_3._id_4871)) {
      continue;
    }
    var_3._id_4871 = 1;
    level thread _id_DFE2(var_3);

    if(isDefined(var_3._id_ED9E)) {
      if(!isDefined(level.flag[var_3._id_ED9E]))
        scripts\engine\utility::flag_init(var_3._id_ED9E);
    }

    if(isDefined(var_3._id_EDA0)) {
      if(!isDefined(level.flag[var_3._id_EDA0]))
        scripts\engine\utility::flag_init(var_3._id_EDA0);
    }

    if(isDefined(var_3._id_ED9B)) {
      if(!isDefined(level.flag[var_3._id_ED9B]))
        scripts\engine\utility::flag_init(var_3._id_ED9B);
    }

    if(isDefined(var_3.target)) {
      var_4 = _id_7CDA(var_3.target);

      foreach(var_6 in var_4) {
        if(!isDefined(var_6._id_4871))
          var_1[var_1.size] = var_6;
      }
    }
  }
}

_id_DFE2(var_0) {
  waittillframeend;

  if(isDefined(var_0))
    var_0._id_4871 = undefined;
}

_id_107EC() {
  self.usechokepoints = 0;
  _id_3DF4();
}

_id_107ED() {
  if(self.unittype == "soldier" && !isDefined(level._id_55F0))
    thread _id_5CEE();

  _id_3DF4();
  scripts\sp\utility::_id_16B7(scripts\sp\gameskill::_id_2627);

  if(isDefined(self._id_ED3A))
    self.combatmode = self._id_ED3A;
}

_id_3DF4() {
  var_0["crew"] = 1;
  var_0["no_boost"] = 1;

  if(isDefined(self.subclass) && isDefined(var_0[self.subclass]))
    self _meth_8504(0, "soldier_boost");
}

_id_107EF() {
  _id_107ED();
  _id_3DF4();
}

_id_107EE() {
  _id_3DF4();
}

_id_10804() {}

_id_10803() {
  self._id_C05C = 1;
  self._id_2894 = 1000;
  self.attackeraccuracy = 0.1;
}

_id_107F4() {
  scripts\sp\gameskill::_id_4FE9();
  scripts\sp\gameskill::grenadeawareness();
}

_id_19BB() {
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

_id_107F5() {
  if(isDefined(self._id_ED6B)) {
    self._id_596C = 1;
    self._id_ED6B = undefined;
  }

  if(isDefined(self._id_ED48))
    thread _id_1936();

  if(isDefined(self._id_ECFD)) {
    self.attackeraccuracy = self._id_ECFD;
    self._id_ECFD = undefined;
  }

  if(isDefined(self._id_EECC)) {
    thread _id_10CC6();
    self._id_EECC = undefined;
  }

  if(isDefined(self._id_ED4B))
    thread deathtime();

  if(isDefined(self._id_EE62)) {
    scripts\sp\utility::_id_558D();
    self._id_EE62 = undefined;
  }

  if(isDefined(self._id_EE57)) {
    self._id_10264 = 1;
    self._id_EE57 = undefined;
  }

  if(isDefined(self._id_ECF8)) {
    self._id_1FBB = self._id_ECF8;
    self._id_ECF8 = undefined;
  }

  if(isDefined(self._id_EDFC))
    thread _id_19BB();

  if(isDefined(self._id_ED42)) {
    var_0 = self._id_ED42;

    if(var_0 == 1)
      var_0 = 8;

    scripts\sp\utility::_id_61EB(var_0);
  }

  if(isDefined(self._id_ED89))
    self.maxfaceenemydist = self._id_ED89;
  else if(!self.space)
    self.maxfaceenemydist = 512;

  if(isDefined(self._id_EDAD))
    scripts\sp\utility::_id_F3B5(self._id_EDAD);

  if(isDefined(self._id_595C))
    self.dropweapon = 0;

  if(isDefined(self._id_ED99)) {
    self.fixednode = self._id_ED99 == 1;
    self._id_ED99 = undefined;
  } else
    self.fixednode = self.team == "allies";

  if(isDefined(self._id_EE54) && self._id_EE54 == 1) {
    self._id_C010 = 1;
    self._id_EE54 = undefined;
  }

  self.providecoveringfire = self.team == "allies" && self.fixednode;

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "mgpair")
    thread scripts\sp\mg_penetration::_id_491C();

  if(isDefined(self._id_EDCF) && !(isDefined(self._id_EE2B) && self._id_EE2B == 1 || isDefined(self._id_EED1)))
    thread _id_F3DE();

  if(isDefined(self._id_EEE2))
    self setthreatbiasgroup(self._id_EEE2);
  else if(self.team == "neutral")
    self setthreatbiasgroup("civilian");
  else
    self setthreatbiasgroup(self.team);

  if(isDefined(self._id_ED17))
    scripts\sp\utility::_id_F2DA(self._id_ED17);

  if(isDefined(self._id_ECE5)) {
    self._id_2894 = self._id_ECE5;
    self._id_ECE5 = undefined;
  }

  if(isDefined(self._id_EDE4)) {
    self.ignoreme = 1;
    self._id_EDE4 = undefined;
  }

  if(isDefined(self._id_EDE2)) {
    self.ignoresuppression = 1;
    self._id_EDE2 = undefined;
  }

  if(isDefined(self._id_EDE3)) {
    self.ignoreall = 1;
    self clearenemy();
  }

  if(isDefined(self._id_EE55)) {
    self._id_C012 = 1;
    self._id_EE55 = undefined;
  }

  if(isDefined(self._id_ED90)) {
    if(self._id_ED90 == "player") {
      self.favoriteenemy = level.player;
      level.player.targetname = "player";
    }
  }

  if(isDefined(self._id_EEAA)) {
    self.maxsightdistsqrd = self._id_EEAA;
    self._id_EEAA = undefined;
  }

  if(isDefined(self._id_ED92)) {
    self.pathenemyfightdist = self._id_ED92;
    self._id_ED92 = undefined;
  }

  if(isDefined(self._id_EE10)) {
    self.pathenemylookahead = self._id_EE10;
    self._id_EE10 = undefined;
  }

  if(isDefined(self._id_EE05)) {
    self.a.disablelongdeath = 1;
    self._id_EE05 = undefined;
  }

  if(isDefined(self._id_ED5A)) {
    self.diequietly = 1;
    self._id_ED5A = undefined;
  }

  if(isDefined(self._id_EE5F)) {
    self.noragdoll = 1;
    self._id_EE5F = undefined;
  }

  if(isDefined(self._id_EE71)) {
    self.pacifist = 1;
    self._id_EE71 = undefined;
  }

  if(isDefined(self._id_ED22)) {
    scripts\sp\utility::_id_B14F();
    self._id_ED22 = undefined;
  }

  if(isDefined(self._id_EEC8)) {
    self.health = self._id_EEC8;
    self._id_EEC8 = undefined;
  }

  if(isDefined(self._id_EE5A)) {
    self._id_C05C = self._id_EE5A;
    self._id_EE5A = undefined;
  }

  if(isDefined(self._id_ED56)) {
    scripts\sp\utility::_id_51E1(self._id_ED56);
    self._id_ED56 = undefined;
  }

  if(scripts\sp\utility::_id_93A6() && self.team == "axis") {
    self._id_2894 = self._id_2894 * 3.25;
    self.accuracy = self.accuracy * 3.25;
  }
}

_id_10662() {
  if(isDefined(self._id_EEA6)) {
    self.bt.forceselfdestructtimer = gettime() + self._id_EEA6 * 1000;
    self._id_EEA6 = undefined;
  } else if(isDefined(self._id_EEA5)) {
    self.bt.forceselfdestructtimer = 1;
    self._id_EEA5 = undefined;
  }
}

_id_107F3(var_0) {
  thread _id_1931();
  thread _id_114E6();

  if(!isDefined(level._id_193D))
    self thermaldrawenable();

  self._id_1086A = undefined;

  if(!isDefined(self.unique_id))
    scripts\sp\utility::_id_F294();

  thread _id_4E47();
  level thread scripts\sp\friendlyfire::_id_73B1(self);
  self.walkdist = 16;
  _id_9709();
  _id_107F4();
  _id_107F5();

  switch (self.unittype) {
    case "c6":
      _id_10662();
      break;
  }

  [[level._id_115BE[self.team]]]();

  if(isDefined(level._id_12BA5[self.unittype]))
    self thread[[level._id_12BA5[self.unittype]]]();

  thread scripts\sp\damagefeedback::monitordamage();
  _id_F3D8();

  if(isDefined(self._id_EE87)) {
    self setgoalentity(level.player);
    return;
  }

  if(isDefined(self._id_EED1)) {
    _id_0F18::_id_10E8B("do_stealth");
    return;
  }

  if(isDefined(self._id_EE7E) && !isDefined(self._id_EE2B)) {
    thread scripts\sp\patrol::_id_C97C();
    return;
  }

  if(isDefined(self._id_EE93) && self._id_EE93 == 1)
    scripts\sp\utility::_id_622F();

  if(isDefined(self._id_ED53)) {
    if(!isDefined(self.script_radius))
      self.goalradius = 800;

    self setgoalentity(level.player);
    level thread _id_50F5(self);
    return;
  }

  if(isDefined(self.used_an_mg42)) {
    return;
  }
  if(isDefined(self._id_EE2B) && self._id_EE2B == 1) {
    _id_F3D7();
    self setgoalpos(self.origin);
    return;
  }

  if(!isDefined(self._id_EED1)) {}

  _id_F3D7();

  if(isDefined(self.target))
    thread _id_8409();
}

_id_9709() {
  scripts\sp\utility::_id_F340();

  if(isDefined(self._id_EDD2))
    self.grenadeammo = self._id_EDD2;
  else
    self.grenadeammo = 3;

  if(isDefined(self.primaryweapon))
    self.noattackeraccuracymod = scripts\anim\utility_common::isasniper();

  self._id_BEFA = 1;
}

_id_EF8C() {
  if(self.team == "neutral")
    self setthreatbiasgroup("civilian");
  else
    self setthreatbiasgroup(self.team);

  _id_9709();
  self._id_2894 = 1;
  scripts\sp\gameskill::grenadeawareness();
  scripts\sp\utility::_id_414F();
  self.interval = 96;
  self.disablearrivals = undefined;
  self.ignoreme = 0;
  self.ignoreall = 0;
  self.threatbias = 0;
  self.pacifist = 0;
  self.pacifistwait = 20;
  self.ignorerandombulletdamage = 0;
  self.pushable = 1;
  self.script_pushable = 1;
  self.allowdeath = 0;
  self.anglelerprate = 540;
  self.badplaceawareness = 0.75;
  self.dontavoidplayer = 0;
  self.drawoncompass = 1;
  self.dropweapon = 1;
  self.goalradius = level._id_4FF6;
  self.goalheight = level._id_4FF5;
  self.ignoresuppression = 0;
  self _meth_8250(0);

  if(isDefined(self._id_B14F) && self._id_B14F)
    scripts\sp\utility::_id_1101B();

  scripts\sp\utility::_id_5575();
  self.maxsightdistsqrd = 67108864;
  self.script_forcegrenade = 0;
  self.walkdist = 16;
  self.pushable = 1;
  self.script_pushable = 1;
  scripts\anim\init::_id_F2B0();
  self.fixednode = self.team == "allies";
}

_id_50F5(var_0) {
  var_0 endon("death");

  while(isalive(var_0)) {
    if(var_0.goalradius > 200)
      var_0.goalradius = var_0.goalradius - 200;

    wait 6;
  }
}

_id_6E4B(var_0) {
  self endon("death");

  if(!self._id_6E66) {
    var_0.used_an_mg42 = 1;
    self._id_6E66 = 1;
    var_0 waittill("death");
    self._id_6E66 = 0;
    self notify("get new user");
  }
}

_id_F3DE() {
  self endon("death");
  waittillframeend;

  if(isDefined(self.team) && self.team == "allies")
    self.fixednode = 0;

  var_0 = level._id_8438[self._id_EDCF];

  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.target)) {
    var_1 = getnode(var_0.target, "targetname");
    var_2 = getEnt(var_0.target, "targetname");
    var_3 = scripts\engine\utility::getStruct(var_0.target, "targetname");
    var_4 = undefined;

    if(isDefined(var_1)) {
      var_4 = var_1;
      self _meth_82EE(var_4);
    } else if(isDefined(var_2)) {
      var_4 = var_2;
      self setgoalpos(var_4.origin);
    } else if(isDefined(var_3)) {
      var_4 = var_3;
      self setgoalpos(var_4.origin);
    }

    if(isDefined(var_4.radius) && var_4.radius != 0)
      self.goalradius = var_4.radius;

    if(isDefined(var_4.goalheight) && var_4.goalheight != 0)
      self.goalheight = var_4.goalheight;
  }

  if(isDefined(self.target))
    self _meth_82F0(var_0);
  else
    self _meth_82F1(var_0);
}

_id_7CDA(var_0) {
  var_1 = getnodearray(var_0, "targetname");
  var_2 = scripts\engine\utility::getStructArray(var_0, "targetname");

  foreach(var_4 in var_2)
  var_1[var_1.size] = var_4;

  var_2 = getEntArray(var_0, "targetname");

  foreach(var_4 in var_2) {
    if(isspawner(var_4) || var_4.code_classname == "trigger_multiple" || var_4.code_classname == "trigger_once" || var_4.code_classname == "trigger_radius") {
      continue;
    }
    var_1[var_1.size] = var_4;
  }

  return var_1;
}

_id_C035(var_0) {
  return isDefined(var_0.radius) && var_0.radius != 0;
}

_id_8409(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(self.used_an_mg42)) {
    return;
  }
  if(!isDefined(var_0)) {
    var_5 = _id_7CDA(self.target);

    if(var_5.size == 0) {
      self notify("reached_path_end");
      return;
    }
  } else if(isarray(var_0))
    var_5 = var_0;
  else
    var_5[0] = var_0;

  _id_8414(var_5, var_2, var_3, var_4);
}

_id_7A7B(var_0) {
  if(var_0.size == 1)
    return var_0[0];

  var_0 = scripts\engine\utility::array_randomize(var_0);
  var_1 = var_0[0];

  if(!isDefined(var_1._id_13070))
    var_1._id_13070 = 0;

  foreach(var_3 in var_0) {
    if(!isDefined(var_3._id_13070))
      var_3._id_13070 = 0;

    if(var_3._id_13070 < var_1._id_13070)
      var_1 = var_3;
  }

  var_1._id_13070 = gettime();
  return var_1;
}

_id_8414(var_0, var_1, var_2, var_3) {
  self notify("stop_going_to_node");
  self endon("stop_going_to_node");
  self endon("death");
  var_4 = scripts\engine\utility::ter_op(isDefined(var_2), var_2, 300);

  for(;;) {
    var_0 = _id_7A7B(var_0);

    if(isDefined(var_0._id_EE95)) {
      if(var_0._id_EE95 > 1)
        var_4 = var_0._id_EE95;

      var_0._id_EE95 = 0;
    }

    if(_id_C035(var_0))
      self.goalradius = var_0.radius;

    if(isDefined(var_0.height))
      self.goalheight = var_0.height;

    if(isDefined(var_0._id_ED56))
      scripts\sp\utility::_id_51E1(var_0._id_ED56);

    if(isDefined(var_0._id_EE71))
      self.pacifist = var_0._id_EE71;

    if(isDefined(var_0._id_EDE3))
      self.ignoreall = var_0._id_EDE3;

    if(isDefined(var_0._id_EDE4))
      self.ignoreme = var_0._id_EDE4;

    if(isDefined(self._id_10E6D))
      _id_0F18::_id_10E8A("go_to_node_wait", ::_id_840F, var_0);
    else {
      _id_840F(var_0);
      self waittill("goal");
    }

    var_0 notify("trigger", self);

    if(isDefined(self._id_10E6D))
      _id_0F18::_id_10E8A("go_to_node_arrive", ::_id_840F, var_0);

    if(isDefined(var_1))
      [[var_1]](var_0);

    if(isDefined(var_0._id_ED9E))
      scripts\engine\utility::flag_set(var_0._id_ED9E);

    if(isDefined(var_0._id_ED80))
      scripts\sp\utility::_id_65E1(var_0._id_ED80);

    if(isDefined(var_0._id_ED9B))
      scripts\engine\utility::flag_clear(var_0._id_ED9B);

    if(_id_1157F(var_0))
      return 1;

    var_0 scripts\sp\utility::script_delay();

    if(isDefined(var_0.script_soundalias))
      self playSound(var_0.script_soundalias);

    if(isDefined(var_0._id_EDC7))
      thread scripts\sp\utility::_id_77B7(var_0._id_EDC7);

    if(isDefined(var_0._id_EDA0))
      scripts\engine\utility::flag_wait(var_0._id_EDA0);

    if(isDefined(var_0._id_ED81))
      scripts\sp\utility::_id_65E3(var_0._id_ED81);

    var_0 scripts\sp\utility::_id_EF15();

    if(isDefined(self._id_D6EE))
      [[self._id_D6EE]]();

    if(isDefined(var_0.script_delay_post))
      wait(var_0.script_delay_post);

    while(isDefined(var_0._id_EE95)) {
      var_0._id_EE95 = 0;

      if(_id_8416(var_0, ::_id_7CDA, var_4)) {
        var_0._id_EE95 = 1;
        var_0 notify("script_requires_player");
        break;
      }

      wait 0.1;
    }

    if(isDefined(var_0._id_ED57))
      scripts\sp\utility::_id_51E1(var_0._id_ED57);

    if(isDefined(var_3))
      [[var_3]](var_0);

    if(isDefined(var_0._id_ED43) && var_0._id_ED43)
      scripts\sp\utility::_id_54C6();

    if(isDefined(var_0._id_ED54) && var_0._id_ED54) {
      if(isDefined(self._id_B14F))
        scripts\sp\utility::_id_1101B();

      self delete();
    }

    if(!isDefined(var_0.target)) {
      break;
    }

    var_5 = _id_7CDA(var_0.target);

    if(!var_5.size) {
      break;
    }

    var_0 = var_5;
  }

  self notify("reached_path_end");

  if(isDefined(self._id_EDB0)) {
    return;
  }
  if(isDefined(self._id_527B) && self._id_527B == "patrol") {
    return;
  }
  if(isDefined(self _meth_812A()))
    self _meth_82F1(self _meth_812A());
  else
    self.goalradius = level._id_4FF6;
}

_id_8416(var_0, var_1, var_2) {
  foreach(var_4 in level.players) {
    if(distancesquared(var_4.origin, var_0.origin) < distancesquared(self.origin, var_0.origin))
      return 1;
  }

  if(!isDefined(var_0._id_ED5F)) {
    var_6 = anglesToForward(self.angles);

    if(isDefined(var_0.target)) {
      var_7 = [[var_1]](var_0.target);

      if(var_7.size == 1)
        var_6 = vectorNormalize(var_7[0].origin - var_0.origin);
      else if(isDefined(var_0.angles))
        var_6 = anglesToForward(var_0.angles);
    } else if(isDefined(var_0.angles))
      var_6 = anglesToForward(var_0.angles);

    var_8 = [];

    foreach(var_4 in level.players)
    var_8[var_8.size] = vectorNormalize(var_4.origin - self.origin);

    foreach(var_12 in var_8) {
      if(vectordot(var_6, var_12) > 0)
        return 1;
    }
  }

  var_14 = var_2 * var_2;

  foreach(var_4 in level.players) {
    if(distancesquared(var_4.origin, self.origin) < var_14)
      return 1;
  }

  return 0;
}

_id_8413(var_0) {
  if(!isDefined(var_0))
    return 1;

  if(!isDefined(var_0.target))
    return 1;

  if(isDefined(var_0.script_delay))
    return 1;

  if(isDefined(var_0._id_EF15))
    return 1;

  if(isDefined(var_0._id_EF1A))
    return 1;

  if(isDefined(var_0._id_EF1C))
    return 1;

  if(isDefined(var_0._id_EF1B))
    return 1;

  if(isDefined(var_0._id_EDA0))
    return 1;

  if(isDefined(var_0._id_ED81))
    return 1;

  if(isDefined(var_0.script_delay_post))
    return 1;

  if(isDefined(var_0._id_EE95))
    return 1;

  return 0;
}

_id_840F(var_0) {
  if(isnode(var_0))
    _id_8411(var_0);
  else if(isstruct(var_0))
    _id_8412(var_0);
  else if(isent(var_0))
    _id_8410(var_0);

  if(isstruct(var_0) || isnode(var_0))
    var_0._id_C9A7 = _id_8413(var_0);
}

_id_8410(var_0) {
  if(var_0.classname == "info_volume") {
    self _meth_82F1(var_0);
    self notify("go_to_node_new_goal");
    return;
  }

  _id_8412(var_0);
}

_id_8412(var_0) {
  scripts\sp\utility::_id_F3D3(var_0);
  self notify("go_to_node_new_goal");
}

_id_8411(var_0) {
  scripts\sp\utility::_id_F3D9(var_0);
  self notify("go_to_node_new_goal");
}

_id_1157F(var_0) {
  if(!isDefined(var_0.target))
    return 0;

  var_1 = getEntArray(var_0.target, "targetname");

  if(!var_1.size)
    return 0;

  var_2 = var_1[0];

  if(!issubstr(var_2.classname, "misc_turret"))
    return 0;

  thread _id_12F9C(var_2);
  return 1;
}

_id_F3D8() {
  if(isDefined(self._id_EDCD))
    self.goalheight = self._id_EDCD;
  else
    self.goalheight = level._id_4FF5;
}

_id_F3D7(var_0) {
  if(isDefined(self.script_radius)) {
    self.goalradius = self.script_radius;
    return;
  }

  if(isDefined(self._id_EDB0)) {
    if(isDefined(var_0) && isDefined(var_0.radius)) {
      self.goalradius = var_0.radius;
      return;
    }
  }

  if(!isDefined(self _meth_812A())) {
    if(self.type == "civilian")
      self.goalradius = 128;
    else
      self.goalradius = level._id_4FF6;
  }
}

_id_2697(var_0) {
  for(;;) {
    var_1 = self _meth_8165();

    if(!isalive(var_1)) {
      wait 1.5;
      continue;
    }

    if(!isDefined(var_1.enemy)) {
      self settargetentity(scripts\engine\utility::random(var_0));
      self notify("startfiring");
      self _meth_8398();
    }

    wait(2 + randomfloat(1));
  }
}

_id_B321(var_0) {
  for(;;) {
    self settargetentity(scripts\engine\utility::random(var_0));
    self notify("startfiring");
    self _meth_8398();
    wait(2 + randomfloat(1));
  }
}

_id_12F9C(var_0) {
  self endon("stop_using_turret");
  self endon("death");

  if(self isbadguy() && self.health == 150) {
    self.health = 100;
    self.a.disablelongdeath = 1;
  }

  scripts\asm\asm_bb::_id_296E(var_0);

  while(!isDefined(self _meth_8164()) || self _meth_8164() != var_0)
    wait 0.05;

  if(isDefined(var_0.target) && var_0.target != var_0.targetname) {
    var_1 = getEntArray(var_0.target, "targetname");
    var_2 = [];

    for(var_3 = 0; var_3 < var_1.size; var_3++) {
      if(var_1[var_3].classname == "script_origin")
        var_2[var_2.size] = var_1[var_3];
    }

    if(isDefined(var_0._id_ED0F))
      var_0 thread _id_2697(var_2);
    else if(isDefined(var_0._id_EE07)) {
      var_0 setmode("manual_ai");
      var_0 thread _id_B321(var_2);
    } else if(var_2.size > 0) {
      if(var_2.size == 1) {
        var_0._id_B319 = var_2[0];
        var_0 settargetentity(var_2[0]);
        thread scripts\sp\mgturret::_id_B31A(var_0);
      } else
        var_0 thread scripts\sp\mgturret::_id_B6A8(var_2);
    }
  }

  thread _id_D31C(var_0);
  thread scripts\sp\mgturret::_id_B6A3(var_0);
  var_0 notify("startfiring");
}

_id_D31C(var_0) {
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
      if(level.player useButtonPressed()) {
        var_2 = 1;
        break;
      }

      wait 0.05;
    }
  }

  var_1 delete();
  _id_11054();
}

_id_11054() {
  self notify("stop_using_turret");
  self notify("stop_using_built_in_burst_fire");
  var_0 = self _meth_8164();

  if(!isDefined(var_0)) {
    return;
  }
  self _meth_83AF();
  scripts\asm\asm_bb::_id_296E(undefined);
  self _meth_83A1();
  var_0 _meth_83A3();
}

_id_73D9(var_0) {
  var_1 = getnode(var_0.target, "targetname");
  var_2 = getEnt(var_1.target, "targetname");
  var_2 setmode("auto_ai");
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
    if(isDefined(var_4._id_EF00) && var_4._id_EF00 == 0) {
      continue;
    }
    if(var_4 thread _id_73D7(var_2, var_1)) {
      var_4 thread _id_73D6(var_2, var_1);
      var_2 waittill("friendly_finished_using_mg42");

      if(isalive(var_4))
        var_4._id_12A4D = gettime() + 10000;
    }

    wait 1;
  }
}

_id_73D2(var_0, var_1) {
  var_1 endon("friendly_finished_using_mg42");
  var_0 waittill("death");
  var_1 notify("friendly_finished_using_mg42");
}

_id_73D8(var_0) {
  var_0 endon("friendly_finished_using_mg42");
  self.useable = 1;
  self setCursorHint("HINT_NOICON");
  self setHintString(&"PLATFORM_USEAIONMG42");
  self waittill("trigger");
  self.useable = 0;
  self setHintString("");
  self _meth_83AF();
  self notify("stopped_use_turret");
  var_0 notify("friendly_finished_using_mg42");
}

_id_73D7(var_0, var_1) {
  if(self.useable)
    return 0;

  if(isDefined(self._id_12A4D) && gettime() < self._id_12A4D)
    return 0;

  if(distance(level.player.origin, var_1.origin) < 100)
    return 0;

  return 1;
}

_id_73D4(var_0, var_1) {
  var_0 endon("friendly_finished_using_mg42");
  self waittill("trigger");
  var_0 notify("friendly_finished_using_mg42");
}

_id_73D5() {
  if(!isDefined(self._id_73D0)) {
    return;
  }
  self._id_73D0 notify("friendly_finished_using_mg42");
}

_id_C05F() {
  self endon("death");
  self waittill("goal");
  self.goalradius = self.oldradius;

  if(self.goalradius < 32)
    self.goalradius = 400;
}

_id_73D6(var_0, var_1) {
  self endon("death");
  var_0 endon("friendly_finished_using_mg42");
  level thread _id_73D2(self, var_0);
  self.oldradius = self.goalradius;
  self.goalradius = 28;
  thread _id_C05F();
  self _meth_82EE(var_1);
  self.ignoresuppression = 1;
  self waittill("goal");
  self.goalradius = self.oldradius;

  if(self.goalradius < 32)
    self.goalradius = 400;

  self.ignoresuppression = 0;
  self.goalradius = self.oldradius;

  if(distance(level.player.origin, var_1.origin) < 32) {
    var_0 notify("friendly_finished_using_mg42");
    return;
  }

  self._id_73D0 = var_0;
  thread _id_73D8(var_0);
  thread _id_73D1(var_0);
  self _meth_83D7(var_0);

  if(isDefined(var_0.target)) {
    var_2 = getEnt(var_0.target, "targetname");

    if(isDefined(var_2))
      var_2 thread _id_73D4(var_0, self);
  }

  for(;;) {
    if(distance(self.origin, var_1.origin) < 32)
      self _meth_83D7(var_0);
    else
      break;

    wait 1;
  }

  var_0 notify("friendly_finished_using_mg42");
}

_id_73D1(var_0) {
  self endon("death");
  var_0 waittill("friendly_finished_using_mg42");
  _id_73D3();
}

_id_73D3() {
  self endon("death");
  var_0 = self._id_73D0;
  self._id_73D0 = undefined;
  self _meth_83AF();
  self notify("stopped_use_turret");
  self.useable = 0;
  self.goalradius = self.oldradius;

  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_0.target)) {
    return;
  }
  var_1 = getnode(var_0.target, "targetname");
  var_2 = self.goalradius;
  self.goalradius = 8;
  self _meth_82EE(var_1);
  wait 2;
  self.goalradius = 384;
  return;
  self waittill("goal");

  if(isDefined(self.target)) {
    var_1 = getnode(self.target, "targetname");

    if(isDefined(var_1.target))
      var_1 = getnode(var_1.target, "targetname");

    if(isDefined(var_1))
      self _meth_82EE(var_1);
  }

  self.goalradius = var_2;
}

_id_114E6() {
  if(isDefined(level._id_C0B5)) {
    return;
  }
  if(isDefined(level.vehicle._id_8BBA) && !level.vehicle._id_8BBA) {
    return;
  }
  scripts\sp\utility::_id_16B7(::_id_114E7);
}

_id_114E7(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isDefined(self)) {
    return;
  }
  if(isalive(self)) {
    return;
  }
  if(!isalive(var_1)) {
    return;
  }
  if(!isDefined(var_1.vehicletype)) {
    return;
  }
  if(var_1 scripts\sp\vehicle::_id_9E2C()) {
    return;
  }
  if(!isDefined(self.noragdoll)) {
    if(isDefined(self._id_71C8))
      self[[self._id_71C8]]();

    self startragdoll();
  }

  if(!isDefined(self)) {
    return;
  }
  scripts\sp\utility::_id_DFE6(::_id_114E7);
}

_id_6F4C(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "instant_respawn")
    var_0 = 1;

  level._id_10881 = [];
  var_1 = getspawnerarray(self.target);
  scripts\engine\utility::array_thread(var_1, ::_id_6F50, var_0);
  var_2 = 0;
  var_3 = 0;

  for(;;) {
    self waittill("trigger", var_4);

    if(!var_3) {
      var_3 = 1;
      scripts\sp\utility::script_delay();
    }

    if(self istouching(level.player))
      var_2 = 1;
    else {
      if(!isalive(var_4)) {
        continue;
      }
      if(isPlayer(var_4))
        var_2 = 1;
      else if(!isDefined(var_4._id_9F73) || !var_4._id_9F73)
        continue;
    }

    var_1 = getspawnerarray(self.target);

    if(isDefined(var_1[0])) {
      if(isDefined(var_1[0]._id_EE91))
        _id_4B09(var_1[0]._id_EE91);
    }

    var_1 = getspawnerarray(self.target);

    for(var_5 = 0; var_5 < var_1.size; var_5++) {
      var_1[var_5]._id_D43F = var_2;
      var_1[var_5] notify("flood_begin");
    }

    if(var_2) {
      wait 5;
      continue;
    }

    wait 0.1;
  }
}

_id_6F50(var_0) {
  if(isDefined(self._id_F0DC)) {
    return;
  }
  self._id_F0DC = 1;
  self._id_127CC = 1;
  var_1 = self.target;
  var_2 = self.targetname;

  if(!isDefined(var_1) && !isDefined(self._id_EE2B))
    waittillframeend;

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
  _id_6F51(var_6, var_3.size > 0, var_0);

  if(isalive(var_6._id_1912))
    var_6._id_1912 waittill("death");

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
    var_4[var_5].targetname = var_2;
    var_8 = var_1;

    if(isDefined(var_4[var_5].target)) {
      var_9 = getspawner(var_4[var_5].target, "targetname");

      if(!isDefined(var_9) || !issubstr(var_9.classname, "actor"))
        var_8 = var_4[var_5].target;
    }

    var_4[var_5].target = var_8;
    var_4[var_5] thread _id_6F50(var_0);
    var_4[var_5]._id_D43F = 1;
    var_4[var_5] notify("flood_begin");
  }
}

_id_6F51(var_0, var_1, var_2) {
  self endon("death");
  var_3 = self.count;

  if(!var_1)
    var_1 = isDefined(self.script_noteworthy) && self.script_noteworthy == "delete";

  scripts\sp\utility::_id_F311(2);

  if(isDefined(self.script_delay))
    var_4 = self.script_delay;
  else
    var_4 = 0;

  for(;;) {
    self waittill("flood_begin");

    if(self._id_D43F) {
      break;
    }

    if(var_4) {
      continue;
    }
    break;
  }

  var_5 = distance(level.player.origin, self.origin);

  while(var_3) {
    self._id_12844 = var_3;
    scripts\sp\utility::_id_F311(2);
    wait(var_4);
    var_6 = isDefined(self._id_EED1) && scripts\engine\utility::flag("stealth_enabled") && !scripts\engine\utility::flag("stealth_spotted");

    if(isDefined(self._id_EDB3))
      var_7 = self _meth_8393(var_6);
    else
      var_7 = self dospawn(var_6);

    if(scripts\sp\utility::_id_106ED(var_7)) {
      var_8 = 0;

      if(var_4 < 2)
        wait 2;

      continue;
    } else {
      if(isDefined(self._id_ED39)) {
        if(self._id_ED39 == "heat")
          var_7 scripts\sp\utility::_id_61FF();

        if(self._id_ED39 == "cqb")
          var_7 scripts\sp\utility::_id_61E7();
      }

      thread _id_1865(var_7);
      var_7 thread _id_6F4D(self);

      if(isDefined(self._id_ECE5))
        var_7._id_2894 = self._id_ECE5;

      var_0._id_1912 = var_7;
      var_0 notify("got_ai");
      self waittill("spawn_died", var_9, var_8);

      if(var_4 > 2)
        var_4 = randomint(4) + 2;
      else
        var_4 = 0.5 + randomfloat(0.5);
    }

    if(var_9) {
      _id_13840(var_5);
      continue;
    }

    if(_id_D462(var_8 || var_1, var_0._id_1912))
      var_3--;

    if(!var_2)
      _id_13851();
  }

  self delete();
}

_id_1382E(var_0) {
  self endon("death");
  var_0 waittill("death");
}

_id_1865(var_0) {
  var_1 = self.targetname;

  if(!isDefined(level._id_10881[var_1])) {
    level._id_10881[var_1] = spawnStruct();
    level._id_10881[var_1] scripts\sp\utility::_id_F311(0);
    level._id_10881[var_1]._id_11A1D = 0;
  }

  if(!isDefined(self._id_17C5)) {
    self._id_17C5 = 1;
    level._id_10881[var_1]._id_11A1D++;
  }

  level._id_10881[var_1].count++;
  _id_1382E(var_0);
  level._id_10881[var_1].count--;

  if(!isDefined(self))
    level._id_10881[var_1]._id_11A1D--;

  if(level._id_10881[var_1]._id_11A1D) {
    if(level._id_10881[var_1].count / level._id_10881[var_1]._id_11A1D < 0.32)
      level._id_10881[var_1] notify("waveReady");
  }
}

_id_13851() {
  var_0 = self.targetname;

  if(level._id_10881[var_0].count)
    level._id_10881[var_0] waittill("waveReady");
}

_id_D462(var_0, var_1) {
  if(var_0)
    return 1;

  if(isDefined(var_1) && isDefined(var_1.origin))
    var_2 = var_1.origin;
  else
    var_2 = self.origin;

  if(distance(level.player.origin, var_2) < 700)
    return 1;

  return bullettracepassed(level.player getEye(), var_1 getEye(), 0, undefined);
}

_id_13840(var_0) {
  self endon("flood_begin");
  var_0 = var_0 * 0.75;

  while(distance(level.player.origin, self.origin) > var_0)
    wait 1;
}

_id_6F4D(var_0) {
  thread _id_6F4E();
  self waittill("death", var_1);
  var_2 = isalive(var_1) && isPlayer(var_1);

  if(!var_2 && isDefined(var_1) && var_1.classname == "worldspawn")
    var_2 = 1;

  var_3 = !isDefined(self);
  var_0 notify("spawn_died", var_3, var_2);
}

_id_6F4E() {
  if(isDefined(self._id_EE2B)) {
    return;
  }
  self endon("death");
  var_0 = getnode(self.target, "targetname");

  if(isDefined(var_0))
    self _meth_82EE(var_0);
  else {
    var_0 = getEnt(self.target, "targetname");

    if(isDefined(var_0))
      self setgoalpos(var_0.origin);
  }

  if(isDefined(level._id_6BDF)) {
    self.pathenemyfightdist = level._id_6BDF;
    self.pathenemylookahead = level._id_B491;
  }

  if(isDefined(var_0.radius) && var_0.radius >= 0)
    self.goalradius = var_0.radius;
  else
    self.goalradius = 256;

  self waittill("goal");

  while(isDefined(var_0.target)) {
    var_1 = getnode(var_0.target, "targetname");

    if(isDefined(var_1))
      var_0 = var_1;
    else
      break;

    self _meth_82EE(var_0);

    if(_id_C035(var_0))
      self.goalradius = var_0.radius;
    else
      self.goalradius = 256;

    self waittill("goal");
  }

  if(isDefined(self.script_noteworthy)) {
    if(self.script_noteworthy == "delete") {
      self _meth_81D0();
      return;
    }
  }

  if(isDefined(var_0.target)) {
    var_2 = getEnt(var_0.target, "targetname");

    if(isDefined(var_2) && var_2.code_classname == "misc_turret") {
      self _meth_82EE(var_0);
      self.goalradius = 4;
      self waittill("goal");

      if(!isDefined(self._id_EDB0))
        self.goalradius = level._id_4FF6;

      _id_12F9C(var_2);
    }
  }

  if(isDefined(self.script_noteworthy)) {
    if(self.script_noteworthy == "hide") {
      thread scripts\sp\utility::_id_F2DA(0);
      return;
    }
  }

  if(!isDefined(self._id_EDB0) && !isDefined(self _meth_812A()))
    self.goalradius = level._id_4FF6;
}

_id_8438() {
  var_0 = getEntArray("info_volume", "classname");
  level._id_4E32 = [];
  level._id_8438 = [];

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(isDefined(var_2._id_ED47))
      level._id_4E32[var_2._id_ED47] = var_2;

    if(isDefined(var_2._id_EDCF))
      level._id_8438[var_2._id_EDCF] = var_2;
  }
}

_id_1A12(var_0) {
  level._id_1162[var_0] = spawnStruct();
  level._id_1162[var_0]._id_1A09 = 0;
  level._id_1162[var_0]._id_1A0D = 0;
  level._id_1162[var_0]._id_10878 = 0;
  level._id_1162[var_0]._id_1912 = [];
  level._id_1162[var_0].spawners = [];
}

_id_1A17(var_0) {
  self endon("death");
  self.decremented = 0;
  var_0._id_10878++;
  var_0.spawners = scripts\engine\utility::array_add(var_0.spawners, self);
  thread _id_1A15(var_0);
  thread _id_1A16(var_0);

  while(self.count) {
    self waittill("spawned", var_1);

    if(scripts\sp\utility::_id_106ED(var_1)) {
      continue;
    }
    var_1 thread _id_1A14(var_0);
  }

  waittillframeend;

  if(self.decremented) {
    return;
  }
  self.decremented = 1;
  var_0._id_10878--;
}

_id_1A15(var_0) {
  self waittill("death");

  if(isDefined(self) && self.decremented) {
    return;
  }
  var_0._id_10878--;
}

_id_1A16(var_0) {
  self endon("death");
  self waittill("emptied spawner");
  waittillframeend;

  if(self.decremented) {
    return;
  }
  self.decremented = 1;
  var_0._id_10878--;
}

_id_1A14(var_0) {
  var_0._id_1A09++;
  var_0._id_1912[var_0._id_1912.size] = self;

  if(isDefined(self._id_ED49))
    _id_1382D();
  else
    self waittill("death");

  var_0._id_1A09--;
  var_0._id_1A0D++;
}

camper_trigger_think(var_0) {
  var_1 = strtok(var_0.script_linkto, " ");
  var_2 = [];
  var_3 = [];

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    var_5 = var_1[var_4];
    var_6 = getspawner(var_5, "script_linkname");

    if(isDefined(var_6)) {
      var_2 = scripts\engine\utility::add_to_array(var_2, var_6);
      continue;
    }

    var_7 = getnode(var_5, "script_linkname");

    if(!isDefined(var_7)) {
      continue;
    }
    var_3 = scripts\engine\utility::add_to_array(var_3, var_7);
  }

  var_0 waittill("trigger");
  var_3 = scripts\engine\utility::array_randomize(var_3);

  for(var_4 = 0; var_4 < var_3.size; var_4++)
    var_3[var_4].claimed = 0;

  var_8 = 0;

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    var_9 = var_2[var_4];

    if(!isDefined(var_9)) {
      continue;
    }
    if(isDefined(var_9._id_EEB3)) {
      continue;
    }
    while(isDefined(var_3[var_8].script_noteworthy) && var_3[var_8].script_noteworthy == "dont_spawn")
      var_8++;

    var_9.origin = var_3[var_8].origin;
    var_9.angles = var_3[var_8].angles;
    var_9 scripts\sp\utility::_id_1747(::_id_3FEF, var_3[var_8]);
    var_8++;
  }

  scripts\engine\utility::array_thread(var_2, scripts\sp\utility::_id_1747, ::_id_37E9);
  scripts\engine\utility::array_thread(var_2, scripts\sp\utility::_id_1747, ::_id_BC9F, var_3);
  scripts\engine\utility::array_thread(var_2, scripts\sp\utility::_id_10619);
}

_id_37E9() {
  self.goalradius = 8;
  self.fixednode = 1;
}

_id_BC9F(var_0) {
  self endon("death");
  var_1 = 0;

  for(;;) {
    if(!isalive(self.enemy)) {
      self waittill("enemy");
      var_1 = 0;
      continue;
    }

    if(isPlayer(self.enemy)) {
      if(self.enemy scripts\sp\utility::_id_65DB("player_has_red_flashing_overlay") || scripts\engine\utility::flag("player_flashed")) {
        self.fixednode = 0;

        for(;;) {
          self.goalradius = 180;
          self setgoalpos(level.player.origin);
          wait 1;
        }

        return;
      }
    }

    if(var_1) {
      if(self cansee(self.enemy)) {
        wait 0.05;
        continue;
      }

      var_1 = 0;
    } else {
      if(self cansee(self.enemy))
        var_1 = 1;

      wait 0.05;
      continue;
    }

    if(randomint(3) > 0) {
      var_2 = _id_6CA6(var_0);

      if(isDefined(var_2)) {
        _id_3FEF(var_2, self._id_3FF3);
        self waittill("goal");
      }
    }
  }
}

_id_3FEF(var_0, var_1) {
  self _meth_82EE(var_0);
  self._id_3FF3 = var_0;
  var_0.claimed = 1;

  if(isDefined(var_1))
    var_1.claimed = 0;
}

_id_6CA6(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(var_0[var_1].claimed)
      continue;
    else
      return var_0[var_1];
  }

  return undefined;
}

_id_6F5D(var_0) {
  var_1 = getspawnerarray(var_0.target);
  scripts\engine\utility::array_thread(var_1, ::_id_6F59);
  var_0 waittill("trigger");
  var_1 = getspawnerarray(var_0.target);
  scripts\engine\utility::array_thread(var_1, ::_id_6F5C, var_0);
}

_id_6F59() {}

_id_1278B(var_0) {
  if(!isDefined(var_0))
    return 0;

  return isDefined(var_0._id_EE95);
}

_id_6F5C(var_0) {
  if(!isDefined(level._id_107A7) || isspawner(self))
    self endon("death");

  self notify("stop current floodspawner");
  self endon("stop current floodspawner");

  if(_id_9C98()) {
    _id_DB3D(var_0);
    return;
  }

  var_1 = _id_1278B(var_0);
  scripts\sp\utility::script_delay();

  if(isDefined(level._id_107A7)) {
    if(!isspawner(self))
      self.count = 1;
  }

  while(self.count > 0) {
    while(var_1 && !level.player istouching(var_0))
      wait 0.5;

    var_2 = isDefined(self._id_EED1) && scripts\engine\utility::flag("stealth_enabled") && !scripts\engine\utility::flag("stealth_spotted");
    var_3 = self;

    if(isDefined(level._id_107A7)) {
      if(!isspawner(self))
        var_3 = _id_7C86(self, 1);
    }

    if(isDefined(self._id_EDB3))
      var_4 = var_3 _meth_8393(var_2);
    else
      var_4 = var_3 dospawn(var_2);

    if(scripts\sp\utility::_id_106ED(var_4)) {
      wait 2;
      continue;
    }

    if(isDefined(self._id_ED39)) {
      if(self._id_ED39 == "heat")
        var_4 scripts\sp\utility::_id_61FF();

      if(self._id_ED39 == "cqb")
        var_4 scripts\sp\utility::_id_61E7();
    }

    var_4 thread _id_DF23(self);
    var_4 waittill("death", var_5);

    if(!_id_D27A(var_4, var_5))
      self.count++;

    if(!isDefined(var_4)) {
      continue;
    }
    if(!scripts\sp\utility::_id_EF15())
      wait(randomfloatrange(5, 9));
  }
}

_id_D27A(var_0, var_1) {
  if(isDefined(self._id_EDAA)) {
    if(self._id_EDAA)
      return 1;
  }

  if(!isDefined(var_0))
    return 0;

  if(isalive(var_1)) {
    if(isPlayer(var_1))
      return 1;

    if(distance(var_1.origin, level.player.origin) < 200)
      return 1;
  } else if(isDefined(var_1)) {
    if(var_1.classname == "worldspawn")
      return 0;

    if(distance(var_1.origin, level.player.origin) < 200)
      return 1;
  }

  if(distance(var_0.origin, level.player.origin) < 200)
    return 1;

  return bullettracepassed(level.player getEye(), var_0 getEye(), 0, undefined);
}

_id_9C98() {
  if(!isDefined(self.target))
    return 0;

  var_0 = getspawnerarray(self.target);

  if(!var_0.size)
    return 0;

  return issubstr(var_0[0].classname, "actor");
}

_id_DB3C(var_0) {
  var_0._id_1060E waittill("death");
  self notify("death_report");
}

_id_DB3D(var_0) {
  self endon("death");
  var_1 = _id_1278B(var_0);
  scripts\sp\utility::script_delay();

  if(var_1) {
    while(!level.player istouching(var_0))
      wait 0.5;
  }

  var_2 = getspawnerarray(self.target);
  self.spawners = 0;
  scripts\engine\utility::array_thread(var_2, ::_id_DB3F, self);
  var_4 = randomint(var_2.size);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(self.count <= 0) {
      return;
    }
    var_4++;

    if(var_4 >= var_2.size)
      var_4 = 0;

    var_5 = var_2[var_4];
    var_5 scripts\sp\utility::_id_F311(1);
    var_6 = var_5 scripts\sp\utility::_id_10619();

    if(scripts\sp\utility::_id_106ED(var_6)) {
      wait 2;
      continue;
    }

    self.count--;
    var_5._id_1060E = var_6;
    var_6 thread _id_DF23(self);
    var_6 thread _id_6985(var_0);
    thread _id_DB3C(var_5);
  }

  var_7 = 0.01;

  while(self.count > 0) {
    self waittill("death_report");
    scripts\sp\utility::_id_EF15();
    var_4 = randomint(var_2.size);

    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      var_2 = scripts\engine\utility::array_removeundefined(var_2);

      if(!var_2.size) {
        if(isDefined(self))
          self delete();

        return;
      }

      var_4++;

      if(var_4 >= var_2.size)
        var_4 = 0;

      var_5 = var_2[var_4];

      if(isalive(var_5._id_1060E)) {
        continue;
      }
      if(isDefined(var_5.target))
        self.target = var_5.target;
      else
        self.target = undefined;

      var_6 = scripts\sp\utility::_id_10619();

      if(scripts\sp\utility::_id_106ED(var_6)) {
        wait 2;
        continue;
      }

      var_6 thread _id_DF23(self);
      var_6 thread _id_6985(var_0);
      var_5._id_1060E = var_6;
      thread _id_DB3C(var_5);

      if(self.count <= 0)
        return;
    }
  }
}

_id_DB3F(var_0) {
  var_0 endon("death");
  var_0.spawners++;
  self waittill("death");
  var_0.spawners--;

  if(!var_0.spawners)
    var_0 delete();
}

_id_6985(var_0) {
  if(isDefined(self._id_EDB0)) {
    return;
  }
  var_1 = level._id_4FF6;

  if(isDefined(var_0)) {
    if(isDefined(var_0.script_radius)) {
      if(var_0.script_radius == -1) {
        return;
      }
      var_1 = var_0.script_radius;
    }
  }

  if(isDefined(self._id_EDB0)) {
    return;
  }
  self endon("death");
  self waittill("goal");
  self.goalradius = var_1;
}

_id_100C6() {}

_id_DC9B(var_0) {
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

    for(var_4 = 0; var_4 < var_3.size; var_4++)
      var_1[var_1.size] = getspawner(var_3[var_4], "script_linkname");
  }

  waittillframeend;
  scripts\engine\utility::array_thread(var_1, scripts\sp\utility::_id_1747, ::_id_2BD0);
  scripts\engine\utility::array_thread(var_1, scripts\sp\utility::_id_10619);
}

_id_2BD0() {
  if(isDefined(self._id_EDB0)) {
    return;
  }
  self endon("death");
  self waittill("reached_path_end");

  if(!isDefined(self _meth_812A()))
    self.goalradius = level._id_4FF6;
}

_id_1085E(var_0) {
  var_1 = var_0 spawndrone();

  if(var_1.weapon != "none") {
    var_2 = getweaponmodel(var_1.weapon);
    var_1 attach(var_2, "tag_weapon_right");
    var_3 = getweaponhidetags(var_1.weapon);

    for(var_4 = 0; var_4 < var_3.size; var_4++)
      var_1 hidepart(var_3[var_4], var_2);
  }

  var_1.spawner = var_0;
  var_1._id_5BF2 = isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "drone_delete_on_unload";
  var_1._id_6CDA = 1;
  var_1 notify("finished spawning");
  var_0 notify("drone_spawned", var_1);
  return var_1;
}

_id_10869(var_0, var_1) {
  if(!isDefined(var_0.spawner)) {}

  var_2 = var_0.spawner.origin;
  var_3 = var_0.spawner.angles;
  var_4 = var_0.spawner.target;
  var_0.spawner.origin = var_0.origin;
  var_0.spawner.angles = var_0.angles;

  if(isDefined(var_1))
    var_0.spawner.target = var_1;

  var_0.spawner.count = var_0.spawner.count + 1;
  var_5 = var_0.spawner _meth_8393();
  var_6 = scripts\sp\utility::_id_106ED(var_5);

  if(var_6) {}

  var_5._id_131F5 = var_0._id_131F5;
  var_5._id_1321D = var_0._id_1321D;
  var_5._id_10B71 = var_0._id_10B71;
  var_5._id_72A4 = var_0._id_72A4;
  var_0.spawner.origin = var_2;
  var_0.spawner.angles = var_3;
  var_0.spawner.target = var_4;
  var_0 delete();
  return var_5;
}

_id_10868(var_0, var_1) {
  if(!isDefined(var_0.spawner)) {}

  var_2 = var_0.spawner.origin;
  var_3 = var_0.spawner.angles;
  var_4 = var_0.spawner.target;
  var_0.spawner.origin = var_0.origin;
  var_0.spawner.angles = var_0.angles;

  if(isDefined(var_1))
    var_0.spawner.target = var_1;

  var_0.spawner.count = var_0.spawner.count + 1;
  var_5 = scripts\sp\utility::_id_6B47(var_0.spawner);
  var_6 = scripts\sp\utility::_id_106ED(var_5);

  if(var_6) {}

  var_5._id_131F5 = var_0._id_131F5;
  var_5._id_1321D = var_0._id_1321D;
  var_5._id_10B71 = var_0._id_10B71;
  var_5._id_72A4 = var_0._id_72A4;
  var_0.spawner.origin = var_2;
  var_0.spawner.angles = var_3;
  var_0.spawner.target = var_4;
  var_0 delete();
  return var_5;
}

_id_1732() {
  var_0 = self._id_EE90;
  var_1 = self._id_EE91;

  if(!isDefined(level._id_A67E))
    level._id_A67E = [];

  if(!isDefined(level._id_A67E[var_0]))
    level._id_A67E[var_0] = [];

  if(!isDefined(level._id_A67E[var_0][var_1]))
    level._id_A67E[var_0][var_1] = [];

  level._id_A67E[var_0][var_1][self._id_6A0B] = self;
}

_id_177E() {
  var_0 = self._id_EEBA;
  var_1 = self._id_EEBB;

  if(!isDefined(level._id_10727[var_0]))
    level._id_10727[var_0] = [];

  if(!isDefined(level._id_10727[var_0][var_1]))
    level._id_10727[var_0][var_1] = [];

  level._id_10727[var_0][var_1][self._id_6A0B] = self;
}

_id_10CC6() {
  self endon("death");
  self._id_55ED = 1;
  wait 3;
  self._id_55ED = 0;
}

deathtime() {
  self endon("death");
  wait(self._id_ED4B);
  wait(randomfloat(10));
  self _meth_81D0();
}

_id_11AD7(var_0) {
  self notify("tracker_bullet_hit");
  self endon("tracker_bullet_hit");

  if(self.team != "axis") {
    return;
  }
  if(!isalive(self)) {
    return;
  }
  scripts\sp\utility::_id_9196(1, 0, 1, "tracker");
  scripts\engine\utility::waittill_notify_or_timeout("death", 5.0);
  scripts\sp\utility::_id_9193("tracker");

  if(isalive(self)) {
    for(var_1 = 0; var_1 < 3; var_1++) {
      wait 0.2;
      scripts\sp\utility::_id_9196(1, 0, 1, "tracker");
      wait 0.15;
      scripts\sp\utility::_id_9193("tracker");
    }
  }
}