main() {
  maps\mp\mp_invasion_precache::main();
  maps\createart\mp_invasion_art::main();
  maps\createart\mp_invasion_fog::main();
  maps\createart\mp_invasion_fog_hdr::main();
  maps\mp\mp_invasion_fx::main();
  maps\mp\_load::main();
  common_scripts\_destructible::init();

  maps\mp\_compass::setupMiniMap("compass_map_mp_invasion");

  // raise up planes to avoid them flying through buildings
  level.airstrikeHeightScale = 1.5;

  ambientPlay("ambient_mp_urban");

  game["attackers"] = "axis";
  game["defenders"] = "allies";

  setDvar("r_specularcolorscale", "2.5");
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.25);
  setDvar("r_lightGridContrast", .5);
  setDvar("compassmaxrange", "2500");

  setDvar("r_tessellation", 0);
  setDvar("r_lodBiasRigid", -2000);
  setDvar("r_lodBiasSkinned", -2000);
  setDvar("r_drawSun", 0);
  setDvar("r_umbra", 1);
  setDvar("r_fog", 1);
  setDvar("r_filmusetweaks", 0);
  setDvar("r_smodelinstancedthreshold", 0);

  setDvar("r_primaryLightUseTweaks", 1);
  setDvar("r_primaryLightTweakDiffuseStrength", 3.93);
  setDvar("r_primaryLightTweakSpecularStrength", 1.62);

  setDvar("r_viewModelPrimaryLightUseTweaks", 1);
  setDvar("r_viewModelPrimaryLightTweakDiffuseStrength", 3.93);
  setDvar("r_viewModelPrimaryLightTweakSpecularStrength", 1.62);

  setDvar("r_colorScaleUseTweaks", 1);
  setDvar("r_diffuseColorScale", 2.2);
  setDvar("r_specularColorScale", 2.5);

  setDvar("r_veil", 1);
  setDvar("r_veilusetweaks", 1);
  setDvar("r_veilStrength", 0.27);
  setDvar("r_veilBackgroundStrength", 0.69);
}