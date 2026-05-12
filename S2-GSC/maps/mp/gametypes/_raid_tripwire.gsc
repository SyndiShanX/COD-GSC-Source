/************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_raid_tripwire.gsc
************************************************/

runtripwirelogic() {
  setdvarifuninitialized("wall_test_debug", "0");
  level.tripwireplantedmodels = [];
  runtripwirefx();
  level.var_5A61["tripwire"] = ::tripwire_killstreak_helper;
  level.var_5A7D["war_tripwire_mp"] = "tripwire";
  setdvarifuninitialized("scorestreak_enabled_tripwire", 1);
  thread tripwire_preget_animation_distance();
}

runtripwirefx() {
  level.var_0611["trip_wire_exposion"] = loadfx("vfx/explosion/frag_grenade_concrete");
  level.var_0611["trip_wire_dust_on_bomb_plant"] = loadfx("vfx/weaponimpact/large_dirt_1");
}

watch_allow_fire() {
  self endon("placed_tripwire");
  common_scripts\utility::func_A70C(level, "runBomberObjective", self, "kill_player_reticle_think", self, "death", self, "disconnect", self, "weapon_change");
  thread enable_fire();
}

disable_fire() {
  self method_812B(0);
}

enable_fire() {
  self method_812B(1);
}

tripwire_preget_animation_distance() {
  var_00 = (0, 0, 0);
  var_01 = spawn("script_model", var_00);
  var_01 setModel("prop_hus_tripwire_01_sheen_blue");
  var_01 method_805C();
  var_01 notsolid();
  var_02 = spawn("script_model", var_00);
  var_02 setModel("tripwire_standing");
  var_02 method_805C();
  var_02 notsolid();
  var_03 = spawn("script_model", var_00);
  var_03 setModel("tripwire_standing");
  var_03 method_805C();
  var_03 notsolid();
  var_02 scriptmodelplayanim("tripwire_standin_anim", "wire", 0, 0.01);
  var_02 scriptmodelpauseanim(1);
  var_03 scriptmodelplayanim("tripwire_standin_anim", "wire", 1, 1);
  var_04 = 3.333333;
  wait(var_04);
  var_05 = var_02 gettagorigin("spike");
  var_06 = var_03 gettagorigin("spike");
  var_01 delete();
  var_02 delete();
  var_03 delete();
  level.raydistance = distance(var_06, var_05);
}

