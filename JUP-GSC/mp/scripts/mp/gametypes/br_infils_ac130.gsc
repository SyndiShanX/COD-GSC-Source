/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_infils_ac130.gsc
****************************************************/

#using script_75377e59f5becac8;
#using script_930a1e7bd882c1d;
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\cp_mp\operator;
#using scripts\cp_mp\utility\audio_utility;
#using scripts\engine\math;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\music_and_dialog;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#using scripts\mp\utility\teams;
#namespace br_infils_ac130;

function init() {
  assert(isDefined(level.infilstruct));

  setdevdvarifuninitialized(@ "hash_ef579438c4248057", 3.75);
  setdevdvarifuninitialized(@ "hash_224074cc9cbd34e3", 1);
  setdevdvarifuninitialized(@ "hash_916619431dc89fba", 6);
  setdevdvarifuninitialized(@ "hash_419ab155ef9169a4", 3);
  setdevdvarifuninitialized(@ "hash_4ee80a43d1c50ca2", 1);
  setdevdvarifuninitialized(@ "hash_bfded00ac93c45b7", 1);
  setdevdvarifuninitialized(@ "hash_7f1da0c3501cbdf2", 1);
  setdevdvarifuninitialized(@ "hash_5fd54d13e95394d5", 0);

  if(getdvarint(@ "hash_2be93dd484220a45", 0)) {
    level.infilstruct.c130model = "shadow::veh9_mil_air_cargo_plane_exterior_infil";
  } else if(scripts\mp\utility\game::getsubgametype() == "zxp") {
    level.infilstruct.c130model = "veh9_mil_air_cargo_plane_exterior_infil_green";
  } else {
    level.infilstruct.c130model = "jup_black_wz::veh9_mil_air_cargo_plane_exterior_infil";
  }

  level.infilstruct.var_30e653e12f358438 = "veh9_mil_air_cargo_plane_interior_infil";
  level.infilstruct.var_c3a4f4442070a8b5 = "tag_body_animate";
  delaythread(0.05, &function_c880edba9face762, "ac130");
  level.infilstruct.var_b381e33e977da440 = &function_55f2480b4b819aea;
  level.infilstruct.var_ae9e4023110acc6e = &function_ad4a7a73c7d7d9e0;
  level.infilstruct.jumpfunc = &jumpfunc;
  level.infilstruct.var_dc0bc83a31193177 = &function_dc0bc83a31193177;
  level.infilstruct.var_12c912ee9672fa1 = 1;
  level.infilstruct.var_eb0e85a583f21b9d = 1;
  level.infilstruct.c130soundalias = "veh_br_infil_c17_distant_lp";
  var_1809e16510055e87 = ["cam_orbit_br_infil_ac130_player1", "cam_orbit_br_infil_ac130_player2", "cam_orbit_br_infil_ac130_player3", "cam_orbit_br_infil_ac130_player4", "cam_orbit_br_infil_ac130_player1"];
  function_226e337633a44059(var_1809e16510055e87);
  function_ad12d29d41483e8a("prematch", &function_cd7e1a37d5e2ca2b);
  function_ad12d29d41483e8a("fadedown", &function_26874fd7694aa29);
  game["dialog"]["infil_ac130_5_seconds"] = "dx_br_dmzc_infl_ldms_drop";
}

function function_9afdeab1e38dac18(animstruct, animationref) {
  if(isDefined(animstruct.staticc130)) {
    add_pack_modelanim(animstruct.staticc130, animationref);
  }

  if(isDefined(animstruct.movingc130)) {
    add_pack_modelanim(animstruct.movingc130, animationref);
  }
}

