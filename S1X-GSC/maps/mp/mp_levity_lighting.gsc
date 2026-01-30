/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\mp_levity_lighting.gsc
***************************************************/

main() {
  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);

  setdvar("r_mpRimColor", ".7 .9 1");
  setdvar("r_mpRimStrength", "7");
  setdvar("r_mpRimDiffuseTint", ".77 .85 1.1");

  setdvar("r_gunSightColorEntityScale", "7");
  setdvar("r_gunSightColorNoneScale", "0.8");

  if(level.currentgen) {
    level.ospvisionset = "mp_levity_osp";
    level.ospLightSet = "mp_levity_osp";

    level.warbirdVisionSet = "mp_levity_warbird";
    level.warbirdLightSet = "mp_levity_warbird";

    level.droneVisionSet = "mp_levity_drone";
    level.droneLightSet = "mp_levity_drone";
  }

}