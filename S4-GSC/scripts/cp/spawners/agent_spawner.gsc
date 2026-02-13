/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\spawners\agent_spawner.gsc
*************************************************/

init_agent_spawner() {
  level.agent_spawners = [];
}

register_spawner(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.name = var_0;
  var_2._id_E141 = var_1;
  level.agent_spawners[var_0] = var_2;
}

_id_5222(var_0) {
  level.agent_spawner_current = level.agent_spawners[var_0];
}

_id_E0AC(var_0) {
  return [[level.agent_spawner_current._id_E141]](var_0);
}