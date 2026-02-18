/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\art.gsc
***********************************************/

#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace art;

function private autoexec __init__system__() {
  system::register(#"art", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(!isDefined(level.dofdefault)) {
    level.dofdefault[# "nearstart"] = 0;
    level.dofdefault[# "nearend"] = 1;
    level.dofdefault[# "farstart"] = 8000;
    level.dofdefault[# "farend"] = 10000;
    level.dofdefault[# "nearblur"] = 6;
    level.dofdefault[# "farblur"] = 0;
  }

  level.curdof = (level.dofdefault[# "farstart"] - level.dofdefault[# "nearend"]) / 2;

  thread tweakart();

  if(!isDefined(level.script)) {
    level.script = util::get_map_name();
  }
}

function artfxprintln(file, string) {
  if(file == -1) {
    return;
  }

  fprintln(file, string);
}

function strtok_loc(string, par1) {
  stringlist = [];
  indexstring = "";

  for(i = 0; i < par1.size; i++) {
    if(par1[i] == " ") {
      stringlist[stringlist.size] = indexstring;
      indexstring = "";
      continue;
    }

    indexstring += par1[i];
  }

  if(indexstring.size) {
    stringlist[stringlist.size] = indexstring;
  }

  return stringlist;
}

function setfogsliders() {
  fogall = strtok_loc(getdvarstring(#"g_fogcolorreadonly"), " ");
  red = fogall[0];
  green = fogall[1];
  blue = fogall[2];
  halfplane = getdvarstring(#"g_foghalfdistreadonly");
  nearplane = getdvarstring(#"g_fogstartdistreadonly");

  if(!isDefined(red) || !isDefined(green) || !isDefined(blue) || !isDefined(halfplane)) {
    red = 1;
    green = 1;
    blue = 1;
    halfplane = 10000001;
    nearplane = 10000000;
  }

  setDvar(#"scr_fog_exp_halfplane", halfplane);
  setDvar(#"scr_fog_nearplane", nearplane);
  setDvar(#"scr_fog_color", red + " " + green + " " + blue);
}

function tweakart() {
  if(!isDefined(level.tweakfile)) {
    level.tweakfile = 0;
  }

  if(getdvarstring(#"scr_fog_baseheight") == "<dev string:x38>") {
    setDvar(#"scr_fog_exp_halfplane", 500);
    setDvar(#"scr_fog_exp_halfheight", 500);
    setDvar(#"scr_fog_nearplane", 0);
    setDvar(#"scr_fog_baseheight", 0);
  }

  setDvar(#"scr_fog_fraction", 1);
  setDvar(#"scr_art_dump", 0);
  setDvar(#"scr_art_sun_fog_dir_set", 0);
  setDvar(#"scr_dof_nearstart", level.dofdefault[# "nearstart"]);
  setDvar(#"scr_dof_nearend", level.dofdefault[# "nearend"]);
  setDvar(#"scr_dof_farstart", level.dofdefault[# "farstart"]);
  setDvar(#"scr_dof_farend", level.dofdefault[# "farend"]);
  setDvar(#"scr_dof_nearblur", level.dofdefault[# "nearblur"]);
  setDvar(#"scr_dof_farblur", level.dofdefault[# "farblur"]);
  file = undefined;
  filename = undefined;
  tweak_toggle = 1;

  for(;;) {
    while(getdvarint(#"scr_art_tweak", 0) == 0) {
      tweak_toggle = 1;
      waitframe(1);
    }

    if(tweak_toggle) {
      tweak_toggle = 0;
      fogsettings = getfogsettings();
      setDvar(#"scr_fog_nearplane", fogsettings[0]);
      setDvar(#"scr_fog_exp_halfplane", fogsettings[1]);
      setDvar(#"scr_fog_exp_halfheight", fogsettings[3]);
      setDvar(#"scr_fog_baseheight", fogsettings[2]);
      setDvar(#"scr_fog_color", fogsettings[4] + "<dev string:x3c>" + fogsettings[5] + "<dev string:x3c>" + fogsettings[6]);
      setDvar(#"scr_fog_color_scale", fogsettings[7]);
      setDvar(#"scr_sun_fog_color", fogsettings[8] + "<dev string:x3c>" + fogsettings[9] + "<dev string:x3c>" + fogsettings[10]);
      level.fogsundir = [];
      level.fogsundir[0] = fogsettings[11];
      level.fogsundir[1] = fogsettings[12];
      level.fogsundir[2] = fogsettings[13];
      setDvar(#"scr_sun_fog_start_angle", fogsettings[14]);
      setDvar(#"scr_sun_fog_end_angle", fogsettings[15]);
      setDvar(#"scr_fog_max_opacity", fogsettings[16]);
    }

    level.fogexphalfplane = getdvarfloat(#"scr_fog_exp_halfplane", 0);
    level.fogexphalfheight = getdvarfloat(#"scr_fog_exp_halfheight", 0);
    level.fognearplane = getdvarfloat(#"scr_fog_nearplane", 0);
    level.fogbaseheight = getdvarfloat(#"scr_fog_baseheight", 0);
    colors = strtok(getdvarstring(#"scr_fog_color"), "<dev string:x3c>");
    level.fogcolorred = int(colors[0]);
    level.fogcolorgreen = int(colors[1]);
    level.fogcolorblue = int(colors[2]);
    level.fogcolorscale = getdvarfloat(#"scr_fog_color_scale", 0);
    colors = strtok(getdvarstring(#"scr_sun_fog_color"), "<dev string:x3c>");
    level.sunfogcolorred = int(colors[0]);
    level.sunfogcolorgreen = int(colors[1]);
    level.sunfogcolorblue = int(colors[2]);
    level.sunstartangle = getdvarfloat(#"scr_sun_fog_start_angle", 0);
    level.sunendangle = getdvarfloat(#"scr_sun_fog_end_angle", 0);
    level.fogmaxopacity = getdvarfloat(#"scr_fog_max_opacity", 0);

    if(getdvarint(#"scr_art_sun_fog_dir_set", 0)) {
      setDvar(#"scr_art_sun_fog_dir_set", 0);
      println("<dev string:x41>");
      players = getplayers();
      dir = vectornormalize(anglesToForward(players[0] getplayerangles()));
      level.fogsundir = [];
      level.fogsundir[0] = dir[0];
      level.fogsundir[1] = dir[1];
      level.fogsundir[2] = dir[2];
    }

    fovslidercheck();
    dumpsettings();

    if(!getdvarint(#"scr_fog_disable", 0)) {
      if(!isDefined(level.fogsundir)) {
        level.fogsundir = [];
        level.fogsundir[0] = 1;
        level.fogsundir[1] = 0;
        level.fogsundir[2] = 0;
      }

      setvolfog(level.fognearplane, level.fogexphalfplane, level.fogexphalfheight, level.fogbaseheight, level.fogcolorred, level.fogcolorgreen, level.fogcolorblue, level.fogcolorscale, level.sunfogcolorred, level.sunfogcolorgreen, level.sunfogcolorblue, level.fogsundir[0], level.fogsundir[1], level.fogsundir[2], level.sunstartangle, level.sunendangle, 0, level.fogmaxopacity);
    } else {
      setexpfog(100000000, 100000001, 0, 0, 0, 0);
    }

    wait 0.1;
  }
}

function fovslidercheck() {
  if(level.dofdefault[# "nearstart"] >= level.dofdefault[# "nearend"]) {
    level.dofdefault[# "nearstart"] = level.dofdefault[# "nearend"] - 1;
    setDvar(#"scr_dof_nearstart", level.dofdefault[# "nearstart"]);
  }

  if(level.dofdefault[# "nearend"] <= level.dofdefault[# "nearstart"]) {
    level.dofdefault[# "nearend"] = level.dofdefault[# "nearstart"] + 1;
    setDvar(#"scr_dof_nearend", level.dofdefault[# "nearend"]);
  }

  if(level.dofdefault[# "farstart"] >= level.dofdefault[# "farend"]) {
    level.dofdefault[# "farstart"] = level.dofdefault[# "farend"] - 1;
    setDvar(#"scr_dof_farstart", level.dofdefault[# "farstart"]);
  }

  if(level.dofdefault[# "farend"] <= level.dofdefault[# "farstart"]) {
    level.dofdefault[# "farend"] = level.dofdefault[# "farstart"] + 1;
    setDvar(#"scr_dof_farend", level.dofdefault[# "farend"]);
  }

  if(level.dofdefault[# "farblur"] >= level.dofdefault[# "nearblur"]) {
    level.dofdefault[# "farblur"] = level.dofdefault[# "nearblur"] - 0.1;
    setDvar(#"scr_dof_farblur", level.dofdefault[# "farblur"]);
  }

  if(level.dofdefault[# "farstart"] <= level.dofdefault[# "nearend"]) {
    level.dofdefault[# "farstart"] = level.dofdefault[# "nearend"] + 1;
    setDvar(#"scr_dof_farstart", level.dofdefault[# "farstart"]);
  }
}

function dumpsettings() {
  if(getDvar(#"scr_art_dump", 0)) {
    println("<dev string:x72>" + level.fognearplane + "<dev string:x84>");
    println("<dev string:x89>" + level.fogexphalfplane + "<dev string:x84>");
    println("<dev string:x9a>" + level.fogexphalfheight + "<dev string:x84>");
    println("<dev string:xad>" + level.fogbaseheight + "<dev string:x84>");
    println("<dev string:xc0>" + level.fogcolorred + "<dev string:x84>");
    println("<dev string:xcd>" + level.fogcolorgreen + "<dev string:x84>");
    println("<dev string:xda>" + level.fogcolorblue + "<dev string:x84>");
    println("<dev string:xe7>" + level.fogcolorscale + "<dev string:x84>");
    println("<dev string:xf8>" + level.sunfogcolorred + "<dev string:x84>");
    println("<dev string:x109>" + level.sunfogcolorgreen + "<dev string:x84>");
    println("<dev string:x11a>" + level.sunfogcolorblue + "<dev string:x84>");
    println("<dev string:x12b>" + level.fogsundir[0] + "<dev string:x84>");
    println("<dev string:x13c>" + level.fogsundir[1] + "<dev string:x84>");
    println("<dev string:x14d>" + level.fogsundir[2] + "<dev string:x84>");
    println("<dev string:x15e>" + level.sunstartangle + "<dev string:x84>");
    println("<dev string:x173>" + level.sunendangle + "<dev string:x84>");
    println("<dev string:x187>");
    println("<dev string:x195>" + level.fogmaxopacity + "<dev string:x84>");
    println("<dev string:x38>");
    println("<dev string:x1ac>");
    println("<dev string:x20b>");
    println("<dev string:x262>");
    setDvar(#"scr_art_dump", 0);
  }
}