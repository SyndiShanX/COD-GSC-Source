/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\102.gsc
**************************************/

main() {
  precachemodel("grenade_bag");
  createthreatbiasgroup("allies");
  createthreatbiasgroup("axis");
  createthreatbiasgroup("team3");
  createthreatbiasgroup("civilian");
  maps\_anim::_id_1264("generic", "rappel_pushoff_initial_npc", maps\_utility::_id_20FB);
  maps\_anim::_id_1264("generic", "ps_rappel_pushoff_initial_npc", maps\_utility::_id_20FB);
  maps\_anim::_id_1264("generic", "feet_on_ground", maps\_utility::_id_20FC);
  maps\_anim::_id_1264("generic", "ps_rappel_clipout_npc", maps\_utility::_id_20FC);

  foreach(var_1 in level.players) {}
  var_1 setthreatbiasgroup("allies");

  level._id_20FD = 0;
  level._id_20FE = [];
  level._id_20FF = 0;
  level._id_2100 = 0;
  level._id_16C9 = 0;
  level._id_2101 = [];
  level._id_2102 = [];

  if(!isDefined(level._id_2103)) {
    level._id_2103 = [];

  }
  level._id_2104 = 0;
  level._id_2105 = [];

  if(!isDefined(level._id_2106)) {
    level._id_2106 = [];

  }
  level._id_2106["regular"] = ::_id_216A;
  level._id_2106["elite"] = ::_id_2166;
  level._id_2107 = [];
  level._id_2107["axis"] = ::_id_2161;
  level._id_2107["allies"] = ::_id_215E;
  level._id_2107["team3"] = ::_id_2164;
  level._id_2107["neutral"] = ::_id_2165;
  level._id_2108 = 0;
  level._id_2109 = randomintrange(1, 4);

  if(!isDefined(level._id_2070)) {
    level._id_2070 = 2048;

  }
  if(!isDefined(level._id_210A)) {
    level._id_210A = 512;

  }
  level._id_210B = "J_Shoulder_RI";
  level._id_210C = 1024;

  if(!isDefined(level._id_210D)) {
    level._id_210D = 11;

  }
  level._id_210E = 0;
  var_3 = getaispeciesarray();
  common_scripts\utility::array_thread(var_3, ::_id_215C);
  level._id_210F = [];
  level._id_1B42 = [];
  var_4 = getspawnerarray();

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    var_4[var_5] thread _id_2147();

  }
  level._id_1B42 = undefined;
  thread _id_2113();
  common_scripts\utility::array_thread(var_3, ::_id_214F);
  level._id_2110 = getarraykeys(level._id_210F);

  for(var_5 = 0; var_5 < level._id_2110.size; var_5++) {
    if(!issubstr(tolower(level._id_2110[var_5]), "rpg")) {
      continue;
    }
    precacheitem("rpg_player");
    break;
  }

  level._id_2110 = undefined;
  common_scripts\utility::run_thread_on_noteworthy("hiding_door_spawner", maps\_hiding_door::_id_1285);
}

_id_2111(var_0) {
  if(var_0.size <= 16) {
    return;
  }
  var_1 = 0;
  var_2 = 0;

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    if(!var_0[var_3].team != "axis") {
      continue;
    }
    var_1++;

    if(!var_0[var_3] _id_2112()) {
      continue;
    }
    var_2++;
  }
}

_id_2112() {
  if(isDefined(self.script_char_group)) {
    return 1;

  }
  return isDefined(self.script_char_index);
}

_id_2113() {
  foreach(var_2, var_1 in level._id_2103) {
    if(!isDefined(level.flag[var_2])) {
      common_scripts\utility::flag_init(var_2);
    }
  }
}

_id_2114() {
  self endon("death");

  for(;;) {
    if(self.count > 0) {
      self waittill("spawned");

    }
    waittillframeend;

    if(!self.count) {
      return;
    }
  }
}

_id_2115() {
  level._id_2103[self._id_2116]["ai"][self.unique_id] = self;
  var_0 = self.unique_id;
  var_1 = self._id_2116;

  if(isDefined(self._id_2117)) {
    _id_2143();
  } else {
    self waittill("death");

  }
  level._id_2103[var_1]["ai"][var_0] = undefined;
  _id_211B(var_1);
}

_id_2118() {
  var_0 = self.unique_id;
  var_1 = self._id_2116;

  if(!isDefined(level._id_2103) || !isDefined(level._id_2103[self._id_2116])) {
    waittillframeend;

    if(!isDefined(self)) {
      return;
    }
  }

  level._id_2103[var_1]["vehicles"][var_0] = self;
  self waittill("death");
  level._id_2103[var_1]["vehicles"][var_0] = undefined;
  _id_211B(var_1);
}

_id_2119() {
  level._id_2103[self._id_2116] = [];
  waittillframeend;

  if(!isDefined(self) || self.count == 0) {
    return;
  }
  self._id_2104 = level._id_2104;
  level._id_2104++;
  level._id_2103[self._id_2116]["spawners"][self._id_2104] = self;
  var_0 = self._id_2116;
  var_1 = self._id_2104;
  _id_2114();
  level._id_2103[var_0]["spawners"][var_1] = undefined;
  _id_211B(var_0);
}

_id_211A() {
  level._id_2103[self._id_2116] = [];
  waittillframeend;

  if(!isDefined(self)) {
    return;
  }
  self._id_2104 = level._id_2104;
  level._id_2104++;
  level._id_2103[self._id_2116]["vehicle_spawners"][self._id_2104] = self;
  var_0 = self._id_2116;
  var_1 = self._id_2104;
  _id_2114();
  level._id_2103[var_0]["vehicle_spawners"][var_1] = undefined;
  _id_211B(var_0);
}

_id_211B(var_0) {
  level notify("updating_deathflag_" + var_0);
  level endon("updating_deathflag_" + var_0);
  waittillframeend;

  foreach(var_3, var_2 in level._id_2103[var_0]) {
    if(getarraykeys(var_2).size > 0) {
      return;
    }
  }

  common_scripts\utility::flag_set(var_0);
}

_id_1EAC(var_0) {
  var_0 endon("death");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(!isai(var_1)) {
      continue;
    }
    var_1 thread maps\_utility::_id_211C(0.15);
    var_1 maps\_utility::_id_109E();
    var_1._id_0FFE = 0;
  }
}

_id_1EAD(var_0) {
  var_0 endon("death");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(!isai(var_1)) {
      continue;
    }
    var_1 thread maps\_utility::_id_211C(0.15);
    var_1 maps\_utility::_id_109B();
    var_1._id_0FFE = 1;
  }
}

_id_211D(var_0) {
  var_0 endon("death");
  self endon("death");

  for(;;) {
    self waittill("trigger");

    if(!var_0.count) {
      return;
    }
    if(self.target != var_0.targetname) {
      return;
    }
    if(isDefined(var_0._id_211E)) {
      return;
    }
    var_1 = var_0 maps\_utility::_id_166F();

    if(maps\_utility::_id_13AF(var_1)) {
      var_0 notify("spawn_failed");

    }
    if(isDefined(self.wait) && self.wait > 0) {
      wait(self.wait);
    }
  }
}

_id_1EA2(var_0) {
  var_1 = var_0._id_1EBD;
  var_2 = var_0.target;
  var_0 waittill("trigger");
  var_0 maps\_utility::script_delay();

  if(isDefined(var_1)) {
    waittillframeend;

  }
  var_3 = getEntArray(var_2, "targetname");

  foreach(var_5 in var_3) {
    if(var_5.code_classname == "script_vehicle") {
      if(isDefined(var_5._id_2005) && var_5._id_2005 == 1 || !isDefined(var_5.target)) {
        thread maps\_vehicle::_id_211F(var_5);
      } else {
        var_5 thread maps\_vehicle::_id_1F9E();

      }
      continue;
    }

    var_5 thread _id_212B();
  }

  if(isDefined(level._id_2120)) {
    _id_2121(var_2);
  }
}

_id_2121(var_0) {
  var_1 = common_scripts\utility::getstructarray(var_0, "targetname");

  if(getEntArray(var_0, "target").size <= 1) {
    maps\_utility::_id_2122(var_1);

  }
  var_2 = _id_2123(var_1);
  common_scripts\utility::array_thread(var_2, ::_id_212B);
}

_id_2123(var_0) {
  var_1 = [];
  var_2 = [];

  foreach(var_4 in var_0) {
    if(!isDefined(var_4._id_2124)) {
      continue;
    }
    if(!isDefined(var_2[var_4._id_2124])) {
      var_2[var_4._id_2124] = [];

    }
    var_2[var_4._id_2124][var_2[var_4._id_2124].size] = var_4;
  }

  foreach(var_7 in var_2) {
    foreach(var_4 in var_7) {
      var_9 = _id_2125(var_4, var_7.size);
      var_1[var_1.size] = var_9;
    }
  }

  return var_1;
}

_id_2125(var_0, var_1) {
  if(!isDefined(level._id_2126)) {
    level._id_2126 = [];

  }
  if(!isDefined(level._id_2126[var_0._id_2124])) {
    level._id_2126[var_0._id_2124] = _id_212A(var_0._id_2124);

  }
  var_2 = level._id_2126[var_0._id_2124];
  var_3 = var_2._id_2128[var_2._id_2127];
  var_2._id_2127++;
  var_2._id_2127 = var_2._id_2127 % var_2._id_2128.size;
  var_3.origin = var_0.origin;

  if(isDefined(var_0.angles)) {
    var_3.angles = var_0.angles;
  } else if(isDefined(var_0.target)) {
    var_4 = getnode(var_0.target, "targetname");

    if(isDefined(var_4)) {
      var_3.angles = vectortoangles(var_4.origin - var_3.origin);
    }
  }

  if(isDefined(level._id_2129)) {
    var_3[[level._id_2129]](var_0);

  }
  if(isDefined(var_0.target)) {
    var_3.target = var_0.target;

  }
  var_3.count = 1;
  return var_3;
}

_id_212A(var_0) {
  var_1 = getspawnerarray();
  var_2 = spawnStruct();
  var_3 = [];

  foreach(var_5 in var_1) {
    if(!isDefined(var_5._id_2124)) {
      continue;
    }
    if(var_5._id_2124 != var_0) {
      continue;
    }
    var_3[var_3.size] = var_5;
  }

  var_2._id_2127 = 0;
  var_2._id_2128 = var_3;
  return var_2;
}

_id_212B() {
  self endon("death");
  maps\_utility::script_delay();

  if(!isDefined(self)) {
    return undefined;

  }
  if(isDefined(self._id_212C)) {
    var_0 = maps\_utility::_id_212D(self);
    return undefined;
  } else if(!issubstr(self.classname, "actor")) {
    return undefined;

  }
  var_1 = isDefined(self._id_212E) && common_scripts\utility::flag("_stealth_enabled") && !common_scripts\utility::flag("_stealth_spotted");

  if(isDefined(self._id_212F)) {
    var_0 = self stalingradspawn(var_1);
  } else {
    var_0 = self dospawn(var_1);

  }
  if(!maps\_utility::_id_13AF(var_0)) {
    if(isDefined(self._id_2130)) {
      if(self._id_2130 == "heat") {
        var_0 maps\_utility::_id_2131();

      }
      if(self._id_2130 == "cqb") {
        var_0 maps\_utility::_id_109B();
      }
    }
  }

  return var_0;
}

