/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3598.gsc
************************/

func_218F() {}

func_2197() {
  self setscriptablepartstate("armorUp", "active", 0);
  self setscriptablepartstate("armorUpMaterial", "on");
  self.health = self.maxhealth;
  scripts\mp\heavyarmor::addheavyarmor(getheavyarmorvalue());
  thread func_2196();
  thread func_219C();
  thread func_2199();
  if(!scripts\mp\utility::isanymlgmatch()) {
    thread scripts\mp\supers::watchobjuse(75);
  }

  return 1;
}

func_218E(var_0) {
  self notify("armorUp_end");
  self notify("obj_drain_end");
  if(scripts\mp\utility::istrue(var_0)) {
    self setscriptablepartstate("armorUpMaterial", "offImmediate", 0);
  } else {
    self setscriptablepartstate("armorUpMaterial", "off", 0);
  }

  if(self.loadoutarchetype == "archetype_heavy") {
    self setscriptablepartstate("armorUp", "neutral", 0);
  }

  if(scripts\mp\heavyarmor::hasheavyarmor() && !scripts\mp\utility::istrue(self.heavyarmor.invulnerabilityframe)) {
    scripts\mp\heavyarmor::removeheavyarmor();
  }
}

func_219C() {
  self endon("disconnect");
  self endon("armorUp_end");
  level waittill("game_ended");
  scripts\mp\supers::func_DE3B(9999);
}

func_2199() {
  self endon("disconnect");
  self endon("armorUp_end");
  self waittill("heavyArmor_broken");
  scripts\mp\supers::func_DE3B(9999);
}

func_2196() {
  self endon("disconnect");
  self endon("armorUp_end");
  self.var_219F = [];
  for(;;) {
    self waittill("damage", var_0, var_1);
    if(isDefined(var_1)) {
      self.var_219F[self.var_219F.size] = var_1;
    }
  }
}

func_9FC0() {
  var_0 = scripts\mp\supers::getcurrentsuperref();
  if(!isDefined(var_0) || var_0 != "super_armorup") {
    return 0;
  }

  return scripts\mp\supers::issuperinuse();
}

getheavyarmorvalue() {
  var_0 = scripts\engine\utility::ter_op(scripts\mp\utility::isanymlgmatch(), 100, 114);
  return scripts\engine\utility::ter_op(scripts\mp\utility::istrue(level.hardcoremode), 76, var_0);
}