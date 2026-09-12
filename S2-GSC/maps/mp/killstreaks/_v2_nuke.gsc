/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_v2_nuke.gsc
*********************************************/

init() {
  level.killstreakfuncs["v2_rocket"] = ::func_9E3D;
  level.var_5A7D["v2_rocket_mp"] = "v2_rocket";
  level.var_611["nuke_flash"] = loadfx("vfx/explosion/v2_explosion_mp_rnr");
  setdvarifuninitialized("scr_nukeTimer", 10);
  level.var_6866 = getdvarint("scr_nukeTimer");
  level.var_685E = spawnStruct();
}

func_9E3D(param_00) {
  if(isDefined(level.var_685D)) {
    self iprintlnbold(&"KILLSTREAKS_NUKE_ALREADY_INBOUND");
    return 0;
  }

  if(isDefined(level.nukecoolingdown)) {
    self iprintlnbold(&"KILLSTREAKS_NUKE_COOLDOWN");
    return 0;
  }

  if(maps\mp\_utility::func_581D()) {
    return 0;
  }

  thread func_3252();
  if(level.gametype != "infect") {
    maps\mp\gametypes\_missions::processchallenge("ch_streak_v2rocket");
  }

  maps\mp\_matchdata::func_5E9A("v2_rocket", self.origin);
  return 1;
}

func_2CEE(param_00, param_01) {
  level endon("nuke_cancelled");
  maps\mp\gametypes\_hostmigration::func_A6F5(param_00);
  thread[[param_01]]();
}

wait_for_nuke_user_disconnect() {
  level endon("game_ended");
  level endon("nuke_cancelled");
  level endon("nuke_death");
  self waittill("disconnect");
  level notify("nuke_cancelled");
}

wait_for_nuke_cancelled() {
  level endon("game_ended");
  level endon("nuke_death");
  level waittill("nuke_cancelled");
  setomnvar("ui_bomb_a_state", 0);
  level.var_685D = undefined;
  level.nukecoolingdown = undefined;
  level.var_685E.player = undefined;
  level.var_685E.team = undefined;
}

func_3252() {
  level endon("nuke_cancelled");
  thread wait_for_nuke_user_disconnect();
  level thread wait_for_nuke_cancelled();
  level.var_685E.player = self;
  level.var_685E.team = self.pers["team"];
  level.var_685D = 1;
  level.nukecoolingdown = 1;
  setomnvar("ui_bomb_a_state", 4);
  if(!level.teambased && !level.hardcoremode) {
    self iprintlnbold(&"MP_FRIENDLY_TACTICAL_NUKE");
  }

  level thread func_2CEE(level.var_6866, ::func_6861);
  level thread func_2CEE(level.var_6866, ::func_6860);
  level thread func_2CEE(level.var_6866 - 0.47, ::func_685C);
  level thread func_2CEE(level.var_6866 - 0.1, ::func_6867);
  level thread func_2CEE(level.var_6866 + 0.5, ::func_6858);
  level thread func_2CEE(level.var_6866 + 0.6, ::func_685A);
  level thread func_A0D6();
  if(!isDefined(level.var_6852)) {
    level.var_6852 = spawn("script_origin", (0, 0, 0));
    level.var_6852 hide();
  }

  if(!isDefined(level.var_6856)) {
    level.var_6856 = spawn("script_origin", (0, 0, 1));
    level.var_6856 hide();
  }

  lib_0378::func_8D74("aud_v2_incoming");
  for(var_00 = level.var_6866; var_00 > 0; var_00--) {
    lib_0380::func_6840("mp_s2_obj_timer_tick_1s", undefined);
    wait(1);
  }
}

func_6861() {
  level endon("nuke_cancelled");
  lib_0378::func_8D74("aud_v2_explosion");
}

func_685C() {
  level endon("nuke_cancelled");
  foreach(var_01 in level.players) {
    var_02 = anglesToForward(var_01.angles);
    var_02 = (var_02[0], var_02[1], 0);
    var_02 = vectorNormalize(var_02);
    var_03 = 5000;
    var_04 = spawn("script_model", var_01.origin + var_02 * var_03);
    var_04 setModel("tag_origin");
    var_05 = vectortoangles(var_01.origin - var_04.origin);
    var_04.angles = (270, var_05[1] + 90, 0);
    var_04 hide();
    var_04 showtoclient(var_01);
    var_04 thread func_685B(var_01);
    var_04 thread wait_destroy_nuke_fx();
  }
}

wait_destroy_nuke_fx() {
  level endon("game_ended");
  level common_scripts\utility::waittill_notify_or_timeout("nuke_cancelled", 20);
  self delete();
  level.nukecoolingdown = undefined;
}

func_685B(param_00) {
  level endon("nuke_cancelled");
  param_00 endon("disconnect");
  wait 0.05;
  playfxontagforclients(level.var_611["nuke_flash"], self, "tag_origin", param_00);
}

func_6860() {
  level endon("nuke_cancelled");
  setomnvar("ui_bomb_a_state", 0);
  setslowmotion(1, 0.25, 0.5);
  level waittill("nuke_death");
  setslowmotion(0.25, 1, 2);
}

func_6867() {
  level endon("nuke_cancelled");
  var_00 = "dna_bomb";
  if(isDefined(level.var_3092)) {
    var_00 = level.var_3092;
  }

  level.var_6868 = 1;
  foreach(var_02 in level.players) {
    var_02 method_8483(var_00, 0.5);
    var_02 thread applyv2flash(1.6, 0.75);
  }

  level waittill("nuke_death");
  wait(3);
  foreach(var_02 in level.players) {
    var_02 method_8483("", 10);
  }

  level.var_6868 = undefined;
}

