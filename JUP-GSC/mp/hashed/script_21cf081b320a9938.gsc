/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_21cf081b320a9938.gsc
*************************************************/

#using script_595089f78ef8e11b;
#using scripts\asm\asm_bb;
#using scripts\common\callbacks;
#using scripts\engine\math;
#using scripts\engine\utility;
#namespace zombie_mimic_audio;

function function_62acb9a556ab5175() {
  if(flag("mimic_audio")) {
    return;
  }

  flag_set("mimic_audio");
  function_f11270bb42f7f080("vox_amb_slow", "vox_amb_slow", "vox_ai_mimic_ambient_slow", 1);
  function_f11270bb42f7f080("vox_amb_fast", "vox_amb_fast", "vox_ai_mimic_ambient_fast", 1);
  function_f11270bb42f7f080("vox_scream", "vox_scream", "vox_ai_mimic_ambient_scream", 1);
  function_f11270bb42f7f080("vox_pushback_scream", "vox_scream", "vox_ai_mimic_ambient_scream", 3);
  function_f11270bb42f7f080("vox_scream_long", "vox_scream_long", "vox_ai_mimic_ambient_scream_long", 2);
  function_f11270bb42f7f080("vox_melee", "vox_melee", "vox_ai_mimic_attack_melee", 2);
  function_f11270bb42f7f080("vox_tentacle_out", "vox_tentacle_out", "vox_ai_mimic_attack_tentacle_out", 3);
  function_f11270bb42f7f080("vox_tentacle_in", "vox_tentacle_in", "vox_ai_mimic_attack_tentacle_in", 3);
  function_f11270bb42f7f080("vox_spit", "vox_spit", "vox_ai_mimic_attack_spit_start", 3);
  function_f11270bb42f7f080("vox_spit_tail", "vox_spit_tail", "vox_ai_mimic_attack_spit_tail", 3);
  function_f11270bb42f7f080("vox_appear", "vox_appear", "vox_ai_mimic_appear", 3);
  function_f11270bb42f7f080("pain_electric_vox", "pain_electric", "vox_ai_mimic_pain_electric", 3);
  function_f11270bb42f7f080("vox_death", "vox_death", "vox_ai_mimic_death", 4);
  level thread function_1dc3dbebbb45158a();
  callback::get_template(self.animsetname) callback::add("killed_body_cloned", &play_death_vo);
  callback::get_template(self.animsetname) callback::add("on_entity_revealed", &function_c0b5ec9f8877f0c2);
  callback::get_template(self.animsetname) callback::add("on_entity_hidden_in_prop", &function_78f226fccfe4f778);
}

function function_1e388b876cdce171() {
  thread function_78c6b4fdf8524643();
  thread function_664debe3a324ac7a();
}

function private function_664debe3a324ac7a() {
  level endon("game_ended");
  self endon("death");

  while(true) {
    notifies = ["vox_scream_long", "vox_melee", "vox_tentacle_out", "vox_spit", "vox_appear", "vox_tentacle_in"];
    event = waittill_any_in_array_return(notifies);

    switch (event) {
      case #"hash_61c966d3596089cd":
      case #"hash_a7b8c1e16ee6914e":
      case #"hash_bab03b3033b60dc5":
      case #"hash_c43a5c8334deed2e":
      case #"hash_d7d7d13d52c04cdd":
        thread function_5bda47768887115f(1.75);
        break;
      case #"hash_3790fac69eee7c05":
      default:
        thread function_5bda47768887115f(1);
        break;
    }
  }
}

function private play_death_vo(params) {
  assert(isDefined(params.body));
  str_channel = function_fc041668d6654de8();
  self stopsoundchannel(str_channel);
  level thread play_vox(params.body, "vox_death", "vox_ai_mimic_death", 4);
}

function private function_c0b5ec9f8877f0c2(params) {
  thread function_78c6b4fdf8524643();

  if(self isscriptable()) {
    self setscriptablepartstate("sound_event", "emerge");
  }
}

function private function_78f226fccfe4f778(params) {
  self notify("ambientvox_shutdown");

  if(self isscriptable()) {
    self setscriptablepartstate("sound_event", "hide");
  }
}

function private function_5bda47768887115f(n_time) {
  self notify("stopambientvox_singleton");
  self endon("stopambientvox_singleton");
  self endon("death");
  self notify("ambientvox_shutdown");
  wait n_time;
  thread function_78c6b4fdf8524643();
}

function function_78c6b4fdf8524643() {
  ambient_cap = 3;
  self notify("ambientvox_singleton");
  self endon("ambientvox_singleton");
  self endon("ambientvox_shutdown");
  self endon("death");
  var_299fe3d37c321f97 = 0;

  while(true) {
    params = function_4e5d15fb46a1875f();
    ambient_notify = params.var_b1b1f6668aecbbe5;
    n_waittime = params.var_39dc1f6992cbf2cf;

    if(isDefined(level.zombie_ambient_count)) {
      level.zombie_ambient_count++;

      if(level.zombie_ambient_count < ambient_cap) {
        function_f707c26d8f269f94(ambient_notify);
        waitframe();
        ent_flag_waitopen("playing_vo");
      }
    }

    wait 0.1;
  }
}

function private function_4e5d15fb46a1875f() {
  params = spawnStruct();
  params.var_b1b1f6668aecbbe5 = "vox_amb_slow";
  params.var_39dc1f6992cbf2cf = 1.4;

  if(isDefined(self.enemy)) {
    params.var_b1b1f6668aecbbe5 = "vox_amb_fast";
    params.var_39dc1f6992cbf2cf = 0.7;
  }

  return params;
}

function private function_1dc3dbebbb45158a() {
  level endon("game_ended");
  level.zombie_ambient_count = 0;

  while(true) {
    level.zombie_ambient_count = 0;
    wait 0.1;
  }
}