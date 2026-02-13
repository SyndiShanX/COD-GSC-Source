/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1844.gsc
*************************************************/

_id_7F41() {
  level thread _id_AB5A();
}

_id_AB5A() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread _id_7990();
    var_0 thread _id_98C7();
    var_0 thread _id_E41E();
  }
}

_id_DCBD(var_0, var_1, var_2) {
  if(!isPlayer(self)) {
    return;
  }
  var_3 = spawnStruct();

  if(isDefined(var_2)) {
    var_0 = var_0 + ("_" + var_2);
  }

  showsplash(var_0, var_1);
}

_id_DC8F(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(var_1)) {
    var_2 = var_1;
  } else {
    var_2 = scripts\cp\cp_hud_util::_id_A2BB(var_0) - 1;
  }

  var_3 = level._id_9DE3[var_0]["displayParam"];

  if(!isDefined(var_3)) {
    var_3 = scripts\cp\cp_hud_util::_id_A2BC(var_0, var_2);

    if(var_3 == 0) {
      var_3 = 1;
    }

    var_4 = level._id_9DE3[var_0]["paramScale"];

    if(isDefined(var_4)) {
      var_3 = int(var_3 / var_4);
    }
  }

  thread showsplash(var_0, var_3);
}

showsplash(var_0, var_1, var_2) {
  if(isDefined(self._id_C0FD) && self._id_C0FD >= 6) {
    _id_BED9(var_0, var_1, var_2);
    return;
  }

  _id_DCE4(var_0, var_1, var_2);
}

_id_DCE4(var_0, var_1, var_2) {
  if(!isPlayer(self)) {
    return;
  }
  var_3 = tablelookuprownum(_id_6D6F(), 0, var_0);

  if(!isDefined(var_3) || var_3 < 0) {
    return;
  }
  if(!isDefined(self._id_A4D7)) {
    self._id_A4D7 = 0;
  }

  if(!isDefined(self._id_E418)) {
    self._id_E418 = 1;
  }

  var_4 = var_3;

  if(self._id_E418) {
    var_4 = var_4 | 2048;
  }

  if(isDefined(var_1)) {
    self setclientomnvar("ui_player_splash_param_" + self._id_A4D7, var_1);
  } else {
    self setclientomnvar("ui_player_splash_param_" + self._id_A4D7, -1);
  }

  if(isDefined(var_2)) {
    self setclientomnvar("ui_player_splash_cardClientId_" + self._id_A4D7, var_2 getentitynumber());
  } else {
    self setclientomnvar("ui_player_splash_cardClientId_" + self._id_A4D7, -1);
  }

  self setclientomnvar("ui_player_splash_id_" + self._id_A4D7, var_4);

  if(!isDefined(self._id_C0FD)) {
    self._id_C0FD = 1;
  } else {
    self._id_C0FD++;
  }

  thread _id_388F();
  self._id_A4D7++;

  if(self._id_A4D7 >= 6) {
    self._id_A4D7 = 0;
    self._id_E418 = !self._id_E418;
  }
}

_id_BED9(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3._id_C189 = var_0;
  var_3._id_AC53 = var_1;
  var_3._id_B6AF = var_2;

  if(!isDefined(self._id_E41B)) {
    self._id_E41B = var_3;
    self._id_E41C = var_3;
    thread _id_7495();
  } else {
    var_4 = self._id_E41C;
    var_4._id_A4D6 = var_3;
    self._id_E41C = var_3;
  }
}

_id_7495() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");

  while(isDefined(self._id_E41B)) {
    self waittill("splash_list_cleared");

    for(var_0 = 0; var_0 < 6; var_0++) {
      var_1 = self._id_E41B;
      _id_DCE4(var_1._id_C189, var_1._id_AC53, var_1._id_B6AF);
      self._id_E41B = var_1._id_A4D6;

      if(!isDefined(self._id_E41B)) {
        break;
      }
    }
  }

  self._id_E41C = undefined;
}

_id_98C7() {
  self endon("disconnect");
  self._id_98C6 = [];
  var_0 = "default";

  if(isDefined(level._id_98C5)) {
    var_0 = level._id_98C5;
  }

  var_1 = level._id_98C9;
  var_2 = level._id_98C8;
  var_3 = 1.25;

  if(level.splitscreen || self _meth_81E2() && !isai(self)) {
    var_1 = var_1 - 40;
    var_2 = level._id_98C8 * 1.3;
    var_3 = var_3 * 1.5;
  }

  self._id_98C4 = scripts\cp\utility::createfontstring(var_0, var_2);
  self._id_98C4 settext("");
  self._id_98C4.archived = 0;
  self._id_98C4.sort = 10;
  self._id_98C4.showinkillcam = 0;
  self._id_98C4 scripts\cp\utility::setpoint("CENTER", level._id_98CA, 0, var_1);
  self._id_98CB = scripts\cp\utility::createfontstring("default", var_3);
  self._id_98CB scripts\cp\utility::setparent(self._id_98C4);
  self._id_98CB scripts\cp\utility::setpoint("TOP", "BOTTOM", 0, 0);
  self._id_98CB settext("");
  self._id_98CB.archived = 0;
  self._id_98CB.sort = 10;
  self._id_98CB.showinkillcam = 0;
}

_id_8808() {
  return 0;
}

_id_6D6F() {
  return "mp/splashtable.csv";
}

