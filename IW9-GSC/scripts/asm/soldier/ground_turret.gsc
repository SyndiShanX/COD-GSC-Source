/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\soldier\ground_turret.gsc
*************************************************/

aigroundturret_shouldcompletedismount(asmname, statename, _id_F2B19B25D457C2A6, params) {
  turret = self._blackboard.aigroundturretref;
  turret cleartargetentity();
  return 1;
}

_id_9808F5689A4A7B1A() {
  turret = self._blackboard.aigroundturretref;
  turret.inuse = 0;
  turret setturretteam("neutral");
  turret setmode("manual");
  self stopuseturret();
}

playanim_mountturret(asmname, statename, params) {
  turret = self._blackboard.aigroundturretref;
  scripts\common\ai::aigroundturret_mountcompleted();
  scripts\asm\asm::asm_playanimstate(asmname, statename, params);
}

playanim_aioperateturret(asmname, statename, params) {
  turret = self._blackboard.aigroundturretref;
  origin = turret gettagorigin("tag_gunner");
  angles = turret gettagangles("tag_gunner");

  if(self islinked())
    self unlink();

  turret.inuse = 1;
  turret setturretteam(self.team);

  if(isDefined(turret._id_B81564300A56532B))
    turret setmode(turret._id_B81564300A56532B);
  else
    turret setmode("auto_nonai");

  self forceteleport(origin, angles);
  self linktoblendtotag(turret, "tag_gunner", 0);
  self useturret(turret);
  scripts\asm\asm::asm_playanimstate(asmname, statename, params);
}

playanim_aibegindismountturret(asmname, statename, params) {
  _id_9808F5689A4A7B1A();
  scripts\asm\asm::asm_playanimstate(asmname, statename, params);
}

playanim_aidismountturret(asmname, statename, params) {
  if(self islinked())
    self unlink();

  scripts\common\ai::aigroundturret_dismountcompleted();
  scripts\asm\asm::asm_playanimstate(asmname, statename, params);
}

playdeathanim_groundturret(asmname, statename, params) {
  turret = self._blackboard.aigroundturretref;

  if(isDefined(turret)) {
    turret.inuse = 0;
    turret setturretteam("neutral");
    turret setmode("manual");
  }

  scripts\asm\soldier\death::playdeathanim(asmname, statename, params);
}

_id_E41FEA1DF987324A(asmname, statename, params) {
  _id_9808F5689A4A7B1A();
  scripts\asm\soldier\pain::playpainanim(asmname, statename, params);
}