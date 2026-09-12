/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametype_x2.gsc
***************************************************/

#using_animtree("");

function escort_friendly_ai_riders() {
  level.scr_animtree["plane3"] = #animtree;
  level.scr_anim["plane3"]["x2_plane"] = $ingame_intro2_x2_bcloud3;
  level.scr_animname["plane3"]["x2_plane"] = "ingame_intro2_x2_Bcloud3";
  level.scr_animtree["plane4"] = #animtree;
  level.scr_anim["plane4"]["x2_plane"] = % ingame_intro2_x2_bcloud4;
  level.scr_animname["plane4"]["x2_plane"] = "ingame_intro2_x2_Bcloud4";
  level.scr_animtree["plane5"] = #animtree;
  level.scr_anim["plane5"]["x2_plane"] = % ingame_intro2_x2_bcloud5;
  level.scr_animname["plane5"]["x2_plane"] = "ingame_intro2_x2_Bcloud5";
  level.scr_animtree["guy1"] = #animtree;
  level.scr_anim["guy1"]["x2_exfil"] = % br_exfil_x2_guy_walk;
  level.scr_animname["guy1"]["x2_exfil"] = "br_exfil_x2_guy_walk";
  level.scr_anim["guy1"]["x2_exfil_mute"] = % br_exfil_x2_guy_walk_mute;
  level.scr_animname["guy1"]["x2_exfil_mute"] = "br_exfil_x2_guy_walk_mute";
  level.scr_animtree["guy2"] = #animtree;
  level.scr_anim["guy2"]["x2_exfil"] = % br_exfil_x2_guy_drag;
  level.scr_animname["guy2"]["x2_exfil"] = "br_exfil_x2_guy_drag";
  level.scr_anim["guy2"]["x2_exfil_mute"] = % br_exfil_x2_guy_drag_mute;
  level.scr_animname["guy2"]["x2_exfil_mute"] = "br_exfil_x2_guy_drag_mute";
  level.scr_animtree["guy3"] = #animtree;
  level.scr_anim["guy3"]["x2_exfil"] = % br_exfil_x2_guy_hit;
  level.scr_animname["guy3"]["x2_exfil"] = "br_exfil_x2_guy_hit";
  level.scr_anim["guy3"]["x2_exfil_mute"] = % br_exfil_x2_guy_hit_mute;
  level.scr_animname["guy3"]["x2_exfil_mute"] = "br_exfil_x2_guy_hit_mute";
  level.scr_animtree["guy4"] = #animtree;
  level.scr_anim["guy4"]["x2_exfil"] = % br_exfil_x2_dead_drag;
  level.scr_animname["guy4"]["x2_exfil"] = "br_exfil_x2_dead_drag";
  level.scr_anim["guy4"]["x2_exfil_mute"] = % br_exfil_x2_dead_drag_mute;
  level.scr_animname["guy4"]["x2_exfil_mute"] = "br_exfil_x2_dead_drag_mute";
}

function init() {
  ref_11965();
  thread scripts\mp\utility\sound::besttime("br_event_x2_sfx");
  thread evaluatefobspawns();
  thread execute_combat_action();
  thread evaluateallaccolades();
  thread evaluatecontrolledcallback();
  level.ref_12ca7 = getdvarint("scr_bmo_respawnHeightOverride", 2500);
  level.disable_super_in_turret.ref_13cd1 = getDvar("scr_wztrain_type", "armored");
  level.ref_14632 = 0;
  level.ref_14639 = 0;
  level.ref_1463d = [];
  level.ref_133c0 = 1;
  scripts\engine\utility::flag_init("no_crate_spawning");
  level.delay_show_backpack = (10940, -9123, 18925);
  escort_friendly_ai_riders();
  registerscriptedagents();
  extract_dialogue_played();
}

function ref_11965() {
  level._effect["vfx_br_x2_explosion_a1"] = loadfx("vfx/iw8_br/gameplay/event/vfx_br_x2_explosion_a1.vfx");
  level._effect["vfx_br_x2_large_explosion"] = loadfx("vfx/iw8_br/gameplay/event/vfx_br_x2_large_explosion.vfx");
  level._effect["vfx_br_x2_smoke_column_1"] = loadfx("vfx/iw8_br/gameplay/event/vfx_br_x2_smoke_column_1.vfx");
  level._effect["vfx_br_x2_door_explosion"] = loadfx("vfx/iw8_br/gameplay/event/vfx_br_x2_door_explosion.vfx");
  level._effect["vfx_br_x2_embers_smoke"] = loadfx("vfx/iw8_br/gameplay/event/vfx_br_x2_embers_smoke.vfx");
  level._effect["vfx_br_x2_state_explosion"] = loadfx("vfx/iw8_br/gameplay/event/vfx_br_x2_state_explosion.vfx");
  level._effect["vfx_br_x2_fire_lrg"] = loadfx("vfx/iw8_br/gameplay/event/vfx_br_x2_fire_lrg.vfx");
  level._effect["vfx_br_x2_frenzied_sparks"] = loadfx("vfx/iw8_br/gameplay/event/vfx_br_x2_frenzied_sparks.vfx");
  level._effect["vfx_br_x2_linger_smoke"] = loadfx("vfx/iw8_br/gameplay/event/vfx_br_x2_linger_smoke.vfx");
  level._effect["vfx_br_x2_brake_sparks_loco"] = loadfx("vfx/iw8_br/gameplay/event/vfx_br_x2_brake_sparks_02.vfx");
  level._effect["vfx_br_x2_brake_sparks_car"] = loadfx("vfx/iw8_br/gameplay/event/vfx_br_x2_brake_sparks_01.vfx");
  level._effect["vfx_br_x2_turret_exp_01"] = loadfx("vfx/iw8_br/gameplay/event/vfx_br_x2_turret_exp_01.vfx");
  level._effect["vfx_br_x2_turret_loco_exp_01"] = loadfx("vfx/iw8_br/gameplay/event/vfx_br_x2_turret_loco_exp_01.vfx");
  level._effect["vfx_br_x2_flare_attack_r"] = loadfx("vfx/iw8_br/gameplay/event/vfx_br_x2_flare_attack_r");
  level._effect["vfx_br_x2_train_turrets_gatling_hit"] = loadfx("vfx/iw8_br/gameplay/event/vfx_br_x2_train_turrets_gatling_hit.vfx");
  level._effect["vfx_br_x2_train_turrets_88mm_hit"] = loadfx("vfx/iw8_br/gameplay/event/vfx_br_x2_train_turrets_88mm_hit.vfx");
  level._effect["vfx_br_x2_locomotive_hit"] = loadfx("vfx/iw8_br/gameplay/event/vfx_br_x2_locomotive_hit.vfx");
  level._effect["vfx_br_x2_locomotive_damage_hit"] = loadfx("vfx/iw8_br/gameplay/event/vfx_br_x2_locomotive_damage_hit.vfx");
  level._effect["vfx_br_x2_assault_car_hit"] = loadfx("vfx/iw8_br/gameplay/event/vfx_br_x2_assault_car_hit.vfx");
  level._effect["vfx_br_x2_assault_car_damage_01_hit"] = loadfx("vfx/iw8_br/gameplay/event/vfx_br_x2_assault_car_damage_01_hit.vfx");
  level._effect["vfx_br_x2_assault_car_damage_02_hit"] = loadfx("vfx/iw8_br/gameplay/event/vfx_br_x2_assault_car_damage_02_hit.vfx");
  level._effect["vfx_br_fire_ground_line_sm"] = loadfx("vfx/iw8_br/gen_amb/vfx_br_fire_ground_line_sm.vfx");
  level._effect["vfx_br_x2_fire_ground_line_xlg"] = loadfx("vfx/iw8_br/gameplay/event/vfx_br_x2_fire_ground_line_xlg.vfx");
  level._effect["vfx_br_x2_outro_fire_ground_fast_lrg"] = loadfx("vfx/iw8_br/gameplay/event/vfx_br_x2_outro_fire_ground_fast_lrg.vfx");
  level._effect["vfx_br_fire_tiny_nl"] = loadfx("vfx/iw8_br/gen_amb/vfx_br_fire_tiny_nl.vfx");
  level._effect["vfx_br_fire_sml_nl"] = loadfx("vfx/iw8_br/gen_amb/vfx_br_fire_sml_nl.vfx");
  level._effect["vfx_br_x2_smk_stack"] = loadfx("vfx/iw8_br/gameplay/event/vfx_br_x2_smk_stack.vfx");
  level._effect["vfx_br_x2_outro_floating_embers"] = loadfx("vfx/iw8_br/gameplay/event/vfx_br_x2_outro_floating_embers.vfx");
  level._effect["vfx_br_x2_outro_lingering_smoke"] = loadfx("vfx/iw8_br/gameplay/event/vfx_br_x2_outro_lingering_smoke.vfx");
  level._effect["vfx_br_x2_camcentr_ash"] = loadfx("vfx/iw8_br/gameplay/event/vfx_br_x2_camcentr_ash.vfx");
  level._effect["vfx_br_x2_outro_exp_lrg_decal"] = loadfx("vfx/iw8_br/gameplay/event/vfx_br_x2_outro_exp_lrg_decal.vfx");
  level._effect["vfx_br_x2_smoke_column"] = loadfx("vfx/iw8_br/gameplay/event/vfx_br_x2_smoke_column.vfx");
  level._effect["vfx_br_x2_smoke_column_5"] = loadfx("vfx/iw8_br/gameplay/event/vfx_br_x2_smoke_column_5.vfx");
  level._effect["vfx_br_x2_smoke_column"] = loadfx("vfx/iw8_br/gameplay/event/vfx_br_x2_smoke_column.vfx");
  level._effect["vfx_br_x2_fire_ground_xsm"] = loadfx("vfx/iw8_br/gameplay/event/vfx_br_x2_fire_ground_xsm.vfx");
  level._effect["vfx_br_x2_fire_ground_med"] = loadfx("vfx/iw8_br/gameplay/event/vfx_br_x2_fire_ground_med.vfx");
  level._effect["vfx_br_x2_fire_ground_sm"] = loadfx("vfx/iw8_br/gameplay/event/vfx_br_x2_fire_ground_sm.vfx");
  level._effect["vfx_br_x2_fire_ground_med"] = loadfx("vfx/iw8_br/gameplay/event/vfx_br_x2_fire_ground_med.vfx");
  level._effect["vfx_br_x2_outro_lingering_smoke"] = loadfx("vfx/iw8_br/gameplay/event/vfx_br_x2_outro_lingering_smoke.vfx");
  level._effect["vfx_br_x2_wind_blowing_fast"] = loadfx("vfx/iw8_br/gameplay/event/vfx_br_x2_wind_blowing_fast.vfx");
  level._effect["vfx_br_field_embers"] = loadfx("vfx/iw8_br/gen_amb/vfx_br_field_embers.vfx");
  level._effect["vfx_br_x2_wind_blowing_fast"] = loadfx("vfx/iw8_br/gameplay/event/vfx_br_x2_wind_blowing_fast.vfx");
  level._effect["vfx_br_field_embers"] = loadfx("vfx/iw8_br/gen_amb/vfx_br_field_embers.vfx");
  level._effect["vfx_br_x2_wind_blowing_fast"] = loadfx("vfx/iw8_br/gameplay/event/vfx_br_x2_wind_blowing_fast.vfx");
  level._effect["vfx_br_field_embers"] = loadfx("vfx/iw8_br/gen_amb/vfx_br_field_embers.vfx");
  level._effect["vfx_br_x2_dirt_burst"] = loadfx("vfx/iw8_br/gameplay/event/vfx_br_x2_dirt_burst.vfx");
  level._effect["vfx_br_x2_kick_dirt"] = loadfx("vfx/iw8_br/gameplay/event/vfx_br_x2_kick_dirt.vfx");
  level._effect["vfx_br_x2__trash_drift"] = loadfx("vfx/iw8_br/gameplay/event/vfx_br_x2__trash_drift.vfx");
  level._effect["vfx_br_x2_flare_exfill_r"] = loadfx("vfx/iw8_br/gameplay/event/vfx_br_x2_flare_exfill_r");
  level._effect["vfx_br_x2__trash_drift"] = loadfx("vfx/iw8_br/gameplay/event/vfx_br_x2__trash_drift.vfx");
  level._effect["vfx_br_x2_exfill_beacon"] = loadfx("vfx/iw8_br/gameplay/event/vfx_br_x2_exfill_beacon.vfx");
}

function evaluatefobspawns() {
  level endon("game_ended");

  if(getdvarint("scr_br_x2_debug", 0) == 1) {
    scripts\mp\gametypes\br_gametypes::move_molotov_mortar("allowLateJoiners");
  }

  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("drogBagLoadout");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("gulag");
  scripts\mp\gametypes\br_gametypes::move_molotov_mortar("circleEarlyStart");
  level.decoyassists = &escort_vehicle_push_clip;
  setDvar("voice_proximity_team", 1);
  setDvar("voice_proximity_radius", -1);
}

function execute_combat_action() {
  level endon("game_ended");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("waitLoadoutDone");
  scripts\mp\gametypes\br_gametypes::ref_12b11("onInfilSequenceEnd", &escort_a);
  scripts\mp\gametypes\br_gametypes::ref_12b11("playerNakedDropLoadout", &exploder_ref);
  scripts\mp\gametypes\br_gametypes::ref_12b11("getDefaultLoadout", &enterpos);
  scripts\mp\gametypes\br_gametypes::ref_12b11("playerKilledSpawn", &ref_125f7);
  scripts\mp\gametypes\br_gametypes::ref_12b11("markPlayerAsEliminatedOnKilled", &ref_11b16);
  scripts\mp\gametypes\br_gametypes::ref_12b11("mayConsiderPlayerDead", &ref_11b80);
  scripts\mp\gametypes\br_gametypes::ref_12b11("modifyPlayerDamage", &exfil_spawners_triggered);
  scripts\mp\gametypes\br_gametypes::ref_12b11("getFinalCircleCenter", &entity_movingplatform_update);
  scripts\mp\gametypes\br_gametypes::ref_12b11("mapCenterFinalCircle", &entity_movingplatform_update);
  scripts\mp\gametypes\br_gametypes::ref_12b11("startUICloseTimer", &extrascore4);
  scripts\mp\gametypes\br_gametypes::ref_12b11("playerWelcomeSplashes", &explode_fx);
  scripts\mp\gametypes\br_gametypes::ref_12b11("postSpawnVehicle", &extra_delay);
  scripts\mp\gametypes\br_gametypes::ref_12b11("onConnectSpawnPoint", &ref_12006);
  scripts\mp\gametypes\br_gametypes::ref_12b11("onPlayerConnect", &exfilchopper);
  scripts\mp\gametypes\br_gametypes::ref_12b11("onTrainBrakeComplete", &exit_laser_panel_anim_sequence);
  scripts\mp\gametypes\br_gametypes::ref_12b11("onTrainAccelBegin", &existingkills);
  scripts\mp\gametypes\br_gametypes::ref_12b11("sixthSenseThink", &extractlocale_checkiflocaleisavailable);
  scripts\mp\gametypes\br_gametypes::ref_12b11("addToC130Infil", &enemy_respawn_manager);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airstrike", "postAirstrikeAnim", &extra_collision);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airstrike", "harmlessAirstrikeEffect", &escape_if_player_is_in_hangar);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airstrike", "overridePlayFlyFX", &exit_open);

  if(!isDefined(level.ref_145f1)) {
    level.ref_145f1 = spawnStruct();
  }

  level.ref_145f1.ks_airdropcrateusetime = 1;
  waittillframeend();
  level.ref_12067 = &exfill_chopper_dialogue;
  level.ref_11ffb = &exfill_chopper_dialogue;
  level.ontimelimit = &exfill_vehicle;
  thread execution_obstacle();
  level.playerkillstreakgetownerlookatignoreents = 1;
  level.ref_13396 = getdvarint("scr_br_x2_signal_quest_enabled", 0);
  level.ent_delete_by_targetname = getdvarint("scr_br_x2_driver_car_damage_assist", 195);
  level.ent_model = getdvarint("scr_br_x2_driver_turret_damage_assist", 105);
  level.loadoutbrfieldupgrade = 1;
  evade_start_targetname();
  enemygunship_getnearbytargets();
  scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(&exfil_spots_objs_settings);
  level.ref_140d9 = [];
  thread executionquip();
  executioncashmultiplier();
  evaluationcallback();
  thread escort_vehicle_push_volume();
  thread excludedteams();

  if(level.mapname == "mp_br_mechanics") {
    thread extraweapons();
  }

  escort_b();
  thread eventcallback();
  level thread scripts\mp\gametypes\br_heavy_weapon_drop_x2::init();
  thread ref_11d03();
  thread ref_1260c();
  thread ref_13251();
}

