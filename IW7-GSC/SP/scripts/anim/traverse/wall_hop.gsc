/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\traverse\wall_hop.gsc
**********************************************/

main() {
  if(self.type == "dog")
    scripts\anim\traverse\shared::_id_586D("wallhop", 40);
  else
    _id_138A5();
}

_id_138A5() {
  if(getdvarint("ai_iw7", 0) == 0)
    scripts\anim\traverse\shared::_id_18D1(_id_7814(), 39.875);
  else
    self waittill("killanimscript");
}

#using_animtree("generic_human");

_id_7814() {
  return % traverse_wallhop_3;
}