/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\grenade_return_throw.gsc
************************************************/

#using_animtree("generic_human");

main() {
  self orientmode("face default");
  self endon("killanimscript");
  animscripts\utility::_id_0D15("grenade_return_throw");
  self animmode("zonly_physics");
  var_0 = undefined;
  var_1 = 1000;

  if(isDefined(self.enemy)) {
    var_1 = distance(self.origin, self.enemy.origin);

  }
  var_2 = [];

  if(var_1 < 600 && _id_3FE1()) {
    if(var_1 < 300) {
      var_2[0] = % grenade_return_running_throw_forward;
      var_2[1] = % grenade_return_standing_throw_forward_1;
    } else {
      var_2[0] = % grenade_return_running_throw_forward;
      var_2[1] = % grenade_return_standing_throw_overhand_forward;
    }
  }

  if(var_2.size == 0) {
    var_2[0] = % grenade_return_standing_throw_overhand_forward;

  }
  var_0 = var_2[randomint(var_2.size)];
  self setflaggedanimknoballrestart("throwanim", var_0, % body, 1, 0.3);
  var_4 = animhasnotetrack(var_0, "grenade_left") || animhasnotetrack(var_0, "grenade_right");

  if(var_4) {
    animscripts\shared::_id_0C9B(self.weapon, "left");
    thread _id_3FE2();
    thread _id_3FE3("throwanim", "grenade_left");
    thread _id_3FE3("throwanim", "grenade_right");
    self waittill("grenade_pickup");
    self pickupgrenade();
    animscripts\battlechatter_ai::_id_0B3A("grenade");
    self waittillmatch("throwanim", "grenade_throw");
  } else {
    self waittillmatch("throwanim", "grenade_throw");
    self pickupgrenade();
    animscripts\battlechatter_ai::_id_0B3A("grenade");
  }

  if(isDefined(self.grenade)) {
    self throwgrenade();

  }
  wait 1;

  if(var_4) {
    self notify("put_weapon_back_in_right_hand");
    animscripts\shared::_id_0C9B(self.weapon, "right");
  }
}

_id_3FE1() {
  var_0 = (self.origin[0], self.origin[1], self.origin[2] + 20);
  var_1 = var_0 + anglesToForward(self.angles) * 50;
  return sighttracepassed(var_0, var_1, 0, undefined);
}

_id_3FE2() {
  self endon("death");
  self endon("put_weapon_back_in_right_hand");
  self waittill("killanimscript");
  animscripts\shared::_id_0C9B(self.weapon, "right");
}

_id_3FE3(var_0, var_1) {
  self endon("killanimscript");
  self endon("grenade_pickup");
  self waittillmatch(var_0, var_1);
  self notify("grenade_pickup");
}