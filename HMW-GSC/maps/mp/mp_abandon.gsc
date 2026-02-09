main() {
  maps\mp\mp_abandon_precache::main();
  maps\createart\mp_abandon_art::main();
  maps\createart\mp_abandon_fog::main();
  maps\createart\mp_abandon_fog_hdr::main();
  maps\mp\mp_abandon_fx::main();
  common_scripts\_destructible::init();
  //common_scripts\_destructible_dlc::main();

  //maps\mp\_destructible_dlc2::main(); // call before _load
  //maps\mp\_destructible_dlc::main(); // call before _load
  maps\mp\_load::main();

  ambientPlay("ambient_mp_abandon");

  maps\mp\_compass::setupMiniMap("compass_map_mp_abandon");

  setDvar("r_specularcolorscale", "2.5");
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.452);
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
  setDvar("r_primaryLightTweakDiffuseStrength", 2);
  setDvar("r_primaryLightTweakSpecularStrength", 1);

  setDvar("r_viewModelPrimaryLightUseTweaks", 1);
  setDvar("r_viewModelPrimaryLightTweakDiffuseStrength", 2);
  setDvar("r_viewModelPrimaryLightTweakSpecularStrength", 1);

  setDvar("r_colorScaleUseTweaks", 1);
  setDvar("r_diffuseColorScale", 2);
  setDvar("r_specularColorScale", 2.5);

  setDvar("r_veil", 1);
  setDvar("r_veilStrength", 0.180);
  setDvar("r_veilBackgroundStrength", 0.850);

  setDvar("compassmaxrange", "2000");

  game["attackers"] = "allies";
  game["defenders"] = "axis";
}