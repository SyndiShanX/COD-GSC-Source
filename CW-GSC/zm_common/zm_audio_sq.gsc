/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\zm_audio_sq.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_sq;
#using scripts\zm_common\zm_unitrigger;
#namespace zm_audio_sq;

function init() {
  level zm_sq::register(#"music_sq", #"first_location", #"hash_3531cfab5aa57f4b", &function_fe4dc0ff, &function_3f739fed);
  level zm_sq::start(#"music_sq");
}

function private function_fe4dc0ff(var_a276c861) {
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

function private function_3f739fed(var_a276c861, var_19e802fa) {
  if(!var_a276c861) {
    if(var_19e802fa) {
      music_sq_cleanup();
    }
  }
}

function function_9310fe45() {
  level util::clientnotify("sndUnlockEESong");
  level thread zm_audio::sndmusicsystem_stopandflush();
  waitframe(1);
  level thread zm_audio::sndmusicsystem_playstate("ee_song");

  if(isDefined(level.var_da00670e)) {
    level thread[[level.var_da00670e]]();
  }
}

function function_9e3ff948() {
  var_2361f0ab = struct::get_array(#"s_music_sq_location", "targetname");
  var_2ab51a2c = 0;
  var_97671ac1 = var_2361f0ab.size;

  foreach(s_music_sq_location in var_2361f0ab) {
    s_music_sq_location thread function_8853dd01();
    waitframe(1);
  }

  while(true) {
    level waittill(#"hash_5f146847260b1b46");
    var_2ab51a2c++;

    if(var_2ab51a2c >= var_97671ac1) {
      break;
    }
  }
}

function function_8853dd01() {
  self.var_c65fa63f = util::spawn_model("p9_zm_ndu_cassette_gold", self.origin, self.angles);
  e_activator = self zm_unitrigger::function_fac87205(undefined, 75);
  e_activator playrumbleonentity(#"zm_interact_rumble");
  self.var_c65fa63f playSound("evt_sq_cassette_pickup");
  level notify(#"hash_5f146847260b1b46");
  waitframe(1);
  self.var_c65fa63f delete();
  self.var_c65fa63f = undefined;
}

function music_sq_cleanup() {
  var_2361f0ab = struct::get_array(#"s_music_sq_location", "targetname");

  foreach(s_music_sq_location in var_2361f0ab) {
    if(isDefined(s_music_sq_location.var_c65fa63f)) {
      s_music_sq_location.var_c65fa63f delete();
      waitframe(1);
    }
  }
}