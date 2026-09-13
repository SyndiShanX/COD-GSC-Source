/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\killstreaks.gsc
**************************************************/

initkillstreakdata() {
  _id_584994FAB4A8712B = spawnStruct();
  level._id_0B23156D776B1D85 = _id_584994FAB4A8712B;
  _id_584994FAB4A8712B.costomnvars = [];
  _id_584994FAB4A8712B.costomnvars[1] = "ui_score_streak_cost";
  _id_584994FAB4A8712B.costomnvars[2] = "ui_score_streak_two_cost";
  _id_584994FAB4A8712B.costomnvars[3] = "ui_score_streak_three_cost";
  _id_584994FAB4A8712B.slotomnvars = [];
  _id_584994FAB4A8712B.slotomnvars[0] = "ui_score_streak_index_0";
  _id_584994FAB4A8712B.slotomnvars[1] = "ui_score_streak_index_1";
  _id_584994FAB4A8712B.slotomnvars[2] = "ui_score_streak_index_2";
  _id_584994FAB4A8712B.slotomnvars[3] = "ui_score_streak_index_3";
  _id_584994FAB4A8712B.availableomnvars = [];
  _id_584994FAB4A8712B.availableomnvars[0] = "ui_score_streak_available_0";
  _id_584994FAB4A8712B.availableomnvars[1] = "ui_score_streak_available_1";
  _id_584994FAB4A8712B.availableomnvars[2] = "ui_score_streak_available_2";
  _id_584994FAB4A8712B.availableomnvars[3] = "ui_score_streak_available_3";
  _id_584994FAB4A8712B._id_8BBE6DC152F1DAE0 = [];
  _id_584994FAB4A8712B._id_8BBE6DC152F1DAE0[1] = "ui_score_streak_last_round_earned_1";
  _id_584994FAB4A8712B._id_8BBE6DC152F1DAE0[2] = "ui_score_streak_last_round_earned_2";
  _id_584994FAB4A8712B._id_8BBE6DC152F1DAE0[3] = "ui_score_streak_last_round_earned_3";
  _id_1F9E754F6B690E33();

  if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback(::killstreakonteamchange);

  if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73() && getdvarint("dvar_8B0F39DEAC448892", 0))
    level._id_55DAE6D1042D7E1E = ["assault_drone", "scrambler_drone_guard", "cruise_predator", "sentry_gun", "fuel_airstrike", "hover_jet", "airdrop_escort", "pac_sentry", "auto_drone", "chopper_gunner", "gunship", "juggernaut"];
}

_id_1F9E754F6B690E33() {
  _id_584994FAB4A8712B = level._id_0B23156D776B1D85;

  if(isDefined(_id_584994FAB4A8712B._id_038F2A11237246AC)) {
    return;
  }
  _id_584994FAB4A8712B._id_038F2A11237246AC = [];
  _id_584994FAB4A8712B._id_2150DA9328528BB9 = [];
  _id_20EE381602C954DB = getscriptbundle(scripts\cp_mp\utility\killstreak_utility::_id_0708853C5D755F72());

  foreach(index, _id_CC673384F6943C85 in _id_20EE381602C954DB._id_386A08793AF08E6C) {
    if(!isnumber(index)) {
      continue;
    }
    if(!isDefined(_id_CC673384F6943C85)) {
      continue;
    }
    if(!isDefined(_id_CC673384F6943C85.ref)) {
      continue;
    }
    _id_2B7CF61AF0CB9960 = _id_CC673384F6943C85.ref;

    if(_id_2B7CF61AF0CB9960 == "none") {
      continue;
    }
    _id_5AD12D18E74C1F78 = _id_CC673384F6943C85._id_D442547D75DFFD09;

    if(!isDefined(_id_5AD12D18E74C1F78)) {
      continue;
    }
    if(_id_5AD12D18E74C1F78 == "killstreak_none") {
      continue;
    }
    if(_id_5AD12D18E74C1F78 == "replace_me") {
      continue;
    }
    _id_D442547D75DFFD09 = getscriptbundle("killstreak:" + _id_5AD12D18E74C1F78);

    if(!isDefined(_id_D442547D75DFFD09)) {
      continue;
    }
    _id_584994FAB4A8712B._id_038F2A11237246AC[_id_2B7CF61AF0CB9960] = _id_D442547D75DFFD09;
    _id_584994FAB4A8712B._id_2150DA9328528BB9[_id_2B7CF61AF0CB9960] = index;
    _id_1002CEB046A0D0F8 = _func_1823FF50BB28148D(_id_2B7CF61AF0CB9960);
    game["dialog"][_id_1002CEB046A0D0F8] = "killstreak_team_leader_earned";
    game["dialog"][_id_2B7CF61AF0CB9960 + "_teamleader_friendly_inbound"] = "killstreak_team_leader_ally_callout";
    game["dialog"][_id_2B7CF61AF0CB9960 + "_teamleader_enemy_inbound"] = "killstreak_team_leader_enemy_callout";
    game["dialog"][_id_2B7CF61AF0CB9960 + "_teamleader_destroyed"] = "killstreak_team_leader_crash";
    game["dialog"][_id_2B7CF61AF0CB9960 + "_teamleader_timeout"] = "killstreak_team_leader_timeout";
    streakpoints = _id_D442547D75DFFD09.score;
    scripts\mp\rank::registerscoreinfo(_func_2EF675C13CA1C4AF("stat_FD85621902D48DC8", _id_2B7CF61AF0CB9960), "stat_7CE4FD9430E80CEA", streakpoints);
  }
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", player);

    if(!isDefined(player.pers["streakData"]))
      player.pers["streakData"] = createplayerstreakdatastruct();

    player.streakdata = player.pers["streakData"];
    player scripts\mp\utility\stats::initpersstat("streakPoints");
    player.streakpoints = player scripts\mp\utility\stats::getpersstat("streakPoints");
    player.previousstreakpoints = player.streakpoints;
    player.nukepoints = player scripts\mp\utility\stats::getpersstat("cur_kill_streak");
    player visionsetmissilecamforplayer(game["thermal_vision"]);

    if(!level.roundretainstreaks)
      player resetstreakavailability(1);

    player _id_B7492842AAD6FE82();
  }
}

onplayerspawned() {
  if(isDefined(level.deathretainstreaks) && !level.deathretainstreaks)
    resetstreakavailability(1);

  selectfirstavailablekillstreak();

  if(!isDefined(self.earnedstreaklevel))
    self.earnedstreaklevel = 0;

  self.triggeringstreak = undefined;
  setstreakcounttonext();
  updatekillstreakselectedui();
  updatekillstreakuislots();
  updatestreakmeterui();
  updatestreakcosts();
  triggeravailablekillstreaks();
}

createplayerstreakdatastruct() {
  streakdata = spawnStruct();
  streakdata.streaks = [];
  return streakdata;
}

getplayerstreakdata() {
  return self.streakdata;
}

resetforloadoutswitch() {
  if(istrue(level.casualscorestreaks)) {
    return;
  }
  updatespecialistui();
  updatestreakcosts();

  if(isDefined(self.oldperks) && isDefined(self.perks) && self.oldperks.size > 0) {
    if(scripts\engine\utility::array_contains_key(self.perks, "specialty_support_killstreaks") && scripts\engine\utility::array_contains_key(self.oldperks, "specialty_support_killstreaks"))
      return;
    else if(!scripts\engine\utility::array_contains_key(self.oldperks, "specialty_support_killstreaks"))
      return;
    else {
      resetstreakpoints();
      resetstreakavailability();
      updatekillstreakuislots();
      updatekillstreakselectedui();
    }
  }
}

setupinputnotifications() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(isbot(self)) {
    return;
  }
  scripts\mp\flags::gameflagwait("prematch_done");
  self notifyonplayercommand("ks_select_up", "+actionslot 1");
  self notifyonplayercommand("ks_select_down", "+actionslot 2");
  self notifyonplayercommand("ks_action_5", "+actionslot 5");
  self notifyonplayercommand("ks_action_6", "+actionslot 6");
  self notifyonplayercommand("ks_action_3", "+actionslot 3");
  self notifyonplayercommand("ks_action_4", "+actionslot 4");
  self setactionslot(4, "");
}

updatestreakcount() {
  if(self.streakpoints == self.previousstreakpoints) {
    return;
  }
  _id_36DA2F0C55913388 = self.streakpoints;
  _id_29050ADF065DDF86(int(min(self.streakpoints, 16384)));

  if(!isDefined(self.nextstreakcost) || self.streakpoints >= self.nextstreakcost)
    setstreakcounttonext();
}

resetstreakcount() {
  _id_29050ADF065DDF86(0);
  self setclientomnvar("ui_score_streak_cost", 0);
  self setclientomnvar("ui_score_streak_two_cost", 0);
  self setclientomnvar("ui_score_streak_three_cost", 0);
  setstreakcounttonext();
}

setstreakcounttonext() {
  if(!isDefined(self.streaktype)) {
    self.nextstreakcost = 0;
    self setnextkillstreakcost(0);
    return;
  }

  if(findmaxstreakcost() == 0) {
    self.nextstreakcost = 0;
    self setnextkillstreakcost(0);
    return;
  }

  _id_FC5890F05240FFAA = self.nextstreakcost;
  _id_631DF3F5D4971DDD = getnextstreakname();

  if(!isDefined(_id_631DF3F5D4971DDD)) {
    return;
  }
  nextstreakcost = calcstreakcost(_id_631DF3F5D4971DDD);
  self.nextstreakcost = nextstreakcost;

  if(scripts\mp\utility\perk::_hasperk("specialty_support_killstreaks") && isDefined(getkillstreakinslot(1)) && !istrue(self.earnedmaxkillstreak)) {
    _id_0226C0FDD8C3B878 = 0;

    foreach(_id_153FDEE861E0F06F in self.streakdata.streaks) {
      if(istrue(_id_153FDEE861E0F06F.earned)) {
        _id_0226C0FDD8C3B878 = 1;
        continue;
      }

      _id_0226C0FDD8C3B878 = 0;
    }

    if(_id_0226C0FDD8C3B878 && !isDefined(self.earnedmaxkillstreak)) {
      self.earnedmaxkillstreak = 1;
      self.nextstreakcost = 0;
      self setnextkillstreakcost(0);
      _id_29050ADF065DDF86(0);
      self setclientomnvar("ui_score_streak_cost", 0);
      self setclientomnvar("ui_score_streak_two_cost", 0);
      self setclientomnvar("ui_score_streak_three_cost", 0);
      return;
    }
  }

  self setnextkillstreakcost(nextstreakcost);
}

getnextstreakname() {
  if(self.streakpoints == findmaxstreakcost() && self.streaktype != "specialist")
    streakpoints = 0;
  else
    streakpoints = self.streakpoints;

  for(_id_015314DA30B44470 = 1; _id_015314DA30B44470 <= 4; _id_015314DA30B44470++) {
    _id_16EFCF27E6EFCBE8 = getkillstreakinslot(_id_015314DA30B44470);

    if(isDefined(_id_16EFCF27E6EFCBE8) && isDefined(_id_16EFCF27E6EFCBE8.currentcost) && _id_16EFCF27E6EFCBE8.currentcost > streakpoints)
      return _id_16EFCF27E6EFCBE8.streakname;
  }

  return undefined;
}

