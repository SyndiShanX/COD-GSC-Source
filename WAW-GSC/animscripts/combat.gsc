/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\combat.gsc
*****************************************************/

#include animscripts\Utility;
#include animscripts\SetPoseMovement;
#include animscripts\Combat_utility;
#include animscripts\shared;
#include common_scripts\Utility;
#using_animtree("generic_human");

main() {
  self endon("killanimscript");
  [[self.exception["exposed"]]]();
  animscripts\utility::initialize("combat");
  self.a.arrivalType = undefined;
  if(getdvar("scr_testgrenadethrows") == "on")
    testGrenadeThrowAnimOffsets();
  self setup();
  self exposedCombatMainLoop();
  self notify("stop_deciding_how_to_shoot");
}

testAnims() {
  testanims = [];
  self animmode("zonly_physics");
  self orientMode("face current");
  for(i = 0; i < testanims.size; i++) {
    println(testanims[i]);
    self thread printAnimDebugLn(i);
    self setFlaggedAnimKnobAllRestart("animtest", testanims[i], % root, 1, 0, 1);
    self waittillmatch("animtest", "end");
    level notify("stopline");
  }
}

printAnimDebugLn(text) {
  level endon("stopline");
  pos = self.origin + (0, 0, -20);
  while(1) {
    print3d(pos, text);
    wait .05;
  }
}

lineUntilNotify(a, b) {
  level endon("stopline");
  while(1) {
    line(a, b);
    wait .05;
  }
}

testGrenadeThrowAnimOffsets() {
  testanims = [];
  testanims[0] = % exposed_grenadeThrowB;
  testanims[1] = % exposed_grenadeThrowC;
  testanims[2] = % corner_standL_grenade_A;
  testanims[3] = % corner_standL_grenade_B;
  testanims[4] = % CornerCrL_grenadeA;
  testanims[5] = % CornerCrL_grenadeB;
  testanims[6] = % corner_standR_grenade_A;
  testanims[7] = % corner_standR_grenade_B;
  testanims[8] = % CornerCrR_grenadeA;
  testanims[9] = % covercrouch_grenadeA;
  testanims[10] = % covercrouch_grenadeB;
  testanims[11] = % coverstand_grenadeA;
  testanims[12] = % coverstand_grenadeB;
  testanims[13] = % prone_grenade_A;
  model = getGrenadeModel();
  self animmode("zonly_physics");
  for(i = 0; i < testanims.size; i++) {
    forward = anglesToForward(self.angles);
    right = anglestoright(self.angles);
    startpos = self.origin;
    tag = "TAG_INHAND";
    self setFlaggedAnimKnobAllRestart("grenadetest", testanims[i], % root, 1, 0, 1);
    for(;;) {
      self waittill("grenadetest", notetrack);
      if(notetrack == "grenade_left" || notetrack == "grenade_right")
        self attach(model, tag);
      if(notetrack == "grenade_throw" || notetrack == "grenade throw") {
        break;
      }
      assert(notetrack != "end");
      if(notetrack == "end") {
        break;
      }
    }
    pos = self getTagOrigin(tag);
    baseoffset = pos - startpos;
    offset = (vectordot(baseoffset, forward), -1 * vectordot(baseoffset, right), baseoffset[2]);
    endpos = startpos + forward * offset[0] - right * offset[1] + (0, 0, 1) * offset[2];
    thread debugLine(startpos, endpos, (1, 1, 1), 20);
    println("else if( throwAnim == %", testanims[i], " ) offset = ", offset, ";");
    self detach(model, tag);
    wait 1;
  }
}
idleThread() {
  self endon("killanimscript");
  self endon("kill_idle_thread");
  for(;;) {
    idleAnim = animArrayPickRandom("exposed_idle");
    self setflaggedanimlimited("idle", idleAnim);
    self waittillmatch("idle", "end");
    self clearanim(idleAnim, .2);
  }
}
setupExposedSet() {
  if(isDefined(self.exposedSetIgnore) && self.exposedSetIgnore == true) {
    self.exposedSet = 0;
    return;
  }
  if(isDefined(self.exposedSetOverride)) {
    if(self.exposedSetOverride == 1) {
      self.exposedSetOverride = gettime() + 10000;
      self.exposedSet = 0;
      return;
    } else
    if(self.exposedSetOverride < gettime()) {
      self.exposedSet = 0;
      return;
    } else
      self.exposedSetOverride = undefined;
  }
  if(self is_zombie()) {
    self.exposedSet = 0;
    return;
  }
  if(usingSMG()) {
    probability = getdvarint("ai_exposedSet2Probability");
    if(probability == 100 || randomint(100) < probability) {
      self.exposedSet = 1;
    } else {
      self.exposedSet = 0;
    }
  } else {
    self.exposedSet = 0;
  }
}

setup() {
  self setupExposedSet();
  if(usingSidearm())
    transitionTo("stand");
  if(self.a.pose == "stand") {
    self set_animarray_standing();
  } else if(self.a.pose == "crouch") {
    self set_animarray_crouching();
  } else if(self.a.pose == "prone") {
    self set_animarray_prone();
  } else {
    assertMsg("Unsupported self.a.pose: " + self.a.pose);
  }
  self.isturning = false;
  self thread stopShortly();
  self.previousPitchDelta = 0.0;
  self clearAnim( % root, .2);
  self setAnim(animarray("straight_level"));
  self setAnim( % add_idle);
  if(!self is_zombie()) {
    self clearanim( % aim_4, .2);
    self clearanim( % aim_6, .2);
    self clearanim( % aim_2, .2);
    self clearanim( % aim_8, .2);
  }
  setupAim(.2);
  self thread idleThread();
  self.a.meleeState = "aim";
  self.twitchallowed = true;
}

stopShortly() {
  self endon("killanimscript");
  self endon("melee");
  wait .2;
  self.a.movement = "stop";
}

setupAim(transTime) {
  if(self is_zombie()) {
    return;
  }
  assert(isDefined(transTime));
  self setAnimKnobLimited(animArray("add_aim_up"), 1, transTime);
  self setAnimKnobLimited(animArray("add_aim_down"), 1, transTime);
  self setAnimKnobLimited(animArray("add_aim_left"), 1, transTime);
  self setAnimKnobLimited(animArray("add_aim_right"), 1, transTime);
}

set_aimturn_limits() {
  self.rightAimLimit = 45;
  self.leftAimLimit = -45;
  self.upAimLimit = 45;
  self.downAimLimit = -45;
  self.turnleft180limit = -130;
  self.turnright180limit = 130;
  self.turnleft90limit = -70;
  self.turnright90limit = 70;
}

