/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_infils_ac130.gsc
****************************************************/

init() {
  if(getdvarint("dvar_2BE93DD484220A45", 0))
    level.infilstruct._id_FD05DC031A2E7283 = "shadow::veh9_mil_air_cargo_plane_exterior_infil";
  else if(getdvarint("dvar_F8DC051F831D715F", 0))
    level.infilstruct._id_FD05DC031A2E7283 = "veh9_mil_air_cargo_plane_exterior_infil_green";
  else
    level.infilstruct._id_FD05DC031A2E7283 = "black::veh9_mil_air_cargo_plane_exterior_infil";

  level.infilstruct._id_30E653E12F358438 = "veh9_mil_air_cargo_plane_interior_infil";
  level.infilstruct._id_C3A4F4442070A8B5 = "tag_body_animate";
  scripts\engine\utility::delaythread(0.05, _id_0930A1E7BD882C1D::_id_C880EDBA9FACE762, "ac130");
  level.infilstruct._id_B381E33E977DA440 = ::_id_55F2480B4B819AEA;
  level.infilstruct._id_AE9E4023110ACC6E = ::_id_AD4A7A73C7D7D9E0;
  level.infilstruct._id_8D5C19A9B693E913 = ::_id_8D5C19A9B693E913;
  level.infilstruct._id_DC0BC83A31193177 = ::_id_DC0BC83A31193177;
  level.infilstruct._id_012C912EE9672FA1 = 1;
  level.infilstruct._id_EB0E85A583F21B9D = 1;
  level.infilstruct._id_7A96307B6A7ED797 = "veh_br_infil_c17_distant_lp";
  _id_1809E16510055E87 = ["cam_orbit_br_infil_ac130_player1", "cam_orbit_br_infil_ac130_player2", "cam_orbit_br_infil_ac130_player3", "cam_orbit_br_infil_ac130_player4", "cam_orbit_br_infil_ac130_player1"];
  _id_0930A1E7BD882C1D::_id_226E337633A44059(_id_1809E16510055E87);
  _id_0930A1E7BD882C1D::_id_AD12D29D41483E8A("prematch", ::_id_CD7E1A37D5E2CA2B);
  _id_0930A1E7BD882C1D::_id_AD12D29D41483E8A("fadedown", ::_id_026874FD7694AA29);
  game["dialog"]["infil_ac130_30_seconds"] = "dx_br_dmzc_infl_wzpl_drop";
  game["dialog"]["infil_ac130_5_seconds"] = "dx_br_dmzc_infl_ldms_drop";
}

_id_9AFDEAB1E38DAC18(animstruct, _id_46B59AA03461A82E) {
  if(isDefined(animstruct.staticc130))
    _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct.staticc130, _id_46B59AA03461A82E);

  if(isDefined(animstruct.movingc130))
    _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct.movingc130, _id_46B59AA03461A82E);
}

