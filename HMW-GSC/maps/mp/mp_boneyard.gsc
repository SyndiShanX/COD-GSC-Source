main() {
  maps\mp\mp_boneyard_precache::main();

  maps\mp\mp_boneyard_fx::main();
  maps\createart\mp_boneyard_art::main();
  maps\createart\mp_boneyard_fog::main();
  maps\createart\mp_boneyard_fog_hdr::main();
  maps\mp\mp_boneyard_precache::main();
  maps\mp\_load::main();
  maps\mp\_compass::setupMiniMap("compass_map_mp_boneyard");
  setdvar("compassmaxrange", "1700");
  common_scripts\_destructible::init();

  ambientPlay("ambient_mp_desert");

  game["attackers"] = "axis";
  game["defenders"] = "allies";

  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.19);
  setdvar("r_lightGridContrast", .4);

  setdvar("r_tessellation", 0);
  setdvar("r_lodBiasRigid", -2000);
  setdvar("r_lodBiasSkinned", -2000);
  setdvar("r_drawSun", 0);
  setdvar("r_umbra", 1);
  setdvar("r_fog", 1);
  setdvar("r_filmusetweaks", 0);
  setdvar("r_smodelinstancedthreshold", 0);

  setdvar("r_primaryLightUseTweaks", 1);
  setdvar("r_primaryLightTweakDiffuseStrength", 2.92);
  setdvar("r_primaryLightTweakSpecularStrength", 2.18);

  setdvar("r_viewModelPrimaryLightUseTweaks", 1);
  setdvar("r_viewModelPrimaryLightTweakDiffuseStrength", 2.92);
  setdvar("r_viewModelPrimaryLightTweakSpecularStrength", 2.18);

  setdvar("r_colorScaleUseTweaks", 1);
  setdvar("r_diffuseColorScale", 2.160);
  setdvar("r_specularColorScale", 1.870);

  setdvar("r_veil", 1);
  setdvar("r_veilusetweaks", 1);
  setdvar("r_veilStrength", 0.277);
  setdvar("r_veilBackgroundStrength", 1.023);

  if(level.ps3) {
    setdvar("sm_sunShadowScale", "0.7"); // ps3 optimization
  }
}