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
  level.ref_13bd1 = &helidrivabledeathall;
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
  scripts\mp\gametypes\br_gametypes::ref_12b11("onPlayerConnect", &drop_new_carepackage);
  scripts\mp\gametypes\br_gametypes::ref_12b11("onInfilSequenceEnd", &dorpgambushvo);
  scripts\mp\gametypes\br_gametypes::ref_12b11("mapCenterFinalCircle", &drop_platform);
  scripts\mp\gametypes\br_gametypes::ref_12b11("getFinalCircleCenter", &drop_platform);
  scripts\mp\gametypes\br_gametypes::ref_12b11("preCalcSafeCircleCenters", &dropaccesscard);
  scripts\mp\gametypes\br_gametypes::ref_12b11("playerWelcomeSplashes", &drop_support_crate_intro);
  scripts\mp\gametypes\br_gametypes::ref_12b11("onContractEnd", &drop_max);
  scripts\mp\gametypes\br_gametypes::ref_12b11("playerKilledSpawn", &drop_support_crates);
  scripts\mp\gametypes\br_gametypes::ref_12b11("onLastStandEnter", &drop_minigun);
  waittillframeend();
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "dangerNotifyPlayersInRange", &doarmsracelocationnags);
  doapcdamagevo();
  level.delete_players_black_screen = &drop_weapon_scripted;
  level.disable_back_light = 1;
  downangles();
  level.ref_140d9 = [];
  level.ref_123ab = spawnStruct();
  level.ref_123ab.player_fov_default_1 = [];
  level.ref_123ab.audio_player_spawn_mud_loop = [];
  level.ref_123ab.audio_player_start_mud_loop = [];
  level.ref_123ab.ref_11b1b = [];

  switch (level.mapname) {
    case "mp_br_mechanics":
      download_progress();
      thread dropped_weapon();
      break;
    case "mp_don4":
      level.ref_123ab.ref_12f8b = [];
      level.ref_123ab.ref_13b2e = [];
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

  foreach(var1 in level.weapon_should_not_get_ammo) {
    var2 = 1;
    var3 = var1;

    foreach(var5 in level.weapon_pick_up_monitor[var7]) {
      var2++;
      var3 += var5;
    }

    var3 /= var2;
    level.weapon_class[var7] = var3;
  }

  var8 = scripts\engine\utility::array_randomize([0, 1, 2]);
  level.weapon_xp_iw8_ar_kilo433 = var8[0];
  level.weapon_xp_iw8_ar_golf36 = level.weapon_should_not_get_ammo[level.weapon_xp_iw8_ar_kilo433];

  if(var8[0] != 1 && var8[1] != 1) {
    GscBinSkip0(0x2e, 2, var8[1]);
  }

  level.weapon_box_cache_use = var8;
}

function doapcdamagevo() {
  scripts\cp_mp\utility\game_utility::ref_12c10("delete_on_load", "targetname");
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
  var0 = "mp/br_lep_dis_locations.csv";
  var1 = int(tablelookuprownum(var0, 0, "1"));

  if(tablelookupbyrow(var0, var1, 0) == "1") {
    var2 = [];
    GscBinSkip0(0x2e, 0, (int(tablelookupbyrow(var0, var1, 1)), int(tablelookupbyrow(var0, var1, 2)), int(tablelookupbyrow(var0, var1, 3))));
  }

  level.weapon_xp_iw8_ar_golf36 = (-265, -4121, 58);
}

function downtown_gw_ambient_sound_load() {
  var0 = "mp/br_lep_dis_locations.csv";
  var1 = level.br_level.default_class_chosen[3];
  var2 = level.br_level.br_circleradii[3];
  var3 = 0;

  if(tablelookupbyrow(var0, var3, 0) == "0") {
    var4 = [];
    GscBinSkip0(0x2e, 0, (int(tablelookupbyrow(var0, var3, 1)), int(tablelookupbyrow(var0, var3, 2)), int(tablelookupbyrow(var0, var3, 3))));
  }

  var3 = int(tablelookuprownum(var0, 0, "2"));

  if(tablelookupbyrow(var0, var3, 0) == "2") {
    var4 = [];
    GscBinSkip0(0x2e, 0, (int(tablelookupbyrow(var0, var3, 1)), int(tablelookupbyrow(var0, var3, 2)), int(tablelookupbyrow(var0, var3, 3))));
  }

  for(var3 = 0; tablelookupbyrow(var0, var3, 7) != ""; var3++) {
    do_cache_2_prep(int(tablelookupbyrow(var0, var3, 7)), int(tablelookupbyrow(var0, var3, 8)));
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

function dropbrlootchoppercrate(var0, var1, var2, var3) {
  level.waypointcolors[var0] = var1;
  level.waypointbgtype[var0] = 1;
  level.waypointstring[var0] = var2;
  level.waypointshader[var0] = "ui_mp_br_mapmenu_icon_gulag_overtime_objective";
  level.waypointpulses[var0] = var3;
}

function downtown_helicopter_start() {
  var0 = [["brloot_killstreak_assaultdrone", 1], ["brloot_offhand_decoy", 1], ["brloot_offhand_frag", 1], ["brloot_offhand_semtex", 1], ["brloot_offhand_snapshot", 1], ["brloot_killstreak_recondrone", 1], ["brloot_super_deadsilence", 1]];
  var1 = 0;
  level.weapon_xp_iw8_ar_sierra552 = spawnStruct();
  level.weapon_xp_iw8_ar_sierra552.itemlist = [];

  foreach(var3 in var0) {
    var4 = var3[1];
    var1 += var4;
    var5 = spawnStruct();
    var5.name = var3[0];
    var5.ref_12d81 = var1;
    level.weapon_xp_iw8_ar_sierra552.itemlist[level.weapon_xp_iw8_ar_sierra552.itemlist.size] = var5;
  }

  level.weapon_xp_iw8_ar_sierra552.ref_13bf6 = var1;
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
  level.ref_13b41 = "vfx_br_lep_bomber_exp";
  level.ref_13b46 = getdvarfloat("scr_threat_max_radius_strikes_around_player", 500);
  level.ref_13b47 = getdvarfloat("scr_threat_min_radius_strikes_around_player", 10);
  level.ref_13b45 = getdvarint("scr_threat_explosion_per_strikes", 1);
  level.ref_13b48 = getdvarfloat("scr_threat_thickness_radius_strikes_around_player", 10);
  level.ref_13b43 = getdvarfloat("scr_threat_delay_between_strikes", 0.3);
  level.ref_13b49 = getdvarfloat("scr_threat_varied_delay_between_strikes", 0.5);
  level.ref_13b44 = getdvarint("scr_threat_explosion_damage", 0);
}

function downangles() {
  level.multieventdebug = spawnStruct();
  level.multieventdebug.ref_142af = "mp_lep_end";
  level.multieventdebug.ref_142ae = 76;
  level.multieventdebug.unmarkplayeraseliminated = 1;
}

function drop_new_carepackage(var0) {
  thread dropbrlootchoppercrateforpublicevent(level);
}

function dropbrlootchoppercrateforpublicevent(var0) {
  level endon("game_ended");
  var0 endon("disconnect");
  var0 waittill("spawned_player");

  if(isDefined(level.ref_142d1)) {
    var0 visionsetnakedforplayer(level.ref_142d1, 0);
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
  for(var0 = 6; var0 > 3; var0--) {
    do_exfil_vo(1, var0);
  }

  for(var0 = 3; var0 > 1; var0--) {
    do_exfil_vo(2, var0);
  }

  for(var0 = 1; var0 >= 0; var0--) {
    do_exfil_vo(3, var0);
  }
}

function doorisclosed(var0) {
  var1 = [];

  if(isDefined(var0) && var0 != "tie") {
    var1 = scripts\mp\utility\teams::getteamdata(var0, "players");
  }

  return var1;
}

function drop_weapon_scripted(var0) {
  thread dopunishhelivocalls(doorisclosed(var0));
  thread dom();
  var1 = dontspawnjeep();

  foreach(var3 in level.players) {
    if(isDefined(var3)) {
      var3 scripts\mp\utility\player::_freezecontrols(1);
      var3 calloutmarkerping_getinventoryslot(0);
      var3 scripts\mp\gametypes\br_public::ref_126b9(var1.origin);
    }
  }

  wait 8;

  foreach(var3 in level.players) {
    if(isDefined(var3)) {
      if(scripts\mp\utility\player::unset_relic_trex(var3)) {
        var3 scripts\mp\laststand::playanim_aibegindismountturret("self_revive_success", var3);
      }

      var3 setclientomnvar("ui_br_end_game_splash_type", 0);
      var3 setclientomnvar("ui_br_squad_eliminated_active", 0);
      var3.plotarmor = 1;
      var3 thread scripts\mp\gametypes\br_gulag::gulagfadetoblack(1);
    }
  }

  wait 1;
  dorestartvo();
  thread dropbrhealthpack();
  thread doleaderinterrogationnag();

  foreach(var3 in level.players) {
    if(isDefined(var3)) {
      var3 thread scripts\mp\playerlogic::spawnintermission(var1, undefined, 0);
    }
  }

  wait 1.5;
  dropbrkillstreak("mp_don4_lep_end", 0);

  foreach(var3 in level.players) {
    if(isDefined(var3)) {
      var3 thread scripts\mp\gametypes\br_gulag::gulagfadefromblack();
    }
  }

  wait 2;
  setomnvarforallclients("post_game_state", 15);
  wait 8;
}

function drop_max(var0) {
  if(getdvarint("scr_lep_show_plane_icon_after_contract", 0) > 0) {
    foreach(var2 in level.ref_123ab.audio_player_spawn_mud_loop) {
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var2, self);
    }

    level.ref_123ab.ref_11b1b = scripts\engine\utility::array_remove(level.ref_123ab.ref_11b1b, self);
    return;
  }

  if(!istrue(self.highlighttoteam)) {
    foreach(var2 in level.ref_123ab.audio_player_spawn_mud_loop) {
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var2, self);
    }

    foreach(var2 in level.ref_123ab.audio_player_start_mud_loop) {
      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var2, self);
    }

    level.ref_123ab.ref_11b1b = scripts\engine\utility::array_remove(level.ref_123ab.ref_11b1b, self);
    return;
  }
}

