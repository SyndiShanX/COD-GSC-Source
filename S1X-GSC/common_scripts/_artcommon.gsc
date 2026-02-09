/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: common_scripts\_artcommon.gsc
***************************************************/

#include common_scripts\utility;

setfogsliders() {
  /$

  SetDevDvar("scr_fog_exp_halfplane", getDvar("g_fogHalfDistReadOnly", 0.0));
  SetDevDvar("scr_fog_nearplane", getDvar("g_fogStartDistReadOnly", 0.1));
  SetDevDvar("scr_fog_color", getDvar("g_fogColorReadOnly", (1, 0, 0)));
  SetDevDvar("scr_fog_color_intensity", getDvar("g_fogColorIntensityReadOnly", 1.0));
  SetDevDvar("scr_fog_max_opacity", getDvar("g_fogMaxOpacityReadOnly", 1.0));
  SetDevDvar("scr_sunFogEnabled", getDvar("g_sunFogEnabledReadOnly", 0));
  SetDevDvar("scr_sunFogColor", getDvar("g_sunFogColorReadOnly", (1, 0, 0)));
  SetDevDvar("scr_sunfogColorIntensity", getDvar("g_sunFogColorIntensityReadOnly", 1.0));
  SetDevDvar("scr_sunFogDir", GetDvarVector("g_sunFogDirReadOnly", (1, 0, 0)));
  SetDevDvar("scr_sunFogBeginFadeAngle", getDvar("g_sunFogBeginFadeAngleReadOnly", 0.0));
  SetDevDvar("scr_sunFogEndFadeAngle", getDvar("g_sunFogEndFadeAngleReadOnly", 180.0));
  SetDevDvar("scr_sunFogScale", getDvar("g_sunFogScaleReadOnly", 1.0));
  SetDevDvar("scr_heightFogEnabled", getDvar("g_heightFogEnabledReadOnly", 0));
  SetDevDvar("scr_heightFogBaseHeight", getDvar("g_heightFogBaseHeightReadOnly", 0));
  SetDevDvar("scr_heightFogHalfPlaneDistance", getDvar("g_heightFogHalfPlaneDistanceReadOnly", 1000));

  SetDevDvar("scr_skyFogIntensity", getDvar("r_sky_fog_intensity", 0.0));
  SetDevDvar("scr_skyFogMinAngle", getDvar("r_sky_fog_min_angle", 0.0));
  SetDevDvar("scr_skyFogMaxAngle", getDvar("r_sky_fog_max_angle", 90.0));

  SetDevDvar("scr_atmosFogEnabled", getDvar("g_atmosFogEnabledReadOnly", 0));
  SetDevDvar("scr_atmosFogSunFogColor", getDvar("g_atmosFogSunFogColorReadOnly", (.5, .5, .5)));
  SetDevDvar("scr_atmosFogHazeColor", getDvar("g_atmosFogHazeColorReadOnly", (.5, .5, .5)));
  SetDevDvar("scr_atmosFogHazeStrength", getDvar("g_atmosFogHazeStrengthReadOnly", .5));
  SetDevDvar("scr_atmosFogHazeSpread", getDvar("g_atmosFogHazeSpreadReadOnly", .75));
  SetDevDvar("scr_atmosFogExtinctionStrength", getDvar("g_atmosFogExtinctionStrengthReadOnly", 1));
  SetDevDvar("scr_atmosFogInScatterStrength", getDvar("g_atmosFogInScatterStrengthReadOnly", 0));
  SetDevDvar("scr_atmosFogHalfPlaneDistance", getDvar("g_atmosFogHalfPlaneDistanceReadOnly", 5000));
  SetDevDvar("scr_atmosFogStartDistance", getDvar("g_atmosFogStartDistanceReadOnly", 0));
  SetDevDvar("scr_atmosFogDistanceScale", getDvar("g_atmosFogDistanceScaleReadOnly", 1));
  SetDevDvar("scr_atmosFogSkyDistance", int(getDvar("g_atmosFogSkyDistanceReadOnly", 100000)));
  SetDevDvar("scr_atmosFogSkyAngularFalloffEnabled", getDvar("g_atmosFogSkyAngularFalloffEnabledReadOnly", 0));
  SetDevDvar("scr_atmosFogSkyFalloffStartAngle", getDvar("g_atmosFogSkyFalloffStartAngleReadOnly", 0));
  SetDevDvar("scr_atmosFogSkyFalloffAngleRange", getDvar("g_atmosFogSkyFalloffAngleRangeReadOnly", 90));
  SetDevDvar("scr_atmosFogSunDirection", GetDvarVector("g_atmosFogSunDirectionReadOnly", (0, 0, 1)));
  SetDevDvar("scr_atmosFogHeightFogEnabled", getDvar("g_atmosFogHeightFogEnabledReadOnly", 0));
  SetDevDvar("scr_atmosFogHeightFogBaseHeight", getDvar("g_atmosFogHeightFogBaseHeightReadOnly", 0));
  SetDevDvar("scr_atmosFogHeightFogHalfPlaneDistance", getDvar("g_atmosFogHeightFogHalfPlaneDistanceReadOnly", 1000));
  $ /
}

