/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_424d9a66f5fd1677.gsc
***********************************************/

main() {
  _id_13EDC1BE8BD42660::main();
  _id_2F783D0F46E2744C::main();
  _id_61CB3B69FC9CF49A::main();

  if(level.createfx_enabled) {
    return;
  }
  _id_DB40733CB25062E1();
  scripts\cp\utility::coop_mode_enable(["sp_stealth"]);
  _id_D525F1534752BFC7();
  _id_C4D555BF9485AC3B();
  level._id_1F9A4D8F7E4586BB = 1;
  level._id_3423C60CBB355C81 = 1;
  level._id_AAF6515899A6735D = ::setup_soldier_stealth;

  if(!isDefined(game["enable_farah_chair_animation"]))
    game["enable_farah_chair_animation"] = getdvarint("dvar_39FDE18CC3CB4B90", 1);

  _id_3B64EB40368C1450::_id_2D6E7E0B80767910("blinded_player", ["offhand_weapons", "prone", "melee", "execution_attack", "weapon_pickup", "mantle", "cp_munitions", "sprint", "killstreaks", "allow_melee_victim"]);
  _id_3B64EB40368C1450::_id_2D6E7E0B80767910("blinded_player_chair_tied", ["allow_movement", "allow_jump"]);
  _id_3B64EB40368C1450::_id_2D6E7E0B80767910("captured_player_munitions", ["cp_munitions"]);
  _id_3B64EB40368C1450::_id_2D6E7E0B80767910("captured_player_weapons", ["weapon_pickup", "offhand_weapons", "weapon_switch", "melee"]);
  _id_3B64EB40368C1450::_id_2D6E7E0B80767910("voteSwap", ["crouch", "prone", "usability", "weapon_switch", "supers", "gesture", "killstreaks", "cp_munitions", "offhand_primary_weapons", "fire", "offhand_secondary_weapons", "offhand_weapons", "allow_movement", "melee"]);
}

#using_animtree("script_model");

_id_D986A6B508AAE1E0() {
  level.scr_animtree["price_rig"] = #animtree;
  level.scr_anim["price_rig"]["ziptie_release"] = % iw9_cp_raid4_prisoncell_price;
  level.scr_animname["price_rig"]["ziptie_release"] = "iw9_cp_raid4_prisoncell_price";
  level.scr_eventanim["price_rig"]["ziptie_release"] = "ziptie_release";
  level.scr_goaltime["price_rig"]["ziptie_release"] = 0;
  level.scr_animtree["player_rig"] = #animtree;
  level.scr_anim["player_rig"]["chair_idle"] = % iw9_cp_raid4_chair_break_farah_idle;
  level.scr_animname["player_rig"]["chair_idle"] = "iw9_cp_raid4_chair_break_farah_idle";
  level.scr_eventanim["player_rig"]["chair_idle"] = "chair_idle";
  level.scr_goaltime["player_rig"]["chair_idle"] = 0;
  level.scr_anim["player_rig"]["chair_break"] = % iw9_cp_raid4_chair_break_farah_break;
  level.scr_animname["player_rig"]["chair_break"] = "iw9_cp_raid4_chair_break_farah_break";
  level.scr_eventanim["player_rig"]["chair_break"] = "chair_break";
  level.scr_goaltime["player_rig"]["chair_break"] = 0;
  level.scr_anim["player_rig"]["ziptie_release_farah"] = % iw9_cp_raid4_prisoncell_farah;
  level.scr_animname["player_rig"]["ziptie_release_farah"] = "iw9_cp_raid4_prisoncell_farah";
  level.scr_eventanim["player_rig"]["ziptie_release_farah"] = "ziptie_release_farah";
  level.scr_goaltime["player_rig"]["ziptie_release_farah"] = 0;
  level.scr_anim["player_rig"]["hadir_captured"] = % iw9_cp_raid4_jail_intro_farah;
  level.scr_animname["player_rig"]["hadir_captured"] = "iw9_cp_raid4_jail_intro_farah";
  level.scr_eventanim["player_rig"]["hadir_captured"] = "hadir_captured";
  level.scr_goaltime["player_rig"]["hadir_captured"] = 0;
  scripts\common\anim::addnotetrack_customfunction("player_rig", "say_dx_cp_cpr4_cptr_fara_youareacowardtooasha", ::_id_F51F2C10C7235A58);
  scripts\common\anim::addnotetrack_customfunction("player_rig", "say_dx_cp_cpr4_cptr_fara_youareconfusedbetwee", ::_id_F51F2F10C72360F1);
  level.scr_anim["player_rig"]["hadir_captured_b"] = % iw9_cp_raid4_jail_intro_farah_b;
  level.scr_animname["player_rig"]["hadir_captured_b"] = "iw9_cp_raid4_jail_intro_farah_b";
  level.scr_eventanim["player_rig"]["hadir_captured_b"] = "hadir_captured_b";
  level.scr_goaltime["player_rig"]["hadir_captured_b"] = 0;
}

#using_animtree("generic_human");

_id_E06158633A435CCC() {
  level.scr_animtree["hadir_rig"] = #animtree;
  level.scr_anim["hadir_rig"]["hadir_captured"] = % iw9_cp_raid4_jail_intro_hadir;
  level.scr_animname["hadir_rig"]["hadir_captured"] = "iw9_cp_raid4_jail_intro_hadir";
  level.scr_eventanim["hadir_rig"]["hadir_captured"] = "hadir_captured";
  level.scr_goaltime["hadir_rig"]["hadir_captured"] = 0;
  level.scr_anim["guard_rig"]["hadir_captured"] = % iw9_cp_raid4_jail_intro_guard;
  level.scr_animname["guard_rig"]["hadir_captured"] = "iw9_cp_raid4_jail_intro_guard";
  level.scr_eventanim["guard_rig"]["hadir_captured"] = "hadir_captured";
  level.scr_goaltime["guard_rig"]["hadir_captured"] = 0;
}

_id_F51F2C10C7235A58(player_rig) {
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.farah, "dx_cp_cpr4_cptr_fara_youareacowardtooasha", 0, 1, 0);
}

_id_F51F2F10C72360F1(player_rig) {
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(level.farah, "dx_cp_cpr4_cptr_fara_youareconfusedbetwee", 0, 1, 0);
}

#using_animtree("script_model");

_id_22E9EAD73D37146C() {
  level.scr_animtree["chair"] = #animtree;
  level.scr_anim["chair"]["chair_idle"] = % iw9_cp_raid4_chair_break_prop_idle;
  level.scr_animname["chair"]["chair_idle"] = "iw9_cp_raid4_chair_break_prop_idle";
  level.scr_goaltime["chair"]["chair_idle"] = 0;
  level.scr_anim["chair"]["chair_break"] = % iw9_cp_raid4_chair_break_prop_break;
  level.scr_animname["chair"]["chair_break"] = "iw9_cp_raid4_chair_break_prop_break";
  level.scr_goaltime["chair"]["chair_break"] = 0;
  level.scr_anim["chair"]["hadir_captured"] = % iw9_cp_raid4_jail_intro_prop_chair;
  level.scr_animname["chair"]["hadir_captured"] = "iw9_cp_raid4_jail_intro_prop_chair";
  level.scr_goaltime["chair"]["hadir_captured"] = 0;
  level.scr_animtree["ziptie"] = #animtree;
  level.scr_anim["ziptie"]["ziptie_release_farah"] = % iw9_cp_raid4_prisoncell_ziptie;
  level.scr_animname["ziptie"]["ziptie_release_farah"] = "iw9_cp_raid4_prisoncell_ziptie";
  level.scr_goaltime["ziptie"]["ziptie_release_farah"] = 0;
  level.scr_anim["ziptie"]["chair_idle"] = % iw9_cp_raid4_chair_break_ziptie_idle;
  level.scr_animname["ziptie"]["chair_idle"] = "iw9_cp_raid4_chair_break_ziptie_idle";
  level.scr_goaltime["ziptie"]["chair_idle"] = 0;
  level.scr_anim["ziptie"]["chair_break"] = % iw9_cp_raid4_chair_break_ziptie_break;
  level.scr_animname["ziptie"]["chair_break"] = "iw9_cp_raid4_chair_break_ziptie_break";
  level.scr_goaltime["ziptie"]["chair_break"] = 0;
}

_id_DB40733CB25062E1() {}

onplayerconnect(player) {}

_id_27013CA5F99005FE(_id_E3108E412AFB3811) {
  self setclientomnvar("ui_earned_streak_visible", _id_E3108E412AFB3811);
  _id_3B64EB40368C1450::_id_3633B947164BE4F3("captured_player_munitions", _id_E3108E412AFB3811);
}

onplayerspawned() {
  scripts\engine\utility::ent_flag_wait("intro_binks_complete");
  thread scripts\cp\execution::_id_94C333BD965E6685();
  _id_27013CA5F99005FE(0);
  _id_3B64EB40368C1450::_id_3633B947164BE4F3("captured_player_weapons", 0);
  self _meth_670863FC4008C3D8((10135.7, 17635.1, -3683.48));
  _id_F42869166D50FBE9 = scripts\cp\cp_checkpoint::_id_9EED75023A958C18();

  if(isDefined(_id_F42869166D50FBE9) && (_id_F42869166D50FBE9 == "" || _id_F42869166D50FBE9 == "checkpoint_captured_blind")) {
    thread _id_0D84C331CC811EE0();
    return;
  } else {
    start = getDvar("start");

    if(start == "captured" || start == "") {
      thread _id_0D84C331CC811EE0();
      return;
    }
  }

  thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 0, 1);
}

_id_0D84C331CC811EE0() {
  thread _id_8718B816A731C75A();
  thread _id_CBAA7ABD11CE1DFF();
  setDvar("dvar_E8512E1508AFEFE8", 0);
  level.pingsystemactive = getdvarint("dvar_E8512E1508AFEFE8", 0);
}

_id_CBAA7ABD11CE1DFF() {
  scripts\engine\utility::flag_wait("intro_binks_complete");
  scripts\cp\utility::_id_4CBAED764C116A25(1);
}

_id_04BFC487778DC703(spawnpoints, _id_80EE2BF8E69E86C3) {
  _id_48232C7BE8E19692 = self.pers["operator_override"].name;

  foreach(point in spawnpoints) {
    if(isDefined(point.script_noteworthy) && point.script_noteworthy == _id_48232C7BE8E19692) {
      _id_293D38BA5ADE4FA6();
      return point;
    }
  }

  return undefined;
}

_id_80E5F7E571C3C80F() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  scripts\engine\utility::flag_wait("hadir_guard_intro_spawn_complete");
  thread play_intro_animation();
  thread _id_D48473E1BEF4A5EC("chair_idle", undefined, 1, undefined, 1, 1);
}

