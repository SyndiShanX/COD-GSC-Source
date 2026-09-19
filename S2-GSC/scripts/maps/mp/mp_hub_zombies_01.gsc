/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_hub_zombies_01.gsc
*************************************************/

main() {
  level._id_A1FE = getdvarint("4476", 0) != 0;
  level._id_A220 = level._id_A1FE;
  level._id_A259 = 1;
  level._id_AC5A = 1;
  _id_04D9::_id_4F3E();
  _id_04B1::main();
  _id_0418::main();
  _id_04B0::main();
  _id_0483::main();
  maps\mp\mp_hub_zombies_01_lighting::main();
  maps\mp\mp_hub_zombies_01_aud::main();
  _id_0472::_id_8A2F("");
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  setDvar("4135", "allies");
  level._id_ACBC = undefined;
  level._id_ACBA = undefined;
  level._id_ACC0 = undefined;
  level._id_ACBD = undefined;
  level._id_ACBB = undefined;
  level._id_ACBF = undefined;
  level._id_6C5F = "mp_hub_zombies_01_osp";
  level._id_6C5E = "mp_hub_zombies_01_osp";
  level._id_3445 = "mp_hub_zombies_01_drone";
  level._id_343A = "mp_hub_zombies_01_drone";
  level._id_A853 = "mp_hub_zombies_01_warbird";
  level._id_A852 = "mp_hub_zombies_01_warbird";
  level._id_3FDD = ::_id_0F39;
  level._id_3FE0 = ::_id_A27B;
  level thread _id_6B70();
  level thread _id_054F::init();
  level thread maps\mp\zombies\zombie_weapon_kits_shared::weaponkitsinitshared();
  level thread _id_0565::_id_5373();
  level thread initzmeventassets();
}

initzmeventassets() {
  if(getdvarint("spv_hub_st_patricks_event_enabled", 0) == 0) {
    var_0 = getEntArray("stp_event_assets", "targetname");

    if(isDefined(var_0) && var_0.size > 0) {
      foreach(var_2 in var_0)
      var_2 delete();
    }
  }

  if(getdvarint("spv_hub_war_machine_event_enabled", 0) == 0) {
    var_4 = getEntArray("wmc_event_assets", "targetname");

    if(isDefined(var_4) && var_4.size > 0) {
      foreach(var_2 in var_4)
      var_2 delete();
    }
  }

  if(getdvarint("spv_hub_war_machine_event_enabled", 0) == 1) {
    var_7 = _func_18E("zmb_hub_cannon", "script_noteworthy");
    _func_147(level._effect["zmb_hub_canon_env_fx"], var_7, "tag_origin");
  }
}

_id_6B70() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread _id_04D9::_id_5302();
  }
}

_id_0F39() {}

_id_A27B(var_0, var_1) {
  switch (var_1) {
    case "specialty_class_mule_kick_zm":
    case "specialty_class_serrated_edge_zm":
    case "specialty_class_lucky_crit_zm":
    case "specialty_class_sustain_zone_zm":
    case "specialty_class_hoarder_zm":
    case "specialty_class_suppressive_fire_zm":
    case "specialty_class_fast_hands_zm":
    case "specialty_class_gungho_zm":
    case "specialty_class_mk_ii_zm":
    case "specialty_class_squad_tactics_zm":
    case "specialty_class_hit_em_hard_zm":
    case "specialty_class_come_get_zm":
    case "specialty_class_dutiful_medic_zm":
    case "specialty_class_specialist_zm":
    case "specialty_class_breathing_room_zm":
    case "specialty_class_fiery_burst_zm":
    case "specialty_class_on_your_feet_zm":
    case "specialty_class_exploit_weakness_zm":
    case "specialty_class_bolster_morale_zm":
    case "specialty_class_counter_offensive_zm":
    case "specialty_class_team_effort_zm":
    case "specialty_class_resilient_zm":
    case "specialty_class_improvised_def_zm":
    case "specialty_class_frag_skull_zm":
    case "specialty_class_ammo_carrier_zm":
    case "specialty_class_explosives_handler_zm":
    case "specialty_class_marksmanship_zm":
    case "specialty_class_charge_the_line_zm":
    case "specialty_class_covert_exfiltration_zm":
    case "specialty_class_recon_medic_zm":
    case "specialty_class_saboteur_zm":
    case "specialty_class_survivalist_zm":
    case "specialty_class_mobilization_zm":
    case "specialty_class_discipline_zm":
    case "specialty_class_grenadier_zm":
    case "specialty_class_flak_jacket_zm":
    case "specialty_class_preventative_medicine_zm":
    case "specialty_class_fully_loaded_zm":
    case "specialty_class_finishing_blow_zm":
    case "specialty_class_mugger_zm":
    case "specialty_class_aftertaste_zm":
    case "specialty_class_resourceful_zm":
    case "specialty_class_longlasting_zm":
    case "specialty_class_armor_zm":
      return maps\mp\_utility::_id_452A(var_1);
    default:
      return 0;
  }
}