set_animarray_standing() {
  self.a.array = [];
  self.turnThreshold = 35;
  set_aimturn_limits();
  if(!isDefined(self.exposedSet) || self.exposedSet == 0) {
    self.a.array["exposed_idle"] = array( % exposed_idle_alert_v1, % exposed_idle_alert_v2, % exposed_idle_alert_v3);
    self.a.array["idle1"] = % exposed_idle_alert_v1;
    self.a.array["idle2"] = % exposed_idle_alert_v2;
    self.a.array["idle3"] = % exposed_idle_alert_v3;
    self.a.array["fire"] = % exposed_shoot_auto_v3;
    self.a.array["single"] = array( % exposed_shoot_semi1);
    self.a.array["burst2"] = % exposed_shoot_burst3;
    self.a.array["burst3"] = % exposed_shoot_burst3;
    self.a.array["burst4"] = % exposed_shoot_burst4;
    self.a.array["burst5"] = % exposed_shoot_burst5;
    self.a.array["burst6"] = % exposed_shoot_burst6;
    self.a.array["semi2"] = % exposed_shoot_semi2;
    self.a.array["semi3"] = % exposed_shoot_semi3;
    self.a.array["semi4"] = % exposed_shoot_semi4;
    self.a.array["semi5"] = % exposed_shoot_semi5;
    self.a.array["reload"] = array( % exposed_reload);
    self.a.array["reload_crouchhide"] = array( % exposed_reloadb);
    self.a.array["turn_left_45"] = % exposed_tracking_turn45L;
    self.a.array["turn_left_90"] = % exposed_tracking_turn90L;
    self.a.array["turn_left_135"] = % exposed_tracking_turn135L;
    self.a.array["turn_left_180"] = % exposed_tracking_turn180L;
    self.a.array["turn_right_45"] = % exposed_tracking_turn45R;
    self.a.array["turn_right_90"] = % exposed_tracking_turn90R;
    self.a.array["turn_right_135"] = % exposed_tracking_turn135R;
    self.a.array["turn_right_180"] = % exposed_tracking_turn180L;
    self.a.array["straight_level"] = % exposed_aim_5;
    self.a.array["add_aim_up"] = % exposed_aim_8;
    self.a.array["add_aim_down"] = % exposed_aim_2;
    self.a.array["add_aim_left"] = % exposed_aim_4;
    self.a.array["add_aim_right"] = % exposed_aim_6;
    self.a.array["add_turn_aim_up"] = % exposed_turn_aim_8;
    self.a.array["add_turn_aim_down"] = % exposed_turn_aim_2;
    self.a.array["add_turn_aim_left"] = % exposed_turn_aim_4;
    self.a.array["add_turn_aim_right"] = % exposed_turn_aim_6;
    self.a.array["crouch_2_stand"] = % exposed_crouch_2_stand;
    self.a.array["stand_2_crouch"] = % exposed_stand_2_crouch;
  } else {
    self.leftAimLimit = -40;
    self.a.array["exposed_idle"] = array( % exposed2_idle_alert_v1, % exposed2_idle_alert_v2, % exposed2_idle_alert_v3);
    self.a.array["idle1"] = % exposed2_idle_alert_v1;
    self.a.array["idle2"] = % exposed2_idle_alert_v2;
    self.a.array["idle3"] = % exposed2_idle_alert_v3;
    self.a.array["fire"] = % exposed2_shoot_auto_v3;
    self.a.array["single"] = array( % exposed2_shoot_semi1);
    self.a.array["burst2"] = % exposed2_shoot_burst3;
    self.a.array["burst3"] = % exposed2_shoot_burst3;
    self.a.array["burst4"] = % exposed2_shoot_burst4;
    self.a.array["burst5"] = % exposed2_shoot_burst5;
    self.a.array["burst6"] = % exposed2_shoot_burst6;
    self.a.array["semi2"] = % exposed2_shoot_semi2;
    self.a.array["semi3"] = % exposed2_shoot_semi3;
    self.a.array["semi4"] = % exposed2_shoot_semi4;
    self.a.array["semi5"] = % exposed2_shoot_semi5;
    self.a.array["reload"] = array( % exposed2_reload);
    self.a.array["reload_crouchhide"] = array( % exposed2_reloadb);
    self.a.array["turn_left_45"] = % exposed2_tracking_turn45L;
    self.a.array["turn_left_90"] = % exposed2_tracking_turn90L;
    self.a.array["turn_left_135"] = % exposed2_tracking_turn135L;
    self.a.array["turn_left_180"] = % exposed2_tracking_turn180L;
    self.a.array["turn_right_45"] = % exposed2_tracking_turn45R;
    self.a.array["turn_right_90"] = % exposed2_tracking_turn90R;
    self.a.array["turn_right_135"] = % exposed2_tracking_turn135R;
    self.a.array["turn_right_180"] = % exposed2_tracking_turn180L;
    self.a.array["straight_level"] = % exposed2_aim_5;
    self.a.array["add_aim_up"] = % exposed2_aim_8;
    self.a.array["add_aim_down"] = % exposed2_aim_2;
    self.a.array["add_aim_left"] = % exposed2_aim_4;
    self.a.array["add_aim_right"] = % exposed2_aim_6;
    self.a.array["add_turn_aim_up"] = % exposed2_turn_aim_8;
    self.a.array["add_turn_aim_down"] = % exposed2_turn_aim_2;
    self.a.array["add_turn_aim_left"] = % exposed2_turn_aim_4;
    self.a.array["add_turn_aim_right"] = % exposed2_turn_aim_6;
    self.a.array["crouch_2_stand"] = % exposed2_crouch_2_stand;
    self.a.array["stand_2_crouch"] = % exposed2_stand_2_crouch;
  }
  self.a.array["crouch_2_prone"] = % crouch_2_prone;
  self.a.array["stand_2_prone"] = % stand_2_prone;
  self.a.array["prone_2_crouch"] = % prone_2_crouch;
  self.a.array["prone_2_stand"] = % prone_2_stand;
  if(self usingBoltActionWeapon()) {
    if(!isDefined(self.exposedSet) || self.exposedSet == 0) {
      self.a.array["rechamber"] = % exposed_rechamber_v1;
    } else {
      self.a.array["rechamber"] = % exposed2_rechamber_v1;
    }
  }
  if(self usingTopLoadingWeapon()) {
    self.a.array["reload"] = array( % exposed_topload);
    self.a.array["reload_crouchhide"] = array( % exposed_topload);
  }
  if(usingSidearm()) {
    self.a.array["exposed_idle"] = array( % pistol_stand_idle_alert);
    self.a.array["fire"] = % pistol_stand_fire_A;
    self.a.array["single"] = array( % pistol_stand_fire_A);
    self.a.array["reload"] = array( % pistol_stand_reload_A);
    self.a.array["reload_crouchhide"] = array();
    self.a.array["turn_left_45"] = % pistol_stand_turn45L;
    self.a.array["turn_right_45"] = % pistol_stand_turn45R;
    self.a.array["turn_left_90"] = % pistol_stand_turn90L;
    self.a.array["turn_right_90"] = % pistol_stand_turn90R;
    self.a.array["turn_left_135"] = % pistol_stand_turn180L;
    self.a.array["turn_right_135"] = % pistol_stand_turn180L;
    self.a.array["turn_left_180"] = % pistol_stand_turn180L;
    self.a.array["turn_right_180"] = % pistol_stand_turn180L;
    self.a.array["straight_level"] = % pistol_stand_aim_5;
    self.a.array["add_aim_up"] = % pistol_stand_aim_8_add;
    self.a.array["add_aim_down"] = % pistol_stand_aim_2_add;
    self.a.array["add_aim_left"] = % pistol_stand_aim_4_add;
    self.a.array["add_aim_right"] = % pistol_stand_aim_6_add;
    self.a.array["add_turn_aim_up"] = % pistol_stand_aim_8_alt;
    self.a.array["add_turn_aim_down"] = % pistol_stand_aim_2_alt;
    self.a.array["add_turn_aim_left"] = % pistol_stand_aim_4_alt;
    self.a.array["add_turn_aim_right"] = % pistol_stand_aim_6_alt;
  } else if(weaponAnims() == "rocketlauncher") {
    self.a.array["add_aim_up"] = % RPG_stand_aim_8;
    self.a.array["add_aim_down"] = % RPG_stand_aim_2;
    self.a.array["add_aim_left"] = % RPG_stand_aim_4;
    self.a.array["add_aim_right"] = % RPG_stand_aim_6;
    self.a.array["fire"] = % RPG_stand_fire;
    self.a.array["straight_level"] = % RPG_stand_aim_5;
    self.a.array["reload"] = array( % RPG_stand_reload);
    self.a.array["reload_crouchhide"] = array();
    self.a.array["exposed_idle"] = array( % RPG_stand_idle);
  } else if(weaponAnims() == "gas") {
    self.a.array["exposed_idle"] = array( % ai_flamethrower_stand_idle_alert_v1);
    self.a.array["idle1"] = % ai_flamethrower_stand_idle_alert_v1;
    self.a.array["fire"] = % ai_flame_fire_center;
    self.a.array["single"] = % ai_flame_fire_center;
    self.a.array["turn_left_45"] = % ai_flamethrower_turn45l;
    self.a.array["turn_left_90"] = % ai_flamethrower_turn90l;
    self.a.array["turn_left_135"] = % ai_flamethrower_turn135l;
    self.a.array["turn_left_180"] = % ai_flamethrower_turn180;
    self.a.array["turn_right_45"] = % ai_flamethrower_turn45r;
    self.a.array["turn_right_90"] = % ai_flamethrower_turn90r;
    self.a.array["turn_right_135"] = % ai_flamethrower_turn135r;
    self.a.array["turn_right_180"] = % ai_flamethrower_turn180;
    self.a.array["straight_level"] = % ai_flamethrower_aim_5;
    self.a.array["add_aim_up"] = % ai_flamethrower_aim_8;
    self.a.array["add_aim_down"] = % ai_flamethrower_aim_2;
    self.a.array["add_aim_left"] = % ai_flamethrower_aim_4;
    self.a.array["add_aim_right"] = % ai_flamethrower_aim_6;
    self.a.array["crouch_2_stand"] = % ai_flamethrower_crouch_2_stand;
    self.a.array["stand_2_crouch"] = % ai_flamethrower_stand_2_crouch;
  } else if(self is_zombie()) {
    self.a.array["turn_left_45"] = % exposed_tracking_turn45L;
    self.a.array["turn_left_90"] = % exposed_tracking_turn90L;
    self.a.array["turn_left_135"] = % exposed_tracking_turn135L;
    self.a.array["turn_left_180"] = % exposed_tracking_turn180L;
    self.a.array["turn_right_45"] = % exposed_tracking_turn45R;
    self.a.array["turn_right_90"] = % exposed_tracking_turn90R;
    self.a.array["turn_right_135"] = % exposed_tracking_turn135R;
    self.a.array["turn_right_180"] = % exposed_tracking_turn180L;
    self.a.array["exposed_idle"] = array( % ai_zombie_idle_v1);
    self.a.array["straight_level"] = % ai_zombie_idle_base;
    self.a.array["stand_2_crouch"] = % ai_zombie_shot_leg_right_2_crawl;
  } else if(self usingShotgun()) {
    self.a.array["reload"] = array( % shotgun_stand_reload_A, % shotgun_stand_reload_B, % shotgun_stand_reload_C, % shotgun_stand_reload_C, % shotgun_stand_reload_C);
    self.a.array["reload_crouchhide"] = array( % shotgun_stand_reload_A, % shotgun_stand_reload_B);
    self.a.array["straight_level"] = % shotgun_aim_5;
    self.a.array["add_aim_up"] = % shotgun_aim_8;
    self.a.array["add_aim_down"] = % shotgun_aim_2;
    self.a.array["add_aim_left"] = % shotgun_aim_4;
    self.a.array["add_aim_right"] = % shotgun_aim_6;
  } else if(self isCQBWalking() || self is_banzai()) {
    self.a.array["reload"] = array( % CQB_stand_reload_steady);
    self.a.array["reload_crouchhide"] = array( % CQB_stand_reload_knee);
    self.a.array["straight_level"] = % CQB_stand_aim5;
    self.a.array["add_aim_up"] = % CQB_stand_aim8;
    self.a.array["add_aim_down"] = % CQB_stand_aim2;
    self.a.array["add_aim_left"] = % CQB_stand_aim4;
    self.a.array["add_aim_right"] = % CQB_stand_aim6;
  }
}

