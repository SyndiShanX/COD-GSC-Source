/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\aitypes\zombie_base\zombie_base.gsc
**********************************************************/

#using script_22e5ad6fd19f0770;
#using script_38c251115537f16e;
#using script_3badb8914eb5ac16;
#using script_405d05c89e998922;
#using script_45db5d9949648894;
#using script_466b725e9bac18fd;
#using script_7edf952f8921aa6b;
#using script_a12e958c96b6c57;
#using scripts\aitypes\bt_util;
#using scripts\aitypes\zombie_base\zombie_base_audio;
#using scripts\anim\utility_common;
#using scripts\anim\weaponlist;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\utility;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace zombie_base;

function precache(params) {
  function_582bd4b9c9a2091d(params);
}

function private function_f49a30f92555b827(params) {
  function_dbd4fdd08f5252a3();
  function_976734974e28596e();
  function_8e401d26d58bc32d();
  function_b718bd8a845dc9ab();
  callback::get_template(self.animsetname) callback::add("on_turned", &function_e809d2e0583ea302);
  callback::get_template(self.animsetname) callback::add("shocked", &function_c8bbb80c04cd9a37);
  callback::get_template(self.animsetname) callback::add("shocked_end", &function_deadba29b36b687d);
  callback::get_template(self.animsetname) callback::add("burned", &function_bf0fe7b30fa14180);
  callback::get_template(self.animsetname) callback::add("burned_end", &function_788a3fa28ef17f52);
  callback::get_template(self.animsetname) callback::add("napalm_burned", &function_dbb5710ec418627e);
  callback::get_template(self.animsetname) callback::add("napalm_burned_end", &function_afa5ec2deb3f62a0);
  callback::get_template(self.animsetname) callback::add("killed_body_cloned", &function_c8c10b313b3fcf09);
  callback::get_template(self.animsetname) callback::add("on_is_crawling_changed", &function_d9b1a731573b17c6);

  namespace_fc8e35fbcefcfd94::function_a9bcc765070d0b08();
  namespace_d30035ccbf6888e3::function_71fb46ec2e0bf63();
  function_cd37404b5eaaf996();
}

function zombieinit(taskid) {
  assert(isDefined(self.zombieaisetting));
  zombie_init_ai(self.zombieaisetting);
  callback::add("on_first_ai_init", &function_f49a30f92555b827);
  function_1fc0eb1eb90c8dd0("walk", 100);
  function_1fc0eb1eb90c8dd0("run", 120);
  self.var_c3554a26521188a8 = &function_a8c9248308033e4e;
  function_265e0e58c950559();
  function_f54dcf741aec59fb();
  function_7f1a5cba2db537c5();
  function_9d6df53b2bb22d73();
  init_knockdown();

  if(isDefined(self._blackboard.var_955e413d1be8201a) && istrue(self._blackboard.var_955e413d1be8201a)) {
    function_665db26685801f1c();
  }

  thread initscriptable();
  return anim.success;
}

function initscriptable() {
  self endon("death");
  scripts\engine\utility::flag_wait("scriptables_ready");
  waitframe();

  if(self isscriptable()) {
    utility::function_3ab9164ef76940fd("base", "base_on");
  }
}

function private function_c8c10b313b3fcf09(params) {
  utility::function_3ab9164ef76940fd("base", "base_off");

  if(isDefined(params.body)) {
    params.body utility::function_3ab9164ef76940fd("base", "base_off");
  }

  if(istrue(ent_flag("burned"))) {
    if(isDefined(params.body)) {
      params.body utility::function_3ab9164ef76940fd("burned", "burned_on");
      params.body thread function_d13d798c34386976();
    }
  } else if(istrue(ent_flag("napalm_burned"))) {
    if(isDefined(params.body)) {
      params.body utility::function_3ab9164ef76940fd("napalm_burned", "napalm_burned_on");
      params.body thread function_c14610f0b3bdffe6();
    }
  } else if(istrue(ent_flag("frost_killed"))) {
    if(isDefined(params.body)) {
      params.body utility::function_3ab9164ef76940fd("cryofreeze", "cryofreeze_dead");
      params.body thread function_4aa6775b3d57186b();
    }
  } else if(istrue(ent_flag("dissolve"))) {
    if(isDefined(params.body)) {
      params.body utility::function_3ab9164ef76940fd("reveal_death_blue_glow", "reveal_death_blue_glow");
    }
  } else if(istrue(ent_flag("plasma_death_pap"))) {
    if(isDefined(params.body)) {
      params.body utility::function_3ab9164ef76940fd("reveal_death_red", "reveal_death_red");
    }
  } else if(istrue(ent_flag("plasma_death"))) {
    if(isDefined(params.body)) {
      params.body utility::function_3ab9164ef76940fd("reveal_death_purple", "reveal_death_purple");
    }
  }

  if(isDefined(params.body)) {
    params.body thread function_cf1ce6f676b10723();
  }
}

