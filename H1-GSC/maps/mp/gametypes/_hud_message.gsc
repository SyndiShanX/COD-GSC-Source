/**********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\gametypes\_hud_message.gsc
**********************************************/

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
  game["round_end"]["game_end"] = 14;
  game["round_end"]["spectator"] = 15;
  game["end_reason"]["score_limit_reached"] = 1;
  game["end_reason"]["time_limit_reached"] = 2;
  game["end_reason"]["players_forfeited"] = 3;
  game["end_reason"]["target_destroyed"] = 4;
  game["end_reason"]["bomb_defused"] = 5;
  game["end_reason"]["allies_eliminated"] = 6;
  game["end_reason"]["axis_eliminated"] = 7;
  game["end_reason"]["allies_forfeited"] = 8;
  game["end_reason"]["axis_forfeited"] = 9;
  game["end_reason"]["allies_mission_accomplished"] = 10;
  game["end_reason"]["axis_mission_accomplished"] = 11;
  game["end_reason"]["enemies_eliminated"] = 12;
  game["end_reason"]["tie"] = 13;
  game["end_reason"]["objective_completed"] = 14;
  game["end_reason"]["objective_failed"] = 15;
  game["end_reason"]["switching_sides"] = 16;
  game["end_reason"]["round_limit_reached"] = 17;
  game["end_reason"]["ended_game"] = 18;
  game["end_reason"]["host_ended_game"] = 19;
  game["end_reason"]["stat_loss_prevention"] = 20;
  game["end_reason"]["survivors_eliminated"] = 99;
  game["end_reason"]["zombies_completed"] = 99;
  game["end_reason"]["zombie_extraction_failed"] = 99;
  game["end_reason"]["survivors_eliminated"] = 99;
  game["end_reason"]["infected_eliminated"] = 99;
  game["end_reason"]["survivors_forfeited"] = 99;
  game["end_reason"]["infected_forfeited"] = 99;
  game["strings"]["overtime"] = & "MP_OVERTIME";
  level.lua_splash_type_none = 0;
  level.lua_splash_type_killstreak = 1;
  level.lua_splash_type_medal = 2;
  level.lua_splash_type_challenge = 3;
  level.lua_splash_type_rankup = 4;
  level.lua_splash_type_generic = 5;
  level thread onplayerconnect();
  setdvar("scr_lua_splashes", "1");
}

onplayerconnect() {
  for (;;) {
    level waittill("connected", var_0);
    var_0 thread lowermessagethink();
    var_0 thread initnotifymessage();
    var_0 thread manageluasplashtimers();
  }
}

hintmessage(var_0) {
  var_1 = spawnstruct();
  var_1.notifytext = var_0;
  notifymessage(var_1);
}

initnotifymessage() {
  if(level.splitscreen || self issplitscreenplayer()) {
    var_0 = 1.5;
    var_1 = 1.85;
    var_2 = 24;
    var_3 = "objective";
    var_4 = "TOP";
    var_5 = "BOTTOM";
    var_6 = 94;
    var_7 = 0;
  } else {
    var_0 = 2.5;
    var_1 = 1.35;
    var_2 = 30;
    var_3 = "objective";
    var_4 = "TOP";
    var_5 = "BOTTOM";
    var_6 = 94;
    var_7 = 0;
  }

  self.notifytitle = maps\mp\gametypes\_hud_util::createfontstring(var_3, var_0);
  self.notifytitle maps\mp\gametypes\_hud_util::setpoint(var_4, undefined, var_7, var_6);
  self.notifytitle.hidewheninmenu = 1;
  self.notifytitle.archived = 0;
  self.notifytitle.alpha = 0;
  self.notifytext = maps\mp\gametypes\_hud_util::createfontstring(var_3, var_1);
  self.notifytext maps\mp\gametypes\_hud_util::setparent(self.notifytitle);
  self.notifytext maps\mp\gametypes\_hud_util::setpoint(var_4, var_5, 0, 0);
  self.notifytext.hidewheninmenu = 1;
  self.notifytext.archived = 0;
  self.notifytext.alpha = 0;
  self.notifytext2 = maps\mp\gametypes\_hud_util::createfontstring(var_3, var_1);
  self.notifytext2 maps\mp\gametypes\_hud_util::setparent(self.notifytitle);
  self.notifytext2 maps\mp\gametypes\_hud_util::setpoint(var_4, var_5, 0, 0);
  self.notifytext2.hidewheninmenu = 1;
  self.notifytext2.archived = 0;
  self.notifytext2.alpha = 0;
  self.notifyicon = maps\mp\gametypes\_hud_util::createicon("white", var_2, var_2);
  self.notifyicon maps\mp\gametypes\_hud_util::setparent(self.notifytext2);
  self.notifyicon maps\mp\gametypes\_hud_util::setpoint(var_4, var_5, 0, 0);
  self.notifyicon.hidewheninmenu = 1;
  self.notifyicon.archived = 0;
  self.notifyicon.alpha = 0;
  self.notifyoverlay = maps\mp\gametypes\_hud_util::createicon("white", var_2, var_2);
  self.notifyoverlay maps\mp\gametypes\_hud_util::setparent(self.notifyicon);
  self.notifyoverlay maps\mp\gametypes\_hud_util::setpoint("CENTER", "CENTER", 0, 0);
  self.notifyoverlay.hidewheninmenu = 1;
  self.notifyoverlay.archived = 0;
  self.notifyoverlay.alpha = 0;
  self.doingsplash = [];
  self.doingsplash[0] = undefined;
  self.doingsplash[1] = undefined;
  self.doingsplash[2] = undefined;
  self.doingsplash[3] = undefined;
  self.splashqueue = [];
  self.splashqueue[0] = [];
  self.splashqueue[1] = [];
  self.splashqueue[2] = [];
  self.splashqueue[3] = [];
}

