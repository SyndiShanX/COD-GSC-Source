/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\dc_crashsite.gsc
********************************************************/

#include maps\_utility;
#include maps\_vehicle;
#include maps\_anim;
#include maps\_hud_util;
#include common_scripts\utility;

main() {
  flag_init("obj_heli_ride_complete");
  flag_init("player_crash_done");
  flag_init("obj_crash_site_given");
  flag_init("obj_crash_site_complete");
  flag_init("crash_actors_ready");
  flag_init("crash_fade_up");
  flag_init("crash_redshirt_speaks");
  flag_init("macey_last_mag_dialogue");
  flag_init("give_player_weapon");
  flag_init("redshirt_headshot");
  flag_init("player_ran_out_of_first_clip");
  flag_init("macey_clip_to_player");
  flag_init("macey_wont_throw_clip_to_player");
  flag_init("macey_should_throw_clip_to_player");
  flag_init("end_sequence_music");
  flag_init("end_sequence_starting");
  flag_init("friendly_02_injured");
  flag_init("crash_cut_to_black");
  flag_init("notetrack_player_upright");
  flag_init("notetrack_player_raisehands");
  flag_init("notetrack_player_lowerhands");
  flag_init("emp_entity_cleanup_done");
  flag_init("emp_back_from_whiteout");
  flag_init("first_wave_done");
  flag_init("can_talk_crashsite");
  flag_set("can_talk_crashsite");

  precacheshellshock("dcburning");
  precacheModel("weapon_m4_clip");
  preCacheModel("viewhands_player_us_army");
  precacheTurret("heli_spotlight");

  crash_anims();
  crash_player_anims();
  crash_bh_anims();

  array_thread(getvehiclenodearray("plane_sound", "script_noteworthy"), maps\_mig29::plane_sound_node);
}

AA_crash_site_init() {
  array_spawn_function_noteworthy("axis_crash", ::AI_axis_crash_think);
  thread AAA_sequence_player_crash_site();
  thread obj_crash_site();
  thread dialogue_crash_site();
  thread crash_music();
  thread player_crash_gun_behavior();
  thread crash_vehicles();
}

dialogue_crash_site() {
  crash_chatter_org_left = getent("crash_chatter_org_left", "targetname");
  crash_chatter_org_right = getent("crash_chatter_org_right", "targetname");

  flag_wait("crash_actors_ready");

  radio_dialogue("dcburn_hqr_doyoucopy");

  wait(1);

  radio_dialogue("dcburn_hqr_howcopy");

  wait(1);

  crash_chatter_org_left delaycall(1.5, ::playsound, "dcburn_ar3_twomags");

  level.friendly02 dialogue_queue("dcburn_cpd_target2");

  wait(2);

  level.teamleader dialogue_queue("dcburn_mcy_talktome");

  crash_chatter_org_right delaycall(0, ::playsound, "dcburn_ar4_watch3");

  wait(1);

  level.friendly02 thread dialogue_queue("dcburn_cpd_target11");

  flag_wait("crash_redshirt_speaks");

  level.friendly03.soundOrg = spawn_tag_origin();
  level.friendly03.soundOrg.origin = level.player.origin;
  level.friendly03.soundOrg linkTo(level.player);
  level.friendly03.soundOrg thread entity_delete_on_flag("redshirt_headshot");
  level.friendly03.soundOrg thread play_sound_on_tag_endon_death("dcburn_gr1_hangon", "tag_origin");

  flag_wait("redshirt_headshot");
  wait(1);

  crash_chatter_org_left delaycall(1, ::playsound, "dcburn_ar1_reloadingcover");

  level.teamleader dialogue_queue("dcburn_mcy_wadesdown");

  flag_set("obj_crash_site_given");

  wait(2);

  crash_chatter_org_right play_sound_in_space("dcburn_ar2_mccordcovering");

  wait(4);

  crash_chatter_org_left delaycall(0, ::playsound, "dcburn_ar2_lastmag");

  flag_wait("macey_last_mag_dialogue");

  level.teamleader play_sound_on_entity("dcburn_mcy_lastone");

  wait(.5);

  level.teamleader dialogue_queue("dcburn_mcy_ammocheck");

  crash_chatter_org_right delaycall(.3, ::playsound, "dcburn_ar4_imgood");

  wait(1.5);

  level.friendly02 dialogue_queue("dcburn_cpd_toomany");

  crash_chatter_org_right play_sound_in_space("dcburn_ar2_seanlast");

  level.teamleader thread dialogue_queue("dcburn_mcy_soundoff");

  flag_wait("end_sequence_starting");

  crash_chatter_org_left = getent("crash_chatter_org_left", "targetname");
  crash_chatter_org_right = getent("crash_chatter_org_right", "targetname");

  crash_chatter_org_right delaycall(0, ::playsound, "dcburn_ar1_newtarget");

  wait(1);

  wait(1);

  crash_chatter_org_left delaycall(.6, ::playsound, "dcburn_ar2_gotitgotit");
}

entity_delete_on_flag(sFlag) {
  self endon("death");
  flag_wait(sFlag);
  if(isDefined(self))
    self delete();
}