_id_1EA3(var_0) {
  var_1 = var_0.target;
  var_2 = 0;
  var_3 = getEntArray(var_1, "targetname");

  foreach(var_5 in var_3) {
    if(!isDefined(var_5.target)) {
      continue;
    }
    var_6 = getent(var_5.target, "targetname");

    if(!isDefined(var_6)) {
      if(!isDefined(var_5.script_linkto)) {
        continue;
      }
      var_6 = var_5 common_scripts\utility::get_linked_ent();

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
  var_0 maps\_utility::script_delay();
  var_3 = getEntArray(var_1, "targetname");

  foreach(var_5 in var_3) {}
  var_5 thread _id_2132();
}

_id_2132() {
  var_0 = _id_2134();
  var_1 = _id_212B();

  if(!isDefined(var_1)) {
    self delete();

    if(isDefined(var_0)) {
      var_1 = var_0 _id_212B();
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
  if(!isDefined(var_0.count)) {
    var_0.count = 1;

  }
  for(;;) {
    if(!isDefined(var_0)) {
      break;
    }

    var_2 = var_0 thread _id_212B();

    if(!isDefined(var_2)) {
      var_0 delete();
      break;
    }

    var_2 thread _id_2136(var_0);
    var_2 waittill("death", var_3);

    if(!_id_223F(var_2, var_3)) {
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

    if(!maps\_utility::_id_2133()) {
      wait(randomfloatrange(1, 3));
    }
  }

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

_id_2134() {
  if(isDefined(self.target)) {
    var_0 = getent(self.target, "targetname");

    if(isDefined(var_0) && isspawner(var_0)) {
      return var_0;
    }
  }

  if(isDefined(self.script_linkto)) {
    var_0 = common_scripts\utility::get_linked_ent();

    if(isDefined(var_0) && isspawner(var_0)) {
      return var_0;
    }
  }

  return undefined;
}

_id_2135(var_0) {
  common_scripts\utility::array_thread(var_0, ::_id_223A);
  common_scripts\utility::array_thread(var_0, ::_id_223D);
}

_id_2136(var_0) {
  var_0 endon("death");

  if(isDefined(self._id_2137)) {
    if(self._id_2137) {
      return;
    }
  }

  self waittill("death");

  if(!isDefined(self)) {
    var_0.count++;
  }
}

_id_2138(var_0) {
  for(var_1 = 0; var_1 < 2; var_1++) {
    switch (var_1) {
      case 0:
        var_2 = "axis";
        break;
      default:
        var_2 = "allies";
        break;
    }

    var_3 = getEntArray(var_2, "team");

    for(var_4 = 0; var_4 < var_3.size; var_4++) {
      if(isDefined(var_3[var_4]._id_2139)) {
        if(var_3[var_4]._id_2139 == var_0) {
          var_3[var_4] thread _id_21D1();
        }
      }
    }
  }
}

_id_213A(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.targetname) && var_0.targetname != "flood_spawner") {
    return;
  }
  if(level.script == "sniperescape") {
    return;
  }
  var_0 delete();
}

_id_1EBD(var_0) {
  var_0 endon("death");
  var_1 = var_0._id_1EBC;
  waittillframeend;

  if(!isDefined(level._id_1E90[var_1])) {
    return;
  }
  var_0 waittill("trigger");
  _id_213B(var_1);
}

_id_213B(var_0) {
  if(!isDefined(level._id_1E90[var_0])) {
    return;
  }
  var_1 = level._id_1E90[var_0];
  var_2 = getarraykeys(var_1);

  if(var_2.size <= 1) {
    return;
  }
  var_3 = common_scripts\utility::random(var_2);
  var_1[var_3] = undefined;

  foreach(var_9, var_5 in var_1) {
    foreach(var_8, var_7 in var_5) {
      if(isDefined(var_7)) {
        var_7 delete();
      }
    }

    level._id_1E90[var_0][var_9] = undefined;
  }
}

_id_213C(var_0) {
  var_1 = getspawnerarray();

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(isDefined(var_1[var_2]._id_182E) && var_0 == var_1[var_2]._id_182E) {
      var_1[var_2] delete();
    }
  }
}

_id_1EB3(var_0) {
  var_1 = var_0._id_182E;
  var_0 waittill("trigger");
  waittillframeend;
  waittillframeend;
  _id_213C(var_1);
  _id_213A(var_0);
}

_id_1EB7(var_0) {
  var_1 = var_0._id_1EB6;
  var_0 waittill("trigger");
  var_2 = getspawnerarray();

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(!isDefined(var_2[var_3]._id_1EB6)) {
      continue;
    }
    if(var_1 != var_2[var_3]._id_1EB6) {
      continue;
    }
    if(isDefined(var_2[var_3]._id_0A7C)) {
      level notify("stop_flanker_behavior" + var_2[var_3]._id_0A7C);

    }
    var_2[var_3] maps\_utility::_id_213D(0);
    var_2[var_3] notify("emptied spawner");
  }

  var_0 notify("deleted spawners");
}

_id_213E(var_0) {
  var_1 = getspawnerarray();

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(!isDefined(var_1[var_2]._id_182E)) {
      continue;
    }
    if(var_0 != var_1[var_2]._id_182E) {
      continue;
    }
    var_1[var_2] delete();
  }
}

_id_213F(var_0) {}

_id_2140(var_0, var_1) {
  if(!isDefined(level._id_2141) || !isDefined(level._id_2141[var_1])) {
    level._id_2142[var_1] = 0;
    level._id_2141[var_1] = [];
  }

  var_2 = level._id_2142[var_1];
  var_3 = level._id_2141[var_1][var_2];

  if(isDefined(var_3)) {
    var_3 delete();

  }
  var_3 = spawn("weapon_fraggrenade", var_0);
  level._id_2141[var_1][var_2] = var_3;
  level._id_2142[var_1] = (var_2 + 1) % 16;
  return var_3;
}

_id_2143() {
  self endon("death");
  self waittill("pain_death");
}

_id_2144() {
  var_0 = self.team;
  _id_2143();

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self._id_2145)) {
    return;
  }
  self.ignoreforfixednodesafecheck = 1;

  if(self.grenadeammo <= 0) {
    return;
  }
  level._id_20C8--;

  if(level._id_20C8 > 0) {
    return;
  }
  level._id_20C8 = 2 + randomint(2);
  var_1 = 25;
  var_2 = 12;
  var_3 = self.origin + (randomint(var_1) - var_2, randomint(var_1) - var_2, 2) + (0, 0, 42);
  var_4 = (0, randomint(360), 90);
  thread _id_2146(var_3, var_4, self.team);
}

_id_2146(var_0, var_1, var_2) {
  var_3 = _id_2140(var_0, var_2);
  var_3 setModel("grenade_bag");
  var_3.angles = var_1;
  var_3 hide();
  wait 0.7;

  if(!isDefined(var_3)) {
    return;
  }
  var_3 show();
}

_id_1B48() {
  maps\_drone::_id_203D();
}

_id_20C0() {}

_id_2147() {
  level._id_210F[self.classname] = 1;

  if(isDefined(self._id_2148)) {
    switch (self._id_2148) {
      case "easy":
        if(level.gameskill > 1) {
          maps\_utility::_id_213D(0);

        }
        break;
      case "hard":
        if(level.gameskill < 2) {
          maps\_utility::_id_213D(0);

        }
        break;
    }
  }

  if(isDefined(self._id_212C)) {
    thread _id_1B48();

  }
  if(isDefined(self._id_2149)) {
    var_0 = self._id_2149;

    if(!isDefined(level._id_20FE[var_0])) {
      _id_222A(var_0);

    }
    thread _id_222E(level._id_20FE[var_0]);
  }

  if(isDefined(self._id_214A)) {
    var_1 = 0;

    if(isDefined(level._id_214B)) {
      if(isDefined(level._id_214B[self._id_214A])) {
        var_1 = level._id_214B[self._id_214A].size;
      }
    }

    level._id_214B[self._id_214A][var_1] = self;
  }

  if(isDefined(self._id_1DF8)) {
    if(self._id_1DF8 > level._id_210E) {
      level._id_210E = self._id_1DF8;

    }
    var_1 = 0;

    if(isDefined(level._id_214C)) {
      if(isDefined(level._id_214C[self._id_1DF8])) {
        var_1 = level._id_214C[self._id_1DF8].size;
      }
    }

    level._id_214C[self._id_1DF8][var_1] = self;
  }

  if(isDefined(self._id_2116)) {
    thread _id_2119();

  }
  if(isDefined(self.target)) {
    _id_215D();

  }
  if(isDefined(self._id_1F95)) {
    _id_226A();

  }
  if(isDefined(self._id_1EBC)) {
    _id_2268();

  }
  if(!isDefined(self._id_214D)) {
    self._id_214D = [];

  }
  for(;;) {
    var_2 = undefined;
    self waittill("spawned", var_2);

    if(!isalive(var_2)) {
      continue;
    }
    if(isDefined(level._id_214E)) {
      self thread[[level._id_214E]](var_2);

    }
    if(isDefined(self._id_214A)) {
      for(var_3 = 0; var_3 < level._id_214B[self._id_214A].size; var_3++) {
        if(level._id_214B[self._id_214A][var_3] != self) {
          level._id_214B[self._id_214A][var_3] delete();
        }
      }
    }

    var_2._id_1E97 = self._id_214D;
    var_2.spawner = self;

    if(isDefined(self.targetname)) {
      var_2 thread _id_214F(self.targetname);
      continue;
    }

    var_2 thread _id_214F();
  }
}

_id_214F(var_0) {
  level._id_210F[self.classname] = 1;
  _id_218B(var_0);
  self endon("death");

  if(_id_2151()) {
    self delete();

  }
  thread _id_2152();
  self.finished_spawning = 1;
  self notify("finished spawning");

  if(self.team == "allies" && !isDefined(self._id_2150)) {
    thread _id_21D7();
  }
}

_id_2151() {
  if(!isDefined(self._id_2148)) {
    return 0;

  }
  var_0 = 0;

  switch (self._id_2148) {
    case "easy":
      if(level.gameskill > 1) {
        var_0 = 1;

      }
      break;
    case "hard":
      if(level.gameskill < 2) {
        var_0 = 1;

      }
      break;
  }

  return var_0;
}

_id_2152() {
  if(!isDefined(self._id_1E97)) {
    self.spawner = undefined;
    return;
  }

  for(var_0 = 0; var_0 < self._id_1E97.size; var_0++) {
    var_1 = self._id_1E97[var_0];

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

  if(isDefined(self.team)) {
    for(var_0 = 0; var_0 < level._id_1E97[self.team].size; var_0++) {
      var_1 = level._id_1E97[self.team][var_0];

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

  self._id_1E97 = undefined;
  self.spawner = undefined;
}

_id_2153() {
  if(!maps\_utility::_id_0A36()) {
    return;
  }
  maps\_utility::_id_12E2(::_id_2156);
  thread _id_2154();
}

_id_2154() {
  self waittill("death", var_0, var_1, var_2);

  if(!isDefined(self)) {
    return;
  }
  if(!self isbadguy()) {
    return;
  }
  if(!isDefined(var_0)) {
    return;
  }
  if(!isplayer(var_0)) {
    return;
  }
  if(!isDefined(var_2)) {
    var_0._id_2155 = undefined;
    return;
  }

  if(!isDefined(var_0._id_2155)) {
    var_0._id_2155 = 1;
  } else {
    var_0._id_2155++;

  }
  if(maps\_utility::_id_12DC() && var_0._id_2155 >= 4) {
    var_0 notify("sur_ch_quadkill");

  }
  waittillframeend;
  var_0._id_2155 = undefined;
}

_id_2156(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(self)) {
    return;
  }
  if(isDefined(var_1) && isplayer(var_1)) {
    self._id_0D7A = var_1;
    self._id_2157 = var_4;
  }
}

_id_2158() {
  self waittill("death", var_0, var_1, var_2);
  level notify("ai_killed", self);

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(var_0)) {
    if(self.team == "axis" || self.team == "team3") {
      var_3 = undefined;

      if(isDefined(var_0.attacker)) {
        if(isDefined(var_0._id_0A38) && var_0._id_0A38) {
          var_3 = "sentry";

        }
        if(isDefined(var_0.destructible_type)) {
          var_3 = "destructible";

        }
        var_0 = var_0.attacker;
      } else if(isDefined(var_0.owner)) {
        if(isai(var_0) && isplayer(var_0.owner)) {
          var_3 = "friendly";

        }
        var_0 = var_0.owner;
      } else if(isDefined(var_0.damageowner)) {
        if(isDefined(var_0.destructible_type)) {
          var_3 = "destructible";

        }
        var_0 = var_0.damageowner;
      }

      var_4 = 0;

      if(isplayer(var_0)) {
        var_4 = 1;

      }
      if(isDefined(level._id_0A35) && level._id_0A35) {
        var_4 = 1;

      }
      if(var_4) {
        var_0 maps\_player_stats::_id_0A34(self, var_1, var_2, var_3);
      }
    }
  }

  for(var_5 = 0; var_5 < self._id_2159.size; var_5++) {
    var_6 = self._id_2159[var_5];

    switch (var_6["params"]) {
      case 0:
        [[var_6["func"]]](var_0);
        break;
      case 1:
        [[var_6["func"]]](var_0, var_6["param1"]);
        break;
      case 2:
        [[var_6["func"]]](var_0, var_6["param1"], var_6["param2"]);
        break;
      case 3:
        [[var_6["func"]]](var_0, var_6["param1"], var_6["param2"], var_6["param3"]);
        break;
    }
  }
}

_id_215A() {
  self._id_215B = [];

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6);

    if(isDefined(var_1) && isplayer(var_1)) {
      var_7 = var_1 getcurrentweapon();

      if(isDefined(var_7) && maps\_utility::isprimaryweapon(var_7) && isDefined(var_4) && (var_4 == "MOD_PISTOL_BULLET" || var_4 == "MOD_RIFLE_BULLET")) {
        var_1 thread maps\_player_stats::_id_0A3B();
      }
    }

    foreach(var_9 in self._id_215B) {}
    thread[[var_9]](var_0, var_1, var_2, var_3, var_4, var_5, var_6);

    if(!isalive(self) || self.delayeddeath) {
      break;
    }
  }
}

