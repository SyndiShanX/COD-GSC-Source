/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\tunnels\zd30tunnels_lighting.gsc
****************************************************/

main() {
  scripts\engine\sp\utility::post_load_precache(::post_load);
  thread setup_infil_lights();
}

post_load() {
  scripts\engine\sp\utility::motion_blur_enable(1, 1);
  thread setup_lighting_dvars();
}

setup_lighting_dvars() {
  setsaveddvar("MQRQQONQSL", 0);
  setsaveddvar("NPONLLLSPL", 0.05);
  setsaveddvar("LSNRQTOKRR", 0);
  setsaveddvar("RNPPKQOTN", 1);
  setsaveddvar("QPLMKRON", 1);
  setsaveddvar("MROOOROPKL", 8);
  setsaveddvar("LTQMSPKRKO", 8);
  setsaveddvar("OMKTSMSOS", 0);
  wait 5;
  setsaveddvar("LKOLRONRNQ", 600);
}

setup_infil_lights() {
  while(!isDefined(level.infil_heli_alpha) && !isDefined(level.infil_heli_bravo))
    waitframe();

  level.infil_heli_cockpit_light = getEnt("infil_heli_alpha_cockpit_light", "targetname");
  level.infil_heli_cockpit_light setlightintensity(0.05);
  level.infil_heli_cockpit_light setlightradius(300);
  level.infil_heli_cockpit_light setlightfovrange(120, 65);
  level.infil_heli_cockpit_light setlightcolor((0.7, 0.1, 0.05));
  level.infil_heli_cockpit_light linkTo(level.infil_heli_alpha, "tag_passenger5", (0, -15, 50), (30, 90, 0));
  level.infil_heli_fill_light = getEnt("infil_heli_alpha_fill_light", "targetname");
  level.infil_heli_fill_light setlightintensity(0.05);
  level.infil_heli_fill_light setlightradius(150);
  level.infil_heli_fill_light setlightfovrange(110, 20);
  level.infil_heli_fill_light setlightcolor((0.7, 0.1, 0.05));
  level.infil_heli_fill_light linkTo(level.infil_heli_bravo, "tag_origin", (-5, 20, -35), (30, -60, 0));
}

dof_kyledrone() {
  thread scripts\engine\sp\utility::dof_enable_autofocus(2.0, 4, undefined, 60, undefined);
  scripts\engine\utility::flag_wait("pre_anim_finished");
  scripts\engine\sp\utility::dof_disable_autofocus();
  level thread scripts\engine\sp\utility::dof_enable_autofocus(5.6, 4, undefined, 90, undefined);
  scripts\engine\utility::flag_wait("lb_landed");
  level scripts\engine\sp\utility::dof_disable_autofocus();
}

fire_trigger_on_and_off() {
  var_0 = getEnt("light_fire_motion", "targetname");
  var_0 setlightintensity(0.0);
  var_1 = getEnt("script_light_on", "targetname");
  var_1 waittill("trigger");
  iprintlnbold("***script light on***");
  var_0 thread fire_flicker();
  var_1 = getEnt("script_light_off", "targetname");
  var_1 waittill("trigger");
  iprintlnbold("***script light off***");
  var_0 notify("stop_fire_flicker");
  var_0 setlightintensity(0.0);
}

fire_flicker() {
  thread setup_fire_flicker();
  self endon("death");
  self endon("stop_fire_flicker");
  self.og_origin = self.origin;
  var_0 = 10;
  var_1 = 0.05;
  var_2 = 0.2;
  var_3 = 0;
  var_4 = [];
  var_4["intensity"] = create_light_setting("intensity", self getlightintensity(), 0.125, 1, 0.05, 0.25, ::setlightintensity);
  var_4["color"] = create_light_setting("color", self getlightcolor(), 0.25, 1, 0.05, 0.25, ::setlightcolor);
  var_4["range"] = create_light_setting("range", self getlightradius(), 0.9, 1, 0.05, 0.15, ::setlightradius);

  for(;;) {
    waitframe();

    if(gettime() > var_3) {
      var_5 = var_0 * randomfloatrange(-1, 1);
      var_6 = var_0 * randomfloatrange(-1, 1);
      var_7 = var_0 * randomfloatrange(-1, 1);
      var_8 = self.og_origin + (var_5, var_6, var_7);
      var_9 = randomfloatrange(var_1, var_2);
      var_3 = gettime() + var_9 * 1000;
      self moveTo(var_8, var_9);
    }

    var_10 = 0;

    foreach(var_13, var_12 in var_4) {
      lerp_light_setting(var_12);
      var_10++;
    }
  }
}

setup_fire_flicker() {
  var_0 = getEnt("light_fire_motion", "targetname");
  var_0 setlightcolor((1, 0.2, 0));
  var_0 setlightintensity(15);
  var_0 setlightfovrange(100, 4);
  var_0 setlightradius(200);
}

create_light_setting(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawnStruct();
  var_7.ogval = var_1;
  var_7.nextval = var_7.ogval;
  var_7.prevval = var_7.ogval;
  var_7.value = var_1;
  var_7.minscale = var_2;
  var_7.maxscale = var_3;
  var_7.mintime = var_4;
  var_7.maxtime = var_5;
  var_7.func = var_6;
  var_7.count = 0;
  var_7.count_total = 0;
  return var_7;
}

lerp_light_setting(var_0) {
  if(var_0.count == var_0.count_total) {
    var_0.count_total = int(randomfloatrange(var_0.mintime, var_0.maxtime) * 20);
    var_0.count = 0;
    var_0.nextval = var_0.ogval * randomfloatrange(var_0.minscale, var_0.maxscale);
    var_0.prevval = var_0.value;
  }

  var_0.value = scripts\engine\math::lerp(var_0.prevval, var_0.nextval, var_0.count / var_0.count_total);
  self call[[var_0.func]](var_0.value);
  var_0.count++;
}