AAA_sequence_player_crash_site() {
  level.player enableinvulnerability();

  level.noMaxMortarDist = true;
  level.playerMortarFovOffset = (0, 0, 0);
  level._effect["mortar"]["dirt"] = loadfx("explosions/grenadeExp_dirt");

  crash_node = getent("crash_node", "targetname");

  movement_grid = crash_site_player_and_heli_setup();

  flag_wait("player_crash_done");
  if(level.script == "dcburning")
    thread autosave_now(true);

  setsaveddvar("sm_sunSampleSizeNear", 0.25);
  setsaveddvar("sm_sunShadowScale", 1);
  maps\_utility::vision_set_fog_changes("dcburning_crash", 0);
  if(getdvarint("r_dcburning_culldist") == 1) {
    level.culldist = getculldist();
    setculldist(23000);
  }
  music_stop();

  if(level.script == "dc_burning") {
    array_thread(level.effects_ww2, ::pauseEffect);
    array_thread(level.effects_trenches, ::pauseEffect);
    array_thread(level.effects_commerce, ::pauseEffect);
  }

  if(!isDefined(level.black_overlay)) {
    level.black_overlay = create_client_overlay("black", 1);
    level.black_overlay.foreground = false;
  }

  anim_actors_rescue = [];

  level.teamleader = spawn_targetname("teamLeaderCrash", true);
  level.friendly02 = spawn_targetname("friendly02Crash", true);
  level.friendly03 = spawn_targetname("friendly03Crash", true);

  level.teamleader hide();
  level.friendly02 hide();
  level.friendly03 hide();

  level.teamleader.animname = "crash_leader";
  level.friendly02.animname = "crash_dunn";
  level.friendly03.animname = "crash_redshirt";
  level.teamleader thread AI_ignored_and_oblivious_crashsite();
  level.friendly02 thread AI_ignored_and_oblivious_crashsite();
  level.friendly03 thread AI_ignored_and_oblivious_crashsite();

  level.teamleader thread magic_bullet_shield(true);
  level.friendly02 thread magic_bullet_shield(true);

  level.teamleader set_flavorbursts(false);
  level.friendly02 set_flavorbursts(false);
  level.friendly03 set_flavorbursts(false);

  crash_node = getent("crash_node", "targetname");

  ePlayer_rig = spawn_anim_model("player_rig");

  anim_actors_rescue[0] = ePlayer_rig;
  anim_actors_rescue[1] = level.friendly03;

  crash_node anim_first_frame(anim_actors_rescue, "dcburning_BHrescue");

  level.m4 = spawn("script_model", (0, 0, 0));
  level.m4 setModel("weapon_m4");
  level.m4 HidePart("TAG_THERMAL_SCOPE");
  level.m4 HidePart("TAG_FOREGRIP");

  level.m4 HidePart("TAG_HEARTBEAT");

  level.m4 HidePart("TAG_RED_DOT");
  level.m4 HidePart("TAG_SHOTGUN");
  level.m4 HidePart("TAG_SILENCER");
  level.m4.origin = level.friendly03 gettagorigin("tag_inhand");
  level.m4.angles = level.friendly03 gettagangles("tag_inhand");
  level.m4 linkto(level.friendly03, "tag_inhand");
  level.m4 thread delete_on_flag("redshirt_headshot");

  level.player freezecontrols(true);
  level.player PlayerLinkToDelta(ePlayer_rig, "tag_player", 1, 0, 0, 0, 0, true);

  thread player_crash_movement(movement_grid["top_left"], movement_grid["bot_right"], ePlayer_rig);

  flag_set("crash_actors_ready");

  wait(3);
  flag_set("obj_heli_ride_complete");
  wait(4);

  spawn_trigger_dummy_crashsite("dummy_spawner_axis_crash_flood");
  axis_crash_drones = getEntArray("axis_crash_drones", "targetname");
  thread drone_flood_start_crashsite(axis_crash_drones, "axis_crash_drones");

  flag_set("crash_fade_up");
  delaythread(8, maps\_mortar::bog_style_mortar_on, 3);
  level.black_overlay fadeOverTime(2);
  level.black_overlay.alpha = 0;

  level.friendly03 show();
  hostiles_drones_crash_site_01 = array_spawn(getEntArray("hostiles_drones_crash_site_01", "targetname"));

  level.friendly03.dontdonotetracks = true;
  level.friendly03.dropweapon = false;
  level.friendly03.script_looping = 0;
  level.friendly03 setcontents(0);
  level.friendly03.skipDeathAnim = true;
  level.friendly03.noragdoll = true;
  level.friendly03 thread delete_at_end_of_anim();
  crash_node thread anim_single(anim_actors_rescue, "dcburning_BHrescue");

  anim_actors_leader_and_dunn = [];
  anim_actors_leader_and_dunn[0] = level.teamleader;
  anim_actors_leader_and_dunn[1] = level.friendly02;
  level.teamleader show();
  level.friendly02 show();
  crash_node anim_single(anim_actors_leader_and_dunn, "vehicle_cover");

  flag_set("first_wave_done");

  flag_set("macey_should_throw_clip_to_player");

  thread macey_last_mag_dialogue();

  time = getanimlength(level.teamleader getanim("dcburning_BHrescue_throwclip")) - 5.0;
  thread flag_set_delayed("end_sequence_music", time);

  crash_node anim_single(anim_actors_leader_and_dunn, "dcburning_BHrescue_throwclip");

  flag_set("end_sequence_starting");

  delaythread(2, maps\_mortar::bog_style_mortar_off, 3);
  crash_node thread anim_single(anim_actors_leader_and_dunn, "dcburning_BHrescue_laststand");

  level.friendly02 thread play_sound_on_entity("dcburn_cpd_tracer3rounds");

  foreach(guy in anim_actors_leader_and_dunn)
  guy.ignorme = true;
  level.player.ignoreme = true;

  flag_wait("crash_cut_to_black");

  level.black_overlay destroy();

  crash_end_scene();
}

