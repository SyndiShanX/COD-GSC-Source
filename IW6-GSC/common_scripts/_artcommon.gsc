/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: common_scripts\_artcommon.gsc
*****************************************/

#include common_scripts\utility;

setfogsliders() {
  SetDevDvar("scr_fog_exp_halfplane", getDvar("g_fogHalfDistReadOnly", 0.0));
  SetDevDvar("scr_fog_nearplane", getDvar("g_fogStartDistReadOnly", 0.1));
  SetDevDvar("scr_fog_color", GetDvarVector("g_fogColorReadOnly", (1, 0, 0)));
  SetDevDvar("scr_fog_color_intensity", getDvar("g_fogColorIntensityReadOnly", 1.0));
  SetDevDvar("scr_fog_max_opacity", getDvar("g_fogMaxOpacityReadOnly", 1.0));

  SetDevDvar("scr_sunFogEnabled", getDvar("g_sunFogEnabledReadOnly", 0));
  SetDevDvar("scr_sunFogColor", GetDvarVector("g_sunFogColorReadOnly", (1, 0, 0)));
  SetDevDvar("scr_sunfogColorIntensity", getDvar("g_sunFogColorIntensityReadOnly", 1.0));
  SetDevDvar("scr_sunFogDir", GetDvarVector("g_sunFogDirReadOnly", (1, 0, 0)));
  SetDevDvar("scr_sunFogBeginFadeAngle", getDvar("g_sunFogBeginFadeAngleReadOnly", 0.0));
  SetDevDvar("scr_sunFogEndFadeAngle", getDvar("g_sunFogEndFadeAngleReadOnly", 180.0));
  SetDevDvar("scr_sunFogScale", getDvar("g_sunFogScaleReadOnly", 1.0));

  SetDevDvar("scr_skyFogIntensity", getDvar("r_sky_fog_intensity"), 0.0);
  SetDevDvar("scr_skyFogMinAngle", getDvar("r_sky_fog_min_angle"), 0.0);
  SetDevDvar("scr_skyFogMaxAngle", getDvar("r_sky_fog_max_angle"), 90.0);
}

translateFogSlidersToScript() {
  level.fogexphalfplane = limit(GetDvarFloat("scr_fog_exp_halfplane"));
  level.fognearplane = limit(GetDvarFloat("scr_fog_nearplane"));
  level.fogHDRColorIntensity = limit(GetDvarFloat("scr_fog_color_intensity"));
  level.fogmaxopacity = limit(GetDvarFloat("scr_fog_max_opacity"));

  level.sunFogEnabled = GetDvarInt("scr_sunFogEnabled");
  level.sunFogHDRColorIntensity = limit(GetDvarFloat("scr_sunFogColorIntensity"));
  level.sunFogBeginFadeAngle = limit(GetDvarFloat("scr_sunFogBeginFadeAngle"));
  level.sunFogEndFadeAngle = limit(GetDvarFloat("scr_sunFogEndFadeAngle"));
  level.sunFogScale = limit(GetDvarFloat("scr_sunFogScale"));

  level.skyFogIntensity = limit(GetDvarFloat("scr_skyFogIntensity"));
  level.skyFogMinAngle = limit(GetDvarFloat("scr_skyFogMinAngle"));
  level.skyFogMaxAngle = limit(GetDvarFloat("scr_skyFogMaxAngle"));

  fogColor = GetDvarVector("scr_fog_color");
  r = limit(fogColor[0]);
  g = limit(fogColor[1]);
  b = limit(fogColor[2]);
  level.fogcolor = (r, g, b);

  sunFogColor = GetDvarVector("scr_sunFogColor");
  r = limit(sunFogColor[0]);
  g = limit(sunFogColor[1]);
  b = limit(sunFogColor[2]);
  level.sunFogColor = (r, g, b);

  sunFogDir = GetDvarVector("scr_sunFogDir");
  x = limit(sunFogDir[0]);
  y = limit(sunFogDir[1]);
  z = limit(sunFogDir[2]);
  level.sunFogDir = (x, y, z);
}

limit(i) {
  limit = 0.001;
  if((i < limit) && (i > (limit * -1)))
    i = 0;
  return i;
}

fogslidercheck() {
  if(level.sunFogBeginFadeAngle >= level.sunFogEndFadeAngle) {
    level.sunFogBeginFadeAngle = level.sunFogEndFadeAngle - 1;
    setDvar("scr_sunFogBeginFadeAngle", level.sunFogBeginFadeAngle);
  }

  if(level.sunFogEndFadeAngle <= level.sunFogBeginFadeAngle) {
    level.sunFogEndFadeAngle = level.sunFogBeginFadeAngle + 1;
    setDvar("scr_sunFogEndFadeAngle", level.sunFogEndFadeAngle);
  }
}

