/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\_hud_message.gsc
******************************************************/

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
  game["end_reason"]["enemies_eliminated"] = 10;
  game["end_reason"]["tie"] = 11;
  game["end_reason"]["objective_completed"] = 12;
  game["end_reason"]["objective_failed"] = 13;
  game["end_reason"]["switching_sides"] = 14;
  game["end_reason"]["round_limit_reached"] = 15;
  game["end_reason"]["ended_game"] = 16;
  game["end_reason"]["host_ended_game"] = 17;
  game["end_reason"]["loss_stat_prevented"] = 18;
  game["end_reason"]["zombies_completed"] = 19;
  game["end_reason"]["zombie_extraction_failed"] = 20;
  game["end_reason"]["survivors_eliminated"] = 21;
  game["end_reason"]["infected_eliminated"] = 22;
  game["end_reason"]["survivors_forfeited"] = 23;
  game["end_reason"]["infected_forfeited"] = 24;
  game["end_reason"]["prop_tiebreaker_kills"] = 25;
  game["end_reason"]["prop_tiebreaker_time"] = 26;
  game["end_reason"]["ranked_play_void_match"] = 27;
  game["strings"]["overtime"] = &"MP_OVERTIME";
  level thread onplayerconnect();
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread lowermessagethink();
    var_0 thread initnotifymessage();
  }
}

hintmessage(var_0) {
  var_1 = spawnStruct();
  var_1.notifytext = var_0;
  notifymessage(var_1);
}

