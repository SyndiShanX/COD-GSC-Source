main() {
  maps\mp\mp_terminal_precache::main();
  maps\createart\mp_terminal_art::main();
  maps\mp\mp_terminal_fx::main();
  maps\mp\_explosive_barrels::main();
  maps\mp\_load::main();
  common_scripts\_destructible::init();
  thread common_scripts\_dynamic_world::init();

  maps\mp\_compass::setupMiniMap("compass_map_mp_terminal");
  setdvar("compassmaxrange", "2000");

  ambientPlay("ambient_mp_airport");

  VisionSetNaked("mp_terminal");

  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.22);
  setdvar("r_lightGridContrast", .6);

  setdvar("r_tessellation", 0);
  setdvar("r_lodBiasRigid", -2000);
  setdvar("r_lodBiasSkinned", -2000);
  setdvar("r_drawSun", 0);
  setdvar("r_umbra", 1);
  setdvar("r_fog", 1);
  setdvar("r_filmusetweaks", 0);
  setdvar("r_smodelinstancedthreshold", 0);

  setdvar("r_primaryLightUseTweaks", 1);
  setdvar("r_primaryLightTweakDiffuseStrength", 3);
  setdvar("r_primaryLightTweakSpecularStrength", 1);

  setdvar("r_viewModelPrimaryLightUseTweaks", 1);
  setdvar("r_viewModelPrimaryLightTweakDiffuseStrength", 3);
  setdvar("r_viewModelPrimaryLightTweakSpecularStrength", 1);

  setdvar("r_colorScaleUseTweaks", 1);
  setdvar("r_diffuseColorScale", 1.95);
  setdvar("r_specularColorScale", 1.06);

  setdvar("r_veil", 1);
  setdvar("r_veilusetweaks", 1);
  setdvar("r_veilStrength", 0.06);
  setdvar("r_veilBackgroundStrength", 0.85);

  game["attackers"] = "allies";
  game["defenders"] = "axis";
}