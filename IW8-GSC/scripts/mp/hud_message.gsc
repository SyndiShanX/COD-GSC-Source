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
    level waittill("connected", var0);
    thread lowermessagethink();
    thread eventsplashesthink();
  }
}

function showkillstreaksplash(var0, var1, var2) {
  if(!isPlayer(self)) {
    return;
  }

  var3 = undefined;

  if(istrue(var2)) {
    var3 = 1;
  }

  var0 = getspecialistsplashfromkillstreak(var0);
  showsplash(var0, var1, undefined, var3);

  if(scripts\cp_mp\utility\game_utility::isrealismenabled()) {
    scripts\mp\utility\dialog::playkillstreakdialogonplayer(var0, "killstreak_earned", 1);
    return;
  }
}

function getspecialistsplashfromkillstreak(var0) {
  var1 = var0;
  var2 = scripts\mp\perks\perks::getspecialistperkforstreak(var0);

  if(isDefined(var2)) {
    var1 = var2;
  }

  return var1;
}

function showsplashwithkillcheckhack(var0, var1, var2, var3, var4) {
  level endon("game_ended");
  self endon("disconnect");
  waitframe();

  if(isDefined(self.lastkilltime)) {
    var5 = getdvarfloat("scr_splash_kill_buffer", 0.5) * 1000;
    var6 = int(max(var5 - gettime() - self.lastkilltime, 0));
    wait var6 / 1000;
  }

  showsplash(var0, var1, var2, var3, 1);
}

function showsplash(var0, var1, var2, var3, var4) {
  if(!istrue(var4)) {
    thread showsplashwithkillcheckhack(var0, var1, var2, var3, var4);
    return;
  }

  var5 = undefined;

  if(isDefined(var2)) {
    var5 = var2 getentitynumber();
  }

  if(isDefined(self.recentsplashcount) && self.recentsplashcount >= 6) {
    queuesplash(var0, var1, var2, var5, var3);
    return;
  }

  if(!scripts\mp\utility\player::isreallyalive(self) && !self ismlgspectator()) {
    queuesplash(var0, var1, var2, var5, var3);
    return;
  }

  showsplashinternal(var0, var1, var2, var5, var3);
}

function showsplashinternal(var0, var1, var2, var3, var4) {
  if(!isPlayer(self)) {
    return;
  }

  if(isDefined(var3)) {
    if(!isDefined(var2)) {
      return;
    }
  }

  var5 = getsplashid(var0);

  if(!isDefined(var5) || var5 < 0) {
    return;
  }

  if(!isDefined(self.nextsplashlistindex)) {
    self.nextsplashlistindex = 0;
  }

  if(!isDefined(self.splashlisttoggle)) {
    self.splashlisttoggle = 1;
  }

  var6 = var5;

  if(self.splashlisttoggle) {
    var6 |= 4096;
  }

  if(isDefined(var1)) {
    self setclientomnvar("ui_player_splash_param_" + self.nextsplashlistindex, var1);
  } else {
    self setclientomnvar("ui_player_splash_param_" + self.nextsplashlistindex, -1);
  }

  if(isDefined(var3)) {
    self setclientomnvar("ui_player_splash_cardClientId_" + self.nextsplashlistindex, var3);
  } else {
    self setclientomnvar("ui_player_splash_cardClientId_" + self.nextsplashlistindex, -1);
  }

  if(isDefined(var4)) {
    self setclientomnvar("ui_player_splash_use_alt_" + self.nextsplashlistindex, var4);
  } else {
    self setclientomnvar("ui_player_splash_use_alt_" + self.nextsplashlistindex, 0);
  }

  self setclientomnvar("ui_player_splash_id_" + self.nextsplashlistindex, var6);

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

function queuesplash(var0, var1, var2, var3, var4) {
  var5 = spawnStruct();
  var5.ref = var0;
  var5.optionalnumber = var1;
  var5.playerforplayercard = var2;
  var5.playernumforplayercard = var3;
  var5.altdisplayindex = var4;

  if(!isDefined(self.splashqueuehead)) {
    self.splashqueuehead = var5;
    self.splashqueuetail = var5;
    thread handlesplashqueue();
    return;
  }

  var6 = self.splashqueuetail;
  var6.nextsplash = var5;
  self.splashqueuetail = var5;
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

    for(var0 = 0; var0 < 6; var0++) {
      var1 = self.splashqueuehead;
      showsplashinternal(var1.ref, var1.optionalnumber, var1.playerforplayercard, var1.playernumforplayercard, var1.altdisplayindex);
      self.splashqueuehead = var1.nextsplash;

      if(!isDefined(self.splashqueuehead)) {
        break;
      }
    }
  }

  self.splashqueuetail = undefined;
}

