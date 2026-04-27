/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\gulag_anim.gsc
********************************************************/

#include maps\_anim;
#include maps\_utility;
#include common_scripts\utility;
#using_animtree("generic_human");
gulag_anim() {
  gulag_anims();
  gulag_vo();
  gulag_script_models();
  gulag_vehicles();
  gulag_player();
}

gulag_anims() {
  level.scr_anim["operator"]["pulldown"] = % gulag_slamraam_tarp_pull_guy2_v1;
  level.scr_anim["operator"]["idle"][0] = % gulag_slamraam_tarp_idle_guy2_v1;

  level.scr_anim["puller"]["pulldown"] = % gulag_slamraam_tarp_pull_guy1_v1;

  level.scr_anim["generic"]["rappel_start"] = % gulag_rappel_soldier;

  level.scr_anim["pilot"]["idle"][0] = % F15_pilot_idle;
  level.scr_animtree["pilot"] = #animtree;
  level.scr_anim["generic"]["sewer_slide"] = % gulag_sewer_slide;

  level.scr_anim["generic"]["breach_stackL_approach"] = % breach_stackL_approach;
  level.scr_anim["generic"]["death_explosion_stand_B_v3"] = % death_explosion_stand_B_v3;
  level.scr_anim["generic"]["react_stand_2_run_R45"] = % react_stand_2_run_R45;
  level.scr_anim["generic"]["execution_fightback_guy1_03"] = % execution_fightback_guy1_03;
  level.scr_anim["generic"]["execution_fightback_guy2_03"] = % execution_fightback_guy2_03;
  level.scr_anim["generic"]["execution_fightback_guy2_03_survives"] = % execution_fightback_guy2_03_survives;
  level.scr_anim["generic"]["execution_fightback_guy2_03_death"] = % execution_fightback_guy2_03_death;

  addNotetrack_customFunction("generic", "slide_start", ::slide_start, "sewer_slide");
  addNotetrack_customFunction("generic", "slide_end", ::slide_stop, "sewer_slide");
  addNotetrack_customFunction("generic", "slide_land", ::slide_land, "sewer_slide");
  addNotetrack_customFunction("generic", "slide_land_deep", ::slide_land_deep, "sewer_slide");

  level.scr_anim["ghost"]["laptop_approach"] = % laptop_sit_runin;
  level.scr_anim["ghost"]["laptop_idle"][0] = % laptop_sit_idle_active;
  level.scr_anim["ghost"]["laptop_idle"][1] = % laptop_sit_idle_calm;
  level.scr_anim["ghost"]["laptop_idle"][2] = % laptop_sit_idle_flinch;

  level.scr_anim["generic"]["grenade_throw"] = % corner_standr_grenade_b;
  addNotetrack_customFunction("generic", "grenade_throw", ::throw_flash, "grenade_throw");
}

throw_flash(guy) {
  flash_start = getstruct("flash_org", "targetname");
  flash_end = getstruct(flash_start.target, "targetname");
  start = flash_start.origin;
  end = flash_end.origin;

  MagicGrenade("flash_grenade", start, end, 0.9);
  wait(1.0);
  level notify("flashed_room");
}

slide_start(guy) {
  slide_fx = getFX("water_slide");

  guy endon("stop_slide_fx");
  guy endon("death");
  while(true) {
    playFXOnTag(slide_fx, guy, "tag_origin");
    wait(.1);
  }
}

slide_stop(guy) {
  guy notify("stop_slide_fx");
}

slide_land(guy) {
  if(!isDefined(guy.slide_landed)) {
    index = guy get_my_index();

    guy.slide_landed = true;

    guy playSound("scn_gulag_sewer_slide_friend" + index);
  }

  slide_start_fx = getFX("water_slide_start");
  playFXOnTag(slide_start_fx, guy, "tag_origin");
}

slide_land_deep(guy) {
  if(!isDefined(guy.slide_landed_deep)) {
    index = guy get_my_index();

    guy.slide_landed_deep = true;

    guy playSound("scn_gulag_sewer_splash_friend" + index);
  }

  slide_splash_fx = getFX("water_slide_splash");
  playFXOnTag(slide_splash_fx, guy, "tag_origin");
}