oldnotifymessage(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnstruct();
  var_6.titletext = var_0;
  var_6.notifytext = var_1;
  var_6.iconname = var_2;
  var_6.glowcolor = var_3;
  var_6.sound = var_4;
  var_6.duration = var_5;
  notifymessage(var_6);
}

notifymessage(var_0) {
  self endon("death");
  self endon("disconnect");

  if(!isdefined(var_0.slot))
    var_0.slot = 0;

  var_1 = var_0.slot;

  if(!isdefined(var_0.type))
    var_0.type = "";

  if(!isdefined(self.doingsplash[var_1])) {
    thread shownotifymessage(var_0);
    return;
  }

  self.splashqueue[var_1][self.splashqueue[var_1].size] = var_0;
}

dispatchnotify(var_0) {
  waittillframeend;
  var_1 = self.splashqueue[var_0][0];

  if(!isdefined(var_1)) {
    return;
  }
  for (var_2 = 1; var_2 < self.splashqueue[var_0].size; var_2++)
    self.splashqueue[var_0][var_2 - 1] = self.splashqueue[var_0][var_2];

  self.splashqueue[var_0][var_2 - 1] = undefined;

  if(isdefined(var_1.name))
    actionnotify(var_1);
  else
    shownotifymessage(var_1);
}

promotionsplashnotify() {
  if(!isplayer(self)) {
    return;
  }
  self endon("disconnect");
  var_0 = spawnstruct();
  var_1 = "promotion";
  var_0.name = var_1;
  var_0.type = tablelookup(get_table_name(), 0, var_1, 11);
  var_0.sound = tablelookup(get_table_name(), 0, var_1, 9);
  var_0.slot = 0;
  thread actionnotify(var_0);
}

shownotifymessage(var_0) {
  self endon("disconnect");

  if(maps\mp\_utility::is_true(var_0.resetondeath))
    self endon("death");

  var_1 = var_0.slot;

  if(level.gameended) {
    if(isdefined(var_0.type) && var_0.type == "rank") {
      self setclientdvar("ui_promotion", 1);
      self.postgamepromotion = 1;
    }

    if(self.splashqueue[var_1].size)
      thread dispatchnotify(var_1);

    return;
  }

  self.doingsplash[var_1] = var_0;

  if(maps\mp\_utility::is_true(var_0.resetondeath))
    thread resetondeath();

  thread resetoncancel();
  waitrequirevisibility(0);

  if(isdefined(var_0.duration))
    var_2 = var_0.duration;
  else if(level.gameended)
    var_2 = 2.0;
  else
    var_2 = 4.0;

  if(isdefined(var_0.sound))
    self playlocalsound(var_0.sound);

  if(isdefined(var_0.leadersound))
    maps\mp\_utility::leaderdialogonplayer(var_0.leadersound);

  var_3 = var_0.glowcolor;
  var_4 = self.notifytitle;

  if(isdefined(var_0.titletext)) {
    if(isdefined(var_0.titlelabel))
      self.notifytitle.label = var_0.titlelabel;
    else
      self.notifytitle.label = & "";

    if(isdefined(var_0.titlelabel) && !isdefined(var_0.titleisstring))
      self.notifytitle setvalue(var_0.titletext);
    else
      self.notifytitle settext(var_0.titletext);

    if(isdefined(var_3))
      self.notifytitle.glowcolor = var_3;

    self.notifytitle.alpha = 1;
    self.notifytitle fadeovertime(var_2 * 1.25);
    self.notifytitle.alpha = 0;
  }

  if(isdefined(var_0.textglowcolor))
    var_3 = var_0.textglowcolor;

  if(isdefined(var_0.notifytext)) {
    if(isdefined(var_0.textlabel))
      self.notifytext.label = var_0.textlabel;
    else
      self.notifytext.label = & "";

    if(isdefined(var_0.textlabel) && !isdefined(var_0.textisstring))
      self.notifytext setvalue(var_0.notifytext);
    else
      self.notifytext settext(var_0.notifytext);

    if(isdefined(var_3))
      self.notifytext.glowcolor = var_3;

    self.notifytext.alpha = 1;
    self.notifytext fadeovertime(var_2 * 1.25);
    self.notifytext.alpha = 0;
    var_4 = self.notifytext;
  }

  if(isdefined(var_0.notifytext2)) {
    self.notifytext2 maps\mp\gametypes\_hud_util::setparent(var_4);

    if(isdefined(var_0.text2label))
      self.notifytext2.label = var_0.text2label;
    else
      self.notifytext2.label = & "";

    self.notifytext2 settext(var_0.notifytext2);

    if(isdefined(var_3))
      self.notifytext2.glowcolor = var_3;

    self.notifytext2.alpha = 1;
    self.notifytext2 fadeovertime(var_2 * 1.25);
    self.notifytext2.alpha = 0;
    var_4 = self.notifytext2;
  }

  if(isdefined(var_0.iconname)) {
    self.notifyicon maps\mp\gametypes\_hud_util::setparent(var_4);

    if(level.splitscreen || self issplitscreenplayer())
      self.notifyicon setshader(var_0.iconname, 30, 30);
    else
      self.notifyicon setshader(var_0.iconname, 60, 60);

    self.notifyicon.alpha = 0;

    if(isdefined(var_0.iconoverlay)) {
      self.notifyicon fadeovertime(0.15);
      self.notifyicon.alpha = 1;
      var_0.overlayoffsety = 0;
      self.notifyoverlay maps\mp\gametypes\_hud_util::setparent(self.notifyicon);
      self.notifyoverlay maps\mp\gametypes\_hud_util::setpoint("CENTER", "CENTER", 0, var_0.overlayoffsety);
      self.notifyoverlay setshader(var_0.iconoverlay, 511, 511);
      self.notifyoverlay.alpha = 0;
      self.notifyoverlay.color = game["colors"]["orange"];
      self.notifyoverlay fadeovertime(0.4);
      self.notifyoverlay.alpha = 0.85;
      self.notifyoverlay scaleovertime(0.4, 32, 32);
      waitrequirevisibility(var_2);
      self.notifyicon fadeovertime(0.75);
      self.notifyicon.alpha = 0;
      self.notifyoverlay fadeovertime(0.75);
      self.notifyoverlay.alpha = 0;
    } else {
      self.notifyicon fadeovertime(1.0);
      self.notifyicon.alpha = 1;
      waitrequirevisibility(var_2);
      self.notifyicon fadeovertime(0.75);
      self.notifyicon.alpha = 0;
    }
  } else
    waitrequirevisibility(var_2);

  self notify("notifyMessageDone");
  self.doingsplash[var_1] = undefined;

  if(self.splashqueue[var_1].size)
    thread dispatchnotify(var_1);
}

