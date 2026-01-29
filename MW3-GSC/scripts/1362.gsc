/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1362.gsc
**************************************/

init() {
  precachemenu("uiScript_startMultiplayer");
  precacheshader("black");
  precacheshader("white");
  precacheshader("menu_button");
  precacheshader("menu_button_selected");
  precacheshader("menu_button_fade");
  precacheshader("menu_button_fade_selected");
  precacheshader("menu_button_faderight");
  precacheshader("menu_button_faderight_selected");
  precacheshader("menu_caret_open");
  precacheshader("menu_caret_closed");
  thread _id_40FD();
  thread _id_40FE();
  thread _id_40FF();
  thread _id_4100();
  thread _id_4101();
  thread _id_4102();
  level._id_40CA = [];
  var_0 = _id_40D4("levels");
  var_1 = _id_4104(::_id_40CE, "cqb_1");
  var_2 = spawnStruct();
  var_2._id_40CB = &"MENU_1ST_PASS";
  var_2._id_40CC = 240;
  var_2._id_40CD = 100;
  var_0 _id_40DD(&"MENU_CQB_TEST", var_1, "loadmap", var_2);
  var_1 = _id_4104(::_id_40CE, "descent");
  var_2 = spawnStruct();
  var_2._id_40CB = &"MENU_1ST_PASS";
  var_2._id_40CC = 240;
  var_2._id_40CD = 100;
  var_0 _id_40DD(&"MENU_BUNKER", var_1, "loadmap", var_2);
  var_1 = _id_4104(::_id_40CE, "aftermath");
  var_2 = spawnStruct();
  var_2._id_40CB = &"MENU_100_INITIAL_GEO";
  var_2._id_40CC = 240;
  var_2._id_40CD = 100;
  var_0 _id_40DD(&"MENU_AFTERMATH", var_1, "loadmap", var_2);
  var_1 = _id_4104(::_id_40CE, "chechnya_escape");
  var_2 = spawnStruct();
  var_2._id_40CB = &"MENU_40_INITIAL_GEO";
  var_2._id_40CC = 240;
  var_2._id_40CD = 100;
  var_0 _id_40DD(&"MENU_CHECHNYA_ESCAPE", var_1, "loadmap", var_2);
  var_1 = _id_4104(::_id_40CE, "marksman");
  var_2 = spawnStruct();
  var_2._id_40CB = &"MENU_25_SCRIPTED";
  var_2._id_40CC = 240;
  var_2._id_40CD = 100;
  var_0 _id_40DD(&"MENU_MARKSMAN", var_1, "loadmap", var_2);
  var_1 = _id_4104(::_id_40CE, "seaknight_defend");
  var_2 = spawnStruct();
  var_2._id_40CB = &"MENU_PROTOTYPE_LEVEL_30_SCRIPTED";
  var_2._id_40CC = 240;
  var_2._id_40CD = 100;
  var_0 _id_40DD(&"MENU_SEAKNIGHT_DEFEND", var_1, "loadmap", var_2);
  var_1 = _id_4104(::_id_40CE, "wetwork");
  var_2 = spawnStruct();
  var_2._id_40CB = &"MENU_100_INITIAL_GEO";
  var_2._id_40CC = 240;
  var_2._id_40CD = 100;
  var_0 _id_40DD(&"MENU_WETWORK", var_1, "loadmap", var_2);
  var_1 = _id_4104(::_id_40CE, "cargoship");
  var_2 = spawnStruct();
  var_2._id_40CB = &"MENU_10_SCRIPTED";
  var_2._id_40CC = 240;
  var_2._id_40CD = 100;
  var_0 _id_40DD(&"MENU_CARGOSHIP", var_1, "loadmap", var_2);
  var_1 = _id_4104(::_id_40CE, "bog");
  var_2 = spawnStruct();
  var_2._id_40CB = &"MENU_35_INITIAL_GEO";
  var_2._id_40CC = 240;
  var_2._id_40CD = 100;
  var_0 _id_40DD(&"MENU_BOG", var_1, "loadmap", var_2);
  var_1 = _id_4104(::_id_40CE, "training");
  var_2 = spawnStruct();
  var_2._id_40CB = &"MENU_5_SCRIPTED";
  var_2._id_40CC = 240;
  var_2._id_40CD = 100;
  var_0 _id_40DD(&"MENU_TRAINING1", var_1, "loadmap", var_2);
  var_1 = _id_4104(::_id_40CE, "ac130");
  var_2 = spawnStruct();
  var_2._id_40CB = &"MENU_30";
  var_2._id_40CC = 240;
  var_2._id_40CD = 100;
  var_0 _id_40DD(&"MENU_AC130", var_1, "loadmap", var_2);
  var_1 = _id_4104(::_id_40CE, "seaknight_assault");
  var_2 = spawnStruct();
  var_2._id_40CB = &"MENU_INITIAL_GEO_IN_PROGRESS";
  var_2._id_40CC = 240;
  var_2._id_40CD = 100;
  var_0 _id_40DD(&"MENU_SEAKNIGHT_ASSAULT", var_1, "loadmap", var_2);
  var_1 = _id_4104(::_id_40CE, "pilotcobra");
  var_2 = spawnStruct();
  var_2._id_40CB = &"MENU_INITIAL_GEO_IN_PROGRESS";
  var_2._id_40CC = 240;
  var_2._id_40CD = 100;
  var_0 _id_40DD(&"MENU_PILOT_COBRA", var_1, "loadmap", var_2);
  var_3 = _id_40DA("controls");
  var_4 = spawnStruct();
  var_4.index = 0;
  var_4.dvar = "controls_sticksConfig";
  var_4.value[0] = "thumbstick_default";
  var_4.value[1] = "thumbstick_southpaw";
  var_4.value[2] = "thumbstick_legacy";
  var_4.value[3] = "thumbstick_legacysouthpaw";
  var_4._id_40CB[0] = "Default";
  var_4._id_40CB[1] = "Southpaw";
  var_4._id_40CB[2] = "Legacy";
  var_4._id_40CB[3] = "Legacy Southpaw";
  var_3 _id_40E3(&"MENU_THUMBSTICK_LAYOUT", undefined, undefined, undefined, var_4);
  var_4 = spawnStruct();
  var_4.index = 0;
  var_4.dvar = "controls_buttonConfig";
  var_4.value[0] = "buttons_default";
  var_4.value[1] = "buttons_tactical";
  var_4.value[2] = "buttons_lefty";
  var_4.value[3] = "buttons_finesthour";
  var_4._id_40CB[0] = "Default";
  var_4._id_40CB[1] = "Tactical";
  var_4._id_40CB[2] = "Lefty";
  var_4._id_40CB[3] = "Finest Hour";
  var_3 _id_40E3(&"MENU_BUTTON_LAYOUT", undefined, undefined, undefined, var_4);
  var_4 = spawnStruct();
  var_4.index = 1;
  var_4.dvar = "controls_sensitivityConfig";
  var_4.value[0] = "sensitivity_low";
  var_4.value[1] = "sensitivity_medium";
  var_4.value[2] = "sensitivity_high";
  var_4.value[3] = "sensitivity_veryhigh";
  var_4._id_40CB[0] = "Low";
  var_4._id_40CB[1] = "Medium";
  var_4._id_40CB[2] = "High";
  var_4._id_40CB[3] = "Very High";
  var_3 _id_40E3(&"MENU_LOOK_SENSITIVITY", undefined, undefined, undefined, var_4);
  var_4 = spawnStruct();
  var_4.index = 0;
  var_4.dvar = "controls_inversionConfig";
  var_4.value[0] = "inversion_disabled";
  var_4.value[1] = "inversion_enabled";
  var_4._id_40CB[0] = "Disabled";
  var_4._id_40CB[1] = "Enabled";
  var_3 _id_40E3(&"MENU_LOOK_INVERSION", undefined, undefined, undefined, var_4);
  var_4 = spawnStruct();
  var_4.index = 1;
  var_4.dvar = "controls_autoaimConfig";
  var_4.value[0] = "autoaim_disabled";
  var_4.value[1] = "autoaim_enabled";
  var_4._id_40CB[0] = "Disabled";
  var_4._id_40CB[1] = "Enabled";
  var_3 _id_40E3(&"MENU_AUTOAIM", undefined, undefined, undefined, var_4);
  var_4 = spawnStruct();
  var_4.index = 1;
  var_4.dvar = "controls_vibrationConfig";
  var_4.value[0] = "vibration_disabled";
  var_4.value[1] = "vibration_enabled";
  var_4._id_40CB[0] = "Disabled";
  var_4._id_40CB[1] = "Enabled";
  var_3 _id_40E3(&"MENU_CONTROLLER_VIBRATION", undefined, undefined, undefined, var_4);
  var_5 = _id_40D4("main");
  var_1 = _id_4104(::_id_40D0, var_0);
  var_5 _id_40DD(&"MENU_SELECT_LEVEL", var_1, "openmenu_levels");
  var_6 = var_5 _id_40E5("options", &"MENU_OPTIONS");
  var_1 = _id_4104(::_id_40D0, var_3);
  var_6 _id_40DD(&"MENU_CONTROLS", var_1);
  var_6 _id_40DD(&"MENU_SUBTITLES");
  var_6 _id_40DD(&"MENU_SAVE_DEVICE");
  var_5 _id_40DD(&"MENU_CREDITS");
  var_1 = _id_4104(::_id_40CF);
  var_5 _id_40DD(&"MENU_MULTIPLAYER", var_1);
  _id_40D0(var_5);
  level.player thread _id_410A();
}

