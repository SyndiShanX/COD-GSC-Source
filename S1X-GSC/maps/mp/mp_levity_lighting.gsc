/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\mp_levity_lighting.gsc
***************************************************/

main() {
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.33);

  setDvar("r_mpRimColor", ".7 .9 1");
  setDvar("r_mpRimStrength", "7");
  setDvar("r_mpRimDiffuseTint", ".77 .85 1.1");

  setDvar("r_gunSightColorEntityScale", "7");
  setDvar("r_gunSightColorNoneScale", "0.8");

  if(level.currentgen) {
    level.ospvisionset = "mp_levity_osp";
    level.ospLightSet = "mp_levity_osp";

    level.warbirdVisionSet = "mp_levity_warbird";
    level.warbirdLightSet = "mp_levity_warbird";

    level.droneVisionSet = "mp_levity_drone";
    level.droneLightSet = "mp_levity_drone";
  }
}