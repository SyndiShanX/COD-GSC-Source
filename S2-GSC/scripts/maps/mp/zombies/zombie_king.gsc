/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\zombie_king.gsc
***************************************************/

#using_animtree("zombie_king");

init() {
  maps\mp\agents\_scripted_agent_anim_util::_id_5159("zombie_king");
  level._id_0A41["zombie_king"] = level._id_0A41["zombie"];
  level._id_0A41["zombie_king"]["think"] = ::king_think;
  level._id_0A41["zombie_king"]["on_damaged_finished"] = ::king_on_damage_finished;
  level._id_0A41["zombie_king"]["on_damaged"] = ::king_on_damaged;
  level._id_0A41["zombie_king"]["is_hit_weak_point"] = ::king_ishitweakpoint;
  var_0 = spawnStruct();
  var_0._id_0A4B = "zombie_king";
  var_0._id_0EAE = "zombie_king_animclass";
  var_0._id_0E88 = "zombie_king";
  var_0._id_0879 = "zombie_king";
  var_0._id_4C12 = 10;
  var_0.overridehealth = int(2451660);
  var_0._id_60E2 = 65;
  var_0._id_8302 = 100;
  var_0._id_8303 = 32;
  var_0.tacklebymelee = 0;
  var_0.tacklebycharge = 0;
  var_0.knockbyravensword = 0;
  var_0.shockbyteslablood = 0;
  var_0.scaleshealthbyplayers = 1;
  var_0.exemptfromfailsafekill = 1;
  var_0._id_5ED2["zombie_king"]["whole_body"] = "zom_darkone_base";
  _id_0547::_id_0A52(var_0, "zombie_king");
  _id_0547::registeranimtree("zombie_king", #animtree);
  _id_0541::_id_2F92("crawl", ["zombie_king"]);
  thread validate_level_setup();
  _id_0547::_id_7BD0("king_default", ::state_default_run, ::state_default_interrupt, 100, ::state_default_end);
  _id_0547::_id_7BD0("king_stand_pain", ::anim_state_stand_pain_run, ::anim_state_stand_pain_interrupt, 149, ::anim_state_stand_pain_end);
  level._effect["zmb_king_gk_levitation"] = loadfx("vfx/zombie/zmb_king_gk_levitation");
  level._effect["zmb_king_gk_blood_levitation"] = loadfx("vfx/zombie/zmb_king_gk_blood_levitation");
  level._effect["zmb_king_gk_blood_levitation_chn_1"] = loadfx("vfx/zombie/zmb_king_gk_blood_levitation_chn_1");
  level._effect["zmb_king_gk_blood_levitation_chn_2"] = loadfx("vfx/zombie/zmb_king_gk_blood_levitation_chn_2");
  level._effect["zmb_king_gk_blood_levitation_chn_3"] = loadfx("vfx/zombie/zmb_king_gk_blood_levitation_chn_3");
  level._effect["zmb_king_gk_death_levitation"] = loadfx("vfx/zombie/zmb_king_gk_death_levitation");
  level._effect["zmb_king_gk_death_levitation_chn_1"] = loadfx("vfx/zombie/zmb_king_gk_death_levitation_chn_1");
  level._effect["zmb_king_gk_death_levitation_chn_2"] = loadfx("vfx/zombie/zmb_king_gk_death_levitation_chn_2");
  level._effect["zmb_king_gk_death_levitation_chn_3"] = loadfx("vfx/zombie/zmb_king_gk_death_levitation_chn_3");
  level._effect["zmb_king_gk_moon_levitation"] = loadfx("vfx/zombie/zmb_king_gk_moon_levitation");
  level._effect["zmb_king_gk_moon_levitation_chn_1"] = loadfx("vfx/zombie/zmb_king_gk_moon_levitation_chn_1");
  level._effect["zmb_king_gk_moon_levitation_chn_2"] = loadfx("vfx/zombie/zmb_king_gk_moon_levitation_chn_2");
  level._effect["zmb_king_gk_moon_levitation_chn_3"] = loadfx("vfx/zombie/zmb_king_gk_moon_levitation_chn_3");
  level._effect["zmb_king_gk_storm_levitation"] = loadfx("vfx/zombie/zmb_king_gk_storm_levitation");
  level._effect["zmb_king_gk_storm_levitation_chn_1"] = loadfx("vfx/zombie/zmb_king_gk_storm_levitation_chn_1");
  level._effect["zmb_king_gk_storm_levitation_chn_2"] = loadfx("vfx/zombie/zmb_king_gk_storm_levitation_chn_2");
  level._effect["zmb_king_gk_storm_levitation_chn_3"] = loadfx("vfx/zombie/zmb_king_gk_storm_levitation_chn_3");
  level._effect["zmb_king_gk_levitation"] = loadfx("vfx/zombie/zmb_king_gk_levitation");
  level._effect["zmb_king_gk_levitation_chn_1"] = loadfx("vfx/zombie/zmb_king_gk_levitation_chn_1");
  level._effect["zmb_king_gk_levitation_chn_2"] = loadfx("vfx/zombie/zmb_king_gk_levitation_chn_2");
  level._effect["zmb_king_gk_levitation_chn_3"] = loadfx("vfx/zombie/zmb_king_gk_levitation_chn_3");
  level._effect["zmb_gk_geistbomb_trail"] = loadfx("vfx/trail/zmb_gk_geistbomb_trail");
  level._effect["zmb_godking_giestbomb"] = loadfx("vfx/zombie/zmb_godking_giestbomb");
  level._effect["zmb_godking_giestbomb_prime"] = loadfx("vfx/zombie/zmb_godking_giestbomb_prime");
  level._effect["zmb_gk_lightsun_blast"] = loadfx("vfx/zombie/zmb_gk_lightsun_blast");
  level._effect["zmb_gk_lightsun_buildup"] = loadfx("vfx/zombie/zmb_gk_lightsun_buildup");
  level._effect["zmb_godking_gk_impact"] = loadfx("vfx/zombie/zmb_godking_gk_impact");
  level._effect["zmb_godking_sword_protection"] = loadfx("vfx/zombie/zmb_godking_sword_protection");
  level._effect["blood_godking_impact_burst"] = loadfx("vfx/blood/blood_godking_impact_burst");
  level._effect["zmf_corpse_eater_smoldering"] = loadfx("vfx/zombie/prototype_fx/zmf_corpse_eater_smoldering");
}

king_post_model_vfx() {
  attach_levitation_effects();
}

attach_levitation_effects() {
  self endon("death");
  waitframe();
  waitframe();
  waitframe();
  waitframe();
  _func_147(level._effect["zmb_king_gk_levitation"], self, "J_Spine4");
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
  level.bossfight.default_boss_pos.origin = level.bossfight.boss_pos;
  level.king_level_setup = 1;
}

king_think_setup() {
  level notify("zombie_king_spawned");
  maps\mp\agents\humanoid\_humanoid::_id_8A27();
  thread _id_054D::_id_A146();
  self.iszombieking = 1;

  if(_id_0547::is_solo())
    self.issolomode = 1;

  self _meth_85A1("zombie");
  self _meth_83A2(1);
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(1, "zombie_king");
  self.ispermanentlyscripted = 1;
  self._id_55AB = 1;
  self._id_57E8 = 1;
  self._id_562B = 1;
  self.ignoredistractiondrones = 1;
  self.shortstun = 1;
  self._id_509A = 1;
  self._id_6734 = 1;
  self._id_0C29 = 0;
  self.is_flamethrower_immune = 1;
  self.lucky_crit_nerf = 1;
  self.zmdemigod = 1;
  self._id_6816 = 1;
  self.nomutilate = 1;
  self.nopairmelee = 1;
  self._id_66EC = 1;
  self._id_00BD = 100;
  self.radius = 32;
  self._id_2BCA = self.radius + 1;
  self _meth_8399(self._id_2BCA);
  _id_0547::_id_86C8(280);
  _id_0547::_id_86C7(280);
  self.candamageallies = 1;
  self._id_2A9D = "death";
  self._id_11AB = 85 + self.radius;
  self._id_60F5 = "large";
  self._id_60F6 = 200;
  self._id_60E1 = 40;
  self _meth_84D4();
  self.king_damage_finished_funcs = [];
  self.vo_drain_punished_int = 0;
  self.vo_taunt_int = 0;
  self.vo_lines_played = [];
  self.stunnedclip = _func_18E("clip_boss_torso", "targetname");

  if(isDefined(self.stunnedclip)) {
    self.stunnedclip.original_org = self.stunnedclip.origin;
    self.stunnedclip.original_ang = self.stunnedclip.angles;
    self.stunnedclip _meth_82C2();
    self.stunnedclip._id_A045 = ::body_clip_unresolved_collision;
    self.stunnedclip._id_A049 = 1;
  }

  common_scripts\utility::_id_3799("phase_transition_active");
  attacks_init();
  phases_init();
  thread wave_management_think();
  thread handle_manual_move();
  thread handle_manual_rotation();
  thread end_condition();
  _id_0542::set_invalid_melee_pairing_reason("god_king", 1);
  thread king_scale_health();
  thread king_handle_pain();
  thread init_impact_vfx();
  _id_0547::_id_7BA9(::zombie_detonate_clear_property);
}

king_scale_health() {
  waitframe();
  var_0 = self.maxhealth * level.player.size;
  maps\mp\agents\_agent_common::_id_83FD(int(var_0));
}

end_condition() {
  var_0 = self;
  var_0 waittill("it_is_over");
  level notify("god_king_defeated");
  common_scripts\utility::flag_set("flag_boss_complete");
}

attacks_init() {
  self.attack_basic["geist_blast"] = spawnStruct();
  self.attack_basic["geist_blast"]._id_116E = "geist_blast";
  self.attack_basic["geist_blast"].scr_st = "geist_blast";
  self.attack_basic["geist_blast"].try_func = ::special_geist_blast_try;
  self.attack_basic["geist_blast"]._id_920F = ::special_geist_blast_start;
  self.attack_basic["geist_blast"].think_func = ::special_geist_blast_think;
  self.attack_basic["geist_blast"]._id_367E = ::special_geist_blast_end;
  self.attack_basic["geist_blast"].run_func = ::anim_state_geist_blast_run;
  self.attack_basic["geist_blast"].scr_pri = 101;
  self.attack_basic["geist_blast"].anim_end_func = ::anim_state_geist_blast_end;
  self.attack_basic["geist_blast"].allow_pain = 1;
  register_boss_special_attack_wrapper("geist_blast");
  self.attack_basic["geist_lightning"] = spawnStruct();
  self.attack_basic["geist_lightning"]._id_116E = "geist_lightning";
  self.attack_basic["geist_lightning"].scr_st = "geist_lightning";
  self.attack_basic["geist_lightning"].try_func = ::special_geist_lightning_try;
  self.attack_basic["geist_lightning"]._id_920F = ::special_geist_lightning_start;
  self.attack_basic["geist_lightning"].think_func = ::special_geist_lightning_think;
  self.attack_basic["geist_lightning"]._id_367E = ::special_geist_lightning_end;
  self.attack_basic["geist_lightning"].run_func = ::anim_state_geist_lightning_run;
  self.attack_basic["geist_lightning"].scr_pri = 102;
  self.attack_basic["geist_lightning"].allow_pain = 1;
  register_boss_special_attack_wrapper("geist_lightning");
  self.attack_basic["geist_bomb"] = spawnStruct();
  self.attack_basic["geist_bomb"]._id_116E = "geist_bomb";
  self.attack_basic["geist_bomb"].scr_st = "geist_bomb";
  self.attack_basic["geist_bomb"].try_func = ::special_geist_bombs_try;
  self.attack_basic["geist_bomb"]._id_920F = ::special_geist_bombs_start;
  self.attack_basic["geist_bomb"].think_func = ::special_geist_bombs_think;
  self.attack_basic["geist_bomb"]._id_367E = ::special_geist_bombs_end;
  self.attack_basic["geist_bomb"].run_func = ::anim_state_geist_bombs_run;
  self.attack_basic["geist_bomb"].scr_pri = 104;
  self.attack_basic["geist_bomb"].allow_pain = 1;
  register_boss_special_attack_wrapper("geist_bomb");
  self.attack_basic["geist_detonate"] = spawnStruct();
  self.attack_basic["geist_detonate"]._id_116E = "detonate";
  self.attack_basic["geist_detonate"].scr_st = "detonate";
  self.attack_basic["geist_detonate"].try_func = ::special_detonate_try;
  self.attack_basic["geist_detonate"]._id_920F = ::special_detonate_start;
  self.attack_basic["geist_detonate"].think_func = ::special_detonate_think;
  self.attack_basic["geist_detonate"]._id_367E = ::special_detonate_end;
  self.attack_basic["geist_detonate"].run_func = ::anim_state_detonate_run;
  self.attack_basic["geist_detonate"].scr_pri = 103;
  self.attack_basic["geist_detonate"].allow_pain = 1;
  register_boss_special_attack_wrapper("geist_detonate");
  self.attack_basic["geist_pull"] = spawnStruct();
  self.attack_basic["geist_pull"]._id_116E = "geist_pull";
  self.attack_basic["geist_pull"].scr_st = "geist_pull";
  self.attack_basic["geist_pull"].try_func = ::special_geist_pull_try;
  self.attack_basic["geist_pull"]._id_920F = ::special_geist_pull_start;
  self.attack_basic["geist_pull"].think_func = ::special_geist_pull_think;
  self.attack_basic["geist_pull"]._id_367E = ::special_geist_pull_end;
  self.attack_basic["geist_pull"].run_func = ::anim_state_geist_pull_run;
  self.attack_basic["geist_pull"].scr_pri = 105;
  self.attack_basic["geist_pull"].anim_end_func = ::anim_state_geist_pull_end;
  register_boss_special_attack_wrapper("geist_pull");
  self.attack_basic["geist_drain"] = spawnStruct();
  self.attack_basic["geist_drain"]._id_116E = "geist_drain";
  self.attack_basic["geist_drain"].scr_st = "geist_drain";
  self.attack_basic["geist_drain"].try_func = ::special_geist_drain_try;
  self.attack_basic["geist_drain"]._id_920F = ::special_geist_drain_start;
  self.attack_basic["geist_drain"].think_func = ::special_geist_drain_think;
  self.attack_basic["geist_drain"]._id_367E = ::special_geist_drain_end;
  self.attack_basic["geist_drain"].run_func = ::anim_state_geist_drain_run;
  self.attack_basic["geist_drain"].scr_pri = 107;
  self.attack_basic["geist_drain"].anim_end_func = ::anim_state_geist_drain_end;
  register_boss_special_attack_wrapper("geist_drain");
  self.attack_basic["flame_wave"] = spawnStruct();
  self.attack_basic["flame_wave"]._id_116E = "flame_wave";
  self.attack_basic["flame_wave"].scr_st = "flame_wave";
  self.attack_basic["flame_wave"].try_func = ::uber_flame_wave_try;
  self.attack_basic["flame_wave"]._id_920F = ::uber_flame_wave_start;
  self.attack_basic["flame_wave"].think_func = ::uber_flame_wave_think;
  self.attack_basic["flame_wave"]._id_367E = ::uber_flame_wave_end;
  self.attack_basic["flame_wave"].run_func = ::anim_state_flame_wave_run;
  self.attack_basic["flame_wave"].scr_pri = 151;
  self.attack_basic["flame_wave"].anim_end_func = ::anim_state_flame_wave_end;
  register_boss_special_attack_wrapper("flame_wave");
  self.attack_basic["force"] = spawnStruct();
  self.attack_basic["force"]._id_116E = "force";
  self.attack_basic["force"].scr_st = "force";
  self.attack_basic["force"].try_func = ::uber_force_try;
  self.attack_basic["force"]._id_920F = ::uber_force_start;
  self.attack_basic["force"].think_func = ::uber_force_think;
  self.attack_basic["force"]._id_367E = ::uber_force_end;
  self.attack_basic["force"].run_func = ::anim_state_force_run;
  self.attack_basic["force"].scr_pri = 152;
  register_boss_special_attack_wrapper("force");
  self.attack_basic["sun"] = spawnStruct();
  self.attack_basic["sun"]._id_116E = "sun";
  self.attack_basic["sun"].scr_st = "sun";
  self.attack_basic["sun"].try_func = ::uber_sun_try;
  self.attack_basic["sun"]._id_920F = ::uber_sun_start;
  self.attack_basic["sun"].think_func = ::uber_sun_think;
  self.attack_basic["sun"]._id_367E = ::uber_sun_end;
  self.attack_basic["sun"].run_func = ::anim_state_sun_run;
  self.attack_basic["sun"].scr_pri = 153;
  register_boss_special_attack_wrapper("sun");
  self.attack_basic["sit"] = spawnStruct();
  self.attack_basic["sit"]._id_116E = "sit";
  self.attack_basic["sit"].scr_st = "sit";
  self.attack_basic["sit"].try_func = ::special_geist_sit_try;
  self.attack_basic["sit"]._id_920F = ::special_geist_sit_start;
  self.attack_basic["sit"].think_func = ::special_geist_sit_think;
  self.attack_basic["sit"]._id_367E = ::special_geist_sit_end;
  self.attack_basic["sit"].run_func = ::anim_state_geist_sit_run;
  self.attack_basic["sit"].scr_pri = 120;
  self.attack_basic["sit"].anim_end_func = ::anim_state_geist_sit_end;
  register_boss_special_attack_wrapper("sit");
  self.attack_basic["geist_kneel"] = spawnStruct();
  self.attack_basic["geist_kneel"]._id_116E = "kneel";
  self.attack_basic["geist_kneel"].scr_st = "kneel";
  self.attack_basic["geist_kneel"].try_func = ::special_geist_kneel_try;
  self.attack_basic["geist_kneel"]._id_920F = ::special_geist_kneel_start;
  self.attack_basic["geist_kneel"].think_func = ::special_geist_kneel_think;
  self.attack_basic["geist_kneel"]._id_367E = ::special_geist_kneel_end;
  self.attack_basic["geist_kneel"].run_func = ::anim_state_geist_kneel_run;
  self.attack_basic["geist_kneel"].scr_pri = 106;
  self.attack_basic["geist_kneel"].anim_end_func = ::anim_state_geist_kneel_end;
  register_boss_special_attack_wrapper("geist_kneel");
  self.attack_basic["geist_drain_special_fake"] = spawnStruct();
  self.attack_basic["geist_drain_special_fake"]._id_116E = "geist_drain_special_fake";
  self.attack_basic["geist_drain_special_fake"].scr_st = "geist_drain_special_fake";
  self.attack_basic["geist_drain_special_fake"].try_func = ::special_geist_drain_special_fake_try;
  self.attack_basic["geist_drain_special_fake"]._id_920F = ::special_geist_drain_special_fake_start;
  self.attack_basic["geist_drain_special_fake"].think_func = ::special_geist_drain_special_fake_think;
  self.attack_basic["geist_drain_special_fake"]._id_367E = ::special_geist_drain_special_fake_end;
  self.attack_basic["geist_drain_special_fake"].run_func = ::anim_state_geist_drain_special_fake_run;
  self.attack_basic["geist_drain_special_fake"].scr_pri = 150;
  self.attack_basic["geist_drain_special_fake"].anim_end_func = ::anim_state_geist_drain_special_fake_end;
  register_boss_special_attack_wrapper("geist_drain_special_fake");
  self.attack_basic["geist_drain_special"] = spawnStruct();
  self.attack_basic["geist_drain_special"]._id_116E = "geist_drain_special";
  self.attack_basic["geist_drain_special"].scr_st = "geist_drain_special";
  self.attack_basic["geist_drain_special"].try_func = ::special_geist_drain_special_try;
  self.attack_basic["geist_drain_special"]._id_920F = ::special_geist_drain_special_start;
  self.attack_basic["geist_drain_special"].think_func = ::special_geist_drain_special_think;
  self.attack_basic["geist_drain_special"]._id_367E = ::special_geist_drain_special_end;
  self.attack_basic["geist_drain_special"].run_func = ::anim_state_geist_drain_special_run;
  self.attack_basic["geist_drain_special"].scr_pri = 108;
  self.attack_basic["geist_drain_special"].anim_end_func = ::anim_state_geist_drain_special_end;
  register_boss_special_attack_wrapper("geist_drain_special");
  self.attack_basic["melee"] = spawnStruct();
  self.attack_basic["melee"]._id_116E = "melee";
  self.attack_basic["melee"].scr_st = "king_melee";
  self.attack_basic["melee"].try_func = ::special_melee_try;
  self.attack_basic["melee"]._id_920F = ::special_melee_start;
  self.attack_basic["melee"].think_func = ::special_melee_think;
  self.attack_basic["melee"]._id_367E = ::special_melee_end;
  self.attack_basic["melee"].run_func = ::anim_state_melee_run;
  self.attack_basic["melee"].scr_pri = 110;
  self.attack_basic["melee"].anim_end_func = ::anim_state_melee_end;
  register_boss_special_attack_wrapper("melee");
  melee_init();
  self.attack_basic["move_face_enemy"] = spawnStruct();
  self.attack_basic["move_face_enemy"]._id_116E = "move_face_enemy";
  self.attack_basic["move_face_enemy"].try_func = ::special_move_face_enemy_try;
  self.attack_basic["move_face_enemy"]._id_920F = ::special_move_face_enemy_start;
  self.attack_basic["move_face_enemy"].think_func = ::special_move_face_enemy_think;
  self.attack_basic["move_face_enemy"]._id_367E = ::special_move_face_enemy_end;
  register_boss_special_attack_wrapper("move_face_enemy");
  self.attack_basic["move_to_enemy"] = spawnStruct();
  self.attack_basic["move_to_enemy"]._id_116E = "move_to_enemy";
  self.attack_basic["move_to_enemy"].try_func = ::special_move_to_enemy_try;
  self.attack_basic["move_to_enemy"]._id_920F = ::special_move_to_enemy_start;
  self.attack_basic["move_to_enemy"].think_func = ::special_move_to_enemy_think;
  self.attack_basic["move_to_enemy"]._id_367E = ::special_move_to_enemy_end;
  register_boss_special_attack_wrapper("move_to_enemy");
}

melee_init() {
  if(isDefined(level.king_melee_attacks)) {
    return;
  }
  level.king_melee_attacks = [];
  var_0 = spawnStruct();
  var_0.anim_action = "melee_front_quick";
  var_0._id_0F3E = 60;
  var_0.arc_distance = 280;
  var_0.arc_rotation_offset = 0;
  var_0._id_2994 = 0;
  var_0.facing_rotation_allowed = 0;
  level.king_melee_attacks["quick"] = var_0;
  var_0 = spawnStruct();
  var_0.anim_action = "melee_front_heavy";
  var_0._id_0F3E = 180;
  var_0.arc_distance = 280;
  var_0.arc_rotation_offset = 0;
  var_0.facing_rotation_allowed = 0;
  level.king_melee_attacks["front180"] = var_0;
  var_0 = spawnStruct();
  var_0.anim_action = "melee_back";
  var_0._id_0F3E = 180;
  var_0.arc_distance = 280;
  var_0.arc_rotation_offset = 180;
  var_0.facing_rotation_allowed = 0;
  level.king_melee_attacks["back180"] = var_0;
}

phases_init() {
  self.phases = [];
  var_0 = spawnStruct();
  self.phases[self.phases.size] = var_0;
  var_0._id_9FE1 = undefined;
  var_0.transition_attack_set = undefined;
  var_0.fx_1_name = "zmb_king_gk_death_levitation_chn_1";
  var_0.fx_2_name = "zmb_king_gk_death_levitation_chn_2";
  var_0.fx_3_name = "zmb_king_gk_death_levitation_chn_3";
  var_0.wave_management = ::phase0_wave_management;
  var_0.special_move_set = [];
  var_0 phase_add_special_move("geist_blast");
  var_0 phase_add_special_move("melee");
  var_0 phase_add_special_move("geist_blast");

  if(!common_scripts\utility::_id_562E(self.issolomode))
    var_0 phase_add_special_move("move_to_enemy", [679.0]);

  if(!common_scripts\utility::_id_562E(self.issolomode))
    var_0 phase_add_special_move("melee");

  var_0 phase_add_special_move("melee");
  var_0 phase_add_special_move("geist_blast");

  if(!common_scripts\utility::_id_562E(self.issolomode))
    var_0 phase_add_special_move("move_to_enemy");
  else
    var_0 phase_add_special_move("move_face_enemy");

  var_0 phase_add_special_move("melee");
  var_0 phase_add_special_move("geist_bomb");
  var_0 phase_add_special_move("move_face_enemy");
  var_0 phase_add_special_move("melee");
  var_0 phase_add_special_move("detonate");
  var_0 phase_add_special_move("melee");
  var_0 phase_add_special_move("detonate");
  var_0 phase_add_special_move("melee");
  var_0 phase_add_special_move("geist_blast");
  var_0 phase_add_special_move("move_face_enemy");
  var_0 phase_add_special_move("melee");
  var_0 phase_add_special_move("geist_bomb");

  if(common_scripts\utility::_id_562E(self.issolomode))
    var_0 phase_add_special_move("move_face_enemy");

  var_0 = spawnStruct();
  self.phases[self.phases.size] = var_0;
  var_0._id_9FE1 = undefined;
  var_0.transition_attack_set = ["geist_pull", "geist_drain"];
  var_0.fx_1_name = "zmb_king_gk_blood_levitation_chn_1";
  var_0.fx_2_name = "zmb_king_gk_blood_levitation_chn_2";
  var_0.fx_3_name = "zmb_king_gk_blood_levitation_chn_3";
  var_0.wave_management = ::phase1_wave_management;
  var_0.special_move_set = [];
  var_0 phase_add_special_move("melee");
  var_0 phase_add_special_move("geist_blast");
  var_0 phase_add_special_move("melee");
  var_0 phase_add_special_move("geist_blast");
  var_0 phase_add_special_move("sun");

  if(!common_scripts\utility::_id_562E(self.issolomode))
    var_0 phase_add_special_move("move_to_enemy", [679.0]);
  else
    var_0 phase_add_special_move("move_face_enemy");

  var_0 phase_add_special_move("geist_lightning");
  var_0 phase_add_special_move("melee");
  var_0 phase_add_special_move("geist_lightning");
  var_0 phase_add_special_move("melee");
  var_0 phase_add_special_move("geist_blast");
  var_0 phase_add_special_move("sun");

  if(!common_scripts\utility::_id_562E(self.issolomode)) {
    var_0 phase_add_special_move("move_to_enemy", [679.0]);
    var_0 phase_add_special_move("melee");
    var_0 phase_add_special_move("move_to_enemy", [679.0]);
  } else
    var_0 phase_add_special_move("move_face_enemy");

  var_0 = spawnStruct();
  self.phases[self.phases.size] = var_0;
  var_0._id_9FE1 = undefined;
  var_0.transition_attack_set = ["geist_pull", "geist_drain"];
  var_0.fx_1_name = "zmb_king_gk_storm_levitation_chn_1";
  var_0.fx_2_name = "zmb_king_gk_storm_levitation_chn_2";
  var_0.fx_3_name = "zmb_king_gk_storm_levitation_chn_3";
  var_0.wave_management = ::phase2_wave_management;
  var_0.special_move_set = [];
  var_0 phase_add_special_move("melee");
  var_0 phase_add_special_move("geist_lightning");
  var_0 phase_add_special_move("force");

  if(!common_scripts\utility::_id_562E(self.issolomode))
    var_0 phase_add_special_move("move_to_enemy", [679.0]);
  else
    var_0 phase_add_special_move("move_face_enemy");

  var_0 phase_add_special_move("melee");
  var_0 phase_add_special_move("geist_lightning");
  var_0 phase_add_special_move("melee");
  var_0 phase_add_special_move("geist_lightning");
  var_0 phase_add_special_move("melee");
  var_0 phase_add_special_move("geist_bomb");
  var_0 phase_add_special_move("move_face_enemy", [970]);
  var_0 phase_add_special_move("force");
  var_0 phase_add_special_move("geist_bomb");
  var_0 phase_add_special_move("melee");
  var_0 phase_add_special_move("geist_blast");

  if(!common_scripts\utility::_id_562E(self.issolomode))
    var_0 phase_add_special_move("move_to_enemy", [679.0]);
  else
    var_0 phase_add_special_move("move_face_enemy");

  var_0 phase_add_special_move("melee");
  var_0 phase_add_special_move("geist_lightning");
  var_0 phase_add_special_move("melee");
  var_0 phase_add_special_move("geist_lightning");
  var_0 phase_add_special_move("melee");
  var_0 phase_add_special_move("move_face_enemy", [970]);
  var_0 = spawnStruct();
  self.phases[self.phases.size] = var_0;
  var_0._id_9FE1 = undefined;
  var_0.transition_attack_set = ["geist_pull", "geist_drain"];
  var_0.fx_1_name = "zmb_king_gk_moon_levitation_chn_1";
  var_0.fx_2_name = "zmb_king_gk_moon_levitation_chn_2";
  var_0.fx_3_name = "zmb_king_gk_moon_levitation_chn_3";
  var_0.wave_management = ::phase3_wave_management;
  var_0.special_move_set = [];
  var_0 phase_add_special_move("melee");
  var_0 phase_add_special_move("detonate");
  var_0 phase_add_special_move("melee");
  var_0 phase_add_special_move("detonate");
  var_0 phase_add_special_move("move_face_enemy");
  var_0 phase_add_special_move("geist_pull");
  var_0 phase_add_special_move("flame_wave");
  var_0 phase_add_special_move("move_face_enemy");
  var_0 phase_add_special_move("melee");
  var_0 phase_add_special_move("geist_blast");
  var_0 phase_add_special_move("melee");
  var_0 phase_add_special_move("geist_blast");
  var_0 phase_add_special_move("geist_bomb");

  if(!common_scripts\utility::_id_562E(self.issolomode))
    var_0 phase_add_special_move("move_to_enemy", [679.0]);
  else
    var_0 phase_add_special_move("move_face_enemy");

  var_0 = spawnStruct();
  self.phases[self.phases.size] = var_0;
  var_0._id_9FE1 = undefined;
  var_0.transition_attack_set = ["geist_pull", "kneel", "sit"];
  var_0.fx_1_name = "zmb_king_gk_levitation_chn_1";
  var_0.fx_2_name = "zmb_king_gk_levitation_chn_2";
  var_0.fx_3_name = "zmb_king_gk_levitation_chn_3";
  var_0.wave_management = ::phase4_wave_management;
  var_0.special_move_set = [];
  var_0 phase_add_special_move("geist_drain_special_fake");
  var_0 = spawnStruct();
  self.phases[self.phases.size] = var_0;
  var_0._id_9FE1 = undefined;
  var_0.transition_attack_set = undefined;
  var_0.fx_1_name = "zmb_king_gk_levitation_chn_1";
  var_0.fx_2_name = "zmb_king_gk_levitation_chn_2";
  var_0.fx_3_name = "zmb_king_gk_levitation_chn_3";
  var_0.wave_management = ::phase5_wave_management;
  var_0.special_move_set = [];
  var_0 phase_add_special_move("geist_drain_special");
  var_0 = spawnStruct();
  self.phases[self.phases.size] = var_0;
  var_0._id_9FE1 = undefined;
  var_0.transition_attack_set = ["geist_pull", "geist_drain"];
  var_0.fx_1_name = "zmb_king_gk_levitation_chn_1";
  var_0.fx_2_name = "zmb_king_gk_levitation_chn_2";
  var_0.fx_3_name = "zmb_king_gk_levitation_chn_3";
  var_0.wave_management = ::phase6_wave_management;
  var_0.special_move_set = [];

  if(!common_scripts\utility::_id_562E(self.issolomode)) {
    var_0 phase_add_special_move("move_to_enemy", [679.0]);
    var_0 phase_add_special_move("melee");
    var_0 phase_add_special_move("move_to_enemy", [679.0]);
    var_0 phase_add_special_move("melee");
  }

  var_0 phase_add_special_move("move_face_enemy");
  var_0 phase_add_special_move("geist_bomb");
  var_0 phase_add_special_move("melee");
  var_0 phase_add_special_move("force");
  var_0 phase_add_special_move("detonate");
  var_0 phase_add_special_move("detonate");

  if(!common_scripts\utility::_id_562E(self.issolomode)) {
    var_0 phase_add_special_move("move_to_enemy", [679.0]);
    var_0 phase_add_special_move("melee");
    var_0 phase_add_special_move("move_to_enemy", [679.0]);
  } else
    var_0 phase_add_special_move("move_face_enemy");

  var_0 phase_add_special_move("melee");
  var_0 phase_add_special_move("geist_blast");
  var_0 phase_add_special_move("melee");
  var_0 phase_add_special_move("geist_blast");
  var_0 phase_add_special_move("geist_bomb");
  var_0 phase_add_special_move("flame_wave");

  if(!common_scripts\utility::_id_562E(self.issolomode)) {
    var_0 phase_add_special_move("move_to_enemy", [679.0]);
    var_0 phase_add_special_move("melee");
  }

  var_0 phase_add_special_move("melee");
  var_0 phase_add_special_move("geist_blast");
  var_0 phase_add_special_move("melee");
  var_0 phase_add_special_move("geist_blast");
  var_0 phase_add_special_move("sun");
}

phase_add_special_move(var_0, var_1) {
  var_2 = self;
  var_3 = var_2.special_move_set.size;
  var_4 = spawnStruct();
  var_4.name = var_0;
  var_4._id_6E59 = var_1;
  var_2.special_move_set[var_3] = var_4;
}

king_set_current_phase(var_0) {
  var_1 = self;
  var_1.current_phase_index = var_0;
  var_1.current_phase = level.zombie_king.phases[var_0];
  var_1.current_special_move_index = undefined;
  var_1.transition_move_index = undefined;
  var_1 common_scripts\utility::_id_379A("phase_transition_active");
  var_1 thread king_set_phase_fx(var_1.current_phase);
  var_1 thread wave_management_set(var_1.current_phase_index);
}

king_set_phase_fx(var_0) {
  var_1 = self;

  if(isDefined(var_1.phase_fx_1_ent))
    var_1.phase_fx_1_ent delete();

  if(isDefined(var_1.phase_fx_2_ent))
    var_1.phase_fx_2_ent delete();

  if(isDefined(var_1.phase_fx_3_ent))
    var_1.phase_fx_3_ent delete();

  if(var_1 common_scripts\utility::_id_3794("phase_transition_active") && var_1.current_phase_index != 0) {
    var_2 = "zmb_king_gk_levitation_chn_1";
    var_3 = "zmb_king_gk_levitation_chn_2";
    var_4 = "zmb_king_gk_levitation_chn_3";
    var_1.transition_fx_1_ent = _func_2A8(common_scripts\utility::_id_44F5(var_2), var_1, "TAG_FX01");
    _func_14C(var_1.transition_fx_1_ent);
    var_1 king_handle_attached_vfx_cleanup(var_1.transition_fx_1_ent);
    var_1.transition_fx_1_ent thread delete_on_parent_notify(var_1, "clear_transition_fx");
    var_1.transition_fx_2_ent = _func_2A8(common_scripts\utility::_id_44F5(var_3), var_1, "TAG_FX01");
    _func_14C(var_1.transition_fx_2_ent);
    var_1 king_handle_attached_vfx_cleanup(var_1.transition_fx_2_ent);
    var_1.transition_fx_2_ent thread delete_on_parent_notify(var_1, "clear_transition_fx");
    var_1.transition_fx_3_ent = _func_2A8(common_scripts\utility::_id_44F5(var_4), var_1, "TAG_FX01");
    _func_14C(var_1.transition_fx_3_ent);
    var_1 king_handle_attached_vfx_cleanup(var_1.transition_fx_3_ent);
    var_1.transition_fx_3_ent thread delete_on_parent_notify(var_1, "clear_transition_fx");
    var_1 common_scripts\utility::_id_37A1("phase_transition_active");
  }

  if(isDefined(var_1.transition_fx_1_ent))
    var_1.transition_fx_1_ent delete();

  if(isDefined(var_1.transition_fx_2_ent))
    var_1.transition_fx_2_ent delete();

  if(isDefined(var_1.transition_fx_3_ent))
    var_1.transition_fx_3_ent delete();

  if(isDefined(var_0.fx_1_name)) {
    var_1.phase_fx_1_ent = _func_2A8(common_scripts\utility::_id_44F5(var_0.fx_1_name), var_1, "TAG_FX01");
    _func_14C(var_1.phase_fx_1_ent);
    var_1 king_handle_attached_vfx_cleanup(var_1.phase_fx_1_ent);
  }

  if(isDefined(var_0.fx_2_name)) {
    var_1.phase_fx_2_ent = _func_2A8(common_scripts\utility::_id_44F5(var_0.fx_2_name), var_1, "TAG_FX02");
    _func_14C(var_1.phase_fx_2_ent);
    var_1 king_handle_attached_vfx_cleanup(var_1.phase_fx_2_ent);
  }

  if(isDefined(var_0.fx_3_name)) {
    var_1.phase_fx_3_ent = _func_2A8(common_scripts\utility::_id_44F5(var_0.fx_3_name), var_1, "TAG_FX03");
    _func_14C(var_1.phase_fx_3_ent);
    var_1 king_handle_attached_vfx_cleanup(var_1.phase_fx_3_ent);
  }
}

king_think() {
  thread king_think_setup();
  wait 0;
  thread _id_0547::_id_7D1A("king_default");
  self endon("death");
  self endon("fight_complete");
  level endon("game_ended");

  for(;;) {
    waitframe();

    if(king_in_paused_state()) {
      continue;
    }
    if(process_special_moves())
      continue;
  }
}

king_in_paused_state() {
  var_0 = self;
  return _id_0547::_id_5565(var_0.full_pause_state, 1);
}

king_set_paused_state() {
  var_0 = self;
  var_0.full_pause_state = 1;
}

king_clear_paused_state() {
  var_0 = self;
  var_0.full_pause_state = 0;
}

process_special_moves() {
  var_0 = self;

  if(isDefined(var_0.current_special_move)) {
    var_1 = var_0[[var_0.current_special_move.think_func]]();

    if(common_scripts\utility::_id_562E(var_1)) {
      if(isDefined(var_0.current_special_move._id_367E))
        var_0[[var_0.current_special_move._id_367E]]();

      var_0.current_special_move = undefined;
      var_0.standing_pain_allowed = 0;
    } else
      return 1;
  }

  var_2 = undefined;
  var_3 = undefined;
  var_5 = undefined;

  if(isDefined(var_0.current_phase))
    var_5 = var_0.current_phase.transition_attack_set;

  if(!isDefined(var_2) && var_0 common_scripts\utility::_id_3794("phase_transition_active") && isDefined(var_0.current_phase) && isDefined(var_0.current_phase.transition_attack_set)) {
    var_6 = 0;

    if(isDefined(var_0.transition_move_index))
      var_6 = var_0.transition_move_index + 1;

    var_7 = 0;

    for(;;) {
      var_8 = var_7 + var_6;

      if(var_8 >= var_0.current_phase.transition_attack_set.size) {
        var_0 common_scripts\utility::_id_3796("phase_transition_active");
        break;
      }

      var_9 = var_5[var_8];
      var_2 = level.boss_special_moves[var_9];
      var_10 = var_0[[var_2.try_func]]();

      if(var_10) {
        var_0.transition_move_index = var_8;
        break;
      } else
        var_2 = undefined;

      var_7++;
    }
  } else if(var_0 common_scripts\utility::_id_3794("phase_transition_active"))
    var_0 common_scripts\utility::_id_3796("phase_transition_active");

  var_11 = undefined;

  if(isDefined(var_0.current_phase))
    var_11 = var_0.current_phase.special_move_set;

  if(isDefined(var_11) && !isDefined(var_2)) {
    var_12 = 0;

    if(isDefined(var_0.current_special_move_index))
      var_12 = var_0.current_special_move_index + 1;

    for(var_7 = 0; var_7 < var_11.size; var_7++) {
      var_8 = common_scripts\utility::_id_627D(var_7 + var_12, var_11.size);
      var_13 = var_11[var_8];
      var_9 = var_13.name;
      var_2 = level.boss_special_moves[var_9];
      var_3 = var_13._id_6E59;

      if(isDefined(var_3))
        var_10 = var_0[[var_2.try_func]](var_3);
      else
        var_10 = var_0[[var_2.try_func]]();

      if(var_10) {
        var_0.current_special_move_index = var_8;
        break;
      } else {
        var_2 = undefined;
        var_3 = undefined;
      }
    }
  }

  if(isDefined(var_2)) {
    var_0.current_special_move = var_2;

    if(common_scripts\utility::_id_562E(var_2.allow_pain))
      var_0.standing_pain_allowed = 1;

    if(isDefined(var_2._id_920F)) {
      if(isDefined(var_3))
        var_10 = var_0[[var_2._id_920F]](var_3);
      else
        var_10 = var_0[[var_2._id_920F]]();
    }

    return 1;
  }

  return 0;
}

wave_management_think() {
  self endon("fight_complete");
  self.wave_management = spawnStruct();

  if(!isDefined(self.wave_management.expected_zombies))
    self.wave_management.expected_zombies = [];

  while(isalive(self)) {
    self waittill("phase_wave_management_update");
    thread wave_management_living_think();
  }
}

wave_management_living_think() {
  self endon("phase_wave_management_update");

  foreach(var_1 in self.wave_management.expected_zombies)
  childthread manage_respawn(var_1);
}

manage_respawn(var_0) {
  var_1 = undefined;
  var_2 = common_scripts\utility::_id_46B7("zone_citadel_spawners", "targetname");
  var_3 = undefined;

  for(;;) {
    if(!isDefined(var_1)) {
      var_3 = _id_054D::_id_90BA(var_0, common_scripts\utility::random(var_2), "final boss fight", 0, 1, 1);

      if(!isDefined(var_3)) {
        wait 1;
        continue;
      }
    }

    while(isDefined(var_3.health) && var_3.health > 0)
      waitframe();

    wait(get_respawn_times());
  }
}

get_respawn_times() {
  var_0 = 5;

  switch (level.players.size) {
    case 1:
      var_0 = 16;
      break;
    case 2:
      var_0 = 12;
      break;
    case 3:
      var_0 = 10;
      break;
    case 4:
      var_0 = 8;
      break;
    default:
      break;
  }

  return var_0;
}

wave_management_set(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case 0:
      var_1 = ::phase0_wave_management;
      break;
    case 1:
      var_1 = ::phase1_wave_management;
      break;
    case 2:
      var_1 = ::phase2_wave_management;
      break;
    case 3:
      var_1 = ::phase3_wave_management;
      break;
    case 4:
      var_1 = ::phase4_wave_management;
      break;
    default:
      break;
  }

  if(common_scripts\utility::_id_3794("phase_transition_active"))
    common_scripts\utility::_id_37A1("phase_transition_active");

  self notify("phase_wave_management_update");

  if(isDefined(var_1))
    [[var_1]]();
}

