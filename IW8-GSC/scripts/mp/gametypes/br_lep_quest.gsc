/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_lep_quest.gsc
*************************************************/

function init() {
  var_0 = scripts\mp\gametypes\br_quest_util::registerquestcategory("lep", 0);

  if(!var_0) {
    return;
  }

  scripts\engine\scriptable::ref_12f5b("body", &drone_movement_vector_monitor);
  scripts\mp\gametypes\br_quest_util::ref_12b2a("lep", "brloot_lep_tablet");
  scripts\mp\gametypes\br_quest_util::getquestdata("lep").ref_12fa0 = getdvarint("scr_br_lep_searchCircleSize", 1000);
  scripts\mp\gametypes\br_quest_util::getquestdata("lep").ref_11c4c = getdvarint("scr_br_lep_missionTimeBase", 300);
  scripts\mp\gametypes\br_quest_util::getquestdata("lep").ref_11c4d = getdvarint("scr_br_lep_missionTimeBonus", 60);
  scripts\mp\gametypes\br_quest_util::getquestdata("lep").ref_12c83 = getdvarint("scr_br_lep_resetTimerOnPickup", 1);
  scripts\mp\gametypes\br_quest_util::ref_12b3d("lep", &dropoff_point_spawner);
  scripts\mp\gametypes\br_quest_util::registerremovequestinstance("lep", &dropbrc130airdropcrate);
  scripts\mp\gametypes\br_quest_util::ref_12b2e("lep", &drop_structs);
  scripts\mp\gametypes\br_quest_util::registerquestlocale("lep_locale");
  scripts\mp\gametypes\br_quest_util::registercreatequestlocale("lep_locale", &doclocksound);
  scripts\mp\gametypes\br_quest_util::ref_12b2b("lep_locale", &drop_jugg_suit_on_death);
  scripts\mp\gametypes\br_quest_util::registerremovequestinstance("lep_locale", &dropbrammoboxes);
  scripts\mp\gametypes\br_quest_util::registercheckiflocaleisavailable("lep_locale", &do_secured_player_vo);
  scripts\mp\gametypes\br_quest_util::registerquestcircletick("lep_locale", &do_wave_spawning_while_players_return_to_safehouse);
  scripts\mp\gametypes\br_quest_util::ref_12b2d("lep_locale", &dom_ontimerexpired);
  scripts\mp\gametypes\br_quest_util::ref_12b30("lep_locale", &dropbrequipment);
  scripts\mp\gametypes\br_quest_util::ref_1297c("lep", 1);
  scripts\mp\gametypes\br_quest_util::ref_12b31("lep", &drop_percent);
  var_1 = [];
  GscBinSkip0(0x2e, 0, &scripts\mp\gametypes\br_quest_util::filtercondition_isdead);
}

function download_paused_watcher() {
  level.flagonexit = [];
  var_0 = "mp/br_lep_bun_locations.csv";

  for(var_1 = 0;; var_1++) {
    var_2 = tablelookupbyrow(var_0, var_1, 0);

    if(var_2 == "") {
      break;
    }

    var_2 = int(var_2);
    var_3 = spawnStruct();
    var_3.origin = (float(tablelookupbyrow(var_0, var_1, 1)), float(tablelookupbyrow(var_0, var_1, 2)), float(tablelookupbyrow(var_0, var_1, 3)));
    var_3.angles = (float(tablelookupbyrow(var_0, var_1, 4)), float(tablelookupbyrow(var_0, var_1, 5)), float(tablelookupbyrow(var_0, var_1, 6)));
    var_3.ref_12dc1 = var_1 + 1;

    if(!isDefined(level.flagonexit[var_2])) {
      level.flagonexit[var_2] = [];
    }

    level.flagonexit[var_2][level.flagonexit[var_2].size] = var_3;
  }

  for(var_4 = 0; var_4 < level.flagonexit.size; var_4++) {
    level.flagonexit[var_4] = scripts\engine\utility::array_randomize(level.flagonexit[var_4]);
  }
}

function dropbrc130airdropcrate() {
  scripts\mp\gametypes\br_quest_util::releaseteamonquest(self.team);
}

function drop_structs(var_0) {
  if(var_0.team == self.team) {
    var_1 = scripts\mp\utility\teams::getteamdata(self.team, "players");
    scripts\mp\gametypes\br_quest_util::getquestinstancedata("lep_locale", self.team).playerlist = var_1;

    if(isDefined(self.ref_1393b) && isDefined(self.ref_1393b.force_spawn_all_dead_players) && var_1.size) {
      self.ref_1393b.force_spawn_all_dead_players setotherent(var_1[0]);
    }

    if(!scripts\mp\gametypes\br_quest_util::isteamvalid(var_0.team)) {
      self.result = "fail";
      scripts\mp\gametypes\br_quest_util::removequestinstance();
      return;
    }

    return;
  }
}

