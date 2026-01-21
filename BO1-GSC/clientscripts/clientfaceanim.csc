/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\clientfaceanim.csc
********************************************/

#include clientscripts\_face_utility;
#include clientscripts\_utility;

actor_flag_change_handler(localClientNum, flag, set, newEnt) {
  if(flag == 1) {
    if(set) {
      self.face_disable = true;
      self notify("face", "face_advance");
    } else {
      self.face_disable = false;
      self notify("face", "face_advance");
    }
  }
}
init_clientfaceanim() {
  level._faceAnimCBFunc = clientscripts\_clientfaceanim::doFace;
}
doFace(localClientNum) {
  while(true) {
    if(self IsPlayer()) {
      doFace_player(localClientNum);
      self waittill("respawn");
      while(!isDefined(self)) {
        wait(0.05);
      }
      self.face_death = false;
      self.face_disable = false;
    } else {
      return;
    }
  }
}
#using_animtree("multiplayer");
doFace_player(localClientNum) {
  level.face_anim_tree = "multiplayer";
  self setFaceRoot(%head);
  self buildFaceState("face_casual", true, -1, 0, "basestate", %pf_casual_idle);
  self buildFaceState("face_alert", true, -1, 0, "basestate", %pf_alert_idle);
  self buildFaceState("face_shoot", true, 1, 1, "eventstate", %pf_firing);
  self buildFaceState("face_shoot_single", true, 1, 1, "eventstate", %pf_firing);
  self buildFaceState("face_melee", true, 2, 1, "eventstate", %pf_melee);
  self buildFaceState("face_pain", false, -1, 2, "eventstate", %pf_pain);
  self buildFaceState("face_death", false, -1, 2, "exitstate", %pf_death);
  self buildFaceState("face_advance", false, -1, 3, "nullstate", undefined);
  PrintLn("Starting Client Face Anims");
  self thread processFaceEvents(localClientNum);
}
do_corpse_face_hack(localClientNum) {
  if(isDefined(self) && isDefined(level.face_anim_tree) && isDefined(level.faceStates)) {
    numAnims = level.faceStates["face_death"]["animation"].size;
    if(!isDefined(self))
      return;
    self SetAnimKnob(level.faceStates["face_death"]["animation"][RandomInt(numAnims)], 1.0, 0.1, 1.0);
  }
}