_id_215C() {
  if(isDefined(self._id_2116)) {
    level._id_2103[self._id_2116] = 1;

  }
  if(isDefined(self.target)) {
    _id_215D();
  }
}

_id_215D() {
  var_0 = _id_21B0();

  if(isDefined(var_0)) {
    var_1 = var_0["destination"];
    var_2 = var_0["get_target_func"];

    for(var_3 = 0; var_3 < var_1.size; var_3++) {
      _id_21AF(var_1[var_3], var_2);
    }
  }
}

_id_215E() {
  self.usechokepoints = 0;

  if(isDefined(self._id_215F)) {
    self.followmin = self._id_215F;

  }
  if(isDefined(self._id_2160)) {
    self.followmax = self._id_2160;
  }
}

_id_2161() {
  if(isDefined(level._id_12E5) && level._id_12E5) {
    thread maps\_rank::_id_12E0();

  }
  if(self.type == "human") {
    thread _id_2144();

  }
  maps\_utility::_id_12E2(maps\_gameskill::_id_2162);

  if(isDefined(self._id_2163)) {
    self.combatmode = self._id_2163;
  }
}

_id_2164() {
  _id_2161();
}

_id_2165() {}

_id_2166() {
  self endon("death");
  self._id_2167 = 1;
  self._id_10A3 = 0.5;

  if(!isDefined(self._id_2168)) {
    self._id_20AF = 5;

  }
  self._id_0F3C = 1;

  if(maps\_utility::_id_2169()) {
    var_0 = undefined;

    switch (level.gameskill) {
      case 0:
        var_0 = 0;
        break;
      case 1:
        var_0 = 2;
        break;
      case 2:
        var_0 = 3;
        break;
      case 3:
        var_0 = 4;
        break;
    }

    if(level.gameskill > 0) {
      self.grenadeweapon = "flash_grenade";
      self.grenadeammo = var_0;
    }
  }
}

_id_216A() {}

_id_216B(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("death");

  if(self.health <= 0) {
    return;
  }
  if(var_0 >= self.minpaindamage) {
    var_7 = self.minpaindamage;
    self.minpaindamage = var_7 * 3;
    wait 5;
    self.minpaindamage = var_7;
  }
}

_id_1A2D(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(self) || self.health <= 0) {
    return;
  }
  if(isDefined(self._id_0D04) && self._id_0D04) {
    return;
  }
  if(!issubstr(var_4, "BULLET")) {
    return;
  }
  var_7 = self._id_1A2D;

  if(var_0 < self._id_1A2D) {
    var_7 = var_0;

  }
  self.health = self.health + var_7;
}

_id_216C() {
  maps\_gameskill::_id_216D();
  maps\_gameskill::grenadeawareness();
}

_id_216E() {
  if(!isalive(self)) {
    return;
  }
  if(self.health <= 1) {
    return;
  }
  self laserforceon();
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }
  self laserforceoff();
}

_id_216F() {
  if(isDefined(self._id_2170)) {
    self._id_0FF1 = 1;

  }
  if(isDefined(self._id_2116)) {
    thread _id_2115();

  }
  if(isDefined(self._id_2171)) {
    self.attackeraccuracy = self._id_2171;

  }
  if(isDefined(self._id_2172)) {
    thread _id_226C();

  }
  if(isDefined(self._id_2173)) {
    thread deathtime();

  }
  if(isDefined(self._id_2174)) {
    maps\_utility::_id_0EEC();

  }
  if(isDefined(self._id_2175)) {
    self._id_0ECB = 1;

  }
  if(isDefined(self._id_2176)) {
    thread _id_216E();

  }
  if(isDefined(self._id_2177)) {
    var_0 = self._id_2177;

    if(var_0 == 1) {
      var_0 = 8;

    }
    maps\_utility::_id_2178(var_0);
  }

  if(isDefined(self._id_2179)) {
    self.maxfaceenemydist = self._id_2179;
  } else {
    self.maxfaceenemydist = 512;

  }
  if(isDefined(self._id_134B)) {
    maps\_utility::_id_13A4(self._id_134B);

  }
  if(isDefined(self._id_217A)) {
    self.dropweapon = 0;

  }
  if(isDefined(self._id_217B)) {
    self.fixednode = self._id_217B == 1;
  } else {
    self.fixednode = self.team == "allies";

  }
  self.providecoveringfire = self.team == "allies" && self.fixednode;

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "mgpair") {
    thread maps\_mg_penetration::_id_0A53();

  }
  if(isDefined(self._id_1830) && !(isDefined(self._id_2005) && self._id_2005 == 1 || isDefined(self._id_212E))) {
    thread _id_21A0();

  }
  if(isDefined(self._id_217C)) {
    self setthreatbiasgroup(self._id_217C);
  } else if(self.team == "neutral") {
    self setthreatbiasgroup("civilian");
  } else {
    self setthreatbiasgroup(self.team);

  }
  if(isDefined(self._id_217D)) {
    maps\_utility::_id_0D72(self._id_217D);

  }
  if(isDefined(self._id_2168)) {
    self._id_20AF = self._id_2168;

  }
  if(isDefined(self._id_217E)) {
    self.ignoreme = 1;

  }
  if(isDefined(self._id_217F)) {
    self.ignoresuppression = 1;

  }
  if(isDefined(self._id_2180)) {
    self.ignoreall = 1;
    self clearenemy();
  }

  if(isDefined(self._id_2181)) {
    self.maxsightdistsqrd = self._id_2181;

  }
  if(isDefined(self._id_2182)) {
    if(self._id_2182 == "player") {
      self.favoriteenemy = level.player;
      level.player.targetname = "player";
    }
  }

  if(isDefined(self._id_2183)) {
    self.pathenemyfightdist = self._id_2183;

  }
  if(isDefined(self._id_2184)) {
    self.pathenemylookahead = self._id_2184;

  }
  if(isDefined(self._id_2185)) {
    self.a._id_0D31 = 1;

  }
  if(isDefined(self._id_2186)) {
    self.diequietly = 1;

  }
  if(isDefined(self._id_2187)) {
    self.grenadeweapon = "flash_grenade";
    self.grenadeammo = self._id_2187;
  }

  if(isDefined(self._id_2188)) {
    self.pacifist = 1;

  }
  if(isDefined(self._id_2189)) {
    self.health = self._id_2189;

  }
  if(isDefined(self._id_218A)) {
    self._id_2145 = self._id_218A;
  }
}

_id_218B(var_0) {
  thread _id_215A();
  thread _id_21E9();
  thread _id_2255();
  thread _id_2153();

  if(!isDefined(level._id_2002)) {
    self thermaldrawenable();

  }
  self._id_2104 = undefined;

  if(!isDefined(self.unique_id)) {
    maps\_utility::_id_218C();

  }
  if(!isDefined(self._id_2159)) {
    self._id_2159 = [];

  }
  thread _id_2158();
  level thread maps\_friendlyfire::_id_1FE4(self);
  self.walkdist = 16;
  _id_2197();
  _id_216C();
  _id_216F();
  [[level._id_2107[self.team]]]();
  thread[[level._id_2106[self.subclass]]]();
  thread maps\_damagefeedback::_id_1A28();
  common_scripts\_dynamic_world::ai_init();
  _id_21B1();

  if(isDefined(self._id_218E)) {
    self setgoalentity(level.player);
    return;
  }

  if(isDefined(self._id_212E)) {
    if(isDefined(self._id_218F)) {
      var_1 = level._id_2190[self._id_218F];
      self thread[[var_1]]();
    } else {
      self thread[[level._id_1C4D["_spawner_stealth_default"]]]();
    }
  }

  if(isDefined(self._id_2191)) {
    self thread[[level._id_1C4D["_idle_call_idle_func"]]]();
    return;
  }

  if(isDefined(self._id_2192) && !isDefined(self._id_2005)) {
    self thread[[level._id_1C4D["_idle_call_idle_func"]]]();

  }
  if(isDefined(self._id_2050) && !isDefined(self._id_2005)) {
    thread maps\_patrol::_id_204E();
    return;
  }

  if(isDefined(self._id_2193) && self._id_2193 == 1) {
    maps\_utility::_id_2194();

  }
  if(isDefined(self._id_2195)) {
    if(!isDefined(self.script_radius)) {
      self.goalradius = 800;

    }
    self setgoalentity(level.player);
    level thread _id_1EF8(self);
    return;
  }

  if(isDefined(self._id_2196)) {
    return;
  }
  if(isDefined(self._id_2005) && self._id_2005 == 1) {
    _id_21B3();
    self setgoalpos(self.origin);
    return;
  }

  if(!isDefined(self._id_212E)) {}

  _id_21B3();

  if(isDefined(self.target)) {
    thread _id_21A4();
  }
}

_id_2197() {
  self eqoff();
  maps\_utility::_id_2198();

  if(isDefined(self._id_2199)) {
    self.grenadeammo = self._id_2199;
  } else {
    self.grenadeammo = 3;

  }
  if(isDefined(self.primaryweapon)) {
    self.noattackeraccuracymod = animscripts\combat_utility::issniper();

  }
  if(!maps\_utility::_id_0A36()) {
    self._id_0FD9 = 1;
  }
}

_id_219A() {
  if(self.team == "neutral") {
    self setthreatbiasgroup("civilian");
  } else {
    self setthreatbiasgroup(self.team);

  }
  _id_2197();
  self._id_20AF = 1;
  maps\_gameskill::grenadeawareness();
  maps\_utility::_id_219B();
  self.interval = 96;
  self._id_117F = undefined;
  self.ignoreme = 0;
  self.threatbias = 0;
  self.pacifist = 0;
  self.pacifistwait = 20;
  self.ignorerandombulletdamage = 0;
  self.pushable = 1;
  self.script_pushable = 1;
  self.allowdeath = 0;
  self.anglelerprate = 540;
  self.badplaceawareness = 0.75;
  self.chainfallback = 0;
  self.dontavoidplayer = 0;
  self.drawoncompass = 1;
  self.dropweapon = 1;
  self.goalradius = level._id_2070;
  self.goalheight = level._id_210A;
  self.ignoresuppression = 0;
  self pushplayer(0);

  if(isDefined(self._id_0D04) && self._id_0D04) {
    maps\_utility::_id_1902();

  }
  maps\_utility::_id_219C();
  self.maxsightdistsqrd = 67108864;
  self._id_20B5 = 0;
  self.walkdist = 16;
  maps\_utility::_id_219D();
  self.pushable = 1;
  self.script_pushable = 1;
  animscripts\init::_id_20BE();
  self.fixednode = self.team == "allies";
}

_id_1EF8(var_0) {
  var_0 endon("death");

  while(isalive(var_0)) {
    if(var_0.goalradius > 200) {
      var_0.goalradius = var_0.goalradius - 200;

    }
    wait 6;
  }
}

_id_219E(var_0) {
  self endon("death");

  if(!self._id_219F) {
    var_0._id_2196 = 1;
    self._id_219F = 1;
    var_0 waittill("death");
    self._id_219F = 0;
    self notify("get new user");
  }
}

_id_21A0() {
  self endon("death");
  waittillframeend;
  var_0 = level._id_1E98[self._id_1830];

  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.target)) {
    var_1 = getnode(var_0.target, "targetname");
    var_2 = getent(var_0.target, "targetname");
    var_3 = common_scripts\utility::getstruct(var_0.target, "targetname");
    var_4 = undefined;

    if(isDefined(var_1)) {
      var_4 = var_1;
      self setgoalnode(var_4);
    } else if(isDefined(var_2)) {
      var_4 = var_2;
      self setgoalpos(var_4.origin);
    } else if(isDefined(var_3)) {
      var_4 = var_3;
      self setgoalpos(var_4.origin);
    }

    if(isDefined(var_4.radius) && var_4.radius != 0) {
      self.goalradius = var_4.radius;

    }
    if(isDefined(var_4.goalheight) && var_4.goalheight != 0) {
      self.goalheight = var_4.goalheight;
    }
  }

  if(isDefined(self.target)) {
    self setgoalvolume(var_0);
  } else {
    self setgoalvolumeauto(var_0);
  }
}

_id_1411(var_0) {
  return getEntArray(var_0, "targetname");
}

_id_1410(var_0) {
  return getnodearray(var_0, "targetname");
}

_id_140F(var_0) {
  return common_scripts\utility::getstructarray(var_0, "targetname");
}

_id_21A1(var_0) {
  return isDefined(var_0.radius) && var_0.radius != 0;
}

_id_21A2(var_0, var_1) {
  _id_21A4(var_0, "origin", var_1);
}

_id_21A3(var_0, var_1) {
  _id_21A4(var_0, "struct", var_1);
}

