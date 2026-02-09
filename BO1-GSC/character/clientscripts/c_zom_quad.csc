/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\clientscripts\c_zom_quad\.csc
**************************************************/

matches_me() {
  if(self.model == "c_zom_quad_body") {
    return true;
  }
  return (false);
}
register_gibs() {
  if(!isDefined(level._gibbing_actor_models)) {
    level._gibbing_actor_models = [];
  }
  gib_spawn = spawnStruct();
  gib_spawn.matches_me = ::matches_me;
  gib_spawn.gibSpawn3 = "c_zom_quad_g_rlegspawn";
  gib_spawn.gibSpawnTag3 = "J_Knee_RI";
  gib_spawn.gibSpawn4 = "c_zom_quad_g_llegspawn";
  gib_spawn.gibSpawnTag4 = "J_Knee_LE";
  level._gibbing_actor_models[level._gibbing_actor_models.size] = gib_spawn;
}