updatestreakmeterui() {
  self setclientomnvar("ui_score_streak", self.streakpoints);
}

updatestreakcosts() {
  updatestreakcost(1);
  updatestreakcost(2);
  updatestreakcost(3);
  updatestreakcost(4);
}

updatestreakcost(_id_015314DA30B44470) {
  _id_16EFCF27E6EFCBE8 = getkillstreakinslot(_id_015314DA30B44470);

  if(isDefined(_id_16EFCF27E6EFCBE8)) {
    currentcost = calcstreakcost(_id_16EFCF27E6EFCBE8.streakname);
    _id_16EFCF27E6EFCBE8.currentcost = currentcost;

    if(_id_015314DA30B44470 <= 3) {
      _id_E9D476A3809CB3F1 = level._id_0B23156D776B1D85.costomnvars[_id_015314DA30B44470];
      self setclientomnvar(_id_E9D476A3809CB3F1, currentcost);
      _id_B3FD3059338901D8(_id_015314DA30B44470, currentcost);
    }
  }
}

findmaxstreakcost() {
  for(_id_015314DA30B44470 = 4; _id_015314DA30B44470 >= 1; _id_015314DA30B44470--) {
    _id_16EFCF27E6EFCBE8 = getkillstreakinslot(_id_015314DA30B44470);

    if(!isDefined(_id_16EFCF27E6EFCBE8)) {
      continue;
    }
    return _id_16EFCF27E6EFCBE8.currentcost;
  }

  return 0;
}

updatekillstreakuislots() {
  if(!scripts\mp\utility\player::isreallyalive(self)) {
    return;
  }
  for(_id_FB85F48630D3D4FF = 0; _id_FB85F48630D3D4FF <= 3; _id_FB85F48630D3D4FF++)
    updatekillstreakuislot(_id_FB85F48630D3D4FF);
}

updatekillstreakuislot(_id_015314DA30B44470) {
  if(_id_015314DA30B44470 > 3) {
    return;
  }
  _id_584994FAB4A8712B = level._id_0B23156D776B1D85;
  _id_16EFCF27E6EFCBE8 = getkillstreakinslot(_id_015314DA30B44470);

  if(isDefined(_id_16EFCF27E6EFCBE8) && isDefined(_id_16EFCF27E6EFCBE8.streakname)) {
    index = undefined;

    if(istrue(self.loadoutusingspecialist) && _id_015314DA30B44470 != 0) {
      perk = scripts\mp\perks\perks::getspecialistperkforstreak(_id_16EFCF27E6EFCBE8.streakname);
      index = scripts\mp\perks\perks::getperkid(perk);
    } else
      index = scripts\cp_mp\utility\killstreak_utility::getkillstreakindex(_id_16EFCF27E6EFCBE8.streakname);

    self setclientomnvar(_id_584994FAB4A8712B.slotomnvars[_id_015314DA30B44470], index);
    self setclientomnvar(_id_584994FAB4A8712B.availableomnvars[_id_015314DA30B44470], _id_16EFCF27E6EFCBE8.available);
    _id_E0859317B5E7A75B(_id_015314DA30B44470, index);
    _id_8D43CE79A3F2D876(_id_015314DA30B44470, _id_16EFCF27E6EFCBE8.available);
    _id_B3FD3059338901D8(_id_015314DA30B44470, _id_16EFCF27E6EFCBE8.currentcost);
  } else {
    self setclientomnvar(_id_584994FAB4A8712B.slotomnvars[_id_015314DA30B44470], 0);
    self setclientomnvar(_id_584994FAB4A8712B.availableomnvars[_id_015314DA30B44470], 0);
    _id_E0859317B5E7A75B(_id_015314DA30B44470, 0);
    _id_8D43CE79A3F2D876(_id_015314DA30B44470, 0);
    _id_B3FD3059338901D8(_id_015314DA30B44470, 0);
  }
}

updatekillstreakselectedui() {
  _id_AC1FBBFC38B10426 = getselectedkillstreakindex();

  if(isDefined(_id_AC1FBBFC38B10426))
    self setclientomnvar("ui_score_streak_selected_slot", _id_AC1FBBFC38B10426);
  else
    self setclientomnvar("ui_score_streak_selected_slot", -1);
}

_id_B7492842AAD6FE82() {
  if(!isDefined(self)) {
    return;
  }
  if(isagent(self) || isbot(self)) {
    return;
  }
  if(!isDefined(self.streakdata)) {
    return;
  }
  for(_id_FB85F48630D3D4FF = 0; _id_FB85F48630D3D4FF <= 3; _id_FB85F48630D3D4FF++)
    _id_95CDA89AC13F2D7C(_id_FB85F48630D3D4FF);
}

_id_95CDA89AC13F2D7C(_id_015314DA30B44470) {
  _id_584994FAB4A8712B = level._id_0B23156D776B1D85;
  _id_16EFCF27E6EFCBE8 = getkillstreakinslot(_id_015314DA30B44470);
  _id_86F175D25984D15B = self.pers["deaths"];

  if(isDefined(_id_16EFCF27E6EFCBE8) && isDefined(_id_16EFCF27E6EFCBE8.streakname)) {
    if(_id_015314DA30B44470 != 0) {
      _id_B3E0E45EB45070EC = 0;

      if(_id_16EFCF27E6EFCBE8.available && _id_16EFCF27E6EFCBE8.streaklifeid != _id_86F175D25984D15B)
        _id_B3E0E45EB45070EC = 1;

      self setclientomnvar(_id_584994FAB4A8712B._id_8BBE6DC152F1DAE0[_id_015314DA30B44470], _id_B3E0E45EB45070EC);
    }
  }
}

updatespecialistui() {
  if(isDefined(self.loadoutusingspecialist))
    self setclientomnvar("ui_score_streak_is_specialist", self.loadoutusingspecialist);
}

killstreakonteamchange(player) {
  if(istrue(player.changedteams))
    player clearkillstreaks();
}

listenkillstreakaction(_id_EA3E3B2121E6713A, _id_015314DA30B44470) {
  if(isDefined(_id_EA3E3B2121E6713A) && _id_EA3E3B2121E6713A == "streak_select")
    dokillstreakaction(undefined, _id_015314DA30B44470);
}

dokillstreakaction(action, _id_015314DA30B44470) {
  if(isDefined(self.triggeringstreak)) {
    return;
  }
  if(isDefined(action) && issubstr(action, "ks_"))
    _id_015314DA30B44470 = gettriggeredslotfromnotify(action);

  if(!isDefined(_id_015314DA30B44470)) {
    return;
  }
  _id_16EFCF27E6EFCBE8 = getkillstreakinslot(_id_015314DA30B44470);

  if(!isDefined(_id_16EFCF27E6EFCBE8) || _id_16EFCF27E6EFCBE8.available == 0 || _id_16EFCF27E6EFCBE8.available == -1) {
    return;
  }
  setselectedkillstreak(_id_015314DA30B44470);
  thread triggerkillstreak(_id_16EFCF27E6EFCBE8, _id_015314DA30B44470);
}

trytriggerkillstreakfromsuper(streakname) {
  _id_16EFCF27E6EFCBE8 = createstreakitemstruct(streakname);
  _id_16EFCF27E6EFCBE8.available = 1;
  return triggerkillstreak(_id_16EFCF27E6EFCBE8);
}

gettriggeredslotfromnotify(_id_EA3E3B2121E6713A) {
  _id_015314DA30B44470 = undefined;

  if(!isai(self)) {
    if(!self usinggamepad()) {
      if(_id_EA3E3B2121E6713A == "ks_action_3" || _id_EA3E3B2121E6713A == "ks_action_4" || _id_EA3E3B2121E6713A == "ks_action_5" || _id_EA3E3B2121E6713A == "ks_action_6")
        _id_015314DA30B44470 = getselectedkillstreakindex();
    }
  } else if(scripts\mp\utility\game::getgametype() == "grnd" && !scripts\engine\utility::is_player_gamepad_enabled()) {
    switch (_id_EA3E3B2121E6713A) {
      case "ks_action_3":
        _id_015314DA30B44470 = 0;
        break;
      case "ks_action_4":
        _id_015314DA30B44470 = 0;
        break;
      case "ks_action_5":
        _id_015314DA30B44470 = 0;
        break;
      case "ks_action_6":
        _id_015314DA30B44470 = 0;
        break;
    }
  } else {
    switch (_id_EA3E3B2121E6713A) {
      case "ks_action_3":
        _id_015314DA30B44470 = 1;
        break;
      case "ks_action_4":
        _id_015314DA30B44470 = 2;
        break;
      case "ks_action_5":
        _id_015314DA30B44470 = 3;
        break;
      case "ks_action_6":
        _id_015314DA30B44470 = 0;
        break;
    }
  }

  return _id_015314DA30B44470;
}

iskillstreakvisibleforcodcaster(streakname) {
  if(!isDefined(streakname))
    return 0;

  switch (streakname) {
    case "counter_uav":
    case "dronedrop":
    case "directional_uav":
    case "uav":
      return 0;
    default:
      return 1;
  }
}

triggerkillstreak(_id_16EFCF27E6EFCBE8, _id_015314DA30B44470) {
  self endon("disconnect");
  level endon("game_ended");
  streaksetupinfo = _id_16EFCF27E6EFCBE8.streaksetupinfo;

  if(!_id_3B64EB40368C1450::_id_E0751B03DFB9EB43("killstreaks")) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS/CANNOT_BE_USED");
    return 0;
  }

  if(self _meth_9CC921A57FF4DEB5()) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS/CANNOT_BE_USED");
    return 0;
  }

  if(isDefined(level.modeiskillstreakallowed) && !self[[level.modeiskillstreakallowed]](_id_16EFCF27E6EFCBE8, _id_015314DA30B44470)) {
    if(isDefined(_id_16EFCF27E6EFCBE8._id_67243B08ECF2E214))
      scripts\mp\hud_message::showerrormessage(_id_16EFCF27E6EFCBE8._id_67243B08ECF2E214);
    else
      scripts\mp\hud_message::showerrormessage("KILLSTREAKS/CANNOT_BE_USED");

    return 0;
  }

  if(_id_16EFCF27E6EFCBE8.isspecialist || isDefined(self.triggeringstreak) && self.triggeringstreak == _id_16EFCF27E6EFCBE8)
    return 0;

  self.triggeringstreak = _id_16EFCF27E6EFCBE8;
  scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_cancelalldeployments();
  streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo(_id_16EFCF27E6EFCBE8.streakname, self);
  streakinfo.mpstreaksysteminfo = _id_16EFCF27E6EFCBE8;
  _id_E005D4B70D6F2611 = scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508();

  if(_id_E005D4B70D6F2611) {
    self setclientomnvar("ui_br_using_killstreak", 1);
    _id_16EFCF27E6EFCBE8.uniqueid = streakinfo.id;
  }

  scripts\mp\gamelogic::sethasdonecombat(self, 1);
  _id_9F5B1C5031E4B039 = self[[streaksetupinfo.triggeredfunc]](streakinfo);
  self.triggeringstreak = undefined;

  if(_id_E005D4B70D6F2611)
    self setclientomnvar("ui_br_using_killstreak", 0);

  if(!istrue(_id_9F5B1C5031E4B039))
    return 0;

  if(isDefined(_id_015314DA30B44470))
    onsuccessfulstreakactivation(_id_16EFCF27E6EFCBE8, _id_015314DA30B44470);

  if(isDefined(self.team))
    level notify("killstreak_used_" + self.team, _id_16EFCF27E6EFCBE8.streakname);

  thread _id_189B67B2735B981D::_id_967DE5F2484E51EF(self, streakinfo.streakname);
  return 1;
}