coopkillstreaksplashnotify(var_0, var_1) {
  if(!isplayer(self)) {
    return;
  }
  self endon("disconnect");
  waittillframeend;

  if(level.gameended) {
    return;
  }
  var_2 = spawnstruct();
  var_2.name = var_0;
  var_2.type = tablelookup(get_table_name(), 0, var_0, 11);
  var_2.optionalnumber = 0;
  var_2.sound = tablelookup(get_table_name(), 0, var_0, 9);
  var_2.leadersound = var_1;
  var_2.slot = 0;
  thread actionnotify(var_2);
}

killstreaksplashnotify(var_0, var_1, var_2, var_3, var_4) {
  if(!isplayer(self)) {
    return;
  }
  self endon("disconnect");
  waittillframeend;

  if(!isdefined(self)) {
    return;
  }
  if(level.gameended) {
    return;
  }
  if(isdefined(var_2))
    var_0 = var_0 + ("_" + var_2);

  if(!isdefined(var_4))
    var_4 = -1;

  if(getdvarint("scr_lua_splashes")) {
    var_5 = tablelookuprownum("mp\splashTable.csv", 0, var_0);

    if(var_5 >= 0) {
      self luinotifyevent(&"killstreak_splash", 3, var_5, var_1, var_4);
      self luinotifyeventtospectators(&"killstreak_splash", 3, var_5, var_1, var_4);
      insertluasplash(level.lua_splash_type_killstreak, var_5);
    }

    return;
  }

  var_6 = spawnstruct();
  var_6.name = var_0;
  var_6.type = tablelookup(get_table_name(), 0, var_0, 11);
  var_6.optionalnumber = var_1;
  var_6.sound = maps\mp\_utility::getkillstreaksound(var_0);
  var_6.leadersound = var_0;
  var_6.leadersoundgroup = "killstreak_earned";
  var_6.slot = 0;
  var_6.killstreakslot = var_4;

  if(isdefined(var_3) && isarray(var_3)) {
    if(var_3.size > 0)
      var_6.module1idx = tablelookuprownum(level.ks_modules_table, level.ks_module_ref_column, var_3[0]);

    if(var_3.size > 1)
      var_6.module2idx = tablelookuprownum(level.ks_modules_table, level.ks_module_ref_column, var_3[1]);

    if(var_3.size > 2)
      var_6.module3idx = tablelookuprownum(level.ks_modules_table, level.ks_module_ref_column, var_3[2]);
  }

  thread actionnotify(var_6);
}

