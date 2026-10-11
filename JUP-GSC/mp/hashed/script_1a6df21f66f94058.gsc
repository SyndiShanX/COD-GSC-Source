/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_1a6df21f66f94058.gsc
*************************************************/

#using script_2047cdbf5176ba0;
#using script_208955cb4d2c8fb3;
#using script_24fbedba9a7a1ef4;
#using script_41387eecc35b88bf;
#using script_42adcce5878f583;
#using script_6995888daf1a86e;
#using script_7e41e37180e554f;
#using script_ec2a55b85051e9b;
#using script_edb8e725d068ac9;
#using scripts\asm\asm;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\gasmask;
#using scripts\cp_mp\killstreaks\helper_drone;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\math;
#using scripts\engine\utility;
#using scripts\mp\utility\script;
#namespace namespace_9f019848a4f1b0f2;

function autoexec main() {
  namespace_ad1f398af6f48cb1::setup_data("Chemist", "WARLORD_CHEMIST");
  namespace_ad1f398af6f48cb1::function_56e8f78ce1511d35("Chemist", &oninitialization);
  namespace_ad1f398af6f48cb1::function_dbfada6bda9049b3("Chemist", &function_325892ecd89575e1);
  namespace_ad1f398af6f48cb1::function_32d58ef031f811e5("Chemist", &function_21039072892a1a46);
  level scripts\common\callbacks::add("on_zombie_ai_spawned", &function_ee2770a2fe71d2);
  level.var_b2b35840c12ce55c["gas_grenade_chemist_exgm"] = &namespace_d3f3cf99d75d3345::function_584accf001003add;
  level.var_367d292e115ae65c = &function_afa2965998bfa8cf;
  level.var_81ba5adae4e23b59 = &function_9f559ae98d816f54;
  level.var_381f13069ba0b5d4 = &namespace_d3f3cf99d75d3345::gas_createtrigger;

  setdvarifuninitialized(@ "hash_54fc92ada753c66a", "<dev string:x1c>");
  setdvarifuninitialized(@ "hash_213776149170b77d", "<dev string:x1c>");
  setdvarifuninitialized(@ "hash_8c0b4f15bd7fd07b", "<dev string:x1c>");
  setdvarifuninitialized(@ "hash_8a1cc8908c6494a8", "<dev string:x1c>");

  setdvarifuninitialized(@ "hash_71db33dac3141054", 2);
  scripts\engine\utility::registersharedfunc("warlords", "tile_c_warlord_registration", &function_11b424487e28934);
}

function private function_11b424487e28934() {
  if(!istrue(scripts\engine\utility::callsharedfunc("warlords", "warlordIsDisabled", "WARLORD_CHEMIST"))) {
    namespace_609d2ee77dae3d8c::function_447c6ab4bea16b52("objective", "REV_OB_WARLORD", &namespace_75b9b66caa533c31::function_8abadf3d8f19384a, &namespace_d1d9f1596b655e40::function_fd69cf02ba4d90a2);
  }
}

function oninitialization(agent, userdata) {
  warlordparameters = namespace_ad1f398af6f48cb1::function_9acf953fd6bf2e46("Chemist");
  function_eb98b97f412981da(agent, warlordparameters);
  function_15f8975c6e32f069(agent, warlordparameters);
  function_5c459133d355fcd3();
}

function function_325892ecd89575e1(agent, userdata) {
  warlordparameters = namespace_ad1f398af6f48cb1::function_9acf953fd6bf2e46("Chemist");
  function_a978a5c7de9cdba2(agent, warlordparameters);
}

