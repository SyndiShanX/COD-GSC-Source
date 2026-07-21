/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_hud_message.gsc
***********************************************/

init_cp_hud_message() {
  level thread onplayerconnect_cphudmessage();
}

onplayerconnect_cphudmessage() {
  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);
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

  if(isDefined(var_2))
    var_0 = var_0 + ("_encstr_BA4C02DF" + var_2);

  showsplash(var_0, var_1);
}

showchallengesplash(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(var_1))
    var_2 = var_1;
  else
    var_2 = scripts\cp\cp_hud_util::mt_getstate(var_0) - 1;

  var_3 = level.meritinfo[var_0]["_encstr_8ECD0D124B6FEFCB599379971A3BC8"];

  if(!isDefined(var_3)) {
    var_3 = scripts\cp\cp_hud_util::mt_gettarget(var_0, var_2);

    if(var_3 == 0)
      var_3 = 1;

    var_4 = level.meritinfo[var_0]["_encstr_B2300B803360AE4F56691AD2B1"];

    if(isDefined(var_4))
      var_3 = int(var_3 / var_4);
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
  if(!isDefined(self.nextsplashlistindex))
    self.nextsplashlistindex = 0;

  if(!isDefined(self.splashlisttoggle))
    self.splashlisttoggle = 1;

  var_4 = var_3;

  if(self.splashlisttoggle)
    var_4 = var_4 | 4096;

  if(isDefined(var_1))
    self setclientomnvar("_encstr_BE8F18232339A7D1B288A50AC943FB8282FFE217709A624152C9" + self.nextsplashlistindex, var_1);
  else
    self setclientomnvar("_encstr_BE8F18232339A7D1B288A50AC943FB8282FFE217709A624152C9" + self.nextsplashlistindex, -1);

  if(isDefined(var_2))
    self setclientomnvar("_encstr_BD4E1FFB1317ABDC9970570329B39832C3B604F98E93431CE5C01F47988B697AE7" + self.nextsplashlistindex, var_2 getentitynumber());
  else
    self setclientomnvar("_encstr_BD4E1FFB1317ABDC9970570329B39832C3B604F98E93431CE5C01F47988B697AE7" + self.nextsplashlistindex, -1);

  self setclientomnvar("_encstr_95AC155D5A7DE08D0B97CAC9EB9B0E360B9BA1AF5A46F5" + self.nextsplashlistindex, var_4);

  if(!isDefined(self.recentsplashcount))
    self.recentsplashcount = 1;
  else
    self.recentsplashcount++;

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
  } else {
    var_4 = self.splashqueuetail;
    var_4.nextsplash = var_3;
    self.splashqueuetail = var_3;
  }
}

handlesplashqueue() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  while(isDefined(self.splashqueuehead)) {
    self waittill("_encstr_A13E149BE0D8B0CD86FA36A5CDD1D736C62B0B272B8C");

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
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.lowermessages = [];
  var_0 = "_encstr_8B1608EC43B8D647A113";

  if(isDefined(level.lowermessagefont))
    var_0 = level.lowermessagefont;

  var_1 = level.lowertexty;
  var_2 = level.lowertextfontsize;
  var_3 = 1.25;

  if(level.splitscreen || self issplitscreenplayer() && !isai(self)) {
    var_1 = var_1 - 40;
    var_2 = level.lowertextfontsize * 1.3;
    var_3 = var_3 * 1.5;
  }

  self.lowermessage = scripts\cp\utility::createfontstring(var_0, var_2);
  self.lowermessage settext("_encstr_B40101");
  self.lowermessage.archived = 0;
  self.lowermessage.sort = 10;
  self.lowermessage.showinkillcam = 0;
  self.lowermessage scripts\cp\utility::setpoint("_encstr_A5C407E57585313DB1", level.lowertextyalign, 0, var_1);
  self.lowertimer = scripts\cp\utility::createfontstring("_encstr_8B1608EC43B8D647A113", var_3);
  self.lowertimer scripts\cp\utility::setparent(self.lowermessage);
  self.lowertimer scripts\cp\utility::setpoint("_encstr_AC190439DF9A", "_encstr_A146079E6DF9115CFD", 0, 0);
  self.lowertimer settext("_encstr_B40101");
  self.lowertimer.archived = 0;
  self.lowertimer.sort = 10;
  self.lowertimer.showinkillcam = 0;
}

