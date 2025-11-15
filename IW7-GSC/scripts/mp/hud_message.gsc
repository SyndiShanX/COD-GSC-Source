/**************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\hud_message.gsc
**************************************/

init() {
  game["round_end"]["draw"] = 1;
  game["round_end"]["round_draw"] = 2;
  game["round_end"]["round_win"] = 3;
  game["round_end"]["round_loss"] = 4;
  game["round_end"]["victory"] = 5;
  game["round_end"]["defeat"] = 6;
  game["round_end"]["halftime"] = 7;
  game["round_end"]["overtime"] = 8;
  game["round_end"]["roundend"] = 9;
  game["round_end"]["intermission"] = 10;
  game["round_end"]["side_switch"] = 11;
  game["round_end"]["match_bonus"] = 12;
  game["round_end"]["tie"] = 13;
  game["round_end"]["spectator"] = 14;
  game["round_end"]["final_round"] = 15;
  game["round_end"]["match_point"] = 16;
  game["end_reason"]["score_limit_reached"] = 1;
  game["end_reason"]["time_limit_reached"] = 2;
  game["end_reason"]["players_forfeited"] = 3;
  game["end_reason"]["target_destroyed"] = 4;
  game["end_reason"]["bomb_defused"] = 5;
  game["end_reason"]["allies_eliminated"] = 6;
  game["end_reason"]["axis_eliminated"] = 7;
  game["end_reason"]["allies_forfeited"] = 8;
  game["end_reason"]["axis_forfeited"] = 9;
  game["end_reason"]["enemies_eliminated"] = 10;
  game["end_reason"]["tie"] = 11;
  game["end_reason"]["objective_completed"] = 12;
  game["end_reason"]["objective_failed"] = 13;
  game["end_reason"]["switching_sides"] = 14;
  game["end_reason"]["round_limit_reached"] = 15;
  game["end_reason"]["ended_game"] = 16;
  game["end_reason"]["host_ended_game"] = 17;
  game["end_reason"]["loss_stat_prevented"] = 18;
  game["end_reason"]["time_to_beat_ctf_win"] = 19;
  game["end_reason"]["time_to_beat_ctf_loss"] = 20;
  game["end_reason"]["time_to_beat_uplink_win"] = 21;
  game["end_reason"]["time_to_beat_uplink_loss"] = 22;
  game["end_reason"]["nuke_end"] = 23;
  game["strings"]["overtime"] = & "MP_OVERTIME";
  level thread onplayerconnect();
  level.showerrormessagefunc = ::showerrormessage;
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_00);
    var_00 thread lowermessagethink();
    var_00 thread splashshownthink();
    var_00 thread func_68B8();
  }
}

showkillstreaksplash(param_00, param_01, param_02) {
  if(!isplayer(self)) {
    return;
  }

  var_03 = undefined;
  if(scripts\mp\utility::istrue(param_02)) {
    var_03 = 1;
  }

  showsplash(param_00, param_01, undefined, var_03);
}

showsplash(param_00, param_01, param_02, param_03) {
  var_04 = undefined;
  if(isDefined(param_02)) {
    var_04 = param_02 getentitynumber();
  }

  if(isDefined(self.recentsplashcount) && self.recentsplashcount >= 6) {
    queuesplash(param_00, param_01, param_02, var_04, param_03);
    return;
  }

  if(!scripts\mp\utility::isreallyalive(self) && !self ismlgspectator()) {
    queuesplash(param_00, param_01, param_02, var_04, param_03);
    return;
  }

  showsplashinternal(param_00, param_01, param_02, var_04, param_03);
}