_id_21A4(var_0, var_1, var_2, var_3) {
  if(isDefined(self._id_2196)) {
    return;
  }
  var_4 = _id_21B0(var_0, var_1);

  if(!isDefined(var_4)) {
    self notify("reached_path_end");
    return;
  }

  if(!isDefined(var_2)) {
    var_2 = ::_id_21A5;

  }
  _id_21A7(var_4["destination"], var_4["get_target_func"], var_4["set_goal_func_quits"], var_2, var_3);
}

_id_21A5(var_0) {}

_id_21A6(var_0) {
  if(var_0.size == 1) {
    return var_0[0];

  }
  var_1 = var_0[0].targetname;

  if(!isDefined(level._id_2105[var_1])) {
    level._id_2105[var_1] = var_0;

  }
  var_0 = level._id_2105[var_1];
  var_2 = var_0[0];
  var_3 = [];

  for(var_4 = 0; var_4 < var_0.size - 1; var_4++) {
    var_3[var_4] = var_0[var_4 + 1];

  }
  var_3[var_0.size - 1] = var_0[0];
  level._id_2105[var_1] = var_3;
  return var_2;
}

_id_21A7(var_0, var_1, var_2, var_3, var_4) {
  self notify("stop_going_to_node");
  self endon("stop_going_to_node");
  self endon("death");

  for(;;) {
    var_0 = _id_21A6(var_0);
    var_5 = var_4;

    if(isDefined(var_0._id_21A8)) {
      if(var_0._id_21A8 > 1) {
        var_5 = var_0._id_21A8;

      }
      var_0._id_21A8 = 0;
    }

    if(_id_21A1(var_0)) {
      self.goalradius = var_0.radius;
    } else {
      self.goalradius = level._id_2070;

    }
    if(isDefined(var_0.height)) {
      self.goalheight = var_0.height;
    } else {
      self.goalheight = level._id_210A;

    }
    [[var_2]](var_0);

    if(maps\_utility::_id_133C("_stealth_override_goalpos")) {
      for(;;) {
        self waittill("goal");

        if(!maps\_utility::_id_1008("_stealth_override_goalpos")) {
          break;
        }

        maps\_utility::_id_13DB("_stealth_override_goalpos");
      }
    } else {
      self waittill("goal");

    }
    var_0 notify("trigger", self);
    [[var_3]](var_0);

    if(isDefined(var_0._id_2057)) {
      common_scripts\utility::flag_set(var_0._id_2057);

    }
    if(isDefined(var_0._id_2058)) {
      maps\_utility::_id_13DC(var_0._id_2058);

    }
    if(isDefined(var_0._id_2059)) {
      common_scripts\utility::flag_clear(var_0._id_2059);

    }
    if(_id_21AC(var_0)) {
      return 1;

    }
    var_0 maps\_utility::script_delay();

    if(isDefined(var_0._id_1288)) {
      common_scripts\utility::flag_wait(var_0._id_1288);

    }
    var_0 maps\_utility::_id_2133();

    if(isDefined(var_0._id_1EE1)) {
      wait(var_0._id_1EE1);

    }
    while(isDefined(var_0._id_21A8)) {
      var_0._id_21A8 = 0;

      if(_id_1412(var_0, var_1, var_5)) {
        var_0._id_21A8 = 1;
        var_0 notify("script_requires_player");
        break;
      }

      wait 0.1;
    }

    if(!isDefined(var_0.target)) {
      break;
    }

    var_6 = [[var_1]](var_0.target);

    if(!var_6.size) {
      break;
    }

    var_0 = var_6;
  }

  self notify("reached_path_end");

  if(isDefined(self._id_1382)) {
    return;
  }
  if(isDefined(self getgoalvolume())) {
    self setgoalvolumeauto(self getgoalvolume());
  } else {
    self.goalradius = level._id_2070;
  }
}

_id_1412(var_0, var_1, var_2) {
  foreach(var_4 in level.players) {
    if(distancesquared(var_4.origin, var_0.origin) < distancesquared(self.origin, var_0.origin)) {
      return 1;
    }
  }

  var_6 = anglesToForward(self.angles);

  if(isDefined(var_0.target)) {
    var_7 = [[var_1]](var_0.target);

    if(var_7.size == 1) {
      var_6 = vectornormalize(var_7[0].origin - var_0.origin);
    } else if(isDefined(var_0.angles)) {
      var_6 = anglesToForward(var_0.angles);
    }
  } else if(isDefined(var_0.angles)) {
    var_6 = anglesToForward(var_0.angles);

  }
  var_8 = [];

  foreach(var_4 in level.players) {}
  var_8[var_8.size] = vectornormalize(var_4.origin - self.origin);

  foreach(var_12 in var_8) {
    if(vectordot(var_6, var_12) > 0) {
      return 1;
    }
  }

  var_14 = var_2 * var_2;

  foreach(var_4 in level.players) {
    if(distancesquared(var_4.origin, self.origin) < var_14) {
      return 1;
    }
  }

  return 0;
}

_id_21A9(var_0) {
  if(var_0.classname == "info_volume") {
    self setgoalvolumeauto(var_0);
    self notify("go_to_node_new_goal");
    return;
  }

  _id_21AA(var_0);
}

_id_21AA(var_0) {
  maps\_utility::_id_2052(var_0);
  self notify("go_to_node_new_goal");
}

_id_21AB(var_0) {
  maps\_utility::_id_2053(var_0);
  self notify("go_to_node_new_goal");
}

_id_21AC(var_0) {
  if(!isDefined(var_0.target)) {
    return 0;

  }
  var_1 = getEntArray(var_0.target, "targetname");

  if(!var_1.size) {
    return 0;

  }
  var_2 = var_1[0];

  if(var_2.classname != "misc_turret") {
    return 0;

  }
  thread _id_21B6(var_2);
  return 1;
}

_id_21AD(var_0) {
  waittillframeend;

  if(isDefined(var_0)) {
    var_0._id_21AE = undefined;
  }
}

_id_21AF(var_0, var_1) {
  var_2 = 0;
  var_3 = [];
  var_4 = 0;

  for(;;) {
    if(!isDefined(var_0._id_21AE)) {
      var_0._id_21AE = 1;
      level thread _id_21AD(var_0);

      if(isDefined(var_0._id_2057)) {
        if(!isDefined(level.flag[var_0._id_2057])) {
          common_scripts\utility::flag_init(var_0._id_2057);
        }
      }

      if(isDefined(var_0._id_1288)) {
        if(!isDefined(level.flag[var_0._id_1288])) {
          common_scripts\utility::flag_init(var_0._id_1288);
        }
      }

      if(isDefined(var_0._id_2059)) {
        if(!isDefined(level.flag[var_0._id_2059])) {
          common_scripts\utility::flag_init(var_0._id_2059);
        }
      }

      if(isDefined(var_0.target)) {
        var_5 = [[var_1]](var_0.target);
        var_3 = common_scripts\utility::add_to_array(var_3, var_5);
      }
    }

    var_4++;

    if(var_4 >= var_3.size) {
      break;
    }

    var_0 = var_3[var_4];
  }
}

_id_21B0(var_0, var_1) {
  var_2["entity"] = ::_id_1411;
  var_2["node"] = ::_id_1410;
  var_2["struct"] = ::_id_140F;
  var_3["entity"] = ::_id_21A9;
  var_3["struct"] = ::_id_21AA;
  var_3["node"] = ::_id_21AB;

  if(!isDefined(var_1)) {
    var_1 = "node";

  }
  var_4 = [];

  if(isDefined(var_0)) {
    var_4["destination"][0] = var_0;
  } else {
    var_0 = getEntArray(self.target, "targetname");

    if(var_0.size > 0) {
      var_1 = "entity";

    }
    if(var_1 == "node") {
      var_0 = getnodearray(self.target, "targetname");

      if(!var_0.size) {
        var_0 = common_scripts\utility::getstructarray(self.target, "targetname");

        if(!var_0.size) {
          return;
        }
        var_1 = "struct";
      }
    }

    var_4["destination"] = var_0;
  }

  var_4["get_target_func"] = var_2[var_1];
  var_4["set_goal_func_quits"] = var_3[var_1];
  return var_4;
}

_id_21B1() {
  if(isDefined(self._id_21B2)) {
    self.goalheight = self._id_21B2;
  } else {
    self.goalheight = level._id_210A;
  }
}

_id_21B3(var_0) {
  if(isDefined(self.script_radius)) {
    self.goalradius = self.script_radius;
    return;
  }

  if(isDefined(self._id_1382)) {
    if(isDefined(var_0) && isDefined(var_0.radius)) {
      self.goalradius = var_0.radius;
      return;
    }
  }

  if(!isDefined(self getgoalvolume())) {
    if(self.type == "civilian") {
      self.goalradius = 128;
    } else {
      self.goalradius = level._id_2070;
    }
  }
}

_id_21B4(var_0) {
  for(;;) {
    var_1 = self getturretowner();

    if(!isalive(var_1)) {
      wait 1.5;
      continue;
    }

    if(!isDefined(var_1.enemy)) {
      self settargetentity(common_scripts\utility::random(var_0));
      self notify("startfiring");
      self startfiring();
    }

    wait(2 + randomfloat(1));
  }
}

_id_21B5(var_0) {
  for(;;) {
    self settargetentity(common_scripts\utility::random(var_0));
    self notify("startfiring");
    self startfiring();
    wait(2 + randomfloat(1));
  }
}

_id_21B6(var_0) {
  if(self isbadguy() && self.health == 150) {
    self.health = 100;
    self.a._id_0D31 = 1;
  }

  self useturret(var_0);

  if(isDefined(var_0.target) && var_0.target != var_0.targetname) {
    var_1 = getEntArray(var_0.target, "targetname");
    var_2 = [];

    for(var_3 = 0; var_3 < var_1.size; var_3++) {
      if(var_1[var_3].classname == "script_origin") {
        var_2[var_2.size] = var_1[var_3];
      }
    }

    if(isDefined(var_0._id_21B7)) {
      var_0 thread _id_21B4(var_2);
    } else if(isDefined(var_0._id_21B8)) {
      var_0 setmode("manual_ai");
      var_0 thread _id_21B5(var_2);
    } else if(var_2.size > 0) {
      if(var_2.size == 1) {
        var_0._id_21B9 = var_2[0];
        var_0 settargetentity(var_2[0]);
        thread maps\_mgturret::_id_21BA(var_0);
      } else {
        var_0 thread maps\_mgturret::_id_21BB(var_2);
      }
    }
  }

  thread maps\_mgturret::_id_21BC(var_0);
  var_0 notify("startfiring");
}

_id_21BD(var_0, var_1) {
  self endon("death");
  level._id_21BE[var_0] = level._id_21BE[var_0] + self.count;
  var_2 = 1;

  while(self.count > 0) {
    self waittill("spawned", var_3);

    if(var_2) {
      if(getdvar("fallback", "0") == "1") {}

      level notify("fallback_firstspawn" + var_0);
      var_2 = 0;
    }

    common_scripts\utility::waitframe();

    if(maps\_utility::_id_13AF(var_3)) {
      level notify("fallbacker_died" + var_0);
      level._id_21BE[var_0]--;
      continue;
    }

    var_3 thread _id_21C0(var_0, var_1, "is spawner");
  }
}

_id_21BF(var_0, var_1) {
  var_0 waittill("death");
  level._id_21BE[var_1]--;
  level notify("fallbacker_died" + var_1);
}

_id_21C0(var_0, var_1, var_2) {
  if(!isDefined(self._id_21C1) || !isDefined(self._id_21C1[var_0])) {
    self._id_21C1[var_0] = 1;
  } else {
    return;

  }
  self._id_1EAF = var_0;

  if(!isDefined(var_2)) {
    level._id_21BE[var_0]++;

  }
  if(isDefined(var_1) && level._id_21C2[var_0]) {
    thread _id_21C5(var_0, var_1);

  }
  level thread _id_21BF(self, var_0);
}

_id_21C3(var_0, var_1) {
  var_0 waittill("death");
  level notify("fallback_reached_goal" + var_1);
}

_id_21C4() {
  self waittill("goal");
  self.ignoresuppression = 0;
  self notify("fallback_notify");
  self notify("stop_coverprint");
}

_id_21C5(var_0, var_1) {
  self notify("stop_going_to_node");
  self stopuseturret();
  self.ignoresuppression = 1;
  self setgoalnode(var_1);

  if(var_1.radius != 0) {
    self.goalradius = var_1.radius;

  }
  self endon("death");
  level thread _id_21C3(self, var_0);
  thread _id_21C4();

  if(getdvar("fallback", "0") == "1") {
    thread _id_21C6(var_1.origin);

  }
  self waittill("fallback_notify");
  level notify("fallback_reached_goal" + var_0);
}

_id_21C6(var_0) {
  self endon("fallback_notify");
  self endon("stop_coverprint");

  for(;;) {
    common_scripts\utility::waitframe();
  }
}

