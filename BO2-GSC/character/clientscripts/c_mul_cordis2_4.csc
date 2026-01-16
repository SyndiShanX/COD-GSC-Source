/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\clientscripts\c_mul_cordis2_4.csc
*********************************************************/

main() {
  self._gib_def = level._gibbing_actor_models["c_mul_cordis_body2_4"];
}

precache() {
  register_gibs();
}

register_gibs() {
  if(!isDefined(level._gibbing_actor_models))
    level._gibbing_actor_models = [];

  gib_spawn = spawnstruct();
  gib_spawn.gibspawn1 = "c_mul_cordis_body_g_rarmspawn";
  gib_spawn.gibspawntag1 = "J_Elbow_RI";
  gib_spawn.gibspawn2 = "c_mul_cordis_body_g_larmspawn";
  gib_spawn.gibspawntag2 = "J_Elbow_LE";
  gib_spawn.gibspawn3 = "c_mul_cordis_body_g_rlegspawn";
  gib_spawn.gibspawntag3 = "J_Knee_RI";
  gib_spawn.gibspawn4 = "c_mul_cordis_body_g_llegspawn";
  gib_spawn.gibspawntag4 = "J_Knee_LE";
  gib_spawn.gibspawn5 = "c_mul_cordis_g_headspawn";
  gib_spawn.gibspawntag5 = "J_Neck";
  level._gibbing_actor_models["c_mul_cordis_body2_4"] = gib_spawn;
}