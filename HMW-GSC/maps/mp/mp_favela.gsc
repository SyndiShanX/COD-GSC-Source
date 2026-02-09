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

  setDvar("r_specularcolorscale", "2.8");
  setDvar("compassmaxrange", "2000");
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.25);
  setDvar("r_lightGridContrast", .45);

  setDvar("r_tessellation", 0);
  setDvar("r_lodBiasRigid", -2000);
  setDvar("r_lodBiasSkinned", -2000);
  setDvar("r_drawSun", 0);
  setDvar("r_umbra", 1);
  setDvar("r_fog", 1);
  setDvar("r_filmusetweaks", 0);
  setDvar("r_smodelinstancedthreshold", 0);

  setDvar("r_primaryLightUseTweaks", 1);
  setDvar("r_primaryLightTweakDiffuseStrength", 1.15);
  setDvar("r_primaryLightTweakSpecularStrength", 1.24);

  setDvar("r_viewModelPrimaryLightUseTweaks", 1);
  setDvar("r_viewModelPrimaryLightTweakDiffuseStrength", 1.15);
  setDvar("r_viewModelPrimaryLightTweakSpecularStrength", 1.24);

  setDvar("r_colorScaleUseTweaks", 1);
  setDvar("r_diffuseColorScale", 3.480);
  setDvar("r_specularColorScale", 2.210);

  setDvar("r_veil", 1);
  setDvar("r_veilusetweaks", 1);
  setDvar("r_veilStrength", 0.217);
  setDvar("r_veilBackgroundStrength", 0.913);
}