function evaluateallaccolades() {
  level endon("game_ended");
  level waittill("br_dialog_initialized");
  game["dialog"]["match_start"] = "gametype_battle";
  game["dialog"]["mode_desc1"] = "gametype_desc_battle_pve";
  game["dialog"]["mode_desc2"] = "gametype_desc_battle_squads";
  game["dialog"]["mode_desc3"] = "gametype_desc_battle_train";
  game["dialog"]["objective1_desc"] = "ambush_first";
  game["dialog"]["destroy_part6"] = "car_start";
  game["dialog"]["destroy_part11"] = "car_half";
  game["dialog"]["destroy_car7"] = "car_done";
  game["dialog"]["car_vulnerable"] = "car_shoot";
  game["dialog"]["train_incoming1"] = "train_ambush";
  game["dialog"]["train_incoming2"] = "ambush_last";
  game["dialog"]["train_stopped1"] = "attack_after";
  game["dialog"]["outro_victory"] = "train_destroy";
  game["dialog"]["overdrive_nag"] = "ambush_break";
  game["dialog"]["resuply_drop0"] = "drop_use";
  game["dialog"]["resuply_drop1"] = "drop_resupply";
  game["dialog"]["outro_bombers_tease"] = "dx_bra_op4_bombers_trouble";
  game["dialog"]["outro_bombers"] = "dx_bra_op4_outro_bombers";
  game["dialog"]["outro_keep_running"] = "dx_bra_op4_outro_explosion";
  game["dialog"]["outro_exfil_coming"] = "dx_bra_op4_outro_down";
  game["dialog"]["outro_exfil_almost_over"] = "dx_bra_op4_outro_cover";
}

function enemygunship_getnearbytargets() {
  scripts\cp_mp\utility\game_utility::ref_12c10("delete_on_load", "targetname");
}

function evaluatecontrolledcallback() {
  level endon("game_ended");
}

function executionquip() {
  level endon("game_ended");
  extracting("mp_don4_x2", 0.5);
}

function escort_vehicle_push_clip() {
  level.br_level.ref_13884 = 1;
}

function evade_start_targetname() {
  level.juggheli_spawner_jammer5_4 = [];
  level.juggheli_spawner_jammer5_4["atv"] = "veh8_mil_lnd_atango_skin_x2";
  level.juggheli_spawner_jammer5_4["little_bird"] = "veh8_mil_air_lbravo_skin_x2";
  level.juggheli_spawner_jammer5_4["little_bird_mg"] = "veh8_mil_air_lbravo_skin_x2";
  level.juggheli_spawner_jammer5_4["cargo_truck"] = "veh8_mil_lnd_mkilo23_skin_x2";
  level.juggheli_spawner_jammer5_4["tac_rover"] = "veh8_mil_lnd_tromeo_skin_x2";
  level.juggheli_spawner_jammer5_4["jeep"] = "veh8_civ_lnd_decho_skin_x2";
  level.juggheli_spawner_jammer5_4["motorcycle"] = "camo_veh_t9_mil_lnd_motorcycle_wz_x2";
}

function extra_delay(var_0, var_1) {
  if(isDefined(level.juggheli_spawner_jammer5_4)) {
    var_2 = level.juggheli_spawner_jammer5_4[var_1];

    if(isDefined(var_2)) {
      var_0 setvehiclecamo();
      var_0 getmountconfigenabled(var_2);
      var_0.gasfxair = 1;
      return;
    }

    return;
  }
}

function enemy_respawn_manager() {
  thread exfil_clear_objective();
}

function exfil_clear_objective() {
  level endon("game_ended");
  self endon("death");
  var_0 = getdvarfloat("scr_x2_infil_kick_timer", 21);
  wait var_0;

  foreach(var_2 in level.players) {
    if(isDefined(var_2) && isDefined(var_2.br_infil_type) && var_2.br_infil_type == "c130" && !isDefined(var_2.jumptype)) {
      var_2.jumptype = "outOfBounds";
      var_2 notify("halo_kick_c130");
    }
  }
}

function exfil() {
  level endon("game_ended");
  thread extractlocale_circletick(level.brneverlanded[1].position, level.brneverlanded[1].broadcast_currency);
  scripts\mp\flags::gameflagwait("br_ready_to_jump");
  thread extractsilentcountdown("ambush0");
  var_1 = getdvarint("scr_br_x2_intro_delay", 60);

  while(var_1 >= 0) {
    setomnvar("ui_hardpoint_timer", gettime() + int(var_1 * 1000));

    if(var_1 <= 15 && var_1 >= 1) {
      scripts\mp\utility\sound::playsoundonplayers("match_start_tick_in3", "allies");
    }

    var_1--;
    wait 1;
  }

  setomnvar("ui_hardpoint_timer", 0);
  thread exfil_spawning_logic();
  thread execution_debug();
  extactioncancel();
  wait 4;
  thread scripts\mp\gametypes\br_movingtrain_armored::initmarker();
}

function exfill_vehicle() {
  if(isDefined(level.numendgame)) {
    level thread scripts\mp\gametypes\br::startendgame(1);
  }

  level.numendgame = undefined;
}

function timeoutonabandoneddelay(var_0) {
  level.depletionrate = [];
  var_1 = tablelookupgetnumcols(var_0) - 1;

  for(var_2 = 0; var_2 < var_1; var_2++) {
    level.depletionrate[var_2] = init_structs_mp_don3(var_2, var_0);
  }
}

function init_structs_mp_don3(var_0, var_1) {
  GscBinSkip1(0x45, "loadoutArchetype", "archetype_assault");
}

function enterpos() {
  GscBinSkip1(0x45, "loadoutArchetype", "archetype_assault");
}

function exploder_ref() {
  if(!isDefined(level.depletionrate)) {
    timeoutonabandoneddelay("mp/classtable_x2.csv");
  }

  var_0 = level.depletionrate[randomint(level.depletionrate.size)];
  equip_random_grenade(var_0, 1);
  scripts\mp\gametypes\br_pickups::forcegivesuper(var_0["loadoutSuper"], 0);
  scripts\mp\gametypes\br_armor::searchcirclesize(1);
  scripts\mp\gametypes\br_weapons::debug_spawncover_badnodetest();
  return false;
}

function equip_random_grenade(var_0, var_1, var_2) {
  self.pers["gamemodeLoadout"] = var_0;
  self.class = "gamemode";
  self.prevweaponobj = undefined;
  var_3 = scripts\mp\class::loadout_getclassstruct();
  var_3 = scripts\mp\class::loadout_updateclass(var_3, "gamemode");
  scripts\mp\class::preloadandqueueclassstruct(var_3, 1, 1);
  self takeallweapons();
  scripts\mp\class::giveloadout(self.team, "gamemode", var_1, var_1);
  self givestartammo(var_3.loadoutprimaryobject);
  self givestartammo(var_3.loadoutsecondaryobject);
  scripts\mp\gametypes\br::scriptednode(self);
  scripts\mp\gametypes\br_weapons::br_ammo_player_clear();

  if(!istrue(var_2)) {
    scripts\mp\gametypes\br_weapons::delay_add_to_chopper_boss_drone_target_array();
  }

  scripts\mp\gametypes\br_weapons::br_ammo_update_weapons(self);
  self notify("ammo_update");
}

function exploboltexplode() {
  var_0 = [];
  var_1 = self getweaponslistprimaries();

  foreach(var_3 in var_1) {
    var_4 = scripts\mp\gametypes\br_weapons::br_ammo_type_for_weapon(var_3);

    if(isDefined(var_4)) {
      var_5 = weaponclipsize(var_3);
      self.br_ammo[var_4] = var_5;
      scripts\mp\gametypes\br_weapons::br_ammo_player_hud_update_ammotype(var_4);
    }
  }

  scripts\mp\gametypes\br_weapons::br_ammo_update_weapons(self);
}

function ref_125f7(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  thread ref_126a4(1);
  return true;
}

function ref_11b80(var_0) {
  return true;
}

function ref_11b16() {
  return false;
}

function ref_12573() {
  if(scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("missions")) {
    return undefined;
  }

  return self.ref_1296e;
}

function risktokenonuse() {
  var_0 = getdvarfloat("scr_br_respawnMaxTrainOffset", 6000);
  var_1 = randomfloatrange(0, 360);
  return (cos(var_1), sin(var_1), 0) * randomfloatrange(0, var_0);
}

function ref_12006() {
  var_0 = getdvarfloat("scr_br_respawnTrainHeight", 5000);
  var_1 = randomfloatrange(0, 360);
  var_2 = spawnStruct();
  var_2.origin = (-12221, -12808, 500) + risktokenonuse() + (0, 0, var_0);
  var_2.angles = vectortoangles((cos(var_1), sin(var_1), 0));
  var_2.index = -1;
  return var_2;
}

function ref_126a4(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  if(var_0) {
    var_1 = getdvarfloat("scr_br_respawnTrainHeight", 2500);
    var_2 = undefined;
    var_3 = undefined;

    if(scripts\mp\flags::gameflag("x2_train_destroyed")) {
      var_4 = scripts\mp\gametypes\br_gulag::ref_12568(0);

      if(!isDefined(var_4)) {
        var_4 = self;
      }

      var_2 = scripts\mp\gametypes\br_gulag::rocket_fuel_stability(var_4.origin, 1000);
      var_2 = scripts\mp\gametypes\br_public::modifyplayer_damage(var_2);
      var_3 = scripts\mp\gametypes\br_gulag::registercarryobjectpickupcheck(var_2, var_4.origin);
    } else {
      var_5 = (0, 0, var_1);
      var_6 = undefined;

      if(level.mapname == "mp_br_mechanics") {
        var_6 = (0, 0, 0) + var_5;
      } else if(level.mapname == "mp_don4" && !scripts\mp\flags::gameflag("prematch_done")) {
        var_6 = (-12221, -12808, 500) + (0, 0, 2 * var_1) + risktokenonuse();
      } else if(isDefined(level.ref_145f1) && isDefined(level.ref_145f1.ref_13c8d) && isDefined(level.ref_145f1.ref_13c8d[0])) {
        var_6 = level.ref_145f1.ref_13c8d[0].wz_tease.origin + var_5;
      } else {
        var_6 = (4853.5, -1000.75, -108.75) + (0, 0, var_1) + risktokenonuse();
      }

      var_7 = getdvarfloat("scr_br_respawnMaxTrainOffset", 6000);
      var_2 = scripts\mp\gametypes\br_gulag::rocket_fuel_stability(var_6, var_7, undefined);
      var_3 = scripts\mp\gametypes\br_gulag::registercarryobjectpickupcheck(var_2, var_6);
    }

    if(isDefined(var_2) && isDefined(var_3)) {
      var_8 = spawn("script_model", var_2);
      var_8.playerspawnpos = var_2;
      var_8.playerspawnangles = var_3;
      var_8.notti = 1;
      self.setspawnpoint = var_8;
    }

    self.ref_1286f = scripts\mp\gametypes\br_gulag::ref_125be(0, undefined, var_1);
    self.ref_1286f.index = -1;
  } else {
    self.ref_1286f = scripts\mp\gametypes\br::getspawnpoint(1);
    var_1 = scripts\cp_mp\parachute::getc130height();
    var_9 = scripts\engine\utility::drop_to_ground(self.ref_1286f.origin, 1500, -20000);
    var_5 = (0, 0, var_1);
    self.ref_1286f.origin = scripts\mp\gametypes\br::getoffsetspawnorigin(var_9, var_5);
  }

  scripts\mp\playerlogic::waitandspawnclient(0);
  self.ref_1463c = scripts\mp\utility\outline::outlineenableforall(self, "outline_depth_x2", "level_script");
  scripts\mp\utility\perk::giveperk("specialty_surveillance");
  self freezecontrols(1);

  if(!istrue(level.skipprematchdropspawn)) {
    thread scripts\mp\gametypes\br::prematchdeployparachute();
  }

  while(!isalive(self)) {
    waitframe();
  }

  waitframe();
  scripts\mp\gametypes\br_armor::searchcirclesize(1);
  scripts\mp\gametypes\br_weapons::debug_spawncover_badnodetest();
  thread scripts\mp\gametypes\br::defend_wave_2();
  self skydive_setdeploymentstatus(1);
  self skydive_setbasejumpingstatus(1);
  self visionsetnakedforplayer(level.ref_142d1, 0);
  var_10 = !self calloutmarkerping_getEnt();
  var_11 = gettime();

  if(var_10) {
    while(isalive(self) && isDefined(self.weaponlist) && !self hasloadedviewweapons(self.weaponlist)) {
      if(var_11 + 3000 < gettime()) {
        break;
      }

      waitframe();
    }
  }

  self notify("brWaitAndSpawnClientComplete");
  self.waitingtospawn = 0;
  self freezecontrols(0);

  if(var_1) {
    scripts\mp\gametypes\br::ref_13f21(self);
    return;
  }
}

function extra_riders_getin_anim_func(var_0, var_1, var_2, var_3) {
  var_4 = scripts\mp\gametypes\br_quest_util::createquestinstance(var_0, var_1 + "-" + self.squadindex, var_2, var_3, self.squadindex);
  var_4 scripts\mp\gametypes\br_quest_util::ref_12b15(self);
  var_4.team = self.team;
  var_4.startlocation = self.origin;
  var_4.intelprogress = self.origin;
  var_4.playerlist = level.squaddata[self.team][self.squadindex].players;
  return var_4;
}

function extra_riders_func(var_0) {
  if(var_0.team == self.team && var_0.squadindex == self.squadindex) {
    return 1;
  }

  return 0;
}

function enemy_signal_flare(var_0, var_1) {
  var_2 = self;

  if(isDefined(level.questinfo.quests[var_0].instances[var_2.team + "-" + var_2.squadindex])) {
    return;
  }

  var_3 = [[var_1]](var_2.team, "", var_2, "");

  if(isDefined(var_3)) {
    thread exfilallyturning();
  }

  return var_3;
}

function exfilallyturning() {
  level endon("game_ended");
  var_0 = self;
  var_0 waittill("removed");
  var_0 notify("update");
}

function entmantling(var_0, var_1) {
  return level.questinfo.quests[var_0].instances[var_1.team + "-" + var_1.squadindex];
}

function enter_laser_panel_anim_sequence(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(isDefined(var_3) && isalive(var_3)) {
      var_1 = var_3;
    }
  }

  return var_1;
}

function extract_ontimerexpired(var_0) {
  foreach(var_2 in var_0.playerlist) {
    var_2.ref_1296e = undefined;
  }
}

function evaluationcallback() {
  scripts\mp\flags::gameflaginit("x2_ambush1_starting", 0);
  scripts\mp\flags::gameflaginit("x2_ambush1_completed", 0);
  scripts\mp\flags::gameflaginit("x2_ambush2_starting", 0);
  scripts\mp\flags::gameflaginit("x2_ambush2_completed", 0);
  scripts\mp\flags::gameflaginit("x2_ambush3_starting", 0);
  scripts\mp\flags::gameflaginit("x2_ambush3_completed", 0);
  scripts\mp\flags::gameflaginit("x2_ambush4_starting", 0);
  scripts\mp\flags::gameflaginit("x2_ambush4_completed", 0);
  scripts\mp\flags::gameflaginit("x2_ambush4_starting", 0);
  scripts\mp\flags::gameflaginit("x2_ambush4_completed", 0);
  scripts\mp\flags::gameflaginit("x2_ambush5_starting", 0);
  scripts\mp\flags::gameflaginit("x2_ambush5_completed", 0);
  scripts\mp\flags::gameflaginit("x2_ambush6_starting", 0);
  scripts\mp\flags::gameflaginit("x2_ambush6_completed", 0);
  scripts\mp\flags::gameflaginit("x2_ambush7_starting", 0);
  scripts\mp\flags::gameflaginit("x2_ambush7_completed", 0);
  scripts\mp\flags::gameflaginit("x2_ambush8_starting", 0);
  scripts\mp\flags::gameflaginit("x2_ambush8_completed", 0);
  scripts\mp\flags::gameflaginit("x2_locomotive_vulnerable", 0);
  scripts\mp\flags::gameflaginit("x2_train_destroyed", 0);
  scripts\mp\flags::gameflaginit("x2_checkpoint1_completed", 0);
  scripts\mp\flags::gameflaginit("x2_checkpoint2_completed", 0);
  scripts\mp\flags::gameflaginit("x2_checkpoint3_completed", 0);
  scripts\mp\flags::gameflaginit("x2_checkpoint4_completed", 0);
  scripts\mp\flags::gameflaginit("x2_checkpoint5_completed", 0);
  scripts\mp\flags::gameflaginit("x2_checkpoint6_completed", 0);
  scripts\mp\flags::gameflaginit("x2_airstrike_begin", 0);
}

