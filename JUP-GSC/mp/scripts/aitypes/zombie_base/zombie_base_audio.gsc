/****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\aitypes\zombie_base\zombie_base_audio.gsc
****************************************************************/

#using script_405d05c89e998922;
#using script_595089f78ef8e11b;
#using scripts\asm\asm_bb;
#using scripts\common\callbacks;
#using scripts\engine\math;
#using scripts\engine\utility;
#namespace zombie_base_audio;

function function_dbd4fdd08f5252a3() {
  if(flag("zombie_base_audio")) {
    return;
  }

  flag_set("zombie_base_audio");
  function_f11270bb42f7f080("ambient_normal", "ambient_normal", "vox_ai_zombie_ambient", 1);
  function_f11270bb42f7f080("ambient_crawl", "ambient_crawl", "vox_ai_zombie_crawl", 1);
  function_f11270bb42f7f080("ambient_sprint", "ambient_sprint", "vox_ai_zombie_sprint", 1);
  function_f11270bb42f7f080("ambient_investigate", "ambient_investigate", "vox_ai_zombie_investigate", 1);
  function_f11270bb42f7f080("ambient_redzone", "ambient_redzone", "vox_ai_zombie_ambient_redzone", 1);
  function_f11270bb42f7f080("anim_redzone", "anim_redzone", "vox_ai_zombie_idle_to_aware", 1);
  function_f11270bb42f7f080("zombie_pain_start", "pain", "vox_ai_zombie_pain", 3);
  function_f11270bb42f7f080("pain_electric_vox", "pain_electric", "vox_ai_zombie_pain_electric", 3);
  function_f11270bb42f7f080("melee_vox", "attack", "vox_ai_zombie_attack", 2);
  function_f11270bb42f7f080("toss_vox", "throw", "vox_ai_zombie_attack", 2);
  function_f11270bb42f7f080("behind_vox", "behind", "vox_ai_zombie_behind", 3);
  function_f11270bb42f7f080("zombie_transform", "transform", "vox_ai_zombie_transform", 3);
  function_ea9336bca9113548("zombie_base_abom_crawler", "ambient_normal", "ambient_normal", "vox_ai_abom_crawl_ambient", 1);
  function_ea9336bca9113548("zombie_base_abom_crawler", "ambient_crawl", "ambient_normal", "vox_ai_abom_crawl_ambient", 1);
  function_ea9336bca9113548("zombie_base_abom_crawler", "ambient_sprint", "ambient_normal", "vox_ai_abom_crawl_ambient", 1);
  function_ea9336bca9113548("zombie_base_abom_crawler", "ambient_investigate", "ambient_normal", "vox_ai_abom_crawl_ambient", 1);
  function_ea9336bca9113548("zombie_base_abom_crawler", "ambient_redzone", "ambient_normal", "vox_ai_abom_crawl_ambient", 1);
  level callback::add("player_connect", &function_622dfa9ef1c9ec44, self.basearchetype);

  foreach(player in level.players) {
    player thread function_622dfa9ef1c9ec44(undefined, self.basearchetype);
  }

  level thread function_1dc3dbebbb45158a();
  callback::get_template(self.animsetname) callback::add("killed_body_cloned", &play_death_vo);
  callback::get_template(self.animsetname) callback::add("shocked", &function_7ca612e0628da67);
  callback::get_template(self.animsetname) callback::add("on_zombie_ai_damaged", &function_94fe21f6edbcec92);
}

function function_f54dcf741aec59fb() {
  thread function_78c6b4fdf8524643();
  function_3b76e1d247d2f5a(&play_zombie_vo);
  delaycall(1, &setentitysoundcontext, "gender", "zombie");
}

function private play_zombie_vo(event, zombie, scriptable_state, alias, priority) {
  switch (event) {
    case #"hash_17116e75dd0568d1":
    case #"hash_b694a70b9092bed1":
      zombie function_5420e83b135ec96f(function_a5b14435e3229bed(1.5), 1);
      break;
    default:
      break;
  }

  play_vox(zombie, scriptable_state, alias, priority);
}

