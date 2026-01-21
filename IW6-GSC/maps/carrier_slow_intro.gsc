/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\carrier_slow_intro.gsc
***************************************/

slow_intro_pre_load() {
  common_scripts\utility::flag_init("intro_fade_done");
  common_scripts\utility::flag_init("intro_part_1_done");
  common_scripts\utility::flag_init("fade_promotion");
  common_scripts\utility::flag_init("slow_intro_finished");
  common_scripts\utility::flag_init("disable_hurt_breathing");
  common_scripts\utility::flag_init("stop_player_ekg");
  common_scripts\utility::flag_init("slow_intro_alarms");
  common_scripts\utility::flag_init("talkers_anim_stop");
  common_scripts\utility::flag_init("meet_and_greet_kick");
  common_scripts\utility::flag_init("player_grabbed_mask");
  common_scripts\utility::flag_init("start_promo_fade");
  common_scripts\utility::flag_init("give_mask");
  common_scripts\utility::flag_init("fall_water_kill_trigger");
  common_scripts\utility::flag_init("tilt_water_kill_trigger");
  common_scripts\utility::flag_init("hesh_stair_intro");
  common_scripts\utility::flag_init("start_medbay_exit");
  precacheitem("helmet_goggles_mask");
  precachestring(&"CARRIER_INTROSCREEN_LINE1");
  precachestring(&"CARRIER_INTROSCREEN_LINE2");
  precachestring(&"CARRIER_INTROSCREEN_LINE3");
  precachestring(&"CARRIER_3DAYS");
  precachestring(&"CARRIER_TAKE_MASK");
  precachestring(&"CARRIER_TAKE_MASK_CONSOLE");
  precacheshader("pip_scene_overlay");
  var_0 = getEntArray("barrack_doors_open", "targetname");
  common_scripts\utility::array_thread(var_0, maps\_utility::hide_entity);
  var_1 = getent("blast_shield1", "targetname");
  var_1 rotateto((0, 0, 0), 0.5);
  var_2 = getent("blast_shield2", "targetname");
  var_2 rotateto((0, 0, 0), 0.5);
  var_3 = getent("blast_shield3", "targetname");
  var_3 rotateto((0, 0, 0), 0.5);
  var_4 = getent("blast_shield4", "targetname");
  var_4 rotateto((0, 0, 0), 0.5);
  var_5 = getent("blast_shield5", "targetname");
  var_5 rotateto((0, 0, 0), 0.5);
  var_6 = getent("blast_shield6", "targetname");
  var_6 rotateto((0, 0, 0), 0.5);
  maps\_utility::add_hint_string("3_days", &"CARRIER_3DAYS");
  maps\_utility::intro_screen_create(&"CARRIER_INTROSCREEN_LINE1", &"CARRIER_INTROSCREEN_LINE2", &"CARRIER_INTROSCREEN_LINE3");
  maps\_utility::intro_screen_custom_func(::custom_intro_screen_func);
  maps\_utility_dogs::init_dog_pc("c_hurt");
}

setup_slow_intro() {
  level.start_point = "slow_intro";
  maps\carrier_code::setup_common(1);
}

begin_slow_intro() {
  if(isDefined(level.player))
    var_0 = newclienthudelem(level.player);
  else
    var_0 = newhudelem();

  var_0.x = 0;
  var_0.y = 0;
  var_0 setshader("black", 640, 480);
  var_0.alignx = "left";
  var_0.aligny = "top";
  var_0.sort = 1;
  var_0.horzalign = "fullscreen";
  var_0.vertalign = "fullscreen";
  var_0.alpha = 1;
  var_0.foreground = 1;
  common_scripts\utility::flag_set("exterior_effects_off");
  common_scripts\utility::exploder(4501);
  level.player disableweapons();
  level.player takeweapon("g28+acog_sp");
  wait 0.2;
  var_0 destroy();
  thread maps\carrier_audio::aud_check("slow_intro");
  thread slow_intro();
  common_scripts\utility::flag_wait("slow_intro_finished");
  maps\_utility::stop_exploder(4501);
  thread maps\_utility::autosave_tactical();
}

catchup_slow_intro() {
  common_scripts\utility::flag_set("slow_intro_finished");
  thread clean_up_intro_exterior_props();
}

custom_intro_screen_func() {
  common_scripts\utility::flag_wait("start_medbay_exit");
  wait 2.5;
  maps\_introscreen::introscreen(1);
}

slow_intro() {
  maps\_utility::battlechatter_off("allies");
  thread maps\carrier_audio::aud_play_intro_music();
  thread intro_cinematic();
  thread intro_vo();
  thread maps\carrier_audio::aud_carr_begin_promotion();
  common_scripts\utility::flag_wait("intro_part_1_done");
  thread run_promotion();
}

intro_cinematic() {
  setsaveddvar("hud_showStance", 0);
  level.player freezecontrols(1);
  setsaveddvar("cg_cinematicCanPause", "1");
  cinematicingamesync("carrier_intro");
  wait 0.1;

  while(iscinematicplaying()) {
    var_0 = cinematicgettimeinmsec();
    var_1 = var_0 / 26995;

    if(var_1 >= 0.97) {
      thread maps\carrier_code::set_black_fade(1, 0.01);
      level.hud_black.foreground = 0;
      break;
    }

    wait 0.05;
  }

  common_scripts\utility::flag_set("intro_part_1_done");
  setsaveddvar("cg_cinematicCanPause", "0");
}