phase0_wave_management() {
  self endon("phase_wave_management_update");
  var_0 = getEntArray("zone_citadel_spawners", "targetname");
  var_1 = undefined;

  switch (level.players.size) {
    case 1:
      var_1 = ["zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_berserker", "zombie_berserker"];
      break;
    case 2:
      var_1 = ["zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_berserker", "zombie_berserker"];
      break;
    case 3:
      var_1 = ["zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_berserker", "zombie_berserker"];
      break;
    case 4:
      var_1 = ["zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_berserker", "zombie_berserker"];
      break;
    default:
      break;
  }

  self.wave_management.expected_zombies = var_1;
}

phase1_wave_management() {
  self endon("phase_wave_management_update");
  var_0 = getEntArray("zone_citadel_spawners", "targetname");
  var_1 = undefined;

  switch (level.players.size) {
    case 1:
      var_1 = ["zombie_generic", "zombie_generic", "zombie_berserker", "zombie_berserker", "zombie_berserker", "zombie_exploder"];
      break;
    case 2:
      var_1 = ["zombie_generic", "zombie_generic", "zombie_generic", "zombie_berserker", "zombie_berserker", "zombie_berserker", "zombie_exploder"];
      break;
    case 3:
      var_1 = ["zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_berserker", "zombie_berserker", "zombie_berserker", "zombie_exploder", "zombie_exploder"];
      break;
    case 4:
      var_1 = ["zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_berserker", "zombie_berserker", "zombie_berserker", "zombie_berserker", "zombie_exploder", "zombie_exploder"];
      break;
    default:
      break;
  }

  self.wave_management.expected_zombies = var_1;
}

phase2_wave_management() {
  self endon("phase_wave_management_update");
  var_0 = getEntArray("zone_citadel_spawners", "targetname");
  var_1 = undefined;

  switch (level.players.size) {
    case 1:
      var_1 = ["zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_berserker", "zombie_exploder", "zombie_heavy"];
      break;
    case 2:
      var_1 = ["zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_berserker", "zombie_berserker", "zombie_exploder", "zombie_heavy", "zombie_heavy"];
      break;
    case 3:
      var_1 = ["zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_berserker", "zombie_berserker", "zombie_exploder", "zombie_exploder", "zombie_heavy", "zombie_heavy", "zombie_heavy"];
      break;
    case 4:
      var_1 = ["zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_berserker", "zombie_berserker", "zombie_exploder", "zombie_exploder", "zombie_heavy", "zombie_heavy", "zombie_heavy", "zombie_heavy"];
      break;
    default:
      break;
  }

  self.wave_management.expected_zombies = var_1;
}

phase3_wave_management() {
  self endon("phase_wave_management_update");
  var_0 = getEntArray("zone_citadel_spawners", "targetname");
  var_1 = undefined;

  switch (level.players.size) {
    case 1:
      var_1 = ["zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_exploder", "zombie_exploder", "zombie_dlc4"];
      break;
    case 2:
      var_1 = ["zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_berserker", "zombie_berserker", "zombie_exploder", "zombie_exploder", "zombie_dlc4"];
      break;
    case 3:
      var_1 = ["zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_berserker", "zombie_berserker", "zombie_berserker", "zombie_heavy", "zombie_exploder", "zombie_exploder", "zombie_exploder", "zombie_dlc4", "zombie_dlc4"];
      break;
    case 4:
      var_1 = ["zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_berserker", "zombie_berserker", "zombie_berserker", "zombie_berserker", "zombie_heavy", "zombie_heavy", "zombie_exploder", "zombie_exploder", "zombie_exploder", "zombie_exploder", "zombie_dlc4", "zombie_dlc4", "zombie_dlc4"];
      break;
    default:
      break;
  }

  self.wave_management.expected_zombies = var_1;
}

phase4_wave_management() {
  self endon("phase_wave_management_update");
  var_0 = getEntArray("zone_citadel_spawners", "targetname");
  var_1 = [];
  self.wave_management.expected_zombies = var_1;
}

phase5_wave_management() {
  self endon("phase_wave_management_update");
  var_0 = getEntArray("zone_citadel_spawners", "targetname");
  var_1 = undefined;

  switch (level.players.size) {
    case 1:
      var_1 = ["zombie_dlc4", "zombie_dlc4"];
      break;
    case 2:
      var_1 = ["zombie_dlc4", "zombie_dlc4", "zombie_dlc4"];
      break;
    case 3:
      var_1 = ["zombie_dlc4", "zombie_dlc4", "zombie_dlc4", "zombie_dlc4"];
      break;
    case 4:
      var_1 = ["zombie_dlc4", "zombie_dlc4", "zombie_dlc4", "zombie_dlc4"];
      break;
    default:
      break;
  }

  self.wave_management.expected_zombies = var_1;
}

phase6_wave_management() {
  self endon("phase_wave_management_update");
  var_0 = getEntArray("zone_citadel_spawners", "targetname");
  var_1 = undefined;

  switch (level.players.size) {
    case 1:
      var_1 = ["zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_berserker", "zombie_berserker", "zombie_exploder", "zombie_exploder"];
      break;
    case 2:
      var_1 = ["zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_berserker", "zombie_berserker", "zombie_heavy", "zombie_exploder", "zombie_exploder"];
      break;
    case 3:
      var_1 = ["zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_berserker", "zombie_berserker", "zombie_berserker", "zombie_heavy", "zombie_exploder", "zombie_exploder", "zombie_exploder"];
      break;
    case 4:
      var_1 = ["zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_generic", "zombie_berserker", "zombie_berserker", "zombie_berserker", "zombie_berserker", "zombie_heavy", "zombie_heavy", "zombie_heavy", "zombie_exploder", "zombie_exploder", "zombie_exploder", "zombie_exploder"];
      break;
    default:
      break;
  }

  self.wave_management.expected_zombies = var_1;
}

special_geist_blast_try() {
  var_0 = self;
  return 1;
}

special_geist_blast_start() {
  var_0 = self;
  var_0.current_blast = spawnStruct();
}

special_geist_blast_think() {
  var_0 = self;

  if(var_0 king_try_interrupted_by_pain())
    return 1;

  var_1 = _id_0547::_id_5565(var_0.current_blast.rotation_target, var_0.rotation_target);
  var_2 = var_0 king_enemy_target_is_valid(var_0.current_blast.target);
  var_3 = var_0 king_is_in_or_waiting_for_scripted_state("geist_blast");

  if(!var_2) {
    var_4 = var_0.current_blast.target;

    if(!var_2) {
      var_0 notify("blast_target_lost");
      var_4 = var_0 king_get_enemy_target();
    }

    if(isDefined(var_4)) {
      var_0.current_blast.rotation_target = var_0 create_rotation_target_ent(var_4);
      var_0 set_rotation_target(var_0.current_blast.rotation_target);
      var_0.current_blast.target = var_4;
      var_0.current_blast.last_known_target_origin = var_0.current_blast.target.origin;
      var_0 thread special_geist_blast_tracking();
    }
  }

  if(!common_scripts\utility::_id_562E(var_0.current_blast.anim_state_completed)) {
    if(var_1 && var_2) {
      if(!var_3)
        var_0 thread _id_0547::_id_7D1A("geist_blast", undefined, undefined, [var_0, "stand_pain_interrupt"]);
    }
  } else
    return 1;

  return 0;
}

special_geist_blast_tracking() {
  var_0 = self;
  var_0 endon("death");
  var_0 endon("geist_blast_end");

  while(isDefined(var_0) && isDefined(var_0.current_blast)) {
    var_1 = var_0 king_enemy_target_is_valid(var_0.current_blast.target);

    if(var_1 && !_id_0547::_id_5565(var_0.current_blast.rotation_locked, 1)) {
      var_0.current_blast.rotation_target.origin = var_0.current_blast.target.origin;
      var_0.current_blast.last_known_target_origin = var_0.current_blast.target.origin;
    }

    wait 0.2;
  }
}

