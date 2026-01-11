/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2752.gsc
***************************************/

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
    level waittill("connected", var_00);
    var_00 thread lowermessagethink();
    var_00 thread splashshownthink();
    var_00 thread func_68B8();
  }
}

showkillstreaksplash(var_00, var_01, var_02) {
  if(!isplayer(self)) {
    return;
  }
  var_03 = undefined;

  if(scripts\mp\utility\game::istrue(var_02)) {
    var_03 = 1;
  }

  showsplash(var_00, var_01, undefined, var_03);
}

showsplash(var_00, var_01, var_02, var_03) {
  var_04 = undefined;

  if(isDefined(var_02)) {
    var_04 = var_02 getentitynumber();
  }

  if(isDefined(self.recentsplashcount) && self.recentsplashcount >= 6) {
    queuesplash(var_00, var_01, var_02, var_04, var_03);
    return;
  }

  if(!scripts\mp\utility\game::isreallyalive(self) && !self ismlgspectator()) {
    queuesplash(var_00, var_01, var_02, var_04, var_03);
    return;
  }

  showsplashinternal(var_00, var_01, var_02, var_04, var_03);
}

showsplashinternal(var_00, var_01, var_02, var_03, var_04) {
  if(!isplayer(self)) {
    return;
  }
  if(isDefined(var_03)) {
    if(!isDefined(var_02)) {
      return;
    }
  }

  var_05 = tablelookuprownum(getsplashtablename(), 0, var_00);

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

  if(isDefined(var_01)) {
    self setclientomnvar("ui_player_splash_param_" + self.nextsplashlistindex, var_01);
  }
  else {
    self setclientomnvar("ui_player_splash_param_" + self.nextsplashlistindex, -1);
  }

  if(isDefined(var_03)) {
    self setclientomnvar("ui_player_splash_cardClientId_" + self.nextsplashlistindex, var_03);
  }
  else {
    self setclientomnvar("ui_player_splash_cardClientId_" + self.nextsplashlistindex, -1);
  }

  if(isDefined(var_04)) {
    self setclientomnvar("ui_player_splash_use_alt_" + self.nextsplashlistindex, var_04);
  }
  else {
    self setclientomnvar("ui_player_splash_use_alt_" + self.nextsplashlistindex, 0);
  }

  self setclientomnvar("ui_player_splashfunc_" + self.nextsplashlistindex, var_06);

  if(!isDefined(self.recentsplashcount)) {
    self.recentsplashcount = 1;
  }
  else {
    self.recentsplashcount++;
  }

  thread cleanuplocalplayersplashlist();
  self.nextsplashlistindex++;

  if(self.nextsplashlistindex >= 6) {
    self.nextsplashlistindex = 0;
    self.splashlisttoggle = !self.splashlisttoggle;
  }
}

queuesplash(var_00, var_01, var_02, var_03, var_04) {
  var_05 = spawnStruct();
  var_5.ref = var_00;
  var_5.optionalnumber = var_01;
  var_5.playerforplayercard = var_02;
  var_5.playernumforplayercard = var_03;
  var_5.altdisplayindex = var_04;

  if(!isDefined(self.splashqueuehead)) {
    self.splashqueuehead = var_05;
    self.splashqueuetail = var_05;
    thread handlesplashqueue();
  } else {
    var_06 = self.splashqueuetail;
    var_6.nextsplash = var_05;
    self.splashqueuetail = var_05;
  }
}

