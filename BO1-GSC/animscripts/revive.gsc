/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\revive.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#include animscripts\Utility;
#include animscripts\Debug;
#include maps\_anim;
#using_animtree("generic_human");
precacheReviveModels() {
  if(isDefined(level.reviveFeature) && !level.reviveFeature)
    return;
  precacheModel("char_rus_bandages1");
}

revive_main() {
  anim.nextReviveSequenceTime = GetTime() + RandomIntRange(0, 20000);
  anim.nextReviveSequencePlayerTimeMin = 15000;
  anim.nextReviveSequencePlayerTimeMax = 30000;
  anim.nextReviveSequenceTimeMin = 5000;
  anim.nextReviveSequenceTimeMax = 10000;
  anim.bleederBleedOutTimeMin = 5000;
  anim.bleederBleedOutTimeMax = 10000;
  anim.reviverPingDist = 512;
  anim.reviverIgnorePlayerDistSq = 200 * 200;
  anim.reviveSequencePlayerVisibleDistSq = 1000 * 1000;
  anim.revive = [];
  anim.bleed["stand"]["fall"] = % ai_revive_wounded_onback_fall_stand;
  anim.bleed["crouch"]["fall"] = % ai_revive_wounded_onback_fall_crouch;
  anim.bleed["prone"]["fall"] = % ai_dying_crawl_2_back_revive;
  anim.bleed["bleed_loop"] = % ai_revive_wounded_onback_loop;
  anim.bleed["left"]["being_revived"] = % ai_revive_wounded_onback_left_revive;
  anim.bleed["left"]["get_up"] = % ai_revive_wounded_onback_left_get_up;
  anim.revive["left"]["reviving"] = % ai_revive_reviver_onback_left_revive;
  anim.revive["left"]["get_up"] = % ai_revive_reviver_onback_left_get_up;
}

revive_init() {
  self.a.revivedOnce = false;
  self.a.reviveMe = false;
  self.a.falling = false;
  self.a.bleeding = false;
  self.a.isReviver = false;
  self.a.isReviving = false;
  self.a.canBleed = true;
  self.a.canRevive = true;
  self.a.reviver = undefined;
  self.a.bleeder = undefined;
  self.a.oldRevivers = [];
}

