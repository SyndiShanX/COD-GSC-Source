/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: common_scripts\_artcommon.gsc
*****************************************/

#include common_scripts\utility;

setfogsliders() {
  SetDevDvar("scr_fog_exp_halfplane", GetDvar("g_fogHalfDistReadOnly", 0.0));
  SetDevDvar("scr_fog_nearplane", GetDvar("g_fogStartDistReadOnly", 0.1));
  SetDevDvar("scr_fog_color", GetDvarVector("g_fogColorReadOnly", (1, 0, 0)));
  SetDevDvar("scr_fog_color_intensity", GetDvar("g_fogColorIntensityReadOnly", 1.0));
  SetDevDvar("scr_fog_max_opacity", GetDvar("g_fogMaxOpacityReadOnly", 1.0));

  SetDevDvar("scr_sunFogEnabled", GetDvar("g_sunFogEnabledReadOnly", 0));
  SetDevDvar("scr_sunFogColor", GetDvarVector("g_sunFogColorReadOnly", (1, 0, 0)));
  SetDevDvar("scr_sunfogColorIntensity", GetDvar("g_sunFogColorIntensityReadOnly", 1.0));
  SetDevDvar("scr_sunFogDir", GetDvarVector("g_sunFogDirReadOnly", (1, 0, 0)));
  SetDevDvar("scr_sunFogBeginFadeAngle", GetDvar("g_sunFogBeginFadeAngleReadOnly", 0.0));
  SetDevDvar("scr_sunFogEndFadeAngle", GetDvar("g_sunFogEndFadeAngleReadOnly", 180.0));
  SetDevDvar("scr_sunFogScale", GetDvar("g_sunFogScaleReadOnly", 1.0));

  SetDevDvar("scr_skyFogIntensity", GetDvar("r_sky_fog_intensity"), 0.0);
  SetDevDvar("scr_skyFogMinAngle", GetDvar("r_sky_fog_min_angle"), 0.0);
  SetDevDvar("scr_skyFogMaxAngle", GetDvar("r_sky_fog_max_angle"), 90.0);
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
    SetDvar("scr_sunFogBeginFadeAngle", level.sunFogBeginFadeAngle);
  }

  if(level.sunFogEndFadeAngle <= level.sunFogBeginFadeAngle) {
    level.sunFogEndFadeAngle = level.sunFogBeginFadeAngle + 1;
    SetDvar("scr_sunFogEndFadeAngle", level.sunFogEndFadeAngle);
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

  fileprint_launcher("r_glow \"" + GetDvar("r_glowTweakEnable") + "\"");
  fileprint_launcher("r_glowRadius0\"" + GetDvar("r_glowTweakRadius0") + "\"");
  fileprint_launcher("r_glowBloomPinch \"" + GetDvar("r_glowTweakBloomPinch") + "\"");
  fileprint_launcher("r_glowBloomCutoff\"" + GetDvar("r_glowTweakBloomCutoff") + "\"");
  fileprint_launcher("r_glowBloomDesaturation\"" + GetDvar("r_glowTweakBloomDesaturation") + "\"");
  fileprint_launcher("r_glowBloomIntensity0\"" + GetDvar("r_glowTweakBloomIntensity0") + "\"");
  fileprint_launcher("r_glowUseAltCutoff \"" + GetDvar("r_glowTweakUseAltCutoff") + "\"");
  fileprint_launcher(" ");

  fileprint_launcher("r_filmEnable\"" + GetDvar("r_filmTweakEnable") + "\"");
  fileprint_launcher("r_filmContrast\"" + GetDvar("r_filmTweakContrast") + "\"");
  fileprint_launcher("r_filmBrightness\"" + GetDvar("r_filmTweakBrightness") + "\"");
  fileprint_launcher("r_filmDesaturation\"" + GetDvar("r_filmTweakDesaturation") + "\"");
  fileprint_launcher("r_filmDesaturationDark\"" + GetDvar("r_filmTweakDesaturationDark") + "\"");
  fileprint_launcher("r_filmInvert\"" + GetDvar("r_filmTweakInvert") + "\"");
  fileprint_launcher("r_filmLightTint \"" + GetDvar("r_filmTweakLightTint") + "\"");
  fileprint_launcher("r_filmMediumTint\"" + GetDvar("r_filmTweakMediumTint") + "\"");
  fileprint_launcher("r_filmDarkTint\"" + GetDvar("r_filmTweakDarkTint") + "\"");
  fileprint_launcher(" ");

  fileprint_launcher("r_primaryLightUseTweaks\"" + GetDvar("r_primaryLightUseTweaks") + "\"");
  fileprint_launcher("r_primaryLightTweakDiffuseStrength \"" + GetDvar("r_primaryLightTweakDiffuseStrength") + "\"");
  fileprint_launcher("r_primaryLightTweakSpecularStrength\"" + GetDvar("r_primaryLightTweakSpecularStrength") + "\"");
  fileprint_launcher("r_charLightAmbient \"" + GetDvar("r_charLightAmbient") + "\"");
  fileprint_launcher("r_primaryLightUseTweaks_NG \"" + GetDvar("r_primaryLightUseTweaks_NG") + "\"");
  fileprint_launcher("r_primaryLightTweakDiffuseStrength_NG\"" + GetDvar("r_primaryLightTweakDiffuseStrength_NG") + "\"");
  fileprint_launcher("r_primaryLightTweakSpecularStrength_NG \"" + GetDvar("r_primaryLightTweakSpecularStrength_NG") + "\"");
  fileprint_launcher("r_charLightAmbient_NG\"" + GetDvar("r_charLightAmbient_NG") + "\"");
  fileprint_launcher(" ");

  fileprint_launcher("r_viewModelPrimaryLightUseTweaks\"" + GetDvar("r_viewModelPrimaryLightUseTweaks") + "\"");
  fileprint_launcher("r_viewModelPrimaryLightTweakDiffuseStrength \"" + GetDvar("r_viewModelPrimaryLightTweakDiffuseStrength") + "\"");
  fileprint_launcher("r_viewModelPrimaryLightTweakSpecularStrength\"" + GetDvar("r_viewModelPrimaryLightTweakSpecularStrength") + "\"");
  fileprint_launcher("r_viewModelLightAmbient \"" + GetDvar("r_viewModelLightAmbient") + "\"");
  fileprint_launcher("r_viewModelPrimaryLightUseTweaks_NG \"" + GetDvar("r_viewModelPrimaryLightUseTweaks_NG") + "\"");
  fileprint_launcher("r_viewModelPrimaryLightTweakDiffuseStrength_NG\"" + GetDvar("r_viewModelPrimaryLightTweakDiffuseStrength_NG") + "\"");
  fileprint_launcher("r_viewModelPrimaryLightTweakSpecularStrength_NG \"" + GetDvar("r_viewModelPrimaryLightTweakSpecularStrength_NG") + "\"");
  fileprint_launcher("r_viewModelLightAmbient_NG\"" + GetDvar("r_viewModelLightAmbient_NG") + "\"");
  fileprint_launcher(" ");

  fileprint_launcher("r_materialBloomRadius\"" + GetDvar("r_materialBloomRadius") + "\"");
  fileprint_launcher("r_materialBloomPinch \"" + GetDvar("r_materialBloomPinch") + "\"");
  fileprint_launcher("r_materialBloomIntensity \"" + GetDvar("r_materialBloomIntensity") + "\"");
  fileprint_launcher("r_materialBloomLuminanceCutoff \"" + GetDvar("r_materialBloomLuminanceCutoff") + "\"");
  fileprint_launcher("r_materialBloomDesaturation\"" + GetDvar("r_materialBloomDesaturation") + "\"");
  fileprint_launcher(" ");

  fileprint_launcher("r_volumeLightScatter \"" + GetDvar("r_volumeLightScatterUseTweaks") + "\"");
  fileprint_launcher("r_volumeLightScatterLinearAtten\"" + GetDvar("r_volumeLightScatterLinearAtten") + "\"");
  fileprint_launcher("r_volumeLightScatterQuadraticAtten \"" + GetDvar("r_volumeLightScatterQuadraticAtten") + "\"");
  fileprint_launcher("r_volumeLightScatterAngularAtten \"" + GetDvar("r_volumeLightScatterAngularAtten") + "\"");
  fileprint_launcher("r_volumeLightScatterDepthAttenNear \"" + GetDvar("r_volumeLightScatterDepthAttenNear") + "\"");
  fileprint_launcher("r_volumeLightScatterDepthAttenFar\"" + GetDvar("r_volumeLightScatterDepthAttenFar") + "\"");
  fileprint_launcher("r_volumeLightScatterBackgroundDistance \"" + GetDvar("r_volumeLightScatterBackgroundDistance") + "\"");
  fileprint_launcher("r_volumeLightScatterColor\"" + GetDvar("r_volumeLightScatterColor") + "\"");
  fileprint_launcher(" ");

  fileprint_launcher("r_ssaoStrength \"" + GetDvar("r_ssaoStrength") + "\"");
  fileprint_launcher("r_ssaoPower\"" + GetDvar("r_ssaoPower") + "\"");
  fileprint_launcher(" ");

  fileprint_launcher("r_rimLight0Pitch\"" + GetDvar("r_rimLight0Pitch") + "\"");
  fileprint_launcher("r_rimLight0Heading\"" + GetDvar("r_rimLight0Heading") + "\"");
  fileprint_launcher("r_rimLightDiffuseIntensity\"" + GetDvar("r_rimLightDiffuseIntensity") + "\"");
  fileprint_launcher("r_rimLightSpecIntensity \"" + GetDvar("r_rimLightSpecIntensity") + "\"");
  fileprint_launcher("r_rimLightBias\"" + GetDvar("r_rimLightBias") + "\"");
  fileprint_launcher("r_rimLightPower \"" + GetDvar("r_rimLightPower") + "\"");
  fileprint_launcher("r_rimLight0Color\"" + GetDvar("r_rimLight0Color") + "\"");
  fileprint_launcher("r_rimLight0Pitch_NG \"" + GetDvar("r_rimLight0Pitch_NG") + "\"");
  fileprint_launcher("r_rimLight0Heading_NG \"" + GetDvar("r_rimLight0Heading_NG") + "\"");
  fileprint_launcher("r_rimLightDiffuseIntensity_NG \"" + GetDvar("r_rimLightDiffuseIntensity_NG") + "\"");
  fileprint_launcher("r_rimLightSpecIntensity_NG\"" + GetDvar("r_rimLightSpecIntensity_NG") + "\"");
  fileprint_launcher("r_rimLightBias_NG \"" + GetDvar("r_rimLightBias_NG") + "\"");
  fileprint_launcher("r_rimLightPower_NG\"" + GetDvar("r_rimLightPower_NG") + "\"");
  fileprint_launcher("r_rimLight0Color_NG \"" + GetDvar("r_rimLight0Color_NG") + "\"");
  fileprint_launcher(" ");

  fileprint_launcher("r_unlitSurfaceHDRScalar \"" + GetDvar("r_unlitSurfaceHDRScalar") + "\"");
  fileprint_launcher(" ");

  colorizationName = GetDvar("r_colorizationTweakName");
  toneMappingName = GetDvar("r_toneMappingTweakName");
  clutMaterialName = GetDvar("r_clutMaterialTweakName");
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