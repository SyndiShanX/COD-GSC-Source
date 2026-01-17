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
  game["end_reason"]["survivors_eliminated"] = 21;
  game["end_reason"]["infected_eliminated"] = 22;
  game["end_reason"]["survivors_forfeited"] = 23;
  game["end_reason"]["infected_forfeited"] = 24;
  game["strings"]["overtime"] = &"MP_OVERTIME";
  level.lua_splash_type_none = 0;
  level.lua_splash_type_killstreak = 1;
  level.lua_splash_type_medal = 2;
  level.lua_splash_type_challenge = 3;
  level.lua_splash_type_rankup = 4;
  level.lua_splash_type_generic = 5;
  level.lua_splash_type_playercard = 6;
  level.lua_splash_type_deathstreak = 7;
  level thread onplayerconnect();
  setdvar("scr_lua_splashes", "1");
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread lowermessagethink();
    var_0 thread initnotifymessage();
    var_0 thread manageluasplashtimers();
  }
}

hintmessage(var_0) {
  var_1 = spawnStruct();
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
  var_6 = spawnStruct();
  var_6.titletext = var_0;
  var_6.notifytext = var_1;
  var_6.iconname = var_2;
  var_6.glowcolor = var_3;
  var_6.sound = var_4;
  var_6.duration = var_5;
  notifymessage(var_6);
}

notifyMessage(notifyData) {
  self endon("death");
  self endon("disconnect");

  if(!isDefined(notifyData.slot))
    notifyData.slot = 0;

  slot = notifyData.slot;

  if(!isDefined(notifyData.type))
    notifyData.type = "";

  if(!isDefined(self.doingSplash[slot])) {
    self thread showNotifyMessage(notifyData);
    return;
  }

  self.splashQueue[slot][self.splashQueue[slot].size] = notifyData;
}

dispatchNotify(slot) {
  waittillframeend;
  nextNotifyData = self.splashQueue[slot][0];

  if(!isDefined(nextNotifyData)) {
    return;
  }
  for(i = 1; i < self.splashQueue[slot].size; i++)
    self.splashQueue[slot][i - 1] = self.splashQueue[slot][i];

  self.splashQueue[slot][i - 1] = undefined;

  if(isDefined(nextNotifyData.name))
    actionNotify(nextNotifyData);
  else
    showNotifyMessage(nextNotifyData);
}

