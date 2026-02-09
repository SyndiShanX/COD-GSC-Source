/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_horde_crates.gsc
***********************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\killstreaks\_airdrop;
#include maps\mp\gametypes\horde;
#include maps\mp\gametypes\_horde_util;

CONST_AIR_DROP_USE_TIME = 1000;
CONST_LOOT_DROP_USE_TIME = 2000;
KILLSTREAK_SLOT_1 = 1;
KILLSTREAK_SLOT_3 = 3;

CONST_STAGE_0_OUTLINE = 2;
CONST_STAGE_0_COLOR = (0.431, 0.745, 0.235);

CONST_STAGE_1_OUTLINE = 5;
CONST_STAGE_1_COLOR = (0.804, 0.804, 0.035);

createHordeCrates(friendly_crate_model, enemy_crate_model) {
  level.getRandomCrateTypeForGameMode = ::getRandomCrateTypeHorde;

  level.hordeIcon["ammo"] = "specialty_ammo_crate";

  level.hordeIcon["iw6_mts255_mp_barrelrange03_reflexshotgun"] = "hud_icon_mts255";
  level.hordeIcon["iw6_fp6_mp_barrelrange03_reflexshotgun"] = "hud_icon_fp6";
  level.hordeIcon["iw6_vepr_mp_grip"] = "hud_icon_vepr";
  level.hordeIcon["iw6_microtar_mp_eotechsmg"] = "hud_icon_microtar";
  level.hordeIcon["iw6_ak12_mp_flashsuppress_grip"] = "hud_icon_ak12";
  level.hordeIcon["iw6_arx160_mp_flashsuppress_hybrid"] = "hud_icon_arx160";
  level.hordeIcon["iw6_m27_mp_flashsuppress_hybrid"] = "hud_icon_m27";
  level.hordeIcon["iw6_kac_mp_flashsuppress"] = "hud_icon_kac";
  level.hordeIcon["iw6_usr_mp_usrvzscope_xmags"] = "hud_icon_usr";
  level.hordeIcon["iw6_magnumhorde_mp_fmj"] = "hud_icon_magnum";
  level.hordeIcon["throwingknife_mp"] = "throw_knife_sm";

  level.hordeIcon["specialty_lightweight"] = "icon_perks_agility";
  level.hordeIcon["specialty_fastreload"] = "icon_perks_sleight_of_hand";
  level.hordeIcon["specialty_quickdraw"] = "icon_perks_quickdraw";
  level.hordeIcon["specialty_marathon"] = "icon_perks_marathon";
  level.hordeIcon["specialty_quickswap"] = "icon_perks_reflex";
  level.hordeIcon["specialty_bulletaccuracy"] = "icon_perks_steady_aim";
  level.hordeIcon["specialty_fastsprintrecovery"] = "icon_perks_ready_up";
  level.hordeIcon["_specialty_blastshield"] = "icon_perks_blast_shield";
  level.hordeIcon["specialty_stalker"] = "icon_perks_stalker";
  level.hordeIcon["specialty_sharp_focus"] = "icon_perks_focus";
  level.hordeIcon["specialty_regenfaster"] = "icon_perks_icu";
  level.hordeIcon["specialty_sprintreload"] = "icon_perks_on_the_go";
  level.hordeIcon["specialty_triggerhappy"] = "icon_perks_triggerhappy";

  addCrateType("a", "iw6_mts255_mp_barrelrange03_reflexshotgun", 12, ::hordeCrateWeaponThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_MTS");
  addCrateType("a", "iw6_fp6_mp_barrelrange03_reflexshotgun", 12, ::hordeCrateWeaponThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_FP6");
  addCrateType("a", "iw6_vepr_mp_grip", 12, ::hordeCrateWeaponThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_VEPR");
  addCrateType("a", "iw6_microtar_mp_eotechsmg", 12, ::hordeCrateWeaponThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_MICRO");
  addCrateType("a", "iw6_ak12_mp_flashsuppress_grip", 0, ::hordeCrateWeaponThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_AK");
  addCrateType("a", "iw6_arx160_mp_flashsuppress_hybrid", 0, ::hordeCrateWeaponThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_ARX");
  addCrateType("a", "iw6_m27_mp_flashsuppress_hybrid", 0, ::hordeCrateWeaponThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_M27");
  addCrateType("a", "iw6_kac_mp_flashsuppress", 0, ::hordeCrateWeaponThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_KAC");
  addCrateType("a", "iw6_usr_mp_usrvzscope_xmags", 12, ::hordeCrateWeaponThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_USR");
  addCrateType("a", "iw6_magnumhorde_mp_fmj", 0, ::hordeCrateWeaponThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_WEST");

  addCrateType("a", "throwingknife_mp", 3, ::hordeCrateLethalThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_KNIFE");
  addCrateType("a", "specialty_lightweight", 0, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_LIGHT");
  addCrateType("a", "specialty_fastreload", 0, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_FAST");
  addCrateType("a", "specialty_quickdraw", 10, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_QIUCK");
  addCrateType("a", "specialty_marathon", 0, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_MARA");
  addCrateType("a", "specialty_quickswap", 10, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_SWAP");
  addCrateType("a", "specialty_bulletaccuracy", 0, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_AIM");
  addCrateType("a", "specialty_fastsprintrecovery", 7, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_READY");
  addCrateType("a", "_specialty_blastshield", 0, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_BLAST");
  addCrateType("a", "specialty_stalker", 10, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_STALK");
  addCrateType("a", "specialty_sharp_focus", 0, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_FOCUS");
  addCrateType("a", "specialty_regenfaster", 0, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_HEALTH");
  addCrateType("a", "specialty_sprintreload", 0, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_GO");
  addCrateType("a", "specialty_triggerhappy", 0, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_TRIGGER");
  addCrateType("a", "ammo", 0, ::hordeCrateAmmoThink, friendly_crate_model, enemy_crate_model, &"HORDE_AMMO");

  addCrateType("b", "iw6_mts255_mp_barrelrange03_reflexshotgun", 5, ::hordeCrateWeaponThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_MTS");
  addCrateType("b", "iw6_fp6_mp_barrelrange03_reflexshotgun", 5, ::hordeCrateWeaponThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_FP6");
  addCrateType("b", "iw6_vepr_mp_grip", 10, ::hordeCrateWeaponThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_VEPR");
  addCrateType("b", "iw6_microtar_mp_eotechsmg", 10, ::hordeCrateWeaponThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_MICRO");
  addCrateType("b", "iw6_ak12_mp_flashsuppress_grip", 10, ::hordeCrateWeaponThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_AK");
  addCrateType("b", "iw6_arx160_mp_flashsuppress_hybrid", 10, ::hordeCrateWeaponThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_ARX");
  addCrateType("b", "iw6_m27_mp_flashsuppress_hybrid", 0, ::hordeCrateWeaponThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_M27");
  addCrateType("b", "iw6_kac_mp_flashsuppress", 0, ::hordeCrateWeaponThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_KAC");
  addCrateType("b", "iw6_usr_mp_usrvzscope_xmags", 10, ::hordeCrateWeaponThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_USR");
  addCrateType("b", "iw6_magnumhorde_mp_fmj", 0, ::hordeCrateWeaponThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_WEST");

  addCrateType("b", "throwingknife_mp", 3, ::hordeCrateLethalThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_KNIFE");
  addCrateType("b", "specialty_lightweight", 10, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_LIGHT");
  addCrateType("b", "specialty_fastreload", 0, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_FAST");
  addCrateType("b", "specialty_quickdraw", 0, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_QIUCK");
  addCrateType("b", "specialty_marathon", 10, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_MARA");
  addCrateType("b", "specialty_quickswap", 0, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_SWAP");
  addCrateType("b", "specialty_bulletaccuracy", 0, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_AIM");
  addCrateType("b", "specialty_fastsprintrecovery", 0, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_READY");
  addCrateType("b", "_specialty_blastshield", 0, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_BLAST");
  addCrateType("b", "specialty_stalker", 0, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_STALK");
  addCrateType("b", "specialty_sharp_focus", 7, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_FOCUS");
  addCrateType("b", "specialty_regenfaster", 0, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_HEALTH");
  addCrateType("b", "specialty_sprintreload", 10, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_GO");
  addCrateType("b", "specialty_triggerhappy", 0, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_TRIGGER");
  addCrateType("b", "ammo", 0, ::hordeCrateAmmoThink, friendly_crate_model, enemy_crate_model, &"HORDE_AMMO");

  addCrateType("c", "iw6_mts255_mp_barrelrange03_reflexshotgun", 5, ::hordeCrateWeaponThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_MTS");
  addCrateType("c", "iw6_fp6_mp_barrelrange03_reflexshotgun", 5, ::hordeCrateWeaponThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_FP6");
  addCrateType("c", "iw6_vepr_mp_grip", 5, ::hordeCrateWeaponThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_VEPR");
  addCrateType("c", "iw6_microtar_mp_eotechsmg", 5, ::hordeCrateWeaponThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_MICRO");
  addCrateType("c", "iw6_ak12_mp_flashsuppress_grip", 12, ::hordeCrateWeaponThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_AK");
  addCrateType("c", "iw6_arx160_mp_flashsuppress_hybrid", 12, ::hordeCrateWeaponThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_ARX");
  addCrateType("c", "iw6_m27_mp_flashsuppress_hybrid", 0, ::hordeCrateWeaponThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_M27");
  addCrateType("c", "iw6_kac_mp_flashsuppress", 0, ::hordeCrateWeaponThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_KAC");
  addCrateType("c", "iw6_usr_mp_usrvzscope_xmags", 6, ::hordeCrateWeaponThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_USR");
  addCrateType("c", "iw6_magnumhorde_mp_fmj", 0, ::hordeCrateWeaponThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_WEST");

  addCrateType("c", "throwingknife_mp", 2, ::hordeCrateLethalThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_KNIFE");
  addCrateType("c", "specialty_lightweight", 0, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_LIGHT");
  addCrateType("c", "specialty_fastreload", 12, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_FAST");
  addCrateType("c", "specialty_quickdraw", 0, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_QIUCK");
  addCrateType("c", "specialty_marathon", 0, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_MARA");
  addCrateType("c", "specialty_quickswap", 0, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_SWAP");
  addCrateType("c", "specialty_bulletaccuracy", 12, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_AIM");
  addCrateType("c", "specialty_fastsprintrecovery", 0, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_READY");
  addCrateType("c", "_specialty_blastshield", 12, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_BLAST");
  addCrateType("c", "specialty_stalker", 0, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_STALK");
  addCrateType("c", "specialty_sharp_focus", 0, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_FOCUS");
  addCrateType("c", "specialty_regenfaster", 12, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_HEALTH");
  addCrateType("c", "specialty_sprintreload", 0, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_GO");
  addCrateType("c", "specialty_triggerhappy", 0, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_TRIGGER");
  addCrateType("c", "ammo", 0, ::hordeCrateAmmoThink, friendly_crate_model, enemy_crate_model, &"HORDE_AMMO");

  addCrateType("d", "iw6_mts255_mp_barrelrange03_reflexshotgun", 5, ::hordeCrateWeaponThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_MTS");
  addCrateType("d", "iw6_fp6_mp_barrelrange03_reflexshotgun", 5, ::hordeCrateWeaponThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_FP6");
  addCrateType("d", "iw6_vepr_mp_grip", 5, ::hordeCrateWeaponThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_VEPR");
  addCrateType("d", "iw6_microtar_mp_eotechsmg", 5, ::hordeCrateWeaponThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_MICRO");
  addCrateType("d", "iw6_ak12_mp_flashsuppress_grip", 5, ::hordeCrateWeaponThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_AK");
  addCrateType("d", "iw6_arx160_mp_flashsuppress_hybrid", 5, ::hordeCrateWeaponThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_ARX");
  addCrateType("d", "iw6_m27_mp_flashsuppress_hybrid", 10, ::hordeCrateWeaponThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_M27");
  addCrateType("d", "iw6_kac_mp_flashsuppress", 10, ::hordeCrateWeaponThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_KAC");
  addCrateType("d", "iw6_usr_mp_usrvzscope_xmags", 5, ::hordeCrateWeaponThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_USR");
  addCrateType("d", "iw6_magnumhorde_mp_fmj", 0, ::hordeCrateWeaponThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_WEST");

  addCrateType("d", "throwingknife_mp", 2, ::hordeCrateLethalThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_KNIFE");
  addCrateType("d", "specialty_lightweight", 3, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_LIGHT");
  addCrateType("d", "specialty_fastreload", 4, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_FAST");
  addCrateType("d", "specialty_quickdraw", 3, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_QIUCK");
  addCrateType("d", "specialty_marathon", 4, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_MARA");
  addCrateType("d", "specialty_quickswap", 3, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_SWAP");
  addCrateType("d", "specialty_bulletaccuracy", 4, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_AIM");
  addCrateType("d", "specialty_fastsprintrecovery", 3, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_READY");
  addCrateType("d", "_specialty_blastshield", 4, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_BLAST");
  addCrateType("d", "specialty_stalker", 3, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_STALK");
  addCrateType("d", "specialty_sharp_focus", 4, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_FOCUS");
  addCrateType("d", "specialty_regenfaster", 4, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_HEALTH");
  addCrateType("d", "specialty_sprintreload", 4, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_GO");
  addCrateType("d", "specialty_triggerhappy", 0, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_TRIGGER");
  addCrateType("d", "ammo", 0, ::hordeCrateAmmoThink, friendly_crate_model, enemy_crate_model, &"HORDE_AMMO");

  addCrateType("e", "iw6_mts255_mp_barrelrange03_reflexshotgun", 4, ::hordeCrateWeaponThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_MTS");
  addCrateType("e", "iw6_fp6_mp_barrelrange03_reflexshotgun", 4, ::hordeCrateWeaponThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_FP6");
  addCrateType("e", "iw6_vepr_mp_grip", 4, ::hordeCrateWeaponThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_VEPR");
  addCrateType("e", "iw6_microtar_mp_eotechsmg", 4, ::hordeCrateWeaponThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_MICRO");
  addCrateType("e", "iw6_ak12_mp_flashsuppress_grip", 4, ::hordeCrateWeaponThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_AK");
  addCrateType("e", "iw6_arx160_mp_flashsuppress_hybrid", 4, ::hordeCrateWeaponThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_ARX");
  addCrateType("e", "iw6_m27_mp_flashsuppress_hybrid", 9, ::hordeCrateWeaponThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_M27");
  addCrateType("e", "iw6_kac_mp_flashsuppress", 9, ::hordeCrateWeaponThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_KAC");
  addCrateType("e", "iw6_usr_mp_usrvzscope_xmags", 5, ::hordeCrateWeaponThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_USR");
  addCrateType("e", "iw6_magnumhorde_mp_fmj", 3, ::hordeCrateWeaponThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_WEST");

  addCrateType("e", "throwingknife_mp", 2, ::hordeCrateLethalThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_KNIFE");
  addCrateType("e", "specialty_lightweight", 4, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_LIGHT");
  addCrateType("e", "specialty_fastreload", 4, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_FAST");
  addCrateType("e", "specialty_quickdraw", 4, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_QIUCK");
  addCrateType("e", "specialty_marathon", 4, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_MARA");
  addCrateType("e", "specialty_quickswap", 4, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_SWAP");
  addCrateType("e", "specialty_bulletaccuracy", 4, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_AIM");
  addCrateType("e", "specialty_fastsprintrecovery", 4, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_READY");
  addCrateType("e", "_specialty_blastshield", 4, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_BLAST");
  addCrateType("e", "specialty_stalker", 4, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_STALK");
  addCrateType("e", "specialty_sharp_focus", 4, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_FOCUS");
  addCrateType("e", "specialty_regenfaster", 4, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_HEALTH");
  addCrateType("e", "specialty_sprintreload", 4, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_GO");
  addCrateType("e", "specialty_triggerhappy", 3, ::hordeCratePerkThink, friendly_crate_model, enemy_crate_model, &"HORDE_DOUBLE_TAP_TRIGGER");
  addCrateType("e", "ammo", 0, ::hordeCrateAmmoThink, friendly_crate_model, enemy_crate_model, &"HORDE_AMMO");

  setupLootCrates(friendly_crate_model, enemy_crate_model);
}

setupLootCrates(friendly_crate_model, enemy_crate_model) {
  addCrateType("loot", "ims", 15, ::killstreakCrateThinkHorde, friendly_crate_model, enemy_crate_model, &"KILLSTREAKS_HINTS_IMS_PICKUP");
  addCrateType("loot", "helicopter", 15, ::killstreakCrateThinkHorde, friendly_crate_model, enemy_crate_model, &"KILLSTREAKS_HINTS_HELICOPTER_PICKUP");
  addCrateType("loot", "drone_hive", 15, ::killstreakCrateThinkHorde, friendly_crate_model, enemy_crate_model, &"KILLSTREAKS_HINTS_DRONE_HIVE_PICKUP");
  addCrateType("loot", "sentry", 15, ::killstreakCrateThinkHorde, friendly_crate_model, enemy_crate_model, &"KILLSTREAKS_HINTS_SENTRY_PICKUP");
  addCrateType("loot", "heli_sniper", 15, ::killstreakCrateThinkHorde, friendly_crate_model, enemy_crate_model, &"KILLSTREAKS_HINTS_HELI_SNIPER_PICKUP");
  addCrateType("loot", "ball_drone_backup", 15, ::killstreakCrateThinkHorde, friendly_crate_model, enemy_crate_model, &"KILLSTREAKS_HINTS_BALL_DRONE_BACKUP_PICKUP");
}

hordeCrateWeaponThink(dropType) {
  self endon("death");
  self endon("doubleTap");
  self endon("restarting_physics");

  if(!isDefined(self.doubleTapCount))
    self.doubleTapCount = 0;

  crateHint = game["strings"][self.crateType + "_hint"];
  self thread doubleTapThink();

  self crateSetupForUse(crateHint, level.hordeIcon[self.crateType]);
  self thread crateAllCaptureThinkHorde(CONST_AIR_DROP_USE_TIME);
  setCrateLooksBasedOnTap(self);

  level thread removeOnNextAirDrop(self);

  while(true) {
    self waittill("captured", player);

    tryGiveHordeWeapon(player, self.crateType);

    self deleteCrate();
  }
}

tryGiveHordeWeapon(player, weaponName) {
  player playLocalSound("ammo_crate_use");

  weaponList = [];
  weaponListTemp = player GetWeaponsListPrimaries();
  baseWeaponName = GetWeaponBaseName(weaponName);

  foreach(weaponHeld in weaponListTemp) {
    if(weaponHeld == level.intelMiniGun) {
      continue;
    }
    weaponList[weaponList.size] = weaponHeld;
  }

  if(weaponList.size > 1) {
    removeWeapon = true;

    foreach(weaponInList in weaponList) {
      if(weaponName == weaponInList)
        removeWeapon = false;
    }

    if(removeWeapon) {
      replaceWeapon = player GetCurrentPrimaryWeapon();

      if(replaceWeapon == "none")
        replaceWeapon = player getLastWeapon();

      if(!player HasWeapon(replaceWeapon) || (replaceWeapon == level.intelMiniGun))
        replaceWeapon = player maps\mp\killstreaks\_killstreaks::getFirstPrimaryWeapon();

      player TakeWeapon(replaceWeapon);
    } else {
      player GiveMaxAmmo(weaponName);

      barSize = player.weaponState[baseWeaponName]["barSize"];
      player.weaponState[baseWeaponName]["vaule"] = barSize;
      player notify("weaponPointsEarned");
    }
  }

  createHordeWeaponState(player, baseWeaponName, true);

  player _giveWeapon(weaponName);
  player SwitchToWeaponImmediate(weaponName);
}

hordeCratePerkThink(dropType) {
  self endon("death");
  self endon("doubleTap");
  self endon("restarting_physics");

  if(!isDefined(self.doubleTapCount))
    self.doubleTapCount = 0;

  crateHint = game["strings"][self.crateType + "_hint"];
  self thread doubleTapThink();

  self crateSetupForUse(crateHint, level.hordeIcon[self.crateType]);
  self thread crateAllCaptureThinkHorde(CONST_AIR_DROP_USE_TIME);
  setCrateLooksBasedOnTap(self);

  level thread removeOnNextAirDrop(self);

  while(true) {
    self waittill("captured", player);

    player playLocalSound("ammo_crate_use");

    if(!player _hasPerk(self.crateType)) {
      perk = self.crateType;
      player givePerk(perk, false);

      perkTableIndex = TableLookup("mp/hordeIcons.csv", 1, perk, 0);
      player SetClientOmnvar("ui_horde_update_perk", int(perkTableIndex));

      numPerks = player.horde_perks.size;
      player.horde_perks[numPerks]["name"] = perk;
      player.horde_perks[numPerks]["index"] = int(perkTableIndex);
    }

    self deleteCrate();
  }
}

hordeCrateLethalThink(dropType) {
  self endon("death");
  self endon("doubleTap");
  self endon("restarting_physics");

  if(!isDefined(self.doubleTapCount))
    self.doubleTapCount = 0;

  crateHint = game["strings"][self.crateType + "_hint"];
  self thread doubleTapThink();

  self crateSetupForUse(crateHint, level.hordeIcon[self.crateType]);
  self thread crateAllCaptureThinkHorde(CONST_AIR_DROP_USE_TIME);
  setCrateLooksBasedOnTap(self);

  level thread removeOnNextAirDrop(self);

  while(true) {
    self waittill("captured", player);

    player playLocalSound("ammo_crate_use");

    if(!player HasWeapon(self.crateType)) {
      currentOffHand = player GetCurrentOffhand();
      player TakeWeapon(currentOffHand);
      player givePerkEquipment(self.crateType, true);
    } else {
      player GiveMaxAmmo(self.crateType);
    }

    self deleteCrate();
  }
}

hordeCrateAmmoThink(dropType) {
  self endon("death");
  self endon("restarting_physics");

  crateHint = game["strings"][self.crateType + "_hint"];
  crateSetupForUse(crateHint, level.hordeIcon[self.crateType]);

  self thread crateAllCaptureThinkHorde(CONST_LOOT_DROP_USE_TIME);
  self.friendlyModel HudOutlineEnable(CONST_STAGE_1_OUTLINE, false);
  self.outlineColor = CONST_STAGE_1_OUTLINE;

  level thread removeOnNextAirDrop(self);

  while(true) {
    self waittill("captured", player);

    player playLocalSound("ammo_crate_use");
    level thread refillAmmoHorde(player);

    self deleteCrate();
  }
}

killstreakCrateThinkHorde(dropType) {
  self endon("death");
  self endon("restarting_physics");

  crateHint = game["strings"][self.crateType + "_hint"];
  crateSetupForUse(crateHint, getKillstreakOverheadIcon(self.crateType));

  self thread crateAllCaptureThinkHorde(CONST_LOOT_DROP_USE_TIME);
  setCrateLook(self, 3, (0.157, 0.784, 0.784));

  while(true) {
    self waittill("captured", player);

    if(!isPlayer(player)) {
      continue;
    }
    slotNumber = getSlotNumber(player);

    if(!isDefined(slotNumber)) {
      continue;
    }
    player playLocalSound("ammo_crate_use");
    player thread maps\mp\killstreaks\_killstreaks::giveKillstreak(self.crateType, false, false, self.owner, slotNumber);

    self deleteCrate();
  }
}

getSlotNumber(player) {
  slotNumber = undefined;

  for(i = KILLSTREAK_SLOT_1; i < KILLSTREAK_SLOT_3 + 1; i++) {
    self_pers_killstreak_i = player.pers["killstreaks"][i];

    if(!isDefined(self_pers_killstreak_i) || !isDefined(self_pers_killstreak_i.streakName) || self_pers_killstreak_i.available == false) {
      slotNumber = i;
      break;
    }
  }

  return slotNumber;
}

crateAllCaptureThinkHorde(useTime) {
  self endon("doubleTap");
  self endon("restarting_physics");

  if(!isDefined(useTime))
    useTime = 500;

  while(isDefined(self)) {
    self MakeUsable();
    self waittill("trigger", player);

    if(handleAgentUse(player)) {
      continue;
    }
    if(handleKillStreakLimit(player)) {
      continue;
    }
    if(!self validateOpenConditions(player)) {
      continue;
    }
    self MakeUnusable();
    player.isCapturingCrate = true;

    if(!useHoldThink(player, useTime)) {
      player.isCapturingCrate = false;
      continue;
    }

    player.isCapturingCrate = false;
    awardHordeCrateUsed(player);
    self notify("captured", player);
  }
}

handleKillStreakLimit(player) {
  if((self.dropType == "loot") && !isDefined(getSlotNumber(player))) {
    player SetClientOmnvar("ui_killstreak_limit", 1);
    return true;
  }

  return false;
}

handleAgentUse(player) {
  if(!isPlayer(player)) {
    if(isDefined(player.disablePlayerUseEnt))
      player.disablePlayerUseEnt EnablePlayerUse(player);

    player.disablePlayerUseEnt = self;
    self DisablePlayerUse(player);

    return true;
  }

  return false;
}

monitorDoubleTap(player) {
  player endon("disconnect");

  buttonTime = 0;

  while(true) {
    if(player UseButtonPressed()) {
      buttonTime = 0;
      while(player UseButtonPressed()) {
        buttonTime += 0.05;
        wait(0.05);
      }

      if(buttonTime >= 0.5) {
        continue;
      }
      buttonTime = 0;
      while(!player UseButtonPressed() && buttonTime < 0.5) {
        buttonTime += 0.05;
        wait(0.05);
      }

      if(buttonTime >= 0.5) {
        continue;
      }
      level notify("doubleTap", player);
    }
    wait(0.05);
  }
}

doubleTapThink() {
  self endon("death");
  self endon("capture");
  self endon("restarting_physics");

  maxDistanceSq = 128 * 128;

  if(self.doubleTapCount > 0)
    wait(1.0);

  while(true) {
    level waittill("doubleTap", player);

    if(isPlayerInLastStand(player)) {
      continue;
    }
    if(!isReallyAlive(player)) {
      continue;
    }
    if(isDefined(self.inUse) && self.inUse) {
      continue;
    }
    if(Distance2DSquared(player.origin, self.origin) < maxDistanceSq) {
      self notify("doubleTap");
      self newRandomCrate();
      break;
    }
  }
}

newRandomCrate() {
  self.doubleTapCount++;
  playSoundAtPos(self.origin, "mp_killconfirm_tags_drop");

  if(self.doubleTapCount > 1) {
    crateType = "ammo";
  } else {
    originalWeight = level.crateTypes[self.dropType][self.crateType].raw_weight;
    changeCrateWeight(self.dropType, self.crateType, 0);
    crateType = getRandomCrateTypeHorde(self.dropType);
    changeCrateWeight(self.dropType, self.crateType, originalWeight);
  }

  self.crateType = crateType;

  self thread[[level.crateTypes[self.dropType][self.crateType].func]](self.dropType);
}

runLootDrop() {
  dropType = "loot";
  dropNum = 8;
  crateOffest = RandomInt(level.crateTypes["loot"].size);
  createSpawnHeight = (0, 0, 75);

  if(isDefined(level.spawnMaxCrates))
    dropNum = level.hordeDropLocations.size;

  if(!level.carePackages.size)
    sortDropLocations();

  for(i = 0; i < dropNum; i++) {
    dropLocation = level.hordeDropLocations[level.dropLocationIndex];
    groundLocation = getFinalDropLocation(dropLocation.traceLocation);

    if(!isDefined(groundLocation)) {
      level.dropLocationIndex = getNextDropLocationIndex(level.dropLocationIndex);
      continue;
    }

    startPos = groundLocation;
    crateType = getCrateTypeForLootDrop(crateOffest + i);
    dropCrate = level.players[0] createAirDropCrate(level.players[0], dropType, crateType, startPos + createSpawnHeight, startPos, 3);
    dropCrate.angles = (0, 0, 0);
    dropCrate.droppingToGround = true;
    dropCrate.friendlyModel hide();

    wait(0.05);

    dropCrate thread waitForDropCrateMsg(dropCrate, (RandomInt(25), RandomInt(25), RandomInt(25)), dropType, crateType, 800, true);

    level thread removeAtRoundEnd(dropCrate);
    level.dropLocationIndex = getNextDropLocationIndex(level.dropLocationIndex);

    wait(0.05);

    playFX(level._effect["crate_teleport"], dropCrate.origin, (0, 0, 1));
    PlaySoundAtPos(dropCrate.origin, "crate_teleport_safeguard");
    dropCrate.friendlyModel show();
  }
}

lootCrateEffect(crate) {
  crate waittill("physics_finished");

  dropEffect = SpawnFx(level._effect["loot_crtae"], crate.origin - (0, 0, 16));
  TriggerFX(dropEffect);

  crate waittill_any_timeout_no_endon_death(level.specialRoundTime, "death");

  dropEffect Delete();
}

getFinalDropLocation(groundLocation) {
  if(!isPlayerNearLocation(groundLocation))
    return groundLocation;

  pathNodeArray = GetNodesInRadiusSorted(groundLocation, 256, 64, 128, "Path");

  foreach(pathNode in pathNodeArray) {
    if(!isPlayerNearLocation(pathNode.origin))
      return pathNode.origin;
  }

  return undefined;
}

isPlayerNearLocation(groundLocation) {
  pickNewLocation = false;

  foreach(player in level.participants) {
    distSquared = Distance2DSquared(player.origin, groundLocation);

    if(distSquared < (64 * 64)) {
      pickNewLocation = true;
      break;
    }
  }

  return pickNewLocation;
}

getCrateTypeForLootDrop(index) {
  while(index >= level.crateTypes["loot"].size) {
    index = index - level.crateTypes["loot"].size;
  }

  lootKeys = GetArrayKeys(level.crateTypes["loot"]);

  type = level.crateTypes["loot"][lootKeys[index]].type;

  return type;
}

removeOnNextAirDrop(dropCrate) {
  dropCrate endon("death");
  dropCrate endon("doubleTap");
  dropCrate endon("restarting_physics");

  level waittill("airSupport");

  while(isDefined(dropCrate.inUse) && dropCrate.inUse) {
    waitframe();
  }

  dropCrate deleteCrate();
}

removeAtRoundEnd(dropCrate) {
  dropCrate endon("death");

  level waittill("round_ended");

  while(isDefined(dropCrate.inUse) && dropCrate.inUse) {
    waitframe();
  }

  dropCrate deleteCrate();
}

getRandomCrateTypeHorde(dropType) {
  numPowerWeapons = getNumPowerWeapons();
  value = RandomInt(level.crateMaxVal[dropType]);

  selectedCrateType = undefined;
  foreach(crateType in level.crateTypes[dropType]) {
    type = crateType.type;
    if(!level.crateTypes[dropType][type].weight) {
      continue;
    }
    if(!canPickCrate(type, numPowerWeapons)) {
      continue;
    }
    selectedCrateType = type;

    if(level.crateTypes[dropType][type].weight > value) {
      break;
    }
  }

  return (selectedCrateType);
}

CONST_POWER_GUN = "iw6_magnumhorde_mp_fmj";
CONST_POWER_PERK = "specialty_triggerhappy";
CONST_POWER_LIMIT = 2;

getNumPowerWeapons() {
  numPowerWeapons = 0;

  foreach(player in level.players) {
    if(!isOnHumanTeam(player)) {
      continue;
    }
    if(player HasWeapon(CONST_POWER_GUN))
      numPowerWeapons++;

    if(player _hasPerk(CONST_POWER_PERK))
      numPowerWeapons++;
  }

  carePackages = getEntArray("care_package", "targetname");

  foreach(crate in carePackages) {
    if(crate.crateType == CONST_POWER_GUN)
      numPowerWeapons++;

    if(crate.crateType == CONST_POWER_PERK)
      numPowerWeapons++;
  }

  return numPowerWeapons;
}

isPowerWeapon(crateType) {
  return ((crateType == CONST_POWER_GUN) || (crateType == CONST_POWER_PERK));
}

canPickCrate(crateType, numPowerWeapons) {
  if(isPowerWeapon(crateType) && (numPowerWeapons >= CONST_POWER_LIMIT))
    return false;

  return true;
}

setCrateLook(crate, outlineNum, HUDColor) {
  crate.friendlyModel HudOutlineEnable(outlineNum, false);
  crate.outlineColor = outlineNum;

  foreach(icon in crate.entityHeadIcons)
  icon.color = HUDColor;
}

setCrateLooksBasedOnTap(crate) {
  if(crate.doubleTapCount == 0) {
    setCrateLook(crate, CONST_STAGE_0_OUTLINE, CONST_STAGE_0_COLOR);
  } else {
    setCrateLook(crate, CONST_STAGE_1_OUTLINE, CONST_STAGE_1_COLOR);
  }
}