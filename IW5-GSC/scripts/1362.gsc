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
  thread initthumbsticklayout();
  thread initbuttonlayout();
  thread initsensitivity();
  thread initinversion();
  thread initautoaim();
  thread initvibration();
  level.menustack = [];
  var_0 = createmenu("levels");
  var_1 = setupaction(::loadmap, "cqb_1");
  var_2 = spawnStruct();
  var_2.display = &"MENU_1ST_PASS";
  var_2.xpos = 240;
  var_2.ypos = 100;
  var_0 additem(&"MENU_CQB_TEST", var_1, "loadmap", var_2);
  var_1 = setupaction(::loadmap, "descent");
  var_2 = spawnStruct();
  var_2.display = &"MENU_1ST_PASS";
  var_2.xpos = 240;
  var_2.ypos = 100;
  var_0 additem(&"MENU_BUNKER", var_1, "loadmap", var_2);
  var_1 = setupaction(::loadmap, "aftermath");
  var_2 = spawnStruct();
  var_2.display = &"MENU_100_INITIAL_GEO";
  var_2.xpos = 240;
  var_2.ypos = 100;
  var_0 additem(&"MENU_AFTERMATH", var_1, "loadmap", var_2);
  var_1 = setupaction(::loadmap, "chechnya_escape");
  var_2 = spawnStruct();
  var_2.display = &"MENU_40_INITIAL_GEO";
  var_2.xpos = 240;
  var_2.ypos = 100;
  var_0 additem(&"MENU_CHECHNYA_ESCAPE", var_1, "loadmap", var_2);
  var_1 = setupaction(::loadmap, "marksman");
  var_2 = spawnStruct();
  var_2.display = &"MENU_25_SCRIPTED";
  var_2.xpos = 240;
  var_2.ypos = 100;
  var_0 additem(&"MENU_MARKSMAN", var_1, "loadmap", var_2);
  var_1 = setupaction(::loadmap, "seaknight_defend");
  var_2 = spawnStruct();
  var_2.display = &"MENU_PROTOTYPE_LEVEL_30_SCRIPTED";
  var_2.xpos = 240;
  var_2.ypos = 100;
  var_0 additem(&"MENU_SEAKNIGHT_DEFEND", var_1, "loadmap", var_2);
  var_1 = setupaction(::loadmap, "wetwork");
  var_2 = spawnStruct();
  var_2.display = &"MENU_100_INITIAL_GEO";
  var_2.xpos = 240;
  var_2.ypos = 100;
  var_0 additem(&"MENU_WETWORK", var_1, "loadmap", var_2);
  var_1 = setupaction(::loadmap, "cargoship");
  var_2 = spawnStruct();
  var_2.display = &"MENU_10_SCRIPTED";
  var_2.xpos = 240;
  var_2.ypos = 100;
  var_0 additem(&"MENU_CARGOSHIP", var_1, "loadmap", var_2);
  var_1 = setupaction(::loadmap, "bog");
  var_2 = spawnStruct();
  var_2.display = &"MENU_35_INITIAL_GEO";
  var_2.xpos = 240;
  var_2.ypos = 100;
  var_0 additem(&"MENU_BOG", var_1, "loadmap", var_2);
  var_1 = setupaction(::loadmap, "training");
  var_2 = spawnStruct();
  var_2.display = &"MENU_5_SCRIPTED";
  var_2.xpos = 240;
  var_2.ypos = 100;
  var_0 additem(&"MENU_TRAINING1", var_1, "loadmap", var_2);
  var_1 = setupaction(::loadmap, "ac130");
  var_2 = spawnStruct();
  var_2.display = &"MENU_30";
  var_2.xpos = 240;
  var_2.ypos = 100;
  var_0 additem(&"MENU_AC130", var_1, "loadmap", var_2);
  var_1 = setupaction(::loadmap, "seaknight_assault");
  var_2 = spawnStruct();
  var_2.display = &"MENU_INITIAL_GEO_IN_PROGRESS";
  var_2.xpos = 240;
  var_2.ypos = 100;
  var_0 additem(&"MENU_SEAKNIGHT_ASSAULT", var_1, "loadmap", var_2);
  var_1 = setupaction(::loadmap, "pilotcobra");
  var_2 = spawnStruct();
  var_2.display = &"MENU_INITIAL_GEO_IN_PROGRESS";
  var_2.xpos = 240;
  var_2.ypos = 100;
  var_0 additem(&"MENU_PILOT_COBRA", var_1, "loadmap", var_2);
  var_3 = createmenu_controls("controls");
  var_4 = spawnStruct();
  var_4.index = 0;
  var_4.dvar = "controls_sticksConfig";
  var_4.value[0] = "thumbstick_default";
  var_4.value[1] = "thumbstick_southpaw";
  var_4.value[2] = "thumbstick_legacy";
  var_4.value[3] = "thumbstick_legacysouthpaw";
  var_4.display[0] = "Default";
  var_4.display[1] = "Southpaw";
  var_4.display[2] = "Legacy";
  var_4.display[3] = "Legacy Southpaw";
  var_3 additemsetting(&"MENU_THUMBSTICK_LAYOUT", undefined, undefined, undefined, var_4);
  var_4 = spawnStruct();
  var_4.index = 0;
  var_4.dvar = "controls_buttonConfig";
  var_4.value[0] = "buttons_default";
  var_4.value[1] = "buttons_tactical";
  var_4.value[2] = "buttons_lefty";
  var_4.value[3] = "buttons_finesthour";
  var_4.display[0] = "Default";
  var_4.display[1] = "Tactical";
  var_4.display[2] = "Lefty";
  var_4.display[3] = "Finest Hour";
  var_3 additemsetting(&"MENU_BUTTON_LAYOUT", undefined, undefined, undefined, var_4);
  var_4 = spawnStruct();
  var_4.index = 1;
  var_4.dvar = "controls_sensitivityConfig";
  var_4.value[0] = "sensitivity_low";
  var_4.value[1] = "sensitivity_medium";
  var_4.value[2] = "sensitivity_high";
  var_4.value[3] = "sensitivity_veryhigh";
  var_4.display[0] = "Low";
  var_4.display[1] = "Medium";
  var_4.display[2] = "High";
  var_4.display[3] = "Very High";
  var_3 additemsetting(&"MENU_LOOK_SENSITIVITY", undefined, undefined, undefined, var_4);
  var_4 = spawnStruct();
  var_4.index = 0;
  var_4.dvar = "controls_inversionConfig";
  var_4.value[0] = "inversion_disabled";
  var_4.value[1] = "inversion_enabled";
  var_4.display[0] = "Disabled";
  var_4.display[1] = "Enabled";
  var_3 additemsetting(&"MENU_LOOK_INVERSION", undefined, undefined, undefined, var_4);
  var_4 = spawnStruct();
  var_4.index = 1;
  var_4.dvar = "controls_autoaimConfig";
  var_4.value[0] = "autoaim_disabled";
  var_4.value[1] = "autoaim_enabled";
  var_4.display[0] = "Disabled";
  var_4.display[1] = "Enabled";
  var_3 additemsetting(&"MENU_AUTOAIM", undefined, undefined, undefined, var_4);
  var_4 = spawnStruct();
  var_4.index = 1;
  var_4.dvar = "controls_vibrationConfig";
  var_4.value[0] = "vibration_disabled";
  var_4.value[1] = "vibration_enabled";
  var_4.display[0] = "Disabled";
  var_4.display[1] = "Enabled";
  var_3 additemsetting(&"MENU_CONTROLLER_VIBRATION", undefined, undefined, undefined, var_4);
  var_5 = createmenu("main");
  var_1 = setupaction(::pushmenu, var_0);
  var_5 additem(&"MENU_SELECT_LEVEL", var_1, "openmenu_levels");
  var_6 = var_5 addsubmenu("options", &"MENU_OPTIONS");
  var_1 = setupaction(::pushmenu, var_3);
  var_6 additem(&"MENU_CONTROLS", var_1);
  var_6 additem(&"MENU_SUBTITLES");
  var_6 additem(&"MENU_SAVE_DEVICE");
  var_5 additem(&"MENU_CREDITS");
  var_1 = setupaction(::loadmultiplayer);
  var_5 additem(&"MENU_MULTIPLAYER", var_1);
  pushmenu(var_5);
  level.player thread menuresponse();
}