function escort_a() {
  exfil_sequence("InfilSequenceEnd");
  thread extraweapons();
  thread escort_intro_pre_anim_wait();
  level.battlechatterenabled = 0;
}

function extraweapons() {
  level endon("game_ended");
  exfil_sequence("x2think");
  scripts\mp\flags::gameflagwait("prematch_done");
  thread exfil();
  wait 1;
  thread exfil_spawnfunc();
  thread fadetogearingup();
  thread equip_trophies();
  showsplash("br_x2_introduction");
  wait 1.5;
  var_0 = enter_numbers_end();

  foreach(var_2 in var_0) {
    foreach(var_4 in var_2) {
      thread extra_riders_intro_scene_func();
      LOC_0000009a:
    }
  }
}

function escort_b() {
  level.brneverlanded = [];
  level.getpubliceventchance = [];
  enemygunship_handlemissiledetection(1, 0, 0, (4606, -820, -100), 0, 1, 0, 1, []);
  enemygunship_spawngunship(1, (2477, 18513, -237), [(-5756, 23842, -390), (-12077, 29338, -216)]);
  enemygunship_spawngunship(2, (-15901, 29619, -184), [(-23766, 31256, -6), (-30370, 29231, 371)]);
  enemygunship_spawngunship(3, (-31170, 9206, -380), []);
  enemygunship_handlemissiledetection(2, 1, 1, (-31298, 3614, -284), 1, 1, 0, 0, []);
}

function enemygunship_handlemissiledetection(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = spawnStruct();
  var_9.broadcast_currency = var_0;
  var_9.managecontrolledcallbacktimeout = var_1;
  var_9.ref_13343 = var_2;
  var_9.position = var_3;
  var_9.should_do_damage_check_func_relics = var_4;
  var_9.turret_guncourse_explode_on_end = var_5;
  var_9.loc_exposed_to_chopper_boss = var_6;
  var_9.ref_13ccb = var_7;
  var_9.infilvideowaituntilcomplete = var_8;
  level.brneverlanded[var_0] = var_9;
}

function enemygunship_spawngunship(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.tv_station_interior_enemy_should_break_stealth_immediately = 1;
  var_3.getquestplunderreward = var_0;
  var_3.position = var_1;
  var_3.vehicle_occupancy_isneutraltoteam = [];
  var_3.infilvideowaituntilcomplete = var_2;
  level.getpubliceventchance[var_0] = var_3;
}

function enter_numbers_init(var_0) {
  return level.brneverlanded[var_0];
}

function eventcallback() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  level.ref_145f1.ref_13cca = 0;
  level.ref_145f1.instance = 0;
  level.ref_145f1.ref_1397d = [];
  level.ref_145f1.ref_1397c = [];
}

function exfil_spawnfunc() {
  level endon("game_ended");
  level endon("train_destroyed");
  scripts\engine\utility::flag_wait("wztrain_anim_playing");
  var_0 = level.ref_145f1.ref_13c8d[0];
  var_0 scripts\mp\gametypes\br_movingtrain::ref_13c8b(3, 2);

  if(!isDefined(level.ref_145f1) || !isDefined(level.ref_145f1.animents) && !isDefined(level.ref_145f1.animents[0])) {
    return;
  }

  thread exit_laststand_usability();
  thread fadetoblackforxsec(level, var_0);
  enemy_right_monitor(level.brneverlanded[1]);

  foreach(var_2 in level.getpubliceventchance) {
    enemygunship_firerounds(var_2);
  }

  enemy_right_monitor(level.brneverlanded[2]);
}

function exit_laststand_usability() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("x2_ambush1_completed");
  scripts\mp\gametypes\br_movingtrain_armored::extraction_balloon_total_plunder();
}

function enemygunship_firerounds(var_0) {
  var_1 = level.ref_145f1.ref_13c8d[0];
  var_2 = var_0.position;
  var_3 = var_0.getquestplunderreward;
  thread extractsilentcountdown("ambush" + var_3 + 1);
  var_4 = 1500;
  ref_143fd(var_1, var_2, var_4);
  thread extendcirclelist();
  extractmissionhelipadscriptable(var_0.infilvideowaituntilcomplete);
  var_4 = 50;
  ref_143fd(var_1, var_2, var_4);
  scripts\mp\flags::gameflagset("x2_checkpoint" + var_3 + "_completed");

  if(var_0.vehicle_occupancy_isneutraltoteam.size > 0) {
    if(var_3 > 1) {
      exfil_heli_landing(var_3 - 1);
    }

    extractplunderheliinvulnerable(var_3);
  }

  var_5 = var_0.getquestplunderreward;

  if(var_5 >= 1) {
    enemymarker(var_5);
    return;
  }
}

function enemy_right_monitor(var_0) {
  var_1 = level.ref_145f1.ref_13c8d[0];

  if(var_0.managecontrolledcallbacktimeout) {
    wait 2;
  }

  if(var_0.broadcast_currency != 1 && istrue(level.ref_13396)) {
    thread extractlocale_circletick(var_0.position, var_0.broadcast_currency);
  }

  if(var_0.broadcast_currency >= level.brneverlanded.size) {
    var_2 = var_0.broadcast_currency + level.getpubliceventchance.size;
  } else {
    var_2 = var_1.broadcast_currency;
    thread extractsilentcountdown("ambush" + var_2);
  }

  var_3 = getdvarvector("scr_br_x2_amb_destination", var_1.position);
  level.initextractionlocations = var_1.broadcast_currency;
  var_4 = getdvarint("scr_br_x2_amb_warn_distance1", 24000);
  var_5 = getdvarint("scr_br_x2_amb_warn_distance2", 12500);
  var_6 = getdvarint("scr_br_x2_amb_warn_distance3", 3000);
  var_7 = getdvarint("scr_br_x2_amb_warn_distance4", 50);
  var_8 = 200;
  ref_143fd(var_2, var_3, var_4);
  extractmissionhelipadscriptable(var_1.infilvideowaituntilcomplete);
  ref_143fd(var_2, var_3, var_5);

  if(var_1.broadcast_currency == 1 || var_1.should_do_damage_check_func_relics && istrue(level.ref_13396)) {
    showsplash("br_x2_distance02");
  }

  level notify("train_incoming");
  ref_143fd(var_2, var_3, var_6);

  if(var_1.broadcast_currency == 1 || var_1.should_do_damage_check_func_relics && istrue(level.ref_13396)) {
    showsplash("br_x2_distance03");
  }

  scripts\mp\flags::gameflagset("x2_ambush" + var_1.broadcast_currency + "_starting");
  ref_143fd(var_2, var_3, var_7);

  if(var_1.turret_guncourse_explode_on_end && level.ref_145f1.instance > 0) {
    if(var_1.loc_exposed_to_chopper_boss) {
      showsplash("br_x2_distance04");
    } else {
      showsplash("br_x2_train_immobilized");
    }
  }

  ref_143fd(var_2, var_3, var_8);

  if(!var_1.ref_13ccb) {
    level.ref_145f1.ref_12a38 = 1;
  }

  var_9 = scripts\engine\utility::ter_op(var_1.turret_guncourse_explode_on_end, 8, 3);
  thread extratimeincreasecount(var_9, 0, var_1.turret_guncourse_explode_on_end);

  if(var_1.turret_guncourse_explode_on_end) {
    if(level.ref_145f1.instance == 0) {
      level.ref_145f1.instance++;
    }

    faceenemyspawn(var_1.broadcast_currency);
    var_2 scripts\mp\gametypes\br_movingtrain_armored::enemy_rushdown_player();
    scripts\mp\gametypes\br_x2_bomb_quest::has_headicon();
    scripts\mp\flags::gameflagset("x2_ambush" + var_1.broadcast_currency + "_completed");
    wait 6;
  } else {
    wait 2;
    scripts\mp\flags::gameflagset("x2_ambush" + var_1.broadcast_currency + "_completed");
    wait 6;
  }

  if(!istrue(level.ref_145f1.ref_12a38)) {
    var_2 scripts\mp\gametypes\br_movingtrain::ref_13c8b(0.7, 0.05);
    thread f11lights();
  } else if(!level.ref_145f1.usedcountinveh) {
    level thread scripts\mp\gametypes\br_movingtrain_armored::ref_13ccd();
  }

  var_10 = var_2 - 1;

  if(var_10 >= 1) {
    enemymarker(var_10);
    return;
  }
}

function extractlocale_circletick(var_0, var_1) {
  level endon("game_ended");
  var_2 = spawn("script_model", var_0);
  var_2 setModel("vfx_br_x2");
  var_2 setscriptablepartstate("vfx", "vfx_br_x2_beacon_01");
  scripts\engine\utility::ref_143ad("x2_ambush" + var_1 + "_completed", "x2_train_destroyed");
  var_2 delete();
}

function fadetoblackforxsec(var_0, var_1) {
  level endon("game_ended");
  var_2 = 2300;

  if(!istrue(level.ref_13396)) {
    var_3 = 6000;
    ref_143fd(var_0, var_1.position, var_3);
    scripts\mp\flags::gameflagset("x2_airstrike_begin");
  }

  ref_143fd(var_0, var_1.position, var_2);
  thread f14_keypadnumstr(var_1.broadcast_currency, var_1.position);
}

function fadeoutinspectatorsofplayer(var_0) {
  level endon("game_ended");
  var_1 = level.ref_145f1.ref_13c8d[0];
  thread f14_current_inputamt(1);
  wait 5;

  if(var_0) {
    if(!istrue(level.ref_145f1.ref_12a38) && !scripts\mp\flags::gameflag("x2_train_destroyed") && !scripts\mp\flags::gameflag("x2_locomotive_vulnerable")) {
      var_1 scripts\mp\gametypes\br_movingtrain::ref_13c8b(0.7, 0.05);
      thread f11lights();
      return;
    }

    return;
  }

  if(!level.ref_145f1.usedcountinveh) {
    level thread scripts\mp\gametypes\br_movingtrain_armored::ref_13ccd();
    return;
  }
}

function extratimeincreasecount(var_0, var_1, var_2) {
  level endon("game_ended");
  level notify("x2_train_stopped");
  level endon("x2_train_stopped");
  var_3 = level.ref_145f1.ref_13c8d[0];
  var_3 scripts\mp\gametypes\br_movingtrain::ref_13c94(var_0);

  if(!var_1) {
    if(level.ref_145f1.animents[0].burst_fire_turret > 0) {
      thread f11onarmoryswitchon(var_0, var_2);
      thread eyeonnotehandler(var_0);
      return;
    }

    return;
  }
}

function fadetogearingup() {
  level endon("game_ended");
  exfil_sequence("watchTrainDestroyed");
  scripts\mp\flags::gameflagwait("x2_locomotive_vulnerable");
  thread ref_13356();
  scripts\mp\flags::gameflagwait("x2_train_destroyed");
  thread extratimeincreasecount(3, 1);
  level notify("train_destroyed");
  exfil_enemy_spawning(level);
  extractupdateiconsframeend(level);
}

function exfil_enemy_spawning() {
  wait 6;
  thread scripts\mp\gametypes\br_vehicles::emptyallvehicles();
  thread scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_allowvehicleuseglobal(0);
}

function ref_13356() {
  level endon("game_ended");
  level endon("x2_train_destroyed");
  wait 3;
  level notify("finishtrain_splash");
  showsplash("br_x2_finishtrain");
}

function ref_143fd(var_0, var_1, var_2) {
  var_3 = var_2 * var_2;

  while(length2dsquared(var_0.origin - var_1) > var_3) {
    waitframe();
  }
}

function showsplash(var_0) {
  foreach(var_2 in level.players) {
    var_2 scripts\mp\hud_message::showsplash(var_0);
  }
}

function ref_13744(var_0) {
  foreach(var_2 in self.players) {
    var_2 scripts\mp\hud_message::showsplash(var_0);
  }
}

function f14_keypadnumstr(var_0, var_1) {
  level endon("game_ended");
  var_2 = 82;
  var_3 = var_1;
  thread enemy_validate_node_proximity(level, var_3);
}

function faceenemyspawn(var_0) {
  var_1 = (-90, 0, 0);
  var_2 = (0, 0, 0);

  switch (var_0) {
    case 1:
      var_2 = (4595, -1000, -160);
      var_1 = (0, 86, 0);
      break;
    case 2:
      var_2 = (-31298, 3614, -284);
      var_1 = (0, 82, 0);
      break;
    default:
      break;
  }

  var_3 = spawn("script_model", var_2);
  var_3 setModel("x2_vfx_ambushes_spawn");
  var_3.angles = var_1;
  var_3 setscriptablepartstate("base", "ambush_" + var_0);
  thread handlerocketkillsgiverockets(var_3);
}

function extracting(var_0, var_1) {
  level.ref_142d1 = var_0;

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  foreach(var_3 in level.players) {
    var_3 visionsetnakedforplayer(var_0, var_1);
  }
}

function extra_riders_intro_scene_func() {
  level endon("game_ended");
  level endon("train_destroyed");
  extracthelipadusecallback(&scripts\mp\gametypes\br_x2_bomb_quest::calculatehelispawndata);
  wait 2;

  if(!scripts\mp\flags::gameflag("x2_ambush1_starting")) {
    extracthelipadusecallback(&scripts\mp\gametypes\br_x2_amb1_quest::calculatehelispawndata);
    wait 2;
  }

  waitframe();
  exfil_speed(1);

  if(istrue(level.ref_13396)) {
    extracthelipadusecallback(&scripts\mp\gametypes\br_x2_map_quest::calculatehelispawndata);
    wait 2;
    ref_13744("br_x2_bomb_quest_signal");
    level.ref_1464e = "signal";
    var_0 = -4;
    scripts\mp\gametypes\br_x2_bomb_quest::ref_1362d(level.brneverlanded[2].position, var_0);
    scripts\mp\flags::gameflagset("x2_airstrike_begin");
    extracthelipadusecallback(&scripts\mp\gametypes\br_x2_bomb_quest::calculatehelispawndata);
    wait 2;

    if(!scripts\mp\flags::gameflag("x2_ambush2_starting")) {
      extracthelipadusecallback(&scripts\mp\gametypes\br_x2_amb1_quest::calculatehelispawndata);
      wait 2;
    }
  }

  extracthelipadusecallback(&scripts\mp\gametypes\br_x2_map_quest::calculatehelispawndata);
}

function exfil_speed(var_0) {
  if(level.ref_14632 == var_0) {
    return;
  }

  level.ref_14632 = var_0;
  level.disable_super_in_turret.ref_14653 = 0;
  level.ref_14639 = 0;
  level.ref_14651 = 0;
}

function extracthelipadusecallback(var_0) {
  var_1 = ref_14381();

  if(!isDefined(var_1)) {
    return;
  }

  var_2 = var_1[[var_0]]();
  var_2 waittill("removed");
}

function ref_14381() {
  while(self.players.size != 0) {
    foreach(var_1 in self.players) {
      if(isalive(var_1) && !istrue(var_1.inlaststand) && !var_1 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal()) {
        return var_1;
      }
    }

    wait 1;
  }

  return undefined;
}

function execution_obstacle() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");

  foreach(var_1 in level.vehicle.spawn.databyref) {
    var_1.canspawncallback = &enemygunship_attackgoal;
  }
}

