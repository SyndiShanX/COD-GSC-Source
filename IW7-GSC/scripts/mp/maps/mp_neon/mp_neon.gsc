/***********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_neon\mp_neon.gsc
***********************************************/

main() {
  scripts\mp\maps\mp_neon\mp_neon_precache::main();
  scripts\mp\maps\mp_neon\gen\mp_neon_art::main();
  scripts\mp\maps\mp_neon\mp_neon_fx::main();
  scripts\mp\load::main();
  scripts\mp\compass::setupminimap("compass_map_mp_neon");
  level.var_C7B3 = getEntArray("OutOfBounds", "targetname");
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.33);
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("sm_sunSampleSizeNear", 0.705);
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
  var_0 = getent("player128x128x256", "targetname");
  var_1 = spawn("script_model", (-2504, 842, 676));
  var_1.angles = (0, 0, 0);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getent("player128x128x256", "targetname");
  var_3 = spawn("script_model", (-2504, 842, 420));
  var_3.angles = (0, 0, 0);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = getent("player256x256x256", "targetname");
  var_5 = spawn("script_model", (-892, 1380, 464));
  var_5.angles = (0, 0, 0);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_6 = getent("player64x64x128", "targetname");
  var_7 = spawn("script_model", (-599, 339, 139.5));
  var_7.angles = (0, 0, -9.5);
  var_7 clonebrushmodeltoscriptmodel(var_6);
  var_8 = getent("player64x64x256", "targetname");
  var_9 = spawn("script_model", (-1440, -1424, -92));
  var_9.angles = (0, 0, 0);
  var_9 clonebrushmodeltoscriptmodel(var_8);
  var_10 = getent("player64x64x256", "targetname");
  var_11 = spawn("script_model", (-1440, -1424, -348));
  var_11.angles = (0, 0, 0);
  var_11 clonebrushmodeltoscriptmodel(var_10);
  var_12 = getent("player256x256x8", "targetname");
  var_13 = spawn("script_model", (-1484, -256, -26));
  var_13.angles = (0, 0, 0);
  var_13 clonebrushmodeltoscriptmodel(var_12);
  var_14 = getent("player64x64x256", "targetname");
  var_15 = spawn("script_model", (-1580, -128, -50));
  var_15.angles = (90, 1.7, -88);
  var_15 clonebrushmodeltoscriptmodel(var_14);
  var_10 = getent("player32x32x128", "targetname");
  var_11 = spawn("script_model", (-1238, 2298, 37));
  var_11.angles = (0, 0, 0);
  var_11 clonebrushmodeltoscriptmodel(var_10);
  var_12 = getent("player64x64x256", "targetname");
  var_13 = spawn("script_model", (1264, 1696, -224));
  var_13.angles = (0, 0, 0);
  var_13 clonebrushmodeltoscriptmodel(var_12);
}

callback_vr_playerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(var_4 != "MOD_TRIGGER_HURT") {
    self.nocorpse = 1;
  }

  thread vrdeatheffects();
  scripts\mp\damage::playerkilled_internal(var_0, var_1, self, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0);
}

vrdeatheffects() {
  var_0 = ["j_head", "j_chest", "j_shoulder_ri", "j_shoulder_le", "j_elbow_ri", "j_elbow_le", "j_hip_ri", "j_hip_le", "j_knee_ri", "j_knee_le"];
  var_1 = var_0.size;
  thread playbodyfx(0);
}

playbodyfx(var_0) {
  var_1[0][1]["org"] = self gettagorigin("j_spinelower");
  var_1[0][1]["angles"] = self gettagangles("j_spinelower");
  var_1[0][1]["effect"] = "vfx_vr_death_player_vol_chest";
  var_1[0][2]["org"] = self gettagorigin("j_head");
  var_1[0][2]["angles"] = self gettagangles("j_head");
  var_1[0][2]["effect"] = "vfx_vr_enemy_death";
  var_1[1][0]["org"] = self gettagorigin("j_knee_ri");
  var_1[1][0]["angles"] = self gettagangles("j_knee_ri");
  var_1[1][0]["effect"] = "vfx_vr_death_player_volume";
  var_1[1][1]["org"] = self gettagorigin("j_knee_le");
  var_1[1][1]["angles"] = self gettagangles("j_knee_le");
  var_1[1][1]["effect"] = "vfx_vr_death_player_volume";
  var_1[1][2]["org"] = self gettagorigin("j_elbow_ri");
  var_1[1][2]["angles"] = self gettagangles("j_elbow_ri");
  var_1[1][2]["effect"] = "vfx_vr_enemy_death";
  var_1[1][3]["org"] = self gettagorigin("j_elbow_le");
  var_1[1][3]["angles"] = self gettagangles("j_elbow_le");
  var_1[1][3]["effect"] = "vfx_vr_enemy_death";
  foreach(var_3 in var_1) {
    foreach(var_5 in var_3) {
      playFX(scripts\engine\utility::getfx(var_5["effect"]), var_5["org"]);
    }

    wait(0.01);
  }
}

