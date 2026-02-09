main() {
  maps\mp\mp_subbase_precache::main();
  maps\createart\mp_subbase_art::main();
  maps\createart\mp_subbase_fog::main();
  maps\createart\mp_subbase_fog_hdr::main();
  maps\mp\mp_subbase_fx::main();
  maps\mp\_load::main();

  maps\mp\_compass::setupMiniMap("compass_map_mp_subbase");

  ambientPlay("ambient_mp_snow");

  game["defenders"] = "axis";
  game["attackers"] = "allies";

  setDvar("r_specularcolorscale", "2.9");
  setDvar("compassmaxrange", "2500");
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 2);
  setDvar("r_lodBiasRigid", -2000);
  setDvar("r_lodBiasSkinned", -2000);
  setDvar("r_drawSun", 0);
  setDvar("r_umbra", 1);
  setDvar("r_fog", 1);
  setDvar("r_filmusetweaks", 0);
  setDvar("r_tessellation", 0);
  setDvar("r_smodelinstancedthreshold", 0);

  setDvar("r_primaryLightUseTweaks", 1);
  setDvar("r_primaryLightTweakDiffuseStrength", 0.41);
  setDvar("r_primaryLightTweakSpecularStrength", 0.96);

  setDvar("r_viewModelPrimaryLightUseTweaks", 1);
  setDvar("r_viewModelPrimaryLightTweakDiffuseStrength", 0.41);
  setDvar("r_viewModelPrimaryLightTweakSpecularStrength", 0.96);

  setDvar("r_colorScaleUseTweaks", 1);
  setDvar("r_diffuseColorScale", 0.5);
  setDvar("r_specularColorScale", 3.51);

  setDvar("r_veil", 1);
  setDvar("r_veilusetweaks", 1);
  setDvar("r_veilStrength", 0.42);
  setDvar("r_veilBackgroundStrength", 0.56);
}