/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\flowgraph\flowgraph_fx.csc
**************************************************/

#include scripts\core_common\exploder_shared;
#include scripts\core_common\util_shared;

#namespace flowgraph_fx;

playfxatposition(x, fx_effect, v_position, v_forward, v_up, i_time) {
  playFX(self.owner.localclientnum, fx_effect, v_position, v_forward, v_up, i_time);
  return true;
}

playfxontagfunc(x, e_entity, fx_effect, str_tagname) {
  util::playFXOnTag(self.owner.localclientnum, fx_effect, e_entity, str_tagname);
  return true;
}

function_f4373d13(x, fx_effect, v_offset, v_forward, v_up, i_time) {
  playfxoncamera(self.owner.localclientnum, fx_effect, v_offset, v_forward, v_up, i_time);
  return true;
}

#namespace namespace_84ba1809;

playexploder(x, str_name) {
  exploder::exploder(str_name);
  return true;
}

stopexploder(x, str_name) {
  exploder::stop_exploder(str_name);
  return true;
}

killexploder(x, str_name) {
  exploder::kill_exploder(str_name);
  return true;
}