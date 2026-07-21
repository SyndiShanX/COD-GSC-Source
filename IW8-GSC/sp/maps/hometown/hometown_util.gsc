/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\hometown\hometown_util.gsc
***********************************************/

wait_any_input(var_0) {
  level.player notifyonplayercommand("stance_pressed", "+stance");
  level.player endon("reload_pressed");
  level.player endon("frag_pressed");
  level.player endon("smoke_pressed");
  level.player endon("melee_pressed");
  level.player endon("sprint_pressed");
  level.player endon("attack_pressed");
  level.player endon("attack_released");
  level.player endon("ads_pressed");
  level.player endon("ads_released");
  level.player endon("focus_pressed");
  level.player endon("focus_released");
  level.player endon("reload_pressed");
  level.player endon("use_pressed");
  level.player endon("jump_pressed");
  level.player endon("weapon_switch_pressed");
  level.player endon("show_hud_button_pressed");
  level.player endon("stance_pressed");

  if(!istrue(var_0)) {
    level.player endon("tried_moving");
    level.player childthread waittill_player_moves();
  }

  level waittill("forever");
}

waittill_player_moves() {
  while(level.player getnormalizedmovement() == (0, 0, 0))
    waitframe();

  level.player notify("tried_moving");
}

register_farah_deaths() {
  scripts\sp\player_death::register_player_death("fire", "stand", "vm_death_yfarah_generic_01", ["player_death_fall_left", "plr_death_flop"], "origin", 0);
  scripts\sp\player_death::register_player_death("default", "stand", "vm_death_yfarah_b_01", ["player_death_fall_left", "plr_death_flop"], "forward", 0);
  scripts\sp\player_death::register_player_death("default", "stand", "vm_death_yfarah_b_02", ["player_death_fall_back", "plr_death_flop"], "forward", 0);
  scripts\sp\player_death::register_player_death("default", "stand", "vm_death_yfarah_f_01", ["player_death_stand_left", "plr_death_flop"], "back", 0);
  scripts\sp\player_death::register_player_death("default", "stand", "vm_death_yfarah_f_02", ["player_death_stand_left", "plr_death_flop"], "back", 0);
  scripts\sp\player_death::register_player_death("default", "stand", "vm_death_yfarah_f_03", ["player_death_stand_left", "plr_death_flop"], "forward", 0);
  scripts\sp\player_death::register_player_death("default", "stand", "vm_death_yfarah_l_01", ["player_death_stand_left", "plr_death_flop"], "left", 0);
  scripts\sp\player_death::register_player_death("default", "stand", "vm_death_yfarah_r_01", ["player_death_stand_left", "plr_death_flop"], "right", 0);
  scripts\sp\player_death::register_player_death("default", "stand", "vm_death_yfarah_generic_01", ["player_death_fall_back", "plr_death_flop"], "origin", 0);
}

force_ai_see_player_square() {
  scripts\engine\sp\utility::trigger_wait("force_ai_alert_trigger_square", "script_noteworthy");
  scripts\engine\utility::flag_set("patrol_cover_blown");

  foreach(var_1 in getaiarray("axis"))
  var_1 aieventlistenerevent("combat", level.player, level.player.origin);
}

force_ai_see_player_car_flank() {
  scripts\engine\sp\utility::trigger_wait("force_ai_alert_trigger_car_flank", "script_noteworthy");
  scripts\engine\utility::flag_set("patrol_cover_blown");

  foreach(var_1 in getaiarray("axis"))
  var_1 aieventlistenerevent("combat", level.player, level.player.origin);
}

force_ai_see_player_gas_start() {
  scripts\engine\sp\utility::trigger_wait("gas_start_enemies_alert_trigger", "script_noteworthy");
  scripts\engine\utility::flag_set("patrol_cover_blown");

  foreach(var_1 in getaiarray("axis"))
  var_1 aieventlistenerevent("combat", level.player, level.player.origin);
}

force_ai_see_player_gas_start_execution() {
  level endon("hadir_ready_to_cross_street");
  scripts\engine\sp\utility::trigger_wait("gas_start_execution_alert_trigger", "script_noteworthy");
  scripts\engine\utility::flag_set("patrol_cover_blown");

  foreach(var_1 in getaiarray("axis"))
  var_1 aieventlistenerevent("combat", level.player, level.player.origin);
}

wait_lookat(var_0, var_1, var_2, var_3, var_4) {
  var_3 = var_3 * 1000;
  var_5 = undefined;

  while(!isDefined(var_5) || gettime() - var_5 < var_3) {
    if(isDefined(var_4))
      wait_near(var_0, var_4);

    var_6 = get_is_looking_at(var_0, var_1, var_2);

    if(var_6 && !isDefined(var_5))
      var_5 = gettime();
    else if(!var_6)
      var_5 = undefined;

    waitframe();
  }
}

get_is_looking_at(var_0, var_1, var_2, var_3) {
  if(isent(var_0) && isDefined(var_2))
    var_4 = var_0 gettagorigin(var_2);
  else if(isent(var_0))
    var_4 = var_0.origin;
  else
    var_4 = var_0;

  var_5 = self worldpointtoscreenpos(var_4, getdvarint("MRNKTKLLKP"));

  if(!isDefined(var_5))
    return 0;

  if(isDefined(var_1) && length2d(var_5) > var_1)
    return 0;

  if(!isDefined(var_3) || var_3) {
    if(isent(var_0))
      var_6 = [self, var_0];
    else
      var_6 = [self];

    var_7 = scripts\engine\trace::ray_trace_passed(self getEye(), var_4, var_6, scripts\engine\trace::create_ainosight_contents());
  } else
    var_7 = 1;

  return var_7;
}

wait_near(var_0, var_1) {
  var_2 = var_1 * var_1;
  var_3 = var_0;

  for(;;) {
    if(isent(var_0))
      var_3 = var_0.origin;

    if(distance2dsquared(self.origin, var_3) < var_2) {
      break;
    }

    waitframe();
  }
}

#using_animtree("generic_human");

