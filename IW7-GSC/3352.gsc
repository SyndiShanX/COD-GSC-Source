/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3352.gsc
*********************************************/

setrewind() {
  thread func_13A62();
}

unsetrewind() {
  self notify("rewindUnset");
  self setscriptablepartstate("rewind", "neutral", 0);
  thread func_E163();
}

func_10DEB() {
  self endon("disconnect");
  self setscriptablepartstate("rewind", "activeStart", 0);
  self.ability_invulnerable = 1;
  scripts\engine\utility::allow_usability(0);
  self limitedmovement(0);
  self notify("cancel_sentry");
  self notify("cancel_medusa");
  self notify("cancel_trap");
  self notify("cancel_boombox");
  self notify("cancel_revocator");
  self notify("cancel_ims");
  self notify("cancel_gascan");
  scripts\engine\utility::waitframe();
  foreach(var_1 in level.players) {
    if(var_1 == self) {
      continue;
    }

    self hidefromplayer(var_1);
  }

  self.isrewinding = 1;
  scripts\cp\utility::adddamagemodifier("rewind", 0, 0);
  self motionblurhqenable();
  restrictfunctionality();
}

delayed_unset_damage_modifier() {
  self endon("disconnect");
  wait(2);
  self.ability_invulnerable = undefined;
  scripts\cp\utility::removedamagemodifier("rewind", 0);
}

func_637E() {
  self setscriptablepartstate("rewind", "activeEnd", 0);
  scripts\engine\utility::waitframe();
  if(!self isonground()) {
    self.flung = 1;
    self limitedmovement(1);
    thread func_12CE7();
  }

  thread delayed_unset_damage_modifier();
  func_E4D5();
  func_E4C7();
  func_E163();
}

func_12CE7() {
  self endon("disconnect");
  while(!self isonground() && isalive(self)) {
    wait(0.05);
  }

  self.flung = undefined;
  self limitedmovement(0);
}

func_E163() {
  self.isrewinding = undefined;
  self.ability_invulnerable = undefined;
  scripts\cp\utility::removedamagemodifier("rewind", 0);
  if(!scripts\engine\utility::isusabilityallowed()) {
    scripts\engine\utility::allow_usability(1);
  }

  self playanimscriptevent("power_exit", "rewind");
  foreach(var_1 in level.players) {
    if(var_1 == self) {
      continue;
    }

    self showtoplayer(var_1);
  }

  self motionblurhqdisable();
  restorefunctionality();
}

func_13A62() {
  self endon("disconnect");
  self endon("rewindUnset");
  self notify("watchForRewind");
  self endon("watchForRewind");
  for(;;) {
    var_0 = spawnStruct();
    childthread func_13A66(var_0);
    childthread func_13A64(var_0);
    childthread func_13A63(var_0);
    childthread func_13A65(var_0);
    self waittill("rewindBeginRace");
    waittillframeend;
    if(isDefined(var_0.var_6ACF)) {
      scripts\cp\powers\coop_powers::power_adjustcharges(1, "secondary");
    } else if(isDefined(var_0.var_10DE6) && isDefined(var_0.var_4E59)) {
      scripts\cp\powers\coop_powers::power_adjustcharges(1, "secondary");
    } else if(isDefined(var_0.var_637B)) {
      func_637E();
    } else if(isDefined(var_0.var_10DE6)) {
      func_10DEB();
    }

    self notify("rewindEndRace");
  }
}

func_13A66(var_0) {
  self endon("rewindEndRace");
  self waittill("rewindStart");
  var_0.var_10DE6 = 1;
  self notify("rewindBeginRace");
}

func_13A64(var_0) {
  self endon("rewindEndRace");
  self waittill("rewindEnd");
  var_0.var_637B = 1;
  self notify("rewindBeginRace");
  self notify("powers_rewind_used", 1);
}

func_13A63(var_0) {
  self endon("rewindEndRace");
  self waittill("death");
  var_0.var_4E59 = 1;
  self notify("rewindBeginRace");
}

func_13A65(var_0) {
  self endon("rewindEndRace");
  self waittill("rewindFailed");
  var_0.var_6ACF = 1;
  self notify("rewindBeginRace");
  self notify("powers_rewind_used", 0);
}

func_E4D5() {
  var_0 = self.maxhealth - self.health;
  self.health = self.maxhealth;
}

func_E4C7() {
  var_0 = self getweaponslistprimaries();
  foreach(var_2 in var_0) {
    if(scripts\cp\utility::is_melee_weapon(var_2)) {
      continue;
    }

    var_3 = weaponstartammo(var_2);
    var_4 = self getweaponammoclip(var_2) + self getweaponammostock(var_2);
    var_5 = scripts\engine\utility::ter_op(var_3 > var_4, var_3, var_4);
    var_6 = int(min(weaponclipsize(var_2), var_5));
    var_7 = var_5 - var_6;
    self setweaponammoclip(var_2, var_6);
    self setweaponammostock(var_2, var_7);
  }
}

restrictfunctionality() {
  if(scripts\engine\utility::istrue(self.rewindrestrictedfunctionality)) {
    return;
  }

  self.rewindrestrictedfunctionality = 1;
  scripts\engine\utility::allow_weapon_switch(0);
  scripts\engine\utility::allow_usability(0);
  scripts\cp\utility::allow_player_teleport(0);
  thread restrictfunctionalitycleanup();
}

restorefunctionality() {
  if(!scripts\engine\utility::istrue(self.rewindrestrictedfunctionality)) {
    return;
  }

  self.rewindrestrictedfunctionality = undefined;
  if(!scripts\engine\utility::isweaponswitchallowed()) {
    scripts\engine\utility::allow_weapon_switch(1);
  }

  if(!scripts\engine\utility::isusabilityallowed()) {
    scripts\engine\utility::allow_usability(1);
  }

  if(!scripts\cp\utility::isteleportenabled()) {
    scripts\cp\utility::allow_player_teleport(1);
  }
}

restrictfunctionalitycleanup() {
  self endon("disconnect");
  self endon("rewindUnset");
  self notify("rewindRestrictFunctionalityCleanup");
  self endon("rewindRestrictFunctionalityCleanup");
  self waittill("death");
  self.rewindrestrictedfunctionality = undefined;
}