delete_on_flag(sFlag) {
  flag_wait(sFlag);
  if(isDefined(self))
    self delete();
}

macey_last_mag_dialogue() {}

player_crash_gun_behavior() {
  flag_wait("player_crash_done");
  level.player takeallweapons();
  level.player disableweapons();

  flag_wait("give_player_weapon");
  thread autosave_now(true);
  SetSavedDvar("hud_showStance", "1");
  setsaveddvar("ui_hidemap", 0);
  setSavedDvar("hud_drawhud", "1");
  SetSavedDvar("hud_showStance", "1");
  SetSavedDvar("compass", "1");
  setDvar("old_compass", "1");
  SetSavedDvar("ammoCounterHide", "0");
  level.player allowcrouch(true);

  level.player giveWeapon("m4m203_eotech");
  level.player SetWeaponAmmoClip("m4m203_eotech", 0);
  level.player SetWeaponAmmoStock("m4m203_eotech", 0);
  level.player SetWeaponAmmoClip("m203_m4_eotech", 0);
  level.player SetWeaponAmmoStock("m203_m4_eotech", 0);
  level.player switchToWeapon("m4m203_eotech");
  level.player enableweapons();

  if(level.script == "dcemp") {
    level.player giveWeapon("fraggrenade");
    level.player giveWeapon("flash_grenade");
    level.player setOffhandSecondaryClass("flash");
    level.player setWeaponAmmoStock("fraggrenade", 0);
    level.player setWeaponAmmoStock("flash_grenade", 0);
  }

  level.player SetWeaponAmmoClip("m4m203_eotech", 30);
  level.player SetWeaponAmmoStock("m4m203_eotech", 0);

  thread player_ammo_monitor_clip_01();

  flag_wait_either("macey_wont_throw_clip_to_player", "macey_should_throw_clip_to_player");

  if(flag("macey_should_throw_clip_to_player")) {
    flag_wait("macey_clip_to_player");

    level.player SetWeaponAmmoClip("m4m203_eotech", 0);
    level.player SetWeaponAmmoStock("m4m203_eotech", 30);
  } else {}
}

delete_at_end_of_anim() {
  self waittillmatch("single anim", "end");
  weapon_model = getWeaponModel(self.weapon);
  weapon = self.weapon;
  if(isDefined(weapon_model)) {
    self detach(weapon_model, "tag_weapon_right");
  }

  self kill();
}

player_ammo_monitor_clip_01() {
  while(level.player GetWeaponAmmoClip("m4m203_eotech") > 0)
    wait(0.05);
  flag_set("player_ran_out_of_first_clip");
}

waittill_player_fires_empty_gun() {
  while(!level.player attackButtonPressed())
    wait(0.05);
}

crash_site_player_and_heli_setup() {
  crash_node = getent("crash_node", "targetname");

  level.player allowstand(true);
  level.player allowprone(false);
  level.player allowsprint(false);
  level.player allowjump(false);
  level.player allowcrouch(false);

  player_crash_heli = getent("crash_site", "targetname");
  dummy = player_crash_heli;

  crash_site_clip = getent("crash_site_clip", "targetname");
  heli_clip = getent("intro_heli_after_emp_clip", "targetname");
  crash_site_top_bar = getent("crash_site_top_bar", "targetname");
  crash_site_bot_bar = getent("crash_site_bot_bar", "targetname");
  movement_grid_top_left = getent("movement_grid_top_left", "targetname");
  movement_grid_bot_right = getent("movement_grid_bot_right", "targetname");
  movement_grid_exit = getent("movement_grid_exit", "targetname");

  crash_site_clip show();
  heli_clip notsolid();

  crash_site_clip linkto(dummy);
  movement_grid_top_left linkto(dummy);
  movement_grid_bot_right linkto(dummy);
  movement_grid_exit linkto(dummy);
  heli_clip linkto(dummy);

  if(level.script == "dcburning") {
    crash_site_top_bar linkto(dummy);
    crash_site_bot_bar linkto(dummy);
  } else {
    level.plank2 = spawn_anim_model("plank2", crash_site_top_bar getorigin());
    level.plank1 = spawn_anim_model("plank1", crash_site_bot_bar getorigin());
    level.planks = [];
    level.planks[0] = level.plank1;
    level.planks[1] = level.plank2;

    crash_site_top_bar linkto(level.plank2);
    crash_site_bot_bar linkto(level.plank1);

    crash_node anim_first_frame(level.planks, "dcemp_BHrescue");
  }

  player_crash_heli.animname = "crash_blackhawk";
  player_crash_heli assign_animtree();
  crash_node anim_first_frame_solo(player_crash_heli, "rotors_start");

  add_wait(::flag_wait, "player_crash_done");
  add_func(::player_crash_vision);
  player_crash_heli add_call(::show);
  crash_node add_func(::anim_loop_solo, player_crash_heli, "rotors");
  thread do_wait();

  movement_grid = [];
  movement_grid["top_left"] = movement_grid_top_left;
  movement_grid["bot_right"] = movement_grid_bot_right;
  return movement_grid;
}

