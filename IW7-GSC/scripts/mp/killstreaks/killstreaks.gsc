/**************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\killstreaks.gsc
**************************************************/

func_9888() {
  level.var_A697 = [];
  var_0 = 1;
  for(;;) {
    var_1 = scripts\mp\utility::func_7F4B(var_0);
    if(!isDefined(var_1) || var_1 == "") {
      break;
    }

    var_2 = var_1;
    var_3 = scripts\mp\utility::func_7F3C(var_2);
    var_4 = scripts\mp\utility::func_7F3B(var_2);
    game["dialog"][var_2] = var_4;
    var_5 = scripts\mp\utility::func_7F34(var_2);
    game["dialog"]["allies_friendly_" + var_2 + "_inbound"] = "friendly_" + var_5;
    game["dialog"]["allies_enemy_" + var_2 + "_inbound"] = "enemy_" + var_5;
    var_6 = scripts\mp\utility::func_7F3E(var_2);
    game["dialog"]["axis_friendly_" + var_2 + "_inbound"] = "friendly_" + var_6;
    game["dialog"]["axis_enemy_" + var_2 + "_inbound"] = "enemy_" + var_6;
    var_7 = scripts\mp\utility::func_7F4E(var_2);
    scripts\mp\rank::registerscoreinfo("killstreak_" + var_2, "value", var_7);
    level.var_A697[level.var_A697.size] = var_2;
    var_0++;
  }
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    if(!isDefined(var_0.pers["killstreaks"])) {
      var_0.pers["killstreaks"] = [];
    }

    if(!isDefined(var_0.pers["startedMapSelect"])) {
      var_0.pers["startedMapSelect"] = 0;
    }

    var_0 visionsetmissilecamforplayer(game["thermal_vision"]);
    var_0 thread onplayerspawned();
    var_0 thread func_B9CB();
    var_0 thread func_110C3();
    var_0 thread monitorrigswitch();
  }
}

onplayerspawned() {
  self endon("disconnect");
  for(;;) {
    self waittill("spawned_player");
    self.var_13111 = undefined;
    func_F1C5();
    thread func_A6BA();
    thread func_A69C();
    thread func_A69B();
    thread func_A69D();
    thread func_A6B8();
    thread func_A6B0();
    thread func_FAC6();
    if(!isDefined(self.var_5FBE)) {
      self.var_5FBE = 0;
    }

    if(!scripts\mp\utility::istrue(self.var_AE15)) {
      scripts\mp\utility::initpersstat("streakPoints");
      self.streakpoints = scripts\mp\utility::getpersstat("streakPoints");
      self.var_AE15 = 1;
    }

    func_F866();
    updatekillstreakselectedui();
    func_12F2E(self.streakpoints);
  }
}

monitorrigswitch() {
  self endon("disconnect");
  level endon("game_ended");
  for(;;) {
    self waittill("giveLoadout");
    if(scripts\mp\utility::istrue(level.var_3B1E)) {
      continue;
    }

    if(isDefined(self.oldperks) && isDefined(self.perks) && self.oldperks.size > 0) {
      if(scripts\mp\utility::func_2287(self.perks, "specialty_support_killstreaks") && scripts\mp\utility::func_2287(self.oldperks, "specialty_support_killstreaks")) {
        continue;
      } else if(!scripts\mp\utility::func_2287(self.oldperks, "specialty_support_killstreaks")) {
        continue;
      } else {
        func_E275();
        updatekillstreakselectedui();
      }
    }
  }
}

func_B9CB() {
  while(isDefined(self)) {
    if(scripts\mp\utility::bot_is_fireteam_mode()) {
      self waittill("disconnect");
      continue;
    }

    scripts\engine\utility::waittill_any("disconnect", "joined_team", "joined_spectators");
    self notify("killstreak_disowned");
  }
}

func_FAC6() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  if(isbot(self)) {
    return;
  }

  scripts\mp\utility::gameflagwait("prematch_done");
  self notifyonplayercommand("ks_select_up", "+actionslot 1");
  self notifyonplayercommand("ks_select_down", "+actionslot 2");
  self notifyonplayercommand("ks_action_3", "+actionslot 3");
  self notifyonplayercommand("ks_action_4", "+actionslot 4");
  self notifyonplayercommand("ks_action_5", "+actionslot 5");
  self notifyonplayercommand("ks_action_6", "+actionslot 6");
  scripts\mp\utility::_setactionslot(4, "");
}

updatestreakcount() {
  if(!isDefined(self.pers["killstreaks"])) {
    return;
  }

  if(self.streakpoints == self.previousstreakpoints) {
    return;
  }

  var_0 = self.streakpoints;
  self setkillstreakpoints(int(min(self.streakpoints, 16384)));
  if(self.streakpoints >= self.var_BFB0) {
    func_F866();
  }
}

func_E274() {
  self setkillstreakpoints(0);
  self setclientomnvar("ui_score_streak_cost", 0);
  self setclientomnvar("ui_score_streak_two_cost", 0);
  self setclientomnvar("ui_score_streak_three_cost", 0);
  func_F866();
}

func_F866() {
  if(!isDefined(self.streaktype)) {
    self.var_BFB0 = 0;
    self getrandompoint(0);
    return;
  }

  if(func_7FA2() == 0) {
    self.var_BFB0 = 0;
    self getrandompoint(0);
    return;
  }

  var_0 = self.var_BFB0;
  var_1 = func_7FEE();
  if(!isDefined(var_1)) {
    return;
  }

  var_2 = getstreakcost(var_1);
  self.var_BFB0 = var_2;
  if(scripts\mp\utility::_hasperk("specialty_support_killstreaks") && isDefined(self.pers["killstreaks"][1]) && !scripts\mp\utility::istrue(self.var_5FBD)) {
    var_3 = 0;
    foreach(var_5 in self.pers["killstreaks"]) {
      if(scripts\mp\utility::istrue(var_5.earned)) {
        var_3 = 1;
        continue;
      }

      var_3 = 0;
    }

    if(var_3 && !isDefined(self.var_5FBD)) {
      self.var_5FBD = 1;
      self.var_BFB0 = 0;
      self getrandompoint(0);
      self setkillstreakpoints(0);
      self setclientomnvar("ui_score_streak_cost", 0);
      self setclientomnvar("ui_score_streak_two_cost", 0);
      self setclientomnvar("ui_score_streak_three_cost", 0);
      scripts\mp\hud_message::showerrormessage("KILLSTREAKS_SUPPORT_NO_WRAP");
      return;
    }
  }

  self getrandompoint(var_2);
}

func_7FEE() {
  if(self.streakpoints == func_7FA2() && self.streaktype != "specialist") {
    var_0 = 0;
  } else {
    var_0 = self.streakpoints;
  }

  foreach(var_2 in self.var_A6AB) {
    var_3 = getstreakcost(var_2);
    if(var_3 > var_0) {
      return var_2;
    }
  }

  return undefined;
}

