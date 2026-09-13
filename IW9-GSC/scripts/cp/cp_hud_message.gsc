/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_hud_message.gsc
***********************************************/

init_cp_hud_message() {
  level thread onplayerconnect_cphudmessage();
  level.showerrormessagefunc = ::showerrormessage;
}

onplayerconnect_cphudmessage() {
  for(;;) {
    level waittill("connected", player);
    player thread hintmessagedeaththink();
    player thread lowermessagethink();
    player thread splashshownthink();
  }
}

showkillstreaksplash(_id_F7B6CC6C062A7A43, _id_F06B5C1AC51DF6A6, _id_38ECFEB60187E7D3) {
  if(!isPlayer(self)) {
    return;
  }
  _id_324D2D5F2E38524B = spawnStruct();

  if(isDefined(_id_38ECFEB60187E7D3))
    _id_F7B6CC6C062A7A43 = _id_F7B6CC6C062A7A43 + ("_" + _id_38ECFEB60187E7D3);

  showsplash(_id_F7B6CC6C062A7A43, _id_F06B5C1AC51DF6A6);
}

showchallengesplash(_id_A5CB6F1F6ABE070B, _id_737C25E5BCF0380D) {
  _id_3146D9BB98662047 = undefined;

  if(isDefined(_id_737C25E5BCF0380D))
    _id_3146D9BB98662047 = _id_737C25E5BCF0380D;
  else
    _id_3146D9BB98662047 = scripts\cp\cp_hud_util::mt_getstate(_id_A5CB6F1F6ABE070B) - 1;

  _id_18671D21B01DEF46 = level.meritinfo[_id_A5CB6F1F6ABE070B]["displayParam"];

  if(!isDefined(_id_18671D21B01DEF46)) {
    _id_18671D21B01DEF46 = scripts\cp\cp_hud_util::mt_gettarget(_id_A5CB6F1F6ABE070B, _id_3146D9BB98662047);

    if(_id_18671D21B01DEF46 == 0)
      _id_18671D21B01DEF46 = 1;

    _id_46E8EAE4D219AF2C = level.meritinfo[_id_A5CB6F1F6ABE070B]["paramScale"];

    if(isDefined(_id_46E8EAE4D219AF2C))
      _id_18671D21B01DEF46 = int(_id_18671D21B01DEF46 / _id_46E8EAE4D219AF2C);
  }

  thread showsplash(_id_A5CB6F1F6ABE070B, _id_18671D21B01DEF46);
}

showsplash(ref, optionalnumber, playerforplayercard, altdisplayindex, _id_EF4849B4CB3AC7E2, _id_042B1E877AB187C6) {
  if(isDefined(self.recentsplashcount) && self.recentsplashcount >= 6) {
    queuesplash(ref, optionalnumber, playerforplayercard, _id_042B1E877AB187C6);
    return;
  }

  showsplashinternal(ref, optionalnumber, playerforplayercard, _id_042B1E877AB187C6);
}

