/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametype_lep.gsc
****************************************************/

#using_animtree("");

function doteamextractedupdate() {
  level.scr_animtree["planeWaves"] = #animtree;
  level.scr_anim["planeWaves"]["bomber_planes"] = $veh_wz_usa_bomber_boscar17_cloud;
  level.scr_animname["planeWaves"]["bomber_planes"] = "veh_wz_usa_bomber_boscar17_cloud";
  level.scr_animtree["outroFirstSet"] = #animtree;
  level.scr_anim["outroFirstSet"]["beauty_shot"] = % veh_wz_usa_bomber_b17_ending01;
  level.scr_animname["outroFirstSet"]["beauty_shot"] = "veh_wz_usa_bomber_b17_ending01";
  level.scr_animtree["outroSecondSet"] = #animtree;
  level.scr_anim["outroSecondSet"]["beauty_shot"] = % veh_wz_usa_bomber_b17_ending02;
  level.scr_animname["outroSecondSet"]["beauty_shot"] = "veh_wz_usa_bomber_b17_ending02";
}

function drone_death_cleanup() {
  level._effect["vfx_br_lep_ground_exp"] = loadfx("vfx/iw8_br/gameplay/event/vfx_br_lep_ground_exp.vfx");
}

function init() {
  thread downedwithbombweapon();
  thread dragonsbreathdamage();
  thread dovoforleaderinterrogated();
  thread downed_reviver_watch_for_return_to_usability();
  level thread scripts\mp\gametypes\br_gametype_rebirth::enabledskiplaststand();
  thread doteamextractedupdate();
  level.ref_13BD1 = &helidrivabledeathall;
}

function downedwithbombweapon() {
  level endon("game_ended");

  if(getdvarint("scr_br_lep_debug", 0) == 1) {
    scripts\mp\gametypes\br_gametypes::move_molotov_mortar("allowLateJoiners");
    return;
  }
}

function dragonsbreathdamage() {
  level endon("game_ended");
  drone_death_cleanup();
  level thread scripts\mp\utility\sound::besttime("br_event_lep_sfx");
  double_agent();
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("gulag");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("drogBagLoadout");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("dropBagLoop");
  scripts\mp\gametypes\br_gametypes::ref_12B11("onPlayerConnect", &drop_new_carepackage);
  scripts\mp\gametypes\br_gametypes::ref_12B11("onInfilSequenceEnd", &dorpgambushvo);
  scripts\mp\gametypes\br_gametypes::ref_12B11("mapCenterFinalCircle", &drop_platform);
  scripts\mp\gametypes\br_gametypes::ref_12B11("getFinalCircleCenter", &drop_platform);
  scripts\mp\gametypes\br_gametypes::ref_12B11("preCalcSafeCircleCenters", &dropaccesscard);
  scripts\mp\gametypes\br_gametypes::ref_12B11("playerWelcomeSplashes", &drop_support_crate_intro);
  scripts\mp\gametypes\br_gametypes::ref_12B11("onContractEnd", &drop_max);
  scripts\mp\gametypes\br_gametypes::ref_12B11("playerKilledSpawn", &drop_support_crates);
  scripts\mp\gametypes\br_gametypes::ref_12B11("onLastStandEnter", &drop_minigun);
  waittillframeend();
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "dangerNotifyPlayersInRange", &doarmsracelocationnags);
  doapcdamagevo();
  level.delete_players_black_screen = &drop_weapon_scripted;
  level.disable_back_light = 1;
  downangles();
  level.ref_140D9 = [];
  level.ref_123AB = spawnStruct();
  level.ref_123AB.player_fov_default_1 = [];
  level.ref_123AB.audio_player_spawn_mud_loop = [];
  level.ref_123AB.audio_player_start_mud_loop = [];
  level.ref_123AB.ref_11B1B = [];

  switch (level.mapname) {
    case "mp_br_mechanics":
      download_progress();
      thread dropped_weapon();
      break;
    case "mp_don4":
      level.ref_123AB.ref_12F8B = [];
      level.ref_123AB.ref_13B2E = [];
      thread dropped_weapon_cleanup();
      break;
  }

  thread dragonsbreathhitloccollection();
  downed_player();
  downtown_helicopter_start();
  dotmtylgroup();

  if(!isDefined(level.ctgs_comparestats)) {
    level.ctgs_comparestats = spawnStruct();
  }

  thread dropcircle();
  thread drop_in_progress();
  thread drones_spawning();
  thread doteamcirclebattlechatter();
  scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(&drop_locations);
}

function dragonsbreathhitloccollection() {
  level endon("game_ended");
  dropbrkillstreak("mp_don4_lep_start", undefined, 1);
}

function double_agent() {
  level.weapon_should_not_get_ammo = [(-20473, -5682, -738), (134, 18667, -792), (35557, 24084, -198)];
  level.weapon_pick_up_monitor = [[(-22749, -7178, -678), (-18213, -4752, -678)], [(-1047, 21103, -733), (1082, 16414, -733)], [(37656, 24942, -140), (33145, 22862, -140)]];
  level.weapon_buy_point_watch_death = [];

  foreach(var_1 in level.weapon_should_not_get_ammo) {
    var_2 = 1;
    var_3 = var_1;

    foreach(var_5 in level.weapon_pick_up_monitor[var_7]) {
      var_2++;
      var_3 += var_5;
    }

    var_3 /= var_2;
    level.weapon_class[var_7] = var_3;
  }

  var_8 = scripts\engine\utility::array_randomize([0, 1, 2]);
  level.weapon_xp_iw8_ar_kilo433 = var_8[0];
  level.weapon_xp_iw8_ar_golf36 = level.weapon_should_not_get_ammo[level.weapon_xp_iw8_ar_kilo433];

  if(var_8[0] != 1 && var_8[1] != 1) {
    GscBinSkip0(0x2e, 2, var_8[1]);
  }

  level.weapon_box_cache_use = var_8;
}

function doapcdamagevo() {
  scripts\cp_mp\utility\game_utility::ref_12C10("delete_on_load", "targetname");
}

function dovoforleaderinterrogated() {
  level endon("game_ended");
  level waittill("br_dialog_initialized");
  game["dialog"]["exfil_enemy_50"] = "powergrab_enemy_50";
  game["dialog"]["exfil_enemy_start"] = "powergrab_enemy_capture";
  game["dialog"]["exfil_enemy_win"] = "powergrab_enemy_success";
  game["dialog"]["exfil_ready"] = "exfil_start";
  game["dialog"]["exfil_friendly_50"] = "powergrab_friendly_50";
  game["dialog"]["exfil_friendly_start"] = "powergrab_friendly_capture";
  game["dialog"]["exfil_friendly_win"] = "powergrab_friendly_success";
  game["dialog"]["exfil_contested"] = "powergrab_zone_contest";
  game["dialog"]["match_start"] = "gametype_lep";
  game["dialog"]["mode_desc1"] = "gametype_desc_lep";
  game["dialog"]["mode_desc2"] = "infil_desc";
  game["dialog"]["lep_chall_success"] = "challenge_success";
  game["dialog"]["lep_bomb_shelter"] = "bomb_shelter";
  game["dialog"]["lep_bomb_incoming"] = "bomb_incoming";
  game["dialog"]["lep_air_defences"] = "air_defences";
}

function downed_reviver_watch_for_return_to_usability() {
  level endon("game_ended");
}

function download_progress() {
  var_0 = "mp/br_lep_dis_locations.csv";
  var_1 = int(tablelookuprownum(var_0, 0, "1"));

  if(tablelookupbyrow(var_0, var_1, 0) == "1") {
    var_2 = [];
    GscBinSkip0(0x2e, 0, (int(tablelookupbyrow(var_0, var_1, 1)), int(tablelookupbyrow(var_0, var_1, 2)), int(tablelookupbyrow(var_0, var_1, 3))));
  }

  level.weapon_xp_iw8_ar_golf36 = (-265, -4121, 58);
}

function downtown_gw_ambient_sound_load() {
  var_0 = "mp/br_lep_dis_locations.csv";
  var_1 = level.br_level.default_class_chosen[3];
  var_2 = level.br_level.br_circleradii[3];
  var_3 = 0;

  if(tablelookupbyrow(var_0, var_3, 0) == "0") {
    var_4 = [];
    GscBinSkip0(0x2e, 0, (int(tablelookupbyrow(var_0, var_3, 1)), int(tablelookupbyrow(var_0, var_3, 2)), int(tablelookupbyrow(var_0, var_3, 3))));
  }

  var_3 = int(tablelookuprownum(var_0, 0, "2"));

  if(tablelookupbyrow(var_0, var_3, 0) == "2") {
    var_4 = [];
    GscBinSkip0(0x2e, 0, (int(tablelookupbyrow(var_0, var_3, 1)), int(tablelookupbyrow(var_0, var_3, 2)), int(tablelookupbyrow(var_0, var_3, 3))));
  }

  for(var_3 = 0; tablelookupbyrow(var_0, var_3, 7) != ""; var_3++) {
    do_cache_2_prep(int(tablelookupbyrow(var_0, var_3, 7)), int(tablelookupbyrow(var_0, var_3, 8)));
  }
}

function downed_player() {
  dropbrlootchoppercrate("waypoint_captureneutral", "neutral", "MP_BR_INGAME/DOM_CAPTURE", 0);
  dropbrlootchoppercrate("waypoint_capture", "enemy", "MP_BR_INGAME/DOM_CAPTURE", 0);
  dropbrlootchoppercrate("waypoint_defend", "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", 0);
  dropbrlootchoppercrate("waypoint_defending", "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", 0);
  dropbrlootchoppercrate("waypoint_contested", "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", 1);
  dropbrlootchoppercrate("waypoint_taking", "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", 1);
  dropbrlootchoppercrate("waypoint_losing", "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", 1);
  scripts\mp\gametypes\br_dom_quest::ref_13239();
}

function dropbrlootchoppercrate(var_0, var_1, var_2, var_3) {
  level.waypointcolors[var_0] = var_1;
  level.waypointbgtype[var_0] = 1;
  level.waypointstring[var_0] = var_2;
  level.waypointshader[var_0] = "ui_mp_br_mapmenu_icon_gulag_overtime_objective";
  level.waypointpulses[var_0] = var_3;
}

