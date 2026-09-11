/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\hometown\hometown_util.gsc
******************************************************/

function wait_any_input(var0) {
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

  if(!istrue(var0)) {
    level.player endon("tried_moving");
    GscBinSkip4(0x6e, level.player);
  }

  level waittill("forever");
}

function waittill_player_moves() {
  while(level.player getnormalizedmovement() == (0, 0, 0)) {
    waitframe();
  }

  level.player notify("tried_moving");
}

function register_farah_deaths() {
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

function force_ai_see_player_square() {
  scripts\engine\sp\utility::trigger_wait("force_ai_alert_trigger_square", "script_noteworthy");
  scripts\engine\utility::flag_set("patrol_cover_blown");

  foreach(var1 in getaiarray("axis")) {
    var1 aieventlistenerevent("combat", level.player, level.player.origin);
  }
}

function force_ai_see_player_car_flank() {
  scripts\engine\sp\utility::trigger_wait("force_ai_alert_trigger_car_flank", "script_noteworthy");
  scripts\engine\utility::flag_set("patrol_cover_blown");

  foreach(var1 in getaiarray("axis")) {
    var1 aieventlistenerevent("combat", level.player, level.player.origin);
  }
}

function force_ai_see_player_gas_start() {
  scripts\engine\sp\utility::trigger_wait("gas_start_enemies_alert_trigger", "script_noteworthy");
  scripts\engine\utility::flag_set("patrol_cover_blown");

  foreach(var1 in getaiarray("axis")) {
    var1 aieventlistenerevent("combat", level.player, level.player.origin);
  }
}

function force_ai_see_player_gas_start_execution() {
  level endon("hadir_ready_to_cross_street");
  scripts\engine\sp\utility::trigger_wait("gas_start_execution_alert_trigger", "script_noteworthy");
  scripts\engine\utility::flag_set("patrol_cover_blown");

  foreach(var1 in getaiarray("axis")) {
    var1 aieventlistenerevent("combat", level.player, level.player.origin);
  }
}

function wait_lookat(var0, var1, var2, var3, var4) {
  var3 *= 1000;
  var5 = undefined;

  while(!isDefined(var5) || gettime() - var5 < var3) {
    if(isDefined(var4)) {
      wait_near(var0, var4);
    }

    var6 = get_is_looking_at(var0, var1, var2);

    if(var6 && !isDefined(var5)) {
      var5 = gettime();
    } else if(!var6) {
      var5 = undefined;
    }

    waitframe();
  }
}

function get_is_looking_at(var0, var1, var2, var3) {
  if(isent(var0) && isDefined(var2)) {
    var4 = var0 gettagorigin(var2);
  } else if(isent(var1)) {
    var4 = var1.origin;
  } else {
    var4 = var2;
  }

  var5 = self worldpointtoscreenpos(var4, getdvarint("MRNKTKLLKP"));

  if(!isDefined(var5)) {
    return 0;
  }

  if(isDefined(var3) && length2d(var5) > var3) {
    return 0;
  }

  if(!isDefined(var4) || var4) {
    jumpiffalse(isent(var2)) LOC_0000007d;
    var6 = [self, var2];
    goto LOC_00000084;
  } else {
    var7 = 1;
  }

  return var7;
}

function wait_near(var0, var1) {
  var2 = var1 * var1;
  var3 = var0;

  for(;;) {
    if(isent(var0)) {
      var3 = var0.origin;
    }

    if(distance2dsquared(self.origin, var3) < var2) {
      break;
    }

    waitframe();
  }
}

#using_animtree("generic_human");

function make_script_model_civ(var0, var1, var2, var3) {
  var4 = scripts\engine\sp\utility::spawn_anim_model(var0, var1.origin, var1.angles);
  var5 = ["head_sc_m_mrehin_civ_dust", "head_sc_m_arakelyan_civ_dust", "head_sc_m_bansal_civ_dust", "head_sc_m_alameer_civ_dust", "head_sc_m_haghighi_civ_dust", "head_sc_m_nassernia_civ_dust", "head_sc_m_ahmadzai_civ"];
  var6 = ["head_sc_m_mrehin_civ_bg_dust", "head_sc_m_arakelyan_civ_bg_dust", "head_sc_m_bansal_civ_bg_dust", "head_sc_m_alameer_civ_bg_dust", "head_sc_m_haghighi_civ_bg_dust", "head_sc_m_nassernia_civ_bg_dust", "head_sc_m_ahmadzai_civ_bg_dust", "head_sc_m_ahmadzai_bg_dust_civ_no_hair"];
  var7 = ["body_civ_syrkistan_male_1_1", "body_civ_syrkistan_male_2_1", "body_civ_syrkistan_male_3_1", "body_civ_syrkistan_male_4_1", "body_civ_syrkistan_male_5_1", "body_civ_syrkistan_male_6_1", "body_civ_syrkistan_male_7_1", "body_civ_syrkistan_male_10_1"];
  var8 = ["hat_sc_m_nassernia_headscarf", "hat_sc_m_nassernia_headwrap", "hat_sc_m_nassernia_pakol"];
  var9 = ["hat_sc_m_bansal_headscarf", "hat_sc_m_bansal_headwrap", "hat_sc_m_bansal_pakol"];
  var10 = ["hat_sc_m_mrehin_civ_beanie", "hat_sc_m_mrehin_pakol", "hat_sc_m_mrehin_scarf", "hat_sc_m_mrehin_fullwrap"];
  var11 = ["hat_sc_m_ahmadzai_pakol", "hat_sc_m_ahmadzai_scarf", "hat_sc_m_ahmadzai_fullwrap"];
  var4 setModel(scripts\engine\utility::random(var7));
  var4.headmodel = scripts\engine\utility::random(var6);
  var4 attach(var4.headmodel);

  if(isDefined(var2)) {
    level.civ_cleanup_array[level.civ_cleanup_array.size] = var4;
  }

  if(isDefined(var3)) {
    var4 makefakeai();
    var4.health = 100;
  }

  var4.fakeactor_face_anim = 1;
  var4.animationarchetype = "soldier";
  var4.unittype = "civilian";

  if(getdvarint("scr_use_procedural_bones")) {
    var4 setanim(%proc_node, 1, 0);
    var4.anim_getrootfunc = &scripts\asm\gesture\script_funcs::set_root;
  }

  if(var4.headmodel == "head_sc_m_nassernia_civ_bg_dust") {
    var4.hatmodel = scripts\engine\utility::random(var8);
    var4 attach(var4.hatmodel);
  }

  if(var4.headmodel == "head_sc_m_bansal_civ_bg_dust") {
    var4.hatmodel = scripts\engine\utility::random(var9);
    var4 attach(var4.hatmodel);
  }

  if(var4.headmodel == "head_sc_m_mrehin_bg_dust_civ_no_hair") {
    var4.hatmodel = scripts\engine\utility::random(var10);
    var4 attach(var4.hatmodel);
  }

  if(var4.headmodel == "head_sc_m_ahmadzai_bg_dust_civ_no_hair") {
    var4.hatmodel = scripts\engine\utility::random(var11);
    var4 attach(var4.hatmodel);
  }

  return var4;
}

#using_animtree("");

function make_script_model_civ_wh(var0, var1, var2, var3) {
  var4 = scripts\engine\sp\utility::spawn_anim_model(var0, var1.origin, var1.angles);
  var5 = ["head_sc_m_ahmadzai_civ_helmet_dust", "head_sc_m_alameer_civ_helmet_dust", "head_sc_m_kargorgis_civ_helmet_dust", "head_sc_m_yurteri_civ_helmet_dust"];
  var6 = ["head_sc_m_ahmadzai_civ_helmet_bg_dust", "head_sc_m_alameer_civ_helmet_bg_dust", "head_sc_m_kargorgis_civ_helmet_bg_dust", "head_sc_m_yurteri_civ_helmet_bg_dust"];
  var7 = ["body_white_helmets_male_1", "body_white_helmets_male_2", "body_white_helmets_male_3"];
  var4 setModel(scripts\engine\utility::random(var7));
  var4 attach(scripts\engine\utility::random(var6));

  if(isDefined(var2)) {
    level.civ_cleanup_array[level.civ_cleanup_array.size] = var4;
  }

  if(isDefined(var3)) {
    var4 makefakeai();
    var4.health = 100;
  }

  var4.fakeactor_face_anim = 1;
  var4.animationarchetype = "soldier";
  var4.unittype = "civilian";

  if(getdvarint("scr_use_procedural_bones")) {
    var4 setanim(%proc_node, 1, 0);
    var4.anim_getrootfunc = &scripts\asm\gesture\script_funcs::set_root;
  }

  return var4;
}

function make_script_model_civ_female(var0, var1, var2, var3) {
  var4 = scripts\engine\sp\utility::spawn_anim_model(var0, var1.origin, var1.angles);
  var5 = ["head_sc_f_toyouri_civ_dust", "head_sc_f_rezaee_civ_dust", "head_sc_f_eghbali_civ_dust", "head_sc_f_mostafavi_civ"];
  var6 = ["head_sc_f_toyouri_civ_bg_no_hair_dust", "head_sc_f_rezaee_civ_bg_dust", "head_sc_f_eghbali_civ_bg_dust"];
  var7 = ["body_civ_syrkistan_female_1_2", "body_civ_syrkistan_female_5_1", "body_civ_syrkistan_female_5_2", "body_civ_syrkistan_female_6_1", "body_civ_syrkistan_female_6_2", "body_civ_syrkistan_female_8_2", "body_civ_syrkistan_female_10_1", "body_civ_syrkistan_female_10_2"];
  var4 setModel(scripts\engine\utility::random(var7));
  var4 attach(scripts\engine\utility::random(var6));

  if(isDefined(var2)) {
    level.civ_cleanup_array[level.civ_cleanup_array.size] = var4;
  }

  if(isDefined(var3)) {
    var4 makefakeai();
    var4.health = 100;
  }

  var4.fakeactor_face_anim = 1;
  var4.animationarchetype = "soldier";
  var4.unittype = "civilian";

  if(getdvarint("scr_use_procedural_bones")) {
    var4 setanim(%proc_node, 1, 0);
    var4.anim_getrootfunc = &scripts\asm\gesture\script_funcs::set_root;
  }

  return var4;
}

function make_script_model_civ_child(var0, var1, var2) {
  var3 = scripts\engine\sp\utility::spawn_anim_model(var0, var1.origin, var1.angles);
  var4 = ["head_sc_m_naficy_civ_dust", "head_sc_m_ahmed_civ", "head_sc_m_choudhary_civ"];
  var5 = ["head_sc_m_naficy_civ_bg_dust"];
  var6 = ["body_civ_syrkistan_boy_2_1", "body_civ_syrkistan_boy_3_1", "body_civ_syrkistan_boy_4_1", "body_civ_syrkistan_boy_5_1", "body_civ_syrkistan_boy_6_1"];
  var3 setModel(scripts\engine\utility::random(var6));
  var3 attach(scripts\engine\utility::random(var5));

  if(isDefined(var2)) {
    level.civ_cleanup_array[level.civ_cleanup_array.size] = var3;
  }

  var3.fakeactor_face_anim = 1;
  var3.animationarchetype = "soldier";
  var3.unittype = "civilian";

  if(getdvarint("scr_use_procedural_bones")) {
    var3 setanim(%proc_node, 1, 0);
    var3.anim_getrootfunc = &scripts\asm\gesture\script_funcs::set_root;
  }

  return var3;
}

function make_script_model_civ_child_female(var0, var1, var2) {
  var3 = scripts\engine\sp\utility::spawn_anim_model(var0, var1.origin, var1.angles);
  var4 = ["head_sc_f_roa_dust", "head_sc_f_fausto_dust", "head_sc_f_kohli_dust"];
  var5 = ["head_sc_f_roa_bg_dust", "head_sc_f_fausto_bg_dust", "head_sc_f_kohli_bg_dust"];
  var6 = ["body_civ_syrkistan_girl_1_1", "body_civ_syrkistan_girl_2_1", "body_civ_syrkistan_girl_3_1", "body_civ_syrkistan_girl_4_1", "body_civ_syrkistan_girl_5_1", "body_civ_syrkistan_girl_6_1"];
  var3 setModel(scripts\engine\utility::random(var6));
  var3 attach(scripts\engine\utility::random(var5));

  if(isDefined(var2)) {
    level.civ_cleanup_array[level.civ_cleanup_array.size] = var3;
  }

  var3.fakeactor_face_anim = 1;
  var3.animationarchetype = "soldier";
  var3.unittype = "civilian";

  if(getdvarint("scr_use_procedural_bones")) {
    var3 setanim(%proc_node, 1, 0);
    var3.anim_getrootfunc = &scripts\asm\gesture\script_funcs::set_root;
  }

  return var3;
}

function make_script_model_russian(var0, var1, var2, var3) {
  var4 = scripts\engine\sp\utility::spawn_anim_model(var0, var1.origin, var1.angles);
  var5 = ["head_russian_army_balaclava_1", "head_russian_army_balaclava_2"];
  var6 = ["body_russian_army_ar_1", "body_russian_army_ar_2"];
  var4 setModel(scripts\engine\utility::random(var6));
  var4 attach(scripts\engine\utility::random(var5));

  if(isDefined(var2)) {
    level.civ_cleanup_array[level.civ_cleanup_array.size] = var4;
  }

  var4.gun_model = spawn("script_model", var4.origin);
  var4.gun_model setModel("attachment_wm_receiver_akilo47");
  var4.gun_model attach("attachment_wm_stock_akilo47");
  var4.gun_model attach("attachment_wm_barrel_akilo47");
  var4.gun_model attach("attachment_wm_mag_akilo47");

  if(isDefined(var3)) {
    var4.gun_model attach("attachment_wm_ub_gpapa25");
  }

  var4.gun_model linkTo(var4, "tag_accessory_right", (0, 0, 0), (0, 0, 0));
  var4.fakeactor_face_anim = 1;
  var4.animationarchetype = "soldier";
  var4.unittype = "civilian";

  if(getdvarint("scr_use_procedural_bones")) {
    var4 setanim(%proc_node, 1, 0);
    var4.anim_getrootfunc = &scripts\asm\gesture\script_funcs::set_root;
  }

  return var4;
}

function shoot_gun_from_notetrack(var0) {
  var1 = self.gun_model gettagorigin("tag_flash");
  var2 = var1 + anglesToForward(self.gun_model gettagangles("tag_flash")) * 50;
  magicbullet("iw8_ar_akilo47_silent", var1, var2);
  playFXOnTag(level._effect["vfx_muz_ar_w"], self.gun_model, "tag_flash");
}

function shoot_gun_from_notetrack_player(var0) {
  var1 = level.goliath_ai gettagorigin("tag_flash");
  var2 = var1 + anglesToForward(level.goliath_ai gettagangles("tag_flash")) * 50;
  magicbullet("iw8_ar_akilo47_silent", var1, var2);
  playFXOnTag(level._effect["vfx_muz_ar_w"], level.goliath_ai, "tag_flash");
  level.player playSound("weap_akilo47j12_fire_plr");
  level.player playSound("weap_akilo47j12_fire_plr_atmo");
  level.player playRumbleOnEntity("damage_bullet");
}

function shoot_gas_grenade_from_notetrack(var0) {
  var1 = self.gun_model gettagorigin("tag_flash");
  var2 = self.gun_model gettagorigin("tag_flash");
  playFXOnTag(level._effect["vfx_htown_gas_muzzleflash"], self.gun_model, "tag_flash");
  self.gun_model thread scripts\engine\sp\utility::play_sound_on_tag("ht_weap_mike203_fire_npc_med", "tag_flash");

  if(level.gas_trail_ground_done == 0) {
    scripts\engine\utility::exploder("gas_attack_amb");
    level.gas_trail_ground_done = 1;
    return;
  }
}

function weapon_monitor() {
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

function battlechatter_off_spawn_func() {
  self endon("death");

  while(!istrue(self.battlechatterallowed)) {
    wait 0.1;
  }

  scripts\engine\sp\utility::set_battlechatter(0);
}

function goliath_spawn_func() {
  self.goalradius = 50;
  self.disablepistol = 1;
  self.baseaccuracy = 1;
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
  scripts\sp\maps\hometown\goliath_stealth::goliath_setup_stealth();
  self.proximity_bump_dist_sqr_override = 900;
  self.context_melee_back_dot_override = -0.5;
  self.smartobjectnotetrackhandle = &goliath_smartobject_notetrack_handler;
  thread battlechatter_off_spawn_func();
  thread goliath_flashlight();
  wait 1;
  thread scripts\common\ai::magic_bullet_shield(1);
  self.stealth.funcs["event_investigate"] = &goliath_stealth_filter;
  self.stealth.funcs["event_cover_blown"] = &goliath_stealth_filter;
  self.stealth.funcs["event_combat"] = &goliath_stealth_filter;
  self[[self.fnsetstealthstate]]("hunt", undefined);
  var0 = scripts\stealth\group::getgroup(self.script_stealthgroup);
  var1 = scripts\stealth\group::group_findpod(var0, self);
  var1.borigininvestigated = 1;
  var2 = scripts\sp\utility::make_weapon("iw8_ar_akilo47_goliath", ["reflexstable_west01", "barsmg_akilo47", "calsmg_akilo47_sp", "taclight", "gripvert_akilo47"]);
  scripts\anim\shared::forceuseweapon(var2, "primary");
  self.fnshouldplaypainanim = &wasaimeleedbyplayer;
  self removeaieventlistener("footstep_sprint");
}

function goliath_flashlight() {
  wait 1;
  self.flashlightfxoverridetag = "tag_light";
  scripts\sp\nvg\nvg_ai::flashlight_off(1);
  scripts\sp\nvg\nvg_ai::flashlight_on(1);
}

function goliath_stealth_filter(var0) {
  if(scripts\engine\utility::is_equal(var0.entity, self)) {
    return true;
  }

  return false;
}

function goliath_smartobject_notetrack_handler(var0) {
  level endon("boss_dying");

  switch (var0) {
    case "knock_off":
      var1 = level.goliath_ai gettagorigin("j_wrist_le");
      physicsexplosionsphere(var1, 15, 10, 50);
      break;
    case "spawn_entity":
      var2 = level.goliath_ai gettagangles("j_mainroot");
      var2 = anglesToForward(var2);
      var3 = level.goliath_ai.origin + (0, 0, 36) + anglesToForward(level.goliath_ai.angles) * 15;
      var4 = spawn("script_model", var3);
      var5 = [0, 1, 2];
      var6 = 0;
      var7 = scripts\engine\utility::random(var5);

      while(level.goliath_melee_weapon_spawn_count == var7 && var6 < 30) {
        var7 = scripts\engine\utility::random(var5);
        var6++;
      }

      level.goliath_melee_weapon_spawn_count = var7;

      if(level.current_knock_off == "drop_all") {
        var8 = scripts\engine\utility::random(["iw8_knife_kid", "iw8_knife_kid_screwdriver", "iw8_knife_kid_scissors"]);
      } else if(level.current_knock_off == "drop_scissors_only") {
        var8 = scripts\engine\utility::random(["iw8_knife_kid_scissors"]);
      } else if(level.current_knock_off == "drop_screwdriver_only") {
        var8 = scripts\engine\utility::random(["iw8_knife_kid_screwdriver"]);
      } else if(level.current_knock_off == "drop_knife_only") {
        var8 = scripts\engine\utility::random(["iw8_knife_kid"]);
      } else if(level.current_knock_off == "drop_scissors_screwdriver") {
        var8 = scripts\engine\utility::random(["iw8_knife_kid_screwdriver", "iw8_knife_kid_scissors"]);
      } else if(level.current_knock_off == "drop_scissors_knife") {
        var8 = scripts\engine\utility::random(["iw8_knife_kid", "iw8_knife_kid_scissors"]);
      } else if(level.current_knock_off == "drop_screwdriver_knife") {
        var8 = scripts\engine\utility::random(["iw8_knife_kid", "iw8_knife_kid_screwdriver"]);
      } else {
        var8 = scripts\engine\utility::random(["iw8_knife_kid", "iw8_knife_kid_screwdriver", "iw8_knife_kid_scissors"]);
      }

      if(var8 == "iw8_knife_kid") {
        var8 setModel("weapon_wm_me_kitchen_knife");
      } else if(var8 == "iw8_knife_kid_screwdriver") {
        var8 setModel("weapon_wm_me_screwdriver");
      } else if(var8 == "iw8_knife_kid_scissors") {
        var8 setModel("weapon_wm_me_scissors");
      } else {
        var8 setModel("weapon_wm_me_kitchen_knife");
      }

      var9 = anglesToForward(var8);
      var9 = var9 * randomfloatrange(20, 25) * -1;
      var10 = var9[0];
      var11 = 10;
      var12 = 10;
      var8 physicslaunchserver(var8.origin, (var10, var11, var12));
      thread goliath_melee_weapon_spawn_interact(var8, var8);
      break;
    case "kick":
      earthquake(0.5, 1, self gettagorigin("j_ball_ri"), 30);
      var13 = self.asm.smartobject;
      var14 = [];

      foreach(var16 in var13 scripts\engine\utility::get_linked_ents()) {
        if(scripts\engine\utility::is_equal(var16.script_noteworthy, "kick_obj")) {
          if(!isDefined(var16.animname)) {
            var16.animname = var16.script_animname;
            var16 scripts\engine\sp\utility::assign_animtree();
          }

          if(!isDefined(var16.clip) && isDefined(var16.target)) {
            var16.clip = getEnt(var16.target, "targetname");
            var16.clip linkTo(var16);
            waittillframeend();
          }

          var13 thread scripts\common\anim::anim_single_solo(var16, "kick");
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

function goliath_bloody_footsteps(var0) {
  var1 = "soldier";
  var2 = scripts\engine\utility::getfx("bloody_footprint");
  scripts\anim\utility::setfootprinteffect(var1, "snow", var2);
  scripts\anim\utility::setfootprinteffect(var1, "ice", var2);
  scripts\anim\utility::setfootprinteffect(var1, "asphalt_dry", var2);
  scripts\anim\utility::setfootprinteffect(var1, "dirt", var2);
  scripts\anim\utility::setfootprinteffect(var1, "foliage", var2);
  scripts\anim\utility::setfootprinteffect(var1, "grass", var2);
  scripts\anim\utility::setfootprinteffect(var1, "gravel", var2);
  scripts\anim\utility::setfootprinteffect(var1, "mud", var2);
  scripts\anim\utility::setfootprinteffect(var1, "rock", var2);
  scripts\anim\utility::setfootprinteffect(var1, "sand", var2);
  scripts\anim\utility::setfootprinteffect(var1, "water", var2);
  scripts\anim\utility::setfootprinteffect(var1, "default", var2);
  scripts\anim\utility::setfootprinteffect(var1, "wood_floor", var2);
}

function clear_goliath_bloody_footsteps() {
  scripts\anim\utility::unsetfootprinteffect("snow");
  scripts\anim\utility::unsetfootprinteffect("ice");
  scripts\anim\utility::unsetfootprinteffect("asphalt_dry");
  scripts\anim\utility::unsetfootprinteffect("dirt");
  scripts\anim\utility::unsetfootprinteffect("foliage");
  scripts\anim\utility::unsetfootprinteffect("grass");
  scripts\anim\utility::unsetfootprinteffect("gravel");
  scripts\anim\utility::unsetfootprinteffect("mud");
  scripts\anim\utility::unsetfootprinteffect("rock");
  scripts\anim\utility::unsetfootprinteffect("sand");
  scripts\anim\utility::unsetfootprinteffect("water");
  scripts\anim\utility::unsetfootprinteffect("default");
  scripts\anim\utility::unsetfootprinteffect("wood_floor");
}

function goliath_melee_weapon_spawn_interact(var0, var1) {
  wait 1;
  thread goliath_melee_weapon_interact(var0);
}

function kill_quietly(var0) {
  self.skipdeathanim = 1;
  self.noragdoll = 1;
  self pushplayer(0);
  self.allowdeath = 1;
  self.diequietly = 1;

  if(isDefined(self.magic_bullet_shield)) {
    scripts\common\ai::stop_magic_bullet_shield();
  }

  self kill((0, 0, 0), var0, var0);
}

function kill_and_delete_quietly(var0) {
  self.skipdeathanim = 1;
  self.noragdoll = 1;
  self pushplayer(0);
  self.allowdeath = 1;
  self.diequietly = 1;

  if(isDefined(self.magic_bullet_shield)) {
    scripts\common\ai::stop_magic_bullet_shield();
  }

  self kill((0, 0, 0), var0, var0);
  self delete();
}

function spawn_father() {
  var0 = getspawner("farah_father", "script_noteworthy");
  var0 scripts\engine\sp\utility::add_spawn_function(&father_spawn_func);
  level.farah_father_ai = var0 scripts\engine\sp\utility::spawn_ai(1);
  level.farah_father_ai.anim_playvo_func = &scripts\engine\utility::playsoundontag;
}

function spawn_hadir() {
  var0 = getspawner("hadir_spawner", "script_noteworthy");
  var0.count = 2;
  var0 scripts\engine\sp\utility::add_spawn_function(&hadir_spawn_func);
  level.hadir_ai = var0 scripts\engine\sp\utility::spawn_ai(1);
  level.hadir_ai.anim_playvo_func = &scripts\engine\utility::playsoundontag;
}

function spawn_goliath_boss() {
  var0 = getspawner("goliath_spawner", "script_noteworthy");
  var0 scripts\engine\sp\utility::add_spawn_function(&goliath_spawn_func);
  level.goliath_ai = var0 scripts\engine\sp\utility::spawn_ai(1);
  level.goliath_ai.anim_playvo_func = &scripts\engine\utility::playsoundontag;
}

function hadir_spawn_func() {
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
  wait 1;
  scripts\common\ai::magic_bullet_shield(1);
  self.gestureinterruptible = 1;
}

function father_spawn_func() {
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

function russian_patroller_spawn_func() {
  self.combatmode = "no_cover";
  self.noarmor = 1;
  self.baseaccuracy = 10;

  if(!isDefined(self.stealth.funcs)) {
    self.stealth.funcs = [];
  }

  self.stealth.funcs["event_investigate"] = &russian_patroller_stealth_filter;
  self.stealth.funcs["event_cover_blown"] = &russian_patroller_stealth_filter;
  self.stealth.funcs["event_combat"] = &russian_patroller_stealth_filter;
  self.ignoreforfixednodesafecheck = 1;
  scripts\engine\sp\utility::battlechatter_off();
  wait 0.5;
  self removeaieventlistener("footstep_sprint");
  self.fnshouldplaypainanim = &wasaimeleedbyplayer;
}

function wasaimeleedbyplayer() {
  if(isDefined(self.lastattacker)) {
    if(scripts\engine\utility::is_equal(self.lastattacker, level.player)) {
      if(isDefined(self.damagemod)) {
        if(self.damagemod == "MOD_MELEE") {
          return false;
        }
      }
    }
  }

  return true;
}

function russian_patroller_stealth_filter(var0) {
  scripts\engine\sp\utility::battlechatter_on();

  if(var0.type == "investigate") {
    scripts\engine\utility::thread_on_notify("stealth_idle", &scripts\engine\sp\utility::battlechatter_off);
    thread russian_patroller_investigate();
    return false;
  }

  if(var0.type == "cover_blown") {
    var0.type = "combat";
  }

  scripts\engine\utility::flag_set("patrol_cover_blown");
  return false;
}

function russian_patroller_investigate() {
  self endon("stealth_idle");
  self endon("stealth_combat");
  var0 = scripts\engine\trace::create_contents(1, 1, 0, 1, 1, 1, 0, 1, 1);

  for(;;) {
    wait 0.2;

    if(!scripts\engine\utility::within_fov(self.origin, self.angles, level.hadir_ai.origin, 0.5)) {
      continue;
    }

    if(!scripts\engine\utility::can_trace_to_ai(self getEye(), level.hadir_ai, undefined, var0)) {
      continue;
    }

    self aieventlistenerevent("combat", level.player, level.hadir_ai.origin);
    return;
  }
}

function russian_patroller_spawn_func_no_flashlight() {
  self.combatmode = "no_cover";
  self.noarmor = 1;

  if(!isDefined(self.stealth.funcs)) {
    self.stealth.funcs = [];
  }

  self.stealth.funcs["event_investigate"] = &poppies_enemy_stealth_filter;
  self.stealth.funcs["event_cover_blown"] = &poppies_enemy_stealth_filter;
  self.stealth.funcs["event_combat"] = &poppies_enemy_stealth_filter;
}

function russian_patroller_spawn_func_no_flashlight_ignore() {
  self.combatmode = "no_cover";
  self.noarmor = 1;
  self.ignoreall = 1;

  if(!isDefined(self.stealth.funcs)) {
    self.stealth.funcs = [];
  }

  self.stealth.funcs["event_investigate"] = &poppies_enemy_stealth_filter;
  self.stealth.funcs["event_cover_blown"] = &poppies_enemy_stealth_filter;
  self.stealth.funcs["event_combat"] = &poppies_enemy_stealth_filter;
}

function poppies_enemy_stealth_filter(var0) {
  if(var0.typeorig == "gunshot" || var0.typeorig == "bulletwhizby" || var0.typeorig == "gunshot_teammate") {
    return true;
  }

  return false;
}

function search_ground_hint() {
  level.player endon("player_found_a_weapon");
  scripts\engine\utility::flag_wait("goliath_weapon_exists");
  wait 120;
  scripts\engine\utility::flag_set("goliath_weapon_exists_hint");
  scripts\sp\utility::context_melee_set_hint_directions(["back", "left", "right", "front"]);
  scripts\engine\sp\utility::display_hint("search_ground_hint", 30, 0, [level.player], ["player_found_a_weapon"]);
}

function goliath_melee_weapon_interact(var0) {
  if(var0 == "iw8_knife_kid") {
    var1 = &"HOMETOWN/KNIFE";
  } else if(var1 == "iw8_knife_kid_rebar") {
    var1 = &"HOMETOWN/BRICK";
  } else if(var1 == "iw8_knife_kid_scissors") {
    var1 = &"HOMETOWN/SCISSORS";
  } else if(var1 == "iw8_knife_kid_screwdriver") {
    var1 = &"HOMETOWN/SCREWDRIVER";
  } else {
    var1 = &"HOMETOWN/KNIFE";
  }

  var2 = scripts\engine\utility::spawn_tag_origin(self.origin);
  var2 scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", (0, 0, 0), var1, 75, 175, 50, 0);
  level.goliath_weapon_interacts_array[level.goliath_weapon_interacts_array.size] = var2;
  level.goliath_weapon_exists = "true";
  scripts\engine\utility::flag_set("goliath_weapon_exists");

  for(var3 = 0; var3 == 0; var3 = 1) {
    var2 waittill("trigger");
    level.player playSound("scn_hometown_stab_weap_pickup");
    scripts\engine\utility::flag_set("objective_kill_the_soldier");

    if(scripts\engine\sp\utility::player_has_weapon("iw8_knife_kid") || scripts\engine\sp\utility::player_has_weapon("iw8_knife_kid_rebar") || scripts\engine\sp\utility::player_has_weapon("iw8_knife_kid_screwdriver") || scripts\engine\sp\utility::player_has_weapon("iw8_knife_kid_scissors")) {
      goliath_melee_weapon_swap();
      waitframe();
      level.player takeallweapons();
      waitframe();
      var3 = 1;
      continue;
    }
  }

  level.player_found_a_weapon = "true";
  level.player notify("player_found_a_weapon");
  var2 delete();
  level.player giveweapon(var1);
  level.player switchtoweapon(var1);
  level.player notify("knife_change");

  if(scripts\sp\autosave::autosavethreatcheck(1)) {
    thread scripts\engine\sp\utility::autosave_by_name("got_melee_weapon");
  }

  self delete();
}

function goliath_melee_weapon_swap() {
  level endon("boss_dying");
  var0 = level.player gettagangles("tag_origin");
  var0 = anglesToForward(var0);

  if(level.player getstance() == "prone") {
    var1 = level.player.origin + (0, 0, 3) + anglesToForward(level.player.angles) * 15;
  } else if(level.player getstance() == "crouch") {
    var1 = level.player.origin + (0, 0, 10) + anglesToForward(level.player.angles) * 15;
  } else {
    var1 = level.player.origin + (0, 0, 20) + anglesToForward(level.player.angles) * 15;
  }

  var2 = spawn("script_model", var1);

  if(scripts\engine\sp\utility::player_has_weapon("iw8_knife_kid_scissors")) {
    var3 = "iw8_knife_kid_scissors";
    var2 setModel("weapon_wm_me_scissors");
  } else if(scripts\engine\sp\utility::player_has_weapon("iw8_knife_kid_screwdriver")) {
    var3 = "iw8_knife_kid_screwdriver";
    var3 setModel("weapon_wm_me_screwdriver");
  } else if(scripts\engine\sp\utility::player_has_weapon("iw8_knife_kid")) {
    var3 = "iw8_knife_kid";
    var3 setModel("weapon_wm_me_kitchen_knife");
  } else {
    var3 = "iw8_knife_kid";
    var3 setModel("weapon_wm_me_kitchen_knife");
  }

  var4 = anglesToForward(var3);
  var4 = var4 * randomfloatrange(20, 25) * -1;
  var5 = var4[0];
  var6 = 10;
  var7 = 10;
  var3 physicslaunchserver(var3.origin, (var5, var6, var7));
  thread goliath_melee_weapon_spawn_interact(var3, var3);
}

function goliath_delete_weapon_interacts_monitor() {
  level.goliath_weapon_interacts_array = [];
  level waittill("clean_up_goliath_interacts");
  var0 = scripts\engine\utility::array_removeundefined(level.goliath_weapon_interacts_array);

  foreach(var2 in var0) {
    if(isDefined(var2)) {
      var2 delete();
    }
  }
}

function play_anim_and_delete(var0, var1) {
  scripts\common\anim::anim_single_solo(var0, var1);
  var0 delete();
}

function play_anim_and_then_loop(var0, var1, var2) {
  self endon("stop_play_anim_and_then_loop");
  self notify("stop_loop");
  scripts\common\anim::anim_single_solo(var0, var1);
  self notify("loop_started");
  thread scripts\common\anim::anim_loop_solo(var0, var2);
}

function play_anim_and_then_loop_with_nags(var0, var1, var2) {
  self endon("stop_play_anim_and_then_loop");
  self notify("stop_loop");
  scripts\common\anim::anim_single_solo(var0, var1);

  for(;;) {
    scripts\common\anim::anim_single_solo(var0, var2 + "_nags");
    thread scripts\common\anim::anim_loop_solo(var0, var2);
    wait 3;
    self notify("stop_loop");
  }
}

function play_anim_and_then_last_frame(var0, var1) {
  self endon("stop_play_anim_and_then_loop");
  self notify("stop_loop");
  scripts\common\anim::anim_single_solo(var0, var1);
  scripts\common\anim::anim_last_frame_solo(var0, var1);
}

function spawn_dude_play_anim_and_delete(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(!isDefined(var7)) {
    if(var2 == "male") {
      var10 = make_script_model_civ(var0, self);
    } else if(var3 == "russian_male") {
      var10 = make_script_model_russian(var1, self);
    } else if(var4 == "child_male") {
      var10 = make_script_model_civ_child(var2, self);
    } else if(var5 == "child_female") {
      var10 = make_script_model_civ_child_female(var3, self);
    } else if(var6 == "female") {
      var10 = make_script_model_civ_female(var4, self);
    } else if(var7 == "white_helmet") {
      var10 = make_script_model_civ_wh(var5, self);
    } else {
      var10 = scripts\engine\sp\utility::spawn_anim_model(var6, self.origin, self.angles);
      var10.fakeactor_face_anim = 1;
      var10.animationarchetype = "soldier";
    }
  } else {
    var10 = scripts\engine\sp\utility::spawn_anim_model(var7, self.origin, self.angles);
    var10.fakeactor_face_anim = 1;
    var10.animationarchetype = "soldier";
  }

  if(isDefined(var10)) {
    level.square_dudes_hide_array[level.square_dudes_hide_array.size] = var10;
    var10 hide();
  }

  if(isDefined(var10)) {
    var10 makefakeai();
    var10.health = 100;
  }

  if(isDefined(var10)) {
    var10 setModel(var10);
  }

  if(isDefined(var10)) {
    var10 attach(var10);
  }

  if(!isDefined(var10.hatmodel)) {
    if(isDefined(var10)) {
      var10 attach(var10);
    }
  }

  var10 scripts\engine\utility::delaythread(1, &hometown_print3d_on_me);
  thread spawn_dude_play_anim_and_delete_animate(var10, var8, var10, var10);
  return var10;
}

function spawn_dude_play_anim_and_delete_animate(var0, var1, var2, var3) {
  if(isDefined(var2)) {
    scripts\common\anim::anim_first_frame_solo(var0, var1);
    level waittill(var2);
  }

  scripts\common\anim::anim_single_solo(var0, var1);

  if(isDefined(var3)) {
    if(var3) {
      if(isDefined(var0.gun_model)) {
        var0.gun_model delete();
      }

      var0 delete();
    }
  }

  if(!isDefined(var3)) {
    if(isDefined(var0.gun_model)) {
      var0.gun_model delete();
    }

    var0 delete();
    return;
  }
}

function hometown_print3d_on_me() {
  self endon("death");
}

function spawn_dude_loop_anim(var0, var1, var2, var3) {
  if(var2 == "male") {
    var4 = make_script_model_civ(var0, self);
  } else if(var3 == "russian_male") {
    var4 = make_script_model_russian(var1, self);
  } else if(var4 == "child_male") {
    var4 = make_script_model_civ_child(var2, self);
  } else {
    var4 = scripts\engine\sp\utility::spawn_anim_model(var3, self.origin, self.angles);
    var4.fakeactor_face_anim = 1;
    var4.animationarchetype = "soldier";
  }

  level.civ_cleanup_array[level.civ_cleanup_array.size] = var4;
  thread scripts\common\anim::anim_loop_solo(var4, var4, var4);
  return var4;
}

function spawn_dude_play_anim(var0, var1, var2) {
  if(var2 == "male") {
    var3 = make_script_model_civ(var0, self);
  } else if(var3 == "russian_male") {
    var3 = make_script_model_russian(var1, self);
  } else {
    var3 = scripts\engine\sp\utility::spawn_anim_model(var2, self.origin, self.angles);
    var3.fakeactor_face_anim = 1;
    var3.animationarchetype = "soldier";
  }

  scripts\common\anim::anim_loop_solo(var3, var3);
  return var3;
}

function spawn_thing_play_anim_and_delete(var0, var1, var2, var3) {
  var4 = scripts\engine\sp\utility::spawn_anim_model(var0, self.origin, self.angles);

  if(isDefined(var3)) {
    level.square_dudes_hide_array[level.square_dudes_hide_array.size] = var4;
    var4 hide();
  }

  var4 scripts\engine\utility::delaythread(1, &hometown_print3d_on_me);
  scripts\common\anim::anim_single_solo(var4, var1);

  if(isDefined(var2)) {
    if(var2) {
      var4 delete();
    }
  }

  if(!isDefined(var2)) {
    var4 delete();
    return;
  }
}

function spawn_thing_play_anim_and_last_frame(var0, var1, var2, var3) {
  var4 = scripts\engine\sp\utility::spawn_anim_model(var0, self.origin, self.angles);

  if(isDefined(var3)) {
    level.square_dudes_hide_array[level.square_dudes_hide_array.size] = var4;
    var4 hide();
  }

  var4 scripts\engine\utility::delaythread(1, &hometown_print3d_on_me);
  scripts\common\anim::anim_single_solo(var4, var1);
  scripts\common\anim::anim_last_frame_solo(var4, var1);
}

function autosave_setup_hometown() {
  level.autosave.proximity_threat_func = &autosave_proximity_threat_func_hometown;
}

function autosaveprint_hometown(var0, var1, var2) {}

function getcanshootandsee_hometown() {
  return scripts\anim\utility_common::canseeenemy(0) && self canshootenemy(0);
}

function autosave_proximity_threat_func_hometown(var0) {
  foreach(var2 in level.players) {
    var3 = distancesquared(var0.origin, var2.origin);

    if(var3 < 10000) {
      return "return_even_if_low_accuracy";
    }

    if(var3 < 129600) {
      return "return";
    }

    if(var3 < 1000000) {
      return "threat_exists";
    }
  }

  return "none";
}

function autosavethreatcheck_hometown(var0, var1) {
  var2 = getaiunittypearray("bad_guys", "all");

  foreach(var4 in var2) {
    if(isDefined(level.player.stealth) && isDefined(var4.stealth) && var4.threatsight && var4 getthreatsight(level.player) > 0) {
      return false;
    }

    if(!isDefined(var4.enemy)) {
      continue;
    }

    if(!isPlayer(var4.enemy)) {
      continue;
    }

    if(isDefined(var4.melee) && isDefined(var4.melee.target) && isPlayer(var4.melee.target)) {
      return false;
    }

    var5 = [[level.autosave.proximity_threat_func_hometown]](var4);

    if(var5 == "return_even_if_low_accuracy") {
      return false;
    }

    if(var4.finalaccuracy < 0.021 && var4.finalaccuracy > -1) {
      continue;
    }

    if(var5 == "return") {
      return false;
    }

    if(var5 == "none") {
      continue;
    }

    var6 = undefined;

    if(var4.a.lastshoottime > gettime() - 500) {
      var6 = getcanshootandsee_hometown(var4);

      if(var0 || var6) {
        return false;
      }
    }

    if(!isDefined(var6)) {
      var6 = getcanshootandsee_hometown(var4);
    }

    if(isDefined(var4.asm.trackasm) && var4 scripts\asm\asm::asm_currentstatehasflag(var4.asm.trackasm, "aim") && var6) {
      return false;
    }
  }

  if(scripts\sp\utility::player_is_near_live_offhand()) {
    return false;
  }

  if(isDefined(level.phys_barrels)) {
    foreach(var9 in level.phys_barrels) {
      if(!isDefined(var9.onfire)) {
        continue;
      }

      if(var9.subtype == "antigrav") {
        continue;
      }

      if(distancesquared(var9.origin, level.player.origin) < 122500) {
        return false;
      }
    }
  }

  var11 = getEntArray("scriptable", "code_classname");

  foreach(var13 in var11) {
    if(!isDefined(var13.destructible_type) || var13.destructible_type != "vehicle") {
      continue;
    }

    if(!isDefined(var13.onfire)) {
      continue;
    }

    if(distancesquared(var13.origin, level.player.origin) < 160000) {
      return false;
    }
  }

  return true;
}

function transient_load_town() {
  wait 2;
  setsaveddvar("OMNONNMOTP", "0.1 400 0.1 1000");
  scripts\engine\sp\utility::transient_load_array(["hometown_buried_tr", "hometown_main_town_tr", "hometown_main_town_carried_tr"]);
}

function transient_load_boss() {
  wait 2;
  scripts\engine\sp\utility::transient_unload_array(["hometown_buried_tr", "hometown_main_town_carried_tr"]);
  scripts\engine\sp\utility::transient_load_array(["hometown_main_town_tr", "hometown_main_town_boss_tr"]);
}

function transient_unload_carried() {
  wait 2;
}

function transient_unload_boss() {
  wait 2;
}

function transient_load_poppies() {
  wait 1;
  scripts\engine\sp\utility::transient_unload_array(["hometown_main_town_boss_tr"]);
  scripts\engine\sp\utility::transient_load_array(["hometown_main_town_tr", "hometown_poppies_tr", "hometown_periph_tr"]);
}

function transient_unload_town() {
  if(isDefined(level.execution_civs_array)) {
    foreach(var1 in level.execution_civs_array) {
      var1 delete();
    }
  }

  wait 1;
  scripts\engine\sp\utility::transient_unload_array(["hometown_main_town_tr"]);
  scripts\engine\sp\utility::transient_load_array(["hometown_poppies_tr", "hometown_periph_tr", "hometown_bunker_tr"]);
  var3 = getEnt("pistol_overlook_conceal_clip", "script_noteworthy");
  var3 delete();
}

function transient_unload_poppies() {
  wait 1;
  scripts\engine\sp\utility::transient_unload("hometown_poppies_tr");
  scripts\engine\sp\utility::transient_unload("hometown_periph_tr");
}

function stayahead_turbo_check() {
  level notify("stop_stayahead_turbo_check");
  self endon("death");
  level endon("stop_stayahead_turbo_check");
  var0 = "undefined";

  for(;;) {
    if(scripts\engine\utility::flag("stayahead_turbo")) {
      if(var0 != "175") {
        var0 = "175";
        scripts\sp\utility::enable_stayahead_turbo(250);
      }
    } else if(var0 != "undefined") {
      var0 = "undefined";
      scripts\sp\utility::enable_stayahead_turbo(undefined);
    }

    waitframe();
  }
}

function getfarrahbloodymodel() {
  if(scripts\common\utility::iswegameplatform()) {
    return "viewhands_farrah";
  }

  return "viewhands_farrah_bloody";
}

function skipchildrenkillingscene() {
  return scripts\common\utility::iswegameplatform();
}

function buried_kill_trigger() {
  scripts\engine\sp\utility::trigger_wait("backtrack_buried_kill_trigger", "script_noteworthy");

  if(!istransientloaded("hometown_buried_tr")) {
    level.player dodamage(1000, (0, 0, 0));
    return;
  }
}

function gas_cover_blown_monitor() {
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

    foreach(var1 in getaiarray("axis")) {
      if(isDefined(var1.stealth) && !var1[[var1.fnisinstealthcombat]]()) {
        continue;
      }

      var1 getenemyinfo(level.player);

      if(!var1 canshoot(level.player getEye())) {
        continue;
      }

      var2 = var1 gettagorigin("tag_flash");

      if(isDefined(level.player worldpointtoscreenpos(var2, getdvarint("MRNKTKLLKP")))) {
        continue;
      }

      magicbullet(var1.weapon, var2, level.player getEye(), var1);
    }
  }
}

function post_alley_spawn_func() {
  self.animname = "post_alley_russian0" + level.animname_incrementer;
  level.animname_incrementer += 1;
  self.ignoreall = 1;
  self.fnshouldplaypainanim = &wasaimeleedbyplayer;
}

function boss_blocker() {
  var0 = getEnt("boss_struggle_blocker_loc", "script_noteworthy");
  level.dead_boss_blocker scripts\engine\sp\utility::show_entity();
  level.dead_boss_blocker_use scripts\engine\sp\utility::show_entity();
  var1 = scripts\engine\utility::spawn_tag_origin(var0.origin, var0.angles);
  level.dead_boss_blocker linkTo(var1, "tag_origin");
  level.dead_boss_blocker_use linkTo(var1, "tag_origin");
  var1.origin = level.boss_struggle_anim_node.origin;
  var1.angles = level.boss_struggle_anim_node.angles;
}