crash_end_scene() {
  if(level.script == "dcburning") {
    white_overlay = crash_white_out();

    wait(1);
    vehicle_delete_all_crashsite();
    aAI = getaiarray();
    array_thread(aAI, ::AI_delete_crashsite);

    wait(2);

    nextMission();
  } else {
    white_overlay = crash_white_out();
    level.white_overlay = white_overlay;

    if(level.start_point != "emp") {
      excluders = [];
      excluders[excluders.size] = level.emp_heli_spotlight;
      excluders[excluders.size] = level.emp_btr80;
      excluders = array_combine(excluders, level.helis_crash_rappel);
      excluders = array_combine(excluders, level.helis_crash_distant);

      vehicle_delete_all_crashsite(excluders);

      array_thread(getaiarray("neutral", "allies"), ::AI_delete_crashsite);
      array_call(getEntArray("axis_crash_flood", "targetname"), ::delete);

      level notify("stop_drone_flood" + "axis_crash_drones");
      drones = getEntArray("axis_crash_drone", "script_noteworthy");
      array_call(drones, ::delete);
    }
    flag_set("emp_entity_cleanup_done");
    level.player disableinvulnerability();

    if(getdvarint("r_dcburning_culldist") == 1) {
      setculldist(level.culldist);
    }
  }

}

crash_white_out() {
  white_overlay = create_client_overlay("white", 0);

  wait(.6);

  white_overlay fadeOverTime(.2);
  white_overlay.alpha = 1;

  thread play_sound_in_space("emp_whoosh", level.player.origin + (0, 0, 100), true);
  delaythread(.5, ::crash_cut_sound);

  wait(.3);

  return white_overlay;
}

crash_cut_sound() {
  time = .25;

  level.player SetEqLerp(1, level.eq_main_track);
  AmbientStop(time);
  thread maps\_ambient::use_eq_settings("sound_fadeout", level.eq_mix_track);
  thread maps\_ambient::blend_to_eq_track(level.eq_mix_track, time);
}

crash_vehicles() {
  flag_wait("crash_redshirt_speaks");
  delaythread(0, ::spawn_vehicles_from_targetname_and_drive, "jets_crash_site_01");
  helis = spawn_vehicles_from_targetname_and_drive("helis_crash_rappel");
  array_thread(helis, ::godOn);
  flag_wait("end_sequence_starting");
  btr80s_end = spawn_vehicles_from_targetname_and_drive("btr80s_end");
  array_thread(btr80s_end, ::godOn);
  array_thread(btr80s_end, ::btr80s_end_think);

  thread heli_crash_site_spotlight_think(btr80s_end);
}

btr80s_end_think() {
  self ent_flag_init("stop_btr");
  self ent_flag_wait("stop_btr");
  self vehicle_setSpeed(0, 3, 3);
  self setTurretTargetVec(level.player.origin + (0, 0, 32));
}

player_crash_vision() {
  SetBlur(3, .1);
  setsaveddvar("ui_hidemap", 1);
  SetSavedDvar("hud_showStance", "0");
  SetSavedDvar("compass", "0");

  handsDuration = getanimlength(level.scr_anim["player_rig"]["dcburning_BHrescue"]);
  shellshockTime = handsDuration + 2;

  level.player shellshock("dcburning", shellshockTime);

  dof_start = level.dofDefault;

  flag_wait("notetrack_player_upright");
  SetBlur(3, .5);
  wait(.5);
  SetBlur(.2, .5);
  wait(.5);
  SetBlur(3, .5);

  flag_wait("notetrack_player_raisehands");

  dof_see_hands = [];
  dof_see_hands["nearStart"] = 0;
  dof_see_hands["nearEnd"] = 0;
  dof_see_hands["nearBlur"] = 6;
  dof_see_hands["farStart"] = 30;
  dof_see_hands["farEnd"] = 70;
  dof_see_hands["farBlur"] = 2.5;
  thread blend_dof(dof_start, dof_see_hands, 3);
  SetBlur(0, 3);

  flag_wait("notetrack_player_lowerhands");

  dof_see_dudes = [];
  dof_see_dudes["nearStart"] = 4.7;
  dof_see_dudes["nearEnd"] = 56;
  dof_see_dudes["nearBlur"] = 6;
  dof_see_dudes["farStart"] = 1000;
  dof_see_dudes["farEnd"] = 7000;
  dof_see_dudes["farBlur"] = 0;

  thread blend_dof(dof_see_hands, dof_start, 6);
}

