/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\pet_watch.gsc
***********************************************/

function init() {
  if(!isDefined(level.petconsts) && !scripts\common\utility::iscp()) {
    thread checkgreenmassacre();
  }

  level.petconsts = [];

  for(var_0 = 0;; var_0++) {
    var_1 = tablelookupbyrow("mp/petWatchTable.csv", var_0, 1);
    var_1 = int(var_1);
    var_2 = spawnStruct();
    var_2.phasetime = int(tablelookupbyrow("mp/petWatchTable.csv", var_0, 2));
    var_2.bonustimemax = int(tablelookupbyrow("mp/petWatchTable.csv", var_0, 3));
    var_2.boredomrate = int(tablelookupbyrow("mp/petWatchTable.csv", var_0, 4));
    var_2.dirtyrate = int(tablelookupbyrow("mp/petWatchTable.csv", var_0, 5));
    var_2.unrulyrate = int(tablelookupbyrow("mp/petWatchTable.csv", var_0, 6));
    var_2.hungryrate = int(tablelookupbyrow("mp/petWatchTable.csv", var_0, 7));
    var_2.bonustype = tablelookupbyrow("mp/petWatchTable.csv", var_0, 8);
    var_2.boredstart = int(tablelookupbyrow("mp/petWatchTable.csv", var_0, 9));
    var_2.dirtystart = int(tablelookupbyrow("mp/petWatchTable.csv", var_0, 10));
    var_2.unrulystart = int(tablelookupbyrow("mp/petWatchTable.csv", var_0, 11));
    var_2.hungrystart = int(tablelookupbyrow("mp/petWatchTable.csv", var_0, 12));
    level.petconsts[var_1] = var_2;
  }

  LOC_00000152:
    level.ref_12309 = [];
  level.ref_12309["assist"] = 1;
  level.ref_12309["longshot"] = 1;
  level.ref_12309["pointblank"] = 1;
  level.ref_12309["headshot"] = 1;
  level.ref_12309["avenger"] = 1;
  level.ref_12309["save_teammate"] = 1;
  level.ref_12309["posthumous"] = 1;
  level.ref_12309["revenge"] = 1;
  level.ref_12309["firstblood"] = 1;
  level.ref_12309["comeback"] = 1;
  level.ref_12309["backfire"] = 1;
  level.ref_12309["quad_feed"] = 1;
  level.ref_12309["first_place_kill"] = 1;
  level.ref_12309["gun_butt"] = 1;
  level.ref_12309["mode_x_wipeout"] = 1;
  level.ref_12309["grenade_double"] = 1;
}

function checkgreenmassacre() {
  level endon("game_ended");

  for(;;) {
    foreach(var_1 in level.players) {
      if(isDefined(var_1.petwatch)) {
        feedaction(var_1);
      }
    }

    wait 1;
  }
}

function setstate(var_0, var_1) {
  self setclientomnvar("ui_pet_watch_action", var_0 * -1);
  self.petwatch.phase = var_0;
  updateuistate();
}

function doaction(var_0) {
  switch (var_0) {
    case 1:
      growpet();
      break;
    case 2:
      feedaction();
      break;
    case 3:
      thread updatepetstatesincelastupdate();
      break;
    case 4:
      initpet(1);
      break;
    case 6:
      initpet(1, "pet_black");
      break;
    case 5:
      initpet(1, "pet_turbo");
      break;
    case 7:
      initpet(1, "pet_turbo", 1);
      break;
  }
}

function growpet() {
  var_0 = level.petconsts[self.petwatch.phase].phasetime;
  self.petwatch.growthtime = var_0;
  debugsetlasttime(var_0);
}

function ref_12044() {
  self.petwatch = undefined;
}