func_12F2E(var_0) {
  if(scripts\mp\utility::istrue(self.var_5FBD) && scripts\mp\utility::_hasperk("specialty_support_killstreaks")) {
    self setclientomnvar("ui_score_streak", 0);
    self setclientomnvar("ui_score_streak_two", 0);
    self setclientomnvar("ui_score_streak_three", 0);
    self setclientomnvar("ui_score_streak_cost", 0);
    self setclientomnvar("ui_score_streak_two_cost", 0);
    self setclientomnvar("ui_score_streak_three_cost", 0);
    self setclientomnvar("ui_score_streak", 0);
    return;
  }

  var_1 = 0;
  if(isDefined(self.var_A6AB)) {
    foreach(var_3 in self.var_A6AB) {
      if(var_1 == 0) {
        var_4 = getstreakcost(var_3);
        self setclientomnvar("ui_score_streak_cost", var_4);
        self setclientomnvar("ui_score_streak", var_0);
        var_1++;
        continue;
      }

      if(var_1 == 1) {
        var_4 = getstreakcost(var_3);
        self setclientomnvar("ui_score_streak_two_cost", var_4);
        self setclientomnvar("ui_score_streak_two", var_0);
        var_1++;
        continue;
      }

      var_4 = getstreakcost(var_3);
      self setclientomnvar("ui_score_streak_three_cost", var_4);
      self setclientomnvar("ui_score_streak_three", var_0);
    }
  }
}

func_7FA2() {
  var_0 = 0;
  foreach(var_2 in self.var_A6AB) {
    var_3 = getstreakcost(var_2);
    if(var_3 > var_0) {
      var_0 = var_3;
    }
  }

  return var_0;
}

updatekillstreakselectedui() {
  if(!scripts\mp\utility::isreallyalive(self)) {
    return;
  }

  var_0 = self.pers["killstreaks"];
  for(var_1 = 0; var_1 <= 3; var_1++) {
    var_2 = var_0[var_1];
    if(isDefined(var_2) && isDefined(var_2.streakname)) {
      self setclientomnvar("ui_score_streak_index_" + var_1, scripts\mp\utility::getkillstreakindex(var_2.streakname));
      self setclientomnvar("ui_score_streak_available_" + var_1, var_0[var_1].var_269A);
      continue;
    }

    self setclientomnvar("ui_score_streak_index_" + var_1, 0);
    self setclientomnvar("ui_score_streak_available_" + var_1, 0);
  }

  var_3 = getclosestenemysqdist();
  if(isDefined(var_3)) {
    self setclientomnvar("ui_score_streak_selected_slot", var_3);
    return;
  }

  self setclientomnvar("ui_score_streak_selected_slot", -1);
}

func_A6B8() {
  self endon("disconnect");
  self endon("faux_spawn");
  self notify("killstreakTeamChangeWatcher");
  self endon("killstreakTeamChangeWatcher");
  for(;;) {
    self waittill("joined_team");
    func_41C0();
  }
}

func_A6BA() {
  self endon("disconnect");
  self endon("death");
  self endon("joined_team");
  self endon("faux_spawn");
  self endon("spawned");
  level endon("game_ended");
  self notify("killstreakTriggeredWatcher");
  self endon("killstreakTriggeredWatcher");
  for(;;) {
    var_0 = scripts\engine\utility::waittill_any_return("ks_action_3", "ks_action_4", "ks_action_5", "ks_action_6");
    var_1 = laseron(var_0);
    if(!isDefined(var_1)) {
      continue;
    }

    var_2 = func_7F45(var_1);
    if(!isDefined(var_2) || !var_2.var_269A) {
      continue;
    }

    if(!scripts\engine\utility::isusabilityallowed()) {
      scripts\mp\hud_message::showerrormessage("KILLSTREAKS_CANNOT_BE_USED", undefined);
      continue;
    }

    if(isDefined(var_2.weapon)) {
      var_3 = func_392B(var_2.weapon, var_2);
      if(isDefined(var_3)) {
        var_4 = undefined;
        if(var_3 == "KILLSTREAKS_UNAVAILABLE_FOR_N") {
          var_4 = level.var_A6AA - level.func_8487 - level.ingraceperiod;
        }

        scripts\mp\hud_message::showerrormessage(var_3, var_4);
        continue;
      }
    }

    if(isDefined(self.var_13111)) {
      self notify("killstreak_trigger_blocked", var_2);
      continue;
    }

    var_5 = var_2.streakshouldchain;
    if(isDefined(var_5.var_127BD)) {
      if(!self[[var_5.var_127BD]](var_2)) {
        continue;
      }
    }

    self.var_AA35 = var_2;
    if(!scripts\engine\utility::is_player_gamepad_enabled()) {
      func_F837(var_1);
    }

    if(var_2.var_EF88 == "no_fire_weapon") {
      thread func_127C7(var_2.weapon, var_2, 1);
    } else if(var_2.var_EF88 == "gesture_script_weapon") {
      self giveandfireoffhand(var_2.weapon);
    } else if(isDefined(var_2.weapon) && var_2.weapon != "none") {
      thread func_127C7(var_2.weapon, var_2);
    } else {
      var_1 = getclosestenemysqdist();
      thread func_A69A(var_2);
    }

    var_6 = int(tablelookup("mp\killstreaktable.csv", 1, var_2.streakname, 4));
    if(var_6 >= 1000) {
      var_7 = tablelookup("mp\killstreaktable.csv", 1, var_2.streakname, 0);
      if(var_7 != "") {
        var_8 = int(var_7);
        scripts\mp\utility::setmlgannouncement(20, self.team, self getentitynumber(), var_8);
      }
    }
  }
}

laseron(var_0) {
  var_1 = undefined;
  if(!isai(self) && scripts\engine\utility::is_player_gamepad_enabled()) {
    if(var_0 == "ks_action_4") {
      var_1 = getclosestenemysqdist();
    }
  } else if(level.gametype == "grnd" && !scripts\engine\utility::is_player_gamepad_enabled()) {
    switch (var_0) {
      case "ks_action_3":
        var_1 = 0;
        break;

      case "ks_action_4":
        var_1 = 0;
        break;

      case "ks_action_5":
        var_1 = 0;
        break;

      case "ks_action_6":
        var_1 = 0;
        break;
    }
  } else {
    switch (var_0) {
      case "ks_action_3":
        var_1 = 1;
        break;

      case "ks_action_4":
        var_1 = 2;
        break;

      case "ks_action_5":
        var_1 = 3;
        break;

      case "ks_action_6":
        var_1 = 0;
        break;
    }
  }

  return var_1;
}