blur_blink() {
  SetBlur(3, .5);
  wait(.5);
  SetBlur(0, .5);
  wait(.5);
  SetBlur(3, .5);
}

crash_music() {
  flag_wait("end_sequence_music");

  thread musicPlayWrapper("dcburning_crashsite_01");

  flag_wait("end_sequence_starting");

  wait(11.5);
  flag_set("crash_cut_to_black");
  battlechatter_off("axis");
}

player_killing_crash_enemies_at_good_pace() {
  currentTime = getTime();
  timeElapsed = currentTime - level.lasttimePlayerKilledEnemy;
  if(currentTime == level.lasttimePlayerKilledEnemy)
    return true;
  else if(timeElapsed > 5000)
    return false;
  else
    return true;
}

crash_dlight(ePlayer_rig) {
  while(!flag("end_sequence_starting")) {
    playFXOnTag(getfx("dlight_blue"), ePlayer_rig, "tag_player");
    wait(1);
    stopFXOnTag(getfx("dlight_blue"), ePlayer_rig, "tag_player");
    wait(.3);
    playFXOnTag(getfx("dlight_blue"), ePlayer_rig, "tag_player");
    wait(.5);
    stopFXOnTag(getfx("dlight_blue"), ePlayer_rig, "tag_player");
    wait(.3);
    playFXOnTag(getfx("dlight_blue"), ePlayer_rig, "tag_player");
    wait(.2);
    stopFXOnTag(getfx("dlight_blue"), ePlayer_rig, "tag_player");
    wait(.4);
    playFXOnTag(getfx("dlight_blue"), ePlayer_rig, "tag_player");
    wait(.6);
    stopFXOnTag(getfx("dlight_blue"), ePlayer_rig, "tag_player");
    wait(.4);
  }

  stopFXOnTag(getfx("dlight_blue"), ePlayer_rig, "tag_player");
}

player_crash_movement(movement_grid_top_left, movement_grid_bot_right, ePlayer_rig) {
  level endon("player_shot");
  level endon("player_unlinked");

  flag_wait("crash_fade_up");

  thread crash_dlight(ePlayer_rig);

  if(level.script != "dcemp" || level.start_point != "iss")
    delaythread(1, ::open_player_fov, ePlayer_rig);

  flag_wait("redshirt_headshot");

  ePlayer_rig hide();
  zoffset = (0, 0, 0);
  crash_node = getent("crash_node", "targetname");
  playerOrg = spawn_tag_origin();

  playerOrg.origin = level.player.origin + zoffset;
  playerOrg.angles = ePlayer_rig.angles + (0, 0, 0);

  if(level.script != "dcemp" || level.start_point != "iss") {
    level.player unlink();
    level.player playerLinkToBlend(playerOrg, "tag_player", .5);
    wait(.5);
    level.player PlayerLinkToDelta(playerOrg, "tag_player", 1, 45, 60, 20, 15, true);
  }

  level.player.playerrig = playerOrg;

  moveRate = 3;
  updateTime = 0.05;

  maxValueX = movement_grid_top_left.origin[0];
  maxValueY = movement_grid_bot_right.origin[1];

  minValueX = movement_grid_bot_right.origin[0];
  minValueY = movement_grid_top_left.origin[1];

  valueX = undefined;
  valueY = undefined;
  valueZ = undefined;

  while(true) {
    wait(updateTime);

    movement = level.player GetNormalizedMovement();

    forward = anglesToForward(level.player.angles);
    right = anglesToRight(level.player.angles);

    forward *= movement[0] * moveRate;
    right *= movement[1] * moveRate;

    newLocation = playerOrg.origin + forward + right;
    newLocation = (newLocation[0], newLocation[1], crash_node.origin[2]);

    valueX = cap_value(newLocation[0], minValueX, maxValueX);
    valueY = cap_value(newLocation[1], minValueY, maxValueY);
    valueZ = playerOrg.origin[2];
    newLocation = (valueX, valueY, valueZ);

    playerOrg.origin = newLocation;
  }
}

AI_axis_crash_think() {
  self.interval = 0;
  self.neverEnableCQB = true;
  self.grenadeawareness = 0;
  self.ignoresuppression = true;
  self.aggressivemode = true;

  self waittill("death", attacker);
  if((isDefined(attacker)) && (isPlayer(attacker)))
    level.lasttimePlayerKilledEnemy = getTime();
}

open_player_fov(ePlayer_rig) {
  level.player freezecontrols(false);

  level.player PlayerLinkToDelta(ePlayer_rig, "tag_player", 1, 25, 25, 15, 10, true);
}

