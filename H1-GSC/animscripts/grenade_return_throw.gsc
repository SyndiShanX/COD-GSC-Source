/************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\grenade_return_throw.gsc
************************************************/

#using_animtree("generic_human");

main() {
  self orientmode("face default");
  self endon("killanimscript");
  animscripts\utility::initialize("grenade_return_throw");
  self animmode("zonly_physics");
  var_0 = undefined;

  if(level.h1_improved_grenade_returns)
    var_0 = getgrenadereturnanim_h1();
  else
    var_0 = getgrenadereturnanim();

  self setflaggedanimknoballrestart("throwanim", var_0, % body, 1, 0.3);
  var_1 = animhasnotetrack(var_0, "grenade_left") || animhasnotetrack(var_0, "grenade_right");

  if(var_1) {
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

  if(isdefined(self.grenade))
    self throwgrenade();

  self waittillmatch("throwanim", "finish");

  if(var_1) {
    self notify("put_weapon_back_in_right_hand");
    animscripts\shared::placeweaponon(self.weapon, "right");
  }
}

getgrenadereturnanim() {
  var_1 = 1000;

  if(isdefined(self.enemy))
    var_1 = distance(self.origin, self.enemy.origin);

  var_2 = [];

  if(var_1 < 600 && islowthrowsafe()) {
    if(var_1 < 300) {
      if(animscripts\utility::usingsmg())
        var_2 = animscripts\utility::lookupanim("grenade", "return_throw_short_smg");
      else
        var_2 = animscripts\utility::lookupanim("grenade", "return_throw_short");
    } else if(animscripts\utility::usingsmg())
      var_2 = animscripts\utility::lookupanim("grenade", "return_throw_long_smg");
    else
      var_2 = animscripts\utility::lookupanim("grenade", "return_throw_long");
  }

  if(var_2.size == 0) {
    if(animscripts\utility::usingsmg())
      var_2 = animscripts\utility::lookupanim("grenade", "return_throw_default_smg");
    else
      var_2 = animscripts\utility::lookupanim("grenade", "return_throw_default");
  }

  return var_2[randomint(var_2.size)];
}

getgrenadereturnanim_h1() {
  var_0 = [];
  var_1 = self.grenadedanger;

  if(self._id_01D4)
    var_1 = self._id_01D3 - self.grenade.origin;

  var_2 = length2d(var_1);

  if(var_2 > 0)
    var_1 = (var_1[0] / var_2, var_1[1] / var_2, 0);

  var_3 = length2dsquared(self.velocity);
  var_4 = anglestoforward(self.angles);

  if(var_3 > 1) {
    if(var_2 < 300 && islowthrowsafe())
      var_0 = animscripts\utility::lookupanim("grenade", "return_running_throw_short");

    if(var_0.size == 0)
      var_0 = animscripts\utility::lookupanim("grenade", "return_running_throw_long");
  }

  if(self.a.pose == "crouch") {
    if(self.prevscript == "cover_left") {
      if(animscripts\corner::hasonekneeup())
        var_0 = animscripts\utility::lookupanim("grenade", "return_cornercrl_1knee_throw");
      else
        var_0 = animscripts\utility::lookupanim("grenade", "return_cornercrl_2knee_throw");
    } else if(self.prevscript == "cover_right") {
      if(animscripts\corner::hasonekneeup())
        var_0 = animscripts\utility::lookupanim("grenade", "return_cornercrr_1knee_throw");
      else
        var_0 = animscripts\utility::lookupanim("grenade", "return_cornercrr_2knee_throw");
    } else if(self.prevscript == "cover_crouch")
      var_0 = animscripts\utility::lookupanim("grenade", "return_covercrouch_throw");

    if(var_0.size == 0)
      var_0 = animscripts\utility::lookupanim("grenade", "return_crouching_throw");
  }

  if(var_0.size == 0)
    var_0 = animscripts\utility::lookupanim("grenade", "return_standing_throw");

  var_5 = vectordot(var_1, var_4);
  var_6 = var_1[0] * var_4[1] - var_4[0] * var_1[1];
  var_7 = atan2(var_6, var_5);
  var_8 = int(exp((var_7 + 180) / 90));
  var_8 = var_8 % var_0.size;
  return var_0[var_8];
}

islowthrowsafe() {
  var_0 = (self.origin[0], self.origin[1], self.origin[2] + 20);
  var_1 = var_0 + anglestoforward(self.angles) * 50;
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