_id_55F2480B4B819AEA(movingc130) {
  animstruct = spawnStruct();
  animstruct.origin = getdvarvector("br_infil_anim_pos", (0, 0, 0));
  animstruct.angles = (0, 0, 0);
  animstruct._id_7A2AF7FE0EF35BAA = getdvarint("dvar_4EE80A43D1C50CA2", 1);
  animstruct._id_03772737101AA4AF = level._id_2655050B4D075E87;
  animstruct.cleanupfunc = ::_id_72145194F4F38714;
  animstruct._id_AB8494260B910B51 = ::_id_52BEDAE2CED8E191;
  animstruct.movingc130 = movingc130;

  if(isDefined(animstruct.movingc130)) {
    animstruct.movingc130.animname = "movingC130";
    animstruct.movingc130.innards.animname = "movingC130";
    animstruct.movingc130.animstruct = animstruct;
    animstruct.movingc130._id_6A704063A0555C1D = 1;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("br_infils_ac130", "getAnimStruct"))
    animstruct = [[scripts\cp_mp\utility\script_utility::getsharedfunc("br_infils_ac130", "getAnimStruct")]](animstruct);
  else {
    _id_B870E891EE0D664F = scripts\engine\utility::ter_op(isDefined(level._id_47CF6FF6443DBDF4), level._id_47CF6FF6443DBDF4, "infil_ac130_exterior");
    animstruct.staticc130 = getEnt(_id_B870E891EE0D664F, "targetname");

    if(isDefined(animstruct.staticc130)) {
      animstruct.staticc130 show();
      animstruct.staticc130.animname = "c130";
      animstruct.staticc130._id_662EFE6105E9F585 = 1;
    } else
      animstruct.staticc130 = animstruct _id_0930A1E7BD882C1D::spawn_script_model("black::veh9_mil_air_cargo_plane_exterior_infil", "c130");

    animstruct.staticc130._id_6A704063A0555C1D = 1;
    animstruct._id_E73CE295AE9D4104 = animstruct _id_0930A1E7BD882C1D::spawn_script_model("generic_prop_x30", "camera");
    animstruct._id_E73CE295AE9D4104 linkTo(animstruct.staticc130, "tag_body_animate", (0, 0, 0), (0, 0, 0));

    if(getdvarint("dvar_F8DC051F831D715F", 0))
      animstruct._id_6F8BCD4A2212597D = animstruct _id_0930A1E7BD882C1D::spawn_script_model("veh9_mil_air_cargo_plane_exterior_infil_green", "introPlane");
    else
      animstruct._id_6F8BCD4A2212597D = animstruct _id_0930A1E7BD882C1D::spawn_script_model("black::veh9_mil_air_cargo_plane", "introPlane");

    animstruct._id_6F8BCD4A2212597D linkTo(animstruct._id_E73CE295AE9D4104, "j_prop_30");
    _id_37DF38D20E12F77D = ["milsim_western_a", "milsim_western_b", "milsim_western_c", "milsim_western_d", "milsim_eastern_a", "milsim_eastern_b", "milsim_eastern_c", "milsim_eastern_d"];
    animstruct._id_0B50860E78D9E1E5 = [];
    animstruct._id_0B50860E78D9E1E5[0] = animstruct _id_0930A1E7BD882C1D::spawn_script_model("tag_player", "playerTag1");
    animstruct._id_0B50860E78D9E1E5[1] = animstruct _id_0930A1E7BD882C1D::spawn_script_model("tag_player", "playerTag2");
    animstruct._id_0B50860E78D9E1E5[2] = animstruct _id_0930A1E7BD882C1D::spawn_script_model("tag_player", "playerTag3");
    animstruct._id_0B50860E78D9E1E5[3] = animstruct _id_0930A1E7BD882C1D::spawn_script_model("tag_player", "playerTag4");
    animstruct._id_0B50860E78D9E1E5[4] = animstruct _id_0930A1E7BD882C1D::spawn_script_model("tag_player", "playerTag5");
    animstruct._id_0B50860E78D9E1E5[0] linkTo(animstruct._id_E73CE295AE9D4104, "j_prop_2", (0, 0, 0), (0, 0, 0));
    animstruct._id_0B50860E78D9E1E5[1] linkTo(animstruct._id_E73CE295AE9D4104, "j_prop_3", (0, 0, 0), (0, 0, 0));
    animstruct._id_0B50860E78D9E1E5[2] linkTo(animstruct._id_E73CE295AE9D4104, "j_prop_4", (0, 0, 0), (0, 0, 0));
    animstruct._id_0B50860E78D9E1E5[3] linkTo(animstruct._id_E73CE295AE9D4104, "j_prop_5", (0, 0, 0), (0, 0, 0));
    animstruct._id_0B50860E78D9E1E5[4] linkTo(animstruct._id_E73CE295AE9D4104, "j_prop_15", (0, 0, 0), (0, 0, 0));
    animstruct._id_A552EC61E51ECE6E = [];
    animstruct._id_A552EC61E51ECE6E[0] = animstruct _id_0930A1E7BD882C1D::spawn_script_model("fullbody_usmc_ar_br_infil", "player1");
    animstruct._id_A552EC61E51ECE6E[1] = animstruct _id_0930A1E7BD882C1D::spawn_script_model("fullbody_usmc_ar_br_infil", "player2");
    animstruct._id_A552EC61E51ECE6E[2] = animstruct _id_0930A1E7BD882C1D::spawn_script_model("fullbody_usmc_ar_br_infil", "player3");
    animstruct._id_A552EC61E51ECE6E[3] = animstruct _id_0930A1E7BD882C1D::spawn_script_model("fullbody_usmc_ar_br_infil", "player4");
    animstruct._id_A552EC61E51ECE6E[4] = animstruct _id_0930A1E7BD882C1D::spawn_script_model("fullbody_usmc_ar_br_infil", "player5");
    animstruct._id_A552EC61E51ECE6E[0] linkTo(animstruct._id_0B50860E78D9E1E5[0], "tag_player", (0, 0, 0), (0, 0, 0));
    animstruct._id_A552EC61E51ECE6E[1] linkTo(animstruct._id_0B50860E78D9E1E5[1], "tag_player", (0, 0, 0), (0, 0, 0));
    animstruct._id_A552EC61E51ECE6E[2] linkTo(animstruct._id_0B50860E78D9E1E5[2], "tag_player", (0, 0, 0), (0, 0, 0));
    animstruct._id_A552EC61E51ECE6E[3] linkTo(animstruct._id_0B50860E78D9E1E5[3], "tag_player", (0, 0, 0), (0, 0, 0));
    animstruct._id_A552EC61E51ECE6E[4] linkTo(animstruct._id_0B50860E78D9E1E5[4], "tag_player", (0, 0, 0), (0, 0, 0));
    _id_D84AAA47282D5918 = scripts\engine\utility::array_randomize(_id_37DF38D20E12F77D);
    animstruct._id_A552EC61E51ECE6E[0] _id_66B13900C5013DE5(_id_D84AAA47282D5918[0]);
    animstruct._id_A552EC61E51ECE6E[1] _id_66B13900C5013DE5(_id_D84AAA47282D5918[1]);
    animstruct._id_A552EC61E51ECE6E[2] _id_66B13900C5013DE5(_id_D84AAA47282D5918[2]);
    animstruct._id_A552EC61E51ECE6E[3] _id_66B13900C5013DE5(_id_D84AAA47282D5918[3]);
    animstruct._id_A552EC61E51ECE6E[4] _id_66B13900C5013DE5(_id_D84AAA47282D5918[4]);
    animstruct.crates = [];
    animstruct.crates[0] = animstruct _id_0930A1E7BD882C1D::spawn_script_model("military_carepackage_03_br", "crate1");
    animstruct.crates[0] linkTo(animstruct._id_E73CE295AE9D4104, "j_prop_8", (0, 0, 0), (0, 0, 0));
    animstruct._id_2668FB5D52D6438D = [];
    animstruct._id_2668FB5D52D6438D[0] = animstruct _id_0930A1E7BD882C1D::spawn_script_model("fullbody_usmc_ar_br_infil", "npc1");
    animstruct._id_2668FB5D52D6438D[1] = animstruct _id_0930A1E7BD882C1D::spawn_script_model("fullbody_usmc_ar_br_infil", "npc2");
    animstruct._id_2668FB5D52D6438D[2] = animstruct _id_0930A1E7BD882C1D::spawn_script_model("fullbody_usmc_ar_br_infil", "npc3");
    animstruct._id_2668FB5D52D6438D[3] = animstruct _id_0930A1E7BD882C1D::spawn_script_model("fullbody_usmc_ar_br_infil", "npc4");
    animstruct._id_2668FB5D52D6438D[4] = animstruct _id_0930A1E7BD882C1D::spawn_script_model("fullbody_usmc_ar_br_infil", "npc5");
    animstruct._id_2668FB5D52D6438D[5] = animstruct _id_0930A1E7BD882C1D::spawn_script_model("fullbody_usmc_ar_br_infil", "npc6");
    animstruct._id_2668FB5D52D6438D[0] linkTo(animstruct._id_E73CE295AE9D4104, "j_prop_9", (0, 0, 0), (0, 0, 0));
    animstruct._id_2668FB5D52D6438D[1] linkTo(animstruct._id_E73CE295AE9D4104, "j_prop_10", (0, 0, 0), (0, 0, 0));
    animstruct._id_2668FB5D52D6438D[2] linkTo(animstruct._id_E73CE295AE9D4104, "j_prop_11", (0, 0, 0), (0, 0, 0));
    animstruct._id_2668FB5D52D6438D[3] linkTo(animstruct._id_E73CE295AE9D4104, "j_prop_12", (0, 0, 0), (0, 0, 0));
    animstruct._id_2668FB5D52D6438D[4] linkTo(animstruct._id_E73CE295AE9D4104, "j_prop_13", (0, 0, 0), (0, 0, 0));
    animstruct._id_2668FB5D52D6438D[5] linkTo(animstruct._id_E73CE295AE9D4104, "j_prop_14", (0, 0, 0), (0, 0, 0));
    _id_D84AAA47282D5918 = scripts\engine\utility::array_randomize(_id_37DF38D20E12F77D);
    animstruct._id_2668FB5D52D6438D[0] _id_66B13900C5013DE5(_id_D84AAA47282D5918[0]);
    animstruct._id_2668FB5D52D6438D[1] _id_66B13900C5013DE5(_id_D84AAA47282D5918[1]);
    animstruct._id_2668FB5D52D6438D[2] _id_66B13900C5013DE5(_id_D84AAA47282D5918[2]);
    animstruct._id_2668FB5D52D6438D[3] _id_66B13900C5013DE5(_id_D84AAA47282D5918[3]);
    animstruct._id_2668FB5D52D6438D[4] _id_66B13900C5013DE5(_id_D84AAA47282D5918[4]);
    animstruct._id_2668FB5D52D6438D[5] _id_66B13900C5013DE5(_id_D84AAA47282D5918[5]);
    animstruct.packs = [];
    n = 0;
    _id_E92AED86E7DD8B76 = 10.0;
    _id_630E1DFE2A5B41CA = 10.0;
    _id_92C2F39ADF1C2E62 = 0;
    animstruct.packs[n] = animstruct _id_0930A1E7BD882C1D::create_animpack("scene0.0");
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_startfunc([_id_E92AED86E7DD8B76, _id_630E1DFE2A5B41CA, _id_92C2F39ADF1C2E62], ::_id_1A124E836E45482C);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_E73CE295AE9D4104, level._id_1A209BD995A7FA83["wz_infil_g_prop_sh000"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_6F8BCD4A2212597D, level._id_1A209BD995A7FA83["wz_infil_cargoplane_sh000"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[0], level._id_1A209BD995A7FA83["wz_infil_drone_guy1_idle_sh010"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[1], level._id_1A209BD995A7FA83["wz_infil_drone_guy2_idle_sh010"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[2], level._id_1A209BD995A7FA83["wz_infil_drone_guy3_idle_sh010"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[3], level._id_1A209BD995A7FA83["wz_infil_drone_guy4_idle_sh010"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[4], level._id_1A209BD995A7FA83["wz_infil_drone_guy1_idle_sh010"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[0], level._id_1A209BD995A7FA83["wz_infil_drone_guy1_idle_sh010"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[1], level._id_1A209BD995A7FA83["wz_infil_drone_guy2_idle_sh010"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[2], level._id_1A209BD995A7FA83["wz_infil_drone_guy3_idle_sh010"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[3], level._id_1A209BD995A7FA83["wz_infil_drone_guy4_idle_sh010"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[4], level._id_1A209BD995A7FA83["wz_infil_drone_guy1_idle_sh010"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_D4561AB1BA4F5DE9(animstruct._id_E73CE295AE9D4104, "tag_origin", level._id_1A209BD995A7FA83["wz_infil_g_prop_sh000"], "wz_infil_xcam_sh000_quads", ::_id_3AD82A1083BF9FDE);
    animstruct.packs[n]._id_6B5CE0E0E0FA80C3 = ["wz_infil_xcam_sh000_quads", "wz_infil_xcam_sh000_quads", "wz_infil_xcam_sh000_quads", "wz_infil_xcam_sh000_quads"];

    if(!isDefined(level.scr_notetrack["camera"]) || !isDefined(level.scr_notetrack["camera"]["any"]["infil_header_player1"])) {
      scripts\common\anim::addnotetrack_customfunction("camera", "infil_header_player1", ::_id_1A5E2C1CEF16393F);
      scripts\common\anim::addnotetrack_customfunction("camera", "infil_header_player2", ::_id_7797914101C3A342);
      scripts\common\anim::addnotetrack_customfunction("camera", "infil_header_player3", ::_id_E86F60FFD1ABCD75);
      scripts\common\anim::addnotetrack_customfunction("camera", "infil_header_player4", ::_id_A9090D88A8813828);
    }

    n++;
    _id_E92AED86E7DD8B76 = 35.0;
    _id_630E1DFE2A5B41CA = 30.0;
    _id_92C2F39ADF1C2E62 = 0;
    animstruct.packs[n] = animstruct _id_0930A1E7BD882C1D::create_animpack("scene4");
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_startfunc([_id_E92AED86E7DD8B76, _id_630E1DFE2A5B41CA, _id_92C2F39ADF1C2E62], ::_id_0BAF143DBADB3F80);
    animstruct.packs[n] _id_9AFDEAB1E38DAC18(animstruct, level._id_1A209BD995A7FA83["wz_infil_cargoplane_sh040"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_E73CE295AE9D4104, level._id_1A209BD995A7FA83["wz_infil_g_prop_sh040"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[0], level._id_1A209BD995A7FA83["wz_infil_drone_guy1_sh040"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[1], level._id_1A209BD995A7FA83["wz_infil_drone_guy2_sh040"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[2], level._id_1A209BD995A7FA83["wz_infil_drone_guy3_sh040"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[3], level._id_1A209BD995A7FA83["wz_infil_drone_guy4_sh040"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[4], level._id_1A209BD995A7FA83["wz_infil_solowin_guy1_sh040"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[0], level._id_1A209BD995A7FA83["wz_infil_drone_guy1_sh040"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[1], level._id_1A209BD995A7FA83["wz_infil_drone_guy2_sh040"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[2], level._id_1A209BD995A7FA83["wz_infil_drone_guy3_sh040"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[3], level._id_1A209BD995A7FA83["wz_infil_drone_guy4_sh040"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[4], level._id_1A209BD995A7FA83["wz_infil_solowin_guy1_sh040"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct.crates[0], level._id_1A209BD995A7FA83["wz_infil_cargobox_sh040"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[0], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc1_sh040"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[1], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc2_sh040"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[2], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc3_sh040"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[3], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc4_sh040"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[4], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc5_sh040"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[5], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc6_sh040"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_D4561AB1BA4F5DE9(animstruct._id_E73CE295AE9D4104, "tag_origin", level._id_1A209BD995A7FA83["wz_infil_g_prop_sh040"], "wz_infil_xcam_sh040_quads", ::_id_3AD82A1083BF9FDE);
    animstruct.packs[n]._id_6B5CE0E0E0FA80C3 = ["wz_infil_xcam_sh040_solos", "wz_infil_xcam_sh040_solos", "wz_infil_xcam_sh040_quads", "wz_infil_xcam_sh040_quads"];
    n++;
    _id_E92AED86E7DD8B76 = 7.5;
    _id_630E1DFE2A5B41CA = 40.0;
    _id_92C2F39ADF1C2E62 = 0;
    animstruct.packs[n] = animstruct _id_0930A1E7BD882C1D::create_animpack("scene5");
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_startfunc([_id_E92AED86E7DD8B76, _id_630E1DFE2A5B41CA, _id_92C2F39ADF1C2E62], ::_id_9AF898862A8C98B9);
    animstruct.packs[n] _id_9AFDEAB1E38DAC18(animstruct, level._id_1A209BD995A7FA83["wz_infil_cargoplane_sh050"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_E73CE295AE9D4104, level._id_1A209BD995A7FA83["wz_infil_g_prop_sh050"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[0], level._id_1A209BD995A7FA83["wz_infil_drone_guy1_sh050"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[1], level._id_1A209BD995A7FA83["wz_infil_drone_guy2_sh050"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[2], level._id_1A209BD995A7FA83["wz_infil_drone_guy3_sh050"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[3], level._id_1A209BD995A7FA83["wz_infil_drone_guy4_sh050"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[4], level._id_1A209BD995A7FA83["wz_infil_solowin_guy1_sh050"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[0], level._id_1A209BD995A7FA83["wz_infil_drone_guy1_sh050"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[1], level._id_1A209BD995A7FA83["wz_infil_drone_guy2_sh050"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[2], level._id_1A209BD995A7FA83["wz_infil_drone_guy3_sh050"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[3], level._id_1A209BD995A7FA83["wz_infil_drone_guy4_sh050"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[4], level._id_1A209BD995A7FA83["wz_infil_solowin_guy1_sh050"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct.crates[0], level._id_1A209BD995A7FA83["wz_infil_cargobox_sh050"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[0], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc1_sh050"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[1], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc2_sh050"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[2], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc3_sh050"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[3], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc4_sh050"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[4], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc5_sh050"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[5], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc6_sh050"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_D4561AB1BA4F5DE9(animstruct._id_E73CE295AE9D4104, "tag_origin", level._id_1A209BD995A7FA83["wz_infil_g_prop_sh050"], "wz_infil_xcam_sh050_quads", ::_id_3AD82A1083BF9FDE);
    animstruct.packs[n]._id_6B5CE0E0E0FA80C3 = ["wz_infil_xcam_sh050_solos", "wz_infil_xcam_sh050_solos", "wz_infil_xcam_sh050_quads", "wz_infil_xcam_sh050_quads"];
    n++;
    _id_E92AED86E7DD8B76 = 30.0;
    _id_630E1DFE2A5B41CA = 40.0;
    _id_92C2F39ADF1C2E62 = 0;
    animstruct.packs[n] = animstruct _id_0930A1E7BD882C1D::create_animpack("scene6");
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_startfunc([_id_E92AED86E7DD8B76, _id_630E1DFE2A5B41CA, _id_92C2F39ADF1C2E62], ::_id_646B15A1F9A1E55A);
    animstruct.packs[n] _id_9AFDEAB1E38DAC18(animstruct, level._id_1A209BD995A7FA83["wz_infil_cargoplane_sh060"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_E73CE295AE9D4104, level._id_1A209BD995A7FA83["wz_infil_g_prop_sh060"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[0], level._id_1A209BD995A7FA83["wz_infil_drone_guy1_sh060"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[1], level._id_1A209BD995A7FA83["wz_infil_drone_guy2_sh060"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[2], level._id_1A209BD995A7FA83["wz_infil_drone_guy3_sh060"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[3], level._id_1A209BD995A7FA83["wz_infil_drone_guy4_sh060"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[4], level._id_1A209BD995A7FA83["wz_infil_solowin_guy1_sh060"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[0], level._id_1A209BD995A7FA83["wz_infil_drone_guy1_sh060"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[1], level._id_1A209BD995A7FA83["wz_infil_drone_guy2_sh060"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[2], level._id_1A209BD995A7FA83["wz_infil_drone_guy3_sh060"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[3], level._id_1A209BD995A7FA83["wz_infil_drone_guy4_sh060"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[4], level._id_1A209BD995A7FA83["wz_infil_solowin_guy1_sh060"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct.crates[0], level._id_1A209BD995A7FA83["wz_infil_cargobox_sh060"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[0], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc1_sh060"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[1], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc2_sh060"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[2], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc3_sh060"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[3], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc4_sh060"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[4], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc5_sh060"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[5], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc6_sh060"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_D4561AB1BA4F5DE9(animstruct._id_E73CE295AE9D4104, "tag_origin", level._id_1A209BD995A7FA83["wz_infil_g_prop_sh060"], "wz_infil_xcam_sh060_quads", ::_id_3AD82A1083BF9FDE);
    animstruct.packs[n]._id_6B5CE0E0E0FA80C3 = ["wz_infil_xcam_sh060_solos", "wz_infil_xcam_sh060_solos", "wz_infil_xcam_sh060_quads", "wz_infil_xcam_sh060_quads"];
    n++;
    _id_E92AED86E7DD8B76 = 20.0;
    _id_630E1DFE2A5B41CA = 50.0;
    _id_92C2F39ADF1C2E62 = 0;
    animstruct.packs[n] = animstruct _id_0930A1E7BD882C1D::create_animpack("scene7");
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_startfunc([_id_E92AED86E7DD8B76, _id_630E1DFE2A5B41CA, _id_92C2F39ADF1C2E62], ::_id_0A1154BE6E3C8A13);
    animstruct.packs[n] _id_9AFDEAB1E38DAC18(animstruct, level._id_1A209BD995A7FA83["wz_infil_cargoplane_sh070"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_E73CE295AE9D4104, level._id_1A209BD995A7FA83["wz_infil_g_prop_sh070"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[0], level._id_1A209BD995A7FA83["wz_infil_drone_guy1_sh070"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[1], level._id_1A209BD995A7FA83["wz_infil_drone_guy2_sh070"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[2], level._id_1A209BD995A7FA83["wz_infil_drone_guy3_sh070"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[3], level._id_1A209BD995A7FA83["wz_infil_drone_guy4_sh070"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[4], level._id_1A209BD995A7FA83["wz_infil_solowin_guy1_sh070"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[0], level._id_1A209BD995A7FA83["wz_infil_drone_guy1_sh070"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[1], level._id_1A209BD995A7FA83["wz_infil_drone_guy2_sh070"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[2], level._id_1A209BD995A7FA83["wz_infil_drone_guy3_sh070"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[3], level._id_1A209BD995A7FA83["wz_infil_drone_guy4_sh070"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[4], level._id_1A209BD995A7FA83["wz_infil_solowin_guy1_sh070"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct.crates[0], level._id_1A209BD995A7FA83["wz_infil_cargobox_sh070"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[0], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc1_sh070"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[1], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc2_sh070"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[2], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc3_sh070"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[3], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc4_sh070"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[4], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc5_sh070"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[5], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc6_sh070"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_D4561AB1BA4F5DE9(animstruct._id_E73CE295AE9D4104, "tag_origin", level._id_1A209BD995A7FA83["wz_infil_g_prop_sh070"], "wz_infil_xcam_sh070_quads", ::_id_3AD82A1083BF9FDE);
    animstruct.packs[n]._id_6B5CE0E0E0FA80C3 = ["wz_infil_xcam_sh070_solos", "wz_infil_xcam_sh070_solos", "wz_infil_xcam_sh070_quads", "wz_infil_xcam_sh070_quads"];
    n++;
    _id_E92AED86E7DD8B76 = 30.0;
    _id_630E1DFE2A5B41CA = 50.0;
    _id_92C2F39ADF1C2E62 = 0;
    animstruct.packs[n] = animstruct _id_0930A1E7BD882C1D::create_animpack("scene8");
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_startfunc([_id_E92AED86E7DD8B76, _id_630E1DFE2A5B41CA, _id_92C2F39ADF1C2E62], ::_id_5252A2070A63D534);
    animstruct.packs[n] _id_9AFDEAB1E38DAC18(animstruct, level._id_1A209BD995A7FA83["wz_infil_cargoplane_sh080"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_E73CE295AE9D4104, level._id_1A209BD995A7FA83["wz_infil_g_prop_sh080"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[0], level._id_1A209BD995A7FA83["wz_infil_drone_guy1_sh080"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[1], level._id_1A209BD995A7FA83["wz_infil_drone_guy2_sh080"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[2], level._id_1A209BD995A7FA83["wz_infil_drone_guy3_sh080"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[3], level._id_1A209BD995A7FA83["wz_infil_drone_guy4_sh080"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[4], level._id_1A209BD995A7FA83["wz_infil_solowin_guy1_sh080"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[0], level._id_1A209BD995A7FA83["wz_infil_drone_guy1_sh080"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[1], level._id_1A209BD995A7FA83["wz_infil_drone_guy2_sh080"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[2], level._id_1A209BD995A7FA83["wz_infil_drone_guy3_sh080"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[3], level._id_1A209BD995A7FA83["wz_infil_drone_guy4_sh080"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[4], level._id_1A209BD995A7FA83["wz_infil_solowin_guy1_sh080"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct.crates[0], level._id_1A209BD995A7FA83["wz_infil_cargobox_sh080"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[0], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc1_sh080"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[1], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc2_sh080"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[2], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc3_sh080"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[3], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc4_sh080"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[4], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc5_sh080"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[5], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc6_sh080"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_D4561AB1BA4F5DE9(animstruct._id_E73CE295AE9D4104, "tag_origin", level._id_1A209BD995A7FA83["wz_infil_g_prop_sh080"], "wz_infil_xcam_sh080_quads", ::_id_3AD82A1083BF9FDE);
    animstruct.packs[n]._id_6B5CE0E0E0FA80C3 = ["wz_infil_xcam_sh080_solos", "wz_infil_xcam_sh080_solos", "wz_infil_xcam_sh080_quads", "wz_infil_xcam_sh080_quads"];
    n++;
    _id_E92AED86E7DD8B76 = 25.0;
    _id_630E1DFE2A5B41CA = 31.78;
    _id_92C2F39ADF1C2E62 = 1;
    animstruct.packs[n] = animstruct _id_0930A1E7BD882C1D::create_animpack("scene9");
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_startfunc([_id_E92AED86E7DD8B76, _id_630E1DFE2A5B41CA, _id_92C2F39ADF1C2E62], ::_id_6822439C818B5B8D);
    animstruct.packs[n] _id_9AFDEAB1E38DAC18(animstruct, level._id_1A209BD995A7FA83["wz_infil_cargoplane_sh090"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_E73CE295AE9D4104, level._id_1A209BD995A7FA83["wz_infil_g_prop_sh090"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[0], level._id_1A209BD995A7FA83["wz_infil_drone_guy1_sh090"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[1], level._id_1A209BD995A7FA83["wz_infil_drone_guy2_sh090"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[2], level._id_1A209BD995A7FA83["wz_infil_drone_guy3_sh090"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[3], level._id_1A209BD995A7FA83["wz_infil_drone_guy4_sh090"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[4], level._id_1A209BD995A7FA83["wz_infil_solowin_guy1_sh090"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[0], level._id_1A209BD995A7FA83["wz_infil_drone_guy1_sh090"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[1], level._id_1A209BD995A7FA83["wz_infil_drone_guy2_sh090"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[2], level._id_1A209BD995A7FA83["wz_infil_drone_guy3_sh090"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[3], level._id_1A209BD995A7FA83["wz_infil_drone_guy4_sh090"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[4], level._id_1A209BD995A7FA83["wz_infil_solowin_guy1_sh090"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct.crates[0], level._id_1A209BD995A7FA83["wz_infil_cargobox_sh090"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[0], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc1_sh090"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[1], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc2_sh090"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[2], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc3_sh090"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[3], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc4_sh090"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[4], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc5_sh090"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[5], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc6_sh090"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_D4561AB1BA4F5DE9(animstruct._id_E73CE295AE9D4104, "tag_origin", level._id_1A209BD995A7FA83["wz_infil_g_prop_sh090"], "wz_infil_xcam_sh090_quads", ::_id_3AD82A1083BF9FDE);
    animstruct.packs[n]._id_6B5CE0E0E0FA80C3 = ["wz_infil_xcam_sh090_solos", "wz_infil_xcam_sh090_quads", "wz_infil_xcam_sh090_solos", "wz_infil_xcam_sh090_quads"];
    n++;
    _id_E92AED86E7DD8B76 = 20.0;
    _id_630E1DFE2A5B41CA = 17.847;
    _id_92C2F39ADF1C2E62 = 1;
    animstruct.packs[n] = animstruct _id_0930A1E7BD882C1D::create_animpack("scene10");
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_startfunc([_id_E92AED86E7DD8B76, _id_630E1DFE2A5B41CA, _id_92C2F39ADF1C2E62], ::_id_9CFD7CAB1A6E747B);
    animstruct.packs[n] _id_9AFDEAB1E38DAC18(animstruct, level._id_1A209BD995A7FA83["wz_infil_cargoplane_sh100"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_E73CE295AE9D4104, level._id_1A209BD995A7FA83["wz_infil_g_prop_sh100"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[0], level._id_1A209BD995A7FA83["wz_infil_drone_guy1_sh100"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[1], level._id_1A209BD995A7FA83["wz_infil_drone_guy2_sh100"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[2], level._id_1A209BD995A7FA83["wz_infil_drone_guy3_sh100"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[3], level._id_1A209BD995A7FA83["wz_infil_drone_guy4_sh100"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[4], level._id_1A209BD995A7FA83["wz_infil_solowin_guy1_sh100"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[0], level._id_1A209BD995A7FA83["wz_infil_drone_guy1_sh100"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[1], level._id_1A209BD995A7FA83["wz_infil_drone_guy2_sh100"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[2], level._id_1A209BD995A7FA83["wz_infil_drone_guy3_sh100"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[3], level._id_1A209BD995A7FA83["wz_infil_drone_guy4_sh100"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[4], level._id_1A209BD995A7FA83["wz_infil_solowin_guy1_sh100"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct.crates[0], level._id_1A209BD995A7FA83["wz_infil_cargobox_sh100"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[0], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc1_sh100"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[1], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc2_sh100"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[2], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc3_sh100"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[3], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc4_sh100"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[4], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc5_sh100"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[5], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc6_sh100"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_D4561AB1BA4F5DE9(animstruct._id_E73CE295AE9D4104, "tag_origin", level._id_1A209BD995A7FA83["wz_infil_g_prop_sh100"], "wz_infil_xcam_sh100_quads", ::_id_3AD82A1083BF9FDE);
    animstruct.packs[n]._id_6B5CE0E0E0FA80C3 = ["wz_infil_xcam_sh100_solos", "wz_infil_xcam_sh100_quads", "wz_infil_xcam_sh100_solos", "wz_infil_xcam_sh100_quads"];
    n++;
    _id_E92AED86E7DD8B76 = 40.0;
    _id_630E1DFE2A5B41CA = 40.0;
    _id_92C2F39ADF1C2E62 = 0;
    animstruct.packs[n] = animstruct _id_0930A1E7BD882C1D::create_animpack("scene11");
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_startfunc([_id_E92AED86E7DD8B76, _id_630E1DFE2A5B41CA, _id_92C2F39ADF1C2E62], ::_id_2391D520E79F9862);
    animstruct.packs[n] _id_9AFDEAB1E38DAC18(animstruct, level._id_1A209BD995A7FA83["wz_infil_cargoplane_sh110"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_E73CE295AE9D4104, level._id_1A209BD995A7FA83["wz_infil_g_prop_sh110"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[0], level._id_1A209BD995A7FA83["wz_infil_drone_guy1_sh110"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[1], level._id_1A209BD995A7FA83["wz_infil_drone_guy2_sh110"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[2], level._id_1A209BD995A7FA83["wz_infil_drone_guy3_sh110"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[3], level._id_1A209BD995A7FA83["wz_infil_drone_guy4_sh110"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[4], level._id_1A209BD995A7FA83["wz_infil_drone_guy1_sh110"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[0], level._id_1A209BD995A7FA83["wz_infil_drone_guy1_sh110"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[1], level._id_1A209BD995A7FA83["wz_infil_drone_guy2_sh110"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[2], level._id_1A209BD995A7FA83["wz_infil_drone_guy3_sh110"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[3], level._id_1A209BD995A7FA83["wz_infil_drone_guy4_sh110"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[4], level._id_1A209BD995A7FA83["wz_infil_drone_guy1_sh110"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct.crates[0], level._id_1A209BD995A7FA83["wz_infil_cargobox_sh110"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[0], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc1_sh110"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[1], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc2_sh110"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[2], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc3_sh110"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[3], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc4_sh110"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[4], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc5_sh110"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[5], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc6_sh110"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_D4561AB1BA4F5DE9(animstruct._id_E73CE295AE9D4104, "tag_origin", level._id_1A209BD995A7FA83["wz_infil_g_prop_sh110"], "wz_infil_xcam_sh110_quads", ::_id_3AD82A1083BF9FDE);
    animstruct.packs[n]._id_6B5CE0E0E0FA80C3 = ["wz_infil_xcam_sh110_quads", "wz_infil_xcam_sh110_quads", "wz_infil_xcam_sh110_quads", "wz_infil_xcam_sh110_quads"];
    n++;
    _id_E92AED86E7DD8B76 = 45.0;
    _id_630E1DFE2A5B41CA = 45.0;
    _id_92C2F39ADF1C2E62 = 0;
    animstruct.packs[n] = animstruct _id_0930A1E7BD882C1D::create_animpack("scene12");
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_startfunc([_id_E92AED86E7DD8B76, _id_630E1DFE2A5B41CA, _id_92C2F39ADF1C2E62], ::_id_E63AB2E92DDFFAA1);
    animstruct.packs[n] _id_9AFDEAB1E38DAC18(animstruct, level._id_1A209BD995A7FA83["wz_infil_cargoplane_sh120"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_E73CE295AE9D4104, level._id_1A209BD995A7FA83["wz_infil_g_prop_sh120"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[0], level._id_1A209BD995A7FA83["wz_infil_drone_guy1_sh120"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[1], level._id_1A209BD995A7FA83["wz_infil_drone_guy2_sh120"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[2], level._id_1A209BD995A7FA83["wz_infil_drone_guy3_sh120"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[3], level._id_1A209BD995A7FA83["wz_infil_drone_guy4_sh120"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[4], level._id_1A209BD995A7FA83["wz_infil_drone_guy1_sh120"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[0], level._id_1A209BD995A7FA83["wz_infil_drone_guy1_sh120"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[1], level._id_1A209BD995A7FA83["wz_infil_drone_guy2_sh120"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[2], level._id_1A209BD995A7FA83["wz_infil_drone_guy3_sh120"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[3], level._id_1A209BD995A7FA83["wz_infil_drone_guy4_sh120"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[4], level._id_1A209BD995A7FA83["wz_infil_drone_guy1_sh120"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct.crates[0], level._id_1A209BD995A7FA83["wz_infil_cargobox_sh120"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[0], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc1_sh120"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[1], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc2_sh120"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[2], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc3_sh120"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[3], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc4_sh120"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[4], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc5_sh120"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[5], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc6_sh120"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_D4561AB1BA4F5DE9(animstruct._id_E73CE295AE9D4104, "tag_origin", level._id_1A209BD995A7FA83["wz_infil_g_prop_sh120"], "wz_infil_xcam_sh120_quads", ::_id_3AD82A1083BF9FDE);
    animstruct.packs[n]._id_6B5CE0E0E0FA80C3 = ["wz_infil_xcam_sh120_quads", "wz_infil_xcam_sh120_quads", "wz_infil_xcam_sh120_quads", "wz_infil_xcam_sh120_quads"];
    _id_E92AED86E7DD8B76 = 45.0;
    _id_630E1DFE2A5B41CA = 45.0;
    _id_92C2F39ADF1C2E62 = 0;
    n++;
    animstruct.packs[n] = animstruct _id_0930A1E7BD882C1D::create_animpack("looping", 1);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_startfunc([_id_E92AED86E7DD8B76, _id_630E1DFE2A5B41CA, _id_92C2F39ADF1C2E62], ::_id_F90E2DB4B34D7F57);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_E718BA63D511FCDE([], ::_id_60240BEEDE5E1AB8);
    animstruct.packs[n] _id_9AFDEAB1E38DAC18(animstruct, level._id_1A209BD995A7FA83["wz_infil_cargoplane_idle_sh010"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_E73CE295AE9D4104, level._id_1A209BD995A7FA83["wz_infil_g_prop_idle_sh010"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[0], level._id_1A209BD995A7FA83["wz_infil_drone_guy1_idle_sh010"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[1], level._id_1A209BD995A7FA83["wz_infil_drone_guy2_idle_sh010"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[2], level._id_1A209BD995A7FA83["wz_infil_drone_guy3_idle_sh010"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[3], level._id_1A209BD995A7FA83["wz_infil_drone_guy4_idle_sh010"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[4], level._id_1A209BD995A7FA83["wz_infil_drone_guy1_idle_sh010"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[0], level._id_1A209BD995A7FA83["wz_infil_drone_guy1_idle_sh010"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[1], level._id_1A209BD995A7FA83["wz_infil_drone_guy2_idle_sh010"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[2], level._id_1A209BD995A7FA83["wz_infil_drone_guy3_idle_sh010"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[3], level._id_1A209BD995A7FA83["wz_infil_drone_guy4_idle_sh010"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_F7FC8B110C478968(animstruct._id_A552EC61E51ECE6E[4], level._id_1A209BD995A7FA83["wz_infil_drone_guy1_idle_sh010"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[0], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc1idle_sh010"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[1], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc2idle_sh010"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[2], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc3idle_sh010"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[3], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc4idle_sh010"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[4], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc5idle_sh010"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::add_pack_modelanim(animstruct._id_2668FB5D52D6438D[5], level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc6idle_sh010"]);
    animstruct.packs[n] _id_0930A1E7BD882C1D::_id_D4561AB1BA4F5DE9(animstruct._id_E73CE295AE9D4104, ::_id_E128261218FAFDAA);
  }

  return animstruct;
}

_id_CC1B64E82FD4680C(players) {
  teams = [];

  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }
    if(!isDefined(teams[player.team]))
      teams[player.team] = [];

    teams[player.team][teams[player.team].size] = player;
  }

  return teams;
}

_id_F3AE4B41DF047BA0(array) {
  _id_64BE57CF259833DE = 0;
  _id_E92AED86E7DD8B76 = undefined;
  _id_630E1DFE2A5B41CA = undefined;
  _id_92C2F39ADF1C2E62 = 0;

  if(isDefined(array) && array.size >= 2 && isnumber(array[0]) && isnumber(array[1])) {
    _id_64BE57CF259833DE = 1;
    _id_E92AED86E7DD8B76 = array[0];
    _id_630E1DFE2A5B41CA = array[1];
  }

  if(isDefined(array) && array.size >= 3)
    _id_92C2F39ADF1C2E62 = array[2];

  pack = self._id_2739B8C6B038BA5E;
  pack._id_92C2F39ADF1C2E62 = _id_92C2F39ADF1C2E62;
  _id_E49A1C04AC964563 = 0;
  _id_1FF908A48D4DC0D3 = 4;
  _id_0930A1E7BD882C1D::_id_583F118C4064CA21(level.infilstruct.players);
  teams = _id_CC1B64E82FD4680C(level.infilstruct.players);

  foreach(team, players in teams) {
    numplayers = players.size;

    if(_id_E49A1C04AC964563)
      numplayers = _id_1FF908A48D4DC0D3;

    _id_F5B09A636E6E3153 = [1, 2, 3, 4];

    if(isDefined(level._id_CA06425E37AF610C))
      _id_F5B09A636E6E3153 = [[level._id_CA06425E37AF610C]](numplayers, _id_92C2F39ADF1C2E62);
    else if(numplayers == 1)
      _id_F5B09A636E6E3153 = [5];
    else if(numplayers == 2) {
      if(_id_92C2F39ADF1C2E62)
        _id_F5B09A636E6E3153 = [1, 4];
      else
        _id_F5B09A636E6E3153 = [5, 4];
    } else if(_id_92C2F39ADF1C2E62 && numplayers == 3)
      _id_F5B09A636E6E3153 = [5, 2, 3, 4];

    _id_D12A341B40354143 = 0;

    foreach(player in players) {
      player.infilanimindex = _id_F5B09A636E6E3153[_id_D12A341B40354143 % _id_F5B09A636E6E3153.size];
      player._id_DB122A8941DFEE14 = numplayers;
      _id_D12A341B40354143++;
    }

    if(_id_64BE57CF259833DE) {
      _id_69FF9B8BE936AC16 = _id_630E1DFE2A5B41CA;

      if(_id_92C2F39ADF1C2E62 && numplayers == 2)
        _id_69FF9B8BE936AC16 = _id_630E1DFE2A5B41CA;
      else if(_id_92C2F39ADF1C2E62 && numplayers == 3)
        _id_69FF9B8BE936AC16 = _id_E92AED86E7DD8B76;
      else if(numplayers < 3)
        _id_69FF9B8BE936AC16 = _id_E92AED86E7DD8B76;

      foreach(player in players) {
        player setclientdvar("cg_fov", _id_69FF9B8BE936AC16);
        player setclientdvar("cg_disable_user_fov", 1);
      }
    }
  }

  if(_id_E49A1C04AC964563) {
    pack._id_A39842BCDFC531C2 = 1;
    pack._id_3BD5282B118D27F8 = scripts\engine\utility::array_removeundefined(pack._id_3BD5282B118D27F8);

    if(pack._id_3BD5282B118D27F8.size >= 5) {
      foreach(_id_10727DCC51C74547 in pack._id_3BD5282B118D27F8)
      _id_10727DCC51C74547 hide();

      if(_id_1FF908A48D4DC0D3 == 1) {
        pack._id_3BD5282B118D27F8[4] show();
        return;
      }

      if(_id_1FF908A48D4DC0D3 == 2) {
        if(_id_92C2F39ADF1C2E62) {
          pack._id_3BD5282B118D27F8[0] show();
          pack._id_3BD5282B118D27F8[3] show();
          return;
        }

        pack._id_3BD5282B118D27F8[4] show();
        pack._id_3BD5282B118D27F8[3] show();
        return;
        return;
      }

      if(_id_1FF908A48D4DC0D3 == 3) {
        if(_id_92C2F39ADF1C2E62) {
          pack._id_3BD5282B118D27F8[4] show();
          pack._id_3BD5282B118D27F8[1] show();
          pack._id_3BD5282B118D27F8[2] show();
          return;
        }

        pack._id_3BD5282B118D27F8[0] show();
        pack._id_3BD5282B118D27F8[1] show();
        pack._id_3BD5282B118D27F8[2] show();
        return;
        return;
      }

      pack._id_3BD5282B118D27F8[0] show();
      pack._id_3BD5282B118D27F8[1] show();
      pack._id_3BD5282B118D27F8[2] show();
      pack._id_3BD5282B118D27F8[3] show();
      return;
      return;
      return;
    } else if(pack._id_3BD5282B118D27F8.size >= 4) {
      _id_2246D8F267E2C3DE = 0;

      foreach(_id_10727DCC51C74547 in pack._id_3BD5282B118D27F8) {
        if(_id_2246D8F267E2C3DE < _id_1FF908A48D4DC0D3) {
          _id_10727DCC51C74547 show();
          continue;
        }

        _id_10727DCC51C74547 hide();
      }
    }
  }
}

_id_0A0D0E8089BFD149(_id_847D2A046CAA4B54) {
  if(isDefined(self.staticc130))
    self[[_id_847D2A046CAA4B54]](self.staticc130);

  if(isDefined(self.movingc130))
    self[[_id_847D2A046CAA4B54]](self.movingc130);
}

_id_7F4BBC61AD158330(c130) {
  c130 show();

  if(isDefined(c130.innards))
    c130.innards show();
}

_id_6C267F4C5A7845AE(c130) {
  _id_2995A4F619ED836F = scripts\engine\utility::ter_op(scripts\cp_mp\utility\game_utility::isnightmap(), "running_lights_pm", "running_lights");
  c130 setscriptablepartstate(_id_2995A4F619ED836F, "on");
}

_id_C53EC4FA5D1E2EAE(teams, _id_06D317D76597942A) {
  foreach(team, players in teams) {
    sounds = _id_06D317D76597942A[players.size - 1];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < players.size; _id_AC0E594AC96AA3A8++) {
      alias = sounds[_id_AC0E594AC96AA3A8];

      if(isstring(alias) && alias != "")
        _id_7AB5B649FA408138::_id_7ACDE5FEB50C98F2(players, alias);
    }
  }
}

_id_6913BD6620C40D4C() {
  _id_0CE07A0A6D5C4501 = scripts\engine\utility::ter_op(isDefined(level._id_5621A5132074DA11), level._id_5621A5132074DA11, "mp_saba_infil_exterior");
  self visionsetnakedforplayer(_id_0CE07A0A6D5C4501, 0.0);
  _id_2A5E082B65F82A5C = getdvarint("dvar_7F1DA0C3501CBDF2", 1);

  if(_id_2A5E082B65F82A5C)
    self _meth_451319F93D30EBE5("enum_016737CFA86D4521");
}

_id_1A124E836E45482C(array) {
  _id_F3AE4B41DF047BA0(array);
  _id_0A0D0E8089BFD149(::_id_7F4BBC61AD158330);
  _id_2995A4F619ED836F = scripts\engine\utility::ter_op(scripts\cp_mp\utility\game_utility::isnightmap(), "running_lights_pm", "running_lights");
  self._id_6F8BCD4A2212597D setscriptablepartstate(_id_2995A4F619ED836F, "on");
  _id_0A0D0E8089BFD149(::_id_6C267F4C5A7845AE);
  _id_A98A49377DBBB3FB = getdvarint("dvar_5FD54D13E95394D5", 0);

  if(_id_A98A49377DBBB3FB) {
    setsundirection(anglesToForward((-37, 40, 0)));
    setsuncolorandintensity(0.9294, 0.9608, 1, 0.2);
  }

  _id_D788FBB04A7A099D = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("br_infil_intro");
  _id_6BA6E41C20DC40FA = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("br_infil_intro_classic");
  _id_7AB5B649FA408138::_id_FE75A89529DD0FD0(level.infilstruct.players, _id_D788FBB04A7A099D, undefined, undefined, _id_6BA6E41C20DC40FA);
  level.playedinfilmusic = 1;
  _id_7AB5B649FA408138::_id_7ACDE5FEB50C98F2(level.infilstruct.players, "scn_br_c17_infil_ext");
  thread delaystreamtomovingplane();
  _id_2A5E082B65F82A5C = getdvarint("dvar_7F1DA0C3501CBDF2", 1);
  _id_A90A02071386E840 = getdvarint("dvar_6EFF23C71A0D4B51", 1);

  foreach(player in level.infilstruct.players) {
    if(!isDefined(player)) {
      continue;
    }
    _id_0CE07A0A6D5C4501 = scripts\engine\utility::ter_op(isDefined(level._id_5621A5132074DA11), level._id_5621A5132074DA11, "mp_saba_infil_exterior");
    player visionsetnakedforplayer(_id_0CE07A0A6D5C4501, 0.0);

    if(_id_2A5E082B65F82A5C)
      player _meth_451319F93D30EBE5("enum_016737CFA86D4521");

    if(_id_A90A02071386E840)
      player clearpredictedstreampos();
  }

  _id_DFB3AEFBC657970F();
  _id_441FC5517A189A33();
  _id_A8900020E68C73BC = scripts\engine\utility::get_notetrack_time(level._id_1A209BD995A7FA83["wz_infil_g_prop_sh000"], "fade_to_black_start");
  _id_A8900020E68C73BC = _id_A8900020E68C73BC - scripts\engine\utility::mod(_id_A8900020E68C73BC, 0.05);
  _id_CD1BD4A1058452DA = 0.1;
  scripts\engine\utility::delaythread(_id_A8900020E68C73BC, _id_0930A1E7BD882C1D::_id_EA856EC0B3C4CFC6, _id_CD1BD4A1058452DA, level.infilstruct.players, "sh000");
  _id_0930A1E7BD882C1D::_id_6199C35F4CF4524C(::_id_6913BD6620C40D4C);
}

_id_55E8ECA046DC86E1(c130) {
  c130 show();

  if(isDefined(c130.innards))
    c130.innards show();

  _id_2995A4F619ED836F = scripts\engine\utility::ter_op(scripts\cp_mp\utility\game_utility::isnightmap(), "running_lights_pm", "running_lights");
  c130 setscriptablepartstate(_id_2995A4F619ED836F, "off");
  _id_A98A49377DBBB3FB = getdvarint("dvar_5FD54D13E95394D5", 0);

  if(_id_A98A49377DBBB3FB) {
    resetsundirection();
    resetsunlight();
  }
}

leaderdialog(_id_D653377138D5EFF2) {
  if(!getdvarint("dvar_BFDED00AC93C45B7", 1)) {
    return;
  }
  _id_1499E7C2D69E0074 = 2;

  if(soundexists(_id_D653377138D5EFF2))
    _id_1499E7C2D69E0074 = lookupsoundlength(_id_D653377138D5EFF2, 1) / 1000.0;

  _id_CB3339ECE72DBDEB = game["dialog"][_id_D653377138D5EFF2];

  foreach(player in level.infilstruct.players) {
    if(!isDefined(player)) {
      continue;
    }
    player queuedialogforplayer(_id_CB3339ECE72DBDEB, _id_D653377138D5EFF2, _id_1499E7C2D69E0074);
  }
}

_id_A4A93D249C2219A7() {
  self playlocalsound("scn_br_c17_infil_int");
  _id_372DADA9A76A92A3 = scripts\engine\utility::ter_op(isDefined(level._id_269C8213B2C00D6B), level._id_269C8213B2C00D6B, "mp_saba_infil");
  self visionsetnakedforplayer(_id_372DADA9A76A92A3, 0.0);
  self setclienttriggeraudiozone("br_c17_infil_int", 0.0);
  _id_2A5E082B65F82A5C = getdvarint("dvar_7F1DA0C3501CBDF2", 1);

  if(_id_2A5E082B65F82A5C)
    self _meth_451319F93D30EBE5("enum_1FAE1FA57C3E3922");
}

_id_3D33299E71A25AF0() {
  self._id_6F8BCD4A2212597D hide();
  _id_0A0D0E8089BFD149(::_id_55E8ECA046DC86E1);
  sound = scripts\engine\utility::ter_op(isDefined(level._id_04294E392C776520), level._id_04294E392C776520, "scn_br_c17_infil_int");
  _id_7AB5B649FA408138::_id_7ACDE5FEB50C98F2(level.infilstruct.players, sound);
  teams = _id_CC1B64E82FD4680C(level.infilstruct.players);
  sounds = [];

  if(isDefined(level._id_983AB0DFCD3F73F3) && isDefined(level._id_983AB0DFCD3F73F3["04"]))
    sounds = level._id_983AB0DFCD3F73F3["04"];
  else {
    sounds[0] = ["scn_br_c17_infil_solos_plr1_shot04"];
    sounds[1] = ["scn_br_c17_infil_duos_plr1_shot04", ""];
    sounds[2] = ["scn_br_c17_infil_trios_plr1_shot04", "scn_br_c17_infil_trios_plr2_shot04", "scn_br_c17_infil_trios_plr3_shot04"];
    sounds[3] = ["scn_br_c17_infil_quads_plr1_shot04", "scn_br_c17_infil_quads_plr2_shot04", "scn_br_c17_infil_quads_plr3_shot04", ""];
  }

  _id_C53EC4FA5D1E2EAE(teams, sounds);
  _id_2A5E082B65F82A5C = getdvarint("dvar_7F1DA0C3501CBDF2", 1);

  foreach(player in level.infilstruct.players) {
    if(!isDefined(player)) {
      continue;
    }
    _id_372DADA9A76A92A3 = scripts\engine\utility::ter_op(isDefined(level._id_269C8213B2C00D6B), level._id_269C8213B2C00D6B, "mp_saba_infil");
    player visionsetnakedforplayer(_id_372DADA9A76A92A3, 0.0);
    player setclienttriggeraudiozone("br_c17_infil_int", 0.0);

    if(_id_2A5E082B65F82A5C)
      player _meth_451319F93D30EBE5("enum_1FAE1FA57C3E3922");
  }

  _id_97FDB5E4895E8651();
  _id_1EF7AA0DFF43DA85();
  thread _id_48B6AD7AFC978B6C();
  leaderdialog("infil_ac130_30_seconds");
  _id_0930A1E7BD882C1D::_id_6199C35F4CF4524C(::_id_A4A93D249C2219A7);
}

_id_0BAF143DBADB3F80(array) {
  _id_F3AE4B41DF047BA0(array);
  _id_3D33299E71A25AF0();
  _id_C2419EC768E4CB25 = scripts\engine\utility::get_notetrack_time(level._id_1A209BD995A7FA83["wz_infil_g_prop_sh040"], "fade_to_black_end");
  _id_C2419EC768E4CB25 = _id_C2419EC768E4CB25 + (0.05 - scripts\engine\utility::mod(_id_C2419EC768E4CB25, 0.05));
  _id_1BB7594C18D17443 = 0.65;
  scripts\engine\utility::delaythread(_id_C2419EC768E4CB25, _id_0930A1E7BD882C1D::_id_7F3AD8FE6DF1B8FE, _id_1BB7594C18D17443, level.infilstruct.players, "sh000");
}

_id_9AF898862A8C98B9(array) {
  _id_F3AE4B41DF047BA0(array);
}

_id_646B15A1F9A1E55A(array) {
  _id_F3AE4B41DF047BA0(array);
}

_id_0A1154BE6E3C8A13(array) {
  _id_F3AE4B41DF047BA0(array);
}

_id_5252A2070A63D534(array) {
  _id_F3AE4B41DF047BA0(array);
  teams = _id_CC1B64E82FD4680C(level.infilstruct.players);
  sounds = [];

  if(isDefined(level._id_983AB0DFCD3F73F3) && isDefined(level._id_983AB0DFCD3F73F3["08"]))
    sounds = level._id_983AB0DFCD3F73F3["08"];
  else {
    sounds[0] = ["scn_br_c17_infil_solos_plr1_shot08"];
    sounds[1] = ["scn_br_c17_infil_duos_plr1_shot08", "scn_br_c17_infil_duos_plr2_shot08"];
    sounds[2] = ["scn_br_c17_infil_trios_plr1_shot08", "scn_br_c17_infil_trios_plr2_shot08", "scn_br_c17_infil_trios_plr3_shot08"];
    sounds[3] = ["scn_br_c17_infil_quads_plr1_shot08", "scn_br_c17_infil_quads_plr2_shot08", "scn_br_c17_infil_quads_plr3_shot08", "scn_br_c17_infil_quads_plr4_shot08"];
  }

  _id_C53EC4FA5D1E2EAE(teams, sounds);
}

_id_6822439C818B5B8D(array) {
  _id_F3AE4B41DF047BA0(array);
}

_id_516CC7FCAFADC9CD() {
  self setclienttriggeraudiozone("br_c17_infil_ext", 3.0);
}

_id_9CFD7CAB1A6E747B(array) {
  _id_F3AE4B41DF047BA0(array);

  foreach(player in level.infilstruct.players) {
    if(!isDefined(player)) {
      continue;
    }
    player setclienttriggeraudiozone("br_c17_infil_ext", 3.0);
  }

  _id_0930A1E7BD882C1D::_id_6199C35F4CF4524C(::_id_516CC7FCAFADC9CD);
}

_id_2391D520E79F9862(array) {
  _id_F3AE4B41DF047BA0(array);
  teams = _id_CC1B64E82FD4680C(level.infilstruct.players);
  sounds = [];

  if(isDefined(level._id_983AB0DFCD3F73F3) && isDefined(level._id_983AB0DFCD3F73F3["11"]))
    sounds = level._id_983AB0DFCD3F73F3["11"];
  else {
    sounds[0] = ["scn_br_c17_infil_solos_plr1_shot11"];
    sounds[1] = ["scn_br_c17_infil_duos_plr1_shot11", "scn_br_c17_infil_duos_plr2_shot11"];
    sounds[2] = ["scn_br_c17_infil_trios_plr1_shot11", "scn_br_c17_infil_trios_plr2_shot11", "scn_br_c17_infil_trios_plr3_shot11"];
    sounds[3] = ["scn_br_c17_infil_quads_plr1_shot11", "scn_br_c17_infil_quads_plr2_shot11", "scn_br_c17_infil_quads_plr3_shot11", "scn_br_c17_infil_quads_plr4_shot11"];
  }

  _id_C53EC4FA5D1E2EAE(teams, sounds);
  scripts\engine\utility::delaythread(0.5, ::_id_8FF9139B185CAC31);
}

_id_161DA87DF4150EE8() {
  _id_8CFE7CEDC00FF8D3 = getdvarfloat("dvar_224074CC9CBD34E3", 1.0);
  self visionsetnakedforplayer("", _id_8CFE7CEDC00FF8D3);
  _id_2A5E082B65F82A5C = getdvarint("dvar_7F1DA0C3501CBDF2", 1);

  if(_id_2A5E082B65F82A5C)
    self _meth_0DF8FAD503896462("enum_1FAE1FA57C3E3922");
}

_id_C337548F4B03BDF2() {
  _id_04400D6A8D876BD9 = getdvarfloat("dvar_EF579438C4248057", 3.75);
  _id_8CFE7CEDC00FF8D3 = getdvarfloat("dvar_224074CC9CBD34E3", 1.0);

  if(_id_04400D6A8D876BD9 > 0.0)
    wait(_id_04400D6A8D876BD9);

  _id_2A5E082B65F82A5C = getdvarint("dvar_7F1DA0C3501CBDF2", 1);

  foreach(player in level.infilstruct.players) {
    if(!isDefined(player)) {
      continue;
    }
    player visionsetnakedforplayer("", _id_8CFE7CEDC00FF8D3);

    if(_id_2A5E082B65F82A5C)
      player _meth_0DF8FAD503896462("enum_1FAE1FA57C3E3922");
  }

  scripts\engine\utility::delaythread(1.0, ::_id_F23EDAD7E7A000C5);
  _id_0930A1E7BD882C1D::_id_6199C35F4CF4524C(::_id_161DA87DF4150EE8);
}

_id_D231CA558E0AB75D() {
  wait 3.0;
  _id_7AB5B649FA408138::_id_C79F9300EE85F805(level.players, "solo_cin_igc_music", 3.0);
  wait 3.0;
}

_id_3724B7DF63604071() {
  _id_A8900020E68C73BC = scripts\engine\utility::get_notetrack_time(level._id_1A209BD995A7FA83["wz_infil_g_prop_sh120"], "fade_to_black_start");
  _id_C2419EC768E4CB25 = scripts\engine\utility::get_notetrack_time(level._id_1A209BD995A7FA83["wz_infil_g_prop_sh120"], "fade_to_black_end");
  _id_A8900020E68C73BC = _id_A8900020E68C73BC - scripts\engine\utility::mod(_id_A8900020E68C73BC, 0.05);
  _id_C2419EC768E4CB25 = _id_C2419EC768E4CB25 + (0.05 - scripts\engine\utility::mod(_id_C2419EC768E4CB25, 0.05));
  wait(_id_A8900020E68C73BC);
  _id_0930A1E7BD882C1D::_id_EA856EC0B3C4CFC6(0.066, level.infilstruct.players, "sh120");
  wait(_id_C2419EC768E4CB25 - _id_A8900020E68C73BC);
  _id_0930A1E7BD882C1D::_id_7F3AD8FE6DF1B8FE(0.083, level.infilstruct.players, "sh120");
}

_id_E63AB2E92DDFFAA1(array) {
  _id_F3AE4B41DF047BA0(array);
  level thread _id_D231CA558E0AB75D();
  level thread _id_C337548F4B03BDF2();
  _id_04400D6A8D876BD9 = getdvarfloat("dvar_1968FC42F31E7D28", 3.9);

  if(_id_04400D6A8D876BD9 > 0.0)
    scripts\engine\utility::delaythread(_id_04400D6A8D876BD9, ::_id_5DBA404B985C7D41);
  else
    _id_5DBA404B985C7D41();

  level thread _id_3724B7DF63604071();
  _id_2995A4F619ED836F = scripts\engine\utility::ter_op(scripts\cp_mp\utility\game_utility::isnightmap(), "running_lights_pm", "running_lights");
  self.movingc130 setscriptablepartstate(_id_2995A4F619ED836F, "on");
  leaderdialog("infil_ac130_5_seconds");
}

_id_8FF9139B185CAC31() {
  _id_BFE193D9D13C62DC = getentitylessscriptablearray("air_cargo_light_switch", "targetname");

  foreach(_id_CE483278F59E7C3C in _id_BFE193D9D13C62DC)
  _id_CE483278F59E7C3C setscriptablepartstate("base", "on_green");

  _id_405425B0F7DA50DC = scripts\engine\utility::ter_op(isDefined(level._id_D7C4CC78F9C8BBD6), level._id_D7C4CC78F9C8BBD6, "on");
  self.staticc130 setscriptablepartstate("int_lights_red_all", "off");
  self.staticc130 setscriptablepartstate("int_lights_green_all", _id_405425B0F7DA50DC);
  _id_7AB5B649FA408138::_id_7ACDE5FEB50C98F2(level.players, "scn_br_c17_infil_jump_buzzer");
}

_id_16F307C48E420065() {
  self.movingc130 setscriptablepartstate("int_lights_green_all", "on");
}

_id_97FDB5E4895E8651() {
  _id_BFE193D9D13C62DC = getentitylessscriptablearray("air_cargo_light_switch", "targetname");

  foreach(_id_CE483278F59E7C3C in _id_BFE193D9D13C62DC)
  _id_CE483278F59E7C3C setscriptablepartstate("base", "on_red");

  _id_405425B0F7DA50DC = scripts\engine\utility::ter_op(isDefined(level._id_D7C4CC78F9C8BBD6), level._id_D7C4CC78F9C8BBD6, "on");
  self.staticc130 setscriptablepartstate("int_lights_red_all", _id_405425B0F7DA50DC);
  self.staticc130 setscriptablepartstate("int_lights_green_all", "off");
}

_id_1EF7AA0DFF43DA85() {
  self.movingc130 setscriptablepartstate("int_lights_green_all", "off");
}

_id_DFB3AEFBC657970F() {
  _id_BFE193D9D13C62DC = getentitylessscriptablearray("air_cargo_light_switch", "targetname");

  foreach(_id_CE483278F59E7C3C in _id_BFE193D9D13C62DC)
  _id_CE483278F59E7C3C setscriptablepartstate("base", "off");

  self.staticc130 setscriptablepartstate("int_lights_red_all", "off");
  self.staticc130 setscriptablepartstate("int_lights_green_all", "off");
}

_id_441FC5517A189A33() {
  self.movingc130 setscriptablepartstate("int_lights_green_all", "off");
}

_id_F23EDAD7E7A000C5() {}

_id_F900E49E0584BA57(c130) {}

_id_F90E2DB4B34D7F57(array) {
  _id_F3AE4B41DF047BA0(array);
  _id_F23EDAD7E7A000C5();
}

_id_60240BEEDE5E1AB8(player, array) {}

_id_0A85E9F36F620029(players, index) {
  foreach(player in players) {
    if(isDefined(player.infilanimindex) && player.infilanimindex == index)
      return player;
  }

  return undefined;
}

_id_0406A85847778FB1(index) {
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
    _id_AB823CE7BB33B9AA = undefined;

    if(index == 0) {
      _id_AB823CE7BB33B9AA = _id_0A85E9F36F620029(players, 1);

      if(!isDefined(_id_AB823CE7BB33B9AA))
        _id_AB823CE7BB33B9AA = _id_0A85E9F36F620029(players, 5);
    } else if(index == 1) {
      if(numplayers == 2)
        _id_AB823CE7BB33B9AA = undefined;
      else
        _id_AB823CE7BB33B9AA = _id_0A85E9F36F620029(players, 2);
    } else if(index == 2)
      _id_AB823CE7BB33B9AA = _id_0A85E9F36F620029(players, 3);
    else
      _id_AB823CE7BB33B9AA = _id_0A85E9F36F620029(players, 4);

    _id_5C9DDCF56D36F133 = -1;

    if(isDefined(_id_AB823CE7BB33B9AA))
      _id_5C9DDCF56D36F133 = _id_AB823CE7BB33B9AA getentitynumber();

    foreach(player in players)
    player setclientomnvar("ui_br_infil_exfil_player_focus", _id_5C9DDCF56D36F133);
  }
}

_id_CD7E1A37D5E2CA2B() {
  level.nosuspensemusic = 1;
  thread scripts\mp\music_and_dialog::stopsuspensemusic();
  _id_3B03284FC91EB596 = "mp_gamemode_br_infils";

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("br_infils_ac130", "getInfilSoundbank"))
    _id_3B03284FC91EB596 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("br_infils_ac130", "getInfilSoundbank")]]();

  _id_7AB5B649FA408138::_id_0F1AED36AB4598EA(_id_3B03284FC91EB596);
}

_id_55FB66F4ACB3D466() {
  if(getdvarint("dvar_6EFF23C71A0D4B51", 1)) {
    level.infilstruct._id_2A959F4BA13B75DA = 1;
    waitframe();
    _id_11F3B4465C8B637B = level.infilstruct.c130.animstruct._id_6F8BCD4A2212597D.origin;

    foreach(player in level.players) {
      if(!isDefined(player)) {
        continue;
      }
      player setpredictedstreamloaddist(-1.0);
      player _meth_BC667001F9DD3808(_id_11F3B4465C8B637B);
    }
  }
}

_id_8D050F78FE1D180F() {
  level thread _id_55FB66F4ACB3D466();
  _id_7AB5B649FA408138::_id_4E8BA327EB12540C(level.players, "solo_cin_igc_music", 2.5);
  _func_6F9B54CEA87F1C9E();
  wait 2.5;
  _id_7AB5B649FA408138::_id_C79F9300EE85F805(level.players, "mp_br_lobby_fade", 0.0);
}

_id_026874FD7694AA29() {
  level thread _id_8D050F78FE1D180F();
}

_id_1A5E2C1CEF16393F(camera) {
  _id_0406A85847778FB1(0);
}

_id_7797914101C3A342(camera) {
  _id_0406A85847778FB1(1);
}

_id_E86F60FFD1ABCD75(camera) {
  _id_0406A85847778FB1(2);
}

_id_A9090D88A8813828(camera) {
  _id_0406A85847778FB1(3);
}

_id_72145194F4F38714() {
  _id_3B03284FC91EB596 = "mp_gamemode_br_infils";

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("br_infils_ac130", "getInfilSoundbank"))
    _id_3B03284FC91EB596 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("br_infils_ac130", "getInfilSoundbank")]]();

  _id_7AB5B649FA408138::_id_F4E0FF5CB899686D(_id_3B03284FC91EB596);
  _id_75377E59F5BECAC8::cleanupents();
}

_id_E128261218FAFDAA(player) {
  _id_4A99009E075A9364 = "j_prop_1";
  _id_4FEBD9F54A7E9968 = "j_prop_17";
  _id_1EDD840D40B43222 = _id_4A99009E075A9364;

  if(isDefined(player) && isDefined(player._id_DB122A8941DFEE14)) {
    _id_652F47620AC4713F = player._id_DB122A8941DFEE14;
    _id_92C2F39ADF1C2E62 = 0;

    if(isDefined(self._id_2739B8C6B038BA5E))
      _id_92C2F39ADF1C2E62 = istrue(self._id_2739B8C6B038BA5E._id_92C2F39ADF1C2E62);

    if(_id_92C2F39ADF1C2E62 && _id_652F47620AC4713F == 2)
      _id_1EDD840D40B43222 = _id_4A99009E075A9364;
    else if(_id_92C2F39ADF1C2E62 && _id_652F47620AC4713F == 3)
      _id_1EDD840D40B43222 = _id_4FEBD9F54A7E9968;
    else if(_id_652F47620AC4713F < 3)
      _id_1EDD840D40B43222 = _id_4FEBD9F54A7E9968;
  }

  return _id_1EDD840D40B43222;
}

_id_3AD82A1083BF9FDE(player) {
  if(isDefined(player) && isDefined(player._id_DB122A8941DFEE14))
    return self._id_6B5CE0E0E0FA80C3[player._id_DB122A8941DFEE14 - 1];

  return self._id_6B5CE0E0E0FA80C3[0];
}

_id_AD4A7A73C7D7D9E0() {
  self clearclienttriggeraudiozone(3.0);
  _id_522A77434D41564A = self getplayerangles(1);
  _id_20AF753DED3657E1 = anglesToForward(_id_522A77434D41564A);
  _id_4B52F031A2CBEF8E = anglesToForward(level.infilstruct.c130.angles);
  _id_D8BB89F41AE3D919 = anglestoright(level.infilstruct.c130.angles);
  _id_172D42D175E16C61 = vectordot(_id_20AF753DED3657E1, _id_4B52F031A2CBEF8E);
  _id_ED451F0EA36C48C6 = vectordot(_id_20AF753DED3657E1, _id_D8BB89F41AE3D919);

  if(!isDefined(self.infilanimindex))
    self.infilanimindex = 1;

  infilanimindex = self.infilanimindex;

  if(infilanimindex >= 5)
    infilanimindex = 1;

  _id_8E3AFD40D3C95B46 = "j_prop_" + (infilanimindex + 1);
  _id_C29AC1B887131D03 = cos(45.0);

  if(_id_172D42D175E16C61 < -1.0 * _id_C29AC1B887131D03)
    return ["wz_infil_gprop_standard_sh010", level._id_1A209BD995A7FA83["wz_infil_gprop_standard_sh010"], "wz_infil_standardforward_jump_sh010", _id_8E3AFD40D3C95B46];

  if(_id_ED451F0EA36C48C6 > _id_C29AC1B887131D03)
    return ["wz_infil_gprop_l90_sh010", level._id_1A209BD995A7FA83["wz_infil_gprop_l90_sh010"], "wz_infil_l90_jump_sh010", _id_8E3AFD40D3C95B46];
  else if(_id_ED451F0EA36C48C6 < -1.0 * _id_C29AC1B887131D03)
    return ["wz_infil_gprop_r90_sh010", level._id_1A209BD995A7FA83["wz_infil_gprop_r90_sh010"], "wz_infil_r90_jump_sh010", _id_8E3AFD40D3C95B46];
  else if(_id_ED451F0EA36C48C6 > 0.0)
    return ["wz_infil_gprop_l180_sh010", level._id_1A209BD995A7FA83["wz_infil_gprop_l180_sh010"], "wz_infil_l180_jump_sh010", _id_8E3AFD40D3C95B46];
  else
    return ["wz_infil_gprop_r180_sh010", level._id_1A209BD995A7FA83["wz_infil_gprop_r180_sh010"], "wz_infil_r180_jump_sh010", _id_8E3AFD40D3C95B46];
}

_id_00D99D934D14E73D() {
  self endon("disconnect");
  wait 5;
  _id_2A5E082B65F82A5C = getdvarint("dvar_7F1DA0C3501CBDF2", 1);

  if(_id_2A5E082B65F82A5C)
    self _meth_0DF8FAD503896462("enum_016737CFA86D4521");
}

_id_8D5C19A9B693E913() {
  thread _id_00D99D934D14E73D();

  if(getdvarint("dvar_549DF6AB370A2BC4", 1)) {
    self lerpfovscalefactor(0.0, 0.0);
    self setclientdvar("cg_disable_user_fov", 0);
  }
}

_id_DC0BC83A31193177() {
  self endon("disconnect");
  self lerpfov(65.0, 0.5);

  if(getdvarint("dvar_549DF6AB370A2BC4", 1))
    self lerpfovscalefactor(1.0, 0.5);

  wait 1;

  if(isDefined(self._id_1F0A019572C9F8E2)) {
    self._id_1F0A019572C9F8E2 = undefined;
    self disablephysicaldepthoffieldscripting();
  }

  self setclientdvar("cg_fov", 65.0);
  self setclientdvar("cg_fov_viewmodel", 65.0);
  self setclientdvar("cg_disable_user_fov", 0);
}

_id_52BEDAE2CED8E191() {
  _id_A910600EADF5E31C = level._effect["vfx_br_ac130_clouds"];
  _id_08B26DE022A9F35F = level._effect["vfx_br_ac130_oneshot"];

  if(isDefined(_id_A910600EADF5E31C))
    stopFXOnTag(_id_A910600EADF5E31C, self, "tag_body");

  if(isDefined(_id_08B26DE022A9F35F))
    stopFXOnTag(_id_08B26DE022A9F35F, self, "tag_body");
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

_id_98486F8B479597E1(_id_477C1209E5432ABE) {
  if(_id_477C1209E5432ABE <= 0.0)
    _id_477C1209E5432ABE = 0.0;
  else if(_id_477C1209E5432ABE >= 1.0)
    _id_477C1209E5432ABE = 1.0;

  _id_C5FAA94190723347 = int(_id_477C1209E5432ABE * 100.0);
  _id_C5FAA94190723347 = _id_C5FAA94190723347 - scripts\engine\utility::mod(_id_C5FAA94190723347, 10);

  if(isPlayer(self))
    scripts\mp\utility\player::setwind(scripts\engine\utility::string(_id_C5FAA94190723347), 1);
  else
    self setscriptablepartstate("wind", scripts\engine\utility::string(_id_C5FAA94190723347), 1);
}

_id_48B6AD7AFC978B6C() {
  self endon("stopWind");
  _id_E8D980A1B17BC221 = self.staticc130.origin;
  _id_1EA13AA1F992052F = self.staticc130.angles;

  if(!isDefined(_id_1EA13AA1F992052F))
    _id_1EA13AA1F992052F = (0, 0, 0);

  _id_27220E8D699E8148 = anglesToForward(_id_1EA13AA1F992052F);
  _id_6628001E4283C554 = _id_27220E8D699E8148 * -1.0;
  _id_1E51BF3BEB996BEA = getdvarfloat("dvar_35E512315EC17F9E", -200.0);
  _id_9C1B24ED417256AC = getdvarfloat("dvar_35C124315E992C7C", 50.0);
  _id_2668FB5D52D6438D = scripts\engine\utility::array_combine(self._id_2668FB5D52D6438D, self._id_A552EC61E51ECE6E);

  for(;;) {
    _id_B6217B906C6BE73E = scripts\engine\utility::array_combine(level.infilstruct.players, _id_2668FB5D52D6438D);

    foreach(operator in _id_B6217B906C6BE73E) {
      if(!isDefined(operator)) {
        continue;
      }
      _id_6F56FA8209DCF5D0 = operator.origin - _id_E8D980A1B17BC221;
      _id_A6C6221A1040F454 = scripts\engine\math::scalar_projection(_id_6628001E4283C554, _id_6F56FA8209DCF5D0);
      _id_1865B7643C24139D = (_id_A6C6221A1040F454 - _id_1E51BF3BEB996BEA) / (_id_9C1B24ED417256AC - _id_1E51BF3BEB996BEA);
      operator _id_98486F8B479597E1(_id_1865B7643C24139D);
    }

    wait 0.5;
  }
}

clearplayerwind() {
  self notify("stopWind");
  _id_2668FB5D52D6438D = scripts\engine\utility::array_combine(self._id_2668FB5D52D6438D, self._id_A552EC61E51ECE6E);
  _id_B6217B906C6BE73E = scripts\engine\utility::array_combine(level.infilstruct.players, _id_2668FB5D52D6438D);

  foreach(operator in _id_B6217B906C6BE73E) {
    if(!isDefined(operator)) {
      continue;
    }
    if(isPlayer(operator))
      operator.manualoverridewindmaterial = undefined;

    operator setscriptablepartstate("wind", "1", 1);
  }
}

_id_708E8449A90A636F() {
  wait 0.1;
  _id_16F307C48E420065();

  if(isDefined(self.movingc130))
    self.movingc130 setscriptablepartstate("br_fx", "clouds");
}

_id_F1462CCAD9C4E0BE() {
  self.manualoverridewindmaterial = undefined;
  scripts\mp\utility\player::setwind("1");
  self setallstreamloaddist(0.0);
}

_id_5DBA404B985C7D41() {
  clearplayerwind();

  foreach(player in level.infilstruct.players) {
    if(!isDefined(player)) {
      continue;
    }
    player setallstreamloaddist(0.0);
  }

  if(isDefined(self.movingc130)) {
    self._id_E73CE295AE9D4104 unlink();
    self._id_E73CE295AE9D4104 linkTo(self.movingc130, "tag_body_animate", (0, 0, 0), (0, 0, 0));

    if(!istrue(level.infilstruct._id_DF94E780C2B3C994) || _id_0930A1E7BD882C1D::_id_8663DA4077FA7E20())
      self.movingc130 notify("start_moving");
  }

  setomnvar("ui_hide_player_icons", 0);
  level notify("teleportToMovingPlane");
  thread _id_708E8449A90A636F();
  _id_0930A1E7BD882C1D::_id_6199C35F4CF4524C(::_id_F1462CCAD9C4E0BE);
}

_id_66B13900C5013DE5(_id_0C26FC18BDA607B7) {
  body = tablelookup("operatorSkins.csv", 1, _id_0C26FC18BDA607B7, 4);
  head = tablelookup("operatorSkins.csv", 1, _id_0C26FC18BDA607B7, 5);

  if(body == "" || head == "") {
    return;
  }
  self _meth_DD6D30B9EC87C1B3(body, head, "iw9_avatar_scriptable_mp");
}