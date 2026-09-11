/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\proxywar\proxywar_lighting.gsc
**********************************************************/

function main() {
  scripts\engine\sp\utility::motion_blur_enable(1, 1);
  thread init_lighting_dvars();
  init_lights();
  thread lights_off("proxywar_lights_overlook_fire");
  thread lights_off("proxywar_lights_end_explosion");
  thread lights_off("tower_lights");
  thread lights_off("warehouse_light_gas");
  var0 = getEntArray("sunblend", "targetname");

  foreach(var2 in var0) {
    thread blend_sun_intensity_over_distance_trigger();
  }
}

function init_lights(var0) {
  var1 = getEntArray();

  foreach(var3 in var1) {
    if(issubstr(var3.classname, "light")) {
      var3.og_intensity = var3 getlightintensity();
    }
  }
}

function init_lighting_dvars() {
  setsaveddvar("NPONLLLSPL", 0.2);
  setsaveddvar("LSNRQTOKRR", 2);
  setsaveddvar("NTLKNLNPLK", 2);
  setsaveddvar("TMNTMTQRM", 1);
  setsaveddvar("LKOLRONRNQ", 800);
  waitframe();
  setsaveddvar("LTQMSPKRKO", 6);
  setsaveddvar("MROOOROPKL", 9);
}

function lights_off(var0) {
  var1 = getEntArray(var0, "targetname");

  foreach(var3 in var1) {
    var3 setlightintensity(0);
  }
}

function lights_on(var0) {
  var1 = getEntArray(var0, "targetname");

  foreach(var3 in var1) {
    var3 setlightintensity(var3.og_intensity);
  }
}

function blend_sun_intensity_over_distance_trigger() {
  wait 0.25;
  var0 = scripts\engine\utility::getStruct(self.target, "targetname");
  var1 = float(var0.script_parameters);
  var2 = scripts\engine\utility::getStruct(var0.target, "targetname");
  var3 = float(var2.script_parameters);
  var4 = distance(var0.origin, var2.origin);

  for(;;) {
    self waittill("trigger");

    while(level.player istouching(self)) {
      var5 = pointonsegmentnearesttopoint(var0.origin, var2.origin, level.player.origin);
      var6 = scripts\engine\math::normalize_value(0, var4, distance(var0.origin, var5));
      var7 = scripts\engine\math::factor_value(var1, var3, var6);
      setsuncolorandintensity(var7);
      waitframe();
    }
  }
}

function end_sequence_dof() {
  wait 11;
  level.alpha1 thread scripts\engine\sp\utility::dof_enable_autofocus(1.8, 8, undefined, undefined, "tag_eye", undefined, 1);
  wait 12;
  level.fakeaq thread scripts\engine\sp\utility::dof_enable_autofocus(2.8, 8, undefined, undefined, "tag_eye", undefined, 1);
  wait 6;
  level.hadir thread scripts\engine\sp\utility::dof_enable_autofocus(1.8, 8, undefined, undefined, "tag_eye", undefined, 1);
  wait 20;
  level.player.bodydouble thread scripts\engine\sp\utility::dof_enable_autofocus(1.2, 8, undefined, undefined, "tag_eye", undefined, 1);
}