showsplashinternal(param_00, param_01, param_02, param_03, param_04) {
  if(!isplayer(self)) {
    return;
  }

  if(isDefined(param_03)) {
    if(!isDefined(param_02)) {
      return;
    }
  }

  var_05 = tablelookuprownum(getsplashtablename(), 0, param_00);
  if(!isDefined(var_05) || var_05 < 0) {
    return;
  }

  if(!isDefined(self.nextsplashlistindex)) {
    self.nextsplashlistindex = 0;
  }

  if(!isDefined(self.splashlisttoggle)) {
    self.splashlisttoggle = 1;
  }

  var_06 = var_05;
  if(self.splashlisttoggle) {
    var_06 = var_06 | 2048;
  }

  if(isDefined(param_01)) {
    self setclientomnvar("ui_player_splash_param_" + self.nextsplashlistindex, param_01);
  } else {
    self setclientomnvar("ui_player_splash_param_" + self.nextsplashlistindex, -1);
  }

  if(isDefined(param_03)) {
    self setclientomnvar("ui_player_splash_cardClientId_" + self.nextsplashlistindex, param_03);
  } else {
    self setclientomnvar("ui_player_splash_cardClientId_" + self.nextsplashlistindex, -1);
  }

  if(isDefined(param_04)) {
    self setclientomnvar("ui_player_splash_use_alt_" + self.nextsplashlistindex, param_04);
  } else {
    self setclientomnvar("ui_player_splash_use_alt_" + self.nextsplashlistindex, 0);
  }

  self setclientomnvar("ui_player_splashfunc_" + self.nextsplashlistindex, var_06);
  if(!isDefined(self.recentsplashcount)) {
    self.recentsplashcount = 1;
  } else {
    self.recentsplashcount++;
  }

  thread cleanuplocalplayersplashlist();
  self.nextsplashlistindex++;
  if(self.nextsplashlistindex >= 6) {
    self.nextsplashlistindex = 0;
    self.splashlisttoggle = !self.splashlisttoggle;
  }
}

queuesplash(param_00, param_01, param_02, param_03, param_04) {
  var_05 = spawnStruct();
  var_05.ref = param_00;
  var_05.optionalnumber = param_01;
  var_05.playerforplayercard = param_02;
  var_05.playernumforplayercard = param_03;
  var_05.altdisplayindex = param_04;
  if(!isDefined(self.splashqueuehead)) {
    self.splashqueuehead = var_05;
    self.splashqueuetail = var_05;
    thread handlesplashqueue();
    return;
  }

  var_06 = self.splashqueuetail;
  var_06.nextsplash = var_05;
  self.splashqueuetail = var_05;
}

handlesplashqueue() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  while(isDefined(self.splashqueuehead)) {
    scripts\engine\utility::waittill_any_3("splash_list_cleared", "spawned_player");
    for(var_00 = 0; var_00 < 6; var_00++) {
      var_01 = self.splashqueuehead;
      showsplashinternal(var_01.ref, var_01.optionalnumber, var_01.playerforplayercard, var_01.playernumforplayercard, var_01.altdisplayindex);
      self.splashqueuehead = var_01.nextsplash;
      if(!isDefined(self.splashqueuehead)) {
        break;
      }
    }
  }

  self.splashqueuetail = undefined;
}

lowermessagethink() {
  self endon("disconnect");
  self.lowermessages = [];
  var_00 = "default";
  if(isDefined(level.lowermessagefont)) {
    var_00 = level.lowermessagefont;
  }

  var_01 = level.lowertexty;
  var_02 = level.lowertextfontsize;
  var_03 = 1.25;
  if(level.splitscreen || self issplitscreenplayer() && !isai(self)) {
    var_01 = var_01 - 40;
    var_02 = level.lowertextfontsize * 1.3;
    var_03 = var_03 * 1.5;
  }

  self.lowermessage = scripts\mp\hud_util::createfontstring(var_00, var_02);
  self.lowermessage settext("");
  self.lowermessage.archived = 0;
  self.lowermessage.sort = 10;
  self.lowermessage.showinkillcam = 0;
  self.lowermessage scripts\mp\hud_util::setpoint("CENTER", level.lowertextyalign, 0, var_01);
  self.lowertimer = scripts\mp\hud_util::createfontstring("default", var_03);
  self.lowertimer scripts\mp\hud_util::setparent(self.lowermessage);
  self.lowertimer scripts\mp\hud_util::setpoint("TOP", "BOTTOM", 0, 0);
  self.lowertimer settext("");
  self.lowertimer.archived = 0;
  self.lowertimer.sort = 10;
  self.lowertimer.showinkillcam = 0;
}

isdoingsplash() {
  return 0;
}