onkillstreaktriggered(streakinfo) {
  return 1;
}

onkillstreakbeginuse(streakinfo) {
  owner = streakinfo.owner;

  if(!isDefined(owner))
    return 0;

  return 1;
}

onkillstreakfinishuse(streakinfo, _id_B6BE7467E1DA151A) {}

forceactivatekillstreak(streakname, owner) {
  _id_16EFCF27E6EFCBE8 = createstreakitemstruct(streakname);
  triggerkillstreak(_id_16EFCF27E6EFCBE8);
}

forceactivategimmekillstreak() {
  _id_16EFCF27E6EFCBE8 = getkillstreakinslot(0);
  triggerkillstreak(_id_16EFCF27E6EFCBE8);
}

onsuccessfulstreakactivation(_id_16EFCF27E6EFCBE8, _id_015314DA30B44470) {
  streakname = _id_16EFCF27E6EFCBE8.streakname;
  self notify("streak_activated", streakname);

  if(istrue(level._id_7DFAD9748480C388) && self.streaktype != "specialist")
    _id_16EFCF27E6EFCBE8.available = -1;
  else
    _id_16EFCF27E6EFCBE8.available = -1;

  _id_8D43CE79A3F2D876(_id_015314DA30B44470, _id_16EFCF27E6EFCBE8.available);
  _id_E005D4B70D6F2611 = scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508();

  if(isDefined(_id_015314DA30B44470)) {
    if(_id_E005D4B70D6F2611 || (_id_015314DA30B44470 == 0 || _id_015314DA30B44470 >= 5)) {
      removekillstreak(_id_015314DA30B44470);

      if(getdvarint("dvar_1D3C72CAB41E5D7C", 0))
        _id_7E52B56769FA7774::_id_B76F69CE63757CEA(streakname);
    }

    selectnextavailablekillstreak();
    updatekillstreakuislot(_id_015314DA30B44470);
  } else {}

  thread scripts\cp_mp\challenges::usedkillstreak(streakname);
  scripts\mp\utility\print::printgameaction("killstreak started - " + streakname, self);
  scripts\cp_mp\utility\killstreak_utility::playkillstreakusedialog(streakname);
  activatedtime = scripts\mp\matchdata::gettimefrommatchstart(gettime());
  _id_16EFCF27E6EFCBE8.activatedtime = activatedtime;
  scripts\mp\analyticslog::logevent_killstreakactivated(self, _id_16EFCF27E6EFCBE8.streakmatchlifeid, _id_16EFCF27E6EFCBE8.streakname, _id_16EFCF27E6EFCBE8.isgimme, activatedtime, self.origin);

  switch (streakname) {
    case "care_package":
      scripts\mp\utility\stats::incpersstat("killstreakCarePackageUsed", 1);
      break;
    case "emergency_airdrop":
      scripts\mp\utility\stats::incpersstat("killstreakEmergencyAirdropUsed", 1);
      break;
  }

  combatrecordkillstreakuse(streakname);

  if(isDefined(self.petwatch)) {
    scripts\cp_mp\pet_watch::addkillstreakcharge();

    if(_id_16EFCF27E6EFCBE8.currentcost > 7)
      scripts\cp_mp\pet_watch::addtopkillstreakcharge();

    if(streakname == "nuke")
      scripts\cp_mp\pet_watch::addnukecharge();
    else if(streakname == "juggernaut")
      scripts\cp_mp\pet_watch::addjuggernautcharge();
  }
}

createstreakitemstruct(streakname) {
  _id_16EFCF27E6EFCBE8 = spawnStruct();
  _id_16EFCF27E6EFCBE8.available = 0;
  _id_16EFCF27E6EFCBE8.streakname = streakname;
  _id_16EFCF27E6EFCBE8.isgimme = 0;
  _id_16EFCF27E6EFCBE8.streaksetupinfo = getkillstreaksetupinfo(streakname);
  _id_16EFCF27E6EFCBE8.madeavailabletime = -1;
  _id_16EFCF27E6EFCBE8.currentcost = calcstreakcost(streakname);
  _id_16EFCF27E6EFCBE8.isspecialist = scripts\mp\perks\perks::isspecialiststreak(streakname);
  _id_16EFCF27E6EFCBE8.specialistperk = scripts\mp\perks\perks::getspecialistperkforstreak(streakname);
  return _id_16EFCF27E6EFCBE8;
}

awardkillstreak(streakname, source, _id_352D315FC8A744CE, _id_722764086BD2150D, _id_E01ECD2F1FF85E28, _id_546F4A2E8B131D3F) {
  _id_16EFCF27E6EFCBE8 = createstreakitemstruct(streakname);
  awardkillstreakfromstruct(_id_16EFCF27E6EFCBE8, source, _id_352D315FC8A744CE, _id_722764086BD2150D, _id_E01ECD2F1FF85E28, _id_546F4A2E8B131D3F);
}

awardkillstreakfromstruct(_id_16EFCF27E6EFCBE8, source, _id_352D315FC8A744CE, _id_722764086BD2150D, _id_E01ECD2F1FF85E28, _id_546F4A2E8B131D3F) {
  _id_16EFCF27E6EFCBE8.isgimme = 1;
  _id_DFA6F061FC548E80 = 0;

  if(isDefined(_id_546F4A2E8B131D3F))
    _id_DFA6F061FC548E80 = _id_546F4A2E8B131D3F;

  if(isDefined(_id_16EFCF27E6EFCBE8)) {
    if(!isDefined(_id_352D315FC8A744CE))
      _id_352D315FC8A744CE = _id_16EFCF27E6EFCBE8.streaklifeid;

    if(!isDefined(_id_722764086BD2150D))
      _id_722764086BD2150D = _id_16EFCF27E6EFCBE8.streakmatchlifeid;
  }

  slotkillstreak(_id_16EFCF27E6EFCBE8, _id_DFA6F061FC548E80);
  setselectedkillstreak(_id_DFA6F061FC548E80);
  makekillstreakavailable(_id_DFA6F061FC548E80, source, _id_352D315FC8A744CE, _id_722764086BD2150D, _id_E01ECD2F1FF85E28);
}

equipkillstreak(streakname, _id_015314DA30B44470) {
  if(!isDefined(streakname) || !isDefined(_id_015314DA30B44470)) {
    return;
  }
  _id_16EFCF27E6EFCBE8 = createstreakitemstruct(streakname);
  slotkillstreak(_id_16EFCF27E6EFCBE8, _id_015314DA30B44470);
}

equipslotonekillstreak(streakname) {
  equipkillstreak(streakname, 1);
}

equipslottwokillstreak(streakname) {
  equipkillstreak(streakname, 2);
}

equipslotthreekillstreak(streakname) {
  equipkillstreak(streakname, 3);
}

pushgimmeslotstreakontostack() {
  _id_245D8A017DA23D3E = getplayerstreakdata();

  if(isDefined(_id_245D8A017DA23D3E.streaks[36]))
    return 0;

  _id_8AE4B342199BBB1A = _id_245D8A017DA23D3E.streaks[0];

  if(!isDefined(_id_8AE4B342199BBB1A))
    return 1;

  for(_id_87C06A6FBF20E489 = 5; _id_87C06A6FBF20E489 < 37; _id_87C06A6FBF20E489++) {
    if(!isDefined(_id_245D8A017DA23D3E.streaks[_id_87C06A6FBF20E489])) {
      _id_245D8A017DA23D3E.streaks[_id_87C06A6FBF20E489] = _id_8AE4B342199BBB1A;
      _id_245D8A017DA23D3E.streaks[0] = undefined;
      break;
    }
  }

  return 1;
}

popstackedstreakintogimmeslot() {
  _id_245D8A017DA23D3E = getplayerstreakdata();
  _id_8AE4B342199BBB1A = _id_245D8A017DA23D3E.streaks[0];
  _id_11738FCB38C5309B = undefined;
  _id_DBF9E7F32E883840 = undefined;

  for(_id_87C06A6FBF20E489 = 5; _id_87C06A6FBF20E489 < 37; _id_87C06A6FBF20E489++) {
    _id_730CCC1B27C04AE8 = _id_245D8A017DA23D3E.streaks[_id_87C06A6FBF20E489];

    if(isDefined(_id_730CCC1B27C04AE8)) {
      _id_11738FCB38C5309B = _id_730CCC1B27C04AE8;
      _id_DBF9E7F32E883840 = _id_87C06A6FBF20E489;
      continue;
    }

    break;
  }

  _id_245D8A017DA23D3E.streaks[0] = _id_11738FCB38C5309B;

  if(isDefined(_id_DBF9E7F32E883840))
    _id_245D8A017DA23D3E.streaks[_id_DBF9E7F32E883840] = undefined;
}

deletestackedstreak(_id_015314DA30B44470) {
  _id_245D8A017DA23D3E = getplayerstreakdata();

  if(_id_015314DA30B44470 == 36) {
    _id_245D8A017DA23D3E.streaks[_id_015314DA30B44470] = undefined;
    return;
  }

  for(_id_87C06A6FBF20E489 = _id_015314DA30B44470; _id_87C06A6FBF20E489 < 36; _id_87C06A6FBF20E489++) {
    _id_A9C7299B6086939D = _id_245D8A017DA23D3E.streaks[_id_87C06A6FBF20E489 + 1];

    if(!isDefined(_id_A9C7299B6086939D)) {
      break;
    }

    _id_245D8A017DA23D3E.streaks[_id_015314DA30B44470] = _id_A9C7299B6086939D;
  }
}

removekillstreak(_id_015314DA30B44470) {
  self.streakdata.streaks[_id_015314DA30B44470] = undefined;

  if(_id_015314DA30B44470 == 0)
    popstackedstreakintogimmeslot();
  else if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && _id_015314DA30B44470 == 1) {
    if(_id_0B7A9CE0A2282B79::_id_E0FC1230452CF4E7())
      _id_0B7A9CE0A2282B79::_id_28550536EBAFE216(self);

    clearkillstreaks();
  } else if(_id_015314DA30B44470 >= 5)
    deletestackedstreak(_id_015314DA30B44470);
}

clearkillstreaks() {
  self.streakdata.streaks = [];
  resetstreakpoints();
  resetstreakavailability();
  clearkillstreakselection();
  updatekillstreakuislots();
  updatekillstreakselectedui();
}

slotkillstreak(_id_16EFCF27E6EFCBE8, _id_015314DA30B44470) {
  if(_id_015314DA30B44470 == 0) {
    if(!pushgimmeslotstreakontostack())
      return;
  } else {}

  self.streakdata.streaks[_id_015314DA30B44470] = _id_16EFCF27E6EFCBE8;
  updatekillstreakuislot(_id_015314DA30B44470);

  if(_id_015314DA30B44470 != 0)
    updatestreakcost(_id_015314DA30B44470);
}

