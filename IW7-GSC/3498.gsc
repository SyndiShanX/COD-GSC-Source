/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3498.gsc
***************************************/

func_9888() {
  level.func_A697 = [];
  var_00 = 1;

  for(;;) {
    var_01 = scripts\mp\utility\game::func_7F4B(var_00);

    if(!isDefined(var_01) || var_01 == "") {
      break;
    }
    var_02 = var_01;
    var_03 = scripts\mp\utility\game::func_7F3C(var_02);
    var_04 = scripts\mp\utility\game::func_7F3B(var_02);
    game["dialog"][var_02] = var_04;
    var_05 = scripts\mp\utility\game::func_7F34(var_02);
    game["dialog"]["allies_friendly_" + var_02 + "_inbound"] = "friendly_" + var_05;
    game["dialog"]["allies_enemy_" + var_02 + "_inbound"] = "enemy_" + var_05;
    var_06 = scripts\mp\utility\game::func_7F3E(var_02);
    game["dialog"]["axis_friendly_" + var_02 + "_inbound"] = "friendly_" + var_06;
    game["dialog"]["axis_enemy_" + var_02 + "_inbound"] = "enemy_" + var_06;
    var_07 = scripts\mp\utility\game::func_7F4E(var_02);
    scripts\mp\rank::registerscoreinfo("killstreak_" + var_02, "value", var_07);
    level.func_A697[level.func_A697.size] = var_02;
    var_0++;
  }
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_00);

    if(!isDefined(var_0.pers["killstreaks"])) {
      var_0.pers["killstreaks"] = [];
    }

    if(!isDefined(var_0.pers["startedMapSelect"])) {
      var_0.pers["startedMapSelect"] = 0;
    }

    var_00 visionsetmissilecamforplayer(game["thermal_vision"]);
    var_00 thread onplayerspawned();
    var_00 thread func_B9CB();
    var_00 thread func_110C3();
    var_00 thread monitorrigswitch();
  }
}

onplayerspawned() {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned_player");
    self.func_13111 = undefined;
    func_F1C5();
    thread func_A6BA();
    thread func_A69C();
    thread func_A69B();
    thread func_A69D();
    thread func_A6B8();
    thread func_A6B0();
    thread func_FAC6();

    if(!isDefined(self.func_5FBE)) {
      self.func_5FBE = 0;
    }

    if(!scripts\mp\utility\game::istrue(self.func_AE15)) {
      scripts\mp\utility\game::initpersstat("streakPoints");
      self.streakpoints = scripts\mp\utility\game::getpersstat("streakPoints");
      self.func_AE15 = 1;
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

    if(scripts\mp\utility\game::istrue(level.func_3B1E)) {
      continue;
    }
    if(isDefined(self.oldperks) && isDefined(self.perks) && self.oldperks.size > 0) {
      if(scripts\mp\utility\game::func_2287(self.perks, "specialty_support_killstreaks") && scripts\mp\utility\game::func_2287(self.oldperks, "specialty_support_killstreaks")) {
        continue;
      }
      else if(!scripts\mp\utility\game::func_2287(self.oldperks, "specialty_support_killstreaks")) {
        continue;
      }
      else {
        func_E275();
        updatekillstreakselectedui();
      }
    }
  }
}

