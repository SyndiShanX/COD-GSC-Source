/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\_achievements.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_skipto;
#using scripts\cp\_util;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace achievements;

function autoexec __init__sytem__() {
  system::register("achievements", &__init__, undefined, undefined);
}

function __init__() {
  callback::on_connect(&on_player_connect);
  callback::on_ai_spawned(&on_ai_spawned);
  callback::on_ai_damage(&on_ai_damage);
  callback::on_ai_killed(&on_ai_killed);
  callback::on_player_killed(&on_player_death);
  spawner::add_archetype_spawn_function("wasp", &function_632712d7, 3);
  function_4462a8b7();
}

function function_4462a8b7() {
  level.var_a4d4c1e3["cp_mi_cairo_aquifer"] = "CP_COMPLETE_AQUIFER";
  level.var_a4d4c1e3["cp_mi_sing_biodomes"] = "CP_COMPLETE_BIODOMES";
  level.var_a4d4c1e3["cp_mi_sing_blackstation"] = "CP_COMPLETE_BLACKSTATION";
  level.var_a4d4c1e3["cp_mi_cairo_infection"] = "CP_COMPLETE_INFECTION";
  level.var_a4d4c1e3["cp_mi_cairo_lotus"] = "CP_COMPLETE_LOTUS";
  level.var_a4d4c1e3["cp_mi_zurich_newworld"] = "CP_COMPLETE_NEWWORLD";
  level.var_a4d4c1e3["cp_mi_eth_prologue"] = "CP_COMPLETE_PROLOGUE";
  level.var_a4d4c1e3["cp_mi_cairo_ramses"] = "CP_COMPLETE_RAMSES";
  level.var_a4d4c1e3["cp_mi_sing_sgen"] = "CP_COMPLETE_SGEN";
  level.var_a4d4c1e3["cp_mi_sing_vengeance"] = "CP_COMPLETE_VENGEANCE";
}

function give_achievement(str_id, var_56503a18 = 0) {
  if(sessionmodeiscampaignzombiesgame() && !var_56503a18) {
    return;
  }
  printtoprightln("" + str_id, (1, 1, 1));
  println("" + str_id);
  self giveachievement(str_id);
}

function on_player_connect() {
  self endon("disconnect");
  self.var_75cf9e2e = spawnStruct();
  self.var_75cf9e2e.killindex = 0;
  self.var_75cf9e2e.var_940a9f6e = 0;
  self.var_75cf9e2e.kills = [];
  self.var_75cf9e2e.var_43311285 = [];
  self thread function_34eaa01b();
  self thread function_e587e1f2();
  while(true) {
    self waittill("give_achievement", str_id);
    give_achievement(str_id);
  }
}

function function_5f2f7800(eplayer, levelname, difficulty) {
  if(!isDefined(levelname) || !isDefined(level.var_a4d4c1e3[levelname])) {
    return;
  }
  if(difficulty < 2) {
    return;
  }
  eplayer give_achievement(level.var_a4d4c1e3[levelname]);
}

function function_c3e7ff05(eplayer) {
  var_44a14bc7 = [];
  for(index = 0; index <= 4; index++) {
    var_44a14bc7[index] = 0;
  }
  mission_list = skipto::function_23eda99c();
  var_f0ecfb92 = 0;
  foreach(mission in mission_list) {
    if(!eplayer getdstat("PlayerStatsByMap", mission, "hasBeenCompleted")) {
      continue;
    }
    highestdifficulty = eplayer getdstat("PlayerStatsByMap", mission, "highestStats", "HIGHEST_DIFFICULTY");
    if(!isDefined(var_44a14bc7[highestdifficulty])) {
      var_44a14bc7[highestdifficulty] = 0;
    }
    var_44a14bc7[highestdifficulty]++;
    var_f0ecfb92++;
  }
  var_98680dde = mission_list.size;
  if(var_f0ecfb92 == var_98680dde) {
    eplayer give_achievement("CP_CAMPAIGN_COMPLETE");
  }
  if(((var_44a14bc7[2] + var_44a14bc7[3]) + var_44a14bc7[4]) == var_98680dde) {
    eplayer give_achievement("CP_HARD_COMPLETE");
  }
  if(var_44a14bc7[4] == var_98680dde) {
    eplayer give_achievement("CP_REALISTIC_COMPLETE");
  }
}