func_392B(var_0, var_1) {
  if(scripts\mp\utility::func_10060(var_1.streakname)) {
    if(isDefined(level.var_A6AA) && level.var_A6AA > 0) {
      if(level.func_8487 - level.ingraceperiod < level.var_A6AA) {
        return "KILLSTREAKS_UNAVAILABLE_FOR_N";
      }
    }
  }

  if(self hasweapon(var_0)) {
    return "KILLSTREAKS_CANNOT_BE_USED";
  }

  if(self isonladder()) {
    return "KILLSTREAKS_CANNOT_BE_USED";
  }

  if(self ismantling()) {
    return "KILLSTREAKS_CANNOT_BE_USED";
  }

  if(!scripts\engine\utility::isweaponswitchallowed()) {
    return "KILLSTREAKS_CANNOT_BE_USED";
  }

  if(scripts\mp\utility::func_9FAE(self)) {
    return "KILLSTREAKS_CANNOT_BE_USED";
  }

  if((scripts\mp\utility::func_9F2C(var_1.streakname) || scripts\mp\utility::func_9E90(var_1.streakname)) && !self isonground() || self iswallrunning()) {
    return "KILLSTREAKS_CANNOT_BE_USED";
  }
}

func_127C7(var_0, var_1, var_2) {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  if(self hasweapon(var_0)) {
    return 0;
  }

  self.tryingtousekillstreak = 1;
  thread triggerkillstreakweaponwatchdeath();
  scripts\mp\supers::allowsuperweaponstow();
  scripts\mp\utility::_giveweapon(var_0, 0, 0, 1);
  var_3 = var_1.streakshouldchain;
  if(isDefined(var_3.var_13C8D)) {
    var_4 = self[[var_3.var_13C8D]](var_1);
    if(isDefined(var_4) && var_4 == 0) {
      scripts\mp\utility::_takeweapon(var_0);
      self.tryingtousekillstreak = undefined;
      self notify("stopTryingToUseKillstreak");
      return;
    }
  }

  var_5 = scripts\mp\utility::func_11383(var_0);
  if(isDefined(var_3.weaponswapwatcher)) {
    self[[var_3.weaponswapwatcher]](var_1, var_5);
  }

  if(var_5) {
    if(scripts\mp\utility::istrue(var_2)) {
      thread func_510E(0.05, var_1);
    }

    self waittill("killstreak_finished_with_weapon_" + var_0);
  }

  self.tryingtousekillstreak = undefined;
  self notify("stopTryingToUseKillstreak");
  if(self hasweapon(var_0)) {
    scripts\mp\supers::unstowsuperweapon();
    scripts\mp\utility::forcethirdpersonwhenfollowing(var_0);
    if(self getcurrentweapon() == "none") {
      scripts\mp\utility::_switchtoweapon(self.lastdroppableweaponobj);
    }
  }

  if(isDefined(var_3.weapontouse)) {
    self[[var_3.weapontouse]](var_1);
  }
}

triggerkillstreakweaponwatchdeath() {
  self endon("disconnect");
  self endon("stopTryingToUseKillstreak");
  self waittill("death");
  self.tryingtousekillstreak = undefined;
}

func_510E(var_0, var_1) {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  wait(var_0);
  thread func_A69A(var_1);
}

func_13B96(var_0) {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  self endon("killstreak_finished_with_weapon");
  for(;;) {
    if(self getcurrentweapon() != var_0) {
      self notify("killstreak_finished_with_weapon_" + var_0);
      break;
    }

    scripts\engine\utility::waitframe();
  }
}

func_A69C() {
  self endon("disconnect");
  self endon("death");
  self endon("joined_team");
  self endon("faux_spawn");
  self endon("spawned");
  level endon("game_ended");
  self notify("killstreakFiredWatcher_offhand");
  self endon("killstreakFiredWatcher_offhand");
  for(;;) {
    self waittill("offhand_fired", var_0);
    thread func_128A4(var_0, "offhand_fired");
  }
}

func_A69B() {
  self endon("disconnect");
  self endon("death");
  self endon("joined_team");
  self endon("faux_spawn");
  self endon("spawned");
  level endon("game_ended");
  self notify("killstreakFiredWatcher_grenade");
  self endon("killstreakFiredWatcher_grenade");
  for(;;) {
    self waittill("grenade_fire", var_0, var_1);
    thread func_128A4(var_1, "grenade_fire", var_0);
  }
}

func_A69D() {
  self endon("disconnect");
  self endon("death");
  self endon("joined_team");
  self endon("faux_spawn");
  self endon("spawned");
  level endon("game_ended");
  self notify("killstreakFiredWatcher_weaponFired");
  self endon("killstreakFiredWatcher_weaponFired");
  for(;;) {
    self waittill("weapon_fired", var_0);
    thread func_128A4(var_0, "weapon_fired");
  }
}

func_128A4(var_0, var_1, var_2) {
  var_3 = func_7F61();
  if(!isDefined(var_3)) {
    return;
  }

  if(var_3.weapon != var_0) {
    return;
  }

  var_4 = self.pers["killstreaks"];
  var_5 = undefined;
  for(var_6 = 0; var_6 < 36; var_6++) {
    if(!isDefined(var_4[var_6])) {
      if(var_6 >= 4) {
        break;
      } else {
        continue;
      }
    }

    if(var_4[var_6] == var_3) {
      var_5 = var_6;
      break;
    }
  }

  if(!isDefined(var_5)) {
    return;
  }

  if(var_3.var_6D6B == var_1) {
    thread func_A69A(var_3, var_2);
  }
}

func_9E6B(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  switch (var_0) {
    case "jammer":
    case "dronedrop":
    case "directional_uav":
    case "counter_uav":
    case "uav":
      return 0;

    default:
      return 1;
  }
}

func_A69A(var_0, var_1) {
  self endon("disconnect");
  self endon("joined_team");
  level endon("game_ended");
  var_2 = var_0.streakshouldchain;
  if(!scripts\mp\utility::validateusestreak(var_0.streakname)) {
    if(isDefined(var_2.var_9B12)) {
      self[[var_2.var_9B12]](var_0);
    }

    if(isDefined(var_0.weapon) && var_0.weapon != "none") {
      self notify("killstreak_finished_with_weapon_" + var_0.weapon);
    }

    return 0;
  }

  if(getdvarint("com_codcasterEnabled", 0) == 1) {
    if(func_9E6B(var_0.streakname)) {
      self func_80C3(1);
    }
  }

  self.var_13111 = var_0;
  var_3 = 1;
  if(isDefined(var_2.usefunc)) {
    var_3 = self[[var_2.usefunc]](var_0);
  }

  var_4 = 1;
  if(isDefined(var_2.user_triggered)) {
    var_4 = self[[var_2.user_triggered]](var_0, var_1);
  }

  self notify("killstreak_use_finished", var_0.streakname, var_3);
  self.var_13111 = undefined;
  if(getdvarint("com_codcasterEnabled", 0) == 1) {
    self func_80C3(0);
  }

  if(!var_3 || !var_4) {
    return 0;
  }

  func_C5A9(var_0);
}