_id_8718B816A731C75A() {
  self endon("disconnect");
  level endon("game_ended");

  if(self.pers["operator_override"].name == "farah_western") {
    thread _id_8C5BF27E60A8E1C7();
    level._id_A57B56E23A52AFE1 = 1;
    scripts\engine\utility::flag_wait("both_players_intro_binks_complete");

    if(getdvarint("dvar_DAE648DEBCE82FAF", 0)) {
      level._id_A57B56E23A52AFE1 = 0;
      level._id_5A2AF420BC54EE97._id_46E51D9C12FF301C[0] notify("trigger", self);
    }

    if(istrue(game["enable_farah_chair_animation"]))
      thread _id_80E5F7E571C3C80F();
    else {
      thread _id_F441A9864C0DC3C7(0.5);
      _id_3B64EB40368C1450::_id_3633B947164BE4F3("blinded_player_chair_tied", 1);
      scripts\cp\utility::_freezelookcontrols(0);
    }

    wait 2;
    self sethudtutorialmessage(&"COOP_GAME_PLAY/YOU_ARE_BLINDFOLDED", 1);
    _id_12E2FB553EC1605E::setcharactermodels("body_mp_farah_iw9_raid_captive", "tag_origin", "mp_vm_arms_farah_iw9_1_1");
    wait 4;
    self clearhudtutorialmessage();

    if(istrue(game["enable_farah_chair_animation"]))
      thread _id_C024CA5EF800A301();
    else
      level._id_A57B56E23A52AFE1 = 0;
  } else {
    thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 0, 1);
    scripts\cp\utility::allow_player_ignore_me(1);
    thread _id_D89D286082589DC3();
    thread _id_7775FB0D2FEBCB37();
  }

  thread _id_11811C954BBA79E3::_id_55B2AB068074D468();
}

_id_7775FB0D2FEBCB37() {
  level endon("chair_break_anim_play");
  self endon("death_or_disconnect");
  level endon("game_ended");
  level endon("chair_break_go_ahead");
  level endon("farah_killed");
  level waittill("intro_animation_completed");

  for(;;) {
    if(!istrue(self._id_D5AF94588739718C)) {
      wait 0.2;
      self clearhudtutorialmessage();
      continue;
    }

    wait 0.2;
    self clearhudtutorialmessage();
    self sethudtutorialmessage(&"COOP_GAME_PLAY/PRESS_TO_GIVE_ALL_CLEAR", 1);
    wait 0.2;
  }
}

_id_D89D286082589DC3() {
  level endon("chair_break_anim_play");
  self endon("death_or_disconnect");
  level endon("game_ended");
  level endon("chair_break_go_ahead");
  level endon("farah_killed");
  level waittill("intro_animation_completed");
  wait 1.5;
  self notifyonplayercommand("inputReceived", "+smoke");

  for(;;) {
    result = scripts\engine\utility::waittill_any_return_1("inputReceived");

    if(!istrue(self._id_D5AF94588739718C)) {
      continue;
    }
    switch (result) {
      case "inputReceived":
        self notifyonplayercommandremove("inputReceived", "+smoke");

        if(isDefined(level.price))
          level.price clearhudtutorialmessage();

        if(isDefined(level.alex))
          level.alex clearhudtutorialmessage();

        level notify("chair_break_go_ahead", self);
        return;
      default:
        break;
    }
  }
}

_id_C024CA5EF800A301() {
  level endon("chair_break_anim_play");
  self endon("death_or_disconnect");
  level endon("game_ended");
  self notifyonplayercommand("inputReceived", "+activate");
  self notifyonplayercommand("inputReceived", "+usereload");
  level waittill("intro_animation_completed");

  if(level.players.size > 1)
    level waittill("chair_break_go_ahead");

  wait 2;
  thread _id_F90E3BE3460EA7D1();

  for(;;) {
    result = scripts\engine\utility::waittill_any_return_1("inputReceived");

    switch (result) {
      case "inputReceived":
        level._id_A57B56E23A52AFE1 = 0;
        self notifyonplayercommandremove("inputReceived", "+activate");
        self notifyonplayercommandremove("inputReceived", "+usereload");
        self clearhudtutorialmessage();
        thread _id_BBDB0668377CB7E7();
        break;
      default:
        break;
    }
  }
}

_id_BBDB0668377CB7E7() {
  level.farah playSound("evt_raid4_farah_fly_chair_escape");
  thread _id_62E11D77B25C1D30::_id_A606867D80CFABD5(self, "dx_cp_cpr4_cptr_fara_grunteffort");
  _id_F441A9864C0DC3C7();
  _id_D48473E1BEF4A5EC("chair_break", "chair_break_anim_play", 1, 1, undefined, 1);
  scripts\engine\utility::flag_set("break_out_of_chair");
  game["enable_farah_chair_animation"] = 0;
  _id_3B64EB40368C1450::_id_3633B947164BE4F3("blinded_player_chair_tied", 1);
  scripts\cp\utility::_freezelookcontrols(0, 1);
}

_id_F90E3BE3460EA7D1() {
  level endon("chair_break_anim_play");
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    self clearhudtutorialmessage();
    self sethudtutorialmessage(&"COOP_GAME_PLAY/PRESS_TO_BREAK_CHAIR", 1);
    wait 5;
  }
}

play_intro_animation() {
  _id_448F3F72810BBA0B = getEnt("captured_chair", "targetname");
  scenenode = spawnStruct();
  scenenode.origin = (10135.7, 17635.1, -3683.48);
  scenenode.angles = (0, -135.538, 0);
  _id_448F3F72810BBA0B.scenenode = scenenode;
  self.scenenode = scenenode;
  _id_448F3F72810BBA0B.scenenode.code_classname = "node";

  while(!isDefined(level._id_0029C8AE4A2C2B71) || !isDefined(level._id_388D985C5B239914))
    wait 0.1;

  level.farah setOrigin(scenenode.origin, 1);
  level._id_0029C8AE4A2C2B71 setOrigin(scenenode.origin, 1);
  level._id_0029C8AE4A2C2B71.scenenode = scenenode;
  level._id_388D985C5B239914 setOrigin(scenenode.origin, 1);
  level._id_388D985C5B239914.scenenode = scenenode;
  level._id_0029C8AE4A2C2B71 thread _id_055B8229C19C258D::_id_AAA7C056D54B8461();
  _id_13D5D79FDFC0CDA8 = scripts\cp_mp\anim_scene::anim_scene_create_actor(level._id_0029C8AE4A2C2B71, "hadir_rig", 0, 0, 0, 0);
  _id_9B6EEEA89E244287 = scripts\cp_mp\anim_scene::anim_scene_create_actor(level._id_388D985C5B239914, "guard_rig", 0, 0, 0, 0);
  _id_BDDFB2346D56700F = scripts\cp_mp\anim_scene::anim_scene_create_actor(_id_448F3F72810BBA0B, "chair");
  actors = [_id_BDDFB2346D56700F, _id_9B6EEEA89E244287, _id_13D5D79FDFC0CDA8];
  level._id_0029C8AE4A2C2B71 playSound("iw9_cp_raid4_jail_intro_hadir_01");
  level._id_388D985C5B239914 playSound("iw9_cp_raid4_jail_intro_guard_01");
  started = _id_448F3F72810BBA0B.scenenode thread scripts\cp_mp\anim_scene::anim_scene(actors, "hadir_captured", 1, 1, undefined, 0, 0);
  _id_6844765A86EC90B2 = scripts\cp_mp\anim_scene::anim_scene_create_actor(level.farah, "player_rig", 1, 1, 1);
  actors = [_id_6844765A86EC90B2];
  level.farah playSound("iw9_cp_raid4_jail_intro_farah_01");
  started = _id_448F3F72810BBA0B.scenenode scripts\cp_mp\anim_scene::anim_scene(actors, "hadir_captured", 1, 0, undefined, 0, 0);
  _id_448F3F72810BBA0B.scenenode scripts\common\anim::anim_last_frame_solo(_id_6844765A86EC90B2.player_rig, "hadir_captured");
  started = _id_448F3F72810BBA0B.scenenode scripts\cp_mp\anim_scene::anim_scene(actors, "hadir_captured_b", 0, 0, undefined, 0, 0);
  thread _id_47FAB7476783708F();
  level notify("intro_animation_completed");
}

_id_47FAB7476783708F() {
  wait 0.25;
  level._id_0029C8AE4A2C2B71._id_D0E9753B09126417 = undefined;
  level._id_388D985C5B239914._id_D0E9753B09126417 = undefined;
  level._id_0029C8AE4A2C2B71 _id_18A73A64992DD07D::script_kill_ai(0);
  level._id_388D985C5B239914 _id_18A73A64992DD07D::script_kill_ai(0);
}

_id_D48473E1BEF4A5EC(anim_name, _id_34FB06C037BE3746, _id_3DBD514C3362AE0C, _id_5E4581952ACEDA50, _id_BAFDBCF4899D54F7, _id_2DFF5D5BDFCD87B2) {
  level endon("farah_killed");
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(istrue(_id_BAFDBCF4899D54F7))
    level waittill("intro_animation_completed");

  _id_448F3F72810BBA0B = getEnt("captured_chair", "targetname");
  _id_E695CF3561EC7CD3 = undefined;

  if(istrue(_id_2DFF5D5BDFCD87B2) && !isDefined(level._id_E695CF3561EC7CD3)) {
    _id_E695CF3561EC7CD3 = scripts\common\utility::_id_22490AAEBAAC105E("misc_ziptie_prop", level.farah.origin);
    _id_E695CF3561EC7CD3 setModel("misc_ziptie_prop");
    level._id_E695CF3561EC7CD3 = _id_E695CF3561EC7CD3;
  } else
    _id_E695CF3561EC7CD3 = level._id_E695CF3561EC7CD3;

  scenenode = spawnStruct();
  scenenode.origin = (10135.7, 17635.1, -3683.48);
  scenenode.angles = (0, -135.538, 0);
  _id_448F3F72810BBA0B.scenenode = scenenode;
  _id_448F3F72810BBA0B.scenenode.code_classname = "node";
  self.scenenode = scenenode;

  if(isDefined(_id_34FB06C037BE3746))
    level notify(_id_34FB06C037BE3746);

  if(!isDefined(_id_5E4581952ACEDA50))
    _id_5E4581952ACEDA50 = 1;

  _id_448F3F72810BBA0B.scenenode scripts\cp_mp\anim_scene::anim_scene_stop(1);

  if(istrue(_id_2DFF5D5BDFCD87B2)) {
    _id_EF192F97B39ACAD9 = scripts\cp_mp\anim_scene::anim_scene_create_actor(_id_E695CF3561EC7CD3, "ziptie");
    actorplayer = scripts\cp_mp\anim_scene::anim_scene_create_actor(self, "player_rig", 1, 1, 1);
    _id_BDDFB2346D56700F = scripts\cp_mp\anim_scene::anim_scene_create_actor(_id_448F3F72810BBA0B, "chair");
    actors = [actorplayer, _id_BDDFB2346D56700F, _id_EF192F97B39ACAD9];
    started = _id_448F3F72810BBA0B.scenenode scripts\cp_mp\anim_scene::anim_scene(actors, anim_name, 1, _id_5E4581952ACEDA50, undefined, 0, 0);

    if(isDefined(_id_E695CF3561EC7CD3))
      _id_E695CF3561EC7CD3 delete();

    return;
  }

  actorplayer = scripts\cp_mp\anim_scene::anim_scene_create_actor(self, "player_rig", 1, 0, 1);
  _id_BDDFB2346D56700F = scripts\cp_mp\anim_scene::anim_scene_create_actor(_id_448F3F72810BBA0B, "chair");
  actors = [actorplayer, _id_BDDFB2346D56700F];
  started = _id_448F3F72810BBA0B.scenenode scripts\cp_mp\anim_scene::anim_scene(actors, anim_name, 1, _id_5E4581952ACEDA50, undefined, 0, 0);
}

