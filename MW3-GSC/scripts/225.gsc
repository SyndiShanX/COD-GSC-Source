/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\225.gsc
**************************************/

artstartvisionfileexport() {
  common_scripts\utility::fileprint_launcher_start_file();
}

artendvisionfileexport() {
  return common_scripts\utility::fileprint_launcher_end_file("\\share\\raw\\vision\\" + level.script + ".vision", 1);
}

artstartfogfileexport() {
  common_scripts\utility::fileprint_launcher_start_file();
}

artendfogfileexport() {
  return common_scripts\utility::fileprint_launcher_end_file("\\share\\raw\\maps\\createart\\" + level.script + "_art.gsc", 1);
}

artcommonfxprintln(var_0) {
  common_scripts\utility::fileprint_launcher(var_0);
}

setfogsliders() {}

translatefogsliderstoscript() {
  level.fogexphalfplane = getdvarfloat("scr_fog_exp_halfplane");
  level.fognearplane = getdvarfloat("scr_fog_nearplane");
  level.fogcolor = getdvarvector("scr_fog_color");
  level.fogmaxopacity = getdvarfloat("scr_fog_max_opacity");
  level.sunfogenabled = getdvarint("scr_sunFogEnabled");
  level.sunfogcolor = getdvarvector("scr_sunFogColor");
  level.sunfogdir = getdvarvector("scr_sunFogDir");
  level.sunfogbeginfadeangle = getdvarfloat("scr_sunFogBeginFadeAngle");
  level.sunfogendfadeangle = getdvarfloat("scr_sunFogEndFadeAngle");
  level.sunfogscale = getdvarfloat("scr_sunFogScale");
  level.fogexphalfplane = limit(level.fogexphalfplane);
  level.fognearplane = limit(level.fognearplane);
  var_0 = limit(level.fogcolor[0]);
  var_1 = limit(level.fogcolor[1]);
  var_2 = limit(level.fogcolor[2]);
  level.fogcolor = (var_0, var_1, var_2);
  level.fogmaxopacity = limit(level.fogmaxopacity);
  level.sunfogenabled = limit(level.sunfogenabled);
  var_0 = limit(level.sunfogcolor[0]);
  var_1 = limit(level.sunfogcolor[1]);
  var_2 = limit(level.sunfogcolor[2]);
  level.sunfogcolor = (var_0, var_1, var_2);
  var_3 = limit(level.sunfogdir[0]);
  var_4 = limit(level.sunfogdir[1]);
  var_5 = limit(level.sunfogdir[2]);
  level.sunfogdir = (var_3, var_4, var_5);
  level.sunfogbeginfadeangle = limit(level.sunfogbeginfadeangle);
  level.sunfogendfadeangle = limit(level.sunfogendfadeangle);
  level.sunfogscale = limit(level.sunfogscale);
}

limit(var_0) {
  var_1 = 0.001;

  if(var_0 < var_1 && var_0 > var_1 * -1) {
    var_0 = 0;

  }
  return var_0;
}

updatefogfromscript() {
  if(!getdvarint("scr_fog_disable")) {
    if(level.sunfogenabled) {
      setexpfog(level.fognearplane, level.fogexphalfplane, level.fogcolor[0], level.fogcolor[1], level.fogcolor[2], level.fogmaxopacity, 0, level.sunfogcolor[0], level.sunfogcolor[1], level.sunfogcolor[2], level.sunfogdir, level.sunfogbeginfadeangle, level.sunfogendfadeangle, level.sunfogscale);
    } else {
      setexpfog(level.fognearplane, level.fogexphalfplane, level.fogcolor[0], level.fogcolor[1], level.fogcolor[2], level.fogmaxopacity, 0);
    }
  } else {
    setexpfog(1215752192, 1215752193, 0, 0, 0, 0, 0);
  }
}

artfxprintlnfog() {
  common_scripts\utility::fileprint_launcher("");
  common_scripts\utility::fileprint_launcher("\t//************************************** Fog section * ");
  common_scripts\utility::fileprint_launcher("");
  common_scripts\utility::fileprint_launcher("\tsetDevDvar( \"scr_fog_disable\", \"" + getdvarint("scr_fog_disable") + "\"" + " );");
  common_scripts\utility::fileprint_launcher("");

  if(!getdvarint("scr_fog_disable")) {
    if(level.sunfogenabled) {
      common_scripts\utility::fileprint_launcher("\tsetExpFog( " + level.fognearplane + ", " + level.fogexphalfplane + ", " + level.fogcolor[0] + ", " + level.fogcolor[1] + ", " + level.fogcolor[2] + ", " + level.fogmaxopacity + ", 0, " + level.sunfogcolor[0] + ", " + level.sunfogcolor[1] + ", " + level.sunfogcolor[2] + ", (" + level.sunfogdir[0] + ", " + level.sunfogdir[1] + ", " + level.sunfogdir[2] + "), " + level.sunfogbeginfadeangle + ", " + level.sunfogendfadeangle + ", " + level.sunfogscale + " );");
    } else {
      common_scripts\utility::fileprint_launcher("\tsetExpFog( " + level.fognearplane + ", " + level.fogexphalfplane + ", " + level.fogcolor[0] + ", " + level.fogcolor[1] + ", " + level.fogcolor[2] + ", " + level.fogmaxopacity + ", 0 );");
    }
  }
}