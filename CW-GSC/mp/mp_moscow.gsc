/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp\mp_moscow.gsc
***********************************************/

#using script_67ce8e728d8f37ba;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\compass;
#using scripts\core_common\flag_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreaks_shared;
#namespace mp_moscow;

function event_handler[level_init] main(eventstruct) {
  namespace_66d6aa44::function_3f3466c9();
  killstreaks::function_257a5f13("straferun", 40);
  killstreaks::function_257a5f13("helicopter_comlink", 75);
  load::main();
  compass::setupminimap("");
  scene::function_497689f6(#"cin_mp_moscow_intro_cia", "intro_van_moscow", "tag_probe_attach", "prb_tn_mos_eu_van");
  scene::function_497689f6(#"cin_mp_moscow_intro_kgb", "helicopter", "tag_probe_attach", "prb_tn_mos_heli_light_cabin");
  level.cleandepositpoints = array((1183, -1170, 204), (1074, 722, 132));
  level thread function_29584e41();
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