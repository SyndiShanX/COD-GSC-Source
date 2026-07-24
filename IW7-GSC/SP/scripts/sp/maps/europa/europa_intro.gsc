/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\europa\europa_intro.gsc
***************************************************/

_id_9AB6() {
  scripts\engine\utility::flag_init("halo_jump_start");
  scripts\engine\utility::flag_init("halo_level_out");
  scripts\engine\utility::flag_init("halo_tip_down");
  scripts\engine\utility::flag_init("player_boosted");
  scripts\engine\utility::flag_init("player_boost_failed");
  scripts\engine\utility::flag_init("boost_required_start");
  scripts\engine\utility::flag_init("boost_required_end");
  scripts\engine\utility::flag_init("clouds_idle_start");
  scripts\engine\utility::flag_init("clouds_idle_end");
  scripts\engine\utility::flag_init("player_stabbed");
  scripts\engine\utility::flag_init("scar_saved_player");
  scripts\engine\utility::flag_init("cliffjump_complete");
  scripts\engine\utility::flag_init("teleport_scar1");
  scripts\engine\utility::flag_init("scars_spawned");
  scripts\engine\utility::flag_init("did_scope_hint");
  scripts\engine\utility::flag_init("cliffjump_boost_start");
  scripts\engine\utility::flag_init("cliffjump_boost_end");
  scripts\engine\utility::flag_init("safe_to_swap_models");
  scripts\engine\utility::flag_init("lookdown_started");
  scripts\engine\utility::flag_init("begin_dropship_bink");
  scripts\engine\utility::flag_init("dropship_bink_finished");
  scripts\engine\utility::flag_init("dropship_intro_vo_finished");
  level.player scripts\sp\utility::_id_65E0("frost_overlay_active");
  level.player scripts\sp\utility::_id_65E0("switched_weapon_during_tutorial");
  precachestring(&"EUROPA_JUMPIN");
}

_id_9ABC() {
  level.player notifyonplayercommand("melee_pressed", "+melee");
  level.player notifyonplayercommand("melee_pressed", "+melee_zoom");
  level.player notifyonplayercommand("melee_pressed", "+melee_breath");
  precachestring(&"EUROPA_BOOST_DEATH_HINT");
  precachestring(&"EUROPA_FREEZE_DEATH");
  precachestring(&"EUROPA_HALOJUMP_FAIL");
  precachemodel("weapon_bullet_iw5");
  precachemodel("tactical_knife_iw7_wm");
  precacheshader("vfx_ui_player_freeze_overlay");
  precacheshader("vfx_ui_player_freeze_overlay_02");
  precacheshader("arrow_left_white");
  precacheshader("arrow_right_white");
  scripts\sp\utility::_id_16EB("seeker_tutorial_hint", &"EUROPA_SEEKER_HINT", scripts\sp\maps\europa\europa_labs::_id_F164);
  scripts\sp\utility::_id_16EB("halojump_hint", &"EUROPA_HALOJUMP_HINT", ::_id_8893);
  scripts\sp\utility::_id_16EB("freefall_boost", &"EUROPA_FREEFALL_BOOST", ::_id_2CB4);
  scripts\sp\utility::_id_16EB("scope_y", &"EUROPA_HINT_SCOPE_Y", ::_id_9CF7);
  scripts\sp\utility::_id_16EB("scope_dpad", &"EUROPA_HINT_SCOPE_DPAD", ::_id_9CF7);
  scripts\sp\utility::_id_16EB("scope_both", &"EUROPA_HINT_SCOPE_BOTH", ::_id_9CF7);
  scripts\sp\utility::_id_16EB("scope_kb", &"EUROPA_HINT_SCOPE_KB", ::_id_9CF7);
  scripts\sp\utility::_id_16EB("scope_test", &"EUROPA_SCOPE_CONFIRM", ::_id_9B50);
  scripts\sp\utility::_id_16EB("fly_controller", &"EUROPA_FLY_CONTROLLER", ::_id_9EAC);
  scripts\sp\utility::_id_16EB("fly_kb", &"EUROPA_FLY_KB", ::_id_9EAC);
  scripts\sp\utility::_id_16EB("melee_hint", &"EUROPA_MELEE", ::_id_D42B);
  level.player scripts\sp\utility::_id_65E0("isFlying");
  level._id_CF99 = 0;
  level._id_D36A = 0;
  level._id_1C2A = 0;
}

_id_5858() {
  if(level.player scripts\engine\utility::is_player_gamepad_enabled())
    scripts\sp\utility::_id_56BA("fly_controller");
  else {
    thread scripts\sp\utility::_id_56BA("fly_kb");
    wait 0.05;
    thread _id_9EEC();
  }
}

_id_9EAC() {
  if(level.player scripts\engine\utility::is_player_gamepad_enabled())
    return level.player getnormalizedmovement() != (0, 0, 0) || level.player _meth_814B() != (0, 0, 0);
  else
    return level.player scripts\sp\utility::_id_65DB("isFlying");
}

_id_9EEC() {
  level.player endon("global_hint_in_use");
  level.player notifyonplayercommand("moving", "+forward");
  level.player notifyonplayercommand("moving", "+back");
  level.player notifyonplayercommand("moving", "+moveleft");
  level.player notifyonplayercommand("moving", "+moveright");
  level.player waittill("moving");
  level.player scripts\sp\utility::_id_65E1("isFlying");
}

_id_9CF7() {
  if(level.player scripts\sp\utility::_id_65DB("switched_weapon_during_tutorial"))
    return 1;

  if(issubstr(level.player getcurrentweapon(), "hybrid_snow"))
    return !level.player _meth_8519(level.player getcurrentprimaryweapon());
  else
    return level.player _meth_8519(level.player getcurrentprimaryweapon());
}

_id_9B50() {
  return level.player adsButtonPressed();
}

_id_D42B() {
  return scripts\engine\utility::flag("player_stabbed") || scripts\engine\utility::flag("scar_saved_player");
}

_id_1873() {
  foreach(var_1 in level.createfxent) {
    if(isDefined(var_1.v["exploder"]) && var_1.v["exploder"] == "clouds")
      var_1.v["origin"] = var_1.v["origin"] + (-193, 1501, 0);
  }
}

_id_5DF1() {}

_id_5E01() {
  scripts\sp\maps\europa\europa_util::_id_107C5();
  scripts\engine\utility::array_thread(level._id_EBCA, scripts\sp\utility::_id_BE49);
  scripts\engine\utility::array_thread(level._id_EBCA, scripts\sp\utility::_id_DC45, "raise");
  _id_5EA4();
  _id_0E4B::_id_8E06(1);
  level._id_D267 = scripts\sp\utility::_id_10639("player_rig", level.player.origin, level.player.angles);
  level._id_D267 dontinterpolate();
  level.player scripts\sp\maps\europa\europa_util::_id_D85C();
  level._id_5D6C _id_0BBF::_id_1101E();
  level.player playerlinktodelta(level._id_D267, "tag_player", 1, 0, 0, 0, 0, 1);
  level.player._id_8632 = spawn("script_origin", level.player.origin);
  level.player._id_8632 linkTo(level._id_D267, "tag_player", (0, 0, 0), (0, 0, 0));
  level.player _meth_823F(level.player._id_8632);

  if(scripts\sp\utility::_id_9BB5()) {
    level._id_EBBC scripts\anim\shared::placeweaponon(level._id_EBBC.weapon, "none");
    level._id_EBBC._id_8719 = scripts\sp\utility::_id_10639("fhr40", level._id_5D6C.origin, level._id_5D6C.angles);
    level._id_EBBC._id_8719 attach("attachment_suppressor_energy_1_wm");
    level._id_5D6C.group = [level._id_EBBB, level._id_EBBC, level._id_EBBC._id_8719, level._id_D267, level._id_5D6C];
    level._id_EBBC thread _id_EBBD();
  } else
    level._id_5D6C.group = [level._id_EBBB, level._id_EBBC, level._id_D267, level._id_5D6C];

  level._id_5D6C._id_EBCA = [level._id_EBBB, level._id_EBBC, level._id_D267];
  thread _id_1873();
  thread _id_5DFD();
  thread _id_5ED8();
  setumbraportalstate("halo_portal", 0);
}

_id_EBBD() {
  level waittill("scar2_stow_weapon");
  scripts\anim\shared::placeweaponon(self.weapon, "right");
  self._id_8719 hide();
}

_id_5DEF() {
  level.player _meth_82C0("europa_dropship_intro_fullscreen_hit", 0.0);

  if(!isDefined(level._id_2B4C)) {
    level._id_2B4C = scripts\sp\hud_util::_id_48B7("black", 1);
    level._id_2B4C.foreground = 0;
  }

  level.player _meth_81DE(55, 0.05);
  _id_5E01();
  level._id_5D6C scripts\sp\anim::_id_1EC1(level._id_5D6C.group, "europa_dropship_intro", "tag_origin");
  thread _id_D324();
  thread firstline();
  thread _id_A635();
  thread _id_5E0F();
  thread _id_3F69();
  thread _id_59E8();
  thread _id_5E75();
  level._id_EBBC._id_C383 = level._id_EBBC.headmodel;
  level._id_EBBC detach(level._id_EBBC.headmodel);
  level._id_EBBC attach("head_hero_t_hqss");
  level._id_EBBB._id_C383 = level._id_EBBB.headmodel;
  level._id_EBBB detach(level._id_EBBB.headmodel);
  level._id_EBBB attach("head_hero_sipes_cine_hqss");
  level._id_5D6C scripts\sp\anim::_id_1F2C(level._id_5D6C.group, "europa_dropship_intro", "tag_origin");
}

firstline() {
  scripts\sp\utility::_id_13705();
  level.player thread scripts\sp\utility::play_sound_on_entity("europa_plr_understoodwarlordwell");
}

_id_9A9F() {
  scripts\engine\utility::flag_set("begin_dropship_bink");
  level.player _meth_82C0("europa_dropship_intro_fullscreen_hit", 0.0);
  level._id_5D6C scripts\engine\utility::delaythread(1.5, scripts\sp\utility::play_sound_on_entity, "europa_rpr_warlordactual");

  if(!isDefined(level._id_2B4C)) {
    level._id_2B4C = scripts\sp\hud_util::_id_48B7("black", 1);
    level._id_2B4C.foreground = 0;
  }
}

_id_5E25() {
  _id_5E01();
  scripts\engine\utility::flag_set("dropship_door_open");
  level._id_5D6C _id_0BBC::_id_C5F1("right", 0, 1, 0);
  scripts\engine\utility::array_thread(level._id_EBCA, scripts\sp\utility::_id_DC45, "lower");
  level._id_EBBC._id_C383 = level._id_EBBC.headmodel;
  level._id_EBBC detach(level._id_EBBC.headmodel);
  level._id_EBBC attach("head_hero_t_hqss");
  level._id_EBBB._id_C383 = level._id_EBBB.headmodel;
  level._id_EBBB detach(level._id_EBBB.headmodel);
  level._id_EBBB attach("head_hero_sipes_cine_hqss");
  _id_D324();
  level.player _meth_81DE(55, 0.05);
  setglobalsoundcontext("atmosphere", "helmet", 1.0);
  setomnvar("ui_europa_halo_drop_state", 1);
  setomnvar("ui_europa_halo_drop_state", 3);
  level._id_E7C2 = scripts\sp\utility::_id_7C23();
  level._id_E7C2 thread scripts\sp\utility::_id_E7C9(1, 0.1);
  level._id_E7C2 scripts\engine\utility::delaythread(0.1, scripts\sp\utility::_id_E7C9, 0.2, 1);
}

