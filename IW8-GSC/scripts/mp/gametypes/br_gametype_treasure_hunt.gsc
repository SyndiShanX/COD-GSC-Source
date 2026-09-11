/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametype_treasure_hunt.gsc
**************************************************************/

function activate_c4_for_pick_up() {}

function activate_laser_trap_parent() {}

function init() {
  table_getrole();
  thread table_getaddblueprintattachments();
}

function table_getrole() {
  tarmac_techo_start();
  successfulteams();
  init_callbacks();
}

function tarmac_techo_start() {
  level.ref_13d17 = spawnStruct();
  level.ref_13d17.ref_13900 = getDvar("scr_brTreasureHunt_loadout_starting_weapon_1", "iw8_fists_mp");
  level.ref_13d17.ref_13901 = getDvar("scr_brTreasureHunt_loadout_starting_weapon_2", "iw8_sm_t9handling");
  level.ref_13d17.ref_138ff = getDvar("scr_brTreasureHunt_loadout_starting_lethal", "frag_grenade_mp");
  level.ref_13d17.parachute_set_spawn_values = getdvarfloat("scr_brTreasureHunt_defaultRespawnDelay", 30);
  level.ref_13d17.spotlight_target_found_dist_sq = getdvarint("scr_brTreasureHunt_useRespawnDelayPerCircle", 1);
  level.ref_13d17.spotlight_target_found_speed = getdvarint("scr_brTreasureHunt_useRespawnWaves", 0);
  level.ref_13d17.spotlight_tag = getdvarint("scr_brTreasureHunt_usePointsToReduceRespawnTime", 1);
  level.ref_13d17.paired_lasers = getdvarfloat("scr_brTreasureHunt_aircraftRespawn", 0.08);
  level.ref_13d17.padding_damage = getdvarfloat("scr_brTreasureHunt_aircraftMaxAllowed", 30);
  level.ref_13d17.para_groups = getdvarfloat("scr_brTreasureHunt_aircraftTypeChance", 1);
  level.ref_13d17.splashtime_drops = getdvarint("scr_brTreasureHunt_respawnWaitForPrestream", 0);
  level.ref_13d17.spinpropkey = getdvarint("scr_brTreasureHunt_respawnNotifyStart", 1);
  level.ref_12ca7 = getdvarint("scr_brTreasureHunt_", 7500);
}

function successfulteams() {
  if(getdvarint("scr_brTreasureHunt_playtest", 0)) {
    scripts\mp\gametypes\br_gametypes::move_molotov_mortar("allowLateJoiners");
  }

  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("gulag");
}

function init_callbacks() {
  level.decoyassists = &groundz;
  scripts\mp\gametypes\br_gametypes::ref_12b11("circleTimer", &circletimer);
  scripts\mp\gametypes\br_gametypes::ref_12b11("dropOnPlayerDeath", &droponplayerdeath);
  scripts\mp\gametypes\br_gametypes::ref_12b11("playerNakedDropLoadout", &ref_12604);
  scripts\mp\gametypes\br_gametypes::ref_12b11("mayConsiderPlayerDead", &dyn_door);
  scripts\mp\gametypes\br_gametypes::ref_12b11("triggerRespawnOverlay", &ref_13dcb);
  scripts\mp\gametypes\br_gametypes::ref_12b11("kioskRevivePlayer", &wait_for_chopper_boss_finish_turning);
  scripts\mp\gametypes\br_gametypes::ref_12b11("onPlayerKilled", &onplayerkilled);
}

function table_getaddblueprintattachments() {
  waitframe();
  scripts\mp\flags::gameflaginit("infil_complete", 0);
  scripts\mp\gametypes\br_skydive_protection::init();
  thread ref_13206();
  thread syringe_out();
}

function ref_13206() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  level.ref_13d17.ref_12ca4 = 1;
  thread ref_131e8();
  thread ref_13207();
}

