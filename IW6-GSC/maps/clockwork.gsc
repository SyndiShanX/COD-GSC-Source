/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\clockwork.gsc
*****************************************************/

main() {
  maps\_utility::add_hint_string("nvg", &"SCRIPT_NIGHTVISION_USE", maps\_nightvision::shouldbreaknvghintprint);
  maps\_utility::add_hint_string("disable_nvg", &"SCRIPT_NIGHTVISION_STOP_USE", maps\_nightvision::should_break_disable_nvg_print);
  maps\_utility::template_level("clockwork");
  maps\createart\clockwork_art::main();
  maps\clockwork_fx::main();
  maps\clockwork_precache::main();
  maps\_c4::main();
  maps\_drone_ai::init();
  precache_for_startpoints();
  thread maps\_teargas::initteargas();
  level.woof = 0;
  clockwork_starts();
  maps\clockwork_code::clockwork_init();
  maps\_utility::transient_init("clockwork_start_tr");
  maps\_utility::transient_init("clockwork_end_tr");
  maps\_load::main();
  maps\clockwork_anim::main();
  maps\clockwork_fx::setup_footstep_fx();
  maps\_rv_vfx::init();
  maps\clockwork_audio::main();
  thread fx_turn_on_tunnel_lights();
  thread fx_turn_on_introfx();
  thread fx_snowmobile_light();
  maps\_nightvision::main(level.players, 1);
  level.player setactionslot(1, "");
  setsaveddvar("r_ssaofadedepth", 1200);
  maps\_utility::setsaveddvar_cg_ng("r_specularcolorscale", 2.4, 4.0);
  maps\_utility::setsaveddvar_cg_ng("r_diffusecolorscale", 2.2, 1.3);
  setsaveddvar("cg_foliagesnd_alias", "clkw_foot_foliage_player");
  maps\clockwork_scriptedlights::main();
  maps\_utility::setsaveddvar_cg_ng("fx_alphathreshold", 9, 9);
  setDvar("music_enable", 1);
  thread fx_aurora_anim();
  thread maps\clockwork_fx::fx_checkpoint_states();
  maps\hud_outline_objective::outline_enable();
}

fx_aurora_anim() {
  var_0 = getent("clk_aurora", "targetname");

  if(isDefined(var_0)) {
    var_0.animname = "aurora";
    var_1 = var_0 common_scripts\utility::spawn_tag_origin();
    var_2 = maps\_utility::spawn_anim_model("aurora", var_0.origin);
    var_2.angles = var_0.angles;
    var_3 = maps\_utility::spawn_anim_model("aurora2", var_0.origin);
    var_3.angles = var_0.angles;
    var_0 delete();
    var_2 thread maps\_anim::anim_loop_solo(var_2, "clk_aurora_loop");
    wait 7.35;
    var_3 thread maps\_anim::anim_loop_solo(var_3, "clk_aurora_loop");
  }
}

fx_turn_on_tunnel_lights() {
  common_scripts\utility::exploder(150);
}

fx_turn_on_introfx() {
  common_scripts\utility::exploder(2000);
}

fx_snowmobile_light() {
  thread maps\clockwork_fx::turn_effects_on("snowmobile_headlight", "vfx/moments/clockwork/vfx_intro_snwmbl_lights");
  common_scripts\utility::flag_wait("FLAG_intro_light_off");
  thread maps\clockwork_audio::intro_headlamp_smash();
  thread maps\clockwork_fx::turn_effects_on("snowmobile_headlight", "vfx/moments/clockwork/vfx_intro_snwmbl_lights_break");
  common_scripts\utility::flag_set("snowmobile_headlight");
}

