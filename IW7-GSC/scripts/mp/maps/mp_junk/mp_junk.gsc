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
  var_0 = getent("grinderKillTrigger", "targetname");
  thread killtriggerloop(var_0);
  thread fix_collision();
  thread droptonavmeshtriggers();
  thread move_frontline_spawns();
  level.upsidedowntaunts = 1;
}

fix_collision() {
  var_0 = getent("player512x512x8", "targetname");
  var_1 = spawn("script_model", (1520, -76, 512));
  var_1.angles = (0, 0, 90);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = spawn("script_model", (-1880, -708, 24));
  var_2.angles = (0, 70, -90);
  var_2 setModel("mp_desert_uplink_col_01");
  var_3 = spawn("script_model", (-1410, 36, 4));
  var_3.angles = (0, 285, 0);
  var_3 setModel("mp_junk_nosight_01");
  var_4 = spawn("script_model", (-726, 608, 28));
  var_4.angles = (0, 0, 0);
  var_4 setModel("mp_junk_nosight_01");
  var_5 = spawn("script_model", (1024, -512, 0));
  var_5.angles = (0, 0, 0);
  var_5 setModel("mp_junk_nosight_02");
  var_6 = spawn("script_model", (-1382, -2238, 52));
  var_6.angles = (270, 0, -58);
  var_6 setModel("mp_junk_nosight_01");
  var_7 = spawn("script_model", (700, 1368, -80));
  var_7.angles = (0, 270, 90);
  var_7 setModel("mp_rivet_missile_patch_01");
  var_8 = getent("player512x512x8", "targetname");
  var_9 = spawn("script_model", (-804, 1072, 576));
  var_9.angles = (88, 135, 0);
  var_9 clonebrushmodeltoscriptmodel(var_8);
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

func_CDA4(var_0) {
  wait(30);
  playcinematicforalllooping(var_0);
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
    level waittill("connected", var_0);
    var_0 thread on_spawn();
    var_0 thread flip_watch();
  }
}

setupmagnets(var_0) {
  var_1 = getEntArray(var_0, "targetname");
  foreach(var_3 in var_1) {
    var_3.upref = getent(var_3.target, "targetname");
    var_3.var_127BE = [];
    thread magwatch(var_3);
  }
}

magwatch(var_0) {
  level endon("game_ended");
  for(;;) {
    var_0 waittill("trigger", var_1);
    var_2 = var_1 getentitynumber();
    if(!isDefined(var_0.var_127BE[var_2])) {
      var_0.var_127BE[var_2] = var_1;
      thread magupvector(var_0, var_2, var_1);
    }
  }
}

magupvector(var_0, var_1, var_2) {
  var_3 = spawn("script_model", var_2.origin);
  var_3.angles = var_2.angles;
  var_3 setModel("tag_origin");
  var_2 playerlinkto(var_3, "tag_origin", 0, 180, 180, 180, 180, 0);
  var_3 moveto(var_0.upref.origin + (0, 0, -72), 1, 0.75, 0);
  var_3 rotateroll(180, 1, 0.9, 0);
  wait(1);
  var_2 unlink();
  var_2 setworldupreference(var_0.upref);
  var_2 playrumbleonentity("damage_heavy");
  var_3 delete();
  while(isDefined(var_2) && isalive(var_2) && var_2 istouching(var_0)) {
    scripts\engine\utility::waitframe();
  }

  if(isDefined(var_2) && isalive(var_2)) {
    var_4 = var_2 getvelocity();
    var_3 = spawn("script_model", var_2.origin);
    var_3.angles = var_2.angles + (0, 0, 180);
    var_3 setModel("tag_origin");
    var_2 playerlinkto(var_3, "tag_origin", 0, 180, 180, 180, 180, 0);
    var_3 moveto(var_2.origin + (0, 0, -74), 0.5, 0.1, 0);
    var_3 rotateroll(-180, 0.5, 0, 0.4);
    wait(0.5);
    var_2 unlink();
    var_3 delete();
    var_2 setworldupreference(undefined);
    var_2 setvelocity(var_4);
  }

  wait(2);
  var_0.var_127BE[var_1] = undefined;
}

apex_not_outofbounds() {
  level.outofboundstriggerpatches = [];
  var_0 = getent("apex_unoutofbounds", "targetname");
  level.outofboundstriggerpatches[level.outofboundstriggerpatches.size] = var_0;
  level waittill("game_ended");
  foreach(var_0 in level.outofboundstriggerpatches) {
    if(isDefined(var_0)) {
      var_0 delete();
    }
  }
}

killtriggerloop(var_0) {
  level endon("game_ended");
  for(;;) {
    var_0 waittill("trigger", var_1);
    if(isDefined(var_1)) {
      if(isplayer(var_1)) {
        var_1 suicide();
        var_2 = var_1 _meth_8113();
        var_2 hide(1);
        var_2.permanentcustommovetransition = 1;
        if(var_1.loadoutarchetype == "archetype_scout") {
          playFX(level._effect["reaper_kill_robot"], var_1.origin + (0, 0, 12));
        } else {
          playFX(level._effect["grinder_kill"], var_1.origin + (0, 0, 12));
        }

        continue;
      }

      if(isDefined(var_1.classname) && var_1.classname == "script_vehicle") {
        if(isDefined(var_1.streakname)) {
          if(var_1.streakname == "minijackal") {
            var_1 notify("minijackal_end");
            continue;
          }

          if(var_1.streakname == "venom") {
            var_1 notify("venom_end", var_1.origin);
          }
        }
      }
    }
  }
}

droptonavmeshtriggers() {
  wait(1);
  var_0 = spawn("trigger_radius", (256, 800, 16), 0, 256, 500);
  var_0 hide();
  level.droptonavmeshtriggers[level.droptonavmeshtriggers.size] = var_0;
}

move_frontline_spawns() {
  if(level.gametype == "front") {
    wait(1);
    var_0 = scripts\mp\spawnlogic::getspawnpointarray("mp_front_spawn_axis");
    foreach(var_2 in var_0) {
      if(distance(var_2.origin, (-1664, -2368, 32)) < 10) {
        var_2.origin = (-1664, -2368, 40);
      }

      if(distance(var_2.origin, (-1136, -1376, 32)) < 10) {
        var_2.origin = (-1136, -1376, 40);
      }
    }
  }
}