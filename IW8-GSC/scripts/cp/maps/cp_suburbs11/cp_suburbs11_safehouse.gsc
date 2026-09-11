/*******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_suburbs11\cp_suburbs11_safehouse.gsc
*******************************************************************/

function main() {
  level.safehouse_s11_obj_func = &safehouse_obj_func;
}

function safehouse_obj_func() {
  level endon("game_ended");
  scripts\engine\utility::flag_init("players_regrouped");
  scripts\engine\utility::flag_init("smuggler_safehouse_return");
  scripts\engine\utility::flag_wait("interactions_initialized");
  scripts\cp\cp_objectives::registerobjective("safehouse_suburbs11_mnu", undefined, undefined, undefined, undefined, &debug_safehouse_start);
  scripts\cp\cp_objectives::registerobjective("safehouse_suburbs11", undefined, &start_safehouse, undefined, &debugbeatobjective, &debugbeatobjective);
  scripts\cp\cp_objectives::registerobjective("safehouse_return", undefined, &ref_12e58, undefined, &debugbeatobjective, &debugbeatobjective);
  scripts\engine\utility::flag_wait("cp_donetsk_safehouse_suburbs11_cs_completed");
  level.initlocs_bunkertest = scripts\engine\utility::getStructArray("safehouse_s11_playerstart", "targetname");
  level thread scripts\mp\vehicles\vehicle_damage_mp::ref_12e57();
}

function debugbeatobjective(var0) {}

function debug_safehouse_start(var0) {
  thread threaded_debug_start();
}

function threaded_debug_start() {
  scripts\engine\utility::flag_wait("cp_donetsk_safehouse_suburbs11_cs_completed");
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "safehouse_s11_playerstart");
  thread start_safehouse_objective();
}

function spawn_atvs(var0, var1) {
  scripts\engine\utility::flag_wait("cp_donetsk_safehouse_suburbs11_cs_completed");

  if(istrue(var1)) {
    scripts\engine\utility::flag_wait("cp_quarry2_convoy4_create_script_completed");
  }

  if(!isDefined(level.atvs)) {
    level.atvs = [];
  }

  var2 = scripts\engine\utility::getStructArray(var0, "targetname");
  level thread scripts\cp\vehicles\atv_cp::atv_cp_createfromstructs(var2, 1);
}

function ref_135e1(var0) {
  scripts\engine\utility::flag_wait("objectives_registered");
  wait 3;

  if(!isDefined(level.tacrovers)) {
    level.tacrovers = [];
  }

  var1 = scripts\engine\utility::getStructArray(var0, "targetname");
  level thread scripts\cp\vehicles\tac_rover_cp::tac_rover_cp_createfromstructs(var1, 1);
}

function start_safehouse_objective() {
  scripts\engine\utility::flag_wait("cp_donetsk_safehouse_suburbs11_cs_completed");
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "safehouse_s11_playerstart");
  var0 = scripts\engine\utility::getStructArray("safehouse_s11_playerstart", "targetname")[0].origin;
  thread scripts\mp\vehicles\vehicle_damage_mp::ref_13bc2(1);
  thread scripts\mp\vehicles\vehicle_damage_mp::molotov_get_pool_level_data(scripts\engine\utility::getStruct("smuggler_safehouse1_loadout", "targetname"));
  thread scripts\mp\brclientmatchdata::getnextrpgspawnmodule("smuggler_1", "safehouse_door_opened", 10, 1);
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  thread spawn_atvs("smuggler_atv_spawn");
  thread ref_135e1("smuggler_tacrover_spawn");
  thread scripts\mp\vehicles\vehicle_damage_mp::ref_13bc1(1, var0, 2048, "scriptable_door_wooden_panel_mp_01", "classname");
  thread scripts\mp\vehicles\vehicle_damage_mp::ref_13bc1(1, var0, 2048, "scriptable_door_wooden_hollow_mp_01", "classname");
  scripts\cp\cp_objectives::run_objective("obj_caches", "primary", "allies");
  wait 0.7;
  thread scripts\mp\vehicles\vehicle_damage_mp::ref_13bc1(0, var0, 2048, "scriptable_door_wooden_panel_mp_01", "classname");
  thread scripts\mp\vehicles\vehicle_damage_mp::ref_13bc1(0, var0, 2048, "scriptable_door_wooden_hollow_mp_01", "classname");
  thread scripts\mp\vehicles\vehicle_damage_mp::ref_14325(var0, 2048, "scriptable_door_wooden_panel_mp_01", "classname");
  thread scripts\mp\vehicles\vehicle_damage_mp::ref_14325(var0, 2048, "scriptable_door_wooden_hollow_mp_01", "classname");
  level waittill("safehouse_door_opened");
  thread scripts\mp\vehicles\vehicle_damage_mp::ref_13bc2(0);

  foreach(var2 in level.players) {
    thread precomputeddropbagpos();
  }

  level.ref_121b1 = getEnt("Phase4OutOfBounds", "targetname");

  if(isDefined(level.ref_121b1)) {
    thread scripts\cp\cp_outofbounds::watchoobtrigger(level.ref_121b1);
    return;
  }
}

