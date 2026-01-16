/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\createart\mp_checkpoint_art.gsc
********************************************************/

// _createart generated.modify at your own risk. Changing values should be fine.
main() {

  level.tweakfile = true;

  //* Fog section * 

  setDevDvar("scr_fog_disable", "0");

  setExpFog(99.3969, 4225.65, 0.482353, 0.478431, 0.501961, 0.335211, 0, 0.648188, 0.514262, 0.316033, (0.689786, 0.66702, 0.281567), 0, 180, 0.437698);
  VisionSetNaked("mp_checkpoint", 0);

}