function drop_support_crates(var0, var1) {
  level endon("game_ended");
  self endon("disconnect");
  thread drop_type();
  return undefined;
}

function drop_type() {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("forcePlayerSpectateTarget");

  if(isDefined(level.ref_142d1)) {
    self visionsetnakedforplayer(level.ref_142d1, 0);
  }

  self waittill("spawned_player");

  if(isDefined(level.ref_142d1)) {
    self visionsetnakedforplayer(level.ref_142d1, 0);
    return;
  }
}

function dontspawnjeep() {
  var0 = spawnStruct();
  var0.origin = (-13871, -22965, 1193);
  var0.angles = (358, 59, 0);
  return var0;
}

function dorestartvo() {
  if(level.mapname == "mp_br_mechanics") {
    return;
  }

  var0 = level.br_circle.circleindex;
  scripts\mp\gametypes\br_circle::spawn_carriable_at_struct();

  if(level.br_level.default_suicidebomber_combat[var0] > 0) {
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
  var0 = spawn("script_origin", (0, 0, 0));

  for(;;) {
    thread dropbrweapon(level);
    wait 13.5;
  }
}

function extractlocale_createquestlocale(var0) {
  var1 = spawn("script_origin", (0, 0, 0));
  var1.origin = var0;
  var2 = getanimlength(%veh_wz_usa_bomber_b17_ending01);

  for(var3 = 0; var3 < 4; var3++) {
    var4 = 13.5 * var3 / var2;
    thread dropbrweapon(var1, var4);
  }

  scripts\engine\utility::ref_143bf(var2, "stop_planes");
  var1 delete();
}

function dropbrweapon(var0, var1) {
  var2 = dropbrsuperfulton("outroFirstSet");
  var3 = dropbrsuperfulton("outroSecondSet");
  var4 = [var2, var3];
  var5 = getanimlength(%veh_wz_usa_bomber_b17_ending01);
  var0 thread scripts\common\anim::anim_single(var4, "beauty_shot");

  if(isDefined(var1)) {
    var0 scripts\engine\utility::delaythread(0.05, &scripts\common\anim::anim_set_time, var4, "beauty_shot", var1);
    var5 -= var1 * var5;
  }

  scripts\engine\utility::ref_143bf(var5, "stop_planes");
  var2 delete();
  var3 delete();
}

function dropbrsuperfulton(var0) {
  var1 = spawn("script_model", (0, 0, 0));
  var1 setModel("wz_usa_bomber_b17_phase05");
  var1.animname = var0;
  var1 useanimtree(level.scr_animtree[var0]);
  return var1;
}

function doleaderinterrogationnag() {
  level endon("game_ended");
  level.ref_13b41 = "vfx_br_lep_bomber_exp_end";
  level.ref_13b46 = 12000;
  level.ref_13b47 = 4000;
  level.ref_13b45 = 10;
  level.ref_13b48 = 4000;
  level.ref_13b43 = 0.1;
  var0 = 11.5;

  for(;;) {
    level thread _hidesafecircleui::chase(var0, (-6937, -15094, 2876), 1);
    wait var0;
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
  var0 = 1;

  while(var0) {
    var1 = scripts\engine\utility::ref_143b0("stopped_self_revive", "last_stand_finished", "use_hold_think_fail", "last_stand_revived", "death_or_disconnect");
    thread dropbrgasmask(self);

    if(isDefined(self.laststandreviveent)) {
      thread dropbrgasmask(self.laststandreviveent.reviver);
    }

    switch (var1) {
      case "last_stand_revived":
      case "last_stand_finished":
      case "death":
        var0 = 0;
        break;
      case "use_hold_think_fail":
      case "stopped_self_revive":
      default:
        break;
    }
  }
}

function dropbrgasmask(var0) {
  if(isDefined(var0)) {
    waitframe();
    var1 = level.weapon_xp_iw8_ar_falima.oil_puddles;

    if(var1.claimteam == "none" && !isDefined(var1.lastprogressteam)) {
      var0 setclientomnvar("ui_securing", 17);
    } else if(istrue(var1.stalemate)) {
      var0 setclientomnvar("ui_securing", 20);
    } else if(var0.team == var1.lastprogressteam) {
      var0 setclientomnvar("ui_securing", 18);
    } else {
      var0 setclientomnvar("ui_securing", 19);
    }

    var2 = 0;

    if(isDefined(var1.lastprogressteam)) {
      var2 = var1.teamprogress[var1.lastprogressteam] / var1.usetime;
    }

    var0 setclientomnvar("ui_securing_progress", var2);
    return;
  }
}

function do_exfil_vo(var0, var1) {
  if(var0 > 0) {
    var2 = level.weapon_class[level.weapon_box_cache_use[0]];

    for(var3 = 1; var3 < var0; var3++) {
      var2 += level.weapon_class[level.weapon_box_cache_use[var3]];
    }

    var2 /= var0;
    var4 = 0;

    for(var3 = 0; var3 < var0; var3++) {
      var5 = [level.weapon_should_not_get_ammo[level.weapon_box_cache_use[var3]]];

      foreach(var7 in level.weapon_pick_up_monitor[level.weapon_box_cache_use[var3]]) {
        var5 = scripts\engine\utility::array_add(var5, var7);
      }

      foreach(var10 in var5) {
        var11 = distance2d(var2, var10);

        if(var11 > var4) {
          var4 = var11;
        }
      }
    }

    var13 = var1 + 1;
    var14 = var2 - level.br_level.default_class_chosen[var13];
    var15 = length2d(var14);
    var16 = var15 + level.br_level.br_circleradii[var13];
    var17 = max(var4, var16);
    var18 = level.br_level.br_circleradii[var1];

    if(var18 < var17) {
      var19 = 1 - var18 / var16;
      var20 = var14 * var16 / var15;
      level.br_level.default_class_chosen[var1] = var2 - var20 * var19;
      return;
    }

    var21 = var18 - var17;
    var22 = var21 / var18;
    level.br_level.default_class_chosen[var1] = scripts\mp\gametypes\br_circle::getrandompointincircle(var2, var18, var22, var22);
    return;
  }

  var2 = level.weapon_xp_iw8_ar_golf36;
}

function door_is_frozen(var0) {
  var1 = 0;

  foreach(var3 in level.weapon_should_not_get_ammo) {
    var4 = level.br_level.default_class_chosen[var0];
    var5 = level.br_level.br_circleradii[var0];

    if(scripts\engine\utility::updatescrapassistdata(var3, var4, var5)) {
      var1++;
    }
  }

  return var1;
}

function double_wood_stack() {
  level endon("game_ended");
  var0 = getdvarint("scr_br_lep_challenge_enable", 0);

  if(!var0) {
    return;
  }

  game["dialog"]["lep_item_near"] = "item_near";
  game["dialog"]["lep_item_interact"] = "item_interact";
  game["dialog"]["lep_chall_completed"] = "challenge_complete";
  level.weapon_xp_iw8_lm_mgolf34 = [];
  level waittill("br_prematchEnded");
  var1 = "mp/br_lep_cha_locations.csv";
  var2 = 0;
  var3 = [];
  GscBinSkip0(0x2e, 0, ["furniture_ping_pong_paddle_01_ch3", 1]);
}

function droppoint(var0, var1, var2, var3, var4, var5) {
  var6 = randomintrange(0, var1.size);
  var7 = var1[var6];
  var8 = var3[var6];
  var9 = var2[var6];
  var10 = spawn("script_model", var7);
  var10.angles = var8;
  var10 setModel(var0);
  var10.weapon_xp_iw8_lm_lima86 = var4;
  var10.useprompt = scripts\mp\gameobjects::createhintobject(var10.origin + var9, "HINT_BUTTON", undefined, &"MP_BR_INGAME/COLLECT_INTEL", undefined, undefined, undefined, 480, 90, 72, 90);
  dohudplunderpulse(var10.useprompt, var4);
  thread do_hack_sequence(var10.useprompt, var4, var5);
  return var10;
}

function dohudplunderpulse(var0) {
  var1 = "iw8_s4_ch_common_season_65_wz_event_challenge_" + var0;

  foreach(var3 in level.players) {
    if(isDefined(var3) && draw_debug_sphere(var3, var1)) {
      self disableplayeruse(var3);
      self hidefromplayer(var3);
    }
  }
}

function do_hack_sequence(var0, var1, var2) {
  level endon("game_ended");

  for(;;) {
    var0 waittill("trigger", var3);
    thread do_heli_takeoff_vo(var3, var1);
  }
}

function do_heli_takeoff_vo(var0, var1) {
  var2 = self;
  var2 playsoundtoplayer("ui_intel_interact", var2);
  thread do_ghost_skit();
  thread dobreakeractivation();
  thread do_laser_panel_anim_sequence(var2, var0);

  foreach(var4 in level.weapon_xp_iw8_lm_mgolf34) {
    var4.useprompt disableplayeruse(var2);
    var4.useprompt hidefromplayer(var2);
  }

  wait 0.25;
  var2 scripts\mp\hud_message::showsplash("br_lep_challenge_started", var1);
  thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("lep_item_interact", var2, 1, 0, 3);
}

function dropbrcustompickupitem() {
  self endon("disconnect");
  level endon("game_ended");
  dropbrmissiontablet(0);
  self waittill("spawned");

  foreach(var1 in level.weapon_xp_iw8_lm_mgolf34) {
    var1.useprompt enableplayeruse(self);
    var1.useprompt showtoplayer(self);
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
  level waittill("game_ended", var0);

  if(isDefined(var0) && var0 != "tie") {
    var1 = scripts\mp\utility\teams::getteamdata(var0, "players");

    foreach(var3 in var1) {
      if(var3 == self) {
        thread do_kidnapping_anims(var3);
      }
    }

    return;
  }
}

function do_laser_panel_anim_sequence(var0, var1) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  self notify("br_lep_challenge_started");
  dropbrmissiontablet(var0);
  _calloutmarkerping_handleluinotify_added::ref_1313e("ui_br_lep_data_client", 3, 3, var1);
  var2 = level.br_circle.circleindex;

  while(level.br_circle.circleindex < var2 + var1) {
    level waittill("br_circle_set", var3);
    var4 = var2 + var1 - var3 + 1;

    if(var4 > 0) {
      _calloutmarkerping_handleluinotify_added::ref_1313e("ui_br_lep_data_client", 3, 3, var4);
    }
  }

  thread do_kidnapping_anims(5);
}

function do_kidnapping_anims(var0) {
  self endon("disconnect");
  self notify("br_lep_challenge_completed");
  doors_opened_music("lep_intel_" + self.weapon_xp_iw8_lm_lima86);

  if(var0 && var0 > 0) {
    wait var0;
  }

  _calloutmarkerping_handleluinotify_added::ref_1313e("ui_br_lep_data_client", 3, 3, 0);
  scripts\mp\hud_message::showsplash("br_lep_challenge_completed", self.weapon_xp_iw8_lm_lima86);
  thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("lep_chall_completed", self, 1, 0, 3);
}

function dropbrmissiontablet(var0) {
  self.weapon_xp_iw8_lm_lima86 = var0;
  _calloutmarkerping_handleluinotify_added::ref_1313e("ui_br_lep_data_client", 0, 3, var0);
}

function drop_jugg_crate() {
  self endon("disconnect");
  self endon("br_lep_challenge_started");

  for(;;) {
    var0 = incrementpersistentstat(level.weapon_xp_iw8_lm_mgolf34, self.origin, 400);

    if(var0.size > 0) {
      var1 = scripts\engine\utility::array_get_first_item(var0);

      if(isDefined(var1) && draw_debug_sphere("iw8_s4_ch_common_season_65_wz_event_challenge_" + var1.weapon_xp_iw8_lm_lima86)) {
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

function dogtag_collected_lap(var0) {
  dogtag_visibility_watcher((-37834.2, 28261, 851.73), undefined, undefined, var0);
  dogtag_visibility_watcher((-38449.2, 27099, 1024.73), undefined, undefined, var0);
  dogtag_visibility_watcher((-38449.2, 25818, 1024.73), undefined, undefined, var0);
  dogtag_visibility_watcher((-37815.2, 26098, 532.73), undefined, undefined, var0);
  dogtag_visibility_watcher((-37607.2, 25237, 696.73), undefined, undefined, var0);
  dogtag_visibility_watcher((-37356.2, 26299, 476.73), undefined, undefined, var0);
  dogtag_visibility_watcher((-37618.2, 27497, 707.73), undefined, undefined, var0);
  dogtag_visibility_watcher((-38418.2, 26177, 1024.73), undefined, undefined, var0);
}

function dogtag_collected() {
  level endon("game_ended");
  level waittill("prematch_done");
  dogtag_collected_lap();
}

function dogtag_visibility_watcher(var0, var1, var2, var3) {
  var4 = 600;
  var5 = 350;

  if(!isDefined(var1)) {
    var1 = var4;
  }

  if(!isDefined(var2)) {
    var2 = var5;
  }

  scripts\mp\gametypes\br_quest_util::little_bird_mg_playercontrolmg(var0, var1, var2, var3);
}

function door2(var0, var1) {
  if(var0.size > 0) {
    if(istrue(var1)) {
      var2 = randomint(var0.size);
      return var0[var2];
    } else {
      var3 = [];

      foreach(var5 in var1) {
        var6 = scripts\common\utility::playersinsphere(var5.crashorigin, 3000);
        var5.numplayers = var6.size;
      }

      var3 = scripts\engine\utility::array_sort_with_func(var1, &doarmsraceopencachenags);

      if(var3[0].numplayers == 0) {
        var8 = door2(var1, 1);
        level.ref_12882 = var8.crashorigin;
        return var8;
      }

      var8 = door_anim(var4);
      level.ref_12882 = var8.crashorigin;
      return var8;
    }
  }

  return undefined;
}

function doarmsraceopencachenags(var0, var1) {
  return var0.numplayers > var1.numplayers;
}

function door_anim(var0) {
  if(isDefined(level.ref_12882)) {
    foreach(var2 in var0) {
      if(distance2dsquared(var2.crashorigin, level.ref_12882) > 100000000) {
        return var2;
      }
    }

    return var0[0];
  }

  return var3[0];
}

function dropangles(var0) {
  var1 = level.br_level.default_class_chosen[level.br_circle.circleindex + 1];
  var2 = level.br_level.br_circleradii[level.br_circle.circleindex + 1];

  foreach(var4 in level.ref_123ab.player_fov_default_1) {
    if(distance2d(var4.crashorigin, var1) > var2) {
      var4.forced_bleedout = 1;
      level.ref_123ab.player_fov_default_1 = scripts\engine\utility::array_remove(level.ref_123ab.player_fov_default_1, var4);
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
  level waittill("br_circle_set", var0);

  if(getdvarint("scr_lep_vision_set_extended_disabled", 0) == 0) {
    dropbrkillstreak("mp_don4_lep_circle_1", 10);
  }

  thread dohudplunderroll();
  wait 15;
  thread dokidnapsequence(level);
  thread dropbrselfrevivetoken(level, 5, 2363, 40, 60);
  level waittill("br_circle_started", var0);
  dropangles(var0);
  level waittill("br_circle_set", var0);

  if(getdvarint("scr_lep_vision_set_extended_disabled", 0) == 0) {
    dropbrkillstreak("mp_don4_lep_circle_2", 10);
  }

  thread dokidnapsequence(level);
  thread dropbrselfrevivetoken(level, 5, 2363, 40);
  level waittill("br_circle_started", var0);
  dropangles(var0);
  level waittill("br_circle_set", var0);

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

function dontspawncargotruck(var0) {}

function doingcheck(var0, var1) {
  var0.infil_chopper_path_flags_manager = 1;
  thread dointerrogationvo(level);
  return true;
}

function dointerrogationvo(var0) {
  var1 = var0.crashorigin;
  var2 = vectortoangles(var0.crashorigin - var0.spawnorigin);
  var3 = var0.infectsetradaronnumsurvivors;

  if(!isDefined(var0.infectsetradaronnumsurvivors)) {
    var3 = var2;
  }

  var4 = var0.spawnorigin;

  if(getdvarint("scr_lep_crash_plane_use_raytrace", 0) > 0) {
    var5 = (0, 0, 500);
    var6 = dropallunusableitems(var1 + var5, var1 - var5);
    var7 = var6["position"];
  } else {
    var7 = var2;
  }

  var8 = anglesToForward((0, var3[1], 0)) * -250;
  var9 = var7 + var8;
  dohudplunderrollsound(var1, var7, var9);
  var1.infil_chopper_path_flags_manager = 0;
  var1.forced_bleedout = 1;
  var10 = dropjuggbox(var7, var4);
  var10 radiusdamage(var7, 500, 1000, 50);
  var10 setscriptablepartstate("model", "crashed");
  playFX(level._effect["vfx_br_lep_ground_exp"], var7, anglesToForward((0, var3[1], 0)), (0, 0, 1));
  drone_turret_canseetarget(var10, var1.objid, var1.ref_11f93);
  thread dropped_weapon_cleanup_internal();
}

function dohudplunderrollsound(var0, var1, var2) {
  var3 = var2 - var1;
  var4 = vectortoangles(var3);
  var4 = (var4[2], var4[1] + 90, var4[0]);
  var5 = dropcpcratefromscriptedheli(var1, var4);
  var5 endon("death");
  waitframe();
  var5 setscriptablepartstate("model", "falling");
  var0.objid = drone_turrets(var5, 2000, 1, 1, 0, 0);
  var0.ref_11f93 = drone_turrets(var5, 2000, 1, 0, 0, 1);
  var6 = getdvarint("scr_br_lep_cache_speed", 3000);
  var7 = getdvarfloat("scr_br_lep_cache_accel", 0.75);
  var8 = distance(var1, var2);
  var9 = var8 / var6;
  var10 = var9 * var7;
  var5 moveTo(var2, var9, var10, 0.05);
  thread drop_priorities(level);
  wait var9;
  var5 setscriptablepartstate("model", "impact");
  drop_saw_think(var2);
  var5 notify("stop_plane_vehicle_crush");
  var5 notify("plane_crashed");
  var5 delete();
}

function dropcpcratefromscriptedheli(var0, var1) {
  var2 = spawn("script_model", var0);
  var2.angles = var1;
  var2 setModel("wz_usa_bomber_b17_destroyed_rig");
  var2 setscriptablepartstate("model", "explosion");
  return var2;
}

function dropjuggbox(var0, var1) {
  var2 = spawn("script_model", var0);
  var2.angles = var1;
  var2 setModel("usa_bomber_b17_hero_wing_combined_02");
  var2.enemy_is_visible = spawn("script_model", var0);
  var3 = getEnt("bomber_crash_assets_col", "targetname");

  if(isDefined(var3)) {
    var2.enemy_is_visible clonebrushmodeltoscriptmodel(var3);
    var2.enemy_is_visible linkTo(var2, "", (-86, -28, 40), (0, 0, 0));
  }

  var2.id = "care_package";
  var2.updatecirclepulse = 1;
  var2.angles = (0, var1[1], 0);
  return var2;
}

function drop_saw_think(var0) {
  var1 = scripts\engine\trace::sphere_trace_get_all_results(var0, var0, 60);

  foreach(var3 in var1) {
    var4 = var3["entity"];
    dropoff_sound_playervm_handler(var4, var0);
  }
}

function drop_priorities(var0) {
  var0 endon("death");
  var0 endon("stop_plane_vehicle_crush");

  for(;;) {
    var0 waittill("touch", var1);
    dropoff_sound_playervm_handler(var1, var0.origin);
  }
}

function dropoff_sound_playervm_handler(var0, var1) {
  if(!isDefined(var0) || !isalive(var0)) {
    return;
  }

  if(!var0 scripts\common\vehicle::isvehicle() && !isDefined(var0.classname)) {
    return;
  }

  if(var0.classname == "script_vehicle") {
    var0 dodamage(10 * var0.health, var1);
    return;
  }
}

function dropallunusableitems(var0, var1) {
  var2 = scripts\engine\trace::ray_trace(var0, var1);
  var3 = [];

  if(isDefined(var2["entity"]) && var3.size < 25) {
    GscBinSkip0(0x2e, var3.size, var2["entity"]);
  }

  return var2;
}

function drone_turret_canseetarget(var0, var1, var2) {
  var3 = anglesToForward(var0.angles) * 50;
  var4 = var0.origin + var3;
  var5 = (0, 0, 500);
  var6 = dropallunusableitems(var4 + var5, var4 - var5);
  var7 = (0, var0.angles[1] - 90, 0);
  var7 = generateaxisanglesfromupvector(var6["normal"], var7);
  var0.chest = easepower("br_loot_cache_lep", var6["position"] + (0, 0, 0.5), var7);
  var0.chest.get_circle_back_nodes_on_same_side = &draw_line_orgtoent;
  var0.chest.ref_123a1 = var0;
  var0.chest.objid = var1;
  var0.chest.ref_11f93 = var2;
  drone_turrets(var0.chest, 30, 1, 0, 1, 0);
  drone_turrets(var0.chest, 30, 1, 0, 0, 1);
}

function draw_line_orgtoent(var0, var1, var2, var3, var4) {
  if((var2 == "closed" || var2 == "closed_nocol") && !isDefined(var0.entity)) {
    if(var2 == "closed") {
      var0 setscriptablepartstate(var1, "opening");
    } else if(var2 == "closed_nocol") {
      var0 setscriptablepartstate(var1, "opening_nocol");
    }

    var3 thread scripts\mp\utility\points::giveunifiedpoints("br_cacheOpen");
    var3 scripts\cp\vehicles\vehicle_compass_cp::ref_12002();

    if(!isDefined(var3.ref_11a01)) {
      var3.ref_11a01 = 1;
    } else {
      var3.ref_11a01++;
    }

    var3 scripts\mp\utility\stats::setextrascore1(var3.ref_11a01);
    dropjuggernautcrate(var0);
    level notify("lootcache_opened_kill_callout" + var0.origin);
    thread dropbrattackerperkammo(var0);
    thread dropbrattackerperkammo(var0, var0.ref_11f93);
    var0.objid = undefined;
    var0.ref_11f93 = undefined;
    thread drawprematchareas(var0);
  }

  return false;
}

function drawprematchareas(var0) {
  level endon("game_ended");
  self.ref_123a1 endon("plane_cache_unusable");
  var1 = getdvarint("scr_reusable_cache_recharge_time", 120);
  wait var1;
  self setscriptablepartstate(var0, "closing");
  drone_turrets(self, 30, 1, 0, 1, 0);
  drone_turrets(self, 30, 1, 0, 0, 1);
}

function dropped_weapon_cleanup_internal() {
  self endon("death");
  self endon("plane_cache_unusable");

  for(;;) {
    level waittill("br_circle_started");
    var0 = level.br_level.default_class_chosen[level.br_circle.circleindex + 1];
    var1 = level.br_level.br_circleradii[level.br_circle.circleindex + 1];

    if(distance2d(self.origin, var0) > var1) {
      for(;;) {
        var0 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
        var1 = scripts\mp\gametypes\br_circle::getdangercircleradius() + 1500;

        if(distance2d(self.origin, var0) > var1) {
          thread drone_out_of_bound_monitor();
          return;
        }

        wait 1;
      }
    }
  }
}

function dropjuggernautcrate(var0) {
  var1 = door_is_open_at_least(var0);

  if(!isDefined(var1) || var1.size <= 0) {
    return [];
  }

  var2 = spawnStruct();
  var3 = anglesToForward((0, var0.angles[1] - -90, 0));
  var2.origin = var0.origin + var3 * 25 - (0, 0, 0.5);
  var2.angles = (0, var0.angles[1], 0);
  var2.itemsdropped = 0;
  var4 = var2 scripts\mp\gametypes\br_lootcache::ref_11a42(var1, 1, undefined);
  return var4;
}

function door_is_open_at_least(var0) {
  var1 = randomint(24);
  var2 = verifybunkercode("lep_cache", var1);

  if(!isDefined(var2)) {
    var2 = [];
  }

  var3 = door_parts();

  if(isDefined(var3)) {
    var2 = var3;
  }

  var2 = "brloot_lep_tablet";
  return var2;
}

function door_parts() {
  if(!isDefined(level.weapon_xp_iw8_ar_sierra552)) {
    downtown_helicopter_start();
  }

  var0 = randomint(level.weapon_xp_iw8_ar_sierra552.ref_13bf6);

  foreach(var2 in level.weapon_xp_iw8_ar_sierra552.itemlist) {
    if(var0 <= var2.ref_12d81) {
      return var2.name;
    }
  }

  return undefined;
}

function drone_out_of_bound_monitor(var0) {
  self endon("death");
  jumpiftrue(isDefined(var0)) LOC_00000011;
  var0 = 0;

  while(!var0) {
    var1 = scripts\common\utility::playersinsphere(self.origin, 3000);

    if(var1.size == 0) {
      break;
    }

    wait 1;
  }

  self.chest setscriptablepartstate("body", "hidden");
  dropbrattackerperkammo(self.chest.objid);
  dropbrattackerperkammo(self.chest.ref_11f93, 1);
  self notify("plane_cache_unusable");
  self.enemy_is_visible delete();
  self delete();
}

function drone_turrets(var0, var1, var2, var3, var4, var5) {
  if(getdvarint("scr_lep_show_plane_icon_after_contract", 0) > 0 && istrue(var5)) {
    return undefined;
  }

  var6 = scripts\engine\utility::ter_op(istrue(var5), var0.ref_11f93, var0.objid);

  if(!isDefined(var6)) {
    var6 = scripts\mp\objidpoolmanager::requestobjectiveid(99);

    if(istrue(var5)) {
      var0.ref_11f93 = var6;
      scripts\mp\objidpoolmanager::objective_add_objective(var6, "active");
      level.ref_123ab.audio_player_start_mud_loop[level.ref_123ab.audio_player_start_mud_loop.size] = var6;
    } else {
      var0.objid = var6;
      scripts\mp\objidpoolmanager::objective_add_objective(var6, "current");
      level.ref_123ab.audio_player_spawn_mud_loop[level.ref_123ab.audio_player_spawn_mud_loop.size] = var6;
    }

    objective_setbackground(var6, 1);
    objective_icon(var6, "ui_mp_br_minimap_icon_dis");
    function_0421(var6, 1);
    objective_setplayintro(var6, 0);
    objective_setlabel(var6, "BR_LEP_EVENT/PLANE_CRASH");
    function_043d(var6, 1);
    objective_removeallfrommask(var6);

    foreach(var8 in level.players) {
      if(isDefined(var8)) {
        if(scripts\engine\utility::array_contains(level.ref_123ab.ref_11b1b, var8)) {
          if(istrue(var5)) {
            scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var6, var8);
          } else {
            scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var6, var8);
          }

          continue;
        }

        if(!istrue(var5)) {
          scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var6, var8);
          continue;
        }

        scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var6, var8);
      }
    }
  } else {
    objective_setzoffset(var6, 0);
  }

  if(!isDefined(var1)) {
    var1 = 0;
  }

  if(istrue(var3)) {
    objective_setshowoncompass(var6, var3);
  }

  if(istrue(var2) && !istrue(var5)) {
    getbnetigrbattlepassxpmultiplier(var6, 39370, 47244);
  }

  if(istrue(var4)) {
    objective_setshowdistance(var6, var4);
  }

  if(isent(var0)) {
    if(getdvarint("scr_br_lep_cache_self_update_icon_pos", 0) > 0) {
      thread dropoff_sound_playerwm_handler(var0, var6);
    } else {
      objective_onentity(var6, var0);
      objective_setzoffset(var6, var1);
    }
  } else {
    objective_setlocation(var6, 0, var0.origin + (0, 0, var1));
  }

  return var6;
}

function dropoff_sound_playerwm_handler(var0, var1) {
  self endon("plane_crashed");
  self endon("death");
  var2 = (0, 0, var1);

  for(;;) {
    objective_position(var0, self.origin + var2);
    waitframe();
    waitframe();
  }
}

function dropbrattackerperkammo(var0, var1) {
  if(getdvarint("scr_lep_show_plane_icon_after_contract", 0) > 0 && istrue(var1)) {
    return;
  }

  if(isDefined(var0)) {
    foreach(var3 in level.players) {
      if(isDefined(var3)) {
        var4 = var3 getnodeoffset_code(7);

        if(isDefined(var4) && var4 == var0) {
          var3 scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_removecallout(7);
        }
      }
    }

    waittillframeend();
    scripts\mp\objidpoolmanager::returnobjectiveid(var0);

    if(istrue(var1)) {
      level.ref_123ab.audio_player_start_mud_loop = scripts\engine\utility::array_remove(level.ref_123ab.audio_player_start_mud_loop, var0);
      return;
    }

    level.ref_123ab.audio_player_spawn_mud_loop = scripts\engine\utility::array_remove(level.ref_123ab.audio_player_spawn_mud_loop, var0);
    return;
  }
}

function drop_in_progress() {
  level endon("game_ended");

  for(;;) {
    level waittill("quest_started", var0, var1);
    waitframe();
    var2 = scripts\engine\utility::array_removeundefined(scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var0, var1));

    foreach(var4 in var2) {
      if(!scripts\engine\utility::array_contains(level.ref_123ab.ref_11b1b, var4)) {
        level.ref_123ab.ref_11b1b = scripts\engine\utility::array_add(level.ref_123ab.ref_11b1b, var4);

        foreach(var6 in level.ref_123ab.audio_player_spawn_mud_loop) {
          scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var6, var4);
        }

        foreach(var6 in level.ref_123ab.audio_player_start_mud_loop) {
          scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var6, var4);
        }
      }
    }
  }
}

function do_ascender_entrance(var0, var1, var2, var3) {
  if(istrue(var3)) {
    var4 = combineangles((0, 180, 0), (0, level.infilstruct.c130pathstruct.angle[1], 0));
    var5 = var1 + anglesToForward(var4) * -24000;
    var5 = (var5[0], var5[1], 23000);
  } else {
    var5 = var2 + anglesToForward(var3) * -24000;
    var5 = (var5[0], var5[1], 23000);
  }

  var6 = spawnStruct();
  var6.crashorigin = var2;
  var6.spawnorigin = var5;
  var6.infectsetradaronnumsurvivors = var3;
  var6.infil_chopper_path_flags_manager = 0;
  var6.forced_bleedout = 0;
  var1 = scripts\engine\utility::array_add(var1, var6);
  return var1;
}

function do_cache_2_prep(var0, var1) {
  var2 = var0 - 1;

  if(!isDefined(level.player_fulton_evac_rumble)) {
    level.player_fulton_evac_rumble = [];
  }

  if(!isDefined(level.player_fulton_evac_rumble[var2])) {
    level.player_fulton_evac_rumble[var2] = [];
  }

  level.player_fulton_evac_rumble[var2] = scripts\engine\utility::array_add(level.player_fulton_evac_rumble[var2], var1);
}

function dokidnapsequence(var0) {
  var1 = level.player_fulton_evac_rumble[var0 - 1];

  foreach(var3 in var1) {
    wait var3;
    var4 = door2(level.ref_123ab.player_fov_default_1);

    if(!isDefined(var4)) {
      return;
    }

    if(doingcheck(level, var4)) {
      level.ref_123ab.player_fov_default_1 = scripts\engine\utility::array_remove(level.ref_123ab.player_fov_default_1, var4);
    }
  }
}

function dointrovo(var0) {
  var1 = level.player_fulton_evac_rumble[var0 - 1];

  foreach(var3 in var1) {
    wait var3;
    var4 = door2(level.ref_123ab.ref_13b2e, 1);

    if(!isDefined(var4)) {
      return;
    }

    if(doingcheck(level, var4)) {
      level.ref_123ab.ref_13b2e = scripts\engine\utility::array_remove(level.ref_123ab.ref_13b2e, var4);
    }
  }
}

function dohudplunderroll() {
  var0 = scripts\engine\utility::array_randomize(level.ref_123ab.ref_12f8b);
  wait 5;

  foreach(var2 in var0) {
    thread doingcheck(level);
    wait 3;
  }
}

function drones_spawning() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  var0 = 0;

  while(var0 <= 5) {
    level waittill("br_circle_set", var0);

    if(var0 == 1) {
      wait 20;
    }

    var1 = level.br_level.br_mapcenter;

    if(var0 > 1 && var0 < level.br_level.default_class_chosen.size) {
      var1 = level.br_level.default_class_chosen[var0];
    }

    var1 = (var1[0], var1[1], 30000);
    extraction_balloon_num_completed(var1, var0);
  }
}

function extraction_balloon_num_completed(var0, var1) {
  if(!isDefined(level.player_infil_played_or_skipped)) {
    level.player_infil_played_or_skipped = spawnStruct();
    level.player_infil_played_or_skipped.ent = spawn("script_model", var0);
    level.player_infil_played_or_skipped.ent setModel("vfx_br_lep");
    thread doesstreakinfomatchequippedstreak(level.player_infil_played_or_skipped.ent);
  }

  level.player_infil_played_or_skipped.amount = clamp(var1, 1, 5);
  level.player_infil_played_or_skipped.ent.origin = var0;
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

function dropminigunondeath(var0, var1, var2) {
  level endon("game_ended");
  level endon("stop_planes");

  if(!getdvarint("scr_br_lep_plane_waves_enabled", 1)) {
    return;
  }

  if(!isDefined(level.ctgs_comparestats)) {
    level.ctgs_comparestats = spawnStruct();
  }

  var3 = gettime() + var0 * 1000;
  var4 = [(45000, -15000, 0), (45000, -20000, 0), (45000, -17500, 0), (45000, -18000, 0), (45000, -20000, 0)];
  var5 = -1000;
  var2 = var2;
  var6 = var1;
  var7 = 20;
  var8 = getdvarint("scr_bomberWaveDelay", 20);
  level.ref_11b54 = getdvarint("scr_br_maxBomberWaves_entityCount", 16);

  if(isDefined(level.br_circle) && isDefined(level.br_circle.circleindex) && level.br_circle.circleindex < 1) {
    var9 = getdvarvector("bomber_offset", var4[0]);
    var10 = level.br_level.br_mapcenter + rotatevector(var9, (0, var2, 0));
    dropdeliveryatpos(var10, var2, var6, var7, var8);
  }

  while(gettime() < var3) {
    if(level.ctgs_comparestats.ref_123ac < level.ref_11b54) {
      dropcondensedplunder(var4, var5, var2, var6, var7);
    }

    wait var8;
  }
}

function dropoff() {
  level notify("stop_planes");

  if(!isDefined(level.ctgs_comparestats) || !isDefined(level.ctgs_comparestats.ref_1452c)) {
    return;
  }

  foreach(var1 in level.ctgs_comparestats.ref_1452c) {
    doendofmatchotsequence(var1, 0);
  }

  level.ctgs_comparestats.ref_1452c = [];
}

function dropdeliveryatpos(var0, var1, var2, var3, var4) {
  if(!isDefined(level.ctgs_comparestats.ref_123ac)) {
    level.ctgs_comparestats.ref_123ac = 0;
  }

  for(var5 = 3; var5 > 0; var5--) {
    if(level.ctgs_comparestats.ref_123ac < level.ref_11b54) {
      var6 = dotooclosetominenags(var0, var1, var2, var3);
      var7 = var6.models[0] scripts\engine\utility::getanim("bomber_planes");
      var8 = getanimlength(var7);
      var9 = var4 * var5 / var8;
      thread drop_scavenger_bag(var6);
      var6.bunkeralt_playerinteractwithkeypadloop scripts\engine\utility::delaythread(0.05, &scripts\common\anim::anim_set_time, var6.models, "bomber_planes", var9);
    }
  }
}

function dropcondensedplunder(var0, var1, var2, var3, var4) {
  var5 = int(min(level.br_circle.circleindex, level.br_level.br_circleradii.size - 1));
  var6 = level.br_level.br_mapcenter;
  var7 = getdvarvector("bomber_offset", var0[int(clamp(var5, 0, var0.size - 1))]);

  if(var5 > 0) {
    var6 = level.br_level.default_class_chosen[var5];
    var4 += level.br_level.br_mapsize[0] / level.br_level.br_circleradii[var5];
  }

  if(isDefined(level.br_circle.starttime)) {
    var8 = level.br_circle.starttime / 1000 + level.br_level.br_circledelaytimes[var5];
    var9 = gettime() / 1000 + 17;
    var10 = var9 >= var8;

    if(var10 && var5 + 1 < level.br_level.default_class_chosen.size) {
      var11 = clamp((var9 - var8) / level.br_level.br_circleclosetimes[var5], 0, 1);
      var12 = level.br_level.default_class_chosen[var5 + 1];
      var13 = getdvarvector("bomber_next_offset", var0[int(clamp(var5 + 1, 0, var0.size - 1))]);
      var6 = vectorlerp(var6, var12, var11);
      var7 = vectorlerp(var7, var13, var11);
    }
  }

  var6 = (var6[0], var6[1], var1) + rotatevector(var7, (0, var2, 0));
  var14 = dotooclosetominenags(var6, var2, var3, var4);
  thread drop_scavenger_bag(var14);
}

function dotooclosetominenags(var0, var1, var2, var3) {
  if(!isDefined(level.ctgs_comparestats)) {
    level.ctgs_comparestats.ctgs_comparestats = spawnStruct();
  }

  if(!isDefined(level.ctgs_comparestats.ref_123ac)) {
    level.ctgs_comparestats.ref_123ac = 0;
  }

  if(!isDefined(level.ctgs_comparestats.ref_1452c)) {
    level.ctgs_comparestats.ref_1452c = [];
  }

  var4 = spawnStruct();
  var4.spawnpos = var0;
  var4.building_magic_grenade_watch = (0, var1, 0);
  var4.bunkeralt_playerinteractwithkeypadloop = scripts\engine\utility::spawn_tag_origin(var4.spawnpos, var4.building_magic_grenade_watch);
  var4.molotov_delete_pool_by_id = var3;
  var4.models = [];
  var5 = (0, 0, 0);

  if(isDefined(level.br_circle) && isDefined(level.br_circle.circleindex) && isDefined(level.br_level.br_circleradii) && var2.size > 1) {
    var6 = int(clamp(level.br_circle.circleindex, 0, level.br_level.br_circleradii.size));
    var5 = (0, randomfloat(level.br_level.br_circleradii[var6]), 0);
    var5 = rotatevector(var5, (0, var1, 0));
    var0 -= (var2.size / 2, var2.size / 2, 0) * var5;
  }

  foreach(var8 in var2) {
    var9 = dropcashdeny(var0);
    var9.animname = var8;
    var9 useanimtree(level.scr_animtree[var8]);
    var9 unmarkkeyframedmover(1);
    var4.models[var10] = var9;
    var5 *= rotatevector((-1, 1, -1), (0, var1, 0));
    var0 += var5;
  }

  var4.num_nodes_search_player = var4.models.size + 1;
  level.ctgs_comparestats.ref_123ac += var4.num_nodes_search_player;
  level.ctgs_comparestats.ref_1452c[level.ctgs_comparestats.ref_1452c.size] = var4;
  return var4;
}

function doendofmatchotsequence(var0, var1) {
  if(!isDefined(var0)) {
    return;
  }

  if(!isDefined(var1)) {
    var1 = 1;
  }

  foreach(var3 in var0.models) {
    var3 delete();
  }

  var0.bunkeralt_playerinteractwithkeypadloop delete();
  level.ctgs_comparestats.ref_123ac -= var0.num_nodes_search_player;

  if(istrue(var1)) {
    level.ctgs_comparestats.ref_1452c = scripts\engine\utility::array_remove(level.ctgs_comparestats.ref_1452c, var0);
    return;
  }
}

function drop_scavenger_bag(var0) {
  level endon("game_ended");
  level endon("stop_planes");
  var0.bunkeralt_playerinteractwithkeypadloop scripts\common\anim::anim_single(var0.models, "bomber_planes", undefined, var0.molotov_delete_pool_by_id);
  doendofmatchotsequence(var0);
}

function dropcashdeny(var0) {
  var1 = clamp(level.br_circle.circleindex + 1, 1, 5);
  var2 = spawn("script_model", var0);
  var3 = "wz_usa_bomber_boscar17_phase1_group_ch3";
  var2 setModel(var3);
  var2.angles = (0, 0, 0);
  return var2;
}

function dontshowscoreevent() {
  level endon("game_ended");
  wait 2;
  level.weapon_xp_iw8_lm_kilo121 setscriptablepartstate("sfx", "siren");

  foreach(var1 in level.players) {
    if(isDefined(var1)) {
      var1 setsoundsubmix("br_lep_amb_2");
      var1 clearsoundsubmix("br_lep_amb_2", 5);
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
  var0 = level.weapon_xp_iw8_ar_golf36;
  var1 = 10288;
  thread dropkit_marker_hints(level, var0);
}

function doarmsracelocationnags(var0, var1, var2, var3) {
  if(var2 == "toma_strike" && !isPlayer(self)) {
    var4 = scripts\common\utility::playersincylinder(var0, var1);
    level thread scripts\mp\gametypes\br_public::brleaderdialog("lep_bomb_incoming", undefined, var4);

    foreach(var6 in var4) {
      if(!isDefined(var6) || !scripts\mp\utility\player::isreallyalive(var6) || var6.team == self.team) {
        continue;
      }

      scripts\mp\gametypes\br_killstreaks::isbrsquadleader(var6, "lep_toma_strike", 0);
    }

    return;
  }

  scripts\mp\gametypes\br_killstreaks::isbulletpenetration(var0, var1, var2, var3);
}

function do_spawn_vo_callout(var0, var1) {
  if(!isDefined(level.create_digit_models)) {
    level.create_digit_models = [];
  }

  var2 = 1000;

  for(var3 = 0; var3 < 3; var3++) {
    var4 = randomfloatrange(0, 360);
    var5 = randomfloatrange(0, var1);
    var6 = (cos(var4) * var5, sin(var4) * var5, 0) + var0;

    for(var7 = 0; var7 < level.create_digit_models.size; var7++) {
      var8 = level.create_digit_models[var7];
      var2 = distance2d(var6, var8);

      if(var2 < 1000) {
        break;
      }
    }

    if(var2 < 1000) {
      continue;
    }

    level.create_digit_models[level.create_digit_models.size] = var6;
    return var6;
  }

  return undefined;
}

function dropkit_marker_hints(var0, var1) {
  self notify("lep_bombardment");
  self notify("begin_strikes");
  self endon("lep_bombardment");
  self endon("game_ended");
  var2 = 2 * level.framedurationseconds;
  var3 = 5;

  for(;;) {
    level.create_digit_models = [];

    for(var4 = 0; var4 < var3; var4++) {
      var5 = do_spawn_vo_callout(var0, var1);

      if(!isDefined(var5)) {
        break;
      }

      if(getdvarint("scr_lep_bombardment_does_damage", 0)) {
        thread dropbrprimaryweapons(level, var5, 30);
      }

      if(getdvarint("scr_lep_bombardment_fx", 0)) {
        level thread _hidesafecircleui::chase(10, var5);
      }

      wait var2;
    }

    wait 20;
  }
}

function dropbrprimaryweapons(var0, var1, var2) {
  var3 = spawnStruct();
  var3.streakname = "toma_strike";
  var3.score = 0;
  var3.shots_fired = 0;
  var3.hits = 0;
  var3.damage = 0;
  var3.kills = 0;
  var3.ref_11eae = 0;
  var3.ref_11f47 = 1;
  var3.vehicle_process_node_when_at_goal = 1;
  var3.ref_121a9 = "ks_toma_strike_missile_mp_x2";
  var3.ref_121a8 = "ks_toma_strike_cluster_mp_x2";
  var3.ref_133dc = 1;
  var3.ref_13a81 = var0;

  if(isDefined(var1)) {
    var3.ref_129e3 = var1;
  }

  if(isDefined(var2)) {
    var3.ref_11ece = var2;
  }

  var4 = randomfloatrange(0, 360);
  var5 = vectortoangles((cos(var4), sin(var4), 0));
  scripts\cp_mp\killstreaks\toma_strike::ref_13bda(var0, var5, var3);
}

function helidrivabledeathall() {
  if(!isDefined(self)) {
    return;
  }

  radiusdamage(self.origin, 256, 15, 15, self, "MOD_EXPLOSIVE", "toma_proj_mp");
}

function dropbrselfrevivetoken(var0, var1, var2, var3, var4) {
  level notify("begin_strikes");
  level endon("begin_strikes");
  self endon("game_ended");
  var5 = getdvarfloat("scr_clusterBombDuration", 0.5);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "dangerNotifyPlayersInRange", &doarmsracelocationnags);

  while(level.ref_123a7) {
    var6 = scripts\engine\utility::array_randomize(level.players);
    var7 = [];
    var8 = [];
    level.create_digit_models = [];

    for(var9 = 0; var9 < var0; var9++) {
      var10 = undefined;

      foreach(var12 in var6) {
        var8 = var12;

        if(!isDefined(var12) || !scripts\mp\utility\player::isreallyalive(var12)) {
          continue;
        }

        if(do_func(var12, var7, var1 * 3)) {
          var10 = do_spawn_vo_callout(var12.origin, var1);
          var7 = var12;
          break;
        }
      }

      foreach(var15 in var8) {
        var6 = scripts\engine\utility::array_remove(var6, var15);
      }

      var8 = [];

      if(isDefined(var10)) {
        if(getdvarint("scr_randomBombardment_clusterStrike", 0)) {
          thread dropbrprimaryweapons(level, var10, undefined);
        }

        if(getdvarint("scr_randomBombardment_clusterBombs", 0)) {
          thread do_convoy_moving_vo(level, var5, var10);
        }
      }
    }

    LOC_0000016e:
      var17 = randomintrange(var2, var3);
    wait var17;
  }
}

function do_func(var0, var1, var2) {
  var3 = var2 * var2;

  foreach(var5 in var1) {
    if(var0 == var5) {
      return false;
    }

    if(distance2dsquared(var0.origin, var5.origin) < var3) {
      return false;
    }
  }

  return true;
}

function do_convoy_moving_vo(var0, var1, var2) {
  level endon("game_ended");
  wait var2;
  level thread _hidesafecircleui::chase(var0, var1);
}

function dropbrkillstreak(var0, var1, var2) {
  level.ref_142d1 = var0;

  if(istrue(var2)) {
    return;
  }

  if(!isDefined(var1)) {
    var1 = 0;
  }

  foreach(var4 in level.players) {
    var4 visionsetnakedforplayer(var0, var1);
  }
}

function dropcratefrommanualheli_cp() {
  level endon("game_ended");
  dropbrkillstreak("mp_don4_outro_shadow_lep", 10);
}

function drop_locations(var0, var1) {
  if(var0 == "bink_complete") {
    self notify("bink_complete");
    return;
  }
}

function dont_shoot_parachutes() {
  level endon("game_ended");
  level.weapon_xp_iw8_ar_falima = spawnStruct();
  var0 = 225;
  var1 = getgroundposition(level.weapon_xp_iw8_ar_golf36, 1);
  scripts\mp\gametypes\br_publicevents::ref_13371("br_lep_exfil_incoming");
  wait 20;
  scripts\mp\gametypes\br_publicevents::ref_13371("br_lep_exfil_online");

  foreach(var3 in level.players) {
    var3 scripts\mp\utility\lower_message::setlowermessageomnvar(83, undefined, 10);
  }

  level thread scripts\mp\gametypes\br_public::brleaderdialog("exfil_ready", undefined, undefined, 1);
  wait 3;
  level.weapon_xp_iw8_ar_falima.trigger = spawn("trigger_radius", var1, 0, int(var0), int(level.defend_wave_3));
  var5 = scripts\mp\gametypes\obj_dom::setupobjective(level.weapon_xp_iw8_ar_falima.trigger, "neutral");
  var5.flagmodel setModel("x2_military_old_recon_station");
  var5.onuse = &domtablet_init;
  var5.onbeginuse = &domflag_showicontoplayer;
  var5.onuseupdate = &donetsksubmap;
  var5.onenduse = &domflagupdateiconsframeend;
  var5.oncontested = &domflag_usecondition;
  var5.onuncontested = &domlocale_onrespawn;
  var5.onunoccupied = &domoralesnags;
  var5.onpinnedstate = &domgulagsounds;
  var5.onunpinnedstate = &domplatecapturetime;
  var5.ref_138b2 = &domlocale_onentergulag;
  var5.stompprogressreward = &dont_update_volume;
  var5.gate_swings_open = 1;
  var5.id = "domFlag";
  var5.pinobj = 0;
  var5.lockupdatingicons = 1;
  var5 scripts\mp\gameobjects::setcapturebehavior("persistent");
  var5 scripts\mp\gameobjects::setusetime(60);
  dontclose(var5);
  playencryptedcinematicforall(var5.objidnum, 1);
  level.weapon_xp_iw8_ar_falima.oil_puddles = var5;
  level.objectivescaler = 1;

  foreach(var3 in level.players) {
    var3 setclientomnvar("ui_securing", 17);
    var3 setclientomnvar("ui_securing_progress", 0);
  }
}

function dont_disable(var0) {
  foreach(var2 in level.players) {
    if(isDefined(var2) && isDefined(var2.team)) {
      if(var2.team == var0) {
        var2 setclientomnvar("ui_securing", 18);
        continue;
      }

      var2 setclientomnvar("ui_securing", 19);
    }
  }
}

function dont_kill_off_old(var0) {
  if(var0 == "contested") {
    self setclientomnvar("ui_securing", 20);
    return;
  }

  if(var0 == "friendly") {
    self setclientomnvar("ui_securing", 18);
    return;
  }

  self setclientomnvar("ui_securing", 19);
}

function dontcallpostplunder(var0) {
  foreach(var2 in level.players) {
    if(isDefined(var2) && !istrue(var2.usedprops) && !istrue(var2.beingrevived)) {
      var2 setclientomnvar("ui_securing_progress", var0);
    }
  }
}

function domflag_onbeginuse(var0) {
  self notify("exfil_newOwnerFeedback");
  self endon("exfil_newOwnerFeedback");

  if(isPlayer(var0)) {
    var1 = var0.team;
  } else {
    var1 = var1;
  }

  foreach(var3 in level.players) {
    if(isDefined(var3) && isDefined(var1)) {
      if(var3.team == var1) {
        thread dont_kill_off_old(var3);
        var3 thread scripts\mp\hud_message::showsplash("br_lep_friendly_team_exfil");
        continue;
      }

      thread dont_kill_off_old(var3);
      var3 thread scripts\mp\hud_message::showsplash("br_lep_enemy_team_exfil");
    }
  }
}

function domtablet_init(var0) {
  var1 = var0.team;
  self.capturetime = gettime();
  self.get_current_bush_zone = 1;

  if(self.touchlist[var1].size == 0 && isDefined(self.oldtouchlist)) {
    self.touchlist = self.oldtouchlist;
  }

  drop_usb_stick(var1, "lep_chall_success", "exfil_enemy_win");
  dontcallpostplunder(1);
  thread domflag_hideiconfromplayer(var1);
}

function domflag_showicontoplayer(var0) {
  if(!isDefined(self.ref_11f63) || !self.ref_11f63) {
    self.ref_11f63 = 1;
    thread domflag_onbeginuse(var0);
    var1 = scripts\mp\utility\teams::getfriendlyplayers(var0.team, 0);

    foreach(var3 in var1) {
      var3 notify("calloutmarkerping_warzoneKillQuestIcon");
    }

    return;
  }
}

function donetsksubmap(var0, var1, var2, var3) {
  if(var1 < 1 && !level.gameended && !istrue(self.get_current_bush_zone)) {
    dontcallpostplunder(var1);
    donotwatchabandoned(var1, var0);
  }

  if(var1 > 0.05 && var2 && !istrue(self.didstatusnotify)) {
    self.didstatusnotify = 1;
  }

  if(self.gate_swings_open && var1 > 0.5) {
    self.gate_swings_open = 0;
    drop_usb_stick(var0, "exfil_friendly_50", "exfil_enemy_50");
    return;
  }
}

function domflagupdateiconsframeend(var0, var1, var2) {
  scripts\mp\gametypes\obj_dom::dompoint_onuseend(var0, var1, var2);
}

function domflag_usecondition() {
  scripts\mp\gameobjects::setobjectivestatusicons("waypoint_contested");
  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, undefined);
  level thread scripts\mp\gametypes\br_public::brleaderdialog("exfil_contested", undefined, undefined, 1);
  var0 = scripts\mp\gameobjects::getownerteam();

  foreach(var2 in level.players) {
    if(isDefined(var2) && isDefined(var0)) {
      thread dont_kill_off_old(var2);
    }
  }
}

function domlocale_onrespawn(var0) {
  var1 = scripts\mp\gameobjects::getownerteam();
  var2 = undefined;
  var3 = domassairetreat();

  if(var3 <= 1) {
    foreach(var5 in level.teamnamelist) {
      var6 = self.teamprogress[var5];

      if(var6 > 0) {
        var2 = var5;
        break;
      }
    }

    if(isDefined(var2)) {
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, var2);
      dont_disable(var2);
    } else if(var1 != "neutral") {
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, var1);
    } else if(var0 != "none") {
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, var0);
    }

    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_capture");

    if(var0 == "none" || var1 == "neutral") {
      self.didstatusnotify = 0;
      return;
    }

    return;
  }
}