intro_vo() {
  wait 0.1;
  wait 1.5;
  maps\_utility::smart_radio_dialogue("carrier_plt1_ussliberatorthisis");
  maps\_utility::smart_radio_dialogue("carrier_com_copyphantomtwotwoyou");
  wait 0.1;
  maps\_utility::smart_radio_dialogue("carrier_hsh_wehavetogo");
  maps\_utility::smart_radio_dialogue("carrier_mrk_negativeheshthefederation");
  wait 0.1;
  maps\_utility::smart_radio_dialogue("carrier_hsh_sowhatstheplan");
  maps\_utility::smart_radio_dialogue("carrier_mrk_weriskeverythingwe");
  common_scripts\utility::flag_wait("intro_part_1_done");
}

clean_up_intro_exterior_props() {
  var_0 = getEntArray("intro_static_jets", "targetname");
  maps\_utility::array_delete(var_0);
  var_1 = getent("intro_drive_tugger", "targetname");
  var_1 delete();
  var_2 = getent("intro_taxing_jet", "targetname");
  var_2 delete();
  var_3 = getent("intro_taxing_tugger", "targetname");
  var_3 delete();
  var_4 = getent("intro_drive_tugger_close_up", "targetname");
  var_4 delete();
  getent("intro_flyby_jet1", "targetname") delete();
  getent("intro_flyby_jet2", "targetname") delete();
}

run_promotion() {
  thread clean_up_intro_exterior_props();
  thread maps\_utility::vision_set_fog_changes("carrier_interior", 0);
  thread maps\carrier_audio::aud_switch_zone_medbay();
  maps\_art::sunflare_changes("carrier_combat_sunflare", 0);
  var_0 = getEntArray("barrack_doors_closed", "targetname");
  common_scripts\utility::array_thread(var_0, maps\_utility::show_entity);
  var_1 = getent("barrack_doors_closed_clip", "targetname");
  var_1 movez(200, 0.1);
  thread promotion_dog();
  wait 1.5;
  thread promotion_anims();
  thread maps\carrier_code::set_black_fade(0, 1.75);
  thread maps\_utility::smart_radio_dialogue("carrier_us2_lieutenantmackplease");
  wait 0.5;
  level.deck_clean = getEntArray("deck_clean", "targetname");
  common_scripts\utility::array_thread(level.deck_clean, maps\_utility::hide_entity);
  common_scripts\utility::flag_wait("fade_promotion");
  thread maps\carrier_code::set_black_fade(1, 1.5);
  wait 1.5;
  thread intro_ending();
  level.hesh_medbay delete();
  level.merrick_medbay delete();
  level.riley maps\_utility_dogs::kill_dog_fur_effect_and_delete();
}

promo_dof() {
  maps\_art::dof_enable_script(0, 7, 4, 0, 70, 1.5, 0.5);
  wait 0.5;
  maps\_art::dof_enable_script(0, 7, 4, 0, 70, 10, 1.0);
  common_scripts\utility::flag_wait("start_promo_fade");
  wait 0.25;
  maps\_art::dof_disable_script(0.75);
}

promotion_anims() {
  var_0 = common_scripts\utility::getstruct("promo_animnode", "targetname");
  level.player unlink();
  var_1 = common_scripts\utility::getstruct("promotion_player_start", "targetname");
  maps\_utility::teleport_player(var_1);
  level.player allowjump(0);
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player allowsprint(0);
  level.player allowads(0);
  var_2 = [];
  level.hesh_medbay = maps\_utility::spawn_targetname("hesh_medbay", 1);
  var_2[0] = level.hesh_medbay;
  var_2[0].animname = "hesh";
  var_2[0] maps\_utility::forceuseweapon("honeybadger", "primary");
  var_2[1] = getent("promotion_mask", "targetname");
  var_2[1].animname = "promotion_mask";
  var_2[1] maps\_anim::setanimtree();
  level.merrick_medbay = maps\_utility::spawn_targetname("merrick_medbay", 1);
  var_2[2] = level.merrick_medbay;
  var_2[2] maps\_utility::gun_remove();
  var_2[2].animname = "merrick";
  var_2[3] = maps\_utility::spawn_anim_model("player_intro_rig");
  var_2[4] = maps\_utility::spawn_anim_model("locker");
  var_3 = getent("promo_locker", "targetname");
  var_0 maps\_anim::anim_first_frame(var_2, "carrier_promotion");
  common_scripts\utility::waitframe();
  level.player playerlinktoabsolute(var_2[3], "tag_player");
  level.player freezecontrols(0);
  var_4 = var_2[4] gettagorigin("j_prop_1");
  var_5 = var_2[4] gettagangles("j_prop_1");
  var_3.origin = var_4;
  var_3.angles = var_5;
  var_3 linkto(var_2[4], "j_prop_1");
  common_scripts\utility::waitframe();
  level.player playerlinktodelta(var_2[3], "tag_player", 1, 30, 30, 15, 15, 1);
  var_0 thread maps\_anim::anim_single(var_2, "carrier_promotion");
  var_2[2] waittillmatch("single anim", "vo_carrier_mrk_hereloganthisbelonged");
  level.player lerpviewangleclamp(0.65, 0.2, 0.2, 0, 0, 0, 0);
  var_2[2] waittillmatch("single anim", "vo_carrier_mrk_hellbesafe");
  level.player lerpviewangleclamp(0, 0, 0, 30, 30, 15, 15);
  var_2[3] waittillmatch("single anim", "fade_out");
  common_scripts\utility::flag_set("fade_promotion");
  var_2[3] waittillmatch("single anim", "end");
  level.player freezecontrols(1);
  var_2[3] delete();
}

