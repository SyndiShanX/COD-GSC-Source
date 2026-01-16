/*******************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\clientscripts\c_mul_cartel1_3_char.csc
*******************************************************************/

main() {
  self._gib_def = level._gibbing_actor_models["c_mul_cartel_body1_3_char"];
}

precache() {
  register_gibs();
}

register_gibs() {
  if(!isDefined(level._gibbing_actor_models))
    level._gibbing_actor_models = [];

  gib_spawn = spawnstruct();
  gib_spawn.gibspawn1 = "c_pan_pdf_g_rarmspawn";
  gib_spawn.gibspawntag1 = "J_Elbow_RI";
  gib_spawn.gibspawn2 = "c_pan_pdf_g_larmspawn";
  gib_spawn.gibspawntag2 = "J_Elbow_LE";
  gib_spawn.gibspawn3 = "c_afr_mpla_spawn_rleg";
  gib_spawn.gibspawntag3 = "J_Knee_RI";
  gib_spawn.gibspawn4 = "c_afr_mpla_spawn_lleg";
  gib_spawn.gibspawntag4 = "J_Knee_LE";
  gib_spawn.gibspawn5 = "c_pan_pdf_g_headspawn";
  gib_spawn.gibspawntag5 = "J_Neck";
  level._gibbing_actor_models["c_mul_cartel_body1_3_char"] = gib_spawn;
}