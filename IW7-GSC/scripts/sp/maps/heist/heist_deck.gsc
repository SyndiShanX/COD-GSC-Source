/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\heist\heist_deck.gsc
************************************************/

_id_BAF4() {
  scripts\sp\maps\heist\heist_util::_id_957C();
  scripts\sp\maps\heist\heist_util::_id_968E();
  scripts\sp\maps\heist\heist_util::_id_9686();
  scripts\sp\maps\heist\heist_util::_id_1065E();
  scripts\sp\maps\heist\heist_util::_id_106D9();
  scripts\sp\maps\heist\heist_util::_id_107BE();
  scripts\sp\maps\heist\heist_util::_id_1074D();
  thread scripts\sp\maps\heist\heist_util::_id_FD33("deck");
  scripts\sp\utility::_id_F5AF("start_mons_top_deck", [level.player, level._id_6754, level._id_30F6, level._id_EA2C, level._id_A54E]);
}

_id_BAF3() {
  scripts\sp\maps\heist\heist_util::_id_957C();
  scripts\sp\maps\heist\heist_util::_id_9706();
  _id_16DD("mons_start_frigate_scene", scripts\sp\maps\heist\heist_lift::_id_3A60);
  thread _id_102E6();
  thread _id_A0EB();
  wait 0.1;
  level thread _id_320B();
  level thread _id_320C();
  level thread _id_119E7();
  scripts\engine\utility::flag_wait("slide_scene_done");

  if(scripts\sp\utility::_id_93A6()) {
    thread scripts\sp\specialist_MAYBE::_id_2683();
  }

  wait 0.5;
}

_id_119E7() {
  level endon("start_slide");
  var_0 = getEnt("top_deck_airlock_door", "targetname");

  for(;;) {
    if(scripts\sp\utility::_id_D1DF(var_0.origin, 0.95, 1) && distance2d(level.player.origin, var_0.origin) <= 650.0) {
      break;
    }

    wait 0.05;
  }

  _id_A1CE();
  wait(randomfloatrange(0.05, 1.0));
  _id_A1CE(1);
}

_id_13DC8() {
  level._id_8633 = scripts\engine\utility::spawn_script_origin(level.player.origin, (0, 0, 0));
  level.player _meth_823F(level._id_8633);
  level._id_8633 rotateTo((0, 0, 15), 10.0, 5, 5);
  level waittill("deck_door_closed");
  level._id_8633 rotateTo((0, 0, 0), 10.0, 5, 5);
}

_id_102E6() {
  var_0 = scripts\engine\utility::getStruct("frigate_final_pos", "targetname");
  var_1 = scripts\sp\utility::_id_10639("player_rig", (0, 0, 0));
  var_1 hide();
  var_1 dontinterpolate();
  var_2 = scripts\engine\utility::get_target_ent("mons_slide_scene");

  if(isDefined(level._id_31FE)) {
    scripts\sp\maps\heist\heist_util::_id_100CD();
  }

  scripts\sp\utility::_id_127B3("mons_start_frigate_scene");
  setomnvar("ui_hide_hud", 1);
  scripts\sp\maps\heist\heist_util::_id_5569("!freeze");
  thread _id_1C0A();
  level thread _id_8E9E();
  level.player playerlinktodelta(var_1, "tag_player", 1, 10, 10, 10, 10, 1);
  level.player _meth_8392(0, 5, 5);
  var_1 scripts\engine\utility::delaycall(0.4, ::show);
  level notify("start_slide");
  _id_102E4(var_2, var_1);

  if(isalive(level.player)) {
    level notify("player_slide_done");
    level.player unlink();
    var_1 delete();
    setomnvar("ui_hide_hud", 0);
    scripts\sp\maps\heist\heist_util::_id_6229();
    thread scripts\sp\utility::_id_266F();
  }

  level._id_4E79 solid();
}

_id_8E9E() {
  level.player scripts\sp\utility::_id_D090("ges_quick_drop");
  wait 0.25;
  var_0 = level.player getcurrentprimaryweapon();
  var_1 = level.player getweaponammoclip(var_0);
  var_2 = level.player getweaponammostock(var_0);
  level.player giveweapon("iw7_gunless");
  level.player takeweapon(var_0);
  level.player switchtoweaponimmediate("iw7_gunless");
  level.player disableweaponswitch();
  level waittill("player_slide_done");
  level.player takeweapon("iw7_gunless");
  level.player giveweapon(var_0);
  level.player setweaponammoclip(var_0, var_1);
  level.player setweaponammostock(var_0, var_2);
  level.player enableweaponswitch();
  level.player switchtoweapon(var_0);
}

_id_102E5(var_0, var_1) {
  self endon("death");
  level endon("stop_killer_debris");
  level endon("kash_anim_end");
  level endon("hit_ground3");
  level thread _id_11882();
  level thread _id_CBF9();
  level.player thread scripts\sp\utility::_id_D2CD(90, 0.2);

  for(;;) {
    var_2 = level._id_A54E.origin;
    wait 0.05;
    var_3 = level._id_A54E.origin;
    var_4 = scripts\engine\utility::flatten_vector(vectorNormalize(var_3 - var_2));
    var_5 = scripts\engine\utility::flatten_vector(vectorNormalize(level._id_A54E.origin - level.player.origin));
    var_6 = vectordot(var_4, var_5);
    var_7 = distance2d(level._id_A54E.origin, level.player.origin);

    if((var_7 <= 100.0 || var_6 <= 0.1) && level.player isonground()) {
      level.player thread scripts\sp\utility::_id_D2CD(75, 0.2);

      foreach(var_9 in var_1) {
        var_9 _meth_82B1(var_9 scripts\sp\utility::_id_7DC1("frigate_slide_debris"), 1.3);
      }

      foreach(var_12 in level.allies) {
        var_12 _meth_82B1(var_12 scripts\sp\utility::_id_7DC1("mons_run"), 1.3);
      }

      level._id_FC89 _meth_82B1(level._id_FC89 scripts\sp\utility::_id_7DC1("mons_run"), 1.3);
    } else {
      level.player thread scripts\sp\utility::_id_D2CD(90, 0.2);

      foreach(var_9 in var_1) {
        var_9 _meth_82B1(var_9 scripts\sp\utility::_id_7DC1("frigate_slide_debris"), 1.1);
      }

      foreach(var_12 in level.allies) {
        var_12 _meth_82B1(var_12 scripts\sp\utility::_id_7DC1("mons_run"), 1.1);
      }

      level._id_FC89 _meth_82B1(level._id_FC89 scripts\sp\utility::_id_7DC1("mons_run"), 1.1);
    }

    wait 0.2;
  }
}

_id_F2AA() {
  level waittill("hit_ground3");
  wait 2.0;

  foreach(var_1 in level.allies) {
    var_1 _meth_82B1(var_1 scripts\sp\utility::_id_7DC1("mons_run"), 1.0);
  }
}

_id_102E4(var_0, var_1) {
  thread _id_102E2();
  earthquake(0.75, 1, level.player.origin, 200);
  level.player playRumbleOnEntity("damage_heavy");
  level._id_EA2C scripts\engine\utility::delaythread(0.5, scripts\sp\utility::_id_10346, "heist_slt_reyes");
  scripts\sp\anim::_id_17FC(level._id_A54E._id_1FBB, "explosion", "stumble_explode", "mons_run");
  scripts\sp\anim::_id_17FC(level._id_A54E._id_1FBB, "shield_on", "shield_on", "mons_run");
  scripts\sp\anim::_id_17FC(level._id_A54E._id_1FBB, "shield_off", "shield_off", "mons_run");
  scripts\sp\anim::_id_17FC(level._id_A54E._id_1FBB, "jetpack_boost_fake", "jetpack_boost", "kash_slide");
  level._id_A54E thread _id_A54C();
  var_0 thread _id_743B();
  var_0 thread scripts\sp\anim::_id_1F35(var_1, "player_slide");
  level.player playSound("scn_heist_mons_scuttle_scene_01");
  var_0 scripts\sp\anim::_id_1F35(level._id_A54E, "kash_slide");
  var_0 thread scripts\sp\anim::_id_1F35(level._id_A54E, "kash_hang");
  var_0 thread scripts\sp\anim::_id_1F35(var_1, "player_hang");
  scripts\engine\utility::waitframe();
  var_0 scripts\sp\anim::_id_1F29(level._id_A54E, "kash_hang", 1.0);
  var_0 scripts\sp\anim::_id_1F29(var_1, "player_hang", 1.0);
  thread _id_A608(var_0, var_1);
  wait 2.5;
  level._id_EA2C thread scripts\sp\utility::_id_10346("heist_slt_reyesboost");

  while(!level.player _meth_81CE()) {
    wait 0.1;
  }

  if(isalive(level.player)) {
    level notify("player_boosted");
    level thread _id_E7BD();
    level.player playSound("scn_heist_mons_scuttle_scene_02");
    level thread _id_6ADA();
    level.player thread scripts\sp\utility::_id_1034D("heist_plr_hangon");
    scripts\engine\utility::flag_set("mons_boost");
    scripts\engine\utility::flag_set("slide_scene_done");
    scripts\engine\utility::delaythread(6.5, ::_id_DD01);

    foreach(var_3 in level.allies) {
      var_3 thread _id_F295();
    }

    var_0 thread scripts\sp\anim::_id_1F2C(level.allies, "mons_run");
    var_0 thread _id_C138();
    var_0 thread _id_A55D();
    var_0 thread _id_BAE7();
    var_0 scripts\sp\anim::_id_1F35(var_1, "player_boost");
    level notify("start_door_slt");
    level thread _id_13DC8();
    level thread _id_D06E();
    level.player thread scripts\sp\utility::_id_F526("normal");
  }
}