heli_crash_site_spotlight_think(btr80s_end) {
  heli_crash_site_spotlight = spawn_vehicle_from_targetname_and_drive("heli_crash_site_spotlight");
  heli_crash_site_spotlight endon("death");
  heli_crash_site_spotlight thread godOn();
  heli_crash_site_spotlight vehicle_setSpeed(30);
  heli_crash_site_spotlight setmaxpitchroll(20, 20);
  wait(5);

  heli_crash_site_spotlight SetLookAtEnt(level.player);
  wait(2.5);

  heli_crash_site_spotlight thread maps\_attack_heli::heli_spotlight_on("tag_spotlight", false);
  heli_crash_site_spotlight setturrettargetent(btr80s_end[0]);

  wait(1.5);

  target2 = getent("btr80s_old_end", "targetname");
  heli_crash_site_spotlight setturrettargetent(target2);

  heli_crash_site_spotlight SetLookAtEnt(level.player);
  wait(2);
  heli_crash_site_spotlight vehicle_setSpeed(10);
  heli_crash_site_spotlight notify("stop_spotlight_random_targets");
  wait(.1);
  heli_crash_site_spotlight setturrettargetent(level.player);
  wait(2);
}
obj_crash_site() {
  flag_wait("obj_crash_site_given");
  if(level.script == "dcburning") {
    objective_number = 9;
    objective_add(objective_number, "active", &"DCBURNING_OBJ_CRASH_SITE");
    objective_current(objective_number);

    flag_wait("obj_crash_site_complete");

    objective_state(objective_number, "done");
  } else {
    objective_add(level.objnum, "active", &"DCEMP_OBJ_CRASH_SITE");
    objective_current(level.objnum);

    flag_wait("iss_fx");

    objective_delete(level.objnum);
  }
}

player_blackhawk_health_tweaks() {
  old_longRegenTime = level.player.gs.longRegenTime;
  old_deathInvulnerableTime = level.player.deathInvulnerableTime;
  old_bg_viewKickScale = getDvar("bg_viewKickScale");
  old_bg_viewKickMax = getDvar("bg_viewKickMax");
  old_bg_viewKickMin = getDvar("bg_viewKickMin");
  level.player ent_flag_clear("near_death_vision_enabled");

  level.player.gs.longRegenTime = 500;
  level.player.baseIgnoreRandomBulletDamage = true;
  level.ignoreRandomBulletDamage = true;
  level.player.deathInvulnerableTime = 7000;
  setsaveddvar("bg_viewKickScale", 0.1);
  setsaveddvar("bg_viewKickMax", "5");
  setsaveddvar("bg_viewKickMin", "1");

  flag_wait("player_crash_done");

  level.player.gs.longRegenTime = old_longRegenTime;
  level.player.deathInvulnerableTime = old_deathInvulnerableTime;
  setsaveddvar("bg_viewKickScale", old_bg_viewKickScale);
  setsaveddvar("bg_viewKickMax", old_bg_viewKickMax);
  setsaveddvar("bg_viewKickMin", old_bg_viewKickMin);
  level.player ent_flag_set("near_death_vision_enabled");
}

