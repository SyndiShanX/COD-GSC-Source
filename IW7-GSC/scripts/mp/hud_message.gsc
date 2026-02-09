/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\hud_message.gsc
*********************************************/

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
  game["strings"]["overtime"] = &"MP_OVERTIME";
  level thread onplayerconnect();
  level.showerrormessagefunc = ::showerrormessage;
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread lowermessagethink();
    var_0 thread splashshownthink();
    var_0 thread func_68B8();
  }
}

showkillstreaksplash(var_0, var_1, var_2) {
  if(!isPlayer(self)) {
    return;
  }

  var_3 = undefined;
  if(scripts\mp\utility::istrue(var_2)) {
    var_3 = 1;
  }

  showsplash(var_0, var_1, undefined, var_3);
}

showsplash(var_0, var_1, var_2, var_3) {
  var_4 = undefined;
  if(isDefined(var_2)) {
    var_4 = var_2 getentitynumber();
  }

  if(isDefined(self.recentsplashcount) && self.recentsplashcount >= 6) {
    queuesplash(var_0, var_1, var_2, var_4, var_3);
    return;
  }

  if(!scripts\mp\utility::isreallyalive(self) && !self ismlgspectator()) {
    queuesplash(var_0, var_1, var_2, var_4, var_3);
    return;
  }

  showsplashinternal(var_0, var_1, var_2, var_4, var_3);
}