function ref_131e8() {
  level endon("game_ended");
  level waittill("infils_ready");
  var_0 = raid_player_start_pos_array();
  var_1 = 0;

  for(var_2 = 0; var_2 < var_0; var_2++) {
    var_1 += level.br_level.br_circleclosetimes[var_2] + level.br_level.br_circledelaytimes[var_2];
  }

  level.ally_movement_defend_0 = var_1;
  var_3 = int(var_1 * 1000);
  var_4 = var_3;
  var_5 = getdvarint("scr_treasure_hunt_respawn_closed_timer_max_time", 90000);

  if(var_4 > var_5) {
    wait(var_4 - var_5) / 1000;
    var_4 = var_5;
  }

  setomnvarforallclients("ui_br_plunder_extract_end_time", int(gettime() + var_4));

  foreach(var_7 in level.players) {
    if(!isDefined(var_7)) {
      continue;
    }

    var_7 thread scripts\mp\hud_message::showsplash("br_rebirth_reinforcement_closing");
  }
}

function ref_13207() {
  level endon("game_ended");
  level.ref_13d17.ref_12ca1 = [];

  if(istrue(level.ref_13d17.spotlight_target_found_dist_sq)) {
    var_0 = raid_player_start_pos_array();

    for(var_1 = 0; var_1 < var_0; var_1++) {
      level.ref_13d17.ref_12ca1[var_1] = getdvarint("scr_br_rebirth_respawn_delay_circle_" + var_1 + 1, level.ref_13d17.parachute_set_spawn_values);
    }

    return;
  }

  level.ref_13d17.ref_12ca1[0] = getdvarint("scr_br_rebirth_respawn_delay", level.ref_13d17.parachute_set_spawn_values);
}

function syringe_out() {
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  scripts\mp\flags::gameflagwait("infil_complete");
}

function activate_battle_station() {}

function groundz() {
  level.br_level.default_suicidebomber_combat = [0, 0, 0, 0, 0];

  switch (getdvarint("scr_bodycount_circle_speed", 0)) {
    case 1:
      level.br_level.br_circledelaytimes = [150, 125, 105, 80, 60];
      level.br_level.br_circleclosetimes = [90, 75, 75, 60, 115];
      level.br_level.default_player_connect_black_screen = [120, 0, 0, 0, 0];
      break;
    case 2:
      level.br_level.br_circledelaytimes = [125, 100, 75, 60, 0];
      level.br_level.br_circleclosetimes = [90, 75, 45, 45, 85];
      level.br_level.default_player_connect_black_screen = [100, 0, 0, 0, 0];
      break;
    case 3:
      level.br_level.br_circledelaytimes = [30, 10, 10, 10, 10];
      level.br_level.br_circleclosetimes = [10, 10, 10, 10, 10];
      level.br_level.default_player_connect_black_screen = [5, 0, 0, 0, 0];
      break;
    case 0:
    default:
      level.br_level.br_circledelaytimes = [150, 110, 75, 60, 0];
      level.br_level.br_circleclosetimes = [90, 75, 60, 60, 100];
      level.br_level.default_player_connect_black_screen = [120, 0, 0, 0, 0];
      break;
  }

  level.br_level.br_circleradii = [18000, 12000, 8000, 4500, 1500, 0];
  level.br_level.br_circleminimapradii = [7500, 6500, 5500, 5000, 4500];
}

function circletimer(var_0) {
  if(istrue(level.ref_13d17.ref_12ca4)) {
    var_1 = raid_player_start_pos_array();

    if(var_0 >= 3) {
      little_bird_mg_exitendinternal();
      return;
    }

    return;
  }
}

function activate_control_station_interaction() {}

function dyn_door(var_0) {
  if(scripts\mp\flags::gameflag("prematch_done")) {
    thread ref_14343();
    scripts\mp\gametypes\br::ref_11b15(var_0);
  }

  return true;
}

function droponplayerdeath(var_0) {
  _unlinkcorpsefromvehicle::ref_125fc();
  var_1 = scripts\mp\gametypes\br_pickups::test_ai_anim();
  scripts\mp\gametypes\br_pickups::minplunderextractions(var_1);
  scripts\mp\gametypes\br_pickups::missiontime(var_1);
  scripts\mp\gametypes\br_pickups::mintokensdropondeath(var_1);
  scripts\mp\gametypes\br_pickups::missedinfilplayerhandler(var_1);
  scripts\mp\gametypes\br_pickups::hangar_doors_opening_quadrace();
  return true;
}