void() {}

loadmap(var_0) {
  changelevel(var_0);
}

loadmultiplayer() {
  level.player openpopupmenu("uiScript_startMultiplayer");
}

pushmenu(var_0) {
  level.menustack[level.menustack.size] = var_0;
  var_1 = level.curmenu;
  level.curmenu = var_0;

  if(var_0.menutype == "fullScreen") {
    if(isDefined(var_1)) {
      var_1 thread hidemenu(0.2, 1);
    }
    var_0 thread showmenu(0.2, 1);
    level notify("open_menu", level.curmenu.name);
  } else {
    var_0 thread expandmenu(0.2);
  }
  level.player playSound("mouse_click");
}

popmenu() {
  if(level.menustack.size == 1) {
    return;
  }
  level.menustack[level.menustack.size - 1] = undefined;
  var_0 = level.curmenu;
  level.curmenu = level.menustack[level.menustack.size - 1];

  if(var_0.menutype == "subMenu") {
    var_0 thread collapsemenu(0.2);
    level.curmenu updatemenu(0.2, 1);
  } else {
    var_0 thread hidemenu(0.2, 0);
    level.curmenu thread showmenu(0.2, 0);
    level notify("close_menu", level.menustack.size);
  }

  level.player playSound("mouse_click");
}

createmenu(var_0) {
  var_1 = spawnStruct();
  var_1.name = var_0;
  var_1.menutype = "fullScreen";
  var_1.itemdefs = [];
  var_1.itemwidth = 120;
  var_1.itemheight = 20;
  var_1.itempadding = 0;
  var_1.selectedindex = 0;
  var_1.xpos = 80;
  var_1.ypos = 100;
  var_1.xoffset = 0;
  var_1.yoffset = 0;
  return var_1;
}