_id_102E2() {
  setmusicstate("");
  level waittill("player_boosted");
  wait 5;
  setmusicstate("mx_237_heist_finalroom_setup_temp");
}

_id_AC8C() {
  var_0 = getEnt("lit_exp_mons_topdeck_01", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = 20000;
  var_0 _meth_82FC((0.937255, 0.654902, 0.337255));
  var_2 = 0.25;
  var_3 = gettime() / 1000;

  while(gettime() / 1000 - var_3 < var_2) {
    var_4 = (gettime() / 1000 - var_3) / var_2;
    var_5 = scripts\sp\math::_id_6A8E(0, var_1, var_4);
    var_0 setlightintensity(var_5);
    wait 0.05;
  }

  var_0 setlightintensity(var_1);
  wait 0.5;
  var_2 = 0.5;
  var_3 = gettime() / 1000;

  while(gettime() / 1000 - var_3 < var_2) {
    var_4 = (gettime() / 1000 - var_3) / var_2;
    var_5 = scripts\sp\math::_id_6A8E(var_1, 0, var_4);
    var_0 setlightintensity(var_5);
    wait 0.05;
  }

  var_0 setlightintensity(0);
}

_id_E7BD() {
  var_0 = 2.3;
  var_1 = gettime() / 1000;
  var_2 = 0;

  while(gettime() / 1000 - var_1 < var_0) {
    if(level.player _meth_81CE() && !var_2) {
      level.player playSound("scn_heist_plr_boost");
      level.player _meth_8244("subtle_tank_rumble");
      var_2 = 1;
    }

    if(!level.player _meth_81CE() && var_2) {
      level.player stoprumble("subtle_tank_rumble");
      level.player playSound("double_jump_release_plr");
      var_2 = 0;
    }

    wait 0.25;
  }

  level.player stoprumble("subtle_tank_rumble");
  level.player playSound("double_jump_release_plr");
}

_id_6ADA() {
  var_0 = 2.3;
  var_1 = gettime() / 1000;
  var_2 = 0;
  var_3 = 1.0;
  setomnvar("ui_hud_heist_boost", 1);
  setomnvar("ui_hud_heist_boost_amount", var_3);

  while(gettime() / 1000 - var_1 < var_0) {
    if(level.player _meth_81CE()) {
      var_3 = var_3 - 0.025;
    }

    var_3 = clamp(var_3, 0, 1);
    setomnvar("ui_hud_heist_boost_amount", var_3);
    wait 0.05;
  }

  setomnvar("ui_hud_heist_boost", 0);
}

_id_A54C() {
  level waittill("jetpack_boost");
  var_0 = undefined;
  var_1 = ["tag_jet_bottom_1", "tag_shield_back", "tag_stowed_hip_rear"];

  foreach(var_3 in var_1) {
    if(scripts\sp\utility::hastag(self.model, var_3)) {
      var_0 = var_3;
      break;
    }
  }

  if(!isDefined(var_0)) {
    return;
  }
  playFXOnTag(scripts\engine\utility::getfx("vfx_heist_jetpack_cliffhanger"), self, var_0);
  childthread scripts\sp\utility::play_sound_on_entity("double_jump_boost_npc");
}

_id_C138() {
  scripts\engine\utility::flag_init("kash_anim_end");
  wait(getanimlength(level._id_A54E scripts\sp\utility::_id_7DC1("mons_run")) * 0.9);
  scripts\engine\utility::flag_set("kash_anim_end");
}

_id_D2E8() {
  level waittill("stumble_explode");
  wait 0.2;
  earthquake(0.25, 1, level.player.origin, 200);
  level.player playRumbleOnEntity("damage_heavy");
  playFXOnTag(scripts\engine\utility::getfx("vfx_ra_finale_expl_medium"), self, "p7_debris_concrete_rubble_lg_02_lod0");
  thread scripts\engine\utility::play_sound_in_space("mons_deck_explode_sfx", (-14218, 16799, -85535));
  level thread _id_AC8C();

  if(distance2d(self.origin, level.player.origin) <= 500.0) {
    level.player shellshock("default_nosound", 2.0, undefined, 0);
    level.player thread scripts\sp\utility::_id_D2CD(50, 0.2);
    wait 2.0;
    level.player thread scripts\sp\utility::_id_D2CD(90, 1.0);
  }
}

_id_4E87(var_0) {
  wait 4.25;
  earthquake(0.75, 1, level.player.origin, 200);
  level.player playRumbleOnEntity("damage_heavy");
  playFX(scripts\engine\utility::getfx("vfx_heist_debris_impact"), self.origin + (0, 0, -60), scripts\engine\utility::flatten_vector(level.player.origin - self.origin));
  var_1 = getEntArray("slide_debris_ground_dmg_1", "targetname");
  var_2 = getEntArray("slide_debris_ground_prst_1", "targetname");

  foreach(var_4 in var_1) {
    var_4 show();
  }

  foreach(var_4 in var_2) {
    var_4 hide();
  }

  var_8 = getEntArray("slide_debris_ground_dmg_2", "targetname");
  var_9 = getEntArray("slide_debris_ground_prst_2", "targetname");

  foreach(var_4 in var_8) {
    var_4 show();
  }

  foreach(var_4 in var_9) {
    var_4 hide();
  }

  level waittill("hit_ground");
  wait 0.25;
  playFX(scripts\engine\utility::getfx("vfx_heist_debris_impact"), var_0 gettagorigin("tag_origin"));
  var_14 = vectorNormalize(level.player.origin - var_0 gettagorigin("tag_origin"));
  playFX(scripts\engine\utility::getfx("vfx_heist_debris_impact"), var_0 gettagorigin("tag_origin") + var_14 * 120, var_14, (0, 0, 1));
  thread scripts\engine\utility::play_sound_in_space("scn_heist_mons_scuttle_big_debris", (-13129, 16516, -85510));
  wait 1.65;
  var_14 = vectorNormalize(level.player.origin - var_0 gettagorigin("tag_base_top1"));
  playFX(scripts\engine\utility::getfx("vfx_heist_debris_impact"), var_0 gettagorigin("tag_base_top1") + var_14 * 120, var_14, (0, 0, 1));
  level waittill("hit_ground3");
  playFX(scripts\engine\utility::getfx("vfx_heist_debris_impact"), var_0 gettagorigin("tag_base_top1"));
}

_id_AA49() {
  wait 3.1;
  playFX(scripts\engine\utility::getfx("vfx_heist_debris_impact"), self gettagorigin("tag_top"));
}

_id_BAE7() {
  var_0 = getEnt("debris_concrete_rubble_lg_03", "targetname");
  var_1 = getEnt("debris_concrete_rubble_lg_01", "targetname");
  var_2 = getEnt("debris_concrete_rubble_lg_02", "targetname");
  var_3 = getEnt("debris_concrete_rubble_lg_03_2", "targetname");
  var_4 = getEnt("veh_mil_air_ca_destroyer_dst_piece_small_09", "targetname");
  var_5 = getEnt("top_deck_airlock_door", "targetname");
  var_6 = getEnt("debris_concrete_rubble_lg_01_clip", "targetname");
  var_7 = getEnt("debris_concrete_rubble_lg_02_clip", "targetname");
  var_8 = getEnt("debris_concrete_rubble_lg_03_2_clip", "targetname");
  var_6 linkTo(var_1);
  var_7 linkTo(var_2);
  var_8 linkTo(var_3);
  var_0._id_1FBB = "debris1";
  var_1._id_1FBB = "debris2";
  var_2._id_1FBB = "debris3";
  var_3._id_1FBB = "debris4";
  var_4._id_1FBB = "debris5";
  var_5._id_1FBB = "airlock_door";
  var_0 scripts\sp\anim::_id_F64A();
  var_1 scripts\sp\anim::_id_F64A();
  var_2 scripts\sp\anim::_id_F64A();
  var_3 scripts\sp\anim::_id_F64A();
  var_4 scripts\sp\anim::_id_F64A();
  var_5 scripts\sp\anim::_id_F64A();
  scripts\sp\anim::_id_17FC(var_4._id_1FBB, "hit_ground", "hit_ground", "frigate_slide_debris");
  scripts\sp\anim::_id_17FC(var_4._id_1FBB, "hit_ground2", "hit_ground2", "frigate_slide_debris");
  scripts\sp\anim::_id_17FC(var_4._id_1FBB, "hit_ground3", "hit_ground3", "frigate_slide_debris");
  var_9 = [var_0, var_1, var_2, var_3, var_4, var_5];
  var_2 thread _id_D2E8();
  var_0 thread _id_4E87(var_4);
  scripts\engine\utility::delaythread(4.0, scripts\sp\anim::_id_1F27, var_9, "frigate_slide_debris", 1.1);
  scripts\engine\utility::delaythread(4.0, scripts\sp\anim::_id_1F27, level.allies, "mons_run", 1.1);
  level._id_FC89 scripts\engine\utility::delaycall(4.0, ::_meth_82B1, level._id_FC89 scripts\sp\utility::_id_7DC1("mons_run"), 1.1);
  level scripts\engine\utility::delaythread(4.0, ::_id_102E5, self, var_9);
  thread _id_F2AA();
  scripts\sp\anim::_id_1F2C(var_9, "frigate_slide_debris");
}

_id_A55D() {
  level._id_FC89 = scripts\sp\utility::_id_10639("shield");
  level._id_FC89._id_1FBB = "shield";
  level._id_FC89 scripts\sp\anim::_id_F64A();
  level._id_FC89 hide();
  thread scripts\sp\anim::_id_1F35(level._id_FC89, "mons_run");
  level waittill("shield_on");
  level._id_FC89 show();
  level waittill("shield_off");
  level._id_FC89 hide();
}

_id_D06E() {
  self endon("death");
  level endon("stop_killer_debris");

  for(;;) {
    if(distance2dsquared(level._id_A54E.origin, level.player.origin) >= squared(1500)) {
      level.player thread _id_B152();
      break;
    }

    wait 0.05;
  }
}

_id_6AAC(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "black";
  }

  var_2 = scripts\sp\hud_util::_id_7B4F(var_1);
  var_2 fadeovertime(var_0);
  var_2.alpha = 1;
  var_2.sort = 1;
  wait(var_0);
  level notify("kill_boost_button");
  scripts\engine\utility::flag_set("mons_boost");
  level.player playSound("scn_heist_debris_death");
  _id_0B60::_id_F32F();
  scripts\sp\utility::_id_B8D1();
}