function private function_d13d798c34386976() {
  wait 3;

  if(isDefined(self)) {
    utility::function_3677f2be30fdd581("burned", "burned_off");
  }

  var_8a5b82acd7668d1d = 0;

  if(isDefined(self)) {
    var_8a5b82acd7668d1d = utility::function_3677f2be30fdd581("burned", "burned_dead");
  }

  if(istrue(var_8a5b82acd7668d1d)) {
    return;
  }

  if(isDefined(self)) {
    utility::function_3677f2be30fdd581("burned", "burned_dead");
  }

  wait 3;

  if(isDefined(self)) {
    utility::function_3677f2be30fdd581("burned", "burned_off");
  }
}

function private function_c14610f0b3bdffe6() {
  wait 3.7;
  var_8a5b82acd7668d1d = 0;

  if(isDefined(self)) {
    var_8a5b82acd7668d1d = utility::function_3677f2be30fdd581("napalm_burned", "napalm_burned_dead");
  }

  if(istrue(var_8a5b82acd7668d1d)) {
    return;
  }

  if(isDefined(self)) {
    utility::function_3677f2be30fdd581("napalm_burned", "napalm_burned_end");
  }

  wait 3;

  if(isDefined(self)) {
    utility::function_3677f2be30fdd581("napalm_burned", "napalm_burned_off");
  }
}

function private function_4aa6775b3d57186b() {
  wait 5;

  if(isDefined(self)) {
    utility::function_3677f2be30fdd581("cryofreeze", "cryofreeze_off");
  }
}

function private function_c8bbb80c04cd9a37(var_a21093610d4de2ed) {
  utility::function_3ab9164ef76940fd("shocked", "shocked_on");
}

function private function_deadba29b36b687d(var_a21093610d4de2ed) {
  utility::function_3677f2be30fdd581("shocked", "shocked_off");
}

function private function_bf0fe7b30fa14180(var_12c084a213d7ad2) {
  utility::function_3ab9164ef76940fd("burned", "burned_on");
}

function private function_788a3fa28ef17f52(var_12c084a213d7ad2) {
  utility::function_3677f2be30fdd581("burned", "burned_off");
}

function private function_dbb5710ec418627e(var_12c084a213d7ad2) {
  utility::function_3ab9164ef76940fd("napalm_burned", "napalm_burned_on");
}

function private function_afa5ec2deb3f62a0(var_12c084a213d7ad2) {
  ent_flag_clear("napalm_burned");
  utility::function_3677f2be30fdd581("napalm_burned", "napalm_burned_off");
}

function private function_e809d2e0583ea302(var_8c62cb683d643eb7) {
  function_f1e5805da192a1ef("super_sprint", "turned", 25);
  utility::function_3ab9164ef76940fd("base", "base_off");
  utility::function_3ab9164ef76940fd("brainrot", "brainrot_on");
  self._blackboard.var_8d19c6ba087e7a86 = 1;
}

function function_a8c9248308033e4e() {
  if(namespace_9e6ef02d993a7eba::is_crawling()) {
    return false;
  }

  if(function_ef549c6c35e41708()) {
    return false;
  }

  if(istrue(self.var_f8a44d7cde24460a)) {
    return false;
  }

  return true;
}

function private function_cf1ce6f676b10723() {
  level endon("game_ended");
  self waittill("corpse_deleted", position);

  if(isDefined(position)) {}
}

function private function_d9b1a731573b17c6(params) {
  self._blackboard.var_94f78603f930cce6 = 65;
  self.var_5b7cb9371ba53dc8 = undefined;
}