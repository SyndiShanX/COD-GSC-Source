/**************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\flowgraph\flowgraph_fx.gsc
**************************************************/

#using scripts\core_common\exploder_shared;
#namespace flowgraph_fx;

function playfxatposition(x, fx_effect, v_position, v_forward, v_up) {
  playFX(fx_effect, v_position, v_forward, v_up);
  return true;
}

function function_f4373d13(x, fx_effect, v_offset, v_forward, v_up, var_a1a2ff27) {
  playfxoncamera(fx_effect, v_offset, v_forward, v_up, var_a1a2ff27);
  return true;
}

#namespace namespace_84ba1809;

function playexploder(x, str_name) {
  exploder::exploder(str_name);
  return true;
}

function stopexploder(x, str_name) {
  exploder::stop_exploder(str_name);
  return true;
}

function killexploder(x, str_name) {
  exploder::kill_exploder(str_name);
  return true;
}