_id_6AAD(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = "black";
  }

  var_3 = scripts\sp\hud_util::_id_7B4F(var_1);
  var_3 fadeovertime(var_0);
  var_3.alpha = 1;
  var_3.sort = 0;
  wait(var_0);
  level.player playSound("scn_heist_plr_onfire");
  level.player _meth_81D0();
}

_id_B152() {
  level.player endon("death");
  var_0 = scripts\sp\utility::_id_10639("debris1_kill");
  var_1 = undefined;
  var_2 = undefined;

  if(isDefined(level._id_8633)) {
    var_3 = vectordot(anglesToForward(level.player.angles), anglesToForward(level._id_8633.angles));
    var_4 = vectordot(anglestoright(level.player.angles), anglestoright(level._id_8633.angles));
    var_5 = (level._id_8633.angles[0] * var_4, level.player.angles[1], level._id_8633.angles[2] * var_3);
    var_1 = scripts\engine\utility::spawn_tag_origin(level.player.origin, var_5);
    var_2 = scripts\engine\utility::spawn_tag_origin(level.player getEye(), var_5);
  } else {
    var_1 = scripts\engine\utility::spawn_tag_origin(level.player.origin, level.player.angles);
    var_2 = scripts\engine\utility::spawn_tag_origin(level.player getEye(), level.player.angles);
  }

  var_1 linkTo(var_2);
  level.player _meth_823B(var_1);
  level.player _meth_823C(var_1, "tag_origin", 0.3, 0.1, 0.1);
  wait 0.3;
  var_0.origin = level.player.origin + anglestoup(level.player.angles) * 240;
  var_0.angles = scripts\engine\utility::randomvectorrange(0, 360);
  var_0 dontinterpolate();
  var_2 rotatepitch(-80.0, 0.3, 0.1, 0.1);
  level.player thread scripts\sp\utility::_id_D090("ges_frag_block");
  var_0 moveTo(level.player getEye(), 0.5);
  var_0 rotateTo((0, 0, 0), 0.5);
  wait 0.4;
  earthquake(0.5, 1, level.player.origin, 200);
  level.player playRumbleOnEntity("damage_heavy");
  _id_6AAC(0.1);
}

_id_11882() {
  self endon("death");
  level endon("stop_killer_debris");
  var_0 = 0;
  var_1 = 0;
  var_2 = undefined;
  var_3 = 200;
  var_4 = 10;
  var_5 = level.player scripts\engine\utility::spawn_tag_origin();
  var_5 linkTo(level.player);

  for(;;) {
    if(scripts\engine\utility::flag("slide_run_rcs_kill")) {
      if(!isDefined(var_2)) {
        level.player setclientomnvar("ui_show_temperature_gauge", 1);
        var_2 = 1;
        thread heist_temperature_sfx();
        level.player thread _id_328B(var_5);
      }

      var_0 = var_0 + var_4;
      var_0 = clamp(var_0, 0, var_3);
      var_1 = scripts\sp\math::_id_C097(0, var_3, var_0);
      level.player setclientomnvar("ui_helmet_meter_temperature", int(var_1));
      level.player dodamage(var_4, level.player.origin);
    } else {
      var_0 = var_0 - var_4;
      var_0 = clamp(var_0, 0, var_3);
      var_1 = scripts\sp\math::_id_C097(0, var_3, var_0);
      level.player setclientomnvar("ui_helmet_meter_temperature", int(var_1));

      if(var_0 <= 0 && isDefined(var_2)) {
        level.player setclientomnvar("ui_show_temperature_gauge", 0);
        var_2 = undefined;
        level.player notify("stop_temperature_sfx");
      }

      stopFXOnTag(level._effect["heist_burnup_scrnfx"], var_5, "tag_origin");
    }

    if(level.player.health <= 5) {
      break;
    }

    wait 0.05;
  }

  level.player thread _id_328B(var_5);
  _id_6AAD(0.2);
}

heist_temperature_sfx() {
  var_0 = spawn("script_origin", level.player.origin);
  var_0 linkTo(level.player);
  wait 0.05;
  var_0 playSound("ui_heist_temperature_warning_lp_start");
  var_0 thread heist_temperature_sfx_lp();
  wait 0.5;
  level.player scripts\engine\utility::waittill_any("stop_temperature_sfx", "death");
  var_0 stoploopsound("ui_heist_temperature_warning_lp");
  var_0 delete();
  level.player playSound("ui_heist_temperature_warning_lp_end");
}

heist_temperature_sfx_lp() {
  level.player endon("stop_temperature_sfx");
  level.player endon("death");
  wait 1.7;
  self playLoopSound("ui_heist_temperature_warning_lp");
}

