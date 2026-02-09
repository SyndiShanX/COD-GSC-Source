main() {
  maps\mp\mp_brecourt_precache::main();
  maps\mp\mp_brecourt_fx::main();
  maps\createart\mp_brecourt_art::main();
  maps\mp\_load::main();

  maps\mp\_compass::setupMiniMap("compass_map_mp_brecourt");

  ambientPlay("ambient_mp_rural");

  game["attackers"] = "allies";
  game["defenders"] = "axis";

  setDvar("r_specularcolorscale", "1");

  setDvar("compassmaxrange", "4000");

  setDvar("sm_sunShadowScale", 0.5);

  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.11);
  setDvar("r_lightGridContrast", .29);

  thread maps\mp\_radiation::radiation();

  setDvar("r_tessellation", 0);
  setDvar("r_lodBiasRigid", -2000);
  setDvar("r_lodBiasSkinned", -2000);
  setDvar("r_drawSun", 0);
  setDvar("r_umbra", 1);
  setDvar("r_fog", 1);
  setDvar("r_filmusetweaks", 0);
  setDvar("r_smodelinstancedthreshold", 0);

  setDvar("r_primaryLightUseTweaks", 1);
  setDvar("r_primaryLightTweakDiffuseStrength", 2.5);
  setDvar("r_primaryLightTweakSpecularStrength", 1);

  setDvar("r_viewModelPrimaryLightUseTweaks", 1);
  setDvar("r_viewModelPrimaryLightTweakDiffuseStrength", 2.5);
  setDvar("r_viewModelPrimaryLightTweakSpecularStrength", 1);

  setDvar("r_colorScaleUseTweaks", 1);
  setDvar("r_diffuseColorScale", 2.2);
  setDvar("r_specularColorScale", 0.5);

  setDvar("r_veil", 1);
  setDvar("r_veilusetweaks", 1);
  setDvar("r_veilStrength", 0.250);
  setDvar("r_veilBackgroundStrength", 0.780);
}