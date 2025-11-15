/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\oki2_anim.gsc
*****************************************************/

#include maps\_utility;
#include maps\_anim;

main() {
  init_anims();
  init_spiderhole_anims();
  init_lid_anims();
  init_mg_tarp();
  maps\_mganim::main();
}

#using_animtree("generic_human");

init_anims() {
  level.scr_anim["guy1"]["here_comes"] = % Oki2_pointing_plane;
  level.scr_sound["sarge"]["moveout"] = "Oki2_IGD_000A_ROEB";
  level.scr_sound["polonsky"]["skinny"] = "Oki2_IGD_001A_POLO";
  level.scr_sound["sarge"]["gordon"] = "Oki2_IGD_002A_ROEB";
  level.scr_sound["polonsky"]["supplies"] = "Oki2_IGD_003A_POLO";
  level.scr_sound["sarge"]["coming"] = "Oki2_IGD_004A_ROEB";
  level.scr_sound["polonsky"]["when"] = "Oki2_IGD_005A_POLO";
  level.scr_sound["sarge"]["uphill"] = "Oki2_IGD_006A_ROEB";
  level.scr_sound["sarge"]["spreadout"] = "Oki2_IGD_008A_ROEB";
  level.scr_sound["sarge"]["spiderholes"] = "Oki2_IGD_009A_ROEB";
  level.scr_sound["sarge"]["returnfire"] = "Oki2_IGD_010A_ROEB";
  level.scr_sound["sarge"]["burngrass"] = "Oki2_IGD_011A_ROEB";
  level.scr_sound["sarge"]["fortifiedmg"] = "Oki2_IGD_007A_ROEB";
  level.scr_sound["polonsky"]["mgcovered"] = "Oki2_IGD_012A_POLO";
  level.scr_sound["sarge"]["popsmoke"] = "Oki2_IGD_013A_ROEB";
  level.scr_sound["polonsky"]["smokereminder"] = "Oki2_IGD_014A_POLO";
  level.scr_sound["sarge"]["smokereminder"] = "Oki2_IGD_015A_ROEB";
  level.scr_sound["sarge"]["cantseeus"] = "Oki2_IGD_016A_ROEB";
  level.scr_sound["sarge"]["clearbunker"] = "Oki2_IGD_017A_ROEB";
  level.scr_sound["sarge"]["throughcaves"] = "Oki2_IGD_018A_ROEB";
  level.scr_sound["sarge"]["threeactive"] = "Oki2_IGD_022A_ROEB";
  level.scr_sound["sarge"]["flankround"] = "Oki2_IGD_023A_ROEB";
  level.scr_sound["sarge"]["flamenag"] = "Oki2_IGD_024A_ROEB";
  level.scr_sound["sarge"]["satchelnag1"] = "Oki2_IGD_025A_ROEB";
  level.scr_sound["sarge"]["satchelnag2"] = "Oki2_IGD_027A_ROEB";
  level.scr_sound["sarge"]["satchelnag3"] = "Oki2_IGD_103A_ROEB";
  level.scr_sound["polonsky"]["hurryitup"] = "Oki2_IGD_028A_POLO";
  level.scr_sound["sarge"]["finishjob"] = "Oki2_IGD_029A_ROEB";
  level.scr_sound["sarge"]["onedown"] = "Oki2_IGD_030A_ROEB";
  level.scr_sound["sarge"]["twodown"] = "Oki2_IGD_031A_ROEB";
  level.scr_sound["sarge"]["otherside"] = "Oki2_IGD_032A_ROEB";
  level.scr_sound["sarge"]["lastone"] = "Oki2_IGD_033A_ROEB";
  level.scr_sound["sarge"]["tanksmoving"] = "Oki2_IGD_034A_ROEB";
  level.scr_sound["polonsky"]["mortarfire"] = "Oki2_IGD_037A_POLO";
  level.scr_sound["sarge"]["takecover"] = "Oki2_IGD_038A_ROEB";
  level.scr_sound["polonsky"]["fortress"] = "Oki2_IGD_035A_POLO";
  level.scr_sound["polonsky"]["seepaths"] = "Oki2_IGD_039A_POLO";
  level.scr_sound["polonsky"]["snipersintrees"] = "Oki2_IGD_100A_POLO";
  level.scr_sound["sarge"]["iseeem"] = "Oki2_IGD_101A_ROEB";
  level.scr_sound["sarge"]["bringemdown"] = "Oki2_IGD_102A_ROEB";
  level.scr_sound["sarge"]["burnthose"] = "Oki2_IGD_104A_ROEB";
  level.scr_sound["sarge"]["goddamnflames"] = "Oki2_IGD_105A_ROEB";
  level.scr_sound["polonsky"]["burnem"] = "Oki2_IGD_106A_POLO";
  level.scr_sound["polonsky"]["flamethose"] = "Oki2_IGD_107A_POLO";
  level.scr_sound["sarge"]["meetme"] = "Oki2_IGD_108A_ROEB";
  level.scr_sound["polonsky"]["whatnow"] = "Oki2_IGD_109A_POLO";
  level.scr_sound["sarge"]["keepmovingpolonsky"] = "Oki2_IGD_110A_ROEB";
  level.scr_sound["sarge"]["keepmoving"] = "Oki2_IGD_111A_ROEB";
  level.scr_sound["sarge"]["stayincover"] = "Oki2_IGD_112A_ROEB";
  level.scr_sound["polonsky"]["tunnelahead"] = "Oki2_IGD_113A_POLO";
  level.scr_sound["sarge"]["goodworkpeople"] = "Oki2_IGD_114A_ROEB";
  level.scr_sound["sarge"]["convoyenroute"] = "Oki2_IGD_115A_ROEB";
  level.scr_sound["sarge"]["upladder"] = "Oki2_IGD_120A_ROEB";
  level.scr_sound["sarge"]["areasecured"] = "Oki2_IGD_119A_ROEB";
  level.scr_sound["sarge"]["mortarpositions"] = "Oki2_IGD_118A_ROEB";
  level.scr_sound["sarge"]["REFERENCE"] = "Oki2_IGD_116A_ROEB";
  level.scr_sound["sarge"]["REFERENCE"] = "Oki2_IGD_117A_ROEB";
  level.scr_sound["sarge"]["outstandingmarines"] = "Oki2_IGD_121A_ROEB";
  level.scr_sound["sarge"]["outfuckingstanding"] = "Oki2_IGD_122A_ROEB";
  level.scr_sound["sarge"]["tendwounded"] = "Oki2_IGD_123A_ROEB";
  level.scr_sound["sarge"]["miller"] = "Oki2_OUT_001A_ROEB";
  level.scr_sound["sarge"]["holdonkid"] = "Oki2_OUT_002A_ROEB";
  level.scr_sound["sarge"]["onthetruck"] = "Oki2_OUT_003A_ROEB";
  level.scr_sound["co"]["movingout"] = "Oki2_OUT_004A_MAJG";
  level.scr_sound["sarge"]["onetwothree"] = "Oki2_OUT_005A_ROEB";
  level.scr_sound["sarge"]["itsnotbad"] = "Oki2_OUT_006A_ROEB";
  level.scr_sound["polonsky"]["youleavin"] = "Oki2_OUT_007A_POLO";
  level.scr_sound["co"]["shuricastle"] = "Oki2_OUT_008A_MAJG";
  level.scr_sound["polonsky"]["runninonempty"] = "Oki2_OUT_009A_POLO";
  level.scr_sound["co"]["supplydrop"] = "Oki2_OUT_010A_MAJG";
  level.scr_sound["polonsky"]["holdout"] = "Oki2_OUT_011A_POLO";
  level.scr_sound["polonsky"]["bullshit"] = "Oki2_OUT_012A_POLO";
  level.scr_sound["polonsky"]["hearthissarge"] = "Oki2_OUT_013A_POLO";
  level.scr_sound["co"]["deserted"] = "Oki2_OUT_014A_MAJG";
  level.scr_sound["guy1"]["wegotyou"] = "Oki2_OUT_015A_COR1";
  level.scr_sound["co"]["boathome"] = "Oki2_OUT_016A_MAJG";
  level.scr_sound["polonsky"]["crockofshit"] = "Oki2_OUT_017A_POLO";
  level.scr_sound["guy2"]["staycalm"] = "Oki2_OUT_500A_COR2";
  level.scr_sound["guy2"]["conscious"] = "Oki2_OUT_501A_COR2";
  level.scr_anim["sarge"]["door_kick"] = % door_kick_in;
  level.scr_anim["sarge"]["door_bash"] = % ch_holland3_door_bash;
  addNotetrack_sound("sarge", "bash", "door_bash", "metal_door_kick");
  addNotetrack_customFunction("sarge", "oki2_bash", maps\oki2::move_e3_start_gate, "door_bash");
  level.scr_anim["bayonet_guy1"]["flipover"] = % ch_bayonet_flipover_guy1;
  level.scr_anim["bayonet_guy2"]["flipover"] = % ch_bayonet_flipover_guy2;
}

