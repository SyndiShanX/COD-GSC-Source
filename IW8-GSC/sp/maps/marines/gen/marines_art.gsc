/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\marines\gen\marines_art.gsc
***********************************************/

main() {
  level.tweakfile = 1;
  level.player = getEntArray("player", "classname")[0];
  init_post_flags();
  thread postfx_slam_zoom();
  thread postfx_ied_explosion();
}

init_post_flags() {
  scripts\engine\utility::flag_init("enable_volumetrics");
  scripts\engine\utility::flag_init("disable_volumetrics");
  scripts\engine\utility::flag_init("dynamic_dof_enabled");
  scripts\engine\utility::flag_init("enable_dynamic_sunshadow_first_steps");
  scripts\engine\utility::flag_init("enable_dynamic_shadow_canyon_to_pod_a");
  scripts\engine\utility::flag_init("enable_dynamic_sunshadow_jump_platforms");
  scripts\engine\utility::flag_init("enable_sun_shadow");
  scripts\engine\utility::flag_init("dynamicSunSampleRefinery");
  scripts\engine\utility::flag_init("endDynamicSunSampleRefinery");
  scripts\engine\utility::flag_init("postfx_slam_zoom_start");
  scripts\engine\utility::flag_init("postfx_ied_explosion");
}

postfx_slam_zoom() {
  scripts\engine\utility::flag_wait("postfx_slam_zoom_start");
  visionsetnaked("marines", 0.1);
}

postfx_ied_explosion() {
  scripts\engine\utility::flag_wait("postfx_ied_explosion");
  scripts\engine\utility::flag_wait("play_IED_explosion");
  waitframe();
  scripts\engine\sp\utility::motion_blur_enable(1, 0.5);
  visionsetnaked("marines_ied_a", 2.0);
  scripts\engine\sp\utility::motion_blur_disable(0.5);
  wait 1.0;
  visionsetnaked("marines", 5.0);
  wait 5.5;
  visionsetnaked("", 0.0);
}

init_flicker_and_siren_lights() {
  var_0 = getEntArray("hm_flicker_light", "targetname");
  scripts\engine\utility::array_thread(var_0, ::flicker_light_setup);
  var_1 = getEntArray("hm_siren_light", "targetname");
  scripts\engine\utility::array_thread(var_1, ::siren_light_setup);
}

flicker_light_setup() {
  var_0 = parse_noteworthy_values();
  self.frequency = 100;
  self.randomness = 0.1;
  self.max_intensity = 150;
  self.min_intensity = 5;
  self.start_flag = "hm_flicker_light_start";

  if(isDefined(var_0["frequency"]))
    self.frequency = float(var_0["frequency"]);

  if(isDefined(var_0["randomness"]))
    self.randomness = float(var_0["randomness"]);

  if(isDefined(var_0["max_intensity"]))
    self.max_intensity = float(var_0["max_intensity"]);

  if(isDefined(var_0["min_intensity"]))
    self.min_intensity = float(var_0["min_intensity"]);

  if(isDefined(var_0["start_flag"]))
    self.start_flag = var_0["start_flag"];

  thread flicker_light();
}

siren_light_setup() {
  var_0 = parse_noteworthy_values();
  self.heading = 0;
  self.pitch = 1;
  self.roll = 0;
  self.frequency = 1;
  self.intensity = 0.5;
  self.dir = 1;
  self.start_flag = "hm_siren_light_start";

  if(isDefined(var_0["heading"]))
    self.heading = float(var_0["heading"]);

  if(isDefined(var_0["pitch"]))
    self.pitch = float(var_0["pitch"]);

  if(isDefined(var_0["roll"]))
    self.roll = float(var_0["roll"]);

  if(isDefined(var_0["frequency"]))
    self.frequency = float(var_0["frequency"]);

  if(isDefined(var_0["intensity"]))
    self.intensity = float(var_0["intensity"]);

  if(isDefined(var_0["dir"]))
    self.dir = float(var_0["dir"]);

  if(isDefined(var_0["start_flag"]))
    self.start_flag = var_0["start_flag"];

  thread siren_light();
}

