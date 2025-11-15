/**********************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\anim\traverse\soldier_iw6_wall_hop.gsc
**********************************************************/

main() {
  if(self.type == "dog") {
    scripts\anim\traverse\shared::func_586D("wallhop", 40);
    return;
  }

  func_138A5();
}

func_138A5() {
  if(getdvarint("ai_iw7", 0) == 0) {
    scripts\anim\traverse\shared::func_18D1(func_7814(), 39.875);
    return;
  }

  self waittill("killanimscript");
}

func_7814() {
  return % traverse_wallhop_3;
}