function function_15f8975c6e32f069(warlord, var_3716647cb96f1f04) {
  namespace_d3f3cf99d75d3345::function_c17d42c1c9426b4f(warlord, var_3716647cb96f1f04);
  warlord.chemist.iswarlord = 1;
  warlord.chemist.var_ddd49c02e8a6b496 = default_to(var_3716647cb96f1f04.var_ddd49c02e8a6b496, 3);
  warlord.chemist.var_8e4066ce4def853c = default_to(var_3716647cb96f1f04.var_8e4066ce4def853c, "FollowChemist");
  warlord.chemist.var_4cc27cef1fa6d563 = default_to(var_3716647cb96f1f04.var_4cc27cef1fa6d563, 4);
  warlord.chemist.var_68d81840282013fc = default_to(var_3716647cb96f1f04.var_68d81840282013fc, 3);
  warlord.chemist.gasclouds = [];

  for(var_2fe17a4d7e7c2f96 = 0; var_2fe17a4d7e7c2f96 < self.chemist.var_68d81840282013fc; var_2fe17a4d7e7c2f96++) {
    self.chemist.cloudslots[var_2fe17a4d7e7c2f96] = var_2fe17a4d7e7c2f96;
  }

  warlord.radimmune = 1;
  warlord function_741a41cd8e7cacd0(warlord.chemist.gasradius * warlord.chemist.var_353647cb7ffa6545);
  warlord thread function_380c803fc190244f();
  warlord thread function_57f4dbf6fd0f87cb();
  warlord thread function_5f43cd06008e387f();
  setdvarifuninitialized(@ "hash_9ae216012f64affd", 1);
  level.chemist = warlord;
  warlord.bodyguards = [];

  setdvarifuninitialized(@ "hash_b0bb80340bfcdbe2", self.chemist.var_ddd49c02e8a6b496);
  setdvarifuninitialized(@ "hash_8c9ae83d2eacef", self.chemist.gasradius);
  setdvarifuninitialized(@ "hash_b804dde808052bcd", self.chemist.var_a985895b5796100b);
  warlord thread function_ab1752f09c7cf333();

  warlord.alreadydroppedweapon = 1;
  warlord.var_11bdacfec33ee724 = 1;
  warlord.callbackdamaged = &function_b48154027e80e9c8;

  foreach(activityinstance in level.ob.var_7dd4780d4e4bff4d) {
    if(issubstr(activityinstance.varianttag, "CHEMIST")) {
      activityinstance.arenadamage = default_to(var_3716647cb96f1f04.arenadamage, 3);
      activityinstance.var_a0ad94558bb6d3d1 = default_to(var_3716647cb96f1f04.var_a0ad94558bb6d3d1, 1.66);

      if(activityinstance.goal_volumes.size > 0) {
        warlord.chemist.goalvolume = activityinstance.goal_volumes[0];
        var_dd0473030759e86f = 1;
      }

      break;
    }
  }

  assertex(istrue(var_dd0473030759e86f), "<dev string:x21>");
}

function function_21039072892a1a46(agent, userdata) {
  if(isDefined(agent.chemist) && isDefined(agent.chemist.goalvolume)) {
    agent setgoalvolumeauto(agent.chemist.goalvolume);

    if(isDefined(agent.chemist.bodyguards)) {
      foreach(bodyguard in agent.chemist.bodyguards) {
        bodyguard setgoalvolumeauto(agent.chemist.goalvolume);
      }
    }
  }
}

function function_eb98b97f412981da(warlord, warlordparameters) {
  warlord.stalker = spawnStruct();
  warlord.stalker.var_676a9574befe2b66 = warlordparameters.var_676a9574befe2b66;
  warlord.stalker.var_35d7093a7102d784 = warlordparameters.smokeduration;
  warlord.stalker.var_79a1c3a40f487ae5 = warlordparameters.var_fd316c47f1527c93;
  warlord.stalker.var_edbb6dcc8681957c = 1;
}

function function_fe24d20e95695719(note) {
  if(isDefined(note) && note == "grenade_off") {
    if(isDefined(self.stalker.var_5ef48f5f6c22686b)) {
      self thread[[self.stalker.var_5ef48f5f6c22686b]](self.origin);
      return;
    }

    self.stalker.droppedgrenade = spawnscriptable(self.stalker.var_676a9574befe2b66, self.origin, (-90, 0, 0));
    self.stalker.droppedgrenade setscriptablepartstate("smoke", "on");
    self.stalker.var_edbb6dcc8681957c = 0;
    thread function_5d469096b55c225a();
  }
}

function function_5d469096b55c225a() {
  wait self.stalker.var_35d7093a7102d784;
  self.stalker.droppedgrenade setscriptablepartstate("smoke", "off");
  waitframe();
  self.stalker.droppedgrenade freescriptable();
  wait self.stalker.var_79a1c3a40f487ae5;
  self.stalker.var_edbb6dcc8681957c = 1;
}

function function_b37d2b03ee8dfe69() {
  level endon("game_ended");
  self endon("death");

  while(true) {
    scripts\cp_mp\killstreaks\helper_drone::tryusehelperdrone("scrambler_drone_guard");
    self waittill("drone_destroyed", wasdestroyed);

    if(istrue(wasdestroyed)) {
      wait self.stalker.var_97392817632a7573;
      continue;
    }

    wait self.stalker.var_9c68564e0a21e800;
  }
}

function function_ab375c9b96650987(asmname, statename, params) {
  alias = "";

  if(isDefined(self.damageyaw)) {
    if(self.damageyaw > 135) {
      alias = "2";
    } else if(self.damageyaw > 45) {
      alias = "6";
    } else if(self.damageyaw > -45) {
      alias = "8";
    } else if(self.damageyaw > -135) {
      alias = "4";
    } else {
      alias = "2";
    }
  } else {
    alias = "8";
  }

  return scripts\asm\asm::asm_lookupanimfromalias(statename, alias);
}

function function_a978a5c7de9cdba2(bodyguard, var_cbe65bcc55bb8492) {
  bodyguard.radimmune = 1;
  bodyguard function_741a41cd8e7cacd0(var_cbe65bcc55bb8492.gasradius * var_cbe65bcc55bb8492.var_affbf78d9cdb1361);
  level.chemist.bodyguards = array_add(level.chemist.bodyguards, bodyguard);
}