handlesplashqueue() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");

  while(isDefined(self.splashqueuehead)) {
    scripts\engine\utility::waittill_any("splash_list_cleared", "spawned_player");

    for(var_00 = 0; var_00 < 6; var_0++) {
      var_01 = self.splashqueuehead;
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
  self.lowermessage give_zap_perk("");
  self.lowermessage.archived = 0;
  self.lowermessage.sort = 10;
  self.lowermessage.showinkillcam = 0;
  self.lowermessage scripts\mp\hud_util::setpoint("CENTER", level.lowertextyalign, 0, var_01);
  self.lowertimer = scripts\mp\hud_util::createfontstring("default", var_03);
  self.lowertimer scripts\mp\hud_util::setparent(self.lowermessage);
  self.lowertimer scripts\mp\hud_util::setpoint("TOP", "BOTTOM", 0, 0);
  self.lowertimer give_zap_perk("");
  self.lowertimer.archived = 0;
  self.lowertimer.sort = 10;
  self.lowertimer.showinkillcam = 0;
}

isdoingsplash() {
  return 0;
}

teamoutcomenotify(var_00, var_01, var_02) {
  self endon("disconnect");
  var_03 = self.pers["team"];

  if(self ismlgspectator()) {
    var_03 = self getmlgspectatorteam();
  }

  if(!isDefined(var_03) || var_03 != "allies" && var_03 != "axis") {
    var_03 = "allies";
  }

  if(var_00 == "halftime") {
    self setclientomnvar("ui_round_end_title", game["round_end"]["halftime"]);
    var_00 = "allies";
  } else if(var_00 == "intermission") {
    self setclientomnvar("ui_round_end_title", game["round_end"]["intermission"]);
    var_00 = "allies";
  } else if(var_00 == "roundend") {
    self setclientomnvar("ui_round_end_title", game["round_end"]["roundend"]);
    var_00 = "allies";
  } else if(var_00 == "overtime") {
    if(scripts\mp\utility\game::iswinbytworulegametype() && game["teamScores"]["allies"] != game["teamScores"]["axis"]) {
      self setclientomnvar("ui_round_end_title", game["round_end"]["match_point"]);
    }
    else {
      self setclientomnvar("ui_round_end_title", game["round_end"]["overtime"]);
    }

    var_00 = "allies";
  } else if(var_00 == "finalround") {
    self setclientomnvar("ui_round_end_title", game["round_end"]["final_round"]);
    var_00 = "allies";
  } else if(var_00 == "tie") {
    if(var_01 && !scripts\mp\utility\game::waslastround()) {
      self setclientomnvar("ui_round_end_title", game["round_end"]["round_draw"]);
    }
    else {
      self setclientomnvar("ui_round_end_title", game["round_end"]["draw"]);
    }

    var_00 = "allies";
  } else if(self ismlgspectator())
    self setclientomnvar("ui_round_end_title", game["round_end"]["spectator"]);
  else if(isDefined(self.pers["team"]) && var_00 == var_03) {
    if(var_01 && !scripts\mp\utility\game::waslastround()) {
      self setclientomnvar("ui_round_end_title", game["round_end"]["round_win"]);
    }
    else {
      self setclientomnvar("ui_round_end_title", game["round_end"]["victory"]);
    }
  } else if(var_01 && !scripts\mp\utility\game::waslastround())
    self setclientomnvar("ui_round_end_title", game["round_end"]["round_loss"]);
  else {
    self setclientomnvar("ui_round_end_title", game["round_end"]["defeat"]);

    if(scripts\mp\utility\game::istrue(self.joinedinprogress) && scripts\mp\utility\game::rankingenabled()) {
      var_02 = game["end_reason"]["loss_stat_prevented"];
    }
  }

  if(scripts\mp\utility\game::inovertime() && scripts\mp\utility\game::waslastround() && scripts\mp\utility\game::istimetobeatrulegametype()) {
    if(level.gametype == "ctf") {
      if(isDefined(self.pers["team"]) && var_00 == var_03) {
        var_02 = game["end_reason"]["time_to_beat_ctf_win"];
      }
      else if(isDefined(self.pers["team"]) && var_00 == level.otherteam[self.pers["team"]]) {
        var_02 = game["end_reason"]["time_to_beat_ctf_loss"];
      }
    } else if(level.gametype == "ball") {
      if(isDefined(self.pers["team"]) && var_00 == var_03) {
        var_02 = game["end_reason"]["time_to_beat_uplink_win"];
      }
      else if(isDefined(self.pers["team"]) && var_00 == level.otherteam[self.pers["team"]]) {
        var_02 = game["end_reason"]["time_to_beat_uplink_loss"];
      }
    }
  }

  self setclientomnvar("ui_round_end_reason", var_02);

  if(!scripts\mp\utility\game::isroundbased() || !scripts\mp\utility\game::isobjectivebased() || scripts\mp\utility\game::ismoddedroundgame()) {
    self setclientomnvar("ui_round_end_friendly_score", scripts\mp\gamescore::_getteamscore(var_03));
    self setclientomnvar("ui_round_end_enemy_score", scripts\mp\gamescore::_getteamscore(level.otherteam[var_03]));
  } else {
    self setclientomnvar("ui_round_end_friendly_score", game["roundsWon"][var_03]);
    self setclientomnvar("ui_round_end_enemy_score", game["roundsWon"][level.otherteam[var_03]]);
  }

  if(isDefined(self.func_B3DD)) {
    self setclientomnvar("ui_round_end_match_bonus", self.func_B3DD);
  }
}

func_C752(var_00, var_01) {
  self endon("disconnect");
  var_02 = level.placement["all"];
  var_03 = var_2[0];
  var_04 = var_2[1];
  var_05 = var_2[2];

  if(isstring(var_00) && var_00 == "tie") {
    if(isDefined(var_03) && self == var_03 || isDefined(var_04) && self == var_04 || isDefined(var_05) && self == var_05) {
      self setclientomnvar("ui_round_end_title", game["round_end"]["tie"]);
    }
    else {
      self setclientomnvar("ui_round_end_title", game["round_end"]["defeat"]);
    }
  } else if(isDefined(var_03) && self == var_03 || isDefined(var_04) && self == var_04 || isDefined(var_05) && self == var_05)
    self setclientomnvar("ui_round_end_title", game["round_end"]["victory"]);
  else {
    self setclientomnvar("ui_round_end_title", game["round_end"]["defeat"]);

    if(scripts\mp\utility\game::istrue(self.joinedinprogress) && scripts\mp\utility\game::rankingenabled()) {
      var_01 = game["end_reason"]["loss_stat_prevented"];
    }
  }

  self setclientomnvar("ui_round_end_reason", var_01);

  if(isDefined(self.func_B3DD)) {
    self setclientomnvar("ui_round_end_match_bonus", self.func_B3DD);
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

  while(!scripts\mp\utility\game::isreallyalive(self) && !self ismlgspectator()) {
    wait 0.15;
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

onkillstreaksplashshown(var_00) {
  scripts\mp\utility\game::playkillstreakdialogonplayer(var_00, "killstreak_earned", 1);
}

showerrormessage(var_00, var_01) {
  var_02 = tablelookuprownum("mp\errorMessages.csv", 0, var_00);

  if(isDefined(var_01)) {
    self setclientomnvar("ui_mp_error_message_param", var_01);
  }
  else {
    self setclientomnvar("ui_mp_error_message_param", -1);
  }

  self setclientomnvar("ui_mp_error_message_id", var_02);

  if(!isDefined(self.errormessagebitflipper)) {
    self.errormessagebitflipper = 0;
  }

  self.errormessagebitflipper = !self.errormessagebitflipper;
  self setclientomnvar("ui_mp_error_trigger", scripts\engine\utility::ter_op(self.errormessagebitflipper, 2, 1));
}

showerrormessagetoallplayers(var_00, var_01) {
  foreach(var_03 in level.players) {
  showerrormessage(var_00, var_01);
  }
}

testmiscmessage(var_00) {
  var_01 = tablelookuprownum("mp\miscMessages.csv", 0, var_00);

  if(isDefined(var_01) && var_01 >= 0) {
    return 1;
  }

  return 0;
}

showmiscmessage(var_00) {
  var_01 = tablelookuprownum("mp\miscMessages.csv", 0, var_00);
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
  wait 5.0;

  if(!isDefined(self)) {
    return;
  }
  if(!scripts\mp\utility\game::matchmakinggame()) {
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