function dom_ontimerexpired(var_0) {
  if(!do_player_rescued_anim(var_0)) {
    return;
  }

  var_0 scripts\mp\gametypes\br_quest_util::uiobjectivehide();
  scripts\mp\gametypes\br_quest_util::spawn_downed_friendly(var_0);
}

function dropbrequipment(var_0) {
  if(!do_player_rescued_anim(var_0)) {
    return;
  }

  var_0 scripts\mp\gametypes\br_quest_util::uiobjectiveshow("lep");
  scripts\mp\gametypes\br_quest_util::ref_1336c(var_0);
}

function do_player_rescued_anim(var_0) {
  if(var_0.team == self.subscribedinstances[0].team) {
    return 1;
  }

  return 0;
}

function doclocksound(var_0) {
  var_1 = scripts\mp\gametypes\br_quest_util::createlocaleinstance("lep_locale", "lep", self.team);

  if(!isDefined(var_0)) {
    var_1.curorigin = (0, 0, 0);
    var_1.enabled = 0;
    return var_1;
  }

  var_1 scripts\mp\gametypes\br_quest_util::init_tape_machine_animations("ui_mp_br_mapmenu_icon_lep_objective", "current");
  var_1.playerlist = scripts\mp\utility\teams::getteamdata(self.team, "players");
  var_1.ref_12320 = 0;
  var_1.grenade_obj = self.grenade_obj;
  scripts\mp\gametypes\br_quest_util::addquestinstance("lep_locale", var_1);
  dropbrplatepouch(var_1, var_0);
  return var_1;
}

function drop_jugg_suit_on_death(var_0) {
  self.ref_12320++;
  var_1 = dropbrplatepouch(var_0);

  if(var_1) {
    self.subscribedinstances[0].intelprogress = var_0.origin;
    scripts\mp\gametypes\br_quest_util::displayteamsplash(self.subscribedinstances[0].team, "br_lep_quest_next_location");
    level thread scripts\mp\gametypes\br_public::dmztut_luicallback("lep_quest_first", self.subscribedinstances[0].team, 1);

    if(istrue(scripts\mp\gametypes\br_quest_util::getquestdata("lep").ref_12c83)) {
      self.subscribedinstances[0] scripts\mp\gametypes\br_quest_util::ref_1297d(scripts\mp\gametypes\br_quest_util::getquestdata("lep").ref_11c4c, 1);
      return;
    }

    self.subscribedinstances[0] scripts\mp\gametypes\br_quest_util::ref_1297b(scripts\mp\gametypes\br_quest_util::getquestdata("lep").ref_11c4d);
    return;
  }
}

function dropbrplatepouch(var_0) {
  if(!isDefined(var_0)) {
    var_1 = self.subscribedinstances[0];

    foreach(var_4, var_3 in scripts\mp\utility\teams::getteamdata(var_1.team, "players")) {
      var_3 scripts\mp\utility\lower_message::ref_1316e("br_assassination_notargets", undefined, 5);
    }

    var_1.result = "no_locale";
    var_1 scripts\mp\gametypes\br_quest_util::removequestinstance();
    return false;
  }

  getlootspawnpointcount(var_4.index);

  if(self.ref_12320 == 2) {
    var_5 = level.flagonexit[self.grenade_obj.index][0];
    var_4.origin = scripts\engine\utility::drop_to_ground(var_5.origin, 0);
    var_4.angles = var_5.angles;
    level.flagonexit[self.grenade_obj.index] = scripts\engine\utility::array_remove(level.flagonexit[self.grenade_obj.index], var_5);
    level.flagonexit[self.grenade_obj.index][level.flagonexit[self.grenade_obj.index].size] = var_5;
  }

  dropfunc(var_4.origin, var_4.angles, self);
  self.curorigin = var_4.origin + (0, 0, 50);
  scripts\mp\gametypes\br_quest_util::ref_11db0(self.curorigin);
  droporigin();
  return true;
}

function dropbrammoboxes() {
  doexfilallyidle();
  self.playerlist = undefined;
  self.subscribedinstances = undefined;

  if(isDefined(self.force_spawn_all_dead_players)) {
    if(self.force_spawn_all_dead_players getscriptablepartstate("body") == "scavenger_lep_closed") {
      self.force_spawn_all_dead_players delete();
      return;
    }

    return;
  }
}