check_wall_under_player_reticle_think(param_00, param_01) {
  var_02 = undefined;
  var_03 = level.raydistance;
  level endon("runBomberObjective");
  level endon("game_ended");
  self endon("kill_player_reticle_think");
  self endon("death");
  self endon("disconnect");
  self endon("weapon_change");
  var_04 = (10.9, 0, 0);
  param_01 method_805C();
  thread watch_allow_fire();
  thread watch_tripwire_preview_cleanup(param_00, param_01);
  var_05 = (0, 0, 0);
  var_06 = (0, 0, 0);
  var_07 = (0, 0, 0);
  var_08 = (0, 0, 0);
  var_09 = (0, 0, 0);
  var_0A = (0, 0, 0);
  var_0B = 0;
  for(;;) {
    var_0C = get_average_surface_normal_under_player_reticle(192);
    var_0D = var_0C[0];
    var_0E = var_0C[1];
    if(!self issprinting() && !self method_83B8()) {
      if(is_normal_a_wall(var_0D, var_0E, 20)) {
        param_00 showtoclient(self);
        if(param_00.var_0106 != "prop_hus_tripwire_01_sheen_blue") {
          param_00 setModel("prop_hus_tripwire_01_sheen_blue");
        }

        param_01 showtoclient(self);
        param_00.var_001D = combineangles(vectortoangles(var_0D), (0, 0, 0));
        param_00.var_0116 = var_0E;
        var_0F = rotatevector(var_04, param_00.var_001D);
        var_02 = param_00.var_0116 + var_0F;
        param_01.var_001D = (0, param_00.var_001D[1], param_00.var_001D[2]);
        if(0) {
          param_01.var_0116 = var_02;
        } else if(param_00.var_001D[0] != 0) {
          var_10 = (0, param_00.var_001D[1], 0);
          var_11 = rotatevector(var_04, var_10);
          var_12 = var_02 - var_11;
          param_01.var_0116 = var_12;
        } else {
          param_01.var_0116 = param_00.var_0116;
        }

        var_13 = undefined;
        var_14 = undefined;
        var_15 = 0;
        if(1) {
          var_16 = var_02 + (0, 0, -5);
          var_17 = bulletTrace(var_02, var_16, 0, self);
          if(var_17["fraction"] < 1) {
            var_15 = 1;
          }
        }

        if(!var_15) {
          var_18 = var_02 + var_0D * var_03;
          var_18 = (var_18[0], var_18[1], var_02[2]);
          var_13 = bulletTrace(var_02, var_18, 0, self);
          var_14 = var_13["position"] - var_02;
          var_14 = sqrt(squared(var_14[0]) + squared(var_14[1]));
        }

        if(!var_15 && isDefined(var_13["surfacetype"]) && var_13["surfacetype"] != "none" && var_14 > 30) {
          thread enable_fire();
          var_14 = var_14 - 4;
          var_19 = var_14 / var_03;
          var_1A = 3.333333;
          var_1B = var_19 * var_1A;
          param_01 scriptmodelplayanim("tripwire_standin_anim", "wire", var_1B, 0.01);
          param_01 scriptmodelpauseanim(1);
          var_05 = param_00.var_0116;
          var_06 = param_00.var_001D;
          var_07 = param_01.var_0116;
          var_08 = param_01.var_001D;
          var_09 = var_13["position"];
          var_0A = var_02;
          var_0B = var_1B;
        } else {
          thread disable_fire();
          if(param_00.var_0106 != "prop_hus_tripwire_01_sheen_red") {
            param_00 setModel("prop_hus_tripwire_01_sheen_red");
          }

          param_01 scriptmodelplayanim("tripwire_standin_anim", "wire", 0, 0.01);
          param_01 scriptmodelpauseanim(1);
          param_01 hidefromclient(self);
        }
      } else {
        thread disable_fire();
        var_04 hidefromclient(self);
        var_05 hidefromclient(self);
      }
    } else {
      thread disable_fire();
      var_04 hidefromclient(self);
      var_05 hidefromclient(self);
    }

    if(self method_8127() && !self method_8128()) {
      thread enable_fire();
      self notify("placed_tripwire");
      var_04 showtoclient(self);
      if(var_04.var_0106 != "prop_hus_tripwire_01_sheen_blue") {
        var_04 setModel("prop_hus_tripwire_01_sheen_blue");
      }

      var_05 showtoclient(self);
      var_05 scriptmodelplayanim("tripwire_standin_anim", "wire", var_0F, 0.01);
      var_05 scriptmodelpauseanim(1);
      var_04.var_0116 = var_09;
      var_04.var_001D = var_0A;
      var_05.var_0116 = var_0B;
      var_05.var_001D = var_0C;
      return [var_0E, var_0D, var_0F];
    }

    wait 0.05;
  }
}

watch_tripwire_preview_cleanup(param_00, param_01) {
  self endon("placed_tripwire");
  common_scripts\utility::func_A70C(level, "runBomberObjective", self, "death", self, "disconnect", self, "weapon_change");
  self.has_tripwire = 0;
  tripwire_cleanup(param_00, param_01, undefined);
}

watch_tripwire_placing_cleanup(param_00, param_01) {
  self endon("placed_tripwire_complete");
  common_scripts\utility::func_A70C(level, "runBomberObjective", self, "death", self, "disconnect");
  self.has_tripwire = 0;
  tripwire_cleanup(param_00, param_01, undefined);
}

is_normal_a_wall(param_00, param_01, param_02) {
  if(!isDefined(param_00)) {
    return 0;
  }

  var_03 = 0;
  var_04 = asin(vectornormalize(param_00)[2]);
  if(var_04 > param_02 || var_04 < -1 * param_02) {
    var_03 = 0;
  } else {
    var_03 = 1;
  }

  return var_03;
}

get_average_surface_normal_under_player_reticle(param_00) {
  var_01 = self getEye();
  var_02 = anglesToForward(self geteyeangles());
  var_03 = var_01 + var_02 * param_00;
  var_04 = bullet_trace_for_wall_test(var_01, var_03, self);
  if(var_04["fraction"] < 1) {
    var_05 = get_average_surface_normal_at_point(var_04["position"], var_02, var_04["normal"]);
    return [var_05, var_04["position"]];
  }

  return [undefined, var_04["position"]];
}

