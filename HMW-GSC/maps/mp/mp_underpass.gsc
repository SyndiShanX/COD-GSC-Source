main() {
  maps\mp\mp_underpass_precache::main();
  maps\createart\mp_underpass_art::main();
  maps\mp\mp_underpass_fx::main();
  maps\mp\_load::main();
  common_scripts\_destructible::init();

  maps\mp\_compass::setupMiniMap("compass_map_mp_underpass");
  setDvar("compassmaxrange", "2800");

  //setExpFog( 500, 3500, .5, 0.5, 0.45, 1, 0 );
  ambientPlay("ambient_mp_rain");

  game["attackers"] = "axis";
  game["defenders"] = "allies";

  setDvar("r_specularcolorscale", "3.1");
  setDvar("r_diffusecolorscale", ".78");
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.3);
  setDvar("r_lightGridContrast", .5);

  setDvar("r_tessellation", 0);
  setDvar("r_lodBiasRigid", -2000);
  setDvar("r_lodBiasSkinned", -2000);
  setDvar("r_drawSun", 0);
  setDvar("r_umbra", 1);
  setDvar("r_fog", 1);
  setDvar("r_filmusetweaks", 0);
  setDvar("r_smodelinstancedthreshold", 0);

  setDvar("r_primaryLightUseTweaks", 1);
  setDvar("r_primaryLightTweakDiffuseStrength", 1.5);
  setDvar("r_primaryLightTweakSpecularStrength", 3.35);

  setDvar("r_viewModelPrimaryLightUseTweaks", 1);
  setDvar("r_viewModelPrimaryLightTweakDiffuseStrength", 1.5);
  setDvar("r_viewModelPrimaryLightTweakSpecularStrength", 3.35);

  setDvar("r_colorScaleUseTweaks", 1);
  setDvar("r_diffuseColorScale", 1.19);
  setDvar("r_specularColorScale", 0.7);

  setDvar("r_veil", 1);
  setDvar("r_veilusetweaks", 1);
  setDvar("r_veilStrength", 0.627);
  setDvar("r_veilBackgroundStrength", 0.963);

  if(level.ps3)
    setDvar("sm_sunShadowScale", "0.5"); // ps3 optimization

  thread zombie_easter_egg();
}

zombie_easter_egg() {
  level endon("game_ended");

  damageTrigger = spawn("script_model", (860, 2607, 420));
  damageTrigger setModel("com_plasticcase_friendly");
  damageTrigger hide();
  damageTrigger.angles = (90, -180, 0);
  damageTrigger setCanDamage(true);
  damageTrigger.health = 999999; // keep it from dying anywhere in code

  for(;;) {
    damageTrigger waittill("damage", damage, attacker, direction_vec, point, sMeansOfDeath, modelName, tagName, partName, iDFlags, sWeapon);

    if(isDefined(sMeansOfDeath) && sMeansOfDeath == "MOD_MELEE" && isDefined(attacker) && isPlayer(attacker)) {
      if(!isDefined(attacker.easter_egg_index))
        attacker.easter_egg_index = -1;

      attacker.easter_egg_index++;

      if(attacker.easter_egg_index > 3)
        attacker.easter_egg_index = 0;

      switch (attacker.easter_egg_index) {
        case 0:
          attacker playLocalSound("zombie_tease");
          break;

        case 2:
          attacker playLocalSound("zombie_tease2");
          break;

        default:
          break;
      }
    }
  }
}