runholodome() {
  level endon("game_ended");
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread executeholodome();
  }
}

executeholodome() {
  self waittill("mapCamera_start");
  wait(2.5);
  scripts\engine\utility::exploder(10, self);
}

handleholograms() {
  wait(5);
  var_0 = getscriptablearray("hologram_object", "targetname");
  foreach(var_2 in var_0) {
    var_2 thread runholograminitialization();
  }
}

runholograminitialization() {
  level endon("game_ended");
  var_0 = spawn("trigger_radius", self.origin - (0, 0, 512), 0, 800, 1300);
  if(self.script_noteworthy == "car") {
    self setscriptablepartstate("rootModelManager", "map_start");
    var_1 = "rootModelManager";
    var_2 = "regen";
  } else {
    var_1 = "tree";
    var_2 = "build";
  }

  var_0 waittill("trigger");
  self setscriptablepartstate(var_1, var_2);
}

func_CDA4(var_0) {
  wait(30);
  playcinematicforalllooping(var_0);
}

handlelightinggeo() {
  wait(5);
  var_0 = getEntArray("big_screen", "targetname");
  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_parameters)) {
      var_2 moveto((-2444, 1279.5, 95), 0.1);
    }
  }
}

sfx_club_music() {
  var_0 = spawn("script_origin", (1200, 703, 238));
  scripts\engine\utility::waitframe();
  var_0 playLoopSound("emt_mus_neon_club");
}

spawn_ball_allowed_trigger() {
  if(level.gametype == "ball") {
    wait(1);
    var_0 = spawn("trigger_radius", (-970, 750, 750), 0, 4000, 500);
    var_1 = spawn("trigger_radius", (-720, -400, 470), 0, 230, 400);
    var_2 = spawn("trigger_radius", (-2090, 1100, 350), 0, 450, 400);
    var_0 hide();
    var_1 hide();
    var_2 hide();
    level.ballallowedtriggers = getEntArray("uplinkAllowedOOB", "targetname");
    level.ballallowedtriggers[level.ballallowedtriggers.size] = var_0;
    level.ballallowedtriggers[level.ballallowedtriggers.size] = var_1;
    level.ballallowedtriggers[level.ballallowedtriggers.size] = var_2;
  }
}

spawn_oob_trigger() {
  if(level.gametype == "ball") {
    wait(1);
    var_0 = spawn("trigger_radius", (150, -28, 560), 0, 430, 300);
    var_1 = spawn("trigger_radius", (1000, -28, 560), 0, 530, 300);
    var_2 = spawn("trigger_radius", (150, 1090, 560), 0, 430, 300);
    var_3 = spawn("trigger_radius", (680, 1925, 560), 0, 330, 300);
    var_0 hide();
    var_1 hide();
    var_2 hide();
    var_3 hide();
    level.var_C7B3[level.var_C7B3.size] = var_0;
    level.var_C7B3[level.var_C7B3.size] = var_1;
    level.var_C7B3[level.var_C7B3.size] = var_2;
    level.var_C7B3[level.var_C7B3.size] = var_3;
  }
}

spawn_no_zone_trigger() {
  if(level.gametype == "ball") {
    wait(1);
    var_0 = spawn("trigger_radius", (-2186, -119, 780), 0, 350, 50);
    var_0.var_336 = "uplink_nozone";
    var_0 hide();
    var_1 = spawn("trigger_radius", (-2050, 790, 780), 0, 380, 50);
    var_1.var_336 = "uplink_nozone";
    var_1 hide();
    var_2 = spawn("trigger_radius", (-2772, 320, 780), 0, 560, 50);
    var_2.var_336 = "uplink_nozone";
    var_2 hide();
    level.nozonetriggers[level.nozonetriggers.size] = var_0;
    level.nozonetriggers[level.nozonetriggers.size] = var_1;
    level.nozonetriggers[level.nozonetriggers.size] = var_2;
  }
}