func_729F(var_0, var_1) {
  var_2 = func_4A1C(var_0, var_1);
  func_A69A(var_2);
}

func_729E() {
  var_0 = func_7F45(0);
  func_A69A(var_0, 0);
}

func_C5A9(var_0) {
  var_1 = var_0.streakname;
  var_2 = func_6CBA(var_0);
  var_0.var_269A = 0;
  if(isDefined(var_2)) {
    if(var_2 == 0 || var_2 >= 4) {
      func_E131(var_2);
    }

    func_F1CB();
  }

  thread scripts\mp\killstreak_loot::func_89BC(var_0);
  thread scripts\mp\missions::func_13079(var_1);
  scripts\mp\utility::printgameaction("killstreak started - " + var_1, self);
  self notify("killstreak_used", var_1);
  scripts\mp\utility::func_D4B7(var_1);
  var_6 = gettime() - var_0.var_B143;
  scripts\mp\analyticslog::logevent_killstreakavailable(var_1, var_6);
  combatrecordkillstreakuse(var_1);
}

func_DDF0(var_0) {
  if(isDefined(self.class_num)) {
    if(self getplayerdata(level.loadoutsgroup, "squadMembers", "killstreakSetups", 0, "killstreak") == var_0) {
      self.var_6DEB = gettime();
      return;
    }

    if(self getplayerdata(level.loadoutsgroup, "squadMembers", "killstreakSetups", 2, "killstreak") == var_0 && isDefined(self.var_6DEB)) {
      if(gettime() - self.var_6DEB < 20000) {
        thread scripts\mp\missions::processchallenge("wargasm");
        return;
      }

      return;
    }
  }
}

func_4A1C(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.var_269A = 0;
  var_3.streakname = var_0;
  var_3.var_9E0B = 0;
  var_3.var_FFC4 = 0;
  var_3.owner = var_1;
  var_3.var_A5B0 = func_81ED(self);
  var_3.lifeid = self.pers["deaths"];
  var_3.isgimme = 0;
  var_3.var_9F6E = 0;
  var_3.weapon = scripts\mp\utility::getkillstreakweapon(var_0);
  var_3.var_6D6B = func_7F41(var_0);
  var_3.streakshouldchain = getkillstreaksetupinfo(var_0);
  var_3.var_EF88 = scripts\mp\utility::func_7F4F(var_0);
  var_3.var_B143 = -1;
  var_3.variantid = var_2;
  return var_3;
}

func_81ED(var_0) {
  if(!isDefined(var_0.pers["nextKillstreakID"])) {
    var_0.pers["nextKillstreakID"] = 0;
  }

  var_1 = var_0.pers["nextKillstreakID"];
  var_0.pers["nextKillstreakID"]++;
  return var_1;
}

awardkillstreak(var_0, var_1, var_2, var_3) {
  var_4 = func_4A1C(var_0, var_1, var_3);
  func_26D5(var_4, var_2);
}

func_26D5(var_0, var_1) {
  var_0.isgimme = 1;
  if(isDefined(var_1) && var_1.size > 0) {
    scripts\mp\killstreak_loot::func_988A(var_0, var_1);
  }

  func_1030D(var_0, 0);
  func_F837(0);
  func_B2A9(0);
}

func_6693(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }

  var_4 = func_4A1C(var_0, self, var_3);
  var_4.var_9E0B = 1;
  var_4.var_FFC4 = 1;
  if(isDefined(var_2) && var_2.size > 0) {
    scripts\mp\killstreak_loot::func_988A(var_4, var_2);
  }

  func_1030D(var_4, var_1);
}

func_66B9(var_0, var_1, var_2) {
  func_6693(var_0, 1, var_1, var_2);
}

func_66BB(var_0, var_1, var_2) {
  func_6693(var_0, 2, var_1, var_2);
}

func_66BA(var_0, var_1, var_2) {
  func_6693(var_0, 3, var_1, var_2);
}

func_DB1C() {
  var_0 = self.pers["killstreaks"];
  if(isDefined(var_0[35])) {
    return 0;
  }

  var_1 = var_0[0];
  if(!isDefined(var_1)) {
    return 1;
  }

  for(var_2 = 4; var_2 < 36; var_2++) {
    if(!isDefined(var_0[var_2])) {
      var_0[var_2] = var_1;
      var_0[0] = undefined;
      break;
    }
  }

  self.pers["killstreaks"] = var_0;
  return 1;
}

func_D65E() {
  var_0 = self.pers["killstreaks"];
  var_1 = var_0[0];
  var_2 = undefined;
  var_3 = undefined;
  for(var_4 = 4; var_4 < 36; var_4++) {
    var_5 = var_0[var_4];
    if(isDefined(var_5)) {
      var_2 = var_5;
      var_3 = var_4;
      continue;
    }

    break;
  }

  self.pers["killstreaks"][0] = var_2;
  if(isDefined(var_3)) {
    self.pers["killstreaks"][var_3] = undefined;
  }
}

func_51D3(var_0) {
  if(var_0 == 35) {
    self.pers["killstreaks"][var_0] = undefined;
    return;
  }

  var_1 = self.pers["killstreaks"];
  for(var_2 = var_0; var_2 < 35; var_2++) {
    var_3 = var_1[var_2 + 1];
    if(!isDefined(var_3)) {
      break;
    }

    var_1[var_0] = var_3;
  }

  self.pers["killstreaks"] = var_1;
}

func_E131(var_0) {
  self.pers["killstreaks"][var_0] = undefined;
  if(var_0 == 0) {
    func_D65E();
    return;
  }

  if(var_0 >= 4) {
    func_51D3(var_0);
  }
}

func_41C0() {
  self.pers["killstreaks"] = [];
  func_E275();
  clearkillstreakselection();
  updatekillstreakselectedui();
}

func_1030D(var_0, var_1) {
  if(var_1 == 0) {
    if(!func_DB1C()) {
      return;
    }
  }

  self.pers["killstreaks"][var_1] = var_0;
  updatekillstreakselectedui();
}

func_5FBF(var_0, var_1) {
  var_2 = func_7F45(var_0);
  var_3 = var_2.streakname;
  scripts\mp\utility::bufferednotify("earned_killstreak_buffered", var_3);
  self.var_5FBE = var_1;
  if(scripts\mp\utility::_hasperk("specialty_support_killstreaks")) {
    self.pers["killstreaks"][var_0].earned = 1;
  }

  if(!level.gameended) {
    var_4 = var_3;
    var_5 = scripts\mp\killstreak_loot::getrarityforlootitem(var_2.variantid);
    if(var_5 != "") {
      var_4 = var_4 + "_" + var_5;
    }

    thread scripts\mp\hud_message::showkillstreaksplash(var_4, var_1);
  }

  if(scripts\mp\utility::_hasperk("specialty_support_killstreaks")) {
    scripts\mp\missions::func_D991("ch_trait_support");
  }

  func_DDF0(var_3);
  func_F866();
  func_B2A9(var_0);
}