function private play_death_vo(params) {
  assert(isDefined(params.body));

  if(self isscriptable()) {
    self setscriptablepartstate("sound_vo", "off");
  }

  str_channel = function_fc041668d6654de8();
  self stopsoundchannel(str_channel);

  if(self.subclass == "zombie_base_abom_crawler") {
    level thread play_zombie_vo("abom_crawl_death", params.body, "abom_crawl_death", "vox_ai_abom_crawl_death", 4);
    return;
  }

  level thread play_zombie_vo("death", params.body, "death", "vox_ai_zombie_death", 4);
}

function private function_94fe21f6edbcec92(params) {
  if(isDefined(self.var_1f34fdbb706d1253) && gettime() < self.var_1f34fdbb706d1253) {
    return;
  }

  self.var_1f34fdbb706d1253 = gettime() + 1000;
  function_f707c26d8f269f94("zombie_pain_start");
}

function private function_7ca612e0628da67(params) {
  function_f707c26d8f269f94("pain_electric_vox");
}

function function_78c6b4fdf8524643() {
  ambient_cap = 3;
  self endon("death");
  played_vox = 0;

  while(true) {
    if(self.subclass == "zombie_base_abom_crawler") {
      if(isDefined(self.movemode) && self.movemode == "stop") {
        wait 1;
        continue;
      }
    }

    ambient_notify = function_c9f228f5a6b505a0();

    if(isDefined(level.zombie_ambient_count)) {
      level.zombie_ambient_count++;

      if(level.zombie_ambient_count < ambient_cap) {
        played_vox = 1;
        function_f707c26d8f269f94(ambient_notify);
        waitframe();
        ent_flag_waitopen("playing_vo");
      }
    }

    if(played_vox) {
      played_vox = 0;
      wait randomfloatrange(0.5, 2);
      continue;
    }

    wait 0.1;
  }
}

function private function_c9f228f5a6b505a0() {
  if(isDefined(self.enemy)) {
    if(namespace_9e6ef02d993a7eba::is_crawling()) {
      return "ambient_crawl";
    } else if(bb_movetyperequested("run") || bb_movetyperequested("sprint") || bb_movetyperequested("super_sprint")) {
      return "ambient_sprint";
    } else if(bb_movetyperequested("wander_agitated")) {
      return "ambient_redzone";
    } else if(bb_movetyperequested("investigate")) {
      return "ambient_investigate";
    }
  } else if(bb_movetyperequested("wander_agitated")) {
    return "ambient_redzone";
  } else if(bb_movetyperequested("investigate")) {
    return "ambient_investigate";
  }

  return "ambient_normal";
}

function private function_1dc3dbebbb45158a() {
  level endon("game_ended");
  level.zombie_ambient_count = 0;

  while(true) {
    level.zombie_ambient_count = 0;
    wait 0.1;
  }
}

function private function_622dfa9ef1c9ec44(params, archetype) {
  thread zombie_behind_vo(archetype);
}

function private zombie_behind_vo(archetype) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");

  while(true) {
    wait 0.5;
    var_71a254e149ef0e2b = 250;
    ai_array = getaiarrayinradius(self.origin, var_71a254e149ef0e2b);

    if(isDefined(ai_array)) {
      foreach(ai in ai_array) {
        if(!isDefined(ai) || !isDefined(ai.basearchetype) || ai.basearchetype != archetype) {
          continue;
        }

        if(!isDefined(ai.enemy) || ai.enemy != self || !isPlayer(ai.enemy)) {
          continue;
        }

        if(function_c7ac2345de8620e8(ai)) {
          ai function_f707c26d8f269f94("behind_vox");
          wait 2.5;
        }
      }
    }
  }
}

function private function_c7ac2345de8620e8(zombie) {
  dist = 150;

  if(zombie bb_movetyperequested("walk")) {
    dist = 175;
  } else if(zombie bb_movetyperequested("run")) {
    dist = 200;
  } else if(zombie bb_movetyperequested("sprint")) {
    dist = 225;
  } else if(zombie bb_movetyperequested("super_sprint")) {
    dist = 250;
  }

  is_close = distance2dsquared(self.origin, zombie.origin) < dist * dist;
  var_4d18c820669d9625 = abs(self.origin[2] - zombie.origin[2]) < 140;
  assert(isPlayer(zombie.enemy));
  return is_close && var_4d18c820669d9625 && !within_fov_2d(zombie.enemy.origin, zombie.enemy.angles, zombie.origin, cos(95));
}