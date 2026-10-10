/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_1e9f0caa06d14ade.gsc
*************************************************/

#using script_930a1e7bd882c1d;
#using scripts\common\anim;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_infils_ac130;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\utility\game;
#namespace namespace_ef848fe8ef9d4bad;
#using_animtree("script_model");

function function_2941161fa47c4df0() {
  level.var_ca06425e37af610c = &function_3847ee6a388d287a;
  level.var_8cf2b3f6bd2bf0e6 = 1;
  level.var_2655050b4d075e87 = 0;
  level.var_5338013d30a283c8 = 1;
  level.var_d7c4cc78f9c8bbd6 = "on_delta";
  level.br_anim["wz_iw9_delta_infil_s6_g_prop_sh000_l"] = % wz_iw9_delta_infil_s6_g_prop_sh000_l;
  level.br_anim["wz_iw9_delta_infil_s6_g_prop_sh000_r"] = % wz_iw9_delta_infil_s6_g_prop_sh000_r;
  level.br_anim["wz_iw9_delta_infil_s6_g_prop_sh080_idle_l"] = % wz_iw9_delta_infil_s6_g_prop_sh080_idle_l;
  level.br_anim["wz_iw9_delta_infil_s6_g_prop_sh080_idle_r"] = % wz_iw9_delta_infil_s6_g_prop_sh080_idle_r;
  level.br_anim["wz_iw9_delta_infil_s6_zmb01_sh000"] = % wz_iw9_delta_infil_s6_zmb01_sh000;
  level.br_anim["wz_iw9_delta_infil_s6_zmb02_sh000"] = % wz_iw9_delta_infil_s6_zmb02_sh000;
  level.br_anim["wz_iw9_delta_infil_s6_zmb03_sh000"] = % wz_iw9_delta_infil_s6_zmb03_sh000;
  level.br_anim["wz_iw9_delta_infil_s6_zmb04_sh000"] = % wz_iw9_delta_infil_s6_zmb04_sh000;
  level.br_anim["wz_iw9_delta_infil_s6_zmb05_sh000"] = % wz_iw9_delta_infil_s6_zmb05_sh000;
  level.br_anim["wz_iw9_delta_infil_s6_zmb06_sh000"] = % wz_iw9_delta_infil_s6_zmb06_sh000;
  level.br_anim["wz_iw9_delta_infil_s6_zmb07_sh000"] = % wz_iw9_delta_infil_s6_zmb07_sh000;
  level.br_anim["wz_iw9_delta_infil_s6_zmb08_sh000"] = % wz_iw9_delta_infil_s6_zmb08_sh000;
  level.br_anim["wz_iw9_delta_infil_s6_zmb09_sh000"] = % wz_iw9_delta_infil_s6_zmb09_sh000;
  level.br_anim["wz_iw9_delta_infil_s6_zmb10_sh000"] = % wz_iw9_delta_infil_s6_zmb10_sh000;
  level.br_anim["wz_iw9_delta_infil_s6_zmb11_sh000"] = % wz_iw9_delta_infil_s6_zmb11_sh000;
  level.br_anim["wz_iw9_delta_infil_s6_zmb12_sh000"] = % wz_iw9_delta_infil_s6_zmb12_sh000;
  level.br_anim["wz_iw9_delta_infil_s6_zmb13_sh000"] = % wz_iw9_delta_infil_s6_zmb13_sh000;
  level.br_anim["wz_iw9_delta_infil_s6_zmb14_sh000"] = % wz_iw9_delta_infil_s6_zmb14_sh000;
  level.br_anim["wz_iw9_delta_infil_s6_zmb15_sh000"] = % wz_iw9_delta_infil_s6_zmb15_sh000;
  level.br_anim["wz_iw9_delta_infil_s6_zmb16_sh000"] = % wz_iw9_delta_infil_s6_zmb16_sh000;
  level.br_anim["wz_iw9_delta_infil_s6_zmb17_sh000"] = % wz_iw9_delta_infil_s6_zmb17_sh000;
  level.br_anim["wz_iw9_delta_infil_s6_zmb18_sh000"] = % wz_iw9_delta_infil_s6_zmb18_sh000;
  level.br_anim["wz_iw9_delta_infil_s6_zmb19_sh000"] = % wz_iw9_delta_infil_s6_zmb19_sh000;
  level.br_anim["wz_iw9_delta_infil_s6_zmb20_sh000"] = % wz_iw9_delta_infil_s6_zmb20_sh000;
  level.br_anim["wz_iw9_delta_infil_s6_zmb01_sh080_idle"] = % wz_iw9_delta_infil_s6_zmb01_sh080_idle;
  level.br_anim["wz_iw9_delta_infil_s6_zmb02_sh080_idle"] = % wz_iw9_delta_infil_s6_zmb02_sh080_idle;
  level.br_anim["wz_iw9_delta_infil_s6_zmb03_sh080_idle"] = % wz_iw9_delta_infil_s6_zmb03_sh080_idle;
  level.br_anim["wz_iw9_delta_infil_s6_zmb04_sh080_idle"] = % wz_iw9_delta_infil_s6_zmb04_sh080_idle;
  level.br_anim["wz_iw9_delta_infil_s6_zmb05_sh080_idle"] = % wz_iw9_delta_infil_s6_zmb05_sh080_idle;
  level.br_anim["wz_iw9_delta_infil_s6_zmb06_sh080_idle"] = % wz_iw9_delta_infil_s6_zmb06_sh080_idle;
  level.br_anim["wz_iw9_delta_infil_s6_zmb07_sh080_idle"] = % wz_iw9_delta_infil_s6_zmb07_sh080_idle;
  level.br_anim["wz_iw9_delta_infil_s6_zmb08_sh080_idle"] = % wz_iw9_delta_infil_s6_zmb08_sh080_idle;
  level.br_anim["wz_iw9_delta_infil_s6_zmb09_sh080_idle"] = % wz_iw9_delta_infil_s6_zmb09_sh080_idle;
  level.br_anim["wz_iw9_delta_infil_s6_zmb10_sh080_idle"] = % wz_iw9_delta_infil_s6_zmb10_sh080_idle;
  level.br_anim["wz_iw9_delta_infil_s6_zmb11_sh080_idle"] = % wz_iw9_delta_infil_s6_zmb11_sh080_idle;
  level.br_anim["wz_iw9_delta_infil_s6_zmb12_sh080_idle"] = % wz_iw9_delta_infil_s6_zmb12_sh080_idle;
  level.br_anim["wz_iw9_delta_infil_s6_zmb13_sh080_idle"] = % wz_iw9_delta_infil_s6_zmb13_sh080_idle;
  level.br_anim["wz_iw9_delta_infil_s6_zmb14_sh080_idle"] = % wz_iw9_delta_infil_s6_zmb14_sh080_idle;
  level.br_anim["wz_iw9_delta_infil_s6_zmb15_sh080_idle"] = % wz_iw9_delta_infil_s6_zmb15_sh080_idle;
  level.br_anim["wz_iw9_delta_infil_s6_zmb16_sh080_idle"] = % wz_iw9_delta_infil_s6_zmb16_sh080_idle;
  level.br_anim["wz_iw9_delta_infil_s6_zmb17_sh080_idle"] = % wz_iw9_delta_infil_s6_zmb17_sh080_idle;
  level.br_anim["wz_iw9_delta_infil_s6_zmb18_sh080_idle"] = % wz_iw9_delta_infil_s6_zmb18_sh080_idle;
  level.br_anim["wz_iw9_delta_infil_s6_zmb19_sh080_idle"] = % wz_iw9_delta_infil_s6_zmb19_sh080_idle;
  level.br_anim["wz_iw9_delta_infil_s6_zmb20_sh080_idle"] = % wz_iw9_delta_infil_s6_zmb20_sh080_idle;
  level.br_anim["wz_iw9_delta_infil_s6_g_prop_sh000"] = % wz_iw9_delta_infil_s6_g_prop_sh000;
  level.br_anim["wz_iw9_delta_infil_s6_g_prop_sh010"] = % wz_iw9_delta_infil_s6_g_prop_sh010;
  level.br_anim["wz_iw9_delta_infil_s6_g_prop_sh020"] = % wz_iw9_delta_infil_s6_g_prop_sh020;
  level.br_anim["wz_iw9_delta_infil_s6_g_prop_sh030"] = % wz_iw9_delta_infil_s6_g_prop_sh030;
  level.br_anim["wz_iw9_delta_infil_s6_g_prop_sh040"] = % wz_iw9_delta_infil_s6_g_prop_sh040;
  level.br_anim["wz_iw9_delta_infil_s6_g_prop_sh050"] = % wz_iw9_delta_infil_s6_g_prop_sh050;
  level.br_anim["wz_iw9_delta_infil_s6_g_prop_sh060"] = % wz_iw9_delta_infil_s6_g_prop_sh060;
  level.br_anim["wz_iw9_delta_infil_s6_g_prop_sh070"] = % wz_iw9_delta_infil_s6_g_prop_sh070;
  level.br_anim["wz_iw9_delta_infil_s6_g_prop_sh080"] = % wz_iw9_delta_infil_s6_g_prop_sh080;
  level.br_anim["wz_iw9_delta_infil_s6_g_prop_sh080_idle"] = % wz_iw9_delta_infil_s6_g_prop_sh080_idle;
  level.br_anim["wz_iw9_delta_infil_s6_cargoplane_sh000"] = % wz_iw9_delta_infil_s6_cargoplane_sh000;
  level.br_anim["wz_iw9_delta_infil_cargoplane_sh010"] = % wz_iw9_delta_infil_cargoplane_sh010;
  level.br_anim["wz_iw9_delta_infil_cargoplane_sh020"] = % wz_iw9_delta_infil_cargoplane_sh020;
  level.br_anim["wz_iw9_delta_infil_cargoplane_sh030"] = % wz_iw9_delta_infil_cargoplane_sh030;
  level.br_anim["wz_iw9_delta_infil_cargoplane_sh040"] = % wz_iw9_delta_infil_cargoplane_sh040;
  level.br_anim["wz_iw9_delta_infil_cargoplane_sh050"] = % wz_iw9_delta_infil_cargoplane_sh050;
  level.br_anim["wz_iw9_delta_infil_cargoplane_sh060"] = % wz_iw9_delta_infil_cargoplane_sh060;
  level.br_anim["wz_iw9_delta_infil_cargoplane_sh070"] = % wz_iw9_delta_infil_cargoplane_sh070;
  level.br_anim["wz_iw9_delta_infil_cargoplane_sh080"] = % wz_iw9_delta_infil_cargoplane_sh080;
  level.br_anim["wz_iw9_delta_infil_s6_cargoplane_sh080_idle"] = % wz_iw9_delta_infil_s6_cargoplane_sh080_idle;
  level.br_anim["wz_iw9_delta_infil_carepackage1_sh010"] = % wz_iw9_delta_infil_carepackage1_sh010;
  level.br_anim["wz_iw9_delta_infil_carepackage1_sh020"] = % wz_iw9_delta_infil_carepackage1_sh020;
  level.br_anim["wz_iw9_delta_infil_carepackage1_sh030"] = % wz_iw9_delta_infil_carepackage1_sh030;
  level.br_anim["wz_iw9_delta_infil_carepackage1_sh040"] = % wz_iw9_delta_infil_carepackage1_sh040;
  level.br_anim["wz_iw9_delta_infil_carepackage1_sh050"] = % wz_iw9_delta_infil_carepackage1_sh050;
  level.br_anim["wz_iw9_delta_infil_carepackage1_sh060"] = % wz_iw9_delta_infil_carepackage1_sh060;
  level.br_anim["wz_iw9_delta_infil_carepackage1_sh070"] = % wz_iw9_delta_infil_carepackage1_sh070;
  level.br_anim["wz_iw9_delta_infil_carepackage1_sh080"] = % wz_iw9_delta_infil_carepackage1_sh080;
  level.br_anim["wz_iw9_delta_infil_s6_plr1_sh010"] = % wz_iw9_delta_infil_s6_plr1_sh010;
  level.br_anim["wz_iw9_delta_infil_s6_plr1_sh010_solo"] = % wz_iw9_delta_infil_s6_plr1_sh010_solo;
  level.br_anim["wz_iw9_delta_infil_s6_plr1_sh020"] = % wz_iw9_delta_infil_s6_plr1_sh020;
  level.br_anim["wz_iw9_delta_infil_s6_plr1_sh020_solo"] = % wz_iw9_delta_infil_s6_plr1_sh020_solo;
  level.br_anim["wz_iw9_delta_infil_s6_plr1_sh030"] = % wz_iw9_delta_infil_s6_plr1_sh030;
  level.br_anim["wz_iw9_delta_infil_s6_plr1_sh030_solo"] = % wz_iw9_delta_infil_s6_plr1_sh030_solo;
  level.br_anim["wz_iw9_delta_infil_s6_plr1_sh040"] = % wz_iw9_delta_infil_s6_plr1_sh040;
  level.br_anim["wz_iw9_delta_infil_s6_plr1_sh040_solo"] = % wz_iw9_delta_infil_s6_plr1_sh040_solo;
  level.br_anim["wz_iw9_delta_infil_s6_plr1_sh050"] = % wz_iw9_delta_infil_s6_plr1_sh050;
  level.br_anim["wz_iw9_delta_infil_s6_plr1_sh050_solo"] = % wz_iw9_delta_infil_s6_plr1_sh050_solo;
  level.br_anim["wz_iw9_delta_infil_s6_plr1_sh060"] = % wz_iw9_delta_infil_s6_plr1_sh060;
  level.br_anim["wz_iw9_delta_infil_s6_plr1_sh060_solo"] = % wz_iw9_delta_infil_s6_plr1_sh060_solo;
  level.br_anim["wz_iw9_delta_infil_s6_plr1_sh070"] = % wz_iw9_delta_infil_s6_plr1_sh070;
  level.br_anim["wz_iw9_delta_infil_s6_plr1_sh070_solo"] = % wz_iw9_delta_infil_s6_plr1_sh070_solo;
  level.br_anim["wz_iw9_delta_infil_s6_plr1_sh080"] = % wz_iw9_delta_infil_s6_plr1_sh080;
  level.br_anim["wz_iw9_delta_infil_s6_plr1_sh080_solo"] = % wz_iw9_delta_infil_s6_plr1_sh080_solo;
  level.br_anim["wz_iw9_delta_infil_s6_plr1_fem_sh010"] = % wz_iw9_delta_infil_s6_plr1_fem_sh010;
  level.br_anim["wz_iw9_delta_infil_s6_plr1_fem_sh020"] = % wz_iw9_delta_infil_s6_plr1_fem_sh020;
  level.br_anim["wz_iw9_delta_infil_s6_plr1_fem_sh030"] = % wz_iw9_delta_infil_s6_plr1_fem_sh030;
  level.br_anim["wz_iw9_delta_infil_s6_plr1_fem_sh040"] = % wz_iw9_delta_infil_s6_plr1_fem_sh040;
  level.br_anim["wz_iw9_delta_infil_s6_plr1_fem_sh050"] = % wz_iw9_delta_infil_s6_plr1_fem_sh050;
  level.br_anim["wz_iw9_delta_infil_s6_plr1_fem_sh060"] = % wz_iw9_delta_infil_s6_plr1_fem_sh060;
  level.br_anim["wz_iw9_delta_infil_s6_plr1_fem_sh070"] = % wz_iw9_delta_infil_s6_plr1_fem_sh070;
  level.br_anim["wz_iw9_delta_infil_s6_plr1_fem_sh080"] = % wz_iw9_delta_infil_s6_plr1_fem_sh080;
  level.br_anim["wz_iw9_delta_infil_s6_plr1_fem_sh010_solo"] = % wz_iw9_delta_infil_s6_plr1_fem_sh010_solo;
  level.br_anim["wz_iw9_delta_infil_s6_plr1_fem_sh020_solo"] = % wz_iw9_delta_infil_s6_plr1_fem_sh020_solo;
  level.br_anim["wz_iw9_delta_infil_s6_plr1_fem_sh030_solo"] = % wz_iw9_delta_infil_s6_plr1_fem_sh030_solo;
  level.br_anim["wz_iw9_delta_infil_s6_plr1_fem_sh040_solo"] = % wz_iw9_delta_infil_s6_plr1_fem_sh040_solo;
  level.br_anim["wz_iw9_delta_infil_s6_plr1_fem_sh050_solo"] = % wz_iw9_delta_infil_s6_plr1_fem_sh050_solo;
  level.br_anim["wz_iw9_delta_infil_s6_plr1_fem_sh060_solo"] = % wz_iw9_delta_infil_s6_plr1_fem_sh060_solo;
  level.br_anim["wz_iw9_delta_infil_s6_plr1_fem_sh070_solo"] = % wz_iw9_delta_infil_s6_plr1_fem_sh070_solo;
  level.br_anim["wz_iw9_delta_infil_s6_plr1_fem_sh080_solo"] = % wz_iw9_delta_infil_s6_plr1_fem_sh080_solo;
  level.br_anim["wz_iw9_delta_infil_plr2_sh010"] = % wz_iw9_delta_infil_plr2_sh010;
  level.br_anim["wz_iw9_delta_infil_plr2_sh020"] = % wz_iw9_delta_infil_plr2_sh020;
  level.br_anim["wz_iw9_delta_infil_plr2_sh030"] = % wz_iw9_delta_infil_plr2_sh030;
  level.br_anim["wz_iw9_delta_infil_plr2_sh040"] = % wz_iw9_delta_infil_plr2_sh040;
  level.br_anim["wz_iw9_delta_infil_plr2_sh050"] = % wz_iw9_delta_infil_plr2_sh050;
  level.br_anim["wz_iw9_delta_infil_plr2_sh060"] = % wz_iw9_delta_infil_plr2_sh060;
  level.br_anim["wz_iw9_delta_infil_plr2_sh070"] = % wz_iw9_delta_infil_plr2_sh070;
  level.br_anim["wz_iw9_delta_infil_plr2_sh080"] = % wz_iw9_delta_infil_plr2_sh080;
  level.br_anim["wz_iw9_delta_infil_plr2_fem_sh010"] = % wz_iw9_delta_infil_plr2_fem_sh010;
  level.br_anim["wz_iw9_delta_infil_plr2_fem_sh020"] = % wz_iw9_delta_infil_plr2_fem_sh020;
  level.br_anim["wz_iw9_delta_infil_plr2_fem_sh030"] = % wz_iw9_delta_infil_plr2_fem_sh030;
  level.br_anim["wz_iw9_delta_infil_plr2_fem_sh040"] = % wz_iw9_delta_infil_plr2_fem_sh040;
  level.br_anim["wz_iw9_delta_infil_plr2_fem_sh050"] = % wz_iw9_delta_infil_plr2_fem_sh050;
  level.br_anim["wz_iw9_delta_infil_plr2_fem_sh060"] = % wz_iw9_delta_infil_plr2_fem_sh060;
  level.br_anim["wz_iw9_delta_infil_plr2_fem_sh070"] = % wz_iw9_delta_infil_plr2_fem_sh070;
  level.br_anim["wz_iw9_delta_infil_plr2_fem_sh080"] = % wz_iw9_delta_infil_plr2_fem_sh080;
  level.br_anim["wz_iw9_delta_infil_plr3_sh010"] = % wz_iw9_delta_infil_plr3_sh010;
  level.br_anim["wz_iw9_delta_infil_plr3_sh020"] = % wz_iw9_delta_infil_plr3_sh020;
  level.br_anim["wz_iw9_delta_infil_plr3_sh030"] = % wz_iw9_delta_infil_plr3_sh030;
  level.br_anim["wz_iw9_delta_infil_plr3_sh040"] = % wz_iw9_delta_infil_plr3_sh040;
  level.br_anim["wz_iw9_delta_infil_plr3_sh050"] = % wz_iw9_delta_infil_plr3_sh050;
  level.br_anim["wz_iw9_delta_infil_plr3_sh060"] = % wz_iw9_delta_infil_plr3_sh060;
  level.br_anim["wz_iw9_delta_infil_plr3_sh070"] = % wz_iw9_delta_infil_plr3_sh070;
  level.br_anim["wz_iw9_delta_infil_plr3_sh080"] = % wz_iw9_delta_infil_plr3_sh080;
  level.br_anim["wz_iw9_delta_infil_plr3_fem_sh010"] = % wz_iw9_delta_infil_plr3_fem_sh010;
  level.br_anim["wz_iw9_delta_infil_plr3_fem_sh020"] = % wz_iw9_delta_infil_plr3_fem_sh020;
  level.br_anim["wz_iw9_delta_infil_plr3_fem_sh030"] = % wz_iw9_delta_infil_plr3_fem_sh030;
  level.br_anim["wz_iw9_delta_infil_plr3_fem_sh040"] = % wz_iw9_delta_infil_plr3_fem_sh040;
  level.br_anim["wz_iw9_delta_infil_plr3_fem_sh050"] = % wz_iw9_delta_infil_plr3_fem_sh050;
  level.br_anim["wz_iw9_delta_infil_plr3_fem_sh060"] = % wz_iw9_delta_infil_plr3_fem_sh060;
  level.br_anim["wz_iw9_delta_infil_plr3_fem_sh070"] = % wz_iw9_delta_infil_plr3_fem_sh070;
  level.br_anim["wz_iw9_delta_infil_plr3_fem_sh080"] = % wz_iw9_delta_infil_plr3_fem_sh080;
  level.br_anim["wz_iw9_delta_infil_plr4_sh010"] = % wz_iw9_delta_infil_s6_plr4_sh010;
  level.br_anim["wz_iw9_delta_infil_plr4_sh020"] = % wz_iw9_delta_infil_s6_plr4_sh020;
  level.br_anim["wz_iw9_delta_infil_plr4_sh030"] = % wz_iw9_delta_infil_s6_plr4_sh030;
  level.br_anim["wz_iw9_delta_infil_plr4_sh040"] = % wz_iw9_delta_infil_s6_plr4_sh040;
  level.br_anim["wz_iw9_delta_infil_plr4_sh050"] = % wz_iw9_delta_infil_s6_plr4_sh050;
  level.br_anim["wz_iw9_delta_infil_plr4_sh060"] = % wz_iw9_delta_infil_s6_plr4_sh060;
  level.br_anim["wz_iw9_delta_infil_plr4_sh070"] = % wz_iw9_delta_infil_s6_plr4_sh070;
  level.br_anim["wz_iw9_delta_infil_plr4_sh080"] = % wz_iw9_delta_infil_plr4_sh080;
  level.br_anim["wz_iw9_delta_infil_plr4_fem_sh010"] = % wz_iw9_delta_infil_s6_plr4_fem_sh010;
  level.br_anim["wz_iw9_delta_infil_plr4_fem_sh020"] = % wz_iw9_delta_infil_s6_plr4_fem_sh020;
  level.br_anim["wz_iw9_delta_infil_plr4_fem_sh030"] = % wz_iw9_delta_infil_s6_plr4_fem_sh030;
  level.br_anim["wz_iw9_delta_infil_plr4_fem_sh040"] = % wz_iw9_delta_infil_s6_plr4_fem_sh040;
  level.br_anim["wz_iw9_delta_infil_plr4_fem_sh050"] = % wz_iw9_delta_infil_s6_plr4_fem_sh050;
  level.br_anim["wz_iw9_delta_infil_plr4_fem_sh060"] = % wz_iw9_delta_infil_s6_plr4_fem_sh060;
  level.br_anim["wz_iw9_delta_infil_plr4_fem_sh070"] = % wz_iw9_delta_infil_s6_plr4_fem_sh070;
  level.br_anim["wz_iw9_delta_infil_plr4_fem_sh080"] = % wz_iw9_delta_infil_plr4_fem_sh080;
  level.br_anim["wz_iw9_delta_infil_npc1_sh010"] = % wz_iw9_delta_infil_npc1_sh010;
  level.br_anim["wz_iw9_delta_infil_npc1_sh020"] = % wz_iw9_delta_infil_npc1_sh020;
  level.br_anim["wz_iw9_delta_infil_npc1_sh030"] = % wz_iw9_delta_infil_npc1_sh030;
  level.br_anim["wz_iw9_delta_infil_npc1_sh040"] = % wz_iw9_delta_infil_npc1_sh040;
  level.br_anim["wz_iw9_delta_infil_npc1_sh050"] = % wz_iw9_delta_infil_npc1_sh050;
  level.br_anim["wz_iw9_delta_infil_npc1_sh060"] = % wz_iw9_delta_infil_npc1_sh060;
  level.br_anim["wz_iw9_delta_infil_npc1_sh070"] = % wz_iw9_delta_infil_npc1_sh070;
  level.br_anim["wz_iw9_delta_infil_npc1_sh080"] = % wz_iw9_delta_infil_npc1_sh080;
  level.br_anim["wz_iw9_delta_infil_npc2_sh010"] = % wz_iw9_delta_infil_npc2_sh010;
  level.br_anim["wz_iw9_delta_infil_npc2_sh020"] = % wz_iw9_delta_infil_npc2_sh020;
  level.br_anim["wz_iw9_delta_infil_npc2_sh030"] = % wz_iw9_delta_infil_npc2_sh030;
  level.br_anim["wz_iw9_delta_infil_npc2_sh040"] = % wz_iw9_delta_infil_npc2_sh040;
  level.br_anim["wz_iw9_delta_infil_npc2_sh050"] = % wz_iw9_delta_infil_npc2_sh050;
  level.br_anim["wz_iw9_delta_infil_npc2_sh060"] = % wz_iw9_delta_infil_npc2_sh060;
  level.br_anim["wz_iw9_delta_infil_npc2_sh070"] = % wz_iw9_delta_infil_npc2_sh070;
  level.br_anim["wz_iw9_delta_infil_npc2_sh080"] = % wz_iw9_delta_infil_npc2_sh080;
  level.br_anim["wz_iw9_delta_infil_s6_npc3_sh010"] = % wz_iw9_delta_infil_s6_npc3_sh010;
  level.br_anim["wz_iw9_delta_infil_s6_npc3_sh020"] = % wz_iw9_delta_infil_s6_npc3_sh020;
  level.br_anim["wz_iw9_delta_infil_s6_npc3_sh030"] = % wz_iw9_delta_infil_s6_npc3_sh030;
  level.br_anim["wz_iw9_delta_infil_s6_npc3_sh040"] = % wz_iw9_delta_infil_s6_npc3_sh040;
  level.br_anim["wz_iw9_delta_infil_s6_npc3_sh050"] = % wz_iw9_delta_infil_s6_npc3_sh050;
  level.br_anim["wz_iw9_delta_infil_s6_npc3_sh060"] = % wz_iw9_delta_infil_s6_npc3_sh060;
  level.br_anim["wz_iw9_delta_infil_s6_npc3_sh070"] = % wz_iw9_delta_infil_s6_npc3_sh070;
  level.br_anim["wz_iw9_delta_infil_s6_npc3_sh080"] = % wz_iw9_delta_infil_s6_npc3_sh080;
  level.br_anim["wz_iw9_delta_infil_heli_crash"] = % wz_iw9_delta_infil_heli_crash;
  level.br_anim["wz_iw9_delta_infil_heli_missile"] = % wz_iw9_delta_infil_heli_missile;
  level.br_anim["wz_iw9_delta_infil_heli_missile_miss"] = % wz_iw9_delta_infil_heli_missile_miss;
  level.br_anim["wz_iw9_delta_infil_s6_zmb01_sh010"] = % wz_iw9_delta_infil_s6_zmb01_sh010;
  level.br_anim["wz_iw9_delta_infil_s6_zmb01_sh020"] = % wz_iw9_delta_infil_s6_zmb01_sh020;
  level.br_anim["wz_iw9_delta_infil_s6_zmb01_sh030"] = % wz_iw9_delta_infil_s6_zmb01_sh030;
  level.br_anim["wz_iw9_delta_infil_s6_zmb01_sh040"] = % wz_iw9_delta_infil_s6_zmb01_sh040;
  level.br_anim["wz_iw9_delta_infil_s6_zmb01_sh050"] = % wz_iw9_delta_infil_s6_zmb01_sh050;
  level.br_anim["wz_iw9_delta_infil_s6_zmb01_sh060"] = % wz_iw9_delta_infil_s6_zmb01_sh060;
  level.br_anim["wz_iw9_delta_infil_s6_zmb01_sh070"] = % wz_iw9_delta_infil_s6_zmb01_sh070;
  level.br_anim["wz_iw9_delta_infil_s6_zmb01_sh080"] = % wz_iw9_delta_infil_s6_zmb01_sh080;
}