shownotifymessage(notifyData) {
  self endon("disconnect");

  if(maps\mp\_utility::is_true(notifyData.resetondeath))
    self endon("death");

  assert(isDefined(notifyData.slot));
  slot = notifyData.slot;

  if(level.gameEnded) {
    if(isDefined(notifyData.type) && notifyData.type == "rank") {
      self setClientDvar("ui_promotion", 1);
      self.postGamePromotion = true;
    }

    if(self.splashQueue[slot].size)
      self thread dispatchNotify(slot);

    return;
  }

  self.doingsplash[slot] = notifyData;

  if(maps\mp\_utility::is_true(notifyData.resetondeath))
    thread resetondeath();

  thread resetoncancel();
  waitrequirevisibility(0);

  if(isDefined(notifyData.duration))
    duration = notifyData.duration;
  else if(level.gameended)
    duration = 2.0;
  else
    duration = 4.0;

  if(isDefined(notifyData.sound))
    self playlocalsound(notifyData.sound);

  if(isDefined(notifyData.leadersound))
    maps\mp\_utility::leaderdialogonplayer(notifyData.leadersound);

  var_3 = notifyData.glowcolor;
  var_4 = self.notifytitle;

  if(isDefined(notifyData.titletext)) {
    self.notifytitle.font = "objective";
    self.notifytitle.fontScale = 2.5;

    if(isDefined(notifyData.titlelabel))
      self.notifytitle.label = notifyData.titlelabel;
    else
      self.notifytitle.label = &"";

    if(isDefined(notifyData.titlelabel) && !isDefined(notifyData.titleisstring))
      self.notifytitle setvalue(notifyData.titletext);
    else
      self.notifytitle settext(notifyData.titletext);

    if(isDefined(var_3))
      self.notifytitle.glowcolor = var_3;

    self.notifytitle.alpha = 1;
    self.notifytitle fadeovertime(duration * 1.25);
    self.notifytitle.alpha = 0;
  }

  if(isDefined(notifyData.textglowcolor))
    var_3 = notifyData.textglowcolor;

  if(isDefined(notifyData.notifytext)) {
    self.notifytext.font = "objective";
    self.notifytext.fonScale = 1.35;
    if(isDefined(notifyData.textlabel))
      self.notifytext.label = notifyData.textlabel;
    else
      self.notifytext.label = &"";

    if(isDefined(notifyData.textlabel) && !isDefined(notifyData.textisstring))
      self.notifytext setvalue(notifyData.notifytext);
    else
      self.notifytext settext(notifyData.notifytext);

    if(isDefined(var_3))
      self.notifytext.glowcolor = var_3;

    self.notifytext.alpha = 1;
    self.notifytext fadeovertime(duration * 1.25);
    self.notifytext.alpha = 0;
    var_4 = self.notifytext;
  }

  if(isDefined(notifyData.notifytext2)) {
    self.notifytext2 maps\mp\gametypes\_hud_util::setparent(var_4);

    if(isDefined(notifyData.text2label))
      self.notifytext2.label = notifyData.text2label;
    else
      self.notifytext2.label = &"";

    self.notifytext2 settext(notifyData.notifytext2);

    if(isDefined(var_3))
      self.notifytext2.glowcolor = var_3;

    self.notifytext2.alpha = 1;
    self.notifytext2 fadeovertime(duration * 1.25);
    self.notifytext2.alpha = 0;
    var_4 = self.notifytext2;
  }

  if(isDefined(notifyData.iconname)) {
    self.notifyicon maps\mp\gametypes\_hud_util::setparent(var_4);

    if(level.splitscreen || self issplitscreenplayer())
      self.notifyicon setshader(notifyData.iconname, 30, 30);
    else
      self.notifyicon setshader(notifyData.iconname, 60, 60);

    self.notifyicon.alpha = 0;

    if(isDefined(notifyData.iconoverlay)) {
      self.notifyicon fadeovertime(0.15);
      self.notifyicon.alpha = 1;
      notifyData.overlayoffsety = 0;
      self.notifyoverlay maps\mp\gametypes\_hud_util::setparent(self.notifyicon);
      self.notifyoverlay maps\mp\gametypes\_hud_util::setpoint("CENTER", "CENTER", 0, notifyData.overlayoffsety);
      self.notifyoverlay setshader(notifyData.iconoverlay, 511, 511);
      self.notifyoverlay.alpha = 0;
      self.notifyoverlay.color = game["colors"]["orange"];
      self.notifyoverlay fadeovertime(0.4);
      self.notifyoverlay.alpha = 0.85;
      self.notifyoverlay scaleovertime(0.4, 32, 32);
      waitrequirevisibility(duration);
      self.notifyicon fadeovertime(0.75);
      self.notifyicon.alpha = 0;
      self.notifyoverlay fadeovertime(0.75);
      self.notifyoverlay.alpha = 0;
    } else {
      self.notifyicon fadeovertime(1.0);
      self.notifyicon.alpha = 1;
      waitrequirevisibility(duration);
      self.notifyicon fadeovertime(0.75);
      self.notifyicon.alpha = 0;
    }
  } else
    waitrequirevisibility(duration);

  self notify("notifyMessageDone");
  self.doingsplash[slot] = undefined;

  if(self.splashqueue[slot].size)
    thread dispatchnotify(slot);
}

killstreaksplashnotify(var_0, var_1, var_2, var_3, var_4) {
  if(!isplayer(self)) {
    return;
  }
  self endon("disconnect");
  waittillframeend;

  if(!isDefined(self)) {
    return;
  }
  if(level.gameended) {
    return;
  }
  if(isDefined(var_2))
    var_0 += ("_" + var_2);

  if(!isDefined(var_4))
    var_4 = -1;

  if(!isDefined(var_1))
    var_1 = randomIntRange(1, 25);

  if(getdvarint("scr_lua_splashes")) {
    var_5 = tablelookuprownum("mp/splashTable.csv", 0, var_0);

    if(var_5 >= 0) {
      self luinotifyevent(&"killstreak_splash", 3, var_5, var_1, var_4);
      self _meth_8579(&"killstreak_splash", 3, var_5, var_1, var_4);
      insertluasplash(level.lua_splash_type_killstreak, var_5);
    }

    return;
  }
}

