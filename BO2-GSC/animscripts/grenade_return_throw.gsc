/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\grenade_return_throw.gsc
************************************************/

#include animscripts\anims;
#include animscripts\grenade_cower;
#include animscripts\stop;
#include animscripts\utility;
#include animscripts\shared;
#include maps\_dds;
#using_animtree("generic_human");

main() {
  if(getdvar(#"_id_D94F9C11") == "on" && isDefined(self.grenade)) {
    self orientmode("face angle", randomfloat(360));
    self animmode("gravity");
    wait 0.2;
    animscripts\grenade_cower::main();
    return;
  }

  if(self.a.pose == "prone") {
    animscripts\stop::main();
    return;
  }

  self orientmode("face default");
  self trackscriptstate("Cover Return Throw Main", "code");
  self endon("killanimscript");
  animscripts\utility::initialize("grenade_return_throw");
  self animmode("zonly_physics");
  throwanim = undefined;
  throwdistsq = 1000000;

  if(isDefined(self.enemy))
    throwdistsq = distancesquared(self.origin, self.enemy.origin);

  animarray = [];

  if(throwdistsq < 90000) {
    animarray[0] = animarray("throw_short");
    animarray[1] = animarray("throw_medium");
  } else if(throwdistsq < 1000000) {
    animarray[0] = animarray("throw_medium");
    animarray[1] = animarray("throw_far");
    animarray[2] = animarray("throw_very_far");
  } else
    animarray[0] = animarray("throw_very_far");

  assert(animarray.size);
  throwanim = animarray[randomint(animarray.size)];

  if(getdvar(#"_id_1C9BEA27") != "") {
    val = getdvar(#"_id_1C9BEA27");

    if(val == "throw1")
      throwanim = % grenade_return_running_throw_forward;
    else if(val == "throw2")
      throwanim = % grenade_return_standing_throw_forward_1;
    else if(val == "throw3")
      throwanim = % grenade_return_standing_throw_forward_2;
    else if(val == "throw4")
      throwanim = % grenade_return_standing_throw_overhand_forward;
  }

  assert(isDefined(throwanim));
  self setflaggedanimknoballrestart("throwanim", throwanim, % body, 1, 0.3);
  self thread handlepickupandthrow("throwanim", throwanim);
  self animscripts\shared::donotetracks("throwanim");
}

handlepickupandthrow(animflag, throwanim) {
  self endon("killanimscript");
  haspickup = animhasnotetrack(throwanim, "grenade_left") || animhasnotetrack(throwanim, "grenade_right");

  if(haspickup) {
    self animscripts\shared::placeweaponon(self.weapon, "right");
    self thread putweaponbackinrighthand();
    self thread notifygrenadepickup(animflag, "grenade_left");
    self thread notifygrenadepickup(animflag, "grenade_right");
    self waittill("grenade_pickup");
    self pickupgrenade();
    self maps\_dds::dds_notify_grenade(self.grenadeweapon, self.team == "allies", 1);
    self waittillmatch(animflag, "grenade_throw");
    self throwgrenade();
  }
}

putweaponbackinrighthand() {
  self endon("death");
  self endon("put_weapon_back_in_right_hand");
  self waittill("killanimscript");
  self animscripts\shared::placeweaponon(self.weapon, "right");
}

notifygrenadepickup(animflag, notetrack) {
  self endon("killanimscript");
  self endon("grenade_pickup");
  self waittillmatch(animflag, notetrack);
  self notify("grenade_pickup");
}