_id_8C5BF27E60A8E1C7() {
  level endon("game_ended");
  self endon("disconnect");

  if(getdvarint("dvar_8605C689D46957F4", 1))
    self setclientomnvar("ui_blinded_player_active", 1);

  self setclientomnvar("ui_stop_armor_hint", 1);
  thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 1, 0);
  self.playerstreakspeedscale = -0.35;
  level._id_E1008A2AFED467A7 = 1;
  scripts\cp\cp_agent_utils::set_agent_health(1);
  _id_12E2FB553EC1605E::updatemovespeedscale();
  scripts\engine\utility::ent_flag_wait("player_spawned_with_loadout");
  _id_0E7FCD60B4793720 = &"CP_RAID_COMPLEX_JUGG_MAZE/REMOVE_BINDINGS";
  _id_82DEE71300360BB0 = _id_C64C851114EE9603(self, _id_0E7FCD60B4793720, "j_spineupper", (10, -5, 0), 300, 90, 180, 70, "duration_none");
  _id_4A5D9641C457D2F6 = ["alex_western"];
  _id_82DEE71300360BB0 _id_D04B95CD171249A6(_id_4A5D9641C457D2F6);
  _id_82DEE71300360BB0 thread _id_C3348A2B4D748336(self);
  _id_82DEE71300360BB0 thread _id_89D62390197311E5(level.price);
  level._id_D8EF57E0CCA200FF = _id_82DEE71300360BB0;
  self setclientomnvar("ui_blindfolded_hud", 1);
  self setsoundsubmix("cp_raid_farrah_captured");
  _id_3B64EB40368C1450::_id_3633B947164BE4F3("blinded_player", 0);
  _id_3B64EB40368C1450::_id_3633B947164BE4F3("blinded_player_chair_tied", 0);
  scripts\cp\utility::_freezelookcontrols(1);
  thread _id_9F162E2F3B5FBF8A();
  thread _id_4451E5724907F3F2();
  wait 2;
  thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 0, 1);

  if(isDefined(level._id_AAF382B8120C5FCB))
    level._id_AAF382B8120C5FCB disableplayeruse(self);

  wait 3;

  if(getdvarint("dvar_8605C689D46957F4", 1))
    self setclientomnvar("ui_blinded_player_active", 1);

  foreach(interact in level._id_5A2AF420BC54EE97.interacts)
  interact._id_C5D3D8FF129F88BA disableplayeruse(self);
}

_id_F441A9864C0DC3C7(_id_B29D63D5BCEF6670) {
  if(isDefined(_id_B29D63D5BCEF6670))
    wait(_id_B29D63D5BCEF6670);

  scripts\cp\utility::_giveweapon("iw9_ziptie_mp");

  if(!scripts\cp\utility::isjuggernaut() && !isbot(self))
    scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate("iw9_ziptie_mp");
}

_id_4451E5724907F3F2() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  level endon("farah_killed");
  level endon("captured_completed");
  self notifyonplayercommand("stance_change", "+prone");

  while(self getclientomnvar("ui_blindfolded_hud") == 1) {
    result = scripts\engine\utility::waittill_any_return_1("stance_change");

    switch (result) {
      case "stance_change":
        level._id_A57B56E23A52AFE1 = 1;
        wait 0.2;
        self sethudtutorialmessage(&"COOP_GAME_PLAY/CANNOT_PRONE_BLIND", 1);
        wait 0.5;
        level._id_A57B56E23A52AFE1 = 0;
        break;
      default:
        break;
    }
  }

  self notifyonplayercommandremove("stance_change", "+prone");
}

_id_9F162E2F3B5FBF8A() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  level endon("farah_killed");
  level endon("captured_completed");

  while(self getclientomnvar("ui_blindfolded_hud") == 1) {
    if(istrue(level._id_A57B56E23A52AFE1)) {
      wait 0.2;
      continue;
    }

    level.blocked = 0;
    _id_1D0DFDFEE6CACB97 = self getvelocity();
    _id_E096D9982BE6A83C = vectorNormalize((self _meth_7CB78CCF830D7F81(), self _meth_7CB78BCF830D7D4E(), 0));

    if(!(_id_1D0DFDFEE6CACB97[0] > 10 || _id_1D0DFDFEE6CACB97[0] < -10 || _id_1D0DFDFEE6CACB97[1] > 10 || _id_1D0DFDFEE6CACB97[1] < -10 || _id_1D0DFDFEE6CACB97[2] > 10 || _id_1D0DFDFEE6CACB97[2] < -10) && !(_id_E096D9982BE6A83C[0] > 0.3 || _id_E096D9982BE6A83C[0] < -0.3 || _id_E096D9982BE6A83C[1] > 0.3 || _id_E096D9982BE6A83C[1] < -0.3 || _id_E096D9982BE6A83C[2] > 0.3 || _id_E096D9982BE6A83C[2] < -0.3)) {
      wait 0.2;
      self notify("clear_tutorial_messages");
      self clearhudtutorialmessage();
      continue;
    } else {
      if(_id_1D0DFDFEE6CACB97[0] > 10 || _id_1D0DFDFEE6CACB97[0] < -10 || _id_1D0DFDFEE6CACB97[1] > 10 || _id_1D0DFDFEE6CACB97[1] < -10 || _id_1D0DFDFEE6CACB97[2] > 10 || _id_1D0DFDFEE6CACB97[2] < -10) {
        wait 0.2;
        self notify("clear_tutorial_messages");
        self clearhudtutorialmessage();
        continue;
      }

      level.blocked = 1;
    }

    _id_55CBAAD0451D15A3 = scripts\engine\trace::ray_trace(self gettagorigin("j_spineupper") - (0, 0, 15), self gettagorigin("j_spineupper") - (0, 0, 15) + anglesToForward(self getplayerangles()) * 30, self);

    if(isDefined(_id_55CBAAD0451D15A3["hittype"]) && _id_55CBAAD0451D15A3["hittype"] != "hittype_none" && !istrue(level._id_67A8432ADEB6435A)) {
      level._id_67A8432ADEB6435A = 1;
      self sethudtutorialmessage(&"COOP_GAME_PLAY/BLOCKED_BLINDED", 1);
    } else
      level._id_67A8432ADEB6435A = undefined;

    _id_8D79ECCBAC18169D = scripts\engine\trace::ray_trace(self gettagorigin("j_spineupper") - (0, 0, 15), self gettagorigin("j_spineupper") - (0, 0, 15) + anglestoleft(self getplayerangles()) * 24, self);

    if(isDefined(_id_8D79ECCBAC18169D["hittype"]) && _id_8D79ECCBAC18169D["hittype"] != "hittype_none" && !istrue(level._id_2CD172FC4DA5275C)) {
      level._id_2CD172FC4DA5275C = 1;
      self sethudtutorialmessage(&"COOP_GAME_PLAY/BLOCKED_BLINDED", 1);
    } else
      level._id_2CD172FC4DA5275C = undefined;

    _id_B8290060D3AAF6CA = scripts\engine\trace::ray_trace(self gettagorigin("j_spineupper") - (0, 0, 15), self gettagorigin("j_spineupper") - (0, 0, 15) + anglestoright(self getplayerangles()) * 24, self);

    if(isDefined(_id_B8290060D3AAF6CA["hittype"]) && _id_B8290060D3AAF6CA["hittype"] != "hittype_none" && !istrue(level._id_DDEC7DE8B1ED91DF)) {
      level._id_DDEC7DE8B1ED91DF = 1;
      self sethudtutorialmessage(&"COOP_GAME_PLAY/BLOCKED_BLINDED", 1);
    } else
      level._id_DDEC7DE8B1ED91DF = undefined;

    _id_6EBFAFCF06305E63 = scripts\engine\trace::ray_trace(self gettagorigin("j_spineupper") - (0, 0, 15), self gettagorigin("j_spineupper") - (0, 0, 15) - anglesToForward(self getplayerangles()) * 24, self);

    if(isDefined(_id_6EBFAFCF06305E63["hittype"]) && _id_6EBFAFCF06305E63["hittype"] != "hittype_none" && !istrue(level._id_CD9009B5B205C31A)) {
      level._id_CD9009B5B205C31A = 1;
      self sethudtutorialmessage(&"COOP_GAME_PLAY/BLOCKED_BLINDED", 1);
    } else
      level._id_CD9009B5B205C31A = undefined;

    if(istrue(level.blocked) && !(_id_1D0DFDFEE6CACB97[0] > 10 || _id_1D0DFDFEE6CACB97[0] < -10 || _id_1D0DFDFEE6CACB97[1] > 10 || _id_1D0DFDFEE6CACB97[1] < -10 || _id_1D0DFDFEE6CACB97[2] > 10 || _id_1D0DFDFEE6CACB97[2] < -10))
      self sethudtutorialmessage(&"COOP_GAME_PLAY/BLOCKED_BLINDED", 1);
    else
      level.blocked = 0;

    wait 0.2;

    if(!istrue(level._id_CD9009B5B205C31A) && !istrue(level._id_67A8432ADEB6435A) && !istrue(level._id_2CD172FC4DA5275C) && !istrue(level._id_DDEC7DE8B1ED91DF) && !istrue(level.blocked)) {
      self notify("clear_tutorial_messages");
      self clearhudtutorialmessage();
    }

    wait 0.1;
  }

  self notify("clear_tutorial_messages");
  self clearhudtutorialmessage();
}

_id_CC7480C920DC1E44() {
  level endon("game_ended");
  level endon("farah_killed");
  self endon("button_pressed_done");

  while(scripts\cp\cp_gameskill::_id_DC6FD5E481FA370A(self)) {
    wait 0.1;
    continue;
  }

  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("anim_scene");
  self stopanimscriptsceneevent();
  self unlink();
  self notify("stop_button_animation");
  self notify("button_pressed_done");
}

