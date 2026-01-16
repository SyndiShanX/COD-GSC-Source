/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\mp_slums2.gsc
***********************************************/

#include scripts\core_common\compass;
#include scripts\mp\mp_slums2_fx;
#include scripts\mp\mp_slums2_scripted;
#include scripts\mp\mp_slums2_sound;
#include scripts\mp_common\load;

#namespace mp_slums2;

event_handler[level_init] main(eventstruct) {
  mp_slums2_fx::main();
  mp_slums2_sound::main();
  load::main();
  compass::setupminimap("");
  level.cleandepositpoints = array((0, -744, 560), (472, 1120, 592), (-770, 1340, 592), (-112, -2152, 464), (1153, -1578, 512));
  spawncollision("collision_clip_wall_64x64x10", "collider", (-615, -740.5, 561.5), (0, 285, -90));
  spawncollision("collision_clip_wall_64x64x10", "collider", (-592.5, -734.5, 561.5), (0, 285, -90));
  spawncollision("collision_clip_wall_64x64x10", "collider", (-612.5, -749.5, 561.5), (0, 285, -90));
  spawncollision("collision_clip_wall_64x64x10", "collider", (-590, -743.5, 561.5), (0, 285, -90));
  spawncollision("collision_clip_wall_64x64x10", "collider", (-610, -759, 561.5), (0, 285, -90));
  spawncollision("collision_clip_wall_64x64x10", "collider", (-587.5, -753, 561.5), (0, 285, -90));
}

