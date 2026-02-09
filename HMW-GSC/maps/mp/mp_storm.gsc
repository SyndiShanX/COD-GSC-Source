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

  setDvar("r_specularcolorscale", "1.5");
  setDvar("compassmaxrange", "2300");
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.3);
  //setDvar( "r_lightGridContrast", .5 );

  setDvar("r_tessellation", 0);
  setDvar("r_lodBiasRigid", -2000);
  setDvar("r_lodBiasSkinned", -2000);
  setDvar("r_drawSun", 0);
  setDvar("r_umbra", 1);
  setDvar("r_fog", 1);
  setDvar("r_filmusetweaks", 0);
  setDvar("r_smodelinstancedthreshold", 0);

  setDvar("r_primaryLightUseTweaks", 1);
  setDvar("r_primaryLightTweakDiffuseStrength", 0.61);
  setDvar("r_primaryLightTweakSpecularStrength", 0.9);

  setDvar("r_viewModelPrimaryLightUseTweaks", 1);
  setDvar("r_viewModelPrimaryLightTweakDiffuseStrength", 0.21);
  setDvar("r_viewModelPrimaryLightTweakSpecularStrength", 0.9);

  setDvar("r_colorScaleUseTweaks", 1);
  setDvar("r_diffuseColorScale", 1.04);
  setDvar("r_specularColorScale", 3.19);

  setDvar("r_veil", 1);
  setDvar("r_veilusetweaks", 1);
  setDvar("r_veilStrength", 0.357);
  setDvar("r_veilBackgroundStrength", 0.973);
}