_id_440C76A483A3C9F1() {
  level endon("farah_killed");
  self endon("death_or_disconnect");
  self endon("stop_button_animation");
  thread _id_CC7480C920DC1E44();
  _id_0E4731409BD255E0 = "_right";
  button = undefined;
  buttons = getEntArray("buddy_door_button", "script_noteworthy");

  if(buttons.size)
    button = scripts\engine\utility::getclosest(self.origin, buttons);

  scenenode = spawnStruct();
  scenenode.origin = button.origin;
  scenenode.angles = button.angles;
  button.scenenode = scenenode;
  self.scenenode = button.scenenode;
  actorplayer = scripts\cp_mp\anim_scene::anim_scene_create_actor(self, "plyr_twomandoor", 1, 1);
  _id_54E38BC53ABC8A5E = scripts\cp_mp\anim_scene::anim_scene_create_actor(button, "twomandoor_button");
  actorplayer scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(1);
  _id_54E38BC53ABC8A5E scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(1);
  actors = [actorplayer, _id_54E38BC53ABC8A5E];
  scripts\engine\utility::delaythread(2.5, scripts\engine\utility::send_notify, "button_pressed_anim");
  started = button.scenenode scripts\cp_mp\anim_scene::anim_scene(actors, "start" + _id_0E4731409BD255E0, 1, 0) && scripts\cp_mp\utility\player_utility::_isalive();
  self notify("button_pressed_done");
  button useanimtree(#animtree);
  scripts\engine\utility::delaythread(0.25, scripts\engine\utility::send_notify, "button_released_anim");
  button.scenenode scripts\cp_mp\anim_scene::anim_scene(actors, "stop" + _id_0E4731409BD255E0, 0, 1);
  button scriptmodelclearanim();
  button playSound("scn_cp_elevator_button_press");
  button setModel("electrical_cell_door_button_green");
}

_id_F983BE55A2B3629D(aliases, _id_4E19B0E89937FFAB, _id_DE8530CCC03BDAA9) {
  level endon("farah_killed");
  level endon("dialogueAgentInvalid");

  if(aliases.size > 1)
    result = _id_1F9FFC0B79384330::play_dialogue(aliases, "subtitle_iw9_cp_cpr4_cptr/", 0, ::_id_70EADD1D55E61C8F);
  else {
    _id_70EADD1D55E61C8F(0, aliases[0]);
    result = 1;
  }

  if(result == 0)
    return 0;

  if(aliases.size == 2)
    result = result - 2;

  _id_7E9CCC2D6DDB44DA = _id_4E19B0E89937FFAB[aliases[result - 1]];

  if(!isDefined(_id_7E9CCC2D6DDB44DA))
    _id_7E9CCC2D6DDB44DA = _id_DE8530CCC03BDAA9 scripts\engine\utility::deck_draw();

  level._id_652C062C6B740024 _id_5D265B4FCA61F070::_id_C9A09B3BA9C68F8D(0.4, _id_7E9CCC2D6DDB44DA, 1, 0);
  level._id_C5BD05483E55285F = 0;
  return result;
}

_id_70EADD1D55E61C8F(delay, alias) {
  scripts\engine\utility::flag_set("vo_guardDistracted");
  level._id_C5BD05483E55285F = 1;
  level._id_652C062C6B740024 setgoalpos(level._id_D6BA25E54AFE7E5E.origin);
  level._id_15E258DE13533615 = level._id_D6BA25E54AFE7E5E;
  _id_62E11D77B25C1D30::_id_A606867D80CFABD5(self, alias, 0, 1, 0);
}

_id_B817EB235F57A1F4(_id_5C76167572FCE9C1) {
  level endon("farah_killed");
  level endon("dialogueAgentInvalid");
  aliases = ["dx_cp_cpr4_cptr_alex_easyguy", "dx_cp_cpr4_cptr_alex_relaxpal"];
  result = _id_1F9FFC0B79384330::play_dialogue(aliases, "subtitle_iw9_cp_cpr4_cptr/", 0, ::_id_70EADD1D55E61C8F);
  level._id_C5BD05483E55285F = 0;
}

_id_89D62390197311E5(player, _id_48ECD34FC60598FE) {
  level endon("game_ended");
  level endon("farah_stop_squad_wipe_monitor");

  if(isDefined(player))
    player endon("disconnect");

  _id_F42869166D50FBE9 = scripts\cp\cp_checkpoint::_id_9EED75023A958C18();

  if(!isDefined(_id_F42869166D50FBE9) || _id_F42869166D50FBE9 == "")
    _id_F42869166D50FBE9 = getDvar("start");

  if(isDefined(_id_48ECD34FC60598FE) && _id_F42869166D50FBE9 != "checkpoint_rescue_warehouse")
    level waittill(_id_48ECD34FC60598FE);

  while(isDefined(self)) {
    if(!isDefined(player)) {
      wait 0.2;
      continue;
    }

    if(!scripts\cp\cp_gameskill::_id_DC6FD5E481FA370A(level.farah))
      self disableplayeruse(player);
    else
      self enableplayeruse(player);

    wait 0.2;
  }
}

_id_F7473B71A209644E() {
  level endon("farah_killed");
  self endon("death_or_disconnect");
  level endon("game_ended");
  _id_56ECF27761F21942 = scripts\engine\utility::getStruct("farah_price_release_bindings", "targetname");
  _id_E695CF3561EC7CD3 = undefined;

  if(isDefined(level.farah) && !isDefined(level._id_E695CF3561EC7CD3)) {
    _id_E695CF3561EC7CD3 = scripts\common\utility::_id_22490AAEBAAC105E("misc_ziptie_prop", level.farah.origin);
    _id_E695CF3561EC7CD3 setModel("misc_ziptie_prop");
    level._id_E695CF3561EC7CD3 = _id_E695CF3561EC7CD3;
  } else
    _id_E695CF3561EC7CD3 = level._id_E695CF3561EC7CD3;

  scenenode = spawnStruct();
  scenenode.origin = _id_56ECF27761F21942.origin;
  scenenode.angles = _id_56ECF27761F21942.angles;
  _id_56ECF27761F21942.scenenode = scenenode;
  self.scenenode = _id_56ECF27761F21942.scenenode;

  if(!isDefined(level.price) && !isDefined(level.farah)) {
    return;
  }
  if(!isDefined(level.price)) {
    _id_4244F43E52B74D6D = scripts\cp_mp\anim_scene::anim_scene_create_actor(level.farah, "player_rig", 1, 1, 1);
    _id_EF192F97B39ACAD9 = scripts\cp_mp\anim_scene::anim_scene_create_actor(_id_E695CF3561EC7CD3, "ziptie");
    actors = [_id_4244F43E52B74D6D, _id_EF192F97B39ACAD9];
    started = _id_56ECF27761F21942.scenenode scripts\cp_mp\anim_scene::anim_scene(actors, "ziptie_release", 1, 1, undefined, undefined, 0);

    if(isDefined(_id_E695CF3561EC7CD3))
      _id_E695CF3561EC7CD3 delete();

    return;
  }

  if(!isDefined(level.farah)) {
    _id_B7C6214827F99D00 = scripts\cp_mp\anim_scene::anim_scene_create_actor(level.price, "price_rig", 1, 0, 1);
    actors = [_id_B7C6214827F99D00];
    started = _id_56ECF27761F21942.scenenode scripts\cp_mp\anim_scene::anim_scene(actors, "ziptie_release", 1, 1, undefined, undefined, 0);
    return;
  }

  _id_B7C6214827F99D00 = scripts\cp_mp\anim_scene::anim_scene_create_actor(level.price, "price_rig", 1);
  actors = [_id_B7C6214827F99D00];
  started = _id_56ECF27761F21942.scenenode thread scripts\cp_mp\anim_scene::anim_scene(actors, "ziptie_release", 1, 1, undefined, undefined, 0);
  _id_4244F43E52B74D6D = scripts\cp_mp\anim_scene::anim_scene_create_actor(level.farah, "player_rig", 1);
  _id_EF192F97B39ACAD9 = scripts\cp_mp\anim_scene::anim_scene_create_actor(_id_E695CF3561EC7CD3, "ziptie");
  _id_CF51576178E311CB = [_id_4244F43E52B74D6D, _id_EF192F97B39ACAD9];
  started = _id_56ECF27761F21942.scenenode scripts\cp_mp\anim_scene::anim_scene(_id_CF51576178E311CB, "ziptie_release_farah", 1, 1, undefined, undefined, 0);

  if(isDefined(_id_E695CF3561EC7CD3))
    _id_E695CF3561EC7CD3 delete();
}

_id_F80F9697D6174E39() {
  if(!istrue(level._id_D5F8A16ECCBEF93F))
    give_fists();
}

_id_4B1E51634B51FC40() {
  while(isDefined(self)) {
    self waittill("trigger", player);
    player _id_F80F9697D6174E39();
    player thread _id_440C76A483A3C9F1();
    scripts\engine\utility::flag_set("captured_cell_doors_button_pressed");
    level notify("farah_stop_squad_wipe_monitor");
    self delete();

    if(isDefined(level._id_AAF382B8120C5FCB))
      level._id_AAF382B8120C5FCB enableplayeruse(player);

    setDvar("dvar_E8512E1508AFEFE8", 1);
    level.pingsystemactive = getdvarint("dvar_E8512E1508AFEFE8", 1);
    _id_6B2FC37DCDE87E20(1);
    player waittill("button_pressed_done");

    foreach(player in level.players)
    player clearadditionalstreampos((10135.7, 17635.1, -3683.48));

    _id_297B0F221B9342D6("prison_cell_door_origin_J", "prison_cell_door_script_J");
    _id_D3F451F32914C02B();
    level thread _id_18AF78602B67B70C::_id_1A477014CE8F4CE2("spawn_trigger_post_captured");
    level thread _id_18AF78602B67B70C::_id_1A477014CE8F4CE2("spawn_trigger_post_storage_captured");
    level thread _id_671CC27527998617("staircase_captured", (10977.2, 17193.4, -3811.5), "staircase_captured_door", 1);
    _id_297B0F221B9342D6("prison_cell_door_origin_I", "prison_cell_door_script_I");
    _id_297B0F221B9342D6("prison_cell_door_origin_H", "prison_cell_door_script_H");
    _id_297B0F221B9342D6("prison_cell_door_origin_G", "prison_cell_door_script_G");
    _id_297B0F221B9342D6("prison_cell_door_origin_F", "prison_cell_door_script_F");
    _id_297B0F221B9342D6("prison_cell_door_origin_E", "prison_cell_door_script_E");
    _id_297B0F221B9342D6("prison_cell_door_origin_D", "prison_cell_door_script_D");
    _id_297B0F221B9342D6("prison_cell_door_origin_C", "prison_cell_door_script_C");

    if(isDefined(level.alex))
      _id_43DE452673D0E636(level.alex);

    _id_297B0F221B9342D6("prison_cell_door_origin_B", "prison_cell_door_script_B");

    if(isDefined(level.price))
      _id_43DE452673D0E636(level.price);

    _id_297B0F221B9342D6("prison_cell_door_origin_A", "prison_cell_door_script_A");
    scripts\engine\utility::flag_set("captured_cell_doors_opened");
    return;
  }
}

_id_43DE452673D0E636(player) {
  if(isDefined(player)) {
    player give_fists();
    player scripts\cp\utility::_id_4CBAED764C116A25(0);

    if(istrue(player.enabledignoreme) || istrue(player.ignoreme))
      player scripts\cp\utility::allow_player_ignore_me(0);

    player _id_3B64EB40368C1450::_id_3633B947164BE4F3("captured_player_weapons", 1);
  }
}

give_fists() {
  scripts\cp_mp\utility\inventory_utility::_giveweapon("iw9_me_fists_mp");
  self switchtoweaponimmediate("iw9_me_fists_mp");
  self setspawnweapon("iw9_me_fists_mp", 1);
  self.lastdroppableweaponobj = makeweapon("iw9_me_fists_mp");
  _id_66122A002AFF5D57::takeweaponsdefaultfunc();
}

_id_D3F451F32914C02B() {
  if(!istrue(level._id_942F39C640EF7CDE)) {
    struct = scripts\engine\utility::getStruct("prison_console", "targetname");
    thread scripts\cp\coop_stealth::_id_C72B7181608C8607(struct.origin, 1);
    level._id_942F39C640EF7CDE = 1;
    scripts\engine\utility::flag_set("sounded_alarm");
    _id_064B6A36DE1D637F = getaiarrayinradius(struct.origin, 600);

    foreach(enemy in _id_064B6A36DE1D637F)
    enemy scripts\stealth\enemy::bt_set_stealth_state("combat", undefined);
  }
}

_id_297B0F221B9342D6(_id_5C3C95908409974F, _id_46D8A4066C8417BF) {
  _id_4E64C5CE4E348AD3 = scripts\engine\utility::getStruct(_id_5C3C95908409974F, "targetname");
  _id_4A7FFA088CD0CE86 = _id_D93E790663B230C4(_id_46D8A4066C8417BF, _id_4E64C5CE4E348AD3.origin);
  _id_4A7FFA088CD0CE86 rotateYaw(-90, 1);
  thread scripts\engine\utility::play_sound_in_space("iw9_door_metal_bars_open", _id_4E64C5CE4E348AD3.origin);
  _id_4A7FFA088CD0CE86 waittill("rotatedone");
}

_id_D93E790663B230C4(_id_4A6E62AA769AD290, origin) {
  _id_4B820972885B23D8 = getEntArray(_id_4A6E62AA769AD290, "targetname");
  tagorigin = scripts\engine\utility::spawn_tag_origin(origin);

  foreach(mesh in _id_4B820972885B23D8)
  mesh linkTo(tagorigin);

  return tagorigin;
}

_id_C3348A2B4D748336(_id_7D00CB8DD01E078C) {
  level endon("farah_killed");
  level endon("game_ended");
  _id_7D00CB8DD01E078C endon("disconnect");

  while(isDefined(self)) {
    self waittill("trigger", player);
    level notify("removedFarahBindings", player);

    if(isDefined(self.owner) && player == self.owner) {
      continue;
    }
    foreach(guy in level.players)
    self disableplayeruse(guy);

    _id_7D00CB8DD01E078C _id_F80F9697D6174E39();
    _id_7D00CB8DD01E078C _id_12E2FB553EC1605E::setcharactermodels("body_mp_farah_iw9_raid_captive", "head_mp_farah_iw9_1_2_lod1", "mp_vm_arms_farah_iw9_1_1");
    _id_F7473B71A209644E();
    game["skipFarahDeathVoting"] = 1;
    _id_7D00CB8DD01E078C clearsoundsubmix("cp_raid_farrah_captured", 1);
    _id_7D00CB8DD01E078C _id_EBBF79B971DE3F83();
    _id_7D00CB8DD01E078C _id_A7B222BF60DB70E6();
    _id_7D00CB8DD01E078C _id_3B64EB40368C1450::_id_3633B947164BE4F3("captured_player_weapons", 1);
    level._id_D8EF57E0CCA200FF delete();
  }
}

_id_7D93DFA4B3A09B27() {
  level endon("farah_killed");
  level endon("game_ended");
  level endon("dialogueAgentInvalid");
  self endon("disconnect");
  aliases = ["dx_cp_cpr4_cptr_alex_heyassholecanigetsom", "dx_cp_cpr4_cptr_alex_heyguardigotaquestio"];
  _id_D78BCBFFE40172C3 = scripts\engine\utility::create_deck(["dx_cp_cpr4_cptr_alex_whatdoyasaywejustfor", "dx_cp_cpr4_cptr_alex_gottasaythiswholecon", "dx_cp_cpr4_cptr_alex_myfriendcanigetsomet", "dx_cp_cpr4_cptr_alex_guardiheardsecurityh", "dx_cp_cpr4_cptr_alex_guardshowboutsomerus", "dx_cp_cpr4_cptr_alex_hadirtoldmeheputshis"]);
  _id_4E19B0E89937FFAB = [];
  _id_4E19B0E89937FFAB["dx_cp_cpr4_cptr_alex_heyguardigotaquestio"] = ["dx_cp_cpr4_cptr_aqs1_whatdoyouwant", level.alex, 0.5, "dx_cp_cpr4_cptr_alex_howmanyaqdoesittaket", level._id_652C062C6B740024, 0.8, "dx_cp_cpr4_cptr_aqs1_howmanyciadoesittake"];
  _id_4E19B0E89937FFAB["dx_cp_cpr4_cptr_alex_heyassholecanigetsom"] = "dx_cp_cpr4_cptr_aqs1_youareluckyyoudontge";
  _id_DE8530CCC03BDAA9 = scripts\engine\utility::create_deck(["dx_cp_cpr4_cptr_aqs1_icantwaituntilimallo", "dx_cp_cpr4_cptr_aqs1_iamgoingtoenjoykilli", "", "dx_cp_cpr4_cptr_aqs1_thisfuckingguy", "", "dx_cp_cpr4_cptr_aqs1_youtalktomuch"]);
  _id_90CB8E1F196E0CCF = 0;

  while(isDefined(self)) {
    self waittill("trigger", player);
    result = player _id_F983BE55A2B3629D(aliases, _id_4E19B0E89937FFAB, _id_DE8530CCC03BDAA9);

    if(istrue(result)) {
      if(_id_D78BCBFFE40172C3.index >= _id_D78BCBFFE40172C3.items.size)
        aliases = scripts\engine\utility::array_remove_index(aliases, result - 1);
      else
        aliases[result - 1] = _id_D78BCBFFE40172C3 scripts\engine\utility::deck_draw();
    }

    if(aliases.size == 0) {
      if(!_id_90CB8E1F196E0CCF) {
        aliases = ["dx_cp_cpr4_cptr_alex_soisthatanoonthewate"];
        _id_90CB8E1F196E0CCF = 1;
        continue;
      }

      self makeunusable();
      return;
    }
  }
}

_id_A7B222BF60DB70E6() {
  self.playerstreakspeedscale = 0;
  _id_12E2FB553EC1605E::updatemovespeedscale();
  level._id_E1008A2AFED467A7 = 0;
  self.maxhealth = 100;
  scripts\cp\cp_agent_utils::set_agent_health(100);

  if(isDefined(level._id_3E0B51E80560B991)) {
    level._id_3E0B51E80560B991 enableplayeruse(self);
    level._id_3E0B51E80560B991 = undefined;
  }

  _id_3B64EB40368C1450::_id_3633B947164BE4F3("blinded_player", 1);
}

_id_EBBF79B971DE3F83() {
  level._id_D5F8A16ECCBEF93F = 1;
  level notify("captured_completed");

  foreach(player in level.players)
  player notify("captured_completed");

  if(isDefined(level.farah)) {
    level.farah notify("clear_tutorial_messages");
    level.farah clearhudtutorialmessage();
  }

  self setModel("body_mp_farah_iw9_1_1");
  scripts\cp\cp_gameskill::_id_77E524F19EB4608F();
  self setclientomnvar("ui_blinded_player_active", 0);
  self setclientomnvar("ui_blindfolded_hud", 0);
  self setclientomnvar("ui_stop_armor_hint", 0);
  scripts\cp\utility::_id_4CBAED764C116A25(0);

  if(isDefined(level._id_4CCE949164F2212F))
    level._id_4CCE949164F2212F enableplayeruse(self);
}

_id_C64C851114EE9603(agent, hintstring, _id_016EECA103FF3D38, tagoffset, _id_A191C4DB2D8DBDD4, _id_F85DD646F4CDD407, _id_F87773A8CAABD908, _id_0288E56A5554E9EB, _id_EA9A8C2F23231171) {
  if(!isDefined(agent)) {
    return;
  }
  if(!isDefined(_id_EA9A8C2F23231171))
    _id_EA9A8C2F23231171 = "duration_short";

  if(!isDefined(_id_A191C4DB2D8DBDD4))
    _id_A191C4DB2D8DBDD4 = 200;

  if(!isDefined(_id_F85DD646F4CDD407))
    _id_A191C4DB2D8DBDD4 = 80;

  if(!isDefined(_id_F87773A8CAABD908))
    _id_A191C4DB2D8DBDD4 = 140;

  if(!isDefined(_id_0288E56A5554E9EB))
    _id_A191C4DB2D8DBDD4 = 40;

  tagorigin = scripts\engine\utility::spawn_tag_origin(agent gettagorigin(_id_016EECA103FF3D38));

  if(!isDefined(tagoffset))
    tagoffset = (0, 0, 0);

  tagorigin._id_C5D3D8FF129F88BA = scripts\cp\utility::createhintobject(tagorigin.origin, "HINT_BUTTON", undefined, hintstring, undefined, "duration_short", "show", _id_A191C4DB2D8DBDD4, _id_F85DD646F4CDD407, _id_F87773A8CAABD908, _id_0288E56A5554E9EB);
  tagorigin._id_C5D3D8FF129F88BA linkTo(agent, _id_016EECA103FF3D38, tagoffset, (0, 0, 0));

  if(isPlayer(agent))
    tagorigin._id_C5D3D8FF129F88BA disableplayeruse(agent);

  return tagorigin._id_C5D3D8FF129F88BA;
}

_id_1F0E75190E2BCDA7() {
  wait 1.5;
  _id_8BDD1937DC080CCA = scripts\engine\utility::getStructArray("laser_sentry_defuse", "script_noteworthy");
  hintobj = undefined;

  foreach(_id_FF03DED389B65A7D in _id_8BDD1937DC080CCA) {
    if(istrue(level._id_2473C417153EFC50)) {
      continue;
    }
    _id_FF03DED389B65A7D.turrets = [];
    _id_C3336162B80CD5D1 = scripts\engine\utility::getStructArray(_id_FF03DED389B65A7D.target, "targetname");
    _id_5EC17B72139BF948 = undefined;

    if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8())
      _id_5EC17B72139BF948 = 3;
    else
      _id_5EC17B72139BF948 = 8;

    foreach(_id_573F54C927E2EB98 in _id_C3336162B80CD5D1)
    _id_FF03DED389B65A7D.turrets = scripts\engine\utility::array_add(_id_FF03DED389B65A7D.turrets, _id_3AE866A6DD08DAF9::_id_9C405FFA3BB2DCF0(_id_573F54C927E2EB98, undefined, "electronics_ir_laser_device_rig_skeleton", _id_FF03DED389B65A7D, undefined, _id_5EC17B72139BF948));

    hintobj = _id_3AE866A6DD08DAF9::_id_2CC59EA2A67BD2F4(_id_FF03DED389B65A7D, _id_FF03DED389B65A7D.turrets);
    level._id_7B5771F0D3E048A0 = scripts\engine\utility::array_add(level._id_7B5771F0D3E048A0, _id_FF03DED389B65A7D);
  }

  _id_4A5D9641C457D2F6 = ["farah_western"];
  hintobj _id_D04B95CD171249A6(_id_4A5D9641C457D2F6);
  level._id_4CCE949164F2212F = hintobj;
  level._id_2473C417153EFC50 = 1;
}

