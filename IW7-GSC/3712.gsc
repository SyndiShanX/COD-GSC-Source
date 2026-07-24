/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3712.gsc
**************************************/

#using_animtree("generic_human");

main() {
  var_0 = spawnStruct();
  var_0._id_EBEA = [];
  var_0._id_EBEA["idle"] = % shipcrib_attn_point_idle_01;
  var_0._id_EBEA["angles"] = [15, 45, 75, 105, 135, 165, 195, 225, 255, 285, 315, 345];
  var_0._id_EBEA[15] = % shipcrib_attn_pointright_l00_01;
  var_0._id_EBEA[45] = % shipcrib_attn_pointright_r30_01;
  var_0._id_EBEA[75] = % shipcrib_attn_pointright_r60_01;
  var_0._id_EBEA[105] = % shipcrib_attn_pointright_r90_01;
  var_0._id_EBEA[135] = % shipcrib_attn_pointright_r120_01;
  var_0._id_EBEA[165] = % shipcrib_attn_pointright_r150_01;
  var_0._id_EBEA[195] = % shipcrib_attn_pointright_l180_01;
  var_0._id_EBEA[225] = % shipcrib_attn_pointright_l150_01;
  var_0._id_EBEA[255] = % shipcrib_attn_pointright_l120_01;
  var_0._id_EBEA[285] = % shipcrib_attn_pointright_l90_01;
  var_0._id_EBEA[315] = % shipcrib_attn_pointright_l60_01;
  var_0._id_EBEA[345] = % shipcrib_attn_pointright_l30_01;
  var_0._id_EBEA["lastanim"] = % shipcrib_attn_pointright_l00_01;
  var_0._id_EBEA["trigger_radius"] = 125;
  scripts\sp\interaction::register_interaction("shipcrib_attn_pointright_1", var_0);
}