#using_animtree("generic_human");
crash_anims() {
  level.scr_radio["dcburn_hqr_doyoucopy"] = "dcburn_hqr_doyoucopy";

  level.scr_radio["dcburn_hqr_howcopy"] = "dcburn_hqr_howcopy";

  level.scr_radio["dcburn_hqr_doyoureadme"] = "dcburn_hqr_doyoureadme";

  level.scr_sound["crash_redshirt"]["dcburn_gr1_ramirez1"] = "dcburn_gr1_ramirez1";

  level.scr_sound["crash_redshirt"]["dcburn_gr1_ramirez2"] = "dcburn_gr1_ramirez2";

  level.scr_sound["dcburn_gr1_hangon"] = "dcburn_gr1_hangon";

  level.scr_sound["crash_leader"]["dcburn_mcy_wadesdown"] = "dcburn_mcy_wadesdown";

  level.scr_sound["crash_dunn"]["dcburn_cpd_toomany"] = "dcburn_cpd_toomany";

  level.scr_sound["crash_leader"]["dcburn_mcy_defendthispos"] = "dcburn_mcy_defendthispos";

  level.scr_sound["crash_dunn"]["dcburn_cpd_lastmag"] = "dcburn_cpd_lastmag";

  level.scr_sound["crash_leader"]["dcburn_mcy_lastone"] = "dcburn_mcy_lastone";

  level.scr_sound["crash_dunn"]["dcburn_cpd_imout"] = "dcburn_cpd_imout";

  level.scr_sound["crash_leader"]["dcburn_mcy_getdown"] = "dcburn_mcy_getdown";

  level.scr_sound["generic"]["dcburn_ar1_reloadingcover"] = "dcburn_ar1_reloadingcover";

  level.scr_sound["generic"]["dcburn_ar2_mccordcovering"] = "dcburn_ar2_mccordcovering";

  level.scr_sound["generic"]["dcburn_ar1_loading"] = "dcburn_ar1_loading";

  level.scr_sound["generic"]["dcburn_ar2_seanlast"] = "dcburn_ar2_seanlast";

  level.scr_sound["crash_dunn"]["dcburn_cpd_target2"] = "dcburn_cpd_target2";

  level.scr_sound["crash_leader"]["dcburn_mcy_ammocheck"] = "dcburn_mcy_ammocheck";

  level.scr_sound["generic"]["dcburn_ar4_imgood"] = "dcburn_ar4_imgood";

  level.scr_sound["crash_leader"]["dcburn_mcy_soundoff"] = "dcburn_mcy_soundoff";

  level.scr_sound["generic"]["dcburn_ar3_twomags"] = "dcburn_ar3_twomags";

  level.scr_sound["crash_leader"]["dcburn_mcy_mccord"] = "dcburn_mcy_mccord";

  level.scr_sound["generic"]["dcburn_ar2_lastmag"] = "dcburn_ar2_lastmag";

  level.scr_sound["crash_leader"]["dcburn_mcy_talktome"] = "dcburn_mcy_talktome";

  level.scr_sound["generic"]["dcburn_ar4_watch3"] = "dcburn_ar4_watch3";

  level.scr_sound["generic"]["dcburn_ar1_newtarget"] = "dcburn_ar1_newtarget";

  level.scr_sound["generic"]["dcburn_ar2_gotitgotit"] = "dcburn_ar2_gotitgotit";

  level.scr_sound["crash_dunn"]["dcburn_cpd_target11"] = "dcburn_cpd_target11";

  level.scr_sound["crash_dunn"]["dcburn_cpd_pain"] = "dcburn_cpd_pain";

  level.scr_sound["crash_leader"]["dcburn_mcy_hangon"] = "dcburn_mcy_hangon";

  level._effect["mortar"]["bunker_ceiling"] = loadfx("dust/ceiling_dust_bunker");
  level._effect["mortar"]["bunker_ceiling_green"] = loadfx("dust/ceiling_dust_bunker_green");
  level._effect["mortar"]["dirt_large"] = loadfx("explosions/artilleryExp_dirt_brown_2");
  level._effect["mortar"]["dirt"] = loadfx("explosions/grenadeExp_dirt");

  level._effect["mortar"]["concrete"] = loadfx("explosions/grenadeExp_concrete_1_low");

  level.scr_sound["mortar"]["incomming"] = "mortar_incoming";
  level.scr_sound["mortar"]["dirt"] = "mortar_explosion_dirt";
  level.scr_sound["mortar"]["dirt_large"] = "mortar_explosion_dirt";
  level.scr_sound["mortar"]["concrete"] = "mortar_explosion_dirt";
  level.scr_sound["mortar"]["mud"] = "mortar_explosion_water";

  level._effect["nuke_flash"] = loadfx("explosions/nuke_flash");

  level.scr_anim["crash_redshirt"]["dcburning_BHrescue"] = % dcburning_BHrescue_soldier_wakeup;

  addNotetrack_customFunction("crash_redshirt", "dialogue", ::notetrack_redshirt_dialogue, "dcburning_BHrescue");
  addNotetrack_customFunction("crash_redshirt", "detachgun", ::notetrack_redshirt_gives_gun, "dcburning_BHrescue");
  addNotetrack_customFunction("crash_redshirt", "headshot", ::notetrack_redshirt_shot_in_head, "dcburning_BHrescue");

  level.scr_anim["crash_leader"]["vehicle_cover"] = % dcburning_BHrescue_soldier1_fighting;
  level.scr_anim["crash_dunn"]["vehicle_cover"] = % dcburning_BHrescue_soldier2_fighting;

  level.scr_anim["crash_leader"]["vehicle_cover_loop"] = % dcburning_BHrescue_soldier1_loop;
  level.scr_anim["crash_dunn"]["vehicle_cover_loop"] = % dcburning_BHrescue_soldier2_loop;

  level.scr_anim["crash_leader"]["dcburning_BHrescue_throwclip"] = % dcburning_BHrescue_soldier1_giveammo;
  addNotetrack_customFunction("crash_leader", "dialogue", ::notetrack_friendly_macey_last_mag_dialogue, "dcburning_BHrescue_throwclip");

  level.scr_anim["crash_dunn"]["dcburning_BHrescue_throwclip"] = % dcburning_BHrescue_soldier2_giveammo;
  addNotetrack_attach("crash_leader", "clipattach", "weapon_m4_clip", "tag_inhand", "dcburning_BHrescue_throwclip");
  addNotetrack_detach("crash_leader", "clipdetach", "weapon_m4_clip", "tag_inhand", "dcburning_BHrescue_throwclip");

  level.scr_anim["crash_leader"]["dcburning_BHrescue_laststand"] = % dcburning_BHrescue_soldier1_wounded;
  level.scr_anim["crash_dunn"]["dcburning_BHrescue_laststand"] = % dcburning_BHrescue_soldier2_wounded;
  addNotetrack_customFunction("crash_dunn", "wounded", ::notetrack_friendly_02_is_wounded, "dcburning_BHrescue_laststand");
}

notetrack_friendly_macey_last_mag_dialogue(guy) {
  flag_set("macey_last_mag_dialogue");
  wait(2.2);
  flag_set("macey_clip_to_player");
}

notetrack_redshirt_dialogue(guy) {
  flag_set("crash_redshirt_speaks");
  wait 1.0;

  level.player playSound("scn_dcemp_player_handed_gun");
}