function domoralesnags() {
  var0 = scripts\mp\gameobjects::getownerteam();

  if(var0 == "neutral") {
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_captureneutral");
  } else {
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_capture");
  }

  self.didstatusnotify = 0;
}

function domgulagsounds(var0) {
  if(self.ownerteam != "neutral" && self.numtouching[self.ownerteam] && !self.stalemate) {
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defending", "waypoint_capture");
    return;
  }
}

function domplatecapturetime(var0) {
  if(self.ownerteam != "neutral" && !self.numtouching[self.ownerteam] && !self.stalemate) {
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_capture");
    return;
  }
}

function domlocale_onentergulag(var0) {
  var1 = scripts\mp\utility\teams::getenemyteams(var0);
  var2 = undefined;

  foreach(var4 in var1) {
    var5 = self.teamprogress[var4];

    if(var5 > 0) {
      var2 = var5 / self.usetime;
    }
  }

  if(isDefined(var2)) {
    dontcallpostplunder(var2);
    var7 = level.frameduration * self.userate / self.usetime;

    if(var2 <= var7) {
      thread domflag_onbeginuse(self.claimteam);
    }

    if(!self.gate_swings_open && var2 < 0.4) {
      self.gate_swings_open = 1;
      return;
    }

    return;
  }
}

function dont_update_volume(var0) {
  var0 thread scripts\mp\utility\points::giveunifiedpoints("obj_prog_defend");
  scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defending", "waypoint_capture");

  if(isDefined(self.lastprogressteam)) {
    thread domflag_onbeginuse(var0);
    self.lastprogressteam = undefined;
    return;
  }
}