createmenu_controls(var_0) {
  var_1 = spawnStruct();
  var_1.name = var_0;
  var_1.menutype = "fullScreen";
  var_1.itemdefs = [];
  var_1.itemwidth = 420;
  var_1.itemheight = 20;
  var_1.itempadding = 0;
  var_1.selectedindex = 0;
  var_1.xpos = 80;
  var_1.ypos = 100;
  var_1.xoffset = 0;
  var_1.yoffset = 0;
  return var_1;
}

createsubmenu(var_0) {
  var_1 = spawnStruct();
  var_1.name = var_0;
  var_1.menutype = "subMenu";
  var_1.itemdefs = [];
  var_1.itemwidth = 120;
  var_1.itemheight = 20;
  var_1.itempadding = 0;
  var_1.selectedindex = 0;
  var_1.isexpanded = 0;
  return var_1;
}

additem(var_0, var_1, var_2, var_3) {
  precachestring(var_0);
  var_4 = spawnStruct();
  var_4.itemtype = "item";
  var_4.bgshader = "menu_button_selected";
  var_4.fgtext = var_0;
  var_4.xpos = 0;
  var_4.ypos = 0;
  var_4.xoffset = 0;
  var_4.yoffset = 0;
  var_4.action = var_1;
  var_4.event = var_2;
  var_4.description = var_3;
  var_4.parentdef = self;
  var_4.index = self.itemdefs.size;
  self.itemdefs[self.itemdefs.size] = var_4;
}

