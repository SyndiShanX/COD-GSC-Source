/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_art.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;

main() {
  if(getdvar(#"scr_art_tweak") == "" || getdvar(#"scr_art_tweak") == "0")
    setdvar("scr_art_tweak", 0);

  if(getdvar(#"scr_dof_enable") == "")
    setdvar("scr_dof_enable", "1");

  if(getdvar(#"scr_cinematic_autofocus") == "")
    setdvar("scr_cinematic_autofocus", "1");

  if(getdvar(#"scr_art_visionfile") == "")
    setdvar("scr_art_visionfile", level.script);

  if(!isDefined(level.dofdefault)) {
    level.dofdefault["nearStart"] = 0;
    level.dofdefault["nearEnd"] = 1;
    level.dofdefault["farStart"] = 8000;
    level.dofdefault["farEnd"] = 10000;
    level.dofdefault["nearBlur"] = 6;
    level.dofdefault["farBlur"] = 0;
  }

  level.curdof = (level.dofdefault["farStart"] - level.dofdefault["nearEnd"]) / 2;

  thread tweakart();

  if(!isDefined(level.script))
    level.script = tolower(getdvar(#"mapname"));
}

artfxprintln(file, string) {
  if(file == -1) {
    return;
  }
  fprintln(file, string);
}

setfogsliders() {
  fogall = strtok(getdvar(#"g_fogColorReadOnly"), " ");
  red = fogall[0];
  green = fogall[1];
  blue = fogall[2];
  halfplane = getdvar(#"g_fogHalfDistReadOnly");
  nearplane = getdvar(#"g_fogStartDistReadOnly");

  if(!isDefined(red) || !isDefined(green) || !isDefined(blue) || !isDefined(halfplane)) {
    red = 1;
    green = 1;
    blue = 1;
    halfplane = 10000001;
    nearplane = 10000000;
  }

  setdvar("scr_fog_exp_halfplane", halfplane);
  setdvar("scr_fog_nearplane", nearplane);
  setdvar("scr_fog_color", red + " " + green + " " + blue);
}

tweakart() {
  if(!isDefined(level.tweakfile))
    level.tweakfile = 0;

  if(level.tweakfile && level.bscriptgened)
    script_gen_dump_addline("maps\\createart\\" + level.script + "_art::main();", level.script + "_art");

  if(getdvar(#"scr_fog_baseheight") == "") {
    setdvar("scr_fog_exp_halfplane", "500");
    setdvar("scr_fog_exp_halfheight", "500");
    setdvar("scr_fog_nearplane", "0");
    setdvar("scr_fog_baseheight", "0");
  }

  setdvar("scr_fog_fraction", "1.0");
  setdvar("scr_art_dump", "0");
  setdvar("scr_art_sun_fog_dir_set", "0");
  setdvar("scr_dof_nearStart", level.dofdefault["nearStart"]);
  setdvar("scr_dof_nearEnd", level.dofdefault["nearEnd"]);
  setdvar("scr_dof_farStart", level.dofdefault["farStart"]);
  setdvar("scr_dof_farEnd", level.dofdefault["farEnd"]);
  setdvar("scr_dof_nearBlur", level.dofdefault["nearBlur"]);
  setdvar("scr_dof_farBlur", level.dofdefault["farBlur"]);
  dofvarupdate();
  wait_for_first_player();
  players = get_players();
  tweak_toggle = 1;

  for(;;) {
    while(getdvarint(#"scr_art_tweak") == 0) {
      tweak_toggle = 1;
      wait 0.05;
    }

    if(tweak_toggle) {
      tweak_toggle = 0;
      fogsettings = getfogsettings();
      setdvar("scr_fog_nearplane", fogsettings[0]);
      setdvar("scr_fog_exp_halfplane", fogsettings[1]);
      setdvar("scr_fog_exp_halfheight", fogsettings[3]);
      setdvar("scr_fog_baseheight", fogsettings[2]);
      setdvar("scr_fog_color", fogsettings[4] + " " + fogsettings[5] + " " + fogsettings[6]);
      setdvar("scr_fog_color_scale", fogsettings[7]);
      setdvar("scr_sun_fog_color", fogsettings[8] + " " + fogsettings[9] + " " + fogsettings[10]);
      level.fogsundir = [];
      level.fogsundir[0] = fogsettings[11];
      level.fogsundir[1] = fogsettings[12];
      level.fogsundir[2] = fogsettings[13];
      setdvar("scr_sun_fog_start_angle", fogsettings[14]);
      setdvar("scr_sun_fog_end_angle", fogsettings[15]);
      setdvar("scr_fog_max_opacity", fogsettings[16]);
    }

    level.fogexphalfplane = getdvarfloat(#"scr_fog_exp_halfplane");
    level.fogexphalfheight = getdvarfloat(#"scr_fog_exp_halfheight");
    level.fognearplane = getdvarfloat(#"scr_fog_nearplane");
    level.fogbaseheight = getdvarfloat(#"scr_fog_baseheight");
    level.fogcolorred = getdvarcolorred(#"scr_fog_color");
    level.fogcolorgreen = getdvarcolorgreen(#"scr_fog_color");
    level.fogcolorblue = getdvarcolorblue(#"scr_fog_color");
    level.fogcolorscale = getdvarfloat(#"scr_fog_color_scale");
    level.sunfogcolorred = getdvarcolorred(#"scr_sun_fog_color");
    level.sunfogcolorgreen = getdvarcolorgreen(#"scr_sun_fog_color");
    level.sunfogcolorblue = getdvarcolorblue(#"scr_sun_fog_color");
    level.sunstartangle = getdvarfloat(#"scr_sun_fog_start_angle");
    level.sunendangle = getdvarfloat(#"scr_sun_fog_end_angle");
    level.fogmaxopacity = getdvarfloat(#"scr_fog_max_opacity");

    if(getdvarint(#"scr_art_sun_fog_dir_set")) {
      setdvar("scr_art_sun_fog_dir_set", "0");
      println("Setting sun fog direction to facing of player");
      players = get_players();
      dir = vectornormalize(anglestoforward(players[0] getplayerangles()));
      level.fogsundir = [];
      level.fogsundir[0] = dir[0];
      level.fogsundir[1] = dir[1];
      level.fogsundir[2] = dir[2];
    }

    dofvarupdate();
    fovslidercheck();
    dumpsettings();

    if(!getdvarint(#"_id_DBBD8F3B")) {
      if(!isDefined(level.fogsundir)) {
        level.fogsundir = [];
        level.fogsundir[0] = 1;
        level.fogsundir[1] = 0;
        level.fogsundir[2] = 0;
      }

      setvolfog(level.fognearplane, level.fogexphalfplane, level.fogexphalfheight, level.fogbaseheight, level.fogcolorred, level.fogcolorgreen, level.fogcolorblue, level.fogcolorscale, level.sunfogcolorred, level.sunfogcolorgreen, level.sunfogcolorblue, level.fogsundir[0], level.fogsundir[1], level.fogsundir[2], level.sunstartangle, level.sunendangle, 0, level.fogmaxopacity);
    } else
      setexpfog(100000000, 100000001, 0, 0, 0, 0);

    players[0] setdefaultdepthoffield();
    wait 0.1;
  }

}

fovslidercheck() {
  if(level.dofdefault["nearStart"] >= level.dofdefault["nearEnd"]) {
    level.dofdefault["nearStart"] = level.dofdefault["nearEnd"] - 1;
    setdvar("scr_dof_nearStart", level.dofdefault["nearStart"]);
  }

  if(level.dofdefault["nearEnd"] <= level.dofdefault["nearStart"]) {
    level.dofdefault["nearEnd"] = level.dofdefault["nearStart"] + 1;
    setdvar("scr_dof_nearEnd", level.dofdefault["nearEnd"]);
  }

  if(level.dofdefault["farStart"] >= level.dofdefault["farEnd"]) {
    level.dofdefault["farStart"] = level.dofdefault["farEnd"] - 1;
    setdvar("scr_dof_farStart", level.dofdefault["farStart"]);
  }

  if(level.dofdefault["farEnd"] <= level.dofdefault["farStart"]) {
    level.dofdefault["farEnd"] = level.dofdefault["farStart"] + 1;
    setdvar("scr_dof_farEnd", level.dofdefault["farEnd"]);
  }

  if(level.dofdefault["farBlur"] >= level.dofdefault["nearBlur"]) {
    level.dofdefault["farBlur"] = level.dofdefault["nearBlur"] - 0.1;
    setdvar("scr_dof_farBlur", level.dofdefault["farBlur"]);
  }

  if(level.dofdefault["farStart"] <= level.dofdefault["nearEnd"]) {
    level.dofdefault["farStart"] = level.dofdefault["nearEnd"] + 1;
    setdvar("scr_dof_farStart", level.dofdefault["farStart"]);
  }
}

dumpsettings() {
  if(getdvar(#"scr_art_dump") != "0") {
    println("\\tstart_dist = " + level.fognearplane + ";");
    println("\\thalf_dist = " + level.fogexphalfplane + ";");
    println("\\thalf_height = " + level.fogexphalfheight + ";");
    println("\\tbase_height = " + level.fogbaseheight + ";");
    println("\\tfog_r = " + level.fogcolorred + ";");
    println("\\tfog_g = " + level.fogcolorgreen + ";");
    println("\\tfog_b = " + level.fogcolorblue + ";");
    println("\\tfog_scale = " + level.fogcolorscale + ";");
    println("\\tsun_col_r = " + level.sunfogcolorred + ";");
    println("\\tsun_col_g = " + level.sunfogcolorgreen + ";");
    println("\\tsun_col_b = " + level.sunfogcolorblue + ";");
    println("\\tsun_dir_x = " + level.fogsundir[0] + ";");
    println("\\tsun_dir_y = " + level.fogsundir[1] + ";");
    println("\\tsun_dir_z = " + level.fogsundir[2] + ";");
    println("\\tsun_start_ang = " + level.sunstartangle + ";");
    println("\\tsun_stop_ang = " + level.sunendangle + ";");
    println("\\ttime = 0;");
    println("\\tmax_fog_opacity = " + level.fogmaxopacity + ";");
    println("");
    println("\\tsetVolFog(start_dist, half_dist, half_height, base_height, fog_r, fog_g, fog_b, fog_scale,");
    println("\\t\\tsun_col_r, sun_col_g, sun_col_b, sun_dir_x, sun_dir_y, sun_dir_z, sun_start_ang, ");
    println("\\t\\tsun_stop_ang, time, max_fog_opacity);");
    setdvar("scr_art_dump", "0");
  }

}

dofvarupdate() {
  level.dofdefault["nearStart"] = getdvarint(#"scr_dof_nearStart");
  level.dofdefault["nearEnd"] = getdvarint(#"scr_dof_nearEnd");
  level.dofdefault["farStart"] = getdvarint(#"scr_dof_farStart");
  level.dofdefault["farEnd"] = getdvarint(#"scr_dof_farEnd");
  level.dofdefault["nearBlur"] = getdvarfloat(#"scr_dof_nearBlur");
  level.dofdefault["farBlur"] = getdvarfloat(#"scr_dof_farBlur");
}

setdefaultdepthoffield() {
  if(isDefined(level.do_not_use_dof)) {
    return;
  }
  self setdepthoffield(level.dofdefault["nearStart"], level.dofdefault["nearEnd"], level.dofdefault["farStart"], level.dofdefault["farEnd"], level.dofdefault["nearBlur"], level.dofdefault["farBlur"]);
}