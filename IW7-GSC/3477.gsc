/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3477.gsc
***************************************/

func_526C(var_00, var_01, var_02) {
  self endon("death");
  self.marker = undefined;

  if(self getcurrentweapon() == var_01) {
    thread func_5268(var_01);
    thread func_526D(var_00, var_01, var_02);
    func_526E(var_01);
    return !(self getammocount(var_01) && self hasweapon(var_01));
  }

  return 0;
}

func_5268(var_00) {
  self endon("death");
  self endon("disconnect");
  var_01 = "";

  while(var_01 != var_00) {
    self waittill("grenade_pullback", var_01);
  }

  scripts\engine\utility::allow_usability(0);
  func_5269();
}

func_5269() {
  self endon("death");
  self endon("disconnect");
  scripts\engine\utility::waittill_any("grenade_fire", "weapon_change");
  scripts\engine\utility::allow_usability(1);
}

func_526D(var_00, var_01, var_02) {
  self endon("designator_finished");
  self endon("spawned_player");
  self endon("disconnect");
  var_03 = undefined;
  var_04 = "";

  while(var_04 != var_01) {
    self waittill("grenade_fire", var_03, var_04);
  }

  if(isalive(self)) {
    var_3.owner = self;
    var_3.weaponname = var_01;
    self.marker = var_03;
    thread func_526A(var_00, var_03, var_02);
  } else
    var_03 delete();

  self notify("designator_finished");
}

func_526E(var_00) {
  self endon("spawned_player");
  self endon("disconnect");
  var_01 = self getcurrentweapon();

  while(var_01 == var_00) {
    self waittill("weapon_change", var_01);
  }

  if(self getammocount(var_00) == 0) {
    func_526B(var_00);
  }

  self notify("designator_finished");
}

func_526B(var_00) {
  if(self hasweapon(var_00)) {
    scripts\mp\utility\game::_takeweapon(var_00);
  }
}

func_526A(var_00, var_01, var_02) {
  var_01 waittill("missile_stuck", var_03);

  if(isDefined(var_1.owner)) {
    self thread[[var_02]](var_00, var_01);
  }

  if(isDefined(var_01)) {
    var_01 delete();
  }
}