tryGoingDown(damage, hitloc) {
  Assert(isDefined(level.reviveFeature), "level.reviveFeature is not initialized.");
  if(!level.reviveFeature)
    return false;
  if(!GetDvarInt(#"scr_aiReviveFeature")) {
    if(!shouldReviveSequenceHappen())
      return false;
  }
  if(!IsAI(self) || !IsAlive(self) || (self.isdog) || (self.team != "axis") || (self.a.canBleed == false) || (self.a.pose == "back"))
    return false;
  if(self.a.pose == "prone")
    return false;
  if(isDefined(self.a.usingTurret))
    return false;
  if(!GetDvarInt(#"scr_aiReviveFeature")) {
    friendlies = GetAIArray(self.team);
    alive_nearby_ai = get_array_of_closest(self.origin, friendlies, undefined, undefined, anim.reviverPingDist);
    if(alive_nearby_ai.size <= 2)
      return false;
  }
  if((self.a.isreviver == false) && (self.a.revivedOnce == false) && (self.a.reviveMe == false) && isAIDamageFatal(damage) && !damageLocation(hitloc)) {
    if(!IsReviveOnSafeTerrain())
      return false;
    Assert(IsAlive(self) == true, "AI is already dead or in extended death and cant be put down.");
    self.a.reviveMe = true;
    self thread killMeOnScriptInterrupt();
    self.health = self.health + damage + RandomIntRange(60, 100);
    return true;
  }
  return false;
}

killMeOnScriptInterrupt() {
  self endon("death");
  self waittill("killanimscript");
  self waittill("killanimscript");
  if(self isBleeder() && IsAlive(self)) {
    self DoDamage(self.health + 200, self.origin);
  }
}

revive_strat() {
  self endon("death");
  self endon("killanimscript");
  self thread bleeder_bleed_to_death();
  self thread fall_down_to_bleed();
  self waittill("ready_after_revived");
}

reviver_selection_think(team) {
  self endon("death");
  self endon("revived");
  self endon("reevaluate_reviver");
  self endon("killanimscript");
  Assert(IsAlive(self) == true, "AI is already dead or in extended death and cant be put down.");
  if(self.a.revivedOnce != true) {
    self waittill_players_goes_away();
    reviver_found = false;
    while(!reviver_found) {
      friendlies = GetAIArray(self.team);
      if(self.a.oldRevivers.size > 0)
        ai = get_array_of_closest(self.origin, friendlies, self.a.oldRevivers, undefined, anim.reviverPingDist);
      else
        ai = get_array_of_closest(self.origin, friendlies, undefined, undefined, anim.reviverPingDist);
      for(i = 0; i < ai.size; i++) {
        current_ai = ai[i];
        if(isAIOldReviver(current_ai) || (current_ai.a.canRevive == false))
          continue;
        if(isDefined(current_ai.ignoreall) && current_ai.ignoreall == true)
          continue;
        if((current_ai != self) && isDefined(current_ai.a.revivedOnce) && (current_ai.a.reviveMe == false) && (current_ai.a.isReviver == false)) {
          AssertEx(isDefined(self.predictedRevivePoint), "Predicted revive point is not calculated.");
          if(findpath(current_ai.origin, self.predictedRevivePoint)) {
            reviver_found = true;
            self.a.oldRevivers[self.a.oldRevivers.size] = current_ai;
            self.a.reviver = current_ai;
            current_ai.a.bleeder = self;
            self thread revive_process();
            break;
          }
        }
      }
      if(!reviver_found)
        wait(2);
    }
  }
}

revive_process() {
  self endon("death");
  self.a.reviver thread reviver_think();
  self thread handle_bleeder_death();
  self.a.reviver thread handle_reviver_death();
}

waittill_players_goes_away() {
  while(IsAlive(self)) {
    player = get_closest_player(self.origin);
    if(distanceSquared(player.origin, self.origin) > anim.reviverIgnorePlayerDistSq) {
      break;
    }
    wait(1);
  }
}

handle_reviver_death() {
  self endon("revive_complete");
  self endon("bleeder_death");
  self waittill_any("death");
  self free_reviver("death");
  wait(0.05);
  if(isDefined(self.a.bleeder) && IsAlive(self.a.bleeder)) {
    if(self.a.revivedOnce) {
      self.a.bleeder thread bleeder_getup();
    } else {
      self.a.bleeder play_bleed_loop();
      self.a.bleeder thread reviver_selection_think(self.a.bleeder.team);
    }
  }
}

handle_reviver_goal_change() {
  self endon("revive_complete");
  self endon("bleeder_death");
  self endon("reevaluate_reviver");
  self endon("reviving_bleeder");
  self waittill_any("goalradius_changed");
  self free_reviver("goalradius_changed");
  wait(0.05);
  if(isDefined(self.a.bleeder) && IsAlive(self.a.bleeder)) {
    if(self.a.revivedOnce)
      self.a.bleeder thread bleeder_getup();
    else
      self.a.bleeder thread reviver_selection_think(self.a.bleeder.team);
  }
}

handle_bleeder_death(reviver) {
  self endon("revived");
  self endon("reevaluate_reviver");
  self waittill("death");
  self.a.reviver notify("bleeder_death");
  self.a.reviver free_reviver("bleeder_death");
}

reviver_think() {
  self endon("death");
  self endon("bleeder_death");
  self endon("reevaluate_reviver");
  self.a.isReviver = true;
  while(!self.a.bleeder.a.bleeding) {
    wait(0.05);
  }
  self.ReviveOldgoalradius = self.goalradius;
  self.goalradius = 4;
  self thread handle_reviver_goal_change();
  revive_anim = getReviverReviveAnim();
  approach_angle = GetStartAngles(self.a.bleeder.origin, self.a.bleeder.angles, revive_anim);
  revive_point = getRevivePoint(self.a.bleeder);
  self SetGoalPos(revive_point, approach_angle);
  self waittill("goal");
  self reviver_revive(revive_anim, revive_point);
}

free_reviver(reason) {
  self endon("death");
  if(isDefined(self)) {
    self.a.isReviver = false;
    self.a.isReviving = false;
    self.ignoreme = false;
    if(isDefined(reason) && ((reason == "death") || (reason == "goalradius_changed"))) {
      self notify("reevaluate_reviver");
      self.a.bleeder notify("reevaluate_reviver");
    }
    if(isDefined(self.ReviveOldgoalradius))
      self.goalradius = self.ReviveOldgoalradius;
    if(IsAlive(self) && isDefined(reason) && reason != "death") {
      self notify("killanimscript");
      waittillframeend;
      self thread call_overloaded_func("animscripts\combat", "main");
    }
  }
}

free_bleeder() {
  self endon("death");
  if(isDefined(self)) {
    self.a.reviveMe = false;
    self.a.bleeding = false;
    self.a.falling = false;
    self.health = RandomIntRange(90, 120);
    self notify("ready_after_revived");
    if(isDefined(self.a.special) && self.a.special == "bleeder_death")
      self.a.special = "none";
    if(IsAlive(self)) {
      self notify("killanimscript");
      waittillframeend;
      self thread call_overloaded_func("animscripts\combat", "main");
    }
  }
}

reviver_revive(revive_anim, revive_point) {
  self endon("bleeder_death");
  self.a.isReviving = true;
  bleeder = self.a.bleeder;
  bleeder notify("being_revived");
  self notify("reviving_bleeder");
  self.ignoreme = true;
  resetReviveSequenceTimer();
  bleeder SetFlaggedAnimKnob("being_revived", getBleederReviveAnim(), 1, 0.1, 1);
  self AnimScripted("revive", bleeder.origin, bleeder.angles, revive_anim, "normal", %body, 1);
  self animscripts\shared::DoNoteTracks("revive", ::handleReviverNotetracks);
  self notify("revive_complete");
  self revive_getup_process();
}

revive_getup_process() {
  self.a.bleeder thread bleeder_getup();
  self animcustom(::reviver_getup);
}

bleeder_getup() {
  self SetFlaggedAnimKnobAllRestart("bleeder_get_up", getBleederGetUpAnim(), %body, 1, 0.1, 1.0);
  self animscripts\shared::DoNoteTracks("bleeder_get_up");
  self free_bleeder();
}

reviver_getup() {
  self SetFlaggedAnimKnobAllRestart("reviver_get_up", getReviverGetUpAnim(), %body, 1, 0.1, 1.0);
  self animscripts\shared::DoNoteTracks("reviver_get_up");
  self free_reviver("revive_complete");
}

bleeder_bleed_to_death() {
  self endon("revived");
  self.bleedOutTime = RandomIntRange(anim.bleederBleedOutTimeMin, anim.bleederBleedOutTimeMax);
  wait(self.bleedOutTime / 1000);
  if(isDefined(self) && IsAlive(self))
    self DoDamage(self.health + 200, self.origin);
}

fall_down_to_bleed() {
  self endon("death");
  self endon("revived");
  self endon("being_revived");
  self endon("killanimscript");
  self SetAnimKnobAll(%revive, %body, 1, 0.1, 1);
  transAnim = getTransitionAnim();
  self.a.falling = true;
  self SetFlaggedAnimKnob("fall_transition", transAnim, 1, 0.1, 1.5);
  self thread handleBleederNotetracks("fall_transition");
  self animscripts\shared::DoNoteTracks("fall_transition");
  Assert(self.a.pose == "back", "Fall transition animation is missing the anim_pose = back notetrack.");
  self ClearAnim(transAnim, 0.2);
  self.a.bleeding = true;
  self play_bleed_loop();
}

play_bleed_loop() {
  self SetFlaggedAnimKnobAllRestart("bleeding", getBleedLoopAnim(), %body, 1, 0.1, 1.0);
}

handleBleederNotetracks(anim_name) {
  self endon("death");
  for(;;) {
    self waittill(anim_name, note);
    switch (note) {
      case "reviver_selection": {
        self thread reviver_selection_think(self.team);
        break;
      }
      case "anim_pose = \"back\"": {
        self.a.special = "bleeder_death";
        break;
      }
    }
    if(note == "end") {
      break;
    }
  }
}

handleReviverNotetracks(note) {
  switch (note) {
    case "attach_bandage": {
      bleeder = self.a.bleeder;
      bleeder Attach("char_rus_bandages1");
      bleeder.a.revivedOnce = true;
      bleeder notify("revived");
      break;
    }
  }
}

getTransitionAnim() {
  assert(self.a.pose == "stand" || self.a.pose == "crouch" || self.a.pose == "prone");
  transitionAnim = anim.bleed[self.a.pose]["fall"];
  Assert(animHasNoteTrack(transitionAnim, "anim_pose = \"back\""));
  Assert(animHasNoteTrack(transitionAnim, "reviver_selection"));
  return transitionAnim;
}

getBleedLoopAnim() {
  bleedLoopAnim = anim.bleed["bleed_loop"];
  return bleedLoopAnim;
}

getBleederReviveAnim() {
  reviveAnim = anim.bleed["left"]["being_revived"];
  return reviveAnim;
}

getReviverReviveAnim() {
  reviveAnim = anim.revive["left"]["reviving"];
  Assert(animHasNoteTrack(reviveAnim, "anim_pose = \"crouch\""));
  Assert(animHasNoteTrack(reviveAnim, "attach_bandage"));
  return reviveAnim;
}

getBleederGetUpAnim() {
  bleederGetUpAnim = anim.bleed["left"]["get_up"];
  Assert(animHasNoteTrack(bleederGetUpAnim, "anim_pose = \"stand\""));
  return bleederGetUpAnim;
}

getReviverGetUpAnim() {
  reviverGetUpAnim = anim.revive["left"]["get_up"];
  Assert(animHasNoteTrack(reviverGetUpAnim, "anim_pose = \"stand\""));
  return reviverGetUpAnim;
}

damageLocation(hitloc) {
  if(hitloc == "helmet" || hitloc == "head")
    return true;
  return false;
}

isAIOldReviver(ai) {
  if(self.a.oldRevivers.size > 0) {
    for(i = 0; i < self.a.oldRevivers.size; i++) {
      if(isDefined(self.a.oldRevivers[i]) && self.a.oldRevivers[i] == ai)
        return true;
    }
  }
  return false;
}

getRevivePoint(bleeder) {
  revive_point = GetStartOrigin(bleeder.origin, bleeder.angles, getReviverReviveAnim());
  return revive_point;
}

IsReviveOnSafeTerrain() {
  self endon("death");
  groundPos = physicstrace(self.origin, self.origin - (0, 0, 10000));
  bleederDistanceFromGround = distance(self.origin, groundPos);
  if((bleederDistanceFromGround > 2) || (bleederDistanceFromGround < 0))
    return false;
  angleDelta = getAngleDelta(anim.bleed[self.a.pose]["fall"], 0, 1);
  finalYaw = self.angles[1] + angleDelta;
  finalAngles = (self.angles[0], finalYaw, self.angles[2]);
  moveDelta = GetMoveDelta(anim.bleed[self.a.pose]["fall"], 0, 1);
  endPoint = self localToWorldCoords(moveDelta);
  if(!self mayMoveToPoint(endPoint))
    return false;
  self.predictedRevivePoint = getPredictedRevivePoint(endPoint, finalAngles);
  groundPos = physicstrace(self.predictedRevivePoint, self.predictedRevivePoint - (0, 0, 10000));
  revivePointDistanceFromGround = distance(self.predictedRevivePoint, groundPos);
  if(revivePointDistanceFromGround < 0 || revivePointDistanceFromGround > 15)
    return false;
  diff = abs(bleederDistanceFromGround - revivePointDistanceFromGround);
  if(diff > 15)
    return false;
  return true;
}

getPredictedRevivePoint(endPoint, finalAngles) {
  revive_point = GetStartOrigin(endPoint, finalAngles, getReviverReviveAnim());
  return revive_point;
}

isAIDamageFatal(damage) {
  Assert(IsAlive(self) == true, "AI is already dead or in extended death and cant be put down.");
  health = self.health - damage;
  if(health <= 0)
    return true;
  return false;
}

shouldBleed() {
  self endon("death");
  Assert(IsAlive(self) == true, "AI is already dead or in extended death and cant be put down.");
  Assert(IsAlive(self.a.revivedOnce) == false, "AI is already revived/bleeded once.");
  if((self.a.reviveMe == true) && (self.a.bleeding == false) && (self.a.falling == false))
    return true;
  return false;
}

isBleedingOrFalling() {
  Assert(IsAlive(self) == true, "AI is already dead or in extended death and cant be put down.");
  if((self.a.bleeding == true) || (self.a.falling == true))
    return true;
  return false;
}

shouldReviveSequenceHappen() {
  if(GetTime() < anim.nextReviveSequenceTime) {
    return false;
  }
  if((randomInt(100) > 40))
    return false;
  return true;
}

resetReviveSequenceTimer() {
  players = GetPlayers();
  anybody_nearby = 0;
  for(i = 0; i < players.size; i++) {
    if(isDefined(players[i]) && distanceSquared(self.origin, players[i].origin) < anim.reviveSequencePlayerVisibleDistSq) {
      anybody_nearby = 1;
      break;
    }
  }
  if(anybody_nearby) {
    anim.nextReviveSequenceTime = GetTime() + RandomIntRange(anim.nextReviveSequencePlayerTimeMin, anim.nextReviveSequencePlayerTimeMax);
  } else {
    anim.nextReviveSequenceTime = GetTime() + RandomIntRange(anim.nextReviveSequenceTimeMin, anim.nextReviveSequenceTimeMax);
  }
}

isReviverOrBleeder() {
  if(isDefined(self) &IsAI(self)) {
    if(self.a.isReviver || self.a.reviveMe)
      return true;
  }
  return false;
}

isBleeder() {
  if(isDefined(self) &IsAI(self)) {
    if(self.a.reviveMe)
      return true;
  }
  return false;
}