_id_D324() {
  level.player lerpviewangleclamp(1, 0.5, 0.5, 15, 15, 5, 12);
  level.player setviewangleresistance(15, 15, 5, 12);
}

_id_134E2() {
  scripts\sp\maps\europa\europa_util::_id_134B7("europa_tee_eyeofthestorm");
  scripts\sp\maps\europa\europa_util::_id_134B7("europa_sip_stickwiththegroup");
  scripts\sp\maps\europa\europa_util::_id_134B7("europa_tee_learntokeepup");
}

_id_5E21() {
  level endon("player_boost_failed");

  if(scripts\sp\utility::_id_93A6()) {
    thread scripts\sp\specialist_MAYBE::_id_8E06();
    thread scripts\sp\specialist_MAYBE::_id_F53C(0);
  }

  thread _id_A4E1();

  if(!scripts\sp\utility::_id_9BB5()) {
    while(!isDefined(level._id_5D6C))
      wait 0.05;
  }

  scripts\engine\utility::array_thread(level._id_EBCA, scripts\sp\utility::_id_BE4A);
  thread _id_5E06();
  thread _id_5E24();
  level._id_5D6C thread scripts\sp\anim::_id_1EE7(level._id_5D6C._id_EBCA, "europa_dropship_idle", "stop_loop", "tag_origin");
  level._id_EBBC detach("head_hero_t_hqss");
  level._id_EBBC attach(level._id_EBBC._id_C383);
  level._id_EBBB detach("head_hero_sipes_cine_hqss");
  level._id_EBBB attach(level._id_EBBB._id_C383);

  if(isDefined(level._id_EBBC._id_8719))
    level._id_EBBC._id_8719 delete();

  scripts\sp\utility::_id_2669("jump");
  scripts\sp\maps\europa\europa_util::_id_134B7("europa_tee_gotimewolfcallit");
  _id_D86B();
  level._id_5D6C notify("stop_loop");
  thread _id_257A();
  scripts\engine\utility::flag_set("halo_jump_start");
  scripts\engine\utility::exploder("ex_jump_out");
  thread _id_25DF();
  level.player._id_8892 = level._id_5D6C scripts\engine\utility::spawn_tag_origin();
  level._id_D267 linkTo(level.player._id_8892, "tag_origin");
  level.player._id_8892 thread scripts\sp\anim::_id_1F35(level._id_D267, "europa_dropship_halo_jump", "tag_origin");
  scripts\engine\utility::delaythread(4.5, ::_id_CFDC);
  thread _id_1C0C();
  level._id_EBCB = level._id_5D6C scripts\engine\utility::spawn_tag_origin();
  level._id_EBBB linkTo(level._id_EBCB, "tag_origin");
  level._id_EBBC linkTo(level._id_EBCB, "tag_origin");
  level._id_EBCB thread scripts\sp\anim::_id_1F2C([level._id_EBBB, level._id_EBBC], "europa_dropship_halo_jump", "tag_origin");

  if(level.console || level.player usinggamepad())
    level.player lerpviewangleclamp(1, 0.5, 0.5, 10, 10, 10, 10);

  level.player _meth_8392(0, 1.6, 0.9);
  level.player _meth_81DE(65, 3);
  scripts\engine\utility::delaythread(3.5, ::_id_EBC8, 1);
  scripts\engine\utility::delaythread(8.2, ::_id_EBC8, 0);
  scripts\engine\utility::array_thread(level._id_EBCA, ::_id_EBC2);
  _id_F8D3();
  thread _id_8890();
  scripts\engine\utility::flag_wait("player_boosted");
  _id_D1B3();
}

_id_257A() {
  level.player scripts\engine\utility::delaycall(0.5, ::playsound, "europa_dropship_halo_plr_01");
  level.player scripts\engine\utility::delaythread(0.62, scripts\sp\utility::_id_1034D, "europa_plr_gogo");
  level.player scripts\engine\utility::delaycall(0.62, ::playrumbleonentity, "light_2s");
  level.player scripts\engine\utility::delaycall(1.63333, ::playsound, "europa_dropship_halo_plr_02");
  level.player scripts\engine\utility::delaythread(1.7, scripts\sp\utility::_id_1034D, "europa_plr_go");
  level.player scripts\engine\utility::delaycall(1.7, ::playrumbleonentity, "light_2s");
}

_id_EBC8(var_0) {
  var_1 = ["J_Ankle_LE", "J_Ankle_RI", "J_Wrist_LE", "J_Wrist_RI"];

  foreach(var_3 in level._id_EBCA) {
    foreach(var_5 in var_1) {
      if(var_0) {
        playFXOnTag(scripts\engine\utility::getfx("wisp_loop"), var_3, var_5);
        continue;
      }

      stopFXOnTag(scripts\engine\utility::getfx("wisp_loop"), var_3, var_5);
    }
  }
}

_id_F39B() {
  level endon("player_boosted");
  var_0 = scripts\sp\utility::_id_864C(level.player.origin);

  while(level.player.origin[2] - var_0[2] > 100) {
    var_0 = scripts\sp\utility::_id_864C(level.player.origin);
    wait 0.05;
  }

  scripts\engine\utility::flag_set("player_boost_failed");
  _id_D067();
}

_id_D067() {
  var_0 = level._id_D267 scripts\engine\utility::spawn_tag_origin();
  level._id_D267 linkTo(var_0);
  var_0 thread scripts\sp\anim::_id_1F35(level._id_D267, "europa_dropship_halo_death_rel", "tag_origin");
  var_1 = [level.player, level._id_D267];
  var_2 = scripts\engine\utility::getStruct("sipes_lookaround", "targetname").origin[2] + 70;
  var_3 = (level._id_D267.origin[0], level._id_D267.origin[1], var_2);
  var_4 = getanimlength(level._id_D267 scripts\sp\utility::_id_7DC1("europa_dropship_halo_death_rel"));
  var_5 = 3;
  level._id_D267 _meth_82B1(level._id_D267 scripts\sp\utility::_id_7DC1("europa_dropship_halo_death_rel"), var_5);
  level._id_D267 _meth_82B0(level._id_D267 scripts\sp\utility::_id_7DC1("europa_dropship_halo_death_rel"), 0.6);
  var_4 = var_4 * (1 / var_5);
  var_0 moveTo(var_3, var_4);
  wait(var_4);
  level.player playRumbleOnEntity("heavy_2s");
  level._id_E7C2 delete();
  level.player freezecontrols(1);
  setomnvar("ui_death_hint", 0);
  setomnvar("ui_hide_weapon_info", 1);
  setsaveddvar("hud_showstance", 0);
  setsaveddvar("actionSlotsHide", 1);
  level.player _meth_8497();
  thread _id_25DE();
  earthquake(1, 1, level.player.origin, 200);
  level.player thread _id_0B60::_id_8DDF();
  level.player thread _id_0B60::_id_2BC7();
  _id_0B60::_id_F322("EUROPA_BOOST_DEATH_HINT");
  _id_0B60::_id_F32D();
  playFX(level._effect["deathfx_bloodpool_generic"], level.player.origin);
  wait 3;
  level.player scripts\sp\utility::_id_B8D1();
}

_id_1C0C() {
  _id_13760(0.58);
  level._id_1C2A = 1;
  thread _id_EBC8(1);

  foreach(var_1 in level._id_EBCA) {
    playFXOnTag(scripts\engine\utility::getfx("thrust_loop"), var_1, "tag_fx_bottom");

    if(var_1._id_1FBB == "scar1")
      var_1 playSound("scn_europa_scar1_boost");
    else
      var_1 playSound("scn_europa_scar2_boost");

    wait 0.3;
  }

  scripts\engine\utility::flag_wait("boost_required_end");
  thread _id_EBC8(0);
  level._id_1C2A = 0;
}

_id_F8D3() {
  _id_13760(0.79);
  scripts\sp\utility::_id_10FEC("clouds");
  scripts\sp\utility::_id_10FEC("cloudsreveal");
  scripts\engine\utility::flag_set("clouds_idle_start");
  _id_13760(0.87);
  level.player thread scripts\sp\utility::play_sound_on_entity("europa_tee_boostboost1");
  wait 0.5;
  scripts\engine\utility::flag_set("boost_required_start");
  scripts\engine\utility::flag_set("clouds_idle_end");
}

_id_AB79(var_0, var_1) {
  level notify("lerping_dive_anim_rate");
  level endon("lerping_dive_anim_rate");
  var_2 = _id_7944();
  var_3 = var_0 - var_2;
  var_4 = var_1 / 0.05;
  var_5 = var_3 / var_4;
  var_6 = gettime() + var_1 * 1000;

  while(gettime() < var_6) {
    var_2 = var_2 + var_5;
    _id_F359(var_2);
    wait 0.05;
  }

  _id_F359(var_0);
}

_id_13760(var_0) {
  while(_id_7945() < var_0)
    wait 0.05;
}

_id_7945() {
  return level._id_D267 islegacyagent(level._id_D267 scripts\sp\utility::_id_7DC1("europa_dropship_halo_jump"));
}

_id_7944() {
  return level._id_D267 _meth_8104(level._id_D267 scripts\sp\utility::_id_7DC1("europa_dropship_halo_jump"));
}

_id_F359(var_0) {
  level._id_D267 _meth_82B1(level._id_D267 scripts\sp\utility::_id_7DC1("europa_dropship_halo_jump"), var_0);
  level._id_EBBB _meth_82B1(level._id_EBBB scripts\sp\utility::_id_7DC1("europa_dropship_halo_jump"), var_0);
  level._id_EBBC _meth_82B1(level._id_EBBC scripts\sp\utility::_id_7DC1("europa_dropship_halo_jump"), var_0);
}

_id_CFE1() {
  level._id_CFE4 _id_CFDB(1, 1);
  _id_13760(0.75);
  level._id_CFE4 _id_CFDB(0, 2);
  level waittill("player_landed");
  level notify("stop_player_controlled_updates");
}

_id_AB9D() {
  level endon("player_boosted");
  var_0 = 0;
  var_1 = 0.01;

  for(;;) {
    var_2 = level.player._id_8892.origin - level._id_EBCB.origin;
    level._id_EBCB.origin = level._id_EBCB.origin + var_2 * var_0;
    var_0 = var_0 + var_1;
    wait 0.05;
  }
}

_id_13E6B() {
  level._id_CFE4._id_BC49 = (0, 0, 0);
  level._id_CFE4._id_C3CA = (0, 0, 0);
  level._id_CFE4._id_11532 = (0, 0, 0);
  level._id_CFE4._id_11535 = 0;
  level._id_CFE4._id_11533 = 0;
  level._id_CFE4._id_13D31 = (0, 0, 0);
  level._id_CFE4._id_13D34 = (0, 0, 0);
  level._id_CFE4._id_13D78 = 0;
  level._id_CFE4._id_B7D6 = (0, 0, 0);
  level._id_CFE4._id_B7D8 = (0, 0, 0);
  level._id_CFE4._id_B7D9 = 0;
  level._id_CFE4._id_7440 = 0;
}

_id_CF62() {
  _id_9500();
}

#using_animtree("player");

_id_9500() {
  level._id_D267 _meth_82A2(%europa_dropship_intro_plr_halo_jump_lr, 1, 0, 0);
  level._id_D267 _meth_82B0(%europa_dropship_intro_plr_halo_jump_lr, 0.5);
}