special_geist_blast_end() {
  var_0 = self;
  var_0.current_blast = undefined;
  var_0 notify("geist_blast_end");
}

anim_state_geist_blast_run() {
  var_0 = self;
  var_0 endon("geist_blast_end");

  if(!isDefined(var_0.current_blast)) {
    return;
  }
  var_0 pause_manual_move();
  var_0 start_manual_rotation();
  var_0 disable_geist_bullet_shield();
  var_1 = maps\mp\agents\_scripted_agent_anim_util::_id_434D("geist_bolt");
  var_2 = maps\mp\agents\_scripted_agent_anim_util::_id_7A35(var_1);
  var_0.fx_blast_hand = _func_2A8(common_scripts\utility::_id_44F5("zmb_gk_geistblast_buildup"), var_0, "J_Wrist_LE");
  var_0.fx_blast_hand _id_0378::_id_8D74("god_king_giestblast_charge");
  var_0 king_handle_attached_vfx_cleanup(var_0.fx_blast_hand, 1);
  _func_14C(var_0.fx_blast_hand);
  var_0 thread blast_tracking_notetrack();
  maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_1, var_2, 1, "king_attack", "premature_end", ::geist_blast_handle_notetracks);
  var_0.fx_blast_hand delete();
  var_0.fx_blast_hand = undefined;
  var_0.current_blast.anim_state_completed = 1;
}

blast_tracking_notetrack() {
  var_0 = self;
  var_0 endon("death");
  var_0 endon("geist_blast_end");
  maps\mp\agents\_scripted_agent_anim_util::_id_A79E("king_attack", "stop_tracking", "geist_bolt");

  if(!isDefined(var_0.current_blast)) {
    return;
  }
  var_0.current_blast.rotation_locked = 1;
}

anim_state_geist_blast_end() {
  var_0 = self;
  var_0 pause_manual_rotation();
  var_0 pause_manual_move();
}

geist_blast_handle_notetracks(var_0, var_1, var_2, var_3) {
  switch (var_0) {
    case "bolt_throw":
      thread geist_blast_throw();
      break;
  }
}

geist_blast_throw() {
  var_0 = self;
  var_1 = var_0.current_blast.last_known_target_origin;
  var_2 = var_0 gettagorigin("J_Wrist_LE");
  var_3 = _func_1B5("geist_blast_red", var_2, var_1, var_0, 1, 1);
  var_3._id_0117 = var_0;
  var_0.current_blast._id_776C = var_3;
  var_3 thread geist_blast_zombie_damage();
  _id_0378::_id_8D74("god_king_giestblast_throw", var_3, var_0);

  if(isDefined(level.ice_blocks))
    var_3 thread maps\mp\mp_zombie_descent_ee_main::test_ice_block_projectile_hit(var_0);

  var_0 pause_manual_rotation();
}

geist_blast_player(var_0, var_1) {
  var_2 = self;
  var_3 = _func_1B5("geist_blast_red", var_0, var_1, var_2, 1, 1);
  var_3._id_0117 = var_2;
  var_3 thread geist_blast_zombie_damage();
  var_3 thread notify_on_notification("blast_failed", var_2, "disconnect");
}

notify_on_notification(var_0, var_1, var_2) {
  self endon("death");
  var_1 waittill(var_2);

  if(isDefined(self))
    self notify(var_0);
}

geist_blast_zombie_damage() {
  var_0 = self;
  self endon("blast_reflected");
  self endon("blast_failed");
  var_0 waittill("explode", var_1);
  var_2 = var_0._id_0117;

  if(isDefined(var_2.current_blast) && isDefined(var_2.current_blast._id_776C))
    var_2.current_blast._id_776C = undefined;

  var_3 = _id_0547::_id_408F();
  var_3 = _func_1AC(var_3, var_1, 256);

  foreach(var_5 in var_3) {
    if(!isDefined(var_5._id_0A4B) || _id_0547::_id_5565(var_5, var_2)) {
      continue;
    }
    if(isDefined(var_5.isempowered)) {
      continue;
    }
    if(_func_0E1(var_5.origin, var_1) <= 64) {
      if(_id_0547::_id_5565(level.zombie_king, var_5))
        var_5 _meth_8059(1800, var_2.origin, var_2, var_2, "MOD_EXPLOSIVE", "geist_blast_red");
      else
        var_5 _meth_8059(var_5.health + 666, var_2.origin, var_2, var_2, "MOD_EXPLOSIVE", "geist_blast_red");

      continue;
    }

    if(_func_0E1(var_5.origin, var_1) <= 128) {
      if(_id_0547::_id_5565(level.zombie_king, var_5))
        var_5 _meth_8059(1200, var_2.origin, var_2, var_2, "MOD_EXPLOSIVE", "geist_blast_red");
      else
        var_5 _meth_8059(var_5.maxhealth * 0.66, var_2.origin, var_2, var_2, "MOD_EXPLOSIVE", "geist_blast_red");

      if(isDefined(var_5._id_0A4B)) {
        var_6 = _id_0547::_id_0A51(var_5._id_0A4B);

        if(isDefined(var_6) && common_scripts\utility::_id_562E(var_6.knockbybladebarbarossa))
          _id_0547::_id_7D1B(var_2, var_5, "medium");
      }

      continue;
    }

    if(_func_0E1(var_5.origin, var_1) <= 256) {
      if(_id_0547::_id_5565(level.zombie_king, var_5))
        var_5 _meth_8059(600, var_2.origin, var_2, var_2, "MOD_EXPLOSIVE", "geist_blast_red");
      else
        var_5 _meth_8059(var_5.maxhealth * 0.33, var_2.origin, var_2, var_2, "MOD_EXPLOSIVE", "geist_blast_red");

      if(isDefined(var_5._id_0A4B)) {
        var_6 = _id_0547::_id_0A51(var_5._id_0A4B);

        if(isDefined(var_6) && common_scripts\utility::_id_562E(var_6.knockbybladebarbarossa))
          _id_0547::_id_7D1B(var_2, var_5, "far");
      }
    }
  }
}

special_geist_lightning_try() {
  var_0 = self;
  return 1;
}

special_geist_lightning_start() {
  var_0 = self;
  var_0.current_lightning = spawnStruct();
}

special_geist_lightning_think() {
  var_0 = self;

  if(var_0 king_try_interrupted_by_pain())
    return 1;

  var_1 = _id_0547::_id_5565(var_0.current_lightning.rotation_target, var_0.rotation_target);
  var_2 = var_0 king_enemy_target_is_valid(var_0.current_lightning.target);
  var_3 = var_0 king_is_in_or_waiting_for_scripted_state("geist_lightning");

  if(!var_1 || !var_2) {
    var_4 = var_0.current_lightning.target;

    if(!var_2)
      var_4 = var_0 king_get_enemy_target();

    if(isDefined(var_4)) {
      var_0.current_lightning.rotation_target = var_0 create_rotation_target_ent(var_4);
      var_0 set_rotation_target(var_0.current_lightning.rotation_target);
      var_0.current_lightning.target = var_4;
    }
  }

  if(!var_2) {
    if(!isDefined(var_0.current_lightning.invalid_target_time))
      var_0.current_lightning.invalid_target_time = gettime();
    else if(gettime() - var_0.current_lightning.invalid_target_time > 2000) {
      var_0 notify("invalid_target_interrupt");
      return 1;
    }
  } else {
    var_0.current_lightning.invalid_target_time = undefined;
    var_0.current_lightning.last_known_target = var_0.current_lightning.target;
  }

  if(!common_scripts\utility::_id_562E(var_0.current_lightning.anim_state_completed)) {
    if(var_1 && var_2) {
      if(!var_3)
        var_0 thread _id_0547::_id_7D1A("geist_lightning");
    }
  } else
    return 1;

  return 0;
}

special_geist_lightning_end() {
  var_0 = self;
  var_0.current_lightning = undefined;
  var_0 notify("geist_lightning_end");
}

anim_state_geist_lightning_run() {
  var_0 = self;
  var_0 endon("geist_lightning_end");

  if(!isDefined(var_0.current_lightning)) {
    return;
  }
  var_0 pause_manual_move();
  var_0 start_manual_rotation();
  var_0 disable_geist_bullet_shield();
  var_1 = maps\mp\agents\_scripted_agent_anim_util::_id_434D("geist_lightning");
  var_2 = maps\mp\agents\_scripted_agent_anim_util::_id_7A35(var_1);
  var_0.fx_lightning_hand = _func_2A8(common_scripts\utility::_id_44F5("zmb_blood_zmb_bolt"), var_0, "J_Wrist_RI");
  var_0 king_handle_attached_vfx_cleanup(var_0.fx_lightning_hand, 1);
  _func_14C(self.fx_lightning_hand);
  var_0.fx_lightning_hand _id_0378::_id_8D74("god_king_lightning_summon");
  maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_1, var_2, 1, "king_attack", "end", ::geist_lightning_handle_notetracks);
  var_0.current_lightning.anim_state_completed = 1;
  var_0.fx_lightning_hand delete();
  var_0.fx_lightning_hand = undefined;
}

anim_state_geist_lightning_end() {
  var_0 = self;
  var_0 pause_manual_rotation();
  var_0 pause_manual_move();
}

geist_lightning_handle_notetracks(var_0, var_1, var_2, var_3) {
  switch (var_0) {
    case "cast":
      thread geist_lightning_throw();
      break;
  }
}

geist_lightning_throw() {
  var_0 = self;

  if(king_enemy_target_is_valid(var_0.current_lightning.target)) {
    var_1 = var_0.current_lightning.target;
    var_2 = var_0.current_lightning.target.origin;
    var_3 = var_0 gettagorigin("J_Wrist_LE");
    var_1 thread geist_lightning_shot(var_0);
  }

  var_0 pause_manual_rotation();
}

geist_lightning_shot(var_0) {
  var_1 = self;
  var_1.islightningtarget = 1;
  var_2 = geist_lighting_collect_subsequent_victims(var_1);
  try_lightning(var_0, var_2);

  foreach(var_1 in var_2) {
    if(isalive(var_1))
      var_1.islightningtarget = undefined;
  }
}

geist_lighting_collect_subsequent_victims(var_0) {
  var_1 = [var_0];
  var_2 = undefined;

  for(var_3 = 0; var_3 <= 4; var_3++) {
    var_2 = var_1[var_3] get_next_lightning_target();

    if(!isDefined(var_2)) {
      break;
    }

    var_2.islightningtarget = 1;
    var_1[var_1.size] = var_2;
  }

  return var_1;
}

try_lightning(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;
  var_4 = undefined;
  var_5 = [];

  foreach(var_7 in var_1) {
    var_2 = var_2 + 1;

    if(isPlayer(var_7))
      var_3 = var_3 + 1;
  }

  if(var_3 <= 0)
    var_3 = 1;

  if(common_scripts\utility::_id_562E(var_0.issolomode))
    var_9 = var_2 - 2 / (1.5 / var_3);
  else
    var_9 = var_2 - 2 / (level.players.size / var_3);

  var_10 = var_9 / var_1.size;

  if(var_10 < 0.4)
    var_10 = 0.4;

  foreach(var_20, var_7 in var_1) {
    if(!isDefined(var_4)) {
      var_12 = "J_Wrist_RI";
      var_13 = var_0;
      var_14 = var_12;
    } else {
      var_13 = var_4;
      var_14 = "J_Spine4";
    }

    var_15 = var_7;
    var_16 = "J_Spine4";
    var_17 = undefined;

    if(isDefined(level.ice_blocks))
      var_17 = maps\mp\mp_zombie_descent_ee_main::test_ice_block_bullettrace_hit(var_13 gettagorigin(var_14), var_15 gettagorigin(var_16));

    var_18 = undefined;

    if(_id_0547::_id_5565(var_17[0], 1)) {
      var_15 = common_scripts\utility::_id_8FFC();
      var_15 thread delete_time(0.2);
      var_15.origin = var_17[1];
      var_15 _meth_805B();
      var_16 = "TAG_ORIGIN";
      var_18 = 1;
    }

    var_19 = _func_382("zmb_geistkraft_godking_lightning_beam", var_13, var_14, var_15, var_16);
    var_19 thread delete_time(0.1);
    _func_147(common_scripts\utility::_id_44F5("zmb_giestkraft_impact"), var_7, "J_spine4");
    var_0 _id_0378::_id_8D74("god_king_lightning");

    if(_id_0547::_id_5565(var_18, 1)) {
      return;
    }
    if(_id_0547::_id_5565(level.ravenweaponmanager["shield_emp"]._id_0117, var_7) && var_7 maps\mp\zombies\weapons\_zombie_dlc4_melee::shield_block_test_func(var_0)) {
      return;
    }
    var_4 = var_7;
    var_5[var_5.size] = var_7;
  }

  foreach(var_7 in var_5) {
    var_7 _meth_8059(var_7.maxhealth * var_10, self.origin, var_0, var_0, "MOD_ENERGY");

    if(isDefined(var_7._id_0A4B)) {
      var_22 = _id_0547::_id_0A51(var_7._id_0A4B);

      if(isDefined(var_22) && common_scripts\utility::_id_562E(var_22.knockbybladebarbarossa))
        _id_0547::_id_7D1B(var_0, var_7, "medium");
    }
  }
}

special_geist_bombs_try() {
  var_0 = self;
  return 1;
}

special_geist_bombs_start() {
  var_0 = self;
  var_0.current_bombs = spawnStruct();
}

special_geist_bombs_think() {
  var_0 = self;

  if(var_0 king_try_interrupted_by_pain())
    return 1;

  var_1 = _id_0547::_id_5565(var_0.current_bombs.rotation_target, var_0.rotation_target);
  var_2 = var_0 king_enemy_target_is_valid(var_0.current_bombs.target);
  var_3 = var_0 king_is_in_or_waiting_for_scripted_state("geist_bomb");

  if(!var_1 || !var_2) {
    var_4 = var_0.current_bombs.target;

    if(!var_2)
      var_4 = var_0 king_get_enemy_target();

    if(isDefined(var_4)) {
      var_0.current_bombs.rotation_target = var_0 create_rotation_target_ent(var_4);
      var_0 set_rotation_target(var_0.current_bombs.rotation_target);
      var_0.current_bombs.target = var_4;
    }
  }

  if(!var_2) {
    if(!isDefined(var_0.current_bombs.invalid_target_time))
      var_0.current_bombs.invalid_target_time = gettime();
    else if(gettime() - var_0.current_bombs.invalid_target_time > 2000) {
      var_0 notify("invalid_target_interrupt");
      return 1;
    }
  } else {
    var_0.current_bombs.invalid_target_time = undefined;
    var_0.current_bombs.last_known_target_origin = var_0.current_bombs.target.origin;
  }

  if(!common_scripts\utility::_id_562E(var_0.current_bombs.anim_state_completed)) {
    if(var_1 && var_2) {
      if(!var_3)
        var_0 thread _id_0547::_id_7D1A("geist_bomb");
    }
  } else
    return 1;

  return 0;
}

special_geist_bombs_end() {
  var_0 = self;
  var_0.current_bombs = undefined;
  var_0 notify("geist_bombs_end");
}

anim_state_geist_bombs_run() {
  var_0 = self;
  var_0 endon("geist_bombs_end");

  if(!isDefined(var_0.current_bombs)) {
    return;
  }
  var_0 pause_manual_move();
  var_0 start_manual_rotation();
  var_0 disable_geist_bullet_shield();
  var_1 = maps\mp\agents\_scripted_agent_anim_util::_id_434D("geist_bombs");
  var_2 = maps\mp\agents\_scripted_agent_anim_util::_id_7A35(var_1);
  maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_1, var_2, 1, "king_attack", "end", ::geist_bombs_handle_notetracks);
  var_0.current_bombs.anim_state_completed = 1;
}

anim_state_geist_bombs_end() {
  var_0 = self;
  var_0 pause_manual_rotation();
  var_0 pause_manual_move();
}

geist_bombs_handle_notetracks(var_0, var_1, var_2, var_3) {
  switch (var_0) {
    case "bomb_throw":
      level.zombie_king thread geist_bombs_throw();
      break;
  }
}

geist_bombs_throw(var_0) {
  var_1 = "TAG_WEAPON_CHEST";

  if(!_id_0547::_id_5565(level.zombie_king, self))
    var_1 = "TAG_ORIGIN";

  if(isDefined(var_0))
    var_2 = var_0.origin;
  else
    var_2 = self.current_bombs.last_known_target_origin;

  var_3 = self;

  if(!_id_0547::_id_5565(level.zombie_king, self))
    var_3 = undefined;

  thread vo_play_gdk_ability_line("geist_bomb_toss");
  var_4 = get_bomb_start_pos(var_1);
  var_5 = _func_1B6("geist_bomb_artil", var_4, var_2, 2, var_4[2] + 50, var_3);
  var_5 thread geist_bombs_projectile_think(var_3);
  wait 0.1;
  var_4 = get_bomb_start_pos(var_1);
  var_6 = _func_1B6("geist_bomb_artil", var_4, var_2 + (200, 0, 0), 2, var_4[2] + 50, var_3);
  var_6 thread geist_bombs_projectile_think(var_3);
  wait 0.1;
  var_4 = get_bomb_start_pos(var_1);
  var_7 = _func_1B6("geist_bomb_artil", var_4, var_2 + (33, 200, 0), 2, var_4[2] + 50, var_3);
  var_7 thread geist_bombs_projectile_think(var_3);
  wait 0.1;
  var_4 = get_bomb_start_pos(var_1);
  var_8 = _func_1B6("geist_bomb_artil", var_4, var_2 + (33, -200, 0), 2, var_4[2] + 50, var_3);
  var_8 thread geist_bombs_projectile_think(var_3);
  wait 0.1;
  var_4 = get_bomb_start_pos(var_1);
  var_9 = _func_1B6("geist_bomb_artil", var_4, var_2 + (-200, 66, 0), 2, var_4[2] + 50, var_3);
  var_9 thread geist_bombs_projectile_think(var_3);
  wait 0.1;
  var_4 = get_bomb_start_pos(var_1);
  var_10 = _func_1B6("geist_bomb_artil", var_4, var_2 + (-200, -66, 0), 2, var_4[2] + 50, var_3);
  var_10 thread geist_bombs_projectile_think(var_3);

  if(!_id_0547::_id_5565(level.zombie_king, self)) {
    return;
  }
  pause_manual_rotation();
}

get_bomb_start_pos(var_0) {
  var_1 = self gettagorigin(var_0);
  return var_1;
}

geist_bombs_projectile_think(var_0) {
  var_1 = self;
  _id_0378::_id_8D74("god_king_giestbomb_projectile", "spawn", var_1);
  var_1 waittill("explode", var_2);
  geist_bombs_static_think(var_2);
}

geist_bombs_static_think(var_0) {
  var_1 = _func_082(var_0, 12);
  var_2 = common_scripts\utility::_id_8FFC();
  var_2 _meth_805B();
  var_2.origin = var_1 + (0, 0, 25);
  var_3 = _func_2A8(common_scripts\utility::_id_44F5("zmb_bomb_sphere"), var_2, "tag_origin");
  var_4 = _func_2A8(common_scripts\utility::_id_44F5("zmb_godking_giestbomb"), var_2, "tag_origin");
  var_5 = _func_2A8(common_scripts\utility::_id_44F5("zmb_godking_giestbomb_prime"), var_2, "tag_origin");
  thread show_bomb_vfx(var_4, var_3, var_5);
  _id_0378::_id_8D74("god_king_giestbomb_projectile", "activate", var_2);
  wait 6;
  _func_147(common_scripts\utility::_id_44F5("zmb_giestbomb_exp_1shot"), var_2, "TAG_ORIGIN");
  _id_0378::_id_8D74("god_king_giestbomb_projectile", "explode", var_2);
  var_6 = _id_0547::_id_408F();
  var_7 = level.players;
  var_8 = common_scripts\utility::_id_0F73(var_6, var_7);

  foreach(var_10 in var_8) {
    if(_func_0E1(var_10.origin, var_0) <= 160)
      var_10 _meth_8059(100, var_0, level.zombie_king, level.zombie_king, "MOD_EXPLOSIVE", "geist_bomb_artil");
  }

  if(isDefined(level.ice_blocks))
    var_12 = maps\mp\mp_zombie_descent_ee_main::test_ice_block_explosion_hit(var_2.origin, 160);

  waitframe();
  var_2 delete();
}

show_bomb_vfx(var_0, var_1, var_2) {
  _func_14C(var_0);
  _func_14C(var_1);
  wait 2;
  _func_14C(var_2);
  wait 4;
  var_1 delete();
  var_0 delete();
  var_2 delete();
}

special_detonate_try() {
  var_0 = self;
  var_1 = _id_0547::_id_408F();
  var_2 = common_scripts\utility::_id_0F93(var_1, var_0);
  var_3 = [];

  foreach(var_0 in var_2) {
    if(var_0 _id_0547::_id_4B2C())
      var_3[var_3.size] = var_0;
  }

  if(var_3.size > 0)
    return 1;

  return 0;
}

special_detonate_start() {
  var_0 = self;
  var_0.current_detonate = spawnStruct();
}

special_detonate_think() {
  var_0 = self;

  if(var_0 king_try_interrupted_by_pain())
    return 1;

  var_1 = _id_0547::_id_5565(var_0.current_detonate.rotation_target, var_0.rotation_target);
  var_2 = var_0 king_enemy_target_is_valid(var_0.current_detonate.target);
  var_3 = var_0 king_is_in_or_waiting_for_scripted_state("detonate");

  if(!var_1 || !var_2) {
    var_4 = var_0.current_detonate.target;

    if(!var_2)
      var_4 = var_0 king_get_detonate_target();

    if(isDefined(var_4)) {
      var_0.current_detonate.rotation_target = var_0 create_rotation_target_ent(var_4);
      var_0 set_rotation_target(var_0.current_detonate.rotation_target);
      var_0.current_detonate.target = var_4;
    }
  }

  if(!var_2) {
    if(!isDefined(var_0.current_detonate.invalid_target_time))
      var_0.current_detonate.invalid_target_time = gettime();
    else if(gettime() - var_0.current_detonate.invalid_target_time > 2000) {
      var_0 notify("invalid_target_interrupt");
      return 1;
    }
  } else {
    var_0.current_detonate.invalid_target_time = undefined;
    var_0.current_detonate.last_known_target = var_0.current_detonate.target;
  }

  if(!common_scripts\utility::_id_562E(var_0.current_detonate.anim_state_completed)) {
    if(var_1 && var_2) {
      if(!var_3)
        var_0 thread _id_0547::_id_7D1A("detonate");
    }
  } else
    return 1;

  return 0;
}

special_detonate_end() {
  var_0 = self;
  var_0.current_detonate = undefined;
  var_0 notify("detonate_end");
}

anim_state_detonate_run() {
  var_0 = self;
  var_0 endon("detonate_end");

  if(!isDefined(var_0.current_detonate)) {
    return;
  }
  var_0 pause_manual_move();
  var_0 start_manual_rotation();
  var_0 disable_geist_bullet_shield();
  var_1 = maps\mp\agents\_scripted_agent_anim_util::_id_434D("detonate");
  var_2 = maps\mp\agents\_scripted_agent_anim_util::_id_7A35(var_1);
  var_0 _id_0378::_id_8D74("god_king_detonate_cast");
  maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_1, var_2, 1, "king_attack", "end", ::detonate_handle_notetracks);
  var_0.current_detonate.anim_state_completed = 1;
}

anim_state_detonate_end() {
  var_0 = self;
  var_0 pause_manual_rotation();
  var_0 pause_manual_move();
}

detonate_handle_notetracks(var_0, var_1, var_2, var_3) {
  switch (var_0) {
    case "detonate_start":
      thread detonate_throw();
      break;
  }
}

detonate_throw() {
  var_0 = self;

  if(king_enemy_target_is_valid(var_0.current_detonate.target)) {
    var_1 = var_0.current_detonate.target;
    var_2 = _func_382("zmb_geistkraft_reg_beam_med", var_0, "J_Wrist_RI", var_1, "J_Spine4");
    _id_0378::_id_8D74("god_king_detonate_throw", var_1);
    var_2 thread delete_time(0.45);
    var_1 thread detonate_victim(var_0);
  }

  var_0 pause_manual_rotation();
}

delete_time(var_0) {
  wait(var_0);
  self delete();
}

delete_on_parent_notify(var_0, var_1) {
  self endon("death");
  var_0 waittill(var_1);
  self delete();
}

detonate_victim(var_0) {
  var_1 = self;
  var_1 endon("death");
  var_1.isempowered = 1;
  var_1.fuze_fx = _func_2A8(level._effect["zmf_corpse_eater_smoldering"], var_1, "J_Spine4");
  _func_14C(var_1.fuze_fx);
  var_1 _id_0378::_id_8D74("aud_corpse_eater_fully_charged");
  var_1 maps\mp\agents\_agent_utility::deleteentonagentdeath(var_1.fuze_fx);
  wait 10;
  thread try_detonation(var_0);
}

try_detonation(var_0) {
  if(isDefined(self.fuze_fx))
    self.fuze_fx delete();

  var_1 = self gettagorigin("J_Spine4");
  playFX(level._effect["zmb_corpse_eater_detonate"], var_1);
  _id_0378::_id_8D74("aud_corpse_eater_explosion");

  if(common_scripts\utility::_id_562E(self.isforceshieldactive))
    break_force_shield();

  if(isDefined(self.isempowered))
    self.isempowered = undefined;

  self _meth_8059(self.health + 666, self.origin, var_0, var_0, "MOD_ENERGY");
  radiusdamage(self.origin, 200, 200, 160, var_0, "MOD_ENERGY", "corpse_eater_dlc4_zm", 1);

  if(isDefined(level.ice_blocks))
    var_2 = maps\mp\mp_zombie_descent_ee_main::test_ice_block_explosion_hit(self.origin, 200);
}

