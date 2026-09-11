/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\hud_message.gsc
***********************************************/

function init() {
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
  game["round_end"]["practice_round"] = 17;
  game["round_end"]["win_by_two"] = 18;
  game["end_reason"]["score_limit_reached"] = 1;
  game["end_reason"]["time_limit_reached"] = 2;
  game["end_reason"]["players_forfeited"] = 3;
  game["end_reason"]["target_destroyed"] = 4;
  game["end_reason"]["bomb_defused"] = 5;
  game["end_reason"]["rusf_eliminated"] = 6;
  game["end_reason"]["usmc_eliminated"] = 7;
  game["end_reason"]["sas_eliminated"] = 8;
  game["end_reason"]["sabf_eliminated"] = 9;
  game["end_reason"]["five_eliminated"] = 10;
  game["end_reason"]["six_eliminated"] = 11;
  game["end_reason"]["spetsnaz_forfeited"] = 12;
  game["end_reason"]["marines_forfeited"] = 13;
  game["end_reason"]["sas_forfeited"] = 14;
  game["end_reason"]["sabf_forfeited"] = 15;
  game["end_reason"]["five_forfeited"] = 16;
  game["end_reason"]["six_forfeited"] = 17;
  game["end_reason"]["enemies_eliminated"] = 18;
  game["end_reason"]["tie"] = 19;
  game["end_reason"]["objective_completed"] = 20;
  game["end_reason"]["objective_failed"] = 21;
  game["end_reason"]["switching_sides"] = 22;
  game["end_reason"]["round_limit_reached"] = 23;
  game["end_reason"]["ended_game"] = 24;
  game["end_reason"]["host_ended_game"] = 25;
  game["end_reason"]["loss_stat_prevented"] = 26;
  game["end_reason"]["time_to_beat_ctf_win"] = 27;
  game["end_reason"]["time_to_beat_ctf_loss"] = 28;
  game["end_reason"]["time_to_beat_uplink_win"] = 29;
  game["end_reason"]["time_to_beat_uplink_loss"] = 30;
  game["end_reason"]["nuke_end"] = 31;
  game["end_reason"]["enemies_forfeited"] = 32;
  game["end_reason"]["arena_time_health_win"] = 33;
  game["end_reason"]["arena_time_health_loss"] = 34;
  game["end_reason"]["arena_time_lives_win"] = 35;
  game["end_reason"]["arena_time_lives_loss"] = 36;
  game["end_reason"]["arena_otflag_completed"] = 37;
  game["end_reason"]["arena_otflag_failed"] = 38;
  game["end_reason"]["outpost_defended"] = 39;
  game["end_reason"]["practice_round_over"] = 40;
  game["end_reason"]["br_eliminated"] = 41;
  game["end_reason"]["cyber_tie"] = 42;
  game["end_reason"]["mercy_win"] = 43;
  game["end_reason"]["mercy_loss"] = 44;
  game["end_reason"]["blank"] = 45;
  game["end_reason"]["mlg_time_to_beat_ctf"] = 46;
  game["end_reason"]["mlg_time_to_beat_uplink"] = 47;
  game["end_reason"]["mlg_time_lives"] = 48;
  game["end_reason"]["mlg_time_health"] = 49;
  game["end_reason"]["mlg_eliminated"] = 50;
  game["end_reason"]["mlg_forfeited"] = 51;
  game["end_reason"]["siege_allflags_win"] = 52;
  game["end_reason"]["siege_allflags_loss"] = 53;
  game["end_reason"]["siege_flag_win"] = 54;
  game["end_reason"]["siege_flag_loss"] = 55;
  game["end_reason"]["arena_tournament_tie_win"] = 56;
  game["end_reason"]["arena_tournament_tie_loss"] = 57;
  game["end_reason"]["dmz_plunder_loss"] = 58;
  game["end_reason"]["dmz_plunder_win"] = 59;
  game["end_reason"]["enemy_forfeit"] = 60;
  game["end_reason"]["survivors_eliminated"] = 61;
  game["end_reason"]["siege_force_end"] = 62;
  game["end_reason"]["dom_force_end"] = 63;
  game["end_reason"]["win_by_two_tie"] = 64;
  game["round_end_exmsg"]["intermission"] = 1;
  game["round_end_exmsg"]["switching_sides"] = 2;
  game["round_end_exmsg"]["match_point"] = 3;
  game["end_reason_mlg_mapping"][game["end_reason"]["time_to_beat_ctf_win"]] = game["end_reason"]["mlg_time_to_beat_ctf"];
  game["end_reason_mlg_mapping"][game["end_reason"]["time_to_beat_ctf_loss"]] = game["end_reason"]["mlg_time_to_beat_ctf"];
  game["end_reason_mlg_mapping"][game["end_reason"]["arena_time_health_win"]] = game["end_reason"]["mlg_time_health"];
  game["end_reason_mlg_mapping"][game["end_reason"]["arena_time_health_loss"]] = game["end_reason"]["mlg_time_health"];
  game["end_reason_mlg_mapping"][game["end_reason"]["time_to_beat_uplink_win"]] = game["end_reason"]["mlg_time_to_beat_uplink"];
  game["end_reason_mlg_mapping"][game["end_reason"]["time_to_beat_uplink_loss"]] = game["end_reason"]["mlg_time_to_beat_uplink"];
  game["end_reason_mlg_mapping"][game["end_reason"]["arena_time_lives_win"]] = game["end_reason"]["mlg_time_lives"];
  game["end_reason_mlg_mapping"][game["end_reason"]["arena_time_lives_loss"]] = game["end_reason"]["mlg_time_lives"];
  game["end_reason_mlg_mapping"][game["end_reason"]["rusf_eliminated"]] = game["end_reason"]["mlg_eliminated"];
  game["end_reason_mlg_mapping"][game["end_reason"]["usmc_eliminated"]] = game["end_reason"]["mlg_eliminated"];
  game["end_reason_mlg_mapping"][game["end_reason"]["sas_eliminated"]] = game["end_reason"]["mlg_eliminated"];
  game["end_reason_mlg_mapping"][game["end_reason"]["sabf_eliminated"]] = game["end_reason"]["mlg_eliminated"];
  game["end_reason_mlg_mapping"][game["end_reason"]["five_eliminated"]] = game["end_reason"]["mlg_eliminated"];
  game["end_reason_mlg_mapping"][game["end_reason"]["six_eliminated"]] = game["end_reason"]["mlg_eliminated"];
  game["end_reason_mlg_mapping"][game["end_reason"]["spetsnaz_forfeited"]] = game["end_reason"]["mlg_forfeited"];
  game["end_reason_mlg_mapping"][game["end_reason"]["marines_forfeited"]] = game["end_reason"]["mlg_forfeited"];
  game["end_reason_mlg_mapping"][game["end_reason"]["sas_forfeited"]] = game["end_reason"]["mlg_forfeited"];
  game["end_reason_mlg_mapping"][game["end_reason"]["sabf_forfeited"]] = game["end_reason"]["mlg_forfeited"];
  game["end_reason_mlg_mapping"][game["end_reason"]["five_forfeited"]] = game["end_reason"]["mlg_forfeited"];
  game["end_reason_mlg_mapping"][game["end_reason"]["six_forfeited"]] = game["end_reason"]["mlg_forfeited"];
  level.splashtablecache = [];
  thread onplayerconnect();
  scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(&splashshowncallback);
  level.showerrormessagefunc = &showerrormessage;
}

function onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    thread lowermessagethink();
    thread eventsplashesthink();
  }
}

function showkillstreaksplash(var_0, var_1, var_2) {
  if(!isPlayer(self)) {
    return;
  }

  var_3 = undefined;

  if(istrue(var_2)) {
    var_3 = 1;
  }

  var_0 = getspecialistsplashfromkillstreak(var_0);
  showsplash(var_0, var_1, undefined, var_3);

  if(scripts\cp_mp\utility\game_utility::isrealismenabled()) {
    scripts\mp\utility\dialog::playkillstreakdialogonplayer(var_0, "killstreak_earned", 1);
    return;
  }
}

function getspecialistsplashfromkillstreak(var_0) {
  var_1 = var_0;
  var_2 = scripts\mp\perks\perks::getspecialistperkforstreak(var_0);

  if(isDefined(var_2)) {
    var_1 = var_2;
  }

  return var_1;
}

function showsplashwithkillcheckhack(var_0, var_1, var_2, var_3, var_4) {
  level endon("game_ended");
  self endon("disconnect");
  waitframe();

  if(isDefined(self.lastkilltime)) {
    var_5 = getdvarfloat("scr_splash_kill_buffer", 0.5) * 1000;
    var_6 = int(max(var_5 - gettime() - self.lastkilltime, 0));
    wait var_6 / 1000;
  }

  showsplash(var_0, var_1, var_2, var_3, 1);
}