challengesplashnotify(var_0, var_1, var_2) {
  if(!isplayer(self)) {
    return;
  }
  self endon("disconnect");
  waittillframeend;
  wait 0.05;

  for (var_3 = var_2 - 1; var_3 >= var_1; var_3--) {
    var_4 = maps\mp\gametypes\_hud_util::ch_gettarget(var_0, var_3);

    if(var_4 == 0)
      var_4 = 1;

    if(var_0 == "ch_longersprint_pro" || var_0 == "ch_longersprint_pro_daily" || var_0 == "ch_longersprint_pro_weekly")
      var_4 = int(var_4 / 528);
    else if(var_0 == "ch_exomech_frontier")
      var_4 = int(var_4 / 528);

    if(getdvarint("scr_lua_splashes")) {
      var_5 = tablelookup("mp\allChallengesTable.csv", 0, var_0, 28);

      if(var_5 != "") {
        var_6 = int(var_5);
        self luinotifyevent(&"challenge_splash", 3, var_6, var_3, var_4);
        self luinotifyeventtospectators(&"challenge_splash", 3, var_6, var_3, var_4);
        insertluasplash(level.lua_splash_type_challenge, var_6);
      }

      continue;
    }

    var_7 = spawnstruct();
    var_7.name = var_0;
    var_7.type = tablelookup(get_table_name(), 0, var_0, 11);
    var_7.challengetier = var_3;
    var_7.optionalnumber = var_4;
    var_7.sound = tablelookup(get_table_name(), 0, var_0, 9);
    var_7.slot = 0;
    thread actionnotify(var_7);
  }
}

medalsplashnotify(var_0) {
  if(getdvarint("scr_lua_splashes")) {
    var_1 = tablelookuprownum("mp\splashTable.csv", 0, var_0);

    if(var_1 >= 0) {
      self luinotifyevent(&"medal_splash", 1, var_1);
      self luinotifyeventtospectators(&"medal_splash", 1, var_1);
      insertluasplash(level.lua_splash_type_medal, var_1);
      return;
    }
  } else
    splashnotify(var_0);
}

splashnotify(var_0, var_1, var_2) {
  if(!isplayer(self)) {
    return;
  }
  if(getdvarint("scr_lua_splashes")) {
    var_3 = tablelookuprownum("mp\splashTable.csv", 0, var_0);

    if(var_3 >= 0) {
      if(isdefined(var_1)) {
        self luinotifyevent(&"generic_splash_number", 2, var_3, var_1);
        self luinotifyeventtospectators(&"generic_splash_number", 2, var_3, var_1);
      } else {
        self luinotifyevent(&"generic_splash", 1, var_3);
        self luinotifyeventtospectators(&"generic_splash", 1, var_3);
      }

      insertluasplash(level.lua_splash_type_generic, var_3);
    }

    return;
  }

  self endon("disconnect");
  wait 0.05;
  var_4 = spawnstruct();
  var_4.name = var_0;
  var_4.type = tablelookup(get_table_name(), 0, var_0, 11);
  var_4.optionalnumber = var_1;
  var_4.sound = tablelookup(get_table_name(), 0, var_4.name, 9);

  if(!isdefined(var_2))
    var_2 = -1;

  var_4.killstreakslot = var_2;
  var_4.slot = 0;
  thread actionnotify(var_4);
}

rankupsplashnotify(var_0, var_1, var_2) {
  if(!isplayer(self)) {
    return;
  }
  self endon("disconnect");
  waittillframeend;

  if(!isdefined(self)) {
    return;
  }
  if(level.gameended) {
    return;
  }
  if(getdvarint("scr_lua_splashes")) {
    var_3 = tablelookuprownum("mp\splashTable.csv", 0, var_0);

    if(var_3 >= 0) {
      self luinotifyevent(&"rankup_splash", 3, var_3, var_1, var_2);
      self luinotifyeventtospectators(&"rankup_splash", 3, var_3, var_1, var_2);
      insertluasplash(level.lua_splash_type_rankup, var_3);
    }

    return;
  }

  var_4 = spawnstruct();
  var_4.name = var_0;
  var_4.type = tablelookup(get_table_name(), 0, var_0, 11);
  var_4.sound = tablelookup(get_table_name(), 0, var_0, 9);
  var_4.rank = var_1;
  var_4.prestige = var_2;
  var_4.slot = 0;
  thread actionnotify(var_4);
}

playercardsplashnotify(var_0, var_1, var_2) {
  if(!isplayer(self)) {
    return;
  }
  self endon("disconnect");
  waittillframeend;

  if(!isdefined(self)) {
    return;
  }
  if(level.gameended) {
    return;
  }
  var_3 = spawnstruct();
  var_3.name = var_0;
  var_3.type = tablelookup(get_table_name(), 0, var_0, 11);
  var_3.optionalnumber = var_2;
  var_3.sound = tablelookup(get_table_name(), 0, var_0, 9);
  var_3.playercardplayer = var_1;
  var_3.slot = 0;

  if(var_3.type == "playercard_splash")
    var_3.slot = 1;

  thread actionnotify(var_3);
}

