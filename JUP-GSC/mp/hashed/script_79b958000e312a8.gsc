/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_79b958000e312a8.gsc
************************************************/

#namespace namespace_af91bb24f58a4a7d;

function function_6481fdd7c2eb7d5c() {
  function_aadc3bf2875b3408(0.2);
  function_4c70ed79848813ab("mgl_ftue_tutorial_loop_01");
}

function function_ae00f22f048a1f57(soundalias, loop) {
  assert(isDefined(soundalias));

  if(isDefined(loop)) {
    if(loop) {
      self playLoopSound(soundalias);
    } else {
      self playlocalsound(soundalias);
    }

    return;
  }

  self playlocalsound(soundalias);
}

function function_4c70ed79848813ab(musicstate) {
  assert(isDefined(musicstate));
  setmusicstate(musicstate);
}

function function_aadc3bf2875b3408(volume) {
  if(getdvarint(@ "hash_4b32f268c08cd4e8", 0) == 1) {
    return;
  }

  clamp(volume, 0, 1);
  function_adfd4002c83fe6b2("wpn_plr", volume);
  function_adfd4002c83fe6b2("wpn_plr_atmo", volume);
  function_adfd4002c83fe6b2("wpn_plr_mech", volume);
  function_adfd4002c83fe6b2("wpn_reflections", volume);
  function_adfd4002c83fe6b2("wpn_reflections_dist", volume);
}