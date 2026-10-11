/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3e697e1d89438f5f.gsc
*************************************************/

#using script_26bf705f44166c60;
#using script_2cd07641bf71242a;
#using script_386dce0c73a2fdd4;
#using script_3badb8914eb5ac16;
#using script_40ee7223a578cbc8;
#using script_55418e45f89bc1e0;
#using script_66f322ebddc9485b;
#using script_78ded6cdfff8b056;
#using script_7edf952f8921aa6b;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\variant_asm;
#using scripts\common\callbacks;
#using scripts\engine\utility;
#namespace zombie_base_asm;

function private function_f49a30f92555b827() {
  shouldstrip = self function_70eafce34621eaa2();
  function_29b5fb70d7ea841();
  function_304c63cbb536c526(shouldstrip);
  function_a8d762b7f47cf728();
  function_7dcdb0119cb801c6();
  function_d03eea41ff9cfe90();
  function_52b682d1bb0ddc02();
  function_a40873f83b05ce3c();
  callback::get_template(self.animsetname) callback::add("on_move_speed_changed", &on_move_speed_changed);
  level.scr_anim[self.animname]["spawn"] = "spawn";
  level.scr_anim[self.animname]["spawn_hop"] = "spawn_hop";
  level.scr_anim[self.animname]["spawn_barrel_44"] = "spawn_barrel_44";
  level.scr_anim[self.animname]["spawn_barrel_48"] = "spawn_barrel_48";
  level.scr_anim[self.animname]["spawn_ceiling_112"] = "spawn_ceiling_112";
  level.scr_anim[self.animname]["spawn_ceiling_144"] = "spawn_ceiling_144";
  level.scr_anim[self.animname]["spawn_container_36"] = "spawn_container_36";
  level.scr_anim[self.animname]["spawn_container_4"] = "spawn_container_44";
  level.scr_anim[self.animname]["spawn_fireplace"] = "spawn_fireplace";
  level.scr_anim[self.animname]["spawn_fast"] = "spawn_fast";
  level.scr_anim[self.animname]["spawn_wall"] = "spawn_wall";
  level.scr_anim[self.animname]["spawn_trashbin"] = "spawn_trashbin";
  level.scr_anim[self.animname]["spawn_under_bed"] = "spawn_under_bed";
  level.scr_anim[self.animname]["spawn_abom_crawler"] = "spawn_abom_crawler";
  level.scr_anim[self.animname]["spawn_bank_window_up_92_1"] = "spawn_bank_window_up_92_1";
  level.scr_anim[self.animname]["spawn_bank_window_up_92_2"] = "spawn_bank_window_up_92_2";
  level.scr_anim[self.animname]["spawn_bank_window_up_94_1"] = "spawn_bank_window_up_94_1";
  level.scr_anim[self.animname]["spawn_bank_window_up_94_2"] = "spawn_bank_window_up_94_2";
  level.scr_anim[self.animname]["nest_crawler_idle"] = "nest_crawler_idle";
  level.scr_anim[self.animname]["nest_crawler_idle_two_drop_01"] = "nest_crawler_idle_two_drop_01";
  level.scr_anim[self.animname]["nest_crawler_idle_two_drop_02"] = "nest_crawler_idle_two_drop_02";
  level.scr_anim[self.animname]["spawn_nest_crawler_single"] = "spawn_nest_crawler_single";
  level.scr_anim[self.animname]["spawn_nest_crawler_double_01"] = "spawn_nest_crawler_double_01";
  level.scr_anim[self.animname]["spawn_nest_crawler_double_02"] = "spawn_nest_crawler_double_02";
  level.scr_anim[self.animname]["humangun_turn_from"] = "humangun_turn_from";
  level.scr_anim[self.animname]["humangun_turn_into"] = "humangun_turn_into";
  level.scr_anim[self.animname]["humangun_turned_death_outro"] = "humangun_turned_death_outro";
  level.scr_anim[self.animname]["falling"] = "falling";
  level.scr_anim[self.animname]["jump_across_128"] = "jump_across_128";
}

function zombieinit(asmname, statename, params) {
  function_a343ac31ca854535(&function_f49a30f92555b827);
  self.asm.footsteps = spawnStruct();
  self.asm.footsteps.foot = "invalid";
  self.asm.footsteps.time = 0;
  self.asm.customdata = spawnStruct();
  asm_setmoveplaybackrate(1);
  init_melee();
  function_3426adec3c5d6cb6();
  function_64d97cf652a4d385();
  init_pain();
  init_traverse();
  callback::add("on_ai_init", &on_ai_init);
  ent_flag_set("zombie_asm_init_finished");
}

function private on_ai_init(params) {
  function_f1e5805da192a1ef("walk", "aitype_default", 0);
  callback::remove("on_ai_init", &on_ai_init);
}

function private on_move_speed_changed(params) {
  self._blackboard.var_f20ced1f24ab8752 = random([1, 0]);
}