function ref_13e38() {
  self endon("disconnect");
  self notify("turboPetChallengeWatcher()");
  self endon("turboPetChallengeWatcher()");

  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);

    if(var_0 == "petwatch_turbo_grow") {
      switch (var_1) {
        case 1:
          self reportchallengeuserevent("collect_item", "petwatch_turbo_egg");
          break;
        case 2:
          self reportchallengeuserevent("collect_item", "petwatch_turbo_baby");
          break;
        case 3:
          self reportchallengeuserevent("collect_item", "petwatch_turbo_child");
          break;
        case 4:
          self reportchallengeuserevent("collect_item", "petwatch_turbo_teen_a");
          break;
        case 5:
          self reportchallengeuserevent("collect_item", "petwatch_turbo_teen_b");
          break;
        case 6:
          self reportchallengeuserevent("collect_item", "petwatch_turbo_skunk");
          break;
        case 7:
          self reportchallengeuserevent("collect_item", "petwatch_turbo_bear");
          break;
        case 8:
          self reportchallengeuserevent("collect_item", "petwatch_turbo_mantis");
          break;
        case 9:
          self reportchallengeuserevent("collect_item", "petwatch_turbo_trex");
          break;
        case 10:
          self reportchallengeuserevent("collect_item", "petwatch_turbo_octopus");
          break;
        case 11:
          self reportchallengeuserevent("collect_item", "petwatch_turbo_fox");
          break;
        case 12:
          self reportchallengeuserevent("collect_item", "petwatch_turbo_secret1");
          break;
        case 13:
          self reportchallengeuserevent("collect_item", "petwatch_turbo_secret2");
          break;
        case 14:
          self reportchallengeuserevent("collect_item", "petwatch_turbo_secret3");
          break;
        default:
          break;
      }

      continue;
    }

    if(var_0 == "petwatch_turbo_state") {
      self setclientomnvar("ui_pet_watch_state", var_1);
    }
  }
}

function initpet(var_0, var_1, var_2) {
  if(!isDefined(self.petwatch)) {
    self setclientomnvar("ui_pet_watch_state", 0);
    self.petwatch = spawnStruct();
    self.petwatch.ref_12314 = var_1;

    if(var_1 == "pet_black") {
      self.petwatch.ref_12533 = "petWatchDataBlack";
    } else if(var_1 == "pet_turbo") {
      self.petwatch.ref_12533 = "petWatchDataTurbo";
      thread ref_13e38();
    } else {
      self.petwatch.ref_12533 = "petWatchData";
    }

    if(var_0 && !istrue(var_2)) {
      self setclientomnvar("ui_pet_watch_action", -1);
      setphase(0);
    } else {
      setphase(self getplayerdata("common", self.petwatch.ref_12533, "phase"));
    }
  } else {
    if(var_0) {
      self setclientomnvar("ui_pet_watch_action", -1);
      setphase(0);
    }

    if(self.petwatch.phase == 0) {
      resetpet(1);
    }

    if(!istrue(var_0)) {
      return;
    }
  }

  self.petwatch.isvalidcustomweapon = 0;

  if(self.petwatch.phase == 0) {
    resetpet(1);
  } else {
    self.petwatch.bonustime = 0;
    self.petwatch.currentbestdist = 0;
    self.petwatch.lastupdatetime = self getplayerdata("common", self.petwatch.ref_12533, "lastUpdateTime");
    self.petwatch.bored = self getplayerdata("common", self.petwatch.ref_12533, "boredDmg");
    self.petwatch.dirty = self getplayerdata("common", self.petwatch.ref_12533, "dirtyDmg");
    self.petwatch.unruly = self getplayerdata("common", self.petwatch.ref_12533, "unrulyDmg");
    self.petwatch.hungry = self getplayerdata("common", self.petwatch.ref_12533, "hungryDmg");
    self.petwatch.currentbestdist = self getplayerdata("common", self.petwatch.ref_12533, "bonusTime");
    self.petwatch.charged = self getplayerdata("common", self.petwatch.ref_12533, "charged");
    self.petwatch.growthtime = self getplayerdata("common", self.petwatch.ref_12533, "growthTime");
    self.petwatch.reproductionstreak = self getplayerdata("common", self.petwatch.ref_12533, "reproductionStreak");
    self.petwatch.damage = self getplayerdata("common", self.petwatch.ref_12533, "damage");
    self.petwatch.waittill_player_pings_location = self.petwatch.bored;
    self.petwatch.waittillarenaplayersnotcapturing = self.petwatch.dirty;
    self.petwatch.watch_for_players_in_plane_trigger = self.petwatch.unruly;
    self.petwatch.waittoshow = self.petwatch.hungry;
    var_3 = self.petwatch.reproductionstreak % 10;
    var_4 = var_3 / 10;
    self.petwatch.growthtime += var_4;
    self.petwatch.currentbestdist += var_4;
    self.petwatch.reproductionstreak = int(self.petwatch.reproductionstreak / 10);
    self.petwatch.ref_13f07 = self getplayerdata("common", self.petwatch.ref_12533, "orcaPoints");
    self.petwatch.ref_140e2 = self getplayerdata("common", self.petwatch.ref_12533, "apachePoints");
    self.petwatch.dragonpoints = self getplayerdata("common", self.petwatch.ref_12533, "dragonPoints");
    self.petwatch.current_volume_num = self getplayerdata("common", self.petwatch.ref_12533, "killstreakCharge");
    self.petwatch.currentbestpos = self getplayerdata("common", self.petwatch.ref_12533, "winGamesCharge");
    self.petwatch.current_zone = self getplayerdata("common", self.petwatch.ref_12533, "objectiveScoreCharge");
    self.petwatch.current_volume_enemy = self getplayerdata("common", self.petwatch.ref_12533, "killsCharge");
    self.petwatch.topkillstreakcharge = self getplayerdata("common", self.petwatch.ref_12533, "topKillstreakCharge");
    self.petwatch.nukecharge = self getplayerdata("common", self.petwatch.ref_12533, "nukeCharge");
    self.petwatch.wingamestop3 = self getplayerdata("common", self.petwatch.ref_12533, "winGamesTop3");
    self.petwatch.plantscharge = self getplayerdata("common", self.petwatch.ref_12533, "plantsCharge");
    self.petwatch.executionscharge = self getplayerdata("common", self.petwatch.ref_12533, "executionsCharge");
    self.petwatch.objectivescorecharge = 0;
    self.petwatch.killstreakcharge = 0;
    self.petwatch.wingamescharge = 0;
    self.petwatch.killscharge = 0;
    self.petwatch.waittothrowsmoke = 0;
    self.petwatch.waittill_player_uses_assassination_contract = 0;
    self.petwatch.watch_for_players_joining = 0;
    self.petwatch.waittillhuntersdrop = 0;
  }

  updateuistate();
}

