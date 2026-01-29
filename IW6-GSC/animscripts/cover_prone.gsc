/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\cover_prone.gsc
***************************************/

#using_animtree("generic_human");

init_animset_cover_prone() {
  var_0 = [];
  var_0["straight_level"] = % prone_aim_5;
  var_0["legs_up"] = % prone_aim_feet_45up;
  var_0["legs_down"] = % prone_aim_feet_45down;
  var_0["fire"] = % prone_fire_1;
  var_0["semi2"] = % prone_fire_burst;
  var_0["semi3"] = % prone_fire_burst;
  var_0["semi4"] = % prone_fire_burst;
  var_0["semi5"] = % prone_fire_burst;
  var_0["single"] = [%prone_fire_1];
  var_0["burst2"] = % prone_fire_burst;
  var_0["burst3"] = % prone_fire_burst;
  var_0["burst4"] = % prone_fire_burst;
  var_0["burst5"] = % prone_fire_burst;
  var_0["burst6"] = % prone_fire_burst;
  var_0["reload"] = % prone_reload;
  var_0["look"] = [%prone_twitch_look, %prone_twitch_lookfast, %prone_twitch_lookup];
  var_0["grenade_safe"] = [%prone_grenade_a, %prone_grenade_a];
  var_0["grenade_exposed"] = [%prone_grenade_a, %prone_grenade_a];
  var_0["exposed_idle"] = [%prone_idle];
  var_0["twitch"] = [%prone_twitch_ammocheck, %prone_twitch_look, %prone_twitch_scan, %prone_twitch_lookfast, %prone_twitch_lookup];
  var_0["hide_to_look"] = % coverstand_look_moveup;
  var_0["look_idle"] = % coverstand_look_idle;
  var_0["look_to_hide"] = % coverstand_look_movedown;
  var_0["look_to_hide_fast"] = % coverstand_look_movedown_fast;
  var_0["stand_2_prone"] = % stand_2_prone_nodelta;
  var_0["crouch_2_prone"] = % crouch_2_prone;
  var_0["prone_2_stand"] = % prone_2_stand_nodelta;
  var_0["prone_2_crouch"] = % prone_2_crouch;
  var_0["stand_2_prone_firing"] = % stand_2_prone_firing;
  var_0["crouch_2_prone_firing"] = % crouch_2_prone_firing;
  var_0["prone_2_stand_firing"] = % prone_2_stand_firing;
  var_0["prone_2_crouch_firing"] = % prone_2_crouch_firing;
  anim.archetypes["soldier"]["cover_prone"] = var_0;
}

main() {
  self endon("killanimscript");
  animscripts\utility::initialize("cover_prone");

  if(weaponclass(self.weapon) == "rocketlauncher") {
    animscripts\combat::main();
    return;
  }

  if(isDefined(self.a.arrivaltype) && self.a.arrivaltype == "prone_saw")
    animscripts\cover_wall::useselfplacedturret("saw_bipod_prone", "weapon_saw_MG_Setup");
  else if(isDefined(self.node.turret))
    animscripts\cover_wall::usestationaryturret();

  if(isDefined(self.enemy) && lengthsquared(self.origin - self.enemy.origin) < squared(512)) {
    thread animscripts\combat::main();
    return;
  }

  setup_cover_prone();
  self.covernode = self.node;
  self orientmode("face angle", self.covernode.angles[1]);
  self.a.goingtoproneaim = 1;
  self setproneanimnodes(-45, 45, %prone_legs_down, %exposed_modern, %prone_legs_up);

  if(self.a.pose != "prone")
    prone_transitionto("prone");
  else
    animscripts\utility::enterpronewrapper(0);

  thread animscripts\combat_utility::aimidlethread();
  setupproneaim(0.2);
  self setanim(%prone_aim_5, 1, 0.1);
  self orientmode("face angle", self.covernode.angles[1]);
  self animmode("zonly_physics");
  pronecombatmainloop();
  self notify("stop_deciding_how_to_shoot");
}

end_script() {
  self.a.goingtoproneaim = undefined;
}

idlethread() {
  self endon("killanimscript");
  self endon("kill_idle_thread");

  for(;;) {
    var_0 = animscripts\utility::animarraypickrandom("prone_idle");
    self setflaggedanimlimited("idle", var_0);
    self waittillmatch("idle", "end");
    self clearanim(var_0, 0.2);
  }
}

updatepronewrapper(var_0) {
  self updateprone(animscripts\utility::lookupanim("cover_prone", "legs_up"), animscripts\utility::lookupanim("cover_prone", "legs_down"), 1, var_0, 1);
  self setanim(%exposed_aiming, 1, 0.2);
}