function precomputeddropbagpos() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  var0 = "iw8_ges_demeanor_safe";
  jumpiftrue(istrue(self.ref_124c8)) LOC_00000020;
  return;
}

function start_safehouse(var0) {
  scripts\engine\utility::flag_wait("cp_donetsk_safehouse_suburbs11_cs_completed");
  wait 1;
  scripts\cp\cp_objectives::overridenextstep(var0, "obj_caches");
}

function ref_12e58(var0) {
  scripts\engine\utility::flag_set("cp_smuggler_safehouse_createscript");
  scripts\engine\utility::flag_wait("cp_smuggler_safehouse_createscript_completed");
  var1 = scripts\engine\utility::getStruct("smuggler_safehouse_2_regroup_pos", "targetname");
  objective_position(var0.objectiveindex, var1.origin);
  scripts\cp\cp_objectives::ref_11f80(var0.objectiveindex);
  regroup_at_safehouse();
}

function regroup_at_safehouse() {
  var0 = getEnt("smuggler_safehouse_2_volume", "targetname");
  scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_DWN_TWN_OBJECTIVES/GOTO_SAFEHOUSE_WORLD", "allies", 5);
  scripts\mp\vehicles\vehicle_damage_mp::ref_12e58(var0, "players_regrouped");
  level notify("smuggler_regrouped");
  thread mover_update();
}

function mover_update() {
  for(var0 = 0; var0 < level.players.size; var0++) {
    level.players[var0].ability_invulnerable = 1;
  }

  foreach(var2 in level.players) {
    var2 scripts\cp_mp\xmike109::scriptable_callback("harbinger");

    if(scripts\cp\cp_relics::calldropbag()) {
      if(scripts\cp\cp_gameskill::get_gameskill() != 3) {
        var2 thread scripts\cp_mp\xmike109::scriptable_callback("harbinger_mod");
        continue;
      }

      var2 thread scripts\cp_mp\xmike109::scriptable_callback("harbinger_mod_vet");
    }
  }

  wait 2;
  level thread[[level.endgame]]("allies", level.end_game_string_index["win"]);
}

