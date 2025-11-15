/***********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: common_scripts\_destructible_types_anim_security_camera.gsc
***********************************************************************/

#using_animtree("destructibles_dlc");
main() {
  level._destructible_preanims["security_camera_idle"] = % security_camera_idle;
  level._destructible_preanims["security_camera_null"] = % security_camera_null;
  level._destructible_preanims["security_camera_destroy"] = % security_camera_destroy;
}