set_animarray_crouching() {
  assert(!usingSidearm());
  self.a.array = [];
  self.turnThreshold = 45;
  set_aimturn_limits();
  self.a.array["exposed_idle"] = array( % exposed_crouch_idle_alert_v1, % exposed_crouch_idle_alert_v2, % exposed_crouch_idle_alert_v3);
  self.a.array["fire"] = % exposed_crouch_shoot_auto_v2;
  self.a.array["single"] = array( % exposed_crouch_shoot_semi1);
  self.a.array["burst2"] = % exposed_crouch_shoot_burst3;
  self.a.array["burst3"] = % exposed_crouch_shoot_burst3;
  self.a.array["burst4"] = % exposed_crouch_shoot_burst4;
  self.a.array["burst5"] = % exposed_crouch_shoot_burst5;
  self.a.array["burst6"] = % exposed_crouch_shoot_burst6;
  self.a.array["semi2"] = % exposed_crouch_shoot_semi2;
  self.a.array["semi3"] = % exposed_crouch_shoot_semi3;
  self.a.array["semi4"] = % exposed_crouch_shoot_semi4;
  self.a.array["semi5"] = % exposed_crouch_shoot_semi5;
  self.a.array["reload"] = array( % exposed_crouch_reload);
  self.a.array["turn_left_45"] = % exposed_crouch_turn_left;
  self.a.array["turn_left_90"] = % exposed_crouch_turn_left;
  self.a.array["turn_left_135"] = % exposed_crouch_turn_left;
  self.a.array["turn_left_180"] = % exposed_crouch_turn_left;
  self.a.array["turn_right_45"] = % exposed_crouch_turn_right;
  self.a.array["turn_right_90"] = % exposed_crouch_turn_right;
  self.a.array["turn_right_135"] = % exposed_crouch_turn_right;
  self.a.array["turn_right_180"] = % exposed_crouch_turn_right;
  self.a.array["straight_level"] = % exposed_crouch_aim_5;
  self.a.array["add_aim_up"] = % exposed_crouch_aim_8;
  self.a.array["add_aim_down"] = % exposed_crouch_aim_2;
  self.a.array["add_aim_left"] = % exposed_crouch_aim_4;
  self.a.array["add_aim_right"] = % exposed_crouch_aim_6;
  self.a.array["add_turn_aim_up"] = % exposed_crouch_turn_aim_8;
  self.a.array["add_turn_aim_down"] = % exposed_crouch_turn_aim_2;
  self.a.array["add_turn_aim_left"] = % exposed_crouch_turn_aim_4;
  self.a.array["add_turn_aim_right"] = % exposed_crouch_turn_aim_6;
  if(self is_zombie()) {
    self.a.array["exposed_idle"] = array( % ai_zombie_idle_crawl);
    self.a.array["straight_level"] = % ai_zombie_idle_crawl_base;
    self.a.array["stand_2_crouch"] = % ai_zombie_shot_leg_left_2_crawl;
  }
  if(!isDefined(self.exposedSet) || self.exposedSet == 0) {
    self.a.array["crouch_2_stand"] = % exposed_crouch_2_stand;
    self.a.array["stand_2_crouch"] = % exposed_stand_2_crouch;
  } else {
    self.a.array["crouch_2_stand"] = % exposed2_crouch_2_stand;
    self.a.array["stand_2_crouch"] = % exposed2_stand_2_crouch;
  }
  self.a.array["crouch_2_prone"] = % crouch_2_prone;
  self.a.array["stand_2_prone"] = % stand_2_prone;
  self.a.array["prone_2_crouch"] = % prone_2_crouch;
  self.a.array["prone_2_stand"] = % prone_2_stand;
  if(self usingBoltActionWeapon()) {
    self.a.array["rechamber"] = % exposed_crouch_rechamber_v1;
  }
  if(self usingTopLoadingWeapon()) {
    self.a.array["reload"] = array( % exposed_crouch_topload);
  }
  if(weaponAnims() == "rocketlauncher") {
    self.a.array["exposed_idle"] = array( % RPG_crouch_idle);
    self.a.array["fire"] = % RPG_crouch_fire;
    self.a.array["single"] = array( % RPG_crouch_fire);
    self.a.array["reload"] = array( % RPG_crouch_reload);
    self.a.array["straight_level"] = % RPG_crouch_aim_5;
    self.a.array["add_aim_up"] = % RPG_crouch_aim_8;
    self.a.array["add_aim_down"] = % RPG_crouch_aim_2;
    self.a.array["add_aim_left"] = % RPG_crouch_aim_4;
    self.a.array["add_aim_right"] = % RPG_crouch_aim_6;
  } else if(weaponAnims() == "gas") {
    self.a.array["exposed_idle"] = array( % ai_flamethrower_crouch_idle_a_alert_v1);
    self.a.array["fire"] = % ai_flame_crouch_fire_center;
    self.a.array["single"] = % ai_flame_crouch_fire_center;
    self.a.array["straight_level"] = % ai_flamethrower_crouch_aim_5;
    self.a.array["add_aim_up"] = % ai_flamethrower_crouch_aim_8;
    self.a.array["add_aim_down"] = % ai_flamethrower_crouch_aim_2;
    self.a.array["add_aim_left"] = % ai_flamethrower_crouch_aim_4;
    self.a.array["add_aim_right"] = % ai_flamethrower_crouch_aim_6;
    self.a.array["turn_left_45"] = % ai_flamethrower_crouch_turn90l;
    self.a.array["turn_left_90"] = % ai_flamethrower_crouch_turn90l;
    self.a.array["turn_left_135"] = % ai_flamethrower_crouch_turn90l;
    self.a.array["turn_left_180"] = % ai_flamethrower_crouch_turn90l;
    self.a.array["turn_right_45"] = % ai_flamethrower_crouch_turn90r;
    self.a.array["turn_right_90"] = % ai_flamethrower_crouch_turn90r;
    self.a.array["turn_right_135"] = % ai_flamethrower_crouch_turn90r;
    self.a.array["turn_right_180"] = % ai_flamethrower_crouch_turn90r;
    self.a.array["crouch_2_stand"] = % ai_flamethrower_crouch_2_stand;
    self.a.array["stand_2_crouch"] = % ai_flamethrower_stand_2_crouch;
  } else if(isDefined(self.weapon) && weaponClass(self.weapon) == "spread") {
    self.a.array["single"] = array( % shotgun_crouch_fire);
    self.a.array["reload"] = array( % shotgun_crouch_reload);
    self.a.array["straight_level"] = % shotgun_crouch_aim_5;
    self.a.array["add_aim_up"] = % shotgun_crouch_aim_8;
    self.a.array["add_aim_down"] = % shotgun_crouch_aim_2;
    self.a.array["add_aim_left"] = % shotgun_crouch_aim_4;
    self.a.array["add_aim_right"] = % shotgun_crouch_aim_6;
  }
}

