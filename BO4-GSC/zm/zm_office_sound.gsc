/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_office_sound.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\struct;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_unitrigger;
#include scripts\zm_common\zm_utility;

#namespace zm_office_sound;

main() {
  level thread function_b72b5f36();
  level thread function_7624a4cd();
}

function_7624a4cd() {
  a_structs = struct::get_array("snd_morse_code", "targetname");
  array::thread_all(a_structs, &function_f71796ca);
  level thread function_bc327ddf();
}

function_f71796ca() {
  level endon(#"hash_2bfc849b35affc0c", #"end_game");
  self thread function_e856acd2();
  str_alias = #"hash_716d417cfe416a4d" + self.script_int;
  n_wait = float(soundgetplaybacktime(str_alias)) / 1000;

  if(!isDefined(n_wait)) {
    n_wait = 1;
  }

  if(n_wait <= 0) {
    n_wait = 1;
  }

  self zm_unitrigger::create(undefined, 40);

  while(true) {
    s_notify = self waittill(#"trigger_activated");
    playsoundatposition(str_alias, self.origin);
    level notify(#"hash_66f9802695ce6503", {
      #var_6831e121: self.script_int
    });
    wait n_wait;
  }
}

function_e856acd2() {
  level endon(#"hash_2bfc849b35affc0c", #"end_game");

  while(true) {
    wait randomintrange(20, 60);
    playsoundatposition(#"hash_2c5321deab41da10", self.origin);
  }
}

function_bc327ddf() {
  level endon(#"end_game");
  var_f0f25516 = array(1, 2, 3, 4, 5);

  for(var_5ffc6bcc = 0; true; var_5ffc6bcc = 0) {
    s_result = level waittill(#"hash_66f9802695ce6503");

    if(s_result.var_6831e121 === var_f0f25516[var_5ffc6bcc]) {
      if(var_5ffc6bcc >= 4) {
        level notify(#"hash_2bfc849b35affc0c");
        waitframe(1);
        a_structs = struct::get_array("snd_morse_code", "targetname");

        foreach(struct in a_structs) {
          zm_unitrigger::unregister_unitrigger(struct.s_unitrigger);
        }

        wait 5;
        level thread zm_audio::sndmusicsystem_stopandflush();
        waitframe(1);
        level thread zm_audio::sndmusicsystem_playstate("ee_song_2");
        return;
      } else {
        var_5ffc6bcc++;
      }

      continue;
    }

    if(s_result.var_6831e121 == 1) {
      var_5ffc6bcc = 1;
      continue;
    }
  }
}

function_b72b5f36() {
  a_structs = struct::get_array("mus_ee", "targetname");
  array::thread_all(a_structs, &function_43e2a503);
}

function_43e2a503() {
  if(zm_utility::is_standard() || zm_utility::is_trials()) {
    return;
  }

  var_26d86758 = spawn("script_origin", self.origin);
  var_26d86758 playLoopSound(#"hash_368d31ed538206b0");
  e_activator = self zm_unitrigger::function_fac87205(undefined, 40);

  if(!isDefined(level.var_ec4c747a)) {
    level.var_ec4c747a = 0;
  }

  playsoundatposition(#"hash_58a7d90061e86ced", self.origin);
  var_26d86758 delete();
  level.var_ec4c747a++;

  if(level.var_ec4c747a >= 3) {
    level thread zm_audio::sndmusicsystem_stopandflush();
    waitframe(1);
    level thread zm_audio::sndmusicsystem_playstate("ee_song");
  }
}