showsplashinternal(ref, optionalnumber, playerforplayercard, _id_042B1E877AB187C6) {
  if(!isPlayer(self)) {
    return;
  }
  _id_A4E353FA34A0F7BD = 0;
  _id_83AFA1BB13298AC7 = tablelookuprownum(getsplashtablename(), 0, ref);

  if(!isDefined(_id_83AFA1BB13298AC7) || _id_83AFA1BB13298AC7 < 0) {
    _id_83AFA1BB13298AC7 = _id_73BAF095C3B9CCE6(ref, _id_042B1E877AB187C6);
    _id_A4E353FA34A0F7BD = 1;
  }

  if(!isDefined(_id_83AFA1BB13298AC7) || _id_83AFA1BB13298AC7 < 0) {
    return;
  }
  if(!isDefined(self.nextsplashlistindex))
    self.nextsplashlistindex = 0;

  if(!isDefined(self.splashlisttoggle))
    self.splashlisttoggle = 1;

  _id_5C9DDCF56D36F133 = _id_83AFA1BB13298AC7;

  if(self.splashlisttoggle)
    _id_5C9DDCF56D36F133 = _id_5C9DDCF56D36F133 | 2048;

  if(isDefined(optionalnumber))
    self setclientomnvar("ui_player_splash_param_" + self.nextsplashlistindex, optionalnumber);
  else
    self setclientomnvar("ui_player_splash_param_" + self.nextsplashlistindex, -1);

  if(isDefined(playerforplayercard))
    self setclientomnvar("ui_player_splash_cardClientId_" + self.nextsplashlistindex, playerforplayercard getentitynumber());
  else
    self setclientomnvar("ui_player_splash_cardClientId_" + self.nextsplashlistindex, -1);

  self setclientomnvar("ui_player_splash_scriptBundle_" + self.nextsplashlistindex, _id_A4E353FA34A0F7BD);
  self setclientomnvar("ui_player_splash_id_" + self.nextsplashlistindex, _id_5C9DDCF56D36F133);

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

queuesplash(ref, optionalnumber, playerforplayercard, _id_042B1E877AB187C6) {
  struct = spawnStruct();
  struct.ref = ref;
  struct.optionalnumber = optionalnumber;
  struct.playerforplayercard = playerforplayercard;
  struct._id_042B1E877AB187C6 = _id_042B1E877AB187C6;

  if(!isDefined(self.splashqueuehead)) {
    self.splashqueuehead = struct;
    self.splashqueuetail = struct;
    thread handlesplashqueue();
  } else {
    _id_520AE50DDF0F19C4 = self.splashqueuetail;
    _id_520AE50DDF0F19C4.nextsplash = struct;
    self.splashqueuetail = struct;
  }
}

handlesplashqueue() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");

  while(isDefined(self.splashqueuehead)) {
    self waittill("splash_list_cleared");

    for(_id_2ACA94DD41D845F8 = 0; _id_2ACA94DD41D845F8 < 6; _id_2ACA94DD41D845F8++) {
      struct = self.splashqueuehead;
      showsplashinternal(struct.ref, struct.optionalnumber, struct.playerforplayercard, struct._id_042B1E877AB187C6);
      self.splashqueuehead = struct.nextsplash;

      if(!isDefined(self.splashqueuehead)) {
        break;
      }
    }
  }

  self.splashqueuetail = undefined;
}

_id_73BAF095C3B9CCE6(_id_F7B6CC6C062A7A43, _id_042B1E877AB187C6) {
  _id_C1C3E6A4F162AB45 = undefined;

  if(isDefined(_id_042B1E877AB187C6))
    _id_C1C3E6A4F162AB45 = _id_042B1E877AB187C6;

  if(!isDefined(_id_C1C3E6A4F162AB45) && isDefined(level._id_62F6F7640E4431E3))
    _id_C1C3E6A4F162AB45 = level._id_62F6F7640E4431E3._id_F7D29CEF55A5FB26;

  if(!isDefined(_id_C1C3E6A4F162AB45))
    _id_C1C3E6A4F162AB45 = level._id_1A2B600A06EC21F4._id_F7D29CEF55A5FB26;

  if(!isDefined(_id_C1C3E6A4F162AB45))
    return undefined;

  _id_F7D29CEF55A5FB26 = getscriptbundle(_func_2EF675C13CA1C4AF("enum_7AC5A0B15C7D50E5", _id_C1C3E6A4F162AB45));

  if(!isDefined(_id_F7D29CEF55A5FB26) || !isDefined(_id_F7D29CEF55A5FB26._id_194DF4FE813AE6D7))
    return undefined;

  foreach(_id_68CC4B3BF54ADCFE in _id_F7D29CEF55A5FB26._id_194DF4FE813AE6D7) {
    if(_id_68CC4B3BF54ADCFE.ref != _id_F7B6CC6C062A7A43) {
      continue;
    }
    id = _func_2336488258354FBC("stat_A372798EADBA5C90", _func_2EF675C13CA1C4AF("enum_39857EA6520CF871", _id_68CC4B3BF54ADCFE._id_C922A8C8A92C3282));
    return id;
  }

  return undefined;
}