additemsetting(var_0, var_1, var_2, var_3, var_4) {
  precachestring(var_0);
  var_5 = spawnStruct();
  var_5.itemtype = "settingMenu";
  var_5.bgshader = "menu_button_selected";
  var_5.fgtext = var_0;
  var_5.xpos = 0;
  var_5.ypos = 0;
  var_5.xoffset = 0;
  var_5.yoffset = 0;
  var_5.action = var_1;
  var_5.event = var_2;
  var_5.description = var_3;
  var_5.setting = var_4;
  var_5.parentdef = self;
  var_5.index = self.itemdefs.size;
  self.itemdefs[self.itemdefs.size] = var_5;
}

addsubmenu(var_0, var_1) {
  var_2 = createsubmenu(var_0);
  var_2.itemtype = "subMenu";
  var_2.bgshader = "menu_button_selected";
  var_2.fgtext = var_1;
  var_2.xpos = 0;
  var_2.ypos = 0;
  var_2.xoffset = 20;
  var_2.yoffset = self.itemheight + self.itempadding;
  var_2.parentdef = self;
  var_2.index = self.itemdefs.size;
  self.itemdefs[self.itemdefs.size] = var_2;
  return var_2;
}

createitemelems() {
  self.bgicon = maps\_hud_util::createicon(self.bgshader, self.parentdef.itemwidth, self.parentdef.itemheight);
  self.bgicon.alpha = 0;
  self.bgicon.sort = 0;
  self.fontstring = maps\_hud_util::createfontstring("default", 1.5);
  self.fontstring.alpha = 0;
  self.fontstring.sort = 100;
  self.fontstring settext(self.fgtext);

  if(self.itemtype == "settingMenu") {
    self.settingvalue = maps\_hud_util::createfontstring("default", 1.5);
    self.settingvalue.alpha = 0;
    self.settingvalue.sort = 100;
    updatedisplayvalue();
  }

  if(self.itemtype == "subMenu") {
    self.careticon = maps\_hud_util::createicon("menu_caret_closed", self.parentdef.itemheight, self.parentdef.itemheight);
    self.careticon.alpha = 0;
    self.careticon.sort = 100;
  }

  if(isDefined(self.description)) {
    self.descriptionvalue = maps\_hud_util::createfontstring("default", 1.5);
    self.descriptionvalue.alpha = 0;
    self.descriptionvalue.sort = 100;
    self.descriptionvalue settext(self.description.display);
  }
}

destroyitemelems() {
  if(self.itemtype == "subMenu") {
    self.careticon maps\_hud_util::destroyelem();
  }
  if(self.itemtype == "settingMenu") {
    self.settingvalue maps\_hud_util::destroyelem();
  }
  if(isDefined(self.descriptionvalue)) {
    self.descriptionvalue maps\_hud_util::destroyelem();
  }
  self.bgicon maps\_hud_util::destroyelem();
  self.fontstring maps\_hud_util::destroyelem();
}

setelempoints(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 3;
  self.bgicon maps\_hud_util::setpoint(var_0, var_1, var_2, var_3, var_4);

  if(self.itemtype == "subMenu") {
    self.careticon maps\_hud_util::setpoint(var_0, var_1, var_2, var_3, var_4);
    var_5 = var_5 + 16;
  }

  if(self.itemtype == "settingMenu") {
    self.settingvalue maps\_hud_util::setpoint("TOPRIGHT", var_1, var_2 + var_5 + 400, var_3, var_4);
  }
  if(isDefined(self.descriptionvalue)) {
    self.descriptionvalue maps\_hud_util::setpoint("TOPLEFT", var_1, self.description.xpos, self.description.ypos, var_4);
  }
  self.fontstring maps\_hud_util::setpoint(var_0, var_1, var_2 + var_5, var_3, var_4);
}