void() {}

_id_40CE(var_0) {
  changelevel(var_0);
}

_id_40CF() {
  level.player openpopupmenu("uiScript_startMultiplayer");
}

_id_40D0(var_0) {
  level._id_40CA[level._id_40CA.size] = var_0;
  var_1 = level._id_40D1;
  level._id_40D1 = var_0;

  if(var_0._id_40D2 == "fullScreen") {
    if(isDefined(var_1)) {
      var_1 thread _id_40EF(0.2, 1);

    }
    var_0 thread _id_40EE(0.2, 1);
    level notify("open_menu", level._id_40D1.name);
  } else {
    var_0 thread _id_40F1(0.2);

  }
  level.player playSound("mouse_click");
}

_id_40D3() {
  if(level._id_40CA.size == 1) {
    return;
  }
  level._id_40CA[level._id_40CA.size - 1] = undefined;
  var_0 = level._id_40D1;
  level._id_40D1 = level._id_40CA[level._id_40CA.size - 1];

  if(var_0._id_40D2 == "subMenu") {
    var_0 thread _id_40F0(0.2);
    level._id_40D1 _id_40F2(0.2, 1);
  } else {
    var_0 thread _id_40EF(0.2, 0);
    level._id_40D1 thread _id_40EE(0.2, 0);
    level notify("close_menu", level._id_40CA.size);
  }

  level.player playSound("mouse_click");
}

