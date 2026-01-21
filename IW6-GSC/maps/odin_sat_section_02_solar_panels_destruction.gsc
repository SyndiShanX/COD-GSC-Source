/*****************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\odin_sat_section_02_solar_panels_destruction.gsc
*****************************************************************/

vfxinit() {
  level._effect["solar_panel_break"] = loadfx("vfx/gameplay/space/vfx_solar_panel_shatter");
  level._effect["solar_panel_trail"] = loadfx("vfx/gameplay/space/vfx_solar_panel_trail");
  precachemodel("panel_square_frag_1");
  precachemodel("panel_square_frag_2");
  precachemodel("panel_square_frag_3");
  precachemodel("panel_square_frag_4");
}

spawnsolarpanelsinit(var_0) {
  level.frames = [];

  for(var_1 = 1; var_1 <= 4; var_1++) {
    var_2 = "odin_sat_section_02_solar_wing_0" + var_1;
    var_3 = getent(var_2, "script_noteworthy");
    level.frames[var_2] = var_3;
  }

  level.sat_base_s = getent("odin_sat_section_01", "script_noteworthy");

  foreach(var_5 in level.frames) {
    var_5 thread addpaneltimesarray(var_5);
    var_5 thread spawnsolarpanels("panel_square_frag_1", var_0);
    var_5 thread spawnsolarpanels("panel_square_frag_2", var_0);
    var_5 thread spawnsolarpanels("panel_square_frag_3", var_0);
    var_5 thread spawnsolarpanels("panel_square_frag_4", var_0);
  }
}

spawnsolarpanels(var_0, var_1) {
  self.panel_array = [];

  for(var_2 = 0; var_2 <= 27; var_2++) {
    var_3 = "j_" + var_0 + "_" + var_2;
    var_4 = self gettagorigin(var_3);
    var_5 = self gettagangles(var_3);
    var_6 = spawn("script_model", var_4);

    if(var_1)
      var_6 hide();

    var_6 setModel(var_0);
    var_6.my_name = var_3;
    var_6.angles = var_5;
    var_6 linkto(self, var_3);
    wait 0.05;
    self.panel_array = common_scripts\utility::add_to_array(self.panel_array, var_6);
  }
}

unhideallpanels() {
  foreach(var_1 in level.frames) {
    foreach(var_3 in var_1.panel_array)
    var_3 show();
  }
}

destructisolarpanelsinit(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    foreach(var_4 in level.frames[var_0].panel_array)
    level.frames[var_0] thread destructsolarpanels(var_4, level.frames[var_0].panel_time_array[var_4.my_name], 0.1, var_1, var_2);
  }
}

#using_animtree("destructibles");

