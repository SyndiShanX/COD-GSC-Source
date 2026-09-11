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
  var0 = raid_player_start_pos_array();
  var1 = 0;

  for(var2 = 0; var2 < var0; var2++) {
    var1 += level.br_level.br_circleclosetimes[var2] + level.br_level.br_circledelaytimes[var2];
  }

  level.ally_movement_defend_0 = var1;
  var3 = int(var1 * 1000);
  var4 = var3;
  var5 = getdvarint("scr_treasure_hunt_respawn_closed_timer_max_time", 90000);

  if(var4 > var5) {
    wait(var4 - var5) / 1000;
    var4 = var5;
  }

  setomnvarforallclients("ui_br_plunder_extract_end_time", int(gettime() + var4));

  foreach(var7 in level.players) {
    if(!isDefined(var7)) {
      continue;
    }

    var7 thread scripts\mp\hud_message::showsplash("br_rebirth_reinforcement_closing");
  }
}

function ref_13207() {
  level endon("game_ended");
  level.ref_13d17.ref_12ca1 = [];

  if(istrue(level.ref_13d17.spotlight_target_found_dist_sq)) {
    var0 = raid_player_start_pos_array();

    for(var1 = 0; var1 < var0; var1++) {
      level.ref_13d17.ref_12ca1[var1] = getdvarint("scr_br_rebirth_respawn_delay_circle_" + var1 + 1, level.ref_13d17.parachute_set_spawn_values);
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

function circletimer(var0) {
  if(istrue(level.ref_13d17.ref_12ca4)) {
    var1 = raid_player_start_pos_array();

    if(var0 >= 3) {
      little_bird_mg_exitendinternal();
      return;
    }

    return;
  }
}

function activate_control_station_interaction() {}

function dyn_door(var0) {
  if(scripts\mp\flags::gameflag("prematch_done")) {
    thread ref_14343();
    scripts\mp\gametypes\br::ref_11b15(var0);
  }

  return true;
}

function droponplayerdeath(var0) {
  _unlinkcorpsefromvehicle::ref_125fc();
  var1 = scripts\mp\gametypes\br_pickups::test_ai_anim();
  scripts\mp\gametypes\br_pickups::minplunderextractions(var1);
  scripts\mp\gametypes\br_pickups::missiontime(var1);
  scripts\mp\gametypes\br_pickups::mintokensdropondeath(var1);
  scripts\mp\gametypes\br_pickups::missedinfilplayerhandler(var1);
  scripts\mp\gametypes\br_pickups::hangar_doors_opening_quadrace();
  return true;
}

function onplayerkilled(var0) {
  if(!istrue(level.br_prematchstarted) || level.gameended || !isDefined(var0.victim)) {
    return;
  }

  thread ref_11ec8(var0.victim);

  if(!isDefined(var0.attacker) || !isPlayer(var0.attacker) || var0.attacker == var0.victim) {
    return;
  }

  var1 = scripts\mp\utility\teams::getteamdata(var0.attacker.team, "aliveCount");

  if(var1 <= 0) {
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
  var0 = int(min(level.br_circle.circleindex, level.ref_13d17.ref_12ca1.size - 1));
  self.ref_12ca1 = int(level.ref_13d17.ref_12ca1[var0]);

  if(istrue(level.ref_13d17.spotlight_target_found_speed)) {
    self.ref_12ca1 = level.ref_13d17.ref_1452f;
  }

  if(!isDefined(self.ref_12ca1)) {
    var1 = "Respawn delay was not properly set. scr_br_rebirth_respawn_delay or scr_br_rebirth_respawn_delay_circle_ should have been set. Defaulting to " + level.ref_13d17.parachute_set_spawn_values;
    scripts\mp\utility\script::laststand_dogtags(var1);
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

function manage_health_stage_allows(var0, var1) {
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

  if(istrue(var0)) {
    ref_130de();
    thread scripts\mp\events::killeventtextpopup("br_rebirth_vengeance", 0, 0);
    wait 1.5;
  }

  ref_13fad(var1);
  scripts\mp\playerlogic::addtoalivecount("rebirth2");
  scripts\mp\gametypes\br::ref_13f21(self, "rebirth2");
  scripts\mp\gametypes\br_pickups::addrespawntoken(1);
  var2 = 0;

  if(istrue(level.ref_13d17.splashtime_drops)) {
    var2 = scripts\mp\gametypes\br_gulag::ref_126e8();
  }

  var3 = scripts\mp\gametypes\br_public::relic_nuketimer_gettimeformission() / 1000;
  var4 = scripts\mp\gametypes\br_gulag::ref_125be(0, var3);
  var5 = scripts\mp\gametypes\br_gulag::ref_1263e(var4);
  self.forcespawnorigin = var5;

  if(var2) {
    scripts\mp\utility\lower_message::setlowermessageomnvar(0);
  }

  var6 = 1;
  scripts\mp\gametypes\br_gulag::gulagfadetoblack();
  wait var6;
  spawn_boss_wave_3();
  scripts\mp\hud_message::heartbeat_sensor_pick_up_monitor();
  scripts\mp\playerlogic::spawnplayer(undefined, 0);
  scripts\cp_mp\execution::_clearexecution();
  scripts\mp\gametypes\br_pickups::initplayer();
  scripts\mp\gametypes\br_spectate::ref_1252a();
  self.respawningfromtoken = undefined;
  ref_12c5e();
  thread scripts\mp\gametypes\br_gulag::ref_13dcb(20);
  respawn(var4, var5);
}

function respawn(var0, var1) {
  level notify("update_circle_hide");

  if(isDefined(self.oobimmunity)) {
    scripts\mp\outofbounds::disableoobimmunity(self);
  }

  scripts\mp\gametypes\br::scriptednode(self);

  if(!isDefined(var0)) {
    var0 = scripts\mp\gametypes\br_gulag::ref_125be();
  }

  var2 = var0.origin;
  var3 = var0.angles;
  var4 = var2;

  if(isDefined(var1)) {
    var4 = var1;
  }

  scripts\mp\gametypes\br_gulag::set_scriptable_states();
  self setOrigin(var4, 1);
  self setplayerangles(var3);
  var5 = spawn("script_model", var4);
  var5 setModel("tag_origin");
  var5.angles = var3;
  var5 hide();
  var5 showtoplayer(self);
  self playerlinktoabsolute(var5, "tag_origin");
  self playerhide();
  thread scripts\mp\gametypes\br_gulag::ref_12524(var5);
  waitframe();
  ref_124e6();

  if(getdvarint("scr_skip_respawn_gate", 1) == 0) {
    scripts\mp\gametypes\br_public::ref_126ed();
  }

  scripts\mp\gametypes\br_public::ref_1252b();

  if(isDefined(var1)) {
    var5.origin = var2;
  }

  var5 playsoundtoplayer("br_ac130_flyby", self);
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
  var6 = 0;

  if(isDefined(level.ref_121cc)) {
    var6 = level.ref_121cc;
  }

  if(!scripts\mp\gametypes\br_public::uniquelootitemid()) {
    thread scripts\cp_mp\parachute::startfreefall(var6, 0, undefined, undefined, 1);
  }

  if(scripts\mp\utility\game::getgametype() == "br") {
    self setclientomnvar("ui_show_spectateHud", -1);
  }

  scripts\mp\gametypes\br_gulag::ref_12c7a();
  scripts\mp\gametypes\br_armor::searchcirclesize();
  scripts\mp\gametypes\br_quest_util::ref_12072();
  scripts\mp\gametypes\br_rewards::ref_12072();
  scripts\mp\gametypes\br_pickups::removerespawntoken();
  var7 = level.ph_setfinalkillcamwinner > 0 && randomfloat(1) < level.ph_setfinalkillcamwinner;

  if(istrue(var7) && isDefined(level.ref_13d17) && isDefined(level.ref_13d17.para_groups)) {
    var8 = 0;

    if(isDefined(level.vehicle.instances["veh_a10fd"])) {
      var8 = level.vehicle.instances["veh_a10fd"].size;
    }

    if(var8 < level.ref_13d17.padding_damage) {
      thread ref_124f2(var2);
      wait 1.5;
    }
  }

  wait 0.5;

  if(scripts\mp\utility\game::getgametype() == "br") {
    thread scripts\mp\gametypes\br_gulag::ref_12523();
  }

  waitframe();
  var5 delete();

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

function wait_for_chopper_boss_finish_turning(var0, var1) {
  thread scripts\mp\gametypes\br_gulag::playergulagautowin("rebirth", var0, var1);
  ref_13fad(level.teamdata[self.team]["alivePlayers"], var0);
}

function activategastrap() {}

function ref_124f2(var0) {
  if(scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("circle")) {
    return;
  }

  var1 = level.br_circle.circleindex + 1;

  if(!isDefined(level.br_level.default_class_chosen[var1])) {
    var1 = level.br_circle.circleindex;
  }

  var2 = vectortoyaw(level.br_level.default_class_chosen[var1] - var0);
  var3 = spawnStruct();
  var3.origin = (var0[0], var0[1], var0[2] + 4000);
  var3.angles = (0, var2, 0);
  var3.cannotbesuspended = 1;
  var4 = spawnStruct();
  var5 = "veh_a10fd";

  if(randomfloat(1) > level.ref_13d17.para_groups) {
    var5 = "veh_bt";
  }

  var3.targetname = var5;

  switch (var5) {
    case "veh_bt":
      var3.modelname = "veh_s4_mil_air_bomber_wz";
      var3.vehicletype = "bt_mp";
      var6 = _calloutmarkerping_handleluinotify_mappingdeletemarker::create_mp_version_of_vehicle(var3, var4);
      break;
    case "veh_a10fd":
      var4.modelname = "veh_s4_mil_air_dalpha_wz";
      var4.vehicletype = "a10_warthog_fd";
      var6 = _calloutmarkerping_isvehicleoccupiedbyenemy::bot_gametype_set_role(var4, var5);
      break;
    default:
      return;
  }

  thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var6, "pilot", self);
}

function ref_124ed(var0) {
  if(var0) {
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

  for(var0 = scripts\mp\utility\teams::getteamdata(self.team, "aliveCount"); var0 > 0; var0 = scripts\mp\utility\teams::getteamdata(self.team, "aliveCount")) {
    waitframe();
  }

  spawn_boss_wave_3();
  self notify("squad_wiped");
}

function spawn_boss_wave_3() {
  var0 = self calloutmarkerping_entityzoffset("ui_rebirthRespawnTimer");
  var1 = var0 &~16384;
  self setclientomnvar("ui_rebirthRespawnTimer", var1);
}

function ref_1333f() {
  var0 = self calloutmarkerping_entityzoffset("ui_rebirthRespawnTimer");
  var1 = var0 | 16384;
  self setclientomnvar("ui_rebirthRespawnTimer", var1);
}

function ref_130de() {
  var0 = self calloutmarkerping_entityzoffset("ui_rebirthRespawnTimer");
  var1 = var0 | 32768;
  self setclientomnvar("ui_rebirthRespawnTimer", var1);
}

function ref_12c5e() {
  var0 = self calloutmarkerping_entityzoffset("ui_rebirthRespawnTimer");
  var1 = var0 &~32768;
  self setclientomnvar("ui_rebirthRespawnTimer", var1);
}

function ref_130dd(var0) {
  var1 = self calloutmarkerping_entityzoffset("ui_rebirthRespawnTimer");
  var2 = var1 &~16383;
  var3 = var2 | var0;
  self setclientomnvar("ui_rebirthRespawnTimer", var3);
}

function ref_130dc(var0) {
  var1 = self calloutmarkerping_entityzoffset("ui_rebirthRespawnTimer");
  var2 = var1 &~2147418112;
  var3 = var1 & 1073741824;

  if(var3 != 0) {
    var3 = 0;
  } else {
    var3 = 1073741824;
  }

  var4 = var2 | var0 << 16 | var3;
  self setclientomnvar("ui_rebirthRespawnTimer", var4);
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

  foreach(var1 in level.players) {
    if(!isDefined(var1)) {
      continue;
    }

    scripts\mp\gametypes\br_killstreaks::isbrsquadleader(var1, "respawn_disabled", undefined, 2);
    var1 setclientomnvar("ui_br_plunder_extract_end_time", 0);
  }
}

function ref_13fad(var0, var1) {
  var2 = !istrue(level.teamdata[self.team]["teamHadFirstRevive"]);

  if(var2) {
    level.teamdata[self.team]["teamHadFirstRevive"] = 1;
  }

  foreach(var4 in var0) {
    if(!isDefined(var4.endturretonplayerstatus)) {
      var4.endturretonplayerstatus = 0;
    }

    var4.endturretonplayerstatus++;
    var4 scripts\mp\gametypes\br_public::updatebrscoreboardstat("reviveCount", var4.endturretonplayerstatus);
    ref_121b2(var4);
    var5 = !isDefined(var1) || var4 != var1;
    var6 = var2 && var5;

    if(var6) {
      var4 thread scripts\mp\hud_message::showsplash("br_rebirth_first_revive");
    }
  }
}

function ref_11ec8(var0) {
  foreach(var2 in scripts\mp\utility\teams::getteamdata(var0.team, "players")) {
    if(!istrue(var2.shouldgamelobbyremainintact) && isalive(var2) && var0 != var2) {
      var2.shouldgamelobbyremainintact = 1;
      var2 thread scripts\mp\hud_message::showsplash("br_rebirth_first_dead");
    }
  }
}

function ref_121b2() {
  if(!isDefined(self.endgame_finitewaves_music)) {
    self.endgame_finitewaves_music = 0;
  }

  var0 = self.endgame_finitewaves_music;

  if(var0 > 255) {
    var0 = 255;
  }

  self.extrascore0 = var0;
  self.pers["extrascore0"] = var0;
  return var0;
}

function activate_server_for_interact() {}

function ref_12604() {
  if(!isDefined(self.ref_12eb0)) {
    var0 = getcompleteweaponname(level.ref_13d17.ref_13900);
    var1 = scripts\mp\class::fixcollision(level.ref_13d17.ref_13901, "camo_01b", undefined, -1);
    var2 = getcompleteweaponname(level.ref_13d17.ref_138ff);
    var3 = scripts\mp\equipment::getequipmentreffromweapon(var2);
    self giveweapon(var0);
    self giveweapon(var1);
    self switchtoweaponimmediate(var1);
    self assignweaponprimaryslot(var1);
    scripts\mp\gametypes\br_weapons::br_ammo_player_clear();
    scripts\mp\gametypes\br_weapons::br_ammo_give_type(self, "brloot_ammo_919", var1.clipsize * 2);
    scripts\mp\gametypes\br_weapons::br_ammo_update_weapons(self);
    self notify("ammo_update");
    scripts\mp\equipment::giveequipment(var3, "primary");
    scripts\mp\weapons::fixupplayerweapons(self, var1);
  } else {
    _unlinkcorpsefromvehicle::ref_125fb();
  }

  scripts\mp\gametypes\br_armor::scriptablescurid(150);
}

function active_healthpacks() {}

function activate_emp_drone_pick_up() {}