deathstreaksplashnotify(perk) {
  if(!isplayer(self)) {
    return;
  }
  self endon("disconnect");
  waittillframeend;

  if(!isDefined(self)) {
    return;
  }
  if(level.gameended) {
    return;
  }
  self setClientOmnvar("ui_splash_deathstreak_idx", -1);

  if(perk == "specialty_combathigh" || perk == "specialty_copycat" || perk == "specialty_grenadepulldeath" || perk == "specialty_finalstand") {
    if(getDvarInt("scr_lua_splashes")) {
      index = int(tablelookup("mp/statsTable.csv", 4, perk, 0));
      if(index >= 0) {
        //print( "deathstreaksplashnotify:", perk, " (", index, ")" );
        self setClientOmnvar("ui_splash_deathstreak_time", getTime());
        self setClientOmnvar("ui_splash_deathstreak_idx", index);
      }

      return;
    }
  }
}

stucksplashnotify(isVictim) {
  if(!isplayer(self)) {
    return;
  }
  self endon("disconnect");
  waittillframeend;

  if(!isDefined(self)) {
    return;
  }
  if(level.gameended) {
    return;
  }
  ref = "stuck_attacker";
  if(isVictim)
    ref = "stuck_victim";

  self setClientOmnvar("ui_splash_stuck_idx", -1);

  if(getDvarInt("scr_lua_splashes")) {
    index = int(tablelookuprownum("mp/splashTable.csv", 0, ref));
    if(index >= 0) {
      //print( "stucksplashnotify:", " (", ref, ")" );
      self setClientOmnvar("ui_splash_stuck_time", getTime());
      self setClientOmnvar("ui_splash_stuck_idx", index);
    }

    return;
  }
}

challengesplashnotify(challengeRef, originalState, newState) {
  if(!isplayer(self)) {
    return;
  }
  self endon("disconnect");
  waittillframeend;
  wait 0.05;

  for(state = newState - 1; state >= originalState; state--) {
    target = maps\mp\gametypes\_hud_util::ch_gettarget(challengeRef, state);

    if(target == 0)
      target = 1;

    if(challengeRef == "ch_longersprint_pro" || challengeRef == "ch_longersprint_pro_daily" || challengeRef == "ch_longersprint_pro_weekly")
      target = int(target / 528);

    if(getdvarint("scr_lua_splashes")) {
      ref = tablelookup("mp/allChallengesTable.csv", 0, challengeRef, 28);

      if(ref != "") {
        //print( "challengesplashnotify:", challengeRef );
        intRef = int(ref);
        self luinotifyevent(&"challenge_splash", 3, intRef, state, target);
        self _meth_8579(&"challenge_splash", 3, intRef, state, target);
        insertluasplash(level.lua_splash_type_challenge, intRef);
      }

      continue;
    }

    actionData = spawnStruct();
    actionData.name = challengeRef;
    actionData.type = tablelookup(get_table_name(), 0, challengeRef, 11);
    actionData.challengetier = state;
    actionData.optionalnumber = target;
    actionData.sound = tablelookup(get_table_name(), 0, challengeRef, 9);
    actionData.slot = 0;
    thread actionnotify(actionData);
  }
}

medalsplashnotify(splashRef) {
  if(getdvarint("scr_lua_splashes")) {
    //print( "medalsplashnotify:", splashRef );
    index = tablelookuprownum("mp/splashTable.csv", 0, splashRef);

    if(index >= 0) {
      self luinotifyevent(&"medal_splash", 1, index);
      self _meth_8579(&"medal_splash", 1, index);
      insertluasplash(level.lua_splash_type_medal, index);
      return;
    }
  } else
    splashnotify(splashRef);
}

