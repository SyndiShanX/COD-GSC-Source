/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\soldier\ground_turret.gsc
*************************************************/

#using scripts\asm\asm;
#using scripts\asm\soldier\death;
#using scripts\asm\soldier\pain;
#using scripts\common\ai;
#using scripts\engine\utility;
#namespace ground_turret;

function aigroundturret_shouldcompletedismount(asmname, statename, tostatename, params) {
  turret = self._blackboard.aigroundturretref;
  assert(isDefined(turret));
  turret cleartargetentity();
  return true;
}

function private disablegroundturret() {
  turret = self._blackboard.aigroundturretref;
  assert(isDefined(turret));
  turret.inuse = 0;
  turret setturretteam("neutral");
  turret setmode("manual");
  self stopuseturret();
}

function playanim_mountturret(asmname, statename, params) {
  turret = self._blackboard.aigroundturretref;
  assert(isDefined(turret));
  aigroundturret_mountcompleted();
  asm_playanimstate(asmname, statename, params);
}

function playanim_aioperateturret(asmname, statename, params) {
  turret = self._blackboard.aigroundturretref;
  assert(isDefined(turret));
  origin = turret gettagorigin("tag_gunner");
  angles = turret gettagangles("tag_gunner");

  if(self islinked()) {
    self unlink();
  }

  turret.inuse = 1;
  turret setturretteam(self.team);

  if(isDefined(turret.usemode)) {
    turret setmode(turret.usemode);
  } else {
    turret setmode("auto_nonai");
  }

  self forceteleport(origin, angles);
  self linktoblendtotag(turret, "tag_gunner", 0);
  self useturret(turret);
  asm_playanimstate(asmname, statename, params);
}

function playanim_aibegindismountturret(asmname, statename, params) {
  disablegroundturret();
  asm_playanimstate(asmname, statename, params);
}

function playanim_aidismountturret(asmname, statename, params) {
  if(self islinked()) {
    self unlink();
  }

  aigroundturret_dismountcompleted();
  asm_playanimstate(asmname, statename, params);
}

function playdeathanim_groundturret(asmname, statename, params) {
  turret = self._blackboard.aigroundturretref;

  if(isDefined(turret)) {
    turret.inuse = 0;
    turret setturretteam("neutral");
    turret setmode("manual");
  }

  playdeathanim(asmname, statename, params);
}

function playpainanim_groundturret(asmname, statename, params) {
  disablegroundturret();
  scripts\asm\soldier\pain::playpainanim(asmname, statename, params);
}