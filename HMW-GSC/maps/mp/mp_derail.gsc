main() {
  maps\mp\mp_derail_precache::main();
  maps\mp\mp_derail_fx::main();
  maps\createart\mp_derail_art::main();
  maps\createart\mp_derail_fog::main();
  maps\createart\mp_derail_fog_hdr::main();
  maps\mp\_load::main();

  maps\mp\_compass::setupMiniMap("compass_map_mp_derail");

  ambientPlay("ambient_mp_snow");

  game["attackers"] = "axis";
  game["defenders"] = "allies";

  setDvar("r_specularcolorscale", "2.3");
  setDvar("compassmaxrange", "4000");
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1);
  setDvar("r_lightGridContrast", .4);
  setDvar("r_fog", 1);
  setDvar("r_drawsun", 0);
  setDvar("r_tessellation", 0);
  setDvar("r_lodBiasRigid", -2000);
  setDvar("r_lodBiasSkinned", -2000);
  setDvar("r_umbra", 1);
  setDvar("r_filmusetweaks", 0);
  setDvar("r_smodelinstancedthreshold", 0);

  setDvar("r_primaryLightUseTweaks", 1);
  setDvar("r_primaryLightTweakDiffuseStrength", 1.44);
  setDvar("r_primaryLightTweakSpecularStrength", 1.98);

  setDvar("r_viewModelPrimaryLightUseTweaks", 1);
  setDvar("r_viewModelPrimaryLightTweakDiffuseStrength", 1.44);
  setDvar("r_viewModelPrimaryLightTweakSpecularStrength", 1.98);

  setDvar("r_colorScaleUseTweaks", 1);
  setDvar("r_diffuseColorScale", 1.5);
  setDvar("r_specularColorScale", 2.3);

  setDvar("r_veil", 1);
  setDvar("r_veilusetweaks", 1);
  setDvar("r_veilStrength", 0.3);
  setDvar("r_veilBackgroundStrength", 0.97);
}