_id_21C7(var_0, var_1) {
  var_2 = undefined;
  var_3 = getallnodes();

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    if(isDefined(var_3[var_4]._id_1EAF) && var_3[var_4]._id_1EAF == var_0) {
      var_2 = common_scripts\utility::add_to_array(var_2, var_3[var_4]);
    }
  }

  if(!isDefined(var_2)) {
    return;
  }
  level._id_21BE[var_0] = 0;
  level._id_21C8[var_0] = 0;
  level._id_21C2[var_0] = 0;
  var_5 = getspawnerarray();

  for(var_4 = 0; var_4 < var_5.size; var_4++) {
    if(isDefined(var_5[var_4]._id_1EAF) && var_5[var_4]._id_1EAF == var_0) {
      if(var_5[var_4].count > 0) {
        var_5[var_4] thread _id_21BD(var_0, var_2[randomint(var_2.size)]);
        level._id_21C8[var_0]++;
      }
    }
  }

  var_6 = getaiarray();

  for(var_4 = 0; var_4 < var_6.size; var_4++) {
    if(isDefined(var_6[var_4]._id_1EAF) && var_6[var_4]._id_1EAF == var_0) {
      var_6[var_4] thread _id_21C0(var_0);
    }
  }

  if(!level._id_21BE[var_0] && !level._id_21C8[var_0]) {
    return;
  }
  var_5 = undefined;
  var_6 = undefined;
  thread _id_21CB(var_0, var_1);
  level waittill("fallbacker_trigger" + var_0);

  if(getdvar("fallback", "0") == "1") {}

  level._id_21C2[var_0] = 1;
  var_7 = undefined;
  var_6 = getaiarray();

  for(var_4 = 0; var_4 < var_6.size; var_4++) {
    if(isDefined(var_6[var_4]._id_1EAF) && var_6[var_4]._id_1EAF == var_0 || isDefined(var_6[var_4]._id_21C9) && isDefined(var_1) && var_6[var_4]._id_21C9 == var_1) {
      var_7 = common_scripts\utility::add_to_array(var_7, var_6[var_4]);
    }
  }

  var_6 = undefined;

  if(!isDefined(var_7)) {
    return;
  }
  var_8 = var_7.size * 0.4;
  var_8 = int(var_8);
  level notify("fallback initiated " + var_0);
  _id_21CA(var_7, 0, var_8);

  for(var_4 = 0; var_4 < var_8; var_4++) {
    var_7[var_4] thread _id_21C5(var_0, var_2[randomint(var_2.size)]);

  }
  for(var_4 = 0; var_4 < var_8; var_4++) {
    level waittill("fallback_reached_goal" + var_0);

  }
  _id_21CA(var_7, var_8, var_7.size);

  for(var_4 = var_8; var_4 < var_7.size; var_4++) {
    if(isalive(var_7[var_4])) {
      var_7[var_4] thread _id_21C5(var_0, var_2[randomint(var_2.size)]);
    }
  }
}

_id_21CA(var_0, var_1, var_2) {
  if(gettime() <= level._id_20FD) {
    return;
  }
  for(var_3 = var_1; var_3 < var_2; var_3++) {
    if(!isalive(var_0[var_3])) {
      continue;
    }
    level._id_20FD = gettime() + 2500 + randomint(2000);
    var_4 = var_0.size;
    var_5 = int(var_4 * 0.4);

    if(randomint(100) > 50) {
      if(var_4 - var_5 > 1) {
        if(randomint(100) > 66) {
          var_6 = "dawnville_defensive_german_1";
        } else if(randomint(100) > 66) {
          var_6 = "dawnville_defensive_german_2";
        } else {
          var_6 = "dawnville_defensive_german_3";
        }
      } else if(randomint(100) > 66) {
        var_6 = "dawnville_defensive_german_4";
      } else if(randomint(100) > 66) {
        var_6 = "dawnville_defensive_german_5";
      } else {
        var_6 = "dawnville_defensive_german_1";
      }
    } else if(var_5 > 1) {
      if(randomint(100) > 66) {
        var_6 = "dawnville_defensive_german_2";
      } else if(randomint(100) > 66) {
        var_6 = "dawnville_defensive_german_3";
      } else {
        var_6 = "dawnville_defensive_german_4";
      }
    } else if(randomint(100) > 66) {
      var_6 = "dawnville_defensive_german_5";
    } else if(randomint(100) > 66) {
      var_6 = "dawnville_defensive_german_1";
    } else {
      var_6 = "dawnville_defensive_german_2";

    }
    var_0[var_3] animscripts\face::_id_0C46(undefined, var_6, 1.0);
    return;
  }
}

_id_21CB(var_0, var_1) {
  level endon("fallbacker_trigger" + var_0);

  if(getdvar("fallback", "0") == "1") {}

  for(var_2 = 0; var_2 < level._id_21C8[var_0]; var_2++) {
    if(getdvar("fallback", "0") == "1") {}

    level waittill("fallback_firstspawn" + var_0);
  }

  if(getdvar("fallback", "0") == "1") {}

  var_3 = getaiarray();

  for(var_2 = 0; var_2 < var_3.size; var_2++) {
    if(isDefined(var_3[var_2]._id_1EAF) && var_3[var_2]._id_1EAF == var_0 || isDefined(var_3[var_2]._id_21C9) && isDefined(var_1) && var_3[var_2]._id_21C9 == var_1) {
      var_3[var_2] thread _id_21C0(var_0);
    }
  }

  var_3 = undefined;
  var_4 = level._id_21BE[var_0];

  for(var_5 = 0; level._id_21BE[var_0] > var_4 * 0.5; var_5++) {
    if(getdvar("fallback", "0") == "1") {}

    level waittill("fallbacker_died" + var_0);
  }

  level notify("fallbacker_trigger" + var_0);
}

_id_1EB0(var_0) {
  if(!isDefined(level._id_21C1) || !isDefined(level._id_21C1[var_0._id_1EAF])) {
    level thread _id_21C7(var_0._id_1EAF, var_0._id_21C9);

  }
  var_0 waittill("trigger");
  level notify("fallbacker_trigger" + var_0._id_1EAF);
  _id_213A(var_0);
}

_id_21CC(var_0) {
  self waittill("goal");

  if(var_0.radius != 0) {
    self.goalradius = var_0.radius;
  } else {
    self.goalradius = level._id_2070;
  }
}

_id_21CD() {
  self endon("fallback");
  self endon("fallback_clear_goal");
  self endon("fallback_clear_death");

  for(;;) {
    if(isDefined(self._id_21CE)) {}

    common_scripts\utility::waitframe();
  }
}

_id_21CF() {
  self endon("fallback_clear_goal");
  self endon("fallback_clear_death");

  for(;;) {
    if(isDefined(self._id_21CE)) {}

    common_scripts\utility::waitframe();
  }
}

_id_21C1() {
  var_0 = getnode(self.target, "targetname");
  self._id_21CE = var_0;
  self setgoalnode(var_0);

  if(isDefined(self._id_21D0)) {
    thread _id_21CC(var_0);
  } else if(var_0.radius != 0) {
    self.goalradius = var_0.radius;
  } else {
    self.goalradius = level._id_2070;

  }
  for(;;) {
    self waittill("fallback");
    self.interval = 20;
    level thread _id_21C3(self);

    if(getdvar("fallback", "0") == "1") {
      thread _id_21CF();

    }
    if(isDefined(var_0.target)) {
      var_0 = getnode(var_0.target, "targetname");
      self._id_21CE = var_0;
      self setgoalnode(var_0);
      thread _id_21C4();

      if(var_0.radius != 0) {
        self.goalradius = var_0.radius;

      }
      continue;
    }

    level notify("fallback_arrived" + self._id_1EAF);
    return;
  }
}

_id_21D1() {
  common_scripts\utility::waitframe();
  self delete();
}

_id_21D2(var_0, var_1) {
  var_2 = var_0[0] - var_1[0];
  var_3 = var_0[1] - var_1[1];
  var_4 = var_0[2] - var_1[2];
  var_2 = var_2 * var_2;
  var_3 = var_3 * var_3;
  var_4 = var_4 * var_4;
  var_5 = var_2 + var_3 + var_4;
  return var_5;
}

_id_21D3(var_0) {
  for(;;) {
    wait 0.05;
  }
}

_id_1EA5(var_0) {
  if(!isDefined(level._id_21D4)) {
    thread _id_21D9();

  }
  for(;;) {
    var_0 waittill("trigger");
    level notify("friendly_died");

    if(var_0.targetname == "friendly_wave") {
      level._id_21D5 = var_0;
    } else {
      level._id_21D5 = undefined;

    }
    wait 1;
  }
}

_id_21D6(var_0) {
  if(!isDefined(self.target)) {
    return;
  }
  var_1 = getEntArray(self.target, "targetname");

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_1[var_2] maps\_utility::_id_213D(var_0);
  }
}

_id_21D7() {
  if(!isDefined(level._id_21D8)) {
    level._id_21D8 = 0;

  }
  level._id_21D8++;
  self waittill("death");
  level notify("friendly_died");
  level._id_21D8--;
}

_id_21D9() {
  level._id_21D4 = 1;
  var_0 = getEntArray("friendly_wave", "targetname");
  common_scripts\utility::array_thread(var_0, ::_id_21D6, 0);

  if(!isDefined(level._id_210D)) {
    level._id_210D = 7;

  }
  var_1 = 1;

  for(;;) {
    if(isDefined(level._id_21D5) && isDefined(level._id_21D5.target)) {
      var_2 = level._id_21D5;
      var_3 = getEntArray(level._id_21D5.target, "targetname");

      if(!var_3.size) {
        level waittill("friendly_died");
        continue;
      }

      var_4 = 0;
      var_5 = isDefined(level._id_21D5.script_delay);

      while(isDefined(level._id_21D5) && level._id_21D8 < level._id_210D) {
        if(var_2 != level._id_21D5) {
          var_5 = isDefined(level._id_21D5.script_delay);
          var_2 = level._id_21D5;
          var_3 = getEntArray(level._id_21D5.target, "targetname");
        } else if(!var_5) {
          var_4 = randomint(var_3.size);
        } else if(var_4 == var_3.size) {
          var_4 = 0;

        }
        var_3[var_4] maps\_utility::_id_213D(1);
        var_6 = isDefined(var_3[var_4]._id_212E) && common_scripts\utility::flag("_stealth_enabled") && !common_scripts\utility::flag("_stealth_spotted");

        if(isDefined(var_3[var_4]._id_212F)) {
          var_7 = var_3[var_4] stalingradspawn(var_6);
        } else {
          var_7 = var_3[var_4] dospawn(var_6);

        }
        var_3[var_4] maps\_utility::_id_213D(0);

        if(maps\_utility::_id_13AF(var_7)) {
          wait 0.2;
          continue;
        }

        if(isDefined(var_3[var_4]._id_2130)) {
          if(var_3[var_4]._id_21DA == "heat") {
            var_7 maps\_utility::_id_2131();

          }
          if(var_3[var_4]._id_21DA == "cqb") {
            var_7 maps\_utility::_id_109B();
          }
        }

        if(isDefined(level._id_21DB)) {
          level thread[[level._id_21DB]](var_7);
        } else {
          var_7 setgoalentity(level.player);

        }
        if(var_5) {
          if(level._id_21D5.script_delay == 0) {
            waittillframeend;
          } else {
            wait(level._id_21D5.script_delay);

          }
          var_4++;
          continue;
        }

        wait(randomfloat(5));
      }
    }

    level waittill("friendly_died");
  }
}

_id_1EA6(var_0) {
  var_1 = getnode(var_0.target, "targetname");
  var_2 = getent(var_1.target, "targetname");
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
    if(isDefined(var_4._id_21DC) && var_4._id_21DC == 0) {
      continue;
    }
    if(var_4 thread _id_21E0(var_2, var_1)) {
      var_4 thread _id_21E6(var_2, var_1);
      var_2 waittill("friendly_finished_using_mg42");

      if(isalive(var_4)) {
        var_4._id_21DD = gettime() + 10000;
      }
    }

    wait 1;
  }
}

_id_21DE(var_0, var_1) {
  var_1 endon("friendly_finished_using_mg42");
  var_0 waittill("death");
  var_1 notify("friendly_finished_using_mg42");
}

_id_21DF(var_0) {
  var_0 endon("friendly_finished_using_mg42");
  self.useable = 1;
  self setcursorhint("HINT_NOICON");
  self sethintstring(&"PLATFORM_USEAIONMG42");
  self waittill("trigger");
  self.useable = 0;
  self sethintstring("");
  self stopuseturret();
  self notify("stopped_use_turret");
  var_0 notify("friendly_finished_using_mg42");
}

