/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\destructibles\water_barrel.gsc
***********************************************/

water_barrel_init() {
  level.g_effect["water_barrel_impact"] = loadfx("vfx/iw8/prop/scriptables/shared/vfx_imp_water_stream.vfx");
  level.g_effect["water_barrel_death"] = loadfx("vfx/iw8/prop/scriptables/vfx_container_barrel_plastic_01_closed_s3.vfx");
  var_0 = getEntArray("dyn_water_barrel", "targetname");

  foreach(var_2 in var_0)
  var_2 thread water_barrel();
}

water_barrel() {
  self endon("barrel_death");
  self endon("barrel_delete");
  scripts\sp\destructibles\barrel_common::barrel_setup("water", 450, 250, 9100, 15000, 80, 28);
  self.health = 9450;

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(!scripts\sp\destructibles\barrel_common::isvalidbarreldamage(var_1, var_4)) {
      continue;
    }
    if(!isDefined(var_4)) {
      continue;
    }
    if(self.spewtags.size >= 4) {
      continue;
    }
    var_10 = strtok(var_4, "_");

    if(!scripts\engine\utility::array_contains(var_10, "BULLET")) {
      continue;
    }
    var_11 = scripts\engine\utility::spawn_tag_origin(var_3);
    var_12 = vectorNormalize(self.origin - var_3);
    var_13 = vectortoangles(var_12 * -1);
    var_11.angles = scripts\engine\utility::flat_angle(var_13);
    var_11 linkTo(self);
    var_14 = spawn("script_origin", var_3);
    var_14 linkTo(self);
    self notify("new_spew", var_11);
    playFXOnTag(level.g_effect["water_barrel_impact"], var_11, "tag_origin");
    var_11 playSound("dst_water_barrel_puncture_stream_start");
    var_14 scalevolume(0, 0.0);
    var_14 playLoopSound("dst_water_barrel_puncture_stream_lp");
    var_14 scalevolume(1, 0.25);
    var_14 thread sfx_stop_water_barrel_stream(var_11);
    self.spewtags = scripts\engine\utility::array_add(self.spewtags, var_11);
    thread waterimpactlife(var_11);
  }
}

waterbarrelshoulddie(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0) && var_0 < 100)
    return 0;

  if(isDefined(var_2)) {
    switch (var_2) {
      case "SPLASH":
      case "MOD_GRENADE_SPLASH":
      case "MOD_GRENADE":
      case "MOD_PROJECTILE_SPLASH":
      case "MOD_PROJECTILE":
      case "MOD_EXPLOSIVE":
        return 1;
    }
  }

  return 0;
}

waterimpactlife(var_0) {
  scripts\engine\utility::waittill_notify_or_timeout("entitydeleted", 5);

  if(isDefined(self))
    self.spewtags = scripts\engine\utility::array_remove(self.spewtags, var_0);

  var_0 delete();
}

water_barrel_death() {
  self notify("barrel_death");

  if(isDefined(self))
    self hide();

  playFX(level.g_effect["water_barrel_death"], self.origin);

  foreach(var_1 in self.spewtags) {
    killfxontag(level.g_effect["water_barrel_impact"], var_1, "tag_origin");
    waitframe();

    if(isDefined(var_1))
      var_1 delete();
  }

  if(isDefined(self))
    thread delay_delete(5);
}

delay_delete(var_0) {
  wait(var_0);

  if(isDefined(self))
    self delete();
}

sfx_stop_water_barrel_stream(var_0) {
  wait 3.5;
  var_1 = 0.25;
  var_0 playSound("dst_water_barrel_puncture_stream_stop");
  self scalevolume(0, var_1);
  wait 0.3;
  self stoploopsound("dst_water_barrel_puncture_stream_lp");
  self delete();
}