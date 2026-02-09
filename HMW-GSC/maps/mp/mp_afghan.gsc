main() {
  maps\mp\mp_afghan_precache::main();
  maps\createart\mp_afghan_art::main();
  maps\createart\mp_afghan_fog::main();
  maps\createart\mp_afghan_fog_hdr::main();
  maps\mp\mp_afghan_fx::main();
  maps\mp\_explosive_barrels::main();
  maps\mp\_load::main();
  common_scripts\_destructible::init();

  maps\mp\_compass::setupMiniMap("compass_map_mp_afghan");

  thread maps\mp\_animatedmodels::main();
  thread maps\mp\_radiation::radiation();

  setDvar("compassmaxrange", "3000");

  ambientPlay("ambient_mp_desert");

  game["attackers"] = "allies";
  game["defenders"] = "axis";

  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.2);
  setDvar("r_lightGridContrast", 0);
  setDvar("r_tessellation", 0);
  setDvar("r_lodBiasRigid", -2000);
  setDvar("r_lodBiasSkinned", -2000);
  setDvar("r_drawSun", 0);
  setDvar("r_umbra", 1);
  setDvar("r_fog", 1);
  setDvar("r_filmusetweaks", 0);
  setDvar("r_smodelinstancedthreshold", 0);

  setDvar("r_primaryLightUseTweaks", 1);
  setDvar("r_primaryLightTweakDiffuseStrength", 2.42);
  setDvar("r_primaryLightTweakSpecularStrength", 1.93);

  setDvar("r_viewModelPrimaryLightUseTweaks", 1);
  setDvar("r_viewModelPrimaryLightTweakDiffuseStrength", 2.42);
  setDvar("r_viewModelPrimaryLightTweakSpecularStrength", 1.93);

  setDvar("r_colorScaleUseTweaks", 1);
  setDvar("r_diffuseColorScale", 1.420);
  setDvar("r_specularColorScale", 0.490);

  setDvar("r_veil", 1);
  setDvar("r_veilusetweaks", 1);
  setDvar("r_veilStrength", 0.150);
  setDvar("r_veilBackgroundStrength", 1.2);
}