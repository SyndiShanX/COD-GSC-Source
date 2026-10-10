/***************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\maps\mp_jup_hydro\mp_jup_hydro_fx.gsc
***************************************************************/

#namespace mp_jup_hydro_fx;

function main() {
  level._effect["vfx_story_vortex_blocker_wall"] = loadfx("vfx/jup/ob/gameplay/riftrun/s3_5/story_mission/vfx_story_vortex_blocker_wall.vfx");
  level._effect["vfx_the_entity_ground_vortex_debris"] = loadfx("vfx/jup/ob/gameplay/riftrun/s3_5/story_mission/the_entity/vfx_the_entity_ground_vortex_debris.vfx");
  level._effect["vfx_loot_obj_speed_pickup"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_loot_obj_speed_pickup.vfx");

  if(getDvar(@ "clientsideeffects") != "<dev string:x1c>") {}
}