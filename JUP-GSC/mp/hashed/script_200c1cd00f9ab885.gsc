/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_200c1cd00f9ab885.gsc
*************************************************/

#using script_1260535c202c8074;
#using script_15efdb5808058ab7;
#using script_193e3e231841082f;
#using script_3397bed1b741f042;
#using script_36d7680b337b15b;
#using script_3badb8914eb5ac16;
#using script_51003dec974513a9;
#using script_7edf952f8921aa6b;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\variant_asm;
#using scripts\common\callbacks;
#using scripts\engine\utility;
#namespace zombie_deathworm;

function function_a53f4a78a75cbd41(params) {
  function_6e4961e4c0a38088(params);
  function_ccb525d44a15f2b9(params);
  function_72d358d261f676a3(params);
}

function private function_b0fc1ad0235df745() {
  level.scr_anim[self.animname]["spawn"] = "spawn";
}

function function_5a38039db1b92712(asmname, statename, params) {
  function_a343ac31ca854535(&function_b0fc1ad0235df745);
  function_2dd162d826667677();
  function_14c91797faca36ea();
  function_d526daad5a463daf();
  function_d5a08a1079b6f4dd();
  function_f93080dca9cb5ee1();
  function_f847d21eaf2ae0ec();
  ent_flag_set("zombie_asm_init_finished");
}