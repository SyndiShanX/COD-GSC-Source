/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\anim\grenade_return_throw.gsc
*************************************************/

#using_animtree("generic_human");

function main() {
  if(getdvarint("LPNQTQRRP", 0) == 1) {
    self endon("killanimscript");
    self endon("death");
    self waittill("killanimscript");
  }

  self orientmode("face enemy");
  self endon("killanimscript");
  scripts\anim\utility::initialize("grenade_return_throw");
  self animmode("zonly_physics");
  var0 = undefined;
  var1 = 1000;

  if(isDefined(self.enemy)) {
    var1 = distance(self.origin, self.enemy.origin);
  }

  var2 = [];

  if(var1 < 600 && islowthrowsafe()) {
    if(var1 < 300) {
      var2 = scripts\anim\utility::lookupanim("grenade", "return_throw_short");
    } else {
      var2 = scripts\anim\utility::lookupanim("grenade", "return_throw_long");
    }
  }

  if(var2.size == 0) {
    var2 = scripts\anim\utility::lookupanim("grenade", "return_throw_default");
  }

  var0 = var2[randomint(var2.size)];
  self setflaggedanimknoballrestart("throwanim", var0, %body, 1, 0.3);
  var4 = animhasnotetrack(var0, "grenade_left") || animhasnotetrack(var0, "grenade_right");

  if(var4) {
    scripts\anim\shared::placeweaponon(self.weapon, "left");
    thread putweaponbackinrighthand();
    thread notifygrenadepickup("throwanim", "grenade_left");
    thread notifygrenadepickup("throwanim", "grenade_right");
    self waittill("grenade_pickup");
    self pickupgrenade();
    scripts\anim\battlechatter_wrapper::evaluateattackevent("frag");
    self waittillmatch("throwanim", "grenade_throw");
  } else {
    self waittillmatch("throwanim", "grenade_throw");
    self pickupgrenade();
    scripts\anim\battlechatter_wrapper::evaluateattackevent("frag");
  }

  if(isDefined(self.grenade)) {
    self throwgrenade();
  }

  wait 1;

  if(var4) {
    self notify("put_weapon_back_in_right_hand");
    scripts\anim\shared::placeweaponon(self.weapon, "right");
    return;
  }
}

function islowthrowsafe() {
  var0 = (self.origin[0], self.origin[1], self.origin[2] + 20);
  var1 = var0 + anglesToForward(self.angles) * 50;
  return sighttracepassed(var0, var1, 0, undefined);
}

function putweaponbackinrighthand() {
  self endon("death");
  self endon("put_weapon_back_in_right_hand");
  self waittill("killanimscript");
  scripts\anim\shared::placeweaponon(self.weapon, "right");
}

function notifygrenadepickup(var0, var1) {
  self endon("killanimscript");
  self endon("grenade_pickup");
  self waittillmatch(var0, var1);
  self notify("grenade_pickup");
}