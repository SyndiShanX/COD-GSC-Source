/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\cp_hud_message.gsc
*********************************************/

init() {
  level thread onplayerconnect();
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread hintmessagedeaththink();
    var_0 thread lowermessagethink();
    var_0 thread splashshownthink();
  }
}

showkillstreaksplash(var_0, var_1, var_2) {
  if(!isPlayer(self)) {
    return;
  }

  var_3 = spawnStruct();
  if(isDefined(var_2)) {
    var_0 = var_0 + "_" + var_2;
  }

  showsplash(var_0, var_1);
}

showchallengesplash(var_0, var_1) {
  var_2 = undefined;
  if(isDefined(var_1)) {
    var_2 = var_1;
  } else {
    var_2 = scripts\cp\cp_hud_util::mt_getstate(var_0) - 1;
  }

  var_3 = level.meritinfo[var_0]["displayParam"];
  if(!isDefined(var_3)) {
    var_3 = scripts\cp\cp_hud_util::mt_gettarget(var_0, var_2);
    if(var_3 == 0) {
      var_3 = 1;
    }

    var_4 = level.meritinfo[var_0]["paramScale"];
    if(isDefined(var_4)) {
      var_3 = int(var_3 / var_4);
    }
  }

  thread showsplash(var_0, var_3);
}

showsplash(var_0, var_1, var_2) {
  if(isDefined(self.recentsplashcount) && self.recentsplashcount >= 6) {
    queuesplash(var_0, var_1, var_2);
    return;
  }

  showsplashinternal(var_0, var_1, var_2);
}

showsplashinternal(var_0, var_1, var_2) {
  if(!isPlayer(self)) {
    return;
  }

  var_3 = tablelookuprownum(getsplashtablename(), 0, var_0);
  if(!isDefined(var_3) || var_3 < 0) {
    return;
  }

  if(!isDefined(self.nextsplashlistindex)) {
    self.nextsplashlistindex = 0;
  }

  if(!isDefined(self.splashlisttoggle)) {
    self.splashlisttoggle = 1;
  }

  var_4 = var_3;
  if(self.splashlisttoggle) {
    var_4 = var_4 | 2048;
  }

  if(isDefined(var_1)) {
    self setclientomnvar("ui_player_splash_param_" + self.nextsplashlistindex, var_1);
  } else {
    self setclientomnvar("ui_player_splash_param_" + self.nextsplashlistindex, -1);
  }

  if(isDefined(var_2)) {
    self setclientomnvar("ui_player_splash_cardClientId_" + self.nextsplashlistindex, var_2 getentitynumber());
  } else {
    self setclientomnvar("ui_player_splash_cardClientId_" + self.nextsplashlistindex, -1);
  }

  self setclientomnvar("ui_player_splashfunc_" + self.nextsplashlistindex, var_4);
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

queuesplash(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.ref = var_0;
  var_3.optionalnumber = var_1;
  var_3.playerforplayercard = var_2;
  if(!isDefined(self.splashqueuehead)) {
    self.splashqueuehead = var_3;
    self.splashqueuetail = var_3;
    thread handlesplashqueue();
    return;
  }

  var_4 = self.splashqueuetail;
  var_4.nextsplash = var_3;
  self.splashqueuetail = var_3;
}

handlesplashqueue() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  while(isDefined(self.splashqueuehead)) {
    self waittill("splash_list_cleared");
    for(var_0 = 0; var_0 < 6; var_0++) {
      var_1 = self.splashqueuehead;
      showsplashinternal(var_1.ref, var_1.optionalnumber, var_1.playerforplayercard);
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

  self.lowermessage = scripts\cp\utility::createfontstring(var_0, var_2);
  self.lowermessage settext("");
  self.lowermessage.archived = 0;
  self.lowermessage.sort = 10;
  self.lowermessage.showinkillcam = 0;
  self.lowermessage scripts\cp\utility::setpoint("CENTER", level.lowertextyalign, 0, var_1);
  self.lowertimer = scripts\cp\utility::createfontstring("default", var_3);
  self.lowertimer scripts\cp\utility::setparent(self.lowermessage);
  self.lowertimer scripts\cp\utility::setpoint("TOP", "BOTTOM", 0, 0);
  self.lowertimer settext("");
  self.lowertimer.archived = 0;
  self.lowertimer.sort = 10;
  self.lowertimer.showinkillcam = 0;
}

isdoingsplash() {
  return 0;
}

getsplashtablename() {
  return "cp\zombies\zombie_splashtable.csv";
}

cleanuplocalplayersplashlist() {
  self endon("disconnect");
  self notify("cleanupLocalPlayerSplashList()");
  self endon("cleanupLocalPlayerSplashList()");
  scripts\engine\utility::waittill_notify_or_timeout("death", 0.5);
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
        break;
    }
  }
}