get_my_index() {
  allies = getaiarray("allies");
  foreach(index, ai in allies) {
    if(ai == self) {
      break;
    }
  }

  index %= 3;
  index++;
  assert(index > 0 && index < 4);
  return index;
}

#using_animtree("script_model");
gulag_script_models() {
  level.scr_animtree["tarp"] = #animtree;
  level.scr_anim["tarp"]["pulldown"] = % gulag_slamraam_tarp_simulation;
  level.scr_model["tarp"] = "slamraam_tarp";

  level.scr_animtree["ai_rope"] = #animtree;
  level.scr_model["ai_rope"] = "gulag_rappel_rope_soldier_60ft";
  level.scr_anim["ai_rope"]["rappel_start"] = % gulag_rappel_soldier_rope_60ft;

  level.scr_animtree["player_rope"] = #animtree;
  level.scr_model["player_rope"] = "gulag_rappel_rope_player_60ft";
  level.scr_anim["player_rope"]["rappel_start"] = % gulag_rappel_player_rope_60ft;

  level.scr_animtree["player_rope_obj"] = #animtree;
  level.scr_model["player_rope_obj"] = "gulag_rappel_rope_player_60ft_obj";
  level.scr_anim["player_rope_obj"]["rappel_start"] = % gulag_rappel_player_rope_60ft;

  level.scr_animtree["folding_chair"] = #animtree;
  level.scr_model["folding_chair"] = "com_folding_chair";
  level.scr_anim["folding_chair"]["laptop_approach"] = % laptop_chair_runin;

  level.scr_animtree["strangle_chain"] = #animtree;
  level.scr_model["strangle_chain"] = "strangle_chain";
  level.scr_anim["strangle_chain"]["price_breach"] = % gulag_strangle_chain;
}

#using_animtree("player");
gulag_player() {
  level.scr_anim["player_rappel"]["rappel_start"] = % gulag_rappel_player;
  level.scr_animtree["player_rappel"] = #animtree;
  level.scr_model["player_rappel"] = "viewhands_player_udt";
}

#using_animtree("vehicles");
gulag_vehicles() {
  level.rotate_anims_vehicle = [];
  level.rotate_anims_vehicle["x_right"] = % rotate_body_X_R;

  level.scr_animtree["f15"] = #animtree;
  level.scr_model["f15"] = "vehicle_f15";

  level.scr_animtree["f15"] = #animtree;
  level.scr_model["f15"] = "vehicle_f15";
  level.scr_anim["f15"]["intro_1"] = % gulag_F15_intro_1;
  level.scr_sound["f15"]["intro_1"] = "scn_gulag_f15_jet1";

  level.scr_anim["f15"]["landing_gear"] = % mig_landing_gear_up;

  level.scr_anim["f15"]["intro_2"] = % gulag_F15_intro_2;
  level.scr_sound["f15"]["intro_2"] = "scn_gulag_f15_jet2";
  addNotetrack_customFunction("f15", "explode", ::f15_explode);

  level.scr_animtree["intro_1_missile"] = #animtree;
  level.scr_model["intro_1_missile"] = "vehicle_f15_missile";
  level.scr_anim["intro_1_missile"]["missile_fire_a"] = % gulag_missile_F15_1_A;

  level.scr_animtree["intro_1_missile"] = #animtree;
  level.scr_model["intro_1_missile"] = "vehicle_f15_missile";
  level.scr_anim["intro_1_missile"]["missile_fire_b"] = % gulag_missile_F15_1_B;

  level.scr_animtree["intro_2_missile"] = #animtree;
  level.scr_model["intro_2_missile"] = "vehicle_f15_missile";
  level.scr_anim["intro_2_missile"]["missile_fire_a"] = % gulag_missile_F15_2_A;

  level.scr_animtree["intro_2_missile"] = #animtree;
  level.scr_model["intro_2_missile"] = "vehicle_f15_missile";
  level.scr_anim["intro_2_missile"]["missile_fire_b"] = % gulag_missile_F15_2_B;

  addNotetrack_customFunction("f15", "missile", ::f15_fire_missile);
  addNotetrack_customFunction("f15", "missile_fx", ::f15_missile_fx);
  addNotetrack_customFunction("f15", "afterburner", ::f15_afterburner);
}

