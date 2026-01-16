/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_nightvision.gsc
*****************************************************/

main(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = level.players;

  thread init_and_run(var_0, var_1);
}

init_and_run(var_0, var_1) {
  var_1 = common_scripts\utility::ter_op(isDefined(var_1), var_1, 1);
  precachenightvisioncodeassets();
  precacheshellshock("nightvision");
  level.nightvision_dlight_effect = loadfx("fx/misc/NV_dlight");
  level.nightvision_reflector_effect = loadfx("fx/misc/ir_tapeReflect");

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];
    var_3 maps\_utility::ent_flag_init("nightvision_enabled");
    var_3 maps\_utility::ent_flag_init("nightvision_on");
    var_3 maps\_utility::ent_flag_set("nightvision_enabled");
    var_3 maps\_utility::ent_flag_init("nightvision_dlight_enabled");
    var_3 maps\_utility::ent_flag_set("nightvision_dlight_enabled");
    var_3 maps\_utility::ent_flag_clear("nightvision_dlight_enabled");
    var_3 setactionslot(var_1, "nightvision");
  }

  visionsetnight("default_night");
  waittillframeend;
  wait 0.05;

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];
    var_3 thread nightvision_toggle();
  }
}

nightvision_toggle() {
  self endon("death");

  for(;;) {
    self waittill("night_vision_on");
    nightvision_on();
    self waittill("night_vision_off");
    nightvision_off();
    wait 0.05;
  }
}

nightvision_check(var_0) {
  if(!isDefined(var_0))
    var_0 = level.player;

  return isDefined(var_0.nightvision_enabled);
}

nightvision_on() {
  self.nightvision_started = 1;
  wait 1.0;
  maps\_utility::ent_flag_set("nightvision_on");
  self.nightvision_enabled = 1;
  var_0 = getaiarray("allies");
  common_scripts\utility::array_thread(var_0, ::enable_ir_beacon);

  if(!maps\_utility::exists_global_spawn_function("allies", ::enable_ir_beacon))
    maps\_utility::add_global_spawn_function("allies", ::enable_ir_beacon);
}

enable_ir_beacon() {
  if(!isai(self)) {
    return;
  }
  if(isDefined(self.has_no_ir)) {
    return;
  }
  animscripts\shared::updatelaserstatus();
  thread loopreflectoreffect();
}

loopreflectoreffect() {
  level endon("night_vision_off");
  self endon("death");

  for(;;) {
    playFXOnTag(level.nightvision_reflector_effect, self, "tag_reflector_arm_le");
    playFXOnTag(level.nightvision_reflector_effect, self, "tag_reflector_arm_ri");
    wait 0.1;
  }
}

stop_reflector_effect() {
  if(isDefined(self.has_no_ir)) {
    return;
  }
  stopFXOnTag(level.nightvision_reflector_effect, self, "tag_reflector_arm_le");
  stopFXOnTag(level.nightvision_reflector_effect, self, "tag_reflector_arm_ri");
}

nightvision_off() {
  self.nightvision_started = undefined;
  wait 0.4;
  level notify("night_vision_off");

  if(isDefined(level.nightvision_dlight))
    level.nightvision_dlight delete();

  self notify("nightvision_shellshock_off");
  maps\_utility::ent_flag_clear("nightvision_on");
  self.nightvision_enabled = undefined;
  var_0 = 0;

  for(var_1 = 0; var_1 < level.players.size; var_1++) {
    if(nightvision_check(level.players[var_1]))
      var_0 = 1;
  }

  if(!var_0)
    maps\_utility::remove_global_spawn_function("allies", ::enable_ir_beacon);

  thread nightvision_effectsoff();
}

nightvision_effectsoff() {
  var_0 = getaiarray("allies");

  foreach(var_2 in var_0) {
    var_2.usingnvfx = undefined;
    var_2 animscripts\shared::updatelaserstatus();
    var_2 stop_reflector_effect();
  }
}

shouldbreaknvghintprint() {
  return isDefined(self.nightvision_started);
}

should_break_disable_nvg_print() {
  return !isDefined(self.nightvision_started);
}