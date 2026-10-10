/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_1e2b21a2f6c06fac.gsc
*************************************************/

#using script_595089f78ef8e11b;
#using scripts\asm\asm_bb;
#using scripts\common\callbacks;
#using scripts\engine\math;
#using scripts\engine\utility;
#namespace namespace_4f424515b9703262;

function function_842e17022dab63c3() {
  if(flag("hellhound_audio")) {
    return;
  }

  flag_set("hellhound_audio");
  function_f11270bb42f7f080("ambient_unaware", "ambient_unaware", "vox_ai_hellhound_ambient_unaware", 1);
  function_f11270bb42f7f080("ambient_aware", "ambient_aware", "vox_ai_hellhound_ambient_aware", 1);
  function_f11270bb42f7f080("breath_inhale_slow", "breath_inhale_slow", "vox_ai_hellhound_breath_inhale_slow", 1);
  function_f11270bb42f7f080("breath_inhale_fast", "breath_inhale_fast", "vox_ai_hellhound_breath_inhale_fast", 1);
  function_f11270bb42f7f080("breath_exhale_slow", "breath_exhale_slow", "vox_ai_hellhound_breath_exhale_slow", 1);
  function_f11270bb42f7f080("breath_exhale_fast", "breath_exhale_fast", "vox_ai_hellhound_breath_exhale_fast", 1);
  function_f11270bb42f7f080("warning_close", "warning_close", "vox_ai_hellhound_warning_close", 2);
  function_f11270bb42f7f080("zombie_pain_start", "pain", "vox_ai_hellhound_pain", 3);
  function_f11270bb42f7f080("bite_vox", "attack", "vox_ai_hellhound_attack", 3);
  level callback::add("player_connect", &function_720c096e235021fd, self.basearchetype);

  foreach(player in level.players) {
    player thread function_720c096e235021fd(undefined, self.basearchetype);
  }

  level thread function_1dc3dbebbb45158a();
}

function function_8f8cff4c91f6845b() {
  thread function_78c6b4fdf8524643();
  function_3b76e1d247d2f5a(&function_cd12e4b6f6fa089c);
  callback::add("killed_body_cloned", &play_death_vo);
}

function private function_cd12e4b6f6fa089c(event, zombie, var_c2aec59361d95878, alias, priority) {
  switch (event) {
    case #"hash_c29acedba2860c6d":
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
    self setscriptablepartstate("sound_vo", "off");
  }

  level thread function_cd12e4b6f6fa089c("death", params.body, "death", "vox_ai_hellhound_death", 4);
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
      if(percent_chance(params.var_76897e90bbff1185) || var_fa42533f2450f37a >= 5) {
        var_fa42533f2450f37a = 0;
        ambient_notify = "breath_exhale_" + params.var_f894d0cd3d945874;
      } else {
        var_fa42533f2450f37a++;
        ambient_notify = "breath_exhale_" + params.var_f894d0cd3d945874;
      }

      var_36ac830085c37706 = 1;
    } else {
      ambient_notify = "breath_inhale_" + params.var_f894d0cd3d945874;
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
  params.var_b1b1f6668aecbbe5 = "ambient_unaware";
  params.var_f894d0cd3d945874 = "slow";
  params.var_76897e90bbff1185 = 1;

  if(isDefined(self.enemy)) {
    params.var_b1b1f6668aecbbe5 = "ambient_aware";

    if(bb_movetyperequested("run") || bb_movetyperequested("sprint") || bb_movetyperequested("super_sprint")) {
      params.var_f894d0cd3d945874 = "fast";
      params.var_76897e90bbff1185 = 1;
    } else {
      params.var_f894d0cd3d945874 = "slow";
      params.var_76897e90bbff1185 = 1;
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

function private function_720c096e235021fd(params, archetype) {
  thread function_4af19ec43ed1888e(archetype);
}

function private function_4af19ec43ed1888e(archetype) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");

  while(true) {
    wait 0.5;
    ai_array = getaiarrayinradius(self.origin, 750);

    if(isDefined(ai_array)) {
      foreach(ai in ai_array) {
        if(!isDefined(ai) || !isDefined(ai.basearchetype) || ai.basearchetype != archetype) {
          continue;
        }

        if(istrue(ai.var_926b0f07a813ecc8)) {
          continue;
        }

        if(!isDefined(ai.enemy) || ai.enemy != self || !isPlayer(ai.enemy)) {
          continue;
        }

        if(function_4974a1eb59f8524e(ai)) {
          ai function_f707c26d8f269f94("warning_close");
          ai thread function_9b98c632f16fb653();
          wait 0.25;
        }
      }
    }
  }
}

function private function_4974a1eb59f8524e(zombie) {
  dist = 750;
  distance = distance2dsquared(self.origin, zombie.origin);
  is_close = distance < dist * dist;
  var_2eb8073bda36e7eb = distance < 40000;
  assert(isPlayer(zombie.enemy));

  if(var_2eb8073bda36e7eb) {
    return 0;
  }

  return is_close;
}

function private function_9b98c632f16fb653() {
  self endon("death");
  self.var_926b0f07a813ecc8 = 1;
  wait 5;
  self.var_926b0f07a813ecc8 = 0;
}