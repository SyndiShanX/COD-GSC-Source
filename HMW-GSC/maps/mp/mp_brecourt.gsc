main() {

  maps\mp\mp_brecourt_precache::main();
  maps\mp\mp_brecourt_fx::main();
  maps\createart\mp_brecourt_art::main();
  maps\mp\_load::main();

  maps\mp\_compass::setupMiniMap("compass_map_mp_brecourt");

  ambientPlay("ambient_mp_rural");

  game["attackers"] = "allies";
  game["defenders"] = "axis";

  setdvar("r_specularcolorscale", "1");

  setdvar("compassmaxrange", "4000");

  setdvar("sm_sunShadowScale", 0.5);

  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.11);
  setdvar("r_lightGridContrast", .29);

  thread maps\mp\_radiation::radiation();

  setdvar("r_tessellation", 0);
  setdvar("r_lodBiasRigid", -2000);
  setdvar("r_lodBiasSkinned", -2000);
  setdvar("r_drawSun", 0);
  setdvar("r_umbra", 1);
  setdvar("r_fog", 1);
  setdvar("r_filmusetweaks", 0);
  setdvar("r_smodelinstancedthreshold", 0);

  setdvar("r_primaryLightUseTweaks", 1);
  setdvar("r_primaryLightTweakDiffuseStrength", 2.5);
  setdvar("r_primaryLightTweakSpecularStrength", 1);

  setdvar("r_viewModelPrimaryLightUseTweaks", 1);
  setdvar("r_viewModelPrimaryLightTweakDiffuseStrength", 2.5);
  setdvar("r_viewModelPrimaryLightTweakSpecularStrength", 1);

  setdvar("r_colorScaleUseTweaks", 1);
  setdvar("r_diffuseColorScale", 2.2);
  setdvar("r_specularColorScale", 0.5);

  setdvar("r_veil", 1);
  setdvar("r_veilusetweaks", 1);
  setdvar("r_veilStrength", 0.250);
  setdvar("r_veilBackgroundStrength", 0.780);
}