set_animarray_prone() {
  assert(!usingSidearm());
  self.a.array = [];
  self.a.array["add_aim_up"] = % prone_aim_8_add;
  self.a.array["add_aim_down"] = % prone_aim_2_add;
  self.a.array["add_aim_left"] = % prone_aim_4_add;
  self.a.array["add_aim_right"] = % prone_aim_6_add;
  self.a.array["straight_level"] = % prone_aim_5;
  self.a.array["fire"] = % prone_fire_1;
  self.a.array["single"] = array( % prone_fire_1);
  self.a.array["reload"] = array( % prone_reload);
  self.a.array["burst2"] = % prone_fire_burst;
  self.a.array["burst3"] = % prone_fire_burst;
  self.a.array["burst4"] = % prone_fire_burst;
  self.a.array["burst5"] = % prone_fire_burst;
  self.a.array["burst6"] = % prone_fire_burst;
  self.a.array["semi2"] = % prone_fire_burst;
  self.a.array["semi3"] = % prone_fire_burst;
  self.a.array["semi4"] = % prone_fire_burst;
  self.a.array["semi5"] = % prone_fire_burst;
  self.a.array["exposed_idle"] = array( % exposed_crouch_idle_alert_v1, % exposed_crouch_idle_alert_v2, % exposed_crouch_idle_alert_v3);
  self.a.array["crouch_2_prone"] = % crouch_2_prone;
  if(!isDefined(self.exposedSet) || self.exposedSet == 0) {
    self.a.array["crouch_2_stand"] = % exposed_crouch_2_stand;
    self.a.array["stand_2_crouch"] = % exposed_stand_2_crouch;
  } else {
    self.a.array["crouch_2_stand"] = % exposed2_crouch_2_stand;
    self.a.array["stand_2_crouch"] = % exposed2_stand_2_crouch;
  }
  self.a.array["stand_2_prone"] = % stand_2_prone;
  self.a.array["prone_2_crouch"] = % prone_2_crouch;
  self.a.array["prone_2_stand"] = % prone_2_stand;
  self.turnThreshold = 45;
  self.rightAimLimit = 45;
  self.leftAimLimit = -45;
  self.upAimLimit = 45;
  self.downAimLimit = -45;
  self.turnleft180limit = -130;
  self.turnright180limit = 130;
  self.turnleft90limit = -70;
  self.turnright90limit = 70;
}

banzai_exposed_monitor() {
  self endon("death");
  self endon("killanimscript");
  self endon("melee");
  lastPos = self.origin;
  nonmovements = 0;
  while(1) {
    if(self is_banzai()) {
      distance = distanceSquared(lastPos, self.origin);
      if(distance < 36) {
        nonmovements++;
        if(self.a.movement == "stop" || nonmovements > 5) {
          self.banzai = false;
          self.goalradius = 768;
          self.minDist = 128;
          self FindCoverNearSelf();
          return;
        }
      }
    }
    lastPos = self.origin;
    wait(2);
  }
}