function heartbeat_sensor_pick_up_monitor() {
  self notify("clearSplashQueue");
  var0 = self.splashqueuehead;

  while(isDefined(var0)) {
    var1 = var0;
    var0 = var1.nextsplash;
    var1.nextsplash = undefined;
  }

  self.splashqueuehead = undefined;
  self.splashqueuetail = undefined;
}

function getsplashid(var0) {
  var1 = level.splashtablecache[var0];

  if(!isDefined(var1)) {
    var1 = tablelookuprownum(getsplashtablename(), 0, var0);
    level.splashtablecache[var0] = var1;
  }

  return var1;
}

function lowermessagethink() {
  self endon("disconnect");
  self.lowermessages = [];
  var0 = "default";

  if(isDefined(level.lowermessagefont)) {
    var0 = level.lowermessagefont;
  }

  var1 = level.lowertexty;
  var2 = level.lowertextfontsize;
  var3 = 1.25;

  if(level.splitscreen || self issplitscreenplayer() && !isai(self)) {
    var1 -= 40;
    var2 = level.lowertextfontsize * 1.3;
    var3 *= 1.5;
  }

  self.lowermessage = scripts\mp\hud_util::createfontstring(var0, var2);
  self.lowermessage settext("");
  self.lowermessage.archived = 0;
  self.lowermessage.sort = 10;
  self.lowermessage.showinkillcam = 0;
  self.lowermessage scripts\mp\hud_util::setpoint("CENTER", level.lowertextyalign, 0, var1);
  self.lowertimer = scripts\mp\hud_util::createfontstring("default", var3);
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

function teamoutcomenotify(var0, var1, var2, var3, var4) {
  self endon("disconnect");

  if(isDefined(var4)) {
    self setclientomnvar("ui_round_end_extra_message", var4);
  }

  var5 = self.pers["team"];

  if(self ismlgspectator()) {
    var5 = self getmlgspectatorteam();
  }

  if(!isDefined(var5) || !scripts\engine\utility::array_contains(level.teamnamelist, var5)) {
    var5 = "allies";
  }

  if(var0 == "halftime") {
    self setclientomnvar("ui_round_end_title", game["round_end"]["halftime"]);
    var0 = "allies";
  } else if(var0 == "intermission") {
    self setclientomnvar("ui_round_end_title", game["round_end"]["intermission"]);
    var0 = "allies";
  } else if(var0 == "switching_sides") {
    self setclientomnvar("ui_round_end_title", game["round_end"]["side_switch"]);
    var0 = "allies";
  } else if(var0 == "roundend") {
    self setclientomnvar("ui_round_end_title", game["round_end"]["roundend"]);
    var0 = "allies";
  } else if(var0 == "overtime") {
    if(scripts\mp\utility\game::iswinbytworulegametype() && !scripts\mp\utility\game::allteamstied()) {
      self setclientomnvar("ui_round_end_title", game["round_end"]["match_point"]);
    } else {
      self setclientomnvar("ui_round_end_title", game["round_end"]["overtime"]);
    }

    var0 = "allies";
  } else if(var0 == "match_point") {
    self setclientomnvar("ui_round_end_title", game["round_end"]["match_point"]);
    var0 = "allies";
  } else if(var0 == "final_round") {
    self setclientomnvar("ui_round_end_title", game["round_end"]["final_round"]);
    var0 = "allies";
  } else if(var0 == "win_by_two") {
    self setclientomnvar("ui_round_end_title", game["round_end"]["win_by_two"]);
    var0 = "allies";
  } else if(var0 == "tie") {
    if(var1 && !scripts\mp\utility\game::waslastround()) {
      self setclientomnvar("ui_round_end_title", game["round_end"]["round_draw"]);
    } else {
      self setclientomnvar("ui_round_end_title", game["round_end"]["draw"]);
    }

    var0 = "allies";
  } else if(self ismlgspectator()) {
    self setclientomnvar("ui_round_end_title", game["round_end"]["spectator"]);
  } else if(isDefined(self.pers["team"]) && var0 == var5) {
    if(var1 && !scripts\mp\utility\game::waslastround()) {
      self setclientomnvar("ui_round_end_title", game["round_end"]["round_win"]);
    } else {
      self setclientomnvar("ui_round_end_title", game["round_end"]["victory"]);
    }
  } else if(var1 && !scripts\mp\utility\game::waslastround()) {
    self setclientomnvar("ui_round_end_title", game["round_end"]["round_loss"]);
  } else {
    self setclientomnvar("ui_round_end_title", game["round_end"]["defeat"]);

    if(istrue(self.joinedinprogress) && scripts\mp\utility\game::onlinestatsenabled()) {
      var2 = game["end_reason"]["loss_stat_prevented"];
    }
  }

  if(scripts\mp\utility\game::getgametype() == "arena" || scripts\mp\utility\game::getgametype() == "br" || scripts\mp\utility\game::getgametype() == "arm" || scripts\mp\utility\game::getgametype() == "siege") {
    if(isDefined(var3)) {
      if(isDefined(self.pers["team"]) && var0 == var5) {
        var2 = var2;
      } else {
        var2 = var3;
      }
    }
  } else if(scripts\mp\utility\game::inovertime() && scripts\mp\utility\game::waslastround() && scripts\mp\utility\game::istimetobeatrulegametype()) {
    if(scripts\mp\utility\game::getgametype() == "ctf") {
      if(isDefined(self.pers["team"]) && var0 == var5) {
        var2 = game["end_reason"]["time_to_beat_ctf_win"];
      } else if(isDefined(self.pers["team"]) && var0 == scripts\mp\utility\game::getotherteam(self.pers["team"])[0]) {
        var2 = game["end_reason"]["time_to_beat_ctf_loss"];
      }
    } else if(scripts\mp\utility\game::getgametype() == "ball") {
      if(isDefined(self.pers["team"]) && var0 == var5) {
        var2 = game["end_reason"]["time_to_beat_uplink_win"];
      } else if(isDefined(self.pers["team"]) && var0 == scripts\mp\utility\game::getotherteam(self.pers["team"])[0]) {
        var2 = game["end_reason"]["time_to_beat_uplink_loss"];
      }
    }
  } else if(isDefined(var3)) {
    if(isDefined(self.pers["team"]) && var0 == var5) {
      var2 = var2;
    } else {
      var2 = var3;
    }
  }

  if(!isDefined(var2)) {
    var2 = 1;
  }

  if(self ismlgspectator()) {
    if(isDefined(game["end_reason_mlg_mapping"][var2])) {
      var2 = game["end_reason_mlg_mapping"][var2];
    }
  }

  self setclientomnvar("ui_round_end_reason", var2);

  if(self ismlgspectator()) {
    if(var0 == "allies") {
      self setclientomnvar("ui_round_end_winner", 1);
    } else if(var0 == "axis") {
      self setclientomnvar("ui_round_end_winner", 2);
    } else {
      self setclientomnvar("ui_round_end_winner", 0);
    }
  }

  if(!scripts\mp\utility\game::isroundbased() || !scripts\mp\utility\game::isobjectivebased() || scripts\mp\utility\game::ismoddedroundgame()) {
    var6 = scripts\mp\gamescore::_getteamscore(var5);

    if(var6 > 16000) {
      var6 = 16000;
    }

    var7 = scripts\mp\gamescore::_getteamscore(scripts\mp\utility\game::getotherteam(var5)[0]);

    if(var7 > 16000) {
      var7 = 16000;
    }

    self setclientomnvar("ui_round_end_friendly_score", var6);
    self setclientomnvar("ui_round_end_enemy_score", var7);
  } else {
    self setclientomnvar("ui_round_end_friendly_score", game["roundsWon"][var5]);
    self setclientomnvar("ui_round_end_enemy_score", game["roundsWon"][scripts\mp\utility\game::getotherteam(var5)[0]]);
  }

  if(isDefined(self.matchbonus)) {
    self setclientomnvar("ui_round_end_match_bonus", self.matchbonus);
    return;
  }
}

function outcomenotify(var0, var1, var2) {
  self endon("disconnect");
  var3 = level.placement["all"];
  var4 = var3[0];
  var5 = var3[1];
  var6 = var3[2];

  if(isstring(var0) && var0 == "tie") {
    if(isDefined(var4) && self == var4 || isDefined(var5) && self == var5 || isDefined(var6) && self == var6) {
      self setclientomnvar("ui_round_end_title", game["round_end"]["tie"]);
      self setclientomnvar("ui_round_end_reason", var1);
    } else {
      self setclientomnvar("ui_round_end_title", game["round_end"]["defeat"]);
      self setclientomnvar("ui_round_end_reason", scripts\engine\utility::ter_op(isDefined(var2), var2, var1));
    }
  } else if(isDefined(var4) && self == var4 || isDefined(var5) && self == var5 || isDefined(var6) && self == var6) {
    self setclientomnvar("ui_round_end_title", game["round_end"]["victory"]);
    self setclientomnvar("ui_round_end_reason", var1);
  } else {
    self setclientomnvar("ui_round_end_title", game["round_end"]["defeat"]);
    self setclientomnvar("ui_round_end_reason", scripts\engine\utility::ter_op(isDefined(var2), var2, var1));

    if(istrue(self.joinedinprogress) && scripts\mp\utility\game::onlinestatsenabled()) {
      var1 = game["end_reason"]["loss_stat_prevented"];
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

function splashshowncallback(var0, var1) {
  if(var0 != "splash_shown") {
    return;
  }

  var2 = tablelookupbyrow(getsplashtablename(), var1, 0);
  var3 = tablelookupbyrow(getsplashtablename(), var1, 6);

  switch (var3) {
    case "killstreak_splash":
      onkillstreaksplashshown(var2);
      break;
  }
}

function onkillstreaksplashshown(var0) {
  scripts\mp\utility\dialog::playkillstreakdialogonplayer(var0, "killstreak_earned", 1);
  thread checkforspecialistbonusvo(var0);
}

function checkforspecialistbonusvo(var0) {
  var1 = scripts\mp\perks\perks::getspecialistperkforstreak();

  if(var0 == "specialist_perk_bonus") {
    wait 2;
    level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "flavor_positive");
    return;
  }
}

function showerrormessage(var0, var1) {
  var2 = tablelookuprownum("mp/errorMessages.csv", 0, var0);

  if(isDefined(var1)) {
    self setclientomnvar("ui_mp_error_message_param", var1);
  } else {
    self setclientomnvar("ui_mp_error_message_param", -1);
  }

  self setclientomnvar("ui_mp_error_message_id", var2);

  if(!isDefined(self.errormessagebitflipper)) {
    self.errormessagebitflipper = 0;
  }

  self.errormessagebitflipper = !self.errormessagebitflipper;
  self setclientomnvar("ui_mp_error_trigger", scripts\engine\utility::ter_op(self.errormessagebitflipper, 2, 1));
}

function showerrormessagetoallplayers(var0, var1) {
  foreach(var3 in level.players) {
    showerrormessage(var0, var1);
  }
}

function testmiscmessage(var0) {
  var1 = tablelookuprownum("mp/miscMessages.csv", 0, var0);

  if(isDefined(var1) && var1 >= 0) {
    return true;
  }

  return false;
}

function showmiscmessage(var0) {
  var1 = tablelookuprownum("mp/miscMessages.csv", 0, var0);
  var2 = tablelookupbyrow("mp/miscMessages.csv", var1, 3);

  if(isDefined(var2) && var2 != "") {
    self playlocalsound(var2);
  }

  self setclientomnvar("ui_misc_message_id", var1);
  self setclientomnvar("ui_misc_message_trigger", 1);
}

function eventsplashesthink() {
  self endon("disconnect");

  if(!scripts\mp\utility\game::matchmakinggame()) {
    return;
  }

  var0 = 0;

  if(!isDefined(self.pers["hasSpawned"])) {
    var0 = 1;
  }

  var1 = getdvarint("OLLOKOKKSM", 0) == 1 || !isgamebattlematch();

  if(!var1) {
    var0 = 0;
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

  var2 = self getprivatepartysize() > 1;

  if(var0) {
    if(getdvarint("LKKNORQKTP") == 2 || var2 && getdvarint("NTLKOKLKRS") == 2 || self isps4player() && getdvarfloat("MPPRMTPSLT") == 2) {
      showsplash("event_double_xp");
    }

    if(getdvarint("PMORNPNTK") == 2 || var2 && getdvarint("LNQMMNNPSR") == 2) {
      showsplash("event_double_weapon_xp");
    }

    if(getdvarint("LTKKKPSRSK") == 2) {
      showsplash("event_double_battle_xp");
    }

    if(getdvarint("LPORTLTMNP") > 0) {
      showsplash("event_double_keys");
    }

    if(getdvarint("OMPLRMMKML") == 2 || var2 && getdvarint("NTPRTMORKK") == 2) {
      showsplash("event_double_xp_teams");
      return;
    }

    return;
  }
}

function notifyteam(var0, var1, var2, var3, var4, var5) {
  var6 = scripts\mp\utility\teams::getenemyteams(var2);

  foreach(var8 in level.players) {
    if(!scripts\mp\utility\player::isreallyalive(var8)) {
      continue;
    }

    if(var8.team == var2) {
      if(isDefined(var3)) {
        if(!scripts\engine\utility::array_contains(var3, var8)) {
          thread showsplash(var8, var0);
        }
      } else {
        thread showsplash(var8, var0);
      }

      continue;
    }

    foreach(var10 in var6) {
      if(var8.team == var10) {
        if(isDefined(var3)) {
          if(!scripts\engine\utility::array_contains(var3, var8)) {
            thread showsplash(var8, var1);
          }

          continue;
        }

        thread showsplash(var8, var1);
      }
    }
  }
}

function updatematchstatushintforallplayers(var0, var1, var2, var3, var4) {
  level notify("updateHint");
  level endon("updateHint");

  foreach(var6 in level.players) {
    if(isDefined(var0) && var6.team == var0) {
      if(isDefined(var3) && var6 == var3) {
        var6 setclientomnvar("ui_match_status_hint_text", var4);
      } else {
        var6 setclientomnvar("ui_match_status_hint_text", var1);
      }

      continue;
    }

    if(isDefined(var2)) {
      var6 setclientomnvar("ui_match_status_hint_text", var2);
    }
  }
}