/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp\mp_tank.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\util_shared;
#namespace mp_tank;

function event_handler[level_init] main(eventstruct) {
  setsaveddvar(#"enable_global_wind", 1);
  setsaveddvar(#"wind_global_vector", "88 0 0");
  setsaveddvar(#"wind_global_low_altitude", 0);
  setsaveddvar(#"wind_global_hi_altitude", 10000);
  setsaveddvar(#"wind_global_low_strength_percent", 100);
  clientfield::register("world", "" + # "hash_7de1e9f42b73bf42", 1, 1, "int", &function_383aad7d, 0, 0);
  callback::on_gameplay_started(&on_gameplay_started);
  load::main();
  util::waitforclient(0);
}

function on_gameplay_started(localclientnum) {
  waitframe(1);
  util::function_8eb5d4b0(700, 2.25);
}

function function_383aad7d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    function_3385d776(#"hash_6f5d8ddb17e33f8d");
    function_3385d776(#"hash_37f32a6efae2b7e2");
    function_3385d776(#"hash_6592edf28efce440");
    return;
  }

  function_c22a1ca2(#"hash_6f5d8ddb17e33f8d");
  function_c22a1ca2(#"hash_37f32a6efae2b7e2");
  function_c22a1ca2(#"hash_6592edf28efce440");
}