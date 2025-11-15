/*********************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\sp\vision.gsc
*********************************/

func_979C() {
  if(!isDefined(level.var_13483)) {
    level.var_13483 = "cheat_bw";
  }

  visionsetthermal(level.var_13483);
  visionsetpain("near_death");
}