function showsplash(var_0, var_1, var_2, var_3, var_4) {
  if(!istrue(var_4)) {
    thread showsplashwithkillcheckhack(var_0, var_1, var_2, var_3, var_4);
    return;
  }

  var_5 = undefined;

  if(isDefined(var_2)) {
    var_5 = var_2 getentitynumber();
  }

  if(isDefined(self.recentsplashcount) && self.recentsplashcount >= 6) {
    queuesplash(var_0, var_1, var_2, var_5, var_3);
    return;
  }

  if(!scripts\mp\utility\player::isreallyalive(self) && !self ismlgspectator()) {
    queuesplash(var_0, var_1, var_2, var_5, var_3);
    return;
  }

  showsplashinternal(var_0, var_1, var_2, var_5, var_3);
}

function showsplashinternal(var_0, var_1, var_2, var_3, var_4) {
  if(!isPlayer(self)) {
    return;
  }

  if(isDefined(var_3)) {
    if(!isDefined(var_2)) {
      return;
    }
  }

  var_5 = getsplashid(var_0);

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
    var_6 |= 4096;
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

  self setclientomnvar("ui_player_splash_id_" + self.nextsplashlistindex, var_6);

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
    return;
  }
}

function queuesplash(var_0, var_1, var_2, var_3, var_4) {
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

function handlesplashqueue() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("clearSplashQueue");

  while(isDefined(self.splashqueuehead)) {
    if(scripts\mp\utility\game::getgametype() == "br" && (scripts\mp\utility\game::round_vehicle_logic() == "dmz" || scripts\mp\utility\game::round_vehicle_logic() == "risk" || scripts\mp\utility\game::round_vehicle_logic() == "rumble")) {
      scripts\engine\utility::ref_143a5("splash_list_cleared", "can_show_splashes");
    } else {
      scripts\engine\utility::ref_143a5("splash_list_cleared", "spawned_player");
    }

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

function heartbeat_sensor_pick_up_monitor() {
  self notify("clearSplashQueue");
  var_0 = self.splashqueuehead;

  while(isDefined(var_0)) {
    var_1 = var_0;
    var_0 = var_1.nextsplash;
    var_1.nextsplash = undefined;
  }

  self.splashqueuehead = undefined;
  self.splashqueuetail = undefined;
}

function getsplashid(var_0) {
  var_1 = level.splashtablecache[var_0];

  if(!isDefined(var_1)) {
    var_1 = tablelookuprownum(getsplashtablename(), 0, var_0);
    level.splashtablecache[var_0] = var_1;
  }

  return var_1;
}

function lowermessagethink() {
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
    var_1 -= 40;
    var_2 = level.lowertextfontsize * 1.3;
    var_3 *= 1.5;
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

function isdoingsplash() {
  return false;
}

function teamoutcomenotify(var_0, var_1, var_2, var_3, var_4) {
  self endon("disconnect");

  if(isDefined(var_4)) {
    self setclientomnvar("ui_round_end_extra_message", var_4);
  }

  var_5 = self.pers["team"];

  if(self ismlgspectator()) {
    var_5 = self getmlgspectatorteam();
  }

  if(!isDefined(var_5) || !scripts\engine\utility::array_contains(level.teamnamelist, var_5)) {
    var_5 = "allies";
  }

  if(var_0 == "halftime") {
    self setclientomnvar("ui_round_end_title", game["round_end"]["halftime"]);
    var_0 = "allies";
  } else if(var_0 == "intermission") {
    self setclientomnvar("ui_round_end_title", game["round_end"]["intermission"]);
    var_0 = "allies";
  } else if(var_0 == "switching_sides") {
    self setclientomnvar("ui_round_end_title", game["round_end"]["side_switch"]);
    var_0 = "allies";
  } else if(var_0 == "roundend") {
    self setclientomnvar("ui_round_end_title", game["round_end"]["roundend"]);
    var_0 = "allies";
  } else if(var_0 == "overtime") {
    if(scripts\mp\utility\game::iswinbytworulegametype() && !scripts\mp\utility\game::allteamstied()) {
      self setclientomnvar("ui_round_end_title", game["round_end"]["match_point"]);
    } else {
      self setclientomnvar("ui_round_end_title", game["round_end"]["overtime"]);
    }

    var_0 = "allies";
  } else if(var_0 == "match_point") {
    self setclientomnvar("ui_round_end_title", game["round_end"]["match_point"]);
    var_0 = "allies";
  } else if(var_0 == "final_round") {
    self setclientomnvar("ui_round_end_title", game["round_end"]["final_round"]);
    var_0 = "allies";
  } else if(var_0 == "win_by_two") {
    self setclientomnvar("ui_round_end_title", game["round_end"]["win_by_two"]);
    var_0 = "allies";
  } else if(var_0 == "tie") {
    if(var_1 && !scripts\mp\utility\game::waslastround()) {
      self setclientomnvar("ui_round_end_title", game["round_end"]["round_draw"]);
    } else {
      self setclientomnvar("ui_round_end_title", game["round_end"]["draw"]);
    }

    var_0 = "allies";
  } else if(self ismlgspectator()) {
    self setclientomnvar("ui_round_end_title", game["round_end"]["spectator"]);
  } else if(isDefined(self.pers["team"]) && var_0 == var_5) {
    if(var_1 && !scripts\mp\utility\game::waslastround()) {
      self setclientomnvar("ui_round_end_title", game["round_end"]["round_win"]);
    } else {
      self setclientomnvar("ui_round_end_title", game["round_end"]["victory"]);
    }
  } else if(var_1 && !scripts\mp\utility\game::waslastround()) {
    self setclientomnvar("ui_round_end_title", game["round_end"]["round_loss"]);
  } else {
    self setclientomnvar("ui_round_end_title", game["round_end"]["defeat"]);

    if(istrue(self.joinedinprogress) && scripts\mp\utility\game::onlinestatsenabled()) {
      var_2 = game["end_reason"]["loss_stat_prevented"];
    }
  }

  if(scripts\mp\utility\game::getgametype() == "arena" || scripts\mp\utility\game::getgametype() == "br" || scripts\mp\utility\game::getgametype() == "arm" || scripts\mp\utility\game::getgametype() == "siege") {
    if(isDefined(var_3)) {
      if(isDefined(self.pers["team"]) && var_0 == var_5) {
        var_2 = var_2;
      } else {
        var_2 = var_3;
      }
    }
  } else if(scripts\mp\utility\game::inovertime() && scripts\mp\utility\game::waslastround() && scripts\mp\utility\game::istimetobeatrulegametype()) {
    if(scripts\mp\utility\game::getgametype() == "ctf") {
      if(isDefined(self.pers["team"]) && var_0 == var_5) {
        var_2 = game["end_reason"]["time_to_beat_ctf_win"];
      } else if(isDefined(self.pers["team"]) && var_0 == scripts\mp\utility\game::getotherteam(self.pers["team"])[0]) {
        var_2 = game["end_reason"]["time_to_beat_ctf_loss"];
      }
    } else if(scripts\mp\utility\game::getgametype() == "ball") {
      if(isDefined(self.pers["team"]) && var_0 == var_5) {
        var_2 = game["end_reason"]["time_to_beat_uplink_win"];
      } else if(isDefined(self.pers["team"]) && var_0 == scripts\mp\utility\game::getotherteam(self.pers["team"])[0]) {
        var_2 = game["end_reason"]["time_to_beat_uplink_loss"];
      }
    }
  } else if(isDefined(var_3)) {
    if(isDefined(self.pers["team"]) && var_0 == var_5) {
      var_2 = var_2;
    } else {
      var_2 = var_3;
    }
  }

  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  if(self ismlgspectator()) {
    if(isDefined(game["end_reason_mlg_mapping"][var_2])) {
      var_2 = game["end_reason_mlg_mapping"][var_2];
    }
  }

  self setclientomnvar("ui_round_end_reason", var_2);

  if(self ismlgspectator()) {
    if(var_0 == "allies") {
      self setclientomnvar("ui_round_end_winner", 1);
    } else if(var_0 == "axis") {
      self setclientomnvar("ui_round_end_winner", 2);
    } else {
      self setclientomnvar("ui_round_end_winner", 0);
    }
  }

  if(!scripts\mp\utility\game::isroundbased() || !scripts\mp\utility\game::isobjectivebased() || scripts\mp\utility\game::ismoddedroundgame()) {
    var_6 = scripts\mp\gamescore::_getteamscore(var_5);

    if(var_6 > 16000) {
      var_6 = 16000;
    }

    var_7 = scripts\mp\gamescore::_getteamscore(scripts\mp\utility\game::getotherteam(var_5)[0]);

    if(var_7 > 16000) {
      var_7 = 16000;
    }

    self setclientomnvar("ui_round_end_friendly_score", var_6);
    self setclientomnvar("ui_round_end_enemy_score", var_7);
  } else {
    self setclientomnvar("ui_round_end_friendly_score", game["roundsWon"][var_5]);
    self setclientomnvar("ui_round_end_enemy_score", game["roundsWon"][scripts\mp\utility\game::getotherteam(var_5)[0]]);
  }

  if(isDefined(self.matchbonus)) {
    self setclientomnvar("ui_round_end_match_bonus", self.matchbonus);
    return;
  }
}

function outcomenotify(var_0, var_1, var_2) {
  self endon("disconnect");
  var_3 = level.placement["all"];
  var_4 = var_3[0];
  var_5 = var_3[1];
  var_6 = var_3[2];

  if(isstring(var_0) && var_0 == "tie") {
    if(isDefined(var_4) && self == var_4 || isDefined(var_5) && self == var_5 || isDefined(var_6) && self == var_6) {
      self setclientomnvar("ui_round_end_title", game["round_end"]["tie"]);
      self setclientomnvar("ui_round_end_reason", var_1);
    } else {
      self setclientomnvar("ui_round_end_title", game["round_end"]["defeat"]);
      self setclientomnvar("ui_round_end_reason", scripts\engine\utility::ter_op(isDefined(var_2), var_2, var_1));
    }
  } else if(isDefined(var_4) && self == var_4 || isDefined(var_5) && self == var_5 || isDefined(var_6) && self == var_6) {
    self setclientomnvar("ui_round_end_title", game["round_end"]["victory"]);
    self setclientomnvar("ui_round_end_reason", var_1);
  } else {
    self setclientomnvar("ui_round_end_title", game["round_end"]["defeat"]);
    self setclientomnvar("ui_round_end_reason", scripts\engine\utility::ter_op(isDefined(var_2), var_2, var_1));

    if(istrue(self.joinedinprogress) && scripts\mp\utility\game::onlinestatsenabled()) {
      var_1 = game["end_reason"]["loss_stat_prevented"];
    }
  }

  if(isDefined(self.matchbonus)) {
    self setclientomnvar("ui_round_end_match_bonus", self.matchbonus);
    return;
  }
}

function getsplashtablename() {
  return "mp/splashTable.csv";
}

function getsplashtablemaxaltdisplays() {
  return 5;
}

function cleanuplocalplayersplashlist() {
  self endon("disconnect");
  self notify("cleanupLocalPlayerSplashList()");
  self endon("cleanupLocalPlayerSplashList()");
  scripts\engine\utility::waittill_notify_or_timeout("death", 0.5);

  while(!scripts\mp\utility\player::isreallyalive(self) && !self ismlgspectator()) {
    wait 0.15;
  }

  self.recentsplashcount = undefined;
  self notify("splash_list_cleared");
}

function splashshowncallback(var_0, var_1) {
  if(var_0 != "splash_shown") {
    return;
  }

  var_2 = tablelookupbyrow(getsplashtablename(), var_1, 0);
  var_3 = tablelookupbyrow(getsplashtablename(), var_1, 6);

  switch (var_3) {
    case "killstreak_splash":
      onkillstreaksplashshown(var_2);
      break;
  }
}

function onkillstreaksplashshown(var_0) {
  scripts\mp\utility\dialog::playkillstreakdialogonplayer(var_0, "killstreak_earned", 1);
  thread checkforspecialistbonusvo(var_0);
}

function checkforspecialistbonusvo(var_0) {
  var_1 = scripts\mp\perks\perks::getspecialistperkforstreak();

  if(var_0 == "specialist_perk_bonus") {
    wait 2;
    level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "flavor_positive");
    return;
  }
}

function showerrormessage(var_0, var_1) {
  var_2 = tablelookuprownum("mp/errorMessages.csv", 0, var_0);

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

function showerrormessagetoallplayers(var_0, var_1) {
  foreach(var_3 in level.players) {
    showerrormessage(var_0, var_1);
  }
}

function testmiscmessage(var_0) {
  var_1 = tablelookuprownum("mp/miscMessages.csv", 0, var_0);

  if(isDefined(var_1) && var_1 >= 0) {
    return true;
  }

  return false;
}

function showmiscmessage(var_0) {
  var_1 = tablelookuprownum("mp/miscMessages.csv", 0, var_0);
  var_2 = tablelookupbyrow("mp/miscMessages.csv", var_1, 3);

  if(isDefined(var_2) && var_2 != "") {
    self playlocalsound(var_2);
  }

  self setclientomnvar("ui_misc_message_id", var_1);
  self setclientomnvar("ui_misc_message_trigger", 1);
}

function eventsplashesthink() {
  self endon("disconnect");

  if(!scripts\mp\utility\game::matchmakinggame()) {
    return;
  }

  var_0 = 0;

  if(!isDefined(self.pers["hasSpawned"])) {
    var_0 = 1;
  }

  var_1 = getdvarint("OLLOKOKKSM", 0) == 1 || !isgamebattlematch();

  if(!var_1) {
    var_0 = 0;
  }

  if(scripts\mp\flags::gameflag("infil_will_run")) {
    if(!scripts\mp\flags::gameflag("prematch_done")) {
      level scripts\mp\flags::gameflagwait("prematch_done");
    }
  }

  if(!istrue(self.hasspawned)) {
    self waittill("spawned_player");

    if(!scripts\mp\flags::gameflag("prematch_done")) {
      wait 5;
    } else {
      wait 2;
    }
  } else {
    wait 2;
  }

  if(!isDefined(self)) {
    return;
  }

  var_2 = self getprivatepartysize() > 1;

  if(var_0) {
    if(getdvarint("LKKNORQKTP") == 2 || var_2 && getdvarint("NTLKOKLKRS") == 2 || self isps4player() && getdvarfloat("MPPRMTPSLT") == 2) {
      showsplash("event_double_xp");
    }

    if(getdvarint("PMORNPNTK") == 2 || var_2 && getdvarint("LNQMMNNPSR") == 2) {
      showsplash("event_double_weapon_xp");
    }

    if(getdvarint("LTKKKPSRSK") == 2) {
      showsplash("event_double_battle_xp");
    }

    if(getdvarint("LPORTLTMNP") > 0) {
      showsplash("event_double_keys");
    }

    if(getdvarint("OMPLRMMKML") == 2 || var_2 && getdvarint("NTPRTMORKK") == 2) {
      showsplash("event_double_xp_teams");
      return;
    }

    return;
  }
}

function notifyteam(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = scripts\mp\utility\teams::getenemyteams(var_2);

  foreach(var_8 in level.players) {
    if(!scripts\mp\utility\player::isreallyalive(var_8)) {
      continue;
    }

    if(var_8.team == var_2) {
      if(isDefined(var_3)) {
        if(!scripts\engine\utility::array_contains(var_3, var_8)) {
          thread showsplash(var_8, var_0);
        }
      } else {
        thread showsplash(var_8, var_0);
      }

      continue;
    }

    foreach(var_10 in var_6) {
      if(var_8.team == var_10) {
        if(isDefined(var_3)) {
          if(!scripts\engine\utility::array_contains(var_3, var_8)) {
            thread showsplash(var_8, var_1);
          }

          continue;
        }

        thread showsplash(var_8, var_1);
      }
    }
  }
}

function updatematchstatushintforallplayers(var_0, var_1, var_2, var_3, var_4) {
  level notify("updateHint");
  level endon("updateHint");

  foreach(var_6 in level.players) {
    if(isDefined(var_0) && var_6.team == var_0) {
      if(isDefined(var_3) && var_6 == var_3) {
        var_6 setclientomnvar("ui_match_status_hint_text", var_4);
      } else {
        var_6 setclientomnvar("ui_match_status_hint_text", var_1);
      }

      continue;
    }

    if(isDefined(var_2)) {
      var_6 setclientomnvar("ui_match_status_hint_text", var_2);
    }
  }
}