make_script_model_civ(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\sp\utility::spawn_anim_model(var_0, var_1.origin, var_1.angles);
  var_5 = ["head_sc_m_mrehin_civ_dust", "head_sc_m_arakelyan_civ_dust", "head_sc_m_bansal_civ_dust", "head_sc_m_alameer_civ_dust", "head_sc_m_haghighi_civ_dust", "head_sc_m_nassernia_civ_dust", "head_sc_m_ahmadzai_civ"];
  var_6 = ["head_sc_m_mrehin_civ_bg_dust", "head_sc_m_arakelyan_civ_bg_dust", "head_sc_m_bansal_civ_bg_dust", "head_sc_m_alameer_civ_bg_dust", "head_sc_m_haghighi_civ_bg_dust", "head_sc_m_nassernia_civ_bg_dust", "head_sc_m_ahmadzai_civ_bg_dust", "head_sc_m_ahmadzai_bg_dust_civ_no_hair"];
  var_7 = ["body_civ_syrkistan_male_1_1", "body_civ_syrkistan_male_2_1", "body_civ_syrkistan_male_3_1", "body_civ_syrkistan_male_4_1", "body_civ_syrkistan_male_5_1", "body_civ_syrkistan_male_6_1", "body_civ_syrkistan_male_7_1", "body_civ_syrkistan_male_10_1"];
  var_8 = ["hat_sc_m_nassernia_headscarf", "hat_sc_m_nassernia_headwrap", "hat_sc_m_nassernia_pakol"];
  var_9 = ["hat_sc_m_bansal_headscarf", "hat_sc_m_bansal_headwrap", "hat_sc_m_bansal_pakol"];
  var_10 = ["hat_sc_m_mrehin_civ_beanie", "hat_sc_m_mrehin_pakol", "hat_sc_m_mrehin_scarf", "hat_sc_m_mrehin_fullwrap"];
  var_11 = ["hat_sc_m_ahmadzai_pakol", "hat_sc_m_ahmadzai_scarf", "hat_sc_m_ahmadzai_fullwrap"];
  var_4 setModel(scripts\engine\utility::random(var_7));
  var_4.headmodel = scripts\engine\utility::random(var_6);
  var_4 attach(var_4.headmodel);

  if(isDefined(var_2))
    level.civ_cleanup_array[level.civ_cleanup_array.size] = var_4;

  if(isDefined(var_3)) {
    var_4 makefakeai();
    var_4.health = 100;
  }

  var_4.fakeactor_face_anim = 1;
  var_4.animationarchetype = "soldier";
  var_4.unittype = "civilian";

  if(getdvarint("scr_use_procedural_bones")) {
    var_4 setanim(%proc_node, 1.0, 0.0);
    var_4.anim_getrootfunc = scripts\asm\gesture\script_funcs::set_root;
  }

  if(var_4.headmodel == "head_sc_m_nassernia_civ_bg_dust") {
    var_4.hatmodel = scripts\engine\utility::random(var_8);
    var_4 attach(var_4.hatmodel);
  }

  if(var_4.headmodel == "head_sc_m_bansal_civ_bg_dust") {
    var_4.hatmodel = scripts\engine\utility::random(var_9);
    var_4 attach(var_4.hatmodel);
  }

  if(var_4.headmodel == "head_sc_m_mrehin_bg_dust_civ_no_hair") {
    var_4.hatmodel = scripts\engine\utility::random(var_10);
    var_4 attach(var_4.hatmodel);
  }

  if(var_4.headmodel == "head_sc_m_ahmadzai_bg_dust_civ_no_hair") {
    var_4.hatmodel = scripts\engine\utility::random(var_11);
    var_4 attach(var_4.hatmodel);
  }

  return var_4;
}

make_script_model_civ_wh(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\sp\utility::spawn_anim_model(var_0, var_1.origin, var_1.angles);
  var_5 = ["head_sc_m_ahmadzai_civ_helmet_dust", "head_sc_m_alameer_civ_helmet_dust", "head_sc_m_kargorgis_civ_helmet_dust", "head_sc_m_yurteri_civ_helmet_dust"];
  var_6 = ["head_sc_m_ahmadzai_civ_helmet_bg_dust", "head_sc_m_alameer_civ_helmet_bg_dust", "head_sc_m_kargorgis_civ_helmet_bg_dust", "head_sc_m_yurteri_civ_helmet_bg_dust"];
  var_7 = ["body_white_helmets_male_1", "body_white_helmets_male_2", "body_white_helmets_male_3"];
  var_4 setModel(scripts\engine\utility::random(var_7));
  var_4 attach(scripts\engine\utility::random(var_6));

  if(isDefined(var_2))
    level.civ_cleanup_array[level.civ_cleanup_array.size] = var_4;

  if(isDefined(var_3)) {
    var_4 makefakeai();
    var_4.health = 100;
  }

  var_4.fakeactor_face_anim = 1;
  var_4.animationarchetype = "soldier";
  var_4.unittype = "civilian";

  if(getdvarint("scr_use_procedural_bones")) {
    var_4 setanim(%proc_node, 1.0, 0.0);
    var_4.anim_getrootfunc = scripts\asm\gesture\script_funcs::set_root;
  }

  return var_4;
}

make_script_model_civ_female(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\sp\utility::spawn_anim_model(var_0, var_1.origin, var_1.angles);
  var_5 = ["head_sc_f_toyouri_civ_dust", "head_sc_f_rezaee_civ_dust", "head_sc_f_eghbali_civ_dust", "head_sc_f_mostafavi_civ"];
  var_6 = ["head_sc_f_toyouri_civ_bg_no_hair_dust", "head_sc_f_rezaee_civ_bg_dust", "head_sc_f_eghbali_civ_bg_dust"];
  var_7 = ["body_civ_syrkistan_female_1_2", "body_civ_syrkistan_female_5_1", "body_civ_syrkistan_female_5_2", "body_civ_syrkistan_female_6_1", "body_civ_syrkistan_female_6_2", "body_civ_syrkistan_female_8_2", "body_civ_syrkistan_female_10_1", "body_civ_syrkistan_female_10_2"];
  var_4 setModel(scripts\engine\utility::random(var_7));
  var_4 attach(scripts\engine\utility::random(var_6));

  if(isDefined(var_2))
    level.civ_cleanup_array[level.civ_cleanup_array.size] = var_4;

  if(isDefined(var_3)) {
    var_4 makefakeai();
    var_4.health = 100;
  }

  var_4.fakeactor_face_anim = 1;
  var_4.animationarchetype = "soldier";
  var_4.unittype = "civilian";

  if(getdvarint("scr_use_procedural_bones")) {
    var_4 setanim(%proc_node, 1.0, 0.0);
    var_4.anim_getrootfunc = scripts\asm\gesture\script_funcs::set_root;
  }

  return var_4;
}

make_script_model_civ_child(var_0, var_1, var_2) {
  var_3 = scripts\engine\sp\utility::spawn_anim_model(var_0, var_1.origin, var_1.angles);
  var_4 = ["head_sc_m_naficy_civ_dust", "head_sc_m_ahmed_civ", "head_sc_m_choudhary_civ"];
  var_5 = ["head_sc_m_naficy_civ_bg_dust"];
  var_6 = ["body_civ_syrkistan_boy_2_1", "body_civ_syrkistan_boy_3_1", "body_civ_syrkistan_boy_4_1", "body_civ_syrkistan_boy_5_1", "body_civ_syrkistan_boy_6_1"];
  var_3 setModel(scripts\engine\utility::random(var_6));
  var_3 attach(scripts\engine\utility::random(var_5));

  if(isDefined(var_2))
    level.civ_cleanup_array[level.civ_cleanup_array.size] = var_3;

  var_3.fakeactor_face_anim = 1;
  var_3.animationarchetype = "soldier";
  var_3.unittype = "civilian";

  if(getdvarint("scr_use_procedural_bones")) {
    var_3 setanim(%proc_node, 1.0, 0.0);
    var_3.anim_getrootfunc = scripts\asm\gesture\script_funcs::set_root;
  }

  return var_3;
}

