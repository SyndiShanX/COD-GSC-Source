/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2647.gsc
***************************************/

init() {
  level thread onplayerconnect();
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_00);
    var_00 thread hintmessagedeaththink();
    var_00 thread lowermessagethink();
    var_00 thread splashshownthink();
  }
}

showkillstreaksplash(var_00, var_01, var_02) {
  if(!isplayer(self)) {
    return;
  }
  var_03 = spawnStruct();

  if(isDefined(var_02)) {
    var_00 = var_00 + ("_" + var_02);
  }

  showsplash(var_00, var_01);
}

showchallengesplash(var_00, var_01) {
  var_02 = undefined;

  if(isDefined(var_01)) {
    var_02 = var_01;
  }
  else {
    var_02 = scripts\cp\cp_hud_util::mt_getstate(var_00) - 1;
  }

  var_03 = level.meritinfo[var_00]["displayParam"];

  if(!isDefined(var_03)) {
    var_03 = scripts\cp\cp_hud_util::mt_gettarget(var_00, var_02);

    if(var_03 == 0) {
      var_03 = 1;
    }

    var_04 = level.meritinfo[var_00]["paramScale"];

    if(isDefined(var_04)) {
      var_03 = int(var_03 / var_04);
    }
  }

  thread showsplash(var_00, var_03);
}

showsplash(var_00, var_01, var_02) {
  if(isDefined(self.recentsplashcount) && self.recentsplashcount >= 6) {
    queuesplash(var_00, var_01, var_02);
    return;
  }

  showsplashinternal(var_00, var_01, var_02);
}

