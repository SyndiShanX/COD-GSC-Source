/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_white_lighting.gsc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\exploder_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_perks;
#include scripts\zm_common\zm_unitrigger;

#namespace zm_white_lighting;

autoexec __init__system__() {
  system::register(#"zm_white_lighting", &init, undefined, undefined);
}

init() {
  level thread function_3d4e24ea();
  level flag::init("start_exploder");
  level flag::init("stop_exploder");
  level thread function_2bdf9f35();
}

function_2bdf9f35() {
  level thread function_c51c8e3("start_exploder");
}

function_3d4e24ea() {
  level._effect[#"hash_5ee980374efab771"] = #"hash_964810cc067cb78";
}

function_c51c8e3(var_edf4d25) {
  self flag::wait_till(var_edf4d25);

  if(var_edf4d25 == "start_exploder") {
    exp_lgt_start();
    var_27a8909d = "stop_exploder";
  } else if(var_edf4d25 == "stop_exploder") {
    function_40dfe103();
    var_27a8909d = "start_exploder";
  }

  self flag::clear("start_exploder");
  self flag::clear("stop_exploder");
  self function_c51c8e3(var_27a8909d);
}

exp_lgt_start() {
  iprintlnbold("Start Exploder!");
  exploder::exploder("exploder_test");
  exploder::exploder("fxexp_disco_lgt");
}

function_40dfe103() {
  iprintlnbold("Stop Exploder!");
  exploder::stop_exploder("exploder_test");
  exploder::stop_exploder("fxexp_disco_lgt");
}

function_829b14de() {
  while(true) {
    self movez(100, 5);
    wait 5;
    self movez(-100, 5);
    wait 5;
  }
}