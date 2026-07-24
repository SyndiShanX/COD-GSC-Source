/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3838.gsc
**************************************/

_id_FD0B() {
  level._id_FCD6 = 1;
  level._id_21E4 = _id_0F04::_id_E98D;
  _id_FD09();
  _id_FD0A();
  _id_FCF0();
  _id_0F36::_id_D83F();
}

main(var_0) {
  scripts\engine\utility::flag_init("highlight_zero_g_ai");
  scripts\engine\utility::flag_set("highlight_zero_g_ai");
  _id_FCF4();
  _id_FCF7();
  _id_FCEA();
  _id_0F09::_id_6A23();
  _id_0F14::_id_FD5D();
  _id_0F01::_id_FCE0();
  thread _id_0F03::_id_43D8(var_0);
  _id_0E45::main();
}

_id_FD09() {
  _id_0F14::_id_1139A();
  _id_0E45::_id_5F81();
  precachemodel("vm_hero_protagonist_helmet");
}

_id_FD0A() {
  precachestring(&"SHIP_ASSAULT_HINT_LIFE_SUPPORT");
  precachestring(&"SHIP_ASSAULT_HINT_ROBOTICS");
  scripts\sp\utility::_id_16EB("hint_exit_jackal", &"SHIP_ASSAULT_EXIT_JACKAL", _id_0F16::_id_6975);
  scripts\sp\utility::_id_16EB("threat_meter", &"SHIP_ASSAULT_THREAT_SIGHT_HELP");
  scripts\sp\utility::_id_16EB("tagging_hint", &"SHIP_ASSAULT_TAGGING_HINT", ::_id_11402);
  scripts\sp\utility::_id_16EB("obj_on_demand_hint", &"SHIP_ASSAULT_OBJ_ON_DEMAND_HINT", ::_id_C26C);
}

_id_C26C() {
  return getDvar("objectiveGlobalFadeState") == "2";
}

_id_11402() {
  if(!isDefined(level._id_11403)) {
    level._id_11403 = gettime();
  }

  return scripts\engine\utility::is_true(level.player._id_113F4) || gettime() >= level._id_11403 + 6000;
}

_id_117C7() {}

_id_FCF0() {
  level._id_E042 = ["supportdrone"];
}

_id_FD1B() {
  level thread _id_0F21::_id_F5B6(1);
  level thread _id_971D();
}

_id_971D(var_0) {
  wait 5;
  var_1 = _id_7C24(var_0);
  thread _id_0F24::_id_1DD6(var_1);
}

_id_7C24(var_0) {
  var_1 = [];
  var_2 = [];
  var_3 = "sp/sa_radio_conversations.csv";

  if(!isDefined(var_0)) {
    var_0 = "";
  }

  var_4 = "";
  var_5 = 0;

  for(;;) {
    var_6 = tablelookupbyrow(var_3, var_5, 0);
    var_7 = tablelookupbyrow(var_3, var_5, 1);
    var_8 = tablelookupbyrow(var_3, var_5, 2);

    if(var_1.size > 0 && var_7 != var_4) {
      var_2[var_2.size] = var_1;
      var_1 = [];
    }

    var_4 = var_7;

    if(var_0 == var_8 && var_6 != "") {
      var_1[var_1.size] = var_6;
    }

    if(var_6 == "") {
      break;
    }

    var_5++;
  }

  return var_2;
}

_id_FCF4() {
  level._id_128E = 0;
  scripts\engine\utility::add_fx("door_sparks", "vfx/misc/sparks/electrical_sparks");
  scripts\engine\utility::add_fx("red_siren", "vfx/iw7/levels/cp_jackal_assault/vfx_cpja_light_warning_red");
  scripts\engine\utility::add_fx("red_strobe", "vfx/misc/lights/vfx_glow_red_light_400_strobe.vfx");
  scripts\engine\utility::add_fx("blue_strobe", "vfx/misc/lights/vfx_glow_blue_light_400_strobe");
  scripts\engine\utility::add_fx("c6_amber_glow", "vfx/iw7/_requests/ship_assault/vfx_ra_glow_c6_amber");
  scripts\engine\utility::add_fx("turret_smoke", "vfx/iw7/_requests/ship_assault/vfx_exp_chargeshot_core_smoke");
  scripts\engine\utility::add_fx("turret_sparks", "vfx/iw7/core/equipment/vfx_sparks_turret");
  scripts\engine\utility::add_fx("window_decompression", "vfx/iw7/_requests/ship_assault/vfx_moon_airlock_wind_tunnel");
  scripts\engine\utility::add_fx("helmet_frost", "vfx/iw7/core/screen/vfx_frost_screen.vfx");
  scripts\engine\utility::add_fx("ground_steam", "vfx/iw7/_requests/ship_assault/vfx_ra_steam_vent_blast");
  scripts\engine\utility::add_fx("airlock_steam", "vfx/iw7/_requests/ship_assault/vfx_steam_vent");
  scripts\engine\utility::add_fx("flashlight_player", "vfx/_requests/moon/vfx_flashlight_player");
  scripts\engine\utility::add_fx("life_support_player_fog", "vfx/iw7/_requests/ship_assault/vfx_moon_airlock_suck_in.vfx");
  scripts\engine\utility::add_fx("robotics_shocks", "vfx/iw7/_requests/ship_assault/vfx_kinetic_pulse_shock");
  scripts\engine\utility::add_fx("ambient_sparks_looping", "vfx/misc/sparks/vfx_mechanical_sparks_runner");
  scripts\engine\utility::add_fx("sa_flashlight", "vfx/iw7/core/light/vfx_flashlight_npc");
  scripts\engine\utility::add_fx("sa_flashlight_flare", "vfx/iw7/core/light/vfx_flashlight_npc_nolight.vfx");
  scripts\engine\utility::add_fx("zerog_breach_emergency_light", "vfx/iw7/_requests/ship_assault/vfx_breach_emergency_light_01");
  scripts\engine\utility::add_fx("zerog_breach_airlock_smoke_ground", "vfx/iw7/_requests/ship_assault/vfx_breach_airlock_steam_ground");
  scripts\engine\utility::add_fx("zerog_breach_airlock_smoke_jet", "vfx/iw7/_requests/ship_assault/vfx_breach_airlock_steam_jet");
  scripts\engine\utility::add_fx("zerog_breach_explosion", "vfx/iw7/_requests/ship_assault/vfx_explosion_zerog_v3");
  scripts\engine\utility::add_fx("destroyer_explode", "vfx/iw7/core/expl/vehicle/vfx_destroyer_death.vfx");
}