actionnotify(var_0) {
  self endon("death");
  self endon("disconnect");
  var_1 = var_0.slot;

  if(!isdefined(var_0.type))
    var_0.type = "";

  if(!isdefined(self.doingsplash[var_1])) {
    thread actionnotifymessage(var_0);
    return;
  } else {
    switch (var_0.type) {
      case "urgent_splash":
        self.notifytext.alpha = 0;
        self.notifytext2.alpha = 0;
        self.notifyicon.alpha = 0;
        self setclientomnvar("ui_splash_idx", -1);
        self setclientomnvar("ui_splash_killstreak_mod_1", -1);
        self setclientomnvar("ui_splash_killstreak_mod_2", -1);
        self setclientomnvar("ui_splash_killstreak_mod_3", -1);
        self setclientomnvar("ui_splash_killstreak_idx", -1);
        thread actionnotifymessage(var_0);
        return;
      case "killstreak_coop_splash":
      case "killstreak_splash":
      case "splash":
        if(self.doingsplash[var_1].type != "splash" && self.doingsplash[var_1].type != "urgent_splash" && self.doingsplash[var_1].type != "killstreak_coop_splash" && self.doingsplash[var_1].type != "killstreak_splash" && self.doingsplash[var_1].type != "challenge_splash" && self.doingsplash[var_1].type != "promotion_splash" && self.doingsplash[var_1].type != "intel_splash" && self.doingsplash[var_1].type != "rankup_splash") {
          self.notifytext.alpha = 0;
          self.notifytext2.alpha = 0;
          self.notifyicon.alpha = 0;
          thread actionnotifymessage(var_0);
          return;
        }

        break;
    }
  }

  if(var_0.type == "challenge_splash" || var_0.type == "killstreak_splash" || var_0.type == "killstreak_coop_splash") {
    for (var_2 = self.splashqueue[var_1].size; var_2 > 0; var_2--)
      self.splashqueue[var_1][var_2] = self.splashqueue[var_1][var_2 - 1];

    self.splashqueue[var_1][0] = var_0;
  } else
    self.splashqueue[var_1][self.splashqueue[var_1].size] = var_0;
}

actionnotifymessage(var_0) {
  self endon("disconnect");
  var_1 = var_0.slot;

  if(level.gameended) {
    if(isdefined(var_0.type) && (var_0.type == "promotion_splash" || var_0.type == "promotion_weapon_splash")) {
      self setclientdvar("ui_promotion", 1);
      self.postgamepromotion = 1;
    } else if(isdefined(var_0.type) && var_0.type == "challenge_splash") {
      self.pers["postGameChallenges"]++;
      self setclientdvar("ui_challenge_" + self.pers["postGameChallenges"] + "_ref", var_0.name);
    }

    if(self.splashqueue[var_1].size)
      thread dispatchnotify(var_1);

    return;
  }

  if(tablelookup(get_table_name(), 0, var_0.name, 0) != "") {
    var_2 = tablelookuprownum(get_table_name(), 0, var_0.name);
    var_3 = maps\mp\_utility::stringtofloat(tablelookupbyrow(get_table_name(), var_2, 4));

    switch (var_0.type) {
      case "killstreak_coop_splash":
      case "killstreak_splash":
        if(isdefined(var_0.killstreakslot) && !level.console)
          self setclientomnvar("ui_splash_killstreak_slot_idx", var_0.killstreakslot);

        self setclientomnvar("ui_splash_killstreak_idx", var_2);

        if(isdefined(var_0.playercardplayer) && var_0.playercardplayer != self)
          self setclientomnvar("ui_splash_killstreak_clientnum", var_0.playercardplayer getentitynumber());
        else
          self setclientomnvar("ui_splash_killstreak_clientnum", -1);

        if(isdefined(var_0.optionalnumber))
          self setclientomnvar("ui_splash_killstreak_optional_number", var_0.optionalnumber);
        else
          self setclientomnvar("ui_splash_killstreak_optional_number", 0);

        if(isdefined(var_0.module1idx))
          self setclientomnvar("ui_splash_killstreak_mod_1", var_0.module1idx);
        else
          self setclientomnvar("ui_splash_killstreak_mod_1", -1);

        if(isdefined(var_0.module2idx))
          self setclientomnvar("ui_splash_killstreak_mod_2", var_0.module2idx);
        else
          self setclientomnvar("ui_splash_killstreak_mod_2", -1);

        if(isdefined(var_0.module3idx))
          self setclientomnvar("ui_splash_killstreak_mod_3", var_0.module3idx);
        else
          self setclientomnvar("ui_splash_killstreak_mod_3", -1);

        break;
      case "playercard_splash":
        if(isdefined(var_0.playercardplayer)) {
          self setclientomnvar("ui_splash_playercard_idx", var_2);

          if(isplayer(var_0.playercardplayer))
            self setclientomnvar("ui_splash_playercard_clientnum", var_0.playercardplayer getentitynumber());

          if(isdefined(var_0.optionalnumber))
            self setclientomnvar("ui_splash_playercard_optional_number", var_0.optionalnumber);
        }

        break;
      case "intel_splash":
      case "urgent_splash":
      case "splash":
        self setclientomnvar("ui_splash_idx", var_2);

        if(isdefined(var_0.optionalnumber))
          self setclientomnvar("ui_splash_optional_number", var_0.optionalnumber);

        break;
      case "rankup_splash":
        self setclientomnvar("ui_rankup_splash_idx", var_2);

        if(isdefined(var_0.rank))
          self setclientomnvar("ui_rank_splash_rank", var_0.rank);

        if(isdefined(var_0.prestige))
          self setclientomnvar("ui_rank_splash_prestige", var_0.prestige);

        break;
      case "perk_challenge_splash":
      case "challenge_splash":
        var_2 = int(tablelookup("mp\allchallengestable.csv", 0, var_0.name, 28));
        self setclientomnvar("ui_challenge_splash_idx", var_2);

        if(isdefined(var_0.challengetier))
          self setclientomnvar("ui_challenge_splash_tier", var_0.challengetier);

        if(isdefined(var_0.optionalnumber))
          self setclientomnvar("ui_challenge_splash_optional_number", var_0.optionalnumber);

        break;
      default:
        break;
    }

    self.doingsplash[var_1] = var_0;

    if(isdefined(var_0.sound) && var_0.sound != "")
      self playlocalsound(var_0.sound);

    if(isdefined(var_0.leadersound)) {
      if(isdefined(var_0.leadersoundgroup))
        maps\mp\_utility::leaderdialogonplayer(var_0.leadersound, var_0.leadersoundgroup, 1);
      else
        maps\mp\_utility::leaderdialogonplayer(var_0.leadersound);
    }

    self notify("actionNotifyMessage" + var_1);
    self endon("actionNotifyMessage" + var_1);
    wait(var_3 + 0.5);
    self.doingsplash[var_1] = undefined;
  }

  if(self.splashqueue[var_1].size)
    thread dispatchnotify(var_1);
}