siren_light() {
  scripts\engine\utility::flag_wait(self.start_flag);
  var_0 = self.angles;
  var_1 = 0.0;
  self setlightintensity(self.intensity);

  while(scripts\engine\utility::flag(self.start_flag)) {
    if(var_1 > 360)
      var_1 = var_1 - 360;

    var_2 = var_0[0] + var_1 * self.pitch * self.dir;
    var_3 = var_0[1] + var_1 * self.heading * self.dir;
    var_4 = var_0[2] + var_1 * self.roll * self.dir;
    self rotateTo((var_2, var_3, var_4), 0.09);
    var_1 = var_1 + 360 / (1 / self.frequency) / 100;
    wait 0.11;
  }

  self setlightintensity(0.01);
  thread siren_light();
}

flicker_light() {
  scripts\engine\utility::flag_wait(self.start_flag);

  while(scripts\engine\utility::flag(self.start_flag)) {
    var_0 = randomfloatrange(self.min_intensity, self.max_intensity);
    self setlightintensity(var_0);
    wait(1 / self.frequency);
  }

  thread flicker_light();
}

parse_noteworthy_values() {
  var_0 = [];

  if(isDefined(self.script_noteworthy)) {
    var_1 = strtok(self.script_noteworthy, " ");

    foreach(var_3 in var_1) {
      var_4 = strtok(var_3, ":");
      var_0[var_4[0]] = var_4[1];
    }
  }

  return var_0;
}

lerplightintensity(var_0, var_1) {
  var_2 = self getlightintensity();
  var_3 = 1.0 / (var_1 / 0.2);
  var_4 = 0.0;

  while(var_4 <= 1) {
    var_4 = var_4 + var_3;
    var_5 = var_2 * (1 - var_4) + var_0 * var_4;
    self setlightintensity(var_5);
    wait 0.2;
  }
}

lerplightradius(var_0, var_1) {
  var_2 = self getlightradius();
  var_3 = 1.0 / (var_1 / 0.2);
  var_4 = 0.0;

  while(var_4 <= 1) {
    var_4 = var_4 + var_3;
    var_5 = var_2 * (1 - var_4) + var_0 * var_4;
    self setlightradius(var_5);
    wait 0.2;
  }
}

lerplightcolor(var_0, var_1) {
  var_2 = self getlightcolor();
  var_3 = 1.0 / (var_1 / 0.2);
  var_4 = 0.0;

  while(var_4 <= 1) {
    var_4 = var_4 + var_3;
    var_5 = vectorlerp(var_2, var_0, var_4);
    self setlightcolor(var_5);
    wait 0.2;
  }
}

flicker_light_and_fixture(var_0, var_1, var_2, var_3) {
  scripts\engine\utility::flag_wait(var_0);
  var_4 = getEntArray(var_1, "targetname");
  var_5 = getEnt(var_2, "targetname");
  var_6 = getEnt(var_3, "targetname");
  var_7 = [];

  for(var_8 = 0; var_8 < var_4.size; var_8++)
    var_7[var_8] = var_4[var_8] getlightintensity();

  var_9 = "on";

  while(scripts\engine\utility::flag(var_0)) {
    if(var_9 == "on") {
      foreach(var_11 in var_4)
      var_11 setlightintensity(0);

      if(isDefined(var_5) && isDefined(var_6)) {
        var_5 hide();
        var_6 show();
      }

      var_9 = "off";
    } else {
      for(var_8 = 0; var_8 < var_4.size; var_8++)
        var_4[var_8] setlightintensity(var_7[var_8]);

      if(isDefined(var_5) && isDefined(var_6)) {
        var_5 show();
        var_6 hide();
      }

      var_9 = "on";
    }

    wait(randomfloatrange(0.05, 0.3));
  }
}

