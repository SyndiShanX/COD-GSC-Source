/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3723.gsc
**************************************/

#using_animtree("generic_human");

main() {
  var_0 = spawnStruct();
  var_0._id_EBEA = [];
  var_0._id_EBEA["no_gun"] = 1;
  var_0._id_EBEA["idle"] = [%shipcrib_bridge_hall_pipe_repair_idle_01, %shipcrib_bridge_hall_pipe_repair_idle_01];
  var_0._id_EBEA["angles"] = [15, 45, 75, 105, 135, 165];
  var_0._id_EBEA[15] = [%shipcrib_bridge_hall_pipe_repair_l00_01, 0.75, "shipcrib_us1_sir1"];
  var_0._id_EBEA[45] = [%shipcrib_bridge_hall_pipe_repair_r30_01, 0.75, "shipcrib_us1_sir1"];
  var_0._id_EBEA[75] = [%shipcrib_bridge_hall_pipe_repair_r60_01, 0.75, "shipcrib_us1_sir1"];
  var_0._id_EBEA[105] = [%shipcrib_bridge_hall_pipe_repair_r90_01, 0.75, "shipcrib_us1_sir1"];
  var_0._id_EBEA[135] = [%shipcrib_bridge_hall_pipe_repair_r120_01, 0.75, "shipcrib_us1_sir1"];
  var_0._id_EBEA[165] = [%shipcrib_bridge_hall_pipe_repair_r150_01, 0.75, "shipcrib_us1_sir1"];
  var_0._id_EBEA["lastanim"] = [%shipcrib_bridge_hall_pipe_repair_l180_01, 0.75, "shipcrib_us1_sir1"];
  var_0._id_EBEA["trigger_radius"] = 128;
  scripts\sp\interaction::register_interaction("shipcrib_hall_pipe_repair_01", var_0);
}