function getAnimStruct(animstruct) {
  animstruct.staticc130 = getEnt("infil_ac130_delta_exterior", "targetname");

  if(isDefined(animstruct.staticc130)) {
    animstruct.staticc130 show();
    animstruct.staticc130.animname = "c130";
    animstruct.staticc130.dontdelete = 1;
  } else {
    animstruct.staticc130 = animstruct namespace_81156089ff1fe819::spawn_script_model("black::veh9_mil_air_cargo_plane_exterior_infil", "c130");
  }

  animstruct.staticc130.dontteleport = 1;
  animstruct.camerarunner = animstruct namespace_81156089ff1fe819::spawn_script_model("generic_prop_x30", "camera");
  animstruct.camerarunner linkTo(animstruct.staticc130, "tag_body_animate", (0, 0, 0), (0, 0, 0));

  if(scripts\mp\utility\game::getsubgametype() == "zxp") {
    animstruct.introplane = animstruct namespace_81156089ff1fe819::spawn_script_model("veh9_mil_air_cargo_plane_exterior_infil_green", "introPlane");
  } else {
    animstruct.introplane = animstruct namespace_81156089ff1fe819::spawn_script_model("black::veh9_mil_air_cargo_plane", "introPlane");
  }

  animstruct.introplane linkTo(animstruct.camerarunner, "j_prop_30");
  skins = ["milsim_western_a", "milsim_western_b", "milsim_western_c", "milsim_western_d", "milsim_eastern_a", "milsim_eastern_b", "milsim_eastern_c", "milsim_eastern_d"];
  animstruct.playertags = [];
  animstruct.playertags[0] = animstruct namespace_81156089ff1fe819::spawn_script_model("tag_player", "playerTag1");
  animstruct.playertags[1] = animstruct namespace_81156089ff1fe819::spawn_script_model("tag_player", "playerTag2");
  animstruct.playertags[2] = animstruct namespace_81156089ff1fe819::spawn_script_model("tag_player", "playerTag3");
  animstruct.playertags[3] = animstruct namespace_81156089ff1fe819::spawn_script_model("tag_player", "playerTag4");
  animstruct.playertags[4] = animstruct namespace_81156089ff1fe819::spawn_script_model("tag_player", "playerTag5");
  animstruct.playertags[0] linkTo(animstruct.camerarunner, "j_prop_2", (0, 0, 0), (0, 0, 0));
  animstruct.playertags[1] linkTo(animstruct.camerarunner, "j_prop_3", (0, 0, 0), (0, 0, 0));
  animstruct.playertags[2] linkTo(animstruct.camerarunner, "j_prop_4", (0, 0, 0), (0, 0, 0));
  animstruct.playertags[3] linkTo(animstruct.camerarunner, "j_prop_5", (0, 0, 0), (0, 0, 0));
  animstruct.playertags[4] linkTo(animstruct.camerarunner, "j_prop_15", (0, 0, 0), (0, 0, 0));
  animstruct.playermodels = [];
  animstruct.playermodels[0] = animstruct namespace_81156089ff1fe819::spawn_script_model("fullbody_usmc_ar_br_infil", "player1");
  animstruct.playermodels[1] = animstruct namespace_81156089ff1fe819::spawn_script_model("fullbody_usmc_ar_br_infil", "player2");
  animstruct.playermodels[2] = animstruct namespace_81156089ff1fe819::spawn_script_model("fullbody_usmc_ar_br_infil", "player3");
  animstruct.playermodels[3] = animstruct namespace_81156089ff1fe819::spawn_script_model("fullbody_usmc_ar_br_infil", "player4");
  animstruct.playermodels[4] = animstruct namespace_81156089ff1fe819::spawn_script_model("fullbody_usmc_ar_br_infil", "player5");
  animstruct.playermodels[0] linkTo(animstruct.playertags[0], "tag_player", (0, 0, 0), (0, 0, 0));
  animstruct.playermodels[1] linkTo(animstruct.playertags[1], "tag_player", (0, 0, 0), (0, 0, 0));
  animstruct.playermodels[2] linkTo(animstruct.playertags[2], "tag_player", (0, 0, 0), (0, 0, 0));
  animstruct.playermodels[3] linkTo(animstruct.playertags[3], "tag_player", (0, 0, 0), (0, 0, 0));
  animstruct.playermodels[4] linkTo(animstruct.playertags[4], "tag_player", (0, 0, 0), (0, 0, 0));
  randomskins = scripts\engine\utility::array_randomize(skins);
  animstruct.playermodels[0] scripts\mp\gametypes\br_infils_ac130::function_66b13900c5013de5(randomskins[0]);
  animstruct.playermodels[1] scripts\mp\gametypes\br_infils_ac130::function_66b13900c5013de5(randomskins[1]);
  animstruct.playermodels[2] scripts\mp\gametypes\br_infils_ac130::function_66b13900c5013de5(randomskins[2]);
  animstruct.playermodels[3] scripts\mp\gametypes\br_infils_ac130::function_66b13900c5013de5(randomskins[3]);
  animstruct.playermodels[4] scripts\mp\gametypes\br_infils_ac130::function_66b13900c5013de5(randomskins[4]);
  animstruct.crates = [];
  animstruct.crates[0] = animstruct namespace_81156089ff1fe819::spawn_script_model("military_carepackage_03_br", "crate1");
  animstruct.crates[0] linkTo(animstruct.camerarunner, "j_prop_8", (0, 0, 0), (0, 0, 0));
  animstruct.npcs = [];
  animstruct.npcs[0] = animstruct namespace_81156089ff1fe819::spawn_script_model("fullbody_usmc_ar_br_infil", "npc1");
  animstruct.npcs[1] = animstruct namespace_81156089ff1fe819::spawn_script_model("fullbody_usmc_ar_br_infil", "npc2");
  animstruct.npcs[2] = animstruct namespace_81156089ff1fe819::spawn_script_model("fullbody_usmc_ar_br_infil", "npc3");
  animstruct.npcs[3] = animstruct namespace_81156089ff1fe819::spawn_script_model("fullbody_zombie_a_infil", "npc4");
  animstruct.npcs[0] linkTo(animstruct.camerarunner, "j_prop_9", (0, 0, 0), (0, 0, 0));
  animstruct.npcs[1] linkTo(animstruct.camerarunner, "j_prop_10", (0, 0, 0), (0, 0, 0));
  animstruct.npcs[2] linkTo(animstruct.camerarunner, "j_prop_11", (0, 0, 0), (0, 0, 0));
  animstruct.npcs[3] linkTo(animstruct.camerarunner, "j_prop_20", (0, 0, 0), (0, 0, 0));
  randomskins = scripts\engine\utility::array_randomize(skins);
  animstruct.npcs[0] scripts\mp\gametypes\br_infils_ac130::function_66b13900c5013de5(randomskins[0]);
  animstruct.npcs[1] scripts\mp\gametypes\br_infils_ac130::function_66b13900c5013de5(randomskins[1]);
  animstruct.npcs[2] scripts\mp\gametypes\br_infils_ac130::function_66b13900c5013de5(randomskins[2]);
  animstruct.var_225add0764cabce2 = animstruct function_f9c90bddfe9edeb("wz_iw9_delta_infil_s6_g_prop_sh000_l", "wz_iw9_delta_infil_s6_g_prop_sh080_idle_l", "j_prop_28");
  animstruct.var_cac4e9f7fb01d4ef = animstruct function_f9c90bddfe9edeb("wz_iw9_delta_infil_s6_g_prop_sh000_r", "wz_iw9_delta_infil_s6_g_prop_sh080_idle_r", "j_prop_29");
  animstruct function_d504b15d94a33dd3("wz_iw9_delta_infil_s6_zmb01_sh000", "wz_iw9_delta_infil_s6_zmb01_sh080_idle", animstruct.var_225add0764cabce2, "j_prop_1");
  animstruct function_d504b15d94a33dd3("wz_iw9_delta_infil_s6_zmb02_sh000", "wz_iw9_delta_infil_s6_zmb02_sh080_idle", animstruct.var_225add0764cabce2, "j_prop_2");
  animstruct function_d504b15d94a33dd3("wz_iw9_delta_infil_s6_zmb03_sh000", "wz_iw9_delta_infil_s6_zmb03_sh080_idle", animstruct.var_225add0764cabce2, "j_prop_3");
  animstruct function_d504b15d94a33dd3("wz_iw9_delta_infil_s6_zmb04_sh000", "wz_iw9_delta_infil_s6_zmb04_sh080_idle", animstruct.var_225add0764cabce2, "j_prop_4");
  animstruct function_d504b15d94a33dd3("wz_iw9_delta_infil_s6_zmb05_sh000", "wz_iw9_delta_infil_s6_zmb05_sh080_idle", animstruct.var_225add0764cabce2, "j_prop_5");
  animstruct function_d504b15d94a33dd3("wz_iw9_delta_infil_s6_zmb06_sh000", "wz_iw9_delta_infil_s6_zmb06_sh080_idle", animstruct.var_225add0764cabce2, "j_prop_6");
  animstruct function_d504b15d94a33dd3("wz_iw9_delta_infil_s6_zmb07_sh000", "wz_iw9_delta_infil_s6_zmb07_sh080_idle", animstruct.var_225add0764cabce2, "j_prop_7");
  animstruct function_d504b15d94a33dd3("wz_iw9_delta_infil_s6_zmb08_sh000", "wz_iw9_delta_infil_s6_zmb08_sh080_idle", animstruct.var_225add0764cabce2, "j_prop_8");
  animstruct function_d504b15d94a33dd3("wz_iw9_delta_infil_s6_zmb09_sh000", "wz_iw9_delta_infil_s6_zmb09_sh080_idle", animstruct.var_225add0764cabce2, "j_prop_9");
  animstruct function_d504b15d94a33dd3("wz_iw9_delta_infil_s6_zmb10_sh000", "wz_iw9_delta_infil_s6_zmb10_sh080_idle", animstruct.var_225add0764cabce2, "j_prop_10");
  animstruct function_d504b15d94a33dd3("wz_iw9_delta_infil_s6_zmb11_sh000", "wz_iw9_delta_infil_s6_zmb11_sh080_idle", animstruct.var_cac4e9f7fb01d4ef, "j_prop_1");
  animstruct function_d504b15d94a33dd3("wz_iw9_delta_infil_s6_zmb12_sh000", "wz_iw9_delta_infil_s6_zmb12_sh080_idle", animstruct.var_cac4e9f7fb01d4ef, "j_prop_2");
  animstruct function_d504b15d94a33dd3("wz_iw9_delta_infil_s6_zmb13_sh000", "wz_iw9_delta_infil_s6_zmb13_sh080_idle", animstruct.var_cac4e9f7fb01d4ef, "j_prop_3");
  animstruct function_d504b15d94a33dd3("wz_iw9_delta_infil_s6_zmb14_sh000", "wz_iw9_delta_infil_s6_zmb14_sh080_idle", animstruct.var_cac4e9f7fb01d4ef, "j_prop_4");
  animstruct function_d504b15d94a33dd3("wz_iw9_delta_infil_s6_zmb15_sh000", "wz_iw9_delta_infil_s6_zmb15_sh080_idle", animstruct.var_cac4e9f7fb01d4ef, "j_prop_5");
  animstruct function_d504b15d94a33dd3("wz_iw9_delta_infil_s6_zmb16_sh000", "wz_iw9_delta_infil_s6_zmb16_sh080_idle", animstruct.var_cac4e9f7fb01d4ef, "j_prop_6");
  animstruct function_d504b15d94a33dd3("wz_iw9_delta_infil_s6_zmb17_sh000", "wz_iw9_delta_infil_s6_zmb17_sh080_idle", animstruct.var_cac4e9f7fb01d4ef, "j_prop_7");
  animstruct function_d504b15d94a33dd3("wz_iw9_delta_infil_s6_zmb18_sh000", "wz_iw9_delta_infil_s6_zmb18_sh080_idle", animstruct.var_cac4e9f7fb01d4ef, "j_prop_8");
  animstruct function_d504b15d94a33dd3("wz_iw9_delta_infil_s6_zmb19_sh000", "wz_iw9_delta_infil_s6_zmb19_sh080_idle", animstruct.var_cac4e9f7fb01d4ef, "j_prop_9");
  animstruct function_d504b15d94a33dd3("wz_iw9_delta_infil_s6_zmb20_sh000", "wz_iw9_delta_infil_s6_zmb20_sh080_idle", animstruct.var_cac4e9f7fb01d4ef, "j_prop_10");
  animstruct.packs = [];
  n = 0;
  var_e92aed86e7dd8b76 = 10;
  quadsfov = 10;
  var_92c2f39adf1c2e62 = 0;
  animstruct.packs[n] = animstruct namespace_81156089ff1fe819::create_animpack("scene0.0");
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_startfunc([var_e92aed86e7dd8b76, quadsfov, var_92c2f39adf1c2e62], &scripts\mp\gametypes\br_infils_ac130::function_1a124e836e45482c);
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_modelanim(animstruct.camerarunner, level.br_anim["wz_iw9_delta_infil_s6_g_prop_sh000"]);
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_modelanim(animstruct.introplane, level.br_anim["wz_iw9_delta_infil_s6_cargoplane_sh000"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_ad0bcac98781e0ab(animstruct.playertags[0], level.br_anim["wz_infil_drone_guy1_idle_sh010"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_ad0bcac98781e0ab(animstruct.playertags[1], level.br_anim["wz_infil_drone_guy2_idle_sh010"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_ad0bcac98781e0ab(animstruct.playertags[2], level.br_anim["wz_infil_drone_guy3_idle_sh010"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_ad0bcac98781e0ab(animstruct.playertags[3], level.br_anim["wz_infil_drone_guy4_idle_sh010"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_ad0bcac98781e0ab(animstruct.playertags[4], level.br_anim["wz_infil_drone_guy1_idle_sh010"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_f7fc8b110c478968(animstruct.playermodels[0], level.br_anim["wz_infil_drone_guy1_idle_sh010"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_f7fc8b110c478968(animstruct.playermodels[1], level.br_anim["wz_infil_drone_guy2_idle_sh010"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_f7fc8b110c478968(animstruct.playermodels[2], level.br_anim["wz_infil_drone_guy3_idle_sh010"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_f7fc8b110c478968(animstruct.playermodels[3], level.br_anim["wz_infil_drone_guy4_idle_sh010"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_f7fc8b110c478968(animstruct.playermodels[4], level.br_anim["wz_infil_drone_guy1_idle_sh010"]);

  foreach(var_70d30bdf11e3ec9b in animstruct.var_410039458420238) {
    animstruct.packs[n] namespace_81156089ff1fe819::add_pack_modelanim(var_70d30bdf11e3ec9b.gprop, level.br_anim[var_70d30bdf11e3ec9b.animname]);

    foreach(zombie in var_70d30bdf11e3ec9b.zombies) {
      animstruct.packs[n] namespace_81156089ff1fe819::add_pack_modelanim(zombie.model, level.br_anim[zombie.animname]);
    }
  }

  animstruct.packs[n] namespace_81156089ff1fe819::function_d4561ab1ba4f5de9(animstruct.camerarunner, "tag_origin", level.br_anim["wz_iw9_delta_infil_s6_g_prop_sh000"], "wz_infil_xcam_sh000_quads", &scripts\mp\gametypes\br_infils_ac130::getxcamfunc);
  animstruct.packs[n].xcams = ["wz_infil_xcam_sh000_quads", "wz_infil_xcam_sh000_quads", "wz_infil_xcam_sh000_quads", "wz_infil_xcam_sh000_quads"];

  if(!isDefined(level.scr_notetrack["camera"]) || !isDefined(level.scr_notetrack["camera"]["any"]["infil_header_player1"])) {
    scripts\common\anim::addnotetrack_customfunction("camera", "infil_header_player1", &scripts\mp\gametypes\br_infils_ac130::function_1a5e2c1cef16393f);
    scripts\common\anim::addnotetrack_customfunction("camera", "infil_header_player2", &scripts\mp\gametypes\br_infils_ac130::function_7797914101c3a342);
    scripts\common\anim::addnotetrack_customfunction("camera", "infil_header_player3", &scripts\mp\gametypes\br_infils_ac130::function_e86f60ffd1abcd75);
    scripts\common\anim::addnotetrack_customfunction("camera", "infil_header_player4", &scripts\mp\gametypes\br_infils_ac130::function_a9090d88a8813828);
  }

  n++;
  var_e92aed86e7dd8b76 = 35;
  quadsfov = 30;
  var_92c2f39adf1c2e62 = 0;
  animstruct.packs[n] = animstruct namespace_81156089ff1fe819::create_animpack("scene1");
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_startfunc([], &function_9638397bb7d4e928);
  animstruct.packs[n] scripts\mp\gametypes\br_infils_ac130::function_9afdeab1e38dac18(animstruct, level.br_anim["wz_iw9_delta_infil_cargoplane_sh010"]);
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_modelanim(animstruct.camerarunner, level.br_anim["wz_iw9_delta_infil_s6_g_prop_sh010"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_ad0bcac98781e0ab(animstruct.playertags[0], level.br_anim["wz_iw9_delta_infil_s6_plr1_sh010"], level.br_anim["wz_iw9_delta_infil_s6_plr1_fem_sh010"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_ad0bcac98781e0ab(animstruct.playertags[1], level.br_anim["wz_iw9_delta_infil_plr2_sh010"], level.br_anim["wz_iw9_delta_infil_plr2_fem_sh010"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_ad0bcac98781e0ab(animstruct.playertags[2], level.br_anim["wz_iw9_delta_infil_plr3_sh010"], level.br_anim["wz_iw9_delta_infil_plr3_fem_sh010"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_ad0bcac98781e0ab(animstruct.playertags[3], level.br_anim["wz_iw9_delta_infil_plr4_sh010"], level.br_anim["wz_iw9_delta_infil_plr4_fem_sh010"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_ad0bcac98781e0ab(animstruct.playertags[4], level.br_anim["wz_iw9_delta_infil_s6_plr1_sh010_solo"], level.br_anim["wz_iw9_delta_infil_s6_plr1_fem_sh010_solo"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_f7fc8b110c478968(animstruct.playermodels[0], level.br_anim["wz_iw9_delta_infil_s6_plr1_sh010"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_f7fc8b110c478968(animstruct.playermodels[1], level.br_anim["wz_iw9_delta_infil_plr2_sh010"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_f7fc8b110c478968(animstruct.playermodels[2], level.br_anim["wz_iw9_delta_infil_plr3_sh010"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_f7fc8b110c478968(animstruct.playermodels[3], level.br_anim["wz_iw9_delta_infil_plr4_sh010"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_f7fc8b110c478968(animstruct.playermodels[4], level.br_anim["wz_iw9_delta_infil_s6_plr1_sh010"]);
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_modelanim(animstruct.crates[0], level.br_anim["wz_iw9_delta_infil_carepackage1_sh010"]);
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_modelanim(animstruct.npcs[0], level.br_anim["wz_iw9_delta_infil_npc1_sh010"]);
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_modelanim(animstruct.npcs[1], level.br_anim["wz_iw9_delta_infil_npc2_sh010"]);
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_modelanim(animstruct.npcs[2], level.br_anim["wz_iw9_delta_infil_s6_npc3_sh010"]);
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_modelanim(animstruct.npcs[3], level.br_anim["wz_iw9_delta_infil_s6_zmb01_sh010"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_d4561ab1ba4f5de9(animstruct.camerarunner, "tag_origin", level.br_anim["wz_iw9_delta_infil_s6_g_prop_sh010"], "wz_iw9_delta_infil_s6_xcam_sh010", &scripts\mp\gametypes\br_infils_ac130::getxcamfunc);
  animstruct.packs[n].xcams = ["wz_iw9_delta_infil_s6_xcam_sh010_solo", "wz_iw9_delta_infil_s6_xcam_sh010", "wz_iw9_delta_infil_s6_xcam_sh010", "wz_iw9_delta_infil_s6_xcam_sh010"];
  n++;
  var_e92aed86e7dd8b76 = 35;
  quadsfov = 40;
  var_92c2f39adf1c2e62 = 0;
  animstruct.packs[n] = animstruct namespace_81156089ff1fe819::create_animpack("scene2");
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_startfunc([], &scripts\mp\gametypes\br_infils_ac130::function_9af898862a8c98b9);
  animstruct.packs[n] scripts\mp\gametypes\br_infils_ac130::function_9afdeab1e38dac18(animstruct, level.br_anim["wz_iw9_delta_infil_cargoplane_sh020"]);
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_modelanim(animstruct.camerarunner, level.br_anim["wz_iw9_delta_infil_s6_g_prop_sh020"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_ad0bcac98781e0ab(animstruct.playertags[0], level.br_anim["wz_iw9_delta_infil_s6_plr1_sh020"], level.br_anim["wz_iw9_delta_infil_s6_plr1_fem_sh020"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_ad0bcac98781e0ab(animstruct.playertags[1], level.br_anim["wz_iw9_delta_infil_plr2_sh020"], level.br_anim["wz_iw9_delta_infil_plr2_fem_sh020"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_ad0bcac98781e0ab(animstruct.playertags[2], level.br_anim["wz_iw9_delta_infil_plr3_sh020"], level.br_anim["wz_iw9_delta_infil_plr3_fem_sh020"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_ad0bcac98781e0ab(animstruct.playertags[3], level.br_anim["wz_iw9_delta_infil_plr4_sh020"], level.br_anim["wz_iw9_delta_infil_plr4_fem_sh020"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_ad0bcac98781e0ab(animstruct.playertags[4], level.br_anim["wz_iw9_delta_infil_s6_plr1_sh020_solo"], level.br_anim["wz_iw9_delta_infil_s6_plr1_fem_sh020_solo"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_f7fc8b110c478968(animstruct.playermodels[0], level.br_anim["wz_iw9_delta_infil_s6_plr1_sh020"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_f7fc8b110c478968(animstruct.playermodels[1], level.br_anim["wz_iw9_delta_infil_plr2_sh020"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_f7fc8b110c478968(animstruct.playermodels[2], level.br_anim["wz_iw9_delta_infil_plr3_sh020"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_f7fc8b110c478968(animstruct.playermodels[3], level.br_anim["wz_iw9_delta_infil_plr4_sh020"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_f7fc8b110c478968(animstruct.playermodels[4], level.br_anim["wz_iw9_delta_infil_s6_plr1_sh020"]);
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_modelanim(animstruct.crates[0], level.br_anim["wz_iw9_delta_infil_carepackage1_sh020"]);
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_modelanim(animstruct.npcs[0], level.br_anim["wz_iw9_delta_infil_npc1_sh020"]);
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_modelanim(animstruct.npcs[1], level.br_anim["wz_iw9_delta_infil_npc2_sh020"]);
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_modelanim(animstruct.npcs[2], level.br_anim["wz_iw9_delta_infil_s6_npc3_sh020"]);
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_modelanim(animstruct.npcs[3], level.br_anim["wz_iw9_delta_infil_s6_zmb01_sh020"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_d4561ab1ba4f5de9(animstruct.camerarunner, "tag_origin", level.br_anim["wz_iw9_delta_infil_s6_g_prop_sh020"], "wz_iw9_delta_infil_s6_xcam_sh020", &scripts\mp\gametypes\br_infils_ac130::getxcamfunc);
  animstruct.packs[n].xcams = ["wz_iw9_delta_infil_s6_xcam_sh020_solo", "wz_iw9_delta_infil_s6_xcam_sh020", "wz_iw9_delta_infil_s6_xcam_sh020", "wz_iw9_delta_infil_s6_xcam_sh020"];
  n++;
  var_e92aed86e7dd8b76 = 30;
  quadsfov = 40;
  var_92c2f39adf1c2e62 = 0;
  animstruct.packs[n] = animstruct namespace_81156089ff1fe819::create_animpack("scene3");
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_startfunc([], &scripts\mp\gametypes\br_infils_ac130::function_646b15a1f9a1e55a);
  animstruct.packs[n] scripts\mp\gametypes\br_infils_ac130::function_9afdeab1e38dac18(animstruct, level.br_anim["wz_iw9_delta_infil_cargoplane_sh030"]);
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_modelanim(animstruct.camerarunner, level.br_anim["wz_iw9_delta_infil_s6_g_prop_sh030"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_ad0bcac98781e0ab(animstruct.playertags[0], level.br_anim["wz_iw9_delta_infil_s6_plr1_sh030"], level.br_anim["wz_iw9_delta_infil_s6_plr1_fem_sh030"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_ad0bcac98781e0ab(animstruct.playertags[1], level.br_anim["wz_iw9_delta_infil_plr2_sh030"], level.br_anim["wz_iw9_delta_infil_plr2_fem_sh030"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_ad0bcac98781e0ab(animstruct.playertags[2], level.br_anim["wz_iw9_delta_infil_plr3_sh030"], level.br_anim["wz_iw9_delta_infil_plr3_fem_sh030"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_ad0bcac98781e0ab(animstruct.playertags[3], level.br_anim["wz_iw9_delta_infil_plr4_sh030"], level.br_anim["wz_iw9_delta_infil_plr4_fem_sh030"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_ad0bcac98781e0ab(animstruct.playertags[4], level.br_anim["wz_iw9_delta_infil_s6_plr1_sh030_solo"], level.br_anim["wz_iw9_delta_infil_s6_plr1_fem_sh030_solo"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_f7fc8b110c478968(animstruct.playermodels[0], level.br_anim["wz_iw9_delta_infil_s6_plr1_sh030"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_f7fc8b110c478968(animstruct.playermodels[1], level.br_anim["wz_iw9_delta_infil_plr2_sh030"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_f7fc8b110c478968(animstruct.playermodels[2], level.br_anim["wz_iw9_delta_infil_plr3_sh030"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_f7fc8b110c478968(animstruct.playermodels[3], level.br_anim["wz_iw9_delta_infil_plr4_sh030"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_f7fc8b110c478968(animstruct.playermodels[4], level.br_anim["wz_iw9_delta_infil_s6_plr1_sh030"]);
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_modelanim(animstruct.crates[0], level.br_anim["wz_iw9_delta_infil_carepackage1_sh030"]);
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_modelanim(animstruct.npcs[0], level.br_anim["wz_iw9_delta_infil_npc1_sh030"]);
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_modelanim(animstruct.npcs[1], level.br_anim["wz_iw9_delta_infil_npc2_sh030"]);
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_modelanim(animstruct.npcs[2], level.br_anim["wz_iw9_delta_infil_s6_npc3_sh030"]);
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_modelanim(animstruct.npcs[3], level.br_anim["wz_iw9_delta_infil_s6_zmb01_sh030"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_d4561ab1ba4f5de9(animstruct.camerarunner, "tag_origin", level.br_anim["wz_iw9_delta_infil_s6_g_prop_sh030"], "wz_iw9_delta_infil_s6_xcam_sh030", &scripts\mp\gametypes\br_infils_ac130::getxcamfunc);
  animstruct.packs[n].xcams = ["wz_iw9_delta_infil_s6_xcam_sh030_solo", "wz_iw9_delta_infil_s6_xcam_sh030", "wz_iw9_delta_infil_s6_xcam_sh030", "wz_iw9_delta_infil_s6_xcam_sh030"];
  n++;
  var_e92aed86e7dd8b76 = 20;
  quadsfov = 50;
  var_92c2f39adf1c2e62 = 0;
  animstruct.packs[n] = animstruct namespace_81156089ff1fe819::create_animpack("scene4");
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_startfunc([], &scripts\mp\gametypes\br_infils_ac130::function_a1154be6e3c8a13);
  animstruct.packs[n] scripts\mp\gametypes\br_infils_ac130::function_9afdeab1e38dac18(animstruct, level.br_anim["wz_iw9_delta_infil_cargoplane_sh040"]);
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_modelanim(animstruct.camerarunner, level.br_anim["wz_iw9_delta_infil_s6_g_prop_sh040"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_ad0bcac98781e0ab(animstruct.playertags[0], level.br_anim["wz_iw9_delta_infil_s6_plr1_sh040"], level.br_anim["wz_iw9_delta_infil_s6_plr1_fem_sh040"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_ad0bcac98781e0ab(animstruct.playertags[1], level.br_anim["wz_iw9_delta_infil_plr2_sh040"], level.br_anim["wz_iw9_delta_infil_plr2_fem_sh040"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_ad0bcac98781e0ab(animstruct.playertags[2], level.br_anim["wz_iw9_delta_infil_plr3_sh040"], level.br_anim["wz_iw9_delta_infil_plr3_fem_sh040"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_ad0bcac98781e0ab(animstruct.playertags[3], level.br_anim["wz_iw9_delta_infil_plr4_sh040"], level.br_anim["wz_iw9_delta_infil_plr4_fem_sh040"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_ad0bcac98781e0ab(animstruct.playertags[4], level.br_anim["wz_iw9_delta_infil_s6_plr1_sh040_solo"], level.br_anim["wz_iw9_delta_infil_s6_plr1_fem_sh040_solo"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_f7fc8b110c478968(animstruct.playermodels[0], level.br_anim["wz_iw9_delta_infil_s6_plr1_sh040"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_f7fc8b110c478968(animstruct.playermodels[1], level.br_anim["wz_iw9_delta_infil_plr2_sh040"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_f7fc8b110c478968(animstruct.playermodels[2], level.br_anim["wz_iw9_delta_infil_plr3_sh040"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_f7fc8b110c478968(animstruct.playermodels[3], level.br_anim["wz_iw9_delta_infil_plr4_sh040"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_f7fc8b110c478968(animstruct.playermodels[4], level.br_anim["wz_iw9_delta_infil_s6_plr1_sh040"]);
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_modelanim(animstruct.crates[0], level.br_anim["wz_iw9_delta_infil_carepackage1_sh040"]);
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_modelanim(animstruct.npcs[0], level.br_anim["wz_iw9_delta_infil_npc1_sh040"]);
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_modelanim(animstruct.npcs[1], level.br_anim["wz_iw9_delta_infil_npc2_sh040"]);
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_modelanim(animstruct.npcs[2], level.br_anim["wz_iw9_delta_infil_s6_npc3_sh040"]);
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_modelanim(animstruct.npcs[3], level.br_anim["wz_iw9_delta_infil_s6_zmb01_sh040"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_d4561ab1ba4f5de9(animstruct.camerarunner, "tag_origin", level.br_anim["wz_iw9_delta_infil_s6_g_prop_sh040"], "wz_iw9_delta_infil_s6_xcam_sh040", &scripts\mp\gametypes\br_infils_ac130::getxcamfunc);
  animstruct.packs[n].xcams = ["wz_iw9_delta_infil_s6_xcam_sh040_solo", "wz_iw9_delta_infil_s6_xcam_sh040", "wz_iw9_delta_infil_s6_xcam_sh040", "wz_iw9_delta_infil_s6_xcam_sh040"];
  n++;
  var_e92aed86e7dd8b76 = 30;
  quadsfov = 50;
  var_92c2f39adf1c2e62 = 0;
  animstruct.packs[n] = animstruct namespace_81156089ff1fe819::create_animpack("scene5");
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_startfunc([], &scripts\mp\gametypes\br_infils_ac130::function_5252a2070a63d534);
  animstruct.packs[n] scripts\mp\gametypes\br_infils_ac130::function_9afdeab1e38dac18(animstruct, level.br_anim["wz_iw9_delta_infil_cargoplane_sh050"]);
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_modelanim(animstruct.camerarunner, level.br_anim["wz_iw9_delta_infil_s6_g_prop_sh050"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_ad0bcac98781e0ab(animstruct.playertags[0], level.br_anim["wz_iw9_delta_infil_s6_plr1_sh050"], level.br_anim["wz_iw9_delta_infil_s6_plr1_fem_sh050"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_ad0bcac98781e0ab(animstruct.playertags[1], level.br_anim["wz_iw9_delta_infil_plr2_sh050"], level.br_anim["wz_iw9_delta_infil_plr2_fem_sh050"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_ad0bcac98781e0ab(animstruct.playertags[2], level.br_anim["wz_iw9_delta_infil_plr3_sh050"], level.br_anim["wz_iw9_delta_infil_plr3_fem_sh050"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_ad0bcac98781e0ab(animstruct.playertags[3], level.br_anim["wz_iw9_delta_infil_plr4_sh050"], level.br_anim["wz_iw9_delta_infil_plr4_fem_sh050"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_ad0bcac98781e0ab(animstruct.playertags[4], level.br_anim["wz_iw9_delta_infil_s6_plr1_sh050_solo"], level.br_anim["wz_iw9_delta_infil_s6_plr1_fem_sh050_solo"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_f7fc8b110c478968(animstruct.playermodels[0], level.br_anim["wz_iw9_delta_infil_s6_plr1_sh050"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_f7fc8b110c478968(animstruct.playermodels[1], level.br_anim["wz_iw9_delta_infil_plr2_sh050"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_f7fc8b110c478968(animstruct.playermodels[2], level.br_anim["wz_iw9_delta_infil_plr3_sh050"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_f7fc8b110c478968(animstruct.playermodels[3], level.br_anim["wz_iw9_delta_infil_plr4_sh050"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_f7fc8b110c478968(animstruct.playermodels[4], level.br_anim["wz_iw9_delta_infil_s6_plr1_sh050"]);
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_modelanim(animstruct.crates[0], level.br_anim["wz_iw9_delta_infil_carepackage1_sh050"]);
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_modelanim(animstruct.npcs[0], level.br_anim["wz_iw9_delta_infil_npc1_sh050"]);
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_modelanim(animstruct.npcs[1], level.br_anim["wz_iw9_delta_infil_npc2_sh050"]);
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_modelanim(animstruct.npcs[2], level.br_anim["wz_iw9_delta_infil_s6_npc3_sh050"]);
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_modelanim(animstruct.npcs[3], level.br_anim["wz_iw9_delta_infil_s6_zmb01_sh050"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_d4561ab1ba4f5de9(animstruct.camerarunner, "tag_origin", level.br_anim["wz_iw9_delta_infil_s6_g_prop_sh050"], "wz_iw9_delta_infil_s6_xcam_sh050", &scripts\mp\gametypes\br_infils_ac130::getxcamfunc);
  animstruct.packs[n].xcams = ["wz_iw9_delta_infil_s6_xcam_sh050_solo", "wz_iw9_delta_infil_s6_xcam_sh050_duo", "wz_iw9_delta_infil_s6_xcam_sh050", "wz_iw9_delta_infil_s6_xcam_sh050"];
  n++;
  var_e92aed86e7dd8b76 = 25;
  quadsfov = 31.78;
  var_92c2f39adf1c2e62 = 0;
  animstruct.packs[n] = animstruct namespace_81156089ff1fe819::create_animpack("scene6");
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_startfunc([], &function_11443a29bf9747a3);
  animstruct.packs[n] scripts\mp\gametypes\br_infils_ac130::function_9afdeab1e38dac18(animstruct, level.br_anim["wz_iw9_delta_infil_cargoplane_sh060"]);
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_modelanim(animstruct.camerarunner, level.br_anim["wz_iw9_delta_infil_s6_g_prop_sh060"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_ad0bcac98781e0ab(animstruct.playertags[0], level.br_anim["wz_iw9_delta_infil_s6_plr1_sh060"], level.br_anim["wz_iw9_delta_infil_s6_plr1_fem_sh060"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_ad0bcac98781e0ab(animstruct.playertags[1], level.br_anim["wz_iw9_delta_infil_plr2_sh060"], level.br_anim["wz_iw9_delta_infil_plr2_fem_sh060"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_ad0bcac98781e0ab(animstruct.playertags[2], level.br_anim["wz_iw9_delta_infil_plr3_sh060"], level.br_anim["wz_iw9_delta_infil_plr3_fem_sh060"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_ad0bcac98781e0ab(animstruct.playertags[3], level.br_anim["wz_iw9_delta_infil_plr4_sh060"], level.br_anim["wz_iw9_delta_infil_plr4_fem_sh060"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_ad0bcac98781e0ab(animstruct.playertags[4], level.br_anim["wz_iw9_delta_infil_s6_plr1_sh060_solo"], level.br_anim["wz_iw9_delta_infil_s6_plr1_fem_sh060_solo"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_f7fc8b110c478968(animstruct.playermodels[0], level.br_anim["wz_iw9_delta_infil_s6_plr1_sh060"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_f7fc8b110c478968(animstruct.playermodels[1], level.br_anim["wz_iw9_delta_infil_plr2_sh060"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_f7fc8b110c478968(animstruct.playermodels[2], level.br_anim["wz_iw9_delta_infil_plr3_sh060"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_f7fc8b110c478968(animstruct.playermodels[3], level.br_anim["wz_iw9_delta_infil_plr4_sh060"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_f7fc8b110c478968(animstruct.playermodels[4], level.br_anim["wz_iw9_delta_infil_s6_plr1_sh060"]);
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_modelanim(animstruct.crates[0], level.br_anim["wz_iw9_delta_infil_carepackage1_sh060"]);
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_modelanim(animstruct.npcs[0], level.br_anim["wz_iw9_delta_infil_npc1_sh060"]);
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_modelanim(animstruct.npcs[1], level.br_anim["wz_iw9_delta_infil_npc2_sh060"]);
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_modelanim(animstruct.npcs[2], level.br_anim["wz_iw9_delta_infil_s6_npc3_sh060"]);
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_modelanim(animstruct.npcs[3], level.br_anim["wz_iw9_delta_infil_s6_zmb01_sh060"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_d4561ab1ba4f5de9(animstruct.camerarunner, "tag_origin", level.br_anim["wz_iw9_delta_infil_s6_g_prop_sh060"], "wz_iw9_delta_infil_s6_xcam_sh060", &scripts\mp\gametypes\br_infils_ac130::getxcamfunc);
  animstruct.packs[n].xcams = ["wz_iw9_delta_infil_s6_xcam_sh060_solo", "wz_iw9_delta_infil_s6_xcam_sh060", "wz_iw9_delta_infil_s6_xcam_sh060", "wz_iw9_delta_infil_s6_xcam_sh060"];
  n++;
  var_e92aed86e7dd8b76 = 20;
  quadsfov = 17.847;
  var_92c2f39adf1c2e62 = 0;
  animstruct.packs[n] = animstruct namespace_81156089ff1fe819::create_animpack("scene7");
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_startfunc([], &scripts\mp\gametypes\br_infils_ac130::function_2391d520e79f9862);
  animstruct.packs[n] scripts\mp\gametypes\br_infils_ac130::function_9afdeab1e38dac18(animstruct, level.br_anim["wz_iw9_delta_infil_cargoplane_sh070"]);
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_modelanim(animstruct.camerarunner, level.br_anim["wz_iw9_delta_infil_s6_g_prop_sh070"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_ad0bcac98781e0ab(animstruct.playertags[0], level.br_anim["wz_iw9_delta_infil_s6_plr1_sh070"], level.br_anim["wz_iw9_delta_infil_s6_plr1_fem_sh070"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_ad0bcac98781e0ab(animstruct.playertags[1], level.br_anim["wz_iw9_delta_infil_plr2_sh070"], level.br_anim["wz_iw9_delta_infil_plr2_fem_sh070"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_ad0bcac98781e0ab(animstruct.playertags[2], level.br_anim["wz_iw9_delta_infil_plr3_sh070"], level.br_anim["wz_iw9_delta_infil_plr3_fem_sh070"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_ad0bcac98781e0ab(animstruct.playertags[3], level.br_anim["wz_iw9_delta_infil_plr4_sh070"], level.br_anim["wz_iw9_delta_infil_plr4_fem_sh070"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_ad0bcac98781e0ab(animstruct.playertags[4], level.br_anim["wz_iw9_delta_infil_s6_plr1_sh070_solo"], level.br_anim["wz_iw9_delta_infil_s6_plr1_fem_sh070_solo"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_f7fc8b110c478968(animstruct.playermodels[0], level.br_anim["wz_iw9_delta_infil_s6_plr1_sh070"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_f7fc8b110c478968(animstruct.playermodels[1], level.br_anim["wz_iw9_delta_infil_plr2_sh070"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_f7fc8b110c478968(animstruct.playermodels[2], level.br_anim["wz_iw9_delta_infil_plr3_sh070"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_f7fc8b110c478968(animstruct.playermodels[3], level.br_anim["wz_iw9_delta_infil_plr4_sh070"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_f7fc8b110c478968(animstruct.playermodels[4], level.br_anim["wz_iw9_delta_infil_s6_plr1_sh070"]);
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_modelanim(animstruct.crates[0], level.br_anim["wz_iw9_delta_infil_carepackage1_sh070"]);
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_modelanim(animstruct.npcs[0], level.br_anim["wz_iw9_delta_infil_npc1_sh070"]);
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_modelanim(animstruct.npcs[1], level.br_anim["wz_iw9_delta_infil_npc2_sh070"]);
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_modelanim(animstruct.npcs[2], level.br_anim["wz_iw9_delta_infil_s6_npc3_sh070"]);
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_modelanim(animstruct.npcs[3], level.br_anim["wz_iw9_delta_infil_s6_zmb01_sh070"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_d4561ab1ba4f5de9(animstruct.camerarunner, "tag_origin", level.br_anim["wz_iw9_delta_infil_s6_g_prop_sh070"], "wz_iw9_delta_infil_s6_xcam_sh070", &scripts\mp\gametypes\br_infils_ac130::getxcamfunc);
  animstruct.packs[n].xcams = ["wz_iw9_delta_infil_s6_xcam_sh070_solo", "wz_iw9_delta_infil_s6_xcam_sh070", "wz_iw9_delta_infil_s6_xcam_sh070", "wz_iw9_delta_infil_s6_xcam_sh070"];
  n++;
  var_e92aed86e7dd8b76 = 40;
  quadsfov = 40;
  var_92c2f39adf1c2e62 = 0;
  animstruct.packs[n] = animstruct namespace_81156089ff1fe819::create_animpack("scene8");
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_startfunc([], &function_d382f3be22ca54c9);
  animstruct.packs[n] scripts\mp\gametypes\br_infils_ac130::function_9afdeab1e38dac18(animstruct, level.br_anim["wz_iw9_delta_infil_cargoplane_sh080"]);
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_modelanim(animstruct.camerarunner, level.br_anim["wz_iw9_delta_infil_s6_g_prop_sh080"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_ad0bcac98781e0ab(animstruct.playertags[0], level.br_anim["wz_iw9_delta_infil_s6_plr1_sh080"], level.br_anim["wz_iw9_delta_infil_s6_plr1_fem_sh080"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_ad0bcac98781e0ab(animstruct.playertags[1], level.br_anim["wz_iw9_delta_infil_plr2_sh080"], level.br_anim["wz_iw9_delta_infil_plr2_fem_sh080"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_ad0bcac98781e0ab(animstruct.playertags[2], level.br_anim["wz_iw9_delta_infil_plr3_sh080"], level.br_anim["wz_iw9_delta_infil_plr3_fem_sh080"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_ad0bcac98781e0ab(animstruct.playertags[3], level.br_anim["wz_iw9_delta_infil_plr4_sh080"], level.br_anim["wz_iw9_delta_infil_plr4_fem_sh080"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_ad0bcac98781e0ab(animstruct.playertags[4], level.br_anim["wz_iw9_delta_infil_s6_plr1_sh080_solo"], level.br_anim["wz_iw9_delta_infil_s6_plr1_fem_sh080_solo"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_f7fc8b110c478968(animstruct.playermodels[0], level.br_anim["wz_iw9_delta_infil_s6_plr1_sh080"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_f7fc8b110c478968(animstruct.playermodels[1], level.br_anim["wz_iw9_delta_infil_plr2_sh080"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_f7fc8b110c478968(animstruct.playermodels[2], level.br_anim["wz_iw9_delta_infil_plr3_sh080"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_f7fc8b110c478968(animstruct.playermodels[3], level.br_anim["wz_iw9_delta_infil_plr4_sh080"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_f7fc8b110c478968(animstruct.playermodels[4], level.br_anim["wz_iw9_delta_infil_s6_plr1_sh080"]);
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_modelanim(animstruct.crates[0], level.br_anim["wz_iw9_delta_infil_carepackage1_sh080"]);
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_modelanim(animstruct.npcs[0], level.br_anim["wz_iw9_delta_infil_npc1_sh080"]);
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_modelanim(animstruct.npcs[1], level.br_anim["wz_iw9_delta_infil_npc2_sh080"]);
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_modelanim(animstruct.npcs[2], level.br_anim["wz_iw9_delta_infil_s6_npc3_sh080"]);
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_modelanim(animstruct.npcs[3], level.br_anim["wz_iw9_delta_infil_s6_zmb01_sh080"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_d4561ab1ba4f5de9(animstruct.camerarunner, "tag_origin", level.br_anim["wz_iw9_delta_infil_s6_g_prop_sh080"], "wz_iw9_delta_infil_s6_xcam_sh080", &scripts\mp\gametypes\br_infils_ac130::getxcamfunc);
  animstruct.packs[n].xcams = ["wz_iw9_delta_infil_s6_xcam_sh080_solo", "wz_iw9_delta_infil_s6_xcam_sh080", "wz_iw9_delta_infil_s6_xcam_sh080", "wz_iw9_delta_infil_s6_xcam_sh080"];
  var_e92aed86e7dd8b76 = 65;
  quadsfov = 65;
  var_92c2f39adf1c2e62 = 0;
  n++;
  animstruct.packs[n] = animstruct namespace_81156089ff1fe819::create_animpack("looping", 1);
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_startfunc([var_e92aed86e7dd8b76, quadsfov], &function_1cbe02f23f2a6ff);
  animstruct.packs[n] namespace_81156089ff1fe819::function_e718ba63d511fcde([], &function_b1c2078eae3653b0);
  animstruct.packs[n] scripts\mp\gametypes\br_infils_ac130::function_9afdeab1e38dac18(animstruct, level.br_anim["wz_iw9_delta_infil_s6_cargoplane_sh080_idle"]);
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_modelanim(animstruct.camerarunner, level.br_anim["wz_iw9_delta_infil_s6_g_prop_sh080_idle"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_ad0bcac98781e0ab(animstruct.playertags[0], level.br_anim["wz_infil_drone_guy1_idle_sh010"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_ad0bcac98781e0ab(animstruct.playertags[1], level.br_anim["wz_infil_drone_guy2_idle_sh010"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_ad0bcac98781e0ab(animstruct.playertags[2], level.br_anim["wz_infil_drone_guy3_idle_sh010"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_ad0bcac98781e0ab(animstruct.playertags[3], level.br_anim["wz_infil_drone_guy4_idle_sh010"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_ad0bcac98781e0ab(animstruct.playertags[4], level.br_anim["wz_infil_drone_guy1_idle_sh010"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_f7fc8b110c478968(animstruct.playermodels[0], level.br_anim["wz_infil_drone_guy1_idle_sh010"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_f7fc8b110c478968(animstruct.playermodels[1], level.br_anim["wz_infil_drone_guy2_idle_sh010"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_f7fc8b110c478968(animstruct.playermodels[2], level.br_anim["wz_infil_drone_guy3_idle_sh010"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_f7fc8b110c478968(animstruct.playermodels[3], level.br_anim["wz_infil_drone_guy4_idle_sh010"]);
  animstruct.packs[n] namespace_81156089ff1fe819::function_f7fc8b110c478968(animstruct.playermodels[4], level.br_anim["wz_infil_drone_guy1_idle_sh010"]);
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_modelanim(animstruct.npcs[0], level.br_anim["wz_infil_drone_guy_npc1idle_sh010"]);
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_modelanim(animstruct.npcs[1], level.br_anim["wz_infil_drone_guy_npc2idle_sh010"]);
  animstruct.packs[n] namespace_81156089ff1fe819::add_pack_modelanim(animstruct.npcs[2], level.br_anim["wz_infil_drone_guy_npc3idle_sh010"]);

  foreach(var_70d30bdf11e3ec9b in animstruct.var_410039458420238) {
    animstruct.packs[n] namespace_81156089ff1fe819::add_pack_modelanim(var_70d30bdf11e3ec9b.gprop, level.br_anim[var_70d30bdf11e3ec9b.var_e39ca5de2ca93ab5]);

    foreach(zombie in var_70d30bdf11e3ec9b.zombies) {
      animstruct.packs[n] namespace_81156089ff1fe819::add_pack_modelanim(zombie.model, level.br_anim[zombie.var_e39ca5de2ca93ab5]);
    }
  }

  animstruct.packs[n] namespace_81156089ff1fe819::function_d4561ab1ba4f5de9(animstruct.camerarunner, &scripts\mp\gametypes\br_infils_ac130::function_e128261218fafdaa);
  return animstruct;
}

function function_1cbe02f23f2a6ff(array) {
  scripts\mp\gametypes\br_infils_ac130::function_f3ae4b41df047ba0(array);
  thread function_34550133036807f8();
}

function function_34550133036807f8() {
  wait 15;
  self.var_225add0764cabce2.zombies[4].model hide();
  wait 7;
  self.var_225add0764cabce2.zombies[8].model hide();
}

function function_b1c2078eae3653b0(player, array) {}

function function_9638397bb7d4e928(array) {
  scripts\mp\gametypes\br_infils_ac130::function_baf143dbadb3f80(array);

  foreach(player in level.infilstruct.players) {
    if(!isDefined(player)) {
      continue;
    }

    if(player.infilanimindex == 1 || player.infilanimindex == 5 || player.infilanimindex == 2) {
      weapon_obj = scripts\cp_mp\weapon::buildweapon("iw9_pi_golf17_mp");
      player scripts\cp_mp\utility\inventory_utility::_giveweapon(weapon_obj);
      player scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(weapon_obj);
      player allowfire(0);
      player disableweaponswitch();
      player.var_3da7f09bd592bd53 = weapon_obj;
    }
  }
}

function function_11443a29bf9747a3(array) {
  scripts\mp\gametypes\br_infils_ac130::function_9cfd7cab1a6e747b(array);
}

function function_d382f3be22ca54c9(array) {
  scripts\mp\gametypes\br_infils_ac130::function_f3ae4b41df047ba0(array);
  level thread scripts\mp\gametypes\br_infils_ac130::function_d231ca558e0ab75d();
  level thread function_3681196cfc0b8f3a();
  delayseconds = getdvarfloat(@ "hash_1968fc42f31e7d28", 3.6);

  if(delayseconds > 0) {
    scripts\engine\utility::delaythread(delayseconds, &scripts\mp\gametypes\br_infils_ac130::teleporttomovingplane);
    scripts\engine\utility::delaythread(delayseconds, &function_8da7d1f262e22981);
  } else {
    scripts\mp\gametypes\br_infils_ac130::teleporttomovingplane();
    function_8da7d1f262e22981();
  }

  level thread function_9cdb9af6897c35d9();
  var_2995a4f619ed836f = ter_op(scripts\cp_mp\utility\game_utility::isnightmap(), "running_lights_pm", "running_lights");
  self.movingc130 setscriptablepartstate(var_2995a4f619ed836f, "on");
  scripts\mp\gametypes\br_public::brleaderdialog("infil_ac130_5_seconds", 0, undefined, 1, 0, undefined, level.brgametype.dialogprefix);
}

function function_3681196cfc0b8f3a() {
  delayseconds = 3.6;
  transitionseconds = 1;

  if(delayseconds > 0) {
    wait delayseconds;
  }

  var_2a5e082b65f82a5c = getdvarint(@ "hash_7f1da0c3501cbdf2", 1);

  foreach(player in level.infilstruct.players) {
    if(!isDefined(player)) {
      continue;
    }

    player visionsetnakedforplayer("", transitionseconds);

    if(var_2a5e082b65f82a5c) {
      if(isDefined(level.var_46cfc90c68413ca8)) {
        player function_df8fad503896462(%"hash_1249abd27675ff");
        continue;
      }

      player function_df8fad503896462(%"hash_1fae1fa57c3e3922");
    }
  }

  scripts\engine\utility::delaythread(1, &scripts\mp\gametypes\br_infils_ac130::function_f23edad7e7a000c5);
  namespace_81156089ff1fe819::function_6199c35f4cf4524c(&scripts\mp\gametypes\br_infils_ac130::function_161da87df4150ee8);
}

function function_9cdb9af6897c35d9() {
  fadestarttime = scripts\engine\utility::get_notetrack_time(level.br_anim["wz_iw9_delta_infil_s6_g_prop_sh080"], "fade_to_black_start");
  fadeendtime = scripts\engine\utility::get_notetrack_time(level.br_anim["wz_iw9_delta_infil_s6_g_prop_sh080"], "fade_to_black_end");
  fadestarttime -= scripts\engine\utility::mod(fadestarttime, 0.05);
  fadeendtime += 0.05 - scripts\engine\utility::mod(fadeendtime, 0.05);
  wait fadestarttime;
  namespace_81156089ff1fe819::function_ea856ec0b3c4cfc6(0.066, level.infilstruct.players, "sh120");
  wait fadeendtime - fadestarttime;
  namespace_81156089ff1fe819::function_7f3ad8fe6df1b8fe(0.083, level.infilstruct.players, "sh120");
}

function function_8da7d1f262e22981() {
  foreach(player in level.infilstruct.players) {
    if(!isDefined(player)) {
      continue;
    }

    if(player.infilanimindex == 1 || player.infilanimindex == 5 || player.infilanimindex == 2) {
      if(isDefined(player.var_3da7f09bd592bd53)) {
        player scripts\cp_mp\utility\inventory_utility::_takeweapon(player.var_3da7f09bd592bd53);
      }

      player allowfire(1);
      player enableweaponswitch();
    }
  }
}

function function_3847ee6a388d287a(numplayers, var_92c2f39adf1c2e62) {
  possibleindices = [1, 2, 3, 4];

  if(numplayers == 1) {
    possibleindices = [5];
  } else if(numplayers == 2) {
    if(var_92c2f39adf1c2e62) {
      possibleindices = [5, 2];
    } else {
      possibleindices = [1, 2];
    }
  } else if(var_92c2f39adf1c2e62 && numplayers == 3) {
    possibleindices = [5, 2, 3, 4];
  }

  return possibleindices;
}

function function_d504b15d94a33dd3(animname, var_e39ca5de2ca93ab5, var_70d30bdf11e3ec9b, var_d15a8cfc621e1b14) {
  assertex(isDefined(var_70d30bdf11e3ec9b), "<dev string:x1c>");
  assertex(isDefined(var_d15a8cfc621e1b14), "<dev string:x3c>");
  assertex(isDefined(animname), "<dev string:x65>");
  assertex(isDefined(var_e39ca5de2ca93ab5), "<dev string:x87>");

  if(!isDefined(var_70d30bdf11e3ec9b.zombies)) {
    var_70d30bdf11e3ec9b.zombies = [];
  }

  var_254c6f127c194157 = spawnStruct();
  var_254c6f127c194157.model = namespace_81156089ff1fe819::spawn_script_model("fullbody_zombie_a_br", "zombie" + animname);
  var_254c6f127c194157.model linkTo(var_70d30bdf11e3ec9b.gprop, var_d15a8cfc621e1b14, (0, 0, 0), (0, 0, 0));
  var_254c6f127c194157.animname = animname;
  var_254c6f127c194157.var_e39ca5de2ca93ab5 = var_e39ca5de2ca93ab5;
  var_70d30bdf11e3ec9b.zombies[var_70d30bdf11e3ec9b.zombies.size] = var_254c6f127c194157;
  return var_254c6f127c194157;
}

function function_f9c90bddfe9edeb(animname, var_e39ca5de2ca93ab5, var_d15a8cfc621e1b14) {
  assertex(isDefined(var_d15a8cfc621e1b14), "<dev string:xad>");

  if(!isDefined(self.var_410039458420238)) {
    self.var_410039458420238 = [];
  }

  var_b385a00765af5a67 = spawnStruct();
  var_b385a00765af5a67.gprop = namespace_81156089ff1fe819::spawn_script_model("generic_prop_x10", "cluster" + var_d15a8cfc621e1b14);
  var_b385a00765af5a67.gprop linkTo(self.camerarunner, var_d15a8cfc621e1b14, (0, 0, 0), (0, 0, 0));
  var_b385a00765af5a67.animname = animname;
  var_b385a00765af5a67.var_e39ca5de2ca93ab5 = var_e39ca5de2ca93ab5;
  self.var_410039458420238[self.var_410039458420238.size] = var_b385a00765af5a67;
  return var_b385a00765af5a67;
}