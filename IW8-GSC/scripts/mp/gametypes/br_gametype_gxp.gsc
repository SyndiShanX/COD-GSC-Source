/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametype_gxp.gsc
****************************************************/

function init() {
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("gulag");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("match_start_VO");
  scripts\mp\gametypes\br_gametypes::move_molotov_mortar("ignoreGhostsLastStandWipe");
  scripts\mp\gametypes\br_gxp_fear::init();
  scripts\mp\gametypes\br_gxp_hallucination::init();
  scripts\mp\gametypes\br_gxp_safe_zones::init();
  scripts\mp\gametypes\br_gxp_phones::init();
  scripts\mp\gametypes\br_gametypes::ref_12b11("onPlayerConnect", &onplayerconnect);
  scripts\mp\gametypes\br_gametypes::ref_12b11("onPlayerDamaged", &onplayerdamaged);
  scripts\mp\gametypes\br_gametypes::ref_12b11("onPlayerArmorDamaged", &ref_12063);
  scripts\mp\gametypes\br_gametypes::ref_12b11("onVehicleDamaged", &ref_120ab);
  scripts\mp\gametypes\br_gametypes::ref_12b11("onLastStandEnter", &ref_1204c);
  scripts\mp\gametypes\br_gametypes::ref_12b11("onLastStandRevive", &ref_12050);
  scripts\mp\gametypes\br_gametypes::ref_12b11("onPlayerKilled", &onplayerkilled);
  scripts\mp\gametypes\br_gametypes::ref_12b11("onArmorPlate", &ref_11fff);
  scripts\mp\gametypes\br_gametypes::ref_12b11("onContractEnd", &ref_12009);
  scripts\mp\gametypes\br_gametypes::ref_12b11("onKillstreakDanger", &ref_12049);
  scripts\mp\gametypes\br_gametypes::ref_12b11("lootCacheOpened", &ref_1205d);
  scripts\mp\gametypes\br_gametypes::ref_12b11("playerSkipLootPickup", &scripts\mp\gametypes\br_gametype_gxp_ghost::ref_1269c);
  scripts\mp\gametypes\br_gametypes::ref_12b11("playerSkipKioskUse", &scripts\mp\gametypes\br_gametype_gxp_ghost::ref_1269b);
  scripts\mp\gametypes\br_gametypes::ref_12b11("markPlayerAsEliminatedOnKilled", &scripts\mp\gametypes\br_gametype_gxp_ghost::ref_11b16);
  scripts\mp\gametypes\br_gametypes::ref_12b11("addToTeamLives", &scripts\mp\gametypes\br_gametype_gxp_ghost::addtoteamlives);
  scripts\mp\gametypes\br_gametypes::ref_12b11("removeFromTeamLives", &scripts\mp\gametypes\br_gametype_gxp_ghost::removefromteamlives);
  scripts\mp\gametypes\br_gametypes::ref_12b11("allowMeleeVehicleDamage", &brking_cleanupents);
  scripts\mp\gametypes\br_gametypes::ref_12b11("playerNakedDropLoadout", &scripts\mp\gametypes\br_gametype_gxp_ghost::ref_12604);
  scripts\mp\gametypes\br_gametypes::ref_12b11("dropOnPlayerDeath", &scripts\mp\gametypes\br_gametype_gxp_ghost::droponplayerdeath);
  scripts\mp\gametypes\br_gametypes::ref_12b11("shouldLastStandDamageScale", &ref_13308);
  scripts\mp\gametypes\br_gametypes::ref_12b11("dangerCircleTickActual", &dangercircletick);
  scripts\mp\gametypes\br_gametypes::ref_12b11("exfilStart", &onnewequipmentpickup);
  scripts\mp\gametypes\br_gametypes::ref_12b11("onLeaveAC130", &ref_12051);
  scripts\mp\gametypes\br_gametypes::ref_12b11("remainingPlayersAliveOnTeam", &scripts\mp\gametypes\br_gametype_gxp_ghost::ref_12bba);
  scripts\mp\gametypes\br_gametypes::ref_12b11("spawnHandled", &scripts\mp\gametypes\br_gametype_gxp_ghost::ref_1365d);
  scripts\mp\gametypes\br_gametypes::ref_12b11("mayConsiderPlayerDead", &scripts\mp\gametypes\br_gametype_gxp_ghost::ref_11b80);
  scripts\mp\gametypes\br_gametypes::ref_12b11("modifyPlayerDamage", &scripts\mp\gametypes\br_gametype_gxp_ghost::modifyplayerdamage);
  scripts\mp\gametypes\br_gametypes::ref_12b11("modifyVehicleDamage", &ref_11ca1);
  scripts\mp\gametypes\br_gametypes::ref_12b11("postUpdateGameEvents", &scripts\mp\gametypes\br_gametype_gxp_ghost::ref_12810);
  scripts\mp\gametypes\br_gametypes::ref_12b11("lastStandAllowed", &scripts\mp\gametypes\br_gametype_gxp_ghost::watch_flight_collision);
  level.disable_super_in_turret.ref_133d0 = 1;
  level.disable_super_in_turret.sat_wait_for_piece_added = 0;
  level.disable_super_in_turret.ref_11b76 = getdvarint("scr_br_gxp_maxTagsVisible", 12);
  level.disable_super_in_turret.ref_11b74 = getdvarfloat("scr_br_gxp_maxRadius", 0);
  level.disable_super_in_turret.ref_11b75 = level.disable_super_in_turret.ref_11b74 * level.disable_super_in_turret.ref_11b74;
  level.disable_super_in_turret.ref_13a25 = getdvarint("scr_br_gxp_autoPickup", 1);
  level.disable_super_in_turret.spawndomplates = getdvarint("scr_br_gxp_human_powers", 0);
  level.disable_super_in_turret.sat_signal_lost_nag = getdvarint("scr_br_gxp_ghost_drop_tags", 0);
  level.disable_super_in_turret.sat_signal_shift = getdvarint("scr_br_gxp_ghost_drop_tags_chance", 100);
  level.disable_super_in_turret.ref_11b5b = getdvarint("scr_br_gxp_max_tags", 100);
  level.disable_super_in_turret.spawndomplateflagtestmap = getdvarint("scr_br_gxp_human_loadout_restore", 1);
  level.disable_super_in_turret.ref_12cb0 = [];
  level.disable_super_in_turret.ref_12cb1 = [];
  level.disable_super_in_turret.brlootchoppercratecapturecallback = 1;
  level.disable_super_in_turret.scale_off_bravo_audio = 1;
  level.disable_super_in_turret.sat_wait_for_transmission_start = scripts\mp\gametypes\br_gametype_gxp_ghost::init_relic_nuketimer();
  level.disable_super_in_turret.sat_wait_for_activated_think = getdvarint("scr_br_gxp_health", 300);
  level.disable_super_in_turret.sceneangles = getdvarfloat("scr_br_gxp_ghostBulletDamageScale", 0.75);
  level.disable_super_in_turret.school_guards_wake_behavior = getdvarfloat("scr_br_gxp_ghostMeleeDamageScale", 0.5);
  level.disable_super_in_turret.school_guards_rpg_guys = getdvarfloat("scr_br_gxp_ghostfireDamageScale", 1);
  level.disable_super_in_turret.school_guards_behavior = getdvarint("scr_br_gxp_ghostsDamageGhosts", 0);
  level.disable_super_in_turret.school_guards_behavior_internal = getdvarint("scr_br_gxp_ghostsDamageGhostsDamage", 80);
  level.disable_super_in_turret.school_guards_rpg_shoot_into_windows = getdvarint("scr_br_gxp_ghostsIgnoreVehicleExplosions", 0);
  level.disable_super_in_turret.brkickedfromplane = getdvarint("scr_br_gxp_allow_ghost_uav", 1);
  level.disable_super_in_turret.saw_4_angles = getdvarfloat("scr_br_gxp_ping_rate", -1);
  level.disable_super_in_turret.saw_4_origin = getdvarfloat("scr_br_gxp_ping_time", 0.5);
  level.disable_super_in_turret.saw_3_origin = getdvarint("scr_br_gxp_num_consume", 3);
  level.disable_super_in_turret.scalesitesbyteams = getdvarint("scr_br_gxp_ghost_respawn_on_execute", 1);
  level.disable_super_in_turret.scavenger_cache_hint = getdvarint("scr_br_gxp_ghost_respawn_on_laststand_execute", 0);
  level.disable_super_in_turret.saw_remove_icon = getdvarfloat("scr_br_gxp_regen_rate_scale_in_gas", 1);
  level.disable_super_in_turret.saw_watch_for_stop_interaction = getdvarfloat("scr_br_gxp_regen_rate_scale_out_gas", 0.5);
  level.disable_super_in_turret.saw_origin = getdvarfloat("scr_br_gxp_regen_delay_scale_in_gas", 1);
  level.disable_super_in_turret.saw_pickup_think = getdvarfloat("scr_br_gxp_regen_delay_scale_out_gas", 1.5);
  level.disable_super_in_turret.saw_head_icon = getdvarint("scr_br_gxp_powers", 1);
  level.disable_super_in_turret.ref_12820 = getdvarint("scr_br_gxp_powers_cooldown", 1);
  level.disable_super_in_turret.saveweaponstates = getdvarfloat("scr_br_gxp_numHits", 4);
  level.disable_super_in_turret.saw_2_origin = getdvarfloat("scr_br_gxp_numHitsLastStand", 4);
  level.disable_super_in_turret.saw_2_angles = getdvarfloat("scr_br_gxp_numHitsJugg", 20);
  level.disable_super_in_turret.sat_wait_for_antenna = getdvarint("scr_br_gxp_ignoreArmor", 1);
  level.disable_super_in_turret.scalertoscaleinfo = getdvarint("scr_br_gxp_respawn_shutdown_jugg", 1);
  level.disable_super_in_turret.saveendgamelocals = getdvarfloat("scr_br_gxp_numHitsHeli", 2);
  level.disable_super_in_turret.savedangles = getdvarfloat("scr_br_gxp_numHitsAtv", 2);
  level.disable_super_in_turret.savedexecutionref = getdvarfloat("scr_br_gxp_numHitsCar", 3);
  level.disable_super_in_turret.saw_3_angles = getdvarfloat("scr_br_gxp_numHitsTruck", 4);
  level.disable_super_in_turret.scn_infil_hackney_heli_npc4 = getdvarint("scr_br_gxp_spawn_air", 1);
  level.disable_super_in_turret.scn_infil_tango_npc_5_sfx = getdvarint("scr_br_gxp_vehicle_laststand", 0);
  level.disable_super_in_turret.scn_infil_hackney_heli_npc3 = getdvarint("scr_br_gxp_ghost_spawn_above", 0);
  level.disable_super_in_turret.spawndragonsbreathstruct = getdvarint("scr_br_gxp_human_spawn_air", 1);
  level.disable_super_in_turret.fluctuatevalues = getdvarint("scr_br_gxp_buyback_human", 1);
  level.disable_super_in_turret.vehicle_occupancy_friendlystatuschangedcallback = getdvarint("scr_br_gxp_jugg_num_players", 3);
  level.disable_super_in_turret.vehicle_occupancy_getreserving = getdvarint("scr_br_gxp_jugg_health_icon", 0);
  level.disable_super_in_turret.spawndistancemax = getdvarint("scr_br_gxp_server_hud", 0);
  level.disable_super_in_turret.vehicle_occupancy_monitorturretcontrols = getdvarint("scr_br_gxp_jump_trace_up1_offset", 20);
  level.disable_super_in_turret.vehicle_occupancy_mp_changedseats = getdvarint("scr_br_gxp_jump_trace_up2_offset", 30);
  level.disable_super_in_turret.score_accuracy_think = getdvarint("scr_br_gxp_ghost_vision", 1);
  level.disable_super_in_turret.score_event_accuracy = getdvarint("scr_br_gxp_ghost_vision_overlay", 1);
  level.disable_super_in_turret.ref_14061 = getdvarint("scr_br_gxp_use_armor_headshot_scale", 0);
  level.disable_super_in_turret.sat_wait_for_access_card = getdvarfloat("scr_br_gxp_ghost_headshot_scalar", 0.65);
  level.disable_super_in_turret.scn_infil_tango_npc_4_sfx = getdvarint("scr_br_gxp_ghost_vehicle_impact_teleport", 1);
  level.disable_super_in_turret.scn_infil_tango_npc_3_sfx = getdvarfloat("scr_br_gxp_ghost_vehicle_damage_scalar", 8);
  level.disable_super_in_turret.scavengerlootcacheused = getdvarint("scr_br_gxp_ghost_safe_zone_teleport", 1);
  level.disable_super_in_turret.ref_12e6b = getdvarint("scr_br_safe_zones_enabled", 1);
  level.disable_super_in_turret.ref_12e6c = getdvarint("scr_br_gxp_safezone_fear_decrement", 2);
  level.disable_super_in_turret.ref_12e72 = getdvarint("scr_br_gxp_safezone_hallucinations", 1);
  level.disable_super_in_turret.ref_12e73 = getdvarint("scr_br_gxp_safezone_health", 2500);
  level.disable_super_in_turret.ref_12e74 = getdvarfloat("scr_br_gxp_safezone_health_orange_percentage", 0.3);
  level.disable_super_in_turret.ref_12e75 = getdvarfloat("scr_br_gxp_safezone_health_yellow_percentage", 0.6);
  level.disable_super_in_turret.ref_12e70 = getdvarint("scr_br_gxp_safezone_ghost_teleport_damage", 100);
  level.disable_super_in_turret.ref_12e6f = getdvarfloat("scr_br_gxp_safezone_ghost_damage_cooldown", 0.5);
  level.disable_super_in_turret.ref_12e6e = getdvarfloat("scr_br_gxp_safezone_ghost_damage", 20);
  level.disable_super_in_turret.ref_12e69 = getdvarint("scr_br_gxp_safezone_circle_destory", 1);
  level.disable_super_in_turret.ref_12e6a = getdvarint("scr_br_gxp_safezone_ghost_teleport_damage", 0);
  level.disable_super_in_turret.ref_12e68 = getdvarint("scr_br_gxp_safezone_backup_teleport_attempts", 6);
  level.disable_super_in_turret.scn_infil_hackney_heli_npc1 = getdvarint("scr_br_gxp_ghost_soul_circle_destory", 0);
  level.disable_super_in_turret.scn_infil_hackney_heli_npc2 = getdvarint("scr_br_gxp_ghost_soul_ghost_teleport_damage", 1000);
  level.disable_super_in_turret.sat_wait_for_signal_transfer = getDvar("scr_br_ghost_killed_loot_items", "brloot_ammo_12g,brloot_ammo_50cal,brloot_ammo_762,brloot_ammo_919");
  level.disable_super_in_turret.sat_wait_for_power = getdvarint("scr_br_ghost_killed_loot_item_drop_chance", 0);
  level.disable_super_in_turret.sat_wait_for_power_think = getdvarint("scr_br_ghost_killed_loot_item_drop_max_count", 2);
  level.disable_super_in_turret.sat_sound_think = getdvarint("scr_br_ghost_enable_execution", 1);
  level.disable_super_in_turret.sat_setup_access_cards = getdvarint("scr_br_ghost_disable_player_corpses", 0);
  level.disable_super_in_turret.sat_wait_for_radar = strtok(level.disable_super_in_turret.sat_wait_for_signal_transfer, ",");
  level.disable_super_in_turret.vehicle_occupancy_getplayerfriendlyto = 0;
  level.ref_13364 = 1;
  game["dialog"]["zmb_player_into_zombie"] = "zombie_player_into_zombie";
  game["dialog"]["zmb_teammate_into_zombie"] = "zombie_teammate_into_zombie";
  game["dialog"]["zmb_need_someone_alive"] = "zombie_near_end";
  game["dialog"]["zmb_teammate_back_human"] = "zombie_teammate_back_human";
  level._effect["ghost_soul_pickup"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_ghost_soul_pickup.vfx");
  level._effect["ghost_trans"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_ghost_transition_to_human_3p.vfx");
  level._effect["zombie_splat"] = loadfx("vfx/iw8_br/gameplay/zombie/vfx_zmb_freefall_splat.vfx");
  level.disable_super_in_turret.ref_136e3 = loadfx("vfx/iw8_br/gameplay/hween2/vfx_ghost_blast_ability_3p.vfx");
  level.disable_super_in_turret.ref_136e2 = loadfx("vfx/iw8_br/gameplay/hween2/vfx_ghost_blast_ability_1p.vfx");
  level.disable_super_in_turret.ref_136e4 = loadfx("vfx/iw8_br/gameplay/hween2/vfx_ghost_blast_ability_victim.vfx");
  level.disable_super_in_turret.start_coop_defuse_infiltrate = loadfx("vfx/iw8_br/gameplay/zombie/vfx_zmb_human_push_blast");
  level.disable_super_in_turret.ref_13aea = loadfx("vfx/iw8_br/gameplay/hween2/vfx_gxp_teleport_3p.vfx");
  level.disable_super_in_turret.ref_13ae9 = loadfx("vfx/iw8_br/gameplay/hween2/vfx_gxp_teleport_1p.vfx");
  level.disable_super_in_turret.sat_setup_access_card_pickup = loadfx("vfx/iw8_br/gameplay/hween2/vfx_ghost_death_3p");
  level.disable_super_in_turret.scn_infil_tango_npc_1_sfx = loadfx("vfx/iw8_br/gameplay/hween2/vfx_ghost_transition_to_human_1p");
  level.disable_super_in_turret.scn_infil_hackney_heli_npc6 = loadfx("vfx/iw8_br/gameplay/hween2/vfx_gxp_ghost_landing.vfx");
  thread delay_activate_damage_trigger();
  thread teamswithcirclepeek();
  thread toggleusbstickinhand();
  thread directimpactkill();
}

function toggleusbstickinhand() {
  waittillframeend();

  if(level.disable_super_in_turret.vehicle_occupancy_friendlystatuschangedcallback > 0 && level.disable_super_in_turret.vehicle_occupancy_getreserving) {
    level.vehicle_occupancy_forceweaponswitchallowed = undefined;
  }

  thread scripts\mp\gametypes\br_gametype_gxp_ghost::ref_13247();
  thread scripts\mp\gametypes\br_gametype_gxp_ghost::setchecklistsubversion();
}

function teamswithcirclepeek() {
  while(!isDefined(level.onplayerspawncallbacks)) {
    waitframe();
  }

  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&onplayerspawned);
}

function directimpactkill() {
  level waittill("br_dialog_initialized");
  scripts\mp\gametypes\br_public::endgamevo("prematch_enter", "dx_bra_gfac_gamestate_prematch_enter");
  scripts\mp\gametypes\br_public::endgamevo("prematch_end", "dx_bra_gfac_gamestate_prematch_end");
  scripts\mp\gametypes\br_public::endgamevo("first_circle", "dx_bra_gfac_gamestate_circle_first");
  scripts\mp\gametypes\br_public::endgamevo("new_circle", "dx_bra_gfac_gamestate_circle_new");
  scripts\mp\gametypes\br_public::endgamevo("circle_closing", "dx_bra_gfac_gamestate_circle_red_close");
  scripts\mp\gametypes\br_public::endgamevo("final_circle", "dx_bra_gfac_gamestate_circle_red_final");
  scripts\mp\gametypes\br_public::endgamevo("last_man_standing", "dx_bra_gfac_gamestate_last_man_standing");
  scripts\mp\gametypes\br_public::endgamevo("team_loss", "dx_bra_gfac_gamestate_lose");
  scripts\mp\gametypes\br_public::endgamevo("team_victory", "dx_bra_gfac_gamestate_win");
  scripts\mp\gametypes\br_public::endgamevo("player_into_ghost_first", "dx_bra_gfac_ghost_powers");
  scripts\mp\gametypes\br_public::endgamevo("player_into_ghost", "dx_bra_gfac_ghost_player_ghost");
  scripts\mp\gametypes\br_public::endgamevo("player_into_human", "dx_bra_gfac_ghost_player_human");
  scripts\mp\gametypes\br_public::endgamevo("teammate_into_ghost", "dx_bra_gfac_ghost_teammate_ghost");
  scripts\mp\gametypes\br_public::endgamevo("teammate_back_human", "dx_bra_gfac_ghost_teammate_human");
  scripts\mp\gametypes\br_public::endgamevo("safe_zone_human_vo", "dx_bra_gfac_safe_space_safety_taunt");
  scripts\mp\gametypes\br_public::endgamevo("safe_zone_ghost_vo", "dx_bra_gfac_ghost_safe_denied");
}

function onplayerconnect(var0) {
  scripts\mp\gametypes\br_gxp_fear::onplayerconnect(var0);
  scripts\mp\gametypes\br_gxp_hallucination::onplayerconnect(var0);
}

function onplayerspawned(var0) {
  scripts\mp\gametypes\br_gxp_fear::onplayerspawned();
  scripts\mp\gametypes\br_gxp_hallucination::onplayerspawned();

  if(level.disable_super_in_turret.sat_setup_access_cards) {
    self.ref_133c8 = 1;
    return;
  }
}

function onplayerdamaged(var0) {
  if(isDefined(var0.victim) && isDefined(level.disable_super_in_turret.setquestindexteamomnvar) && isDefined(var0.attacker) && level.disable_super_in_turret.setquestindexteamomnvar == var0.attacker) {
    var0.victim.health += var0.damage;
    return;
  }

  scripts\mp\gametypes\br_gxp_fear::placementupdatewait("onPlayerDamaged", var0);
}

function ref_12063(var0) {
  scripts\mp\gametypes\br_gxp_fear::placementupdatewait("onPlayerArmorDamaged", var0);
}

function onplayerkilled(var0) {
  scripts\mp\gametypes\br_gametype_gxp_challenges::ref_11ff1(var0);
  scripts\mp\gametypes\br_gametype_gxp_ghost::onplayerkilled(var0);
  var1 = var0.victim;
  var2 = var0.attacker;

  if(isDefined(var1)) {
    var3 = scripts\mp\gametypes\br_public::rotationrefsbyseatandweapon(var1.team, var1.squadindex);

    foreach(var5 in var3) {
      var5 scripts\mp\gametypes\br_gxp_fear::placementupdatewait("onTeammateKilled", var0);
    }
  }

  if(isDefined(var2) && isPlayer(var2)) {
    var2 scripts\mp\gametypes\br_gxp_fear::placementupdatewait("onPlayerKilled", var0);
  }

  var7 = scripts\mp\utility\player::getplayersinradius(var1.origin, 1000);

  foreach(var5 in var7) {
    if(var5.team == var1.team && var5.squadindex == var1.squadindex) {
      continue;
    }

    if(isDefined(var5.squadindex) && isDefined(var2) && isDefined(var2.team) && isDefined(var2.squadindex) && var5.team == var2.team && var5.squadindex == var2.squadindex) {
      continue;
    }

    var5 scripts\mp\gametypes\br_gxp_fear::placementupdatewait("onPlayerDied", var0);
  }

  if(!getdvarint("scr_br_gxp_disable_hallucination_corpse_vfx", 0)) {
    level thread scripts\mp\gametypes\br_gxp_hallucination::setreduceregendelayonkill(var1);
    return;
  }
}

function ref_120ab(var0) {
  scripts\mp\gametypes\br_gxp_fear::placementupdatewait("onVehicleDamaged", var0);
}

function ref_1204c() {
  var0 = scripts\mp\gametypes\br_public::rotationrefsbyseatandweapon(self.team, self.squadindex);

  foreach(var2 in var0) {
    var2 scripts\mp\gametypes\br_gxp_fear::placementupdatewait("onLastStandEnter", self);
  }
}

function ref_12050(var0) {
  if(isDefined(var0) && var0 != self) {
    var0 scripts\mp\gametypes\br_gxp_fear::placementupdatewait("onLastStandRevive", self);
    return;
  }
}

function ref_11fff(var0) {
  scripts\mp\gametypes\br_gxp_fear::placementupdatewait("onArmorPlate", var0);
}

function ref_12009(var0) {
  scripts\mp\gametypes\br_gxp_fear::placementupdatewait("onContractEnd", var0);
}

function ref_12049(var0) {
  scripts\mp\gametypes\br_gxp_fear::placementupdatewait("onKillstreakDanger", var0);
}

function ref_12051() {
  scripts\mp\gametypes\br_gxp_fear::lethal_crate_spawn();
}

function ref_1205d(var0) {
  scripts\mp\gametypes\br_gxp_fear::placementupdatewait("onOpenLootBox");
}

function ref_13308(var0) {
  if(isPlayer(var0.attacker) && var0.attacker scripts\mp\gametypes\br_public::ref_125ec() && var0.meansofdeath == "MOD_MELEE") {
    return false;
  }

  return true;
}

function delay_activate_damage_trigger() {
  wait 5;
  scripts\mp\utility\sound::besttime("br_event_ghosts_sfx");
}

function brking_cleanupents(var0) {
  var1 = isPlayer(var0.attacker) && var0.attacker scripts\mp\gametypes\br_public::ref_125ec();
  return var1;
}

function ref_11ca1(var0) {
  var1 = var0.damage;
  var2 = isPlayer(var0.attacker) && var0.attacker scripts\mp\gametypes\br_public::ref_125ec();

  if(var2) {
    return (var1 * level.disable_super_in_turret.scn_infil_tango_npc_3_sfx);
  }

  return var1;
}

function onnewequipmentpickup(var0) {
  foreach(var2 in level.players) {
    var2 hudoutlinedisable();
    var2 visionsetnakedforplayer("", 0);
  }
}

function dangercircletick(var0, var1) {
  scripts\mp\gametypes\br_gametype_gxp_ghost::dangercircletick(var0, var1);
  scripts\mp\gametypes\br_gxp_safe_zones::dangercircletick(var0, var1);
}