promotion_dog() {
  level.riley = maps\_utility::spawn_targetname("riley", 1);
  level.riley.animname = "riley";
  level.riley.name = "Riley";
  level.riley pushplayer(1);
  var_0 = common_scripts\utility::getstruct("promo_animnode", "targetname");
  var_0 maps\_anim::anim_loop_solo(level.riley, "carrier_promotion_loop");
}

intro_ending() {
  wait 3.0;
  thread maps\carrier_audio::aud_play_battlestations_music();
  thread maps\_utility::vision_set_fog_changes("carrier_interior", 0);
  thread maps\carrier_audio::aud_clear_zone_medbay();
  thread maps\_utility::stylized_center_text(&"CARRIER_3DAYS", 3);
  var_0 = getEntArray("barrack_doors_open", "targetname");
  common_scripts\utility::array_thread(var_0, maps\_utility::show_entity);
  var_1 = getEntArray("barrack_doors_closed", "targetname");
  maps\_utility::array_delete(var_1);
  var_2 = getent("barrack_doors_closed_clip", "targetname");
  var_2 delete();
  var_3 = common_scripts\utility::getstruct("intro_medbay_floor", "targetname");
  level.player maps\_utility::teleport_player(var_3);
  common_scripts\utility::flag_set("slow_intro_finished");
  var_4 = maps\_utility::get_living_ai_array("ally_intro", "script_noteworthy");
  maps\_utility::array_delete(var_4);
}

setup_medbay() {
  level.start_point = "medbay";
  maps\carrier_code::setup_common(1);
  thread maps\_utility::vision_set_fog_changes("carrier_interior", 0);
  maps\_art::sunflare_changes("carrier_combat_sunflare", 0);
  var_0 = getEntArray("barrack_doors_open", "targetname");
  common_scripts\utility::array_thread(var_0, maps\_utility::show_entity);
  var_1 = getEntArray("barrack_doors_closed", "targetname");
  maps\_utility::array_delete(var_1);
  level.deck_clean = getEntArray("deck_clean", "targetname");
  common_scripts\utility::array_thread(level.deck_clean, maps\_utility::hide_entity);
  level.player disableweapons();
  level.player takeweapon("g28+acog_sp");
  level.player allowjump(0);
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player allowsprint(0);
  level.player allowads(0);
  level.player setmovespeedscale(0.8);
  level.player freezecontrols(1);
  thread maps\carrier_code::set_black_fade(1, 0.01);
  thread maps\carrier_audio::aud_check("medbay");
  common_scripts\utility::flag_set("exterior_effects_off");
  common_scripts\utility::flag_set("slow_intro_finished");
}

begin_medbay() {
  thread run_exit();
  maps\_utility::set_team_bcvoice("allies", "delta");
  maps\_utility::battlechatter_on("allies");
  maps\_utility::flavorbursts_on("allies");
  thread maps\carrier_audio::aud_check("medbay");
  level.player freezecontrols(1);
  level.player setmovespeedscale(0.8);
  level.player allowsprint(0);
  common_scripts\utility::flag_wait("medbay_finished");
  thread maps\carrier_audio::aud_flight_deck_bell();
  thread maps\_utility::flag_clear_delayed("slow_intro_alarms", 10);
  thread maps\_utility::autosave_tactical();
}

catchup_medbay() {
  thread maps\carrier_vista::run_vista();
}

