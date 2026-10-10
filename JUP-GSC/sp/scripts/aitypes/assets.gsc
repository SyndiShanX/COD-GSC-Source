/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\aitypes\assets.gsc
***********************************************/

#using scripts\aitypes\bt_util;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace assets;

function main() {}

function soldier() {
  if(!function_fca40a005d4059d6("soldier")) {
    level._effect["npc_flashlight"] = loadfx("vfx/iw9/core/flashlight/vfx_flashlight_npc_nolight.vfx");
    level._effect["npc_flashlight_flare"] = loadfx("vfx/iw9/core/flashlight/vfx_flashlight_npc.vfx");
    precachemodel("attachment_wm_tac_light_held");
    precachemodel("offhand_wm_smartphone_on");
    precachemodel("p7_bottle_plastic_16oz_water");
    precachemodel("cp_disco_folding_chair_lod0");
    precachemodel("weapon_wm_pi_mike1911_phys");
    precachemodel("misc_cigarette_01_centered");
    precachemodel("misc_wm_blackbox_laptop");
    level.g_effect["cellphone_glow"] = loadfx("vfx/iw7/levels/piccadilly/vfx_pic_phone_light_01.vfx");
    level.g_effect["cigarette_lit"] = loadfx("vfx/iw8/char/cigarette/vfx_cigarette_lit_hand_01.vfx");
    level.g_effect["cigarette_lit_toss"] = loadfx("vfx/iw8/char/cigarette/vfx_cigarette_lit_hand_01_toss.vfx");
    level.g_effect["cigarette_unlit"] = loadfx("vfx/iw8/char/cigarette/vfx_cigarette_unlit_hand_01.vfx");
    level.g_effect["lighter_glow"] = loadfx("vfx/iw8/char/cigarette/vfx_cigarette_lighter_glow_hand_01.vfx");
    level.g_effect["cigarette_smoke"] = loadfx("vfx/iw8/char/cigarette/vfx_cigarette_smk_blow_01.vfx");
    level._effect["crawling_death_blood_smear"] = loadfx("vfx/core/impacts/blood_smear_decal.vfx");
    function_89bd0a0f1b23fe8d("soldier");
  }
}

function civilian() {}

function dog() {}

function juggernaut() {
  if(!function_fca40a005d4059d6("juggernaut")) {
    if(!isDefined(level.g_effect)) {
      level.g_effect = [];
    }

    level._effect["npc_flashlight"] = loadfx("vfx/iw9/core/flashlight/vfx_flashlight_npc_nolight.vfx");
    level._effect["npc_flashlight_flare"] = loadfx("vfx/iw9/core/flashlight/vfx_flashlight_npc.vfx");
    level._effect["crawling_death_blood_smear"] = loadfx("vfx/core/impacts/blood_smear_decal.vfx");
    function_89bd0a0f1b23fe8d("juggernaut");
  }
}

function suicidebomber() {
  if(!function_fca40a005d4059d6("suicidebomber")) {
    precachemodel("offhand_wm_clacker");

    if(isdismembermentenabled()) {
      level.g_effect["vfx_suicide_bomber_gib_explode"] = loadfx("vfx/iw8/weap/_explo/suicide/vfx_explo_suicide_bomb.vfx");
    } else {
      level.g_effect["vfx_suicide_bomber_gib_explode"] = loadfx("vfx/core/blank.vfx");
    }

    level.g_effect["vfx_suicide_bomber_no_dismember"] = loadfx("vfx/iw8/weap/_explo/vfx_explo_frag_gren.vfx");
    level._effect["suicide_bomber_clicker_flash"] = loadfx("vfx/_requests/piccadilly/vfx_suicide_bomber_clicker_flash.vfx");
    function_89bd0a0f1b23fe8d("suicidebomber");
  }
}

function zombie() {
  if(!function_fca40a005d4059d6("zombie")) {
    function_89bd0a0f1b23fe8d("zombie");
  }
}

function function_89bd0a0f1b23fe8d(type) {
  if(!isDefined(level.var_7d310f9c5a785dcb)) {
    level.var_7d310f9c5a785dcb = [];
  }

  switch (type) {
    case #"hash_1403dfb5d1265ddc":
    case #"hash_44aaeb0edd152195":
    case #"hash_4ad475e6e15635bd":
      function_7d79a3fa97a020cc();
      break;
    default:
      break;
  }

  level.var_7d310f9c5a785dcb[type] = 1;
}

function function_fca40a005d4059d6(type) {
  return isDefined(level.var_7d310f9c5a785dcb) && istrue(level.var_7d310f9c5a785dcb[type]);
}

function function_7d79a3fa97a020cc() {
  if(isDefined(level.g_effect) && isDefined(level.g_effect["human_gib_fullbody"])) {
    return;
  }

  if(isdismembermentenabled()) {
    level.g_effect["human_gib_fullbody"] = loadfx("vfx/iw8/weap/_explo/suicide/vfx_gib_dir1.vfx");
    level.g_effect["human_gib_head"] = loadfx("vfx/iw8/weap/_impact/flesh/vfx_imp_flesh_fatal_head_med_dismb.vfx");
    level.g_effect["human_gib_head_cap"] = loadfx("vfx/iw8/weap/_impact/flesh/vfx_dismemberment_head_cap.vfx");
    return;
  }

  level.g_effect["human_gib_fullbody"] = loadfx("vfx/core/blank.vfx");
  level.g_effect["human_gib_head"] = loadfx("vfx/core/blank.vfx");
  level.g_effect["human_gib_head_cap"] = loadfx("vfx/core/blank.vfx");
}