_id_CFDC() {
  level endon("stop_player_controlled_updates");
  level.player playRumbleOnEntity("heavy_2s");
  scripts\engine\utility::delaythread(1.25, ::_id_5858);
  scripts\engine\utility::delaythread(0.9, scripts\sp\maps\europa\europa_util::_id_134B7, "europa_tee_staytight");
  thread _id_CF62();
  level._id_CFE4 = spawnStruct();
  _id_13E6B();
  level._id_CFE4._id_B3D1 = 0;
  level._id_CFE4._id_13D33 = 1;
  level._id_CFE4._id_2B8D = 0;
  thread scripts\sp\utility::_id_AB9A("r_mbRadialoverridechromaticAberration", 0.015, 3);
  thread scripts\sp\utility::_id_AB9A("r_mbradialoverridestrength", 0.011, 3);
  level._id_CFE4 thread _id_CFE1();
  var_0 = level.player._id_8892;
  var_1 = anglesToForward(var_0.angles);
  var_2 = anglestoright(var_0.angles);
  var_3 = anglestoup(var_0.angles);
  var_4 = var_0.origin;
  level._id_CFE4 thread _id_B2EC(var_4, var_0);
  level._id_CFE4 thread _id_5727();
  thread _id_5E23();

  for(;;) {
    level._id_CFE4 _id_CFDD(var_1, var_2, var_3);
    level._id_CFE4._id_13D34 = level._id_CFE4._id_13D34 + level._id_CFE4._id_13D31 * level._id_CFE4._id_13D78 * level._id_CFE4._id_13D33;
    level._id_CFE4._id_B7D8 = level._id_CFE4._id_B7D8 + level._id_CFE4._id_B7D6 * level._id_CFE4._id_B7D9;
    var_5 = level._id_CFE4._id_BC49 + level._id_CFE4._id_13D34 + level._id_CFE4._id_B7D8;
    var_0.origin = var_4 + var_5 * level._id_CFE4._id_B3D1;
    _id_CFE3(level._id_CFE4._id_BBF8[0], level._id_CFE4._id_BBF8[1], level._id_CFE4._id_B3D1);

    if(level._id_CFE4._id_2B8D) {
      level._id_CFE4 waittill("quickturn_master_blend_complete");
      continue;
    }

    wait 0.05;
  }
}

_id_B2EC(var_0, var_1) {
  level endon("stop_player_controlled_updates");
  var_2 = 0.09;
  var_3 = 0.45;
  var_4 = var_2;
  var_5 = 0.05;
  var_6 = 9;
  var_7 = 4;
  self._id_13D31 = scripts\engine\utility::random([anglesToForward(level.player._id_8892.angles), anglesToForward(level.player._id_8892.angles) * -1]);
  var_8 = 1;

  for(;;) {
    wait 0.05;

    if(var_4 + var_5 < var_3)
      var_4 = clamp(var_4 + var_5, var_2, var_3);
    else
      var_4 = var_3;

    if(!var_8)
      self._id_13D31 = _id_7D7D();
    else
      var_8 = 0;

    while(!_id_9C77()) {
      self._id_13D78 = clamp(self._id_13D78 + var_4, 0, var_6);
      wait 0.05;
    }

    while(_id_9C77()) {
      self._id_13D78 = clamp(self._id_13D78 - var_4, var_7, var_6);
      wait 0.05;
    }
  }
}

_id_9C77() {
  if(level.console || level.player usinggamepad())
    return length(level.player getnormalizedmovement()) >= 0.1 || length(level.player _meth_814B()) >= 0.1;
  else
    return length(level.player getnormalizedmovement()) >= 0.1;
}

_id_7D7D() {
  var_0 = scripts\sp\math::_id_7ADE(level._id_EBCA[0].origin, level._id_EBCA[1].origin);
  var_0 = scripts\sp\math::_id_7ADE(var_0, level._id_EBCA[0].origin);

  if(level.player getEye()[0] > var_0[0])
    return anglesToForward(level.player._id_8892.angles);
  else
    return anglesToForward(level.player._id_8892.angles) * -1;
}

_id_CFDD(var_0, var_1, var_2) {
  level endon("stop_player_controlled_updates");
  var_3 = 0.0625;
  var_4 = 1;
  var_5 = 40;
  var_6 = 18;

  if(level.console || level.player usinggamepad()) {
    var_7 = [];
    var_7[0] = level.player getnormalizedmovement();
    var_7[1] = level.player _meth_814B();
    var_7[0] = var_7[0] * self._id_B3D1;
    var_7[1] = var_7[1] * self._id_B3D1;
    var_8 = max(length(var_7[0]), length(var_7[1]));
    var_9 = (var_7[0] + var_7[1]) * 0.5;
    var_9 = vectorNormalize(var_9) * var_8;
  } else {
    var_9 = level.player getnormalizedmovement();
    var_9 = var_9 * self._id_B3D1;
  }

  self._id_11535 = self._id_11535 + var_9[0] * var_6;
  self._id_11533 = self._id_11533 + var_9[1] * var_6;

  if(self._id_11535 > var_5)
    self._id_11535 = var_5;
  else if(self._id_11535 < var_5 * -1)
    self._id_11535 = var_5 * -1;

  self._id_11535 = self._id_11535 * var_4;
  self._id_11533 = self._id_11533 * var_4;
  self._id_11532 = self._id_11535 * var_1 + self._id_11533 * var_0 * -1;
  self._id_BC49 = scripts\sp\math::_id_AB6F(self._id_BC49, self._id_11532, var_3);
  self._id_BBF8 = self._id_C3CA - self._id_BC49;
  self._id_C3CA = self._id_BC49;
}

_id_CFDB(var_0, var_1) {
  self notify("new_master_blend");
  self endon("new_master_blend");

  if(var_1 == 0) {
    self._id_B3D1 = var_0;
    return;
  }

  self._id_2B8D = 1;
  var_2 = (var_0 - self._id_B3D1) / var_1 * 0.05;
  var_3 = self._id_B3D1;
  var_4 = var_1;

  while(var_4 > 0) {
    var_3 = var_3 + var_2;
    self._id_B3D1 = clamp(var_3, 0, 1);
    var_4 = var_4 - 0.05;
    self notify("quickturn_master_blend_complete");
    wait 0.05;
  }

  self._id_B3D1 = var_0;
  self._id_2B8D = 0;
  self notify("quickturn_master_blend_complete");
}

_id_CFE3(var_0, var_1, var_2) {
  level endon("stop_player_controlled_updates");
  var_1 = var_1 * (0.12 * var_2);
  var_0 = var_0 * (0.041 * var_2);
  var_1 = clamp(var_1, -1, 1);
  var_0 = clamp(var_0, -1, 1);
  var_1 = var_1 * -1;
  var_1 = 0.5 + 0.5 * var_1;
  var_0 = 0.5 + 0.5 * var_0;
  var_3 = 0.7;
  var_4 = 1;
  var_5 = 0.2;
  level._id_D267 childthread _id_CFE2(%europa_dropship_intro_plr_halo_jump_fb, var_1, var_3, var_4, var_5, 0);
  level._id_D267 childthread _id_CFE2(%europa_dropship_intro_plr_halo_jump_lr, var_0, var_3, var_4, var_5, 1);
}

_id_CFE2(var_0, var_1, var_2, var_3, var_4, var_5) {
  self notify("stop_current_anim_time_lerp" + var_5);
  self endon("stop_current_anim_time_lerp" + var_5);

  if(!isDefined(var_5))
    var_5 = 1;

  if(var_1 == 1)
    var_1 = 0.999;
  else if(var_1 == 0)
    var_1 = 0.001;

  var_6 = getanimlength(var_0);
  var_2 = var_2 * var_6;
  var_3 = var_3 * var_6;

  if(!isDefined(self._id_1EE3))
    self._id_1EE3 = [];

  if(!isDefined(self._id_1EE3[var_5]))
    self._id_1EE3[var_5] = 0.0;

  for(var_7 = self islegacyagent(var_0); abs(var_7 - var_1) > 0.0; var_7 = self islegacyagent(var_0)) {
    var_8 = (var_1 - var_7) * var_6 / 0.05;
    var_9 = abs(self._id_1EE3[var_5] - var_8);

    if(var_9 < var_2)
      self._id_1EE3[var_5] = var_8;

    if(self._id_1EE3[var_5] < var_8)
      self._id_1EE3[var_5] = self._id_1EE3[var_5] + var_2;
    else
      self._id_1EE3[var_5] = self._id_1EE3[var_5] - var_2;

    if(abs(self._id_1EE3[var_5]) > var_3)
      self._id_1EE3[var_5] = self._id_1EE3[var_5] * (var_3 / abs(self._id_1EE3[var_5]));

    var_10 = 1;
    var_11 = abs(var_1 - var_7);

    if(self._id_1EE3[var_5] > 0 && var_1 > var_7)
      var_10 = scripts\sp\math::_id_C097(0, var_4, var_11);
    else if(self._id_1EE3[var_5] < 0 && var_1 < var_7)
      var_10 = scripts\sp\math::_id_C097(0, var_4, var_11);

    self._id_1EE3[var_5] = self._id_1EE3[var_5] * var_10;
    self _meth_82B1(var_0, self._id_1EE3[var_5]);
    wait 0.05;
  }

  self _meth_82B0(var_0, var_1);
  self _meth_82B1(var_0, 0);
}

_id_5727() {
  level endon("lightning_death");
  level endon("boost_required_start");
  self._id_2A4C = spawn("script_origin", level.player.origin);
  self._id_2A4C linkTo(level.player);
  level.player._id_58DF = 0;
  var_0 = 600;
  var_1 = 0.175;
  var_2 = 0.4;
  var_3 = 0;
  var_4 = 0;
  var_5 = 110;
  var_6 = 0;
  var_7 = undefined;
  var_8 = undefined;

  for(;;) {
    var_9 = _id_7942();
    var_10 = scripts\sp\math::_id_7ADE(level._id_EBCA[0].origin, level._id_EBCA[1].origin);
    self._id_7440 = scripts\sp\math::_id_C097(0, var_0, var_9);

    if(level.player getEye()[0] > var_10[0])
      var_11 = "right";
    else
      var_11 = "left";

    if(self._id_7440 <= 0.175) {
      var_7 = undefined;
      var_4 = 0;
      var_3 = 0;
    } else
      var_3++;

    if(self._id_7440 >= var_2 || var_4 > var_5 * 0.5) {
      if(var_6) {
        var_7 = "scn_europa_halo_altitude_beep_lp_02";
        var_12 = _id_E758(scripts\engine\utility::mod(var_3, 5));

        if(!var_12) {
          var_6 = 0;
          thread _id_B293("red", var_11, 11);
          var_4 = var_4 + 4;
        }
      } else {
        var_7 = "scn_europa_halo_altitude_beep_lp_03";
        var_12 = _id_E758(scripts\engine\utility::mod(var_3, 4));

        if(!var_12) {
          thread _id_B293("red", var_11, 11);
          var_4 = var_4 + 4;
        }
      }
    } else if(self._id_7440 >= var_1) {
      var_6 = 1;
      var_4 = var_4 + 1;
      var_12 = _id_E758(scripts\engine\utility::mod(var_3, 5));

      if(!var_12)
        thread _id_B293("white", var_11, 9);
    }

    if(var_4 > var_5)
      thread _id_D1D3();

    if(isDefined(var_7)) {
      if(!isDefined(var_8) || var_7 != var_8) {
        self._id_2A4C playLoopSound(var_7);
        level.player._id_58DF = 1;
      }
    } else {
      self._id_2A4C stoploopsound();
      level.player._id_58DF = 0;
    }

    wait 0.05;
  }
}