run_exit() {
  common_scripts\utility::flag_set("slow_intro_alarms");
  maps\carrier_code::spawn_allies();
  thread hall_redshirt_talk();
  thread hall_redshirt_runner();
  thread pharm_roller_shut();
  thread hallway_crossing_middle();
  thread hallway_rear_run_down();
  thread hallway_rear_run_down_back();
  thread medbay_player_anim();
  thread maps\_utility::smart_radio_dialogue("carrier_ttn_allcallsignsfederation");
  wait 2;
  var_0 = common_scripts\utility::getstruct("anim_ref_medbay_door", "targetname");
  var_0 thread maps\_anim::anim_first_frame_solo(level.hesh, "carrier_medbay_letsgo_hesh_enter");
  thread interior_pa_vo();
  thread maps\carrier_code::set_black_fade(0, 2);
  setsaveddvar("hud_showStance", 1);
  common_scripts\utility::flag_set("start_medbay_exit");
  var_0 thread maps\_anim::anim_single_solo(level.hesh, "carrier_medbay_letsgo_hesh_enter");
  level.hesh.target = "hesh_hallway_path";
  level.hesh thread super_ignore_all();
  wait 0.8;
  wait 1.5;
  level.hesh thread maps\_utility::smart_dialogue("carrier_hsh_showtime");
  wait 0.5;
  thread maps\carrier::obj_flight_deck();
  level.hesh waittillmatch("single anim", "end");

  if(!common_scripts\utility::flag("player_reached_medbay_door"))
    var_0 thread maps\_anim::anim_loop_solo(level.hesh, "carrier_medbay_letsgo_hesh_loop", "stop_loop");

  common_scripts\utility::flag_wait("player_reached_medbay_door");
  var_0 notify("stop_loop");
  level.hesh maps\_utility::disable_exits();
  level.hesh maps\_utility::disable_arrivals();
  var_0 maps\_anim::anim_single_solo(level.hesh, "carrier_medbay_letsgo_hesh_exit");
  level.hesh thread hallway_vo();
  level.hesh maps\carrier_code::fast_jog(1);
  level.hesh maps\_utility::enable_ai_color();
  common_scripts\utility::flag_wait("redshirts_start");
  level.hesh maps\_utility::enable_exits();
  level.hesh maps\_utility::enable_arrivals();
  common_scripts\utility::flag_wait("hesh_stair_intro");
  level.hesh maps\carrier_code::fast_jog(0);
  level.hesh.animname = "hesh";
  common_scripts\utility::flag_wait("medbay_finished");
  thread maps\carrier_vista::run_vista();
  level.deck_clean = getEntArray("deck_clean", "targetname");
  common_scripts\utility::array_thread(level.deck_clean, maps\_utility::show_entity);
  var_1 = getent("water_wake_intro", "targetname");
  var_1 delete();
}

medbay_player_anim() {
  var_0 = common_scripts\utility::getstruct("anim_ref_medbay_door", "targetname");
  var_1 = maps\_utility::spawn_anim_model("player_rig");
  var_0 thread maps\_anim::anim_first_frame_solo(var_1, "carrier_medbay_grab_mask_player");
  level.player playerlinktodelta(var_1, "tag_player", 1, 15, 15, 15, 15, 1);
  common_scripts\utility::flag_wait("start_medbay_exit");
  var_2 = getent("promotion_mask", "targetname");
  var_2.animname = "promotion_mask";
  var_2 maps\_anim::setanimtree();
  level.player freezecontrols(0);
  var_0 thread maps\_anim::anim_single_solo(var_2, "carrier_medbay_grab_mask_mask");
  var_0 maps\_anim::anim_single_solo(var_1, "carrier_medbay_grab_mask_player");
  thread maps\carrier_audio::aud_carr_ghost_mask_on_plr();
  level.player unlink();
  level.player allowjump(1);
  level.player allowcrouch(1);
  level.player allowprone(1);
  level.player allowads(1);
  var_1 delete();
  var_2 delete();
  level.player enableweapons();
  setsaveddvar("ammoCounterHide", 1);
  level.player giveweapon("helmet_goggles_mask");
  level.player switchtoweapon("helmet_goggles_mask");
  wait 1;
  thread maps\carrier_code::set_black_fade(1, 0.2);
  maps\_utility::delaythread(0.6, maps\carrier_code::set_black_fade, 0, 0.6);
  wait 2;
  level.player giveweapon("g28+acog_sp");
  level.player switchtoweapon("g28+acog_sp");
  level.player takeweapon("helmet_goggles_mask");
  setsaveddvar("ammoCounterHide", 0);
}

hallway_vo() {
  maps\_utility::smart_dialogue("carrier_hsh_wevegottohelp");
  wait 0.7;
  maps\_utility::smart_radio_dialogue_overlap("carrier_com_wearebeingboarded");
  wait 0.5;
  maps\_utility::smart_dialogue("carrier_hsh_iftheygettheir");
  wait 0.2;
  maps\_utility::smart_dialogue("carrier_hsh_wevegottohold");
}

interior_pa_vo() {
  maps\_utility::smart_radio_dialogue("carrier_us4_enemycontactshavebeen");
  maps\_utility::smart_radio_dialogue("carrier_us4_prepareforincomingattack");
  wait 1;
  maps\_utility::smart_radio_dialogue("carrier_us4_firecontrolteamsreport");
  wait 0.4;
  maps\_utility::smart_radio_dialogue("carrier_us4_activateaabatteries1");
  maps\_utility::smart_radio_dialogue("carrier_us4_allhandstobattles");
}

hall_redshirt_talk() {
  var_0 = getent("anim_hallway_takers_goal", "targetname");
  var_1 = [];
  var_1[0] = maps\_utility::spawn_targetname("hall_redshirt_1", 1);
  var_1[1] = maps\_utility::spawn_targetname("hall_redshirt_2", 1);
  var_1[0].animname = "rs1";
  var_1[1].animname = "rs2";
  var_1[0].health = 1;
  var_1[1].health = 1;
  var_2 = common_scripts\utility::getstruct("anim_ref_medbay_door", "targetname");
  var_2 thread maps\_anim::anim_loop(var_1, "carrier_hallway_talk_loop", "stop_rs_loop");
  common_scripts\utility::flag_wait("redshirts_start");
  var_2 notify("stop_rs_loop");
  var_2 maps\_anim::anim_single(var_1, "carrier_hallway_salute_enter");
  var_2 thread maps\_anim::anim_loop(var_1, "carrier_hallway_salute_loop", "stop_rs_loop");
  common_scripts\utility::flag_wait("redshirts_end");
  var_2 notify("stop_rs_loop");
  var_3 = getent("runback_clip_blocker", "targetname");
  var_3 movex(-124, 0.1);
  var_2 maps\_anim::anim_single(var_1, "carrier_hallway_salute_exit");
  var_2 thread maps\_anim::anim_loop(var_1, "carrier_hallway_talk_loop", "stop_rs_loop");
  common_scripts\utility::flag_wait("hallway_door_close");
  var_2 notify("stop_rs_loop");
  common_scripts\utility::waitframe();
  maps\_utility::array_delete(var_1);
  var_3 = getent("runback_clip_blocker", "targetname");
  var_3 delete();
}

