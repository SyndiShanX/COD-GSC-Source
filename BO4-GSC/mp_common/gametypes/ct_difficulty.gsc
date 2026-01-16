/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\ct_difficulty.gsc
*************************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\player\player_role;
#include scripts\core_common\potm_shared;
#include scripts\core_common\struct;
#include scripts\core_common\values_shared;
#include scripts\mp_common\gametypes\ct_bots;
#include scripts\mp_common\gametypes\ct_ui;
#include scripts\mp_common\gametypes\ct_utils;
#include scripts\mp_common\gametypes\globallogic;
#include scripts\mp_common\util;

#namespace ct_difficulty;

function_be562a72() {
  level.ctdifficulty = 0;

  switch (level.ctdifficulty) {
    case 0:
      level.var_90bb9821 = 0;
      level.var_df0a0911 = "bot_tacstate_easy_mp_ct";
      level.var_eea9be19 = 150;
      level.var_1ecfe3a2 = 150;
      level.var_abdff161 = 1;
      level.var_b0436df5 = 2000;
      level.var_30675389 = 3000;
      level.var_39c7b92c = 1;
      break;
    case 1:
      level.var_df0a0911 = "bot_tacstate_easy_mp_ct";
      level.var_eea9be19 = 50;
      level.var_1ecfe3a2 = 250;
      level.var_abdff161 = 1;
      level.var_b0436df5 = 2000;
      level.var_30675389 = 3000;
      level.var_39c7b92c = 1;
      break;
    case 2:
      level.var_df0a0911 = "bot_tacstate_mp_ct";
      level.var_eea9be19 = 100;
      level.var_abdff161 = 0.35;
      level.var_b0436df5 = 500;
      level.var_30675389 = 1000;
      level.var_39c7b92c = 0;
      break;
    case 3:
      level.var_df0a0911 = "bot_tacstate_mp_ct";
      level.var_eea9be19 = 150;
      level.var_abdff161 = 0;
      level.var_b0436df5 = 400;
      level.var_30675389 = 500;
      level.var_39c7b92c = 0;
      break;
  }
}

bot_set_difficulty(var_29e78c21, var_daab64c2, var_de2ce1d3) {
  self.bot.var_b2b8f0b6 = var_29e78c21;
  self.bot.var_e8c941d6 = var_daab64c2;
  self.var_abdff161 = var_de2ce1d3;
}