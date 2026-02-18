/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp\mp_dune.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\util_shared;
#namespace mp_dune;

function event_handler[level_init] main(eventstruct) {
  if(level.var_87c6c648 !== 1) {
    function_11e3e877(#"surface_enter", #"hash_6928446ee7176a2c");
    function_11e3e877(#"hash_6251d9bc015e4542", #"hash_3ae5980d031edc20");
    function_11e3e877(#"hash_6a2ccf46147cb7d8", #"hash_4c01b69a93976f42");
    function_11e3e877(#"hash_6be5853fe57d01b0", #"hash_118e10d00498591e");
  }

  if(function_be90acca(util::get_game_type()) === # "zsurvival") {
    clientfield::register("toplayer", "" + # "hash_732e76418cbd8453", 1, 1, "int", &function_8f4ebcaf, 0, 0);
    callback::on_spawned(&on_player_spawned);
  }

  clientfield::register("toplayer", "" + # "hash_5e463693d1dbcf1c", 1, 1, "int", &function_a30c2dd0, 0, 0);
  setsaveddvar(#"enable_global_wind", 1);
  setsaveddvar(#"wind_global_vector", "88 0 0");
  setsaveddvar(#"wind_global_low_altitude", 0);
  setsaveddvar(#"wind_global_hi_altitude", 10000);
  setsaveddvar(#"wind_global_low_strength_percent", 100);
  callback::on_gameplay_started(&on_gameplay_started);
  load::main();
  level thread function_7f639bc1();
  util::waitforclient(0);
  function_103cfebf();
}

function on_gameplay_started(localclientnum) {
  waitframe(1);
  util::function_8eb5d4b0(2000, 1.9);
}

function on_player_spawned(localclientnum) {
  function_f58e42ae(localclientnum, 2);

  if(isPlayer(self)) {
    self function_8f4ebcaf(localclientnum, 0, 1);
  }
}

function function_7f639bc1() {
  var_f7d8aaa7 = strtok("koth10v10 vip conf10v10 dom10v10 tdm10v10 war12v12 zonslaught zonslaught_lotto_loadouts zsurvival", " ");
  gametype = util::get_game_type();

  if(isinarray(var_f7d8aaa7, gametype)) {
    function_e7647ecd("6v6_occluder", 0);
    indices = findvolumedecalindexarray("6v6_bounds");

    foreach(index in indices) {
      hidevolumedecal(index);
    }

    return;
  }

  function_e7647ecd("6v6_occluder", 1);
  indices = findvolumedecalindexarray("12v12_bounds");

  foreach(index in indices) {
    hidevolumedecal(index);
  }
}

function function_8f4ebcaf(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isPlayer(self)) {
    fieldname = self getlocalclientnumber();
  }

  if(!isDefined(fieldname)) {
    return;
  }

  if(bwastimejump) {
    function_be93487f(fieldname, 4, 0, 0, 1, 0);
    return;
  }

  function_be93487f(fieldname, 1, 1, 0, 0, 0);
}

function function_a30c2dd0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    function_be93487f(fieldname, 8, 0, 0, 0, 1);
    return;
  }

  function_be93487f(fieldname, 1, 1, 0, 0, 0);
}

function private function_103cfebf() {
  foreach(n_decal in findvolumedecalindexarray("hordehunt_corpses_1")) {
    hidevolumedecal(n_decal);
  }

  foreach(n_decal in findvolumedecalindexarray("hordehunt_corpses_2")) {
    hidevolumedecal(n_decal);
  }
}