_id_388F() {
  self endon("disconnect");
  self notify("cleanupLocalPlayerSplashList()");
  self endon("cleanupLocalPlayerSplashList()");
  scripts\engine\utility::_id_108F5("death", 0.5);
  self._id_C0FD = undefined;
  self notify("splash_list_cleared");
}

_id_E41E() {
  self endon("disconnect");

  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);

    if(var_0 != "splash_shown") {
      continue;
    }
    var_2 = tablelookupbyrow(_id_6D6F(), var_1, 0);
    var_3 = tablelookupbyrow(_id_6D6F(), var_1, 5);

    switch (var_3) {
      case "killstreak_splash":
        break;
    }
  }
}

_id_AB19(var_0) {}

_id_DCA2(var_0, var_1) {
  var_2 = tablelookuprownum("mp/errorMessages.csv", 0, var_0);

  if(isDefined(var_1)) {
    self setclientomnvar("ui_mp_error_message_param", var_1);
  } else {
    self setclientomnvar("ui_mp_error_message_param", -1);
  }

  self setclientomnvar("ui_mp_error_message_id", var_2);

  if(!isDefined(self._id_559A)) {
    self._id_559A = 0;
  }

  self._id_559A = !self._id_559A;
  self setclientomnvar("ui_mp_error_trigger", scripts\engine\utility::ter_op(self._id_559A, 2, 1));
}

_id_DCA4(var_0, var_1) {
  foreach(var_3 in level.players) {
    _id_DCA2(var_0, var_1);
  }
}

_id_DCC6(var_0) {
  var_1 = tablelookuprownum("mp/miscMessages.csv", 0, var_0);
  var_2 = tablelookupbyrow("mp/miscMessages.csv", var_1, 3);

  if(isDefined(var_2) && var_2 != "") {
    self playlocalsound(var_2);
  }

  self setclientomnvar("ui_misc_message_id", var_1);

  if(!isDefined(self._id_9F4C)) {
    self._id_9F4C = 0;
  }

  self._id_9F4C = !self._id_9F4C;
  self setclientomnvar("ui_misc_message_trigger", scripts\engine\utility::ter_op(self._id_9F4C, 1, 0));
}

_id_EF7B(var_0, var_1, var_2) {
  foreach(var_4 in level.players) {
    var_4 thread _id_F8D0(var_0, var_2);
  }
}

_id_F8D0(var_0, var_1) {
  level endon("game_ended");
  self endon("clear_tutorial_messages");
  self endon("disconnect");
  self sethudtutorialmessage(var_0);
  wait(var_1);
  self clearhudtutorialmessage();
}

_id_7990() {
  self endon("disconnect");

  for(;;) {
    self waittill("death");

    if(isDefined(self._id_798F)) {
      self._id_798F scripts\cp\utility::destroyelem();
    }
  }
}

_id_80EA() {
  self setplayerdata("cp", "zombiePlayerLoadout", "tutorialOff", 1);
  self._id_78DC = 1;
  thread _id_345B();
}

_id_345B() {
  level waittill("multiple_players");
  self._id_78DC = 0;

  if(!isDefined(level._id_F8B8) || !isDefined(level._id_F8B9)) {
    return;
  }
  _id_0737::_id_C3C5(level._id_F8B8);
  _id_0737::_id_C3C5(level._id_F8B9);
}

_id_F8B7() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self waittill("luinotifyserver", var_0);

  if(var_0 == "tutorial_off") {
    self setplayerdata("cp", "zombiePlayerLoadout", "tutorialOff", 1);
    self._id_78DC = 1;
  }

  if(var_0 == "tutorial_on") {
    self setplayerdata("cp", "zombiePlayerLoadout", "tutorialOff", 0);
    self._id_78DC = 0;
  }
}

_id_F8BA(var_0) {
  if(!(scripts\cp\utility::_id_89AE() || level._id_AB30)) {
    return;
  }
  var_1 = level.players[0];

  if(var_1._id_78DC == 1) {
    return;
  }
  if(!isDefined(level._id_F8BC)) {
    return;
  }
  if(!_id_DBD2(var_0)) {
    return;
  }
  if(var_1 _id_64DB(var_0)) {
    return;
  }
  if(var_0 != "null" && !istrue(level._id_F8A1)) {
    level._id_F8A1 = 1;
    var_2 = int(_func_0222(level._id_F8BC, 1, var_0, 0));
    var_1 setclientomnvar("zm_tutorial_num", var_2);
    var_1 _id_D23E(var_0, 1);
    level._id_F8A1 = undefined;
  }
}

_id_D23E(var_0, var_1) {
  self setplayerdata("cp", "tutorial", var_0, "saw_message", var_1);
}

_id_D23D(var_0, var_1) {
  self setplayerdata("cp", "tutorialPerm", var_0, "saw_message", var_1);
}

_id_64DB(var_0) {
  var_1 = self getplayerdata("cp", "tutorial", var_0, "saw_message");
  return var_1;
}

_id_10759() {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("luinotifyserver", var_0);

  if(var_0 == "tutorial_unpause") {
    _func_01F0(1.0, 1.0, 0);
  }
}

_id_DBD2(var_0) {
  if(isDefined(level._id_DAD2)) {
    return [[level._id_DAD2]](var_0);
  } else {
    return 1;
  }
}

_id_106CB(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self notify("clear_message");
  self endon("clear_message");
  wait(var_1);
  _id_F8BA(var_0);
}