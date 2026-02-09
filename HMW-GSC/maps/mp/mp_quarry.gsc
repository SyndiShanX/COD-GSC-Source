main() {
  maps\mp\mp_quarry_precache::main();
  maps\mp\mp_quarry_fx::main();
  maps\createart\mp_quarry_art::main();
  maps\mp\_load::main();
  maps\mp\_explosive_barrels::main();
  maps\mp\_compass::setupMiniMap("compass_map_mp_quarry");
  setDvar("compassmaxrange", "2800");
  common_scripts\_destructible::init();

  //setExpFog( 900, 3500, 0.631373, 0.568627, 0.54902, 1, 0 );
  //setExpFog( 900, 3500, 0.631373, 0.568627, 0.34902, 1, 0, 1, 0.803922, 0.564706, (0, .5, 1), 0, 	15.2331, 0.961894 );

  ambientPlay("ambient_mp_desert");
  VisionSetNaked("mp_quarry");

  // raise up planes to avoid them flying through buildings
  level.airstrikeHeightScale = 2;

  game["attackers"] = "axis";
  game["defenders"] = "allies";

  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.22);
  setDvar("r_lightGridContrast", .67);

  setDvar("r_tessellation", 0);
  setDvar("r_lodBiasRigid", -2000);
  setDvar("r_lodBiasSkinned", -2000);
  setDvar("r_drawSun", 0);
  setDvar("r_umbra", 1);
  setDvar("r_fog", 1);
  setDvar("r_filmusetweaks", 0);
  setDvar("r_smodelinstancedthreshold", 0);

  setDvar("r_primaryLightUseTweaks", 1);
  setDvar("r_primaryLightTweakDiffuseStrength", 1.39);
  setDvar("r_primaryLightTweakSpecularStrength", 0.5);

  setDvar("r_viewModelPrimaryLightUseTweaks", 1);
  setDvar("r_viewModelPrimaryLightTweakDiffuseStrength", 1.39);
  setDvar("r_viewModelPrimaryLightTweakSpecularStrength", 0.5);

  setDvar("r_colorScaleUseTweaks", 1);
  setDvar("r_diffuseColorScale", 3);
  setDvar("r_specularColorScale", 0.85);

  setDvar("r_veil", 1);
  setDvar("r_veilusetweaks", 1);
  setDvar("r_veilStrength", 0.267);
  setDvar("r_veilBackgroundStrength", 0.783);
}