initnotifymessage() {
  if((level.splitscreen || self _meth_82D0()) && !_func_3BA()) {
    var_0 = 1.5;
    var_1 = 1.25;
    var_2 = 24;
    var_3 = "hudsmall";
    var_4 = "TOP";
    var_5 = "BOTTOM";
    var_6 = 0;
    var_7 = 0;
  } else {
    var_0 = 2.5;
    var_1 = 1.75;
    var_2 = 30;
    var_3 = "hudsmall";
    var_4 = "TOP";
    var_5 = "BOTTOM";
    var_6 = 50;
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

notifymessage(var_0) {
  self endon("death");
  self endon("disconnect");

  if(!isDefined(var_0.slot))
    var_0.slot = 0;

  var_1 = var_0.slot;

  if(!isDefined(var_0.type))
    var_0.type = "";

  if(!isDefined(self.doingsplash[var_1])) {
    thread shownotifymessage(var_0);
    return;
  }

  self.splashqueue[var_1][self.splashqueue[var_1].size] = var_0;
}

dispatchnotify(var_0) {
  waittillframeend;
  var_1 = self.splashqueue[var_0][0];

  for(var_2 = 1; var_2 < self.splashqueue[var_0].size; var_2++)
    self.splashqueue[var_0][var_2 - 1] = self.splashqueue[var_0][var_2];

  self.splashqueue[var_0][var_2 - 1] = undefined;

  if(isDefined(var_1.name))
    actionnotify(var_1);
  else
    shownotifymessage(var_1);
}

promotionsplashnotify() {
  if(!isPlayer(self)) {
    return;
  }
  self endon("disconnect");
  var_0 = spawnStruct();
  var_1 = "promotion";
  var_0.name = var_1;
  var_0.type = tablelookup(get_splash_table(), 0, var_1, 11);
  var_0.sound = tablelookup(get_splash_table(), 0, var_1, 9);
  var_0.slot = 0;
  thread actionnotify(var_0);
}

ranksplashnotify(var_0) {
  if(!isPlayer(self)) {
    return;
  }
  self endon("disconnect");
  var_1 = spawnStruct();
  var_2 = "callout_rankPromoted";
  var_1.name = var_2;
  var_1.type = tablelookup(get_splash_table(), 0, var_2, 11);
  var_1.sound = tablelookup(get_splash_table(), 0, var_2, 9);
  var_1._id_73C1 = var_0;
  var_1.slot = 0;

  if(var_1.type == "playercard_splash")
    var_1.slot = 1;

  thread actionnotify(var_1);
}

shownotifymessage(var_0) {
  self endon("disconnect");
  var_1 = var_0.slot;

  if(level.gameended) {
    if(isDefined(var_0.type) && var_0.type == "rank") {
      self setclientdvar("ui_promotion", 1);
      self.postgamepromotion = 1;
    }

    if(self.splashqueue[var_1].size)
      thread dispatchnotify(var_1);

    return;
  }

  self.doingsplash[var_1] = var_0;
  thread resetoncancel();
  waitrequirevisibility(0);

  if(isDefined(var_0.duration))
    var_2 = var_0.duration;
  else if(level.gameended)
    var_2 = 2.0;
  else
    var_2 = 4.0;

  if(isDefined(var_0.sound))
    self playlocalsound(var_0.sound);

  if(isDefined(var_0.leadersound))
    maps\mp\_utility::leaderdialogonplayer(var_0.leadersound);

  var_3 = var_0.glowcolor;
  var_4 = self.notifytitle;

  if(isDefined(var_0.titletext)) {
    if(isDefined(var_0.titlelabel))
      self.notifytitle.label = var_0.titlelabel;
    else
      self.notifytitle.label = &"";

    if(isDefined(var_0.titlelabel) && !isDefined(var_0.titleisstring))
      self.notifytitle setvalue(var_0.titletext);
    else
      self.notifytitle settext(var_0.titletext);

    if(isDefined(var_3))
      self.notifytitle.glowcolor = var_3;

    self.notifytitle.alpha = 1;
    self.notifytitle fadeovertime(var_2 * 1.25);
    self.notifytitle.alpha = 0;
  }

  if(isDefined(var_0.textglowcolor))
    var_3 = var_0.textglowcolor;

  if(isDefined(var_0.notifytext)) {
    if(isDefined(var_0._id_992E))
      self.notifytext.label = var_0._id_992E;
    else
      self.notifytext.label = &"";

    if(isDefined(var_0._id_992E) && !isDefined(var_0._id_992D))
      self.notifytext setvalue(var_0.notifytext);
    else
      self.notifytext settext(var_0.notifytext);

    if(isDefined(var_3))
      self.notifytext.glowcolor = var_3;

    self.notifytext.alpha = 1;
    self.notifytext fadeovertime(var_2 * 1.25);
    self.notifytext.alpha = 0;
    var_4 = self.notifytext;
  }

  if(isDefined(var_0.notifytext2)) {
    self.notifytext2 maps\mp\gametypes\_hud_util::setparent(var_4);

    if(isDefined(var_0.text2label))
      self.notifytext2.label = var_0.text2label;
    else
      self.notifytext2.label = &"";

    self.notifytext2 settext(var_0.notifytext2);

    if(isDefined(var_3))
      self.notifytext2.glowcolor = var_3;

    self.notifytext2.alpha = 1;
    self.notifytext2 fadeovertime(var_2 * 1.25);
    self.notifytext2.alpha = 0;
    var_4 = self.notifytext2;
  }

  if(isDefined(var_0.iconname)) {
    self.notifyicon maps\mp\gametypes\_hud_util::setparent(var_4);

    if((level.splitscreen || self _meth_82D0()) && !_func_3BA())
      self.notifyicon setshader(var_0.iconname, 30, 30);
    else
      self.notifyicon setshader(var_0.iconname, 60, 60);

    self.notifyicon.alpha = 0;

    if(isDefined(var_0.iconoverlay)) {
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

_id_265F(var_0, var_1) {
  if(!isPlayer(self)) {
    return;
  }
  self endon("disconnect");
  waittillframeend;

  if(level.gameended) {
    return;
  }
  var_2 = spawnStruct();
  var_2.name = var_0;
  var_2.type = tablelookup(get_splash_table(), 0, var_0, 11);
  var_2.optionalnumber = 0;
  var_2.sound = tablelookup(get_splash_table(), 0, var_0, 9);
  var_2.leadersound = var_1;
  var_2.slot = 0;
  thread actionnotify(var_2);
}

killstreaksplashnotify(var_0, var_1, var_2, var_3, var_4) {
  if(!isPlayer(self)) {
    return;
  }
  self endon("disconnect");
  waittillframeend;

  if(level.gameended) {
    return;
  }
  var_5 = spawnStruct();

  if(isDefined(var_2))
    var_0 = var_0 + ("_" + var_2);

  if(!isDefined(var_3))
    var_3 = -1;

  var_5.name = var_0;
  var_5.type = tablelookup(get_splash_table(), 0, var_0, 11);
  var_5.optionalnumber = var_1;
  var_5.sound = maps\mp\_utility::_id_4547(var_0);
  var_5.leadersound = var_0;
  var_5.leadersoundgroup = "killstreak_earned";
  var_5.slot = 0;
  var_5._id_5A76 = var_3;

  if(isDefined(var_4))
    var_5.leadersound = var_4;

  thread actionnotify(var_5);
}

_id_20AB(var_0, var_1, var_2) {
  if(!isPlayer(self)) {
    return;
  }
  self endon("disconnect");
  waittillframeend;
  waitframe();

  for(var_3 = var_2 - 1; var_3 >= var_1; var_3--) {
    var_4 = maps\mp\gametypes\_hud_util::_id_2099(var_0, var_3);

    if(var_4 == 0)
      var_4 = 1;

    if(var_0 == "ch_exomech_frontier")
      var_4 = int(var_4 / 528);

    var_5 = spawnStruct();
    var_5.name = var_0;
    var_5.type = tablelookup(get_splash_table(), 0, var_0, 11);
    var_5._id_20AC = var_3;
    var_5.optionalnumber = var_4;
    var_5.sound = tablelookup(get_splash_table(), 0, var_0, 9);
    var_5.slot = 0;
    thread actionnotify(var_5);
  }
}

_id_9102(var_0, var_1, var_2) {
  if(!isPlayer(self)) {
    return;
  }
  self endon("disconnect");
  waitframe();
  var_3 = spawnStruct();
  var_3.name = var_0;
  var_3.type = tablelookup(get_splash_table(), 0, var_0, 11);
  var_3.optionalnumber = var_1;
  var_3.sound = tablelookup(get_splash_table(), 0, var_3.name, 9);

  if(!isDefined(var_2))
    var_2 = -1;

  var_3._id_5A76 = var_2;
  var_3.slot = 0;

  if(common_scripts\utility::_id_562E(level._id_2FA1)) {
    switch (var_3.type) {
      case "specialist_splash":
      case "challenge_splash":
      case "rankup_splash":
      case "largewar_splash":
      case "playercard_splash":
        break;
      default:
        return;
    }
  }

  thread actionnotify(var_3);
}

_id_9104(var_0, var_1) {
  if(!isPlayer(self)) {
    return;
  }
  self endon("disconnect");
  waitframe();
  var_2 = spawnStruct();
  var_2.name = var_0;
  var_2.type = tablelookup(get_splash_table(), 0, var_0, 11);
  var_2.optionalnumber = var_1;
  var_2.sound = tablelookup(get_splash_table(), 0, var_0, 9);
  var_2.slot = 0;
  thread actionnotify(var_2);
}

_id_9103(var_0, var_1) {
  if(!isPlayer(self)) {
    return;
  }
  self endon("disconnect");
  waittillframeend;

  if(level.gameended) {
    return;
  }
  var_2 = spawnStruct();
  var_2.name = var_0;
  var_2.type = tablelookup(get_splash_table(), 0, var_0, 11);
  var_2.optionalnumber = var_1;
  var_2.sound = tablelookup(get_splash_table(), 0, var_0, 9);
  var_2.slot = 0;
  thread actionnotify(var_2);
}

_id_7A6C(var_0, var_1, var_2) {
  if(!isPlayer(self)) {
    return;
  }
  self endon("disconnect");
  waittillframeend;

  if(level.gameended) {
    return;
  }
  var_3 = spawnStruct();
  var_3.name = var_0;
  var_3.type = tablelookup(get_splash_table(), 0, var_0, 11);
  var_3.sound = tablelookup(get_splash_table(), 0, var_0, 9);
  var_3._id_7A65 = var_1;

  if(isDefined(var_2))
    var_3._id_76B0 = var_2;

  var_3.slot = 0;
  thread actionnotify(var_3);
}

_id_A9DD(var_0, var_1, var_2) {
  if(!isPlayer(self)) {
    return;
  }
  self endon("disconnect");
  waittillframeend;

  if(level.gameended) {
    return;
  }
  var_3 = spawnStruct();
  var_3.name = var_0;
  var_3.type = tablelookup(get_splash_table(), 0, var_0, 11);
  var_3.sound = tablelookup(get_splash_table(), 0, var_0, 9);
  var_3._id_A9D0 = var_2;
  var_3.slot = 0;
  thread actionnotify(var_3);
}

_id_3055(var_0, var_1) {
  if(!isPlayer(self)) {
    return;
  }
  self endon("disconnect");
  waittillframeend;

  if(level.gameended) {
    return;
  }
  var_2 = spawnStruct();
  var_2.name = var_0;
  var_2.type = tablelookup(get_splash_table(), 0, var_0, 11);
  var_2.sound = tablelookup(get_splash_table(), 0, var_0, 9);
  var_2._id_3054 = var_1;
  var_2.slot = 0;
  thread actionnotify(var_2);
}

playercardsplashnotify(var_0, var_1, var_2) {
  if(!isPlayer(self)) {
    return;
  }
  self endon("disconnect");
  waittillframeend;

  if(level.gameended) {
    return;
  }
  var_3 = spawnStruct();
  var_3.name = var_0;
  var_3.type = tablelookup(get_splash_table(), 0, var_0, 11);
  var_3.optionalnumber = var_2;
  var_3.sound = tablelookup(get_splash_table(), 0, var_0, 9);
  var_3._id_73C1 = var_1;
  var_3.slot = 0;

  if(var_3.type == "playercard_splash")
    var_3.slot = 1;

  thread actionnotify(var_3);
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
      case "specialist_splash":
      case "largewar_splash":
        self.notifytext.alpha = 0;
        self.notifytext2.alpha = 0;
        self.notifyicon.alpha = 0;
        self _meth_82FF("ui_splash_idx", -1);
        self _meth_82FF("ui_splash_killstreak_idx", -1);
        self _meth_82FF("ui_daily_challenge_idx", -1);
        thread actionnotifymessage(var_0);
        return;
      case "daily_challenge_splash":
      case "killstreak_splash":
      case "killstreak_coop_splash":
      case "splash":
        if(self.doingsplash[var_1].type != "splash" && self.doingsplash[var_1].type != "urgent_splash" && self.doingsplash[var_1].type != "largewar_splash" && self.doingsplash[var_1].type != "killstreak_coop_splash" && self.doingsplash[var_1].type != "killstreak_splash" && self.doingsplash[var_1].type != "challenge_splash" && self.doingsplash[var_1].type != "promotion_splash" && self.doingsplash[var_1].type != "intel_splash" && self.doingsplash[var_1].type != "rankup_splash" && self.doingsplash[var_1].type != "weapon_level_splash" && self.doingsplash[var_1].type != "division_level_splash" && self.doingsplash[var_1].type != "daily_challenge_splash" && self.doingsplash[var_1].type != "specialist_splash") {
          self.notifytext.alpha = 0;
          self.notifytext2.alpha = 0;
          self.notifyicon.alpha = 0;
          thread actionnotifymessage(var_0);
          return;
        }

        break;
    }
  }

  if(var_0.type == "challenge_splash" || var_0.type == "killstreak_splash" || var_0.type == "killstreak_coop_splash" || var_0.type == "daily_challenge_splash") {
    if(var_0.type == "daily_challenge_splash" && self.splashqueue[var_1].size > 0) {
      var_2 = "";

      if(issubstr(var_0.name, "_complete"))
        var_2 = "_complete";

      foreach(var_4 in self.splashqueue[var_1]) {
        if(var_4.name + var_2 == var_0.name) {
          self.splashqueue[var_1] = common_scripts\utility::_id_0F93(self.splashqueue[var_1], var_4);
          break;
        }
      }
    }

    for(var_6 = self.splashqueue[var_1].size; var_6 > 0; var_6--)
      self.splashqueue[var_1][var_6] = self.splashqueue[var_1][var_6 - 1];

    self.splashqueue[var_1][0] = var_0;
  } else
    self.splashqueue[var_1][self.splashqueue[var_1].size] = var_0;
}

actionnotifymessage(var_0) {
  self endon("disconnect");
  var_1 = var_0.slot;

  if(level.gameended) {
    if(isDefined(var_0.type) && (var_0.type == "promotion_splash" || var_0.type == "promotion_weapon_splash")) {
      self setclientdvar("ui_promotion", 1);
      self.postgamepromotion = 1;
    } else if(isDefined(var_0.type) && var_0.type == "challenge_splash") {
      self.pers["postGameChallenges"]++;
      self setclientdvar("ui_challenge_" + self.pers["postGameChallenges"] + "_ref", var_0.name);
    }

    if(self.splashqueue[var_1].size)
      thread dispatchnotify(var_1);

    return;
  }

  if(!isDefined(self._id_66CE))
    self._id_66CE = 0;

  if(tablelookup(get_splash_table(), 0, var_0.name, 0) != "") {
    var_2 = _func_1B1(get_splash_table(), 0, var_0.name);
    var_3 = common_scripts\utility::stringtofloat(_func_1AE(get_splash_table(), var_2, 4));

    switch (var_0.type) {
      case "killstreak_splash":
      case "killstreak_coop_splash":
        if(getdvarint("5270", 1))
          _id_8C18(var_0.name, var_0._id_5A76);

        break;
      case "playercard_splash":
        if(isDefined(var_0._id_73C1)) {
          self _meth_82FF("ui_splash_playercard_idx", var_2);

          if(isPlayer(var_0._id_73C1))
            self _meth_82FF("ui_splash_playercard_clientnum", var_0._id_73C1 getentitynumber());

          if(isDefined(var_0.optionalnumber))
            self _meth_82FF("ui_splash_playercard_optional_number", var_0.optionalnumber);
        }

        break;
      case "perk_challenge_splash":
      case "intel_splash":
      case "daily_challenge_splash":
      case "urgent_splash":
      case "specialist_splash":
      case "challenge_splash":
      case "largewar_splash":
      case "splash":
        _id_8C18(var_0.name, var_0.optionalnumber);
        break;
      case "rankup_splash":
        _id_8C18(var_0.name, var_0._id_7A65);
        break;
      case "weapon_level_splash":
        _id_8C18(var_0.name, var_0._id_A9D0);
        break;
      case "division_level_splash":
        _id_8C18(var_0.name, var_0._id_3054);
        break;
      default:
        break;
    }

    self.doingsplash[var_1] = var_0;

    if(isDefined(var_0.leadersound)) {
      if(isDefined(var_0.leadersoundgroup))
        maps\mp\_utility::leaderdialogonplayer(var_0.leadersound, var_0.leadersoundgroup, 1);
      else
        maps\mp\_utility::leaderdialogonplayer(var_0.leadersound);
    }

    self notify("actionNotifyMessage" + var_1);
    self endon("actionNotifyMessage" + var_1);
    self.doingsplash[var_1] = undefined;
  }

  if(self.splashqueue[var_1].size)
    thread dispatchnotify(var_1);
}

waitrequirevisibility(var_0) {
  var_1 = 0.05;

  while(!canreadtext())
    wait(var_1);

  while(var_0 > 0) {
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
  level endon("game_ended");
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
  var_0 = "default";

  if(isDefined(level._id_5F2A))
    var_0 = level._id_5F2A;

  var_1 = -140;
  var_2 = level.lowertextfontsize;
  var_3 = 1.25;

  if((level.splitscreen || self _meth_82D0() && !_func_0C1(self)) && !_func_3BA()) {
    var_1 = var_1 - 40;
    var_2 = level.lowertextfontsize * 1.3;
    var_3 = var_3 * 1.5;
  }

  self.lowermessage = maps\mp\gametypes\_hud_util::createfontstring(var_0, var_2);
  self.lowermessage settext("");
  self.lowermessage.archived = 0;
  self.lowermessage.sort = 10;
  self.lowermessage._id_0180 = 0;
  self.lowermessage maps\mp\gametypes\_hud_util::setpoint("CENTER", level.lowetextyalign, 0, var_1);
  self.lowertimer = maps\mp\gametypes\_hud_util::createfontstring("default", var_3);
  self.lowertimer maps\mp\gametypes\_hud_util::setparent(self.lowermessage);
  self.lowertimer maps\mp\gametypes\_hud_util::setpoint("TOP", "BOTTOM", 0, 0);
  self.lowertimer settext("");
  self.lowertimer.archived = 0;
  self.lowertimer.sort = 10;
  self.lowertimer._id_0180 = 0;
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
  if(isDefined(self.doingsplash[0]))
    return 1;

  if(isDefined(self.doingsplash[1]))
    return 1;

  if(isDefined(self.doingsplash[2]))
    return 1;

  if(isDefined(self.doingsplash[3]))
    return 1;

  return 0;
}

teamoutcomenotify(var_0, var_1, var_2, var_3) {
  self endon("disconnect");
  self notify("reset_outcome");
  thread _id_5CA5(32, 1);
  wait 0.5;
  var_4 = self.pers["team"];

  if(!isDefined(var_4) || var_4 != "allies" && var_4 != "axis")
    var_4 = "allies";

  while(isdoingsplash())
    waitframe();

  self endon("reset_outcome");
  var_5 = 0;

  if(level.gametype == "ctf" && isDefined(var_3) && var_3)
    var_5 = 1;

  if(var_0 == "halftime") {
    self _meth_82FF("ui_round_end_title", game["round_end"]["halftime"]);
    var_0 = "allies";

    if(level.gametype == "ctf")
      var_5 = 1;
  } else if(var_0 == "intermission") {
    self _meth_82FF("ui_round_end_title", game["round_end"]["intermission"]);
    var_0 = "allies";
  } else if(var_0 == "roundend") {
    self _meth_82FF("ui_round_end_title", game["round_end"]["roundend"]);
    var_0 = "allies";
  } else if(var_0 == "none")
    self _meth_82FF("ui_round_end_title", game["round_end"]["game_end"]);
  else if(maps\mp\_utility::_id_576C(var_0)) {
    self _meth_82FF("ui_round_end_title", game["round_end"]["overtime"]);

    if(level.gametype == "ctf" && var_0 == "overtime")
      var_5 = 1;

    var_0 = "allies";
  } else if(var_0 == "tie") {
    if(var_1)
      self _meth_82FF("ui_round_end_title", game["round_end"]["round_draw"]);
    else
      self _meth_82FF("ui_round_end_title", game["round_end"]["draw"]);

    var_0 = "allies";
  } else if(self _meth_8436())
    self _meth_82FF("ui_round_end_title", game["round_end"]["spectator"]);
  else if(isDefined(self.pers["team"]) && var_0 == var_4) {
    if(var_1)
      self _meth_82FF("ui_round_end_title", game["round_end"]["round_win"]);
    else
      self _meth_82FF("ui_round_end_title", game["round_end"]["victory"]);
  } else if(var_1)
    self _meth_82FF("ui_round_end_title", game["round_end"]["round_loss"]);
  else {
    self _meth_82FF("ui_round_end_title", game["round_end"]["defeat"]);

    if(isDefined(self._id_5969) && self._id_5969 && maps\mp\_utility::rankingenabled())
      var_2 = game["end_reason"]["loss_stat_prevented"];
  }

  self _meth_82FF("ui_round_end_reason", var_2);

  if(isDefined(level.gametyperoundendscoresetomnvar) && [[level.gametyperoundendscoresetomnvar]](var_0, var_1, var_2, var_3, var_4)) {} else if(var_5 && !level._id_AA24) {
    self _meth_82FF("ui_round_end_friendly_score", game["roundsWon"][var_4]);
    self _meth_82FF("ui_round_end_enemy_score", game["roundsWon"][level._id_6C63[var_4]]);
  } else if(!maps\mp\_utility::isroundbased() || !maps\mp\_utility::isobjectivebased()) {
    self _meth_82FF("ui_round_end_friendly_score", _id_04D2::_id_063E(var_4));
    self _meth_82FF("ui_round_end_enemy_score", _id_04D2::_id_063E(level._id_6C63[var_4]));
  } else {
    self _meth_82FF("ui_round_end_friendly_score", game["roundsWon"][var_4]);
    self _meth_82FF("ui_round_end_enemy_score", game["roundsWon"][level._id_6C63[var_4]]);
  }

  if(isDefined(self._id_6024))
    self _meth_82FF("ui_round_end_match_bonus", self._id_6024);

  if(isDefined(game["round_time_to_beat"]))
    self _meth_82FF("ui_round_end_stopwatch", int(game["round_time_to_beat"] * 60));

  self _meth_82FF("ui_round_end", 1);
}

outcomenotify(var_0, var_1) {
  self endon("disconnect");
  self notify("reset_outcome");

  while(isdoingsplash())
    waitframe();

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
    self _meth_82FF("ui_round_end_title", game["round_end"]["tie"]);
  else if(isDefined(var_3) && self == var_3)
    self _meth_82FF("ui_round_end_title", game["round_end"]["victory"]);
  else {
    self _meth_82FF("ui_round_end_title", game["round_end"]["defeat"]);

    if(isDefined(self._id_5969) && self._id_5969 && maps\mp\_utility::rankingenabled())
      var_1 = game["end_reason"]["loss_stat_prevented"];
  }

  self _meth_82FF("ui_round_end_reason", var_1);

  if(isDefined(self._id_6024))
    self _meth_82FF("ui_round_end_match_bonus", self._id_6024);

  self _meth_82FF("ui_round_end", 1);
  self waittill("update_outcome");
}

_id_1F6C(var_0) {}

_id_5CA5(var_0, var_1) {
  self _meth_82DD(var_0, var_1);
}

get_splash_table() {
  return "mp/splashTable.csv";
}

_id_8C18(var_0, var_1) {
  if(isDefined(self._id_7AD5) && self._id_7AD5 >= 6) {
    _id_788E(var_0, var_1);
    return;
  }

  if(!maps\mp\_utility::isreallyalive(self)) {
    _id_788E(var_0, var_1);
    return;
  }

  _id_8C19(var_0, var_1);
}

setbroadcasteromnvar(var_0, var_1) {
  foreach(var_3 in level.broadcasters) {
    if(isDefined(var_3._id_1E99) && isDefined(var_3._id_1E99._id_9815) && self == var_3._id_1E99._id_9815)
      var_3 _meth_82FF(var_0 + self._id_66CE, var_1);
  }
}

_id_8C19(var_0, var_1) {
  if(!isPlayer(self)) {
    return;
  }
  var_2 = _func_1B1(get_splash_table(), 0, var_0);

  if(!isDefined(var_2) || var_2 < 0) {
    return;
  }
  if(!isDefined(self._id_66CE))
    self._id_66CE = 0;

  if(!isDefined(self._id_9100))
    self._id_9100 = 1;

  var_3 = var_2 << 1;

  if(self._id_9100)
    var_3 = var_3 | 1;

  if(isDefined(var_1)) {
    self _meth_82FF("ui_player_splash_param_" + self._id_66CE, var_1);
    setbroadcasteromnvar("ui_player_splash_param_", var_1);
  } else {
    self _meth_82FF("ui_player_splash_param_" + self._id_66CE, -1);
    setbroadcasteromnvar("ui_player_splash_param_", -1);
  }

  self _meth_82FF("ui_player_splash_id_" + self._id_66CE, var_3);
  setbroadcasteromnvar("ui_player_splash_id_", var_3);

  if(!isDefined(self._id_7AD5))
    self._id_7AD5 = 1;
  else
    self._id_7AD5++;

  thread _id_2389();

  foreach(var_5 in level.broadcasters)
  var_5 thread cleanupbroadcastersplashlist();

  self._id_66CE++;

  if(self._id_66CE >= 6) {
    self._id_66CE = 0;
    self._id_9100 = !self._id_9100;
  }
}

_id_2389() {
  self endon("disconnect");
  self notify("cleanupLocalPlayerSplashList()");
  self endon("cleanupLocalPlayerSplashList()");
  common_scripts\utility::waittill_notify_or_timeout("death", 0.5);

  while(!maps\mp\_utility::isreallyalive(self))
    wait 0.15;

  self._id_7AD5 = undefined;
  self notify("splash_list_cleared");
}

cleanupbroadcastersplashlisttimeout() {
  self endon("disconnect");
  self endon("cleanupBroadcasterSplashList");
  wait 0.5;
  self._id_7AD5 = undefined;
  self notify("splash_list_cleared");
  self notify("broadcasterSplashListTimeOut");
}

cleanupbroadcastersplashlist() {
  self endon("disconnect");
  self endon("broadcasterSplashListTimeOut");
  self endon("cleanupBroadcasterSplashList");

  for(;;) {
    thread cleanupbroadcastersplashlisttimeout();
    self waittill("luinotifyserver", var_0, var_1);

    if(var_0 == "broadcaster_client_change") {
      var_2 = int(_func_0D4(var_1 / 100));

      if(var_2 == self.clientid) {
        self notify("cleanupBroadcasterSplashList");
        self._id_7AD5 = undefined;
        self notify("splash_list_cleared");
      }
    }
  }
}

_id_788E(var_0, var_1) {
  var_2 = spawnStruct();
  var_2._id_7B79 = var_0;
  var_2.optionalnumber = var_1;

  if(!isDefined(self._id_9107)) {
    self._id_9107 = var_2;
    self._id_9108 = var_2;
    thread _id_4AF7();
  } else {
    var_3 = self._id_9108;
    var_3._id_66CD = var_2;
    self._id_9108 = var_2;
  }
}

_id_4AF7() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");

  while(isDefined(self._id_9107)) {
    common_scripts\utility::_id_A70A("splash_list_cleared", "spawned_player");

    for(var_0 = 0; var_0 < 6; var_0++) {
      var_1 = self._id_9107;
      _id_8C19(var_1._id_7B79, var_1.optionalnumber);
      self._id_9107 = var_1._id_66CD;

      if(!isDefined(self._id_9107)) {
        break;
      }
    }
  }

  self._id_9108 = undefined;
}