showsplashinternal(var_0, var_1, var_2, var_3, var_4) {
  if(!isPlayer(self)) {
    return;
  }

  if(isDefined(var_3)) {
    if(!isDefined(var_2)) {
      return;
    }
  }

  var_5 = tablelookuprownum(getsplashtablename(), 0, var_0);
  if(!isDefined(var_5) || var_5 < 0) {
    return;
  }

  if(!isDefined(self.nextsplashlistindex)) {
    self.nextsplashlistindex = 0;
  }

  if(!isDefined(self.splashlisttoggle)) {
    self.splashlisttoggle = 1;
  }

  var_6 = var_5;
  if(self.splashlisttoggle) {
    var_6 = var_6 | 2048;
  }

  if(isDefined(var_1)) {
    self setclientomnvar("ui_player_splash_param_" + self.nextsplashlistindex, var_1);
  } else {
    self setclientomnvar("ui_player_splash_param_" + self.nextsplashlistindex, -1);
  }

  if(isDefined(var_3)) {
    self setclientomnvar("ui_player_splash_cardClientId_" + self.nextsplashlistindex, var_3);
  } else {
    self setclientomnvar("ui_player_splash_cardClientId_" + self.nextsplashlistindex, -1);
  }

  if(isDefined(var_4)) {
    self setclientomnvar("ui_player_splash_use_alt_" + self.nextsplashlistindex, var_4);
  } else {
    self setclientomnvar("ui_player_splash_use_alt_" + self.nextsplashlistindex, 0);
  }

  self setclientomnvar("ui_player_splashfunc_" + self.nextsplashlistindex, var_6);
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

queuesplash(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_5.ref = var_0;
  var_5.optionalnumber = var_1;
  var_5.playerforplayercard = var_2;
  var_5.playernumforplayercard = var_3;
  var_5.altdisplayindex = var_4;
  if(!isDefined(self.splashqueuehead)) {
    self.splashqueuehead = var_5;
    self.splashqueuetail = var_5;
    thread handlesplashqueue();
    return;
  }

  var_6 = self.splashqueuetail;
  var_6.nextsplash = var_5;
  self.splashqueuetail = var_5;
}

handlesplashqueue() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  while(isDefined(self.splashqueuehead)) {
    scripts\engine\utility::waittill_any("splash_list_cleared", "spawned_player");
    for(var_0 = 0; var_0 < 6; var_0++) {
      var_1 = self.splashqueuehead;
      showsplashinternal(var_1.ref, var_1.optionalnumber, var_1.playerforplayercard, var_1.playernumforplayercard, var_1.altdisplayindex);
      self.splashqueuehead = var_1.nextsplash;
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
  var_0 = "default";
  if(isDefined(level.lowermessagefont)) {
    var_0 = level.lowermessagefont;
  }

  var_1 = level.lowertexty;
  var_2 = level.lowertextfontsize;
  var_3 = 1.25;
  if(level.splitscreen || self issplitscreenplayer() && !isai(self)) {
    var_1 = var_1 - 40;
    var_2 = level.lowertextfontsize * 1.3;
    var_3 = var_3 * 1.5;
  }

  self.lowermessage = scripts\mp\hud_util::createfontstring(var_0, var_2);
  self.lowermessage settext("");
  self.lowermessage.archived = 0;
  self.lowermessage.sort = 10;
  self.lowermessage.showinkillcam = 0;
  self.lowermessage scripts\mp\hud_util::setpoint("CENTER", level.lowertextyalign, 0, var_1);
  self.lowertimer = scripts\mp\hud_util::createfontstring("default", var_3);
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

teamoutcomenotify(var_0, var_1, var_2) {
  self endon("disconnect");
  var_3 = self.pers["team"];
  if(self ismlgspectator()) {
    var_3 = self getmlgspectatorteam();
  }

  if(!isDefined(var_3) || var_3 != "allies" && var_3 != "axis") {
    var_3 = "allies";
  }

  if(var_0 == "halftime") {
    self setclientomnvar("ui_round_end_title", game["round_end"]["halftime"]);
    var_0 = "allies";
  } else if(var_0 == "intermission") {
    self setclientomnvar("ui_round_end_title", game["round_end"]["intermission"]);
    var_0 = "allies";
  } else if(var_0 == "roundend") {
    self setclientomnvar("ui_round_end_title", game["round_end"]["roundend"]);
    var_0 = "allies";
  } else if(var_0 == "overtime") {
    if(scripts\mp\utility::iswinbytworulegametype() && game["teamScores"]["allies"] != game["teamScores"]["axis"]) {
      self setclientomnvar("ui_round_end_title", game["round_end"]["match_point"]);
    } else {
      self setclientomnvar("ui_round_end_title", game["round_end"]["overtime"]);
    }

    var_0 = "allies";
  } else if(var_0 == "finalround") {
    self setclientomnvar("ui_round_end_title", game["round_end"]["final_round"]);
    var_0 = "allies";
  } else if(var_0 == "tie") {
    if(var_1 && !scripts\mp\utility::waslastround()) {
      self setclientomnvar("ui_round_end_title", game["round_end"]["round_draw"]);
    } else {
      self setclientomnvar("ui_round_end_title", game["round_end"]["draw"]);
    }

    var_0 = "allies";
  } else if(self ismlgspectator()) {
    self setclientomnvar("ui_round_end_title", game["round_end"]["spectator"]);
  } else if(isDefined(self.pers["team"]) && var_0 == var_3) {
    if(var_1 && !scripts\mp\utility::waslastround()) {
      self setclientomnvar("ui_round_end_title", game["round_end"]["round_win"]);
    } else {
      self setclientomnvar("ui_round_end_title", game["round_end"]["victory"]);
    }
  } else if(var_1 && !scripts\mp\utility::waslastround()) {
    self setclientomnvar("ui_round_end_title", game["round_end"]["round_loss"]);
  } else {
    self setclientomnvar("ui_round_end_title", game["round_end"]["defeat"]);
    if(scripts\mp\utility::istrue(self.joinedinprogress) && scripts\mp\utility::rankingenabled()) {
      var_2 = game["end_reason"]["loss_stat_prevented"];
    }
  }

  if(scripts\mp\utility::inovertime() && scripts\mp\utility::waslastround() && scripts\mp\utility::istimetobeatrulegametype()) {
    if(level.gametype == "ctf") {
      if(isDefined(self.pers["team"]) && var_0 == var_3) {
        var_2 = game["end_reason"]["time_to_beat_ctf_win"];
      } else if(isDefined(self.pers["team"]) && var_0 == level.otherteam[self.pers["team"]]) {
        var_2 = game["end_reason"]["time_to_beat_ctf_loss"];
      }
    } else if(level.gametype == "ball") {
      if(isDefined(self.pers["team"]) && var_0 == var_3) {
        var_2 = game["end_reason"]["time_to_beat_uplink_win"];
      } else if(isDefined(self.pers["team"]) && var_0 == level.otherteam[self.pers["team"]]) {
        var_2 = game["end_reason"]["time_to_beat_uplink_loss"];
      }
    }
  }

  self setclientomnvar("ui_round_end_reason", var_2);
  if(!scripts\mp\utility::isroundbased() || !scripts\mp\utility::isobjectivebased() || scripts\mp\utility::ismoddedroundgame()) {
    self setclientomnvar("ui_round_end_friendly_score", scripts\mp\gamescore::_getteamscore(var_3));
    self setclientomnvar("ui_round_end_enemy_score", scripts\mp\gamescore::_getteamscore(level.otherteam[var_3]));
  } else {
    self setclientomnvar("ui_round_end_friendly_score", game["roundsWon"][var_3]);
    self setclientomnvar("ui_round_end_enemy_score", game["roundsWon"][level.otherteam[var_3]]);
  }

  if(isDefined(self.var_B3DD)) {
    self setclientomnvar("ui_round_end_match_bonus", self.var_B3DD);
  }
}

func_C752(var_0, var_1) {
  self endon("disconnect");
  var_2 = level.placement["all"];
  var_3 = var_2[0];
  var_4 = var_2[1];
  var_5 = var_2[2];
  if(isstring(var_0) && var_0 == "tie") {
    if((isDefined(var_3) && self == var_3) || isDefined(var_4) && self == var_4 || isDefined(var_5) && self == var_5) {
      self setclientomnvar("ui_round_end_title", game["round_end"]["tie"]);
    } else {
      self setclientomnvar("ui_round_end_title", game["round_end"]["defeat"]);
    }
  } else if((isDefined(var_3) && self == var_3) || isDefined(var_4) && self == var_4 || isDefined(var_5) && self == var_5) {
    self setclientomnvar("ui_round_end_title", game["round_end"]["victory"]);
  } else {
    self setclientomnvar("ui_round_end_title", game["round_end"]["defeat"]);
    if(scripts\mp\utility::istrue(self.joinedinprogress) && scripts\mp\utility::rankingenabled()) {
      var_1 = game["end_reason"]["loss_stat_prevented"];
    }
  }

  self setclientomnvar("ui_round_end_reason", var_1);
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
    self waittill("luinotifyserver", var_0, var_1);
    if(var_0 != "splash_shown") {
      continue;
    }

    var_2 = tablelookupbyrow(getsplashtablename(), var_1, 0);
    var_3 = tablelookupbyrow(getsplashtablename(), var_1, 5);
    switch (var_3) {
      case "killstreak_splash":
        onkillstreaksplashshown(var_2);
        break;
    }
  }
}

onkillstreaksplashshown(var_0) {
  scripts\mp\utility::playkillstreakdialogonplayer(var_0, "killstreak_earned", 1);
}

showerrormessage(var_0, var_1) {
  var_2 = tablelookuprownum("mp\errorMessages.csv", 0, var_0);
  if(isDefined(var_1)) {
    self setclientomnvar("ui_mp_error_message_param", var_1);
  } else {
    self setclientomnvar("ui_mp_error_message_param", -1);
  }

  self setclientomnvar("ui_mp_error_message_id", var_2);
  if(!isDefined(self.errormessagebitflipper)) {
    self.errormessagebitflipper = 0;
  }

  self.errormessagebitflipper = !self.errormessagebitflipper;
  self setclientomnvar("ui_mp_error_trigger", scripts\engine\utility::ter_op(self.errormessagebitflipper, 2, 1));
}

showerrormessagetoallplayers(var_0, var_1) {
  foreach(var_3 in level.players) {
    showerrormessage(var_0, var_1);
  }
}

testmiscmessage(var_0) {
  var_1 = tablelookuprownum("mp\miscMessages.csv", 0, var_0);
  if(isDefined(var_1) && var_1 >= 0) {
    return 1;
  }

  return 0;
}

showmiscmessage(var_0) {
  var_1 = tablelookuprownum("mp\miscMessages.csv", 0, var_0);
  var_2 = tablelookupbyrow("mp\miscMessages.csv", var_1, 3);
  if(isDefined(var_2) && var_2 != "") {
    self playlocalsound(var_2);
  }

  self setclientomnvar("ui_misc_message_id", var_1);
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

  var_0 = self func_85BE() > 1;
  if(getdvarint("online_mp_xpscale") == 2 || var_0 && getdvarint("online_mp_party_xpscale") == 2) {
    showsplash("event_double_xp");
  }

  if(getdvarint("online_mp_weapon_xpscale") == 2 || var_0 && getdvarint("online_mp_party_weapon_xpscale") == 2) {
    showsplash("event_double_weapon_xp");
  }

  if(getdvarint("online_double_keys") > 0) {
    showsplash("event_double_keys");
  }

  if(getdvarint("online_mp_missionteam_xpscale") == 2 || var_0 && getdvarint("online_mp_party_missionteam_xpscale") == 2) {
    showsplash("event_double_xp_teams");
  }
}