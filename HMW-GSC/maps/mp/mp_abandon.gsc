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

  setdvar("r_specularcolorscale", "2.5");
  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.452);
  setdvar("r_lightGridContrast", 0);
  setdvar("r_tessellation", 0);
  setdvar("r_lodBiasRigid", -2000);
  setdvar("r_lodBiasSkinned", -2000);
  setdvar("r_drawSun", 0);
  setdvar("r_umbra", 1);
  setdvar("r_fog", 1);
  setdvar("r_filmusetweaks", 0);
  setdvar("r_smodelinstancedthreshold", 0);

  setdvar("r_primaryLightUseTweaks", 1);
  setdvar("r_primaryLightTweakDiffuseStrength", 2);
  setdvar("r_primaryLightTweakSpecularStrength", 1);

  setdvar("r_viewModelPrimaryLightUseTweaks", 1);
  setdvar("r_viewModelPrimaryLightTweakDiffuseStrength", 2);
  setdvar("r_viewModelPrimaryLightTweakSpecularStrength", 1);

  setdvar("r_colorScaleUseTweaks", 1);
  setdvar("r_diffuseColorScale", 2);
  setdvar("r_specularColorScale", 2.5);

  setdvar("r_veil", 1);
  setdvar("r_veilStrength", 0.180);
  setdvar("r_veilBackgroundStrength", 0.850);

  setdvar("compassmaxrange", "2000");

  game["attackers"] = "allies";
  game["defenders"] = "axis";
}