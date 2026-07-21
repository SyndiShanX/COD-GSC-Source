/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitypes\assets.gsc
***********************************************/

main() {}

soldier() {
  if(!getdvarint("NTMLLPTNLT"))
    level.g_effect["human_gib_fullbody"] = loadfx("vfx/core/blank.vfx");
  else
    level.g_effect["human_gib_fullbody"] = loadfx("vfx/iw8/weap/_explo/suicide/vfx_gib_dir1.vfx");

  level.g_effect["human_gib_head"] = loadfx("vfx/_requests/human/headgib.vfx");
  level.g_effect["sniper_glint"] = loadfx("vfx/misc/scope_glint.vfx");
  level._effect["npc_flashlight"] = loadfx("vfx/iw8/core/light/vfx_flashlight_npc.vfx");
  precachemodel("attachment_wm_tac_light_held");
  precachemodel("offhand_wm_smartphone_on");
  precachemodel("p7_bottle_plastic_16oz_water");
  precachemodel("cp_disco_folding_chair_lod0");
  level.g_effect["cellphone_glow"] = loadfx("vfx/iw7/levels/piccadilly/vfx_pic_phone_light_01.vfx");
  level.g_effect["cigarette_lit"] = loadfx("vfx/iw8/char/cigarette/vfx_cigarette_lit_hand_01.vfx");
  level.g_effect["cigarette_lit_toss"] = loadfx("vfx/iw8/char/cigarette/vfx_cigarette_lit_hand_01_toss.vfx");
  level.g_effect["cigarette_unlit"] = loadfx("vfx/iw8/char/cigarette/vfx_cigarette_unlit_hand_01.vfx");
  level.g_effect["lighter_glow"] = loadfx("vfx/iw8/char/cigarette/vfx_cigarette_lighter_glow_hand_01.vfx");
  level.g_effect["cigarette_smoke"] = loadfx("vfx/iw8/char/cigarette/vfx_cigarette_smk_blow_01.vfx");
  level._effect["crawling_death_blood_smear"] = loadfx("vfx/core/impacts/blood_smear_decal.vfx");
}

civilian() {}

dog() {}

juggernaut() {
  if(!getdvarint("NTMLLPTNLT"))
    level.g_effect["human_gib_fullbody"] = loadfx("vfx/core/blank.vfx");
  else
    level.g_effect["human_gib_fullbody"] = loadfx("vfx/iw8/weap/_explo/suicide/vfx_gib_dir1.vfx");

  level.g_effect["human_gib_head"] = loadfx("vfx/_requests/human/headgib.vfx");
  level.g_effect["sniper_glint"] = loadfx("vfx/misc/scope_glint.vfx");
  level._effect["npc_flashlight"] = loadfx("vfx/iw8/core/light/vfx_flashlight_npc.vfx");
  level._effect["crawling_death_blood_smear"] = loadfx("vfx/core/impacts/blood_smear_decal.vfx");
}

suicidebomber() {
  precachemodel("offhand_wm_clacker");
  level.g_effect["human_gib_fullbody"] = loadfx("vfx/iw8/weap/_explo/suicide/vfx_gib_dir1.vfx");
  level.g_effect["vfx_suicide_bomber_gib_explode"] = loadfx("vfx/iw8/weap/_explo/suicide/vfx_explo_suicide_bomb.vfx");
  level.g_effect["vfx_suicide_bomber_no_dismember"] = loadfx("vfx/iw8/weap/_explo/vfx_explo_frag_gren.vfx");
  level.g_effect["human_gib_head"] = loadfx("vfx/_requests/human/headgib.vfx");
  level._effect["suicide_bomber_clicker_flash"] = loadfx("vfx/_requests/piccadilly/vfx_suicide_bomber_clicker_flash.vfx");
}