clearvisionsetnaked() {
  scripts\engine\utility::flag_wait("clear_vision_set_naked");
  visionsetnaked("", 0.5);
  scripts\engine\utility::flag_clear("clear_vision_set_naked");
  wait 0.2;
  thread clearvisionsetnaked();
}

visionsetflag(var_0, var_1, var_2) {
  scripts\engine\utility::flag_wait(var_2);
  setvisionsetnaked(var_0, var_1);
  scripts\engine\utility::flag_clear(var_2);
  wait(var_1 + 0.05);
  thread visionsetflag(var_0, var_1, var_2);
}

setvisionsetnaked(var_0, var_1, var_2) {
  visionsetnaked(var_0, var_1);

  if(!isDefined(var_2))
    level.current_visionset = var_0;
  else if(var_2)
    level.current_visionset = var_0;
}

enable_volumetrics() {
  scripts\engine\utility::flag_wait("enable_volumetrics");
  setsaveddvar("QPLMKRON", 1);
  scripts\engine\utility::flag_clear("enable_volumetrics");
  wait 1.0;
  thread enable_volumetrics();
}

disable_volumetrics() {
  scripts\engine\utility::flag_wait("disable_volumetrics");
  setsaveddvar("QPLMKRON", 0);
  scripts\engine\utility::flag_clear("disable_volumetrics");
  wait 1.0;
  thread disable_volumetrics();
}

damagerumblequake(var_0, var_1, var_2, var_3, var_4) {
  var_5 = randomfloatrange(var_3, var_4);
  earthquake(var_5, var_2, level.player.origin, 800);
  wait(var_2);

  if(var_5 > 0.2) {
    level.player playrumblelooponentity("damage_heavy");
    wait(var_2 * 2.0);
    level.player stoprumble("damage_heavy");
  } else if(var_5 > 0.1) {
    level.player playrumblelooponentity("damage_light");
    wait(var_2);
    level.player stoprumble("damage_light");
  }
}

motionblurtest() {
  scripts\engine\sp\utility::motion_blur_enable(1, 1);
}

dynamic_dof() {
  while(scripts\engine\utility::flag("dynamic_dof_enabled")) {
    var_0 = level.player getEye();
    var_1 = anglesToForward(level.player getplayerangles());
    var_2 = physicstrace(var_0, var_0 + var_1 * 32000);
    var_3 = distance(var_2, var_0);
    var_4 = var_3 * 0.975;
    var_5 = var_4 * 20.0;
    var_6 = 3.0;
    var_7 = 0.0;
    var_8 = var_4 * 0.25;
    var_9 = 3.0;
    var_10 = 0.2;
    thread scripts\sp\art::dof_enable_script(var_7, var_8, var_9, var_4, var_5, var_6, var_10);
    wait 0.2;
  }

  thread scripts\sp\art::dof_disable_script(1);
}

dyanmic_sun_sample_size(var_0, var_1, var_2, var_3, var_4, var_5) {
  scripts\engine\utility::flag_wait(var_0);

  while(scripts\engine\utility::flag(var_0)) {
    var_6 = anglesToForward(level.player getplayerangles());
    var_7 = vectordot(var_6, var_2);
    var_8 = (var_7 + 1) * 0.5;
    var_9 = pow(var_8, var_1);
    var_10 = vectorlerp((var_3, 0, 0), (var_4, 0, 0), var_9);
    wait 0.1;
  }
}

playsoundatpoint(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawn("script_origin", var_1);
  var_5 playSound(var_0, "sounddone");

  if(isDefined(var_2))
    var_5 scalepitch(var_2, 0);

  if(isDefined(var_3))
    var_5 scalevolume(var_3, 0);

  if(isDefined(var_4))
    var_5 linkTo(var_4);

  var_5 waittill("sounddone");
  var_5 delete();
}