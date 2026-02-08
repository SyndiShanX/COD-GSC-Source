/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\ber3b_anim.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_anim;
#include maps\ber3_util;
#using_animtree("generic_human");

ber3b_anim_init() {
  setup_level_anims();
  setup_player_interactive_anims();
  setup_eagle_anims();
  setup_chandelier_anims();
  setup_statue_anims();
  setup_roof_flag_anims();
  setup_door_anims();

  maps\_mganim::main();
}

setup_level_anims() {
  level.scr_anim["ai"]["stairs_run_up"] = % ai_staircase_run_up_v1;

  level.scr_anim["collectible"]["collectible_loop"][0] = % ch_ber3b_collectible;

  level.scr_anim["sarge"]["intro_peptalk"] = % ch_berlin3b_intro_reznov;

  addNotetrack_dialogue("sarge", "dialog", "intro_peptalk", "Ber3B_INT_001A_REZN");
  addNotetrack_dialogue("sarge", "dialog", "intro_peptalk", "Ber3B_INT_003A_REZN");
  addNotetrack_dialogue("sarge", "dialog", "intro_peptalk", "Ber3B_INT_005A_REZN");
  addNotetrack_dialogue("sarge", "dialog", "intro_peptalk", "Ber3B_INT_007A_REZN");
  addNotetrack_dialogue("sarge", "dialog", "intro_peptalk", "Ber3B_INT_009A_REZN");

  level.scr_anim["commissar"]["intro_idle"][0] = % ch_berlin3b_intro_commisar_idle;
  level.scr_anim["commissar"]["intro"] = % ch_berlin3b_intro_commisar;

  addNotetrack_dialogue("commissar", "dialog", "intro", "Ber3B_INT_000A_COMM");
  addNotetrack_dialogue("commissar", "dialog", "intro", "Ber3B_INT_002A_COMM");
  addNotetrack_dialogue("commissar", "dialog", "intro", "Ber3B_INT_006A_COMM");
  addNotetrack_dialogue("commissar", "dialog", "intro", "Ber3B_INT_008A_COMM");
  addNotetrack_dialogue("commissar", "dialog", "intro", "Ber3B_INT_004A_COMM");
  addNotetrack_dialogue("commissar", "dialog", "intro", "Ber3B_INT_000A_COMM");

  level.scr_anim["intro_door_closer_1"]["closedoor"] = % ch_berlin3_Reichstag_door_guy1;
  level.scr_anim["intro_door_closer_2"]["closedoor"] = % ch_berlin3_Reichstag_door_guy2;
  level.scr_anim["intro_door_closer_3"]["closedoor"] = % ch_berlin3_Reichstag_door_guy3;
  level.scr_anim["intro_door_closer_4"]["closedoor"] = % ch_berlin3_Reichstag_door_guy4;

  level.scr_anim["flagbearer_death_prefoyer"]["death"] = % ch_berlin3_e2_bearerdeath;
  level.scr_anim["flagbearer_death_prefoyer"]["run_with_flag"] = % ai_flagbearer_stand_run;
  level.scr_anim["flagbearer_death_prefoyer"]["crouch_with_flag"][0] = % ai_flagbearer_crouch_left_idle;

  level.scr_anim["rtag_melee_beater"]["melee1"] = % ch_berlin3_e3_melee_russian;
  level.scr_anim["rtag_melee_victim"]["melee1"] = % ch_berlin3_e3_melee_german;

  level.scr_anim["rtag_melee_beater"]["melee2"] = % ch_berlin3_e3_melee2_russian;
  level.scr_anim["rtag_melee_victim"]["melee2"] = % ch_berlin3_e3_melee2_german;

  level.scr_anim["rtag_melee_beater"]["melee3"] = % ch_berlin3_e3_melee3_russian;
  level.scr_anim["rtag_melee_victim"]["melee3"] = % ch_berlin3_e3_melee3_german;

  level.scr_anim["pacing1_doorkick_guy1"]["idle"][0] = % ch_berlin3_e3_melee4_doorkick_russian1_loop;
  level.scr_anim["pacing1_doorkick_guy2"]["idle"][0] = % ch_berlin3_e3_melee4_doorkick_russian2_loop;
  level.scr_anim["pacing1_doorkick_guy1"]["doorkick"] = % ch_berlin3_e3_melee4_doorkick_russian1;
  level.scr_anim["pacing1_doorkick_guy2"]["doorkick"] = % ch_berlin3_e3_melee4_doorkick_russian2;
  level.scr_anim["pacing1_doorkick_victim1"]["surrender"] = % ch_berlin1_surrendering_scared_a;
  level.scr_anim["pacing1_doorkick_victim2"]["surrender"] = % ch_berlin1_surrendering_scared_b;
  addNotetrack_customFunction("pacing1_doorkick_guy1", "kick", maps\ber3b_event_foyer::pacing1_friendly_doorbreach_dooropen, "doorkick");

  level.scr_anim["sarge"]["balconywave"][0] = % ch_berlin3b_reznov_crouch_waving;

  level.scr_anim["first_balcony_dooropener"]["shoulder"] = % ch_berlin3b_door_bash_short;
  level.scr_anim["downstairs_dooropener"]["shoulder"] = % ch_berlin3b_door_bash;

  level.scr_anim["parliament_molotov_thrower"]["molotov_throw_custom"] = % ch_seelow1_pickup_molotov_a;
  addNotetrack_attach("parliament_molotov_thrower", "attach_molotov", "weapon_rus_molotov_grenade", "tag_weapon_left", "molotov_throw_custom");
  addNotetrack_detach("parliament_molotov_thrower", "detach_molotov", "weapon_rus_molotov_grenade", "tag_weapon_left", "molotov_throw_custom");
  addNotetrack_customFunction("parliament_molotov_thrower", "detach_molotov", maps\_grenade_toss::force_grenade_toss_internal, "molotov_throw_custom");

  level.scr_anim["parliament_doorpusher_1"]["doorpush"] = % ch_berlin3_parliament_door_guy1;
  addNotetrack_dialogue("parliament_doorpusher_1", "dialog", "doorpush", "Ber3B_IGD_038A_RUR1");

  level.scr_anim["parliament_doorpusher_2"]["doorpush"] = % ch_berlin3_parliament_door_guy2;
  addNotetrack_dialogue("parliament_doorpusher_2", "dialog", "doorpush", "Ber3B_IGD_040A_RUR1");

  level.scr_anim["parliament_doorpusher_3"]["doorpush"] = % ch_berlin3_parliament_door_guy3;

  level.scr_anim["parliament_doorpusher_1"]["doorbreach"] = % ch_berlin3_parliament_door2_guy2;
  level.scr_anim["parliament_doorpusher_2"]["doorbreach"] = % ch_berlin3_parliament_door2_guy1;
  level.scr_anim["parliament_doorpusher_3"]["doorbreach"] = % ch_berlin3_parliament_door2_guy3;
  addNotetrack_dialogue("parliament_doorpusher_2", "dialog", "doorbreach", "Ber3B_IGD_041A_RUR2");

  level.scr_anim["parliament_doorholder_1"]["doorbreach"] = % ch_berlin3_parliament_door2_german1;
  level.scr_anim["parliament_doorholder_2"]["doorbreach"] = % ch_berlin3_parliament_door2_german2;
  level.scr_anim["parliament_doorholder_3"]["doorbreach"] = % ch_berlin3_parliament_door2_german3;

  level.scr_sound["fireteam_bazooka_primary"]["bazooka_firing_1"] = "See2_IGD_014A_REZN";
  level.scr_sound["fireteam_bazooka_primary"]["bazooka_firing_2"] = "See1_IGD_302A_REZN";

  level.scr_sound["fireteam_bazooka_primary"]["bazooka_reload"] = "RPG_crouch_reload";
  level.scr_sound["fireteam_bazooka_secondary"]["bazooka_reload"] = "RU_che_inform_reloading_generic_00";

  level.scr_sound["sarge"]["keep_hold_of_flag"] = "Ber3B_IGD_002A_REZN";
  level.scr_sound["sarge"]["protect_the_flag"] = "Ber3B_IGD_003A_REZN";
  level.scr_sound["sarge"]["keep_them_off_flagbearer"] = "Ber3B_IGD_004A_REZN";
  level.scr_sound["sarge"]["clear_path_for_flag"] = "Ber3B_IGD_007A_REZN";

  level.scr_sound["sarge"]["positions_fortified_need_support"] = "RU_che_inform_suppressed_generic_03";
  level.scr_sound["sarge"]["want_bazooka_team"] = "RU_2_order_action_suppress_08";

  level.scr_sound["sarge"]["eagle_loosening"] = "Ber1_IGD_023A_REZN";
  level.scr_sound["eagle_redshirt2"]["aim_for_eagle"] = "RU_rez_landmark_near_eagle_01";

  level.scr_sound["roof_pacing_redshirt1"]["must_be_nearing_roof"] = "Ber3B_IGD_043A_RUR1";
  level.scr_sound["roof_pacing_redshirt2"]["throw_germans_over_edge"] = "Ber3B_IGD_044A_RUR2";
  level.scr_sound["roof_pacing_redshirt1"]["comrades_flooding_in"] = "Ber3B_IGD_045A_RUR1";

  level.scr_sound["sarge"]["let_them_have_our_scraps"] = "Ber3B_IGD_046A_REZN";
  level.scr_sound["sarge"]["keep_going_plant_flag"] = "Ber3B_IGD_047A_REZN";

  level.scr_sound["sarge"]["look_my_brothers"] = "Ber3B_IGD_048A_REZN";

  level.scr_sound["sarge"]["up_there"] = "Ber3B_IGD_051A_REZN";
  level.scr_sound["sarge"]["on_the_balconies"] = "Ber3B_IGD_052A_REZN";
  level.scr_sound["sarge"]["they_have_nowhere_to_go"] = "Ber3B_IGD_054A_REZN";
  level.scr_sound["sarge"]["claim_our_victory"] = "Ber3B_IGD_057A_REZN";

  level.scr_anim["crawl1"]["crawl_crawl"] = % ch_berlin2_crawl1;
  level.scr_anim["crawl1"]["crawl_die"] = % ch_berlin2_crawl1_die;
  level.scr_anim["crawl1"]["crawl_idle"][0] = % ch_berlin2_crawl1_loop;
  level.scr_anim["crawl1"]["crawl_shot"] = % ch_berlin2_crawl1_shot;

  level.scr_anim["crawl2"]["crawl_crawl"] = % ch_berlin2_crawl2;
  level.scr_anim["crawl2"]["crawl_die"] = % ch_berlin2_crawl2_die;
  level.scr_anim["crawl2"]["crawl_idle"][0] = % ch_berlin2_crawl2_loop;
  level.scr_anim["crawl2"]["crawl_shot"] = % ch_berlin2_crawl2_shot;

  level.scr_anim["crawl3"]["crawl_crawl"] = % ch_berlin2_crawl3;
  level.scr_anim["crawl3"]["crawl_die"] = % ch_berlin2_crawl3_die;
  level.scr_anim["crawl3"]["crawl_idle"][0] = % ch_berlin2_crawl3_loop;
  level.scr_anim["crawl3"]["crawl_shot"] = % ch_berlin2_crawl3_shot;

  level.scr_sound["honorguard_misc"]["fur_deutschland"] = "Ber3B_IGD_050A_SSHG";
  level.scr_sound["honorguard_misc"]["give_lives_for_germany"] = "Ber3B_IGD_053A_SSHG";
  level.scr_sound["honorguard_misc"]["fur_das_fuhrer"] = "Ber3B_IGD_016A_SSHG";
  level.scr_sound["honorguard_misc"]["deutschland_uber_alles"] = "Ber3B_IGD_017A_SSHG";
  level.scr_sound["honorguard_misc"]["fur_den_ruhm"] = "Ber3B_IGD_018A_SSHG";
  level.scr_sound["honorguard_misc"]["give_lives_for_fuhrer"] = "Ber3B_IGD_019A_SSHG";
  level.scr_sound["honorguard_misc"]["berlin_never_yours"] = "Ber3B_IGD_020A_SSHG";
  level.scr_sound["honorguard_misc"]["take_them_with_you"] = "Ber3B_IGD_055A_SSHG";

  level.scr_anim["roof_flagbearer_shooter"]["outro_playershot"] = % ch_berlin3b_outro_german_last_stand;

  level.scr_anim["sarge"]["outro_playershot"] = % ch_berlin3b_outro_reznov_last_stand;
  level.scr_anim["player_avatar"]["outro_playershot"] = % p_berlin3b_outro_player_last_stand;

  addNotetrack_dialogue("sarge", "dialog", "outro_playershot", "Ber3B_OUT_000A_REZN");
  addNotetrack_dialogue("sarge", "dialog", "outro_playershot", "Ber3B_OUT_001A_REZN");

  level.scr_anim["sarge"]["outro_beckon_idle"][0] = % ch_berlin3b_outro_reznov_idle;
  level.scr_anim["player_avatar"]["outro_player_stagger_idle"] = % p_berlin3b_outro_flag_crawl;

  level.scr_anim["sarge"]["outro_playerplantflag"] = % ch_berlin3b_outro_reznov_victory;
  level.scr_anim["player_avatar"]["outro_playerplantflag"] = % p_berlin3b_outro_player_plant_flag;

  addNotetrack_dialogue("sarge", "dialog", "outro_playerplantflag", "Ber3B_OUT_002A_REZN");
  addNotetrack_dialogue("sarge", "dialog", "outro_playerplantflag", "Ber3B_OUT_003A_REZN");
  addNotetrack_dialogue("sarge", "dialog", "outro_playerplantflag", "Sni1_IGD_355A_REZN");
  addNotetrack_dialogue("sarge", "dialog", "outro_playerplantflag", "Ber3B_INT_005A_REZN");
}
#using_animtree("player");

