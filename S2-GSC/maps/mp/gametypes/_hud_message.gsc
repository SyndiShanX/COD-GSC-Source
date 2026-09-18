/**********************************************
 * Decompiled by Bog and Edited by SyndiShanX
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
    level waittill("connected", var_00);
    var_00 thread lowermessagethink();
    var_00 thread initnotifymessage();
  }
}

hintmessage(param_00) {
  var_01 = spawnStruct();
  var_01.notifytext = param_00;
  notifymessage(var_01);
}

initnotifymessage() {
  if((level.splitscreen || self issplitscreenplayer()) && !function_03BA()) {
    var_00 = 1.5;
    var_01 = 1.25;
    var_02 = 24;
    var_03 = "hudsmall";
    var_04 = "TOP";
    var_05 = "BOTTOM";
    var_06 = 0;
    var_07 = 0;
  } else {
    var_00 = 2.5;
    var_01 = 1.75;
    var_02 = 30;
    var_03 = "hudsmall";
    var_04 = "TOP";
    var_05 = "BOTTOM";
    var_06 = 50;
    var_07 = 0;
  }

  self.notifytitle = maps\mp\gametypes\_hud_util::createfontstring(var_03, var_00);
  self.notifytitle maps\mp\gametypes\_hud_util::setpoint(var_04, undefined, var_07, var_06);
  self.notifytitle.hidewheninmenu = 1;
  self.notifytitle.archived = 0;
  self.notifytitle.alpha = 0;
  self.notifytext = maps\mp\gametypes\_hud_util::createfontstring(var_03, var_01);
  self.notifytext maps\mp\gametypes\_hud_util::setparent(self.notifytitle);
  self.notifytext maps\mp\gametypes\_hud_util::setpoint(var_04, var_05, 0, 0);
  self.notifytext.hidewheninmenu = 1;
  self.notifytext.archived = 0;
  self.notifytext.alpha = 0;
  self.notifytext2 = maps\mp\gametypes\_hud_util::createfontstring(var_03, var_01);
  self.notifytext2 maps\mp\gametypes\_hud_util::setparent(self.notifytitle);
  self.notifytext2 maps\mp\gametypes\_hud_util::setpoint(var_04, var_05, 0, 0);
  self.notifytext2.hidewheninmenu = 1;
  self.notifytext2.archived = 0;
  self.notifytext2.alpha = 0;
  self.notifyicon = maps\mp\gametypes\_hud_util::createicon("white", var_02, var_02);
  self.notifyicon maps\mp\gametypes\_hud_util::setparent(self.notifytext2);
  self.notifyicon maps\mp\gametypes\_hud_util::setpoint(var_04, var_05, 0, 0);
  self.notifyicon.hidewheninmenu = 1;
  self.notifyicon.archived = 0;
  self.notifyicon.alpha = 0;
  self.notifyoverlay = maps\mp\gametypes\_hud_util::createicon("white", var_02, var_02);
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

oldnotifymessage(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = spawnStruct();
  var_06.titletext = param_00;
  var_06.notifytext = param_01;
  var_06.iconname = param_02;
  var_06.glowcolor = param_03;
  var_06.sound = param_04;
  var_06.duration = param_05;
  notifymessage(var_06);
}

notifymessage(param_00) {
  self endon("death");
  self endon("disconnect");
  if(!isDefined(param_00.slot)) {
    param_00.slot = 0;
  }

  var_01 = param_00.slot;
  if(!isDefined(param_00.type)) {
    param_00.type = "";
  }

  if(!isDefined(self.doingsplash[var_01])) {
    thread shownotifymessage(param_00);
    return;
  }

  self.splashqueue[var_01][self.splashqueue[var_01].size] = param_00;
}

dispatchnotify(param_00) {
  waittillframeend;
  var_01 = self.splashqueue[param_00][0];
  for(var_02 = 1; var_02 < self.splashqueue[param_00].size; var_02++) {
    self.splashqueue[param_00][var_02 - 1] = self.splashqueue[param_00][var_02];
  }

  self.splashqueue[param_00][var_02 - 1] = undefined;
  if(isDefined(var_01.name)) {
    func_0884(var_01);
    return;
  }

  shownotifymessage(var_01);
}

promotionsplashnotify() {
  if(!isPlayer(self)) {
    return;
  }

  self endon("disconnect");
  var_00 = spawnStruct();
  var_01 = "promotion";
  var_00.name = var_01;
  var_00.type = tablelookup(get_splash_table(), 0, var_01, 11);
  var_00.sound = tablelookup(get_splash_table(), 0, var_01, 9);
  var_00.slot = 0;
  thread func_0884(var_00);
}

ranksplashnotify(param_00) {
  if(!isPlayer(self)) {
    return;
  }

  self endon("disconnect");
  var_01 = spawnStruct();
  var_02 = "callout_rankPromoted";
  var_01.name = var_02;
  var_01.type = tablelookup(get_splash_table(), 0, var_02, 11);
  var_01.sound = tablelookup(get_splash_table(), 0, var_02, 9);
  var_01.var_73C1 = param_00;
  var_01.slot = 0;
  if(var_01.type == "playercard_splash") {
    var_01.slot = 1;
  }

  thread func_0884(var_01);
}

shownotifymessage(param_00) {
  self endon("disconnect");
  var_01 = param_00.slot;
  if(level.gameended) {
    if(isDefined(param_00.type) && param_00.type == "rank") {
      self setclientdvar("ui_promotion", 1);
      self.postgamepromotion = 1;
    }

    if(self.splashqueue[var_01].size) {
      thread dispatchnotify(var_01);
    }

    return;
  }

  self.doingsplash[var_01] = param_00;
  thread resetoncancel();
  waitrequirevisibility(0);
  if(isDefined(param_00.duration)) {
    var_02 = param_00.duration;
  } else if(level.gameended) {
    var_02 = 2;
  } else {
    var_02 = 4;
  }

  if(isDefined(param_00.sound)) {
    self playlocalsound(param_00.sound);
  }

  if(isDefined(param_00.leadersound)) {
    maps\mp\_utility::leaderdialogonplayer(param_00.leadersound);
  }

  var_03 = param_00.glowcolor;
  var_04 = self.notifytitle;
  if(isDefined(param_00.titletext)) {
    if(isDefined(param_00.titlelabel)) {
      self.notifytitle.label = param_00.titlelabel;
    } else {
      self.notifytitle.label = &"";
    }

    if(isDefined(param_00.titlelabel) && !isDefined(param_00.titleisstring)) {
      self.notifytitle setvalue(param_00.titletext);
    } else {
      self.notifytitle settext(param_00.titletext);
    }

    if(isDefined(var_03)) {
      self.notifytitle.glowcolor = var_03;
    }

    self.notifytitle.alpha = 1;
    self.notifytitle fadeovertime(var_02 * 1.25);
    self.notifytitle.alpha = 0;
  }

  if(isDefined(param_00.textglowcolor)) {
    var_03 = param_00.textglowcolor;
  }

  if(isDefined(param_00.notifytext)) {
    if(isDefined(param_00.var_992E)) {
      self.notifytext.label = param_00.var_992E;
    } else {
      self.notifytext.label = &"";
    }

    if(isDefined(param_00.var_992E) && !isDefined(param_00.var_992D)) {
      self.notifytext setvalue(param_00.notifytext);
    } else {
      self.notifytext settext(param_00.notifytext);
    }

    if(isDefined(var_03)) {
      self.notifytext.glowcolor = var_03;
    }

    self.notifytext.alpha = 1;
    self.notifytext fadeovertime(var_02 * 1.25);
    self.notifytext.alpha = 0;
    var_04 = self.notifytext;
  }

  if(isDefined(param_00.notifytext2)) {
    self.notifytext2 maps\mp\gametypes\_hud_util::setparent(var_04);
    if(isDefined(param_00.text2label)) {
      self.notifytext2.label = param_00.text2label;
    } else {
      self.notifytext2.label = &"";
    }

    self.notifytext2 settext(param_00.notifytext2);
    if(isDefined(var_03)) {
      self.notifytext2.glowcolor = var_03;
    }

    self.notifytext2.alpha = 1;
    self.notifytext2 fadeovertime(var_02 * 1.25);
    self.notifytext2.alpha = 0;
    var_04 = self.notifytext2;
  }

  if(isDefined(param_00.iconname)) {
    self.notifyicon maps\mp\gametypes\_hud_util::setparent(var_04);
    if((level.splitscreen || self issplitscreenplayer()) && !function_03BA()) {
      self.notifyicon setshader(param_00.iconname, 30, 30);
    } else {
      self.notifyicon setshader(param_00.iconname, 60, 60);
    }

    self.notifyicon.alpha = 0;
    if(isDefined(param_00.iconoverlay)) {
      self.notifyicon fadeovertime(0.15);
      self.notifyicon.alpha = 1;
      param_00.overlayoffsety = 0;
      self.notifyoverlay maps\mp\gametypes\_hud_util::setparent(self.notifyicon);
      self.notifyoverlay maps\mp\gametypes\_hud_util::setpoint("CENTER", "CENTER", 0, param_00.overlayoffsety);
      self.notifyoverlay setshader(param_00.iconoverlay, 511, 511);
      self.notifyoverlay.alpha = 0;
      self.notifyoverlay.color = game["colors"]["orange"];
      self.notifyoverlay fadeovertime(0.4);
      self.notifyoverlay.alpha = 0.85;
      self.notifyoverlay scaleovertime(0.4, 32, 32);
      waitrequirevisibility(var_02);
      self.notifyicon fadeovertime(0.75);
      self.notifyicon.alpha = 0;
      self.notifyoverlay fadeovertime(0.75);
      self.notifyoverlay.alpha = 0;
    } else {
      self.notifyicon fadeovertime(1);
      self.notifyicon.alpha = 1;
      waitrequirevisibility(var_02);
      self.notifyicon fadeovertime(0.75);
      self.notifyicon.alpha = 0;
    }
  } else {
    waitrequirevisibility(var_02);
  }

  self notify("notifyMessageDone");
  self.doingsplash[var_01] = undefined;
  if(self.splashqueue[var_01].size) {
    thread dispatchnotify(var_01);
  }
}

func_265F(param_00, param_01) {
  if(!isPlayer(self)) {
    return;
  }

  self endon("disconnect");
  waittillframeend;
  if(level.gameended) {
    return;
  }

  var_02 = spawnStruct();
  var_02.name = param_00;
  var_02.type = tablelookup(get_splash_table(), 0, param_00, 11);
  var_02.optionalnumber = 0;
  var_02.sound = tablelookup(get_splash_table(), 0, param_00, 9);
  var_02.leadersound = param_01;
  var_02.slot = 0;
  thread func_0884(var_02);
}

killstreaksplashnotify(param_00, param_01, param_02, param_03, param_04) {
  if(!isPlayer(self)) {
    return;
  }

  self endon("disconnect");
  waittillframeend;
  if(level.gameended) {
    return;
  }

  var_05 = spawnStruct();
  if(isDefined(param_02)) {
    param_00 = param_00 + "_" + param_02;
  }

  if(!isDefined(param_03)) {
    param_03 = -1;
  }

  var_05.name = param_00;
  var_05.type = tablelookup(get_splash_table(), 0, param_00, 11);
  var_05.optionalnumber = param_01;
  var_05.sound = maps\mp\_utility::func_4547(param_00);
  var_05.leadersound = param_00;
  var_05.leadersoundgroup = "killstreak_earned";
  var_05.slot = 0;
  var_05.var_5A76 = param_03;
  if(isDefined(param_04)) {
    var_05.leadersound = param_04;
  }

  thread func_0884(var_05);
}

challengesplashnotify(param_00, param_01, param_02) {
  if(!isPlayer(self)) {
    return;
  }

  self endon("disconnect");
  waittillframeend;
  wait 0.05;
  for(var_03 = param_02 - 1; var_03 >= param_01; var_03--) {
    var_04 = maps\mp\gametypes\_hud_util::ch_gettarget(param_00, var_03);
    if(var_04 == 0) {
      var_04 = 1;
    }

    if(param_00 == "ch_exomech_frontier") {
      var_04 = int(var_04 / 528);
    }

    var_05 = spawnStruct();
    var_05.name = param_00;
    var_05.type = tablelookup(get_splash_table(), 0, param_00, 11);
    var_05.var_20AC = var_03;
    var_05.optionalnumber = var_04;
    var_05.sound = tablelookup(get_splash_table(), 0, param_00, 9);
    var_05.slot = 0;
    thread func_0884(var_05);
  }
}

func_9102(param_00, param_01, param_02) {
  if(!isPlayer(self)) {
    return;
  }

  self endon("disconnect");
  wait 0.05;
  var_03 = spawnStruct();
  var_03.name = param_00;
  var_03.type = tablelookup(get_splash_table(), 0, param_00, 11);
  var_03.optionalnumber = param_01;
  var_03.sound = tablelookup(get_splash_table(), 0, var_03.name, 9);
  if(!isDefined(param_02)) {
    param_02 = -1;
  }

  var_03.var_5A76 = param_02;
  var_03.slot = 0;
  if(common_scripts\utility::func_562E(level.var_2FA1)) {
    switch (var_03.type) {
      case "specialist_splash":
      case "challenge_splash":
      case "rankup_splash":
      case "largewar_splash":
      case "playercard_splash":
        break;

      default:
        break;
    }
  }

  thread func_0884(var_03);
}

func_9104(param_00, param_01) {
  if(!isPlayer(self)) {
    return;
  }

  self endon("disconnect");
  wait 0.05;
  var_02 = spawnStruct();
  var_02.name = param_00;
  var_02.type = tablelookup(get_splash_table(), 0, param_00, 11);
  var_02.optionalnumber = param_01;
  var_02.sound = tablelookup(get_splash_table(), 0, param_00, 9);
  var_02.slot = 0;
  thread func_0884(var_02);
}

func_9103(param_00, param_01) {
  if(!isPlayer(self)) {
    return;
  }

  self endon("disconnect");
  waittillframeend;
  if(level.gameended) {
    return;
  }

  var_02 = spawnStruct();
  var_02.name = param_00;
  var_02.type = tablelookup(get_splash_table(), 0, param_00, 11);
  var_02.optionalnumber = param_01;
  var_02.sound = tablelookup(get_splash_table(), 0, param_00, 9);
  var_02.slot = 0;
  thread func_0884(var_02);
}

func_7A6C(param_00, param_01, param_02) {
  if(!isPlayer(self)) {
    return;
  }

  self endon("disconnect");
  waittillframeend;
  if(level.gameended) {
    return;
  }

  var_03 = spawnStruct();
  var_03.name = param_00;
  var_03.type = tablelookup(get_splash_table(), 0, param_00, 11);
  var_03.sound = tablelookup(get_splash_table(), 0, param_00, 9);
  var_03.var_7A65 = param_01;
  if(isDefined(param_02)) {
    var_03.var_76B0 = param_02;
  }

  var_03.slot = 0;
  thread func_0884(var_03);
}

func_A9DD(param_00, param_01, param_02) {
  if(!isPlayer(self)) {
    return;
  }

  self endon("disconnect");
  waittillframeend;
  if(level.gameended) {
    return;
  }

  var_03 = spawnStruct();
  var_03.name = param_00;
  var_03.type = tablelookup(get_splash_table(), 0, param_00, 11);
  var_03.sound = tablelookup(get_splash_table(), 0, param_00, 9);
  var_03.var_A9D0 = param_02;
  var_03.slot = 0;
  thread func_0884(var_03);
}

func_3055(param_00, param_01) {
  if(!isPlayer(self)) {
    return;
  }

  self endon("disconnect");
  waittillframeend;
  if(level.gameended) {
    return;
  }

  var_02 = spawnStruct();
  var_02.name = param_00;
  var_02.type = tablelookup(get_splash_table(), 0, param_00, 11);
  var_02.sound = tablelookup(get_splash_table(), 0, param_00, 9);
  var_02.var_3054 = param_01;
  var_02.slot = 0;
  thread func_0884(var_02);
}

playercardsplashnotify(param_00, param_01, param_02) {
  if(!isPlayer(self)) {
    return;
  }

  self endon("disconnect");
  waittillframeend;
  if(level.gameended) {
    return;
  }

  var_03 = spawnStruct();
  var_03.name = param_00;
  var_03.type = tablelookup(get_splash_table(), 0, param_00, 11);
  var_03.optionalnumber = param_02;
  var_03.sound = tablelookup(get_splash_table(), 0, param_00, 9);
  var_03.var_73C1 = param_01;
  var_03.slot = 0;
  if(var_03.type == "playercard_splash") {
    var_03.slot = 1;
  }

  thread func_0884(var_03);
}

func_0884(param_00) {
  self endon("death");
  self endon("disconnect");
  var_01 = param_00.slot;
  if(!isDefined(param_00.type)) {
    param_00.type = "";
  }

  if(!isDefined(self.doingsplash[var_01])) {
    thread func_0885(param_00);
    return;
  } else {
    switch (param_00.type) {
      case "urgent_splash":
      case "specialist_splash":
      case "largewar_splash":
        self.notifytext.alpha = 0;
        self.notifytext2.alpha = 0;
        self.notifyicon.alpha = 0;
        self setclientomnvar("ui_splash_idx", -1);
        self setclientomnvar("ui_splash_killstreak_idx", -1);
        self setclientomnvar("ui_daily_challenge_idx", -1);
        thread func_0885(param_00);
        break;

      case "daily_challenge_splash":
      case "splash":
      case "killstreak_splash":
      case "killstreak_coop_splash":
        if(self.doingsplash[var_01].type != "splash" && self.doingsplash[var_01].type != "urgent_splash" && self.doingsplash[var_01].type != "largewar_splash" && self.doingsplash[var_01].type != "killstreak_coop_splash" && self.doingsplash[var_01].type != "killstreak_splash" && self.doingsplash[var_01].type != "challenge_splash" && self.doingsplash[var_01].type != "promotion_splash" && self.doingsplash[var_01].type != "intel_splash" && self.doingsplash[var_01].type != "rankup_splash" && self.doingsplash[var_01].type != "weapon_level_splash" && self.doingsplash[var_01].type != "division_level_splash" && self.doingsplash[var_01].type != "daily_challenge_splash" && self.doingsplash[var_01].type != "specialist_splash") {
          self.notifytext.alpha = 0;
          self.notifytext2.alpha = 0;
          self.notifyicon.alpha = 0;
          thread func_0885(param_00);
          return;
        }
        break;
    }
  }

  if(param_00.type == "challenge_splash" || param_00.type == "killstreak_splash" || param_00.type == "killstreak_coop_splash" || param_00.type == "daily_challenge_splash") {
    if(param_00.type == "daily_challenge_splash" && self.splashqueue[var_01].size > 0) {
      var_02 = "";
      if(issubstr(param_00.name, "_complete")) {
        var_02 = "_complete";
      }

      foreach(var_04 in self.splashqueue[var_01]) {
        if(var_04.name + var_02 == param_00.name) {
          self.splashqueue[var_01] = common_scripts\utility::func_F93(self.splashqueue[var_01], var_04);
          break;
        }
      }
    }

    for(var_06 = self.splashqueue[var_01].size; var_06 > 0; var_06--) {
      self.splashqueue[var_01][var_06] = self.splashqueue[var_01][var_06 - 1];
    }

    self.splashqueue[var_01][0] = param_00;
    return;
  }

  self.splashqueue[var_01][self.splashqueue[var_01].size] = param_00;
}

func_0885(param_00) {
  self endon("disconnect");
  var_01 = param_00.slot;
  if(level.gameended) {
    if(isDefined(param_00.type) && param_00.type == "promotion_splash" || param_00.type == "promotion_weapon_splash") {
      self setclientdvar("ui_promotion", 1);
      self.postgamepromotion = 1;
    } else if(isDefined(param_00.type) && param_00.type == "challenge_splash") {
      self.pers["postGameChallenges"]++;
      self setclientdvar("ui_challenge_" + self.pers["postGameChallenges"] + "_ref", param_00.name);
    }

    if(self.splashqueue[var_01].size) {
      thread dispatchnotify(var_01);
    }

    return;
  }

  if(!isDefined(self.var_66CE)) {
    self.var_66CE = 0;
  }

  if(tablelookup(get_splash_table(), 0, param_00.name, 0) != "") {
    var_02 = tablelookuprownum(get_splash_table(), 0, param_00.name);
    var_03 = common_scripts\utility::stringtofloat(tablelookupbyrow(get_splash_table(), var_02, 4));
    switch (param_00.type) {
      case "killstreak_splash":
      case "killstreak_coop_splash":
        if(getdvarint("5270", 1)) {
          func_8C18(param_00.name, param_00.var_5A76);
        }
        break;

      case "playercard_splash":
        if(isDefined(param_00.var_73C1)) {
          self setclientomnvar("ui_splash_playercard_idx", var_02);
          if(isPlayer(param_00.var_73C1)) {
            self setclientomnvar("ui_splash_playercard_clientnum", param_00.var_73C1 getentitynumber());
          }

          if(isDefined(param_00.optionalnumber)) {
            self setclientomnvar("ui_splash_playercard_optional_number", param_00.optionalnumber);
          }
        }
        break;

      case "perk_challenge_splash":
      case "intel_splash":
      case "daily_challenge_splash":
      case "splash":
      case "urgent_splash":
      case "specialist_splash":
      case "challenge_splash":
      case "largewar_splash":
        func_8C18(param_00.name, param_00.optionalnumber);
        break;

      case "rankup_splash":
        func_8C18(param_00.name, param_00.var_7A65);
        break;

      case "weapon_level_splash":
        func_8C18(param_00.name, param_00.var_A9D0);
        break;

      case "division_level_splash":
        func_8C18(param_00.name, param_00.var_3054);
        break;

      default:
        break;
    }

    self.doingsplash[var_01] = param_00;
    if(isDefined(param_00.leadersound)) {
      if(isDefined(param_00.leadersoundgroup)) {
        maps\mp\_utility::leaderdialogonplayer(param_00.leadersound, param_00.leadersoundgroup, 1);
      } else {
        maps\mp\_utility::leaderdialogonplayer(param_00.leadersound);
      }
    }

    self notify("actionNotifyMessage" + var_01);
    self endon("actionNotifyMessage" + var_01);
    self.doingsplash[var_01] = undefined;
  }

  if(self.splashqueue[var_01].size) {
    thread dispatchnotify(var_01);
  }
}

waitrequirevisibility(param_00) {
  var_01 = 0.05;
  while(!canreadtext()) {
    wait(var_01);
  }

  while(param_00 > 0) {
    wait(var_01);
    if(canreadtext()) {
      param_00 = param_00 - var_01;
    }
  }
}

canreadtext() {
  if(maps\mp\_flashgrenades::isflashbanged()) {
    return 0;
  }

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
  var_00 = "default";
  if(isDefined(level.var_5F2A)) {
    var_00 = level.var_5F2A;
  }

  var_01 = -140;
  var_02 = level.lowertextfontsize;
  var_03 = 1.25;
  if((level.splitscreen || self issplitscreenplayer() && !isai(self)) && !function_03BA()) {
    var_01 = var_01 - 40;
    var_02 = level.lowertextfontsize * 1.3;
    var_03 = var_03 * 1.5;
  }

  self.lowermessage = maps\mp\gametypes\_hud_util::createfontstring(var_00, var_02);
  self.lowermessage settext("");
  self.lowermessage.archived = 0;
  self.lowermessage.sort = 10;
  self.lowermessage.showinkillcam = 0;
  self.lowermessage maps\mp\gametypes\_hud_util::setpoint("CENTER", level.lowetextyalign, 0, var_01);
  self.lowertimer = maps\mp\gametypes\_hud_util::createfontstring("default", var_03);
  self.lowertimer maps\mp\gametypes\_hud_util::setparent(self.lowermessage);
  self.lowertimer maps\mp\gametypes\_hud_util::setpoint("TOP", "BOTTOM", 0, 0);
  self.lowertimer settext("");
  self.lowertimer.archived = 0;
  self.lowertimer.sort = 10;
  self.lowertimer.showinkillcam = 0;
}

outcomeoverlay(param_00) {
  if(level.teambased) {
    if(param_00 == "tie") {
      matchoutcomenotify("draw");
      return;
    }

    if(param_00 == self.team) {
      matchoutcomenotify("victory");
      return;
    }

    matchoutcomenotify("defeat");
    return;
  }

  if(param_00 == self) {
    matchoutcomenotify("victory");
    return;
  }

  matchoutcomenotify("defeat");
}

matchoutcomenotify(param_00) {
  var_01 = self.team;
  var_02 = maps\mp\gametypes\_hud_util::createfontstring("bigfixed", 1);
  var_02 maps\mp\gametypes\_hud_util::setpoint("TOP", undefined, 0, 50);
  var_02.foreground = 1;
  var_02.glowalpha = 1;
  var_02.hidewheninmenu = 0;
  var_02.archived = 0;
  var_02 settext(game["strings"][param_00]);
  var_02.alpha = 0;
  var_02 fadeovertime(0.5);
  var_02.alpha = 1;
  switch (param_00) {
    case "victory":
      var_02.glowcolor = game["colors"]["cyan"];
      break;

    default:
      var_02.glowcolor = game["colors"]["orange"];
      break;
  }

  var_03 = maps\mp\gametypes\_hud_util::createicon(game["icons"][var_01], 64, 64);
  var_03 maps\mp\gametypes\_hud_util::setparent(var_02);
  var_03 maps\mp\gametypes\_hud_util::setpoint("TOP", "BOTTOM", 0, 30);
  var_03.foreground = 1;
  var_03.hidewheninmenu = 0;
  var_03.archived = 0;
  var_03.alpha = 0;
  var_03 fadeovertime(0.5);
  var_03.alpha = 1;
  wait(3);
  var_02 maps\mp\gametypes\_hud_util::destroyelem();
  var_03 maps\mp\gametypes\_hud_util::destroyelem();
}

isdoingsplash() {
  if(isDefined(self.doingsplash[0])) {
    return 1;
  }

  if(isDefined(self.doingsplash[1])) {
    return 1;
  }

  if(isDefined(self.doingsplash[2])) {
    return 1;
  }

  if(isDefined(self.doingsplash[3])) {
    return 1;
  }

  return 0;
}

teamoutcomenotify(param_00, param_01, param_02, param_03) {
  self endon("disconnect");
  self notify("reset_outcome");
  thread func_5CA5(32, 1);
  wait(0.5);
  var_04 = self.pers["team"];
  if(!isDefined(var_04) || var_04 != "allies" && var_04 != "axis") {
    var_04 = "allies";
  }

  while(isdoingsplash()) {
    wait 0.05;
  }

  self endon("reset_outcome");
  var_05 = 0;
  if(level.gametype == "ctf" && isDefined(param_03) && param_03) {
    var_05 = 1;
  }

  if(param_00 == "halftime") {
    self setclientomnvar("ui_round_end_title", game["round_end"]["halftime"]);
    param_00 = "allies";
    if(level.gametype == "ctf") {
      var_05 = 1;
    }
  } else if(param_00 == "intermission") {
    self setclientomnvar("ui_round_end_title", game["round_end"]["intermission"]);
    param_00 = "allies";
  } else if(param_00 == "roundend") {
    self setclientomnvar("ui_round_end_title", game["round_end"]["roundend"]);
    param_00 = "allies";
  } else if(param_00 == "none") {
    self setclientomnvar("ui_round_end_title", game["round_end"]["game_end"]);
  } else if(maps\mp\_utility::func_576C(param_00)) {
    self setclientomnvar("ui_round_end_title", game["round_end"]["overtime"]);
    if(level.gametype == "ctf" && param_00 == "overtime") {
      var_05 = 1;
    }

    param_00 = "allies";
  } else if(param_00 == "tie") {
    if(param_01) {
      self setclientomnvar("ui_round_end_title", game["round_end"]["round_draw"]);
    } else {
      self setclientomnvar("ui_round_end_title", game["round_end"]["draw"]);
    }

    param_00 = "allies";
  } else if(self method_8436()) {
    self setclientomnvar("ui_round_end_title", game["round_end"]["spectator"]);
  } else if(isDefined(self.pers["team"]) && param_00 == var_04) {
    if(param_01) {
      self setclientomnvar("ui_round_end_title", game["round_end"]["round_win"]);
    } else {
      self setclientomnvar("ui_round_end_title", game["round_end"]["victory"]);
    }
  } else if(param_01) {
    self setclientomnvar("ui_round_end_title", game["round_end"]["round_loss"]);
  } else {
    self setclientomnvar("ui_round_end_title", game["round_end"]["defeat"]);
    if(isDefined(self.var_5969) && self.var_5969 && maps\mp\_utility::rankingenabled()) {
      param_02 = game["end_reason"]["loss_stat_prevented"];
    }
  }

  self setclientomnvar("ui_round_end_reason", param_02);
  if(isDefined(level.gametyperoundendscoresetomnvar) && [[level.gametyperoundendscoresetomnvar]](param_00, param_01, param_02, param_03, var_04)) {} else if(var_05 && !level.var_AA24) {
    self setclientomnvar("ui_round_end_friendly_score", game["roundsWon"][var_04]);
    self setclientomnvar("ui_round_end_enemy_score", game["roundsWon"][level.var_6C63[var_04]]);
  } else if(!maps\mp\_utility::isroundbased() || !maps\mp\_utility::isobjectivebased()) {
    self setclientomnvar("ui_round_end_friendly_score", maps\mp\gametypes\_gamescore::func_63E(var_04));
    self setclientomnvar("ui_round_end_enemy_score", maps\mp\gametypes\_gamescore::func_63E(level.var_6C63[var_04]));
  } else {
    self setclientomnvar("ui_round_end_friendly_score", game["roundsWon"][var_04]);
    self setclientomnvar("ui_round_end_enemy_score", game["roundsWon"][level.var_6C63[var_04]]);
  }

  if(isDefined(self.matchbonus)) {
    self setclientomnvar("ui_round_end_match_bonus", self.matchbonus);
  }

  if(isDefined(game["round_time_to_beat"])) {
    self setclientomnvar("ui_round_end_stopwatch", int(game["round_time_to_beat"] * 60));
  }

  self setclientomnvar("ui_round_end", 1);
}

outcomenotify(param_00, param_01) {
  self endon("disconnect");
  self notify("reset_outcome");
  while(isdoingsplash()) {
    wait 0.05;
  }

  self endon("reset_outcome");
  var_02 = level.placement["all"];
  var_03 = var_02[0];
  var_04 = var_02[1];
  var_05 = var_02[2];
  var_06 = 0;
  if(isDefined(var_03) && self.score == var_03.score && self.deaths == var_03.deaths) {
    if(self != var_03) {
      var_06 = 1;
    } else if(isDefined(var_04) && var_04.score == var_03.score && var_04.deaths == var_03.deaths) {
      var_06 = 1;
    }
  }

  if(var_06) {
    self setclientomnvar("ui_round_end_title", game["round_end"]["tie"]);
  } else if(isDefined(var_03) && self == var_03) {
    self setclientomnvar("ui_round_end_title", game["round_end"]["victory"]);
  } else {
    self setclientomnvar("ui_round_end_title", game["round_end"]["defeat"]);
    if(isDefined(self.var_5969) && self.var_5969 && maps\mp\_utility::rankingenabled()) {
      param_01 = game["end_reason"]["loss_stat_prevented"];
    }
  }

  self setclientomnvar("ui_round_end_reason", param_01);
  if(isDefined(self.matchbonus)) {
    self setclientomnvar("ui_round_end_match_bonus", self.matchbonus);
  }

  self setclientomnvar("ui_round_end", 1);
  self waittill("update_outcome");
}

func_1F6C(param_00) {}

func_5CA5(param_00, param_01) {
  self setblurforplayer(param_00, param_01);
}

get_splash_table() {
  return "mp/splashTable.csv";
}

func_8C18(param_00, param_01) {
  if(isDefined(self.var_7AD5) && self.var_7AD5 >= 6) {
    func_788E(param_00, param_01);
    return;
  }

  if(!maps\mp\_utility::isreallyalive(self)) {
    func_788E(param_00, param_01);
    return;
  }

  func_8C19(param_00, param_01);
}

setbroadcasteromnvar(param_00, param_01) {
  foreach(var_03 in level.broadcasters) {
    if(isDefined(var_03.var_1E99) && isDefined(var_03.var_1E99.var_9815) && self == var_03.var_1E99.var_9815) {
      var_03 setclientomnvar(param_00 + self.var_66CE, param_01);
    }
  }
}

func_8C19(param_00, param_01) {
  if(!isPlayer(self)) {
    return;
  }

  var_02 = tablelookuprownum(get_splash_table(), 0, param_00);
  if(!isDefined(var_02) || var_02 < 0) {
    return;
  }

  if(!isDefined(self.var_66CE)) {
    self.var_66CE = 0;
  }

  if(!isDefined(self.var_9100)) {
    self.var_9100 = 1;
  }

  var_03 = var_02 << 1;
  if(self.var_9100) {
    var_03 = var_03 | 1;
  }

  if(isDefined(param_01)) {
    self setclientomnvar("ui_player_splash_param_" + self.var_66CE, param_01);
    setbroadcasteromnvar("ui_player_splash_param_", param_01);
  } else {
    self setclientomnvar("ui_player_splash_param_" + self.var_66CE, -1);
    setbroadcasteromnvar("ui_player_splash_param_", -1);
  }

  self setclientomnvar("ui_player_splash_id_" + self.var_66CE, var_03);
  setbroadcasteromnvar("ui_player_splash_id_", var_03);
  if(!isDefined(self.var_7AD5)) {
    self.var_7AD5 = 1;
  } else {
    self.var_7AD5++;
  }

  thread func_2389();
  foreach(var_05 in level.broadcasters) {
    var_05 thread cleanupbroadcastersplashlist();
  }

  self.var_66CE++;
  if(self.var_66CE >= 6) {
    self.var_66CE = 0;
    self.var_9100 = !self.var_9100;
  }
}

func_2389() {
  self endon("disconnect");
  self notify("cleanupLocalPlayerSplashList()");
  self endon("cleanupLocalPlayerSplashList()");
  common_scripts\utility::waittill_notify_or_timeout("death", 0.5);
  while(!maps\mp\_utility::isreallyalive(self)) {
    wait(0.15);
  }

  self.var_7AD5 = undefined;
  self notify("splash_list_cleared");
}

cleanupbroadcastersplashlisttimeout() {
  self endon("disconnect");
  self endon("cleanupBroadcasterSplashList");
  wait(0.5);
  self.var_7AD5 = undefined;
  self notify("splash_list_cleared");
  self notify("broadcasterSplashListTimeOut");
}

cleanupbroadcastersplashlist() {
  self endon("disconnect");
  self endon("broadcasterSplashListTimeOut");
  self endon("cleanupBroadcasterSplashList");
  for(;;) {
    thread cleanupbroadcastersplashlisttimeout();
    self waittill("luinotifyserver", var_00, var_01);
    if(var_00 == "broadcaster_client_change") {
      var_02 = int(floor(var_01 / 100));
      if(var_02 == self.clientid) {
        self notify("cleanupBroadcasterSplashList");
        self.var_7AD5 = undefined;
        self notify("splash_list_cleared");
      }
    }
  }
}

func_788E(param_00, param_01) {
  var_02 = spawnStruct();
  var_02.var_7B79 = param_00;
  var_02.optionalnumber = param_01;
  if(!isDefined(self.var_9107)) {
    self.var_9107 = var_02;
    self.var_9108 = var_02;
    thread func_4AF7();
    return;
  }

  var_03 = self.var_9108;
  var_03.var_66CD = var_02;
  self.var_9108 = var_02;
}

func_4AF7() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  while(isDefined(self.var_9107)) {
    common_scripts\utility::waittill_any("splash_list_cleared", "spawned_player");
    for(var_00 = 0; var_00 < 6; var_00++) {
      var_01 = self.var_9107;
      func_8C19(var_01.var_7B79, var_01.optionalnumber);
      self.var_9107 = var_01.var_66CD;
      if(!isDefined(self.var_9107)) {
        break;
      }
    }
  }

  self.var_9108 = undefined;
}