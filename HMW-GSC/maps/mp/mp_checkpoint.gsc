main() {
  maps\mp\mp_checkpoint_precache::main();
  maps\createart\mp_checkpoint_art::main();
  maps\mp\mp_checkpoint_fx::main();
  maps\mp\_load::main();
  common_scripts\_destructible::init();

  maps\mp\_compass::setupMiniMap("compass_map_mp_checkpoint");

  // raise up planes to avoid them flying through buildings
  level.airstrikeHeightScale = 1.5;

  ambientPlay("ambient_mp_urban");

  game["attackers"] = "axis";
  game["defenders"] = "allies";

  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.27);
  setDvar("r_lightGridContrast", 1);

  setDvar("r_tessellation", 0);
  setDvar("r_lodBiasRigid", -2000);
  setDvar("r_lodBiasSkinned", -2000);
  setDvar("r_drawSun", 0);
  setDvar("r_umbra", 1);
  setDvar("r_fog", 1);
  setDvar("r_filmusetweaks", 0);
  setDvar("r_smodelinstancedthreshold", 0);

  setDvar("r_specularcolorscale", "2");

  setDvar("compassmaxrange", "1600");

  setDvar("r_primaryLightUseTweaks", 1);
  setDvar("r_primaryLightTweakDiffuseStrength", 0.68);
  setDvar("r_primaryLightTweakSpecularStrength", 3.62);

  setDvar("r_viewModelPrimaryLightUseTweaks", 1);
  setDvar("r_viewModelPrimaryLightTweakDiffuseStrength", 0.68);
  setDvar("r_viewModelPrimaryLightTweakSpecularStrength", 3.62);

  setDvar("r_colorScaleUseTweaks", 1);
  setDvar("r_diffuseColorScale", 2.46);
  setDvar("r_specularColorScale", 2.27);

  setDvar("r_veil", 1);
  setDvar("r_veilusetweaks", 1);
  setDvar("r_veilStrength", 0.247);
  setDvar("r_veilBackgroundStrength", 0.780);
}