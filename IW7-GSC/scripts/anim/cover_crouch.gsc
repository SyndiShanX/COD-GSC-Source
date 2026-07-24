/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\cover_crouch.gsc
*****************************************/

main() {
  self endon("killanimscript");
  scripts\anim\utility::_id_9832("cover_crouch");
  scripts\anim\cover_wall::_id_470E("crouch");
}

end_script() {
  self._id_4716 = undefined;
  scripts\anim\cover_behavior::end_script("crouch");
}