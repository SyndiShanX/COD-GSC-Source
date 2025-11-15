/***********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_neon\mp_neon.gsc
***********************************************/

main() {
  scripts\mp\maps\mp_neon\mp_neon_precache::main();
  scripts\mp\maps\mp_neon\gen\mp_neon_art::main();
  scripts\mp\maps\mp_neon\mp_neon_fx::main();
  scripts\mp\load::main();
  scripts\mp\compass::setupminimap("compass_map_mp_neon");
  level.var_C7B3 = getEntArray("OutOfBounds", "targetname");
  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);
  setdvar("r_umbraMinObjectContribution", 8);
  setdvar("sm_sunSampleSizeNear", 0.705);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  thread func_CDA4("mp_neontest_1");
  thread fix_collision();
  level.callbackplayerkilled = ::callback_vr_playerkilled;
  level thread handleholograms();
  level thread handlelightinggeo();
  level thread runholodome();
  level thread sfx_club_music();
  level thread spawn_ball_allowed_trigger();
  level thread spawn_oob_trigger();
  level thread spawn_no_zone_trigger();
}

fix_collision() {
  var_00 = getent("player128x128x256", "targetname");
  var_01 = spawn("script_model", (-2504, 842, 676));
  var_01.angles = (0, 0, 0);
  var_01 clonebrushmodeltoscriptmodel(var_00);
  var_02 = getent("player128x128x256", "targetname");
  var_03 = spawn("script_model", (-2504, 842, 420));
  var_03.angles = (0, 0, 0);
  var_03 clonebrushmodeltoscriptmodel(var_02);
  var_04 = getent("player256x256x256", "targetname");
  var_05 = spawn("script_model", (-892, 1380, 464));
  var_05.angles = (0, 0, 0);
  var_05 clonebrushmodeltoscriptmodel(var_04);
  var_06 = getent("player64x64x128", "targetname");
  var_07 = spawn("script_model", (-599, 339, 139.5));
  var_07.angles = (0, 0, -9.5);
  var_07 clonebrushmodeltoscriptmodel(var_06);
  var_08 = getent("player64x64x256", "targetname");
  var_09 = spawn("script_model", (-1440, -1424, -92));
  var_09.angles = (0, 0, 0);
  var_09 clonebrushmodeltoscriptmodel(var_08);
  var_0A = getent("player64x64x256", "targetname");
  var_0B = spawn("script_model", (-1440, -1424, -348));
  var_0B.angles = (0, 0, 0);
  var_0B clonebrushmodeltoscriptmodel(var_0A);
  var_0C = getent("player256x256x8", "targetname");
  var_0D = spawn("script_model", (-1484, -256, -26));
  var_0D.angles = (0, 0, 0);
  var_0D clonebrushmodeltoscriptmodel(var_0C);
  var_0E = getent("player64x64x256", "targetname");
  var_0F = spawn("script_model", (-1580, -128, -50));
  var_0F.angles = (90, 1.7, -88);
  var_0F clonebrushmodeltoscriptmodel(var_0E);
  var_10 = getent("player32x32x128", "targetname");
  var_11 = spawn("script_model", (-1238, 2298, 37));
  var_11.angles = (0, 0, 0);
  var_11 clonebrushmodeltoscriptmodel(var_10);
  var_12 = getent("player64x64x256", "targetname");
  var_13 = spawn("script_model", (1264, 1696, -224));
  var_13.angles = (0, 0, 0);
  var_13 clonebrushmodeltoscriptmodel(var_12);
}

callback_vr_playerkilled(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  if(param_04 != "MOD_TRIGGER_HURT") {
    self.nocorpse = 1;
  }

  thread vrdeatheffects();
  scripts\mp\damage::playerkilled_internal(param_00, param_01, self, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, 0);
}

vrdeatheffects() {
  var_00 = ["j_head", "j_chest", "j_shoulder_ri", "j_shoulder_le", "j_elbow_ri", "j_elbow_le", "j_hip_ri", "j_hip_le", "j_knee_ri", "j_knee_le"];
  var_01 = var_00.size;
  thread playbodyfx(0);
}

