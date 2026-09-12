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
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("r_reactiveMotionPlayerPushDecay", 0.9);
  setDvar("r_vertexDeformCutOffDist", 5000);
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
  var_0 = getEnt("infil_collision", "targetname");
  var_0 notsolid();
  waittillframeend();
  var_0 connectpaths();
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
  var_1 = getEnt("infil_door_left", "targetname");
  var_2 = getEnt("infil_door_right", "targetname");
  var_3 = getEnt("infil_door_chain", "targetname");
  var_1.animname = "gate_left";
  var_1 scripts\common\anim::setanimtree();
  var_2.animname = "gate_right";
  var_2 scripts\common\anim::setanimtree();
  var_1 thread scripts\common\anim::anim_single_solo(var_1, "open");
  var_2 thread scripts\common\anim::anim_single_solo(var_2, "open");
  var_3 hide();
  var_4 = getEnt("gate2Left", "targetname");
  var_5 = getEnt("gate2Right", "targetname");
  var_6 = getEntArray("gate2LeftBits", "targetname");

  foreach(var_8 in var_6) {
    var_8 linkTo(var_4);
  }

  var_10 = getEntArray("gate2RightBits", "targetname");

  foreach(var_8 in var_10) {
    var_8 linkTo(var_5);
  }

  var_4.heli_isleaving = var_4.origin;
  var_13 = scripts\engine\utility::getStruct("gate2LeftOpen", "targetname");
  var_4.ref_1212b = var_13.origin;
  var_5.heli_isleaving = var_5.origin;
  var_14 = scripts\engine\utility::getStruct("gate2RightOpen", "targetname");
  var_5.ref_1212b = var_14.origin;
  var_15 = 4;
  var_16 = 8;
  var_5 moveTo(var_5.ref_1212b, var_15, var_15 * 0.1, var_15 * 0.1);
  var_4 moveTo(var_4.ref_1212b, var_15, var_15 * 0.1, var_15 * 0.1);
  level waittill("prematch_countdown");
  var_0 solid();
  waittillframeend();
  var_0 disconnectPaths();
  var_1 thread scripts\common\anim::anim_single_solo(var_1, "close");
  var_2 thread scripts\common\anim::anim_single_solo(var_2, "close");
  GscBinSkip1(0x45, 0, "_left");
}

function lb_pitch_roll_dmg_threshold(var_0, var_1, var_2) {
  level endon("game_ended");
  wait 5;
  var_3 = getscriptablearray(var_0, "targetname");
  var_4 = getEnt(var_1, "targetname");
  var_5 = getEnt(var_2, "targetname");
  var_5 hide();

  if(isDefined(var_3) && isDefined(var_3[0])) {
    var_6 = var_3[0];
    var_7 = 1;

    while(var_7) {
      var_6 waittill("scriptableNotification", var_8, var_9);

      switch (var_8) {
        case "vehicle_death":
        case "onfire":
        case "flareup":
          var_7 = 0;
          var_5 show();
          var_4 hide();
          return;
        case "anim_explosion":
          var_7 = 0;
          var_5 show();
          var_4 hide();
          return;
      }
    }

    return;
  }
}

function battle_tracks_vehicleoccupancyenter() {
  var_0 = [];

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
        GscBinSkip0(0x2e, var_0.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_dd_spawn_attacker_start", (-389, -1455, 59), (0, 90, 0)));
      }

      break;
  }

  if(var_0.size > 0) {
    scripts\mp\spawnlogic::bdiedonce(var_0);
    return;
  }
}