zombie_detonate_clear_property(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(common_scripts\utility::_id_562E(self.isempowered))
    self.isempowered = undefined;

  if(common_scripts\utility::_id_3C77("flag_boss_complete"))
    _id_0547::_id_2D8C(::zombie_detonate_clear_property);
}

special_geist_pull_try() {
  var_0 = self;
  return 1;
}

special_geist_pull_start() {
  var_0 = self;
  var_0.current_pull = spawnStruct();
  var_1 = get_boss_pull_position(var_0);
  var_0 enable_geist_bullet_shield();
  var_0.current_pull._id_2DA7 = king_create_destination(var_1, 1455);
}

special_geist_pull_think() {
  var_0 = self;
  var_1 = king_has_arrived(var_0.current_pull._id_2DA7);

  if(!var_1)
    king_continue_moving(var_0.current_pull._id_2DA7);

  var_2 = _id_0547::_id_5565(var_0.current_pull.rotation_target, var_0.rotation_target);
  var_3 = var_0 king_enemy_target_is_valid(var_0.current_pull.target);
  var_4 = var_0 king_is_in_or_waiting_for_scripted_state("geist_pull");

  if(!var_2 || !var_3) {
    var_5 = var_0.current_pull.target;

    if(!var_3)
      var_5 = var_0 king_get_enemy_target();

    if(isDefined(var_5)) {
      var_0.current_pull.rotation_target = var_0 create_rotation_target_ent(var_5);
      var_0 set_rotation_target(var_0.current_pull.rotation_target);
      var_0.current_pull.target = var_5;
    }
  }

  if(!var_3) {
    if(!isDefined(var_0.current_pull.invalid_target_time))
      var_0.current_pull.invalid_target_time = gettime();
    else if(gettime() - var_0.current_pull.invalid_target_time > 2000) {
      var_0 notify("invalid_target_interrupt");
      return 1;
    }
  } else {
    var_0.current_pull.invalid_target_time = undefined;
    var_0.current_pull.last_known_target = var_0.current_pull.target;
  }

  if(!common_scripts\utility::_id_562E(var_0.current_pull.anim_state_completed)) {
    if(var_1 && var_2 && var_3) {
      if(!var_4)
        var_0 thread _id_0547::_id_7D1A("geist_pull");
    }
  } else
    return 1;

  return 0;
}

special_geist_pull_end() {
  var_0 = self;
  var_0.current_pull = undefined;
  var_0 notify("geist_pull_end");
}

anim_state_geist_pull_run() {
  var_0 = self;
  var_0 endon("geist_pull_end");

  if(!isDefined(var_0.current_pull)) {
    return;
  }
  var_0 pause_manual_move();
  var_0 start_manual_rotation();
  var_1 = maps\mp\agents\_scripted_agent_anim_util::_id_434D("kneel_vortex");
  var_2 = maps\mp\agents\_scripted_agent_anim_util::_id_7A35(var_1);
  var_0 _id_0378::_id_8D74("god_king_pull_summon");
  maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_1, var_2, 1, "king_attack", "end", ::geist_pull_handle_notetracks);
  var_0.current_pull.anim_state_completed = 1;
}

anim_state_geist_pull_end() {
  var_0 = self;
  var_0 pause_manual_rotation();
  var_0 pause_manual_move();
}

geist_pull_handle_notetracks(var_0, var_1, var_2, var_3) {
  switch (var_0) {
    case "pull_begin":
      thread geist_pull_aoe();
      break;
  }
}

geist_pull_aoe() {
  var_0 = self;
  var_1 = "TAG_WEAPON_LEFT";
  _func_147(common_scripts\utility::_id_44F5("zmb_pommel_energy_field_burst"), var_0, var_1);
  var_0 _id_0378::_id_8D74("god_king_pull");
  var_2 = [];
  var_2 = var_0 king_get_targets_in_range(1600);
  var_0 thread spawn_attractor_nodes();
  _id_0547::_id_7BA9(::boss_mind_control_fx_clear);

  if(isDefined(var_2)) {
    foreach(var_4 in var_2)
    var_0 thread geist_pull_attack_victim(var_4, 6);
  }

  _id_0547::_id_2D8C(::boss_mind_control_fx_clear);
  var_0 pause_manual_rotation();
}

geist_pull_attack_victim(var_0, var_1) {
  var_2 = self;
  var_0 endon("death");
  var_2 endon("death");
  var_3 = isPlayer(var_0);

  if(var_3 && _id_0547::_id_577E(var_0)) {
    return;
  }
  var_4 = var_0.origin + (0, 0, 32);
  var_5 = var_2.origin + (0, 0, 64);
  var_6 = 5;
  var_7 = 2560000;
  var_8 = 65536;
  var_9 = _func_211(var_4, var_5);
  var_10 = _func_07E(var_4, var_5, 0, var_2, var_0);

  if(var_9 >= var_7) {
    return;
  }
  var_11 = 1 - (_func_0E1(var_0.origin, var_2.origin) / 1600 - 256) / 1344;

  if(var_11 < 1)
    var_11 = 1;

  var_12 = var_1 * var_11 / 2;
  var_13 = var_1 * var_11;

  if(common_scripts\utility::_id_562E(var_10)) {
    if(var_3 && !_id_0547::_id_577E(var_0)) {
      var_0 _meth_8182("zm_heavy_hit", var_13, var_12);
      var_0 _meth_8308(0);
      var_0 _meth_809F("damage_heavy");
    }

    if(!var_3 && var_0 _id_0547::_id_4B2C() && isDefined(var_2.pull_attractor._id_0F6D)) {
      var_0 thread attract_to_boss(common_scripts\utility::random(var_2.pull_attractor._id_0F6D));
      var_0 thread pull_mind_control_fx();
    }

    if(var_9 > var_8) {
      var_2 thread pulse_drag_in_victim(var_0);

      if(isDefined(var_2))
        var_0 _meth_8059(var_6, var_2.origin, var_2, var_2, "MOD_CRUSH");
    } else if(isDefined(var_2))
      var_0 _meth_8059(var_6, var_2.origin, var_2, var_2, "MOD_CRUSH");
  } else {}

  wait(var_1 * var_11);

  if(var_3 && !_id_0547::_id_577E(var_0))
    var_0 _meth_8308(1);

  waitframe();
}

pulse_drag_in_victim(var_0) {
  var_0 endon("death");
  self endon("death");
  var_1 = 800;
  var_2 = self.origin - var_0.origin;
  var_2 = (var_2[0], var_2[1], 0);
  var_2 = var_1 * vectorNormalize(var_2);
  var_2 = (var_2[0], var_2[1], 125);
  var_0 _meth_82F7(var_2);
}

pull_mind_control_fx() {
  self endon("death");
  self.boss_control_fx = _func_2A8(common_scripts\utility::_id_44F5("zmb_red_zmb_blind"), self, "J_Head");
  _func_14C(self.boss_control_fx);
  maps\mp\agents\_agent_utility::deleteentonagentdeath(self.boss_control_fx);
}

pull_mind_control_clear_fx() {
  if(isDefined(self.boss_control_fx))
    self.boss_control_fx delete();
}

spawn_attractor_nodes() {
  var_0 = self;
  var_1 = common_scripts\utility::_id_8FFC();
  var_2 = common_scripts\utility::_id_8FFC();
  var_3 = common_scripts\utility::_id_8FFC();
  var_4 = common_scripts\utility::_id_8FFC();
  var_5 = common_scripts\utility::_id_8FFC();
  var_1.origin = var_0.origin;
  var_2.origin = var_0.origin + (115, 0, 0);
  var_3.origin = var_0.origin + (0, 115, 0);
  var_4.origin = var_0.origin + (-115, 0, 0);
  var_5.origin = var_0.origin + (0, -115, 0);
  var_1 linktosynchronizedparent(var_0);
  var_2 linktosynchronizedparent(var_1);
  var_3 linktosynchronizedparent(var_1);
  var_4 linktosynchronizedparent(var_1);
  var_5 linktosynchronizedparent(var_1);
  var_0.pull_attractor = var_1;
  var_0.pull_attractor._id_0F6D = [var_2, var_3, var_4, var_5];
  var_0.pull_attractor thread attractor_rotate();
  var_0 common_scripts\utility::_id_A70A("zombie_kneel", "geist_drain_result", "flame_wave_cast");

  if(isDefined(var_2))
    var_2 delete();

  if(isDefined(var_3))
    var_3 delete();

  if(isDefined(var_4))
    var_4 delete();

  if(isDefined(var_5))
    var_5 delete();

  if(isDefined(var_1))
    var_1 delete();
}

attractor_rotate() {
  var_0 = 10;

  while(isDefined(self)) {
    self _meth_83E5((360, 0, 0), var_0);
    wait(var_0);
  }
}

attract_to_boss(var_0) {
  var_1 = self;
  var_1 endon("death");

  if(level.players.size > 0)
    var_0._id_4883 = _func_2E1(var_0.origin, level.players[0]);
  else
    var_0._id_4883 = var_0.origin;

  var_2 = 0;

  if(isDefined(level._id_AC80) && isDefined(level._id_AC80._id_ACB3) && level._id_AC80._id_ACB3.size > 0)
    var_2 = _id_055A::_id_578A(var_0._id_4883, 1);

  if(!var_2) {
    return;
  }
  while(isDefined(var_0)) {
    if(common_scripts\utility::_id_562E(var_1.ignoredistractiondrones)) {
      waitframe();
      continue;
    }

    if(isDefined(var_1._id_3045) && var_1._id_3045 == var_0) {
      waitframe();
      continue;
    }

    if(isDefined(var_1._id_3044) && var_1._id_3044 >= 5) {
      if(distance(var_1.origin, var_0.origin) > 256) {
        var_1._id_3045 = var_0;
        var_1._id_3044 = 0;
        var_1._id_3043 = undefined;
        waitframe();
        continue;
      }
    }

    if(!isDefined(var_1._id_3043) || distancesquared(var_1._id_3043._id_4883, var_1.origin) > distancesquared(var_0._id_4883, var_1.origin)) {
      var_3 = var_1 _meth_857B(var_1.origin, var_0._id_4883);

      if(var_3.size > 0) {
        var_1._id_3043 = var_0;
        var_1._id_3044 = 0;
        var_1._id_3045 = undefined;
      }
    }

    wait 0.1;
  }

  var_1 pull_mind_control_clear_fx();
}

boss_mind_control_fx_clear(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(isDefined(self.boss_control_fx))
    self.boss_control_fx delete();
}

special_geist_sit_try() {
  var_0 = self;
  return 1;
}

special_geist_sit_start() {
  var_0 = self;
  var_0.current_sit = spawnStruct();
  var_1 = level.bossfight.throne_pos.origin;
  var_0 enable_geist_bullet_shield();
  var_0.current_sit._id_2DA7 = king_create_destination(var_1);
  var_2 = level.bossfight.throne_pos.angles[1];
  var_0.current_sit.rotation_target = create_rotation_target_yaw(var_2);
  var_0 set_rotation_target(var_0.current_sit.rotation_target);
}

special_geist_sit_think() {
  var_0 = self;
  var_1 = king_has_arrived(var_0.current_sit._id_2DA7);

  if(!var_1)
    king_continue_moving(var_0.current_sit._id_2DA7);

  var_2 = var_0 king_is_in_or_waiting_for_scripted_state("sit");

  if(!common_scripts\utility::_id_562E(var_0.current_sit.anim_state_completed)) {
    if(var_1) {
      if(!var_2)
        var_0 thread _id_0547::_id_7D1A("sit");
    }
  } else
    return 1;

  return 0;
}

special_geist_sit_end() {
  var_0 = self;
  var_0.current_sit = undefined;
  var_0 notify("geist_sit_end");
}

anim_state_geist_sit_run() {
  var_0 = self;

  if(!isDefined(var_0.current_sit)) {
    return;
  }
  var_0 pause_manual_move();
  var_0 pause_manual_rotation();
  var_1 = maps\mp\agents\_scripted_agent_anim_util::_id_434D("death_stand_2_sit");
  var_2 = maps\mp\agents\_scripted_agent_anim_util::_id_7A35(var_1);
  maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_1, var_2, 1, "king_attack", "end");
  var_0.king_seated = 1;
  var_0.current_sit.anim_state_completed = 1;
}

anim_state_geist_sit_end() {
  var_0 = self;
  var_0 pause_manual_rotation();
  var_0 pause_manual_move();
}

special_geist_kneel_try() {
  var_0 = self;
  return 1;
}

special_geist_kneel_start() {
  var_0 = self;
  var_0.current_kneel = spawnStruct();
  var_1 = var_0.origin;
  var_0 enable_geist_bullet_shield();
  var_0.current_kneel._id_2DA7 = king_create_destination(var_1);
  var_0 thread vo_play_gdk_ability_line("kneel_tell");
}

special_geist_kneel_think() {
  var_0 = self;
  var_1 = king_has_arrived(var_0.current_kneel._id_2DA7);

  if(!var_1)
    king_continue_moving(var_0.current_kneel._id_2DA7);

  var_2 = var_0 king_is_in_or_waiting_for_scripted_state("kneel");

  if(!common_scripts\utility::_id_562E(var_0.current_kneel.anim_state_completed)) {
    if(var_1) {
      if(!var_2)
        var_0 thread _id_0547::_id_7D1A("kneel");
    }
  } else
    return 1;

  return 0;
}

special_geist_kneel_end() {
  var_0 = self;
  var_0.current_kneel = undefined;
  var_0 notify("geist_kneel_end");
}

anim_state_geist_kneel_run() {
  var_0 = self;
  var_0 endon("geist_kneel_end");

  if(!isDefined(var_0.current_kneel)) {
    return;
  }
  var_0 pause_manual_move();
  var_0 start_manual_rotation();
  var_1 = maps\mp\agents\_scripted_agent_anim_util::_id_434D("kneel_burst");
  var_2 = maps\mp\agents\_scripted_agent_anim_util::_id_7A35(var_1);
  _id_0378::_id_8D74("god_king_force_kneel");
  var_0 thread vo_play_gdk_ability_line("kneel_execute");
  maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_1, var_2, 1, "king_attack", "end", ::geist_kneel_handle_notetracks);
  var_0.current_kneel.anim_state_completed = 1;
}

anim_state_geist_kneel_end() {
  var_0 = self;
  var_0 pause_manual_rotation();
  var_0 pause_manual_move();
}

geist_kneel_handle_notetracks(var_0, var_1, var_2, var_3) {
  switch (var_0) {
    case "kneel_begin":
      thread geist_kneel_aoe();
      break;
  }
}

geist_kneel_aoe() {
  var_0 = self;
  var_1 = level.players;
  var_0 notify("zombie_kneel");
  thread kill_remaining_zombies();

  foreach(var_3 in var_1)
  var_3 thread geist_kneel_run(var_0);

  var_0 pause_manual_rotation();
}

geist_kneel_run(var_0) {
  var_1 = self;
  var_1 endon("disconnect");
  var_1 common_scripts\utility::_id_0603();
  var_1 common_scripts\utility::_disableoffhandweapons();
  var_1 _meth_8322();
  var_1 maps\mp\_utility::freezecontrolswrapper(1);
  var_1 _meth_8179("crouch");
  var_1 _meth_84C0(1);
  var_1 _meth_8182("zm_heavy_hit", 1.4, 1);
  var_1 _meth_809F("damage_heavy");
  var_1 thread bow_head();
  var_1 waittill("drain_fake_start");
  var_1 thread geist_kneel_break_you(var_0);
  var_1 enable_kneel_vision();
  level common_scripts\utility::_id_67EC(3, "finale_bik_outro_begin");
  var_1 notify("kill_fake_drain_beam");
  waitframe();
  var_1 disable_kneel_vision();
  var_1 release_from_kneel();
  var_1 _meth_84C0(0);
  var_1 _meth_8057(var_1.lerpposent);
  var_1.lerpposent delete();
  var_1 maps\mp\_utility::freezecontrolswrapper(0);
  var_1 _meth_8323();
  var_1 _id_0586::_id_078E(_id_0547::_id_AB2B());
  var_1 common_scripts\utility::_id_0617();
  var_1 common_scripts\utility::_id_0614();
}

bow_head() {
  var_0 = self;
  var_1 = spawn("script_model", var_0.origin);
  var_1 setModel("tag_origin");
  var_2 = var_0 _meth_8566();
  var_1.angles = var_2;
  var_0.lerpposent = var_1;
  var_0 _meth_807B(var_0.lerpposent, "tag_origin", 0.25);
  var_1 _meth_82B1(var_0.lerpposent.origin, 0.05);
  waitframe();
  var_1 _meth_82B8(vectortoangles(level.zombie_king gettagorigin("J_Spine4") - var_0.lerpposent.origin), 0.1);
  wait 0.1;
  var_1 _meth_82B8(vectortoangles(level.zombie_king gettagorigin("J_Spine4") - var_0.lerpposent.origin) + (60, 0, 0), 0.25);
  wait 1.2;
  var_1 _meth_82B8(vectortoangles(level.zombie_king gettagorigin("J_Spine4") - var_0.lerpposent.origin), 2.8, 1, 1.5);
}

geist_kneel_break_you(var_0) {
  level endon("finale_bik_outro_begin");
  self endon("kneel_release");

  for(;;) {
    self _meth_8059(50, var_0.origin, var_0, var_0, "MOD_ENERGY");
    wait 0.8;
  }
}

release_from_kneel() {
  self endon("death");
  self endon("kneel_release");
  level endon("finale_outro_bik_end");
  self waittill("forever");
}

kill_remaining_zombies() {
  var_0 = _id_0547::_id_408F();

  foreach(var_2 in var_0) {
    if(_id_0547::_id_5565(level.zombie_king, var_2)) {
      continue;
    }
    var_2 suicide();
  }
}

enable_kneel_vision() {
  if(!common_scripts\utility::_id_562E(level._id_22F0)) {
    self _meth_8483("mp_zombie_descent_underwater", 0.05);
    self _meth_83C7("mp_zombie_descent_underwater", 0.05);
  }
}

disable_kneel_vision() {
  self _meth_8483("", 0.05);
  self _meth_83C8(0.05);
}

special_geist_drain_try() {
  var_0 = self;
  return 1;
}

special_geist_drain_start() {
  var_0 = self;
  var_0.current_drain = spawnStruct();
  var_1 = var_0.origin;
  var_0 enable_geist_bullet_shield();
  var_0.current_drain._id_2DA7 = king_create_destination(var_1);
}

special_geist_drain_think() {
  var_0 = self;
  var_1 = var_0 king_is_in_or_waiting_for_scripted_state("geist_drain");

  if(!common_scripts\utility::_id_562E(var_0.current_drain.anim_state_completed)) {
    if(!var_1)
      var_0 thread _id_0547::_id_7D1A("geist_drain");
  } else
    return 1;

  return 0;
}

special_geist_drain_end() {
  var_0 = self;
  var_0 notify("geist_drain_end");
  var_0.current_drain = undefined;
}

anim_state_geist_drain_run() {
  var_0 = self;
  var_0 endon("geist_drain_end");

  if(!isDefined(var_0.current_drain)) {
    return;
  }
  var_0 pause_manual_move();
  var_0 pause_manual_rotation();
  var_1 = maps\mp\agents\_scripted_agent_anim_util::_id_434D("geist_drain_enter");
  var_2 = maps\mp\agents\_scripted_agent_anim_util::_id_7A35(var_1);
  maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_1, var_2, 1, "king_attack", "end", ::geist_drain_cast_handle_notetracks);
  _id_0555::_id_83DD("dlc4_godking_drain");
  var_0.drainshieldacive = 1;
  var_0 anim_state_geist_drain_cast_control();
  var_0.drainshieldacive = undefined;
  var_3 = var_0.current_drain._id_7DF9;

  if(_id_0547::_id_5565(var_3, "complete")) {
    var_0.current_drain.geist_drain_struct attack_geist_drain_stop();
    _id_0555::_id_83DD("dlc4_godking_drain_bonus");
    var_0 enable_geist_bullet_shield();
    var_1 = maps\mp\agents\_scripted_agent_anim_util::_id_434D("geist_drain_exit");
    var_2 = maps\mp\agents\_scripted_agent_anim_util::_id_7A35(var_1);
    maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_1, var_2, 1, "king_attack", "end");
  } else {
    var_0.current_drain.geist_drain_struct attack_geist_drain_stop();
    _id_0555::_id_83DD("dlc4_godking_drain_end");
    var_0 disable_geist_bullet_shield();
    var_0 thread enable_body_clip();
    var_1 = maps\mp\agents\_scripted_agent_anim_util::_id_434D("geist_drain_stumble_knockdown");
    var_2 = maps\mp\agents\_scripted_agent_anim_util::_id_7A35(var_1);
    var_0 notify("clear_transition_fx");
    var_0 thread play_punish_vo();
    maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_1, var_2, 1, "king_attack", "end");
    var_0.drainpunishactive = 1;
    var_0 anim_state_ground_recover_loop();
    var_0.drainpunishactive = undefined;

    if(isDefined(var_0.punishdamage))
      var_0.punishdamage = undefined;

    var_0 enable_geist_bullet_shield();
    var_1 = maps\mp\agents\_scripted_agent_anim_util::_id_434D("geist_drain_stumble_recover");
    var_2 = maps\mp\agents\_scripted_agent_anim_util::_id_7A35(var_1);
    maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_1, var_2, 1, "king_attack", "end");
    var_0 thread disable_body_clip();
  }

  var_0 thread king_spawn_pickups(var_0.current_drain.geist_drain_struct.origin);
  var_0.current_drain.anim_state_completed = 1;
}

play_punish_vo() {
  var_0 = self;
  var_0 endon("death");
  wait 0.45;
  var_0 thread vo_play_gdk_ability_line("drain_punished");
}

enable_body_clip() {
  self endon("chest_clip_stop_update");
  var_0 = "J_SpineUpper";
  var_1 = 0.5;
  self.stunnedclip _meth_808C();
  self.stunnedclip.origin = self gettagorigin(var_0);
  self.stunnedclip.angles = self _meth_8181(var_0);
  self.stunnedclip _meth_82C1();

  for(;;) {
    var_2 = self gettagorigin(var_0);
    var_3 = self _meth_8181(var_0);
    self.stunnedclip _meth_82B1(var_2, var_1);
    wait(var_1);
  }
}

disable_body_clip() {
  self.stunnedclip _meth_82C2();
  self notify("chest_clip_stop_update");
  self.stunnedclip.origin = self.stunnedclip.original_org;
  self.stunnedclip.angles = self.stunnedclip.original_ang;
}

body_clip_unresolved_collision(var_0) {
  var_1 = [];
  var_2 = var_0.origin - self.origin;
  var_2 = vectorNormalize((var_2[0], var_2[1], 0));
  var_3 = _func_2E1(var_0.origin + var_2 * 48);
  var_3 = _func_082(var_3, 40, 100, 50);
  var_4 = spawnStruct();
  var_4.origin = var_3;
  var_1[var_1.size] = var_4;
  self._id_A048 = var_1;
  var_5 = level.use_zombie_unresolved_collision;
  level.use_zombie_unresolved_collision = undefined;
  _id_0488::_id_A047(var_0, 0);
  level.use_zombie_unresolved_collision = var_5;
}

anim_state_geist_drain_cast_control() {
  var_0 = self;

  if(isDefined(var_0.current_drain._id_7DF9)) {
    return;
  }
  var_0 endon("geist_drain_result");
  var_1 = maps\mp\agents\_scripted_agent_anim_util::_id_434D("geist_drain_loop");
  var_2 = maps\mp\agents\_scripted_agent_anim_util::_id_7A35(var_1);
  var_0 maps\mp\agents\_scripted_agent_anim_util::_id_8415(var_1, var_2);
  var_0 waittill("forever");
}

anim_state_ground_recover_loop() {
  var_0 = self;
  var_0 thread anim_state_ground_recover_end_think();
  var_0 endon("geist_recover_result");
  var_1 = maps\mp\agents\_scripted_agent_anim_util::_id_434D("geist_drain_stumble_idle");
  var_2 = maps\mp\agents\_scripted_agent_anim_util::_id_7A35(var_1);
  var_0 maps\mp\agents\_scripted_agent_anim_util::_id_8415(var_1, var_2);
  var_0 waittill("forever");
}

anim_state_ground_recover_end_think() {
  var_0 = self;
  var_1 = 8;

  for(var_2 = 1; var_1 > 0; var_1 = var_1 - var_2)
    wait(var_2);

  var_0 notify("geist_recover_result");
}

geist_drain_cast_handle_notetracks(var_0, var_1, var_2, var_3) {
  var_4 = self;

  switch (var_0) {
    case "cast":
      if(isDefined(var_4.current_drain))
        var_4 thread king_spawn_geist_drain();

      break;
  }
}

king_geist_drain_report_result(var_0) {
  var_1 = self;
  var_1.current_drain._id_7DF9 = var_0;
  var_1 notify("geist_drain_result", var_0);
}