function enemygunship_attackgoal(var_0, var_1, var_2, var_3) {
  var_4 = (-25571, -10031, 84);
  var_5 = 45981;

  if(distance2d(var_2.origin, var_4) > var_5) {
    return false;
  }

  var_4 = (-11360, -20916, 154);
  var_5 = 13000;

  if(distance2d(var_2.origin, var_4) < var_5) {
    return false;
  }

  var_4 = (-12737, -9293, 412);
  var_5 = 18000;

  if(distance2d(var_2.origin, var_4) < var_5) {
    return false;
  }

  var_4 = (-17354, 15846, -260);
  var_5 = 8000;

  if(distance2d(var_2.origin, var_4) < var_5) {
    return false;
  }

  var_4 = (-32195, -13969, 1605);
  var_5 = 16000;

  if(distance2d(var_2.origin, var_4) < var_5) {
    return false;
  }

  var_4 = (-18401, -34786, 1339);
  var_5 = 20000;

  if(distance2d(var_2.origin, var_4) < var_5) {
    return false;
  }

  return true;
}

function executioncashmultiplier() {
  level.ref_14643 = [];
  level.ref_1463f = [];
  var_0 = [];
  GscBinSkip0(0x2e, var_0.size, enemygunship_updatedebugflashlight("jeep", (4212, 2380, -411), (10, 72, 0)));
}

function enemygunship_updatedebugflashlight(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.refname = var_0;
  var_3.origin = var_1;
  var_3.angles = var_2;
  return var_3;
}

function extractsilentcountdown(var_0) {
  if(getdvarint("scr_br_x2_vehicle_set_enabled", 1) == 0) {
    return;
  }

  if(!isDefined(level.ref_14643)) {
    return;
  }

  var_1 = level.ref_14643[var_0];

  if(!isDefined(var_1)) {
    return;
  }

  var_2 = getdvarfloat("scr_br_x2_vehicle_set_wait", 0.5);

  if(var_2 > 0) {
    if(var_2 > 0) {
      wait var_2;
    } else {
      waitframe();
    }
  }

  var_3 = [];

  foreach(var_5 in var_1) {
    waitframe();
    var_3 = extractshowicontoplayer(var_5.refname, var_5.origin, var_5.angles);
  }

  level.ref_1463e[var_0] = var_3;
}

function extractshowicontoplayer(var_0, var_1, var_2) {
  if(level.vehiclecount >= getdvarint("scr_br_x2_vehicle_count_max", 104)) {
    return undefined;
  }

  var_3 = spawnStruct();
  var_4 = spawnStruct();
  var_4.origin = var_1;
  var_4.angles = var_2;
  var_5 = scripts\mp\gametypes\br_vehicles::tryspawnavehicle(var_0, var_4, "X2_spawns", var_3);
  return var_5;
}

function engagementcount(var_0) {
  var_0 scripts\cp_mp\vehicles\vehicle_damage::ref_14141(var_0);
  var_0 scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_deregisterinstance(var_0);
  var_0 scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_deregisterinstance(var_0);
  var_0 scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_deregisterinstance(var_0);
  var_0 scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_deregisterinstance(var_0.vehiclename, var_0 getentitynumber());
  var_0 scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(var_0);
}

function enemymarker(var_0) {
  for(var_1 = 0; var_1 <= var_0; var_1++) {
    var_2 = "ambush" + var_1;

    if(level.ref_1463e[var_2].size <= 0) {
      continue;
    }

    var_3 = [];

    foreach(var_5 in level.ref_1463e[var_2]) {
      if(!isDefined(var_5) || !isDefined(var_5.origin)) {
        continue;
      }

      var_6 = extracthelipadwatchforhelileaving(var_5.origin, 5000);

      if(isDefined(var_5.owner) || !var_5.isempty || var_6.size > 0) {
        var_3 = var_5;
        continue;
      }

      engagementcount(var_5);
    }

    level.ref_1463e[var_2] = var_3;
  }
}

function extracthelipadwatchforhelileaving(var_0, var_1) {
  var_2 = [];
  var_3 = var_1 * var_1;

  foreach(var_5 in level.players) {
    var_6 = distancesquared(var_5.origin, var_0);

    if(var_6 < var_3) {
      var_2 = var_5;
    }
  }

  return var_2;
}

function extrascore4(var_0, var_1, var_2, var_3) {
  return true;
}

function entity_movingplatform_update() {
  return (-64642, -39932, 1509);
}

function enemy_push_players_logic(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.origin = var_1;
  var_4.angles = var_2;
  var_4.ref_11f2f = var_3;
  var_4.vehicle_occupancy_isneutraltoplayer = [];
  var_5 = level.getpubliceventchance[var_0].vehicle_occupancy_isneutraltoteam.size;
  level.getpubliceventchance[var_0].vehicle_occupancy_isneutraltoteam[var_5] = var_4;
}

function exfil_heli_landing(var_0) {
  if(level.getpubliceventchance[var_0].vehicle_occupancy_isneutraltoteam.size > 0) {
    var_1 = level.getpubliceventchance[var_0].vehicle_occupancy_isneutraltoteam;

    foreach(var_3 in var_1) {
      if(!isDefined(var_3.vehicle_occupancy_isneutraltoplayer)) {
        continue;
      }

      foreach(var_5 in var_3.vehicle_occupancy_isneutraltoplayer) {
        if(isDefined(var_5)) {
          var_5 kill();
        }
      }
    }

    return;
  }
}

function extractplunderheliinvulnerable(var_0) {
  if(level.getpubliceventchance[var_0].vehicle_occupancy_isneutraltoteam.size > 0) {
    var_1 = level.getpubliceventchance[var_0].vehicle_occupancy_isneutraltoteam;

    foreach(var_3 in var_1) {
      var_4 = extractplunderhelihealth(var_3.origin, var_3.angles, var_3.ref_11f2f);
      level.getpubliceventchance[var_0].vehicle_occupancy_isneutraltoteam[var_5].vehicle_occupancy_isneutraltoplayer = var_4;
    }

    return;
  }
}

function extractplunder(var_0, var_1) {
  var_0 = scripts\engine\utility::drop_to_ground(var_0, 130);
  var_2 = scripts\mp\mp_agent::spawnnewagentaitype("enemy_lw_br_juggernaut_x2", var_0, var_1);

  if(!isDefined(var_2)) {
    return undefined;
  }

  var_2.team = scripts\mp\gametypes\br_movingtrain_armored::run_openexfil_spawn();

  if(isDefined(level.teamnamelist) && !scripts\engine\utility::array_contains(level.teamnamelist, var_2.team)) {
    level.teamnamelist = scripts\engine\utility::array_add(level.teamnamelist, var_2.team);
  }

  var_3 = getdvarint("scr_x2_health_agent", 3000);
  var_2.loadout_giveweaponobj = 1;
  var_2.maxhealth = var_3;
  var_2.health = var_3;
  return var_2;
}

function extractplunderhelihealth(var_0, var_1, var_2) {
  var_3 = [];

  if(var_2 > 1) {
    var_4 = 130;
    var_5 = 360 / var_2;

    for(var_6 = 0; var_6 < var_2; var_6++) {
      var_7 = var_6 * var_5;
      var_8 = vectortoangles((cos(var_7), sin(var_7), 0));
      var_9 = anglesToForward(var_8) * var_4;
      var_10 = var_0 + var_9;
      var_3 = extractplunder(var_10, var_1);
    }
  } else {
    GscBinSkip0(0x2e, 0, extractplunder(var_0, var_1));
  }

  return var_3;
}

function extract_dialogue_played() {
  level.agent_funcs["actor_enemy_lw_br_juggernaut_x2"]["on_damaged"] = &scripts\mp\subway_fast_travel\subway_station::callbacksoldieragentdamaged;
  level.agent_funcs["actor_enemy_lw_br_juggernaut_x2"]["gametype_on_damage_finished"] = &scripts\mp\subway_fast_travel\subway_station::callbacksoldieragentgametypedamagefinished;
  level.agent_funcs["actor_enemy_lw_br_juggernaut_x2"]["gametype_on_killed"] = &scripts\mp\subway_fast_travel\subway_station::callbacksoldieragentgametypekilled;
}

function registerscriptedagents() {
  scripts\mp\mp_agent::init_agent("mp/iw8_default_agent_definition.csv");
  scripts\engine\scriptable::scriptable_setinitcallback(&ref_12f60);
}

function ref_12f60() {
  if(!scripts\engine\utility::flag_exist("scriptables_ready")) {
    scripts\engine\utility::flag_init("scriptables_ready");
  }

  scripts\engine\utility::flag_set("scriptables_ready");
}

function extractupdateiconsframeend() {
  exfil_sequence("startOutro");
  scripts\engine\utility::flag_set("no_crate_spawning");

  foreach(var_1 in level.players) {
    var_1.ref_1463a = 1;
    thread explosion_init();
    thread extra_bomb_explode_vfx_func(var_1, "scn_x2_bombers_intro_siren_lr", var_1);
  }

  level.watch_for_objective_failed = 1;
  level.playerkillstreakgetownerlookatignoreents = 0;
  level.brking_initpostmain = 1;
  level.delay_makeuseable = 0;
  level.ref_133d8 = 1;
  wait 16;
  level notify("tease_bombers");
  extractupdateicons();
  level waittill("strike_3");
  wait 0.1;
  setmusicstate("");
  var_3 = entisvehicle();
  thread explosivemodoverride(var_3, 0);
  level waittill("strike_4");
  thread equipgasmaskbr();
  expiredlootleaderinstance();
}

function extractupdateicons() {
  exfil_sequence("startMainOutroFlow");
  wait 5;
  thread exposed_node();
  wait 2;
  enemygunship_watchweaponimpact();
  enemygunship_watchdebuglocation();
  ref_12c06();
  thread extractthink(3);
  thread enter_maze_ai_combat(17);
}

function extactioncancel() {
  enter_numbers_debug_start(1);
  extra_enemies(12, 0, 1);
  expiredbydeath("mp_warzone_intro_x2", 1);
}

function enemygunship_getshotgoal(var_0) {
  level endon("game_ended");

  if(var_0) {
    thread enter_combat_maze_ai();
    level waittill("bink_complete");
  }

  stopcinematicforall();
  enemygunship_getfiretime(0, 0, 1);
}

function exposed_node() {
  level endon("game_ended");
  enter_numbers_debug_start(1);
  exitvehicle_oldturnrate("mp_warzone_intro2_x2", 12, 1, 0, 1);
  level notify("bink_intro2_over");
  enter_numbers_debug_start(0);
}

function enter_combat_maze_ai() {
  level endon("game_ended");

  foreach(var_1 in level.players) {
    var_1 clearsoundsubmix("fade_to_black_all_except_music_and_scripted3", 0.3);
    var_1 clearsoundsubmix("fade_to_black_all", 0.3);
    var_1 setclientomnvar("ui_br_bink_overlay_state", 6);
  }

  wait 0.3;

  foreach(var_1 in level.players) {
    var_1 setclientomnvar("ui_br_bink_overlay_state", 4);
  }
}

function extractthink(var_0) {
  level endon("game_ended");
  wait var_0;
  extractunlockablechance(0);
  thread extraction_helicoptor_total_plunder();
  thread extracttablet_init(22);
}

function extractunlockablechance(var_0) {
  level notify("stop_planes");
  thread extractunlockablelootid(var_0);
  thread extractquest_unlockablelootid(entityplunderbankalldeposited(), 210, 2);
  thread extractupdatehud(5);
}

function enter_maze_ai_combat(var_0) {
  exfil_sequence("flowExfilObjective");
  level endon("game_ended");
  var_1 = getdvarfloat("scr_x2_vision_set_fade_time", 4);
  wait var_0;
  exitdriver();
  extracting("mp_don4_outro_x2", var_1);
  var_2 = gettime() * 0.001;
  thread extractiontime(0, var_2);
}

function expiredlootleaderinstance() {
  foreach(var_1 in level.players) {
    var_1.deletequestcircle = 1;
    var_1 scripts\mp\laststand::playanim_aibegindismountturret("self_revive_success", var_1);
  }

  thread eyeoffnotehandler();
  enter_numbers_debug_start(1);
  enter_combat_callback(1, 0);
  waitframe();
  wait 4;
  extra_enemies(12, 0, 1);
  var_3 = expiredbydeath("mp_warzone_x2_outro", 1);
  var_4 = 0;

  if(var_4) {
    stopcinematicforall();
    enter_numbers_debug_start(0);
    enemygunship_getfiretime(0, 0, 1);
    level.watch_for_objective_failed = 0;
  } else {
    enter_combat_callback(1, 0);
    waitframe();
    stopcinematicforall();
    enemygunship_getfiretime(0, 0, 1);
    level.defensefactormod = 0;
    level.defend_spawn_crates = 0;
    level thread scripts\mp\gamelogic::forceend();
    level waittill("game_cleanup");
    wait 2;

    foreach(var_1 in level.players) {
      if(!isDefined(var_1)) {
        continue;
      }

      var_1 clearsoundsubmix("fade_to_black_all", 0.5);
    }
  }

  level.blackoverlay destroy();
}

function extractquest_missionitem() {
  var_0 = newhudelem();
  var_0.x = 0;
  var_0.y = 0;
  var_0 setshader("black", 640, 480);
  var_0.alignx = "left";
  var_0.aligny = "top";
  var_0.horzalign = "fullscreen";
  var_0.vertalign = "fullscreen";
  var_0.sort = -1;
  var_0.alpha = 1;
  var_0 sendcollectedclientanticheatdata(1);
  return var_0;
}

function enemygunship_watchweaponimpact() {
  level endon("game_ended");
  thread scripts\mp\gametypes\br_vehicles::deleteextantvehicles();
  enemygunship_watchtargets((0, 0, 0));
}

function enemygunship_watchtargets(var_0) {
  var_1 = 250000;
  var_2 = canceljoins(undefined, undefined, var_0, var_1);

  if(isDefined(var_2)) {
    foreach(var_4 in var_2) {
      if(!scripts\mp\gametypes\br_pickups::update_gamebattles_char_loc(var_4, 0)) {
        continue;
      }

      if(var_4 getscriptableisreserved() && !isDefined(var_4.embassy_main)) {
        continue;
      }

      scripts\mp\gametypes\br_pickups::ref_11a21(var_4);
    }

    return;
  }
}

function extractiontime(var_0, var_1) {
  level endon("game_ended");
  wait var_0;
  eomawardplayerxp();
  wait 1.8;
  extractionmethod();
  extractplayers(var_1);
}

function extractplayers(var_0) {
  foreach(var_2 in level.disable_super_in_turret.onmaprestart) {
    var_3 = spawn("script_model", var_2.origin);
    var_3 setModel("x2_military_old_recon_station");
    var_4 = (0, 3, 30);
    var_5 = spawn("script_model", var_2.origin + var_4);
    var_5 scripts\mp\gameobjects::sethintobject(undefined, "HINT_BUTTON", undefined, &"BR_REVEAL_X2_EVENT/SIGNAL_POSITION", undefined, "duration_none", undefined, 350, 90, 80, 90);
    var_5 istacmapactive();
    var_5 hide();

    foreach(var_7 in var_2.ref_11e36) {
      var_5 showtoplayer(var_7);
      var_5 enableplayeruse(var_7);
      playFX(level._effect["vfx_br_x2_exfill_beacon"], var_2.origin, undefined, undefined, var_7);
      thread ref_14056(var_5);
    }

    thread init_relic_no_ammo_mun(var_5, var_2.origin, 400, var_2.ref_11e36, var_2.ref_11f8a);
  }
}

function ref_14056(var_0) {
  level endon("game_ended");
  self endon("death");
  self waittillmatch("trigger", var_0);
  self hidefromplayer(var_0);
  self disableplayeruse(var_0);
  playFX(level._effect["vfx_br_x2_flare_exfill_r"], self.origin);
  var_0 scripts\cp\vehicles\vehicle_compass_cp::ref_120a4("charm_x2");
}

