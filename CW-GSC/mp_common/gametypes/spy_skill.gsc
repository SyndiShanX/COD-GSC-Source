/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\spy_skill.gsc
***********************************************/

#using script_6b4984dd2d3d3eea;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\globallogic\globallogic_audio;
#using scripts\core_common\math_shared;
#using scripts\core_common\perks;
#using scripts\core_common\potm_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreak_dialog;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\gametypes\spy;
#namespace spy_skill;

function private autoexec __init__system__() {
  system::register(#"spy_skill", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register("allplayers", "victim_entity_num", 28000, 5, "int");
  clientfield::register("toplayer", "corpse_entity_num", 28000, 5, "int");
  clientfield::register("allplayers", "footsteps_victim_entity_num", 28000, 5, "int");
}

function function_d999c676() {
  return # "hash_7845745ea9a615cd";
}

function function_30e98aee() {
  if(!isDefined(level.var_21bbed05)) {
    level.var_21bbed05 = getscriptbundlelist(#"hash_42b2451caf60eb9f");
  }

  level.var_1c6fe905 = [];

  foreach(index, bundle_name in level.var_21bbed05) {
    var_748b77e9 = getscriptbundle(bundle_name);
    var_df565943 = spawnStruct();
    var_df565943.var_256f0fd3 = isDefined(var_748b77e9.var_256f0fd3) ? var_748b77e9.var_256f0fd3 : 0;
    var_df565943.var_17e8c06b = isDefined(var_748b77e9.var_17e8c06b) ? var_748b77e9.var_17e8c06b : "";
    var_df565943.var_3ae94a37 = isDefined(var_748b77e9.var_3ae94a37) ? var_748b77e9.var_3ae94a37 : 0;

    if(isstring(var_748b77e9.var_d8ed7f46) && var_748b77e9.var_d8ed7f46 != "") {
      var_df565943.var_d8ed7f46 = function_8764fdff(var_748b77e9.var_d8ed7f46, 3, var_df565943.var_256f0fd3, var_df565943.var_3ae94a37, var_df565943.var_17e8c06b);
    }

    var_df565943.var_c95c96b3 = isDefined(var_748b77e9.var_c95c96b3) ? var_748b77e9.var_c95c96b3 : 0;

    if(isstring(var_748b77e9.var_2d627fdd) && var_748b77e9.var_2d627fdd != "") {
      var_df565943.var_2d627fdd = function_8764fdff(var_748b77e9.var_2d627fdd, 1, var_df565943.var_256f0fd3, var_df565943.var_c95c96b3, var_df565943.var_17e8c06b);
    }

    level.var_1c6fe905[index] = var_df565943;
  }

  level.var_bea0fcef = [];
  level.var_9ed97ddc = [];
  level.var_22297c6 = [];
  level.var_f43b14f7 = [];
  level.var_762a9eb6 = [];
  level.var_36f90a41 = [];
  level.var_65977c6 = 1;
  events = getscriptbundle(#"hash_46763a2cc09c6164");
  events.var_eafdfcd2 = isDefined(events.var_eafdfcd2) ? events.var_eafdfcd2 : 0;
  events.var_5114afc5 = isDefined(events.var_5114afc5) ? events.var_5114afc5 : 0;
  events.var_ed9f408b = isDefined(events.var_ed9f408b) ? events.var_ed9f408b : 0;
  events.var_6f25263a = isDefined(events.var_6f25263a) ? events.var_6f25263a : 0;
  events.var_57b43928 = isDefined(events.var_57b43928) ? events.var_57b43928 : 0;
  events.var_5c975fda = isDefined(events.var_5c975fda) ? events.var_5c975fda : 0;
  events.var_c77b4162 = isDefined(events.var_c77b4162) ? events.var_c77b4162 : 0;
  events.var_6cc03c67 = isDefined(events.var_6cc03c67) ? events.var_6cc03c67 : 0;
  events.var_133ba5a7 = isDefined(events.var_133ba5a7) ? events.var_133ba5a7 : 0;
  events.var_5da13983 = isDefined(events.var_5da13983) ? events.var_5da13983 : 0;
  level.var_7e569431 = events;

  if(spy::function_3d83e588(1)) {
    function_c329fcd3(#"combat_bow", undefined, undefined, undefined, undefined, undefined, undefined, &function_9deb70f);
    function_c329fcd3(#"attack_helicopter", undefined, undefined, undefined, undefined, undefined, undefined, &function_9deb70f);
    function_c329fcd3(#"hash_3cda454c67af897f", undefined, undefined, undefined, undefined, undefined, undefined, &function_9deb70f);
    function_c329fcd3(#"tear_gas", undefined, undefined, undefined, undefined, undefined, undefined, &function_9deb70f);
  }

  if(spy::function_3d83e588(3)) {
    function_c329fcd3(#"spy_med_pack", undefined, undefined, undefined, undefined, undefined, undefined, &function_9deb70f);
    function_c329fcd3(#"spy_wanted_order", undefined, undefined, undefined, undefined, undefined, undefined, &function_9deb70f, &function_c416ba8f);
    function_c329fcd3(#"hand_cannon", undefined, undefined, undefined, undefined, undefined, undefined, &function_9deb70f);
    function_c329fcd3(#"trophy_system", undefined, undefined, undefined, undefined, undefined, undefined, &function_9deb70f);
    function_aafab535(#"spy_wanted_order", &function_94858bde);
  }

  level thread init_devgui();
}

function private function_8764fdff(var_952fc2b4, role, var_229cbfe0, var_8bf10510, var_6cf359b7) {
  var_6669664 = getscriptbundle(var_952fc2b4);
  assert(isDefined(var_6669664));
  skill = spawnStruct();
  skill.role = role;
  skill.var_ada67e63 = isDefined(var_6669664.var_a99abf33) ? var_6669664.var_a99abf33 : "";
  skill.id = isDefined(var_6669664.var_e1bfe02c) ? var_6669664.var_e1bfe02c : 0;
  skill.credit = var_8bf10510;
  skill.var_df565943 = var_229cbfe0;
  skill.cooldown = isDefined(var_6669664.cooldown) ? var_6669664.cooldown : 0;
  skill.var_3e32dc53 = isDefined(var_6669664.var_a58f84b8) ? var_6669664.var_a58f84b8 : 0;
  skill.var_501386ad = isDefined(var_6669664.casttime) ? var_6669664.casttime : 0;
  skill.var_2f423d19 = isDefined(var_6669664.var_65bbf236) ? var_6669664.var_65bbf236 : "";
  skill.var_b33aa4ce = isDefined(var_6669664.var_aefe2d36) ? var_6669664.var_aefe2d36 : "";
  skill.var_29abb77f = isDefined(var_6669664.var_14c09096) ? var_6669664.var_14c09096 : "";
  skill.var_6b0570b = isDefined(var_6669664.var_e5aec172) ? var_6669664.var_e5aec172 : "";
  skill.var_b1a0bb67 = isDefined(var_6669664.var_9a31299) ? var_6669664.var_9a31299 : "";
  skill.var_2c445a1c = isDefined(var_6669664.var_3367532b) ? var_6669664.var_3367532b : 0;
  skill.var_79cb1fe2 = isDefined(var_6669664.var_3fcd829a) ? var_6669664.var_3fcd829a : 0;
  skill.var_5fcde6a8 = var_6cf359b7;
  customparams = isDefined(var_6669664.customparams) ? var_6669664.customparams : "";

  if(customparams != "") {
    skill.params = strtok(customparams, "|");
  }

  perks = isDefined(var_6669664.perks) ? var_6669664.perks : "";

  if(perks != "") {
    skill.perks = strtok(perks, "|");
  }

  if(isstring(var_6669664.scorestreak)) {
    skill.scorestreak = getscriptbundle(var_6669664.scorestreak);

    if(isDefined(skill.scorestreak.kstype)) {
      killstreaks::function_94c74046(skill.scorestreak.kstype);
    }
  }

  skill.weapon = var_6669664.weapon;
  println("<dev string:x38>" + role + "<dev string:x5b>" + skill.var_ada67e63);
  function_204a5e6d(skill.role, skill, skill.var_ada67e63);
  return skill;
}

function precache() {}

function function_204a5e6d(role, skill, var_ada67e63) {
  if(!isDefined(level.var_7f624f77[role])) {
    level.var_7f624f77[role] = [];
  }

  level.var_7f624f77[role][var_ada67e63] = skill;
}

function function_c329fcd3(var_ada67e63, usefunc, canusefunc, var_baaeed8f, var_b7343bb8, var_5620738, var_27fef6bc, var_8a2e2eba, var_f9ecd84a) {
  level.var_bea0fcef[var_ada67e63] = usefunc;
  level.var_9ed97ddc[var_ada67e63] = canusefunc;
  level.var_22297c6[var_ada67e63] = var_baaeed8f;
  level.var_f43b14f7[var_ada67e63] = var_b7343bb8;
  level.var_762a9eb6[var_ada67e63] = var_5620738;
  level.var_36f90a41[var_ada67e63] = var_27fef6bc;
  level.var_fb8d16fa[var_ada67e63] = var_8a2e2eba;
  level.var_40683d3d[var_ada67e63] = var_f9ecd84a;
}

function function_d5cebde0(var_ada67e63) {
  player = self;

  if(!isDefined(player)) {
    return false;
  }

  role = player spy::function_da8679c7();

  if(!isDefined(role) || !isDefined(level.var_7f624f77[role]) || !level.var_7f624f77[role].size) {
    return false;
  }

  if(isDefined(var_ada67e63) && (var_ada67e63 == "" || !isDefined(level.var_7f624f77[role][var_ada67e63]))) {
    return false;
  }

  return true;
}

function function_cb6ba828(role, var_ada67e63) {
  assert(isDefined(level.var_7f624f77));

  if(isDefined(level.var_7f624f77[role]) && isDefined(level.var_7f624f77[role][var_ada67e63])) {
    return level.var_7f624f77[role][var_ada67e63];
  }
}

function function_8da4c80d() {
  level endon(#"game_ended");
  self endon(#"disconnect");
  self endon(#"death");
  player = self;
  level flag::wait_till("spy_role_assigned");

  if(!spy::function_3d83e588(player.spyRole)) {
    return;
  }

  println("<dev string:x6d>" + player.name + "<dev string:x7d>");

  if(!isDefined(player) || isbot(player) || !player function_d5cebde0()) {
    return;
  }

  player function_c59f835();
  player childthread function_6a08066c();
  player childthread function_95f4f685();
  player childthread function_cd5f950();
  player childthread function_b3dbed86();
}

function function_6a08066c() {
  player = self;

  if(!isDefined(player) || !isPlayer(player) || isbot(player)) {
    return;
  }

  if(spy::function_701a9d44(player, 2)) {
    return;
  }

  role = player spy::function_da8679c7();

  if(isDefined(level.var_7f624f77) && isDefined(level.var_7f624f77[role])) {
    foreach(var_ada67e63, skill in level.var_7f624f77[role]) {
      scorestreak = skill.scorestreak;

      if(isDefined(scorestreak)) {
        slot = function_5648ed56(skill.var_5fcde6a8);

        if(isDefined(slot)) {
          player function_2c334e8f(slot, 1);
        }
      }
    }
  }

  util::wait_network_frame(1);

  if(!isDefined(player)) {
    return;
  }

  role = player spy::function_da8679c7();

  if(isDefined(level.var_7f624f77) && isDefined(level.var_7f624f77[role])) {
    foreach(skill in level.var_7f624f77[role]) {
      scorestreak = skill.scorestreak;

      if(isDefined(scorestreak)) {
        slot = function_5648ed56(skill.var_5fcde6a8);

        if(isDefined(slot)) {
          player function_2c334e8f(slot, 0);
          player killstreaks::function_b3185041(slot, int(0));
          player killstreaks::function_a831f92c(slot, int(0), 1);
        }
      }
    }
  }
}

function function_c59f835(skill) {
  if(isDefined(self.killstreak) && self.killstreak.size > 0) {
    return;
  }

  role = self spy::function_da8679c7();
  self.killstreak = [];

  if(isDefined(level.var_7f624f77) && isDefined(level.var_7f624f77[role])) {
    foreach(skill in level.var_7f624f77[role]) {
      scorestreak = skill.scorestreak;

      if(isDefined(scorestreak)) {
        weapon = killstreaks::get_killstreak_weapon(scorestreak.kstype);
        slot = function_5648ed56(skill.var_5fcde6a8);

        if(isDefined(slot)) {
          self setkillstreakweapon(slot, weapon);
          self.killstreak[slot] = weapon.rootweapon.name;
          println("<dev string:xb6>" + self.name + "<dev string:xc6>" + scorestreak.kstype);
        } else {
          println("<dev string:x6d>" + self.name + "<dev string:xdb>" + scorestreak.kstype);
        }
      }

      weapon = skill.weapon;

      if(isDefined(weapon)) {
        if(weapon.offhandslot == "Special" && weapon.inventorytype == "ability") {
          self giveweapon(weapon);
          self setweaponammoclip(weapon, 0);
          println("<dev string:xb6>" + self.name + "<dev string:x104>" + skill.var_ada67e63);
        } else {
          println("<dev string:x6d>" + skill.var_ada67e63 + "<dev string:x11b>" + self.name);
        }
      }

      if(!isDefined(scorestreak) && !isDefined(weapon)) {
        println("<dev string:x6d>" + self.name + "<dev string:x152>" + skill.var_ada67e63);
      }
    }
  }
}

function function_5648ed56(var_41d6bb00) {
  if(isstring(var_41d6bb00)) {
    switch (var_41d6bb00) {
      case # "+actionslot 1":
        return 0;
      case # "+actionslot 2":
        return 1;
      case # "+actionslot 3":
        return 2;
      case # "+actionslot 4":
        return 3;
    }
  }

  return undefined;
}

function function_45d8c5d5(var_ada67e63) {
  player = self;

  if(!isDefined(player)) {
    return;
  }

  level endon(#"game_ended");
  player endon(#"disconnect");
  player endon(#"death");

  if(!player function_d5cebde0(var_ada67e63)) {
    return;
  }

  role = player spy::function_da8679c7();
  assert(isDefined(role));
  skill = function_cb6ba828(role, var_ada67e63);
  assert(isDefined(skill));

  while(true) {
    player waittill(#"credit_changed");

    if(player.credit >= skill.credit) {
      player function_ca32358b(role, var_ada67e63);
      break;
    }
  }
}

function function_95f4f685() {
  player = self;

  if(!isDefined(player)) {
    return;
  }

  level endon(#"game_ended");
  player endon(#"disconnect");
  player endon(#"death");
  self notify("3373176b2af2aaba");
  self endon("3373176b2af2aaba");

  while(true) {
    waitresult = player waittill(#"hash_757d0a71400e1713");
    var_d65c6028 = "";

    if(isDefined(waitresult.name)) {
      var_d65c6028 = waitresult.name;
    }

    if(!isDefined(player)) {
      break;
    }

    if(!isDefined(var_d65c6028) || !player function_d5cebde0(var_d65c6028)) {
      continue;
    }

    role = player spy::function_da8679c7();
    assert(isDefined(role));
    skill = function_cb6ba828(role, var_d65c6028);
    assert(isDefined(skill));

    if(isDefined(level.var_f43b14f7[var_d65c6028])) {
      self thread[[level.var_f43b14f7[var_d65c6028]]](skill);
    }

    if(skill.var_29abb77f != "") {
      player playSound(skill.var_29abb77f);
    }
  }
}

function function_cd5f950() {
  player = self;

  if(!isDefined(player)) {
    return;
  }

  self notify("634ae4691992eb27");
  self endon("634ae4691992eb27");
  level endon(#"game_ended");
  player endon(#"disconnect");
  player endon(#"death");

  while(true) {
    waitresult = player waittill(#"hash_31c68c2381d76ec4");
    var_d65c6028 = "";

    if(isDefined(waitresult.name)) {
      var_d65c6028 = waitresult.name;
    }

    if(!isDefined(player)) {
      break;
    }

    if(!isDefined(var_d65c6028) || !player function_d5cebde0(var_d65c6028)) {
      continue;
    }

    role = player spy::function_da8679c7();
    assert(isDefined(role));
    skill = function_cb6ba828(role, var_d65c6028);
    assert(isDefined(skill));

    if(isDefined(level.var_762a9eb6[var_d65c6028])) {
      self thread[[level.var_762a9eb6[var_d65c6028]]](skill);
    }

    if(skill.var_60f75e16 != "") {
      player playSound(skill.var_60f75e16);
    }
  }
}

function function_866080d3(skill) {
  player = self;
  var_ada67e63 = skill.var_ada67e63;

  if(isDefined(skill.scorestreak)) {
    notify_name = "killstreak_done";

    if(isDefined(level.var_40683d3d[var_ada67e63])) {
      player thread[[level.var_40683d3d[var_ada67e63]]]();
    }
  } else {
    notify_name = "" + # "use_skill_" + var_ada67e63;
    player notifyonplayercommand(notify_name, skill.var_5fcde6a8);
  }

  if(!isDefined(player) || !isDefined(notify_name) || notify_name == "") {
    return;
  }

  level endon(#"game_ended");
  player endon(#"disconnect");
  player endon(#"death");

  if(!player function_d5cebde0(var_ada67e63)) {
    return;
  }

  var_17b7891d = "36db09d0249b8cb9" + "end_use_skill_" + var_ada67e63;
  self notify(var_17b7891d);
  self endon(var_17b7891d);
  role = player spy::function_da8679c7();
  assert(isDefined(role));

  while(true) {
    result = player waittill(notify_name);

    if(!isDefined(player)) {
      return;
    }

    if(isDefined(skill.scorestreak)) {
      if(!result.is_successful) {
        continue;
      }

      if(!isDefined(result.kstype) || result.kstype != skill.scorestreak.kstype) {
        continue;
      }
    }

    if(is_true(player.var_b5fc63cb[var_ada67e63]) || player arecontrolsfrozen()) {
      continue;
    }

    if(is_true(player.var_706748ec)) {
      continue;
    }

    success = player function_ca32358b(role, var_ada67e63);

    if(is_true(success)) {
      if(isDefined(level.var_ed3ea60a[var_ada67e63])) {
        self thread[[level.var_ed3ea60a[var_ada67e63]]]();
      }

      player function_ec01c4ec(hash(var_ada67e63));
    } else {
      continue;
    }

    if(!isalive(player)) {
      return;
    }

    player childthread function_6f5821f0(role, var_ada67e63);
    player thread function_226d4395(role, var_ada67e63);
  }
}

function function_6f5821f0(role, var_ada67e63) {
  player = self;
  level endon(#"game_ended");
  skill = function_cb6ba828(role, var_ada67e63);
  assert(isDefined(skill));

  if(!isDefined(skill)) {
    return;
  }

  if(skill.var_3e32dc53 <= 0) {
    return;
  }

  player waittilltimeout(skill.var_3e32dc53, #"death", #"disconnect");

  if(isDefined(player)) {
    player notify(function_d999c676() + var_ada67e63);
    skill = function_cb6ba828(player spy::function_da8679c7(), var_ada67e63);
  }
}

function function_226d4395(role, var_ada67e63) {
  player = self;
  level endon(#"game_ended");
  player endon(#"disconnect");
  player endon(#"death");
  player notify("wait_skill_" + var_ada67e63);
  player endon("wait_skill_" + var_ada67e63);
  skill = function_cb6ba828(role, var_ada67e63);
  assert(isDefined(skill));

  if(!isDefined(skill)) {
    return;
  }

  if(skill.cooldown <= 0) {
    return;
  }

  if(var_ada67e63 == "awp") {
    waitresult = player waittill(#"hash_bd3f663437feb44", #"cooldown_stop_awp");

    if(waitresult._notify == "cooldown_stop_awp") {
      return;
    }
  }

  if(var_ada67e63 == "teleporter" && is_true(player.var_c7f46ab0)) {
    return;
  }

  skill = function_cb6ba828(player spy::function_da8679c7(), var_ada67e63);

  if(!isDefined(skill.cooldown) || !isDefined(skill.scorestreak) || skill.cooldown <= 0) {
    if(isDefined(skill.weapon) && skill.weapon.offhandslot == "Special" && skill.weapon.inventorytype == "ability") {
      if(isDefined(skill.cooldown)) {
        self thread function_71b294d4(role, var_ada67e63);
      }

      return;
    }

    if(isDefined(level.var_fb8d16fa[var_ada67e63])) {
      self thread[[level.var_fb8d16fa[var_ada67e63]]](skill);
    }

    return;
  }

  slot = player function_5648ed56(skill.var_5fcde6a8);
  player.var_b5fc63cb[var_ada67e63] = 1;
  start_time = gettime();
  end_time = start_time + int(skill.var_3e32dc53 * 1000);
  player killstreaks::function_b3185041(slot, int(end_time));
  player killstreaks::function_a831f92c(slot, int(skill.var_3e32dc53), 0);
  wait skill.var_3e32dc53;
  duration = skill.cooldown - skill.var_3e32dc53;
  player killstreaks::function_b3185041(slot, int(gettime() + int(duration * 1000)));
  player killstreaks::function_a831f92c(slot, int(duration), 1);
  wait duration;

  if(isDefined(player)) {
    cost = player function_dceb5542(level.killstreaks[skill.scorestreak.kstype].itemindex);
    player function_2c334e8f(slot, int(cost));
    player killstreaks::function_b3185041(slot, int(0));
    player killstreaks::function_a831f92c(slot, int(0), 1);
    player.var_b5fc63cb[var_ada67e63] = 0;

    if(isDefined(level.var_fb8d16fa[var_ada67e63])) {
      self thread[[level.var_fb8d16fa[var_ada67e63]]](skill);
    }
  }
}

function private function_71b294d4(role, var_ada67e63) {
  level endon(#"game_ended");
  self endon(#"disconnect");
  self endon(#"death");

  if(var_ada67e63 == "tear_gas") {
    self waittill(#"hash_228d061be1b2a83a");
  } else if(var_ada67e63 == "trophy_system") {
    self waittill(#"hash_50994ef63f120738");
  }

  self clientfield::set_player_uimodel("hudItems.ammoCooldowns.fieldUpgrade", 0);
  skill = function_cb6ba828(role, var_ada67e63);
  wait skill.var_3e32dc53;
  duration = skill.cooldown - skill.var_3e32dc53;
  var_8d623945 = 0;
  starttime = float(gettime()) / 1000;

  while(var_8d623945 <= 1) {
    currtime = float(gettime()) / 1000;
    deltatime = currtime - starttime;
    var_8d623945 = deltatime / duration;
    self clientfield::set_player_uimodel("hudItems.ammoCooldowns.fieldUpgrade", var_8d623945);
    waitframe(1);
  }

  self.var_b5fc63cb[var_ada67e63] = 0;

  if(isDefined(level.var_fb8d16fa[var_ada67e63])) {
    self thread[[level.var_fb8d16fa[var_ada67e63]]](skill);
  }
}

function function_ca32358b(role, var_ada67e63) {
  player = self;

  if(!isDefined(player)) {
    return false;
  }

  level endon(#"game_ended");
  player endon(#"disconnect");
  player endon(#"death");

  if(!isDefined(role)) {
    role = player spy::function_da8679c7();

    if(!isDefined(role)) {
      assert(isDefined(role));
      return false;
    }
  }

  skill = function_cb6ba828(role, var_ada67e63);

  if(!isDefined(skill)) {
    assert(isDefined(skill));
    return false;
  }

  if(isDefined(level.var_9ed97ddc[var_ada67e63]) && !is_true([[level.var_9ed97ddc[var_ada67e63]]](skill.params))) {
    if(skill.var_b1a0bb67 != "") {
      player playSound(skill.var_b1a0bb67);
    }

    return false;
  }

  var_a2885ced = 1;

  if(skill.var_501386ad > 0) {
    var_a2885ced = player function_33e8c664(var_ada67e63, skill);
  }

  if(!var_a2885ced) {
    player notify(#"hash_31c68c2381d76ec4", var_ada67e63);
    return false;
  }

  if(isDefined(level.var_bea0fcef[var_ada67e63])) {
    self thread[[level.var_bea0fcef[var_ada67e63]]](skill);
  }

  if(isDefined(level.var_36f90a41[var_ada67e63])) {
    var_77fe8da5 = player[[level.var_36f90a41[var_ada67e63]]]();
  } else {
    var_77fe8da5 = 1;
  }

  if(is_true(var_77fe8da5)) {
    soundname = skill.var_2f423d19;
  } else {
    soundname = skill.var_b33aa4ce;
  }

  if(soundname != "") {
    player playSound(soundname);
  }

  if(is_true(var_77fe8da5) && isDefined(skill.perks)) {
    player thread giveperks(skill.perks, var_ada67e63);
  }

  return true;
}

function function_33e8c664(var_ada67e63, skill) {
  player = self;

  if(!isDefined(player)) {
    return 0;
  }

  level endon(#"game_ended");
  player endon(#"disconnect");
  player endon(#"death");
  player notify(#"hash_757d0a71400e1713", {
    #name: var_ada67e63
  });

  if(!isDefined(var_ada67e63)) {
    return 0;
  }

  start_time = gettime();
  var_a2885ced = 1;

  if(!is_true(level.var_bc836645)) {
    waitresult = player waittilltimeout(skill.var_501386ad, #"cast_break");

    if(waitresult._notify == "cast_break") {
      var_a2885ced = 0;
    }
  } else {
    var_a2885ced = player function_b281b5ca(skill);
  }

  if(var_a2885ced) {}

  return var_a2885ced;
}

function function_b281b5ca(skill) {
  player = self;
  level endon(#"game_ended");
  player endon(#"disconnect");

  if(!isDefined(player.var_3ae9291a)) {}

  lastrate = -1;
  start_time = gettime();
  use_time = skill.var_501386ad * 1000;
  end_time = start_time + use_time;
  succeed = 1;

  while(isalive(player)) {
    if(lastrate >= 1) {
      break;
    }

    if(skill.var_79cb1fe2 && is_true(player.var_59dcdc20)) {
      succeed = 0;
      break;
    }

    rate = (gettime() - start_time) * 1 / use_time;

    if(rate < 0) {
      rate = 0;
    } else if(rate > 1) {
      rate = 1;
    }

    lastrate = rate;
    waitframe(1);
  }

  if(isDefined(player) && isDefined(player.var_3ae9291a)) {}

  return succeed;
}

function function_c356752a() {
  level endon(#"game_ended");
  player = self;

  if(!isDefined(player) || !isDefined(player.var_3ae9291a)) {
    return;
  }

  player util::waittill_multiple("disconnect", "death");

  if(isDefined(player) && isDefined(player.var_3ae9291a)) {
    player.var_3ae9291a = undefined;
  }
}

function function_632622b6(var_ada67e63) {
  player = self;

  if(isDefined(level.var_22297c6[var_ada67e63])) {
    var_4b0f78f6 = player[[level.var_22297c6[var_ada67e63]]]();
    player show_hint(var_4b0f78f6, 1);
  }
}

function show_hint(var_4b0f78f6, duration) {}

function giveperks(perks, var_ada67e63) {
  level endon(#"game_ended");
  self endon(#"disconnect");
  self endon(#"death");
  player = self;
  valid_perks = [];

  foreach(perk in perks) {
    player perks::perk_setperk(perk);
    valid_perks[valid_perks.size] = perk;
  }

  player waittill(function_d999c676() + var_ada67e63);

  foreach(perk in valid_perks) {
    player perks::perk_unsetperk(perk);
  }
}

function function_b3dbed86() {
  level endon(#"game_ended");
  self endon(#"disconnect");
  self endon(#"death");
  self notify("2c276a3c5dfe7b3e");
  self endon("2c276a3c5dfe7b3e");
  player = self;

  if(!isDefined(player.var_df565943)) {
    player.var_df565943 = 0;
  }

  while(true) {
    player waittill(#"credit_changed");

    if(!isDefined(player)) {
      return;
    }

    if(player.var_df565943 >= 4) {
      break;
    }

    while(true) {
      role = player spy::function_da8679c7();

      if(role == 3) {
        var_fd4bfb0e = level.var_1c6fe905[player.var_df565943 + 1].var_3ae94a37;
        var_7a4fec0b = level.var_1c6fe905[player.var_df565943 + 1].var_d8ed7f46;
      } else {
        var_fd4bfb0e = level.var_1c6fe905[player.var_df565943 + 1].var_c95c96b3;
        var_7a4fec0b = level.var_1c6fe905[player.var_df565943 + 1].var_2d627fdd;
      }

      if(isDefined(var_7a4fec0b.scorestreak) && !spy::function_3d83e588(role)) {
        break;
      }

      if(!isDefined(var_fd4bfb0e) || var_fd4bfb0e <= 0) {
        break;
      }

      if(player.credit >= var_fd4bfb0e) {
        player.var_df565943++;

        if(isDefined(var_7a4fec0b)) {
          function_ea44a840(var_7a4fec0b);
          waitframe(1);
        }

        continue;
      }

      break;
    }
  }
}

function function_ed728a5d() {
  player = self;
  role = player spy::function_da8679c7();

  if(isDefined(level.var_7f624f77) && isDefined(level.var_7f624f77[role])) {
    foreach(skill in level.var_7f624f77[role]) {
      if(skill.var_2c445a1c) {
        player function_ea44a840(skill);
      }
    }
  }
}

function function_ea44a840(skill) {
  assert(isPlayer(self));
  self function_35dcdbf0(skill.var_ada67e63);
  self.var_dff29d6[skill.var_df565943] = skill.var_ada67e63;

  if(isDefined(skill.scorestreak)) {
    weapon = killstreaks::get_killstreak_weapon(skill.scorestreak.kstype);
    self giveweapon(weapon);

    if(!weapon.iscarriedkillstreak) {
      self.pers[#"killstreak_quantity"][weapon] = 1;
    }

    self setweaponammoclip(weapon, weapon.clipsize);
    self function_d724b608(skill);
  }

  if(isDefined(skill.weapon)) {
    if(!self hasweapon(skill.weapon)) {
      self giveweapon(skill.weapon);
    }

    self setweaponammoclip(skill.weapon, 1);

    if(skill.weapon.offhandslot == "Special" && skill.weapon.inventorytype == "ability") {
      self clientfield::set_player_uimodel("hudItems.ammoCooldowns.fieldUpgrade", 1);
      self function_c82e22aa(skill);
    }
  }

}

function function_d724b608(skill) {
  if(game.state != # "playing") {
    return;
  }

  self thread killstreak_dialog::play_killstreak_ready_dialog(skill.scorestreak.kstype);

  if(isDefined(skill.scorestreak.var_c08f7089)) {
    self playsoundtoplayer(skill.scorestreak.var_c08f7089, self);
  } else {
    self playsoundtoplayer("uin_kls_generic", self);
  }

  if(isDefined(level.killstreakindices[skill.scorestreak.kstype])) {
    var_f4cc972d = function_5648ed56(skill.var_5fcde6a8);
    self luinotifyevent(#"killstreak_received", 4, level.killstreakindices[skill.scorestreak.kstype], "", 0, var_f4cc972d);
    self function_8ba40d2f(#"killstreak_received", 3, level.killstreakindices[skill.scorestreak.kstype], "", 0);
    self function_6bf621ea(#"hash_6a9cb800ad0ef395", 2, self getentitynumber(), var_f4cc972d);
  }
}

function function_c82e22aa(skill) {
  if(game.state != # "playing") {
    return;
  }

  weaponindex = getitemindexfromref(skill.weapon.name);
  self luinotifyevent(#"hash_14ebcb39234f4126", 1, weaponindex);
  self function_6bf621ea(#"hash_14ebcb39234f4126", 2, self getentitynumber(), weaponindex);
  self playsoundtoplayer(#"hash_55f9d99ffab775e1", self);
}

function function_35dcdbf0(var_ada67e63) {
  player = self;

  if(!isDefined(player) || isbot(player)) {
    return;
  }

  role = player spy::function_da8679c7();
  skill = function_cb6ba828(role, var_ada67e63);

  if(!isDefined(skill)) {
    return;
  }

  if(skill.var_2c445a1c && player function_d5cebde0(var_ada67e63)) {
    player function_ca32358b(role, var_ada67e63);
    return;
  }

  if(skill.var_5fcde6a8 != "") {
    player thread function_866080d3(skill);
    return;
  }

  player thread function_45d8c5d5(var_ada67e63);
}

function function_eba95887(credit) {
  assert(isPlayer(self));
  credit = int(math::clamp(isDefined(credit) ? credit : 0, 0, 100));
  self.credit = credit;
  self notify(#"credit_changed");

  if(getdvarint(#"hash_628a73b6809e0598", 0) > 0) {
    iprintln(self.playername + "<dev string:x18d>" + self.credit);
  }

  role = self spy::function_da8679c7();

  if(isDefined(level.var_7f624f77) && isDefined(level.var_7f624f77[role])) {
    foreach(var_a99abf33, skill in level.var_7f624f77[role]) {
      if(isDefined(skill.scorestreak)) {
        self function_395f82d0(var_a99abf33);
      }
    }
  }
}

function function_53a81144(credit) {
  assert(isPlayer(self));
  assert(isint(self.credit));
  credit = int(isDefined(credit) ? credit : 0);

  if(credit == 0) {
    return;
  }

  var_52fe6461 = self.credit;
  self function_eba95887(credit + var_52fe6461);
}

function function_f77996e9(attacker, victim) {
  if(!isDefined(victim)) {
    return;
  }

  var_5ed12177 = victim spy::function_da8679c7();

  if(var_5ed12177 == 2 && (!isDefined(attacker) || attacker spy::function_da8679c7() != 1)) {
    return;
  }

  foreach(player in function_a1ef346b()) {
    var_e389c624 = player spy::function_da8679c7();

    if(var_e389c624 == 2) {
      if(var_5ed12177 == 1) {
        if(player == attacker) {
          potm::bookmark(#"hash_4781443e5cb38974", gettime(), attacker);
        }
      }

      continue;
    }

    reward = 0;

    if(var_e389c624 == 3) {
      if(var_5ed12177 == 1) {
        if(player == attacker) {
          potm::bookmark(#"hash_4781443e5cb38974", gettime(), attacker);
          reward = level.var_7e569431.var_ed9f408b;
          reward += level.var_7e569431.var_5c975fda;
        } else {
          reward = level.var_7e569431.var_5c975fda;
        }
      }
    } else if(var_5ed12177 == 1) {
      reward = level.var_7e569431.var_57b43928;
    } else if(player == attacker) {
      if(var_5ed12177 == 3) {
        reward = level.var_7e569431.var_eafdfcd2;
        potm::bookmark(#"hash_91ca92038ff4712", gettime(), attacker);
      } else {
        reward = level.var_7e569431.var_5114afc5;
        potm::bookmark(#"hash_3412b13233ce0bf0", gettime(), attacker);
      }
    }

    player function_53a81144(reward);
  }
}

function function_395f82d0(var_ada67e63) {
  if(isbot(self)) {
    return;
  }

  skill = function_cb6ba828(self spy::function_da8679c7(), var_ada67e63);

  if(isDefined(skill.credit) && isDefined(skill.scorestreak) && skill.credit > 0 && skill.credit >= self.credit) {
    progress = self.credit / skill.credit;
    slot = function_5648ed56(skill.var_5fcde6a8);
    cost = self function_dceb5542(level.killstreaks[skill.scorestreak.kstype].itemindex);
    self function_2c334e8f(slot, int(cost * progress));
  }
}

function function_9e75b1a6() {
  level endon(#"game_ended");

  while(true) {
    wait 60;

    foreach(player in function_a1ef346b()) {
      role = player spy::function_da8679c7();

      if(role == 3) {
        player function_53a81144(level.var_7e569431.var_5da13983);
        continue;
      }

      if(role == 1) {
        player function_53a81144(level.var_7e569431.var_6cc03c67);
      }
    }
  }
}

function function_9deb70f(skill) {
  if(isDefined(skill.scorestreak)) {
    weapon = killstreaks::get_killstreak_weapon(skill.scorestreak.kstype);

    if(!self hasweapon(weapon)) {
      self giveweapon(weapon);
    }

    self killstreaks::change_killstreak_quantity(weapon, 1);
    self setweaponammoclip(weapon, weapon.clipsize);
    self function_d724b608(skill);
  }

  if(isDefined(skill.weapon)) {
    if(!self hasweapon(skill.weapon)) {
      self giveweapon(skill.weapon);
    }

    self setweaponammoclip(skill.weapon, 1);

    if(skill.weapon.offhandslot == "Special" && skill.weapon.inventorytype == "ability") {
      self function_c82e22aa(skill);
    }
  }
}

function notifyonplayercommand(command, key) {
  assert(isPlayer(self));
  self thread function_255e9614(command, key);
}

function notifyonplayercommandremove(command, key) {
  self notify(command + "_" + key);
}

function function_255e9614(command, key) {
  self endon(#"disconnect");
  level endon(#"game_ended");
  var_17b7891d = "1e11d940d946c63d" + command + "_" + key;
  self notify(var_17b7891d);
  self endon(var_17b7891d);

  switch (key) {
    case # "+weapoffhandspecial":
      function_9024fce3(&offhandspecialbuttonpressed, command);
      break;
    case # "+actionslot 1":
      function_9024fce3(&actionslotonebuttonpressed, command);
      break;
    case # "+actionslot 2":
      function_9024fce3(&actionslottwobuttonpressed, command);
      break;
    case # "+actionslot 3":
      function_9024fce3(&actionslotthreebuttonpressed, command);
      break;
    case # "+actionslot 4":
      function_9024fce3(&actionslotfourbuttonpressed, command);
      break;
    case # "-actionslot 1":
      function_21e5a72f(&actionslotonebuttonpressed, command);
      break;
    case # "-actionslot 2":
      function_21e5a72f(&actionslottwobuttonpressed, command);
      break;
    case # "-actionslot 3":
      function_21e5a72f(&actionslotthreebuttonpressed, command);
      break;
    case # "-actionslot 4":
      function_21e5a72f(&actionslotfourbuttonpressed, command);
      break;
  }
}

function function_9024fce3(buttonfunc, command) {
  while(true) {
    while(!self[[buttonfunc]]()) {
      waitframe(1);
    }

    self notify(command);

    while(self[[buttonfunc]]()) {
      waitframe(1);
    }
  }
}

function function_21e5a72f(buttonfunc, command) {
  while(true) {
    while(!self[[buttonfunc]]()) {
      waitframe(1);
    }

    while(self[[buttonfunc]]()) {
      waitframe(1);
    }

    self notify(command);
  }
}

function private function_ba6c41e5() {
  player = self;

  if(!isDefined(player) || !isPlayer(player)) {
    return;
  }

  player endon(#"disconnect", #"death");
  level endon(#"game_ended");
  result = player waittill(#"medpack_placed", #"hash_aa96693d26dccbe");

  if(result._notify === "medpack_placed") {
    if(isDefined(result.medpack)) {
      level thread function_be16c1f7(result.medpack);
    }
  }
}

function private function_be16c1f7(medpack) {
  if(!isDefined(medpack)) {
    return;
  }

  medpack endon(#"hash_5f25f60b7159ac0f");
  skill = function_cb6ba828(3, "spy_med_pack");
  timeremaining = skill.var_3e32dc53;
  starttime = float(gettime()) / 1000;
  endtime = starttime + timeremaining;

  while(timeremaining > 0) {
    wait float(function_60d95f53()) / 1000;

    if(!isDefined(medpack)) {
      break;
    }

    currenttime = float(gettime()) / 1000;
    timeremaining = int(round(endtime - currenttime));
  }

  if(isDefined(medpack) && isDefined(level.var_40346f16)) {
    medpack[[level.var_40346f16]](0, 0);
  }
}

function private function_c416ba8f() {
  assert(isPlayer(self));
  assert(isalive(self));
  assert(isDefined(level.spyhud));
  player = self;
  player endon(#"disconnect", #"death");
  level endon(#"game_ended");

  while(true) {
    event = player waittill(#"player_selected", #"hash_91a93ea58d7ad74", #"death", #"disconnect", #"game_ended");

    if(event._notify === "player_selected") {
      var_3b16e9b8 = getentbynum(event.playerclientnum);

      if(isDefined(var_3b16e9b8) && isPlayer(var_3b16e9b8)) {
        level.var_3b16e9b8[event.playerclientnum] = var_3b16e9b8;
        var_3b16e9b8.var_73a2057c = gameobjects::get_next_obj_id();
        var_3b16e9b8.iswanted = 1;
        objective_add(var_3b16e9b8.var_73a2057c, "active", var_3b16e9b8, #"hash_27a9c9216bd5cfeb", var_3b16e9b8);
        objective_setvisibletoall(var_3b16e9b8.var_73a2057c);
        objective_setinvisibletoplayer(var_3b16e9b8.var_73a2057c, var_3b16e9b8);

        if(var_3b16e9b8 spy::function_da8679c7() == 1) {
          var_3b16e9b8.var_349e0ec6 = gameobjects::get_next_obj_id();
          objective_add(var_3b16e9b8.var_349e0ec6, "active", var_3b16e9b8, #"hash_11f265c9fb8d6ec2", var_3b16e9b8);
          objective_setinvisibletoall(var_3b16e9b8.var_349e0ec6);

          foreach(checkplayer in getplayers()) {
            if(isDefined(checkplayer) && isalive(checkplayer) && checkplayer spy::function_da8679c7() == 1) {
              objective_setinvisibletoplayer(var_3b16e9b8.var_73a2057c, checkplayer);
              objective_setvisibletoplayer(var_3b16e9b8.var_349e0ec6, checkplayer);
            }
          }
        }

        level clientfield::set("wanted_client_num", event.playerclientnum);
        waitframe(1);
        level thread namespace_e51f0bc1::function_4f53c9a2(16);
        level thread namespace_e51f0bc1::function_2398866a(3, undefined, event.playerclientnum);
        level thread function_24a08c0d(var_3b16e9b8, player);
      }
    }
  }
}

function private function_24a08c0d(player, investigator) {
  if(!isDefined(player) || !isDefined(player.var_73a2057c)) {
    return;
  }

  var_e6d03a85 = player.var_588e0374;
  var_fd806937 = player getentitynumber();
  level endon(#"game_ended");
  level clientfield::set_world_uimodel("hudItems.spyMatchData." + var_e6d03a85 + ".isWanted", 1);
  skill = function_cb6ba828(3, "spy_wanted_order");
  timeremaining = skill.var_3e32dc53;
  starttime = float(gettime()) / 1000;
  endtime = starttime + timeremaining;
  isalive = 1;

  while(timeremaining > 0) {
    if(!isDefined(player) || !isalive(player)) {
      isalive = 0;
      break;
    }

    if(isDefined(player.var_349e0ec6)) {
      objective_setposition(player.var_349e0ec6, player getorigin() + (0, 0, 50));
    }

    wait float(function_60d95f53()) / 1000;
    currenttime = float(gettime()) / 1000;
    timeremaining = int(round(endtime - currenttime));
  }

  if(!isalive) {
    scoreevents::processscoreevent(#"hash_774766902a004309", investigator);
  } else if(isDefined(player)) {
    level thread namespace_e51f0bc1::function_2398866a(15, undefined, var_fd806937);
    player.iswanted = undefined;

    if(isDefined(player.var_73a2057c)) {
      objective_delete(player.var_73a2057c);
    }

    if(isDefined(player.var_349e0ec6)) {
      objective_delete(player.var_349e0ec6);
    }
  }

  level clientfield::set_world_uimodel("hudItems.spyMatchData." + var_e6d03a85 + ".isWanted", 0);
}

function function_aafab535(var_ada67e63, var_cfcbf39e) {
  level.var_ed3ea60a[var_ada67e63] = var_cfcbf39e;
}

function function_94858bde() {
  var_afef4a47 = undefined;
  players = spy::function_7a7907d4();

  foreach(player in players) {
    if(isDefined(player.iswanted) && player.iswanted) {
      var_afef4a47 = player;
      otherplayers = players;
      arrayremovevalue(otherplayers, var_afef4a47);
      thread globallogic_audio::function_61e17de0("spySkillWantedOrder", otherplayers);

      if(var_afef4a47.spyRole == 1) {
        var_afef4a47 thread globallogic_audio::leader_dialog_on_player("spySkillWantedOrderTarget");
      }

      break;
    }
  }
}

function function_ec01c4ec(var_ada67e63) {
  var_9921e529 = {
    #var_ada67e63: var_ada67e63, #use_time: function_f8d53445()
  };
  self function_678f57c8(#"hash_25cd38498fc97acf", var_9921e529);
}

function private init_devgui() {
  util::init_dvar("<dev string:x1a4>", 0, &function_14bb4ccb);
  util::waittill_can_add_debug_command();
  adddebugcommand("<dev string:x1bb>" + "<dev string:x1a4>" + "<dev string:x1fe>");
  adddebugcommand("<dev string:x207>" + "<dev string:x1a4>" + "<dev string:x24c>");
  adddebugcommand("<dev string:x256>");
}

function private function_14bb4ccb(dvar) {
  if(dvar.value != 0) {
    foreach(player in level.players) {
      if(!isbot(player)) {
        player function_53a81144(dvar.value);
      }
    }

    setDvar(dvar.name, 0);
  }
}

function private function_d876a71e() {
  self endon(#"death");

  if(getdvarint(#"hash_7c24f18aa004e92d", 0)) {}
}