function downtown_helicopter_start() {
  var_0 = [["brloot_killstreak_assaultdrone", 1], ["brloot_offhand_decoy", 1], ["brloot_offhand_frag", 1], ["brloot_offhand_semtex", 1], ["brloot_offhand_snapshot", 1], ["brloot_killstreak_recondrone", 1], ["brloot_super_deadsilence", 1]];
  var_1 = 0;
  level.weapon_xp_iw8_ar_sierra552 = spawnStruct();
  level.weapon_xp_iw8_ar_sierra552.itemlist = [];

  foreach(var_3 in var_0) {
    var_4 = var_3[1];
    var_1 += var_4;
    var_5 = spawnStruct();
    var_5.name = var_3[0];
    var_5.ref_12D81 = var_1;
    level.weapon_xp_iw8_ar_sierra552.itemlist[level.weapon_xp_iw8_ar_sierra552.itemlist.size] = var_5;
  }

  level.weapon_xp_iw8_ar_sierra552.ref_13BF6 = var_1;
}

function drop_support_crate_intro() {
  self endon("disconnect");
  self waittill("spawned_player");
  wait 1;

  if(!istrue(game["liveLobbyCompleted"])) {
    scripts\mp\hud_message::showsplash("br_prematch_welcome");
  }

  if(!istrue(level.br_infils_disabled)) {
    self waittill("br_jump");
    thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("mode_desc1", self);

    while(!self isonground()) {
      waitframe();
    }

    thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("mode_desc2", self);
  } else {
    level waittill("prematch_done");
  }

  scripts\mp\gametypes\br_analytics::detachriotshield(self);
}

function dotmtylgroup() {
  level.ref_13B41 = "vfx_br_lep_bomber_exp";
  level.ref_13B46 = getdvarfloat("scr_threat_max_radius_strikes_around_player", 500);
  level.ref_13B47 = getdvarfloat("scr_threat_min_radius_strikes_around_player", 10);
  level.ref_13B45 = getdvarint("scr_threat_explosion_per_strikes", 1);
  level.ref_13B48 = getdvarfloat("scr_threat_thickness_radius_strikes_around_player", 10);
  level.ref_13B43 = getdvarfloat("scr_threat_delay_between_strikes", 0.3);
  level.ref_13B49 = getdvarfloat("scr_threat_varied_delay_between_strikes", 0.5);
  level.ref_13B44 = getdvarint("scr_threat_explosion_damage", 0);
}

function downangles() {
  level.multieventdebug = spawnStruct();
  level.multieventdebug.ref_142AF = "mp_lep_end";
  level.multieventdebug.ref_142AE = 76;
  level.multieventdebug.unmarkplayeraseliminated = 1;
}

function drop_new_carepackage(var_0) {
  thread dropbrlootchoppercrateforpublicevent(level);
}

function dropbrlootchoppercrateforpublicevent(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 waittill("spawned_player");

  if(isDefined(level.ref_142D1)) {
    var_0 visionsetnakedforplayer(level.ref_142D1, 0);
    return;
  }
}

function doteamcirclebattlechatter() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  wait 1.5;
  dropbrkillstreak("mp_don4_infil_lep", 0.5);
  level waittill("infil_transition_chopper");
  dropbrkillstreak("mp_don4");
  waitframe();
  dropbrkillstreak("mp_don4_lep_start");
}

function dorpgambushvo() {
  thread doteleporttosafehouse();
  thread draw_cross_forever();
  thread doorstate();
}

function draw_cross_forever() {
  level endon("game_ended");
  wait 1;
  scripts\mp\gametypes\br_publicevents::ref_13371("br_lep_introduction");
}

function drop_platform() {
  return level.weapon_xp_iw8_ar_golf36;
}

function dropaccesscard() {
  for(var_0 = 6; var_0 > 3; var_0--) {
    do_exfil_vo(1, var_0);
  }

  for(var_0 = 3; var_0 > 1; var_0--) {
    do_exfil_vo(2, var_0);
  }

  for(var_0 = 1; var_0 >= 0; var_0--) {
    do_exfil_vo(3, var_0);
  }
}

function doorisclosed(var_0) {
  var_1 = [];

  if(isDefined(var_0) && var_0 != "tie") {
    var_1 = scripts\mp\utility\teams::getteamdata(var_0, "players");
  }

  return var_1;
}

function drop_weapon_scripted(var_0) {
  thread dopunishhelivocalls(doorisclosed(var_0));
  thread dom();
  var_1 = dontspawnjeep();

  foreach(var_3 in level.players) {
    if(isDefined(var_3)) {
      var_3 scripts\mp\utility\player::_freezecontrols(1);
      var_3 calloutmarkerping_getinventoryslot(0);
      var_3 scripts\mp\gametypes\br_public::ref_126B9(var_1.origin);
    }
  }

  wait 8;

  foreach(var_3 in level.players) {
    if(isDefined(var_3)) {
      if(scripts\mp\utility\player::unset_relic_trex(var_3)) {
        var_3 scripts\mp\laststand::playanim_aibegindismountturret("self_revive_success", var_3);
      }

      var_3 setclientomnvar("ui_br_end_game_splash_type", 0);
      var_3 setclientomnvar("ui_br_squad_eliminated_active", 0);
      var_3.plotarmor = 1;
      var_3 thread scripts\mp\gametypes\br_gulag::gulagfadetoblack(1);
    }
  }

  wait 1;
  dorestartvo();
  thread dropbrhealthpack();
  thread doleaderinterrogationnag();

  foreach(var_3 in level.players) {
    if(isDefined(var_3)) {
      var_3 thread scripts\mp\playerlogic::spawnintermission(var_1, undefined, 0);
    }
  }

  wait 1.5;
  dropbrkillstreak("mp_don4_lep_end", 0);

  foreach(var_3 in level.players) {
    if(isDefined(var_3)) {
      var_3 thread scripts\mp\gametypes\br_gulag::gulagfadefromblack();
    }
  }

  wait 2;
  setomnvarforallclients("post_game_state", 15);
  wait 8;
}

function drop_max(var_0) {
  if(getdvarint("scr_lep_show_plane_icon_after_contract", 0) > 0) {
    foreach(var_2 in level.ref_123AB.audio_player_spawn_mud_loop) {
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var_2, self);
    }

    level.ref_123AB.ref_11B1B = scripts\engine\utility::array_remove(level.ref_123AB.ref_11B1B, self);
    return;
  }

  if(!istrue(self.highlighttoteam)) {
    foreach(var_2 in level.ref_123AB.audio_player_spawn_mud_loop) {
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var_2, self);
    }

    foreach(var_2 in level.ref_123AB.audio_player_start_mud_loop) {
      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var_2, self);
    }

    level.ref_123AB.ref_11B1B = scripts\engine\utility::array_remove(level.ref_123AB.ref_11B1B, self);
    return;
  }
}

function drop_support_crates(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  thread drop_type();
  return undefined;
}

function drop_type() {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("forcePlayerSpectateTarget");

  if(isDefined(level.ref_142D1)) {
    self visionsetnakedforplayer(level.ref_142D1, 0);
  }

  self waittill("spawned_player");

  if(isDefined(level.ref_142D1)) {
    self visionsetnakedforplayer(level.ref_142D1, 0);
    return;
  }
}

function dontspawnjeep() {
  var_0 = spawnStruct();
  var_0.origin = (-13871, -22965, 1193);
  var_0.angles = (358, 59, 0);
  return var_0;
}

function dorestartvo() {
  if(level.mapname == "mp_br_mechanics") {
    return;
  }

  var_0 = level.br_circle.circleindex;
  scripts\mp\gametypes\br_circle::spawn_carriable_at_struct();

  if(level.br_level.default_suicidebomber_combat[var_0] > 0) {
    scripts\mp\gametypes\br_circle::spawn_dummy_crate();
  }

  scripts\mp\gametypes\br_circle::all_players_are_in_trap_room_entrance();
  setomnvar("ui_br_circle0_start_entity", undefined);
}

function dropbrhealthpack() {
  dropoff();
  level endon("stop_planes");
  thread extractlocale_createquestlocale((7747, 12827, 0));
  wait 13.5;
  var_0 = spawn("script_origin", (0, 0, 0));

  for(;;) {
    thread dropbrweapon(level);
    wait 13.5;
  }
}

function extractlocale_createquestlocale(var_0) {
  var_1 = spawn("script_origin", (0, 0, 0));
  var_1.origin = var_0;
  var_2 = getanimlength(%veh_wz_usa_bomber_b17_ending01);

  for(var_3 = 0; var_3 < 4; var_3++) {
    var_4 = 13.5 * var_3 / var_2;
    thread dropbrweapon(var_1, var_4);
  }

  scripts\engine\utility::ref_143BF(var_2, "stop_planes");
  var_1 delete();
}

function dropbrweapon(var_0, var_1) {
  var_2 = dropbrsuperfulton("outroFirstSet");
  var_3 = dropbrsuperfulton("outroSecondSet");
  var_4 = [var_2, var_3];
  var_5 = getanimlength(%veh_wz_usa_bomber_b17_ending01);
  var_0 thread scripts\common\anim::anim_single(var_4, "beauty_shot");

  if(isDefined(var_1)) {
    var_0 scripts\engine\utility::delaythread(0.05, &scripts\common\anim::anim_set_time, var_4, "beauty_shot", var_1);
    var_5 -= var_1 * var_5;
  }

  scripts\engine\utility::ref_143BF(var_5, "stop_planes");
  var_2 delete();
  var_3 delete();
}

function dropbrsuperfulton(var_0) {
  var_1 = spawn("script_model", (0, 0, 0));
  var_1 setModel("wz_usa_bomber_b17_phase05");
  var_1.animname = var_0;
  var_1 useanimtree(level.scr_animtree[var_0]);
  return var_1;
}

function doleaderinterrogationnag() {
  level endon("game_ended");
  level.ref_13B41 = "vfx_br_lep_bomber_exp_end";
  level.ref_13B46 = 12000;
  level.ref_13B47 = 4000;
  level.ref_13B45 = 10;
  level.ref_13B48 = 4000;
  level.ref_13B43 = 0.1;
  var_0 = 11.5;

  for(;;) {
    level thread _hidesafecircleui::chase(var_0, (-6937, -15094, 2876), 1);
    wait var_0;
  }
}

function drop_minigun() {
  if(isDefined(level.weapon_xp_iw8_ar_falima) && isDefined(level.weapon_xp_iw8_ar_falima.oil_puddles)) {
    thread drop_intel_on_death_regardless();
    return;
  }
}

