/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\pet_watch.gsc
***********************************************/

function init() {
  if(!isDefined(level.petconsts) && !scripts\common\utility::iscp()) {
    thread checkgreenmassacre();
  }

  level.petconsts = [];

  for(var0 = 0;; var0++) {
    var1 = tablelookupbyrow("mp/petWatchTable.csv", var0, 1);
    var1 = int(var1);
    var2 = spawnStruct();
    var2.phasetime = int(tablelookupbyrow("mp/petWatchTable.csv", var0, 2));
    var2.bonustimemax = int(tablelookupbyrow("mp/petWatchTable.csv", var0, 3));
    var2.boredomrate = int(tablelookupbyrow("mp/petWatchTable.csv", var0, 4));
    var2.dirtyrate = int(tablelookupbyrow("mp/petWatchTable.csv", var0, 5));
    var2.unrulyrate = int(tablelookupbyrow("mp/petWatchTable.csv", var0, 6));
    var2.hungryrate = int(tablelookupbyrow("mp/petWatchTable.csv", var0, 7));
    var2.bonustype = tablelookupbyrow("mp/petWatchTable.csv", var0, 8);
    var2.boredstart = int(tablelookupbyrow("mp/petWatchTable.csv", var0, 9));
    var2.dirtystart = int(tablelookupbyrow("mp/petWatchTable.csv", var0, 10));
    var2.unrulystart = int(tablelookupbyrow("mp/petWatchTable.csv", var0, 11));
    var2.hungrystart = int(tablelookupbyrow("mp/petWatchTable.csv", var0, 12));
    level.petconsts[var1] = var2;
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
    foreach(var1 in level.players) {
      if(isDefined(var1.petwatch)) {
        feedaction(var1);
      }
    }

    wait 1;
  }
}

function setstate(var0, var1) {
  self setclientomnvar("ui_pet_watch_action", var0 * -1);
  self.petwatch.phase = var0;
  updateuistate();
}

