/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: anim\first_frame.gsc
***********************************************/

main() {
  self endon("death");
  self endon("stop_first_frame");
  self notify("killanimscript");
  self.pushable = 0;
  self clearanim(scripts\asm\asm::asm_getbodyknob(), 0.3);

  if(scripts\engine\utility::actor_is3d())
    self orientmode("face angle 3d", self.angles);
  else
    self orientmode("face angle", self.angles[1]);

  self animmode("zonly_physics", 0);
  self setanim(self._first_frame_anim, 1, 0, 0);
  self._first_frame_anim = undefined;
  self waittill("killanimscript");
}