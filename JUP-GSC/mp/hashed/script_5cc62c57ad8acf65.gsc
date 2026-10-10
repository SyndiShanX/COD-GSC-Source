/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_5cc62c57ad8acf65.gsc
*************************************************/

#using script_1bfe8e965532ee8a;
#using script_2cd07641bf71242a;
#using script_33781ab60ef13663;
#using script_3badb8914eb5ac16;
#using script_7edf952f8921aa6b;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\variant_asm;
#using scripts\common\callbacks;
#using scripts\engine\utility;
#namespace namespace_ce4d65499c0c19a1;

function private function_f49a30f92555b827() {
  function_a66b42c7ea0c395b();
  function_fc3f9083a8c8a68c();
  function_96f220b689167b22();
  callback::function_e7fddda1f0b46b5e(self.animsetname) callback::add("on_is_moving_melee_changed", &on_is_moving_melee_changed);
  callback::function_e7fddda1f0b46b5e(self.animsetname) callback::add("on_move_speed_changed", &on_move_speed_changed);
  level.scr_anim[self.animname]["spawn"] = "spawn";
  level.scr_anim[self.animname]["spawn_fast"] = "spawn_fast";
  level.scr_anim[self.animname]["emerge"] = "emerge";
  level.scr_anim[self.animname]["emerge_sprint"] = "emerge_sprint";
  level.scr_anim[self.animname]["emerge_attack"] = "emerge_attack";
  level.scr_anim[self.animname]["emerge_attack_hit"] = "emerge_attack_hit";
  level.scr_anim[self.animname]["emerge_attack_miss"] = "emerge_attack_miss";
}

function function_25dabcda59af1c66(asmname, statename, params) {
  if(ent_flag("zombie_asm_init_finished")) {
    return;
  }

  function_a343ac31ca854535(&function_f49a30f92555b827);
  self.asm.footsteps = spawnStruct();
  self.asm.footsteps.foot = "invalid";
  self.asm.footsteps.time = 0;
  self.asm.customdata = spawnStruct();
  asm_setmoveplaybackrate(1);
  thread wander_listener();
  function_8626c13b5be18c1b("melee");
  function_64d97cf652a4d385();
  function_714b93f3cd89e618();
  callback::add("on_ai_init", &on_ai_init);
  ent_flag_set("zombie_asm_init_finished");
}

function private on_ai_init(params) {
  function_f1e5805da192a1ef("run", "aitype_default", 0);
  callback::remove("on_ai_init", &on_ai_init);
}

function on_move_speed_changed(params) {
  function_8626c13b5be18c1b("melee");
  function_8626c13b5be18c1b("move");
}

function on_is_moving_melee_changed(params) {
  function_8626c13b5be18c1b("melee");
  function_8626c13b5be18c1b("move");
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

function function_fc3f9083a8c8a68c() {
  function_406984e213848212("move", &function_eee30195769f679e, &function_3efc6f398dd71d26);
  function_3f5173a731bdfe2f("move", function_8776345ecd2673e5("walk"), 2);
  function_3f5173a731bdfe2f("move", function_8776345ecd2673e5("run"), 2);
}

function private function_8776345ecd2673e5(move_type) {
  struct = spawnStruct();
  struct.move_type = move_type;
  return struct;
}

function private function_eee30195769f679e(struct) {
  alias = "";

  if(isDefined(struct.move_type)) {
    alias += struct.move_type;

    if(self._blackboard.movetype != struct.move_type) {
      return undefined;
    }
  }

  return alias;
}

function private function_3efc6f398dd71d26(alias) {
  self function_164c05dd1bcfbca7("move", alias);

  if(asm_currentstatehasflag(self.asmname, "move")) {
    asm_fireevent_internal(self.asmname, "loop_reroll_anim");
  }
}

function function_a66b42c7ea0c395b() {
  function_406984e213848212("melee", &function_79d559d24ce75889, &function_f01c824a76203041);
  function_3f5173a731bdfe2f("melee", function_28d26d7ead912662(1, "walk"));
  function_3f5173a731bdfe2f("melee", function_28d26d7ead912662(1, "run"));
  function_3f5173a731bdfe2f("melee", function_28d26d7ead912662(0, undefined));
}

function private function_28d26d7ead912662(var_f261c2f31d7de033, move_type) {
  struct = spawnStruct();
  struct.var_f261c2f31d7de033 = var_f261c2f31d7de033;
  struct.move_type = move_type;
  return struct;
}

function private function_79d559d24ce75889(struct) {
  alias = "";

  if(isDefined(struct.var_f261c2f31d7de033)) {
    alias += ter_op(istrue(self.var_f261c2f31d7de033), "move", "static");

    if(istrue(self.var_f261c2f31d7de033) != struct.var_f261c2f31d7de033) {
      return undefined;
    }
  }

  if(isDefined(struct.move_type)) {
    alias += "_" + struct.move_type;

    if(self._blackboard.movetype != struct.move_type) {
      return undefined;
    }
  }

  return alias;
}

function private function_f01c824a76203041(alias) {
  self function_164c05dd1bcfbca7("melee", alias);
}