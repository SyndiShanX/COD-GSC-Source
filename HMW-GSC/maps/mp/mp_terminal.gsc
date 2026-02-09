main() {
  maps\mp\mp_terminal_precache::main();
  maps\createart\mp_terminal_art::main();
  maps\mp\mp_terminal_fx::main();
  maps\mp\_explosive_barrels::main();
  maps\mp\_load::main();
  common_scripts\_destructible::init();
  thread common_scripts\_dynamic_world::init();

  maps\mp\_compass::setupMiniMap("compass_map_mp_terminal");
  setDvar("compassmaxrange", "2000");

  ambientPlay("ambient_mp_airport");

  VisionSetNaked("mp_terminal");

  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.22);
  setDvar("r_lightGridContrast", .6);

  setDvar("r_tessellation", 0);
  setDvar("r_lodBiasRigid", -2000);
  setDvar("r_lodBiasSkinned", -2000);
  setDvar("r_drawSun", 0);
  setDvar("r_umbra", 1);
  setDvar("r_fog", 1);
  setDvar("r_filmusetweaks", 0);
  setDvar("r_smodelinstancedthreshold", 0);

  setDvar("r_primaryLightUseTweaks", 1);
  setDvar("r_primaryLightTweakDiffuseStrength", 3);
  setDvar("r_primaryLightTweakSpecularStrength", 1);

  setDvar("r_viewModelPrimaryLightUseTweaks", 1);
  setDvar("r_viewModelPrimaryLightTweakDiffuseStrength", 3);
  setDvar("r_viewModelPrimaryLightTweakSpecularStrength", 1);

  setDvar("r_colorScaleUseTweaks", 1);
  setDvar("r_diffuseColorScale", 1.95);
  setDvar("r_specularColorScale", 1.06);

  setDvar("r_veil", 1);
  setDvar("r_veilusetweaks", 1);
  setDvar("r_veilStrength", 0.06);
  setDvar("r_veilBackgroundStrength", 0.85);

  game["attackers"] = "allies";
  game["defenders"] = "axis";
}