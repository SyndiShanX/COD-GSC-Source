/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_hideout\mp_hideout.gsc
*****************************************************/

function main() {
  _start_rooftop_raid_exfil::keypad_check_levelinput();
  level.music_style = "middle_east";
  scripts\mp\maps\mp_hideout\mp_hideout_precache::main();
  scripts\mp\maps\mp_hideout\gen\mp_hideout_art::main();
  scripts\mp\maps\mp_hideout\mp_hideout_fx::main();
  scripts\mp\maps\mp_hideout\mp_hideout_lighting::main();
  scripts\mp\load::main();
  setDvar("mantle_force_legacy_system", 1);
  level thread scripts\engine\scriptable_door::system_init();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_hideout", "codcaster_compass_map_mp_hideout");
  setDvar("PKKMTTRQO", 8);
  setDvar("MTORLPNK", 0.9);
  setDvar("LTMPKRLLNM", 5000);
  thread lb_pitch_roll_dmg_threshold("destructibleSedan01", "destructibleSedan01_edges", "destructibleSedan01_edges_dst");
  thread lb_pitch_roll_dmg_threshold("destructibleSedan02", "destructibleSedan02_edges", "destructibleSedan02_edges_dst");
  thread lb_pitch_roll_dmg_threshold("destructibleDecho01", "destructibleDecho02_edges", "destructibleDecho02_edges_dst");
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  thread managegate();
  battle_tracks_vehicleoccupancyenter(level);
}

#using_animtree("");

function managegate() {
  var0 = getEnt("infil_collision", "targetname");
  var0 notsolid();
  waittillframeend();
  var0 connectpaths();
  level waittill("infil_setup_complete");

  if(!scripts\mp\flags::gameflag("infil_will_run")) {
    return;
  }

  scripts\mp\flags::gameflagwait("infil_started");
  level.scr_animtree["gate_left"] = #animtree;
  level.scr_anim["gate_left"]["close"] = $mp_trainyard_gatel_close;
  level.scr_animname["gate_left"]["close"] = "mp_trainyard_gateL_close";
  level.scr_anim["gate_left"]["open"] = % mp_trainyard_gatel_open;
  level.scr_animname["gate_left"]["open"] = "mp_trainyard_gateL_open";
  level.scr_animtree["gate_right"] = #animtree;
  level.scr_anim["gate_right"]["close"] = % mp_trainyard_gater_close;
  level.scr_animname["gate_right"]["close"] = "mp_trainyard_gateR_close";
  level.scr_anim["gate_right"]["open"] = % mp_trainyard_gater_open;
  level.scr_animname["gate_right"]["open"] = "mp_trainyard_gateR_open";
  var1 = getEnt("infil_door_left", "targetname");
  var2 = getEnt("infil_door_right", "targetname");
  var3 = getEnt("infil_door_chain", "targetname");
  var1.animname = "gate_left";
  var1 scripts\common\anim::setanimtree();
  var2.animname = "gate_right";
  var2 scripts\common\anim::setanimtree();
  var1 thread scripts\common\anim::anim_single_solo(var1, "open");
  var2 thread scripts\common\anim::anim_single_solo(var2, "open");
  var3 hide();
  var4 = getEnt("gate2Left", "targetname");
  var5 = getEnt("gate2Right", "targetname");
  var6 = getEntArray("gate2LeftBits", "targetname");

  foreach(var8 in var6) {
    var8 linkTo(var4);
  }

  var10 = getEntArray("gate2RightBits", "targetname");

  foreach(var8 in var10) {
    var8 linkTo(var5);
  }

  var4.heli_isleaving = var4.origin;
  var13 = scripts\engine\utility::getStruct("gate2LeftOpen", "targetname");
  var4.ref_1212b = var13.origin;
  var5.heli_isleaving = var5.origin;
  var14 = scripts\engine\utility::getStruct("gate2RightOpen", "targetname");
  var5.ref_1212b = var14.origin;
  var15 = 4;
  var16 = 8;
  var5 moveTo(var5.ref_1212b, var15, var15 * 0.1, var15 * 0.1);
  var4 moveTo(var4.ref_1212b, var15, var15 * 0.1, var15 * 0.1);
  level waittill("prematch_countdown");
  var0 solid();
  waittillframeend();
  var0 disconnectPaths();
  var1 thread scripts\common\anim::anim_single_solo(var1, "close");
  var2 thread scripts\common\anim::anim_single_solo(var2, "close");
  GscBinSkip1(0x45, 0, "_left");
}

function lb_pitch_roll_dmg_threshold(var0, var1, var2) {
  level endon("game_ended");
  wait 5;
  var3 = getscriptablearray(var0, "targetname");
  var4 = getEnt(var1, "targetname");
  var5 = getEnt(var2, "targetname");
  var5 hide();

  if(isDefined(var3) && isDefined(var3[0])) {
    var6 = var3[0];
    var7 = 1;

    while(var7) {
      var6 waittill("scriptableNotification", var8, var9);

      switch (var8) {
        case "vehicle_death":
        case "onfire":
        case "flareup":
          var7 = 0;
          var5 show();
          var4 hide();
          return;
        case "anim_explosion":
          var7 = 0;
          var5 show();
          var4 hide();
          return;
      }
    }

    return;
  }
}

function battle_tracks_vehicleoccupancyenter() {
  var0 = [];

  switch (scripts\mp\utility\game::getgametype()) {
    case "dd":
      if(isDefined(game["roundsPlayed"]) && game["roundsPlayed"] == 2) {
        level.modifiedspawnpoints["-415 -2239"]["mp_dd_spawn_attacker_start"]["remove"] = 1;
        level.modifiedspawnpoints["-391 -2191"]["mp_dd_spawn_attacker_start"]["remove"] = 1;
        level.modifiedspawnpoints["-353 -2239"]["mp_dd_spawn_attacker_start"]["remove"] = 1;
        level.modifiedspawnpoints["-329 -2191"]["mp_dd_spawn_attacker_start"]["remove"] = 1;
        level.modifiedspawnpoints["-289 -2239"]["mp_dd_spawn_attacker_start"]["remove"] = 1;
        level.modifiedspawnpoints["-265 -2191"]["mp_dd_spawn_attacker_start"]["remove"] = 1;
        level.modifiedspawnpoints["-225 -2239"]["mp_dd_spawn_attacker_start"]["remove"] = 1;
        level.modifiedspawnpoints["-201 -2191"]["mp_dd_spawn_attacker_start"]["remove"] = 1;
        level.modifiedspawnpoints["-161 -2239"]["mp_dd_spawn_attacker_start"]["remove"] = 1;
        level.modifiedspawnpoints["-137 -2191"]["mp_dd_spawn_attacker_start"]["remove"] = 1;
        GscBinSkip0(0x2e, var0.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_dd_spawn_attacker_start", (-389, -1455, 59), (0, 90, 0)));
      }

      break;
  }

  if(var0.size > 0) {
    scripts\mp\spawnlogic::bdiedonce(var0);
    return;
  }
}