function gethours(var_0) {
  var_1 = 3600;
  return int(var_0 / var_1);
}

function gethourtime(var_0) {
  var_1 = 3600;
  var_2 = 24 * var_1;
  var_3 = var_2 * 365.25;
  var_4 = var_0 / int(var_3);
  var_5 = int(var_0 % var_3) / int(var_2);
  var_6 = int(var_0 % var_2) / int(var_1);
  return int(var_6);
}

function testtiming() {
  var_0 = getsystemtime();
  var_1 = var_0 - 300;
  var_2 = var_0 - 7200;
  var_3 = var_0 - 3480;
  var_4 = var_0 - 3720;
  var_5 = var_0 - 43200;
  var_6 = var_0 - 86400;
  var_7 = var_6 - 43200;
  var_8 = var_0 - 604800;
  var_9 = hoursawakesincelastupdate(var_0, var_1).spawn_real_number;
  var_10 = hoursawakesincelastupdate(var_0, var_3).spawn_real_number;
  var_11 = hoursawakesincelastupdate(var_0, var_4).spawn_real_number;
  var_12 = hoursawakesincelastupdate(var_0, var_2).spawn_real_number;
  var_13 = hoursawakesincelastupdate(var_0, var_5).spawn_real_number;
  var_14 = hoursawakesincelastupdate(var_0, var_6).spawn_real_number;
  var_15 = hoursawakesincelastupdate(var_0, var_7).spawn_real_number;
  var_16 = hoursawakesincelastupdate(var_0, var_8).spawn_real_number;
  var_17 = 1;
}

