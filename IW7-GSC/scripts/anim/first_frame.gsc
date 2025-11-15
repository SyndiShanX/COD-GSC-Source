/****************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\anim\first_frame.gsc
****************************************/

main() {
  self endon("death");
  self endon("stop_first_frame");
  self notify("killanimscript");
  self.closefile = 0;
  if(getdvarint("ai_iw7") == 1) {
    self clearanim(lib_0A1E::asm_getbodyknob(), 0.3);
  } else {
    self clearanim(self.var_E6E6, 0.3);
  }

  if(scripts\engine\utility::actor_is3d()) {
    self orientmode("face angle 3d", self.angles);
  } else {
    self orientmode("face angle", self.angles[1]);
  }

  self give_attacker_kill_rewards(self.var_1286, 1, 0, 0);
  self.var_1286 = undefined;
  self waittill("killanimscript");
}