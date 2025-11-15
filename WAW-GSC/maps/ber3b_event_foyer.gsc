/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\ber3b_event_foyer.gsc
*****************************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_anim;
#include maps\ber3b;
#include maps\ber3b_anim;
#include maps\ber3_util;
#include maps\_music;
#using_animtree("generic_human");

event_intro_start() {
  share_screen(get_host(), true, true);
  warp_players_underworld();
  thread battlechatter_off("allies");
  doIntroscreen = GetDvarInt("introscreen");
  if(isDefined(doIntroscreen) && doIntroscreen > 0) {
    diary_reading();
  }
  thread introscene_closedoors_near();
  thread foyer_spawn_redshirts_1();
  level waittill("introscene_closedoors_near_warpdone");
  warp_friendlies("struct_foyer_frontdoor_start_friends", "targetname");
  warp_players("struct_foyer_frontdoor_start", "targetname");
  setup_commissar();
  level notify("hitler_speak");
  thread intro_fakefire();
  event_foyer_introscene();
  thread battlechatter_on("allies");
  level thread event_foyer_setup();
}

event_foyer_start() {
  warp_players_underworld();
  thread introscene_closedoors_near();
  thread foyer_spawn_redshirts_1();
  level waittill("introscene_closedoors_near_warpdone");
  setup_commissar();
  warp_commissar_to_intro_spot();
  warp_friendlies("struct_foyer_frontdoor_start_friends", "targetname");
  warp_players("struct_foyer_frontdoor_start", "targetname");
  thread intro_fakefire();
  thread introscene_closedoors_far();
  level notify("introscene_closedoors_near_startanim");
  level thread event_foyer_setup();
}

event_foyer_pacing_start() {
  warp_players_underworld();
  warp_friendlies("struct_parliament_foyer_pacing_start_friends", "targetname");
  warp_players("struct_parliament_foyer_pacing_start", "targetname");
  set_color_chain("trig_script_color_allies_b5");
  set_objective(1);
  level thread event_foyer_pacing_action();
}

diary_reading() {
  while(!isDefined(level._introscreen)) {
    wait(0.05);
  }
  while(!level._introscreen) {
    wait(0.05);
  }
  wait(2);
  clientNotify("diaryreading_start");
  setmusicstate("DIARY");
  diaryLineTime = 23;
  EndTime = GetTime() + (diaryLineTime * 1000);
  host = get_players()[0];
  fadeTime = 0.5;
  level waittill("finished final intro screen fadein");
  wait(2.5);
  while(GetTime() < endTime) {
    wait(0.5);
  }
  host notify("fade_diary_hud");
  wait(0.5);
  flag_set(level.introscreen_waitontext_flag);
}

event_foyer_introscene() {
  setmusicstate("INTRO");
  thread crouch_players();
  thread align_friendlies();
  flag_init("intro_interrupt");
  thread introscene_playercheck();
  doingIntroscreen = GetDvarInt("introscreen");
  if(isDefined(doingIntroscreen) && doingIntroscreen) {
    flag_wait(level.introscreen_waitontext_flag);
    wait(2);
  }
  thread introscene_artystrikes();
  level notify("introscene_closedoors_near_startanim");
  thread introscene_closedoors_far();
  sarge = level.sarge;
  sarge.animname = "sarge";
  animSpot = spawn("script_origin", sarge.origin);
  animSpot.angles = (0, 0, 0);
  sarge thread anim_finished_notify("intro_sarge_anim_done");
  animSpot thread anim_single_solo_earlyout(sarge, "intro_peptalk");
  level thread delayed_screen_restore(2);
  level waittill_any("intro_interrupt", "intro_sarge_anim_done");
  if(flag("intro_interrupt")) {
    sarge anim_stopanimscripted();
  }
  level notify("intro_finished");
}

delayed_screen_restore(time) {
  wait(time);
  share_screen(get_host(), false, false);
}

anim_finished_notify(notifystring) {
  level endon("intro_interrupt");
  animtime = GetAnimLength(level.scr_anim["sarge"]["intro_peptalk"]);
  wait(animtime - 2);
  level notify(notifystring);
}

introscene_artystrikes() {
  level endon("intro_finished");
  level endon("intro_interrupt");
  minWait = 5;
  maxWait = 10;
  firstTime = true;
  while(1) {
    if(firstTime) {
      firstTime = false;
    } else {
      wait(RandomFloatRange(minWait, maxWait));
    }
    level notify("arty_strike");
    thread arty_strike_on_players(RandomFloatRange(.2, .3), 3, 500);
  }
}