function donotwatchabandoned(var0, var1) {
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

function domflag_hideiconfromplayer(var0) {
  var1 = getarraykeys(level.teamdata);
  var2 = [];

  foreach(var4 in var1) {
    if(var4 == var0) {
      continue;
    }

    if(level.teamdata[var4]["aliveCount"] > 0) {
      var2 = var4;
    }
  }

  var6 = scripts\mp\utility\script::quicksort(var2, &dropbrsuper);

  for(var7 = 0; var7 < var6.size; var7++) {
    var4 = var6[var7];
    var8 = var7 + 2;
    thread scripts\mp\gametypes\br::ref_1209b(var4, var8, 0, 1);
  }

  waitframe();

  if(istrue(level.ref_13dc0)) {
    return;
  }

  level.ref_13dc0 = 1;
  level.ref_145c1 = 1;
  level thread scripts\mp\gamelogic::endgame(var0, game["end_reason"]["objective_completed"], undefined, undefined, undefined, 1);
}

function dropbrsuper(var0, var1) {
  var2 = getteamscore(var0);
  var3 = getteamscore(var1);
  return var2 >= var3;
}

function domassairetreat() {
  var0 = 0;

  foreach(var2 in self.numtouching) {
    if(var2 > 0 && (!isstring(var3) || var3 != "none")) {
      var0++;
    }
  }

  return var0;
}

function dontclose() {
  scripts\mp\objidpoolmanager::update_objective_setneutrallabel(self.objidnum, "BR_LEP_EVENT/BUNKER_EXFIL");
}

function doorstate() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  var0 = scripts\engine\utility::array_removeundefined(level.players);

  foreach(var2 in var0) {
    var2 scripts\cp\vehicles\vehicle_compass_cp::ref_120a4("lep_dis_1");
  }
}

