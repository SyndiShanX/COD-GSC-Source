/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\cover_crouch.gsc
****************************************/

main() {
  self endon("killanimscript");
  animscripts\utility::_id_0D15("cover_crouch");
  animscripts\cover_wall::_id_0F76("crouch");
}

end_script() {
  self._id_0CAC = undefined;
  animscripts\cover_behavior::end_script("crouch");
}