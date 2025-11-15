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

  setdvar("compassmaxrange", "2000");

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
  setdvar("r_diffuseColorScale", 2.5);
  setdvar("r_specularColorScale", 2.8);

  setdvar("r_veil", 1);
  setdvar("r_veilusetweaks", 1);
  setdvar("r_veilStrength", 0.100);
  setdvar("r_veilBackgroundStrength", 0.850);
}