teamoutcomenotify(param_00, param_01, param_02) {
  self endon("disconnect");
  var_03 = self.pers["team"];
  if(self ismlgspectator()) {
    var_03 = self getmlgspectatorteam();
  }

  if(!isDefined(var_03) || var_03 != "allies" && var_03 != "axis") {
    var_03 = "allies";
  }

  if(param_00 == "halftime") {
    self setclientomnvar("ui_round_end_title", game["round_end"]["halftime"]);
    param_00 = "allies";
  } else if(param_00 == "intermission") {
    self setclientomnvar("ui_round_end_title", game["round_end"]["intermission"]);
    param_00 = "allies";
  } else if(param_00 == "roundend") {
    self setclientomnvar("ui_round_end_title", game["round_end"]["roundend"]);
    param_00 = "allies";
  } else if(param_00 == "overtime") {
    if(scripts\mp\utility::iswinbytworulegametype() && game["teamScores"]["allies"] != game["teamScores"]["axis"]) {
      self setclientomnvar("ui_round_end_title", game["round_end"]["match_point"]);
    } else {
      self setclientomnvar("ui_round_end_title", game["round_end"]["overtime"]);
    }

    param_00 = "allies";
  } else if(param_00 == "finalround") {
    self setclientomnvar("ui_round_end_title", game["round_end"]["final_round"]);
    param_00 = "allies";
  } else if(param_00 == "tie") {
    if(param_01 && !scripts\mp\utility::waslastround()) {
      self setclientomnvar("ui_round_end_title", game["round_end"]["round_draw"]);
    } else {
      self setclientomnvar("ui_round_end_title", game["round_end"]["draw"]);
    }

    param_00 = "allies";
  } else if(self ismlgspectator()) {
    self setclientomnvar("ui_round_end_title", game["round_end"]["spectator"]);
  } else if(isDefined(self.pers["team"]) && param_00 == var_03) {
    if(param_01 && !scripts\mp\utility::waslastround()) {
      self setclientomnvar("ui_round_end_title", game["round_end"]["round_win"]);
    } else {
      self setclientomnvar("ui_round_end_title", game["round_end"]["victory"]);
    }
  } else if(param_01 && !scripts\mp\utility::waslastround()) {
    self setclientomnvar("ui_round_end_title", game["round_end"]["round_loss"]);
  } else {
    self setclientomnvar("ui_round_end_title", game["round_end"]["defeat"]);
    if(scripts\mp\utility::istrue(self.joinedinprogress) && scripts\mp\utility::rankingenabled()) {
      param_02 = game["end_reason"]["loss_stat_prevented"];
    }
  }

  if(scripts\mp\utility::inovertime() && scripts\mp\utility::waslastround() && scripts\mp\utility::istimetobeatrulegametype()) {
    if(level.gametype == "ctf") {
      if(isDefined(self.pers["team"]) && param_00 == var_03) {
        param_02 = game["end_reason"]["time_to_beat_ctf_win"];
      } else if(isDefined(self.pers["team"]) && param_00 == level.otherteam[self.pers["team"]]) {
        param_02 = game["end_reason"]["time_to_beat_ctf_loss"];
      }
    } else if(level.gametype == "ball") {
      if(isDefined(self.pers["team"]) && param_00 == var_03) {
        param_02 = game["end_reason"]["time_to_beat_uplink_win"];
      } else if(isDefined(self.pers["team"]) && param_00 == level.otherteam[self.pers["team"]]) {
        param_02 = game["end_reason"]["time_to_beat_uplink_loss"];
      }
    }
  }

  self setclientomnvar("ui_round_end_reason", param_02);
  if(!scripts\mp\utility::isroundbased() || !scripts\mp\utility::isobjectivebased() || scripts\mp\utility::ismoddedroundgame()) {
    self setclientomnvar("ui_round_end_friendly_score", scripts\mp\gamescore::_getteamscore(var_03));
    self setclientomnvar("ui_round_end_enemy_score", scripts\mp\gamescore::_getteamscore(level.otherteam[var_03]));
  } else {
    self setclientomnvar("ui_round_end_friendly_score", game["roundsWon"][var_03]);
    self setclientomnvar("ui_round_end_enemy_score", game["roundsWon"][level.otherteam[var_03]]);
  }

  if(isDefined(self.var_B3DD)) {
    self setclientomnvar("ui_round_end_match_bonus", self.var_B3DD);
  }
}

