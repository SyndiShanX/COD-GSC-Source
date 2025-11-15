/***********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
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
  var_00 = getEntArray("floatingJackal", "targetname");
  foreach(var_02 in var_00) {
    thread func_90EF(var_02);
  }

  thread fix_via_models();
  thread runmodespecifictriggers();
  thread fix_collision();
}

fix_collision() {
  var_00 = getent("player32x32x32", "targetname");
  var_01 = spawn("script_model", (1360, 301, 110));
  var_01.angles = (0, 0, 6.5);
  var_01 clonebrushmodeltoscriptmodel(var_00);
  var_02 = getent("player32x32x32", "targetname");
  var_03 = spawn("script_model", (1198, 301, 110));
  var_03.angles = (0, 0, 6.5);
  var_03 clonebrushmodeltoscriptmodel(var_02);
  var_04 = getent("player64x64x8", "targetname");
  var_05 = spawn("script_model", (-376, 1300, 29));
  var_05.angles = (0, 0, 115);
  var_05 clonebrushmodeltoscriptmodel(var_04);
  var_06 = getent("player128x128x128", "targetname");
  var_07 = spawn("script_model", (1616, 1074, 112));
  var_07.angles = (0, 0, 0);
  var_07 clonebrushmodeltoscriptmodel(var_06);
  var_08 = getent("player256x256x8", "targetname");
  var_09 = spawn("script_model", (-1035.5, -1622.5, 387));
  var_09.angles = (360, 55.1, -90);
  var_09 clonebrushmodeltoscriptmodel(var_08);
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
    var_00 = spawn("trigger_radius", (532, -48, 16), 0, 32, 52);
    var_00.var_336 = "uplink_nozone";
    var_00 hide();
    level.nozonetriggers[level.nozonetriggers.size] = var_00;
  }
}

fix_via_models() {
  func_107CC("p7_picture_frame_modern_01_mp_flip_patch", (-840, 691.5, 92), (0, 270, 0));
  func_107CC("p7_picture_frame_modern_01_mp_flip_patch", (-796, 691.5, 92), (0, 270, 0));
  func_107CC("p7_picture_frame_modern_01_mp_flip_patch", (-696, 691.5, 92), (0, 270, 0));
  func_107CC("p7_picture_frame_modern_01_mp_flip_patch", (-652, 691.5, 92), (0, 270, 0));
}

func_107CC(param_00, param_01, param_02) {
  var_03 = spawn("script_model", param_01);
  var_03 setModel(param_00);
  var_03.angles = param_02;
}

func_CDA4(param_00) {
  wait(30);
  playcinematicforalllooping(param_00);
}

func_90EF(param_00) {
  param_00.areanynavvolumesloaded = param_00.origin;
  param_00.var_10D6C = param_00.angles;
  thread func_5EE1(param_00);
  thread func_5EE9(param_00);
}

func_5EE1(param_00) {
  var_01 = 1;
  for(;;) {
    var_02 = randomintrange(6, 13);
    param_00.objective_playermask_hidefromall = param_00.areanynavvolumesloaded + (randomintrange(-16, 16), randomintrange(-16, 16), var_01 * randomintrange(4, 16));
    param_00 moveto(param_00.objective_playermask_hidefromall, var_02, var_02 * 0.4, var_02 * 0.4);
    var_01 = var_01 * -1;
    wait(var_02);
  }
}

func_5EE9(param_00) {
  var_01 = 1;
  for(;;) {
    var_02 = randomintrange(7, 10);
    param_00.energy_getrestorerate = param_00.var_10D6C + (var_01 * randomintrange(1, 3), randomintrange(-2, 2), randomintrange(-3, 3));
    param_00 rotateto(param_00.energy_getrestorerate, var_02, var_02 * 0.4, var_02 * 0.4);
    var_01 = var_01 * -1;
    wait(var_02);
  }
}

func_5EE7(param_00) {
  foreach(var_02 in param_00.var_BE1E) {
    var_02 thread func_5EE8();
  }
}

func_5EE8() {
  wait(5);
  var_00 = scripts\engine\utility::spawn_tag_origin();
  var_00 show();
  var_00 linkto(self);
  scripts\engine\utility::waitframe();
  if(isDefined(self.var_336)) {
    playFXOnTag(scripts\engine\utility::getfx(self.var_336), var_00, "tag_origin");
  }
}

rotatefans() {
  var_00 = getEntArray("rotating_fan", "targetname");
  foreach(var_02 in var_00) {
    var_03 = 3 + randomint(8);
    var_02 thread func_E72B(var_03);
  }
}

func_E72B(param_00) {
  level endon("game_ended");
  var_01 = "roll";
  if(isDefined(self.script_noteworthy)) {
    var_01 = self.script_noteworthy;
  }

  var_02 = "Custom rotation axis must be one of yaw\pitch\roll";
  for(;;) {
    if(var_01 == "yaw") {
      self rotateyaw(360, param_00, 0, 0);
    } else if(var_01 == "pitch") {
      self rotatepitch(360, param_00, 0, 0);
    } else if(var_01 == "roll") {
      self rotateroll(360, param_00, 0, 0);
    }

    wait(param_00);
  }
}