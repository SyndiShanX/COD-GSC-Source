main() {
  maps\mp\mp_estate_precache::main();
  maps\createart\mp_estate_art::main();
  maps\createart\mp_estate_fog::main();
  maps\createart\mp_estate_fog_hdr::main();
  maps\mp\mp_estate_fx::main();
  maps\mp\_load::main();
  common_scripts\_destructible::init();

  maps\mp\_compass::setupMiniMap("compass_map_mp_estate");

  ambientPlay("ambient_mp_estate");

  game["attackers"] = "allies";
  game["defenders"] = "axis";

  setDvar("r_specularcolorscale", "1.17");
  setDvar("compassmaxrange", "3500");
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.3);
  setDvar("r_lightGridContrast", 0);

  setDvar("r_tessellation", 0);
  setDvar("r_lodBiasRigid", -2000);
  setDvar("r_lodBiasSkinned", -2000);
  setDvar("r_drawSun", 0);
  setDvar("r_umbra", 1);
  setDvar("r_fog", 1);
  setDvar("r_filmusetweaks", 0);
  setDvar("r_smodelinstancedthreshold", 0);

  setDvar("r_primaryLightUseTweaks", 1);
  setDvar("r_primaryLightTweakDiffuseStrength", 2.06);
  setDvar("r_primaryLightTweakSpecularStrength", 1);

  setDvar("r_viewModelPrimaryLightUseTweaks", 1);
  setDvar("r_viewModelPrimaryLightTweakDiffuseStrength", 2.06);
  setDvar("r_viewModelPrimaryLightTweakSpecularStrength", 1);

  setDvar("r_colorScaleUseTweaks", 1);
  setDvar("r_diffuseColorScale", 2.85);
  setDvar("r_specularColorScale", 1.17);

  setDvar("r_veil", 1);
  setDvar("r_veilusetweaks", 1);
  setDvar("r_veilStrength", 0.167);
  setDvar("r_veilBackgroundStrength", 0.853);

  if(level.ps3)
    setDvar("sm_sunShadowScale", "0.5"); // ps3 optimization
  else
    setDvar("sm_sunShadowScale", "0.7"); // optimization
}