function init_relic_no_ammo_mun(var_0, var_1, var_2, var_3, var_4) {
  level endon("game_ended");
  self endon("death");
  self waittill("trigger", var_5);
  var_6 = 0;
  var_7 = getdvarfloat("scr_x2_strike_1", 9);
  var_8 = getdvarfloat("scr_x2_strike_2", 12);
  var_9 = getdvarfloat("scr_x2_strike_3", 10);
  var_10 = getdvarfloat("scr_x2_strike_4", 8);
  var_11 = 2.5;
  var_6 = var_7 + var_8 + var_9 + var_10 + var_11;
  var_12 = gettime() * 0.001 - var_4;
  var_13 = var_6 - var_12;

  if(var_13 <= 0) {
    var_13 = 30;
  }

  ref_131c4("waypoint_captureneutral_br", "neutral", "BR_REVEAL_X2_EVENT/ESTABLISHING_COMMUNICATIONS", 1);
  var_14 = spawn("trigger_radius", var_0, 0, int(var_1), int(var_1));
  var_15 = scripts\mp\gametypes\obj_dom::setupobjective(var_14, undefined, undefined, 1, 0);
  var_15.flagmodel hide();
  var_15.visibilitymanuallycontrolled = 1;
  var_15.onlyexecutefromthefront = var_2;
  var_15.getrandompointincirclewithindistance = 1;
  var_15.objidnum = var_3;
  var_15 scripts\mp\gameobjects::setcapturebehavior("single_progress");
  var_15 scripts\mp\gameobjects::setusetime(var_13);
  var_15 scripts\mp\gameobjects::setclaimteam("none");
  var_15 scripts\mp\gameobjects::setvisibleteam("any", undefined, 1);
  var_15.onuseupdate = &ref_1388c;
  var_15.usecondition = &ref_1388d;
  var_15.onenduse = &scripts\mp\gametypes\obj_dom::dompoint_onuseend;
  var_15.oncontested = &scripts\mp\gametypes\obj_dom::dompoint_oncontested;
  var_15.onuncontested = &scripts\mp\gametypes\obj_dom::dompoint_onuncontested;
  var_15.onunoccupied = &scripts\mp\gametypes\obj_dom::dompoint_onunoccupied;
  var_15.onpinnedstate = &scripts\mp\gametypes\obj_dom::dompoint_onpinnedstate;
  var_15.onunpinnedstate = &scripts\mp\gametypes\obj_dom::dompoint_onunpinnedstate;
  exfil_sequence("Objective #" + var_3 + " converted into capture objective.");
}

function ref_131c4(var_0, var_1, var_2, var_3) {
  level.waypointcolors[var_0] = var_1;
  level.waypointbgtype[var_0] = 1;
  level.waypointstring[var_0] = var_2;
  level.waypointshader[var_0] = "ui_mp_br_mapmenu_icon_extraction_objective";
  level.waypointpulses[var_0] = var_3;
}

function ref_1388d(var_0) {
  if(isDefined(var_0) && scripts\engine\utility::array_contains(self.onlyexecutefromthefront, var_0)) {
    return true;
  }

  return false;
}

function ref_1388c(var_0, var_1, var_2, var_3) {
  var_4 = 0.95;

  if(var_1 > var_4) {
    self.curprogress = var_4 * self.usetime;
    self.teamprogress[self.claimteam] = self.curprogress;
  }

  if(var_1 < 1 && !level.gameended) {
    ref_12427(var_1, var_0);
  }

  if(var_1 > 0.05 && var_2 && !istrue(self.didstatusnotify)) {
    self.didstatusnotify = 1;
    return;
  }
}

function ref_12427(var_0, var_1) {
  if(!isDefined(self.lastsfxplayedtime)) {
    self.lastsfxplayedtime = gettime();
  }

  if(self.lastsfxplayedtime + 995 < gettime()) {
    self.lastsfxplayedtime = gettime();
    var_2 = "";
    var_0 = int(floor(var_0 * 10));
    var_2 = "mp_dom_capturing_tick_0" + var_0;
    self.visuals[0] playsoundtoteam(var_2, var_1);
    return;
  }
}

function extractionmethod() {
  foreach(var_1 in level.players) {
    if(isalive(var_1)) {
      var_1 scripts\mp\hud_message::showsplash("br_x2_exfil");
    }
  }
}

function eomawardplayerxp() {
  foreach(var_1 in level.disable_super_in_turret.onmaprestart) {
    var_2 = scripts\mp\objidpoolmanager::requestobjectiveid(99);
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_2);
    scripts\mp\objidpoolmanager::objective_add_objective(var_2, "current", var_1.origin + (0, 0, 80), "ui_mp_br_mapmenu_icon_extraction_tablet_x2");
    scripts\mp\objidpoolmanager::update_objective_setbackground(var_2, 1);
    scripts\mp\objidpoolmanager::ref_11f82(var_2, var_1.ref_11e36);
    level.disable_super_in_turret.onmaprestart[var_3].ref_11f8a = var_2;
  }
}

function exitdriver() {
  enemy_vehicle_setup();
  var_0 = entityplunderlosealldeposited();
  var_1 = getdvarint("scr_x2_exfil_points_failsafe_enable", 1) == 1;

  if(var_1) {
    exfil_sequence("Failsafe is enabled.");
    var_2 = 0;
    var_3 = "";

    foreach(var_5 in level.players) {
      if(!isDefined(var_5.ref_14657)) {
        var_3 += var_5.name + ", ";
        var_2++;
      }
    }

    if(isDefined(level.disable_super_in_turret.onmaprestart)) {
      exfil_sequence("Exfil points are already assigned. Skipping assignation.");
    }

    if(var_2 == 0) {
      exfil_sequence("All players have assigned points. Skipping assignation.");
    } else {
      exfil_sequence("Some players (" + var_2 + ") have unassigned points : " + var_3);
    }

    if(!isDefined(level.disable_super_in_turret.onmaprestart) && var_2 > 0) {
      level.disable_super_in_turret.onmaprestart = enemy_spawnnewscrambler(var_0);
    }

    thread equipmentuse();
  } else {
    level.disable_super_in_turret.onmaprestart = enemy_spawnnewscrambler(var_0);
  }

  exfil_retreat();
}

function enemy_spawnnewscrambler(var_0) {
  var_1 = getdvarfloat("scr_x2_exfil_distance", 150);

  foreach(var_4, var_3 in var_0) {
    var_0[var_4].ref_11e36 = [];
  }

  foreach(var_6 in level.players) {
    var_7 = undefined;
    var_8 = undefined;

    foreach(var_4, var_3 in var_0) {
      var_10 = entisalivevehicle(var_3.origin, var_6.origin);
      var_11 = abs(var_10 - var_1);

      if(!isDefined(var_8) || var_11 < var_8) {
        var_7 = var_4;
        var_8 = var_11;
      }
    }

    var_0[var_7].ref_11e36[var_0[var_7].ref_11e36.size] = var_6;
    var_6.ref_14657 = var_0[var_7];
  }

  exfil_sequence("Exfil points have been assigned to all players.");

  foreach(var_3 in var_0) {
    if(var_3.ref_11e36.size == 0) {
      var_0[var_4] = undefined;
    }
  }

  return scripts\engine\utility::array_removeundefined(var_0);
}

function exfil_retreat() {
  foreach(var_1 in level.disable_super_in_turret.onmaprestart) {
    var_2 = "Exfil Point #" + var_6 + " Players : ";

    foreach(var_4 in var_1.ref_11e36) {
      var_2 += var_4.name + ", ";

      if(var_4.ref_14657 != var_1) {
        exfil_sequence("Player " + var_4.name + " assignation and exfil assignation are different!");
      }
    }

    exfil_sequence(var_2);
  }
}

function equipmentuse() {
  level endon("game_ended");
  level endon("stop_bomb");
  var_0 = getdvarfloat("scr_x2_exfil_delay_verify_visibility", 0.05);

  for(;;) {
    if(var_0 <= 0) {
      waitframe();
    } else {
      wait var_0;
    }

    enemy_sentry_debug();
  }
}

function enemy_sentry_debug() {
  foreach(var_1 in level.disable_super_in_turret.onmaprestart) {
    if(isDefined(var_1.ref_11f8a)) {
      scripts\mp\objidpoolmanager::ref_11f82(var_1.ref_11f8a, scripts\engine\utility::array_removeundefined(var_1.ref_11e36));
    }
  }
}

function entityplunderlosealldeposited() {
  var_0 = [];
  var_1 = entity_movingplatform_update();
  var_2 = level.br_level.br_circleradii[0];
  var_3 = getdvarfloat("scr_x2_exfil_height", 50);
  var_0 = scripts\mp\gametypes\br_ending::propminigamefinish([], var_1, 1);

  if(level.script == "mp_br_mechanics") {
    return var_0;
  }

  var_4 = 0;

  foreach(var_6 in var_0) {
    if(!var_4 && distance2d(var_6.origin, var_1) > var_2) {
      var_4 = 1;
    }

    if(var_4 || var_6.origin[2] >= var_3) {
      var_0[var_7] = undefined;
    }
  }

  return scripts\engine\utility::array_removeundefined(var_0);
}

function enemy_vehicle_setup() {
  if(isDefined(level.disable_super_in_turret.onmaprestart)) {
    exfil_sequence("All existing exfil objectives cancelled.");

    foreach(var_1 in level.disable_super_in_turret.onmaprestart) {
      if(isDefined(var_1.ref_11f8a)) {
        scripts\mp\objidpoolmanager::returnobjectiveid(var_1.ref_11f8a);
        var_1.ref_11f8a = undefined;
      }
    }

    return;
  }
}

function enter_numbers_end() {
  var_0 = level.squaddata;

  if(scripts\mp\menus::brking_updateteamscore()) {
    var_0 = [level.squaddata["allies"]];
  }

  return var_0;
}

function entisalivevehicle(var_0, var_1) {
  var_2 = distance2d(var_0, var_1);
  var_3 = 0.0254 * var_2;
  return var_3;
}

function extracttablet_init(var_0) {
  level endon("game_ended");
  wait var_0;
  var_1 = getdvarfloat("scr_x2_bomb_duration", 60);
  level thread _hidesafecircleui::chase(var_1);
}

function exfil_spawners_triggered(var_0) {
  var_1 = var_0.damage;

  if(istrue(self.inlaststand) && isDefined(level.ref_12f8f) && level.ref_12f8f >= 3) {
    var_2 = var_0.meansofdeath == "MOD_TRIGGER_HURT" && var_0.objweapon.basename == "iw8_gunless";

    if(!var_2 || istrue(level.disable_super_in_turret.unset_ignoreall_after_notify)) {
      var_1 = 0;
    }

    if(var_1 >= self.health) {
      var_1 = self.health - 1;
    }
  } else if(istrue(self.ref_1463a) || isDefined(level.ref_12f8f) && level.ref_12f8f > 3) {
    if(var_1 >= self.health) {
      var_1 = self.health - 1;
    }
  }

  return var_1;
}

function extraction_helicoptor_total_plunder() {
  level endon("game_ended");
  level waittill("bomb_started");
  var_0 = [];
  GscBinSkip0(0x2e, var_0.size, getdvarfloat("scr_x2_strike_1", 9));
}

function exfil_objective(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("disconnect");
  thread exit_level(var_1, var_0);
  wait 1;
  var_2 = anglesToForward(var_0.angles);
  var_3 = var_0.origin + var_2 * 300;
  var_4 = var_0.maxhealth / 2;
  var_5 = 0;
  var_6 = 6;
  level thread _hidesafecircleui::ref_12e21(var_3, 0, var_0);
  wait 0.15;

  switch (var_1) {
    case 1:
      extract_ismissionweapon(var_0);
      break;
    case 3:
      scripts\mp\gametypes\br::scriptednode(var_0);
      var_0.ref_1463a = 0;
      var_4 = 9999;
      var_5 = 1;
      var_6 = 3.5;
      var_0 scripts\mp\utility\player::hidehudenable();
      var_0.littlebirdsmg = 1;
      break;
    case 4:
      var_3 = var_0.origin;
      break;
  }

  extratimeincreasecountcap(var_0, var_6, var_5, 1);

  if(!istrue(var_0.unset_relic_trex) && var_1 <= 3) {
    var_0 dodamage(var_4, var_3, var_0, undefined, "MOD_EXPLOSIVE", "artillery_mp");
  }

  var_0.ref_1463a = 1;
  level notify("strike_" + var_1);
}

function engagementtime(var_0, var_1) {
  level endon("game_ended");
  wait var_0;

  foreach(var_3 in level.players) {
    var_3 scripts\common\utility::allow_mantle(0);
  }

  wait var_1;

  foreach(var_3 in level.players) {
    var_3 scripts\common\utility::allow_mantle(1);
  }
}

function extract_ismissionweapon() {
  var_0 = self.meleeweapons;

  if(var_0.size == 0) {
    var_0 = ["iw8_fists_mp"];
  }

  self takeallweapons();

  foreach(var_2 in var_0) {
    self giveweapon(var_2);
    self assignweaponmeleeslot(var_2);
    self switchtoweapon(var_2);
  }
}

function extratimeincreasecountcap(var_0, var_1, var_2) {
  var_1 = istrue(var_1);
  var_2 = istrue(var_2);

  if(scripts\mp\utility\perk::_hasperk("specialty_stun_resistance")) {
    scripts\mp\utility\perk::removeperk("specialty_stun_resistance");
  }

  scripts\mp\weapons::setplayerstunned();
  thread scripts\mp\weapons::cleanupconcussionstun(var_0);
  scripts\cp_mp\utility\shellshock_utility::_stopshellshock();

  if(var_2) {
    if(var_1) {
      scripts\cp_mp\utility\shellshock_utility::_shellshock("flash_grenade_mp_x2", "bottom", var_0, 1);
      return;
    }

    scripts\cp_mp\utility\shellshock_utility::_shellshock("mp_don4_x2_explosion_outro", "bottom", var_0, 1);
    return;
  }

  scripts\cp_mp\utility\shellshock_utility::_shellshock("mp_don4_x2_explosion", "bottom", var_0, 1);
}

function extractunlockablelootid(var_0) {
  level endon("game_ended");
  level endon("stop_planes");
  var_1 = getdvarint("scr_x2_planes_enable", 1);

  if(var_1 <= 0) {
    return;
  }

  if(!isDefined(level.disable_super_in_turret.ref_123ac)) {
    level.disable_super_in_turret.ref_123ac = 0;
  }

  foreach(var_3 in level.players) {
    var_3 setclienttriggeraudiozonepartialwithfade("br_x2_bombers_attack", 3, "reverb", "mix", "filter", "ambient");
  }

  var_5 = getdvarfloat("scr_x2_planes_delay", 5.5);
  var_6 = 0;

  for(;;) {
    thread extractlocale_onentergulag(entityplunderbankalldeposited(), var_6);
    var_6++;
    wait var_5;
  }
}

function extractlocale_onentergulag(var_0, var_1) {
  level endon("game_ended");
  level endon("stop_planes");
  var_2 = 300;
  var_0 = (var_0[0] + -10000, var_0[1] + -8000, -6000);
  var_3 = vectortoangles((cos(var_2), sin(var_2), 0));
  var_4 = scripts\engine\utility::spawn_tag_origin(var_0, var_3);
  var_5 = [];
  var_6 = ["plane3", "plane4", "plane5"];

  if(istrue(level.disable_super_in_turret.unset_ignoreall_after_notify)) {
    var_6 = ["plane3"];
  }

  foreach(var_8 in var_6) {
    var_9 = extractlocale_islocaleavailable((0, 0, 0));
    var_9.animname = var_8;
    var_9 useanimtree(level.scr_animtree[var_8]);
    var_9 unmarkkeyframedmover(1);
    var_5 = var_9;
  }

  thread enemy_traversal_management(var_4, var_5, var_1);
  var_4 scripts\common\anim::anim_single(var_5, "x2_plane", undefined, 17);
  level notify("end_wave_" + var_1);
}

function enemy_traversal_management(var_0, var_1, var_2) {
  level endon("game_ended");
  var_3 = var_1.size + 1;
  level.disable_super_in_turret.ref_123ac += var_3;
  level scripts\engine\utility::ref_143ad("stop_planes", "end_wave_" + var_2);

  foreach(var_5 in var_1) {
    var_5 delete();
  }

  var_0 delete();
  level.disable_super_in_turret.ref_123ac -= var_3;
}

