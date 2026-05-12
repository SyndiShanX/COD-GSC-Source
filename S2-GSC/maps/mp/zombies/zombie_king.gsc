/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\zombie_king.gsc
*********************************************/

func_00D5() {
  maps\mp\agents\_scripted_agent_anim_util::func_5159("zombie_king");
  level.var_A41["zombie_king"] = level.var_A41["zombie"];
  level.var_A41["zombie_king"]["think"] = ::king_think;
  level.var_A41["zombie_king"]["on_damaged_finished"] = ::king_on_damage_finished;
  level.var_A41["zombie_king"]["on_damaged"] = ::king_on_damaged;
  level.var_A41["zombie_king"]["is_hit_weak_point"] = ::king_ishitweakpoint;
  var_00 = spawnStruct();
  var_00.var_A4B = "zombie_king";
  var_00.var_EAE = "zombie_king_animclass";
  var_00.var_E88 = "zombie_king";
  var_00.var_879 = "zombie_king";
  var_00.var_4C12 = 10;
  var_00.overridehealth = int(2451660);
  var_00.var_60E2 = 65;
  var_00.var_8302 = 100;
  var_00.var_8303 = 32;
  var_00.tacklebymelee = 0;
  var_00.tacklebycharge = 0;
  var_00.knockbyravensword = 0;
  var_00.shockbyteslablood = 0;
  var_00.scaleshealthbyplayers = 1;
  var_00.exemptfromfailsafekill = 1;
  var_00.var_5ED2["zombie_king"]["whole_body"] = "zom_darkone_base";
  lib_0547::func_A52(var_00, "zombie_king");
  lib_0547::registeranimtree("zombie_king", #animtree);
  lib_0541::func_2F92("crawl", ["zombie_king"]);
  thread validate_level_setup();
  lib_0547::func_7BD0("king_default", ::state_default_run, ::state_default_interrupt, 100, ::state_default_end);
  lib_0547::func_7BD0("king_stand_pain", ::anim_state_stand_pain_run, ::anim_state_stand_pain_interrupt, 149, ::anim_state_stand_pain_end);
  level.var_611["zmb_king_gk_levitation"] = loadfx("vfx/zombie/zmb_king_gk_levitation");
  level.var_611["zmb_king_gk_blood_levitation"] = loadfx("vfx/zombie/zmb_king_gk_blood_levitation");
  level.var_611["zmb_king_gk_blood_levitation_chn_1"] = loadfx("vfx/zombie/zmb_king_gk_blood_levitation_chn_1");
  level.var_611["zmb_king_gk_blood_levitation_chn_2"] = loadfx("vfx/zombie/zmb_king_gk_blood_levitation_chn_2");
  level.var_611["zmb_king_gk_blood_levitation_chn_3"] = loadfx("vfx/zombie/zmb_king_gk_blood_levitation_chn_3");
  level.var_611["zmb_king_gk_death_levitation"] = loadfx("vfx/zombie/zmb_king_gk_death_levitation");
  level.var_611["zmb_king_gk_death_levitation_chn_1"] = loadfx("vfx/zombie/zmb_king_gk_death_levitation_chn_1");
  level.var_611["zmb_king_gk_death_levitation_chn_2"] = loadfx("vfx/zombie/zmb_king_gk_death_levitation_chn_2");
  level.var_611["zmb_king_gk_death_levitation_chn_3"] = loadfx("vfx/zombie/zmb_king_gk_death_levitation_chn_3");
  level.var_611["zmb_king_gk_moon_levitation"] = loadfx("vfx/zombie/zmb_king_gk_moon_levitation");
  level.var_611["zmb_king_gk_moon_levitation_chn_1"] = loadfx("vfx/zombie/zmb_king_gk_moon_levitation_chn_1");
  level.var_611["zmb_king_gk_moon_levitation_chn_2"] = loadfx("vfx/zombie/zmb_king_gk_moon_levitation_chn_2");
  level.var_611["zmb_king_gk_moon_levitation_chn_3"] = loadfx("vfx/zombie/zmb_king_gk_moon_levitation_chn_3");
  level.var_611["zmb_king_gk_storm_levitation"] = loadfx("vfx/zombie/zmb_king_gk_storm_levitation");
  level.var_611["zmb_king_gk_storm_levitation_chn_1"] = loadfx("vfx/zombie/zmb_king_gk_storm_levitation_chn_1");
  level.var_611["zmb_king_gk_storm_levitation_chn_2"] = loadfx("vfx/zombie/zmb_king_gk_storm_levitation_chn_2");
  level.var_611["zmb_king_gk_storm_levitation_chn_3"] = loadfx("vfx/zombie/zmb_king_gk_storm_levitation_chn_3");
  level.var_611["zmb_king_gk_levitation"] = loadfx("vfx/zombie/zmb_king_gk_levitation");
  level.var_611["zmb_king_gk_levitation_chn_1"] = loadfx("vfx/zombie/zmb_king_gk_levitation_chn_1");
  level.var_611["zmb_king_gk_levitation_chn_2"] = loadfx("vfx/zombie/zmb_king_gk_levitation_chn_2");
  level.var_611["zmb_king_gk_levitation_chn_3"] = loadfx("vfx/zombie/zmb_king_gk_levitation_chn_3");
  level.var_611["zmb_gk_geistbomb_trail"] = loadfx("vfx/trail/zmb_gk_geistbomb_trail");
  level.var_611["zmb_godking_giestbomb"] = loadfx("vfx/zombie/zmb_godking_giestbomb");
  level.var_611["zmb_godking_giestbomb_prime"] = loadfx("vfx/zombie/zmb_godking_giestbomb_prime");
  level.var_611["zmb_gk_lightsun_blast"] = loadfx("vfx/zombie/zmb_gk_lightsun_blast");
  level.var_611["zmb_gk_lightsun_buildup"] = loadfx("vfx/zombie/zmb_gk_lightsun_buildup");
  level.var_611["zmb_godking_gk_impact"] = loadfx("vfx/zombie/zmb_godking_gk_impact");
  level.var_611["zmb_godking_sword_protection"] = loadfx("vfx/zombie/zmb_godking_sword_protection");
  level.var_611["blood_godking_impact_burst"] = loadfx("vfx/blood/blood_godking_impact_burst");
  level.var_611["zmf_corpse_eater_smoldering"] = loadfx("vfx/zombie/prototype_fx/zmf_corpse_eater_smoldering");
}

king_post_model_vfx() {
  attach_levitation_effects();
}

attach_levitation_effects() {
  self endon("death");
  wait 0.05;
  wait 0.05;
  wait 0.05;
  wait 0.05;
  playFXOnTag(level.var_611["zmb_king_gk_levitation"], self, "J_Spine4");
}

validate_level_setup() {
  level.king_level_setup = 0;
  if(!isDefined(level.bossfight)) {
    return;
  }

  if(!isDefined(level.bossfight.boss_pos) || !isDefined(level.bossfight.boss_blood_pos) || !isDefined(level.bossfight.throne_pos)) {
    return;
  }

  level.bossfight.default_boss_pos = spawnStruct();
  level.bossfight.default_boss_pos.var_116 = level.bossfight.boss_pos;
  level.king_level_setup = 1;
}

king_think_setup() {
  level notify("zombie_king_spawned");
  maps\mp\agents\humanoid\_humanoid::func_8A27();
  thread lib_054D::func_A146();
  self.iszombieking = 1;
  if(lib_0547::is_solo()) {
    self.issolomode = 1;
  }

  self method_85A1("zombie");
  self scragentsetscripted(1);
  maps\mp\agents\_scripted_agent_anim_util::func_8732(1, "zombie_king");
  self.ispermanentlyscripted = 1;
  self.var_55AB = 1;
  self.var_57E8 = 1;
  self.var_562B = 1;
  self.ignoredistractiondrones = 1;
  self.shortstun = 1;
  self.var_509A = 1;
  self.var_6734 = 1;
  self.var_C29 = 0;
  self.is_flamethrower_immune = 1;
  self.lucky_crit_nerf = 1;
  self.zmdemigod = 1;
  self.var_6816 = 1;
  self.nomutilate = 1;
  self.nopairmelee = 1;
  self.var_66EC = 1;
  self.var_BD = 100;
  self.var_14F = 32;
  self.var_2BCA = self.var_14F + 1;
  self method_8399(self.var_2BCA);
  lib_0547::func_86C8(280);
  lib_0547::func_86C7(280);
  self.candamageallies = 1;
  self.var_2A9D = "death";
  self.var_11AB = 85 + self.var_14F;
  self.var_60F5 = "large";
  self.var_60F6 = 200;
  self.var_60E1 = 40;
  self method_84D4();
  self.king_damage_finished_funcs = [];
  self.vo_drain_punished_int = 0;
  self.vo_taunt_int = 0;
  self.vo_lines_played = [];
  self.stunnedclip = getent("clip_boss_torso", "targetname");
  if(isDefined(self.stunnedclip)) {
    self.stunnedclip.original_org = self.stunnedclip.var_116;
    self.stunnedclip.original_ang = self.stunnedclip.var_1D;
    self.stunnedclip notsolid();
    self.stunnedclip.var_A045 = ::body_clip_unresolved_collision;
    self.stunnedclip.var_A049 = 1;
  }

  common_scripts\utility::func_3799("phase_transition_active");
  attacks_init();
  phases_init();
  thread wave_management_think();
  thread handle_manual_move();
  thread handle_manual_rotation();
  thread end_condition();
  lib_0542::set_invalid_melee_pairing_reason("god_king", 1);
  thread king_scale_health();
  thread king_handle_pain();
  thread init_impact_vfx();
  lib_0547::func_7BA9(::zombie_detonate_clear_property);
}

king_scale_health() {
  wait 0.05;
  var_00 = self.var_FB * level.var_721C.size;
  maps\mp\agents\_agent_common::func_83FD(int(var_00));
}

end_condition() {
  var_00 = self;
  var_00 waittill("it_is_over");
  level notify("god_king_defeated");
  common_scripts\utility::func_3C8F("flag_boss_complete");
}

attacks_init() {
  self.attack_basic["geist_blast"] = spawnStruct();
  self.attack_basic["geist_blast"].var_116E = "geist_blast";
  self.attack_basic["geist_blast"].scr_st = "geist_blast";
  self.attack_basic["geist_blast"].try_func = ::special_geist_blast_try;
  self.attack_basic["geist_blast"].var_920F = ::special_geist_blast_start;
  self.attack_basic["geist_blast"].think_func = ::special_geist_blast_think;
  self.attack_basic["geist_blast"].var_367E = ::special_geist_blast_end;
  self.attack_basic["geist_blast"].run_func = ::anim_state_geist_blast_run;
  self.attack_basic["geist_blast"].scr_pri = 101;
  self.attack_basic["geist_blast"].anim_end_func = ::anim_state_geist_blast_end;
  self.attack_basic["geist_blast"].allow_pain = 1;
  register_boss_special_attack_wrapper("geist_blast");
  self.attack_basic["geist_lightning"] = spawnStruct();
  self.attack_basic["geist_lightning"].var_116E = "geist_lightning";
  self.attack_basic["geist_lightning"].scr_st = "geist_lightning";
  self.attack_basic["geist_lightning"].try_func = ::special_geist_lightning_try;
  self.attack_basic["geist_lightning"].var_920F = ::special_geist_lightning_start;
  self.attack_basic["geist_lightning"].think_func = ::special_geist_lightning_think;
  self.attack_basic["geist_lightning"].var_367E = ::special_geist_lightning_end;
  self.attack_basic["geist_lightning"].run_func = ::anim_state_geist_lightning_run;
  self.attack_basic["geist_lightning"].scr_pri = 102;
  self.attack_basic["geist_lightning"].allow_pain = 1;
  register_boss_special_attack_wrapper("geist_lightning");
  self.attack_basic["geist_bomb"] = spawnStruct();
  self.attack_basic["geist_bomb"].var_116E = "geist_bomb";
  self.attack_basic["geist_bomb"].scr_st = "geist_bomb";
  self.attack_basic["geist_bomb"].try_func = ::special_geist_bombs_try;
  self.attack_basic["geist_bomb"].var_920F = ::special_geist_bombs_start;
  self.attack_basic["geist_bomb"].think_func = ::special_geist_bombs_think;
  self.attack_basic["geist_bomb"].var_367E = ::special_geist_bombs_end;
  self.attack_basic["geist_bomb"].run_func = ::anim_state_geist_bombs_run;
  self.attack_basic["geist_bomb"].scr_pri = 104;
  self.attack_basic["geist_bomb"].allow_pain = 1;
  register_boss_special_attack_wrapper("geist_bomb");
  self.attack_basic["geist_detonate"] = spawnStruct();
  self.attack_basic["geist_detonate"].var_116E = "detonate";
  self.attack_basic["geist_detonate"].scr_st = "detonate";
  self.attack_basic["geist_detonate"].try_func = ::special_detonate_try;
  self.attack_basic["geist_detonate"].var_920F = ::special_detonate_start;
  self.attack_basic["geist_detonate"].think_func = ::special_detonate_think;
  self.attack_basic["geist_detonate"].var_367E = ::special_detonate_end;
  self.attack_basic["geist_detonate"].run_func = ::anim_state_detonate_run;
  self.attack_basic["geist_detonate"].scr_pri = 103;
  self.attack_basic["geist_detonate"].allow_pain = 1;
  register_boss_special_attack_wrapper("geist_detonate");
  self.attack_basic["geist_pull"] = spawnStruct();
  self.attack_basic["geist_pull"].var_116E = "geist_pull";
  self.attack_basic["geist_pull"].scr_st = "geist_pull";
  self.attack_basic["geist_pull"].try_func = ::special_geist_pull_try;
  self.attack_basic["geist_pull"].var_920F = ::special_geist_pull_start;
  self.attack_basic["geist_pull"].think_func = ::special_geist_pull_think;
  self.attack_basic["geist_pull"].var_367E = ::special_geist_pull_end;
  self.attack_basic["geist_pull"].run_func = ::anim_state_geist_pull_run;
  self.attack_basic["geist_pull"].scr_pri = 105;
  self.attack_basic["geist_pull"].anim_end_func = ::anim_state_geist_pull_end;
  register_boss_special_attack_wrapper("geist_pull");
  self.attack_basic["geist_drain"] = spawnStruct();
  self.attack_basic["geist_drain"].var_116E = "geist_drain";
  self.attack_basic["geist_drain"].scr_st = "geist_drain";
  self.attack_basic["geist_drain"].try_func = ::special_geist_drain_try;
  self.attack_basic["geist_drain"].var_920F = ::special_geist_drain_start;
  self.attack_basic["geist_drain"].think_func = ::special_geist_drain_think;
  self.attack_basic["geist_drain"].var_367E = ::special_geist_drain_end;
  self.attack_basic["geist_drain"].run_func = ::anim_state_geist_drain_run;
  self.attack_basic["geist_drain"].scr_pri = 107;
  self.attack_basic["geist_drain"].anim_end_func = ::anim_state_geist_drain_end;
  register_boss_special_attack_wrapper("geist_drain");
  self.attack_basic["flame_wave"] = spawnStruct();
  self.attack_basic["flame_wave"].var_116E = "flame_wave";
  self.attack_basic["flame_wave"].scr_st = "flame_wave";
  self.attack_basic["flame_wave"].try_func = ::uber_flame_wave_try;
  self.attack_basic["flame_wave"].var_920F = ::uber_flame_wave_start;
  self.attack_basic["flame_wave"].think_func = ::uber_flame_wave_think;
  self.attack_basic["flame_wave"].var_367E = ::uber_flame_wave_end;
  self.attack_basic["flame_wave"].run_func = ::anim_state_flame_wave_run;
  self.attack_basic["flame_wave"].scr_pri = 151;
  self.attack_basic["flame_wave"].anim_end_func = ::anim_state_flame_wave_end;
  register_boss_special_attack_wrapper("flame_wave");
  self.attack_basic["force"] = spawnStruct();
  self.attack_basic["force"].var_116E = "force";
  self.attack_basic["force"].scr_st = "force";
  self.attack_basic["force"].try_func = ::uber_force_try;
  self.attack_basic["force"].var_920F = ::uber_force_start;
  self.attack_basic["force"].think_func = ::uber_force_think;
  self.attack_basic["force"].var_367E = ::uber_force_end;
  self.attack_basic["force"].run_func = ::anim_state_force_run;
  self.attack_basic["force"].scr_pri = 152;
  register_boss_special_attack_wrapper("force");
  self.attack_basic["sun"] = spawnStruct();
  self.attack_basic["sun"].var_116E = "sun";
  self.attack_basic["sun"].scr_st = "sun";
  self.attack_basic["sun"].try_func = ::uber_sun_try;
  self.attack_basic["sun"].var_920F = ::uber_sun_start;
  self.attack_basic["sun"].think_func = ::uber_sun_think;
  self.attack_basic["sun"].var_367E = ::uber_sun_end;
  self.attack_basic["sun"].run_func = ::anim_state_sun_run;
  self.attack_basic["sun"].scr_pri = 153;
  register_boss_special_attack_wrapper("sun");
  self.attack_basic["sit"] = spawnStruct();
  self.attack_basic["sit"].var_116E = "sit";
  self.attack_basic["sit"].scr_st = "sit";
  self.attack_basic["sit"].try_func = ::special_geist_sit_try;
  self.attack_basic["sit"].var_920F = ::special_geist_sit_start;
  self.attack_basic["sit"].think_func = ::special_geist_sit_think;
  self.attack_basic["sit"].var_367E = ::special_geist_sit_end;
  self.attack_basic["sit"].run_func = ::anim_state_geist_sit_run;
  self.attack_basic["sit"].scr_pri = 120;
  self.attack_basic["sit"].anim_end_func = ::anim_state_geist_sit_end;
  register_boss_special_attack_wrapper("sit");
  self.attack_basic["geist_kneel"] = spawnStruct();
  self.attack_basic["geist_kneel"].var_116E = "kneel";
  self.attack_basic["geist_kneel"].scr_st = "kneel";
  self.attack_basic["geist_kneel"].try_func = ::special_geist_kneel_try;
  self.attack_basic["geist_kneel"].var_920F = ::special_geist_kneel_start;
  self.attack_basic["geist_kneel"].think_func = ::special_geist_kneel_think;
  self.attack_basic["geist_kneel"].var_367E = ::special_geist_kneel_end;
  self.attack_basic["geist_kneel"].run_func = ::anim_state_geist_kneel_run;
  self.attack_basic["geist_kneel"].scr_pri = 106;
  self.attack_basic["geist_kneel"].anim_end_func = ::anim_state_geist_kneel_end;
  register_boss_special_attack_wrapper("geist_kneel");
  self.attack_basic["geist_drain_special_fake"] = spawnStruct();
  self.attack_basic["geist_drain_special_fake"].var_116E = "geist_drain_special_fake";
  self.attack_basic["geist_drain_special_fake"].scr_st = "geist_drain_special_fake";
  self.attack_basic["geist_drain_special_fake"].try_func = ::special_geist_drain_special_fake_try;
  self.attack_basic["geist_drain_special_fake"].var_920F = ::special_geist_drain_special_fake_start;
  self.attack_basic["geist_drain_special_fake"].think_func = ::special_geist_drain_special_fake_think;
  self.attack_basic["geist_drain_special_fake"].var_367E = ::special_geist_drain_special_fake_end;
  self.attack_basic["geist_drain_special_fake"].run_func = ::anim_state_geist_drain_special_fake_run;
  self.attack_basic["geist_drain_special_fake"].scr_pri = 150;
  self.attack_basic["geist_drain_special_fake"].anim_end_func = ::anim_state_geist_drain_special_fake_end;
  register_boss_special_attack_wrapper("geist_drain_special_fake");
  self.attack_basic["geist_drain_special"] = spawnStruct();
  self.attack_basic["geist_drain_special"].var_116E = "geist_drain_special";
  self.attack_basic["geist_drain_special"].scr_st = "geist_drain_special";
  self.attack_basic["geist_drain_special"].try_func = ::special_geist_drain_special_try;
  self.attack_basic["geist_drain_special"].var_920F = ::special_geist_drain_special_start;
  self.attack_basic["geist_drain_special"].think_func = ::special_geist_drain_special_think;
  self.attack_basic["geist_drain_special"].var_367E = ::special_geist_drain_special_end;
  self.attack_basic["geist_drain_special"].run_func = ::anim_state_geist_drain_special_run;
  self.attack_basic["geist_drain_special"].scr_pri = 108;
  self.attack_basic["geist_drain_special"].anim_end_func = ::anim_state_geist_drain_special_end;
  register_boss_special_attack_wrapper("geist_drain_special");
  self.attack_basic["melee"] = spawnStruct();
  self.attack_basic["melee"].var_116E = "melee";
  self.attack_basic["melee"].scr_st = "king_melee";
  self.attack_basic["melee"].try_func = ::special_melee_try;
  self.attack_basic["melee"].var_920F = ::special_melee_start;
  self.attack_basic["melee"].think_func = ::special_melee_think;
  self.attack_basic["melee"].var_367E = ::special_melee_end;
  self.attack_basic["melee"].run_func = ::anim_state_melee_run;
  self.attack_basic["melee"].scr_pri = 110;
  self.attack_basic["melee"].anim_end_func = ::anim_state_melee_end;
  register_boss_special_attack_wrapper("melee");
  melee_init();
  self.attack_basic["move_face_enemy"] = spawnStruct();
  self.attack_basic["move_face_enemy"].var_116E = "move_face_enemy";
  self.attack_basic["move_face_enemy"].try_func = ::special_move_face_enemy_try;
  self.attack_basic["move_face_enemy"].var_920F = ::special_move_face_enemy_start;
  self.attack_basic["move_face_enemy"].think_func = ::special_move_face_enemy_think;
  self.attack_basic["move_face_enemy"].var_367E = ::special_move_face_enemy_end;
  register_boss_special_attack_wrapper("move_face_enemy");
  self.attack_basic["move_to_enemy"] = spawnStruct();
  self.attack_basic["move_to_enemy"].var_116E = "move_to_enemy";
  self.attack_basic["move_to_enemy"].try_func = ::special_move_to_enemy_try;
  self.attack_basic["move_to_enemy"].var_920F = ::special_move_to_enemy_start;
  self.attack_basic["move_to_enemy"].think_func = ::special_move_to_enemy_think;
  self.attack_basic["move_to_enemy"].var_367E = ::special_move_to_enemy_end;
  register_boss_special_attack_wrapper("move_to_enemy");
}

melee_init() {
  if(isDefined(level.king_melee_attacks)) {
    return;
  }

  level.king_melee_attacks = [];
  var_00 = spawnStruct();
  var_00.anim_action = "melee_front_quick";
  var_00.var_F3E = 60;
  var_00.arc_distance = 280;
  var_00.arc_rotation_offset = 0;
  var_00.var_2994 = 0;
  var_00.facing_rotation_allowed = 0;
  level.king_melee_attacks["quick"] = var_00;
  var_00 = spawnStruct();
  var_00.anim_action = "melee_front_heavy";
  var_00.var_F3E = 180;
  var_00.arc_distance = 280;
  var_00.arc_rotation_offset = 0;
  var_00.facing_rotation_allowed = 0;
  level.king_melee_attacks["front180"] = var_00;
  var_00 = spawnStruct();
  var_00.anim_action = "melee_back";
  var_00.var_F3E = 180;
  var_00.arc_distance = 280;
  var_00.arc_rotation_offset = 180;
  var_00.facing_rotation_allowed = 0;
  level.king_melee_attacks["back180"] = var_00;
}

phases_init() {
  self.phases = [];
  var_00 = spawnStruct();
  self.phases[self.phases.size] = var_00;
  var_00.var_9FE1 = undefined;
  var_00.transition_attack_set = undefined;
  var_00.fx_1_name = "zmb_king_gk_death_levitation_chn_1";
  var_00.fx_2_name = "zmb_king_gk_death_levitation_chn_2";
  var_00.fx_3_name = "zmb_king_gk_death_levitation_chn_3";
  var_00.wave_management = ::phase0_wave_management;
  var_00.special_move_set = [];
  var_00 phase_add_special_move("geist_blast");
  var_00 phase_add_special_move("melee");
  var_00 phase_add_special_move("geist_blast");
  if(!common_scripts\utility::func_562E(self.issolomode)) {
    var_00 phase_add_special_move("move_to_enemy", [679]);
  }

  if(!common_scripts\utility::func_562E(self.issolomode)) {
    var_00 phase_add_special_move("melee");
  }

  var_00 phase_add_special_move("melee");
  var_00 phase_add_special_move("geist_blast");
  if(!common_scripts\utility::func_562E(self.issolomode)) {
    var_00 phase_add_special_move("move_to_enemy");
  } else {
    var_00 phase_add_special_move("move_face_enemy");
  }

  var_00 phase_add_special_move("melee");
  var_00 phase_add_special_move("geist_bomb");
  var_00 phase_add_special_move("move_face_enemy");
  var_00 phase_add_special_move("melee");
  var_00 phase_add_special_move("detonate");
  var_00 phase_add_special_move("melee");
  var_00 phase_add_special_move("detonate");
  var_00 phase_add_special_move("melee");
  var_00 phase_add_special_move("geist_blast");
  var_00 phase_add_special_move("move_face_enemy");
  var_00 phase_add_special_move("melee");
  var_00 phase_add_special_move("geist_bomb");
  if(common_scripts\utility::func_562E(self.issolomode)) {
    var_00 phase_add_special_move("move_face_enemy");
  }

  var_00 = spawnStruct();
  self.phases[self.phases.size] = var_00;
  var_00.var_9FE1 = undefined;
  var_00.transition_attack_set = ["geist_pull", "geist_drain"];
  var_00.fx_1_name = "zmb_king_gk_blood_levitation_chn_1";
  var_00.fx_2_name = "zmb_king_gk_blood_levitation_chn_2";
  var_00.fx_3_name = "zmb_king_gk_blood_levitation_chn_3";
  var_00.wave_management = ::phase1_wave_management;
  var_00.special_move_set = [];
  var_00 phase_add_special_move("melee");
  var_00 phase_add_special_move("geist_blast");
  var_00 phase_add_special_move("melee");
  var_00 phase_add_special_move("geist_blast");
  var_00 phase_add_special_move("sun");
  if(!common_scripts\utility::func_562E(self.issolomode)) {
    var_00 phase_add_special_move("move_to_enemy", [679]);
  } else {
    var_00 phase_add_special_move("move_face_enemy");
  }

  var_00 phase_add_special_move("geist_lightning");
  var_00 phase_add_special_move("melee");
  var_00 phase_add_special_move("geist_lightning");
  var_00 phase_add_special_move("melee");
  var_00 phase_add_special_move("geist_blast");
  var_00 phase_add_special_move("sun");
  if(!common_scripts\utility::func_562E(self.issolomode)) {
    var_00 phase_add_special_move("move_to_enemy", [679]);
    var_00 phase_add_special_move("melee");
    var_00 phase_add_special_move("move_to_enemy", [679]);
  } else {
    var_00 phase_add_special_move("move_face_enemy");
  }

  var_00 = spawnStruct();
  self.phases[self.phases.size] = var_00;
  var_00.var_9FE1 = undefined;
  var_00.transition_attack_set = ["geist_pull", "geist_drain"];
  var_00.fx_1_name = "zmb_king_gk_storm_levitation_chn_1";
  var_00.fx_2_name = "zmb_king_gk_storm_levitation_chn_2";
  var_00.fx_3_name = "zmb_king_gk_storm_levitation_chn_3";
  var_00.wave_management = ::phase2_wave_management;
  var_00.special_move_set = [];
  var_00 phase_add_special_move("melee");
  var_00 phase_add_special_move("geist_lightning");
  var_00 phase_add_special_move("force");
  if(!common_scripts\utility::func_562E(self.issolomode)) {
    var_00 phase_add_special_move("move_to_enemy", [679]);
  } else {
    var_00 phase_add_special_move("move_face_enemy");
  }

  var_00 phase_add_special_move("melee");
  var_00 phase_add_special_move("geist_lightning");
  var_00 phase_add_special_move("melee");
  var_00 phase_add_special_move("geist_lightning");
  var_00 phase_add_special_move("melee");
  var_00 phase_add_special_move("geist_bomb");
  var_00 phase_add_special_move("move_face_enemy", [970]);
  var_00 phase_add_special_move("force");
  var_00 phase_add_special_move("geist_bomb");
  var_00 phase_add_special_move("melee");
  var_00 phase_add_special_move("geist_blast");
  if(!common_scripts\utility::func_562E(self.issolomode)) {
    var_00 phase_add_special_move("move_to_enemy", [679]);
  } else {
    var_00 phase_add_special_move("move_face_enemy");
  }

  var_00 phase_add_special_move("melee");
  var_00 phase_add_special_move("geist_lightning");
  var_00 phase_add_special_move("melee");
  var_00 phase_add_special_move("geist_lightning");
  var_00 phase_add_special_move("melee");
  var_00 phase_add_special_move("move_face_enemy", [970]);
  var_00 = spawnStruct();
  self.phases[self.phases.size] = var_00;
  var_00.var_9FE1 = undefined;
  var_00.transition_attack_set = ["geist_pull", "geist_drain"];
  var_00.fx_1_name = "zmb_king_gk_moon_levitation_chn_1";
  var_00.fx_2_name = "zmb_king_gk_moon_levitation_chn_2";
  var_00.fx_3_name = "zmb_king_gk_moon_levitation_chn_3";
  var_00.wave_management = ::phase3_wave_management;
  var_00.special_move_set = [];
  var_00 phase_add_special_move("melee");
  var_00 phase_add_special_move("detonate");
  var_00 phase_add_special_move("melee");
  var_00 phase_add_special_move("detonate");
  var_00 phase_add_special_move("move_face_enemy");
  var_00 phase_add_special_move("geist_pull");
  var_00 phase_add_special_move("flame_wave");
  var_00 phase_add_special_move("move_face_enemy");
  var_00 phase_add_special_move("melee");
  var_00 phase_add_special_move("geist_blast");
  var_00 phase_add_special_move("melee");
  var_00 phase_add_special_move("geist_blast");
  var_00 phase_add_special_move("geist_bomb");
  if(!common_scripts\utility::func_562E(self.issolomode)) {
    var_00 phase_add_special_move("move_to_enemy", [679]);
  } else {
    var_00 phase_add_special_move("move_face_enemy");
  }

  var_00 = spawnStruct();
  self.phases[self.phases.size] = var_00;
  var_00.var_9FE1 = undefined;
  var_00.transition_attack_set = ["geist_pull", "kneel", "sit"];
  var_00.fx_1_name = "zmb_king_gk_levitation_chn_1";
  var_00.fx_2_name = "zmb_king_gk_levitation_chn_2";
  var_00.fx_3_name = "zmb_king_gk_levitation_chn_3";
  var_00.wave_management = ::phase4_wave_management;
  var_00.special_move_set = [];
  var_00 phase_add_special_move("geist_drain_special_fake");
  var_00 = spawnStruct();
  self.phases[self.phases.size] = var_00;
  var_00.var_9FE1 = undefined;
  var_00.transition_attack_set = undefined;
  var_00.fx_1_name = "zmb_king_gk_levitation_chn_1";
  var_00.fx_2_name = "zmb_king_gk_levitation_chn_2";
  var_00.fx_3_name = "zmb_king_gk_levitation_chn_3";
  var_00.wave_management = ::phase5_wave_management;
  var_00.special_move_set = [];
  var_00 phase_add_special_move("geist_drain_special");
  var_00 = spawnStruct();
  self.phases[self.phases.size] = var_00;
  var_00.var_9FE1 = undefined;
  var_00.transition_attack_set = ["geist_pull", "geist_drain"];
  var_00.fx_1_name = "zmb_king_gk_levitation_chn_1";
  var_00.fx_2_name = "zmb_king_gk_levitation_chn_2";
  var_00.fx_3_name = "zmb_king_gk_levitation_chn_3";
  var_00.wave_management = ::phase6_wave_management;
  var_00.special_move_set = [];
  if(!common_scripts\utility::func_562E(self.issolomode)) {
    var_00 phase_add_special_move("move_to_enemy", [679]);
    var_00 phase_add_special_move("melee");
    var_00 phase_add_special_move("move_to_enemy", [679]);
    var_00 phase_add_special_move("melee");
  }

  var_00 phase_add_special_move("move_face_enemy");
  var_00 phase_add_special_move("geist_bomb");
  var_00 phase_add_special_move("melee");
  var_00 phase_add_special_move("force");
  var_00 phase_add_special_move("detonate");
  var_00 phase_add_special_move("detonate");
  if(!common_scripts\utility::func_562E(self.issolomode)) {
    var_00 phase_add_special_move("move_to_enemy", [679]);
    var_00 phase_add_special_move("melee");
    var_00 phase_add_special_move("move_to_enemy", [679]);
  } else {
    var_00 phase_add_special_move("move_face_enemy");
  }

  var_00 phase_add_special_move("melee");
  var_00 phase_add_special_move("geist_blast");
  var_00 phase_add_special_move("melee");
  var_00 phase_add_special_move("geist_blast");
  var_00 phase_add_special_move("geist_bomb");
  var_00 phase_add_special_move("flame_wave");
  if(!common_scripts\utility::func_562E(self.issolomode)) {
    var_00 phase_add_special_move("move_to_enemy", [679]);
    var_00 phase_add_special_move("melee");
  }

  var_00 phase_add_special_move("melee");
  var_00 phase_add_special_move("geist_blast");
  var_00 phase_add_special_move("melee");
  var_00 phase_add_special_move("geist_blast");
  var_00 phase_add_special_move("sun");
}

phase_add_special_move(param_00, param_01) {
  var_02 = self;
  var_03 = var_02.special_move_set.size;
  var_04 = spawnStruct();
  var_04.var_109 = param_00;
  var_04.var_6E59 = param_01;
  var_02.special_move_set[var_03] = var_04;
}

king_set_current_phase(param_00) {
  var_01 = self;
  var_01.current_phase_index = param_00;
  var_01.current_phase = level.zombie_king.phases[param_00];
  var_01.current_special_move_index = undefined;
  var_01.transition_move_index = undefined;
  var_01 common_scripts\utility::func_379A("phase_transition_active");
  var_01 thread king_set_phase_fx(var_01.current_phase);
  var_01 thread wave_management_set(var_01.current_phase_index);
}

king_set_phase_fx(param_00) {
  var_01 = self;
  if(isDefined(var_01.phase_fx_1_ent)) {
    var_01.phase_fx_1_ent delete();
  }

  if(isDefined(var_01.phase_fx_2_ent)) {
    var_01.phase_fx_2_ent delete();
  }

  if(isDefined(var_01.phase_fx_3_ent)) {
    var_01.phase_fx_3_ent delete();
  }

  if(var_01 common_scripts\utility::func_3794("phase_transition_active") && var_01.current_phase_index != 0) {
    var_02 = "zmb_king_gk_levitation_chn_1";
    var_03 = "zmb_king_gk_levitation_chn_2";
    var_04 = "zmb_king_gk_levitation_chn_3";
    var_01.transition_fx_1_ent = spawnlinkedfx(common_scripts\utility::func_44F5(var_02), var_01, "TAG_FX01");
    triggerfx(var_01.transition_fx_1_ent);
    var_01 king_handle_attached_vfx_cleanup(var_01.transition_fx_1_ent);
    var_01.transition_fx_1_ent thread delete_on_parent_notify(var_01, "clear_transition_fx");
    var_01.transition_fx_2_ent = spawnlinkedfx(common_scripts\utility::func_44F5(var_03), var_01, "TAG_FX01");
    triggerfx(var_01.transition_fx_2_ent);
    var_01 king_handle_attached_vfx_cleanup(var_01.transition_fx_2_ent);
    var_01.transition_fx_2_ent thread delete_on_parent_notify(var_01, "clear_transition_fx");
    var_01.transition_fx_3_ent = spawnlinkedfx(common_scripts\utility::func_44F5(var_04), var_01, "TAG_FX01");
    triggerfx(var_01.transition_fx_3_ent);
    var_01 king_handle_attached_vfx_cleanup(var_01.transition_fx_3_ent);
    var_01.transition_fx_3_ent thread delete_on_parent_notify(var_01, "clear_transition_fx");
    var_01 common_scripts\utility::func_37A1("phase_transition_active");
  }

  if(isDefined(var_01.transition_fx_1_ent)) {
    var_01.transition_fx_1_ent delete();
  }

  if(isDefined(var_01.transition_fx_2_ent)) {
    var_01.transition_fx_2_ent delete();
  }

  if(isDefined(var_01.transition_fx_3_ent)) {
    var_01.transition_fx_3_ent delete();
  }

  if(isDefined(param_00.fx_1_name)) {
    var_01.phase_fx_1_ent = spawnlinkedfx(common_scripts\utility::func_44F5(param_00.fx_1_name), var_01, "TAG_FX01");
    triggerfx(var_01.phase_fx_1_ent);
    var_01 king_handle_attached_vfx_cleanup(var_01.phase_fx_1_ent);
  }

  if(isDefined(param_00.fx_2_name)) {
    var_01.phase_fx_2_ent = spawnlinkedfx(common_scripts\utility::func_44F5(param_00.fx_2_name), var_01, "TAG_FX02");
    triggerfx(var_01.phase_fx_2_ent);
    var_01 king_handle_attached_vfx_cleanup(var_01.phase_fx_2_ent);
  }

  if(isDefined(param_00.fx_3_name)) {
    var_01.phase_fx_3_ent = spawnlinkedfx(common_scripts\utility::func_44F5(param_00.fx_3_name), var_01, "TAG_FX03");
    triggerfx(var_01.phase_fx_3_ent);
    var_01 king_handle_attached_vfx_cleanup(var_01.phase_fx_3_ent);
  }
}

king_think() {
  thread king_think_setup();
  wait(0);
  thread lib_0547::func_7D1A("king_default");
  self endon("death");
  self endon("fight_complete");
  level endon("game_ended");
  for(;;) {
    wait 0.05;
    if(king_in_paused_state()) {
      continue;
    }

    if(process_special_moves()) {
      continue;
    }
  }
}

king_in_paused_state() {
  var_00 = self;
  return lib_0547::func_5565(var_00.full_pause_state, 1);
}

king_set_paused_state() {
  var_00 = self;
  var_00.full_pause_state = 1;
}

king_clear_paused_state() {
  var_00 = self;
  var_00.full_pause_state = 0;
}

process_special_moves() {
  var_00 = self;
  if(isDefined(var_00.current_special_move)) {
    var_01 = var_00[[var_00.current_special_move.think_func]]();
    if(common_scripts\utility::func_562E(var_01)) {
      if(isDefined(var_00.current_special_move.var_367E)) {
        var_00[[var_00.current_special_move.var_367E]]();
      }

      var_00.current_special_move = undefined;
      var_00.standing_pain_allowed = 0;
    } else {
      return 1;
    }
  }

  var_02 = undefined;
  var_03 = undefined;
  var_05 = undefined;
  if(isDefined(var_00.current_phase)) {
    var_05 = var_00.current_phase.transition_attack_set;
  }

  if(!isDefined(var_02) && var_00 common_scripts\utility::func_3794("phase_transition_active") && isDefined(var_00.current_phase) && isDefined(var_00.current_phase.transition_attack_set)) {
    var_06 = 0;
    if(isDefined(var_00.transition_move_index)) {
      var_06 = var_00.transition_move_index + 1;
    }

    var_07 = 0;
    for(;;) {
      var_08 = var_07 + var_06;
      if(var_08 >= var_00.current_phase.transition_attack_set.size) {
        var_00 common_scripts\utility::func_3796("phase_transition_active");
        break;
      }

      var_09 = var_05[var_08];
      var_02 = level.boss_special_moves[var_09];
      var_0A = var_00[[var_02.try_func]]();
      if(var_0A) {
        var_00.transition_move_index = var_08;
        break;
      } else {
        var_02 = undefined;
      }

      var_07++;
    }
  } else if(var_00 common_scripts\utility::func_3794("phase_transition_active")) {
    var_00 common_scripts\utility::func_3796("phase_transition_active");
  }

  var_0B = undefined;
  if(isDefined(var_00.current_phase)) {
    var_0B = var_00.current_phase.special_move_set;
  }

  if(isDefined(var_0B) && !isDefined(var_02)) {
    var_0C = 0;
    if(isDefined(var_00.current_special_move_index)) {
      var_0C = var_00.current_special_move_index + 1;
    }

    for(var_07 = 0; var_07 < var_0B.size; var_07++) {
      var_08 = common_scripts\utility::func_627D(var_07 + var_0C, var_0B.size);
      var_0D = var_0B[var_08];
      var_09 = var_0D.var_109;
      var_02 = level.boss_special_moves[var_09];
      var_03 = var_0D.var_6E59;
      if(isDefined(var_03)) {
        var_0A = var_00[[var_02.try_func]](var_03);
      } else {
        var_0A = var_00[[var_02.try_func]]();
      }

      if(var_0A) {
        var_00.current_special_move_index = var_08;
        break;
      } else {
        var_02 = undefined;
        var_03 = undefined;
      }
    }
  }

  if(isDefined(var_02)) {
    var_00.current_special_move = var_02;
    if(common_scripts\utility::func_562E(var_02.allow_pain)) {
      var_00.standing_pain_allowed = 1;
    }

    if(isDefined(var_02.var_920F)) {
      if(isDefined(var_03)) {
        var_0A = var_00[[var_02.var_920F]](var_03);
      } else {
        var_0A = var_02[[var_03.var_920F]]();
      }
    }

    return 1;
  }

  return 0;
}

wave_management_think() {
  self endon("fight_complete");
  self.wave_management = spawnStruct();
  if(!isDefined(self.wave_management.expected_zombies)) {
    self.wave_management.expected_zombies = [];
  }

  while(isalive(self)) {
    self waittill("phase_wave_management_update");
    thread wave_management_living_think();
  }
}

wave_management_living_think() {
  self endon("phase_wave_management_update");
  foreach(var_01 in self.wave_management.expected_zombies) {
    childthread manage_respawn(var_01);
  }
}

manage_respawn(param_00) {
  var_01 = undefined;
  var_02 = common_scripts\utility::func_46B7("zone_citadel_spawners", "targetname");
  var_03 = undefined;
  for(;;) {
    if(!isDefined(var_01)) {
      var_03 = lib_054D::func_90BA(param_00, common_scripts\utility::func_7A33(var_02), "final boss fight", 0, 1, 1);
      if(!isDefined(var_03)) {
        wait(1);
        continue;
      }
    }

    while(isDefined(var_03.var_BC) && var_03.var_BC > 0) {
      wait 0.05;
    }

    wait(get_respawn_times());
  }
}

get_respawn_times() {
  var_00 = 5;
  switch (level.var_744A.size) {
    case 1:
      var_00 = 16;
      break;

    case 2:
      var_00 = 12;
      break;

    case 3:
      var_00 = 10;
      break;

    case 4:
      var_00 = 8;
      break;

    default:
      break;
  }

  return var_00;
}

wave_management_set(param_00) {
  var_01 = undefined;
  switch (param_00) {
    case 0:
      var_01 = ::phase0_wave_management;
      break;

    case 1:
      var_01 = ::phase1_wave_management;
      break;

    case 2:
      var_01 = ::phase2_wave_management;
      break;

    case 3:
      var_01 = ::phase3_wave_management;
      break;

    case 4:
      var_01 = ::phase4_wave_management;
      break;

    default:
      break;
  }

  if(common_scripts\utility::func_3794("phase_transition_active")) {
    common_scripts\utility::func_37A1("phase_transition_active");
  }

  self notify("phase_wave_management_update");
  if(isDefined(var_01)) {
    [[var_01]]();
  }
}

phase0_wave_management() {
  self endon("phase_wave_management_update");
  var_00 = getEntArray("zone_citadel_spawners", "targetname");
  var_01 = undefined;
  switch (level.var_744A.size) {
    case 1:
      var_01 = ["zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_berserker", "zombie_berserker"];
      break;

    case 2:
      var_01 = ["zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_berserker", "zombie_berserker"];
      break;

    case 3:
      var_01 = ["zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_berserker", "zombie_berserker"];
      break;

    case 4:
      var_01 = ["zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_berserker", "zombie_berserker"];
      break;

    default:
      break;
  }

  self.wave_management.expected_zombies = var_01;
}

phase1_wave_management() {
  self endon("phase_wave_management_update");
  var_00 = getEntArray("zone_citadel_spawners", "targetname");
  var_01 = undefined;
  switch (level.var_744A.size) {
    case 1:
      var_01 = ["zombie_generic", "zombie_generic", "zombie_berserker", "zombie_berserker", "zombie_berserker", "zombie_exploder"];
      break;

    case 2:
      var_01 = ["zombie_generic", "zombie_generic", "zombie_generic", "zombie_berserker", "zombie_berserker", "zombie_berserker", "zombie_exploder"];
      break;

    case 3:
      var_01 = ["zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_berserker", "zombie_berserker", "zombie_berserker", "zombie_exploder", "zombie_exploder"];
      break;

    case 4:
      var_01 = ["zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_berserker", "zombie_berserker", "zombie_berserker", "zombie_berserker", "zombie_exploder", "zombie_exploder"];
      break;

    default:
      break;
  }

  self.wave_management.expected_zombies = var_01;
}

phase2_wave_management() {
  self endon("phase_wave_management_update");
  var_00 = getEntArray("zone_citadel_spawners", "targetname");
  var_01 = undefined;
  switch (level.var_744A.size) {
    case 1:
      var_01 = ["zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_berserker", "zombie_exploder", "zombie_heavy"];
      break;

    case 2:
      var_01 = ["zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_berserker", "zombie_berserker", "zombie_exploder", "zombie_heavy", "zombie_heavy"];
      break;

    case 3:
      var_01 = ["zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_berserker", "zombie_berserker", "zombie_exploder", "zombie_exploder", "zombie_heavy", "zombie_heavy", "zombie_heavy"];
      break;

    case 4:
      var_01 = ["zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_berserker", "zombie_berserker", "zombie_exploder", "zombie_exploder", "zombie_heavy", "zombie_heavy", "zombie_heavy", "zombie_heavy"];
      break;

    default:
      break;
  }

  self.wave_management.expected_zombies = var_01;
}

phase3_wave_management() {
  self endon("phase_wave_management_update");
  var_00 = getEntArray("zone_citadel_spawners", "targetname");
  var_01 = undefined;
  switch (level.var_744A.size) {
    case 1:
      var_01 = ["zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_exploder", "zombie_exploder", "zombie_dlc4"];
      break;

    case 2:
      var_01 = ["zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_berserker", "zombie_berserker", "zombie_exploder", "zombie_exploder", "zombie_dlc4"];
      break;

    case 3:
      var_01 = ["zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_berserker", "zombie_berserker", "zombie_berserker", "zombie_heavy", "zombie_exploder", "zombie_exploder", "zombie_exploder", "zombie_dlc4", "zombie_dlc4"];
      break;

    case 4:
      var_01 = ["zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_berserker", "zombie_berserker", "zombie_berserker", "zombie_berserker", "zombie_heavy", "zombie_heavy", "zombie_exploder", "zombie_exploder", "zombie_exploder", "zombie_exploder", "zombie_dlc4", "zombie_dlc4", "zombie_dlc4"];
      break;

    default:
      break;
  }

  self.wave_management.expected_zombies = var_01;
}

phase4_wave_management() {
  self endon("phase_wave_management_update");
  var_00 = getEntArray("zone_citadel_spawners", "targetname");
  var_01 = [];
  self.wave_management.expected_zombies = var_01;
}

phase5_wave_management() {
  self endon("phase_wave_management_update");
  var_00 = getEntArray("zone_citadel_spawners", "targetname");
  var_01 = undefined;
  switch (level.var_744A.size) {
    case 1:
      var_01 = ["zombie_dlc4", "zombie_dlc4"];
      break;

    case 2:
      var_01 = ["zombie_dlc4", "zombie_dlc4", "zombie_dlc4"];
      break;

    case 3:
      var_01 = ["zombie_dlc4", "zombie_dlc4", "zombie_dlc4", "zombie_dlc4"];
      break;

    case 4:
      var_01 = ["zombie_dlc4", "zombie_dlc4", "zombie_dlc4", "zombie_dlc4"];
      break;

    default:
      break;
  }

  self.wave_management.expected_zombies = var_01;
}

phase6_wave_management() {
  self endon("phase_wave_management_update");
  var_00 = getEntArray("zone_citadel_spawners", "targetname");
  var_01 = undefined;
  switch (level.var_744A.size) {
    case 1:
      var_01 = ["zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_berserker", "zombie_berserker", "zombie_exploder", "zombie_exploder"];
      break;

    case 2:
      var_01 = ["zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_berserker", "zombie_berserker", "zombie_heavy", "zombie_exploder", "zombie_exploder"];
      break;

    case 3:
      var_01 = ["zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_berserker", "zombie_berserker", "zombie_berserker", "zombie_heavy", "zombie_exploder", "zombie_exploder", "zombie_exploder"];
      break;

    case 4:
      var_01 = ["zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_berserker", "zombie_berserker", "zombie_berserker", "zombie_berserker", "zombie_heavy", "zombie_heavy", "zombie_heavy", "zombie_exploder", "zombie_exploder", "zombie_exploder", "zombie_exploder"];
      break;

    default:
      break;
  }

  self.wave_management.expected_zombies = var_01;
}

special_geist_blast_try() {
  var_00 = self;
  return 1;
}

special_geist_blast_start() {
  var_00 = self;
  var_00.current_blast = spawnStruct();
}

special_geist_blast_think() {
  var_00 = self;
  if(var_00 king_try_interrupted_by_pain()) {
    return 1;
  }

  var_01 = lib_0547::func_5565(var_00.current_blast.rotation_target, var_00.rotation_target);
  var_02 = var_00 king_enemy_target_is_valid(var_00.current_blast.var_1A2);
  var_03 = var_00 king_is_in_or_waiting_for_scripted_state("geist_blast");
  if(!var_02) {
    var_04 = var_00.current_blast.var_1A2;
    if(!var_02) {
      var_00 notify("blast_target_lost");
      var_04 = var_00 king_get_enemy_target();
    }

    if(isDefined(var_04)) {
      var_00.current_blast.rotation_target = var_00 create_rotation_target_ent(var_04);
      var_00 set_rotation_target(var_00.current_blast.rotation_target);
      var_00.current_blast.var_1A2 = var_04;
      var_00.current_blast.last_known_target_origin = var_00.current_blast.var_1A2.var_116;
      var_00 thread special_geist_blast_tracking();
    }
  }

  if(!common_scripts\utility::func_562E(var_00.current_blast.anim_state_completed)) {
    if(var_01 && var_02) {
      if(!var_03) {
        var_00 thread lib_0547::func_7D1A("geist_blast", undefined, undefined, [var_00, "stand_pain_interrupt"]);
      }
    }
  } else {
    return 1;
  }

  return 0;
}

special_geist_blast_tracking() {
  var_00 = self;
  var_00 endon("death");
  var_00 endon("geist_blast_end");
  while(isDefined(var_00) && isDefined(var_00.current_blast)) {
    var_01 = var_00 king_enemy_target_is_valid(var_00.current_blast.var_1A2);
    if(var_01 && !lib_0547::func_5565(var_00.current_blast.rotation_locked, 1)) {
      var_00.current_blast.rotation_target.var_116 = var_00.current_blast.var_1A2.var_116;
      var_00.current_blast.last_known_target_origin = var_00.current_blast.var_1A2.var_116;
    }

    wait(0.2);
  }
}

special_geist_blast_end() {
  var_00 = self;
  var_00.current_blast = undefined;
  var_00 notify("geist_blast_end");
}

anim_state_geist_blast_run() {
  var_00 = self;
  var_00 endon("geist_blast_end");
  if(!isDefined(var_00.current_blast)) {
    return;
  }

  var_00 pause_manual_move();
  var_00 start_manual_rotation();
  var_00 disable_geist_bullet_shield();
  var_01 = maps\mp\agents\_scripted_agent_anim_util::func_434D("geist_bolt");
  var_02 = maps\mp\agents\_scripted_agent_anim_util::func_7A35(var_01);
  var_00.fx_blast_hand = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_gk_geistblast_buildup"), var_00, "J_Wrist_LE");
  var_00.fx_blast_hand lib_0378::func_8D74("god_king_giestblast_charge");
  var_00 king_handle_attached_vfx_cleanup(var_00.fx_blast_hand, 1);
  triggerfx(var_00.fx_blast_hand);
  var_00 thread blast_tracking_notetrack();
  maps\mp\agents\_scripted_agent_anim_util::func_71FA(var_01, var_02, 1, "king_attack", "premature_end", ::geist_blast_handle_notetracks);
  var_00.fx_blast_hand delete();
  var_00.fx_blast_hand = undefined;
  var_00.current_blast.anim_state_completed = 1;
}

blast_tracking_notetrack() {
  var_00 = self;
  var_00 endon("death");
  var_00 endon("geist_blast_end");
  maps\mp\agents\_scripted_agent_anim_util::func_A79E("king_attack", "stop_tracking", "geist_bolt");
  if(!isDefined(var_00.current_blast)) {
    return;
  }

  var_00.current_blast.rotation_locked = 1;
}

anim_state_geist_blast_end() {
  var_00 = self;
  var_00 pause_manual_rotation();
  var_00 pause_manual_move();
}

geist_blast_handle_notetracks(param_00, param_01, param_02, param_03) {
  switch (param_00) {
    case "bolt_throw":
      thread geist_blast_throw();
      break;
  }
}

geist_blast_throw() {
  var_00 = self;
  var_01 = var_00.current_blast.last_known_target_origin;
  var_02 = var_00 gettagorigin("J_Wrist_LE");
  var_03 = magicbullet("geist_blast_red", var_02, var_01, var_00, 1, 1);
  var_03.var_117 = var_00;
  var_00.current_blast.var_776C = var_03;
  var_03 thread geist_blast_zombie_damage();
  lib_0378::func_8D74("god_king_giestblast_throw", var_03, var_00);
  if(isDefined(level.ice_blocks)) {
    var_03 thread maps\mp\mp_zombie_descent_ee_main::test_ice_block_projectile_hit(var_00);
  }

  var_00 pause_manual_rotation();
}

geist_blast_player(param_00, param_01) {
  var_02 = self;
  var_03 = magicbullet("geist_blast_red", param_00, param_01, var_02, 1, 1);
  var_03.var_117 = var_02;
  var_03 thread geist_blast_zombie_damage();
  var_03 thread notify_on_notification("blast_failed", var_02, "disconnect");
}

notify_on_notification(param_00, param_01, param_02) {
  self endon("death");
  param_01 waittill(param_02);
  if(isDefined(self)) {
    self notify(param_00);
  }
}

geist_blast_zombie_damage() {
  var_00 = self;
  self endon("blast_reflected");
  self endon("blast_failed");
  var_00 waittill("explode", var_01);
  var_02 = var_00.var_117;
  if(isDefined(var_02.current_blast) && isDefined(var_02.current_blast.var_776C)) {
    var_02.current_blast.var_776C = undefined;
  }

  var_03 = lib_0547::func_408F();
  var_03 = function_01AC(var_03, var_01, 256);
  foreach(var_05 in var_03) {
    if(!isDefined(var_05.var_A4B) || lib_0547::func_5565(var_05, var_02)) {
      continue;
    }

    if(isDefined(var_05.isempowered)) {
      continue;
    }

    if(distance2d(var_05.var_116, var_01) <= 64) {
      if(lib_0547::func_5565(level.zombie_king, var_05)) {
        var_05 dodamage(1800, var_02.var_116, var_02, var_02, "MOD_EXPLOSIVE", "geist_blast_red");
      } else {
        var_05 dodamage(var_05.var_BC + 666, var_02.var_116, var_02, var_02, "MOD_EXPLOSIVE", "geist_blast_red");
      }

      continue;
    }

    if(distance2d(var_05.var_116, var_01) <= 128) {
      if(lib_0547::func_5565(level.zombie_king, var_05)) {
        var_05 dodamage(1200, var_02.var_116, var_02, var_02, "MOD_EXPLOSIVE", "geist_blast_red");
      } else {
        var_05 dodamage(var_05.var_FB * 0.66, var_02.var_116, var_02, var_02, "MOD_EXPLOSIVE", "geist_blast_red");
      }

      if(isDefined(var_05.var_A4B)) {
        var_06 = lib_0547::func_A51(var_05.var_A4B);
        if(isDefined(var_06) && common_scripts\utility::func_562E(var_06.knockbybladebarbarossa)) {
          lib_0547::func_7D1B(var_02, var_05, "medium");
        }
      }

      continue;
    }

    if(distance2d(var_05.var_116, var_01) <= 256) {
      if(lib_0547::func_5565(level.zombie_king, var_05)) {
        var_05 dodamage(600, var_02.var_116, var_02, var_02, "MOD_EXPLOSIVE", "geist_blast_red");
      } else {
        var_05 dodamage(var_05.var_FB * 0.33, var_02.var_116, var_02, var_02, "MOD_EXPLOSIVE", "geist_blast_red");
      }

      if(isDefined(var_05.var_A4B)) {
        var_06 = lib_0547::func_A51(var_05.var_A4B);
        if(isDefined(var_06) && common_scripts\utility::func_562E(var_06.knockbybladebarbarossa)) {
          lib_0547::func_7D1B(var_02, var_05, "far");
        }
      }
    }
  }
}

special_geist_lightning_try() {
  var_00 = self;
  return 1;
}

special_geist_lightning_start() {
  var_00 = self;
  var_00.current_lightning = spawnStruct();
}

special_geist_lightning_think() {
  var_00 = self;
  if(var_00 king_try_interrupted_by_pain()) {
    return 1;
  }

  var_01 = lib_0547::func_5565(var_00.current_lightning.rotation_target, var_00.rotation_target);
  var_02 = var_00 king_enemy_target_is_valid(var_00.current_lightning.var_1A2);
  var_03 = var_00 king_is_in_or_waiting_for_scripted_state("geist_lightning");
  if(!var_01 || !var_02) {
    var_04 = var_00.current_lightning.var_1A2;
    if(!var_02) {
      var_04 = var_00 king_get_enemy_target();
    }

    if(isDefined(var_04)) {
      var_00.current_lightning.rotation_target = var_00 create_rotation_target_ent(var_04);
      var_00 set_rotation_target(var_00.current_lightning.rotation_target);
      var_00.current_lightning.var_1A2 = var_04;
    }
  }

  if(!var_02) {
    if(!isDefined(var_00.current_lightning.invalid_target_time)) {
      var_00.current_lightning.invalid_target_time = gettime();
    } else if(gettime() - var_00.current_lightning.invalid_target_time > 2000) {
      var_00 notify("invalid_target_interrupt");
      return 1;
    }
  } else {
    var_00.current_lightning.invalid_target_time = undefined;
    var_00.current_lightning.last_known_target = var_00.current_lightning.var_1A2;
  }

  if(!common_scripts\utility::func_562E(var_00.current_lightning.anim_state_completed)) {
    if(var_01 && var_02) {
      if(!var_03) {
        var_00 thread lib_0547::func_7D1A("geist_lightning");
      }
    }
  } else {
    return 1;
  }

  return 0;
}

special_geist_lightning_end() {
  var_00 = self;
  var_00.current_lightning = undefined;
  var_00 notify("geist_lightning_end");
}

anim_state_geist_lightning_run() {
  var_00 = self;
  var_00 endon("geist_lightning_end");
  if(!isDefined(var_00.current_lightning)) {
    return;
  }

  var_00 pause_manual_move();
  var_00 start_manual_rotation();
  var_00 disable_geist_bullet_shield();
  var_01 = maps\mp\agents\_scripted_agent_anim_util::func_434D("geist_lightning");
  var_02 = maps\mp\agents\_scripted_agent_anim_util::func_7A35(var_01);
  var_00.fx_lightning_hand = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_blood_zmb_bolt"), var_00, "J_Wrist_RI");
  var_00 king_handle_attached_vfx_cleanup(var_00.fx_lightning_hand, 1);
  triggerfx(self.fx_lightning_hand);
  var_00.fx_lightning_hand lib_0378::func_8D74("god_king_lightning_summon");
  maps\mp\agents\_scripted_agent_anim_util::func_71FA(var_01, var_02, 1, "king_attack", "end", ::geist_lightning_handle_notetracks);
  var_00.current_lightning.anim_state_completed = 1;
  var_00.fx_lightning_hand delete();
  var_00.fx_lightning_hand = undefined;
}

anim_state_geist_lightning_end() {
  var_00 = self;
  var_00 pause_manual_rotation();
  var_00 pause_manual_move();
}

geist_lightning_handle_notetracks(param_00, param_01, param_02, param_03) {
  switch (param_00) {
    case "cast":
      thread geist_lightning_throw();
      break;
  }
}

geist_lightning_throw() {
  var_00 = self;
  if(king_enemy_target_is_valid(var_00.current_lightning.var_1A2)) {
    var_01 = var_00.current_lightning.var_1A2;
    var_02 = var_00.current_lightning.var_1A2.var_116;
    var_03 = var_00 gettagorigin("J_Wrist_LE");
    var_01 thread geist_lightning_shot(var_00);
  }

  var_00 pause_manual_rotation();
}

geist_lightning_shot(param_00) {
  var_01 = self;
  var_01.islightningtarget = 1;
  var_02 = geist_lighting_collect_subsequent_victims(var_01);
  try_lightning(param_00, var_02);
  foreach(var_01 in var_02) {
    if(isalive(var_01)) {
      var_01.islightningtarget = undefined;
    }
  }
}

geist_lighting_collect_subsequent_victims(param_00) {
  var_01 = [param_00];
  var_02 = undefined;
  for(var_03 = 0; var_03 <= 4; var_03++) {
    var_02 = var_01[var_03] get_next_lightning_target();
    if(!isDefined(var_02)) {
      break;
    }

    var_02.islightningtarget = 1;
    var_01[var_01.size] = var_02;
  }

  return var_01;
}

try_lightning(param_00, param_01) {
  var_02 = 0;
  var_03 = 0;
  var_04 = undefined;
  var_05 = [];
  foreach(var_07 in param_01) {
    var_02 = var_02 + 1;
    if(isPlayer(var_07)) {
      var_03 = var_03 + 1;
    }
  }

  if(var_03 <= 0) {
    var_03 = 1;
  }

  if(common_scripts\utility::func_562E(param_00.issolomode)) {
    var_09 = var_02 - 2 / 1.5 / var_03;
  } else {
    var_09 = var_03 - 2 / level.var_744A.size / var_04;
  }

  var_0A = var_09 / param_01.size;
  if(var_0A < 0.4) {
    var_0A = 0.4;
  }

  foreach(var_07 in param_01) {
    if(!isDefined(var_04)) {
      var_0C = "J_Wrist_RI";
      var_0D = param_00;
      var_0E = var_0C;
    } else {
      var_0D = var_04;
      var_0E = "J_Spine4";
    }

    var_0F = var_07;
    var_10 = "J_Spine4";
    var_11 = undefined;
    if(isDefined(level.ice_blocks)) {
      var_11 = maps\mp\mp_zombie_descent_ee_main::test_ice_block_bullettrace_hit(var_0D gettagorigin(var_0E), var_0F gettagorigin(var_10));
    }

    var_12 = undefined;
    if(lib_0547::func_5565(var_11[0], 1)) {
      var_0F = common_scripts\utility::func_8FFC();
      var_0F thread delete_time(0.2);
      var_0F.var_116 = var_11[1];
      var_0F method_805B();
      var_10 = "TAG_ORIGIN";
      var_12 = 1;
    }

    var_13 = launchbeam("zmb_geistkraft_godking_lightning_beam", var_0D, var_0E, var_0F, var_10);
    var_13 thread delete_time(0.1);
    playFXOnTag(common_scripts\utility::func_44F5("zmb_giestkraft_impact"), var_07, "J_spine4");
    param_00 lib_0378::func_8D74("god_king_lightning");
    if(lib_0547::func_5565(var_12, 1)) {
      return;
    }

    if(lib_0547::func_5565(level.ravenweaponmanager["shield_emp"].var_117, var_07) && var_07 maps\mp\zombies\weapons\_zombie_dlc4_melee::shield_block_test_func(param_00)) {
      return;
    }

    var_04 = var_07;
    var_05[var_05.size] = var_07;
  }

  foreach(var_07 in var_05) {
    var_07 dodamage(var_07.var_FB * var_0A, self.var_116, param_00, param_00, "MOD_ENERGY");
    if(isDefined(var_07.var_A4B)) {
      var_16 = lib_0547::func_A51(var_07.var_A4B);
      if(isDefined(var_16) && common_scripts\utility::func_562E(var_16.knockbybladebarbarossa)) {
        lib_0547::func_7D1B(param_00, var_07, "medium");
      }
    }
  }
}

special_geist_bombs_try() {
  var_00 = self;
  return 1;
}

special_geist_bombs_start() {
  var_00 = self;
  var_00.current_bombs = spawnStruct();
}

special_geist_bombs_think() {
  var_00 = self;
  if(var_00 king_try_interrupted_by_pain()) {
    return 1;
  }

  var_01 = lib_0547::func_5565(var_00.current_bombs.rotation_target, var_00.rotation_target);
  var_02 = var_00 king_enemy_target_is_valid(var_00.current_bombs.var_1A2);
  var_03 = var_00 king_is_in_or_waiting_for_scripted_state("geist_bomb");
  if(!var_01 || !var_02) {
    var_04 = var_00.current_bombs.var_1A2;
    if(!var_02) {
      var_04 = var_00 king_get_enemy_target();
    }

    if(isDefined(var_04)) {
      var_00.current_bombs.rotation_target = var_00 create_rotation_target_ent(var_04);
      var_00 set_rotation_target(var_00.current_bombs.rotation_target);
      var_00.current_bombs.var_1A2 = var_04;
    }
  }

  if(!var_02) {
    if(!isDefined(var_00.current_bombs.invalid_target_time)) {
      var_00.current_bombs.invalid_target_time = gettime();
    } else if(gettime() - var_00.current_bombs.invalid_target_time > 2000) {
      var_00 notify("invalid_target_interrupt");
      return 1;
    }
  } else {
    var_00.current_bombs.invalid_target_time = undefined;
    var_00.current_bombs.last_known_target_origin = var_00.current_bombs.var_1A2.var_116;
  }

  if(!common_scripts\utility::func_562E(var_00.current_bombs.anim_state_completed)) {
    if(var_01 && var_02) {
      if(!var_03) {
        var_00 thread lib_0547::func_7D1A("geist_bomb");
      }
    }
  } else {
    return 1;
  }

  return 0;
}

special_geist_bombs_end() {
  var_00 = self;
  var_00.current_bombs = undefined;
  var_00 notify("geist_bombs_end");
}

anim_state_geist_bombs_run() {
  var_00 = self;
  var_00 endon("geist_bombs_end");
  if(!isDefined(var_00.current_bombs)) {
    return;
  }

  var_00 pause_manual_move();
  var_00 start_manual_rotation();
  var_00 disable_geist_bullet_shield();
  var_01 = maps\mp\agents\_scripted_agent_anim_util::func_434D("geist_bombs");
  var_02 = maps\mp\agents\_scripted_agent_anim_util::func_7A35(var_01);
  maps\mp\agents\_scripted_agent_anim_util::func_71FA(var_01, var_02, 1, "king_attack", "end", ::geist_bombs_handle_notetracks);
  var_00.current_bombs.anim_state_completed = 1;
}

anim_state_geist_bombs_end() {
  var_00 = self;
  var_00 pause_manual_rotation();
  var_00 pause_manual_move();
}

geist_bombs_handle_notetracks(param_00, param_01, param_02, param_03) {
  switch (param_00) {
    case "bomb_throw":
      level.zombie_king thread geist_bombs_throw();
      break;
  }
}

geist_bombs_throw(param_00) {
  var_01 = "TAG_WEAPON_CHEST";
  if(!lib_0547::func_5565(level.zombie_king, self)) {
    var_01 = "TAG_ORIGIN";
  }

  if(isDefined(param_00)) {
    var_02 = param_00.var_116;
  } else {
    var_02 = self.current_bombs.last_known_target_origin;
  }

  var_03 = self;
  if(!lib_0547::func_5565(level.zombie_king, self)) {
    var_03 = undefined;
  }

  thread vo_play_gdk_ability_line("geist_bomb_toss");
  var_04 = get_bomb_start_pos(var_01);
  var_05 = magicartillery("geist_bomb_artil", var_04, var_02, 2, var_04[2] + 50, var_03);
  var_05 thread geist_bombs_projectile_think(var_03);
  wait(0.1);
  var_04 = get_bomb_start_pos(var_01);
  var_06 = magicartillery("geist_bomb_artil", var_04, var_02 + (200, 0, 0), 2, var_04[2] + 50, var_03);
  var_06 thread geist_bombs_projectile_think(var_03);
  wait(0.1);
  var_04 = get_bomb_start_pos(var_01);
  var_07 = magicartillery("geist_bomb_artil", var_04, var_02 + (33, 200, 0), 2, var_04[2] + 50, var_03);
  var_07 thread geist_bombs_projectile_think(var_03);
  wait(0.1);
  var_04 = get_bomb_start_pos(var_01);
  var_08 = magicartillery("geist_bomb_artil", var_04, var_02 + (33, -200, 0), 2, var_04[2] + 50, var_03);
  var_08 thread geist_bombs_projectile_think(var_03);
  wait(0.1);
  var_04 = get_bomb_start_pos(var_01);
  var_09 = magicartillery("geist_bomb_artil", var_04, var_02 + (-200, 66, 0), 2, var_04[2] + 50, var_03);
  var_09 thread geist_bombs_projectile_think(var_03);
  wait(0.1);
  var_04 = get_bomb_start_pos(var_01);
  var_0A = magicartillery("geist_bomb_artil", var_04, var_02 + (-200, -66, 0), 2, var_04[2] + 50, var_03);
  var_0A thread geist_bombs_projectile_think(var_03);
  if(!lib_0547::func_5565(level.zombie_king, self)) {
    return;
  }

  pause_manual_rotation();
}

get_bomb_start_pos(param_00) {
  var_01 = self gettagorigin(param_00);
  return var_01;
}

geist_bombs_projectile_think(param_00) {
  var_01 = self;
  lib_0378::func_8D74("god_king_giestbomb_projectile", "spawn", var_01);
  var_01 waittill("explode", var_02);
  geist_bombs_static_think(var_02);
}

geist_bombs_static_think(param_00) {
  var_01 = getgroundposition(param_00, 12);
  var_02 = common_scripts\utility::func_8FFC();
  var_02 method_805B();
  var_02.var_116 = var_01 + (0, 0, 25);
  var_03 = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_bomb_sphere"), var_02, "tag_origin");
  var_04 = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_godking_giestbomb"), var_02, "tag_origin");
  var_05 = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_godking_giestbomb_prime"), var_02, "tag_origin");
  thread show_bomb_vfx(var_04, var_03, var_05);
  lib_0378::func_8D74("god_king_giestbomb_projectile", "activate", var_02);
  wait(6);
  playFXOnTag(common_scripts\utility::func_44F5("zmb_giestbomb_exp_1shot"), var_02, "TAG_ORIGIN");
  lib_0378::func_8D74("god_king_giestbomb_projectile", "explode", var_02);
  var_06 = lib_0547::func_408F();
  var_07 = level.var_744A;
  var_08 = common_scripts\utility::func_F73(var_06, var_07);
  foreach(var_0A in var_08) {
    if(distance2d(var_0A.var_116, param_00) <= 160) {
      var_0A dodamage(100, param_00, level.zombie_king, level.zombie_king, "MOD_EXPLOSIVE", "geist_bomb_artil");
    }
  }

  if(isDefined(level.ice_blocks)) {
    var_0C = maps\mp\mp_zombie_descent_ee_main::test_ice_block_explosion_hit(var_02.var_116, 160);
  }

  wait 0.05;
  var_02 delete();
}

show_bomb_vfx(param_00, param_01, param_02) {
  triggerfx(param_00);
  triggerfx(param_01);
  wait(2);
  triggerfx(param_02);
  wait(4);
  param_01 delete();
  param_00 delete();
  param_02 delete();
}

special_detonate_try() {
  var_00 = self;
  var_01 = lib_0547::func_408F();
  var_02 = common_scripts\utility::func_F93(var_01, var_00);
  var_03 = [];
  foreach(var_00 in var_02) {
    if(var_00 lib_0547::func_4B2C()) {
      var_03[var_03.size] = var_00;
    }
  }

  if(var_03.size > 0) {
    return 1;
  }

  return 0;
}

special_detonate_start() {
  var_00 = self;
  var_00.current_detonate = spawnStruct();
}

special_detonate_think() {
  var_00 = self;
  if(var_00 king_try_interrupted_by_pain()) {
    return 1;
  }

  var_01 = lib_0547::func_5565(var_00.current_detonate.rotation_target, var_00.rotation_target);
  var_02 = var_00 king_enemy_target_is_valid(var_00.current_detonate.var_1A2);
  var_03 = var_00 king_is_in_or_waiting_for_scripted_state("detonate");
  if(!var_01 || !var_02) {
    var_04 = var_00.current_detonate.var_1A2;
    if(!var_02) {
      var_04 = var_00 king_get_detonate_target();
    }

    if(isDefined(var_04)) {
      var_00.current_detonate.rotation_target = var_00 create_rotation_target_ent(var_04);
      var_00 set_rotation_target(var_00.current_detonate.rotation_target);
      var_00.current_detonate.var_1A2 = var_04;
    }
  }

  if(!var_02) {
    if(!isDefined(var_00.current_detonate.invalid_target_time)) {
      var_00.current_detonate.invalid_target_time = gettime();
    } else if(gettime() - var_00.current_detonate.invalid_target_time > 2000) {
      var_00 notify("invalid_target_interrupt");
      return 1;
    }
  } else {
    var_00.current_detonate.invalid_target_time = undefined;
    var_00.current_detonate.last_known_target = var_00.current_detonate.var_1A2;
  }

  if(!common_scripts\utility::func_562E(var_00.current_detonate.anim_state_completed)) {
    if(var_01 && var_02) {
      if(!var_03) {
        var_00 thread lib_0547::func_7D1A("detonate");
      }
    }
  } else {
    return 1;
  }

  return 0;
}

special_detonate_end() {
  var_00 = self;
  var_00.current_detonate = undefined;
  var_00 notify("detonate_end");
}

anim_state_detonate_run() {
  var_00 = self;
  var_00 endon("detonate_end");
  if(!isDefined(var_00.current_detonate)) {
    return;
  }

  var_00 pause_manual_move();
  var_00 start_manual_rotation();
  var_00 disable_geist_bullet_shield();
  var_01 = maps\mp\agents\_scripted_agent_anim_util::func_434D("detonate");
  var_02 = maps\mp\agents\_scripted_agent_anim_util::func_7A35(var_01);
  var_00 lib_0378::func_8D74("god_king_detonate_cast");
  maps\mp\agents\_scripted_agent_anim_util::func_71FA(var_01, var_02, 1, "king_attack", "end", ::detonate_handle_notetracks);
  var_00.current_detonate.anim_state_completed = 1;
}

anim_state_detonate_end() {
  var_00 = self;
  var_00 pause_manual_rotation();
  var_00 pause_manual_move();
}

detonate_handle_notetracks(param_00, param_01, param_02, param_03) {
  switch (param_00) {
    case "detonate_start":
      thread detonate_throw();
      break;
  }
}

detonate_throw() {
  var_00 = self;
  if(king_enemy_target_is_valid(var_00.current_detonate.var_1A2)) {
    var_01 = var_00.current_detonate.var_1A2;
    var_02 = launchbeam("zmb_geistkraft_reg_beam_med", var_00, "J_Wrist_RI", var_01, "J_Spine4");
    lib_0378::func_8D74("god_king_detonate_throw", var_01);
    var_02 thread delete_time(0.45);
    var_01 thread detonate_victim(var_00);
  }

  var_00 pause_manual_rotation();
}

delete_time(param_00) {
  wait(param_00);
  self delete();
}

delete_on_parent_notify(param_00, param_01) {
  self endon("death");
  param_00 waittill(param_01);
  self delete();
}

detonate_victim(param_00) {
  var_01 = self;
  var_01 endon("death");
  var_01.isempowered = 1;
  var_01.fuze_fx = spawnlinkedfx(level.var_611["zmf_corpse_eater_smoldering"], var_01, "J_Spine4");
  triggerfx(var_01.fuze_fx);
  var_01 lib_0378::func_8D74("aud_corpse_eater_fully_charged");
  var_01 maps\mp\agents\_agent_utility::deleteentonagentdeath(var_01.fuze_fx);
  wait(10);
  thread try_detonation(param_00);
}

try_detonation(param_00) {
  if(isDefined(self.fuze_fx)) {
    self.fuze_fx delete();
  }

  var_01 = self gettagorigin("J_Spine4");
  playFX(level.var_611["zmb_corpse_eater_detonate"], var_01);
  lib_0378::func_8D74("aud_corpse_eater_explosion");
  if(common_scripts\utility::func_562E(self.isforceshieldactive)) {
    break_force_shield();
  }

  if(isDefined(self.isempowered)) {
    self.isempowered = undefined;
  }

  self dodamage(self.var_BC + 666, self.var_116, param_00, param_00, "MOD_ENERGY");
  radiusdamage(self.var_116, 200, 200, 160, param_00, "MOD_ENERGY", "corpse_eater_dlc4_zm", 1);
  if(isDefined(level.ice_blocks)) {
    var_02 = maps\mp\mp_zombie_descent_ee_main::test_ice_block_explosion_hit(self.var_116, 200);
  }
}

zombie_detonate_clear_property(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(common_scripts\utility::func_562E(self.isempowered)) {
    self.isempowered = undefined;
  }

  if(common_scripts\utility::func_3C77("flag_boss_complete")) {
    lib_0547::func_2D8C(::zombie_detonate_clear_property);
  }
}

special_geist_pull_try() {
  var_00 = self;
  return 1;
}

special_geist_pull_start() {
  var_00 = self;
  var_00.current_pull = spawnStruct();
  var_01 = get_boss_pull_position(var_00);
  var_00 enable_geist_bullet_shield();
  var_00.current_pull.var_2DA7 = king_create_destination(var_01, 1455);
}

special_geist_pull_think() {
  var_00 = self;
  var_01 = king_has_arrived(var_00.current_pull.var_2DA7);
  if(!var_01) {
    king_continue_moving(var_00.current_pull.var_2DA7);
  }

  var_02 = lib_0547::func_5565(var_00.current_pull.rotation_target, var_00.rotation_target);
  var_03 = var_00 king_enemy_target_is_valid(var_00.current_pull.var_1A2);
  var_04 = var_00 king_is_in_or_waiting_for_scripted_state("geist_pull");
  if(!var_02 || !var_03) {
    var_05 = var_00.current_pull.var_1A2;
    if(!var_03) {
      var_05 = var_00 king_get_enemy_target();
    }

    if(isDefined(var_05)) {
      var_00.current_pull.rotation_target = var_00 create_rotation_target_ent(var_05);
      var_00 set_rotation_target(var_00.current_pull.rotation_target);
      var_00.current_pull.var_1A2 = var_05;
    }
  }

  if(!var_03) {
    if(!isDefined(var_00.current_pull.invalid_target_time)) {
      var_00.current_pull.invalid_target_time = gettime();
    } else if(gettime() - var_00.current_pull.invalid_target_time > 2000) {
      var_00 notify("invalid_target_interrupt");
      return 1;
    }
  } else {
    var_00.current_pull.invalid_target_time = undefined;
    var_00.current_pull.last_known_target = var_00.current_pull.var_1A2;
  }

  if(!common_scripts\utility::func_562E(var_00.current_pull.anim_state_completed)) {
    if(var_01 && var_02 && var_03) {
      if(!var_04) {
        var_00 thread lib_0547::func_7D1A("geist_pull");
      }
    }
  } else {
    return 1;
  }

  return 0;
}

special_geist_pull_end() {
  var_00 = self;
  var_00.current_pull = undefined;
  var_00 notify("geist_pull_end");
}

anim_state_geist_pull_run() {
  var_00 = self;
  var_00 endon("geist_pull_end");
  if(!isDefined(var_00.current_pull)) {
    return;
  }

  var_00 pause_manual_move();
  var_00 start_manual_rotation();
  var_01 = maps\mp\agents\_scripted_agent_anim_util::func_434D("kneel_vortex");
  var_02 = maps\mp\agents\_scripted_agent_anim_util::func_7A35(var_01);
  var_00 lib_0378::func_8D74("god_king_pull_summon");
  maps\mp\agents\_scripted_agent_anim_util::func_71FA(var_01, var_02, 1, "king_attack", "end", ::geist_pull_handle_notetracks);
  var_00.current_pull.anim_state_completed = 1;
}

anim_state_geist_pull_end() {
  var_00 = self;
  var_00 pause_manual_rotation();
  var_00 pause_manual_move();
}

geist_pull_handle_notetracks(param_00, param_01, param_02, param_03) {
  switch (param_00) {
    case "pull_begin":
      thread geist_pull_aoe();
      break;
  }
}

geist_pull_aoe() {
  var_00 = self;
  var_01 = "TAG_WEAPON_LEFT";
  playFXOnTag(common_scripts\utility::func_44F5("zmb_pommel_energy_field_burst"), var_00, var_01);
  var_00 lib_0378::func_8D74("god_king_pull");
  var_02 = [];
  var_02 = var_00 king_get_targets_in_range(1600);
  var_00 thread spawn_attractor_nodes();
  lib_0547::func_7BA9(::boss_mind_control_fx_clear);
  if(isDefined(var_02)) {
    foreach(var_04 in var_02) {
      var_00 thread geist_pull_attack_victim(var_04, 6);
    }
  }

  lib_0547::func_2D8C(::boss_mind_control_fx_clear);
  var_00 pause_manual_rotation();
}

geist_pull_attack_victim(param_00, param_01) {
  var_02 = self;
  param_00 endon("death");
  var_02 endon("death");
  var_03 = isPlayer(param_00);
  if(var_03 && lib_0547::func_577E(param_00)) {
    return;
  }

  var_04 = param_00.var_116 + (0, 0, 32);
  var_05 = var_02.var_116 + (0, 0, 64);
  var_06 = 5;
  var_07 = 2560000;
  var_08 = 65536;
  var_09 = distance2dsquared(var_04, var_05);
  var_0A = bullettracepassed(var_04, var_05, 0, var_02, param_00);
  if(var_09 >= var_07) {
    return;
  }

  var_0B = 1 - distance2d(param_00.var_116, var_02.var_116) / 1600 - 256 / 1344;
  if(var_0B < 1) {
    var_0B = 1;
  }

  var_0C = param_01 * var_0B / 2;
  var_0D = param_01 * var_0B;
  if(common_scripts\utility::func_562E(var_0A)) {
    if(var_03 && !lib_0547::func_577E(param_00)) {
      param_00 shellshock("zm_heavy_hit", var_0D, var_0C);
      param_00 method_8308(0);
      param_00 playrumbleonentity("damage_heavy");
    }

    if(!var_03 && param_00 lib_0547::func_4B2C() && isDefined(var_02.pull_attractor.var_F6D)) {
      param_00 thread attract_to_boss(common_scripts\utility::func_7A33(var_02.pull_attractor.var_F6D));
      param_00 thread pull_mind_control_fx();
    }

    if(var_09 > var_08) {
      var_02 thread pulse_drag_in_victim(param_00);
      if(isDefined(var_02)) {
        param_00 dodamage(var_06, var_02.var_116, var_02, var_02, "MOD_CRUSH");
      }
    } else if(isDefined(var_02)) {
      param_00 dodamage(var_06, var_02.var_116, var_02, var_02, "MOD_CRUSH");
    }
  } else {}

  wait(param_01 * var_0B);
  if(var_03 && !lib_0547::func_577E(param_00)) {
    param_00 method_8308(1);
  }

  wait 0.05;
}

pulse_drag_in_victim(param_00) {
  param_00 endon("death");
  self endon("death");
  var_01 = 800;
  var_02 = self.var_116 - param_00.var_116;
  var_02 = (var_02[0], var_02[1], 0);
  var_02 = var_01 * vectornormalize(var_02);
  var_02 = (var_02[0], var_02[1], 125);
  param_00 setvelocity(var_02);
}

pull_mind_control_fx() {
  self endon("death");
  self.boss_control_fx = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_red_zmb_blind"), self, "J_Head");
  triggerfx(self.boss_control_fx);
  maps\mp\agents\_agent_utility::deleteentonagentdeath(self.boss_control_fx);
}

pull_mind_control_clear_fx() {
  if(isDefined(self.boss_control_fx)) {
    self.boss_control_fx delete();
  }
}

spawn_attractor_nodes() {
  var_00 = self;
  var_01 = common_scripts\utility::func_8FFC();
  var_02 = common_scripts\utility::func_8FFC();
  var_03 = common_scripts\utility::func_8FFC();
  var_04 = common_scripts\utility::func_8FFC();
  var_05 = common_scripts\utility::func_8FFC();
  var_01.var_116 = var_00.var_116;
  var_02.var_116 = var_00.var_116 + (115, 0, 0);
  var_03.var_116 = var_00.var_116 + (0, 115, 0);
  var_04.var_116 = var_00.var_116 + (-115, 0, 0);
  var_05.var_116 = var_00.var_116 + (0, -115, 0);
  var_01 method_8449(var_00);
  var_02 method_8449(var_01);
  var_03 method_8449(var_01);
  var_04 method_8449(var_01);
  var_05 method_8449(var_01);
  var_00.pull_attractor = var_01;
  var_00.pull_attractor.var_F6D = [var_02, var_03, var_04, var_05];
  var_00.pull_attractor thread attractor_rotate();
  var_00 common_scripts\utility::knock_off_battery("zombie_kneel", "geist_drain_result", "flame_wave_cast");
  if(isDefined(var_02)) {
    var_02 delete();
  }

  if(isDefined(var_03)) {
    var_03 delete();
  }

  if(isDefined(var_04)) {
    var_04 delete();
  }

  if(isDefined(var_05)) {
    var_05 delete();
  }

  if(isDefined(var_01)) {
    var_01 delete();
  }
}

attractor_rotate() {
  var_00 = 10;
  while(isDefined(self)) {
    self rotateby((360, 0, 0), var_00);
    wait(var_00);
  }
}

attract_to_boss(param_00) {
  var_01 = self;
  var_01 endon("death");
  if(level.var_744A.size > 0) {
    param_00.var_4883 = getclosestpointonnavmesh(param_00.var_116, level.var_744A[0]);
  } else {
    param_00.var_4883 = param_00.var_116;
  }

  var_02 = 0;
  if(isDefined(level.var_AC80) && isDefined(level.var_AC80.var_ACB3) && level.var_AC80.var_ACB3.size > 0) {
    var_02 = lib_055A::func_578A(param_00.var_4883, 1);
  }

  if(!var_02) {
    return;
  }

  while(isDefined(param_00)) {
    if(common_scripts\utility::func_562E(var_01.ignoredistractiondrones)) {
      wait 0.05;
      continue;
    }

    if(isDefined(var_01.var_3045) && var_01.var_3045 == param_00) {
      wait 0.05;
      continue;
    }

    if(isDefined(var_01.var_3044) && var_01.var_3044 >= 5) {
      if(distance(var_01.var_116, param_00.var_116) > 256) {
        var_01.var_3045 = param_00;
        var_01.var_3044 = 0;
        var_01.var_3043 = undefined;
        wait 0.05;
        continue;
      }
    }

    if(!isDefined(var_01.var_3043) || distancesquared(var_01.var_3043.var_4883, var_01.var_116) > distancesquared(param_00.var_4883, var_01.var_116)) {
      var_03 = var_01 method_857B(var_01.var_116, param_00.var_4883);
      if(var_03.size > 0) {
        var_01.var_3043 = param_00;
        var_01.var_3044 = 0;
        var_01.var_3045 = undefined;
      }
    }

    wait(0.1);
  }

  var_01 pull_mind_control_clear_fx();
}

boss_mind_control_fx_clear(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(isDefined(self.boss_control_fx)) {
    self.boss_control_fx delete();
  }
}

special_geist_sit_try() {
  var_00 = self;
  return 1;
}

special_geist_sit_start() {
  var_00 = self;
  var_00.current_sit = spawnStruct();
  var_01 = level.bossfight.throne_pos.var_116;
  var_00 enable_geist_bullet_shield();
  var_00.current_sit.var_2DA7 = king_create_destination(var_01);
  var_02 = level.bossfight.throne_pos.var_1D[1];
  var_00.current_sit.rotation_target = create_rotation_target_yaw(var_02);
  var_00 set_rotation_target(var_00.current_sit.rotation_target);
}

special_geist_sit_think() {
  var_00 = self;
  var_01 = king_has_arrived(var_00.current_sit.var_2DA7);
  if(!var_01) {
    king_continue_moving(var_00.current_sit.var_2DA7);
  }

  var_02 = var_00 king_is_in_or_waiting_for_scripted_state("sit");
  if(!common_scripts\utility::func_562E(var_00.current_sit.anim_state_completed)) {
    if(var_01) {
      if(!var_02) {
        var_00 thread lib_0547::func_7D1A("sit");
      }
    }
  } else {
    return 1;
  }

  return 0;
}

special_geist_sit_end() {
  var_00 = self;
  var_00.current_sit = undefined;
  var_00 notify("geist_sit_end");
}

anim_state_geist_sit_run() {
  var_00 = self;
  if(!isDefined(var_00.current_sit)) {
    return;
  }

  var_00 pause_manual_move();
  var_00 pause_manual_rotation();
  var_01 = maps\mp\agents\_scripted_agent_anim_util::func_434D("death_stand_2_sit");
  var_02 = maps\mp\agents\_scripted_agent_anim_util::func_7A35(var_01);
  maps\mp\agents\_scripted_agent_anim_util::func_71FA(var_01, var_02, 1, "king_attack", "end");
  var_00.king_seated = 1;
  var_00.current_sit.anim_state_completed = 1;
}

anim_state_geist_sit_end() {
  var_00 = self;
  var_00 pause_manual_rotation();
  var_00 pause_manual_move();
}

special_geist_kneel_try() {
  var_00 = self;
  return 1;
}

special_geist_kneel_start() {
  var_00 = self;
  var_00.current_kneel = spawnStruct();
  var_01 = var_00.var_116;
  var_00 enable_geist_bullet_shield();
  var_00.current_kneel.var_2DA7 = king_create_destination(var_01);
  var_00 thread vo_play_gdk_ability_line("kneel_tell");
}

special_geist_kneel_think() {
  var_00 = self;
  var_01 = king_has_arrived(var_00.current_kneel.var_2DA7);
  if(!var_01) {
    king_continue_moving(var_00.current_kneel.var_2DA7);
  }

  var_02 = var_00 king_is_in_or_waiting_for_scripted_state("kneel");
  if(!common_scripts\utility::func_562E(var_00.current_kneel.anim_state_completed)) {
    if(var_01) {
      if(!var_02) {
        var_00 thread lib_0547::func_7D1A("kneel");
      }
    }
  } else {
    return 1;
  }

  return 0;
}

special_geist_kneel_end() {
  var_00 = self;
  var_00.current_kneel = undefined;
  var_00 notify("geist_kneel_end");
}

anim_state_geist_kneel_run() {
  var_00 = self;
  var_00 endon("geist_kneel_end");
  if(!isDefined(var_00.current_kneel)) {
    return;
  }

  var_00 pause_manual_move();
  var_00 start_manual_rotation();
  var_01 = maps\mp\agents\_scripted_agent_anim_util::func_434D("kneel_burst");
  var_02 = maps\mp\agents\_scripted_agent_anim_util::func_7A35(var_01);
  lib_0378::func_8D74("god_king_force_kneel");
  var_00 thread vo_play_gdk_ability_line("kneel_execute");
  maps\mp\agents\_scripted_agent_anim_util::func_71FA(var_01, var_02, 1, "king_attack", "end", ::geist_kneel_handle_notetracks);
  var_00.current_kneel.anim_state_completed = 1;
}

anim_state_geist_kneel_end() {
  var_00 = self;
  var_00 pause_manual_rotation();
  var_00 pause_manual_move();
}

geist_kneel_handle_notetracks(param_00, param_01, param_02, param_03) {
  switch (param_00) {
    case "kneel_begin":
      thread geist_kneel_aoe();
      break;
  }
}

geist_kneel_aoe() {
  var_00 = self;
  var_01 = level.var_744A;
  var_00 notify("zombie_kneel");
  thread kill_remaining_zombies();
  foreach(var_03 in var_01) {
    var_03 thread geist_kneel_run(var_00);
  }

  var_00 pause_manual_rotation();
}

geist_kneel_run(param_00) {
  var_01 = self;
  var_01 endon("disconnect");
  var_01 common_scripts\utility::func_603();
  var_01 common_scripts\utility::func_600();
  var_01 method_8322();
  var_01 maps\mp\_utility::func_3E8E(1);
  var_01 setstance("crouch");
  var_01 setdemigod(1);
  var_01 shellshock("zm_heavy_hit", 1.4, 1);
  var_01 playrumbleonentity("damage_heavy");
  var_01 thread bow_head();
  var_01 waittill("drain_fake_start");
  var_01 thread geist_kneel_break_you(param_00);
  var_01 enable_kneel_vision();
  level common_scripts\utility::func_67EC(3, "finale_bik_outro_begin");
  var_01 notify("kill_fake_drain_beam");
  wait 0.05;
  var_01 disable_kneel_vision();
  var_01 release_from_kneel();
  var_01 setdemigod(0);
  var_01 unlink(var_01.lerpposent);
  var_01.lerpposent delete();
  var_01 maps\mp\_utility::func_3E8E(0);
  var_01 method_8323();
  var_01 lib_0586::func_78E(lib_0547::func_AB2B());
  var_01 common_scripts\utility::func_617();
  var_01 common_scripts\utility::func_614();
}

bow_head() {
  var_00 = self;
  var_01 = spawn("script_model", var_00.var_116);
  var_01 setModel("tag_origin");
  var_02 = var_00 geteyeangles();
  var_01.var_1D = var_02;
  var_00.lerpposent = var_01;
  var_00 playerlinktoblend(var_00.lerpposent, "tag_origin", 0.25);
  var_01 moveto(var_00.lerpposent.var_116, 0.05);
  wait 0.05;
  var_01 rotateto(vectortoangles(level.zombie_king gettagorigin("J_Spine4") - var_00.lerpposent.var_116), 0.1);
  wait(0.1);
  var_01 rotateto(vectortoangles(level.zombie_king gettagorigin("J_Spine4") - var_00.lerpposent.var_116) + (60, 0, 0), 0.25);
  wait(1.2);
  var_01 rotateto(vectortoangles(level.zombie_king gettagorigin("J_Spine4") - var_00.lerpposent.var_116), 2.8, 1, 1.5);
}

geist_kneel_break_you(param_00) {
  level endon("finale_bik_outro_begin");
  self endon("kneel_release");
  for(;;) {
    self dodamage(50, param_00.var_116, param_00, param_00, "MOD_ENERGY");
    wait(0.8);
  }
}

release_from_kneel() {
  self endon("death");
  self endon("kneel_release");
  level endon("finale_outro_bik_end");
  self waittill("forever");
}

kill_remaining_zombies() {
  var_00 = lib_0547::func_408F();
  foreach(var_02 in var_00) {
    if(lib_0547::func_5565(level.zombie_king, var_02)) {
      continue;
    }

    var_02 suicide();
  }
}

enable_kneel_vision() {
  if(!common_scripts\utility::func_562E(level.var_22F0)) {
    self method_8483("mp_zombie_descent_underwater", 0.05);
    self lightsetoverrideenableforplayer("mp_zombie_descent_underwater", 0.05);
  }
}

disable_kneel_vision() {
  self method_8483("", 0.05);
  self method_83C8(0.05);
}

special_geist_drain_try() {
  var_00 = self;
  return 1;
}

special_geist_drain_start() {
  var_00 = self;
  var_00.current_drain = spawnStruct();
  var_01 = var_00.var_116;
  var_00 enable_geist_bullet_shield();
  var_00.current_drain.var_2DA7 = king_create_destination(var_01);
}

special_geist_drain_think() {
  var_00 = self;
  var_01 = var_00 king_is_in_or_waiting_for_scripted_state("geist_drain");
  if(!common_scripts\utility::func_562E(var_00.current_drain.anim_state_completed)) {
    if(!var_01) {
      var_00 thread lib_0547::func_7D1A("geist_drain");
    }
  } else {
    return 1;
  }

  return 0;
}

special_geist_drain_end() {
  var_00 = self;
  var_00 notify("geist_drain_end");
  var_00.current_drain = undefined;
}

anim_state_geist_drain_run() {
  var_00 = self;
  var_00 endon("geist_drain_end");
  if(!isDefined(var_00.current_drain)) {
    return;
  }

  var_00 pause_manual_move();
  var_00 pause_manual_rotation();
  var_01 = maps\mp\agents\_scripted_agent_anim_util::func_434D("geist_drain_enter");
  var_02 = maps\mp\agents\_scripted_agent_anim_util::func_7A35(var_01);
  maps\mp\agents\_scripted_agent_anim_util::func_71FA(var_01, var_02, 1, "king_attack", "end", ::geist_drain_cast_handle_notetracks);
  lib_0555::func_83DD("dlc4_godking_drain");
  var_00.drainshieldacive = 1;
  var_00 anim_state_geist_drain_cast_control();
  var_00.drainshieldacive = undefined;
  var_03 = var_00.current_drain.var_7DF9;
  if(lib_0547::func_5565(var_03, "complete")) {
    var_00.current_drain.geist_drain_struct attack_geist_drain_stop();
    lib_0555::func_83DD("dlc4_godking_drain_bonus");
    var_00 enable_geist_bullet_shield();
    var_01 = maps\mp\agents\_scripted_agent_anim_util::func_434D("geist_drain_exit");
    var_02 = maps\mp\agents\_scripted_agent_anim_util::func_7A35(var_01);
    maps\mp\agents\_scripted_agent_anim_util::func_71FA(var_01, var_02, 1, "king_attack", "end");
  } else {
    var_00.current_drain.geist_drain_struct attack_geist_drain_stop();
    lib_0555::func_83DD("dlc4_godking_drain_end");
    var_00 disable_geist_bullet_shield();
    var_00 thread enable_body_clip();
    var_01 = maps\mp\agents\_scripted_agent_anim_util::func_434D("geist_drain_stumble_knockdown");
    var_02 = maps\mp\agents\_scripted_agent_anim_util::func_7A35(var_01);
    var_00 notify("clear_transition_fx");
    var_00 thread play_punish_vo();
    maps\mp\agents\_scripted_agent_anim_util::func_71FA(var_01, var_02, 1, "king_attack", "end");
    var_00.drainpunishactive = 1;
    var_00 anim_state_ground_recover_loop();
    var_00.drainpunishactive = undefined;
    if(isDefined(var_00.punishdamage)) {
      var_00.punishdamage = undefined;
    }

    var_00 enable_geist_bullet_shield();
    var_01 = maps\mp\agents\_scripted_agent_anim_util::func_434D("geist_drain_stumble_recover");
    var_02 = maps\mp\agents\_scripted_agent_anim_util::func_7A35(var_01);
    maps\mp\agents\_scripted_agent_anim_util::func_71FA(var_01, var_02, 1, "king_attack", "end");
    var_00 thread disable_body_clip();
  }

  var_00 thread king_spawn_pickups(var_00.current_drain.geist_drain_struct.var_116);
  var_00.current_drain.anim_state_completed = 1;
}

play_punish_vo() {
  var_00 = self;
  var_00 endon("death");
  wait(0.45);
  var_00 thread vo_play_gdk_ability_line("drain_punished");
}

enable_body_clip() {
  self endon("chest_clip_stop_update");
  var_00 = "J_SpineUpper";
  var_01 = 0.5;
  self.stunnedclip method_808C();
  self.stunnedclip.var_116 = self gettagorigin(var_00);
  self.stunnedclip.var_1D = self gettagangles(var_00);
  self.stunnedclip solid();
  for(;;) {
    var_02 = self gettagorigin(var_00);
    var_03 = self gettagangles(var_00);
    self.stunnedclip moveto(var_02, var_01);
    wait(var_01);
  }
}

disable_body_clip() {
  self.stunnedclip notsolid();
  self notify("chest_clip_stop_update");
  self.stunnedclip.var_116 = self.stunnedclip.original_org;
  self.stunnedclip.var_1D = self.stunnedclip.original_ang;
}

body_clip_unresolved_collision(param_00) {
  var_01 = [];
  var_02 = param_00.var_116 - self.var_116;
  var_02 = vectornormalize((var_02[0], var_02[1], 0));
  var_03 = getclosestpointonnavmesh(param_00.var_116 + var_02 * 48);
  var_03 = getgroundposition(var_03, 40, 100, 50);
  var_04 = spawnStruct();
  var_04.var_116 = var_03;
  var_01[var_01.size] = var_04;
  self.var_A048 = var_01;
  var_05 = level.use_zombie_unresolved_collision;
  level.use_zombie_unresolved_collision = undefined;
  maps\mp\_movers::func_A047(param_00, 0);
  level.use_zombie_unresolved_collision = var_05;
}

anim_state_geist_drain_cast_control() {
  var_00 = self;
  if(isDefined(var_00.current_drain.var_7DF9)) {
    return;
  }

  var_00 endon("geist_drain_result");
  var_01 = maps\mp\agents\_scripted_agent_anim_util::func_434D("geist_drain_loop");
  var_02 = maps\mp\agents\_scripted_agent_anim_util::func_7A35(var_01);
  var_00 maps\mp\agents\_scripted_agent_anim_util::func_8415(var_01, var_02);
  var_00 waittill("forever");
}

anim_state_ground_recover_loop() {
  var_00 = self;
  var_00 thread anim_state_ground_recover_end_think();
  var_00 endon("geist_recover_result");
  var_01 = maps\mp\agents\_scripted_agent_anim_util::func_434D("geist_drain_stumble_idle");
  var_02 = maps\mp\agents\_scripted_agent_anim_util::func_7A35(var_01);
  var_00 maps\mp\agents\_scripted_agent_anim_util::func_8415(var_01, var_02);
  var_00 waittill("forever");
}

anim_state_ground_recover_end_think() {
  var_00 = self;
  var_01 = 8;
  var_02 = 1;
  while(var_01 > 0) {
    wait(var_02);
    var_01 = var_01 - var_02;
  }

  var_00 notify("geist_recover_result");
}

geist_drain_cast_handle_notetracks(param_00, param_01, param_02, param_03) {
  var_04 = self;
  switch (param_00) {
    case "cast":
      if(isDefined(var_04.current_drain)) {
        var_04 thread king_spawn_geist_drain();
      }
      break;
  }
}

king_geist_drain_report_result(param_00) {
  var_01 = self;
  var_01.current_drain.var_7DF9 = param_00;
  var_01 notify("geist_drain_result", param_00);
}

king_start_geist_drain_cast_fx() {
  var_00 = self;
  var_00.current_drain.fx_left_hand = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_gk_geistdrain_hands"), var_00, "J_Wrist_LE");
  var_00.current_drain.fx_right_hand = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_gk_geistdrain_hands"), var_00, "J_Wrist_RI");
  var_00 king_handle_attached_vfx_cleanup(var_00.current_drain.fx_left_hand);
  var_00 king_handle_attached_vfx_cleanup(var_00.current_drain.fx_right_hand);
  triggerfx(var_00.current_drain.fx_left_hand);
  triggerfx(var_00.current_drain.fx_right_hand);
  var_00.current_drain.fx_left_hand thread lib_0547::func_2D20(var_00, "geist_drain_result");
  var_00.current_drain.fx_right_hand thread lib_0547::func_2D20(var_00, "geist_drain_result");
}

king_spawn_geist_drain() {
  var_00 = self;
  var_00 endon("geist_drain_result");
  var_00 endon("geist_drain_end");
  var_01 = attack_geist_drain_spawn(var_00.var_116, var_00);
  thread king_start_geist_drain_cast_fx();
  var_00 thread setup_geist_drain_pain();
  var_00.current_drain.geist_drain_struct = var_01;
  var_00 thread vo_play_gdk_ability_line("geist_drain");
  var_01 attack_geist_drain_wait_till_stopped();
}

anim_state_geist_drain_end() {}

setup_geist_drain_pain() {
  var_00 = self;
  var_00 endon("death");
  var_00.current_drain.var_4DE0 = 0;
  var_00 thread geist_drain_plate_destruction_wait();
  var_00 common_scripts\utility::knock_off_battery("geist_drain_result", "geist_drain_end");
  var_00 cleanup_geist_drain_pain();
}

cleanup_geist_drain_pain() {
  var_00 = self;
}

geist_drain_plate_destruction_wait() {
  var_00 = self;
  var_00 endon("death");
  var_00 endon("geist_drain_result");
  for(var_01 = 0; var_01 < 3; var_01++) {
    var_00 waittill("plate_destroyed");
  }

  var_00 thread king_geist_drain_report_result("pain");
}

attack_geist_drain_spawn(param_00, param_01) {
  var_02 = spawnStruct();
  var_02.var_116 = param_00;
  var_02.var_117 = param_01;
  var_02.var_8BE = 1;
  param_01 thread geist_drain_aoe(var_02);
  return var_02;
}

geist_drain_aoe(param_00) {
  var_01 = self;
  param_00 endon("attack_geist_drain_stop");
  var_02 = 0.25;
  var_03 = 18;
  if(common_scripts\utility::func_562E(var_01.issolomode)) {
    var_03 = 25;
  }

  var_04 = 18 / var_02;
  var_05 = -1 / var_04;
  var_06 = "J_Wrist_LE";
  var_07 = "J_Wrist_RI";
  var_08 = "TAG_SWORD";
  lib_0378::func_8D74("god_king_giestdrain", var_01, param_00);
  var_09 = [var_07, var_06, var_08];
  var_0A = function_01AC(level.blood_plates, var_01.var_116, 2400);
  foreach(var_0C in var_0A) {
    if(lib_0547::func_5565(var_0C.var_8260, "plate_boss_room")) {
      var_09 = sort_tags_by_distance_2d(var_0C.var_116, var_01, var_09);
      var_0D = var_09[0];
      var_09 = common_scripts\utility::func_F93(var_09, var_0D);
      var_0C.loc_beam = launchbeam("zmb_geistkraft_blood_beam_med_drain", var_0C.plate_model, "TAG_ORIGIN", var_01, var_0D);
      var_0C.loc_beam thread lib_0547::func_2D20(var_0C, "plate_destroyed");
      var_0C.loc_beam thread lib_0547::func_2D20(var_0C, "drain_ended");
      var_0C thread drain_plate_think(var_0C.loc_beam, var_02, var_01);
    }
  }

  for(var_0F = 0; var_0F < var_04; var_0F++) {
    var_10 = var_01 king_get_targets_in_range(512);
    if(isDefined(var_10)) {
      foreach(var_12 in var_10) {
        if(distance2dsquared(var_01 gettagorigin(var_06), var_12.var_116) > distance2dsquared(var_01 gettagorigin(var_07), var_12.var_116)) {
          var_0D = var_07;
        } else {
          var_0D = var_06;
        }

        var_13 = launchbeam("zmb_geistkraft_reg_beam_med", var_01, var_0D, var_12, "J_Spine4");
        var_13 thread delete_time(int(var_02));
        if(isPlayer(var_12)) {
          if(isDefined(self.powerbuffamount) && self.powerbuffamount > 0) {
            var_12 lib_0533::func_F37(var_05, 1, 1);
            drain_heal_king(-15536 / var_04);
          } else {
            var_14 = var_12.var_FB / var_04;
            var_14 = int(var_14);
            var_12 dodamage(var_14, var_01.var_116, var_01, var_01, "MOD_ENERGY");
            drain_heal_king(-15536 / var_04);
          }

          continue;
        }

        var_14 = var_12.var_FB / var_04;
        var_14 = int(var_14);
        var_12 dodamage(var_14, var_01.var_116, var_01, var_01, "MOD_ENERGY");
        drain_heal_king(-15536 / var_04);
      }
    }

    wait(var_02);
  }

  foreach(var_0C in level.blood_plates) {
    if(lib_0547::func_5565(var_0C.var_8260, "plate_boss_room")) {
      var_0C notify("drain_ended");
    }
  }

  drain_heal_king(100000);
  playFX(common_scripts\utility::func_44F5("zmb_hilt_sphere_explosion"), var_01 gettagorigin(var_08), var_01 gettagangles(var_08));
  var_01 thread king_geist_drain_report_result("complete");
  lib_0378::func_8D74("aud_clear_mute_zvox_for_drain");
}

drain_heal_king(param_00) {
  var_01 = self;
  if(param_00 + var_01.var_BC >= var_01.var_FB) {
    param_00 = var_01.var_FB - var_01.var_BC;
  }

  if(common_scripts\utility::func_562E(var_01.issolomode)) {
    param_00 = param_00 / 2;
  }

  var_01.var_BC = var_01.var_BC + int(param_00);
}

drain_plate_think(param_00, param_01, param_02) {
  var_03 = self;
  var_03.fount_active = 1;
  var_03.drain_fx_ent = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_desc_blood_plates_lt_drain"), var_03.plate_model, "TAG_ORIGIN");
  triggerfx(var_03.drain_fx_ent);
  var_03.plate_hit_clip solid();
  var_03.plate_hit_clip setCanDamage(1);
  var_03.plate_hit_clip setdamagecallbackon(1);
  var_03.plate_hit_clip.total_damage = 0;
  var_03.plate_hit_clip.my_fount = var_03;
  var_03.plate_hit_clip.var_29B5 = ::geist_drain_plate_damage;
  var_03 childthread drain_plate(param_00, param_01);
  var_03 drain_end_wait(param_02);
  var_03.drain_fx_ent delete();
  var_03.plate_hit_clip notsolid();
  var_03.plate_hit_clip setCanDamage(0);
  var_03.plate_hit_clip setdamagecallbackon(0);
  var_03.plate_hit_clip.var_29B5 = undefined;
  playFX(common_scripts\utility::func_44F5("zmb_hilt_sphere_explosion"), var_03.plate_model.var_116, anglesToForward(var_03.plate_model.var_1D));
  var_03.fount_active = 0;
}

drain_end_wait(param_00) {
  var_01 = self;
  param_00 endon("death");
  var_01 endon("drain_ended");
  var_01 waittill("plate_destroyed");
}

geist_drain_plate_damage(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  var_0C = self;
  if(isPlayer(param_01)) {
    var_0D = "weakpoint";
    param_01 thread maps\mp\gametypes\_damagefeedback::func_A102(var_0D);
    if(king_check_if_raven_weapons(param_05)) {
      param_02 = param_02 * 2.5;
    }

    self.total_damage = self.total_damage + param_02;
    if(self.total_damage > get_plate_health()) {
      self.my_fount notify("plate_destroyed");
      if(isDefined(level.zombie_king)) {
        lib_0378::func_8D74("god_king_giestdrain_plate_destroyed");
        level.zombie_king notify("plate_destroyed");
        return;
      }
    }
  }
}

get_plate_health() {
  var_00 = 4000;
  switch (level.var_744A.size) {
    case 1:
      var_00 = 4000;
      break;

    case 2:
      var_00 = 6000;
      break;

    case 3:
      var_00 = 7000;
      break;

    case 4:
      var_00 = 8000;
      break;

    default:
      break;
  }

  return var_00;
}

drain_plate(param_00, param_01) {
  while(isDefined(param_00)) {
    maps\mp\mp_zombie_descent::blood_plate_subtract();
    wait(param_01);
  }
}

attack_geist_drain_spawn_interrupt_volume(param_00, param_01, param_02) {}

attack_geist_drain_stop() {
  var_00 = self;
  if(common_scripts\utility::func_562E(var_00.var_8BE)) {
    var_00.var_8BE = 0;
    var_00 notify("attack_geist_drain_stop");
  }
}

attack_geist_drain_wait_till_stopped() {
  var_00 = self;
  if(common_scripts\utility::func_562E(var_00.var_8BE)) {
    var_00 waittill("attack_geist_drain_stop");
  }
}

uber_flame_wave_try() {
  var_00 = self;
  return 1;
}

uber_flame_wave_start() {
  var_00 = self;
  var_00.current_flame_wave = spawnStruct();
  var_01 = level.bossfight.throne_pos.var_116;
  var_00 enable_geist_bullet_shield();
  var_00.current_flame_wave.var_2DA7 = king_create_destination(var_01);
}

uber_flame_wave_think() {
  var_00 = self;
  var_01 = 0;
  var_01 = king_has_arrived(var_00.current_flame_wave.var_2DA7);
  if(!var_01) {
    king_continue_moving(var_00.current_flame_wave.var_2DA7);
  }

  var_02 = var_00 king_is_in_or_waiting_for_scripted_state("flame_wave");
  if(var_01) {
    if(!common_scripts\utility::func_562E(var_00.current_flame_wave.anim_state_completed)) {
      if(!var_02) {
        var_00 thread lib_0547::func_7D1A("flame_wave");
      }
    } else {
      return 1;
    }
  }

  return 0;
}

uber_flame_wave_end() {
  var_00 = self;
  var_00 notify("flame_wave_end");
  var_00.current_flame_wave = undefined;
}

anim_state_flame_wave_run() {
  var_00 = self;
  var_00 endon("flame_wave_end");
  if(!isDefined(var_00.current_flame_wave)) {
    return;
  }

  var_00 pause_manual_move();
  var_00 start_manual_rotation();
  var_00 anim_state_flame_wave_cast_control();
  var_01 = var_00.current_flame_wave.var_7DF9;
  if(lib_0547::func_5565(var_01, "complete")) {
    var_02 = maps\mp\agents\_scripted_agent_anim_util::func_434D("flame_wave_end");
    var_03 = maps\mp\agents\_scripted_agent_anim_util::func_7A35(var_02);
    maps\mp\agents\_scripted_agent_anim_util::func_71FA(var_02, var_03, 1, "king_attack", "end");
  } else {
    var_02.current_flame_wave.flame_wave_struct attack_flame_wave_stop();
    var_02 = maps\mp\agents\_scripted_agent_anim_util::func_434D("flame_wave_pain");
    var_03 = maps\mp\agents\_scripted_agent_anim_util::func_7A35(var_03);
    maps\mp\agents\_scripted_agent_anim_util::func_71FA(var_02, var_03, 1, "king_attack", "end");
  }

  var_00.current_flame_wave.anim_state_completed = 1;
}

anim_state_flame_wave_cast_control() {
  var_00 = self;
  var_00 endon("flame_wave_result");
  var_00 disable_geist_bullet_shield();
  var_01 = maps\mp\agents\_scripted_agent_anim_util::func_434D("flame_wave_cast");
  var_02 = maps\mp\agents\_scripted_agent_anim_util::func_7A35(var_01);
  var_00 notify("flame_wave_cast");
  maps\mp\agents\_scripted_agent_anim_util::func_71FA(var_01, var_02, 1, "king_attack", "end", ::flame_wave_cast_handle_notetracks);
  var_01 = maps\mp\agents\_scripted_agent_anim_util::func_434D("flame_wave_ctrl");
  var_02 = maps\mp\agents\_scripted_agent_anim_util::func_7A35(var_01);
  var_00 maps\mp\agents\_scripted_agent_anim_util::func_8415(var_01, var_02);
  var_00 waittill("forever");
}

flame_wave_cast_handle_notetracks(param_00, param_01, param_02, param_03) {
  var_04 = self;
  switch (param_00) {
    case "cast":
      if(isDefined(var_04.current_flame_wave)) {
        var_04 thread king_spawn_flame_wave();
      }
      break;
  }
}

king_flame_wave_report_result(param_00) {
  var_01 = self;
  var_01.current_flame_wave.var_7DF9 = param_00;
  var_01 notify("flame_wave_result", param_00);
}

king_spawn_flame_wave() {
  var_00 = self;
  var_00 endon("flame_wave_result");
  var_00 endon("flame_wave_end");
  var_01 = attack_flame_wave_spawn(var_00.var_116, var_00);
  var_00 thread setup_flame_wave_pain();
  var_00.current_flame_wave.flame_wave_struct = var_01;
  var_00 thread vo_play_gdk_ability_line("flame_wave");
  var_01 attack_flame_wave_wait_till_stopped();
  var_00 thread king_flame_wave_report_result("complete");
}

anim_state_flame_wave_end() {}

setup_flame_wave_pain() {
  var_00 = self;
  var_00 endon("death");
  var_00.current_flame_wave.var_4DE0 = 0;
  var_00 add_king_damage_finished_func("flame_wave_pain", ::flame_wave_on_damage_finished);
  var_00 common_scripts\utility::knock_off_battery("flame_wave_result", "flame_wave_end");
  var_00 cleanup_flame_wave_pain();
}

cleanup_flame_wave_pain() {
  var_00 = self;
  var_00 remove_king_damage_finished_func("flame_wave_pain");
}

flame_wave_on_damage_finished(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  var_0B = self;
  if(!isDefined(var_0B.current_flame_wave)) {
    return;
  }

  if(isDefined(param_01) && isPlayer(param_01)) {
    if(!isDefined(var_0B.current_flame_wave.flame_wave_struct)) {
      return;
    }

    var_0C = var_0B.current_flame_wave.flame_wave_struct.last_kill_radius;
    if(isDefined(var_0C) && distance2d(param_01.var_116, var_0B.var_116) < var_0C) {
      var_0B.current_flame_wave.var_4DE0++;
      if(var_0B.current_flame_wave.var_4DE0 > 0) {
        var_0B thread king_flame_wave_report_result("pain");
        return;
      }
    }
  }
}

attack_flame_wave_spawn(param_00, param_01, param_02) {
  var_03 = spawnStruct();
  var_03.var_116 = param_00;
  var_03.var_117 = param_01;
  var_03.istrial = param_02;
  if(!isDefined(level.next_flame_wave_id)) {
    level.next_flame_wave_id = 0;
  } else {
    level.next_flame_wave_id++;
  }

  var_03.flame_id = level.next_flame_wave_id;
  var_03 thread attack_flame_wave_run();
  var_04 = "flame_wave_end_" + var_03.flame_id;
  thread maps\mp\_utility::func_6F74(::flame_wave_sound_runner, var_03, var_04);
  return var_03;
}

flame_wave_sound_runner(param_00) {
  var_01 = self;
  var_02 = spawn("script_model", self.var_116);
  var_02 setModel("tag_origin");
  var_02 method_805C();
  var_02 showtoclient(var_01);
  lib_0378::func_8D74("flame_wave_runner_start", var_02, var_01);
  flame_wave_sound_runner_run(param_00, var_02);
  lib_0378::func_8D74("flame_wave_runner_stop", var_02, var_01);
  wait(1);
  var_02 delete();
}

flame_wave_sound_runner_run(param_00, param_01) {
  var_02 = self;
  var_02 endon("disconnect");
  param_00 endon("attack_flame_wave_stop");
  if(!common_scripts\utility::func_562E(param_00.var_8BE)) {
    return;
  }

  var_03 = 40;
  var_04 = 0;
  for(;;) {
    var_05 = var_02.var_116 - param_00.var_116 * (1, 1, 0);
    var_06 = length(var_05);
    var_07 = var_06 < param_00.last_kill_radius;
    if(var_07 != var_04) {
      if(var_07) {
        lib_0378::func_8D74("flame_wave_runner_inside", param_01, var_02);
      } else {
        lib_0378::func_8D74("flame_wave_runner_outside", param_01, var_02);
      }
    }

    var_04 = var_07;
    var_08 = var_05 / var_06;
    var_09 = param_00.var_116 + var_08 * param_00.last_kill_radius;
    var_09 = (var_09[0], var_09[1], var_02.var_116[2]);
    var_0A = param_00.var_116 + var_08 * param_00.last_kill_radius + var_03;
    var_0A = (var_0A[0], var_0A[1], var_02.var_116[2]);
    param_01.var_116 = var_09;
    param_01 moveto(var_0A, 0.2);
    wait(0.2);
  }
}

attack_flame_wave_run() {
  var_00 = self;
  var_00.var_8BE = 1;
  var_01 = randomfloatrange(0, 360);
  var_02 = anglesToForward((0, var_01, 0));
  if(lib_0547::func_5565(var_00.istrial, 1)) {
    var_00.var_3F2F = spawnfx(common_scripts\utility::func_44F5("zmb_desc_flame_wave_02"), var_00.var_116, (0, 1, 0), (0, 0, 1));
  } else {
    var_00.var_3F2F = spawnfx(common_scripts\utility::func_44F5("zmb_desc_flame_wave"), var_00.var_116, var_02, (0, 0, 1));
  }

  function_014E(var_00.var_3F2F, 1);
  triggerfx(var_00.var_3F2F);
  var_00 endon("attack_flame_wave_stop");
  var_00 childthread attack_flame_wave_handle_max_timeout();
  var_00 childthread attack_flame_wave_damage();
}

attack_flame_wave_handle_max_timeout() {
  var_00 = self;
  wait(10);
  var_00 thread attack_flame_wave_stop();
}

attack_flame_wave_damage() {
  var_00 = self;
  var_01 = 0;
  var_02 = 0;
  var_03 = 40;
  var_00.last_kill_radius = 0;
  wait(0.4);
  for(;;) {
    var_04 = var_02;
    var_01 = var_01 + var_03;
    var_02 = max(var_01 - 72, 0);
    var_00.last_kill_radius = var_01;
    var_05 = common_scripts\utility::func_F73(level.var_744A, lib_0547::func_408F());
    var_05 = common_scripts\utility::func_F73(var_05, maps\mp\mp_zombie_descent_ee_main::get_unbroken_ice_blocks());
    foreach(var_07 in var_05) {
      if(isDefined(var_07.flame_waves_hit_by) && isDefined(var_07.flame_waves_hit_by[var_00.flame_id])) {
        continue;
      }

      if(lib_0547::func_5565(var_00.var_117, var_07)) {
        continue;
      }

      var_08 = approximate_script_hit_cylinder(var_07);
      var_09 = var_08[0];
      var_0A = var_08[1];
      var_0B = 0.5 * var_0A;
      var_0C = abs(var_07.var_116[2] + var_0B - var_00.var_116[2]);
      if(var_0C > var_0B + 600) {
        continue;
      }

      var_0D = distance2d(var_07.var_116, var_00.var_116);
      if(var_0D > var_01 + var_09 || var_0D < var_04 - var_09) {
        continue;
      }

      var_07.flame_waves_hit_by[var_00.flame_id] = 1;
      var_00 thread target_hit_by_flame_wave(var_07);
    }

    wait(0.2);
  }
}

target_hit_by_flame_wave(param_00) {
  wait(0);
  var_01 = self;
  if(common_scripts\utility::func_562E(param_00.is_ice_block)) {
    var_02 = 200;
    var_03 = param_00.var_8303 / var_02;
    var_01 endon("attack_flame_wave_stop");
    wait(var_03);
    param_00 maps\mp\mp_zombie_descent_ee_main::ice_block_break();
    return;
  }

  if(isPlayer(param_00) && !lib_0547::func_577E(param_00)) {
    param_00 lib_0547::func_7454(0);
    param_00 dodamage(param_00.var_BC + 666, var_01.var_116, var_01.var_117, undefined, "MOD_BURNED", "zombie_king_uber_flame");
    return;
  }

  param_00 dodamage(param_00.var_BC + 666, param_00.var_116, param_00, param_00, "MOD_BURNED", "zombie_king_uber_flame");
}

approximate_script_hit_cylinder(param_00) {
  var_01 = undefined;
  var_02 = undefined;
  if(isDefined(param_00.var_8302)) {
    var_01 = param_00.var_8302;
  } else if(isDefined(param_00.var_BD)) {
    var_01 = param_00.var_BD;
  } else {
    var_01 = 65;
  }

  if(isDefined(param_00.var_8303)) {
    var_02 = param_00.var_8303;
  } else if(isDefined(param_00.var_14F)) {
    var_02 = param_00.var_14F;
  } else {
    var_02 = 65;
  }

  return [var_02, var_01];
}

attack_flame_wave_spawn_interrupt_volume(param_00, param_01, param_02) {}

attack_flame_wave_stop() {
  var_00 = self;
  if(common_scripts\utility::func_562E(var_00.var_8BE)) {
    var_00.var_8BE = 0;
    var_00.var_3F2F delete();
    var_00 notify("attack_flame_wave_stop");
    level notify("flame_wave_end_" + var_00.flame_id);
  }
}

attack_flame_wave_wait_till_stopped() {
  var_00 = self;
  if(common_scripts\utility::func_562E(var_00.var_8BE)) {
    var_00 waittill("attack_flame_wave_stop");
  }
}

uber_force_try() {
  var_00 = self;
  return 1;
}

uber_force_start() {
  var_00 = self;
  var_00.current_force = spawnStruct();
  var_01 = get_random_boss_position();
  var_00 enable_geist_bullet_shield();
  var_00.current_force.var_2DA7 = king_create_destination(var_01);
}

uber_force_think() {
  var_00 = self;
  var_01 = 0;
  var_01 = king_has_arrived(var_00.current_force.var_2DA7);
  if(!var_01) {
    king_continue_moving(var_00.current_force.var_2DA7);
  }

  var_02 = var_00 king_is_in_or_waiting_for_scripted_state("force");
  if(var_01) {
    if(!common_scripts\utility::func_562E(var_00.current_force.anim_state_completed)) {
      if(!var_02) {
        var_00 thread lib_0547::func_7D1A("force");
      }
    } else {
      return 1;
    }
  }

  return 0;
}

uber_force_end() {
  var_00 = self;
  var_00 notify("force_end");
  var_00.current_force = undefined;
}

anim_state_force_run() {
  var_00 = self;
  var_00 endon("force_end");
  if(!isDefined(var_00.current_force)) {
    return;
  }

  var_00 pause_manual_move();
  var_00 start_manual_rotation();
  var_00 disable_geist_bullet_shield();
  var_01 = maps\mp\agents\_scripted_agent_anim_util::func_434D("overwhelm_force");
  var_02 = maps\mp\agents\_scripted_agent_anim_util::func_7A35(var_01);
  var_00 thread force_attack_run();
  var_00 thread vo_play_gdk_ability_line("overwhelm_force");
  maps\mp\agents\_scripted_agent_anim_util::func_71FA(var_01, var_02, 1, "king_attack", "end", ::force_handle_notetracks);
  var_00.current_force.anim_state_completed = 1;
}

force_handle_notetracks(param_00, param_01, param_02, param_03) {
  switch (param_00) {
    case "unleash_force":
      self notify("notify_force_unleash");
      break;
  }
}

force_attack_run() {
  var_00 = "TAG_WEAPON_RIGHT";
  if(!lib_0547::func_5565(level.zombie_king, self)) {
    var_00 = "TAG_ORIGIN";
  }

  lib_0378::func_8D74("god_king_force_summon");
  self waittill("notify_force_unleash");
  thread force_apply_shield();
}

force_apply_shield(param_00) {
  var_01 = lib_0547::func_408F();
  foreach(var_03 in var_01) {
    if(var_03 == self || isDefined(param_00) && !var_03 istouching(param_00)) {
      continue;
    }

    var_03 thread enable_force_shield();
  }
}

enable_force_shield() {
  if(lib_0547::func_5565(self.isforceshieldactive, 1)) {
    return;
  }

  self.isforceshieldactive = 1;
  self.var_480F = 1;
  self.nomutilate = 1;
  var_00 = spawnlinkedfx(common_scripts\utility::func_44F5("force_zombie_bubble"), self, "J_SpineLower");
  maps\mp\agents\_agent_utility::deleteentonagentdeath(var_00);
  triggerfx(var_00);
  self.myforceshield = var_00;
}

break_force_shield() {
  if(isDefined(self.myforceshield)) {
    self.myforceshield delete();
  }

  self.isforceshieldactive = 0;
  playFXOnTag(common_scripts\utility::func_44F5("force_zombie_bubble_pop"), self, "J_SpineLower");
  self.nomutilate = 0;
  self.var_480F = 0;
}

uber_sun_try() {
  var_00 = self;
  return 1;
}

uber_sun_start() {
  var_00 = self;
  var_00.current_sun = spawnStruct();
  var_01 = get_random_boss_sun_position();
  var_00 enable_geist_bullet_shield();
  var_00.current_sun.var_2DA7 = king_create_destination(var_01);
}

uber_sun_think() {
  var_00 = self;
  var_01 = 0;
  var_01 = king_has_arrived(var_00.current_sun.var_2DA7);
  if(!var_01) {
    king_continue_moving(var_00.current_sun.var_2DA7);
  }

  var_02 = var_00 king_is_in_or_waiting_for_scripted_state("sun");
  if(var_01) {
    if(!common_scripts\utility::func_562E(var_00.current_sun.anim_state_completed)) {
      if(!var_02) {
        var_00 thread lib_0547::func_7D1A("sun");
      }
    } else {
      return 1;
    }
  }

  return 0;
}

uber_sun_end() {
  var_00 = self;
  var_00 notify("sun_end");
  var_00.current_sun = undefined;
}

anim_state_sun_run() {
  var_00 = self;
  var_00 endon("sun_end");
  if(!isDefined(var_00.current_sun)) {
    return;
  }

  var_00 pause_manual_move();
  var_00 start_manual_rotation();
  var_00 disable_geist_bullet_shield();
  var_01 = maps\mp\agents\_scripted_agent_anim_util::func_434D("light_of_the_sun");
  var_02 = maps\mp\agents\_scripted_agent_anim_util::func_7A35(var_01);
  var_00 thread sun_attack_run();
  var_00 thread vo_play_gdk_ability_line("light_of_the_sun");
  maps\mp\agents\_scripted_agent_anim_util::func_71FA(var_01, var_02, 1, "king_attack", "end", ::sun_handle_notetracks);
  var_00.current_sun.anim_state_completed = 1;
}

sun_handle_notetracks(param_00, param_01, param_02, param_03) {
  switch (param_00) {
    case "light_begin":
      self notify("notify_sun_kill");
      break;
  }
}

sun_attack_run() {
  var_00 = "TAG_WEAPON_CHEST";
  if(!lib_0547::func_5565(level.zombie_king, self)) {
    var_00 = "TAG_ORIGIN";
  }

  self.fx_sun_tell = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_gk_lightsun_buildup"), self, var_00);
  king_handle_attached_vfx_cleanup(self.fx_sun_tell);
  triggerfx(self.fx_sun_tell);
  self.fx_sun_tell lib_0378::func_8D74("god_king_sun_cast");
  wait(0.15);
  thread sun_do_preface_damage(var_00);
  self waittill("notify_sun_kill");
  self.fx_sun_tell delete();
  self.fx_sun_tell = undefined;
  playFXOnTag(common_scripts\utility::func_44F5("zmb_gk_lightsun_blast"), self, var_00);
  lib_0378::func_8D74("god_king_sun_blast");
  thread praise_the_sun(var_00);
}

sun_do_preface_damage(param_00) {
  self endon("notify_sun_kill");
  for(;;) {
    var_01 = lib_0547::func_408F();
    var_02 = common_scripts\utility::func_F73(var_01, level.var_744A);
    foreach(var_04 in var_02) {
      if(var_04 == self || lib_0547::func_5565(level.zombie_king, var_04)) {
        continue;
      }

      if(bullettracepassed(self gettagorigin(param_00), var_04 getEye(), 0, self)) {
        var_04 dodamage(5, self.var_116, self, self, "MOD_ENERGY", "zombie_king_uber_sun");
      }
    }

    wait(0.4);
  }
}

praise_the_sun(param_00) {
  var_01 = self;
  var_02 = lib_0547::func_408F();
  var_03 = common_scripts\utility::func_F73(var_02, level.var_744A);
  foreach(var_05 in var_03) {
    if(var_05 == self || lib_0547::func_5565(level.zombie_king, var_05)) {
      continue;
    }

    if(bullettracepassed(self gettagorigin(param_00), var_05 getEye(), 0, self)) {
      var_05 dodamage(var_05.var_BC + 666, self.var_116, self, self, "MOD_ENERGY", "zombie_king_uber_sun");
      lib_0378::func_8D74("god_king_sun_blast_hit_plr", var_05);
    }
  }
}

special_geist_drain_special_try() {
  var_00 = self;
  return 1;
}

special_geist_drain_special_start() {
  var_00 = self;
  var_00.current_drain_special = spawnStruct();
  var_01 = level.bossfight.throne_pos;
  var_00 enable_geist_bullet_shield();
  var_00.current_drain_special.var_2DA7 = king_create_destination(var_01);
  var_02 = level.bossfight.throne_pos.var_1D[1];
  var_00.current_drain_special.rotation_target = create_rotation_target_yaw(var_02);
  var_00 set_rotation_target(var_00.current_drain_special.rotation_target);
}

special_geist_drain_special_think() {
  var_00 = self;
  var_01 = var_00 king_is_in_or_waiting_for_scripted_state("geist_drain_special");
  if(!common_scripts\utility::func_562E(var_00.current_drain_special.anim_state_completed)) {
    if(!var_01) {
      var_00 thread lib_0547::func_7D1A("geist_drain_special");
    }
  } else {
    return 0;
  }

  return 0;
}

special_geist_drain_special_end() {
  var_00 = self;
  var_00 notify("geist_drain_special_end");
  var_00.current_drain_special = undefined;
}

anim_state_geist_drain_special_run() {
  var_00 = self;
  var_00 endon("geist_drain_special_end");
  if(!isDefined(var_00.current_drain_special)) {
    return;
  }

  var_00 pause_manual_move();
  var_00 pause_manual_rotation();
  var_00 disable_geist_bullet_shield();
  var_00 thread king_spawn_geist_drain_special();
  var_00 thread end_taunt_loop();
  var_00 anim_state_geist_drain_special_cast_control();
  var_01 = var_00.current_drain_special.var_7DF9;
  if(lib_0547::func_5565(var_01, "complete")) {
    var_02 = maps\mp\agents\_scripted_agent_anim_util::func_434D("death_fail");
    var_03 = maps\mp\agents\_scripted_agent_anim_util::func_7A35(var_02);
    var_00 lib_0378::func_8D74("god_king_finale_melee");
    var_00 thread vo_play_gdk_ability_line("end_fail");
    maps\mp\agents\_scripted_agent_anim_util::func_71FA(var_02, var_03, 1, "king_attack", "end");
    var_00.king_seated = 0;
    foreach(var_05 in level.var_744A) {
      var_06 = launchbeam("zmb_geistkraft_blood_beam_med_drain", var_05, "J_Spine4", var_00, "TAG_SWORD");
      var_06 thread delete_time(2);
      var_05 thread king_zombie_wins(var_00);
    }

    var_00 lib_0378::func_8D74("god_king_finale_drain_end");
  } else {
    var_02.current_drain_special.geist_drain_special_struct attack_geist_drain_special_stop();
    var_02 notify("fatal_blow");
    var_02 = maps\mp\agents\_scripted_agent_anim_util::func_434D("death_finale");
    var_03 = maps\mp\agents\_scripted_agent_anim_util::func_7A35(var_03);
    var_00 lib_0378::func_8D74("god_king_death");
    maps\mp\agents\_scripted_agent_anim_util::func_71FA(var_02, var_03, 1, "king_attack", "end");
    if(isDefined(level.zombie_king_sword.hitbox)) {
      level.zombie_king_sword.hitbox delete();
    }

    if(isDefined(level.zombie_king_sword)) {
      playFX(level.var_611["zmb_desc_boss_death_sword_hide"], level.zombie_king_sword.var_116, anglesToForward(level.zombie_king_sword.var_1D));
      level.zombie_king_sword delete();
    }

    var_00 lib_0378::func_8D74("god_king_finale_drain_end");
    var_00 thread zombie_king_play_dead();
  }

  var_00.current_drain_special.anim_state_completed = 1;
}

end_taunt_loop() {
  self endon("death");
  self endon("fatal_blow");
  thread vo_play_gdk_ability_line("end_taunt");
  wait(6);
  thread vo_play_gdk_ability_line("end_taunt");
  wait(3);
  thread vo_play_gdk_ability_line("end_taunt");
}

anim_state_geist_drain_special_cast_control() {
  var_00 = self;
  if(isDefined(var_00.current_drain_special.var_7DF9)) {
    return;
  }

  var_00 endon("geist_drain_special_result");
  var_01 = undefined;
  for(;;) {
    var_02 = maps\mp\agents\_scripted_agent_anim_util::func_434D("death_sit");
    var_03 = maps\mp\agents\_scripted_agent_anim_util::func_7A35(var_02);
    var_00 maps\mp\agents\_scripted_agent_anim_util::func_8415(var_02, var_03);
    var_00 waittill("finale_minor_pain", var_04);
    if(isDefined(var_04)) {
      var_02 = maps\mp\agents\_scripted_agent_anim_util::func_434D(var_04);
      var_03 = maps\mp\agents\_scripted_agent_anim_util::func_7A35(var_02);
      var_00 maps\mp\agents\_scripted_agent_anim_util::func_71FA(var_02, var_03, 1, "king_death", "end");
    }
  }
}

king_geist_drain_special_report_result(param_00) {
  var_01 = self;
  var_01.current_drain_special.var_7DF9 = param_00;
  var_01 notify("geist_drain_special_result", param_00);
}

king_spawn_geist_drain_special() {
  var_00 = self;
  var_00 endon("geist_drain_special_result");
  var_00 endon("geist_drain_special_end");
  var_01 = attack_geist_drain_special_spawn(var_00.var_116, var_00);
  var_00 thread setup_geist_drain_special_pain();
  var_00.current_drain_special.geist_drain_special_struct = var_01;
  var_01 attack_geist_drain_special_wait_till_stopped();
  var_00 thread king_geist_drain_special_report_result("complete");
}

anim_state_geist_drain_special_end() {}

setup_geist_drain_special_pain() {
  var_00 = self;
  var_00 endon("death");
  var_00.current_drain_special.damage_taken = 0;
  var_00 add_king_damage_finished_func("geist_drain_special_pain", ::geist_drain_special_on_damage_finished);
  var_00 common_scripts\utility::knock_off_battery("geist_drain_special_result", "geist_drain_special_end");
  var_00 cleanup_geist_drain_special_pain();
}

cleanup_geist_drain_special_pain() {
  var_00 = self;
  var_00 remove_king_damage_finished_func("geist_drain_special_pain");
}

geist_drain_special_on_damage_finished(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  var_0B = self;
  if(!isDefined(var_0B.current_drain_special)) {
    return;
  }

  if(isDefined(param_05) && isDefined(param_04)) {
    if(king_check_if_weapon_op(param_05, param_04) && param_02 > 1) {
      param_02 = int(param_02 * 0.6);
    }
  }

  if(isDefined(param_05) && isDefined(param_04)) {
    if(king_check_if_raven_weapons(param_05, param_04) && param_02 > 1) {
      param_02 = int(param_02 * 2.5);
    }
  }

  var_0B.current_drain_special.damage_taken = var_0B.current_drain_special.damage_taken + param_02;
  var_0C = 100000 * level.var_721C.size;
  if(var_0B.current_drain_special.damage_taken > var_0C) {
    var_0B thread king_geist_drain_special_report_result("pain");
    return;
  }

  var_0D = var_0B.current_drain_special.last_finale_minor_pain;
  if(!isDefined(var_0D) || gettime() > var_0D + 1300) {
    var_0E = "death_sit_pain_head";
    if(isDefined(param_08) && param_08 != "head" && isDefined(param_07)) {
      var_0F = anglestoright(var_0B.puck.var_1D);
      if(vectordot(var_0F, param_07) > 0) {
        var_0E = "death_sit_pain_r";
      } else {
        var_0E = "death_sit_pain_l";
      }
    }

    var_0B.current_drain_special.last_finale_minor_pain = gettime();
    var_0B notify("finale_minor_pain", var_0E);
  }
}

king_check_if_weapon_sap(param_00, param_01) {
  var_02 = 0;
  if(issubstr(param_00, "p38_") && issubstr(param_00, "_pap_zm")) {
    var_02 = 1;
  }

  if(issubstr(param_00, "sdk_") && issubstr(param_00, "_pap_zm")) {
    var_02 = 1;
  }

  return var_02;
}

king_check_if_weapon_op(param_00, param_01) {
  var_02 = 0;
  if(!isDefined(param_00)) {
    return 0;
  }

  if(issubstr(param_00, "svt40_") && issubstr(param_00, "_pap_zm")) {
    var_02 = 1;
  }

  if(issubstr(param_00, "raven_gun_") && issubstr(param_00, "_pap_zm")) {
    var_02 = 1;
  }

  if(lib_0547::func_5565(param_01, "MOD_EXPLOSIVE") || lib_0547::func_5565(param_01, "MOD_EXPLOSIVE_BULLET")) {
    var_02 = 1;
  }

  return var_02;
}

king_check_if_raven_weapons(param_00, param_01) {
  var_02 = 0;
  if(!isDefined(param_00)) {
    return 0;
  }

  if(issubstr(param_00, level.ravenweaponmanager["shield"].var_1D0) || issubstr(param_00, level.ravenweaponmanager["shield_emp"].var_1D0) || issubstr(param_00, level.ravenweaponmanager["scythe"].var_1D0) || issubstr(param_00, level.ravenweaponmanager["scythe_emp"].var_1D0) || issubstr(param_00, level.ravenweaponmanager["spike"].var_1D0) || issubstr(param_00, level.ravenweaponmanager["spike_emp"].var_1D0) || issubstr(param_00, level.ravenweaponmanager["hammer"].var_1D0) || issubstr(param_00, level.ravenweaponmanager["hammer_emp"].var_1D0)) {
    var_02 = 1;
  }

  return var_02;
}

king_check_if_raven_weapon_cleave(param_00, param_01) {
  var_02 = 0;
  if(!isDefined(param_00)) {
    return 0;
  }

  if(issubstr(param_00, "hammer_cleave_zm") || issubstr(param_00, "hammer_cleave_emp_zm") || issubstr(param_00, "scythe_cleave_zm") || issubstr(param_00, "scythe_cleave_emp_zm") || issubstr(param_00, "scythe_shard_zm") || issubstr(param_00, "shield_cleave_zm") || issubstr(param_00, "shield_cleave_emp_zm") || issubstr(param_00, "zom_hammer_grenade_zm")) {
    var_02 = 1;
  }

  return var_02;
}

attack_geist_drain_special_spawn(param_00, param_01) {
  var_02 = spawnStruct();
  var_02.var_116 = param_00;
  var_02.var_117 = param_01;
  var_02.var_8BE = 1;
  param_01 thread geist_drain_special_aoe(var_02);
  return var_02;
}

geist_drain_special_aoe(param_00) {
  var_01 = self;
  param_00 endon("attack_geist_drain_special_stop");
  var_02 = 0.25;
  var_03 = 16 / var_02;
  var_04 = "J_Wrist_LE";
  var_05 = "J_Wrist_RI";
  for(var_06 = 0; var_06 < var_03; var_06++) {
    var_07 = var_01 king_get_targets_in_range(2200);
    if(isDefined(var_07)) {
      var_08 = common_scripts\utility::func_F73(level.var_744A, var_07);
    } else {
      var_08 = level.var_744A;
    }

    if(!isDefined(var_08)) {
      wait(var_02);
      continue;
    }

    foreach(var_0A in var_08) {
      if(distance2dsquared(var_01 gettagorigin(var_04), var_0A.var_116) > distance2dsquared(var_01 gettagorigin(var_05), var_0A.var_116)) {
        var_0B = var_05;
      } else {
        var_0B = var_04;
      }

      var_0C = launchbeam("zmb_geistkraft_blood_beam_med_drain", var_01, var_0B, var_0A, "J_Spine4");
      var_0C thread delete_time(int(var_02));
      var_0D = var_0A.var_BC + 1;
      if(isPlayer(var_0A)) {
        var_0D = 1;
      }

      var_0A dodamage(var_0D, var_01.var_116, var_01, var_01, "MOD_ENERGY");
      var_01.var_BC = var_01.var_BC + 1;
    }

    wait(var_02);
  }

  param_00 attack_geist_drain_special_stop();
}

attack_geist_drain_special_spawn_interrupt_volume(param_00, param_01, param_02) {}

attack_geist_drain_special_stop() {
  var_00 = self;
  if(common_scripts\utility::func_562E(var_00.var_8BE)) {
    var_00.var_8BE = 0;
    var_00 notify("attack_geist_drain_special_stop");
  }
}

attack_geist_drain_special_wait_till_stopped() {
  var_00 = self;
  if(common_scripts\utility::func_562E(var_00.var_8BE)) {
    var_00 waittill("attack_geist_drain_special_stop");
  }
}

king_zombie_wins(param_00) {
  var_01 = self;
  var_01 maps\mp\zombies\_zombies_blood_tubes::enable_blood_vision();
  while(var_01.var_BC > 0) {
    var_01 dodamage(5, param_00.var_116, param_00, param_00, "MOD_CRUSH");
    wait 0.05;
    var_01 dodamage(5, param_00.var_116, param_00, param_00, "MOD_CRUSH");
    wait 0.05;
    var_01 dodamage(5, param_00.var_116, param_00, param_00, "MOD_CRUSH");
    wait 0.05;
    var_01 suicide();
    wait 0.05;
  }
}

special_geist_drain_special_fake_try() {
  var_00 = self;
  return 1;
}

special_geist_drain_special_fake_start() {
  var_00 = self;
  var_00.current_drain_special_fake = spawnStruct();
  var_01 = var_00.var_116;
  var_00 enable_geist_bullet_shield();
  var_00.current_drain_special_fake.var_2DA7 = king_create_destination(var_01);
}

special_geist_drain_special_fake_think() {
  var_00 = self;
  var_01 = var_00 king_is_in_or_waiting_for_scripted_state("geist_drain_special_fake");
  if(!common_scripts\utility::func_562E(var_00.current_drain_special_fake.anim_state_completed)) {
    if(!var_01) {
      var_00 thread lib_0547::func_7D1A("geist_drain_special_fake");
    }
  } else {
    return 1;
  }

  return 0;
}

special_geist_drain_special_fake_end() {
  var_00 = self;
  var_00 notify("geist_drain_special_fake_end");
  var_00.current_drain_special_fake = undefined;
}

anim_state_geist_drain_special_fake_run() {
  var_00 = self;
  var_00 endon("geist_drain_special_fake_end");
  if(!isDefined(var_00.current_drain_special_fake)) {
    return;
  }

  var_00 pause_manual_move();
  var_00 pause_manual_rotation();
  var_00 thread king_spawn_geist_drain_special_fake();
  var_00 anim_state_geist_drain_special_fake_cast_control();
  var_01 = var_00.current_drain_special_fake.var_7DF9;
  var_00.current_drain_special_fake.anim_state_completed = 1;
}

anim_state_geist_drain_special_fake_cast_control() {
  var_00 = self;
  if(isDefined(var_00.current_drain_special_fake.var_7DF9)) {
    return;
  }

  var_00 endon("geist_drain_special_fake_result");
  var_01 = maps\mp\agents\_scripted_agent_anim_util::func_434D("death_sit");
  var_02 = maps\mp\agents\_scripted_agent_anim_util::func_7A35(var_01);
  var_00 maps\mp\agents\_scripted_agent_anim_util::func_8415(var_01, var_02);
  var_00 waittill("forever");
}

king_geist_drain_special_fake_report_result(param_00) {
  var_01 = self;
  var_01.current_drain_special_fake.var_7DF9 = param_00;
  var_01 notify("geist_drain_special_fake_result", param_00);
}

king_spawn_geist_drain_special_fake() {
  var_00 = self;
  var_00 endon("geist_drain_special_fake_result");
  var_00 endon("geist_drain_special_fake_end");
  var_00 lib_0378::func_8D74("god_king_finale_drain_first");
  var_00 thread vo_play_gdk_ability_line("geist_drain");
  var_01 = "J_Wrist_LE";
  var_02 = "J_Wrist_RI";
  foreach(var_04 in level.var_744A) {
    if(distance2dsquared(var_00 gettagorigin(var_01), var_04.var_116) > distance2dsquared(var_00 gettagorigin(var_02), var_04.var_116)) {
      var_05 = var_02;
    } else {
      var_05 = var_01;
    }

    var_04.drain_beam = launchbeam("zmb_geistkraft_blood_beam_med_drain", var_00, var_05, var_04, "J_Head");
    var_04.drain_beam thread delete_on_parent_notify(var_04, "kill_fake_drain_beam");
    var_04 notify("drain_fake_start");
  }

  var_00 attack_geist_drain_special_fake_wait_till_stopped();
  var_00 thread king_geist_drain_special_fake_report_result("complete");
}

anim_state_geist_drain_special_fake_end() {}

attack_geist_drain_special_fake_wait_till_stopped() {
  var_00 = self;
  var_00 common_scripts\utility::knock_off_battery("attack_geist_drain_special_fake_stop", "transition_scene_done");
}

special_melee_try() {
  var_00 = self;
  var_01 = king_get_targets_in_range(280);
  if(isDefined(var_01)) {
    var_00.current_melee = spawnStruct();
    var_00.current_melee.melee_targets = var_01;
    var_00.current_melee.var_9297 = gettime();
    return 1;
  }

  return 0;
}

special_melee_start() {
  var_00 = self;
  var_01 = special_melee_pick_best_attack_and_yaw(var_00.current_melee.melee_targets);
  var_02 = var_01[0];
  var_03 = var_01[1];
  if(!isDefined(var_02) || !isDefined(var_03)) {
    return;
  }

  var_00.current_melee.rotation_target = create_rotation_target_yaw(var_03, 360);
  var_00 set_rotation_target(var_00.current_melee.rotation_target);
  var_00.current_melee.melee_struct = level.king_melee_attacks[var_02];
  var_00 thread lib_0547::func_7D1A("king_melee");
}

special_melee_pick_best_attack_and_yaw(param_00) {
  var_01 = self;
  var_02 = undefined;
  var_03 = 0;
  var_04 = undefined;
  var_05 = undefined;
  foreach(var_07 in param_00) {
    var_08 = vectortoyaw(var_07.var_116 - var_01.var_116);
    var_07.king_melee_aiming_yaw = angleclamp180(var_08 - var_01.var_1D[1]);
  }

  foreach(var_0F, var_0B in level.king_melee_attacks) {
    var_0C = 0;
    foreach(var_07 in param_00) {
      if(abs(var_07.king_melee_aiming_yaw - var_0B.arc_rotation_offset) < var_0B.var_F3E * 0.5 + var_0B.facing_rotation_allowed) {
        var_0C++;
      }
    }

    if(var_0C > var_03) {
      var_04 = 0;
      var_03 = var_0C;
      var_02 = var_0F;
    }
  }

  if(isDefined(var_04)) {
    var_05 = angleclamp180(var_04 + var_01.puck.var_1D[1]);
  }

  return [var_02, var_05];
}

special_melee_think() {
  var_00 = self;
  var_00 disable_geist_bullet_shield();
  var_01 = var_00 king_is_in_or_waiting_for_scripted_state("king_melee");
  if(!var_01 || common_scripts\utility::func_562E(var_00.current_melee.anim_state_completed)) {
    return 1;
  }

  return 0;
}

special_melee_end() {
  var_00 = self;
  var_00 notify("special_melee_end");
  var_00.current_melee = undefined;
}

anim_state_melee_run() {
  var_00 = self;
  var_00 endon("special_melee_end");
  if(!isDefined(var_00.current_melee)) {
    return;
  }

  var_01 = var_00.current_melee.melee_struct.anim_action;
  var_00 lib_0378::func_8D74("god_king_melee");
  var_02 = maps\mp\agents\_scripted_agent_anim_util::func_434D(var_01);
  var_03 = maps\mp\agents\_scripted_agent_anim_util::func_7A35(var_02);
  maps\mp\agents\_scripted_agent_anim_util::func_71FA(var_02, var_03, 1, "king_attack", "end", ::melee_handle_notetracks);
  var_00.current_melee.anim_state_completed = 1;
}

anim_state_melee_end() {
  var_00 = self;
  var_00 pause_manual_rotation();
  var_00 pause_manual_move();
}

melee_handle_notetracks(param_00, param_01, param_02, param_03) {
  var_04 = self;
  switch (param_00) {
    case "strike":
      var_04 melee_strike_notetrack();
      break;

    case "stop_rotation":
      var_04 pause_manual_rotation();
      break;
  }
}

melee_strike_notetrack() {
  var_00 = self;
  var_01 = var_00.current_melee.melee_struct;
  var_02 = var_00 gettagorigin("J_MainRoot");
  var_03 = king_get_all_targets();
  var_04 = angleclamp180(var_00.puck.var_1D[1] + var_01.arc_rotation_offset);
  var_05 = anglesToForward((0, var_04, 0));
  var_06 = cos(var_01.var_F3E / 2);
  var_0E = [];
  foreach(var_10 in var_03) {
    var_11 = approximate_script_hit_cylinder(var_10);
    var_12 = var_11[0];
    var_13 = var_11[1];
    var_07 = var_13 * 0.5;
    var_14 = var_10.var_116 + (0, 0, var_07);
    if(abs(var_02[2] - var_14[2]) > var_07 + 280) {
      continue;
    }

    if(distance2d(var_10.var_116, var_02) > 280 + var_12) {
      continue;
    }

    var_15 = vectornormalize(var_10.var_116 - var_02 * (1, 1, 0));
    if(vectordot(var_15, var_05) <= var_06) {
      continue;
    }

    var_0E[var_0E.size] = var_10;
  }

  foreach(var_10 in var_0E) {
    var_00 thread zombie_king_on_melee_hit_target(var_10);
  }
}

zombie_king_on_melee_hit_target(param_00) {
  var_01 = self;
  if(isPlayer(param_00)) {
    param_00 dodamage(80, var_01.var_116, var_01, var_01, "MOD_MELEE");
    param_00 thread run_melee_shellshock(var_01.var_116);
    return;
  }

  param_00 dodamage(param_00.var_BC + 666, var_01.var_116, var_01, var_01, "MOD_MELEE");
}

run_melee_shellshock(param_00) {
  var_01 = 2;
  var_02 = 2;
  var_03 = 300;
  self endon("death");
  self shellshock("zm_heavy_hit", var_02, var_01);
  self method_8308(0);
  self playrumbleonentity("damage_heavy");
  var_04 = self.var_116 - param_00;
  var_04 = (var_04[0], var_04[1], 0);
  var_04 = var_03 * vectornormalize(var_04);
  var_04 = (var_04[0], var_04[1], 125);
  wait(var_02);
  self setvelocity(var_04);
  self method_8308(1);
}

special_move_to_enemy_try(param_00) {
  var_01 = self;
  var_02 = king_get_closest_enemy_target();
  if(!isDefined(var_02)) {
    return 0;
  }

  var_01.current_move_to = spawnStruct();
  var_01.current_move_to.var_375E = var_02;
  return 1;
}

special_move_to_enemy_start(param_00) {
  var_01 = self;
  var_02 = var_01.current_move_to.var_375E;
  var_03 = var_02.var_116 + (0, 0, 42);
  var_04 = undefined;
  if(isDefined(param_00)) {
    var_04 = param_00[0];
  }

  var_01 enable_geist_bullet_shield();
  var_01.current_move_to.var_2DA7 = king_create_destination(var_03, var_04);
  var_01.current_move_to.backup_rotation_target = var_01 create_rotation_target_yaw(var_01.puck.var_1D[1]);
}

special_move_to_enemy_think() {
  var_00 = self;
  if(!var_00 king_enemy_target_is_valid(var_00.current_move_to.var_375E)) {
    var_01 = get_victim_player();
    if(!isDefined(var_01)) {
      var_01 = king_get_enemy_target();
    }

    if(isDefined(var_01)) {
      var_00.current_move_to.var_375E = var_01;
      var_00.current_move_to.rotation_target = var_00 create_rotation_target_ent(var_01);
      var_00 set_rotation_target(var_00.current_move_to.rotation_target);
      var_00 king_set_preselected_enemy(var_01);
    } else if(var_00.rotation_target != var_00.current_move_to.backup_rotation_target) {
      var_00 set_rotation_target(var_00.current_move_to.backup_rotation_target);
    }
  }

  var_02 = king_has_arrived(var_00.current_move_to.var_2DA7);
  if(!var_02) {
    king_continue_moving(var_00.current_move_to.var_2DA7);
  }

  return var_02;
}

special_move_to_enemy_end() {
  var_00 = self;
  var_00.current_move_to = undefined;
}

special_move_face_enemy_try(param_00) {
  var_01 = self;
  return 1;
}

special_move_face_enemy_start(param_00) {
  var_01 = self;
  var_01.current_move = spawnStruct();
  var_02 = get_new_boss_position();
  var_03 = undefined;
  if(isDefined(param_00)) {
    var_03 = param_00[0];
  }

  var_01 enable_geist_bullet_shield();
  var_01.current_move.var_2DA7 = king_create_destination(var_02, var_03);
  var_01.current_move.backup_rotation_target = var_01 create_rotation_target_yaw(var_01.puck.var_1D[1]);
}

special_move_face_enemy_think() {
  var_00 = self;
  if(!var_00 king_enemy_target_is_valid(var_00.current_move.var_375E)) {
    var_01 = get_victim_player();
    if(!isDefined(var_01)) {
      var_01 = king_get_enemy_target();
    }

    if(isDefined(var_01)) {
      var_00.current_move.var_375E = var_01;
      var_00.current_move.rotation_target = var_00 create_rotation_target_ent(var_01);
      var_00 set_rotation_target(var_00.current_move.rotation_target);
      var_00 king_set_preselected_enemy(var_01);
    } else if(var_00.rotation_target != var_00.current_move.backup_rotation_target) {
      var_00 set_rotation_target(var_00.current_move.backup_rotation_target);
    }
  }

  var_02 = king_has_arrived(var_00.current_move.var_2DA7);
  if(!var_02) {
    king_continue_moving(var_00.current_move.var_2DA7);
  }

  return var_02;
}

special_move_face_enemy_end() {
  var_00 = self;
  var_00.current_move = undefined;
}

register_boss_melee_move(param_00, param_01, param_02, param_03, param_04) {
  if(!isDefined(level.boss_melee_moves)) {
    level.boss_melee_moves = [];
  }

  if(isDefined(level.boss_melee_moves[param_00])) {}

  var_05 = spawnStruct();
  var_05.var_109 = param_00;
  var_05.try_func = param_01;
  var_05.var_920F = param_02;
  var_05.think_func = param_03;
  var_05.var_367E = param_04;
  level.boss_melee_moves[param_00] = var_05;
}

register_boss_special_attack_wrapper(param_00, param_01) {
  var_02 = undefined;
  if(common_scripts\utility::func_562E(param_01)) {
    var_02 = self.attack_uber[param_00];
  } else {
    var_02 = self.attack_basic[param_00];
  }

  var_03 = var_02.var_116E;
  var_04 = var_02.try_func;
  var_05 = var_02.var_920F;
  var_06 = var_02.think_func;
  var_07 = var_02.var_367E;
  var_08 = var_02.run_func;
  var_09 = var_02.scr_st;
  var_0A = var_02.scr_pri;
  var_0B = var_02.anim_end_func;
  register_boss_special_move(var_03, var_04, var_05, var_06, var_07);
  var_0C = level.boss_special_moves[var_03];
  var_0C.allow_pain = var_02.allow_pain;
  if(isDefined(var_09)) {
    lib_0547::func_7BD0(var_09, var_08, undefined, var_0A, var_0B);
  }
}

register_boss_special_move(param_00, param_01, param_02, param_03, param_04) {
  if(!isDefined(level.boss_special_moves)) {
    level.boss_special_moves = [];
  }

  if(isDefined(level.boss_special_moves[param_00])) {}

  var_05 = spawnStruct();
  var_05.var_109 = param_00;
  var_05.try_func = param_01;
  var_05.var_920F = param_02;
  var_05.think_func = param_03;
  var_05.var_367E = param_04;
  level.boss_special_moves[param_00] = var_05;
}

king_enemy_target_is_valid(param_00) {
  var_01 = self;
  if(!isDefined(param_00)) {
    return 0;
  }

  if(!isalive(param_00)) {
    return 0;
  }

  if(lib_0547::func_5565(level.zombie_king, param_00)) {
    return 0;
  }

  if(var_01 lib_0547::func_8B95(param_00)) {
    return 0;
  }

  if(param_00.var_CE || isDefined(param_00.var_117) && param_00.var_117.var_CE) {
    return 0;
  }

  if(param_00 method_8541() || isDefined(param_00.var_117) && param_00.var_117 method_8541()) {
    return 0;
  }

  return 1;
}

king_set_preselected_enemy(param_00) {
  var_01 = self;
  var_01.preselected_enemy = param_00;
}

king_get_preselected_enemy() {
  var_00 = self;
  var_01 = var_00.preselected_enemy;
  if(isDefined(var_01) && king_enemy_target_is_valid(var_01)) {
    var_00.preselected_enemy = undefined;
    return var_01;
  }

  return undefined;
}

king_get_preselected_enemy_player() {
  var_00 = self;
  var_01 = var_00.preselected_enemy;
  if(isDefined(var_01) && isPlayer(var_01) && king_enemy_target_is_valid(var_01)) {
    var_00.preselected_enemy = undefined;
    return var_01;
  }

  return undefined;
}

king_get_closest_enemy_target() {
  var_00 = self;
  var_01 = lib_053C::func_4F88();
  foreach(var_03 in var_01) {
    if(lib_0547::func_5565(var_03.var_983B, 1)) {
      return var_03;
    }
  }

  foreach(var_03 in var_01) {
    if(king_enemy_target_is_valid(var_03)) {
      return var_03;
    }
  }

  return undefined;
}

king_get_enemy_target() {
  var_00 = self;
  var_01 = var_00 king_get_preselected_enemy();
  if(isDefined(var_01)) {
    return var_01;
  }

  var_02 = lib_053C::func_4F88();
  foreach(var_04 in var_02) {
    if(lib_0547::func_5565(var_04.var_983B, 1)) {
      return var_04;
    }
  }

  foreach(var_04 in var_02) {
    if(king_enemy_target_is_valid(var_04)) {
      return var_04;
    }
  }

  return undefined;
}

king_get_detonate_target() {
  var_00 = lib_0547::func_408F();
  var_01 = get_victim_player();
  var_00 = function_01AC(var_00, var_01.var_116);
  var_00 = common_scripts\utility::func_FA2(var_00);
  foreach(var_03 in var_00) {
    if(king_enemy_target_is_valid(var_03) && !isPlayer(var_03) && var_03 lib_0547::func_4B2C()) {
      return var_03;
    }
  }

  return undefined;
}

king_get_all_targets() {
  var_00 = [];
  var_01 = lib_0547::func_408F();
  var_01 = common_scripts\utility::func_F73(var_01, level.var_744A);
  foreach(var_03 in var_01) {
    if(king_enemy_target_is_valid(var_03)) {
      if(isDefined(var_03.var_A4B) && !var_03 lib_0547::func_4B2C()) {
        continue;
      }

      var_00[var_00.size] = var_03;
    }
  }

  return var_00;
}

king_get_targets_in_range(param_00) {
  var_01 = self;
  var_02 = king_get_all_targets();
  var_02 = function_01AC(var_02, var_01.var_116, param_00);
  var_02 = common_scripts\utility::func_FA2(var_02);
  if(var_02.size > 0) {
    return var_02;
  }

  return undefined;
}

get_next_lightning_target() {
  var_00 = lib_0547::func_408F();
  var_01 = get_victim_player();
  var_00 = function_01AC(var_00, var_01.var_116, 128);
  foreach(var_03 in var_00) {
    if(king_enemy_target_is_valid(var_03) && !lib_0547::func_5565(var_03.islightningtarget, 1)) {
      return var_03;
    }
  }

  return undefined;
}

get_victim_player() {
  var_00 = self;
  var_01 = [];
  var_02 = [];
  var_03 = undefined;
  var_04 = var_00 king_get_preselected_enemy_player();
  if(isDefined(var_04)) {
    return var_04;
  }

  foreach(var_06 in level.var_744A) {
    if(lib_0547::func_5565(var_06.var_983B, 1)) {
      var_02[var_02.size] = var_06;
    }

    if(!lib_0547::func_577E(var_06) && !common_scripts\utility::func_562E(var_06.boss_victim_cooldown)) {
      var_01[var_01.size] = var_06;
    }
  }

  if(var_02.size >= 0) {
    var_03 = level.var_744A;
  } else if(var_01.size >= 0) {
    var_03 = level.var_744A;
  }

  var_08 = common_scripts\utility::func_7A33(var_03);
  var_08 thread set_victim_cooldown();
  return var_08;
}

set_victim_cooldown() {
  self notify("boss_set_victim_cooldown");
  self endon("boss_set_victim_cooldown");
  self.boss_victim_cooldown = 1;
  wait(3);
  self.boss_victim_cooldown = 0;
}

king_pick_blood_plate() {
  var_00 = self;
  var_01 = maps\mp\mp_zombie_descent::get_full_boss_blood_plates();
  if(var_01.size > 0) {
    var_01 = function_01AC(var_01, var_00.var_116);
    return var_01[0];
  }

  return undefined;
}

king_create_destination(param_00, param_01) {
  var_02 = spawnStruct();
  var_02.var_116 = param_00;
  var_02.move_targets = [];
  var_02.move_targets[0] = create_move_target(param_00, param_01);
  var_02.move_targets_reached = 0;
  var_02.var_18A = param_01;
  return var_02;
}

king_has_arrived(param_00) {
  var_01 = self;
  if(!lib_0547::func_5565(var_01.current_destination, param_00)) {
    return 0;
  }

  if(param_00.move_targets_reached < param_00.move_targets.size) {
    return 0;
  }

  return 1;
}

king_continue_moving(param_00) {
  var_01 = self;
  if(!lib_0547::func_5565(var_01.current_destination, param_00)) {
    thread king_set_destination_internal(param_00);
  }
}

king_is_facing_rotation_target(param_00) {
  var_01 = self;
  if(!lib_0547::func_5565(var_01.rotation_target, param_00)) {
    return 0;
  }

  var_02 = var_01 get_desired_rotation_yaw();
  if(abs(angleclamp180(var_02 - var_01.puck.var_1D[1])) < 22) {
    return 1;
  }

  return 0;
}

king_set_destination_internal(param_00) {
  var_01 = self;
  var_01 notify("new_destination");
  var_01 endon("death");
  var_01 endon("new_destination");
  var_01 king_create_destination_path(param_00);
  var_01 childthread king_handle_destination_path(param_00);
}

king_create_destination_path(param_00) {
  var_01 = self;
  var_02 = var_01.var_116;
  var_03 = param_00.var_116;
  if(distance(var_02, var_03) < 10) {
    param_00.move_targets_reached = param_00.move_targets.size;
    return;
  }

  param_00.move_targets_reached = 0;
  var_04 = param_00.var_18A;
  if(var_01 method_83EC(var_02, var_03, 32, 100, 1)) {
    param_00.move_targets = [create_move_target(var_03, var_04)];
    return;
  }

  param_00.move_targets = [];
  var_05 = getclosestpointonnavmesh(var_02, var_01);
  var_06 = getclosestpointonnavmesh(var_03, var_01);
  var_07 = var_01 method_857B(var_05, var_06);
  var_08 = vectornormalize(var_03 - var_02);
  for(var_09 = 1; var_09 < var_07.size - 1; var_09++) {
    var_0A = var_07[var_09];
    var_0B = var_0A - var_02;
    var_0C = lib_0547::func_776A(var_0B, var_08);
    var_0D = var_0C[0];
    var_0E = var_0C[1];
    var_0F = max(var_02[2] + var_0D[2], var_0A[2]);
    param_00.move_targets[param_00.move_targets.size] = create_move_target((var_0A[0], var_0A[1], var_0F), var_04);
  }

  param_00.move_targets[param_00.move_targets.size] = create_move_target(var_03, var_04);
}

king_handle_destination_path(param_00) {
  var_01 = self;
  var_02 = common_scripts\utility::func_FA3(param_00.move_targets, param_00.move_targets_reached);
  var_01 set_move_path(var_02);
  var_01.current_destination = param_00;
  while(var_01.current_destination.move_targets_reached < var_01.current_destination.move_targets.size) {
    var_03 = var_01.move_targets[0];
    var_03 waittill("complete");
    var_01.current_destination.move_targets_reached++;
  }
}

king_is_in_or_waiting_for_scripted_state(param_00) {
  var_01 = self;
  return var_01 lib_0547::is_in_scripted_state(param_00) || var_01 lib_0547::has_scripted_state_queued(param_00);
}

king_handle_attached_vfx_cleanup(param_00, param_01) {
  var_02 = self;
  var_02 maps\mp\agents\_agent_utility::deleteentonagentdeath(param_00);
  if(common_scripts\utility::func_562E(param_01)) {
    var_02 thread handle_clear_on_interrupt(param_00);
  }
}

handle_clear_on_interrupt(param_00) {
  var_01 = self;
  param_00 endon("entitydeleted");
  var_01 endon("death");
  common_scripts\utility::func_A70C(var_01, "stand_pain_interrupt", var_01, "invalid_target_interrupt");
  param_00 delete();
}

king_ishitweakpoint(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  if(isDefined(param_08) && param_08 == "soft") {
    return 1;
  }

  return 0;
}

king_on_damaged(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  var_0C = param_02;
  var_0D = self;
  if(lib_0547::func_5565(var_0D, param_01)) {
    param_02 = 0;
  }

  if(isPlayer(param_01) && common_scripts\utility::func_562E(var_0D.geistbulletshield) && !king_check_if_raven_weapons(param_05)) {
    param_02 = 0;
    god_king_impact_vfx(param_06, level.var_611["zmb_godking_gk_impact"]);
  }

  if(isPlayer(param_01) && common_scripts\utility::func_562E(var_0D.drainshieldacive)) {
    param_02 = 0;
    god_king_impact_vfx(param_06, level.var_611["zmb_godking_gk_impact"]);
  }

  if(isDefined(param_05) && isDefined(param_04)) {
    if(king_check_if_weapon_op(param_05, param_04) && param_02 > 1) {
      param_02 = int(param_02 * 0.65);
    }
  }

  if(isDefined(param_05) && isDefined(param_04)) {
    if(king_check_if_weapon_sap(param_05, param_04) && param_02 > 1) {
      param_02 = int(param_02 * 0.5);
    }
  }

  if(king_check_if_raven_weapons(param_05) && !common_scripts\utility::func_562E(var_0D.drainshieldacive)) {
    var_0E = "weakpoint";
    param_01 thread maps\mp\gametypes\_damagefeedback::func_A102(var_0E);
    param_02 = 49033.2;
  }

  if(king_check_if_raven_weapon_cleave(param_05) && !common_scripts\utility::func_562E(var_0D.drainshieldacive)) {
    param_02 = 24516.6;
  }

  if(isDefined(param_08) && param_08 == "soft") {
    var_0F = param_01 method_850B(param_05, param_08);
    var_10 = param_01 method_850B(param_05, "head");
    if(var_0F <= 0) {
      var_0F = 1;
    }

    var_11 = param_02 / var_0F;
    var_12 = var_11 * var_10;
    param_02 = int(var_12);
  }

  if(var_0D[[var_0D maps\mp\agents\_agent_utility::func_A59("is_hit_weak_point")]](var_0D, param_00, param_01, param_02, param_04, param_05, undefined, param_07, param_08)) {
    var_13 = param_01 method_850B(param_05, param_08);
    var_14 = function_01AA(param_05);
    if(var_13 == 0 || function_01AA(param_05) == "sniper") {} else {
      var_15 = int(param_02 / var_13);
      var_16 = var_13 * 0.5;
      var_17 = var_15 / var_16 * max(var_16 + 1, 0);
      param_02 = int(var_17);
    }
  }

  if(isPlayer(param_01) && maps\mp\zombies\weapons\_zombie_dlc4_melee::is_scythe_death_burst_weapon(param_05)) {
    var_0E = "weakpoint";
    param_01 thread maps\mp\gametypes\_damagefeedback::func_A102(var_0E);
    param_02 = var_0D.var_FB * 0.03;
  }

  if(param_02 > 0) {
    god_king_impact_vfx(param_06, level.var_611["blood_godking_impact_burst"]);
  }

  if(param_02 <= 0) {
    var_0E = "none";
    param_01 thread maps\mp\gametypes\_damagefeedback::func_A102(var_0E);
  }

  var_0D lib_054D::func_6BD1(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A);
}

init_impact_vfx() {
  var_00 = self;
  level.god_king_impact_vfx = [];
  for(var_01 = 0; var_01 < 4; var_01++) {
    var_02 = spawn("script_model", (0, 0, 0));
    var_02 setModel("tag_origin");
    var_02 thread lib_0547::func_2D19(var_00);
    level.god_king_impact_vfx[var_01] = var_02;
  }

  level.last_god_king_impact_vfx_index = -1;
}

god_king_impact_vfx(param_00, param_01) {
  var_02 = gettime();
  if(!lib_0547::func_5565(level.last_god_king_impact_vfx, var_02)) {
    var_03 = common_scripts\utility::func_627D(level.last_god_king_impact_vfx_index + 1, 4);
    var_04 = level.god_king_impact_vfx[var_03];
    var_04.var_116 = param_00;
    var_04 method_808C();
    playFXOnTag(param_01, var_04, "tag_origin");
    level.last_god_king_impact_vfx_index = var_03;
    level.last_god_king_impact_vfx = var_02;
  }
}

reflect_bullet(param_00, param_01, param_02, param_03, param_04) {
  if(lib_0547::func_5565(param_01, param_00)) {
    return;
  }

  if(maps\mp\_utility::func_5695(param_03)) {
    var_05 = param_04 + vectornormalize(vectornormalize(param_01 getEye() - param_04) + func_7A43(0.9)) * 3000;
    magicbullet(param_02, param_04, var_05, param_00);
  }
}

punish_damage_limit_reached() {
  if(!isDefined(self.punishdamage)) {
    return 0;
  }

  if(self.punishdamage > get_zombie_king_punish_limit()) {
    return 1;
  }

  return 0;
}

get_zombie_king_punish_limit() {
  var_00 = 5;
  switch (level.var_744A.size) {
    case 1:
      var_00 = 100000;
      break;

    case 2:
      var_00 = 150000;
      break;

    case 3:
      var_00 = 200000;
      break;

    case 4:
      var_00 = 300000;
      break;

    default:
      break;
  }

  return int(var_00);
}

king_on_damage_finished(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  var_0B = self;
  if(isPlayer(param_01) && common_scripts\utility::func_562E(var_0B.drainpunishactive) && !var_0B punish_damage_limit_reached()) {
    var_0C = "weakpoint";
    param_01 thread maps\mp\gametypes\_damagefeedback::func_A102(var_0C);
    param_02 = int(param_02 * 1.25);
    if(!isDefined(var_0B.punishdamage)) {
      var_0B.punishdamage = param_02;
    } else {
      var_0B.punishdamage = var_0B.punishdamage + param_02;
    }
  } else if(isPlayer(param_01) && common_scripts\utility::func_562E(var_0B.drainpunishactive) && var_0B punish_damage_limit_reached()) {
    var_0C = "none";
    param_01 thread maps\mp\gametypes\_damagefeedback::func_A102(var_0C);
    param_02 = 0;
  }

  if(param_02 == 0) {
    return;
  }

  foreach(var_0E in var_0B.king_damage_finished_funcs) {
    var_0B thread[[var_0E]](param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A);
  }

  lib_054D::func_6BD3(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A);
}

add_king_damage_finished_func(param_00, param_01) {
  var_02 = self;
  var_02.king_damage_finished_funcs[param_00] = param_01;
}

remove_king_damage_finished_func(param_00) {
  var_01 = self;
  var_01.king_damage_finished_funcs[param_00] = undefined;
}

state_default_run() {
  var_00 = self;
  var_00 start_manual_rotation();
  var_00 pause_manual_move();
  var_01 = 0;
  var_02 = 0;
  var_03 = undefined;
  var_04 = undefined;
  var_05 = undefined;
  var_06 = undefined;
  var_07 = 1;
  if(common_scripts\utility::func_562E(var_00.king_seated)) {
    var_08 = var_00 maps\mp\agents\_scripted_agent_anim_util::func_434D("death_sit");
    var_00 maps\mp\agents\_scripted_agent_anim_util::func_8415(var_08);
    var_00 waittill("forever");
  }

  for(;;) {
    if(!common_scripts\utility::func_562E(var_07)) {
      var_00 common_scripts\utility::func_A74B("manual_move_complete", 0.2);
    }

    var_07 = 0;
    var_06 = var_00 get_next_manual_move();
    var_09 = isDefined(var_06);
    if(var_09) {
      var_0A = get_manual_rotation_target_yaw_in_time(0.3);
      var_0B = vectortoyaw(var_06.var_116 - var_00.puck.var_116);
      var_0C = angleclamp180(var_0A - var_0B);
      var_04 = var_0B;
      var_05 = var_0A;
      if(var_01) {
        var_0D = get_angled_anim_info_for_action("strafe", var_0C);
        if(!lib_0547::func_5565(var_0D.var_E18, var_03)) {
          var_00 maps\mp\agents\_scripted_agent_anim_util::func_8415(var_0D.var_E84, var_0D.var_E18);
          var_03 = var_0D.var_E18;
        }
      } else {
        var_0D = var_01 get_angled_anim_info_for_action("stand_2_strafe", var_0D);
        var_00 maps\mp\agents\_scripted_agent_anim_util::func_71FA(var_0D.var_E84, var_0D.var_E18, 1, "king_move");
        var_00 start_manual_move();
        var_01 = 1;
        var_03 = undefined;
        var_02 = 0;
        var_07 = 1;
      }

      continue;
    }

    if(var_01) {
      var_00 pause_manual_move();
      var_0C = angleclamp180(var_05 - var_04);
      var_0D = var_00 get_angled_anim_info_for_action("strafe_2_stand", var_0C);
      var_00 maps\mp\agents\_scripted_agent_anim_util::func_71FA(var_0D.var_E84, var_0D.var_E18, 1, "king_move");
      var_01 = 0;
      var_0E = undefined;
      var_07 = 1;
      continue;
    }

    if(!var_02) {
      var_08 = var_00 maps\mp\agents\_scripted_agent_anim_util::func_434D("idle");
      var_00 maps\mp\agents\_scripted_agent_anim_util::func_8415(var_08);
      var_02 = 1;
    }
  }
}

king_control_for_rotation_animation(param_00, param_01) {
  var_02 = self;
  var_03 = var_02 method_83D8(param_00.var_E84, param_00.var_E18);
  var_04 = getanimlength(var_03);
  var_05 = maps\mp\agents\_scripted_agent_anim_util::func_45B9(var_03, "rotation_start", 0);
  var_06 = maps\mp\agents\_scripted_agent_anim_util::func_45B9(var_03, "rotation_end", 1);
  if(var_04 == 0) {
    return;
  }

  var_07 = var_04 * var_05;
  if(var_07 > 0) {
    wait(var_07);
  }

  var_08 = var_04 * var_06 - var_07;
  var_09 = (0, param_01, 0);
  var_02.puck rotateto(var_09, var_08);
  if(var_02.rotation_target.var_1B9 == "ent") {
    var_02 start_manual_rotation();
  }

  wait(var_08);
}

state_default_interrupt() {
  thread lib_0547::func_7D1A("king_default");
}

state_default_end() {
  var_00 = self;
  var_00 pause_manual_move();
  var_00 pause_manual_rotation();
}

get_angled_anim_info_for_action(param_00, param_01) {
  var_02 = spawnStruct();
  var_03 = self;
  var_02.var_E84 = var_03 maps\mp\agents\_scripted_agent_anim_util::func_434D(param_00);
  var_04 = var_03 method_83DB(var_02.var_E84);
  var_02.var_E18 = maps\mp\agents\_scripted_agent_anim_util::func_4416(param_01, var_04);
  return var_02;
}

get_possible_boss_positions() {
  var_00 = undefined;
  if(common_scripts\utility::func_562E(level.king_level_setup)) {
    if(lib_0547::func_5565(level.zombie_king.current_phase_index, 0)) {
      return level.bossfight.boss_pos_wave0;
    } else if(lib_0547::func_5565(level.zombie_king.current_phase_index, 1)) {
      return level.bossfight.boss_pos_wave1;
    } else if(lib_0547::func_5565(level.zombie_king.current_phase_index, 2)) {
      return level.bossfight.boss_pos_wave2;
    } else if(lib_0547::func_5565(level.zombie_king.current_phase_index, 3)) {
      return level.bossfight.boss_pos_wave3;
    } else if(lib_0547::func_5565(level.zombie_king.current_phase_index, 6)) {
      return level.bossfight.boss_pos_wave6;
    }

    return [level.bossfight.default_boss_pos];
  }

  var_01 = spawnStruct();
  var_01.var_116 = (randomintrange(-500, 500), randomintrange(-500, 500), randomintrange(0, 500));
  return [var_01];
}

get_new_boss_position() {
  var_00 = self;
  var_01 = get_possible_boss_positions();
  var_01 = common_scripts\utility::func_F92(var_01);
  foreach(var_03 in var_01) {
    if(distancesquared(var_03.var_116, var_00.puck.var_116) > 100) {
      return var_03.var_116;
    }
  }

  return var_01[0].var_116;
}

get_random_boss_position() {
  var_00 = get_possible_boss_positions();
  var_01 = common_scripts\utility::func_7A33(var_00);
  return var_01.var_116;
}

get_random_boss_sun_position() {
  var_00 = common_scripts\utility::func_7A33(level.bossfight.boss_sun_pos);
  return var_00.var_116;
}

get_random_boss_blood_position() {
  if(common_scripts\utility::func_562E(level.king_level_setup)) {
    var_00 = common_scripts\utility::func_7A33(level.bossfight.boss_blood_pos);
    return var_00.var_116;
  }

  return (randomintrange(-500, 500), randomintrange(-500, 500), randomintrange(0, 500));
}

get_boss_pull_position(param_00) {
  if(common_scripts\utility::func_562E(level.king_level_setup)) {
    if((!param_00 common_scripts\utility::func_3794("phase_transition_active") && lib_0547::func_5565(param_00.current_phase_index, 3)) || lib_0547::func_5565(param_00.current_phase_index, 4)) {
      var_01 = level.bossfight.throne_pos;
    } else {
      var_01 = level.bossfight.boss_drain_pos;
    }

    return var_01.var_116;
  }

  return (randomintrange(-500, 500), randomintrange(-500, 500), randomintrange(0, 500));
}

king_handle_pain() {
  var_00 = self;
  var_00 endon("death");
  var_00.lastpaindamagetick = 20;
  var_00 add_king_damage_finished_func("pain_watch", ::king_pain_on_damage_finished);
}

king_pain_on_damage_finished(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  var_0B = self;
  if(!common_scripts\utility::func_562E(var_0B.standing_pain_allowed)) {
    return;
  }

  if(var_0B king_is_in_or_waiting_for_scripted_state("king_stand_pain")) {
    return;
  }

  var_0C = ceil(var_0B.var_BC / var_0B.var_FB * 20);
  var_0D = var_0C < var_0B.lastpaindamagetick;
  if(var_0D) {
    var_0B thread lib_0547::func_7D1A("king_stand_pain", [param_08, param_07], 0.2);
    var_0B.lastpaindamagetick = var_0C;
    return;
  }

  if(var_0C > var_0B.lastpaindamagetick) {
    var_0B.lastpaindamagetick = var_0C;
  }
}

anim_state_stand_pain_run(param_00, param_01) {
  var_02 = self;
  var_02 notify("stand_pain_interrupt");
  var_02.was_pain_interrupted = 1;
  var_03 = "pain_stand_head";
  if(isDefined(param_00) && param_00 != "head" && isDefined(param_01)) {
    var_04 = anglestoright(var_02.puck.var_1D);
    if(vectordot(var_04, param_01) > 0) {
      var_03 = "pain_stand_right";
    } else {
      var_03 = "pain_stand_left";
    }
  }

  var_05 = maps\mp\agents\_scripted_agent_anim_util::func_434D(var_03);
  var_06 = maps\mp\agents\_scripted_agent_anim_util::func_7A35(var_05);
  var_02 maps\mp\agents\_scripted_agent_anim_util::func_71FA(var_05, var_06, 1, "", "end");
}

anim_state_stand_pain_interrupt(param_00, param_01) {}

anim_state_stand_pain_end(param_00, param_01) {}

king_try_interrupted_by_pain() {
  var_00 = self;
  var_01 = common_scripts\utility::func_562E(var_00.was_pain_interrupted);
  var_00.was_pain_interrupted = 0;
  return var_01;
}

handle_manual_move() {
  var_00 = self;
  var_00 endon("death");
  var_01 = spawn("script_model", self.var_116);
  var_01 setModel("tag_origin");
  var_01.var_1D = (0, var_00.var_1D[1], 0);
  var_01 thread lib_0547::func_2D19(var_00);
  var_00.puck = var_01;
  var_00.move_targets = [];
  var_00 common_scripts\utility::func_3799("manual_move_enabled");
  var_00 method_839D("noclip");
  var_00 method_855A(0.1, 0.1, var_00.puck, "tag_origin", "tag_sync");
  for(;;) {
    var_02 = var_00 wait_for_valid_manual_move();
    var_03 = var_00 do_manual_move(var_02);
  }
}

do_manual_move(param_00) {
  var_01 = self;
  var_01.current_move_target = param_00;
  var_01 thread manual_move_motion(param_00);
  var_01 waittill("manual_move_end", var_02);
  if(isDefined(var_02)) {
    switch (var_02) {
      case "result_complete":
        on_manual_move_complete(param_00);
        break;
    }
  }

  var_01.current_move_target = undefined;
  wait(0);
  return var_02;
}

manual_move_motion(param_00) {
  var_01 = self;
  var_01 endon("manual_move_end");
  var_02 = distance(var_01.puck.var_116, param_00.var_116);
  var_03 = var_02 / param_00.var_18A;
  if(var_02 == 0) {
    wait 0.05;
  } else {
    param_00.var_9255 = var_01.puck.var_116;
    param_00.var_9297 = gettime() / 1000;
    param_00.var_36AD = param_00.var_9297 + var_03;
    var_01.puck moveto(param_00.var_116, var_03);
    wait(var_03);
    wait 0.05;
  }

  var_01 notify("manual_move_end", "result_complete");
}

wait_for_valid_manual_move() {
  var_00 = self;
  var_00 endon("death");
  for(;;) {
    var_01 = get_next_manual_move();
    if(var_00 common_scripts\utility::func_3794("manual_move_enabled") && isDefined(var_01)) {
      return var_01;
    }

    var_00 common_scripts\utility::knock_off_battery("manual_move_enabled", "new_manual_move");
  }
}

on_manual_move_complete(param_00) {
  var_01 = self;
  param_00 notify("complete");
  var_01 notify("manual_move_complete");
  var_01.move_targets = common_scripts\utility::func_F93(var_01.move_targets, param_00);
}

get_next_manual_move() {
  var_00 = self;
  if(!isDefined(var_00.move_targets) || var_00.move_targets.size == 0) {
    return undefined;
  }

  return var_00.move_targets[0];
}

start_manual_move() {
  var_00 = self;
  if(var_00 common_scripts\utility::func_3794("manual_move_enabled")) {
    return;
  }

  var_00 common_scripts\utility::func_379A("manual_move_enabled");
  var_00.puck.var_116 = var_00 gettagorigin("tag_sync");
  var_00.puck.var_1D = var_00 gettagangles("tag_sync");
}

pause_manual_move() {
  var_00 = self;
  if(!var_00 common_scripts\utility::func_3794("manual_rotate_enabled")) {
    return;
  }

  var_00.puck moveto(var_00.puck.var_116, 0.1);
  if(isDefined(var_00.current_move_target)) {
    var_00 notify("manual_move_end", "result_paused");
  }

  var_00 common_scripts\utility::func_3796("manual_move_enabled");
}

set_move_path(param_00) {
  var_01 = self;
  var_01.move_targets = param_00;
  on_move_targets_changed();
}

set_move_target(param_00) {
  var_01 = self;
  var_01.move_targets = [param_00];
  on_move_targets_changed();
}

on_move_targets_changed() {
  var_00 = self;
  var_00 notify("new_manual_move");
  if(isDefined(var_00.current_move_target) && !lib_0547::func_5565(var_00.move_targets[0], var_00.current_move_target)) {
    var_00 notify("manual_move_end", "result_replaced");
  }

  if(isDefined(var_00.current_destination)) {
    var_00.current_destination = undefined;
  }
}

add_to_end_of_path(param_00) {
  var_01 = self;
  var_01.move_targets = common_scripts\utility::func_F6F(var_01.move_targets, param_00);
  var_01 notify("new_manual_move");
}

go_to_position(param_00) {
  set_move_target(create_move_target(param_00));
}

create_move_target(param_00, param_01) {
  var_02 = self;
  var_03 = spawnStruct();
  if(!isDefined(param_01) || param_01 == 0) {
    param_01 = 485;
  }

  var_03.var_116 = param_00;
  var_03.var_18A = param_01;
  return var_03;
}

handle_manual_rotation() {
  var_00 = self;
  var_00 endon("death");
  var_00 common_scripts\utility::func_3799("manual_rotate_enabled");
  for(;;) {
    wait_for_valid_rotation_target();
    var_01 = get_desired_rotation_yaw();
    var_02 = angleclamp180(var_01 - var_00.puck.var_1D[1]);
    var_03 = 220;
    var_04 = abs(var_02) / var_03;
    var_05 = (0, var_01, 0);
    if(var_04 > 0) {
      var_04 = max(0.2, var_04);
      var_00.puck rotateto(var_05, var_04);
      var_00.rotation_target.last_yaw_target = var_01;
      var_00.rotation_target.last_end_time = gettime() / 1000 + var_04;
      wait(0.2);
      continue;
    }

    wait 0.05;
  }
}

wait_for_valid_rotation_target() {
  var_00 = self;
  for(;;) {
    if(isDefined(var_00.rotation_target) && var_00 common_scripts\utility::func_3794("manual_rotate_enabled")) {
      return;
    }

    var_00 common_scripts\utility::knock_off_battery("manual_rotate_enabled", "new_rotation_target");
  }
}

start_manual_rotation() {
  var_00 = self;
  if(var_00 common_scripts\utility::func_3794("manual_rotate_enabled")) {
    return;
  }

  var_00 common_scripts\utility::func_379A("manual_rotate_enabled");
}

pause_manual_rotation() {
  var_00 = self;
  if(!var_00 common_scripts\utility::func_3794("manual_rotate_enabled")) {
    return;
  }

  var_00 common_scripts\utility::func_3796("manual_rotate_enabled");
  var_00.puck rotateto(var_00.puck.var_1D, 0.05);
}

get_desired_rotation_yaw() {
  var_00 = self;
  if(!isDefined(var_00.rotation_target)) {
    return var_00.puck.var_1D[1];
  }

  switch (var_00.rotation_target.var_1B9) {
    case "yaw":
      return var_00.rotation_target.var_AAE8;

    case "origin":
      return vectortoyaw(var_00.rotation_target.var_116 - var_00.puck.var_116);

    case "ent":
      return vectortoyaw(var_00.rotation_target.var_378F.var_116 - var_00.puck.var_116);
  }

  return var_00.puck.var_1D[1];
}

get_manual_rotation_target_yaw_in_time(param_00) {
  var_01 = self;
  if(!var_01 common_scripts\utility::func_3794("manual_rotate_enabled") || !isDefined(var_01.rotation_target)) {
    return var_01.puck.var_1D[1];
  }

  switch (var_01.rotation_target.var_1B9) {
    case "yaw":
      return var_01.rotation_target.var_AAE8;

    case "origin":
      var_02 = var_01 get_expected_position_in_time(param_00);
      return vectortoyaw(var_01.rotation_target.var_116 - var_02);

    case "ent":
      var_02 = var_02 get_expected_position_in_time(var_01);
      return vectortoyaw(var_01.rotation_target.var_378F.var_116 - var_02);
  }

  return var_02.puck.var_1D[1];
}

get_expected_position_in_time(param_00) {
  var_01 = self;
  var_02 = var_01.var_116;
  if(var_01 common_scripts\utility::func_3794("manual_move_enabled")) {
    var_02 = var_01.puck.var_116;
    if(isDefined(var_01.current_move_target)) {
      var_03 = var_01.current_move_target;
      var_04 = gettime() / 1000 + param_00;
      if(var_04 < var_03.var_9297) {
        var_02 = var_01.puck.var_116;
      } else if(var_04 < var_03.var_36AD) {
        var_05 = var_04 - var_03.var_9297 / var_03.var_36AD - var_03.var_9297;
        var_02 = vectorlerp(var_03.var_9255, var_03.var_116, clamp(var_05, 0, 1));
      } else {
        var_02 = var_03.var_116;
      }
    }
  }

  return var_02;
}

set_rotation_target(param_00) {
  var_01 = self;
  var_01 notify("new_rotation_target");
  var_01.rotation_target = param_00;
}

create_rotation_target_shared(param_00) {
  var_01 = spawnStruct();
  if(!isDefined(param_00)) {
    param_00 = 220;
  }

  var_01.rot_speed = param_00;
  return var_01;
}

create_rotation_target_yaw(param_00, param_01) {
  var_02 = create_rotation_target_shared(param_01);
  var_02.var_1B9 = "yaw";
  var_02.var_AAE8 = param_00;
  return var_02;
}

create_rotation_target_origin(param_00, param_01) {
  var_02 = create_rotation_target_shared(param_01);
  var_02.var_1B9 = "origin";
  var_02.var_116 = param_00;
  return var_02;
}

create_rotation_target_ent(param_00, param_01) {
  var_02 = create_rotation_target_shared(param_01);
  var_02.var_1B9 = "ent";
  var_02.var_378F = param_00;
  return var_02;
}

boss_blood_plate_drain() {
  var_00 = self;
  var_00 endon("release_plate");
  for(;;) {
    var_00 maps\mp\mp_zombie_descent::blood_plate_subtract();
    wait(0.85);
  }
}

enable_geist_bullet_shield() {
  var_00 = self;
  if(common_scripts\utility::func_562E(var_00.geistbulletshield)) {
    return;
  }

  var_00.geistbulletshield = 1;
  if(isDefined(level.zombie_king_sword)) {
    var_00.shieldprotectionfx = spawnlinkedfx(level.var_611["zmb_godking_sword_protection"], level.zombie_king_sword, "TAG_FX");
    triggerfx(var_00.shieldprotectionfx);
  }
}

disable_geist_bullet_shield() {
  var_00 = self;
  if(!common_scripts\utility::func_562E(var_00.geistbulletshield)) {
    return;
  }

  var_00.geistbulletshield = undefined;
  if(isDefined(var_00.shieldprotectionfx)) {
    var_00.shieldprotectionfx delete();
  }
}

vo_play_gdk_line(param_00) {
  self endon("death");
  while(common_scripts\utility::func_562E(self.gdk_speaking)) {
    wait 0.05;
  }

  self.gdk_speaking = 1;
  self.ability_vo = lib_0380::func_288B(param_00, level.var_744A, self, 0, 1);
  var_01 = lookupsoundlength(param_00);
  if(isDefined(self.ability_vo)) {
    wait(var_01);
    level notify("level_gdk_ability_line_done");
    self.ability_vo = undefined;
  }

  self.gdk_speaking = 0;
}

vo_play_gdk_ability_line(param_00) {
  self endon("death");
  var_01 = vo_get_gdk_ability_line(param_00);
  if(isDefined(var_01)) {
    vo_play_gdk_line(var_01);
  }
}

vo_get_gdk_ability_line(param_00) {
  self endon("death");
  var_01 = "zmb_dlc4_fzn_dwn_gdk_";
  var_02 = undefined;
  var_03 = undefined;
  switch (param_00) {
    case "geist_bomb_toss":
      var_02 = common_scripts\utility::func_7A33(["youcanrunfrompainbutyouwi", "feelmypowerwashoveryou"]);
      var_03 = 1;
      break;

    case "kneel_tell":
      var_02 = common_scripts\utility::func_7A33(["youcannotescapemymajesty", "gatherbeforemesupplicants"]);
      break;

    case "kneel_execute":
      var_02 = common_scripts\utility::func_7A33(["kneelbeforeyourlord", "kneelbowyourheadsbeforedi"]);
      break;

    case "geist_drain":
      var_02 = common_scripts\utility::func_7A33(["paytributetoyourlord", "vesselsaremeanttobeemptie", "yourwillshallbreakitalway"]);
      break;

    case "light_of_the_sun":
      var_02 = common_scripts\utility::func_7A33(["thesunandmooncowerbeforem", "lookuponyourfinaldawn"]);
      break;

    case "overwhelm_force":
      var_02 = common_scripts\utility::func_7A33(["riseminionsicommandyou", "noforcecanresistmywill"]);
      break;

    case "flame_wave":
      var_02 = common_scripts\utility::func_7A33(["yourfleshshallwither", "yourbonesshallbreak"]);
      break;

    case "end_taunt":
      var_04 = ["evennowyoucannotdefeatme", "relyingonbirdstosuccoryou"];
      var_02 = var_04[self.vo_taunt_int];
      self.vo_taunt_int = common_scripts\utility::func_627D(self.vo_taunt_int + 1, var_04.size);
      break;

    case "end_fail":
      var_02 = "yourmercyisweakness";
      break;

    case "end_succeed":
      var_02 = "andsothecyclecontinuesthi";
      break;

    case "drain_punished":
      var_05 = ["thisthisisnotwhatiwantedi", "betrayedbymyknightsprison", "aaarghgahneveryoudareno", "cowardsstrikemedownevenno"];
      var_02 = var_05[self.vo_drain_punished_int];
      self.vo_drain_punished_int = common_scripts\utility::func_627D(self.vo_drain_punished_int + 1, var_05.size);
      break;

    case "intro":
      var_02 = "yourpainyourbloodyourterr";
      break;
  }

  if(common_scripts\utility::func_562E(var_03) && self.vo_lines_played.size > 0 && isDefined(common_scripts\utility::func_F7E(self.vo_lines_played, param_00)) && common_scripts\utility::func_24A6()) {
    var_02 = undefined;
  }

  if(isDefined(self.vo_lines_played) && !isDefined(common_scripts\utility::func_F7E(self.vo_lines_played, param_00))) {
    self.vo_lines_played[self.vo_lines_played.size] = param_00;
  }

  if(isDefined(var_02)) {
    var_02 = var_01 + var_02;
  }

  return var_02;
}

temp_idle_anim() {
  var_00 = self;
  var_01 = var_00 maps\mp\agents\_scripted_agent_anim_util::func_434D("idle");
  var_02 = var_00 method_83DB(var_01);
  var_03 = gettime();
  var_04 = randomint(var_02);
  var_00 maps\mp\agents\_scripted_agent_anim_util::func_71FA(var_01, var_04, 1);
}

sort_tags_by_distance(param_00, param_01, param_02) {
  for(var_03 = 0; var_03 < param_02.size - 1; var_03++) {
    for(var_04 = var_03 + 1; var_04 < param_02.size; var_04++) {
      if(distance(param_00, param_01 gettagorigin(param_02[var_04])) < distance(param_00, param_01 gettagorigin(param_02[var_03]))) {
        var_05 = param_02[var_04];
        param_02[var_04] = param_02[var_03];
        param_02[var_03] = var_05;
      }
    }
  }

  return param_02;
}

sort_tags_by_distance_2d(param_00, param_01, param_02) {
  for(var_03 = 0; var_03 < param_02.size - 1; var_03++) {
    for(var_04 = var_03 + 1; var_04 < param_02.size; var_04++) {
      if(distance2d(param_00, param_01 gettagorigin(param_02[var_04])) < distance2d(param_00, param_01 gettagorigin(param_02[var_03]))) {
        var_05 = param_02[var_04];
        param_02[var_04] = param_02[var_03];
        param_02[var_03] = var_05;
      }
    }
  }

  return param_02;
}

king_spawn_pickups(param_00) {
  var_01 = getgroundposition(param_00 + org_randomization(64), 12, 128, 12);
  maps\mp\gametypes\zombies::func_281C("ammo", var_01, "king zombie spawn", 1, 0);
  if(lib_0547::is_solo()) {
    var_01 = getgroundposition(param_00 + org_randomization(64), 12, 128, 12);
    maps\mp\gametypes\zombies::func_281C("ability_fill", var_01, "king zombie spawn", 1, 0);
  }
}

org_randomization(param_00) {
  return (randomint(param_00), randomint(param_00), 0);
}

zombie_king_play_dead() {
  var_00 = self;
  var_00 notify("geist_drain_special_end");
  var_00 notify("fight_complete");
  var_00 notify("it_is_over");
  var_00.var_480F = 0;
  var_00.var_1DEB = 1;
  wait 0.05;
  var_00 dodamage(var_00.var_BC + 666, var_00.var_116);
  level.zombie_king_corpse = spawn("script_model", level.bossfight.throne_pos.var_116);
  level.zombie_king_corpse setModel("zom_darkone_base");
  level.zombie_king_corpse.var_1D = level.bossfight.throne_pos.var_1D;
  level.zombie_king_corpse method_8495("s2_zom_gdk_death_finale", level.bossfight.throne_pos.var_116, level.bossfight.throne_pos.var_1D, "forever", 10.06);
  level.zombie_king_corpse scriptmodelpauseanim(1);
  level.zombie_king_corpse thread vo_play_gdk_ability_line("end_succeed");
  while(isDefined(var_00) && lib_0547::func_5565(var_00.var_A4B, "zombie_king")) {
    if(common_scripts\utility::func_562E(var_00.var_480F)) {
      var_00.var_480F = 0;
    }

    var_00 dodamage(var_00.var_BC + 666, var_00.var_116);
    wait 0.05;
  }
}

set_player_ravenlord_state() {
  var_00 = self;
  var_00.isravenlordstate = 1;
  var_00 endon("disconnect");
  var_00 endon("raven_powers_removed");
  lib_0547::playfxclient_for_player("zmb_desc_player_finale_screen", var_00.var_116, var_00);
  var_00 thread spawn_wings_think();
  var_00 ravenlord_apply_health_to_players();
  var_00 lib_0547::func_73AC(3);
  var_00 childthread ravenlord_ammo_refill();
  var_00 childthread ravenlord_lethal_refill();
  var_00 childthread ravenlord_tactical_refill();
  var_00 childthread ravenlord_armor_refill();
  var_00 childthread ravenlord_special_refill();
  var_00 waittill("forever");
}

spawn_wings_think() {
  var_00 = self;
  var_00 endon("disconnect");
  for(;;) {
    var_00 spawn_wings();
    var_00 waittill("zombie_player_spawn_finished");
  }
}

spawn_wings() {
  var_00 = self;
  if(isDefined(var_00.wing_fx)) {
    var_00.wing_fx delete();
  }

  var_00.wing_fx = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_desc_player_wings"), var_00, "J_Spine4");
  triggerfx(var_00.wing_fx);
  var_00 maps\mp\gametypes\_playerlogic::deleteentonplayerdisconnect(var_00.wing_fx);
  var_00.wing_fx thread lib_0547::func_2D19(var_00);
}

ravenlord_ammo_refill() {
  var_00 = self;
  for(;;) {
    wait(8);
    var_01 = var_00 getcurrentweapon();
    if(var_01 == "none" || lib_0547::func_57AF(var_01) || lib_0547::func_5862(var_01) || lib_0547::iszombieconsumableweapon(var_01) || lib_0547::func_5864(var_01) || lib_0547::func_585C(var_01) || maps\mp\zombies\_zombies_magicbox::is_grenadier_immune_weapon(var_01)) {
      continue;
    }

    var_02 = var_00 getweaponammoclip(var_01);
    var_03 = weaponclipsize(var_01);
    var_04 = var_00 getweaponammostock(var_01);
    var_05 = weaponmaxammo(var_01);
    if(var_04 < var_05) {
      var_06 = int(var_05 * 0.04);
      var_07 = var_04;
      if(var_06 + var_04 >= var_05) {
        var_07 = var_05;
      } else {
        var_07 = var_07 + var_06;
      }

      var_00 setweaponammostock(var_01, var_07);
    }

    if(var_02 < var_03) {
      while(var_00 isreloading()) {
        wait 0.05;
      }

      var_08 = int(var_03 * 0.04);
      var_07 = var_02;
      if(var_08 + var_02 >= var_03) {
        var_07 = var_03;
      } else {
        var_07 = var_07 + var_08;
      }

      var_00 method_82FA(var_01, var_07);
    }

    if(issubstr(var_01, "dlcgun1")) {
      var_03 = weaponclipsize(var_01);
      var_00 method_82FA(var_01, var_03, "right");
    }
  }
}

ravenlord_lethal_refill() {
  var_00 = self;
  for(;;) {
    wait(18);
    if(isDefined(var_00._dlc4_weapon_manager) && isDefined(var_00._dlc4_weapon_manager["stored_lethal"])) {
      var_01 = var_00._dlc4_weapon_manager["stored_lethal"];
      var_02 = var_00 getweaponammoclip(var_01);
      var_03 = weaponclipsize(var_00._dlc4_weapon_manager["stored_lethal"], self);
      if(var_02 >= var_03) {
        var_00._dlc4_weapon_manager["stored_lethal_ammo"] = var_03;
      }

      continue;
    }

    var_01 = var_00 method_834A();
    var_02 = var_00 getweaponammoclip(var_01);
    var_03 = weaponclipsize(var_01, var_00);
    if(var_02 < var_03) {
      var_00 method_82FA(var_01, var_02 + 1);
    }
  }
}

ravenlord_tactical_refill() {
  var_00 = self;
  for(;;) {
    wait(18);
    if(isDefined(var_00._dlc4_weapon_manager) && isDefined(var_00._dlc4_weapon_manager["stored_tactical"])) {
      var_01 = var_00._dlc4_weapon_manager["stored_tactical"];
      var_02 = var_00 getweaponammoclip(var_01);
      var_03 = weaponclipsize(var_00._dlc4_weapon_manager["stored_tactical"], self);
      if(var_02 >= var_03) {
        var_00._dlc4_weapon_manager["stored_tactical_ammo"] = var_03;
      }

      continue;
    }

    var_01 = var_00 method_831F();
    var_02 = var_00 getweaponammoclip(var_01);
    var_03 = weaponclipsize(var_01, var_00);
    if(var_02 >= var_03) {
      var_00 method_82FA(var_01, var_02 + 1);
    }
  }
}

ravenlord_armor_refill() {
  var_00 = self;
  for(;;) {
    wait(26);
    var_00 lib_0547::func_73AC(1);
  }
}

ravenlord_special_refill() {
  var_00 = self;
  for(;;) {
    wait(1);
    var_00 lib_0533::func_F37(0.005, 1, 1);
  }
}

ravenlord_apply_health_to_players() {
  if(self.var_BC < self.var_FB) {
    self.var_BC = self.var_BC + 100;
  }

  if(self.var_BC > self.var_FB) {
    self.var_BC = self.var_FB;
  }
}

func_7A43(param_00) {
  return (randomfloatrange(param_00 * -1, param_00), randomfloatrange(param_00 * -1, param_00), randomfloatrange(param_00 * -1, param_00));
}

func_7A44(param_00) {
  return (randomfloatrange(param_00 * -1, param_00), randomfloatrange(param_00 * -1, param_00), 0);
}

random_2d_vector_safe_zone(param_00, param_01, param_02) {
  var_03 = anglesToForward((0, randomint(359), 0));
  var_04 = randomintrange(param_01, param_02);
  var_05 = var_03 * var_04;
  var_06 = var_05 + param_00.var_116;
  return var_06;
}