_id_CBF9() {
  self endon("death");
  level endon("stop_killer_debris");

  for(;;) {
    if(scripts\engine\utility::flag_exist("slide_run_fall_kill") && scripts\engine\utility::flag("slide_run_fall_kill")) {
      wait 0.25;
      _id_B152();
    }

    wait 0.05;
  }
}

_id_328B(var_0) {
  level.player playSound("scn_heist_plr_onfire");
  var_1 = playFXOnTag(level._effect["heist_burnup_scrnfx"], var_0, "tag_origin");
}

_id_743B(var_0) {
  self endon("death");
  level endon("stop_killer_debris");
  var_1 = scripts\sp\vehicle::_id_1080C("slide_event_destroyer");
  level._id_4804 = var_1;
  wait 0.05;
  var_1 thread _id_0BB8::_id_39D0("idle");

  foreach(var_3 in var_1.turrets) {
    foreach(var_5 in var_3) {
      var_5 delete();
    }
  }

  var_1._id_1FBB = "slide_frigate";
  var_1 scripts\sp\anim::_id_F64A();
  thread scripts\sp\anim::_id_1F35(var_1, "heist_mons_slide_fall_frigate");
  level._id_4822 hide();
  scripts\engine\utility::delaythread(6.5, ::_id_7584);
  level thread _id_F08F();
  wait 6.5;
  var_8 = scripts\engine\utility::getStruct("killer_debris_struct_2", "targetname");
  var_9 = scripts\engine\utility::spawn_tag_origin(var_8.origin + anglestoup(var_8.angles) * -500, var_8.angles + (0, 0, 0));
  var_9 linkTo(level._id_31FD);
  playFXOnTag(scripts\engine\utility::getfx("vfx_heist_building_impact_debris"), var_9, "tag_origin");
  wait 0.2;
  playFXOnTag(scripts\engine\utility::getfx("vfx_heist_building_impact_debris"), var_9, "tag_origin");
  thread scripts\engine\utility::play_sound_in_space("scn_heist_mons_scuttle_bld_explo", var_9.origin + (0, 0, -800));
  wait 0.8;
  level thread scripts\sp\maps\heist\heist_util::_id_1130C();

  for(;;) {
    level.player playSound("heist_mons_quakes_ext");
    thread _id_69E8();
    wait 0.05;
    level.player scripts\engine\utility::delaythread(0.2, scripts\sp\utility::play_sound_on_entity, "heist_emt_dist_explosion_tail");
    thread _id_69E8();
    wait 0.1;
    wait 0.05;
    level.player scripts\engine\utility::delaythread(0.2, scripts\sp\utility::play_sound_on_entity, "heist_emt_dist_explosion_tail");
    thread scripts\engine\utility::play_sound_in_space("jackal_explode_grnd", var_9.origin + (0, 0, -800));
    thread _id_69E8();
    wait 0.1;
    level.player scripts\engine\utility::delaythread(0.2, scripts\sp\utility::play_sound_on_entity, "heist_emt_dist_explosion_tail");
    thread _id_69E8();
    wait 1.0;
    level.player playSound("heist_mons_quakes_ext");
    thread _id_69E8();
    wait 1.5;
    thread scripts\engine\utility::play_sound_in_space("heist_emt_dist_explosion_tail", var_9.origin + (0, 0, -800));
    thread _id_69E8();
    wait 0.5;
    level.player scripts\engine\utility::delaythread(0.2, scripts\sp\utility::play_sound_on_entity, "heist_emt_dist_explosion_tail");
    thread _id_69E8();
    wait 1.0;
    level.player playSound("heist_mons_quakes_ext");
    thread _id_69E8();
    wait 0.25;
    level.player scripts\engine\utility::delaythread(0.2, scripts\sp\utility::play_sound_on_entity, "heist_emt_dist_explosion_tail");
    wait 0.1;
    level.player scripts\engine\utility::delaythread(0.2, scripts\sp\utility::play_sound_on_entity, "heist_emt_dist_explosion_tail");
    thread _id_69E8();
    wait 0.1;
  }
}

_id_69E8() {
  earthquake(0.25, 1, level.player.origin, 200);
  level.player playRumbleOnEntity("damage_heavy");
}

_id_F08F() {
  self endon("death");
  level endon("stop_killer_debris");
  wait 16.0;
  var_0 = scripts\engine\utility::getStruct("second_bldng_expl", "targetname");
  var_1 = scripts\engine\utility::spawn_tag_origin(var_0.origin + anglestoup(var_0.angles) * 1800 + anglestoright(var_0.angles) * 800 + anglesToForward(var_0.angles) * -500, var_0.angles);
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = [];
  var_8 = [];
  var_9 = [];
  var_10 = [];
  var_11 = [];
  var_12 = [];
  var_13 = [];
  var_14 = undefined;
  var_15 = undefined;
  var_16 = undefined;
  var_17 = undefined;
  var_18 = undefined;

  foreach(var_20 in level._id_31FE) {
    if(isDefined(var_20.script_parameters)) {
      switch (var_20.script_parameters) {
        case "bldng_flr_1":
          var_2 = var_20;
          var_14 = var_20 scripts\engine\utility::spawn_tag_origin();
          var_14 linkTo(var_2);
          break;
        case "bldng_flr_2":
          var_3 = var_20;
          var_15 = var_20 scripts\engine\utility::spawn_tag_origin();
          var_15 linkTo(var_3);
          break;
        case "bldng_flr_3":
          var_4 = var_20;
          var_16 = var_20 scripts\engine\utility::spawn_tag_origin();
          var_16 linkTo(var_4);
          break;
        case "bldng_flr_4":
          var_5 = var_20;
          var_17 = var_20 scripts\engine\utility::spawn_tag_origin();
          var_17 linkTo(var_5);
          break;
        case "bldng_flr_5":
          var_6 = var_20;
          var_18 = var_20 scripts\engine\utility::spawn_tag_origin();
          var_18 linkTo(var_6);
          break;
      }

      continue;
    }

    var_7 = scripts\engine\utility::array_add(var_7, var_20);
  }

  foreach(var_20 in level._id_31FF) {
    if(isDefined(var_20.script_parameters)) {
      switch (var_20.script_parameters) {
        case "dmg_bldng_flr_1":
          var_8 = scripts\engine\utility::array_add(var_8, var_20);
          break;
        case "dmg_bldng_flr_2":
          var_9 = scripts\engine\utility::array_add(var_9, var_20);
          break;
        case "dmg_bldng_flr_3":
          var_10 = scripts\engine\utility::array_add(var_10, var_20);
          break;
        case "dmg_bldng_flr_4":
          var_11 = scripts\engine\utility::array_add(var_11, var_20);
          break;
        case "dmg_bldng_flr_5":
          var_12 = scripts\engine\utility::array_add(var_12, var_20);
          break;
      }

      continue;
    }

    var_13 = scripts\engine\utility::array_add(var_13, var_20);
  }

  var_24 = [var_2, var_3, var_4, var_5, var_6];
  var_25 = [var_8, var_9, var_10, var_11, var_12];
  var_26 = [var_14, var_15, var_16, var_17, var_18];
  playFXOnTag(scripts\engine\utility::getfx("vfx_heist_building_second_roof"), var_18, "tag_origin");
  wait 1.0;

  foreach(var_28, var_20 in var_13) {
    var_20 show();
  }

  foreach(var_20 in var_7) {
    var_20 hide();
  }

  foreach(var_32 in level._id_31FF) {
    var_32 show();
  }

  foreach(var_32 in level._id_31FE) {
    var_32 hide();
  }

  wait 1.5;

  for(var_28 = 4; var_28 > -1; var_28--) {
    var_24[var_28] hide();

    foreach(var_20 in var_25[var_28]) {
      var_20 show();
    }

    playFXOnTag(scripts\engine\utility::getfx("vfx_heist_building_whole_floor_glass_breaking"), var_26[var_28], "tag_origin");
    wait 1.25;
  }

  wait 1.0;
}

