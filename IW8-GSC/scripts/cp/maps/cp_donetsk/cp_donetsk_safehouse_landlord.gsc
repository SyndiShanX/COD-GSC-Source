/************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_donetsk\cp_donetsk_safehouse_landlord.gsc
************************************************************************/

function registersafehouse() {
  level endon("game_ended");
  scripts\engine\utility::flag_init("players_regrouped");
  scripts\engine\utility::flag_wait("interactions_initialized");
  scripts\engine\utility::flag_init("airfield_safehouse_open");
  scripts\cp\cp_objectives::registerobjective("safehouse_landlord_mnu", undefined, undefined, undefined, undefined, &debug_safehouse_start);
  scripts\cp\cp_objectives::registerobjective("safehouse_landlord", undefined, &start_safehouse, undefined, &debugbeatobjective, &debugbeatobjective);
  scripts\cp\cp_objectives::registerobjective("safehouse_landlord_regroup_mnu", undefined, &ref_12E59, undefined, undefined, &debugbeatobjective);
  scripts\cp\cp_objectives::registerobjective("safehouse_landlord_regroup", undefined, &ref_137F8, undefined, &debugbeatobjective, &debugbeatobjective);
  scripts\engine\utility::flag_set("cp_donetsk_safehouse_landlord_cs");
  scripts\engine\utility::flag_wait("cp_donetsk_safehouse_landlord_cs_completed");
  level.initlocs_bunkertest = scripts\engine\utility::getStructArray("landlord_safehouse_player_start", "targetname");
  level thread scripts\mp\vehicles\vehicle_damage_mp::ref_12E57();
}

function debugbeatobjective(var_0) {}

function debug_safehouse_start(var_0) {
  if(!scripts\engine\utility::flag_exist("cp_donetsk_safehouse_landlord_cs")) {
    scripts\engine\utility::flag_init("cp_donetsk_safehouse_landlord_cs");
  }

  scripts\engine\utility::flag_set("cp_donetsk_safehouse_landlord_cs");
  scripts\engine\utility::flag_wait("cp_donetsk_safehouse_landlord_cs_completed");
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "landlord_safehouse_player_start");
  thread start_safehouse_objective();
}

function isprophuntgametype(var_0) {
  if(!scripts\engine\utility::flag_exist("cp_donetsk_safehouse_landlord_cs")) {
    scripts\engine\utility::flag_init("cp_donetsk_safehouse_landlord_cs");
  }

  scripts\engine\utility::flag_set("cp_donetsk_safehouse_landlord_cs");
  scripts\engine\utility::flag_wait("cp_donetsk_safehouse_landlord_cs_completed");
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "landlord_safehouse_regroup_player_start");
  thread ref_137F9();
}

function spawn_atvs() {
  scripts\engine\utility::flag_wait("objectives_registered");
  wait 3;

  if(!isDefined(level.atvs)) {
    level.atvs = [];
  }

  var_0 = scripts\engine\utility::getStructArray("landlord_atv_spawn", "script_noteworthy");
  level thread scripts\cp\vehicles\atv_cp::atv_cp_createfromstructs(var_0, 1);
  level thread scripts\cp\maps\cp_donetsk\cp_donetsk_obj_overwatch::ref_135AC();
}

function start_safehouse_objective() {
  wait 3;
  scripts\cp\cp_objectives::run_objective("safehouse_landlord", "primary", "allies");
}