_id_D1D3() {
  setomnvar("ui_hide_weapon_info", 1);
  var_0 = level.player getEye();
  var_1 = var_0 + anglesToForward(level.player getplayerangles()) * 20;
  var_2 = var_1 - var_0;
  setsunlight(10000, 10000, 15000);
  playworldsound("scn_europa_lightning_death", (0, 0, 0));
  level.player _meth_809A(1, 1);
  earthquake(2, 10, level.player.origin, 1000);
  level.player thread _id_0B60::_id_8DDF();
  level.player thread _id_0B60::_id_2BC7();
  level.player freezecontrols(1);
  level notify("lightning_death");
  level.player _meth_83A1();
  level.player _meth_81D0();
  wait 4;
  scripts\sp\utility::_id_B8D1();
  level waittill("forever");
}

_id_B293(var_0, var_1, var_2) {
  level endon("lightning_death");

  if(var_0 == "white")
    var_0 = (1, 1, 1);
  else if(var_0 == "orange")
    var_0 = (1, 0.5, 0);
  else
    var_0 = (1, 0, 0);

  if(var_1 == "left") {
    var_2 = var_2 * -1;
    var_3 = "arrow_left_white";
    var_4 = 640;
  } else {
    var_3 = "arrow_right_white";
    var_4 = 0;
  }

  var_5 = newclienthudelem(level.player);
  var_6 = 60;
  var_7 = 140;
  var_5 setshader(var_3, 50, var_7);
  var_5.color = var_0;
  var_5.x = var_4;
  var_5.y = 240 - var_7 / 2;
  var_5.alpha = 0.75;
  var_8 = 0.6;
  var_9 = gettime() + var_8 * 1000;
  var_5 thread scripts\sp\hud_util::_id_6AAB(0, var_8);
  var_10 = var_6 - var_7;
  var_11 = var_7;
  var_12 = var_10 / (var_8 / 0.05);

  while(gettime() < var_9) {
    var_13 = var_11;
    var_14 = var_5.y;
    var_11 = int(var_11 + var_12);
    var_15 = var_13 - var_11;
    var_5.alpha = var_5.alpha - 0.01;
    var_5.x = var_5.x + var_2;
    var_5.y = var_5.y + var_15 / 2;
    var_5 setshader(var_3, 50, var_11);
    wait 0.05;
  }

  var_5 destroy();
}

_id_7942() {
  var_0 = abs(level._id_EBCA[0].origin[0] - level.player getEye()[0]);
  var_1 = abs(level._id_EBCA[1].origin[0] - level.player getEye()[0]);
  return min(var_0, var_1);
}

_id_F561(var_0) {
  if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_0, cos(113))) {
    setblur(0, 0.15);
    _id_F562(clamp(level._id_CFE4._id_7440, 0.1, 1), var_0);
  } else
    setblur(5, 0.15);
}

_id_E757(var_0) {
  return float(int(var_0 * 100 + 0.5)) / 100;
}

_id_E758(var_0) {
  return float(int(var_0 * 10 + 0.5)) / 10;
}

_id_5E22() {
  if(getdvarint("debug_europa"))
    iprintln("opening umbra portal 'halo_portal' ");

  setumbraportalstate("halo_portal", 1);

  if(scripts\sp\utility::_id_93A6()) {
    thread scripts\sp\specialist_MAYBE::_id_8E06();
    thread scripts\sp\specialist_MAYBE::_id_F53C(0);
  } else
    _id_0E4B::_id_8E06();
}

_id_25DE() {
  playworldsound("scn_jump_from_plane_booster_death_lr", level.player.origin);
}

_id_25DF() {
  level._id_1178C = spawn("script_origin", level.player.origin);
  level._id_1178C linkTo(level.player);
  level._id_1178D = spawn("script_origin", level.player.origin);
  level._id_1178D linkTo(level.player);
  level._id_1178C playSound("scn_jump_from_plane_01_lr");
  wait 3.4;
  level.player _meth_82C0("europa_halo_jump", 0.5);
  setmusicstate("");
  thread _id_8891();
  _id_13760(0.58);
  level._id_1178C playSound("scn_jump_from_plane_02_lr");
  level.player playRumbleOnEntity("heavy_3s");
  level.player playSound("scn_jump_from_plane_booster_save_lr");
}

_id_8891() {
  level endon("player_landed");
  level._id_6E87 = spawn("script_origin", level.player.origin);
  level._id_6E87 linkTo(level.player);
  wait 1;
  level._id_6E87 _meth_8278(0);
  var_0 = 0;
  var_1 = 0;

  for(;;) {
    var_2 = level.player getnormalizedmovement();
    var_3 = var_2[1];

    if(var_3 < 0)
      var_3 = var_3 * -1;

    if(var_3 > 0.15) {
      if(var_0 == 0) {
        level._id_6E87 playLoopSound("scn_europa_halo_flapping_lp");
        var_0 = 1;
        wait 0.05;
      }

      var_3 = scripts\sp\math::_id_AB6F(var_1, var_3, 0.1);
      level._id_6E87 _meth_8278(var_3, 0.1);
      var_1 = var_3;
      wait 0.1;
      continue;
    }

    level._id_6E87 _meth_8278(0, 0.5);
    wait 0.5;
    level._id_6E87 stoploopsound("scn_europa_halo_flapping_lp");
    var_0 = 0;
    var_1 = 0;
    wait 0.05;
  }
}

_id_25F8() {
  playworldsound("scn_jump_from_plane_booster_save_lr", level.player.origin);
  level.player clearclienttriggeraudiozone(2.0);
  thread _id_2CC9();
  level._id_1178C _meth_8278(0, 1.0);
  wait 1.1;
  level._id_1178C stopsounds();
}

_id_2CC9() {
  wait 5.0;
  setmusicstate("mx_168_surveylandscape");
}

_id_D1B3() {
  thread _id_8E4A();
  level.player thread scripts\sp\maps\europa\europa_util::_id_8E34(1);
  level.player thread scripts\sp\maps\europa\europa_util::_id_13013(1);
  level.player _meth_809A(0, 2);
  thread _id_DFCD();
  thread _id_7451();
  level waittill("player_landed");
  level.player playRumbleOnEntity("damage_heavy");
  level._id_E7C2 delete();
  _id_0E4B::_id_8DEA();
  setomnvar("ui_hud_heist_boost", 0);
  level notify("kill_boost_button");
  level._id_5D6C delete();
  scripts\sp\utility::_id_10FEC("ex_jump_out");

  if(isDefined(level._id_6E87)) {
    level._id_6E87 stopsounds();
    wait 0.05;

    if(isDefined(level._id_6E87))
      level._id_6E87 delete();
  }

  level.player._id_8632 rotateTo((0, 0, 0), 0.5);
  level waittill("land_animation_over");
  level.player _meth_823F(undefined);
  level.player._id_8632 delete();
  thread scripts\sp\maps\europa\europa_util::_id_DF3E();

  if(isDefined(level._id_D267))
    level._id_D267 delete();

  level.player._id_8892 delete();

  if(isDefined(level._id_1178C))
    level._id_1178C delete();

  if(isDefined(level._id_1178D))
    level._id_1178D delete();
}

_id_F562(var_0, var_1) {
  if(isDefined(var_0))
    var_2 = var_0;
  else
    var_2 = 1;

  var_3 = 0.85 * var_2;
  var_4 = 0.22 * var_2;
  setsaveddvar("r_mbRadialoverrideposition", var_1);
  setsaveddvar("r_mbRadialoverridechromaticAberration", var_3);
  setsaveddvar("r_mbradialoverridestrength", var_4);
}

_id_DC5D(var_0) {
  level endon("removing_blur_effects");
  var_1 = getdvarfloat("r_mbRadialoverridechromaticAberration");
  var_2 = getdvarfloat("r_mbradialoverridestrength");

  if(isDefined(var_0))
    var_3 = var_0;
  else
    var_3 = 1;

  var_1 = 0;
  var_2 = 0;
  var_4 = 0.075;
  var_5 = 0.01;
  var_6 = 0.85;
  var_7 = 0.95;

  while(getdvarfloat("r_mbRadialoverridechromaticAberration") < var_6 && getdvarfloat("r_mbradialoverridestrength") < var_7) {
    var_1 = clamp(var_1 + var_4, 0, var_6);
    var_2 = clamp(var_2 + var_5, 0, var_7);
    setsaveddvar("r_mbRadialoverridechromaticAberration", var_1);
    setsaveddvar("r_mbradialoverridestrength", var_2);
    wait 0.05;
  }
}

_id_DFCD() {
  level notify("removing_blur_effects");
  var_0 = getdvarfloat("r_mbRadialoverridechromaticAberration");
  var_1 = getdvarfloat("r_mbradialoverridestrength");

  while(getdvarfloat("r_mbRadialoverridechromaticAberration") > 0 && getdvarfloat("r_mbradialoverridestrength") > 0) {
    var_0 = max(var_0 - 0.002, 0);
    var_1 = max(var_1 - 0.001, 0);
    setsaveddvar("r_mbRadialoverridechromaticAberration", var_0);
    setsaveddvar("r_mbradialoverridestrength", var_1);
    wait 0.05;
  }
}

_id_5DFD() {
  if(getdvarint("debug_europa"))
    iprintln("hiding intro_surface_vista_01");

  var_0 = getEnt("intro_surface_vista_01", "targetname");
  var_0 hide();

  if(getdvarint("debug_europa"))
    iprintln("hiding base_reveal_vista");

  scripts\sp\maps\europa\europa_util::toggle_cockpit_lights(0);
  scripts\engine\utility::flag_wait("clouds_idle_start");

  if(getdvarint("debug_europa"))
    iprintln("opening umbra portal named 'halo_portal' ");

  setumbraportalstate("halo_portal", 1);
  wait 6;

  if(getdvarint("debug_europa"))
    iprintln("show intro_surface_vista_01");

  var_0 show();
}

_id_5ED8() {
  scripts\engine\utility::exploder("cloudreveal");
  scripts\engine\utility::exploder("clouds_static");
  scripts\engine\utility::flag_wait("dropship_door_open");
  scripts\engine\utility::exploder("clouds");
  thread _id_75F7();
}

_id_75F7() {
  wait 0.8;
  scripts\sp\utility::_id_10FEC("clouds_static");
}

_id_8890() {
  level endon("player_boost_failed");
  level endon("player_landed");
  thread scripts\sp\utility::_id_56BA("freefall_boost");
  thread _id_F39B();
  var_0 = 1;
  var_1 = 0.01;
  var_2 = 1;
  childthread _id_2CAC();

  for(;;) {
    if(level.player _meth_81CE()) {
      if(isDefined(level._id_CFE4._id_2A4C))
        level._id_CFE4._id_2A4C scripts\sp\utility::_id_10460(0.05, 1);

      if(var_0 - var_1 > 0) {
        var_0 = var_0 - var_1;

        if(var_2) {
          setomnvar("ui_hud_heist_boost", 1);
          thread _id_D1B4();
          thread _id_25F8();
          var_2 = 0;
        }
      }

      if(var_0 <= 0.75) {
        scripts\engine\utility::flag_set("player_boosted");
        scripts\engine\utility::flag_set("boost_required_end");
      }
    }

    setomnvar("ui_hud_heist_boost_amount", var_0);
    wait 0.05;
  }
}

_id_2CAC() {
  for(;;) {
    if(level.player _meth_81CE()) {
      earthquake(0.43, 0.3, level.player.origin, 200);
      level.player playRumbleOnEntity("heavy_3s");
      level.player playRumbleOnEntity("damage_heavy");
      level.player _meth_8291(0.5, 0.5, 0.5, 0.3, 0, -1, 0, 30, 30, 30);
      wait 0.1;
    }

    wait 0.05;
  }
}