notetrack_redshirt_gives_gun(guy) {
  flag_set("give_player_weapon");
}

notetrack_redshirt_shot_in_head(guy) {
  flag_set("redshirt_headshot");
  thread play_sound_in_space("weap_deserteagle_fire_npc", guy.origin);
  thread play_sound_in_space("bullet_large_flesh", guy.origin);
  playFXOnTag(getfx("headshot3"), guy, "TAG_EYE");
}

notetrack_friendly_02_is_wounded(guy) {
  flag_set("friendly_02_injured");
  thread play_sound_in_space("weap_deserteagle_fire_npc", guy.origin);
  thread play_sound_in_space("bullet_large_flesh", guy.origin);
  playFXOnTag(getfx("headshot3"), guy, "J_Shoulder_RI");

  wait(1);

  level.teamleader thread dialogue_queue("dcburn_mcy_hangon");

  crash_chatter_org_right = getent("crash_chatter_org_right", "targetname");

  crash_chatter_org_right delaythread(1, ::play_sound_in_space, "dcburn_ar1_loading");

  wait(2);

  level.teamleader thread dialogue_queue("dcburn_mcy_defendthispos");
}

notetrack_player_upright(guy) {
  flag_set("notetrack_player_upright");
}

notetrack_player_raisehands(guy) {
  flag_set("notetrack_player_raisehands");
}

notetrack_player_lowerhands(guy) {
  flag_set("notetrack_player_lowerhands");
}

#using_animtree("player");
crash_player_anims() {
  level.scr_model["player_rig"] = "viewhands_player_us_army_bloody";

  level.scr_anim["player_rig"]["dcburning_BHrescue"] = % dcburning_BHrescue_player_wakeup;
  level.scr_anim["player_rig"]["dcburning_BHrescue_throwclip"] = % dcburning_BHrescue_player_takeammo;
  addNotetrack_customFunction("player_rig", "upright", ::notetrack_player_upright, "dcburning_BHrescue");
  addNotetrack_customFunction("player_rig", "handsup", ::notetrack_player_raisehands, "dcburning_BHrescue");
  addNotetrack_customFunction("player_rig", "handsdown", ::notetrack_player_lowerhands, "dcburning_BHrescue");
}

#using_animtree("vehicles");
crash_bh_anims() {
  level.scr_anim["crash_blackhawk"]["rotors_start"] = % dcburning_BHrescue_BH;
  level.scr_anim["crash_blackhawk"]["rotors"][0] = % dcburning_BHrescue_BH;
  level.scr_animtree["crash_blackhawk"] = #animtree;
}

AI_delete_crashsite(excluders) {
  self endon("death");
  if(!isDefined(self))
    return;
  if((isDefined(excluders)) && (excluders.size > 0)) {
    if(is_in_array(excluders, self))
      return;
  }
  if(isDefined(self.magic_bullet_shield))
    self stop_magic_bullet_shield();
  if(!isSentient(self)) {}

  self delete();
}

vehicle_delete_all_crashsite(excluders) {
  vehicles_to_delete1 = level.vehicles["axis"];
  vehicles_to_delete2 = level.vehicles["allies"];
  vehicles_to_delete = array_merge(vehicles_to_delete1, vehicles_to_delete2);
  foreach(vehicle in vehicles_to_delete) {
    if(!isDefined(vehicle)) {
      continue;
    }
    if((isDefined(excluders)) && (excluders.size > 0)) {
      if(is_in_array(excluders, vehicle))
        continue;
    }

    vehicle maps\_vehicle::godoff();
    vehicle vehicle_delete_crashsite();
  }
}

vehicle_delete_crashsite() {
  if(!isDefined(self))
    return;
  self endon("death");

  if((isDefined(self.riders)) && (self.riders.size))
    array_thread(self.riders, ::AI_delete_crashsite);

  if(isDefined(self.mgturret)) {
    foreach(turret in self.mgturret) {
      if(isDefined(turret))
        turret delete();
    }
  }
  self delete();
}

drone_flood_start_crashsite(aSpawners, groupName) {
  level endon("stop_drone_flood" + groupName);
  while(true) {
    foreach(spawner in aSpawners) {
      spawner.script_noteworthy = "axis_crash_drone";
      add_wait(::_wait, randomfloatrange(5, 6));
      spawner add_abort(::waittill_msg, "death");
      add_func(::dronespawn, spawner);
      thread do_wait();
    }
    wait(randomfloatrange(5, 6));
  }
}

spawn_trigger_dummy_crashsite(sDummyTargetname) {
  ent = getent(sDummyTargetname, "targetname");
  assert(isDefined(ent));
  assert(isDefined(ent.script_linkTo));
  trig = getent(ent.script_linkTo, "script_linkname");
  assert(isDefined(trig));
  trig notify("trigger", level.player);
}

AI_ignored_and_oblivious_crashsite() {
  self endon("death");
  if(!isDefined(self))
    return;
  if((isDefined(self.code_classname)) && (self.code_classname == "script_model"))
    return;
  self setFlashbangImmunity(true);
  self.ignoreme = true;
  self.ignoreall = true;
  self.grenadeawareness = 0;
}