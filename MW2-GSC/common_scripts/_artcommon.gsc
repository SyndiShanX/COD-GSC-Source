/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: common_scripts\_artcommon.gsc
********************************************************/

#include common_scripts\utility;

artStartVisionFileExport() {
  fileprint_launcher_start_file();
}

artEndVisionFileExport() {
  return fileprint_launcher_end_file("\\share\\raw\\vision\\" + level.script + ".vision", true);
}

artStartFogFileExport() {
  fileprint_launcher_start_file();
}

artEndFogFileExport() {
  return fileprint_launcher_end_file("\\share\\raw\\maps\\createart\\" + level.script + "_art.gsc", true);
}

artCommonfxprintln(string) {
  fileprint_launcher(string);
}

setfogsliders() {
  fogcolor = getdvarvector("g_fogColorReadOnly");
  maxOpacity = getDvar("g_fogMaxOpacityReadOnly");
  halfplane = getDvar("g_fogHalfDistReadOnly");
  nearplane = getDvar("g_fogStartDistReadOnly");

  sunFogEnabled = getDvar("g_sunFogEnabledReadOnly");
  sunFogColor = getdvarvector("g_sunFogColorReadOnly");
  sunFogDir = getdvarvector("g_sunFogDirReadOnly");
  sunFogBeginFadeAngle = getDvar("g_sunFogBeginFadeAngleReadOnly");
  sunFogEndFadeAngle = getDvar("g_sunFogEndFadeAngleReadOnly");
  sunFogScale = getDvar("g_sunFogScaleReadOnly");

  if(!isDefined(fogcolor) || !isDefined(maxOpacity) || !isDefined(halfplane) || !isDefined(nearplane) || !isDefined(sunFogEnabled) || !isDefined(sunFogColor) || !isDefined(sunFogDir) || !isDefined(sunFogBeginFadeAngle) || !isDefined(sunFogEndFadeAngle) || !isDefined(sunFogScale)) {
    fogcolor = (1, 1, 1);
    halfplane = 10000001;
    nearplane = 10000000;
    maxOpacity = 1;

    sunFogEnabled = false;
    sunFogColor = (1, 1, 1);
    sunFogDir = (1.0, 0.0, 0.0);
    sunFogBeginFadeAngle = getDvar("g_sunFogBeginFadeAngle");
    sunFogEndFadeAngle = getDvar("g_sunFogEndFadeAngle");
    sunFogScale = getDvar("g_sunFogScaleReadOnly");
  }
  SetDevDvar("scr_fog_exp_halfplane", halfplane);
  SetDevDvar("scr_fog_nearplane", nearplane);
  SetDevDvar("scr_fog_color", fogcolor);
  SetDevDvar("scr_fog_max_opacity", maxOpacity);

  SetDevDvar("scr_sunFogEnabled", sunFogEnabled);
  SetDevDvar("scr_sunFogColor", sunFogColor);
  SetDevDvar("scr_sunFogDir", sunFogDir);
  SetDevDvar("scr_sunFogBeginFadeAngle", sunFogBeginFadeAngle);
  SetDevDvar("scr_sunFogEndFadeAngle", sunFogEndFadeAngle);
  SetDevDvar("scr_sunFogScale", sunFogScale);
}

translateFogSlidersToScript() {
  level.fogexphalfplane = GetDvarFloat("scr_fog_exp_halfplane");
  level.fognearplane = GetDvarFloat("scr_fog_nearplane");
  level.fogcolor = getdvarvector("scr_fog_color");
  level.fogmaxopacity = GetDvarFloat("scr_fog_max_opacity");

  level.sunFogEnabled = GetDvarInt("scr_sunFogEnabled");
  level.sunFogColor = getdvarvector("scr_sunFogColor");
  level.sunFogDir = getdvarvector("scr_sunFogDir");
  level.sunFogBeginFadeAngle = GetDvarFloat("scr_sunFogBeginFadeAngle");
  level.sunFogEndFadeAngle = GetDvarFloat("scr_sunFogEndFadeAngle");
  level.sunFogScale = GetDvarFloat("scr_sunFogScale");
}

updateFogFromScript() {
  if(GetDvarInt("scr_cmd_plr_sun")) {
    SetDevDvar("scr_sunFogDir", anglesToForward(level.player GetPlayerAngles()));
    SetDevDvar("scr_cmd_plr_sun", 0);
  }

  if(!GetDvarInt("scr_fog_disable")) {
    if(level.sunFogEnabled)
      SetExpFog(level.fognearplane, level.fogexphalfplane, level.fogcolor[0], level.fogcolor[1], level.fogcolor[2], level.fogmaxopacity, 0, level.sunFogColor[0], level.sunFogColor[1], level.sunFogColor[2], level.sunFogDir, level.sunFogBeginFadeAngle, level.sunFogEndFadeAngle, level.sunFogScale);
    else
      SetExpFog(level.fognearplane, level.fogexphalfplane, level.fogcolor[0], level.fogcolor[1], level.fogcolor[2], level.fogmaxopacity, 0);
  } else {
    SetExpFog(100000000000, 100000000001, 0, 0, 0, 0, 0); // couldn't find discreet fog disabling other than to never set it in the first place
  }
}

artfxprintlnFog() {
  fileprint_launcher("");
  fileprint_launcher("\t//* Fog section * ");
  fileprint_launcher("");

  fileprint_launcher("\tsetDevDvar( \"scr_fog_disable\"" + ", " + "\"" + GetDvarInt("scr_fog_disable") + "\"" + " );");

  fileprint_launcher("");
  if(!GetDvarInt("scr_fog_disable")) {
    if(level.sunFogEnabled)
      fileprint_launcher("\tsetExpFog( " + level.fognearplane + ", " + level.fogexphalfplane + ", " + level.fogcolor[0] + ", " + level.fogcolor[1] + ", " + level.fogcolor[2] + ", " + level.fogmaxopacity + ", 0, " + level.sunFogColor[0] + ", " + level.sunFogColor[1] + ", " + level.sunFogColor[2] + ", (" + level.sunFogDir[0] + ", " + level.sunFogDir[1] + ", " + level.sunFogDir[2] + "), " + level.sunFogBeginFadeAngle + ", " + level.sunFogEndFadeAngle + ", " + level.sunFogScale + " );");
    else
    fileprint_launcher("\tsetExpFog( " + level.fognearplane + ", " + level.fogexphalfplane + ", " + level.fogcolor[0] + ", " + level.fogcolor[1] + ", " + level.fogcolor[2] + ", " + level.fogmaxopacity + ", 0 );");
  }
}