showmenu(var_0, var_1) {
  var_2 = 0;

  for(var_3 = 0; var_3 < self.itemdefs.size; var_3++) {
    var_4 = self.itemdefs[var_3];
    var_4 createitemelems();

    if(var_1) {
      var_4 setelempoints("TOPLEFT", "TOPRIGHT", self.xpos, self.ypos + var_2);
    } else {
      var_4 setelempoints("TOPRIGHT", "TOPLEFT", self.xpos, self.ypos + var_2);
    }
    var_4.xpos = self.xpos;
    var_4.ypos = self.ypos + var_2;
    var_2 = var_2 + (self.itemheight + self.itempadding);

    if(var_4.itemtype == "subMenu" && var_4.isexpanded) {
      var_2 = var_2 + var_4 getmenuheight();
    }
  }

  if(self.menutype == "subMenu") {
    self.parentdef showmenu(var_0, var_1);
  }
  updatemenu(var_0, 1);
}

hidemenu(var_0, var_1) {
  var_2 = 0;

  for(var_3 = 0; var_3 < self.itemdefs.size; var_3++) {
    var_4 = self.itemdefs[var_3];
    var_5 = -1 * self.itemwidth;

    if(var_1) {
      var_4 setelempoints("TOPRIGHT", "TOPLEFT", self.xpos, self.ypos + var_2, var_0);
      var_4.bgicon fadeovertime(var_0);
      var_4.bgicon.alpha = 0;
      var_4.fontstring fadeovertime(var_0);
      var_4.fontstring.alpha = 0;

      if(var_4.itemtype == "settingMenu") {
        var_4.settingvalue fadeovertime(var_0);
        var_4.settingvalue.alpha = 0;
      }

      if(var_4.itemtype == "subMenu") {
        var_4.careticon fadeovertime(var_0);
        var_4.careticon.alpha = 0;
      }
    } else {
      var_4 setelempoints("TOPLEFT", "TOPRIGHT", self.xpos, self.ypos + var_2, var_0);
      var_4.bgicon fadeovertime(var_0);
      var_4.bgicon.alpha = 0;
      var_4.fontstring fadeovertime(var_0);
      var_4.fontstring.alpha = 0;

      if(var_4.itemtype == "settingMenu") {
        var_4.settingvalue fadeovertime(var_0);
        var_4.settingvalue.alpha = 0;
      }

      if(var_4.itemtype == "subMenu") {
        var_4.careticon fadeovertime(var_0);
        var_4.careticon.alpha = 0;
      }
    }

    var_4.xpos = self.xpos;
    var_4.ypos = self.ypos + var_2;
    var_2 = var_2 + (self.itemheight + self.itempadding);

    if(var_4.itemtype == "subMenu" && var_4.isexpanded) {
      var_2 = var_2 + var_4 getmenuheight();
    }
  }

  if(self.menutype == "subMenu") {
    self.parentdef thread hidemenu(var_0, var_1);
  }
  wait(var_0);

  for(var_3 = 0; var_3 < self.itemdefs.size; var_3++) {
    var_4 = self.itemdefs[var_3];
    var_4 destroyitemelems();
  }
}

collapsemenu(var_0) {
  self.isexpanded = 0;
  self.careticon setshader("menu_caret_closed", self.parentdef.itemheight, self.parentdef.itemheight);
  var_1 = 0;

  for(var_2 = 0; var_2 < self.itemdefs.size; var_2++) {
    var_3 = self.itemdefs[var_2];
    var_3 setelempoints("TOPLEFT", "TOPLEFT", self.xpos, self.ypos, var_0);
    var_3.bgicon fadeovertime(var_0);
    var_3.bgicon.alpha = 0;
    var_3.fontstring fadeovertime(var_0);
    var_3.fontstring.alpha = 0;

    if(var_3.itemtype == "subMenu") {
      var_3.careticon fadeovertime(var_0);
      var_3.careticon.alpha = 0;
    }

    var_3.xpos = self.xpos;
    var_3.ypos = self.ypos;
  }

  wait(var_0);

  for(var_2 = 0; var_2 < self.itemdefs.size; var_2++) {
    var_3 = self.itemdefs[var_2];
    var_3.bgicon maps\_hud_util::destroyelem();
    var_3.fontstring maps\_hud_util::destroyelem();

    if(var_3.itemtype == "subMenu") {
      var_3.careticon maps\_hud_util::destroyelem();
    }
  }
}

