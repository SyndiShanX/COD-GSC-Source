/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_142b065a6cb7bf82.gsc
***********************************************/

init() {
  level._id_F84366B8FDD80CF2 = getdvarint("dvar_1D024C82743AA4CE", 0);
  level.infilstruct._id_FD05DC031A2E7283 = "veh8_mil_air_mindia8_open_back_infil";
  level.infilstruct._id_30E653E12F358438 = "veh8_mil_air_mindia8_interior_vm_infil";
  level.infilstruct._id_477BD548940C3A78 = "mp_donetsk_mindia8_intro";
  level.infilstruct._id_10D27B439AF13A2A = scripts\engine\utility::ter_op(level._id_F84366B8FDD80CF2, 0.1, 5);
  level.infilstruct._id_B381E33E977DA440 = ::_id_55F2480B4B819AEA;
  level.infilstruct._id_AE9E4023110ACC6E = ::_id_AD4A7A73C7D7D9E0;
  level.infilstruct._id_A6547E85663B3BC2 = ::_id_B766175A1F0EEB13;
  _id_1809E16510055E87 = ["cam_orbit_br_chopper_squad_player1", "cam_orbit_br_chopper_squad_player1", "cam_orbit_br_chopper_squad_player2", "cam_orbit_br_chopper_squad_player3", "cam_orbit_br_chopper_squad_player4"];
  _id_0930A1E7BD882C1D::_id_226E337633A44059(_id_1809E16510055E87, "cam_orbit_br_chopper_solo");
  _id_0930A1E7BD882C1D::_id_AD12D29D41483E8A("prematch", scripts\engine\utility::void);
  _id_0930A1E7BD882C1D::_id_AD12D29D41483E8A("cinematic", ::_id_5901CD0BE722F86A);
  _id_0930A1E7BD882C1D::_id_AD12D29D41483E8A("animatic", ::_id_39C2CF6576478D41);
}