add_vision_set_to_list(vision_set_name) {
  assert(isDefined(level.vision_set_names));

  found = array_find(level.vision_set_names, vision_set_name);
  if(isDefined(found)) {
    return;
  }
  level.vision_set_names = array_add(level.vision_set_names, vision_set_name);
}

print_vision(vision_set) {
  found = array_find(level.vision_set_names, vision_set);
  if(!isDefined(found)) {
    return;
  }
  fileprint_launcher_start_file();

  fileprint_launcher("r_glow \"" + getDvar("r_glowTweakEnable") + "\"");
  fileprint_launcher("r_glowRadius0\"" + getDvar("r_glowTweakRadius0") + "\"");
  fileprint_launcher("r_glowBloomPinch \"" + getDvar("r_glowTweakBloomPinch") + "\"");
  fileprint_launcher("r_glowBloomCutoff\"" + getDvar("r_glowTweakBloomCutoff") + "\"");
  fileprint_launcher("r_glowBloomDesaturation\"" + getDvar("r_glowTweakBloomDesaturation") + "\"");
  fileprint_launcher("r_glowBloomIntensity0\"" + getDvar("r_glowTweakBloomIntensity0") + "\"");
  fileprint_launcher("r_glowUseAltCutoff \"" + getDvar("r_glowTweakUseAltCutoff") + "\"");
  fileprint_launcher(" ");

  fileprint_launcher("r_filmEnable\"" + getDvar("r_filmTweakEnable") + "\"");
  fileprint_launcher("r_filmContrast\"" + getDvar("r_filmTweakContrast") + "\"");
  fileprint_launcher("r_filmBrightness\"" + getDvar("r_filmTweakBrightness") + "\"");
  fileprint_launcher("r_filmDesaturation\"" + getDvar("r_filmTweakDesaturation") + "\"");
  fileprint_launcher("r_filmDesaturationDark\"" + getDvar("r_filmTweakDesaturationDark") + "\"");
  fileprint_launcher("r_filmInvert\"" + getDvar("r_filmTweakInvert") + "\"");
  fileprint_launcher("r_filmLightTint \"" + getDvar("r_filmTweakLightTint") + "\"");
  fileprint_launcher("r_filmMediumTint\"" + getDvar("r_filmTweakMediumTint") + "\"");
  fileprint_launcher("r_filmDarkTint\"" + getDvar("r_filmTweakDarkTint") + "\"");
  fileprint_launcher(" ");

  fileprint_launcher("r_primaryLightUseTweaks\"" + getDvar("r_primaryLightUseTweaks") + "\"");
  fileprint_launcher("r_primaryLightTweakDiffuseStrength \"" + getDvar("r_primaryLightTweakDiffuseStrength") + "\"");
  fileprint_launcher("r_primaryLightTweakSpecularStrength\"" + getDvar("r_primaryLightTweakSpecularStrength") + "\"");
  fileprint_launcher("r_charLightAmbient \"" + getDvar("r_charLightAmbient") + "\"");
  fileprint_launcher("r_primaryLightUseTweaks_NG \"" + getDvar("r_primaryLightUseTweaks_NG") + "\"");
  fileprint_launcher("r_primaryLightTweakDiffuseStrength_NG\"" + getDvar("r_primaryLightTweakDiffuseStrength_NG") + "\"");
  fileprint_launcher("r_primaryLightTweakSpecularStrength_NG \"" + getDvar("r_primaryLightTweakSpecularStrength_NG") + "\"");
  fileprint_launcher("r_charLightAmbient_NG\"" + getDvar("r_charLightAmbient_NG") + "\"");
  fileprint_launcher(" ");

  fileprint_launcher("r_viewModelPrimaryLightUseTweaks\"" + getDvar("r_viewModelPrimaryLightUseTweaks") + "\"");
  fileprint_launcher("r_viewModelPrimaryLightTweakDiffuseStrength \"" + getDvar("r_viewModelPrimaryLightTweakDiffuseStrength") + "\"");
  fileprint_launcher("r_viewModelPrimaryLightTweakSpecularStrength\"" + getDvar("r_viewModelPrimaryLightTweakSpecularStrength") + "\"");
  fileprint_launcher("r_viewModelLightAmbient \"" + getDvar("r_viewModelLightAmbient") + "\"");
  fileprint_launcher("r_viewModelPrimaryLightUseTweaks_NG \"" + getDvar("r_viewModelPrimaryLightUseTweaks_NG") + "\"");
  fileprint_launcher("r_viewModelPrimaryLightTweakDiffuseStrength_NG\"" + getDvar("r_viewModelPrimaryLightTweakDiffuseStrength_NG") + "\"");
  fileprint_launcher("r_viewModelPrimaryLightTweakSpecularStrength_NG \"" + getDvar("r_viewModelPrimaryLightTweakSpecularStrength_NG") + "\"");
  fileprint_launcher("r_viewModelLightAmbient_NG\"" + getDvar("r_viewModelLightAmbient_NG") + "\"");
  fileprint_launcher(" ");

  fileprint_launcher("r_materialBloomRadius\"" + getDvar("r_materialBloomRadius") + "\"");
  fileprint_launcher("r_materialBloomPinch \"" + getDvar("r_materialBloomPinch") + "\"");
  fileprint_launcher("r_materialBloomIntensity \"" + getDvar("r_materialBloomIntensity") + "\"");
  fileprint_launcher("r_materialBloomLuminanceCutoff \"" + getDvar("r_materialBloomLuminanceCutoff") + "\"");
  fileprint_launcher("r_materialBloomDesaturation\"" + getDvar("r_materialBloomDesaturation") + "\"");
  fileprint_launcher(" ");

  fileprint_launcher("r_volumeLightScatter \"" + getDvar("r_volumeLightScatterUseTweaks") + "\"");
  fileprint_launcher("r_volumeLightScatterLinearAtten\"" + getDvar("r_volumeLightScatterLinearAtten") + "\"");
  fileprint_launcher("r_volumeLightScatterQuadraticAtten \"" + getDvar("r_volumeLightScatterQuadraticAtten") + "\"");
  fileprint_launcher("r_volumeLightScatterAngularAtten \"" + getDvar("r_volumeLightScatterAngularAtten") + "\"");
  fileprint_launcher("r_volumeLightScatterDepthAttenNear \"" + getDvar("r_volumeLightScatterDepthAttenNear") + "\"");
  fileprint_launcher("r_volumeLightScatterDepthAttenFar\"" + getDvar("r_volumeLightScatterDepthAttenFar") + "\"");
  fileprint_launcher("r_volumeLightScatterBackgroundDistance \"" + getDvar("r_volumeLightScatterBackgroundDistance") + "\"");
  fileprint_launcher("r_volumeLightScatterColor\"" + getDvar("r_volumeLightScatterColor") + "\"");
  fileprint_launcher(" ");

  fileprint_launcher("r_ssaoStrength \"" + getDvar("r_ssaoStrength") + "\"");
  fileprint_launcher("r_ssaoPower\"" + getDvar("r_ssaoPower") + "\"");
  fileprint_launcher(" ");

  fileprint_launcher("r_rimLight0Pitch\"" + getDvar("r_rimLight0Pitch") + "\"");
  fileprint_launcher("r_rimLight0Heading\"" + getDvar("r_rimLight0Heading") + "\"");
  fileprint_launcher("r_rimLightDiffuseIntensity\"" + getDvar("r_rimLightDiffuseIntensity") + "\"");
  fileprint_launcher("r_rimLightSpecIntensity \"" + getDvar("r_rimLightSpecIntensity") + "\"");
  fileprint_launcher("r_rimLightBias\"" + getDvar("r_rimLightBias") + "\"");
  fileprint_launcher("r_rimLightPower \"" + getDvar("r_rimLightPower") + "\"");
  fileprint_launcher("r_rimLight0Color\"" + getDvar("r_rimLight0Color") + "\"");
  fileprint_launcher("r_rimLight0Pitch_NG \"" + getDvar("r_rimLight0Pitch_NG") + "\"");
  fileprint_launcher("r_rimLight0Heading_NG \"" + getDvar("r_rimLight0Heading_NG") + "\"");
  fileprint_launcher("r_rimLightDiffuseIntensity_NG \"" + getDvar("r_rimLightDiffuseIntensity_NG") + "\"");
  fileprint_launcher("r_rimLightSpecIntensity_NG\"" + getDvar("r_rimLightSpecIntensity_NG") + "\"");
  fileprint_launcher("r_rimLightBias_NG \"" + getDvar("r_rimLightBias_NG") + "\"");
  fileprint_launcher("r_rimLightPower_NG\"" + getDvar("r_rimLightPower_NG") + "\"");
  fileprint_launcher("r_rimLight0Color_NG \"" + getDvar("r_rimLight0Color_NG") + "\"");
  fileprint_launcher(" ");

  fileprint_launcher("r_unlitSurfaceHDRScalar \"" + getDvar("r_unlitSurfaceHDRScalar") + "\"");
  fileprint_launcher(" ");

  colorizationName = getDvar("r_colorizationTweakName");
  toneMappingName = getDvar("r_toneMappingTweakName");
  clutMaterialName = getDvar("r_clutMaterialTweakName");
  if(colorizationName != "")
    fileprint_launcher("colorizationSet \"" + colorizationName + "\"");
    if(toneMappingName != "")
      fileprint_launcher("toneMapping \"" + toneMappingName + "\"");
      if(clutMaterialName != "")
        fileprint_launcher("clutMaterial\"" + clutMaterialName + "\"");

        return fileprint_launcher_end_file("\\share\\raw\\vision\\" + vision_set + ".vision", true);
}