func_B2A9(var_0) {
  var_1 = func_7F45(var_0);
  if(!isDefined(var_1)) {
    return;
  }

  var_2 = var_1.streakname;
  var_3 = var_1.streakshouldchain;
  if(self.team == "spectator") {
    return;
  }

  var_1.var_269A = 1;
  if(var_0 >= 0 && var_0 <= 3) {
    func_F837(var_0);
  }

  updatekillstreakselectedui();
  if(isDefined(var_3.var_26A2)) {
    self[[var_3.var_26A2]](var_1);
  }

  if(isDefined(var_1.var_9E0B) && var_1.var_9E0B && isDefined(var_1.var_FFC4) && var_1.var_FFC4) {
    self notify("received_earned_killstreak");
  }

  var_1.var_B143 = gettime();
  var_4 = scripts\mp\utility::getkillstreakindex(var_2);
  scripts\mp\analyticslog::logevent_killstreakearned(var_4, var_1.var_B143);
  scripts\mp\matchdata::logkillstreakavailableevent(var_2);
}

givekillstreak(var_0, var_1, var_2, var_3) {
  awardkillstreak(var_0, var_3);
}

getstreakcost(var_0) {
  var_1 = int(scripts\mp\utility::func_7F46(var_0));
  if(isDefined(self) && isplayer(self)) {
    var_1 = scripts\mp\killstreak_loot::modifycostforlootitem(self.streakvariantids[var_0], var_1);
    if(scripts\mp\utility::isspecialistkillstreak(var_0)) {
      if(isDefined(self.pers["gamemodeLoadout"])) {
        if(isDefined(self.pers["gamemodeLoadout"]["loadoutKillstreak1"]) && self.pers["gamemodeLoadout"]["loadoutKillstreak1"] == var_0) {
          var_1 = 2;
        } else if(isDefined(self.pers["gamemodeLoadout"]["loadoutKillstreak2"]) && self.pers["gamemodeLoadout"]["loadoutKillstreak2"] == var_0) {
          var_1 = 4;
        } else if(isDefined(self.pers["gamemodeLoadout"]["loadoutKillstreak3"]) && self.pers["gamemodeLoadout"]["loadoutKillstreak3"] == var_0) {
          var_1 = 6;
        }
      } else if(issubstr(self.curclass, "custom")) {
        for(var_2 = 0; var_2 < 3; var_2++) {
          var_3 = self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", self.class_num, "specialistStreaks", var_2);
          if(var_3 == var_0) {
            break;
          }
        }

        if(var_2 == 1) {
          var_1 = 500;
        } else if(var_2 == 2) {
          var_1 = 800;
        }
      } else if(issubstr(self.curclass, "callback")) {
        var_2 = 0;
        foreach(var_5 in self.pers["specialistStreaks"]) {
          if(var_5 == var_0) {
            break;
          }
        }

        var_1 = self.pers["specialistStreakKills"][var_2];
      } else if(issubstr(self.curclass, "axis") || issubstr(self.curclass, "allies")) {
        var_2 = 0;
        var_6 = "none";
        if(issubstr(self.curclass, "axis")) {
          var_6 = "axis";
        } else if(issubstr(self.curclass, "allies")) {
          var_6 = "allies";
        }

        var_7 = scripts\mp\utility::getclassindex(self.curclass);
        while(var_2 < 3) {
          var_3 = scripts\mp\utility::getmatchrulesdatawithteamandindex("defaultClasses", var_6, var_7, "class", "specialistStreaks", var_2);
          if(var_3 == var_0) {
            break;
          }

          var_2++;
        }

        var_1 = scripts\mp\utility::getmatchrulesdatawithteamandindex("defaultClasses", var_6, var_7, "class", "specialistStreakKills", var_2);
      }
    }
  }

  var_1 = int(clamp(var_1, 0, 7000));
  return var_1;
}

buttonpressed(var_0, var_1) {
  var_2 = 0;
  if(scripts\mp\utility::_hasperk("specialty_support_killstreaks")) {
    var_3 = scripts\mp\utility::getkillstreakindex(var_0);
    var_2 = 175 * var_3;
  }

  return var_2;
}

func_A6B0() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  level endon("game_ended");
  for(;;) {
    var_0 = scripts\engine\utility::waittill_any_return("ks_select_up", "ks_select_down");
    if(!scripts\engine\utility::is_player_gamepad_enabled()) {
      continue;
    }

    if(!scripts\mp\utility::isjuggernaut() && !scripts\mp\utility::istrue(self.iscarrying) && !isDefined(self.var_13111)) {
      var_1 = getclosestenemysqdist();
      if(!isDefined(var_1)) {
        continue;
      }

      var_2 = var_1;
      if(var_0 == "ks_select_up") {
        var_2 = func_7FED(var_1);
      } else if(var_0 == "ks_select_down") {
        var_2 = detonate(var_1);
      }

      func_F837(var_2);
    }
  }
}

func_F1C5() {
  var_0 = self.pers["killstreaks"];
  for(var_1 = 3; var_1 >= 0; var_1--) {
    var_2 = var_0[var_1];
    if(isDefined(var_2) && var_2.var_269A) {
      func_F837(var_1);
      return;
    }
  }

  clearkillstreakselection();
}

func_7FED(var_0) {
  var_1 = self.pers["killstreaks"];
  var_2 = var_0;
  var_3 = scripts\engine\utility::ter_op(var_0 >= 3, 0, var_0 + 1);
  var_4 = var_0;
  var_5 = var_3;
  while(var_5 != var_4) {
    var_6 = var_1[var_5];
    if(isDefined(var_6) && var_6.var_269A) {
      var_2 = var_5;
      break;
    }

    var_5++;
    if(var_5 > 3) {
      var_5 = 0;
    }
  }

  return var_2;
}

detonate(var_0) {
  var_1 = self.pers["killstreaks"];
  var_2 = var_0;
  var_3 = scripts\engine\utility::ter_op(var_0 <= 0, 3, var_0 - 1);
  var_4 = var_0;
  var_5 = var_3;
  while(var_5 != var_4) {
    var_6 = var_1[var_5];
    if(isDefined(var_6) && var_6.var_269A) {
      var_2 = var_5;
      break;
    }

    var_5--;
    if(var_5 < 0) {
      var_5 = 3;
    }
  }

  return var_2;
}

func_F1CB() {
  var_0 = self.pers["killstreaks"];
  var_1 = undefined;
  var_2 = -1;
  for(var_3 = 3; var_3 >= 0; var_3--) {
    var_4 = var_0[var_3];
    if(isDefined(var_4) && var_4.var_269A) {
      var_5 = getstreakcost(var_4.streakname);
      if(var_5 > var_2) {
        var_1 = var_3;
        var_2 = var_5;
      }
    }
  }

  if(!isDefined(var_1)) {
    clearkillstreakselection();
    return;
  }

  func_F837(var_1);
}