make_script_model_civ_child_female(var_0, var_1, var_2) {
  var_3 = scripts\engine\sp\utility::spawn_anim_model(var_0, var_1.origin, var_1.angles);
  var_4 = ["head_sc_f_roa_dust", "head_sc_f_fausto_dust", "head_sc_f_kohli_dust"];
  var_5 = ["head_sc_f_roa_bg_dust", "head_sc_f_fausto_bg_dust", "head_sc_f_kohli_bg_dust"];
  var_6 = ["body_civ_syrkistan_girl_1_1", "body_civ_syrkistan_girl_2_1", "body_civ_syrkistan_girl_3_1", "body_civ_syrkistan_girl_4_1", "body_civ_syrkistan_girl_5_1", "body_civ_syrkistan_girl_6_1"];
  var_3 setModel(scripts\engine\utility::random(var_6));
  var_3 attach(scripts\engine\utility::random(var_5));

  if(isDefined(var_2))
    level.civ_cleanup_array[level.civ_cleanup_array.size] = var_3;

  var_3.fakeactor_face_anim = 1;
  var_3.animationarchetype = "soldier";
  var_3.unittype = "civilian";

  if(getdvarint("scr_use_procedural_bones")) {
    var_3 setanim(%proc_node, 1.0, 0.0);
    var_3.anim_getrootfunc = scripts\asm\gesture\script_funcs::set_root;
  }

  return var_3;
}

make_script_model_russian(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\sp\utility::spawn_anim_model(var_0, var_1.origin, var_1.angles);
  var_5 = ["head_russian_army_balaclava_1", "head_russian_army_balaclava_2"];
  var_6 = ["body_russian_army_ar_1", "body_russian_army_ar_2"];
  var_4 setModel(scripts\engine\utility::random(var_6));
  var_4 attach(scripts\engine\utility::random(var_5));

  if(isDefined(var_2))
    level.civ_cleanup_array[level.civ_cleanup_array.size] = var_4;

  var_4.gun_model = spawn("script_model", var_4.origin);
  var_4.gun_model setModel("attachment_wm_receiver_akilo47");
  var_4.gun_model attach("attachment_wm_stock_akilo47");
  var_4.gun_model attach("attachment_wm_barrel_akilo47");
  var_4.gun_model attach("attachment_wm_mag_akilo47");

  if(isDefined(var_3))
    var_4.gun_model attach("attachment_wm_ub_gpapa25");

  var_4.gun_model linkTo(var_4, "tag_accessory_right", (0, 0, 0), (0, 0, 0));
  var_4.fakeactor_face_anim = 1;
  var_4.animationarchetype = "soldier";
  var_4.unittype = "civilian";

  if(getdvarint("scr_use_procedural_bones")) {
    var_4 setanim(%proc_node, 1.0, 0.0);
    var_4.anim_getrootfunc = scripts\asm\gesture\script_funcs::set_root;
  }

  return var_4;
}

shoot_gun_from_notetrack(var_0) {
  var_1 = self.gun_model gettagorigin("tag_flash");
  var_2 = var_1 + anglesToForward(self.gun_model gettagangles("tag_flash")) * 50;
  magicbullet("iw8_ar_akilo47_silent", var_1, var_2);
  playFXOnTag(level._effect["vfx_muz_ar_w"], self.gun_model, "tag_flash");
}

shoot_gun_from_notetrack_player(var_0) {
  var_1 = level.goliath_ai gettagorigin("tag_flash");
  var_2 = var_1 + anglesToForward(level.goliath_ai gettagangles("tag_flash")) * 50;
  magicbullet("iw8_ar_akilo47_silent", var_1, var_2);
  playFXOnTag(level._effect["vfx_muz_ar_w"], level.goliath_ai, "tag_flash");
  level.player playSound("weap_akilo47j12_fire_plr");
  level.player playSound("weap_akilo47j12_fire_plr_atmo");
  level.player playRumbleOnEntity("damage_bullet");
}

shoot_gas_grenade_from_notetrack(var_0) {
  var_1 = self.gun_model gettagorigin("tag_flash");
  var_2 = self.gun_model gettagorigin("tag_flash");
  playFXOnTag(level._effect["vfx_htown_gas_muzzleflash"], self.gun_model, "tag_flash");
  self.gun_model thread scripts\engine\sp\utility::play_sound_on_tag("ht_weap_mike203_fire_npc_med", "tag_flash");

  if(level.gas_trail_ground_done == 0) {
    scripts\engine\utility::exploder("gas_attack_amb");
    level.gas_trail_ground_done = 1;
  }
}

weapon_monitor() {
  level notify("weapon_monitor");
  level endon("weapon_monitor");
  level.player scripts\sp\utility::context_melee_allow_blocked_hint(0);

  for(;;) {
    level.player waittill("knife_change");

    if(scripts\engine\sp\utility::player_has_weapon("iw8_knife_kid") || scripts\engine\sp\utility::player_has_weapon("iw8_knife_kid_rebar") || scripts\engine\sp\utility::player_has_weapon("iw8_knife_kid_screwdriver") || scripts\engine\sp\utility::player_has_weapon("iw8_knife_kid_scissors")) {
      level.player scripts\sp\utility::context_melee_allow_blocked_hint(1);
      continue;
    }

    level.player scripts\sp\utility::context_melee_allow_blocked_hint(0);
  }
}

battlechatter_off_spawn_func() {
  self endon("death");

  while(!istrue(self.battlechatterallowed))
    wait 0.1;

  scripts\engine\sp\utility::set_battlechatter(0);
}