function printplayerdatastats() {
  var_0 = self getplayerdata("common", self.petwatch.ref_12533, "phase");
  var_1 = self getplayerdata("common", self.petwatch.ref_12533, "lastUpdateTime");
  var_2 = self getplayerdata("common", self.petwatch.ref_12533, "boredDmg");
  var_3 = self getplayerdata("common", self.petwatch.ref_12533, "dirtyDmg");
  var_4 = self getplayerdata("common", self.petwatch.ref_12533, "unrulyDmg");
  var_5 = self getplayerdata("common", self.petwatch.ref_12533, "hungryDmg");
  var_6 = self getplayerdata("common", self.petwatch.ref_12533, "bonusTime");
  var_7 = self getplayerdata("common", self.petwatch.ref_12533, "charged");
  var_8 = self getplayerdata("common", self.petwatch.ref_12533, "growthTime");
  var_9 = self getplayerdata("common", self.petwatch.ref_12533, "reproductionStreak");
  var_10 = self getplayerdata("common", self.petwatch.ref_12533, "damage");
  var_11 = self getplayerdata("common", self.petwatch.ref_12533, "orcaPoints");
  var_12 = self getplayerdata("common", self.petwatch.ref_12533, "apachePoints");
  var_13 = self getplayerdata("common", self.petwatch.ref_12533, "dragonPoints");
  var_14 = self getplayerdata("common", self.petwatch.ref_12533, "killstreakCharge");
  var_15 = self getplayerdata("common", self.petwatch.ref_12533, "winGamesCharge");
  var_16 = self getplayerdata("common", self.petwatch.ref_12533, "objectiveScoreCharge");
  var_17 = self getplayerdata("common", self.petwatch.ref_12533, "killsCharge");
  var_18 = self getplayerdata("common", self.petwatch.ref_12533, "topKillstreakCharge");
  var_19 = self getplayerdata("common", self.petwatch.ref_12533, "nukeCharge");
  var_20 = self getplayerdata("common", self.petwatch.ref_12533, "winGamesTop3");
  var_21 = self getplayerdata("common", self.petwatch.ref_12533, "plantsCharge");
  var_22 = self getplayerdata("common", self.petwatch.ref_12533, "executionsCharge");
}

function testpetdebug(var_0) {
  if(var_0 > 16 && !isDefined(self.petwatch)) {
    initpet(1, "pet_turbo");
  }

  if(!isDefined(self.petwatch)) {
    return;
  }

  switch (var_0) {
    case 1:
      testtiming();
      break;
    case 2:
      printplayerdatastats();
      break;
    case 3:
      addkillcharge();
      break;
    case 4:
      begin_spectate();
      break;
    case 5:
      addobjectivescorecharge("debug", 1);
      break;
    case 6:
      addobjectivescorecharge("debug", 10);
      break;
    case 7:
      addwatchchargewin();
      break;
    case 8:
      addplantingcharge();
      break;
    case 9:
      addexecutioncharge();
      break;
    case 10:
      addwatchchargewintop3();
      break;
    case 11:
      addtopkillstreakcharge();
      break;
    case 12:
      addnukecharge();
      break;
    case 13:
      self.petwatch.damage = 0;
      updateuistate();
      break;
    case 14:
      self.petwatch.damage = 900;
      updateuistate();
      break;
    case 15:
      self.petwatch.damage = 500;
      updateuistate();
      break;
    case 16:
      addkillstreakcharge();
      break;
    case 17:
      self setclientomnvar("ui_smart_watch_interact", 2);
      break;
    case 18:
      self setclientomnvar("ui_smart_watch_interact", 3);
      break;
    case 19:
      self setclientomnvar("ui_smart_watch_interact", 4);
      break;
    case 20:
      self notify("luinotifyserver", "petwatch_turbo_grow", 1);
      break;
    case 21:
      self notify("luinotifyserver", "petwatch_turbo_grow", 2);
      break;
    case 22:
      self notify("luinotifyserver", "petwatch_turbo_grow", 3);
      break;
  }
}

