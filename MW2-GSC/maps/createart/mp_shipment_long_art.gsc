/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\createart\mp_shipment_long_art.gsc
********************************************************/

// _createart generated.modify at your own risk. Changing values should be fine.
main() {

  level.tweakfile = true;

  //* Fog section * 

  setdvar("scr_fog_disable", "0");

  //setExpFog( 500, 2842, 0.642709, 0.626383, 0.5, 3.0, 0 );
  //setExpFog( start distance, halfway distance, red, green, blue, max opacity, transition time,
  setExpFog(230, 3000, 0.402709, 0.412383, 0.29, 0.135, 0);
  VisionSetNaked("mp_shipment_long", 0);

}