isdoingsplash() {
  return 0;
}

getsplashtablename() {
  return "_encstr_820613E0612536534983E7C92977FDB145A6AB43C4";
}

cleanuplocalplayersplashlist() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_A2331F7703E207C8B5DA4438068990D7CA9FDBF3836957E0F972C854AC638853F6");
  self endon("_encstr_A2331F7703E207C8B5DA4438068990D7CA9FDBF3836957E0F972C854AC638853F6");
  scripts\engine\utility::waittill_notify_or_timeout("_encstr_AD75063D571AE108", 0.5);
  self.recentsplashcount = undefined;
  self notify("_encstr_A13E149BE0D8B0CD86FA36A5CDD1D736C62B0B272B8C");
}

splashshownthink() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    self waittill("_encstr_8DEB10B1FD2F404F8B0A906083E72D1B7782", var_0, var_1);

    if(var_0 != "_encstr_BA020DCDE06358CD34D7E6347B7737") {
      continue;
    }
    var_2 = tablelookupbyrow(getsplashtablename(), var_1, 0);
    var_3 = tablelookupbyrow(getsplashtablename(), var_1, 5);

    switch (var_3) {
      case "_encstr_9B48126F3758F9B2E01A27434227F730E9331070":
        break;
    }
  }
}

onkillstreaksplashshown(var_0) {}

showerrormessage(var_0, var_1) {
  var_2 = tablelookuprownum("_encstr_83901575F96247EB1EC013E8E9F6973E484BE38E77584B", 0, var_0);

  if(isDefined(var_1))
    self setclientomnvar("_encstr_BA791AF514B9934B1FAFA0B89F6AE6DBA23A6E776FF22F73099B3048", var_1);
  else
    self setclientomnvar("_encstr_BA791AF514B9934B1FAFA0B89F6AE6DBA23A6E776FF22F73099B3048", -1);

  self setclientomnvar("_encstr_8B1C179F4BA63D53E7EDFAF2C06579F509280F57D859578AF9", var_2);

  if(!isDefined(self.errormessagebitflipper))
    self.errormessagebitflipper = 0;

  self.errormessagebitflipper = !self.errormessagebitflipper;
  self setclientomnvar("_encstr_9B5F1415F45973ABFF0F93183F0A8689731C84944F23", scripts\engine\utility::ter_op(self.errormessagebitflipper, 2, 1));
}

showerrormessagetoallplayers(var_0, var_1) {
  foreach(var_3 in level.players)
  showerrormessage(var_0, var_1);
}

showmiscmessage(var_0) {
  var_1 = tablelookuprownum("_encstr_B6DD145B1CF2D6A56ED8D42BDCE6853BAC375C8D6ECE", 0, var_0);
  var_2 = tablelookupbyrow("_encstr_B6DD145B1CF2D6A56ED8D42BDCE6853BAC375C8D6ECE", var_1, 3);

  if(isDefined(var_2) && var_2 != "_encstr_B40101")
    self playlocalsound(var_2);

  self setclientomnvar("_encstr_A582132BC3C7AAE9EB90EF2F88C3CBD21F6D39A43D", var_1);

  if(!isDefined(self.miscmessagebitflipper))
    self.miscmessagebitflipper = 0;

  self.miscmessagebitflipper = !self.miscmessagebitflipper;
  self setclientomnvar("_encstr_8E2B185B40B75DA79346AF856DBB07E67F8861C3E0B397A78936", scripts\engine\utility::ter_op(self.miscmessagebitflipper, 1, 0));
}

teamhudtutorialmessage(var_0, var_1, var_2) {
  foreach(var_4 in level.players)
  var_4 thread tutorialprint(var_0, var_2);
}

tutorialprint(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_832718E84395C10D11C36DF51D9B6389F4F71040973B19EF5A2A");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self sethudtutorialmessage(var_0);
  wait(var_1);
  self clearhudtutorialmessage();
}