function onplayerkilled(var_0) {
  if(!istrue(level.br_prematchstarted) || level.gameended || !isDefined(var_0.victim)) {
    return;
  }

  thread ref_11ec8(var_0.victim);

  if(!isDefined(var_0.attacker) || !isPlayer(var_0.attacker) || var_0.attacker == var_0.victim) {
    return;
  }

  var_1 = scripts\mp\utility\teams::getteamdata(var_0.attacker.team, "aliveCount");

  if(var_1 <= 0) {
    return;
  }
}

function activatedtime() {}

function ref_14343() {
  if(!istrue(level.ref_13d17.ref_12ca4)) {
    return;
  }

  level endon("game_ended");
  self endon("disconnect");
  self endon("squad_wiped");
  self endon("force_stop_respawn");
  thread getdroplocationnearcurrentcircle();
  var_0 = int(min(level.br_circle.circleindex, level.ref_13d17.ref_12ca1.size - 1));
  self.ref_12ca1 = int(level.ref_13d17.ref_12ca1[var_0]);

  if(istrue(level.ref_13d17.spotlight_target_found_speed)) {
    self.ref_12ca1 = level.ref_13d17.ref_1452f;
  }

  if(!isDefined(self.ref_12ca1)) {
    var_1 = "Respawn delay was not properly set. scr_br_rebirth_respawn_delay or scr_br_rebirth_respawn_delay_circle_ should have been set. Defaulting to " + level.ref_13d17.parachute_set_spawn_values;
    scripts\mp\utility\script::laststand_dogtags(var_1);
    self.ref_12ca1 = int(level.ref_13d17.parachute_set_spawn_values);
  }

  ref_1333f();
  ref_130dd(self.ref_12ca1);
  self.ref_12ca3 = 0;

  while(self.ref_12ca1 > 0) {
    if(isalive(self)) {
      self.ref_12ca1 = 0;
    } else {
      ref_130dd(self.ref_12ca1);
    }

    ref_130dc(self.ref_12ca3);
    scripts\mp\gametypes\br_public::updatebrscoreboardstat("respawnInSeconds", self.ref_12ca1);
    self.ref_12ca3 = 0;
    wait 1;
    self.ref_12ca1--;
  }

  spawn_boss_wave_3();
  ref_130dc(0);
  scripts\mp\gametypes\br_public::updatebrscoreboardstat("respawnInSeconds", 0);

  if(!isalive(self)) {
    if(isDefined(self.team)) {
      scripts\mp\gametypes\br_quest_util::lookforvehicles(self.team, self, 12, 1);
    }

    thread manage_health_stage_allows(0, level.teamdata[self.team]["alivePlayers"]);
    return;
  }
}

function manage_health_stage_allows(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  self notify("doingRespawn");

  if(istrue(self.respawningfromtoken)) {
    return;
  }

  self.respawningfromtoken = 1;

  if(istrue(level.ref_13d17.spinpropkey)) {
    self notify("started_spawnPlayer");
  }

  if(istrue(var_0)) {
    ref_130de();
    thread scripts\mp\events::killeventtextpopup("br_rebirth_vengeance", 0, 0);
    wait 1.5;
  }

  ref_13fad(var_1);
  scripts\mp\playerlogic::addtoalivecount("rebirth2");
  scripts\mp\gametypes\br::ref_13f21(self, "rebirth2");
  scripts\mp\gametypes\br_pickups::addrespawntoken(1);
  var_2 = 0;

  if(istrue(level.ref_13d17.splashtime_drops)) {
    var_2 = scripts\mp\gametypes\br_gulag::ref_126e8();
  }

  var_3 = scripts\mp\gametypes\br_public::relic_nuketimer_gettimeformission() / 1000;
  var_4 = scripts\mp\gametypes\br_gulag::ref_125be(0, var_3);
  var_5 = scripts\mp\gametypes\br_gulag::ref_1263e(var_4);
  self.forcespawnorigin = var_5;

  if(var_2) {
    scripts\mp\utility\lower_message::setlowermessageomnvar(0);
  }

  var_6 = 1;
  scripts\mp\gametypes\br_gulag::gulagfadetoblack();
  wait var_6;
  spawn_boss_wave_3();
  scripts\mp\hud_message::heartbeat_sensor_pick_up_monitor();
  scripts\mp\playerlogic::spawnplayer(undefined, 0);
  scripts\cp_mp\execution::_clearexecution();
  scripts\mp\gametypes\br_pickups::initplayer();
  scripts\mp\gametypes\br_spectate::ref_1252a();
  self.respawningfromtoken = undefined;
  ref_12c5e();
  thread scripts\mp\gametypes\br_gulag::ref_13dcb(20);
  respawn(var_4, var_5);
}

