/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\wz_ignore_systems.gsc
***********************************************/

#include scripts\core_common\system_shared;

#namespace wz_ignore_systems;

autoexec ignore_systems() {
  system::ignore(#"recon_car");
  system::ignore(#"planemortar");
  system::ignore(#"supplydrop");
  system::ignore(#"ultimate_turret");
  system::ignore(#"armor_station");
  system::ignore(#"counteruav");
  system::ignore(#"uav");
  system::ignore(#"supplypod");
}