/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\mp_vlobby_room_lighting.gsc
***************************************************/

main() {
  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);

  setdvar("r_mpRimColor", "0 0 0");
  setdvar("r_mpRimStrength", "0");
  setdvar("r_mpRimDiffuseTint", "0 0 0");

  setdvar("sm_spotshadowfadetime", 0.01);
  setdvar("sm_spotLightScoreModelScale", 0.3);

  setdvar("r_gunSightColorEntityScale", "7");
  setdvar("r_gunSightColorNoneScale", "0.8");
}