function drop_intel_on_death_regardless() {
  self endon("game_ended");
  self endon("disconnect");
  var_0 = 1;

  while(var_0) {
    var_1 = scripts\engine\utility::ref_143B0("stopped_self_revive", "last_stand_finished", "use_hold_think_fail", "last_stand_revived", "death_or_disconnect");
    thread dropbrgasmask(self);

    if(isDefined(self.laststandreviveent)) {
      thread dropbrgasmask(self.laststandreviveent.reviver);
    }

    switch (var_1) {
      case "last_stand_revived":
      case "last_stand_finished":
      case "death":
        var_0 = 0;
        break;
      case "use_hold_think_fail":
      case "stopped_self_revive":
      default:
        break;
    }
  }
}

function dropbrgasmask(var_0) {
  if(isDefined(var_0)) {
    waitframe();
    var_1 = level.weapon_xp_iw8_ar_falima.oil_puddles;

    if(var_1.claimteam == "none" && !isDefined(var_1.lastprogressteam)) {
      var_0 setclientomnvar("ui_securing", 17);
    } else if(istrue(var_1.stalemate)) {
      var_0 setclientomnvar("ui_securing", 20);
    } else if(var_0.team == var_1.lastprogressteam) {
      var_0 setclientomnvar("ui_securing", 18);
    } else {
      var_0 setclientomnvar("ui_securing", 19);
    }

    var_2 = 0;

    if(isDefined(var_1.lastprogressteam)) {
      var_2 = var_1.teamprogress[var_1.lastprogressteam] / var_1.usetime;
    }

    var_0 setclientomnvar("ui_securing_progress", var_2);
    return;
  }
}

function do_exfil_vo(var_0, var_1) {
  if(var_0 > 0) {
    var_2 = level.weapon_class[level.weapon_box_cache_use[0]];

    for(var_3 = 1; var_3 < var_0; var_3++) {
      var_2 += level.weapon_class[level.weapon_box_cache_use[var_3]];
    }

    var_2 /= var_0;
    var_4 = 0;

    for(var_3 = 0; var_3 < var_0; var_3++) {
      var_5 = [level.weapon_should_not_get_ammo[level.weapon_box_cache_use[var_3]]];

      foreach(var_7 in level.weapon_pick_up_monitor[level.weapon_box_cache_use[var_3]]) {
        var_5 = scripts\engine\utility::array_add(var_5, var_7);
      }

      foreach(var_10 in var_5) {
        var_11 = distance2d(var_2, var_10);

        if(var_11 > var_4) {
          var_4 = var_11;
        }
      }
    }

    var_13 = var_1 + 1;
    var_14 = var_2 - level.br_level.default_class_chosen[var_13];
    var_15 = length2d(var_14);
    var_16 = var_15 + level.br_level.br_circleradii[var_13];
    var_17 = max(var_4, var_16);
    var_18 = level.br_level.br_circleradii[var_1];

    if(var_18 < var_17) {
      var_19 = 1 - var_18 / var_16;
      var_20 = var_14 * var_16 / var_15;
      level.br_level.default_class_chosen[var_1] = var_2 - var_20 * var_19;
      return;
    }

    var_21 = var_18 - var_17;
    var_22 = var_21 / var_18;
    level.br_level.default_class_chosen[var_1] = scripts\mp\gametypes\br_circle::getrandompointincircle(var_2, var_18, var_22, var_22);
    return;
  }

  var_2 = level.weapon_xp_iw8_ar_golf36;
}

function door_is_frozen(var_0) {
  var_1 = 0;

  foreach(var_3 in level.weapon_should_not_get_ammo) {
    var_4 = level.br_level.default_class_chosen[var_0];
    var_5 = level.br_level.br_circleradii[var_0];

    if(scripts\engine\utility::updatescrapassistdata(var_3, var_4, var_5)) {
      var_1++;
    }
  }

  return var_1;
}

function double_wood_stack() {
  level endon("game_ended");
  var_0 = getdvarint("scr_br_lep_challenge_enable", 0);

  if(!var_0) {
    return;
  }

  game["dialog"]["lep_item_near"] = "item_near";
  game["dialog"]["lep_item_interact"] = "item_interact";
  game["dialog"]["lep_chall_completed"] = "challenge_complete";
  level.weapon_xp_iw8_lm_mgolf34 = [];
  level waittill("br_prematchEnded");
  var_1 = "mp/br_lep_cha_locations.csv";
  var_2 = 0;
  var_3 = [];
  GscBinSkip0(0x2e, 0, ["furniture_ping_pong_paddle_01_ch3", 1]);
}

function droppoint(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = randomintrange(0, var_1.size);
  var_7 = var_1[var_6];
  var_8 = var_3[var_6];
  var_9 = var_2[var_6];
  var_10 = spawn("script_model", var_7);
  var_10.angles = var_8;
  var_10 setModel(var_0);
  var_10.weapon_xp_iw8_lm_lima86 = var_4;
  var_10.useprompt = scripts\mp\gameobjects::createhintobject(var_10.origin + var_9, "HINT_BUTTON", undefined, &"MP_BR_INGAME/COLLECT_INTEL", undefined, undefined, undefined, 480, 90, 72, 90);
  dohudplunderpulse(var_10.useprompt, var_4);
  thread do_hack_sequence(var_10.useprompt, var_4, var_5);
  return var_10;
}

function dohudplunderpulse(var_0) {
  var_1 = "iw8_s4_ch_common_season_65_wz_event_challenge_" + var_0;

  foreach(var_3 in level.players) {
    if(isDefined(var_3) && draw_debug_sphere(var_3, var_1)) {
      self disableplayeruse(var_3);
      self hidefromplayer(var_3);
    }
  }
}

function do_hack_sequence(var_0, var_1, var_2) {
  level endon("game_ended");

  for(;;) {
    var_0 waittill("trigger", var_3);
    thread do_heli_takeoff_vo(var_3, var_1);
  }
}

function do_heli_takeoff_vo(var_0, var_1) {
  var_2 = self;
  var_2 playsoundtoplayer("ui_intel_interact", var_2);
  thread do_ghost_skit();
  thread dobreakeractivation();
  thread do_laser_panel_anim_sequence(var_2, var_0);

  foreach(var_4 in level.weapon_xp_iw8_lm_mgolf34) {
    var_4.useprompt disableplayeruse(var_2);
    var_4.useprompt hidefromplayer(var_2);
  }

  wait 0.25;
  var_2 scripts\mp\hud_message::showsplash("br_lep_challenge_started", var_1);
  thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("lep_item_interact", var_2, 1, 0, 3);
}

function dropbrcustompickupitem() {
  self endon("disconnect");
  level endon("game_ended");
  dropbrmissiontablet(0);
  self waittill("spawned");

  foreach(var_1 in level.weapon_xp_iw8_lm_mgolf34) {
    var_1.useprompt enableplayeruse(self);
    var_1.useprompt showtoplayer(self);
  }

  thread drop_jugg_crate();
}

function do_ghost_skit() {
  self endon("disconnect");
  self endon("br_lep_challenge_completed");
  level endon("game_ended");
  self waittill("death");
  thread dropbrcustompickupitem();
}

function dobreakeractivation() {
  self endon("death_or_disconnect");
  self endon("br_lep_challenge_completed");
  level waittill("game_ended", var_0);

  if(isDefined(var_0) && var_0 != "tie") {
    var_1 = scripts\mp\utility\teams::getteamdata(var_0, "players");

    foreach(var_3 in var_1) {
      if(var_3 == self) {
        thread do_kidnapping_anims(var_3);
      }
    }

    return;
  }
}

function do_laser_panel_anim_sequence(var_0, var_1) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  self notify("br_lep_challenge_started");
  dropbrmissiontablet(var_0);
  _calloutmarkerping_handleluinotify_added::ref_1313E("ui_br_lep_data_client", 3, 3, var_1);
  var_2 = level.br_circle.circleindex;

  while(level.br_circle.circleindex < var_2 + var_1) {
    level waittill("br_circle_set", var_3);
    var_4 = var_2 + var_1 - var_3 + 1;

    if(var_4 > 0) {
      _calloutmarkerping_handleluinotify_added::ref_1313E("ui_br_lep_data_client", 3, 3, var_4);
    }
  }

  thread do_kidnapping_anims(5);
}

function do_kidnapping_anims(var_0) {
  self endon("disconnect");
  self notify("br_lep_challenge_completed");
  doors_opened_music("lep_intel_" + self.weapon_xp_iw8_lm_lima86);

  if(var_0 && var_0 > 0) {
    wait var_0;
  }

  _calloutmarkerping_handleluinotify_added::ref_1313E("ui_br_lep_data_client", 3, 3, 0);
  scripts\mp\hud_message::showsplash("br_lep_challenge_completed", self.weapon_xp_iw8_lm_lima86);
  thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("lep_chall_completed", self, 1, 0, 3);
}

function dropbrmissiontablet(var_0) {
  self.weapon_xp_iw8_lm_lima86 = var_0;
  _calloutmarkerping_handleluinotify_added::ref_1313E("ui_br_lep_data_client", 0, 3, var_0);
}

function drop_jugg_crate() {
  self endon("disconnect");
  self endon("br_lep_challenge_started");

  for(;;) {
    var_0 = incrementpersistentstat(level.weapon_xp_iw8_lm_mgolf34, self.origin, 400);

    if(var_0.size > 0) {
      var_1 = scripts\engine\utility::array_get_first_item(var_0);

      if(isDefined(var_1) && draw_debug_sphere("iw8_s4_ch_common_season_65_wz_event_challenge_" + var_1.weapon_xp_iw8_lm_lima86)) {
        wait 5;
      } else {
        wait 1;

        if(!isDefined(self.weapon_xp_iw8_lm_lima86) || self.weapon_xp_iw8_lm_lima86 == 0) {
          thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("lep_item_near", self);
          wait 35;
        }
      }
    }

    wait 1;
  }
}

function doextractionevent() {
  dogtag_collected_lap(1);
  thread dogtag_collected();
}

function dogtag_collected_lap(var_0) {
  dogtag_visibility_watcher((-37834.2, 28261, 851.73), undefined, undefined, var_0);
  dogtag_visibility_watcher((-38449.2, 27099, 1024.73), undefined, undefined, var_0);
  dogtag_visibility_watcher((-38449.2, 25818, 1024.73), undefined, undefined, var_0);
  dogtag_visibility_watcher((-37815.2, 26098, 532.73), undefined, undefined, var_0);
  dogtag_visibility_watcher((-37607.2, 25237, 696.73), undefined, undefined, var_0);
  dogtag_visibility_watcher((-37356.2, 26299, 476.73), undefined, undefined, var_0);
  dogtag_visibility_watcher((-37618.2, 27497, 707.73), undefined, undefined, var_0);
  dogtag_visibility_watcher((-38418.2, 26177, 1024.73), undefined, undefined, var_0);
}