king_start_geist_drain_cast_fx() {
  var_0 = self;
  var_0.current_drain.fx_left_hand = _func_2A8(common_scripts\utility::_id_44F5("zmb_gk_geistdrain_hands"), var_0, "J_Wrist_LE");
  var_0.current_drain.fx_right_hand = _func_2A8(common_scripts\utility::_id_44F5("zmb_gk_geistdrain_hands"), var_0, "J_Wrist_RI");
  var_0 king_handle_attached_vfx_cleanup(var_0.current_drain.fx_left_hand);
  var_0 king_handle_attached_vfx_cleanup(var_0.current_drain.fx_right_hand);
  _func_14C(var_0.current_drain.fx_left_hand);
  _func_14C(var_0.current_drain.fx_right_hand);
  var_0.current_drain.fx_left_hand thread _id_0547::_id_2D20(var_0, "geist_drain_result");
  var_0.current_drain.fx_right_hand thread _id_0547::_id_2D20(var_0, "geist_drain_result");
}

king_spawn_geist_drain() {
  var_0 = self;
  var_0 endon("geist_drain_result");
  var_0 endon("geist_drain_end");
  var_1 = attack_geist_drain_spawn(var_0.origin, var_0);
  thread king_start_geist_drain_cast_fx();
  var_0 thread setup_geist_drain_pain();
  var_0.current_drain.geist_drain_struct = var_1;
  var_0 thread vo_play_gdk_ability_line("geist_drain");
  var_1 attack_geist_drain_wait_till_stopped();
}

anim_state_geist_drain_end() {}

setup_geist_drain_pain() {
  var_0 = self;
  var_0 endon("death");
  var_0.current_drain._id_4DE0 = 0;
  var_0 thread geist_drain_plate_destruction_wait();
  var_0 common_scripts\utility::_id_A70A("geist_drain_result", "geist_drain_end");
  var_0 cleanup_geist_drain_pain();
}

cleanup_geist_drain_pain() {
  var_0 = self;
}

geist_drain_plate_destruction_wait() {
  var_0 = self;
  var_0 endon("death");
  var_0 endon("geist_drain_result");

  for(var_1 = 0; var_1 < 3; var_1++)
    var_0 waittill("plate_destroyed");

  var_0 thread king_geist_drain_report_result("pain");
}

attack_geist_drain_spawn(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.origin = var_0;
  var_2._id_0117 = var_1;
  var_2._id_08BE = 1;
  var_1 thread geist_drain_aoe(var_2);
  return var_2;
}

geist_drain_aoe(var_0) {
  var_1 = self;
  var_0 endon("attack_geist_drain_stop");
  var_2 = 0.25;
  var_3 = 18;

  if(common_scripts\utility::_id_562E(var_1.issolomode))
    var_3 = 25;

  var_4 = 18 / var_2;
  var_5 = -1 / var_4;
  var_6 = "J_Wrist_LE";
  var_7 = "J_Wrist_RI";
  var_8 = "TAG_SWORD";
  _id_0378::_id_8D74("god_king_giestdrain", var_1, var_0);
  var_9 = [var_7, var_6, var_8];
  var_10 = _func_1AC(level.blood_plates, var_1.origin, 2400);

  foreach(var_12 in var_10) {
    if(_id_0547::_id_5565(var_12._id_8260, "plate_boss_room")) {
      var_9 = sort_tags_by_distance_2d(var_12.origin, var_1, var_9);
      var_13 = var_9[0];
      var_9 = common_scripts\utility::_id_0F93(var_9, var_13);
      var_12.loc_beam = _func_382("zmb_geistkraft_blood_beam_med_drain", var_12.plate_model, "TAG_ORIGIN", var_1, var_13);
      var_12.loc_beam thread _id_0547::_id_2D20(var_12, "plate_destroyed");
      var_12.loc_beam thread _id_0547::_id_2D20(var_12, "drain_ended");
      var_12 thread drain_plate_think(var_12.loc_beam, var_2, var_1);
    }
  }

  for(var_15 = 0; var_15 < var_4; var_15++) {
    var_16 = var_1 king_get_targets_in_range(512);

    if(isDefined(var_16)) {
      foreach(var_18 in var_16) {
        if(_func_211(var_1 gettagorigin(var_6), var_18.origin) > _func_211(var_1 gettagorigin(var_7), var_18.origin))
          var_13 = var_7;
        else
          var_13 = var_6;

        var_19 = _func_382("zmb_geistkraft_reg_beam_med", var_1, var_13, var_18, "J_Spine4");
        var_19 thread delete_time(int(var_2));

        if(isPlayer(var_18)) {
          if(isDefined(self.powerbuffamount) && self.powerbuffamount > 0) {
            var_18 _id_0533::_id_0F37(var_5, 1, 1);
            drain_heal_king(50000 / var_4);
          } else {
            var_20 = var_18.maxhealth / var_4;
            var_20 = int(var_20);
            var_18 _meth_8059(var_20, var_1.origin, var_1, var_1, "MOD_ENERGY");
            drain_heal_king(50000 / var_4);
          }

          continue;
        }

        var_20 = var_18.maxhealth / var_4;
        var_20 = int(var_20);
        var_18 _meth_8059(var_20, var_1.origin, var_1, var_1, "MOD_ENERGY");
        drain_heal_king(50000 / var_4);
      }
    }

    wait(var_2);
  }

  foreach(var_12 in level.blood_plates) {
    if(_id_0547::_id_5565(var_12._id_8260, "plate_boss_room"))
      var_12 notify("drain_ended");
  }

  drain_heal_king(100000);
  playFX(common_scripts\utility::_id_44F5("zmb_hilt_sphere_explosion"), var_1 gettagorigin(var_8), var_1 _meth_8181(var_8));
  var_1 thread king_geist_drain_report_result("complete");
  _id_0378::_id_8D74("aud_clear_mute_zvox_for_drain");
}

drain_heal_king(var_0) {
  var_1 = self;

  if(var_0 + var_1.health >= var_1.maxhealth)
    var_0 = var_1.maxhealth - var_1.health;

  if(common_scripts\utility::_id_562E(var_1.issolomode))
    var_0 = var_0 / 2;

  var_1.health = var_1.health + int(var_0);
}

drain_plate_think(var_0, var_1, var_2) {
  var_3 = self;
  var_3.fount_active = 1;
  var_3.drain_fx_ent = _func_2A8(common_scripts\utility::_id_44F5("zmb_desc_blood_plates_lt_drain"), var_3.plate_model, "TAG_ORIGIN");
  _func_14C(var_3.drain_fx_ent);
  var_3.plate_hit_clip _meth_82C1();
  var_3.plate_hit_clip _meth_82C3(1);
  var_3.plate_hit_clip _meth_849F(1);
  var_3.plate_hit_clip.total_damage = 0;
  var_3.plate_hit_clip.my_fount = var_3;
  var_3.plate_hit_clip.damagecallback = ::geist_drain_plate_damage;
  var_3 childthread drain_plate(var_0, var_1);
  var_3 drain_end_wait(var_2);
  var_3.drain_fx_ent delete();
  var_3.plate_hit_clip _meth_82C2();
  var_3.plate_hit_clip _meth_82C3(0);
  var_3.plate_hit_clip _meth_849F(0);
  var_3.plate_hit_clip.damagecallback = undefined;
  playFX(common_scripts\utility::_id_44F5("zmb_hilt_sphere_explosion"), var_3.plate_model.origin, anglesToForward(var_3.plate_model.angles));
  var_3.fount_active = 0;
}

drain_end_wait(var_0) {
  var_1 = self;
  var_0 endon("death");
  var_1 endon("drain_ended");
  var_1 waittill("plate_destroyed");
}

geist_drain_plate_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = self;

  if(isPlayer(var_1)) {
    var_13 = "weakpoint";
    var_1 thread _id_04C7::_id_A102(var_13);

    if(king_check_if_raven_weapons(var_5))
      var_2 = var_2 * 2.5;

    self.total_damage = self.total_damage + var_2;

    if(self.total_damage > get_plate_health()) {
      self.my_fount notify("plate_destroyed");

      if(isDefined(level.zombie_king)) {
        _id_0378::_id_8D74("god_king_giestdrain_plate_destroyed");
        level.zombie_king notify("plate_destroyed");
      }
    }
  }
}

get_plate_health() {
  var_0 = 4000;

  switch (level.players.size) {
    case 1:
      var_0 = 4000;
      break;
    case 2:
      var_0 = 6000;
      break;
    case 3:
      var_0 = 7000;
      break;
    case 4:
      var_0 = 8000;
      break;
    default:
      break;
  }

  return var_0;
}

drain_plate(var_0, var_1) {
  while(isDefined(var_0)) {
    maps\mp\mp_zombie_descent::blood_plate_subtract();
    wait(var_1);
  }
}

attack_geist_drain_spawn_interrupt_volume(var_0, var_1, var_2) {}

attack_geist_drain_stop() {
  var_0 = self;

  if(common_scripts\utility::_id_562E(var_0._id_08BE)) {
    var_0._id_08BE = 0;
    var_0 notify("attack_geist_drain_stop");
  }
}

attack_geist_drain_wait_till_stopped() {
  var_0 = self;

  if(common_scripts\utility::_id_562E(var_0._id_08BE))
    var_0 waittill("attack_geist_drain_stop");
}

uber_flame_wave_try() {
  var_0 = self;
  return 1;
}

uber_flame_wave_start() {
  var_0 = self;
  var_0.current_flame_wave = spawnStruct();
  var_1 = level.bossfight.throne_pos.origin;
  var_0 enable_geist_bullet_shield();
  var_0.current_flame_wave._id_2DA7 = king_create_destination(var_1);
}

uber_flame_wave_think() {
  var_0 = self;
  var_1 = 0;
  var_1 = king_has_arrived(var_0.current_flame_wave._id_2DA7);

  if(!var_1)
    king_continue_moving(var_0.current_flame_wave._id_2DA7);

  var_2 = var_0 king_is_in_or_waiting_for_scripted_state("flame_wave");

  if(var_1) {
    if(!common_scripts\utility::_id_562E(var_0.current_flame_wave.anim_state_completed)) {
      if(!var_2)
        var_0 thread _id_0547::_id_7D1A("flame_wave");
    } else
      return 1;
  }

  return 0;
}

uber_flame_wave_end() {
  var_0 = self;
  var_0 notify("flame_wave_end");
  var_0.current_flame_wave = undefined;
}

anim_state_flame_wave_run() {
  var_0 = self;
  var_0 endon("flame_wave_end");

  if(!isDefined(var_0.current_flame_wave)) {
    return;
  }
  var_0 pause_manual_move();
  var_0 start_manual_rotation();
  var_0 anim_state_flame_wave_cast_control();
  var_1 = var_0.current_flame_wave._id_7DF9;

  if(_id_0547::_id_5565(var_1, "complete")) {
    var_2 = maps\mp\agents\_scripted_agent_anim_util::_id_434D("flame_wave_end");
    var_3 = maps\mp\agents\_scripted_agent_anim_util::_id_7A35(var_2);
    maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_2, var_3, 1, "king_attack", "end");
  } else {
    var_0.current_flame_wave.flame_wave_struct attack_flame_wave_stop();
    var_2 = maps\mp\agents\_scripted_agent_anim_util::_id_434D("flame_wave_pain");
    var_3 = maps\mp\agents\_scripted_agent_anim_util::_id_7A35(var_2);
    maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_2, var_3, 1, "king_attack", "end");
  }

  var_0.current_flame_wave.anim_state_completed = 1;
}

anim_state_flame_wave_cast_control() {
  var_0 = self;
  var_0 endon("flame_wave_result");
  var_0 disable_geist_bullet_shield();
  var_1 = maps\mp\agents\_scripted_agent_anim_util::_id_434D("flame_wave_cast");
  var_2 = maps\mp\agents\_scripted_agent_anim_util::_id_7A35(var_1);
  var_0 notify("flame_wave_cast");
  maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_1, var_2, 1, "king_attack", "end", ::flame_wave_cast_handle_notetracks);
  var_1 = maps\mp\agents\_scripted_agent_anim_util::_id_434D("flame_wave_ctrl");
  var_2 = maps\mp\agents\_scripted_agent_anim_util::_id_7A35(var_1);
  var_0 maps\mp\agents\_scripted_agent_anim_util::_id_8415(var_1, var_2);
  var_0 waittill("forever");
}

flame_wave_cast_handle_notetracks(var_0, var_1, var_2, var_3) {
  var_4 = self;

  switch (var_0) {
    case "cast":
      if(isDefined(var_4.current_flame_wave))
        var_4 thread king_spawn_flame_wave();

      break;
  }
}

king_flame_wave_report_result(var_0) {
  var_1 = self;
  var_1.current_flame_wave._id_7DF9 = var_0;
  var_1 notify("flame_wave_result", var_0);
}

king_spawn_flame_wave() {
  var_0 = self;
  var_0 endon("flame_wave_result");
  var_0 endon("flame_wave_end");
  var_1 = attack_flame_wave_spawn(var_0.origin, var_0);
  var_0 thread setup_flame_wave_pain();
  var_0.current_flame_wave.flame_wave_struct = var_1;
  var_0 thread vo_play_gdk_ability_line("flame_wave");
  var_1 attack_flame_wave_wait_till_stopped();
  var_0 thread king_flame_wave_report_result("complete");
}

anim_state_flame_wave_end() {}

setup_flame_wave_pain() {
  var_0 = self;
  var_0 endon("death");
  var_0.current_flame_wave._id_4DE0 = 0;
  var_0 add_king_damage_finished_func("flame_wave_pain", ::flame_wave_on_damage_finished);
  var_0 common_scripts\utility::_id_A70A("flame_wave_result", "flame_wave_end");
  var_0 cleanup_flame_wave_pain();
}

cleanup_flame_wave_pain() {
  var_0 = self;
  var_0 remove_king_damage_finished_func("flame_wave_pain");
}

flame_wave_on_damage_finished(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = self;

  if(!isDefined(var_11.current_flame_wave)) {
    return;
  }
  if(isDefined(var_1) && isPlayer(var_1)) {
    if(!isDefined(var_11.current_flame_wave.flame_wave_struct)) {
      return;
    }
    var_12 = var_11.current_flame_wave.flame_wave_struct.last_kill_radius;

    if(isDefined(var_12) && _func_0E1(var_1.origin, var_11.origin) < var_12) {
      var_11.current_flame_wave._id_4DE0++;

      if(var_11.current_flame_wave._id_4DE0 > 0)
        var_11 thread king_flame_wave_report_result("pain");
    }
  }
}

attack_flame_wave_spawn(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.origin = var_0;
  var_3._id_0117 = var_1;
  var_3.istrial = var_2;

  if(!isDefined(level.next_flame_wave_id))
    level.next_flame_wave_id = 0;
  else
    level.next_flame_wave_id++;

  var_3.flame_id = level.next_flame_wave_id;
  var_3 thread attack_flame_wave_run();
  var_4 = "flame_wave_end_" + var_3.flame_id;
  thread maps\mp\_utility::_id_6F74(::flame_wave_sound_runner, var_3, var_4);
  return var_3;
}

flame_wave_sound_runner(var_0) {
  var_1 = self;
  var_2 = spawn("script_model", self.origin);
  var_2 setModel("tag_origin");
  var_2 _meth_805C();
  var_2 _meth_8005(var_1);
  _id_0378::_id_8D74("flame_wave_runner_start", var_2, var_1);
  flame_wave_sound_runner_run(var_0, var_2);
  _id_0378::_id_8D74("flame_wave_runner_stop", var_2, var_1);
  wait 1.0;
  var_2 delete();
}

flame_wave_sound_runner_run(var_0, var_1) {
  var_2 = self;
  var_2 endon("disconnect");
  var_0 endon("attack_flame_wave_stop");

  if(!common_scripts\utility::_id_562E(var_0._id_08BE)) {
    return;
  }
  var_3 = 40.0;
  var_4 = 0;

  for(;;) {
    var_5 = (var_2.origin - var_0.origin) * (1, 1, 0);
    var_6 = length(var_5);
    var_7 = var_6 < var_0.last_kill_radius;

    if(var_7 != var_4) {
      if(var_7)
        _id_0378::_id_8D74("flame_wave_runner_inside", var_1, var_2);
      else
        _id_0378::_id_8D74("flame_wave_runner_outside", var_1, var_2);
    }

    var_4 = var_7;
    var_8 = var_5 / var_6;
    var_9 = var_0.origin + var_8 * var_0.last_kill_radius;
    var_9 = (var_9[0], var_9[1], var_2.origin[2]);
    var_10 = var_0.origin + var_8 * (var_0.last_kill_radius + var_3);
    var_10 = (var_10[0], var_10[1], var_2.origin[2]);
    var_1.origin = var_9;
    var_1 _meth_82B1(var_10, 0.2);
    wait 0.2;
  }
}

attack_flame_wave_run() {
  var_0 = self;
  var_0._id_08BE = 1;
  var_1 = _func_0A5(0, 360);
  var_2 = anglesToForward((0, var_1, 0));

  if(_id_0547::_id_5565(var_0.istrial, 1))
    var_0.fx = _func_14B(common_scripts\utility::_id_44F5("zmb_desc_flame_wave_02"), var_0.origin, (0, 1, 0), (0, 0, 1));
  else
    var_0.fx = _func_14B(common_scripts\utility::_id_44F5("zmb_desc_flame_wave"), var_0.origin, var_2, (0, 0, 1));

  setfxkillondelete(var_0.fx, 1);
  _func_14C(var_0.fx);
  var_0 endon("attack_flame_wave_stop");
  var_0 childthread attack_flame_wave_handle_max_timeout();
  var_0 childthread attack_flame_wave_damage();
}

attack_flame_wave_handle_max_timeout() {
  var_0 = self;
  wait 10;
  var_0 thread attack_flame_wave_stop();
}

attack_flame_wave_damage() {
  var_0 = self;
  var_1 = 0;
  var_2 = 0;
  var_3 = 40.0;
  var_0.last_kill_radius = 0;
  wait 0.4;

  for(;;) {
    var_4 = var_2;
    var_1 = var_1 + var_3;
    var_2 = max(var_1 - 72, 0);
    var_0.last_kill_radius = var_1;
    var_5 = common_scripts\utility::_id_0F73(level.players, _id_0547::_id_408F());
    var_5 = common_scripts\utility::_id_0F73(var_5, maps\mp\mp_zombie_descent_ee_main::get_unbroken_ice_blocks());

    foreach(var_7 in var_5) {
      if(isDefined(var_7.flame_waves_hit_by) && isDefined(var_7.flame_waves_hit_by[var_0.flame_id])) {
        continue;
      }
      if(_id_0547::_id_5565(var_0._id_0117, var_7)) {
        continue;
      }
      [var_9, var_10] = approximate_script_hit_cylinder(var_7);
      var_11 = 0.5 * var_10;
      var_12 = _func_0AE(var_7.origin[2] + var_11 - var_0.origin[2]);

      if(var_12 > var_11 + 600) {
        continue;
      }
      var_13 = _func_0E1(var_7.origin, var_0.origin);

      if(var_13 > var_1 + var_9 || var_13 < var_4 - var_9) {
        continue;
      }
      var_7.flame_waves_hit_by[var_0.flame_id] = 1;
      var_0 thread target_hit_by_flame_wave(var_7);
    }

    wait 0.2;
  }
}

target_hit_by_flame_wave(var_0) {
  wait 0;
  var_1 = self;

  if(common_scripts\utility::_id_562E(var_0.is_ice_block)) {
    var_2 = 200.0;
    var_3 = var_0._id_8303 / var_2;
    var_1 endon("attack_flame_wave_stop");
    wait(var_3);
    var_0 maps\mp\mp_zombie_descent_ee_main::ice_block_break();
  } else if(isPlayer(var_0) && !_id_0547::_id_577E(var_0)) {
    var_0 _id_0547::_id_7454(0);
    var_0 _meth_8059(var_0.health + 666, var_1.origin, var_1._id_0117, undefined, "MOD_BURNED", "zombie_king_uber_flame");
  } else
    var_0 _meth_8059(var_0.health + 666, var_0.origin, var_0, var_0, "MOD_BURNED", "zombie_king_uber_flame");
}

approximate_script_hit_cylinder(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  if(isDefined(var_0._id_8302))
    var_1 = var_0._id_8302;
  else if(isDefined(var_0._id_00BD))
    var_1 = var_0._id_00BD;
  else
    var_1 = 65;

  if(isDefined(var_0._id_8303))
    var_2 = var_0._id_8303;
  else if(isDefined(var_0.radius))
    var_2 = var_0.radius;
  else
    var_2 = 65;

  return [var_2, var_1];
}

attack_flame_wave_spawn_interrupt_volume(var_0, var_1, var_2) {}

attack_flame_wave_stop() {
  var_0 = self;

  if(common_scripts\utility::_id_562E(var_0._id_08BE)) {
    var_0._id_08BE = 0;
    var_0.fx delete();
    var_0 notify("attack_flame_wave_stop");
    level notify("flame_wave_end_" + var_0.flame_id);
  }
}

attack_flame_wave_wait_till_stopped() {
  var_0 = self;

  if(common_scripts\utility::_id_562E(var_0._id_08BE))
    var_0 waittill("attack_flame_wave_stop");
}

uber_force_try() {
  var_0 = self;
  return 1;
}

uber_force_start() {
  var_0 = self;
  var_0.current_force = spawnStruct();
  var_1 = get_random_boss_position();
  var_0 enable_geist_bullet_shield();
  var_0.current_force._id_2DA7 = king_create_destination(var_1);
}

uber_force_think() {
  var_0 = self;
  var_1 = 0;
  var_1 = king_has_arrived(var_0.current_force._id_2DA7);

  if(!var_1)
    king_continue_moving(var_0.current_force._id_2DA7);

  var_2 = var_0 king_is_in_or_waiting_for_scripted_state("force");

  if(var_1) {
    if(!common_scripts\utility::_id_562E(var_0.current_force.anim_state_completed)) {
      if(!var_2)
        var_0 thread _id_0547::_id_7D1A("force");
    } else
      return 1;
  }

  return 0;
}

uber_force_end() {
  var_0 = self;
  var_0 notify("force_end");
  var_0.current_force = undefined;
}

anim_state_force_run() {
  var_0 = self;
  var_0 endon("force_end");

  if(!isDefined(var_0.current_force)) {
    return;
  }
  var_0 pause_manual_move();
  var_0 start_manual_rotation();
  var_0 disable_geist_bullet_shield();
  var_1 = maps\mp\agents\_scripted_agent_anim_util::_id_434D("overwhelm_force");
  var_2 = maps\mp\agents\_scripted_agent_anim_util::_id_7A35(var_1);
  var_0 thread force_attack_run();
  var_0 thread vo_play_gdk_ability_line("overwhelm_force");
  maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_1, var_2, 1, "king_attack", "end", ::force_handle_notetracks);
  var_0.current_force.anim_state_completed = 1;
}

force_handle_notetracks(var_0, var_1, var_2, var_3) {
  switch (var_0) {
    case "unleash_force":
      self notify("notify_force_unleash");
      break;
  }
}

force_attack_run() {
  var_0 = "TAG_WEAPON_RIGHT";

  if(!_id_0547::_id_5565(level.zombie_king, self))
    var_0 = "TAG_ORIGIN";

  _id_0378::_id_8D74("god_king_force_summon");
  self waittill("notify_force_unleash");
  thread force_apply_shield();
}

force_apply_shield(var_0) {
  var_1 = _id_0547::_id_408F();

  foreach(var_3 in var_1) {
    if(var_3 == self || isDefined(var_0) && !var_3 istouching(var_0)) {
      continue;
    }
    var_3 thread enable_force_shield();
  }
}

enable_force_shield() {
  if(_id_0547::_id_5565(self.isforceshieldactive, 1)) {
    return;
  }
  self.isforceshieldactive = 1;
  self._id_480F = 1;
  self.nomutilate = 1;
  var_0 = _func_2A8(common_scripts\utility::_id_44F5("force_zombie_bubble"), self, "J_SpineLower");
  maps\mp\agents\_agent_utility::deleteentonagentdeath(var_0);
  _func_14C(var_0);
  self.myforceshield = var_0;
}

break_force_shield() {
  if(isDefined(self.myforceshield))
    self.myforceshield delete();

  self.isforceshieldactive = 0;
  _func_147(common_scripts\utility::_id_44F5("force_zombie_bubble_pop"), self, "J_SpineLower");
  self.nomutilate = 0;
  self._id_480F = 0;
}

uber_sun_try() {
  var_0 = self;
  return 1;
}

uber_sun_start() {
  var_0 = self;
  var_0.current_sun = spawnStruct();
  var_1 = get_random_boss_sun_position();
  var_0 enable_geist_bullet_shield();
  var_0.current_sun._id_2DA7 = king_create_destination(var_1);
}

uber_sun_think() {
  var_0 = self;
  var_1 = 0;
  var_1 = king_has_arrived(var_0.current_sun._id_2DA7);

  if(!var_1)
    king_continue_moving(var_0.current_sun._id_2DA7);

  var_2 = var_0 king_is_in_or_waiting_for_scripted_state("sun");

  if(var_1) {
    if(!common_scripts\utility::_id_562E(var_0.current_sun.anim_state_completed)) {
      if(!var_2)
        var_0 thread _id_0547::_id_7D1A("sun");
    } else
      return 1;
  }

  return 0;
}

uber_sun_end() {
  var_0 = self;
  var_0 notify("sun_end");
  var_0.current_sun = undefined;
}

