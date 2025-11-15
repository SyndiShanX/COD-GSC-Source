/*****************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\mp_vlobby_room_fx.gsc
*****************************************/

main() {
  level._effect["pigeon_flock_vista_loop"] = loadfx("vfx\animal\pigeon_flock_vista_loop");
  level._effect["vlobby_light_red"] = loadfx("vfx\map\mp_vlobby_room\vlobby_light_red");
  level._effect["vlobby_c130_motes"] = loadfx("vfx\map\mp_vlobby_room\vlobby_c130_motes");
  level._effect["crate_dryice_vlobby"] = loadfx("vfx\map\mp_vlobby_room\crate_dryice_vlobby");
  level._effect["mug_steam_vlobby"] = loadfx("vfx\map\mp_vlobby_room\mug_steam_vlobby");
  level._effect["vlobby_c130_dust"] = loadfx("vfx\map\mp_vlobby_room\vlobby_c130_dust");
  level._effect["vlobby_c130_smoke"] = loadfx("vfx\map\mp_vlobby_room\vlobby_c130_smoke");
  level._effect["round_glow_lightbulb"] = loadfx("vfx\map\mp_vlobby_room\round_glow_lightbulb");
  level._effect["ambient_hallway_dust_mp"] = loadfx("vfx\map\mp_citystreets\ambient_hallway_dust_mp");
  level._effect["flight02_spotlight_gobo"] = loadfx("vfx\lights\mp_vlobby_refraction\flight02_spotlight_gobo");
  level._effect["flashlight_spotlight_gobo"] = loadfx("vfx\lights\mp_vlobby_refraction\flashlight_spotlight_gobo");
  level._effect["vlobby_dust"] = loadfx("vfx\map\mp_vlobby_room\vlobby_dust");
  level._effect["vlobby_steam"] = loadfx("vfx\map\mp_vlobby_room\vlobby_steam");
  level._effect["vlobby_front_steam"] = loadfx("vfx\map\mp_vlobby_room\vlobby_front_steam");
  level._effect["vlobby_vista_explosion_runner"] = loadfx("vfx\map\mp_vlobby_room\vlobby_vista_explosion_runner");
  level._effect["paper_falling"] = loadfx("fx\misc\paper_falling_slow");
  level._effect["watermelon"] = loadfx("fx\props\watermelon");
}