function dogtag_collected() {
  level endon("game_ended");
  level waittill("prematch_done");
  dogtag_collected_lap();
}

function dogtag_visibility_watcher(var_0, var_1, var_2, var_3) {
  var_4 = 600;
  var_5 = 350;

  if(!isDefined(var_1)) {
    var_1 = var_4;
  }

  if(!isDefined(var_2)) {
    var_2 = var_5;
  }

  scripts\mp\gametypes\br_quest_util::little_bird_mg_playercontrolmg(var_0, var_1, var_2, var_3);
}

function door2(var_0, var_1) {
  if(var_0.size > 0) {
    if(istrue(var_1)) {
      var_2 = randomint(var_0.size);
      return var_0[var_2];
    } else {
      var_3 = [];

      foreach(var_5 in var_1) {
        var_6 = scripts\common\utility::playersinsphere(var_5.crashorigin, 3000);
        var_5.numplayers = var_6.size;
      }

      var_3 = scripts\engine\utility::array_sort_with_func(var_1, &doarmsraceopencachenags);

      if(var_3[0].numplayers == 0) {
        var_8 = door2(var_1, 1);
        level.ref_12882 = var_8.crashorigin;
        return var_8;
      }

      var_8 = door_anim(var_4);
      level.ref_12882 = var_8.crashorigin;
      return var_8;
    }
  }

  return undefined;
}

function doarmsraceopencachenags(var_0, var_1) {
  return var_0.numplayers > var_1.numplayers;
}

function door_anim(var_0) {
  if(isDefined(level.ref_12882)) {
    foreach(var_2 in var_0) {
      if(distance2dsquared(var_2.crashorigin, level.ref_12882) > 100000000) {
        return var_2;
      }
    }

    return var_0[0];
  }

  return var_3[0];
}

function dropangles(var_0) {
  var_1 = level.br_level.default_class_chosen[level.br_circle.circleindex + 1];
  var_2 = level.br_level.br_circleradii[level.br_circle.circleindex + 1];

  foreach(var_4 in level.ref_123AB.player_fov_default_1) {
    if(distance2d(var_4.crashorigin, var_1) > var_2) {
      var_4.forced_bleedout = 1;
      level.ref_123AB.player_fov_default_1 = scripts\engine\utility::array_remove(level.ref_123AB.player_fov_default_1, var_4);
    }
  }
}

function dropped_weapon() {
  level endon("game_ended");
  jumpiftrue(getdvarint("scr_br_lep_cache_drop_enabled", 1)) LOC_00000016;
  return;
}

function dropped_weapon_cleanup() {
  level endon("game_ended");

  if(!getdvarint("scr_br_lep_cache_drop_enabled", 1)) {
    return;
  }

  scripts\mp\flags::gameflagwait("prematch_fade_done");

  while(!isDefined(level.infilstruct)) {
    return;
  }

  downtown_gw_ambient_sound_load();
  level waittill("br_circle_set", var_0);

  if(getdvarint("scr_lep_vision_set_extended_disabled", 0) == 0) {
    dropbrkillstreak("mp_don4_lep_circle_1", 10);
  }

  thread dohudplunderroll();
  wait 15;
  thread dokidnapsequence(level);
  thread dropbrselfrevivetoken(level, 5, 2363, 40, 60);
  level waittill("br_circle_started", var_0);
  dropangles(var_0);
  level waittill("br_circle_set", var_0);

  if(getdvarint("scr_lep_vision_set_extended_disabled", 0) == 0) {
    dropbrkillstreak("mp_don4_lep_circle_2", 10);
  }

  thread dokidnapsequence(level);
  thread dropbrselfrevivetoken(level, 5, 2363, 40);
  level waittill("br_circle_started", var_0);
  dropangles(var_0);
  level waittill("br_circle_set", var_0);

  if(getdvarint("scr_lep_vision_set_extended_disabled", 0) == 0) {
    dropbrkillstreak("mp_don4_lep_circle_3", 10);
  }

  thread dointrovo(level);
  thread do_manual_splash_damage_when_frag_explodes();
  thread dropbrselfrevivetoken(level, 5, 1181, 35);
  level waittill("br_circle_set");

  if(getdvarint("scr_lep_vision_set_extended_disabled", 0) == 0) {
    dropbrkillstreak("mp_don4_lep_circle_4", 10);
  }

  thread do_not_unload();
  thread dropbrselfrevivetoken(level, 5, 1181, 35);
  level waittill("br_circle_set");
  level thread scripts\mp\gametypes\br_quest_util::generate_solution();
  level thread scripts\mp\gametypes\br_quest_util::little_bird_mg_mp_enterendinternal();
  thread dontshowscoreevent();
}

function dontspawncargotruck(var_0) {}

function doingcheck(var_0, var_1) {
  var_0.infil_chopper_path_flags_manager = 1;
  thread dointerrogationvo(level);
  return true;
}

function dointerrogationvo(var_0) {
  var_1 = var_0.crashorigin;
  var_2 = vectortoangles(var_0.crashorigin - var_0.spawnorigin);
  var_3 = var_0.infectsetradaronnumsurvivors;

  if(!isDefined(var_0.infectsetradaronnumsurvivors)) {
    var_3 = var_2;
  }

  var_4 = var_0.spawnorigin;

  if(getdvarint("scr_lep_crash_plane_use_raytrace", 0) > 0) {
    var_5 = (0, 0, 500);
    var_6 = dropallunusableitems(var_1 + var_5, var_1 - var_5);
    var_7 = var_6["position"];
  } else {
    var_7 = var_2;
  }

  var_8 = anglesToForward((0, var_3[1], 0)) * -250;
  var_9 = var_7 + var_8;
  dohudplunderrollsound(var_1, var_7, var_9);
  var_1.infil_chopper_path_flags_manager = 0;
  var_1.forced_bleedout = 1;
  var_10 = dropjuggbox(var_7, var_4);
  var_10 radiusdamage(var_7, 500, 1000, 50);
  var_10 setscriptablepartstate("model", "crashed");
  playFX(level._effect["vfx_br_lep_ground_exp"], var_7, anglesToForward((0, var_3[1], 0)), (0, 0, 1));
  drone_turret_canseetarget(var_10, var_1.objid, var_1.ref_11F93);
  thread dropped_weapon_cleanup_internal();
}

function dohudplunderrollsound(var_0, var_1, var_2) {
  var_3 = var_2 - var_1;
  var_4 = vectortoangles(var_3);
  var_4 = (var_4[2], var_4[1] + 90, var_4[0]);
  var_5 = dropcpcratefromscriptedheli(var_1, var_4);
  var_5 endon("death");
  waitframe();
  var_5 setscriptablepartstate("model", "falling");
  var_0.objid = drone_turrets(var_5, 2000, 1, 1, 0, 0);
  var_0.ref_11F93 = drone_turrets(var_5, 2000, 1, 0, 0, 1);
  var_6 = getdvarint("scr_br_lep_cache_speed", 3000);
  var_7 = getdvarfloat("scr_br_lep_cache_accel", 0.75);
  var_8 = distance(var_1, var_2);
  var_9 = var_8 / var_6;
  var_10 = var_9 * var_7;
  var_5 moveTo(var_2, var_9, var_10, 0.05);
  thread drop_priorities(level);
  wait var_9;
  var_5 setscriptablepartstate("model", "impact");
  drop_saw_think(var_2);
  var_5 notify("stop_plane_vehicle_crush");
  var_5 notify("plane_crashed");
  var_5 delete();
}

function dropcpcratefromscriptedheli(var_0, var_1) {
  var_2 = spawn("script_model", var_0);
  var_2.angles = var_1;
  var_2 setModel("wz_usa_bomber_b17_destroyed_rig");
  var_2 setscriptablepartstate("model", "explosion");
  return var_2;
}

function dropjuggbox(var_0, var_1) {
  var_2 = spawn("script_model", var_0);
  var_2.angles = var_1;
  var_2 setModel("usa_bomber_b17_hero_wing_combined_02");
  var_2.enemy_is_visible = spawn("script_model", var_0);
  var_3 = getEnt("bomber_crash_assets_col", "targetname");

  if(isDefined(var_3)) {
    var_2.enemy_is_visible clonebrushmodeltoscriptmodel(var_3);
    var_2.enemy_is_visible linkTo(var_2, "", (-86, -28, 40), (0, 0, 0));
  }

  var_2.id = "care_package";
  var_2.updatecirclepulse = 1;
  var_2.angles = (0, var_1[1], 0);
  return var_2;
}

function drop_saw_think(var_0) {
  var_1 = scripts\engine\trace::sphere_trace_get_all_results(var_0, var_0, 60);

  foreach(var_3 in var_1) {
    var_4 = var_3["entity"];
    dropoff_sound_playervm_handler(var_4, var_0);
  }
}

function drop_priorities(var_0) {
  var_0 endon("death");
  var_0 endon("stop_plane_vehicle_crush");

  for(;;) {
    var_0 waittill("touch", var_1);
    dropoff_sound_playervm_handler(var_1, var_0.origin);
  }
}

function dropoff_sound_playervm_handler(var_0, var_1) {
  if(!isDefined(var_0) || !isalive(var_0)) {
    return;
  }

  if(!var_0 scripts\common\vehicle::isvehicle() && !isDefined(var_0.classname)) {
    return;
  }

  if(var_0.classname == "script_vehicle") {
    var_0 dodamage(10 * var_0.health, var_1);
    return;
  }
}

function dropallunusableitems(var_0, var_1) {
  var_2 = scripts\engine\trace::ray_trace(var_0, var_1);
  var_3 = [];

  if(isDefined(var_2["entity"]) && var_3.size < 25) {
    GscBinSkip0(0x2e, var_3.size, var_2["entity"]);
  }

  return var_2;
}

function drone_turret_canseetarget(var_0, var_1, var_2) {
  var_3 = anglesToForward(var_0.angles) * 50;
  var_4 = var_0.origin + var_3;
  var_5 = (0, 0, 500);
  var_6 = dropallunusableitems(var_4 + var_5, var_4 - var_5);
  var_7 = (0, var_0.angles[1] - 90, 0);
  var_7 = generateaxisanglesfromupvector(var_6["normal"], var_7);
  var_0.chest = easepower("br_loot_cache_lep", var_6["position"] + (0, 0, 0.5), var_7);
  var_0.chest.get_circle_back_nodes_on_same_side = &draw_line_orgtoent;
  var_0.chest.ref_123A1 = var_0;
  var_0.chest.objid = var_1;
  var_0.chest.ref_11F93 = var_2;
  drone_turrets(var_0.chest, 30, 1, 0, 1, 0);
  drone_turrets(var_0.chest, 30, 1, 0, 0, 1);
}

