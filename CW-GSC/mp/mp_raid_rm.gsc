/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp\mp_raid_rm.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\compass;
#using scripts\core_common\flag_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\oob;
#using scripts\core_common\util_shared;
#namespace mp_raid_rm;

function event_handler[level_init] main(eventstruct) {
  level.levelkothdisable = [];
  level.levelkothdisable[level.levelkothdisable.size] = spawn("trigger_radius", (2645, 1883, 100), 0, 50, 50);
  level.levelkothdisable[level.levelkothdisable.size] = spawn("trigger_radius", (2417, 2117, 100), 0, 50, 50);
  level.levelkothdisable[level.levelkothdisable.size] = spawn("trigger_radius", (2067, 2119, 100), 0, 50, 50);
  level.levelkothdisable[level.levelkothdisable.size] = spawn("trigger_radius", (1835, 1886, 100), 0, 50, 50);
  level.levelwardisable = [];
  level.levelwardisable[level.levelkothdisable.size] = spawn("trigger_radius", (2645, 1883, 100), 0, 50, 150);
  level.levelwardisable[level.levelkothdisable.size] = spawn("trigger_radius", (-898, 2710, 100), 0, 50, 150);
  level.levelwardisable[level.levelkothdisable.size] = spawn("trigger_radius", (-898, 2710, 100), 0, 50, 150);
  level.levelwardisable[level.levelkothdisable.size] = spawn("trigger_radius", (-898, 2710, 100), 0, 50, 150);
  trigger = spawn("trigger_radius_out_of_bounds", (1030, 4860, 54), 0, 50, 50);
  trigger thread oob::run_oob_trigger();
  level thread function_b02d88a3();
  load::main();
  compass::setupminimap("");
  spawncollision("collision_bullet_wall_256x256x10", "collider", (2396, 3464, 124), (0, 0, 0));
  spawncollision("collision_bullet_wall_256x256x10", "collider", (2396, 3680, 124), (0, 0, 0));
  spawncollision("collision_bullet_wall_256x256x10", "collider", (2520, 3804, 124), (0, 90, 0));
  spawncollision("collision_bullet_wall_256x256x10", "collider", (2616, 3804, 124), (0, 90, 0));
  level thread function_29584e41();
}

function function_b02d88a3() {
  var_76bdb3ae = strtok("tdm tdm_hc tdm10v10 conf conf10v10 conf_hc dm dm_hc ctf koth koth10v10 koth_cdl koth_hc oic shrp gun control control_cdl koth_cdlpro control_cdlpro", " ");
  gametype = util::get_game_type();

  if(!isinarray(var_76bdb3ae, gametype)) {
    hidemiscmodels("dom_bounds");
    array::delete_all(getEntArray("dom_bounds", "targetname"));
    array::delete_all(getEntArray("dom_bounds", "script_noteworthy"));
    return;
  }

  array::run_all(getEntArray("dom_bounds", "targetname"), &disconnectpaths, undefined, 0);
}

function function_29584e41() {
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