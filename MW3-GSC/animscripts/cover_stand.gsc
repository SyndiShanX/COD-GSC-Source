/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\cover_stand.gsc
***************************************/

main() {
  self endon("killanimscript");
  animscripts\utility::_id_0D15("cover_stand");
  animscripts\cover_wall::_id_0F76("stand");
}

end_script() {
  animscripts\cover_behavior::end_script("stand");
}