hall_redshirt_runner() {
  wait 0.6;
  var_0 = maps\_utility::array_spawn_targetname("intro_hall_runaway_ally", 1);

  foreach(var_2 in var_0) {
    var_2.animname = "generic";
    var_2 maps\_utility::set_run_anim("run_gun_up");
    var_2 maps\_utility::gun_remove();
    var_2 thread run_to_and_delete();
    var_2 maps\_utility::setflashbangimmunity(1);
  }
}

run_to_and_delete(var_0) {
  self endon("death");
  self.goalradius = 8;
  self waittill("goal");
  self delete();
}

#using_animtree("generic_human");

pharm_roller_shut() {
  var_0 = getent("pharm_roller_door", "targetname");
  var_1 = maps\_utility::spawn_targetname("pharm_redshirt", 1);
  var_1 maps\_utility::gun_remove();
  var_1.animname = "rs_pharm";
  var_2 = common_scripts\utility::getstruct("shutter_close_ref", "targetname");
  var_2 maps\_anim::anim_first_frame_solo(var_1, "pharm_shutter_close");
  common_scripts\utility::flag_wait("redshirts_start");
  var_2 thread maps\_anim::anim_single_solo(var_1, "pharm_shutter_close");
  thread maps\carrier_audio::aud_carr_pharmacy_shut();
  wait 0.7;
  var_1 setanimtime(%favela_curtain_pull, 0.1);
  wait 1.6;
  var_0 movez(-38, 0.7, 0.3);
  var_1 waittillmatch("single anim", "end");
}

hallway_crossing_middle() {
  common_scripts\utility::flag_wait("redshirts_runners_start");
  var_0 = maps\_utility::array_spawn_targetname("hallway_cross_runners", 1);

  foreach(var_2 in var_0) {
    var_2 thread run_to_and_delete();
    var_2.runanim = maps\_utility::getgenericanim("unarmed_run");
    var_2 maps\_utility::setflashbangimmunity(1);
  }
}

hallway_rear_run_down() {
  common_scripts\utility::flag_wait("redshirts_runners_start");
  var_0 = maps\_utility::array_spawn_targetname("hallway_rear_hall_runners", 1);

  foreach(var_2 in var_0) {
    var_2 thread maps\_utility::disable_pain();
    var_2 thread run_to_and_delete();
    var_2 maps\_utility::setflashbangimmunity(1);
    var_2 maps\_utility::enable_cqbwalk();
    var_2 maps\_utility::set_moveplaybackrate(1.1);
  }
}

hallway_rear_run_down_back() {
  level endon("redshirts_end");
  var_0 = getent("hallway_cross_runners_rear", "targetname");
  var_1 = getent("end_pos", "targetname");
  common_scripts\utility::flag_wait("redshirts_runners_start");

  for(;;) {
    var_2 = maps\_utility::spawn_targetname("hallway_cross_runners_rear", 1);
    var_2 setgoalvolumeauto(var_1);
    var_2 waittill("goal");

    if(isDefined(var_2) && isalive(var_2))
      var_2 delete();

    wait(randomfloatrange(1, 5));
  }
}

super_ignore_all() {
  var_0 = getdvar("ai_friendlyFireBlockDuration");
  setsaveddvar("ai_friendlyFireBlockDuration", 0);
  self pushplayer(1);
  self.ignoreall = 1;
  self.dontmelee = 1;
  self.ignorerandombulletdamage = 1;
  maps\_utility::disable_danger_react();
  maps\_utility::disable_pain();
  maps\_utility::setflashbangimmunity(1);
  self.dontavoidplayer = 1;
  self.nododgemove = 1;
  common_scripts\utility::flag_wait("hesh_stair_intro");
  setsaveddvar("ai_friendlyFireBlockDuration", var_0);
  self pushplayer(0);
  self.ignoreall = 0;
  self.dontmelee = 0;
  self.ignorerandombulletdamage = 0;
  maps\_utility::enable_danger_react(0);
  maps\_utility::enable_pain();
  maps\_utility::setflashbangimmunity(0);
  self.dontavoidplayer = 0;
  self.nododgemove = 0;
}

wait_teleport(var_0) {
  level endon("redshirts_end");
  wait(randomfloatrange(1, 5));
  self forceteleport(var_0.origin);
}

