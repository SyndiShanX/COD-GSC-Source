/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\zm_customgame.gsc
***********************************************/

#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\bots\bot;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\hud_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_blockers;
#using scripts\zm_common\zm_crafting;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_laststand;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_player;
#using scripts\zm_common\zm_power;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_utility;
#namespace zm_custom;

function autoexec function_d776b402() {}

function function_901b751c(var_c9db62d5) {
  if(var_c9db62d5 === "") {
    return undefined;
  }

  setting = getgametypesetting(var_c9db62d5);
  assert(isDefined(setting), "<dev string:x38>" + function_9e72a96(var_c9db62d5) + "<dev string:x51>");
  return setting;
}

function function_16020b98(var_c9db62d5) {
  a_s_defaults = function_a8e9a6c7();

  foreach(s_setting in a_s_defaults) {
    if(var_c9db62d5 == s_setting.name) {
      return s_setting.default_val;
    }
  }

  return undefined;
}

function function_9be9c072(var_c9db62d5) {
  foreach(e_player in level.players) {
    e_player val::set(#"game_end", "freezecontrols", 1);
  }

  level notify(#"end_game");
}

function function_8b8fa6e5(e_player) {
  foreach(str_perk in level.var_b8be892e) {
    if(!e_player hasperk(str_perk)) {
      return false;
    }
  }

  return true;
}

function function_928be07c(var_6a59aecf) {
  if(isDefined(var_6a59aecf)) {
    var_7df0eb2d = var_6a59aecf;
    level.friendlyfire = var_6a59aecf;
    setgametypesetting(#"zmfriendlyfiretype", var_6a59aecf);
    setDvar(#"ui_friendlyfire", var_6a59aecf);
  } else {
    var_7df0eb2d = function_901b751c(#"zmfriendlyfiretype");
  }

  switch (var_7df0eb2d) {
    case 0:
      zm_player::function_a8846426(&function_e57809dd);
      zm_player::function_a8846426(&function_4225c3b7);
      zm_player::function_a8846426(&function_6607cdee);
      break;
    case 1:
      zm_player::function_a8846426(&function_4225c3b7);
      zm_player::function_a8846426(&function_6607cdee);
      zm_player::register_player_friendly_fire_callback(&function_e57809dd);
      break;
    case 2:
      zm_player::function_a8846426(&function_e57809dd);
      zm_player::function_a8846426(&function_6607cdee);
      zm_player::register_player_friendly_fire_callback(&function_4225c3b7);
      break;
    case 3:
      zm_player::function_a8846426(&function_e57809dd);
      zm_player::function_a8846426(&function_4225c3b7);
      zm_player::register_player_friendly_fire_callback(&function_6607cdee);
      break;
  }
}

function function_ff4557dc(s_talisman) {
  if(!function_901b751c(#"zmtalismansenabled")) {
    return false;
  }

  switch (s_talisman.name) {
    case # "talisman_box_guarantee_box_only":
      if(!function_901b751c(#"zmtalismanboxguaranteeboxonly") || function_901b751c(#"zmmysteryboxstate") == 0) {
        return false;
      }

      break;
    case # "talisman_box_guarantee_lmg":
      if(!function_901b751c(#"zmtalismanboxguaranteelmg") || !function_901b751c(#"zmweaponslmg") || function_901b751c(#"zmmysteryboxstate") == 0) {
        return false;
      }

      break;
    case # "talisman_coagulant":
      if(!function_901b751c(#"zmtalismancoagulant")) {
        return false;
      }

      break;
    case # "talisman_extra_claymore":
      if(!function_901b751c(#"zmtalismanextraclaymore")) {
        return false;
      }

      break;
    case # "talisman_extra_frag":
      if(!function_901b751c(#"zmtalismanextrafrag")) {
        return false;
      }

      break;
    case # "talisman_extra_miniturret":
      if(!function_901b751c(#"zmtalismanextraminiturret")) {
        return false;
      }

      break;
    case # "talisman_extra_molotov":
      if(!function_901b751c(#"zmtalismanextramolotov")) {
        return false;
      }

      break;
    case # "talisman_extra_semtex":
      if(!function_901b751c(#"zmtalismanextrasemtex")) {
        return false;
      }

      break;
    case # "talisman_impatient":
      if(!function_901b751c(#"zmtalismanimpatient")) {
        return false;
      }

      break;
    case # "talisman_perk_mod_single":
      if(!function_901b751c(#"zmtalismanperkmodsingle")) {
        return false;
      }

      break;
    case # "talisman_perk_permanent_1":
      if(!function_901b751c(#"zmtalismanperkpermanent1") || !function_901b751c(#"zmperksactive")) {
        return false;
      }

      break;
    case # "talisman_perk_permanent_2":
      if(!function_901b751c(#"zmtalismanperkpermanent2") || !function_901b751c(#"zmperksactive")) {
        return false;
      }

      break;
    case # "talisman_perk_permanent_3":
      if(!function_901b751c(#"zmtalismanperkpermanent3") || !function_901b751c(#"zmperksactive")) {
        return false;
      }

      break;
    case # "talisman_perk_permanent_4":
      if(!function_901b751c(#"zmtalismanperkpermanent4") || !function_901b751c(#"zmperksactive")) {
        return false;
      }

      break;
    case # "talisman_perk_reducecost_1":
      if(!function_901b751c(#"zmtalismanperkreducecost1") || !function_901b751c(#"zmperksactive")) {
        return false;
      }

      break;
    case # "talisman_perk_reducecost_2":
      if(!function_901b751c(#"zmtalismanperkreducecost2") || !function_901b751c(#"zmperksactive")) {
        return false;
      }

      break;
    case # "talisman_perk_reducecost_3":
      if(!function_901b751c(#"zmtalismanperkreducecost3") || !function_901b751c(#"zmperksactive")) {
        return false;
      }

      break;
    case # "talisman_perk_reducecost_4":
      if(!function_901b751c(#"zmtalismanperkreducecost4") || !function_901b751c(#"zmperksactive")) {
        return false;
      }

      break;
    case # "talisman_perk_start_1":
      if(!function_901b751c(#"zmtalismanperkstart1") || !function_901b751c(#"zmperksactive")) {
        return false;
      }

      break;
    case # "talisman_perk_start_2":
      if(!function_901b751c(#"zmtalismanperkstart2") || !function_901b751c(#"zmperksactive")) {
        return false;
      }

      break;
    case # "talisman_perk_start_3":
      if(!function_901b751c(#"zmtalismanperkstart3") || !function_901b751c(#"zmperksactive")) {
        return false;
      }

      break;
    case # "talisman_perk_start_4":
      if(!function_901b751c(#"zmtalismanperkstart4") || !function_901b751c(#"zmperksactive")) {
        return false;
      }

      break;
    case # "talisman_shield_durability_legendary":
      if(!function_901b751c(#"zmtalismanshielddurabilitylegendary") || !function_901b751c(#"zmshieldisenabled")) {
        return false;
      }

      break;
    case # "talisman_shield_durability_rare":
      if(!function_901b751c(#"zmtalismanshielddurabilityrare") || !function_901b751c(#"zmshieldisenabled")) {
        return false;
      }

      break;
    case # "talisman_shield_price":
      if(!function_901b751c(#"zmtalismanshieldprice") || !function_901b751c(#"zmshieldisenabled")) {
        return false;
      }

      break;
    case # "talisman_special_startlv2":
      if(!function_901b751c(#"zmtalismanspecialstartlvl2")) {
        return false;
      }

      break;
    case # "talisman_special_startlv3":
      if(!function_901b751c(#"zmtalismanspecialstartlvl3")) {
        return false;
      }

      break;
    case # "talisman_special_xp_rate":
      if(!function_901b751c(#"zmtalismanspecialxprate")) {
        return false;
      }

      break;
    case # "talisman_start_weapon_ar":
      if(!function_901b751c(#"zmtalismanstartweaponar")) {
        return false;
      }

      break;
    case # "talisman_start_weapon_lmg":
      if(!function_901b751c(#"zmtalismanstartweaponlmg")) {
        return false;
      }

      break;
    case # "talisman_start_weapon_smg":
      if(!function_901b751c(#"zmtalismanstartweaponsmg")) {
        return false;
      }

      break;
    case # "talisman_weapon_reducepapcost":
      if(!function_901b751c(#"zmtalismanreducepapcost")) {
        return false;
      }

      break;
    case # "talisman_permanent_heroweap_armor":
      if(!function_901b751c(#"zmtalismanpermanentheroweaparmor")) {
        return false;
      }

      break;
    case # "talisman_extra_self_revive":
      if(!function_901b751c(#"zmtalismanextraselfrevive")) {
        return false;
      }

      break;
    default:
      break;
  }

  if(isDefined(s_talisman.rarity)) {
    switch (s_talisman.rarity) {
      case 0:
        if(!function_901b751c(#"zmtalismanscommon")) {
          return false;
        }

        break;
      case 1:
        if(!function_901b751c(#"zmtalismansrare")) {
          return false;
        }

        break;
      case 2:
        if(!function_901b751c(#"zmtalismanslegendary")) {
          return false;
        }

        break;
      case 3:
        if(!function_901b751c(#"zmtalismansepic")) {
          return false;
        }

        break;
      case 4:
        if(!function_901b751c(#"zmtalismansultra")) {
          return false;
        }

        break;
      default:
        break;
    }
  }

  return true;
}

function function_3ac936c6(str_elixir) {
  if(!isDefined(str_elixir) || str_elixir == "" || !function_901b751c(#"zmelixirsenabled")) {
    return false;
  }

  n_index = getitemindexfromref(str_elixir);
  s_fields = function_b143666d(n_index, 2);

  if(isDefined(s_fields) && isDefined(s_fields.bgbrarity)) {
    n_rarity = s_fields.bgbrarity;
  }

  if(!isDefined(n_rarity)) {
    n_rarity = 0;
  }

  switch (str_elixir) {
    case # "zm_bgb_always_done_swiftly":
      if(!function_901b751c(#"zmelixiralwaysdoneswiftly")) {
        return false;
      }

      break;
    case # "zm_bgb_anywhere_but_here":
      if(!function_901b751c(#"zmelixiranywherebuthere")) {
        return false;
      }

      break;
    case # "zm_bgb_arsenal_accelerator":
      if(!function_901b751c(#"zmelixirarsenalaccelerator") || !function_901b751c(#"zmspecweaponisenabled")) {
        return false;
      }

      break;
    case # "zm_bgb_danger_closest":
      if(!function_901b751c(#"zmelixirdangerclosest")) {
        return false;
      }

      break;
    case # "zm_bgb_in_plain_sight":
      if(!function_901b751c(#"zmelixirinplainsight")) {
        return false;
      }

      break;
    case # "zm_bgb_newtonian_negation":
      if(!function_901b751c(#"zmelixirnewtoniannegation")) {
        return false;
      }

      break;
    case # "zm_bgb_now_you_see_me":
      if(!function_901b751c(#"zmelixirnowyouseeme")) {
        return false;
      }

      break;
    case # "zm_bgb_stock_option":
      if(!function_901b751c(#"zmelixirstockoption")) {
        return false;
      }

      break;
    case # "zm_bgb_board_games":
      if(!function_901b751c(#"zmelixirboardgames") || !function_901b751c(#"zmbarricadestate")) {
        return false;
      }

      break;
    case # "zm_bgb_burned_out":
      if(!function_901b751c(#"zmelixirburnedout")) {
        return false;
      }

      break;
    case # "zm_bgb_crawl_space":
      if(!function_901b751c(#"zmelixircrawlspace") || function_901b751c(#"zmcrawlerstate") == 0) {
        return false;
      }

      break;
    case # "zm_bgb_pop_shocks":
      if(!function_901b751c(#"zmelixirpopshocks")) {
        return false;
      }

      break;
    case # "zm_bgb_temporal_gift":
      if(!function_901b751c(#"zmelixirtemporalgift") || !function_901b751c(#"zmpowerupsactive")) {
        return false;
      }

      break;
    case # "zm_bgb_point_drops":
      if(!function_901b751c(#"zmelixirpointdrops") || !function_901b751c(#"zmpowerupchaospoints") || !function_901b751c(#"zmpowerupsactive")) {
        return false;
      }

      break;
    case # "zm_bgb_alchemical_antithesis":
      if(!function_901b751c(#"zmelixiralchemicalantithesis") || function_901b751c(#"zmpointsfixed")) {
        return false;
      }

      break;
    case # "zm_bgb_sword_flay":
      if(!function_901b751c(#"zmelixirswordflay") || !function_901b751c(#"zmweaponsmelee")) {
        return false;
      }

      break;
    case # "zm_bgb_dead_of_nuclear_winter":
      if(!function_901b751c(#"zmelixirdeadofnuclearwinter") || !function_901b751c(#"zmpowerupnuke") || !function_901b751c(#"zmpowerupsactive")) {
        return false;
      }

      break;
    case # "zm_bgb_licensed_contractor":
      if(!function_901b751c(#"zmelixirlicensedcontractor") || !function_901b751c(#"zmpowerupcarpenter") || !function_901b751c(#"zmpowerupsactive")) {
        return false;
      }

      break;
    case # "zm_bgb_undead_man_walking":
      if(!function_901b751c(#"zmelixirundeadmanwalking")) {
        return false;
      }

      break;
    case # "zm_bgb_whos_keeping_score":
      if(!function_901b751c(#"zmelixirwhoskeepingscore") || !function_901b751c(#"zmpowerupdouble") || !function_901b751c(#"zmpowerupsactive")) {
        return false;
      }

      break;
    case # "zm_bgb_aftertaste":
      if(!function_901b751c(#"zmelixiraftertaste")) {
        return false;
      }

      break;
    case # "zm_bgb_extra_credit":
      if(!function_901b751c(#"zmelixirextracredit") || !function_901b751c(#"zmpowerupchaospoints") || !function_901b751c(#"zmpowerupsactive")) {
        return false;
      }

      break;
    case # "zm_bgb_kill_joy":
      if(!function_901b751c(#"zmelixirkilljoy") || !function_901b751c(#"zmpowerupinstakill") || !function_901b751c(#"zmpowerupsactive")) {
        return false;
      }

      break;
    case # "zm_bgb_soda_fountain":
      if(!function_901b751c(#"zmelixirsodafountain") || !function_901b751c(#"zmperksactive")) {
        return false;
      }

      break;
    case # "zm_bgb_ctrl_z":
      if(!function_901b751c(#"zmelixirctrlz")) {
        return false;
      }

      break;
    case # "zm_bgb_free_fire":
      if(!function_901b751c(#"zmelixirfreefire")) {
        return false;
      }

      break;
    case # "zm_bgb_cache_back":
      if(!function_901b751c(#"zmelixircacheback") || !function_901b751c(#"zmpowerupmaxammo") || !function_901b751c(#"zmpowerupsactive")) {
        return false;
      }

      break;
    case # "zm_bgb_immolation_liquidation":
      if(!function_901b751c(#"zmelixirimmolationliquidation") || !function_901b751c(#"zmpowerupfiresale") || !function_901b751c(#"zmpowerupsactive") || function_901b751c(#"zmmysteryboxstate") == 0) {
        return false;
      }

      break;
    case # "zm_bgb_phoenix_up":
      if(!function_901b751c(#"zmelixirphoenixup") || !function_901b751c(#"zmlaststandduration")) {
        return false;
      }

      break;
    case # "zm_bgb_power_keg":
      if(!function_901b751c(#"zmelixirpowerkeg") || !function_901b751c(#"zmspecweaponisenabled") || !function_901b751c(#"zmpowerupspecialweapon") || !function_901b751c(#"zmpowerupsactive")) {
        return false;
      }

      break;
    case # "zm_bgb_blood_debt":
      if(!function_901b751c(#"zmelixirblooddebt")) {
        return false;
      }

      break;
    case # "zm_bgb_near_death_experience":
      if(!function_901b751c(#"zmelixirneardeathexperience")) {
        return false;
      }

      break;
    case # "zm_bgb_perkaholic":
      if(!function_901b751c(#"zmelixirperkaholic") || !function_901b751c(#"zmperksactive")) {
        return false;
      }

      break;
    case # "zm_bgb_wall_power":
      if(!function_901b751c(#"zmelixirwallpower") || function_901b751c(#"zmpapenabled") == 0) {
        return false;
      }

      break;
    case # "zm_bgb_anti_entrapment":
      if(!function_901b751c(#"zmelixirantientrapment")) {
        return false;
      }

      break;
    case # "zm_bgb_equip_mint":
      if(!function_901b751c(#"zmelixirequipmint")) {
        return false;
      }

      break;
    case # "zm_bgb_head_scan":
      if(!function_901b751c(#"zmelixirheadscan")) {
        return false;
      }

      break;
    case # "zm_bgb_join_the_party":
      if(!function_901b751c(#"zmelixirjointheparty")) {
        return false;
      }

      break;
    case # "zm_bgb_nowhere_but_there":
      if(!function_901b751c(#"zmelixirnowherebutthere")) {
        return false;
      }

      break;
    case # "zm_bgb_phantom_reload":
      if(!function_901b751c(#"zmelixirphantomreload")) {
        return false;
      }

      break;
    case # "zm_bgb_shields_up":
      if(!function_901b751c(#"zmelixirshieldsup") || !function_901b751c("zmShieldIsEnabled")) {
        return false;
      }

      break;
    case # "zm_bgb_wall_to_wall_clearance":
      if(!function_901b751c(#"zmelixirwalltowall")) {
        return false;
      }

      break;
    case # "zm_bgb_conflagration_liquidation":
      if(!function_901b751c(#"zmelixirconflagrationliquidation") || function_901b751c(#"zmpapenabled") == 0) {
        return false;
      }

      break;
    case # "zm_bgb_perk_up":
      if(!function_901b751c(#"zmelixirperkup") || !function_901b751c(#"zmperksactive")) {
        return false;
      }

      break;
    case # "zm_bgb_refresh_mint":
      if(!function_901b751c(#"zmelixirrefreshmint") || !function_901b751c(#"zmequipmentisenabled") && !function_901b751c(#"zmspecweaponisenabled")) {
        return false;
      }

      break;
    case # "zm_bgb_dividend_yield":
      if(!function_901b751c(#"zmelixirdividendyield")) {
        return false;
      }

      break;
    case # "zm_bgb_suit_up":
      if(!function_901b751c(#"zmelixirsuitup")) {
        return false;
      }

      break;
    case # "zm_bgb_talkin_bout_regeneration":
      if(!function_901b751c(#"zmelixirtalkinboutregeneration")) {
        return false;
      }

      break;
    case # "zm_bgb_bullet_boost":
      if(!function_901b751c(#"zmelixirbulletboost")) {
        return false;
      }

      break;
    case # "zm_bgb_quacknarok":
      if(!function_901b751c(#"zmelixirquacknarok")) {
        return false;
      }

      break;
    case # "zm_bgb_near_death_experience":
      if(!function_901b751c(#"zmelixirneardeathexperience")) {
        return false;
      }

      break;
    case # "zm_bgb_shopping_free":
      if(!function_901b751c(#"zmelixirshoppingfree")) {
        return false;
      }

      break;
    case # "zm_bgb_phoenix_up":
      if(!function_901b751c(#"zmelixirphoenixup")) {
        return false;
      }

      break;
    case # "zm_bgb_perkaholic":
      if(!function_901b751c(#"zmelixirperkaholic")) {
        return false;
      }

      break;
    case # "zm_bgb_reign_drops":
      if(!function_901b751c(#"zmelixirreigndrops") || !function_901b751c(#"zmpowerupsactive")) {
        return false;
      }

      break;
    case # "zm_bgb_head_drama":
      if(!function_901b751c(#"zmelixirheaddrama")) {
        return false;
      }

      break;
    case # "zm_bgb_power_vacuum":
      if(!function_901b751c(#"zmelixirpowervacuum") || !function_901b751c(#"zmpowerupsactive")) {
        return false;
      }

      break;
    case # "zm_bgb_secret_shopper":
      if(!function_901b751c(#"zmelixirsecretshopper") || !function_901b751c(#"zmwallbuysenabled")) {
        return false;
      }

      break;
    default:
      break;
  }

  switch (n_rarity) {
    case 0:
      if(!function_901b751c(#"zmelixirsdurables")) {
        return false;
      }

      break;
    case 2:
      if(!function_901b751c(#"zmelixirscommon")) {
        return false;
      }

      break;
    case 3:
      if(!function_901b751c(#"zmelixirsrare")) {
        return false;
      }

      break;
    case 5:
      if(!function_901b751c(#"zmelixirsepic")) {
        return false;
      }

      break;
    case 4:
      if(!function_901b751c(#"zmelixirslegendary")) {
        return false;
      }

      break;
    default:
      break;
  }

  return true;
}

function function_bce642a1(s_weap) {
  if(s_weap.itemgroupname === "weapon_cqb" && !function_901b751c(#"zmweaponsshotgun") || s_weap.itemgroupname === "weapon_smg" && !function_901b751c(#"zmweaponssmg") || s_weap.itemgroupname === "weapon_assault" && !function_901b751c(#"zmweaponsar") || s_weap.itemgroupname === "weapon_tactical" && !function_901b751c(#"zmweaponstr") || s_weap.itemgroupname === "weapon_lmg" && !function_901b751c(#"zmweaponslmg") || s_weap.itemgroupname === "weapon_sniper" && !function_901b751c(#"zmweaponssniper")) {
    return false;
  }

  return true;
}

function function_d9f0defb(str_perk) {
  if(!isDefined(str_perk) || !function_901b751c(#"zmperksactive")) {
    return false;
  }

  switch (str_perk) {
    case # "hash_47d7a8105237c88":
      if(!function_901b751c(#"zmperksjuggernaut")) {
        return false;
      }

      break;
    case # "talent_speedcola":
      if(!function_901b751c(#"zmperksspeed")) {
        return false;
      }

      break;
    case # "talent_quickrevive":
      if(!function_901b751c(#"zmperksquickrevive")) {
        return false;
      }

      break;
    case # "specialty_widowswine":
      if(!function_901b751c(#"zmperkswidowswail")) {
        return false;
      }

      break;
    case # "talent_staminup":
      if(!function_901b751c(#"zmperksstaminup")) {
        return false;
      }

      break;
    case # "specialty_additionalprimaryweapon":
      if(!function_901b751c(#"zmperksmulekick")) {
        return false;
      }

      break;
    case # "specialty_electriccherry":
      if(!function_901b751c(#"zmperkselectricburst")) {
        return false;
      }

      break;
    case # "talent_deadshot":
      if(!function_901b751c(#"zmperksdeadshot")) {
        return false;
      }

      break;
    case # "specialty_cooldown":
      if(!function_901b751c(#"zmperkscooldown")) {
        return false;
      }

      break;
    case # "specialty_berserker":
      if(!function_901b751c(#"zmperksdyingwish")) {
        return false;
      }

      break;
    case # "talent_phdslider":
      if(!function_901b751c(#"zmperksphdslider")) {
        return false;
      }

      break;
    case # "specialty_camper":
      if(!function_901b751c(#"zmperksstonecold")) {
        return false;
      }

      break;
    case # "specialty_extraammo":
      if(!function_901b751c(#"zmperksbandolier")) {
        return false;
      }

      break;
    case # "talent_deathperception":
      if(!function_901b751c(#"zmperksdeathperception")) {
        return false;
      }

      break;
    case # "specialty_shield":
      if(!function_901b751c(#"zmperksvictorious")) {
        return false;
      }

      break;
    case # "specialty_mystery":
      if(!function_901b751c(#"zmperkssecretsauce")) {
        return false;
      }

      break;
    case # "specialty_etherealrazor":
      if(!function_901b751c(#"zmperksetherealrazor")) {
        return false;
      }

      break;
    case # "specialty_zombshell":
      if(!function_901b751c(#"zmperkszombshell")) {
        return false;
      }

      break;
    case # "specialty_wolf_protector":
      if(!function_901b751c(#"zmperkswolfprotector")) {
        return false;
      }

      break;
    default:
      return false;
  }

  return true;
}

function function_2717f4b3() {
  var_17b7891d = "53d3ed6b43743770" + "talismanmsg";
  self notify(var_17b7891d);
  self endon(var_17b7891d);
  level endon(#"game_ended");
  self endon(#"disconnect");
  level flag::wait_till("all_players_spawned");
  wait 9;
  self iprintlnbold(#"hash_329de7d3aa04177c");
}

function function_deae84ba() {
  var_17b7891d = "b004e24506319a1" + "elixirmsg";
  self notify(var_17b7891d);
  self endon(var_17b7891d);
  level endon(#"game_ended");
  self endon(#"disconnect");
  level flag::wait_till("all_players_spawned");
  wait 10;
  self iprintlnbold(#"hash_6d446c2466f066ac");
}

function function_343353f8() {
  var_17b7891d = "782fe6896ef7bb67" + "weaponmsg";
  self notify(var_17b7891d);
  self endon(var_17b7891d);
  level endon(#"game_ended");
  self endon(#"disconnect");
  level flag::wait_till("all_players_spawned");
  wait 8;

  self iprintlnbold(#"hash_1225b8e31a9ffb76");
}

function function_41ed4017() {
  var_17b7891d = "26da004e3a8e260c" + "perkmsg";
  self notify(var_17b7891d);
  self endon(var_17b7891d);
  level endon(#"game_ended");
  self endon(#"disconnect");
  level flag::wait_till("all_players_spawned");
  wait 11;

  if(!is_true(level.var_5f7c5b5d)) {
    self iprintlnbold(#"hash_d77fc2d11c6deb1");
  }
}

function function_928e94b9(a_str_archetypes) {
  foreach(str_archetype in a_str_archetypes) {
    str_archetype = hash(str_archetype);

    if(isinarray(array(#"blight_father", #"brutus", #"gegenees", #"mechz", #"hash_7c0d83ac1e845ac2"), str_archetype) && function_901b751c(#"hash_4269e873a0c207c") == 0) {
      return true;
    }

    if(isinarray(array(#"stoker", #"gladiator", #"gladiator_marauder", #"gladiator_destroyer", #"werewolf", #"avogadro", #"raz"), str_archetype) && function_901b751c(#"hash_69262a31e0f8f91c") == 0) {
      return true;
    }

    if(isinarray(array(#"bat", #"dog", #"zombie_dog", #"zombie"), str_archetype) && function_901b751c(#"hash_4035c12ee5837454") == 0) {
      return true;
    }
  }

  return false;
}

function function_e1f04ede() {
  if(function_901b751c(#"zmpowerupsislimitedround") && level.powerup_drop_count >= function_901b751c(#"zmpowerupslimitround")) {
    return true;
  }

  return false;
}

function function_318d417b(e_player) {
  self endon(#"death");
  e_player endon(#"disconnect");

  if(!zm_perks::vending_trigger_can_player_use(e_player, 1)) {
    waitframe(1);
    return;
  }

  n_slot = self.stub.script_int;
  n_cost = 2000;
  var_ffc1cdd8 = e_player.var_c27f1e90[n_slot];

  if(!e_player zm_score::can_player_purchase(n_cost)) {
    self playSound(#"evt_perk_deny");
    e_player zm_audio::create_and_play_dialog(#"general", #"outofmoney");
    waitframe(1);
    return;
  }

  e_player zm_score::minus_to_player_score(n_cost);
  e_player.var_ec426a71 = 1;
  sound = "evt_bottle_dispense";
  playsoundatposition(sound, self.origin);
  var_cc1db3c1 = array::exclude(level.var_b8be892e, e_player.perks_active);
  e_player.var_62fef0f1 = array::random(var_cc1db3c1);

  if(!isDefined(e_player.var_62fef0f1)) {
    waitframe(1);
    return;
  }

  e_player.var_c27f1e90[n_slot] = e_player.var_62fef0f1;
  e_player notify(#"perk_purchased", {
    #perk: e_player.var_62fef0f1
  });
  e_player thread zm_perks::function_4acf7b43(n_slot, e_player.var_62fef0f1);
  self thread zm_perks::taking_cover_tanks_(e_player, e_player.var_62fef0f1, n_slot);
  e_player.var_ec426a71 = 0;
}

function function_8e7a6cf() {
  if(function_3f3752ab()) {
    return false;
  }

  return true;
}

function function_3f3752ab() {
  if(util::get_game_type() != "zclassic") {
    return false;
  }

  a_s_defaults = function_a8e9a6c7();

  foreach(s_default in a_s_defaults) {
    if(function_901b751c(s_default.name) !== s_default.default_val) {
      return true;
    }
  }

  return false;
}

function function_db030433() {
  self clientfield::increment_uimodel("zmhud.damage_point_shake");
}

function private function_74b79f63() {
  level thread function_214e109e();
  function_cd05a082();
  function_5b526135();
  function_928be07c();
  level waittill(#"all_players_spawned");
  function_7a8180ae();
  wait 5;

  switch (function_901b751c(#"zmdoorstate")) {
    case 1:
    default:
      break;
    case 2:
      players = getplayers();
      a_zombie_doors = getEntArray("zombie_door", "targetname");

      foreach(door in arraycopy(a_zombie_doors)) {
        if(isDefined(level.var_f3a008f)) {
          if(is_true(door[[level.var_f3a008f]]())) {
            arrayremovevalue(a_zombie_doors, door);
          }
        }
      }

      if(isDefined(level.var_229f30cd)) {
        level thread[[level.var_229f30cd]](a_zombie_doors);
      } else {
        for(i = 0; i < a_zombie_doors.size; i++) {
          if(!is_true(a_zombie_doors[i].has_been_opened)) {
            a_zombie_doors[i] notify(#"trigger", {
              #is_forced: 1
            });
          }

          waitframe(1);
        }

        var_38a6b7d0 = getEntArray("zombie_airlock_buy", "targetname");

        for(i = 0; i < var_38a6b7d0.size; i++) {
          var_38a6b7d0[i] notify(#"trigger", {
            #is_forced: 1
          });
          waitframe(1);
        }

        a_zombie_debris = getEntArray("zombie_debris", "targetname");

        for(i = 0; i < a_zombie_debris.size; i++) {
          if(isDefined(a_zombie_debris[i])) {
            a_zombie_debris[i] notify(#"trigger", {
              #is_forced: 1
            });
          }

          waitframe(1);
        }
      }

      break;
  }

  switch (function_901b751c(#"zmpowerdoorstate")) {
    case 1:
    default:
      break;
    case 2:
      a_zombie_doors = getEntArray("zombie_door", "targetname");

      foreach(door in a_zombie_doors) {
        if(!isDefined(door.script_noteworthy) || !isDefined(door.classname)) {
          continue;
        }

        if(isDefined(level.var_f3a008f)) {
          if(is_true(door[[level.var_f3a008f]]())) {
            continue;
          }
        }

        if(door.script_noteworthy == "electric_door" || door.script_noteworthy == "electric_buyable_door") {
          door thread zm_blockers::door_opened();

          if(isDefined(level.temporary_power_switch_logic)) {
            door.power_on = 1;
          }

          continue;
        }

        if(door.script_noteworthy === "local_electric_door") {
          door thread zm_blockers::door_opened();
        }
      }

      break;
  }

  switch (function_901b751c(#"zmpowerstate")) {
    case 1:
      break;
    case 2:
      level flag::set("power_on");
      level flag::set(#"hash_3e80d503318a5674");

      if(function_901b751c(#"zmpowerdoorstate") == 1) {
        a_zombie_doors = getEntArray("zombie_door", "targetname");

        foreach(door in a_zombie_doors) {
          if(!isDefined(door.script_noteworthy) || !isDefined(door.classname)) {
            continue;
          }

          if(isDefined(level.var_f3a008f)) {
            if(is_true(door[[level.var_f3a008f]]())) {
              continue;
            }
          }

          if(door.script_noteworthy == "electric_door" || door.script_noteworthy == "electric_buyable_door") {
            door thread zm_blockers::door_opened();

            if(isDefined(level.temporary_power_switch_logic)) {
              door.power_on = 1;
            }

            continue;
          }

          if(door.script_noteworthy === "local_electric_door") {
            door thread zm_blockers::door_opened();
          }
        }
      }
    case 0:
      a_trigs = getEntArray("use_elec_switch", "targetname");

      foreach(trig in a_trigs) {
        trig notify(#"hash_21e36726a7f30458");
        trig delete();
      }

      break;
    default:
      break;
  }

  if(!function_901b751c(#"zmpowerupnuke")) {
    zm_powerups::powerup_remove_from_regular_drops("nuke");
  }

  if(!function_901b751c(#"zmpowerupdouble")) {
    zm_powerups::powerup_remove_from_regular_drops("double_points");
  }

  if(!function_901b751c(#"zmpowerupinstakill")) {
    zm_powerups::powerup_remove_from_regular_drops("insta_kill");
  }

  if(!function_901b751c(#"zmpowerupchaospoints")) {
    zm_powerups::powerup_remove_from_regular_drops("bonus_points_player");
    zm_powerups::powerup_remove_from_regular_drops("bonus_points_team");
  }

  if(!function_901b751c(#"zmpowerupfiresale")) {
    zm_powerups::powerup_remove_from_regular_drops("fire_sale");
  }

  if(!function_901b751c(#"zmpowerupspecialweapon") || !function_901b751c(#"zmspecweaponisenabled")) {
    zm_powerups::powerup_remove_from_regular_drops("hero_weapon_power");
  }

  if(!function_901b751c(#"zmpowerupfreeperk")) {
    zm_powerups::powerup_remove_from_regular_drops("free_perk");
  }

  if(!function_901b751c(#"zmpowerupmaxammo")) {
    zm_powerups::powerup_remove_from_regular_drops("full_ammo");
  }

  if(!function_901b751c(#"zmpowerupcarpenter")) {
    zm_powerups::powerup_remove_from_regular_drops("carpenter");
  }

  if(!isDefined(level.var_cbc6587a)) {
    level.var_cbc6587a = [];
  }

  foreach(s_weap in level.zombie_weapons) {
    if(s_weap.weapon_classname == "pistol" && !function_901b751c(#"zmweaponspistol") || s_weap.weapon_classname == "shotgun" && !function_901b751c(#"zmweaponsshotgun") || s_weap.weapon_classname == "smg" && !function_901b751c(#"zmweaponssmg") || s_weap.weapon_classname == "ar" && !function_901b751c(#"zmweaponsar") || s_weap.weapon_classname == "tr" && !function_901b751c(#"zmweaponstr") || s_weap.weapon_classname == "lmg" && !function_901b751c(#"zmweaponslmg") || s_weap.weapon_classname == "sniper" && !function_901b751c(#"zmweaponssniper") || s_weap.weapon_classname == "melee" && !function_901b751c(#"zmweaponsknife") || s_weap.weapon_classname == "equipment" && !function_901b751c(#"zmequipmentisenabled")) {
      if(!isDefined(level.var_cbc6587a)) {
        level.var_cbc6587a = [];
      } else if(!isarray(level.var_cbc6587a)) {
        level.var_cbc6587a = array(level.var_cbc6587a);
      }

      if(!isinarray(level.var_cbc6587a, s_weap.weapon)) {
        level.var_cbc6587a[level.var_cbc6587a.size] = s_weap.weapon;
      }
    }
  }

  if(!function_901b751c(#"zmshieldisenabled")) {
    foreach(str_bp in array("zblueprint_shield", "zblueprint_shield_dual_wield", "zblueprint_zhield_zword", "zblueprint_shield_spectral_shield")) {
      zm_crafting::function_ca244624(hash(str_bp));
    }
  }

  if(!function_901b751c(#"zmbarricadestate")) {
    level.no_board_repair = 1;
    level flag::wait_till("all_players_spawned");
    zm_blockers::function_22642075();
    level.no_board_repair = 1;
  }

  switch (function_901b751c(#"zmequipmentchargerate")) {
    case 1:
      setgametypesetting("scoreEquipmentPowerTimeFactor", 1);
      break;
    case 2:
      setgametypesetting("scoreEquipmentPowerTimeFactor", 2);
      break;
    case 0:
      setgametypesetting("scoreEquipmentPowerTimeFactor", 0.5);
      break;
  }

  level flag::wait_till("all_players_spawned");
}

function private function_214e109e() {
  level waittill(#"start_of_round");

  if(function_901b751c(#"zmroundcap") && function_901b751c(#"startround") > function_901b751c(#"zmroundcap")) {
    wait 1;
    function_9be9c072("zmRoundCap");
  }
}

function private function_34c2aeb5() {
  self endon(#"disconnect");
  player = self;
  level flag::wait_till("all_players_spawned");
  n_regen_delay = function_901b751c(#"zmhealthregendelay");
  n_regen_rate = function_901b751c(#"zmhealthregenrate");
  n_health_on_kill = function_901b751c(#"zmhealthonkill");
  n_health_drain = function_901b751c(#"zmhealthdrain");

  switch (function_901b751c(#"zmhealthstartingbars")) {
    case 3:
    default:
      var_d75008e3 = 0;
      break;
    case 4:
      var_d75008e3 = 1;
      break;
    case 5:
      var_d75008e3 = 2;
      break;
    case 6:
      var_d75008e3 = 3;
      break;
    case 2:
      var_d75008e3 = -1;
      break;
    case 1:
      var_d75008e3 = -2;
      break;
    case 0:
      var_d75008e3 = -3;
      break;
  }

  n_target = int(max(zombie_utility::get_zombie_var(#"player_base_health") + 50 * var_d75008e3, 1));
  n_mod = math::clamp(n_target - player.var_66cb03ad, 0, n_target);
  player player::function_2a67df65(#"custom_settings", n_mod);
  player.var_66cb03ad = n_target;
  player.maxhealth = n_target;
  player setmaxhealth(n_target);
  player zm_utility::set_max_health();
  println("<dev string:x66>" + player.name + "<dev string:x72>" + player.var_66cb03ad);

  switch (n_regen_delay) {
    case 0:
      player.n_regen_delay = 2;
      break;
    case 1:
      player.n_regen_delay = zombie_utility::get_zombie_var("player_health_regen_delay");
      break;
    case 2:
      player.n_regen_delay = 8;
      break;
  }

  switch (n_regen_rate) {
    case 0:
      player.var_44d52546 = 1;
      break;
    case 1:
      player.n_regen_rate = 50;
      break;
    case 2:
      player.n_regen_rate = zombie_utility::get_zombie_var("player_health_regen_rate");
      break;
    case 3:
      player.n_regen_rate = 12.5;
      break;
    case 4:
      player.n_regen_rate = 0;
      break;
  }

  switch (n_health_on_kill) {
    case 0:
      break;
    case 1:
      player.n_health_on_kill = 10;
      break;
    case 2:
      player.n_health_on_kill = 25;
      break;
    case 3:
      player.n_health_on_kill = 50;
      break;
  }

  switch (n_health_drain) {
    case 0:
      break;
    case 1:
      player thread drain_health(6);
      break;
    case 2:
      player thread drain_health(3);
      break;
    case 3:
      player thread drain_health(1);
      break;
  }
}

function private drain_health(var_c454f44e) {
  self notify(#"hash_13fcb28a561bd5fe");
  self endon(#"disconnect", #"hash_13fcb28a561bd5fe");
  level endon(#"game_ended");
  self val::set(#"custom_games", "health_regen", 0);

  while(zombie_utility::get_current_zombie_count() == 0) {
    waitframe(1);
  }

  while(true) {
    wait var_c454f44e;

    if(self.health <= 0 || self laststand::player_is_in_laststand() || is_true(self.var_eb319d10)) {
      waitframe(1);
      continue;
    }

    if(self.health <= 5) {
      if(zm_utility::is_magic_bullet_shield_enabled(self)) {
        self util::stop_magic_bullet_shield();
      }

      self dodamage(self.health + 1000, self.origin);
      continue;
    }

    self dodamage(5, self.origin);
  }
}

function private function_e57809dd(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex) {
  if(boneindex > 0) {
    boneindex = max(int(boneindex * 0.25), 1);
  }

  return boneindex;
}

function private function_4225c3b7(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex) {
  if(boneindex > 0) {
    boneindex = max(int(boneindex * 0.25), 1);
  }

  psoffsettime dodamage(boneindex, self.origin);
  return false;
}

function private function_6607cdee(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex) {
  if(boneindex > 0) {
    boneindex = max(int(boneindex * 0.25 / 2), 1);
  }

  psoffsettime dodamage(boneindex, self.origin);
  return boneindex;
}

function private function_cd05a082() {
  var_320de887 = function_901b751c(#"zmpointsfixed");
  var_46e28538 = function_901b751c(#"zmpointsstarting") * 100;
  var_1f9ee1b2 = function_901b751c(#"hash_5566698b97a6282e");
  var_58d18c72 = function_901b751c(#"zmpointslosstype");
  var_523e89f3 = function_901b751c(#"zmpointslosspercent");
  var_39215b53 = function_901b751c(#"zmpointslossvalue");

  if(var_46e28538 != 500) {
    level.player_starting_points = var_46e28538;
  }

  if(var_320de887) {
    level.var_894a83d8 = 1;
  }

  if(var_58d18c72) {
    if(var_58d18c72 == 1) {
      level.var_a2d8b7eb = var_523e89f3 / 100;
      return;
    }

    level.var_39e18a71 = var_39215b53;
  }
}

function private function_c25113() {
  self endon(#"disconnect");
  level flag::wait_till("start_zombie_round_logic");
  waitframe(1);
  var_629da31e = function_901b751c(#"zmlaststandduration");

  switch (var_629da31e) {
    case 0:
      self.var_39c78617 = 1;
      self zm_laststand::function_3d685b5f(0);
      return;
    case 1:
      self.var_b92e42da = 20;
      break;
    case 2:
      break;
    case 3:
      self.var_b92e42da = 60;
      break;
  }
}

function private function_8abf3abd() {
  if(!function_901b751c(#"zmweaponsmelee")) {
    self allowmelee(0);
    self thread function_bfc2f3f1();
    self thread function_dc856fd8();
  }
}

function private function_99c0cc77() {
  if(!function_901b751c(#"zmequipmentisenabled") && isDefined(self.slot_weapons[#"lethal_grenade"])) {
    self takeweapon(self.slot_weapons[#"lethal_grenade"]);
  }

  if(!function_901b751c(#"zmweaponspistol") && self hasweapon(getweapon(#"pistol_topbreak_t8"))) {}
}

function private function_bfc2f3f1() {
  self endon(#"death");

  while(true) {
    self waittill(#"hero_weapon_power_on");
    self allowmelee(1);
    self waittill(#"hero_weapon_power_off");
    self allowmelee(0);
  }
}

function private function_dc856fd8() {
  self endon(#"death");

  while(true) {
    self waittill(#"crafting_fail", #"crafting_success", #"bgb_update");
    self allowmelee(0);
  }
}

function private function_7a8180ae() {
  var_52e65b4 = function_901b751c(#"zmcrawlerstate");
  var_a98f5518 = function_901b751c(#"zmzombiespread");
  var_1b9aa497 = function_901b751c(#"zmzombieminspeed");
  var_34f5f077 = function_901b751c(#"zmzombiemaxspeed");
  var_46e03bb6 = function_901b751c(#"zmzombiehealthmult");
  var_c739ead9 = function_901b751c(#"zmzombiedamagemult");

  switch (var_52e65b4) {
    case 1:
      break;
    case 0:
      level.var_41259f0d = 1;
      break;
    case 2:
      level.var_6d8a8e47 = 1;
      break;
  }

  switch (var_a98f5518) {
    case 0:
      level.zigzag_activation_distance = 256;
      level.inner_zigzag_radius = 0;
      level.outer_zigzag_radius = 16;
      level.zigzag_distance_min = 16;
      level.zigzag_distance_max = 512;
      break;
    case 1:
      break;
    case 2:
      level.zigzag_activation_distance = 16;
      level.inner_zigzag_radius = 256;
      level.outer_zigzag_radius = 2048;
      level.zigzag_distance_min = 128;
      level.zigzag_distance_max = 1024;
      break;
  }

  switch (var_1b9aa497) {
    case 0:
      break;
    case 1:
      level.var_43fb4347 = "run";
      break;
    case 2:
      level.var_43fb4347 = "sprint";
      break;
    case 3:
      level.var_43fb4347 = "super_sprint";
      break;
  }

  switch (var_34f5f077) {
    case 0:
      level.var_102b1301 = "walk";
      break;
    case 1:
      level.var_102b1301 = "run";
      break;
    case 2:
      level.var_102b1301 = "sprint";
      break;
    case 3:
      break;
  }

  switch (var_c739ead9) {
    case 1:
      break;
    case 0:
      level.var_c739ead9 = 0.5;
      break;
    case 2:
      level.var_c739ead9 = 2;
      break;
  }

  switch (var_46e03bb6) {
    case 1:
      break;
    case 0:
      level.var_46e03bb6 = 0.5;
      break;
    case 2:
      level.var_46e03bb6 = 2;
      break;
  }
}

function private function_5b526135() {
  var_525c797b = function_901b751c(#"hash_69262a31e0f8f91c");
  var_cfbc34ae = function_901b751c(#"hash_47683a928d3b5c50");
  var_6a6ab4ce = function_901b751c(#"hash_260fe4ac4d0ee7c7");
  var_d46f8e18 = function_901b751c(#"hash_35ac79d2ca5673c8");
  var_9b9f6d3d = function_901b751c(#"hash_4269e873a0c207c");
  var_5a59b382 = function_901b751c(#"hash_407d7afcff755230");
  var_8593895d = function_901b751c(#"hash_3e1334207938d6a7");
  var_8670c016 = function_901b751c(#"hash_443cfbf2a6fbc040");
  var_47a77473 = function_901b751c(#"hash_4035c12ee5837454");
  var_97850f30 = function_901b751c(#"hash_2d0db902620447a8");
  var_f2b4495f = function_901b751c(#"hash_29b057ccce3ee75f");
  var_12c07114 = function_901b751c(#"hash_35ac79d2ca5673c8");

  switch (var_525c797b) {
    case 1:
      break;
    case 0:
      level.var_ef0aada0 = 1;
      break;
    case 2:
      level.var_5931f93f = 1;
      level.var_78acec0a = 1;
      level.var_f38e5f93 = 0.2;
      break;
  }

  switch (var_cfbc34ae) {
    case 1:
      break;
    case 0:
      level.var_cfbc34ae = 0.5;
      break;
    case 2:
      level.var_cfbc34ae = 2;
      break;
  }

  switch (var_6a6ab4ce) {
    case 1:
      break;
    case 0:
      level.var_6a6ab4ce = 0.5;
      break;
    case 2:
      level.var_6a6ab4ce = 2;
      break;
  }

  switch (var_d46f8e18) {
    case 1:
    default:
      break;
    case 0:
      level.var_66682370 = 0.5;
      break;
    case 2:
      level.var_66682370 = 2;
      break;
    case 3:
      level.var_66682370 = 4;
      break;
  }

  switch (var_9b9f6d3d) {
    case 1:
      break;
    case 0:
      level.var_b38bb71 = 1;
      break;
    case 2:
      level.var_d3e01096 = 1;
      level.var_78acec0a = 1;
      level.var_f38e5f93 = 0.2;
      break;
  }

  switch (var_5a59b382) {
    case 1:
      break;
    case 0:
      level.var_5a59b382 = 0.5;
      break;
    case 2:
      level.var_5a59b382 = 2;
      break;
  }

  switch (var_8593895d) {
    case 1:
      break;
    case 0:
      level.var_8593895d = 0.5;
      break;
    case 2:
      level.var_8593895d = 2;
      break;
  }

  switch (var_8670c016) {
    case 1:
    default:
      break;
    case 0:
      level.var_397ca369 = 0.5;
      break;
    case 2:
      level.var_397ca369 = 2;
      break;
    case 3:
      level.var_397ca369 = 4;
      break;
  }

  switch (var_47a77473) {
    case 1:
      break;
    case 0:
      level.var_1931799d = 1;
      break;
    case 2:
      level.var_d56511a2 = 1;
      break;
  }

  switch (var_97850f30) {
    case 1:
      break;
    case 0:
      level.var_97850f30 = 0.5;
      break;
    case 2:
      level.var_97850f30 = 2;
      break;
  }

  switch (var_f2b4495f) {
    case 1:
      break;
    case 0:
      level.var_f2b4495f = 0.5;
      break;
    case 2:
      level.var_f2b4495f = 2;
      break;
  }

  switch (var_12c07114) {
    case 1:
    default:
      break;
    case 0:
      level.var_6a9f25ba = 0.5;
      break;
    case 2:
      level.var_6a9f25ba = 2;
      break;
    case 3:
      level.var_6a9f25ba = 4;
      break;
  }

  if(is_true(level.var_d3e01096)) {
    setgametypesetting(#"zmspecialroundsenabled", 0);
    level.var_ef0aada0 = 1;
    level.var_1931799d = 1;
    level.var_81bce2c8 = 1;
    return;
  }

  if(is_true(level.var_5931f93f)) {
    setgametypesetting(#"zmspecialroundsenabled", 0);
    level.var_b38bb71 = 1;
    level.var_1931799d = 1;
    level.var_888f3e2 = 1;
    return;
  }

  if(is_true(level.var_90534a4f)) {
    setgametypesetting(#"zmspecialroundsenabled", 0);
    level.var_b38bb71 = 1;
    level.var_ef0aada0 = 1;
    level.var_1931799d = 1;
    return;
  }

  if(is_true(level.var_d56511a2)) {
    setgametypesetting(#"zmspecialroundsenabled", 0);
    level.var_b38bb71 = 1;
    level.var_ef0aada0 = 1;
  }
}

function function_a00576dd(var_59459749, var_7fe52f51, var_8ccdc1e3) {
  if(is_true(level.var_d3e01096)) {
    level.var_78afc69 = var_59459749;
    return;
  }

  if(is_true(level.var_5931f93f)) {
    level.var_78afc69 = var_7fe52f51;
    return;
  }

  if(is_true(level.var_d56511a2)) {
    level.var_78afc69 = var_8ccdc1e3;
  }
}

function private function_6129676c() {
  timer = function_901b751c(#"zmtimecap") * 60;

  if(timer === 0) {
    return;
  }

  level endon(#"game_ended");
  level flag::wait_till("gameplay_started");
  clientfield::set_world_uimodel("ZMHudGlobal.trials.gameStartTime", gettime());
  wait timer;
  function_9be9c072("zmTimeCap");
}

function private function_c2ebdc07() {
  self endon(#"disconnect");
  self waittill(#"spawned");

  if(level.players.size < 4) {
    bot::add_bot(self.team);
  }
}

function private function_401f18e6() {
  if(!function_901b751c(#"zmspecialroundsenabled")) {
    while(!flag::exists(#"disable_special_rounds")) {
      waitframe(1);
    }

    level flag::set(#"disable_special_rounds");
  }

  n_start = function_901b751c(#"startround");

  if(n_start > 1) {
    level waittill(#"start_of_round");

    for(i = 0; i < n_start; i++) {
      if(isDefined(level.var_45827161) && isDefined(level.var_45827161[i])) {
        for(var_830a0b65 = i + n_start; isDefined(level.var_45827161[var_830a0b65]); var_830a0b65++) {}

        level.var_45827161[var_830a0b65] = level.var_45827161[i];
      }
    }
  }
}

function private function_a8e9a6c7() {
  return array({
    #name: # "startround", #default_val: 1
  }, {
    #name: # "headshotsonly", #default_val: 0
  }, {
    #name: # "zmroundcap", #default_val: 0
  }, {
    #name: # "zmtimecap", #default_val: 0
  }, {
    #name: # "zmshowtimer", #default_val: 0
  }, {
    #name: # "zmkillcap", #default_val: 0
  }, {
    #name: # "zmdoorstate", #default_val: 1
  }, {
    #name: # "zmspecialroundsenabled", #default_val: 1
  }, {
    #name: # "zmendonquest", #default_val: 0
  }, {
    #name: # "zmmysteryboxstate", #default_val: 2
  }, {
    #name: # "hash_5d65c0983698a539", #default_val: 0
  }, {
    #name: # "zmmysteryboxlimitmove", #default_val: 0
  }, {
    #name: # "hash_23fe21eb92ffbc2c", #default_val: 0
  }, {
    #name: # "zmmysteryboxlimit", #default_val: 0
  }, {
    #name: # "hash_751384283abde22c", #default_val: 0
  }, {
    #name: # "zmmysteryboxlimitround", #default_val: 0
  }, {
    #name: # "zmpowerstate", #default_val: 1
  }, {
    #name: # "zmpowerdoorstate", #default_val: 1
  }, {
    #name: # "zmperksactive", #default_val: 1
  }, {
    #name: # "zmperksjuggernaut", #default_val: 1
  }, {
    #name: # "zmperksspeed", #default_val: 1
  }, {
    #name: # "zmperksquickrevive", #default_val: 1
  }, {
    #name: # "zmperkswidowswail", #default_val: 1
  }, {
    #name: # "zmperksstaminup", #default_val: 1
  }, {
    #name: # "zmperksmulekick", #default_val: 1
  }, {
    #name: # "zmperkselectricburst", #default_val: 1
  }, {
    #name: # "zmperksdeadshot", #default_val: 1
  }, {
    #name: # "zmperkscooldown", #default_val: 1
  }, {
    #name: # "zmperksdyingwish", #default_val: 1
  }, {
    #name: # "zmpapenabled", #default_val: 1
  }, {
    #name: # "zmsuperpapenabled", #default_val: 1
  }, {
    #name: # "zmpowerupsactive", #default_val: 1
  }, {
    #name: # "zmpowerupnuke", #default_val: 1
  }, {
    #name: # "zmpowerupdouble", #default_val: 1
  }, {
    #name: # "zmpowerupinstakill", #default_val: 1
  }, {
    #name: # "zmpowerupchaospoints", #default_val: 1
  }, {
    #name: # "zmpowerupfiresale", #default_val: 1
  }, {
    #name: # "zmpowerupspecialweapon", #default_val: 1
  }, {
    #name: # "zmpowerupfreeperk", #default_val: 1
  }, {
    #name: # "zmpowerupmaxammo", #default_val: 1
  }, {
    #name: # "zmpowerupcarpenter", #default_val: 1
  }, {
    #name: # "zmpowerupsislimitedround", #default_val: 0
  }, {
    #name: # "zmpowerupslimitround", #default_val: 1
  }, {
    #name: # "zmpowerupsharing", #default_val: 1
  }, {
    #name: # "zmwallbuysenabled", #default_val: 1
  }, {
    #name: # "zmrandomwallbuys", #default_val: 0
  }, {
    #name: # "zmelixirsenabled", #default_val: 1
  }, {
    #name: # "zmelixirscooldown", #default_val: 1
  }, {
    #name: # "zmelixirsindividual", #default_val: 1
  }, {
    #name: # "zmelixirsdurables", #default_val: 1
  }, {
    #name: # "zmelixirscommon", #default_val: 1
  }, {
    #name: # "zmelixirsrare", #default_val: 1
  }, {
    #name: # "zmelixirslegendary", #default_val: 1
  }, {
    #name: # "zmelixirsepic", #default_val: 1
  }, {
    #name: # "zmtalismansenabled", #default_val: 1
  }, {
    #name: # "zmtalismansindividual", #default_val: 1
  }, {
    #name: # "zmtalismanscommon", #default_val: 1
  }, {
    #name: # "zmtalismansrare", #default_val: 1
  }, {
    #name: # "zmtalismanslegendary", #default_val: 1
  }, {
    #name: # "zmtalismansepic", #default_val: 1
  }, {
    #name: # "zmweaponspistol", #default_val: 1
  }, {
    #name: # "zmweaponsshotgun", #default_val: 1
  }, {
    #name: # "zmweaponssmg", #default_val: 1
  }, {
    #name: # "zmweaponsar", #default_val: 1
  }, {
    #name: # "zmweaponstr", #default_val: 1
  }, {
    #name: # "zmweaponslmg", #default_val: 1
  }, {
    #name: # "zmweaponssniper", #default_val: 1
  }, {
    #name: # "zmweaponsknife", #default_val: 1
  }, {
    #name: # "zmweaponsmelee", #default_val: 1
  }, {
    #name: # "zmspecweaponisenabled", #default_val: 1
  }, {
    #name: # "zmspecweaponchargerate", #default_val: 1
  }, {
    #name: # "zmwonderweaponisenabled", #default_val: 1
  }, {
    #name: # "zmequipmentisenabled", #default_val: 1
  }, {
    #name: # "zmequipmentchargerate", #default_val: 1
  }, {
    #name: # "zmshieldisenabled", #default_val: 1
  }, {
    #name: # "zmshielddurability", #default_val: 1
  }, {
    #name: # "zmheadshotsonly", #default_val: 0
  }, {
    #name: # "zmrunnerstate", #default_val: 0
  }, {
    #name: # "zmwalkerstate", #default_val: 0
  }, {
    #name: # "zmcrawlerstate", #default_val: 1
  }, {
    #name: # "zmzombiespread", #default_val: 1
  }, {
    #name: # "zmzombieminspeed", #default_val: 0
  }, {
    #name: # "zmzombiemaxspeed", #default_val: 3
  }, {
    #name: # "zmzombiedamagemult", #default_val: 1
  }, {
    #name: # "zmzombiehealthmult", #default_val: 1
  }, {
    #name: # "zmcrawlerdamagemult", #default_val: 1
  }, {
    #name: # "zmcrawlerhealthmult", #default_val: 1
  }, {
    #name: # "zmcrawleraggro", #default_val: 1
  }, {
    #name: # "hash_69262a31e0f8f91c", #default_val: 1
  }, {
    #name: # "hash_47683a928d3b5c50", #default_val: 1
  }, {
    #name: # "hash_260fe4ac4d0ee7c7", #default_val: 1
  }, {
    #name: # "hash_2f2281537f0463f7", #default_val: 1
  }, {
    #name: # "hash_4269e873a0c207c", #default_val: 1
  }, {
    #name: # "hash_407d7afcff755230", #default_val: 1
  }, {
    #name: # "hash_3e1334207938d6a7", #default_val: 1
  }, {
    #name: # "hash_4a23f5a8d8193e57", #default_val: 1
  }, {
    #name: # "zmhealthstartingbars", #default_val: 3
  }, {
    #name: # "zmhealthregendelay", #default_val: 1
  }, {
    #name: # "zmhealthregenrate", #default_val: 2
  }, {
    #name: # "zmhealthonkill", #default_val: 0
  }, {
    #name: # "zmhealthdrain", #default_val: 0
  }, {
    #name: # "zmpointsfixed", #default_val: 0
  }, {
    #name: # "zmpointsstarting", #default_val: 5
  }, {
    #name: # "hash_5566698b97a6282e", #default_val: 0
  }, {
    #name: # "zmpointslosstype", #default_val: 0
  }, {
    #name: # "zmpointslosspercent", #default_val: 1
  }, {
    #name: # "zmpointslossvalue", #default_val: 100
  }, {
    #name: # "zmlaststandduration", #default_val: 2
  }, {
    #name: # "hash_12f776f6bc579bb4", #default_val: 0
  }, {
    #name: # "zmlimiteddownsamount", #default_val: 0
  }, {
    #name: # "zmbarricadestate", #default_val: 1
  }, {
    #name: # "hash_3c5363541b97ca3e", #default_val: 1
  }, {
    #name: # "zmpowerupfrequency", #default_val: 1
  }, {
    #name: # "zmtalismanboxguaranteeboxonly", #default_val: 1
  }, {
    #name: # "zmtalismanboxguaranteelmg", #default_val: 1
  }, {
    #name: # "hash_61695e52556ff2d1", #default_val: 1
  }, {
    #name: # "zmtalismancoagulant", #default_val: 1
  }, {
    #name: # "zmtalismanextraclaymore", #default_val: 1
  }, {
    #name: # "zmtalismanextrafrag", #default_val: 1
  }, {
    #name: # "zmtalismanextraminiturret", #default_val: 1
  }, {
    #name: # "zmtalismanextramolotov", #default_val: 1
  }, {
    #name: # "zmtalismanextrasemtex", #default_val: 1
  }, {
    #name: # "zmtalismanimpatient", #default_val: 1
  }, {
    #name: # "zmtalismanperkmodsingle", #default_val: 1
  }, {
    #name: # "zmtalismanperkpermanent1", #default_val: 1
  }, {
    #name: # "zmtalismanperkpermanent2", #default_val: 1
  }, {
    #name: # "zmtalismanperkpermanent3", #default_val: 1
  }, {
    #name: # "zmtalismanperkpermanent4", #default_val: 1
  }, {
    #name: # "zmtalismanperkreducecost1", #default_val: 1
  }, {
    #name: # "zmtalismanperkreducecost2", #default_val: 1
  }, {
    #name: # "zmtalismanperkreducecost3", #default_val: 1
  }, {
    #name: # "zmtalismanperkreducecost4", #default_val: 1
  }, {
    #name: # "zmtalismanperkstart1", #default_val: 1
  }, {
    #name: # "zmtalismanperkstart2", #default_val: 1
  }, {
    #name: # "zmtalismanperkstart3", #default_val: 1
  }, {
    #name: # "zmtalismanperkstart4", #default_val: 1
  }, {
    #name: # "zmtalismanshielddurabilitylegendary", #default_val: 1
  }, {
    #name: # "zmtalismanshielddurabilityrare", #default_val: 1
  }, {
    #name: # "zmtalismanshieldprice", #default_val: 1
  }, {
    #name: # "zmtalismanspecialstartlvl2", #default_val: 1
  }, {
    #name: # "zmtalismanspecialstartlvl3", #default_val: 1
  }, {
    #name: # "zmtalismanspecialxprate", #default_val: 1
  }, {
    #name: # "zmtalismanstartweaponar", #default_val: 1
  }, {
    #name: # "zmtalismanstartweaponlmg", #default_val: 1
  }, {
    #name: # "zmtalismanstartweaponsmg", #default_val: 1
  }, {
    #name: # "zmtalismanreducepapcost", #default_val: 1
  }, {
    #name: # "zmtalismansultra", #default_val: 1
  }, {
    #name: # "zmelixiralwaysdoneswiftly", #default_val: 1
  }, {
    #name: # "zmelixiranywherebuthere", #default_val: 1
  }, {
    #name: # "zmelixirarsenalaccelerator", #default_val: 1
  }, {
    #name: # "zmelixirdangerclosest", #default_val: 1
  }, {
    #name: # "zmelixirinplainsight", #default_val: 1
  }, {
    #name: # "zmelixirnewtoniannegation", #default_val: 1
  }, {
    #name: # "zmelixirnowyouseeme", #default_val: 1
  }, {
    #name: # "zmelixirstockoption", #default_val: 1
  }, {
    #name: # "zmelixirboardgames", #default_val: 1
  }, {
    #name: # "zmelixirburnedout", #default_val: 1
  }, {
    #name: # "zmelixircrawlspace", #default_val: 1
  }, {
    #name: # "zmelixirpopshocks", #default_val: 1
  }, {
    #name: # "zmelixirtemporalgift", #default_val: 1
  }, {
    #name: # "zmelixirpointdrops", #default_val: 1
  }, {
    #name: # "zmelixiralchemicalantithesis", #default_val: 1
  }, {
    #name: # "zmelixirswordflay", #default_val: 1
  }, {
    #name: # "zmelixirdeadofnuclearwinter", #default_val: 1
  }, {
    #name: # "zmelixirlicensedcontractor", #default_val: 1
  }, {
    #name: # "zmelixirundeadmanwalking", #default_val: 1
  }, {
    #name: # "zmelixirwhoskeepingscore", #default_val: 1
  }, {
    #name: # "zmelixiraftertaste", #default_val: 1
  }, {
    #name: # "zmelixirextracredit", #default_val: 1
  }, {
    #name: # "zmelixirkilljoy", #default_val: 1
  }, {
    #name: # "zmelixirsodafountain", #default_val: 1
  }, {
    #name: # "zmelixirctrlz", #default_val: 1
  }, {
    #name: # "zmelixirfreefire", #default_val: 1
  }, {
    #name: # "zmelixircacheback", #default_val: 1
  }, {
    #name: # "zmelixirimmolationliquidation", #default_val: 1
  }, {
    #name: # "zmelixirphoenixup", #default_val: 1
  }, {
    #name: # "zmelixirpowerkeg", #default_val: 1
  }, {
    #name: # "zmelixirblooddebt", #default_val: 1
  }, {
    #name: # "zmelixirneardeathexperience", #default_val: 1
  }, {
    #name: # "zmelixirperkaholic", #default_val: 1
  }, {
    #name: # "zmelixirwallpower", #default_val: 1
  }, {
    #name: # "hash_429b520a87274afb", #default_val: 0
  }, {
    #name: # "zmtrapsenabled", #default_val: 1
  }, {
    #name: # "zmstartingweaponenabled", #default_val: 1
  }, {
    #name: # "hash_35ac79d2ca5673c8", #default_val: 1
  }, {
    #name: # "hash_443cfbf2a6fbc040", #default_val: 1
  }, {
    #name: # "zmselfreviveamount", #default_val: 0
  }, {
    #name: # "hash_4035c12ee5837454", #default_val: 1
  }, {
    #name: # "hash_2d0db902620447a8", #default_val: 1
  }, {
    #name: # "hash_29b057ccce3ee75f", #default_val: 1
  }, {
    #name: # "hash_35ac79d2ca5673c8", #default_val: 1
  }, {
    #name: # "zmretainweapons", #default_val: 1
  }, {
    #name: # "zmperkdecay", #default_val: 1
  }, {
    #name: # "zmcraftingkeyline", #default_val: 0
  }, {
    #name: # "zmpointlossondown", #default_val: 0
  }, {
    #name: # "zmpointlossondeath", #default_val: 0
  }, {
    #name: # "zmpointlossonteammatedeath", #default_val: 0
  }, {
    #name: # "zmelixirantientrapment", #default_val: 1
  }, {
    #name: # "zmelixirequipmint", #default_val: 1
  }, {
    #name: # "zmelixirheadscan", #default_val: 1
  }, {
    #name: # "zmelixirjointheparty", #default_val: 1
  }, {
    #name: # "zmelixirnowherebutthere", #default_val: 1
  }, {
    #name: # "zmelixirphantomreload", #default_val: 1
  }, {
    #name: # "zmelixirshieldsup", #default_val: 1
  }, {
    #name: # "zmelixirwalltowall", #default_val: 1
  }, {
    #name: # "zmperksbandolier", #default_val: 1
  }, {
    #name: # "zmperksdeathperception", #default_val: 1
  }, {
    #name: # "zmperksphdslider", #default_val: 1
  }, {
    #name: # "zmperkssecretsauce", #default_val: 1
  }, {
    #name: # "zmperksstonecold", #default_val: 1
  }, {
    #name: # "zmperkswolfprotector", #default_val: 1
  }, {
    #name: # "zmperksvictorious", #default_val: 1
  }, {
    #name: # "zmfriendlyfiretype", #default_val: 0
  }, {
    #name: # "zmelixirconflagrationliquidation", #default_val: 1
  }, {
    #name: # "zmelixirperkup", #default_val: 1
  }, {
    #name: # "zmelixirrefreshmint", #default_val: 1
  });
}

function function_185687d7(event) {
  return false;
}

function private function_3ca8ca85() {
  if(getdvarint(#"hash_459b2d01242f9fd4", 0)) {
    setgametypesetting("<dev string:x92>", 9);
    setgametypesetting("<dev string:xa0>", 2);
    setgametypesetting("<dev string:xba>", 2);
    setgametypesetting("<dev string:xba>", 2);
    setgametypesetting("<dev string:xcf>", 0);
    setgametypesetting("<dev string:xe5>", 1);
    setgametypesetting("<dev string:xfa>", 9);
    setgametypesetting("<dev string:x112>", 2);
    setgametypesetting("<dev string:x128>", 1);
    setgametypesetting("<dev string:x13c>", 9);
  }

  if(getdvarint(#"hash_18b717f0d84d2ee6", 0)) {
    setgametypesetting("<dev string:x153>", 4);
    setgametypesetting("<dev string:x92>", 6);
    setgametypesetting("<dev string:x16b>", 1);
    setgametypesetting("<dev string:xba>", 2);
    setgametypesetting("<dev string:x17f>", 2);
    setgametypesetting("<dev string:x196>", 0);
    setgametypesetting("<dev string:x1aa>", 0);
  }

  if(getdvarint(#"hash_712656a2976e26c6", 0)) {
    setgametypesetting("<dev string:x1bf>", 40);
    setgametypesetting("<dev string:x1d3>", 1);
    setgametypesetting("<dev string:x1e4>", 0);
    setgametypesetting("<dev string:x1f9>", 3);
    setgametypesetting("<dev string:x20e>", 0);
    setgametypesetting("<dev string:x221>", 0);
    setgametypesetting("<dev string:x237>", 0);
    setgametypesetting("<dev string:x24f>", 0);
    setgametypesetting("<dev string:x264>", 0);
    setgametypesetting("<dev string:x279>", 0);
    setgametypesetting("<dev string:x28f>", 1);
    setgametypesetting("<dev string:x2a7>", 3);
    setgametypesetting("<dev string:x2be>", 0);
    setgametypesetting("<dev string:x2d1>", 0);
  }

  if(getdvarint(#"hash_6e1983b84de27c22", 0)) {
    setgametypesetting("<dev string:x153>", 6);
    setgametypesetting("<dev string:xe5>", 4);
    setgametypesetting("<dev string:x2e1>", 3);
    setgametypesetting("<dev string:x2f2>", 2);
    setgametypesetting("<dev string:xfa>", 10);
    setgametypesetting("<dev string:x92>", 5);
    setgametypesetting("<dev string:x304>", 0);
    setgametypesetting("<dev string:xba>", 2);
    setgametypesetting("<dev string:x31a>", 0);
    setgametypesetting("<dev string:x32e>", 0);
    setgametypesetting("<dev string:x344>", 0);
    setgametypesetting("<dev string:x357>", 2);
  }
}

function private function_172decfc() {
  level endon(#"game_ended");
  level waittill(#"all_players_spawned");
  var_325bac97 = function_338abd6d();
  var_32d62863 = array();
  var_210f7603 = 0;
  var_ecc27a73 = 0;

  foreach(s_var in var_325bac97) {
    if(s_var.name.size > var_ecc27a73) {
      var_ecc27a73 = s_var.name.size;
    }
  }

  for(i = 0; i < var_325bac97.size; i++) {
    var_2f572bbb = "<dev string:x378>";

    for(j = 0; j < var_ecc27a73 - var_325bac97[i].size; j++) {
      var_2f572bbb += "<dev string:x37c>";
    }

    var_2f572bbb += var_325bac97[i].name + "<dev string:x381>";

    if(var_325bac97[i].state[0] != "<dev string:x378>" && isDefined(var_325bac97[i].state[int(getgametypesetting(var_325bac97[i].name))])) {
      var_2f572bbb += var_325bac97[i].state[int(getgametypesetting(var_325bac97[i].name))];

      for(j = 0; j < 13 - var_325bac97[i].state[int(getgametypesetting(var_325bac97[i].name))].size; j++) {
        var_2f572bbb += "<dev string:x37c>";
      }
    } else {
      var_2f572bbb += getgametypesetting(var_325bac97[i].name);

      for(j = 0; j < 13 - string(getgametypesetting(var_325bac97[i].name)).size; j++) {
        var_2f572bbb += "<dev string:x37c>";
      }
    }

    array::add(var_32d62863, var_2f572bbb);
  }

  var_5f0a1940 = 0;
  var_af35ffa2 = 0;

  if(function_3f3752ab()) {
    for(i = 0; i < var_325bac97.size; i++) {
      if(floor(getgametypesetting(var_325bac97[i].name)) != var_325bac97[i].default_val) {
        var_5f0a1940++;

        if(var_5f0a1940 > 29) {
          var_5f0a1940 -= 29;
          var_af35ffa2++;
        }

        v_pos = 300 + 18 * var_5f0a1940;
        var_f993b45d = 200 + 400 * var_af35ffa2;
        debug2dtext((var_f993b45d, v_pos, 0), var_32d62863[i], (0, 1, 0), undefined, (0, 0, 0), 0.75, 0.85, 360);
      }
    }
  }
}

function private function_338abd6d() {
  return array({
    #name: "<dev string:x92>", #default_val: 1, #state: array("<dev string:x378>")
  }, {
    #name: "<dev string:x388>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x39e>", #default_val: 0, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x3ab>", #default_val: 0, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x3bc>", #default_val: 0, #state: array("<dev string:x378>")
  }, {
    #name: "<dev string:x3cf>", #default_val: 0, #state: array("<dev string:x378>")
  }, {
    #name: "<dev string:x3dd>", #default_val: 0, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x3ea>", #default_val: 0, #state: array("<dev string:x378>")
  }, {
    #name: "<dev string:x3f9>", #default_val: 0, #state: array("<dev string:x378>")
  }, {
    #name: "<dev string:x406>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x415>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x42f>", #default_val: 0, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x1f9>", #default_val: 2, #state: array("<dev string:x391>", "<dev string:x43f>", "<dev string:x450>", "<dev string:x45b>")
  }, {
    #name: "<dev string:x465>", #default_val: 0, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x482>", #default_val: 0, #state: array("<dev string:x378>")
  }, {
    #name: "<dev string:x49b>", #default_val: 0, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x4b4>", #default_val: 0, #state: array("<dev string:x378>")
  }, {
    #name: "<dev string:x4c9>", #default_val: 0, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x4e7>", #default_val: 0, #state: array("<dev string:x378>")
  }, {
    #name: "<dev string:x501>", #default_val: 1, #state: array("<dev string:x511>", "<dev string:x450>", "<dev string:x51b>")
  }, {
    #name: "<dev string:x523>", #default_val: 1, #state: array("<dev string:x511>", "<dev string:x450>", "<dev string:x51b>")
  }, {
    #name: "<dev string:x537>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x548>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x55d>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x32e>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x56d>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x582>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x595>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x5a8>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x5c0>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x344>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x31a>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x5d3>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x450>", "<dev string:x5e3>")
  }, {
    #name: "<dev string:x5f0>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x605>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x619>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x20e>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x221>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x237>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x24f>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x62a>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x264>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x644>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x279>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x658>", #default_val: 0, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x28f>", #default_val: 1, #state: array("<dev string:x378>")
  }, {
    #name: "<dev string:x674>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x1e4>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x688>", #default_val: 0, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x69c>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x6b0>", #default_val: 1, #state: array("<dev string:x378>")
  }, {
    #name: "<dev string:x6c5>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x6dc>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x6f1>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x704>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x715>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x72b>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x73c>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x752>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x76b>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x780>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x793>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x7ab>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x7be>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x7d1>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x2d1>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x7e5>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x7f4>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x803>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x2be>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x813>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x825>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x837>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:xa0>", #default_val: 1, #state: array("<dev string:x850>", "<dev string:x450>", "<dev string:x858>")
  }, {
    #name: "<dev string:x860>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x87b>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x893>", #default_val: 1, #state: array("<dev string:x850>", "<dev string:x450>", "<dev string:x858>")
  }, {
    #name: "<dev string:x8ac>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x112>", #default_val: 1, #state: array("<dev string:x8c1>", "<dev string:x450>", "<dev string:x8c9>")
  }, {
    #name: "<dev string:x8d3>", #default_val: 0, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x8e6>", #default_val: 0, #state: array("<dev string:x391>", "<dev string:x398>", "<dev string:x8f7>")
  }, {
    #name: "<dev string:x8ff>", #default_val: 0, #state: array("<dev string:x391>", "<dev string:x398>", "<dev string:x8f7>")
  }, {
    #name: "<dev string:x910>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>", "<dev string:x8f7>")
  }, {
    #name: "<dev string:x922>", #default_val: 1, #state: array("<dev string:x934>", "<dev string:x93d>", "<dev string:x947>")
  }, {
    #name: "<dev string:x16b>", #default_val: 0, #state: array("<dev string:x950>", "<dev string:x958>", "<dev string:x95f>", "<dev string:x969>")
  }, {
    #name: "<dev string:x979>", #default_val: 3, #state: array("<dev string:x950>", "<dev string:x958>", "<dev string:x95f>", "<dev string:x969>")
  }, {
    #name: "<dev string:x98d>", #default_val: 1, #state: array("<dev string:x8c1>", "<dev string:x450>", "<dev string:x8c9>")
  }, {
    #name: "<dev string:x304>", #default_val: 1, #state: array("<dev string:x8c1>", "<dev string:x450>", "<dev string:x8c9>")
  }, {
    #name: "<dev string:x9a3>", #default_val: 1, #state: array("<dev string:x8c1>", "<dev string:x450>", "<dev string:x8c9>")
  }, {
    #name: "<dev string:x9ba>", #default_val: 1, #state: array("<dev string:x8c1>", "<dev string:x450>", "<dev string:x8c9>")
  }, {
    #name: "<dev string:x9d1>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x9e3>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>", "<dev string:x8f7>")
  }, {
    #name: "<dev string:x9f5>", #default_val: 1, #state: array("<dev string:x8c1>", "<dev string:x450>", "<dev string:x8c9>")
  }, {
    #name: "<dev string:x17f>", #default_val: 1, #state: array("<dev string:x8c1>", "<dev string:x450>", "<dev string:x8c9>")
  }, {
    #name: "<dev string:xa0c>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:xa1e>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>", "<dev string:x8f7>")
  }, {
    #name: "<dev string:xa2e>", #default_val: 1, #state: array("<dev string:x8c1>", "<dev string:x450>", "<dev string:x8c9>")
  }, {
    #name: "<dev string:x1aa>", #default_val: 1, #state: array("<dev string:x8c1>", "<dev string:x450>", "<dev string:x8c9>")
  }, {
    #name: "<dev string:xa43>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x153>", #default_val: 3, #state: array("<dev string:x378>")
  }, {
    #name: "<dev string:xcf>", #default_val: 1, #state: array("<dev string:xa53>", "<dev string:x93d>", "<dev string:xa5c>")
  }, {
    #name: "<dev string:xe5>", #default_val: 2, #state: array("<dev string:xa64>", "<dev string:xa53>", "<dev string:x93d>", "<dev string:xa5c>", "<dev string:xa6f>")
  }, {
    #name: "<dev string:x2f2>", #default_val: 0, #state: array("<dev string:x391>", "<dev string:xa77>", "<dev string:x93d>", "<dev string:xa80>")
  }, {
    #name: "<dev string:x2e1>", #default_val: 0, #state: array("<dev string:x391>", "<dev string:xa77>", "<dev string:x93d>", "<dev string:xa80>")
  }, {
    #name: "<dev string:x1d3>", #default_val: 0, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x1bf>", #default_val: 5, #state: array("<dev string:x378>")
  }, {
    #name: "<dev string:xa89>", #default_val: 0, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x128>", #default_val: 0, #state: array("<dev string:x391>", "<dev string:xa9e>", "<dev string:xaac>")
  }, {
    #name: "<dev string:x13c>", #default_val: 0, #state: array("<dev string:x378>")
  }, {
    #name: "<dev string:xab5>", #default_val: 0, #state: array("<dev string:x378>")
  }, {
    #name: "<dev string:x2a7>", #default_val: 2, #state: array("<dev string:x391>", "<dev string:xa53>", "<dev string:x93d>", "<dev string:xa5c>")
  }, {
    #name: "<dev string:xaca>", #default_val: 0, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:xfa>", #default_val: 0, #state: array("<dev string:x378>")
  }, {
    #name: "<dev string:xae5>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:xaf9>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:xb11>", #default_val: 1, #state: array("<dev string:x8c1>", "<dev string:x450>", "<dev string:x8c9>")
  }, {
    #name: "<dev string:xb27>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:xb48>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:xb65>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:xb85>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:xb9c>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:xbb7>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:xbce>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:xbeb>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:xc05>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:xc1e>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:xc35>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:xc50>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:xc6c>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:xc88>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:xca4>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:xcc0>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:xcdd>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:xcfa>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:xd17>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:xd34>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:xd4c>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:xd64>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:xd7c>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:xd94>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:xdbb>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:xddd>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:xdf6>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:xe14>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:xe32>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:xe4d>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:xe68>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:xe84>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:xea0>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:xebb>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:xecf>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:xeec>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:xf07>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:xf25>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:xf3e>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:xf56>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:xf73>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:xf8a>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:xfa1>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:xfb7>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:xfcc>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:xfe2>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:xff7>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x100f>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x1025>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x1045>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x105a>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x1079>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x1097>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x10b3>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x10cf>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x10e5>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x10fc>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x110f>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x1127>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x1138>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x114c>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x1161>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x1182>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x1197>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x11ab>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x11c0>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x11df>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x11f5>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x120a>", #default_val: 0, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x121e>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x1230>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:xba>", #default_val: 1, #state: array("<dev string:x8c1>", "<dev string:x450>", "<dev string:x8c9>", "<dev string:x124b>")
  }, {
    #name: "<dev string:x196>", #default_val: 1, #state: array("<dev string:x8c1>", "<dev string:x450>", "<dev string:x8c9>", "<dev string:x124b>")
  }, {
    #name: "<dev string:x1258>", #default_val: 0, #state: array("<dev string:x378>")
  }, {
    #name: "<dev string:x126e>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>", "<dev string:x8f7>")
  }, {
    #name: "<dev string:x127f>", #default_val: 1, #state: array("<dev string:x8c1>", "<dev string:x450>", "<dev string:x8c9>")
  }, {
    #name: "<dev string:x1295>", #default_val: 1, #state: array("<dev string:x8c1>", "<dev string:x450>", "<dev string:x8c9>")
  }, {
    #name: "<dev string:xba>", #default_val: 1, #state: array("<dev string:x8c1>", "<dev string:x450>", "<dev string:x8c9>", "<dev string:x124b>")
  }, {
    #name: "<dev string:x12ab>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x12be>", #default_val: 1, #state: array("<dev string:x450>", "<dev string:xa64>")
  }, {
    #name: "<dev string:x12cd>", #default_val: 0, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x12e2>", #default_val: 0, #state: array("<dev string:x378>")
  }, {
    #name: "<dev string:x12f7>", #default_val: 0, #state: array("<dev string:x378>")
  }, {
    #name: "<dev string:x130d>", #default_val: 0, #state: array("<dev string:x378>")
  }, {
    #name: "<dev string:x132b>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x1345>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x135a>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x136e>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x1386>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x13a1>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x13ba>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x13cf>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x13e5>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x13f9>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x1413>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x1427>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x143d>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x1451>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  }, {
    #name: "<dev string:x1469>", #default_val: 1, #state: array("<dev string:x391>", "<dev string:x398>")
  });
}