function extractlocale_onrespawn(var_0) {
  level notify("stop_planes");

  if(!isDefined(level.disable_super_in_turret.ref_123ac)) {
    level.disable_super_in_turret.ref_123ac = 0;
  }

  var_1 = (-50000, -15000, 0);
  var_2 = (12000, 0, 0);
  var_3 = 6;

  for(var_4 = 0; var_4 < var_3; var_4++) {
    var_5 = var_0 + var_1 + var_4 * var_2;
    thread extractlocale_onentergulag(var_5, var_4);
  }
}

function extractlocale_islocaleavailable(var_0) {
  var_1 = spawn("script_model", var_0);
  var_1 setModel("veh8_mil_air_ca_ger_bomber_117_group_ultralow");
  var_1.angles = (0, 0, 0);
  return var_1;
}

function entityplunderbankalldeposited() {
  var_0 = scripts\engine\utility::array_removeundefined(level.players);
  return scripts\mp\gametypes\br_ending::get_center_of_array(var_0);
}

function extractupdatehud(var_0) {
  level endon("game_ended");
  level endon("stop_planes");
  var_1 = getdvarint("scr_x2_shadows_enable", 1);

  if(var_1 <= 0) {
    return;
  }

  wait var_0;
  setDvar("sm_sunSampleSizeNear", 0.8);
  setDvar("sm_sunCascadeSizeMultiplier1", 1);
  setDvar("sm_sunCascadeSizeMultiplier2", 2);
  level.disable_super_in_turret.ref_119dc = [];
  thread equipname();
  var_2 = 210;
  var_3 = (cos(var_2 + 90), sin(var_2 + 90), 0);
  var_4 = var_3 * 6500;

  for(;;) {
    var_5 = entityplunderbankalldeposited();
    thread extractquest_alwaysallowdeposit(var_5, var_2);
    thread extractquest_alwaysallowdeposit(var_5 + var_4, var_2);
    thread extractquest_alwaysallowdeposit(var_5 - var_4, var_2);
    wait 25;
  }
}

function equipname() {
  level endon("game_ended");
  level waittill("stop_planes");
  enemygunship_watchplanedistance();
}

function enemygunship_watchplanedistance() {
  if(isDefined(level.disable_super_in_turret.ref_1374a)) {
    level.disable_super_in_turret.ref_1374a delete();
  }

  level.disable_super_in_turret.ref_1374a = undefined;

  if(isDefined(level.disable_super_in_turret.ref_119dc)) {
    for(var_0 = 0; var_0 < level.disable_super_in_turret.ref_119dc.size; var_0++) {
      var_1 = level.disable_super_in_turret.ref_119dc[var_0];

      if(isDefined(var_1)) {
        var_1 delete();
      }
    }
  }

  level.disable_super_in_turret.ref_119dc = [];
}

function extractquest_alwaysallowdeposit(var_0, var_1) {
  level endon("game_ended");
  var_2 = extractquest_missionweapon(var_0, var_1, "vfx_br_x2_plane_shadow_multiple");

  for(var_3 = 0; var_3 <= level.disable_super_in_turret.ref_119dc.size; var_3++) {
    if(!isDefined(level.disable_super_in_turret.ref_119dc[var_3])) {
      level.disable_super_in_turret.ref_119dc[var_3] = var_2;
      break;
    }
  }

  wait 40;

  if(isDefined(var_2)) {
    var_2 delete();
    return;
  }
}

function extractquest_unlockablelootid(var_0, var_1, var_2) {
  level endon("game_ended");
  level endon("stop_planes");
  wait var_2;
  var_3 = extractquest_missionweapon(var_0, var_1, "vfx_br_x2_square_shadow");

  if(isDefined(level.disable_super_in_turret.ref_1374a)) {
    level.disable_super_in_turret.ref_1374a delete();
  }

  level.disable_super_in_turret.ref_1374a = var_3;
  wait 120;

  if(isDefined(var_3)) {
    var_3 delete();
    return;
  }
}

function extractquest_missionweapon(var_0, var_1, var_2) {
  var_0 = (var_0[0], var_0[1], 2000);
  var_3 = vectortoangles((cos(var_1), sin(var_1), 0));
  var_4 = spawn("script_model", var_0);
  var_4 setModel(var_2);
  var_4.angles = var_3;
  return var_4;
}

function exitvehicle_oldturnrate(var_0, var_1, var_2, var_3, var_4) {
  level endon("game_ended");
  extra_enemies(var_1, var_2, var_3);
  expiredbydeath(var_0, var_4);
  stopcinematicforall();
  enemygunship_getfiretime(0, var_2, var_3);
}

function extra_enemies(var_0, var_1, var_2) {
  foreach(var_4 in level.players) {
    if(!isDefined(var_4)) {
      continue;
    }

    var_4 setclientomnvar("ui_br_bink_overlay_state", var_0);

    if(var_1) {
      var_4 setsoundsubmix("fade_to_black_all_except_music_and_scripted3", 0.5);
    }

    if(var_2) {
      var_4 setsoundsubmix("fade_to_black_all", 0.5);
    }
  }
}

function enemygunship_getfiretime(var_0, var_1, var_2) {
  foreach(var_4 in level.players) {
    if(!isDefined(var_4)) {
      continue;
    }

    if(var_1) {
      var_4 clearsoundsubmix("fade_to_black_all_except_music_and_scripted3", 0.5);
    }

    if(var_2) {
      var_4 clearsoundsubmix("fade_to_black_all", 0.5);
    }

    var_4 setclientomnvar("ui_br_bink_overlay_state", var_0);
  }
}

function exfil_spots_objs_settings(var_0, var_1) {
  if(var_0 == "bink_complete") {
    level notify("bink_complete");
    return;
  }
}

function expirationtimer(var_0, var_1) {
  level notify("bink_start");
  playcinematicforall(var_0, 1, var_1);
}

function expiredbydeath(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;
  var_4 = getdvarint("scr_x2_max_attempt_binks", 1);
  jumpiffalse(var_4 < 1) LOC_00000020;
  var_4 = 1;

  while(!var_3 && var_2 < var_4) {
    expirationtimer(var_0, var_1);

    if(var_2 == 0) {
      switch (var_0) {
        case "mp_warzone_x2_outro":
          waitframe();
          enter_combat_callback(0, 0);
          level.blackoverlay = extractquest_missionitem();
          break;
      }
    }

    var_5 = scripts\engine\utility::ref_143bf(3, "bink_complete");
    var_3 = var_5 == "timeout";

    if(!var_3) {
      exfil_sequence("Failed to play bink '" + var_0 + "', attempt #" + var_2 + 1 + ", waittill return value is " + var_5);
    }

    var_2++;

    if(!var_3 && var_2 < var_4) {
      stopcinematicforall();
      enemygunship_getfiretime(0, 0, 0);
      waitframe();
      extra_enemies(12, 0, 0);
    }
  }

  if(var_0 == "mp_warzone_intro_x2") {
    thread enemygunship_watchdamage();
  }

  if(var_3) {
    switch (var_0) {
      case "mp_warzone_intro_x2":
        wait 19;
        enter_numbers_debug_start(0);
        thread enemygunship_getshotgoal(var_3);
        break;
      case "mp_warzone_x2_outro":
      case "mp_warzone_intro2_x2":
        wait 7.5;

        foreach(var_7 in level.players) {
          var_7 setclientomnvar("ui_br_bink_overlay_state", 10);
        }

        break;
    }

    level waittill("bink_complete");
  } else {
    switch (var_0) {
      case "mp_warzone_intro_x2":
        stopcinematicforall();
        enter_numbers_debug_start(0);
        enemygunship_getfiretime(0, 0, 1);
        break;
    }
  }

  return var_3;
}

function enemygunship_watchdamage() {
  wait 16;
  scripts\mp\gametypes\br_movingtrain::tr_findvehicle(1);
}

function enter_combat_callback(var_0, var_1) {
  foreach(var_3 in level.players) {
    thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(var_3, var_0, var_1);
  }

  if(var_1 > 0) {
    wait var_1;
    return;
  }
}

function enter_numbers_debug_start(var_0, var_1) {
  foreach(var_3 in level.players) {
    var_3 scripts\mp\utility\player::_freezecontrols(var_0, var_1);
  }
}

function equip_trophies() {
  level endon("game_ended");

  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }

    var_1 scripts\cp\vehicles\vehicle_compass_cp::ref_120a4("emblem_1_x2");
  }
}

function equipgasmaskbr() {
  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }

    var_1 scripts\cp\vehicles\vehicle_compass_cp::ref_120a4("rpd_blueprint");
  }
}

function equipprimarypickup(var_0, var_1) {
  if(var_0 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    var_0 = var_0.owner;
  }

  if(!isDefined(var_0) || !isPlayer(var_0)) {
    return;
  }

  if(!isDefined(var_0.ref_14656)) {
    exclude_me(var_0);
  }

  var_0.ref_14656["train"] = var_0.ref_14656["train"] + var_1;
  var_2 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_0.team, var_0.squadindex);

  while(var_0.ref_14656["train"] > 1000) {
    var_0 thread scripts\mp\utility\points::giveunifiedpoints("br_x2_train_damage");
    extractgroundpos(var_0, var_2, level.ent_delete_by_targetname);
    var_0.ref_14656["train"] = var_0.ref_14656["train"] - 1000;
  }
}

function equipsecondarypickup(var_0, var_1) {
  if(var_0 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    var_0 = var_0.owner;
  }

  if(!isDefined(var_0) || !isPlayer(var_0)) {
    return;
  }

  var_2 = var_0 getxuid();

  if(!isDefined(var_0.ref_14656)) {
    exclude_me(var_0);
  }

  var_0.ref_14656["turret"] = var_0.ref_14656["turret"] + var_1;
  var_3 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_0.team, var_0.squadindex);

  while(var_0.ref_14656["turret"] > 500) {
    var_0 thread scripts\mp\utility\points::giveunifiedpoints("br_x2_turret_damage");
    extractgroundpos(var_0, var_3, level.ent_model);
    var_0.ref_14656["turret"] = var_0.ref_14656["turret"] - 500;
  }

  if(self.health <= 0) {
    foreach(var_5 in level.players) {
      var_5 thread scripts\mp\utility\points::giveunifiedpoints("br_x2_turret_disabled");
    }

    return;
  }
}

function extractgroundpos(var_0, var_1, var_2) {
  foreach(var_4 in var_1) {
    if(!isDefined(var_4)) {
      continue;
    }

    if(var_4 == var_0) {
      continue;
    }

    if(enemy_waittill_seen(var_4)) {
      var_4 thread scripts\mp\utility\points::giveunifiedpoints("br_x2_driver_assist");
      scripts\mp\gametypes\br_movingtrain_armored::ref_13fcf(var_4, 105);
    }
  }
}

function enemy_waittill_seen(var_0) {
  if(var_0 scripts\cp_mp\utility\player_utility::isinvehicle()) {
    var_1 = var_0 scripts\cp_mp\utility\player_utility::getvehicle();

    if(!isDefined(var_1)) {
      return false;
    }

    var_2 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(var_1, 1);

    if(isDefined(var_2) && var_2 == var_0) {
      var_3 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var_1, 1);

      if(isDefined(var_3) && var_3.size > 1) {
        return true;
      }

      var_4 = scripts\mp\utility\player::getplayersinradius(var_1.origin, 200);

      foreach(var_6 in var_4) {
        if(!isDefined(var_6)) {
          continue;
        }

        if(var_6 == var_0) {
          continue;
        }

        var_7 = var_6 getgroundentity();

        if(isDefined(var_7) && var_7 == var_1) {
          return true;
        }
      }
    }
  }

  return false;
}

function escort_vehicle_push_volume() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");

  foreach(var_1 in level.players) {
    exclude_me(var_1);
  }
}

function exclude_me() {
  self.ref_14656 = [];
  self.ref_14656["train"] = 0;
  self.ref_14656["turret"] = 0;
}

function excludedteams() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");

  foreach(var_1 in level.players) {
    var_1 scripts\mp\utility\perk::giveperk("specialty_surveillance");
  }
}

function extractquest_helipadid() {
  level endon("game_ended");
  self.itemsdropped = 0;
  var_0 = [["brloot_weapon_lm_t9accurate_lege", 5], ["brloot_super_munitionsbox", 10], ["brloot_weapon_lm_t9light_lege", 5], ["brloot_ammo_762", 15], ["brloot_weapon_lm_t9accurate_lege", 5], ["brloot_ammo_rocket", 15], ["brloot_weapon_lm_t9light_lege", 5]];
  var_1 = spawnStruct();
  var_1.origin = self.origin;
  var_1.angles = self.angles;
  var_1.dropstruct = scripts\mp\gametypes\br_pickups::test_ai_anim();
  var_1.dropstruct.ml_p3_to_safehouse_transition = 250;
  var_1.dropstruct.silencer_pick_up_monitor = 150;
  var_2 = self.angles + (0, 45, 0);

  foreach(var_4 in var_0) {
    var_5 = var_4[0];
    var_6 = var_4[1];

    if(scripts\mp\gametypes\br_lootcache::get_bonus_targets(var_5)) {
      for(var_7 = 0; var_7 < var_6; var_7++) {
        var_8 = scripts\mp\gametypes\br_lootcache::ref_11a41(var_5, var_1.dropstruct, self.origin + (0, 0, var_1.dropstruct.silencer_pick_up_monitor), var_2, 0, 0);
        var_1.dropstruct.silencer_pick_up_monitor += 3;
        self.itemsdropped++;
        waitframe();
      }
    }
  }
}

function exfil_spawning_logic() {
  level endon("game_ended");
  level waittill("bink_complete");
  setmusicstate("mx_train_approach_1");
  level waittill("activateMortar");
  setmusicstate("");
  level waittill("finishtrain_splash");
  setmusicstate("mx_train_critical");
  level waittill("train_destroyed");
  setmusicstate("");
  level waittill("bink_start");
  setmusicstate("mx_plane_outro_cine");
}

function explode_fx() {
  self endon("disconnect");
  self waittill("infil_jump_done");
  thread expiredlootleaderenabled("mode_desc1", 0, 1);
  thread expiredlootleaderenabled("mode_desc2", 0, 1);
  thread expiredlootleaderenabled("mode_desc3", 0, 1);
  thread explosionspots();
  thread explosive_barrel();
  self endon("bomb_used");

  while(!self isonground()) {
    waitframe();
  }

  thread expiredlootleaderenabled("objective1_desc", 1, 1);
}

function explosive_barrel() {
  level endon("game_ended");
  self endon("disconnect");
  level endon("train_destroyed");
  level waittill("car_vulnerable");
  scripts\mp\hud_message::showsplash("br_x2_train_stopped");
  thread expiredlootleaderenabled("car_vulnerable", 1, 1);
  wait 10;

  while(level.ref_145f1.ref_13cca < 12) {
    level waittill("train_part_destroyed");

    switch (level.ref_145f1.ref_13cca) {
      case 6:
        thread expiredlootleaderenabled("destroy_part6", 1.5, 1);
        break;
      case 11:
        thread expiredlootleaderenabled("destroy_part11", 1.5, 1);
        break;
      default:
        break;
    }
  }

  for(;;) {
    level waittill("car_destroyed");

    if(level.ref_14635 == 7) {
      thread expiredlootleaderenabled("destroy_car7", 1.5, 1);
    }
  }
}

function explosionspots() {
  level endon("game_ended");
  self endon("disconnect");
  level endon("train_destroyed");

  for(;;) {
    level waittill("train_incoming");

    switch (level.initextractionlocations) {
      case 1:
        thread expiredlootleaderenabled("train_incoming1", 3, 1);
        level waittill("train_braking");
        thread expiredlootleaderenabled("train_stopped1", 1, 1);
        break;
      case 2:
        if(istrue(level.ref_13396)) {
          thread expiredlootleaderenabled("train_incoming2", 1, 1);
        }

        break;
      default:
        break;
    }
  }
}