goliath_spawn_func() {
  self.goalradius = 50;
  self.disablepistol = 1;
  self.baseaccuracy = 1.0;
  self.combatmode = "no_cover";
  self.script_combatmode = "no_cover";
  self.allowdeath = 0;
  self.allowpain = 0;
  self.animname = "generic";
  self.keepstealthoncontextmelee = 1;
  self.battlechatterallowed = 0;
  self.noarmor = 1;
  self.aggressivemode = 1;
  self.disableaimchangetime = 99999999;
  self.a.nextmeleechargesound = 9999999;
  self.stealthforcegundown = 1;
  self.meleeignoreplayerstance = 1;
  self.usemuzzlesideoffset = 1;
  scripts\engine\sp\utility::set_grenadeammo(0);
  level.goliath_boss = 1;
  level.goliath_boss_round = 0;
  scripts\sp\maps\hometown\goliath_stealth.gsc::goliath_setup_stealth();
  self.proximity_bump_dist_sqr_override = 900;
  self.context_melee_back_dot_override = -0.5;
  self.smartobjectnotetrackhandle = ::goliath_smartobject_notetrack_handler;
  thread battlechatter_off_spawn_func();
  thread goliath_flashlight();
  wait 1.0;
  thread scripts\common\ai::magic_bullet_shield(1);
  self.stealth.funcs["event_investigate"] = ::goliath_stealth_filter;
  self.stealth.funcs["event_cover_blown"] = ::goliath_stealth_filter;
  self.stealth.funcs["event_combat"] = ::goliath_stealth_filter;
  self[[self.fnsetstealthstate]]("hunt", undefined);
  var_0 = scripts\stealth\group::getgroup(self.script_stealthgroup);
  var_1 = scripts\stealth\group::group_findpod(var_0, self);
  var_1.borigininvestigated = 1;
  var_2 = scripts\sp\utility::make_weapon("iw8_ar_akilo47_goliath", ["reflexstable_west01", "barsmg_akilo47", "calsmg_akilo47_sp", "taclight", "gripvert_akilo47"]);
  scripts\anim\shared.gsc::forceuseweapon(var_2, "primary");
  self.fnshouldplaypainanim = ::wasaimeleedbyplayer;
  self removeaieventlistener("footstep_sprint");
}

goliath_flashlight() {
  wait 1;
  self.flashlightfxoverridetag = "tag_light";
  scripts\sp\nvg\nvg_ai::flashlight_off(1);
  scripts\sp\nvg\nvg_ai::flashlight_on(1);
}

goliath_stealth_filter(var_0) {
  if(scripts\engine\utility::is_equal(var_0.entity, self))
    return 1;

  return 0;
}

goliath_smartobject_notetrack_handler(var_0) {
  level endon("boss_dying");

  switch (var_0) {
    case "knock_off":
      var_1 = level.goliath_ai gettagorigin("j_wrist_le");
      physicsexplosionsphere(var_1, 15, 10, 50);
      break;
    case "spawn_entity":
      var_2 = level.goliath_ai gettagangles("j_mainroot");
      var_2 = anglesToForward(var_2);
      var_3 = level.goliath_ai.origin + (0, 0, 36) + anglesToForward(level.goliath_ai.angles) * 15;
      var_4 = spawn("script_model", var_3);
      var_5 = [0, 1, 2];
      var_6 = 0;

      for(var_7 = scripts\engine\utility::random(var_5); level.goliath_melee_weapon_spawn_count == var_7 && var_6 < 30; var_6++)
        var_7 = scripts\engine\utility::random(var_5);

      level.goliath_melee_weapon_spawn_count = var_7;

      if(level.current_knock_off == "drop_all")
        var_8 = scripts\engine\utility::random(["iw8_knife_kid", "iw8_knife_kid_screwdriver", "iw8_knife_kid_scissors"]);
      else if(level.current_knock_off == "drop_scissors_only")
        var_8 = scripts\engine\utility::random(["iw8_knife_kid_scissors"]);
      else if(level.current_knock_off == "drop_screwdriver_only")
        var_8 = scripts\engine\utility::random(["iw8_knife_kid_screwdriver"]);
      else if(level.current_knock_off == "drop_knife_only")
        var_8 = scripts\engine\utility::random(["iw8_knife_kid"]);
      else if(level.current_knock_off == "drop_scissors_screwdriver")
        var_8 = scripts\engine\utility::random(["iw8_knife_kid_screwdriver", "iw8_knife_kid_scissors"]);
      else if(level.current_knock_off == "drop_scissors_knife")
        var_8 = scripts\engine\utility::random(["iw8_knife_kid", "iw8_knife_kid_scissors"]);
      else if(level.current_knock_off == "drop_screwdriver_knife")
        var_8 = scripts\engine\utility::random(["iw8_knife_kid", "iw8_knife_kid_screwdriver"]);
      else
        var_8 = scripts\engine\utility::random(["iw8_knife_kid", "iw8_knife_kid_screwdriver", "iw8_knife_kid_scissors"]);

      if(var_8 == "iw8_knife_kid")
        var_4 setModel("weapon_wm_me_kitchen_knife");
      else if(var_8 == "iw8_knife_kid_screwdriver")
        var_4 setModel("weapon_wm_me_screwdriver");
      else if(var_8 == "iw8_knife_kid_scissors")
        var_4 setModel("weapon_wm_me_scissors");
      else
        var_4 setModel("weapon_wm_me_kitchen_knife");

      var_9 = anglesToForward(var_2);
      var_9 = var_9 * randomfloatrange(20, 25) * -1;
      var_10 = var_9[0];
      var_11 = 10;
      var_12 = 10;
      var_4 physicslaunchserver(var_4.origin, (var_10, var_11, var_12));
      thread goliath_melee_weapon_spawn_interact(var_4, var_8);
      break;
    case "kick":
      earthquake(0.5, 1, self gettagorigin("j_ball_ri"), 30);
      var_13 = self.asm.smartobject;
      var_14 = [];

      foreach(var_16 in var_13 scripts\engine\utility::get_linked_ents()) {
        if(scripts\engine\utility::is_equal(var_16.script_noteworthy, "kick_obj")) {
          if(!isDefined(var_16.animname)) {
            var_16.animname = var_16.script_animname;
            var_16 scripts\engine\sp\utility::assign_animtree();
          }

          if(!isDefined(var_16.clip) && isDefined(var_16.target)) {
            var_16.clip = getEnt(var_16.target, "targetname");
            var_16.clip linkTo(var_16);
            waittillframeend;
          }

          var_13 thread scripts\common\anim::anim_single_solo(var_16, "kick");
        }
      }

      break;
    case "kick_left":
      earthquake(0.5, 1, self gettagorigin("j_ball_le"), 30);
      break;
    case "bash":
      earthquake(0.5, 1, self gettagorigin("tag_stock_attach") - anglesToForward(self gettagangles("tag_stock_attach")) * 9, 30);
      break;
    case "punch":
      earthquake(0.5, 1, self gettagorigin("j_elbow_le"), 30);
      break;
  }
}