function dopunishhelivocalls(var0) {
  foreach(var2 in var0) {
    var2 scripts\cp\vehicles\vehicle_compass_cp::ref_120a4("lep_dis_3");
  }
}

function doors_opened_music(var0) {
  scripts\cp\vehicles\vehicle_compass_cp::ref_120a4(var0);
}

function draw_debug_sphere(var0) {
  return self getplayerdata("mp", "missionComplete", var0);
}

function door_set_frozen() {
  var0 = scripts\engine\utility::array_removeundefined(level.players);
  return scripts\mp\gametypes\br_ending::get_center_of_array(var0);
}

function drop_usb_stick(var0, var1, var2) {
  foreach(var4 in level.teamnamelist) {
    if(var4 == var0) {
      level thread scripts\mp\gametypes\br_public::dmztut_luicallback(var1, var4, undefined, undefined, undefined, 1);
      continue;
    }

    level thread scripts\mp\gametypes\br_public::dmztut_luicallback(var2, var4, undefined, undefined, undefined, 1);
  }
}

function doesstreakinfomatchequippedstreak(var0) {
  level waittill("game_ended");

  if(isDefined(var0)) {
    var0 delete();
    return;
  }
}

function doteleporttosafehouse() {
  level endon("game_ended");

  foreach(var1 in level.players) {
    var1 setsoundsubmix("br_lep_amb_1");
  }

  var3 = spawn("script_model", (0, 0, 500));
  var3 setModel("lep_sfx");
  waitframe();
  var3 setscriptablepartstate("sfx", "attack_state_01");
  level.weapon_xp_iw8_la_rpapa7 = var3;
  var3 = spawn("script_model", (0, 0, 500));
  var3 setModel("lep_sfx");
  waitframe();
  var3 setscriptablepartstate("sfx", "base");
  level.weapon_xp_iw8_lm_kilo121 = var3;

  foreach(var1 in level.players) {
    var1 clearsoundsubmix("br_lep_amb_1", 5);
  }
}