function function_57f4dbf6fd0f87cb() {
  level endon("game_ended");
  self endon("death");

  while(true) {
    self waittill("trigger_destroyed", var_95ac049b4af7cea1);
    function_1c300798d7dceca5();

    if(self.goalpos == var_95ac049b4af7cea1.origin) {
      function_2936f08c196809e7();
    }

    waitframe();
  }
}

function function_5f43cd06008e387f() {
  self endon("death");
  level endon("game_ended");
  var_e394465173d031ec = 0;

  while(true) {
    if(self.bisincombat) {
      if(!var_e394465173d031ec) {
        initialwait = self.chemist.var_884e31585e1488e7;
        wait initialwait;
        var_e394465173d031ec = 1;
      }

      if(isDefined(self.enemy) && isDefined(self.grenadeweapon) && self cansee(self.enemy)) {
        if(self.grenadeammo == 0) {
          self.grenadeammo++;
        }

        grenadetype = self.grenadeweapon.basename;
        var_8ea931149354e622 = 300;
        heightdiff = abs(self.enemy.origin[2] - self.origin[2]);
        var_a22c8ff50bd01e2f = clamp(heightdiff / var_8ea931149354e622, 0, 1);
        heightoffset = scripts\engine\math::lerp(0, 10, var_a22c8ff50bd01e2f);
        grenadetargetpos = self.enemy.origin + (0, 0, heightoffset);
        scripts\cp_mp\agents\agent_utils::function_ae99616202575e39(grenadetargetpos, grenadetype, undefined, 0);
        wait self.chemist.var_5aaa252fb3c34a87;
      }
    }

    wait 1;
  }
}

function function_e06d209c6ac42e4c(triggeringent, tripwire) {
  triggeringent thread namespace_d3f3cf99d75d3345::function_abe80254fe179ec7(triggeringent.origin, 1);
}

function function_b48154027e80e9c8(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon) {
  if(!isDefined(self.chemist.var_918e96d1d5362916)) {
    self.chemist.var_918e96d1d5362916 = 0;
  }

  if(!isDefined(self.var_6aa61171d7cbeaa3)) {
    self.var_6aa61171d7cbeaa3 = 0;
  }

  if(self.var_6aa61171d7cbeaa3 < gettime()) {
    namespace_d3f3cf99d75d3345::function_870ea0fefcd757f4(1, isDefined(self.chemist));
    self.var_2cb06c767e8080ff = gettime() + 500;
    self.var_6aa61171d7cbeaa3 = self.var_2cb06c767e8080ff + 1000 * getdvarfloat(@ "hash_71db33dac3141054", 2);
  }

  if(gettime() > self.chemist.var_918e96d1d5362916) {
    function_1c300798d7dceca5();
    function_2936f08c196809e7();
  }

  idamage = namespace_ad1f398af6f48cb1::function_395c3a00db83ba6(idamage, smeansofdeath, objweapon);
  namespace_daa149ca485fd50a::function_dffac413ed66bcd0(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon);
}

