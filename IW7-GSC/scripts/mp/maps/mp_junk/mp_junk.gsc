/***********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_junk\mp_junk.gsc
***********************************************/

main() {
  scripts\mp\maps\mp_junk\mp_junk_precache::main();
  scripts\mp\maps\mp_junk\gen\mp_junk_art::main();
  scripts\mp\maps\mp_junk\mp_junk_fx::main();
  scripts\mp\load::main();
  scripts\mp\compass::setupminimap("compass_map_mp_junk");
  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);
  setdvar("r_umbraMinObjectContribution", 8);
  setdvar("r_umbraAccurateOcclusionThreshold", 1024);
  setdvar("r_tessellationFactor", 40);
  setdvar("r_tessellationCutoffFalloff", 256);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level.var_C7B3 = getEntArray("OutOfBounds", "targetname");
  thread apex_not_outofbounds();
  thread on_connect();
  thread func_CDA4("mp_junk_screens");
  level._effect["grinder_kill"] = loadfx("vfx\iw7\levels\mp_junk\vfx_body_exp.vfx");
  var_00 = getent("grinderKillTrigger", "targetname");
  thread killtriggerloop(var_00);
  thread fix_collision();
  thread droptonavmeshtriggers();
  thread move_frontline_spawns();
  level.upsidedowntaunts = 1;
}

fix_collision() {
  var_00 = getent("player512x512x8", "targetname");
  var_01 = spawn("script_model", (1520, -76, 512));
  var_01.angles = (0, 0, 90);
  var_01 clonebrushmodeltoscriptmodel(var_00);
  var_02 = spawn("script_model", (-1880, -708, 24));
  var_02.angles = (0, 70, -90);
  var_02 setModel("mp_desert_uplink_col_01");
  var_03 = spawn("script_model", (-1410, 36, 4));
  var_03.angles = (0, 285, 0);
  var_03 setModel("mp_junk_nosight_01");
  var_04 = spawn("script_model", (-726, 608, 28));
  var_04.angles = (0, 0, 0);
  var_04 setModel("mp_junk_nosight_01");
  var_05 = spawn("script_model", (1024, -512, 0));
  var_05.angles = (0, 0, 0);
  var_05 setModel("mp_junk_nosight_02");
  var_06 = spawn("script_model", (-1382, -2238, 52));
  var_06.angles = (270, 0, -58);
  var_06 setModel("mp_junk_nosight_01");
  var_07 = spawn("script_model", (700, 1368, -80));
  var_07.angles = (0, 270, 90);
  var_07 setModel("mp_rivet_missile_patch_01");
  var_08 = getent("player512x512x8", "targetname");
  var_09 = spawn("script_model", (-804, 1072, 576));
  var_09.angles = (88, 135, 0);
  var_09 clonebrushmodeltoscriptmodel(var_08);
  var_0A = getent("player64x64x256", "targetname");
  var_0B = spawn("script_model", (208, -1248, 512));
  var_0B.angles = (0, 50, 0);
  var_0B clonebrushmodeltoscriptmodel(var_0A);
  var_0C = spawn("script_model", (208, -1248, 256));
  var_0C.angles = (0, 50, 0);
  var_0C clonebrushmodeltoscriptmodel(var_0A);
  var_0D = getent("player64x64x256", "targetname");
  var_0E = spawn("script_model", (208, -1248, 192));
  var_0E.angles = (0, 50, 0);
  var_0E clonebrushmodeltoscriptmodel(var_0D);
  var_0F = getent("player512x512x8", "targetname");
  var_10 = spawn("script_model", (-607, 1267, 576));
  var_10.angles = (89.5, 135, 0);
  var_10 clonebrushmodeltoscriptmodel(var_0F);
  var_11 = getent("player512x512x8", "targetname");
  var_12 = spawn("script_model", (-2194, -2328, 576));
  var_12.angles = (270, 0, 0);
  var_12 clonebrushmodeltoscriptmodel(var_11);
  var_13 = getent("player512x512x8", "targetname");
  var_14 = spawn("script_model", (-2194, -1816, 576));
  var_14.angles = (270, 0, 0);
  var_14 clonebrushmodeltoscriptmodel(var_13);
}

func_CDA4(param_00) {
  wait(30);
  playcinematicforalllooping(param_00);
}

on_spawn() {
  for(;;) {
    self waittill("spawned_player");
    wait(0.05);
    self enableworldup(1);
  }
}

flip_watch() {
  self endon("death");
  for(;;) {
    self waittill("world_up_flip");
    self playSound("mp_junk_magnet_use");
  }
}