function function_733a6065(eplayer, levelname, difficulty, var_10c5a3ef) {
  if(!var_10c5a3ef) {
    function_5f2f7800(eplayer, levelname, difficulty);
    function_c3e7ff05(eplayer);
  }
}

function function_34eaa01b() {
  self endon("disconnect");
  while(true) {
    self waittill("wallrun_begin");
    v_start = self.origin;
    self waittill("wallrun_end");
    var_1d634a25 = distance(v_start, self.origin);
    n_current_dist = self getdstat("Achievements", "CP_COMPLETE_WALL_RUN");
    n_current_dist = n_current_dist + var_1d634a25;
    printtoprightln(n_current_dist, (1, 1, 1));
    if(n_current_dist >= 9843) {
      give_achievement("CP_COMPLETE_WALL_RUN");
      return;
    }
    self setdstat("Achievements", "CP_COMPLETE_WALL_RUN", int(n_current_dist));
  }
}

function on_ai_spawned() {}

function on_ai_damage(s_params) {
  self.var_74390712 = undefined;
  if(isplayer(s_params.eattacker)) {
    if(s_params.idflags & 8) {
      self.var_74390712 = s_params.eattacker;
    }
  }
}

function on_player_death(s_params) {
  self.var_75cf9e2e.killindex = 0;
  self.var_75cf9e2e.var_940a9f6e = 0;
  self.var_75cf9e2e.kills = [];
  self.var_75cf9e2e.var_43311285 = [];
}

function private function_1121f26a(var_c856ad1d, evictim) {
  if(isDefined(var_c856ad1d.hijacked_vehicle_entity)) {
    var_1efe785f = distance(var_c856ad1d.hijacked_vehicle_entity.origin, evictim.origin);
  } else {
    var_1efe785f = distance(var_c856ad1d.origin, evictim.origin);
  }
  if(var_1efe785f >= 3937) {
    var_46907f23 = var_c856ad1d getdstat("Achievements", "CP_DISTANCE_KILL");
    var_46907f23++;
    printtoprightln((("" + var_1efe785f) + "") + var_46907f23, (1, 1, 1));
    if(var_46907f23 >= 5) {
      var_c856ad1d give_achievement("CP_DISTANCE_KILL");
    } else {
      var_c856ad1d setdstat("Achievements", "CP_DISTANCE_KILL", var_46907f23);
    }
  }
}

