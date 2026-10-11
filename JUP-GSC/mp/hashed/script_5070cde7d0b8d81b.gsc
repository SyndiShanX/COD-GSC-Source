/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_5070cde7d0b8d81b.gsc
*************************************************/

#using script_2b848668600efa30;
#using script_2cd07641bf71242a;
#using script_33781ab60ef13663;
#using script_3badb8914eb5ac16;
#using script_620eb610e5593d47;
#using script_7edf952f8921aa6b;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\variant_asm;
#using scripts\common\callbacks;
#using scripts\engine\utility;
#namespace zombie_mangler_asm;

function private function_f49a30f92555b827() {
  function_304c63cbb536c526();
  function_29b5fb70d7ea841();
  function_96f220b689167b22();
}

function function_e3e1894798c371bf(asmname, statename, params) {
  function_a343ac31ca854535(&function_f49a30f92555b827);
  self.asm.footsteps = spawnStruct();
  self.asm.footsteps.foot = "invalid";
  self.asm.footsteps.time = 0;
  self.asm.customdata = spawnStruct();
  asm_setmoveplaybackrate(1);
  function_161807de85552fb();
  function_bd41a979b3c3bcb6();
  function_64d97cf652a4d385();
  callback::add("on_ai_init", &on_ai_init);
  ent_flag_set("zombie_asm_init_finished");
}

function private on_ai_init(params) {
  function_f1e5805da192a1ef("walk", "aitype_default", 0);
  callback::remove("on_ai_init", &on_ai_init);
}