expandmenu(var_0) {
  self.isexpanded = 1;
  self.careticon setshader("menu_caret_open", self.parentdef.itemheight, self.parentdef.itemheight);

  for(var_1 = 0; var_1 < self.itemdefs.size; var_1++) {
    var_2 = self.itemdefs[var_1];
    var_2 createitemelems();
    var_2 setelempoints("TOPLEFT", "TOPLEFT", self.xpos + self.xoffset, self.ypos + self.yoffset);
    var_2.xpos = self.xpos + self.xoffset;
    var_2.ypos = self.ypos + self.yoffset;
  }

  updatemenu(var_0, 1);
}

updatemenu(var_0, var_1) {
  var_2 = self.xoffset;
  var_3 = self.yoffset;

  for(var_4 = 0; var_4 < self.itemdefs.size; var_4++) {
    var_5 = self.itemdefs[var_4];
    var_5 setselected(var_0, var_4 == self.selectedindex);
    var_6 = var_5.xpos;
    var_7 = var_5.ypos;

    if(var_1 || self.xpos + var_2 != var_6 || self.ypos + var_3 != var_7) {
      var_5 setelempoints("TOPLEFT", "TOPLEFT", self.xpos + var_2, self.ypos + var_3, var_0);
      var_5.xpos = self.xpos + var_2;
      var_5.ypos = self.ypos + var_3;
    }

    var_3 = var_3 + (self.itemheight + self.itempadding);

    if(var_5.itemtype == "subMenu" && var_5.isexpanded) {
      var_3 = var_3 + var_5 getmenuheight();
    }
  }

  if(isDefined(self.parentdef)) {
    self.parentdef thread updatemenu(var_0, var_1);
  }
}

setselected(var_0, var_1) {
  self.bgicon fadeovertime(var_0);
  self.fontstring fadeovertime(var_0);

  if(isDefined(self.settingvalue)) {
    self.settingvalue fadeovertime(var_0);
  }
  if(isDefined(self.descriptionvalue)) {
    self.descriptionvalue fadeovertime(var_0);
  }
  if(var_1) {
    if(self.parentdef == level.curmenu) {
      setelemalpha(1);
    } else {
      setelemalpha(0.5);
    }
    if(isDefined(self.descriptionvalue)) {
      self.descriptionvalue.alpha = 1;
    }
  } else {
    if(self.parentdef == level.curmenu) {
      setelemalpha(0.5);
    } else {
      setelemalpha(0.25);
    }
    if(isDefined(self.descriptionvalue)) {
      self.descriptionvalue.alpha = 0;
    }
  }
}

setelemalpha(var_0) {
  self.bgicon.alpha = var_0;
  self.fontstring.alpha = var_0;

  if(self.itemtype == "settingMenu") {
    self.settingvalue.alpha = var_0;
  }
  if(self.itemtype == "subMenu") {
    self.careticon.alpha = var_0;
  }
}

setelemcolor(var_0) {
  self.fontstring.color = var_0;
}

getmenuheight() {
  var_0 = 0;

  for(var_1 = 0; var_1 < self.itemdefs.size; var_1++) {
    var_2 = self.itemdefs[var_1];
    var_0 = var_0 + (self.itemheight + self.itempadding);

    if(var_2.itemtype == "subMenu" && var_2.isexpanded) {
      var_0 = var_0 + var_2 getmenuheight();
    }
  }

  return var_0;
}

ondpadup() {
  self.selectedindex--;

  if(self.selectedindex < 0) {
    self.selectedindex = self.itemdefs.size - 1;
  }
  updatemenu(0.1, 0);
  level.player playSound("mouse_over");
}