_id_7584() {
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0.origin = var_0.origin + anglestoup(var_0.angles) * -300;
  var_0.origin = var_0.origin + anglestoright(var_0.angles) * -700;
  playFXOnTag(scripts\engine\utility::getfx("vfx_heist_dustmoment_hanging_dust_lrg"), var_0, "tag_origin");
  playFX(scripts\engine\utility::getfx("vfx_heist_dustmoment_hanging_dust_lrg"), var_0.origin + anglesToForward(var_0.angles) * -800);
  playFX(scripts\engine\utility::getfx("vfx_heist_dustmoment_hanging_dust_lrg"), var_0.origin + anglesToForward(var_0.angles) * -1600);
  playFX(scripts\engine\utility::getfx("vfx_heist_dustmoment_hanging_dust_lrg"), var_0.origin + anglesToForward(var_0.angles) * 800);
  playFX(scripts\engine\utility::getfx("vfx_heist_dustmoment_hanging_dust_lrg"), var_0.origin + anglesToForward(var_0.angles) * 1600);
  playFX(scripts\engine\utility::getfx("vfx_heist_dustmoment_hanging_dust_lrg"), var_0.origin + anglesToForward(var_0.angles) * 2400);
  playFX(scripts\engine\utility::getfx("vfx_heist_dustmoment_hanging_dust_lrg"), var_0.origin + anglesToForward(var_0.angles) * 3200);
  playFX(scripts\engine\utility::getfx("vfx_heist_dustmoment_hanging_dust_lrg"), var_0.origin + anglestoup(var_0.angles) * 800);
  playFX(scripts\engine\utility::getfx("vfx_heist_dustmoment_hanging_dust_lrg"), var_0.origin + anglesToForward(var_0.angles) * -800 + anglestoup(var_0.angles) * 800);
  playFX(scripts\engine\utility::getfx("vfx_heist_dustmoment_hanging_dust_lrg"), var_0.origin + anglesToForward(var_0.angles) * -1600 + anglestoup(var_0.angles) * 800);
  playFX(scripts\engine\utility::getfx("vfx_heist_dustmoment_hanging_dust_lrg"), var_0.origin + anglesToForward(var_0.angles) * 800 + anglestoup(var_0.angles) * 800);
  playFX(scripts\engine\utility::getfx("vfx_heist_dustmoment_hanging_dust_lrg"), var_0.origin + anglesToForward(var_0.angles) * 1600 + anglestoup(var_0.angles) * 800);
  playFX(scripts\engine\utility::getfx("vfx_heist_dustmoment_hanging_dust_lrg"), var_0.origin + anglesToForward(var_0.angles) * 2400 + anglestoup(var_0.angles) * 800);
  playFX(scripts\engine\utility::getfx("vfx_heist_dustmoment_hanging_dust_lrg"), var_0.origin + anglesToForward(var_0.angles) * 3200 + anglestoup(var_0.angles) * 800);
}

_id_DC3A() {
  level endon("stop_killer_debris");
  var_0 = level.player scripts\engine\utility::spawn_tag_origin();
  level thread _id_40AD(var_0);
  playFXOnTag(scripts\engine\utility::getfx("vfx_heist_raining_debris"), var_0, "tag_origin");

  for(;;) {
    var_0.origin = level.player.origin;
    wait 0.05;
  }
}

_id_40AD(var_0) {
  level waittill("stop_killer_debris");
  stopFXOnTag(scripts\engine\utility::getfx("vfx_heist_raining_debris"), var_0, "tag_origin");
  wait 0.05;
  var_0 delete();
}

_id_A1CE(var_0) {
  var_1 = scripts\sp\vehicle::_id_1080D("slide_jackal_amb");
  var_1 notsolid();
  var_1 _id_0BDC::_id_19AB(230, 50);

  if(isDefined(var_0)) {
    wait(randomfloatrange(0.7, 1.5));
    var_1 _meth_81D0();
  } else {
    var_1 waittill("end_spline");
    var_1 _meth_81D0();
  }
}

_id_A608(var_0, var_1) {
  level endon("player_boosted");
  wait 2.0;
  scripts\sp\utility::_id_56BE("boost_hint");
  var_2 = scripts\sp\utility::_id_10639("debris1_kill");
  var_2._id_1FBB = "debris1_kill";
  var_2 scripts\sp\anim::_id_F64A();
  var_0 thread scripts\sp\anim::_id_1F35(var_2, "frigate_slide_debris_kill");
  wait 2.7;
  thread _id_6AAC(0.1);
  level._id_A54E playSound("hst_metal_twang");
  level.player playSound("hst_zombie_dismember_arm");
  level._id_A54E scripts\sp\utility::_id_1101B();
  level._id_A54E _meth_83A1();
  level._id_A54E _meth_81D0();
}

_id_BA4F() {
  if(scripts\engine\utility::flag("mons_boost") || scripts\engine\utility::flag("mons_boost_failed")) {
    return 1;
  }

  return 0;
}

_id_16DD(var_0, var_1) {
  var_2 = getEnt(var_0, "targetname");
  var_2 thread[[var_1]]();
  return;
}

_id_A0EB() {
  var_0 = -100;
  var_1 = 5000;
  var_2 = 800;
  var_3 = scripts\engine\utility::getStruct("collapse_pos_1", "targetname");
  level._id_4822 = getEnt("crash_before_window", "targetname");
  level._id_4822 moveTo(var_3.origin + (var_0, var_1, var_2), 0.05);
  level._id_4822.origin = level._id_4822.origin + (var_0, var_1, var_2);

  if(isDefined(level._id_31FD)) {
    return;
  }
}

_id_320B() {
  level endon("start_slide");
  wait 0.05;
  var_0 = level._id_31FD.origin + anglestoright(level._id_31FD.angles) * -500;
  level._id_31FD.origin = var_0;
  wait 0.05;
  var_1 = level._id_31FD.origin + anglesToForward(level._id_31FD.angles) * -800;

  for(;;) {
    level._id_31FD moveTo(var_1, 30.0, 10, 10);
    wait 32.0;
    level._id_31FD moveTo(var_0, 30.0, 10, 10);
    wait 32.0;
  }
}

_id_320C() {
  var_0 = level._id_31FD.origin;
  var_1 = level._id_31FD.origin + anglesToForward(level._id_31FD.angles) * -2000;
  level waittill("start_slide");
  level._id_31FD.origin = var_0;
  level._id_31FD dontinterpolate();
  scripts\engine\utility::flag_wait("slide_scene_done");
  var_2 = getanimlength(level._id_EA2C scripts\sp\utility::_id_7DC1("mons_run"));
  level._id_31FD moveTo(var_1, var_2, 0.0, var_2 * 0.5);
}

_id_A0EC() {
  var_0 = 50;
  var_1 = 300;
  var_2 = 0;
  scripts\sp\utility::_id_127B3("mons_start_frigate_scene");
  var_3 = scripts\engine\utility::getStruct("collapse_pos_1", "targetname");
  var_4 = scripts\engine\utility::getStruct("collapse_pos_2", "targetname");
  var_5 = scripts\engine\utility::getStruct("collapse_pos_3", "targetname");
  scripts\engine\utility::flag_wait("deck_wallrun");

  if(isDefined(level._id_31FD)) {
    level._id_31FD moveTo(var_5.origin + (var_0, 2000, var_2), 40);
  }
}

_id_119E9() {
  level.player playSound("heist_mons_quakes");
  level.player earthquakeforplayer(0.5, 3, level.player.origin, 360);
  var_0 = randomfloatrange(1.2, 1.4);
  level.player _meth_8291(0.3, 0.3, 0.3, var_0, 0, -1, 0, 30, 30, 30);
  level._id_8632 rotateTo((0, 0, 8), 0.1);
  level._id_3F8E rotateTo((0, 0, 8), 0.1);
  scripts\engine\utility::flag_wait("steel_dragon_scene_done");
  level.player playSound("heist_mons_quakes");
  level._id_8632 rotateTo((0, 0, 0), 4, 1, 1);
  level._id_3F8E rotateTo((0, 0, 0), 4, 1, 1);
  level.player earthquakeforplayer(0.5, 3, level.player.origin, 360);
  var_0 = randomfloatrange(1.2, 1.4);
  level.player _meth_8291(0.2, 0.2, 0.2, var_0, 0, -1, 0, 30, 30, 30);
}

_id_F295() {
  var_0 = getanimlength(scripts\sp\utility::_id_7DC1("mons_run"));
  wait(var_0);
  scripts\sp\utility::_id_414F();
  set_ally_color_enddeck();
  self.ignoreall = 0;
  scripts\sp\utility::_id_51E1("combat");
  scripts\sp\utility::_id_F417(1);
  scripts\sp\utility::_id_15F5("post_anim_color");
  scripts\engine\utility::flag_set("run_anim_done");
}

