main() {
  maps\mp\mp_trailerpark_precache::main();
  maps\createart\mp_trailerpark_art::main();
  maps\createart\mp_trailerpark_fog::main();
  maps\createart\mp_trailerpark_fog_hdr::main();
  maps\mp\mp_trailerpark_fx::main();
  common_scripts\_destructible::init();

  //maps\mp\_destructible_dlc2::main(); // call before _load
  //maps\mp\_destructible_dlc::main(); // call before _load

  maps\mp\_compass::setupMiniMap("compass_map_mp_trailerpark");

  maps\mp\_load::main();

  maps\mp\_compass::setupMiniMap("compass_map_mp_trailerpark");

  setDvar("r_lightGridEnableTweaks", 1);
  //	setDvar( "r_specularcolorscale", "1.7" );
  setDvar("r_lightGridIntensity", 1.33);

  setDvar("r_tessellation", 0);
  setDvar("r_lodBiasRigid", -2000);
  setDvar("r_lodBiasSkinned", -2000);
  setDvar("r_drawSun", 0);
  setDvar("r_umbra", 1);
  setDvar("r_fog", 1);
  setDvar("r_filmusetweaks", 0);
  setDvar("r_smodelinstancedthreshold", 0);

  setDvar("compassmaxrange", "2000");

  AmbientPlay("ambient_mp_trailerpark");

  setDvar("r_primaryLightUseTweaks", 1);
  setDvar("r_primaryLightTweakDiffuseStrength", 1.4);
  setDvar("r_primaryLightTweakSpecularStrength", 1);

  setDvar("r_viewModelPrimaryLightUseTweaks", 1);
  setDvar("r_viewModelPrimaryLightTweakDiffuseStrength", 1.4);
  setDvar("r_viewModelPrimaryLightTweakSpecularStrength", 1);

  setDvar("r_colorScaleUseTweaks", 1);
  setDvar("r_diffuseColorScale", 0.79);
  setDvar("r_specularColorScale", 1.2);

  setDvar("r_veil", 1);
  setDvar("r_veilusetweaks", 1);
  setDvar("r_veilStrength", 0.447);
  setDvar("r_veilBackgroundStrength", 1.093);

  game["attackers"] = "allies";
  game["defenders"] = "axis";
}