setup_frontdoors() {
  door1 = getent_safe("sbmodel_frontdoor_set1_right", "targetname");
  door2 = getent_safe("sbmodel_frontdoor_set1_left", "targetname");
  door1 ConnectPaths();
  door2 ConnectPaths();
}

introscene_closedoors_far() {
  door1 = getent_safe("sbmodel_frontdoor_set1_right", "targetname");
  door2 = getent_safe("sbmodel_frontdoor_set1_left", "targetname");
  animSpot = getstruct_safe("struct_intro_doors_animref_1", "targetname");
  spawner1 = getent_safe(animSpot.target, "targetname");
  spawner2 = getent_safe(spawner1.target, "targetname");
  guy1 = spawn_guy(spawner1);
  guy2 = spawn_guy(spawner2);
  guys[0] = guy1;
  guys[1] = guy2;
  for(i = 0; i < guys.size; i++) {
    guy = guys[i];
    guy.ignoreme = true;
    guy.ignoreall = true;
    guy PushPlayer(true);
  }
  guy1.animname = "intro_door_closer_1";
  guy2.animname = "intro_door_closer_2";
  animSpot anim_reach(guys, "closedoor");
  door1 thread reichstag_dooranim("reichstag_frontdoor_1", "closedoor", "frontdoor_anim");
  door2 thread reichstag_dooranim("reichstag_frontdoor_2", "closedoor", "frontdoor_anim");
  animSpot anim_single(guys, "closedoor");
  for(i = 0; i < guys.size; i++) {
    guy = guys[i];
    guy.ignoreme = false;
    guy.ignoreall = false;
    guy PushPlayer(false);
    node = getnode_safe(guy.target, "targetname");
    guy SetGoalNode(node);
    guy thread bloody_death_after_wait(10, true, 5);
  }
}

introscene_closedoors_near() {
  door3 = getent_safe("sbmodel_frontdoor_set2_right", "targetname");
  door4 = getent_safe("sbmodel_frontdoor_set2_left", "targetname");
  animSpot = getstruct_safe("struct_intro_doors_animref_2", "targetname");
  spawner3 = getent_safe(animSpot.target, "targetname");
  spawner4 = getent_safe(spawner3.target, "targetname");
  guy3 = spawn_guy(spawner3);
  guy4 = spawn_guy(spawner4);
  guys[0] = guy3;
  guys[1] = guy4;
  for(i = 0; i < guys.size; i++) {
    guy = guys[i];
    guy.ignoreme = true;
    guy.ignoreall = true;
    guy PushPlayer(true);
  }
  guy3.animname = "intro_door_closer_3";
  guy4.animname = "intro_door_closer_4";
  guy3 maps\_anim::set_start_pos("closedoor", animSpot.origin, animSpot.angles, undefined);
  guy4 maps\_anim::set_start_pos("closedoor", animSpot.origin, animSpot.angles, undefined);
  level notify("introscene_closedoors_near_warpdone");
  level waittill("introscene_closedoors_near_startanim");
  door3 thread reichstag_dooranim("reichstag_frontdoor_3", "closedoor", "frontdoor_anim");
  door4 thread reichstag_dooranim("reichstag_frontdoor_4", "closedoor", "frontdoor_anim");
  animSpot anim_single(guys, "closedoor");
  for(i = 0; i < guys.size; i++) {
    guy = guys[i];
    guy.ignoreme = false;
    guy.ignoreall = false;
    guy PushPlayer(false);
    node = getnode_safe(guy.target, "targetname");
    guy SetGoalNode(node);
    guy thread bloody_death_after_wait(10, true, 5);
  }
}

introscene_playercheck() {
  level endon("intro_finished");
  trig = getent_safe("trig_script_color_allies_b1", "targetname");
  while(isDefined(trig)) {
    trig waittill("trigger", guy);
    if(IsPlayer(guy)) {
      break;
    }
  }
  flag_set("intro_interrupt");
}

crouch_players() {
  flag_wait("warp_players_done");
  players = get_players();
  for(i = 0; i < players.size; i++) {
    player = players[i];
    player SetStance("crouch");
  }
}

