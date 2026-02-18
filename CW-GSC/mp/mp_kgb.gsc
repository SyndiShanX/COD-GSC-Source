/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp\mp_kgb.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\compass;
#using scripts\core_common\flag_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreaks_shared;
#namespace mp_kgb;

function event_handler[level_init] main(eventstruct) {
  level.levelkothdisable = [];
  level.levelkothdisable[level.levelkothdisable.size] = spawn("trigger_radius", (600, 1045, -68), 0, 50, 150);
  level.levelkothdisable[level.levelkothdisable.size] = spawn("trigger_radius", (633, 214, 0), 0, 65, 150);
  callback::on_game_playing(&on_game_playing);
  level thread function_29584e41();
  killstreaks::function_257a5f13("straferun", 40);
  killstreaks::function_257a5f13("helicopter_comlink", 75);
  load::main();
  compass::setupminimap("");
  level.var_947cc86b = 1000;
}

function on_game_playing() {
  hidemiscmodels("intro_gameplay_models");
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