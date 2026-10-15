/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\mp_grind.gsc
***********************************************/

#include scripts\core_common\compass;
#include scripts\core_common\util_shared;
#include scripts\mp_common\load;

#namespace mp_grind;

event_handler[level_init] main(eventstruct) {
  load::main();
  level function_89088577();
  level spawnkilltrigger();
  compass::setupminimap("");
  level.cleandepositpoints = array((536, -668, 1212), (1820, -1052, 1192), (-1592, -16, 1272), (-1348, -1668, 1284), (1308, 140, 1192));
}

function_89088577() {
  spawncollision("collision_clip_wall_128x128x10", "collider", (1179.08, -101.57, 1364), (270, 350.638, -25.7397));
  spawncollision("collision_clip_wall_128x128x10", "collider", (1196.05, -54, 1364), (270, 0, 0));
  spawncollision("collision_clip_wall_64x64x10", "collider", (1144, 16, 1364), (270, 0, 0));
  spawncollision("collision_clip_wall_64x64x10", "collider", (1213.5, 17, 1364), (270, 17.7027, 17.796));
  spawncollision("collision_clip_wall_64x64x10", "collider", (1177, 51, 1364), (270, 44.9, 13.8969));
  spawncollision("collision_clip_wall_64x64x10", "collider", (1159.5, 62.5, 1364), (270, 333.635, 93.5613));
  spawncollision("collision_clip_wall_32x32x10", "collider", (1128, 64, 1364), (270, 0, 0));
  spawncollision("collision_clip_wall_32x32x10", "collider", (1128, 88, 1364), (270, 0, 0));
}

spawnkilltrigger() {
  trigger = spawn("trigger_radius", (-1368, 3024, 1256), 0, 196, 128);
  trigger thread watchkilltrigger();
  trigger = spawn("trigger_radius", (-1320, 1528, 1488), 0, 96, 128);
  trigger thread watchkilltrigger();
}

watchkilltrigger() {
  level endon(#"game_ended");
  trigger = self;

  while(true) {
    waitresult = trigger waittill(#"trigger");
    waitresult.activator dodamage(1000, trigger.origin + (0, 0, 0), trigger, trigger, "none", "MOD_SUICIDE", 0);
  }
}