_id_21E0(var_0, var_1) {
  if(self.useable) {
    return 0;

  }
  if(isDefined(self._id_21DD) && gettime() < self._id_21DD) {
    return 0;

  }
  if(distance(level.player.origin, var_1.origin) < 100) {
    return 0;

  }
  if(isDefined(self.chainnode)) {
    if(distance(level.player.origin, self.chainnode.origin) > 1100) {
      return 0;
    }
  }

  return 1;
}

_id_21E1(var_0, var_1) {
  var_0 endon("friendly_finished_using_mg42");
  self waittill("trigger");
  var_0 notify("friendly_finished_using_mg42");
}

_id_21E2() {
  if(!isDefined(self._id_21E3)) {
    return;
  }
  self._id_21E3 notify("friendly_finished_using_mg42");
}

_id_21E4() {
  self endon("death");
  self waittill("goal");
  self.goalradius = self.oldradius;

  if(self.goalradius < 32) {
    self.goalradius = 400;
  }
}

_id_21E6(var_0, var_1) {
  self endon("death");
  var_0 endon("friendly_finished_using_mg42");
  level thread _id_21DE(self, var_0);
  self.oldradius = self.goalradius;
  self.goalradius = 28;
  thread _id_21E4();
  self setgoalnode(var_1);
  self.ignoresuppression = 1;
  self waittill("goal");
  self.goalradius = self.oldradius;

  if(self.goalradius < 32) {
    self.goalradius = 400;

  }
  self.ignoresuppression = 0;
  self.goalradius = self.oldradius;

  if(distance(level.player.origin, var_1.origin) < 32) {
    var_0 notify("friendly_finished_using_mg42");
    return;
  }

  self._id_21E3 = var_0;
  thread _id_21DF(var_0);
  thread _id_21E7(var_0);
  self useturret(var_0);

  if(isDefined(var_0.target)) {
    var_2 = getent(var_0.target, "targetname");

    if(isDefined(var_2)) {
      var_2 thread _id_21E1(var_0, self);
    }
  }

  for(;;) {
    if(distance(self.origin, var_1.origin) < 32) {
      self useturret(var_0);
    } else {
      break;

    }
    if(isDefined(self.chainnode)) {
      if(distance(self.origin, self.chainnode.origin) > 1100) {
        break;
      }
    }

    wait 1;
  }

  var_0 notify("friendly_finished_using_mg42");
}

_id_21E7(var_0) {
  self endon("death");
  var_0 waittill("friendly_finished_using_mg42");
  _id_21E8();
}

_id_21E8() {
  self endon("death");
  var_0 = self._id_21E3;
  self._id_21E3 = undefined;
  self stopuseturret();
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
  self setgoalnode(var_1);
  wait 2;
  self.goalradius = 384;
  return;
  self waittill("goal");

  if(isDefined(self.target)) {
    var_1 = getnode(self.target, "targetname");

    if(isDefined(var_1.target)) {
      var_1 = getnode(var_1.target, "targetname");

    }
    if(isDefined(var_1)) {
      self setgoalnode(var_1);
    }
  }

  self.goalradius = var_2;
}

_id_21E9() {
  if(isDefined(level._id_21EA)) {
    return;
  }
  if(isDefined(level._id_21EB) && !level._id_21EB) {
    return;
  }
  maps\_utility::_id_12E2(::_id_21EC);
}

_id_21EC(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
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
  if(var_1 maps\_vehicle::_id_21ED()) {
    return;
  }
  if(!isDefined(self._id_0EC6)) {
    self startragdoll();

  }
  if(!isDefined(self)) {
    return;
  }
  maps\_utility::_id_1A2A(::_id_21EC);
}

_id_21EE(var_0, var_1, var_2, var_3, var_4) {
  var_0 endon("death");
  var_0._id_21EF = var_1;

  if(isDefined(var_1.script_delay)) {
    var_0._id_21F0 = var_1.script_delay;

  }
  if(isDefined(var_3) && isDefined(var_4)) {
    var_0._id_21F1 = var_3;
    var_0._id_21F2 = var_4;
  } else {
    var_0._id_21F3 = var_2;

  }
  var_0 setgoalpos(var_0.origin);
  var_0 setgoalnode(var_1);
  var_0.goalradius = 12;
  var_0 waittill("goal");
  var_0.goalradius = 28;
  var_0 waittill("shot_at_target");
  var_0._id_21F1 = undefined;
  var_0._id_21F3 = undefined;
  var_0._id_21F0 = undefined;
}

_id_21F4(var_0, var_1, var_2) {
  var_3 = getstartorigin(var_0, var_1, var_2);

  for(;;) {
    wait 0.05;
  }
}

_id_21F5() {
  maps\_utility::_id_213D(1);

  if(isDefined(self._id_212F)) {
    var_0 = self stalingradspawn();
  } else {
    var_0 = self dospawn();

  }
  if(maps\_utility::_id_13AF(var_0)) {
    return;
  }
  if(isDefined(self._id_2130)) {
    if(self._id_2130 == "heat") {
      var_0 maps\_utility::_id_2131();

    }
    if(self._id_2130 == "cqb") {
      var_0 maps\_utility::_id_109B();
    }
  }

  var_0._id_21F6 = 1;
}

_id_21F7() {
  self endon("death");
  self waittill("leaveSquad");
}

_id_1E9B() {
  common_scripts\utility::array_thread(getEntArray(self.target, "targetname"), ::_id_2227, self);

  for(;;) {
    self waittill("trigger", var_2);

    if(_id_2222() && _id_2223() == self) {
      _id_2220();

    }
    self waittill("friendly_wave_start", var_3);
    _id_2224(var_3, self);

    if(!isDefined(var_3.target)) {
      continue;
    }
    var_4 = getent(var_3.target, "targetname");
    var_4 thread _id_2226(self);
  }
}

_id_1E9C(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;

  }
  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "instant_respawn") {
    var_0 = 1;

  }
  level._id_21F8 = [];
  var_1 = getEntArray(self.target, "targetname");
  common_scripts\utility::array_thread(var_1, ::_id_21FD, var_0);
  var_2 = 0;
  var_3 = 0;

  for(;;) {
    self waittill("trigger", var_4);

    if(!_id_2212()) {
      continue;
    }
    if(!var_3) {
      var_3 = 1;
      maps\_utility::script_delay();
    }

    if(self istouching(level.player)) {
      var_2 = 1;
    } else {
      if(!isalive(var_4)) {
        continue;
      }
      if(isplayer(var_4)) {
        var_2 = 1;
      } else if(!isDefined(var_4._id_21F9) || !var_4._id_21F9) {
        continue;
      }
    }

    var_1 = getEntArray(self.target, "targetname");

    if(isDefined(var_1[0])) {
      if(isDefined(var_1[0]._id_21FA)) {
        _id_213B(var_1[0]._id_21FA);
      }
    }

    var_1 = getEntArray(self.target, "targetname");

    for(var_5 = 0; var_5 < var_1.size; var_5++) {
      var_1[var_5]._id_21FB = var_2;
      var_1[var_5] notify("flood_begin");
    }

    if(var_2) {
      wait 5;
      continue;
    }

    wait 0.1;
  }
}

_id_21FC(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_1[var_0[var_2]._id_21FA] = 1;

  }
  var_3 = getarraykeys(var_1);
  var_4 = common_scripts\utility::random(var_3);

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(var_0[var_2]._id_21FA != var_4) {
      var_0[var_2] delete();
    }
  }
}

_id_21FD(var_0) {
  if(isDefined(self._id_21FE)) {
    return;
  }
  self._id_21FE = 1;
  self._id_211E = 1;
  var_1 = self.target;
  var_2 = self.targetname;

  if(!isDefined(var_1) && !isDefined(self._id_2005)) {
    waittillframeend;

  }
  var_3 = [];

  if(isDefined(var_1)) {
    var_4 = getEntArray(var_1, "targetname");

    for(var_5 = 0; var_5 < var_4.size; var_5++) {
      if(!issubstr(var_4[var_5].classname, "actor")) {
        continue;
      }
      var_3[var_3.size] = var_4[var_5];
    }
  }

  var_6 = spawnStruct();
  var_7 = self.origin;
  _id_2200(var_6, var_3.size > 0, var_0);

  if(isalive(var_6._id_21FF)) {
    var_6._id_21FF waittill("death");

  }
  if(!isDefined(var_1)) {
    return;
  }
  var_4 = getEntArray(var_1, "targetname");

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
      var_9 = getent(var_4[var_5].target, "targetname");

      if(!isDefined(var_9) || !issubstr(var_9.classname, "actor")) {
        var_8 = var_4[var_5].target;
      }
    }

    var_4[var_5].target = var_8;
    var_4[var_5] thread _id_21FD(var_0);
    var_4[var_5]._id_21FB = 1;
    var_4[var_5] notify("flood_begin");
  }
}

_id_2200(var_0, var_1, var_2) {
  self endon("death");
  var_3 = self.count;

  if(!var_1) {
    var_1 = isDefined(self.script_noteworthy) && self.script_noteworthy == "delete";

  }
  maps\_utility::_id_213D(2);

  if(isDefined(self.script_delay)) {
    var_4 = self.script_delay;
  } else {
    var_4 = 0;

  }
  for(;;) {
    self waittill("flood_begin");

    if(self._id_21FB) {
      break;
    }

    if(var_4) {
      continue;
    }
    break;
  }

  var_5 = distance(level.player.origin, self.origin);

  while(var_3) {
    self._id_19D9 = var_3;
    maps\_utility::_id_213D(2);
    wait(var_4);
    var_6 = isDefined(self._id_212E) && common_scripts\utility::flag("_stealth_enabled") && !common_scripts\utility::flag("_stealth_spotted");

    if(isDefined(self._id_212F)) {
      var_7 = self stalingradspawn(var_6);
    } else {
      var_7 = self dospawn(var_6);

    }
    if(maps\_utility::_id_13AF(var_7)) {
      var_8 = 0;

      if(var_4 < 2) {
        wait 2;

      }
      continue;
    } else {
      if(isDefined(self._id_2130)) {
        if(self._id_2130 == "heat") {
          var_7 maps\_utility::_id_2131();

        }
        if(self._id_2130 == "cqb") {
          var_7 maps\_utility::_id_109B();
        }
      }

      thread _id_2202(var_7);
      var_7 thread _id_2209(self);

      if(isDefined(self._id_2168)) {
        var_7._id_20AF = self._id_2168;

      }
      var_0._id_21FF = var_7;
      var_0 notify("got_ai");
      self waittill("spawn_died", var_9, var_8);

      if(var_4 > 2) {
        var_4 = randomint(4) + 2;
      } else {
        var_4 = 0.5 + randomfloat(0.5);
      }
    }

    if(var_9) {
      _id_2208(var_5);
      continue;
    }

    if(_id_2207(var_8 || var_1, var_0._id_21FF)) {
      var_3--;

    }
    if(!var_2) {
      _id_2206();
    }
  }

  self delete();
}

_id_2201(var_0) {
  self endon("death");
  var_0 waittill("death");
}

_id_2202(var_0) {
  var_1 = self.targetname;

  if(!isDefined(level._id_21F8[var_1])) {
    level._id_21F8[var_1] = spawnStruct();
    level._id_21F8[var_1] maps\_utility::_id_213D(0);
    level._id_21F8[var_1]._id_2203 = 0;
  }

  if(!isDefined(self._id_2204)) {
    self._id_2204 = 1;
    level._id_21F8[var_1]._id_2203++;
  }

  level._id_21F8[var_1].count++;
  _id_2201(var_0);
  level._id_21F8[var_1].count--;

  if(!isDefined(self)) {
    level._id_21F8[var_1]._id_2203--;

  }
  if(level._id_21F8[var_1]._id_2203) {
    if(level._id_21F8[var_1].count / level._id_21F8[var_1]._id_2203 < 0.32) {
      level._id_21F8[var_1] notify("waveReady");
    }
  }
}

_id_2205(var_0) {
  self endon("debug_stop");
  self endon("death");

  for(;;) {
    wait 0.05;
  }
}

_id_2206() {
  var_0 = self.targetname;

  if(level._id_21F8[var_0].count) {
    level._id_21F8[var_0] waittill("waveReady");
  }
}