splashnotify(splash, optionalNumber, optionalKillstreakSlot) {
  if(!isplayer(self)) {
    return;
  }
  if(getdvarint("scr_lua_splashes")) {
    //print( "splashnotify:", splash );
    var_3 = tablelookuprownum("mp/splashTable.csv", 0, splash);

    if(var_3 >= 0) {
      if(isDefined(optionalNumber)) {
        self luinotifyevent(&"generic_splash_number", 2, var_3, optionalNumber);
        self luinotifyeventtospectators(&"generic_splash_number", 2, var_3, optionalNumber);
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
  actionData = spawnStruct();
  actionData.name = splash;
  actionData.type = tablelookup("mp/splashTable.csv", 0, splash, 11);
  actionData.optionalnumber = optionalNumber;
  actionData.sound = tablelookup("mp/splashTable.csv", 0, actionData.name, 9);

  if(!isDefined(optionalKillstreakSlot))
    optionalKillstreakSlot = -1;

  actionData.killstreakslot = optionalKillstreakSlot;
  actionData.slot = 0;
  thread actionnotify(actionData);
}

rankupsplashnotify(var_0, var_1, var_2) {
  if(!isplayer(self)) {
    return;
  }
  self endon("disconnect");
  waittillframeend;

  if(!isDefined(self)) {
    return;
  }
  if(level.gameended) {
    return;
  }
  if(getdvarint("scr_lua_splashes")) {
    var_3 = tablelookuprownum("mp/splashTable.csv", 0, var_0);
    //print( "rankupsplashnotify:", var_0 );
    if(var_3 >= 0) {
      self luinotifyevent(&"rankup_splash", 3, var_3, var_1, var_2);
      self _meth_8579(&"rankup_splash", 3, var_3, var_1, var_2);
      insertluasplash(level.lua_splash_type_rankup, var_3);
    }
    return;
  }

  var_4 = spawnStruct();
  var_4.name = var_0;
  var_4.type = tablelookup("mp/splashTable.csv", 0, var_0, 11);
  var_4.sound = tablelookup("mp/splashTable.csv", 0, var_0, 9);
  var_4.rank = var_1;
  var_4.prestige = var_2;
  var_4.slot = 0;
  thread actionnotify(var_4);
}

playerCardSplashNotify(splashRef, player, optionalNumber) {
  if(!isPlayer(self)) {
    return;
  }
  self endon("disconnect");
  waittillframeend;

  if(level.gameEnded) {
    return;
  }
  self setClientOmnvar("ui_splash_playercard_idx", -1);

  if(getDvarInt("scr_lua_splashes")) {
    index = tablelookuprownum("mp/splashTable.csv", 0, splashRef);
    if(index >= 0) {
      //print( "playerCardSplashNotify:", splashRef );
      self setClientOmnvar("ui_splash_playercard_time", getTime());
      self setClientOmnvar("ui_splash_playercard_clientnum", player getEntityNumber());
      self setClientOmnvar("ui_splash_playercard_idx", index);

      if(isDefined(optionalNumber))
        self setClientOmnvar("ui_splash_playercard_optional_number", optionalNumber);
      /*
      self luinotifyevent(&"playercard_splash", 3, index, player, optionalNumber );
      self luinotifyeventtospectators(&"playercard_splash", 3, index, player, optionalNumber );
      self _meth_8579(&"playercard_splash", 3, index, player, optionalNumber );
      insertluasplash( level.lua_splash_type_playercard, index );
      */
    }

    return;
  }
}

cardKillSplashNotify(splashRef, player) {
  if(!isPlayer(self)) {
    return;
  }
  self endon("disconnect");
  waittillframeend;

  if(level.gameEnded) {
    return;
  }
  index = splashRef == "killedby" ? 0 : 1;

  self setClientOmnvar("ui_splash_cardkill_idx", -1);

  if(getDvarInt("scr_lua_splashes")) {
    self setClientOmnvar("ui_splash_cardkill_time", getTime());
    self setClientOmnvar("ui_splash_cardkill_clientnum", player getEntityNumber());
    self setClientOmnvar("ui_splash_cardkill_idx", index);
    return;
  }
}

actionnotify(var_0) {
  self endon("death");
  self endon("disconnect");
  var_1 = var_0.slot;

  if(!isDefined(var_0.type))
    var_0.type = "";

  if(!isDefined(self.doingsplash[var_1])) {
    thread actionnotifymessage(var_0);
    return;
  } else {
    switch (var_0.type) {
      case "urgent_splash":
        self.notifytext.alpha = 0;
        self.notifytext2.alpha = 0;
        self.notifyicon.alpha = 0;
        self setclientomnvar("ui_splash_idx", -1);
        self setclientomnvar("ui_splash_killstreak_idx", -1);
        thread actionnotifymessage(var_0);
        return;
      case "splash":
      case "killstreak_splash":
        if(self.doingsplash[var_1].type != "splash" &&
          self.doingsplash[var_1].type != "urgent_splash" &&
          self.doingsplash[var_1].type != "killstreak_splash" &&
          self.doingsplash[var_1].type != "challenge_splash" &&
          self.doingsplash[var_1].type != "rankup_splash" &&
          self.doingsplash[var_1].type != "promotion_splash") {
          self.notifytext.alpha = 0;
          self.notifytext2.alpha = 0;
          self.notifyicon.alpha = 0;
          thread actionnotifymessage(var_0);
          return;
        }
        break;
    }
  }

  if(var_0.type == "challenge_splash" || var_0.type == "killstreak_splash") {
    for(var_2 = self.splashqueue[var_1].size; var_2 > 0; var_2--)
      self.splashqueue[var_1][var_2] = self.splashqueue[var_1][var_2 - 1];

    self.splashqueue[var_1][0] = var_0;
  } else
    self.splashqueue[var_1][self.splashqueue[var_1].size] = var_0;
}

actionNotifyMessage(actionData) {
  self endon("disconnect");

  assert(isDefined(actionData.slot));
  slot = actionData.slot;

  if(level.gameEnded) {
    if(isDefined(actionData.type) && (actionData.type == "promotion_splash")) {
      self setClientDvar("ui_promotion", 1);
      self.postGamePromotion = true;
    } else if(isDefined(actionData.type) && actionData.type == "challenge_splash") {
      self.pers["postGameChallenges"]++;
      self setClientDvar("ui_challenge_" + self.pers["postGameChallenges"] + "_ref", actionData.name);
    }

    if(self.splashQueue[slot].size)
      self thread dispatchNotify(slot);

    return;
  }

  assertEx(tableLookup("mp/splashTable.csv", 0, actionData.name, 0) != "", "ERROR: unknown splash - " + actionData.name);

  if(tableLookup("mp/splashTable.csv", 0, actionData.name, 0) != "") {
    splashIdx = tableLookupRowNum("mp/splashTable.csv", 0, actionData.name);
    duration = maps\mp\_utility::stringtofloat(tableLookupByRow("mp/splashTable.csv", splashIdx, 4));

    switch (actionData.type) {
      case "killstreak_splash":
        self setClientOmnvar("ui_splash_killstreak_idx", splashIdx);
        if(isDefined(actionData.playerCardPlayer) && actionData.playerCardPlayer != self)
          self setClientOmnvar("ui_splash_killstreak_clientnum", actionData.playerCardPlayer getEntityNumber());
        else
          self setClientOmnvar("ui_splash_killstreak_clientnum", -1);

        if(isDefined(actionData.optionalNumber))
          self setClientOmnvar("ui_splash_killstreak_optional_number", actionData.optionalNumber);
        else
          self setClientOmnvar("ui_splash_killstreak_optional_number", 0);
        break;

      case "playercard_splash":
        if(isDefined(actionData.playerCardPlayer)) {
          assert(isPlayer(actionData.playerCardPlayer) || isAgent(actionData.playerCardPlayer));
          self setClientOmnvar("ui_splash_playercard_idx", splashIdx);
          self setClientOmnvar("ui_splash_playercard_clientnum", actionData.playerCardPlayer getEntityNumber());
          if(isDefined(actionData.optionalNumber))
            self setClientOmnvar("ui_splash_playercard_optional_number", actionData.optionalNumber);
        }
        break;

      case "splash":
      case "urgent_splash":
        self setClientOmnvar("ui_splash_idx", splashIdx);
        if(isDefined(actionData.optionalNumber))
          self setClientOmnvar("ui_splash_optional_number", actionData.optionalNumber);
        break;
      case "rankup_splash":
        self setclientomnvar("ui_rankup_splash_idx", splashIdx);

        if(isDefined(actionData.rank))
          self setclientomnvar("ui_rank_splash_rank", actionData.rank);

        if(isDefined(actionData.prestige))
          self setclientomnvar("ui_rank_splash_prestige", actionData.prestige);

        break;
      case "challenge_splash":
      case "perk_challenge_splash":
        splashIdx = int(tablelookup("mp/allchallengestable.csv", 0, actionData.name, 28));
        self setclientomnvar("ui_challenge_splash_idx", splashIdx);

        if(isDefined(actionData.challengetier))
          self setclientomnvar("ui_challenge_splash_tier", actionData.challengetier);

        if(isDefined(actionData.optionalnumber))
          self setclientomnvar("ui_challenge_splash_optional_number", actionData.optionalnumber);

        break;

      default:
        assertMsg("Splashes should have a type! FIX IT! Splash: " + actionData.name);
        break;
    }

    self.doingSplash[slot] = actionData;

    if(isDefined(actionData.sound) && actionData.sound != "")
      self PlayLocalSound(actionData.sound);

    if(isDefined(actionData.leaderSound)) {
      if(isDefined(actionData.leaderSoundGroup))
        self maps\mp\_utility::leaderDialogOnPlayer(actionData.leaderSound, actionData.leaderSoundGroup, true);
      else
        self maps\mp\_utility::leaderDialogOnPlayer(actionData.leaderSound);
    }

    self notify("actionNotifyMessage" + slot);
    self endon("actionNotifyMessage" + slot);

    wait(duration + 0.5); // wait the duration but put a buffer in between each splash

    self.doingSplash[slot] = undefined;
  }

  if(self.splashQueue[slot].size)
    self thread dispatchNotify(slot);
}

setCustomPoint(point, x, y) {
  if(point == "center") {
    self.horzAlign = "center";
    self.vertAlign = "middle";
    self.alignX = "center";
    self.alignY = "middle";
  } else {
    self.horzAlign = point + "_adjustable";
    self.vertAlign = "top_adjustable";
    self.alignX = point;
    self.alignY = "top";
  }

  self.x = x;
  self.y = y;
}

waitrequirevisibility(var_0) {
  var_1 = 0.05;

  while(!canreadtext())
    wait(var_1);

  while(var_0 > 0) {
    wait(var_1);

    if(canreadtext())
      var_0 -= var_1;
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

  if(isDefined(level.lowermessagefont))
    var_0 = level.lowermessagefont;

  var_1 = -140;
  var_2 = level.lowertextfontsize;
  var_3 = 1.25;

  if(level.splitscreen || self issplitscreenplayer() && !isai(self)) {
    var_2 = level.lowertextfontsize * 1.4;
    var_3 *= 1.5;
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

isdoingsplash() {
  if(isDefined(self.doingsplash)) {
    if(isDefined(self.doingsplash[0]))
      return 1;

    if(isDefined(self.doingsplash[1]))
      return 1;

    if(isDefined(self.doingsplash[2]))
      return 1;

    if(isDefined(self.doingsplash[3]))
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

  if(!isDefined(var_4) || var_4 != "allies" && var_4 != "axis")
    var_4 = "allies";

  while(isdoingsplash())
    wait 0.05;

  self endon("reset_outcome");
  var_5 = 0;

  if(level.gametype == "ctf" && isDefined(var_3) && var_3)
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
  else if(isDefined(self.pers["team"]) && var_0 == var_4) {
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

  if(isDefined(self.matchbonus))
    self setclientomnvar("ui_round_end_match_bonus", self.matchbonus);

  if(isDefined(game["round_time_to_beat"]))
    self setclientomnvar("ui_round_end_stopwatch", int(game["round_time_to_beat"] * 60));

  self setclientomnvar("ui_round_end", 1);
}

outcomenotify(var_0, var_1) {
  self endon("disconnect");
  self notify("reset_outcome");

  while(isdoingsplash())
    wait 0.05;

  self endon("reset_outcome");
  var_2 = level.placement["all"];
  var_3 = var_2[0];
  var_4 = var_2[1];
  var_5 = var_2[2];
  var_6 = 0;

  if(isDefined(var_3) && self.score == var_3.score && self.deaths == var_3.deaths) {
    if(self != var_3)
      var_6 = 1;
    else if(isDefined(var_4) && var_4.score == var_3.score && var_4.deaths == var_3.deaths)
      var_6 = 1;
  }

  if(var_6)
    self setclientomnvar("ui_round_end_title", game["round_end"]["tie"]);
  else if(isDefined(var_3) && self == var_3)
    self setclientomnvar("ui_round_end_title", game["round_end"]["victory"]);
  else
    self setclientomnvar("ui_round_end_title", game["round_end"]["defeat"]);

  self setclientomnvar("ui_round_end_reason", var_1);

  if(isDefined(self.matchbonus))
    self setclientomnvar("ui_round_end_match_bonus", self.matchbonus);

  self setclientomnvar("ui_round_end", 1);
  self waittill("update_outcome");
}

canshowsplash(var_0) {}

lerpscreenblurup(var_0, var_1) {
  self setblurforplayer(var_0, var_1);
}

get_table_name() {
  return "mp/splashTable.csv";
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

  for(;;) {
    if(!self.luasplashqueue.size)
      self waittill("luaSplashTimerUpdate");

    if(!self.luasplashqueue.size) {
      continue;
    }
    var_0 = self.luasplashqueue[0];
    self.luasplashqueue = maps\mp\_utility::array_remove_index(self.luasplashqueue, 0);
    self.luasplashcurrenttype = var_0.splashtype;

    if(var_0.splashtype == level.lua_splash_type_killstreak) {
      var_1 = int(1000.0 * float(tablelookupbyrow("mp/splashTable.csv", var_0.splashdata, 4)));

      if(!var_1) {
        continue;
      }
      self.luasplashnextintrocompletetime = gettime() + var_1;
      self.luasplashnextoutrocompletetime = gettime() + var_1;
    } else if(var_0.splashtype == level.lua_splash_type_medal) {
      var_1 = int(1000.0 * float(tablelookupbyrow("mp/splashTable.csv", var_0.splashdata, 4)));

      if(!var_1) {
        continue;
      }
      self.luasplashnextintrocompletetime = gettime() + 250;
      self.luasplashnextoutrocompletetime = gettime() + var_1;
    } else if(var_0.splashtype == level.lua_splash_type_challenge) {
      var_2 = tablelookup("mp/allchallengestable.csv", 28, var_0.splashdata, 0);

      if(var_2 == "") {
        continue;
      }
      var_1 = int(1000.0 * float(tablelookup("mp/splashTable.csv", 0, var_2, 4)));

      if(!var_1) {
        continue;
      }
      self.luasplashnextintrocompletetime = gettime() + var_1;
      self.luasplashnextoutrocompletetime = gettime() + var_1;
    } else if(var_0.splashtype == level.lua_splash_type_rankup) {
      var_1 = int(1000.0 * float(tablelookupbyrow("mp/splashTable.csv", var_0.splashdata, 4)));

      if(!var_1) {
        continue;
      }
      self.luasplashnextintrocompletetime = gettime() + var_1;
      self.luasplashnextoutrocompletetime = gettime() + var_1;
    } else {
      var_1 = int(1000.0 * float(tablelookupbyrow("mp/splashTable.csv", var_0.splashdata, 4)));

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

    while(gettime() < self.luasplashnextoutrocompletetime) {
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
  if(!isDefined(self.luasplashqueue)) {
    return;
  }
  if(var_0 == level.lua_splash_type_medal) {
    for(var_2 = 0; var_2 < self.luasplashqueue.size; var_2++) {
      if(self.luasplashqueue[var_2].splashtype == var_0 && self.luasplashqueue[var_2].splashdata == var_1)
        return;
    }
  }

  var_3 = spawnStruct();
  var_3.splashtype = var_0;
  var_3.splashdata = var_1;

  if(var_0 == level.lua_splash_type_killstreak) {
    var_4 = undefined;

    for(var_2 = 0; var_2 < self.luasplashqueue.size; var_2++) {
      if(self.luasplashqueue[var_2].splashtype != level.lua_splash_type_killstreak) {
        var_4 = var_2;
        break;
      }
    }

    if(isDefined(var_4)) {
      self.luasplashqueue = common_scripts\utility::array_insert(self.luasplashqueue, var_3, var_4);
      self notify("luaSplashTimerUpdate");
      return;
    }
  }

  self.luasplashqueue[self.luasplashqueue.size] = var_3;
  self notify("luaSplashTimerUpdate");
}

customsplashnotify(title, descriptionText, sound) {
  if(!isPlayer(self)) {
    return;
  }
  self endon("disconnect");
  waittillframeend;

  if(!isDefined(self) || level.gameended) {
    return;
  }
  actionData = spawnStruct();
  actionData.type = "deathstreak_splash";
  actionData.name = title;
  actionData.slot = 0;
  actionData.splash_title = title;
  actionData.splash_underText = descriptionText;
  actionData.sound = sound;

  self thread actionNotify(actionData);
}