on_connect() {
  for(;;) {
    level waittill("connected", var_00);
    var_00 thread on_spawn();
    var_00 thread flip_watch();
  }
}

setupmagnets(param_00) {
  var_01 = getEntArray(param_00, "targetname");
  foreach(var_03 in var_01) {
    var_03.upref = getent(var_03.target, "targetname");
    var_03.var_127BE = [];
    thread magwatch(var_03);
  }
}

magwatch(param_00) {
  level endon("game_ended");
  for(;;) {
    param_00 waittill("trigger", var_01);
    var_02 = var_01 getentitynumber();
    if(!isDefined(param_00.var_127BE[var_02])) {
      param_00.var_127BE[var_02] = var_01;
      thread magupvector(param_00, var_02, var_01);
    }
  }
}

magupvector(param_00, param_01, param_02) {
  var_03 = spawn("script_model", param_02.origin);
  var_03.angles = param_02.angles;
  var_03 setModel("tag_origin");
  param_02 playerlinkto(var_03, "tag_origin", 0, 180, 180, 180, 180, 0);
  var_03 moveto(param_00.upref.origin + (0, 0, -72), 1, 0.75, 0);
  var_03 rotateroll(180, 1, 0.9, 0);
  wait(1);
  param_02 unlink();
  param_02 setworldupreference(param_00.upref);
  param_02 playrumbleonentity("damage_heavy");
  var_03 delete();
  while(isDefined(param_02) && isalive(param_02) && param_02 istouching(param_00)) {
    scripts\engine\utility::waitframe();
  }

  if(isDefined(param_02) && isalive(param_02)) {
    var_04 = param_02 getvelocity();
    var_03 = spawn("script_model", param_02.origin);
    var_03.angles = param_02.angles + (0, 0, 180);
    var_03 setModel("tag_origin");
    param_02 playerlinkto(var_03, "tag_origin", 0, 180, 180, 180, 180, 0);
    var_03 moveto(param_02.origin + (0, 0, -74), 0.5, 0.1, 0);
    var_03 rotateroll(-180, 0.5, 0, 0.4);
    wait(0.5);
    param_02 unlink();
    var_03 delete();
    param_02 setworldupreference(undefined);
    param_02 setvelocity(var_04);
  }

  wait(2);
  param_00.var_127BE[param_01] = undefined;
}

apex_not_outofbounds() {
  level.outofboundstriggerpatches = [];
  var_00 = getent("apex_unoutofbounds", "targetname");
  level.outofboundstriggerpatches[level.outofboundstriggerpatches.size] = var_00;
  level waittill("game_ended");
  foreach(var_00 in level.outofboundstriggerpatches) {
    if(isDefined(var_00)) {
      var_00 delete();
    }
  }
}

killtriggerloop(param_00) {
  level endon("game_ended");
  for(;;) {
    param_00 waittill("trigger", var_01);
    if(isDefined(var_01)) {
      if(isplayer(var_01)) {
        var_01 suicide();
        var_02 = var_01 _meth_8113();
        var_02 hide(1);
        var_02.permanentcustommovetransition = 1;
        if(var_01.loadoutarchetype == "archetype_scout") {
          playFX(level._effect["reaper_kill_robot"], var_01.origin + (0, 0, 12));
        } else {
          playFX(level._effect["grinder_kill"], var_01.origin + (0, 0, 12));
        }

        continue;
      }

      if(isDefined(var_01.classname) && var_01.classname == "script_vehicle") {
        if(isDefined(var_01.streakname)) {
          if(var_01.streakname == "minijackal") {
            var_01 notify("minijackal_end");
            continue;
          }

          if(var_01.streakname == "venom") {
            var_01 notify("venom_end", var_01.origin);
          }
        }
      }
    }
  }
}

droptonavmeshtriggers() {
  wait(1);
  var_00 = spawn("trigger_radius", (256, 800, 16), 0, 256, 500);
  var_00 hide();
  level.droptonavmeshtriggers[level.droptonavmeshtriggers.size] = var_00;
}

move_frontline_spawns() {
  if(level.gametype == "front") {
    wait(1);
    var_00 = scripts\mp\spawnlogic::getspawnpointarray("mp_front_spawn_axis");
    foreach(var_02 in var_00) {
      if(distance(var_02.origin, (-1664, -2368, 32)) < 10) {
        var_02.origin = (-1664, -2368, 40);
      }

      if(distance(var_02.origin, (-1136, -1376, 32)) < 10) {
        var_02.origin = (-1136, -1376, 40);
      }
    }
  }
}