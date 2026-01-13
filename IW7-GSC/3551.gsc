/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3551.gsc
*********************************************/

set() {}

unset(var_0) {
  if(func_9FC1()) {
    end(var_0);
  }
}

func_12F9B() {
  if(func_9FC1()) {
    return 0;
  }

  self.var_9D8B = 1;
  self.var_5583 = 1;
  scripts\mp\utility::giveperk("specialty_noscopeoutline");
  scripts\mp\utility::giveperk("specialty_spygame");
  scripts\mp\utility::giveperk("specialty_blindeye");
  scripts\mp\utility::giveperk("specialty_no_target");
  self.var_423A = 1;
  self setscriptablepartstate("cloak", "on", 0);
  self setscriptablepartstate("jet_pack", "off", 0);
  self setscriptablepartstate("teamColorPins", "off", 0);
  if(!scripts\mp\utility::isanymlgmatch()) {
    thread scripts\mp\supers::watchobjuse(75, 1);
  }

  thread func_13A14();
  return 1;
}

func_13A14() {
  self endon("death");
  self endon("disconnect");
  self endon("cloak_end");
  scripts\engine\utility::waittill_any_3("grenade_throw", "weapon_fired", "melee_fired");
  scripts\mp\supers::func_DE3B(9999);
}

end(var_0, var_1) {
  if(!isDefined(self)) {
    return;
  }

  self notify("cloak_end");
  self notify("obj_drain_end");
  var_0 = scripts\engine\utility::istrue(var_0);
  var_1 = scripts\engine\utility::istrue(var_1);
  if(var_0) {
    self setscriptablepartstate("cloak", "offImmediate", 0);
    self.var_9D8B = undefined;
    self.var_5583 = 0;
    self.var_423A = undefined;
    return;
  }

  if(var_1) {
    thread endimmediate();
    return;
  }

  thread enddelayed();
}

enddelayed() {
  self endon("disconnect");
  self endon("cloak_end");
  enddelayedinternal();
  if(scripts\mp\utility::istrue(self.var_423A)) {
    scripts\mp\utility::removeperk("specialty_noscopeoutline");
    scripts\mp\utility::removeperk("specialty_spygame");
    scripts\mp\utility::removeperk("specialty_blindeye");
    scripts\mp\utility::removeperk("specialty_no_target");
  }

  if(!scripts\mp\utility::istrue(level.broshotrunning)) {
    self setscriptablepartstate("jet_pack", "neutral", 0);
    self setscriptablepartstate("teamColorPins", "teamColorPins", 0);
  }

  self.var_9D8B = undefined;
  self.var_5583 = 0;
  self.var_423A = undefined;
}

enddelayedinternal() {
  self endon("death");
  wait(0.05000001);
  if(!scripts\mp\utility::istrue(level.broshotrunning)) {
    self setscriptablepartstate("cloak", "off", 0);
  }

  wait(0.45);
}

endimmediate() {
  if(scripts\mp\utility::istrue(self.var_423A)) {
    scripts\mp\utility::removeperk("specialty_noscopeoutline");
    scripts\mp\utility::removeperk("specialty_spygame");
    scripts\mp\utility::removeperk("specialty_blindeye");
    scripts\mp\utility::removeperk("specialty_no_target");
  }

  if(!scripts\mp\utility::istrue(level.broshotrunning)) {
    self setscriptablepartstate("jet_pack", "neutral", 0);
    self setscriptablepartstate("teamColorPins", "teamColorPins", 0);
  }

  self.var_9D8B = undefined;
  self.var_5583 = 0;
  self.var_423A = undefined;
}

func_E26A() {
  self setscriptablepartstate("cloak", "offImmediate", 0);
}

func_9FC1() {
  return scripts\mp\utility::istrue(self.var_9D8B);
}