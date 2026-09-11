/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\destructibles\oil_barrel.gsc
***************************************************/

function oil_barrel_init() {
  level.g_effect["oil_barrel_impact"] = loadfx("vfx/iw8/prop/scriptables/shared/vfx_imp_oil_stream.vfx");
  level.g_effect["oil_barrel_death"] = loadfx("vfx/iw8/prop/scriptables/vfx_oil_drum_big_01_s3.vfx");
  var0 = oil_get_barrels();

  foreach(var2 in var0) {
    thread oil_barrel();
  }
}

function oil_get_barrels() {
  return getEntArray("dyn_oil_barrel", "targetname");
}

function oil_barrel() {
  self endon("barrel_death");
  self endon("barrel_delete");
  scripts\sp\destructibles\barrel_common::barrel_setup("oil", 450, 250, 9100, 15000, 80, 28);
  self.health = 9450;

  for(;;) {
    self waittill("damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9);

    if(!scripts\sp\destructibles\barrel_common::isvalidbarreldamage(var1, var4)) {
      continue;
    }

    if(!isDefined(var4)) {
      continue;
    }

    if(self.spewtags.size >= 4) {
      continue;
    }

    var10 = strtok(var4, "_");

    if(!scripts\engine\utility::array_contains(var10, "BULLET")) {
      continue;
    }

    var11 = scripts\engine\utility::spawn_tag_origin(var3);
    var12 = vectorNormalize(self.origin - var3);
    var13 = vectortoangles(var12 * -1);
    var11.angles = scripts\engine\utility::flat_angle(var13);
    var11 linkTo(self);
    var14 = spawn("script_origin", var3);
    var14 linkTo(self);
    self notify("new_spew", var11);
    playFXOnTag(level.g_effect["oil_barrel_impact"], var11, "tag_origin");
    var11 playSound("dst_oil_barrel_puncture_stream_start");
    var14 scalevolume(0, 0);
    var14 playLoopSound("dst_oil_barrel_puncture_stream_lp");
    var14 scalevolume(1, 0.25);
    thread sfx_stop_oil_barrel_stream();
    self.spewtags = scripts\engine\utility::array_add(self.spewtags, var11);
    thread oilimpactlife(var11);
  }
}

function oilbarrelshoulddie(var0, var1, var2, var3) {
  if(isDefined(var0) && var0 < 100) {
    return false;
  }

  if(isDefined(var2)) {
    switch (var2) {
      case "SPLASH":
      case "MOD_GRENADE_SPLASH":
      case "MOD_GRENADE":
      case "MOD_PROJECTILE_SPLASH":
      case "MOD_PROJECTILE":
      case "MOD_EXPLOSIVE":
        return true;
    }
  }

  return false;
}

function oilimpactlife(var0) {
  scripts\engine\utility::waittill_notify_or_timeout("entitydeleted", 5);

  if(isDefined(self)) {
    self.spewtags = scripts\engine\utility::array_remove(self.spewtags, var0);
  }

  var0 delete();
}

function oil_barrel_death() {
  self notify("barrel_death");

  if(isDefined(self)) {
    self hide();
  }

  playFX(level.g_effect["oil_barrel_death"], self.origin);

  foreach(var1 in self.spewtags) {
    killfxontag(level.g_effect["oil_barrel_impact"], var1, "tag_origin");
    waitframe();

    if(isDefined(var1)) {
      var1 delete();
    }
  }

  if(isDefined(self)) {
    thread delay_delete(5);
    return;
  }
}

function delay_delete(var0) {
  wait var0;

  if(isDefined(self)) {
    self delete();
    return;
  }
}

function sfx_stop_oil_barrel_stream() {
  wait 3.3;
  var0 = 0.25;
  self playSound("dst_oil_barrel_puncture_stream_stop");
  self scalevolume(0, var0);
  wait 0.3;
  self stoploopsound("dst_oil_barrel_puncture_stream_lp");
  self delete();
}