get_average_surface_normal_from_direction(param_00, param_01, param_02) {
  param_01 = anglesToForward(param_01);
  param_01 = param_01 + (0, -90, 0);
  var_03 = param_00 + param_01 * param_02;
  var_04 = bullet_trace_for_wall_test(param_00, var_03, self);
  if(var_04["fraction"] < 1) {
    var_05 = get_average_surface_normal_at_point(var_04["position"], param_01, var_04["normal"]);
    return [var_05, var_04["position"]];
  }

  return [undefined, var_04["position"]];
}

bullet_trace_for_wall_test(param_00, param_01, param_02) {
  return bulletTrace(param_00, param_01, 0, param_02, 0, 0, 0, 0, 1, 0, 0);
}

bullet_trace_for_wall_test_passed(param_00, param_01, param_02) {
  var_03 = bullet_trace_for_wall_test(param_00, param_01, param_02);
  if(var_03["fraction"] < 1) {
    return 0;
  }

  return 1;
}

get_average_surface_normal_at_point(param_00, param_01, param_02) {
  if(getdvarint("wall_test_debug") > 0) {}

  var_03 = undefined;
  var_04 = undefined;
  var_05 = undefined;
  var_06 = [];
  var_07 = [];
  var_08 = [];
  var_05 = param_02 * -1;
  var_03 = (0, 0, 1);
  var_04 = vectorcross(var_03, param_02);
  var_09 = param_00 + var_04 + var_03 * 5;
  var_0A = 10;
  var_0B = 10;
  for(var_0C = 0; var_0C <= var_0A; var_0C++) {
    var_0D = var_0C * 1;
    for(var_0E = 0; var_0E <= var_0B; var_0E++) {
      var_0F = var_0E * 1;
      var_10 = var_04 * var_0D + var_03 * var_0F;
      var_11 = var_09 - var_10;
      var_06[var_0C][var_0E] = var_11 - var_05 * 15;
      var_07[var_0C][var_0E] = var_11 + var_05 * 10;
    }
  }

  for(var_0C = 0; var_0C <= var_0A; var_0C++) {
    var_08[var_0C] = [];
    for(var_0E = 0; var_0E <= var_0B; var_0E++) {
      var_12 = undefined;
      var_13 = undefined;
      var_14 = var_06[var_0C][var_0E];
      var_15 = var_07[var_0C][var_0E];
      var_16 = bullet_trace_for_wall_test(var_14, var_15, self);
      if(var_16["fraction"] < 1) {
        var_12 = var_16["position"];
        var_13 = var_16["normal"];
      }

      if(isDefined(var_12)) {
        var_08[var_0C][var_0E] = var_13;
      }
    }
  }

  var_19 = 0;
  var_1A = (0, 0, 0);
  for(var_0C = 0; var_0C <= var_0A; var_0C++) {
    for(var_0E = 0; var_0E <= var_0B; var_0E++) {
      if(isDefined(var_08[var_0C][var_0E])) {
        var_1A = var_1A + var_08[var_0C][var_0E];
        var_19++;
      }
    }
  }

  var_1B = undefined;
  if(var_19 > 0) {
    var_1B = var_1A / var_19;
  }

  return var_1B;
}

tripwire_killstreak_helper(param_00) {
  var_01 = tripwire_place_anywhere_handler(param_00);
  if(!isDefined(var_01)) {
    return 0;
  }

  return var_01;
}

