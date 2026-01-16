/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_zodt8_sound.csc
***********************************************/

#include scripts\core_common\audio_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\struct;

#namespace zm_zodt8_sound;

main() {
  level thread startzmbspawnersoundloops();
  level thread function_9466dec0();
}

startzmbspawnersoundloops() {
  loopers = struct::get_array("spawn_location", "script_noteworthy");

  if(isDefined(loopers) && loopers.size > 0) {
    delay = 0;

    if(getdvarint(#"debug_audio", 0) > 0) {
      println("<dev string:x38>" + loopers.size + "<dev string:x72>");
    }

      for(i = 0; i < loopers.size; i++) {
        loopers[i] thread soundloopthink();
        delay += 1;

        if(delay % 20 == 0) {
          waitframe(1);
        }
      }

    return;
  }

  if(getdvarint(#"debug_audio", 0) > 0) {
    println("<dev string:x7f>");
  }

}

soundloopthink() {
  if(!isDefined(self.origin)) {
    return;
  }

  if(!isDefined(self.script_sound)) {
    self.script_sound = "zmb_spawn_walla";
  }

  notifyname = "";
  assert(isDefined(notifyname));

  if(isDefined(self.script_string)) {
    notifyname = self.script_string;
  }

  assert(isDefined(notifyname));
  started = 1;

  if(isDefined(self.script_int)) {
    started = self.script_int != 0;
  }

  if(started) {
    soundloopemitter(self.script_sound, self.origin + (0, 0, 60));
  }

  if(notifyname != "") {
    for(;;) {
      level waittill(notifyname);

      if(started) {
        soundstoploopemitter(self.script_sound, self.origin + (0, 0, 60));
      } else {
        soundloopemitter(self.script_sound, self.origin + (0, 0, 60));
      }

      started = !started;
    }
  }
}

function_a6e35dcd() {
  wait 3;
  audio::playloopat("amb_iceberg_cracking_loop", (-863, 5324, 1451));
}

function_9466dec0() {
  var_7a522422 = struct::get_array("sndWoodRattles", "targetname");
  var_c5cacee = struct::get_array("sndPipeRattles", "targetname");
  var_61bc8796 = struct::get_array("sndWoodStress", "targetname");
  level waittill(#"play_destruction_sounds");
  playSound(0, #"hash_36a95d08ed4998f6", (20, -5248, 1196));

  foreach(rattle in var_7a522422) {
    playSound(0, #"hash_565a94625021a254", rattle.origin);
    waitframe(1);
  }

  foreach(rattle in var_c5cacee) {
    playSound(0, #"hash_2dbe3a174b1c934c", rattle.origin);
    waitframe(1);
  }

  foreach(rattle in var_61bc8796) {
    playSound(0, #"hash_3d14ed72726a475a", rattle.origin);
    waitframe(1);
  }
}