#using_animtree("generic_human");

_id_FCF7() {
  level._id_EC85["generic"]["life_support_kill_1"] = % hm_zg_org_grav_grenade_choke01_ar;
  level._id_EC85["generic"]["life_support_kill_2"] = % hm_zg_org_grav_grenade_choke02_ar;
  level._id_EC85["generic"]["life_support_lift_1"] = % hm_zg_org_grav_grenade_float01_ar;
  level._id_EC85["generic"]["life_support_lift_2"] = % hm_zg_org_grav_grenade_float02_ar;
  level._id_EC85["generic"]["life_support_lift_3"] = % hm_zg_org_grav_grenade_float03_ar;
  level._id_EC85["generic"]["life_support_float_loop_1"][0] = % hm_zg_org_grav_grenade_loop01_ar;
  level._id_EC85["generic"]["life_support_float_loop_2"][0] = % hm_zg_org_grav_grenade_loop02_ar;
  level._id_EC85["generic"]["life_support_land_1"] = % hm_zg_org_grav_grenade_land01_ar;
  level._id_EC85["generic"]["life_support_land_2"] = % hm_zg_org_grav_grenade_land02_ar;
  level._id_EC85["generic"]["life_support_land_3"] = % hm_zg_org_grav_grenade_land03_ar;
  level._id_EC85["generic"]["life_support_float"][0] = % zg_exposed_idle;
  level._id_EC85["generic"]["life_support_shoot"][0] = % hm_zg_org_exposed_aim_5_ar;
  level._id_EC85["generic"]["life_support_ally_lift_1"] = % sa_wounded_zerog_enter_ally_01;
  level._id_EC85["generic"]["life_support_ally_lift_2"] = % sa_wounded_zerog_enter_ally_02;
  level._id_EC85["generic"]["life_support_ally_loop_1"][0] = % sa_wounded_zerog_loop_ally_01;
  level._id_EC85["generic"]["life_support_ally_land_1"] = % sa_wounded_zerog_exit_ally_01;
  level._id_EC85["generic"]["life_support_ally_land_2"] = % sa_wounded_zerog_exit_ally_02;
  level._id_EC85["generic"]["life_support_ally_lift_1_gundown"] = % sa_wounded_zerog_gundown_enter_ally_01;
  level._id_EC85["generic"]["life_support_ally_loop_1_gundown"][0] = % sa_wounded_zerog_gundown_loop_ally_01;
  level._id_EC85["generic"]["life_support_ally_land_1_gundown"] = % sa_wounded_zerog_gundown_exit_ally_01;
  level._id_EC85["generic"]["injured_walk"] = % hm_grnd_injured_walk_forward_ar;
}

#using_animtree("c6");

_id_FCEA() {
  level._id_EC85["robot"]["life_support_C6_lift_1"] = % c6_zg_org_grav_grenade_float01_ar;
  level._id_EC85["robot"]["life_support_C6_lift_2"] = % c6_zg_org_grav_grenade_float02_ar;
  level._id_EC85["robot"]["life_support_C6_float_idle"][0] = % c6_zg_org_grav_grenade_exposed_aim_idle_ar;
  level._id_EC85["robot"]["life_support_C6_float_aim_2"][0] = % c6_zg_org_grav_grenade_exposed_aim_2_ar;
  level._id_EC85["robot"]["life_support_C6_float_aim_4"][0] = % c6_zg_org_grav_grenade_exposed_aim_4_ar;
  level._id_EC85["robot"]["life_support_C6_float_aim_5"][0] = % c6_zg_org_grav_grenade_exposed_aim_5_ar;
  level._id_EC85["robot"]["life_support_C6_float_aim_6"][0] = % c6_zg_org_grav_grenade_exposed_aim_6_ar;
  level._id_EC85["robot"]["life_support_C6_float_aim_8"][0] = % c6_zg_org_grav_grenade_exposed_aim_8_ar;
}

#using_animtree("script_model");

_id_FD11() {
  level._id_EC87["mute_charge_01"] = #animtree;
  level._id_EC8C["mute_charge_01"] = "mute_charge_01";
}