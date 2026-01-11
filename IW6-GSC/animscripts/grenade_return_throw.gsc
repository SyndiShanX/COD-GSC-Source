/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\grenade_return_throw.gsc
************************************************/

#using_animtree("generic_human");

main() {
  self orientmode("face default");
  self endon("killanimscript");
  animscripts\utility::initialize("grenade_return_throw");
  self animmode("zonly_physics");
  var_0 = undefined;
  var_1 = 1000;

  if(isDefined(self.enemy)) {
    var_1 = distance(self.origin, self.enemy.origin);
  }

  var_2 = [];

  if(var_1 < 600 && islowthrowsafe()) {
    if(var_1 < 300) {
      var_2 = animscripts\utility::lookupanim("grenade", "return_throw_short");
    }
    else {
      var_2 = animscripts\utility::lookupanim("grenade", "return_throw_long");
    }
  }

  if(var_2.size == 0) {
    var_2 = animscripts\utility::lookupanim("grenade", "return_throw_default");
  }

  var_0 = var_2[randomint(var_2.size)];
  self setflaggedanimknoballrestart("throwanim", var_0, % body, 1, 0.3);
  var_4 = animhasnotetrack(var_0, "grenade_left") || animhasnotetrack(var_0, "grenade_right");

  if(var_4) {
    animscripts\shared::placeweaponon(self.weapon, "left");
    thread putweaponbackinrighthand();
    thread notifygrenadepickup("throwanim", "grenade_left");
    thread notifygrenadepickup("throwanim", "grenade_right");
    self waittill("grenade_pickup");
    self pickupgrenade();
    animscripts\battlechatter_ai::evaluateattackevent("grenade");
    self waittillmatch("throwanim", "grenade_throw");
  } else {
    self waittillmatch("throwanim", "grenade_throw");
    self pickupgrenade();
    animscripts\battlechatter_ai::evaluateattackevent("grenade");
  }

  if(isDefined(self.grenade)) {
    self throwgrenade();
  }

  wait 1;

  if(var_4) {
    self notify("put_weapon_back_in_right_hand");
    animscripts\shared::placeweaponon(self.weapon, "right");
  }
}

islowthrowsafe() {
  var_0 = (self.origin[0], self.origin[1], self.origin[2] + 20);
  var_1 = var_0 + anglesToForward(self.angles) * 50;
  return sighttracepassed(var_0, var_1, 0, undefined);
}

putweaponbackinrighthand() {
  self endon("death");
  self endon("put_weapon_back_in_right_hand");
  self waittill("killanimscript");
  animscripts\shared::placeweaponon(self.weapon, "right");
}

notifygrenadepickup(var_0, var_1) {
  self endon("killanimscript");
  self endon("grenade_pickup");
  self waittillmatch(var_0, var_1);
  self notify("grenade_pickup");
}