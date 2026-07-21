/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\destructibles\oil_barrel.gsc
***********************************************/

oil_barrel_init() {
  level.g_effect["oil_barrel_impact"] = loadfx("vfx/iw8/prop/scriptables/shared/vfx_imp_oil_stream.vfx");
  level.g_effect["oil_barrel_death"] = loadfx("vfx/iw8/prop/scriptables/vfx_oil_drum_big_01_s3.vfx");
  var_0 = oil_get_barrels();

  foreach(var_2 in var_0)
  var_2 thread oil_barrel();
}

oil_get_barrels() {
  return getEntArray("dyn_oil_barrel", "targetname");
}

oil_barrel() {
  self endon("barrel_death");
  self endon("barrel_delete");
  scripts\sp\destructibles\barrel_common::barrel_setup("oil", 450, 250, 9100, 15000, 80, 28);
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
    playFXOnTag(level.g_effect["oil_barrel_impact"], var_11, "tag_origin");
    var_11 playSound("dst_oil_barrel_puncture_stream_start");
    var_14 scalevolume(0, 0.0);
    var_14 playLoopSound("dst_oil_barrel_puncture_stream_lp");
    var_14 scalevolume(1, 0.25);
    var_14 thread sfx_stop_oil_barrel_stream();
    self.spewtags = scripts\engine\utility::array_add(self.spewtags, var_11);
    thread oilimpactlife(var_11);
  }
}

oilbarrelshoulddie(var_0, var_1, var_2, var_3) {
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

oilimpactlife(var_0) {
  scripts\engine\utility::waittill_notify_or_timeout("entitydeleted", 5);

  if(isDefined(self))
    self.spewtags = scripts\engine\utility::array_remove(self.spewtags, var_0);

  var_0 delete();
}

oil_barrel_death() {
  self notify("barrel_death");

  if(isDefined(self))
    self hide();

  playFX(level.g_effect["oil_barrel_death"], self.origin);

  foreach(var_1 in self.spewtags) {
    killfxontag(level.g_effect["oil_barrel_impact"], var_1, "tag_origin");
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

sfx_stop_oil_barrel_stream() {
  wait 3.3;
  var_0 = 0.25;
  self playSound("dst_oil_barrel_puncture_stream_stop");
  self scalevolume(0, var_0);
  wait 0.3;
  self stoploopsound("dst_oil_barrel_puncture_stream_lp");
  self delete();
}