function hoursawakesincelastupdate(var_0, var_1, var_2) {
  var_3 = gethourtime(var_0);
  var_4 = gethours(var_0 - var_1);
  var_5 = max(0, var_4);
  var_6 = spawnStruct();
  var_6.spawn_real_number = var_5;
  return var_6;
}

function updatepetstatesincelastupdate(var_0) {
  self endon("disconnect");
}

function begin_vo() {
  if(isDefined(self.petwatch) && self.petwatch.ref_12314 == "pet_turbo") {
    self.petwatch.wingamescharge++;
    self setclientomnvar("ui_pet_watch_bonus_earned_0", 80000 + self.petwatch.wingamescharge);
    return;
  }
}

function addkillstreakcharge() {
  if(isDefined(self.petwatch) && self.petwatch.ref_12314 == "pet_turbo") {
    self.petwatch.current_volume_num++;
    self.petwatch.killstreakcharge++;
    self setclientomnvar("ui_pet_watch_bonus_earned_1", 30000 + self.petwatch.killstreakcharge);
    return;
  }
}

function battle_tracks_getplayerdataenum() {
  if(isDefined(self.petwatch) && self.petwatch.ref_12314 == "pet_turbo") {
    self setclientomnvar("ui_pet_watch_bonus_earned_2", 20000);
    return;
  }
}

function bearwatch() {
  if(isDefined(self.petwatch) && self.petwatch.ref_12314 == "pet_turbo") {
    self.petwatch.plantscharge++;
    self setclientomnvar("ui_pet_watch_bonus_earned_0", 40000 + self.petwatch.plantscharge);
    return;
  }
}

function battle_tracks_vehicleallowlisteningoutsideoccupancy() {
  if(isDefined(self.petwatch) && self.petwatch.ref_12314 == "pet_turbo") {
    self setclientomnvar("ui_pet_watch_bonus_earned_0", 40000);
    return;
  }
}

function battle_tracks_standingonsamevehiclewithsametracksowner() {
  if(isDefined(self.petwatch) && self.petwatch.ref_12314 == "pet_turbo") {
    self.petwatch.nukecharge++;
    self setclientomnvar("ui_pet_watch_bonus_earned_4", 10000 + self.petwatch.nukecharge);
    return;
  }
}

function bhasriotshieldattached() {
  if(isDefined(self.petwatch) && self.petwatch.ref_12314 == "pet_turbo") {
    self.petwatch.wingamestop3++;
    self setclientomnvar("ui_pet_watch_bonus_earned_1", 90000 + self.petwatch.wingamestop3);
    return;
  }
}

function round_vehicle_logic() {
  var_0 = level.gametype;

  if(var_0 == "br") {
    var_1 = getDvar("scr_br_gametype", "");

    if(var_1 != "") {
      return var_1;
    }
  }

  return var_0;
}

function below_player_eye_allowance() {
  var_0 = round_vehicle_logic();

  if(level.gametype == "br" && (var_0 == "br" || var_0 == "jugg" || var_0 == "mini")) {
    if(isDefined(self.petwatch) && self.petwatch.ref_12314 == "pet_turbo") {
      self setclientomnvar("ui_pet_watch_bonus_earned_1", 90000);
      return;
    }

    return;
  }
}

function bhasthermitestucktoshield() {
  if(isDefined(self.petwatch) && self.petwatch.ref_12314 == "pet_turbo") {
    self setclientomnvar("ui_pet_watch_bonus_earned_0", 80000);
    return;
  }
}

function ref_13fbd() {
  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getTeamData")) {
    return;
  }

  var_0 = game["roundsPlayed"];

  foreach(var_2 in level.teamnamelist) {
    var_3 = game["roundsWon"][var_2];
    var_4 = var_3 / level.winlimit;
    var_5 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getTeamData")]](var_2, "players");

    foreach(var_7 in var_5) {
      if(isDefined(var_7.petwatch) && var_7.petwatch.ref_12314 == "pet_turbo") {
        ref_13e23(var_7, var_4, 2);
      }
    }
  }
}

function ref_13e23(var_0, var_1) {
  if(isDefined(self.petwatch) && self.petwatch.ref_12314 == "pet_turbo") {
    var_0 = min(1, var_0);
    self setclientomnvar("ui_pet_watch_bonus_earned_4", 50000 + int(var_0 * 10) + var_1 * 100);
    return;
  }
}

