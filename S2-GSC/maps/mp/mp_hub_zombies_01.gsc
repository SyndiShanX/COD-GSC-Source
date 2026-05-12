/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_hub_zombies_01.gsc
*********************************************/

func_00F9() {
  level.var_A1FE = getdvarint("4476", 0) != 0;
  level.var_A220 = level.var_A1FE;
  level.var_A259 = 1;
  level.var_AC5A = 1;
  maps\mp\gametypes\_hub_stats::func_4F3E();
  lib_04B1::func_00F9();
  lib_0418::func_00F9();
  lib_04B0::func_00F9();
  maps\mp\_load::func_00F9();
  maps\mp\mp_hub_zombies_01_lighting::func_00F9();
  maps\mp\mp_hub_zombies_01_aud::func_00F9();
  maps\mp\_compass::func_8A2F("");
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  setDvar("4135", "allies");
  level.var_ACBC = undefined;
  level.var_ACBA = undefined;
  level.var_ACC0 = undefined;
  level.var_ACBD = undefined;
  level.var_ACBB = undefined;
  level.var_ACBF = undefined;
  level.var_6C5F = "mp_hub_zombies_01_osp";
  level.var_6C5E = "mp_hub_zombies_01_osp";
  level.var_3445 = "mp_hub_zombies_01_drone";
  level.var_343A = "mp_hub_zombies_01_drone";
  level.var_A853 = "mp_hub_zombies_01_warbird";
  level.var_A852 = "mp_hub_zombies_01_warbird";
  level.var_3FDD = ::func_0F39;
  level.var_3FE0 = ::func_A27B;
  level thread func_6B70();
  level thread lib_054F::func_00D5();
  level thread maps\mp\zombies\zombie_weapon_kits_shared::weaponkitsinitshared();
  level thread lib_0565::func_5373();
  level thread initzmeventassets();
}

initzmeventassets() {
  if(getdvarint("spv_hub_st_patricks_event_enabled", 0) == 0) {
    var_00 = getEntArray("stp_event_assets", "targetname");
    if(isDefined(var_00) && var_00.size > 0) {
      foreach(var_02 in var_00) {
        var_02 delete();
      }
    }
  }

  if(getdvarint("spv_hub_war_machine_event_enabled", 0) == 0) {
    var_04 = getEntArray("wmc_event_assets", "targetname");
    if(isDefined(var_04) && var_04.size > 0) {
      foreach(var_02 in var_04) {
        var_02 delete();
      }
    }
  }

  if(getdvarint("spv_hub_war_machine_event_enabled", 0) == 1) {
    var_07 = getent("zmb_hub_cannon", "script_noteworthy");
    playFXOnTag(level.var_0611["zmb_hub_canon_env_fx"], var_07, "tag_origin");
  }
}

func_6B70() {
  for(;;) {
    level waittill("connected", var_00);
    var_00 thread maps\mp\gametypes\_hub_stats::func_5302();
  }
}

func_0F39() {}

func_A27B(param_00, param_01) {
  switch (param_01) {
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
      return maps\mp\_utility::func_452A(param_01);

    default:
      return 0;
  }
}