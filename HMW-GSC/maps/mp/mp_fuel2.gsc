main() {
  maps\mp\mp_fuel2_precache::main();
  maps\mp\mp_fuel2_fx::main();
  maps\createart\mp_fuel2_art::main();
  maps\mp\_load::main();
  common_scripts\_destructible::init();

  maps\mp\_compass::setupMiniMap("compass_map_mp_fuel2");

  ambientPlay("ambient_mp_fuel");

  game["attackers"] = "allies";
  game["defenders"] = "axis";

  setdvar("r_tessellation", 0);
  setdvar("r_lodBiasRigid", -2000);
  setdvar("r_lodBiasSkinned", -2000);
  setdvar("compassmaxrange", 2000);
  setdvar("r_drawSun", 0);
  setdvar("r_umbra", 1);
  setdvar("r_fog", 1);
  setdvar("r_filmusetweaks", 0);
  setdvar("r_smodelinstancedthreshold", 0);

  setdvar("r_primaryLightUseTweaks", 1);
  setdvar("r_primaryLightTweakDiffuseStrength", 2.6);
  setdvar("r_primaryLightTweakSpecularStrength", 1);

  setdvar("r_viewModelPrimaryLightUseTweaks", 1);
  setdvar("r_viewModelPrimaryLightTweakDiffuseStrength", 2.6);
  setdvar("r_viewModelPrimaryLightTweakSpecularStrength", 1);

  setdvar("r_colorScaleUseTweaks", 1);
  setdvar("r_diffuseColorScale", 1.34);
  setdvar("r_specularColorScale", 2);

  setdvar("r_veil", 1);
  setdvar("r_veilusetweaks", 1);
  setdvar("r_veilStrength", 0.27);
  setdvar("r_veilBackgroundStrength", 1.5);
}