_id_1D2519F2DBCBE8FF(_id_34FB06C037BE3746) {
  level endon("farah_killed");
  level endon("game_ended");
  level endon("dialogueAgentInvalid");
  level waittill(_id_34FB06C037BE3746);
  wait 5;
  enemies = getaiarray();

  foreach(enemy in enemies) {
    if(enemy.enemy_group == _id_34FB06C037BE3746)
      enemy scripts\cp\cp_agent_utils::set_agent_health(1);
  }
}

_id_4A2C25B7AE36FBBE(_id_F8E5E3AA5762A8E7) {
  level._id_0029C8AE4A2C2B71 = self;
  _id_BFA89CE8148C4E4B();
}

_id_837865939E864EA9(_id_F8E5E3AA5762A8E7) {
  level._id_388D985C5B239914 = self;
  _id_BFA89CE8148C4E4B();
  attachments = _func_6527364C1ECCA6C6("iw9_ar_akilo74_mp");
  objweapon = makeweapon("iw9_ar_akilo74_mp", attachments);
  scripts\cp\utility::_giveweapon(objweapon);
  self setspawnweapon(objweapon);
}

_id_BFA89CE8148C4E4B() {
  self.ignoreall = 1;
  self.invulnerable = 1;
  self.dont_enter_combat = 1;
  self.animationarchetype = "soldier";
  self.nocorpse = 1;
  self.diequietly = 1;
  self._id_D0E9753B09126417 = undefined;
  self._id_AD799295A6692B29 = 1;
  take_ai_weapon();
  self animmode("noclip");
  self dontinterpolate();
}