print_fog_ents(forMP) {
  foreach(ent in level.vision_set_fog) {
    if(!isDefined(ent.name)) {
      continue;
    }
    if(forMP)
      fileprint_launcher("\tent = maps\\mp\\_art::create_vision_set_fog( \"" + ent.name + "\" );");
    else
      fileprint_launcher("\tent = maps\\_utility::create_vision_set_fog( \"" + ent.name + "\" );");

      fileprint_launcher("\tent.startDist =" + ent.startDist + ";");
      fileprint_launcher("\tent.halfwayDist =" + ent.halfwayDist + ";");
      fileprint_launcher("\tent.red =" + ent.red + ";");
      fileprint_launcher("\tent.green =" + ent.green + ";");
      fileprint_launcher("\tent.blue = " + ent.blue + ";");
      fileprint_launcher("\tent.HDRColorIntensity =" + ent.HDRColorIntensity + ";");
      fileprint_launcher("\tent.maxOpacity = " + ent.maxOpacity + ";");
      fileprint_launcher("\tent.transitionTime = " + ent.transitionTime + ";");
      fileprint_launcher("\tent.sunFogEnabled =" + ent.sunFogEnabled + ";");
      fileprint_launcher("\tent.sunRed = " + ent.sunRed + ";");
      fileprint_launcher("\tent.sunGreen = " + ent.sunGreen + ";");
      fileprint_launcher("\tent.sunBlue =" + ent.sunBlue + ";");
      fileprint_launcher("\tent.HDRSunColorIntensity = " + ent.HDRSunColorIntensity + ";");
      fileprint_launcher("\tent.sunDir = " + ent.sunDir + ";");
      fileprint_launcher("\tent.sunBeginFadeAngle =" + ent.sunBeginFadeAngle + ";");
      fileprint_launcher("\tent.sunEndFadeAngle =" + ent.sunEndFadeAngle + ";");
      fileprint_launcher("\tent.normalFogScale = " + ent.normalFogScale + ";");
      fileprint_launcher("\tent.skyFogIntensity =" + ent.skyFogIntensity + ";");
      fileprint_launcher("\tent.skyFogMinAngle = " + ent.skyFogMinAngle + ";");
      fileprint_launcher("\tent.skyFogMaxAngle = " + ent.skyFogMaxAngle + ";");

      if(isDefined(ent.HDROverride))
        fileprint_launcher("\tent.HDROverride =\"" + ent.HDROverride + "\";");

        if(isDefined(ent.stagedVisionSets)) {
          string = " ";
          for(i = 0; i < ent.stagedVisionSets.size; i++) {
            string = string + "\"" + ent.stagedVisionSets[i] + "\"";
            if(i < ent.stagedVisionSets.size - 1)
              string = string + ",";
            string = string + " ";
          }

          fileprint_launcher("\tent.stagedVisionSets = [" + string + "];");
        }

    fileprint_launcher(" ");
  }
}

print_fog_ents_csv() {
  foreach(ent in level.vision_set_fog) {
    if(!isDefined(ent.name)) {
      continue;
    }
    targettedByHDROverride = false;
    foreach(ent2 in level.vision_set_fog) {
      if(isDefined(ent2.HDROverride) && ent2.HDROverride == ent.name) {
        targettedByHDROverride = true;
        break;
      }
    }

    if(!targettedByHDROverride)
    fileprint_launcher("rawfile,vision/" + ent.name + ".vision");
  }
}