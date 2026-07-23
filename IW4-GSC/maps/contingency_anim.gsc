/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\contingency_anim.gsc
********************************************************/

#include maps\_anim;
#include maps\_utility;
#include common_scripts\utility;

main_anim() {
  ride_vehicle_anims();
  ride_player_anims();
  generic_human();
  dialog();
  vehicles();
}

notetrack_notify_attach_rocket(guy) {
  guy notify("attach rocket");
}

notetrack_notify_fire_rocket(guy) {
  guy notify("fire rocket");
}

notetrack_notify_drop_rocket(guy) {
  guy notify("drop rocket");
}

#using_animtree("vehicles");
ride_vehicle_anims() {
  level.scr_anim["generic"]["boneyard_UAZ_door"] = % boneyard_UAZ_door;
}
#using_animtree("vehicles");
ride_uaz_door() {
  anim_model = self maps\_vehicle_aianim::getanimatemodel();
  anim_model setflaggedanimknob("uaz_door_anim", level.scr_anim["generic"]["boneyard_UAZ_door"], 1, .2, 1);
  anim_model waittillmatch("uaz_door_anim", "end");
  anim_model ClearAnim(level.scr_anim["generic"]["boneyard_UAZ_door"], 0);
}

#using_animtree("player");
ride_player_anims() {
  level.scr_animtree["player_rig"] = #animtree;
  level.scr_model["player_rig"] = "viewhands_player_arctic_wind";
  level.scr_anim["player_rig"]["boneyard_uaz_mount"] = % boneyard_player_enter_UAZ;
}

#using_animtree("generic_human");
generic_human() {
  level.scr_anim["price"]["intro"] = % contengency_price_intro;
  level.scr_anim["generic"]["cqb_stand_idle_scan"] = % patrol_bored_react_look_v1;

  level.scr_anim["price"]["slide"] = % contengency_price_slide;
  level.scr_anim["price"]["caution_stop"] = % afgan_caves_intro_stop;

  level.scr_anim["generic"]["tear_gas_guy1"] = % contingency_teargas_1;
  level.scr_anim["generic"]["tear_gas_guy2"] = % contingency_teargas_2;
  level.scr_anim["generic"]["tear_gas_guy3"] = % contingency_teargas_3;

  addNotetrack_customFunction("price", "price_land_settle", ::price_land_settle_fx);
  addNotetrack_customFunction("price", "price_slide_start", ::price_slide_fx);
  addNotetrack_customFunction("price", "price_slide_end", ::price_stop_slide_fx);

  level.scr_anim["bricktop"]["at4_fire"] = % contengency_rocket_moment;
  addNotetrack_customFunction("bricktop", "attach rocket", ::notetrack_notify_attach_rocket, "at4_fire");
  addNotetrack_customFunction("bricktop", "fire rocket", ::notetrack_notify_fire_rocket, "at4_fire");
  addNotetrack_customFunction("bricktop", "drop rocket", ::notetrack_notify_drop_rocket, "at4_fire");

  level.scr_anim["rasta"]["at4_fire"] = % contengency_rocket_moment;
  addNotetrack_customFunction("rasta", "attach rocket", ::notetrack_notify_attach_rocket, "at4_fire");
  addNotetrack_customFunction("rasta", "fire rocket", ::notetrack_notify_fire_rocket, "at4_fire");
  addNotetrack_customFunction("rasta", "drop rocket", ::notetrack_notify_drop_rocket, "at4_fire");

  level.scr_anim["price"]["at4_fire"] = % contengency_rocket_moment;
  addNotetrack_customFunction("price", "attach rocket", ::notetrack_notify_attach_rocket, "at4_fire");
  addNotetrack_customFunction("price", "fire rocket", ::notetrack_notify_fire_rocket, "at4_fire");
  addNotetrack_customFunction("price", "drop rocket", ::notetrack_notify_drop_rocket, "at4_fire");

  maps\_hand_signals::initHandSignals();

  level.scr_anim["generic"]["_stealth_patrol_search_a"] = % patrolwalk_cold_gunup_idle;
  level.scr_anim["generic"]["_stealth_patrol_search_b"] = % patrolwalk_cold_gunup_idle;

  level.scr_anim["generic"]["patrol_cold_huddle"][0] = % patrolwalk_cold_huddle_idle;
  level.scr_anim["generic"]["patrol_cold_huddle"][1] = % patrolwalk_cold_huddle_twitch;
  level.scr_anim["generic"]["patrol_cold_huddle_pause"] = % patrolwalk_cold_huddle_stand_idle;
  level.scr_anim["generic"]["patrol_cold_huddle_stop"] = % patrolwalk_cold_huddle_walk2stand;
  level.scr_anim["generic"]["patrol_cold_huddle_start"] = % patrolwalk_cold_huddle_stand2walk;

  level.scr_anim["generic"]["patrol_cold_crossed"][0] = % patrolwalk_cold_crossed_idle;
  level.scr_anim["generic"]["patrol_cold_crossed"][1] = % patrolwalk_cold_crossed_twitch;
  level.scr_anim["generic"]["patrol_cold_crossed_pause"] = % patrolwalk_cold_crossed_stand_idle;
  level.scr_anim["generic"]["patrol_cold_crossed_stop"] = % patrolwalk_cold_crossed_walk2stand;
  level.scr_anim["generic"]["patrol_cold_crossed_start"] = % patrolwalk_cold_crossed_stand2walk;

  level.scr_anim["generic"]["sprint"] = % sprint1_loop;

  weights = [];
  weights[0] = 8;
  weights[1] = 2;

  level.scr_anim["generic"]["patrol_twitch_weights"] = get_cumulative_weights(weights);

  level.scr_anim["generic"]["patrol_cold_gunup_search"] = % patrolwalk_cold_gunup_idle;

  level.scr_anim["generic"]["patrol_cold_gunup"][0] = % patrolwalk_cold_gunup_idle;
  level.scr_anim["generic"]["patrol_cold_gunup"][1] = % patrolwalk_cold_gunup_twitchA;
  level.scr_anim["generic"]["patrol_cold_gunup"][2] = % patrolwalk_cold_gunup_twitchB;

  weights = [];
  weights[0] = 4;
  weights[1] = 3;
  weights[2] = 3;

  level.scr_anim["generic"]["patrol_gunup_twitch_weights"] = get_cumulative_weights(weights);

  level.scr_anim["generic"]["truckride_climbin"] = % traverse_stepup_52;
}