function draw_line_orgtoent(var_0, var_1, var_2, var_3, var_4) {
  if((var_2 == "closed" || var_2 == "closed_nocol") && !isDefined(var_0.entity)) {
    if(var_2 == "closed") {
      var_0 setscriptablepartstate(var_1, "opening");
    } else if(var_2 == "closed_nocol") {
      var_0 setscriptablepartstate(var_1, "opening_nocol");
    }

    var_3 thread scripts\mp\utility\points::giveunifiedpoints("br_cacheOpen");
    var_3 scripts\cp\vehicles\vehicle_compass_cp::ref_12002();

    if(!isDefined(var_3.ref_11A01)) {
      var_3.ref_11A01 = 1;
    } else {
      var_3.ref_11A01++;
    }

    var_3 scripts\mp\utility\stats::setextrascore1(var_3.ref_11A01);
    dropjuggernautcrate(var_0);
    level notify("lootcache_opened_kill_callout" + var_0.origin);
    thread dropbrattackerperkammo(var_0);
    thread dropbrattackerperkammo(var_0, var_0.ref_11F93);
    var_0.objid = undefined;
    var_0.ref_11F93 = undefined;
    thread drawprematchareas(var_0);
  }

  return false;
}

function drawprematchareas(var_0) {
  level endon("game_ended");
  self.ref_123A1 endon("plane_cache_unusable");
  var_1 = getdvarint("scr_reusable_cache_recharge_time", 120);
  wait var_1;
  self setscriptablepartstate(var_0, "closing");
  drone_turrets(self, 30, 1, 0, 1, 0);
  drone_turrets(self, 30, 1, 0, 0, 1);
}

function dropped_weapon_cleanup_internal() {
  self endon("death");
  self endon("plane_cache_unusable");

  for(;;) {
    level waittill("br_circle_started");
    var_0 = level.br_level.default_class_chosen[level.br_circle.circleindex + 1];
    var_1 = level.br_level.br_circleradii[level.br_circle.circleindex + 1];

    if(distance2d(self.origin, var_0) > var_1) {
      for(;;) {
        var_0 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
        var_1 = scripts\mp\gametypes\br_circle::getdangercircleradius() + 1500;

        if(distance2d(self.origin, var_0) > var_1) {
          thread drone_out_of_bound_monitor();
          return;
        }

        wait 1;
      }
    }
  }
}

function dropjuggernautcrate(var_0) {
  var_1 = door_is_open_at_least(var_0);

  if(!isDefined(var_1) || var_1.size <= 0) {
    return [];
  }

  var_2 = spawnStruct();
  var_3 = anglesToForward((0, var_0.angles[1] - -90, 0));
  var_2.origin = var_0.origin + var_3 * 25 - (0, 0, 0.5);
  var_2.angles = (0, var_0.angles[1], 0);
  var_2.itemsdropped = 0;
  var_4 = var_2 scripts\mp\gametypes\br_lootcache::ref_11A42(var_1, 1, undefined);
  return var_4;
}

function door_is_open_at_least(var_0) {
  var_1 = randomint(24);
  var_2 = verifybunkercode("lep_cache", var_1);

  if(!isDefined(var_2)) {
    var_2 = [];
  }

  var_3 = door_parts();

  if(isDefined(var_3)) {
    var_2 = var_3;
  }

  var_2 = "brloot_lep_tablet";
  return var_2;
}

function door_parts() {
  if(!isDefined(level.weapon_xp_iw8_ar_sierra552)) {
    downtown_helicopter_start();
  }

  var_0 = randomint(level.weapon_xp_iw8_ar_sierra552.ref_13BF6);

  foreach(var_2 in level.weapon_xp_iw8_ar_sierra552.itemlist) {
    if(var_0 <= var_2.ref_12D81) {
      return var_2.name;
    }
  }

  return undefined;
}

function drone_out_of_bound_monitor(var_0) {
  self endon("death");
  jumpiftrue(isDefined(var_0)) LOC_00000011;
  var_0 = 0;

  while(!var_0) {
    var_1 = scripts\common\utility::playersinsphere(self.origin, 3000);

    if(var_1.size == 0) {
      break;
    }

    wait 1;
  }

  self.chest setscriptablepartstate("body", "hidden");
  dropbrattackerperkammo(self.chest.objid);
  dropbrattackerperkammo(self.chest.ref_11F93, 1);
  self notify("plane_cache_unusable");
  self.enemy_is_visible delete();
  self delete();
}

function drone_turrets(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(getdvarint("scr_lep_show_plane_icon_after_contract", 0) > 0 && istrue(var_5)) {
    return undefined;
  }

  var_6 = scripts\engine\utility::ter_op(istrue(var_5), var_0.ref_11F93, var_0.objid);

  if(!isDefined(var_6)) {
    var_6 = scripts\mp\objidpoolmanager::requestobjectiveid(99);

    if(istrue(var_5)) {
      var_0.ref_11F93 = var_6;
      scripts\mp\objidpoolmanager::objective_add_objective(var_6, "active");
      level.ref_123AB.audio_player_start_mud_loop[level.ref_123AB.audio_player_start_mud_loop.size] = var_6;
    } else {
      var_0.objid = var_6;
      scripts\mp\objidpoolmanager::objective_add_objective(var_6, "current");
      level.ref_123AB.audio_player_spawn_mud_loop[level.ref_123AB.audio_player_spawn_mud_loop.size] = var_6;
    }

    objective_setbackground(var_6, 1);
    objective_icon(var_6, "ui_mp_br_minimap_icon_dis");
    function_0421(var_6, 1);
    objective_setplayintro(var_6, 0);
    objective_setlabel(var_6, "BR_LEP_EVENT/PLANE_CRASH");
    function_043d(var_6, 1);
    objective_removeallfrommask(var_6);

    foreach(var_8 in level.players) {
      if(isDefined(var_8)) {
        if(scripts\engine\utility::array_contains(level.ref_123AB.ref_11B1B, var_8)) {
          if(istrue(var_5)) {
            scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var_6, var_8);
          } else {
            scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var_6, var_8);
          }

          continue;
        }

        if(!istrue(var_5)) {
          scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var_6, var_8);
          continue;
        }

        scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var_6, var_8);
      }
    }
  } else {
    objective_setzoffset(var_6, 0);
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(istrue(var_3)) {
    objective_setshowoncompass(var_6, var_3);
  }

  if(istrue(var_2) && !istrue(var_5)) {
    getbnetigrbattlepassxpmultiplier(var_6, 39370, 47244);
  }

  if(istrue(var_4)) {
    objective_setshowdistance(var_6, var_4);
  }

  if(isent(var_0)) {
    if(getdvarint("scr_br_lep_cache_self_update_icon_pos", 0) > 0) {
      thread dropoff_sound_playerwm_handler(var_0, var_6);
    } else {
      objective_onentity(var_6, var_0);
      objective_setzoffset(var_6, var_1);
    }
  } else {
    objective_setlocation(var_6, 0, var_0.origin + (0, 0, var_1));
  }

  return var_6;
}

function dropoff_sound_playerwm_handler(var_0, var_1) {
  self endon("plane_crashed");
  self endon("death");
  var_2 = (0, 0, var_1);

  for(;;) {
    objective_position(var_0, self.origin + var_2);
    waitframe();
    waitframe();
  }
}

function dropbrattackerperkammo(var_0, var_1) {
  if(getdvarint("scr_lep_show_plane_icon_after_contract", 0) > 0 && istrue(var_1)) {
    return;
  }

  if(isDefined(var_0)) {
    foreach(var_3 in level.players) {
      if(isDefined(var_3)) {
        var_4 = var_3 getnodeoffset_code(7);

        if(isDefined(var_4) && var_4 == var_0) {
          var_3 scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_removecallout(7);
        }
      }
    }

    waittillframeend();
    scripts\mp\objidpoolmanager::returnobjectiveid(var_0);

    if(istrue(var_1)) {
      level.ref_123AB.audio_player_start_mud_loop = scripts\engine\utility::array_remove(level.ref_123AB.audio_player_start_mud_loop, var_0);
      return;
    }

    level.ref_123AB.audio_player_spawn_mud_loop = scripts\engine\utility::array_remove(level.ref_123AB.audio_player_spawn_mud_loop, var_0);
    return;
  }
}

function drop_in_progress() {
  level endon("game_ended");

  for(;;) {
    level waittill("quest_started", var_0, var_1);
    waitframe();
    var_2 = scripts\engine\utility::array_removeundefined(scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_0, var_1));

    foreach(var_4 in var_2) {
      if(!scripts\engine\utility::array_contains(level.ref_123AB.ref_11B1B, var_4)) {
        level.ref_123AB.ref_11B1B = scripts\engine\utility::array_add(level.ref_123AB.ref_11B1B, var_4);

        foreach(var_6 in level.ref_123AB.audio_player_spawn_mud_loop) {
          scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var_6, var_4);
        }

        foreach(var_6 in level.ref_123AB.audio_player_start_mud_loop) {
          scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var_6, var_4);
        }
      }
    }
  }
}

function do_ascender_entrance(var_0, var_1, var_2, var_3) {
  if(istrue(var_3)) {
    var_4 = combineangles((0, 180, 0), (0, level.infilstruct.c130pathstruct.angle[1], 0));
    var_5 = var_1 + anglesToForward(var_4) * -24000;
    var_5 = (var_5[0], var_5[1], 23000);
  } else {
    var_5 = var_2 + anglesToForward(var_3) * -24000;
    var_5 = (var_5[0], var_5[1], 23000);
  }

  var_6 = spawnStruct();
  var_6.crashorigin = var_2;
  var_6.spawnorigin = var_5;
  var_6.infectsetradaronnumsurvivors = var_3;
  var_6.infil_chopper_path_flags_manager = 0;
  var_6.forced_bleedout = 0;
  var_1 = scripts\engine\utility::array_add(var_1, var_6);
  return var_1;
}

function do_cache_2_prep(var_0, var_1) {
  var_2 = var_0 - 1;

  if(!isDefined(level.player_fulton_evac_rumble)) {
    level.player_fulton_evac_rumble = [];
  }

  if(!isDefined(level.player_fulton_evac_rumble[var_2])) {
    level.player_fulton_evac_rumble[var_2] = [];
  }

  level.player_fulton_evac_rumble[var_2] = scripts\engine\utility::array_add(level.player_fulton_evac_rumble[var_2], var_1);
}