function explosion_init() {
  level endon("game_ended");
  self endon("disconnect");
  thread expiredlootleaderenabled("outro_victory", 5.5, 1);
  level waittill("tease_bombers");
  thread expiredlootleaderenabled("outro_bombers_tease", 1, 0);
  level waittill("bink_intro2_over");
  thread expiredlootleaderenabled("outro_bombers", 3, 0);
  level waittill("strike_1");
  thread expiredlootleaderenabled("outro_exfil_coming", 0.5, 0);
  var_0 = self.ref_14657;
  var_1 = distance(var_0.origin, self.origin);

  if(var_1 >= 2700) {
    thread expiredlootleaderenabled("outro_keep_running", 8, 0);
  }

  level waittill("strike_2");
  thread expiredlootleaderenabled("outro_exfil_almost_over", 5.5, 0);
}

function expiredlootleaderenabled(var_0, var_1, var_2) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(var_1) && var_1 > 0) {
    wait var_1;
  }

  if(isDefined(var_2) && var_2 == 1) {
    scripts\mp\gametypes\br_public::dmztut_endgamewithreward(var_0, self, 0);
    return;
  }

  var_3 = lookupsoundlength(game["dialog"][var_0], 1) / 1000;
  self queuedialogforplayer(game["dialog"][var_0], var_0, var_3);
}

function extendcirclelist() {
  level endon("game_ended");
  level waittill("drop_resuply");
  var_0 = randomint(2);
  var_1 = "resuply_drop" + var_0;

  foreach(var_3 in level.players) {
    thread expiredlootleaderenabled(var_3, var_1, 0);
  }
}

function entisvehicle() {
  var_0 = undefined;

  if(level.script == "mp_don4") {
    var_0 = spawnStruct();
    var_0.origin = (4555.72, -36115.3, -200.848);
    var_0.angles = (0, -156.66, 0);
    var_1 = getdvarfloat("scr_x2_exfil_x_offset", 1000);
    var_2 = getdvarfloat("scr_x2_exfil_y_offset", 600);
    var_0.origin += (var_1, var_2, 0);
  } else {
    if(!isDefined(level.disable_super_in_turret.onmaprestart)) {
      exitdriver();
    }

    var_0 = level.disable_super_in_turret.onmaprestart[0];
  }

  var_3 = getdvarfloat("scr_x2_exfil_angle", -60);
  var_0.angles = (0, var_3, 0);
  return var_0;
}

function explosivemodoverride(var_0, var_1) {
  level endon("game_ended");
  level.disable_super_in_turret.unset_ignoreall_after_notify = 1;
  thread extra_glow_sticks_init(var_0);
  level.disable_super_in_turret.onlineprimaryoverride = [];
  var_2 = scripts\engine\utility::spawn_tag_origin(var_0.origin, var_0.angles);
  scripts\engine\utility::exploder("x2_se_juggernaut");
  var_3 = 1;

  while(var_3) {
    var_3 = getdvarint("scr_x2_exfil_loop", 0) > 0;
    level.disable_super_in_turret.update_game_cyber = var_3;

    foreach(var_5 in level.players) {
      if(!isDefined(var_5)) {
        continue;
      }

      thread extactionstart(var_5);
      thread enemy_spawners();
      var_5 setclientdvar("LTMOQONPQ", 1);
      var_5 setclientdvar("cg_fov", 90);
    }

    scripts\engine\utility::ref_143bf(10, "strike_4");
    level notify("stop_bomb");
    enter_combat_callback(1, 0);
    waitframe();

    foreach(var_5 in level.players) {
      var_5 setclientdvar("LTMOQONPQ", 0);
      var_5 setclientdvar("cg_fov", 65);
    }
  }

  level.disable_super_in_turret.unset_ignoreall_after_notify = 0;
  scripts\engine\utility::kill_exploder("x2_se_juggernaut");

  foreach(var_5 in level.players) {
    var_5 scripts\mp\utility\player::hidehuddisable();
    var_5 playershow();
    var_5 clearclienttriggeraudiozone(0);
  }

  if(var_1) {
    wait 2;
    enter_combat_callback(0, 0);

    foreach(var_5 in level.players) {
      var_5 scripts\mp\utility\player::_freezecontrols(0);
      var_5 clearsoundsubmix("fade_to_black_all_except_music_and_scripted3", 0.5);
      var_5 clearsoundsubmix("fade_to_black_all", 0.5);
    }
  }

  level notify("stop_planes");
}

function extra_glow_sticks_init(var_0) {
  level endon("game_ended");
  var_1 = 0;

  foreach(var_3 in level.players) {
    if(!var_1) {
      var_3 scripts\mp\utility\player::_freezecontrols(1);
    }

    var_3 clearsoundsubmix("deaths_door_mp", 0.3);
    var_3 setOrigin(var_0.origin);
    var_3 scripts\mp\utility\player::hidehudenable();
    var_3 playerhide();
  }

  extracting("mp_don4_exfil_x2", 0);
  extractlocale_onrespawn(var_0.origin);
  _hidesafecircleui::ref_13b3f(1100);
}

function extractmissionhelipadmodel(var_0) {
  for(var_1 = 1; var_1 <= 3; var_1++) {
    var_2 = "guy" + var_1;
    var_3 = extractposition((0, 0, 0), (0, 0, 0));
    explosive_cars(var_0, var_3, var_2);
    level.disable_super_in_turret.onlineprimaryoverride[var_2] = var_3;
  }

  var_4 = extractquest_removequestinstance((0, 0, 0), (0, 0, 0));
  explosive_cars(var_0, var_4, "guy4");
  level.disable_super_in_turret.onlineprimaryoverride["guy4"] = var_4;
}

function explosive_cars(var_0, var_1, var_2) {
  var_1.animname = var_2;
  var_1 useanimtree(level.scr_animtree[var_2]);
  var_0 thread scripts\common\anim::anim_single_solo(var_1, "x2_exfil");

  if(isDefined(var_1.headmodel)) {
    var_1.headmodel scriptmodelplayanim(level.scr_animname[var_2]["x2_exfil_mute"]);
  }

  if(isDefined(var_1.ref_14595)) {
    var_1.ref_14595 scriptmodelplayanim(level.scr_animname[var_2]["x2_exfil_mute"]);
    return;
  }
}

function extactionstart(var_0) {
  level endon("game_ended");
  var_1 = spawn("script_arms", (0, 0, 0), 0, 0, self);
  var_1.angles = (0, 0, 0);
  var_1 useanimtree(#animtree);
  var_1 hide();
  var_1 showtoplayer(self);
  self.ref_12651 = var_1;
  var_2 = 0;

  if(!var_2) {
    self cameralinkTo(var_1, "tag_camera", 1, 1);
  }

  var_1 animScripted("exfil", var_0.origin, var_0.angles, %br_exfil_x2_player);
  var_1 scriptmodelplayanim("br_exfil_x2_player");
  var_1 waittillmatch("exfil", "end");
  self cameraunlink();
  self stopanimscriptsceneevent();
  self.ref_12651 = undefined;
  var_1 delete();
}

function enemygunship_watchexfilsequencestart() {
  var_0 = ["guy1", "guy2", "guy3", "guy4"];

  foreach(var_2 in var_0) {
    var_3 = level.disable_super_in_turret.onlineprimaryoverride[var_2];

    if(isDefined(var_3)) {
      if(isDefined(var_3.headmodel)) {
        var_3.headmodel delete();
      }

      if(isDefined(var_3.ref_14595)) {
        var_3.ref_14595 delete();
      }

      var_3 delete();
    }
  }
}

function extractquest_removequestinstance(var_0, var_1) {
  return extractlocale_removelocaleinstance(var_0, var_1, "body_mp_western_fireteam_west_ar_1_1", "head_mp_western_fireteam_west_ar_1_1", undefined);
}

function extractposition(var_0, var_1) {
  return extractlocale_removelocaleinstance(var_0, var_1, "body_opforce_juggernaut_x2", "head_opforce_juggernaut_x2", "weapon_wm_lm_dblmg_juggernaut");
}

function extractlocale_removelocaleinstance(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawn("script_model", var_0);
  var_5 setModel(var_2);
  var_5.angles = var_1;

  if(isDefined(var_3)) {
    var_6 = spawn("script_model", var_0);
    var_6 setModel(var_3);
    var_6 linkTo(var_5, "j_spine4", (0, 0, 0), (0, 0, 0));
    var_5.headmodel = var_6;
  }

  if(isDefined(var_4)) {
    var_7 = spawn("script_model", var_0);
    var_7 setModel(var_4);
    var_7 linkTo(var_5, "j_gun", (0, 0, 0), (0, 0, 0));
    var_5.ref_14595 = var_7;
  }

  return var_5;
}

function enemy_spawners() {
  level endon("game_ended");
  self endon("disconnect");
  self setblurforplayer(5, 0);
  wait 0.5;
  self setblurforplayer(0, 2);
  wait 2;
  self setblurforplayer(5, 0.5);
  wait 0.5;
  self setblurforplayer(0, 0.5);
  wait 2;
  self setblurforplayer(6, 0.5);
  wait 0.5;
  self setblurforplayer(0, 0.5);
  wait 2;
  self setblurforplayer(7, 0.5);
  wait 0.5;
  self setblurforplayer(0, 1);
}

function enemy_validate_node_proximity(var_0, var_1) {
  level endon("game_ended");
  var_2 = spawnStruct();
  var_2.streakname = "precision_airstrike";
  var_2.owner = level.players[0];
  var_2.score = 0;
  var_2.shots_fired = 0;
  var_2.hits = 0;
  var_2.damage = 0;
  var_2.kills = 0;
  var_2.setuptimelimit = 1;
  var_2.brmini_ontimelimit = 0;
  var_2.burst_fire_turret = 0.65;
  var_2.animname = % mp_alfa10_flyin;
  var_2.ref_1360d = 1;
  var_2.ref_12186 = 1;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = 24000;
  var_6 = 6500;
  var_7 = 950;
  var_8 = 1500;
  var_9 = 215;
  var_10 = (0, var_1, 0);
  var_11 = undefined;
  var_12 = scripts\cp_mp\killstreaks\airstrike::getflightpath(var_0, var_10, var_5, 1, var_7, var_6, var_8, var_2.streakname, var_11);
  var_13 = [];
  GscBinSkip0(0x2e, var_13.size, (0, 0, 0));
}

function extra_collision() {
  if(isDefined(self.streakinfo.burst_fire_turret) && isDefined(self.streakinfo.animname)) {
    self setanimrate(self.streakinfo.animname, self.streakinfo.burst_fire_turret);
    return;
  }
}

function escape_if_player_is_in_hangar(var_0, var_1, var_2, var_3, var_4) {
  var_0 endon("death");

  if(!istrue(var_0.streakinfo.ref_1360d)) {
    return;
  }

  if(isDefined(var_0.streakinfo.burst_fire_turret)) {
    var_1 = (var_1 + 1.25) / var_0.streakinfo.burst_fire_turret;
  } else {
    var_1 = var_1;
  }

  var_5 = var_0.flightdir;
  var_0.bulletpoint setModel("ks_airstrike_target_mp_x2");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_1);
  var_6 = 5;
  var_7 = (0, 0, 0);
  var_8 = var_7;
  var_0.bulletpoint setscriptablepartstate("bullet_impact", "on", 0);
  var_9 = 0;
  var_10 = 0;
  var_11 = [var_3 - var_5 * 512, var_3 - var_5 * 256, var_3, var_3 + var_5 * 256, var_3 + var_5 * 512];
  var_12 = var_3[2] + var_0.flightheight * 3;

  for(var_13 = 0; var_13 < var_6; var_13++) {
    var_14 = -50;
    var_15 = 150;

    while(var_9 < var_10 + 4) {
      var_16 = scripts\cp_mp\killstreaks\airstrike::callstrike_getrandomshotoffset(var_14, var_15, var_11[var_13], var_0.angles);
      var_17 = var_0 gettagorigin("tag_turret_fx") * (1, 1, 0) + (0, 0, var_12) + var_5 * 1000;
      var_18 = vectorNormalize(var_16 - var_17);
      var_19 = var_16 + var_18 * 30000;
      var_20 = scripts\engine\trace::ray_trace(var_17, var_19, undefined, scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 1, 0));
      var_21 = var_20["position"];
      var_22 = var_20["normal"];
      var_23 = var_21 + var_22 * 10;
      var_24 = vectorNormalize(var_21 - var_0 gettagorigin("tag_turret_fx"));
      var_25 = vectorcross(var_24, (0, 0, 1));
      var_26 = vectorcross(var_25, var_24);
      var_0 thread scripts\cp_mp\killstreaks\airstrike::callstrike_playmultitracerfx(scripts\engine\utility::getfx("airstrike_tracer"), var_23, var_24, var_26);
      var_0.bulletpoint thread scripts\cp_mp\killstreaks\airstrike::moveanddamagepoint(var_9 + 1, var_23);
      var_8 = var_21;
      var_9++;
      var_0.bulletpoint.streakinfo.shots_fired++;
      var_14 += 20;
      var_15 += 40;
      var_12 -= 200;

      if(var_12 < var_0.flightheight) {
        var_12 = var_0.flightheight;
      }

      wait 0.05;
    }

    var_10 = var_9;
  }

  var_0 notify("fire_finished");
  var_0.bulletpoint setscriptablepartstate("bullet_impact", "off", 0);
}

function exit_open(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_0 endon("death");
  level endon("game_ended");
  var_0 thread scripts\cp_mp\killstreaks\airstrike::airstrike_delayplayscriptable(0.05);
  var_7 = 1.65 / var_6.burst_fire_turret;
  var_8 = 6.917 / var_6.burst_fire_turret;
  var_9 = (var_4 + 1.25) / var_6.burst_fire_turret;
  var_10 = 30;
  var_0.player_waittilljumpedfromc130 = spawn("script_model", var_1);
  var_0.player_waittilljumpedfromc130 setModel("ks_airstrike_mp");
  var_0.player_waittilljumpedfromc130 dontinterpolate();
  var_0.player_waittilljumpedfromc130 thread scripts\cp_mp\killstreaks\airstrike::airstrike_playapproachfx(var_7);
  var_0.player_waittilljumpedfromc130 thread scripts\cp_mp\killstreaks\airstrike::airstrike_playflybyfx(var_8);
  var_0.player_waittilljumpedfromc130 thread scripts\cp_mp\killstreaks\airstrike::airstrike_playflyoutfx(var_9);
  var_0.player_waittilljumpedfromc130 thread scripts\cp_mp\killstreaks\airstrike::airstrike_handleflyoutfxdeath(var_10);
  var_0.player_waittilljumpedfromc130 thread scripts\cp_mp\killstreaks\airstrike::branalytics_selfrevive(var_0);
}

function ref_12d9d(var_0, var_1) {
  var_2 = sin(var_1);
  var_3 = cos(var_1);
  var_4 = var_0[0] * var_3 - var_0[1] * var_2;
  var_5 = var_0[0] * var_2 + var_0[1] * var_3;
  return (var_4, var_5, var_0[2]);
}

function fadeoutoverlay(var_0) {
  var_1 = int(level.ref_13737[var_0.team][var_0.squadindex].ref_13bee);

  foreach(var_3 in level.squaddata[var_0.team][var_0.squadindex].players) {
    if(!isDefined(var_3)) {
      continue;
    }

    var_3 _calloutmarkerping_handleluinotify_added::ref_1313e("ui_br_x2_client_data", 0, 18, var_1);
  }
}

function handlerocketkillsgiverockets(var_0) {
  level endon("game_ended");
  self endon("death");

  if(!isDefined(var_0)) {
    var_0 = 5;
  }

  wait var_0;

  if(isDefined(self)) {
    self delete();
    return;
  }
}

function extractionlocation() {
  if(isDefined(level.ref_145f1) && isDefined(level.ref_145f1.ref_13c8d)) {
    playFX(level._effect["vfx_br_x2_flare_attack_r"], self.origin);
    return;
  }
}

function escort_intro_pre_anim_wait() {
  level endon("game_ended");

  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }

    var_1 setsoundsubmix("br_x2_default_mix");
  }
}