take_ai_weapon() {
  self.old_weapon = self.weapon;
  self.anim_weapon = _id_2669878CF5A1B6BC::buildweapon("iw9_me_fists_mp", [], "none", "none", -1);
  self giveweapon(self.anim_weapon);
  self takeweapon(self.old_weapon);
  self setspawnweapon(self.anim_weapon);
}

_id_6D4C7946D9FFB194() {
  level endon("game_ended");

  while(!isDefined(level.farah))
    wait 0.1;

  level.farah scripts\engine\utility::ent_flag_wait("intro_binks_complete");
}

_id_EBB1AE1A8070AF00() {
  level endon("game_ended");

  if(getdvarint("dvar_AEF2860A5102FA52", 0) == 0)
    _id_6D4C7946D9FFB194();

  thread _id_18A73A64992DD07D::registerambientgroup("hadir_spawn_captured", 1, 1, 1, undefined, undefined, "hadir_spawn_captured", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("hadir_spawn_captured", ::_id_4A2C25B7AE36FBBE);
  _id_18A73A64992DD07D::run_spawn_module("hadir_spawn_captured");
  thread _id_18A73A64992DD07D::registerambientgroup("guard_spawn_captured", 1, 1, 1, undefined, undefined, "guard_spawn_captured", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("guard_spawn_captured", ::_id_837865939E864EA9);
  _id_18A73A64992DD07D::run_spawn_module("guard_spawn_captured");
  scripts\engine\utility::flag_set("hadir_guard_intro_spawn_complete");
}

_id_08796B255F69304A() {
  level endon("game_ended");

  if(istrue(game["enable_farah_chair_animation"]))
    thread _id_EBB1AE1A8070AF00();

  scripts\engine\utility::flag_wait("both_players_intro_binks_complete");
  _id_18A73A64992DD07D::registerambientgroup("prison_cell_guard", 2, 2, 2, 0.05, undefined, "prison_cell_guard", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("prison_cell_guard", ::setup_soldier_stealth);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("prison_cell_guard");
  _id_18A73A64992DD07D::run_spawn_module("prison_cell_guard");
  thread _id_1D2519F2DBCBE8FF("prison_cell_guard");
  checkpoint = scripts\cp\cp_checkpoint::_id_9EED75023A958C18();

  if(isDefined(checkpoint) && checkpoint != "") {
    switch (checkpoint) {
      case "checkpoint_captured_blind":
        thread _id_A0622892B7819C9E();
        return;
      case "checkpoint_rescue_warehouse":
        return;
    }
  } else {
    start = getDvar("start");

    if(start == "captured" || start == "")
      thread _id_A0622892B7819C9E();
  }
}

_id_A0622892B7819C9E() {
  _id_18A73A64992DD07D::registerambientgroup("prison_cell_guard_captured_only", 1, 1, 1, 0.05, undefined, "prison_cell_guard_captured_only", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("prison_cell_guard_captured_only", ::setup_soldier_stealth);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("prison_cell_guard_captured_only");
  _id_18A73A64992DD07D::run_spawn_module("prison_cell_guard_captured_only");
  level thread _id_A8C19D426D7FD684("prison_cell_guard_captured_only");
  level thread _id_18AF78602B67B70C::_id_1A477014CE8F4CE2("spawn_trigger_captured");
  level thread _id_671CC27527998617("captured_lurker", (11092.7, 17426.9, -3811.5), "captured_lurker_door", undefined, 1);
}

_id_A8C19D426D7FD684(targetname) {
  level endon("game_ended");
  level endon("farah_killed");
  level endon("dialogueAgentInvalid");
  wait 15;
  agents = getaiarray("axis");
  _id_799996F78AF659DD = undefined;

  foreach(agent in agents) {
    if(agent.enemy_group == targetname)
      _id_799996F78AF659DD = agent;
  }

  if(!isDefined(_id_799996F78AF659DD)) {
    return;
  }
  _id_799996F78AF659DD endon("death");
  level._id_652C062C6B740024 = _id_799996F78AF659DD;
  level._id_652C062C6B740024 scripts\cp\cp_agent_utils::set_agent_health(1);
  _id_C2E3019A928E9503 = &"CP_RAID_COMPLEX_JUGG_MAZE/TALK_TO_GUARD";
  _id_93EAE9069867C28F = _id_C64C851114EE9603(_id_799996F78AF659DD, _id_C2E3019A928E9503, "j_spineupper", (10, -5, 0), 200, 100, 80, 70);
  _id_93EAE9069867C28F thread _id_7D93DFA4B3A09B27();
  _id_4A5D9641C457D2F6 = ["price_western", "farah_western"];
  _id_93EAE9069867C28F _id_D04B95CD171249A6(_id_4A5D9641C457D2F6);
  _id_93EAE9069867C28F thread _id_66DB593B28DDA96F();
  level thread _id_D0D638F4EE0C5F55(_id_799996F78AF659DD);
  _id_93EAE9069867C28F thread _id_0E08FBAD561B2729(level._id_652C062C6B740024);
}

_id_66DB593B28DDA96F() {
  level endon("game_ended");
  level endon("farah_killed");

  if(isDefined(level.alex))
    level.alex endon("death_or_disconnect");

  while(isDefined(self)) {
    if(istrue(level._id_C5BD05483E55285F)) {
      if(isDefined(level.alex))
        self disableplayeruse(level.alex);
    } else if(isDefined(level.alex))
      self enableplayeruse(level.alex);

    wait 0.01;
  }
}

_id_0E08FBAD561B2729(agent) {
  level endon("game_ended");

  while(!scripts\engine\utility::is_dead_or_dying(agent) && agent _id_35DE402EFC5ACFB3::_id_16DCE705F14F4B84() != "combat")
    wait 0.1;

  level notify("dialogueAgentInvalid");
  self delete();
}

_id_D04B95CD171249A6(_id_86F1B581281ED0D3) {
  foreach(player in level.players) {
    if(isDefined(player.pers["operator_override"])) {
      foreach(_id_48232C7BE8E19692 in _id_86F1B581281ED0D3) {
        if(player.pers["operator_override"].name == _id_48232C7BE8E19692)
          self disableplayeruse(player);
      }
    }
  }
}

_id_671CC27527998617(_id_34FB06C037BE3746, origin, _id_8958D713D28E4249, _id_49871D7485FEF42B, _id_BF8C2B2133575AB7) {
  level endon("game_ended");
  level waittill(_id_34FB06C037BE3746);

  if(istrue(_id_BF8C2B2133575AB7)) {
    _id_E8D51BF2E0FD9BF4 = scripts\engine\utility::getStruct("lurker_kill_farah_goal", "script_noteworthy");

    if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8())
      _id_E8D51BF2E0FD9BF4.target = "hard_mode_patrol";
    else
      _id_E8D51BF2E0FD9BF4.target = "normal_mode_patrol";
  }

  _id_E84BF64AF696D687 = getentitylessscriptablearray("scriptable_scriptable_door_industrial_metal_mp_01", "classname", origin, 20);

  foreach(door in _id_E84BF64AF696D687) {
    if(isDefined(door.script_noteworthy) && door.script_noteworthy == _id_8958D713D28E4249) {
      _id_531C536DCD04E20F::_id_B092780F9EC4496E(door);
      wait 6;
      door _id_18AF78602B67B70C::_id_887438C3B4B194B6(1, undefined, 5);
      wait 0.5;
      _id_531C536DCD04E20F::_id_FBBFE6F05EDA5EB1(door);

      if(!istrue(_id_49871D7485FEF42B)) {
        foreach(player in level.players)
        door disablescriptableplayeruse(player);
      }
    }
  }

  level thread _id_7800C88A83C180E5(_id_34FB06C037BE3746);
}

setup_soldier_stealth(group_name, func) {
  if(getdvarint("dvar_DCF5FCEDE3345FB8", 0) != 0)
    self.ignoreall = 1;

  self _meth_95D5375059C2A022("cp_jugg_maze_stealth_section");
  self _meth_D493E7FE15E5EAF4("cp_jugg_maze_stealth_section");
  thread scripts\cp\coop_stealth::run_common_functions(self, 1, 1, 60, 160000);
  scripts\stealth\utility::set_stealth_func("event_investigate", _id_242A2441CBD54AF1::_id_F161C068112045E3);
  scripts\stealth\utility::set_stealth_func("event_cover_blown", ::_id_8CCC1B017CF2310B);
  scripts\stealth\utility::set_stealth_func("event_combat", ::_id_8CCC1B017CF2310B);
  level notify(group_name.group_name);
  scripts\cp\cp_agent_utils::set_agent_health(1);
}

_id_8CCC1B017CF2310B(event) {
  scripts\stealth\enemy::bt_set_stealth_state("combat", undefined);

  if(isDefined(level.farah))
    self setgoalpos(level.farah.origin, 5);
}

_id_5A13959F7AF9E427() {
  _id_9E4E1482CB40C9C5 = scripts\engine\utility::getStructArray("rock_spawn", "targetname");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_9E4E1482CB40C9C5.size; _id_AC0E594AC96AA3A8++) {
    _id_06FE80416B4BE165 = _id_66122A002AFF5D57::getitemdropinfo(_id_9E4E1482CB40C9C5[_id_AC0E594AC96AA3A8].origin, _id_9E4E1482CB40C9C5[_id_AC0E594AC96AA3A8].angles);
    _id_32E00752C95AAD17 = "brloot_rock";
    item = _id_66122A002AFF5D57::spawnpickup(_id_32E00752C95AAD17, _id_06FE80416B4BE165, undefined, undefined, undefined, 0);
  }

  _id_E7DF3BF5AE539CF0 = scripts\engine\utility::getStructArray("knife_spawn", "targetname");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_E7DF3BF5AE539CF0.size; _id_AC0E594AC96AA3A8++) {
    _id_06FE80416B4BE165 = _id_66122A002AFF5D57::getitemdropinfo(_id_E7DF3BF5AE539CF0[_id_AC0E594AC96AA3A8].origin, _id_E7DF3BF5AE539CF0[_id_AC0E594AC96AA3A8].angles);
    _id_32E00752C95AAD17 = "brloot_weapon_me_knife_comm";
    item = _id_66122A002AFF5D57::spawnpickup(_id_32E00752C95AAD17, _id_06FE80416B4BE165, 1, undefined, undefined, 0, undefined, 1);
  }
}

_id_279964C2C969DDA3() {}

_id_861DCC9779702ADB() {
  scripts\engine\utility::ent_flag_wait("intro_binks_complete");
  thread _id_D78368E4F9DBAAF2();
  onplayerspawned();
}

_id_D78368E4F9DBAAF2() {
  waitframe();
  _id_5E5507D57BBBB709::_id_79CD95DA38030C14();
  _id_66122A002AFF5D57::takeweaponsdefaultfunc("iw9_gunless_fists");
  self setspawnweapon("iw9_gunless_fists", 1);
  self.lastdroppableweaponobj = makeweapon("iw9_gunless_fists");
  _id_7EF95BBA57DC4B82::takeequipment("primary");
  _id_7EF95BBA57DC4B82::takeequipment("secondary");
}

_id_8663ADB0F4B58DEF() {
  struct = scripts\engine\utility::getStruct("prison_console", "targetname");
  hintstring = &"CP_RAID_COMPLEX_JUGG_MAZE/UNLOCK_PRISON_DOORS";
  button = undefined;

  if(isDefined(struct))
    button = scripts\cp\utility::createhintobject(struct.origin, "HINT_BUTTON", "cp_crate_icon_lethalrefill", hintstring, undefined, "duration_short", "show");

  return button;
}

_id_293D38BA5ADE4FA6() {
  if(!isDefined(level._id_B6217B906C6BE73E))
    level._id_B6217B906C6BE73E = [];

  if(isstartstr(self._id_DC196D396886FB97.name, "price")) {
    level.price = self;
    level._id_B6217B906C6BE73E["price"] = self;
    self._id_938E8B2CA6549759 = "price";
  } else if(isstartstr(self._id_DC196D396886FB97.name, "farah")) {
    level.farah = self;
    level._id_B6217B906C6BE73E["farah"] = self;
    self._id_938E8B2CA6549759 = "farah";
  } else {
    level.alex = self;
    level._id_B6217B906C6BE73E["alex"] = self;
    self._id_938E8B2CA6549759 = "alex";
  }
}

_id_3861EB0A004E0D38() {
  level.objectivesfunc = ::_id_C2A86F682BF1AB71;
  level thread scripts\cp\cp_objectives::objectives_init();
}

_id_FF8BC388141AC38D(_id_6D7218F0D1450A35) {
  level thread _id_5EA56F8291461E60();
  scripts\cp\cp_gameskill::_id_0127B010126B6A90();

  if(istrue(_id_6D7218F0D1450A35)) {
    level._id_D5F8A16ECCBEF93F = 1;
    return;
  }

  setDvar("dvar_E8512E1508AFEFE8", 0);
  level.pingsystemactive = getdvarint("dvar_E8512E1508AFEFE8", 0);
}

_id_C4D555BF9485AC3B() {
  level thread _id_FC4803DC319A81D2();
  _id_04BFCED04A831CD7::_id_B04F37F19C6631E0();
  _id_3AE866A6DD08DAF9::_id_E7A64DF827074B05();
  checkpoint = scripts\cp\cp_checkpoint::_id_9EED75023A958C18();

  if(isDefined(checkpoint) && (checkpoint == "" || checkpoint == "checkpoint_captured_blind"))
    _id_FF8BC388141AC38D();
  else if(checkpoint == "checkpoint_rescue_warehouse")
    _id_FF8BC388141AC38D(1);
  else {
    start = getDvar("start");

    if(start == "captured" || start == "")
      _id_FF8BC388141AC38D();
  }
}

_id_5EA56F8291461E60() {
  level endon("game_ended");
  level notify("farah_squad_wipe");
  level endon("farah_squad_wipe");
  level endon("farah_stop_squad_wipe_monitor");
  scripts\engine\utility::flag_wait("both_players_intro_binks_complete");

  for(;;) {
    if(!isDefined(level.farah)) {
      wait 1;
      continue;
    }

    _id_0EF06FFED30DF7AD = 0;
    _id_92FEFF32D875F80A = undefined;

    if(!scripts\cp\cp_gameskill::_id_DC6FD5E481FA370A(level.farah))
      _id_0EF06FFED30DF7AD = 1;

    if(istrue(_id_0EF06FFED30DF7AD)) {
      level.farah notify("clear_tutorial_messages");
      level.farah clearhudtutorialmessage();
      _id_5A67C9D0186C1589 = &"COOP_GAME_PLAY/WIPE_FROM_FARAH_DEATH";
      scripts\cp\cp_hud_message::teamhudtutorialmessage(_id_5A67C9D0186C1589, "allies", 2);

      if(!istrue(game["skipFarahDeathVoting"])) {
        level.farah childthread _id_4A8490BC4033053C();
        level scripts\engine\utility::waittill_any_timeout_1(11, "end_farah_swap_vote");
      }

      foreach(player in level.players) {
        player notify("clear_tutorial_messages");
        player clearhudtutorialmessage();
      }

      level notify("stop_party_wipe_monitor");
      _id_5A67C9D0186C1589 = &"CP_RAID_COMPLEX_JUGG_MAZE/FARAH_KILLED";
      level thread[[level.endgame]]("axis", level.end_game_string_index["farah_killed"]);
      level notify("farah_squad_wipe");
    }

    wait 1;
  }
}

_id_FDB2DA2BBFBC5878(player, _id_C92399F05F63EB2C) {
  if(isDefined(player)) {
    player notify("clear_tutorial_messages");
    player clearhudtutorialmessage();
    wait 1;

    if(!istrue(_id_C92399F05F63EB2C))
      player thread scripts\cp\cp_hud_message::tutorialprint(&"COOP_GAME_PLAY/FARAH_IS_VOTING", 11);
  }
}

_id_4A8490BC4033053C() {
  level endon("game_ended");
  level.farah endon("disconnect");
  level notify("farah_killed");

  foreach(guy in level.players)
  guy notify("farah_killed");

  _id_FDB2DA2BBFBC5878(level.farah, 1);

  if(isDefined(level.farah.reviveent))
    level.farah.reviveent makeunusable();

  level.farah notifyonplayercommand("swapPlayer", "+usereload");
  level.farah notifyonplayercommand("swapPlayer", "+activate");
  level.farah notifyonplayercommand("skipSwap", "+weapnext");
  level.farah thread scripts\cp\cp_hud_message::tutorialprint(&"COOP_GAME_PLAY/SWAP_BLINDED_OPERATOR", 11);
  level.farah _id_3B64EB40368C1450::_id_3633B947164BE4F3("voteSwap", 0);
  level.farah scripts\cp\utility::freezecontrolswrapper(1);
  thread _id_FDB2DA2BBFBC5878(level.alex);
  thread _id_FDB2DA2BBFBC5878(level.price);
  _id_C7847202BA2808C5 = 0;

  for(_id_76463E06945B7B63 = 1; _id_C7847202BA2808C5 < _id_76463E06945B7B63; _id_C7847202BA2808C5++) {
    result = level.farah scripts\engine\utility::waittill_any_return_2("swapPlayer", "skipSwap");
    level.farah playlocalsound("weap_ammo_pickup");

    switch (result) {
      case "swapPlayer":
        level.farah _id_D458C201516B94E5();
        break;
      case "skipSwap":
        break;
    }
  }

  level.farah scripts\cp\utility::freezecontrolswrapper(0);
  level.farah _id_3B64EB40368C1450::_id_588F2307A3040610("voteSwap");
  level.farah notifyonplayercommandremove("swapPlayer", "+usereload");
  level.farah notifyonplayercommandremove("swapPlayer", "+activate");
  level.farah notifyonplayercommandremove("skipSwap", "-smoke");
  level notify("end_farah_swap_vote");
}

_id_D458C201516B94E5() {
  foreach(player in level.players) {
    if(player.pers["operator_override"].name == "price_western") {
      player.pers["operator_override"].name = "alex_western";
      continue;
    }

    if(player.pers["operator_override"].name == "alex_western") {
      player.pers["operator_override"].name = "farah_western";

      if(getdvarint("dvar_8605C689D46957F4", 1))
        player setclientomnvar("ui_blinded_player_active", 1);
    }
  }

  self.pers["operator_override"].name = "price_western";
}

_id_FC4803DC319A81D2() {
  level thread wait_for_pre_game_period();
  level thread wait_for_strike_init_complete();
}

wait_for_pre_game_period() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("bsp_structs_initialized");
  scripts\engine\utility::flag_wait("level_ready_for_script");
}