_id_BACD() {
  scripts\sp\maps\heist\heist_util::_id_957C();
  scripts\sp\maps\heist\heist_util::_id_9686();
  scripts\sp\maps\heist\heist_util::_id_9706();
  scripts\sp\maps\heist\heist_util::_id_968E();
  thread _id_DD01();
  scripts\sp\maps\heist\heist_util::_id_1065E();
  scripts\sp\maps\heist\heist_util::_id_106D9();
  scripts\sp\maps\heist\heist_util::_id_107BE();
  scripts\sp\maps\heist\heist_util::_id_1074D();
  scripts\sp\utility::_id_F5AF("start_mons_mid_deck", [level.player, level._id_6754, level._id_30F6, level._id_EA2C, level._id_A54E]);
  wait 0.1;
  thread scripts\sp\maps\heist\heist_util::_id_FD33("breach");
}

_id_BACC() {
  foreach(var_1 in level.allies) {
    var_1.ignoreall = 1;
  }

  thread _id_6740();
  thread _id_5468();
  thread scripts\sp\maps\heist\heist_util::_id_1103D();
  thread _id_BD36();
  thread _id_BD37();
  scripts\sp\maps\heist\heist_breach::_id_9684();
  thread _id_6B70();
}

_id_6B70() {
  wait 4.0;
  level thread scripts\sp\maps\heist\heist_util::_id_1103D();
  level thread _id_DC3A();
}

_id_5468() {
  level.player endon("death");
  wait 13;
  level._id_EA2C scripts\sp\utility::_id_10346("heist_slt_shesgonnahit");
  wait 2;
  level._id_6754 scripts\sp\utility::_id_10346("heist_eth_brace");
  wait 5;
  scripts\sp\utility::_id_1034D("heist_plr_wegood");
  level._id_30F6 scripts\sp\utility::_id_10346("heist_brk_yessir");
  level._id_EA2C thread scripts\sp\utility::_id_10346("heist_slt_affirmative");
  wait 0.5;
  level._id_6754 scripts\sp\utility::_id_10346("heist_eth_solid2");
  level._id_A54E scripts\sp\utility::_id_10346("heist_ksh_beenbettercapta");
  scripts\engine\utility::flag_set("dialogue_mid_deck_complete");
}

_id_3205() {
  while(!self isonground()) {
    wait 0.05;
  }

  self playgestureviewmodel("ges_antigrav_reaction");
  var_0 = randomfloatrange(2.7, 3.3);
  self _meth_8291(0.25, 0.25, 0.25, var_0, 0, -1, 0, 30, 30, 30);
  self playRumbleOnEntity("heavy_3s");
  var_1 = vectorNormalize((-100, 50, 0));
  var_1 = var_1 * 13;
  thread scripts\sp\maps\heist\heist_util::_id_4D77(var_1, 1.5);
  wait 2;
  level.player stopgestureviewmodel("ges_antigrav_reaction");
}

_id_3206() {
  level.player earthquakeforplayer(0.5, 1, level.player.origin, 360);
  playFXOnTag(scripts\engine\utility::getfx("dropship_slide_crash_glass"), level._id_7602, "tag_origin");
  wait 2;
  stopFXOnTag(scripts\engine\utility::getfx("dropship_slide_crash_glass"), level._id_7602, "tag_origin");
}

_id_3204() {
  level._id_8632 rotateTo((0, 0, 3), 0.1);
  level._id_320A rotateTo((0, 0, 3), 0.1);
  scripts\engine\utility::flag_wait("building_start_scrape");
  level.player._id_8632 rotateTo((0, 0, 0), 3);
}

_id_320F() {
  playFXOnTag(scripts\engine\utility::getfx("vfx_hst_building_explosion_01"), level._id_7602, "tag_origin");
  scripts\engine\utility::play_sound_in_space("alien_meteor_impact", level._id_7602.origin + (-1000, 0, 0));
  level.player earthquakeforplayer(0.5, 2, level.player.origin, 360);
  level.player thread _id_4553(0.35, 2.5);
  level.player setmovespeedscale(0.65);
  wait 3;
  playFXOnTag(scripts\engine\utility::getfx("vfx_hst_building_explosion_01"), level._id_7602, "tag_origin");
  wait 3;
  level._id_7602 delete();
  level._id_7603 delete();
}

_id_4553(var_0, var_1) {
  var_2 = gettime() + var_1 * 1000;

  while(gettime() < var_2) {
    var_3 = randomfloatrange(0.4, 1);
    level.player earthquakeforplayer(var_0, var_3, level.player.origin, 360);
    wait(var_3);
  }

  wait 0.5;
  level.player setmovespeedscale(1);
}

_id_320E() {
  wait 0.1;

  if(!isDefined(level.player._id_8632)) {
    level.player._id_8632 = spawn("script_model", (0, 0, 0));
    level.player _meth_823F(level.player._id_8632);
  }

  level.player._id_8632 rotateTo((0, 0, 5), 3);
  level._id_320A rotateTo((0, 0, 5), 3);
  level.player._id_8632 waittill("rotatedone");
  wait 6;
  level.player._id_8632 rotateTo((0, 0, 0), 3);
  level._id_320A rotateTo((0, 0, 0), 4);
}

_id_BA7C() {
  scripts\sp\maps\heist\heist_util::_id_968E();
  scripts\sp\maps\heist\heist_util::_id_9686();
  scripts\sp\maps\heist\heist_util::_id_1065E();
  scripts\sp\maps\heist\heist_util::_id_106D9();
  scripts\sp\maps\heist\heist_util::_id_107BE();
  scripts\sp\maps\heist\heist_util::_id_1074D();
  scripts\sp\utility::_id_F5AF("start_mons_end_deck", [level.player, level._id_6754, level._id_30F6, level._id_EA2C, level._id_A54E]);
  wait 0.1;
  thread _id_BD36();
  scripts\engine\utility::flag_set("end_deck_startpoint");
  scripts\engine\utility::delaythread(3, scripts\engine\utility::flag_set, "run_anim_done");
  thread _id_BD37();
  thread _id_1C1E();
  scripts\sp\utility::_id_15F5("post_anim_color");
  wait 5;
  scripts\engine\utility::flag_set("transient_mons_bridge_approach");
}

_id_BA7B() {
  scripts\sp\utility::_id_28D7("axis");
  scripts\sp\utility::_id_28D7("allies");
  scripts\sp\utility::_id_127AE("hangar_door_trig", "targetname");
  thread hangar_door_lighting();
  scripts\engine\utility::delaythread(12, ::_id_5437);
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
    var_2 _meth_83A1();
  }

  scripts\sp\utility::_id_228A(getaiarray("axis"));
  thread _id_106C4();
  thread scripts\sp\maps\heist\heist_util::_id_FD33("breach");
  scripts\sp\maps\heist\heist_breach::_id_9684();
  thread _id_639E();
  thread _id_1C16();
  thread _id_F112();
  thread _id_678A();
  thread _id_A8B6();
  scripts\engine\utility::flag_wait("deck_combat_end");
}

_id_106C4() {
  thread _id_E5A7();
  scripts\engine\utility::waitframe();
  var_0 = scripts\sp\utility::_id_107EA("flank_guy");
  var_1 = scripts\sp\utility::_id_107EA("crew_02_c6");
  var_0 scripts\sp\utility::_id_51E1("sprint");
  var_0 scripts\sp\utility::_id_72EC("iw7_sdfar", "primary");
  var_2 = scripts\sp\utility::_id_22CD("crew_01_runner", 1);
  var_3 = scripts\sp\utility::_id_22CD("crew_01", 1);
  var_3 = scripts\engine\utility::array_combine(var_3, var_2);

  foreach(var_5 in var_3) {
    if(isalive(var_5)) {
      var_5 scripts\sp\utility::_id_72EC("iw7_erad+eradscope+shotgunerad_sp", "primary");
    }
  }

  scripts\engine\utility::array_add(var_3, var_0);
  scripts\engine\utility::array_add(var_3, var_1);

  foreach(var_5 in var_3) {
    if(isalive(var_5)) {
      var_5 _meth_8504(1, "soldier");
      var_5 scripts\sp\utility::_id_51E1("frantic");
    }
  }

  var_9 = getaiarray("axis", "all");

  foreach(var_11 in var_9) {
    var_11.grenadeammo = 0;
  }

  foreach(var_11 in var_9) {
    var_11.ignoreall = 1;
    var_11.ignoreme = 1;
  }

  wait 3;

  foreach(var_11 in var_9) {
    if(!isDefined(var_11)) {
      continue;
    }
    var_11.ignoreme = 0;
    var_11.ignoreall = 0;
    wait 0.5;
  }
}