exposedCombatMainLoop() {
  self endon("killanimscript");
  self endon("melee");
  self thread trackShootEntOrPos();
  self thread banzai_exposed_monitor();
  if(!self is_banzai()) {
    self thread ReacquireWhenNecessary();
  }
  self thread animscripts\shoot_behavior::decideWhatAndHowToShoot("normal");
  self thread watchShootEntVelocity();
  if(self.a.magicReloadWhenReachEnemy) {
    self animscripts\weaponList::RefillClip();
    self.a.magicReloadWhenReachEnemy = false;
  }
  self animMode("zonly_physics", false);
  self OrientMode("face angle", self.angles[1]);
  nextShootTime = 0;
  self resetGiveUpOnEnemyTime();
  self.a.dontCrouchTime = gettime() + randomintrange(500, 1500);
  justWaited = false;
  for(;;) {
    if(self weaponAnims() == "rocketlauncher")
      self.deathFunction = undefined;
    self IsInCombat();
    if(!justWaited) {
      if(self.a.pose == "stand")
        self set_animarray_standing();
      else if(self.a.pose == "crouch")
        self set_animarray_crouching();
      else
        self set_animarray_prone();
    }
    justWaited = false;
    if(EnsureStanceIsAllowed()) {
      continue;
    }
    if(TryMelee()) {
      return;
    }
    if(self is_zombie()) {
      if(needToTurn()) {
        predictTime = 0.25;
        if(isDefined(self.shootEnt) && !isSentient(self.shootEnt)) {
          predictTime = 1.5;
        }
        yawToShootEntOrPos = getPredictedAimYawToShootEntOrPos(predictTime);
        if(TurnToFaceRelativeYaw(yawToShootEntOrPos)) {
          continue;
        }
      }
      exposedWait();
      justWaited = true;
      continue;
    }
    if(!isDefined(self.shootPos)) {
      assert(!isDefined(self.shootEnt));
      cantSeeEnemyBehavior();
      continue;
    }
    assert(isDefined(self.shootPos));
    self resetGiveUpOnEnemyTime();
    distSqToShootPos = lengthsquared(self.origin - self.shootPos);
    if(weaponAnims() == "rocketlauncher" && !self.a.no_weapon_switch && (distSqToShootPos < squared(512) || self.a.rockets < 1)) {
      if(self.a.pose != "stand" && self.a.pose != "crouch")
        transitionTo("crouch");
      if(self.a.pose == "stand")
        animscripts\shared::throwDownWeapon( % RPG_stand_throw);
      else
        animscripts\shared::throwDownWeapon( % RPG_crouch_throw);
      continue;
    }
    if(self.a.pose != "stand" && self isStanceAllowed("stand")) {
      if(distSqToShootPos < squared(285)) {
        transitionTo("stand");
        continue;
      }
      if(standIfMakesEnemyVisible())
        continue;
    }
    if(needToTurn()) {
      predictTime = 0.25;
      if(isDefined(self.shootEnt) && !isSentient(self.shootEnt))
        predictTime = 1.5;
      yawToShootEntOrPos = getPredictedAimYawToShootEntOrPos(predictTime);
      if(TurnToFaceRelativeYaw(yawToShootEntOrPos))
        continue;
    }
    if(self is_banzai()) {
      wait 0.05;
      justWaited = true;
      continue;
    }
    if(considerThrowGrenade()) {
      continue;
    }
    if(isDefined(self.forceSideArm) && self.forceSideArm && self.a.pose == "stand" && !usingSidearm()) {
      if(self tryUsingSidearm())
        continue;
    }
    if(NeedToReload(0)) {
      distSQ = lengthsquared(self.origin - self.shootPos);
      if(distSQ > anim.chargeRangeSq && distSQ < anim.standRangeSq) {
        if(!usingSidearm() && weaponAnims() != "rocketlauncher" && self isStanceAllowed("stand") && self.weapon == self.primaryweapon) {
          if(self.a.pose != "stand") {
            transitionTo("stand");
            continue;
          }
          if(self tryUsingSidearm()) {
            continue;
          }
        }
      } else {
        if(usingSidearm()) {
          switchToLastWeapon( % pistol_stand_switch);
        }
      }
      if(TryMelee()) {
        return;
      }
      if(self exposedReload(0)) {
        continue;
      }
    }
    if(self weaponAnims() == "rocketlauncher" && self.a.pose != "crouch" && randomFloat(1) > 0.65)
      self.deathFunction = ::rpgDeath;
    if(usingSidearm() && self.a.pose == "stand" && lengthsquared(self.origin - self.shootPos) > squared(512))
      switchToLastWeapon( % pistol_stand_switch);
    if(distSqToShootPos > squared(600) && self.a.pose != "crouch" && self isStanceAllowed("crouch") && !usingSidearm() && gettime() >= self.a.dontCrouchTime) {
      if(lengthSquared(self.shootEntVelocity) < 100 * 100) {
        if(!isDefined(self.shootPos) || sightTracePassed(self.origin + (0, 0, 36), self.shootPos, false, undefined)) {
          transitionTo("crouch");
          continue;
        }
      }
    }
    if(aimedAtShootEntOrPos() && gettime() >= nextShootTime) {
      self shootUntilNeedToTurn();
      if(!self usingShotgun() && !self usingBoltActionWeapon())
        self clearAnim( % add_fire, .2);
      if(NeedToRechamber()) {
        if(self exposedRechamber()) {
          self notify("weapon_rechamber_done");
          continue;
        }
      }
      continue;
    }
    exposedWait();
    justWaited = true;
  }
}

exposedWait() {
  if(!isDefined(self.enemy) || !self cansee(self.enemy)) {
    self endon("enemy");
    self endon("shoot_behavior_change");
    wait 0.2 + randomfloat(0.1);
    self waittill("do_slow_things");
  } else {
    wait 0.05;
  }
}

standIfMakesEnemyVisible() {
  assert(self.a.pose != "stand");
  assert(self isStanceAllowed("stand"));
  if(isDefined(self.enemy) && (!self cansee(self.enemy) || !self canShoot(self.enemy getShootAtPos())) && sightTracePassed(self.origin + (0, 0, 64), self.enemy getShootAtPos(), false, undefined)) {
    self.a.dontCrouchTime = gettime() + 3000;
    transitionTo("stand");
    return true;
  }
  return false;
}

needToTurn() {
  point = self.shootPos;
  if(self is_zombie()) {
    if(isDefined(self.enemy)) {
      point = self.enemy.origin;
      self.shootPos = point;
    }
  }
  if(!isDefined(point))
    return false;
  yaw = self.angles[1] - VectorToAngles(point - self.origin)[1];
  distsq = distanceSquared(self.origin, point);
  if(distsq < 256 * 256) {
    dist = sqrt(distsq);
    if(dist > 3)
      yaw += asin(-3 / dist);
  }
  return AbsAngleClamp180(yaw) > self.turnThreshold;
}

EnsureStanceIsAllowed() {
  curstance = self.a.pose;
  if(!self isStanceAllowed(curstance)) {
    assert(curstance == "stand" || curstance == "crouch" || curstance == "prone");
    otherstance = "crouch";
    if(curstance == "crouch")
      otherstance = "stand";
    if(self isStanceAllowed(otherstance)) {
      if(curstance == "stand" && usingSidearm()) {
        switchToLastWeapon( % pistol_stand_switch);
        return true;
      }
      transitionTo(otherstance);
      return true;
    }
  }
  return false;
}

cantSeeEnemyBehavior() {
  if(self.a.pose != "stand" && self isStanceAllowed("stand") && standIfMakesEnemyVisible())
    return true;
  time = gettime();
  self.a.dontCrouchTime = time + 1500;
  if(isDefined(self.node) && self.node.type == "Guard") {
    relYaw = AngleClamp180(self.angles[1] - self.node.angles[1]);
    if(self TurnToFaceRelativeYaw(relYaw))
      return true;
  } else if(self.goalangle[1] != 0.0) {
    relYaw = AngleClamp180(self.angles[1] - self.goalangle[1]);
    if(self TurnToFaceRelativeYaw(relYaw))
      return true;
  } else if(time > self.a.scriptStartTime + 1200) {
    likelyEnemyDir = self getAnglesToLikelyEnemyPath();
    if(isDefined(likelyEnemyDir)) {
      relYaw = AngleClamp180(self.angles[1] - likelyEnemyDir[1]);
      if(self TurnToFaceRelativeYaw(relYaw))
        return true;
    }
  }
  if(considerThrowGrenade())
    return true;
  givenUpOnEnemy = (self.a.nextGiveUpOnEnemyTime < time);
  threshold = 0;
  if(givenUpOnEnemy)
    threshold = 0.99999;
  if(self exposedReload(threshold))
    return true;
  if(givenUpOnEnemy && usingSidearm()) {
    switchToLastWeapon( % pistol_stand_switch);
    return true;
  }
  cantSeeEnemyWait();
  return true;
}

