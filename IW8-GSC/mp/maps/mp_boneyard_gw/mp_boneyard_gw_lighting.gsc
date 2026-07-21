/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\maps\mp_boneyard_gw\mp_boneyard_gw_lighting.gsc
**************************************************************/

main() {
  level.tweakfile = 1;
  thread lighting_setup_dvars();
}

lighting_setup_dvars() {
  setDvar("_encstr_8AB10B4909EADB6F7B507E783C", 0.01);
  setDvar("_encstr_91510B50211B615B99771857E9", 1);
  setDvar("_encstr_9A400AEB2390F1FD098F0AC5", 0);
  setDvar("_encstr_84D20BC8A9B7B51394314358D9", 0.35);
  setDvar("_encstr_994D0BE8B1B5B26797B05B5AD6", 2);
  setDvar("_encstr_B4F00B9C51C42D9CC43982265A", 1);
  setDvar("_encstr_A5AD0AB9C789FB64295D839C", 2);
  setDvar("_encstr_88060B49BC98F12F2F63C13907", 1000);
  setDvar("_encstr_BE360B89A215A69A0AD229B47A", 4);
  setDvar("_encstr_91070B6BA23D9140AB28DFA4C4", 8);
  setDvar("_encstr_AB840B539C2A6905C9C43D2815", 1);
  setDvar("_encstr_BEF80B3DEB91A709E3A5D7AF1D", 1);
}