/*****************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\anim\cover_crouch.gsc
*****************************************/

main() {
  self endon("killanimscript");
  scripts\anim\utility::func_9832("cover_crouch");
  scripts\anim\cover_wall::func_470E("crouch");
}

end_script() {
  self.var_4716 = undefined;
  scripts\anim\cover_behavior::ismayhem("crouch");
}