_id_40D4(var_0) {
  var_1 = spawnStruct();
  var_1.name = var_0;
  var_1._id_40D2 = "fullScreen";
  var_1._id_40D5 = [];
  var_1._id_40D6 = 120;
  var_1._id_40D7 = 20;
  var_1._id_40D8 = 0;
  var_1._id_40D9 = 0;
  var_1._id_40CC = 80;
  var_1._id_40CD = 100;
  var_1.xoffset = 0;
  var_1.yoffset = 0;
  return var_1;
}

_id_40DA(var_0) {
  var_1 = spawnStruct();
  var_1.name = var_0;
  var_1._id_40D2 = "fullScreen";
  var_1._id_40D5 = [];
  var_1._id_40D6 = 420;
  var_1._id_40D7 = 20;
  var_1._id_40D8 = 0;
  var_1._id_40D9 = 0;
  var_1._id_40CC = 80;
  var_1._id_40CD = 100;
  var_1.xoffset = 0;
  var_1.yoffset = 0;
  return var_1;
}

_id_40DB(var_0) {
  var_1 = spawnStruct();
  var_1.name = var_0;
  var_1._id_40D2 = "subMenu";
  var_1._id_40D5 = [];
  var_1._id_40D6 = 120;
  var_1._id_40D7 = 20;
  var_1._id_40D8 = 0;
  var_1._id_40D9 = 0;
  var_1._id_40DC = 0;
  return var_1;
}

_id_40DD(var_0, var_1, var_2, var_3) {
  precachestring(var_0);
  var_4 = spawnStruct();
  var_4._id_40DE = "item";
  var_4._id_40DF = "menu_button_selected";
  var_4._id_40E0 = var_0;
  var_4._id_40CC = 0;
  var_4._id_40CD = 0;
  var_4.xoffset = 0;
  var_4.yoffset = 0;
  var_4._id_40E1 = var_1;
  var_4._id_0EFE = var_2;
  var_4._id_1B32 = var_3;
  var_4._id_40E2 = self;
  var_4.index = self._id_40D5.size;
  self._id_40D5[self._id_40D5.size] = var_4;
}