/$
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
  level.heightFogEnabled = GetDvarInt("scr_heightFogEnabled");
  level.heightFogBaseHeight = limit(GetDvarFloat("scr_heightFogBaseHeight"));
  level.heightFogHalfPlaneDistance = limit(GetDvarFloat("scr_heightFogHalfPlaneDistance"));

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

  level.atmosFogEnabled = GetDvarInt("scr_atmosFogEnabled");
  vec3 = GetDvarVector("scr_atmosFogSunFogColor");
  x = limit(vec3[0]);
  y = limit(vec3[1]);
  z = limit(vec3[2]);
  level.atmosFogSunFogColor = (x, y, z);
  vec3 = GetDvarVector("scr_atmosFogHazeColor");
  x = limit(vec3[0]);
  y = limit(vec3[1]);
  z = limit(vec3[2]);
  level.atmosFogHazeColor = (x, y, z);
  level.atmosFogHazeStrength = limit(GetDvarFloat("scr_atmosFogHazeStrength"));
  level.atmosFogHazeSpread = limit(GetDvarFloat("scr_atmosFogHazeSpread"));
  level.atmosFogExtinctionStrength = limit(GetDvarFloat("scr_atmosFogExtinctionStrength"));
  level.atmosFogInScatterStrength = limit(GetDvarFloat("scr_atmosFogInScatterStrength"));
  level.atmosFogHalfPlaneDistance = limit(GetDvarFloat("scr_atmosFogHalfPlaneDistance"));
  level.atmosFogStartDistance = limit(GetDvarFloat("scr_atmosFogStartDistance"));
  level.atmosFogDistanceScale = limit(GetDvarFloat("scr_atmosFogDistanceScale"));
  level.atmosFogSkyDistance = GetDvarInt("scr_atmosFogSkyDistance");
  level.atmosFogSkyAngularFalloffEnabled = GetDvarInt("scr_atmosFogSkyAngularFalloffEnabled");
  level.atmosFogSkyFalloffStartAngle = limit(GetDvarFloat("scr_atmosFogSkyFalloffStartAngle"));
  level.atmosFogSkyFalloffAngleRange = limit(GetDvarFloat("scr_atmosFogSkyFalloffAngleRange"));
  vec3 = GetDvarVector("scr_atmosFogSunDirection");
  x = limit(vec3[0]);
  y = limit(vec3[1]);
  z = limit(vec3[2]);
  level.atmosFogSunDirection = (x, y, z);
  level.atmosFogHeightFogEnabled = GetDvarInt("scr_atmosFogHeightFogEnabled");
  level.atmosFogHeightFogBaseHeight = limit(GetDvarFloat("scr_atmosFogHeightFogBaseHeight"));
  level.atmosFogHeightFogHalfPlaneDistance = limit(GetDvarFloat("scr_atmosFogHeightFogHalfPlaneDistance"));
}

