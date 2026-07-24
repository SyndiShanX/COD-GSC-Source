/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\cover_stand.gsc
****************************************/

main() {
  self endon("killanimscript");
  scripts\anim\utility::_id_9832("cover_stand");
  scripts\anim\cover_wall::_id_470E("stand");
}

end_script() {
  scripts\anim\cover_behavior::end_script("stand");
}