align_friendlies() {
  warp_players_underworld();
  warp_commissar_to_intro_spot();
  sargeSpot = getstruct_safe("struct_intro_sarge_spot", "targetname");
  level.sarge Teleport(groundpos(sargeSpot.origin), sargeSpot.angles);
  warp_players("struct_foyer_frontdoor_start", "targetname");
  for(i = 0; i < level.friends.size; i++) {
    guy = level.friends[i];
    if(is_active_ai(guy) && guy != level.sarge) {
      guy AllowedStances("crouch");
    }
  }
  level waittill_any("intro_finished", "intro_interrupt");
  reset_friendlies();
}

reset_friendlies() {
  for(i = 0; i < level.friends.size; i++) {
    guy = level.friends[i];
    if(is_active_ai(guy)) {
      guy AllowedStances("stand", "crouch", "prone");
    }
  }
}

setup_commissar() {
  commissar_spawner = getent_safe("commissar", "targetname");
  commissar = spawn_guy(commissar_spawner);
  commissar.ignoreme = true;
  commissar thread magic_bullet_shield_safe();
  level.commissar = commissar;
  ASSERTEX(is_active_ai(level.commissar), "setup_commissar(): couldn't assign level.commissar.");
  thread commissar_action();
}

commissar_action() {
  while(!isDefined(level.commissar.wasWarped)) {
    wait(0.05);
  }
  level.commissar animscripts\shared::placeWeaponOn(level.commissar.primaryweapon, "none");
  level.commissar Attach("clutter_berlin_megaphone", "tag_weapon_left");
  level.commissar.animname = "commissar";
  level.commissar thread anim_loop_solo(level.commissar, "intro_idle", undefined, "idle_stop");
  level waittill_any("intro_finished", "intro_interrupt");
  level.commissar notify("idle_stop");
  level.commissar anim_single_solo(level.commissar, "intro");
  flag_set("commissar_dialogue_done");
  level.commissar thread anim_loop_solo(level.commissar, "intro_idle", undefined, "idle_stop");
  wait(10);
  level.commissar wait_while_players_can_see(400, 5);
  level.commissar notify("idle_stop");
  level.commissar thread stop_magic_bullet_shield_safe();
  level.commissar Delete();
}

warp_commissar_to_intro_spot() {
  comSpot = getstruct_safe("struct_intro_commissar_spot", "targetname");
  level.commissar Teleport(groundpos(comSpot.origin), comSpot.angles);
  level.commissar.wasWarped = true;
}

event_foyer_setup() {
  set_objective(1);
  thread event_foyer_action();
  thread foyer_mg();
  thread foyer_bazookateam();
  thread kill_aigroup_at_trigger("trig_pacing1_kicked_door", "targetname", "ai_foyer_redshirts_1");
}

event_foyer_action() {
  set_color_chain("trig_script_color_allies_b0");
  thread foyer_intro_hallway_running_dialogue();
  thread event_foyer_pacing_action();
  thread foyer_force_ai_fire();
}

foyer_force_ai_fire() {
  trigger = getent("foyer_colors_stair_base", "targetname");
  trigger waittill("trigger");
  autosave_by_name("Ber1 reached stair");
  enemies = GetAIArray("axis");
  for(i = 0; i < enemies.size; i++) {
    enemies[i].ignoreme = false;
    if(enemies[i].origin[2] < 15216) {
      enemies[i].health = 1;
    }
  }
}

debug_print_ber3b() {
  while(1) {
    print3d(self.origin + (0, 0, 40), "***", (1, 1, 1), 1, 3);
    wait(0.01);
  }
}

foyer_intro_hallway_running_dialogue() {
  flag_wait("commissar_dialogue_done");
  level notify("arty_strike");
  thread arty_strike_on_players(RandomFloatRange(.3, .4), 3, 500);
  buddy = get_randomfriend_notsarge();
  buddy playsound_generic_facial("Ber3B_IGD_000A_RUR2");
  level.sarge playsound_generic_facial("Ber3B_IGD_001A_REZN");
  flag_set("hallway_running_dialogue_done");
}

event_foyer_pacing_action() {
  thread pacing1_melees_init();
  thread pacing1_friendly_doorbreach();
  thread pacing1_fallbackers_kill();
  trigger_wait("trig_parliament_entrance", "targetname");
  maps\ber3b_event_parliament::event_parliament_setup();
}

pacing1_fallbackers_kill() {
  trigger_wait("trig_pacing1_melee1", "targetname");
  enemies = get_ai_group_ai("ai_pacing1_fallbackers");
  array_thread(enemies, ::pacing1_fallbacker_kill);
}

pacing1_fallbacker_kill() {
  self endon("death");
  self wait_while_players_can_see(450, 5);
  self thread bloody_death(true, 0);
}