playbodyfx(param_00) {
  var_01[0][1]["org"] = self gettagorigin("j_spinelower");
  var_01[0][1]["angles"] = self gettagangles("j_spinelower");
  var_01[0][1]["effect"] = "vfx_vr_death_player_vol_chest";
  var_01[0][2]["org"] = self gettagorigin("j_head");
  var_01[0][2]["angles"] = self gettagangles("j_head");
  var_01[0][2]["effect"] = "vfx_vr_enemy_death";
  var_01[1][0]["org"] = self gettagorigin("j_knee_ri");
  var_01[1][0]["angles"] = self gettagangles("j_knee_ri");
  var_01[1][0]["effect"] = "vfx_vr_death_player_volume";
  var_01[1][1]["org"] = self gettagorigin("j_knee_le");
  var_01[1][1]["angles"] = self gettagangles("j_knee_le");
  var_01[1][1]["effect"] = "vfx_vr_death_player_volume";
  var_01[1][2]["org"] = self gettagorigin("j_elbow_ri");
  var_01[1][2]["angles"] = self gettagangles("j_elbow_ri");
  var_01[1][2]["effect"] = "vfx_vr_enemy_death";
  var_01[1][3]["org"] = self gettagorigin("j_elbow_le");
  var_01[1][3]["angles"] = self gettagangles("j_elbow_le");
  var_01[1][3]["effect"] = "vfx_vr_enemy_death";
  foreach(var_03 in var_01) {
    foreach(var_05 in var_03) {
      playFX(scripts\engine\utility::getfx(var_05["effect"]), var_05["org"]);
    }

    wait(0.01);
  }
}

runholodome() {
  level endon("game_ended");
  for(;;) {
    level waittill("connected", var_00);
    var_00 thread executeholodome();
  }
}

executeholodome() {
  self waittill("mapCamera_start");
  wait(2.5);
  scripts\engine\utility::exploder(10, self);
}

handleholograms() {
  wait(5);
  var_00 = getscriptablearray("hologram_object", "targetname");
  foreach(var_02 in var_00) {
    var_02 thread runholograminitialization();
  }
}

runholograminitialization() {
  level endon("game_ended");
  var_00 = spawn("trigger_radius", self.origin - (0, 0, 512), 0, 800, 1300);
  if(self.script_noteworthy == "car") {
    self setscriptablepartstate("rootModelManager", "map_start");
    var_01 = "rootModelManager";
    var_02 = "regen";
  } else {
    var_01 = "tree";
    var_02 = "build";
  }

  var_00 waittill("trigger");
  self setscriptablepartstate(var_01, var_02);
}

func_CDA4(param_00) {
  wait(30);
  playcinematicforalllooping(param_00);
}

handlelightinggeo() {
  wait(5);
  var_00 = getEntArray("big_screen", "targetname");
  foreach(var_02 in var_00) {
    if(isDefined(var_02.script_parameters)) {
      var_02 moveto((-2444, 1279.5, 95), 0.1);
    }
  }
}

sfx_club_music() {
  var_00 = spawn("script_origin", (1200, 703, 238));
  scripts\engine\utility::waitframe();
  var_00 playLoopSound("emt_mus_neon_club");
}

spawn_ball_allowed_trigger() {
  if(level.gametype == "ball") {
    wait(1);
    var_00 = spawn("trigger_radius", (-970, 750, 750), 0, 4000, 500);
    var_01 = spawn("trigger_radius", (-720, -400, 470), 0, 230, 400);
    var_02 = spawn("trigger_radius", (-2090, 1100, 350), 0, 450, 400);
    var_00 hide();
    var_01 hide();
    var_02 hide();
    level.ballallowedtriggers = getEntArray("uplinkAllowedOOB", "targetname");
    level.ballallowedtriggers[level.ballallowedtriggers.size] = var_00;
    level.ballallowedtriggers[level.ballallowedtriggers.size] = var_01;
    level.ballallowedtriggers[level.ballallowedtriggers.size] = var_02;
  }
}

spawn_oob_trigger() {
  if(level.gametype == "ball") {
    wait(1);
    var_00 = spawn("trigger_radius", (150, -28, 560), 0, 430, 300);
    var_01 = spawn("trigger_radius", (1000, -28, 560), 0, 530, 300);
    var_02 = spawn("trigger_radius", (150, 1090, 560), 0, 430, 300);
    var_03 = spawn("trigger_radius", (680, 1925, 560), 0, 330, 300);
    var_00 hide();
    var_01 hide();
    var_02 hide();
    var_03 hide();
    level.var_C7B3[level.var_C7B3.size] = var_00;
    level.var_C7B3[level.var_C7B3.size] = var_01;
    level.var_C7B3[level.var_C7B3.size] = var_02;
    level.var_C7B3[level.var_C7B3.size] = var_03;
  }
}

spawn_no_zone_trigger() {
  if(level.gametype == "ball") {
    wait(1);
    var_00 = spawn("trigger_radius", (-2186, -119, 780), 0, 350, 50);
    var_00.var_336 = "uplink_nozone";
    var_00 hide();
    var_01 = spawn("trigger_radius", (-2050, 790, 780), 0, 380, 50);
    var_01.var_336 = "uplink_nozone";
    var_01 hide();
    var_02 = spawn("trigger_radius", (-2772, 320, 780), 0, 560, 50);
    var_02.var_336 = "uplink_nozone";
    var_02 hide();
    level.nozonetriggers[level.nozonetriggers.size] = var_00;
    level.nozonetriggers[level.nozonetriggers.size] = var_01;
    level.nozonetriggers[level.nozonetriggers.size] = var_02;
  }
}