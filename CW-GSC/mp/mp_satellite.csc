/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp\mp_satellite.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\util_shared;
#namespace mp_satellite;

function event_handler[level_init] main(eventstruct) {
  if(level.var_87c6c648 !== 1) {
    function_11e3e877(#"surface_enter", #"hash_591f9167b6a7ea8b");
    function_11e3e877(#"hash_6be5853fe57d01b0", #"hash_1f2ced241c9e45bb");
    function_11e3e877(#"hash_6251d9bc015e4542", #"hash_4e8bc503c06e62e3");
    function_11e3e877(#"hash_6a2ccf46147cb7d8", #"hash_eb2febf62337433");
  }

  clientfield::register("toplayer", "force_stream_rappel_ropes", 1, 1, "int", &force_stream_rappel_ropes, 0, 0);
  setsaveddvar(#"enable_global_wind", 1);
  setsaveddvar(#"wind_global_vector", "88 0 0");
  setsaveddvar(#"wind_global_low_altitude", 0);
  setsaveddvar(#"wind_global_hi_altitude", 10000);
  setsaveddvar(#"wind_global_low_strength_percent", 100);
  callback::on_gameplay_started(&on_gameplay_started);
  load::main();
  level thread function_e5a1065e();
  util::waitforclient(0);
}

function on_gameplay_started(localclientnum) {
  waitframe(1);
  util::function_8eb5d4b0(250, 2.25);
  level notify(#"hash_6ce45f8471d15231");
  level thread scene::play(#"hash_5657eeda4a6d163f");
}

function function_e5a1065e() {
  level endon(#"hash_6ce45f8471d15231");

  while(true) {
    level waittill(#"hash_67b3195af66ed4eb");

    foreach(player in getlocalplayers()) {
      player postfx::playpostfxbundle(#"hash_4a3eee8916342bd9");
    }

    level waittill(#"hash_240db290be3c7f0f");

    foreach(player in getlocalplayers()) {
      player postfx::exitpostfxbundle(#"hash_4a3eee8916342bd9");
    }
  }
}

function force_stream_rappel_ropes(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    forcestreamxmodel(#"p9_fxanim_mp_sat_intro_rappel_frozen_rope_01_mod");
    forcestreamxmodel(#"p9_fxanim_mp_sat_intro_rappel_sh010_rope_01_mod");
    forcestreamxmodel(#"p9_fxanim_mp_sat_intro_rappel_sh020_rope_01_mod");
    forcestreamxmodel(#"p9_fxanim_mp_sat_intro_rappel_sh050_rope_01_mod");
    forcestreamxmodel(#"p9_fxanim_mp_sat_intro_rappel_sh010_rope_02a_mod");
    forcestreamxmodel(#"p9_fxanim_mp_sat_intro_rappel_sh020_rope_02_mod");
    forcestreamxmodel(#"p9_fxanim_mp_sat_intro_rappel_sh050_rope_02_mod");
    forcestreamxmodel(#"p9_fxanim_mp_sat_intro_rappel_sh010_rope_03_mod");
    forcestreamxmodel(#"p9_fxanim_mp_sat_intro_rappel_sh020_rope_03_mod");
    forcestreamxmodel(#"p9_fxanim_mp_sat_intro_rappel_sh050_rope_03_mod");
    forcestreamxmodel(#"p9_fxanim_mp_sat_intro_rappel_sh010_rope_04_mod");
    forcestreamxmodel(#"p9_fxanim_mp_sat_intro_rappel_sh020_rope_04_mod");
    forcestreamxmodel(#"p9_fxanim_mp_sat_intro_rappel_sh050_rope_04_mod");
    forcestreamxmodel(#"p9_fxanim_mp_sat_intro_rappel_sh010_rope_05_mod");
    forcestreamxmodel(#"p9_fxanim_mp_sat_intro_rappel_sh020_rope_05_mod");
    forcestreamxmodel(#"p9_fxanim_mp_sat_intro_rappel_sh050_rope_05_mod");
    forcestreamxmodel(#"p9_fxanim_mp_sat_intro_rappel_sh010_rope_02b_mod");
    return;
  }

  stopforcestreamingxmodel(#"p9_fxanim_mp_sat_intro_rappel_frozen_rope_01_mod");
  stopforcestreamingxmodel(#"p9_fxanim_mp_sat_intro_rappel_sh010_rope_01_mod");
  stopforcestreamingxmodel(#"p9_fxanim_mp_sat_intro_rappel_sh020_rope_01_mod");
  stopforcestreamingxmodel(#"p9_fxanim_mp_sat_intro_rappel_sh050_rope_01_mod");
  stopforcestreamingxmodel(#"p9_fxanim_mp_sat_intro_rappel_sh010_rope_02a_mod");
  stopforcestreamingxmodel(#"p9_fxanim_mp_sat_intro_rappel_sh020_rope_02_mod");
  stopforcestreamingxmodel(#"p9_fxanim_mp_sat_intro_rappel_sh050_rope_02_mod");
  stopforcestreamingxmodel(#"p9_fxanim_mp_sat_intro_rappel_sh010_rope_03_mod");
  stopforcestreamingxmodel(#"p9_fxanim_mp_sat_intro_rappel_sh020_rope_03_mod");
  stopforcestreamingxmodel(#"p9_fxanim_mp_sat_intro_rappel_sh050_rope_03_mod");
  stopforcestreamingxmodel(#"p9_fxanim_mp_sat_intro_rappel_sh010_rope_04_mod");
  stopforcestreamingxmodel(#"p9_fxanim_mp_sat_intro_rappel_sh020_rope_04_mod");
  stopforcestreamingxmodel(#"p9_fxanim_mp_sat_intro_rappel_sh050_rope_04_mod");
  stopforcestreamingxmodel(#"p9_fxanim_mp_sat_intro_rappel_sh010_rope_05_mod");
  stopforcestreamingxmodel(#"p9_fxanim_mp_sat_intro_rappel_sh020_rope_05_mod");
  stopforcestreamingxmodel(#"p9_fxanim_mp_sat_intro_rappel_sh050_rope_05_mod");
  stopforcestreamingxmodel(#"p9_fxanim_mp_sat_intro_rappel_sh010_rope_02b_mod");
}