goliath_bloody_footsteps(var_0) {
  var_1 = "soldier";
  var_2 = scripts\engine\utility::getfx("bloody_footprint");
  scripts\anim\utility.gsc::setfootprinteffect(var_1, "snow", var_2);
  scripts\anim\utility.gsc::setfootprinteffect(var_1, "ice", var_2);
  scripts\anim\utility.gsc::setfootprinteffect(var_1, "asphalt_dry", var_2);
  scripts\anim\utility.gsc::setfootprinteffect(var_1, "dirt", var_2);
  scripts\anim\utility.gsc::setfootprinteffect(var_1, "foliage", var_2);
  scripts\anim\utility.gsc::setfootprinteffect(var_1, "grass", var_2);
  scripts\anim\utility.gsc::setfootprinteffect(var_1, "gravel", var_2);
  scripts\anim\utility.gsc::setfootprinteffect(var_1, "mud", var_2);
  scripts\anim\utility.gsc::setfootprinteffect(var_1, "rock", var_2);
  scripts\anim\utility.gsc::setfootprinteffect(var_1, "sand", var_2);
  scripts\anim\utility.gsc::setfootprinteffect(var_1, "water", var_2);
  scripts\anim\utility.gsc::setfootprinteffect(var_1, "default", var_2);
  scripts\anim\utility.gsc::setfootprinteffect(var_1, "wood_floor", var_2);
}

clear_goliath_bloody_footsteps() {
  scripts\anim\utility.gsc::unsetfootprinteffect("snow");
  scripts\anim\utility.gsc::unsetfootprinteffect("ice");
  scripts\anim\utility.gsc::unsetfootprinteffect("asphalt_dry");
  scripts\anim\utility.gsc::unsetfootprinteffect("dirt");
  scripts\anim\utility.gsc::unsetfootprinteffect("foliage");
  scripts\anim\utility.gsc::unsetfootprinteffect("grass");
  scripts\anim\utility.gsc::unsetfootprinteffect("gravel");
  scripts\anim\utility.gsc::unsetfootprinteffect("mud");
  scripts\anim\utility.gsc::unsetfootprinteffect("rock");
  scripts\anim\utility.gsc::unsetfootprinteffect("sand");
  scripts\anim\utility.gsc::unsetfootprinteffect("water");
  scripts\anim\utility.gsc::unsetfootprinteffect("default");
  scripts\anim\utility.gsc::unsetfootprinteffect("wood_floor");
}

goliath_melee_weapon_spawn_interact(var_0, var_1) {
  wait 1.0;
  var_0 thread goliath_melee_weapon_interact(var_1);
}

kill_quietly(var_0) {
  self.skipdeathanim = 1;
  self.noragdoll = 1;
  self pushplayer(0);
  self.allowdeath = 1;
  self.diequietly = 1;

  if(isDefined(self.magic_bullet_shield))
    scripts\common\ai::stop_magic_bullet_shield();

  self kill((0, 0, 0), var_0, var_0);
}

kill_and_delete_quietly(var_0) {
  self.skipdeathanim = 1;
  self.noragdoll = 1;
  self pushplayer(0);
  self.allowdeath = 1;
  self.diequietly = 1;

  if(isDefined(self.magic_bullet_shield))
    scripts\common\ai::stop_magic_bullet_shield();

  self kill((0, 0, 0), var_0, var_0);
  self delete();
}

spawn_father() {
  var_0 = getspawner("farah_father", "script_noteworthy");
  var_0 scripts\engine\sp\utility::add_spawn_function(::father_spawn_func);
  level.farah_father_ai = var_0 scripts\engine\sp\utility::spawn_ai(1);
  level.farah_father_ai.anim_playvo_func = scripts\engine\utility::playsoundontag;
}

spawn_hadir() {
  var_0 = getspawner("hadir_spawner", "script_noteworthy");
  var_0.count = 2;
  var_0 scripts\engine\sp\utility::add_spawn_function(::hadir_spawn_func);
  level.hadir_ai = var_0 scripts\engine\sp\utility::spawn_ai(1);
  level.hadir_ai.anim_playvo_func = scripts\engine\utility::playsoundontag;
}

spawn_goliath_boss() {
  var_0 = getspawner("goliath_spawner", "script_noteworthy");
  var_0 scripts\engine\sp\utility::add_spawn_function(::goliath_spawn_func);
  level.goliath_ai = var_0 scripts\engine\sp\utility::spawn_ai(1);
  level.goliath_ai.anim_playvo_func = scripts\engine\utility::playsoundontag;
}

hadir_spawn_func() {
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.goalradius = 40;
  self setgoalpos(self.origin);
  scripts\common\ai::gun_remove();
  self.bt.cannotmelee = 1;
  self.animname = "hadir";
  self.allowdeath = 0;
  self.name = "";
  self._blackboard.civstate = "stealth";
  self.script_pushable = 0;
  self pushplayer(1);
  self.dontchangepushplayer = 1;
  self.fixednodesaferadius = 0;
  self.useslopes = 0;
  wait 1.0;
  scripts\common\ai::magic_bullet_shield(1);
  self.gestureinterruptible = 1;
}

father_spawn_func() {
  self.ignoreall = 1;
  self.goalradius = 40;
  self setgoalpos(self.origin);
  scripts\common\ai::gun_remove();
  self.bt.cannotmelee = 1;
  self.allowdeath = 1;
  self.name = "";
  self.animname = "farah_father";
  self._blackboard.civstate = "stealth";
  self._blackboard.requestedspeed = 56;
  self allowedstances("stand");
  self.script_pushable = 0;
  self pushplayer(1);
  self.useslopes = 0;
  scripts\common\ai::magic_bullet_shield(1);
}

russian_patroller_spawn_func() {
  self.combatmode = "no_cover";
  self.noarmor = 1;
  self.baseaccuracy = 10;

  if(!isDefined(self.stealth.funcs))
    self.stealth.funcs = [];

  self.stealth.funcs["event_investigate"] = ::russian_patroller_stealth_filter;
  self.stealth.funcs["event_cover_blown"] = ::russian_patroller_stealth_filter;
  self.stealth.funcs["event_combat"] = ::russian_patroller_stealth_filter;
  self.ignoreforfixednodesafecheck = 1;
  scripts\engine\sp\utility::battlechatter_off();
  wait 0.5;
  self removeaieventlistener("footstep_sprint");
  self.fnshouldplaypainanim = ::wasaimeleedbyplayer;
}

wasaimeleedbyplayer() {
  if(isDefined(self.lastattacker)) {
    if(scripts\engine\utility::is_equal(self.lastattacker, level.player)) {
      if(isDefined(self.damagemod)) {
        if(self.damagemod == "MOD_MELEE")
          return 0;
      }
    }
  }

  return 1;
}

russian_patroller_stealth_filter(var_0) {
  scripts\engine\sp\utility::battlechatter_on();

  if(var_0.type == "investigate") {
    scripts\engine\utility::thread_on_notify("stealth_idle", scripts\engine\sp\utility::battlechatter_off);
    thread russian_patroller_investigate();
    return 0;
  }

  if(var_0.type == "cover_blown")
    var_0.type = "combat";

  scripts\engine\utility::flag_set("patrol_cover_blown");
  return 0;
}

