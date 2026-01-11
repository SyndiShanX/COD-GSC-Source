/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\grenade_return_throw.gsc
*****************************************************/

#using_animtree("generic_human");

main() {
  if(getdvar("scr_forcegrenadecower") == "on" && isDefined(self.grenade)) {
    self OrientMode("face angle", randomfloat(360));
    self animmode("gravity");
    wait .2;
    animscripts\grenade_cower::main();
    return;
  }
  self orientMode("face default");
  self trackScriptState("Cover Return Throw Main", "code");
  self endon("killanimscript");
  animscripts\utility::initialize("grenade_return_throw");
  self animMode("zonly_physics");
  throwAnim = undefined;
  throwDist = 700;
  if(isDefined(self.enemy)) {
    throwDist = distance(self.origin, self.enemy.origin);
  }
  animArray = [];
  if(throwDist < 300) {
    animArray[0] = % grenade_return_running_throw_forward;
    animArray[1] = % grenade_return_standing_throw_forward_1;
  } else if(throwDist < 1024) {
    animArray[0] = % grenade_return_standing_throw_forward_1;
    animArray[1] = % grenade_return_standing_throw_forward_2;
    animArray[2] = % grenade_return_standing_throw_overhand_forward;
  } else {
    animArray[0] = % grenade_return_standing_throw_overhand_forward;
  }
  assert(animArray.size);
  throwAnim = animArray[randomint(animArray.size)];
  if(getdvar("scr_grenadereturnanim") != "") {
    val = getdvar("scr_grenadereturnanim");
    if(val == "kick1") {
      throwAnim = % grenade_return_running_kick_forward_1;
    } else if(val == "kick2") {
      throwAnim = % grenade_return_running_kick_forward_2;
    } else if(val == "throw1") {
      throwAnim = % grenade_return_running_throw_forward;
    } else if(val == "throw2") {
      throwAnim = % grenade_return_standing_throw_forward_1;
    } else if(val == "throw3") {
      throwAnim = % grenade_return_standing_throw_forward_2;
    } else if(val == "throw4") {
      throwAnim = % grenade_return_standing_throw_overhand_forward;
    }
  }
  assert(isDefined(throwAnim));
  self setFlaggedAnimKnoballRestart("throwanim", throwAnim, % body, 1, .3);
  hasPickup = (animHasNotetrack(throwAnim, "grenade_left") || animHasNotetrack(throwAnim, "grenade_right"));
  if(hasPickup) {
    self animscripts\shared::placeWeaponOn(self.weapon, "left");
    self thread putWeaponBackInRightHand();
    self thread notifyGrenadePickup("throwanim", "grenade_left");
    self thread notifyGrenadePickup("throwanim", "grenade_right");
    self waittill("grenade_pickup");
    self pickUpGrenade();
    self animscripts\battleChatter_ai::evaluateAttackEvent("grenade");
    self waittillmatch("throwanim", "grenade_throw");
    self throwGrenade();
  } else {
    self waittillmatch("throwanim", "grenade_throw");
    self pickUpGrenade();
    self animscripts\battleChatter_ai::evaluateAttackEvent("grenade");
    self throwGrenade();
  }
  wait 1;
  if(hasPickup) {
    self notify("put_weapon_back_in_right_hand");
    self animscripts\shared::placeWeaponOn(self.weapon, "right");
  }
}

putWeaponBackInRightHand() {
  self endon("death");
  self endon("put_weapon_back_in_right_hand");
  self waittill("killanimscript");
  self animscripts\shared::placeWeaponOn(self.weapon, "right");
}

notifyGrenadePickup(animFlag, notetrack) {
  self endon("killanimscript");
  self endon("grenade_pickup");
  self waittillmatch(animFlag, notetrack);
  self notify("grenade_pickup");
}