hintmessagedeaththink() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    self waittill("_encstr_AD75063D571AE108");

    if(isDefined(self.hintmessage))
      self.hintmessage scripts\cp\utility::destroyelem();
  }
}

init_tutorial_message_array() {
  self setplayerdata("_encstr_850703B7D9", "_encstr_8AA214B2256D10B35A53C1E3CF620629373EF968CBDC", "_encstr_92290CF9253B5F12017F03586606", 1);
  self.hide_tutorial = 1;
  thread check_for_more_players();
}

check_for_more_players() {
  level waittill("_encstr_8708117D756AEC4C4B8422B0CF9476A107C350");
  self.hide_tutorial = 0;

  if(!isDefined(level.tutorial_interaction_1) || !isDefined(level.tutorial_interaction_2)) {
    return;
  }
  scripts\cp\cp_interaction::remove_from_current_interaction_list(level.tutorial_interaction_1);
  scripts\cp\cp_interaction::remove_from_current_interaction_list(level.tutorial_interaction_2);
}

tutorial_interaction() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  self waittill("_encstr_8DEB10B1FD2F404F8B0A906083E72D1B7782", var_0);

  if(var_0 == "_encstr_9BB50D4B0D8307E3DC432A41C74296") {
    self setplayerdata("_encstr_850703B7D9", "_encstr_8AA214B2256D10B35A53C1E3CF620629373EF968CBDC", "_encstr_92290CF9253B5F12017F03586606", 1);
    self.hide_tutorial = 1;
  }

  if(var_0 == "_encstr_922A0C31ADCBA8F66FD2305E5A1B") {
    self setplayerdata("_encstr_850703B7D9", "_encstr_8AA214B2256D10B35A53C1E3CF620629373EF968CBDC", "_encstr_92290CF9253B5F12017F03586606", 0);
    self.hide_tutorial = 0;
  }
}

tutorial_lookup_func(var_0) {
  if(!(scripts\cp\utility::isplayingsolo() || level.only_one_player)) {
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
  if(var_0 != "_encstr_A3BA05E0735C50" && !istrue(level.tutorial_activated)) {
    level.tutorial_activated = 1;
    var_2 = int(tablelookup(level.tutorial_message_table, 1, var_0, 0));
    var_1 setclientomnvar("_encstr_8617101A687113E3E8471EC11E3AB6857BCA", var_2);
    var_1 set_has_seen_tutorial(var_0, 1);
    level.tutorial_activated = undefined;
  }
}

set_has_seen_tutorial(var_0, var_1) {
  self setplayerdata("_encstr_850703B7D9", "_encstr_922809F9253B5F12017F03", var_0, "_encstr_935D0C9B5877D7AD599BB92CEC59", var_1);
}

set_has_seen_perm_tutorial(var_0, var_1) {
  self setplayerdata("_encstr_850703B7D9", "_encstr_A9260D318BBB182BEF493003D51A25", var_0, "_encstr_935D0C9B5877D7AD599BB92CEC59", var_1);
}

get_has_seen_tutorial(var_0) {
  var_1 = self getplayerdata("_encstr_850703B7D9", "_encstr_922809F9253B5F12017F03", var_0, "_encstr_935D0C9B5877D7AD599BB92CEC59");
  return var_1;
}

wait_for_tutorial_unpause() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_8DEB10B1FD2F404F8B0A906083E72D1B7782", var_0);

  if(var_0 == "_encstr_8C191133486B87CB2347E5D1B5C5235193D0CF")
    setslowmotion(1.0, 1.0, 0);
}

shouldshowtutorial(var_0) {
  if(isDefined(level.should_show_tutorial_func))
    return [[level.should_show_tutorial_func]](var_0);
  else
    return 1;
}

wait_and_play_tutorial_message(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_95020EC6D856C293EB6BB2CD9BC2B3CA");
  self endon("_encstr_95020EC6D856C293EB6BB2CD9BC2B3CA");
  wait(var_1);
  tutorial_lookup_func(var_0);
}