function dokidnapsequence(var_0) {
  var_1 = level.player_fulton_evac_rumble[var_0 - 1];

  foreach(var_3 in var_1) {
    wait var_3;
    var_4 = door2(level.ref_123AB.player_fov_default_1);

    if(!isDefined(var_4)) {
      return;
    }

    if(doingcheck(level, var_4)) {
      level.ref_123AB.player_fov_default_1 = scripts\engine\utility::array_remove(level.ref_123AB.player_fov_default_1, var_4);
    }
  }
}

function dointrovo(var_0) {
  var_1 = level.player_fulton_evac_rumble[var_0 - 1];

  foreach(var_3 in var_1) {
    wait var_3;
    var_4 = door2(level.ref_123AB.ref_13B2E, 1);

    if(!isDefined(var_4)) {
      return;
    }

    if(doingcheck(level, var_4)) {
      level.ref_123AB.ref_13B2E = scripts\engine\utility::array_remove(level.ref_123AB.ref_13B2E, var_4);
    }
  }
}

function dohudplunderroll() {
  var_0 = scripts\engine\utility::array_randomize(level.ref_123AB.ref_12F8B);
  wait 5;

  foreach(var_2 in var_0) {
    thread doingcheck(level);
    wait 3;
  }
}

function drones_spawning() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  var_0 = 0;

  while(var_0 <= 5) {
    level waittill("br_circle_set", var_0);

    if(var_0 == 1) {
      wait 20;
    }

    var_1 = level.br_level.br_mapcenter;

    if(var_0 > 1 && var_0 < level.br_level.default_class_chosen.size) {
      var_1 = level.br_level.default_class_chosen[var_0];
    }

    var_1 = (var_1[0], var_1[1], 30000);
    extraction_balloon_num_completed(var_1, var_0);
  }
}

function extraction_balloon_num_completed(var_0, var_1) {
  if(!isDefined(level.player_infil_played_or_skipped)) {
    level.player_infil_played_or_skipped = spawnStruct();
    level.player_infil_played_or_skipped.ent = spawn("script_model", var_0);
    level.player_infil_played_or_skipped.ent setModel("vfx_br_lep");
    thread doesstreakinfomatchequippedstreak(level.player_infil_played_or_skipped.ent);
  }

  level.player_infil_played_or_skipped.amount = clamp(var_1, 1, 5);
  level.player_infil_played_or_skipped.ent.origin = var_0;
  level.player_infil_played_or_skipped.ent setscriptablepartstate("vfx", "flak_" + level.player_infil_played_or_skipped.amount);
}

function dropcircle() {
  scripts\mp\flags::gameflagwait("prematch_fade_done");

  if(!isDefined(level.infilstruct)) {
    return;
  }

  dropoff();
  thread dropminigunondeath(2048, ["planeWaves", "planeWaves", "planeWaves"], level.infilstruct.c130pathstruct.angle[1]);
}

function dropminigunondeath(var_0, var_1, var_2) {
  level endon("game_ended");
  level endon("stop_planes");

  if(!getdvarint("scr_br_lep_plane_waves_enabled", 1)) {
    return;
  }

  if(!isDefined(level.ctgs_comparestats)) {
    level.ctgs_comparestats = spawnStruct();
  }

  var_3 = gettime() + var_0 * 1000;
  var_4 = [(45000, -15000, 0), (45000, -20000, 0), (45000, -17500, 0), (45000, -18000, 0), (45000, -20000, 0)];
  var_5 = -1000;
  var_2 = var_2;
  var_6 = var_1;
  var_7 = 20;
  var_8 = getdvarint("scr_bomberWaveDelay", 20);
  level.ref_11B54 = getdvarint("scr_br_maxBomberWaves_entityCount", 16);

  if(isDefined(level.br_circle) && isDefined(level.br_circle.circleindex) && level.br_circle.circleindex < 1) {
    var_9 = getdvarvector("bomber_offset", var_4[0]);
    var_10 = level.br_level.br_mapcenter + rotatevector(var_9, (0, var_2, 0));
    dropdeliveryatpos(var_10, var_2, var_6, var_7, var_8);
  }

  while(gettime() < var_3) {
    if(level.ctgs_comparestats.ref_123AC < level.ref_11B54) {
      dropcondensedplunder(var_4, var_5, var_2, var_6, var_7);
    }

    wait var_8;
  }
}

function dropoff() {
  level notify("stop_planes");

  if(!isDefined(level.ctgs_comparestats) || !isDefined(level.ctgs_comparestats.ref_1452C)) {
    return;
  }

  foreach(var_1 in level.ctgs_comparestats.ref_1452C) {
    doendofmatchotsequence(var_1, 0);
  }

  level.ctgs_comparestats.ref_1452C = [];
}

function dropdeliveryatpos(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(level.ctgs_comparestats.ref_123AC)) {
    level.ctgs_comparestats.ref_123AC = 0;
  }

  for(var_5 = 3; var_5 > 0; var_5--) {
    if(level.ctgs_comparestats.ref_123AC < level.ref_11B54) {
      var_6 = dotooclosetominenags(var_0, var_1, var_2, var_3);
      var_7 = var_6.models[0] scripts\engine\utility::getanim("bomber_planes");
      var_8 = getanimlength(var_7);
      var_9 = var_4 * var_5 / var_8;
      thread drop_scavenger_bag(var_6);
      var_6.bunkeralt_playerinteractwithkeypadloop scripts\engine\utility::delaythread(0.05, &scripts\common\anim::anim_set_time, var_6.models, "bomber_planes", var_9);
    }
  }
}

function dropcondensedplunder(var_0, var_1, var_2, var_3, var_4) {
  var_5 = int(min(level.br_circle.circleindex, level.br_level.br_circleradii.size - 1));
  var_6 = level.br_level.br_mapcenter;
  var_7 = getdvarvector("bomber_offset", var_0[int(clamp(var_5, 0, var_0.size - 1))]);

  if(var_5 > 0) {
    var_6 = level.br_level.default_class_chosen[var_5];
    var_4 += level.br_level.br_mapsize[0] / level.br_level.br_circleradii[var_5];
  }

  if(isDefined(level.br_circle.starttime)) {
    var_8 = level.br_circle.starttime / 1000 + level.br_level.br_circledelaytimes[var_5];
    var_9 = gettime() / 1000 + 17;
    var_10 = var_9 >= var_8;

    if(var_10 && var_5 + 1 < level.br_level.default_class_chosen.size) {
      var_11 = clamp((var_9 - var_8) / level.br_level.br_circleclosetimes[var_5], 0, 1);
      var_12 = level.br_level.default_class_chosen[var_5 + 1];
      var_13 = getdvarvector("bomber_next_offset", var_0[int(clamp(var_5 + 1, 0, var_0.size - 1))]);
      var_6 = vectorlerp(var_6, var_12, var_11);
      var_7 = vectorlerp(var_7, var_13, var_11);
    }
  }

  var_6 = (var_6[0], var_6[1], var_1) + rotatevector(var_7, (0, var_2, 0));
  var_14 = dotooclosetominenags(var_6, var_2, var_3, var_4);
  thread drop_scavenger_bag(var_14);
}

function dotooclosetominenags(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.ctgs_comparestats)) {
    level.ctgs_comparestats.ctgs_comparestats = spawnStruct();
  }

  if(!isDefined(level.ctgs_comparestats.ref_123AC)) {
    level.ctgs_comparestats.ref_123AC = 0;
  }

  if(!isDefined(level.ctgs_comparestats.ref_1452C)) {
    level.ctgs_comparestats.ref_1452C = [];
  }

  var_4 = spawnStruct();
  var_4.spawnpos = var_0;
  var_4.building_magic_grenade_watch = (0, var_1, 0);
  var_4.bunkeralt_playerinteractwithkeypadloop = scripts\engine\utility::spawn_tag_origin(var_4.spawnpos, var_4.building_magic_grenade_watch);
  var_4.molotov_delete_pool_by_id = var_3;
  var_4.models = [];
  var_5 = (0, 0, 0);

  if(isDefined(level.br_circle) && isDefined(level.br_circle.circleindex) && isDefined(level.br_level.br_circleradii) && var_2.size > 1) {
    var_6 = int(clamp(level.br_circle.circleindex, 0, level.br_level.br_circleradii.size));
    var_5 = (0, randomfloat(level.br_level.br_circleradii[var_6]), 0);
    var_5 = rotatevector(var_5, (0, var_1, 0));
    var_0 -= (var_2.size / 2, var_2.size / 2, 0) * var_5;
  }

  foreach(var_8 in var_2) {
    var_9 = dropcashdeny(var_0);
    var_9.animname = var_8;
    var_9 useanimtree(level.scr_animtree[var_8]);
    var_9 unmarkkeyframedmover(1);
    var_4.models[var_10] = var_9;
    var_5 *= rotatevector((-1, 1, -1), (0, var_1, 0));
    var_0 += var_5;
  }

  var_4.num_nodes_search_player = var_4.models.size + 1;
  level.ctgs_comparestats.ref_123AC += var_4.num_nodes_search_player;
  level.ctgs_comparestats.ref_1452C[level.ctgs_comparestats.ref_1452C.size] = var_4;
  return var_4;
}

function doendofmatchotsequence(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  foreach(var_3 in var_0.models) {
    var_3 delete();
  }

  var_0.bunkeralt_playerinteractwithkeypadloop delete();
  level.ctgs_comparestats.ref_123AC -= var_0.num_nodes_search_player;

  if(istrue(var_1)) {
    level.ctgs_comparestats.ref_1452C = scripts\engine\utility::array_remove(level.ctgs_comparestats.ref_1452C, var_0);
    return;
  }
}

function drop_scavenger_bag(var_0) {
  level endon("game_ended");
  level endon("stop_planes");
  var_0.bunkeralt_playerinteractwithkeypadloop scripts\common\anim::anim_single(var_0.models, "bomber_planes", undefined, var_0.molotov_delete_pool_by_id);
  doendofmatchotsequence(var_0);
}

function dropcashdeny(var_0) {
  var_1 = clamp(level.br_circle.circleindex + 1, 1, 5);
  var_2 = spawn("script_model", var_0);
  var_3 = "wz_usa_bomber_boscar17_phase1_group_ch3";
  var_2 setModel(var_3);
  var_2.angles = (0, 0, 0);
  return var_2;
}