_id_2207(var_0, var_1) {
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

_id_2208(var_0) {
  self endon("flood_begin");
  var_0 = var_0 * 0.75;

  while(distance(level.player.origin, self.origin) > var_0) {
    wait 1;
  }
}

_id_2209(var_0) {
  thread _id_220A();
  self waittill("death", var_1);
  var_2 = isalive(var_1) && isplayer(var_1);

  if(!var_2 && isDefined(var_1) && var_1.classname == "worldspawn") {
    var_2 = 1;

  }
  var_3 = !isDefined(self);
  var_0 notify("spawn_died", var_3, var_2);
}

_id_220A() {
  if(isDefined(self._id_2005)) {
    return;
  }
  self endon("death");
  var_0 = getnode(self.target, "targetname");

  if(isDefined(var_0)) {
    self setgoalnode(var_0);
  } else {
    var_0 = getent(self.target, "targetname");

    if(isDefined(var_0)) {
      self setgoalpos(var_0.origin);
    }
  }

  if(isDefined(level._id_220B)) {
    self.pathenemyfightdist = level._id_220B;
    self.pathenemylookahead = level._id_1BBA;
  }

  if(isDefined(var_0.radius) && var_0.radius >= 0) {
    self.goalradius = var_0.radius;
  } else {
    self.goalradius = 256;

  }
  self waittill("goal");

  while(isDefined(var_0.target)) {
    var_1 = getnode(var_0.target, "targetname");

    if(isDefined(var_1)) {
      var_0 = var_1;
    } else {
      break;

    }
    self setgoalnode(var_0);

    if(var_0.radius) {
      self.goalradius = var_0.radius;
    } else {
      self.goalradius = 256;

    }
    self waittill("goal");
  }

  if(isDefined(self.script_noteworthy)) {
    if(self.script_noteworthy == "delete") {
      self kill();
      return;
    }
  }

  if(isDefined(var_0.target)) {
    var_2 = getent(var_0.target, "targetname");

    if(isDefined(var_2) && (var_2.code_classname == "misc_mgturret" || var_2.code_classname == "misc_turret")) {
      self setgoalnode(var_0);
      self.goalradius = 4;
      self waittill("goal");

      if(!isDefined(self._id_1382)) {
        self.goalradius = level._id_2070;

      }
      _id_21B6(var_2);
    }
  }

  if(isDefined(self.script_noteworthy)) {
    if(isDefined(self._id_220C)) {
      if(self._id_220C == "furniture_push") {
        thread _id_220D();
      }
    }

    if(self.script_noteworthy == "hide") {
      thread maps\_utility::_id_0D72(0);
      return;
    }
  }

  if(!isDefined(self._id_1382) && !isDefined(self getgoalvolume())) {
    self.goalradius = level._id_2070;
  }
}

_id_220D() {
  var_0 = getent(self.target, "targetname").origin;
  common_scripts\utility::play_sound_in_space("furniture_slide", var_0);
  wait 0.9;

  if(isDefined(level._id_220E)) {
    common_scripts\utility::play_sound_in_space(common_scripts\utility::random(level._id_220E), var_0);
  }
}

_id_220F() {
  waittillframeend;
  var_0 = getEntArray(self.target, "targetname");

  if(!var_0.size) {
    var_1 = getnode(self.target, "targetname");

    for(;;) {
      self waittill("trigger");

      if(isDefined(level._id_2210) && level._id_2210 == self) {
        wait 0.5;
        continue;
      }

      if(!_id_2212()) {
        wait 0.5;
        continue;
      }

      level notify("new_friendly_trigger");
      level._id_2210 = self;
      var_2 = !isDefined(self._id_2211) || self._id_2211 == 0;
      _id_221C(var_1, var_2);
    }
  }

  for(;;) {
    self waittill("trigger");

    while(level.player istouching(self)) {
      wait 0.05;

    }
    if(!_id_2212()) {
      wait 0.05;
      continue;
    }

    if(isDefined(level._id_2210) && level._id_2210 == self) {
      continue;
    }
    level notify("new_friendly_trigger");
    level._id_2210 = self;
    common_scripts\utility::array_thread(var_0, ::_id_2217);
    wait 0.5;
  }
}

_id_2212() {
  var_0 = 1;

  if(isDefined(self._id_2213)) {
    var_0 = 0;

    for(var_1 = 0; var_1 < level._id_2214.size; var_1++) {
      if(!issubstr(self._id_2213, level._id_2214[var_1])) {
        continue;
      }
      var_0 = 1;
      break;
    }

    if(!var_0) {
      return 0;
    }
  }

  if(!isDefined(self._id_2215)) {
    return var_0;

  }
  var_2 = 0;

  for(var_1 = 0; var_1 < level._id_2216.size; var_1++) {
    if(!issubstr(self._id_2215, level._id_2216[var_1])) {
      continue;
    }
    var_2++;
  }

  var_3 = strtok(self._id_2215, " ");
  return var_2 == var_3.size;
}

_id_2217(var_0) {
  level endon("new_friendly_trigger");
  self waittill("trigger");
  var_0 = getnode(self.target, "targetname");
  var_1 = !isDefined(self._id_2211) || self._id_2211 == 0;
  _id_221C(var_0, var_1);
}

_id_2218() {
  self endon("death");
  var_0 = self._id_13BF;

  while(self.count) {
    self waittill("spawned", var_1);
    var_1 thread _id_2219(var_0);
  }
}

_id_2219(var_0) {
  level._id_13C0[var_0]++;
  self waittill("death");
  level._id_13C0[var_0]--;
  level notify("spawner_expired" + var_0);
}

_id_221A() {
  var_0 = self._id_13BF;
  level._id_13C0[var_0]++;
  var_1 = self.origin;
  _id_2218();
  level notify("spawner dot" + var_1);
  level._id_13C0[var_0]--;
  level notify("spawner_expired" + var_0);
}

_id_1E9A() {
  var_0 = getEntArray("friendly_chain_on_death", "targetname");
  var_1 = getspawnerarray();
  level._id_13C0 = [];

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(!isDefined(var_1[var_2]._id_13BF)) {
      continue;
    }
    var_3 = var_1[var_2]._id_13BF;

    if(!isDefined(level._id_13C0[var_3])) {
      level._id_13C0[var_3] = 0;

    }
    var_1[var_2] thread _id_221A();
  }

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(!isDefined(var_0[var_2]._id_13BF)) {
      return;
    }
    var_0[var_2] thread _id_221B();
  }
}

_id_221B() {
  while(level._id_13C0[self._id_13BF] > 0) {
    level waittill("spawner_expired" + self._id_13BF);

  }
  level endon("start_chain");
  var_0 = getnode(self.target, "targetname");

  for(;;) {
    self waittill("trigger");
    _id_221C(var_0, 1);
    iprintlnbold("Area secured, move up!");
    wait 5;
  }
}

_id_221C(var_0, var_1) {
  level.player maps\_utility::_id_221D(var_0);
  level notify("new_escort_trigger");
  level notify("new_escort_debug");
  level notify("start_chain", var_1);
}

_id_1E99() {
  level._id_221E = [];
  level._id_221F = [];
  common_scripts\utility::array_thread(getEntArray("friendlychain", "targetname"), ::_id_220F);
}

_id_2220() {
  var_0 = [];
  var_1 = [];

  for(var_2 = 0; var_2 < level._id_221E.size; var_2++) {
    var_0[var_0.size] = level._id_221E[var_2];
    var_1[var_1.size] = level._id_221F[var_2];
  }

  level._id_221E = var_0;
  level._id_221F = var_1;

  if(_id_2222()) {
    return;
  }
  common_scripts\utility::flag_clear("spawning_friendlies");
}

_id_2221() {
  return level._id_221E[level._id_221E.size - 1];
}

_id_2222() {
  return level._id_221E.size > 0;
}

_id_2223() {
  return level._id_221F[level._id_221F.size - 1];
}

_id_2224(var_0, var_1) {
  level._id_221E[level._id_221E.size] = var_0.origin;
  level._id_221F[level._id_221F.size] = var_1;
  common_scripts\utility::flag_set("spawning_friendlies");
}

_id_2225() {
  self endon("death");
  self endon("leaveSquad");
  wait 0.5;
  self setgoalentity(level.player);
}

_id_2226(var_0) {
  self notify("stopTrigger");
  self endon("stopTrigger");
  self waittill("trigger");

  if(_id_2223() != var_0) {
    return;
  }
  _id_2220();
}

_id_2227(var_0) {
  var_1 = getent(self.target, "targetname");

  for(;;) {
    self waittill("trigger");
    var_0 notify("friendly_wave_start", var_1);

    if(!isDefined(var_1.target)) {
      continue;
    }
  }
}

_id_1E98() {
  var_0 = getEntArray("info_volume", "classname");
  level._id_2228 = [];
  level._id_1E98 = [];

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(isDefined(var_2._id_13BF)) {
      level._id_2228[var_2._id_13BF] = var_2;

    }
    if(isDefined(var_2._id_1830)) {
      level._id_1E98[var_2._id_1830] = var_2;
    }
  }
}

debugprint(var_0, var_1, var_2) {
  if(1) {
    return;
  }
  var_3 = self getorigin();
  var_4 = 40 * sin(var_3[0] + var_3[1]) - 40;
  var_3 = (var_3[0], var_3[1], var_3[2] + var_4);
  level endon(var_1);
  self endon("new_color");

  if(!isDefined(var_2)) {
    var_2 = (0, 0.8, 0.6);

  }
  var_5 = 0;

  for(;;) {
    var_5 = var_5 + 12;
    var_6 = sin(var_5) * 0.4;

    if(var_6 < 0) {
      var_6 = var_6 * -1;

    }
    var_6 = var_6 + 1;
    wait 0.05;
  }
}

_id_222A(var_0) {
  level._id_20FE[var_0] = spawnStruct();
  level._id_20FE[var_0]._id_222B = 0;
  level._id_20FE[var_0]._id_222C = 0;
  level._id_20FE[var_0]._id_21FF = [];
  level._id_20FE[var_0]._id_222D = [];
}

_id_222E(var_0) {
  self endon("death");
  self._id_222F = 0;
  var_0._id_222C++;
  thread _id_2230(var_0);
  thread _id_2231(var_0);

  while(self.count) {
    self waittill("spawned", var_1);

    if(maps\_utility::_id_13AF(var_1)) {
      continue;
    }
    var_1 thread _id_2232(var_0);
  }

  waittillframeend;

  if(self._id_222F) {
    return;
  }
  self._id_222F = 1;
  var_0._id_222C--;
}

_id_2230(var_0) {
  self waittill("death");

  if(self._id_222F) {
    return;
  }
  var_0._id_222C--;
}

_id_2231(var_0) {
  self endon("death");
  self waittill("emptied spawner");
  waittillframeend;

  if(self._id_222F) {
    return;
  }
  self._id_222F = 1;
  var_0._id_222C--;
}

_id_2232(var_0) {
  var_0._id_222B++;
  var_0._id_21FF[var_0._id_21FF.size] = self;

  if(isDefined(self._id_2117)) {
    _id_2143();
  } else {
    self waittill("death");

  }
  var_0._id_222B--;
}

_id_1EA7(var_0) {
  var_1 = strtok(var_0.script_linkto, " ");
  var_2 = [];
  var_3 = [];

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    var_5 = var_1[var_4];
    var_6 = getent(var_5, "script_linkname");

    if(isDefined(var_6)) {
      var_2 = common_scripts\utility::add_to_array(var_2, var_6);
      continue;
    }

    var_7 = getnode(var_5, "script_linkname");

    if(!isDefined(var_7)) {
      continue;
    }
    var_3 = common_scripts\utility::add_to_array(var_3, var_7);
  }

  var_0 waittill("trigger");
  var_3 = maps\_utility::_id_0B53(var_3);

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    var_3[var_4]._id_2233 = 0;

  }
  var_8 = 0;

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    var_9 = var_2[var_4];

    if(!isDefined(var_9)) {
      continue;
    }
    if(isDefined(var_9._id_2234)) {
      continue;
    }
    while(isDefined(var_3[var_8].script_noteworthy) && var_3[var_8].script_noteworthy == "dont_spawn") {
      var_8++;

    }
    var_9.origin = var_3[var_8].origin;
    var_9.angles = var_3[var_8].angles;
    var_9 maps\_utility::add_spawn_function(::_id_2238, var_3[var_8]);
    var_8++;
  }

  common_scripts\utility::array_thread(var_2, maps\_utility::add_spawn_function, ::_id_2235);
  common_scripts\utility::array_thread(var_2, maps\_utility::add_spawn_function, ::_id_2236, var_3);
  common_scripts\utility::array_thread(var_2, maps\_utility::_id_166F);
}

_id_2235() {
  self.goalradius = 8;
  self.fixednode = 1;
}

_id_2236(var_0) {
  self endon("death");
  var_1 = 0;

  for(;;) {
    if(!isalive(self.enemy)) {
      self waittill("enemy");
      var_1 = 0;
      continue;
    }

    if(isplayer(self.enemy)) {
      if(self.enemy maps\_utility::_id_1008("player_has_red_flashing_overlay") || common_scripts\utility::flag("player_flashed")) {
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
      if(self cansee(self.enemy)) {
        var_1 = 1;

      }
      wait 0.05;
      continue;
    }

    if(randomint(3) > 0) {
      var_2 = _id_2239(var_0);

      if(isDefined(var_2)) {
        _id_2238(var_2, self._id_2237);
        self waittill("goal");
      }
    }
  }
}

_id_2238(var_0, var_1) {
  self setgoalnode(var_0);
  self._id_2237 = var_0;
  var_0._id_2233 = 1;

  if(isDefined(var_1)) {
    var_1._id_2233 = 0;
  }
}

_id_2239(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(var_0[var_1]._id_2233) {
      continue;
    } else {
      return var_0[var_1];
    }
  }

  return undefined;
}

