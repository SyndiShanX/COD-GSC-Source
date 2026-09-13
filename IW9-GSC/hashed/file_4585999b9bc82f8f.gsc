/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_4585999b9bc82f8f.gsc
***********************************************/

_id_6481FDD7C2EB7D5C() {
  _id_AADC3BF2875B3408(0.2);
  _id_4C70ED79848813AB("mgl_ftue_tutorial_loop_01");

  if(!level.battlechatterenabled)
    scripts\mp\battlechatter_mp::init();
}

_id_AE00F22F048A1F57(soundalias, loop) {
  if(isDefined(loop)) {
    if(loop)
      self playLoopSound(soundalias);
    else
      self playlocalsound(soundalias);
  } else
    self playlocalsound(soundalias);
}

_id_4C70ED79848813AB(_id_51941101270F867D) {
  setmusicstate(_id_51941101270F867D);
}

_id_AADC3BF2875B3408(volume) {
  if(getdvarint("snd_volume_mute", 0) == 1) {
    return;
  }
  clamp(volume, 0.0, 1.0);
  _func_ADFD4002C83FE6B2("wpn_plr", volume);
  _func_ADFD4002C83FE6B2("wpn_plr_atmo", volume);
  _func_ADFD4002C83FE6B2("wpn_plr_mech", volume);
  _func_ADFD4002C83FE6B2("wpn_reflections", volume);
  _func_ADFD4002C83FE6B2("wpn_reflections_dist", volume);
}

_id_CDA6B5416805C105(event, targetent, location) {
  if(isDefined(self) && getdvarint("dvar_6A3FEE7050C03726", 0) == 0)
    scripts\mp\battlechatter_mp::dosound(event, targetent, location);
}