limit(i) {
  limit = 0.001;
  if((i < limit) && (i > (limit * -1))) {
    i = 0;
  }
  return i;
}

updateFogEntFromScript() {
  if(GetDvarInt("scr_cmd_plr_sun")) {
    SetDevDvar("scr_sunFogDir", anglesToForward(level.player GetPlayerAngles()));
    SetDevDvar("scr_cmd_plr_sun", 0);
  }
  if(GetDvarInt("scr_cmd_plr_sun_atmos_fog")) {
    SetDevDvar("scr_atmosFogSunDirection", anglesToForward(level.player GetPlayerAngles()));
    SetDevDvar("scr_cmd_plr_sun_atmos_fog", 0);
  }
  vision_set_name = ToLower(level.vision_set_transition_ent.vision_set);
  if(level.currentgen) {
    vision_set_name_cg = vision_set_name + "_cg";
    if(isDefined(level.vision_set_fog[vision_set_name_cg])) {
      vision_set_name = vision_set_name_cg;
    }
  }
  ent = level.vision_set_fog[vision_set_name];

  if(isDefined(ent) && isDefined(ent.HDROverride) && isDefined(level.vision_set_fog[ToLower(ent.HDROverride)])) {
    ent = level.vision_set_fog[ToLower(ent.HDROverride)];
  }

  if(isDefined(ent) && isDefined(ent.name)) {
    ent.startDist = level.fognearplane;
    ent.halfwayDist = level.fogexphalfplane;
    ent.red = level.fogcolor[0];
    ent.green = level.fogcolor[1];
    ent.blue = level.fogcolor[2];
    ent.HDRColorIntensity = level.fogHDRColorIntensity;
    ent.maxOpacity = level.fogmaxopacity;
    ent.sunFogEnabled = level.sunFogEnabled;
    ent.sunRed = level.sunFogColor[0];
    ent.sunGreen = level.sunFogColor[1];
    ent.sunBlue = level.sunFogColor[2];
    ent.HDRSunColorIntensity = level.sunFogHDRColorIntensity;
    ent.sunDir = level.sunFogDir;
    ent.sunBeginFadeAngle = level.sunFogBeginFadeAngle;
    ent.sunEndFadeAngle = level.sunFogEndFadeAngle;
    ent.normalFogScale = level.sunFogScale;
    ent.skyFogIntensity = level.skyFogIntensity;
    ent.skyFogMinAngle = level.skyFogMinAngle;
    ent.skyFogMaxAngle = level.skyFogMaxAngle;

    if(isDefined(level.heightFogEnabled) && isDefined(level.heightFogBaseHeight) && isDefined(level.heightFogHalfPlaneDistance)) {
      ent.heightFogEnabled = level.heightFogEnabled;
      ent.heightFogBaseHeight = level.heightFogBaseHeight;
      ent.heightFogHalfPlaneDistance = level.heightFogHalfPlaneDistance;
    } else {
      ent.heightFogEnabled = 0;
      ent.heightFogBaseHeight = 0;
      ent.heightFogHalfPlaneDistance = 1000;
    }

    if(isDefined(level.atmosFogEnabled)) {
      Assert(isDefined(level.atmosFogSunFogColor));
      Assert(isDefined(level.atmosFogHazeColor));
      Assert(isDefined(level.atmosFogHazeStrength));
      Assert(isDefined(level.atmosFogHazeSpread));
      Assert(isDefined(level.atmosFogExtinctionStrength));
      Assert(isDefined(level.atmosFogInScatterStrength));
      Assert(isDefined(level.atmosFogHalfPlaneDistance));
      Assert(isDefined(level.atmosFogStartDistance));
      Assert(isDefined(level.atmosFogDistanceScale));
      Assert(isDefined(level.atmosFogSkyDistance));
      Assert(isDefined(level.atmosFogSkyAngularFalloffEnabled));
      Assert(isDefined(level.atmosFogSkyFalloffStartAngle));
      Assert(isDefined(level.atmosFogSkyFalloffAngleRange));
      Assert(isDefined(level.atmosFogSunDirection));
      Assert(isDefined(level.atmosFogHeightFogEnabled));
      Assert(isDefined(level.atmosFogHeightFogBaseHeight));
      Assert(isDefined(level.atmosFogHeightFogHalfPlaneDistance));

      ent.atmosFogEnabled = level.atmosFogEnabled;
      ent.atmosFogSunFogColor = level.atmosFogSunFogColor;
      ent.atmosFogHazeColor = level.atmosFogHazeColor;
      ent.atmosFogHazeStrength = level.atmosFogHazeStrength;
      ent.atmosFogHazeSpread = level.atmosFogHazeSpread;
      ent.atmosFogExtinctionStrength = level.atmosFogExtinctionStrength;
      ent.atmosFogInScatterStrength = level.atmosFogInScatterStrength;
      ent.atmosFogHalfPlaneDistance = level.atmosFogHalfPlaneDistance;
      ent.atmosFogStartDistance = level.atmosFogStartDistance;
      ent.atmosFogDistanceScale = level.atmosFogDistanceScale;
      ent.atmosFogSkyDistance = level.atmosFogSkyDistance;
      ent.atmosFogSkyAngularFalloffEnabled = level.atmosFogSkyAngularFalloffEnabled;
      ent.atmosFogSkyFalloffStartAngle = level.atmosFogSkyFalloffStartAngle;
      ent.atmosFogSkyFalloffAngleRange = level.atmosFogSkyFalloffAngleRange;
      ent.atmosFogSunDirection = level.atmosFogSunDirection;
      ent.atmosFogHeightFogEnabled = level.atmosFogHeightFogEnabled;
      ent.atmosFogHeightFogBaseHeight = level.atmosFogHeightFogBaseHeight;
      ent.atmosFogHeightFogHalfPlaneDistance = level.atmosFogHeightFogHalfPlaneDistance;
    } else {
      if(isDefined(ent.atmosFogEnabled)) {
        ent.atmosFogEnabled = 0;
      }
    }

    if(GetDvarInt("scr_fog_disable")) {
      ent.startDist = 2000000000;
      ent.halfwayDist = 2000000001;
      ent.red = 0;
      ent.green = 0;
      ent.blue = 0;
      ent.HDRColorIntensity = 1;
      ent.HDRSunColorIntensity = 1;
      ent.maxOpacity = 0;
      ent.skyFogIntensity = 0;
      ent.heightFogEnabled = 0;
      ent.heightFogBaseHeight = 0;
      ent.heightFogHalfPlaneDistance = 1000;

      if(isDefined(ent.atmosFogEnabled)) {
        ent.atmosFogEnabled = 0;
      }
    }

    set_fog_to_ent_values(ent, 0);
  }
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

  fileprint_launcher( "r_glow \"" + getDvar( "r_glowTweakEnable" ) + "\"" );
  fileprint_launcher( "r_glowRadius0\"" + getDvar( "r_glowTweakRadius0" ) + "\"" );
  fileprint_launcher( "r_glowBloomPinch \"" + getDvar( "r_glowTweakBloomPinch" ) + "\"" );
  fileprint_launcher( "r_glowBloomCutoff\"" + getDvar( "r_glowTweakBloomCutoff" ) + "\"" );
  fileprint_launcher( "r_glowBloomDesaturation\"" + getDvar( "r_glowTweakBloomDesaturation" ) + "\"" );
  fileprint_launcher( "r_glowBloomIntensity0\"" + getDvar( "r_glowTweakBloomIntensity0" ) + "\"" );
  fileprint_launcher( "r_glowUseAltCutoff \"" + getDvar( "r_glowTweakUseAltCutoff" ) + "\"" );
  fileprint_launcher( "" );

  fileprint_launcher( "r_filmEnable\"" + getDvar( "r_filmTweakEnable" ) + "\"" );
  fileprint_launcher( "r_filmContrast\"" + getDvar( "r_filmTweakContrast" ) + "\"" );
  if(level.currentgen) {
    fileprint_launcher( "r_filmIntensity \"" + getDvar( "r_filmTweakIntensity" ) + "\"" );
  }
  fileprint_launcher( "r_filmBrightness\"" + getDvar( "r_filmTweakBrightness" ) + "\"" );
  fileprint_launcher( "r_filmDesaturation\"" + getDvar( "r_filmTweakDesaturation" ) + "\"" );
  fileprint_launcher( "r_filmDesaturationDark\"" + getDvar( "r_filmTweakDesaturationDark" ) + "\"" );
  fileprint_launcher( "r_filmInvert\"" + getDvar( "r_filmTweakInvert" ) + "\"" );
  fileprint_launcher( "r_filmLightTint \"" + getDvar( "r_filmTweakLightTint" ) + "\"" );
  fileprint_launcher( "r_filmMediumTint\"" + getDvar( "r_filmTweakMediumTint" ) + "\"" );
  fileprint_launcher( "r_filmDarkTint\"" + getDvar( "r_filmTweakDarkTint" ) + "\"" );
  fileprint_launcher( " " );

  fileprint_launcher( "r_primaryLightUseTweaks\"" + getDvar( "r_primaryLightUseTweaks" ) + "\"" );
  fileprint_launcher( "r_primaryLightTweakDiffuseStrength \"" + getDvar( "r_primaryLightTweakDiffuseStrength" ) + "\"" );
  fileprint_launcher( "r_primaryLightTweakSpecularStrength\"" + getDvar( "r_primaryLightTweakSpecularStrength" ) + "\"" );
  fileprint_launcher( "r_charLightAmbient \"" + getDvar( "r_charLightAmbient" ) + "\"" );
  fileprint_launcher( " " );

  fileprint_launcher( "r_viewModelPrimaryLightUseTweaks\"" + getDvar( "r_viewModelPrimaryLightUseTweaks" ) + "\"" );
  fileprint_launcher( "r_viewModelPrimaryLightTweakDiffuseStrength \"" + getDvar( "r_viewModelPrimaryLightTweakDiffuseStrength" ) + "\"" );
  fileprint_launcher( "r_viewModelPrimaryLightTweakSpecularStrength\"" + getDvar( "r_viewModelPrimaryLightTweakSpecularStrength" ) + "\"" );
  fileprint_launcher( "r_viewModelLightAmbient \"" + getDvar( "r_viewModelLightAmbient" ) + "\"" );
  fileprint_launcher( " " );

  fileprint_launcher( "r_volumeLightScatter \"" + getDvar( "r_volumeLightScatterUseTweaks" ) + "\"" );
  fileprint_launcher( "r_volumeLightScatterLinearAtten\"" + getDvar( "r_volumeLightScatterLinearAtten" ) + "\"" );
  fileprint_launcher( "r_volumeLightScatterQuadraticAtten \"" + getDvar( "r_volumeLightScatterQuadraticAtten" ) + "\"" );
  fileprint_launcher( "r_volumeLightScatterAngularAtten \"" + getDvar( "r_volumeLightScatterAngularAtten" ) + "\"" );
  fileprint_launcher( "r_volumeLightScatterDepthAttenNear \"" + getDvar( "r_volumeLightScatterDepthAttenNear" ) + "\"" );
  fileprint_launcher( "r_volumeLightScatterDepthAttenFar\"" + getDvar( "r_volumeLightScatterDepthAttenFar" ) + "\"" );
  fileprint_launcher( "r_volumeLightScatterBackgroundDistance \"" + getDvar( "r_volumeLightScatterBackgroundDistance" ) + "\"" );
  fileprint_launcher( "r_volumeLightScatterColor\"" + getDvar( "r_volumeLightScatterColor" ) + "\"" );
  fileprint_launcher( "r_volumeLightScatterEv \"" + getDvar( "r_volumeLightScatterEv" ) + "\"" );
  fileprint_launcher( " " );

  fileprint_launcher( "r_rimLightUseTweaks \"" + getDvar( "r_rimLightUseTweaks" ) + "\"" );
  fileprint_launcher( "r_rimLight0Pitch\"" + getDvar( "r_rimLight0Pitch" ) + "\"" );
  fileprint_launcher( "r_rimLight0Heading\"" + getDvar( "r_rimLight0Heading" ) + "\"" );
  fileprint_launcher( "r_rimLightDiffuseIntensity\"" + getDvar( "r_rimLightDiffuseIntensity" ) + "\"" );
  fileprint_launcher( "r_rimLightSpecIntensity \"" + getDvar( "r_rimLightSpecIntensity" ) + "\"" );
  fileprint_launcher( "r_rimLightBias\"" + getDvar( "r_rimLightBias" ) + "\"" );
  fileprint_launcher( "r_rimLightPower \"" + getDvar( "r_rimLightPower" ) + "\"" );
  fileprint_launcher( "r_rimLight0Color\"" + getDvar( "r_rimLight0Color" ) + "\"" );
  fileprint_launcher( "r_rimLightFalloffMaxDistance\"" + getDvar( "r_rimLightFalloffMaxDistance" ) + "\"" );
  fileprint_launcher( "r_rimLightFalloffMinDistance\"" + getDvar( "r_rimLightFalloffMinDistance" ) + "\"" );
  fileprint_launcher( "r_rimLightFalloffMinIntensity \"" + getDvar( "r_rimLightFalloffMinIntensity" ) + "\"" );
  fileprint_launcher( " " );

  fileprint_launcher( "r_unlitSurfaceHDRScalar \"" + getDvar( "r_unlitSurfaceHDRScalar" ) + "\"" );
  fileprint_launcher( "" );

  fileprint_launcher( "r_chromaticAberrationMode \"" + getDvar( "r_chromaticAberration" ) + "\"" );
  fileprint_launcher( "r_chromaticSeparation \"" + getDvar( "r_chromaticSeparationR" ) + " " + getDvar( "r_chromaticSeparationG" ) + " " + getDvar( "r_chromaticSeparationB" ) + "\"" );
  fileprint_launcher( "r_chromaticAberrationAlpha \"" + getDvar( "r_chromaticAberrationAlpha" ) + "\"" );

  visionFileName = "\\share\\raw\\vision\\" + vision_set + ".vision";

  return fileprint_launcher_end_file( visionFileName, true );
}