_id_D1B4() {
  level endon("player_boost_failed");
  scripts\engine\utility::array_thread([level._id_EBBB, level._id_EBBC], ::_id_A837);
  thread _id_D1B9();
  scripts\engine\utility::exploder("landing");
  scripts\engine\utility::exploder("ex_landing_impact");
  var_0 = level._id_D267 scripts\engine\utility::spawn_tag_origin();
  level._id_D267 linkTo(var_0);
  var_0 thread scripts\sp\anim::_id_1F35(level._id_D267, "europa_dropship_halo_land_rel", "tag_origin");
  var_1 = 0.462069;
  var_2 = getanimlength(level._id_D267 scripts\sp\utility::_id_7DC1("europa_dropship_halo_land_rel"));
  var_3 = scripts\sp\utility::_id_864C(level._id_D267.origin);
  var_4 = level._id_D267.origin[2] - var_3[2];
  var_5 = scripts\sp\math::_id_C097(600, 3500, var_4);
  var_5 = clamp(1 - var_5, 0.5, 1);
  _id_F537(var_5);
  var_6 = var_2 * (1 - var_1);
  var_2 = var_2 * (1 / var_5);
  var_7 = var_2 * var_1;
  var_0 moveTo(var_3, var_7);
  wait(var_2 * var_1);
  _id_F537(1);
  level.player playSound("scn_jump_from_plane_booster_land_lr");
  earthquake(1, 1, level.player.origin, 200);
  level notify("player_landed");
  wait(var_6);
  level.player _meth_8391(2);
  level.player unlink(1);
  level._id_EBBB unlink();
  level._id_EBBC unlink();
  level notify("land_animation_over");
}

_id_D1B9() {
  var_0 = scripts\sp\utility::_id_864C(level.player.origin);

  while(level.player.origin[2] - var_0[2] > 500)
    wait 0.05;

  playFX(scripts\engine\utility::getfx("landing_kickup_dist"), var_0);

  while(level.player.origin[2] - var_0[2] > 325)
    wait 0.05;

  playFX(scripts\engine\utility::getfx("landing_kickup"), var_0);
  level waittill("player_landed");
  playFX(level._effect["player_landing"], var_0, anglestoright(level.player._id_8892.angles));
}

_id_7BA1() {
  return level._id_D267 islegacyagent(level._id_D267 scripts\sp\utility::_id_7DC1("europa_dropship_halo_land"));
}

_id_F537(var_0) {
  level._id_D267 _meth_82B1(level._id_D267 scripts\sp\utility::_id_7DC1("europa_dropship_halo_land_rel"), var_0);
}

_id_A635() {
  level._id_2B4C fadeovertime(0.25);
  level._id_2B4C.alpha = 0;
  level.player _meth_82C0("europa_dropship_intro_fullscreen_hit", 0.05);
  level.player scripts\engine\utility::delaycall(2.0, ::clearclienttriggeraudiozone, 5.0);
  level.player setclientomnvar("ui_hide_hud", 0);
  wait 0.25;
  level._id_2B4C destroy();
}

_id_59E8() {
  scripts\engine\utility::flag_wait("dropship_door_open");
  scripts\engine\utility::delaythread(3, ::_id_5E1B);

  if(getdvarint("debug_europa"))
    iprintln("dropship_door_open FX");

  wait 0.7;
  level.player playRumbleOnEntity("heavy_3s");
  level._id_E7C2 = scripts\sp\utility::_id_7C23();
  level._id_E7C2 thread scripts\sp\utility::_id_E7C9(1, 0.1);
  level._id_E7C2 scripts\engine\utility::delaythread(0.1, scripts\sp\utility::_id_E7C9, 0.2, 1);
  playFXOnTag(scripts\engine\utility::getfx("dropship_door_open"), level._id_5D6C, "tag_origin");
  thread _id_59B9();
  var_0 = scripts\engine\utility::getStruct("dropship_door_sound", "targetname");
  var_1 = scripts\engine\utility::spawn_tag_origin(var_0.origin, var_0.angles);
  var_1 playSound("scn_europa_dropship_door_open");
  var_2 = scripts\engine\utility::getStruct("dropship_door_100units", "targetname");
  var_3 = scripts\engine\utility::spawn_tag_origin(var_2.origin, var_2.angles);
  var_3 playLoopSound("scn_europa_dropship_door_wind_lp");

  if(getdvarint("debug_europa"))
    iprintln("ex_door_open exploder");

  scripts\engine\utility::exploder("ex_door_open");
  thread _id_5E45();
  scripts\engine\utility::flag_wait("boost_required_start");
  stopFXOnTag(scripts\engine\utility::getfx("dropship_door_open"), level._id_5D6C, "tag_origin");
  var_1 delete();
  var_3 delete();
}

_id_5E1B() {
  level._id_5D6C attach("veh_mil_air_un_dropship_hero_interior_snow", "tag_connect");
}

_id_5E45() {}

_id_8893() {
  if(scripts\engine\utility::flag("halo_jump_start"))
    return 1;

  return 0;
}

_id_6A22() {}

