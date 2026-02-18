/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: wz\wz_duga.csc
***********************************************/

#using scripts\core_common\audio_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\util_shared;
#namespace wz_duga;

function event_handler[level_init] main(eventstruct) {
  setsaveddvar(#"enable_global_wind", 1);
  setsaveddvar(#"wind_global_vector", "88 0 0");
  setsaveddvar(#"wind_global_low_altitude", 0);
  setsaveddvar(#"wind_global_hi_altitude", 10000);
  setsaveddvar(#"wind_global_low_strength_percent", 100);
  callback::on_gameplay_started(&on_gameplay_started);
  load::main();
  util::waitforclient(0);
  function_103cfebf();
  forcestreammaterial("mc/t9_water_lake_wz_duga_01", -1);
  level thread function_b1c181b9();
}

function private function_103cfebf() {
  foreach(n_decal in findvolumedecalindexarray("hordehunt_corpses_1")) {
    hidevolumedecal(n_decal);
  }

  foreach(n_decal in findvolumedecalindexarray("hordehunt_corpses_2")) {
    hidevolumedecal(n_decal);
  }

  foreach(n_decal in findvolumedecalindexarray("hordehunt_corpses_3")) {
    hidevolumedecal(n_decal);
  }
}

function on_gameplay_started(localclientnum) {
  waitframe(1);
  util::function_8eb5d4b0(700, 1.5);
}

function function_b1c181b9() {
  audio::playloopat(#"hash_85f5d79551f8b65", (1509, 4267, 8793));
}