function function_2936f08c196809e7() {
  if(self.chemist.gasclouds.size > 0) {
    self.chemist.var_918e96d1d5362916 = gettime() + self.chemist.var_4cc27cef1fa6d563 * 1000;
    var_dba21b1ab8cd0d5c = self.chemist.gasradius * 0.5;
    bestdist = 0;

    foreach(gascloud in self.chemist.gasclouds) {
      if(isDefined(gascloud)) {
        var_695c5f3e67d07095 = distance(self.origin, gascloud.origin);

        if(var_695c5f3e67d07095 >= bestdist) {
          var_e6f7f117af3819e4 = gascloud;
          bestdist = var_695c5f3e67d07095;
        }
      }
    }

    randx = randomfloatrange(-0.8, 0.8);
    randy = randomfloatrange(-0.8, 0.8);
    var_e59b538d189553bc = (var_dba21b1ab8cd0d5c * randx, var_dba21b1ab8cd0d5c * randy, 0);
    targetpos = getclosestpointonnavmesh(var_e6f7f117af3819e4.origin + var_e59b538d189553bc);
    self setgoalpos(targetpos, var_dba21b1ab8cd0d5c);

    dvar = getunarchiveddebugdvar(@ "hash_8a1cc8908c6494a8", "<dev string:x1c>");

    if(int(dvar)) {
      if(bestdist < var_dba21b1ab8cd0d5c) {
        print3d(self.origin, "<dev string:x82>", (1, 0, 1), 1, 1, 20, 1);
      }

      draw_circle(var_e6f7f117af3819e4.origin, var_dba21b1ab8cd0d5c, (0, 1, 1), 1, 0, 20);
    }

    dvar = int(getunarchiveddebugdvar(@ "hash_8c0b4f15bd7fd07b", "<dev string:x1c>"));

    if(dvar) {
      switch (dvar) {
        case 1:
          self.chemist.var_8e4066ce4def853c = "<dev string:xa7>";
          break;
        case 2:
          self.chemist.var_8e4066ce4def853c = "<dev string:xb8>";
          break;
        case 3:
          self.chemist.var_8e4066ce4def853c = "<dev string:xc6>";
          break;
      }
    }

    switch (self.chemist.var_8e4066ce4def853c) {
      case #"hash_52b06792de26b86b":
        foreach(bodyguard in self.bodyguards) {
          if(isalive(bodyguard)) {
            bodyguard function_85e7c2baf116abf8(self);
          }
        }

        break;
      case #"hash_371022f5b1c1f06a":
        for(var_1edf155d034eccbe = 0; var_1edf155d034eccbe < self.bodyguards.size; var_1edf155d034eccbe++) {
          bodyguard = self.bodyguards[var_1edf155d034eccbe];

          if(isalive(bodyguard)) {
            var_2fe17a4d7e7c2f96 = var_1edf155d034eccbe % self.chemist.gasclouds.size;
            var_e6f7f117af3819e4 = self.chemist.gasclouds[var_2fe17a4d7e7c2f96];
            bodyguard function_2cb8a233e10962b5();
            bodyguard setgoalpos(var_e6f7f117af3819e4.origin, self.chemist.gasradius);
          }
        }

        break;
      case #"hash_d950ebd1da4d0aa2":
        foreach(bodyguard in self.bodyguards) {
          if(isalive(bodyguard)) {
            var_e6f7f117af3819e4 = array_random(self.chemist.gasclouds);
            bodyguard function_2cb8a233e10962b5();
            bodyguard setgoalpos(var_e6f7f117af3819e4.origin, self.chemist.gasradius);
          }
        }

        break;
    }

    return;
  }

  function_c2108f8c1f9625b8();
}

function function_1c300798d7dceca5() {
  if(self.chemist.gasclouds.size > 0) {
    foreach(gascloud in self.chemist.gasclouds) {
      if(!isDefined(gascloud)) {
        self.chemist.gasclouds = array_remove(self.chemist.gasclouds, gascloud);
      }
    }
  }
}

function private function_273365e63042c310(var_712a263a7ea760e, var_7128963a7ea3f13, var_debb750de57351e, var_48f6987d66e459d6, aabb) {
  var_d06f14b85814a4c8 = var_debb750de57351e * 0.5;
  var_2100670c437cd4b0 = var_48f6987d66e459d6 * 0.5;
  var_3064cf7c293bbc6e = aabb["min"][0] + var_712a263a7ea760e * var_debb750de57351e + var_d06f14b85814a4c8;
  cloudy = aabb["min"][1] + var_7128963a7ea3f13 * var_48f6987d66e459d6 + var_2100670c437cd4b0;
  var_3064cd7c293bb808 = aabb["min"][2];
  return (var_3064cf7c293bbc6e, cloudy, var_3064cd7c293bb808);
}

function private function_dd653e96ed539114(var_5f1af3d2cf0d8d69, var_5b2481e83a7571ca) {
  var_ae9a8da3d83c576e = 1;

  foreach(square in var_5f1af3d2cf0d8d69) {
    if(array_compare(square, var_5b2481e83a7571ca)) {
      var_ae9a8da3d83c576e = 0;
      break;
    }
  }

  return var_ae9a8da3d83c576e;
}

