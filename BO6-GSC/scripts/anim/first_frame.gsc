/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\first_frame.gsc
****************************************/

#using scripts\asm\asm;
#using scripts\engine\utility;
#namespace first_frame;

function main() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x8c\xf1P#\xe1i\xd3\x0e\x10\x18\xcb\xb8\xaa\xacs\xd4");
  self notify("\xbb\x91a^\xe9\x1dr\x1e\x1cks\xf5y@");
  self.pushable = 0;
  self leaveinteraction();
  self clearanim(asm::asm_getbodyknob(), 0.3);

  if(utility::actor_is3d()) {
    self orientmode("\x01\x9a \xdcwK\xd4\xd9\xc6\x1ci\xf7r", self.angles);
  } else {
    self orientmode("u\x9fP\x1a\xbe4oa\xd5\xd9", self.angles[1]);
  }

  self animmode("b\xf21\xbc\xeb{");
  self setanim(self._first_frame_anim, 1, 0, 0);
  self._first_frame_anim = undefined;
  self waittill("\xbb\x91a^\xe9\x1dr\x1e\x1cks\xf5y@");
}