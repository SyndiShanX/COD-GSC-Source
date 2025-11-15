/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\agents\dog\_dog_traverse.gsc
************************************************/

#include maps\mp\agents\_scriptedAgents;

main() {
  self endon("killanimscript");

  if(!isDefined(level.dogTraverseAnims))
    InitDogTraverseAnims();

  startNode = self GetNegotiationStartNode();
  endNode = self GetNegotiationEndNode();
  assert(isDefined(startNode) && isDefined(endNode));

  animState = undefined;

  animState = level.dogTraverseAnims[startNode.animscript];

  if(!isDefined(animState)) {
    assertmsg("no animation for traverse " + startNode.animscript);
    return;
  }

  self.bLockGoalPos = true;

  startToEnd = endNode.origin - startNode.origin;
  startToEnd2D = (startToEnd[0], startToEnd[1], 0);
  anglesToEnd = VectorToAngles(startToEnd2D);

  self ScrAgentSetOrientMode("face angle abs", anglesToEnd);
  self ScrAgentSetAnimMode("anim deltas");

  traverseAnim = self GetAnimEntry(animState, 0);

  codeMoveNotetracks = GetNotetrackTimes(traverseAnim, "code_move");
  if(codeMoveNotetracks.size > 0)
    moveDelta = GetMoveDelta(traverseAnim, 0, codeMoveNotetracks[0]);
  else
    moveDelta = GetMoveDelta(traverseAnim, 0, 1);

  scaleFactors = GetAnimScaleFactors(startToEnd, moveDelta);

  self ScrAgentSetPhysicsMode("noclip");

  if(startToEnd[2] > 0) {
    if(moveDelta[2] > 0) {
      jumpStartNotetracks = GetNotetrackTimes(traverseAnim, "traverse_jump_start");
      if(jumpStartNotetracks.size > 0) {
        xyScale = 1;
        zScale = 1;
        if(Length2DSquared(startToEnd2D) < 0.8 * 0.8 * Length2DSquared(moveDelta))
          xyScale = 0.4;
        if(startToEnd[2] < 0.75 * moveDelta[2])
          zScale = 0.5;

        self ScrAgentSetAnimScale(xyScale, zScale);

        self PlayAnimNUntilNotetrack(animState, 0, "traverse", "traverse_jump_start");
        jumpEndNotetracks = GetNotetrackTimes(traverseAnim, "traverse_jump_end");
        assert(jumpEndNotetracks.size > 0);
        jumpStartMoveDelta = GetMoveDelta(traverseAnim, 0, jumpStartNotetracks[0]);
        jumpEndMoveDelta = GetMoveDelta(traverseAnim, 0, jumpEndNotetracks[0]);

        xyScale = 1;
        zScale = 1;
        currentToEnd = endNode.origin - self.origin;
        animToEnd = moveDelta - jumpStartMoveDelta;
        if(Length2DSquared(currentToEnd) < 0.75 * 0.75 * Length2DSquared(animToEnd))
          xyScale = 0.75;
        if(currentToEnd[2] < 0.75 * animToEnd[2])
          zScale = 0.75;

        animJumpEndToEnd = moveDelta - jumpEndMoveDelta;
        scaledAnimJumpEndToEnd = (animJumpEndToEnd[0] * xyScale, animJumpEndToEnd[1] * xyScale, animJumpEndToEnd[2] * zScale);
        worldAnimJumpEndToEnd = RotateVector(scaledAnimJumpEndToEnd, anglesToEnd);
        nodeJumpEndPos = endNode.origin - worldAnimJumpEndToEnd;

        animJumpStartToJumpEnd = jumpEndMoveDelta - jumpStartMoveDelta;
        worldAnimJumpStartToJumpEnd = RotateVector(animJumpStartToJumpEnd, anglesToEnd);
        currentToNodeJumpEnd = nodeJumpEndPos - self.origin;

        scaleFactors = GetAnimScaleFactors(currentToNodeJumpEnd, worldAnimJumpStartToJumpEnd, true);
        self ScrAgentSetAnimScale(scaleFactors.xy, scaleFactors.z);
        self WaitUntilNotetrack("traverse", "traverse_jump_end");

        self ScrAgentSetAnimScale(xyScale, zScale);
        self WaitUntilNotetrack("traverse", "code_move");
      } else {
        self ScrAgentSetAnimScale(scaleFactors.xy, scaleFactors.z);
        self PlayAnimNUntilNotetrack(animState, 0, "traverse");
      }
    } else {
      gravityOnNotetracks = GetNotetrackTimes(traverseAnim, "gravity on");
      if(gravityOnNotetracks.size > 0) {
        targetEntPos = startNode GetTargetEntPos();
        if(isDefined(targetEntPos)) {
          startToTarget = targetEntPos - self.origin;
          targetToEnd = endNode.origin - targetEntPos;

          startDelta = GetMoveDelta(traverseAnim, 0, gravityOnNotetracks[0]);
          scaleFactors = self GetAnimScaleFactors(startToTarget, startDelta);

          self ScrAgentSetAnimScale(scaleFactors.xy, scaleFactors.z);
          self PlayAnimNUntilNotetrack(animState, 0, "traverse", "gravity on");

          endDelta = GetMoveDelta(traverseAnim, gravityOnNotetracks[0], 1);
          scaleFactors = self GetAnimScaleFactors(targetToEnd, endDelta);

          self ScrAgentSetAnimScale(scaleFactors.xy, scaleFactors.z);
          self WaitUntilNotetrack("traverse", "code_move");

          return;
        }
      }
      animLength = GetAnimLength(traverseAnim);
      self ScrAgentDoAnimLerp(startNode.origin, endNode.origin, animLength);
      self PlayAnimNUntilNotetrack(animState, 0, "traverse");
    }
  } else {
    gravityOnNotetracks = GetNotetrackTimes(traverseAnim, "gravity on");
    if(gravityOnNotetracks.size > 0) {
      self ScrAgentSetAnimScale(scaleFactors.xy, 1);
      self PlayAnimNUntilNotetrack(animState, 0, "traverse", "gravity on");

      gravityOnMoveDelta = GetMoveDelta(traverseAnim, 0, gravityOnNotetracks[0]);
      zAnimDelta = gravityOnMoveDelta[2] - moveDelta[2];

      if(abs(zAnimDelta) > 0) {
        zMeToEnd = self.origin[2] - endNode.origin[2];

        zScale = zMeToEnd / zAnimDelta;
        assert(zScale > 0);

        self ScrAgentSetAnimScale(scaleFactors.xy, zScale);

        animrate = Clamp(2 / zScale, 0.5, 1);

        norestart = animState + "_norestart";
        self SetAnimState(norestart, 0, animrate);
      }

      self WaitUntilNotetrack("traverse", "code_move");
    } else {
      self ScrAgentSetAnimScale(scaleFactors.xy, scaleFactors.z);

      animrate = Clamp(2 / scaleFactors.z, 0.5, 1);

      jumpEndNotetracks = GetNotetrackTimes(traverseAnim, "traverse_jump_end");
      if(jumpEndNotetracks.size > 0) {
        self PlayAnimNAtRateUntilNotetrack(animState, 0, animrate, "traverse", "traverse_jump_end");
        norestart = animState + "_norestart";
        self SetAnimState(norestart, 0, 1);
        self WaitUntilNotetrack("traverse", "code_move");
      } else {
        self PlayAnimNUntilNotetrack(animState, 0, "traverse");
      }

    }

    self ScrAgentSetAnimScale(1, 1);
  }
}