function private function_3464e87269ef5eb5(aabb, var_debb750de57351e, var_48f6987d66e459d6, var_5cac484eae2169f7, var_ace97a1e1e4dc80d, var_5f1af3d2cf0d8d69) {
  if(isDefined(var_5f1af3d2cf0d8d69)) {
    if(var_5f1af3d2cf0d8d69.size > 0) {
      var_d74acbf5f46e7ff5 = [];

      for(var_22005e4dd144c15c = 0; var_22005e4dd144c15c < var_5f1af3d2cf0d8d69.size; var_22005e4dd144c15c++) {
        if(var_5f1af3d2cf0d8d69[var_22005e4dd144c15c][0] > 0) {
          var_5b2481e83a7571ca = [var_5f1af3d2cf0d8d69[var_22005e4dd144c15c][0] - 1, var_5f1af3d2cf0d8d69[var_22005e4dd144c15c][1]];

          if(function_dd653e96ed539114(var_5f1af3d2cf0d8d69, var_5b2481e83a7571ca)) {
            var_d74acbf5f46e7ff5[var_d74acbf5f46e7ff5.size] = var_5b2481e83a7571ca;
          }
        }

        if(var_5f1af3d2cf0d8d69[var_22005e4dd144c15c][0] < var_5cac484eae2169f7 - 1) {
          var_5b2481e83a7571ca = [var_5f1af3d2cf0d8d69[var_22005e4dd144c15c][0] + 1, var_5f1af3d2cf0d8d69[var_22005e4dd144c15c][1]];

          if(function_dd653e96ed539114(var_5f1af3d2cf0d8d69, var_5b2481e83a7571ca)) {
            var_d74acbf5f46e7ff5[var_d74acbf5f46e7ff5.size] = var_5b2481e83a7571ca;
          }
        }

        if(var_5f1af3d2cf0d8d69[var_22005e4dd144c15c][1] > 0) {
          var_5b2481e83a7571ca = [var_5f1af3d2cf0d8d69[var_22005e4dd144c15c][0], var_5f1af3d2cf0d8d69[var_22005e4dd144c15c][1] - 1];

          if(function_dd653e96ed539114(var_5f1af3d2cf0d8d69, var_5b2481e83a7571ca)) {
            var_d74acbf5f46e7ff5[var_d74acbf5f46e7ff5.size] = var_5b2481e83a7571ca;
          }
        }

        if(var_5f1af3d2cf0d8d69[var_22005e4dd144c15c][1] < var_ace97a1e1e4dc80d - 1) {
          var_5b2481e83a7571ca = [var_5f1af3d2cf0d8d69[var_22005e4dd144c15c][0], var_5f1af3d2cf0d8d69[var_22005e4dd144c15c][1] + 1];

          if(function_dd653e96ed539114(var_5f1af3d2cf0d8d69, var_5b2481e83a7571ca)) {
            var_d74acbf5f46e7ff5[var_d74acbf5f46e7ff5.size] = var_5b2481e83a7571ca;
          }
        }
      }

      assertex(var_d74acbf5f46e7ff5.size > 0, "<dev string:xd0>");
      return array_random(var_d74acbf5f46e7ff5);
    }

    var_2a467b228654165 = self.origin[0] - aabb["min"][0];
    var_2a47cb228656f94 = self.origin[1] - aabb["min"][1];
    var_e76caca3029eee79 = int(var_2a467b228654165 / var_debb750de57351e);
    var_e76cc1a3029f1ca8 = int(var_2a47cb228656f94 / var_48f6987d66e459d6);
    return [var_e76caca3029eee79, var_e76cc1a3029f1ca8];
  }
}

function private function_1d9a6d4f970f532(var_584d88622912b443) {
  aabb = get_aabb(self.chemist.goalvolume);
  var_22b98cdb5c88d103 = [];
  var_6e8d5a28c0c33cf5 = [];

  if(!isDefined(aabb)) {
    assertmsg("<dev string:x10a>");
    return var_6e8d5a28c0c33cf5;
  }

  var_e5028559af049efd = aabb["max"][0] - aabb["min"][0];
  var_efcb8d9501658ef3 = aabb["max"][1] - aabb["min"][1];
  assertex(var_e5028559af049efd > self.chemist.gasradius, "<dev string:x14f>");
  assertex(var_efcb8d9501658ef3 > self.chemist.gasradius, "<dev string:x197>");
  var_5cac484eae2169f7 = int(var_e5028559af049efd / 2 * self.chemist.gasradius);
  var_ace97a1e1e4dc80d = int(var_efcb8d9501658ef3 / 2 * self.chemist.gasradius);
  var_debb750de57351e = var_e5028559af049efd / var_5cac484eae2169f7;
  var_48f6987d66e459d6 = var_efcb8d9501658ef3 / var_ace97a1e1e4dc80d;
  assertex(var_584d88622912b443 < var_5cac484eae2169f7 * var_ace97a1e1e4dc80d + 1, "<dev string:x1df>");

  for(var_2fe17a4d7e7c2f96 = 0; var_2fe17a4d7e7c2f96 < var_584d88622912b443; var_2fe17a4d7e7c2f96++) {
    var_22b98cdb5c88d103[var_2fe17a4d7e7c2f96] = function_3464e87269ef5eb5(aabb, var_debb750de57351e, var_48f6987d66e459d6, var_5cac484eae2169f7, var_ace97a1e1e4dc80d, var_22b98cdb5c88d103);
  }

  assertex(var_22b98cdb5c88d103.size == var_584d88622912b443, "<dev string:x22d>");

  foreach(var_3e347f23db554582 in var_22b98cdb5c88d103) {
    var_6e8d5a28c0c33cf5[var_6e8d5a28c0c33cf5.size] = function_273365e63042c310(var_3e347f23db554582[0], var_3e347f23db554582[1], var_debb750de57351e, var_48f6987d66e459d6, aabb);
  }

  assertex(var_6e8d5a28c0c33cf5.size == var_584d88622912b443, "<dev string:x26b>");
  return var_6e8d5a28c0c33cf5;
}

function function_380c803fc190244f() {
  self endon("death");
  level endon("game_ended");

  if(!isDefined(self.chemist.var_a2dcaa338cf9101c)) {
    self.chemist.var_a2dcaa338cf9101c = 0;
  }

  utility::waittill_any_4("stealth_investigate", "stealth_hunt", "stealth_combat", "startCombatRush");
  var_83a3523418e92b00 = getdvarint(@ "hash_8bb89f10cde85d98", 0);
  wait var_83a3523418e92b00;

  while(true) {
    if(gettime() > self.chemist.var_a2dcaa338cf9101c) {
      function_c2108f8c1f9625b8();
    }

    wait 1;
  }
}

