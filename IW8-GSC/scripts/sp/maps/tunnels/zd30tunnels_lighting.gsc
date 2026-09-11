/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\tunnels\zd30tunnels_lighting.gsc
************************************************************/

function main() {
  scripts\engine\sp\utility::post_load_precache(&post_load);
  thread setup_infil_lights();
}

function post_load() {
  scripts\engine\sp\utility::motion_blur_enable(1, 1);
  thread setup_lighting_dvars();
}

function setup_lighting_dvars() {
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

function setup_infil_lights() {
  while(!isDefined(level.infil_heli_alpha) && !isDefined(level.infil_heli_bravo)) {
    waitframe();
  }

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

function dof_kyledrone() {
  thread scripts\engine\sp\utility::dof_enable_autofocus(2, 4, undefined, 60, undefined);
  scripts\engine\utility::flag_wait("pre_anim_finished");
  scripts\engine\sp\utility::dof_disable_autofocus();
  level thread scripts\engine\sp\utility::dof_enable_autofocus(5.6, 4, undefined, 90, undefined);
  scripts\engine\utility::flag_wait("lb_landed");
  level scripts\engine\sp\utility::dof_disable_autofocus();
}

function fire_trigger_on_and_off() {
  var0 = getEnt("light_fire_motion", "targetname");
  var0 setlightintensity(0);
  var1 = getEnt("script_light_on", "targetname");
  var1 waittill("trigger");
  iprintlnbold("***script light on***");
  thread fire_flicker();
  var1 = getEnt("script_light_off", "targetname");
  var1 waittill("trigger");
  iprintlnbold("***script light off***");
  var0 notify("stop_fire_flicker");
  var0 setlightintensity(0);
}

function fire_flicker() {
  thread setup_fire_flicker();
  self endon("death");
  self endon("stop_fire_flicker");
  self.og_origin = self.origin;
  var0 = 10;
  var1 = 0.05;
  var2 = 0.2;
  var3 = 0;
  var4 = [];
  GscBinSkip0(0x2e, "intensity", create_light_setting("intensity", self getlightintensity(), 0.125, 1, 0.05, 0.25, &setlightintensity));
}

function setup_fire_flicker() {
  var0 = getEnt("light_fire_motion", "targetname");
  var0 setlightcolor((1, 0.2, 0));
  var0 setlightintensity(15);
  var0 setlightfovrange(100, 4);
  var0 setlightradius(200);
}

function create_light_setting(var0, var1, var2, var3, var4, var5, var6) {
  var7 = spawnStruct();
  var7.ogval = var1;
  var7.nextval = var7.ogval;
  var7.prevval = var7.ogval;
  var7.value = var1;
  var7.minscale = var2;
  var7.maxscale = var3;
  var7.mintime = var4;
  var7.maxtime = var5;
  var7.func = var6;
  var7.count = 0;
  var7.count_total = 0;
  return var7;
}

function lerp_light_setting(var0) {
  if(var0.count == var0.count_total) {
    var0.count_total = int(randomfloatrange(var0.mintime, var0.maxtime) * 20);
    var0.count = 0;
    var0.nextval = var0.ogval * randomfloatrange(var0.minscale, var0.maxscale);
    var0.prevval = var0.value;
  }

  var0.value = scripts\engine\math::lerp(var0.prevval, var0.nextval, var0.count / var0.count_total);
  self builtin[[var0.func]](var0.value);
  var0.count++;
}