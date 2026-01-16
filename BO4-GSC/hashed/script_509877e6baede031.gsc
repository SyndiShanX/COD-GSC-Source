/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_509877e6baede031.gsc
***********************************************/

#include scripts\core_common\aat_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\zm\zm_hms_util;
#include scripts\zm_common\zm_sq;

#namespace namespace_3417f8d2;

autoexec __init__system__() {
  system::register(#"hash_684e9a488b07947", &init, undefined, undefined);
}

init() {
  init_clientfields();
  level flag::init(#"hash_7d5f27392b7264ae");
  level flag::init(#"hash_7d5f26392b7262fb");
  level flag::init(#"hash_51ae2a56153f7f83");
  zm_sq::register(#"hash_22d9cdbaac99885", #"step_1", #"hash_7b16b0c7f4445917", &function_a8fa5ac7, &function_8686db4c);
  zm_sq::register(#"hash_22d9cdbaac99885", #"step_2", #"hash_7b16b1c7f4445aca", &function_ebc2f134, &function_dc7d5745);
  zm_sq::register(#"hash_22d9cdbaac99885", #"step_3", #"hash_7b16b2c7f4445c7d", &function_d0d114be, &function_2beb73f6);
  zm_sq::start(#"hash_22d9cdbaac99885");
}

init_clientfields() {
  clientfield::register("scriptmover", "" + #"hash_671ee63741834a25", 1, 1, "int");
}

function_a8fa5ac7(var_5ea5c94d) {
  level thread setup_phone_audio();

  if(!var_5ea5c94d) {
    level flag::wait_till(#"hash_7d5f27392b7264ae");
  }
}

function_8686db4c(var_5ea5c94d, ended_early) {
  if(var_5ea5c94d || ended_early) {
    level.var_c2e6ed5a++;
    return;
  }

  level.var_2363fbdb = 0;
  function_72d3152();
}

function_ebc2f134(var_5ea5c94d) {
  if(!var_5ea5c94d) {
    level flag::wait_till(#"hash_7d5f26392b7262fb");
  }
}

function_dc7d5745(var_5ea5c94d, ended_early) {
  if(var_5ea5c94d || ended_early) {
    level.var_c2e6ed5a++;
    return;
  }

  level.var_2363fbdb = 0;
  function_72d3152();
}

function_d0d114be(var_5ea5c94d) {
  if(!var_5ea5c94d) {
    level flag::wait_till(#"hash_51ae2a56153f7f83");
  }
}

function_2beb73f6(var_5ea5c94d, ended_early) {
  if(var_5ea5c94d || ended_early) {
    level function_ccd6d7bc();
    return;
  }

  level function_ccd6d7bc();
}

setup_phone_audio() {
  wait 1;
  level.var_2363fbdb = 0;
  level.var_c2e6ed5a = 0;
  level.var_1c33dba2 = getEntArray("secret_phone_trig", "targetname");
  array::thread_all(level.var_1c33dba2, &phone_init);
}

phone_init() {
  if(!isDefined(self)) {
    return;
  }

  self.e_phone = struct::get(self.target, "targetname");

  if(isDefined(self.e_phone)) {
    self.e_phone scene::play("blinking");
  }

  self usetriggerrequirelookat();
  self setcursorhint("HINT_NOICON");
  self thread function_a546fd97();
}

function_a546fd97() {
  self endon(#"death");

  while(true) {
    s_notify = self waittill(#"damage");
    add_outtime = s_notify.attacker aat::getaatonweapon(s_notify.weapon);

    if(isDefined(add_outtime) && add_outtime.name === "zm_aat_kill_o_watt") {

      getplayers()[0] iprintln("<dev string:x38>");

        level.var_2363fbdb += 1;
      self.e_phone scene::play("ring");

      if(level.var_2363fbdb == 3) {
        wait 1;
        self thread function_7dbe8985();
        wait 1;
      }

      self waittill(#"dialog_played");
      self.e_phone scene::play("blinking");
      wait 1;
    }
  }
}

function_7dbe8985() {
  if(level.var_c2e6ed5a == 0) {
    zm_hms_util::function_e308175e(#"hash_10486eedc1e9fad", self.origin);
    level flag::set(#"hash_7d5f27392b7264ae");
  } else if(level.var_c2e6ed5a == 1) {
    zm_hms_util::function_e308175e(#"hash_6742a63120f41d3b", self.origin);
    level flag::set(#"hash_7d5f26392b7262fb");
  } else {
    zm_hms_util::function_e308175e(#"hash_1678ea887d624d95", self.origin);
    level flag::set(#"hash_51ae2a56153f7f83");
  }

  level.var_c2e6ed5a += 1;
}

function_72d3152() {
  foreach(trigger in level.var_1c33dba2) {
    trigger notify(#"dialog_played");
  }
}

function_ccd6d7bc() {
  foreach(trigger in level.var_1c33dba2) {
    trigger.e_phone scene::play("init");
    trigger delete();
  }
}