earnkillstreak(_id_015314DA30B44470, _id_32E049AFBC37BD56) {
  _id_16EFCF27E6EFCBE8 = getkillstreakinslot(_id_015314DA30B44470);
  streakname = _id_16EFCF27E6EFCBE8.streakname;
  scripts\mp\utility\script::bufferednotify("earned_killstreak_buffered", streakname);
  self.earnedstreaklevel = _id_32E049AFBC37BD56;

  if(scripts\mp\utility\perk::_hasperk("specialty_support_killstreaks"))
    self.streakdata.streaks[_id_015314DA30B44470].earned = 1;

  self.streakdata.streaks[_id_015314DA30B44470].lifeid = scripts\cp_mp\utility\killstreak_utility::getcurrentplayerlifeidforkillstreak();

  if(!level.gameended) {
    thread scripts\mp\hud_message::showkillstreaksplash(streakname, _id_015314DA30B44470);
    combatrecordincrementkillstreakawardedstat(streakname);
  }

  setstreakcounttonext();
  makekillstreakavailable(_id_015314DA30B44470, "earned");
  clientnum = self getentitynumber();
  _id_548072087C9FD504::_id_F63556DC2AA67FDC(0, clientnum, _id_015314DA30B44470);
}

makekillstreakavailable(_id_015314DA30B44470, source, _id_352D315FC8A744CE, _id_722764086BD2150D, _id_E01ECD2F1FF85E28) {
  _id_16EFCF27E6EFCBE8 = getkillstreakinslot(_id_015314DA30B44470);

  if(!isDefined(_id_16EFCF27E6EFCBE8)) {
    return;
  }
  streakname = _id_16EFCF27E6EFCBE8.streakname;

  if(isDefined(_id_16EFCF27E6EFCBE8.specialistperk))
    streakname = _id_16EFCF27E6EFCBE8.specialistperk;

  loadassociatedkillstreakweapons(streakname);
  streaksetupinfo = _id_16EFCF27E6EFCBE8.streaksetupinfo;

  if(self.team == "spectator") {
    return;
  }
  _id_16EFCF27E6EFCBE8.available = 1;
  _id_8D43CE79A3F2D876(_id_015314DA30B44470, _id_16EFCF27E6EFCBE8.available);
  setselectedkillstreak(_id_015314DA30B44470);
  updatekillstreakuislot(_id_015314DA30B44470);

  if(isDefined(streaksetupinfo.availablefunc))
    self[[streaksetupinfo.availablefunc]](_id_16EFCF27E6EFCBE8);

  if(_id_16EFCF27E6EFCBE8.isgimme)
    self notify("received_earned_killstreak");

  _id_16EFCF27E6EFCBE8.madeavailabletime = scripts\mp\matchdata::gettimefrommatchstart(gettime());
  _id_16EFCF27E6EFCBE8.streaklifeid = self.lifeid;
  _id_16EFCF27E6EFCBE8.streakmatchlifeid = self.matchdatalifeindex;
  _id_16EFCF27E6EFCBE8.owner = self;
  _id_16EFCF27E6EFCBE8.ownerxuid = self getxuid();

  if(isDefined(_id_352D315FC8A744CE))
    _id_16EFCF27E6EFCBE8.streaklifeid = _id_352D315FC8A744CE;

  if(isDefined(_id_722764086BD2150D))
    _id_16EFCF27E6EFCBE8.streakmatchlifeid = _id_722764086BD2150D;

  if(isDefined(_id_E01ECD2F1FF85E28)) {
    _id_16EFCF27E6EFCBE8.owner = _id_E01ECD2F1FF85E28;
    _id_16EFCF27E6EFCBE8.ownerxuid = _id_E01ECD2F1FF85E28 getxuid();
  }

  scripts\cp_mp\challenges::_id_D8F43796D36ED5BF(streakname, source);
  scripts\mp\analyticslog::logevent_killstreakavailable(self, _id_16EFCF27E6EFCBE8.streakmatchlifeid, streakname, _id_16EFCF27E6EFCBE8.isgimme, _id_16EFCF27E6EFCBE8.madeavailabletime, self.origin);

  if(isDefined(self.petwatch) && _id_015314DA30B44470 == 3) {
    _id_255A376CBD6929BA = 0;
    _id_A04E7ED93FA07B83 = 0;
    _id_98BCB23F5F5AB5C7 = getallavailablekillstreakstructs();

    foreach(_id_153FDEE861E0F06F in _id_98BCB23F5F5AB5C7) {
      _id_1385C002E4DE24F4 = getvisiblekillstreakavailable(_id_153FDEE861E0F06F.streakname);

      switch (_id_1385C002E4DE24F4) {
        case 1:
          _id_255A376CBD6929BA = _id_153FDEE861E0F06F.streaklifeid == self.lifeid;
          break;
        case 2:
          _id_A04E7ED93FA07B83 = _id_153FDEE861E0F06F.streaklifeid == self.lifeid;
          break;
        default:
          break;
      }
    }

    if(_id_255A376CBD6929BA && _id_A04E7ED93FA07B83)
      scripts\cp_mp\pet_watch::addallkillstreaksunlockedinonelife();
    else
      scripts\cp_mp\pet_watch::addallkillstreaksunlocked();
  }
}

_id_E0859317B5E7A75B(_id_015314DA30B44470, index) {
  if(_id_015314DA30B44470 > 3) {
    return;
  }
  scripts\mp\codcasterclientmatchdata::_id_6807ED320B73BE7F(3, _id_015314DA30B44470, index);
}

_id_8D43CE79A3F2D876(_id_015314DA30B44470, _id_2B11FCB306AA898C) {
  if(_id_015314DA30B44470 > 3) {
    return;
  }
  if(_id_2B11FCB306AA898C < 0)
    _id_2B11FCB306AA898C = 0;

  scripts\mp\codcasterclientmatchdata::_id_6807ED320B73BE7F(4, _id_015314DA30B44470, _id_2B11FCB306AA898C);
}

_id_B3FD3059338901D8(_id_015314DA30B44470, cost) {
  if(_id_015314DA30B44470 > 3 || !isDefined(cost)) {
    return;
  }
  scripts\mp\codcasterclientmatchdata::_id_6807ED320B73BE7F(2, _id_015314DA30B44470, cost);
}

_id_29050ADF065DDF86(_id_B20A008833190858) {
  scripts\mp\codcasterclientmatchdata::_id_7EE466E81B1AFC12(8, _id_B20A008833190858);
}

givekillstreak(streakname, _id_E1FC7660351AD693, _id_E1FC7760351AD8C6) {
  awardkillstreak(streakname, "other");
}

calcstreakcost(streakname) {
  cost = int(scripts\mp\utility\killstreak::getkillstreakkills(streakname));

  if(isDefined(self) && isPlayer(self))
    cost = cost + getperkadjustedkillstreakcost(streakname, cost);

  cost = int(clamp(cost, 0, 7000));
  return cost;
}

getperkadjustedkillstreakcost(streakname, cost) {
  _id_BB3A4ED149FCAF82 = 0;

  if(scripts\mp\utility\perk::_hasperk("specialty_support_killstreaks")) {
    index = scripts\cp_mp\utility\killstreak_utility::getkillstreakindex(streakname);
    _id_BB3A4ED149FCAF82 = 175 * index;
  }

  if(scripts\mp\utility\perk::_hasperk("specialty_hardline") && cost > 0 && streakname != "nuke") {
    if(scripts\mp\utility\perk::_hasperk("specialty_killstreak_to_scorestreak"))
      _id_BB3A4ED149FCAF82 = _id_BB3A4ED149FCAF82 - 125;
    else
      _id_BB3A4ED149FCAF82--;
  }

  return _id_BB3A4ED149FCAF82;
}

killstreakselectionwatcher() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  level endon("game_ended");

  for(;;) {
    _id_EA3E3B2121E6713A = scripts\engine\utility::waittill_any_return_2("ks_select_up", "ks_select_down");

    if(!scripts\engine\utility::is_player_gamepad_enabled()) {
      continue;
    }
    if(!istrue(self.iscarrying)) {
      _id_87B2434B91E0FC37 = getselectedkillstreakindex();

      if(!isDefined(_id_87B2434B91E0FC37)) {
        continue;
      }
      _id_F37426A5AFCCF614 = _id_87B2434B91E0FC37;

      if(_id_EA3E3B2121E6713A == "ks_select_up")
        _id_F37426A5AFCCF614 = getnextselectablekillstreakslot(_id_87B2434B91E0FC37);
      else if(_id_EA3E3B2121E6713A == "ks_select_down")
        _id_F37426A5AFCCF614 = getpreviousselectablekillstreakslot(_id_87B2434B91E0FC37);
      else {}

      setselectedkillstreak(_id_F37426A5AFCCF614);
    }
  }
}

selectfirstavailablekillstreak() {
  _id_245D8A017DA23D3E = getplayerstreakdata();

  if(isDefined(_id_245D8A017DA23D3E.streaks[0])) {
    if(_id_245D8A017DA23D3E.streaks[0].available == 1) {
      setselectedkillstreak(0);
      return;
    }
  } else {
    for(_id_015314DA30B44470 = 3; _id_015314DA30B44470 >= 0; _id_015314DA30B44470--) {
      _id_16EFCF27E6EFCBE8 = _id_245D8A017DA23D3E.streaks[_id_015314DA30B44470];

      if(isDefined(_id_16EFCF27E6EFCBE8) && _id_16EFCF27E6EFCBE8.available == 1) {
        setselectedkillstreak(_id_015314DA30B44470);
        return;
      }
    }
  }

  clearkillstreakselection();
}

getnextselectablekillstreakslot(_id_73E860F9676499E1) {
  _id_F37426A5AFCCF614 = _id_73E860F9676499E1;
  _id_D98B9E3625693C3B = scripts\engine\utility::ter_op(_id_73E860F9676499E1 >= 3, 0, _id_73E860F9676499E1 + 1);
  _id_ECF773E7BB221C28 = _id_73E860F9676499E1;
  _id_E1D097C517C3AF5B = _id_D98B9E3625693C3B;

  while(_id_E1D097C517C3AF5B != _id_ECF773E7BB221C28) {
    _id_16EFCF27E6EFCBE8 = self.streakdata.streaks[_id_E1D097C517C3AF5B];

    if(isDefined(_id_16EFCF27E6EFCBE8) && _id_16EFCF27E6EFCBE8.available == 1) {
      _id_F37426A5AFCCF614 = _id_E1D097C517C3AF5B;
      break;
    }

    _id_E1D097C517C3AF5B++;

    if(_id_E1D097C517C3AF5B > 3)
      _id_E1D097C517C3AF5B = 0;
  }

  return _id_F37426A5AFCCF614;
}

getpreviousselectablekillstreakslot(_id_73E860F9676499E1) {
  _id_F37426A5AFCCF614 = _id_73E860F9676499E1;
  _id_D98B9E3625693C3B = scripts\engine\utility::ter_op(_id_73E860F9676499E1 <= 0, 3, _id_73E860F9676499E1 - 1);
  _id_ECF773E7BB221C28 = _id_73E860F9676499E1;
  _id_E1D097C517C3AF5B = _id_D98B9E3625693C3B;

  while(_id_E1D097C517C3AF5B != _id_ECF773E7BB221C28) {
    _id_16EFCF27E6EFCBE8 = self.streakdata.streaks[_id_E1D097C517C3AF5B];

    if(isDefined(_id_16EFCF27E6EFCBE8) && _id_16EFCF27E6EFCBE8.available == 1) {
      _id_F37426A5AFCCF614 = _id_E1D097C517C3AF5B;
      break;
    }

    _id_E1D097C517C3AF5B--;

    if(_id_E1D097C517C3AF5B < 0)
      _id_E1D097C517C3AF5B = 3;
  }

  return _id_F37426A5AFCCF614;
}