cantSeeEnemyWait() {
  self endon("shoot_behavior_change");
  wait 0.4 + randomfloat(0.4);
  self waittill("do_slow_things");
}

resetGiveUpOnEnemyTime() {
  self.a.nextGiveUpOnEnemyTime = gettime() + randomintrange(2000, 4000);
}

TurnToFaceRelativeYaw(faceYaw) {
  if(faceYaw < 0 - self.turnThreshold) {
    if(self.a.pose == "prone") {
      self animscripts\cover_prone::proneTo("crouch");
      self set_animarray_crouching();
    }
    self turn("left", 0 - faceYaw);
    self maps\_gameskill::didSomethingOtherThanShooting();
    return true;
  }
  if(faceYaw > self.turnThreshold) {
    if(self.a.pose == "prone") {
      self animscripts\cover_prone::proneTo("crouch");
      self set_animarray_crouching();
    }
    self turn("right", faceYaw);
    self maps\_gameskill::didSomethingOtherThanShooting();
    return true;
  }
  return false;
}

watchShootEntVelocity() {
  self endon("killanimscript");
  self.shootEntVelocity = (0, 0, 0);
  prevshootent = undefined;
  prevpos = self.origin;
  interval = .15;
  while(1) {
    if(isDefined(self.shootEnt) && isDefined(prevshootent) && self.shootEnt == prevshootent) {
      curpos = self.shootEnt.origin;
      self.shootEntVelocity = vectorScale(curpos - prevpos, 1 / interval);
      prevpos = curpos;
    } else {
      if(isDefined(self.shootEnt))
        prevpos = self.shootEnt.origin;
      else
        prevpos = self.origin;
      prevshootent = self.shootEnt;
      self.shootEntVelocity = (0, 0, 0);
    }
    wait interval;
  }
}

shouldSwapShotgun() {
  return false;
}

DoNoteTracksWithEndon(animname) {
  self endon("killanimscript");
  self animscripts\shared::DoNoteTracks(animname);
}

endtwitch() {
  self endon("killanimscript");
  wait(10);
  self.twitchallowed = true;
}

faceEnemyImmediately() {
  self endon("killanimscript");
  self notify("facing_enemy_immediately");
  self endon("facing_enemy_immediately");
  maxYawChange = 5;
  while(1) {
    yawChange = 0 - GetYawToEnemy();
    if(abs(yawChange) < 2) {
      break;
    }
    if(abs(yawChange) > maxYawChange)
      yawChange = maxYawChange * sign(yawChange);
    self OrientMode("face angle", self.angles[1] + yawChange);
    wait .05;
  }
  self OrientMode("face current");
  self notify("can_stop_turning");
}

isDeltaAllowed(theanim) {
  delta = getMoveDelta(theanim, 0, 1);
  endPoint = self localToWorldCoords(delta);
  return self isInGoal(endPoint) && self mayMoveToPoint(endPoint);
}

turn(direction, amount) {
  knowWhereToShoot = isDefined(self.shootPos);
  rate = 1;
  transTime = 0.2;
  mustFaceEnemy = (isDefined(self.enemy) && self canSee(self.enemy) && distanceSquared(self.enemy.origin, self.origin) < 512 * 512);
  if(self.a.scriptStartTime + 500 > gettime() || self is_zombie()) {
    transTime = 0.25;
    if(mustFaceEnemy)
      self thread faceEnemyImmediately();
  } else {
    if(mustFaceEnemy) {
      urgency = 1.0 - (distance(self.enemy.origin, self.origin) / 512);
      rate = 1 + urgency * 1;
      if(rate > 2)
        transTime = .05;
      else if(rate > 1.3)
        transTime = .1;
      else
        transTime = .15;
    }
  }
  angle = 0;
  if(amount > 157.5)
    angle = 180;
  else if(amount > 112.5)
    angle = 135;
  else if(amount > 67.5)
    angle = 90;
  else
    angle = 45;
  if(self is_zombie()) {
    self.isturning = true;
    wait(transTime);
    self.isturning = false;
  } else {
    animname = "turn_" + direction + "_" + angle;
    turnanim = animarray(animname);
    if(isDefined(self.node) && self.node.type == "Guard" && distanceSquared(self.origin, self.node.origin) < 16 * 16)
      self animmode("angle deltas");
    else if(isDeltaAllowed(turnanim))
      self animMode("zonly_physics");
    else
      self animmode("angle deltas");
    self setAnimKnobAll( % exposed_aiming, % body, 1, transTime);
    self.isturning = true;
    self _TurningAimingOn(transTime);
    self setAnimLimited( % turn, 1, transTime);
    self setFlaggedAnimKnobLimitedRestart("turn", turnanim, 1, 0, rate);
    self notify("turning");
    if(knowWhereToShoot)
      self thread shootWhileTurning();
    doTurnNotetracks();
    self setanimlimited( % turn, 0, .2);
    self _TurningAimingOff(.2);
    self clearanim( % turn, .2);
    self setanimknob( % exposed_aiming, 1, .2, 1);
    if(isDefined(self.turnLastResort)) {
      self.turnLastResort = undefined;
      self thread faceEnemyImmediately();
    }
    if(!self usingShotgun() && !self usingBoltActionWeapon())
      self clearAnim( % add_fire, .2);
    self animMode("zonly_physics");
    self notify("done turning");
    self.isturning = false;
  }
}

doTurnNotetracks() {
  self endon("turning_isnt_working");
  self endon("can_stop_turning");
  self thread makeSureTurnWorks();
  self animscripts\shared::DoNoteTracks("turn");
}

makeSureTurnWorks() {
  self endon("killanimscript");
  self endon("done turning");
  startAngle = self.angles[1];
  wait .3;
  if(self.angles[1] == startAngle) {
    self notify("turning_isnt_working");
    self.turnLastResort = true;
  }
}

_TurningAimingOn(transTime) {
  self setAnimLimited(animarray("straight_level"), 0, transTime);
  self setAnim( % add_idle, 0, transTime);
}

_TurningAimingOff(transTime) {
  self setAnimLimited(animarray("straight_level"), 1, transTime);
  self setAnim( % add_idle, 1, transTime);
}

shootWhileTurning() {
  self endon("killanimscript");
  self endon("done turning");
  if(self weaponAnims() == "rocketlauncher") {
    return;
  }
  self flamethrower_stop_shoot(250);
  shootUntilShootBehaviorChange();
  self flamethrower_stop_shoot();
  self clearAnim( % add_fire, .2);
}

shootUntilNeedToTurn() {
  self thread watchForNeedToTurnOrTimeout();
  self endon("need_to_turn");
  self thread keepTryingToMelee();
  shootUntilShootBehaviorChange();
  self flamethrower_stop_shoot();
  self notify("stop_watching_for_need_to_turn");
  self notify("stop_trying_to_melee");
}

watchForNeedToTurnOrTimeout() {
  self endon("killanimscript");
  self endon("stop_watching_for_need_to_turn");
  endtime = gettime() + 4000 + randomint(2000);
  while(1) {
    if(gettime() > endtime || needToTurn()) {
      self notify("need_to_turn");
      break;
    }
    wait .1;
  }
}

considerThrowGrenade() {
  if(!myGrenadeCoolDownElapsed())
    return false;
  self.a.nextGrenadeTryTime = gettime() + 300;
  players = GetPlayers();
  for(i = 0; i < players.size; i++) {
    if(isDefined(players[i]) && isDefined(players[i].throwGrenadeAtPlayerASAP) && isAlive(players[i])) {
      if(tryThrowGrenade(players[i], 200))
        return true;
    }
  }
  if(isDefined(self.enemy))
    return tryThrowGrenade(self.enemy, 850);
  return false;
}