_id_B7C4() {
  level endon("deck_combat_end");

  for(;;) {
    level._id_8632 rotateTo((5, 3, 2), 3);
    wait 4;
    level._id_8632 rotateTo((0, 0, 0), 3);
    wait 4;
  }
}

_id_4A66() {
  if(isalive(self)) {
    self.ignoreall = 1;
    self.ignoreme = 1;
  }

  wait 5;

  if(isalive(self)) {
    self.ignoreall = 0;
    self.ignoreme = 0;
  }
}

_id_1C0A() {
  foreach(var_1 in level.allies) {
    var_1 set_ally_color_enddeck();
  }
}

_id_1C1E() {
  foreach(var_1 in level.allies) {
    var_1 scripts\sp\utility::_id_414F();
    var_1 set_ally_color_enddeck();
  }
}

set_ally_color_enddeck() {
  if(self == level._id_6754) {
    scripts\sp\utility::_id_F3B5("g");
  } else if(self == level._id_EA2C) {
    scripts\sp\utility::_id_F3B5("b");
  } else if(self == level._id_30F6) {
    scripts\sp\utility::_id_F3B5("o");
  } else if(self == level._id_A54E) {
    scripts\sp\utility::_id_F3B5("y");
  }
}

_id_BD36() {
  _id_0E29::hack_blacklist_all_robots(1);
  thread scripts\sp\maps\heist\heist_util::_id_127B1("vol_upper_deck_inside", _id_0E29::hack_blacklist_all_robots, 0);
  level waittill("start_door_slt");
  thread hangar_door_lighting();
  wait 7.0;
  var_0 = getEnt("door_upper_deck", "targetname");
  var_0.clip = getEnt("upper_deck_clip", "targetname");
  level._id_4F6A = getEnt("upper_deck_push_trig", "targetname");
  var_0.clip linkTo(var_0);
  level._id_4F6A enablelinkTo();
  level._id_4F6A linkTo(var_0);
  thread _id_D30E();
  var_0 movez(20, 0.1);
  wait 0.2;
  var_1 = gettime() / 1000;
  var_2 = 22;
  var_0.clip scripts\engine\utility::delaycall(var_2 - 1, ::disconnectpaths);
  var_0 movez(-150, var_2);
  scripts\engine\utility::flag_wait("kash_anim_end");
  var_3 = gettime() / 1000;
  var_4 = var_3 - var_1;
  var_5 = var_4 / var_2;
  var_6 = -150 + -150 * (var_5 * -1);
  var_0 movez(var_6, 0.4);
  wait 0.4;

  if(level.player istouching(level._id_4F6A)) {
    level.player _meth_81D0();
  }

  level notify("deck_door_closed");
  scripts\engine\utility::flag_set("close_deck_door");
  _id_D102();
  level._id_4804 _id_0BA9::_id_397B();
  wait 0.5;
  level.player thread scripts\sp\utility::_id_D2CD(100, 0.2);
  scripts\sp\utility::_id_2669("post_slide_inside");
  level notify("stop_killer_debris");
  scripts\engine\utility::flag_set("transient_mons_bridge_approach");
}

hangar_door_lighting() {
  scripts\engine\utility::flag_wait("lgt_deck_hangar_door");
  var_0 = getEntArray("mons_gundeck_door", "script_noteworthy");
  scripts\engine\utility::array_thread(var_0, scripts\sp\lights::_id_AB83, 0, 0.5);
}

_id_59B2() {
  for(;;) {
    wait 0.05;
  }
}

_id_BD37() {
  wait 0.5;
  var_0 = getEnt("door_upper_deck_2", "targetname");
  var_0.clip = getEnt("upper_deck_clip_2", "targetname");
  var_0.clip linkTo(var_0);

  if(scripts\engine\utility::flag("end_deck_startpoint")) {
    var_0 movez(-130, 0.1);
    var_0 waittill("movedone");
  } else {
    var_0 movez(-130, 7);
    var_0 waittill("movedone");
    var_0.clip disconnectPaths();
  }
}

_id_6740() {
  foreach(var_1 in level.allies) {
    var_1.ignoreall = 1;
  }

  wait 1;
  var_3 = scripts\sp\utility::_id_107EA("deck_slide_runner", 1);
  var_3._id_1FBB = "generic";
  var_3 scripts\sp\utility::_id_B14F(1);
  var_3.ignoreall = 1;
  wait 0.5;
  var_4 = scripts\engine\utility::getStruct("sdf_door_slide", "targetname");
  var_4 scripts\sp\anim::_id_1F17(var_3, "deck_runner_slide");
  var_4 thread scripts\sp\anim::_id_1F35(var_3, "deck_runner_slide");
  scripts\engine\utility::waitframe();
  var_4 scripts\sp\anim::_id_1F29(var_3, "deck_runner_slide", 1.2);
  wait 2.5;
  var_3 _meth_83A1();
  var_5 = getnode("runner_node", "targetname");
  var_3 setgoalpos(var_5.origin);
  wait 2.0;

  if(isalive(var_3)) {
    var_3 delete();
  }

  var_6 = [level._id_EA2C, level._id_6754, level._id_30F6, level._id_A54E];

  foreach(var_1 in level.allies) {
    var_1.ignoreall = 0;
  }
}

_id_DD01() {
  thread scripts\sp\maps\heist\heist_util::_id_DCFE("rcs_slide_1");
  thread scripts\sp\maps\heist\heist_util::_id_DCFE("rcs_slide_2");
  thread scripts\sp\maps\heist\heist_util::_id_DCFE("rcs_slide_3");
  wait 0.25;
  thread scripts\sp\maps\heist\heist_util::_id_DCFE("rcs_slide_4");
  thread scripts\sp\maps\heist\heist_util::_id_DCFE("rcs_slide_5");
  scripts\sp\maps\heist\heist_util::_id_DCFE("rcs_slide_6");
  wait 1.25;
  var_0 = scripts\engine\utility::getStructArray("mons_rcs_thruster_low", "targetname");
  var_1 = scripts\engine\utility::getStructArray("mons_rcs_thruster_high", "targetname");
  var_2 = scripts\engine\utility::spawn_tag_origin(var_0[0].origin, var_0[0].angles);
  var_3 = scripts\engine\utility::spawn_tag_origin(var_0[1].origin, var_0[1].angles);
  var_4 = scripts\engine\utility::spawn_tag_origin(var_0[2].origin, var_0[2].angles);
  var_5 = scripts\engine\utility::spawn_tag_origin(var_1[0].origin, var_1[0].angles);
  var_6 = scripts\engine\utility::spawn_tag_origin(var_1[1].origin, var_1[1].angles);
  var_7 = scripts\engine\utility::spawn_tag_origin(var_1[2].origin, var_1[2].angles);
  var_8 = [var_2, var_3, var_4];
  var_9 = [var_5, var_6, var_7];
  var_4 playSound("veh_capitol_ship_rcs_med");
  var_7 playSound("veh_capitol_ship_rcs_med");
  level.player playRumbleOnEntity("damage_heavy");
  level scripts\engine\utility::delaythread(0.0, ::_id_DD02);
  var_2 playLoopSound("veh_capitol_ship_rcs_lp");
  var_3 playLoopSound("veh_capitol_ship_rcs_lp");
  var_4 playLoopSound("veh_capitol_ship_rcs_lp");
  var_5 playLoopSound("veh_capitol_ship_rcs_lp");
  var_6 playLoopSound("veh_capitol_ship_rcs_lp");
  var_7 playLoopSound("veh_capitol_ship_rcs_lp");

  while(!scripts\engine\utility::flag("close_deck_door")) {
    foreach(var_11 in var_8) {
      playFXOnTag(scripts\engine\utility::getfx("vfx_heist_rcs_thruster_small"), var_11, "tag_origin");
    }

    foreach(var_11 in var_9) {
      playFXOnTag(scripts\engine\utility::getfx("vfx_heist_rcs_thruster_small"), var_11, "tag_origin");
    }

    wait 10;
  }

  foreach(var_11 in var_8) {
    var_11 delete();
  }

  foreach(var_11 in var_9) {
    var_11 delete();
  }
}