function ref_137f7() {
  scripts\engine\utility::flag_init("quarry_intro_vo_finished");
  var0 = "cp_smuggler_safehouse_createscript";

  if(!scripts\engine\utility::flag_exist(var0)) {
    scripts\engine\utility::flag_init(var0);
  }

  if(!scripts\engine\utility::flag(var0)) {
    scripts\engine\utility::flag_set(var0);
  }

  scripts\engine\utility::flag_wait(var0 + "_completed");
  wait 1;
  var1 = scripts\engine\utility::getStruct("smuggler_safehouse_2_edit_loadout", "targetname");
  var2 = scripts\engine\utility::getStructArray("smuggler_safehouse_2_player_spawn", "targetname");
  var3 = getEntArray("smuggler_safehouse_2_loot", "targetname");
  var4 = scripts\engine\utility::getStruct("smuggler_safehouse_2_regroup_pos", "targetname");

  if(!isDefined(var1)) {
    return;
  }

  thread scripts\mp\vehicles\vehicle_damage_mp::molotov_get_pool_level_data(var1);
  thread scripts\mp\brclientmatchdata::getnextrpgspawnmodule("smuggler_2", "safehouse_door_opened", 10, 1);
  thread scripts\mp\vehicles\vehicle_damage_mp::ref_13bc2(1);
  thread scripts\mp\vehicles\vehicle_damage_mp::ref_12e56(var3);
  setDvar("restart_checkpoint", "");
  level.initlocs_bunkertest = var2;
  level.ref_139b5 = 1;
  thread scripts\mp\vehicles\vehicle_damage_mp::ref_13bc1(1, var4.origin, 2048, "scriptable_door_wooden_panel_mp_01", "classname");
  thread scripts\mp\vehicles\vehicle_damage_mp::ref_13bc1(1, var4.origin, 2048, "scriptable_door_wooden_hollow_mp_01", "classname");
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");

  if(getDvar("cp_smuggler_skip_vo", "") == "") {
    thread ref_12414();
    wait 35;
  } else {
    thread ref_12414(level);
    wait 10;
  }

  setDvar("cp_smuggler_skip_vo", "skip");
  scripts\engine\utility::flag_set("quarry_intro_vo_finished");
  thread scripts\mp\vehicles\vehicle_damage_mp::ref_13bc1(0, var4.origin, 2048, "scriptable_door_wooden_panel_mp_01", "classname");
  thread scripts\mp\vehicles\vehicle_damage_mp::ref_13bc1(0, var4.origin, 2048, "scriptable_door_wooden_hollow_mp_01", "classname");
  thread scripts\mp\vehicles\vehicle_damage_mp::ref_14325(var4.origin, 2048, "scriptable_door_wooden_panel_mp_01", "classname");
  thread scripts\mp\vehicles\vehicle_damage_mp::ref_14325(var4.origin, 2048, "scriptable_door_wooden_hollow_mp_01", "classname");
  level waittill("safehouse_door_opened");

  foreach(var6 in level.players) {
    thread precomputeddropbagpos();
  }

  thread scripts\mp\vehicles\vehicle_damage_mp::ref_13bc2(0);
  scripts\cp\utility::ref_123fe("mus_cp_smuggler_travel_4");
  level.ref_139b5 = 0;
}

function ref_12414(var0) {
  level endon("stop_searching_vo");
  wait 5;

  if(!istrue(var0)) {
    scripts\mp\vehicles\vehicle_damage_mp::ref_12409("lass");
    play_vo_delay(level, "dx_cps_lass_quarry2_mission_intro_10");
    wait 1.5;
    play_vo_delay(level, "dx_cps_kama_quarry2_brief_10");
    wait 0.75;
    scripts\mp\vehicles\vehicle_damage_mp::ref_12408(undefined, "conv_generic_affirm");
    return;
  }

  play_vo_delay(level, "dx_cps_kama_quarry2_brief_10");
  wait 0.75;
  scripts\mp\vehicles\vehicle_damage_mp::ref_12408(undefined, "conv_generic_affirm");
}

function play_vo_delay(var0, var1, var2, var3, var4, var5, var6) {
  if(isDefined(var4)) {
    wait var4;
  }

  if(isDefined(var0)) {
    level scripts\cp\cp_vo::try_to_play_vo_on_team(var0, "allies", var3, var5, var6);
  }

  if(isDefined(var1)) {
    wait var1;
  }

  if(isDefined(var2)) {
    level thread scripts\cp\utility::cp_add_dialogue_line(var2);
    return;
  }
}