tryThrowGrenade(throwAt, minDist) {
  if(self.team == "axis" && RandomInt(100) < 25)
    return false;
  threw = false;
  throwSpot = throwAt.origin;
  if(!self canSee(throwAt)) {
    if(isDefined(self.enemy) && throwAt == self.enemy && isDefined(self.shootPos))
      throwSpot = self.shootPos;
  }
  if(!self canSee(throwAt))
    minDist = 100;
  if(distanceSquared(self.origin, throwSpot) > minDist * minDist && self.a.pose == "stand") {
    yaw = GetYawToSpot(throwSpot);
    if(abs(yaw) < 60) {
      throwAnims = [];
      if(!isDefined(self.exposedSet) || self.exposedSet == 0) {
        if(isDeltaAllowed( % exposed_grenadeThrowB))
          throwAnims[throwAnims.size] = % exposed_grenadeThrowB;
        if(isDeltaAllowed( % exposed_grenadeThrowC))
          throwAnims[throwAnims.size] = % exposed_grenadeThrowC;
      } else {
        if(isDeltaAllowed( % exposed2_grenadeThrowB))
          throwAnims[throwAnims.size] = % exposed2_grenadeThrowB;
        if(isDeltaAllowed( % exposed2_grenadeThrowC))
          throwAnims[throwAnims.size] = % exposed2_grenadeThrowC;
      }
      if(throwAnims.size > 0) {
        self setanim( % exposed_aiming, 0, .1);
        self animMode("zonly_physics");
        setAnimAimWeight(0, 0);
        threw = TryGrenade(throwAt, throwAnims[randomint(throwAnims.size)]);
        self setanim( % exposed_aiming, 1, .1);
        if(threw)
          setAnimAimWeight(1, .5);
        else
          setAnimAimWeight(1, 0);
      }
    }
  }
  if(threw)
    self maps\_gameskill::didSomethingOtherThanShooting();
  return threw;
}

transitionTo(newPose) {
  if(newPose == self.a.pose) {
    return;
  }
  assert(!usingSidearm());
  self clearanim( % root, .3);
  self notify("kill_idle_thread");
  transAnim = animArray(self.a.pose + "_2_" + newPose);
  if(newPose == "stand")
    rate = 2;
  else
    rate = 1;
  if(self is_zombie()) {
    self setAnim( % add_idle);
    self thread idleThread();
    self maps\_gameskill::didSomethingOtherThanShooting();
    wait(0.1);
    return;
  }
  if(!animHasNoteTrack(transAnim, "anim_pose = \"" + newPose + "\"")) {
    println("error: " + self.a.pose + "_2_" + newPose + " missing notetrack to set pose!");
  }
  self setFlaggedAnimKnobAllRestart("trans", transanim, % body, 1, .2, rate);
  transTime = getAnimLength(transanim) / rate;
  playTime = transTime - 0.3;
  if(playTime < 0.2)
    playTime = 0.2;
  self animscripts\shared::DoNoteTracksForTime(playTime, "trans");
  self.a.pose = newPose;
  if(newPose == "stand")
    self set_animarray_standing();
  else if(newPose == "crouch")
    self set_animarray_crouching();
  self setAnimKnobAllRestart(animarray("straight_level"), % body, 1, .25);
  setupAim(.25);
  self setAnim( % add_idle);
  self thread idleThread();
  self maps\_gameskill::didSomethingOtherThanShooting();
}

keepTryingToMelee() {
  self endon("killanimscript");
  self endon("stop_trying_to_melee");
  self endon("done turning");
  self endon("need_to_turn");
  self endon("shoot_behavior_change");
  while(1) {
    wait .2 + randomfloat(.3);
    if(isDefined(self.enemy) && (distanceSquared(self.enemy.origin, self.origin) < 100 * 100) && TryMelee())
      return;
  }
}

TryMelee() {
  if(!isDefined(self.enemy))
    return false;
  if(distanceSquared(self.origin, self.enemy.origin) > 512 * 512)
    return false;
  if(self.a.pose == "prone")
    return false;
  if(self usingGasweapon()) {
    return false;
  }
  if(!NeedToReload(0)) {
    if(distanceSquared(self.enemy.origin, self.origin) > 200 * 200)
      return false;
  }
  canMelee = animscripts\melee::CanMeleeDesperate();
  if(!canMelee)
    return false;
  if(usingSidearm()) {
    if(self.pistolSwitchTime > gettime() && randomint(100) < 5) {
      switchToLastWeapon( % pistol_stand_switch);
    }
    return false;
  }
  if(self can_banzai_melee()) {
    self thread animscripts\banzai::banzai_attack();
  } else {
    self thread animscripts\melee::MeleeCombat();
    self notify("melee");
  }
  return true;
}

can_banzai_melee() {
  if(!isDefined(self.banzai) || !self.banzai)
    return false;
  if(!self maps\_bayonet::has_bayonet())
    return false;
  return !self.enemy animscripts\banzai::in_banzai_melee();
}

exposedReload(threshold) {
  if(NeedToReload(threshold)) {
    if(self usingGasWeapon()) {
      self animscripts\weaponList::RefillClip();
      return true;
    }
    self.a.exposedReloading = true;
    reloadAnim = animArrayPickRandom("reload");
    if(self.a.pose == "stand" && animArrayAnyExist("reload_crouchhide") && isDefined(self.enemy) && self canSee(self.enemy)) {
      if(!sightTracePassed(self.origin + (0, 0, 50), self.enemy getShootAtPos(), false, undefined))
        reloadAnim = animArrayPickRandom("reload_crouchhide");
    }
    self thread keepTryingToMelee();
    self setanim( % reload, 1, .2);
    self setanim( % exposed_aiming, 0, .2);
    self setanim( % rechamber, 0, .2);
    self.finishedReload = false;
    self doReloadAnim(reloadAnim, threshold > .05);
    self notify("abort_reload");
    if(self.finishedReload)
      self animscripts\weaponList::RefillClip();
    self setanimrestart( % exposed_aiming, 1, .2);
    self clearanim( % reload, .2);
    self notify("stop_trying_to_melee");
    self.a.exposedReloading = false;
    self maps\_gameskill::didSomethingOtherThanShooting();
    if(self usingBoltActionWeapon()) {
      wait 0.2;
    }
    return true;
  }
  return false;
}

doReloadAnim(reloadAnim, stopWhenCanShoot) {
  self endon("abort_reload");
  if(stopWhenCanShoot)
    self thread abortReloadWhenCanShoot();
  animRate = 1;
  flagName = "reload_" + getUniqueFlagNameIndex();
  self setflaggedanimknoballrestart(flagName, reloadAnim, % root, 1, .2, animRate);
  self thread notifyOnStartAim("abort_reload", flagName);
  self endon("start_aim");
  self animscripts\shared::DoNoteTracks(flagName);
  self.finishedReload = true;
}

abortReloadWhenCanShoot() {
  self endon("abort_reload");
  self endon("killanimscript");
  while(1) {
    if(isDefined(self.shootEnt) && self canSee(self.shootEnt)) {
      break;
    }
    wait .05;
  }
  self notify("abort_reload");
}

notifyOnStartAim(endonStr, flagName) {
  self endon(endonStr);
  self endon("killanimscript");
  self waittillmatch(flagName, "start_aim");
  self.finishedReload = true;
  self notify("start_aim");
}

finishNoteTracks(animname) {
  self endon("killanimscript");
  animscripts\shared::DoNoteTracks(animname);
}

drop_turret() {
  maps\_mgturret::dropTurret();
  self animscripts\weaponList::RefillClip();
  self.a.needsToRechamber = 0;
  self notify("dropped_gun");
  maps\_mgturret::restoreDefaults();
}