destructsolarpanels(var_0, var_1, var_2, var_3, var_4) {
  wait(var_1 * 8 + var_2);
  var_0 useanimtree(#animtree);
  var_0 setanim(%odin_sat_solar_panel_wiggle2);
  wait(getanimlength(%odin_sat_solar_panel_wiggle2));

  if(var_4) {}

  var_5 = (randomintrange(360, 720), randomintrange(360, 720), randomintrange(360, 720));
  var_6 = 1;
  var_7 = randomintrange(-1024 * var_6, 1024 * var_6);
  var_8 = randomintrange(-1024 * var_6, -512 * var_6);
  var_9 = randomintrange(512 * var_6, 1024 * var_6);

  if(randomint(2) > 0)
    var_9 = var_9 * -1;

  var_10 = (var_7, var_8, var_9);
  var_11 = (-6257, 50029, -17584);
  var_12 = var_11 - level.sat_base_s.origin;
  var_13 = length(var_12);
  var_12 = vectornormalize(var_12);
  var_14 = 38 + var_3;
  playFXOnTag(level._effect["solar_panel_break"], var_0, "tag_origin");
  var_15 = 8;
  var_0 unlink();
  var_0 rotateby(var_5 * 32, var_14);
  var_0 moveto(var_0.origin + var_12 * (var_13 * var_15) + var_10 * var_15, var_14);
  wait 0.1;

  if(randomint(2) == 0)
    playFXOnTag(level._effect["solar_panel_trail"], var_0, "tag_origin");

  wait 5;
  var_0 delete();
}

addpaneltimesarray(var_0) {
  var_0.panel_time_array = [];
  var_0.panel_time_array["j_panel_square_frag_2_27"] = 0.0588235;
  var_0.panel_time_array["j_panel_square_frag_1_24"] = 0.466667;
  var_0.panel_time_array["j_panel_square_frag_4_18"] = 0.380392;
  var_0.panel_time_array["j_panel_square_frag_1_26"] = 0.0980392;
  var_0.panel_time_array["j_panel_square_frag_1_27"] = 0.0588235;
  var_0.panel_time_array["j_panel_square_frag_4_17"] = 0.701961;
  var_0.panel_time_array["j_panel_square_frag_2_25"] = 0.729412;
  var_0.panel_time_array["j_panel_square_frag_2_26"] = 0.556863;
  var_0.panel_time_array["j_panel_square_frag_4_19"] = 0.0588235;
  var_0.panel_time_array["j_panel_square_frag_3_24"] = 0.376471;
  var_0.panel_time_array["j_panel_square_frag_3_25"] = 0.0588235;
  var_0.panel_time_array["j_panel_square_frag_3_26"] = 0.101961;
  var_0.panel_time_array["j_panel_square_frag_3_27"] = 0.0588235;
  var_0.panel_time_array["j_panel_square_frag_4_16"] = 0.388235;
  var_0.panel_time_array["j_panel_square_frag_1_25"] = 0.0588235;
  var_0.panel_time_array["j_panel_square_frag_2_24"] = 0.443137;
  var_0.panel_time_array["j_panel_square_frag_2_23"] = 0.717647;
  var_0.panel_time_array["j_panel_square_frag_1_20"] = 0.388235;
  var_0.panel_time_array["j_panel_square_frag_4_21"] = 0.501961;
  var_0.panel_time_array["j_panel_square_frag_1_22"] = 0.184314;
  var_0.panel_time_array["j_panel_square_frag_1_23"] = 0.713726;
  var_0.panel_time_array["j_panel_square_frag_4_20"] = 0.588235;
  var_0.panel_time_array["j_panel_square_frag_3_22"] = 0.752941;
  var_0.panel_time_array["j_panel_square_frag_2_22"] = 0.313726;
  var_0.panel_time_array["j_panel_square_frag_4_22"] = 0.670588;
  var_0.panel_time_array["j_panel_square_frag_3_20"] = 0.6;
  var_0.panel_time_array["j_panel_square_frag_3_21"] = 0.662745;
  var_0.panel_time_array["j_panel_square_frag_3_23"] = 0.160784;
  var_0.panel_time_array["j_panel_square_frag_2_20"] = 0.384314;
  var_0.panel_time_array["j_panel_square_frag_1_21"] = 0.501961;
  var_0.panel_time_array["j_panel_square_frag_2_21"] = 0.615686;
  var_0.panel_time_array["j_panel_square_frag_4_23"] = 0.721569;
  var_0.panel_time_array["j_panel_square_frag_2_19"] = 0.45098;
  var_0.panel_time_array["j_panel_square_frag_1_16"] = 0.756863;
  var_0.panel_time_array["j_panel_square_frag_1_17"] = 0.454902;
  var_0.panel_time_array["j_panel_square_frag_1_18"] = 0.505882;
  var_0.panel_time_array["j_panel_square_frag_1_19"] = 0.454902;
  var_0.panel_time_array["j_panel_square_frag_2_16"] = 0.72549;
  var_0.panel_time_array["j_panel_square_frag_2_17"] = 0.627451;
  var_0.panel_time_array["j_panel_square_frag_2_18"] = 0.388235;
  var_0.panel_time_array["j_panel_square_frag_4_26"] = 0.54902;
  var_0.panel_time_array["j_panel_square_frag_3_16"] = 0.627451;
  var_0.panel_time_array["j_panel_square_frag_3_17"] = 0.52549;
  var_0.panel_time_array["j_panel_square_frag_3_18"] = 0.435294;
  var_0.panel_time_array["j_panel_square_frag_3_19"] = 0.341176;
  var_0.panel_time_array["j_panel_square_frag_4_24"] = 0.611765;
  var_0.panel_time_array["j_panel_square_frag_4_25"] = 0.631373;
  var_0.panel_time_array["j_panel_square_frag_4_27"] = 0.419608;
  var_0.panel_time_array["j_panel_square_frag_2_15"] = 0.752941;
  var_0.panel_time_array["j_panel_square_frag_1_12"] = 0.729412;
  var_0.panel_time_array["j_panel_square_frag_4_0"] = 0.764706;
  var_0.panel_time_array["j_panel_square_frag_1_14"] = 0.407843;
  var_0.panel_time_array["j_panel_square_frag_1_15"] = 0.752941;
  var_0.panel_time_array["j_panel_square_frag_3_14"] = 0.458824;
  var_0.panel_time_array["j_panel_square_frag_2_13"] = 0.576471;
  var_0.panel_time_array["j_panel_square_frag_2_14"] = 0.752941;
  var_0.panel_time_array["j_panel_square_frag_4_3"] = 0.756863;
  var_0.panel_time_array["j_panel_square_frag_3_12"] = 0.45098;
  var_0.panel_time_array["j_panel_square_frag_3_13"] = 0.768627;
  var_0.panel_time_array["j_panel_square_frag_3_15"] = 0.396078;
  var_0.panel_time_array["j_panel_square_frag_1_13"] = 0.564706;
  var_0.panel_time_array["j_panel_square_frag_4_1"] = 0.454902;
  var_0.panel_time_array["j_panel_square_frag_4_2"] = 0.819608;
  var_0.panel_time_array["j_panel_square_frag_2_12"] = 0.737255;
  var_0.panel_time_array["j_panel_square_frag_2_11"] = 0.803922;
  var_0.panel_time_array["j_panel_square_frag_1_8"] = 0.792157;
  var_0.panel_time_array["j_panel_square_frag_4_14"] = 0.537255;
  var_0.panel_time_array["j_panel_square_frag_1_10"] = 0.784314;
  var_0.panel_time_array["j_panel_square_frag_1_11"] = 0.847059;
  var_0.panel_time_array["j_panel_square_frag_2_8"] = 0.839216;
  var_0.panel_time_array["j_panel_square_frag_4_12"] = 0.737255;
  var_0.panel_time_array["j_panel_square_frag_2_10"] = 0.576471;
  var_0.panel_time_array["j_panel_square_frag_4_15"] = 0.713726;
  var_0.panel_time_array["j_panel_square_frag_3_8"] = 0.729412;
  var_0.panel_time_array["j_panel_square_frag_3_9"] = 0.843137;
  var_0.panel_time_array["j_panel_square_frag_3_10"] = 0.682353;
  var_0.panel_time_array["j_panel_square_frag_3_11"] = 0.858824;
  var_0.panel_time_array["j_panel_square_frag_4_13"] = 0.666667;
  var_0.panel_time_array["j_panel_square_frag_1_9"] = 0.870588;
  var_0.panel_time_array["j_panel_square_frag_2_9"] = 0.792157;
  var_0.panel_time_array["j_panel_square_frag_2_7"] = 0.8;
  var_0.panel_time_array["j_panel_square_frag_1_4"] = 0.890196;
  var_0.panel_time_array["j_panel_square_frag_1_5"] = 0.843137;
  var_0.panel_time_array["j_panel_square_frag_1_6"] = 0.819608;
  var_0.panel_time_array["j_panel_square_frag_1_7"] = 0.788235;
  var_0.panel_time_array["j_panel_square_frag_2_4"] = 0.878431;
  var_0.panel_time_array["j_panel_square_frag_2_5"] = 0.886275;
  var_0.panel_time_array["j_panel_square_frag_2_6"] = 0.8;
  var_0.panel_time_array["j_panel_square_frag_4_11"] = 0.827451;
  var_0.panel_time_array["j_panel_square_frag_3_4"] = 0.811765;
  var_0.panel_time_array["j_panel_square_frag_3_5"] = 0.811765;
  var_0.panel_time_array["j_panel_square_frag_3_6"] = 0.733333;
  var_0.panel_time_array["j_panel_square_frag_3_7"] = 0.8;
  var_0.panel_time_array["j_panel_square_frag_4_8"] = 0.811765;
  var_0.panel_time_array["j_panel_square_frag_4_10"] = 0.866667;
  var_0.panel_time_array["j_panel_square_frag_4_9"] = 0.745098;
  var_0.panel_time_array["j_panel_square_frag_2_3"] = 0.87451;
  var_0.panel_time_array["j_panel_square_frag_4_6"] = 0.811765;
  var_0.panel_time_array["j_panel_square_frag_1_0"] = 0.839216;
  var_0.panel_time_array["j_panel_square_frag_1_1"] = 0.882353;
  var_0.panel_time_array["j_panel_square_frag_1_2"] = 0.921569;
  var_0.panel_time_array["j_panel_square_frag_1_3"] = 0.87451;
  var_0.panel_time_array["j_panel_square_frag_2_0"] = 0.929412;
  var_0.panel_time_array["j_panel_square_frag_2_1"] = 0.835294;
  var_0.panel_time_array["j_panel_square_frag_2_2"] = 0.87451;
  var_0.panel_time_array["j_panel_square_frag_4_7"] = 0.839216;
  var_0.panel_time_array["j_panel_square_frag_3_0"] = 0.905882;
  var_0.panel_time_array["j_panel_square_frag_3_1"] = 0.921569;
  var_0.panel_time_array["j_panel_square_frag_3_2"] = 0.886275;
  var_0.panel_time_array["j_panel_square_frag_3_3"] = 0.85098;
  var_0.panel_time_array["j_panel_square_frag_4_4"] = 0.909804;
  var_0.panel_time_array["j_panel_square_frag_4_5"] = 0.882353;
}