function respawn(var_0, var_1) {
  level notify("update_circle_hide");

  if(isDefined(self.oobimmunity)) {
    scripts\mp\outofbounds::disableoobimmunity(self);
  }

  scripts\mp\gametypes\br::scriptednode(self);

  if(!isDefined(var_0)) {
    var_0 = scripts\mp\gametypes\br_gulag::ref_125be();
  }

  var_2 = var_0.origin;
  var_3 = var_0.angles;
  var_4 = var_2;

  if(isDefined(var_1)) {
    var_4 = var_1;
  }

  scripts\mp\gametypes\br_gulag::set_scriptable_states();
  self setOrigin(var_4, 1);
  self setplayerangles(var_3);
  var_5 = spawn("script_model", var_4);
  var_5 setModel("tag_origin");
  var_5.angles = var_3;
  var_5 hide();
  var_5 showtoplayer(self);
  self playerlinktoabsolute(var_5, "tag_origin");
  self playerhide();
  thread scripts\mp\gametypes\br_gulag::ref_12524(var_5);
  waitframe();
  ref_124e6();

  if(getdvarint("scr_skip_respawn_gate", 1) == 0) {
    scripts\mp\gametypes\br_public::ref_126ed();
  }

  scripts\mp\gametypes\br_public::ref_1252b();

  if(isDefined(var_1)) {
    var_5.origin = var_2;
  }

  var_5 playsoundtoplayer("br_ac130_flyby", self);
  wait 1.5;
  self unlink();
  self clearsoundsubmix("deaths_door_mp");

  if(scripts\mp\gametypes\br_public::tutorial_playSound()) {
    self clearsoundsubmix("iw8_br_gulag_tutorial", 2);
  } else {
    self clearsoundsubmix("fade_to_black_all_except_music_and_scripted5", 2);
  }

  self clearclienttriggeraudiozone(1);
  self playershow();
  ref_124ed(1);
  var_6 = 0;

  if(isDefined(level.ref_121cc)) {
    var_6 = level.ref_121cc;
  }

  if(!scripts\mp\gametypes\br_public::uniquelootitemid()) {
    thread scripts\cp_mp\parachute::startfreefall(var_6, 0, undefined, undefined, 1);
  }

  if(scripts\mp\utility\game::getgametype() == "br") {
    self setclientomnvar("ui_show_spectateHud", -1);
  }

  scripts\mp\gametypes\br_gulag::ref_12c7a();
  scripts\mp\gametypes\br_armor::searchcirclesize();
  scripts\mp\gametypes\br_quest_util::ref_12072();
  scripts\mp\gametypes\br_rewards::ref_12072();
  scripts\mp\gametypes\br_pickups::removerespawntoken();
  var_7 = level.ph_setfinalkillcamwinner > 0 && randomfloat(1) < level.ph_setfinalkillcamwinner;

  if(istrue(var_7) && isDefined(level.ref_13d17) && isDefined(level.ref_13d17.para_groups)) {
    var_8 = 0;

    if(isDefined(level.vehicle.instances["veh_a10fd"])) {
      var_8 = level.vehicle.instances["veh_a10fd"].size;
    }

    if(var_8 < level.ref_13d17.padding_damage) {
      thread ref_124f2(var_2);
      wait 1.5;
    }
  }

  wait 0.5;

  if(scripts\mp\utility\game::getgametype() == "br") {
    thread scripts\mp\gametypes\br_gulag::ref_12523();
  }

  waitframe();
  var_5 delete();

  if(istrue(level.ref_133ef)) {
    scripts\mp\gametypes\br_skydive_protection::toma_strike_munitionused(1);
  }

  if(scripts\mp\gametypes\br_public::tutorial_playSound()) {
    self notify("respawn_from_gulag");
  }

  self notify("can_show_splashes");

  if(!istrue(level.stage)) {
    thread scripts\mp\hud_message::showsplash("br_rebirth_redeploy", 20, undefined);
    return;
  }
}

