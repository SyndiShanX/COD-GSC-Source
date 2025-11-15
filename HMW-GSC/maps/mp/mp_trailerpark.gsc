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

  setdvar("r_lightGridEnableTweaks", 1);
  //	setdvar( "r_specularcolorscale", "1.7" );
  setdvar("r_lightGridIntensity", 1.33);

  setdvar("r_tessellation", 0);
  setdvar("r_lodBiasRigid", -2000);
  setdvar("r_lodBiasSkinned", -2000);
  setdvar("r_drawSun", 0);
  setdvar("r_umbra", 1);
  setdvar("r_fog", 1);
  setdvar("r_filmusetweaks", 0);
  setdvar("r_smodelinstancedthreshold", 0);

  setdvar("compassmaxrange", "2000");

  AmbientPlay("ambient_mp_trailerpark");

  setdvar("r_primaryLightUseTweaks", 1);
  setdvar("r_primaryLightTweakDiffuseStrength", 1.4);
  setdvar("r_primaryLightTweakSpecularStrength", 1);

  setdvar("r_viewModelPrimaryLightUseTweaks", 1);
  setdvar("r_viewModelPrimaryLightTweakDiffuseStrength", 1.4);
  setdvar("r_viewModelPrimaryLightTweakSpecularStrength", 1);

  setdvar("r_colorScaleUseTweaks", 1);
  setdvar("r_diffuseColorScale", 0.79);
  setdvar("r_specularColorScale", 1.2);

  setdvar("r_veil", 1);
  setdvar("r_veilusetweaks", 1);
  setdvar("r_veilStrength", 0.447);
  setdvar("r_veilBackgroundStrength", 1.093);

  game["attackers"] = "allies";
  game["defenders"] = "axis";
}