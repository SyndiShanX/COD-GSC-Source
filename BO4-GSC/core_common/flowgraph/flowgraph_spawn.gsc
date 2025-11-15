/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\flowgraph\flowgraph_spawn.gsc
*****************************************************/

#namespace flowgraph_spawn;

spawnentityfromspawner(x, sp_spawner, str_targetname, b_force_spawn, b_make_room, b_infinite_spawn) {
  e_spawned = sp_spawner spawnfromspawner(str_targetname, b_force_spawn, b_make_room, b_infinite_spawn);
  return array(isDefined(e_spawned), e_spawned);
}