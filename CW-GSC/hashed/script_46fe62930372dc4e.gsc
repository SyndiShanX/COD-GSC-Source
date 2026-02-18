/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_46fe62930372dc4e.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_audio;
#namespace namespace_4ce4e65e;

function init() {
  level.var_a353323e = &function_cb5a4b1a;
  level.var_ae2fe3bd = &function_613a7ccc;
}

function function_cb5a4b1a() {
  music::setmusicstate("common_exfil");
}

function function_613a7ccc(b_success = 0) {
  if(b_success) {
    music::setmusicstate("common_exfil_success");
    return;
  }

  music::setmusicstate("common_exfil_fail");
}

function function_4f292ffc() {
  wait 1;
  function_dd9efc4();
}

function function_453254ee() {
  function_c383014f();
}

function function_dd9efc4() {
  if(!isDefined(level.var_8c5cb77b)) {
    level.var_8c5cb77b = ["assault_round_00", "assault_round_01", "assault_round_02"];
    level.var_8c5cb77b = array::randomize(level.var_8c5cb77b);
  }

  level.var_b8089dfc = array::pop_front(level.var_8c5cb77b);
  level thread zm_audio::function_b36aeaf6(level.var_b8089dfc);

  if(level.var_8c5cb77b.size == 0) {
    level.var_8c5cb77b = undefined;
  }
}

function function_c383014f() {
  if(isDefined(level.var_b8089dfc)) {
    level thread zm_audio::function_2354b945(level.var_b8089dfc);
  }
}