run_fly_in() {
  wait 3;
  common_scripts\utility::flag_set("intro_fade_done");
  wait 3;
  thread player_ride_shake();
  thread maps\_vehicle::spawn_vehicle_from_targetname_and_drive("intro_flyby_jet1");
  thread maps\_vehicle::spawn_vehicle_from_targetname_and_drive("intro_flyby_jet2");
  common_scripts\utility::flag_wait("start_intro_shot_fade");
  wait 7;
  level.player freezecontrols(1);
  level.player_blackhawk vehicle_turnengineoff();
  common_scripts\utility::waitframe();
  common_scripts\utility::flag_set("intro_part_1_done");
  wait 0.05;
  level notify("player_unloading");
  level.player.is_on_heli = 0;
  level.player_blackhawk vehicle_teleport((50000, 50000, 50000), (0, 0, 0));
  common_scripts\utility::waitframe();
  level.player_blackhawk delete();
  level.blackhawk_ally delete();
  wait 0.25;
  level.vttype = "silenthawk";
  level.vtmodel = "vehicle_silenthawk";
  level.vtclassname = "script_vehicle_silenthawk_open";
  maps\_vehicle::build_aianims(vehicle_scripts\silenthawk::setanims, vehicle_scripts\silenthawk::set_vehicle_anims);
}

player_ride_shake() {
  level endon("player_unloading");

  for(;;) {
    var_0 = randomfloatrange(0.05, 0.1);
    earthquake(var_0, 0.5, level.player.origin, 200);
    wait 0.2;
  }
}

jets_launching() {
  thread slow_intro_jet_takeoff_guys("jet_handler1", "launch1_handler1", "intro_launch1_handler1_paths", "jet_takeoff1_exit", 0.8, 9);
  thread slow_intro_jet_takeoff_guys("jet_handler2", "launch1_handler2", "intro_launch1_handler2_paths", "jet_takeoff1_exit", 0.9, 9);
  thread slow_intro_jet_takeoff_guys("jet_shooter1", "launch1_shooter1", "intro_launch1_shooter1_paths", "jet_takeoff1_exit", 1, 9);
  thread jet_takeoff1();
  thread jet_takeoff2_guys();
  thread jet_takeoff2();
}

jet_takeoff1() {
  slow_intro_jet_takeoff_jet("anim_jet_launcher1", "jet_launcher1", "jet_takeoff1_exit", 9);
}

jet_takeoff2_guys() {
  thread slow_intro_jet_takeoff_guys("jet_handler1", "launch2_handler1", "intro_launch2_handler1_paths", "jet_takeoff2_exit", 1, 5);
  thread slow_intro_jet_takeoff_guys("jet_handler2", "launch2_handler2", "intro_launch2_handler2_paths", "jet_takeoff2_exit", 0.9, 5);
  thread slow_intro_jet_takeoff_guys("jet_shooter1", "launch2_shooter1", "intro_launch2_shooter1_paths", "jet_takeoff2_exit", 0.7, 5);
}

jet_takeoff2() {
  slow_intro_jet_takeoff_jet("anim_jet_launcher2", "jet_launcher2", "jet_takeoff2_exit", 5);
}

slow_intro_jet_takeoff_guys(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = common_scripts\utility::getstruct("slow_intro_jet_ref", "targetname");
  var_7 = maps\_utility::spawn_targetname(var_0);
  var_7.animname = var_1;
  var_7.runanim = maps\_utility::getgenericanim("unarmed_run");
  var_7 maps\_utility::gun_remove();
  var_8 = getanimlength(level.scr_anim[var_1][var_3]);
  var_9 = var_5 / var_8;
  var_6 thread maps\_anim::anim_single_solo(var_7, var_3);
  common_scripts\utility::waitframe();
  var_7 setanimtime(level.scr_anim[var_1][var_3], var_9);
  var_7 waittillmatch("single anim", "end");
  var_7.target = var_2;
  var_7 maps\_utility::set_moveplaybackrate(var_4);
  var_7 thread maps\_drone::drone_move();
  common_scripts\utility::flag_wait("start_promo_fade");

  if(isDefined(var_7))
    var_7 delete();
}

slow_intro_jet_takeoff_jet(var_0, var_1, var_2, var_3) {
  var_4 = common_scripts\utility::getstruct("redshirt_forklift_stopper_ref", "targetname");
  var_5 = getent(var_0, "targetname");
  var_5.animname = var_1;
  var_5 maps\_anim::setanimtree();
  var_5 thread maps\carrier_fx::handle_jet_launch_fx();
  var_6 = getanimlength(level.scr_anim[var_1][var_2]);
  var_7 = var_3 / var_6;
  var_4 thread maps\_anim::anim_single_solo(var_5, var_2);
  wait 0.15;
  var_5 setanimtime(level.scr_anim[var_1][var_2], var_7);
  var_5 waittillmatch("single anim", "end");
}

