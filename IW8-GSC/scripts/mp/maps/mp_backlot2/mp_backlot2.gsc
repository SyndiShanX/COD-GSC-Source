/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_backlot2\mp_backlot2.gsc
*******************************************************/

function main() {
  _questtimerwait::keypad_check_levelinput();
  scripts\mp\maps\mp_backlot2\mp_backlot2_precache::main();
  scripts\mp\maps\mp_backlot2\gen\mp_backlot2_art::main();
  scripts\mp\maps\mp_backlot2\mp_backlot2_fx::main();
  scripts\mp\maps\mp_backlot2\mp_backlot2_lighting::main();
  scripts\mp\load::main();
  level thread scripts\engine\scriptable_door::system_init();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_backlot2", "codcaster_compass_map_mp_backlot2");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  setDvar("r_umbraAccurateOcclusionThreshold", 512);
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("r_tessellationFactor", 30);
  setDvar("r_tessellationCutoffFalloff", 256);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  var_0 = getEnt("infil_van_col", "targetname");

  if(isDefined(var_0)) {
    var_0 hide();
    var_0 connectpaths();
  }

  thread managegate();
  thread spawnstaticvan();
  level.music_style = "middle_east";
  ref_12C23(level);
  battle_tracks_vehicleoccupancyenter(level);
  thread player_exfil_struct();
}

#using_animtree("");

function managegate() {
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
  var_0 = getEnt("infil_door_left", "targetname");
  var_1 = getEnt("infil_door_right", "targetname");
  var_2 = getEnt("infil_door_chain", "targetname");
  var_0.animname = "gate_left";
  var_0 scripts\common\anim::setanimtree();
  var_1.animname = "gate_right";
  var_1 scripts\common\anim::setanimtree();
  var_0 thread scripts\common\anim::anim_single_solo(var_0, "open");
  var_1 thread scripts\common\anim::anim_single_solo(var_1, "open");
  var_2 hide();
  level waittill("prematch_countdown");
  var_0 thread scripts\common\anim::anim_single_solo(var_0, "close");
  var_1 thread scripts\common\anim::anim_single_solo(var_1, "close");
  GscBinSkip1(0x45, 0, "_left");
}

function spawnstaticvan() {
  level waittill("infil_setup_complete");

  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("infil", "get_all_infils")) {
    return;
  }

  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("infil", "spawnPersistentVan")) {
    return;
  }

  if(!scripts\mp\flags::gameflag("infil_will_run")) {
    foreach(var_1 in [[scripts\cp_mp\utility\script_utility::getsharedfunc("infil", "get_all_infils")]]()) {
      if(var_1.script_noteworthy != "infil_van_hackney") {
        continue;
      }

      if(var_1.name != "alpha") {
        continue;
      }

      game["infil"]["types"]["infil_van_hackney"]["alpha"]["vehicleOrg"] = (-128, 2241, 60);
      game["infil"]["types"]["infil_van_hackney"]["alpha"]["vehicleAng"] = (0, 90, 0);
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("infil", "spawnPersistentVan")]]("infil_van_hackney", "alpha");
      break;
    }

    return;
  }
}

function ref_12C23() {
  level.modifiedspawnpoints["1896 624"]["mp_dm_spawn"]["remove"] = 1;
}

function battle_tracks_vehicleoccupancyenter() {
  var_0 = [];

  switch (scripts\mp\utility\game::getgametype()) {
    case "dm":
      GscBinSkip0(0x2e, var_0.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_dm_spawn_start", (-611, -2560, 73), (0, 60, 0)));
  }

  if(var_0.size > 0) {
    scripts\mp\spawnlogic::bdiedonce(var_0);
    return;
  }
}

function player_exfil_struct() {
  var_0 = getEnt("clip128x128x128", "targetname");
  var_1 = spawn("script_model", (289, 529, 309));
  var_1.angles = (0, 0, 0);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getEnt("clip128x128x128", "targetname");
  var_3 = spawn("script_model", (289, 657, 309));
  var_3.angles = (0, 0, 0);
  var_3 clonebrushmodeltoscriptmodel(var_2);
}