_id_1EA8(var_0) {
  var_1 = getEntArray(var_0.target, "targetname");
  common_scripts\utility::array_thread(var_1, ::_id_223A);
  var_0 waittill("trigger");
  var_1 = getEntArray(var_0.target, "targetname");
  common_scripts\utility::array_thread(var_1, ::_id_223D, var_0);
}

_id_223A(var_0) {}

_id_223B(var_0) {
  if(!isDefined(var_0)) {
    return 0;

  }
  return isDefined(var_0._id_21A8);
}

_id_1EA9(var_0) {
  var_1 = getent(var_0.target, "targetname");
  waittillframeend;
  var_2 = getEntArray(var_1.target, "targetname");

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_2[var_3]._id_2005 = 1;
    var_2[var_3] maps\_utility::add_spawn_function(::_id_223C, var_1);
  }

  var_0 waittill("trigger");
  var_2 = getEntArray(var_1.target, "targetname");
  common_scripts\utility::array_thread(var_2, maps\_utility::_id_166F);
}

_id_223C(var_0) {
  var_0 endon("death");
  self endon("death");
  self.goalradius = 8;
  var_0 waittill("trigger");
  thread _id_21A4();
}

_id_223D(var_0) {
  self endon("death");
  self notify("stop current floodspawner");
  self endon("stop current floodspawner");

  if(_id_2240()) {
    _id_2243(var_0);
    return;
  }

  var_1 = _id_223B(var_0);
  maps\_utility::script_delay();

  while(self.count > 0) {
    while(var_1 && !level.player istouching(var_0)) {
      wait 0.5;

    }
    var_2 = isDefined(self._id_212E) && common_scripts\utility::flag("_stealth_enabled") && !common_scripts\utility::flag("_stealth_spotted");

    if(isDefined(self._id_212F)) {
      var_3 = self stalingradspawn(var_2);
    } else {
      var_3 = self dospawn(var_2);

    }
    if(maps\_utility::_id_13AF(var_3)) {
      wait 2;
      continue;
    }

    if(isDefined(self._id_2130)) {
      if(self._id_2130 == "heat") {
        var_3 maps\_utility::_id_2131();

      }
      if(self._id_2130 == "cqb") {
        var_3 maps\_utility::_id_109B();
      }
    }

    var_3 thread _id_2136(self);
    var_3 thread _id_2245(var_0);
    var_3 waittill("death", var_4);

    if(!_id_223F(var_3, var_4)) {
      self.count++;
    } else if(isDefined(level._id_223E)) {
      if(isDefined(level._id_1C52) && var_4 == level._id_1C52) {
        if(randomint(2) == 0) {
          self.count++;
        }
      }
    }

    if(!isDefined(var_3)) {
      continue;
    }
    if(!maps\_utility::_id_2133()) {
      wait(randomfloatrange(5, 9));
    }
  }
}

_id_223F(var_0, var_1) {
  if(isDefined(self._id_2137)) {
    if(self._id_2137) {
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

_id_2240() {
  if(!isDefined(self.target)) {
    return 0;

  }
  var_0 = getEntArray(self.target, "targetname");

  if(!var_0.size) {
    return 0;

  }
  return issubstr(var_0[0].classname, "actor");
}

_id_2241(var_0) {
  var_0._id_2242 waittill("death");
  self notify("death_report");
}

_id_2243(var_0) {
  self endon("death");
  var_1 = _id_223B(var_0);
  maps\_utility::script_delay();

  if(var_1) {
    while(!level.player istouching(var_0)) {
      wait 0.5;
    }
  }

  var_2 = getEntArray(self.target, "targetname");
  self._id_222D = 0;
  common_scripts\utility::array_thread(var_2, ::_id_2244, self);
  var_4 = randomint(var_2.size);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(self.count <= 0) {
      return;
    }
    var_4++;

    if(var_4 >= var_2.size) {
      var_4 = 0;

    }
    var_5 = var_2[var_4];
    var_5 maps\_utility::_id_213D(1);
    var_6 = var_5 maps\_utility::_id_166F();

    if(maps\_utility::_id_13AF(var_6)) {
      wait 2;
      continue;
    }

    self.count--;
    var_5._id_2242 = var_6;
    var_6 thread _id_2136(self);
    var_6 thread _id_2245(var_0);
    thread _id_2241(var_5);
  }

  var_7 = 0.01;

  while(self.count > 0) {
    self waittill("death_report");
    maps\_utility::_id_2133();
    wait(var_7);
    var_7 = var_7 + 2.5;
    var_4 = randomint(var_2.size);

    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      var_2 = common_scripts\utility::array_removeundefined(var_2);

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

      if(isalive(var_5._id_2242)) {
        continue;
      }
      if(isDefined(var_5.target)) {
        self.target = var_5.target;
      } else {
        self.target = undefined;

      }
      var_6 = maps\_utility::_id_166F();

      if(maps\_utility::_id_13AF(var_6)) {
        wait 2;
        continue;
      }

      var_6 thread _id_2136(self);
      var_6 thread _id_2245(var_0);
      var_5._id_2242 = var_6;
      thread _id_2241(var_5);

      if(self.count <= 0) {
        return;
      }
    }
  }
}

_id_2244(var_0) {
  var_0 endon("death");
  var_0._id_222D++;
  self waittill("death");
  var_0._id_222D--;

  if(!var_0._id_222D) {
    var_0 delete();
  }
}

_id_2245(var_0) {
  if(isDefined(self._id_1382)) {
    return;
  }
  var_1 = level._id_2070;

  if(isDefined(var_0)) {
    if(isDefined(var_0.script_radius)) {
      if(var_0.script_radius == -1) {
        return;
      }
      var_1 = var_0.script_radius;
    }
  }

  if(isDefined(self._id_1382)) {
    return;
  }
  self endon("death");
  self waittill("goal");
  self.goalradius = var_1;
}

_id_2246() {
  self endon("death");
  wait 95;
  self notify("timeout");
}

_id_2247() {
  self endon("timeout");
  thread _id_2246();
  self waittill("trigger");
  maps\_utility::_id_2248(1);
}

_id_2249(var_0) {
  for(;;) {
    wait 0.05;
  }
}

_id_224A() {}

_id_1EAA(var_0) {
  var_0 waittill("trigger");
  var_1 = getEntArray(var_0.target, "targetname");

  if(!var_1.size) {
    return;
  }
  var_2 = common_scripts\utility::random(var_1);
  var_1 = [];
  var_1[var_1.size] = var_2;

  if(isDefined(var_2.script_linkto)) {
    var_3 = strtok(var_2.script_linkto, " ");

    for(var_4 = 0; var_4 < var_3.size; var_4++) {
      var_1[var_1.size] = getent(var_3[var_4], "script_linkname");
    }
  }

  waittillframeend;
  common_scripts\utility::array_thread(var_1, maps\_utility::add_spawn_function, ::_id_224B);
  common_scripts\utility::array_thread(var_1, maps\_utility::_id_166F);
}

_id_224B() {
  if(isDefined(self._id_1382)) {
    return;
  }
  self endon("death");
  self waittill("reached_path_end");

  if(!isDefined(self getgoalvolume())) {
    self.goalradius = level._id_2070;
  }
}

_id_1EAB(var_0) {
  var_1 = var_0 maps\_utility::_id_13C1();
  common_scripts\utility::flag_init(var_1);

  while(level._id_13C0[var_0._id_13BF] > 0) {
    level waittill("spawner_expired" + var_0._id_13BF);

  }
  common_scripts\utility::flag_set(var_1);
}

_id_224C() {
  self endon("death");
  waittillframeend;
  self._id_224D = isplayer(self);
  self._id_1F3D = [];
  self._id_1F3E = [];

  for(var_0 = 0; var_0 < level._id_224E; var_0++) {
    self._id_1F3D[var_0] = 0;
  }
}

_id_1F41() {
  level._id_1F41[level.unique_id] = self;
  self waittill("death");
  waittillframeend;
  level._id_1F41[level.unique_id] = undefined;
}

#using_animtree("generic_human");

_id_1B49(var_0) {
  var_1 = var_0 spawndrone();
  var_1 useanimtree(#animtree);

  if(var_1.weapon != "none") {
    var_2 = getweaponmodel(var_1.weapon);
    var_1 attach(var_2, "tag_weapon_right");
    var_3 = getweaponhidetags(var_1.weapon);

    for(var_4 = 0; var_4 < var_3.size; var_4++) {
      var_1 hidepart(var_3[var_4], var_2);
    }
  }

  var_1.spawner = var_0;
  var_1._id_224F = isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "drone_delete_on_unload";
  var_0 notify("drone_spawned", var_1);
  return var_1;
}

_id_2250(var_0) {
  if(!isDefined(var_0.spawner)) {}

  var_1 = var_0.spawner.origin;
  var_2 = var_0.spawner.angles;
  var_0.spawner.origin = var_0.origin;
  var_0.spawner.angles = var_0.angles;
  var_3 = var_0.spawner stalingradspawn();
  var_4 = maps\_utility::_id_13AF(var_3);

  if(var_4) {}

  var_3._id_2251 = var_0._id_2251;
  var_3._id_2252 = var_0._id_2252;
  var_3._id_2253 = var_0._id_2253;
  var_3._id_2254 = var_0._id_2254;
  var_0.spawner.origin = var_1;
  var_0.spawner.angles = var_2;
  var_0 delete();
  return var_3;
}

_id_2255() {
  self waittill("death", var_0, var_1, var_2);

  if(!isDefined(self)) {
    return;
  }
  if(!self isbadguy()) {
    return;
  }
  if(!isDefined(var_0)) {
    return;
  }
  if(!isplayer(var_0)) {
    return;
  }
  thread _id_4414(var_0, var_1, var_2);
  thread _id_4415(var_0, var_1, var_2);
  thread _id_01D2(var_0, var_1, var_2);

  if(isDefined(self._id_2157)) {
    var_1 = self._id_2157;
  }
}

_id_4414(var_0, var_1, var_2) {
  if(var_1 != "MOD_GRENADE_SPLASH") {
    var_0._id_4414 = undefined;
    return;
  }

  if(!isDefined(var_2)) {
    var_0._id_4414 = undefined;
    return;
  }

  if(weaponinventorytype(var_2) != "offhand") {
    var_0._id_4414 = undefined;
    return;
  }

  if(!isDefined(var_0._id_4414)) {
    var_0._id_4414 = 1;
  } else {
    var_0._id_4414++;

  }
  if(var_0._id_4414 == 5) {
    var_0 maps\_utility::_id_1E39("STRIKE");

  }
  waittillframeend;
  var_0._id_4414 = undefined;
}

_id_4415(var_0, var_1, var_2) {
  if(var_1 == "MOD_MELEE") {
    if(!isDefined(var_0._id_4415)) {
      var_0._id_4415 = 1;
    } else {
      var_0._id_4415++;

    }
    if(var_0._id_4415 == 5) {
      var_0 maps\_utility::_id_1E39("JACK_THE_RIPPER");
    }
  } else {
    var_0._id_4415 = undefined;
  }
}

_id_01D2(var_0, var_1, var_2) {
  if(isDefined(self._id_0A37) && self._id_0A37 && var_1 == "MOD_MELEE" && (!isDefined(var_2) || !issubstr(var_2, "riotshield") && !issubstr(var_2, "riot_shield"))) {
    var_0 maps\_utility::_id_1E39("SERRATED_EDGE");
  }
}

_id_2256(var_0) {}

_id_2268() {
  var_0 = self._id_1EBC;
  var_1 = self._id_21FA;

  if(!isDefined(level._id_1E90[var_0])) {
    level._id_1E90[var_0] = [];

  }
  if(!isDefined(level._id_1E90[var_0][var_1])) {
    level._id_1E90[var_0][var_1] = [];

  }
  level._id_1E90[var_0][var_1][self.export] = self;
}

_id_226A() {
  var_0 = self._id_1F95;
  var_1 = self._id_226B;

  if(!isDefined(level._id_1EA0[var_0])) {
    level._id_1EA0[var_0] = [];

  }
  if(!isDefined(level._id_1EA0[var_0][var_1])) {
    level._id_1EA0[var_0][var_1] = [];

  }
  level._id_1EA0[var_0][var_1][self.export] = self;
}

_id_226C() {
  self endon("death");
  self._id_1199 = 1;
  wait 3;
  self._id_1199 = 0;
}

deathtime() {
  self endon("death");
  wait(self._id_2173);
  wait(randomfloat(10));
  self kill();
}