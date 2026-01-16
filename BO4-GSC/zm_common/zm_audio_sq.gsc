/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_audio_sq.gsc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_sq;

#namespace zm_audio_sq;

init() {
  clientfield::register("scriptmover", "medallion_fx", 1, 1, "int");
  zm_sq::register(#"music_sq", #"first_location", #"hash_3531cfab5aa57f4b", &function_fe4dc0ff, &function_3f739fed);
  zm_sq::start(#"music_sq");
}

private function_fe4dc0ff(var_a276c861) {
  level endon(#"end_game");

  if(!isDefined(level.var_c5c448d)) {
    level.var_c5c448d = 0;
  }

  level.var_c5c448d++;

  if(!var_a276c861) {
    function_9e3ff948();
    function_9310fe45();
  }
}

private function_3f739fed(var_a276c861, var_19e802fa) {
  if(!var_a276c861) {
    if(var_19e802fa) {
      music_sq_cleanup();
    }
  }
}

function_9310fe45() {
  level thread zm_audio::sndmusicsystem_stopandflush();
  waitframe(1);
  level thread zm_audio::sndmusicsystem_playstate("ee_song");
}

function_9e3ff948() {
  var_1a2e422e = 0;
  var_2361f0ab = struct::get_array(#"s_music_sq_location", "targetname");

  foreach(s_music_sq_location in var_2361f0ab) {
    if(isDefined(s_music_sq_location.script_int) && s_music_sq_location.script_int == level.var_c5c448d) {
      s_music_sq_location thread function_c0862b9e();
      util::wait_network_frame();
    }
  }

  while(true) {
    level waittill(#"hash_71162ec98b670d92");
    var_1a2e422e++;

    if(var_1a2e422e >= 4) {
      break;
    }
  }
}

function_c0862b9e() {
  self.var_6522085c = util::spawn_model(self.model, self.origin, self.angles);
  self.var_6522085c setCanDamage(1);
  self.var_6522085c.health = 1000000;

  if(isDefined(level.var_35d6e654)) {
    self thread[[level.var_35d6e654]]();
  }

  while(true) {
    waitresult = self.var_6522085c waittill(#"damage");

    if(!isDefined(waitresult.attacker) || !isplayer(waitresult.attacker)) {
      continue;
    }

    if(isDefined(level.musicsystemoverride) && level.musicsystemoverride) {
      continue;
    }

    waitresult.attacker playsoundtoplayer(#"hash_3ffdc84cf43cae2b", waitresult.attacker);
    level notify(#"hash_71162ec98b670d92");
    break;
  }

  self.var_6522085c clientfield::set("medallion_fx", 1);
  util::wait_network_frame();
  self.var_6522085c delete();
  self.var_6522085c = undefined;
}

music_sq_cleanup() {
  var_2361f0ab = struct::get_array(#"s_music_sq_location", "targetname");

  foreach(s_music_sq_location in var_2361f0ab) {
    if(isDefined(s_music_sq_location.var_6522085c)) {
      s_music_sq_location.var_6522085c delete();
      util::wait_network_frame();
    }
  }
}