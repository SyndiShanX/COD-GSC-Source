main() {
  maps\mp\mp_underpass_precache::main();
  maps\createart\mp_underpass_art::main();
  maps\mp\mp_underpass_fx::main();
  maps\mp\_load::main();
  common_scripts\_destructible::init();

  maps\mp\_compass::setupMiniMap("compass_map_mp_underpass");
  setdvar("compassmaxrange", "2800");

  //setExpFog( 500, 3500, .5, 0.5, 0.45, 1, 0 );
  ambientPlay("ambient_mp_rain");

  game["attackers"] = "axis";
  game["defenders"] = "allies";

  setdvar("r_specularcolorscale", "3.1");
  setdvar("r_diffusecolorscale", ".78");
  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.3);
  setdvar("r_lightGridContrast", .5);

  setdvar("r_tessellation", 0);
  setdvar("r_lodBiasRigid", -2000);
  setdvar("r_lodBiasSkinned", -2000);
  setdvar("r_drawSun", 0);
  setdvar("r_umbra", 1);
  setdvar("r_fog", 1);
  setdvar("r_filmusetweaks", 0);
  setdvar("r_smodelinstancedthreshold", 0);

  setdvar("r_primaryLightUseTweaks", 1);
  setdvar("r_primaryLightTweakDiffuseStrength", 1.5);
  setdvar("r_primaryLightTweakSpecularStrength", 3.35);

  setdvar("r_viewModelPrimaryLightUseTweaks", 1);
  setdvar("r_viewModelPrimaryLightTweakDiffuseStrength", 1.5);
  setdvar("r_viewModelPrimaryLightTweakSpecularStrength", 3.35);

  setdvar("r_colorScaleUseTweaks", 1);
  setdvar("r_diffuseColorScale", 1.19);
  setdvar("r_specularColorScale", 0.7);

  setdvar("r_veil", 1);
  setdvar("r_veilusetweaks", 1);
  setdvar("r_veilStrength", 0.627);
  setdvar("r_veilBackgroundStrength", 0.963);

  if(level.ps3)
    setdvar("sm_sunShadowScale", "0.5"); // ps3 optimization

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

  for (;;) {
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