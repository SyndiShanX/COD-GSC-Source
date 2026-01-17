/************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\clientscripts\c_zom_cosmo_spetznaz.csc
************************************************************/

matches_me() {
  if(self.model == "c_zom_cosmo_spetznaz_body") {
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
  gib_spawn.gibSpawn1 = "char_ger_honorgd_body1_g_rarmspawn";
  gib_spawn.gibSpawnTag1 = "J_Elbow_RI";
  gib_spawn.gibSpawn2 = "char_ger_honorgd_body1_g_larmspawn";
  gib_spawn.gibSpawnTag2 = "J_Elbow_LE";
  gib_spawn.gibSpawn3 = "char_ger_honorgd_body1_g_rlegspawn";
  gib_spawn.gibSpawnTag3 = "J_Knee_RI";
  gib_spawn.gibSpawn4 = "char_ger_honorgd_body1_g_llegspawn";
  gib_spawn.gibSpawnTag4 = "J_Knee_LE";
  level._gibbing_actor_models[level._gibbing_actor_models.size] = gib_spawn;
}