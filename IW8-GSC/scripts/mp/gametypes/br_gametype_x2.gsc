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
  setDvar("LKTPRPKPMR", 1);
  setDvar("NNMLSMNTOQ", -1);
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

function extra_delay(var0, var1) {
  if(isDefined(level.juggheli_spawner_jammer5_4)) {
    var2 = level.juggheli_spawner_jammer5_4[var1];

    if(isDefined(var2)) {
      var0 setvehiclecamo();
      var0 getmountconfigenabled(var2);
      var0.gasfxair = 1;
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
  var0 = getdvarfloat("scr_x2_infil_kick_timer", 21);
  wait var0;

  foreach(var2 in level.players) {
    if(isDefined(var2) && isDefined(var2.br_infil_type) && var2.br_infil_type == "c130" && !isDefined(var2.jumptype)) {
      var2.jumptype = "outOfBounds";
      var2 notify("halo_kick_c130");
    }
  }
}

function exfil() {
  level endon("game_ended");
  thread extractlocale_circletick(level.brneverlanded[1].position, level.brneverlanded[1].broadcast_currency);
  scripts\mp\flags::gameflagwait("br_ready_to_jump");
  thread extractsilentcountdown("ambush0");
  var1 = getdvarint("scr_br_x2_intro_delay", 60);

  while(var1 >= 0) {
    setomnvar("ui_hardpoint_timer", gettime() + int(var1 * 1000));

    if(var1 <= 15 && var1 >= 1) {
      scripts\mp\utility\sound::playsoundonplayers("match_start_tick_in3", "allies");
    }

    var1--;
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

function timeoutonabandoneddelay(var0) {
  level.depletionrate = [];
  var1 = tablelookupgetnumcols(var0) - 1;

  for(var2 = 0; var2 < var1; var2++) {
    level.depletionrate[var2] = init_structs_mp_don3(var2, var0);
  }
}

function init_structs_mp_don3(var0, var1) {
  GscBinSkip1(0x45, "loadoutArchetype", "archetype_assault");
}

function enterpos() {
  GscBinSkip1(0x45, "loadoutArchetype", "archetype_assault");
}

function exploder_ref() {
  if(!isDefined(level.depletionrate)) {
    timeoutonabandoneddelay("mp/classtable_x2.csv");
  }

  var0 = level.depletionrate[randomint(level.depletionrate.size)];
  equip_random_grenade(var0, 1);
  scripts\mp\gametypes\br_pickups::forcegivesuper(var0["loadoutSuper"], 0);
  scripts\mp\gametypes\br_armor::searchcirclesize(1);
  scripts\mp\gametypes\br_weapons::debug_spawncover_badnodetest();
  return false;
}

function equip_random_grenade(var0, var1, var2) {
  self.pers["gamemodeLoadout"] = var0;
  self.class = "gamemode";
  self.prevweaponobj = undefined;
  var3 = scripts\mp\class::loadout_getclassstruct();
  var3 = scripts\mp\class::loadout_updateclass(var3, "gamemode");
  scripts\mp\class::preloadandqueueclassstruct(var3, 1, 1);
  self takeallweapons();
  scripts\mp\class::giveloadout(self.team, "gamemode", var1, var1);
  self givestartammo(var3.loadoutprimaryobject);
  self givestartammo(var3.loadoutsecondaryobject);
  scripts\mp\gametypes\br::scriptednode(self);
  scripts\mp\gametypes\br_weapons::br_ammo_player_clear();

  if(!istrue(var2)) {
    scripts\mp\gametypes\br_weapons::delay_add_to_chopper_boss_drone_target_array();
  }

  scripts\mp\gametypes\br_weapons::br_ammo_update_weapons(self);
  self notify("ammo_update");
}

function exploboltexplode() {
  var0 = [];
  var1 = self getweaponslistprimaries();

  foreach(var3 in var1) {
    var4 = scripts\mp\gametypes\br_weapons::br_ammo_type_for_weapon(var3);

    if(isDefined(var4)) {
      var5 = weaponclipsize(var3);
      self.br_ammo[var4] = var5;
      scripts\mp\gametypes\br_weapons::br_ammo_player_hud_update_ammotype(var4);
    }
  }

  scripts\mp\gametypes\br_weapons::br_ammo_update_weapons(self);
}

function ref_125f7(var0, var1) {
  level endon("game_ended");
  self endon("disconnect");
  thread ref_126a4(1);
  return true;
}

function ref_11b80(var0) {
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
  var0 = getdvarfloat("scr_br_respawnMaxTrainOffset", 6000);
  var1 = randomfloatrange(0, 360);
  return (cos(var1), sin(var1), 0) * randomfloatrange(0, var0);
}

function ref_12006() {
  var0 = getdvarfloat("scr_br_respawnTrainHeight", 5000);
  var1 = randomfloatrange(0, 360);
  var2 = spawnStruct();
  var2.origin = (-12221, -12808, 500) + risktokenonuse() + (0, 0, var0);
  var2.angles = vectortoangles((cos(var1), sin(var1), 0));
  var2.index = -1;
  return var2;
}

function ref_126a4(var0) {
  level endon("game_ended");
  self endon("disconnect");

  if(var0) {
    var1 = getdvarfloat("scr_br_respawnTrainHeight", 2500);
    var2 = undefined;
    var3 = undefined;

    if(scripts\mp\flags::gameflag("x2_train_destroyed")) {
      var4 = scripts\mp\gametypes\br_gulag::ref_12568(0);

      if(!isDefined(var4)) {
        var4 = self;
      }

      var2 = scripts\mp\gametypes\br_gulag::rocket_fuel_stability(var4.origin, 1000);
      var2 = scripts\mp\gametypes\br_public::modifyplayer_damage(var2);
      var3 = scripts\mp\gametypes\br_gulag::registercarryobjectpickupcheck(var2, var4.origin);
    } else {
      var5 = (0, 0, var1);
      var6 = undefined;

      if(level.mapname == "mp_br_mechanics") {
        var6 = (0, 0, 0) + var5;
      } else if(level.mapname == "mp_don4" && !scripts\mp\flags::gameflag("prematch_done")) {
        var6 = (-12221, -12808, 500) + (0, 0, 2 * var1) + risktokenonuse();
      } else if(isDefined(level.ref_145f1) && isDefined(level.ref_145f1.ref_13c8d) && isDefined(level.ref_145f1.ref_13c8d[0])) {
        var6 = level.ref_145f1.ref_13c8d[0].wz_tease.origin + var5;
      } else {
        var6 = (4853.5, -1000.75, -108.75) + (0, 0, var1) + risktokenonuse();
      }

      var7 = getdvarfloat("scr_br_respawnMaxTrainOffset", 6000);
      var2 = scripts\mp\gametypes\br_gulag::rocket_fuel_stability(var6, var7, undefined);
      var3 = scripts\mp\gametypes\br_gulag::registercarryobjectpickupcheck(var2, var6);
    }

    if(isDefined(var2) && isDefined(var3)) {
      var8 = spawn("script_model", var2);
      var8.playerspawnpos = var2;
      var8.playerspawnangles = var3;
      var8.notti = 1;
      self.setspawnpoint = var8;
    }

    self.ref_1286f = scripts\mp\gametypes\br_gulag::ref_125be(0, undefined, var1);
    self.ref_1286f.index = -1;
  } else {
    self.ref_1286f = scripts\mp\gametypes\br::getspawnpoint(1);
    var1 = scripts\cp_mp\parachute::getc130height();
    var9 = scripts\engine\utility::drop_to_ground(self.ref_1286f.origin, 1500, -20000);
    var5 = (0, 0, var1);
    self.ref_1286f.origin = scripts\mp\gametypes\br::getoffsetspawnorigin(var9, var5);
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
  var10 = !self calloutmarkerping_getEnt();
  var11 = gettime();

  if(var10) {
    while(isalive(self) && isDefined(self.weaponlist) && !self hasloadedviewweapons(self.weaponlist)) {
      if(var11 + 3000 < gettime()) {
        break;
      }

      waitframe();
    }
  }

  self notify("brWaitAndSpawnClientComplete");
  self.waitingtospawn = 0;
  self freezecontrols(0);

  if(var1) {
    scripts\mp\gametypes\br::ref_13f21(self);
    return;
  }
}

function extra_riders_getin_anim_func(var0, var1, var2, var3) {
  var4 = scripts\mp\gametypes\br_quest_util::createquestinstance(var0, var1 + "-" + self.squadindex, var2, var3, self.squadindex);
  var4 scripts\mp\gametypes\br_quest_util::ref_12b15(self);
  var4.team = self.team;
  var4.startlocation = self.origin;
  var4.intelprogress = self.origin;
  var4.playerlist = level.squaddata[self.team][self.squadindex].players;
  return var4;
}

function extra_riders_func(var0) {
  if(var0.team == self.team && var0.squadindex == self.squadindex) {
    return 1;
  }

  return 0;
}

function enemy_signal_flare(var0, var1) {
  var2 = self;

  if(isDefined(level.questinfo.quests[var0].instances[var2.team + "-" + var2.squadindex])) {
    return;
  }

  var3 = [[var1]](var2.team, "", var2, "");

  if(isDefined(var3)) {
    thread exfilallyturning();
  }

  return var3;
}

function exfilallyturning() {
  level endon("game_ended");
  var0 = self;
  var0 waittill("removed");
  var0 notify("update");
}

function entmantling(var0, var1) {
  return level.questinfo.quests[var0].instances[var1.team + "-" + var1.squadindex];
}

function enter_laser_panel_anim_sequence(var0) {
  var1 = [];

  foreach(var3 in var0) {
    if(isDefined(var3) && isalive(var3)) {
      var1 = var3;
    }
  }

  return var1;
}

function extract_ontimerexpired(var0) {
  foreach(var2 in var0.playerlist) {
    var2.ref_1296e = undefined;
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
  var0 = enter_numbers_end();

  foreach(var2 in var0) {
    foreach(var4 in var2) {
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

function enemygunship_handlemissiledetection(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  var9 = spawnStruct();
  var9.broadcast_currency = var0;
  var9.managecontrolledcallbacktimeout = var1;
  var9.ref_13343 = var2;
  var9.position = var3;
  var9.should_do_damage_check_func_relics = var4;
  var9.turret_guncourse_explode_on_end = var5;
  var9.loc_exposed_to_chopper_boss = var6;
  var9.ref_13ccb = var7;
  var9.infilvideowaituntilcomplete = var8;
  level.brneverlanded[var0] = var9;
}

function enemygunship_spawngunship(var0, var1, var2) {
  var3 = spawnStruct();
  var3.tv_station_interior_enemy_should_break_stealth_immediately = 1;
  var3.getquestplunderreward = var0;
  var3.position = var1;
  var3.vehicle_occupancy_isneutraltoteam = [];
  var3.infilvideowaituntilcomplete = var2;
  level.getpubliceventchance[var0] = var3;
}

function enter_numbers_init(var0) {
  return level.brneverlanded[var0];
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
  var0 = level.ref_145f1.ref_13c8d[0];
  var0 scripts\mp\gametypes\br_movingtrain::ref_13c8b(3, 2);

  if(!isDefined(level.ref_145f1) || !isDefined(level.ref_145f1.animents) && !isDefined(level.ref_145f1.animents[0])) {
    return;
  }

  thread exit_laststand_usability();
  thread fadetoblackforxsec(level, var0);
  enemy_right_monitor(level.brneverlanded[1]);

  foreach(var2 in level.getpubliceventchance) {
    enemygunship_firerounds(var2);
  }

  enemy_right_monitor(level.brneverlanded[2]);
}

function exit_laststand_usability() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("x2_ambush1_completed");
  scripts\mp\gametypes\br_movingtrain_armored::extraction_balloon_total_plunder();
}

function enemygunship_firerounds(var0) {
  var1 = level.ref_145f1.ref_13c8d[0];
  var2 = var0.position;
  var3 = var0.getquestplunderreward;
  thread extractsilentcountdown("ambush" + var3 + 1);
  var4 = 1500;
  ref_143fd(var1, var2, var4);
  thread extendcirclelist();
  extractmissionhelipadscriptable(var0.infilvideowaituntilcomplete);
  var4 = 50;
  ref_143fd(var1, var2, var4);
  scripts\mp\flags::gameflagset("x2_checkpoint" + var3 + "_completed");

  if(var0.vehicle_occupancy_isneutraltoteam.size > 0) {
    if(var3 > 1) {
      exfil_heli_landing(var3 - 1);
    }

    extractplunderheliinvulnerable(var3);
  }

  var5 = var0.getquestplunderreward;

  if(var5 >= 1) {
    enemymarker(var5);
    return;
  }
}

function enemy_right_monitor(var0) {
  var1 = level.ref_145f1.ref_13c8d[0];

  if(var0.managecontrolledcallbacktimeout) {
    wait 2;
  }

  if(var0.broadcast_currency != 1 && istrue(level.ref_13396)) {
    thread extractlocale_circletick(var0.position, var0.broadcast_currency);
  }

  if(var0.broadcast_currency >= level.brneverlanded.size) {
    var2 = var0.broadcast_currency + level.getpubliceventchance.size;
  } else {
    var2 = var1.broadcast_currency;
    thread extractsilentcountdown("ambush" + var2);
  }

  var3 = getdvarvector("scr_br_x2_amb_destination", var1.position);
  level.initextractionlocations = var1.broadcast_currency;
  var4 = getdvarint("scr_br_x2_amb_warn_distance1", 24000);
  var5 = getdvarint("scr_br_x2_amb_warn_distance2", 12500);
  var6 = getdvarint("scr_br_x2_amb_warn_distance3", 3000);
  var7 = getdvarint("scr_br_x2_amb_warn_distance4", 50);
  var8 = 200;
  ref_143fd(var2, var3, var4);
  extractmissionhelipadscriptable(var1.infilvideowaituntilcomplete);
  ref_143fd(var2, var3, var5);

  if(var1.broadcast_currency == 1 || var1.should_do_damage_check_func_relics && istrue(level.ref_13396)) {
    showsplash("br_x2_distance02");
  }

  level notify("train_incoming");
  ref_143fd(var2, var3, var6);

  if(var1.broadcast_currency == 1 || var1.should_do_damage_check_func_relics && istrue(level.ref_13396)) {
    showsplash("br_x2_distance03");
  }

  scripts\mp\flags::gameflagset("x2_ambush" + var1.broadcast_currency + "_starting");
  ref_143fd(var2, var3, var7);

  if(var1.turret_guncourse_explode_on_end && level.ref_145f1.instance > 0) {
    if(var1.loc_exposed_to_chopper_boss) {
      showsplash("br_x2_distance04");
    } else {
      showsplash("br_x2_train_immobilized");
    }
  }

  ref_143fd(var2, var3, var8);

  if(!var1.ref_13ccb) {
    level.ref_145f1.ref_12a38 = 1;
  }

  var9 = scripts\engine\utility::ter_op(var1.turret_guncourse_explode_on_end, 8, 3);
  thread extratimeincreasecount(var9, 0, var1.turret_guncourse_explode_on_end);

  if(var1.turret_guncourse_explode_on_end) {
    if(level.ref_145f1.instance == 0) {
      level.ref_145f1.instance++;
    }

    faceenemyspawn(var1.broadcast_currency);
    var2 scripts\mp\gametypes\br_movingtrain_armored::enemy_rushdown_player();
    scripts\mp\gametypes\br_x2_bomb_quest::has_headicon();
    scripts\mp\flags::gameflagset("x2_ambush" + var1.broadcast_currency + "_completed");
    wait 6;
  } else {
    wait 2;
    scripts\mp\flags::gameflagset("x2_ambush" + var1.broadcast_currency + "_completed");
    wait 6;
  }

  if(!istrue(level.ref_145f1.ref_12a38)) {
    var2 scripts\mp\gametypes\br_movingtrain::ref_13c8b(0.7, 0.05);
    thread f11lights();
  } else if(!level.ref_145f1.usedcountinveh) {
    level thread scripts\mp\gametypes\br_movingtrain_armored::ref_13ccd();
  }

  var10 = var2 - 1;

  if(var10 >= 1) {
    enemymarker(var10);
    return;
  }
}

function extractlocale_circletick(var0, var1) {
  level endon("game_ended");
  var2 = spawn("script_model", var0);
  var2 setModel("vfx_br_x2");
  var2 setscriptablepartstate("vfx", "vfx_br_x2_beacon_01");
  scripts\engine\utility::ref_143ad("x2_ambush" + var1 + "_completed", "x2_train_destroyed");
  var2 delete();
}

function fadetoblackforxsec(var0, var1) {
  level endon("game_ended");
  var2 = 2300;

  if(!istrue(level.ref_13396)) {
    var3 = 6000;
    ref_143fd(var0, var1.position, var3);
    scripts\mp\flags::gameflagset("x2_airstrike_begin");
  }

  ref_143fd(var0, var1.position, var2);
  thread f14_keypadnumstr(var1.broadcast_currency, var1.position);
}

function fadeoutinspectatorsofplayer(var0) {
  level endon("game_ended");
  var1 = level.ref_145f1.ref_13c8d[0];
  thread f14_current_inputamt(1);
  wait 5;

  if(var0) {
    if(!istrue(level.ref_145f1.ref_12a38) && !scripts\mp\flags::gameflag("x2_train_destroyed") && !scripts\mp\flags::gameflag("x2_locomotive_vulnerable")) {
      var1 scripts\mp\gametypes\br_movingtrain::ref_13c8b(0.7, 0.05);
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

function extratimeincreasecount(var0, var1, var2) {
  level endon("game_ended");
  level notify("x2_train_stopped");
  level endon("x2_train_stopped");
  var3 = level.ref_145f1.ref_13c8d[0];
  var3 scripts\mp\gametypes\br_movingtrain::ref_13c94(var0);

  if(!var1) {
    if(level.ref_145f1.animents[0].burst_fire_turret > 0) {
      thread f11onarmoryswitchon(var0, var2);
      thread eyeonnotehandler(var0);
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

function ref_143fd(var0, var1, var2) {
  var3 = var2 * var2;

  while(length2dsquared(var0.origin - var1) > var3) {
    waitframe();
  }
}

function showsplash(var0) {
  foreach(var2 in level.players) {
    var2 scripts\mp\hud_message::showsplash(var0);
  }
}

function ref_13744(var0) {
  foreach(var2 in self.players) {
    var2 scripts\mp\hud_message::showsplash(var0);
  }
}

function f14_keypadnumstr(var0, var1) {
  level endon("game_ended");
  var2 = 82;
  var3 = var1;
  thread enemy_validate_node_proximity(level, var3);
}

function faceenemyspawn(var0) {
  var1 = (-90, 0, 0);
  var2 = (0, 0, 0);

  switch (var0) {
    case 1:
      var2 = (4595, -1000, -160);
      var1 = (0, 86, 0);
      break;
    case 2:
      var2 = (-31298, 3614, -284);
      var1 = (0, 82, 0);
      break;
    default:
      break;
  }

  var3 = spawn("script_model", var2);
  var3 setModel("x2_vfx_ambushes_spawn");
  var3.angles = var1;
  var3 setscriptablepartstate("base", "ambush_" + var0);
  thread handlerocketkillsgiverockets(var3);
}

function extracting(var0, var1) {
  level.ref_142d1 = var0;

  if(!isDefined(var1)) {
    var1 = 0;
  }

  foreach(var3 in level.players) {
    var3 visionsetnakedforplayer(var0, var1);
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
    var0 = -4;
    scripts\mp\gametypes\br_x2_bomb_quest::ref_1362d(level.brneverlanded[2].position, var0);
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

function exfil_speed(var0) {
  if(level.ref_14632 == var0) {
    return;
  }

  level.ref_14632 = var0;
  level.disable_super_in_turret.ref_14653 = 0;
  level.ref_14639 = 0;
  level.ref_14651 = 0;
}

function extracthelipadusecallback(var0) {
  var1 = ref_14381();

  if(!isDefined(var1)) {
    return;
  }

  var2 = var1[[var0]]();
  var2 waittill("removed");
}

function ref_14381() {
  while(self.players.size != 0) {
    foreach(var1 in self.players) {
      if(isalive(var1) && !istrue(var1.inlaststand) && !var1 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal()) {
        return var1;
      }
    }

    wait 1;
  }

  return undefined;
}

function execution_obstacle() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");

  foreach(var1 in level.vehicle.spawn.databyref) {
    var1.canspawncallback = &enemygunship_attackgoal;
  }
}

function enemygunship_attackgoal(var0, var1, var2, var3) {
  var4 = (-25571, -10031, 84);
  var5 = 45981;

  if(distance2d(var2.origin, var4) > var5) {
    return false;
  }

  var4 = (-11360, -20916, 154);
  var5 = 13000;

  if(distance2d(var2.origin, var4) < var5) {
    return false;
  }

  var4 = (-12737, -9293, 412);
  var5 = 18000;

  if(distance2d(var2.origin, var4) < var5) {
    return false;
  }

  var4 = (-17354, 15846, -260);
  var5 = 8000;

  if(distance2d(var2.origin, var4) < var5) {
    return false;
  }

  var4 = (-32195, -13969, 1605);
  var5 = 16000;

  if(distance2d(var2.origin, var4) < var5) {
    return false;
  }

  var4 = (-18401, -34786, 1339);
  var5 = 20000;

  if(distance2d(var2.origin, var4) < var5) {
    return false;
  }

  return true;
}

function executioncashmultiplier() {
  level.ref_14643 = [];
  level.ref_1463f = [];
  var0 = [];
  GscBinSkip0(0x2e, var0.size, enemygunship_updatedebugflashlight("jeep", (4212, 2380, -411), (10, 72, 0)));
}

function enemygunship_updatedebugflashlight(var0, var1, var2) {
  var3 = spawnStruct();
  var3.refname = var0;
  var3.origin = var1;
  var3.angles = var2;
  return var3;
}

function extractsilentcountdown(var0) {
  if(getdvarint("scr_br_x2_vehicle_set_enabled", 1) == 0) {
    return;
  }

  if(!isDefined(level.ref_14643)) {
    return;
  }

  var1 = level.ref_14643[var0];

  if(!isDefined(var1)) {
    return;
  }

  var2 = getdvarfloat("scr_br_x2_vehicle_set_wait", 0.5);

  if(var2 > 0) {
    if(var2 > 0) {
      wait var2;
    } else {
      waitframe();
    }
  }

  var3 = [];

  foreach(var5 in var1) {
    waitframe();
    var3 = extractshowicontoplayer(var5.refname, var5.origin, var5.angles);
  }

  level.ref_1463e[var0] = var3;
}

function extractshowicontoplayer(var0, var1, var2) {
  if(level.vehiclecount >= getdvarint("scr_br_x2_vehicle_count_max", 104)) {
    return undefined;
  }

  var3 = spawnStruct();
  var4 = spawnStruct();
  var4.origin = var1;
  var4.angles = var2;
  var5 = scripts\mp\gametypes\br_vehicles::tryspawnavehicle(var0, var4, "X2_spawns", var3);
  return var5;
}

function engagementcount(var0) {
  var0 scripts\cp_mp\vehicles\vehicle_damage::ref_14141(var0);
  var0 scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_deregisterinstance(var0);
  var0 scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_deregisterinstance(var0);
  var0 scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_deregisterinstance(var0);
  var0 scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_deregisterinstance(var0.vehiclename, var0 getentitynumber());
  var0 scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(var0);
}

function enemymarker(var0) {
  for(var1 = 0; var1 <= var0; var1++) {
    var2 = "ambush" + var1;

    if(level.ref_1463e[var2].size <= 0) {
      continue;
    }

    var3 = [];

    foreach(var5 in level.ref_1463e[var2]) {
      if(!isDefined(var5) || !isDefined(var5.origin)) {
        continue;
      }

      var6 = extracthelipadwatchforhelileaving(var5.origin, 5000);

      if(isDefined(var5.owner) || !var5.isempty || var6.size > 0) {
        var3 = var5;
        continue;
      }

      engagementcount(var5);
    }

    level.ref_1463e[var2] = var3;
  }
}

function extracthelipadwatchforhelileaving(var0, var1) {
  var2 = [];
  var3 = var1 * var1;

  foreach(var5 in level.players) {
    var6 = distancesquared(var5.origin, var0);

    if(var6 < var3) {
      var2 = var5;
    }
  }

  return var2;
}

function extrascore4(var0, var1, var2, var3) {
  return true;
}

function entity_movingplatform_update() {
  return (-64642, -39932, 1509);
}

function enemy_push_players_logic(var0, var1, var2, var3) {
  var4 = spawnStruct();
  var4.origin = var1;
  var4.angles = var2;
  var4.ref_11f2f = var3;
  var4.vehicle_occupancy_isneutraltoplayer = [];
  var5 = level.getpubliceventchance[var0].vehicle_occupancy_isneutraltoteam.size;
  level.getpubliceventchance[var0].vehicle_occupancy_isneutraltoteam[var5] = var4;
}

function exfil_heli_landing(var0) {
  if(level.getpubliceventchance[var0].vehicle_occupancy_isneutraltoteam.size > 0) {
    var1 = level.getpubliceventchance[var0].vehicle_occupancy_isneutraltoteam;

    foreach(var3 in var1) {
      if(!isDefined(var3.vehicle_occupancy_isneutraltoplayer)) {
        continue;
      }

      foreach(var5 in var3.vehicle_occupancy_isneutraltoplayer) {
        if(isDefined(var5)) {
          var5 kill();
        }
      }
    }

    return;
  }
}

function extractplunderheliinvulnerable(var0) {
  if(level.getpubliceventchance[var0].vehicle_occupancy_isneutraltoteam.size > 0) {
    var1 = level.getpubliceventchance[var0].vehicle_occupancy_isneutraltoteam;

    foreach(var3 in var1) {
      var4 = extractplunderhelihealth(var3.origin, var3.angles, var3.ref_11f2f);
      level.getpubliceventchance[var0].vehicle_occupancy_isneutraltoteam[var5].vehicle_occupancy_isneutraltoplayer = var4;
    }

    return;
  }
}

function extractplunder(var0, var1) {
  var0 = scripts\engine\utility::drop_to_ground(var0, 130);
  var2 = scripts\mp\mp_agent::spawnnewagentaitype("enemy_lw_br_juggernaut_x2", var0, var1);

  if(!isDefined(var2)) {
    return undefined;
  }

  var2.team = scripts\mp\gametypes\br_movingtrain_armored::run_openexfil_spawn();

  if(isDefined(level.teamnamelist) && !scripts\engine\utility::array_contains(level.teamnamelist, var2.team)) {
    level.teamnamelist = scripts\engine\utility::array_add(level.teamnamelist, var2.team);
  }

  var3 = getdvarint("scr_x2_health_agent", 3000);
  var2.loadout_giveweaponobj = 1;
  var2.maxhealth = var3;
  var2.health = var3;
  return var2;
}

function extractplunderhelihealth(var0, var1, var2) {
  var3 = [];

  if(var2 > 1) {
    var4 = 130;
    var5 = 360 / var2;

    for(var6 = 0; var6 < var2; var6++) {
      var7 = var6 * var5;
      var8 = vectortoangles((cos(var7), sin(var7), 0));
      var9 = anglesToForward(var8) * var4;
      var10 = var0 + var9;
      var3 = extractplunder(var10, var1);
    }
  } else {
    GscBinSkip0(0x2e, 0, extractplunder(var0, var1));
  }

  return var3;
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

  foreach(var1 in level.players) {
    var1.ref_1463a = 1;
    thread explosion_init();
    thread extra_bomb_explode_vfx_func(var1, "scn_x2_bombers_intro_siren_lr", var1);
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
  var3 = entisvehicle();
  thread explosivemodoverride(var3, 0);
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

function enemygunship_getshotgoal(var0) {
  level endon("game_ended");

  if(var0) {
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

  foreach(var1 in level.players) {
    var1 clearsoundsubmix("fade_to_black_all_except_music_and_scripted3", 0.3);
    var1 clearsoundsubmix("fade_to_black_all", 0.3);
    var1 setclientomnvar("ui_br_bink_overlay_state", 6);
  }

  wait 0.3;

  foreach(var1 in level.players) {
    var1 setclientomnvar("ui_br_bink_overlay_state", 4);
  }
}

function extractthink(var0) {
  level endon("game_ended");
  wait var0;
  extractunlockablechance(0);
  thread extraction_helicoptor_total_plunder();
  thread extracttablet_init(22);
}

function extractunlockablechance(var0) {
  level notify("stop_planes");
  thread extractunlockablelootid(var0);
  thread extractquest_unlockablelootid(entityplunderbankalldeposited(), 210, 2);
  thread extractupdatehud(5);
}

function enter_maze_ai_combat(var0) {
  exfil_sequence("flowExfilObjective");
  level endon("game_ended");
  var1 = getdvarfloat("scr_x2_vision_set_fade_time", 4);
  wait var0;
  exitdriver();
  extracting("mp_don4_outro_x2", var1);
  var2 = gettime() * 0.001;
  thread extractiontime(0, var2);
}

function expiredlootleaderinstance() {
  foreach(var1 in level.players) {
    var1.deletequestcircle = 1;
    var1 scripts\mp\laststand::playanim_aibegindismountturret("self_revive_success", var1);
  }

  thread eyeoffnotehandler();
  enter_numbers_debug_start(1);
  enter_combat_callback(1, 0);
  waitframe();
  wait 4;
  extra_enemies(12, 0, 1);
  var3 = expiredbydeath("mp_warzone_x2_outro", 1);
  var4 = 0;

  if(var4) {
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

    foreach(var1 in level.players) {
      if(!isDefined(var1)) {
        continue;
      }

      var1 clearsoundsubmix("fade_to_black_all", 0.5);
    }
  }

  level.blackoverlay destroy();
}

function extractquest_missionitem() {
  var0 = newhudelem();
  var0.x = 0;
  var0.y = 0;
  var0 setshader("black", 640, 480);
  var0.alignx = "left";
  var0.aligny = "top";
  var0.horzalign = "fullscreen";
  var0.vertalign = "fullscreen";
  var0.sort = -1;
  var0.alpha = 1;
  var0 sendcollectedclientanticheatdata(1);
  return var0;
}

function enemygunship_watchweaponimpact() {
  level endon("game_ended");
  thread scripts\mp\gametypes\br_vehicles::deleteextantvehicles();
  enemygunship_watchtargets((0, 0, 0));
}

function enemygunship_watchtargets(var0) {
  var1 = 250000;
  var2 = canceljoins(undefined, undefined, var0, var1);

  if(isDefined(var2)) {
    foreach(var4 in var2) {
      if(!scripts\mp\gametypes\br_pickups::update_gamebattles_char_loc(var4, 0)) {
        continue;
      }

      if(var4 getscriptableisreserved() && !isDefined(var4.embassy_main)) {
        continue;
      }

      scripts\mp\gametypes\br_pickups::ref_11a21(var4);
    }

    return;
  }
}

function extractiontime(var0, var1) {
  level endon("game_ended");
  wait var0;
  eomawardplayerxp();
  wait 1.8;
  extractionmethod();
  extractplayers(var1);
}

function extractplayers(var0) {
  foreach(var2 in level.disable_super_in_turret.onmaprestart) {
    var3 = spawn("script_model", var2.origin);
    var3 setModel("x2_military_old_recon_station");
    var4 = (0, 3, 30);
    var5 = spawn("script_model", var2.origin + var4);
    var5 scripts\mp\gameobjects::sethintobject(undefined, "HINT_BUTTON", undefined, &"BR_REVEAL_X2_EVENT/SIGNAL_POSITION", undefined, "duration_none", undefined, 350, 90, 80, 90);
    var5 istacmapactive();
    var5 hide();

    foreach(var7 in var2.ref_11e36) {
      var5 showtoplayer(var7);
      var5 enableplayeruse(var7);
      playFX(level._effect["vfx_br_x2_exfill_beacon"], var2.origin, undefined, undefined, var7);
      thread ref_14056(var5);
    }

    thread init_relic_no_ammo_mun(var5, var2.origin, 400, var2.ref_11e36, var2.ref_11f8a);
  }
}

function ref_14056(var0) {
  level endon("game_ended");
  self endon("death");
  self waittillmatch("trigger", var0);
  self hidefromplayer(var0);
  self disableplayeruse(var0);
  playFX(level._effect["vfx_br_x2_flare_exfill_r"], self.origin);
  var0 scripts\cp\vehicles\vehicle_compass_cp::ref_120a4("charm_x2");
}

function init_relic_no_ammo_mun(var0, var1, var2, var3, var4) {
  level endon("game_ended");
  self endon("death");
  self waittill("trigger", var5);
  var6 = 0;
  var7 = getdvarfloat("scr_x2_strike_1", 9);
  var8 = getdvarfloat("scr_x2_strike_2", 12);
  var9 = getdvarfloat("scr_x2_strike_3", 10);
  var10 = getdvarfloat("scr_x2_strike_4", 8);
  var11 = 2.5;
  var6 = var7 + var8 + var9 + var10 + var11;
  var12 = gettime() * 0.001 - var4;
  var13 = var6 - var12;

  if(var13 <= 0) {
    var13 = 30;
  }

  ref_131c4("waypoint_captureneutral_br", "neutral", "BR_REVEAL_X2_EVENT/ESTABLISHING_COMMUNICATIONS", 1);
  var14 = spawn("trigger_radius", var0, 0, int(var1), int(var1));
  var15 = scripts\mp\gametypes\obj_dom::setupobjective(var14, undefined, undefined, 1, 0);
  var15.flagmodel hide();
  var15.visibilitymanuallycontrolled = 1;
  var15.onlyexecutefromthefront = var2;
  var15.getrandompointincirclewithindistance = 1;
  var15.objidnum = var3;
  var15 scripts\mp\gameobjects::setcapturebehavior("single_progress");
  var15 scripts\mp\gameobjects::setusetime(var13);
  var15 scripts\mp\gameobjects::setclaimteam("none");
  var15 scripts\mp\gameobjects::setvisibleteam("any", undefined, 1);
  var15.onuseupdate = &ref_1388c;
  var15.usecondition = &ref_1388d;
  var15.onenduse = &scripts\mp\gametypes\obj_dom::dompoint_onuseend;
  var15.oncontested = &scripts\mp\gametypes\obj_dom::dompoint_oncontested;
  var15.onuncontested = &scripts\mp\gametypes\obj_dom::dompoint_onuncontested;
  var15.onunoccupied = &scripts\mp\gametypes\obj_dom::dompoint_onunoccupied;
  var15.onpinnedstate = &scripts\mp\gametypes\obj_dom::dompoint_onpinnedstate;
  var15.onunpinnedstate = &scripts\mp\gametypes\obj_dom::dompoint_onunpinnedstate;
  exfil_sequence("Objective #" + var3 + " converted into capture objective.");
}

function ref_131c4(var0, var1, var2, var3) {
  level.waypointcolors[var0] = var1;
  level.waypointbgtype[var0] = 1;
  level.waypointstring[var0] = var2;
  level.waypointshader[var0] = "ui_mp_br_mapmenu_icon_extraction_objective";
  level.waypointpulses[var0] = var3;
}

function ref_1388d(var0) {
  if(isDefined(var0) && scripts\engine\utility::array_contains(self.onlyexecutefromthefront, var0)) {
    return true;
  }

  return false;
}

function ref_1388c(var0, var1, var2, var3) {
  var4 = 0.95;

  if(var1 > var4) {
    self.curprogress = var4 * self.usetime;
    self.teamprogress[self.claimteam] = self.curprogress;
  }

  if(var1 < 1 && !level.gameended) {
    ref_12427(var1, var0);
  }

  if(var1 > 0.05 && var2 && !istrue(self.didstatusnotify)) {
    self.didstatusnotify = 1;
    return;
  }
}

function ref_12427(var0, var1) {
  if(!isDefined(self.lastsfxplayedtime)) {
    self.lastsfxplayedtime = gettime();
  }

  if(self.lastsfxplayedtime + 995 < gettime()) {
    self.lastsfxplayedtime = gettime();
    var2 = "";
    var0 = int(floor(var0 * 10));
    var2 = "mp_dom_capturing_tick_0" + var0;
    self.visuals[0] playsoundtoteam(var2, var1);
    return;
  }
}

function extractionmethod() {
  foreach(var1 in level.players) {
    if(isalive(var1)) {
      var1 scripts\mp\hud_message::showsplash("br_x2_exfil");
    }
  }
}

function eomawardplayerxp() {
  foreach(var1 in level.disable_super_in_turret.onmaprestart) {
    var2 = scripts\mp\objidpoolmanager::requestobjectiveid(99);
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var2);
    scripts\mp\objidpoolmanager::objective_add_objective(var2, "current", var1.origin + (0, 0, 80), "ui_mp_br_mapmenu_icon_extraction_tablet_x2");
    scripts\mp\objidpoolmanager::update_objective_setbackground(var2, 1);
    scripts\mp\objidpoolmanager::ref_11f82(var2, var1.ref_11e36);
    level.disable_super_in_turret.onmaprestart[var3].ref_11f8a = var2;
  }
}

function exitdriver() {
  enemy_vehicle_setup();
  var0 = entityplunderlosealldeposited();
  var1 = getdvarint("scr_x2_exfil_points_failsafe_enable", 1) == 1;

  if(var1) {
    exfil_sequence("Failsafe is enabled.");
    var2 = 0;
    var3 = "";

    foreach(var5 in level.players) {
      if(!isDefined(var5.ref_14657)) {
        var3 += var5.name + ", ";
        var2++;
      }
    }

    if(isDefined(level.disable_super_in_turret.onmaprestart)) {
      exfil_sequence("Exfil points are already assigned. Skipping assignation.");
    }

    if(var2 == 0) {
      exfil_sequence("All players have assigned points. Skipping assignation.");
    } else {
      exfil_sequence("Some players (" + var2 + ") have unassigned points : " + var3);
    }

    if(!isDefined(level.disable_super_in_turret.onmaprestart) && var2 > 0) {
      level.disable_super_in_turret.onmaprestart = enemy_spawnnewscrambler(var0);
    }

    thread equipmentuse();
  } else {
    level.disable_super_in_turret.onmaprestart = enemy_spawnnewscrambler(var0);
  }

  exfil_retreat();
}

function enemy_spawnnewscrambler(var0) {
  var1 = getdvarfloat("scr_x2_exfil_distance", 150);

  foreach(var4, var3 in var0) {
    var0[var4].ref_11e36 = [];
  }

  foreach(var6 in level.players) {
    var7 = undefined;
    var8 = undefined;

    foreach(var4, var3 in var0) {
      var10 = entisalivevehicle(var3.origin, var6.origin);
      var11 = abs(var10 - var1);

      if(!isDefined(var8) || var11 < var8) {
        var7 = var4;
        var8 = var11;
      }
    }

    var0[var7].ref_11e36[var0[var7].ref_11e36.size] = var6;
    var6.ref_14657 = var0[var7];
  }

  exfil_sequence("Exfil points have been assigned to all players.");

  foreach(var3 in var0) {
    if(var3.ref_11e36.size == 0) {
      var0[var4] = undefined;
    }
  }

  return scripts\engine\utility::array_removeundefined(var0);
}

function exfil_retreat() {
  foreach(var1 in level.disable_super_in_turret.onmaprestart) {
    var2 = "Exfil Point #" + var6 + " Players : ";

    foreach(var4 in var1.ref_11e36) {
      var2 += var4.name + ", ";

      if(var4.ref_14657 != var1) {
        exfil_sequence("Player " + var4.name + " assignation and exfil assignation are different!");
      }
    }

    exfil_sequence(var2);
  }
}

function equipmentuse() {
  level endon("game_ended");
  level endon("stop_bomb");
  var0 = getdvarfloat("scr_x2_exfil_delay_verify_visibility", 0.05);

  for(;;) {
    if(var0 <= 0) {
      waitframe();
    } else {
      wait var0;
    }

    enemy_sentry_debug();
  }
}

function enemy_sentry_debug() {
  foreach(var1 in level.disable_super_in_turret.onmaprestart) {
    if(isDefined(var1.ref_11f8a)) {
      scripts\mp\objidpoolmanager::ref_11f82(var1.ref_11f8a, scripts\engine\utility::array_removeundefined(var1.ref_11e36));
    }
  }
}

function entityplunderlosealldeposited() {
  var0 = [];
  var1 = entity_movingplatform_update();
  var2 = level.br_level.br_circleradii[0];
  var3 = getdvarfloat("scr_x2_exfil_height", 50);
  var0 = scripts\mp\gametypes\br_ending::propminigamefinish([], var1, 1);

  if(level.script == "mp_br_mechanics") {
    return var0;
  }

  var4 = 0;

  foreach(var6 in var0) {
    if(!var4 && distance2d(var6.origin, var1) > var2) {
      var4 = 1;
    }

    if(var4 || var6.origin[2] >= var3) {
      var0[var7] = undefined;
    }
  }

  return scripts\engine\utility::array_removeundefined(var0);
}

function enemy_vehicle_setup() {
  if(isDefined(level.disable_super_in_turret.onmaprestart)) {
    exfil_sequence("All existing exfil objectives cancelled.");

    foreach(var1 in level.disable_super_in_turret.onmaprestart) {
      if(isDefined(var1.ref_11f8a)) {
        scripts\mp\objidpoolmanager::returnobjectiveid(var1.ref_11f8a);
        var1.ref_11f8a = undefined;
      }
    }

    return;
  }
}

function enter_numbers_end() {
  var0 = level.squaddata;

  if(scripts\mp\menus::brking_updateteamscore()) {
    var0 = [level.squaddata["allies"]];
  }

  return var0;
}

function entisalivevehicle(var0, var1) {
  var2 = distance2d(var0, var1);
  var3 = 0.0254 * var2;
  return var3;
}

function extracttablet_init(var0) {
  level endon("game_ended");
  wait var0;
  var1 = getdvarfloat("scr_x2_bomb_duration", 60);
  level thread _hidesafecircleui::chase(var1);
}

function exfil_spawners_triggered(var0) {
  var1 = var0.damage;

  if(istrue(self.inlaststand) && isDefined(level.ref_12f8f) && level.ref_12f8f >= 3) {
    var2 = var0.meansofdeath == "MOD_TRIGGER_HURT" && var0.objweapon.basename == "iw8_gunless";

    if(!var2 || istrue(level.disable_super_in_turret.unset_ignoreall_after_notify)) {
      var1 = 0;
    }

    if(var1 >= self.health) {
      var1 = self.health - 1;
    }
  } else if(istrue(self.ref_1463a) || isDefined(level.ref_12f8f) && level.ref_12f8f > 3) {
    if(var1 >= self.health) {
      var1 = self.health - 1;
    }
  }

  return var1;
}

function extraction_helicoptor_total_plunder() {
  level endon("game_ended");
  level waittill("bomb_started");
  var0 = [];
  GscBinSkip0(0x2e, var0.size, getdvarfloat("scr_x2_strike_1", 9));
}

function exfil_objective(var0, var1) {
  level endon("game_ended");
  var0 endon("disconnect");
  thread exit_level(var1, var0);
  wait 1;
  var2 = anglesToForward(var0.angles);
  var3 = var0.origin + var2 * 300;
  var4 = var0.maxhealth / 2;
  var5 = 0;
  var6 = 6;
  level thread _hidesafecircleui::ref_12e21(var3, 0, var0);
  wait 0.15;

  switch (var1) {
    case 1:
      extract_ismissionweapon(var0);
      break;
    case 3:
      scripts\mp\gametypes\br::scriptednode(var0);
      var0.ref_1463a = 0;
      var4 = 9999;
      var5 = 1;
      var6 = 3.5;
      var0 scripts\mp\utility\player::hidehudenable();
      var0.littlebirdsmg = 1;
      break;
    case 4:
      var3 = var0.origin;
      break;
  }

  extratimeincreasecountcap(var0, var6, var5, 1);

  if(!istrue(var0.unset_relic_trex) && var1 <= 3) {
    var0 dodamage(var4, var3, var0, undefined, "MOD_EXPLOSIVE", "artillery_mp");
  }

  var0.ref_1463a = 1;
  level notify("strike_" + var1);
}

function engagementtime(var0, var1) {
  level endon("game_ended");
  wait var0;

  foreach(var3 in level.players) {
    var3 scripts\common\utility::allow_mantle(0);
  }

  wait var1;

  foreach(var3 in level.players) {
    var3 scripts\common\utility::allow_mantle(1);
  }
}

function extract_ismissionweapon() {
  var0 = self.meleeweapons;

  if(var0.size == 0) {
    var0 = ["iw8_fists_mp"];
  }

  self takeallweapons();

  foreach(var2 in var0) {
    self giveweapon(var2);
    self assignweaponmeleeslot(var2);
    self switchtoweapon(var2);
  }
}

function extratimeincreasecountcap(var0, var1, var2) {
  var1 = istrue(var1);
  var2 = istrue(var2);

  if(scripts\mp\utility\perk::_hasperk("specialty_stun_resistance")) {
    scripts\mp\utility\perk::removeperk("specialty_stun_resistance");
  }

  scripts\mp\weapons::setplayerstunned();
  thread scripts\mp\weapons::cleanupconcussionstun(var0);
  scripts\cp_mp\utility\shellshock_utility::_stopshellshock();

  if(var2) {
    if(var1) {
      scripts\cp_mp\utility\shellshock_utility::_shellshock("flash_grenade_mp_x2", "bottom", var0, 1);
      return;
    }

    scripts\cp_mp\utility\shellshock_utility::_shellshock("mp_don4_x2_explosion_outro", "bottom", var0, 1);
    return;
  }

  scripts\cp_mp\utility\shellshock_utility::_shellshock("mp_don4_x2_explosion", "bottom", var0, 1);
}

function extractunlockablelootid(var0) {
  level endon("game_ended");
  level endon("stop_planes");
  var1 = getdvarint("scr_x2_planes_enable", 1);

  if(var1 <= 0) {
    return;
  }

  if(!isDefined(level.disable_super_in_turret.ref_123ac)) {
    level.disable_super_in_turret.ref_123ac = 0;
  }

  foreach(var3 in level.players) {
    var3 setclienttriggeraudiozonepartialwithfade("br_x2_bombers_attack", 3, "reverb", "mix", "filter", "ambient");
  }

  var5 = getdvarfloat("scr_x2_planes_delay", 5.5);
  var6 = 0;

  for(;;) {
    thread extractlocale_onentergulag(entityplunderbankalldeposited(), var6);
    var6++;
    wait var5;
  }
}

function extractlocale_onentergulag(var0, var1) {
  level endon("game_ended");
  level endon("stop_planes");
  var2 = 300;
  var0 = (var0[0] + -10000, var0[1] + -8000, -6000);
  var3 = vectortoangles((cos(var2), sin(var2), 0));
  var4 = scripts\engine\utility::spawn_tag_origin(var0, var3);
  var5 = [];
  var6 = ["plane3", "plane4", "plane5"];

  if(istrue(level.disable_super_in_turret.unset_ignoreall_after_notify)) {
    var6 = ["plane3"];
  }

  foreach(var8 in var6) {
    var9 = extractlocale_islocaleavailable((0, 0, 0));
    var9.animname = var8;
    var9 useanimtree(level.scr_animtree[var8]);
    var9 unmarkkeyframedmover(1);
    var5 = var9;
  }

  thread enemy_traversal_management(var4, var5, var1);
  var4 scripts\common\anim::anim_single(var5, "x2_plane", undefined, 17);
  level notify("end_wave_" + var1);
}

function enemy_traversal_management(var0, var1, var2) {
  level endon("game_ended");
  var3 = var1.size + 1;
  level.disable_super_in_turret.ref_123ac += var3;
  level scripts\engine\utility::ref_143ad("stop_planes", "end_wave_" + var2);

  foreach(var5 in var1) {
    var5 delete();
  }

  var0 delete();
  level.disable_super_in_turret.ref_123ac -= var3;
}

function extractlocale_onrespawn(var0) {
  level notify("stop_planes");

  if(!isDefined(level.disable_super_in_turret.ref_123ac)) {
    level.disable_super_in_turret.ref_123ac = 0;
  }

  var1 = (-50000, -15000, 0);
  var2 = (12000, 0, 0);
  var3 = 6;

  for(var4 = 0; var4 < var3; var4++) {
    var5 = var0 + var1 + var4 * var2;
    thread extractlocale_onentergulag(var5, var4);
  }
}

function extractlocale_islocaleavailable(var0) {
  var1 = spawn("script_model", var0);
  var1 setModel("veh8_mil_air_ca_ger_bomber_117_group_ultralow");
  var1.angles = (0, 0, 0);
  return var1;
}

function entityplunderbankalldeposited() {
  var0 = scripts\engine\utility::array_removeundefined(level.players);
  return scripts\mp\gametypes\br_ending::get_center_of_array(var0);
}

function extractupdatehud(var0) {
  level endon("game_ended");
  level endon("stop_planes");
  var1 = getdvarint("scr_x2_shadows_enable", 1);

  if(var1 <= 0) {
    return;
  }

  wait var0;
  setDvar("NPONLLLSPL", 0.8);
  setDvar("LSNRQTOKRR", 1);
  setDvar("NTLKNLNPLK", 2);
  level.disable_super_in_turret.ref_119dc = [];
  thread equipname();
  var2 = 210;
  var3 = (cos(var2 + 90), sin(var2 + 90), 0);
  var4 = var3 * 6500;

  for(;;) {
    var5 = entityplunderbankalldeposited();
    thread extractquest_alwaysallowdeposit(var5, var2);
    thread extractquest_alwaysallowdeposit(var5 + var4, var2);
    thread extractquest_alwaysallowdeposit(var5 - var4, var2);
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
    for(var0 = 0; var0 < level.disable_super_in_turret.ref_119dc.size; var0++) {
      var1 = level.disable_super_in_turret.ref_119dc[var0];

      if(isDefined(var1)) {
        var1 delete();
      }
    }
  }

  level.disable_super_in_turret.ref_119dc = [];
}

function extractquest_alwaysallowdeposit(var0, var1) {
  level endon("game_ended");
  var2 = extractquest_missionweapon(var0, var1, "vfx_br_x2_plane_shadow_multiple");

  for(var3 = 0; var3 <= level.disable_super_in_turret.ref_119dc.size; var3++) {
    if(!isDefined(level.disable_super_in_turret.ref_119dc[var3])) {
      level.disable_super_in_turret.ref_119dc[var3] = var2;
      break;
    }
  }

  wait 40;

  if(isDefined(var2)) {
    var2 delete();
    return;
  }
}

function extractquest_unlockablelootid(var0, var1, var2) {
  level endon("game_ended");
  level endon("stop_planes");
  wait var2;
  var3 = extractquest_missionweapon(var0, var1, "vfx_br_x2_square_shadow");

  if(isDefined(level.disable_super_in_turret.ref_1374a)) {
    level.disable_super_in_turret.ref_1374a delete();
  }

  level.disable_super_in_turret.ref_1374a = var3;
  wait 120;

  if(isDefined(var3)) {
    var3 delete();
    return;
  }
}

function extractquest_missionweapon(var0, var1, var2) {
  var0 = (var0[0], var0[1], 2000);
  var3 = vectortoangles((cos(var1), sin(var1), 0));
  var4 = spawn("script_model", var0);
  var4 setModel(var2);
  var4.angles = var3;
  return var4;
}

function exitvehicle_oldturnrate(var0, var1, var2, var3, var4) {
  level endon("game_ended");
  extra_enemies(var1, var2, var3);
  expiredbydeath(var0, var4);
  stopcinematicforall();
  enemygunship_getfiretime(0, var2, var3);
}

function extra_enemies(var0, var1, var2) {
  foreach(var4 in level.players) {
    if(!isDefined(var4)) {
      continue;
    }

    var4 setclientomnvar("ui_br_bink_overlay_state", var0);

    if(var1) {
      var4 setsoundsubmix("fade_to_black_all_except_music_and_scripted3", 0.5);
    }

    if(var2) {
      var4 setsoundsubmix("fade_to_black_all", 0.5);
    }
  }
}

function enemygunship_getfiretime(var0, var1, var2) {
  foreach(var4 in level.players) {
    if(!isDefined(var4)) {
      continue;
    }

    if(var1) {
      var4 clearsoundsubmix("fade_to_black_all_except_music_and_scripted3", 0.5);
    }

    if(var2) {
      var4 clearsoundsubmix("fade_to_black_all", 0.5);
    }

    var4 setclientomnvar("ui_br_bink_overlay_state", var0);
  }
}

function exfil_spots_objs_settings(var0, var1) {
  if(var0 == "bink_complete") {
    level notify("bink_complete");
    return;
  }
}

function expirationtimer(var0, var1) {
  level notify("bink_start");
  playcinematicforall(var0, 1, var1);
}

function expiredbydeath(var0, var1) {
  var2 = 0;
  var3 = 0;
  var4 = getdvarint("scr_x2_max_attempt_binks", 1);
  jumpiffalse(var4 < 1) LOC_00000020;
  var4 = 1;

  while(!var3 && var2 < var4) {
    expirationtimer(var0, var1);

    if(var2 == 0) {
      switch (var0) {
        case "mp_warzone_x2_outro":
          waitframe();
          enter_combat_callback(0, 0);
          level.blackoverlay = extractquest_missionitem();
          break;
      }
    }

    var5 = scripts\engine\utility::ref_143bf(3, "bink_complete");
    var3 = var5 == "timeout";

    if(!var3) {
      exfil_sequence("Failed to play bink '" + var0 + "', attempt #" + var2 + 1 + ", waittill return value is " + var5);
    }

    var2++;

    if(!var3 && var2 < var4) {
      stopcinematicforall();
      enemygunship_getfiretime(0, 0, 0);
      waitframe();
      extra_enemies(12, 0, 0);
    }
  }

  if(var0 == "mp_warzone_intro_x2") {
    thread enemygunship_watchdamage();
  }

  if(var3) {
    switch (var0) {
      case "mp_warzone_intro_x2":
        wait 19;
        enter_numbers_debug_start(0);
        thread enemygunship_getshotgoal(var3);
        break;
      case "mp_warzone_x2_outro":
      case "mp_warzone_intro2_x2":
        wait 7.5;

        foreach(var7 in level.players) {
          var7 setclientomnvar("ui_br_bink_overlay_state", 10);
        }

        break;
    }

    level waittill("bink_complete");
  } else {
    switch (var0) {
      case "mp_warzone_intro_x2":
        stopcinematicforall();
        enter_numbers_debug_start(0);
        enemygunship_getfiretime(0, 0, 1);
        break;
    }
  }

  return var3;
}

function enemygunship_watchdamage() {
  wait 16;
  scripts\mp\gametypes\br_movingtrain::tr_findvehicle(1);
}

function enter_combat_callback(var0, var1) {
  foreach(var3 in level.players) {
    thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(var3, var0, var1);
  }

  if(var1 > 0) {
    wait var1;
    return;
  }
}

function enter_numbers_debug_start(var0, var1) {
  foreach(var3 in level.players) {
    var3 scripts\mp\utility\player::_freezecontrols(var0, var1);
  }
}

function equip_trophies() {
  level endon("game_ended");

  foreach(var1 in level.players) {
    if(!isDefined(var1)) {
      continue;
    }

    var1 scripts\cp\vehicles\vehicle_compass_cp::ref_120a4("emblem_1_x2");
  }
}

function equipgasmaskbr() {
  foreach(var1 in level.players) {
    if(!isDefined(var1)) {
      continue;
    }

    var1 scripts\cp\vehicles\vehicle_compass_cp::ref_120a4("rpd_blueprint");
  }
}

function equipprimarypickup(var0, var1) {
  if(var0 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    var0 = var0.owner;
  }

  if(!isDefined(var0) || !isPlayer(var0)) {
    return;
  }

  if(!isDefined(var0.ref_14656)) {
    exclude_me(var0);
  }

  var0.ref_14656["train"] = var0.ref_14656["train"] + var1;
  var2 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var0.team, var0.squadindex);

  while(var0.ref_14656["train"] > 1000) {
    var0 thread scripts\mp\utility\points::giveunifiedpoints("br_x2_train_damage");
    extractgroundpos(var0, var2, level.ent_delete_by_targetname);
    var0.ref_14656["train"] = var0.ref_14656["train"] - 1000;
  }
}

function equipsecondarypickup(var0, var1) {
  if(var0 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    var0 = var0.owner;
  }

  if(!isDefined(var0) || !isPlayer(var0)) {
    return;
  }

  var2 = var0 getxuid();

  if(!isDefined(var0.ref_14656)) {
    exclude_me(var0);
  }

  var0.ref_14656["turret"] = var0.ref_14656["turret"] + var1;
  var3 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var0.team, var0.squadindex);

  while(var0.ref_14656["turret"] > 500) {
    var0 thread scripts\mp\utility\points::giveunifiedpoints("br_x2_turret_damage");
    extractgroundpos(var0, var3, level.ent_model);
    var0.ref_14656["turret"] = var0.ref_14656["turret"] - 500;
  }

  if(self.health <= 0) {
    foreach(var5 in level.players) {
      var5 thread scripts\mp\utility\points::giveunifiedpoints("br_x2_turret_disabled");
    }

    return;
  }
}

function extractgroundpos(var0, var1, var2) {
  foreach(var4 in var1) {
    if(!isDefined(var4)) {
      continue;
    }

    if(var4 == var0) {
      continue;
    }

    if(enemy_waittill_seen(var4)) {
      var4 thread scripts\mp\utility\points::giveunifiedpoints("br_x2_driver_assist");
      scripts\mp\gametypes\br_movingtrain_armored::ref_13fcf(var4, 105);
    }
  }
}

function enemy_waittill_seen(var0) {
  if(var0 scripts\cp_mp\utility\player_utility::isinvehicle()) {
    var1 = var0 scripts\cp_mp\utility\player_utility::getvehicle();

    if(!isDefined(var1)) {
      return false;
    }

    var2 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(var1, 1);

    if(isDefined(var2) && var2 == var0) {
      var3 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var1, 1);

      if(isDefined(var3) && var3.size > 1) {
        return true;
      }

      var4 = scripts\mp\utility\player::getplayersinradius(var1.origin, 200);

      foreach(var6 in var4) {
        if(!isDefined(var6)) {
          continue;
        }

        if(var6 == var0) {
          continue;
        }

        var7 = var6 getgroundentity();

        if(isDefined(var7) && var7 == var1) {
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

  foreach(var1 in level.players) {
    exclude_me(var1);
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

  foreach(var1 in level.players) {
    var1 scripts\mp\utility\perk::giveperk("specialty_surveillance");
  }
}

function extractquest_helipadid() {
  level endon("game_ended");
  self.itemsdropped = 0;
  var0 = [["brloot_weapon_lm_t9accurate_lege", 5], ["brloot_super_munitionsbox", 10], ["brloot_weapon_lm_t9light_lege", 5], ["brloot_ammo_762", 15], ["brloot_weapon_lm_t9accurate_lege", 5], ["brloot_ammo_rocket", 15], ["brloot_weapon_lm_t9light_lege", 5]];
  var1 = spawnStruct();
  var1.origin = self.origin;
  var1.angles = self.angles;
  var1.dropstruct = scripts\mp\gametypes\br_pickups::test_ai_anim();
  var1.dropstruct.ml_p3_to_safehouse_transition = 250;
  var1.dropstruct.silencer_pick_up_monitor = 150;
  var2 = self.angles + (0, 45, 0);

  foreach(var4 in var0) {
    var5 = var4[0];
    var6 = var4[1];

    if(scripts\mp\gametypes\br_lootcache::get_bonus_targets(var5)) {
      for(var7 = 0; var7 < var6; var7++) {
        var8 = scripts\mp\gametypes\br_lootcache::ref_11a41(var5, var1.dropstruct, self.origin + (0, 0, var1.dropstruct.silencer_pick_up_monitor), var2, 0, 0);
        var1.dropstruct.silencer_pick_up_monitor += 3;
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
  var0 = self.ref_14657;
  var1 = distance(var0.origin, self.origin);

  if(var1 >= 2700) {
    thread expiredlootleaderenabled("outro_keep_running", 8, 0);
  }

  level waittill("strike_2");
  thread expiredlootleaderenabled("outro_exfil_almost_over", 5.5, 0);
}

function expiredlootleaderenabled(var0, var1, var2) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(var1) && var1 > 0) {
    wait var1;
  }

  if(isDefined(var2) && var2 == 1) {
    scripts\mp\gametypes\br_public::dmztut_endgamewithreward(var0, self, 0);
    return;
  }

  var3 = lookupsoundlength(game["dialog"][var0], 1) / 1000;
  self queuedialogforplayer(game["dialog"][var0], var0, var3);
}

function extendcirclelist() {
  level endon("game_ended");
  level waittill("drop_resuply");
  var0 = randomint(2);
  var1 = "resuply_drop" + var0;

  foreach(var3 in level.players) {
    thread expiredlootleaderenabled(var3, var1, 0);
  }
}

function entisvehicle() {
  var0 = undefined;

  if(level.script == "mp_don4") {
    var0 = spawnStruct();
    var0.origin = (4555.72, -36115.3, -200.848);
    var0.angles = (0, -156.66, 0);
    var1 = getdvarfloat("scr_x2_exfil_x_offset", 1000);
    var2 = getdvarfloat("scr_x2_exfil_y_offset", 600);
    var0.origin += (var1, var2, 0);
  } else {
    if(!isDefined(level.disable_super_in_turret.onmaprestart)) {
      exitdriver();
    }

    var0 = level.disable_super_in_turret.onmaprestart[0];
  }

  var3 = getdvarfloat("scr_x2_exfil_angle", -60);
  var0.angles = (0, var3, 0);
  return var0;
}

function explosivemodoverride(var0, var1) {
  level endon("game_ended");
  level.disable_super_in_turret.unset_ignoreall_after_notify = 1;
  thread extra_glow_sticks_init(var0);
  level.disable_super_in_turret.onlineprimaryoverride = [];
  var2 = scripts\engine\utility::spawn_tag_origin(var0.origin, var0.angles);
  scripts\engine\utility::exploder("x2_se_juggernaut");
  var3 = 1;

  while(var3) {
    var3 = getdvarint("scr_x2_exfil_loop", 0) > 0;
    level.disable_super_in_turret.update_game_cyber = var3;

    foreach(var5 in level.players) {
      if(!isDefined(var5)) {
        continue;
      }

      thread extactionstart(var5);
      thread enemy_spawners();
      var5 setclientdvar("LTMOQONPQ", 1);
      var5 setclientdvar("QTSPTNLOL", 90);
    }

    scripts\engine\utility::ref_143bf(10, "strike_4");
    level notify("stop_bomb");
    enter_combat_callback(1, 0);
    waitframe();

    foreach(var5 in level.players) {
      var5 setclientdvar("LTMOQONPQ", 0);
      var5 setclientdvar("QTSPTNLOL", 65);
    }
  }

  level.disable_super_in_turret.unset_ignoreall_after_notify = 0;
  scripts\engine\utility::kill_exploder("x2_se_juggernaut");

  foreach(var5 in level.players) {
    var5 scripts\mp\utility\player::hidehuddisable();
    var5 playershow();
    var5 clearclienttriggeraudiozone(0);
  }

  if(var1) {
    wait 2;
    enter_combat_callback(0, 0);

    foreach(var5 in level.players) {
      var5 scripts\mp\utility\player::_freezecontrols(0);
      var5 clearsoundsubmix("fade_to_black_all_except_music_and_scripted3", 0.5);
      var5 clearsoundsubmix("fade_to_black_all", 0.5);
    }
  }

  level notify("stop_planes");
}

function extra_glow_sticks_init(var0) {
  level endon("game_ended");
  var1 = 0;

  foreach(var3 in level.players) {
    if(!var1) {
      var3 scripts\mp\utility\player::_freezecontrols(1);
    }

    var3 clearsoundsubmix("deaths_door_mp", 0.3);
    var3 setOrigin(var0.origin);
    var3 scripts\mp\utility\player::hidehudenable();
    var3 playerhide();
  }

  extracting("mp_don4_exfil_x2", 0);
  extractlocale_onrespawn(var0.origin);
  _hidesafecircleui::ref_13b3f(1100);
}

function extractmissionhelipadmodel(var0) {
  for(var1 = 1; var1 <= 3; var1++) {
    var2 = "guy" + var1;
    var3 = extractposition((0, 0, 0), (0, 0, 0));
    explosive_cars(var0, var3, var2);
    level.disable_super_in_turret.onlineprimaryoverride[var2] = var3;
  }

  var4 = extractquest_removequestinstance((0, 0, 0), (0, 0, 0));
  explosive_cars(var0, var4, "guy4");
  level.disable_super_in_turret.onlineprimaryoverride["guy4"] = var4;
}

function explosive_cars(var0, var1, var2) {
  var1.animname = var2;
  var1 useanimtree(level.scr_animtree[var2]);
  var0 thread scripts\common\anim::anim_single_solo(var1, "x2_exfil");

  if(isDefined(var1.headmodel)) {
    var1.headmodel scriptmodelplayanim(level.scr_animname[var2]["x2_exfil_mute"]);
  }

  if(isDefined(var1.ref_14595)) {
    var1.ref_14595 scriptmodelplayanim(level.scr_animname[var2]["x2_exfil_mute"]);
    return;
  }
}

function extactionstart(var0) {
  level endon("game_ended");
  var1 = spawn("script_arms", (0, 0, 0), 0, 0, self);
  var1.angles = (0, 0, 0);
  var1 useanimtree(#animtree);
  var1 hide();
  var1 showtoplayer(self);
  self.ref_12651 = var1;
  var2 = 0;

  if(!var2) {
    self cameralinkTo(var1, "tag_camera", 1, 1);
  }

  var1 animScripted("exfil", var0.origin, var0.angles, %br_exfil_x2_player);
  var1 scriptmodelplayanim("br_exfil_x2_player");
  var1 waittillmatch("exfil", "end");
  self cameraunlink();
  self stopanimscriptsceneevent();
  self.ref_12651 = undefined;
  var1 delete();
}

function enemygunship_watchexfilsequencestart() {
  var0 = ["guy1", "guy2", "guy3", "guy4"];

  foreach(var2 in var0) {
    var3 = level.disable_super_in_turret.onlineprimaryoverride[var2];

    if(isDefined(var3)) {
      if(isDefined(var3.headmodel)) {
        var3.headmodel delete();
      }

      if(isDefined(var3.ref_14595)) {
        var3.ref_14595 delete();
      }

      var3 delete();
    }
  }
}

function extractquest_removequestinstance(var0, var1) {
  return extractlocale_removelocaleinstance(var0, var1, "body_mp_western_fireteam_west_ar_1_1", "head_mp_western_fireteam_west_ar_1_1", undefined);
}

function extractposition(var0, var1) {
  return extractlocale_removelocaleinstance(var0, var1, "body_opforce_juggernaut_x2", "head_opforce_juggernaut_x2", "weapon_wm_lm_dblmg_juggernaut");
}

function extractlocale_removelocaleinstance(var0, var1, var2, var3, var4) {
  var5 = spawn("script_model", var0);
  var5 setModel(var2);
  var5.angles = var1;

  if(isDefined(var3)) {
    var6 = spawn("script_model", var0);
    var6 setModel(var3);
    var6 linkTo(var5, "j_spine4", (0, 0, 0), (0, 0, 0));
    var5.headmodel = var6;
  }

  if(isDefined(var4)) {
    var7 = spawn("script_model", var0);
    var7 setModel(var4);
    var7 linkTo(var5, "j_gun", (0, 0, 0), (0, 0, 0));
    var5.ref_14595 = var7;
  }

  return var5;
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

function enemy_validate_node_proximity(var0, var1) {
  level endon("game_ended");
  var2 = spawnStruct();
  var2.streakname = "precision_airstrike";
  var2.owner = level.players[0];
  var2.score = 0;
  var2.shots_fired = 0;
  var2.hits = 0;
  var2.damage = 0;
  var2.kills = 0;
  var2.setuptimelimit = 1;
  var2.brmini_ontimelimit = 0;
  var2.burst_fire_turret = 0.65;
  var2.animname = % mp_alfa10_flyin;
  var2.ref_1360d = 1;
  var2.ref_12186 = 1;
  var3 = undefined;
  var4 = undefined;
  var5 = 24000;
  var6 = 6500;
  var7 = 950;
  var8 = 1500;
  var9 = 215;
  var10 = (0, var1, 0);
  var11 = undefined;
  var12 = scripts\cp_mp\killstreaks\airstrike::getflightpath(var0, var10, var5, 1, var7, var6, var8, var2.streakname, var11);
  var13 = [];
  GscBinSkip0(0x2e, var13.size, (0, 0, 0));
}

function extra_collision() {
  if(isDefined(self.streakinfo.burst_fire_turret) && isDefined(self.streakinfo.animname)) {
    self setanimrate(self.streakinfo.animname, self.streakinfo.burst_fire_turret);
    return;
  }
}

function escape_if_player_is_in_hangar(var0, var1, var2, var3, var4) {
  var0 endon("death");

  if(!istrue(var0.streakinfo.ref_1360d)) {
    return;
  }

  if(isDefined(var0.streakinfo.burst_fire_turret)) {
    var1 = (var1 + 1.25) / var0.streakinfo.burst_fire_turret;
  } else {
    var1 = var1;
  }

  var5 = var0.flightdir;
  var0.bulletpoint setModel("ks_airstrike_target_mp_x2");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var1);
  var6 = 5;
  var7 = (0, 0, 0);
  var8 = var7;
  var0.bulletpoint setscriptablepartstate("bullet_impact", "on", 0);
  var9 = 0;
  var10 = 0;
  var11 = [var3 - var5 * 512, var3 - var5 * 256, var3, var3 + var5 * 256, var3 + var5 * 512];
  var12 = var3[2] + var0.flightheight * 3;

  for(var13 = 0; var13 < var6; var13++) {
    var14 = -50;
    var15 = 150;

    while(var9 < var10 + 4) {
      var16 = scripts\cp_mp\killstreaks\airstrike::callstrike_getrandomshotoffset(var14, var15, var11[var13], var0.angles);
      var17 = var0 gettagorigin("tag_turret_fx") * (1, 1, 0) + (0, 0, var12) + var5 * 1000;
      var18 = vectorNormalize(var16 - var17);
      var19 = var16 + var18 * 30000;
      var20 = scripts\engine\trace::ray_trace(var17, var19, undefined, scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 1, 0));
      var21 = var20["position"];
      var22 = var20["normal"];
      var23 = var21 + var22 * 10;
      var24 = vectorNormalize(var21 - var0 gettagorigin("tag_turret_fx"));
      var25 = vectorcross(var24, (0, 0, 1));
      var26 = vectorcross(var25, var24);
      var0 thread scripts\cp_mp\killstreaks\airstrike::callstrike_playmultitracerfx(scripts\engine\utility::getfx("airstrike_tracer"), var23, var24, var26);
      var0.bulletpoint thread scripts\cp_mp\killstreaks\airstrike::moveanddamagepoint(var9 + 1, var23);
      var8 = var21;
      var9++;
      var0.bulletpoint.streakinfo.shots_fired++;
      var14 += 20;
      var15 += 40;
      var12 -= 200;

      if(var12 < var0.flightheight) {
        var12 = var0.flightheight;
      }

      wait 0.05;
    }

    var10 = var9;
  }

  var0 notify("fire_finished");
  var0.bulletpoint setscriptablepartstate("bullet_impact", "off", 0);
}

function exit_open(var0, var1, var2, var3, var4, var5, var6) {
  var0 endon("death");
  level endon("game_ended");
  var0 thread scripts\cp_mp\killstreaks\airstrike::airstrike_delayplayscriptable(0.05);
  var7 = 1.65 / var6.burst_fire_turret;
  var8 = 6.917 / var6.burst_fire_turret;
  var9 = (var4 + 1.25) / var6.burst_fire_turret;
  var10 = 30;
  var0.player_waittilljumpedfromc130 = spawn("script_model", var1);
  var0.player_waittilljumpedfromc130 setModel("ks_airstrike_mp");
  var0.player_waittilljumpedfromc130 dontinterpolate();
  var0.player_waittilljumpedfromc130 thread scripts\cp_mp\killstreaks\airstrike::airstrike_playapproachfx(var7);
  var0.player_waittilljumpedfromc130 thread scripts\cp_mp\killstreaks\airstrike::airstrike_playflybyfx(var8);
  var0.player_waittilljumpedfromc130 thread scripts\cp_mp\killstreaks\airstrike::airstrike_playflyoutfx(var9);
  var0.player_waittilljumpedfromc130 thread scripts\cp_mp\killstreaks\airstrike::airstrike_handleflyoutfxdeath(var10);
  var0.player_waittilljumpedfromc130 thread scripts\cp_mp\killstreaks\airstrike::branalytics_selfrevive(var0);
}

function ref_12d9d(var0, var1) {
  var2 = sin(var1);
  var3 = cos(var1);
  var4 = var0[0] * var3 - var0[1] * var2;
  var5 = var0[0] * var2 + var0[1] * var3;
  return (var4, var5, var0[2]);
}

function fadeoutoverlay(var0) {
  var1 = int(level.ref_13737[var0.team][var0.squadindex].ref_13bee);

  foreach(var3 in level.squaddata[var0.team][var0.squadindex].players) {
    if(!isDefined(var3)) {
      continue;
    }

    var3 _calloutmarkerping_handleluinotify_added::ref_1313e("ui_br_x2_client_data", 0, 18, var1);
  }
}

function handlerocketkillsgiverockets(var0) {
  level endon("game_ended");
  self endon("death");

  if(!isDefined(var0)) {
    var0 = 5;
  }

  wait var0;

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

  foreach(var1 in level.players) {
    if(!isDefined(var1)) {
      continue;
    }

    var1 setsoundsubmix("br_x2_default_mix");
  }
}

function execution_debug() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("wztrain_anim_playing");
  wait 1;

  if(!isDefined(level.ref_145f1) || !isDefined(level.ref_145f1.ref_13c8d)) {
    return;
  }

  var0 = level.ref_145f1.ref_13c8d[0];

  for(var1 = 0; var1 < level.ref_145f1.ref_13c8d.size; var1++) {
    if(soundexists("veh_cargotrain_lp_" + var1)) {
      level.ref_145f1.ref_13c8d[var1].wz_tease playLoopSound("veh_cargotrain_lp_" + var1);
    }
  }

  var0 playLoopSound("veh_cargotrain_locomotive_dist_lp");

  foreach(var3 in level.players) {
    if(!isDefined(var3)) {
      continue;
    }

    var3 setsoundsubmix("br_x2_train_moving");
  }

  level waittill("buffTurrets");
  setglobalsoundcontext("x2_event", "turrets_buffed", 0.1);
  level waittill("x2SuperInterupt");
  var0 stoploopsound();

  for(var1 = 0; var1 < level.ref_145f1.ref_13c8d.size; var1++) {
    level.ref_145f1.ref_13c8d[var1].wz_tease stoploopsound();
  }
}

function eyeoffnotehandler() {
  level endon("game_ended");

  foreach(var1 in level.players) {
    if(!isDefined(var1)) {
      continue;
    }

    var1 clearsoundsubmix("br_x2_train_idle");
    var1 clearsoundsubmix("br_x2_train_moving");
    var1 clearsoundsubmix("br_x2_train_destroyed");
  }

  wait 6;

  foreach(var1 in level.players) {
    if(!isDefined(var1)) {
      continue;
    }

    var1 clearsoundsubmix("br_x2_outro_ending");
  }
}

function f11lights(var0) {
  level endon("game_ended");

  if(!isDefined(level.ref_145f1) || !isDefined(level.ref_145f1.ref_13c8d)) {
    return;
  }

  var1 = level.ref_145f1.ref_13c8d[0].wz_tease;
  var1 setscriptablepartstate("movement", "accel");
  thread f14_current_inputseq("br_x2_train_moving", 3, "br_x2_train_idle", 4, 0);
}

function f11onarmoryswitchon(var0, var1) {
  level endon("game_ended");

  if(!isDefined(level.ref_145f1) || !isDefined(level.ref_145f1.ref_13c8d)) {
    return;
  }

  var2 = level.ref_145f1.ref_13c8d[0].wz_tease;

  if(istrue(var1)) {
    var2 setscriptablepartstate("movement", "brake");
  } else {
    var2 setscriptablepartstate("movement", "brake_short");
  }

  thread f14_current_inputseq("br_x2_train_idle", var0, "br_x2_train_moving", 3, var0);
}

function f14_current_inputseq(var0, var1, var2, var3, var4) {
  level endon("game_ended");

  foreach(var6 in level.players) {
    if(!isDefined(var6)) {
      continue;
    }

    var6 setsoundsubmix(var0, var1);
  }

  wait var4;

  foreach(var6 in level.players) {
    if(!isDefined(var6)) {
      continue;
    }

    var6 clearsoundsubmix(var2, var3);
  }
}

function f14_current_inputamt(var0) {
  level endon("game_ended");

  if(!isDefined(level.ref_145f1) || !isDefined(level.ref_145f1.ref_13c8d)) {
    return;
  }

  wait var0;
  var1 = level.ref_145f1.ref_13c8d[0].wz_tease;
  var1 playsoundonmovingent("veh_horn_cargotrain_wake");
}

function f11scriptlighttoggle(var0) {
  level endon("game_ended");

  if(!isDefined(level.ref_145f1) || !isDefined(level.ref_145f1.ref_13c8d)) {
    return;
  }

  wait var0;
  var1 = level.ref_145f1.ref_13c8d[0].wz_tease;
  var1 playsoundonmovingent("veh_horn_cargotrain_buffed_weapon");
}

function exit_level(var0, var1) {
  if(!isDefined(var1)) {
    return;
  }

  if(var0 <= 1) {
    var1 playlocalsound("scn_x2_ac130_bomb_incoming_01", undefined, undefined, 1);
    return;
  }

  if(var0 == 2) {
    var1 playlocalsound("scn_x2_ac130_bomb_incoming_02", undefined, undefined, 1);
    return;
  }

  if(var0 == 3) {
    wait 0.2;
    var1 clearclienttriggeraudiozone(0);
    var1 playlocalsound("scn_x2_outro_part1_lr", undefined, undefined, 1);
    var1 clearallsoundsubmixes(0.1);
    var1 setsoundsubmix("br_x2_outro_ending");
    wait 5.6;
    var1 playlocalsound("scn_x2_outro_part2_lr", undefined, undefined, 1);
    return;
  }
}

function eyeonnotehandler(var0) {
  level endon("game_ended");

  for(var1 = 0; var1 < level.ref_145f1.ref_13c8d.size; var1++) {
    if(var1 > 0) {
      playFXOnTag(level._effect["vfx_br_x2_brake_sparks_car"], level.ref_145f1.ref_13c8d[var1].wz_tease, "tag_origin");
      continue;
    }

    playFXOnTag(level._effect["vfx_br_x2_brake_sparks_loco"], level.ref_145f1.ref_13c8d[var1].wz_tease, "tag_origin");
  }

  wait var0;

  for(var1 = 0; var1 < level.ref_145f1.ref_13c8d.size; var1++) {
    if(var1 > 0) {
      stopFXOnTag(level._effect["vfx_br_x2_brake_sparks_car"], level.ref_145f1.ref_13c8d[var1].wz_tease, "tag_origin");
      continue;
    }

    stopFXOnTag(level._effect["vfx_br_x2_brake_sparks_loco"], level.ref_145f1.ref_13c8d[var1].wz_tease, "tag_origin");
  }
}

function extractmissionhelipadscriptable(var0, var1) {
  if(scripts\engine\utility::flag_exist("no_crate_spawning") && scripts\engine\utility::flag("no_crate_spawning")) {
    return;
  }

  if(!isDefined(var0) || !isarray(var0)) {
    return;
  }

  extractcountdownmsg();

  foreach(var3 in var0) {
    var4 = spawnStruct();
    var4.origin = scripts\engine\utility::drop_to_ground(var3, 150, -1000);
    var4.clear_legacy_pickup_munitions = spawn("script_model", var4.origin);
    var4.clear_legacy_pickup_munitions setModel("ks_airdrop_crate_br");
    level.fnhidefoundintel = 8000;

    if(isDefined(var1)) {
      level.fnhidefoundintel = var1;
    }

    var5 = scripts\mp\gametypes\br_c130airdrop::fn_spec_op_post_customization(undefined, var3, 1);
    var6 = distance(var5.startpt, var5.endpt);
    var7 = scripts\mp\gametypes\br_c130::getc130speed() * 1.2;
    var8 = var6 / var7;
    var9 = scripts\mp\gametypes\br_c130airdrop::fntrapdeactivation(var5, var6, var7, var8);
    var9.mode_can_play_ending = &mode_can_play_ending;
    var9 scripts\mp\gametypes\br_c130airdrop::fob(1, "heavy_weapon_crate", "inactive", var4);
  }
}

function mode_can_play_ending(var0, var1, var2, var3) {
  level endon("no_crate_spawning");
  var4 = self.startpt;
  var5 = self.centerpt;
  var6 = self.speed;
  var7 = distance2d(var4, var5) / var6;
  var8 = 0;
  var9 = 0;
  wait var7;
  level notify("drop_resuply");
  var10 = var3.origin;
  var11 = scripts\cp_mp\killstreaks\airdrop::minshotstostage3acc(var10 + (0, 0, level.fnhidefoundintel - 100), var10, self.angles, var1, var2, var3.ref_11eab);
  var11 setscriptablepartstate("objective", "heavy_weapon_public");
  var11.ml_p2_func = var3;
  var11.ref_134e2 = self.ref_134e2;
  level.ref_1463d[level.ref_1463d.size] = var11;
}

function extractcountdownmsg() {
  enemyhasuavkill();

  foreach(var1 in level.ref_1463d) {
    level.ref_1463b[level.ref_1463b.size] = var1;
  }

  level.ref_1463d = [];
}

function enemyhasuavkill(var0) {
  if(!isDefined(level.ref_1463b) || level.ref_1463b.size <= 0) {
    level.ref_1463b = [];
    return;
  }

  if(!isDefined(var0)) {
    var0 = 0;
  }

  var1 = [];

  foreach(var3 in level.ref_1463b) {
    if(!isDefined(var3) || !isDefined(var3.origin)) {
      continue;
    }

    var4 = scripts\common\utility::playersinsphere(var3.origin, 5000);

    if(var0 || var4.size <= 0) {
      var3 thread scripts\cp_mp\killstreaks\airdrop::destroycrate(1);
      continue;
    }

    var1 = var3;
  }

  level.ref_1463b = var1;
}

function enemygunship_watchdebuglocation() {
  foreach(var1 in level.ref_1463d) {
    level.ref_1463b[level.ref_1463b.size] = var1;
  }

  level.ref_1463d = [];
  enemyhasuavkill(1);
}

function ref_11d03() {
  level endon("game_ended");

  for(;;) {
    foreach(var1 in level.players) {
      var1.heli_orbit_logic = scripts\mp\utility\player::getplayersinradius(var1.origin, 500, var1.team, var1);
    }

    wait 1;
  }
}

function ref_12171(var0) {
  if(!scripts\engine\utility::flag("wztrain_anim_playing")) {
    return false;
  }

  if(scripts\mp\flags::gameflag("x2_train_destroyed")) {
    return false;
  }

  if(!isalive(var0)) {
    return false;
  }

  if(var0 scripts\cp_mp\utility\player_utility::isinvehicle()) {
    return false;
  }

  if(var0 isskydiving() || var0 isparachuting()) {
    return false;
  }

  if(isDefined(var0.ref_1286f) && distance(var0.origin, var0.ref_1286f.origin) < 200) {
    return false;
  }

  var1 = getdvarint("scr_x2_overdrive_distance", 1500);
  var2 = 0;

  foreach(var4 in level.ref_145f1.ref_13c8d) {
    if(var4.wz_tease.get_remaining_bots <= 0) {
      continue;
    }

    var5 = distance2d(var4.origin, var0.origin);

    if(var5 < var1) {
      var2 = 1;
      break;
    }
  }

  if(var2) {
    if(!isDefined(var0.watch_for_players_approaching_tugofwar)) {
      return false;
    } else if(gettime() - var0.watch_for_players_approaching_tugofwar > 3000) {
      return false;
    }
  } else {
    var0.watch_for_players_approaching_tugofwar = gettime();
  }

  return true;
}

function ref_1260c() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("x2_ambush1_completed");

  for(;;) {
    foreach(var1 in level.players) {
      if(ref_12171(var1)) {
        if(!isDefined(var1.ref_1216f) || !istrue(var1.ref_1216f)) {
          var1.ref_1216f = 1;
          var1 allowsupersprint(1);
          ref_12543(var1);
          var1 setclientomnvar("ui_privateevent_timer_type", 4);
        }

        var1 setclientomnvar("ui_privateevent_timer", var1.watch_for_players_approaching_tugofwar + 3000);
        var1 refreshsprinttime();
        continue;
      }

      if(istrue(var1.ref_1216f)) {
        var1.ref_1216f = 0;
        var1 setclientomnvar("ui_privateevent_timer_type", 0);
        ref_1253d(var1);
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
  var0 = level.ref_145f1.ref_13c8d[0].wz_tease.lb_wood_surf_dmg_scalar;

  if(isDefined(var0) && var0 > 2) {
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

function exfilchopper(var0) {
  var0 waittill("spawned_player");
  var0 visionsetnakedforplayer(level.ref_142d1, 0);

  if(!isDefined(var0.ref_1463c)) {
    var0.ref_1463c = scripts\mp\utility\outline::outlineenableforall(var0, "outline_depth_x2", "lowest");
  }

  var0.heli_landing_volumes = [];
}

function ref_13251() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  thread ref_12c06();

  foreach(var1 in level.players) {
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

  foreach(var1 in level.players) {
    if(isDefined(var1.ref_1463c)) {
      scripts\mp\utility\outline::outlinedisable(var1.ref_1463c, var1);
      var1.ref_1463c = undefined;
    }
  }
}

function extra_bomb_explode_vfx_func(var0, var1, var2) {
  level endon("game_ended");
  var1 endon("disconnect");
  wait var2;
  var1 playsoundtoplayer(var0, var1);
}

function exit_laser_panel_anim_sequence() {
  scripts\mp\gametypes\br_movingtrain::ref_13cb4(0);
}

function existingkills() {
  scripts\mp\gametypes\br_movingtrain::ref_13cb4(1);
}

function extractlocale_checkiflocaleisavailable(var0) {
  var1 = 0;

  if(isDefined(level.ref_14640)) {
    foreach(var3 in level.ref_14640) {
      if(!isDefined(var3)) {
        continue;
      }

      if(var3.health > 0 && isDefined(var3.currenttarget) && var3.currenttarget == var0) {
        var1 |= var0 scripts\mp\perks\perkfunctions::roof_rpg_covers(var3);
      }
    }
  }

  return var1;
}

function exfill_chopper_dialogue(var0) {
  if(isPlayer(var0)) {
    return 0;
  }

  if(!isDefined(level.ref_145f1) || !isDefined(level.ref_145f1.ref_13c8d)) {
    return 0;
  }

  foreach(var2 in level.ref_145f1.ref_13c8d) {
    if(var2 == var0) {
      return level.ss_entergulag;
    }

    if(isDefined(var2.wz_tease.frontturret) && var2.wz_tease.frontturret == var0) {
      return level.ss_ontimerexpired;
    }

    if(isDefined(var2.wz_tease.rearturret) && var2.wz_tease.rearturret == var0) {
      return level.ss_ontimerexpired;
    }
  }

  return 0;
}

function exfil_sequence(var0) {
  if(getdvarint("scr_x2_logs_enable", 1)) {
    logstring("[X2] " + var0);
    return;
  }
}