_id_40E3(var_0, var_1, var_2, var_3, var_4) {
  precachestring(var_0);
  var_5 = spawnStruct();
  var_5._id_40DE = "settingMenu";
  var_5._id_40DF = "menu_button_selected";
  var_5._id_40E0 = var_0;
  var_5._id_40CC = 0;
  var_5._id_40CD = 0;
  var_5.xoffset = 0;
  var_5.yoffset = 0;
  var_5._id_40E1 = var_1;
  var_5._id_0EFE = var_2;
  var_5._id_1B32 = var_3;
  var_5._id_40E4 = var_4;
  var_5._id_40E2 = self;
  var_5.index = self._id_40D5.size;
  self._id_40D5[self._id_40D5.size] = var_5;
}

_id_40E5(var_0, var_1) {
  var_2 = _id_40DB(var_0);
  var_2._id_40DE = "subMenu";
  var_2._id_40DF = "menu_button_selected";
  var_2._id_40E0 = var_1;
  var_2._id_40CC = 0;
  var_2._id_40CD = 0;
  var_2.xoffset = 20;
  var_2.yoffset = self._id_40D7 + self._id_40D8;
  var_2._id_40E2 = self;
  var_2.index = self._id_40D5.size;
  self._id_40D5[self._id_40D5.size] = var_2;
  return var_2;
}

_id_40E6() {
  self._id_40E7 = maps\_hud_util::createicon(self._id_40DF, self._id_40E2._id_40D6, self._id_40E2._id_40D7);
  self._id_40E7.alpha = 0;
  self._id_40E7.sort = 0;
  self._id_40E8 = maps\_hud_util::createfontstring("default", 1.5);
  self._id_40E8.alpha = 0;
  self._id_40E8.sort = 100;
  self._id_40E8 settext(self._id_40E0);

  if(self._id_40DE == "settingMenu") {
    self._id_40E9 = maps\_hud_util::createfontstring("default", 1.5);
    self._id_40E9.alpha = 0;
    self._id_40E9.sort = 100;
    _id_4103();
  }

  if(self._id_40DE == "subMenu") {
    self._id_40EA = maps\_hud_util::createicon("menu_caret_closed", self._id_40E2._id_40D7, self._id_40E2._id_40D7);
    self._id_40EA.alpha = 0;
    self._id_40EA.sort = 100;
  }

  if(isDefined(self._id_1B32)) {
    self._id_40EB = maps\_hud_util::createfontstring("default", 1.5);
    self._id_40EB.alpha = 0;
    self._id_40EB.sort = 100;
    self._id_40EB settext(self._id_1B32._id_40CB);
  }
}

_id_40EC() {
  if(self._id_40DE == "subMenu") {
    self._id_40EA maps\_hud_util::destroyelem();

  }
  if(self._id_40DE == "settingMenu") {
    self._id_40E9 maps\_hud_util::destroyelem();

  }
  if(isDefined(self._id_40EB)) {
    self._id_40EB maps\_hud_util::destroyelem();

  }
  self._id_40E7 maps\_hud_util::destroyelem();
  self._id_40E8 maps\_hud_util::destroyelem();
}

_id_40ED(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 3;
  self._id_40E7 maps\_hud_util::setpoint(var_0, var_1, var_2, var_3, var_4);

  if(self._id_40DE == "subMenu") {
    self._id_40EA maps\_hud_util::setpoint(var_0, var_1, var_2, var_3, var_4);
    var_5 = var_5 + 16;
  }

  if(self._id_40DE == "settingMenu") {
    self._id_40E9 maps\_hud_util::setpoint("TOPRIGHT", var_1, var_2 + var_5 + 400, var_3, var_4);

  }
  if(isDefined(self._id_40EB)) {
    self._id_40EB maps\_hud_util::setpoint("TOPLEFT", var_1, self._id_1B32._id_40CC, self._id_1B32._id_40CD, var_4);

  }
  self._id_40E8 maps\_hud_util::setpoint(var_0, var_1, var_2 + var_5, var_3, var_4);
}