russian_patroller_investigate() {
  self endon("stealth_idle");
  self endon("stealth_combat");
  var_0 = scripts\engine\trace::create_contents(1, 1, 0, 1, 1, 1, 0, 1, 1);

  for(;;) {
    wait 0.2;

    if(!scripts\engine\utility::within_fov(self.origin, self.angles, level.hadir_ai.origin, 0.5)) {
      continue;
    }
    if(!scripts\engine\utility::can_trace_to_ai(self getEye(), level.hadir_ai, undefined, var_0)) {
      continue;
    }
    self aieventlistenerevent("combat", level.player, level.hadir_ai.origin);
    return;
  }
}

russian_patroller_spawn_func_no_flashlight() {
  self.combatmode = "no_cover";
  self.noarmor = 1;

  if(!isDefined(self.stealth.funcs))
    self.stealth.funcs = [];

  self.stealth.funcs["event_investigate"] = ::poppies_enemy_stealth_filter;
  self.stealth.funcs["event_cover_blown"] = ::poppies_enemy_stealth_filter;
  self.stealth.funcs["event_combat"] = ::poppies_enemy_stealth_filter;
}

russian_patroller_spawn_func_no_flashlight_ignore() {
  self.combatmode = "no_cover";
  self.noarmor = 1;
  self.ignoreall = 1;

  if(!isDefined(self.stealth.funcs))
    self.stealth.funcs = [];

  self.stealth.funcs["event_investigate"] = ::poppies_enemy_stealth_filter;
  self.stealth.funcs["event_cover_blown"] = ::poppies_enemy_stealth_filter;
  self.stealth.funcs["event_combat"] = ::poppies_enemy_stealth_filter;
}

poppies_enemy_stealth_filter(var_0) {
  if(var_0.typeorig == "gunshot" || var_0.typeorig == "bulletwhizby" || var_0.typeorig == "gunshot_teammate")
    return 1;

  return 0;
}

search_ground_hint() {
  level.player endon("player_found_a_weapon");
  scripts\engine\utility::flag_wait("goliath_weapon_exists");
  wait 120.0;
  scripts\engine\utility::flag_set("goliath_weapon_exists_hint");
  scripts\sp\utility::context_melee_set_hint_directions(["back", "left", "right", "front"]);
  scripts\engine\sp\utility::display_hint("search_ground_hint", 30, 0, [level.player], ["player_found_a_weapon"]);
}

goliath_melee_weapon_interact(var_0) {
  if(var_0 == "iw8_knife_kid")
    var_1 = &"HOMETOWN/KNIFE";
  else if(var_0 == "iw8_knife_kid_rebar")
    var_1 = &"HOMETOWN/BRICK";
  else if(var_0 == "iw8_knife_kid_scissors")
    var_1 = &"HOMETOWN/SCISSORS";
  else if(var_0 == "iw8_knife_kid_screwdriver")
    var_1 = &"HOMETOWN/SCREWDRIVER";
  else
    var_1 = &"HOMETOWN/KNIFE";

  var_2 = scripts\engine\utility::spawn_tag_origin(self.origin);
  var_2 scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", (0, 0, 0), var_1, 75, 175, 50, 0);
  level.goliath_weapon_interacts_array[level.goliath_weapon_interacts_array.size] = var_2;
  level.goliath_weapon_exists = "true";
  scripts\engine\utility::flag_set("goliath_weapon_exists");
  var_3 = 0;

  while(var_3 == 0) {
    var_2 waittill("trigger");
    level.player playSound("scn_hometown_stab_weap_pickup");
    scripts\engine\utility::flag_set("objective_kill_the_soldier");

    if(scripts\engine\sp\utility::player_has_weapon("iw8_knife_kid") || scripts\engine\sp\utility::player_has_weapon("iw8_knife_kid_rebar") || scripts\engine\sp\utility::player_has_weapon("iw8_knife_kid_screwdriver") || scripts\engine\sp\utility::player_has_weapon("iw8_knife_kid_scissors")) {
      goliath_melee_weapon_swap();
      waitframe();
      level.player takeallweapons();
      waitframe();
      var_3 = 1;
      continue;
    }

    var_3 = 1;
  }

  level.player_found_a_weapon = "true";
  level.player notify("player_found_a_weapon");
  var_2 delete();
  level.player giveweapon(var_0);
  level.player switchtoweapon(var_0);
  level.player notify("knife_change");

  if(scripts\sp\autosave::autosavethreatcheck(1))
    thread scripts\engine\sp\utility::autosave_by_name("got_melee_weapon");

  self delete();
}

goliath_melee_weapon_swap() {
  level endon("boss_dying");
  var_0 = level.player gettagangles("tag_origin");
  var_0 = anglesToForward(var_0);

  if(level.player getstance() == "prone")
    var_1 = level.player.origin + (0, 0, 3) + anglesToForward(level.player.angles) * 15;
  else if(level.player getstance() == "crouch")
    var_1 = level.player.origin + (0, 0, 10) + anglesToForward(level.player.angles) * 15;
  else
    var_1 = level.player.origin + (0, 0, 20) + anglesToForward(level.player.angles) * 15;

  var_2 = spawn("script_model", var_1);

  if(scripts\engine\sp\utility::player_has_weapon("iw8_knife_kid_scissors")) {
    var_3 = "iw8_knife_kid_scissors";
    var_2 setModel("weapon_wm_me_scissors");
  } else if(scripts\engine\sp\utility::player_has_weapon("iw8_knife_kid_screwdriver")) {
    var_3 = "iw8_knife_kid_screwdriver";
    var_2 setModel("weapon_wm_me_screwdriver");
  } else if(scripts\engine\sp\utility::player_has_weapon("iw8_knife_kid")) {
    var_3 = "iw8_knife_kid";
    var_2 setModel("weapon_wm_me_kitchen_knife");
  } else {
    var_3 = "iw8_knife_kid";
    var_2 setModel("weapon_wm_me_kitchen_knife");
  }

  var_4 = anglesToForward(var_0);
  var_4 = var_4 * randomfloatrange(20, 25) * -1;
  var_5 = var_4[0];
  var_6 = 10;
  var_7 = 10;
  var_2 physicslaunchserver(var_2.origin, (var_5, var_6, var_7));
  thread goliath_melee_weapon_spawn_interact(var_2, var_3);
}

goliath_delete_weapon_interacts_monitor() {
  level.goliath_weapon_interacts_array = [];
  level waittill("clean_up_goliath_interacts");
  var_0 = scripts\engine\utility::array_removeundefined(level.goliath_weapon_interacts_array);

  foreach(var_2 in var_0) {
    if(isDefined(var_2))
      var_2 delete();
  }
}

play_anim_and_delete(var_0, var_1) {
  scripts\common\anim::anim_single_solo(var_0, var_1);
  var_0 delete();
}

play_anim_and_then_loop(var_0, var_1, var_2) {
  self endon("stop_play_anim_and_then_loop");
  self notify("stop_loop");
  scripts\common\anim::anim_single_solo(var_0, var_1);
  self notify("loop_started");
  thread scripts\common\anim::anim_loop_solo(var_0, var_2);
}

