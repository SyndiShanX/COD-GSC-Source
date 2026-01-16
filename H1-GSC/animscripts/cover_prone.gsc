/***************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
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
  var_0["single"] = [ % prone_fire_1];
  var_0["burst2"] = % prone_fire_burst;
  var_0["burst3"] = % prone_fire_burst;
  var_0["burst4"] = % prone_fire_burst;
  var_0["burst5"] = % prone_fire_burst;
  var_0["burst6"] = % prone_fire_burst;
  var_0["reload"] = % prone_reload;
  var_0["look"] = [ % prone_twitch_look, % prone_twitch_lookfast, % prone_twitch_lookup];
  var_0["grenade_safe"] = [ % prone_grenade_a, % prone_grenade_a];
  var_0["grenade_exposed"] = [ % prone_grenade_a, % prone_grenade_a];
  var_0["exposed_idle"] = [ % prone_idle];
  var_0["twitch"] = [ % prone_twitch_ammocheck, % prone_twitch_look, % prone_twitch_scan, % prone_twitch_lookfast, % prone_twitch_lookup];
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
  var_0["turn_left_45"] = % h1_prone_turn_l45;
  var_0["turn_left_90"] = % h1_prone_turn_l90;
  var_0["turn_left_180"] = % h1_prone_turn_180;
  var_0["turn_right_45"] = % h1_prone_turn_r45;
  var_0["turn_right_90"] = % h1_prone_turn_r90;
  var_0["turn_right_180"] = % h1_prone_turn_180;
  anim.archetypes["soldier"]["cover_prone"] = var_0;
}

setanimmodedelayed(var_0) {
  self endon("killanimscript");
  self endon("killsetAnimModeDelayed");
  wait(var_0);
  self orientmode("face angle", self.covernode.angles[1]);
}

main() {
  self endon("killanimscript");
  animscripts\utility::initialize("cover_prone");

  if(weaponclass(self.weapon) == "rocketlauncher") {
    animscripts\combat::main();
    return;
  }

  if(isdefined(self.a.arrivaltype) && self.a.arrivaltype == "prone_saw")
    animscripts\cover_wall::useselfplacedturret("saw_bipod_prone", "weapon_saw_MG_Setup", 0);
  else if(isdefined(self.node.turret))
    animscripts\cover_wall::usestationaryturret();

  if(isdefined(self.enemy) && lengthsquared(self.origin - self.enemy.origin) < squared(512)) {
    thread animscripts\combat::main();
    return;
  }

  setup_cover_prone();
  self.turnthreshold = 50;
  self.covernode = self.node;
  self orientmode("face angle", self.angles[1]);
  self.a.goingtoproneaim = 1;
  self setproneanimnodes(-45, 45, % prone_legs_down, % exposed_aiming, % prone_legs_up);

  if(self.a.pose != "prone") {
    self orientmode("face angle", self.covernode.angles[1]);
    prone_transitionto("prone");
  } else {
    var_0 = 0;

    if(self.a.movement != "stop")
      var_0 = 0.15;

    animscripts\utility::enterpronewrapper(var_0);

    if(var_0 != 0) {
      var_1 = animscripts\utility::absangleclamp180(self.angles[1] - self.covernode.angles[1]);
      var_2 = % h1_crawl_2_prone;
      var_3 = 0.4;

      if(var_1 < -17.5) {
        var_2 = % h1_crawl_2_prone_35r;
        var_3 = 0.25;
      } else if(var_1 > 17.5) {
        var_3 = 0.25;
        var_2 = % h1_crawl_2_prone_35l;
      }

      var_4 = getanimlength(var_2);
      var_5 = var_4 * var_3;
      thread setanimmodedelayed(var_5);
      self setflaggedanimrestart("coverProneArrival", var_2, 1, 0.2, 1);
      animscripts\shared::donotetracks("coverProneArrival");
      self notify("killsetAnimModeDelayed");
      self.a.movement = "stop";
    }
  }

  thread animscripts\combat_utility::aimidlethread();
  setupproneaim(0.2);
  self setanim( % prone_aim_5, 1, 0.1);
  self orientmode("face angle", self.angles[1]);
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

  for (;;) {
    var_0 = animscripts\utility::animarraypickrandom("prone_idle");
    self setflaggedanimlimited("idle", var_0);
    self waittillmatch("idle", "end");
    self clearanim(var_0, 0.2);
  }
}

updatepronewrapper(var_0) {
  self updateprone(animscripts\utility::lookupanim("cover_prone", "legs_up"), animscripts\utility::lookupanim("cover_prone", "legs_down"), 1, var_0, 1);
  self setanim( % exposed_aiming, 1, 0.2);
}

doturn(var_0, var_1) {
  var_2 = isdefined(self.shootpos);
  var_3 = 1;
  var_4 = 0.2;
  var_5 = isdefined(self.enemy) && !isdefined(self.turntomatchnode) && self seerecently(self.enemy, 2) && distancesquared(self.enemy.origin, self.origin) < 262144;

  if(self.a.scriptstarttime + 500 > gettime()) {
    var_4 = 0.25;

    if(var_5)
      thread animscripts\combat::faceenemyimmediately();
  } else if(var_5) {
    var_6 = 1.0 - distance(self.enemy.origin, self.origin) / 512;
    var_3 = 1 + var_6 * 1;

    if(var_3 > 2)
      var_4 = 0.05;
    else if(var_3 > 1.3)
      var_4 = 0.1;
    else
      var_4 = 0.15;
  }

  var_7 = 0;

  if(var_1 > 157.5)
    var_7 = 180;
  else if(var_1 > 67.5)
    var_7 = 90;
  else
    var_7 = 45;

  var_8 = "turn_" + var_0 + "_" + var_7;
  var_9 = animscripts\utility::animarray(var_8);

  if(isdefined(self.turntomatchnode))
    self animmode("angle deltas", 0);
  else if(isdefined(self.node) && isdefined(anim.iscombatpathnode[self.node.type]) && distancesquared(self.origin, self.node.origin) < 256)
    self animmode("angle deltas", 0);
  else if(animscripts\combat::isanimdeltaingoal(var_9))
    animscripts\combat::resetanimmode();
  else
    self animmode("angle deltas", 0);

  self setanimknoball( % exposed_aiming, % body, 1, var_4);
  self setanimlimited( % turn, 1, var_4);

  if(isdefined(self.heat))
    var_3 = min(1.0, var_3);

  self setflaggedanimknoblimitedrestart("turn", var_9, 1, var_4, var_3);
  self notify("turning");
  animscripts\combat::doturnnotetracks();
  self setanimlimited( % turn, 0, 0.2);
  self clearanim( % turn, 0.2);
  self setanimknob( % exposed_aiming, 1, 0.2, 1);

  if(isdefined(self.turnlastresort)) {
    self.turnlastresort = undefined;
    thread animscripts\combat::faceenemyimmediately();
  }

  animscripts\combat::resetanimmode(0);
  self notify("done turning");
}

needtoturn() {
  if(!isdefined(self.enableproneturn))
    return 0;

  var_0 = self.shootpos;

  if(!isdefined(var_0))
    return 0;

  var_1 = self.angles[1] - vectortoyaw(var_0 - self.origin);
  var_2 = distancesquared(self.origin, var_0);

  if(var_2 < 65536) {
    var_3 = sqrt(var_2);

    if(var_3 > 3)
      var_1 = var_1 + asin(-3 / var_3);
  }

  return animscripts\utility::absangleclamp180(var_1) > self.turnthreshold;
}

turntofacerelativeyaw(var_0) {
  if(var_0 < 0 - self.turnthreshold) {
    doturn("left", 0 - var_0);
    maps\_gameskill::didsomethingotherthanshooting();
    return 1;
  }

  if(var_0 > self.turnthreshold) {
    doturn("right", var_0);
    maps\_gameskill::didsomethingotherthanshooting();
    return 1;
  }

  return 0;
}

coverproneneedtoturn() {
  if(needtoturn()) {
    var_0 = 0.25;

    if(isdefined(self.shootent) && !issentient(self.shootent))
      var_0 = 1.5;

    var_1 = animscripts\shared::getpredictedaimyawtoshootentorpos(var_0);

    if(turntofacerelativeyaw(var_1))
      return 1;
  }

  return 0;
}

pronecombatmainloop() {
  self endon("killanimscript");
  thread animscripts\track::trackshootentorpos();
  thread animscripts\shoot_behavior::decidewhatandhowtoshoot("normal");
  var_0 = gettime() > 2500;

  for (;;) {
    animscripts\utility::updateisincombattimer();
    updatepronewrapper(0.05);

    if(!var_0) {
      wait(0.05 + randomfloat(1.5));
      var_0 = 1;
      continue;
    }

    if(!isdefined(self.shootpos)) {
      if(coverproneneedtoturn()) {
        continue;
      }
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

    if(coverproneneedtoturn()) {
      continue;
    }
    if(considerthrowgrenade()) {
      continue;
    }
    if(pronereload(0)) {
      continue;
    }
    if(animscripts\combat_utility::aimedatshootentorpos()) {
      animscripts\combat_utility::shootuntilshootbehaviorchange();
      self clearanim( % add_fire, 0.2);
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

  if(isdefined(var_1) && var_1)
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
  if(isdefined(anim.throwgrenadeatplayerasap) && isalive(level.player)) {
    if(trythrowinggrenade(level.player, 200))
      return 1;
  }

  if(isdefined(self.enemy))
    return trythrowinggrenade(self.enemy, 850);

  return 0;
}

shouldfirewhilechangingpose() {
  if(!isdefined(self.weapon) || !weaponisauto(self.weapon))
    return 0;

  if(isdefined(self.node) && distancesquared(self.origin, self.node.origin) < 256)
    return 0;

  if(isdefined(self.enemy) && self cansee(self.enemy) && !isdefined(self.grenade) && animscripts\shared::getaimyawtoshootentorpos() < 20)
    return animscripts\move::mayshootwhilemoving();

  return 0;
}

prone_transitionto(var_0) {
  if(var_0 == self.a.pose) {
    return;
  }
  self clearanim( % animscript_root, 0.3);
  animscripts\combat_utility::endfireandanimidlethread();

  if(shouldfirewhilechangingpose())
    var_1 = animscripts\utility::animarray(self.a.pose + "_2_" + var_0 + "_firing");
  else
    var_1 = animscripts\utility::animarray(self.a.pose + "_2_" + var_0);

  if(var_0 == "prone") {}

  self setflaggedanimknoballrestart("trans", var_1, % body, 1, 0.2, 1.0);
  animscripts\shared::donotetracks("trans");
  self setanimknoballrestart(animscripts\utility::animarray("straight_level"), % body, 1, 0.25);
  setupproneaim(0.25);
}

finishnotetracks(var_0) {
  self endon("killanimscript");
  animscripts\shared::donotetracks(var_0);
}

setupproneaim(var_0) {
  self setanimknoball( % prone_aim_5, % body, 1, var_0);
  self setanimlimited( % prone_aim_2_add, 1, var_0);
  self setanimlimited( % prone_aim_4_add, 1, var_0);
  self setanimlimited( % prone_aim_6_add, 1, var_0);
  self setanimlimited( % prone_aim_8_add, 1, var_0);
}

proneto(var_0, var_1, var_2) {
  self clearanim( % animscript_root, 0.3);
  var_3 = undefined;

  if(shouldfirewhilechangingpose()) {
    if(var_0 == "crouch")
      var_3 = % prone_2_crouch_firing;
    else if(var_0 == "stand")
      var_3 = % prone_2_stand_firing;
  } else if(var_0 == "crouch")
    var_3 = % prone_2_crouch;
  else if(var_0 == "stand")
    var_3 = % prone_2_stand_nodelta;

  if(isdefined(self.prone_anim_override))
    var_3 = self.prone_anim_override;

  if(isdefined(self.prone_rate_override))
    var_1 = self.prone_rate_override;

  if(!isdefined(var_1))
    var_1 = 1;

  animscripts\utility::exitpronewrapper(getanimlength(var_3) / 2);
  self setflaggedanimknoballrestart("trans", var_3, % body, 1, 0.2, var_1);
  animscripts\shared::donotetracks("trans");

  if(!isdefined(var_2))
    var_2 = 0.1;

  self clearanim(var_3, var_2);
}