anim_state_sun_run() {
  var_0 = self;
  var_0 endon("sun_end");

  if(!isDefined(var_0.current_sun)) {
    return;
  }
  var_0 pause_manual_move();
  var_0 start_manual_rotation();
  var_0 disable_geist_bullet_shield();
  var_1 = maps\mp\agents\_scripted_agent_anim_util::_id_434D("light_of_the_sun");
  var_2 = maps\mp\agents\_scripted_agent_anim_util::_id_7A35(var_1);
  var_0 thread sun_attack_run();
  var_0 thread vo_play_gdk_ability_line("light_of_the_sun");
  maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_1, var_2, 1, "king_attack", "end", ::sun_handle_notetracks);
  var_0.current_sun.anim_state_completed = 1;
}

sun_handle_notetracks(var_0, var_1, var_2, var_3) {
  switch (var_0) {
    case "light_begin":
      self notify("notify_sun_kill");
      break;
  }
}

sun_attack_run() {
  var_0 = "TAG_WEAPON_CHEST";

  if(!_id_0547::_id_5565(level.zombie_king, self))
    var_0 = "TAG_ORIGIN";

  self.fx_sun_tell = _func_2A8(common_scripts\utility::_id_44F5("zmb_gk_lightsun_buildup"), self, var_0);
  king_handle_attached_vfx_cleanup(self.fx_sun_tell);
  _func_14C(self.fx_sun_tell);
  self.fx_sun_tell _id_0378::_id_8D74("god_king_sun_cast");
  wait 0.15;
  thread sun_do_preface_damage(var_0);
  self waittill("notify_sun_kill");
  self.fx_sun_tell delete();
  self.fx_sun_tell = undefined;
  _func_147(common_scripts\utility::_id_44F5("zmb_gk_lightsun_blast"), self, var_0);
  _id_0378::_id_8D74("god_king_sun_blast");
  thread praise_the_sun(var_0);
}

sun_do_preface_damage(var_0) {
  self endon("notify_sun_kill");

  for(;;) {
    var_1 = _id_0547::_id_408F();
    var_2 = common_scripts\utility::_id_0F73(var_1, level.players);

    foreach(var_4 in var_2) {
      if(var_4 == self || _id_0547::_id_5565(level.zombie_king, var_4)) {
        continue;
      }
      if(_func_07E(self gettagorigin(var_0), var_4 getEye(), 0, self))
        var_4 _meth_8059(5, self.origin, self, self, "MOD_ENERGY", "zombie_king_uber_sun");
    }

    wait 0.4;
  }
}

praise_the_sun(var_0) {
  var_1 = self;
  var_2 = _id_0547::_id_408F();
  var_3 = common_scripts\utility::_id_0F73(var_2, level.players);

  foreach(var_5 in var_3) {
    if(var_5 == self || _id_0547::_id_5565(level.zombie_king, var_5)) {
      continue;
    }
    if(_func_07E(self gettagorigin(var_0), var_5 getEye(), 0, self)) {
      var_5 _meth_8059(var_5.health + 666, self.origin, self, self, "MOD_ENERGY", "zombie_king_uber_sun");
      _id_0378::_id_8D74("god_king_sun_blast_hit_plr", var_5);
    }
  }
}

special_geist_drain_special_try() {
  var_0 = self;
  return 1;
}

special_geist_drain_special_start() {
  var_0 = self;
  var_0.current_drain_special = spawnStruct();
  var_1 = level.bossfight.throne_pos;
  var_0 enable_geist_bullet_shield();
  var_0.current_drain_special._id_2DA7 = king_create_destination(var_1);
  var_2 = level.bossfight.throne_pos.angles[1];
  var_0.current_drain_special.rotation_target = create_rotation_target_yaw(var_2);
  var_0 set_rotation_target(var_0.current_drain_special.rotation_target);
}

special_geist_drain_special_think() {
  var_0 = self;
  var_1 = var_0 king_is_in_or_waiting_for_scripted_state("geist_drain_special");

  if(!common_scripts\utility::_id_562E(var_0.current_drain_special.anim_state_completed)) {
    if(!var_1)
      var_0 thread _id_0547::_id_7D1A("geist_drain_special");
  } else
    return 0;

  return 0;
}

special_geist_drain_special_end() {
  var_0 = self;
  var_0 notify("geist_drain_special_end");
  var_0.current_drain_special = undefined;
}

anim_state_geist_drain_special_run() {
  var_0 = self;
  var_0 endon("geist_drain_special_end");

  if(!isDefined(var_0.current_drain_special)) {
    return;
  }
  var_0 pause_manual_move();
  var_0 pause_manual_rotation();
  var_0 disable_geist_bullet_shield();
  var_0 thread king_spawn_geist_drain_special();
  var_0 thread end_taunt_loop();
  var_0 anim_state_geist_drain_special_cast_control();
  var_1 = var_0.current_drain_special._id_7DF9;

  if(_id_0547::_id_5565(var_1, "complete")) {
    var_2 = maps\mp\agents\_scripted_agent_anim_util::_id_434D("death_fail");
    var_3 = maps\mp\agents\_scripted_agent_anim_util::_id_7A35(var_2);
    var_0 _id_0378::_id_8D74("god_king_finale_melee");
    var_0 thread vo_play_gdk_ability_line("end_fail");
    maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_2, var_3, 1, "king_attack", "end");
    var_0.king_seated = 0;

    foreach(var_5 in level.players) {
      var_6 = _func_382("zmb_geistkraft_blood_beam_med_drain", var_5, "J_Spine4", var_0, "TAG_SWORD");
      var_6 thread delete_time(2);
      var_5 thread king_zombie_wins(var_0);
    }

    var_0 _id_0378::_id_8D74("god_king_finale_drain_end");
  } else {
    var_0.current_drain_special.geist_drain_special_struct attack_geist_drain_special_stop();
    var_0 notify("fatal_blow");
    var_2 = maps\mp\agents\_scripted_agent_anim_util::_id_434D("death_finale");
    var_3 = maps\mp\agents\_scripted_agent_anim_util::_id_7A35(var_2);
    var_0 _id_0378::_id_8D74("god_king_death");
    maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_2, var_3, 1, "king_attack", "end");

    if(isDefined(level.zombie_king_sword.hitbox))
      level.zombie_king_sword.hitbox delete();

    if(isDefined(level.zombie_king_sword)) {
      playFX(level._effect["zmb_desc_boss_death_sword_hide"], level.zombie_king_sword.origin, anglesToForward(level.zombie_king_sword.angles));
      level.zombie_king_sword delete();
    }

    var_0 _id_0378::_id_8D74("god_king_finale_drain_end");
    var_0 thread zombie_king_play_dead();
  }

  var_0.current_drain_special.anim_state_completed = 1;
}

end_taunt_loop() {
  self endon("death");
  self endon("fatal_blow");
  thread vo_play_gdk_ability_line("end_taunt");
  wait 6;
  thread vo_play_gdk_ability_line("end_taunt");
  wait 3;
  thread vo_play_gdk_ability_line("end_taunt");
}

anim_state_geist_drain_special_cast_control() {
  var_0 = self;

  if(isDefined(var_0.current_drain_special._id_7DF9)) {
    return;
  }
  var_0 endon("geist_drain_special_result");
  var_1 = undefined;

  for(;;) {
    var_2 = maps\mp\agents\_scripted_agent_anim_util::_id_434D("death_sit");
    var_3 = maps\mp\agents\_scripted_agent_anim_util::_id_7A35(var_2);
    var_0 maps\mp\agents\_scripted_agent_anim_util::_id_8415(var_2, var_3);
    var_0 waittill("finale_minor_pain", var_4);

    if(isDefined(var_4)) {
      var_2 = maps\mp\agents\_scripted_agent_anim_util::_id_434D(var_4);
      var_3 = maps\mp\agents\_scripted_agent_anim_util::_id_7A35(var_2);
      var_0 maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_2, var_3, 1, "king_death", "end");
    }
  }
}

king_geist_drain_special_report_result(var_0) {
  var_1 = self;
  var_1.current_drain_special._id_7DF9 = var_0;
  var_1 notify("geist_drain_special_result", var_0);
}

king_spawn_geist_drain_special() {
  var_0 = self;
  var_0 endon("geist_drain_special_result");
  var_0 endon("geist_drain_special_end");
  var_1 = attack_geist_drain_special_spawn(var_0.origin, var_0);
  var_0 thread setup_geist_drain_special_pain();
  var_0.current_drain_special.geist_drain_special_struct = var_1;
  var_1 attack_geist_drain_special_wait_till_stopped();
  var_0 thread king_geist_drain_special_report_result("complete");
}

anim_state_geist_drain_special_end() {}

setup_geist_drain_special_pain() {
  var_0 = self;
  var_0 endon("death");
  var_0.current_drain_special.damage_taken = 0;
  var_0 add_king_damage_finished_func("geist_drain_special_pain", ::geist_drain_special_on_damage_finished);
  var_0 common_scripts\utility::_id_A70A("geist_drain_special_result", "geist_drain_special_end");
  var_0 cleanup_geist_drain_special_pain();
}

cleanup_geist_drain_special_pain() {
  var_0 = self;
  var_0 remove_king_damage_finished_func("geist_drain_special_pain");
}

geist_drain_special_on_damage_finished(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = self;

  if(!isDefined(var_11.current_drain_special)) {
    return;
  }
  if(isDefined(var_5) && isDefined(var_4)) {
    if(king_check_if_weapon_op(var_5, var_4) && var_2 > 1)
      var_2 = int(var_2 * 0.6);
  }

  if(isDefined(var_5) && isDefined(var_4)) {
    if(king_check_if_raven_weapons(var_5, var_4) && var_2 > 1)
      var_2 = int(var_2 * 2.5);
  }

  var_11.current_drain_special.damage_taken = var_11.current_drain_special.damage_taken + var_2;
  var_12 = 100000 * level.player.size;

  if(var_11.current_drain_special.damage_taken > var_12)
    var_11 thread king_geist_drain_special_report_result("pain");
  else {
    var_13 = var_11.current_drain_special.last_finale_minor_pain;

    if(!isDefined(var_13) || gettime() > var_13 + 1300.0) {
      var_14 = "death_sit_pain_head";

      if(isDefined(var_8) && var_8 != "head" && isDefined(var_7)) {
        var_15 = anglestoright(var_11.puck.angles);

        if(vectordot(var_15, var_7) > 0)
          var_14 = "death_sit_pain_r";
        else
          var_14 = "death_sit_pain_l";
      }

      var_11.current_drain_special.last_finale_minor_pain = gettime();
      var_11 notify("finale_minor_pain", var_14);
    }
  }
}

king_check_if_weapon_sap(var_0, var_1) {
  var_2 = 0;

  if(issubstr(var_0, "p38_") && issubstr(var_0, "_pap_zm"))
    var_2 = 1;

  if(issubstr(var_0, "sdk_") && issubstr(var_0, "_pap_zm"))
    var_2 = 1;

  return var_2;
}

king_check_if_weapon_op(var_0, var_1) {
  var_2 = 0;

  if(!isDefined(var_0))
    return 0;

  if(issubstr(var_0, "svt40_") && issubstr(var_0, "_pap_zm"))
    var_2 = 1;

  if(issubstr(var_0, "raven_gun_") && issubstr(var_0, "_pap_zm"))
    var_2 = 1;

  if(_id_0547::_id_5565(var_1, "MOD_EXPLOSIVE") || _id_0547::_id_5565(var_1, "MOD_EXPLOSIVE_BULLET"))
    var_2 = 1;

  return var_2;
}

king_check_if_raven_weapons(var_0, var_1) {
  var_2 = 0;

  if(!isDefined(var_0))
    return 0;

  if(issubstr(var_0, level.ravenweaponmanager["shield"]._id_01D0) || issubstr(var_0, level.ravenweaponmanager["shield_emp"]._id_01D0) || issubstr(var_0, level.ravenweaponmanager["scythe"]._id_01D0) || issubstr(var_0, level.ravenweaponmanager["scythe_emp"]._id_01D0) || issubstr(var_0, level.ravenweaponmanager["spike"]._id_01D0) || issubstr(var_0, level.ravenweaponmanager["spike_emp"]._id_01D0) || issubstr(var_0, level.ravenweaponmanager["hammer"]._id_01D0) || issubstr(var_0, level.ravenweaponmanager["hammer_emp"]._id_01D0))
    var_2 = 1;

  return var_2;
}

king_check_if_raven_weapon_cleave(var_0, var_1) {
  var_2 = 0;

  if(!isDefined(var_0))
    return 0;

  if(issubstr(var_0, "hammer_cleave_zm") || issubstr(var_0, "hammer_cleave_emp_zm") || issubstr(var_0, "scythe_cleave_zm") || issubstr(var_0, "scythe_cleave_emp_zm") || issubstr(var_0, "scythe_shard_zm") || issubstr(var_0, "shield_cleave_zm") || issubstr(var_0, "shield_cleave_emp_zm") || issubstr(var_0, "zom_hammer_grenade_zm"))
    var_2 = 1;

  return var_2;
}

attack_geist_drain_special_spawn(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.origin = var_0;
  var_2._id_0117 = var_1;
  var_2._id_08BE = 1;
  var_1 thread geist_drain_special_aoe(var_2);
  return var_2;
}

geist_drain_special_aoe(var_0) {
  var_1 = self;
  var_0 endon("attack_geist_drain_special_stop");
  var_2 = 0.25;
  var_3 = 16 / var_2;
  var_4 = "J_Wrist_LE";
  var_5 = "J_Wrist_RI";

  for(var_6 = 0; var_6 < var_3; var_6++) {
    var_7 = var_1 king_get_targets_in_range(2200);

    if(isDefined(var_7))
      var_8 = common_scripts\utility::_id_0F73(level.players, var_7);
    else
      var_8 = level.players;

    if(!isDefined(var_8)) {
      wait(var_2);
      continue;
    }

    foreach(var_10 in var_8) {
      if(_func_211(var_1 gettagorigin(var_4), var_10.origin) > _func_211(var_1 gettagorigin(var_5), var_10.origin))
        var_11 = var_5;
      else
        var_11 = var_4;

      var_12 = _func_382("zmb_geistkraft_blood_beam_med_drain", var_1, var_11, var_10, "J_Spine4");
      var_12 thread delete_time(int(var_2));
      var_13 = var_10.health + 1;

      if(isPlayer(var_10))
        var_13 = 1;

      var_10 _meth_8059(var_13, var_1.origin, var_1, var_1, "MOD_ENERGY");
      var_1.health = var_1.health + 1;
    }

    wait(var_2);
  }

  var_0 attack_geist_drain_special_stop();
}

attack_geist_drain_special_spawn_interrupt_volume(var_0, var_1, var_2) {}

attack_geist_drain_special_stop() {
  var_0 = self;

  if(common_scripts\utility::_id_562E(var_0._id_08BE)) {
    var_0._id_08BE = 0;
    var_0 notify("attack_geist_drain_special_stop");
  }
}

attack_geist_drain_special_wait_till_stopped() {
  var_0 = self;

  if(common_scripts\utility::_id_562E(var_0._id_08BE))
    var_0 waittill("attack_geist_drain_special_stop");
}

king_zombie_wins(var_0) {
  var_1 = self;
  var_1 maps\mp\zombies\_zombies_blood_tubes::enable_blood_vision();

  while(var_1.health > 0) {
    var_1 _meth_8059(5, var_0.origin, var_0, var_0, "MOD_CRUSH");
    waitframe();
    var_1 _meth_8059(5, var_0.origin, var_0, var_0, "MOD_CRUSH");
    waitframe();
    var_1 _meth_8059(5, var_0.origin, var_0, var_0, "MOD_CRUSH");
    waitframe();
    var_1 suicide();
    waitframe();
  }
}

special_geist_drain_special_fake_try() {
  var_0 = self;
  return 1;
}

special_geist_drain_special_fake_start() {
  var_0 = self;
  var_0.current_drain_special_fake = spawnStruct();
  var_1 = var_0.origin;
  var_0 enable_geist_bullet_shield();
  var_0.current_drain_special_fake._id_2DA7 = king_create_destination(var_1);
}

special_geist_drain_special_fake_think() {
  var_0 = self;
  var_1 = var_0 king_is_in_or_waiting_for_scripted_state("geist_drain_special_fake");

  if(!common_scripts\utility::_id_562E(var_0.current_drain_special_fake.anim_state_completed)) {
    if(!var_1)
      var_0 thread _id_0547::_id_7D1A("geist_drain_special_fake");
  } else
    return 1;

  return 0;
}

special_geist_drain_special_fake_end() {
  var_0 = self;
  var_0 notify("geist_drain_special_fake_end");
  var_0.current_drain_special_fake = undefined;
}

anim_state_geist_drain_special_fake_run() {
  var_0 = self;
  var_0 endon("geist_drain_special_fake_end");

  if(!isDefined(var_0.current_drain_special_fake)) {
    return;
  }
  var_0 pause_manual_move();
  var_0 pause_manual_rotation();
  var_0 thread king_spawn_geist_drain_special_fake();
  var_0 anim_state_geist_drain_special_fake_cast_control();
  var_1 = var_0.current_drain_special_fake._id_7DF9;
  var_0.current_drain_special_fake.anim_state_completed = 1;
}

anim_state_geist_drain_special_fake_cast_control() {
  var_0 = self;

  if(isDefined(var_0.current_drain_special_fake._id_7DF9)) {
    return;
  }
  var_0 endon("geist_drain_special_fake_result");
  var_1 = maps\mp\agents\_scripted_agent_anim_util::_id_434D("death_sit");
  var_2 = maps\mp\agents\_scripted_agent_anim_util::_id_7A35(var_1);
  var_0 maps\mp\agents\_scripted_agent_anim_util::_id_8415(var_1, var_2);
  var_0 waittill("forever");
}

king_geist_drain_special_fake_report_result(var_0) {
  var_1 = self;
  var_1.current_drain_special_fake._id_7DF9 = var_0;
  var_1 notify("geist_drain_special_fake_result", var_0);
}

king_spawn_geist_drain_special_fake() {
  var_0 = self;
  var_0 endon("geist_drain_special_fake_result");
  var_0 endon("geist_drain_special_fake_end");
  var_0 _id_0378::_id_8D74("god_king_finale_drain_first");
  var_0 thread vo_play_gdk_ability_line("geist_drain");
  var_1 = "J_Wrist_LE";
  var_2 = "J_Wrist_RI";

  foreach(var_4 in level.players) {
    if(_func_211(var_0 gettagorigin(var_1), var_4.origin) > _func_211(var_0 gettagorigin(var_2), var_4.origin))
      var_5 = var_2;
    else
      var_5 = var_1;

    var_4.drain_beam = _func_382("zmb_geistkraft_blood_beam_med_drain", var_0, var_5, var_4, "J_Head");
    var_4.drain_beam thread delete_on_parent_notify(var_4, "kill_fake_drain_beam");
    var_4 notify("drain_fake_start");
  }

  var_0 attack_geist_drain_special_fake_wait_till_stopped();
  var_0 thread king_geist_drain_special_fake_report_result("complete");
}

anim_state_geist_drain_special_fake_end() {}

attack_geist_drain_special_fake_wait_till_stopped() {
  var_0 = self;
  var_0 common_scripts\utility::_id_A70A("attack_geist_drain_special_fake_stop", "transition_scene_done");
}

special_melee_try() {
  var_0 = self;
  var_1 = king_get_targets_in_range(280);

  if(isDefined(var_1)) {
    var_0.current_melee = spawnStruct();
    var_0.current_melee.melee_targets = var_1;
    var_0.current_melee._id_9297 = gettime();
    return 1;
  }

  return 0;
}

special_melee_start() {
  var_0 = self;
  [var_2, var_3] = special_melee_pick_best_attack_and_yaw(var_0.current_melee.melee_targets);

  if(!isDefined(var_2) || !isDefined(var_3)) {
    return;
  }
  var_0.current_melee.rotation_target = create_rotation_target_yaw(var_3, 360);
  var_0 set_rotation_target(var_0.current_melee.rotation_target);
  var_0.current_melee.melee_struct = level.king_melee_attacks[var_2];
  var_0 thread _id_0547::_id_7D1A("king_melee");
}

special_melee_pick_best_attack_and_yaw(var_0) {
  var_1 = self;
  var_2 = undefined;
  var_3 = 0;
  var_4 = undefined;
  var_5 = undefined;

  foreach(var_7 in var_0) {
    var_8 = _func_109(var_7.origin - var_1.origin);
    var_7.king_melee_aiming_yaw = _func_0DD(var_8 - var_1.angles[1]);
  }

  foreach(var_15, var_11 in level.king_melee_attacks) {
    var_12 = 0;

    foreach(var_7 in var_0) {
      if(_func_0AE(var_7.king_melee_aiming_yaw - var_11.arc_rotation_offset) < var_11._id_0F3E * 0.5 + var_11.facing_rotation_allowed)
        var_12++;
    }

    if(var_12 > var_3) {
      var_4 = 0;
      var_3 = var_12;
      var_2 = var_15;
    }
  }

  if(isDefined(var_4))
    var_5 = _func_0DD(var_4 + var_1.puck.angles[1]);

  return [var_2, var_5];
}

special_melee_think() {
  var_0 = self;
  var_0 disable_geist_bullet_shield();
  var_1 = var_0 king_is_in_or_waiting_for_scripted_state("king_melee");

  if(!var_1 || common_scripts\utility::_id_562E(var_0.current_melee.anim_state_completed))
    return 1;

  return 0;
}

special_melee_end() {
  var_0 = self;
  var_0 notify("special_melee_end");
  var_0.current_melee = undefined;
}

anim_state_melee_run() {
  var_0 = self;
  var_0 endon("special_melee_end");

  if(!isDefined(var_0.current_melee)) {
    return;
  }
  var_1 = var_0.current_melee.melee_struct.anim_action;
  var_0 _id_0378::_id_8D74("god_king_melee");
  var_2 = maps\mp\agents\_scripted_agent_anim_util::_id_434D(var_1);
  var_3 = maps\mp\agents\_scripted_agent_anim_util::_id_7A35(var_2);
  maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_2, var_3, 1, "king_attack", "end", ::melee_handle_notetracks);
  var_0.current_melee.anim_state_completed = 1;
}

anim_state_melee_end() {
  var_0 = self;
  var_0 pause_manual_rotation();
  var_0 pause_manual_move();
}

melee_handle_notetracks(var_0, var_1, var_2, var_3) {
  var_4 = self;

  switch (var_0) {
    case "strike":
      var_4 melee_strike_notetrack();
    case "stop_rotation":
      var_4 pause_manual_rotation();
      break;
  }
}

melee_strike_notetrack() {
  var_0 = self;
  var_1 = var_0.current_melee.melee_struct;
  var_2 = var_0 gettagorigin("J_MainRoot");
  var_3 = king_get_all_targets();
  var_4 = _func_0DD(var_0.puck.angles[1] + var_1.arc_rotation_offset);
  var_5 = anglesToForward((0, var_4, 0));
  var_6 = _func_0A7(var_1._id_0F3E / 2);
  var_14 = [];

  foreach(var_16 in var_3) {
    [var_18, var_19] = approximate_script_hit_cylinder(var_16);
    var_7 = var_19 * 0.5;
    var_20 = var_16.origin + (0, 0, var_7);

    if(_func_0AE(var_2[2] - var_20[2]) > var_7 + 280) {
      continue;
    }
    if(_func_0E1(var_16.origin, var_2) > 280 + var_18) {
      continue;
    }
    var_21 = vectorNormalize((var_16.origin - var_2) * (1, 1, 0));

    if(vectordot(var_21, var_5) <= var_6) {
      continue;
    }
    var_14[var_14.size] = var_16;
  }

  foreach(var_16 in var_14)
  var_0 thread zombie_king_on_melee_hit_target(var_16);
}

zombie_king_on_melee_hit_target(var_0) {
  var_1 = self;

  if(isPlayer(var_0)) {
    var_0 _meth_8059(80, var_1.origin, var_1, var_1, "MOD_MELEE");
    var_0 thread run_melee_shellshock(var_1.origin);
  } else
    var_0 _meth_8059(var_0.health + 666, var_1.origin, var_1, var_1, "MOD_MELEE");
}

run_melee_shellshock(var_0) {
  var_1 = 2;
  var_2 = 2;
  var_3 = 300;
  self endon("death");
  self _meth_8182("zm_heavy_hit", var_2, var_1);
  self _meth_8308(0);
  self _meth_809F("damage_heavy");
  var_4 = self.origin - var_0;
  var_4 = (var_4[0], var_4[1], 0);
  var_4 = var_3 * vectorNormalize(var_4);
  var_4 = (var_4[0], var_4[1], 125);
  wait(var_2);
  self _meth_82F7(var_4);
  self _meth_8308(1);
}

special_move_to_enemy_try(var_0) {
  var_1 = self;
  var_2 = king_get_closest_enemy_target();

  if(!isDefined(var_2))
    return 0;

  var_1.current_move_to = spawnStruct();
  var_1.current_move_to._id_375E = var_2;
  return 1;
}

special_move_to_enemy_start(var_0) {
  var_1 = self;
  var_2 = var_1.current_move_to._id_375E;
  var_3 = var_2.origin + (0, 0, 42);
  var_4 = undefined;

  if(isDefined(var_0))
    var_4 = var_0[0];

  var_1 enable_geist_bullet_shield();
  var_1.current_move_to._id_2DA7 = king_create_destination(var_3, var_4);
  var_1.current_move_to.backup_rotation_target = var_1 create_rotation_target_yaw(var_1.puck.angles[1]);
}