_id_59B9() {
  level notify("change_camera_shake");
  level endon("change_camera_shake");
  level endon("halo_jump_start");
  scripts\engine\utility::exploder("door_open_visor_frost");

  for(;;) {
    var_0 = randomfloatrange(1.6, 2.2);
    var_1 = randomfloatrange(0.5, 1);
    var_2 = randomfloatrange(0.25, 1);
    var_3 = 0.25;
    var_4 = var_3 * 0.5;
    var_5 = var_3 * 0.5;
    var_6 = 0;
    var_7 = 0;
    var_8 = 0;
    var_9 = 0;
    var_10 = 1;
    level.player _meth_8291(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    wait(var_3);
  }
}

_id_5E23() {
  level notify("change_camera_shake");
  level endon("change_camera_shake");
  level endon("boost_required_end");
  level._id_E7C2 endon("death");

  for(;;) {
    if(level._id_D36A) {
      wait 0.05;
      continue;
    }

    var_0 = level._id_CFE4._id_7440;
    var_1 = 0.5;
    var_2 = 0.2;
    var_3 = clamp(var_1 * (1 - var_0), 0.3, var_1);
    var_4 = clamp(var_2 * var_0, 0.1, var_3);
    var_5 = 15 + var_0 * 30.0;
    var_5 = clamp(var_5, 15, 40);
    var_6 = var_0;

    if(var_0 > 0.4)
      level.player _meth_8291((var_6 + 0.35) * (var_6 + 0.35) * 1.5, var_6, (var_6 + 0.35) * (var_6 + 0.35) * 2.0, var_3, 0, -1, 0, var_5, var_5, var_5);
    else if(var_0 > 0.12)
      level.player _meth_8291(var_6 * 1.5, var_6 * 1.2, var_6 * 2.0, var_3, 0, -1, 0, var_5, var_5, var_5);
    else {
      var_6 = 0.05;
      level.player _meth_8291(var_6 * 1.5, var_6, var_6 * 2.0, var_3, 0, -1, 0, var_5, var_5, var_5);
    }

    level._id_E7C2 thread scripts\sp\utility::_id_E7C9(clamp(1.2 * var_0, 0.2, 1.0), var_4 + 0.1);
    wait(var_4);
  }
}

_id_FC50(var_0, var_1) {
  level notify("new_shake_loop");
  level endon("new_shake_loop");
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = 0.7;

  switch (var_0) {
    case "light":
      var_2 = 0.09;
      var_3 = 0.18;
      var_4 = "damage_light";
      break;
    case "heavy":
      var_2 = 0.13;
      var_3 = 0.16;
      var_4 = "heavy_3s";
      break;
  }
}

_id_A837() {
  wait 1;
  var_0 = scripts\sp\utility::_id_864C(self.origin);

  if(self == level._id_EBBB)
    self playSound("scn_europa_scar1_land");

  if(self == level._id_EBBC)
    self playSound("scn_europa_scar2_land");

  playFX(scripts\engine\utility::getfx("landing_kickup"), var_0);
  wait 1.3;
  stopFXOnTag(scripts\engine\utility::getfx("thrust_loop"), self, "tag_fx_bottom");
  scripts\engine\utility::flag_set("safe_to_swap_models");
}

_id_9280() {
  var_0 = scripts\sp\utility::_id_864C(self.origin);
  playFX(scripts\engine\utility::getfx("icecave_landing_kickup"), var_0);

  if(self == level.player) {
    return;
  }
  wait 0.15;
  stopFXOnTag(scripts\engine\utility::getfx("thrust_loop"), self, "tag_fx_bottom");
  scripts\engine\utility::flag_set("safe_to_swap_models");
}

_id_5E0F() {
  scripts\engine\utility::flag_wait("nt_flag_visor_lower");
  wait 0.5;
  level._id_EBBC thread scripts\sp\utility::play_sound_on_tag("scn_europa_dropship_jetpack_test_01", "tag_fx_bottom");
  wait 0.5;
  setomnvar("ui_europa_halo_drop_state", 1);
  thread _id_888F(15, 0.05);
  wait 3.0;
  wait 0.25;
  level._id_EBBB thread scripts\sp\utility::play_sound_on_tag("scn_europa_dropship_jetpack_test_02", "tag_fx_bottom");
  wait 0.75;
  wait 3.5;
  setomnvar("ui_europa_halo_drop_state", 2);
  scripts\engine\utility::flag_wait("dropship_door_open");
  scripts\engine\utility::delaythread(2, ::_id_888F, -354.933, 0.9);
  scripts\engine\utility::flag_wait("halo_jump_start");
  scripts\engine\utility::delaythread(7, ::_id_888F, -298, 15);
}

_id_5E24() {
  level.player._id_8894 = spawn("script_origin", level.player.origin);
  level.player._id_8894 linkTo(level.player);
  setomnvar("ui_europa_halo_drop_state", 3);
  scripts\engine\utility::flag_wait("halo_jump_start");
  wait 4.0;
  setomnvar("ui_europa_halo_drop_state", 4);
  var_0 = 5.15;
  var_1 = 0.6;
  var_2 = 0.4;
  scripts\engine\utility::delaythread(var_1, ::_id_888C, 5392, var_2, 1);
  scripts\engine\utility::delaythread(var_1 + var_2, ::_id_888C, 4482, var_0 - var_1 - var_2, 1);
  wait 5.15;
  scripts\engine\utility::flag_set("halo_level_out");
  setomnvar("ui_europa_halo_drop_state", 5);
  var_3 = 16.0;
  var_4 = 2962;
  thread _id_888C(var_4, var_3, 1);
  _id_13760(0.58);
  setomnvar("ui_europa_halo_drop_state", 6);
  thread _id_888C(100, 11.0, 1);
  wait 5;
  scripts\engine\utility::flag_set("halo_tip_down");
  scripts\engine\utility::flag_wait("boost_required_start");
  level.player._id_8894 playLoopSound("scn_europa_halo_altitude_beep_lp_03");
  level.player._id_58DF = 1;
  setomnvar("ui_europa_halo_drop_state", 7);
  scripts\engine\utility::flag_wait_any("boost_required_end", "player_boost_failed");
  setomnvar("ui_europa_halo_drop_state", 8);
  var_5 = 2.45;
  var_1 = 1.4;
  thread _id_888C(1, var_1);
  scripts\engine\utility::delaythread(2.0, ::_id_888C, 0, var_5 - var_1);
  thread _id_FB48(var_5);
  wait(var_5);

  if(scripts\engine\utility::flag("player_boost_failed")) {
    return;
  }
  setomnvar("ui_europa_halo_drop_state", 9);
  wait 2.3;
  setomnvar("ui_europa_halo_drop_state", 0);
  level notify("halo_drop_hud_close");
}

_id_FB48(var_0) {
  wait(var_0 - 1.3);
  level.player._id_8894 scripts\sp\utility::_id_10460(1.0, 1);
}

_id_888C(var_0, var_1, var_2) {
  level notify("halo_drop_altitude_lerp");
  level endon("halo_drop_altitude_lerp");
  var_3 = getomnvar("ui_europa_halo_drop_altitude");
  var_4 = var_0;
  var_5 = var_3;
  var_6 = (var_3 - var_4) / (var_1 * 20.0);
  var_7 = 200;
  var_8 = undefined;
  var_8 = floor(var_5 / var_7) * var_7;

  while(var_5 > var_4) {
    var_5 = var_5 - var_6;

    if(abs(var_5 - var_4) < 1) {
      var_5 = var_4;
      setomnvar("ui_europa_halo_drop_altitude", int(var_4));
    } else
      setomnvar("ui_europa_halo_drop_altitude", int(var_5));

    if(isDefined(var_2)) {
      if(var_5 < var_8) {
        if(!isDefined(level.player._id_58DF) || level.player._id_58DF == 0)
          level.player._id_8894 playSound("scn_europa_halo_altitude_beep");

        var_8 = floor(var_5 / var_7) * var_7;
      }
    }

    wait 0.05;
  }
}

_id_888F(var_0, var_1) {
  level notify("halo_drop_temperature_lerp");
  level endon("halo_drop_temperature_lerp");
  var_2 = getomnvar("ui_helmet_meter_temperature");
  var_3 = var_0;
  var_4 = var_2;
  var_5 = (var_2 - var_3) / (var_1 * 20.0);

  if(var_3 < var_2) {
    while(var_4 > var_3) {
      var_4 = var_4 - var_5;

      if(abs(var_4 - var_3) < 1)
        setomnvar("ui_helmet_meter_temperature", int(var_3));
      else
        setomnvar("ui_helmet_meter_temperature", int(var_3));

      wait 0.05;
    }
  } else {
    while(var_4 < var_3) {
      var_4 = var_4 - var_5;

      if(abs(var_4 - var_3) < 1)
        setomnvar("ui_helmet_meter_temperature", int(var_3));
      else
        setomnvar("ui_helmet_meter_temperature", int(var_4));

      wait 0.05;
    }
  }

  thread _id_888E(var_3);
}

_id_888E(var_0) {
  level endon("halo_drop_temperature_lerp");
  level endon("halo_drop_hud_close");
  var_1 = -2.0;
  var_2 = 1.0;
  var_3 = var_0;

  for(;;) {
    wait(randomfloatrange(0.5, 3.0));
    var_3 = var_0 + randomfloatrange(var_1, var_2);
    setomnvar("ui_helmet_meter_temperature", int(var_3));
  }
}

_id_3F69() {
  wait 9;
  setomnvar("ui_chyron", 1);
  thread _id_3F6A();
  wait 7;
  wait 2;
  setomnvar("ui_chyron", 0);
}

_id_3F6A() {
  level.player thread scripts\sp\utility::play_sound_on_entity("ui_chyron_box_start");
  level.player thread scripts\engine\utility::play_loop_sound_on_entity("ui_chyron_box_lp");
  level.player thread scripts\sp\utility::_id_C12D("stop soundui_chyron_box_lp", 0.75);
  level.player thread scripts\sp\utility::play_sound_on_entity("ui_chyron_box_end");
  thread _id_3F6B();
  wait 6;
  level.player thread scripts\sp\utility::play_sound_on_entity("ui_chyron_off");
}

_id_3F6B() {
  wait 1;
  level.player thread scripts\engine\utility::play_loop_sound_on_entity("ui_chyron_text_type_lp");
  wait 1.25;
  level.player notify("stop soundui_chyron_text_type_lp");
}

_id_4212() {
  scripts\sp\maps\europa\europa_util::_id_107C5();
  scripts\sp\utility::_id_F5AF("cliff_drop_start", [level._id_EBBB, level._id_EBBC, level.player]);
  setglobalsoundcontext("storm", "storm_ext", 1.0);
  setglobalsoundcontext("atmosphere", "helmet", 1.0);
  scripts\engine\utility::exploder("landing");
  thread _id_8E4A();
  level.player thread scripts\sp\maps\europa\europa_util::_id_8E34(1);
  thread _id_7451();
  _id_10ACC();
}

_id_4209() {
  thread _id_0B11::_id_CCBE();

  if(scripts\engine\utility::flag("player_boost_failed"))
    level waittill("forever");

  scripts\sp\utility::_id_2669("cliffjumper");
  thread _id_420E();
  thread _id_134C2();
  scripts\engine\utility::flag_wait("player_at_opening");
  _id_41FF();
  scripts\engine\utility::flag_wait("cliffjump_complete");
}

_id_11A84() {
  for(;;) {
    for(var_0 = 0; var_0 < 30; var_0++) {
      var_1 = level.player getEye();
      var_1 = var_1 + (randomintrange(-400, 400), randomintrange(-400, 400), 200);
      playFX(scripts\engine\utility::getfx("vfx_ice_fall_caves"), var_1);
    }

    wait(randomfloatrange(0.35, 0.85));
  }
}

_id_8E4A() {
  scripts\engine\utility::flag_wait("safe_to_swap_models");
  scripts\engine\utility::delaythread(0.25, scripts\sp\maps\europa\europa_util::_id_8E46, 1);
}

_id_4211() {
  scripts\engine\utility::flag_wait("player_at_opening");
  wait 3;
  var_0 = scripts\engine\utility::getStruct("jump_obj", "targetname");
  objective_position(1, var_0.origin - (0, 0, 56));

  if(level._id_7683 < 2)
    objective_setpointertextoverride(1, &"EUROPA_JUMPIN");

  scripts\engine\utility::flag_wait("cliffjump_start");
  objective_position(1, (0, 0, 0));
}

_id_420E() {
  scripts\engine\utility::flag_wait("cliffjump_start");
  wait 3;

  if(getdvarint("debug_europa"))
    iprintln("hiding intro_surface_vista_01");

  var_0 = getEnt("intro_surface_vista_01", "targetname");
  var_0 hide();

  if(getdvarint("debug_europa"))
    iprintln("hiding intro_surface_vista_01");
}

_id_7451() {
  level._id_7452 = newclienthudelem(level.player);
  level._id_7452.foreground = 1;
  level._id_7452.alignx = "left";
  level._id_7452.aligny = "top";
  level._id_7452.horzalign = "fullscreen";
  level._id_7452.vertalign = "fullscreen";
  level._id_7452 setshader("vfx_ui_player_freeze_overlay_02", 640, 480);
  level._id_7452.alpha = 0;
  thread _id_AB7E();
  level waittill("cliffjump_start");
  level._id_7452 scripts\sp\hud_util::_id_6AAB(0, 1);
  level._id_7452 destroy();
}

_id_6745() {
  level.player thread scripts\sp\maps\europa\europa_util::_id_12992();
  thread scripts\sp\maps\europa\europa_util::_id_982F(5);
  level.player scripts\engine\utility::delaythread(5, scripts\sp\maps\europa\europa_util::_id_12970);
}

_id_AB7E() {
  level endon("cliffjump_start");
  var_0 = 15000;
  level.player._id_738C = level.player scripts\engine\utility::spawn_script_origin();
  level.player._id_738C linkTo(level.player);
  level.player._id_47A2 = level.player scripts\engine\utility::spawn_script_origin();
  level.player._id_47A2 linkTo(level.player);
  var_1 = 1;
  var_2 = scripts\engine\utility::getStruct("oval_start", "targetname").origin;
  var_3 = scripts\engine\utility::getStruct("oval_end", "targetname").origin;
  var_4 = distance2d(var_2, var_3) * 0.5;
  var_5 = var_4 * 0.4;
  var_6 = scripts\sp\math::_id_7ADE(var_2, var_3);
  var_7 = level.player.origin;
  var_8 = gettime() + var_0;
  var_9 = [];
  var_9[1] = "europa_cmp_warningtemperat";
  var_9[2] = "europa_cmp_warningtemperatu";
  var_9[3] = "europa_cmp_warningairsuppl";
  scripts\engine\utility::delaythread(3.5, ::_id_6745);
  var_10 = 1;

  for(;;) {
    if(scripts\sp\math::_id_D638(level.player.origin, var_6, var_5, var_4)) {
      var_1 = 0;

      if(gettime() > var_8)
        var_11 = 0.002;
      else
        var_11 = 0;
    } else {
      var_12 = distance2dsquared(level.player.origin, var_6) < distance2dsquared(var_7, var_6);

      if(!var_1) {}

      if(var_12)
        var_11 = 0.005;
      else
        var_11 = 0.02;
    }

    level._id_7452.alpha = level._id_7452.alpha + var_11;
    thread scripts\sp\maps\europa\europa_util::_id_D988(level._id_7452.alpha);

    if(level._id_7452.alpha >= 1) {
      _id_738B();
      break;
    }

    var_7 = level.player.origin;
    var_13 = _id_E758(level._id_7452.alpha);

    if(var_13 == _id_E758(var_10 / var_9.size)) {
      level.player thread scripts\sp\utility::play_sound_on_entity(var_9[var_10]);
      var_10++;
      level.player thread scripts\sp\maps\europa\europa_util::_id_12992();
      level.player scripts\engine\utility::delaythread(5, scripts\sp\maps\europa\europa_util::_id_12970);

      if(var_10 == 2)
        thread start_player_freezing_sfx();
    }

    wait 0.225;
  }
}

start_player_freezing_sfx() {
  level endon("froze_to_death");
  level.freeze_sfx_org = spawn("script_origin", level.player.origin);
  level.freeze_sfx_org scripts\engine\utility::delaycall(19, ::playsound, "scn_euro_player_freeze");
}

_id_6C2C(var_0) {
  level thread scripts\sp\utility::_id_C12D("stop_final_wanring", var_0);
  level.player thread scripts\sp\utility::_id_D2CD(50, var_0);
}

_id_448E(var_0) {
  level endon("cliffjump_start");
  var_1 = [];
  var_1[var_1.size] = "europa_cmp_warningtemperat";
  var_1[var_1.size] = "europa_cmp_warningtemperatu";
  var_1[var_1.size] = "europa_cmp_warningairsuppl";

  foreach(var_3 in var_1) {
    wait(var_0 / var_1.size);
    level.player scripts\sp\utility::play_sound_on_entity(var_3);
  }
}

_id_738B() {
  if(scripts\engine\utility::flag("cliffjump_start")) {
    return;
  }
  level notify("froze_to_death");

  if(isDefined(level.freeze_sfx_org))
    level.freeze_sfx_org scripts\engine\utility::delaycall(1.0, ::stopsounds);

  level.player.death._id_1025C = 1;
  _id_0B60::_id_F322("EUROPA_FREEZE_DEATH");
  level.player scripts\sp\utility::_id_54C6();
}

_id_C800(var_0, var_1) {
  self notify("new_fade");
  self endon("new_fade");
  self fadeovertime(var_1);
  self.alpha = var_0;
  wait(var_1);
}

_id_DAEF(var_0, var_1) {
  var_2 = self.alpha;
  self fadeovertime(var_1 / 2);
  self.alpha = var_0;
  wait(var_1 / 2);
  self fadeovertime(var_1 / 2);
  self.alpha = var_2;
}

_id_10AD0() {
  scripts\engine\utility::array_thread(level._id_EBCA, scripts\sp\utility::_id_54F7);
  level._id_EBBB.target = "sipes_lookaround";
  level._id_EBBC.target = "t_lookaround";
  scripts\engine\utility::array_thread(level._id_EBCA, _id_0B77::_id_8409);
  scripts\engine\utility::flag_wait("player_at_landing_zone");
  _id_1381C();
}

_id_1381C() {
  level endon("landing_vo_finished");
  scripts\engine\utility::flag_waitopen("player_at_landing_zone");
}

_id_B01E() {
  self endon("stop_going_to_node");
  var_0 = scripts\engine\utility::spawn_script_origin();
  var_0 scripts\engine\utility::delaycall(11, ::delete);
  scripts\engine\utility::delaythread(1, _id_0C4C::_id_1955, var_0);

  for(;;) {
    var_1 = anglesToForward(self.angles);
    var_0.origin = self.origin + (0, 0, 200) + var_1 * 100;
    wait 0.05;
  }
}

_id_10ACC() {
  scripts\sp\maps\europa\europa_util::_id_EBC7();
  scripts\engine\utility::array_thread(level._id_EBCA, ::_id_EBC2);
}

_id_EBC2() {
  while(self _meth_81A6())
    wait 0.05;

  scripts\sp\utility::_id_61E7();

  if(self == level._id_EBBC) {
    wait 0.6;
    level._id_EBBC scripts\sp\utility::_id_F3B5("b");
  }

  scripts\engine\utility::delaythread(6, scripts\sp\utility::_id_5514);
  thread _id_B013();
}

_id_420C() {
  var_0 = getEnt("intro_surface_vista_01", "targetname");
  var_0 hide();

  if(getdvarint("debug_europa"))
    iprintln("Hiding 'intro_surface_vista_01' ");

  thread _id_0B11::_id_CCBE();
}

_id_134C2() {
  if(level._id_10CDA == "cliffjumper")
    wait 1.5;

  setglobalsoundcontext("storm", "storm_ext", 1.0);
  scripts\sp\maps\europa\europa_util::_id_134B7("europa_plr_surfacetemps300");
  wait 0.5;
  var_0 = ["europa_plr_reaperscarsareo", "europa_rpr_copy11beadvised", "europa_plr_copyunthemove"];
  scripts\sp\maps\europa\europa_util::_id_D24C(var_0);
  thread scripts\sp\maps\europa\europa_util::_id_67B6(1, "current", &"EUROPA_OBJECTIVE_ACCESS", "entering_seeker_room");
  thread _id_4211();
  level notify("landing_vo_finished");
  _id_4A5D();
}

_id_4A5D() {
  if(scripts\engine\utility::flag("cliffjump_start")) {
    return;
  }
  level endon("cliffjump_start");
  scripts\engine\utility::flag_wait("lookdown_started");
  wait 1;
  scripts\sp\maps\europa\europa_util::_id_134B7("europa_tee_trackintwotargest");
  wait 0.15;
  scripts\sp\maps\europa\europa_util::_id_134B7("europa_tee_boostdowntakeem");
  var_0 = ["europa_tee_gearsicingupletspl", "europa_sip_wolfjumpdownwe", "europa_tee_onyouboss"];

  for(;;) {
    foreach(var_2 in var_0) {
      wait(randomintrange(9, 15));

      if(scripts\engine\utility::flag("cliffjump_start")) {
        return;
      }
      scripts\sp\maps\europa\europa_util::_id_134B7(var_2);
    }

    wait 0.05;
  }
}

_id_B013() {
  level endon("cliffjump_start");
  self._id_B015 = scripts\engine\utility::getStruct("lookdown_" + self._id_1FBB, "targetname");
  scripts\sp\utility::_id_54F7();
  wait(randomfloatrange(0.2, 1.5));
  self._id_B015 scripts\sp\anim::_id_1F17(self, "lookdown");
  scripts\engine\utility::flag_set("lookdown_started");
  self._id_B015 scripts\sp\anim::_id_1F35(self, "lookdown");
  scripts\sp\anim::_id_1EEA(self, "lookdown_idle");
}

_id_41FF() {
  scripts\engine\utility::flag_clear("boost_required_start");
  scripts\engine\utility::flag_clear("boost_required_end");
  scripts\engine\utility::flag_clear("player_boosted");
  level._id_421D = scripts\engine\utility::getStruct("cliffjumper_takedown", "targetname");
  level._id_421D._id_D267 = scripts\sp\utility::_id_10639("player_rig", level._id_421D.origin + (0, 0, 4000), (0, 0, 0));
  level._id_421D._id_D267 hide();
  scripts\engine\utility::flag_wait("cliffjump_start");
  level._id_421D._id_D04B = scripts\sp\utility::_id_107EA("cliffjump_enemy_player", 1);
  level._id_421D._id_1CE2 = scripts\sp\utility::_id_107EA("cliffjump_enemy_ally", 1);
  level._id_421D._id_D04B scripts\sp\maps\europa\europa_labs::_id_19D9();
  level._id_421D._id_1CE2 scripts\sp\maps\europa\europa_labs::_id_19D9();
  level._id_421D._id_D04B._id_1FBB = "player_enemy";
  level._id_421D._id_D04B thread _id_1081C();
  level._id_421D._id_1CE2._id_1FBB = "ally_enemy";
  level._id_421D._id_1CE2 thread _id_1081C();
  level._id_421D._id_1CBF = level._id_EBBC;
  level._id_421D._id_1684 = [level._id_421D._id_D267, level._id_421D._id_D04B, level._id_421D._id_1CE2, level._id_421D._id_1CBF];
  level._id_421D._id_CF5C = getanimlength(level._id_421D._id_D267 scripts\sp\utility::_id_7DC1("cliffjumper"));
  level.player._id_D267 = level._id_421D._id_D267;
  level._id_4205 = spawn("script_origin", level.player.origin);
  level._id_421D._id_1CE2 scripts\sp\utility::_id_B14F();
  thread scripts\engine\utility::flag_set_delayed("boost_required_start", 1.5);
  level._id_4205 playSound("scn_cave_jump_plr");
  level._id_421D._id_1CE2 scripts\sp\utility::_id_1101B();
  setglobalsoundcontext("storm", "", 1.0);

  if(isDefined(level.player._id_738C)) {
    level.player._id_738C _meth_8278(0, 1);
    level.player._id_738C scripts\engine\utility::delaycall(1.25, ::delete);
  }

  scripts\engine\utility::delaythread(1, ::_id_4201);

  if(isDefined(level.player._id_737C))
    level.player._id_737C thread _id_C800(0, 0.5);

  foreach(var_1 in level._id_EBCA) {
    var_1._id_B015 notify("stop_loop");
    var_1 scripts\sp\maps\europa\europa_util::_id_10FC2();
  }

  level._id_421D thread scripts\sp\anim::_id_1F2C(level._id_421D._id_1684, "cliffjumper");
  thread _id_AD0C(level._id_421D);
  level._id_EBBC hide();
  thread _id_4207();
  thread _id_420A(level._id_421D);
  thread _id_4213(level._id_421D);
  thread _id_F915();
  scripts\engine\utility::flag_wait("cliffjump_boost_start");
  level._id_EBBC show();
}

_id_F915() {
  level endon("scar_saved_player");
  var_0 = [level.player._id_D267, level._id_421D._id_D04B];
  scripts\engine\utility::flag_wait("cliffjump_kick_done");
  scripts\engine\utility::delaythread(0.25, scripts\sp\hud::_id_8DFF, -250, 0.05);

  if(!scripts\engine\utility::flag("player_stabbed")) {
    level._id_421D thread scripts\sp\anim::_id_1F2C(var_0, "cliffjumper_loop");
    setslowmotion(1, 0.25, 0.5);
    var_1 = getanimlength(level.player._id_D267 scripts\sp\utility::_id_7DC1("cliffjumper_loop"));
    thread _id_3DB5(var_1);
    level.player waittill("melee_pressed");
    scripts\engine\utility::flag_set("player_stabbed");
    level._id_421D._id_1CBF _meth_82B0(level._id_421D._id_1CBF scripts\sp\utility::_id_7DC1("cliffjumper"), 0.5);
    level._id_421D._id_1CE2 _meth_82B0(level._id_421D._id_1CE2 scripts\sp\utility::_id_7DC1("cliffjumper"), 0.5);
  }

  level.player playSound("scn_cave_jump_boostkill_stab");
  setslowmotion(0.25, 1, 0.1);
  level.player _meth_81DE(65, 0.75);
  level._id_421D scripts\sp\anim::_id_1F2C(var_0, "cliffjumper_kill");
  level._id_421D._id_D04B scripts\sp\utility::_id_19D3();
  scripts\engine\utility::flag_set("cliffjump_complete");
}

_id_1081C() {
  self waittill("death");
  var_0 = self gettagorigin("tag_weapon_right") + (0, 0, 15);
  var_0 = scripts\sp\utility::_id_864C(var_0) + (0, 0, 1);
  var_1 = self gettagangles("tag_weapon_right");
  var_2 = spawn("weapon_" + self.weapon, var_0);
  var_2.angles = var_1;
}

_id_5FB3() {
  level endon("player_stabbed");
  level endon("scar_saved_player");
  scripts\engine\utility::delaythread(1.95, scripts\sp\utility::_id_56BA, "melee_hint");
  level.player waittill("melee_pressed");
  scripts\engine\utility::flag_set("player_stabbed");
}

_id_3DB5(var_0) {
  level endon("player_stabbed");
  wait(var_0);
  scripts\engine\utility::flag_set("scar_saved_player");
  var_1 = scripts\engine\utility::getStruct("blood_pool_struct", "targetname").origin;
  playFX(level._effect["deathfx_bloodpool_generic"], var_1);
  settimescale(1);
  level._id_4214 delete();
  level.player playerlinktodelta(level._id_421D._id_D267, "tag_player", 0, 1, 1, 1, 1, 1);
  level.player _meth_81DE(65, 0.75);
  scripts\engine\utility::delaythread(1.25, scripts\sp\maps\europa\europa_util::_id_134B7, "europa_tee_focusupmate");
  level._id_421D._id_1CBF _meth_82B0(level._id_421D._id_1CBF scripts\sp\utility::_id_7DC1("cliffjumper"), 0.6);
  level._id_421D._id_1CE2 _meth_82B0(level._id_421D._id_1CE2 scripts\sp\utility::_id_7DC1("cliffjumper"), 0.6);
  thread _id_6ADE();
  var_2 = [level.player._id_D267, level._id_421D._id_D04B];
  level._id_421D scripts\sp\anim::_id_1F2C(var_2, "cliffjumper_exit");
  level._id_421D._id_D04B scripts\sp\utility::_id_19D3();
  scripts\engine\utility::flag_set("cliffjump_complete");
}

_id_6ADE() {
  var_0 = scripts\engine\utility::getStruct("cliff_bullet_start", "targetname").origin;
  var_1 = scripts\engine\utility::getStruct("blood_pool_struct", "targetname").origin;
  var_2 = 6;
  var_3 = [];

  for(var_4 = 0; var_4 < var_2; var_4++) {
    playworldsound("weap_kbs_sup_plr", level.player getEye());
    var_5 = var_0 + scripts\engine\utility::randomvector(3);
    var_6 = var_1 + (randomfloatrange(-10, 10), -5, 0);
    var_7 = var_6 - var_5;
    var_8 = vectortoangles(var_7);
    playFX(level._effect["bullet_tracer"], var_5, anglesToForward(var_8), anglestoup(var_8));
    wait 0.05;

    if(isDefined(level._id_421D._id_D04B))
      playFX(level._id_7649["human_gib_head"], scripts\engine\utility::getStruct("blood_pool_struct", "targetname").origin);

    wait(randomfloatrange(0.15, 0.25));
    var_9 = scripts\sp\utility::_id_864C(var_6 + (0, 0, 10));
    playFX(scripts\engine\utility::getfx("bullet_cracks"), var_9);
  }
}

_id_AB70(var_0, var_1) {
  level notify("lerping_cliff_anim_rates");
  level endon("lerping_cliff_anim_rates");
  var_2 = _id_78A5();
  var_3 = var_0 - var_2;
  var_4 = var_1 / 0.05;
  var_5 = var_3 / var_4;
  var_6 = gettime() + var_1 * 1000;

  while(gettime() < var_6) {
    var_2 = var_2 + var_5;
    _id_F300(var_2);
    wait 0.05;
  }

  _id_F300(var_0);
}

_id_78A6() {
  return level.player._id_D267 islegacyagent(level.player._id_D267 scripts\sp\utility::_id_7DC1("cliffjumper"));
}

_id_78A5() {
  return level.player._id_D267 _meth_8104(level.player._id_D267 scripts\sp\utility::_id_7DC1("cliffjumper"));
}

_id_F300(var_0) {
  foreach(var_2 in level._id_421D._id_1684) {
    if(isDefined(var_2))
      var_2 _meth_82B1(var_2 scripts\sp\utility::_id_7DC1("cliffjumper"), var_0);
  }
}

_id_13745(var_0) {
  while(_id_78A6() < var_0)
    wait 0.05;
}

_id_4201() {}

_id_4213(var_0) {
  scripts\sp\utility::_id_10FEC("landing");
  scripts\engine\utility::exploder("le_clouds");
  var_1 = level._id_421D._id_D04B.origin;

  while(level.player.origin[2] - var_1[2] > 500)
    wait 0.05;

  while(!level._id_CF99)
    wait 0.05;

  playFX(scripts\engine\utility::getfx("landing_kickup_dist"), var_1);

  while(level.player.origin[2] - var_1[2] > 325)
    wait 0.05;

  playFX(scripts\engine\utility::getfx("landing_kickup"), var_1);
}

_id_AD0C(var_0) {
  var_1 = getstartangles(var_0.origin, var_0.angles, var_0._id_D267 scripts\sp\utility::_id_7DC1("cliffjumper"))[1];
  var_2 = level.player.angles[1];
  var_2 = scripts\engine\utility::ter_op(var_2 < 0, var_2 + 360, var_2);
  var_3 = 0.75;
  var_4 = 2;
  var_5 = 0;
  var_6 = 180;
  var_7 = var_1 - var_2;
  var_8 = scripts\sp\math::_id_C097(var_6, var_5, var_7);
  var_9 = scripts\sp\math::_id_6A8E(var_3, var_4, var_8);

  if(level.player istouching(getEnt("freaking_lerp_quicker", "targetname")))
    var_9 = 0.5;

  level.player thread scripts\sp\maps\europa\europa_util::_id_D85C();
  level.player _meth_823C(var_0._id_D267, "tag_player", var_9);
  wait(var_9);
  level.player playerlinktodelta(var_0._id_D267, "tag_player", 1, 0, 0, 0, 0, 1);
  var_0._id_D267 scripts\engine\utility::delaycall(0.05, ::show);
  thread _id_10135();
  scripts\engine\utility::flag_wait("cliffjump_complete");

  if(isDefined(level._id_4214))
    level._id_4214 delete();

  level.player scripts\sp\maps\europa\europa_util::_id_DF3E();
  var_0._id_D267 delete();
}

_id_10135() {
  level endon("cliffjump_complete");

  while(!isDefined(level._id_4214))
    wait 0.05;

  level._id_4214 show();
}

_id_420A(var_0) {
  scripts\engine\utility::flag_wait("boost_required_start");
  thread _id_D86A();
  thread _id_420B();
  thread _id_4202(var_0);
  thread _id_4206(var_0);

  while(!level._id_CF99)
    wait 0.05;

  thread _id_5FB3();

  if(scripts\engine\utility::flag("boost_required_end"))
    return;
}

_id_420B() {
  level.player waittill("playerboost");
  level.player playSound("scn_cave_jump_boost");
}

_id_4206(var_0) {
  while(distancesquared(level.player.origin, var_0._id_D04B.origin) > squared(1400))
    wait 0.05;

  if(level._id_CF99) {
    return;
  }
  scripts\engine\utility::delaythread(0.85, scripts\sp\utility::_id_56BE, "freefall_boost", 3);
  level.player thread scripts\sp\utility::play_sound_on_entity("scn_cave_jump_slomo");
  setmusicstate("");
  wait 0.2;
  level._id_4205 stopsounds();
  level._id_1031B._id_ABA1 = 0.4;
  level._id_1031B._id_1098F = 0.1;
  level.player _meth_81DE(50, 2);
  setslowmotion(1, 0.5, 1.5);
  thread _id_AB70(0.05, 2);
  wait 0.2;
  scripts\sp\utility::_id_56BA("freefall_boost");
  notifyoncommand("playerboost", "+gostand");
  notifyoncommand("playerboost", "+moveup");
  level.player waittill("playerboost");
  thread _id_6AE2();
  setslowmotion(0.2, 1, 0.1);
  _id_AB70(1, 0.1);
  level.player thread scripts\sp\utility::play_sound_on_entity("europa_slowmo_out");
}

_id_6AE2() {
  setomnvar("ui_hud_heist_boost", 1);
  var_0 = 1;
  var_1 = 0.03;

  while(var_0 > 0.73) {
    setomnvar("ui_hud_heist_boost_amount", var_0);
    var_0 = var_0 - var_1;
    wait 0.05;
  }

  wait 0.5;
  setomnvar("ui_hud_heist_boost", 0);
}

_id_ABB3(var_0, var_1) {
  var_2 = getdvarint("cg_fov");
  var_3 = gettime() + var_1 * 1000;
  var_4 = var_1 / 0.05;
  var_5 = (var_0 - var_2) / var_4;

  while(gettime() < var_3) {
    var_2 = var_2 + var_5;
    level.player _meth_81DE(var_2, 0.05);
    wait 0.05;
  }
}

_id_4202(var_0) {
  scripts\engine\utility::flag_wait("boost_required_end");
  level notify("kill_boost_button");

  if(!level._id_CF99) {
    thread scripts\sp\utility::_id_10322();
    var_1 = 0.15;
    var_0._id_D361 = level.player scripts\engine\utility::spawn_script_origin();
    var_0._id_D361.angles = (85, level.player.angles[1], level.player.angles[2]);
    level.player _meth_823B(var_0._id_D361);
    var_0._id_D267 hide();
    var_0._id_D361 moveTo(var_0.origin, var_1);
    level.player _meth_8497();
    wait 0.15;
    playworldsound("player_falling_death_impact", level.player.origin);
    earthquake(1, 1, level.player.origin, 200);
    level.player _meth_8244("damage_heavy");
    _id_0B60::_id_F322("EUROPA_BOOST_DEATH_HINT");
    setDvar("player_death_animated", 0);
    level.player _meth_81D0();
    level.player stoprumble("damage_heavy");
    return;
  }
}

_id_4207() {
  scripts\engine\utility::flag_wait("teleport_scar1");
  wait 1.7;
  var_0 = scripts\engine\utility::getStructArray("drop_landing_start", "targetname");

  foreach(var_2 in var_0) {
    if(var_2.script_noteworthy != "scar2")
      level._id_EBBB _meth_80F1(var_2.origin, var_2.angles, 50000);
  }

  level._id_EBBB scripts\sp\utility::_id_4145();
  level._id_EBBC scripts\sp\utility::_id_4145();
  scripts\sp\utility::_id_15F5("squad_lands");
  level._id_EBBB scripts\sp\utility::_id_F3B5("r");
  level._id_EBBB scripts\sp\utility::_id_61C7();
}

_id_4200() {
  scripts\sp\utility::_id_5550();
  self.ignoreall = 1;
  self.dontevershoot = 1;
  self._id_2894 = 0.25;
  scripts\engine\utility::flag_wait("cliffjump_boost_end");
  scripts\sp\utility::_id_F39C(level.player);
  self.ignoreall = 0;
  self.health = 20;
  scripts\engine\utility::flag_wait("cliffjump_landed");
  wait 0.7;
  self.dontevershoot = undefined;
}

_id_A4E1() {
  if(level._id_7683 == 0) {
    return;
  }
  level endon("halo_jump_start");
  wait 20;

  if(!scripts\engine\utility::flag("halo_jump_start")) {
    level.player _meth_8497(1);
    setomnvar("ui_death_hint", 41);
    scripts\sp\utility::_id_B8D1();
  }
}

_id_D86B() {
  var_0 = 0;
  scripts\sp\utility::_id_56BE("halojump_hint", 20);
  notifyoncommand("playerjump", "+gostand");
  notifyoncommand("playerjump", "+moveup");

  while(var_0 == 0) {
    if(!level._id_7683)
      level.player scripts\engine\utility::waittill_notify_or_timeout("playerjump", 20);
    else
      level.player waittill("playerjump");

    level notify("change_camera_shake");
    var_0 = 1;
  }
}

_id_D86A() {
  level endon("kill_boost_button");
  level._id_CF99 = 0;
  scripts\engine\utility::flag_wait("boost_required_start");

  for(;;) {
    level.player waittill("playerboost");
    level._id_CF99 = 1;
    level.player thread scripts\sp\utility::play_sound_on_entity("double_jump_boost_plr");
    level.player playRumbleOnEntity("heavy_1s");
    return;
  }
}

_id_2CB4() {
  if(level._id_CF99 == 1 || scripts\engine\utility::flag("player_boosted"))
    return 1;

  return 0;
}

_id_5DF0() {}

_id_5E75() {
  var_0 = getEntArray("europa_dropshiplight_green", "targetname");
  scripts\engine\utility::array_thread(var_0, scripts\sp\maps\europa\europa_util::_id_AC86);
  var_0 = getEntArray("europa_dropshiplight_red", "targetname");
  scripts\engine\utility::array_thread(var_0, scripts\sp\maps\europa\europa_util::_id_AC87, 100);
}

_id_5E06() {
  var_0 = getEntArray("europa_dropshiplight_red", "targetname");
  scripts\engine\utility::array_thread(var_0, scripts\sp\maps\europa\europa_util::_id_AC86);
  var_0 = getEntArray("europa_dropshiplight_green", "targetname");
  scripts\engine\utility::array_thread(var_0, scripts\sp\maps\europa\europa_util::_id_AC87, 1000);
}

_id_5EA4() {
  level._id_5D6C = _id_0BBF::_id_106B8("scar_dropship", undefined, "jump_seat_1");
  level._id_5D6C _id_0BBF::_id_106BA(1, undefined, 1);
  level._id_5D6C _id_0BBF::_id_F456();
  level._id_5D6C _id_0BBF::_id_F4B4("straps", "heavy");
  level._id_5D6C._id_1FBB = "dropship";
  level._id_5D6C scripts\sp\anim::_id_F64A();

  if(scripts\sp\utility::hastag(level._id_5D6C.model, "tag_origin"))
    level._id_5D6C._id_E6E8 = "tag_origin";
  else
    level._id_5D6C._id_E6E8 = level._id_5D6C.model;

  level._id_5D6C thread _id_5D91();
}

_id_5D91() {
  foreach(var_1 in self._id_4D94._id_9A62) {
    if(issubstr(var_1.model, "bays_ri")) {
      continue;
    }
    if(!issubstr(var_1.model, "interior_")) {
      continue;
    }
    var_1 delete();
  }

  foreach(var_4, var_1 in self._id_4D94._id_F08B) {
    if(issubstr(var_4, "right")) {
      continue;
    }
    var_1 delete();
  }

  if(isDefined(self._id_E4FB)) {
    foreach(var_6 in self._id_E4FB)
    var_6 delete();
  }
}