function private function_c2108f8c1f9625b8() {
  function_1c300798d7dceca5();
  var_366206e10533a38d = self.chemist.var_ddd49c02e8a6b496;
  gasradius = self.chemist.gasradius;

  if(int(getunarchiveddebugdvar(@ "hash_b0bb80340bfcdbe2", self.chemist.var_ddd49c02e8a6b496))) {
    var_366206e10533a38d = int(getunarchiveddebugdvar(@ "hash_b0bb80340bfcdbe2", self.chemist.var_ddd49c02e8a6b496));
  }

  if(int(getunarchiveddebugdvar(@ "hash_8c9ae83d2eacef", self.chemist.gasradius))) {
    gasradius = int(getunarchiveddebugdvar(@ "hash_8c9ae83d2eacef", self.chemist.gasradius));
  }

  var_5e54ef08098b9cdf = self.chemist.var_68d81840282013fc - self.chemist.gasclouds.size;

  if(var_5e54ef08098b9cdf > 0) {
    self.chemist.var_a2dcaa338cf9101c = gettime() + self.stalker.var_79a1c3a40f487ae5 * 1000;
    assertex(var_366206e10533a38d < var_5e54ef08098b9cdf, "<dev string:x2b1>" + var_366206e10533a38d + "<dev string:x2cc>" + self.chemist.var_68d81840282013fc);
    var_366206e10533a38d = min(var_5e54ef08098b9cdf, var_366206e10533a38d);
    var_bbe5951d105d31be = function_1d9a6d4f970f532(var_366206e10533a38d);

    foreach(var_f0349abbd8783539 in var_bbe5951d105d31be) {
      thread function_abe80254fe179ec7(var_f0349abbd8783539, 1);
    }

    namespace_d3f3cf99d75d3345::function_870ea0fefcd757f4(0, isDefined(self.chemist));
    function_2936f08c196809e7();
  }
}

function private function_a3b978f0d3e37d36(text) {
  if(!getdvarint(@ "hash_17f79f0678395264", 0)) {
    return;
  }

  scripts\common\debug::function_7320cd1e4f724899(text);
  println(text);
}

function private function_b8f06ed708934a74() {
  localplayer = level.player;

  if(!isDefined(localplayer) || !isalive(localplayer)) {
    return;
  }

  offset_x = 400;
  offset_y = 100;
  scale = 1;
  line_y = 20;
  printtoscreen2d(offset_x, offset_y, "<dev string:x2ef>", (0, 1, 1), scale);
  offset_y += line_y;

  if(isDefined(localplayer.gasmaskhealth) && isDefined(localplayer.gasmaskmaxhealth)) {
    printtoscreen2d(offset_x, offset_y, "<dev string:x30f>" + localplayer.gasmaskhealth + "<dev string:x32c>" + localplayer.gasmaskmaxhealth, (0, 1, 1), scale);
    offset_y += line_y;
  }

  if(localplayer function_6ef47ee9171ed1b9()) {
    foreach(id, gastrigger in localplayer.gastriggerstouching) {
      if(isDefined(gastrigger)) {
        triggertypetext = default_to(gastrigger.triggertype, "<dev string:x333>");
        printtoscreen2d(offset_x, offset_y, "<dev string:x33a>" + id + "<dev string:x342>" + triggertypetext, (0, 1, 0), scale);
        offset_y += line_y;
        continue;
      }

      printtoscreen2d(offset_x, offset_y, "<dev string:x353>", (1, 0, 0), scale);
      offset_y += line_y;
    }

    return;
  }

  printtoscreen2d(offset_x, offset_y, "<dev string:x333>", (0, 1, 0), scale);
  offset_y += line_y;
}

function private get_aabb(volume) {
  if(isDefined(volume)) {
    aabb = [];
    aabb["min"] = [];
    aabb["max"] = [];
    bounds = [];
    bounds["max"] = volume getboundshalfsize();
    bounds["min"] = bounds["max"] * -1;

    for(i = 0; i < 3; i++) {
      aabb["min"][i] = bounds["min"][i] + volume.origin[i];
      aabb["max"][i] = bounds["max"][i] + volume.origin[i];
    }

    aabb["min"] = (aabb["min"][0], aabb["min"][1], aabb["min"][2]);
    aabb["max"] = (aabb["max"][0], aabb["max"][1], aabb["max"][2]);
    return aabb;
  }
}

function private array_compare(array1, array2) {
  if(array1.size != array2.size) {
    return false;
  }

  foreach(key, member in array1) {
    if(!isDefined(array2[key])) {
      return false;
    }

    member2 = array2[key];

    if(member2 != member) {
      return false;
    }
  }

  return true;
}