wait_for_strike_init_complete() {
  level endon("game_ended");

  if(scripts\engine\utility::flag_exist("strike_init_done"))
    scripts\engine\utility::flag_wait("strike_init_done");
}

_id_AEACA15C955FE85C() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("bsp_structs_initialized");
  scripts\engine\utility::flag_wait("level_ready_for_script");
  _id_71717E6C4597A196::_id_15FE9620D04DBB58();
  _id_71717E6C4597A196::_id_23417F0A11657091("cctv_interact_1", "stop_cctv", 350, 193, 40, 20, "duration_medium", 1, 1, 1, "farah_killed", "captured_completed", "alex_cctv_break", "cp_capture_jugg_cctv", &"CP_CCTV/LOOK");
  _id_71717E6C4597A196::_id_23417F0A11657091("cctv_interact_7", "stop_cctv", 350, 193, 40, 20, "duration_medium", 1, 1, 1, "farah_killed", "captured_completed", "alex_cctv_break", "cp_capture_jugg_cctv", &"CP_CCTV/LOOK");
  scripts\engine\utility::flag_wait("cp_capture_jugg_create_script_completed");
  _id_5A13959F7AF9E427();
  _id_3E0B51E80560B991 = _id_8663ADB0F4B58DEF();
  _id_3E0B51E80560B991 thread _id_4B1E51634B51FC40();
  _id_3E0B51E80560B991 thread _id_89D62390197311E5(level.farah, "captured_completed");
  level._id_3E0B51E80560B991 = _id_3E0B51E80560B991;

  if(getdvarint("dvar_C94F136A78C157C9", 1)) {
    if(isDefined(level._id_3E0B51E80560B991) && isDefined(level.farah))
      level._id_3E0B51E80560B991 disableplayeruse(level.farah);
  }

  if(!isDefined(level._id_7B5771F0D3E048A0))
    level._id_7B5771F0D3E048A0 = [];

  thread _id_1F0E75190E2BCDA7();
  _id_399051FB52552B8B();
  _id_A4E090337ABC55F0();
  thread _id_08796B255F69304A();
  _id_286309E603CB4179 = scripts\engine\utility::getStruct("sound_water_drops", "script_noteworthy");
  scripts\engine\utility::play_loopsound_in_space("emt_cp_jugg_water_drip_captured", _id_286309E603CB4179.origin);
  _id_518EA962BDEF9C10 = scripts\engine\utility::getStruct("vfx_water_drops_2", "targetname");
  _id_8BBBD1CCBBF901A5 = scripts\engine\utility::getStruct("vfx_water_puddle", "targetname");
  _id_470FFC41649E7F15 = scripts\engine\utility::getStruct("vfx_water_puddle_2", "targetname");
  playFX(level._effect["vfx_br_water_drips_line_1"], _id_518EA962BDEF9C10.origin);
  playFX(level._effect["vfx_br_water_drips_line_1"], _id_518EA962BDEF9C10.origin + (1, 1, 1));
  playFX(level._effect["vfx_br_pipe_water_mist"], (11107, 17127.6, -3507.96));
  playFX(level._effect["vfx_border_water_puddle"], _id_8BBBD1CCBBF901A5.origin);
  playFX(level._effect["vfx_border_water_puddle"], _id_470FFC41649E7F15.origin);
  wait 1;
  _id_F42869166D50FBE9 = scripts\cp\cp_checkpoint::_id_9EED75023A958C18();

  if(!isDefined(_id_F42869166D50FBE9) || _id_F42869166D50FBE9 == "")
    _id_F42869166D50FBE9 = getDvar("start");

  if(_id_F42869166D50FBE9 == "checkpoint_rescue_warehouse" || _id_F42869166D50FBE9 == "checkpoint_stealth_section" || !istrue(game["enable_farah_chair_animation"])) {
    _id_448F3F72810BBA0B = getEnt("captured_chair", "targetname");

    if(isDefined(_id_448F3F72810BBA0B))
      _id_448F3F72810BBA0B delete();
  }

  _id_358DF38FEA122097 = scripts\engine\utility::getStruct("seq_captured_exit_door", "script_noteworthy").origin;
  entities = getentarrayinradius(undefined, undefined, _id_358DF38FEA122097, 5);
  level._id_AAF382B8120C5FCB = entities[0];
  _id_6B2FC37DCDE87E20(0, _id_358DF38FEA122097, "scriptable_scriptable_construction_doors_metal_b_02_mp_blue");
  _id_6B2FC37DCDE87E20(0);
  level._id_D6BA25E54AFE7E5E = scripts\engine\utility::getStruct("dialogue_pause_node", "script_noteworthy");
  level._id_C0E5BB83FE3A79E5 = scripts\engine\utility::getStruct("not_dialogue_pause_node", "script_noteworthy");
}

