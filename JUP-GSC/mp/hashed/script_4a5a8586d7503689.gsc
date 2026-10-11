/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_4a5a8586d7503689.gsc
*************************************************/

#using script_1336e8b6e220bbfa;
#using script_23b580b08abe064f;
#using script_2cd07641bf71242a;
#using script_3badb8914eb5ac16;
#using script_3fe2c7524c8d3505;
#using script_56e851046f535a9a;
#using script_7edf952f8921aa6b;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\variant_asm;
#using scripts\common\callbacks;
#using scripts\engine\utility;
#namespace namespace_dc9c4cdd011135ef;

function private function_f49a30f92555b827() {
  function_29b5fb70d7ea841();
  function_304c63cbb536c526();
  callback::get_template(self.animsetname) callback::add("on_move_speed_changed", &on_move_speed_changed);
  level.scr_anim[self.animname]["spawn"] = "spawn";
  level.scr_anim[self.animname]["dig"] = "dig";
  level.scr_anim[self.animname]["drop"] = "drop";
  level.scr_anim[self.animname]["spawn_ground"] = "spawn_ground";
  level.scr_anim[self.animname]["howl"] = "howl";
  level.scr_anim[self.animname]["spawn_fast"] = "spawn";
}

function function_e62bc0179274066c(asmname, statename, params) {
  function_a343ac31ca854535(&function_f49a30f92555b827);
  self.asm.footsteps = spawnStruct();
  self.asm.footsteps.foot = "invalid";
  self.asm.footsteps.time = 0;
  self.asm.customdata = spawnStruct();
  asm_setmoveplaybackrate(1);
  init_melee();
  function_659c38a2f52dc596();
  function_64d97cf652a4d385();
  init_traverse();
  function_c1fd3bf3e4513334();
  callback::add("on_ai_init", &on_ai_init);
  ent_flag_set("zombie_asm_init_finished");
}

function private on_ai_init(params) {
  function_f1e5805da192a1ef("run", "aitype_default", 0);
  callback::remove("on_ai_init", &on_ai_init);
}

function private on_move_speed_changed(params) {}