pronecombatmainloop() {
  self endon("killanimscript");
  thread animscripts\track::trackshootentorpos();
  thread animscripts\shoot_behavior::decidewhatandhowtoshoot("normal");
  var_0 = gettime() > 2500;

  for(;;) {
    animscripts\utility::updateisincombattimer();
    updatepronewrapper(0.05);

    if(!var_0) {
      wait(0.05 + randomfloat(1.5));
      var_0 = 1;
      continue;
    }

    if(!isDefined(self.shootpos)) {
      if(considerthrowgrenade()) {
        continue;
      }
      wait 0.05;
      continue;
    }

    var_1 = lengthsquared(self.origin - self.shootpos);

    if(self.a.pose != "crouch" && self isstanceallowed("crouch") && var_1 < squared(400)) {
      if(var_1 < squared(285)) {
        prone_transitionto("crouch");
        thread animscripts\combat::main();
        return;
      }
    }

    if(considerthrowgrenade()) {
      continue;
    }
    if(pronereload(0)) {
      continue;
    }
    if(animscripts\combat_utility::aimedatshootentorpos()) {
      animscripts\combat_utility::shootuntilshootbehaviorchange();
      self clearanim(%add_fire, 0.2);
      continue;
    }

    wait 0.05;
  }
}

pronereload(var_0) {
  return animscripts\combat_utility::reload(var_0, animscripts\utility::animarray("reload"));
}

setup_cover_prone() {
  self setdefaultaimlimits(self.node);
  self.a.array = animscripts\utility::lookupanimarray("cover_prone");
}

trythrowinggrenade(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(var_1) && var_1)
    var_2 = animscripts\utility::animarraypickrandom("grenade_safe");
  else
    var_2 = animscripts\utility::animarraypickrandom("grenade_exposed");

  self animmode("zonly_physics");
  self.keepclaimednodeifvalid = 1;
  var_3 = (32, 20, 64);
  var_4 = animscripts\combat_utility::trygrenade(var_0, var_2);
  self.keepclaimednodeifvalid = 0;
  return var_4;
}

considerthrowgrenade() {
  if(isDefined(anim.throwgrenadeatplayerasap) && isalive(level.player)) {
    if(trythrowinggrenade(level.player, 200))
      return 1;
  }

  if(isDefined(self.enemy))
    return trythrowinggrenade(self.enemy, 850);

  return 0;
}

shouldfirewhilechangingpose() {
  if(!isDefined(self.weapon) || !weaponisauto(self.weapon))
    return 0;

  if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < 256)
    return 0;

  if(isDefined(self.enemy) && self cansee(self.enemy) && !isDefined(self.grenade) && animscripts\shared::getaimyawtoshootentorpos() < 20)
    return animscripts\move::mayshootwhilemoving();

  return 0;
}

prone_transitionto(var_0) {
  if(var_0 == self.a.pose) {
    return;
  }
  self clearanim(%root, 0.3);
  animscripts\combat_utility::endfireandanimidlethread();

  if(shouldfirewhilechangingpose())
    var_1 = animscripts\utility::animarray(self.a.pose + "_2_" + var_0 + "_firing");
  else
    var_1 = animscripts\utility::animarray(self.a.pose + "_2_" + var_0);

  if(var_0 == "prone") {}

  self setflaggedanimknoballrestart("trans", var_1, %body, 1, 0.2, 1.0);
  animscripts\shared::donotetracks("trans");
  self setanimknoballrestart(animscripts\utility::animarray("straight_level"), %body, 1, 0.25);
  setupproneaim(0.25);
}

finishnotetracks(var_0) {
  self endon("killanimscript");
  animscripts\shared::donotetracks(var_0);
}

setupproneaim(var_0) {
  self setanimknoball(%prone_aim_5, %body, 1, var_0);
  self setanimlimited(%prone_aim_2_add, 1, var_0);
  self setanimlimited(%prone_aim_4_add, 1, var_0);
  self setanimlimited(%prone_aim_6_add, 1, var_0);
  self setanimlimited(%prone_aim_8_add, 1, var_0);
}

proneto(var_0, var_1) {
  self clearanim(%root, 0.3);
  var_2 = undefined;

  if(shouldfirewhilechangingpose()) {
    if(var_0 == "crouch")
      var_2 = % prone_2_crouch_firing;
    else if(var_0 == "stand")
      var_2 = % prone_2_stand_firing;
  } else if(var_0 == "crouch")
    var_2 = % prone_2_crouch;
  else if(var_0 == "stand")
    var_2 = % prone_2_stand_nodelta;

  if(isDefined(self.prone_anim_override))
    var_2 = self.prone_anim_override;

  if(isDefined(self.prone_rate_override))
    var_1 = self.prone_rate_override;

  if(!isDefined(var_1))
    var_1 = 1;

  animscripts\utility::exitpronewrapper(getanimlength(var_2) / 2);
  self setflaggedanimknoballrestart("trans", var_2, %body, 1, 0.2, var_1);
  animscripts\shared::donotetracks("trans");
  self clearanim(var_2, 0.1);
}