_id_40EE(var_0, var_1) {
  var_2 = 0;

  for(var_3 = 0; var_3 < self._id_40D5.size; var_3++) {
    var_4 = self._id_40D5[var_3];
    var_4 _id_40E6();

    if(var_1) {
      var_4 _id_40ED("TOPLEFT", "TOPRIGHT", self._id_40CC, self._id_40CD + var_2);
    } else {
      var_4 _id_40ED("TOPRIGHT", "TOPLEFT", self._id_40CC, self._id_40CD + var_2);

    }
    var_4._id_40CC = self._id_40CC;
    var_4._id_40CD = self._id_40CD + var_2;
    var_2 = var_2 + (self._id_40D7 + self._id_40D8);

    if(var_4._id_40DE == "subMenu" && var_4._id_40DC) {
      var_2 = var_2 + var_4 _id_40F6();
    }
  }

  if(self._id_40D2 == "subMenu") {
    self._id_40E2 _id_40EE(var_0, var_1);

  }
  _id_40F2(var_0, 1);
}

_id_40EF(var_0, var_1) {
  var_2 = 0;

  for(var_3 = 0; var_3 < self._id_40D5.size; var_3++) {
    var_4 = self._id_40D5[var_3];
    var_5 = -1 * self._id_40D6;

    if(var_1) {
      var_4 _id_40ED("TOPRIGHT", "TOPLEFT", self._id_40CC, self._id_40CD + var_2, var_0);
      var_4._id_40E7 fadeovertime(var_0);
      var_4._id_40E7.alpha = 0;
      var_4._id_40E8 fadeovertime(var_0);
      var_4._id_40E8.alpha = 0;

      if(var_4._id_40DE == "settingMenu") {
        var_4._id_40E9 fadeovertime(var_0);
        var_4._id_40E9.alpha = 0;
      }

      if(var_4._id_40DE == "subMenu") {
        var_4._id_40EA fadeovertime(var_0);
        var_4._id_40EA.alpha = 0;
      }
    } else {
      var_4 _id_40ED("TOPLEFT", "TOPRIGHT", self._id_40CC, self._id_40CD + var_2, var_0);
      var_4._id_40E7 fadeovertime(var_0);
      var_4._id_40E7.alpha = 0;
      var_4._id_40E8 fadeovertime(var_0);
      var_4._id_40E8.alpha = 0;

      if(var_4._id_40DE == "settingMenu") {
        var_4._id_40E9 fadeovertime(var_0);
        var_4._id_40E9.alpha = 0;
      }

      if(var_4._id_40DE == "subMenu") {
        var_4._id_40EA fadeovertime(var_0);
        var_4._id_40EA.alpha = 0;
      }
    }

    var_4._id_40CC = self._id_40CC;
    var_4._id_40CD = self._id_40CD + var_2;
    var_2 = var_2 + (self._id_40D7 + self._id_40D8);

    if(var_4._id_40DE == "subMenu" && var_4._id_40DC) {
      var_2 = var_2 + var_4 _id_40F6();
    }
  }

  if(self._id_40D2 == "subMenu") {
    self._id_40E2 thread _id_40EF(var_0, var_1);

  }
  wait(var_0);

  for(var_3 = 0; var_3 < self._id_40D5.size; var_3++) {
    var_4 = self._id_40D5[var_3];
    var_4 _id_40EC();
  }
}

_id_40F0(var_0) {
  self._id_40DC = 0;
  self._id_40EA setshader("menu_caret_closed", self._id_40E2._id_40D7, self._id_40E2._id_40D7);
  var_1 = 0;

  for(var_2 = 0; var_2 < self._id_40D5.size; var_2++) {
    var_3 = self._id_40D5[var_2];
    var_3 _id_40ED("TOPLEFT", "TOPLEFT", self._id_40CC, self._id_40CD, var_0);
    var_3._id_40E7 fadeovertime(var_0);
    var_3._id_40E7.alpha = 0;
    var_3._id_40E8 fadeovertime(var_0);
    var_3._id_40E8.alpha = 0;

    if(var_3._id_40DE == "subMenu") {
      var_3._id_40EA fadeovertime(var_0);
      var_3._id_40EA.alpha = 0;
    }

    var_3._id_40CC = self._id_40CC;
    var_3._id_40CD = self._id_40CD;
  }

  wait(var_0);

  for(var_2 = 0; var_2 < self._id_40D5.size; var_2++) {
    var_3 = self._id_40D5[var_2];
    var_3._id_40E7 maps\_hud_util::destroyelem();
    var_3._id_40E8 maps\_hud_util::destroyelem();

    if(var_3._id_40DE == "subMenu") {
      var_3._id_40EA maps\_hud_util::destroyelem();
    }
  }
}

