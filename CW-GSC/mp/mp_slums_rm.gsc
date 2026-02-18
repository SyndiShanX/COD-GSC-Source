/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp\mp_slums_rm.gsc
***********************************************/

#using script_44b0b8420eabacad;
#using scripts\core_common\compass;
#using scripts\core_common\flag_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\util_shared;
#namespace mp_slums_rm;

function event_handler[level_init] main(eventstruct) {
  function_24198689();
  load::main();
  compass::setupminimap("");
  spawncollision("collision_clip_wall_64x64x10", "collider", (-615, -740.5, 561.5), (0, 285, -90));
  spawncollision("collision_clip_wall_64x64x10", "collider", (-592.5, -734.5, 561.5), (0, 285, -90));
  spawncollision("collision_clip_wall_64x64x10", "collider", (-612.5, -749.5, 561.5), (0, 285, -90));
  spawncollision("collision_clip_wall_64x64x10", "collider", (-590, -743.5, 561.5), (0, 285, -90));
  spawncollision("collision_clip_wall_64x64x10", "collider", (-610, -759, 561.5), (0, 285, -90));
  spawncollision("collision_clip_wall_64x64x10", "collider", (-587.5, -753, 561.5), (0, 285, -90));
  level thread function_29584e41();
}

function precache() {}

function function_24198689() {
  var_780f74b5 = [];
  var_780f74b5[var_780f74b5.size] = "mp_spawn_point";
  var_780f74b5[var_780f74b5.size] = "mp_spawn_point_axis";
  var_780f74b5[var_780f74b5.size] = "mp_spawn_point_allies";
  spawning::move_spawn_point(var_780f74b5, (950.875, -3229.85, 456.125), (919, -3225, 516), (0, 120, 0));
}

function function_29584e41() {
  e_break_glass = getent("e_break_glass", "targetname");

  if(isDefined(e_break_glass)) {
    e_break_glass util::break_glass(128);
  }

  level flag::wait_till(#"item_world_reset");

  if(util::get_game_type() !== # "spy") {
    var_94c44cac = getdynentarray("spy_special_weapon_stash");
    var_de285f77 = getdynentarray("spy_ammo_stash");
    var_ffd6a2d3 = getdynentarray("spy_equipment_stash");
    var_3c1644b6 = arraycombine(var_94c44cac, var_de285f77);
    var_3c1644b6 = arraycombine(var_3c1644b6, var_ffd6a2d3);

    foreach(dynent in var_3c1644b6) {
      setdynentstate(dynent, 3);
    }
  }
}