function start_safehouse(var_0) {
  scripts\engine\utility::flag_wait("cp_donetsk_safehouse_landlord_cs_completed");
  level.ref_121B1 = getEnt("Phase4OutOfBounds", "targetname");

  if(isDefined(level.ref_121B1)) {
    thread scripts\cp\cp_outofbounds::watchoobtrigger(level.ref_121B1);
  }

  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "landlord_safehouse_player_start");
  scripts\mp\vehicles\vehicle_damage_mp::ref_13BC2(1);
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  var_1 = scripts\mp\vehicles\little_bird_mg_mp::blockachievementstimestamp((16520, -4520, 1656));
  var_2 = getentitylessscriptablearrayinradius("scriptable_scriptable_auto_descender", "classname", var_1.origin, 256);
  var_3 = var_2[0];
  var_3 setscriptablepartstate("ascender", "noprompt");
  scripts\mp\vehicles\vehicle_damage_mp::ref_13BC1(1, (16520, -4520, 1656), 2048, "scriptable_door_metal_single_b_02_grey", "classname");
  level.ref_139B5 = 1;
  thread trial_spawn_wp();
  thread trial_special_end();
  thread spawn_atvs();
  thread managejumpmasterinfodisplay();
  level waittill("allow_descender");
  scripts\mp\vehicles\vehicle_damage_mp::ref_13BC2(0);
  scripts\mp\vehicles\vehicle_damage_mp::ref_13BC1(0, (16520, -4520, 1656), 2048, "scriptable_door_metal_single_b_02_grey", "classname");

  foreach(var_5 in level.players) {
    var_5 skydive_setbasejumpingstatus(1);
    var_5 skydive_setdeploymentstatus(1);
  }

  var_3 setscriptablepartstate("ascender", "on");
  wait 5;
  scripts\cp\cp_objectives::overridenextstep(var_0, "obj_tmtyl_0");
}

function ref_137F9() {
  wait 3;
  scripts\cp\cp_objectives::run_objective("safehouse_landlord_regroup", "primary", "allies");
}

function ref_12E59(var_0) {
  scripts\engine\utility::flag_set("cp_airfield_create_script");
  scripts\engine\utility::flag_wait("cp_airfield_create_script_completed");
  level.ref_139B5 = 1;
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "default_player_start_airfield");
  scripts\mp\vehicles\vehicle_damage_mp::ref_13BC2(1);
  thread br_circleshowdelaysafe();
  thread br_clearinventory();
  setDvar("restart_checkpoint", "");
  setDvar("cp_landlord_start_obj", "safehouse_landlord_regroup_mnu");
  level.initlocs_bunkertest = scripts\engine\utility::getStructArray("default_player_start_airfield", "targetname");
  ref_14329(1);
}

function ref_137F8(var_0) {
  if(!scripts\engine\utility::flag_exist("cp_donetsk_safehouse_landlord_cs")) {
    scripts\engine\utility::flag_init("cp_donetsk_safehouse_landlord_cs");
  }

  scripts\engine\utility::flag_set("cp_donetsk_safehouse_landlord_cs");
  scripts\engine\utility::flag_wait("cp_donetsk_safehouse_landlord_cs_completed");

  if(!scripts\engine\utility::flag("players_regrouped")) {
    thread ref_12B44(var_0);
    scripts\engine\utility::flag_wait("players_regrouped");
    thread ref_13CE6();

    if(isDefined(level.ref_121B1)) {
      level.ref_121B1 scripts\engine\utility::trigger_off();
    }

    setDvar("restart_checkpoint", "");
    setDvar("cp_landlord_start_obj", "safehouse_landlord_regroup_mnu");
    level.initlocs_bunkertest = scripts\engine\utility::getStructArray("landlord_safehouse_player_start", "targetname");
    return;
  }
}

function ref_12B44(var_0) {
  var_1 = (19872, 3712, -442.974);
  thread return_to_safehouse_vo();
  objective_position(var_0.objectiveindex, var_1 + (0, 0, 90));
  objective_setlabel(var_0.objectiveindex, &"CP_STRIKE/SAFEHOUSE_REGROUP");
  thread ref_12B47(var_1);
}

function return_to_safehouse_vo() {
  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_ovl_safehouse_intel_gathered_10");
  wait 1;
  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_ovl_safehouse_return_safehouse_10");
}

function ref_12B47(var_0) {
  var_1 = 0;
  var_2 = 0;

  while(var_1 < 31) {
    var_3 = ref_11F26(var_0);

    if(var_3) {
      if(var_3 == level.players.size) {
        if(!var_2) {
          thread scripts\cp\utility::objective_update("safehouse_return_timer", 5, undefined, undefined, 1, undefined, 1, 1);
          var_2 = 1;
          var_1 = int(max(var_1, 24));
        }
      } else if(!var_2) {
        thread scripts\cp\utility::objective_update("safehouse_return_timer", 30, 20, 10, 1, undefined, 1, 1);
        var_2 = 1;
      }
    } else {
      if(var_2) {
        scripts\cp\cp_objectives::lua_objective_complete("safehouse_return_timer");
        thread scripts\cp\utility::objective_update("safehouse_landlord_regroup");
        var_2 = 0;
      }

      var_1 = 0;
    }

    wait 1;
    var_1++;
  }

  scripts\engine\utility::flag_set("players_regrouped");
}