_id_40F1(var_0) {
  self._id_40DC = 1;
  self._id_40EA setshader("menu_caret_open", self._id_40E2._id_40D7, self._id_40E2._id_40D7);

  for(var_1 = 0; var_1 < self._id_40D5.size; var_1++) {
    var_2 = self._id_40D5[var_1];
    var_2 _id_40E6();
    var_2 _id_40ED("TOPLEFT", "TOPLEFT", self._id_40CC + self.xoffset, self._id_40CD + self.yoffset);
    var_2._id_40CC = self._id_40CC + self.xoffset;
    var_2._id_40CD = self._id_40CD + self.yoffset;
  }

  _id_40F2(var_0, 1);
}

_id_40F2(var_0, var_1) {
  var_2 = self.xoffset;
  var_3 = self.yoffset;

  for(var_4 = 0; var_4 < self._id_40D5.size; var_4++) {
    var_5 = self._id_40D5[var_4];
    var_5 _id_40F3(var_0, var_4 == self._id_40D9);
    var_6 = var_5._id_40CC;
    var_7 = var_5._id_40CD;

    if(var_1 || self._id_40CC + var_2 != var_6 || self._id_40CD + var_3 != var_7) {
      var_5 _id_40ED("TOPLEFT", "TOPLEFT", self._id_40CC + var_2, self._id_40CD + var_3, var_0);
      var_5._id_40CC = self._id_40CC + var_2;
      var_5._id_40CD = self._id_40CD + var_3;
    }

    var_3 = var_3 + (self._id_40D7 + self._id_40D8);

    if(var_5._id_40DE == "subMenu" && var_5._id_40DC) {
      var_3 = var_3 + var_5 _id_40F6();
    }
  }

  if(isDefined(self._id_40E2)) {
    self._id_40E2 thread _id_40F2(var_0, var_1);
  }
}

_id_40F3(var_0, var_1) {
  self._id_40E7 fadeovertime(var_0);
  self._id_40E8 fadeovertime(var_0);

  if(isDefined(self._id_40E9)) {
    self._id_40E9 fadeovertime(var_0);

  }
  if(isDefined(self._id_40EB)) {
    self._id_40EB fadeovertime(var_0);

  }
  if(var_1) {
    if(self._id_40E2 == level._id_40D1) {
      _id_40F4(1);
    } else {
      _id_40F4(0.5);

    }
    if(isDefined(self._id_40EB)) {
      self._id_40EB.alpha = 1;
    }
  } else {
    if(self._id_40E2 == level._id_40D1) {
      _id_40F4(0.5);
    } else {
      _id_40F4(0.25);

    }
    if(isDefined(self._id_40EB)) {
      self._id_40EB.alpha = 0;
    }
  }
}

_id_40F4(var_0) {
  self._id_40E7.alpha = var_0;
  self._id_40E8.alpha = var_0;

  if(self._id_40DE == "settingMenu") {
    self._id_40E9.alpha = var_0;

  }
  if(self._id_40DE == "subMenu") {
    self._id_40EA.alpha = var_0;
  }
}

_id_40F5(var_0) {
  self._id_40E8.color = var_0;
}

_id_40F6() {
  var_0 = 0;

  for(var_1 = 0; var_1 < self._id_40D5.size; var_1++) {
    var_2 = self._id_40D5[var_1];
    var_0 = var_0 + (self._id_40D7 + self._id_40D8);

    if(var_2._id_40DE == "subMenu" && var_2._id_40DC) {
      var_0 = var_0 + var_2 _id_40F6();
    }
  }

  return var_0;
}

_id_40F7() {
  self._id_40D9--;

  if(self._id_40D9 < 0) {
    self._id_40D9 = self._id_40D5.size - 1;

  }
  _id_40F2(0.1, 0);
  level.player playSound("mouse_over");
}