loadprecacheddepoteffects() {
  level._effect["cigarette_exhale_vlobby"] = loadfx("vfx\smoke\cigarette_exhale_vlobby");
  level._effect["cigarette_endglow_vlobby"] = loadfx("vfx\smoke\cigarette_endglow_vlobby");
  level._effect["cigarette_flick_trail_vlobby"] = loadfx("vfx\smoke\cigarette_flick_trail_vlobby");
  level._effect["cigarette_ash_vlobby"] = loadfx("vfx\smoke\cigarette_ash_vlobby");
  level._effect["cigarette_smk_vlobby"] = loadfx("vfx\smoke\cigarette_smk_vlobby");
  level._effect["loot_card_trail_common"] = loadfx("vfx\map\mp_vlobby_room\vlobby_common_trail");
  level._effect["loot_card_trail_rare"] = loadfx("vfx\map\mp_vlobby_room\vlobby_rare_trail");
  level._effect["loot_card_trail_legendary"] = loadfx("vfx\map\mp_vlobby_room\vlobby_leg_trail");
  level._effect["loot_card_trail_epic"] = loadfx("vfx\map\mp_vlobby_room\vlobby_epic_trail");
  level._effect["vlobby_pistol_flash"] = loadfx("vfx\map\mp_vlobby_room\vlobby_pistol_flash");
  level._effect["pistol"] = loadfx("vfx\shelleject\pistol");
  level._effect["vlobby_cellphone_light"] = loadfx("vfx\map\mp_vlobby_room\vlobby_cellphone_light");
  level._effect["cigarette_exhnose_vlobby"] = loadfx("vfx\smoke\cigarette_exhnose_vlobby");
  level._effect["loot_sticker_wolf"] = loadfx("vfx\loot\mp_loot_sticker_wolf");
  level._effect["loot_sticker_wolf_rare"] = loadfx("vfx\loot\mp_loot_sticker_wolf_blue");
  level._effect["vlobby_crate_rare_glow"] = loadfx("vfx\map\mp_vlobby_room\vlobby_crate_rare_glow");
  level._effect["vlobby_crate_epic_glow"] = loadfx("vfx\map\mp_vlobby_room\vlobby_crate_epic_glow");
  level._effect["vlobby_crate_leg_glow"] = loadfx("vfx\map\mp_vlobby_room\vlobby_crate_leg_glow");
  level._effect["vlobby_crate_glow"] = loadfx("vfx\map\mp_vlobby_room\vlobby_crate_glow");
  level._effect["smoke_crate_open"] = loadfx("vfx\map\mp_vlobby_room\smoke_crate_open");
  level._effect["loot_sticker_lion"] = loadfx("vfx\loot\mp_loot_sticker_lion_common");
  level._effect["loot_sticker_lion_rare"] = loadfx("vfx\loot\mp_loot_sticker_lion_rare");
  level._effect["loot_sticker_copperhead"] = loadfx("vfx\loot\mp_loot_sticker_copperhead_common");
  level._effect["loot_sticker_copperhead_rare"] = loadfx("vfx\loot\mp_loot_sticker_copperhead_rare");
  setupdepotexploders();
}

setupdepotexploders() {
  var_0 = common_scripts\utility::createexploder("vlobby_crate_glow");
  var_0 common_scripts\_createfx::set_origin_and_angles((14089, 1251.84, -609.323), (270, 152.37, 157.63));
  var_0 common_scripts\_createfx::set_forward_and_up_vectors();
  var_0.v["fxid"] = "vlobby_crate_glow";
  var_0.v["delay"] = 0;
  var_0.v["exploder"] = "106";
  var_0 = common_scripts\utility::createexploder("vlobby_crate_rare_glow");
  var_0 common_scripts\_createfx::set_origin_and_angles((14089, 1251.84, -608.323), (270, 152.37, 157.63));
  var_0 common_scripts\_createfx::set_forward_and_up_vectors();
  var_0.v["fxid"] = "vlobby_crate_rare_glow";
  var_0.v["delay"] = 0;
  var_0.v["exploder"] = "109";
  var_0 = common_scripts\utility::createexploder("vlobby_crate_leg_glow");
  var_0 common_scripts\_createfx::set_origin_and_angles((14089, 1251.84, -607.323), (270, 152.37, 157.63));
  var_0 common_scripts\_createfx::set_forward_and_up_vectors();
  var_0.v["fxid"] = "vlobby_crate_leg_glow";
  var_0.v["delay"] = 0;
  var_0.v["exploder"] = "112";
  var_0 = common_scripts\utility::createexploder("vlobby_crate_epic_glow");
  var_0 common_scripts\_createfx::set_origin_and_angles((14089, 1251.84, -606.323), (270, 152.37, 157.63));
  var_0 common_scripts\_createfx::set_forward_and_up_vectors();
  var_0.v["fxid"] = "vlobby_crate_epic_glow";
  var_0.v["delay"] = 0;
  var_0.v["exploder"] = "115";
  var_0 = common_scripts\utility::createexploder("smoke_crate_open");
  var_0 common_scripts\_createfx::set_origin_and_angles((14088.3, 1253.98, -612.744), (352.008, 131.04, -89.7203));
  var_0 common_scripts\_createfx::set_forward_and_up_vectors();
  var_0.v["fxid"] = "smoke_crate_open";
  var_0.v["delay"] = 0;
  var_0.v["exploder"] = "201";
}