func_F837(var_0) {
  var_1 = func_7F45(var_0);
  self.currentselectedkillstreakslot = var_0;
  updatekillstreakselectedui();
}

clearkillstreakselection() {
  self.currentselectedkillstreakslot = undefined;
  updatekillstreakselectedui();
}

func_8110() {
  var_0 = getclosestenemysqdist();
  if(!isDefined(var_0)) {
    return undefined;
  }

  return self.pers["killstreaks"][var_0];
}

getclosestenemysqdist() {
  return self.currentselectedkillstreakslot;
}

func_7F45(var_0) {
  return self.pers["killstreaks"][var_0];
}

func_7E9E(var_0) {
  var_1 = self.pers["killstreaks"];
  for(var_2 = 1; var_2 <= 3; var_2++) {
    var_3 = var_1[var_2];
    if(isDefined(var_3) && var_3.streakname == var_0) {
      return var_3;
    }
  }

  return undefined;
}

func_7E9F(var_0) {
  var_1 = self.pers["killstreaks"];
  for(var_2 = 1; var_2 <= 3; var_2++) {
    var_3 = var_1[var_2];
    if(isDefined(var_3) && var_3.streakname == var_0) {
      return var_2;
    }
  }

  return undefined;
}

missile_settargetpos(var_0) {
  var_1 = self.pers["killstreaks"];
  for(var_2 = 0; var_2 <= 3; var_2++) {
    var_3 = var_1[var_2];
    if(isDefined(var_3) && var_3.streakname == var_0 && var_3.var_269A) {
      return var_2;
    }
  }

  return undefined;
}

func_7F54(var_0) {
  var_1 = self.pers["killstreaks"];
  for(var_2 = 0; var_2 <= 3; var_2++) {
    var_3 = var_1[var_2];
    if(isDefined(var_3) && var_3.streakname == var_0) {
      return var_2;
    }
  }

  return undefined;
}

func_7ED6() {
  var_0 = [];
  var_1 = self.pers["killstreaks"];
  var_2 = func_7F45(0);
  if(isDefined(var_2)) {
    var_0[0] = var_2;
    for(var_3 = 4; var_3 < 36; var_3++) {
      var_4 = var_1[var_3];
      if(isDefined(var_4)) {
        var_0[var_0.size] = var_4;
        continue;
      }

      break;
    }
  }

  return var_0;
}

func_7DE7() {
  var_0 = [];
  var_1 = self.pers["killstreaks"];
  if(var_1.size) {
    for(var_2 = 1; var_2 < 4; var_2++) {
      var_3 = var_1[var_2];
      if(isDefined(var_3) && isDefined(var_3.streakname) && var_3.var_269A) {
        var_0[var_0.size] = var_3;
      }
    }
  }

  return var_0;
}

registerkillstreak(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(level.killstreaksetups)) {
    level.killstreaksetups = [];
  }

  var_9 = spawnStruct();
  level.killstreaksetups[var_0] = var_9;
  var_9.usefunc = var_1;
  var_9.user_triggered = var_2;
  var_9.var_26A2 = var_3;
  var_9.var_127BD = var_4;
  var_9.var_13C8D = var_5;
  var_9.weapontouse = var_6;
  var_9.var_9B12 = var_7;
  var_9.weaponswapwatcher = var_8;
}

getkillstreaksetupinfo(var_0) {
  var_1 = level.killstreaksetups[var_0];
  return var_1;
}

func_7F41(var_0) {
  if(var_0 == "none") {
    return "";
  }

  var_1 = scripts\mp\utility::func_7F4F(var_0);
  if(!isDefined(var_1) || var_1 == "") {
    return "";
  }

  switch (var_1) {
    case "script_weapon":
    case "gesture_script_weapon":
      return "offhand_fired";

    case "grenade_weapon":
      return "grenade_fire";

    case "normal_weapon":
      return "weapon_fired";

    case "no_weapon":
    case "no_fire_weapon":
      return "";

    default:
      return "";
  }

  return "";
}

func_7F61() {
  return self.var_AA35;
}

func_3E4E(var_0) {
  foreach(var_2 in self.var_A6AB) {
    var_3 = getstreakcost(var_2);
    var_4 = func_7E9F(var_2);
    var_5 = func_7F45(var_4);
    if(self.previousstreakpoints < var_3 && var_0 >= var_3) {
      if(scripts\mp\utility::_hasperk("specialty_support_killstreaks") && scripts\mp\utility::istrue(self.pers["killstreaks"][var_4].earned)) {
        continue;
      }

      func_5FBF(var_4, var_3);
    }
  }
}

func_213F(var_0) {
  var_1 = self.pers["killstreaks"];
  if(!isDefined(var_1)) {
    return 0;
  }

  foreach(var_3 in var_0) {
    var_4 = 0;
    for(var_5 = 1; var_5 <= 3; var_5++) {
      var_6 = var_1[var_5];
      if(isDefined(var_6)) {
        if(isDefined(var_6.streakname)) {
          if(var_6.streakname == var_3) {
            var_4 = 1;
            break;
          }
        }

        continue;
      }

      if(var_3 == "none") {
        var_4 = 1;
        break;
      }
    }

    if(!var_4) {
      return 0;
    }
  }

  return 1;
}

func_6CBA(var_0) {
  var_1 = self.pers["killstreaks"];
  for(var_2 = 0; var_2 <= 36; var_2++) {
    var_3 = var_1[var_2];
    if(!isDefined(var_3)) {
      if(var_2 >= 4) {
        break;
      }

      continue;
    }

    if(var_0 == var_3) {
      return var_2;
    }
  }

  return undefined;
}

func_83A7(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = scripts\mp\rank::getscoreinfovalue(var_0);
  }

  if(var_1 == 0) {
    return;
  }

  var_2 = self.streakpoints + var_1;
  var_3 = var_2;
  var_4 = func_7FA2();
  if(var_3 >= var_4) {
    var_3 = var_3 - var_4;
  }

  setstreakpoints(var_3);
  func_3E4E(var_2);
  if(var_2 >= var_4) {
    setstreakpoints(var_3);
  }

  func_12F2E(var_3);
  scripts\mp\analyticslog::logevent_reportstreakscore(var_1, gettime(), scripts\mp\rank::getscoreinfocategory(var_0, "eventID"));
}

func_E275() {
  self.var_5FBE = 0;
  setstreakpoints(0);
  func_E274();
  func_12F2E(0);
}

setstreakpoints(var_0) {
  if(var_0 < 0) {
    var_0 = 0;
  }

  if(isDefined(self.streakpoints)) {
    self.previousstreakpoints = self.streakpoints;
  } else {
    self.previousstreakpoints = 0;
  }

  self.streakpoints = var_0;
  updatestreakcount();
}

