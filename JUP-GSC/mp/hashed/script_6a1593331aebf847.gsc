/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_6a1593331aebf847.gsc
*************************************************/

#using script_13d927d1fbe8598c;
#using script_25a541cdebf5c6ce;
#using script_2cd07641bf71242a;
#using script_3b7ffa11ee92fc3;
#using script_3badb8914eb5ac16;
#using script_4e131720d70aa378;
#using script_7edf952f8921aa6b;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\variant_asm;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace namespace_5a87d005bee83137;

function precache(params) {
  function_cf142512f48666b7(params);
}

function private function_f49a30f92555b827() {
  function_304c63cbb536c526();
  function_e666bc1f7f826ea2();
}

function function_7c45a7e2b8990bee(asmname, statename, params) {
  function_a343ac31ca854535(&function_f49a30f92555b827);
  self.asm.footsteps = spawnStruct();
  self.asm.footsteps.foot = "invalid";
  self.asm.footsteps.time = 0;
  self.asm.customdata = spawnStruct();
  asm_setmoveplaybackrate(1);
  function_ac7db7e26eb6926c();
  function_1d4cf90e795ad643();
  function_c84ae25edc875e49();
  function_75a233b1c9abd8f();
  function_64d97cf652a4d385();
  callback::add("on_ai_init", &on_ai_init);
  ent_flag_set("zombie_asm_init_finished");
}

function private on_ai_init(params) {
  function_f1e5805da192a1ef("run", "aitype_default", 0);
  callback::remove("on_ai_init", &on_ai_init);
}