function wait_for_chopper_boss_finish_turning(var_0, var_1) {
  thread scripts\mp\gametypes\br_gulag::playergulagautowin("rebirth", var_0, var_1);
  ref_13fad(level.teamdata[self.team]["alivePlayers"], var_0);
}

function activategastrap() {}

function ref_124f2(var_0) {
  if(scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("circle")) {
    return;
  }

  var_1 = level.br_circle.circleindex + 1;

  if(!isDefined(level.br_level.default_class_chosen[var_1])) {
    var_1 = level.br_circle.circleindex;
  }

  var_2 = vectortoyaw(level.br_level.default_class_chosen[var_1] - var_0);
  var_3 = spawnStruct();
  var_3.origin = (var_0[0], var_0[1], var_0[2] + 4000);
  var_3.angles = (0, var_2, 0);
  var_3.cannotbesuspended = 1;
  var_4 = spawnStruct();
  var_5 = "veh_a10fd";

  if(randomfloat(1) > level.ref_13d17.para_groups) {
    var_5 = "veh_bt";
  }

  var_3.targetname = var_5;

  switch (var_5) {
    case "veh_bt":
      var_3.modelname = "veh_s4_mil_air_bomber_wz";
      var_3.vehicletype = "bt_mp";
      var_6 = _calloutmarkerping_handleluinotify_mappingdeletemarker::create_mp_version_of_vehicle(var_3, var_4);
      break;
    case "veh_a10fd":
      var_4.modelname = "veh_s4_mil_air_dalpha_wz";
      var_4.vehicletype = "a10_warthog_fd";
      var_6 = _calloutmarkerping_isvehicleoccupiedbyenemy::bot_gametype_set_role(var_4, var_5);
      break;
    default:
      return;
  }

  thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var_6, "pilot", self);
}

function ref_124ed(var_0) {
  if(var_0) {
    self enableoffhandweapons();
    self enableusability();
    return;
  }

  self disableoffhandweapons();
  self disableusability();
}

function getdroplocationnearcurrentcircle() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("doingRespawn");

  for(var_0 = scripts\mp\utility\teams::getteamdata(self.team, "aliveCount"); var_0 > 0; var_0 = scripts\mp\utility\teams::getteamdata(self.team, "aliveCount")) {
    waitframe();
  }

  spawn_boss_wave_3();
  self notify("squad_wiped");
}

function spawn_boss_wave_3() {
  var_0 = self calloutmarkerping_entityzoffset("ui_rebirthRespawnTimer");
  var_1 = var_0 &~16384;
  self setclientomnvar("ui_rebirthRespawnTimer", var_1);
}

function ref_1333f() {
  var_0 = self calloutmarkerping_entityzoffset("ui_rebirthRespawnTimer");
  var_1 = var_0 | 16384;
  self setclientomnvar("ui_rebirthRespawnTimer", var_1);
}

function ref_130de() {
  var_0 = self calloutmarkerping_entityzoffset("ui_rebirthRespawnTimer");
  var_1 = var_0 | 32768;
  self setclientomnvar("ui_rebirthRespawnTimer", var_1);
}

function ref_12c5e() {
  var_0 = self calloutmarkerping_entityzoffset("ui_rebirthRespawnTimer");
  var_1 = var_0 &~32768;
  self setclientomnvar("ui_rebirthRespawnTimer", var_1);
}

function ref_130dd(var_0) {
  var_1 = self calloutmarkerping_entityzoffset("ui_rebirthRespawnTimer");
  var_2 = var_1 &~16383;
  var_3 = var_2 | var_0;
  self setclientomnvar("ui_rebirthRespawnTimer", var_3);
}