function execution_debug() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("wztrain_anim_playing");
  wait 1;

  if(!isDefined(level.ref_145f1) || !isDefined(level.ref_145f1.ref_13c8d)) {
    return;
  }

  var_0 = level.ref_145f1.ref_13c8d[0];

  for(var_1 = 0; var_1 < level.ref_145f1.ref_13c8d.size; var_1++) {
    if(soundexists("veh_cargotrain_lp_" + var_1)) {
      level.ref_145f1.ref_13c8d[var_1].wz_tease playLoopSound("veh_cargotrain_lp_" + var_1);
    }
  }

  var_0 playLoopSound("veh_cargotrain_locomotive_dist_lp");

  foreach(var_3 in level.players) {
    if(!isDefined(var_3)) {
      continue;
    }

    var_3 setsoundsubmix("br_x2_train_moving");
  }

  level waittill("buffTurrets");
  setglobalsoundcontext("x2_event", "turrets_buffed", 0.1);
  level waittill("x2SuperInterupt");
  var_0 stoploopsound();

  for(var_1 = 0; var_1 < level.ref_145f1.ref_13c8d.size; var_1++) {
    level.ref_145f1.ref_13c8d[var_1].wz_tease stoploopsound();
  }
}

function eyeoffnotehandler() {
  level endon("game_ended");

  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }

    var_1 clearsoundsubmix("br_x2_train_idle");
    var_1 clearsoundsubmix("br_x2_train_moving");
    var_1 clearsoundsubmix("br_x2_train_destroyed");
  }

  wait 6;

  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }

    var_1 clearsoundsubmix("br_x2_outro_ending");
  }
}

function f11lights(var_0) {
  level endon("game_ended");

  if(!isDefined(level.ref_145f1) || !isDefined(level.ref_145f1.ref_13c8d)) {
    return;
  }

  var_1 = level.ref_145f1.ref_13c8d[0].wz_tease;
  var_1 setscriptablepartstate("movement", "accel");
  thread f14_current_inputseq("br_x2_train_moving", 3, "br_x2_train_idle", 4, 0);
}

function f11onarmoryswitchon(var_0, var_1) {
  level endon("game_ended");

  if(!isDefined(level.ref_145f1) || !isDefined(level.ref_145f1.ref_13c8d)) {
    return;
  }

  var_2 = level.ref_145f1.ref_13c8d[0].wz_tease;

  if(istrue(var_1)) {
    var_2 setscriptablepartstate("movement", "brake");
  } else {
    var_2 setscriptablepartstate("movement", "brake_short");
  }

  thread f14_current_inputseq("br_x2_train_idle", var_0, "br_x2_train_moving", 3, var_0);
}

function f14_current_inputseq(var_0, var_1, var_2, var_3, var_4) {
  level endon("game_ended");

  foreach(var_6 in level.players) {
    if(!isDefined(var_6)) {
      continue;
    }

    var_6 setsoundsubmix(var_0, var_1);
  }

  wait var_4;

  foreach(var_6 in level.players) {
    if(!isDefined(var_6)) {
      continue;
    }

    var_6 clearsoundsubmix(var_2, var_3);
  }
}

function f14_current_inputamt(var_0) {
  level endon("game_ended");

  if(!isDefined(level.ref_145f1) || !isDefined(level.ref_145f1.ref_13c8d)) {
    return;
  }

  wait var_0;
  var_1 = level.ref_145f1.ref_13c8d[0].wz_tease;
  var_1 playsoundonmovingent("veh_horn_cargotrain_wake");
}

function f11scriptlighttoggle(var_0) {
  level endon("game_ended");

  if(!isDefined(level.ref_145f1) || !isDefined(level.ref_145f1.ref_13c8d)) {
    return;
  }

  wait var_0;
  var_1 = level.ref_145f1.ref_13c8d[0].wz_tease;
  var_1 playsoundonmovingent("veh_horn_cargotrain_buffed_weapon");
}

function exit_level(var_0, var_1) {
  if(!isDefined(var_1)) {
    return;
  }

  if(var_0 <= 1) {
    var_1 playlocalsound("scn_x2_ac130_bomb_incoming_01", undefined, undefined, 1);
    return;
  }

  if(var_0 == 2) {
    var_1 playlocalsound("scn_x2_ac130_bomb_incoming_02", undefined, undefined, 1);
    return;
  }

  if(var_0 == 3) {
    wait 0.2;
    var_1 clearclienttriggeraudiozone(0);
    var_1 playlocalsound("scn_x2_outro_part1_lr", undefined, undefined, 1);
    var_1 clearallsoundsubmixes(0.1);
    var_1 setsoundsubmix("br_x2_outro_ending");
    wait 5.6;
    var_1 playlocalsound("scn_x2_outro_part2_lr", undefined, undefined, 1);
    return;
  }
}

function eyeonnotehandler(var_0) {
  level endon("game_ended");

  for(var_1 = 0; var_1 < level.ref_145f1.ref_13c8d.size; var_1++) {
    if(var_1 > 0) {
      playFXOnTag(level._effect["vfx_br_x2_brake_sparks_car"], level.ref_145f1.ref_13c8d[var_1].wz_tease, "tag_origin");
      continue;
    }

    playFXOnTag(level._effect["vfx_br_x2_brake_sparks_loco"], level.ref_145f1.ref_13c8d[var_1].wz_tease, "tag_origin");
  }

  wait var_0;

  for(var_1 = 0; var_1 < level.ref_145f1.ref_13c8d.size; var_1++) {
    if(var_1 > 0) {
      stopFXOnTag(level._effect["vfx_br_x2_brake_sparks_car"], level.ref_145f1.ref_13c8d[var_1].wz_tease, "tag_origin");
      continue;
    }

    stopFXOnTag(level._effect["vfx_br_x2_brake_sparks_loco"], level.ref_145f1.ref_13c8d[var_1].wz_tease, "tag_origin");
  }
}

function extractmissionhelipadscriptable(var_0, var_1) {
  if(scripts\engine\utility::flag_exist("no_crate_spawning") && scripts\engine\utility::flag("no_crate_spawning")) {
    return;
  }

  if(!isDefined(var_0) || !isarray(var_0)) {
    return;
  }

  extractcountdownmsg();

  foreach(var_3 in var_0) {
    var_4 = spawnStruct();
    var_4.origin = scripts\engine\utility::drop_to_ground(var_3, 150, -1000);
    var_4.clear_legacy_pickup_munitions = spawn("script_model", var_4.origin);
    var_4.clear_legacy_pickup_munitions setModel("ks_airdrop_crate_br");
    level.fnhidefoundintel = 8000;

    if(isDefined(var_1)) {
      level.fnhidefoundintel = var_1;
    }

    var_5 = scripts\mp\gametypes\br_c130airdrop::fn_spec_op_post_customization(undefined, var_3, 1);
    var_6 = distance(var_5.startpt, var_5.endpt);
    var_7 = scripts\mp\gametypes\br_c130::getc130speed() * 1.2;
    var_8 = var_6 / var_7;
    var_9 = scripts\mp\gametypes\br_c130airdrop::fntrapdeactivation(var_5, var_6, var_7, var_8);
    var_9.mode_can_play_ending = &mode_can_play_ending;
    var_9 scripts\mp\gametypes\br_c130airdrop::fob(1, "heavy_weapon_crate", "inactive", var_4);
  }
}

function mode_can_play_ending(var_0, var_1, var_2, var_3) {
  level endon("no_crate_spawning");
  var_4 = self.startpt;
  var_5 = self.centerpt;
  var_6 = self.speed;
  var_7 = distance2d(var_4, var_5) / var_6;
  var_8 = 0;
  var_9 = 0;
  wait var_7;
  level notify("drop_resuply");
  var_10 = var_3.origin;
  var_11 = scripts\cp_mp\killstreaks\airdrop::minshotstostage3acc(var_10 + (0, 0, level.fnhidefoundintel - 100), var_10, self.angles, var_1, var_2, var_3.ref_11eab);
  var_11 setscriptablepartstate("objective", "heavy_weapon_public");
  var_11.ml_p2_func = var_3;
  var_11.ref_134e2 = self.ref_134e2;
  level.ref_1463d[level.ref_1463d.size] = var_11;
}

function extractcountdownmsg() {
  enemyhasuavkill();

  foreach(var_1 in level.ref_1463d) {
    level.ref_1463b[level.ref_1463b.size] = var_1;
  }

  level.ref_1463d = [];
}

function enemyhasuavkill(var_0) {
  if(!isDefined(level.ref_1463b) || level.ref_1463b.size <= 0) {
    level.ref_1463b = [];
    return;
  }

  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  var_1 = [];

  foreach(var_3 in level.ref_1463b) {
    if(!isDefined(var_3) || !isDefined(var_3.origin)) {
      continue;
    }

    var_4 = scripts\common\utility::playersinsphere(var_3.origin, 5000);

    if(var_0 || var_4.size <= 0) {
      var_3 thread scripts\cp_mp\killstreaks\airdrop::destroycrate(1);
      continue;
    }

    var_1 = var_3;
  }

  level.ref_1463b = var_1;
}

function enemygunship_watchdebuglocation() {
  foreach(var_1 in level.ref_1463d) {
    level.ref_1463b[level.ref_1463b.size] = var_1;
  }

  level.ref_1463d = [];
  enemyhasuavkill(1);
}

function ref_11d03() {
  level endon("game_ended");

  for(;;) {
    foreach(var_1 in level.players) {
      var_1.heli_orbit_logic = scripts\mp\utility\player::getplayersinradius(var_1.origin, 500, var_1.team, var_1);
    }

    wait 1;
  }
}

function ref_12171(var_0) {
  if(!scripts\engine\utility::flag("wztrain_anim_playing")) {
    return false;
  }

  if(scripts\mp\flags::gameflag("x2_train_destroyed")) {
    return false;
  }

  if(!isalive(var_0)) {
    return false;
  }

  if(var_0 scripts\cp_mp\utility\player_utility::isinvehicle()) {
    return false;
  }

  if(var_0 isskydiving() || var_0 isparachuting()) {
    return false;
  }

  if(isDefined(var_0.ref_1286f) && distance(var_0.origin, var_0.ref_1286f.origin) < 200) {
    return false;
  }

  var_1 = getdvarint("scr_x2_overdrive_distance", 1500);
  var_2 = 0;

  foreach(var_4 in level.ref_145f1.ref_13c8d) {
    if(var_4.wz_tease.get_remaining_bots <= 0) {
      continue;
    }

    var_5 = distance2d(var_4.origin, var_0.origin);

    if(var_5 < var_1) {
      var_2 = 1;
      break;
    }
  }

  if(var_2) {
    if(!isDefined(var_0.watch_for_players_approaching_tugofwar)) {
      return false;
    } else if(gettime() - var_0.watch_for_players_approaching_tugofwar > 3000) {
      return false;
    }
  } else {
    var_0.watch_for_players_approaching_tugofwar = gettime();
  }

  return true;
}

function ref_1260c() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("x2_ambush1_completed");

  for(;;) {
    foreach(var_1 in level.players) {
      if(ref_12171(var_1)) {
        if(!isDefined(var_1.ref_1216f) || !istrue(var_1.ref_1216f)) {
          var_1.ref_1216f = 1;
          var_1 allowsupersprint(1);
          ref_12543(var_1);
          var_1 setclientomnvar("ui_privateevent_timer_type", 4);
        }

        var_1 setclientomnvar("ui_privateevent_timer", var_1.watch_for_players_approaching_tugofwar + 3000);
        var_1 refreshsprinttime();
        continue;
      }

      if(istrue(var_1.ref_1216f)) {
        var_1.ref_1216f = 0;
        var_1 setclientomnvar("ui_privateevent_timer_type", 0);
        ref_1253d(var_1);
      }
    }

    wait 0.1;
  }
}

function ref_12543() {
  self.movespeedscaler = 1.2;
  scripts\mp\weapons::updatemovespeedscale();
  self lerpfovbypreset("zombiedefault");

  if(!scripts\mp\gametypes\br_public::shouldlink()) {
    scripts\mp\utility\perk::giveperk("specialty_sprintmelee");
    scripts\mp\utility\perk::giveperk("specialty_sprintads");
    scripts\mp\utility\perk::giveperk("specialty_marathon");
  }

  thread ref_11d14();
  ref_12542();
}

function get_associated_keycard() {
  var_0 = level.ref_145f1.ref_13c8d[0].wz_tease.lb_wood_surf_dmg_scalar;

  if(isDefined(var_0) && var_0 > 2) {
    return false;
  }

  return true;
}

function ref_11d14() {
  level endon("game_ended");
  self notify("stopOverdriveAudio");
  self endon("stopOverdriveAudio");

  for(;;) {
    wait 30;

    if(get_associated_keycard() == 1) {
      expiredlootleaderenabled("overdrive_nag", 0, 1);
    }
  }
}

function ref_1253d() {
  self notify("stopOverdriveAudio");

  if(!scripts\mp\gametypes\br_public::shouldlink()) {
    scripts\mp\utility\perk::removeperk("specialty_sprintmelee");
    scripts\mp\utility\perk::removeperk("specialty_sprintads");
    scripts\mp\utility\perk::removeperk("specialty_marathon");
  }

  self.movespeedscaler = 1;
  scripts\mp\weapons::updatemovespeedscale();
  self lerpfovbypreset("default_2seconds");
  ref_1253c();
}

function ref_12542() {
  self.ref_12147 = self.operatorcustomization.suit;
  self.operatorcustomization.suit = "actionhero_mp";
  scripts\mp\utility\player::_setsuit("actionhero_mp");
}

function ref_1253c() {
  self.operatorcustomization.suit = self.ref_12147;
  scripts\mp\utility\player::_setsuit(self.ref_12147);
  self.ref_12147 = undefined;
}

function exfilchopper(var_0) {
  var_0 waittill("spawned_player");
  var_0 visionsetnakedforplayer(level.ref_142d1, 0);

  if(!isDefined(var_0.ref_1463c)) {
    var_0.ref_1463c = scripts\mp\utility\outline::outlineenableforall(var_0, "outline_depth_x2", "lowest");
  }

  var_0.heli_landing_volumes = [];
}

function ref_13251() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  thread ref_12c06();

  foreach(var_1 in level.players) {
    thread move_to_track_end();
  }
}

function move_to_track_end() {
  level endon("game_ended");
  self waittill("br_jump");

  if(!isDefined(self.ref_1463c)) {
    self.ref_1463c = scripts\mp\utility\outline::outlineenableforall(self, "outline_depth_x2", "lowest");
    return;
  }
}

function ref_12c06() {
  level endon("game_ended");

  foreach(var_1 in level.players) {
    if(isDefined(var_1.ref_1463c)) {
      scripts\mp\utility\outline::outlinedisable(var_1.ref_1463c, var_1);
      var_1.ref_1463c = undefined;
    }
  }
}

function extra_bomb_explode_vfx_func(var_0, var_1, var_2) {
  level endon("game_ended");
  var_1 endon("disconnect");
  wait var_2;
  var_1 playsoundtoplayer(var_0, var_1);
}

function exit_laser_panel_anim_sequence() {
  scripts\mp\gametypes\br_movingtrain::ref_13cb4(0);
}

function existingkills() {
  scripts\mp\gametypes\br_movingtrain::ref_13cb4(1);
}

function extractlocale_checkiflocaleisavailable(var_0) {
  var_1 = 0;

  if(isDefined(level.ref_14640)) {
    foreach(var_3 in level.ref_14640) {
      if(!isDefined(var_3)) {
        continue;
      }

      if(var_3.health > 0 && isDefined(var_3.currenttarget) && var_3.currenttarget == var_0) {
        var_1 |= var_0 scripts\mp\perks\perkfunctions::roof_rpg_covers(var_3);
      }
    }
  }

  return var_1;
}

function exfill_chopper_dialogue(var_0) {
  if(isPlayer(var_0)) {
    return 0;
  }

  if(!isDefined(level.ref_145f1) || !isDefined(level.ref_145f1.ref_13c8d)) {
    return 0;
  }

  foreach(var_2 in level.ref_145f1.ref_13c8d) {
    if(var_2 == var_0) {
      return level.ss_entergulag;
    }

    if(isDefined(var_2.wz_tease.frontturret) && var_2.wz_tease.frontturret == var_0) {
      return level.ss_ontimerexpired;
    }

    if(isDefined(var_2.wz_tease.rearturret) && var_2.wz_tease.rearturret == var_0) {
      return level.ss_ontimerexpired;
    }
  }

  return 0;
}

function exfil_sequence(var_0) {
  if(getdvarint("scr_x2_logs_enable", 1)) {
    logstring("[X2] " + var_0);
    return;
  }
}