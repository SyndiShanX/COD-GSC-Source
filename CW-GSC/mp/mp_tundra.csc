/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp\mp_tundra.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\util_shared;
#namespace mp_tundra;

function event_handler[level_init] main(eventstruct) {
  setsaveddvar(#"enable_global_wind", 1);
  setsaveddvar(#"wind_global_vector", "88 0 0");
  setsaveddvar(#"wind_global_low_altitude", 0);
  setsaveddvar(#"wind_global_hi_altitude", 10000);
  setsaveddvar(#"wind_global_low_strength_percent", 100);
  setsaveddvar(#"hash_59504a17f300dd1b", 1);
  callback::on_gameplay_started(&on_gameplay_started);
  load::main();
  util::waitforclient(0);
  level thread function_c0895679();
  level thread function_7f639bc1();
  function_103cfebf();
}

function on_gameplay_started(localclientnum) {
  waitframe(1);
  util::function_8eb5d4b0(4000, 4.25);
}

function function_c0895679() {
  self notify("13856eaf7eccacc0");
  self endon("13856eaf7eccacc0");

  while(true) {
    level waittill(#"hash_1dd09886b0c5cbb1");
    a_players = getlocalplayers();

    foreach(player in a_players) {
      if(!player postfx::function_556665f2(#"hash_139bff4e9ef99e2d")) {
        player postfx::playpostfxbundle(#"hash_139bff4e9ef99e2d");
      }
    }

    level waittill(#"hash_6f2413de6002b1cd");
    a_players = getlocalplayers();

    foreach(player in a_players) {
      if(player postfx::function_556665f2(#"hash_139bff4e9ef99e2d")) {
        player postfx::stoppostfxbundle(#"hash_139bff4e9ef99e2d");
      }
    }
  }
}

function function_7f639bc1() {
  gametype = util::get_game_type();

  if(!function_559de4b9(gametype)) {
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

function function_559de4b9(str_gametype) {
  a_tokens = strtok(str_gametype, "_");

  switch (a_tokens[0]) {
    case # "koth":
    case # "sas":
    case # "prop":
    case # "control":
    case # "dm":
    case # "sd":
    case # "conf":
    case # "scream":
    case # "oic":
    case # "dom":
    case # "dropkick":
    case # "gun":
    case # "tdm":
    case # "clean":
    case # "infect":
      var_f710be30 = 1;
      break;
    default:
      var_f710be30 = 0;
      break;
  }

  return var_f710be30;
}

function private function_103cfebf() {
  foreach(n_decal in findvolumedecalindexarray("hordehunt_corpses_1")) {
    hidevolumedecal(n_decal);
  }

  foreach(n_decal in findvolumedecalindexarray("hordehunt_corpses_2")) {
    hidevolumedecal(n_decal);
  }
}