intro_fakefire() {
  if(level.clientscripts) {
    maps\_utility::setClientSysState("levelNotify", "intro_fakefire_start");
  } else {
    firePoints = GetStructArray("struct_intro_fakefire", "targetname");
    ASSERTEX(isDefined(firePoints) && firePoints.size > 0, "Can't find fakefire points.");
    array_thread(firePoints, maps\ber3b_fx::ambient_fakefire, "intro_fakefire_end", false);
  }
}

foyer_mg() {
  trig = getent_safe("trig_foyer_mgspawn", "targetname");
  trig waittill("trigger");
  spawner = getent_safe(trig.target, "targetname");
  node = getnode_safe(spawner.target, "targetname");
  mg = getent_safe(node.target, "targetname");
  mger = spawn_guy(spawner);
  mger.ignoreme = true;
  mger thread magic_bullet_shield();
  mger SetGoalNode(node);
  mger thread guy_stay_on_turret(mger, mg);
  level waittill("bazookateam_fire");
  mger notify("stop magic bullet shield");
  level waittill("bazookateam_foyer_damage_done");
  wait(0.1);
  if(isDefined(mger) && is_active_ai(mger)) {
    mger DoDamage(mger.health + 5, (0, 0, 0));
  }
  wait(0.1);
  if(isDefined(mg)) {
    mg Delete();
  }
}

foyer_bazookateam() {
  trig = getent_safe("trig_foyer_bazookateam", "targetname");
  trig waittill("trigger");
  thread maps\ber3b_event_parliament::bazooka_team(trig);
  thread foyer_bazookateam_dialogue();
  dmgtrig = getent_safe("trig_damage_foyer_bazookateam_firearea", "targetname");
  dmgtrig waittill("trigger");
  dmgtrig Delete();
  fxspot = getstruct_safe("struct_foyer_bazookatarget_fxspot", "targetname");
  intactGeo = getEntArray("scripted_foyer_center_emplacement", "targetname");
  ASSERTEX(isDefined(intactGeo) && intactGeo.size > 0, "can't find foyer bazookateam intact geo");
  playFX(level._effect["sandbag_explosion_small"], fxspot.origin);
  RadiusDamage(fxspot.origin, 238, 5000, 5000);
  wait(0.2);
  for(i = 0; i < intactGeo.size; i++) {
    intactGeo[i] Delete();
  }
  level notify("bazookateam_foyer_damage_done");
  flag_clear("bazookateam_keep_firing");
  weaponclip = getent_safe("trig_foyer_bazooka_weaponclip", "targetname");
  weaponclip Delete();
}

foyer_bazookateam_dialogue() {
  sarge_giveorder("positions_fortified_need_support", true);
  sarge_giveorder("want_bazooka_team", true);
}

pacing1_melees_init() {
  level thread pacing1_2man_melee("trig_pacing1_melee1", "melee1");
  level thread pacing1_2man_melee("trig_pacing1_melee2", "melee2");
}

pacing1_2man_melee(triggerTN, anime) {
  beater_animname = "rtag_melee_beater";
  victim_animname = "rtag_melee_victim";
  trig = getent_safe(triggerTN, "targetname");
  trig waittill("trigger");
  animSpot = getstruct_safe(trig.target, "targetname");
  spawner_beater = getent_safe(animSpot.target, "targetname");
  spawner_victim = getent_safe(spawner_beater.target, "targetname");
  beater_goalnode = getnode_safe(spawner_beater.target, "targetname");
  trig Delete();
  beater = spawn_guy(spawner_beater);
  victim = spawn_guy(spawner_victim);
  beater thread magic_bullet_shield_safe();
  victim.nodeathragdoll = true;
  beater.animname = beater_animname;
  victim.animname = victim_animname;
  victim.deathanim = level.scr_anim[victim_animname][anime];
  victim maps\_anim::set_start_pos(anime, animSpot.origin, animSpot.angles, undefined);
  victim DoDamage(victim.health + 5, (0, 0, 0));
  animSpot anim_single_solo(beater, anime);
  beater.goalradius = 24;
  beater SetGoalNode(beater_goalnode);
  beater waittill("goal");
  beater thread stop_magic_bullet_shield_safe();
  beater thread bloody_death(true, 0);
}

