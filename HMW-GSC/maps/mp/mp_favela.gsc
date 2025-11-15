main() {
  maps\mp\mp_favela_precache::main();

  maps\createart\mp_favela_art::main();
  maps\createart\mp_favela_fog::main();
  maps\createart\mp_favela_fog_hdr::main();
  maps\mp\mp_favela_fx::main();
  maps\mp\_load::main();
  common_scripts\_destructible::init();

  maps\mp\_compass::setupMiniMap("compass_map_mp_favela");
  //setExpFog( 270, 11488, 0.8, 0.8, 0.8, 0.1, 0 );

  // raise up planes to avoid them flying through buildings
  level.airstrikeHeightScale = 1.5;

  ambientPlay("ambient_mp_favela");

  switch (level.gameType) {
    case "oneflag":
      game["attackers"] = "allies";
      game["defenders"] = "axis";
      break;
    default:
      game["attackers"] = "axis";
      game["defenders"] = "allies";
      break;
  }

  setdvar("r_specularcolorscale", "2.8");
  setdvar("compassmaxrange", "2000");
  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.25);
  setdvar("r_lightGridContrast", .45);

  setdvar("r_tessellation", 0);
  setdvar("r_lodBiasRigid", -2000);
  setdvar("r_lodBiasSkinned", -2000);
  setdvar("r_drawSun", 0);
  setdvar("r_umbra", 1);
  setdvar("r_fog", 1);
  setdvar("r_filmusetweaks", 0);
  setdvar("r_smodelinstancedthreshold", 0);

  setdvar("r_primaryLightUseTweaks", 1);
  setdvar("r_primaryLightTweakDiffuseStrength", 1.15);
  setdvar("r_primaryLightTweakSpecularStrength", 1.24);

  setdvar("r_viewModelPrimaryLightUseTweaks", 1);
  setdvar("r_viewModelPrimaryLightTweakDiffuseStrength", 1.15);
  setdvar("r_viewModelPrimaryLightTweakSpecularStrength", 1.24);

  setdvar("r_colorScaleUseTweaks", 1);
  setdvar("r_diffuseColorScale", 3.480);
  setdvar("r_specularColorScale", 2.210);

  setdvar("r_veil", 1);
  setdvar("r_veilusetweaks", 1);
  setdvar("r_veilStrength", 0.217);
  setdvar("r_veilBackgroundStrength", 0.913);
}