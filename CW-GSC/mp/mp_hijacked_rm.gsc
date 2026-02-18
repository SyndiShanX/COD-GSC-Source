/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp\mp_hijacked_rm.gsc
***********************************************/

#using scripts\core_common\compass;
#using scripts\core_common\load_shared;
#namespace mp_hijacked_rm;

function event_handler[level_init] main(eventstruct) {
  level.levelkothdisable = [];
  level.levelkothdisable[level.levelkothdisable.size] = spawn("trigger_radius", (395, 185, 28), 0, 55, 300);
  load::main();
  spawncollision("collision_clip_wall_128x128x10", "collider", (869, 204, -44), (0, 0, 0));
  spawncollision("collision_clip_wall_128x128x10", "collider", (869, 360, -44), (0, 0, 0));
  spawncollision("collision_clip_wall_128x128x10", "collider", (-1245, 266, -108), (0, 0, 0));
  spawncollision("collision_clip_wall_128x128x10", "collider", (-1245, 110, -108), (0, 0, 0));
  compass::setupminimap("");

  if(getdvarint(#"hash_3c861ebd76fd24eb", 0) != 0) {
    level.var_a0b75cfd = 1;
  }

  level.var_4c887efb = spawnStruct();
  level.var_4c887efb.origin = (489.35, -40098.1, -319.647);
  level.var_4c887efb.angles = (0, 0, 0);
}