function do_wave_spawning_while_players_return_to_safehouse(var_0, var_1) {
  if(!isDefined(self.lastcircletick)) {
    self.lastcircletick = -1;
  }

  var_2 = gettime();

  if(self.lastcircletick == var_2) {
    return;
  }

  self.lastcircletick = var_2;
  var_3 = distance2d(self.curorigin, var_0);

  if(var_3 > var_1) {
    foreach(var_5 in self.subscribedinstances) {
      dontdeleteonseatenter(var_5);
    }

    return;
  }
}

function do_secured_player_vo() {
  return false;
}

function dropoff_sound_hvt_handler(var_0) {
  if(!istrue(var_0.init)) {
    var_0 scripts\mp\gametypes\br_quest_util::tabletinit("lep");
  }

  var_1 = scripts\mp\gametypes\br_quest_util::createquestinstance("lep", self.team, var_0.index, var_0);
  var_1 scripts\mp\gametypes\br_quest_util::registerteamonquest(self.team, self);
  var_1 scripts\mp\gametypes\br_quest_util::ref_12b15(self);
  var_1.team = self.team;
  var_1.startlocation = self.origin;
  var_1.intelprogress = self.origin;
  var_1.ref_12c4a = var_0.ref_12c4a;
  var_1.grenade_obj = var_0.grenade_obj;
  var_2 = drone_instant_killed_monitor(var_1.startlocation, var_1.ref_12c4a[0]);
  var_3 = var_1 scripts\mp\gametypes\br_quest_util::requestquestlocale("lep_locale", var_2, 1);

  if(!var_3.enabled) {
    scripts\mp\utility\lower_message::ref_1316e("br_assassination_notargets", undefined, 5);
    var_1.result = "no_locale";
    var_1 scripts\mp\gametypes\br_quest_util::releaseteamonquest(self.team);
    var_4 = spawnStruct();
    var_4.origin = var_0.origin;
    var_4.angles = var_0.angles;
    var_4.itemsdropped = 0;

    if(getDvar("scr_br_gametype", "") == "dmz" || getDvar("scr_br_gametype", "") == "rat_race" || getDvar("scr_br_gametype", "") == "risk") {
      var_5 = "mp/loot_set_cache_contents_dmz.csv";
      var_4 scripts\mp\gametypes\br_lootcache::chooseandspawnitems(0, 1, "health", var_5);
      var_4 scripts\mp\gametypes\br_lootcache::chooseandspawnitems(0, 2, "ammo", var_5);
      var_4 scripts\mp\gametypes\br_lootcache::chooseandspawnitems(1, 1, "plunder", var_5);
      return;
    }

    var_4 scripts\mp\gametypes\br_lootcache::chooseandspawnitems(0, 1, "health");
    var_4 scripts\mp\gametypes\br_lootcache::chooseandspawnitems(0, 2, "ammo");
    var_4 scripts\mp\gametypes\br_lootcache::chooseandspawnitems(1, 1, "plunder");
    return;
  }

  scripts\mp\gametypes\br_quest_util::uiobjectiveshowtoteam("lep", self.team);
  var_2.totalscavengeditems = 0;
  var_2 scripts\mp\gametypes\br_quest_util::ref_1297d(scripts\mp\gametypes\br_quest_util::getquestdata("lep").ref_11c4c, 4);
  scripts\mp\gametypes\br_quest_util::addquestinstance("lep", var_2);
  scripts\mp\gametypes\br_quest_util::ref_13879("lep", self, self.team);
  var_6 = spawnStruct();
  var_6.excludedplayers = [];
  var_6.excludedplayers[0] = self;
  var_6.ref_127d5 = scripts\mp\gametypes\br_quest_util::rewardmodifier("lep", scripts\mp\gametypes\br_quest_util::ringing(self.team));
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_lep_quest_start_team", var_6);
  scripts\mp\gametypes\br_quest_util::displayplayersplash(self, "br_lep_quest_start_tablet_finder", var_6);

  if(!scripts\mp\gametypes\br_public::validtousesticker()) {
    scripts\mp\gametypes\br_quest_util::searchfunc(self.team, "br_mission_pickup_tablet");
  }

  scripts\mp\gametypes\br_quest_util::lookforvehicles(var_2.team, self, 6, scripts\mp\gametypes\br_quest_util::getquestindex("lep"));
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("lep_quest_start", var_2.team, 1);
}

function drone_instant_killed_monitor(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.ref_12fa3 = "getUnusedLootCacheArray";
  var_2.ref_12f9f = var_0;
  var_2.ref_12fa6 = 10000;
  var_2.ref_12fa7 = 0;
  var_2.ref_12fa4 = 4000;
  var_2.ref_12fa5 = 2000;
  var_2.ref_12fa1 = 0;
  var_2.ref_12c4a = var_1;
  var_2.mintime = 100;
  return var_2;
}

