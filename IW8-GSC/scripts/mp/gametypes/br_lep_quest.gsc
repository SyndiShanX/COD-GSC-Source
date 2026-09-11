/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_lep_quest.gsc
*************************************************/

function init() {
  var0 = scripts\mp\gametypes\br_quest_util::registerquestcategory("lep", 0);

  if(!var0) {
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
  var1 = [];
  GscBinSkip0(0x2e, 0, &scripts\mp\gametypes\br_quest_util::filtercondition_isdead);
}

function download_paused_watcher() {
  level.flagonexit = [];
  var0 = "mp/br_lep_bun_locations.csv";

  for(var1 = 0;; var1++) {
    var2 = tablelookupbyrow(var0, var1, 0);

    if(var2 == "") {
      break;
    }

    var2 = int(var2);
    var3 = spawnStruct();
    var3.origin = (float(tablelookupbyrow(var0, var1, 1)), float(tablelookupbyrow(var0, var1, 2)), float(tablelookupbyrow(var0, var1, 3)));
    var3.angles = (float(tablelookupbyrow(var0, var1, 4)), float(tablelookupbyrow(var0, var1, 5)), float(tablelookupbyrow(var0, var1, 6)));
    var3.ref_12dc1 = var1 + 1;

    if(!isDefined(level.flagonexit[var2])) {
      level.flagonexit[var2] = [];
    }

    level.flagonexit[var2][level.flagonexit[var2].size] = var3;
  }

  for(var4 = 0; var4 < level.flagonexit.size; var4++) {
    level.flagonexit[var4] = scripts\engine\utility::array_randomize(level.flagonexit[var4]);
  }
}

function dropbrc130airdropcrate() {
  scripts\mp\gametypes\br_quest_util::releaseteamonquest(self.team);
}

function drop_structs(var0) {
  if(var0.team == self.team) {
    var1 = scripts\mp\utility\teams::getteamdata(self.team, "players");
    scripts\mp\gametypes\br_quest_util::getquestinstancedata("lep_locale", self.team).playerlist = var1;

    if(isDefined(self.ref_1393b) && isDefined(self.ref_1393b.force_spawn_all_dead_players) && var1.size) {
      self.ref_1393b.force_spawn_all_dead_players setotherent(var1[0]);
    }

    if(!scripts\mp\gametypes\br_quest_util::isteamvalid(var0.team)) {
      self.result = "fail";
      scripts\mp\gametypes\br_quest_util::removequestinstance();
      return;
    }

    return;
  }
}

function dom_ontimerexpired(var0) {
  if(!do_player_rescued_anim(var0)) {
    return;
  }

  var0 scripts\mp\gametypes\br_quest_util::uiobjectivehide();
  scripts\mp\gametypes\br_quest_util::spawn_downed_friendly(var0);
}

function dropbrequipment(var0) {
  if(!do_player_rescued_anim(var0)) {
    return;
  }

  var0 scripts\mp\gametypes\br_quest_util::uiobjectiveshow("lep");
  scripts\mp\gametypes\br_quest_util::ref_1336c(var0);
}

function do_player_rescued_anim(var0) {
  if(var0.team == self.subscribedinstances[0].team) {
    return 1;
  }

  return 0;
}

function doclocksound(var0) {
  var1 = scripts\mp\gametypes\br_quest_util::createlocaleinstance("lep_locale", "lep", self.team);

  if(!isDefined(var0)) {
    var1.curorigin = (0, 0, 0);
    var1.enabled = 0;
    return var1;
  }

  var1 scripts\mp\gametypes\br_quest_util::init_tape_machine_animations("ui_mp_br_mapmenu_icon_lep_objective", "current");
  var1.playerlist = scripts\mp\utility\teams::getteamdata(self.team, "players");
  var1.ref_12320 = 0;
  var1.grenade_obj = self.grenade_obj;
  scripts\mp\gametypes\br_quest_util::addquestinstance("lep_locale", var1);
  dropbrplatepouch(var1, var0);
  return var1;
}

function drop_jugg_suit_on_death(var0) {
  self.ref_12320++;
  var1 = dropbrplatepouch(var0);

  if(var1) {
    self.subscribedinstances[0].intelprogress = var0.origin;
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

function dropbrplatepouch(var0) {
  if(!isDefined(var0)) {
    var1 = self.subscribedinstances[0];

    foreach(var4, var3 in scripts\mp\utility\teams::getteamdata(var1.team, "players")) {
      var3 scripts\mp\utility\lower_message::ref_1316e("br_assassination_notargets", undefined, 5);
    }

    var1.result = "no_locale";
    var1 scripts\mp\gametypes\br_quest_util::removequestinstance();
    return false;
  }

  getlootspawnpointcount(var4.index);

  if(self.ref_12320 == 2) {
    var5 = level.flagonexit[self.grenade_obj.index][0];
    var4.origin = scripts\engine\utility::drop_to_ground(var5.origin, 0);
    var4.angles = var5.angles;
    level.flagonexit[self.grenade_obj.index] = scripts\engine\utility::array_remove(level.flagonexit[self.grenade_obj.index], var5);
    level.flagonexit[self.grenade_obj.index][level.flagonexit[self.grenade_obj.index].size] = var5;
  }

  dropfunc(var4.origin, var4.angles, self);
  self.curorigin = var4.origin + (0, 0, 50);
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

function do_wave_spawning_while_players_return_to_safehouse(var0, var1) {
  if(!isDefined(self.lastcircletick)) {
    self.lastcircletick = -1;
  }

  var2 = gettime();

  if(self.lastcircletick == var2) {
    return;
  }

  self.lastcircletick = var2;
  var3 = distance2d(self.curorigin, var0);

  if(var3 > var1) {
    foreach(var5 in self.subscribedinstances) {
      dontdeleteonseatenter(var5);
    }

    return;
  }
}

function do_secured_player_vo() {
  return false;
}

function dropoff_sound_hvt_handler(var0) {
  if(!istrue(var0.init)) {
    var0 scripts\mp\gametypes\br_quest_util::tabletinit("lep");
  }

  var1 = scripts\mp\gametypes\br_quest_util::createquestinstance("lep", self.team, var0.index, var0);
  var1 scripts\mp\gametypes\br_quest_util::registerteamonquest(self.team, self);
  var1 scripts\mp\gametypes\br_quest_util::ref_12b15(self);
  var1.team = self.team;
  var1.startlocation = self.origin;
  var1.intelprogress = self.origin;
  var1.ref_12c4a = var0.ref_12c4a;
  var1.grenade_obj = var0.grenade_obj;
  var2 = drone_instant_killed_monitor(var1.startlocation, var1.ref_12c4a[0]);
  var3 = var1 scripts\mp\gametypes\br_quest_util::requestquestlocale("lep_locale", var2, 1);

  if(!var3.enabled) {
    scripts\mp\utility\lower_message::ref_1316e("br_assassination_notargets", undefined, 5);
    var1.result = "no_locale";
    var1 scripts\mp\gametypes\br_quest_util::releaseteamonquest(self.team);
    var4 = spawnStruct();
    var4.origin = var0.origin;
    var4.angles = var0.angles;
    var4.itemsdropped = 0;

    if(getDvar("scr_br_gametype", "") == "dmz" || getDvar("scr_br_gametype", "") == "rat_race" || getDvar("scr_br_gametype", "") == "risk") {
      var5 = "mp/loot_set_cache_contents_dmz.csv";
      var4 scripts\mp\gametypes\br_lootcache::chooseandspawnitems(0, 1, "health", var5);
      var4 scripts\mp\gametypes\br_lootcache::chooseandspawnitems(0, 2, "ammo", var5);
      var4 scripts\mp\gametypes\br_lootcache::chooseandspawnitems(1, 1, "plunder", var5);
      return;
    }

    var4 scripts\mp\gametypes\br_lootcache::chooseandspawnitems(0, 1, "health");
    var4 scripts\mp\gametypes\br_lootcache::chooseandspawnitems(0, 2, "ammo");
    var4 scripts\mp\gametypes\br_lootcache::chooseandspawnitems(1, 1, "plunder");
    return;
  }

  scripts\mp\gametypes\br_quest_util::uiobjectiveshowtoteam("lep", self.team);
  var2.totalscavengeditems = 0;
  var2 scripts\mp\gametypes\br_quest_util::ref_1297d(scripts\mp\gametypes\br_quest_util::getquestdata("lep").ref_11c4c, 4);
  scripts\mp\gametypes\br_quest_util::addquestinstance("lep", var2);
  scripts\mp\gametypes\br_quest_util::ref_13879("lep", self, self.team);
  var6 = spawnStruct();
  var6.excludedplayers = [];
  var6.excludedplayers[0] = self;
  var6.ref_127d5 = scripts\mp\gametypes\br_quest_util::rewardmodifier("lep", scripts\mp\gametypes\br_quest_util::ringing(self.team));
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_lep_quest_start_team", var6);
  scripts\mp\gametypes\br_quest_util::displayplayersplash(self, "br_lep_quest_start_tablet_finder", var6);

  if(!scripts\mp\gametypes\br_public::validtousesticker()) {
    scripts\mp\gametypes\br_quest_util::searchfunc(self.team, "br_mission_pickup_tablet");
  }

  scripts\mp\gametypes\br_quest_util::lookforvehicles(var2.team, self, 6, scripts\mp\gametypes\br_quest_util::getquestindex("lep"));
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("lep_quest_start", var2.team, 1);
}

function drone_instant_killed_monitor(var0, var1) {
  var2 = spawnStruct();
  var2.ref_12fa3 = "getUnusedLootCacheArray";
  var2.ref_12f9f = var0;
  var2.ref_12fa6 = 10000;
  var2.ref_12fa7 = 0;
  var2.ref_12fa4 = 4000;
  var2.ref_12fa5 = 2000;
  var2.ref_12fa1 = 0;
  var2.ref_12c4a = var1;
  var2.mintime = 100;
  return var2;
}

function docache4voskits(var0, var1) {
  var2 = spawnStruct();
  var3 = scripts\mp\gametypes\br_quest_util::ringing(self.team);
  var4 = scripts\mp\gametypes\br_quest_util::getquestindex("lep");
  var5 = scripts\mp\gametypes\br_quest_util::rewardtovalue(scripts\mp\gametypes\br_quest_util::rewardtotype("lep"));
  var2.ref_121b5 = scripts\mp\gametypes\br_quest_util::ref_121b9(var4, var3, var5);

  if(!scripts\mp\gametypes\br_public::validtousesticker()) {
    scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_lep_quest_complete", var2);
    level thread scripts\mp\gametypes\br_public::dmztut_luicallback("lep_quest_finished", self.team, 1, 1);
    thread dooutrovo(level);
  }

  foreach(var1 in self.team) {
    var1.highlighttoteam = 1;
  }

  self.ref_12d2e = var0.origin;
  self.ref_12d2b = var0.angles;
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
  foreach(var1 in self.playerlist) {
    var1 scripts\mp\gametypes\br_quest_util::uiobjectivesetparameter(self.ref_12320);
  }

  var3 = scripts\mp\gametypes\br_quest_util::sortvalidplayersinarray(self.playerlist);

  foreach(var1 in var3["valid"]) {
    var1 scripts\mp\gametypes\br_quest_util::uiobjectiveshow("lep");
    scripts\mp\gametypes\br_quest_util::ref_1336c(var1);
  }

  foreach(var1 in var3["invalid"]) {
    var1 scripts\mp\gametypes\br_quest_util::uiobjectivehide();
    scripts\mp\gametypes\br_quest_util::spawn_downed_friendly(var1);
  }
}

function doreturnvo(var0) {
  scripts\mp\gametypes\br_quest_util::spawn_downed_friendly(var0);
  var0 scripts\mp\gametypes\br_quest_util::uiobjectivehide();
}

function doexfilallyidle() {
  foreach(var1 in self.playerlist) {
    doreturnvo(var1);
  }

  scripts\mp\gametypes\br_quest_util::lastdropedtime();
}

function drop_percent() {
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_lep_quest_timer_expired");
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_gen_fail", self.team, 1);
}

function dropfunc(var0, var1, var2) {
  var3 = spawn("script_model", var0);
  var4 = var2.playerlist[0];
  var3.angles = var1;
  var3 setotherent(var4);
  var3 setModel("military_loot_crate_lep_quest");
  var3 setscriptablepartstate("body", "scavenger_lep_closed");
  var3.questlocale = var2;
  var2.force_spawn_all_dead_players = var3;

  foreach(var6 in level.players) {
    if(var6 != var4 && (var4.team == "none" || var6.team != var4.team)) {
      var3 disablescriptableplayeruse(var6);
    }
  }
}

function drone_movement_vector_monitor(var0, var1, var2, var3, var4) {
  if(istrue(var3 scripts\mp\gametypes\br_gametypes::ref_12e05("playerSkipLootPickup", var0))) {
    return;
  }

  if(var2 == "scavenger_lep_closed" && isDefined(var0.entity)) {
    if(!isDefined(var0.entity.questlocale.subscribedinstances)) {
      var3 iprintlnbold("Chest Requires a Plane Crash Intel Mission");
      return;
    }

    var5 = var0.entity.questlocale.subscribedinstances[0];

    if(var3.team != var5.team) {
      var3 iprintlnbold("Chest Requires a Plane Crash Intel Mission");
      return;
    }

    var0 setscriptablepartstate("body", "scavenger_lep_opening");
    var6 = getdvarint("scr_br_scavenger_cacheDeleteDelay", 30);
    var0.entity scripts\engine\utility::delaycallwatchself(var6, &delete);
    var5 scripts\mp\gametypes\br_quest_util::ref_12b15(var3);
    var5.ref_12d30 = var0;

    switch (var0.entity.questlocale.ref_12320) {
      case 0:
        scripts\mp\gametypes\br_quest_util::search_activate_battle_station("scavenger_1", var3.team, var0.origin, var0.angles, var5.ref_12d30);
        break;
      case 1:
        scripts\mp\gametypes\br_quest_util::search_activate_battle_station("scavenger_2", var3.team, var0.origin, var0.angles, var5.ref_12d30);
        break;
      case 2:
        if(var0.entity.questlocale.ref_12320 == 2 && true) {
          scripts\mp\gametypes\br_quest_util::search_activate_battle_station("scavenger_2", var3.team, var0.origin, var0.angles, var5.ref_12d30);
          dropcount(var0);
        }

        break;
      default:
        dropcount(var0);
        break;
    }

    if(var0.entity.questlocale.ref_12320 == 3) {
      var5.ref_12d2e = var0.origin;
      var5.ref_12d2b = var0.angles;
      scripts\mp\gametypes\br_quest_util::lookforvehicles(var5.team, var3, 8, scripts\mp\gametypes\br_quest_util::getquestindex("lep"));
      docache4voskits(var5, var0.entity, var3);
    } else {
      scripts\mp\gametypes\br_quest_util::lookforvehicles(var5.team, var3, 7, scripts\mp\gametypes\br_quest_util::getquestindex("lep"));
      var7 = drone_instant_killed_monitor(var0.origin, var5.ref_12c4a[var0.entity.questlocale.ref_12320 + 1]);
      var0.entity.questlocale scripts\mp\gametypes\br_quest_util::ref_11daf("lep_locale", var7);
    }

    level notify("lootcache_opened_kill_callout" + var0.origin);
    var8 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getFriendlyPlayers")]](var3.team, 0);

    foreach(var10 in var8) {
      var10 notify("calloutmarkerping_warzoneKillQuestIcon");
    }

    return;
  }
}

function dropcount(var0) {
  var1 = [scripts\mp\gametypes\br_gametype_lep::door_parts()];

  if(!isDefined(var1) || var1.size <= 0) {
    return;
  }

  var2 = spawnStruct();
  var3 = anglesToForward((0, var0.angles[1] - -90, 0));
  var2.origin = var0.origin + var3 * 25;
  var2.angles = (0, var0.angles[1], 0);
  var2.itemsdropped = 0;
  var4 = var2 scripts\mp\gametypes\br_lootcache::ref_11a42(var1, 1, undefined);
}

function dropoff_point_spawner() {
  self.ref_12c4a = [];
  self.grenade_obj = relic_disable_health_regen(self.origin);
  var0 = self.grenade_obj.origin - self.origin;

  for(var1 = 0; var1 < 4; var1++) {
    if(var1 == 2) {
      continue;
    } else if(var1 < 2) {
      var2 = 0.333333;
      var3 = self.origin + var0 * (var1 + 1) * var2;
    } else {
      var3 = self.grenade_obj.origin + rotatevector((5500, 0, 0), (0, randomfloatrange(0, 360), 0));
    }

    var4 = drone_instant_killed_monitor(var3);
    var5 = scripts\mp\gametypes\br_quest_util::play_train_speaker_vo("lep", var4);

    if(!isDefined(var5)) {
      return false;
    }

    getlootspawnpointcount(var5.index);
    var3 = var5.origin;
    self.ref_12c4a[var1] = var5;
  }

  return true;
}

function relic_disable_health_regen(var0) {
  var1 = spawnStruct();
  var1.origin = undefined;
  var1.index = undefined;
  var2 = undefined;

  foreach(var4 in level.weapon_should_not_get_ammo) {
    var5 = 0;

    if(istrue(level.group_unset_jugg_standstill)) {
      var5 = scripts\mp\gametypes\br_circle::updatescavengerhud(var4);
    } else {
      var5 = scripts\mp\gametypes\br_circle::ispointincurrentsafecircle(var4);
    }

    if(!var5) {
      continue;
    }

    var6 = distance2d(var0, var4);

    if(!isDefined(var2) || var6 < var2) {
      var1.origin = var4;
      var1.index = var7;
      var2 = var6;
    }
  }

  return var1;
}

function dooutrovo(var0) {
  foreach(var2 in level.teamdata[var0]["players"]) {
    var2 scripts\cp\vehicles\vehicle_compass_cp::ref_120a4("lep_dis_2");
  }
}