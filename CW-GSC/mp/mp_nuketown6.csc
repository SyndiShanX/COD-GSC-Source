/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp\mp_nuketown6.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\util_shared;
#namespace mp_nuketown6;

function event_handler[level_init] main(eventstruct) {
  setsaveddvar(#"enable_global_wind", 1);
  setsaveddvar(#"wind_global_vector", "88 0 0");
  setsaveddvar(#"wind_global_low_altitude", 0);
  setsaveddvar(#"wind_global_hi_altitude", 10000);
  setsaveddvar(#"wind_global_low_strength_percent", 100);
  init_clientfields();
  callback::on_gameplay_started(&on_gameplay_started);
  level thread function_b02d88a3();
  level thread function_a6101b7();
  load::main();
  util::waitforclient(0);
}

function on_gameplay_started(localclientnum) {
  waitframe(1);
  var_7075c004 = 500;
  var_8b7976b9 = 1.75;

  if(getdvarint(#"hash_269852f320baca83", 0) || getdvarint(#"hash_435b3a7c7c2f2c07", 0)) {
    var_7075c004 = 200;
    var_8b7976b9 = 1.85;
  }

  util::function_8eb5d4b0(var_7075c004, var_8b7976b9);
}

function init_clientfields() {
  clientfield::register("toplayer", "" + # "hash_802934d416ac981", 1, 1, "int", &function_6b8c4c36, 0, 0);
}

function function_b02d88a3() {
  var_f7d8aaa7 = strtok("dom dom10v10 war war12v12 sd control dropkick vip sd_hc dom_hc control_hc", " ");
  gametype = util::get_game_type();

  if(!isinarray(var_f7d8aaa7, gametype)) {
    indices = findvolumedecalindexarray("dom_bounds");

    foreach(index in indices) {
      hidevolumedecal(index);
    }
  }
}

function function_a6101b7() {
  if(getdvarint(#"hash_269852f320baca83", 0)) {
    setsoundcontext("ltm", "xmas");
    level thread scene::play(#"hash_3163c0c4a56dc10");
    level thread scene::play(#"hash_5190937d4de7a0ab");
    level thread scene::play(#"hash_758a1eb7469f93ab");
    level thread scene::play(#"hash_52fc71906d7b4506");
    level thread scene::play(#"hash_14cd021eabacb67a");
    level thread scene::play(#"hash_62e4b7afbda52d35");
    level thread scene::play(#"hash_2c7e5703f973b5c");
    level thread scene::play(#"hash_7299fe160cf1c5e4");
    level thread scene::play(#"hash_2f6dbc5909d54dea");
    level thread scene::play(#"hash_41335bc1f4e7c7d9");
    level thread scene::play(#"hash_4b954439329ad046");
    level thread scene::play(#"hash_45834b6a02ccfc14");
    return;
  }

  if(getdvarint(#"hash_435b3a7c7c2f2c07", 0)) {
    setsoundcontext("ltm", "halloween");
    return;
  }

  indices = findvolumedecalindexarray("nt6_xmas_props");

  foreach(index in indices) {
    hidevolumedecal(index);
  }

  indices = findvolumedecalindexarray("nt6_halloween_props");

  foreach(index in indices) {
    hidevolumedecal(index);
  }
}

function function_6b8c4c36(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self playrumbleonentity(fieldname, #"hash_431e56f34a345079");
    self postfx::playpostfxbundle(#"hash_1c01122f6d0510cf");
    return;
  }

  self postfx::stoppostfxbundle(#"hash_1c01122f6d0510cf");
}