tugger_hookup() {
  var_0 = common_scripts\utility::getstruct("intro_tugger_hookup_ref", "targetname");
  var_1 = getEntArray("anim_tugger", "targetname");
  common_scripts\utility::array_thread(var_1, maps\_utility::show_entity);
  var_2 = [];
  var_3 = [];
  var_4 = [];

  foreach(var_6 in var_1) {
    if(var_6.script_noteworthy == "item") {
      var_2 = var_6;
      continue;
    }

    if(var_6.script_noteworthy == "clip") {
      var_3 = var_6;
      continue;
    }

    var_4 = var_6;
  }

  var_3 linkto(var_2);
  var_4 linkto(var_2);
  var_2.animname = "tugger";
  var_2 maps\_anim::setanimtree();
  var_8 = [];
  var_8[0] = maps\_utility::spawn_targetname("tugger_director");
  var_8[0].animname = "director";
  var_8[0] maps\_utility::gun_remove();
  var_8[1] = maps\_utility::spawn_targetname("tugger_inspector1");
  var_8[1].animname = "inspector1";
  var_8[1] maps\_utility::gun_remove();
  var_8[2] = maps\_utility::spawn_targetname("tugger_inspector2");
  var_8[2].animname = "inspector2";
  var_8[2] maps\_utility::gun_remove();
  var_8[3] = maps\_utility::spawn_targetname("jet_pilot");
  var_8[3].animname = "pilot";
  var_8[3] maps\_utility::gun_remove();
  var_9 = maps\carrier_code::setup_jet_and_clip("front_elevator_jet");
  var_9.animname = "elevator_jet";
  var_9 maps\_anim::setanimtree();
  var_0 thread maps\_anim::anim_first_frame(var_8, "tugger_scene_enter");
  var_0 thread maps\_anim::anim_first_frame_solo(var_2, "tugger_scene_enter");
  var_0 maps\_anim::anim_first_frame_solo(var_9, "elevator_jet_scene_enter");
  wait 4;
  var_0 thread maps\_anim::anim_single(var_8, "tugger_scene_enter");
  var_0 maps\_anim::anim_single_solo(var_2, "tugger_scene_enter");
  common_scripts\utility::flag_wait("slow_intro_finished");
  var_8[0] delete();
  var_8[1] delete();
  var_8[2] delete();
  var_8[3] delete();
}

lower_shield1() {
  var_0 = getent("blast_shield1", "targetname");
  var_0 rotateto((0, 0, -65), 4);
  var_1 = getent("blast_shield2", "targetname");
  var_1 rotateto((0, 0, -65), 3.5);
  var_2 = getent("blast_shield3", "targetname");
  var_2 rotateto((0, 0, -65), 4);
}

lower_shield2() {
  var_0 = getent("blast_shield4", "targetname");
  var_0 rotateto((0, 0, -65), 3.75);
  var_1 = getent("blast_shield5", "targetname");
  var_1 rotateto((0, 0, -65), 4);
  var_2 = getent("blast_shield6", "targetname");
  var_2 rotateto((0, 0, -65), 3.5);
}

hide_deck_objects() {
  var_0 = getEntArray("odin_jet_1", "targetname");
  common_scripts\utility::array_call(var_0, ::hide);
  var_1 = getEntArray("odin_jet_2", "targetname");
  common_scripts\utility::array_call(var_1, ::hide);
  var_2 = getEntArray("sliding_jet1", "targetname");
  common_scripts\utility::array_call(var_2, ::hide);
  var_3 = getEntArray("large_tugger2", "targetname");
  common_scripts\utility::array_call(var_3, ::hide);
  var_4 = getEntArray("large_tugger3", "targetname");
  common_scripts\utility::array_call(var_4, ::hide);
  var_5 = getent("intro_drive_tugger_close_up", "targetname");
  var_5 hide();
  var_6 = getEntArray("barrel_impact", "targetname");
  common_scripts\utility::array_call(var_6, ::hide);
  var_6 = getEntArray("barrel_impact_2", "targetname");
  common_scripts\utility::array_call(var_6, ::hide);
  var_7 = getEntArray("deck_props_delete", "targetname");
  common_scripts\utility::array_call(var_7, ::hide);
  var_8 = getEntArray("odin_impact_objects", "targetname");
  var_8 = common_scripts\utility::array_combine(var_8, getEntArray("odin_impact_objects_2", "targetname"));
  common_scripts\utility::array_call(var_8, ::hide);
  var_9 = getEntArray("odin_phys_objects", "targetname");
  common_scripts\utility::array_call(var_9, ::hide);
  var_9 = getEntArray("odin_phys_objects_2", "targetname");
  common_scripts\utility::array_call(var_9, ::hide);
  var_10 = getEntArray("barrel_med1b", "targetname");
  common_scripts\utility::array_call(var_10, ::hide);
  var_11 = getEntArray("sliding_cart_01b", "targetname");
  common_scripts\utility::array_call(var_11, ::hide);
  var_12 = getEntArray("sliding_cart_01a", "targetname");
  common_scripts\utility::array_call(var_12, ::hide);
  var_13 = getEntArray("sliding_crate_01b", "targetname");
  common_scripts\utility::array_call(var_13, ::hide);
  var_14 = getEntArray("jet11_cart", "targetname");
  common_scripts\utility::array_call(var_14, ::hide);
  var_15 = getEntArray("jet11_missile_rack", "targetname");
  common_scripts\utility::array_call(var_15, ::hide);
}