func_110C3() {
  self endon("disconnect");
  level waittill("game_ended");
  scripts\mp\utility::setpersstat("streakPoints", scripts\engine\utility::ter_op(isDefined(self.streakpoints), self.streakpoints, 0));
}

findunobstructedfiringpointaroundz(var_0, var_1, var_2, var_3) {
  var_4 = rotatevector((0, 0, 1), (-1 * var_3, 0, 0));
  var_5 = vectortoangles(var_1 - var_0.origin);
  for(var_6 = 0; var_6 < 360; var_6 = var_6 + 30) {
    var_7 = var_2 * rotatevector(var_4, (0, var_6 + var_5[1], 0));
    var_8 = var_1 + var_7;
    if(_findunobstructedfiringpointhelper(var_0, var_8, var_1)) {
      return var_8;
    }
  }

  return undefined;
}

findunobstructedfiringpointaroundy(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = vectortoangles(var_0.origin - var_1);
  for(var_7 = var_3; var_7 <= var_4; var_7 = var_7 + var_5) {
    var_8 = rotatevector((1, 0, 0), (var_7 - 90, 0, 0));
    var_9 = var_2 * rotatevector(var_8, (0, var_6[1], 0));
    var_10 = var_1 + var_9;
    if(_findunobstructedfiringpointhelper(var_0, var_10, var_1)) {
      return var_10;
    }
  }

  return undefined;
}

_findunobstructedfiringpointhelper(var_0, var_1, var_2) {
  var_3 = bulletTrace(var_1, var_2, 0);
  if(var_3["fraction"] > 0.99) {
    return 1;
  }

  return 0;
}

findunobstructedfiringpoint(var_0, var_1, var_2) {
  var_3 = findunobstructedfiringpointaroundz(var_0, var_1, var_2, 30);
  if(!isDefined(var_3)) {
    var_3 = findunobstructedfiringpointaroundy(var_0, var_1, var_2, 15, 75, 15);
  }

  return var_3;
}

isusinggunship() {
  return isDefined(self.onhelisniper) && self.onhelisniper;
}

func_9FC4() {
  return isDefined(self.var_98FF) && self.var_98FF;
}

func_532A(var_0, var_1, var_2, var_3) {
  var_4 = "MOD_EXPLOSIVE";
  var_5 = 5000;
  var_6 = (0, 0, 0);
  var_7 = (0, 0, 0);
  var_8 = "";
  var_9 = "";
  var_10 = "";
  var_11 = undefined;
  if(!isDefined(var_3)) {
    return;
  }

  if(level.teambased) {
    foreach(var_13 in var_3) {
      if(scripts\mp\utility::func_9FE7(var_0, var_1, var_13)) {
        var_13 notify("damage", var_5, var_0, var_6, var_7, var_4, var_8, var_9, var_10, var_11, var_2);
        wait(0.05);
      }
    }

    return;
  }

  foreach(var_13 in var_4) {
    if(scripts\mp\utility::func_9FD8(var_0, var_1, var_13)) {
      var_13 notify("damage", var_5, var_0, var_6, var_7, var_4, var_8, var_9, var_10, var_11, var_2);
      wait(0.05);
    }
  }
}

killstreakhit(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1) && isplayer(var_0) && isDefined(var_2.owner) && isDefined(var_2.owner.team)) {
    if(scripts\mp\utility::playersareenemies(var_0, var_2.owner)) {
      if(scripts\mp\utility::iskillstreakweapon(var_1)) {
        return;
      }

      if(!isDefined(var_0.lasthittime[var_1])) {
        var_0.lasthittime[var_1] = 0;
      }

      if(var_0.lasthittime[var_1] == gettime()) {
        return;
      }

      var_0.lasthittime[var_1] = gettime();
      var_0 thread scripts\mp\gamelogic::threadedsetweaponstatbyname(var_1, 1, "hits");
      var_4 = var_0 scripts\mp\persistence::statgetbuffered("totalShots");
      var_5 = var_0 scripts\mp\persistence::statgetbuffered("hits") + 1;
      if(var_5 <= var_4) {
        var_0 scripts\mp\persistence::func_10E55("hits", var_5);
        var_0 scripts\mp\persistence::func_10E55("misses", int(var_4 - var_5));
        var_0 scripts\mp\persistence::func_10E55("accuracy", int(var_5 * 10000 / var_4));
      }

      if((isDefined(var_3) && scripts\engine\utility::isbulletdamage(var_3)) || scripts\mp\utility::isprojectiledamage(var_3)) {
        var_0 thread scripts\mp\contractchallenges::contractshotslanded(var_1);
        var_0.lastdamagetime = gettime();
        var_6 = scripts\mp\utility::getweapongroup(var_1);
        if(var_6 == "weapon_lmg") {
          if(!isDefined(var_0.shotslandedlmg)) {
            var_0.shotslandedlmg = 1;
            return;
          }

          var_0.shotslandedlmg++;
          return;
        }

        return;
      }
    }
  }
}

func_83A0() {
  thread scripts\mp\utility::giveunifiedpoints("destroyed_equipment");
}

givescorefortrophyblocks() {
  thread scripts\mp\utility::giveunifiedpoints("trophy_defense");
}

givescoreforblackhat() {
  thread scripts\mp\utility::giveunifiedpoints("blackhat_hack");
}

func_9E9F(var_0) {
  return var_0 == "iw6_minigunjugg_mp";
}

streaktyperesetsondeath(var_0) {
  switch (var_0) {
    case "assault":
    case "specialist":
      return 1;

    case "resource":
    case "support":
      return 0;

    default:
      return 1;
  }
}

initridekillstreak(var_0) {
  scripts\engine\utility::allow_usability(0);
  var_1 = initridekillstreak_internal(var_0);
  if(isDefined(self)) {
    scripts\engine\utility::allow_usability(1);
  }

  return var_1;
}

