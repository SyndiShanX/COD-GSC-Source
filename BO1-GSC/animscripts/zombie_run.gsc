/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\zombie_run.gsc
**************************************/

#include animscripts\zombie_utility;
#include animscripts\Combat_Utility;
#include animscripts\zombie_SetPoseMovement;
#include animscripts\debug;
#include common_scripts\utility;
#using_animtree("generic_human");
MoveRun() {
  desiredPose = self animscripts\zombie_utility::choosePose("stand");
  switch (desiredPose) {
    case "stand":
      if(BeginStandRun()) {
        return;
      }
      if(self animscripts\zombie_utility::IsInCombat()) {
        if(isDefined(self.run_combatanim)) {
          MoveStandCombatOverride();
        } else {
          MoveStandCombatNormal();
        }
      } else {
        if(isDefined(self.run_noncombatanim)) {
          MoveStandNoncombatOverride();
        } else {
          MoveStandNoncombatNormal();
        }
      }
      break;
    case "crouch":
      if(BeginCrouchRun()) {
        return;
      }
      if(isDefined(self.crouchrun_combatanim)) {
        MoveCrouchRunOverride();
      } else {
        MoveCrouchRunNormal();
      }
      break;
    default:
      break;
  }
}

GetRunAnim() {
  run_anim = undefined;
  if(isDefined(self.a.combatRunAnim)) {
    run_anim = self.a.combatRunAnim;
  } else {
    run_anim = % run_lowready_F;
  }
  assertex(isDefined(run_anim), "run.gsc - No run animation for this AI.");
  return run_anim;
}

GetCrouchRunAnim() {
  if(isDefined(self.a.crouchRunAnim)) {
    return self.a.crouchRunAnim;
  }
  return % crouch_fastwalk_F;
}

MoveStandCombatOverride() {
  if(isDefined(self.needs_run_update) && !self.needs_run_update) {
    wait(GetRunAnimUpdateFrequency());
    return;
  }
  self ClearAnim( % combatrun, 0.2);
  self SetAnimKnobAll( % combatrun, % body, 1, 0.2, self.moveplaybackrate);
  self SetFlaggedAnimKnob("runanim", self.run_combatanim, 1, 0.2, self.moveplaybackrate);
  animscripts\zombie_shared::DoNoteTracksForTime(getRunAnimUpdateFrequency(), "runanim");
  self.needs_run_update = false;
}

