/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\marines\gen\marines_art.gsc
*******************************************************/

function main() {
  level.tweakfile = 1;
  level.player = getEntArray("player", "classname")[0];
  init_post_flags();
  thread postfx_slam_zoom();
  thread postfx_ied_explosion();
}

function init_post_flags() {
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

function postfx_slam_zoom() {
  scripts\engine\utility::flag_wait("postfx_slam_zoom_start");
  visionsetnaked("marines", 0.1);
}

function postfx_ied_explosion() {
  scripts\engine\utility::flag_wait("postfx_ied_explosion");
  scripts\engine\utility::flag_wait("play_IED_explosion");
  waitframe();
  scripts\engine\sp\utility::motion_blur_enable(1, 0.5);
  visionsetnaked("marines_ied_a", 2);
  scripts\engine\sp\utility::motion_blur_disable(0.5);
  wait 1;
  visionsetnaked("marines", 5);
  wait 5.5;
  visionsetnaked("", 0);
}

function init_flicker_and_siren_lights() {
  var0 = getEntArray("hm_flicker_light", "targetname");
  scripts\engine\utility::array_thread(var0, &flicker_light_setup);
  var1 = getEntArray("hm_siren_light", "targetname");
  scripts\engine\utility::array_thread(var1, &siren_light_setup);
}

function flicker_light_setup() {
  var0 = parse_noteworthy_values();
  self.frequency = 100;
  self.randomness = 0.1;
  self.max_intensity = 150;
  self.min_intensity = 5;
  self.start_flag = "hm_flicker_light_start";

  if(isDefined(var0["frequency"])) {
    self.frequency = float(var0["frequency"]);
  }

  if(isDefined(var0["randomness"])) {
    self.randomness = float(var0["randomness"]);
  }

  if(isDefined(var0["max_intensity"])) {
    self.max_intensity = float(var0["max_intensity"]);
  }

  if(isDefined(var0["min_intensity"])) {
    self.min_intensity = float(var0["min_intensity"]);
  }

  if(isDefined(var0["start_flag"])) {
    self.start_flag = var0["start_flag"];
  }

  thread flicker_light();
}

function siren_light_setup() {
  var0 = parse_noteworthy_values();
  self.heading = 0;
  self.pitch = 1;
  self.roll = 0;
  self.frequency = 1;
  self.intensity = 0.5;
  self.dir = 1;
  self.start_flag = "hm_siren_light_start";

  if(isDefined(var0["heading"])) {
    self.heading = float(var0["heading"]);
  }

  if(isDefined(var0["pitch"])) {
    self.pitch = float(var0["pitch"]);
  }

  if(isDefined(var0["roll"])) {
    self.roll = float(var0["roll"]);
  }

  if(isDefined(var0["frequency"])) {
    self.frequency = float(var0["frequency"]);
  }

  if(isDefined(var0["intensity"])) {
    self.intensity = float(var0["intensity"]);
  }

  if(isDefined(var0["dir"])) {
    self.dir = float(var0["dir"]);
  }

  if(isDefined(var0["start_flag"])) {
    self.start_flag = var0["start_flag"];
  }

  thread siren_light();
}

function siren_light() {
  scripts\engine\utility::flag_wait(self.start_flag);
  var0 = self.angles;
  var1 = 0;
  self setlightintensity(self.intensity);

  while(scripts\engine\utility::flag(self.start_flag)) {
    if(var1 > 360) {
      var1 -= 360;
    }

    var2 = var0[0] + var1 * self.pitch * self.dir;
    var3 = var0[1] + var1 * self.heading * self.dir;
    var4 = var0[2] + var1 * self.roll * self.dir;
    self rotateTo((var2, var3, var4), 0.09);
    var1 += 360 / 1 / self.frequency / 100;
    wait 0.11;
  }

  self setlightintensity(0.01);
  thread siren_light();
}

function flicker_light() {
  scripts\engine\utility::flag_wait(self.start_flag);

  while(scripts\engine\utility::flag(self.start_flag)) {
    var0 = randomfloatrange(self.min_intensity, self.max_intensity);
    self setlightintensity(var0);
    wait 1 / self.frequency;
  }

  thread flicker_light();
}

function parse_noteworthy_values() {
  var0 = [];

  if(isDefined(self.script_noteworthy)) {
    var1 = strtok(self.script_noteworthy, " ");

    foreach(var3 in var1) {
      var4 = strtok(var3, ":");
      var0 = var4[1];
    }
  }

  return var0;
}

function lerplightintensity(var0, var1) {
  var2 = self getlightintensity();
  var3 = 1 / var1 / 0.2;
  var4 = 0;

  while(var4 <= 1) {
    var4 += var3;
    var5 = var2 * (1 - var4) + var0 * var4;
    self setlightintensity(var5);
    wait 0.2;
  }
}

function lerplightradius(var0, var1) {
  var2 = self getlightradius();
  var3 = 1 / var1 / 0.2;
  var4 = 0;

  while(var4 <= 1) {
    var4 += var3;
    var5 = var2 * (1 - var4) + var0 * var4;
    self setlightradius(var5);
    wait 0.2;
  }
}

function lerplightcolor(var0, var1) {
  var2 = self getlightcolor();
  var3 = 1 / var1 / 0.2;
  var4 = 0;

  while(var4 <= 1) {
    var4 += var3;
    var5 = vectorlerp(var2, var0, var4);
    self setlightcolor(var5);
    wait 0.2;
  }
}

function flicker_light_and_fixture(var0, var1, var2, var3) {
  scripts\engine\utility::flag_wait(var0);
  var4 = getEntArray(var1, "targetname");
  var5 = getEnt(var2, "targetname");
  var6 = getEnt(var3, "targetname");
  var7 = [];

  for(var8 = 0; var8 < var4.size; var8++) {
    var7 = var4[var8] getlightintensity();
  }

  var9 = "on";

  while(scripts\engine\utility::flag(var0)) {
    if(var9 == "on") {
      foreach(var11 in var4) {
        var11 setlightintensity(0);
      }

      if(isDefined(var5) && isDefined(var6)) {
        var5 hide();
        var6 show();
      }

      var9 = "off";
    } else {
      for(var8 = 0; var8 < var4.size; var8++) {
        var4[var8] setlightintensity(var7[var8]);
      }

      if(isDefined(var5) && isDefined(var6)) {
        var5 show();
        var6 hide();
      }

      var9 = "on";
    }

    wait randomfloatrange(0.05, 0.3);
  }
}

function clearvisionsetnaked() {
  scripts\engine\utility::flag_wait("clear_vision_set_naked");
  visionsetnaked("", 0.5);
  scripts\engine\utility::flag_clear("clear_vision_set_naked");
  wait 0.2;
  thread clearvisionsetnaked();
}

function visionsetflag(var0, var1, var2) {
  scripts\engine\utility::flag_wait(var2);
  setvisionsetnaked(var0, var1);
  scripts\engine\utility::flag_clear(var2);
  wait var1 + 0.05;
  thread visionsetflag(var0, var1, var2);
}

function setvisionsetnaked(var0, var1, var2) {
  visionsetnaked(var0, var1);

  if(!isDefined(var2)) {
    level.current_visionset = var0;
    return;
  }

  if(var2) {
    level.current_visionset = var0;
    return;
  }
}

function enable_volumetrics() {
  scripts\engine\utility::flag_wait("enable_volumetrics");
  setsaveddvar("QPLMKRON", 1);
  scripts\engine\utility::flag_clear("enable_volumetrics");
  wait 1;
  thread enable_volumetrics();
}

function disable_volumetrics() {
  scripts\engine\utility::flag_wait("disable_volumetrics");
  setsaveddvar("QPLMKRON", 0);
  scripts\engine\utility::flag_clear("disable_volumetrics");
  wait 1;
  thread disable_volumetrics();
}

function damagerumblequake(var0, var1, var2, var3, var4) {
  var5 = randomfloatrange(var3, var4);
  earthquake(var5, var2, level.player.origin, 800);
  wait var2;

  if(var5 > 0.2) {
    level.player playrumblelooponentity("damage_heavy");
    wait var2 * 2;
    level.player stoprumble("damage_heavy");
    return;
  }

  if(var5 > 0.1) {
    level.player playrumblelooponentity("damage_light");
    wait var2;
    level.player stoprumble("damage_light");
    return;
  }
}

function motionblurtest() {
  scripts\engine\sp\utility::motion_blur_enable(1, 1);
}

function dynamic_dof() {
  while(scripts\engine\utility::flag("dynamic_dof_enabled")) {
    var0 = level.player getEye();
    var1 = anglesToForward(level.player getplayerangles());
    var2 = physicstrace(var0, var0 + var1 * 32000);
    var3 = distance(var2, var0);
    var4 = var3 * 0.975;
    var5 = var4 * 20;
    var6 = 3;
    var7 = 0;
    var8 = var4 * 0.25;
    var9 = 3;
    var10 = 0.2;
    thread scripts\sp\art::dof_enable_script(var7, var8, var9, var4, var5, var6, var10);
    wait 0.2;
  }

  thread scripts\sp\art::dof_disable_script(1);
}

function dyanmic_sun_sample_size(var0, var1, var2, var3, var4, var5) {
  scripts\engine\utility::flag_wait(var0);

  while(scripts\engine\utility::flag(var0)) {
    var6 = anglesToForward(level.player getplayerangles());
    var7 = vectordot(var6, var2);
    var8 = (var7 + 1) * 0.5;
    var9 = pow(var8, var1);
    var10 = vectorlerp((var3, 0, 0), (var4, 0, 0), var9);
    wait 0.1;
  }
}

function playsoundatpoint(var0, var1, var2, var3, var4) {
  var5 = spawn("script_origin", var1);
  var5 playSound(var0, "sounddone");

  if(isDefined(var2)) {
    var5 scalepitch(var2, 0);
  }

  if(isDefined(var3)) {
    var5 scalevolume(var3, 0);
  }

  if(isDefined(var4)) {
    var5 linkTo(var4);
  }

  var5 waittill("sounddone");
  var5 delete();
}