play_anim_and_then_loop_with_nags(var_0, var_1, var_2) {
  self endon("stop_play_anim_and_then_loop");
  self notify("stop_loop");
  scripts\common\anim::anim_single_solo(var_0, var_1);

  for(;;) {
    scripts\common\anim::anim_single_solo(var_0, var_2 + "_nags");
    thread scripts\common\anim::anim_loop_solo(var_0, var_2);
    wait 3.0;
    self notify("stop_loop");
  }
}

play_anim_and_then_last_frame(var_0, var_1) {
  self endon("stop_play_anim_and_then_loop");
  self notify("stop_loop");
  scripts\common\anim::anim_single_solo(var_0, var_1);
  scripts\common\anim::anim_last_frame_solo(var_0, var_1);
}

spawn_dude_play_anim_and_delete(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isDefined(var_7)) {
    if(var_2 == "male")
      var_10 = make_script_model_civ(var_0, self);
    else if(var_2 == "russian_male")
      var_10 = make_script_model_russian(var_0, self);
    else if(var_2 == "child_male")
      var_10 = make_script_model_civ_child(var_0, self);
    else if(var_2 == "child_female")
      var_10 = make_script_model_civ_child_female(var_0, self);
    else if(var_2 == "female")
      var_10 = make_script_model_civ_female(var_0, self);
    else if(var_2 == "white_helmet")
      var_10 = make_script_model_civ_wh(var_0, self);
    else {
      var_10 = scripts\engine\sp\utility::spawn_anim_model(var_0, self.origin, self.angles);
      var_10.fakeactor_face_anim = 1;
      var_10.animationarchetype = "soldier";
    }
  } else {
    var_10 = scripts\engine\sp\utility::spawn_anim_model(var_0, self.origin, self.angles);
    var_10.fakeactor_face_anim = 1;
    var_10.animationarchetype = "soldier";
  }

  if(isDefined(var_4)) {
    level.square_dudes_hide_array[level.square_dudes_hide_array.size] = var_10;
    var_10 hide();
  }

  if(isDefined(var_5)) {
    var_10 makefakeai();
    var_10.health = 100;
  }

  if(isDefined(var_6))
    var_10 setModel(var_6);

  if(isDefined(var_7))
    var_10 attach(var_7);

  if(!isDefined(var_10.hatmodel)) {
    if(isDefined(var_9))
      var_10 attach(var_9);
  }

  var_10 scripts\engine\utility::delaythread(1.0, ::hometown_print3d_on_me);
  thread spawn_dude_play_anim_and_delete_animate(var_10, var_1, var_8, var_3);
  return var_10;
}

spawn_dude_play_anim_and_delete_animate(var_0, var_1, var_2, var_3) {
  if(isDefined(var_2)) {
    scripts\common\anim::anim_first_frame_solo(var_0, var_1);
    level waittill(var_2);
  }

  scripts\common\anim::anim_single_solo(var_0, var_1);

  if(isDefined(var_3)) {
    if(var_3) {
      if(isDefined(var_0.gun_model))
        var_0.gun_model delete();

      var_0 delete();
    }
  }

  if(!isDefined(var_3)) {
    if(isDefined(var_0.gun_model))
      var_0.gun_model delete();

    var_0 delete();
  }
}

hometown_print3d_on_me() {
  self endon("death");
}

spawn_dude_loop_anim(var_0, var_1, var_2, var_3) {
  if(var_2 == "male")
    var_4 = make_script_model_civ(var_0, self);
  else if(var_2 == "russian_male")
    var_4 = make_script_model_russian(var_0, self);
  else if(var_2 == "child_male")
    var_4 = make_script_model_civ_child(var_0, self);
  else {
    var_4 = scripts\engine\sp\utility::spawn_anim_model(var_0, self.origin, self.angles);
    var_4.fakeactor_face_anim = 1;
    var_4.animationarchetype = "soldier";
  }

  level.civ_cleanup_array[level.civ_cleanup_array.size] = var_4;
  thread scripts\common\anim::anim_loop_solo(var_4, var_1, var_3);
  return var_4;
}

spawn_dude_play_anim(var_0, var_1, var_2) {
  if(var_2 == "male")
    var_3 = make_script_model_civ(var_0, self);
  else if(var_2 == "russian_male")
    var_3 = make_script_model_russian(var_0, self);
  else {
    var_3 = scripts\engine\sp\utility::spawn_anim_model(var_0, self.origin, self.angles);
    var_3.fakeactor_face_anim = 1;
    var_3.animationarchetype = "soldier";
  }

  scripts\common\anim::anim_loop_solo(var_3, var_1);
  return var_3;
}

spawn_thing_play_anim_and_delete(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\sp\utility::spawn_anim_model(var_0, self.origin, self.angles);

  if(isDefined(var_3)) {
    level.square_dudes_hide_array[level.square_dudes_hide_array.size] = var_4;
    var_4 hide();
  }

  var_4 scripts\engine\utility::delaythread(1.0, ::hometown_print3d_on_me);
  scripts\common\anim::anim_single_solo(var_4, var_1);

  if(isDefined(var_2)) {
    if(var_2)
      var_4 delete();
  }

  if(!isDefined(var_2))
    var_4 delete();
}

spawn_thing_play_anim_and_last_frame(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\sp\utility::spawn_anim_model(var_0, self.origin, self.angles);

  if(isDefined(var_3)) {
    level.square_dudes_hide_array[level.square_dudes_hide_array.size] = var_4;
    var_4 hide();
  }

  var_4 scripts\engine\utility::delaythread(1.0, ::hometown_print3d_on_me);
  scripts\common\anim::anim_single_solo(var_4, var_1);
  scripts\common\anim::anim_last_frame_solo(var_4, var_1);
}

autosave_setup_hometown() {
  level.autosave.proximity_threat_func = ::autosave_proximity_threat_func_hometown;
}

autosaveprint_hometown(var_0, var_1, var_2) {}

getcanshootandsee_hometown() {
  return scripts\anim\utility_common.gsc::canseeenemy(0) && self canshootenemy(0);
}

autosave_proximity_threat_func_hometown(var_0) {
  foreach(var_2 in level.players) {
    var_3 = distancesquared(var_0.origin, var_2.origin);

    if(var_3 < 10000)
      return "return_even_if_low_accuracy";
    else if(var_3 < 129600)
      return "return";
    else if(var_3 < 1000000)
      return "threat_exists";
  }

  return "none";
}

