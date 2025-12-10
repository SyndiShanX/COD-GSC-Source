/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\mp_shipment_long_art.gsc
***************************************************/

main() {
  level.tweakfile = true;

  setdvar("scr_fog_disable", "0");

  setExpFog(230, 3000, 0.402709, 0.412383, 0.29, 0.135, 0);
  VisionSetNaked("mp_shipment_long", 0);
}