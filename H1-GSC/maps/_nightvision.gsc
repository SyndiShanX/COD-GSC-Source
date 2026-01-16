/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_nightvision.gsc
********************************/

main(var_0, var_1) {
  if(!isdefined(var_0))
    var_0 = level.players;

  if(!isdefined(level.nightvisionlightset))
    level.nightvisionlightset = "nightvision";

  thread init_and_run(var_0, var_1);
}

init_and_run(var_0, var_1) {
  var_1 = common_scripts\utility::ter_op(isdefined(var_1), var_1, 1);
  precachenightvisioncodeassets();
  precacheshellshock("nightvision");
  level.nightvision_dlight_effect = loadfx("fx\misc\NV_dlight");
  level.nightvision_reflector_effect = loadfx("fx\misc\ir_tapeReflect");
  level.nightvision_distortion_effect = loadfx("vfx\distortion\distortion_nightvision");
  level.nightvision_phosphor_effect = loadfx("vfx\ui\nvg_phosphor");

  for (var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];
    var_3 maps\_utility::ent_flag_init("nightvision_enabled");
    var_3 maps\_utility::ent_flag_init("nightvision_on");
    var_3 maps\_utility::ent_flag_set("nightvision_enabled");
    var_3 maps\_utility::ent_flag_init("nightvision_dlight_enabled");
    var_3 maps\_utility::ent_flag_set("nightvision_dlight_enabled");
    var_3 setactionslot(var_1, "nightvision");
  }

  visionsetnight("default_night");
  thread monitor_blowouts();
  waittillframeend;
  wait 0.05;

  for (var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];
    var_3 thread nightvision_toggle();
  }
}

nightvision_toggle() {
  self endon("death");

  for (;;) {
    self waittill("night_vision_on");
    nightvision_on();
    var_0 = spawnfx(level.nightvision_distortion_effect, level.player.origin);
    var_1 = spawnfx(level.nightvision_phosphor_effect, level.player.origin);
    triggerfx(var_0);
    triggerfx(var_1);
    setomnvar("ui_nightvision", 1);
    self waittill("night_vision_off");
    nightvision_off();
    setomnvar("ui_nightvision", 0);
    var_0 delete();
    var_1 delete();
    wait 0.05;
  }
}

nightvision_check(var_0) {
  if(!isdefined(var_0))
    var_0 = level.player;

  return isdefined(var_0.nightvision_enabled);
}

nightvision_on() {
  level.player setclutoverrideenableforplayer("disabled", 0);
  self.nightvision_started = 1;
  maps\_utility::ent_flag_set("nightvision_on");
  self.nightvision_enabled = 1;
  thread h1_view_weapon_laser_update();
  level.player lightsetoverrideenableforplayer(level.nightvisionlightset, 0);

  if(maps\_utility::ent_flag("nightvision_dlight_enabled")) {
    level.nightvision_dlight = spawnfx(level.nightvision_dlight_effect, level.player.origin);
    triggerfx(level.nightvision_dlight);
  }

  var_0 = getaiarray("allies");
  common_scripts\utility::array_thread(var_0, ::enable_ir_beacon);

  if(!maps\_utility::exists_global_spawn_function("allies", ::enable_ir_beacon))
    maps\_utility::add_global_spawn_function("allies", ::enable_ir_beacon);
}

has_laser_sight_nightvision(var_0) {
  return issubstr(var_0, "m4m203_acog") || issubstr(var_0, "m4m203_silencer") || issubstr(var_0, "m4_grenadier") || issubstr(var_0, "m4_grunt") || issubstr(var_0, "m4_silencer") || issubstr(var_0, "m4m203_silencer_reflex");
}

h1_view_weapon_laser_update() {
  level endon("night_vision_off");
  self endon("death");

  for (;;) {
    if(self getcurrentweapon() == "none") {
      waitframe();
      continue;
    }

    if(has_laser_sight_nightvision(self getcurrentweapon()))
      self laseron();
    else
      self laseroff();

    common_scripts\utility::waittill_any("weapon_switch_started", "weapon_taken");
    self laseroff();
    common_scripts\utility::waittill_any("grenade_fire", "weapon_change");
  }
}

enable_ir_beacon() {
  if(!isai(self)) {
    return;
  }
  if(!isdefined(self.has_ir)) {
    return;
  }
  animscripts\shared::updatelaserstatus();
  thread loopreflectoreffect();
}

loopreflectoreffect() {
  level endon("night_vision_off");
  self endon("death");

  for (;;) {
    if(self gettagindex("tag_reflector_arm_le") != -1)
      playfxontag(level.nightvision_reflector_effect, self, "tag_reflector_arm_le");

    if(self gettagindex("tag_reflector_arm_ri") != -1)
      playfxontag(level.nightvision_reflector_effect, self, "tag_reflector_arm_ri");

    wait 0.1;
  }
}

stop_reflector_effect() {
  if(!isdefined(self.has_ir)) {
    return;
  }
  stopfxontag(level.nightvision_reflector_effect, self, "tag_reflector_arm_le");
  stopfxontag(level.nightvision_reflector_effect, self, "tag_reflector_arm_ri");
}

nightvision_off() {
  self.nightvision_started = undefined;
  self laseroff();
  level notify("night_vision_off");

  if(isdefined(level.nightvision_dlight))
    level.nightvision_dlight delete();

  self notify("nightvision_shellshock_off");
  maps\_utility::ent_flag_clear("nightvision_on");
  self.nightvision_enabled = undefined;
  level.player lightsetoverridedisableforplayer();
  level.player setclutoverridedisableforplayer(0);
  var_0 = 0;

  for (var_1 = 0; var_1 < level.players.size; var_1++) {
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
  if(isdefined(self.nightvision_started))
    return 1;

  return isdefined(self.end_nightvision_hint);
}

should_break_disable_nvg_print() {
  if(!isdefined(self.nightvision_started))
    return 1;

  return isdefined(self.end_nightvision_disable_hint);
}

force_remove_nightvision() {
  level.player forceviewmodelanimation(level.player getcurrentweapon(), "nvg_up");
  wait 0.5;
  setsaveddvar("nightVisionDisableEffects", 1);
  wait 0.5;
  level.player nightvisiongogglesforceoff();
  wait 1;
  setsaveddvar("nightVisionDisableEffects", 0);
}

monitor_blowouts() {
  level.r_ssrblendscale_default_value = getdvarfloat("r_ssrBlendScale");
  level.r_ssrblendscale_nvg_value = monitor_blowouts_getvalue(level.r_ssrblendscale_default_value);

  for (;;) {
    level.player maps\_utility::ent_flag_wait("nightvision_on");
    thread maps\_utility::lerp_saveddvar("r_ssrBlendScale", level.r_ssrblendscale_nvg_value, 0.25);
    level.player maps\_utility::ent_flag_waitopen("nightvision_on");
    thread maps\_utility::lerp_saveddvar("r_ssrBlendScale", level.r_ssrblendscale_default_value, 0.25);
  }
}

monitor_blowouts_getvalue(var_0) {
  switch (level.script) {
    case "blackout":
      return 0.1;
    case "bog_a":
      return 0.25;
  }

  return var_0;
}