selectmostexpensivekillstreak() {
  _id_F37426A5AFCCF614 = undefined;
  _id_4ADC76A2E089AFD2 = -1;

  for(_id_8CE3D0565C392BED = 3; _id_8CE3D0565C392BED >= 0; _id_8CE3D0565C392BED--) {
    _id_16EFCF27E6EFCBE8 = self.streakdata.streaks[_id_8CE3D0565C392BED];

    if(isDefined(_id_16EFCF27E6EFCBE8) && _id_16EFCF27E6EFCBE8.available == 1) {
      if(_id_16EFCF27E6EFCBE8.currentcost > _id_4ADC76A2E089AFD2) {
        _id_F37426A5AFCCF614 = _id_8CE3D0565C392BED;
        _id_4ADC76A2E089AFD2 = _id_16EFCF27E6EFCBE8.currentcost;
      }
    }
  }

  if(!isDefined(_id_F37426A5AFCCF614)) {
    clearkillstreakselection();
    return;
  }

  setselectedkillstreak(_id_F37426A5AFCCF614);
}

selectnextavailablekillstreak() {
  _id_F37426A5AFCCF614 = undefined;
  _id_4ADC76A2E089AFD2 = -1;

  for(_id_8CE3D0565C392BED = 0; _id_8CE3D0565C392BED <= 3; _id_8CE3D0565C392BED++) {
    _id_16EFCF27E6EFCBE8 = self.streakdata.streaks[_id_8CE3D0565C392BED];

    if(isDefined(_id_16EFCF27E6EFCBE8) && _id_16EFCF27E6EFCBE8.available == 1) {
      if(istrue(_id_16EFCF27E6EFCBE8.isgimme)) {
        _id_F37426A5AFCCF614 = _id_8CE3D0565C392BED;
        break;
      } else if(_id_16EFCF27E6EFCBE8.currentcost > _id_4ADC76A2E089AFD2) {
        _id_F37426A5AFCCF614 = _id_8CE3D0565C392BED;
        _id_4ADC76A2E089AFD2 = _id_16EFCF27E6EFCBE8.currentcost;
      }
    }
  }

  if(!isDefined(_id_F37426A5AFCCF614)) {
    clearkillstreakselection();
    return;
  }

  setselectedkillstreak(_id_F37426A5AFCCF614);
}

setselectedkillstreak(_id_015314DA30B44470) {
  if(_id_015314DA30B44470 != 0 && istrue(self.loadoutusingspecialist)) {
    return;
  }
  _id_16EFCF27E6EFCBE8 = getkillstreakinslot(_id_015314DA30B44470);
  self.currentselectedkillstreakslot = _id_015314DA30B44470;
  updatekillstreakselectedui();
}

clearkillstreakselection() {
  self.currentselectedkillstreakslot = undefined;
  updatekillstreakselectedui();
}

getselectedkillstreak() {
  _id_F26451879315CADC = getselectedkillstreakindex();

  if(!isDefined(_id_F26451879315CADC))
    return undefined;

  return self.streakdata.streaks[_id_F26451879315CADC];
}

getselectedkillstreakindex() {
  return self.currentselectedkillstreakslot;
}

getkillstreakinslot(_id_015314DA30B44470) {
  return self.streakdata.streaks[_id_015314DA30B44470];
}

getequippedkillstreakbyname(streakname) {
  for(_id_87C06A6FBF20E489 = 1; _id_87C06A6FBF20E489 <= 3; _id_87C06A6FBF20E489++) {
    _id_16EFCF27E6EFCBE8 = self.streakdata.streaks[_id_87C06A6FBF20E489];

    if(isDefined(_id_16EFCF27E6EFCBE8) && _id_16EFCF27E6EFCBE8.streakname == streakname)
      return _id_16EFCF27E6EFCBE8;
  }

  return undefined;
}

getequippedkillstreakslotbyname(streakname) {
  for(_id_87C06A6FBF20E489 = 1; _id_87C06A6FBF20E489 <= 3; _id_87C06A6FBF20E489++) {
    _id_16EFCF27E6EFCBE8 = self.streakdata.streaks[_id_87C06A6FBF20E489];

    if(isDefined(_id_16EFCF27E6EFCBE8) && _id_16EFCF27E6EFCBE8.streakname == streakname)
      return _id_87C06A6FBF20E489;
  }

  return undefined;
}

getvisiblekillstreakavailable(streakname) {
  for(_id_87C06A6FBF20E489 = 0; _id_87C06A6FBF20E489 <= 3; _id_87C06A6FBF20E489++) {
    _id_16EFCF27E6EFCBE8 = self.streakdata.streaks[_id_87C06A6FBF20E489];

    if(isDefined(_id_16EFCF27E6EFCBE8) && _id_16EFCF27E6EFCBE8.streakname == streakname && _id_16EFCF27E6EFCBE8.available == 1)
      return _id_87C06A6FBF20E489;
  }

  return undefined;
}

getkillstreakvisibleslotbyname(streakname) {
  for(_id_87C06A6FBF20E489 = 0; _id_87C06A6FBF20E489 <= 3; _id_87C06A6FBF20E489++) {
    _id_16EFCF27E6EFCBE8 = self.streakdata.streaks[_id_87C06A6FBF20E489];

    if(isDefined(_id_16EFCF27E6EFCBE8) && _id_16EFCF27E6EFCBE8.streakname == streakname)
      return _id_87C06A6FBF20E489;
  }

  return undefined;
}

getgimmeslotkillstreakstructs() {
  _id_9E4E1482CB40C9C5 = [];
  _id_5DE8F4BC3629955F = getkillstreakinslot(0);

  if(isDefined(_id_5DE8F4BC3629955F)) {
    _id_9E4E1482CB40C9C5[0] = _id_5DE8F4BC3629955F;

    for(_id_87C06A6FBF20E489 = 5; _id_87C06A6FBF20E489 < 37; _id_87C06A6FBF20E489++) {
      _id_16EFCF27E6EFCBE8 = self.streakdata.streaks[_id_87C06A6FBF20E489];

      if(isDefined(_id_16EFCF27E6EFCBE8)) {
        _id_9E4E1482CB40C9C5[_id_9E4E1482CB40C9C5.size] = _id_16EFCF27E6EFCBE8;
        continue;
      }

      break;
    }
  }

  return _id_9E4E1482CB40C9C5;
}

getavailableequippedkillstreakstructs() {
  _id_9E4E1482CB40C9C5 = [];

  if(self.streakdata.streaks.size > 0) {
    for(_id_8CE3D0565C392BED = 1; _id_8CE3D0565C392BED < 4; _id_8CE3D0565C392BED++) {
      _id_16EFCF27E6EFCBE8 = self.streakdata.streaks[_id_8CE3D0565C392BED];

      if(isDefined(_id_16EFCF27E6EFCBE8) && isDefined(_id_16EFCF27E6EFCBE8.streakname) && _id_16EFCF27E6EFCBE8.available == 1)
        _id_9E4E1482CB40C9C5[_id_9E4E1482CB40C9C5.size] = _id_16EFCF27E6EFCBE8;
    }
  }

  return _id_9E4E1482CB40C9C5;
}

getallavailablekillstreakstructs() {
  _id_9E4E1482CB40C9C5 = [];

  if(self.streakdata.streaks.size > 0) {
    for(_id_8CE3D0565C392BED = 0; _id_8CE3D0565C392BED < 3; _id_8CE3D0565C392BED++) {
      _id_16EFCF27E6EFCBE8 = self.streakdata.streaks[_id_8CE3D0565C392BED];

      if(isDefined(_id_16EFCF27E6EFCBE8) && isDefined(_id_16EFCF27E6EFCBE8.streakname) && _id_16EFCF27E6EFCBE8.available == 1)
        _id_9E4E1482CB40C9C5[_id_9E4E1482CB40C9C5.size] = _id_16EFCF27E6EFCBE8;
    }
  }

  return _id_9E4E1482CB40C9C5;
}

registerkillstreak(streakname, triggeredfunc, availablefunc, _id_0B1469BCDAEC75A9) {
  if(!isDefined(level.killstreaksetups))
    level.killstreaksetups = [];

  _id_61CE9E3EAC2AAB90 = spawnStruct();
  level.killstreaksetups[streakname] = _id_61CE9E3EAC2AAB90;
  _id_61CE9E3EAC2AAB90.triggeredfunc = triggeredfunc;
  _id_61CE9E3EAC2AAB90.availablefunc = availablefunc;
  _id_61CE9E3EAC2AAB90._id_0B1469BCDAEC75A9 = _id_0B1469BCDAEC75A9;
}

_id_9336A3981B59677B(streakname, _id_D8A64ED9BCDF7185, _id_1BE56CDC5D342875) {
  _id_2669878CF5A1B6BC::_id_F30B8F5EE8F3E7F8(streakname, _id_D8A64ED9BCDF7185);
  scripts\mp\utility\killstreak::_id_394DE31762A977EB(_id_D8A64ED9BCDF7185, _id_1BE56CDC5D342875);
}

getkillstreaksetupinfo(streakname) {
  _id_61CE9E3EAC2AAB90 = level.killstreaksetups[streakname];
  return _id_61CE9E3EAC2AAB90;
}

checkstreakreward(_id_F47C9F3183EF23B0) {
  for(_id_015314DA30B44470 = 1; _id_015314DA30B44470 <= 4; _id_015314DA30B44470++)
    _id_19DA1DB57971906A(_id_015314DA30B44470, _id_F47C9F3183EF23B0);
}

_id_19DA1DB57971906A(_id_015314DA30B44470, _id_F47C9F3183EF23B0) {
  _id_16EFCF27E6EFCBE8 = getkillstreakinslot(_id_015314DA30B44470);

  if(!isDefined(_id_16EFCF27E6EFCBE8)) {
    return;
  }
  _id_32E049AFBC37BD56 = _id_16EFCF27E6EFCBE8.currentcost;

  if(self.previousstreakpoints >= _id_32E049AFBC37BD56 || _id_F47C9F3183EF23B0 < _id_32E049AFBC37BD56) {
    return;
  }
  if(scripts\mp\utility\perk::_hasperk("specialty_support_killstreaks") && istrue(_id_16EFCF27E6EFCBE8.earned)) {
    return;
  }
  if(isDefined(_id_16EFCF27E6EFCBE8.lifeid) && _id_16EFCF27E6EFCBE8.lifeid == self.lifeid && (!istrue(level._id_7DFAD9748480C388) || istrue(level._id_7DFAD9748480C388) && self.streaktype == "specialist") || istrue(level._id_7DFAD9748480C388) && istrue(level.casualscorestreaks) && self.streaktype != "specialist" && _id_16EFCF27E6EFCBE8.available == -1) {
    return;
  }
  self.pers["hasEarnedHardlineStreak"] = 1;
  earnkillstreak(_id_015314DA30B44470, _id_32E049AFBC37BD56);
}