waitrequirevisibility(var_0) {
  var_1 = 0.05;

  while (!canreadtext())
    wait(var_1);

  while (var_0 > 0) {
    wait(var_1);

    if(canreadtext())
      var_0 = var_0 - var_1;
  }
}

canreadtext() {
  if(maps\mp\_flashgrenades::isflashbanged())
    return 0;

  return 1;
}

resetondeath() {
  self endon("notifyMessageDone");
  self endon("disconnect");
  self waittill("death");
  resetnotify();
}

resetoncancel() {
  self notify("resetOnCancel");
  self endon("resetOnCancel");
  self endon("notifyMessageDone");
  self endon("disconnect");
  level waittill("cancel_notify");
  resetnotify();
}

resetnotify() {
  self.notifytitle fadeovertime(0.05);
  self.notifytitle.alpha = 0;
  self.notifytext.alpha = 0;
  self.notifyicon.alpha = 0;
  self.notifyoverlay.alpha = 0;
  self.doingsplash[0] = undefined;
  self.doingsplash[1] = undefined;
  self.doingsplash[2] = undefined;
  self.doingsplash[3] = undefined;
}

lowermessagethink() {
  self endon("disconnect");
  self.lowermessages = [];
  var_0 = "objective";

  if(isdefined(level.lowermessagefont))
    var_0 = level.lowermessagefont;

  var_1 = -140;
  var_2 = level.lowertextfontsize;
  var_3 = 1.25;

  if(level.splitscreen || self issplitscreenplayer() && !isai(self)) {
    var_2 = level.lowertextfontsize * 1.4;
    var_3 = var_3 * 1.5;
  }

  self.lowermessage = maps\mp\gametypes\_hud_util::createfontstring(var_0, var_2);
  self.lowermessage settext("");
  self.lowermessage.archived = 0;
  self.lowermessage.sort = 10;
  self.lowermessage.showinkillcam = 0;
  self.lowermessage maps\mp\gametypes\_hud_util::setpoint("CENTER", level.lowertextyalign, 0, var_1);
  self.lowertimer = maps\mp\gametypes\_hud_util::createfontstring("default", var_3);
  self.lowertimer maps\mp\gametypes\_hud_util::setparent(self.lowermessage);
  self.lowertimer maps\mp\gametypes\_hud_util::setpoint("TOP", "BOTTOM", 0, 0);
  self.lowertimer settext("");
  self.lowertimer.archived = 0;
  self.lowertimer.sort = 10;
  self.lowertimer.showinkillcam = 0;
}

outcomeoverlay(var_0) {
  if(level.teambased) {
    if(var_0 == "tie")
      matchoutcomenotify("draw");
    else if(var_0 == self.team)
      matchoutcomenotify("victory");
    else
      matchoutcomenotify("defeat");
  } else if(var_0 == self)
    matchoutcomenotify("victory");
  else
    matchoutcomenotify("defeat");
}

matchoutcomenotify(var_0) {
  var_1 = self.team;
  var_2 = maps\mp\gametypes\_hud_util::createfontstring("bigfixed", 1.0);
  var_2 maps\mp\gametypes\_hud_util::setpoint("TOP", undefined, 0, 50);
  var_2.foreground = 1;
  var_2.glowalpha = 1;
  var_2.hidewheninmenu = 0;
  var_2.archived = 0;
  var_2 settext(game["strings"][var_0]);
  var_2.alpha = 0;
  var_2 fadeovertime(0.5);
  var_2.alpha = 1;

  switch (var_0) {
    case "victory":
      var_2.glowcolor = game["colors"]["cyan"];
      break;
    default:
      var_2.glowcolor = game["colors"]["orange"];
      break;
  }

  var_3 = maps\mp\gametypes\_hud_util::createicon(game["icons"][var_1], 64, 64);
  var_3 maps\mp\gametypes\_hud_util::setparent(var_2);
  var_3 maps\mp\gametypes\_hud_util::setpoint("TOP", "BOTTOM", 0, 30);
  var_3.foreground = 1;
  var_3.hidewheninmenu = 0;
  var_3.archived = 0;
  var_3.alpha = 0;
  var_3 fadeovertime(0.5);
  var_3.alpha = 1;
  wait 3.0;
  var_2 maps\mp\gametypes\_hud_util::destroyelem();
  var_3 maps\mp\gametypes\_hud_util::destroyelem();
}

