main() {
  maps\mp\mp_boneyard_precache::main();

  maps\mp\mp_boneyard_fx::main();
  maps\createart\mp_boneyard_art::main();
  maps\createart\mp_boneyard_fog::main();
  maps\createart\mp_boneyard_fog_hdr::main();
  maps\mp\mp_boneyard_precache::main();
  maps\mp\_load::main();
  maps\mp\_compass::setupMiniMap("compass_map_mp_boneyard");
  setDvar("compassmaxrange", "1700");
  common_scripts\_destructible::init();

  ambientPlay("ambient_mp_desert");

  game["attackers"] = "axis";
  game["defenders"] = "allies";

  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.19);
  setDvar("r_lightGridContrast", .4);

  setDvar("r_tessellation", 0);
  setDvar("r_lodBiasRigid", -2000);
  setDvar("r_lodBiasSkinned", -2000);
  setDvar("r_drawSun", 0);
  setDvar("r_umbra", 1);
  setDvar("r_fog", 1);
  setDvar("r_filmusetweaks", 0);
  setDvar("r_smodelinstancedthreshold", 0);

  setDvar("r_primaryLightUseTweaks", 1);
  setDvar("r_primaryLightTweakDiffuseStrength", 2.92);
  setDvar("r_primaryLightTweakSpecularStrength", 2.18);

  setDvar("r_viewModelPrimaryLightUseTweaks", 1);
  setDvar("r_viewModelPrimaryLightTweakDiffuseStrength", 2.92);
  setDvar("r_viewModelPrimaryLightTweakSpecularStrength", 2.18);

  setDvar("r_colorScaleUseTweaks", 1);
  setDvar("r_diffuseColorScale", 2.160);
  setDvar("r_specularColorScale", 1.870);

  setDvar("r_veil", 1);
  setDvar("r_veilusetweaks", 1);
  setDvar("r_veilStrength", 0.277);
  setDvar("r_veilBackgroundStrength", 1.023);

  if(level.ps3)
    setDvar("sm_sunShadowScale", "0.7"); // ps3 optimization
}