function zombienumhitsatv() {
  scripts\engine\utility::flag_set("cp_airfield_create_script");
  scripts\engine\utility::flag_wait("cp_airfield_create_script_completed");
}

function ref_11F26(var_0) {
  var_1 = 0;
  var_2 = 148996;

  foreach(var_4 in level.players) {
    if(distancesquared(var_4.origin, var_0) <= var_2) {
      var_1++;
    }
  }

  return var_1;
}

function ref_14329(var_0) {
  scripts\cp\cp_compass::setupminimap("compass_map_cp_landlord_2");
  ref_135B4();

  if(!isDefined(level.ref_121B1)) {} else {
    level.ref_121B1.origin = (24889, 13966, 11264);
    level.ref_121B1 scripts\engine\utility::trigger_on();
  }

  if(!istrue(var_0)) {
    scripts\engine\utility::flag_wait("player_spawned_with_loadout");
    thread choppersupport_watchleashrange();
    level waittill("ba_vo_done");
    scripts\mp\vehicles\vehicle_damage_mp::run_mission("ba_shiprecieve");
    wait 4;
  } else {
    scripts\mp\vehicles\vehicle_damage_mp::run_mission("ba_shiprecieve");
    wait 5;
  }

  var_1 = scripts\engine\utility::getStruct("airfield_safehouse_garage_switch", "targetname");
  var_2 = spawn("script_model", var_1.origin);
  var_2 scripts\cp\utility::sethintobject(undefined, "HINT_BUTTON", undefined, &"CP_STRIKE/DOOR_OPEN", 25, "duration_none", "show", 512, 65, 64, 65);

  for(;;) {
    var_2 waittill("trigger", var_3);
    break;
  }

  var_2 delete();
  scripts\mp\vehicles\vehicle_damage_mp::ref_13BC2(0);
  var_4 = getEnt("airfield_safehouse_garage_door", "targetname");
  var_4 setscriptablepartstate("base", "opening");
  scripts\engine\utility::flag_set("airfield_safehouse_open");
}

function br_clearinventory() {
  var_0 = getEntArray("airfield_safehouse_loot", "targetname");

  foreach(var_2 in var_0) {
    var_2 thread scripts\cp\utility::create_fake_loot();
  }
}

function trial_special_end() {
  var_0 = getEntArray("landlord_safehouse_loot", "targetname");

  foreach(var_2 in var_0) {
    var_2 thread scripts\cp\utility::create_fake_loot();
  }
}

function br_circleshowdelaysafe() {
  var_0 = scripts\engine\utility::getStruct("airfield_safehouse_edit_loadout", "targetname");
  thread scripts\mp\vehicles\vehicle_damage_mp::molotov_get_pool_level_data(var_0);
  thread scripts\mp\brclientmatchdata::getnextrpgspawnmodule("airfield", "toggle_safehouse_settings", 10, 1);
}

function trial_spawn_wp() {
  var_0 = scripts\engine\utility::getStruct("landlord_safehouse_loadout", "targetname");
  thread scripts\mp\vehicles\vehicle_damage_mp::molotov_get_pool_level_data(var_0);
  thread scripts\mp\brclientmatchdata::getnextrpgspawnmodule("headhunter", "allow_descender", 10, 1);
  var_0 = scripts\engine\utility::getStruct("landlord_safehouse_loadout_change", "targetname");
  thread scripts\mp\vehicles\vehicle_damage_mp::molotov_get_pool_level_data(var_0);
}

function ref_135E8(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  self.ignoreme = 1;
  self.anchor = spawn("script_model", self.origin);
  self.anchor setModel("tag_origin");
  var_2 = vectortoangles(var_1.origin + (0, 0, -60000) - var_0.origin);
  self.anchor.angles = var_2;
  self cameralinkTo(self.anchor, "tag_origin", 0, 1);
  self.anchor rotateTo(var_2, 0.15);
  self.anchor moveTo(var_0.origin + (0, 0, 20000), 2);
  self predictstreampos(var_1.origin + (0, 0, 1000));
  wait 2.5;
  var_2 = vectortoangles(var_1.origin - self.anchor.origin);
  self.anchor rotateTo(var_2, 0.75);
  self.anchor moveTo(var_1.origin, 2);
  wait 1.85;
  thread scripts\mp\vehicles\vehicle_damage_mp::ref_1340D(0.15, 0.25, 0.5);
  wait 0.5;
  self cameraunlink();
  self.anchor delete();
  self clearpredictedstreampos();
}