_id_55F2480B4B819AEA(_id_D40A73AF6AC75726) {
  animstruct = spawnStruct();
  _id_D40A73AF6AC75726.animstruct = animstruct;
  animstruct.origin = getdvarvector("br_infil_anim_pos", (4319, 0, -28644));
  animstruct.angles = (0, 0, 0);
  animstruct._id_D40A73AF6AC75726 = _id_D40A73AF6AC75726;
  animstruct.cleanupfunc = ::_id_A5668882499FB369;
  animstruct.chopper = getEnt("infil_chopper", "script_noteworthy");

  if(isDefined(animstruct.chopper))
    animstruct.chopper show();
  else {
    animstruct.chopper = animstruct _id_0930A1E7BD882C1D::spawn_script_model("veh8_mil_air_mindia8_interior_infil", "chopper");
    animstruct.chopper.angles = animstruct.angles;
    animstruct.chopper.cleanme = 1;
  }

  animstruct._id_2ACEA58437338FEE = getEnt("infil_chopper_open", "script_noteworthy");

  if(isDefined(animstruct._id_2ACEA58437338FEE))
    animstruct._id_2ACEA58437338FEE show();
  else {
    animstruct._id_2ACEA58437338FEE = animstruct.chopper _id_0930A1E7BD882C1D::spawn_script_model("veh8_mil_air_mindia8_open_back_infil", "choppershell");
    animstruct._id_2ACEA58437338FEE.angles = animstruct.chopper.angles;
    animstruct._id_2ACEA58437338FEE.cleanme = 1;
  }

  animstruct._id_C1BF2A7FD5E40DAD = animstruct.chopper _id_0930A1E7BD882C1D::spawn_script_model("veh8_mil_air_mindia8_interior_infil_netting", "movingChopper");
  animstruct._id_C1BF2A7FD5E40DAD linkTo(animstruct.chopper, "tag_origin", (0, 0, 0), (0, 0, 0));
  animstruct._id_C55268271ABF5EA4 = animstruct.chopper _id_0930A1E7BD882C1D::spawn_script_model("veh8_mil_air_mindia8_interior_infil_cabin_door", "chopperDoor");
  animstruct._id_C55268271ABF5EA4 linkTo(animstruct.chopper, "tag_origin", (0, 0, 0), (0, 0, 0));

  if(isDefined(animstruct._id_D40A73AF6AC75726)) {
    animstruct._id_D40A73AF6AC75726.animname = "movingChopper";
    animstruct._id_D40A73AF6AC75726.innards.animname = "movingChopper";
  }

  animstruct._id_D60E3315ABA032E0 = animstruct.chopper _id_0930A1E7BD882C1D::spawn_script_model("generic_prop_x3", "camera");
  animstruct._id_D60E3315ABA032E0 linkTo(animstruct.chopper, "tag_origin", (0, 0, 0), (0, 0, 0));
  animstruct._id_2F73A403F1E61903 = animstruct.chopper _id_0930A1E7BD882C1D::spawn_script_model("generic_prop_x3", "cameraSquad");
  animstruct._id_2F73A403F1E61903 linkTo(animstruct.chopper, "tag_origin", (0, 0, 0), (0, 0, 0));

  if(isDefined(_id_D40A73AF6AC75726)) {
    _id_D40A73AF6AC75726 forcenetfieldhighlod(1);
    animstruct._id_7BBC3350E7793CC6 = _id_D40A73AF6AC75726 _id_0930A1E7BD882C1D::spawn_script_model("generic_prop_x3", "cameramoving");
    animstruct._id_7BBC3350E7793CC6 linkTo(_id_D40A73AF6AC75726, "tag_origin", (0, 0, 0), (0, 0, 0));
    animstruct._id_7BBC3350E7793CC6 forcenetfieldhighlod(1);
    animstruct._id_A9A5DAB973B28FAD = _id_D40A73AF6AC75726 _id_0930A1E7BD882C1D::spawn_script_model("generic_prop_x3", "cameraSquadmoving");
    animstruct._id_A9A5DAB973B28FAD linkTo(_id_D40A73AF6AC75726, "tag_origin", (0, 0, 0), (0, 0, 0));
    animstruct._id_A9A5DAB973B28FAD forcenetfieldhighlod(1);
  }

  animstruct.playerpositionents["parent_solo"] = animstruct.chopper _id_0930A1E7BD882C1D::spawn_script_model("generic_prop_x3", "propsolo");
  animstruct.playerpositionents["parent_solo"] linkTo(animstruct.chopper, "tag_origin", (0, 0, 0), (0, 0, 0));
  animstruct.playerpositionents["parent_squad"] = animstruct.chopper _id_0930A1E7BD882C1D::spawn_script_model("generic_prop_x5", "propparent");
  animstruct.playerpositionents["parent_squad"] linkTo(animstruct.chopper, "tag_origin", (0, 0, 0), (0, 0, 0));
  animstruct._id_0B50860E78D9E1E5 = [];
  animstruct._id_0B50860E78D9E1E5[0] = animstruct.chopper _id_0930A1E7BD882C1D::spawn_script_model("tag_player", "playerTag1");
  animstruct._id_0B50860E78D9E1E5[1] = animstruct.chopper _id_0930A1E7BD882C1D::spawn_script_model("tag_player", "playerTag1");
  animstruct._id_0B50860E78D9E1E5[2] = animstruct.chopper _id_0930A1E7BD882C1D::spawn_script_model("tag_player", "playerTag2");
  animstruct._id_0B50860E78D9E1E5[3] = animstruct.chopper _id_0930A1E7BD882C1D::spawn_script_model("tag_player", "playerTag3");
  animstruct._id_0B50860E78D9E1E5[4] = animstruct.chopper _id_0930A1E7BD882C1D::spawn_script_model("tag_player", "playerTag4");
  animstruct._id_0B50860E78D9E1E5[0] linkTo(animstruct.playerpositionents["parent_solo"], "j_prop_1", (0, 0, 0), (0, 0, 0));
  animstruct._id_0B50860E78D9E1E5[1] linkTo(animstruct.playerpositionents["parent_squad"], "j_prop_1", (0, 0, 0), (0, 0, 0));
  animstruct._id_0B50860E78D9E1E5[2] linkTo(animstruct.playerpositionents["parent_squad"], "j_prop_2", (0, 0, 0), (0, 0, 0));
  animstruct._id_0B50860E78D9E1E5[3] linkTo(animstruct.playerpositionents["parent_squad"], "j_prop_3", (0, 0, 0), (0, 0, 0));
  animstruct._id_0B50860E78D9E1E5[4] linkTo(animstruct.playerpositionents["parent_squad"], "j_prop_4", (0, 0, 0), (0, 0, 0));
  animstruct._id_A552EC61E51ECE6E = [];
  animstruct._id_A552EC61E51ECE6E[0] = animstruct.chopper _id_0930A1E7BD882C1D::spawn_script_model("fullbody_usmc_ar_br_infil", "player1");
  animstruct._id_A552EC61E51ECE6E[1] = animstruct.chopper _id_0930A1E7BD882C1D::spawn_script_model("fullbody_usmc_ar_br_infil", "player1");
  animstruct._id_A552EC61E51ECE6E[2] = animstruct.chopper _id_0930A1E7BD882C1D::spawn_script_model("fullbody_usmc_ar_br_infil", "player2");
  animstruct._id_A552EC61E51ECE6E[3] = animstruct.chopper _id_0930A1E7BD882C1D::spawn_script_model("fullbody_usmc_ar_br_infil", "player3");
  animstruct._id_A552EC61E51ECE6E[4] = animstruct.chopper _id_0930A1E7BD882C1D::spawn_script_model("fullbody_usmc_ar_br_infil", "player4");
  animstruct._id_A552EC61E51ECE6E[0] linkTo(animstruct._id_0B50860E78D9E1E5[0], "tag_player", (0, 0, 0), (0, 0, 0));
  animstruct._id_A552EC61E51ECE6E[1] linkTo(animstruct._id_0B50860E78D9E1E5[0], "tag_player", (0, 0, 0), (0, 0, 0));
  animstruct._id_A552EC61E51ECE6E[2] linkTo(animstruct._id_0B50860E78D9E1E5[1], "tag_player", (0, 0, 0), (0, 0, 0));
  animstruct._id_A552EC61E51ECE6E[3] linkTo(animstruct._id_0B50860E78D9E1E5[2], "tag_player", (0, 0, 0), (0, 0, 0));
  animstruct._id_A552EC61E51ECE6E[4] linkTo(animstruct._id_0B50860E78D9E1E5[3], "tag_player", (0, 0, 0), (0, 0, 0));
  animstruct._id_DF521449D9601357 = animstruct.chopper _id_0930A1E7BD882C1D::spawn_script_model("body_mp_western_otter_3_1_lod1", "aiPilot");
  animstruct._id_83DB4F06BA84626D = spawn("script_model", animstruct._id_DF521449D9601357 gettagorigin("j_neck"));
  animstruct._id_83DB4F06BA84626D setModel("head_mp_eastern_metalghost_1_1");
  animstruct._id_83DB4F06BA84626D.animname = "aiPilotHead";
  animstruct._id_83DB4F06BA84626D linkTo(animstruct._id_DF521449D9601357, "j_neck", (-9, 1, 0), (0, 0, 0));
  animstruct._id_DF521449D9601357 linkTo(animstruct.playerpositionents["parent_solo"], "j_prop_2", (0, 0, 0), (0, 0, 0));
  animstruct._id_B0FFA16EB57B1EA1 = animstruct.chopper _id_0930A1E7BD882C1D::spawn_script_model("body_mp_western_otter_3_1_lod1", "aiCopilot");
  _id_8B31BC2C19776C6F = spawn("script_model", animstruct._id_B0FFA16EB57B1EA1 gettagorigin("j_neck"));
  _id_8B31BC2C19776C6F setModel("head_mp_eastern_metalghost_1_1");
  _id_8B31BC2C19776C6F linkTo(animstruct._id_B0FFA16EB57B1EA1, "j_neck", (-9, 1, 0), (0, 0, 0));
  animstruct._id_B0FFA16EB57B1EA1 linkTo(animstruct.playerpositionents["parent_solo"], "j_prop_3", (0, 0, 0), (0, 0, 0));
  animstruct._id_F31099D0AC1CF72F = animstruct.chopper _id_0930A1E7BD882C1D::spawn_script_model("generic_prop_x10", "armadaRig");
  animstruct._id_F31099D0AC1CF72F linkTo(animstruct.chopper, "", (0, 0, 0), (0, 0, 0));
  animstruct._id_F31099D0AC1CF72F forcenetfieldhighlod(1);
  _id_D4E512C7842A8A5D = 9;
  animstruct._id_8A5C28116079C26B = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_D4E512C7842A8A5D; _id_AC0E594AC96AA3A8++) {
    _id_51ABC28B8D72CF10 = animstruct.chopper _id_0930A1E7BD882C1D::spawn_script_model("veh8_mil_air_mindia8_infil_flight", "newChopper" + _id_AC0E594AC96AA3A8);
    _id_51ABC28B8D72CF10 linkTo(animstruct._id_F31099D0AC1CF72F, "j_prop_" + (_id_AC0E594AC96AA3A8 + 2), (0, 0, 0), (0, 0, 0));
    _id_51ABC28B8D72CF10 forcenetfieldhighlod(1);
    _id_51ABC28B8D72CF10 playLoopSound("br_heli_infil_fleet_lp");
    animstruct._id_8A5C28116079C26B[animstruct._id_8A5C28116079C26B.size] = _id_51ABC28B8D72CF10;
  }

  animstruct.packs = [];
  n = 0;

  if(!istrue(level._id_F84366B8FDD80CF2)) {
    animstruct.packs[n] = animstruct _id_0930A1E7BD882C1D::create_animpack("scene1");
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_startfunc([], ::_id_1D609F282B615EB7);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_E718BA63D511FCDE([], ::_id_447159EC37003898);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_D60E3315ABA032E0, level._id_1A209BD995A7FA83["wz_infil_mindia8_solo_cam"]);

    if(isDefined(animstruct._id_7BBC3350E7793CC6))
      animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_7BBC3350E7793CC6, level._id_1A209BD995A7FA83["wz_infil_mindia8_solo_cam"]);

    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2F73A403F1E61903, level._id_1A209BD995A7FA83["wz_infil_mindia8_squad_cam"]);

    if(isDefined(animstruct._id_A9A5DAB973B28FAD))
      animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_A9A5DAB973B28FAD, level._id_1A209BD995A7FA83["wz_infil_mindia8_squad_cam"]);

    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct.playerpositionents["parent_solo"], level._id_1A209BD995A7FA83["wz_infil_mindia8_solo_character_link"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct.playerpositionents["parent_squad"], level._id_1A209BD995A7FA83["wz_infil_mindia8_squad_character_link"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[0], level._id_1A209BD995A7FA83["wz_infil_mindia8_solo_player"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[1], level._id_1A209BD995A7FA83["wz_infil_mindia8_squad_player1"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[2], level._id_1A209BD995A7FA83["wz_infil_mindia8_squad_player2"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[3], level._id_1A209BD995A7FA83["wz_infil_mindia8_squad_player3"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[4], level._id_1A209BD995A7FA83["wz_infil_mindia8_squad_player4"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[0], level._id_1A209BD995A7FA83["wz_infil_mindia8_solo_player"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[1], level._id_1A209BD995A7FA83["wz_infil_mindia8_squad_player1"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[2], level._id_1A209BD995A7FA83["wz_infil_mindia8_squad_player2"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[3], level._id_1A209BD995A7FA83["wz_infil_mindia8_squad_player3"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[4], level._id_1A209BD995A7FA83["wz_infil_mindia8_squad_player4"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_DF521449D9601357, level._id_1A209BD995A7FA83["wz_infil_mindia8_solo_pilot"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_83DB4F06BA84626D, level._id_1A209BD995A7FA83["wz_infil_mindia8_solo_pilot"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_B0FFA16EB57B1EA1, level._id_1A209BD995A7FA83["wz_infil_mindia8_solo_copilot"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_F31099D0AC1CF72F, level._id_1A209BD995A7FA83["wz_infil_mindia8_armada"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_D4561AB1BA4F5DE9(animstruct._id_2F73A403F1E61903, "j_prop_1", level._id_1A209BD995A7FA83["wz_infil_mindia8_solo_player"]);

    if(!isDefined(level.scr_notetrack["camera"])) {
      scripts\common\anim::addnotetrack_customfunction("camera", "transition", ::_id_88BA30853F3D01F0);
      scripts\common\anim::addnotetrack_customfunction("camera", "fadeinstart", ::_id_45739096D37DD8BA);
      scripts\common\anim::addnotetrack_customfunction("camera", "fadeoutstart", ::_id_6E89FAFBFCEDD6F3);
    }
  }

  n++;
  animstruct.packs[n] = animstruct _id_0930A1E7BD882C1D::create_animpack("looping", 1);
  animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_startfunc([], ::_id_5FF576FC264728A6);
  animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[0], level._id_1A209BD995A7FA83["wz_infil_mindia8_loop_pl01"]);
  animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[1], level._id_1A209BD995A7FA83["wz_infil_mindia8_loop_pl01"]);
  animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[2], level._id_1A209BD995A7FA83["wz_infil_mindia8_loop_pl02"]);
  animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[3], level._id_1A209BD995A7FA83["wz_infil_mindia8_loop_pl03"]);
  animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[4], level._id_1A209BD995A7FA83["wz_infil_mindia8_loop_pl04"]);
  animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[0], level._id_1A209BD995A7FA83["wz_infil_mindia8_loop_pl01"]);
  animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[1], level._id_1A209BD995A7FA83["wz_infil_mindia8_loop_pl01"]);
  animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[2], level._id_1A209BD995A7FA83["wz_infil_mindia8_loop_pl02"]);
  animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[3], level._id_1A209BD995A7FA83["wz_infil_mindia8_loop_pl03"]);
  animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[4], level._id_1A209BD995A7FA83["wz_infil_mindia8_loop_pl04"]);
  animstruct.packs[n] _id_0930A1E7BD882C1D::_id_D4561AB1BA4F5DE9(animstruct._id_2F73A403F1E61903, "j_prop_1");
  return animstruct;
}

_id_F3AE4B41DF047BA0() {
  teams = [];

  foreach(player in level.infilstruct.players) {
    if(!isDefined(player)) {
      continue;
    }
    if(!isDefined(teams[player.team]))
      teams[player.team] = [];

    teams[player.team][teams[player.team].size] = player;
  }

  foreach(team, players in teams) {
    numplayers = players.size;
    _id_F5B09A636E6E3153 = [2, 3, 4, 5];

    if(numplayers == 1)
      _id_F5B09A636E6E3153 = [1];

    _id_D12A341B40354143 = 0;

    foreach(player in players) {
      player.infilanimindex = _id_F5B09A636E6E3153[_id_D12A341B40354143 % _id_F5B09A636E6E3153.size];
      player._id_DB122A8941DFEE14 = numplayers;
      _id_D12A341B40354143++;
    }
  }
}

_id_1D609F282B615EB7(array) {
  _id_F3AE4B41DF047BA0();

  if(isDefined(self._id_D40A73AF6AC75726))
    self._id_D40A73AF6AC75726 stoploopsound();

  self._id_DF521449D9601357 hide();
  self._id_B0FFA16EB57B1EA1 hide();
  self._id_D40A73AF6AC75726 show();
  self._id_C1BF2A7FD5E40DAD show();
  thread clearsoundsubmixmpbrinfilanim();

  if(isDefined(self._id_D40A73AF6AC75726)) {
    self._id_D40A73AF6AC75726 setscriptablepartstate("infil_fx_hero", "on");
    self._id_D40A73AF6AC75726 setscriptablepartstate("infil_fx_mindia8", "moving");
  }

  _id_FD00EDC34074BB24();
  thread _id_69D240B44D66F525();
  thread infil_light_dvars();
  thread delaystreamtomovingplane();
  _id_2695A20D4011076D::hidedangercircle();

  foreach(_id_F3FA27ABE8FB369A in self._id_8A5C28116079C26B) {
    _id_52D8B7E47FB268FC = getanimlength(level._id_1A209BD995A7FA83["wz_infil_mindia8_loop_veh"]);
    _id_23A79FD929B2BA3D = randomfloatrange(0.5, _id_52D8B7E47FB268FC - 0.5);
    _id_F3FA27ABE8FB369A scriptmodelplayanim("wz_infil_mindia8_loop_veh", "armadaChopper", _id_23A79FD929B2BA3D);
    _id_F3FA27ABE8FB369A setscriptablepartstate("infil_fx_armada", "on");

    if(isDefined(_id_F3FA27ABE8FB369A.innards))
      _id_F3FA27ABE8FB369A.innards scriptmodelplayanim("wz_infil_mindia8_loop_veh", "armadaChopperInnards", _id_23A79FD929B2BA3D);
  }
}

_id_447159EC37003898(player, array) {
  _id_28844396B0024FAF = 48;
  _id_D1C04FF6328D20D6 = 5.6;
  _id_095288242E2D19A2 = 50.7;
  _id_8A3CE4D151659D21 = 2.0;
  _id_9B5197CC4BB4356A = 4;
  player playlocalsound("br_heli_infil_part2_lr");
  player setsoundsubmix("mp_br_infil_anim", 0.0);
  player setsoundsubmix("mp_br_infil_music", 0.0);
  player setsoundsubmix("mp_br_infil_ac130", 0.0);
  player setclienttriggeraudiozone("mp_br_c130_infil_int", 1.0);
  player setclientdvar("cg_fov", _id_28844396B0024FAF);
  player setclientdvar("cg_disable_user_fov", 1);
  player enablephysicaldepthoffieldscripting();
  player setphysicaldepthoffield(_id_D1C04FF6328D20D6, _id_095288242E2D19A2, _id_8A3CE4D151659D21, _id_9B5197CC4BB4356A);
  self._id_DF521449D9601357 showtoplayer(player);
  self._id_B0FFA16EB57B1EA1 showtoplayer(player);

  if(!isDefined(player.infilcoveroverlay)) {
    player.infilcoveroverlay = newclienthudelem(player);
    _id_347D499C7FD9AF39(player.infilcoveroverlay);
  }
}

_id_347D499C7FD9AF39(_id_94480E1669B7FF0D) {
  _id_94480E1669B7FF0D.x = 0;
  _id_94480E1669B7FF0D.y = 0;
  _id_94480E1669B7FF0D setshader("white", 640, 480);
  _id_94480E1669B7FF0D.alignx = "left";
  _id_94480E1669B7FF0D.aligny = "top";
  _id_94480E1669B7FF0D.horzalign = "fullscreen";
  _id_94480E1669B7FF0D.vertalign = "fullscreen";
  _id_94480E1669B7FF0D.sort = -1;
  _id_94480E1669B7FF0D.color = (0.21, 0.21, 0.17);
  _id_94480E1669B7FF0D.alpha = 0;
  _id_94480E1669B7FF0D setshowinrealism(1);
}

_id_5FF576FC264728A6(array) {
  if(istrue(level._id_F84366B8FDD80CF2)) {
    if(isDefined(self._id_D40A73AF6AC75726)) {
      self._id_D40A73AF6AC75726 setscriptablepartstate("infil_fx_hero", "on");
      self._id_D40A73AF6AC75726 setscriptablepartstate("infil_fx_mindia8", "moving");
    }

    foreach(_id_F3FA27ABE8FB369A in self._id_8A5C28116079C26B) {
      _id_52D8B7E47FB268FC = getanimlength(level._id_1A209BD995A7FA83["wz_infil_mindia8_loop_veh"]);
      _id_23A79FD929B2BA3D = randomfloatrange(0.5, _id_52D8B7E47FB268FC - 0.5);
      _id_F3FA27ABE8FB369A scriptmodelplayanim("wz_infil_mindia8_loop_veh", "armadaChopper", _id_23A79FD929B2BA3D);
      _id_F3FA27ABE8FB369A setscriptablepartstate("infil_fx_armada", "on");

      if(isDefined(_id_F3FA27ABE8FB369A.innards))
        _id_F3FA27ABE8FB369A.innards scriptmodelplayanim("wz_infil_mindia8_loop_veh", "armadaChopperInnards", _id_23A79FD929B2BA3D);
    }

    self._id_7BBC3350E7793CC6 scriptmodelplayanim("wz_infil_mindia8_solo_cam", "cameramoving", 10, 6);
    self._id_A9A5DAB973B28FAD scriptmodelplayanim("wz_infil_mindia8_squad_cam", "cameraSquadmoving", 10, 6);
    self._id_F31099D0AC1CF72F scriptmodelplayanim("wz_infil_mindia8_armada", "armadaRig", 0, 3);
    _id_88BA30853F3D01F0();
  }

  self.chopper stoploopsound();

  if(isDefined(self._id_D40A73AF6AC75726))
    self._id_D40A73AF6AC75726 playLoopSound("br_heli_infil_hero_lp");
}

_id_A5668882499FB369() {
  _id_75377E59F5BECAC8::cleanupents();
  level notify("cleanupInfil");
}

clearsoundsubmixmpbrinfilanim() {
  level endon("cleanupInfil");
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

_id_C6CEDF68AFE4E839() {
  _id_0930A1E7BD882C1D::waitandpause(7.7);

  foreach(player in level.infilstruct.players) {
    if(!isDefined(player)) {
      continue;
    }
    player clearsoundsubmix("mp_br_infil_ac130", 30.0);
  }
}

_id_FD00EDC34074BB24(c130) {
  foreach(player in level.infilstruct.players) {
    if(!isDefined(player) || isbot(player)) {
      continue;
    }
    player scripts\mp\utility\player::setwind("80", 1);
  }
}

_id_69D240B44D66F525() {
  level endon("cleanupInfil");

  if(isDefined(self._id_C55268271ABF5EA4))
    self._id_C55268271ABF5EA4 hide();

  self._id_D60E3315ABA032E0 scripts\engine\utility::waittill_match_or_timeout("camera", "showdoor", 30.0);

  if(isDefined(self._id_C55268271ABF5EA4))
    self._id_C55268271ABF5EA4 show();
}

clearplayerwind() {
  foreach(player in level.infilstruct.players) {
    if(!isDefined(player)) {
      continue;
    }
    player scripts\mp\utility\player::setwind("1");
    player.manualoverridewindmaterial = undefined;
  }
}

_id_45739096D37DD8BA(c130) {
  _id_EE006CF398BCD8FD = 0.15;

  foreach(player in level.infilstruct.players) {
    if(!isDefined(player)) {
      continue;
    }
    if(!isDefined(player.infilcoveroverlay)) {
      continue;
    }
    player.infilcoveroverlay.alpha = 0;
    player.infilcoveroverlay fadeovertime(_id_EE006CF398BCD8FD);
    player.infilcoveroverlay.alpha = 1;
  }
}

_id_6E89FAFBFCEDD6F3(c130) {
  _id_C8FE6E3CA9715960 = 0.2;

  foreach(player in level.infilstruct.players) {
    if(!isDefined(player)) {
      continue;
    }
    if(!isDefined(player.infilcoveroverlay)) {
      continue;
    }
    player.infilcoveroverlay.alpha = 1;
    player.infilcoveroverlay fadeovertime(_id_C8FE6E3CA9715960);
    player.infilcoveroverlay.alpha = 0;
  }

  _id_0930A1E7BD882C1D::waitandpause(_id_C8FE6E3CA9715960 + 0.1);

  foreach(player in level.infilstruct.players) {
    if(!isDefined(player)) {
      continue;
    }
    if(!isDefined(player.infilcoveroverlay)) {
      continue;
    }
    player.infilcoveroverlay destroy();
  }
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
    player setclienttriggeraudiozone("mp_br_infil_ext", 2.0);
  }

  if(isDefined(level.infilstruct.animstruct._id_D40A73AF6AC75726)) {
    foreach(player in level.infilstruct.players) {
      if(!isDefined(player)) {
        continue;
      }
      cameraent = scripts\engine\utility::ter_op(player._id_DB122A8941DFEE14 == 1, level.infilstruct.animstruct._id_7BBC3350E7793CC6, level.infilstruct.animstruct._id_A9A5DAB973B28FAD);
      _id_1EDD840D40B43222 = "j_prop_1";
      player cameraunlink();
      player cameralinkTo(cameraent, _id_1EDD840D40B43222, 1, 1);
      player setclientdvar("cg_fov", _id_1992F143059AC1D5);
      player setclientdvar("cg_disable_user_fov", 1);
      player setphysicaldepthoffield(_id_E49FE50208C2823C, _id_60A2FCCF1C5E6D84, _id_AF0267D0EC57107F, _id_92DE264F62389DB4);
      player thread _id_9441CFEE5F114846();
    }

    level thread clearsoundsubmixfadetoblackamb();
    _id_2695A20D4011076D::showdangercircle();
    level.infilstruct.animstruct.playerpositionents["parent_solo"] unlink();
    level.infilstruct.animstruct.playerpositionents["parent_squad"] unlink();
    level.infilstruct.animstruct.playerpositionents["parent_solo"] linkTo(level.infilstruct.animstruct._id_D40A73AF6AC75726, "", (0, 0, 0), (0, 0, 0));
    level.infilstruct.animstruct.playerpositionents["parent_squad"] linkTo(level.infilstruct.animstruct._id_D40A73AF6AC75726, "", (0, 0, 0), (0, 0, 0));
    level.infilstruct.animstruct._id_F31099D0AC1CF72F unlink();
    level.infilstruct.animstruct._id_F31099D0AC1CF72F linkTo(level.infilstruct.animstruct._id_D40A73AF6AC75726, "", (0, 0, 0), (0, 0, 0));
    level.infilstruct.animstruct._id_D40A73AF6AC75726 scriptmodelplayanim("wz_infil_mindia8_loop_veh", "movingChopper");
    level.infilstruct.animstruct._id_D40A73AF6AC75726.innards scriptmodelplayanim("wz_infil_mindia8_loop_veh", "movingChopperInnards");
    level.infilstruct.animstruct.playerpositionents["parent_solo"] scriptmodelplayanim("wz_infil_mindia8_loop_genpropx10", "prop");
    level.infilstruct.animstruct.playerpositionents["parent_squad"] scriptmodelplayanim("wz_infil_mindia8_loop_genpropx10", "prop");

    if(istrue(level._id_F84366B8FDD80CF2))
      level waittill("play_video_complete");

    level.infilstruct.animstruct._id_D40A73AF6AC75726 notify("start_moving");

    if(istrue(level._id_F84366B8FDD80CF2))
      wait 3.5;
  }

  level.infilstruct.animstruct._id_DF521449D9601357 hide();
  level.infilstruct.animstruct._id_B0FFA16EB57B1EA1 hide();
  setomnvar("ui_hide_player_icons", 0);
  setomnvar("ui_in_infil", 2);
  level thread _id_C6CEDF68AFE4E839();
}

_id_9441CFEE5F114846() {
  if(istrue(level._id_F84366B8FDD80CF2))
    level waittill("play_video_complete");

  self notify("infil_move");
}

infil_light_dvars() {
  level endon("cleanupInfil");
  _id_C3ED855FE7C983E3 = getdvarfloat("sm_spotDistCull");
  _id_1800E53D66415E2D = getdvarint("sm_spotUpdateLimit");
  _id_5506432D2291C178 = getdvarint("sm_roundRobinPrioritySpotShadows");
  _id_488F9B9FE1EAD0A6 = getdvarfloat("sm_sunSampleSizeNear");
  _id_64224ECF1E2975D9 = getdvarint("cg_brcircleenableoutsidevisionset");
  _id_8A123774D2925E5D = getdvarint("dvar_27D9CB2953410E87");
  _id_99598B81BA0F7519 = getdvarfloat("dvar_A589D43A51D526DF");
  setDvar("sm_spotDistCull", 1000.0);
  setDvar("sm_spotUpdateLimit", 8);
  setDvar("sm_roundRobinPrioritySpotShadows", 8);
  setDvar("sm_sunSampleSizeNear", 0.25);
  setDvar("cg_brcircleenableoutsidevisionset", 0);
  setDvar("dvar_27D9CB2953410E87", 1);
  setDvar("dvar_A589D43A51D526DF", 0.15);
  scripts\engine\utility::waittill_either("infil_reset_light_dvars", "stopScene");
  setDvar("sm_spotDistCull", _id_C3ED855FE7C983E3);
  setDvar("sm_spotUpdateLimit", _id_1800E53D66415E2D);
  setDvar("sm_roundRobinPrioritySpotShadows", _id_5506432D2291C178);
  setDvar("sm_sunSampleSizeNear", _id_488F9B9FE1EAD0A6);
  setDvar("cg_brcircleenableoutsidevisionset", _id_64224ECF1E2975D9);
  setDvar("dvar_27D9CB2953410E87", _id_8A123774D2925E5D);
  setDvar("dvar_A589D43A51D526DF", _id_99598B81BA0F7519);
}

delaystreamtomovingplane() {
  self endon("stopScene");
  level endon("cleanupInfil");

  if(isDefined(self._id_D40A73AF6AC75726)) {
    _id_74B5B12BB6514385 = getdvarint("dvar_D01D0472D843D39E", 8);
    wait(_id_74B5B12BB6514385);

    if(!isDefined(self._id_D40A73AF6AC75726)) {
      return;
    }
    _id_11F3B4465C8B637B = self._id_D40A73AF6AC75726.origin;
    forward = getdvarint("dvar_7ABCDA2D7AABBE4C", 0);

    if(forward > 0) {
      dir = anglesToForward(self._id_D40A73AF6AC75726.angles);
      _id_11F3B4465C8B637B = self._id_D40A73AF6AC75726.origin + dir * forward;
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
  if(isDefined(self._id_D40A73AF6AC75726) && getdvarint("dvar_EB8A05AFA7735E5F", 1) == 1) {
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

_id_5901CD0BE722F86A() {
  _id_D788FBB04A7A099D = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("br_infil_intro");

  foreach(player in level.infilstruct.players) {
    if(!isDefined(player)) {
      continue;
    }
    player setentitysoundcontext("lobby_fade", "", 2);
    player playlocalsound("br_heli_infil_part1_lr");
    player clearsoundsubmix("mp_br_lobby_fade", 1.5);
    player setsoundsubmix("solo_cin_igc_music", 0.5);
    player setplayermusicstate(_id_D788FBB04A7A099D);
  }
}

_id_39C2CF6576478D41() {
  level thread setsoundsubmixfadetoblackamb();
}

setsoundsubmixfadetoblackamb(players) {
  level endon("cleanupInfil");

  if(!istrue(level._id_F84366B8FDD80CF2))
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
    return ["wz_infil_mindia8_jump_genpropx10", level._id_1A209BD995A7FA83["wz_infil_mindia8_jump_genpropx10"], "wz_infil_mindia8_jump01_pl01", _id_8E3AFD40D3C95B46];

  if(_id_ED451F0EA36C48C6 > _id_C29AC1B887131D03)
    return ["wz_infil_mindia8_jump_genpropx10_90_l", level._id_1A209BD995A7FA83["wz_infil_mindia8_jump_genpropx10_90_l"], "wz_infil_mindia8_jump01_pl01_90_l", _id_8E3AFD40D3C95B46];
  else if(_id_ED451F0EA36C48C6 < -1.0 * _id_C29AC1B887131D03)
    return ["wz_infil_mindia8_jump_genpropx10_90_r", level._id_1A209BD995A7FA83["wz_infil_mindia8_jump_genpropx10_90_r"], "wz_infil_mindia8_jump01_pl01_90_r", _id_8E3AFD40D3C95B46];
  else if(_id_ED451F0EA36C48C6 > 0.0)
    return ["wz_infil_mindia8_jump_genpropx10_180_l", level._id_1A209BD995A7FA83["wz_infil_mindia8_jump_genpropx10_180_l"], "wz_infil_mindia8_jump01_pl01_180_l", _id_8E3AFD40D3C95B46];
  else
    return ["wz_infil_mindia8_jump_genpropx10_180_r", level._id_1A209BD995A7FA83["wz_infil_mindia8_jump_genpropx10_180_r"], "wz_infil_mindia8_jump01_pl01_180_r", _id_8E3AFD40D3C95B46];
}

_id_B766175A1F0EEB13(_id_C7F46EF27D351CD0, movetime) {
  level endon("game_ended");
  self endon("death");
  self hide();

  if(isDefined(self.innards))
    self.innards hide();

  self waittill("start_moving");
  self show();

  if(isDefined(self.innards))
    self.innards show();

  self moveTo(_id_C7F46EF27D351CD0, movetime);
  thread _id_45B2B4A889E633FA::killaftertime(movetime, "c130");
  self playLoopSound("br_heli_infil_hero_lp");
}