special_move_to_enemy_think() {
  var_0 = self;

  if(!var_0 king_enemy_target_is_valid(var_0.current_move_to._id_375E)) {
    var_1 = get_victim_player();

    if(!isDefined(var_1))
      var_1 = king_get_enemy_target();

    if(isDefined(var_1)) {
      var_0.current_move_to._id_375E = var_1;
      var_0.current_move_to.rotation_target = var_0 create_rotation_target_ent(var_1);
      var_0 set_rotation_target(var_0.current_move_to.rotation_target);
      var_0 king_set_preselected_enemy(var_1);
    } else if(var_0.rotation_target != var_0.current_move_to.backup_rotation_target)
      var_0 set_rotation_target(var_0.current_move_to.backup_rotation_target);
  }

  var_2 = king_has_arrived(var_0.current_move_to._id_2DA7);

  if(!var_2)
    king_continue_moving(var_0.current_move_to._id_2DA7);

  return var_2;
}

special_move_to_enemy_end() {
  var_0 = self;
  var_0.current_move_to = undefined;
}

special_move_face_enemy_try(var_0) {
  var_1 = self;
  return 1;
}

special_move_face_enemy_start(var_0) {
  var_1 = self;
  var_1.current_move = spawnStruct();
  var_2 = get_new_boss_position();
  var_3 = undefined;

  if(isDefined(var_0))
    var_3 = var_0[0];

  var_1 enable_geist_bullet_shield();
  var_1.current_move._id_2DA7 = king_create_destination(var_2, var_3);
  var_1.current_move.backup_rotation_target = var_1 create_rotation_target_yaw(var_1.puck.angles[1]);
}

special_move_face_enemy_think() {
  var_0 = self;

  if(!var_0 king_enemy_target_is_valid(var_0.current_move._id_375E)) {
    var_1 = get_victim_player();

    if(!isDefined(var_1))
      var_1 = king_get_enemy_target();

    if(isDefined(var_1)) {
      var_0.current_move._id_375E = var_1;
      var_0.current_move.rotation_target = var_0 create_rotation_target_ent(var_1);
      var_0 set_rotation_target(var_0.current_move.rotation_target);
      var_0 king_set_preselected_enemy(var_1);
    } else if(var_0.rotation_target != var_0.current_move.backup_rotation_target)
      var_0 set_rotation_target(var_0.current_move.backup_rotation_target);
  }

  var_2 = king_has_arrived(var_0.current_move._id_2DA7);

  if(!var_2)
    king_continue_moving(var_0.current_move._id_2DA7);

  return var_2;
}

special_move_face_enemy_end() {
  var_0 = self;
  var_0.current_move = undefined;
}

register_boss_melee_move(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(level.boss_melee_moves))
    level.boss_melee_moves = [];

  if(isDefined(level.boss_melee_moves[var_0])) {}

  var_5 = spawnStruct();
  var_5.name = var_0;
  var_5.try_func = var_1;
  var_5._id_920F = var_2;
  var_5.think_func = var_3;
  var_5._id_367E = var_4;
  level.boss_melee_moves[var_0] = var_5;
}

register_boss_special_attack_wrapper(var_0, var_1) {
  var_2 = undefined;

  if(common_scripts\utility::_id_562E(var_1))
    var_2 = self.attack_uber[var_0];
  else
    var_2 = self.attack_basic[var_0];

  var_3 = var_2._id_116E;
  var_4 = var_2.try_func;
  var_5 = var_2._id_920F;
  var_6 = var_2.think_func;
  var_7 = var_2._id_367E;
  var_8 = var_2.run_func;
  var_9 = var_2.scr_st;
  var_10 = var_2.scr_pri;
  var_11 = var_2.anim_end_func;
  register_boss_special_move(var_3, var_4, var_5, var_6, var_7);
  var_12 = level.boss_special_moves[var_3];
  var_12.allow_pain = var_2.allow_pain;

  if(isDefined(var_9))
    _id_0547::_id_7BD0(var_9, var_8, undefined, var_10, var_11);
}

register_boss_special_move(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(level.boss_special_moves))
    level.boss_special_moves = [];

  if(isDefined(level.boss_special_moves[var_0])) {}

  var_5 = spawnStruct();
  var_5.name = var_0;
  var_5.try_func = var_1;
  var_5._id_920F = var_2;
  var_5.think_func = var_3;
  var_5._id_367E = var_4;
  level.boss_special_moves[var_0] = var_5;
}

king_enemy_target_is_valid(var_0) {
  var_1 = self;

  if(!isDefined(var_0))
    return 0;

  if(!isalive(var_0))
    return 0;

  if(_id_0547::_id_5565(level.zombie_king, var_0))
    return 0;

  if(var_1 _id_0547::_id_8B95(var_0))
    return 0;

  if(var_0._id_00CE || isDefined(var_0._id_0117) && var_0._id_0117._id_00CE)
    return 0;

  if(var_0 _meth_8541() || isDefined(var_0._id_0117) && var_0._id_0117 _meth_8541())
    return 0;

  return 1;
}

king_set_preselected_enemy(var_0) {
  var_1 = self;
  var_1.preselected_enemy = var_0;
}

king_get_preselected_enemy() {
  var_0 = self;
  var_1 = var_0.preselected_enemy;

  if(isDefined(var_1) && king_enemy_target_is_valid(var_1)) {
    var_0.preselected_enemy = undefined;
    return var_1;
  }

  return undefined;
}

king_get_preselected_enemy_player() {
  var_0 = self;
  var_1 = var_0.preselected_enemy;

  if(isDefined(var_1) && isPlayer(var_1) && king_enemy_target_is_valid(var_1)) {
    var_0.preselected_enemy = undefined;
    return var_1;
  }

  return undefined;
}

king_get_closest_enemy_target() {
  var_0 = self;
  var_1 = _id_053C::_id_4F88();

  foreach(var_3 in var_1) {
    if(_id_0547::_id_5565(var_3._id_983B, 1))
      return var_3;
  }

  foreach(var_3 in var_1) {
    if(king_enemy_target_is_valid(var_3))
      return var_3;
  }

  return undefined;
}

king_get_enemy_target() {
  var_0 = self;
  var_1 = var_0 king_get_preselected_enemy();

  if(isDefined(var_1))
    return var_1;

  var_2 = _id_053C::_id_4F88();

  foreach(var_4 in var_2) {
    if(_id_0547::_id_5565(var_4._id_983B, 1))
      return var_4;
  }

  foreach(var_4 in var_2) {
    if(king_enemy_target_is_valid(var_4))
      return var_4;
  }

  return undefined;
}

king_get_detonate_target() {
  var_0 = _id_0547::_id_408F();
  var_1 = get_victim_player();
  var_0 = _func_1AC(var_0, var_1.origin);
  var_0 = common_scripts\utility::_id_0FA2(var_0);

  foreach(var_3 in var_0) {
    if(king_enemy_target_is_valid(var_3) && (!isPlayer(var_3) && var_3 _id_0547::_id_4B2C()))
      return var_3;
  }

  return undefined;
}

king_get_all_targets() {
  var_0 = [];
  var_1 = _id_0547::_id_408F();
  var_1 = common_scripts\utility::_id_0F73(var_1, level.players);

  foreach(var_3 in var_1) {
    if(king_enemy_target_is_valid(var_3)) {
      if(isDefined(var_3._id_0A4B) && !var_3 _id_0547::_id_4B2C()) {
        continue;
      }
      var_0[var_0.size] = var_3;
    }
  }

  return var_0;
}

king_get_targets_in_range(var_0) {
  var_1 = self;
  var_2 = king_get_all_targets();
  var_2 = _func_1AC(var_2, var_1.origin, var_0);
  var_2 = common_scripts\utility::_id_0FA2(var_2);

  if(var_2.size > 0)
    return var_2;

  return undefined;
}

get_next_lightning_target() {
  var_0 = _id_0547::_id_408F();
  var_1 = get_victim_player();
  var_0 = _func_1AC(var_0, var_1.origin, 128);

  foreach(var_3 in var_0) {
    if(king_enemy_target_is_valid(var_3) && !_id_0547::_id_5565(var_3.islightningtarget, 1))
      return var_3;
  }

  return undefined;
}

get_victim_player() {
  var_0 = self;
  var_1 = [];
  var_2 = [];
  var_3 = undefined;
  var_4 = var_0 king_get_preselected_enemy_player();

  if(isDefined(var_4))
    return var_4;

  foreach(var_6 in level.players) {
    if(_id_0547::_id_5565(var_6._id_983B, 1))
      var_2[var_2.size] = var_6;

    if(!_id_0547::_id_577E(var_6) && !common_scripts\utility::_id_562E(var_6.boss_victim_cooldown))
      var_1[var_1.size] = var_6;
  }

  if(var_2.size >= 0)
    var_3 = level.players;
  else if(var_1.size >= 0)
    var_3 = level.players;

  var_8 = common_scripts\utility::random(var_3);
  var_8 thread set_victim_cooldown();
  return var_8;
}

set_victim_cooldown() {
  self notify("boss_set_victim_cooldown");
  self endon("boss_set_victim_cooldown");
  self.boss_victim_cooldown = 1;
  wait 3;
  self.boss_victim_cooldown = 0;
}

king_pick_blood_plate() {
  var_0 = self;
  var_1 = maps\mp\mp_zombie_descent::get_full_boss_blood_plates();

  if(var_1.size > 0) {
    var_1 = _func_1AC(var_1, var_0.origin);
    return var_1[0];
  }

  return undefined;
}

king_create_destination(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.origin = var_0;
  var_2.move_targets = [];
  var_2.move_targets[0] = create_move_target(var_0, var_1);
  var_2.move_targets_reached = 0;
  var_2._id_018A = var_1;
  return var_2;
}

king_has_arrived(var_0) {
  var_1 = self;

  if(!_id_0547::_id_5565(var_1.current_destination, var_0))
    return 0;

  if(var_0.move_targets_reached < var_0.move_targets.size)
    return 0;

  return 1;
}

king_continue_moving(var_0) {
  var_1 = self;

  if(!_id_0547::_id_5565(var_1.current_destination, var_0))
    thread king_set_destination_internal(var_0);
  else {}
}

king_is_facing_rotation_target(var_0) {
  var_1 = self;

  if(!_id_0547::_id_5565(var_1.rotation_target, var_0))
    return 0;

  var_2 = var_1 get_desired_rotation_yaw();

  if(_func_0AE(_func_0DD(var_2 - var_1.puck.angles[1])) < 22)
    return 1;

  return 0;
}

king_set_destination_internal(var_0) {
  var_1 = self;
  var_1 notify("new_destination");
  var_1 endon("death");
  var_1 endon("new_destination");
  var_1 king_create_destination_path(var_0);
  var_1 childthread king_handle_destination_path(var_0);
}

king_create_destination_path(var_0) {
  var_1 = self;
  var_2 = var_1.origin;
  var_3 = var_0.origin;

  if(distance(var_2, var_3) < 10) {
    var_0.move_targets_reached = var_0.move_targets.size;
    return;
  }

  var_0.move_targets_reached = 0;
  var_4 = var_0._id_018A;

  if(var_1 _meth_83EC(var_2, var_3, 32, 100, 1)) {
    var_0.move_targets = [create_move_target(var_3, var_4)];
    return;
  }

  var_0.move_targets = [];
  var_5 = _func_2E1(var_2, var_1);
  var_6 = _func_2E1(var_3, var_1);
  var_7 = var_1 _meth_857B(var_5, var_6);
  var_8 = vectorNormalize(var_3 - var_2);

  for(var_9 = 1; var_9 < var_7.size - 1; var_9++) {
    var_10 = var_7[var_9];
    var_11 = var_10 - var_2;
    [var_13, var_14] = _id_0547::_id_776A(var_11, var_8);
    var_15 = max(var_2[2] + var_13[2], var_10[2]);
    var_0.move_targets[var_0.move_targets.size] = create_move_target((var_10[0], var_10[1], var_15), var_4);
  }

  var_0.move_targets[var_0.move_targets.size] = create_move_target(var_3, var_4);
}

king_handle_destination_path(var_0) {
  var_1 = self;
  var_2 = common_scripts\utility::_id_0FA3(var_0.move_targets, var_0.move_targets_reached);
  var_1 set_move_path(var_2);

  for(var_1.current_destination = var_0; var_1.current_destination.move_targets_reached < var_1.current_destination.move_targets.size; var_1.current_destination.move_targets_reached++) {
    var_3 = var_1.move_targets[0];
    var_3 waittill("complete");
  }
}

king_is_in_or_waiting_for_scripted_state(var_0) {
  var_1 = self;
  return var_1 _id_0547::is_in_scripted_state(var_0) || var_1 _id_0547::has_scripted_state_queued(var_0);
}

king_handle_attached_vfx_cleanup(var_0, var_1) {
  var_2 = self;
  var_2 maps\mp\agents\_agent_utility::deleteentonagentdeath(var_0);

  if(common_scripts\utility::_id_562E(var_1))
    var_2 thread handle_clear_on_interrupt(var_0);
}

handle_clear_on_interrupt(var_0) {
  var_1 = self;
  var_0 endon("entitydeleted");
  var_1 endon("death");
  common_scripts\utility::_id_A70C(var_1, "stand_pain_interrupt", var_1, "invalid_target_interrupt");
  var_0 delete();
}

king_ishitweakpoint(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_8) && var_8 == "soft")
    return 1;

  return 0;
}

king_on_damaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = var_2;
  var_13 = self;

  if(_id_0547::_id_5565(var_13, var_1))
    var_2 = 0;

  if(isPlayer(var_1) && common_scripts\utility::_id_562E(var_13.geistbulletshield) && !king_check_if_raven_weapons(var_5)) {
    var_2 = 0;
    god_king_impact_vfx(var_6, level._effect["zmb_godking_gk_impact"]);
  }

  if(isPlayer(var_1) && common_scripts\utility::_id_562E(var_13.drainshieldacive)) {
    var_2 = 0;
    god_king_impact_vfx(var_6, level._effect["zmb_godking_gk_impact"]);
  }

  if(isDefined(var_5) && isDefined(var_4)) {
    if(king_check_if_weapon_op(var_5, var_4) && var_2 > 1)
      var_2 = int(var_2 * 0.65);
  }

  if(isDefined(var_5) && isDefined(var_4)) {
    if(king_check_if_weapon_sap(var_5, var_4) && var_2 > 1)
      var_2 = int(var_2 * 0.5);
  }

  if(king_check_if_raven_weapons(var_5) && !common_scripts\utility::_id_562E(var_13.drainshieldacive)) {
    var_14 = "weakpoint";
    var_1 thread _id_04C7::_id_A102(var_14);
    var_2 = 49033.2;
  }

  if(king_check_if_raven_weapon_cleave(var_5) && !common_scripts\utility::_id_562E(var_13.drainshieldacive))
    var_2 = 24516.6;

  if(isDefined(var_8) && var_8 == "soft") {
    var_15 = var_1 _meth_850B(var_5, var_8);
    var_16 = var_1 _meth_850B(var_5, "head");

    if(var_15 <= 0)
      var_15 = 1;

    var_17 = var_2 / var_15;
    var_18 = var_17 * var_16;
    var_2 = int(var_18);
  }

  if(var_13[[var_13 maps\mp\agents\_agent_utility::_id_0A59("is_hit_weak_point")]](var_13, var_0, var_1, var_2, var_4, var_5, undefined, var_7, var_8)) {
    var_19 = var_1 _meth_850B(var_5, var_8);
    var_20 = weaponclass(var_5);

    if(var_19 == 0 || weaponclass(var_5) == "sniper") {} else {
      var_21 = int(var_2 / var_19);
      var_22 = var_19 * 0.5;
      var_23 = var_21 / var_22 * max(var_22 + 1, 0);
      var_2 = int(var_23);
    }
  }

  if(isPlayer(var_1) && maps\mp\zombies\weapons\_zombie_dlc4_melee::is_scythe_death_burst_weapon(var_5)) {
    var_14 = "weakpoint";
    var_1 thread _id_04C7::_id_A102(var_14);
    var_2 = var_13.maxhealth * 0.03;
  }

  if(var_2 > 0)
    god_king_impact_vfx(var_6, level._effect["blood_godking_impact_burst"]);

  if(var_2 <= 0) {
    var_14 = "none";
    var_1 thread _id_04C7::_id_A102(var_14);
  }

  var_13 _id_054D::_id_6BD1(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
}

init_impact_vfx() {
  var_0 = self;
  level.god_king_impact_vfx = [];

  for(var_1 = 0; var_1 < 4; var_1++) {
    var_2 = spawn("script_model", (0, 0, 0));
    var_2 setModel("tag_origin");
    var_2 thread _id_0547::_id_2D19(var_0);
    level.god_king_impact_vfx[var_1] = var_2;
  }

  level.last_god_king_impact_vfx_index = -1;
}

god_king_impact_vfx(var_0, var_1) {
  var_2 = gettime();

  if(!_id_0547::_id_5565(level.last_god_king_impact_vfx, var_2)) {
    var_3 = common_scripts\utility::_id_627D(level.last_god_king_impact_vfx_index + 1, 4);
    var_4 = level.god_king_impact_vfx[var_3];
    var_4.origin = var_0;
    var_4 _meth_808C();
    _func_147(var_1, var_4, "tag_origin");
    level.last_god_king_impact_vfx_index = var_3;
    level.last_god_king_impact_vfx = var_2;
  }
}

reflect_bullet(var_0, var_1, var_2, var_3, var_4) {
  if(_id_0547::_id_5565(var_1, var_0)) {
    return;
  }
  if(maps\mp\_utility::_id_5695(var_3)) {
    var_5 = var_4 + vectorNormalize(vectorNormalize(var_1 getEye() - var_4) + _id_7A43(0.9)) * 3000;
    _func_1B5(var_2, var_4, var_5, var_0);
  }
}

punish_damage_limit_reached() {
  if(!isDefined(self.punishdamage))
    return 0;

  if(self.punishdamage > get_zombie_king_punish_limit())
    return 1;

  return 0;
}

get_zombie_king_punish_limit() {
  var_0 = 5;

  switch (level.players.size) {
    case 1:
      var_0 = 100000;
      break;
    case 2:
      var_0 = 150000;
      break;
    case 3:
      var_0 = 200000;
      break;
    case 4:
      var_0 = 300000;
      break;
    default:
      break;
  }

  return int(var_0);
}

king_on_damage_finished(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = self;

  if(isPlayer(var_1) && common_scripts\utility::_id_562E(var_11.drainpunishactive) && !var_11 punish_damage_limit_reached()) {
    var_12 = "weakpoint";
    var_1 thread _id_04C7::_id_A102(var_12);
    var_2 = int(var_2 * 1.25);

    if(!isDefined(var_11.punishdamage))
      var_11.punishdamage = var_2;
    else
      var_11.punishdamage = var_11.punishdamage + var_2;
  } else if(isPlayer(var_1) && common_scripts\utility::_id_562E(var_11.drainpunishactive) && var_11 punish_damage_limit_reached()) {
    var_12 = "none";
    var_1 thread _id_04C7::_id_A102(var_12);
    var_2 = 0;
  }

  if(var_2 == 0) {
    return;
  }
  foreach(var_15, var_14 in var_11.king_damage_finished_funcs)
  var_11 thread[[var_14]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

  _id_054D::_id_6BD3(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
}

add_king_damage_finished_func(var_0, var_1) {
  var_2 = self;
  var_2.king_damage_finished_funcs[var_0] = var_1;
}

remove_king_damage_finished_func(var_0) {
  var_1 = self;
  var_1.king_damage_finished_funcs[var_0] = undefined;
}

state_default_run() {
  var_0 = self;
  var_0 start_manual_rotation();
  var_0 pause_manual_move();
  var_1 = 0;
  var_2 = 0;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = 1;

  if(common_scripts\utility::_id_562E(var_0.king_seated)) {
    var_8 = var_0 maps\mp\agents\_scripted_agent_anim_util::_id_434D("death_sit");
    var_0 maps\mp\agents\_scripted_agent_anim_util::_id_8415(var_8);
    var_0 waittill("forever");
  }

  for(;;) {
    if(!common_scripts\utility::_id_562E(var_7))
      var_0 common_scripts\utility::waittill_notify_or_timeout("manual_move_complete", 0.2);

    var_7 = 0;
    var_6 = var_0 get_next_manual_move();
    var_9 = isDefined(var_6);

    if(var_9) {
      var_10 = get_manual_rotation_target_yaw_in_time(0.3);
      var_11 = _func_109(var_6.origin - var_0.puck.origin);
      var_12 = _func_0DD(var_10 - var_11);
      var_4 = var_11;
      var_5 = var_10;

      if(var_1) {
        var_13 = get_angled_anim_info_for_action("strafe", var_12);

        if(!_id_0547::_id_5565(var_13._id_0E18, var_3)) {
          var_0 maps\mp\agents\_scripted_agent_anim_util::_id_8415(var_13._id_0E84, var_13._id_0E18);
          var_3 = var_13._id_0E18;
        }
      } else {
        var_13 = var_0 get_angled_anim_info_for_action("stand_2_strafe", var_12);
        var_0 maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_13._id_0E84, var_13._id_0E18, 1, "king_move");
        var_0 start_manual_move();
        var_1 = 1;
        var_3 = undefined;
        var_2 = 0;
        var_7 = 1;
      }

      continue;
    }

    if(var_1) {
      var_0 pause_manual_move();
      var_12 = _func_0DD(var_5 - var_4);
      var_13 = var_0 get_angled_anim_info_for_action("strafe_2_stand", var_12);
      var_0 maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_13._id_0E84, var_13._id_0E18, 1, "king_move");
      var_1 = 0;
      var_14 = undefined;
      var_7 = 1;
      continue;
    }

    if(!var_2) {
      var_8 = var_0 maps\mp\agents\_scripted_agent_anim_util::_id_434D("idle");
      var_0 maps\mp\agents\_scripted_agent_anim_util::_id_8415(var_8);
      var_2 = 1;
    }
  }
}

king_control_for_rotation_animation(var_0, var_1) {
  var_2 = self;
  var_3 = var_2 _meth_83D8(var_0._id_0E84, var_0._id_0E18);
  var_4 = _func_065(var_3);
  var_5 = maps\mp\agents\_scripted_agent_anim_util::_id_45B9(var_3, "rotation_start", 0);
  var_6 = maps\mp\agents\_scripted_agent_anim_util::_id_45B9(var_3, "rotation_end", 1);

  if(var_4 == 0) {
    return;
  }
  var_7 = var_4 * var_5;

  if(var_7 > 0)
    wait(var_7);

  var_8 = var_4 * var_6 - var_7;
  var_9 = (0, var_1, 0);
  var_2.puck _meth_82B8(var_9, var_8);

  if(var_2.rotation_target.type == "ent")
    var_2 start_manual_rotation();

  wait(var_8);
}

state_default_interrupt() {
  thread _id_0547::_id_7D1A("king_default");
}

state_default_end() {
  var_0 = self;
  var_0 pause_manual_move();
  var_0 pause_manual_rotation();
}

get_angled_anim_info_for_action(var_0, var_1) {
  var_2 = spawnStruct();
  var_3 = self;
  var_2._id_0E84 = var_3 maps\mp\agents\_scripted_agent_anim_util::_id_434D(var_0);
  var_4 = var_3 _meth_83DB(var_2._id_0E84);
  var_2._id_0E18 = maps\mp\agents\_scripted_agent_anim_util::_id_4416(var_1, var_4);
  return var_2;
}

get_possible_boss_positions() {
  var_0 = undefined;

  if(common_scripts\utility::_id_562E(level.king_level_setup)) {
    if(_id_0547::_id_5565(level.zombie_king.current_phase_index, 0))
      return level.bossfight.boss_pos_wave0;
    else if(_id_0547::_id_5565(level.zombie_king.current_phase_index, 1))
      return level.bossfight.boss_pos_wave1;
    else if(_id_0547::_id_5565(level.zombie_king.current_phase_index, 2))
      return level.bossfight.boss_pos_wave2;
    else if(_id_0547::_id_5565(level.zombie_king.current_phase_index, 3))
      return level.bossfight.boss_pos_wave3;
    else if(_id_0547::_id_5565(level.zombie_king.current_phase_index, 6))
      return level.bossfight.boss_pos_wave6;

    return [level.bossfight.default_boss_pos];
  } else {
    var_1 = spawnStruct();
    var_1.origin = (_func_0A4(-500, 500), _func_0A4(-500, 500), _func_0A4(0, 500));
    return [var_1];
  }
}

get_new_boss_position() {
  var_0 = self;
  var_1 = get_possible_boss_positions();
  var_1 = common_scripts\utility::array_randomize(var_1);

  foreach(var_3 in var_1) {
    if(distancesquared(var_3.origin, var_0.puck.origin) > 100)
      return var_3.origin;
  }

  return var_1[0].origin;
}

get_random_boss_position() {
  var_0 = get_possible_boss_positions();
  var_1 = common_scripts\utility::random(var_0);
  return var_1.origin;
}

get_random_boss_sun_position() {
  var_0 = common_scripts\utility::random(level.bossfight.boss_sun_pos);
  return var_0.origin;
}