arekillstreaksequipped(_id_DDA4F8FC2767DCEF) {
  _id_245D8A017DA23D3E = getplayerstreakdata();

  if(!isDefined(_id_245D8A017DA23D3E) || !isDefined(_id_245D8A017DA23D3E.streaks))
    return 0;

  foreach(_id_B2C36A9E7D9A5D9A in _id_DDA4F8FC2767DCEF) {
    _id_2F89AF3C33468EBE = 0;

    for(_id_8CE3D0565C392BED = 1; _id_8CE3D0565C392BED <= 4; _id_8CE3D0565C392BED++) {
      _id_16EFCF27E6EFCBE8 = _id_245D8A017DA23D3E.streaks[_id_8CE3D0565C392BED];

      if(isDefined(_id_16EFCF27E6EFCBE8)) {
        if(isDefined(_id_16EFCF27E6EFCBE8.streakname) && _id_16EFCF27E6EFCBE8.streakname == _id_B2C36A9E7D9A5D9A) {
          if(_id_16EFCF27E6EFCBE8.isspecialist) {
            specialistperk = scripts\mp\perks\perks::getspecialistperkforstreak(_id_B2C36A9E7D9A5D9A);

            if(_id_16EFCF27E6EFCBE8.specialistperk == specialistperk) {
              _id_2F89AF3C33468EBE = 1;
              break;
            }
          } else {
            _id_2F89AF3C33468EBE = 1;
            break;
          }
        }

        continue;
      }

      if(_id_B2C36A9E7D9A5D9A == "none") {
        _id_2F89AF3C33468EBE = 1;
        break;
      }
    }

    if(!_id_2F89AF3C33468EBE)
      return 0;
  }

  return 1;
}

findkillstreakslotnumber(_id_16EFCF27E6EFCBE8) {
  for(_id_8CE3D0565C392BED = 0; _id_8CE3D0565C392BED <= 37; _id_8CE3D0565C392BED++) {
    _id_730CCC1B27C04AE8 = self.streakdata.streaks[_id_8CE3D0565C392BED];

    if(!isDefined(_id_730CCC1B27C04AE8)) {
      if(_id_8CE3D0565C392BED >= 5) {
        break;
      }
    } else if(_id_16EFCF27E6EFCBE8 == _id_730CCC1B27C04AE8)
      return _id_8CE3D0565C392BED;
  }

  return undefined;
}

streakglobals_onkillstreaktriggered(streakinfo) {
  if(isDefined(streakinfo.mpstreaksysteminfo)) {
    _id_ED407C9468DD3E49 = onkillstreaktriggered(streakinfo);

    if(!_id_ED407C9468DD3E49)
      return 0;
  }

  return 1;
}

streakglobals_onkillstreakbeginuse(streakinfo) {
  owner = streakinfo.owner;

  if(isDefined(streakinfo.mpstreaksysteminfo)) {
    _id_ED407C9468DD3E49 = onkillstreakbeginuse(streakinfo);

    if(!_id_ED407C9468DD3E49)
      return 0;
  }

  if(isDefined(owner)) {
    if(level.codcasterenabled) {
      if(iskillstreakvisibleforcodcaster(streakinfo.streakname))
        owner setnoteworthykillstreakactive(1);
    }

    clientnum = owner getentitynumber();
    _id_548072087C9FD504::_id_F63556DC2AA67FDC(1, clientnum, owner getkillstreakvisibleslotbyname(streakinfo.streakname));

    if(scripts\mp\utility\game::ismlgmatch()) {
      _id_AD802F5C40204240 = level._id_0B23156D776B1D85._id_038F2A11237246AC[streakinfo.streakname].kills;
      _id_AD802F5C40204240 = scripts\engine\utility::ter_op(isDefined(_id_AD802F5C40204240), _id_AD802F5C40204240, 0);

      if(_id_AD802F5C40204240 >= 1000)
        _id_87C06A6FBF20E489 = level._id_0B23156D776B1D85._id_2150DA9328528BB9[streakinfo.streakname];
    }
  }

  return 1;
}

streakglobals_onkillstreakfinishuse(streakinfo) {
  owner = streakinfo.owner;
  _id_B6BE7467E1DA151A = 0;

  if(isDefined(owner))
    _id_B6BE7467E1DA151A = owner scripts\mp\utility\killstreak::hasplayerdiedwhileusingkillstreak(streakinfo);

  if(isDefined(streakinfo.mpstreaksysteminfo))
    onkillstreakfinishuse(streakinfo, _id_B6BE7467E1DA151A);

  if(isDefined(owner)) {
    if(!_id_B6BE7467E1DA151A)
      owner notify("killstreak_use_finished");

    if(level.codcasterenabled)
      owner setnoteworthykillstreakactive(0);
  }
}

givestreakpoints(type, _id_A29FE2801F117AE6, _id_17DF47994982B4D2) {
  if(istrue(game["isLaunchChunk"])) {
    return;
  }
  points = scripts\engine\utility::ter_op(scripts\mp\utility\perk::_hasperk("specialty_killstreak_to_scorestreak"), _id_17DF47994982B4D2, _id_A29FE2801F117AE6);

  if(!isDefined(points))
    points = scripts\mp\rank::getscoreinfovalue(type);

  if(points == 0) {
    return;
  }
  self.pers["killstreakToScorestreak"] = undefined;
  self.pers["killstreakToScorestreak_lifeId"] = undefined;
  _id_FB3D43F4D6D424EE = self.streakpoints + points;
  _id_C0E6B80E5E7F63FA = findmaxstreakcost();

  if(_id_FB3D43F4D6D424EE > _id_C0E6B80E5E7F63FA)
    _id_FB3D43F4D6D424EE = _id_C0E6B80E5E7F63FA;

  isvalidevent = _id_F1C3DEF91CF17909(type);

  if(isvalidevent && !istrue(level.disablepersonalnuke) && (istrue(level.allowkillstreaks) || isDefined(level.personalnukecostoverride))) {
    _id_44C59A12E6465947 = self.nukepoints + _id_A29FE2801F117AE6;
    _id_F3ADC82C7B8B4249 = calcstreakcost("nuke");

    if(isDefined(level.personalnukecostoverride))
      _id_F3ADC82C7B8B4249 = level.personalnukecostoverride;

    if(_id_F3ADC82C7B8B4249 > 0) {
      if(_id_44C59A12E6465947 >= _id_F3ADC82C7B8B4249) {
        self.nukepoints = _id_F3ADC82C7B8B4249;

        if(!istrue(self.pers["earned_nuke"])) {
          thread scripts\mp\hud_message::showkillstreaksplash("nuke_multi", _id_F3ADC82C7B8B4249);
          awardkillstreak("nuke_multi", "earned");
          self.pers["earned_nuke"] = 1;
          _id_189B67B2735B981D::_id_55B08D6D71B41402(self, "nuke_earned");
        }
      } else {
        self.nukepoints = _id_44C59A12E6465947;

        if(isDefined(self.petwatch))
          scripts\cp_mp\pet_watch::updatenukeprogress(self.nukepoints / _id_F3ADC82C7B8B4249);
      }
    }
  }

  setstreakpoints(_id_FB3D43F4D6D424EE);
  checkstreakreward(_id_FB3D43F4D6D424EE);
  updatestreakmeterui();

  if(istrue(level._id_7DFAD9748480C388 && self.streaktype != "specialist")) {
    if(_id_FB3D43F4D6D424EE >= _id_C0E6B80E5E7F63FA) {
      _id_FB3D43F4D6D424EE = 0;
      setstreakpoints(0);
      _id_29050ADF065DDF86(0);
      setstreakcounttonext();
      resetstreakavailability();
    }
  }

  scripts\mp\analyticslog::logevent_reportstreakscore(points, gettime(), scripts\mp\rank::getscoreinfocategory(type, "stat_EC3B335BB0B2F752"));
}

_id_F1C3DEF91CF17909(event) {
  _id_509B1132D6BCE34B = 0;

  if(event == "stat_EF9582D72160F199" || event == "stat_1613256561AA6C9C" || event == "stat_F36CF9654E0A0530" || event == "stat_2CF53744F496A844" || event == "stat_121F2644E525ABA3" || event == "stat_80D36F563CEC5AA6")
    _id_509B1132D6BCE34B = 1;

  return _id_509B1132D6BCE34B;
}

resetstreakpoints() {
  self.earnedstreaklevel = 0;
  self.nukepoints = 0;
  setstreakpoints(0);
  resetstreakcount();
  updatestreakmeterui();
}

resetstreakavailability(_id_F72D8FE663D03827) {
  if(!isDefined(self)) {
    return;
  }
  for(_id_FB85F48630D3D4FF = 0; _id_FB85F48630D3D4FF <= 4; _id_FB85F48630D3D4FF++) {
    _id_16EFCF27E6EFCBE8 = self.streakdata.streaks[_id_FB85F48630D3D4FF];

    if(isDefined(_id_16EFCF27E6EFCBE8) && isDefined(_id_16EFCF27E6EFCBE8.streakname)) {
      if(istrue(_id_F72D8FE663D03827))
        _id_16EFCF27E6EFCBE8.available = 0;
      else if(istrue(_id_16EFCF27E6EFCBE8.isspecialist))
        _id_16EFCF27E6EFCBE8.available = 0;
      else if(_id_16EFCF27E6EFCBE8.available == -1)
        _id_16EFCF27E6EFCBE8.available = 0;

      _id_8D43CE79A3F2D876(_id_FB85F48630D3D4FF, _id_16EFCF27E6EFCBE8.available);
    }
  }
}

triggeravailablekillstreaks() {
  for(_id_FB85F48630D3D4FF = 1; _id_FB85F48630D3D4FF <= 4; _id_FB85F48630D3D4FF++) {
    _id_16EFCF27E6EFCBE8 = self.streakdata.streaks[_id_FB85F48630D3D4FF];

    if(isDefined(_id_16EFCF27E6EFCBE8) && istrue(_id_16EFCF27E6EFCBE8.available)) {
      streaksetupinfo = _id_16EFCF27E6EFCBE8.streaksetupinfo;

      if(isDefined(streaksetupinfo.availablefunc))
        self[[streaksetupinfo.availablefunc]](_id_16EFCF27E6EFCBE8);
    }
  }
}

setstreakpoints(value) {
  if(value < 0)
    value = 0;

  if(isDefined(self.streakpoints))
    self.previousstreakpoints = self.streakpoints;
  else
    self.previousstreakpoints = 0;

  self.streakpoints = value;
  updatestreakcount();
}

storescorestreakpointsongameend() {
  level waittill("game_ended");

  if(level.roundretainstreakprog) {
    foreach(player in level.players) {
      if(!isDefined(player)) {
        continue;
      }
      streakpoints = 0;

      if(isDefined(player.streakpoints)) {
        if(player scripts\mp\utility\perk::_hasperk("specialty_killstreak_to_scorestreak"))
          streakpoints = scripts\mp\perks\perkfunctions::killstreaktoscorestreak_scoretokill(player.streakpoints);
        else
          streakpoints = player.streakpoints;
      }

      player.pers["streakPoints"] = streakpoints;
    }
  }
}

