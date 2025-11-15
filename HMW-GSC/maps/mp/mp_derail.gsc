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

  setdvar("r_specularcolorscale", "2.3");
  setdvar("compassmaxrange", "4000");
  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1);
  setdvar("r_lightGridContrast", .4);
  setdvar("r_fog", 1);
  setdvar("r_drawsun", 0);
  setdvar("r_tessellation", 0);
  setdvar("r_lodBiasRigid", -2000);
  setdvar("r_lodBiasSkinned", -2000);
  setdvar("r_umbra", 1);
  setdvar("r_filmusetweaks", 0);
  setdvar("r_smodelinstancedthreshold", 0);

  setdvar("r_primaryLightUseTweaks", 1);
  setdvar("r_primaryLightTweakDiffuseStrength", 1.44);
  setdvar("r_primaryLightTweakSpecularStrength", 1.98);

  setdvar("r_viewModelPrimaryLightUseTweaks", 1);
  setdvar("r_viewModelPrimaryLightTweakDiffuseStrength", 1.44);
  setdvar("r_viewModelPrimaryLightTweakSpecularStrength", 1.98);

  setdvar("r_colorScaleUseTweaks", 1);
  setdvar("r_diffuseColorScale", 1.5);
  setdvar("r_specularColorScale", 2.3);

  setdvar("r_veil", 1);
  setdvar("r_veilusetweaks", 1);
  setdvar("r_veilStrength", 0.3);
  setdvar("r_veilBackgroundStrength", 0.97);
}