function function_55f2480b4b819aea(movingc130) {
  animstruct = spawnStruct();
  animstruct.origin = getdvarvector(@ "br_infil_anim_pos", (0, 0, 0));
  animstruct.angles = (0, 0, 0);
  animstruct.var_7a2af7fe0ef35baa = getdvarint(@ "hash_4ee80a43d1c50ca2", 1);
  animstruct.var_3772737101aa4af = level.var_2655050b4d075e87;
  animstruct.cleanupfunc = &function_72145194f4f38714;
  animstruct.var_ab8494260b910b51 = &function_52bedae2ced8e191;
  animstruct.movingc130 = movingc130;

  if(isDefined(animstruct.movingc130)) {
    animstruct.movingc130.animname = "movingC130";
    animstruct.movingc130.innards.animname = "movingC130";
    animstruct.movingc130.animstruct = animstruct;
    animstruct.movingc130.dontteleport = 1;
  }

  if(scripts\engine\utility::issharedfuncdefined("br_infils_ac130", "getAnimStruct")) {
    animstruct = [[scripts\engine\utility::getsharedfunc("br_infils_ac130", "getAnimStruct")]](animstruct);
  } else {
    animstruct.staticc130 = getEnt("infil_ac130_exterior", "targetname");

    if(isDefined(animstruct.staticc130)) {
      animstruct.staticc130 show();
      animstruct.staticc130.animname = "c130";
      animstruct.staticc130.dontdelete = 1;
    } else {
      animstruct.staticc130 = animstruct spawn_script_model("jup_black_wz::veh9_mil_air_cargo_plane_exterior_infil", "c130");
    }

    animstruct.staticc130.dontteleport = 1;
    animstruct.camerarunner = animstruct spawn_script_model("generic_prop_x30", "camera");
    animstruct.camerarunner linkTo(animstruct.staticc130, "tag_body_animate", (0, 0, 0), (0, 0, 0));
    animstruct.introplane = animstruct spawn_script_model("black::veh9_mil_air_cargo_plane", "introPlane");
    animstruct.introplane linkTo(animstruct.camerarunner, "j_prop_30");
    skins = ["milsim_western_a", "milsim_western_b", "milsim_western_c", "milsim_western_d", "milsim_eastern_a", "milsim_eastern_b", "milsim_eastern_c", "milsim_eastern_d"];
    animstruct.playertags = [];
    animstruct.playertags[0] = animstruct spawn_script_model("tag_player", "playerTag1");
    animstruct.playertags[1] = animstruct spawn_script_model("tag_player", "playerTag2");
    animstruct.playertags[2] = animstruct spawn_script_model("tag_player", "playerTag3");
    animstruct.playertags[3] = animstruct spawn_script_model("tag_player", "playerTag4");
    animstruct.playertags[4] = animstruct spawn_script_model("tag_player", "playerTag5");
    animstruct.playertags[0] linkTo(animstruct.camerarunner, "j_prop_2", (0, 0, 0), (0, 0, 0));
    animstruct.playertags[1] linkTo(animstruct.camerarunner, "j_prop_3", (0, 0, 0), (0, 0, 0));
    animstruct.playertags[2] linkTo(animstruct.camerarunner, "j_prop_4", (0, 0, 0), (0, 0, 0));
    animstruct.playertags[3] linkTo(animstruct.camerarunner, "j_prop_5", (0, 0, 0), (0, 0, 0));
    animstruct.playertags[4] linkTo(animstruct.camerarunner, "j_prop_15", (0, 0, 0), (0, 0, 0));
    animstruct.playermodels = [];
    animstruct.playermodels[0] = animstruct spawn_script_model("fullbody_usmc_ar_br_infil", "player1");
    animstruct.playermodels[1] = animstruct spawn_script_model("fullbody_usmc_ar_br_infil", "player2");
    animstruct.playermodels[2] = animstruct spawn_script_model("fullbody_usmc_ar_br_infil", "player3");
    animstruct.playermodels[3] = animstruct spawn_script_model("fullbody_usmc_ar_br_infil", "player4");
    animstruct.playermodels[4] = animstruct spawn_script_model("fullbody_usmc_ar_br_infil", "player5");
    animstruct.playermodels[0] linkTo(animstruct.playertags[0], "tag_player", (0, 0, 0), (0, 0, 0));
    animstruct.playermodels[1] linkTo(animstruct.playertags[1], "tag_player", (0, 0, 0), (0, 0, 0));
    animstruct.playermodels[2] linkTo(animstruct.playertags[2], "tag_player", (0, 0, 0), (0, 0, 0));
    animstruct.playermodels[3] linkTo(animstruct.playertags[3], "tag_player", (0, 0, 0), (0, 0, 0));
    animstruct.playermodels[4] linkTo(animstruct.playertags[4], "tag_player", (0, 0, 0), (0, 0, 0));
    randomskins = array_randomize(skins);
    animstruct.playermodels[0] function_66b13900c5013de5(randomskins[0]);
    animstruct.playermodels[1] function_66b13900c5013de5(randomskins[1]);
    animstruct.playermodels[2] function_66b13900c5013de5(randomskins[2]);
    animstruct.playermodels[3] function_66b13900c5013de5(randomskins[3]);
    animstruct.playermodels[4] function_66b13900c5013de5(randomskins[4]);
    animstruct.crates = [];
    animstruct.crates[0] = animstruct spawn_script_model("military_carepackage_03_br", "crate1");
    animstruct.crates[0] linkTo(animstruct.camerarunner, "j_prop_8", (0, 0, 0), (0, 0, 0));
    animstruct.npcs = [];
    animstruct.npcs[0] = animstruct spawn_script_model("fullbody_usmc_ar_br_infil", "npc1");
    animstruct.npcs[1] = animstruct spawn_script_model("fullbody_usmc_ar_br_infil", "npc2");
    animstruct.npcs[2] = animstruct spawn_script_model("fullbody_usmc_ar_br_infil", "npc3");
    animstruct.npcs[3] = animstruct spawn_script_model("fullbody_usmc_ar_br_infil", "npc4");
    animstruct.npcs[4] = animstruct spawn_script_model("fullbody_usmc_ar_br_infil", "npc5");
    animstruct.npcs[5] = animstruct spawn_script_model("fullbody_usmc_ar_br_infil", "npc6");
    animstruct.npcs[0] linkTo(animstruct.camerarunner, "j_prop_9", (0, 0, 0), (0, 0, 0));
    animstruct.npcs[1] linkTo(animstruct.camerarunner, "j_prop_10", (0, 0, 0), (0, 0, 0));
    animstruct.npcs[2] linkTo(animstruct.camerarunner, "j_prop_11", (0, 0, 0), (0, 0, 0));
    animstruct.npcs[3] linkTo(animstruct.camerarunner, "j_prop_12", (0, 0, 0), (0, 0, 0));
    animstruct.npcs[4] linkTo(animstruct.camerarunner, "j_prop_13", (0, 0, 0), (0, 0, 0));
    animstruct.npcs[5] linkTo(animstruct.camerarunner, "j_prop_14", (0, 0, 0), (0, 0, 0));
    randomskins = array_randomize(skins);
    animstruct.npcs[0] function_66b13900c5013de5(randomskins[0]);
    animstruct.npcs[1] function_66b13900c5013de5(randomskins[1]);
    animstruct.npcs[2] function_66b13900c5013de5(randomskins[2]);
    animstruct.npcs[3] function_66b13900c5013de5(randomskins[3]);
    animstruct.npcs[4] function_66b13900c5013de5(randomskins[4]);
    animstruct.npcs[5] function_66b13900c5013de5(randomskins[5]);
    animstruct.packs = [];
    n = 0;
    var_e92aed86e7dd8b76 = 10;
    quadsfov = 10;
    var_92c2f39adf1c2e62 = 0;
    animstruct.packs[n] = animstruct create_animpack("scene0.0");
    animstruct.packs[n] add_pack_startfunc([var_e92aed86e7dd8b76, quadsfov, var_92c2f39adf1c2e62], &function_1a124e836e45482c);
    animstruct.packs[n] add_pack_modelanim(animstruct.camerarunner, level.br_anim["wz_infil_g_prop_sh000"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.introplane, level.br_anim["wz_infil_cargoplane_sh000"]);
    animstruct.packs[n] function_ad0bcac98781e0ab(animstruct.playertags[0], level.br_anim["wz_infil_drone_guy1_idle_sh010"]);
    animstruct.packs[n] function_ad0bcac98781e0ab(animstruct.playertags[1], level.br_anim["wz_infil_drone_guy2_idle_sh010"]);
    animstruct.packs[n] function_ad0bcac98781e0ab(animstruct.playertags[2], level.br_anim["wz_infil_drone_guy3_idle_sh010"]);
    animstruct.packs[n] function_ad0bcac98781e0ab(animstruct.playertags[3], level.br_anim["wz_infil_drone_guy4_idle_sh010"]);
    animstruct.packs[n] function_ad0bcac98781e0ab(animstruct.playertags[4], level.br_anim["wz_infil_drone_guy1_idle_sh010"]);
    animstruct.packs[n] function_f7fc8b110c478968(animstruct.playermodels[0], level.br_anim["wz_infil_drone_guy1_idle_sh010"]);
    animstruct.packs[n] function_f7fc8b110c478968(animstruct.playermodels[1], level.br_anim["wz_infil_drone_guy2_idle_sh010"]);
    animstruct.packs[n] function_f7fc8b110c478968(animstruct.playermodels[2], level.br_anim["wz_infil_drone_guy3_idle_sh010"]);
    animstruct.packs[n] function_f7fc8b110c478968(animstruct.playermodels[3], level.br_anim["wz_infil_drone_guy4_idle_sh010"]);
    animstruct.packs[n] function_f7fc8b110c478968(animstruct.playermodels[4], level.br_anim["wz_infil_drone_guy1_idle_sh010"]);
    animstruct.packs[n] function_d4561ab1ba4f5de9(animstruct.camerarunner, "tag_origin", level.br_anim["wz_infil_g_prop_sh000"], "wz_infil_xcam_sh000_quads", &getxcamfunc);
    animstruct.packs[n].xcams = ["wz_infil_xcam_sh000_quads", "wz_infil_xcam_sh000_quads", "wz_infil_xcam_sh000_quads", "wz_infil_xcam_sh000_quads"];

    if(!isDefined(level.scr_notetrack["camera"]) || !isDefined(level.scr_notetrack["camera"]["any"]["infil_header_player1"])) {
      scripts\common\anim::addnotetrack_customfunction("camera", "infil_header_player1", &function_1a5e2c1cef16393f);
      scripts\common\anim::addnotetrack_customfunction("camera", "infil_header_player2", &function_7797914101c3a342);
      scripts\common\anim::addnotetrack_customfunction("camera", "infil_header_player3", &function_e86f60ffd1abcd75);
      scripts\common\anim::addnotetrack_customfunction("camera", "infil_header_player4", &function_a9090d88a8813828);
    }

    n++;
    var_e92aed86e7dd8b76 = 35;
    quadsfov = 30;
    var_92c2f39adf1c2e62 = 0;
    animstruct.packs[n] = animstruct create_animpack("scene4");
    animstruct.packs[n] add_pack_startfunc([var_e92aed86e7dd8b76, quadsfov, var_92c2f39adf1c2e62], &function_baf143dbadb3f80);
    animstruct.packs[n] function_9afdeab1e38dac18(animstruct, level.br_anim["wz_infil_cargoplane_sh040"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.camerarunner, level.br_anim["wz_infil_g_prop_sh040"]);
    animstruct.packs[n] function_ad0bcac98781e0ab(animstruct.playertags[0], level.br_anim["wz_infil_drone_guy1_sh040"]);
    animstruct.packs[n] function_ad0bcac98781e0ab(animstruct.playertags[1], level.br_anim["wz_infil_drone_guy2_sh040"]);
    animstruct.packs[n] function_ad0bcac98781e0ab(animstruct.playertags[2], level.br_anim["wz_infil_drone_guy3_sh040"]);
    animstruct.packs[n] function_ad0bcac98781e0ab(animstruct.playertags[3], level.br_anim["wz_infil_drone_guy4_sh040"]);
    animstruct.packs[n] function_ad0bcac98781e0ab(animstruct.playertags[4], level.br_anim["wz_infil_solowin_guy1_sh040"]);
    animstruct.packs[n] function_f7fc8b110c478968(animstruct.playermodels[0], level.br_anim["wz_infil_drone_guy1_sh040"]);
    animstruct.packs[n] function_f7fc8b110c478968(animstruct.playermodels[1], level.br_anim["wz_infil_drone_guy2_sh040"]);
    animstruct.packs[n] function_f7fc8b110c478968(animstruct.playermodels[2], level.br_anim["wz_infil_drone_guy3_sh040"]);
    animstruct.packs[n] function_f7fc8b110c478968(animstruct.playermodels[3], level.br_anim["wz_infil_drone_guy4_sh040"]);
    animstruct.packs[n] function_f7fc8b110c478968(animstruct.playermodels[4], level.br_anim["wz_infil_solowin_guy1_sh040"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.crates[0], level.br_anim["wz_infil_cargobox_sh040"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[0], level.br_anim["wz_infil_drone_guy_npc1_sh040"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[1], level.br_anim["wz_infil_drone_guy_npc2_sh040"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[2], level.br_anim["wz_infil_drone_guy_npc3_sh040"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[3], level.br_anim["wz_infil_drone_guy_npc4_sh040"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[4], level.br_anim["wz_infil_drone_guy_npc5_sh040"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[5], level.br_anim["wz_infil_drone_guy_npc6_sh040"]);
    animstruct.packs[n] function_d4561ab1ba4f5de9(animstruct.camerarunner, "tag_origin", level.br_anim["wz_infil_g_prop_sh040"], "wz_infil_xcam_sh040_quads", &getxcamfunc);
    animstruct.packs[n].xcams = ["wz_infil_xcam_sh040_solos", "wz_infil_xcam_sh040_solos", "wz_infil_xcam_sh040_quads", "wz_infil_xcam_sh040_quads"];
    n++;
    var_e92aed86e7dd8b76 = 7.5;
    quadsfov = 40;
    var_92c2f39adf1c2e62 = 0;
    animstruct.packs[n] = animstruct create_animpack("scene5");
    animstruct.packs[n] add_pack_startfunc([var_e92aed86e7dd8b76, quadsfov, var_92c2f39adf1c2e62], &function_9af898862a8c98b9);
    animstruct.packs[n] function_9afdeab1e38dac18(animstruct, level.br_anim["wz_infil_cargoplane_sh050"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.camerarunner, level.br_anim["wz_infil_g_prop_sh050"]);
    animstruct.packs[n] function_ad0bcac98781e0ab(animstruct.playertags[0], level.br_anim["wz_infil_drone_guy1_sh050"]);
    animstruct.packs[n] function_ad0bcac98781e0ab(animstruct.playertags[1], level.br_anim["wz_infil_drone_guy2_sh050"]);
    animstruct.packs[n] function_ad0bcac98781e0ab(animstruct.playertags[2], level.br_anim["wz_infil_drone_guy3_sh050"]);
    animstruct.packs[n] function_ad0bcac98781e0ab(animstruct.playertags[3], level.br_anim["wz_infil_drone_guy4_sh050"]);
    animstruct.packs[n] function_ad0bcac98781e0ab(animstruct.playertags[4], level.br_anim["wz_infil_solowin_guy1_sh050"]);
    animstruct.packs[n] function_f7fc8b110c478968(animstruct.playermodels[0], level.br_anim["wz_infil_drone_guy1_sh050"]);
    animstruct.packs[n] function_f7fc8b110c478968(animstruct.playermodels[1], level.br_anim["wz_infil_drone_guy2_sh050"]);
    animstruct.packs[n] function_f7fc8b110c478968(animstruct.playermodels[2], level.br_anim["wz_infil_drone_guy3_sh050"]);
    animstruct.packs[n] function_f7fc8b110c478968(animstruct.playermodels[3], level.br_anim["wz_infil_drone_guy4_sh050"]);
    animstruct.packs[n] function_f7fc8b110c478968(animstruct.playermodels[4], level.br_anim["wz_infil_solowin_guy1_sh050"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.crates[0], level.br_anim["wz_infil_cargobox_sh050"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[0], level.br_anim["wz_infil_drone_guy_npc1_sh050"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[1], level.br_anim["wz_infil_drone_guy_npc2_sh050"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[2], level.br_anim["wz_infil_drone_guy_npc3_sh050"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[3], level.br_anim["wz_infil_drone_guy_npc4_sh050"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[4], level.br_anim["wz_infil_drone_guy_npc5_sh050"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[5], level.br_anim["wz_infil_drone_guy_npc6_sh050"]);
    animstruct.packs[n] function_d4561ab1ba4f5de9(animstruct.camerarunner, "tag_origin", level.br_anim["wz_infil_g_prop_sh050"], "wz_infil_xcam_sh050_quads", &getxcamfunc);
    animstruct.packs[n].xcams = ["wz_infil_xcam_sh050_solos", "wz_infil_xcam_sh050_solos", "wz_infil_xcam_sh050_quads", "wz_infil_xcam_sh050_quads"];
    n++;
    var_e92aed86e7dd8b76 = 30;
    quadsfov = 40;
    var_92c2f39adf1c2e62 = 0;
    animstruct.packs[n] = animstruct create_animpack("scene6");
    animstruct.packs[n] add_pack_startfunc([var_e92aed86e7dd8b76, quadsfov, var_92c2f39adf1c2e62], &function_646b15a1f9a1e55a);
    animstruct.packs[n] function_9afdeab1e38dac18(animstruct, level.br_anim["wz_infil_cargoplane_sh060"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.camerarunner, level.br_anim["wz_infil_g_prop_sh060"]);
    animstruct.packs[n] function_ad0bcac98781e0ab(animstruct.playertags[0], level.br_anim["wz_infil_drone_guy1_sh060"]);
    animstruct.packs[n] function_ad0bcac98781e0ab(animstruct.playertags[1], level.br_anim["wz_infil_drone_guy2_sh060"]);
    animstruct.packs[n] function_ad0bcac98781e0ab(animstruct.playertags[2], level.br_anim["wz_infil_drone_guy3_sh060"]);
    animstruct.packs[n] function_ad0bcac98781e0ab(animstruct.playertags[3], level.br_anim["wz_infil_drone_guy4_sh060"]);
    animstruct.packs[n] function_ad0bcac98781e0ab(animstruct.playertags[4], level.br_anim["wz_infil_solowin_guy1_sh060"]);
    animstruct.packs[n] function_f7fc8b110c478968(animstruct.playermodels[0], level.br_anim["wz_infil_drone_guy1_sh060"]);
    animstruct.packs[n] function_f7fc8b110c478968(animstruct.playermodels[1], level.br_anim["wz_infil_drone_guy2_sh060"]);
    animstruct.packs[n] function_f7fc8b110c478968(animstruct.playermodels[2], level.br_anim["wz_infil_drone_guy3_sh060"]);
    animstruct.packs[n] function_f7fc8b110c478968(animstruct.playermodels[3], level.br_anim["wz_infil_drone_guy4_sh060"]);
    animstruct.packs[n] function_f7fc8b110c478968(animstruct.playermodels[4], level.br_anim["wz_infil_solowin_guy1_sh060"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.crates[0], level.br_anim["wz_infil_cargobox_sh060"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[0], level.br_anim["wz_infil_drone_guy_npc1_sh060"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[1], level.br_anim["wz_infil_drone_guy_npc2_sh060"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[2], level.br_anim["wz_infil_drone_guy_npc3_sh060"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[3], level.br_anim["wz_infil_drone_guy_npc4_sh060"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[4], level.br_anim["wz_infil_drone_guy_npc5_sh060"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[5], level.br_anim["wz_infil_drone_guy_npc6_sh060"]);
    animstruct.packs[n] function_d4561ab1ba4f5de9(animstruct.camerarunner, "tag_origin", level.br_anim["wz_infil_g_prop_sh060"], "wz_infil_xcam_sh060_quads", &getxcamfunc);
    animstruct.packs[n].xcams = ["wz_infil_xcam_sh060_solos", "wz_infil_xcam_sh060_solos", "wz_infil_xcam_sh060_quads", "wz_infil_xcam_sh060_quads"];
    n++;
    var_e92aed86e7dd8b76 = 20;
    quadsfov = 50;
    var_92c2f39adf1c2e62 = 0;
    animstruct.packs[n] = animstruct create_animpack("scene7");
    animstruct.packs[n] add_pack_startfunc([var_e92aed86e7dd8b76, quadsfov, var_92c2f39adf1c2e62], &function_a1154be6e3c8a13);
    animstruct.packs[n] function_9afdeab1e38dac18(animstruct, level.br_anim["wz_infil_cargoplane_sh070"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.camerarunner, level.br_anim["wz_infil_g_prop_sh070"]);
    animstruct.packs[n] function_ad0bcac98781e0ab(animstruct.playertags[0], level.br_anim["wz_infil_drone_guy1_sh070"]);
    animstruct.packs[n] function_ad0bcac98781e0ab(animstruct.playertags[1], level.br_anim["wz_infil_drone_guy2_sh070"]);
    animstruct.packs[n] function_ad0bcac98781e0ab(animstruct.playertags[2], level.br_anim["wz_infil_drone_guy3_sh070"]);
    animstruct.packs[n] function_ad0bcac98781e0ab(animstruct.playertags[3], level.br_anim["wz_infil_drone_guy4_sh070"]);
    animstruct.packs[n] function_ad0bcac98781e0ab(animstruct.playertags[4], level.br_anim["wz_infil_solowin_guy1_sh070"]);
    animstruct.packs[n] function_f7fc8b110c478968(animstruct.playermodels[0], level.br_anim["wz_infil_drone_guy1_sh070"]);
    animstruct.packs[n] function_f7fc8b110c478968(animstruct.playermodels[1], level.br_anim["wz_infil_drone_guy2_sh070"]);
    animstruct.packs[n] function_f7fc8b110c478968(animstruct.playermodels[2], level.br_anim["wz_infil_drone_guy3_sh070"]);
    animstruct.packs[n] function_f7fc8b110c478968(animstruct.playermodels[3], level.br_anim["wz_infil_drone_guy4_sh070"]);
    animstruct.packs[n] function_f7fc8b110c478968(animstruct.playermodels[4], level.br_anim["wz_infil_solowin_guy1_sh070"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.crates[0], level.br_anim["wz_infil_cargobox_sh070"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[0], level.br_anim["wz_infil_drone_guy_npc1_sh070"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[1], level.br_anim["wz_infil_drone_guy_npc2_sh070"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[2], level.br_anim["wz_infil_drone_guy_npc3_sh070"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[3], level.br_anim["wz_infil_drone_guy_npc4_sh070"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[4], level.br_anim["wz_infil_drone_guy_npc5_sh070"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[5], level.br_anim["wz_infil_drone_guy_npc6_sh070"]);
    animstruct.packs[n] function_d4561ab1ba4f5de9(animstruct.camerarunner, "tag_origin", level.br_anim["wz_infil_g_prop_sh070"], "wz_infil_xcam_sh070_quads", &getxcamfunc);
    animstruct.packs[n].xcams = ["wz_infil_xcam_sh070_solos", "wz_infil_xcam_sh070_solos", "wz_infil_xcam_sh070_quads", "wz_infil_xcam_sh070_quads"];
    n++;
    var_e92aed86e7dd8b76 = 30;
    quadsfov = 50;
    var_92c2f39adf1c2e62 = 0;
    animstruct.packs[n] = animstruct create_animpack("scene8");
    animstruct.packs[n] add_pack_startfunc([var_e92aed86e7dd8b76, quadsfov, var_92c2f39adf1c2e62], &function_5252a2070a63d534);
    animstruct.packs[n] function_9afdeab1e38dac18(animstruct, level.br_anim["wz_infil_cargoplane_sh080"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.camerarunner, level.br_anim["wz_infil_g_prop_sh080"]);
    animstruct.packs[n] function_ad0bcac98781e0ab(animstruct.playertags[0], level.br_anim["wz_infil_drone_guy1_sh080"]);
    animstruct.packs[n] function_ad0bcac98781e0ab(animstruct.playertags[1], level.br_anim["wz_infil_drone_guy2_sh080"]);
    animstruct.packs[n] function_ad0bcac98781e0ab(animstruct.playertags[2], level.br_anim["wz_infil_drone_guy3_sh080"]);
    animstruct.packs[n] function_ad0bcac98781e0ab(animstruct.playertags[3], level.br_anim["wz_infil_drone_guy4_sh080"]);
    animstruct.packs[n] function_ad0bcac98781e0ab(animstruct.playertags[4], level.br_anim["wz_infil_solowin_guy1_sh080"]);
    animstruct.packs[n] function_f7fc8b110c478968(animstruct.playermodels[0], level.br_anim["wz_infil_drone_guy1_sh080"]);
    animstruct.packs[n] function_f7fc8b110c478968(animstruct.playermodels[1], level.br_anim["wz_infil_drone_guy2_sh080"]);
    animstruct.packs[n] function_f7fc8b110c478968(animstruct.playermodels[2], level.br_anim["wz_infil_drone_guy3_sh080"]);
    animstruct.packs[n] function_f7fc8b110c478968(animstruct.playermodels[3], level.br_anim["wz_infil_drone_guy4_sh080"]);
    animstruct.packs[n] function_f7fc8b110c478968(animstruct.playermodels[4], level.br_anim["wz_infil_solowin_guy1_sh080"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.crates[0], level.br_anim["wz_infil_cargobox_sh080"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[0], level.br_anim["wz_infil_drone_guy_npc1_sh080"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[1], level.br_anim["wz_infil_drone_guy_npc2_sh080"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[2], level.br_anim["wz_infil_drone_guy_npc3_sh080"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[3], level.br_anim["wz_infil_drone_guy_npc4_sh080"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[4], level.br_anim["wz_infil_drone_guy_npc5_sh080"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[5], level.br_anim["wz_infil_drone_guy_npc6_sh080"]);
    animstruct.packs[n] function_d4561ab1ba4f5de9(animstruct.camerarunner, "tag_origin", level.br_anim["wz_infil_g_prop_sh080"], "wz_infil_xcam_sh080_quads", &getxcamfunc);
    animstruct.packs[n].xcams = ["wz_infil_xcam_sh080_solos", "wz_infil_xcam_sh080_solos", "wz_infil_xcam_sh080_quads", "wz_infil_xcam_sh080_quads"];
    n++;
    var_e92aed86e7dd8b76 = 25;
    quadsfov = 31.78;
    var_92c2f39adf1c2e62 = 1;
    animstruct.packs[n] = animstruct create_animpack("scene9");
    animstruct.packs[n] add_pack_startfunc([var_e92aed86e7dd8b76, quadsfov, var_92c2f39adf1c2e62], &function_6822439c818b5b8d);
    animstruct.packs[n] function_9afdeab1e38dac18(animstruct, level.br_anim["wz_infil_cargoplane_sh090"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.camerarunner, level.br_anim["wz_infil_g_prop_sh090"]);
    animstruct.packs[n] function_ad0bcac98781e0ab(animstruct.playertags[0], level.br_anim["wz_infil_drone_guy1_sh090"]);
    animstruct.packs[n] function_ad0bcac98781e0ab(animstruct.playertags[1], level.br_anim["wz_infil_drone_guy2_sh090"]);
    animstruct.packs[n] function_ad0bcac98781e0ab(animstruct.playertags[2], level.br_anim["wz_infil_drone_guy3_sh090"]);
    animstruct.packs[n] function_ad0bcac98781e0ab(animstruct.playertags[3], level.br_anim["wz_infil_drone_guy4_sh090"]);
    animstruct.packs[n] function_ad0bcac98781e0ab(animstruct.playertags[4], level.br_anim["wz_infil_solowin_guy1_sh090"]);
    animstruct.packs[n] function_f7fc8b110c478968(animstruct.playermodels[0], level.br_anim["wz_infil_drone_guy1_sh090"]);
    animstruct.packs[n] function_f7fc8b110c478968(animstruct.playermodels[1], level.br_anim["wz_infil_drone_guy2_sh090"]);
    animstruct.packs[n] function_f7fc8b110c478968(animstruct.playermodels[2], level.br_anim["wz_infil_drone_guy3_sh090"]);
    animstruct.packs[n] function_f7fc8b110c478968(animstruct.playermodels[3], level.br_anim["wz_infil_drone_guy4_sh090"]);
    animstruct.packs[n] function_f7fc8b110c478968(animstruct.playermodels[4], level.br_anim["wz_infil_solowin_guy1_sh090"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.crates[0], level.br_anim["wz_infil_cargobox_sh090"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[0], level.br_anim["wz_infil_drone_guy_npc1_sh090"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[1], level.br_anim["wz_infil_drone_guy_npc2_sh090"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[2], level.br_anim["wz_infil_drone_guy_npc3_sh090"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[3], level.br_anim["wz_infil_drone_guy_npc4_sh090"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[4], level.br_anim["wz_infil_drone_guy_npc5_sh090"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[5], level.br_anim["wz_infil_drone_guy_npc6_sh090"]);
    animstruct.packs[n] function_d4561ab1ba4f5de9(animstruct.camerarunner, "tag_origin", level.br_anim["wz_infil_g_prop_sh090"], "wz_infil_xcam_sh090_quads", &getxcamfunc);
    animstruct.packs[n].xcams = ["wz_infil_xcam_sh090_solos", "wz_infil_xcam_sh090_quads", "wz_infil_xcam_sh090_solos", "wz_infil_xcam_sh090_quads"];
    n++;
    var_e92aed86e7dd8b76 = 20;
    quadsfov = 17.847;
    var_92c2f39adf1c2e62 = 1;
    animstruct.packs[n] = animstruct create_animpack("scene10");
    animstruct.packs[n] add_pack_startfunc([var_e92aed86e7dd8b76, quadsfov, var_92c2f39adf1c2e62], &function_9cfd7cab1a6e747b);
    animstruct.packs[n] function_9afdeab1e38dac18(animstruct, level.br_anim["wz_infil_cargoplane_sh100"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.camerarunner, level.br_anim["wz_infil_g_prop_sh100"]);
    animstruct.packs[n] function_ad0bcac98781e0ab(animstruct.playertags[0], level.br_anim["wz_infil_drone_guy1_sh100"]);
    animstruct.packs[n] function_ad0bcac98781e0ab(animstruct.playertags[1], level.br_anim["wz_infil_drone_guy2_sh100"]);
    animstruct.packs[n] function_ad0bcac98781e0ab(animstruct.playertags[2], level.br_anim["wz_infil_drone_guy3_sh100"]);
    animstruct.packs[n] function_ad0bcac98781e0ab(animstruct.playertags[3], level.br_anim["wz_infil_drone_guy4_sh100"]);
    animstruct.packs[n] function_ad0bcac98781e0ab(animstruct.playertags[4], level.br_anim["wz_infil_solowin_guy1_sh100"]);
    animstruct.packs[n] function_f7fc8b110c478968(animstruct.playermodels[0], level.br_anim["wz_infil_drone_guy1_sh100"]);
    animstruct.packs[n] function_f7fc8b110c478968(animstruct.playermodels[1], level.br_anim["wz_infil_drone_guy2_sh100"]);
    animstruct.packs[n] function_f7fc8b110c478968(animstruct.playermodels[2], level.br_anim["wz_infil_drone_guy3_sh100"]);
    animstruct.packs[n] function_f7fc8b110c478968(animstruct.playermodels[3], level.br_anim["wz_infil_drone_guy4_sh100"]);
    animstruct.packs[n] function_f7fc8b110c478968(animstruct.playermodels[4], level.br_anim["wz_infil_solowin_guy1_sh100"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.crates[0], level.br_anim["wz_infil_cargobox_sh100"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[0], level.br_anim["wz_infil_drone_guy_npc1_sh100"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[1], level.br_anim["wz_infil_drone_guy_npc2_sh100"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[2], level.br_anim["wz_infil_drone_guy_npc3_sh100"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[3], level.br_anim["wz_infil_drone_guy_npc4_sh100"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[4], level.br_anim["wz_infil_drone_guy_npc5_sh100"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[5], level.br_anim["wz_infil_drone_guy_npc6_sh100"]);
    animstruct.packs[n] function_d4561ab1ba4f5de9(animstruct.camerarunner, "tag_origin", level.br_anim["wz_infil_g_prop_sh100"], "wz_infil_xcam_sh100_quads", &getxcamfunc);
    animstruct.packs[n].xcams = ["wz_infil_xcam_sh100_solos", "wz_infil_xcam_sh100_quads", "wz_infil_xcam_sh100_solos", "wz_infil_xcam_sh100_quads"];
    n++;
    var_e92aed86e7dd8b76 = 40;
    quadsfov = 40;
    var_92c2f39adf1c2e62 = 0;
    animstruct.packs[n] = animstruct create_animpack("scene11");
    animstruct.packs[n] add_pack_startfunc([var_e92aed86e7dd8b76, quadsfov, var_92c2f39adf1c2e62], &function_2391d520e79f9862);
    animstruct.packs[n] function_9afdeab1e38dac18(animstruct, level.br_anim["wz_infil_cargoplane_sh110"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.camerarunner, level.br_anim["wz_infil_g_prop_sh110"]);
    animstruct.packs[n] function_ad0bcac98781e0ab(animstruct.playertags[0], level.br_anim["wz_infil_drone_guy1_sh110"]);
    animstruct.packs[n] function_ad0bcac98781e0ab(animstruct.playertags[1], level.br_anim["wz_infil_drone_guy2_sh110"]);
    animstruct.packs[n] function_ad0bcac98781e0ab(animstruct.playertags[2], level.br_anim["wz_infil_drone_guy3_sh110"]);
    animstruct.packs[n] function_ad0bcac98781e0ab(animstruct.playertags[3], level.br_anim["wz_infil_drone_guy4_sh110"]);
    animstruct.packs[n] function_ad0bcac98781e0ab(animstruct.playertags[4], level.br_anim["wz_infil_drone_guy1_sh110"]);
    animstruct.packs[n] function_f7fc8b110c478968(animstruct.playermodels[0], level.br_anim["wz_infil_drone_guy1_sh110"]);
    animstruct.packs[n] function_f7fc8b110c478968(animstruct.playermodels[1], level.br_anim["wz_infil_drone_guy2_sh110"]);
    animstruct.packs[n] function_f7fc8b110c478968(animstruct.playermodels[2], level.br_anim["wz_infil_drone_guy3_sh110"]);
    animstruct.packs[n] function_f7fc8b110c478968(animstruct.playermodels[3], level.br_anim["wz_infil_drone_guy4_sh110"]);
    animstruct.packs[n] function_f7fc8b110c478968(animstruct.playermodels[4], level.br_anim["wz_infil_drone_guy1_sh110"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.crates[0], level.br_anim["wz_infil_cargobox_sh110"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[0], level.br_anim["wz_infil_drone_guy_npc1_sh110"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[1], level.br_anim["wz_infil_drone_guy_npc2_sh110"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[2], level.br_anim["wz_infil_drone_guy_npc3_sh110"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[3], level.br_anim["wz_infil_drone_guy_npc4_sh110"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[4], level.br_anim["wz_infil_drone_guy_npc5_sh110"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[5], level.br_anim["wz_infil_drone_guy_npc6_sh110"]);
    animstruct.packs[n] function_d4561ab1ba4f5de9(animstruct.camerarunner, "tag_origin", level.br_anim["wz_infil_g_prop_sh110"], "wz_infil_xcam_sh110_quads", &getxcamfunc);
    animstruct.packs[n].xcams = ["wz_infil_xcam_sh110_quads", "wz_infil_xcam_sh110_quads", "wz_infil_xcam_sh110_quads", "wz_infil_xcam_sh110_quads"];
    n++;
    var_e92aed86e7dd8b76 = 45;
    quadsfov = 45;
    var_92c2f39adf1c2e62 = 0;
    animstruct.packs[n] = animstruct create_animpack("scene12");
    animstruct.packs[n] add_pack_startfunc([var_e92aed86e7dd8b76, quadsfov, var_92c2f39adf1c2e62], &function_e63ab2e92ddffaa1);
    animstruct.packs[n] function_9afdeab1e38dac18(animstruct, level.br_anim["wz_infil_cargoplane_sh120"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.camerarunner, level.br_anim["wz_infil_g_prop_sh120"]);
    animstruct.packs[n] function_ad0bcac98781e0ab(animstruct.playertags[0], level.br_anim["wz_infil_drone_guy1_sh120"]);
    animstruct.packs[n] function_ad0bcac98781e0ab(animstruct.playertags[1], level.br_anim["wz_infil_drone_guy2_sh120"]);
    animstruct.packs[n] function_ad0bcac98781e0ab(animstruct.playertags[2], level.br_anim["wz_infil_drone_guy3_sh120"]);
    animstruct.packs[n] function_ad0bcac98781e0ab(animstruct.playertags[3], level.br_anim["wz_infil_drone_guy4_sh120"]);
    animstruct.packs[n] function_ad0bcac98781e0ab(animstruct.playertags[4], level.br_anim["wz_infil_drone_guy1_sh120"]);
    animstruct.packs[n] function_f7fc8b110c478968(animstruct.playermodels[0], level.br_anim["wz_infil_drone_guy1_sh120"]);
    animstruct.packs[n] function_f7fc8b110c478968(animstruct.playermodels[1], level.br_anim["wz_infil_drone_guy2_sh120"]);
    animstruct.packs[n] function_f7fc8b110c478968(animstruct.playermodels[2], level.br_anim["wz_infil_drone_guy3_sh120"]);
    animstruct.packs[n] function_f7fc8b110c478968(animstruct.playermodels[3], level.br_anim["wz_infil_drone_guy4_sh120"]);
    animstruct.packs[n] function_f7fc8b110c478968(animstruct.playermodels[4], level.br_anim["wz_infil_drone_guy1_sh120"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.crates[0], level.br_anim["wz_infil_cargobox_sh120"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[0], level.br_anim["wz_infil_drone_guy_npc1_sh120"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[1], level.br_anim["wz_infil_drone_guy_npc2_sh120"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[2], level.br_anim["wz_infil_drone_guy_npc3_sh120"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[3], level.br_anim["wz_infil_drone_guy_npc4_sh120"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[4], level.br_anim["wz_infil_drone_guy_npc5_sh120"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[5], level.br_anim["wz_infil_drone_guy_npc6_sh120"]);
    animstruct.packs[n] function_d4561ab1ba4f5de9(animstruct.camerarunner, "tag_origin", level.br_anim["wz_infil_g_prop_sh120"], "wz_infil_xcam_sh120_quads", &getxcamfunc);
    animstruct.packs[n].xcams = ["wz_infil_xcam_sh120_quads", "wz_infil_xcam_sh120_quads", "wz_infil_xcam_sh120_quads", "wz_infil_xcam_sh120_quads"];
    var_e92aed86e7dd8b76 = 45;
    quadsfov = 45;
    var_92c2f39adf1c2e62 = 0;
    n++;
    animstruct.packs[n] = animstruct create_animpack("looping", 1);
    animstruct.packs[n] add_pack_startfunc([var_e92aed86e7dd8b76, quadsfov, var_92c2f39adf1c2e62], &function_f90e2db4b34d7f57);
    animstruct.packs[n] function_e718ba63d511fcde([], &function_60240beede5e1ab8);
    animstruct.packs[n] function_9afdeab1e38dac18(animstruct, level.br_anim["wz_infil_cargoplane_idle_sh010"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.camerarunner, level.br_anim["wz_infil_g_prop_idle_sh010"]);
    animstruct.packs[n] function_ad0bcac98781e0ab(animstruct.playertags[0], level.br_anim["wz_infil_drone_guy1_idle_sh010"]);
    animstruct.packs[n] function_ad0bcac98781e0ab(animstruct.playertags[1], level.br_anim["wz_infil_drone_guy2_idle_sh010"]);
    animstruct.packs[n] function_ad0bcac98781e0ab(animstruct.playertags[2], level.br_anim["wz_infil_drone_guy3_idle_sh010"]);
    animstruct.packs[n] function_ad0bcac98781e0ab(animstruct.playertags[3], level.br_anim["wz_infil_drone_guy4_idle_sh010"]);
    animstruct.packs[n] function_ad0bcac98781e0ab(animstruct.playertags[4], level.br_anim["wz_infil_drone_guy1_idle_sh010"]);
    animstruct.packs[n] function_f7fc8b110c478968(animstruct.playermodels[0], level.br_anim["wz_infil_drone_guy1_idle_sh010"]);
    animstruct.packs[n] function_f7fc8b110c478968(animstruct.playermodels[1], level.br_anim["wz_infil_drone_guy2_idle_sh010"]);
    animstruct.packs[n] function_f7fc8b110c478968(animstruct.playermodels[2], level.br_anim["wz_infil_drone_guy3_idle_sh010"]);
    animstruct.packs[n] function_f7fc8b110c478968(animstruct.playermodels[3], level.br_anim["wz_infil_drone_guy4_idle_sh010"]);
    animstruct.packs[n] function_f7fc8b110c478968(animstruct.playermodels[4], level.br_anim["wz_infil_drone_guy1_idle_sh010"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[0], level.br_anim["wz_infil_drone_guy_npc1idle_sh010"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[1], level.br_anim["wz_infil_drone_guy_npc2idle_sh010"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[2], level.br_anim["wz_infil_drone_guy_npc3idle_sh010"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[3], level.br_anim["wz_infil_drone_guy_npc4idle_sh010"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[4], level.br_anim["wz_infil_drone_guy_npc5idle_sh010"]);
    animstruct.packs[n] add_pack_modelanim(animstruct.npcs[5], level.br_anim["wz_infil_drone_guy_npc6idle_sh010"]);
    animstruct.packs[n] function_d4561ab1ba4f5de9(animstruct.camerarunner, &function_e128261218fafdaa);
  }

  return animstruct;
}

function function_cc1b64e82fd4680c(players) {
  assertex(isarray(players));
  teams = [];

  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }

    if(!isDefined(teams[player.team])) {
      teams[player.team] = [];
    }

    teams[player.team][teams[player.team].size] = player;
  }

  return teams;
}

function function_f3ae4b41df047ba0(array) {
  var_64be57cf259833de = 0;
  var_e92aed86e7dd8b76 = undefined;
  quadsfov = undefined;
  var_92c2f39adf1c2e62 = 0;

  if(isDefined(array) && array.size >= 2 && isnumber(array[0]) && isnumber(array[1])) {
    var_64be57cf259833de = 1;
    var_e92aed86e7dd8b76 = array[0];
    quadsfov = array[1];
  }

  if(isDefined(array) && array.size >= 3) {
    var_92c2f39adf1c2e62 = array[2];
  }

  pack = self.activepack;
  assert(isDefined(pack));
  pack.var_92c2f39adf1c2e62 = var_92c2f39adf1c2e62;
  var_e49a1c04ac964563 = 0;
  var_1ff908a48d4dc0d3 = 4;

  var_e49a1c04ac964563 = namespace_56a3588493afc984::function_c43d732289ecf3e8();
  var_1ff908a48d4dc0d3 = namespace_56a3588493afc984::function_d8220f4960da76cd();

  function_583f118c4064ca21(level.infilstruct.players);
  teams = function_cc1b64e82fd4680c(level.infilstruct.players);

  foreach(players in teams) {
    numplayers = players.size;

    if(var_e49a1c04ac964563) {
      numplayers = var_1ff908a48d4dc0d3;
    }

    possibleindices = [1, 2, 3, 4];

    if(isDefined(level.var_ca06425e37af610c)) {
      possibleindices = [[level.var_ca06425e37af610c]](numplayers, var_92c2f39adf1c2e62);
    } else if(numplayers == 1) {
      possibleindices = [5];
    } else if(numplayers == 2) {
      if(var_92c2f39adf1c2e62) {
        possibleindices = [1, 4];
      } else {
        possibleindices = [5, 4];
      }
    } else if(var_92c2f39adf1c2e62 && numplayers == 3) {
      possibleindices = [5, 2, 3, 4];
    }

    playercount = 0;

    foreach(player in players) {
      player.infilanimindex = possibleindices[playercount % possibleindices.size];
      player.var_db122a8941dfee14 = numplayers;
      playercount++;
    }

    if(var_64be57cf259833de) {
      var_69ff9b8be936ac16 = quadsfov;

      if(var_92c2f39adf1c2e62 && numplayers == 2) {
        var_69ff9b8be936ac16 = quadsfov;
      } else if(var_92c2f39adf1c2e62 && numplayers == 3) {
        var_69ff9b8be936ac16 = var_e92aed86e7dd8b76;
      } else if(numplayers < 3) {
        var_69ff9b8be936ac16 = var_e92aed86e7dd8b76;
      }

      foreach(player in players) {
        player setclientdvar(@ "cg_fov", var_69ff9b8be936ac16);
        player setclientdvar(@ "hash_71c6c0b8428e44a7", 1);
      }
    }
  }

  if(var_e49a1c04ac964563) {
    pack.var_a39842bcdfc531c2 = 1;
    pack.var_3bd5282b118d27f8 = array_removeundefined(pack.var_3bd5282b118d27f8);

    if(pack.var_3bd5282b118d27f8.size >= 5) {
      foreach(proxy in pack.var_3bd5282b118d27f8) {
        proxy hide();
      }

      if(var_1ff908a48d4dc0d3 == 1) {
        pack.var_3bd5282b118d27f8[4] show();
      } else if(var_1ff908a48d4dc0d3 == 2) {
        if(var_92c2f39adf1c2e62) {
          pack.var_3bd5282b118d27f8[0] show();
          pack.var_3bd5282b118d27f8[3] show();
        } else {
          pack.var_3bd5282b118d27f8[4] show();
          pack.var_3bd5282b118d27f8[3] show();
        }
      } else if(var_1ff908a48d4dc0d3 == 3) {
        if(var_92c2f39adf1c2e62) {
          pack.var_3bd5282b118d27f8[4] show();
          pack.var_3bd5282b118d27f8[1] show();
          pack.var_3bd5282b118d27f8[2] show();
        } else {
          pack.var_3bd5282b118d27f8[0] show();
          pack.var_3bd5282b118d27f8[1] show();
          pack.var_3bd5282b118d27f8[2] show();
        }
      } else {
        pack.var_3bd5282b118d27f8[0] show();
        pack.var_3bd5282b118d27f8[1] show();
        pack.var_3bd5282b118d27f8[2] show();
        pack.var_3bd5282b118d27f8[3] show();
      }

      return;
    }

    if(pack.var_3bd5282b118d27f8.size >= 4) {
      var_2246d8f267e2c3de = 0;

      foreach(proxy in pack.var_3bd5282b118d27f8) {
        if(var_2246d8f267e2c3de < var_1ff908a48d4dc0d3) {
          proxy show();
          continue;
        }

        proxy hide();
      }
    }
  }
}

function private foreach_c130(callbackfunc) {
  if(isDefined(self.staticc130)) {
    self[[callbackfunc]](self.staticc130);
  }

  if(isDefined(self.movingc130)) {
    self[[callbackfunc]](self.movingc130);
  }
}

function private function_7f4bbc61ad158330(c130) {
  c130 show();

  if(isDefined(c130.innards)) {
    c130.innards show();
  }
}

function private function_6c267f4c5a7845ae(c130) {
  c130 setscriptablepartstate("running_lights", "on");
}

function function_c53ec4fa5d1e2eae(teams, var_6d317d76597942a) {
  assert(isarray(teams));
  assert(isarray(var_6d317d76597942a));

  foreach(players in teams) {
    assert(var_6d317d76597942a.size >= players.size);
    sounds = var_6d317d76597942a[players.size - 1];

    for(i = 0; i < players.size; i++) {
      alias = sounds[i];

      if(isstring(alias) && alias != "") {
        function_7acde5feb50c98f2(players, alias);
      }
    }
  }
}

function function_6913bd6620c40d4c() {
  var_ce07a0a6d5c4501 = ter_op(isDefined(level.var_5621a5132074da11), level.var_5621a5132074da11, "mp_saba_infil_exterior");
  self visionsetnakedforplayer(var_ce07a0a6d5c4501, 0);
  var_2a5e082b65f82a5c = getdvarint(@ "hash_7f1da0c3501cbdf2", 1);

  if(var_2a5e082b65f82a5c) {
    self function_451319f93d30ebe5(%"hash_16737cfa86d4521");
  }
}

function function_1a124e836e45482c(array) {
  function_f3ae4b41df047ba0(array);
  foreach_c130(&function_7f4bbc61ad158330);
  self.introplane setscriptablepartstate("running_lights", "on");
  foreach_c130(&function_6c267f4c5a7845ae);
  var_a98a49377dbbb3fb = getdvarint(@ "hash_5fd54d13e95394d5", 0);

  if(var_a98a49377dbbb3fb) {
    setsundirection(anglesToForward((-37, 40, 0)));
    setsuncolorandintensity(0.9294, 0.9608, 1, 0.2);
  }

  br_infil_intro = function_17ee301cf0b5ba85("br_infil_intro");
  br_infil_intro_classic = function_17ee301cf0b5ba85("br_infil_intro_classic");
  function_fe75a89529dd0fd0(level.infilstruct.players, br_infil_intro, undefined, undefined, br_infil_intro_classic);
  function_7acde5feb50c98f2(level.infilstruct.players, "scn_br_c17_infil_ext");
  thread delaystreamtomovingplane();
  var_2a5e082b65f82a5c = getdvarint(@ "hash_7f1da0c3501cbdf2", 1);
  var_a90a02071386e840 = getdvarint(@ "hash_6eff23c71a0d4b51", 1);

  foreach(player in level.infilstruct.players) {
    if(!isDefined(player)) {
      continue;
    }

    player setscriptablepartstate("skydiveVfx", "default", 0);
    player setisinfilskydive(0);
    var_ce07a0a6d5c4501 = ter_op(isDefined(level.var_5621a5132074da11), level.var_5621a5132074da11, "mp_saba_infil_exterior");

    if(isDefined(level.delta_alt)) {
      setsuncolorandintensity(0.07);
      setsundirection(anglesToForward((-59, -96, 0)));
    }

    player visionsetnakedforplayer(var_ce07a0a6d5c4501, 0);

    if(var_2a5e082b65f82a5c) {
      player function_451319f93d30ebe5(%"hash_16737cfa86d4521");
    }

    if(var_a90a02071386e840) {
      player clearpredictedstreampos();
    }
  }

  function_dfb3aefbc657970f();
  function_441fc5517a189a33();
  fadestarttime = get_notetrack_time(level.br_anim["wz_infil_g_prop_sh000"], "fade_to_black_start");
  fadestarttime -= mod(fadestarttime, 0.05);
  fadedowntime = 0.1;
  delaythread(fadestarttime, &function_ea856ec0b3c4cfc6, fadedowntime, level.infilstruct.players, "sh000");
  function_6199c35f4cf4524c(&function_6913bd6620c40d4c);
}

function private function_55e8eca046dc86e1(c130) {
  c130 show();

  if(isDefined(c130.innards)) {
    c130.innards show();
  }

  c130 setscriptablepartstate("running_lights", "off");
  var_a98a49377dbbb3fb = getdvarint(@ "hash_5fd54d13e95394d5", 0);

  if(var_a98a49377dbbb3fb) {
    resetsundirection();
    resetsunlight();
  }
}

function leaderdialog(dialogref) {
  if(!getdvarint(@ "hash_bfded00ac93c45b7", 1)) {
    return;
  }

  soundlength = 2;

  if(soundexists(dialogref)) {
    soundlength = lookupsoundlength(dialogref, 1) / 1000;
  }

  soundname = game["dialog"][dialogref];

  foreach(player in level.infilstruct.players) {
    if(!isDefined(player)) {
      continue;
    }

    player queuedialogforplayer(soundname, dialogref, soundlength);
  }
}

function function_a4a93d249c2219a7() {
  self playlocalsound("scn_br_c17_infil_int");
  infilvisionset = ter_op(isDefined(level.var_269c8213b2c00d6b), level.var_269c8213b2c00d6b, "mp_saba_infil");
  self visionsetnakedforplayer(infilvisionset, 0);
  self setclienttriggeraudiozone("br_c17_infil_int", 0);
  var_2a5e082b65f82a5c = getdvarint(@ "hash_7f1da0c3501cbdf2", 1);

  if(var_2a5e082b65f82a5c) {
    if(isDefined(level.var_46cfc90c68413ca8)) {
      wait 0.1;
      self function_451319f93d30ebe5(%"hash_1249abd27675ff");
      return;
    }

    self function_451319f93d30ebe5(%"hash_1fae1fa57c3e3922");
  }
}

function function_3d33299e71a25af0() {
  self.introplane hide();
  foreach_c130(&function_55e8eca046dc86e1);
  sound = ter_op(isDefined(level.var_4294e392c776520), level.var_4294e392c776520, "scn_br_c17_infil_int");
  function_7acde5feb50c98f2(level.infilstruct.players, sound);
  teams = function_cc1b64e82fd4680c(level.infilstruct.players);
  sounds = [];

  if(isDefined(level.var_983ab0dfcd3f73f3) && isDefined(level.var_983ab0dfcd3f73f3["04"])) {
    sounds = level.var_983ab0dfcd3f73f3["04"];
  } else {
    sounds[0] = ["scn_br_c17_infil_solos_plr1_shot04"];
    sounds[1] = ["scn_br_c17_infil_duos_plr1_shot04", ""];
    sounds[2] = ["scn_br_c17_infil_trios_plr1_shot04", "scn_br_c17_infil_trios_plr2_shot04", "scn_br_c17_infil_trios_plr3_shot04"];
    sounds[3] = ["scn_br_c17_infil_quads_plr1_shot04", "scn_br_c17_infil_quads_plr2_shot04", "scn_br_c17_infil_quads_plr3_shot04", ""];
  }

  function_c53ec4fa5d1e2eae(teams, sounds);
  var_2a5e082b65f82a5c = getdvarint(@ "hash_7f1da0c3501cbdf2", 1);

  foreach(player in level.infilstruct.players) {
    if(!isDefined(player)) {
      continue;
    }

    infilvisionset = ter_op(isDefined(level.var_269c8213b2c00d6b), level.var_269c8213b2c00d6b, "mp_saba_infil");

    if(isDefined(level.delta_alt)) {
      resetsunlight();
      resetsundirection();
    }

    player visionsetnakedforplayer(infilvisionset, 0);
    player setclienttriggeraudiozone("br_c17_infil_int", 0);

    if(var_2a5e082b65f82a5c) {
      if(isDefined(level.var_46cfc90c68413ca8)) {
        wait 0.1;
        player function_451319f93d30ebe5(%"hash_1249abd27675ff");
        continue;
      }

      player function_451319f93d30ebe5(%"hash_1fae1fa57c3e3922");
    }
  }

  function_97fdb5e4895e8651();
  function_1ef7aa0dff43da85();
  thread function_48b6ad7afc978b6c();
  function_6199c35f4cf4524c(&function_a4a93d249c2219a7);
}

function function_baf143dbadb3f80(array) {
  function_f3ae4b41df047ba0(array);
  function_3d33299e71a25af0();
  fadeendtime = get_notetrack_time(level.br_anim["wz_infil_g_prop_sh040"], "fade_to_black_end");
  fadeendtime += 0.05 - mod(fadeendtime, 0.05);
  var_1bb7594c18d17443 = 0.65;
  delaythread(fadeendtime, &function_7f3ad8fe6df1b8fe, var_1bb7594c18d17443, level.infilstruct.players, "sh000");
}

function function_9af898862a8c98b9(array) {
  function_f3ae4b41df047ba0(array);
}

function function_646b15a1f9a1e55a(array) {
  function_f3ae4b41df047ba0(array);
}

function function_a1154be6e3c8a13(array) {
  function_f3ae4b41df047ba0(array);
}

function function_5252a2070a63d534(array) {
  function_f3ae4b41df047ba0(array);
  teams = function_cc1b64e82fd4680c(level.infilstruct.players);
  sounds = [];

  if(isDefined(level.var_983ab0dfcd3f73f3) && isDefined(level.var_983ab0dfcd3f73f3["08"])) {
    sounds = level.var_983ab0dfcd3f73f3["08"];
  } else {
    sounds[0] = ["scn_br_c17_infil_solos_plr1_shot08"];
    sounds[1] = ["scn_br_c17_infil_duos_plr1_shot08", "scn_br_c17_infil_duos_plr2_shot08"];
    sounds[2] = ["scn_br_c17_infil_trios_plr1_shot08", "scn_br_c17_infil_trios_plr2_shot08", "scn_br_c17_infil_trios_plr3_shot08"];
    sounds[3] = ["scn_br_c17_infil_quads_plr1_shot08", "scn_br_c17_infil_quads_plr2_shot08", "scn_br_c17_infil_quads_plr3_shot08", "scn_br_c17_infil_quads_plr4_shot08"];
  }

  function_c53ec4fa5d1e2eae(teams, sounds);
}

function function_6822439c818b5b8d(array) {
  function_f3ae4b41df047ba0(array);
}

function function_516cc7fcafadc9cd() {
  self setclienttriggeraudiozone("br_c17_infil_ext", 3);
}

function function_9cfd7cab1a6e747b(array) {
  function_f3ae4b41df047ba0(array);

  foreach(player in level.infilstruct.players) {
    if(!isDefined(player)) {
      continue;
    }

    player setclienttriggeraudiozone("br_c17_infil_ext", 3);
  }

  function_6199c35f4cf4524c(&function_516cc7fcafadc9cd);
}

function function_2391d520e79f9862(array) {
  function_f3ae4b41df047ba0(array);
  teams = function_cc1b64e82fd4680c(level.infilstruct.players);
  sounds = [];

  if(isDefined(level.var_983ab0dfcd3f73f3) && isDefined(level.var_983ab0dfcd3f73f3["11"])) {
    sounds = level.var_983ab0dfcd3f73f3["11"];
  } else {
    sounds[0] = ["scn_br_c17_infil_solos_plr1_shot11"];
    sounds[1] = ["scn_br_c17_infil_duos_plr1_shot11", "scn_br_c17_infil_duos_plr2_shot11"];
    sounds[2] = ["scn_br_c17_infil_trios_plr1_shot11", "scn_br_c17_infil_trios_plr2_shot11", "scn_br_c17_infil_trios_plr3_shot11"];
    sounds[3] = ["scn_br_c17_infil_quads_plr1_shot11", "scn_br_c17_infil_quads_plr2_shot11", "scn_br_c17_infil_quads_plr3_shot11", "scn_br_c17_infil_quads_plr4_shot11"];
  }

  function_c53ec4fa5d1e2eae(teams, sounds);
  delaythread(0.5, &function_8ff9139b185cac31);
}

function function_161da87df4150ee8() {
  transitionseconds = getdvarfloat(@ "hash_224074cc9cbd34e3", 1);
  self visionsetnakedforplayer("", transitionseconds);
  var_2a5e082b65f82a5c = getdvarint(@ "hash_7f1da0c3501cbdf2", 1);

  if(var_2a5e082b65f82a5c) {
    if(isDefined(level.var_46cfc90c68413ca8)) {
      wait 0.1;
      self function_df8fad503896462(%"hash_1249abd27675ff");
      return;
    }

    self function_df8fad503896462(%"hash_1fae1fa57c3e3922");
  }
}

function function_c337548f4b03bdf2() {
  delayseconds = getdvarfloat(@ "hash_ef579438c4248057", 3.75);
  transitionseconds = getdvarfloat(@ "hash_224074cc9cbd34e3", 1);

  if(delayseconds > 0) {
    wait delayseconds;
  }

  var_2a5e082b65f82a5c = getdvarint(@ "hash_7f1da0c3501cbdf2", 1);

  foreach(player in level.infilstruct.players) {
    if(!isDefined(player)) {
      continue;
    }

    player visionsetnakedforplayer("", transitionseconds);

    if(var_2a5e082b65f82a5c) {
      if(isDefined(level.var_46cfc90c68413ca8)) {
        wait 0.1;
        player function_451319f93d30ebe5(%"hash_1249abd27675ff");
        continue;
      }

      player function_451319f93d30ebe5(%"hash_1fae1fa57c3e3922");
    }
  }

  delaythread(1, &function_f23edad7e7a000c5);
  function_6199c35f4cf4524c(&function_161da87df4150ee8);
}

function function_d231ca558e0ab75d() {
  wait 3;
  function_c79f9300ee85f805(level.players, "solo_cin_igc_music", 3);
  wait 3;
}

function private function_3724b7df63604071() {
  fadestarttime = get_notetrack_time(level.br_anim["wz_infil_g_prop_sh120"], "fade_to_black_start");
  fadeendtime = get_notetrack_time(level.br_anim["wz_infil_g_prop_sh120"], "fade_to_black_end");
  fadestarttime -= mod(fadestarttime, 0.05);
  fadeendtime += 0.05 - mod(fadeendtime, 0.05);
  wait fadestarttime;
  function_ea856ec0b3c4cfc6(0.066, level.infilstruct.players, "sh120");
  wait fadeendtime - fadestarttime;
  function_7f3ad8fe6df1b8fe(0.083, level.infilstruct.players, "sh120");
}

function function_e63ab2e92ddffaa1(array) {
  function_f3ae4b41df047ba0(array);
  level thread function_d231ca558e0ab75d();
  level thread function_c337548f4b03bdf2();
  delayseconds = getdvarfloat(@ "hash_1968fc42f31e7d28", 3.9);

  if(delayseconds > 0) {
    delaythread(delayseconds, &teleporttomovingplane);
  } else {
    teleporttomovingplane();
  }

  level thread function_3724b7df63604071();
  self.movingc130 setscriptablepartstate("running_lights", "on");
  leaderdialog("infil_ac130_5_seconds");
}

function function_8ff9139b185cac31() {
  if(isDefined(level.var_8daaa1383721b20d)) {
    foreach(player in level.infilstruct.players) {
      if(!isDefined(player)) {
        continue;
      }

      var_1caf2ddae606da4d = ter_op(isDefined(level.var_8daaa1383721b20d), level.var_8daaa1383721b20d, "mp_delta_infil_lightswitch(mp_jup_delta_alt)");
      player visionsetnakedforplayer(var_1caf2ddae606da4d, 0);
    }
  }

  light_switches = getentitylessscriptablearray("air_cargo_light_switch", "targetname");

  foreach(ls in light_switches) {
    ls setscriptablepartstate("base", "on_green");
  }

  lightstate = ter_op(isDefined(level.var_d7c4cc78f9c8bbd6), level.var_d7c4cc78f9c8bbd6, "on");
  self.staticc130 setscriptablepartstate("int_lights_red_all", "off");
  self.staticc130 setscriptablepartstate("int_lights_green_all", lightstate);
  function_7acde5feb50c98f2(level.players, "scn_br_c17_infil_jump_buzzer");

  if(isDefined(level.var_8daaa1383721b20d)) {
    function_6199c35f4cf4524c(&function_8daaa1383721b20d);
  }
}

function function_8daaa1383721b20d() {
  var_1caf2ddae606da4d = ter_op(isDefined(level.var_8daaa1383721b20d), level.var_8daaa1383721b20d, "mp_delta_infil_lightswitch(mp_jup_delta_alt)");
  self visionsetnakedforplayer(var_1caf2ddae606da4d, 0);
}

function function_16f307c48e420065() {
  self.movingc130 setscriptablepartstate("int_lights_green_all", "on");
}

function function_97fdb5e4895e8651() {
  light_switches = getentitylessscriptablearray("air_cargo_light_switch", "targetname");

  foreach(ls in light_switches) {
    ls setscriptablepartstate("base", "on_red");
  }

  lightstate = ter_op(isDefined(level.var_d7c4cc78f9c8bbd6), level.var_d7c4cc78f9c8bbd6, "on");
  self.staticc130 setscriptablepartstate("int_lights_red_all", lightstate);
  self.staticc130 setscriptablepartstate("int_lights_green_all", "off");
}

function function_1ef7aa0dff43da85() {
  self.movingc130 setscriptablepartstate("int_lights_green_all", "off");
}

function function_dfb3aefbc657970f() {
  light_switches = getentitylessscriptablearray("air_cargo_light_switch", "targetname");

  foreach(ls in light_switches) {
    ls setscriptablepartstate("base", "off");
  }

  self.staticc130 setscriptablepartstate("int_lights_red_all", "off");
  self.staticc130 setscriptablepartstate("int_lights_green_all", "off");
}

function function_441fc5517a189a33() {
  self.movingc130 setscriptablepartstate("int_lights_green_all", "off");
}

function function_f23edad7e7a000c5() {}

function private c130_looping(c130) {}

function function_f90e2db4b34d7f57(array) {
  function_f3ae4b41df047ba0(array);
  function_f23edad7e7a000c5();
}

function function_60240beede5e1ab8(player, array) {}

function private function_a85e9f36f620029(players, index) {
  foreach(player in players) {
    if(isDefined(player.infilanimindex) && (player.infilanimindex - 1) % 5 + 1 == index) {
      return player;
    }
  }

  return undefined;
}

function private function_406a85847778fb1(index) {
  teams = [];

  foreach(player in level.infilstruct.players) {
    if(!isDefined(player)) {
      continue;
    }

    if(!isDefined(teams[player.team])) {
      teams[player.team] = [];
    }

    teams[player.team][teams[player.team].size] = player;
  }

  foreach(players in teams) {
    numplayers = players.size;
    foundplayer = undefined;

    if(index == 0) {
      foundplayer = function_a85e9f36f620029(players, 1);

      if(!isDefined(foundplayer)) {
        foundplayer = function_a85e9f36f620029(players, 5);
      }
    } else if(index == 1) {
      if(numplayers == 2) {
        foundplayer = undefined;
      } else {
        foundplayer = function_a85e9f36f620029(players, 2);
      }
    } else if(index == 2) {
      foundplayer = function_a85e9f36f620029(players, 3);
    } else {
      assert(index == 3);
      foundplayer = function_a85e9f36f620029(players, 4);
    }

    omnvarvalue = -1;

    if(isDefined(foundplayer)) {
      omnvarvalue = foundplayer getentitynumber();
    }

    foreach(player in players) {
      player setclientomnvar("ui_br_infil_exfil_player_focus", omnvarvalue);
    }
  }
}

function private function_cd7e1a37d5e2ca2b() {
  level.nosuspensemusic = 1;
  thread scripts\mp\music_and_dialog::stopsuspensemusic();
  soundbank = "mp_gamemode_br_infils";

  if(scripts\engine\utility::issharedfuncdefined("br_infils_ac130", "getInfilSoundbank")) {
    soundbank = [[scripts\engine\utility::getsharedfunc("br_infils_ac130", "getInfilSoundbank")]]();
  }

  snd_transient_load(soundbank);
}

function private function_55fb66f4acb3d466() {
  if(getdvarint(@ "hash_6eff23c71a0d4b51", 1)) {
    level.infilstruct.var_2a959f4ba13b75da = 1;
    waitframe();
    streamorigin = level.infilstruct.c130.animstruct.introplane.origin;

    foreach(player in level.players) {
      if(!isDefined(player)) {
        continue;
      }

      player setpredictedstreamloaddist(-1);
      player predictstreamposuntilcleared(streamorigin);
    }
  }
}

function private function_8d050f78fe1d180f() {
  level thread function_55fb66f4acb3d466();
  function_4e8ba327eb12540c(level.players, "solo_cin_igc_music", 2.5);
  clearmusicstate();
  wait 2.5;
  function_c79f9300ee85f805(level.players, "mp_br_lobby_fade", 0);
}

function private function_26874fd7694aa29() {
  level thread function_8d050f78fe1d180f();
}

function function_1a5e2c1cef16393f(camera) {
  function_406a85847778fb1(0);
}

function function_7797914101c3a342(camera) {
  function_406a85847778fb1(1);
}

function function_e86f60ffd1abcd75(camera) {
  function_406a85847778fb1(2);
}

function function_a9090d88a8813828(camera) {
  function_406a85847778fb1(3);
}

function function_72145194f4f38714() {
  soundbank = "mp_gamemode_br_infils";

  if(scripts\engine\utility::issharedfuncdefined("br_infils_ac130", "getInfilSoundbank")) {
    soundbank = [[scripts\engine\utility::getsharedfunc("br_infils_ac130", "getInfilSoundbank")]]();
  }

  function_e66f664ad726f2e();
  snd_transient_unload(soundbank);
  namespace_56a3588493afc984::cleanupents();
}

function function_e128261218fafdaa(player) {
  quads_tag = "j_prop_1";
  var_4febd9f54a7e9968 = "j_prop_17";
  cameratag = quads_tag;

  if(isDefined(player) && isDefined(player.var_db122a8941dfee14)) {
    teamcount = player.var_db122a8941dfee14;
    var_92c2f39adf1c2e62 = 0;

    if(isDefined(self.activepack)) {
      var_92c2f39adf1c2e62 = istrue(self.activepack.var_92c2f39adf1c2e62);
    }

    if(var_92c2f39adf1c2e62 && teamcount == 2) {
      cameratag = quads_tag;
    } else if(var_92c2f39adf1c2e62 && teamcount == 3) {
      cameratag = var_4febd9f54a7e9968;
    } else if(teamcount < 3) {
      cameratag = var_4febd9f54a7e9968;
    }
  }

  return cameratag;
}

function getxcamfunc(player) {
  assert(isDefined(self.xcams));

  if(isDefined(player) && isDefined(player.var_db122a8941dfee14)) {
    assert(player.var_db122a8941dfee14 > 0);
    assert(player.var_db122a8941dfee14 <= self.xcams.size);
    return self.xcams[player.var_db122a8941dfee14 - 1];
  }

  return self.xcams[0];
}

function function_ad4a7a73c7d7d9e0() {
  self clearclienttriggeraudiozone(3);
  var_522a77434d41564a = self getplayerangles(1);
  playerforward = anglesToForward(var_522a77434d41564a);
  planeforward = anglesToForward(level.infilstruct.c130.angles);
  planeright = anglestoright(level.infilstruct.c130.angles);
  dotforward = vectordot(playerforward, planeforward);
  dotright = vectordot(playerforward, planeright);

  if(!isDefined(self.infilanimindex)) {
    self.infilanimindex = 1;
  }

  infilanimindex = self.infilanimindex;

  if(infilanimindex >= 5) {
    infilanimindex = 1;
  }

  player_link_tag = "j_prop_" + infilanimindex + 1;
  cos45 = cos(45);

  if(dotforward < -1 * cos45) {
    return ["wz_infil_gprop_standard_sh010", level.br_anim["wz_infil_gprop_standard_sh010"], "wz_infil_standardforward_jump_sh010", player_link_tag];
  }

  if(dotright > cos45) {
    return ["wz_infil_gprop_l90_sh010", level.br_anim["wz_infil_gprop_l90_sh010"], "wz_infil_l90_jump_sh010", player_link_tag];
  }

  if(dotright < -1 * cos45) {
    return ["wz_infil_gprop_r90_sh010", level.br_anim["wz_infil_gprop_r90_sh010"], "wz_infil_r90_jump_sh010", player_link_tag];
  }

  if(dotright > 0) {
    return ["wz_infil_gprop_l180_sh010", level.br_anim["wz_infil_gprop_l180_sh010"], "wz_infil_l180_jump_sh010", player_link_tag];
  }

  return ["wz_infil_gprop_r180_sh010", level.br_anim["wz_infil_gprop_r180_sh010"], "wz_infil_r180_jump_sh010", player_link_tag];
}

function function_d99d934d14e73d() {
  self endon("disconnect");
  wait 5;
  var_2a5e082b65f82a5c = getdvarint(@ "hash_7f1da0c3501cbdf2", 1);

  if(var_2a5e082b65f82a5c) {
    self function_df8fad503896462(%"hash_16737cfa86d4521");
  }
}

function jumpfunc() {
  thread function_d99d934d14e73d();

  if(getdvarint(@ "hash_549df6ab370a2bc4", 1)) {
    self lerpfovscalefactor(0, 0);
    self setclientdvar(@ "hash_71c6c0b8428e44a7", 0);
  }
}

function function_dc0bc83a31193177() {
  self endon("disconnect");
  self lerpfov(65, 0.5);

  if(getdvarint(@ "hash_549df6ab370a2bc4", 1)) {
    self lerpfovscalefactor(1, 0.5);
  }

  wait 1;

  if(isDefined(self.var_1f0a019572c9f8e2)) {
    self.var_1f0a019572c9f8e2 = undefined;
    self disablephysicaldepthoffieldscripting();
  }

  self setclientdvar(@ "cg_fov", 65);
  self setclientdvar(@ "hash_86bf34d5f48fa435", 65);
  self setclientdvar(@ "hash_71c6c0b8428e44a7", 0);
}

function function_52bedae2ced8e191() {
  cloudfx = level._effect["vfx_br_ac130_clouds"];
  var_8b26de022a9f35f = level._effect["vfx_br_ac130_oneshot"];

  if(isDefined(cloudfx)) {
    stopFXOnTag(cloudfx, self, "tag_body");
  }

  if(isDefined(var_8b26de022a9f35f)) {
    stopFXOnTag(var_8b26de022a9f35f, self, "tag_body");
  }
}

function delaystreamtomovingplane() {
  self endon("stopScene");

  if(isDefined(self.movingc130)) {
    delaytime = getdvarint(@ "hash_d01d0472d843d39e", 8);
    wait delaytime;

    if(!isDefined(self.movingc130)) {
      return;
    }

    streamorigin = self.movingc130.origin;
    forward = getdvarint(@ "hash_7abcda2d7aabbe4c", 0);

    if(forward > 0) {
      dir = anglesToForward(self.movingc130.angles);
      streamorigin = self.movingc130.origin + dir * forward;
    }

    foreach(player in level.infilstruct.players) {
      if(!isDefined(player)) {
        continue;
      }

      player setpredictedstreamloaddist(0);
      player scripts\mp\gametypes\br_public::playerstreamhintlocation(streamorigin);
    }
  }
}

function private function_98486f8b479597e1(percent) {
  if(percent <= 0) {
    percent = 0;
  } else if(percent >= 1) {
    percent = 1;
  }

  var_c5faa94190723347 = int(percent * 100);
  var_c5faa94190723347 -= mod(var_c5faa94190723347, 10);

  if(isPlayer(self)) {
    setwind(string(var_c5faa94190723347), 1);
    return;
  }

  if(self getscriptablehaspart("wind") && self getscriptableparthasstate("wind", string(var_c5faa94190723347))) {
    self setscriptablepartstate("wind", string(var_c5faa94190723347), 1);
  }
}

function private function_48b6ad7afc978b6c() {
  self endon("stopWind");
  var_e8d980a1b17bc221 = self.staticc130.origin;
  var_1ea13aa1f992052f = self.staticc130.angles;

  if(!isDefined(var_1ea13aa1f992052f)) {
    var_1ea13aa1f992052f = (0, 0, 0);
  }

  var_27220e8d699e8148 = anglesToForward(var_1ea13aa1f992052f);
  var_6628001e4283c554 = var_27220e8d699e8148 * -1;
  var_1e51bf3beb996bea = getdvarfloat(@ "hash_35e512315ec17f9e", -200);
  windmaxdistance = getdvarfloat(@ "hash_35c124315e992c7c", 50);
  npcs = array_combine(self.npcs, self.playermodels);

  while(true) {
    operators = array_combine(level.infilstruct.players, npcs);

    foreach(operator in operators) {
      if(!isDefined(operator)) {
        continue;
      }

      var_6f56fa8209dcf5d0 = operator.origin - var_e8d980a1b17bc221;
      projection = math::scalar_projection(var_6628001e4283c554, var_6f56fa8209dcf5d0);
      projectionpercent = (projection - var_1e51bf3beb996bea) / (windmaxdistance - var_1e51bf3beb996bea);
      operator function_98486f8b479597e1(projectionpercent);
    }

    wait 0.5;
  }
}

function private clearplayerwind() {
  self notify("stopWind");
  npcs = array_combine(self.npcs, self.playermodels);
  operators = array_combine(level.infilstruct.players, npcs);

  foreach(operator in operators) {
    if(!isDefined(operator)) {
      continue;
    }

    if(isPlayer(operator)) {
      operator.manualoverridewindmaterial = undefined;
    }

    operator setscriptablepartstate("wind", "1", 1);
  }
}

function function_708e8449a90a636f() {
  wait 0.1;
  function_16f307c48e420065();
  cloudpartname = ter_op(isDefined(level.var_13e59fcf9acfdcff), level.var_13e59fcf9acfdcff, "clouds");

  if(isDefined(self.movingc130)) {
    self.movingc130 setscriptablepartstate("br_fx", cloudpartname);
  }
}

function function_f1462ccad9c4e0be() {
  self.manualoverridewindmaterial = undefined;
  setwind("1");
  self setallstreamloaddist(0);
}

function teleporttomovingplane() {
  clearplayerwind();

  foreach(player in level.infilstruct.players) {
    if(!isDefined(player)) {
      continue;
    }

    player setallstreamloaddist(0);
  }

  if(isDefined(self.movingc130)) {
    self.camerarunner unlink();
    self.camerarunner linkTo(self.movingc130, "tag_body_animate", (0, 0, 0), (0, 0, 0));

    if(!istrue(level.infilstruct.var_df94e780c2b3c994) || function_8663da4077fa7e20()) {
      self.movingc130 notify("start_moving");
    }
  }

  setomnvar("ui_hide_player_icons", 0);
  level notify("teleportToMovingPlane");
  thread function_708e8449a90a636f();
  function_6199c35f4cf4524c(&function_f1462ccad9c4e0be);
}

function function_66b13900c5013de5(var_c26fc18bda607b7) {
  body = scripts\cp_mp\operator::function_8eba78e65f4be793(var_c26fc18bda607b7);
  head = scripts\cp_mp\operator::function_223061772e2a61b9(var_c26fc18bda607b7);

  if(body == "" || head == "") {
    return;
  }

  self function_dd6d30b9ec87c1b3(body, head, "iw9_avatar_scriptable_mp");
}