func_B9CB() {
  while(isDefined(self)) {
    if(scripts\mp\utility\game::bot_is_fireteam_mode()) {
      self waittill("disconnect");
    }
    else {
      scripts\engine\utility::waittill_any("disconnect", "joined_team", "joined_spectators");
    }

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
  scripts\mp\utility\game::gameflagwait("prematch_done");
  self notifyonplayercommand("ks_select_up", "+actionslot 1");
  self notifyonplayercommand("ks_select_down", "+actionslot 2");
  self notifyonplayercommand("ks_action_3", "+actionslot 3");
  self notifyonplayercommand("ks_action_4", "+actionslot 4");
  self notifyonplayercommand("ks_action_5", "+actionslot 5");
  self notifyonplayercommand("ks_action_6", "+actionslot 6");
  scripts\mp\utility\game::_setactionslot(4, "");
}

updatestreakcount() {
  if(!isDefined(self.pers["killstreaks"])) {
    return;
  }
  if(self.streakpoints == self.previousstreakpoints) {
    return;
  }
  var_00 = self.streakpoints;
  self setkillstreakpoints(int(min(self.streakpoints, 16384)));

  if(self.streakpoints >= self.func_BFB0) {
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
    self.func_BFB0 = 0;
    self getrandompoint(0);
    return;
  }

  if(func_7FA2() == 0) {
    self.func_BFB0 = 0;
    self getrandompoint(0);
    return;
  }

  var_00 = self.func_BFB0;
  var_01 = func_7FEE();

  if(!isDefined(var_01)) {
    return;
  }
  var_02 = getstreakcost(var_01);
  self.func_BFB0 = var_02;

  if(scripts\mp\utility\game::_hasperk("specialty_support_killstreaks") && isDefined(self.pers["killstreaks"][1]) && !scripts\mp\utility\game::istrue(self.func_5FBD)) {
    var_03 = 0;

    foreach(var_05 in self.pers["killstreaks"]) {
      if(scripts\mp\utility\game::istrue(var_5.earned)) {
        var_03 = 1;
        continue;
      }

      var_03 = 0;
    }

    if(var_03 && !isDefined(self.func_5FBD)) {
      self.func_5FBD = 1;
      self.func_BFB0 = 0;
      self getrandompoint(0);
      self setkillstreakpoints(0);
      self setclientomnvar("ui_score_streak_cost", 0);
      self setclientomnvar("ui_score_streak_two_cost", 0);
      self setclientomnvar("ui_score_streak_three_cost", 0);
      scripts\mp\hud_message::showerrormessage("KILLSTREAKS_SUPPORT_NO_WRAP");
      return;
    }
  }

  self getrandompoint(var_02);
}

func_7FEE() {
  if(self.streakpoints == func_7FA2() && self.streaktype != "specialist") {
    var_00 = 0;
  }
  else {
    var_00 = self.streakpoints;
  }

  foreach(var_02 in self.func_A6AB) {
    var_03 = getstreakcost(var_02);

    if(var_03 > var_00) {
      return var_02;
    }
  }

  return undefined;
}

func_12F2E(var_00) {
  if(scripts\mp\utility\game::istrue(self.func_5FBD) && scripts\mp\utility\game::_hasperk("specialty_support_killstreaks")) {
    self setclientomnvar("ui_score_streak", 0);
    self setclientomnvar("ui_score_streak_two", 0);
    self setclientomnvar("ui_score_streak_three", 0);
    self setclientomnvar("ui_score_streak_cost", 0);
    self setclientomnvar("ui_score_streak_two_cost", 0);
    self setclientomnvar("ui_score_streak_three_cost", 0);
    self setclientomnvar("ui_score_streak", 0);
    return;
  }

  var_01 = 0;

  if(isDefined(self.func_A6AB)) {
    foreach(var_03 in self.func_A6AB) {
      if(var_01 == 0) {
        var_04 = getstreakcost(var_03);
        self setclientomnvar("ui_score_streak_cost", var_04);
        self setclientomnvar("ui_score_streak", var_00);
        var_1++;
        continue;
      }

      if(var_01 == 1) {
        var_04 = getstreakcost(var_03);
        self setclientomnvar("ui_score_streak_two_cost", var_04);
        self setclientomnvar("ui_score_streak_two", var_00);
        var_1++;
        continue;
      }

      var_04 = getstreakcost(var_03);
      self setclientomnvar("ui_score_streak_three_cost", var_04);
      self setclientomnvar("ui_score_streak_three", var_00);
    }
  }
}

func_7FA2() {
  var_00 = 0;

  foreach(var_02 in self.func_A6AB) {
    var_03 = getstreakcost(var_02);

    if(var_03 > var_00) {
      var_00 = var_03;
    }
  }

  return var_00;
}

updatekillstreakselectedui() {
  if(!scripts\mp\utility\game::isreallyalive(self)) {
    return;
  }
  var_00 = self.pers["killstreaks"];

  for(var_01 = 0; var_01 <= 3; var_1++) {
    var_02 = var_0[var_01];

    if(isDefined(var_02) && isDefined(var_2.streakname)) {
      self setclientomnvar("ui_score_streak_index_" + var_01, scripts\mp\utility\game::getkillstreakindex(var_2.streakname));
      self setclientomnvar("ui_score_streak_available_" + var_01, var_0[var_01].func_269A);
      continue;
    }

    self setclientomnvar("ui_score_streak_index_" + var_01, 0);
    self setclientomnvar("ui_score_streak_available_" + var_01, 0);
  }

  var_03 = getclosestenemysqdist();

  if(isDefined(var_03)) {
    self setclientomnvar("ui_score_streak_selected_slot", var_03);
  }
  else {
    self setclientomnvar("ui_score_streak_selected_slot", -1);
  }
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
    var_00 = scripts\engine\utility::waittill_any_return("ks_action_3", "ks_action_4", "ks_action_5", "ks_action_6");
    var_01 = laseron(var_00);

    if(!isDefined(var_01)) {
      continue;
    }
    var_02 = func_7F45(var_01);

    if(!isDefined(var_02) || !var_2.func_269A) {
      continue;
    }
    if(!scripts\engine\utility::isusabilityallowed()) {
      scripts\mp\hud_message::showerrormessage("KILLSTREAKS_CANNOT_BE_USED", undefined);
      continue;
    }

    if(isDefined(var_2.weapon)) {
      var_03 = func_392B(var_2.weapon, var_02);

      if(isDefined(var_03)) {
        var_04 = undefined;

        if(var_03 == "KILLSTREAKS_UNAVAILABLE_FOR_N") {
          var_04 = level.func_A6AA - (level._meth_8487 - level.ingraceperiod);
        }

        scripts\mp\hud_message::showerrormessage(var_03, var_04);
        continue;
      }
    }

    if(isDefined(self.func_13111)) {
      self notify("killstreak_trigger_blocked", var_02);
      continue;
    }

    var_05 = var_2.streakshouldchain;

    if(isDefined(var_5.func_127BD)) {
      if(!self[[var_5.func_127BD]](var_02)) {
        continue;
      }
    }

    self.func_AA35 = var_02;

    if(!scripts\engine\utility::is_player_gamepad_enabled()) {
      func_F837(var_01);
    }

    if(var_2.func_EF88 == "no_fire_weapon") {
      thread func_127C7(var_2.weapon, var_02, 1);
    }
    else if(var_2.func_EF88 == "gesture_script_weapon") {
      self giveandfireoffhand(var_2.weapon);
    }
    else if(isDefined(var_2.weapon) && var_2.weapon != "none") {
      thread func_127C7(var_2.weapon, var_02);
    }
    else {
      var_01 = getclosestenemysqdist();
      thread func_A69A(var_02);
    }

    var_06 = int(tablelookup("mp\killstreaktable.csv", 1, var_2.streakname, 4));

    if(var_06 >= 1000) {
      var_07 = tablelookup("mp\killstreaktable.csv", 1, var_2.streakname, 0);

      if(var_07 != "") {
        var_08 = int(var_07);
        scripts\mp\utility\game::setmlgannouncement(20, self.team, self getentitynumber(), var_08);
      }
    }
  }
}

laseron(var_00) {
  var_01 = undefined;

  if(!isai(self) && scripts\engine\utility::is_player_gamepad_enabled()) {
    if(var_00 == "ks_action_4") {
      var_01 = getclosestenemysqdist();
    }
  } else if(level.gametype == "grnd" && !scripts\engine\utility::is_player_gamepad_enabled()) {
    switch (var_00) {
      case "ks_action_3":
        var_01 = 0;
        break;
      case "ks_action_4":
        var_01 = 0;
        break;
      case "ks_action_5":
        var_01 = 0;
        break;
      case "ks_action_6":
        var_01 = 0;
        break;
    }
  } else {
    switch (var_00) {
      case "ks_action_3":
        var_01 = 1;
        break;
      case "ks_action_4":
        var_01 = 2;
        break;
      case "ks_action_5":
        var_01 = 3;
        break;
      case "ks_action_6":
        var_01 = 0;
        break;
    }
  }

  return var_01;
}

