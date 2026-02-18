/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: wz\wz_zoo.gsc
***********************************************/

#using script_72d96920f15049b8;
#using scripts\core_common\compass;
#using scripts\core_common\load_shared;
#using scripts\core_common\util_shared;
#namespace wz_zoo;

function event_handler[level_init] main(eventstruct) {
  load::main();
  compass::setupminimap("");
  level.var_29cfe9dd = 1;
  function_564698fd();
  function_e8fa58f2();
}

function function_564698fd() {
  gametype = function_be90acca(util::get_game_type());

  if(gametype === "zsurvival") {
    level.var_29cfe9dd = 0;
    level.mapcenter = (-3417.43, 1101.38, 673.221);
    namespace_e8c18978::function_d887d24d("chopper_gunner_vol_zoo_1");
    namespace_e8c18978::function_d887d24d("chopper_gunner_vol_zoo_2");
  }
}

function function_e8fa58f2() {
  hidemiscmodels("sv_holdout_aetherfungus");
  hidemiscmodels("defend_corpses_1");
  hidemiscmodels("defend_corpses_2");
  hidemiscmodels("defend_corpses_3");
  hidemiscmodels("hvt_mechz_corpses");
  hidemiscmodels("hvt_mimic_corpses");
  hidemiscmodels("hvt_raz_corpses");
  hidemiscmodels("hvt_steiner_corpses");
  hidemiscmodels("payload_teleport_corpses");
  hidemiscmodels("payload_noteleport_corpses");
  hidemiscmodels("retrieval_corpses");
  hidemiscmodels("secure_corpses");
  hidemiscmodels("hordehunt_corpses_1");
  hidemiscmodels("hordehunt_corpses_2");
  hidemiscmodels("hordehunt_corpses_3");
  hidemiscmodels("fishing_setup");
  hidemiscmodels("transport_corpses");
}