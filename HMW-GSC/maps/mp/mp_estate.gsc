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

  setdvar("r_specularcolorscale", "1.17");
  setdvar("compassmaxrange", "3500");
  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.3);
  setdvar("r_lightGridContrast", 0);

  setdvar("r_tessellation", 0);
  setdvar("r_lodBiasRigid", -2000);
  setdvar("r_lodBiasSkinned", -2000);
  setdvar("r_drawSun", 0);
  setdvar("r_umbra", 1);
  setdvar("r_fog", 1);
  setdvar("r_filmusetweaks", 0);
  setdvar("r_smodelinstancedthreshold", 0);

  setdvar("r_primaryLightUseTweaks", 1);
  setdvar("r_primaryLightTweakDiffuseStrength", 2.06);
  setdvar("r_primaryLightTweakSpecularStrength", 1);

  setdvar("r_viewModelPrimaryLightUseTweaks", 1);
  setdvar("r_viewModelPrimaryLightTweakDiffuseStrength", 2.06);
  setdvar("r_viewModelPrimaryLightTweakSpecularStrength", 1);

  setdvar("r_colorScaleUseTweaks", 1);
  setdvar("r_diffuseColorScale", 2.85);
  setdvar("r_specularColorScale", 1.17);

  setdvar("r_veil", 1);
  setdvar("r_veilusetweaks", 1);
  setdvar("r_veilStrength", 0.167);
  setdvar("r_veilBackgroundStrength", 0.853);

  if(level.ps3) {
    setdvar("sm_sunShadowScale", "0.5"); // ps3 optimization
  } else {
    setdvar("sm_sunShadowScale", "0.7"); // optimization
  }
}