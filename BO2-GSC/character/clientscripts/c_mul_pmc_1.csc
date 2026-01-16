/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\clientscripts\c_mul_pmc_1.csc
***************************************************/

main() {
  self._gib_def = level._gibbing_actor_models["c_mul_pmc_body_1_1"];
}

precache() {
  register_gibs();
}

register_gibs() {
  if(!isDefined(level._gibbing_actor_models))
    level._gibbing_actor_models = [];

  gib_spawn = spawnstruct();
  gib_spawn.gibspawn1 = "c_mul_pmc_body_1_1_g_spawn_rarm";
  gib_spawn.gibspawntag1 = "J_Elbow_RI";
  gib_spawn.gibspawn2 = "c_mul_pmc_body_1_1_g_spawn_larm";
  gib_spawn.gibspawntag2 = "J_Elbow_LE";
  gib_spawn.gibspawn3 = "c_mul_pmc_body_1_1_g_spawn_rleg";
  gib_spawn.gibspawntag3 = "J_Knee_RI";
  gib_spawn.gibspawn4 = "c_mul_pmc_body_1_1_g_spawn_lleg";
  gib_spawn.gibspawntag4 = "J_Knee_LE";
  level._gibbing_actor_models["c_mul_pmc_body_1_1"] = gib_spawn;
}