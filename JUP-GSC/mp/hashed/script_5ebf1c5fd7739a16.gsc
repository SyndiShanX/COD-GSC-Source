/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_5ebf1c5fd7739a16.gsc
*************************************************/

#using script_595089f78ef8e11b;
#using scripts\asm\asm_bb;
#using scripts\common\callbacks;
#using scripts\engine\math;
#using scripts\engine\utility;
#namespace namespace_7833f5c4c30906a9;

function function_4c0620b02e3730ce() {
  if(flag("mangler_audio")) {
    return;
  }

  flag_set("mangler_audio");
  function_f11270bb42f7f080("breath_inhale", "breath_inhale", "dx_ob_mngl_mnge_mang_ailightbreathin", 1);
  function_f11270bb42f7f080("breath_exhale", "breath_exhale", "dx_ob_mngl_mnge_mang_ailightbreathout", 1);
  function_f11270bb42f7f080("breath_inhale_heavy", "breath_inhale_heavy", "dx_ob_mngl_mnge_mang_aihardbreathin", 1);
  function_f11270bb42f7f080("breath_exhale_heavy", "breath_exhale_heavy", "dx_ob_mngl_mnge_mang_aihardbreathout", 1);
  function_f11270bb42f7f080("vox_unaware", "vox_unaware", "dx_ob_mngl_mngc_mang_aiua", 2);
  function_f11270bb42f7f080("vox_aware", "vox_aware", "dx_ob_mngl_mngc_mang_aiaw", 2);
  function_f11270bb42f7f080("vox_taunt", "vox_taunt", "dx_ob_mngl_mngc_mang_aitn", 2);
  function_f11270bb42f7f080("vox_berserk", "vox_berserk", "dx_ob_mngl_mnge_mang_airg", 3);
  function_f11270bb42f7f080("vox_calmdown", "vox_calmdown", "dx_ob_mngl_mnge_mang_aicd", 3);
  function_f11270bb42f7f080("vox_laugh", "vox_laugh", "dx_ob_mngl_mnge_mang_aiml", 2);
  function_f11270bb42f7f080("vox_pain", "vox_pain", "dx_ob_mngl_mnge_mang_aipn", 3);
  function_f11270bb42f7f080("vox_melee", "vox_melee", "dx_ob_mngl_mnge_mang_aims", 2);
  function_f11270bb42f7f080("vox_shoot", "vox_shoot", "dx_ob_mngl_mnge_mang_aims", 2);
  function_f11270bb42f7f080("vox_mantle", "vox_mantle", "dx_ob_mngl_mnge_mang_aimn", 2);
  function_f11270bb42f7f080("vox_land", "vox_land", "dx_ob_mngl_mnge_mang_aild", 2);
  callback::function_e7fddda1f0b46b5e(self.animsetname) callback::add("killed_body_cloned", &play_death_vo);
  level thread function_1dc3dbebbb45158a();
}

function function_1eba107019abdc18() {
  thread function_78c6b4fdf8524643();
  function_3b76e1d247d2f5a(&function_cd12e4b6f6fa089c);
  function_ad9433aab9fcdf04(1, ["death", "preventAmbientAudio"], &setscriptablepartstate, "ambient_audio", "on");
}

function private function_cd12e4b6f6fa089c(event, zombie, var_c2aec59361d95878, alias, priority) {
  switch (event) {
    case #"hash_3790fac69eee7c05":
      zombie function_5420e83b135ec96f(function_a5b14435e3229bed(1.5), 1);
      break;
    default:
      break;
  }

  play_vox(zombie, var_c2aec59361d95878, alias, priority);
}

function private play_death_vo(params) {
  assert(isDefined(params.body));

  if(self isscriptable()) {
    self setscriptablepartstate("ambient_audio", "off");
    self setscriptablepartstate("sound_vo", "off");
  }

  level thread function_cd12e4b6f6fa089c("death", params.body, "death", "dx_ob_mngl_mnge_mang_aidt", 4);
}

function function_78c6b4fdf8524643() {
  ambient_cap = 3;
  self endon("death");
  played_vox = 0;
  var_fa42533f2450f37a = 0;
  var_36ac830085c37706 = 1;

  while(true) {
    params = function_4e5d15fb46a1875f();

    if(!istrue(var_36ac830085c37706)) {
      if(percent_chance(params.var_76897e90bbff1185) || var_fa42533f2450f37a >= 15) {
        var_fa42533f2450f37a = 0;
        ambient_notify = params.var_b1b1f6668aecbbe5;
      } else {
        var_fa42533f2450f37a++;
        ambient_notify = ter_op(params.var_bb3f93c2abfcaf32, "breath_exhale_heavy", "breath_exhale");
      }

      var_36ac830085c37706 = 1;
    } else {
      ambient_notify = ter_op(params.var_bb3f93c2abfcaf32, "breath_inhale_heavy", "breath_inhale");
      var_36ac830085c37706 = 0;
    }

    if(isDefined(level.var_3c408363d81b00e0)) {
      level.var_3c408363d81b00e0++;

      if(level.var_3c408363d81b00e0 < ambient_cap) {
        played_vox = 1;
        function_f707c26d8f269f94(ambient_notify);
        waitframe();
        ent_flag_waitopen("playing_vo");
      }
    }

    waitframe();
  }
}

function private function_4e5d15fb46a1875f() {
  params = spawnStruct();
  params.var_b1b1f6668aecbbe5 = "vox_unaware";
  params.var_bb3f93c2abfcaf32 = 0;
  params.var_76897e90bbff1185 = 5;

  if(isDefined(self.enemy)) {
    params.var_b1b1f6668aecbbe5 = "vox_aware";

    if(bb_movetyperequested("run") || bb_movetyperequested("sprint") || bb_movetyperequested("super_sprint")) {
      params.var_bb3f93c2abfcaf32 = 1;
      params.var_76897e90bbff1185 = 5;
    } else {
      params.var_76897e90bbff1185 = 10;
    }
  }

  return params;
}

function private function_1dc3dbebbb45158a() {
  level endon("game_ended");
  level.var_3c408363d81b00e0 = 0;

  while(true) {
    level.var_3c408363d81b00e0 = 0;
    wait 0.1;
  }
}