price_caution_stop() {
  level endon("run_to_woods");
  self anim_reach_solo(level.price, "caution_stop");
  self anim_single_solo(level.price, "caution_stop");
  level.price setgoalnode(self);
}

#using_animtree("vehicles");
vehicles() {
  level.scr_anim["gauntlet"]["radar_spinup"] = % sa15_radar_spinup;
  level.scr_anim["gauntlet"]["radar_spinloop"] = % sa15_radar_spinloop;
  level.scr_anim["gauntlet"]["radar_spindown"] = % sa15_radar_spindown;
  level.scr_anim["gauntlet"]["turret_scanloop"] = % sa15_turret_scanloop;

  level.scr_animtree["contingency_btr_slide"] = #animtree;
  level.scr_anim["contingency_btr_slide"]["contingency_btr_slide"] = % contingency_btr_slide;
  level.scr_model["contingency_btr_slide"] = "vehicle_btr80_snow";
  addNotetrack_customFunction("contingency_btr_slide", "btr_fire", ::btr80_notetrack_fire, "contingency_btr_slide");
}

btr80_notetrack_fire(guy) {
  guy fireWeapon();

  level notify("btr_fired");
}

price_land_fx(price) {
  tagPos = price gettagorigin("J_Ankle_RI");
  tagPos = PhysicsTrace(tagPos + (0, 0, 64), tagPos + (0, 0, -64));
  playFX(level._effect["price_landing"], tagPos);
}

price_land_settle_fx(price) {
  tagPos = price gettagorigin("J_Ankle_LE");
  tagPos = PhysicsTrace(tagPos + (0, 0, 64), tagPos + (0, 0, -64));
  playFX(level._effect["price_landing"], tagPos);
}

price_slide_fx(price) {
  self endon("stop_slide_fx");
  while(true) {
    playFXOnTag(getfx("price_sliding"), price, "J_Ankle_LE");
    wait(.1);
  }
}

price_stop_slide_fx(price) {
  self notify("stop_slide_fx");
}

