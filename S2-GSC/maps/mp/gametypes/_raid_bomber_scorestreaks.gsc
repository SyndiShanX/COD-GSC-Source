/***********************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_raid_bomber_scorestreaks.gsc
***********************************************************/

init_bomber_killstreaks() {
  level.var_5A61["raid_flak"] = ::tryuseraidflak;
  level.var_5A61["raid_fighters"] = ::tryuseraidfighters;
  level.var_5A7D["killstreak_flak_gun_raids"] = "raid_flak";
  level.var_5A7D["agent_raid_fighters_mp"] = "raid_fighters";
  level thread lib_0528::func_52F3();
}

tryuseraidflak(param_00) {
  if(level.flak_in_progress) {
    self iclientprintlnbold(&"KILLSTREAKS_RAIDS_TOO_MUCH_FLAK");
    return 0;
  }

  level.flak_in_progress = 1;
  level.flak_scorestreak_id++;
  level.var_9854[maps\mp\_utility::func_45DE(self.var_1A7)] = 1;
  level thread lib_0528::func_A0E0();
  thread raid_atmosphereflak();
  thread raid_flakrundamage();
  thread raid_flak_timer();
  return 1;
}

raid_flak_timer() {
  wait(15);
  level notify("flakGunsDisabled");
  destroy_remaining_agents();
  level.flak_in_progress = 0;
  level.var_9854[maps\mp\_utility::func_45DE(self.var_1A7)] = 0;
  level thread lib_0528::func_A0E0();
  clear_flak_death_flags();
}

fighter_scorestreak_watcher(param_00) {
  level endon("game_ended");
  if(isPlayer(param_00) && !isbot(param_00)) {
    param_00 notifyonplayercommand("activate_fighter_scorestreak", "+actionslot 4");
  }

  for(;;) {
    param_00 waittill("activate_fighter_scorestreak");
    if(isDefined(param_00.var_5A69)) {
      param_00 maps\mp\killstreaks\_killstreaks::func_5A7A();
    }

    wait 0.05;
  }
}

raid_flakgettimescale(param_00) {
  return 1 + 6 - param_00 / 6;
}

raid_flakisvalidtarget(param_00) {
  var_01 = common_scripts\utility::func_562E(param_00.occupied_player.hasdiedtoflak);
  var_02 = gettime() - param_00.occupied_player.var_5BE2 >= 3500;
  return !var_01 && var_02;
}

raid_atmosphereflak() {
  level endon("flakGunsDisabled");
  level.var_3CE1 = 0;
  for(;;) {
    if(level.var_3CE1 < 30) {
      var_00 = getflaktargets();
      if(var_00.size == 0) {
        var_01 = (randomfloatrange(-18000, 18000) + level.var_5FEB[0], randomfloatrange(-18000, 18000) + level.var_5FEB[1], randomfloatrange(-8000, 8000) + level.var_5FEB[2]);
      } else {
        var_02 = common_scripts\utility::func_7A33(var_01);
        var_01 = (randomfloatrange(-500, 500) + var_02.var_116[0], randomfloatrange(-500, 500) + var_02.var_116[1], randomfloatrange(-500, 500) + var_02.var_116[2]);
      }

      level.var_3CE1++;
      thread raid_flakexplosioneffects(var_01);
      var_03 = raid_flakgettimescale(var_00.size);
      wait(randomfloatrange(0.1 * var_03, 0.3 * var_03));
      continue;
    }

    wait 0.05;
  }
}

raid_flakexplosioneffects(param_00) {
  var_01 = common_scripts\utility::func_8FFC();
  var_01.var_116 = param_00;
  var_01 method_805B();
  wait 0.05;
  playFXOnTag(common_scripts\utility::func_44F5("flak_gun_explosion"), var_01, "tag_origin");
  lib_0378::func_8D74("ks_flak_cannon_explo", param_00);
  wait(4.5);
  var_01 delete();
  level.var_3CE1--;
}

raid_flakrundamage() {
  level endon("flakGunsDisabled");
  level endon("game_ended");
  for(;;) {
    var_00 = getflaktargets();
    var_01 = common_scripts\utility::func_7A33(var_00);
    if(isDefined(var_01) && raid_flakisvalidtarget(var_01)) {
      var_02 = (randomfloatrange(-100, 100) + var_01.var_116[0], randomfloatrange(-100, 100) + var_01.var_116[1], randomfloatrange(-100, 100) + var_01.var_116[2]);
      thread raid_flakexplosioneffects(var_02);
      if(function_01EF(var_01.occupied_player)) {
        var_01 dodamage(randomfloatrange(450, 500) * 10, var_02, self, undefined, "MOD_UNKNOWN", "killstreak_flak_gun_raids");
      } else {
        var_01 dodamage(randomfloatrange(100, 150) * 10, var_02, self, undefined, "MOD_UNKNOWN", "killstreak_flak_gun_raids");
      }

      if(1) {
        var_01.occupied_player playrumbleonentity("artillery_rumble");
        earthquake(0.7, 0.5, var_01.var_116, 800, var_01.occupied_player);
      }
    }

    var_03 = raid_flakgettimescale(var_00.size);
    wait(randomfloatrange(0.5 * var_03, 1.5 * var_03));
  }
}

destroy_remaining_agents() {
  var_00 = getflaktargets();
  foreach(var_02 in var_00) {
    if(function_01EF(var_02.occupied_player)) {
      var_02 dodamage(randomfloatrange(450, 500) * 10, var_02.var_116, self, undefined, "MOD_UNKNOWN", "killstreak_flak_gun_raids");
    }
  }
}

tryuseraidfighters(param_00) {
  if(!isDefined(level.bomberescortfighteragents)) {
    level.bomberescortfighteragents = [];
  }

  if(!canspawnmorefighters()) {
    return 0;
  }

  level.fighters_in_progress = 1;
  [[level.bot_spawnagents_func]]();
  return 1;
}

canspawnmorefighters() {
  var_00 = 0;
  foreach(var_02 in level.bomberescortfighteragents) {
    if(var_02.var_565F && !var_02.var_4B60) {
      var_00++;
    }
  }

  if(var_00 >= 5) {
    self iclientprintlnbold(&"KILLSTREAKS_RAIDS_TOO_MANY_FIGHTERS");
    return 0;
  }

  return 1;
}

getflaktargets() {
  var_00 = [];
  foreach(var_02 in level.pp_array) {
    if(isDefined(var_02.var_1A7) && var_02.var_1A7 == game["attackers"]) {
      var_00 = common_scripts\utility::func_F6F(var_00, var_02);
    }
  }

  return var_00;
}

clear_flak_death_flags() {
  var_00 = getflaktargets();
  foreach(var_02 in var_00) {
    var_02.occupied_player.hasdiedtoflak = undefined;
  }
}