function private function_ab1752f09c7cf333() {
  level endon("<dev string:x36d>");
  self endon("<dev string:x37b>");

  while(true) {
    dvar = getunarchiveddebugdvar(@ "hash_8c0b4f15bd7fd07b", "<dev string:x1c>");

    if(int(dvar) && isalive(self)) {
      space = 20;
      white = (1, 1, 1);
      red = (1, 0, 0);
      yellow = (1, 1, 0);
      green = (0, 1, 0);
      size = 1.25;
      viewpos = level.players[0] getvieworigin();
      debug_text = "<dev string:x384>" + self.chemist.gasclouds.size;
      color = white;

      if(self.chemist.gasclouds.size > 0) {
        color = green;
      }

      print3d(self.origin - (0, 0, space), debug_text, color, 1, size);

      if(isDefined(self.pathgoalpos)) {
        color = (1, 0, 1);
        line(self.origin, self.pathgoalpos, color);
      }

      line(self.origin, self.goalpos, (0, 1, 1));
      draw_circle(self.goalpos, self.goalradius, (0, 1, 1), 1, 0, 1);

      if(isDefined(self.chemist.goalvolume)) {
        aabb = get_aabb(self.chemist.goalvolume);
        topleftfront = (aabb["<dev string:x394>"][0], aabb["<dev string:x394>"][1], aabb["<dev string:x39b>"][2]);
        toprightfront = (aabb["<dev string:x39b>"][0], aabb["<dev string:x394>"][1], aabb["<dev string:x39b>"][2]);
        topleftback = (aabb["<dev string:x39b>"][0], aabb["<dev string:x394>"][1], aabb["<dev string:x39b>"][2]);
        toprightback = (aabb["<dev string:x39b>"][0], aabb["<dev string:x39b>"][1], aabb["<dev string:x39b>"][2]);
        bottomleftfront = (aabb["<dev string:x394>"][0], aabb["<dev string:x394>"][1], aabb["<dev string:x394>"][2]);
        bottomrightfront = (aabb["<dev string:x39b>"][0], aabb["<dev string:x394>"][1], aabb["<dev string:x394>"][2]);
        bottomleftback = (aabb["<dev string:x39b>"][0], aabb["<dev string:x394>"][1], aabb["<dev string:x394>"][2]);
        bottomrightback = (aabb["<dev string:x39b>"][0], aabb["<dev string:x39b>"][1], aabb["<dev string:x394>"][2]);
        scripts\cp_mp\utility\debug_utility::drawboxfrompoints(topleftfront, toprightfront, topleftback, toprightback, bottomleftfront, bottomrightfront, bottomleftback, bottomrightback, level.framedurationseconds, green);
      }

      foreach(bodyguard in self.bodyguards) {
        if(isalive(bodyguard)) {
          if(isDefined(bodyguard.pathgoalpos)) {
            color = yellow;
            line(bodyguard.origin, bodyguard.pathgoalpos, color);
          }
        }
      }

      function_b8f06ed708934a74();
    }

    waitframe();
  }
}

function function_5c459133d355fcd3() {
  foreach(activityinstance in level.ob.var_7dd4780d4e4bff4d) {
    if(activityinstance.trigger_volumes.size > 0 && issubstr(activityinstance.varianttag, "CHEMIST")) {
      chemist_instance = activityinstance;
      break;
    }
  }

  if(isDefined(chemist_instance)) {
    chemist_instance.var_83116f41aad4fc96 = [];

    foreach(volume in chemist_instance.trigger_volumes) {
      if(volume.script_noteworthy == "chemist_vision_trigger") {
        chemist_instance.var_83116f41aad4fc96[chemist_instance.var_83116f41aad4fc96.size] = volume;
        chemist_instance thread function_92582fd8a73a2383(volume);
      }
    }
  }
}

function function_afa2965998bfa8cf(relevantinfostruct) {
  if(self.varianttag == "WARLORD_CHEMIST") {
    foreach(player in relevantinfostruct.playerlist) {
      player thread function_b85c41554955b2eb(self);
    }
  }
}

function function_9f559ae98d816f54(relevantinfostruct) {
  if(self.varianttag == "WARLORD_CHEMIST") {
    foreach(player in relevantinfostruct.playerlist) {
      player notify("left_chemist_instance");
    }
  }
}

function function_92582fd8a73a2383(volume) {
  assert(isDefined(volume));
  level endon("game_ended");
  self endon("activity_ended");
  self endon("instance_destroyed");
  volume endon("death");

  while(true) {
    volume waittill("trigger", enteringentity);

    if(!isDefined(enteringentity)) {
      continue;
    }

    var_f89a7d23282c775a = [];

    if(isPlayer(enteringentity)) {
      var_f89a7d23282c775a[var_f89a7d23282c775a.size] = enteringentity;
    } else if(enteringentity scripts\cp_mp\vehicles\vehicle::isvehicle()) {
      occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(enteringentity, 0);

      if(isDefined(occupants) && isarray(occupants)) {
        foreach(occupant in occupants) {
          if(isDefined(occupant) && isPlayer(occupant)) {
            var_f89a7d23282c775a[var_f89a7d23282c775a.size] = occupant;
          }
        }
      }
    }

    foreach(player in var_f89a7d23282c775a) {
      player notify("entering_chemist_interior_trigger", volume);
    }
  }
}