showsplashinternal(var_00, var_01, var_02) {
  if(!isplayer(self)) {
    return;
  }
  var_03 = tablelookuprownum(getsplashtablename(), 0, var_00);

  if(!isDefined(var_03) || var_03 < 0) {
    return;
  }
  if(!isDefined(self.nextsplashlistindex)) {
    self.nextsplashlistindex = 0;
  }

  if(!isDefined(self.splashlisttoggle)) {
    self.splashlisttoggle = 1;
  }

  var_04 = var_03;

  if(self.splashlisttoggle) {
    var_04 = var_04 | 1024;
  }

  if(isDefined(var_01)) {
    self setclientomnvar("ui_player_splash_param_" + self.nextsplashlistindex, var_01);
  }
  else {
    self setclientomnvar("ui_player_splash_param_" + self.nextsplashlistindex, -1);
  }

  if(isDefined(var_02)) {
    self setclientomnvar("ui_player_splash_cardClientId_" + self.nextsplashlistindex, var_02 getentitynumber());
  }
  else {
    self setclientomnvar("ui_player_splash_cardClientId_" + self.nextsplashlistindex, -1);
  }

  self setclientomnvar("ui_player_splashfunc_" + self.nextsplashlistindex, var_04);

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

queuesplash(var_00, var_01, var_02) {
  var_03 = spawnStruct();
  var_3.ref = var_00;
  var_3.optionalnumber = var_01;
  var_3.playerforplayercard = var_02;

  if(!isDefined(self.splashqueuehead)) {
    self.splashqueuehead = var_03;
    self.splashqueuetail = var_03;
    thread handlesplashqueue();
  } else {
    var_04 = self.splashqueuetail;
    var_4.nextsplash = var_03;
    self.splashqueuetail = var_03;
  }
}

handlesplashqueue() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");

  while(isDefined(self.splashqueuehead)) {
    self waittill("splash_list_cleared");

    for(var_00 = 0; var_00 < 6; var_0++) {
      var_01 = self.splashqueuehead;
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

  self.lowermessage = scripts\cp\utility::createfontstring(var_00, var_02);
  self.lowermessage give_zap_perk("");
  self.lowermessage.archived = 0;
  self.lowermessage.sort = 10;
  self.lowermessage.showinkillcam = 0;
  self.lowermessage scripts\cp\utility::setpoint("CENTER", level.lowertextyalign, 0, var_01);
  self.lowertimer = scripts\cp\utility::createfontstring("default", var_03);
  self.lowertimer scripts\cp\utility::setparent(self.lowermessage);
  self.lowertimer scripts\cp\utility::setpoint("TOP", "BOTTOM", 0, 0);
  self.lowertimer give_zap_perk("");
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
    self waittill("luinotifyserver", var_00, var_01);

    if(var_00 != "splash_shown") {
      continue;
    }
    var_02 = tablelookupbyrow(getsplashtablename(), var_01, 0);
    var_03 = tablelookupbyrow(getsplashtablename(), var_01, 5);

    switch (var_03) {
      case "killstreak_splash":
        break;
    }
  }
}

onkillstreaksplashshown(var_00) {}

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

showmiscmessage(var_00) {
  var_01 = tablelookuprownum("mp\miscMessages.csv", 0, var_00);
  var_02 = tablelookupbyrow("mp\miscMessages.csv", var_01, 3);

  if(isDefined(var_02) && var_02 != "") {
    self playlocalsound(var_02);
  }

  self setclientomnvar("ui_misc_message_id", var_01);

  if(!isDefined(self.func_B7D7)) {
    self.func_B7D7 = 0;
  }

  self.func_B7D7 = !self.func_B7D7;
  self setclientomnvar("ui_misc_message_trigger", scripts\engine\utility::ter_op(self.func_B7D7, 1, 0));
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
  self setrankedplayerdata("cp", "zombiePlayerLoadout", "tutorialOff", 1);
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
  self waittill("luinotifyserver", var_00);

  if(var_00 == "tutorial_off") {
    self setrankedplayerdata("cp", "zombiePlayerLoadout", "tutorialOff", 1);
    self.hide_tutorial = 1;
  }

  if(var_00 == "tutorial_on") {
    self setrankedplayerdata("cp", "zombiePlayerLoadout", "tutorialOff", 0);
    self.hide_tutorial = 0;
  }
}

tutorial_lookup_func(var_00) {
  if(!(scripts\cp\utility::isplayingsolo() || level.only_one_player)) {
    return;
  }
  var_01 = level.players[0];

  if(var_1.hide_tutorial == 1) {
    return;
  }
  if(!isDefined(level.tutorial_message_table)) {
    return;
  }
  if(!shouldshowtutorial(var_00)) {
    return;
  }
  if(var_01 get_has_seen_tutorial(var_00)) {
    return;
  }
  if(var_00 != "null" && !scripts\engine\utility::is_true(level.tutorial_activated)) {
    level.tutorial_activated = 1;
    var_02 = int(tablelookup(level.tutorial_message_table, 1, var_00, 0));
    var_01 setclientomnvar("zm_tutorial_num", var_02);
    var_01 set_has_seen_tutorial(var_00, 1);
    level.tutorial_activated = undefined;
  }
}

set_has_seen_tutorial(var_00, var_01) {
  self setrankedplayerdata("cp", "tutorial", var_00, "saw_message", var_01);
}

set_has_seen_perm_tutorial(var_00, var_01) {
  self setrankedplayerdata("cp", "tutorialPerm", var_00, "saw_message", var_01);
}

get_has_seen_tutorial(var_00) {
  var_01 = self getrankedplayerdata("cp", "tutorial", var_00, "saw_message");
  return var_01;
}

wait_for_tutorial_unpause() {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("luinotifyserver", var_00);

  if(var_00 == "tutorial_unpause") {
    setslowmotion(1.0, 1.0, 0);
  }
}

shouldshowtutorial(var_00) {
  if(isDefined(level.should_show_tutorial_func)) {
    return [[level.should_show_tutorial_func]](var_00);
  }
  else {
    return 1;
  }
}

wait_and_play_tutorial_message(var_00, var_01) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self notify("clear_message");
  self endon("clear_message");
  wait(var_01);
  tutorial_lookup_func(var_00);
}