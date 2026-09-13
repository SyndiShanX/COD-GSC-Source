/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\aitypes\assets.gsc
***********************************************/

main() {}

soldier() {
  if(!_id_FCA40A005D4059D6("soldier")) {
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
    _id_89BD0A0F1B23FE8D("soldier");
  }
}

civilian() {}

dog() {}

juggernaut() {
  if(!_id_FCA40A005D4059D6("juggernaut")) {
    if(!isDefined(level.g_effect))
      level.g_effect = [];

    level._effect["npc_flashlight"] = loadfx("vfx/iw9/core/flashlight/vfx_flashlight_npc_nolight.vfx");
    level._effect["npc_flashlight_flare"] = loadfx("vfx/iw9/core/flashlight/vfx_flashlight_npc.vfx");
    level._effect["crawling_death_blood_smear"] = loadfx("vfx/core/impacts/blood_smear_decal.vfx");
    _id_89BD0A0F1B23FE8D("juggernaut");
  }
}

suicidebomber() {
  if(!_id_FCA40A005D4059D6("suicidebomber")) {
    precachemodel("offhand_wm_clacker");

    if(isdismembermentenabled())
      level.g_effect["vfx_suicide_bomber_gib_explode"] = loadfx("vfx/iw8/weap/_explo/suicide/vfx_explo_suicide_bomb.vfx");
    else
      level.g_effect["vfx_suicide_bomber_gib_explode"] = loadfx("vfx/core/blank.vfx");

    level.g_effect["vfx_suicide_bomber_no_dismember"] = loadfx("vfx/iw8/weap/_explo/vfx_explo_frag_gren.vfx");
    level._effect["suicide_bomber_clicker_flash"] = loadfx("vfx/_requests/piccadilly/vfx_suicide_bomber_clicker_flash.vfx");
    _id_89BD0A0F1B23FE8D("suicidebomber");
  }
}

zombie() {}

_id_89BD0A0F1B23FE8D(type) {
  if(!isDefined(level._id_7D310F9C5A785DCB))
    level._id_7D310F9C5A785DCB = [];

  switch (type) {
    case "juggernaut":
    case "soldier":
    case "suicidebomber":
      _id_7D79A3FA97A020CC();
      break;
    default:
  }

  level._id_7D310F9C5A785DCB[type] = 1;
}

_id_FCA40A005D4059D6(type) {
  return isDefined(level._id_7D310F9C5A785DCB) && istrue(level._id_7D310F9C5A785DCB[type]);
}

_id_7D79A3FA97A020CC() {
  if(isDefined(level.g_effect["human_gib_fullbody"])) {
    return;
  }
  if(isdismembermentenabled()) {
    level.g_effect["human_gib_fullbody"] = loadfx("vfx/iw8/weap/_explo/suicide/vfx_gib_dir1.vfx");
    level.g_effect["human_gib_head"] = loadfx("vfx/iw8/weap/_impact/flesh/vfx_imp_flesh_fatal_head_med_dismb.vfx");
    level.g_effect["human_gib_head_cap"] = loadfx("vfx/iw8/weap/_impact/flesh/vfx_dismemberment_head_cap.vfx");
  } else {
    level.g_effect["human_gib_fullbody"] = loadfx("vfx/core/blank.vfx");
    level.g_effect["human_gib_head"] = loadfx("vfx/core/blank.vfx");
    level.g_effect["human_gib_head_cap"] = loadfx("vfx/core/blank.vfx");
  }
}