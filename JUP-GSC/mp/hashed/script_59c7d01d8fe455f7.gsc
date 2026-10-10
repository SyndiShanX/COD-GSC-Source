/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_59c7d01d8fe455f7.gsc
*************************************************/

#using script_2cd07641bf71242a;
#using script_3badb8914eb5ac16;
#using script_3e4f26df9dc4b465;
#using script_4d5690421d14cda9;
#using script_4fa22bc28608e9bd;
#using script_7edf952f8921aa6b;
#using script_ac32c5a74321662;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\variant_asm;
#using scripts\common\callbacks;
#using scripts\engine\utility;
#namespace namespace_50f6658a88689353;

function private function_f49a30f92555b827() {
  function_e763a1820edbfd28();
  function_7e95224caecd6944();
  function_3f12f7bb3b0f7b28();
  level.scr_anim[self.animname]["spawn"] = "spawn";
  level.scr_anim[self.animname]["spawn_fast"] = "spawn_fast";
  callback::function_e7fddda1f0b46b5e(self.animsetname) callback::add("on_move_speed_changed", &on_move_speed_changed);
}

function function_f4d5b246417ef16a(asmname, statename, params) {
  function_a343ac31ca854535(&function_f49a30f92555b827);
  self.asm.footsteps = spawnStruct();
  self.asm.footsteps.foot = "invalid";
  self.asm.footsteps.time = 0;
  self.asm.customdata = spawnStruct();
  asm_setmoveplaybackrate(1);
  thread wander_listener();
  function_64d97cf652a4d385();
  function_a9a0b485d2e58d71();
  function_949f643edcd1aade();
  function_d956fa70427897a();
  function_99484082dc3884de();
  callback::add("on_ai_init", &on_ai_init);
  ent_flag_set("zombie_asm_init_finished");
}

function private on_ai_init(params) {
  function_f1e5805da192a1ef("run", "aitype_default", 0);
  callback::remove("on_ai_init", &on_ai_init);
}

function wander_listener() {
  self endon("death");

  while(true) {
    self waittill("wander_start");
    function_f1e5805da192a1ef("walk", "wander", 22);
    self waittill("wander_end");
    function_f1e5805da192a1ef(undefined, "wander");
  }
}

function on_move_speed_changed(params) {
  self.var_30158902d2e2c3c0 = self aigetdesiredspeed();
}