function private function_914b8688(player, evictim, weapon, einflictor) {
  if(!isDefined(weapon)) {
    return;
  }
  if(!isDefined(player.var_58477d59)) {
    player.var_58477d59 = [];
    player.var_58477d59["CP_FLYING_WASP_KILL"] = 0;
    player.var_58477d59["CP_COMBAT_ROBOT_KILL"] = 0;
  }
  var_9663b3f1 = 0;
  if(weapon.name == "gadget_firefly_swarm" || weapon.name == "gadget_firefly_swarm_upgraded") {
    function_9dab90e7(player);
    var_9663b3f1 = 1;
  } else {
    if(isDefined(player.var_75cf9e2e.var_6ce188b0) && weapon.name == "gadget_unstoppable_force" || weapon.name == "gadget_unstoppable_force_upgraded") {
      player.var_75cf9e2e.var_6ce188b0++;
      if(player.var_75cf9e2e.var_6ce188b0 >= 5) {
        player give_achievement("CP_UNSTOPPABLE_KILL");
      }
    } else {
      if(isDefined(player.hijacked_vehicle_entity)) {
        if(isDefined(player.hijacked_vehicle_entity.killcount)) {
          player.hijacked_vehicle_entity.killcount++;
        } else {
          player.hijacked_vehicle_entity.killcount = 1;
        }
        if(player.hijacked_vehicle_entity.scriptvehicletype == "wasp" && player.hijacked_vehicle_entity.killcount >= 20) {
          if(!player.var_58477d59["CP_FLYING_WASP_KILL"]) {
            player give_achievement("CP_FLYING_WASP_KILL");
            player.var_58477d59["CP_FLYING_WASP_KILL"] = 1;
          }
        }
        if(player.hijacked_vehicle_entity.killcount >= 10) {
          if(!player.var_58477d59["CP_COMBAT_ROBOT_KILL"]) {
            player give_achievement("CP_COMBAT_ROBOT_KILL");
            player.var_58477d59["CP_COMBAT_ROBOT_KILL"] = 1;
          }
        }
      } else if(isai(einflictor) && isDefined(einflictor.remote_owner) && einflictor.remote_owner == player) {
        if(isDefined(einflictor.killcount)) {
          einflictor.killcount++;
        } else {
          einflictor.killcount = 1;
        }
        if(einflictor.killcount >= 10) {
          if(!player.var_58477d59["CP_COMBAT_ROBOT_KILL"]) {
            player give_achievement("CP_COMBAT_ROBOT_KILL");
            player.var_58477d59["CP_COMBAT_ROBOT_KILL"] = 1;
          }
        }
      }
    }
  }
  if(isDefined(evictim.swarm) && !var_9663b3f1) {
    function_9dab90e7(player);
  }
  if(isDefined(player.var_75cf9e2e.var_a4fb0163) && player.var_75cf9e2e.var_a4fb0163 >= 6) {
    player give_achievement("CP_FIREFLIES_KILL");
  }
}

function private function_2b2fb40b(player, var_aae1ed0d, weapon) {
  player.var_75cf9e2e.var_940a9f6e++;
  currentindex = player.var_75cf9e2e.killindex;
  player.var_75cf9e2e.kills[currentindex] = gettime();
  player.var_75cf9e2e.killindex = (currentindex + 1) % 10;
  if(player.var_75cf9e2e.var_940a9f6e < 10) {
    return;
  }
  startindex = (currentindex + 1) % 10;
  starttime = player.var_75cf9e2e.kills[startindex];
  endtime = player.var_75cf9e2e.kills[currentindex];
  if(player.var_75cf9e2e.var_940a9f6e >= 10 && (endtime - starttime) <= 3000) {
    player give_achievement("CP_TIMED_KILL");
  }
}

function private function_b1d71bd3(player, weapon) {
  var_4c26012 = getbaseweaponitemindex(weapon);
  if(!isDefined(var_4c26012) || (var_4c26012 < 1 || var_4c26012 > 60)) {
    return;
  }
  player.var_75cf9e2e.var_43311285[weapon.rootweapon.name] = gettime();
  var_6c46ba29 = 0;
  var_376861f6 = gettime() - 30000;
  if(var_376861f6 < 0) {
    var_376861f6 = 0;
  }
  foreach(lastkilltime in player.var_75cf9e2e.var_43311285) {
    if(lastkilltime > var_376861f6) {
      var_6c46ba29++;
    }
  }
  if(var_6c46ba29 >= 5) {
    player give_achievement("CP_DIFFERENT_GUN_KILL");
  }
}

function private function_307b3ac3(eplayer, evictim, var_433291aa) {
  if(!evictim util::isentstunned() || evictim.team !== "axis") {
    return;
  }
  if(!isDefined(eplayer.var_75cf9e2e.var_6a670270)) {
    eplayer.var_75cf9e2e.var_6a670270 = [];
  }
  if(!isDefined(eplayer.var_75cf9e2e.var_6a670270)) {
    eplayer.var_75cf9e2e.var_6a670270 = [];
  } else if(!isarray(eplayer.var_75cf9e2e.var_6a670270)) {
    eplayer.var_75cf9e2e.var_6a670270 = array(eplayer.var_75cf9e2e.var_6a670270);
  }
  eplayer.var_75cf9e2e.var_6a670270[eplayer.var_75cf9e2e.var_6a670270.size] = gettime();
  startindex = eplayer.var_75cf9e2e.var_6a670270.size - 1;
  maxtime = gettime() - 3000;
  for(var_7b5c89e6 = startindex; var_7b5c89e6 >= 0; var_7b5c89e6--) {
    if(eplayer.var_75cf9e2e.var_6a670270[var_7b5c89e6] < maxtime) {
      arrayremoveindex(eplayer.var_75cf9e2e.var_6a670270, var_7b5c89e6);
    }
  }
  if(eplayer.var_75cf9e2e.var_6a670270.size >= 5) {
    eplayer give_achievement("CP_TIMED_STUNNED_KILL");
  }
}