lowermessagethink() {
  self endon("disconnect");
  self.lowermessages = [];
  lowermessagefont = "default";

  if(isDefined(level.lowermessagefont))
    lowermessagefont = level.lowermessagefont;

  _id_7417D49A6C72A483 = level.lowertexty;
  _id_4C254F3E1813B5AC = level.lowertextfontsize;
  _id_ED9168DA0F317746 = 1.25;

  if(level.splitscreen || self issplitscreenplayer() && !isai(self)) {
    _id_7417D49A6C72A483 = _id_7417D49A6C72A483 - 40;
    _id_4C254F3E1813B5AC = level.lowertextfontsize * 1.3;
    _id_ED9168DA0F317746 = _id_ED9168DA0F317746 * 1.5;
  }

  self.lowermessage = scripts\cp\utility::createfontstring(lowermessagefont, _id_4C254F3E1813B5AC);
  self.lowermessage settext("");
  self.lowermessage.archived = 0;
  self.lowermessage.sort = 10;
  self.lowermessage.showinkillcam = 0;
  self.lowermessage scripts\cp\utility::setpoint("CENTER", level.lowertextyalign, 0, _id_7417D49A6C72A483);
  self.lowertimer = scripts\cp\utility::createfontstring("default", _id_ED9168DA0F317746);
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
  return "mp/splashtable.csv";
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
    self waittill("luinotifyserver", _id_7148C1A6F25491F8, _id_EA8523762E51DD5E);

    if(_id_7148C1A6F25491F8 != "splash_shown") {
      continue;
    }
    _id_F7B6CC6C062A7A43 = tablelookupbyrow(getsplashtablename(), _id_EA8523762E51DD5E, 0);
    type = tablelookupbyrow(getsplashtablename(), _id_EA8523762E51DD5E, 5);

    switch (type) {
      case "killstreak_splash":
        break;
    }
  }
}

onkillstreaksplashshown(_id_F7B6CC6C062A7A43) {}

showerrormessage(_id_1797174F9E968E96, _id_D153265565DF63DA) {
  _id_09DD5D9E57E7E36D = tablelookuprownum("mp/errorMessages.csv", 0, _id_1797174F9E968E96);

  if(isDefined(_id_D153265565DF63DA))
    self setclientomnvar("ui_mp_error_message_param", _id_D153265565DF63DA);
  else
    self setclientomnvar("ui_mp_error_message_param", -1);

  self setclientomnvar("ui_mp_error_message_id", _id_09DD5D9E57E7E36D);

  if(!isDefined(self.errormessagebitflipper))
    self.errormessagebitflipper = 0;

  self.errormessagebitflipper = !self.errormessagebitflipper;
  self setclientomnvar("ui_mp_error_trigger", scripts\engine\utility::ter_op(self.errormessagebitflipper, 2, 1));
}

showerrormessagetoallplayers(_id_1797174F9E968E96, _id_D153265565DF63DA) {
  foreach(player in level.players)
  player showerrormessage(_id_1797174F9E968E96, _id_D153265565DF63DA);
}

showmiscmessage(messageref) {
  _id_09DD5D9E57E7E36D = tablelookuprownum("mp/miscMessages.csv", 0, messageref);
  sound = tablelookupbyrow("mp/miscMessages.csv", _id_09DD5D9E57E7E36D, 3);

  if(isDefined(sound) && sound != "")
    self playlocalsound(sound);

  self setclientomnvar("ui_misc_message_id", _id_09DD5D9E57E7E36D);

  if(!isDefined(self.miscmessagebitflipper))
    self.miscmessagebitflipper = 0;

  self.miscmessagebitflipper = !self.miscmessagebitflipper;
  self setclientomnvar("ui_misc_message_trigger", scripts\engine\utility::ter_op(self.miscmessagebitflipper, 1, 0));
}