_id_DD02() {
  var_0 = getEntArray("lit_thrust_mons_topdeck", "targetname");
  var_1 = (0.937255, 0.654902, 0.337255);
  var_2 = 500;

  foreach(var_4 in var_0) {
    var_4 _meth_82FC((0.937255, 0.654902, 0.337255));
    var_4 thread _id_AB85(var_2, 0.25);
  }
}

_id_AB85(var_0, var_1) {
  var_1 = 0.25;
  var_2 = gettime() / 1000;

  while(gettime() / 1000 - var_2 < var_1) {
    var_3 = (gettime() / 1000 - var_2) / var_1;
    var_4 = scripts\sp\math::_id_6A8E(0, var_0, var_3);
    self setlightintensity(var_4);
    wait 0.05;
  }

  self setlightintensity(var_0);
}

_id_D30E() {
  level endon("stop_killer_debris");
  var_0 = vectorNormalize((0, -100, 0));
  var_0 = var_0 * 20;

  for(;;) {
    if(level.player istouching(level._id_4F6A)) {
      level.player _meth_8251(var_0);
      wait 0.3;
      level.player _meth_8251((0, 0, 0));
    }

    wait 0.05;
  }
}

_id_D102() {
  var_0 = 0;
  var_1 = getEntArray("vol_upper_deck_inside", "targetname");

  foreach(var_3 in var_1) {
    if(level.player istouching(var_3)) {
      var_0 = 1;
    }
  }

  scripts\engine\utility::waitframe();

  if(var_0 == 0) {
    _id_B152();
  }
}

_id_639E() {
  var_0 = 1;
  scripts\engine\utility::flag_wait("seekers_released");

  while(var_0) {
    var_1 = getaicount("axis", "all");

    if(var_1 == 0) {
      var_0 = 0;
    }

    wait 0.1;
  }

  scripts\sp\utility::_id_28D7("axis");
  scripts\sp\utility::_id_28D7("allies");
  scripts\engine\utility::flag_set("deck_combat_end");
}

_id_A8B6() {
  var_0 = 1;
  scripts\engine\utility::flag_wait("seekers_released");

  while(var_0) {
    var_1 = getaicount("axis", "human");

    if(var_1 == 1) {
      var_0 = 0;
    }

    wait 0.1;
  }

  var_1 = getaispeciesarray("axis", "human");

  if(var_1.size > 0) {
    foreach(var_3 in var_1) {
      var_3 scripts\sp\maps\heist\heist_util::_id_19DB();
    }
  }
}

_id_1C16() {
  level endon("deck_allies_moved");
  scripts\engine\utility::flag_wait("run_anim_done");
  wait 3;

  for(;;) {
    var_0 = getaicount("axis", "all");

    if(var_0 < 8) {
      scripts\engine\utility::array_thread(level.allies, ::_id_1D23);
      scripts\sp\utility::_id_15F1("deck_combat_color_press", "targetname");
      level notify("deck_allies_moved");
    }

    wait 0.5;
  }

  thread _id_3C33();
}

_id_3C33() {
  var_0 = getEnt("chamber_1", "targetname");
  var_1 = getaiarray("axis");

  foreach(var_3 in var_1) {
    if(var_3 istouching(var_0)) {
      var_3 scripts\sp\maps\heist\heist_util::_id_19DB();
    }
  }
}

_id_1D23() {
  if(self == level._id_30F6) {
    wait 6;
  }

  if(self == level._id_A54E) {
    wait 5.5;
  }

  if(self == level._id_EA2C) {
    wait 5;
  }

  scripts\sp\utility::_id_414F();
  scripts\sp\utility::_id_F3B5("r");
}

_id_F112() {
  level endon("deck_combat_end");
  var_0 = scripts\engine\utility::getStruct("deck_lookat", "targetname");
  var_1 = getEnt("mons_seeker_crate_base", "targetname");
  var_2 = getEnt("mons_seeker_crate_lid", "targetname");
  scripts\engine\utility::waitframe();
  var_1 linkTo(var_2);
  var_3 = scripts\engine\utility::getStruct("mons_seeker_crate_open", "targetname");
  var_4 = scripts\engine\utility::getStruct("mons_seeker_crate_1", "targetname");
  var_5 = getEnt("seeker_crate_1", "targetname");
  var_6 = getEnt("seeker_crate_2", "targetname");
  var_7 = getEnt("seeker_crate_3", "targetname");

  while(!level.player scripts\sp\utility::_id_D1DF(var_0.origin, 0.75)) {
    wait 1;
  }

  var_8 = 0.05;
  var_9 = 0.02;
  var_10 = scripts\engine\utility::spawn_script_origin(var_2.origin, var_2.angles);
  var_2 movez(2, var_9);
  var_2 waittill("movedone");
  var_2 movez(-2, var_9);
  var_2 rotateTo(var_4.angles, var_8);
  var_2 waittill("rotatedone");
  var_2 rotateTo(var_10.angles, var_8);
  var_2 waittill("rotatedone");
  var_2 movez(2, var_9);
  var_2 movez(-2, var_9);
  var_2 rotateTo(var_4.angles, var_8);
  var_2 waittill("rotatedone");
  var_2 rotateTo(var_10.angles, var_8);
  var_2 waittill("rotatedone");
  var_2 movez(2, var_9);
  var_2 rotateTo(var_4.angles, var_8 + 0.05);
  var_2 waittill("rotatedone");
  var_2 moveTo(var_10.origin, 0.35);
  var_2 rotateTo(var_10.angles, var_8);
  var_2 waittill("rotatedone");
  scripts\engine\utility::waitframe();
  var_1 unlink();
  var_2 moveTo(var_3.origin, 0.15);
  var_2 rotateTo(var_3.angles, 0.15);
  var_11 = _id_0E26::_id_107D2(var_5.origin, var_5.angles, "axis", level._id_30F6);
  var_5 delete();
  wait 0.35;
  var_12 = _id_0E26::_id_107D2(var_6.origin, var_6.angles, "axis", level._id_6754);
  var_6 delete();
  scripts\engine\utility::waitframe();
  wait 1;
  var_13 = _id_0E26::_id_107D2(var_7.origin, var_7.angles, "axis", level._id_EA2C);
  var_13.moveplaybackrate = 0.55;
  var_7 delete();
  scripts\engine\utility::waitframe();
  scripts\engine\utility::flag_set("seekers_released");
}

_id_E5A7() {
  scripts\sp\utility::_id_127AE("hangar_door_trig", "targetname");
  wait 3;
  var_0 = _id_0B6C::_id_FA2A("mons_deck_rss");
  var_0 thread _id_0B6C::_id_8953();
  wait 1;
  var_1 = getaiarray("axis", "all");

  foreach(var_3 in var_1) {
    var_3.grenadeammo = 0;
  }
}

_id_678A() {
  level endon("ethan_presses");
  level endon("stop_color_triggers");
  level waittill("deck_allies_moved");

  for(;;) {
    var_0 = getaicount("axis", "all");

    if(var_0 < 3) {
      level._id_6754 scripts\sp\utility::_id_414F();
      level._id_6754 scripts\sp\utility::_id_F3B5("p");
      scripts\sp\utility::_id_15F1("deck_combat_color_breach", "targetname");
      level notify("ethan_presses");
    }

    wait 0.5;
  }
}

_id_116C6() {
  while(level._id_116BF == 1) {
    level._id_1169E++;
    wait(level._id_116C7);
  }
}

_id_548F() {
  wait 3.5;
  level._id_30F6 scripts\sp\utility::_id_10346("heist_ksh_gravitysuckssir");
  level.player scripts\sp\utility::_id_1034D("heist_plr_bigtime");
}

_id_5437() {
  if(level._id_10CDA != "mons_end_deck") {
    scripts\engine\utility::flag_wait("dialogue_mid_deck_complete");
  }

  wait 2;
  var_0 = scripts\engine\utility::getStruct("deck_loudhorn", "targetname") scripts\engine\utility::spawn_tag_origin();
  var_0 scripts\engine\utility::play_sound_in_space("heist_kch_alertthisisadmi");
  var_0 delete();
  scripts\sp\utility::_id_28D8("axis");
  scripts\sp\utility::_id_28D8("allies");
}