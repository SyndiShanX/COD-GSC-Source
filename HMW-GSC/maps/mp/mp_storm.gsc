main() {
  maps\mp\mp_storm_precache::main();
  maps\mp\mp_storm_fx::main();
  maps\createart\mp_storm_art::main();
  maps\mp\_load::main();
  common_scripts\_destructible::init();

  maps\mp\_compass::setupMiniMap("compass_map_mp_storm");

  ambientPlay("ambient_mp_storm");

  game["attackers"] = "axis";
  game["defenders"] = "allies";

  setdvar("r_specularcolorscale", "1.5");
  setdvar("compassmaxrange", "2300");
  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.3);
  //setdvar( "r_lightGridContrast", .5 );

  setdvar("r_tessellation", 0);
  setdvar("r_lodBiasRigid", -2000);
  setdvar("r_lodBiasSkinned", -2000);
  setdvar("r_drawSun", 0);
  setdvar("r_umbra", 1);
  setdvar("r_fog", 1);
  setdvar("r_filmusetweaks", 0);
  setdvar("r_smodelinstancedthreshold", 0);

  setdvar("r_primaryLightUseTweaks", 1);
  setdvar("r_primaryLightTweakDiffuseStrength", 0.61);
  setdvar("r_primaryLightTweakSpecularStrength", 0.9);

  setdvar("r_viewModelPrimaryLightUseTweaks", 1);
  setdvar("r_viewModelPrimaryLightTweakDiffuseStrength", 0.21);
  setdvar("r_viewModelPrimaryLightTweakSpecularStrength", 0.9);

  setdvar("r_colorScaleUseTweaks", 1);
  setdvar("r_diffuseColorScale", 1.04);
  setdvar("r_specularColorScale", 3.19);

  setdvar("r_veil", 1);
  setdvar("r_veilusetweaks", 1);
  setdvar("r_veilStrength", 0.357);
  setdvar("r_veilBackgroundStrength", 0.973);
}