/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\first_frame.gsc
***************************************/

main() {
  self endon("death");
  self endon("stop_first_frame");
  self notify("killanimscript");
  self.pushable = 0;
  self clearanim(self._id_0C56, 0.3);
  self orientmode("face angle", self.angles[1]);
  self setanim(level._id_0C59[self._id_0C58][self._id_0C57], 1, 0, 0);
  self._id_0C57 = undefined;
  self waittill("killanimscript");
}