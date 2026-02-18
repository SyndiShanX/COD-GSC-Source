/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\zm_silver_sound.csc
***********************************************/

#using scripts\core_common\audio_shared;
#using scripts\core_common\struct;
#namespace zm_silver_sound;

function init() {
  level thread function_91c6e82a();
  level thread function_12b1d8eb();
  level thread function_1493eabf();
}

function function_12b1d8eb() {
  wait 1;
  audio::playloopat("mus_underscore_aboveground_loop_0", (0, 0, 0));
  audio::playloopat("mus_underscore_belowground_loop_0", (0, 0, 0));
  audio::playloopat(#"amb_computer", (156, 2017, -211));
  function_5ea2c6e3("mute_underscore_aboveground", 0);
  function_5ea2c6e3("mute_underscore_belowground", 0);
  level waittill(#"end_game");
  audio::stoploopat("mus_underscore_aboveground_loop_0", (0, 0, 0));
  audio::stoploopat("mus_underscore_belowground_loop_0", (0, 0, 0));
}

function startzmbspawnersoundloops() {
  loopers = struct::get_array("spawn_location", "script_noteworthy");

  if(isDefined(loopers) && loopers.size > 0) {
    delay = 0;

    if(getdvarint(#"debug_audio", 0) > 0) {
      println("<dev string:x38>" + loopers.size + "<dev string:x73>");
    }

    for(i = 0; i < loopers.size; i++) {
      if(isDefined(loopers[i].script_sound)) {
        continue;
      }

      loopers[i] thread soundloopthink();
      delay += 1;

      if(delay % 20 == 0) {
        waitframe(1);
      }
    }

    return;
  }

  if(getdvarint(#"debug_audio", 0) > 0) {
    println("<dev string:x81>");
  }
}

function soundloopthink() {
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

function function_91c6e82a() {
  level waittill(#"power_on");
  playSound(0, #"hash_507a8d3d4874b9ca", (984, -658, -207));
  wait 0.25;
  playSound(0, #"hash_61832f7330aa03c", (524, -84, -268));
  playSound(0, #"hash_129c564608f837b6", (524, -84, -268));
  wait 0.1;
  playSound(0, #"hash_487cbd8d6e939533", (524, -84, -268));
  wait 0.4;
  playSound(0, #"hash_43dad678bc35ddb7", (524, -84, -268));
  wait 0.5;
  playSound(0, #"hash_43dad678bc35ddb7", (-744, -1392, -322));
  wait 0.5;
  playSound(0, #"hash_43dad678bc35ddb7", (1641, 970, -360));
}

function function_2f3017ad(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    function_21fee83f(bwasdemojump);
    return;
  }

  function_21fee83f(0);
}

function function_21fee83f(var_c4f44e2) {
  self notify("348fa2cacc8e985f");
  self endon("348fa2cacc8e985f");

  if(!isDefined(level.var_4157094)) {
    level.var_4157094 = 0;
  }

  if(!isDefined(level.var_c5cba082)) {
    level.var_c5cba082 = 0;
  }

  if(var_c4f44e2 === 2) {
    function_672403ca("mute_underscore_aboveground", 1, 1);
    function_672403ca("mute_underscore_belowground", 1, 1);
    level.var_c5cba082 = 1;
    return;
  }

  n_start_delay = 0;

  if(var_c4f44e2 === 3) {
    level.var_c5cba082 = 0;
    var_c4f44e2 = level.var_4157094;
    n_start_delay = 4;
  }

  level.var_4157094 = var_c4f44e2;

  if(!level.var_c5cba082) {
    if(n_start_delay > 0) {
      wait n_start_delay;
    }

    if(var_c4f44e2 === 0) {
      function_672403ca("mute_underscore_aboveground", 5, 0);
      function_672403ca("mute_underscore_belowground", 5, 1);
      return;
    }

    function_672403ca("mute_underscore_aboveground", 5, 1);
    function_672403ca("mute_underscore_belowground", 5, 0);
  }
}

function function_1493eabf() {
  level waittill(#"sndunlockeesong");
  function_2cca7b47(0, #"musictrack_zm_silver_ee");
}