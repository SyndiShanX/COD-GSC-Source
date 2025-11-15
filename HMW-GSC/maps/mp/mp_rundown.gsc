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

  setdvar("r_specularcolorscale", "1.67");
  setdvar("compassmaxrange", "3000");
  setdvar("sm_sunShadowScale", "0.5"); // optimization

  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.16);
  setdvar("r_lightGridContrast", 1);

  setdvar("r_tessellation", 0);
  setdvar("r_lodBiasRigid", -2000);
  setdvar("r_lodBiasSkinned", -2000);
  setdvar("r_drawSun", 0);
  setdvar("r_umbra", 1);
  setdvar("r_fog", 1);
  setdvar("r_filmusetweaks", 0);
  setdvar("r_smodelinstancedthreshold", 0);

  setdvar("r_primaryLightUseTweaks", 1);
  setdvar("r_primaryLightTweakDiffuseStrength", 1.84);
  setdvar("r_primaryLightTweakSpecularStrength", 1.21);

  setdvar("r_viewModelPrimaryLightUseTweaks", 1);
  setdvar("r_viewModelPrimaryLightTweakDiffuseStrength", 1.84);
  setdvar("r_viewModelPrimaryLightTweakSpecularStrength", 1.21);

  setdvar("r_colorScaleUseTweaks", 1);
  setdvar("r_diffuseColorScale", 5.9);
  setdvar("r_specularColorScale", 0.36);

  setdvar("r_veil", 1);
  setdvar("r_veilusetweaks", 1);
  setdvar("r_veilStrength", 0.117);
  setdvar("r_veilBackgroundStrength", 1.023);
}