slow_intro_ally_movement() {
  var_0 = maps\carrier_code::array_spawn_targetname_allow_fail("intro_deck_tower_runner", 1);
  wait 1;
  var_1 = maps\carrier_code::array_spawn_targetname_allow_fail("intro_catwalk_runner", 1);
  wait 2.5;
  var_2 = maps\carrier_code::array_spawn_targetname_allow_fail("intro_chopter_runner_backup_guys", 1);
  var_3 = getent("intro_chopter_runner_animated", "targetname");
  var_4 = var_3 maps\_utility::spawn_ai(1, 0);
  var_4.animname = "generic";

  if(isalive(var_4)) {
    var_5 = common_scripts\utility::getstruct("ally_wave1", "targetname");
    var_5 maps\_anim::anim_reach_solo(var_4, "forward_wave_back");
    var_5 maps\_anim::anim_single_solo(var_4, "forward_wave_back");
    var_5 = common_scripts\utility::getstruct("ally_wave2", "targetname");
    var_5 maps\_anim::anim_reach_solo(var_4, "forward_wave_back");
    var_5 maps\_anim::anim_single_solo(var_4, "forward_wave_back");
  }
}

tugger_events() {
  wait 2;
  thread tugger_jet_taxi();
  wait 1;
  thread cross_deck_tugger();
  wait 16.5;
  thread tugger_closeup();
}

tugger_jet_taxi() {
  wait 2;
  var_0 = getent("intro_taxing_jet", "targetname");
  var_1 = getent("intro_taxing_tugger", "targetname");
  var_0 linkto(var_1);
  var_2 = common_scripts\utility::getstruct(var_1.target, "targetname");
  var_1 moveto(var_2.origin, 7);
  var_3 = common_scripts\utility::getstruct(var_2.target, "targetname");
  var_1 moveto(var_3.origin, 7);
  var_4 = common_scripts\utility::getstruct("final_pos", "targetname");
  var_1 rotateto(var_4.angles, 4, 1);
  var_5 = common_scripts\utility::getstruct(var_3.target, "targetname");
  var_1 moveto(var_5.origin, 13);
}

cross_deck_tugger() {
  var_0 = getent("intro_drive_tugger", "targetname");
  var_1 = common_scripts\utility::getstruct(var_0.target, "targetname");
  var_0 moveto(var_1.origin, 7);
  var_2 = common_scripts\utility::getstruct("tugger_final_pos", "targetname");
  var_0 rotateto(var_2.angles, 1, 1);
  wait 7;
  var_3 = common_scripts\utility::getstruct(var_1.target, "targetname");
  var_0 moveto(var_3.origin, 7);
}

tugger_closeup() {
  var_0 = getent("intro_drive_tugger_close_up", "targetname");
  var_0 show();
  var_1 = common_scripts\utility::getstruct(var_0.target, "targetname");
  var_0 moveto(var_1.origin, 5);
}

cleanup_intro_exterior() {
  var_0 = getEntArray("odin_jet_1", "targetname");
  common_scripts\utility::array_call(var_0, ::show);
  var_1 = getEntArray("odin_jet_2", "targetname");
  common_scripts\utility::array_call(var_1, ::show);
  var_2 = getEntArray("sliding_jet1", "targetname");
  common_scripts\utility::array_call(var_2, ::show);
  var_3 = getEntArray("large_tugger2", "targetname");
  common_scripts\utility::array_call(var_3, ::show);
  var_4 = getEntArray("large_tugger3", "targetname");
  common_scripts\utility::array_call(var_4, ::show);
  var_5 = getEntArray("barrel_impact", "targetname");
  common_scripts\utility::array_call(var_5, ::show);
  var_5 = getEntArray("barrel_impact_2", "targetname");
  common_scripts\utility::array_call(var_5, ::show);
  var_6 = getEntArray("deck_props_delete", "targetname");
  common_scripts\utility::array_call(var_6, ::show);
  var_7 = getEntArray("odin_impact_objects", "targetname");
  var_7 = common_scripts\utility::array_combine(var_7, getEntArray("odin_impact_objects_2", "targetname"));
  common_scripts\utility::array_call(var_7, ::show);
  var_8 = getEntArray("odin_phys_objects", "targetname");
  common_scripts\utility::array_call(var_8, ::show);
  var_8 = getEntArray("odin_phys_objects_2", "targetname");
  common_scripts\utility::array_call(var_8, ::show);
  var_9 = getEntArray("sliding_cart_01b", "targetname");
  common_scripts\utility::array_call(var_9, ::show);
  var_10 = getEntArray("sliding_cart_01a", "targetname");
  common_scripts\utility::array_call(var_10, ::show);
  var_11 = getEntArray("sliding_crate_01b", "targetname");
  common_scripts\utility::array_call(var_11, ::show);
  var_12 = getEntArray("jet11_cart", "targetname");
  common_scripts\utility::array_call(var_12, ::show);
  var_13 = getEntArray("jet11_missile_rack", "targetname");
  common_scripts\utility::array_call(var_13, ::show);
  var_14 = getEntArray("barrel_med1b", "targetname");
  common_scripts\utility::array_call(var_14, ::show);
  var_15 = maps\_utility::get_living_ai_array("intro_ally_deck", "script_noteworthy");
  maps\_utility::array_delete(var_15);
  var_16 = level.drones["allies"].array;

  foreach(var_18 in var_16) {
    if(isDefined(var_18.script_noteworthy) && var_18.script_noteworthy == "intro_ally_deck")
      var_18 delete();
  }
}