#using_animtree("spiderhole_model");

init_lid_anims() {
  PrecacheModel("tag_origin_animate");
  level.scr_animtree["spiderhole_lid"] = #animtree;
  level.scr_anim["spiderhole_lid"]["jump_out"] = % o_spiderhole_jump_out_lid;
  level.scr_anim["spiderhole_lid"]["stumble_out"] = % o_spiderhole_stumble_out_lid;
  level.scr_anim["spiderhole_lid"]["grenade_toss"] = % o_spiderhole_grenade_toss_lid;
  level.scr_anim["spiderhole_lid"]["gun_spray"] = % o_spiderhole_gun_spray_lid;
  level.scr_anim["spiderhole_lid"]["idle"] = % o_spiderhole_idle_lid;
  level.scr_anim["spiderhole_lid"]["crouch2stand"] = % o_spiderhole_jump_out_lid;
  level.scr_anim["spiderhole_lid"]["jump_attack"] = % o_spiderhole_jump_attack_lid;
}

#using_animtree("generic_human");

init_spiderhole_anims() {
  level.scr_anim["spiderhole"]["sprint"][0] = % ai_bonzai_sprint_a;
  level.scr_anim["spiderhole"]["sprint"][1] = % ai_bonzai_sprint_b;
  level.scr_anim["spiderhole"]["sprint"][2] = % ai_bonzai_sprint_c;
  level.scr_anim["spiderhole"]["jump_out"] = % ai_spiderhole_jump_out;
  level.scr_anim["spiderhole"]["stumble_out"] = % ai_spiderhole_stumble_out;
  level.scr_anim["spiderhole"]["grenade_toss"] = % ai_spiderhole_grenade_toss;
  level.scr_anim["spiderhole"]["gun_spray"] = % ai_spiderhole_gun_spray;
  level.scr_anim["spiderhole"]["crouch2stand"] = % crouch2stand;
  level.scr_anim["spiderhole"]["jump_attack"] = % ai_spiderhole_jump_attack;
  level.scr_anim["spiderhole"]["spiderhole_idle_crouch"][0] = % ai_spiderhole_idle;
  level.scr_anim["generic"]["combat_jog"] = % combat_jog;
  level.scr_anim["collectible"]["collectible_loop"][0] = % ch_oki2_collectible;
}

#using_animtree("oki3_models");

init_mg_tarp() {
  level.scr_animtree["mg_curtains"] = #animtree;
  level.scr_anim["mg_curtains"]["intro"] = % o_clothblinders_flap_intro;
  level.scr_anim["mg_curtains"]["loop"] = % o_clothblinders_flap_loop;
  level.scr_anim["mg_curtains"]["outro"] = % o_clothblinders_flap_outro;
}