findunobstructedfiringpointaroundz(player, targetposition, _id_90006566B6C97518, _id_F27ECC7100506085) {
  _id_8B51C1586012DCBC = rotatevector((0, 0, 1), (-1 * _id_F27ECC7100506085, 0, 0));
  _id_817E48ED98AD38C1 = vectortoangles(targetposition - player.origin);

  for(_id_681B749E48C151B8 = 0; _id_681B749E48C151B8 < 360; _id_681B749E48C151B8 = _id_681B749E48C151B8 + 30) {
    _id_FAE759765E65830A = _id_90006566B6C97518 * rotatevector(_id_8B51C1586012DCBC, (0, _id_681B749E48C151B8 + _id_817E48ED98AD38C1[1], 0));
    _id_81AA7E8BC8F8C030 = targetposition + _id_FAE759765E65830A;

    if(_findunobstructedfiringpointhelper(player, _id_81AA7E8BC8F8C030, targetposition))
      return _id_81AA7E8BC8F8C030;
  }

  return undefined;
}

findunobstructedfiringpointaroundy(player, targetposition, _id_90006566B6C97518, _id_DDB680F3984C4777, _id_A5337F8300110201, _id_C0FD4E75A105DEAE) {
  _id_817E48ED98AD38C1 = vectortoangles(player.origin - targetposition);

  for(_id_681B749E48C151B8 = _id_DDB680F3984C4777; _id_681B749E48C151B8 <= _id_A5337F8300110201; _id_681B749E48C151B8 = _id_681B749E48C151B8 + _id_C0FD4E75A105DEAE) {
    _id_8B51C1586012DCBC = rotatevector((1, 0, 0), (_id_681B749E48C151B8 - 90, 0, 0));
    _id_FAE759765E65830A = _id_90006566B6C97518 * rotatevector(_id_8B51C1586012DCBC, (0, _id_817E48ED98AD38C1[1], 0));
    _id_81AA7E8BC8F8C030 = targetposition + _id_FAE759765E65830A;

    if(_findunobstructedfiringpointhelper(player, _id_81AA7E8BC8F8C030, targetposition))
      return _id_81AA7E8BC8F8C030;
  }

  return undefined;
}

_findunobstructedfiringpointhelper(player, _id_81AA7E8BC8F8C030, targetposition) {
  _id_1F0571D36D0DF95B = scripts\engine\trace::_bullet_trace(_id_81AA7E8BC8F8C030, targetposition, 0);

  if(_id_1F0571D36D0DF95B["fraction"] > 0.99)
    return 1;

  return 0;
}

findunobstructedfiringpoint(player, targetposition, _id_90006566B6C97518) {
  result = findunobstructedfiringpointaroundz(player, targetposition, _id_90006566B6C97518, 30);

  if(!isDefined(result))
    result = findunobstructedfiringpointaroundy(player, targetposition, _id_90006566B6C97518, 15, 75, 15);

  return result;
}

killstreakhit(attacker, objweapon, vehicle, meansofdeath, damage) {
  if(isDefined(objweapon) && isPlayer(attacker) && isDefined(vehicle.owner) && isDefined(vehicle.owner.team)) {
    if(scripts\cp_mp\utility\player_utility::playersareenemies(attacker, vehicle.owner)) {
      vehicle updatescrapassistdata(attacker, damage);

      if(_id_2669878CF5A1B6BC::iskillstreakweapon(objweapon.basename)) {
        return;
      }
      _id_366B0ECC2F28AEAD = getcompleteweaponname(objweapon);

      if(!isDefined(attacker.lasthittime[_id_366B0ECC2F28AEAD]))
        attacker.lasthittime[_id_366B0ECC2F28AEAD] = 0;

      if(attacker.lasthittime[_id_366B0ECC2F28AEAD] == gettime()) {
        return;
      }
      attacker.lasthittime[_id_366B0ECC2F28AEAD] = gettime();
      attacker thread scripts\mp\gamelogic::threadedsetweaponstatbyname(_id_366B0ECC2F28AEAD, 1, "hits");

      if(scripts\mp\utility\game::onlinestatsenabled()) {
        _id_C1480A81B0387196 = attacker scripts\mp\playerstats_interface::getplayerstat("combatStats", "totalShots");
        hits = attacker scripts\mp\playerstats_interface::getplayerstat("combatStats", "hits") + 1;

        if(hits <= _id_C1480A81B0387196) {
          attacker scripts\mp\playerstats_interface::setplayerstatbuffered(hits, "combatStats", "hits");
          attacker scripts\mp\playerstats_interface::setplayerstatbuffered(int(_id_C1480A81B0387196 - hits), "combatStats", "misses");
        }
      }

      if(isDefined(meansofdeath) && scripts\engine\utility::isbulletdamage(meansofdeath) || scripts\mp\utility\damage::isprojectiledamage(meansofdeath)) {
        attacker.pers["lastDamageTime"] = gettime();
        _id_CF4209C200F8BBF4 = scripts\mp\utility\weapon::getweapongroup(objweapon.basename);

        if(_id_CF4209C200F8BBF4 == "weapon_lmg") {
          if(!isDefined(attacker.shotslandedlmg))
            attacker.shotslandedlmg = 1;
          else
            attacker.shotslandedlmg++;
        }
      }
    }
  }
}

updatescrapassistdataforcecredit(attacker) {
  updatescrapassistdata(attacker, 150);
}

updatescrapassistdata(attacker, damage) {
  if(!isDefined(attacker) || !isPlayer(attacker) || !isDefined(self)) {
    return;
  }
  if(!isDefined(self.scrapassistdamage))
    self.scrapassistdamage = [];

  playerid = attacker getxuid();
  attacker._id_73F7116F87A4FAB6 = 60;

  if(!isDefined(self.scrapassistdamage[playerid])) {
    _id_4768D89E31D241F9 = spawnStruct();
    _id_4768D89E31D241F9.damage = 0;
    _id_4768D89E31D241F9.player = attacker;
    self.scrapassistdamage[playerid] = _id_4768D89E31D241F9;
  }

  self.scrapassistdamage[playerid].damage = self.scrapassistdamage[playerid].damage + damage;
}

getscrapassistplayers(_id_6181DE250AFA5BB6) {
  if(!isDefined(self.scrapassistdamage))
    return [];

  _id_ABFD7751A2D536A5 = [];

  foreach(_id_4768D89E31D241F9 in self.scrapassistdamage) {
    damage = _id_4768D89E31D241F9.damage;
    player = _id_4768D89E31D241F9.player;

    if(damage < 150) {
      continue;
    }
    enemyteam = !scripts\mp\utility\player::isfriendly(self.team, player);
    _id_2220468158A65E1A = istrue(scripts\cp_mp\utility\player_utility::playersareenemies(player, self.owner));

    if(!enemyteam && !_id_2220468158A65E1A) {
      continue;
    }
    if(isDefined(_id_6181DE250AFA5BB6) && player == _id_6181DE250AFA5BB6) {
      continue;
    }
    _id_ABFD7751A2D536A5[_id_ABFD7751A2D536A5.size] = player;
  }

  return _id_ABFD7751A2D536A5;
}

givescoreforequipment(ent, objweapon) {
  if(isDefined(objweapon) && weaponclass(objweapon) != "rocketlauncher" && objweapon.basename != "iw8_la_kgolf_mp")
    objweapon = undefined;

  thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_521EDEBB385E3753", objweapon);
  scripts\cp_mp\gestures::processcalloutdeath(ent, self);
}

givescorefordestroyedtacinsert() {
  thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_36CF317C0354D831");
}

givescorefortrophyblocks() {
  thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_D21AFAD6E46CC26C");
}

givescoreforblackhat() {
  thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_E7221CBF95D38D3B");
}

givescoreforhack() {
  thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_2E07BBCC73ED19E8");
}

givescoreforempedvehicle() {
  thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_8256DF280C4762EB");
}

_id_7D84B8C1B826B7EA() {
  thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_17E023AE928D30A8");
}

givescoreforempedkillstreak() {
  thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_A16ADEAB187F115B");
}

givescoreforempedplayer() {
  thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_114723BE5AA01334");
}

givescoreformarktarget(_id_E7DA3C6F7A758F20) {
  if(_id_E7DA3C6F7A758F20)
    thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_DAF5C8199CB809AE");
  else
    thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_DAF5C8199CB809AE", undefined, 0);
}

givescorefordestorymarkedtarget() {
  thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_69B1469E70319F73");
}

givescoreforassistdestroymarkedtarget() {
  thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_69B1469E70319F73");
}

givescorefortriggeredalarmeddoor() {
  thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_C0185BB378FA348C");
}

streaktyperesetsondeath(streaktype) {
  switch (streaktype) {
    case "assault":
    case "specialist":
      return 1;
    case "support":
    case "resource":
      return 0;
    default:
      return 1;
  }
}

initridekillstreak(_id_153FDEE861E0F06F) {
  _id_3B64EB40368C1450::set("ride_killstreak", "usability", 0);
  result = initridekillstreak_internal(_id_153FDEE861E0F06F);

  if(isDefined(self))
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("ride_killstreak");

  return result;
}

initridekillstreak_internal(_id_153FDEE861E0F06F) {
  if(isDefined(_id_153FDEE861E0F06F) && islaptoptimeoutkillstreak(_id_153FDEE861E0F06F))
    _id_404E07BC8E36239C = "timeout";
  else
    _id_404E07BC8E36239C = scripts\engine\utility::waittill_any_timeout_3(1.0, "death", "disconnect", "weapon_switch_started");

  scripts\mp\hostmigration::waittillhostmigrationdone();

  if(_id_404E07BC8E36239C == "weapon_switch_started")
    return "fail";

  if(!isalive(self))
    return "fail";

  if(_id_404E07BC8E36239C == "disconnect" || _id_404E07BC8E36239C == "death") {
    if(_id_404E07BC8E36239C == "disconnect")
      return "disconnect";

    if(self.team == "spectator")
      return "fail";

    return "success";
  }

  if(scripts\mp\utility\game::iskillstreakdenied())
    return "fail";

  if(!isDefined(_id_153FDEE861E0F06F) || !issubstr(_id_153FDEE861E0F06F, "pointSelect")) {
    if(_id_153FDEE861E0F06F == "drone_hive") {
      self visionsetfadetoblackforplayer("black_bw", 0);
      thread scripts\mp\utility\player::set_visionset_for_watching_players("black_bw", 0, 1.0, undefined, 1);
      _id_841C93B52E081265 = scripts\engine\utility::waittill_any_timeout_1(0, "death_or_disconnect");
    } else {
      self visionsetfadetoblackforplayer("black_bw", 0.75);
      thread scripts\mp\utility\player::set_visionset_for_watching_players("black_bw", 0.75, 1.0, undefined, 1);
      _id_841C93B52E081265 = scripts\engine\utility::waittill_any_timeout_1(0.8, "death_or_disconnect");
    }
  } else
    _id_841C93B52E081265 = scripts\engine\utility::waittill_any_timeout_1(1.0, "death_or_disconnect");

  self notify("black_out_done");
  scripts\mp\hostmigration::waittillhostmigrationdone();

  if(_id_841C93B52E081265 != "disconnect") {
    if(!isDefined(_id_153FDEE861E0F06F) || !issubstr(_id_153FDEE861E0F06F, "pointSelect"))
      thread clearrideintro(1.0);
    else
      self notify("intro_cleared");

    if(self.team == "spectator")
      return "fail";
  }

  if(self isonladder())
    return "fail";

  if(!isalive(self))
    return "fail";

  if(scripts\mp\utility\game::iskillstreakdenied())
    return "fail";

  if(_id_841C93B52E081265 == "disconnect")
    return "disconnect";
  else
    return "success";
}

