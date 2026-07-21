/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\proxywar\proxywar_lighting.gsc
**************************************************/

main() {
  scripts\engine\sp\utility::motion_blur_enable(1, 1);
  thread init_lighting_dvars();
  init_lights();
  thread lights_off("proxywar_lights_overlook_fire");
  thread lights_off("proxywar_lights_end_explosion");
  thread lights_off("tower_lights");
  thread lights_off("warehouse_light_gas");
  var_0 = getEntArray("sunblend", "targetname");

  foreach(var_2 in var_0)
  var_2 thread blend_sun_intensity_over_distance_trigger();
}

init_lights(var_0) {
  var_1 = getEntArray();

  foreach(var_3 in var_1) {
    if(issubstr(var_3.classname, "light"))
      var_3.og_intensity = var_3 getlightintensity();
  }
}

init_lighting_dvars() {
  setsaveddvar("NPONLLLSPL", 0.2);
  setsaveddvar("LSNRQTOKRR", 2);
  setsaveddvar("NTLKNLNPLK", 2);
  setsaveddvar("TMNTMTQRM", 1);
  setsaveddvar("LKOLRONRNQ", 800);
  waitframe();
  setsaveddvar("LTQMSPKRKO", 6);
  setsaveddvar("MROOOROPKL", 9);
}

lights_off(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  foreach(var_3 in var_1)
  var_3 setlightintensity(0);
}

lights_on(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  foreach(var_3 in var_1)
  var_3 setlightintensity(var_3.og_intensity);
}

blend_sun_intensity_over_distance_trigger() {
  wait 0.25;
  var_0 = scripts\engine\utility::getStruct(self.target, "targetname");
  var_1 = float(var_0.script_parameters);
  var_2 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  var_3 = float(var_2.script_parameters);
  var_4 = distance(var_0.origin, var_2.origin);

  for(;;) {
    self waittill("trigger");

    while(level.player istouching(self)) {
      var_5 = pointonsegmentnearesttopoint(var_0.origin, var_2.origin, level.player.origin);
      var_6 = scripts\engine\math::normalize_value(0, var_4, distance(var_0.origin, var_5));
      var_7 = scripts\engine\math::factor_value(var_1, var_3, var_6);
      setsuncolorandintensity(var_7);
      waitframe();
    }
  }
}

end_sequence_dof() {
  wait 11;
  level.alpha1 thread scripts\engine\sp\utility::dof_enable_autofocus(1.8, 8, undefined, undefined, "tag_eye", undefined, 1);
  wait 12;
  level.fakeaq thread scripts\engine\sp\utility::dof_enable_autofocus(2.8, 8, undefined, undefined, "tag_eye", undefined, 1);
  wait 6;
  level.hadir thread scripts\engine\sp\utility::dof_enable_autofocus(1.8, 8, undefined, undefined, "tag_eye", undefined, 1);
  wait 20;
  level.player.bodydouble thread scripts\engine\sp\utility::dof_enable_autofocus(1.2, 8, undefined, undefined, "tag_eye", undefined, 1);
}