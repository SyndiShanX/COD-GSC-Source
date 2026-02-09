#include maps\mp\_utility;
#include common_scripts\utility;

main() {
  maps\mp\mp_complex_precache::main();
  maps\mp\mp_complex_fx::main();
  maps\createart\mp_complex_art::main();
  maps\createart\mp_complex_fog::main();
  maps\createart\mp_complex_fog_hdr::main();
  common_scripts\_destructible::init();
  //common_scripts\_destructible_dlc::main();

  //maps\mp\_destructible_dlc::main(); // call before _load

  maps\mp\_load::main();

  maps\mp\_compass::setupMiniMap("compass_map_mp_complex");

  ambientPlay("ambient_mp_complex");

  // raise up planes to avoid them flying through buildings
  level.airstrikeHeightScale = 2;

  game["attackers"] = "allies";
  game["defenders"] = "axis";

  setDvar("compassmaxrange", "2000");

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
  setDvar("r_diffuseColorScale", 2.5);
  setDvar("r_specularColorScale", 2.8);

  setDvar("r_veil", 1);
  setDvar("r_veilusetweaks", 1);
  setDvar("r_veilStrength", 0.100);
  setDvar("r_veilBackgroundStrength", 0.850);
}