MoveStandCombatNormal() {
  self ClearAnim( % walk_and_run_loops, 0.2);
  self setanimknob( % combatrun, 1.0, 0.2, self.moveplaybackrate);
  decidedAnimation = false;
  if(isDefined(self.sprint) && self.sprint) {
    self SetFlaggedAnimKnob("runanim", % sprint1_loop, 1, 0.2, self.moveplaybackrate);
    decidedAnimation = true;
  }
  if(!decidedAnimation) {
    runAnim = GetRunAnim();
    self SetFlaggedAnimKnob("runanim", runAnim, 1, self.a.runBlendTime, self.moveplaybackrate);
  }
  useLeans = GetDvarInt(#"ai_useLeanRunAnimations");
  if(useLeans && self.isfacingmotion) {
    self UpdateRunWeightsOnce( %
      combatrun_forward, %
      run_lowready_B, %
      ai_run_lowready_f_lean_l, %
      ai_run_lowready_f_lean_r
    );
  } else {
    self UpdateRunWeightsOnce( %
      combatrun_forward, %
      run_lowready_B, %
      run_lowready_L, %
      run_lowready_R
    );
  }
  animscripts\zombie_shared::DoNoteTracksForTime(getRunAnimUpdateFrequency(), "runanim");
  self notify("stopRunning");
}

MoveStandNoncombatOverride() {
  self endon("movemode");
  if(isDefined(self.needs_run_update) && !self.needs_run_update) {
    wait(GetRunAnimUpdateFrequency());
    return;
  }
  self ClearAnim( % combatrun, 0.6);
  self SetFlaggedAnimKnobAll("runanim", self.run_noncombatanim, % body, 1, 0.2, self.moveplaybackrate);
  animscripts\zombie_shared::DoNoteTracksForTime(0.2, "runanim");
  self.needs_run_update = false;
}

MoveStandNoncombatNormal() {
  self endon("movemode");
  self ClearAnim( % combatrun, 0.6);
  self SetAnimKnobAll( % combatrun, % body, 1, 0.2, self.moveplaybackrate);
  prerunAnim = GetRunAnim();
  self SetFlaggedAnimKnob("runanim", prerunAnim, 1, 0.2);
  useLeans = GetDvarInt(#"ai_useLeanRunAnimations");
  if(useLeans && self.isfacingmotion) {
    self UpdateRunWeightsOnce( %
      combatrun_forward, %
      run_lowready_B, %
      ai_run_lowready_f_lean_l, %
      ai_run_lowready_f_lean_r
    );
  } else {
    self UpdateRunWeightsOnce( %
      combatrun_forward, %
      run_lowready_B, %
      run_lowready_L, %
      run_lowready_R
    );
  }
  animscripts\zombie_shared::DoNoteTracksForTime(getRunAnimUpdateFrequency(), "runanim");
}

MoveCrouchRunOverride() {
  self endon("movemode");
  if(isDefined(self.needs_run_update) && !self.needs_run_update) {
    wait(GetRunAnimUpdateFrequency());
    return;
  }
  self SetFlaggedAnimKnobAll("runanim", self.crouchrun_combatanim, % body, 1, 0.2, self.moveplaybackrate);
  animscripts\zombie_shared::DoNoteTracksForTime(0.2, "runanim");
  self.needs_run_update = false;
}

MoveCrouchRunNormal() {
  self endon("movemode");
  if(isDefined(self.needs_run_update) && !self.needs_run_update) {
    wait(GetRunAnimUpdateFrequency());
    return;
  }
  forward_anim = GetCrouchRunAnim();
  self setanimknob(forward_anim, 1, 0.2);
  animWeights = animscripts\zombie_utility::QuadrantAnimWeights(self getMotionAngle());
  self SetAnim(forward_anim, animWeights["front"], 0.2, 1);
  self SetAnim( % crouch_fastwalk_B, animWeights["back"], 0.2, 1);
  self SetAnim( % crouch_fastwalk_L, animWeights["left"], 0.2, 1);
  self SetAnim( % crouch_fastwalk_R, animWeights["right"], 0.2, 1);
  self SetFlaggedAnimKnobAll("runanim", % combatrun_forward, % body, 1, 0.2, self.moveplaybackrate);
  animscripts\zombie_shared::DoNoteTracksForTime(0.2, "runanim");
  self.needs_run_update = false;
}

runLoopIsNearBeginning() {
  animfraction = self getAnimTime( % walk_and_run_loops);
  loopLength = getAnimLength(animscripts\zombie_run::GetRunAnim()) / 3.0;
  animfraction *= 3.0;
  if(animfraction > 3) {
    animfraction -= 2.0;
  } else if(animfraction > 2) {
    animfraction -= 1.0;
  }
  if(animfraction < .15 / loopLength) {
    return true;
  }
  if(animfraction > 1 - .3 / loopLength) {
    return true;
  }
  return false;
}

UpdateRunWeights(notifyString, frontAnim, backAnim, leftAnim, rightAnim) {
  self endon("killanimscript");
  self endon(notifyString);
  if(GetTime() == self.a.scriptStartTime) {
    UpdateRunWeightsOnce(frontAnim, backAnim, leftAnim, rightAnim);
    wait 0.05;
  }
  for(;;) {
    UpdateRunWeightsOnce(frontAnim, backAnim, leftAnim, rightAnim);
    wait getRunAnimUpdateFrequency();
  }
}

GetLookaheadAngle() {
  yawDiff = VectorToAngles(self.lookaheaddir)[1] - self.angles[1];
  yawDiff = yawDiff * (1.0 / 360.0);
  yawDiff = (yawDiff - floor(yawDiff + 0.5)) * 360.0;
  return yawDiff;
}

UpdateRunWeightsOnce(frontAnim, backAnim, leftAnim, rightAnim) {
  blendTime = 0.2;
  rate = 1;
  yawDiff = 0;
  useLeans = GetDvarInt(#"ai_useLeanRunAnimations");
  if(isDefined(self.needs_run_update) && !self.needs_run_update) {
    wait(GetRunAnimUpdateFrequency());
    return;
  }
  if(useLeans && self.isfacingmotion) {
    yawDiff = self GetLookaheadAngle();
    animWeights = animscripts\zombie_utility::QuadrantAnimWeights(yawDiff);
    tempYawDiff = yawDiff;
    if(tempYawDiff < 0) {
      tempYawDiff *= -1;
    }
    minYaw = GetDvarFloat(#"ai_slowdownMinYawDiff");
    if(tempYawDiff >= minYaw) {
      maxYaw = GetDvarFloat(#"ai_slowdownMaxYawDiff");
      if(tempYawDiff > maxYaw) {
        tempYawDiff = maxYaw;
      }
      maxYaw -= minYaw;
      tempYawDiff -= minYaw;
      minRate = GetDvarFloat(#"ai_slowdownMinRate");
      rate = minRate + (1 - minRate) * ((maxYaw - tempYawDiff) / maxYaw);
    }
  } else {
    yawDiff = self getMotionAngle();
    animWeights = animscripts\zombie_utility::QuadrantAnimWeights(yawDiff);
  }
  if(isDefined(self.lastRunRate)) {
    rateBlendFactor = GetDvarFloat(#"ai_slowdownRateBlendFactor");
    rate = rate * rateBlendFactor + (1 - rateBlendFactor) * self.lastRunRate;
  }
  self.lastRunRate = rate;
  if(useLeans && animWeights["back"] > 0) {
    animWeights["left"] = 0;
    animWeights["right"] = 0;
    animWeights["back"] = 1;
  }
  self SetAnim(frontAnim, animWeights["front"], blendTime, rate);
  self SetAnim(backAnim, animWeights["back"], blendTime, rate);
  self SetAnim(leftAnim, animWeights["left"], blendTime, rate);
  self SetAnim(rightAnim, animWeights["right"], blendTime, rate);
  self.needs_run_update = false;
}

UpdateRunWeightsBiasForward(notifyString, frontAnim, backAnim, leftAnim, rightAnim) {
  self endon("killanimscript");
  self endon(notifyString);
  for(;;) {
    animWeights = animscripts\zombie_utility::QuadrantAnimWeights(self getMotionAngle());
    if(animWeights["front"] < .2) {
      animWeights["front"] = .2;
      if(animWeights["front"] < 0) {
        animWeights["left"] = 0.0;
        animWeights["right"] = 0.0;
      }
    }
    self SetAnim(frontAnim, animWeights["front"], 0.2, 1);
    self SetAnim(backAnim, 0.0, 0.2, 1);
    self SetAnim(leftAnim, animWeights["left"], 0.2, 1);
    self SetAnim(rightAnim, animWeights["right"], 0.2, 1);
    wait getRunAnimUpdateFrequency();
  }
}

MakeRunSounds(notifyString) {
  self endon("killanimscript");
  self endon(notifyString);
  for(;;) {
    wait .5;
    self playSound("fly_step_run_npc_concrete");
    wait .5;
    self playSound("fly_step_run_npc_concrete");
  }
}

getRunAnimUpdateFrequency() {
  return GetDvarFloat(#"ai_runAnimUpdateFrequency");
}