function ref_13c43(var_0) {
  if(isDefined(self.petwatch) && self.petwatch.ref_12314 == "pet_turbo") {
    if(!isDefined(var_0.get_search_node_closest_to_spotlight_goal_node)) {
      var_0.get_search_node_closest_to_spotlight_goal_node = [];
      var_0.get_safe_set_spawn_weapons = [];
    }

    var_1 = -1;

    foreach(var_3 in var_0.get_search_node_closest_to_spotlight_goal_node) {
      if(var_3 == self) {
        var_1 = var_4;
        break;
      }
    }

    if(var_1 == -1) {
      var_1 = var_0.get_search_node_closest_to_spotlight_goal_node.size;
      var_0.get_search_node_closest_to_spotlight_goal_node[var_1] = self;
      var_0.get_safe_set_spawn_weapons[var_1] = 1;
    } else {
      var_0.get_safe_set_spawn_weapons[var_1]++;
    }

    ref_13e23(var_0.get_safe_set_spawn_weapons[var_1] / 10, 3);
    return;
  }
}

function getfullweaponobjforscriptablepartname() {
  if(isDefined(self.get_search_node_closest_to_spotlight_goal_node)) {
    var_0 = 0;

    foreach(var_2 in self.get_search_node_closest_to_spotlight_goal_node) {
      var_3 = isDefined(var_2.petwatch) && var_2.petwatch.ref_12314 == "pet_turbo";

      if(!var_3) {
        continue;
      }

      var_0 = self.get_safe_set_spawn_weapons[var_4];

      if(var_0 >= 10) {
        var_2 setclientomnvar("ui_pet_watch_bonus_earned_1", 10000);
      }
    }

    return;
  }
}

function getfullweaponobjforpickup(var_0) {
  if(isDefined(self.petwatch) && self.petwatch.ref_12314 == "pet_turbo") {
    if(isDefined(var_0.get_search_node_closest_to_spotlight_goal_node)) {
      var_1 = 0;

      foreach(var_3 in var_0.get_search_node_closest_to_spotlight_goal_node) {
        if(var_3 == self) {
          var_1 = var_0.get_safe_set_spawn_weapons[var_4];
          break;
        }
      }

      if(var_1 >= 10) {
        self setclientomnvar("ui_pet_watch_bonus_earned_1", 10000);
        return;
      }

      return;
    }

    return;
  }
}

function addnukecharge() {
  if(isDefined(self.petwatch)) {
    self.petwatch.nukecharge++;
    var_0 = 10000 + self.petwatch.nukecharge;

    if(self.petwatch.ref_12314 == "pet_turbo") {
      var_0 += 100;
    }

    self setclientomnvar("ui_pet_watch_bonus_earned_4", var_0);
    return;
  }
}

function addtopkillstreakcharge() {
  if(isDefined(self.petwatch)) {
    self.petwatch.topkillstreakcharge++;
    self setclientomnvar("ui_pet_watch_bonus_earned_2", 20000 + self.petwatch.topkillstreakcharge);
    return;
  }
}

function battle_tracks_getnewtogglestate() {
  if(isDefined(self.petwatch)) {
    self setclientomnvar("ui_pet_watch_bonus_earned_2", 20001);
    return;
  }
}

function addplantingcharge() {
  if(isDefined(self.petwatch) && self.petwatch.ref_12314 != "pet_turbo") {
    self.petwatch.plantscharge++;
    self setclientomnvar("ui_pet_watch_bonus_earned_0", 40000 + self.petwatch.plantscharge);
    return;
  }
}

function addobjectivescorecharge(var_0, var_1) {
  if(isDefined(self.petwatch) && self.petwatch.ref_12314 != "pet_turbo" && !istrue(level.ref_12309[var_0]) && !issubstr(var_0, "kill")) {
    self.petwatch.current_zone += var_1;
    self.petwatch.objectivescorecharge += var_1;
    self setclientomnvar("ui_pet_watch_bonus_earned_3", 50000 + self.petwatch.objectivescorecharge);
    return;
  }
}

