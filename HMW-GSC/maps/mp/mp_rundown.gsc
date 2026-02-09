main() {
  //maps\mp\mp_rundown_precache::main();
  maps\mp\mp_rundown_fx::main();
  maps\createart\mp_rundown_art::main();
  maps\mp\_load::main();
  common_scripts\_destructible::init();

  maps\mp\_compass::setupMiniMap("compass_map_mp_rundown");

  //setExpFog( 1695, 5200, 0.8, 0.8, 0.8, 0.2, 0 );
  ambientPlay("ambient_mp_rural");
  VisionSetNaked("mp_rundown");

  game["attackers"] = "axis";
  game["defenders"] = "allies";

  setDvar("r_specularcolorscale", "1.67");
  setDvar("compassmaxrange", "3000");
  setDvar("sm_sunShadowScale", "0.5"); // optimization

  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.16);
  setDvar("r_lightGridContrast", 1);

  setDvar("r_tessellation", 0);
  setDvar("r_lodBiasRigid", -2000);
  setDvar("r_lodBiasSkinned", -2000);
  setDvar("r_drawSun", 0);
  setDvar("r_umbra", 1);
  setDvar("r_fog", 1);
  setDvar("r_filmusetweaks", 0);
  setDvar("r_smodelinstancedthreshold", 0);

  setDvar("r_primaryLightUseTweaks", 1);
  setDvar("r_primaryLightTweakDiffuseStrength", 1.84);
  setDvar("r_primaryLightTweakSpecularStrength", 1.21);

  setDvar("r_viewModelPrimaryLightUseTweaks", 1);
  setDvar("r_viewModelPrimaryLightTweakDiffuseStrength", 1.84);
  setDvar("r_viewModelPrimaryLightTweakSpecularStrength", 1.21);

  setDvar("r_colorScaleUseTweaks", 1);
  setDvar("r_diffuseColorScale", 5.9);
  setDvar("r_specularColorScale", 0.36);

  setDvar("r_veil", 1);
  setDvar("r_veilusetweaks", 1);
  setDvar("r_veilStrength", 0.117);
  setDvar("r_veilBackgroundStrength", 1.023);
}