dialog() {
  level.scr_radio["cont_pri_alertenemies"] = "cont_pri_alertenemies";

  level.scr_radio["cont_pri_foundabody"] = "cont_pri_foundabody";

  level.scr_radio["cont_pri_foundabody2"] = "cont_pri_foundabody2";

  level.scr_radio["cont_pri_letpass"] = "cont_pri_letpass";

  level.scr_radio["cont_pri_twoonleft"] = "cont_pri_twoonleft";

  level.scr_radio["cont_pri_slippast"] = "cont_pri_slippast";

  level.scr_radio["cont_pri_nicelydone"] = "cont_pri_nicelydone";

  level.scr_radio["cont_pri_welldone"] = "cont_pri_welldone";

  level.scr_radio["cont_pri_good"] = "cont_pri_good";

  level.scr_radio["cont_pri_seenbetter"] = "cont_pri_seenbetter";

  level.scr_radio["cont_pri_goodwork"] = "cont_pri_goodwork";

  level.scr_radio["cont_pri_impressive"] = "cont_pri_impressive";

  level.scr_radio["cont_pri_forasmoke"] = "cont_pri_forasmoke";

  level.scr_radio["cont_pri_twoinwoods"] = "cont_pri_twoinwoods";

  level.scr_radio["cont_pri_imready"] = "cont_pri_imready";

  level.scr_radio["cont_pri_endawar"] = "cont_pri_endawar";

  level.scr_sound["price"]["cont_pri_foundroach"] = "cont_pri_foundroach";
  level.scr_radio["cont_pri_foundroach"] = "cont_pri_foundroach";

  level.scr_sound["price"]["cont_pri_headnw"] = "cont_pri_headnw";
  level.scr_radio["cont_pri_headnw"] = "cont_pri_headnw";

  level.scr_radio["cont_cmt_fareast"] = "cont_cmt_fareast";

  level.scr_sound["price"]["cont_pri_proceed"] = "cont_pri_proceed";
  level.scr_radio["cont_pri_proceed"] = "cont_pri_proceed";

  level.scr_sound["price"]["cont_pri_foundtransport"] = "cont_pri_foundtransport";
  level.scr_radio["cont_pri_foundtransport"] = "cont_pri_foundtransport";

  level.scr_radio["cont_cmt_workingonit"] = "cont_cmt_workingonit";

  level.scr_radio["cont_pri_outofsight"] = "cont_pri_outofsight";

  level.scr_radio["cont_pri_30metersfront"] = "cont_pri_30metersfront";

  level.scr_radio["cont_pri_pickoffstragglers"] = "cont_pri_pickoffstragglers";

  level.scr_sound["price"]["cont_pri_convoycoming"] = "cont_pri_convoycoming";
  level.scr_radio["cont_pri_convoycoming"] = "cont_pri_convoycoming";

  level.scr_sound["price"]["cont_pri_letthempass"] = "cont_pri_letpass";
  level.scr_radio["cont_pri_letthempass"] = "cont_pri_letpass";

  level.scr_sound["price"]["cont_pri_intelwasoff"] = "cont_pri_intelwasoff";
  level.scr_radio["cont_pri_intelwasoff"] = "cont_pri_intelwasoff";

  level.scr_sound["price"]["cont_cmt_rogerthat"] = "cont_cmt_rogerthat";
  level.scr_radio["cont_cmt_rogerthat"] = "cont_cmt_rogerthat";

  level.scr_radio["cont_pri_yourparachute"] = "cont_pri_yourparachute";

  level.scr_radio["cont_pri_keepmoving"] = "cont_pri_keepmoving";

  level.scr_radio["cont_pri_getdown"] = "cont_pri_getdown";

  level.scr_radio["cont_pri_hugthewalls"] = "cont_pri_hugthewalls";

  level.scr_radio["cont_pri_thatwasclose"] = "cont_pri_thatwasclose";

  level.scr_radio["cont_pri_sittingducks"] = "cont_pri_sittingducks";

  level.scr_radio["cont_pri_goloud"] = "cont_pri_goloud";

  level.scr_radio["cont_pri_ontous"] = "cont_pri_ontous";

  level.scr_radio["cont_pri_werespotted"] = "cont_pri_werespotted";

  level.scr_radio["cont_pri_dontgetclose"] = "cont_pri_dontgetclose";

  level.scr_radio["cont_pri_waitposition"] = "cont_pri_waitposition";

  level.scr_radio["cont_pri_waitforme"] = "cont_pri_waitforme";

  level.scr_radio["cont_pri_whenyoureready"] = "cont_pri_whenyoureready";

  level.scr_radio["cont_pri_getuskilled"] = "cont_pri_getuskilled";

  level.scr_radio["cont_pri_thewordstealth"] = "cont_pri_thewordstealth";

  level.scr_radio["cont_pri_giveawayposition"] = "cont_pri_giveawayposition";

  level.scr_radio["cont_pri_lowprofile"] = "cont_pri_lowprofile";

  level.scr_radio["cont_pri_moveup"] = "cont_pri_moveup";

  level.scr_radio["cont_pri_move"] = "cont_pri_move";

  level.scr_radio["cont_pri_hideinwoods"] = "cont_pri_hideinwoods";

  level.scr_radio["cont_pri_getintowoods"] = "cont_pri_getintowoods";

  level.scr_radio["cont_pri_theyrealerted"] = "cont_pri_theyrealerted";

  level.scr_radio["cont_pri_arentlooking"] = "cont_pri_arentlooking";

  level.scr_radio["cont_pri_splittingup"] = "cont_pri_splittingup";

  level.scr_radio["cont_pri_beautiful"] = "cont_pri_beautiful";

  level.scr_radio["cont_pri_goodshot"] = "cont_pri_goodshot";

  level.scr_radio["cont_pri_gotone"] = "cont_pri_gotone";

  level.scr_radio["cont_pri_hesdown2"] = "cont_pri_hesdown2";

  level.scr_radio["cont_pri_tangodown"] = "cont_pri_tangodown";

  level.scr_radio["cont_pri_goodnight"] = "cont_pri_goodnight";

  level.scr_radio["cont_pri_targeteliminated"] = "cont_pri_targeteliminated";

  level.scr_radio["cont_pri_targetdown"] = "cont_pri_targetdown";

  level.scr_radio["cont_pri_henoticed"] = "cont_pri_henoticed";

  level.scr_radio["cont_pri_getoutofsight"] = "cont_pri_getoutofsight";

  level.scr_radio["cont_pri_hidebeenalerted"] = "cont_pri_hidebeenalerted";

  level.scr_radio["cont_pri_hesalerted"] = "cont_pri_hesalerted";

  level.scr_radio["cont_pri_anotherpatrol"] = "cont_pri_anotherpatrol";

  level.scr_radio["cont_pri_outoraround"] = "cont_pri_outoraround";

  level.scr_sound["price"]["cont_pri_incoming"] = "cont_pri_incoming";
  level.scr_radio["cont_pri_incoming"] = "cont_pri_incoming";

  level.scr_radio["cont_pri_getdown2"] = "cont_pri_getdown2";

  level.scr_sound["price"]["cont_pri_intothewoods"] = "cont_pri_intothewoods";
  level.scr_radio["cont_pri_intothewoods"] = "cont_pri_intothewoods";

  level.scr_sound["price"]["cont_pri_followme"] = "cont_pri_followme";
  level.scr_radio["cont_pri_followme"] = "cont_pri_followme";

  level.scr_sound["price"]["cont_pri_slowdown"] = "cont_pri_slowdown";
  level.scr_radio["cont_pri_slowdown"] = "cont_pri_slowdown";

  level.scr_radio["cont_pri_hatedogs"] = "cont_pri_hatedogs";

  level.scr_radio["cont_pri_gotm"] = "cont_pri_gotm";

  level.scr_radio["cont_pri_hesdown"] = "cont_pri_hesdown";

  level.scr_radio["cont_pri_downboy"] = "cont_pri_downboy";

  level.scr_radio["cont_pri_naptime"] = "cont_pri_naptime";

  level.scr_sound["price"]["cont_pri_airsupport"] = "cont_pri_airsupport";
  level.scr_radio["cont_pri_airsupport"] = "cont_pri_airsupport";

  level.scr_radio["cont_cmt_almostinpos"] = "cont_cmt_almostinpos";

  level.scr_sound["price"]["cont_pri_rogerthat"] = "cont_pri_rogerthat";
  level.scr_radio["cont_pri_rogerthat"] = "cont_pri_rogerthat";

  level.scr_sound["price"]["cont_pri_ridgeisperfect"] = "cont_pri_ridgeisperfect";
  level.scr_radio["cont_pri_ridgeisperfect"] = "cont_pri_ridgeisperfect";

  level.scr_sound["price"]["cont_pri_controluav"] = "cont_pri_controluav";
  level.scr_radio["cont_pri_controluav"] = "cont_pri_controluav";

  level.scr_sound["price"]["cont_pri_bollocks"] = "cont_pri_bollocks";
  level.scr_radio["cont_pri_bollocks"] = "cont_pri_bollocks";

  level.scr_radio["cont_cmt_whathappened"] = "cont_cmt_whathappened";

  level.scr_sound["price"]["cont_pri_mobilesaminvillage"] = "cont_pri_mobilesaminvillage";
  level.scr_radio["cont_pri_mobilesaminvillage"] = "cont_pri_mobilesaminvillage";

  level.scr_sound["price"]["cont_pri_uavsharpish"] = "cont_pri_uavsharpish";
  level.scr_radio["cont_pri_uavsharpish"] = "cont_pri_uavsharpish";

  level.scr_sound["price"]["cont_pri_roachletsgo"] = "cont_pri_roachletsgo";
  level.scr_radio["cont_pri_roachletsgo"] = "cont_pri_roachletsgo";

  level.scr_sound["rasta"]["cont_rst_standback"] = "cont_rst_standback";

  level.scr_sound["rasta"]["cont_rst_getback"] = "cont_rst_getback";

  level.scr_sound["rasta"]["cont_rst_checkfire"] = "cont_rst_checkfire";

  level.scr_sound["price"]["cont_pri_nicework"] = "cont_pri_nicework";

  level.scr_sound["rasta"]["cont_rst_getmoving"] = "cont_rst_getmoving";

  level.scr_sound["price"]["cont_pri_grabweapon"] = "cont_pri_grabweapon";

  level.scr_sound["price"]["cont_pri_rastaandbricktop"] = "cont_pri_rastaandbricktop";

  level.scr_radio["cont_cmt_2nduav"] = "cont_cmt_2nduav";

  level.scr_sound["price"]["cont_pri_belowcrane"] = "cont_pri_belowcrane";

  level.scr_sound["price"]["cont_pri_softendefenses"] = "cont_pri_softendefenses";

  level.scr_radio["cont_cmt_gotattention"] = "cont_cmt_gotattention";

  level.scr_radio["cont_cmt_baseonalert"] = "cont_cmt_baseonalert";

  level.scr_radio["cont_cmt_betterhurry"] = "cont_cmt_betterhurry";

  level.scr_sound["price"]["cont_pri_weremoving"] = "cont_pri_weremoving";

  level.scr_radio["cont_cmt_halwaythere"] = "cont_cmt_halwaythere";

  level.scr_radio["cont_cmt_90secs"] = "cont_cmt_90secs";

  level.scr_radio["cont_cmt_60secs"] = "cont_cmt_60secs";

  level.scr_radio["cont_cmt_30secs"] = "cont_cmt_30secs";

  level.scr_sound["price"]["cont_pri_subwontwait"] = "cont_pri_subwontwait";

  level.scr_sound["price"]["cont_pri_gogogo"] = "cont_pri_gogogo";

  level.scr_sound["price"]["cont_pri_gettosub"] = "cont_pri_gettosub";

  level.scr_sound["price"]["cont_pri_reachedsub"] = "cont_pri_reachedsub";

  level.scr_radio["cont_cmt_rogerthat2"] = "cont_cmt_rogerthat2";

  level.scr_sound["price"]["cont_pri_getmaskon"] = "cont_pri_getmaskon";

  level.scr_sound["price"]["cont_pri_downthehatch"] = "cont_pri_downthehatch";

  level.scr_sound["price"]["cont_pri_needfewminutes"] = "cont_pri_needfewminutes";

  level.scr_radio["cont_cmt_eastgate"] = "cont_cmt_eastgate";

  level.scr_sound["price"]["cont_pri_copythatsoap"] = "cont_pri_copythatsoap";

  level.scr_sound["price"]["cont_pri_almostdone"] = "cont_pri_almostdone";

  level.scr_radio["cont_cmt_muchlonger"] = "cont_cmt_muchlonger";

  level.scr_sound["price"]["cont_pri_notsinking"] = "cont_pri_notsinking";

  level.scr_radio["cont_cmt_bloodyhell"] = "cont_cmt_bloodyhell";

  level.scr_sound["price"]["cont_pri_notime"] = "cont_pri_notime";

  level.scr_sound["price"]["cont_pri_runningout"] = "cont_pri_runningout";

  level.scr_sound["price"]["cont_pri_trustme"] = "cont_pri_trustme";

  level.scr_sound["price"]["cont_pri_donehereletsgo"] = "cont_pri_donehereletsgo";

  level.scr_sound["price"]["cont_pri_gettotruck"] = "cont_pri_gettotruck";

  level.scr_sound["price"]["cont_pri_endawar"] = "cont_pri_endawar";

  level.scr_sound["price"]["cont_pri_usehellfire"] = "cont_pri_usehellfire";

  level.scr_sound["price"]["cont_pri_takeoutheli"] = "cont_pri_takeoutheli";

  level.scr_radio["cont_pri_fivemen"] = "cont_pri_fivemen";

  level.scr_radio["cont_cmt_hatedogs"] = "cont_cmt_hatedogs";

  level.scr_radio["cont_pri_twoonright"] = "cont_pri_twoonright";

  level.scr_radio["cont_pri_searchingforus"] = "cont_pri_searchingforus";

  level.scr_sound["price"]["cont_pri_armoredvehicle"] = "cont_pri_armoredvehicle";

  level.scr_sound["price"]["cont_pri_goingforsub"] = "cont_pri_goingforsub";

  level.scr_sound["price"]["cont_pri_coverme"] = "cont_pri_coverme";

  level.scr_sound["rasta"]["cont_gst_rogerthat"] = "cont_gst_rogerthat";

  level.scr_sound["rasta"]["cont_gst_guardhouse"] = "cont_gst_guardhouse";

  level.scr_radio["cont_pri_insidesub"] = "cont_pri_insidesub";

  level.scr_sound["rasta"]["cont_gst_twotruckseast"] = "cont_gst_twotruckseast";

  level.scr_sound["rasta"]["cont_gst_morevehicleseast"] = "cont_gst_morevehicleseast";

  level.scr_sound["rasta"]["cont_gst_nexttosub"] = "cont_gst_nexttosub";

  level.scr_sound["rasta"]["cont_gst_youthere"] = "cont_gst_youthere";

  level.scr_sound["rasta"]["cont_gst_comein"] = "cont_gst_comein";

  level.scr_sound["rasta"]["cont_gst_doyoucopy"] = "cont_gst_doyoucopy";

  level.scr_radio["cont_pri_good2"] = "cont_pri_good2";

  level.scr_sound["rasta"]["cont_gst_whatwait"] = "cont_gst_whatwait";

  level.scr_sound["rasta"]["cont_gst_codeblack"] = "cont_gst_codeblack";

  level.scr_sound["rasta"]["cont_gst_whathaveyoudone"] = "cont_gst_whathaveyoudone";

  level.scr_radio["cont_pri_russiandogs"] = "cont_pri_russiandogs";

  level.scr_radio["cont_cmt_haveyouback"] = "cont_cmt_haveyouback";

  level.scr_radio["cont_pri_rogerthat2"] = "cont_pri_rogerthat2";

  level.scr_radio["cont_cmt_directhitshelo"] = "cont_cmt_directhitshelo";

  level.scr_radio["cont_cmt_btrdestroyed"] = "cont_cmt_btrdestroyed";

  level.scr_radio["cont_cmt_directhitjeep"] = "cont_cmt_directhitjeep";

  level.scr_radio["cont_cmt_goodkilltruck"] = "cont_cmt_goodkilltruck";

  level.scr_radio["cont_cmt_goodhitvehicles"] = "cont_cmt_goodhitvehicles";

  level.scr_radio["cont_cmt_goodeffectkia"] = "cont_cmt_goodeffectkia";

  level.scr_radio["cont_cmt_fivepluskias"] = "cont_cmt_fivepluskias";

  level.scr_radio["cont_cmt_mutlipleconfirmed"] = "cont_cmt_mutlipleconfirmed";

  level.scr_radio["cont_cmt_3kills"] = "cont_cmt_3kills";

  level.scr_radio["cont_cmt_theyredown"] = "cont_cmt_theyredown";

  level.scr_radio["cont_cmt_directhit"] = "cont_cmt_directhit";

  level.scr_radio["cont_cmt_hesdown"] = "cont_cmt_hesdown";

  level.uav_radio_initialized = true;
  level.scr_radio["uav_reloading"] = "cont_cmt_rearmhellfires";
  level.scr_radio["uav_offline"] = "cont_cmt_hellfiresoffline";
  level.scr_radio["uav_online"] = "cont_cmt_hellfireonline";
  level.scr_radio["uav_online_repeat"] = "cont_cmt_repeatonline";
  level.scr_radio["uav_down"] = "cont_cmt_predatordown";

  level.scr_radio["cont_cmt_barelysee"] = "cont_cmt_barelysee";

  level.scr_sound["price"]["cont_pri_strobes"] = "cont_pri_strobes";
}