/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3575.gsc
*********************************************/

func_CA2B() {
  func_CA29(1);
}

func_CA2C() {
  self endon("death");
  self endon("disconnect");
  self endon("periphVis_end");
  self.personalradaractive = 1;
  self setclientomnvar("ui_ringradar_enabled", 1);
  scripts\mp\utility::printgameaction("ring radar on", self);
  self setscriptablepartstate("periphVis", "activeOn", 0);
  thread func_CA2D();
  scripts\mp\powers::func_4575(4.5, "periphVis_update");
  thread func_CA29();
}

func_CA29(var_0) {
  self endon("disconnect");
  self notify("periphVis_end");
  self notify("periphVis_update", 0);
  if(scripts\mp\utility::istrue(var_0)) {
    self setclientomnvar("ui_ringradar_enabled", 0);
    self setscriptablepartstate("periphVis", "neutral", 0);
  } else {
    self setclientomnvar("ui_ringradar_enabled", 2);
    wait(0.75);
    self setscriptablepartstate("periphVis", "activeOff", 0);
  }

  self.personalradaractive = undefined;
  scripts\mp\utility::printgameaction("ring radar off", self);
}

func_CA2A() {
  if(scripts\mp\utility::istrue(self.personalradaractive)) {
    thread func_CA29(1);
  }
}

func_CA2D() {
  self endon("disconnect");
  self endon("periphVis_end");
  scripts\engine\utility::waittill_any("death", "phase_shift_start");
  thread func_CA29(1);
}