autosavethreatcheck_hometown(var_0, var_1) {
  var_2 = getaiunittypearray("bad_guys", "all");

  foreach(var_4 in var_2) {
    if(isDefined(level.player.stealth) && isDefined(var_4.stealth) && var_4.threatsight && var_4 getthreatsight(level.player) > 0)
      return 0;

    if(!isDefined(var_4.enemy)) {
      continue;
    }
    if(!isPlayer(var_4.enemy)) {
      continue;
    }
    if(isDefined(var_4.melee) && isDefined(var_4.melee.target) && isPlayer(var_4.melee.target))
      return 0;

    var_5 = [[level.autosave.proximity_threat_func_hometown]](var_4);

    if(var_5 == "return_even_if_low_accuracy")
      return 0;

    if(var_4.finalaccuracy < 0.021 && var_4.finalaccuracy > -1) {
      continue;
    }
    if(var_5 == "return")
      return 0;

    if(var_5 == "none") {
      continue;
    }
    var_6 = undefined;

    if(var_4.a.lastshoottime > gettime() - 500) {
      var_6 = var_4 getcanshootandsee_hometown();

      if(var_0 || var_6)
        return 0;
    }

    if(!isDefined(var_6))
      var_6 = var_4 getcanshootandsee_hometown();

    if(isDefined(var_4.asm.trackasm) && var_4 scripts\asm\asm::asm_currentstatehasflag(var_4.asm.trackasm, "aim") && var_6)
      return 0;
  }

  if(scripts\sp\utility::player_is_near_live_offhand())
    return 0;

  if(isDefined(level.phys_barrels)) {
    foreach(var_9 in level.phys_barrels) {
      if(!isDefined(var_9.onfire)) {
        continue;
      }
      if(var_9.subtype == "antigrav") {
        continue;
      }
      if(distancesquared(var_9.origin, level.player.origin) < 122500)
        return 0;
    }
  }

  var_11 = getEntArray("scriptable", "code_classname");

  foreach(var_13 in var_11) {
    if(!isDefined(var_13.destructible_type) || var_13.destructible_type != "vehicle") {
      continue;
    }
    if(!isDefined(var_13.onfire)) {
      continue;
    }
    if(distancesquared(var_13.origin, level.player.origin) < 160000)
      return 0;
  }

  return 1;
}

transient_load_town() {
  wait 2.0;
  setsaveddvar("OMNONNMOTP", "0.1 400 0.1 1000");
  scripts\engine\sp\utility::transient_load_array(["hometown_buried_tr", "hometown_main_town_tr", "hometown_main_town_carried_tr"]);
}

transient_load_boss() {
  wait 2.0;
  scripts\engine\sp\utility::transient_unload_array(["hometown_buried_tr", "hometown_main_town_carried_tr"]);
  scripts\engine\sp\utility::transient_load_array(["hometown_main_town_tr", "hometown_main_town_boss_tr"]);
}

transient_unload_carried() {
  wait 2.0;
}

transient_unload_boss() {
  wait 2.0;
}

transient_load_poppies() {
  wait 1.0;
  scripts\engine\sp\utility::transient_unload_array(["hometown_main_town_boss_tr"]);
  scripts\engine\sp\utility::transient_load_array(["hometown_main_town_tr", "hometown_poppies_tr", "hometown_periph_tr"]);
}

transient_unload_town() {
  if(isDefined(level.execution_civs_array)) {
    foreach(var_1 in level.execution_civs_array)
    var_1 delete();
  }

  wait 1.0;
  scripts\engine\sp\utility::transient_unload_array(["hometown_main_town_tr"]);
  scripts\engine\sp\utility::transient_load_array(["hometown_poppies_tr", "hometown_periph_tr", "hometown_bunker_tr"]);
  var_3 = getEnt("pistol_overlook_conceal_clip", "script_noteworthy");
  var_3 delete();
}

transient_unload_poppies() {
  wait 1.0;
  scripts\engine\sp\utility::transient_unload("hometown_poppies_tr");
  scripts\engine\sp\utility::transient_unload("hometown_periph_tr");
}

stayahead_turbo_check() {
  level notify("stop_stayahead_turbo_check");
  self endon("death");
  level endon("stop_stayahead_turbo_check");
  var_0 = "undefined";

  for(;;) {
    if(scripts\engine\utility::flag("stayahead_turbo")) {
      if(var_0 != "175") {
        var_0 = "175";
        scripts\sp\utility::enable_stayahead_turbo(250);
      }
    } else if(var_0 != "undefined") {
      var_0 = "undefined";
      scripts\sp\utility::enable_stayahead_turbo(undefined);
    }

    waitframe();
  }
}

getfarrahbloodymodel() {
  if(scripts\common\utility::iswegameplatform())
    return "viewhands_farrah";
  else
    return "viewhands_farrah_bloody";
}

skipchildrenkillingscene() {
  return scripts\common\utility::iswegameplatform();
}

buried_kill_trigger() {
  scripts\engine\sp\utility::trigger_wait("backtrack_buried_kill_trigger", "script_noteworthy");

  if(!istransientloaded("hometown_buried_tr"))
    level.player dodamage(1000, (0, 0, 0));
}

gas_cover_blown_monitor() {
  level endon("village_exit_flag");
  level.player endon("death");
  scripts\engine\utility::flag_wait("patrol_cover_blown");

  if(isDefined(level.hadir_ai)) {
    level.hadir_ai.ignoreme = 0;
    level.hadir_ai.ignoreall = 0;
  }

  if(isDefined(level.farah_father_ai)) {
    level.farah_father_ai.ignoreme = 0;
    level.farah_father_ai.ignoreall = 0;
  }

  wait 2;

  for(;;) {
    waitframe();

    foreach(var_1 in getaiarray("axis")) {
      if(isDefined(var_1.stealth) && !var_1[[var_1.fnisinstealthcombat]]()) {
        continue;
      }
      var_1 getenemyinfo(level.player);

      if(!var_1 canshoot(level.player getEye())) {
        continue;
      }
      var_2 = var_1 gettagorigin("tag_flash");

      if(isDefined(level.player worldpointtoscreenpos(var_2, getdvarint("MRNKTKLLKP")))) {
        continue;
      }
      magicbullet(var_1.weapon, var_2, level.player getEye(), var_1);
    }
  }
}

post_alley_spawn_func() {
  self.animname = "post_alley_russian0" + level.animname_incrementer;
  level.animname_incrementer = level.animname_incrementer + 1;
  self.ignoreall = 1;
  self.fnshouldplaypainanim = ::wasaimeleedbyplayer;
}

boss_blocker() {
  var_0 = getEnt("boss_struggle_blocker_loc", "script_noteworthy");
  level.dead_boss_blocker scripts\engine\sp\utility::show_entity();
  level.dead_boss_blocker_use scripts\engine\sp\utility::show_entity();
  var_1 = scripts\engine\utility::spawn_tag_origin(var_0.origin, var_0.angles);
  level.dead_boss_blocker linkTo(var_1, "tag_origin");
  level.dead_boss_blocker_use linkTo(var_1, "tag_origin");
  var_1.origin = level.boss_struggle_anim_node.origin;
  var_1.angles = level.boss_struggle_anim_node.angles;
}