/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\achievements.gsc
***********************************************/

#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\skipto;
#using scripts\cp_common\util;
#namespace achievements;

function private autoexec __init__system__() {
  system::register(#"achievements", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  callback::on_connect(&on_player_connect);
  callback::on_ai_spawned(&on_ai_spawned);
  callback::on_ai_damage(&on_ai_damage);
  callback::on_ai_killed(&on_ai_killed);
  callback::on_player_killed(&on_player_death);
  function_df1192a7();
}

function function_df1192a7() {}

function give_achievement(achievement, var_a299f0b3) {
  assert(ishash(var_a299f0b3), "<dev string:x38>");

  printtoprightln("<dev string:x59>" + function_9e72a96(var_a299f0b3), (1, 1, 1));
  println("<dev string:x59>" + function_9e72a96(var_a299f0b3));

  if(!isDefined(self.var_b34a7212)) {
    self.var_b34a7212 = [];
  }

  if(isDefined(self.var_b34a7212[var_a299f0b3])) {
    return;
  }

  self.var_b34a7212[var_a299f0b3] = 1;
  self giveachievement(var_a299f0b3);
}

function on_player_connect() {
  self endon(#"disconnect");
  self.var_8e5e0541 = spawnStruct();
  self.var_8e5e0541.var_d3879c8e = 0;
  self.var_8e5e0541.var_ca87baa4 = 0;
  self.var_8e5e0541.kills = [];
  self.var_8e5e0541.var_f79c95f9 = [];
  self thread function_fd51b8a8();

  while(true) {
    waitresult = self waittill(#"give_achievement");
    give_achievement(waitresult.id);
  }
}

function function_20254235(eplayer, levelname, difficulty) {
  levelname give_achievement(hash("cp_achievement_" + difficulty));
}

function function_cc2216e2(eplayer) {
  var_b0abc67b = [];

  for(index = 0; index <= 4; index++) {
    var_b0abc67b[index] = 0;
  }

  var_cf1f3586 = skipto::function_228558fd(0, 0);
  var_d8222c25 = 0;

  foreach(msn in var_cf1f3586) {
    if(!eplayer stats::get_stat(#"mapdata", msn, #"complete")) {
      continue;
    }

    highestdifficulty = eplayer stats::get_stat(#"mapdata", msn, #"highestdifficulty");

    if(!isDefined(var_b0abc67b[highestdifficulty])) {
      var_b0abc67b[highestdifficulty] = 0;
    }

    var_b0abc67b[highestdifficulty]++;
    var_d8222c25++;
  }

  var_7a34e971 = var_cf1f3586.size - 1;

  if(var_d8222c25 == var_7a34e971) {
    eplayer give_achievement(#"cp_achievement_combat_recruit");
  }

  if(var_b0abc67b[3] + var_b0abc67b[4] == var_7a34e971) {
    eplayer give_achievement(#"cp_achievement_combat_hardened");
  }
}

function function_f854bc50(eplayer, levelname, difficulty) {
  function_20254235(eplayer, levelname, difficulty);
  function_cc2216e2(eplayer);
}

function on_ai_spawned() {}

function on_ai_damage(s_params) {
  self.var_e2f6147a = undefined;

  if(isPlayer(s_params.eattacker)) {
    if(s_params.idflags & 8) {
      self.var_e2f6147a = s_params.eattacker;
    }
  }
}

function on_player_death(s_params) {
  self.var_8e5e0541.var_d3879c8e = 0;
  self.var_8e5e0541.var_ca87baa4 = 0;
  self.var_8e5e0541.kills = [];
  self.var_8e5e0541.var_f79c95f9 = [];
}

function private function_467369b2(var_668b29af, evictim) {
  var_a8f62552 = distance(var_668b29af.origin, evictim.origin);

  if(var_a8f62552 >= 3937) {
    var_41db60bc = var_668b29af stats::get_stat(#"achievements", #"hash_5740a8698a4d0345");
    var_41db60bc++;

    printtoprightln("<dev string:x73>" + var_a8f62552 + "<dev string:x77>" + var_41db60bc, (1, 1, 1));

    if(var_41db60bc >= 5) {
      var_668b29af give_achievement(#"hash_5740a8698a4d0345");
      return;
    }

    var_668b29af stats::set_stat(#"achievements", #"hash_5740a8698a4d0345", var_41db60bc);
  }
}

function private function_4239da84(player, var_6d2d969a, weapon) {
  weapon.var_8e5e0541.var_ca87baa4++;
  currentindex = weapon.var_8e5e0541.var_d3879c8e;
  weapon.var_8e5e0541.kills[currentindex] = gettime();
  weapon.var_8e5e0541.var_d3879c8e = (currentindex + 1) % 10;

  if(weapon.var_8e5e0541.var_ca87baa4 < 10) {
    return;
  }

  startindex = (currentindex + 1) % 10;
  starttime = weapon.var_8e5e0541.kills[startindex];
  endtime = weapon.var_8e5e0541.kills[currentindex];

  if(weapon.var_8e5e0541.var_ca87baa4 >= 10 && endtime - starttime <= 3000) {
    weapon give_achievement(#"hash_1e7fe721b8911e57");
  }
}

function private function_b25a404e(player, weapon) {
  baseindex = getbaseweaponitemindex(weapon);

  if(!isDefined(baseindex) || baseindex < 1 || baseindex > 60) {
    return;
  }

  player.var_8e5e0541.var_f79c95f9[weapon.rootweapon.name] = gettime();
  var_5f546d20 = 0;
  var_9aecaf58 = gettime() - 30000;

  if(var_9aecaf58 < 0) {
    var_9aecaf58 = 0;
  }

  foreach(lastkilltime in player.var_8e5e0541.var_f79c95f9) {
    if(lastkilltime > var_9aecaf58) {
      var_5f546d20++;
    }
  }

  if(var_5f546d20 >= 5) {
    player give_achievement(#"hash_1a6ca2f96f903656");
  }
}

function function_2240fcb8(eattacker, evictim, eweapon) {
  if(isDefined(eweapon.var_628ca13e) && isPlayer(eweapon.var_628ca13e)) {
    if(isDefined(eweapon.killcount)) {
      eweapon.killcount++;
      return;
    }

    eweapon.killcount = 1;
  }
}

function function_8b531812(eplayer, evictim) {
  if(isDefined(evictim.var_e2f6147a) && evictim.var_e2f6147a == eplayer && evictim.team !== # "allies") {
    eplayer give_achievement(#"hash_1f0a3ec94eff5513");
  }
}

function function_6e3f345f(eplayer) {
  var_71c7cc3a = eplayer getmeleechaincount();

  if(2 <= var_71c7cc3a) {
    eplayer give_achievement(#"hash_42303e6214910391");
  }
}

function on_ai_killed(s_params) {
  if(isPlayer(s_params.eattacker)) {
    player = s_params.eattacker;
    function_467369b2(player, self);
    function_6e3f345f(player);
    function_4239da84(player, self, s_params.weapon);
    function_b25a404e(player, s_params.weapon);
    function_8b531812(player, self);
    player function_1d62fbfa(1, s_params.weapon.weapclass, s_params.weapon.firetype);
    return;
  }

  if(isai(s_params.eattacker)) {
    function_2240fcb8(s_params.eattacker, self, s_params.weapon);
  }
}

function private function_fd51b8a8() {
  self endon(#"disconnect");

  while(true) {
    waitresult = self waittill(#"gun_level_complete");

    if(waitresult.is_last_rank && waitresult.item_index >= 1 && waitresult.item_index <= 60) {
      self give_achievement(#"hash_30b6860e2869b596");
      break;
    }
  }
}

function function_c3541c14(var_71d636c6) {
  if(var_71d636c6 == 3) {
    self give_achievement(#"hash_5f39b2b443875e95");
  }
}

function function_533e57d6(player, count) {
  player stats::function_dad108fa("cp_body_shield_count", count);
  var_69fa8154 = isDefined(player stats::get_stat_global("cp_body_shield_count")) ? player stats::get_stat_global("cp_body_shield_count") : 0;

  if(var_69fa8154 >= 5) {
    player give_achievement(#"cp_achievement_body_shield");
  }
}

function function_1d62fbfa(count, weapclass, firetype) {
  if(weapclass == "rifle" && firetype != "Single Shot") {
    self stats::function_dad108fa("cp_kills_ar", count);
  } else if(weapclass == "spread") {
    self stats::function_dad108fa("cp_kills_sg", count);
  } else if(weapclass == "mg") {
    self stats::function_dad108fa("cp_kills_lmg", count);
  } else if(weapclass == "smg") {
    self stats::function_dad108fa("cp_kills_smg", count);
  } else {
    return;
  }

  lmgkills = isDefined(self stats::get_stat_global(#"cp_kills_lmg")) ? self stats::get_stat_global(#"cp_kills_lmg") : 0;
  smgkills = isDefined(self stats::get_stat_global(#"cp_kills_smg")) ? self stats::get_stat_global(#"cp_kills_smg") : 0;
  arkills = isDefined(self stats::get_stat_global(#"cp_kills_ar")) ? self stats::get_stat_global(#"cp_kills_ar") : 0;
  var_2f070c99 = isDefined(self stats::get_stat_global(#"cp_kills_sg")) ? self stats::get_stat_global(#"cp_kills_sg") : 0;

  if(lmgkills >= 5 && smgkills >= 5 && arkills >= 5 && var_2f070c99 >= 5) {
    self give_achievement(#"cp_achievement_jack_all_trades");
  }

  if(arkills >= 200) {
    self give_achievement(#"cp_achievement_old_faithful");
  }
}