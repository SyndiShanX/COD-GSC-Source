/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: destructible_scripts\toy_filecabinet.gsc
****************************************************/

#include common_scripts\_destructible;
#using_animtree("destructibles");

main() {
  destructible_create("toy_filecabinet", "tag_origin", 120);
  destructible_fx("tag_drawer_lower", "fx/props/filecabinet_dam", true, damage_not("splash"));
  destructible_sound("exp_filecabinet");
  destructible_state(undefined, "com_filecabinetblackclosed_dam", 20, undefined, undefined, "splash");
  destructible_fx("tag_drawer_upper", "fx/props/filecabinet_des", true, "splash");
  destructible_sound("exp_filecabinet");
  destructible_physics("tag_drawer_upper", (50, -10, 5));
  destructible_state(undefined, "com_filecabinetblackclosed_des", undefined, undefined, undefined, undefined, undefined, false);

  destructible_part("tag_drawer_upper", "com_filecabinetblackclosed_drawer", undefined, undefined, undefined, undefined, 1.0, 1.0);
}