function function_b85c41554955b2eb(instance) {
  instance endon("activity_ended");
  instance endon("instance_destroyed");
  level endon("game_ended");
  self endon("left_chemist_instance");
  thread function_48feb105f930a9ee(instance);

  while(true) {
    self waittill("entering_chemist_interior_trigger", ent);

    if(isDefined(instance) && isDefined(instance.var_83116f41aad4fc96) && isDefined(ent) && array_contains(instance.var_83116f41aad4fc96, ent)) {
      if(!isalive(self)) {
        continue;
      }

      if(!istrue(self.var_d9928cc9ad437613)) {
        self.var_d9928cc9ad437613 = 1;
        thread function_e1dc1c329bde811(instance);
        thread function_e439f9a1412e4bf0();
        namespace_d3f3cf99d75d3345::function_9bf22e3dc3f67495();
      }

      if(istrue(self.var_d9928cc9ad437613)) {
        self.var_da9f2014ef47f54a = gettime();
      }
    }

    wait 0.1;
  }
}

function function_e1dc1c329bde811(instance) {
  instance endon("activity_ended");
  instance endon("instance_destroyed");
  level endon("game_ended");
  self endon("left_chemist_instance");
  self notify("chemistArenaExitWatcherStarted");
  self endon("chemistArenaExitWatcherStarted");
  waitframe();

  while(self.var_d9928cc9ad437613) {
    currtime = gettime();

    if(isDefined(self.var_da9f2014ef47f54a) && currtime > self.var_da9f2014ef47f54a + 100) {
      self.var_da9f2014ef47f54a = undefined;
      self.var_d9928cc9ad437613 = 0;
      function_85a0c49ea70a16bd(instance);
      return;
    }

    if(istrue(self.gasmaskswapinprogress)) {
      waittill_notify_or_timeout("gas_mask_swap_complete", 2);
      waitframe();
    }

    wait 0.1;
  }
}

function function_e439f9a1412e4bf0() {
  level endon("game_ended");
  self endon("left_chemist_arena");
  self notify("chemistArenaGasMaskWatcherStarted");
  self endon("chemistArenaGasMaskWatcherStarted");

  while(true) {
    self waittill("gas_mask_swap_complete");

    if(istrue(self.var_d9928cc9ad437613)) {
      namespace_d3f3cf99d75d3345::function_9bf22e3dc3f67495();
    }

    wait 0.1;
  }
}

function function_48feb105f930a9ee(instance) {
  instance endon("activity_ended");
  instance endon("instance_destroyed");
  level endon("game_ended");
  self endon("left_chemist_instance");

  while(true) {
    if(istrue(self.var_d9928cc9ad437613)) {
      namespace_d3f3cf99d75d3345::toggle_gasmask("on");
      var_11e954ae279ee245 = self.gasmaskequipped;

      if(!function_6ef47ee9171ed1b9()) {
        if(scripts\cp_mp\gasmask::hasgasmask(self)) {
          scripts\cp_mp\gasmask::processdamage(instance.arenadamage);
        } else {
          self dodamage(instance.arenadamage, self.origin, self, undefined, "MOD_TRIGGER_HURT", "<explicitweaponnone>", "body");
        }

        if(isDefined(instance) && isDefined(instance.warlord_agent)) {
          if(istrue(var_11e954ae279ee245)) {
            instance.warlord_agent thread namespace_dc53a27a8db8e6bf::function_7f0a446fa91ff206(self);
          } else {
            instance.warlord_agent thread namespace_dc53a27a8db8e6bf::function_4e8e1867968e84a5(self);
          }
        }
      }

      wait instance.var_a0ad94558bb6d3d1;
    }

    wait 0.1;
  }
}

function function_85a0c49ea70a16bd(instance) {
  namespace_d3f3cf99d75d3345::function_92bdd3200219d4b7();
  self notify("left_chemist_arena");

  if(istrue(self.gasmaskequipped) || istrue(self.gasmaskswapinprogress) && !istrue(self.gasmaskequipped)) {
    namespace_d3f3cf99d75d3345::toggle_gasmask("off");

    if(isDefined(level.var_c57ee1e174e42601)) {
      self[[level.var_c57ee1e174e42601]]("chemist_gas");
      return;
    }

    self notify("toggle_gasmask");
  }
}

function private function_ee2770a2fe71d2(params) {
  self.var_b426e3a6879aa708 = 1;
}