function ref_13CE6() {
  foreach(var_1 in level.players) {
    level thread scripts\mp\vehicles\vehicle_damage_mp::regroup_blackscreen(var_1, "showtext", "safehouse_landlord_regroup", "fadein");
  }

  scripts\mp\vehicles\vehicle_damage_mp::ref_13BC2(1);
  zombienumhitsatv();
  level notify("showtext");
  level waittill("regroup_text_done");
  wait 1;
  var_3 = spawnStruct();
  var_3.angles = (0, 0, 0);
  var_3.origin = level.players[0].origin + (0, 0, 90);
  var_4 = spawnStruct();
  var_4 = scripts\engine\utility::getStructArray("default_player_start_airfield", "targetname")[0];
  thread br_circleshowdelaysafe();
  thread br_clearinventory();
  var_5 = "default_player_start_airfield";

  if(getdvarint("airfield_alt_spawn") > 0) {
    var_5 = "airfield_front_spawn";
  }

  var_6 = scripts\engine\utility::getStructArray(var_5, "targetname");
  thread scripts\mp\vehicles\vehicle_damage_mp::ref_12E5A(var_6);
  wait 1;
  level notify("fadein");
  wait 3;
  ref_14329();
}

function choppersupport_watchleashrange() {
  level endon("game_ended");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_kama_base_assault_brief_10", "allies");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_base_assault_brief_20", "allies");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_kama_base_assault_brief_30", "allies");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_base_assault_brief_40", "allies");
  level notify("ba_vo_done");
  var_0 = scripts\engine\utility::random(scripts\cp\utility::getplayersinteam("allies"));
  level scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0, "ping_response_affirm");
}

function managejumpmasterinfodisplay() {
  level endon("game_ended");

  if(getdvarint("intro_vo") > 0) {
    wait 3;
    level notify("allow_descender");
    level notify("intro_VO_Done");
    level.ref_139B5 = 0;
    return;
  }

  var_0 = 0;

  if(getdvarint("loc_language") != 0 && getdvarint("loc_language") != 1) {
    var_0 = 1.5;
  }

  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_convo_start_10", "allies");
  wait var_0;
  var_1 = scripts\engine\utility::random(scripts\cp\utility::getplayersinteam("allies"));
  wait level scripts\cp\cp_player_battlechatter::trysaylocalsound(var_1, "conv_generic_reply") + 1;
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_tmtyl_brief_10", "allies");
  wait var_0;
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_kama_tmtyl_brief_20", "allies");
  wait var_0;
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_tmtyl_brief_30", "allies");
  wait var_0;
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_kama_tmtyl_brief_40", "allies");
  wait var_0;
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_tmtyl_brief_50", "allies");
  wait var_0;
  level notify("allow_descender");
  var_1 = scripts\engine\utility::random(scripts\cp\utility::getplayersinteam("allies"));
  wait level scripts\cp\cp_player_battlechatter::trysaylocalsound(var_1, "conv_generic_affirm");
  level notify("intro_VO_Done");
  setDvar("intro_vo", 1);
  level.ref_139B5 = 0;
}

function ref_135B4() {
  var_0 = spawnStruct();
  var_0.origin = (3097.5, 61399, 758.734);
  var_0.angles = (0, 225, 0);
  var_0.team = "allies";
  scripts\cp_mp\vehicles\tac_rover::tac_rover_create(var_0);
}

function ref_13776(var_0) {
  zombienumhitsatv();
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "default_player_start_airfield");
  scripts\mp\vehicles\vehicle_damage_mp::ref_13BC2(1);
  thread br_circleshowdelaysafe();
  thread br_clearinventory();
  setDvar("restart_checkpoint", "");
  setDvar("cp_landlord_start_obj", "safehouse_landlord_regroup_mnu");
  level.initlocs_bunkertest = scripts\engine\utility::getStructArray("default_player_start_airfield", "targetname");
  ref_14329();
}