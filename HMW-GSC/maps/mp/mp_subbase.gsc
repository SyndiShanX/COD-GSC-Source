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

  setdvar("r_specularcolorscale", "2.9");
  setdvar("compassmaxrange", "2500");
  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 2);
  setdvar("r_lodBiasRigid", -2000);
  setdvar("r_lodBiasSkinned", -2000);
  setdvar("r_drawSun", 0);
  setdvar("r_umbra", 1);
  setdvar("r_fog", 1);
  setdvar("r_filmusetweaks", 0);
  setdvar("r_tessellation", 0);
  setdvar("r_smodelinstancedthreshold", 0);

  setdvar("r_primaryLightUseTweaks", 1);
  setdvar("r_primaryLightTweakDiffuseStrength", 0.41);
  setdvar("r_primaryLightTweakSpecularStrength", 0.96);

  setdvar("r_viewModelPrimaryLightUseTweaks", 1);
  setdvar("r_viewModelPrimaryLightTweakDiffuseStrength", 0.41);
  setdvar("r_viewModelPrimaryLightTweakSpecularStrength", 0.96);

  setdvar("r_colorScaleUseTweaks", 1);
  setdvar("r_diffuseColorScale", 0.5);
  setdvar("r_specularColorScale", 3.51);

  setdvar("r_veil", 1);
  setdvar("r_veilusetweaks", 1);
  setdvar("r_veilStrength", 0.42);
  setdvar("r_veilBackgroundStrength", 0.56);
}