func_392B(var_00, var_01) {
  if(scripts\mp\utility\game::func_10060(var_1.streakname)) {
    if(isDefined(level.func_A6AA) && level.func_A6AA > 0) {
      if(level._meth_8487 - level.ingraceperiod < level.func_A6AA) {
        return "KILLSTREAKS_UNAVAILABLE_FOR_N";
      }
    }
  }

  if(self hasweapon(var_00)) {
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

  if(scripts\mp\utility\game::func_9FAE(self)) {
    return "KILLSTREAKS_CANNOT_BE_USED";
  }

  if((scripts\mp\utility\game::func_9F2C(var_1.streakname) || scripts\mp\utility\game::func_9E90(var_1.streakname)) && (!self isonground() || self iswallrunning())) {
    return "KILLSTREAKS_CANNOT_BE_USED";
  }

  return;
}

func_127C7(var_00, var_01, var_02) {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");

  if(self hasweapon(var_00)) {
    return 0;
  }

  self.tryingtousekillstreak = 1;
  thread triggerkillstreakweaponwatchdeath();
  scripts\mp\supers::allowsuperweaponstow();
  scripts\mp\utility\game::_giveweapon(var_00, 0, 0, 1);
  var_03 = var_1.streakshouldchain;

  if(isDefined(var_3.func_13C8D)) {
    var_04 = self[[var_3.func_13C8D]](var_01);

    if(isDefined(var_04) && var_04 == 0) {
      scripts\mp\utility\game::_takeweapon(var_00);
      self.tryingtousekillstreak = undefined;
      self notify("stopTryingToUseKillstreak");
      return;
    }
  }

  var_05 = scripts\mp\utility\game::func_11383(var_00);

  if(isDefined(var_3.weaponswapwatcher)) {
    self[[var_3.weaponswapwatcher]](var_01, var_05);
  }

  if(var_05) {
    if(scripts\mp\utility\game::istrue(var_02)) {
      thread func_510E(0.05, var_01);
    }

    self waittill("killstreak_finished_with_weapon_" + var_00);
  }

  self.tryingtousekillstreak = undefined;
  self notify("stopTryingToUseKillstreak");

  if(self hasweapon(var_00)) {
    scripts\mp\supers::unstowsuperweapon();
    scripts\mp\utility\game::forcethirdpersonwhenfollowing(var_00);

    if(self getcurrentweapon() == "none") {
      scripts\mp\utility\game::_switchtoweapon(self.lastdroppableweaponobj);
    }
  }

  if(isDefined(var_3.weapontouse)) {
    self[[var_3.weapontouse]](var_01);
  }
}

triggerkillstreakweaponwatchdeath() {
  self endon("disconnect");
  self endon("stopTryingToUseKillstreak");
  self waittill("death");
  self.tryingtousekillstreak = undefined;
}

func_510E(var_00, var_01) {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  wait(var_00);
  thread func_A69A(var_01);
}

func_13B96(var_00) {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  self endon("killstreak_finished_with_weapon");

  for(;;) {
    if(self getcurrentweapon() != var_00) {
      self notify("killstreak_finished_with_weapon_" + var_00);
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
    self waittill("offhand_fired", var_00);
    thread func_128A4(var_00, "offhand_fired");
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
    self waittill("grenade_fire", var_00, var_01);
    thread func_128A4(var_01, "grenade_fire", var_00);
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
    self waittill("weapon_fired", var_00);
    thread func_128A4(var_00, "weapon_fired");
  }
}

func_128A4(var_00, var_01, var_02) {
  var_03 = func_7F61();

  if(!isDefined(var_03)) {
    return;
  }
  if(var_3.weapon != var_00) {
    return;
  }
  var_04 = self.pers["killstreaks"];
  var_05 = undefined;

  for(var_06 = 0; var_06 < 36; var_6++) {
    if(!isDefined(var_4[var_06])) {
      if(var_06 >= 4) {
        break;
      } else
        continue;
    }

    if(var_4[var_06] == var_03) {
      var_05 = var_06;
      break;
    }
  }

  if(!isDefined(var_05)) {
    return;
  }
  if(var_3.func_6D6B == var_01) {
    thread func_A69A(var_03, var_02);
  }
}

func_9E6B(var_00) {
  if(!isDefined(var_00)) {
    return 0;
  }

  switch (var_00) {
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

func_A69A(var_00, var_01) {
  self endon("disconnect");
  self endon("joined_team");
  level endon("game_ended");
  var_02 = var_0.streakshouldchain;

  if(!scripts\mp\utility\game::func_1314A(var_0.streakname)) {
    if(isDefined(var_2.func_9B12)) {
      self[[var_2.func_9B12]](var_00);
    }

    if(isDefined(var_0.weapon) && var_0.weapon != "none") {
      self notify("killstreak_finished_with_weapon_" + var_0.weapon);
    }

    return 0;
  }

  if(getdvarint("com_codcasterEnabled", 0) == 1) {
    if(func_9E6B(var_0.streakname)) {
      self _meth_80C3(1);
    }
  }

  self.func_13111 = var_00;
  var_03 = 1;

  if(isDefined(var_2.usefunc)) {
    var_03 = self[[var_2.usefunc]](var_00);
  }

  var_04 = 1;

  if(isDefined(var_2.user_triggered)) {
    var_04 = self[[var_2.user_triggered]](var_00, var_01);
  }

  self notify("killstreak_use_finished", var_0.streakname, var_03);
  self.func_13111 = undefined;

  if(getdvarint("com_codcasterEnabled", 0) == 1) {
    self _meth_80C3(0);
  }

  if(!var_03 || !var_04) {
    return 0;
  }

  func_C5A9(var_00);
}

func_729F(var_00, var_01) {
  var_02 = func_4A1C(var_00, var_01);
  func_A69A(var_02);
}

func_729E() {
  var_00 = func_7F45(0);
  func_A69A(var_00, 0);
}

func_C5A9(var_00) {
  var_01 = var_0.streakname;
  var_02 = func_6CBA(var_00);
  var_0.func_269A = 0;

  if(isDefined(var_02)) {
    if(var_02 == 0 || var_02 >= 4) {
      func_E131(var_02);
    }

    func_F1CB();
  } else {}

  thread scripts\mp\killstreak_loot::func_89BC(var_00);
  thread scripts\mp\missions::func_13079(var_01);
  scripts\mp\utility\game::printgameaction("killstreak started - " + var_01, self);
  self notify("killstreak_used", var_01);
  scripts\mp\utility\game::func_D4B7(var_01);
  var_06 = gettime() - var_0.func_B143;
  scripts\mp\analyticslog::logevent_killstreakavailable(var_01, var_06);
  combatrecordkillstreakuse(var_01);
}

func_DDF0(var_00) {
  if(isDefined(self.class_num)) {
    if(self getrankedplayerdata(level.loadoutsgroup, "squadMembers", "killstreakSetups", 0, "killstreak") == var_00) {
      self.func_6DEB = gettime();
    }
    else if(self getrankedplayerdata(level.loadoutsgroup, "squadMembers", "killstreakSetups", 2, "killstreak") == var_00 && isDefined(self.func_6DEB)) {
      if(gettime() - self.func_6DEB < 20000) {
        thread scripts\mp\missions::processchallenge("wargasm");
      }
    }
  }
}

func_4A1C(var_00, var_01, var_02) {
  var_03 = spawnStruct();
  var_3.func_269A = 0;
  var_3.streakname = var_00;
  var_3.func_9E0B = 0;
  var_3.func_FFC4 = 0;
  var_3.owner = var_01;
  var_3.func_A5B0 = _meth_81ED(self);
  var_3.lifeid = self.pers["deaths"];
  var_3.isgimme = 0;
  var_3.func_9F6E = 0;
  var_3.weapon = scripts\mp\utility\game::getkillstreakweapon(var_00);
  var_3.func_6D6B = func_7F41(var_00);
  var_3.streakshouldchain = getkillstreaksetupinfo(var_00);
  var_3.func_EF88 = scripts\mp\utility\game::func_7F4F(var_00);
  var_3.func_B143 = -1;
  var_3.variantid = var_02;
  return var_03;
}

_meth_81ED(var_00) {
  if(!isDefined(var_0.pers["nextKillstreakID"])) {
    var_0.pers["nextKillstreakID"] = 0;
  }

  var_01 = var_0.pers["nextKillstreakID"];
  var_0.pers["nextKillstreakID"]++;
  return var_01;
}

awardkillstreak(var_00, var_01, var_02, var_03) {
  var_04 = func_4A1C(var_00, var_01, var_03);
  func_26D5(var_04, var_02);
}

func_26D5(var_00, var_01) {
  var_0.isgimme = 1;

  if(isDefined(var_01) && var_1.size > 0) {
    scripts\mp\killstreak_loot::func_988A(var_00, var_01);
  }

  func_1030D(var_00, 0);
  func_F837(0);
  func_B2A9(0);
}

func_6693(var_00, var_01, var_02, var_03) {
  if(!isDefined(var_00) || !isDefined(var_01)) {
    return;
  }
  var_04 = func_4A1C(var_00, self, var_03);
  var_4.func_9E0B = 1;
  var_4.func_FFC4 = 1;

  if(isDefined(var_02) && var_2.size > 0) {
    scripts\mp\killstreak_loot::func_988A(var_04, var_02);
  }

  func_1030D(var_04, var_01);
}

func_66B9(var_00, var_01, var_02) {
  func_6693(var_00, 1, var_01, var_02);
}

func_66BB(var_00, var_01, var_02) {
  func_6693(var_00, 2, var_01, var_02);
}

func_66BA(var_00, var_01, var_02) {
  func_6693(var_00, 3, var_01, var_02);
}

func_DB1C() {
  var_00 = self.pers["killstreaks"];

  if(isDefined(var_0[35])) {
    return 0;
  }

  var_01 = var_0[0];

  if(!isDefined(var_01)) {
    return 1;
  }

  for(var_02 = 4; var_02 < 36; var_2++) {
    if(!isDefined(var_0[var_02])) {
      var_0[var_02] = var_01;
      var_0[0] = undefined;
      break;
    }
  }

  self.pers["killstreaks"] = var_00;
  return 1;
}

func_D65E() {
  var_00 = self.pers["killstreaks"];
  var_01 = var_0[0];
  var_02 = undefined;
  var_03 = undefined;

  for(var_04 = 4; var_04 < 36; var_4++) {
    var_05 = var_0[var_04];

    if(isDefined(var_05)) {
      var_02 = var_05;
      var_03 = var_04;
      continue;
    }

    break;
  }

  self.pers["killstreaks"][0] = var_02;

  if(isDefined(var_03)) {
    self.pers["killstreaks"][var_03] = undefined;
  }
}

func_51D3(var_00) {
  if(var_00 == 35) {
    self.pers["killstreaks"][var_00] = undefined;
    return;
  }

  var_01 = self.pers["killstreaks"];

  for(var_02 = var_00; var_02 < 35; var_2++) {
    var_03 = var_1[var_02 + 1];

    if(!isDefined(var_03)) {
      break;
    }
    var_1[var_00] = var_03;
  }

  self.pers["killstreaks"] = var_01;
}

func_E131(var_00) {
  self.pers["killstreaks"][var_00] = undefined;

  if(var_00 == 0) {
    func_D65E();
  }
  else if(var_00 >= 4) {
    func_51D3(var_00);
  }
}

func_41C0() {
  self.pers["killstreaks"] = [];
  func_E275();
  clearkillstreakselection();
  updatekillstreakselectedui();
}

func_1030D(var_00, var_01) {
  if(var_01 == 0) {
    if(!func_DB1C()) {
      return;
    }
  } else {}

  self.pers["killstreaks"][var_01] = var_00;
  updatekillstreakselectedui();
}

func_5FBF(var_00, var_01) {
  var_02 = func_7F45(var_00);
  var_03 = var_2.streakname;
  scripts\mp\utility\game::bufferednotify("earned_killstreak_buffered", var_03);
  self.func_5FBE = var_01;

  if(scripts\mp\utility\game::_hasperk("specialty_support_killstreaks")) {
    self.pers["killstreaks"][var_00].earned = 1;
  }

  if(!level.gameended) {
    var_04 = var_03;
    var_05 = scripts\mp\killstreak_loot::getrarityforlootitem(var_2.variantid);

    if(var_05 != "") {
      var_04 = var_04 + "_" + var_05;
    }

    thread scripts\mp\hud_message::showkillstreaksplash(var_04, var_01);
  }

  if(scripts\mp\utility\game::_hasperk("specialty_support_killstreaks")) {
    scripts\mp\missions::func_D991("ch_trait_support");
  }

  func_DDF0(var_03);
  func_F866();
  func_B2A9(var_00);
}

func_B2A9(var_00) {
  var_01 = func_7F45(var_00);

  if(!isDefined(var_01)) {
    return;
  }
  var_02 = var_1.streakname;
  var_03 = var_1.streakshouldchain;

  if(self.team == "spectator") {
    return;
  }
  var_1.func_269A = 1;

  if(var_00 >= 0 && var_00 <= 3) {
    func_F837(var_00);
  }

  updatekillstreakselectedui();

  if(isDefined(var_3.func_26A2)) {
    self[[var_3.func_26A2]](var_01);
  }

  if(isDefined(var_1.func_9E0B) && var_1.func_9E0B && isDefined(var_1.func_FFC4) && var_1.func_FFC4) {
    self notify("received_earned_killstreak");
  }

  var_1.func_B143 = gettime();
  var_04 = scripts\mp\utility\game::getkillstreakindex(var_02);
  scripts\mp\analyticslog::logevent_killstreakearned(var_04, var_1.func_B143);
  scripts\mp\matchdata::logkillstreakavailableevent(var_02);
}

givekillstreak(var_00, var_01, var_02, var_03) {
  awardkillstreak(var_00, var_03);
}

getstreakcost(var_00) {
  var_01 = int(scripts\mp\utility\game::func_7F46(var_00));

  if(isDefined(self) && isplayer(self)) {
    var_01 = scripts\mp\killstreak_loot::modifycostforlootitem(self.streakvariantids[var_00], var_01);

    if(scripts\mp\utility\game::isspecialistkillstreak(var_00)) {
      if(isDefined(self.pers["gamemodeLoadout"])) {
        if(isDefined(self.pers["gamemodeLoadout"]["loadoutKillstreak1"]) && self.pers["gamemodeLoadout"]["loadoutKillstreak1"] == var_00) {
          var_01 = 2;
        }
        else if(isDefined(self.pers["gamemodeLoadout"]["loadoutKillstreak2"]) && self.pers["gamemodeLoadout"]["loadoutKillstreak2"] == var_00) {
          var_01 = 4;
        }
        else if(isDefined(self.pers["gamemodeLoadout"]["loadoutKillstreak3"]) && self.pers["gamemodeLoadout"]["loadoutKillstreak3"] == var_00) {
          var_01 = 6;
        }
        else {}
      } else if(issubstr(self.curclass, "custom")) {
        for(var_02 = 0; var_02 < 3; var_2++) {
          var_03 = self getrankedplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", self.class_num, "specialistStreaks", var_02);

          if(var_03 == var_00) {
            break;
          }
        }

        if(var_02 == 1) {
          var_01 = 500;
        }
        else if(var_02 == 2) {
          var_01 = 800;
        }
      } else if(issubstr(self.curclass, "callback")) {
        var_02 = 0;

        foreach(var_02, var_05 in self.pers["specialistStreaks"]) {
          if(var_05 == var_00) {
            break;
          }
        }

        var_01 = self.pers["specialistStreakKills"][var_02];
      } else if(issubstr(self.curclass, "axis") || issubstr(self.curclass, "allies")) {
        var_02 = 0;
        var_06 = "none";

        if(issubstr(self.curclass, "axis")) {
          var_06 = "axis";
        }
        else if(issubstr(self.curclass, "allies")) {
          var_06 = "allies";
        }

        for(var_07 = scripts\mp\utility\game::getclassindex(self.curclass); var_02 < 3; var_2++) {
          var_03 = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", var_06, var_07, "class", "specialistStreaks", var_02);

          if(var_03 == var_00) {
            break;
          }
        }

        var_01 = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", var_06, var_07, "class", "specialistStreakKills", var_02);
      }
    }
  }

  var_01 = int(clamp(var_01, 0, 7000));
  return var_01;
}

buttonpressed(var_00, var_01) {
  var_02 = 0;

  if(scripts\mp\utility\game::_hasperk("specialty_support_killstreaks")) {
    var_03 = scripts\mp\utility\game::getkillstreakindex(var_00);
    var_02 = 175 * var_03;
  }

  return var_02;
}

func_A6B0() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  level endon("game_ended");

  for(;;) {
    var_00 = scripts\engine\utility::waittill_any_return("ks_select_up", "ks_select_down");

    if(!scripts\engine\utility::is_player_gamepad_enabled()) {
      continue;
    }
    if(!scripts\mp\utility\game::isjuggernaut() && !scripts\mp\utility\game::istrue(self.iscarrying) && !isDefined(self.func_13111)) {
      var_01 = getclosestenemysqdist();

      if(!isDefined(var_01)) {
        continue;
      }
      var_02 = var_01;

      if(var_00 == "ks_select_up") {
        var_02 = func_7FED(var_01);
      }
      else if(var_00 == "ks_select_down") {
        var_02 = detonate(var_01);
      }
      else {}

      func_F837(var_02);
    }
  }
}

func_F1C5() {
  var_00 = self.pers["killstreaks"];

  for(var_01 = 3; var_01 >= 0; var_1--) {
    var_02 = var_0[var_01];

    if(isDefined(var_02) && var_2.func_269A) {
      func_F837(var_01);
      return;
    }
  }

  clearkillstreakselection();
}

func_7FED(var_00) {
  var_01 = self.pers["killstreaks"];
  var_02 = var_00;
  var_03 = scripts\engine\utility::ter_op(var_00 >= 3, 0, var_00 + 1);
  var_04 = var_00;
  var_05 = var_03;

  while(var_05 != var_04) {
    var_06 = var_1[var_05];

    if(isDefined(var_06) && var_6.func_269A) {
      var_02 = var_05;
      break;
    }

    var_5++;

    if(var_05 > 3) {
      var_05 = 0;
    }
  }

  return var_02;
}

detonate(var_00) {
  var_01 = self.pers["killstreaks"];
  var_02 = var_00;
  var_03 = scripts\engine\utility::ter_op(var_00 <= 0, 3, var_00 - 1);
  var_04 = var_00;
  var_05 = var_03;

  while(var_05 != var_04) {
    var_06 = var_1[var_05];

    if(isDefined(var_06) && var_6.func_269A) {
      var_02 = var_05;
      break;
    }

    var_5--;

    if(var_05 < 0) {
      var_05 = 3;
    }
  }

  return var_02;
}

func_F1CB() {
  var_00 = self.pers["killstreaks"];
  var_01 = undefined;
  var_02 = -1;

  for(var_03 = 3; var_03 >= 0; var_3--) {
    var_04 = var_0[var_03];

    if(isDefined(var_04) && var_4.func_269A) {
      var_05 = getstreakcost(var_4.streakname);

      if(var_05 > var_02) {
        var_01 = var_03;
        var_02 = var_05;
      }
    }
  }

  if(!isDefined(var_01)) {
    clearkillstreakselection();
    return;
  }

  func_F837(var_01);
}

func_F837(var_00) {
  var_01 = func_7F45(var_00);
  self.currentselectedkillstreakslot = var_00;
  updatekillstreakselectedui();
}

clearkillstreakselection() {
  self.currentselectedkillstreakslot = undefined;
  updatekillstreakselectedui();
}

_meth_8110() {
  var_00 = getclosestenemysqdist();

  if(!isDefined(var_00)) {
    return undefined;
  }

  return self.pers["killstreaks"][var_00];
}

getclosestenemysqdist() {
  return self.currentselectedkillstreakslot;
}

func_7F45(var_00) {
  return self.pers["killstreaks"][var_00];
}

func_7E9E(var_00) {
  var_01 = self.pers["killstreaks"];

  for(var_02 = 1; var_02 <= 3; var_2++) {
    var_03 = var_1[var_02];

    if(isDefined(var_03) && var_3.streakname == var_00) {
      return var_03;
    }
  }

  return undefined;
}

func_7E9F(var_00) {
  var_01 = self.pers["killstreaks"];

  for(var_02 = 1; var_02 <= 3; var_2++) {
    var_03 = var_1[var_02];

    if(isDefined(var_03) && var_3.streakname == var_00) {
      return var_02;
    }
  }

  return undefined;
}

missile_settargetpos(var_00) {
  var_01 = self.pers["killstreaks"];

  for(var_02 = 0; var_02 <= 3; var_2++) {
    var_03 = var_1[var_02];

    if(isDefined(var_03) && var_3.streakname == var_00 && var_3.func_269A) {
      return var_02;
    }
  }

  return undefined;
}

func_7F54(var_00) {
  var_01 = self.pers["killstreaks"];

  for(var_02 = 0; var_02 <= 3; var_2++) {
    var_03 = var_1[var_02];

    if(isDefined(var_03) && var_3.streakname == var_00) {
      return var_02;
    }
  }

  return undefined;
}

func_7ED6() {
  var_00 = [];
  var_01 = self.pers["killstreaks"];
  var_02 = func_7F45(0);

  if(isDefined(var_02)) {
    var_0[0] = var_02;

    for(var_03 = 4; var_03 < 36; var_3++) {
      var_04 = var_1[var_03];

      if(isDefined(var_04)) {
        var_0[var_0.size] = var_04;
        continue;
      }

      break;
    }
  }

  return var_00;
}

func_7DE7() {
  var_00 = [];
  var_01 = self.pers["killstreaks"];

  if(var_1.size) {
    for(var_02 = 1; var_02 < 4; var_2++) {
      var_03 = var_1[var_02];

      if(isDefined(var_03) && isDefined(var_3.streakname) && var_3.func_269A) {
        var_0[var_0.size] = var_03;
      }
    }
  }

  return var_00;
}

registerkillstreak(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08) {
  if(!isDefined(level.killstreaksetups)) {
    level.killstreaksetups = [];
  }

  var_09 = spawnStruct();
  level.killstreaksetups[var_00] = var_09;
  var_9.usefunc = var_01;
  var_9.user_triggered = var_02;
  var_9.func_26A2 = var_03;
  var_9.func_127BD = var_04;
  var_9.func_13C8D = var_05;
  var_9.weapontouse = var_06;
  var_9.func_9B12 = var_07;
  var_9.weaponswapwatcher = var_08;
}

getkillstreaksetupinfo(var_00) {
  var_01 = level.killstreaksetups[var_00];
  return var_01;
}

func_7F41(var_00) {
  if(var_00 == "none") {
    return "";
  }

  var_01 = scripts\mp\utility\game::func_7F4F(var_00);

  if(!isDefined(var_01) || var_01 == "") {
    return "";
  }

  switch (var_01) {
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
  return self.func_AA35;
}

func_3E4E(var_00) {
  foreach(var_02 in self.func_A6AB) {
    var_03 = getstreakcost(var_02);
    var_04 = func_7E9F(var_02);
    var_05 = func_7F45(var_04);

    if(self.previousstreakpoints < var_03 && var_00 >= var_03) {
      if(scripts\mp\utility\game::_hasperk("specialty_support_killstreaks") && scripts\mp\utility\game::istrue(self.pers["killstreaks"][var_04].earned)) {
        continue;
      }
      func_5FBF(var_04, var_03);
    }
  }
}

func_213F(var_00) {
  var_01 = self.pers["killstreaks"];

  if(!isDefined(var_01)) {
    return 0;
  }

  foreach(var_03 in var_00) {
    var_04 = 0;

    for(var_05 = 1; var_05 <= 3; var_5++) {
      var_06 = var_1[var_05];

      if(isDefined(var_06)) {
        if(isDefined(var_6.streakname)) {
          if(var_6.streakname == var_03) {
            var_04 = 1;
            break;
          }
        }
      } else if(var_03 == "none") {
        var_04 = 1;
        break;
      }
    }

    if(!var_04) {
      return 0;
    }
  }

  return 1;
}

func_6CBA(var_00) {
  var_01 = self.pers["killstreaks"];

  for(var_02 = 0; var_02 <= 36; var_2++) {
    var_03 = var_1[var_02];

    if(!isDefined(var_03)) {
      if(var_02 >= 4) {
        break;
      }
    } else if(var_00 == var_03)
      return var_02;
  }

  return undefined;
}

_meth_83A7(var_00, var_01) {
  if(!isDefined(var_01)) {
    var_01 = scripts\mp\rank::getscoreinfovalue(var_00);
  }

  if(var_01 == 0) {
    return;
  }
  var_02 = self.streakpoints + var_01;
  var_03 = var_02;
  var_04 = func_7FA2();

  if(var_03 >= var_04) {
    var_03 = var_03 - var_04;
  }

  setstreakpoints(var_03);
  func_3E4E(var_02);

  if(var_02 >= var_04) {
    setstreakpoints(var_03);
  }

  func_12F2E(var_03);
  scripts\mp\analyticslog::logevent_reportstreakscore(var_01, gettime(), scripts\mp\rank::getscoreinfocategory(var_00, "eventID"));
}

func_E275() {
  self.func_5FBE = 0;
  setstreakpoints(0);
  func_E274();
  func_12F2E(0);
}

setstreakpoints(var_00) {
  if(var_00 < 0) {
    var_00 = 0;
  }

  if(isDefined(self.streakpoints)) {
    self.previousstreakpoints = self.streakpoints;
  }
  else {
    self.previousstreakpoints = 0;
  }

  self.streakpoints = var_00;
  updatestreakcount();
}

func_110C3() {
  self endon("disconnect");
  level waittill("game_ended");
  scripts\mp\utility\game::func_F7DF("streakPoints", scripts\engine\utility::ter_op(isDefined(self.streakpoints), self.streakpoints, 0));
}

findunobstructedfiringpointaroundz(var_00, var_01, var_02, var_03) {
  var_04 = rotatevector((0, 0, 1), (-1 * var_03, 0, 0));
  var_05 = vectortoangles(var_01 - var_0.origin);

  for(var_06 = 0; var_06 < 360; var_06 = var_06 + 30) {
    var_07 = var_02 * rotatevector(var_04, (0, var_06 + var_5[1], 0));
    var_08 = var_01 + var_07;

    if(_findunobstructedfiringpointhelper(var_00, var_08, var_01)) {
      return var_08;
    }
  }

  return undefined;
}

findunobstructedfiringpointaroundy(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_06 = vectortoangles(var_0.origin - var_01);

  for(var_07 = var_03; var_07 <= var_04; var_07 = var_07 + var_05) {
    var_08 = rotatevector((1, 0, 0), (var_07 - 90, 0, 0));
    var_09 = var_02 * rotatevector(var_08, (0, var_6[1], 0));
    var_10 = var_01 + var_09;

    if(_findunobstructedfiringpointhelper(var_00, var_10, var_01)) {
      return var_10;
    }
  }

  return undefined;
}

_findunobstructedfiringpointhelper(var_00, var_01, var_02) {
  var_03 = bulletTrace(var_01, var_02, 0);

  if(var_3["fraction"] > 0.99) {
    return 1;
  }

  return 0;
}

findunobstructedfiringpoint(var_00, var_01, var_02) {
  var_03 = findunobstructedfiringpointaroundz(var_00, var_01, var_02, 30);

  if(!isDefined(var_03)) {
    var_03 = findunobstructedfiringpointaroundy(var_00, var_01, var_02, 15, 75, 15);
  }

  return var_03;
}

isusinggunship() {
  return isDefined(self.onhelisniper) && self.onhelisniper;
}

func_9FC4() {
  return isDefined(self.func_98FF) && self.func_98FF;
}

func_532A(var_00, var_01, var_02, var_03) {
  var_04 = "MOD_EXPLOSIVE";
  var_05 = 5000;
  var_06 = (0, 0, 0);
  var_07 = (0, 0, 0);
  var_08 = "";
  var_09 = "";
  var_10 = "";
  var_11 = undefined;

  if(!isDefined(var_03)) {
    return;
  }
  if(level.teambased) {
    foreach(var_13 in var_03) {
      if(scripts\mp\utility\game::func_9FE7(var_00, var_01, var_13)) {
        var_13 notify("damage", var_05, var_00, var_06, var_07, var_04, var_08, var_09, var_10, var_11, var_02);
        wait 0.05;
      }
    }
  } else {
    foreach(var_13 in var_03) {
      if(scripts\mp\utility\game::func_9FD8(var_00, var_01, var_13)) {
        var_13 notify("damage", var_05, var_00, var_06, var_07, var_04, var_08, var_09, var_10, var_11, var_02);
        wait 0.05;
      }
    }
  }
}

killstreakhit(var_00, var_01, var_02, var_03) {
  if(isDefined(var_01) && isplayer(var_00) && isDefined(var_2.owner) && isDefined(var_2.owner.team)) {
    if(scripts\mp\utility\game::playersareenemies(var_00, var_2.owner)) {
      if(scripts\mp\utility\game::iskillstreakweapon(var_01)) {
        return;
      }
      if(!isDefined(var_0.lasthittime[var_01])) {
        var_0.lasthittime[var_01] = 0;
      }

      if(var_0.lasthittime[var_01] == gettime()) {
        return;
      }
      var_0.lasthittime[var_01] = gettime();
      var_00 thread scripts\mp\gamelogic::threadedsetweaponstatbyname(var_01, 1, "hits");
      var_04 = var_00 scripts\mp\persistence::statgetbuffered("totalShots");
      var_05 = var_00 scripts\mp\persistence::statgetbuffered("hits") + 1;

      if(var_05 <= var_04) {
        var_00 scripts\mp\persistence::func_10E55("hits", var_05);
        var_00 scripts\mp\persistence::func_10E55("misses", int(var_04 - var_05));
        var_00 scripts\mp\persistence::func_10E55("accuracy", int(var_05 * 10000 / var_04));
      }

      if(isDefined(var_03) && scripts\engine\utility::isbulletdamage(var_03) || scripts\mp\utility\game::isprojectiledamage(var_03)) {
        var_00 thread scripts\mp\contractchallenges::contractshotslanded(var_01);
        var_0.lastdamagetime = gettime();
        var_06 = scripts\mp\utility\game::getweapongroup(var_01);

        if(var_06 == "weapon_lmg") {
          if(!isDefined(var_0.shotslandedlmg)) {
            var_0.shotslandedlmg = 1;
          }
          else {
            var_0.shotslandedlmg++;
          }
        }
      }
    }
  }
}

_meth_83A0() {
  thread scripts\mp\utility\game::giveunifiedpoints("destroyed_equipment");
}

givescorefortrophyblocks() {
  thread scripts\mp\utility\game::giveunifiedpoints("trophy_defense");
}

givescoreforblackhat() {
  thread scripts\mp\utility\game::giveunifiedpoints("blackhat_hack");
}

func_9E9F(var_00) {
  return var_00 == "iw6_minigunjugg_mp";
}

streaktyperesetsondeath(var_00) {
  switch (var_00) {
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

initridekillstreak(var_00) {
  scripts\engine\utility::allow_usability(0);
  var_01 = initridekillstreak_internal(var_00);

  if(isDefined(self)) {
    scripts\engine\utility::allow_usability(1);
  }

  return var_01;
}

initridekillstreak_internal(var_00) {
  if(isDefined(var_00) && func_9E6F(var_00)) {
    var_01 = "timeout";
  }
  else {
    var_01 = scripts\engine\utility::waittill_any_timeout(1.0, "disconnect", "death", "weapon_switch_started");
  }

  scripts\mp\hostmigration::waittillhostmigrationdone();

  if(var_01 == "weapon_switch_started") {
    return "fail";
  }

  if(!isalive(self)) {
    return "fail";
  }

  if(var_01 == "disconnect" || var_01 == "death") {
    if(var_01 == "disconnect") {
      return "disconnect";
    }

    if(self.team == "spectator") {
      return "fail";
    }

    return "success";
  }

  if(scripts\mp\utility\game::iskillstreakdenied()) {
    return "fail";
  }

  if(!isDefined(var_00) || !issubstr(var_00, "odin") || !issubstr(var_00, "pointSelect")) {
    if(var_00 == "orbital_deployment" || var_00 == "drone_hive") {
      self visionsetfadetoblackforplayer("black_bw", 0);
      thread scripts\mp\utility\game::set_visionset_for_watching_players("black_bw", 0, 1.0, undefined, 1);
      var_02 = scripts\engine\utility::waittill_any_timeout(0, "disconnect", "death");
    } else {
      self visionsetfadetoblackforplayer("black_bw", 0.75);
      thread scripts\mp\utility\game::set_visionset_for_watching_players("black_bw", 0.75, 1.0, undefined, 1);
      var_02 = scripts\engine\utility::waittill_any_timeout(0.8, "disconnect", "death");
    }
  } else
    var_02 = scripts\engine\utility::waittill_any_timeout(1.0, "disconnect", "death");

  self notify("black_out_done");
  scripts\mp\hostmigration::waittillhostmigrationdone();

  if(var_02 != "disconnect") {
    if(!isDefined(var_00) || !issubstr(var_00, "odin") || !issubstr(var_00, "pointSelect")) {
      thread clearrideintro(1.0);
    }
    else {
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

  if(scripts\mp\utility\game::iskillstreakdenied()) {
    return "fail";
  }

  if(var_02 == "disconnect") {
    return "disconnect";
  }
  else {
    return "success";
  }
}

func_9E6F(var_00) {
  switch (var_00) {
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

clearrideintro(var_00, var_01) {
  self endon("disconnect");

  if(isDefined(var_00)) {
    wait(var_00);
  }

  if(!isDefined(var_01)) {
    var_01 = 0;
  }

  self visionsetfadetoblackforplayer("", var_01);
  scripts\mp\utility\game::set_visionset_for_watching_players("", var_01);
  self notify("intro_cleared");
}

allowridekillstreakplayerexit(var_00) {
  if(isDefined(var_00)) {
    self endon(var_00);
  }

  if(!isDefined(self.owner)) {
    return;
  }
  var_01 = self.owner;
  level endon("game_ended");
  var_01 endon("disconnect");
  var_01 endon("end_remote");
  self endon("death");

  for(;;) {
    var_02 = 0;

    while(var_01 usebuttonpressed()) {
      var_02 = var_02 + 0.05;

      if(var_02 > 0.75) {
        self notify("killstreakExit");
        return;
      }

      wait 0.05;
    }

    wait 0.05;
  }
}

func_D507(var_00, var_01) {
  self endon("disconnect");
  level endon("game_ended");

  if(scripts\mp\utility\game::isusingremote()) {
    return 0;
  }

  if(!scripts\mp\utility\game::isreallyalive(self)) {
    return 0;
  }

  self notify("play_remote_sequence");
  var_02 = undefined;

  if(scripts\mp\utility\game::istrue(var_01)) {
    if(self isonladder() || self ismantling() || !self isonground()) {
      scripts\mp\hud_message::showerrormessage("KILLSTREAKS_UNAVAILABLE");
      return 0;
    }

    var_02 = "ks_remote_device_mp";
    scripts\mp\supers::allowsuperweaponstow();
    scripts\mp\utility\game::_giveweapon(var_02, 0, 0, 1);
    self setclientomnvar("ui_remote_control_sequence", 1);
    var_03 = scripts\mp\utility\game::func_11383(var_02);

    if(scripts\mp\utility\game::istrue(var_03)) {
      thread func_13A4C(var_02);
    }
    else {
      return 0;
    }
  }

  scripts\mp\utility\game::setusingremote(var_0.streakname);
  scripts\mp\utility\game::freezecontrolswrapper(1);
  thread func_12B9C();
  var_04 = scripts\engine\utility::waittill_any_timeout(1.0, "death");
  self notify("ks_freeze_end");

  if(!isDefined(var_04) || var_04 != "timeout") {
    self setclientomnvar("ui_remote_control_sequence", 0);
    scripts\mp\utility\game::freezecontrolswrapper(0);
    scripts\mp\utility\game::clearusingremote();

    if(isDefined(var_02)) {
      self notify("finished_with_manual_weapon_" + var_02);
    }

    return 0;
  }

  self setscriptablepartstate("killstreak", "visor_active", 0);
  thread func_13BA2();
  scripts\mp\utility\game::freezecontrolswrapper(0);
  self setclientomnvar("ui_remote_control_sequence", 0);
  return 1;
}

func_12B9C() {
  self endon("disconnect");
  self endon("ks_freeze_end");
  level waittill("round_switch");
  scripts\mp\utility\game::freezecontrolswrapper(0);
}

func_13A4C(var_00) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("finished_with_manual_weapon_" + var_00);

  if(self hasweapon(var_00)) {
    scripts\mp\supers::unstowsuperweapon();
    scripts\mp\utility\game::forcethirdpersonwhenfollowing(var_00);

    if(self getcurrentweapon() == "none") {
      scripts\mp\utility\game::_switchtoweapon(self.lastdroppableweaponobj);
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

func_11086(var_00) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("stop_remote_sequence");

  if(scripts\mp\utility\game::isreallyalive(self)) {
    if(scripts\mp\utility\game::istrue(level.nukedetonated) && !scripts\mp\utility\game::istrue(level.func_C1B2)) {
      thread scripts\mp\killstreaks\nuke::func_FB0F(0.05);
    }

    self setclientomnvar("ui_remote_control_sequence", 2);
    var_01 = "ks_remote_device_mp";

    if(scripts\mp\utility\game::istrue(var_00)) {
      wait 0.1;
      self notify("finished_with_manual_weapon_" + var_01);
    } else
      self notify("killstreak_finished_with_weapon_" + var_01);
  }

  thread scripts\mp\utility\game::delaysetclientomnvar(1.3, "ui_remote_control_sequence", 0);
  self setscriptablepartstate("killstreak", "neutral", 0);
  scripts\mp\utility\game::clearusingremote();
}

combatrecordkillstreakuse(var_00) {
  if(!scripts\mp\utility\game::canrecordcombatrecordstats()) {
    return;
  }
  var_01 = scripts\mp\utility\game::getstreakrecordtype(var_00);

  if(!isDefined(var_01)) {
    if(var_00 != "nuke") {}

    return;
  }

  var_02 = self getrankedplayerdata("mp", var_01, var_00, "uses");
  self setrankedplayerdata("mp", var_01, var_00, "uses", var_02 + 1);
}