function docache4voskits(var_0, var_1) {
  var_2 = spawnStruct();
  var_3 = scripts\mp\gametypes\br_quest_util::ringing(self.team);
  var_4 = scripts\mp\gametypes\br_quest_util::getquestindex("lep");
  var_5 = scripts\mp\gametypes\br_quest_util::rewardtovalue(scripts\mp\gametypes\br_quest_util::rewardtotype("lep"));
  var_2.ref_121b5 = scripts\mp\gametypes\br_quest_util::ref_121b9(var_4, var_3, var_5);

  if(!scripts\mp\gametypes\br_public::validtousesticker()) {
    scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_lep_quest_complete", var_2);
    level thread scripts\mp\gametypes\br_public::dmztut_luicallback("lep_quest_finished", self.team, 1, 1);
    thread dooutrovo(level);
  }

  foreach(var_1 in self.team) {
    var_1.highlighttoteam = 1;
  }

  self.ref_12d2e = var_0.origin;
  self.ref_12d2b = var_0.angles;
  self.result = "success";
  scripts\mp\gametypes\br_quest_util::removequestinstance();
}

function dontdeleteonseatenter() {
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_lep_quest_circle_failure");
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_obj_circle_fail", self.team, 1);
  self.result = "fail";
  scripts\mp\gametypes\br_quest_util::removequestinstance();
}

function droporigin() {
  foreach(var_1 in self.playerlist) {
    var_1 scripts\mp\gametypes\br_quest_util::uiobjectivesetparameter(self.ref_12320);
  }

  var_3 = scripts\mp\gametypes\br_quest_util::sortvalidplayersinarray(self.playerlist);

  foreach(var_1 in var_3["valid"]) {
    var_1 scripts\mp\gametypes\br_quest_util::uiobjectiveshow("lep");
    scripts\mp\gametypes\br_quest_util::ref_1336c(var_1);
  }

  foreach(var_1 in var_3["invalid"]) {
    var_1 scripts\mp\gametypes\br_quest_util::uiobjectivehide();
    scripts\mp\gametypes\br_quest_util::spawn_downed_friendly(var_1);
  }
}

function doreturnvo(var_0) {
  scripts\mp\gametypes\br_quest_util::spawn_downed_friendly(var_0);
  var_0 scripts\mp\gametypes\br_quest_util::uiobjectivehide();
}

function doexfilallyidle() {
  foreach(var_1 in self.playerlist) {
    doreturnvo(var_1);
  }

  scripts\mp\gametypes\br_quest_util::lastdropedtime();
}

function drop_percent() {
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_lep_quest_timer_expired");
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_gen_fail", self.team, 1);
}

function dropfunc(var_0, var_1, var_2) {
  var_3 = spawn("script_model", var_0);
  var_4 = var_2.playerlist[0];
  var_3.angles = var_1;
  var_3 setotherent(var_4);
  var_3 setModel("military_loot_crate_lep_quest");
  var_3 setscriptablepartstate("body", "scavenger_lep_closed");
  var_3.questlocale = var_2;
  var_2.force_spawn_all_dead_players = var_3;

  foreach(var_6 in level.players) {
    if(var_6 != var_4 && (var_4.team == "none" || var_6.team != var_4.team)) {
      var_3 disablescriptableplayeruse(var_6);
    }
  }
}