get_lightset_filename() {
  if(level.nextgen) {
    return "\\share\\raw\\maps\\createart\\" + get_template_level() + "_lightsets_hdr.csv";
  } else {
    return "\\share\\raw\\maps\\createart\\" + get_template_level() + "_lightsets.csv";
  }
}

print_lightset(lightset_filename) {
  fileprint_launcher_start_file();

  PrintLightSetSettings();

  return fileprint_launcher_end_file( lightset_filename, true );
}

print_fog_ents(forMP) {
  foreach(ent in level.vision_set_fog) {
    if(!isDefined(ent.name)) {
      continue;
    }

    ConvertLegacyFog(ent);

    if(forMP) {
      fileprint_launcher( "\tent = maps\\mp\\_art::create_vision_set_fog( \"" + ent.name + "\" );");
    } else {
      fileprint_launcher( "\tent = maps\\_utility::create_vision_set_fog( \"" + ent.name + "\" );");
    }

    if(isDefined(ent.startDist)) {
      fileprint_launcher( "\tent.startDist = "+ent.startDist + ";" );
    }
    if(isDefined(ent.halfwayDist)) {
      fileprint_launcher( "\tent.halfwayDist = "+ent.halfwayDist + ";" );
    }
    if(isDefined(ent.red)) {
      fileprint_launcher( "\tent.red = "+ent.red + ";" );
    }
    if(isDefined(ent.green)) {
      fileprint_launcher( "\tent.green = "+ent.green + ";" );
    }
    if(isDefined(ent.blue)) {
      fileprint_launcher( "\tent.blue = "+ent.blue + ";" );
    }
    if(isDefined(ent.HDRColorIntensity)) {
      fileprint_launcher( "\tent.HDRColorIntensity = "+ent.HDRColorIntensity + ";" );
    }
    if(isDefined(ent.maxOpacity)) {
      fileprint_launcher( "\tent.maxOpacity = "+ent.maxOpacity + ";" );
    }
    if(isDefined(ent.transitionTime)) {
      fileprint_launcher( "\tent.transitionTime = "+ent.transitionTime + ";" );
    }
    if(isDefined(ent.sunFogEnabled)) {
      fileprint_launcher( "\tent.sunFogEnabled = "+ent.sunFogEnabled + ";" );
    }
    if(isDefined(ent.sunRed)) {
      fileprint_launcher( "\tent.sunRed = "+ent.sunRed + ";" );
    }
    if(isDefined(ent.sunGreen)) {
      fileprint_launcher( "\tent.sunGreen = "+ent.sunGreen + ";" );
    }
    if(isDefined(ent.sunBlue)) {
      fileprint_launcher( "\tent.sunBlue = "+ent.sunBlue + ";" );
    }
    if(isDefined(ent.HDRSunColorIntensity)) {
      fileprint_launcher( "\tent.HDRSunColorIntensity = "+ent.HDRSunColorIntensity + ";" );
    }
    if(isDefined(ent.sunDir)) {
      fileprint_launcher( "\tent.sunDir = "+ent.sunDir + ";" );
    }
    if(isDefined(ent.sunBeginFadeAngle)) {
      fileprint_launcher( "\tent.sunBeginFadeAngle = "+ent.sunBeginFadeAngle + ";" );
    }
    if(isDefined(ent.sunEndFadeAngle)) {
      fileprint_launcher( "\tent.sunEndFadeAngle = "+ent.sunEndFadeAngle + ";" );
    }
    if(isDefined(ent.normalFogScale)) {
      fileprint_launcher( "\tent.normalFogScale = "+ent.normalFogScale + ";" );
    }
    if(isDefined(ent.skyFogIntensity)) {
      fileprint_launcher( "\tent.skyFogIntensity = "+ent.skyFogIntensity + ";" );
    }
    if(isDefined(ent.skyFogMinAngle)) {
      fileprint_launcher( "\tent.skyFogMinAngle = "+ent.skyFogMinAngle + ";" );
    }
    if(isDefined(ent.skyFogMaxAngle)) {
      fileprint_launcher( "\tent.skyFogMaxAngle = "+ent.skyFogMaxAngle + ";" );
    }
    if(isDefined(ent.HDROverride)) {
      fileprint_launcher( "\tent.HDROverride = \"" + ent.HDROverride + "\";" );
    }
    if(isDefined(ent.heightFogEnabled)) {
      fileprint_launcher( "\tent.heightFogEnabled = " + ent.heightFogEnabled + ";" );
    }
    if(isDefined(ent.heightFogBaseHeight)) {
      fileprint_launcher( "\tent.heightFogBaseHeight = " + ent.heightFogBaseHeight + ";" );
    }
    if(isDefined(ent.heightFogHalfPlaneDistance)) {
      fileprint_launcher( "\tent.heightFogHalfPlaneDistance = " + ent.heightFogHalfPlaneDistance + ";" );
    }

    if(isDefined(ent.atmosFogEnabled)) {
      fileprint_launcher( "\tent.atmosFogEnabled = " + ent.atmosFogEnabled + ";" );
    }
    if(isDefined(ent.atmosFogSunFogColor)) {
      fileprint_launcher( "\tent.atmosFogSunFogColor = " + ent.atmosFogSunFogColor + ";" );
    }
    if(isDefined(ent.atmosFogHazeColor)) {
      fileprint_launcher( "\tent.atmosFogHazeColor = " + ent.atmosFogHazeColor + ";" );
    }
    if(isDefined(ent.atmosFogHazeStrength)) {
      fileprint_launcher( "\tent.atmosFogHazeStrength = " + ent.atmosFogHazeStrength + ";" );
    }
    if(isDefined(ent.atmosFogHazeSpread)) {
      fileprint_launcher( "\tent.atmosFogHazeSpread = " + ent.atmosFogHazeSpread + ";" );
    }
    if(isDefined(ent.atmosFogExtinctionStrength)) {
      fileprint_launcher( "\tent.atmosFogExtinctionStrength = " + ent.atmosFogExtinctionStrength + ";" );
    }
    if(isDefined(ent.atmosFogInScatterStrength)) {
      fileprint_launcher( "\tent.atmosFogInScatterStrength = " + ent.atmosFogInScatterStrength + ";" );
    }
    if(isDefined(ent.atmosFogHalfPlaneDistance)) {
      fileprint_launcher( "\tent.atmosFogHalfPlaneDistance = " + ent.atmosFogHalfPlaneDistance + ";" );
    }
    if(isDefined(ent.atmosFogStartDistance)) {
      fileprint_launcher( "\tent.atmosFogStartDistance = " + ent.atmosFogStartDistance + ";" );
    }
    if(isDefined(ent.atmosFogDistanceScale)) {
      fileprint_launcher( "\tent.atmosFogDistanceScale = " + ent.atmosFogDistanceScale + ";" );
    }
    if(isDefined(ent.atmosFogSkyDistance)) {
      fileprint_launcher( "\tent.atmosFogSkyDistance = " + int( ent.atmosFogSkyDistance ) + ";" );
    }
    if(isDefined(ent.atmosFogSkyAngularFalloffEnabled)) {
      fileprint_launcher( "\tent.atmosFogSkyAngularFalloffEnabled = " + ent.atmosFogSkyAngularFalloffEnabled + ";" );
    }
    if(isDefined(ent.atmosFogSkyFalloffStartAngle)) {
      fileprint_launcher( "\tent.atmosFogSkyFalloffStartAngle = " + ent.atmosFogSkyFalloffStartAngle + ";" );
    }
    if(isDefined(ent.atmosFogSkyFalloffAngleRange)) {
      fileprint_launcher( "\tent.atmosFogSkyFalloffAngleRange = " + ent.atmosFogSkyFalloffAngleRange + ";" );
    }
    if(isDefined(ent.atmosFogSunDirection)) {
      fileprint_launcher( "\tent.atmosFogSunDirection = " + ent.atmosFogSunDirection + ";" );
    }
    if(isDefined(ent.atmosFogHeightFogEnabled)) {
      fileprint_launcher( "\tent.atmosFogHeightFogEnabled = " + ent.atmosFogHeightFogEnabled + ";" );
    }
    if(isDefined(ent.atmosFogHeightFogBaseHeight)) {
      fileprint_launcher( "\tent.atmosFogHeightFogBaseHeight = " + ent.atmosFogHeightFogBaseHeight + ";" );
    }
    if(isDefined(ent.atmosFogHeightFogHalfPlaneDistance)) {
      fileprint_launcher( "\tent.atmosFogHeightFogHalfPlaneDistance = " + ent.atmosFogHeightFogHalfPlaneDistance + ";" );
    }

    if(isDefined(ent.stagedVisionSets)) {
      string = " ";
      for(i = 0; i < ent.stagedVisionSets.size; i++) {
        string = string + "\"" + ent.stagedVisionSets[i] + "\"";
        if(i < ent.stagedVisionSets.size - 1) {
          string = string + ",";
        }
        string = string + " ";
      }

      fileprint_launcher( "\tent.stagedVisionSets = [" + string + "];" );
    }

    fileprint_launcher ( " " );
  }

  if(!forMP) {
    fileprint_launcher( "\t/$" );
    if(IsUsingHDR()) {
      fileprint_launcher( "\tlevel._art_fog_setup = maps\\createart\\" + level.script + "_fog_hdr::main;" );
    } else {
      fileprint_launcher( "\tlevel._art_fog_setup = maps\\createart\\" + level.script + "_fog::main;" );
    }
    fileprint_launcher( "\t$/" );
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

    if(!targettedByHDROverride) {
      fileprint_launcher( "rawfile,vision/"+ent.name+".vision");
    }
  }
}
$ /