tripwire_place_anywhere_handler(param_00) {
  level endon("runBomberObjective");
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("weapon_change");
  if(common_scripts\utility::func_562E(self.has_tripwire)) {
    return 0;
  }

  var_01 = spawn("script_model", (0, 0, 0));
  var_01 setModel("prop_hus_tripwire_01_sheen_blue");
  var_01 method_805C();
  var_01 showtoclient(self);
  var_01 notsolid();
  var_02 = spawn("script_model", (0, 0, 0));
  var_02 setModel("tripwire_standing_sheen_blue");
  var_02 notsolid();
  var_02 method_805C();
  var_03 = check_wall_under_player_reticle_think(var_01, var_02);
  var_04 = var_03[2];
  var_05 = var_03[1] - var_03[0];
  var_06 = vectornormalize(var_05);
  var_01.hitdir = var_05;
  var_01.startpoint = var_03[0];
  self notify("kill_player_reticle_think");
  thread watch_tripwire_placing_cleanup(var_01, var_02);
  wait(0.3);
  if(1) {
    var_02 scriptmodelclearanim();
    wait 0.05;
  }

  var_01 solid();
  var_01 setModel("prop_hus_tripwire_01_no_wire");
  var_02 setModel("tripwire_standing");
  var_01 method_805B();
  var_02 method_805B();
  wait(0.03);
  playFXOnTag(level.var_0611["trip_wire_dust_on_bomb_plant"], var_01, "TAG_ORIGIN");
  var_07 = lib_0380::func_6842("mp_war_tripwire_impact", undefined, var_01.var_0116);
  if(1) {
    var_02 scriptmodelplayanim("tripwire_plant_anim", "wire", 0, 1);
    var_08 = 0.7;
    wait(var_08 * 0.5);
    var_09 = 0.05;
    var_0A = var_04 - var_09;
    var_02 scriptmodelplayanim("tripwire_idle_anim", "wire", var_0A, 0.01, 0);
    wait(var_09);
  }

  var_0B = var_03[1];
  var_0B = var_0B + (0, 0, -3);
  var_0C = 2;
  var_02.spikestart = var_0B - var_0C * var_06;
  var_02.spikeend = var_0B + var_0C * var_06;
  magicbullet("war_tripwire_impact_fx_mp", var_02.spikestart, var_02.spikeend, self);
  if(1) {
    var_02 scriptmodelclearanim();
    wait 0.05;
    var_02 scriptmodelplayanim("tripwire_idle_anim", "wire", var_04, 0.01, 0);
    var_02 scriptmodelpauseanim(1);
  }

  var_0D = lib_0380::func_6842("mp_war_tripwire_plant", undefined, var_02.var_0116);
  thread tripwire_place_anywhere_placed_handler(var_03, var_01, var_02);
  return 1;
}

tripwire_place_anywhere_placed_handler(param_00, param_01, param_02) {
  level endon("game_ended");
  level endon("runBomberObjective");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  param_01 endon("tripwire_defused");
  self notify("kill_player_reticle_think");
  self notify("placed_tripwire_complete");
  var_03 = param_00[0] - param_00[1];
  var_04 = vectornormalize(var_03);
  var_05 = length(var_03);
  var_06 = spawn("trigger_box", param_00[0], 0, (2, 2, var_05));
  var_07 = var_04 * -1;
  var_08 = (0, 0, 1);
  var_09 = vectorcross(var_08, var_07);
  var_0A = axistoangles(var_08, var_09, var_07);
  var_06.var_001D = var_0A;
  param_01.var_9D65 = var_06;
  level.tripwireplantedmodels = common_scripts\utility::func_0F6F(level.tripwireplantedmodels, param_01);
  param_01 thread setuptripwirekillcament(param_01);
  thread tripwire_spawn_damage_trigger(param_01);
  thread tripwire_trigger_wire(param_01, var_06);
  thread tripwire_watch_delete(param_01, param_02, var_06);
  thread tripwire_disarm(param_01);
  thread tripwire_monitor_placed_location(param_01, param_02);
  if(isDefined(self.has_tripwire)) {
    self.has_tripwire = 0;
  }

  param_01 waittill("tripwire_triggered", var_0B);
  if(var_0B == "player") {
    lib_0380::func_6842("mp_wpn_betty_triggered", undefined, param_01.var_0116);
    wait(0.1);
    tripwire_detonate(param_01);
    return;
  }

  tripwire_detonate(param_01);
}

tripwire_trigger_wire(param_00, param_01) {
  level endon("game_ended");
  level endon("runBomberObjective");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  param_00 endon("tripwire_defused");
  param_00 endon("tripwire_triggered");
  var_02 = self;
  var_03 = var_02.var_01A7;
  if(!isDefined(var_03)) {
    var_03 = "none";
  }

  while((!isDefined(var_02) && !isDefined(var_02.var_01A7)) || (isDefined(var_02) && !isstring(var_02) && isDefined(var_02.var_01A7) && var_02.var_01A7 == var_03) || isstring(var_02) && var_02 != "explode") {
    param_01 waittill("trigger", var_02);
  }

  param_00 notify("tripwire_triggered", "player");
}

tripwire_monitor_placed_location(param_00, param_01) {
  level endon("game_ended");
  level endon("runBomberObjective");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  param_00 endon("tripwire_defused");
  param_00 endon("tripwire_triggered");
  waittillframeend;
  var_02 = anglesToForward(param_00.var_001D);
  var_03 = vectornormalize(var_02);
  var_04 = param_00.var_0116 + 2 * var_03;
  var_05 = param_00.var_0116 - 2 * var_03;
  while(isDefined(param_00)) {
    if(bullet_trace_for_wall_test_passed(var_04, var_05, param_00) || bullet_trace_for_wall_test_passed(param_01.spikestart, param_01.spikeend, param_01)) {
      param_00 notify("tripwire_triggered", "wall_destroyed");
      return;
    }

    wait 0.05;
  }
}