function drone_movement_vector_monitor(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_3 scripts\mp\gametypes\br_gametypes::ref_12e05("playerSkipLootPickup", var_0))) {
    return;
  }

  if(var_2 == "scavenger_lep_closed" && isDefined(var_0.entity)) {
    if(!isDefined(var_0.entity.questlocale.subscribedinstances)) {
      var_3 iprintlnbold("Chest Requires a Plane Crash Intel Mission");
      return;
    }

    var_5 = var_0.entity.questlocale.subscribedinstances[0];

    if(var_3.team != var_5.team) {
      var_3 iprintlnbold("Chest Requires a Plane Crash Intel Mission");
      return;
    }

    var_0 setscriptablepartstate("body", "scavenger_lep_opening");
    var_6 = getdvarint("scr_br_scavenger_cacheDeleteDelay", 30);
    var_0.entity scripts\engine\utility::delaycallwatchself(var_6, &delete);
    var_5 scripts\mp\gametypes\br_quest_util::ref_12b15(var_3);
    var_5.ref_12d30 = var_0;

    switch (var_0.entity.questlocale.ref_12320) {
      case 0:
        scripts\mp\gametypes\br_quest_util::search_activate_battle_station("scavenger_1", var_3.team, var_0.origin, var_0.angles, var_5.ref_12d30);
        break;
      case 1:
        scripts\mp\gametypes\br_quest_util::search_activate_battle_station("scavenger_2", var_3.team, var_0.origin, var_0.angles, var_5.ref_12d30);
        break;
      case 2:
        if(var_0.entity.questlocale.ref_12320 == 2 && true) {
          scripts\mp\gametypes\br_quest_util::search_activate_battle_station("scavenger_2", var_3.team, var_0.origin, var_0.angles, var_5.ref_12d30);
          dropcount(var_0);
        }

        break;
      default:
        dropcount(var_0);
        break;
    }

    if(var_0.entity.questlocale.ref_12320 == 3) {
      var_5.ref_12d2e = var_0.origin;
      var_5.ref_12d2b = var_0.angles;
      scripts\mp\gametypes\br_quest_util::lookforvehicles(var_5.team, var_3, 8, scripts\mp\gametypes\br_quest_util::getquestindex("lep"));
      docache4voskits(var_5, var_0.entity, var_3);
    } else {
      scripts\mp\gametypes\br_quest_util::lookforvehicles(var_5.team, var_3, 7, scripts\mp\gametypes\br_quest_util::getquestindex("lep"));
      var_7 = drone_instant_killed_monitor(var_0.origin, var_5.ref_12c4a[var_0.entity.questlocale.ref_12320 + 1]);
      var_0.entity.questlocale scripts\mp\gametypes\br_quest_util::ref_11daf("lep_locale", var_7);
    }

    level notify("lootcache_opened_kill_callout" + var_0.origin);
    var_8 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getFriendlyPlayers")]](var_3.team, 0);

    foreach(var_10 in var_8) {
      var_10 notify("calloutmarkerping_warzoneKillQuestIcon");
    }

    return;
  }
}

function dropcount(var_0) {
  var_1 = [scripts\mp\gametypes\br_gametype_lep::door_parts()];

  if(!isDefined(var_1) || var_1.size <= 0) {
    return;
  }

  var_2 = spawnStruct();
  var_3 = anglesToForward((0, var_0.angles[1] - -90, 0));
  var_2.origin = var_0.origin + var_3 * 25;
  var_2.angles = (0, var_0.angles[1], 0);
  var_2.itemsdropped = 0;
  var_4 = var_2 scripts\mp\gametypes\br_lootcache::ref_11a42(var_1, 1, undefined);
}

function dropoff_point_spawner() {
  self.ref_12c4a = [];
  self.grenade_obj = relic_disable_health_regen(self.origin);
  var_0 = self.grenade_obj.origin - self.origin;

  for(var_1 = 0; var_1 < 4; var_1++) {
    if(var_1 == 2) {
      continue;
    } else if(var_1 < 2) {
      var_2 = 0.333333;
      var_3 = self.origin + var_0 * (var_1 + 1) * var_2;
    } else {
      var_3 = self.grenade_obj.origin + rotatevector((5500, 0, 0), (0, randomfloatrange(0, 360), 0));
    }

    var_4 = drone_instant_killed_monitor(var_3);
    var_5 = scripts\mp\gametypes\br_quest_util::play_train_speaker_vo("lep", var_4);

    if(!isDefined(var_5)) {
      return false;
    }

    getlootspawnpointcount(var_5.index);
    var_3 = var_5.origin;
    self.ref_12c4a[var_1] = var_5;
  }

  return true;
}

function relic_disable_health_regen(var_0) {
  var_1 = spawnStruct();
  var_1.origin = undefined;
  var_1.index = undefined;
  var_2 = undefined;

  foreach(var_4 in level.weapon_should_not_get_ammo) {
    var_5 = 0;

    if(istrue(level.group_unset_jugg_standstill)) {
      var_5 = scripts\mp\gametypes\br_circle::updatescavengerhud(var_4);
    } else {
      var_5 = scripts\mp\gametypes\br_circle::ispointincurrentsafecircle(var_4);
    }

    if(!var_5) {
      continue;
    }

    var_6 = distance2d(var_0, var_4);

    if(!isDefined(var_2) || var_6 < var_2) {
      var_1.origin = var_4;
      var_1.index = var_7;
      var_2 = var_6;
    }
  }

  return var_1;
}

function dooutrovo(var_0) {
  foreach(var_2 in level.teamdata[var_0]["players"]) {
    var_2 scripts\cp\vehicles\vehicle_compass_cp::ref_120a4("lep_dis_2");
  }
}