function dontshowscoreevent() {
  level endon("game_ended");
  wait 2;
  level.weapon_xp_iw8_lm_kilo121 setscriptablepartstate("sfx", "siren");

  foreach(var_1 in level.players) {
    if(isDefined(var_1)) {
      var_1 setsoundsubmix("br_lep_amb_2");
      var_1 clearsoundsubmix("br_lep_amb_2", 5);
    }
  }

  wait 3;
  thread dropcratefrommanualheli_cp();
  wait 8;
  level thread scripts\mp\gametypes\br_public::brleaderdialog("lep_air_defences", undefined, undefined, 1);
  wait 8;
  thread do_custom_evade_start();
  wait 20;
  thread dont_shoot_parachutes();
}

function do_custom_evade_start() {
  level endon("game_ended");
  level thread scripts\mp\gametypes\br_public::brleaderdialog("lep_bomb_shelter", undefined, undefined, 1);
  var_0 = level.weapon_xp_iw8_ar_golf36;
  var_1 = 10288;
  thread dropkit_marker_hints(level, var_0);
}

function doarmsracelocationnags(var_0, var_1, var_2, var_3) {
  if(var_2 == "toma_strike" && !isPlayer(self)) {
    var_4 = scripts\common\utility::playersincylinder(var_0, var_1);
    level thread scripts\mp\gametypes\br_public::brleaderdialog("lep_bomb_incoming", undefined, var_4);

    foreach(var_6 in var_4) {
      if(!isDefined(var_6) || !scripts\mp\utility\player::isreallyalive(var_6) || var_6.team == self.team) {
        continue;
      }

      scripts\mp\gametypes\br_killstreaks::isbrsquadleader(var_6, "lep_toma_strike", 0);
    }

    return;
  }

  scripts\mp\gametypes\br_killstreaks::isbulletpenetration(var_0, var_1, var_2, var_3);
}

function do_spawn_vo_callout(var_0, var_1) {
  if(!isDefined(level.create_digit_models)) {
    level.create_digit_models = [];
  }

  var_2 = 1000;

  for(var_3 = 0; var_3 < 3; var_3++) {
    var_4 = randomfloatrange(0, 360);
    var_5 = randomfloatrange(0, var_1);
    var_6 = (cos(var_4) * var_5, sin(var_4) * var_5, 0) + var_0;

    for(var_7 = 0; var_7 < level.create_digit_models.size; var_7++) {
      var_8 = level.create_digit_models[var_7];
      var_2 = distance2d(var_6, var_8);

      if(var_2 < 1000) {
        break;
      }
    }

    if(var_2 < 1000) {
      continue;
    }

    level.create_digit_models[level.create_digit_models.size] = var_6;
    return var_6;
  }

  return undefined;
}

function dropkit_marker_hints(var_0, var_1) {
  self notify("lep_bombardment");
  self notify("begin_strikes");
  self endon("lep_bombardment");
  self endon("game_ended");
  var_2 = 2 * level.framedurationseconds;
  var_3 = 5;

  for(;;) {
    level.create_digit_models = [];

    for(var_4 = 0; var_4 < var_3; var_4++) {
      var_5 = do_spawn_vo_callout(var_0, var_1);

      if(!isDefined(var_5)) {
        break;
      }

      if(getdvarint("scr_lep_bombardment_does_damage", 0)) {
        thread dropbrprimaryweapons(level, var_5, 30);
      }

      if(getdvarint("scr_lep_bombardment_fx", 0)) {
        level thread _hidesafecircleui::chase(10, var_5);
      }

      wait var_2;
    }

    wait 20;
  }
}

function dropbrprimaryweapons(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.streakname = "toma_strike";
  var_3.score = 0;
  var_3.shots_fired = 0;
  var_3.hits = 0;
  var_3.damage = 0;
  var_3.kills = 0;
  var_3.ref_11EAE = 0;
  var_3.ref_11F47 = 1;
  var_3.vehicle_process_node_when_at_goal = 1;
  var_3.ref_121A9 = "ks_toma_strike_missile_mp_x2";
  var_3.ref_121A8 = "ks_toma_strike_cluster_mp_x2";
  var_3.ref_133DC = 1;
  var_3.ref_13A81 = var_0;

  if(isDefined(var_1)) {
    var_3.ref_129E3 = var_1;
  }

  if(isDefined(var_2)) {
    var_3.ref_11ECE = var_2;
  }

  var_4 = randomfloatrange(0, 360);
  var_5 = vectortoangles((cos(var_4), sin(var_4), 0));
  scripts\cp_mp\killstreaks\toma_strike::ref_13BDA(var_0, var_5, var_3);
}

function helidrivabledeathall() {
  if(!isDefined(self)) {
    return;
  }

  radiusdamage(self.origin, 256, 15, 15, self, "MOD_EXPLOSIVE", "toma_proj_mp");
}

function dropbrselfrevivetoken(var_0, var_1, var_2, var_3, var_4) {
  level notify("begin_strikes");
  level endon("begin_strikes");
  self endon("game_ended");
  var_5 = getdvarfloat("scr_clusterBombDuration", 0.5);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "dangerNotifyPlayersInRange", &doarmsracelocationnags);

  while(level.ref_123A7) {
    var_6 = scripts\engine\utility::array_randomize(level.players);
    var_7 = [];
    var_8 = [];
    level.create_digit_models = [];

    for(var_9 = 0; var_9 < var_0; var_9++) {
      var_10 = undefined;

      foreach(var_12 in var_6) {
        var_8 = var_12;

        if(!isDefined(var_12) || !scripts\mp\utility\player::isreallyalive(var_12)) {
          continue;
        }

        if(do_func(var_12, var_7, var_1 * 3)) {
          var_10 = do_spawn_vo_callout(var_12.origin, var_1);
          var_7 = var_12;
          break;
        }
      }

      foreach(var_15 in var_8) {
        var_6 = scripts\engine\utility::array_remove(var_6, var_15);
      }

      var_8 = [];

      if(isDefined(var_10)) {
        if(getdvarint("scr_randomBombardment_clusterStrike", 0)) {
          thread dropbrprimaryweapons(level, var_10, undefined);
        }

        if(getdvarint("scr_randomBombardment_clusterBombs", 0)) {
          thread do_convoy_moving_vo(level, var_5, var_10);
        }
      }
    }

    LOC_0000016e:
      var_17 = randomintrange(var_2, var_3);
    wait var_17;
  }
}

function do_func(var_0, var_1, var_2) {
  var_3 = var_2 * var_2;

  foreach(var_5 in var_1) {
    if(var_0 == var_5) {
      return false;
    }

    if(distance2dsquared(var_0.origin, var_5.origin) < var_3) {
      return false;
    }
  }

  return true;
}

function do_convoy_moving_vo(var_0, var_1, var_2) {
  level endon("game_ended");
  wait var_2;
  level thread _hidesafecircleui::chase(var_0, var_1);
}

function dropbrkillstreak(var_0, var_1, var_2) {
  level.ref_142D1 = var_0;

  if(istrue(var_2)) {
    return;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  foreach(var_4 in level.players) {
    var_4 visionsetnakedforplayer(var_0, var_1);
  }
}

function dropcratefrommanualheli_cp() {
  level endon("game_ended");
  dropbrkillstreak("mp_don4_outro_shadow_lep", 10);
}

function drop_locations(var_0, var_1) {
  if(var_0 == "bink_complete") {
    self notify("bink_complete");
    return;
  }
}

function dont_shoot_parachutes() {
  level endon("game_ended");
  level.weapon_xp_iw8_ar_falima = spawnStruct();
  var_0 = 225;
  var_1 = getgroundposition(level.weapon_xp_iw8_ar_golf36, 1);
  scripts\mp\gametypes\br_publicevents::ref_13371("br_lep_exfil_incoming");
  wait 20;
  scripts\mp\gametypes\br_publicevents::ref_13371("br_lep_exfil_online");

  foreach(var_3 in level.players) {
    var_3 scripts\mp\utility\lower_message::setlowermessageomnvar(83, undefined, 10);
  }

  level thread scripts\mp\gametypes\br_public::brleaderdialog("exfil_ready", undefined, undefined, 1);
  wait 3;
  level.weapon_xp_iw8_ar_falima.trigger = spawn("trigger_radius", var_1, 0, int(var_0), int(level.defend_wave_3));
  var_5 = scripts\mp\gametypes\obj_dom::setupobjective(level.weapon_xp_iw8_ar_falima.trigger, "neutral");
  var_5.flagmodel setModel("x2_military_old_recon_station");
  var_5.onuse = &domtablet_init;
  var_5.onbeginuse = &domflag_showicontoplayer;
  var_5.onuseupdate = &donetsksubmap;
  var_5.onenduse = &domflagupdateiconsframeend;
  var_5.oncontested = &domflag_usecondition;
  var_5.onuncontested = &domlocale_onrespawn;
  var_5.onunoccupied = &domoralesnags;
  var_5.onpinnedstate = &domgulagsounds;
  var_5.onunpinnedstate = &domplatecapturetime;
  var_5.ref_138B2 = &domlocale_onentergulag;
  var_5.stompprogressreward = &dont_update_volume;
  var_5.gate_swings_open = 1;
  var_5.id = "domFlag";
  var_5.pinobj = 0;
  var_5.lockupdatingicons = 1;
  var_5 scripts\mp\gameobjects::setcapturebehavior("persistent");
  var_5 scripts\mp\gameobjects::setusetime(60);
  dontclose(var_5);
  playencryptedcinematicforall(var_5.objidnum, 1);
  level.weapon_xp_iw8_ar_falima.oil_puddles = var_5;
  level.objectivescaler = 1;

  foreach(var_3 in level.players) {
    var_3 setclientomnvar("ui_securing", 17);
    var_3 setclientomnvar("ui_securing_progress", 0);
  }
}

function dont_disable(var_0) {
  foreach(var_2 in level.players) {
    if(isDefined(var_2) && isDefined(var_2.team)) {
      if(var_2.team == var_0) {
        var_2 setclientomnvar("ui_securing", 18);
        continue;
      }

      var_2 setclientomnvar("ui_securing", 19);
    }
  }
}

function dont_kill_off_old(var_0) {
  if(var_0 == "contested") {
    self setclientomnvar("ui_securing", 20);
    return;
  }

  if(var_0 == "friendly") {
    self setclientomnvar("ui_securing", 18);
    return;
  }

  self setclientomnvar("ui_securing", 19);
}

function dontcallpostplunder(var_0) {
  foreach(var_2 in level.players) {
    if(isDefined(var_2) && !istrue(var_2.usedprops) && !istrue(var_2.beingrevived)) {
      var_2 setclientomnvar("ui_securing_progress", var_0);
    }
  }
}

function domflag_onbeginuse(var_0) {
  self notify("exfil_newOwnerFeedback");
  self endon("exfil_newOwnerFeedback");

  if(isPlayer(var_0)) {
    var_1 = var_0.team;
  } else {
    var_1 = var_1;
  }

  foreach(var_3 in level.players) {
    if(isDefined(var_3) && isDefined(var_1)) {
      if(var_3.team == var_1) {
        thread dont_kill_off_old(var_3);
        var_3 thread scripts\mp\hud_message::showsplash("br_lep_friendly_team_exfil");
        continue;
      }

      thread dont_kill_off_old(var_3);
      var_3 thread scripts\mp\hud_message::showsplash("br_lep_enemy_team_exfil");
    }
  }
}

function domtablet_init(var_0) {
  var_1 = var_0.team;
  self.capturetime = gettime();
  self.get_current_bush_zone = 1;

  if(self.touchlist[var_1].size == 0 && isDefined(self.oldtouchlist)) {
    self.touchlist = self.oldtouchlist;
  }

  drop_usb_stick(var_1, "lep_chall_success", "exfil_enemy_win");
  dontcallpostplunder(1);
  thread domflag_hideiconfromplayer(var_1);
}

function domflag_showicontoplayer(var_0) {
  if(!isDefined(self.ref_11F63) || !self.ref_11F63) {
    self.ref_11F63 = 1;
    thread domflag_onbeginuse(var_0);
    var_1 = scripts\mp\utility\teams::getfriendlyplayers(var_0.team, 0);

    foreach(var_3 in var_1) {
      var_3 notify("calloutmarkerping_warzoneKillQuestIcon");
    }

    return;
  }
}

function donetsksubmap(var_0, var_1, var_2, var_3) {
  if(var_1 < 1 && !level.gameended && !istrue(self.get_current_bush_zone)) {
    dontcallpostplunder(var_1);
    donotwatchabandoned(var_1, var_0);
  }

  if(var_1 > 0.05 && var_2 && !istrue(self.didstatusnotify)) {
    self.didstatusnotify = 1;
  }

  if(self.gate_swings_open && var_1 > 0.5) {
    self.gate_swings_open = 0;
    drop_usb_stick(var_0, "exfil_friendly_50", "exfil_enemy_50");
    return;
  }
}

function domflagupdateiconsframeend(var_0, var_1, var_2) {
  scripts\mp\gametypes\obj_dom::dompoint_onuseend(var_0, var_1, var_2);
}

function domflag_usecondition() {
  scripts\mp\gameobjects::setobjectivestatusicons("waypoint_contested");
  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, undefined);
  level thread scripts\mp\gametypes\br_public::brleaderdialog("exfil_contested", undefined, undefined, 1);
  var_0 = scripts\mp\gameobjects::getownerteam();

  foreach(var_2 in level.players) {
    if(isDefined(var_2) && isDefined(var_0)) {
      thread dont_kill_off_old(var_2);
    }
  }
}