_id_40F8() {
  self._id_40D9++;

  if(self._id_40D9 >= self._id_40D5.size) {
    self._id_40D9 = 0;

  }
  _id_40F2(0.1, 0);
  level.player playSound("mouse_over");
}

_id_40F9() {
  _id_40D3();
}

_id_40FA() {
  var_0 = self._id_40D5[self._id_40D9];

  if(var_0._id_40DE == "subMenu") {
    _id_40D0(var_0);
  } else if(var_0._id_40DE == "item") {
    var_0 thread _id_4107();
  }
}

_id_40FB() {
  var_0 = self._id_40D5[self._id_40D9];

  if(var_0._id_40DE == "settingMenu") {
    var_1 = getdvar(var_0._id_40E4.dvar);
    var_2 = var_0._id_40E4.value;
    var_3 = 0;

    for(var_4 = 0; var_4 < var_2.size; var_4++) {
      var_5 = var_2[var_4];

      if(var_5 != var_1) {
        continue;
      }
      var_3 = var_4 - 1;

      if(var_3 >= 0) {
        var_0._id_40E4.index = var_3;
        setdvar(var_0._id_40E4.dvar, var_2[var_3]);
        var_0 _id_4103();
        level.player playSound("mouse_over");
      }

      break;
    }
  }
}

_id_40FC() {
  var_0 = self._id_40D5[self._id_40D9];

  if(var_0._id_40DE == "settingMenu") {
    var_1 = getdvar(var_0._id_40E4.dvar);
    var_2 = var_0._id_40E4.value;
    var_3 = 0;

    for(var_4 = 0; var_4 < var_2.size; var_4++) {
      var_5 = var_2[var_4];

      if(var_5 != var_1) {
        continue;
      }
      var_3 = var_4 + 1;

      if(var_3 <= var_0._id_40E4.value.size - 1) {
        var_0._id_40E4.index = var_3;
        setdvar(var_0._id_40E4.dvar, var_2[var_3]);
        var_0 _id_4103();
        level.player playSound("mouse_over");
      }

      break;
    }
  }
}

_id_40FD() {
  setdvar("controls_sticksConfig", "thumbstick_default");
}

_id_40FE() {
  setdvar("controls_buttonConfig", "buttons_default");
}

_id_40FF() {
  setdvar("controls_sensitivityConfig", "sensitivity_medium");
}

_id_4100() {
  setdvar("controls_inversionConfig", "inversion_disabled");
}

_id_4101() {
  setdvar("controls_autoaimConfig", "autoaim_enabled");
}

_id_4102() {
  setdvar("controls_vibrationConfig", "vibration_enabled");
}

_id_4103() {
  self._id_40E9 settext(self._id_40E4._id_40CB[self._id_40E4.index]);
}

_id_4104(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.name = var_0;

  if(isDefined(var_1)) {
    var_3._id_4105 = var_1;

  }
  if(isDefined(var_2)) {
    var_3._id_4106 = var_2;

  }
  return var_3;
}

_id_4107() {
  if(isDefined(self._id_40E1)) {
    if(isDefined(self._id_40E1._id_4105)) {
      thread[[self._id_40E1.name]](self._id_40E1._id_4105);
    } else {
      thread[[self._id_40E1.name]]();
    }
  }

  if(isDefined(self._id_0EFE)) {
    level notify(self._id_0EFE);
  }
}

_id_4108() {
  level._id_4109 setgoalnode(getnode("node2", "targetname"));
  level._id_19CD attachpath(getvehiclenode("path2", "targetname"));
  thread maps\_vehicle::_id_1FA6(level._id_19CD);
}

_id_410A() {
  for(;;) {
    self waittill("menuresponse", var_0, var_1);

    switch (var_1) {
      case "DPAD_UP":
        level._id_40D1 _id_40F7();
        break;
      case "DPAD_DOWN":
        level._id_40D1 _id_40F8();
        break;
      case "DPAD_LEFT":
        level._id_40D1 _id_40FB();
        break;
      case "DPAD_RIGHT":
        level._id_40D1 _id_40FC();
        break;
      case "BUTTON_A":
        level._id_40D1 _id_40FA();
        break;
      case "BUTTON_B":
        level._id_40D1 _id_40F9();
        break;
    }
  }
}