_id_399051FB52552B8B() {
  _id_5C8BED8083C95381 = scripts\engine\utility::getStructArray("weapon_spawn", "targetname");

  foreach(struct in _id_5C8BED8083C95381) {
    _id_6CC2126273AA22B3 = undefined;
    _id_E27137570124CFCB = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4(struct.script_noteworthy);

    switch (struct.script_noteworthy) {
      case "iw9_pi_golf17_mp":
        _id_6CC2126273AA22B3 = ["silencer", "reddot"];
        break;
      case "iw9_pi_decho_mp":
        _id_6CC2126273AA22B3 = ["silencer", "reddot"];
        break;
    }

    if(isDefined(_id_6CC2126273AA22B3))
      _id_E27137570124CFCB = _id_E27137570124CFCB _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(_id_6CC2126273AA22B3);

    struct _id_9655BF427A5ABDB8(_id_E27137570124CFCB);
  }
}

_id_9655BF427A5ABDB8(objweapon) {
  sweapon = getcompleteweaponname(objweapon);
  _id_B8F5AC23CE0DFDE3 = spawn("weapon_" + sweapon, self.origin, 17);
  _id_B8F5AC23CE0DFDE3.angles = self.angles;
  _id_AEC66C8D309A2AFA = 0;
  _id_5D9B5B689A1846C8 = undefined;

  if(istrue(objweapon.hasalternate)) {
    _id_5D9B5B689A1846C8 = objweapon getaltweapon();
    _id_AEC66C8D309A2AFA = weaponclipsize(_id_5D9B5B689A1846C8);
    _id_B8F5AC23CE0DFDE3 itemweaponsetammo(1, 0, 1, 1);
  } else
    _id_B8F5AC23CE0DFDE3 itemweaponsetammo(1, 0, 1, 1);

  _id_B8F5AC23CE0DFDE3 thread _id_74502A9E0EF1F19C::watchweaponpickup(1, 0);
  return _id_B8F5AC23CE0DFDE3;
}

_id_A4E090337ABC55F0() {
  _id_B1D92C23A9308CD2 = getEntArray("warehouse_laser_box_variant_A", "script_noteworthy");

  if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8()) {
    foreach(box in _id_B1D92C23A9308CD2)
    box delete();

    return;
  }

  _id_9FD8FD3AD5A2D040 = getEntArray("hard_mode_box", "script_noteworthy");

  foreach(box in _id_9FD8FD3AD5A2D040)
  box delete();
}

_id_6B2FC37DCDE87E20(usable, _id_F9CBFF5134DA960B, _id_D666F1E62CE8DFAD) {
  if(!isDefined(_id_F9CBFF5134DA960B))
    _id_F9CBFF5134DA960B = (10836, 17130, -3555);

  if(!isDefined(_id_D666F1E62CE8DFAD))
    _id_D666F1E62CE8DFAD = "scriptable_scriptable_door_industrial_metal_mp_01";

  _id_E84BF64AF696D687 = getentitylessscriptablearray(_id_D666F1E62CE8DFAD, "classname", _id_F9CBFF5134DA960B, 1000);

  foreach(door in _id_E84BF64AF696D687) {
    _id_531C536DCD04E20F::_id_FBBFE6F05EDA5EB1(door);

    foreach(player in level.players) {
      if(istrue(usable)) {
        door enablescriptableplayeruse(player);
        continue;
      }

      door disablescriptableplayeruse(player);
    }
  }
}

_id_D0D638F4EE0C5F55(_id_799996F78AF659DD) {
  level endon("game_ended");
  level endon("farah_killed");
  level endon("captured_completed");
  level endon("dialogueAgentInvalid");
  trigger = getEnt("farah_nearby", "targetname");
  _id_21FDC35FFF10C2D0 = undefined;

  if(isDefined(trigger))
    _id_21FDC35FFF10C2D0 = trigger;

  _id_21FDC35FFF10C2D0 waittill("trigger");
  scripts\engine\utility::flag_set("farah_nearby");

  if(isDefined(level.alex))
    level.alex notify("alex_cctv_break");

  id = level._id_652C062C6B740024 _meth_92435C7A6AE85C3C();

  if(isDefined(id)) {
    _func_AE368FAD1A1DC337(id, "state", "end");
    level._id_652C062C6B740024 _meth_EA63241A4D3092C4();
  }

  level._id_652C062C6B740024 setgoalpos(level._id_D6BA25E54AFE7E5E.origin);
  level._id_C5BD05483E55285F = 1;

  if(isalive(level.alex) && isDefined(level.alex._id_74CD7962F11BE6A8)) {
    level._id_652C062C6B740024 thread _id_5D265B4FCA61F070::_id_88357F565D1BADF5(1, "dx_cp_cpr4_cptr_aqs1_whatyouarelookingat");
    level._id_652C062C6B740024 _id_5D265B4FCA61F070::_id_88357F565D1BADF5(0.2, "dx_cp_cpr4_cptr_aqs1_getthefuckback");
  }

  thread _id_C7614E7BF6FDA893();

  if(isDefined(level.alex))
    level.alex _id_B817EB235F57A1F4();

  level._id_C5BD05483E55285F = 0;
}

_id_7800C88A83C180E5(targetname) {
  level endon("game_ended");
  level endon("farah_killed");
  level endon("captured_completed");
  agents = getaiarray("axis");
  _id_799996F78AF659DD = undefined;

  foreach(agent in agents) {
    if(agent.enemy_group == targetname)
      _id_799996F78AF659DD = agent;
  }

  _id_799996F78AF659DD endon("death");
  triggers = getEntArray("trigger_rotatable_radius", "classname");
  level._id_371EBD16F964BAE2 = undefined;

  foreach(trigger in triggers) {
    if(!isDefined(trigger.targetname)) {
      continue;
    }
    if(trigger.targetname == "farah_fell")
      level._id_371EBD16F964BAE2 = trigger;
  }

  level._id_371EBD16F964BAE2 waittill("trigger", agent);

  if(!isPlayer(agent)) {
    level thread _id_7800C88A83C180E5("captured_lurker");
    return;
  }

  scripts\engine\utility::flag_set("farah_fell");
  _id_799996F78AF659DD thread _id_49A93E8097DE5C11();
}

_id_49A93E8097DE5C11() {
  _id_E8D51BF2E0FD9BF4 = scripts\engine\utility::getStruct("lurker_kill_farah_goal", "script_noteworthy");
  scripts\stealth\enemy::bt_set_stealth_state("combat", undefined);
  self setgoalpos(_id_E8D51BF2E0FD9BF4.origin);
}

_id_C7614E7BF6FDA893() {
  level endon("farah_killed");
  level endon("captured_completed");
  level._id_15E258DE13533615 = level._id_D6BA25E54AFE7E5E;

  while(isDefined(level._id_652C062C6B740024) && isalive(level._id_652C062C6B740024)) {
    if(istrue(level._id_C5BD05483E55285F)) {
      wait 0.1;
      continue;
    }

    wait 3;

    if(istrue(level._id_C5BD05483E55285F)) {
      wait 0.1;
      continue;
    }

    wait 3;

    if(istrue(level._id_C5BD05483E55285F)) {
      wait 0.1;
      continue;
    }

    wait 2;

    if(istrue(level._id_C5BD05483E55285F)) {
      wait 0.1;
      continue;
    }

    wait 1;

    if(istrue(level._id_C5BD05483E55285F)) {
      wait 0.1;
      continue;
    }

    if(level._id_15E258DE13533615 == level._id_C0E5BB83FE3A79E5)
      level._id_15E258DE13533615 = level._id_D6BA25E54AFE7E5E;
    else
      level._id_15E258DE13533615 = level._id_C0E5BB83FE3A79E5;

    level._id_652C062C6B740024 setgoalpos(level._id_15E258DE13533615.origin);
    wait 0.1;
  }
}

_id_C2A86F682BF1AB71() {
  level.objectives_table = "cp/cp_capture_jugg_objectives.csv";
  level.objectivesmatrixtable = "cp/cp_capture_jugg_objectives_matrix.csv";
  level.objectiveregistration = ::_id_77765E5DD4C9DB54;
  scripts\cp\cp_objectives::parseobjectivestable(level.objectives_table);
}

_id_77765E5DD4C9DB54() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("level_ready_for_script");
  scripts\engine\utility::flag_wait("objective_table_parsed");
}

_id_D525F1534752BFC7() {
  setDvar("sm_sunSampleSizeNear", 1.25);
  setDvar("r_umbraMinObjectContribution", 4);
  setDvar("r_umbraAccurateOcclusionThreshold", 2048);
  setDvar("sm_roundRobinPrioritySpotShadows", 8);
  setDvar("sm_spotUpdateLimit", 8);
  scripts\engine\utility::flag_set("infil_complete");
}