ondpaddown() {
  self.selectedindex++;

  if(self.selectedindex >= self.itemdefs.size) {
    self.selectedindex = 0;
  }
  updatemenu(0.1, 0);
  level.player playSound("mouse_over");
}

onbuttonb() {
  popmenu();
}

onbuttona() {
  var_0 = self.itemdefs[self.selectedindex];

  if(var_0.itemtype == "subMenu") {
    pushmenu(var_0);
  } else if(var_0.itemtype == "item") {
    var_0 thread runaction();
  }
}

ondpadleft() {
  var_0 = self.itemdefs[self.selectedindex];

  if(var_0.itemtype == "settingMenu") {
    var_1 = getDvar(var_0.setting.dvar);
    var_2 = var_0.setting.value;
    var_3 = 0;

    for(var_4 = 0; var_4 < var_2.size; var_4++) {
      var_5 = var_2[var_4];

      if(var_5 != var_1) {
        continue;
      }
      var_3 = var_4 - 1;

      if(var_3 >= 0) {
        var_0.setting.index = var_3;
        setDvar(var_0.setting.dvar, var_2[var_3]);
        var_0 updatedisplayvalue();
        level.player playSound("mouse_over");
      }

      break;
    }
  }
}

ondpadright() {
  var_0 = self.itemdefs[self.selectedindex];

  if(var_0.itemtype == "settingMenu") {
    var_1 = getDvar(var_0.setting.dvar);
    var_2 = var_0.setting.value;
    var_3 = 0;

    for(var_4 = 0; var_4 < var_2.size; var_4++) {
      var_5 = var_2[var_4];

      if(var_5 != var_1) {
        continue;
      }
      var_3 = var_4 + 1;

      if(var_3 <= var_0.setting.value.size - 1) {
        var_0.setting.index = var_3;
        setDvar(var_0.setting.dvar, var_2[var_3]);
        var_0 updatedisplayvalue();
        level.player playSound("mouse_over");
      }

      break;
    }
  }
}

initthumbsticklayout() {
  setDvar("controls_sticksConfig", "thumbstick_default");
}

initbuttonlayout() {
  setDvar("controls_buttonConfig", "buttons_default");
}

initsensitivity() {
  setDvar("controls_sensitivityConfig", "sensitivity_medium");
}

initinversion() {
  setDvar("controls_inversionConfig", "inversion_disabled");
}

initautoaim() {
  setDvar("controls_autoaimConfig", "autoaim_enabled");
}

initvibration() {
  setDvar("controls_vibrationConfig", "vibration_enabled");
}

updatedisplayvalue() {
  self.settingvalue settext(self.setting.display[self.setting.index]);
}

setupaction(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.name = var_0;

  if(isDefined(var_1)) {
    var_3.arg1 = var_1;
  }
  if(isDefined(var_2)) {
    var_3.arg2 = var_2;
  }
  return var_3;
}

runaction() {
  if(isDefined(self.action)) {
    if(isDefined(self.action.arg1)) {
      thread[[self.action.name]](self.action.arg1);
    } else {
      thread[[self.action.name]]();
    }
  }

  if(isDefined(self.event)) {
    level notify(self.event);
  }
}

testaction() {
  level.marine setgoalnode(getnode("node2", "targetname"));
  level.camera attachpath(getvehiclenode("path2", "targetname"));
  thread maps\_vehicle::gopath(level.camera);
}

menuresponse() {
  for(;;) {
    self waittill("menuresponse", var_0, var_1);

    switch (var_1) {
      case "DPAD_UP":
        level.curmenu ondpadup();
        break;
      case "DPAD_DOWN":
        level.curmenu ondpaddown();
        break;
      case "DPAD_LEFT":
        level.curmenu ondpadleft();
        break;
      case "DPAD_RIGHT":
        level.curmenu ondpadright();
        break;
      case "BUTTON_A":
        level.curmenu onbuttona();
        break;
      case "BUTTON_B":
        level.curmenu onbuttonb();
        break;
    }
  }
}