function doaction(var0) {
  switch (var0) {
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
  var0 = level.petconsts[self.petwatch.phase].phasetime;
  self.petwatch.growthtime = var0;
  debugsetlasttime(var0);
}

function ref_12044() {
  self.petwatch = undefined;
}

function ref_13e38() {
  self endon("disconnect");
  self notify("turboPetChallengeWatcher()");
  self endon("turboPetChallengeWatcher()");

  for(;;) {
    self waittill("luinotifyserver", var0, var1);

    if(var0 == "petwatch_turbo_grow") {
      switch (var1) {
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

    if(var0 == "petwatch_turbo_state") {
      self setclientomnvar("ui_pet_watch_state", var1);
    }
  }
}

function initpet(var0, var1, var2) {
  if(!isDefined(self.petwatch)) {
    self setclientomnvar("ui_pet_watch_state", 0);
    self.petwatch = spawnStruct();
    self.petwatch.ref_12314 = var1;

    if(var1 == "pet_black") {
      self.petwatch.ref_12533 = "petWatchDataBlack";
    } else if(var1 == "pet_turbo") {
      self.petwatch.ref_12533 = "petWatchDataTurbo";
      thread ref_13e38();
    } else {
      self.petwatch.ref_12533 = "petWatchData";
    }

    if(var0 && !istrue(var2)) {
      self setclientomnvar("ui_pet_watch_action", -1);
      setphase(0);
    } else {
      setphase(self getplayerdata("common", self.petwatch.ref_12533, "phase"));
    }
  } else {
    if(var0) {
      self setclientomnvar("ui_pet_watch_action", -1);
      setphase(0);
    }

    if(self.petwatch.phase == 0) {
      resetpet(1);
    }

    if(!istrue(var0)) {
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
    var3 = self.petwatch.reproductionstreak % 10;
    var4 = var3 / 10;
    self.petwatch.growthtime += var4;
    self.petwatch.currentbestdist += var4;
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

function gethours(var0) {
  var1 = 3600;
  return int(var0 / var1);
}

function gethourtime(var0) {
  var1 = 3600;
  var2 = 24 * var1;
  var3 = var2 * 365.25;
  var4 = var0 / int(var3);
  var5 = int(var0 % var3) / int(var2);
  var6 = int(var0 % var2) / int(var1);
  return int(var6);
}

function testtiming() {
  var0 = getsystemtime();
  var1 = var0 - 300;
  var2 = var0 - 7200;
  var3 = var0 - 3480;
  var4 = var0 - 3720;
  var5 = var0 - 43200;
  var6 = var0 - 86400;
  var7 = var6 - 43200;
  var8 = var0 - 604800;
  var9 = hoursawakesincelastupdate(var0, var1).spawn_real_number;
  var10 = hoursawakesincelastupdate(var0, var3).spawn_real_number;
  var11 = hoursawakesincelastupdate(var0, var4).spawn_real_number;
  var12 = hoursawakesincelastupdate(var0, var2).spawn_real_number;
  var13 = hoursawakesincelastupdate(var0, var5).spawn_real_number;
  var14 = hoursawakesincelastupdate(var0, var6).spawn_real_number;
  var15 = hoursawakesincelastupdate(var0, var7).spawn_real_number;
  var16 = hoursawakesincelastupdate(var0, var8).spawn_real_number;
  var17 = 1;
}

function printplayerdatastats() {
  var0 = self getplayerdata("common", self.petwatch.ref_12533, "phase");
  var1 = self getplayerdata("common", self.petwatch.ref_12533, "lastUpdateTime");
  var2 = self getplayerdata("common", self.petwatch.ref_12533, "boredDmg");
  var3 = self getplayerdata("common", self.petwatch.ref_12533, "dirtyDmg");
  var4 = self getplayerdata("common", self.petwatch.ref_12533, "unrulyDmg");
  var5 = self getplayerdata("common", self.petwatch.ref_12533, "hungryDmg");
  var6 = self getplayerdata("common", self.petwatch.ref_12533, "bonusTime");
  var7 = self getplayerdata("common", self.petwatch.ref_12533, "charged");
  var8 = self getplayerdata("common", self.petwatch.ref_12533, "growthTime");
  var9 = self getplayerdata("common", self.petwatch.ref_12533, "reproductionStreak");
  var10 = self getplayerdata("common", self.petwatch.ref_12533, "damage");
  var11 = self getplayerdata("common", self.petwatch.ref_12533, "orcaPoints");
  var12 = self getplayerdata("common", self.petwatch.ref_12533, "apachePoints");
  var13 = self getplayerdata("common", self.petwatch.ref_12533, "dragonPoints");
  var14 = self getplayerdata("common", self.petwatch.ref_12533, "killstreakCharge");
  var15 = self getplayerdata("common", self.petwatch.ref_12533, "winGamesCharge");
  var16 = self getplayerdata("common", self.petwatch.ref_12533, "objectiveScoreCharge");
  var17 = self getplayerdata("common", self.petwatch.ref_12533, "killsCharge");
  var18 = self getplayerdata("common", self.petwatch.ref_12533, "topKillstreakCharge");
  var19 = self getplayerdata("common", self.petwatch.ref_12533, "nukeCharge");
  var20 = self getplayerdata("common", self.petwatch.ref_12533, "winGamesTop3");
  var21 = self getplayerdata("common", self.petwatch.ref_12533, "plantsCharge");
  var22 = self getplayerdata("common", self.petwatch.ref_12533, "executionsCharge");
}

function testpetdebug(var0) {
  if(var0 > 16 && !isDefined(self.petwatch)) {
    initpet(1, "pet_turbo");
  }

  if(!isDefined(self.petwatch)) {
    return;
  }

  switch (var0) {
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

function hoursawakesincelastupdate(var0, var1, var2) {
  var3 = gethourtime(var0);
  var4 = gethours(var0 - var1);
  var5 = max(0, var4);
  var6 = spawnStruct();
  var6.spawn_real_number = var5;
  return var6;
}

function updatepetstatesincelastupdate(var0) {
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
  var0 = level.gametype;

  if(var0 == "br") {
    var1 = getDvar("scr_br_gametype", "");

    if(var1 != "") {
      return var1;
    }
  }

  return var0;
}

function below_player_eye_allowance() {
  var0 = round_vehicle_logic();

  if(level.gametype == "br" && (var0 == "br" || var0 == "jugg" || var0 == "mini")) {
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

  var0 = game["roundsPlayed"];

  foreach(var2 in level.teamnamelist) {
    var3 = game["roundsWon"][var2];
    var4 = var3 / level.winlimit;
    var5 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getTeamData")]](var2, "players");

    foreach(var7 in var5) {
      if(isDefined(var7.petwatch) && var7.petwatch.ref_12314 == "pet_turbo") {
        ref_13e23(var7, var4, 2);
      }
    }
  }
}

function ref_13e23(var0, var1) {
  if(isDefined(self.petwatch) && self.petwatch.ref_12314 == "pet_turbo") {
    var0 = min(1, var0);
    self setclientomnvar("ui_pet_watch_bonus_earned_4", 50000 + int(var0 * 10) + var1 * 100);
    return;
  }
}

function ref_13c43(var0) {
  if(isDefined(self.petwatch) && self.petwatch.ref_12314 == "pet_turbo") {
    if(!isDefined(var0.get_search_node_closest_to_spotlight_goal_node)) {
      var0.get_search_node_closest_to_spotlight_goal_node = [];
      var0.get_safe_set_spawn_weapons = [];
    }

    var1 = -1;

    foreach(var3 in var0.get_search_node_closest_to_spotlight_goal_node) {
      if(var3 == self) {
        var1 = var4;
        break;
      }
    }

    if(var1 == -1) {
      var1 = var0.get_search_node_closest_to_spotlight_goal_node.size;
      var0.get_search_node_closest_to_spotlight_goal_node[var1] = self;
      var0.get_safe_set_spawn_weapons[var1] = 1;
    } else {
      var0.get_safe_set_spawn_weapons[var1]++;
    }

    ref_13e23(var0.get_safe_set_spawn_weapons[var1] / 10, 3);
    return;
  }
}

function getfullweaponobjforscriptablepartname() {
  if(isDefined(self.get_search_node_closest_to_spotlight_goal_node)) {
    var0 = 0;

    foreach(var2 in self.get_search_node_closest_to_spotlight_goal_node) {
      var3 = isDefined(var2.petwatch) && var2.petwatch.ref_12314 == "pet_turbo";

      if(!var3) {
        continue;
      }

      var0 = self.get_safe_set_spawn_weapons[var4];

      if(var0 >= 10) {
        var2 setclientomnvar("ui_pet_watch_bonus_earned_1", 10000);
      }
    }

    return;
  }
}

function getfullweaponobjforpickup(var0) {
  if(isDefined(self.petwatch) && self.petwatch.ref_12314 == "pet_turbo") {
    if(isDefined(var0.get_search_node_closest_to_spotlight_goal_node)) {
      var1 = 0;

      foreach(var3 in var0.get_search_node_closest_to_spotlight_goal_node) {
        if(var3 == self) {
          var1 = var0.get_safe_set_spawn_weapons[var4];
          break;
        }
      }

      if(var1 >= 10) {
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
    var0 = 10000 + self.petwatch.nukecharge;

    if(self.petwatch.ref_12314 == "pet_turbo") {
      var0 += 100;
    }

    self setclientomnvar("ui_pet_watch_bonus_earned_4", var0);
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

function addobjectivescorecharge(var0, var1) {
  if(isDefined(self.petwatch) && self.petwatch.ref_12314 != "pet_turbo" && !istrue(level.ref_12309[var0]) && !issubstr(var0, "kill")) {
    self.petwatch.current_zone += var1;
    self.petwatch.objectivescorecharge += var1;
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
  var0 = 180;
  var1 = var0 / 5;

  for(var2 = 1; var2 <= 5; var2++) {
    wait var1;
    ref_13e23(var2 / 5, 4);
  }

  battle_tracks_vehicleallowlisteningoutsideoccupancy();
}

function ref_13ffd(var0) {
  if(isDefined(self.petwatch) && self.petwatch.ref_12314 == "pet_turbo") {
    ref_13e23(var0, 1);
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

function setphase(var0) {
  self.petwatch.phase = var0;
  self.pers["petWatchData_phase"] = var0;
}

function updateuistate() {
  var0 = 0;

  if(self.petwatch.bored < 0) {
    var0 += 20;
  }

  if(self.petwatch.dirty < 0) {
    var0 += 100;
  }

  if(self.petwatch.unruly < 0) {
    var0 += 1000;
  }

  if(self.petwatch.hungry < 0) {
    var0 += 10000;
  }

  var1 = int(self.petwatch.damage / 100) - 1;
  var1 = int(max(0, min(var1, 9)));
  var0 += 100000 * var1;
  var2 = var0 + self.petwatch.phase;
  self setclientomnvar("ui_pet_watch_state", var2);
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

function resetpet(var0, var1) {
  if(isDefined(var1)) {
    setphase(var1);
  } else {
    setphase(1);
  }

  self.petwatch.lastupdatetime = getsystemtime();
  ref_12c76();
}

function debugsetlasttime(var0) {
  self setclientomnvar("ui_pet_watch_action", var0);
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

  var0 = self.petwatch.killstreakcharge * 20;
  var1 = self.petwatch.wingamescharge * 20;
  var2 = self.petwatch.objectivescorecharge * 0.5;
  var3 = self.petwatch.killscharge * 1;
  var4 = self.petwatch.waittothrowsmoke < var3;
  var5 = self.petwatch.waittillhuntersdrop < var1;
  var6 = self.petwatch.waittill_player_uses_assassination_contract < var0;
  var7 = self.petwatch.watch_for_players_joining < var2;

  if(!var4 && !var5 && !var6 && !var7) {
    return;
  }

  var0 = max(-240, min(var0, 240));
  var1 = max(-240, min(var1, 240));
  var2 = max(-240, min(var2, 240));
  var3 = max(-240, min(var3, 240));

  if(var5) {
    var1 = int(var1);

    if(var1 == 0) {
      var1 = 1;
    }

    self setclientomnvar("ui_pet_watch_health_dirty", var1);
  }

  if(var7) {
    var2 = int(var2);

    if(var2 == 0) {
      var2 = 1;
    }

    self setclientomnvar("ui_pet_watch_health_unruly", int(var2));
  }

  if(var4) {
    var3 = int(var3);

    if(var3 == 0) {
      var3 = 1;
    }

    self setclientomnvar("ui_pet_watch_health_hungry", int(var3));
  }

  if(var6) {
    var0 = int(var0);

    if(var0 == 0) {
      var0 = 1;
    }

    self setclientomnvar("ui_pet_watch_health_bored", int(var0));
  }

  self.petwatch.waittothrowsmoke = var3;
  self.petwatch.waittillhuntersdrop = var1;
  self.petwatch.waittill_player_uses_assassination_contract = var0;
  self.petwatch.watch_for_players_joining = var2;
  self.petwatch.topkillstreakcharge = 0;
  self.petwatch.nukecharge = 0;
  self.petwatch.wingamestop3 = 0;
  self.petwatch.plantscharge = 0;
  self.petwatch.executionscharge = 0;
  self.petwatch.bored = var0;
  self.petwatch.dirty = var1;
  self.petwatch.unruly = var2;
  self.petwatch.hungry = var3;
}