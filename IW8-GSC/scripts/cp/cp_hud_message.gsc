/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_hud_message.gsc
***********************************************/

function init_cp_hud_message() {
  thread onplayerconnect_cphudmessage();
}

function onplayerconnect_cphudmessage() {
  for(;;) {
    level waittill("connected", var0);
    thread hintmessagedeaththink();
    thread lowermessagethink();
    thread splashshownthink();
  }
}

function showkillstreaksplash(var0, var1, var2) {
  if(!isPlayer(self)) {
    return;
  }

  var3 = spawnStruct();

  if(isDefined(var2)) {
    var0 += "_" + var2;
  }

  showsplash(var0, var1);
}

function showchallengesplash(var0, var1) {
  var2 = undefined;

  if(isDefined(var1)) {
    var2 = var1;
  } else {
    var2 = scripts\cp\cp_hud_util::mt_getstate(var0) - 1;
  }

  var3 = level.meritinfo[var0]["displayParam"];

  if(!isDefined(var3)) {
    var3 = scripts\cp\cp_hud_util::mt_gettarget(var0, var2);

    if(var3 == 0) {
      var3 = 1;
    }

    var4 = level.meritinfo[var0]["paramScale"];

    if(isDefined(var4)) {
      var3 = int(var3 / var4);
    }
  }

  thread showsplash(var0, var3);
}

function showsplash(var0, var1, var2) {
  if(isDefined(self.recentsplashcount) && self.recentsplashcount >= 6) {
    queuesplash(var0, var1, var2);
    return;
  }

  showsplashinternal(var0, var1, var2);
}

function showsplashinternal(var0, var1, var2) {
  if(!isPlayer(self)) {
    return;
  }

  var3 = tablelookuprownum(getsplashtablename(), 0, var0);

  if(!isDefined(var3) || var3 < 0) {
    return;
  }

  if(!isDefined(self.nextsplashlistindex)) {
    self.nextsplashlistindex = 0;
  }

  if(!isDefined(self.splashlisttoggle)) {
    self.splashlisttoggle = 1;
  }

  var4 = var3;

  if(self.splashlisttoggle) {
    var4 |= 4096;
  }

  if(isDefined(var1)) {
    self setclientomnvar("ui_player_splash_param_" + self.nextsplashlistindex, var1);
  } else {
    self setclientomnvar("ui_player_splash_param_" + self.nextsplashlistindex, -1);
  }

  if(isDefined(var2)) {
    self setclientomnvar("ui_player_splash_cardClientId_" + self.nextsplashlistindex, var2 getentitynumber());
  } else {
    self setclientomnvar("ui_player_splash_cardClientId_" + self.nextsplashlistindex, -1);
  }

  self setclientomnvar("ui_player_splash_id_" + self.nextsplashlistindex, var4);

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

function queuesplash(var0, var1, var2) {
  var3 = spawnStruct();
  var3.ref = var0;
  var3.optionalnumber = var1;
  var3.playerforplayercard = var2;

  if(!isDefined(self.splashqueuehead)) {
    self.splashqueuehead = var3;
    self.splashqueuetail = var3;
    thread handlesplashqueue();
    return;
  }

  var4 = self.splashqueuetail;
  var4.nextsplash = var3;
  self.splashqueuetail = var3;
}

function handlesplashqueue() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");

  while(isDefined(self.splashqueuehead)) {
    self waittill("splash_list_cleared");

    for(var0 = 0; var0 < 6; var0++) {
      var1 = self.splashqueuehead;
      showsplashinternal(var1.ref, var1.optionalnumber, var1.playerforplayercard);
      self.splashqueuehead = var1.nextsplash;

      if(!isDefined(self.splashqueuehead)) {
        break;
      }
    }
  }

  self.splashqueuetail = undefined;
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

  self.lowermessage = scripts\cp\utility::createfontstring(var0, var2);
  self.lowermessage settext("");
  self.lowermessage.archived = 0;
  self.lowermessage.sort = 10;
  self.lowermessage.showinkillcam = 0;
  self.lowermessage scripts\cp\utility::setpoint("CENTER", level.lowertextyalign, 0, var1);
  self.lowertimer = scripts\cp\utility::createfontstring("default", var3);
  self.lowertimer scripts\cp\utility::setparent(self.lowermessage);
  self.lowertimer scripts\cp\utility::setpoint("TOP", "BOTTOM", 0, 0);
  self.lowertimer settext("");
  self.lowertimer.archived = 0;
  self.lowertimer.sort = 10;
  self.lowertimer.showinkillcam = 0;
}

function isdoingsplash() {
  return false;
}

function getsplashtablename() {
  return "mp/splashtable.csv";
}

function cleanuplocalplayersplashlist() {
  self endon("disconnect");
  self notify("cleanupLocalPlayerSplashList()");
  self endon("cleanupLocalPlayerSplashList()");
  scripts\engine\utility::waittill_notify_or_timeout("death", 0.5);
  self.recentsplashcount = undefined;
  self notify("splash_list_cleared");
}