function begin_spectate() {
  if(isDefined(self.petwatch)) {
    self.petwatch.killscharge += 10;
    self.petwatch.current_volume_enemy += 10;
    self setclientomnvar("ui_pet_watch_bonus_earned_0", 60000 + self.petwatch.killscharge);
    return;
  }
}

function addkillcharge() {
  if(isDefined(self.petwatch)) {
    self.petwatch.killscharge++;
    self.petwatch.current_volume_enemy++;
    self setclientomnvar("ui_pet_watch_bonus_earned_0", 60000 + self.petwatch.killscharge);
    return;
  }
}

function addexecutioncharge() {
  if(isDefined(self.petwatch)) {
    self.petwatch.executionscharge++;
    self setclientomnvar("ui_pet_watch_bonus_earned_1", 70000 + self.petwatch.executionscharge);
    return;
  }
}

function addwatchchargewin() {
  if(isDefined(self.petwatch) && self.petwatch.ref_12314 != "pet_turbo") {
    self.petwatch.currentbestpos++;
    self.petwatch.wingamescharge++;
    self setclientomnvar("ui_pet_watch_bonus_earned_0", 80000 + self.petwatch.wingamescharge);
    feedaction();
    return;
  }
}

function addwatchchargewintop3() {
  if(isDefined(self.petwatch) && self.petwatch.ref_12314 != "pet_turbo") {
    self.petwatch.wingamestop3++;
    self setclientomnvar("ui_pet_watch_bonus_earned_1", 90000 + self.petwatch.wingamestop3);
    return;
  }
}

function ref_1230a() {
  self endon("disconnect");
  self endon("cancel_pet_plunder_timer");
  self.petwatch.ref_127cf = 1;
  var_0 = 180;
  var_1 = var_0 / 5;

  for(var_2 = 1; var_2 <= 5; var_2++) {
    wait var_1;
    ref_13e23(var_2 / 5, 4);
  }

  battle_tracks_vehicleallowlisteningoutsideoccupancy();
}

function ref_13ffd(var_0) {
  if(isDefined(self.petwatch) && self.petwatch.ref_12314 == "pet_turbo") {
    ref_13e23(var_0, 1);
    return;
  }
}

function ref_1206d() {
  if(isDefined(self.petwatch) && self.petwatch.ref_12314 == "pet_turbo") {
    if(self.plundercount > 5000) {
      if(!isDefined(self.petwatch.ref_127cf)) {
        thread ref_1230a();
        return;
      }

      return;
    }

    if(isDefined(self.petwatch.ref_127cf)) {
      self notify("cancel_pet_plunder_timer");
      self.petwatch.ref_127cf = undefined;
      ref_13e23(0, 0);
      return;
    }

    return;
  }
}

function setphase(var_0) {
  self.petwatch.phase = var_0;
  self.pers["petWatchData_phase"] = var_0;
}

function updateuistate() {
  var_0 = 0;

  if(self.petwatch.bored < 0) {
    var_0 += 20;
  }

  if(self.petwatch.dirty < 0) {
    var_0 += 100;
  }

  if(self.petwatch.unruly < 0) {
    var_0 += 1000;
  }

  if(self.petwatch.hungry < 0) {
    var_0 += 10000;
  }

  var_1 = int(self.petwatch.damage / 100) - 1;
  var_1 = int(max(0, min(var_1, 9)));
  var_0 += 100000 * var_1;
  var_2 = var_0 + self.petwatch.phase;
  self setclientomnvar("ui_pet_watch_state", var_2);
}