setup_player_interactive_anims() {
  level.scr_animtree["player_interactive"] = #animtree;
  level.scr_model["player_interactive"] = "viewmodel_usa_player";

  level.scr_anim["player_interactive"]["outro_playershot"] = % int_ber3_outro_player_last_stand;
  level.scr_anim["player_interactive"]["outro_playerplantflag"] = % int_ber3_player_plant;
}

#using_animtree("ber3b_eagle");

setup_eagle_anims() {
  level.scr_anim["parliament_eagle"]["slip"] = % o_berlin3_eagle_statue_wall1;
  level.scr_anim["parliament_eagle"]["fall"] = % o_berlin3_eagle_statue_wall2;
}

parliament_eagle_anim(animName, animeName, msg) {
  if(isDefined(self.isDoingAnim)) {
    while(self.isDoingAnim) {
      wait(0.05);
    }
  }

  anime = level.scr_anim[animName][animeName];

  self.isDoingAnim = true;

  self UseAnimTree(#animtree);
  self SetFlaggedAnimKnob(msg, anime, 1.0, 0.2, 1.0);
  self waittillmatch(msg, "end");

  self.isDoingAnim = false;
}

#using_animtree("ber3b_chandelier");

setup_chandelier_anims() {
  level.scr_anim["reichstag_chandelier"]["shake"] = % o_berlin3_chandelier;
}

chandelier_anim(animName, animeName, msg, maxDelay) {
  if(isDefined(self.isDoingAnim) && self.isDoingAnim) {
    return;
  }

  anime = level.scr_anim[animName][animeName];

  self.isDoingAnim = true;

  if(isDefined(maxDelay) && maxDelay > 0) {
    wait(RandomFloat(maxDelay));
  }

  self UseAnimTree(#animtree);
  self SetFlaggedAnimKnob(msg, anime, 1.0, 0.2, 1.0);
  self waittillmatch(msg, "end");
  self ClearAnim(anime, 0);

  self.isDoingAnim = false;
}

#using_animtree("ber3b_roof_statue");

setup_statue_anims() {
  level.scr_anim["roof_statue"]["fall"] = % o_berlin3_statue_rooftop;
}

roof_statue_anim(animName, animeName, msg) {
  anime = level.scr_anim[animName][animeName];

  self UseAnimTree(#animtree);
  self SetFlaggedAnimKnob(msg, anime, 1.0, 0.2, 1.0);
  self waittillmatch(msg, "end");
}

#using_animtree("ber3b_roof_flag");

setup_roof_flag_anims() {
  level.scr_anim["roof_flag"]["fall"] = % o_berlin3b_flag_cutdown;
}

roof_flag_init() {
  animSpot = getstruct_safe("struct_roof_nazi_flag_animref", "targetname");
  animSpot.angles = (0, 0, 0);
  anime = level.scr_anim["roof_flag"]["fall"];

  spawnOrigin = GetStartOrigin(animSpot.origin, animSpot.angles, anime);
  spawnAngles = GetStartAngles(animSpot.origin, animSpot.angles, anime);
  flag = spawn("script_model", spawnOrigin);
  flag setModel("anim_nazi_flag_burnt_rope");

  level waittill("pole_sparks");

  flag UseAnimTree(#animtree);
  flag SetFlaggedAnimKnob("flag_anim", anime, 1.0, 0.2, 1.0);
  flag waittillmatch("flag_anim", "end");
}

#using_animtree("ber3b_doors");

setup_door_anims() {
  level.scr_anim["parliament_door_left"]["doorpush"] = % o_berlin3_parliament_door_left_seq1;
  level.scr_anim["parliament_door_right"]["doorpush"] = % o_berlin3_parliament_door_right_seq1;

  level.scr_anim["parliament_door_left"]["doorbreach"] = % o_berlin3_parliament_door_left;
  level.scr_anim["parliament_door_right"]["doorbreach"] = % o_berlin3_parliament_door_right;

  level.scr_anim["pacing1_doorbreach_door"]["doorkick"] = % o_berlin3_office_door_kink_in;

  level.scr_anim["reichstag_frontdoor_1"]["closedoor"] = % o_berlin3_Reichstag_door_1;
  level.scr_anim["reichstag_frontdoor_2"]["closedoor"] = % o_berlin3_Reichstag_door_2;
  level.scr_anim["reichstag_frontdoor_3"]["closedoor"] = % o_berlin3_Reichstag_door_3;
  level.scr_anim["reichstag_frontdoor_4"]["closedoor"] = % o_berlin3_Reichstag_door_4;
}
reichstag_dooranim(animName, animeName, msg, doConnectPaths) {
  if(!isDefined(doConnectPaths)) {
    doConnectPaths = true;
  }

  if(isDefined(self.isDoingAnim)) {
    while(self.isDoingAnim) {
      wait(0.05);
    }
  }

  if(doConnectPaths) {
    self ConnectPaths();
  }

  anime = level.scr_anim[animName][animeName];

  org = spawn("script_model", self.origin);
  org setModel("tag_origin_animate");

  self.isDoingAnim = true;

  self LinkTo(org, "origin_animate_jnt");

  org UseAnimTree(#animtree);
  org SetFlaggedAnimKnob(msg, anime, 1.0, 0.2, 1.0);
  org waittillmatch(msg, "end");

  if(doConnectPaths) {
    self DisconnectPaths();
  }

  self Unlink();
  org Delete();

  self.isDoingAnim = false;
}
#using_animtree("generic_human");

preview_anim_single(triggerTN, animname, anime, isAxis) {
  trig = GetEnt(triggerTN, "targetname");
  ASSERTEX(isDefined(trig), "trigger can't be found.");

  animSpot = GetStruct(trig.target, "targetname");
  ASSERTEX(isDefined(animSpot), "anim spot (targetname " + trig.target + ") can't be found.");

  trig waittill("trigger");
  trig Delete();

  guy = spawn("script_model", animSpot.origin);
  guy.angles = animSpot.angles;

  if(!isDefined(isAxis)) {
    isAxis = false;
  }

  if(isAxis) {
    guy setup_axis_char_model();
  } else {
    guy setup_ally_char_model();
  }

  guy UseAnimTree(#animtree);
  guy.animname = animname;
  guy.targetname = animname + "_guy";

  animSpot anim_single_solo(guy, anime);
  guy waittill("single anim");

  wait(1);
  guy Delete();
}
setup_ally_char_model() {
  self character\char_rus_r_ppsh::main();
}

setup_axis_char_model() {
  self character\char_ger_honorguard_mp44::main();
}