func_6858() {
  level endon("nuke_cancelled");
  level notify("nuke_death");
  maps\mp\gametypes\_hostmigration::func_A782();
  ambientstop(1);
  var_00 = 0;
  foreach(var_02 in level.players) {
    if(level.teambased) {
      if(isDefined(level.var_685E.team) && var_02.team == level.var_685E.team) {
        continue;
      }
    } else if(isDefined(level.var_685E.player) && var_02 == level.var_685E.player) {
      continue;
    }

    var_02.var_6857 = 1;
    if(isalive(var_02)) {
      var_02 thread maps\mp\gametypes\_damage::func_3BAC(level.var_685E.player, level.var_685E.player, 999999, 0, "MOD_EXPLOSIVE", "v2_rocket_mp", var_02.origin, var_02.origin, "none", 0, 0);
      if(isDefined(var_02.var_5738) && var_02.var_5738 == 1) {
        var_02 dodamage(1, var_02.origin, level.var_685E.player, level.var_685E.player, "MOD_EXPLOSIVE", "v2_rocket_mp");
      }

      var_00 = var_00 + 0.05;
    }
  }

  level thread func_6853();
  level.var_685D = undefined;
}

func_685A() {
  level endon("nuke_cancelled");
  foreach(var_01 in level.players) {
    earthquake(0.6, 5, var_01.origin, 1000, var_01);
    var_01 playRumbleOnEntity("damage_heavy");
  }
}

func_6853() {
  level endon("game_ended");
  level notify("nuke_EMPJam");
  level endon("nuke_EMPJam");
  level thread func_6855(level.var_685E.player);
  level notify("nuke_emp_update");
  foreach(var_01 in level.players) {
    if(level.teambased && var_01.team == level.var_685E.team) {
      continue;
    }

    var_01.var_6857 = undefined;
  }

  level notify("nuke_emp_update");
  level notify("nuke_emp_ended");
}

func_6855(param_00) {
  level endon("game_ended");
  var_01 = [];
  if(level.teambased) {
    var_01 = level.var_9FDA[maps\mp\_utility::func_45DE(param_00.team)];
  } else {
    var_01 = level.var_9FDA;
  }

  foreach(var_03 in var_01) {
    if((level.teambased && isDefined(var_03.team) && var_03.team != param_00.team) || !level.teambased && isDefined(var_03.owner) && var_03.owner != param_00) {
      var_03 dodamage(99999, var_03.origin, param_00, param_00, "MOD_EXPLOSIVE", "v2_rocket_mp");
    }
  }

  var_05 = level.var_7043;
  foreach(var_07 in var_05) {
    if((level.teambased && isDefined(var_07.team) && var_07.team != param_00.team) || !level.teambased && isDefined(var_07.owner) && var_07.owner != param_00) {
      var_07 dodamage(99999, var_07.origin, param_00, param_00, "MOD_EXPLOSIVE", "v2_rocket_mp");
    }
  }

  var_09 = level.var_6E71;
  foreach(var_0B in level.var_6E71) {
    if(isDefined(var_0B) && isDefined(var_0B.owner)) {
      if(level.teambased) {
        if(isDefined(var_0B.owner.team) && var_0B.owner.team != param_00.team) {
          var_0B dodamage(var_0B.health + 500000, var_0B.origin, param_00, param_00, "MOD_EXPLOSIVE", "v2_rocket_mp");
        }

        continue;
      }

      if(var_0B.owner != param_00) {
        var_0B dodamage(var_0B.health + 500000, var_0B.origin, param_00, param_00, "MOD_EXPLOSIVE", "v2_rocket_mp");
      }
    }
  }
}

func_A0D6() {
  level endon("game_ended");
  level endon("disconnect");
  level endon("nuke_cancelled");
  level endon("nuke_death");
  var_00 = level.var_6866 * 1000 + gettime();
  setomnvar("ui_nuke_end_milliseconds", var_00);
  level waittill("host_migration_begin");
  var_01 = maps\mp\gametypes\_hostmigration::func_A782();
  if(var_01 > 0) {
    setomnvar("ui_nuke_end_milliseconds", var_00 + var_01);
  }
}

func_3D58(param_00) {
  self endon("stop_monitoring_flash");
  self notify("flash_rumble_loop");
  self endon("flash_rumble_loop");
  var_01 = gettime() + param_00 * 1000;
  while(gettime() < var_01) {
    self playRumbleOnEntity("damage_heavy");
    wait 0.05;
  }
}

applyv2flash(param_00, param_01) {
  if(!isDefined(self.var_3D46) || param_00 > self.var_3D46) {
    self.var_3D46 = param_00;
  }

  if(!isDefined(self.var_3D57) || param_01 > self.var_3D57) {
    self.var_3D57 = param_01;
  }

  wait 0.05;
  if(isDefined(self.var_3D46)) {
    self shellshock("flashbang_mp", self.var_3D46);
    self.flashendtime = gettime() + self.var_3D46 * 1000;
    thread maps\mp\_utility::func_5D22("flashed", 0.05, 0.1, 0.55);
  }

  if(isDefined(self.var_3D57)) {
    thread func_3D58(self.var_3D57);
  }

  self.var_3D46 = undefined;
  self.var_3D57 = undefined;
}