onkillstreaksplashshown(var_0) {}

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

showmiscmessage(var_0) {
  var_1 = tablelookuprownum("mp\miscMessages.csv", 0, var_0);
  var_2 = tablelookupbyrow("mp\miscMessages.csv", var_1, 3);
  if(isDefined(var_2) && var_2 != "") {
    self playlocalsound(var_2);
  }

  self setclientomnvar("ui_misc_message_id", var_1);
  if(!isDefined(self.var_B7D7)) {
    self.var_B7D7 = 0;
  }

  self.var_B7D7 = !self.var_B7D7;
  self setclientomnvar("ui_misc_message_trigger", scripts\engine\utility::ter_op(self.var_B7D7, 1, 0));
}

hintmessagedeaththink() {
  self endon("disconnect");
  for(;;) {
    self waittill("death");
    if(isDefined(self.hintmessage)) {
      self.hintmessage scripts\cp\utility::destroyelem();
    }
  }
}

init_tutorial_message_array() {
  self setplayerdata("cp", "zombiePlayerLoadout", "tutorialOff", 1);
  self.hide_tutorial = 1;
  thread check_for_more_players();
}

check_for_more_players() {
  level waittill("multiple_players");
  self.hide_tutorial = 0;
  if(!isDefined(level.tutorial_interaction_1) || !isDefined(level.tutorial_interaction_2)) {
    return;
  }

  scripts\cp\cp_interaction::remove_from_current_interaction_list(level.tutorial_interaction_1);
  scripts\cp\cp_interaction::remove_from_current_interaction_list(level.tutorial_interaction_2);
}

tutorial_interaction() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self waittill("luinotifyserver", var_0);
  if(var_0 == "tutorial_off") {
    self setplayerdata("cp", "zombiePlayerLoadout", "tutorialOff", 1);
    self.hide_tutorial = 1;
  }

  if(var_0 == "tutorial_on") {
    self setplayerdata("cp", "zombiePlayerLoadout", "tutorialOff", 0);
    self.hide_tutorial = 0;
  }
}

tutorial_lookup_func(var_0) {
  if(!scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    return;
  }

  var_1 = level.players[0];
  if(var_1.hide_tutorial == 1) {
    return;
  }

  if(!isDefined(level.tutorial_message_table)) {
    return;
  }

  if(!shouldshowtutorial(var_0)) {
    return;
  }

  if(var_1 get_has_seen_tutorial(var_0)) {
    return;
  }

  if(var_0 != "null" && !scripts\engine\utility::istrue(level.tutorial_activated)) {
    level.tutorial_activated = 1;
    var_2 = int(tablelookup(level.tutorial_message_table, 1, var_0, 0));
    var_1 setclientomnvar("zm_tutorial_num", var_2);
    var_1 set_has_seen_tutorial(var_0, 1);
    level.tutorial_activated = undefined;
  }
}

set_has_seen_tutorial(var_0, var_1) {
  self setplayerdata("cp", "tutorial", var_0, "saw_message", var_1);
}

set_has_seen_perm_tutorial(var_0, var_1) {
  self setplayerdata("cp", "tutorialPerm", var_0, "saw_message", var_1);
}

get_has_seen_tutorial(var_0) {
  var_1 = self getplayerdata("cp", "tutorial", var_0, "saw_message");
  return var_1;
}

wait_for_tutorial_unpause() {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("luinotifyserver", var_0);
  if(var_0 == "tutorial_unpause") {
    setslowmotion(1, 1, 0);
  }
}

shouldshowtutorial(var_0) {
  if(isDefined(level.should_show_tutorial_func)) {
    return [[level.should_show_tutorial_func]](var_0);
  }

  return 1;
}

wait_and_play_tutorial_message(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self notify("clear_message");
  self endon("clear_message");
  wait(var_1);
  tutorial_lookup_func(var_0);
}