get_random_boss_blood_position() {
  if(common_scripts\utility::_id_562E(level.king_level_setup)) {
    var_0 = common_scripts\utility::random(level.bossfight.boss_blood_pos);
    return var_0.origin;
  } else
    return (_func_0A4(-500, 500), _func_0A4(-500, 500), _func_0A4(0, 500));
}

get_boss_pull_position(var_0) {
  if(common_scripts\utility::_id_562E(level.king_level_setup)) {
    if(!var_0 common_scripts\utility::_id_3794("phase_transition_active") && _id_0547::_id_5565(var_0.current_phase_index, 3) || _id_0547::_id_5565(var_0.current_phase_index, 4))
      var_1 = level.bossfight.throne_pos;
    else
      var_1 = level.bossfight.boss_drain_pos;

    return var_1.origin;
  } else
    return (_func_0A4(-500, 500), _func_0A4(-500, 500), _func_0A4(0, 500));
}

king_handle_pain() {
  var_0 = self;
  var_0 endon("death");
  var_0.lastpaindamagetick = 20;
  var_0 add_king_damage_finished_func("pain_watch", ::king_pain_on_damage_finished);
}

king_pain_on_damage_finished(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = self;

  if(!common_scripts\utility::_id_562E(var_11.standing_pain_allowed)) {
    return;
  }
  if(var_11 king_is_in_or_waiting_for_scripted_state("king_stand_pain")) {
    return;
  }
  var_12 = _func_0D5(var_11.health / var_11.maxhealth * 20);
  var_13 = var_12 < var_11.lastpaindamagetick;

  if(var_13) {
    var_11 thread _id_0547::_id_7D1A("king_stand_pain", [var_8, var_7], 0.2);
    var_11.lastpaindamagetick = var_12;
  } else if(var_12 > var_11.lastpaindamagetick)
    var_11.lastpaindamagetick = var_12;
}

anim_state_stand_pain_run(var_0, var_1) {
  var_2 = self;
  var_2 notify("stand_pain_interrupt");
  var_2.was_pain_interrupted = 1;
  var_3 = "pain_stand_head";

  if(isDefined(var_0) && var_0 != "head" && isDefined(var_1)) {
    var_4 = anglestoright(var_2.puck.angles);

    if(vectordot(var_4, var_1) > 0)
      var_3 = "pain_stand_right";
    else
      var_3 = "pain_stand_left";
  }

  var_5 = maps\mp\agents\_scripted_agent_anim_util::_id_434D(var_3);
  var_6 = maps\mp\agents\_scripted_agent_anim_util::_id_7A35(var_5);
  var_2 maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_5, var_6, 1, "", "end");
}

anim_state_stand_pain_interrupt(var_0, var_1) {}

anim_state_stand_pain_end(var_0, var_1) {}

king_try_interrupted_by_pain() {
  var_0 = self;
  var_1 = common_scripts\utility::_id_562E(var_0.was_pain_interrupted);
  var_0.was_pain_interrupted = 0;
  return var_1;
}

handle_manual_move() {
  var_0 = self;
  var_0 endon("death");
  var_1 = spawn("script_model", self.origin);
  var_1 setModel("tag_origin");
  var_1.angles = (0, var_0.angles[1], 0);
  var_1 thread _id_0547::_id_2D19(var_0);
  var_0.puck = var_1;
  var_0.move_targets = [];
  var_0 common_scripts\utility::_id_3799("manual_move_enabled");
  var_0 _meth_839D("noclip");
  var_0 _meth_855A(0.1, 0.1, var_0.puck, "tag_origin", "tag_sync");

  for(;;) {
    var_2 = var_0 wait_for_valid_manual_move();
    var_3 = var_0 do_manual_move(var_2);
  }
}

do_manual_move(var_0) {
  var_1 = self;
  var_1.current_move_target = var_0;
  var_1 thread manual_move_motion(var_0);
  var_1 waittill("manual_move_end", var_2);

  if(isDefined(var_2)) {
    switch (var_2) {
      case "result_complete":
        on_manual_move_complete(var_0);
        break;
    }
  }

  var_1.current_move_target = undefined;
  wait 0;
  return var_2;
}

manual_move_motion(var_0) {
  var_1 = self;
  var_1 endon("manual_move_end");
  var_2 = distance(var_1.puck.origin, var_0.origin);
  var_3 = var_2 / var_0._id_018A;

  if(var_2 == 0)
    waitframe();
  else {
    var_0._id_9255 = var_1.puck.origin;
    var_0._id_9297 = gettime() / 1000;
    var_0._id_36AD = var_0._id_9297 + var_3;
    var_1.puck _meth_82B1(var_0.origin, var_3);
    wait(var_3);
    waitframe();
  }

  var_1 notify("manual_move_end", "result_complete");
}

wait_for_valid_manual_move() {
  var_0 = self;
  var_0 endon("death");

  for(;;) {
    var_1 = get_next_manual_move();

    if(var_0 common_scripts\utility::_id_3794("manual_move_enabled") && isDefined(var_1))
      return var_1;

    var_0 common_scripts\utility::_id_A70A("manual_move_enabled", "new_manual_move");
  }
}

on_manual_move_complete(var_0) {
  var_1 = self;
  var_0 notify("complete");
  var_1 notify("manual_move_complete");
  var_1.move_targets = common_scripts\utility::_id_0F93(var_1.move_targets, var_0);
}

get_next_manual_move() {
  var_0 = self;

  if(!isDefined(var_0.move_targets) || var_0.move_targets.size == 0)
    return undefined;

  return var_0.move_targets[0];
}

start_manual_move() {
  var_0 = self;

  if(var_0 common_scripts\utility::_id_3794("manual_move_enabled")) {
    return;
  }
  var_0 common_scripts\utility::_id_379A("manual_move_enabled");
  var_0.puck.origin = var_0 gettagorigin("tag_sync");
  var_0.puck.angles = var_0 _meth_8181("tag_sync");
}

pause_manual_move() {
  var_0 = self;

  if(!var_0 common_scripts\utility::_id_3794("manual_rotate_enabled")) {
    return;
  }
  var_0.puck _meth_82B1(var_0.puck.origin, 0.1);

  if(isDefined(var_0.current_move_target))
    var_0 notify("manual_move_end", "result_paused");

  var_0 common_scripts\utility::_id_3796("manual_move_enabled");
}

set_move_path(var_0) {
  var_1 = self;
  var_1.move_targets = var_0;
  on_move_targets_changed();
}

set_move_target(var_0) {
  var_1 = self;
  var_1.move_targets = [var_0];
  on_move_targets_changed();
}

on_move_targets_changed() {
  var_0 = self;
  var_0 notify("new_manual_move");

  if(isDefined(var_0.current_move_target) && !_id_0547::_id_5565(var_0.move_targets[0], var_0.current_move_target))
    var_0 notify("manual_move_end", "result_replaced");

  if(isDefined(var_0.current_destination))
    var_0.current_destination = undefined;
}

add_to_end_of_path(var_0) {
  var_1 = self;
  var_1.move_targets = common_scripts\utility::_id_0F6F(var_1.move_targets, var_0);
  var_1 notify("new_manual_move");
}

go_to_position(var_0) {
  set_move_target(create_move_target(var_0));
}

create_move_target(var_0, var_1) {
  var_2 = self;
  var_3 = spawnStruct();

  if(!isDefined(var_1) || var_1 == 0)
    var_1 = 485;

  var_3.origin = var_0;
  var_3._id_018A = var_1;
  return var_3;
}

handle_manual_rotation() {
  var_0 = self;
  var_0 endon("death");
  var_0 common_scripts\utility::_id_3799("manual_rotate_enabled");

  for(;;) {
    wait_for_valid_rotation_target();
    var_1 = get_desired_rotation_yaw();
    var_2 = _func_0DD(var_1 - var_0.puck.angles[1]);
    var_3 = 220;
    var_4 = _func_0AE(var_2) / var_3;
    var_5 = (0, var_1, 0);

    if(var_4 > 0) {
      var_4 = max(0.2, var_4);
      var_0.puck _meth_82B8(var_5, var_4);
      var_0.rotation_target.last_yaw_target = var_1;
      var_0.rotation_target.last_end_time = gettime() / 1000 + var_4;
      wait 0.2;
      continue;
    }

    waitframe();
  }
}

wait_for_valid_rotation_target() {
  var_0 = self;

  for(;;) {
    if(isDefined(var_0.rotation_target) && var_0 common_scripts\utility::_id_3794("manual_rotate_enabled")) {
      return;
    }
    var_0 common_scripts\utility::_id_A70A("manual_rotate_enabled", "new_rotation_target");
  }
}

start_manual_rotation() {
  var_0 = self;

  if(var_0 common_scripts\utility::_id_3794("manual_rotate_enabled")) {
    return;
  }
  var_0 common_scripts\utility::_id_379A("manual_rotate_enabled");
}

pause_manual_rotation() {
  var_0 = self;

  if(!var_0 common_scripts\utility::_id_3794("manual_rotate_enabled")) {
    return;
  }
  var_0 common_scripts\utility::_id_3796("manual_rotate_enabled");
  var_0.puck _meth_82B8(var_0.puck.angles, 0.05);
}

get_desired_rotation_yaw() {
  var_0 = self;

  if(!isDefined(var_0.rotation_target))
    return var_0.puck.angles[1];

  switch (var_0.rotation_target.type) {
    case "yaw":
      return var_0.rotation_target._id_AAE8;
    case "origin":
      return _func_109(var_0.rotation_target.origin - var_0.puck.origin);
    case "ent":
      return _func_109(var_0.rotation_target._id_378F.origin - var_0.puck.origin);
  }

  return var_0.puck.angles[1];
}

get_manual_rotation_target_yaw_in_time(var_0) {
  var_1 = self;

  if(!var_1 common_scripts\utility::_id_3794("manual_rotate_enabled") || !isDefined(var_1.rotation_target))
    return var_1.puck.angles[1];

  switch (var_1.rotation_target.type) {
    case "yaw":
      return var_1.rotation_target._id_AAE8;
    case "origin":
      var_2 = var_1 get_expected_position_in_time(var_0);
      return _func_109(var_1.rotation_target.origin - var_2);
    case "ent":
      var_2 = var_1 get_expected_position_in_time(var_0);
      return _func_109(var_1.rotation_target._id_378F.origin - var_2);
  }

  return var_1.puck.angles[1];
}

get_expected_position_in_time(var_0) {
  var_1 = self;
  var_2 = var_1.origin;

  if(var_1 common_scripts\utility::_id_3794("manual_move_enabled")) {
    var_2 = var_1.puck.origin;

    if(isDefined(var_1.current_move_target)) {
      var_3 = var_1.current_move_target;
      var_4 = gettime() / 1000 + var_0;

      if(var_4 < var_3._id_9297)
        var_2 = var_1.puck.origin;
      else if(var_4 < var_3._id_36AD) {
        var_5 = (var_4 - var_3._id_9297) / (var_3._id_36AD - var_3._id_9297);
        var_2 = _func_10A(var_3._id_9255, var_3.origin, clamp(var_5, 0, 1));
      } else
        var_2 = var_3.origin;
    }
  }

  return var_2;
}

set_rotation_target(var_0) {
  var_1 = self;
  var_1 notify("new_rotation_target");
  var_1.rotation_target = var_0;
}

create_rotation_target_shared(var_0) {
  var_1 = spawnStruct();

  if(!isDefined(var_0))
    var_0 = 220;

  var_1.rot_speed = var_0;
  return var_1;
}

create_rotation_target_yaw(var_0, var_1) {
  var_2 = create_rotation_target_shared(var_1);
  var_2.type = "yaw";
  var_2._id_AAE8 = var_0;
  return var_2;
}

create_rotation_target_origin(var_0, var_1) {
  var_2 = create_rotation_target_shared(var_1);
  var_2.type = "origin";
  var_2.origin = var_0;
  return var_2;
}

create_rotation_target_ent(var_0, var_1) {
  var_2 = create_rotation_target_shared(var_1);
  var_2.type = "ent";
  var_2._id_378F = var_0;
  return var_2;
}

boss_blood_plate_drain() {
  var_0 = self;
  var_0 endon("release_plate");

  for(;;) {
    var_0 maps\mp\mp_zombie_descent::blood_plate_subtract();
    wait 0.85;
  }
}

enable_geist_bullet_shield() {
  var_0 = self;

  if(common_scripts\utility::_id_562E(var_0.geistbulletshield)) {
    return;
  }
  var_0.geistbulletshield = 1;

  if(isDefined(level.zombie_king_sword)) {
    var_0.shieldprotectionfx = _func_2A8(level._effect["zmb_godking_sword_protection"], level.zombie_king_sword, "TAG_FX");
    _func_14C(var_0.shieldprotectionfx);
  }
}

disable_geist_bullet_shield() {
  var_0 = self;

  if(!common_scripts\utility::_id_562E(var_0.geistbulletshield)) {
    return;
  }
  var_0.geistbulletshield = undefined;

  if(isDefined(var_0.shieldprotectionfx))
    var_0.shieldprotectionfx delete();
}

vo_play_gdk_line(var_0) {
  self endon("death");

  while(common_scripts\utility::_id_562E(self.gdk_speaking))
    waitframe();

  self.gdk_speaking = 1;
  self.ability_vo = _id_0380::_id_288B(var_0, level.players, self, 0, 1);
  var_1 = _func_35D(var_0);

  if(isDefined(self.ability_vo)) {
    wait(var_1);
    level notify("level_gdk_ability_line_done");
    self.ability_vo = undefined;
  }

  self.gdk_speaking = 0;
}

vo_play_gdk_ability_line(var_0) {
  self endon("death");
  var_1 = vo_get_gdk_ability_line(var_0);

  if(isDefined(var_1))
    vo_play_gdk_line(var_1);
}

vo_get_gdk_ability_line(var_0) {
  self endon("death");
  var_1 = "zmb_dlc4_fzn_dwn_gdk_";
  var_2 = undefined;
  var_3 = undefined;

  switch (var_0) {
    case "geist_bomb_toss":
      var_2 = common_scripts\utility::random(["youcanrunfrompainbutyouwi", "feelmypowerwashoveryou"]);
      var_3 = 1;
      break;
    case "kneel_tell":
      var_2 = common_scripts\utility::random(["youcannotescapemymajesty", "gatherbeforemesupplicants"]);
      break;
    case "kneel_execute":
      var_2 = common_scripts\utility::random(["kneelbeforeyourlord", "kneelbowyourheadsbeforedi"]);
      break;
    case "geist_drain":
      var_2 = common_scripts\utility::random(["paytributetoyourlord", "vesselsaremeanttobeemptie", "yourwillshallbreakitalway"]);
      break;
    case "light_of_the_sun":
      var_2 = common_scripts\utility::random(["thesunandmooncowerbeforem", "lookuponyourfinaldawn"]);
      break;
    case "overwhelm_force":
      var_2 = common_scripts\utility::random(["riseminionsicommandyou", "noforcecanresistmywill"]);
      break;
    case "flame_wave":
      var_2 = common_scripts\utility::random(["yourfleshshallwither", "yourbonesshallbreak"]);
      break;
    case "end_taunt":
      var_4 = ["evennowyoucannotdefeatme", "relyingonbirdstosuccoryou"];
      var_2 = var_4[self.vo_taunt_int];
      self.vo_taunt_int = common_scripts\utility::_id_627D(self.vo_taunt_int + 1, var_4.size);
      break;
    case "end_fail":
      var_2 = "yourmercyisweakness";
      break;
    case "end_succeed":
      var_2 = "andsothecyclecontinuesthi";
      break;
    case "drain_punished":
      var_5 = ["thisthisisnotwhatiwantedi", "betrayedbymyknightsprison", "aaarghgahneveryoudareno", "cowardsstrikemedownevenno"];
      var_2 = var_5[self.vo_drain_punished_int];
      self.vo_drain_punished_int = common_scripts\utility::_id_627D(self.vo_drain_punished_int + 1, var_5.size);
      break;
    case "intro":
      var_2 = "yourpainyourbloodyourterr";
      break;
  }

  if(common_scripts\utility::_id_562E(var_3) && self.vo_lines_played.size > 0 && isDefined(common_scripts\utility::_id_0F7E(self.vo_lines_played, var_0)) && common_scripts\utility::_id_24A6())
    var_2 = undefined;

  if(isDefined(self.vo_lines_played) && !isDefined(common_scripts\utility::_id_0F7E(self.vo_lines_played, var_0)))
    self.vo_lines_played[self.vo_lines_played.size] = var_0;

  if(isDefined(var_2))
    var_2 = var_1 + var_2;

  return var_2;
}

temp_idle_anim() {
  var_0 = self;
  var_1 = var_0 maps\mp\agents\_scripted_agent_anim_util::_id_434D("idle");
  var_2 = var_0 _meth_83DB(var_1);
  var_3 = gettime();
  var_4 = randomint(var_2);
  var_0 maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_1, var_4, 1);
}

sort_tags_by_distance(var_0, var_1, var_2) {
  for(var_3 = 0; var_3 < var_2.size - 1; var_3++) {
    for(var_4 = var_3 + 1; var_4 < var_2.size; var_4++) {
      if(distance(var_0, var_1 gettagorigin(var_2[var_4])) < distance(var_0, var_1 gettagorigin(var_2[var_3]))) {
        var_5 = var_2[var_4];
        var_2[var_4] = var_2[var_3];
        var_2[var_3] = var_5;
      }
    }
  }

  return var_2;
}

sort_tags_by_distance_2d(var_0, var_1, var_2) {
  for(var_3 = 0; var_3 < var_2.size - 1; var_3++) {
    for(var_4 = var_3 + 1; var_4 < var_2.size; var_4++) {
      if(_func_0E1(var_0, var_1 gettagorigin(var_2[var_4])) < _func_0E1(var_0, var_1 gettagorigin(var_2[var_3]))) {
        var_5 = var_2[var_4];
        var_2[var_4] = var_2[var_3];
        var_2[var_3] = var_5;
      }
    }
  }

  return var_2;
}

king_spawn_pickups(var_0) {
  var_1 = _func_082(var_0 + org_randomization(64), 12, 128, 12);
  maps\mp\gametypes\zombies::_id_281C("ammo", var_1, "king zombie spawn", 1, 0);

  if(_id_0547::is_solo()) {
    var_1 = _func_082(var_0 + org_randomization(64), 12, 128, 12);
    maps\mp\gametypes\zombies::_id_281C("ability_fill", var_1, "king zombie spawn", 1, 0);
  }
}

org_randomization(var_0) {
  return (randomint(var_0), randomint(var_0), 0);
}

zombie_king_play_dead() {
  var_0 = self;
  var_0 notify("geist_drain_special_end");
  var_0 notify("fight_complete");
  var_0 notify("it_is_over");
  var_0._id_480F = 0;
  var_0._id_1DEB = 1;
  waitframe();
  var_0 _meth_8059(var_0.health + 666, var_0.origin);
  level.zombie_king_corpse = spawn("script_model", level.bossfight.throne_pos.origin);
  level.zombie_king_corpse setModel("zom_darkone_base");
  level.zombie_king_corpse.angles = level.bossfight.throne_pos.angles;
  level.zombie_king_corpse _meth_8495("s2_zom_gdk_death_finale", level.bossfight.throne_pos.origin, level.bossfight.throne_pos.angles, "forever", 10.06);
  level.zombie_king_corpse _meth_84CA(1);
  level.zombie_king_corpse thread vo_play_gdk_ability_line("end_succeed");

  while(isDefined(var_0) && _id_0547::_id_5565(var_0._id_0A4B, "zombie_king")) {
    if(common_scripts\utility::_id_562E(var_0._id_480F))
      var_0._id_480F = 0;

    var_0 _meth_8059(var_0.health + 666, var_0.origin);
    waitframe();
  }
}

set_player_ravenlord_state() {
  var_0 = self;
  var_0.isravenlordstate = 1;
  var_0 endon("disconnect");
  var_0 endon("raven_powers_removed");
  _id_0547::playfxclient_for_player("zmb_desc_player_finale_screen", var_0.origin, var_0);
  var_0 thread spawn_wings_think();
  var_0 ravenlord_apply_health_to_players();
  var_0 _id_0547::_id_73AC(3);
  var_0 childthread ravenlord_ammo_refill();
  var_0 childthread ravenlord_lethal_refill();
  var_0 childthread ravenlord_tactical_refill();
  var_0 childthread ravenlord_armor_refill();
  var_0 childthread ravenlord_special_refill();
  var_0 waittill("forever");
}

spawn_wings_think() {
  var_0 = self;
  var_0 endon("disconnect");

  for(;;) {
    var_0 spawn_wings();
    var_0 waittill("zombie_player_spawn_finished");
  }
}

spawn_wings() {
  var_0 = self;

  if(isDefined(var_0.wing_fx))
    var_0.wing_fx delete();

  var_0.wing_fx = _func_2A8(common_scripts\utility::_id_44F5("zmb_desc_player_wings"), var_0, "J_Spine4");
  _func_14C(var_0.wing_fx);
  var_0 maps\mp\gametypes\_playerlogic::deleteentonplayerdisconnect(var_0.wing_fx);
  var_0.wing_fx thread _id_0547::_id_2D19(var_0);
}

ravenlord_ammo_refill() {
  var_0 = self;

  for(;;) {
    wait 8;
    var_1 = var_0 getcurrentweapon();

    if(var_1 == "none" || _id_0547::_id_57AF(var_1) || _id_0547::_id_5862(var_1) || _id_0547::iszombieconsumableweapon(var_1) || _id_0547::_id_5864(var_1) || _id_0547::_id_585C(var_1) || _id_0548::is_grenadier_immune_weapon(var_1)) {
      continue;
    }
    var_2 = var_0 getweaponammoclip(var_1);
    var_3 = _func_1A3(var_1);
    var_4 = var_0 getweaponammostock(var_1);
    var_5 = _func_1D6(var_1);

    if(var_4 < var_5) {
      var_6 = int(var_5 * 0.04);
      var_7 = var_4;

      if(var_6 + var_4 >= var_5)
        var_7 = var_5;
      else
        var_7 = var_7 + var_6;

      var_0 setweaponammostock(var_1, var_7);
    }

    if(var_2 < var_3) {
      while(var_0 _meth_833A())
        waitframe();

      var_8 = int(var_3 * 0.04);
      var_7 = var_2;

      if(var_8 + var_2 >= var_3)
        var_7 = var_3;
      else
        var_7 = var_7 + var_8;

      var_0 setweaponammoclip(var_1, var_7);
    }

    if(issubstr(var_1, "dlcgun1")) {
      var_3 = _func_1A3(var_1);
      var_0 setweaponammoclip(var_1, var_3, "right");
    }
  }
}

ravenlord_lethal_refill() {
  var_0 = self;

  for(;;) {
    wait 18;

    if(isDefined(var_0._dlc4_weapon_manager) && isDefined(var_0._dlc4_weapon_manager["stored_lethal"])) {
      var_1 = var_0._dlc4_weapon_manager["stored_lethal"];
      var_2 = var_0 getweaponammoclip(var_1);
      var_3 = _func_1A3(var_0._dlc4_weapon_manager["stored_lethal"], self);

      if(var_2 >= var_3)
        var_0._dlc4_weapon_manager["stored_lethal_ammo"] = var_3;

      continue;
    }

    var_1 = var_0 _meth_834A();
    var_2 = var_0 getweaponammoclip(var_1);
    var_3 = _func_1A3(var_1, var_0);

    if(var_2 < var_3)
      var_0 setweaponammoclip(var_1, var_2 + 1);
  }
}

ravenlord_tactical_refill() {
  var_0 = self;

  for(;;) {
    wait 18;

    if(isDefined(var_0._dlc4_weapon_manager) && isDefined(var_0._dlc4_weapon_manager["stored_tactical"])) {
      var_1 = var_0._dlc4_weapon_manager["stored_tactical"];
      var_2 = var_0 getweaponammoclip(var_1);
      var_3 = _func_1A3(var_0._dlc4_weapon_manager["stored_tactical"], self);

      if(var_2 >= var_3)
        var_0._dlc4_weapon_manager["stored_tactical_ammo"] = var_3;

      continue;
    }

    var_1 = var_0 getoffhandsecondaryclass();
    var_2 = var_0 getweaponammoclip(var_1);
    var_3 = _func_1A3(var_1, var_0);

    if(var_2 >= var_3)
      var_0 setweaponammoclip(var_1, var_2 + 1);
  }
}

ravenlord_armor_refill() {
  var_0 = self;

  for(;;) {
    wait 26;
    var_0 _id_0547::_id_73AC(1);
  }
}

ravenlord_special_refill() {
  var_0 = self;

  for(;;) {
    wait 1;
    var_0 _id_0533::_id_0F37(0.005, 1, 1);
  }
}

ravenlord_apply_health_to_players() {
  if(self.health < self.maxhealth)
    self.health = self.health + 100;

  if(self.health > self.maxhealth)
    self.health = self.maxhealth;
}

_id_7A43(var_0) {
  return (_func_0A5(var_0 * -1, var_0), _func_0A5(var_0 * -1, var_0), _func_0A5(var_0 * -1, var_0));
}

_id_7A44(var_0) {
  return (_func_0A5(var_0 * -1, var_0), _func_0A5(var_0 * -1, var_0), 0);
}

random_2d_vector_safe_zone(var_0, var_1, var_2) {
  var_3 = anglesToForward((0, randomint(359), 0));
  var_4 = _func_0A4(var_1, var_2);
  var_5 = var_3 * var_4;
  var_6 = var_5 + var_0.origin;
  return var_6;
}