isdoingsplash() {
  if(isdefined(self.doingsplash)) {
    if(isdefined(self.doingsplash[0]))
      return 1;

    if(isdefined(self.doingsplash[1]))
      return 1;

    if(isdefined(self.doingsplash[2]))
      return 1;

    if(isdefined(self.doingsplash[3]))
      return 1;
  }

  if(isdoingluasplash())
    return 1;

  return 0;
}

teamoutcomenotify(var_0, var_1, var_2, var_3) {
  self endon("disconnect");
  self notify("reset_outcome");
  thread lerpscreenblurup(32, 1);
  wait 0.5;
  var_4 = self.pers["team"];

  if(!isdefined(var_4) || var_4 != "allies" && var_4 != "axis")
    var_4 = "allies";

  while (isdoingsplash())
    wait 0.05;

  self endon("reset_outcome");
  var_5 = 0;

  if(level.gametype == "ctf" && isdefined(var_3) && var_3)
    var_5 = 1;

  if(var_0 == "halftime") {
    self setclientomnvar("ui_round_end_title", game["round_end"]["halftime"]);
    var_0 = "allies";

    if(level.gametype == "ctf")
      var_5 = 1;
  } else if(var_0 == "intermission") {
    self setclientomnvar("ui_round_end_title", game["round_end"]["intermission"]);
    var_0 = "allies";
  } else if(var_0 == "roundend") {
    self setclientomnvar("ui_round_end_title", game["round_end"]["roundend"]);
    var_0 = "allies";
  } else if(maps\mp\_utility::isovertimetext(var_0)) {
    self setclientomnvar("ui_round_end_title", game["round_end"]["overtime"]);

    if(level.gametype == "ctf" && var_0 == "overtime")
      var_5 = 1;

    var_0 = "allies";
  } else if(var_0 == "tie") {
    if(var_1)
      self setclientomnvar("ui_round_end_title", game["round_end"]["round_draw"]);
    else
      self setclientomnvar("ui_round_end_title", game["round_end"]["draw"]);

    var_0 = "allies";
  } else if(self ismlgspectator())
    self setclientomnvar("ui_round_end_title", game["round_end"]["spectator"]);
  else if(isdefined(self.pers["team"]) && var_0 == var_4) {
    if(var_1)
      self setclientomnvar("ui_round_end_title", game["round_end"]["round_win"]);
    else
      self setclientomnvar("ui_round_end_title", game["round_end"]["victory"]);
  } else if(var_1)
    self setclientomnvar("ui_round_end_title", game["round_end"]["round_loss"]);
  else
    self setclientomnvar("ui_round_end_title", game["round_end"]["defeat"]);

  self setclientomnvar("ui_round_end_reason", var_2);

  if(var_5 && !level.winbycaptures) {
    self setclientomnvar("ui_round_end_friendly_score", game["roundsWon"][var_4]);
    self setclientomnvar("ui_round_end_enemy_score", game["roundsWon"][level.otherteam[var_4]]);
  } else if(!maps\mp\_utility::isroundbased() || !maps\mp\_utility::isobjectivebased()) {
    self setclientomnvar("ui_round_end_friendly_score", maps\mp\gametypes\_gamescore::_getteamscore(var_4));
    self setclientomnvar("ui_round_end_enemy_score", maps\mp\gametypes\_gamescore::_getteamscore(level.otherteam[var_4]));
  } else {
    self setclientomnvar("ui_round_end_friendly_score", game["roundsWon"][var_4]);
    self setclientomnvar("ui_round_end_enemy_score", game["roundsWon"][level.otherteam[var_4]]);
  }

  if(isdefined(self.matchbonus))
    self setclientomnvar("ui_round_end_match_bonus", self.matchbonus);

  if(isdefined(game["round_time_to_beat"]))
    self setclientomnvar("ui_round_end_stopwatch", int(game["round_time_to_beat"] * 60));

  self setclientomnvar("ui_round_end", 1);
}

outcomenotify(var_0, var_1) {
  self endon("disconnect");
  self notify("reset_outcome");

  while (isdoingsplash())
    wait 0.05;

  self endon("reset_outcome");
  var_2 = level.placement["all"];
  var_3 = var_2[0];
  var_4 = var_2[1];
  var_5 = var_2[2];
  var_6 = 0;

  if(isdefined(var_3) && self.score == var_3.score && self.deaths == var_3.deaths) {
    if(self != var_3)
      var_6 = 1;
    else if(isdefined(var_4) && var_4.score == var_3.score && var_4.deaths == var_3.deaths)
      var_6 = 1;
  }

  if(var_6)
    self setclientomnvar("ui_round_end_title", game["round_end"]["tie"]);
  else if(isdefined(var_3) && self == var_3)
    self setclientomnvar("ui_round_end_title", game["round_end"]["victory"]);
  else
    self setclientomnvar("ui_round_end_title", game["round_end"]["defeat"]);

  self setclientomnvar("ui_round_end_reason", var_1);

  if(isdefined(self.matchbonus))
    self setclientomnvar("ui_round_end_match_bonus", self.matchbonus);

  self setclientomnvar("ui_round_end", 1);
  self waittill("update_outcome");
}