f15_fire_missile(f15) {
  if(f15.scene == "intro_1") {
    f15.missiles[0] playSound("scn_gulag_f15_missile_fire1");
  } else {
    f15.missiles[0] playSound("scn_gulag_f15_missile_fire2");
  }

  brackets = getfx("missile_brackets");

  foreach(model in f15.missiles) {
    model show();
    playFXOnTag(brackets, model, "TAG_FX");
  }
}

f15_missile_fx(f15) {
  wait(0.3);
  trail = getfx("javelin_trail");
  ignition = getfx("javelin_ignition");

  if(level.looker_f15 == f15) {
    level.looker_f15 = f15.missiles[0];
    level notify("switch_look");
  }

  foreach(model in f15.missiles) {
    model show();
    playFXOnTag(trail, model, "TAG_FX");
    playFXOnTag(ignition, model, "TAG_FX");
  }
}

f15_afterburner(f15) {
  jet_afterburn_ignites = getfx("jet_afterburner_ignite");
  playFXOnTag(jet_afterburn_ignites, f15, "tag_engine_left");
  playFXOnTag(jet_afterburn_ignites, f15, "tag_engine_right");

  f15 ent_flag_set("contrails");
}

missile_launch_fx(missile) {
  missile endon("death");
  smoke = getfx("missile_trail");

  for(;;) {
    playFXOnTag(smoke, missile, "tag_weapon");
    wait(0.05);
  }
}

f15_explode(f15) {
  fx = getfx("missile_explosion");
  playFXOnTag(fx, f15, "le_side_wing_jnt");
  f15 thread maps\gulag_fx::f15_smoke();
}