end_script() {
  self ScrAgentSetAnimScale(1, 1);
  self.bLockGoalPos = false;
}

GetTargetEntPos() {
  if(isDefined(self.targetEntPos))
    return self.targetEntPos;

  targetEnt = GetEnt(self.target, "targetname");
  if(!isDefined(targetEnt))
    return undefined;

  self.targetEntPos = targetEnt.origin;
  targetEnt delete();
  return self.targetEntPos;
}

InitDogTraverseAnims() {
  level.dogTraverseAnims = [];

  level.dogTraverseAnims["hjk_tree_hop"] = "traverse_jump_over_24";
  level.dogTraverseAnims["jump_across_72"] = "traverse_jump_over_24";
  level.dogTraverseAnims["wall_hop"] = "traverse_jump_over_36";
  level.dogTraverseAnims["window_2"] = "traverse_jump_over_36";
  level.dogTraverseAnims["wall_over_40"] = "traverse_jump_over_36";
  level.dogTraverseAnims["wall_over"] = "traverse_jump_over_36";
  level.dogTraverseAnims["window_divethrough_36"] = "traverse_jump_over_36";
  level.dogTraverseAnims["window_over_40"] = "traverse_jump_over_36";
  level.dogTraverseAnims["window_over_quick"] = "traverse_jump_over_36";
  level.dogTraverseAnims["jump_up_80"] = "traverse_jump_up_70";
  level.dogTraverseAnims["jump_standing_80"] = "traverse_jump_up_70";
  level.dogTraverseAnims["jump_down_80"] = "traverse_jump_down_70";
  level.dogTraverseAnims["jump_up_40"] = "traverse_jump_up_40";
  level.dogTraverseAnims["jump_down_40"] = "traverse_jump_down_40";
  level.dogTraverseAnims["step_up"] = "traverse_jump_up_24";
  level.dogTraverseAnims["step_up_24"] = "traverse_jump_up_24";
  level.dogTraverseAnims["step_down"] = "traverse_jump_down_24";
  level.dogTraverseAnims["jump_down"] = "traverse_jump_down_24";
  level.dogTraverseAnims["jump_across"] = "traverse_jump_over_36";
  level.dogTraverseAnims["jump_across_100"] = "traverse_jump_over_36";
}