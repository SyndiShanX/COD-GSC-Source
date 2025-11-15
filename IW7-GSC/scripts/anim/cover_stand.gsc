/****************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\anim\cover_stand.gsc
****************************************/

main() {
  self endon("killanimscript");
  scripts\anim\utility::func_9832("cover_stand");
  scripts\anim\cover_wall::func_470E("stand");
}

end_script() {
  scripts\anim\cover_behavior::ismayhem("stand");
}