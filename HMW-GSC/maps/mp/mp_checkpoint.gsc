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

  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.27);
  setdvar("r_lightGridContrast", 1);

  setdvar("r_tessellation", 0);
  setdvar("r_lodBiasRigid", -2000);
  setdvar("r_lodBiasSkinned", -2000);
  setdvar("r_drawSun", 0);
  setdvar("r_umbra", 1);
  setdvar("r_fog", 1);
  setdvar("r_filmusetweaks", 0);
  setdvar("r_smodelinstancedthreshold", 0);

  setdvar("r_specularcolorscale", "2");

  setdvar("compassmaxrange", "1600");

  setdvar("r_primaryLightUseTweaks", 1);
  setdvar("r_primaryLightTweakDiffuseStrength", 0.68);
  setdvar("r_primaryLightTweakSpecularStrength", 3.62);

  setdvar("r_viewModelPrimaryLightUseTweaks", 1);
  setdvar("r_viewModelPrimaryLightTweakDiffuseStrength", 0.68);
  setdvar("r_viewModelPrimaryLightTweakSpecularStrength", 3.62);

  setdvar("r_colorScaleUseTweaks", 1);
  setdvar("r_diffuseColorScale", 2.46);
  setdvar("r_specularColorScale", 2.27);

  setdvar("r_veil", 1);
  setdvar("r_veilusetweaks", 1);
  setdvar("r_veilStrength", 0.247);
  setdvar("r_veilBackgroundStrength", 0.780);
}