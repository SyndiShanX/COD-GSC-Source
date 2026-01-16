/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_office_sound.csc
***********************************************/

#include scripts\core_common\audio_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\struct;

#namespace zm_office_sound;

main() {
  level thread startzmbspawnersoundloops();
  level thread function_6e0048f1();
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

function_6e0048f1() {
  wait 0.1;
  level waittill(#"poa");
  audio::playloopat(#"hash_441952a4718e4f31", (-720, 3949, -608));
  audio::playloopat(#"hash_441952a4718e4f31", (-729, 5238, -608));
  audio::playloopat(#"hash_441952a4718e4f31", (-1616, 5252, -562));
  audio::playloopat(#"hash_441952a4718e4f31", (-1602, 3860, -608));
}