disarm_enable_use_watcher(param_00) {
  level endon("game_ended");
  level endon("runBomberObjective");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  param_00 endon("tripwire_triggered");
  param_00 endon("tripwire_defused");
  param_00 endon("tripwire_delete");
  var_01 = self.var_01A7;
  foreach(var_03 in level.var_744A) {
    if(isDefined(level.var_3FDC) && level.var_3FDC == "infect") {
      param_00 disableplayeruse(var_03);
      continue;
    }

    if(var_03.var_01A7 == var_01 || var_03.var_01A7 == "spectator") {
      param_00 disableplayeruse(var_03);
      continue;
    }

    if(var_03.var_01A7 != var_01) {
      param_00 enableplayeruse(var_03);
    }
  }

  for(;;) {
    level waittill("joined_team", var_03);
    if(isDefined(level.var_3FDC) && level.var_3FDC == "infect") {
      param_00 disableplayeruse(var_03);
      continue;
    }

    if(var_03.var_01A7 == var_01 || var_03.var_01A7 == "spectator") {
      param_00 disableplayeruse(var_03);
      continue;
    }

    if(var_03.var_01A7 != var_01) {
      param_00 enableplayeruse(var_03);
    }
  }
}

tripwire_disarm(param_00) {
  level endon("game_ended");
  level endon("runBomberObjective");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  param_00 endon("tripwire_triggered");
  param_00 makeusable();
  param_00 sethintstring(&"RAIDS_TRIPWIRE_DISARM");
  thread disarm_enable_use_watcher(param_00);
  for(;;) {
    param_00 waittill("trigger", var_01);
    if(var_01.var_01A7 == self.var_01A7 && var_01.var_01A7 != "spectator") {
      continue;
    }

    param_00 notify("tripwire_defused");
    param_00 notify("tripwire_delete");
  }
}

tripwire_detonate(param_00) {
  param_00 entityradiusdamage(param_00.var_0116, 200, 200, 50, self, "MOD_EXPLOSIVE", "war_tripwire_mp");
  playFX(common_scripts\utility::func_44F5("trip_wire_exposion"), param_00.var_0116);
  lib_0380::func_6842("mp_war_bomb_explo", undefined, param_00.var_0116);
  param_00 notify("tripwire_delete");
}

tripwire_cleanup(param_00, param_01, param_02) {
  waittillframeend;
  if(isDefined(param_00)) {
    param_00 delete();
  }

  if(isDefined(param_01)) {
    param_01 delete();
  }

  if(isDefined(param_02)) {
    param_02 delete();
  }

  level.tripwireplantedmodels = common_scripts\utility::func_0FA0(level.tripwireplantedmodels);
}

tripwire_watch_delete(param_00, param_01, param_02) {
  common_scripts\utility::func_A70C(level, "game_ended", level, "runBomberObjective", self, "disconnect", self, "joined_team", self, "joined_spectators", param_00, "tripwire_delete");
  tripwire_cleanup(param_00, param_01, param_02);
}

tripwire_spawn_damage_trigger(param_00) {
  level endon("game_ended");
  level endon("runBomberObjective");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  param_00 endon("tripwire_defused");
  param_00 endon("tripwire_triggered");
  param_00 setCanDamage(1);
  param_00.var_00FB = 100000;
  param_00 setnormalhealth(self.var_00FB);
  param_00 waittill("damage");
  param_00 notify("tripwire_triggered", "damage");
}

setuptripwirekillcament(param_00) {
  var_01 = param_00.var_0116 + (0, 0, 5);
  var_02 = param_00.var_0116 + anglestoright(param_00.var_001D + (0, 90, 0)) * 2 + (0, 0, 15);
  var_03 = bulletTrace(var_01, var_02, 0, param_00);
  var_04 = spawn("script_model", var_03["position"]);
  var_04 setModel("tag_origin");
  var_05 = param_00.var_0116 - var_03["position"];
  var_04.var_001D = vectortoangles(var_05);
  var_04 setscriptmoverkillcam("explosive");
  self.var_5A2C = var_04;
}