function splashshownthink() {
  self endon("disconnect");

  for(;;) {
    self waittill("luinotifyserver", var0, var1);

    if(var0 != "splash_shown") {
      continue;
    }

    var2 = tablelookupbyrow(getsplashtablename(), var1, 0);
    var3 = tablelookupbyrow(getsplashtablename(), var1, 5);

    switch (var3) {
      case "killstreak_splash":
        break;
    }
  }
}

function onkillstreaksplashshown(var0) {}

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

function showmiscmessage(var0) {
  var1 = tablelookuprownum("mp/miscMessages.csv", 0, var0);
  var2 = tablelookupbyrow("mp/miscMessages.csv", var1, 3);

  if(isDefined(var2) && var2 != "") {
    self playlocalsound(var2);
  }

  self setclientomnvar("ui_misc_message_id", var1);

  if(!isDefined(self.miscmessagebitflipper)) {
    self.miscmessagebitflipper = 0;
  }

  self.miscmessagebitflipper = !self.miscmessagebitflipper;
  self setclientomnvar("ui_misc_message_trigger", scripts\engine\utility::ter_op(self.miscmessagebitflipper, 1, 0));
}

function teamhudtutorialmessage(var0, var1, var2) {
  foreach(var4 in level.players) {
    thread tutorialprint(var4, var0);
  }
}

function tutorialprint(var0, var1) {
  level endon("game_ended");
  self endon("clear_tutorial_messages");
  self endon("disconnect");
  self sethudtutorialmessage(var0);
  wait var1;
  self clearhudtutorialmessage();
}

function hintmessagedeaththink() {
  self endon("disconnect");

  for(;;) {
    self waittill("death");

    if(isDefined(self.hintmessage)) {
      self.hintmessage scripts\cp\utility::destroyelem();
    }
  }
}

function init_tutorial_message_array() {
  self setplayerdata("cp", "zombiePlayerLoadout", "tutorialOff", 1);
  self.hide_tutorial = 1;
  thread check_for_more_players();
}

function check_for_more_players() {
  level waittill("multiple_players");
  self.hide_tutorial = 0;

  if(!isDefined(level.tutorial_interaction_1) || !isDefined(level.tutorial_interaction_2)) {
    return;
  }

  scripts\cp\cp_interaction::remove_from_current_interaction_list(level.tutorial_interaction_1);
  scripts\cp\cp_interaction::remove_from_current_interaction_list(level.tutorial_interaction_2);
}

function tutorial_interaction() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self waittill("luinotifyserver", var0);

  if(var0 == "tutorial_off") {
    self setplayerdata("cp", "zombiePlayerLoadout", "tutorialOff", 1);
    self.hide_tutorial = 1;
  }

  if(var0 == "tutorial_on") {
    self setplayerdata("cp", "zombiePlayerLoadout", "tutorialOff", 0);
    self.hide_tutorial = 0;
    return;
  }
}

function tutorial_lookup_func(var0) {
  if(!(scripts\cp\utility::isplayingsolo() || level.only_one_player)) {
    return;
  }

  var1 = level.players[0];

  if(var1.hide_tutorial == 1) {
    return;
  }

  if(!isDefined(level.tutorial_message_table)) {
    return;
  }

  if(!shouldshowtutorial(var0)) {
    return;
  }

  if(get_has_seen_tutorial(var1, var0)) {
    return;
  }

  if(var0 != "null" && !istrue(level.tutorial_activated)) {
    level.tutorial_activated = 1;
    var2 = int(tablelookup(level.tutorial_message_table, 1, var0, 0));
    var1 setclientomnvar("zm_tutorial_num", var2);
    set_has_seen_tutorial(var1, var0, 1);
    level.tutorial_activated = undefined;
    return;
  }
}

function set_has_seen_tutorial(var0, var1) {
  self setplayerdata("cp", "tutorial", var0, "saw_message", var1);
}

function set_has_seen_perm_tutorial(var0, var1) {
  self setplayerdata("cp", "tutorialPerm", var0, "saw_message", var1);
}

function get_has_seen_tutorial(var0) {
  var1 = self getplayerdata("cp", "tutorial", var0, "saw_message");
  return var1;
}

function wait_for_tutorial_unpause() {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("luinotifyserver", var0);

  if(var0 == "tutorial_unpause") {
    setslowmotion(1, 1, 0);
    return;
  }
}

function shouldshowtutorial(var0) {
  if(isDefined(level.should_show_tutorial_func)) {
    return [[level.should_show_tutorial_func]](var0);
  }

  return 1;
}

function wait_and_play_tutorial_message(var0, var1) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self notify("clear_message");
  self endon("clear_message");
  wait var1;
  tutorial_lookup_func(var0);
}