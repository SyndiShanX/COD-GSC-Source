/***********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_flip\mp_flip.gsc
***********************************************/

main() {
  scripts\mp\maps\mp_flip\mp_flip_precache::main();
  scripts\mp\maps\mp_flip\gen\mp_flip_art::main();
  scripts\mp\maps\mp_flip\mp_flip_fx::main();
  scripts\mp\load::main();
  level.var_C7B3 = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_flip");
  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);
  setdvar("r_umbraMinObjectContribution", 8);
  setdvar("pmovePerfSkipWorldUpVolumeCheck", 0);
  setdvar("deploy_allowInWater", 1);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  thread scripts\mp\animation_suite::animationsuite();
  thread func_CDA4("mp_flip_screen");
  thread rotatefans();
  var_0 = getEntArray("floatingJackal", "targetname");
  foreach(var_2 in var_0) {
    thread func_90EF(var_2);
  }

  thread fix_via_models();
  thread runmodespecifictriggers();
  thread fix_collision();
}

fix_collision() {
  var_0 = getent("player32x32x32", "targetname");
  var_1 = spawn("script_model", (1360, 301, 110));
  var_1.angles = (0, 0, 6.5);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getent("player32x32x32", "targetname");
  var_3 = spawn("script_model", (1198, 301, 110));
  var_3.angles = (0, 0, 6.5);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = getent("player64x64x8", "targetname");
  var_5 = spawn("script_model", (-376, 1300, 29));
  var_5.angles = (0, 0, 115);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_6 = getent("player128x128x128", "targetname");
  var_7 = spawn("script_model", (1616, 1074, 112));
  var_7.angles = (0, 0, 0);
  var_7 clonebrushmodeltoscriptmodel(var_6);
  var_8 = getent("player256x256x8", "targetname");
  var_9 = spawn("script_model", (-1035.5, -1622.5, 387));
  var_9.angles = (360, 55.1, -90);
  var_9 clonebrushmodeltoscriptmodel(var_8);
  var_0A = getent("player256x256x8", "targetname");
  var_0B = spawn("script_model", (-1569.5, -1171.5, 387));
  var_0B.angles = (360, 34.6, -90);
  var_0B clonebrushmodeltoscriptmodel(var_0A);
  var_0C = getent("player256x256x256", "targetname");
  var_0D = spawn("script_model", (-576, 336, 800));
  var_0D.angles = (0, 0, 0);
  var_0D clonebrushmodeltoscriptmodel(var_0C);
  var_0E = getent("player32x32x128", "targetname");
  var_0F = spawn("script_model", (1250, -28, -50));
  var_0F.angles = (270, 180, 180);
  var_0F clonebrushmodeltoscriptmodel(var_0E);
}

runmodespecifictriggers() {
  if(level.gametype == "ball" || level.gametype == "tdef") {
    wait(1);
    var_0 = spawn("trigger_radius", (532, -48, 16), 0, 32, 52);
    var_0.var_336 = "uplink_nozone";
    var_0 hide();
    level.nozonetriggers[level.nozonetriggers.size] = var_0;
  }
}

fix_via_models() {
  func_107CC("p7_picture_frame_modern_01_mp_flip_patch", (-840, 691.5, 92), (0, 270, 0));
  func_107CC("p7_picture_frame_modern_01_mp_flip_patch", (-796, 691.5, 92), (0, 270, 0));
  func_107CC("p7_picture_frame_modern_01_mp_flip_patch", (-696, 691.5, 92), (0, 270, 0));
  func_107CC("p7_picture_frame_modern_01_mp_flip_patch", (-652, 691.5, 92), (0, 270, 0));
}

func_107CC(var_0, var_1, var_2) {
  var_3 = spawn("script_model", var_1);
  var_3 setModel(var_0);
  var_3.angles = var_2;
}

func_CDA4(var_0) {
  wait(30);
  playcinematicforalllooping(var_0);
}

func_90EF(var_0) {
  var_0.areanynavvolumesloaded = var_0.origin;
  var_0.var_10D6C = var_0.angles;
  thread func_5EE1(var_0);
  thread func_5EE9(var_0);
}

func_5EE1(var_0) {
  var_1 = 1;
  for(;;) {
    var_2 = randomintrange(6, 13);
    var_0.objective_playermask_hidefromall = var_0.areanynavvolumesloaded + (randomintrange(-16, 16), randomintrange(-16, 16), var_1 * randomintrange(4, 16));
    var_0 moveto(var_0.objective_playermask_hidefromall, var_2, var_2 * 0.4, var_2 * 0.4);
    var_1 = var_1 * -1;
    wait(var_2);
  }
}

func_5EE9(var_0) {
  var_1 = 1;
  for(;;) {
    var_2 = randomintrange(7, 10);
    var_0.energy_getrestorerate = var_0.var_10D6C + (var_1 * randomintrange(1, 3), randomintrange(-2, 2), randomintrange(-3, 3));
    var_0 rotateto(var_0.energy_getrestorerate, var_2, var_2 * 0.4, var_2 * 0.4);
    var_1 = var_1 * -1;
    wait(var_2);
  }
}

func_5EE7(var_0) {
  foreach(var_2 in var_0.var_BE1E) {
    var_2 thread func_5EE8();
  }
}

func_5EE8() {
  wait(5);
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0 show();
  var_0 linkto(self);
  scripts\engine\utility::waitframe();
  if(isDefined(self.var_336)) {
    playFXOnTag(scripts\engine\utility::getfx(self.var_336), var_0, "tag_origin");
  }
}

rotatefans() {
  var_0 = getEntArray("rotating_fan", "targetname");
  foreach(var_2 in var_0) {
    var_3 = 3 + randomint(8);
    var_2 thread func_E72B(var_3);
  }
}

func_E72B(var_0) {
  level endon("game_ended");
  var_1 = "roll";
  if(isDefined(self.script_noteworthy)) {
    var_1 = self.script_noteworthy;
  }

  var_2 = "Custom rotation axis must be one of yaw\pitch\roll";
  for(;;) {
    if(var_1 == "yaw") {
      self rotateyaw(360, var_0, 0, 0);
    } else if(var_1 == "pitch") {
      self rotatepitch(360, var_0, 0, 0);
    } else if(var_1 == "roll") {
      self rotateroll(360, var_0, 0, 0);
    }

    wait(var_0);
  }
}