teamhudtutorialmessage(msg, team, time) {
  if(!isDefined(team))
    team = "allies";

  if(!isDefined(time))
    time = 5;

  foreach(player in level.players)
  player thread tutorialprint(msg, time);
}

tutorialprint(msg, time) {
  level endon("game_ended");
  self endon("clear_tutorial_messages");
  self endon("disconnect");

  if(!isDefined(time))
    time = 5;

  self sethudtutorialmessage(msg, 1);
  wait(time);
  self clearhudtutorialmessage();
}

hintmessagedeaththink() {
  self endon("disconnect");

  for(;;) {
    self waittill("death");

    if(isDefined(self.hintmessage))
      self.hintmessage scripts\cp\utility::destroyelem();
  }
}

check_for_more_players() {
  level waittill("multiple_players");
  self.hide_tutorial = 0;

  if(!isDefined(level.tutorial_interaction_1) || !isDefined(level.tutorial_interaction_2)) {
    return;
  }
  _id_71332A5B74214116::remove_from_current_interaction_list(level.tutorial_interaction_1);
  _id_71332A5B74214116::remove_from_current_interaction_list(level.tutorial_interaction_2);
}

tutorial_lookup_func(_id_27B205330F3D56FD) {
  if(!(scripts\cp\utility::isplayingsolo() || level.only_one_player)) {
    return;
  }
  player = level.players[0];

  if(player.hide_tutorial == 1) {
    return;
  }
  if(!isDefined(level.tutorial_message_table)) {
    return;
  }
  if(!shouldshowtutorial(_id_27B205330F3D56FD)) {
    return;
  }
  if(player get_has_seen_tutorial(_id_27B205330F3D56FD)) {
    return;
  }
  if(_id_27B205330F3D56FD != "null" && !istrue(level.tutorial_activated)) {
    level.tutorial_activated = 1;
    omnvar = int(tablelookup(level.tutorial_message_table, 1, _id_27B205330F3D56FD, 0));
    player setclientomnvar("zm_tutorial_num", omnvar);
    player set_has_seen_tutorial(_id_27B205330F3D56FD, 1);
    level.tutorial_activated = undefined;
  }
}

set_has_seen_tutorial(_id_27B205330F3D56FD, _id_BA6DBBAEE6E8110D) {
  self setplayerdata("cp", "tutorial", _id_27B205330F3D56FD, "saw_message", _id_BA6DBBAEE6E8110D);
}

set_has_seen_perm_tutorial(_id_27B205330F3D56FD, _id_BA6DBBAEE6E8110D) {
  self setplayerdata("cp", "tutorialPerm", _id_27B205330F3D56FD, "saw_message", _id_BA6DBBAEE6E8110D);
}

get_has_seen_tutorial(_id_27B205330F3D56FD) {
  _id_E50279FA1FAA67F2 = self getplayerdata("cp", "tutorial", _id_27B205330F3D56FD, "saw_message");
  return _id_E50279FA1FAA67F2;
}

wait_for_tutorial_unpause() {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("luinotifyserver", _id_EA3E3B2121E6713A);

  if(_id_EA3E3B2121E6713A == "tutorial_unpause")
    setslowmotion(1.0, 1.0, 0);
}

shouldshowtutorial(_id_27B205330F3D56FD) {
  if(isDefined(level.should_show_tutorial_func))
    return [[level.should_show_tutorial_func]](_id_27B205330F3D56FD);
  else
    return 1;
}

wait_and_play_tutorial_message(message, waittime) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self notify("clear_message");
  self endon("clear_message");
  wait(waittime);
  tutorial_lookup_func(message);
}