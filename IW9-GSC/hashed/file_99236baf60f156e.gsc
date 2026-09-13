/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_99236baf60f156e.gsc
***********************************************/

main() {
  level._effect["vfx_skerries_cam_rain_infil_scripted"] = loadfx("vfx/iw9/level/mp_skerries/vfx_skerries_cam_rain_infil_scripted.vfx");
  level._effect["vfx_skerries_cam_rain_scripted"] = loadfx("vfx/iw9/level/mp_skerries/vfx_skerries_cam_rain_scripted.vfx");
  level._effect["vfx_rhib_infil_splashes"] = loadfx("vfx/iw9/infil/vfx_rhib_infil_splashes.vfx");
  level._effect["vfx_skerries_cigar_room_vp"] = loadfx("vfx/iw9/level/mp_skerries/vfx_skerries_cigar_room_vp.vfx");
  thread _id_A520347B8E7B8543();
}

precache() {}

_id_A520347B8E7B8543() {
  setsaveddvar("dvar_BA5B493D3212E3ED", 0.8);
  setsaveddvar("dvar_61CD8305CCF44791", 1);
  setsaveddvar("r_reactiveMotionActorRadius", 35);
  setsaveddvar("r_reactiveMotionActorVelocityMax", 7);
  setsaveddvar("r_reactiveMotionPlayerPushDecay", 0.8);
  setsaveddvar("r_reactiveMotionPlayerPushFrequency", 1);
  setsaveddvar("r_reactiveMotionPlayerRadius", 50);
  setsaveddvar("r_reactiveMotionEffectorStrengthScale", 200);
  setsaveddvar("r_reactiveMotionVelocityTailScale", 1);
  setDvar("cg_defaultWindAmplitudeScale", 1);
  setDvar("cg_defaultWindAreaScale", 10);
  setDvar("cg_defaultWindDir", (0, 1, 0));
  setDvar("cg_defaultWindFrequencyScale", 1.5);
  setDvar("cg_defaultWindNoiseScale", 0.5);
  setDvar("cg_defaultWindStrength", 500);
}

_id_D9A27307877FA33E() {
  setDvar("dvar_646CA256ECFF2627", "8600 9050 240");
  setDvar("dvar_A734A8DC8EF7627E", "650 750");
  setDvar("dvar_023BB35BBC2D79A8", 70);
  setDvar("dvar_27FA9F4C8976E565", 300);
  setDvar("dvar_BF2F16BD0028F6E3", "1 1 1");
  setDvar("dvar_33A035C99CB048B1", 0.00005);
  setDvar("dvar_0099863FD36F21E4", 0.015);
  setDvar("dvar_43B1BFE24B9DB3C5", 1);
  setDvar("dvar_70640CE906E6D9C2", 1);
  setDvar("dvar_5BB234E77E6E8500", 0.15);
  setDvar("dvar_248D3E2385CACB9B", 20);
  setDvar("dvar_2F948C271D3B0E2E", 30);
  setDvar("dvar_7623BD064C30088C", 0);
  setDvar("dvar_446ED387D5A2467B", 300);
  setDvar("dvar_D5BE9CF5305A87C0", 0.94);
  setDvar("dvar_383EB0DC42A487BE", 10);
  setDvar("dvar_967941BE518286C3", "0.035");
  setDvar("dvar_6587B19CDE46756E", "-0.25 0.15 0.15");
  setDvar("dvar_198BC49639574B81", 263);
  setDvar("dvar_B7BA2258818C9F3D", 0.5);
  setDvar("dvar_B7972C5881666D83", 0);
  setDvar("dvar_9E9F4B1CAB77DF95", -0.8);
  setDvar("dvar_9AD4FF0067A34902", 1);
  setDvar("dvar_A7B25CA69739B70F", 1);
}