function private function_c4f2de38(player, victim, inflictor) {
  if(!isDefined(inflictor.weapon) || !isDefined(self.scriptvehicletype) || self.scriptvehicletype != "wasp" || inflictor.weapon.type != "grenade") {
    return;
  }
  if(!isDefined(inflictor.var_9bbaef3)) {
    inflictor.var_9bbaef3 = 1;
  } else {
    inflictor.var_9bbaef3++;
  }
  if(inflictor.var_9bbaef3 >= 3) {
    player give_achievement("CP_KILL_WASPS");
  }
}

function function_17ec453c(eattacker, evictim, var_433291aa) {
  if(isDefined(eattacker.iffowner) && isplayer(eattacker.iffowner)) {
    if(isDefined(eattacker.killcount)) {
      eattacker.killcount++;
    } else {
      eattacker.killcount = 1;
    }
    if(eattacker.killcount >= 10) {
      eattacker.iffowner give_achievement("CP_COMBAT_ROBOT_KILL");
    }
  }
}

function function_99d6210d(eplayer, evictim) {
  if(isDefined(evictim.var_74390712) && evictim.var_74390712 == eplayer && evictim.team !== "allies") {
    eplayer give_achievement("CP_OBSTRUCTED_KILL");
  }
}

function function_fbe029db(eplayer) {
  var_ba8faef8 = eplayer getmeleechaincount();
  if(2 <= var_ba8faef8) {
    eplayer give_achievement("CP_MELEE_COMBO_KILL");
  }
}

function on_ai_killed(s_params) {
  if(isplayer(s_params.eattacker)) {
    player = s_params.eattacker;
    function_1121f26a(player, self);
    function_914b8688(player, self, s_params.weapon, s_params.einflictor);
    function_fbe029db(player);
    function_2b2fb40b(player, self, s_params.weapon);
    function_b1d71bd3(player, s_params.weapon);
    function_c4f2de38(player, self, s_params.einflictor);
    function_307b3ac3(player, self, s_params.weapon);
    function_99d6210d(player, self);
  } else if(isai(s_params.eattacker)) {
    function_17ec453c(s_params.eattacker, self, s_params.weapon);
  }
}

function function_632712d7(n_count) {}

function private function_9dab90e7(player) {
  if(!isDefined(player.var_75cf9e2e.var_a4fb0163)) {
    player.var_75cf9e2e.var_a4fb0163 = 1;
  } else {
    player.var_75cf9e2e.var_a4fb0163++;
  }
}

function private function_e587e1f2() {
  self endon("disconnect");
  while(true) {
    self waittill("gun_level_complete", rewardxp, attachmentindex, itemindex, rankid, islastrank);
    if(islastrank && (itemindex >= 1 && itemindex <= 60)) {
      self give_achievement("CP_ALL_WEAPON_ATTACHMENTS");
      break;
    }
  }
}

function checkweaponchallengecomplete(var_e9af7d73) {
  if(var_e9af7d73 == 3) {
    self give_achievement("CP_ALL_WEAPON_CAMOS");
  }
}

function function_b2d1aafa() {
  if(level.cybercom.var_12f85dec == 0) {
    foreach(player in level.players) {
      if(!isDefined(player.var_75cf9e2e.var_a4fb0163)) {
        continue;
      }
      player.var_75cf9e2e.var_a4fb0163 = undefined;
    }
  }
}

function function_386309ce(player) {
  player.var_75cf9e2e.var_6ce188b0 = 0;
}

function function_6903d776(var_44c1c544) {
  if(isDefined(var_44c1c544.killcount)) {
    var_44c1c544.killcount = undefined;
  }
}