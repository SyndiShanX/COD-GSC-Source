/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_7cfb984d8451dc2a.gsc
***********************************************/

init() {
  level.infilstruct._id_B381E33E977DA440 = ::_id_55F2480B4B819AEA;
  level.infilstruct._id_AE9E4023110ACC6E = ::_id_AD4A7A73C7D7D9E0;
  level.infilstruct._id_477BD548940C3A78 = "mp_donetsk_c130_intro";
  level.infilstruct._id_10D27B439AF13A2A = 3.2;
  _id_1809E16510055E87 = ["cam_orbit_br_ac130_player1", "cam_orbit_br_ac130_player2", "cam_orbit_br_ac130_player3", "cam_orbit_br_ac130_player4"];
  _id_0930A1E7BD882C1D::_id_226E337633A44059(_id_1809E16510055E87);
  _id_0930A1E7BD882C1D::_id_AD12D29D41483E8A("prematch", ::_id_CD7E1A37D5E2CA2B);
  _id_0930A1E7BD882C1D::_id_AD12D29D41483E8A("cinematic", ::_id_5901CD0BE722F86A);
  _id_0930A1E7BD882C1D::_id_AD12D29D41483E8A("animatic", ::_id_39C2CF6576478D41);
  level._effect["vfx_br_ac130_clouds"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_ac130_clouds");
  level._effect["vfx_br_infil_cloud_anim"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_cloud_anim");
}

_id_55F2480B4B819AEA(movingc130) {
  animstruct = spawnStruct();
  animstruct.origin = getdvarvector("br_infil_anim_pos", (0, 0, 0));
  animstruct.angles = (0, 0, 0);
  animstruct.cleanupfunc = ::_id_72145194F4F38714;
  animstruct._id_AB8494260B910B51 = ::_id_52BEDAE2CED8E191;
  animstruct.movingc130 = movingc130;
  animstruct.staticc130 = getEnt("infil_plane", "script_noteworthy");

  if(isDefined(animstruct.staticc130)) {
    animstruct.staticc130 show();
    animstruct.staticc130.animname = "c130";
  } else
    animstruct.staticc130 = animstruct _id_0930A1E7BD882C1D::spawn_script_model("veh8_mil_air_acharlie130_magma_animated", "c130");

  if(isDefined(animstruct.movingc130)) {
    animstruct.movingc130.animname = "movingC130";
    animstruct.movingc130.innards.animname = "movingC130";
    animstruct.movingc130 = animstruct;
  }

  animstruct.camera = animstruct _id_0930A1E7BD882C1D::spawn_script_model("generic_prop_x5", "camera");
  animstruct.camera linkTo(animstruct.staticc130, "", (0, 0, 0), (0, 0, 0));

  if(isDefined(animstruct.movingc130)) {
    animstruct._id_96FE3313D1BAB862 = animstruct _id_0930A1E7BD882C1D::spawn_script_model("generic_prop_x5", "cameramoving");
    animstruct._id_96FE3313D1BAB862 linkTo(animstruct.movingc130, "", (0, 0, 0), (0, 0, 0));
  }

  animstruct._id_16CFD3CBF327FEEF = animstruct _id_0930A1E7BD882C1D::spawn_script_model("generic_prop_x5", "parent");
  animstruct._id_16CFD3CBF327FEEF linkTo(animstruct.staticc130, "", (0, 0, 0), (0, 0, 0));
  animstruct._id_0B50860E78D9E1E5 = [];
  animstruct._id_0B50860E78D9E1E5[0] = animstruct _id_0930A1E7BD882C1D::spawn_script_model("tag_player", "playerTag1");
  animstruct._id_0B50860E78D9E1E5[1] = animstruct _id_0930A1E7BD882C1D::spawn_script_model("tag_player", "playerTag2");
  animstruct._id_0B50860E78D9E1E5[2] = animstruct _id_0930A1E7BD882C1D::spawn_script_model("tag_player", "playerTag3");
  animstruct._id_0B50860E78D9E1E5[3] = animstruct _id_0930A1E7BD882C1D::spawn_script_model("tag_player", "playerTag4");
  animstruct._id_0B50860E78D9E1E5[0] linkTo(animstruct._id_16CFD3CBF327FEEF, "j_prop_1", (0, 0, 0), (0, 0, 0));
  animstruct._id_0B50860E78D9E1E5[1] linkTo(animstruct._id_16CFD3CBF327FEEF, "j_prop_2", (0, 0, 0), (0, 0, 0));
  animstruct._id_0B50860E78D9E1E5[2] linkTo(animstruct._id_16CFD3CBF327FEEF, "j_prop_3", (0, 0, 0), (0, 0, 0));
  animstruct._id_0B50860E78D9E1E5[3] linkTo(animstruct._id_16CFD3CBF327FEEF, "j_prop_4", (0, 0, 0), (0, 0, 0));
  animstruct._id_A552EC61E51ECE6E = [];
  animstruct._id_A552EC61E51ECE6E[0] = animstruct _id_0930A1E7BD882C1D::spawn_script_model("fullbody_usmc_ar_br_infil", "player1");
  animstruct._id_A552EC61E51ECE6E[1] = animstruct _id_0930A1E7BD882C1D::spawn_script_model("fullbody_usmc_ar_br_infil", "player2");
  animstruct._id_A552EC61E51ECE6E[2] = animstruct _id_0930A1E7BD882C1D::spawn_script_model("fullbody_usmc_ar_br_infil", "player3");
  animstruct._id_A552EC61E51ECE6E[3] = animstruct _id_0930A1E7BD882C1D::spawn_script_model("fullbody_usmc_ar_br_infil", "player4");
  animstruct._id_A552EC61E51ECE6E[0] linkTo(animstruct._id_0B50860E78D9E1E5[0], "tag_player", (0, 0, 0), (0, 0, 0));
  animstruct._id_A552EC61E51ECE6E[1] linkTo(animstruct._id_0B50860E78D9E1E5[1], "tag_player", (0, 0, 0), (0, 0, 0));
  animstruct._id_A552EC61E51ECE6E[2] linkTo(animstruct._id_0B50860E78D9E1E5[2], "tag_player", (0, 0, 0), (0, 0, 0));
  animstruct._id_A552EC61E51ECE6E[3] linkTo(animstruct._id_0B50860E78D9E1E5[3], "tag_player", (0, 0, 0), (0, 0, 0));
  animstruct._id_F4303E46177AED3A = animstruct _id_0930A1E7BD882C1D::spawn_script_model("fullbody_usmc_ar_br_infil", "doorChief");
  animstruct._id_F4303E46177AED3A linkTo(animstruct._id_16CFD3CBF327FEEF, "j_prop_5", (0, 0, 0), (0, 0, 0));
  animstruct.cloudanimfx = spawnfx(level._effect["vfx_br_infil_cloud_anim"], animstruct.staticc130.origin);
  animstruct.packs = [];
  n = 0;
  animstruct.packs[n] = animstruct _id_0930A1E7BD882C1D::create_animpack("scene1");
  animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_startfunc([], ::_id_21EA09462D07CA25);
  animstruct.packs[n] _id_0930A1E7BD882C1D::_id_E718BA63D511FCDE([], ::_id_B33E50ED017D5ACE);
  animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct.staticc130, level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_redux_players_ac130"]);

  if(isDefined(animstruct.movingc130))
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct.movingc130, level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_redux_players_ac130"]);

  animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct.camera, level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_redux_players_cam"]);

  if(isDefined(animstruct._id_96FE3313D1BAB862))
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_96FE3313D1BAB862, level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_redux_players_cam"]);

  animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_16CFD3CBF327FEEF, level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_redux_character_link"]);
  animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[0], level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_redux_player1"]);
  animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[1], level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_redux_player2"]);
  animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[2], level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_redux_player3"]);
  animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[3], level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_redux_player4"]);
  animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[0], level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_redux_player1"]);
  animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[1], level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_redux_player2"]);
  animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[2], level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_redux_player3"]);
  animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[3], level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_redux_player4"]);
  animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_F4303E46177AED3A, level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_redux_doorchief"]);
  animstruct.packs[n] _id_0930A1E7BD882C1D::_id_D4561AB1BA4F5DE9(animstruct.camera, ["j_prop_1", "j_prop_2", "j_prop_3", "j_prop_4"], level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_redux_players_ac130"]);

  if(!isDefined(level.scr_notetrack["c130"]) || !isDefined(level.scr_notetrack["c130"]["any"]["gored"])) {
    scripts\common\anim::addnotetrack_customfunction("c130", "gored", ::_id_4E1DB4886EDFA5B2);
    scripts\common\anim::addnotetrack_customfunction("c130", "gogreen", ::_id_ECC93C094EFC9AF2);
    scripts\common\anim::addnotetrack_customfunction("c130", "opendoor", ::_id_FD00EDC34074BB24);
    scripts\common\anim::addnotetrack_customfunction("c130", "transitionstart", ::_id_97B59EB002F8DDEB);
    scripts\common\anim::addnotetrack_customfunction("camera", "transition", ::_id_88BA30853F3D01F0);
  }

  n++;
  animstruct.packs[n] = animstruct _id_0930A1E7BD882C1D::create_animpack("looping", 1);
  animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_startfunc([], ::_id_F90E2DB4B34D7F57);
  animstruct.packs[n] _id_0930A1E7BD882C1D::_id_E718BA63D511FCDE([], ::_id_60240BEEDE5E1AB8);

  if(isDefined(animstruct.movingc130)) {
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct.movingc130, level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_loop2_plane"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct.movingc130.innards, level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_loop2_plane"]);
  }

  animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_16CFD3CBF327FEEF, level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_loop_genpropx10"]);
  animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[0], level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_loop_pl01"]);
  animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[1], level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_loop_pl02"]);
  animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[2], level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_loop_pl03"]);
  animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[3], level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_loop_pl04"]);
  animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[0], level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_loop_pl01"]);
  animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[1], level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_loop_pl02"]);
  animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[2], level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_loop_pl03"]);
  animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[3], level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_loop_pl04"]);
  animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_F4303E46177AED3A, level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_loop_doorchief"]);
  animstruct.packs[n] _id_0930A1E7BD882C1D::_id_D4561AB1BA4F5DE9(animstruct.camera, ["j_prop_1", "j_prop_2", "j_prop_3", "j_prop_4"]);
  return animstruct;
}

_id_21EA09462D07CA25(array) {
  if(isDefined(self.movingc130))
    self.movingc130 stoploopsound();

  self._id_F4303E46177AED3A hide();
  playFXOnTag(level._effect["vfx_br_ac130_clouds"], self.staticc130, "tag_body");
  thread clearsoundsubmixmpbrinfilanim();
  thread offlight();
  thread infil_light_dvars();
  thread delaystreamtomovingplane();
}

_id_B33E50ED017D5ACE(player, array) {
  _id_28844396B0024FAF = 34;
  _id_D1C04FF6328D20D6 = 5.6;
  _id_095288242E2D19A2 = 50.7;
  _id_8A3CE4D151659D21 = 2.0;
  _id_9B5197CC4BB4356A = 4;
  player setsoundsubmix("mp_br_infil_anim", 0.0);
  player setsoundsubmix("mp_br_infil_music", 0.0);
  player setsoundsubmix("mp_br_infil_ac130", 0.0);
  player setclienttriggeraudiozone("mp_br_c130_infil_int", 1.0);
  player setclientdvar("cg_fov", _id_28844396B0024FAF);
  player enablephysicaldepthoffieldscripting();
  player setphysicaldepthoffield(_id_D1C04FF6328D20D6, _id_095288242E2D19A2, _id_8A3CE4D151659D21, _id_9B5197CC4BB4356A);
  self._id_F4303E46177AED3A showtoplayer(player);
}

_id_F90E2DB4B34D7F57(array) {
  stopFXOnTag(level._effect["vfx_br_ac130_clouds"], self.staticc130, "tag_body");
  self.staticc130 stoploopsound();

  if(isDefined(self.movingc130))
    self.movingc130 playLoopSound("br_ac130_lp");
}

_id_60240BEEDE5E1AB8(player, array) {}

_id_72145194F4F38714() {
  _id_75377E59F5BECAC8::cleanupents();
}

clearsoundsubmixmpbrinfilanim() {
  _id_0930A1E7BD882C1D::waitandpause(0.65);

  foreach(player in level.infilstruct.players) {
    if(!isDefined(player)) {
      continue;
    }
    player clearsoundsubmix("mp_br_infil_anim", 3.0);
  }
}

clearsoundsubmixfadetoblackamb() {
  _id_0930A1E7BD882C1D::waitandpause(0.5);

  foreach(player in level.infilstruct.players) {
    if(!isDefined(player)) {
      continue;
    }
    player clearsoundsubmix("fade_to_black_all_except_music_scripted5_and_amb", 1.0);
  }
}

clearsoundsubmixmpbrinfilac130() {
  _id_0930A1E7BD882C1D::waitandpause(7.7);

  foreach(player in level.infilstruct.players) {
    if(!isDefined(player)) {
      continue;
    }
    player clearsoundsubmix("mp_br_infil_ac130", 30.0);
  }
}

offlight() {
  _id_620D0024527F448C = getentitylessscriptablearray("infil_blinking_light", "script_noteworthy");

  foreach(_id_4D81CDDC98ED9537 in _id_620D0024527F448C)
  _id_4D81CDDC98ED9537 setscriptablepartstate("light_blinking_slow", "light_off_hold", 1);
}

_id_4E1DB4886EDFA5B2(c130) {
  _id_620D0024527F448C = getentitylessscriptablearray("infil_blinking_light", "script_noteworthy");

  foreach(_id_4D81CDDC98ED9537 in _id_620D0024527F448C)
  _id_4D81CDDC98ED9537 setscriptablepartstate("light_blinking_slow", "light_on", 1);
}

_id_ECC93C094EFC9AF2(c130) {
  _id_620D0024527F448C = getentitylessscriptablearray("infil_blinking_light", "script_noteworthy");

  foreach(_id_4D81CDDC98ED9537 in _id_620D0024527F448C)
  _id_4D81CDDC98ED9537 setscriptablepartstate("light_blinking_slow", "light_jump", 1);
}

_id_FD00EDC34074BB24(c130) {
  foreach(player in level.infilstruct.players) {
    if(!isDefined(player) || isbot(player)) {
      continue;
    }
    player scripts\mp\utility\player::setwind("100", 1);
  }

  level.infilstruct.animstruct._id_F4303E46177AED3A scripts\mp\utility\player::setwind("100");
}

clearplayerwind() {
  foreach(player in level.infilstruct.players) {
    if(!isDefined(player)) {
      continue;
    }
    player scripts\mp\utility\player::setwind("1");
    player.manualoverridewindmaterial = undefined;
  }

  self._id_F4303E46177AED3A scripts\mp\utility\player::setwind("0");
}

_id_97B59EB002F8DDEB(c130) {
  triggerfx(level.infilstruct.animstruct.cloudanimfx);
}

_id_88BA30853F3D01F0(c130) {
  level.infilstruct.animstruct notify("infil_reset_light_dvars");
  level.infilstruct.animstruct clearplayerwind();
  _id_1992F143059AC1D5 = 65;
  _id_E49FE50208C2823C = 14;
  _id_60A2FCCF1C5E6D84 = 35;
  _id_AF0267D0EC57107F = 2.0;
  _id_92DE264F62389DB4 = 4;

  foreach(player in level.infilstruct.players) {
    if(!isDefined(player)) {
      continue;
    }
    player setallstreamloaddist(0.0);
    player setclienttriggeraudiozone("mp_br_c130_infil_ext", 2.0);
  }

  if(isDefined(level.infilstruct.animstruct.movingc130)) {
    foreach(player in level.infilstruct.players) {
      if(!isDefined(player)) {
        continue;
      }
      cameraent = level.infilstruct.animstruct._id_96FE3313D1BAB862;
      _id_1EDD840D40B43222 = undefined;

      if(isarray(level.infilstruct.animstruct._id_2739B8C6B038BA5E._id_2336099A20080602._id_E6783D526B4A7212))
        _id_1EDD840D40B43222 = level.infilstruct.animstruct._id_2739B8C6B038BA5E._id_2336099A20080602._id_E6783D526B4A7212[player.infilanimindex - 1];
      else
        _id_1EDD840D40B43222 = level.infilstruct.animstruct._id_2739B8C6B038BA5E._id_2336099A20080602._id_E6783D526B4A7212;

      player cameraunlink();
      player cameralinkTo(cameraent, _id_1EDD840D40B43222, 1, 1);
      player setclientdvar("cg_fov", _id_1992F143059AC1D5);
      player setphysicaldepthoffield(_id_E49FE50208C2823C, _id_60A2FCCF1C5E6D84, _id_AF0267D0EC57107F, _id_92DE264F62389DB4);
    }

    level thread clearsoundsubmixfadetoblackamb();

    if(isDefined(level.infilstruct.animstruct.cloudanimfx))
      level.infilstruct.animstruct.cloudanimfx.origin = level.infilstruct.animstruct.movingc130.origin;

    level.infilstruct.animstruct._id_16CFD3CBF327FEEF unlink();
    level.infilstruct.animstruct._id_16CFD3CBF327FEEF linkTo(level.infilstruct.animstruct.movingc130, "", (0, 0, 0), (0, 0, 0));
    level.infilstruct.animstruct.movingc130 notify("start_moving");
  }

  level.infilstruct.animstruct.staticc130 hide();
  setomnvar("ui_hide_player_icons", 0);
  level thread clearsoundsubmixmpbrinfilac130();
}

infil_light_dvars() {
  _id_C3ED855FE7C983E3 = getdvarfloat("sm_spotDistCull");
  _id_1800E53D66415E2D = getdvarint("sm_spotUpdateLimit");
  _id_5506432D2291C178 = getdvarint("sm_roundRobinPrioritySpotShadows");
  _id_488F9B9FE1EAD0A6 = getdvarfloat("sm_sunSampleSizeNear");
  setDvar("sm_spotDistCull", 1000.0);
  setDvar("sm_spotUpdateLimit", 6);
  setDvar("sm_roundRobinPrioritySpotShadows", 8);
  setDvar("sm_sunSampleSizeNear", 0.25);
  scripts\engine\utility::waittill_either("infil_reset_light_dvars", "stopScene");
  setDvar("sm_spotDistCull", _id_C3ED855FE7C983E3);
  setDvar("sm_spotUpdateLimit", _id_1800E53D66415E2D);
  setDvar("sm_roundRobinPrioritySpotShadows", _id_5506432D2291C178);
  setDvar("sm_sunSampleSizeNear", _id_488F9B9FE1EAD0A6);
}

delaystreamtomovingplane() {
  self endon("stopScene");

  if(isDefined(self.movingc130)) {
    _id_74B5B12BB6514385 = getdvarint("dvar_D01D0472D843D39E", 8);
    wait(_id_74B5B12BB6514385);

    if(!isDefined(self.movingc130)) {
      return;
    }
    _id_11F3B4465C8B637B = self.movingc130.origin;
    forward = getdvarint("dvar_7ABCDA2D7AABBE4C", 0);

    if(forward > 0) {
      dir = anglesToForward(self.movingc130.angles);
      _id_11F3B4465C8B637B = self.movingc130.origin + dir * forward;
    }

    foreach(player in level.infilstruct.players) {
      if(!isDefined(player)) {
        continue;
      }
      player setpredictedstreamloaddist(0.0);
      player _id_2CEDCC356F1B9FC8::playerstreamhintlocation(_id_11F3B4465C8B637B);
    }
  }
}

stopstreamtomovingplane() {
  if(isDefined(self.movingc130) && getdvarint("dvar_EB8A05AFA7735E5F", 1) == 1) {
    _id_74B5B12BB6514385 = getdvarint("dvar_B7C6D487B0F5506B", 5);
    wait(_id_74B5B12BB6514385);

    foreach(player in level.infilstruct.players) {
      if(!isDefined(player)) {
        continue;
      }
      player thread _id_2CEDCC356F1B9FC8::playerclearstreamhintorigin();
    }
  }
}

_id_CD7E1A37D5E2CA2B() {
  _id_567639D26F6A140B = getEnt("infil_plane", "script_noteworthy");

  if(isDefined(_id_567639D26F6A140B))
    _id_567639D26F6A140B hide();
}

_id_5901CD0BE722F86A() {
  _id_D788FBB04A7A099D = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("br_infil_intro");

  foreach(player in level.infilstruct.players) {
    if(!isDefined(player)) {
      continue;
    }
    player setentitysoundcontext("lobby_fade", "", 2);
    player playlocalsound("br_infil_part1_lr");
    player clearsoundsubmix("mp_br_lobby_fade", 1.5);
    player setsoundsubmix("solo_cin_igc_music", 0.5);
    player setplayermusicstate(_id_D788FBB04A7A099D);
  }
}

_id_39C2CF6576478D41() {
  level thread setsoundsubmixfadetoblackamb();
}

setsoundsubmixfadetoblackamb(players) {
  _id_0930A1E7BD882C1D::waitandpause(2.0);

  foreach(player in level.infilstruct.players) {
    if(!isDefined(player)) {
      continue;
    }
    player clearsoundsubmix("solo_cin_igc_music", 0.5);
    player setsoundsubmix("fade_to_black_all_except_music_scripted5_and_amb", 2.0);
  }
}

_id_AD4A7A73C7D7D9E0() {
  _id_522A77434D41564A = self getplayerangles(1);
  _id_20AF753DED3657E1 = anglesToForward(_id_522A77434D41564A);
  _id_4B52F031A2CBEF8E = anglesToForward(level.infilstruct.c130.angles);
  _id_D8BB89F41AE3D919 = anglestoright(level.infilstruct.c130.angles);
  _id_172D42D175E16C61 = vectordot(_id_20AF753DED3657E1, _id_4B52F031A2CBEF8E);
  _id_ED451F0EA36C48C6 = vectordot(_id_20AF753DED3657E1, _id_D8BB89F41AE3D919);

  if(!isDefined(self.infilanimindex))
    self.infilanimindex = 1;

  _id_8E3AFD40D3C95B46 = "j_prop_" + (self.infilanimindex + 2);
  _id_C29AC1B887131D03 = cos(45.0);

  if(_id_172D42D175E16C61 < -1.0 * _id_C29AC1B887131D03)
    return ["sdr_mp_infil_ac130_jump_genpropx10", level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_jump_genpropx10"], "sdr_mp_infil_ac130_jump", _id_8E3AFD40D3C95B46];

  if(_id_ED451F0EA36C48C6 > _id_C29AC1B887131D03)
    return ["sdr_mp_infil_ac130_jump_genpropx10_90_l", level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_jump_genpropx10_90_l"], "sdr_mp_infil_ac130_jump_90_l", _id_8E3AFD40D3C95B46];
  else if(_id_ED451F0EA36C48C6 < -1.0 * _id_C29AC1B887131D03)
    return ["sdr_mp_infil_ac130_jump_genpropx10_90_r", level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_jump_genpropx10_90_r"], "sdr_mp_infil_ac130_jump_90_r", _id_8E3AFD40D3C95B46];
  else if(_id_ED451F0EA36C48C6 > 0.0)
    return ["sdr_mp_infil_ac130_jump_genpropx10_180_l", level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_jump_genpropx10_180_l"], "sdr_mp_infil_ac130_jump_180_l", _id_8E3AFD40D3C95B46];
  else
    return ["sdr_mp_infil_ac130_jump_genpropx10_180_r", level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_jump_genpropx10_180_r"], "sdr_mp_infil_ac130_jump_180_r", _id_8E3AFD40D3C95B46];
}

_id_52BEDAE2CED8E191() {
  _id_A910600EADF5E31C = level._effect["vfx_br_ac130_clouds"];
  _id_08B26DE022A9F35F = level._effect["vfx_br_ac130_oneshot"];

  if(isDefined(_id_A910600EADF5E31C))
    stopFXOnTag(_id_A910600EADF5E31C, self, "tag_body");

  if(isDefined(_id_08B26DE022A9F35F))
    stopFXOnTag(_id_08B26DE022A9F35F, self, "tag_body");
}