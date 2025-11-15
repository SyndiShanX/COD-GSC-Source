/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_boneyard_ns_anim.gsc
*******************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

main() {
  level.animations = [];
  level.anim_names = [];

  precache_anims();
  script_model_anims();
}

precache_anims() {
  PrecacheMpAnim("byard_shuttle_takeoff_success");
  PrecacheMpAnim("byard_rocket_exploding_01");
  PrecacheMpAnim("byard_major_debris_01_falling");
  PrecacheMpAnim("byard_major_debris_02_falling");
  PrecacheMpAnim("byard_major_debris_03_falling");
  PrecacheMpAnim("byard_major_debris_04_falling");
  PrecacheMpAnim("byard_major_debris_05_falling");
}

#using_animtree("animated_props_dlc1");
script_model_anims() {
  level.animations["rocket_success"] = [];
  level.animations["rocket_success"]["launch"] = % byard_shuttle_takeoff_success;

  level.anim_names["rocket_success"] = [];
  level.anim_names["rocket_success"]["launch"] = "byard_shuttle_takeoff_success";

  level.animations["rocket_explo"] = [];
  level.animations["rocket_explo"]["launch"] = % byard_rocket_exploding_01;
  level.animations["rocket_explo"]["crash_01"] = % byard_major_debris_01_falling;
  level.animations["rocket_explo"]["crash_02"] = % byard_major_debris_02_falling;
  level.animations["rocket_explo"]["crash_03a"] = % byard_major_debris_04_falling;
  level.animations["rocket_explo"]["crash_03b"] = % byard_major_debris_05_falling;
  level.animations["rocket_explo"]["crash_04"] = % byard_major_debris_03_falling;

  level.anim_names["rocket_explo"] = [];
  level.anim_names["rocket_explo"]["launch"] = "byard_rocket_exploding_01";
  level.anim_names["rocket_explo"]["crash_01"] = "byard_major_debris_01_falling";
  level.anim_names["rocket_explo"]["crash_02"] = "byard_major_debris_02_falling";
  level.anim_names["rocket_explo"]["crash_03a"] = "byard_major_debris_04_falling";
  level.anim_names["rocket_explo"]["crash_03b"] = "byard_major_debris_05_falling";
  level.anim_names["rocket_explo"]["crash_04"] = "byard_major_debris_03_falling";
}