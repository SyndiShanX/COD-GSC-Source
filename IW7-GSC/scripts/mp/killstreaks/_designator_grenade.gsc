/**********************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_designator_grenade.gsc
**********************************************************/

func_526C(var_0, var_1, var_2) {
  self endon("death");
  self.marker = undefined;
  if(self getcurrentweapon() == var_1) {
    thread func_5268(var_1);
    thread func_526D(var_0, var_1, var_2);
    func_526E(var_1);
    return !self getrunningforwardpainanim(var_1) && self hasweapon(var_1);
  }

  return 0;
}

func_5268(var_0) {
  self endon("death");
  self endon("disconnect");
  var_1 = "";
  while(var_1 != var_0) {
    self waittill("grenade_pullback", var_1);
  }

  scripts\engine\utility::allow_usability(0);
  func_5269();
}

func_5269() {
  self endon("death");
  self endon("disconnect");
  scripts\engine\utility::waittill_any_3("grenade_fire", "weapon_change");
  scripts\engine\utility::allow_usability(1);
}

func_526D(var_0, var_1, var_2) {
  self endon("designator_finished");
  self endon("spawned_player");
  self endon("disconnect");
  var_3 = undefined;
  var_4 = "";
  while(var_4 != var_1) {
    self waittill("grenade_fire", var_3, var_4);
  }

  if(isalive(self)) {
    var_3.triggerportableradarping = self;
    var_3.var_39C = var_1;
    self.marker = var_3;
    thread func_526A(var_0, var_3, var_2);
  } else {
    var_3 delete();
  }

  self notify("designator_finished");
}

func_526E(var_0) {
  self endon("spawned_player");
  self endon("disconnect");
  var_1 = self getcurrentweapon();
  while(var_1 == var_0) {
    self waittill("weapon_change", var_1);
  }

  if(self getrunningforwardpainanim(var_0) == 0) {
    func_526B(var_0);
  }

  self notify("designator_finished");
}

func_526B(var_0) {
  if(self hasweapon(var_0)) {
    scripts\mp\utility::_takeweapon(var_0);
  }
}

func_526A(var_0, var_1, var_2) {
  var_1 waittill("missile_stuck", var_3);
  if(isDefined(var_1.triggerportableradarping)) {
    self thread[[var_2]](var_0, var_1);
  }

  if(isDefined(var_1)) {
    var_1 delete();
  }
}