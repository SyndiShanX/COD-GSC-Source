/****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_deadzone\mp_deadzone_lighting.gsc
****************************************************************/

function main() {
  setDvar("sm_sunSampleSizeNear", 0.4);
  setDvar("sm_sunDistantShadows", 0);
  setDvar("sm_sunCascadeSizeMultiplier1", 2);
  setDvar("sm_sunCascadeSizeMultiplier2", 3);
  setDvar("sm_spotDistCull", 600);
  setDvar("sm_spotUpdateLimit", 5);
  setDvar("sm_sunDistantShadows", 0);
  setDvar("r_useCompressedSunShadow", 1);
}