canshowsplash(var_0) {}

lerpscreenblurup(var_0, var_1) {
  self setblurforplayer(var_0, var_1);
}

get_table_name() {
  return "mp\splashTable.csv";
}

isdoingluasplash() {
  return maps\mp\_utility::is_true(self.luasplashactive);
}

manageluasplashtimers() {
  self endon("disconnect");
  self.luasplashactive = 0;
  self.luasplashqueue = [];
  self.luasplashcurrenttype = level.lua_splash_type_none;
  self.luasplashnextintrocompletetime = 0;
  self.luasplashnextoutrocompletetime = 0;

  for (;;) {
    if(!self.luasplashqueue.size)
      self waittill("luaSplashTimerUpdate");

    if(!self.luasplashqueue.size) {
      continue;
    }
    var_0 = self.luasplashqueue[0];
    self.luasplashqueue = maps\mp\_utility::array_remove_index(self.luasplashqueue, 0);
    self.luasplashcurrenttype = var_0.splashtype;

    if(var_0.splashtype == level.lua_splash_type_killstreak) {
      var_1 = int(1000.0 * float(tablelookupbyrow("mp\splashTable.csv", var_0.splashdata, 4)));

      if(!var_1) {
        continue;
      }
      self.luasplashnextintrocompletetime = gettime() + var_1;
      self.luasplashnextoutrocompletetime = gettime() + var_1;
    } else if(var_0.splashtype == level.lua_splash_type_medal) {
      var_1 = int(1000.0 * float(tablelookupbyrow("mp\splashTable.csv", var_0.splashdata, 4)));

      if(!var_1) {
        continue;
      }
      self.luasplashnextintrocompletetime = gettime() + 250;
      self.luasplashnextoutrocompletetime = gettime() + var_1;
    } else if(var_0.splashtype == level.lua_splash_type_challenge) {
      var_2 = tablelookup("mp\allchallengestable.csv", 28, var_0.splashdata, 0);

      if(var_2 == "") {
        continue;
      }
      var_1 = int(1000.0 * float(tablelookup("mp\splashTable.csv", 0, var_2, 4)));

      if(!var_1) {
        continue;
      }
      self.luasplashnextintrocompletetime = gettime() + var_1;
      self.luasplashnextoutrocompletetime = gettime() + var_1;
    } else if(var_0.splashtype == level.lua_splash_type_rankup) {
      var_1 = int(1000.0 * float(tablelookupbyrow("mp\splashTable.csv", var_0.splashdata, 4)));

      if(!var_1) {
        continue;
      }
      self.luasplashnextintrocompletetime = gettime() + var_1;
      self.luasplashnextoutrocompletetime = gettime() + var_1;
    } else {
      var_1 = int(1000.0 * float(tablelookupbyrow("mp\splashTable.csv", var_0.splashdata, 4)));

      if(!var_1) {
        continue;
      }
      self.luasplashnextintrocompletetime = gettime() + 250;
      self.luasplashnextoutrocompletetime = gettime() + var_1;
    }

    self.luasplashactive = 1;

    if(gettime() < self.luasplashnextintrocompletetime) {
      var_3 = (self.luasplashnextintrocompletetime - gettime()) * 0.001;
      wait(var_3);
    }

    while (gettime() < self.luasplashnextoutrocompletetime) {
      if(self.luasplashqueue.size > 0) {
        if(self.luasplashcurrenttype == level.lua_splash_type_none || self.luasplashqueue[0].splashtype == self.luasplashcurrenttype) {
          break;
        }
      }

      var_3 = (self.luasplashnextoutrocompletetime - gettime()) * 0.001;
      common_scripts\utility::waittill_notify_or_timeout("luaSplashTimerUpdate", var_3);
    }

    self.luasplashactive = 0;
  }
}

insertluasplash(var_0, var_1) {
  if(!isdefined(self.luasplashqueue)) {
    return;
  }
  if(var_0 == level.lua_splash_type_medal) {
    for (var_2 = 0; var_2 < self.luasplashqueue.size; var_2++) {
      if(self.luasplashqueue[var_2].splashtype == var_0 && self.luasplashqueue[var_2].splashdata == var_1)
        return;
    }
  }

  var_3 = spawnstruct();
  var_3.splashtype = var_0;
  var_3.splashdata = var_1;

  if(var_0 == level.lua_splash_type_killstreak) {
    var_4 = undefined;

    for (var_2 = 0; var_2 < self.luasplashqueue.size; var_2++) {
      if(self.luasplashqueue[var_2].splashtype != level.lua_splash_type_killstreak) {
        var_4 = var_2;
        break;
      }
    }

    if(isdefined(var_4)) {
      self.luasplashqueue = common_scripts\utility::array_insert(self.luasplashqueue, var_3, var_4);
      self notify("luaSplashTimerUpdate");
      return;
    }
  }

  self.luasplashqueue[self.luasplashqueue.size] = var_3;
  self notify("luaSplashTimerUpdate");
}