#using_animtree("generic_human");
gulag_vo() {
  level.scr_sound["soap"]["gulag_rpt_30sec"] = "gulag_rpt_30sec";
  level.scr_face["soap"]["gulag_rpt_30sec"] = % gulag_rpt_30sec;

  level.scr_radio["gulag_hrp1_angelsone"] = "gulag_hrp1_angelsone";

  level.scr_radio["gulag_lbp1_gogetem"] = "gulag_lbp1_gogetem";

  level.scr_radio["gulag_fp1_goodtone"] = "gulag_fp1_goodtone";

  level.scr_radio["gulag_fp2_goodkill"] = "gulag_fp2_goodkill";

  level.scr_radio["gulag_fp1_niceday"] = "gulag_fp1_niceday";

  level.scr_radio["gulag_lbp1_copies"] = "gulag_lbp1_copies";

  level.scr_radio["gulag_lbp2_copiesall"] = "gulag_lbp2_copiesall";

  level.scr_radio["gulag_lbp3_solidcopy"] = "gulag_lbp3_solidcopy";

  level.scr_radio["gulag_lbp2_goinghot"] = "gulag_lbp2_goinghot";

  level.scr_radio["gulag_lbp1_roger"] = "gulag_lbp1_roger";

  level.scr_radio["gulag_lbp2_guns"] = "gulag_lbp2_guns";

  level.scr_radio["gulag_lbp2_guns2"] = "gulag_lbp2_guns2";

  level.scr_radio["gulag_lbp1_goodeffect"] = "gulag_lbp1_goodeffect";

  level.scr_radio["gulag_lbp2_peeling"] = "gulag_lbp2_peeling";

  level.scr_radio["gulag_lbp1_startattack"] = "gulag_lbp1_startattack";

  level.scr_radio["gulag_lbp3_rollingin"] = "gulag_lbp3_rollingin";

  level.scr_sound["soap"]["gulag_rpt_stbyengage"] = "gulag_rpt_stbyengage";

  level.scr_sound["soap"]["gulag_rpt_stabilize"] = "gulag_rpt_stabilize";

  level.scr_radio["gulag_lbp1_roger2"] = "gulag_lbp1_roger2";

  level.scr_radio["gulag_tco_ontarget"] = "gulag_tco_ontarget";

  level.scr_sound["soap"]["gulag_rpt_clearedengage"] = "gulag_rpt_clearedengage";

  level.scr_sound["soap"]["gulag_rpt_shiftright"] = "gulag_rpt_shiftright";

  level.scr_radio["gulag_lbp1_shifting"] = "gulag_lbp1_shifting";

  level.scr_radio["gulag_rpt_stabilize2"] = "gulag_rpt_stabilize2";

  level.scr_radio["gulag_lbp1_ready"] = "gulag_lbp1_ready";

  level.scr_radio["gulag_wrm_ontarget"] = "gulag_wrm_ontarget";

  level.scr_sound["soap"]["gulag_rpt_shiftright2"] = "gulag_rpt_shiftright2";

  level.scr_radio["gulag_lbp1_shifting2"] = "gulag_lbp1_shifting2";

  level.scr_radio["gulag_rpt_stabilize3"] = "gulag_rpt_stabilize3";

  level.scr_radio["gulag_lbp1_ready2"] = "gulag_lbp1_ready2";

  level.scr_radio["gulag_wrm_ontarget2"] = "gulag_wrm_ontarget2";

  level.scr_radio["gulag_tco_ontarget2"] = "gulag_tco_ontarget2";

  level.scr_radio["gulag_rpt_takeemout"] = "gulag_rpt_takeemout";

  level.scr_radio["gulag_lbp1_hangon"] = "gulag_lbp1_hangon";

  level.scr_radio["gulag_rpt_tooclose"] = "gulag_rpt_tooclose";

  level.scr_radio["gulag_hqr_moretime"] = "gulag_hqr_moretime";

  level.scr_radio["gulag_tco_goodorbad"] = "gulag_tco_goodorbad";

  level.scr_radio["gulag_tco_goodorbad"] = "gulag_gst_yanks2";

  level.scr_radio["gulag_tco_goodorbad"] = "gulag_gst_yanks1";

  level.scr_radio["gulag_rpt_cutchatter"] = "gulag_rpt_cutchatter";
  level.scr_anim["gulag_rpt_cutchatter"] = % gulag_rpt_cutchatter;

  level.scr_radio["gulag_lbp2_firstwave"] = "gulag_lbp2_firstwave";

  level.scr_radio["gulag_lbp2_ondeck"] = "gulag_lbp2_ondeck";

  level.scr_radio["gulag_lbp2_holdingpatt"] = "gulag_lbp2_holdingpatt";

  level.scr_radio["gulag_lbp1_2ndwave"] = "gulag_lbp1_2ndwave";

  level.scr_radio["gulag_lbp1_50ft"] = "gulag_lbp1_50ft";

  level.scr_radio["gulag_lbp1_10ft"] = "gulag_lbp1_10ft";

  level.scr_radio["gulag_lbp1_touchdown"] = "gulag_lbp1_touchdown";

  level.scr_radio["gulag_lbp1_deployed"] = "gulag_lbp1_deployed";

  level.scr_radio["gulag_lbp3_snipercover"] = "gulag_lbp3_snipercover";

  level.scr_radio["gulag_lbp1_solidcopy"] = "gulag_lbp1_solidcopy";

  level.scr_sound["generic"]["gulag_rpt_gogogo"] = "gulag_rpt_gogogo";

  level.scr_sound["soap"]["gulag_cmt_tapinto"] = "gulag_cmt_tapinto";

  level.scr_sound["soap"]["gulag_cmt_secdoor"] = "gulag_cmt_secdoor";

  level.scr_radio["gulag_cmt_ancient"] = "gulag_cmt_ancient";

  level.scr_sound["soap"]["gulag_cmt_wrongdoor"] = "gulag_cmt_wrongdoor";

  level.scr_radio["gulag_gst_standby"] = "gulag_gst_standby";

  level.scr_radio["gulag_gst_gotit2"] = "gulag_gst_gotit2";

  level.scr_sound["soap"]["gulag_cmt_thatsbetter"] = "gulag_cmt_thatsbetter";

  level.scr_radio["gulag_gst_threetwo"] = "gulag_gst_threetwo";

  level.scr_sound["soap"]["gulag_cmt_seeanything"] = "gulag_cmt_seeanything";

  level.scr_sound["soap"]["gulag_cmt_gotcompany"] = "gulag_cmt_gotcompany";

  level.scr_sound["soap"]["gulag_cmt_riotshield"] = "gulag_cmt_riotshield";
  level.scr_face["soap"]["gulag_cmt_riotshield"] = % gulag_cmt_riotshield;

  level.scr_sound["soap"]["gulag_cmt_openarmory"] = "gulag_cmt_openarmory";

  level.scr_radio["gulag_gst_almostthere"] = "gulag_gst_almostthere";

  level.scr_sound["soap"]["gulag_cmt_openthedoor"] = "gulag_cmt_openthedoor";

  level.scr_radio["gulag_gst_gotit"] = "gulag_gst_gotit";

  level.scr_sound["soap"]["gulag_cmt_switchnv"] = "gulag_cmt_switchnv";

  level.scr_radio["gulag_gst_badnews"] = "gulag_gst_badnews";

  level.scr_sound["soap"]["gulag_cmt_hearcoming"] = "gulag_cmt_hearcoming";

  level.scr_sound["soap"]["gulag_cmt_opendoor"] = "gulag_cmt_opendoor";

  level.scr_radio["gulag_gst_runabypass"] = "gulag_gst_runabypass";

  level.scr_sound["soap"]["gulag_cmt_toolate"] = "gulag_cmt_toolate";

  level.scr_radio["gulag_gst_gotmoretangos"] = "gulag_gst_gotmoretangos";

  level.scr_sound["soap"]["gulag_cmt_morecover"] = "gulag_cmt_morecover";

  level.scr_sound["soap"]["gulag_cmt_pickupone"] = "gulag_cmt_pickupone";

  level.scr_sound["soap"]["gulag_cmt_openthedoor"] = "gulag_cmt_openthedoor";

  level.scr_radio["gulag_gst_gotit"] = "gulag_gst_gotit";

  level.scr_sound["soap"]["gulag_cmt_gotcompany"] = "gulag_cmt_gotcompany";

  level.scr_sound["soap"]["gulag_cmt_riotshield"] = "gulag_cmt_riotshield";

  level.scr_sound["soap"]["gulag_cmt_roachisdown"] = "gulag_cmt_roachisdown";

  level.scr_sound["soap"]["gulag_cmt_roach"] = "gulag_cmt_roach";

  level.scr_radio["gulag_tf1_cellclear"] = "gulag_tf1_cellclear";

  level.scr_radio["gulag_tf1_cell4dclear"] = "gulag_tf1_cell4dclear";

  level.scr_radio["gulag_tf1_cellsclear"] = "gulag_tf1_cellsclear";

  level.scr_radio["gulag_tf1_lastfloor"] = "gulag_tf1_lastfloor";

  level.scr_radio["gulag_tf1_captainlastfloor"] = "gulag_tf1_captainlastfloor";

  level.scr_radio["gulag_tf2_clear"] = "gulag_tf2_clear";

  level.scr_radio["gulag_tf2_onesempty"] = "gulag_tf2_onesempty";

  level.scr_radio["gulag_tf3_emptytoo"] = "gulag_tf3_emptytoo";

  level.scr_radio["gulag_tf3_clear"] = "gulag_tf3_clear";

  level.scr_sound["soap"]["gulag_cmt_calloff"] = "gulag_cmt_calloff";

  level.scr_radio["gulag_hqr_working"] = "gulag_hqr_working";

  level.scr_radio["gulag_hqr_loosecannon"] = "gulag_hqr_loosecannon";

  level.scr_sound["soap"]["gulag_cmt_gogogo1"] = "gulag_cmt_gogogo1";

  level.scr_radio["gulag_gst_oncameras"] = "gulag_gst_oncameras";

  level.scr_radio["gulag_gst_30ftonleft"] = "gulag_gst_30ftonleft";

  level.scr_sound["soap"]["gulag_cmt_plantbreach"] = "gulag_cmt_plantbreach";

  level.scr_sound["soap"]["gulag_cmt_hurryup"] = "gulag_cmt_hurryup";

  level.scr_sound["soap"]["gulag_cmt_wegotcompany"] = "gulag_cmt_wegotcompany";

  level.scr_sound["soap"]["gulag_cmt_whichway"] = "gulag_cmt_whichway";

  level.scr_radio["gulag_gst_50meters"] = "gulag_gst_50meters";

  level.scr_sound["soap"]["gulag_cmt_startfiring"] = "gulag_cmt_startfiring";

  level.scr_radio["gulag_gst_cistern"] = "gulag_gst_cistern";

  level.scr_radio["gulag_gst_8tangos"] = "gulag_gst_8tangos";

  level.scr_sound["soap"]["gulag_cmt_needmoretime"] = "gulag_cmt_needmoretime";

  level.scr_radio["gulag_hqr_nocando"] = "gulag_hqr_nocando";

  level.scr_radio["gulag_hqr_getout"] = "gulag_hqr_getout";

  level.scr_sound["soap"]["gulag_cmt_spierig"] = "gulag_cmt_spierig";

  level.scr_radio["gulag_plp_rogeronspie"] = "gulag_plp_rogeronspie";

  level.scr_sound["soap"]["gulag_cmt_sendit"] = "gulag_cmt_sendit";

  level.scr_radio["gulag_plp_ontheway"] = "gulag_plp_ontheway";

  level.scr_sound["soap"]["gulag_cmt_hookup"] = "gulag_cmt_hookup";

  level.scr_sound["soap"]["gulag_cmt_gogogo2"] = "gulag_cmt_gogogo2";

  level.scr_sound["soap"]["gulag_plp_onwayhome"] = "gulag_plp_onwayhome";

  level.scr_sound["soap"]["gulag_cmt_ready2jump"] = "gulag_cmt_ready2jump";

  level.scr_sound["soap"]["gulag_cmt_anotherway"] = "gulag_cmt_anotherway";

  level.scr_sound["soap"]["gulag_cmt_depth100"] = "gulag_cmt_depth100";

  level.scr_radio["gulag_plp_15secs"] = "gulag_plp_15secs";

  level.scr_sound["soap"]["gulag_cmt_deadinfive"] = "gulag_cmt_deadinfive";

  level.scr_sound["soap"]["gulag_cmt_whereareyou"] = "gulag_cmt_whereareyou";

  level.scr_radio["gulag_plp_cantsee"] = "gulag_plp_cantsee";

  level.scr_sound["price"]["gulag_pri_doitfast"] = "gulag_pri_doitfast";

  level.scr_radio["gulag_plp_seeflare"] = "gulag_plp_seeflare";

  level.scr_sound["price"]["gulag_pri_letsgo"] = "gulag_pri_letsgo";

  level.scr_sound["soap"]["gulag_cmt_hookup2"] = "gulag_cmt_hookup2";

  level.scr_sound["soap"]["gulag_cmt_gogo"] = "gulag_cmt_gogo";

  level.scr_sound["price"]["gulag_pri_hangon"] = "gulag_pri_hangon";

  level.scr_radio["gulag_lbp1_gunrun"] = "gulag_lbp1_gunrun";

  level.scr_sound["soap"]["gulag_cmt_lasingtarget"] = "gulag_cmt_lasingtarget";

  level.scr_radio["gulag_lbp1_gotatally"] = "gulag_lbp1_gotatally";

  level.scr_sound["soap"]["gulag_cmt_usem203"] = "gulag_cmt_usem203";

  level.scr_sound["soap"]["gulag_cmt_upahead"] = "gulag_cmt_upahead";

  level.scr_sound["soap"]["gulag_cmt_getout"] = "gulag_cmt_getout";

  level.scr_sound["soap"]["gulag_cmt_checkcorners"] = "gulag_cmt_checkcorners";

  level.scr_radio["gulag_gst_controlroom"] = "gulag_gst_controlroom";

  level.scr_sound["ghost"]["gulag_gst_controlroom_ghost"] = "gulag_gst_controlroom";

  level.scr_radio["gulag_cmt_tapinto"] = "gulag_cmt_tapinto";

  level.scr_sound["ghost"]["gulag_cmt_tapinto_ghost"] = "gulag_cmt_tapinto";

  level.scr_sound["soap"]["gulag_cmt_cellduty"] = "gulag_cmt_cellduty";

  level.scr_radio["gulag_gst_patchedin"] = "gulag_gst_patchedin";

  level.scr_sound["soap"]["gulag_cmt_location"] = "gulag_cmt_location";

  level.scr_radio["gulag_gst_jobeasier"] = "gulag_gst_jobeasier";

  level.scr_sound["soap"]["gulag_cmt_staysharp"] = "gulag_cmt_staysharp";

  level.scr_sound["soap"]["gulag_cmt_wrongdoor"] = "gulag_cmt_wrongdoor";

  level.scr_sound["soap"]["gulag_cmt_talktome"] = "gulag_cmt_talktome";

  level.scr_radio["gulag_gst_eastwing"] = "gulag_gst_eastwing";

  level.scr_sound["soap"]["gulag_cmt_armorydownthere"] = "gulag_cmt_armorydownthere";

  level.scr_radio["gulag_gst_almostthere"] = "gulag_gst_almostthere";

  level.scr_radio["gulag_gst_gotit"] = "gulag_gst_gotit";

  level.scr_sound["soap"]["gulag_cmt_letsgo"] = "gulag_cmt_letsgo";

  level.scr_sound["soap"]["gulag_cmt_ready2jump"] = "gulag_cmt_ready2jump";

  level.scr_sound["soap"]["gulag_cmt_anotherway"] = "gulag_cmt_anotherway";
  level.scr_face["soap"]["gulag_cmt_anotherway"] = % gulag_cmt_anotherway;

  level.scr_sound["redshirt"]["gulag_wrm_thisway"] = "gulag_wrm_thisway";
  level.scr_face["redshirt"]["gulag_wrm_thisway"] = % gulag_wrm_thisway;

  level.scr_sound["redshirt"]["gulag_wrm_deadend"] = "gulag_wrm_deadend";

  level.scr_sound["price"]["gulag_pri_doorsopen"] = "gulag_pri_doorsopen";

  level.scr_sound["soap"]["gulag_cmt_depth100"] = "gulag_cmt_depth100";

  level.scr_radio["gulag_plp_15secs"] = "gulag_plp_15secs";

  level.scr_sound["soap"]["gulag_cmt_deadinfive"] = "gulag_cmt_deadinfive";

  level.scr_sound["soap"]["gulag_cmt_whereareyou"] = "gulag_cmt_whereareyou";

  level.scr_radio["gulag_plp_cantsee"] = "gulag_plp_cantsee";

  level.scr_sound["price"]["gulag_pri_doitfast"] = "gulag_pri_doitfast";

  level.scr_radio["gulag_plp_seeflare"] = "gulag_plp_seeflare";

  level.scr_sound["soap"]["gulag_cmt_hookup2"] = "gulag_cmt_hookup2";

  level.scr_sound["soap"]["gulag_cmt_gogo"] = "gulag_cmt_gogo";

  level.scr_sound["price"]["gulag_pri_hangon"] = "gulag_pri_hangon";

  level.scr_sound["soap"]["gulag_cmt_seehostiles"] = "gulag_cmt_seehostiles";
  level.scr_face["soap"]["gulag_cmt_seehostiles"] = % gulag_cmt_seehostiles;

  level.scr_radio["gulag_rpt_tooclose"] = "gulag_rpt_tooclose";

  level.scr_sound["soap"]["gulag_cmt_usesheild"] = "gulag_cmt_usesheild";

  level.scr_sound["soap"]["gulag_cmt_illdrawfire"] = "gulag_cmt_illdrawfire";

  level.scr_radio["gulag_gst_bypassfloors"] = "gulag_gst_bypassfloors";

  level.scr_sound["soap"]["gulag_cmt_roachfollow"] = "gulag_cmt_roachfollow";
  level.scr_face["soap"]["gulag_cmt_roachfollow"] = % gulag_cmt_roachfollow;

  level.scr_radio["gulag_gst_feedisdead"] = "gulag_gst_feedisdead";

  level.scr_sound["soap"]["gulag_cmt_switchnv"] = "gulag_cmt_switchnv";

  level.scr_sound["soap"]["gulag_cmt_stragglers"] = "gulag_cmt_stragglers";

  level.scr_sound["soap"]["gulag_cmt_calloff"] = "gulag_cmt_calloff";

  level.scr_radio["gulag_hqr_working"] = "gulag_hqr_working";

  level.scr_radio["gulag_hqr_loosecannon"] = "gulag_hqr_loosecannon";

  level.scr_sound["soap"]["gulag_cmt_toonarrow"] = "gulag_cmt_toonarrow";

  level.scr_sound["soap"]["gulag_cmt_plantbreach"] = "gulag_cmt_plantbreach";

  level.scr_sound["soap"]["gulag_cmt_hurryup"] = "gulag_cmt_hurryup";

  level.scr_sound["soap"]["gulag_cmt_forgetthatdoor"] = "gulag_cmt_forgetthatdoor";

  level.scr_sound["soap"]["gulag_cmt_spreadout"] = "gulag_cmt_spreadout";

  level.scr_sound["soap"]["gulag_cmt_hostiles2ndfloor"] = "gulag_cmt_hostiles2ndfloor";

  level.scr_sound["soap"]["gulag_cmt_keepmoving"] = "gulag_cmt_keepmoving";

  level.scr_sound["soap"]["gulag_cmt_uselockers"] = "gulag_cmt_uselockers";

  level.scr_sound["soap"]["gulag_cmt_hitfromside"] = "gulag_cmt_hitfromside";

  level.scr_sound["soap"]["gulag_cmt_cookgrenades"] = "gulag_cmt_cookgrenades";

  level.scr_sound["soap"]["gulag_cmt_holeinfloor"] = "gulag_cmt_holeinfloor";

  level.scr_sound["soap"]["gulag_cmt_needmoretime"] = "gulag_cmt_needmoretime";

  level.scr_radio["gulag_hqr_nocando"] = "gulag_hqr_nocando";

  level.scr_sound["generic"]["gulag_cmt_heswithus"] = "gulag_cmt_heswithus";

  level.scr_sound["generic"]["gulag_pri_soap"] = "gulag_pri_soap";

  level.scr_sound["generic"]["gulag_wrm_whosoap"] = "gulag_wrm_whosoap";

  level.scr_sound["generic"]["gulag_cmt_heswithus"] = "gulag_cmt_heswithus";

  level.scr_sound["generic"]["gulag_pri_soap"] = "gulag_pri_soap";

  level.scr_sound["generic"]["gulag_wrm_whosoap"] = "gulag_wrm_whosoap";

  level.scr_sound["generic"]["gulag_cmt_belongstoyou"] = "gulag_cmt_belongstoyou";

  level.scr_sound["generic"]["gulag_cmt_getouttaheremove"] = "gulag_cmt_getouttaheremove";

  level.scr_sound["generic"]["gulag_rpa_ext_1"] = "gulag_rpa_ext_1";

  level.scr_sound["generic"]["gulag_rpa_ext_2"] = "gulag_rpa_ext_2";

  level.scr_sound["generic"]["gulag_rpa_ext_3"] = "gulag_rpa_ext_3";

  level.scr_sound["generic"]["gulag_rpa_ext_4"] = "gulag_rpa_ext_4";

  level.scr_sound["generic"]["gulag_rpa_ext_5"] = "gulag_rpa_ext_5";

  level.scr_sound["generic"]["gulag_rpa_ext_6"] = "gulag_rpa_ext_6";

  level.scr_sound["generic"]["gulag_rpa_ext_7"] = "gulag_rpa_ext_7";

  level.scr_sound["generic"]["gulag_rpa_ext_8"] = "gulag_rpa_ext_8";

  level.scr_sound["generic"]["gulag_rpa_int_1"] = "gulag_rpa_int_1";

  level.scr_sound["generic"]["gulag_rpa_int_2"] = "gulag_rpa_int_2";

  level.scr_sound["generic"]["gulag_rpa_int_3"] = "gulag_rpa_int_3";

  level.scr_sound["generic"]["gulag_rpa_int_4"] = "gulag_rpa_int_4";

  level.scr_sound["generic"]["gulag_rpa_int_5"] = "gulag_rpa_int_5";

  level.scr_sound["generic"]["gulag_pri_yes"] = "gulag_pri_yes";
}