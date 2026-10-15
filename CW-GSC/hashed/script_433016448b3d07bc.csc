/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_433016448b3d07bc.csc
***********************************************/

#using scripts\core_common\audio_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;

#namespace namespace_99d0d95e;

function init() {
  level thread function_91c6e82a();
  level thread function_12b1d8eb();
  level thread function_529ee86f();
  level thread function_2c6cfe43();
  level thread function_1493eabf();
}

function function_91c6e82a() {
  level waittill(#"power_on");
  playSound(0, #"hash_1f574be04a9da670", (-1082, 13389, -133));
  waitframe(1);
  playSound(0, #"hash_73600bf9c06ee82c", (-650, 9979, 741));
  waitframe(1);
  playSound(0, #"hash_73600cf9c06ee9df", (-3803, 11341, 650));
  waitframe(1);
  playSound(0, #"hash_73600df9c06eeb92", (-2124, 8659, 136));
  var_f712f165 = struct::get_array("snd_power_fluorescent", "targetname");

  foreach(light in var_f712f165) {
    playSound(0, #"evt_power_fluorescent", light.origin);
  }

  var_da9a899e = struct::get_array("snd_power_tungsten", "targetname");

  foreach(light in var_da9a899e) {
    playSound(0, #"evt_power_tungsten", light.origin);
  }
}

function function_2f3017ad(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    if(bwasdemojump == 1) {
      addsubmix("cmn_duck_aux_2_0", 3, 1);
    }

    function_21fee83f(bwasdemojump);
    return;
  }

  clearsubmix("cmn_duck_aux_2_0", 3);
  function_21fee83f(0);
}

function function_21fee83f(var_c4f44e2) {
  self notify("61a178f1ddd3d368");
  self endon("61a178f1ddd3d368");

  if(!isDefined(level.var_4157094)) {
    level.var_4157094 = 0;
  }

  if(!isDefined(level.var_c5cba082)) {
    level.var_c5cba082 = 0;
  }

  if(var_c4f44e2 === 2) {
    blendsubmix("mute_underscore_aboveground", 1, 1);
    blendsubmix("mute_underscore_belowground", 1, 1);
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
      blendsubmix("mute_underscore_aboveground", 5, 0);
      blendsubmix("mute_underscore_belowground", 5, 1);
      return;
    }

    blendsubmix("mute_underscore_aboveground", 5, 1);
    blendsubmix("mute_underscore_belowground", 5, 0);
  }
}

function function_12b1d8eb() {
  addsubmix("mute_underscore_aboveground", 0);
  addsubmix("mute_underscore_belowground", 0);
  util::waitforclient(0);
  wait 50;
  audio::playloopat("mus_underscore_aboveground_loop_0", (0, 0, 0));
  level waittill(#"end_game");
  audio::stoploopat("mus_underscore_aboveground_loop_0", (0, 0, 0));
}

function function_1493eabf() {
  level waittill(#"sndunlockeesong");
  function_2cca7b47(0, #"musictrack_zm_platinum_ee");
}

function function_529ee86f() {
  level waittill(#"power_on");
  audio::playloopat("mus_bar_what_awaits", (-1383, 9859, 118));
}

function function_2c6cfe43() {
  level waittill(#"power_on");
  audio::playloopat("mus_seamstress_berlin_1985", (-3989, 10171, 499));
}

function function_ec54a907(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  switch (bwastimejump) {
    case 1:
      soundloopemitter("amb_train_alarm_lp", (-60, 12065, -200));
      var_27cb9568 = array((-1558, 12083, -201), (-726, 12057, -201), (-1100, 11955, -201), (-2311, 12012, -201));

      foreach(location in var_27cb9568) {
        soundloopemitter("amb_train_alarm_bell_lp", location);
      }

      playSound(fieldname, "amb_train_incomming_rumble_start", (-884, 11864, -214));
      playSound(fieldname, "amb_train_incomming_rumble_start", (-2604, 11998, -258));
      wait 2;
      playSound(fieldname, "amb_train_incomming_rumble", (-884, 11864, -214));
      playSound(fieldname, "amb_train_incomming_rumble", (-2604, 11998, -258));
      wait 3;
      soundstoploopemitter("amb_train_alarm_lp", (-60, 12065, -200));
      break;
    case 2:
      soundloopemitter("amb_train_alarm_lp", (-2856, 11966, -200));
      var_27cb9568 = array((-1558, 12083, -201), (-726, 12057, -201), (-1100, 11955, -201), (-2311, 12012, -201));

      foreach(location in var_27cb9568) {
        soundloopemitter("amb_train_alarm_bell_lp", location);
      }

      playSound(fieldname, "amb_train_incomming_rumble_start", (-884, 11864, -214));
      playSound(fieldname, "amb_train_incomming_rumble_start", (-2604, 11998, -258));
      wait 2;
      playSound(fieldname, "amb_train_incomming_rumble", (-884, 11864, -214));
      playSound(fieldname, "amb_train_incomming_rumble", (-2604, 11998, -258));
      wait 3;
      soundstoploopemitter("amb_train_alarm_lp", (-2856, 11966, -200));
      break;
    case 3:
      soundloopemitter("amb_train_alarm_lp", (-2856, 11966, -200));
      var_27cb9568 = array((-1558, 12083, -201), (-726, 12057, -201), (-1100, 11955, -201), (-2311, 12012, -201));

      foreach(location in var_27cb9568) {
        soundloopemitter("amb_train_alarm_bell_lp", location);
      }

      playSound(fieldname, "amb_train_incomming_rumble_start", (-884, 11864, -214));
      playSound(fieldname, "amb_train_incomming_rumble_start", (-2604, 11998, -258));
      wait 2;
      playSound(fieldname, "amb_train_incomming_rumble", (-884, 11864, -214));
      playSound(fieldname, "amb_train_incomming_rumble", (-2604, 11998, -258));
      wait 3;
      soundstoploopemitter("amb_train_alarm_lp", (-2856, 11966, -200));
      break;
    case 4:
      var_27cb9568 = array((-1558, 12083, -201), (-726, 12057, -201), (-1100, 11955, -201), (-2311, 12012, -201));

      foreach(location in var_27cb9568) {
        soundstoploopemitter("amb_train_alarm_bell_lp", location);
        playSound(fieldname, #"amb_train_alarm_bell_stop", location);
        wait randomfloatrange(0.25, 0.75);
      }

      break;
    case 5:
      addsubmix("zmb_platinum_bossfight", 5, 1);
      break;
    case 6:
      clearsubmix("zmb_platinum_bossfight", 5);
      break;
    case 7:
      addsubmix("zmb_step_8", 1, 1);
      break;
  }
}