function ref_12c76() {
  self.petwatch.bored = level.petconsts[self.petwatch.phase].boredstart;
  self.petwatch.dirty = level.petconsts[self.petwatch.phase].dirtystart;
  self.petwatch.unruly = level.petconsts[self.petwatch.phase].unrulystart;
  self.petwatch.hungry = level.petconsts[self.petwatch.phase].hungrystart;
  self.petwatch.waittothrowsmoke = 0;
  self.petwatch.waittill_player_uses_assassination_contract = 0;
  self.petwatch.watch_for_players_joining = 0;
  self.petwatch.waittillhuntersdrop = 0;
  self.petwatch.charged = 0;
  self.petwatch.growthtime = 0;
  self.petwatch.currentbestdist = 0;
  self.petwatch.bonustime = 0;
  self.petwatch.damage = 0;
  self.petwatch.ref_13f07 = 0;
  self.petwatch.ref_140e2 = 0;
  self.petwatch.dragonpoints = 0;
  self.petwatch.current_volume_num = 0;
  self.petwatch.killstreakcharge = 0;
  self.petwatch.currentbestpos = 0;
  self.petwatch.wingamescharge = 0;
  self.petwatch.current_zone = 0;
  self.petwatch.objectivescorecharge = 0;
  self.petwatch.current_volume_enemy = 0;
  self.petwatch.killscharge = 0;
  self.petwatch.topkillstreakcharge = 0;
  self.petwatch.nukecharge = 0;
  self.petwatch.wingamestop3 = 0;
  self.petwatch.plantscharge = 0;
  self.petwatch.executionscharge = 0;
}

function resetpet(var_0, var_1) {
  if(isDefined(var_1)) {
    setphase(var_1);
  } else {
    setphase(1);
  }

  self.petwatch.lastupdatetime = getsystemtime();
  ref_12c76();
}

function debugsetlasttime(var_0) {
  self setclientomnvar("ui_pet_watch_action", var_0);
}

function feedaction() {
  if(!isDefined(self.petwatch)) {
    return;
  }

  if(self.petwatch.ref_12314 == "pet_turbo") {
    return;
  }

  if(self.petwatch.phase == 15) {
    return;
  }

  var_0 = self.petwatch.killstreakcharge * 20;
  var_1 = self.petwatch.wingamescharge * 20;
  var_2 = self.petwatch.objectivescorecharge * 0.5;
  var_3 = self.petwatch.killscharge * 1;
  var_4 = self.petwatch.waittothrowsmoke < var_3;
  var_5 = self.petwatch.waittillhuntersdrop < var_1;
  var_6 = self.petwatch.waittill_player_uses_assassination_contract < var_0;
  var_7 = self.petwatch.watch_for_players_joining < var_2;

  if(!var_4 && !var_5 && !var_6 && !var_7) {
    return;
  }

  var_0 = max(-240, min(var_0, 240));
  var_1 = max(-240, min(var_1, 240));
  var_2 = max(-240, min(var_2, 240));
  var_3 = max(-240, min(var_3, 240));

  if(var_5) {
    var_1 = int(var_1);

    if(var_1 == 0) {
      var_1 = 1;
    }

    self setclientomnvar("ui_pet_watch_health_dirty", var_1);
  }

  if(var_7) {
    var_2 = int(var_2);

    if(var_2 == 0) {
      var_2 = 1;
    }

    self setclientomnvar("ui_pet_watch_health_unruly", int(var_2));
  }

  if(var_4) {
    var_3 = int(var_3);

    if(var_3 == 0) {
      var_3 = 1;
    }

    self setclientomnvar("ui_pet_watch_health_hungry", int(var_3));
  }

  if(var_6) {
    var_0 = int(var_0);

    if(var_0 == 0) {
      var_0 = 1;
    }

    self setclientomnvar("ui_pet_watch_health_bored", int(var_0));
  }

  self.petwatch.waittothrowsmoke = var_3;
  self.petwatch.waittillhuntersdrop = var_1;
  self.petwatch.waittill_player_uses_assassination_contract = var_0;
  self.petwatch.watch_for_players_joining = var_2;
  self.petwatch.topkillstreakcharge = 0;
  self.petwatch.nukecharge = 0;
  self.petwatch.wingamestop3 = 0;
  self.petwatch.plantscharge = 0;
  self.petwatch.executionscharge = 0;
  self.petwatch.bored = var_0;
  self.petwatch.dirty = var_1;
  self.petwatch.unruly = var_2;
  self.petwatch.hungry = var_3;
}