initridekillstreak_internal(var_0) {
  if(isDefined(var_0) && func_9E6F(var_0)) {
    var_1 = "timeout";
  } else {
    var_1 = scripts\engine\utility::waittill_any_timeout(1, "disconnect", "death", "weapon_switch_started");
  }

  scripts\mp\hostmigration::waittillhostmigrationdone();
  if(var_1 == "weapon_switch_started") {
    return "fail";
  }

  if(!isalive(self)) {
    return "fail";
  }

  if(var_1 == "disconnect" || var_1 == "death") {
    if(var_1 == "disconnect") {
      return "disconnect";
    }

    if(self.team == "spectator") {
      return "fail";
    }

    return "success";
  }

  if(scripts\mp\utility::iskillstreakdenied()) {
    return "fail";
  }

  if(!isDefined(var_0) || !issubstr(var_0, "odin") || !issubstr(var_0, "pointSelect")) {
    if(var_0 == "orbital_deployment" || var_0 == "drone_hive") {
      self visionsetfadetoblackforplayer("black_bw", 0);
      thread scripts\mp\utility::set_visionset_for_watching_players("black_bw", 0, 1, undefined, 1);
      var_2 = scripts\engine\utility::waittill_any_timeout(0, "disconnect", "death");
    } else {
      self visionsetfadetoblackforplayer("black_bw", 0.75);
      thread scripts\mp\utility::set_visionset_for_watching_players("black_bw", 0.75, 1, undefined, 1);
      var_2 = scripts\engine\utility::waittill_any_timeout(0.8, "disconnect", "death");
    }
  } else {
    var_2 = scripts\engine\utility::waittill_any_timeout(1, "disconnect", "death");
  }

  self notify("black_out_done");
  scripts\mp\hostmigration::waittillhostmigrationdone();
  if(var_2 != "disconnect") {
    if(!isDefined(var_0) || !issubstr(var_0, "odin") || !issubstr(var_0, "pointSelect")) {
      thread clearrideintro(1);
    } else {
      self notify("intro_cleared");
    }

    if(self.team == "spectator") {
      return "fail";
    }
  }

  if(self isonladder()) {
    return "fail";
  }

  if(!isalive(self)) {
    return "fail";
  }

  if(scripts\mp\utility::iskillstreakdenied()) {
    return "fail";
  }

  if(var_2 == "disconnect") {
    return "disconnect";
  }

  return "success";
}

func_9E6F(var_0) {
  switch (var_0) {
    case "remote_tank":
    case "remote_uav":
    case "osprey_gunner":
    case "pointSelect":
    case "orbital_deployment":
    case "ac130":
    case "ca_a10_strafe":
    case "vanguard":
    case "odin_assault":
    case "odin_support":
    case "heli_pilot":
    case "fleet_swarm":
    case "remote_c8":
    case "spiderbot":
    case "precision_airstrike":
    case "thor":
    case "minijackal":
    case "drone_hive":
      return 1;
  }

  return 0;
}

clearrideintro(var_0, var_1) {
  self endon("disconnect");
  if(isDefined(var_0)) {
    wait(var_0);
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  self visionsetfadetoblackforplayer("", var_1);
  scripts\mp\utility::set_visionset_for_watching_players("", var_1);
  self notify("intro_cleared");
}

allowridekillstreakplayerexit(var_0) {
  if(isDefined(var_0)) {
    self endon(var_0);
  }

  if(!isDefined(self.owner)) {
    return;
  }

  var_1 = self.owner;
  level endon("game_ended");
  var_1 endon("disconnect");
  var_1 endon("end_remote");
  self endon("death");
  for(;;) {
    var_2 = 0;
    while(var_1 usebuttonpressed()) {
      var_2 = var_2 + 0.05;
      if(var_2 > 0.75) {
        self notify("killstreakExit");
        return;
      }

      wait(0.05);
    }

    wait(0.05);
  }
}

func_D507(var_0, var_1) {
  self endon("disconnect");
  level endon("game_ended");
  if(scripts\mp\utility::isusingremote()) {
    return 0;
  }

  if(!scripts\mp\utility::isreallyalive(self)) {
    return 0;
  }

  self notify("play_remote_sequence");
  var_2 = undefined;
  if(scripts\mp\utility::istrue(var_1)) {
    if(self isonladder() || self ismantling() || !self isonground()) {
      scripts\mp\hud_message::showerrormessage("KILLSTREAKS_UNAVAILABLE");
      return 0;
    }

    var_2 = "ks_remote_device_mp";
    scripts\mp\supers::allowsuperweaponstow();
    scripts\mp\utility::_giveweapon(var_2, 0, 0, 1);
    self setclientomnvar("ui_remote_control_sequence", 1);
    var_3 = scripts\mp\utility::func_11383(var_2);
    if(scripts\mp\utility::istrue(var_3)) {
      thread func_13A4C(var_2);
    } else {
      return 0;
    }
  }

  scripts\mp\utility::setusingremote(var_0.streakname);
  scripts\mp\utility::freezecontrolswrapper(1);
  thread func_12B9C();
  var_4 = scripts\engine\utility::waittill_any_timeout(1, "death");
  self notify("ks_freeze_end");
  if(!isDefined(var_4) || var_4 != "timeout") {
    self setclientomnvar("ui_remote_control_sequence", 0);
    scripts\mp\utility::freezecontrolswrapper(0);
    scripts\mp\utility::clearusingremote();
    if(isDefined(var_2)) {
      self notify("finished_with_manual_weapon_" + var_2);
    }

    return 0;
  }

  self setscriptablepartstate("killstreak", "visor_active", 0);
  thread func_13BA2();
  scripts\mp\utility::freezecontrolswrapper(0);
  self setclientomnvar("ui_remote_control_sequence", 0);
  return 1;
}

func_12B9C() {
  self endon("disconnect");
  self endon("ks_freeze_end");
  level waittill("round_switch");
  scripts\mp\utility::freezecontrolswrapper(0);
}

func_13A4C(var_0) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("finished_with_manual_weapon_" + var_0);
  if(self hasweapon(var_0)) {
    scripts\mp\supers::unstowsuperweapon();
    scripts\mp\utility::forcethirdpersonwhenfollowing(var_0);
    if(self getcurrentweapon() == "none") {
      scripts\mp\utility::_switchtoweapon(self.lastdroppableweaponobj);
    }
  }
}

func_13BA2() {
  self endon("stop_remote_sequence");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("death");
  self setscriptablepartstate("killstreak", "neutral", 0);
}

func_11086(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("stop_remote_sequence");
  if(scripts\mp\utility::isreallyalive(self)) {
    if(scripts\mp\utility::istrue(level.nukedetonated) && !scripts\mp\utility::istrue(level.var_C1B2)) {
      thread scripts\mp\killstreaks\_nuke::func_FB0F(0.05);
    }

    self setclientomnvar("ui_remote_control_sequence", 2);
    var_1 = "ks_remote_device_mp";
    if(scripts\mp\utility::istrue(var_0)) {
      wait(0.1);
      self notify("finished_with_manual_weapon_" + var_1);
    } else {
      self notify("killstreak_finished_with_weapon_" + var_1);
    }
  }

  thread scripts\mp\utility::delaysetclientomnvar(1.3, "ui_remote_control_sequence", 0);
  self setscriptablepartstate("killstreak", "neutral", 0);
  scripts\mp\utility::clearusingremote();
}

combatrecordkillstreakuse(var_0) {
  if(!scripts\mp\utility::canrecordcombatrecordstats()) {
    return;
  }

  var_1 = scripts\mp\utility::getstreakrecordtype(var_0);
  if(!isDefined(var_1)) {
    if(var_0 != "nuke") {}

    return;
  }

  var_2 = self getplayerdata("mp", var_1, var_0, "uses");
  self setplayerdata("mp", var_1, var_0, "uses", var_2 + 1);
}