function ref_130dc(var_0) {
  var_1 = self calloutmarkerping_entityzoffset("ui_rebirthRespawnTimer");
  var_2 = var_1 &~2147418112;
  var_3 = var_1 & 1073741824;

  if(var_3 != 0) {
    var_3 = 0;
  } else {
    var_3 = 1073741824;
  }

  var_4 = var_2 | var_0 << 16 | var_3;
  self setclientomnvar("ui_rebirthRespawnTimer", var_4);
}

function ref_124e6() {
  self notify("treasure_hunt_respawn");
  self.health = self.maxhealth;
  scripts\mp\healthoverlay::onexitdeathsdoor(1);
  scripts\mp\utility\player::enableplayerforspawnlogic(0);
  scripts\mp\gametypes\br_public::updatebrscoreboardstat("isRespawning", 0);
}

function ref_13dcb() {
  wait 0.5;
  return true;
}

function raid_player_start_pos_array() {
  return getdvarint("scr_brTreasureHunt_disableRespawnCircleIndex", 3);
}

function little_bird_mg_exitendinternal() {
  level.ref_13d17.ref_12ca4 = 0;

  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }

    scripts\mp\gametypes\br_killstreaks::isbrsquadleader(var_1, "respawn_disabled", undefined, 2);
    var_1 setclientomnvar("ui_br_plunder_extract_end_time", 0);
  }
}

function ref_13fad(var_0, var_1) {
  var_2 = !istrue(level.teamdata[self.team]["teamHadFirstRevive"]);

  if(var_2) {
    level.teamdata[self.team]["teamHadFirstRevive"] = 1;
  }

  foreach(var_4 in var_0) {
    if(!isDefined(var_4.endturretonplayerstatus)) {
      var_4.endturretonplayerstatus = 0;
    }

    var_4.endturretonplayerstatus++;
    var_4 scripts\mp\gametypes\br_public::updatebrscoreboardstat("reviveCount", var_4.endturretonplayerstatus);
    ref_121b2(var_4);
    var_5 = !isDefined(var_1) || var_4 != var_1;
    var_6 = var_2 && var_5;

    if(var_6) {
      var_4 thread scripts\mp\hud_message::showsplash("br_rebirth_first_revive");
    }
  }
}

function ref_11ec8(var_0) {
  foreach(var_2 in scripts\mp\utility\teams::getteamdata(var_0.team, "players")) {
    if(!istrue(var_2.shouldgamelobbyremainintact) && isalive(var_2) && var_0 != var_2) {
      var_2.shouldgamelobbyremainintact = 1;
      var_2 thread scripts\mp\hud_message::showsplash("br_rebirth_first_dead");
    }
  }
}

function ref_121b2() {
  if(!isDefined(self.endgame_finitewaves_music)) {
    self.endgame_finitewaves_music = 0;
  }

  var_0 = self.endgame_finitewaves_music;

  if(var_0 > 255) {
    var_0 = 255;
  }

  self.extrascore0 = var_0;
  self.pers["extrascore0"] = var_0;
  return var_0;
}

function activate_server_for_interact() {}

function ref_12604() {
  if(!isDefined(self.ref_12eb0)) {
    var_0 = getcompleteweaponname(level.ref_13d17.ref_13900);
    var_1 = scripts\mp\class::fixcollision(level.ref_13d17.ref_13901, "camo_01b", undefined, -1);
    var_2 = getcompleteweaponname(level.ref_13d17.ref_138ff);
    var_3 = scripts\mp\equipment::getequipmentreffromweapon(var_2);
    self giveweapon(var_0);
    self giveweapon(var_1);
    self switchtoweaponimmediate(var_1);
    self assignweaponprimaryslot(var_1);
    scripts\mp\gametypes\br_weapons::br_ammo_player_clear();
    scripts\mp\gametypes\br_weapons::br_ammo_give_type(self, "brloot_ammo_919", var_1.clipsize * 2);
    scripts\mp\gametypes\br_weapons::br_ammo_update_weapons(self);
    self notify("ammo_update");
    scripts\mp\equipment::giveequipment(var_3, "primary");
    scripts\mp\weapons::fixupplayerweapons(self, var_1);
  } else {
    _unlinkcorpsefromvehicle::ref_125fb();
  }

  scripts\mp\gametypes\br_armor::scriptablescurid(150);
}

function active_healthpacks() {}

function activate_emp_drone_pick_up() {}