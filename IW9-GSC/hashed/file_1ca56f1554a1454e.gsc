/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_1ca56f1554a1454e.gsc
***********************************************/

main() {
  if(getDvar("clientSideEffects") != "1") {}

  thread _id_A520347B8E7B8543();
}

_id_A520347B8E7B8543() {
  setsaveddvar("dvar_BA5B493D3212E3ED", 0.8);
  setsaveddvar("dvar_61CD8305CCF44791", 1);
  setsaveddvar("r_reactiveMotionActorRadius", 35);
  setsaveddvar("r_reactiveMotionActorVelocityMax", 7);
  setsaveddvar("r_reactiveMotionPlayerPushDecay", 0.8);
  setsaveddvar("r_reactiveMotionPlayerPushFrequency", 1);
  setsaveddvar("r_reactiveMotionPlayerRadius", 50);
  setsaveddvar("r_reactiveMotionEffectorStrengthScale", 200);
  setsaveddvar("r_reactiveMotionVelocityTailScale", 1);
  setDvar("cg_defaultWindAmplitudeScale", 1);
  setDvar("cg_defaultWindAreaScale", 1);
  setDvar("cg_defaultWindDir", (1, 0, 0));
  setDvar("cg_defaultWindFrequencyScale", 0.5);
  setDvar("cg_defaultWindNoiseScale", 0.25);
  setDvar("cg_defaultWindStrength", 10);
}