/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\mp_vlobby_room_lighting.gsc
***************************************************/

main() {
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.33);

  setDvar("r_mpRimColor", "0 0 0");
  setDvar("r_mpRimStrength", "0");
  setDvar("r_mpRimDiffuseTint", "0 0 0");

  setDvar("sm_spotshadowfadetime", 0.01);
  setDvar("sm_spotLightScoreModelScale", 0.3);

  setDvar("r_gunSightColorEntityScale", "7");
  setDvar("r_gunSightColorNoneScale", "0.8");
}