clockwork_starts() {
  maps\_utility::add_start("intro2", maps\clockwork_intro::setup_intro2, "Snowmobiles.", maps\clockwork_intro::begin_intro, "clockwork_start_tr");
  maps\_utility::add_start("checkpoint", maps\clockwork_intro::setup_checkpoint, "Checkpoint", maps\clockwork_intro::begin_checkpoint, "clockwork_start_tr");
  maps\_utility::add_start("start_ambush", maps\clockwork_intro::setup_ambush, "Ambush", maps\clockwork_intro::begin_ambush, "clockwork_start_tr");
  maps\_utility::add_start("interior", maps\clockwork_interior_nvg::setup_interior, "interior", maps\clockwork_interior_nvg::begin_interior, "clockwork_start_tr");
  maps\_utility::add_start("interior_vault_scene", maps\clockwork_interior::setup_interior_vault_scene, "interior_vault_scene", maps\clockwork_interior::begin_interior_vault_scene, "clockwork_start_tr");
  maps\_utility::add_start("interior_combat", maps\clockwork_interior::setup_interior_combat, "interior_combat", maps\clockwork_interior::begin_interior_combat, "clockwork_start_tr");
  maps\_utility::add_start("interior_cqb", maps\clockwork_interior::setup_interior_cqb, "interior_cqb", maps\clockwork_interior::begin_interior_cqb, "clockwork_start_tr");
  maps\_utility::add_start("defend", maps\clockwork_defend::setup_defend, "defend", maps\clockwork_defend::begin_defend, "clockwork_end_tr");
  maps\_utility::add_start("defend_plat", maps\clockwork_defend::setup_defend_plat, "Defend from platform", maps\clockwork_defend::begin_defend_plat, "clockwork_end_tr");
  maps\_utility::add_start("defend_blowdoors1", maps\clockwork_defend::setup_defend_blowdoors1, "Defend 1st doors boom", maps\clockwork_defend::begin_defend_blowdoors1, "clockwork_end_tr");
  maps\_utility::add_start("defend_blowdoors2", maps\clockwork_defend::setup_defend_blowdoors2, "Defend 2nd doors boom", maps\clockwork_defend::begin_defend_blowdoors2, "clockwork_end_tr");
  maps\_utility::add_start("defend_fire_blocker", maps\clockwork_defend::setup_defend_fire_blocker, "Defend fireblocker ready", maps\clockwork_defend::begin_defend_fire_blocker, "clockwork_end_tr");
  maps\_utility::add_start("chaos", maps\clockwork_exfil::setup_chaos, "chaos", maps\clockwork_exfil::begin_chaos, "clockwork_end_tr");
  maps\_utility::add_start("exfil", maps\clockwork_exfil::setup_exfil, "exfil", maps\clockwork_exfil::begin_exfil, "clockwork_end_tr");
  maps\_utility::add_start("exfil_tank", maps\clockwork_exfil::setup_exfil_alt, "exfil_tank", maps\clockwork_exfil::begin_exfil_tank, "clockwork_end_tr");
  maps\_utility::add_start("exfil_bridge", maps\clockwork_exfil::setup_exfil_alt, "exfil_bridge", maps\clockwork_exfil::begin_exfil_bridge, "clockwork_end_tr");
  maps\_utility::add_start("exfil_cave", maps\clockwork_exfil::setup_exfil_alt, "exfil_cave", maps\clockwork_exfil::begin_exfil_cave, "clockwork_end_tr");
  maps\_utility::default_start(maps\clockwork_intro::setup_intro2);
  maps\_utility::set_default_start("intro2");
}

precache_for_startpoints() {
  precacheshader("hud_icon_nvg");
  precacheitem("cz805bren+reflex_sp+silencer_sp");
  precacheitem("cz805bren+reflex_sp");
  precacheitem("M27");
  precacheitem("gm6+scopegm6_sp+silencer03_sp");
  precacheitem("mts255");
  precacheitem("mp443");
  precacheitem("btr80_turret_castle");
  precacheitem("cz805bren_disguise");
  precacheitem("cz805bren_quick");
  precacheitem("gm6_disguise");
  precacheitem("gm6_quick");
  precacheitem("drill_press");
  precacheitem("helmet_goggles");
  precachemodel("clk_vault_tablet");
  precachemodel("viewmodel_commando_knife");
  precachemodel("weapon_proximity_mine");
  precachemodel("chinese_brave_warrior_obj_door_back_LE");
  precachemodel("chinese_brave_warrior_obj_door_back_RI");
  precachemodel("clk_lab_overheadlight_off");
  precachemodel("clk_emergency_light");
  precachemodel("clk_emergency_light_02");
  precachemodel("clk_light_rack");
  precachemodel("chinese_brave_warrior_fx_glass");
  precachemodel("clk_fire_extinguisher_lrg_anim");
  precachemodel("clk_door_01");
  precacherumble("drill_normal");
  precacherumble("drill_vault");
  precacherumble("drill_through");
  precachemodel("fullbody_fed_army_victim_a");
  precachemodel("clk_russian_military_non_disguise_head_a");
  precachemodel("clk_russian_military_non_disguise_head_b");
  precachemodel("head_merrick_fed_head_b");
  precachemodel("head_hesh_stealth_b_no_helmet");
  precachemodel("viewmodel_helmet_goggles_fed");
  precachemodel("chinese_brave_warrior_door_back_le");
  precachemodel("chinese_brave_warrior_door_back_ri");
  precachemodel("weapon_commando_knife");
  precachemodel("head_elite_pmc_head_b");
  precachemodel("fed_army_corpse_a");
  precachemodel("fed_army_corpse_b");
  precachemodel("fed_army_corpse_c");
  precachemodel("ny_harbor_missle_key");
  precachemodel("weapon_binocular");
  precachemodel("com_hand_radio");
  precachemodel("mil_ammo_case_1");
  precachemodel("clk_searchlight_ir_full");
  precachemodel("vehicle_brave_warrior_turretring");
  precachemodel("head_fed_army_c_arctic");
  precachemodel("head_fed_army_a_arctic");
  maps\clockwork_fx::clockwork_treadfx_override();
  maps\clockwork_intro::clockwork_intro_pre_load();
  maps\clockwork_interior_nvg::clockwork_interior_nvg_pre_load();
  maps\clockwork_interior::clockwork_interior_pre_load();
  maps\clockwork_defend::clockwork_defend_pre_load();
  maps\clockwork_exfil::clockwork_exfil_pre_load();
  thread post_load();
}

post_load() {
  level waittill("load_finished");
  maps\clockwork_defend::setup_blockers();
  common_scripts\_sentry::setup_sentry_smg();
}