function do_manual_splash_damage_when_frag_explodes() {
  level.weapon_xp_iw8_lm_kilo121 setscriptablepartstate("sfx", "attack_state_02");

  foreach(var1 in level.players) {
    var1 setsoundsubmix("br_lep_amb_2");
    var1 setsoundsubmix("br_lep_amb_1", 5);
    var1 clearsoundsubmix("br_lep_amb_2", 5);
  }

  wait 5;
  level.weapon_xp_iw8_la_rpapa7 setscriptablepartstate("sfx", "base");
}

function do_not_unload() {
  level.weapon_xp_iw8_la_rpapa7 setscriptablepartstate("sfx", "attack_state_03");

  foreach(var1 in level.players) {
    var1 setsoundsubmix("br_lep_amb_2", 5);
    var1 clearsoundsubmix("br_lep_amb_1", 5);
  }

  wait 5;
  level.weapon_xp_iw8_lm_kilo121 setscriptablepartstate("sfx", "base");
}

function dom() {
  if(isDefined(level.endmusicplayed)) {
    return;
  }

  var0 = scripts\mp\gamescore::run_common_functions_stealth();
  level.endmusicplayed = 1;

  foreach(var2 in level.players) {
    var3 = var0[var2.team];

    if(var3 <= 10) {
      var2 setplayermusicstate("br_lep_victory");
    } else {
      var2 setplayermusicstate("br_plunder_defeat");
    }

    var2 setsoundsubmix("mp_matchend_music", 2);
    var2 enableplayerbreathsystem(0);
  }
}