islaptoptimeoutkillstreak(_id_153FDEE861E0F06F) {
  switch (_id_153FDEE861E0F06F) {
    case "pointSelect":
    case "remote_uav":
    case "osprey_gunner":
    case "drone_hive":
    case "heli_pilot":
    case "remote_tank":
    case "precision_airstrike":
    case "gunship":
      return 1;
  }

  return 0;
}

clearrideintro(delay, _id_A2F1C07A77D7DF80) {
  self endon("disconnect");

  if(isDefined(delay))
    wait(delay);

  if(!isDefined(_id_A2F1C07A77D7DF80))
    _id_A2F1C07A77D7DF80 = 0;

  self visionsetfadetoblackforplayer("", _id_A2F1C07A77D7DF80);
  scripts\mp\utility\player::set_visionset_for_watching_players("", _id_A2F1C07A77D7DF80);
  self notify("intro_cleared");
}

allowridekillstreakplayerexit(_id_F275B3AFD12201BC, _id_43B83976503B9E6D) {
  if(isDefined(_id_F275B3AFD12201BC))
    self endon(_id_F275B3AFD12201BC);

  if(!isDefined(self.owner)) {
    return;
  }
  owner = self.owner;
  level endon("game_ended");
  owner endon("disconnect");
  owner endon("end_remote");
  self endon("death");

  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587()) {
    for(;;) {
      waitframe();

      if(owner useButtonPressed()) {
        self notify("killstreakExit");
        return;
      }
    }
  }

  holdtime = 0.75;

  if(isDefined(_id_43B83976503B9E6D))
    holdtime = _id_43B83976503B9E6D;

  _id_038FC7BD1495C4B2 = level.framedurationseconds;
  _id_6A16936225A5A8CE = 1;

  for(;;) {
    _id_23B90B34FECC58CD = 0;

    if(_id_6A16936225A5A8CE == 1) {
      owner setclientomnvar("ui_exit_progress", 0);
      _id_6A16936225A5A8CE = 0;
    }

    while(owner useButtonPressed()) {
      _id_23B90B34FECC58CD = _id_23B90B34FECC58CD + _id_038FC7BD1495C4B2;
      _id_6A16936225A5A8CE = 1;
      owner setclientomnvar("ui_exit_progress", _id_23B90B34FECC58CD / holdtime);

      if(_id_23B90B34FECC58CD > holdtime) {
        self notify("killstreakExit");
        return;
      }

      wait(_id_038FC7BD1495C4B2);
    }

    wait(_id_038FC7BD1495C4B2);
  }
}

combatrecordkillstreakuse(streakname) {
  if(!scripts\mp\utility\stats::canrecordcombatrecordstats()) {
    return;
  }
  _id_B326F2FC8716B6D8 = scripts\mp\utility\stats::getstreakrecordtype(streakname);

  if(!isDefined(_id_B326F2FC8716B6D8)) {
    if(streakname != "nuke" && streakname != "supply_sweep") {}

    return;
  }

  _id_7ABB90C7E07FF11B = self getplayerdata(level._id_5D69837CF4DB0407, "playerStats", _id_B326F2FC8716B6D8, streakname, "uses");
  self setplayerdata(level._id_5D69837CF4DB0407, "playerStats", _id_B326F2FC8716B6D8, streakname, "uses", _id_7ABB90C7E07FF11B + 1);
}

checkcasualstreaksreset() {
  if(!isDefined(self))
    return 0;

  if(self.streaktype != "specialist" && istrue(level._id_7DFAD9748480C388))
    return 0;

  if(isDefined(self.streakdata) && isDefined(self.streakdata.streaks) && self.streakdata.streaks.size > 0) {
    _id_162A97299AAB893D = self.streakdata.streaks[self.streakdata.streaks.size];

    if(isDefined(_id_162A97299AAB893D)) {
      _id_7CC9835F0C8A4EEE = isDefined(_id_162A97299AAB893D.available) && (_id_162A97299AAB893D.available == 1 || _id_162A97299AAB893D.available == -1);

      if(istrue(_id_7CC9835F0C8A4EEE)) {
        _id_31BA7F63C8ABF014 = _id_162A97299AAB893D.lifeid + 1 == self.pers["deaths"];

        if(istrue(_id_31BA7F63C8ABF014))
          return 1;
      }
    }
  }

  return 0;
}

loadassociatedkillstreakweapons(streakname) {
  _id_39EEDD8C85D59A0B = [];
  _id_8881166E57766E3A = scripts\cp_mp\utility\killstreak_utility::getkillstreakdeployweapon(streakname);
  _id_39EEDD8C85D59A0B[_id_39EEDD8C85D59A0B.size] = _id_8881166E57766E3A;
  _id_392880A8D9F01E28 = scripts\cp_mp\utility\killstreak_utility::getkillstreakgameweapons(streakname);
  _id_39EEDD8C85D59A0B = scripts\engine\utility::array_combine(_id_39EEDD8C85D59A0B, _id_392880A8D9F01E28);
  self loadweaponsforplayer(_id_39EEDD8C85D59A0B, 1);
}

combatrecordincrementkillstreakawardedstat(streakname) {
  if(!scripts\mp\utility\stats::canrecordcombatrecordstats()) {
    return;
  }
  _id_B326F2FC8716B6D8 = scripts\mp\utility\stats::getstreakrecordtype(streakname);

  if(!isDefined(_id_B326F2FC8716B6D8)) {
    return;
  }
  _id_7ABB90C7E07FF11B = self getplayerdata(level._id_5D69837CF4DB0407, "playerStats", _id_B326F2FC8716B6D8, streakname, "awardedCount");
  self setplayerdata(level._id_5D69837CF4DB0407, "playerStats", _id_B326F2FC8716B6D8, streakname, "awardedCount", _id_7ABB90C7E07FF11B + 1);
}

combatrecordincrementkillstreakextrastat(streakname) {
  if(!scripts\mp\utility\stats::canrecordcombatrecordstats()) {
    return;
  }
  _id_B326F2FC8716B6D8 = scripts\mp\utility\stats::getstreakrecordtype(streakname);

  if(!isDefined(_id_B326F2FC8716B6D8)) {
    return;
  }
  _id_7ABB90C7E07FF11B = self getplayerdata(level._id_5D69837CF4DB0407, "playerStats", _id_B326F2FC8716B6D8, streakname, "extraStat1");
  self setplayerdata(level._id_5D69837CF4DB0407, "playerStats", _id_B326F2FC8716B6D8, streakname, "extraStat1", _id_7ABB90C7E07FF11B + 1);
}

_id_29E99A60706E08B1() {
  level endon("game_ended");
  _id_7C15DD97287BEEEF = 240;
  _id_5FAAB0AFC3B30725 = 360;
  _id_87C79731F32EFC1E = 2;
  _id_64309F7F1E2E9563 = 300;

  if(isusingmatchrulesdata())
    setdvarifuninitialized("scr_killstreak_lottery", getmatchrulesdata("commonOption", "killstreakLottery"));
  else
    setdvarifuninitialized("scr_killstreak_lottery", 0);

  setdvarifuninitialized("dvar_6B62B5BF5E934E32", _id_7C15DD97287BEEEF);
  setdvarifuninitialized("dvar_6B3FBFBF5E6D1C78", _id_5FAAB0AFC3B30725);
  setdvarifuninitialized("dvar_6AB0E10E85AF33B4", _id_87C79731F32EFC1E);
  setdvarifuninitialized("scr_killstreak_lottery_cooldown", _id_64309F7F1E2E9563);
  scripts\mp\flags::gameflagwait("prematch_done");

  if(scripts\cp_mp\utility\game_utility::islargebrmap()) {
    return;
  }
  for(;;) {
    _id_79D58CAA88B7674F = getdvarint("scr_killstreak_lottery", 0);

    if(!istrue(_id_79D58CAA88B7674F)) {
      waitframe();
      continue;
    }

    _id_2165B440716FA7B7 = getdvarint("dvar_6B62B5BF5E934E32", _id_7C15DD97287BEEEF);
    _id_5BDEC923FC72018D = getdvarint("dvar_6B3FBFBF5E6D1C78", _id_5FAAB0AFC3B30725);
    _id_C6324960D12D197A = randomintrange(_id_2165B440716FA7B7, _id_5BDEC923FC72018D);
    wait(_id_C6324960D12D197A);

    if(!istrue(_id_79D58CAA88B7674F)) {
      continue;
    }
    _id_5F4B5D4938755DCB = [];

    foreach(player in level.players) {
      if(isDefined(player) && scripts\mp\utility\player::isreallyalive(player) && !isDefined(player._id_E73D59C16D88212B))
        _id_5F4B5D4938755DCB[_id_5F4B5D4938755DCB.size] = player;
    }

    if(_id_5F4B5D4938755DCB.size == 0) {
      continue;
    }
    _id_16F6338C00A23CC7 = getdvarint("dvar_6AB0E10E85AF33B4", 1);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_16F6338C00A23CC7; _id_AC0E594AC96AA3A8++) {
      _id_8DCEF6FA6B6A6EC5 = _id_5F4B5D4938755DCB[randomint(_id_5F4B5D4938755DCB.size)];
      _id_8DCEF6FA6B6A6EC5._id_E73D59C16D88212B = getdvarint("scr_killstreak_lottery_cooldown", _id_64309F7F1E2E9563);
      _id_8DCEF6FA6B6A6EC5 _id_7797C8D5DA974B60();
      _id_8DCEF6FA6B6A6EC5 thread _id_3FFEB63ACB58F504();
      _id_5F4B5D4938755DCB = scripts\engine\utility::array_remove(_id_5F4B5D4938755DCB, _id_8DCEF6FA6B6A6EC5);

      if(_id_5F4B5D4938755DCB.size == 0) {
        break;
      }
    }
  }
}

_id_7797C8D5DA974B60() {
  _id_2FEDFFDDC9BB99CA = getavailableequippedkillstreakstructs();
  _id_5E717900224771CA = [];

  foreach(_id_16EFCF27E6EFCBE8 in _id_2FEDFFDDC9BB99CA)
  _id_5E717900224771CA[_id_5E717900224771CA.size] = _id_16EFCF27E6EFCBE8.streakname;

  if(getdvarint("dvar_B6B7B2946CADB46A", 0)) {
    _id_6008218821136B8D = ["assault_drone", "uav", "cluster_spike", "scrambler_drone_guard"];

    foreach(_id_51BE34C178F12EF4 in _id_6008218821136B8D) {
      if(!scripts\engine\utility::array_contains(_id_5E717900224771CA, _id_51BE34C178F12EF4))
        _id_5E717900224771CA[_id_5E717900224771CA.size] = _id_51BE34C178F12EF4;
    }
  }

  _id_EDC5F3CCA53740B3 = scripts\cp_mp\killstreaks\airdrop::getrandomkillstreak(_id_5E717900224771CA);
  awardkillstreak(_id_EDC5F3CCA53740B3, "other");
  scripts\mp\hud_message::showkillstreaksplash(_id_EDC5F3CCA53740B3);
}

_id_3FFEB63ACB58F504() {
  self endon("disconnect");
  wait(self._id_E73D59C16D88212B);
  self._id_E73D59C16D88212B = undefined;
}