function domlocale_onrespawn(var_0) {
  var_1 = scripts\mp\gameobjects::getownerteam();
  var_2 = undefined;
  var_3 = domassairetreat();

  if(var_3 <= 1) {
    foreach(var_5 in level.teamnamelist) {
      var_6 = self.teamprogress[var_5];

      if(var_6 > 0) {
        var_2 = var_5;
        break;
      }
    }

    if(isDefined(var_2)) {
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, var_2);
      dont_disable(var_2);
    } else if(var_1 != "neutral") {
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, var_1);
    } else if(var_0 != "none") {
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, var_0);
    }

    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_capture");

    if(var_0 == "none" || var_1 == "neutral") {
      self.didstatusnotify = 0;
      return;
    }

    return;
  }
}

function domoralesnags() {
  var_0 = scripts\mp\gameobjects::getownerteam();

  if(var_0 == "neutral") {
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_captureneutral");
  } else {
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_capture");
  }

  self.didstatusnotify = 0;
}

function domgulagsounds(var_0) {
  if(self.ownerteam != "neutral" && self.numtouching[self.ownerteam] && !self.stalemate) {
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defending", "waypoint_capture");
    return;
  }
}

function domplatecapturetime(var_0) {
  if(self.ownerteam != "neutral" && !self.numtouching[self.ownerteam] && !self.stalemate) {
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_capture");
    return;
  }
}

function domlocale_onentergulag(var_0) {
  var_1 = scripts\mp\utility\teams::getenemyteams(var_0);
  var_2 = undefined;

  foreach(var_4 in var_1) {
    var_5 = self.teamprogress[var_4];

    if(var_5 > 0) {
      var_2 = var_5 / self.usetime;
    }
  }

  if(isDefined(var_2)) {
    dontcallpostplunder(var_2);
    var_7 = level.frameduration * self.userate / self.usetime;

    if(var_2 <= var_7) {
      thread domflag_onbeginuse(self.claimteam);
    }

    if(!self.gate_swings_open && var_2 < 0.4) {
      self.gate_swings_open = 1;
      return;
    }

    return;
  }
}

function dont_update_volume(var_0) {
  var_0 thread scripts\mp\utility\points::giveunifiedpoints("obj_prog_defend");
  scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defending", "waypoint_capture");

  if(isDefined(self.lastprogressteam)) {
    thread domflag_onbeginuse(var_0);
    self.lastprogressteam = undefined;
    return;
  }
}

function donotwatchabandoned(var_0, var_1) {
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

function domflag_hideiconfromplayer(var_0) {
  var_1 = getarraykeys(level.teamdata);
  var_2 = [];

  foreach(var_4 in var_1) {
    if(var_4 == var_0) {
      continue;
    }

    if(level.teamdata[var_4]["aliveCount"] > 0) {
      var_2 = var_4;
    }
  }

  var_6 = scripts\mp\utility\script::quicksort(var_2, &dropbrsuper);

  for(var_7 = 0; var_7 < var_6.size; var_7++) {
    var_4 = var_6[var_7];
    var_8 = var_7 + 2;
    thread scripts\mp\gametypes\br::ref_1209B(var_4, var_8, 0, 1);
  }

  waitframe();

  if(istrue(level.ref_13DC0)) {
    return;
  }

  level.ref_13DC0 = 1;
  level.ref_145C1 = 1;
  level thread scripts\mp\gamelogic::endgame(var_0, game["end_reason"]["objective_completed"], undefined, undefined, undefined, 1);
}

function dropbrsuper(var_0, var_1) {
  var_2 = getteamscore(var_0);
  var_3 = getteamscore(var_1);
  return var_2 >= var_3;
}

function domassairetreat() {
  var_0 = 0;

  foreach(var_2 in self.numtouching) {
    if(var_2 > 0 && (!isstring(var_3) || var_3 != "none")) {
      var_0++;
    }
  }

  return var_0;
}

function dontclose() {
  scripts\mp\objidpoolmanager::update_objective_setneutrallabel(self.objidnum, "BR_LEP_EVENT/BUNKER_EXFIL");
}

function doorstate() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  var_0 = scripts\engine\utility::array_removeundefined(level.players);

  foreach(var_2 in var_0) {
    var_2 scripts\cp\vehicles\vehicle_compass_cp::ref_120A4("lep_dis_1");
  }
}

function dopunishhelivocalls(var_0) {
  foreach(var_2 in var_0) {
    var_2 scripts\cp\vehicles\vehicle_compass_cp::ref_120A4("lep_dis_3");
  }
}

function doors_opened_music(var_0) {
  scripts\cp\vehicles\vehicle_compass_cp::ref_120A4(var_0);
}

function draw_debug_sphere(var_0) {
  return self getplayerdata("mp", "missionComplete", var_0);
}

function door_set_frozen() {
  var_0 = scripts\engine\utility::array_removeundefined(level.players);
  return scripts\mp\gametypes\br_ending::get_center_of_array(var_0);
}

function drop_usb_stick(var_0, var_1, var_2) {
  foreach(var_4 in level.teamnamelist) {
    if(var_4 == var_0) {
      level thread scripts\mp\gametypes\br_public::dmztut_luicallback(var_1, var_4, undefined, undefined, undefined, 1);
      continue;
    }

    level thread scripts\mp\gametypes\br_public::dmztut_luicallback(var_2, var_4, undefined, undefined, undefined, 1);
  }
}

function doesstreakinfomatchequippedstreak(var_0) {
  level waittill("game_ended");

  if(isDefined(var_0)) {
    var_0 delete();
    return;
  }
}

function doteleporttosafehouse() {
  level endon("game_ended");

  foreach(var_1 in level.players) {
    var_1 setsoundsubmix("br_lep_amb_1");
  }

  var_3 = spawn("script_model", (0, 0, 500));
  var_3 setModel("lep_sfx");
  waitframe();
  var_3 setscriptablepartstate("sfx", "attack_state_01");
  level.weapon_xp_iw8_la_rpapa7 = var_3;
  var_3 = spawn("script_model", (0, 0, 500));
  var_3 setModel("lep_sfx");
  waitframe();
  var_3 setscriptablepartstate("sfx", "base");
  level.weapon_xp_iw8_lm_kilo121 = var_3;

  foreach(var_1 in level.players) {
    var_1 clearsoundsubmix("br_lep_amb_1", 5);
  }
}

function do_manual_splash_damage_when_frag_explodes() {
  level.weapon_xp_iw8_lm_kilo121 setscriptablepartstate("sfx", "attack_state_02");

  foreach(var_1 in level.players) {
    var_1 setsoundsubmix("br_lep_amb_2");
    var_1 setsoundsubmix("br_lep_amb_1", 5);
    var_1 clearsoundsubmix("br_lep_amb_2", 5);
  }

  wait 5;
  level.weapon_xp_iw8_la_rpapa7 setscriptablepartstate("sfx", "base");
}

function do_not_unload() {
  level.weapon_xp_iw8_la_rpapa7 setscriptablepartstate("sfx", "attack_state_03");

  foreach(var_1 in level.players) {
    var_1 setsoundsubmix("br_lep_amb_2", 5);
    var_1 clearsoundsubmix("br_lep_amb_1", 5);
  }

  wait 5;
  level.weapon_xp_iw8_lm_kilo121 setscriptablepartstate("sfx", "base");
}

function dom() {
  if(isDefined(level.endmusicplayed)) {
    return;
  }

  var_0 = scripts\mp\gamescore::run_common_functions_stealth();
  level.endmusicplayed = 1;

  foreach(var_2 in level.players) {
    var_3 = var_0[var_2.team];

    if(var_3 <= 10) {
      var_2 setplayermusicstate("br_lep_victory");
    } else {
      var_2 setplayermusicstate("br_plunder_defeat");
    }

    var_2 setsoundsubmix("mp_matchend_music", 2);
    var_2 enableplayerbreathsystem(0);
  }
}