exception_exposed_mg42_portable() {
  drop_turret();
}

tryUsingSidearm() {
  if(self usingGasweapon()) {
    return false;
  }
  if(isDefined(self.secondaryWeapon) && weaponClass(self.secondaryweapon) == "spread")
    return false;
  if(randomint(100) < 85)
    return false;
  switchToSidearm( % pistol_stand_pullout);
  return true;
}

switchToSidearm(swapAnim) {
  self endon("killanimscript");
  assert(self.sidearm != "");
  self thread putGunBackInHandOnKillAnimScript();
  self.pistolSwitchTime = gettime() + 9000 + randomint(3000);
  self.swapAnim = swapAnim;
  self setFlaggedAnimKnobAllRestart("weapon swap", swapAnim, % body, 1, .2, 1);
  self DoNoteTracksPostCallbackWithEndon("weapon swap", ::handlePickup, "end_weapon_swap");
  self clearAnim(self.swapAnim, 0);
  self maps\_gameskill::didSomethingOtherThanShooting();
}

DoNoteTracksPostCallbackWithEndon(flagName, interceptFunction, endonMsg) {
  self endon(endonMsg);
  self animscripts\shared::DoNoteTracksPostCallback(flagName, interceptFunction);
}

faceEnemyDelay(delay) {
  self endon("killanimscript");
  wait delay;
  self faceEnemyImmediately();
}

handlePickup(notetrack) {
  if(notetrack == "pistol_pickup") {
    self clearAnim(animarray("straight_level"), 0);
    self set_animarray_standing();
    self thread faceEnemyDelay(0.25);
  } else if(notetrack == "start_aim") {
    if(self needToTurn()) {
      self notify("end_weapon_swap");
    } else {
      self setAnimLimited(animarray("straight_level"), 1, 0);
      setupAim(0);
      self setAnim( % exposed_aiming, 1, .2);
    }
  }
}

switchToLastWeapon(swapAnim) {
  self endon("killanimscript");
  assert(self.lastWeapon != getAISidearmWeapon());
  assert(self.lastWeapon == getAIPrimaryWeapon() || self.lastWeapon == getAISecondaryWeapon());
  self.swapAnim = swapAnim;
  self setFlaggedAnimKnobAllRestart("weapon swap", swapAnim, % body, 1, .1, 1);
  self DoNoteTracksPostCallbackWithEndon("weapon swap", ::handlePutaway, "end_weapon_swap");
  self clearAnim(self.swapAnim, 0);
  self maps\_gameskill::didSomethingOtherThanShooting();
}

handlePutaway(notetrack) {
  if(notetrack == "pistol_putaway") {
    self clearAnim(animarray("straight_level"), 0);
    self set_animarray_standing();
  } else if(notetrack == "start_aim") {
    if(self needToTurn()) {
      self notify("end_weapon_swap");
    } else {
      self setAnimLimited(animarray("straight_level"), 1, 0);
      setupAim(0);
      self setAnim( % exposed_aiming, 1, .2);
    }
  }
}

rpgDeath() {
  if(randomFloat(1) > 0.5)
    self SetFlaggedAnimKnobAll("deathanim", % RPG_stand_death, % root, 1, .05, 1);
  else
    self SetFlaggedAnimKnobAll("deathanim", % RPG_stand_death_stagger, % root, 1, .05, 1);
  self animscripts\shared::DoNoteTracks("deathanim");
  self animscripts\shared::DropAllAIWeapons();
  return;
}

ReacquireWhenNecessary() {
  self endon("killanimscript");
  self endon("melee");
  self.a.exposedReloading = false;
  self.a.lookForNewCoverTime = gettime() + randomintrange(800, 1500);
  if(self.fixedNode) {
    return;
  }
  while(1) {
    wait .05;
    if(self.fixedNode) {
      return;
    }
    TryExposedReacquire();
  }
}

ShouldFindCoverNearSelf() {
  if(gettime() < self.a.lookForNewCoverTime)
    return false;
  if(self canSee(self.enemy)) {
    if(isPlayer(self.enemy) && self.enemy.health < self.enemy.maxHealth * .8)
      return false;
    return self NeedToReload(.5);
  } else {
    if(self.reacquire_state <= 2)
      return false;
    if(self.a.exposedReloading)
      return false;
    return true;
  }
}

TryExposedReacquire() {
  if(!isValidEnemy(self.enemy)) {
    self.reacquire_state = 0;
    return;
  }
  if(self ShouldFindCoverNearSelf()) {
    if(self FindCoverNearSelf()) {
      self.reacquire_state = 0;
      return;
    }
  }
  if(self canSee(self.enemy)) {
    self.reacquire_state = 0;
    return;
  }
  if(self.a.exposedReloading && NeedToReload(.25) && self.enemy.health > self.enemy.maxhealth * .5) {
    self.reacquire_state = 0;
    return;
  }
  switch (self.reacquire_state) {
    case 0:
      if(self ReacquireStep(32)) {
        assert(self.reacquire_state == 0);
        return;
      }
      break;
    case 1:
      if(self ReacquireStep(64)) {
        self.reacquire_state = 0;
        return;
      }
      break;
    case 2:
      if(self ReacquireStep(96)) {
        self.reacquire_state = 0;
        return;
      }
      break;
    case 3:
      if(self.a.script != "combat") {
        self.reacquire_state = 0;
        return;
      }
      self FindReacquireNode();
      self.reacquire_state++;
    case 4:
      node = self GetReacquireNode();
      if(isDefined(node)) {
        oldKeepNodeInGoal = self.keepClaimedNodeInGoal;
        oldKeepNode = self.keepClaimedNode;
        self.keepClaimedNodeInGoal = false;
        self.keepClaimedNode = false;
        if(self UseReacquireNode(node)) {
          self.reacquire_state = 0;
        } else {
          self.keepClaimedNodeInGoal = oldKeepNodeInGoal;
          self.keepClaimedNode = oldKeepNode;
        }
        return;
      }
      break;
    case 5:
      if(tryRunningToEnemy(false)) {
        self.reacquire_state = 0;
        return;
      }
      break;
    default:
      assert(self.reacquire_state == 6);
      self.reacquire_state = 0;
      if(!(self canSee(self.enemy)))
        self FlagEnemyUnattackable();
      return;
  }
  self.reacquire_state++;
}

shouldGoToNode(node) {
  return true;
}

exposedRechamber() {
  if(self.a.pose != "prone") {
    self.a.isRechambering = 1;
    rechamber_anim = animArray("rechamber");
    self setanim( % rechamber, 1, .2);
    self thread animscripts\combat::faceEnemyDelay(0.1);
    self thread putGunBackInHandOnKillAnimScriptRechamber();
    self doRechamberAnim(rechamber_anim);
    self.a.needsToRechamber = 0;
    self.a.isRechambering = 0;
    self clearanim( % rechamber, .2);
    wait(0.2);
    if(isDefined(self.primaryweapon)) {
      animscripts\shared::placeWeaponOn(self.primaryweapon, "right");
    }
  }
  return true;
}

doRechamberAnim(rechamber_anim) {
  self endon("abort_rechamber");
  animRate = randomfloatrange(1.0, 1.4);
  flagName = "rechamber_" + getUniqueFlagNameIndex();
  self setFlaggedAnimKnobLimitedRestart(flagName, rechamber_anim, 1, 0, animRate);
  self thread notifyOnStartAim("abort_rechamber", flagName);
  self endon("start_aim");
  self animscripts\shared::DoNoteTracks(flagName);
}