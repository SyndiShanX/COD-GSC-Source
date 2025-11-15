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

  setdvar("compassmaxrange", "3000");

  ambientPlay("ambient_mp_desert");

  game["attackers"] = "allies";
  game["defenders"] = "axis";

  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.2);
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
  setdvar("r_primaryLightTweakDiffuseStrength", 2.42);
  setdvar("r_primaryLightTweakSpecularStrength", 1.93);

  setdvar("r_viewModelPrimaryLightUseTweaks", 1);
  setdvar("r_viewModelPrimaryLightTweakDiffuseStrength", 2.42);
  setdvar("r_viewModelPrimaryLightTweakSpecularStrength", 1.93);

  setdvar("r_colorScaleUseTweaks", 1);
  setdvar("r_diffuseColorScale", 1.420);
  setdvar("r_specularColorScale", 0.490);

  setdvar("r_veil", 1);
  setdvar("r_veilusetweaks", 1);
  setdvar("r_veilStrength", 0.150);
  setdvar("r_veilBackgroundStrength", 1.2);
}