func_C752(param_00, param_01) {
  self endon("disconnect");
  var_02 = level.placement["all"];
  var_03 = var_02[0];
  var_04 = var_02[1];
  var_05 = var_02[2];
  if(isstring(param_00) && param_00 == "tie") {
    if((isDefined(var_03) && self == var_03) || isDefined(var_04) && self == var_04 || isDefined(var_05) && self == var_05) {
      self setclientomnvar("ui_round_end_title", game["round_end"]["tie"]);
    } else {
      self setclientomnvar("ui_round_end_title", game["round_end"]["defeat"]);
    }
  } else if((isDefined(var_03) && self == var_03) || isDefined(var_04) && self == var_04 || isDefined(var_05) && self == var_05) {
    self setclientomnvar("ui_round_end_title", game["round_end"]["victory"]);
  } else {
    self setclientomnvar("ui_round_end_title", game["round_end"]["defeat"]);
    if(scripts\mp\utility::istrue(self.joinedinprogress) && scripts\mp\utility::rankingenabled()) {
      param_01 = game["end_reason"]["loss_stat_prevented"];
    }
  }

  self setclientomnvar("ui_round_end_reason", param_01);
  if(isDefined(self.var_B3DD)) {
    self setclientomnvar("ui_round_end_match_bonus", self.var_B3DD);
  }
}

getsplashtablename() {
  return "mp\splashTable.csv";
}

getsplashtablemaxaltdisplays() {
  return 5;
}

cleanuplocalplayersplashlist() {
  self endon("disconnect");
  self notify("cleanupLocalPlayerSplashList()");
  self endon("cleanupLocalPlayerSplashList()");
  scripts\engine\utility::waittill_notify_or_timeout("death", 0.5);
  while(!scripts\mp\utility::isreallyalive(self) && !self ismlgspectator()) {
    wait(0.15);
  }

  self.recentsplashcount = undefined;
  self notify("splash_list_cleared");
}

splashshownthink() {
  self endon("disconnect");
  for(;;) {
    self waittill("luinotifyserver", var_00, var_01);
    if(var_00 != "splash_shown") {
      continue;
    }

    var_02 = tablelookupbyrow(getsplashtablename(), var_01, 0);
    var_03 = tablelookupbyrow(getsplashtablename(), var_01, 5);
    switch (var_03) {
      case "killstreak_splash":
        onkillstreaksplashshown(var_02);
        break;
    }
  }
}

onkillstreaksplashshown(param_00) {
  scripts\mp\utility::playkillstreakdialogonplayer(param_00, "killstreak_earned", 1);
}

showerrormessage(param_00, param_01) {
  var_02 = tablelookuprownum("mp\errorMessages.csv", 0, param_00);
  if(isDefined(param_01)) {
    self setclientomnvar("ui_mp_error_message_param", param_01);
  } else {
    self setclientomnvar("ui_mp_error_message_param", -1);
  }

  self setclientomnvar("ui_mp_error_message_id", var_02);
  if(!isDefined(self.errormessagebitflipper)) {
    self.errormessagebitflipper = 0;
  }

  self.errormessagebitflipper = !self.errormessagebitflipper;
  self setclientomnvar("ui_mp_error_trigger", scripts\engine\utility::ter_op(self.errormessagebitflipper, 2, 1));
}

showerrormessagetoallplayers(param_00, param_01) {
  foreach(var_03 in level.players) {
    showerrormessage(param_00, param_01);
  }
}

testmiscmessage(param_00) {
  var_01 = tablelookuprownum("mp\miscMessages.csv", 0, param_00);
  if(isDefined(var_01) && var_01 >= 0) {
    return 1;
  }

  return 0;
}

showmiscmessage(param_00) {
  var_01 = tablelookuprownum("mp\miscMessages.csv", 0, param_00);
  var_02 = tablelookupbyrow("mp\miscMessages.csv", var_01, 3);
  if(isDefined(var_02) && var_02 != "") {
    self playlocalsound(var_02);
  }

  self setclientomnvar("ui_misc_message_id", var_01);
  self setclientomnvar("ui_misc_message_trigger", 1);
}

func_68B8() {
  self endon("disconnect");
  self waittill("spawned_player");
  wait(5);
  if(!isDefined(self)) {
    return;
  }

  if(!scripts\mp\utility::matchmakinggame()) {
    return;
  }

  var_00 = self _meth_85BE() > 1;
  if(getdvarint("online_mp_xpscale") == 2 || var_00 && getdvarint("online_mp_party_xpscale") == 2) {
    showsplash("event_double_xp");
  }

  if(getdvarint("online_mp_weapon_xpscale") == 2 || var_00 && getdvarint("online_mp_party_weapon_xpscale") == 2) {
    showsplash("event_double_weapon_xp");
  }

  if(getdvarint("online_double_keys") > 0) {
    showsplash("event_double_keys");
  }

  if(getdvarint("online_mp_missionteam_xpscale") == 2 || var_00 && getdvarint("online_mp_party_missionteam_xpscale") == 2) {
    showsplash("event_double_xp_teams");
  }
}