pacing1_friendly_doorbreach() {
  startDistance = 710;
  trig = getent_safe("trig_pacing1_kicked_door", "targetname");
  trig waittill("trigger");
  spawners = getEntArray(trig.target, "targetname");
  enemies = getEntArray("spawner_pacing1_doorkick_enemy", "targetname");
  animSpot = getstruct_safe("struct_pacing1_kicked_door_animref", "targetname");
  door = getent_safe("sbmodel_pacing1_kicked_door", "targetname");
  trig Delete();
  enemies thread pacing1_friendly_doorbreach_enemies();
  guys = [];
  for(i = 0; i < spawners.size; i++) {
    guy = spawn_guy(spawners[i]);
    guy.ignoreme = true;
    guy.ignoreall = true;
    guy PushPlayer(true);
    guys[i] = guy;
  }
  guys[0].animname = "pacing1_doorkick_guy1";
  guys[1].animname = "pacing1_doorkick_guy2";
  idle_anime = "idle";
  kick_anime = "doorkick";
  animSpot anim_reach(guys, kick_anime);
  animSpot thread anim_loop(guys, idle_anime, undefined, "end_loop");
  waittill_player_within_range(animSpot.origin, startDistance, 0.05);
  animSpot notify("end_loop");
  door thread reichstag_dooranim("pacing1_doorbreach_door", "doorkick", "pacing1_doorkick");
  animSpot thread anim_single_earlyout(guys, kick_anime);
  goalPos1 = (1000, 17736, 928);
  goalPos2 = (968, 17616, 928);
  guys[0] thread doorbreach_guy_finish(goalPos1, kick_anime);
  guys[1] thread doorbreach_guy_finish(goalPos2, kick_anime);
}

doorbreach_guy_finish(goalPos, anime) {
  self endon("death");
  animtime = GetAnimLength(level.scr_anim[self.animname][anime]);
  wait(animtime - 2);
  self.ignoreme = false;
  self.ignoreall = false;
  self PushPlayer(false);
  self.goalradius = 200;
  self SetGoalPos(goalPos);
  self waittill("goal");
  self thread bloody_death_after_wait(10, true, 5);
}

pacing1_friendly_doorbreach_enemies() {
  guys = [];
  for(i = 0; i < self.size; i++) {
    guy = spawn_guy(self[i]);
    guy.ignoreme = true;
    guy.ignoreall = true;
    guy PushPlayer(true);
    guy SetGoalPos(guy.origin);
    guys[i] = guy;
  }
  level waittill("friendly_doorbreach_dooropen");
  guys[0].animname = "pacing1_doorkick_victim1";
  guys[1].animname = "pacing1_doorkick_victim2";
  anime = "surrender";
  guys[0] thread anim_single_solo(guys[0], anime);
  guys[1] thread anim_single_solo(guys[1], anime);
  wait(1.5);
  for(i = 0; i < guys.size; i++) {
    guys[i] anim_stopanimscripted();
    guys[i] thread bloody_death(true, 1);
  }
}

pacing1_friendly_doorbreach_dooropen(guy) {
  level notify("friendly_doorbreach_dooropen");
}

foyer_spawn_redshirts_1() {
  getent_safe("trig_spawn_foyer_redshirts_1", "targetname") notify("trigger");
  wait(0.1);
  closeGuys = get_ai_group_ai("ai_foyer_redshirts_1_nearplayer");
  array_thread(closeGuys, ::intro_close_redshirt_think);
}

intro_close_redshirt_think() {
  self endon("death");
  playerdist = 260;
  self SetGoalPos(self.origin);
  self AllowedStances("crouch");
  waittill_player_within_range(self.origin, playerdist);
  self AllowedStances("stand", "crouch", "prone");
  self SetGoalNode(getnode_safe(self.target, "targetname"));
  self waittill("goal");
  self bloody_death(true, 10);
}

foyer_flagbearer_buddies_spawnfunc() {
  self SetGoalPos(self.origin);
  self.ignoreme = true;
  self thread magic_bullet_shield();
  wait(RandomFloatRange(0.4, 0.7));
  self notify("stop magic bullet shield");
  self.deathanim = % exposed_death_twist;
  if(self.origin[0] > 1100) {
    self.deathanim = % exposed_death_headtwist;
  }
  self DoDamage(self.health + 5, (0, 0, 0));
  shotOrigin = (1178, 15578, 776);
  bursts = RandomIntRange(3, 5);
  for(i = 0; i < bursts; i++) {
    self maps\ber3b_event_roof::ai_tracer_burst(shotOrigin);
    wait(RandomFloatRange(0.1, 0.2));
  }
}

foyer_pacing_friendly_hallrunners_spawnfunc() {
  self waittill("goal");
  self bloody_death(true, 2);
}