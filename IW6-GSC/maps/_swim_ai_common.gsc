/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_swim_ai_common.gsc
*****************************************************/

override_footsteps() {
  wait 0.1;
  var_0 = level._effect["swim_kick_bubble"];
  animscripts\utility::setfootstepeffect("default", var_0);
  animscripts\utility::setfootstepeffect("asphalt", var_0);
  animscripts\utility::setfootstepeffect("brick", var_0);
  animscripts\utility::setfootstepeffect("carpet", var_0);
  animscripts\utility::setfootstepeffect("cloth", var_0);
  animscripts\utility::setfootstepeffect("concrete", var_0);
  animscripts\utility::setfootstepeffect("cushion", var_0);
  animscripts\utility::setfootstepeffect("dirt", var_0);
  animscripts\utility::setfootstepeffect("foliage", var_0);
  animscripts\utility::setfootstepeffect("grass", var_0);
  animscripts\utility::setfootstepeffect("gravel", var_0);
  animscripts\utility::setfootstepeffect("mud", var_0);
  animscripts\utility::setfootstepeffect("rock", var_0);
  animscripts\utility::setfootstepeffect("sand", var_0);
  animscripts\utility::setfootstepeffect("wood", var_0);
  animscripts\utility::setfootstepeffect("water", var_0);
  animscripts\utility::setfootstepeffectsmall("default", var_0);
  animscripts\utility::setfootstepeffectsmall("asphalt", var_0);
  animscripts\utility::setfootstepeffectsmall("brick", var_0);
  animscripts\utility::setfootstepeffectsmall("carpet", var_0);
  animscripts\utility::setfootstepeffectsmall("cloth", var_0);
  animscripts\utility::setfootstepeffectsmall("concrete", var_0);
  animscripts\utility::setfootstepeffectsmall("cushion", var_0);
  animscripts\utility::setfootstepeffectsmall("dirt", var_0);
  animscripts\utility::setfootstepeffectsmall("foliage", var_0);
  animscripts\utility::setfootstepeffectsmall("grass", var_0);
  animscripts\utility::setfootstepeffectsmall("gravel", var_0);
  animscripts\utility::setfootstepeffectsmall("mud", var_0);
  animscripts\utility::setfootstepeffectsmall("rock", var_0);
  animscripts\utility::setfootstepeffectsmall("sand", var_0);
  animscripts\utility::setfootstepeffectsmall("wood", var_0);
  animscripts\utility::setfootstepeffectsmall("water", var_0);
  override_footstep_notetrack_scripts();
}

override_water_footsteps() {
  wait 0.1;
  var_0 = level._effect["swim_kick_bubble"];
  animscripts\utility::setfootstepeffect("water", var_0);
  animscripts\utility::setfootstepeffectsmall("water", var_0);
  override_footstep_notetrack_scripts();
}

restore_water_footsteps() {
  animscripts\utility::unsetfootstepeffect("water");
  animscripts\utility::unsetfootstepeffectsmall("water");
  restore_footstep_notetrack_scripts();
}

override_footstep_notetrack_scripts() {
  anim.notetracks["footstep_right_large"] = ::notetrackfootstep;
  anim.notetracks["footstep_right_small"] = ::notetrackfootstep;
  anim.notetracks["footstep_left_large"] = ::notetrackfootstep;
  anim.notetracks["footstep_left_small"] = ::notetrackfootstep;
}

restore_footstep_notetrack_scripts() {
  anim.notetracks["footstep_right_large"] = animscripts\notetracks::notetrackfootstep;
  anim.notetracks["footstep_right_small"] = animscripts\notetracks::notetrackfootstep;
  anim.notetracks["footstep_left_large"] = animscripts\notetracks::notetrackfootstep;
  anim.notetracks["footstep_left_small"] = animscripts\notetracks::notetrackfootstep;
}

notetrackfootstep(var_0, var_1) {
  var_2 = issubstr(var_0, "left");
  var_3 = issubstr(var_0, "large");
  playfootstep(var_2, var_3);
}

playfootstep(var_0, var_1) {
  if(!isai(self)) {
    self playSound("step_run_dirt");
    return;
  }

  var_2 = "water";
  var_3 = "J_Ball_RI";

  if(var_0) {
    var_3 = "J_Ball_LE";
  }

  var_4 = "run";
  thread maps\_utility::play_sound_on_entity("foot_flipper_underwater");
  playbubbleeffect(var_3, var_2);
}

playbubbleeffect(var_0, var_1) {
  if(!isDefined(anim.optionalstepeffects[var_1])) {
    return 0;
  }

  var_2 = self gettagorigin(var_0);
  var_3 = self.angles;
  var_4 = anglesToForward(var_3);
  var_5 = var_4 * -1;
  var_6 = (0, 0, 1);
  playFXOnTag(level._effect["step_" + var_1], self, var_0);
  return 1;
}