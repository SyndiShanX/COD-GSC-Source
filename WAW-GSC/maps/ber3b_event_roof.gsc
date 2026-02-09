/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\ber3b_event_roof.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_anim;
#include maps\ber3b;
#include maps\ber3b_anim;
#include maps\ber3_util;
#include maps\_music;
#using_animtree("generic_human");
event_roof_start() {
  setDvar("introscreen", "0");

  objectives_skip(2);

  warp_players_underworld();
  warp_friendlies("struct_roof_start_friends", "targetname");
  warp_players("struct_roof_start", "targetname");
  set_color_chain("trig_script_color_allies_b23");

  level thread event_roof_setup();
}

event_roof_midpoint_start() {
  setDvar("introscreen", "0");

  objectives_skip(2);

  getent_safe("spawntrig_auto980", "script_noteworthy") Delete();

  warp_players_underworld();
  warp_friendlies("struct_roof_midpoint_start_friends", "targetname");
  warp_players("struct_roof_midpoint_start", "targetname");

  level thread event_roof_setup(true);
}

startpoint_triggers_delete() {
  trigs = getEntArray("trigger_multiple", "classname");
  trigs = array_combine(trigs, getEntArray("trigger_radius", "classname"));

  for(i = 0; i < trigs.size; i++) {
    if(isDefined(trigs[i].script_color_allies)) {
      trigs[i] Delete();
    }
  }
}
event_roof_flagplant_start() {
  setDvar("introscreen", "0");

  objectives_skip(2);

  warp_players_underworld();
  warp_friendlies("struct_roof_flagplant_start_friends", "targetname");
  warp_players("struct_roof_flagplant_start", "targetname");

  russian_flag_teleport(groundpos((1136, 12564, 1636)));

  level thread event_roof_setup(true);
}

event_roof_setup(skipTo) {
  if(!isDefined(skipTo)) {
    skipTo = false;
  }

  set_objective(4);

  thread dome_pacing_dialogue();
  thread dome_friendly_combat_dialogue();

  thread roof_statue_fall();
  thread roof_planes_fire_guns_watcher();

  thread cleanup_forcecolor_redshirts("c", "trig_roof_entrance", "targetname", 5);

  thread roof_outside_dialogue();

  thread event_roof_action();
}

roof_stop_laststand() {
  level.no_laststandmissionfail = false;
  level.playerlaststand_func = ::roof_no_death_last_stand;

  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i] EnableInvulnerability();
    if(players[i] maps\_laststand::player_is_in_laststand()) {
      players[i] roof_no_death_last_stand();
    }
  }
}

roof_no_death_last_stand() {
  self thread roof_no_death_last_stand_internal();
}

roof_no_death_last_stand_internal() {
  self setCanDamage(false);
  self.bleedout_time = 999999;
}

dome_pacing_dialogue() {
  trigger_wait("trig_dome_pacing_start", "targetname");

  guy1 = get_randomfriend_notsarge();
  guy2 = get_randomfriend_notsarge_excluding(guy1);

  guy1 say_dialogue("roof_pacing_redshirt1", "must_be_nearing_roof", true);
  guy2 say_dialogue("roof_pacing_redshirt2", "throw_germans_over_edge", true);
  guy1 say_dialogue("roof_pacing_redshirt1", "comrades_flooding_in", true);
  sarge_giveorder("let_them_have_our_scraps", true);
}

dome_friendly_combat_dialogue() {
  level waittill("roof_statue_dialogue_done");

  while(!flag("statue_fall_done")) {
    wait(0.5);
  }

  sarge_giveorder("up_there", true);
  sarge_giveorder("on_the_balconies", true);
}

dome_mg_adjust() {
  mg = getent("auto935", "targetname");
  mg.yawconvergencetime = 3.25;
  mg.convergencetime = 3.25;
  mg.suppressionTime = 1.5;
}

roof_statue_fall() {
  level.pauseArtyStrikes = true;

  trigger_wait("trig_roof_statue_fall", "targetname");

  dome_mg_adjust();

  statue = getent_safe("smodel_dome_statue", "targetname");

  pieces["beam_jnt"] = getent_safe("sbmodel_dome_beam", "targetname");
  pieces["chunk1_jnt"] = getent_safe("sbmodel_dome_chunk02", "targetname");
  pieces["chunk2_jnt"] = getent_safe("sbmodel_dome_chunk01", "targetname");
  pieces["chunk3_jnt"] = getent_safe("sbmodel_dome_chunk05", "targetname");
  pieces["chunk4_jnt"] = getent_safe("sbmodel_dome_chunk03", "targetname");
  pieces["chunk5_jnt"] = getent_safe("sbmodel_dome_chunk04", "targetname");
  pieces["chunk6_jnt"] = getent_safe("sbmodel_dome_chunk07", "targetname");
  pieces["chunk7_jnt"] = getent_safe("sbmodel_dome_chunk06", "targetname");

  keys = GetArrayKeys(pieces);

  for(i = 0; i < pieces.size; i++) {
    pieces[keys[i]] LinkTo(statue, keys[i]);
  }

  thread roof_statue_dialogue();

  thread roof_statue_hitground();

  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i].ignoreme = true;
  }

  thread arty_strike_on_players(.39, 1.7, 500, false);
  level notify("arty_strike");
  level notify("audio_roof_fall");

  fxSpot = getstruct_safe("struct_roof_statuefall_fxspot", "targetname");
  playFX(level._effect["statue_fall"], fxSpot.origin);

  statue roof_statue_anim("roof_statue", "fall", "statue_fall_anim");

  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i].ignoreme = false;
  }

  flag_set("statue_fall_done");
}

roof_statue_dialogue() {
  sarge_giveorder("look_my_brothers", true);

  level notify("roof_statue_dialogue_done");
}

roof_statue_hitground() {
  wait(3.1);

  thread arty_strike_on_players(.42, 2.8, 500, true);
  level notify("audio_roof_ground");

  fxSpot = getstruct_safe("struct_foyer_domeFalloutFX", "targetname");
  playFX(level._effect["statue_fallout_cloud"], fxSpot.origin);
}

roof_outside_dialogue() {
  trigger_wait("trig_roof_outside_entrance", "targetname");

  sarge_giveorder("they_have_nowhere_to_go", true);
  sarge_giveorder("clear_path_for_flag", true);
  wait(3);
  sarge_giveorder("claim_our_victory");
}

event_roof_action() {
  level thread event_roof_ai_flagbearer();
  level thread roof_katyushas();

  level thread roof_coop_linkto_flagbearer();
  level thread roof_mantle_think();
  level waittill("flagbearer_mantled");

  thread roof_stop_laststand();

  level.lastFlagBearer AllowMelee(false);
  level.lastFlagBearer.ignoreme = true;

  level.lastFlagBearer SetClientDvar("compass", "0");
  level.lastFlagBearer SetClientDvar("miniscoreboardhide", "1");

  animSpot = getstruct_safe("struct_roof_flagbearer_shot_animref", "targetname");

  level thread roof_outro_aianims(animSpot);

  level.lastFlagBearer thread roof_flagbearer_shot(animSpot);

  level waittill("flagbearer_shot_done");

  level.lastFlagBearer thread injured_walk();

  flagraise_trigger_wait();

  level notify("kill_flagcarry");
  level notify("player_raising_flag");

  arcademode_assignpoints("arcademode_score_generic500", level.lastFlagBearer);

  level.lastFlagBearer thread roof_flagbearer_plant(animSpot);

  wait(20);

  level thread nextmission();

  wait(0.5);

  share_screen(level.lastFlagBearer, false, false);
}

fade_to_black_then_back(fadeTime, black_time, resume_time) {
  if(!isDefined(fadeTime)) {
    fadeTime = 5;
  }

  fadetoblack = NewHudElem();
  fadetoblack.x = 0;
  fadetoblack.y = 0;
  fadetoblack.alpha = 0;

  fadetoblack.horzAlign = "fullscreen";
  fadetoblack.vertAlign = "fullscreen";
  fadetoblack.foreground = false;
  fadetoblack.sort = 50;
  fadetoblack SetShader("black", 640, 480);

  fadetoblack FadeOverTime(fadeTime);
  fadetoblack.alpha = 1;

  wait(fadeTime + black_time);

  fadetoblack FadeOverTime(resume_time);
  fadetoblack.alpha = 0;
}

flagraise_trigger_wait() {
  flagbearer = level.lastFlagBearer;

  flagbearer.outro_hud = NewClientHudElem(flagbearer);
  flagbearer.outro_hud.alignX = "left";
  flagbearer.outro_hud.fontScale = 1.5;
  flagbearer.outro_hud.x = 210;
  flagbearer.outro_hud.y = 200;
  flagbearer.outro_hud SetText(level.flag_plant_trigger_string);
  flagbearer.outro_hud.alpha = 0;

  fadeTime = 0.1;

  usetrig = getent_safe("trig_finale_raiseFlag", "targetname");

  triggerUsed = false;
  while(!triggerUsed) {
    if(flagbearer IsTouching(usetrig)) {
      flagbearer.outro_hud FadeOverTime(fadeTime);
      flagbearer.outro_hud.alpha = 1;

      while(flagbearer IsTouching(usetrig)) {
        if(flagbearer UseButtonPressed()) {
          triggerUsed = true;
          break;
        } else {
          wait(0.05);
        }
      }

      if(triggerUsed) {
        break;
      }
    } else {
      if(flagbearer.outro_hud.alpha != 0) {
        flagbearer.outro_hud FadeOverTime(fadeTime);
        flagbearer.outro_hud.alpha = 0;
      }
    }

    wait(0.05);
  }

  usetrig Delete();

  flagbearer thread flagbearer_outro_hud_cleanup(fadeTime);
}

flagbearer_outro_hud_cleanup(fadeTime) {
  self.outro_hud FadeOverTime(fadeTime);
  self.outro_hud.alpha = 0;

  wait(fadeTime);
  self.outro_hud Destroy();
}

roof_coop_linkto_flagbearer() {
  level waittill("coop_linkto_flagbearer_start");

  if(!is_coop()) {
    return;
  }

  players = get_players();
  players = array_remove(players, level.lastFlagBearer);

  fadeTime = 0.05;
  array_thread(players, ::player_linkto_flagbearer, fadeTime);

  wait(fadeTime);

  level.lastFlagBearer Hide();

  share_screen(level.lastFlagBearer, true, true);
}

player_linkto_flagbearer(fadeTime) {
  self endon("death");
  self endon("disconnect");

  if(self maps\_laststand::player_is_in_laststand()) {
    self reviveplayer();
  }

  self thread warp_player_start(fadeTime);
  wait(fadeTime);

  self Hide();

  linker = spawn("script_origin", level.lastFlagBearer.origin);
  linker.angles = level.lastFlagBearer.angles;
  linker LinkTo(level.lastFlagBearer);
  self PlayerLinkTo(linker, undefined, 1, 20, 20, 10, 10);

  wait(1);

  self thread warp_player_end();
  self DisableWeapons();
  self AllowCrouch(false);
  self AllowProne(false);
  self AllowJump(false);
  self AllowADS(false);
  self AllowMelee(false);
  self SetClientDvar("compass", "0");
  self SetClientDvar("miniscoreboardhide", "1");
}
roof_katyushas() {
  chainTrig1 = GetEnt("trig_script_color_allies_32", "targetname");
  chainTrig2 = GetEnt("trig_script_color_allies_33", "targetname");

  if(isDefined(chainTrig1)) {
    chainTrig1 trigger_off();
  }

  if(isDefined(chainTrig2)) {
    chainTrig2 trigger_off();
  }

  trigger_wait("trig_roof_katyushas_start", "targetname");

  setmusicstate("ROCKETS_GALORE");

  level thread roof_crawlers();

  starts = GetStructArray("struct_roof_katyusha_start", "targetname");
  ASSERTEX(array_validate(starts), "Can't find any roof katyusha starts.");

  numVolleys = 3;

  for(i = 0; i < numVolleys; i++) {
    array_thread(starts, ::roof_katyusha_fire);
    wait(RandomFloatRange(5, 6));

    if(i == 0) {
      level thread kill_roof_ais();
    }
  }

  flag_set("roof_rockets_done");
  level notify("rockets_done");

  wait(2);

  if(isDefined(chainTrig1)) {
    chainTrig1 trigger_on();

    chainTrig1 notify("trigger");
  }

  if(isDefined(chainTrig2)) {
    chainTrig2 trigger_on();
  }
}

roof_katyusha_fire() {
  min_x = 352;
  max_x = 1984;
  min_y = 12750;
  max_y = 13590;
  z = 1632;

  target_pos = (RandomIntRange(min_x, max_x), RandomIntRange(min_y, max_y), z + 1000);
  target_pos = groundpos(target_pos);

  velocity_strength = 2400;

  offset = RandomIntRange(-1000, -500);
  if(RandomInt(100) < 50) {
    offset = RandomIntRange(500, 1000);
  }

  start_pos = (self.origin[0] + offset, self.origin[1], self.origin[2]);
  startAngles = self.angles;

  wait(RandomFloat(0.8));

  waittill_okTospawn();

  rocket = spawn("script_model", start_pos);
  rocket setModel("katyusha_rocket");
  rocket.angles = startAngles;
  rocket playLoopSound("katy_rocket_run_sign");

  playFXOnTag(level._effect["katyusha_rocket_trail_exaggerated"], rocket, "tag_origin");

  start_pos = rocket.origin;

  gravity = GetDvarInt("g_gravity") * -1;

  dist = Distance(start_pos, target_pos);

  time = dist / velocity_strength;

  delta = target_pos - start_pos;

  drop = 0.5 * gravity * (time * time);

  velocity = ((delta[0] / time), (delta[1] / time), (delta[2] - drop) / time);

  rocket MoveGravity(velocity, time);
  wait(time * 0.5);

  target_angles = VectorToAngles((target_pos + (0, 0, -1000)) - rocket.origin);
  rocket RotateTo(target_angles, time * 0.5);

  wait(time * 0.5);

  playFX(level._effect["katyusha_rocket_explosion"], rocket.origin);
  RadiusDamage(rocket.origin, 196, 25, 45);

  ais = GetAIArray("axis");
  for(i = 0; i < ais.size; i++) {
    if(distance(ais[i].origin, target_pos) < 400) {
      ais[i] dodamage(ais[i].health + 100, target_pos);
    }
  }

  array_thread(get_players(), ::generic_rumble_explosion);
  array_thread4(get_players(), ::scr_earthquake, 0.45, 0.4, rocket.origin, 3000);

  rocket Delete();
}

rocket_wave_rocket(expOrg) {
  rocket = spawn("script_model", expOrg + (0, 0, 6000));
  rocket setModel("katyusha_rocket");
  rocket.angles = (90, 0, 0);

  rocket playLoopSound("katy_rocket_run");
  playFXOnTag(level._effect["katyusha_rocket_trail"], rocket, "tag_origin");
  thread play_sound_in_space("katyusha_launch", rocket.origin);

  rocket MoveTo(expOrg, RandomFloatRange(1, 2));
  rocket waittill("movedone");
  rocket Delete();

  playFX(level._effect["katyusha_rocket_explosion"], expOrg);
  RadiusDamage(expOrg, 196, 25, 45);
  array_thread(get_players(), ::generic_rumble_explosion);
  array_thread4(get_players(), ::scr_earthquake, 0.45, 0.4, expOrg, 3000);
}

kill_roof_ais() {
  killtrig = GetEnt("trig_killspawner_1001", "script_noteworthy");
  if(isDefined(killtrig)) {
    killtrig notify("trigger");
  }

  wait(0.05);

  ais = GetAIArray("axis");
  while(ais.size > 0) {
    if(flag("roof_rockets_done")) {
      for(i = 0; i < ais.size; i++) {
        ais[0] thread bloody_death(true, 1);
      }
      return;
    }

    ais[0] thread bloody_death(true, 1);

    wait(1 + randomfloat(2));
    ais = GetAIArray("axis");
  }
}

roof_crawlers() {
  struct1 = getstruct_safe("struct_roof_crawler_spawnpoint_1", "targetname");
  struct2 = getstruct_safe("struct_roof_crawler_spawnpoint_2", "targetname");
  struct3 = getstruct_safe("struct_roof_crawler_spawnpoint_3", "targetname");

  guy1 = spawn_fake_guy(groundpos(struct1.origin), struct1.angles, "crawl1", "crawl", 0);
  guy2 = spawn_fake_guy(groundpos(struct2.origin), struct2.angles, "crawl2", "crawl", 0);
  guy3 = spawn_fake_guy(groundpos(struct3.origin), struct3.angles, "crawl3", "crawl", 0);

  guy1 thread crawl_think();
  guy2 thread crawl_think();
  guy3 thread crawl_think();

  guy1.a.gib_ref = "left_leg";
  guy2.a.gib_ref = "no_legs";
  guy3.a.gib_ref = "right_leg";

  guy1 thread animscripts\death::do_gib();
  guy2 thread animscripts\death::do_gib();
  guy3 thread animscripts\death::do_gib();
}

spawn_fake_guy(startpoint, startangles, animname, name, assign_weapon) {
  guy = spawn("script_model", startpoint);
  guy.angles = startangles;

  guy setup_axis_char_model();

  guy UseAnimTree(#animtree);
  guy.a = spawnStruct();
  guy.animname = animname;

  if(!isDefined(name)) {
    guy.targetname = "drone";
  } else {
    guy.targetname = name;
  }

  if(isDefined(assign_weapon) && assign_weapon == 1) {
    guy maps\_drones::drone_assign_weapon("axis");
  }

  return guy;
}
crawl_think() {
  self makeFakeAI();
  self setCanDamage(false);
  self.team = "axis";

  self endon("shot_death");

  self thread anim_loop_solo(self, "crawl_idle", undefined, "stop_idling");
  self thread crawl_death_watcher();

  level waittill("rockets_done");

  wait randomfloatrange(0.1, 2.0);

  self notify("stop_idling");

  self setCanDamage(true);
  self.health = 1;

  self anim_single_solo(self, "crawl_crawl");
  self anim_single_solo(self, "crawl_die");

  self notify("stop_shot_death");
  self startragdoll();
  wait 45;

  if(isDefined(self)) {
    self delete();
  }
}

crawl_death_watcher() {
  self endon("stop_shot_death");

  self waittill("damage");
  self notify("shot_death");

  self anim_single_solo(self, "crawl_shot");
  self startragdoll();
}

event_roof_ai_flagbearer() {
  flag_init("flagbearer_deathrun_start");

  spawner = getent_safe("spawner_roof_flagbearer", "targetname");
  waitNode = getnode_safe(spawner.target, "targetname");
  animSpot = getstruct_safe("struct_roof_flagbearer_death_animRef", "targetname");

  trigger_wait("trig_script_color_allies_25", "targetname");

  guy = spawn_guy(spawner);

  spawner Delete();

  guy.ignoreall = true;
  guy.ignoreme = true;
  guy.grenadeammo = 0;
  guy.dropweapon = 0;
  guy thread magic_bullet_shield_safe();
  guy.moveplaybackrate = 1.25;

  guy.animname = "flagbearer_death_prefoyer";
  animRef = "death";
  runAnim = "run_with_flag";
  crouchAnim = "crouch_with_flag";
  guy set_run_anim(runAnim);

  level.russianFlag Show();
  level.russianFlag.origin = guy GetTagOrigin("tag_weapon_right");
  level.russianFlag.angles = guy GetTagAngles("tag_weapon_right");
  level.russianFlag LinkTo(guy, "tag_weapon_right");

  guy thread flagbearer_waitNode_anim(crouchAnim);
  guy SetGoalNode(waitNode);

  trigger_wait("trig_roof_flagbearer_start_deathrun", "targetname");

  flag_set("flagbearer_deathrun_start");

  level thread sarge_giveorder("keep_them_off_flagbearer");

  animSpot anim_reach_solo(guy, animRef);

  guy.nodeathragdoll = true;
  guy disable_long_death();
  guy.allowdeath = false;
  guy.a.pose = "prone";
  guy.a.nodeath = true;

  guy thread ai_flagbearer_gunshots();
  animSpot thread anim_single_solo(guy, animRef);
  guy notify("stop_sequencing_notetracks");
  guy Detach("weapon_rus_ppsh_smg", "tag_weapon_right");
  level notify("death_music_stinger");

  guy waittillmatch("single anim", "detach");
  level notify("stop_flagbearer_gunshots");

  level.russianFlag Unlink();
  level thread russian_flag_startthink();

  guy thread stop_magic_bullet_shield_safe();
  guy.allowdeath = true;
  guy DoDamage(guy.health + 5, (0, 0, 0));
}

flagbearer_waitNode_anim(crouchAnim) {
  self waittill("goal");

  if(flag("flagbearer_deathrun_start")) {
    return;
  }

  self thread anim_loop_solo(self, crouchAnim, undefined, "flagbearer_deathrun_start");
  flag_wait("flagbearer_deathrun_start");
  self notify("flagbearer_deathrun_start");
}

ai_flagbearer_gunshots() {
  level endon("stop_flagbearer_gunshots");

  shotOrigin = (1140, 12888, 1713);

  while(isDefined(self)) {
    self waittillmatch("single anim", "fire");
    self thread ai_tracer_burst(shotOrigin);
  }
}

ai_tracer_burst(shotOrigin) {
  burst = RandomIntRange(3, 5);

  tags = [];
  tags[0] = "j_hip_le";
  tags[1] = "j_hip_ri";
  tags[2] = "j_head";
  tags[3] = "j_spine4";
  tags[4] = "j_spineupper";
  tags[5] = "j_spinelower";
  tags[6] = "j_clavicle_le";
  tags[7] = "j_clavicle_ri";

  for(i = 0; i < burst; i++) {
    tag = get_random(tags);
    endPos = self GetTagOrigin(tag);

    if(i != 0) {
      endPos = (endPos[0] + RandomIntRange(-10, 10), endPos[1] + RandomIntRange(-10, 10), endPos[2] + RandomIntRange(-10, 10));
    }

    BulletTracer(shotOrigin, endPos, true);

    if(is_mature()) {
      if(i == 0) {
        bloodFX = undefined;
        if(RandomInt(100) < 65) {
          bloodFX = level._effect["flesh_hit_large"];
        }

        self thread bloody_death_fx(tag, bloodFX);
      }
    }

    wait(RandomFloat(0.1));
  }
}

roof_mantle_think() {
  mantletrig = getent_safe("trig_roof_mantlearea", "targetname");

  while(1) {
    mantletrig waittill("trigger", other);
    if(!flag("russian_flag_dropped") && isPlayer(other) && other == level.lastFlagBearer) {
      break;
    } else {
      wait(0.05);
    }
  }

  orgs = [];
  times = [];
  orgs[0] = (1130.11, 12472.9, 1633.5);
  times[0] = 0.1;
  orgs[1] = (1130.11, 12469.6, 1651.44);
  times[1] = 0.1;
  orgs[2] = (1130.11, 12467.1, 1656.87);
  times[2] = 0.1;
  orgs[3] = (1130.71, 12465.1, 1656.13);
  times[3] = 0.1;
  orgs[4] = (1132.1, 12459.2, 1656.13);
  times[4] = 0.1;
  orgs[5] = (1134.74, 12446.8, 1656.13);
  times[5] = 0.1;
  orgs[6] = (1137.73, 12432.6, 1649.19);
  times[6] = 0.1;
  orgs[7] = (1140.46, 12420.8, 1641.04);
  times[7] = 0.1;
  orgs[8] = (1141.06, 12419, 1632.98);
  times[8] = 0.1;
  orgs[9] = (1141.11, 12417.5, 1624.7);
  times[9] = 0.1;
  orgs[10] = (1141.12, 12415.6, 1610.13);
  times[10] = 0.1;
  orgs[11] = (1141.12, 12415.5, 1610.13);
  times[11] = 0.1;

  while(!level.lastFlagBearer IsTouching(mantletrig)) {
    wait(0.05);
  }

  lerper = spawn("script_model", orgs[0]);
  lerper.angles = (25, 270, 0);
  lerper setModel("tag_origin");

  level notify("coop_linkto_flagbearer_start");

  level.lastFlagBearer EnableWeaponCycling();
  level.lastFlagBearer EnableOffhandWeapons();
  level.lastFlagBearer DisableWeapons();

  level.lastFlagBearer lerp_player_view_to_tag(lerper, "tag_origin", 0.43, 1, 10, 10, 5, 5);

  level.lastFlagBearer LinkTo(lerper);

  mantletrig playSound("mantle_up");

  for(i = 1; i < orgs.size; i++) {
    lerper MoveTo(orgs[i], times[i]);
    wait(times[i] - (times[i] * 0.1));
  }

  level.lastFlagBearer Unlink();
  lerper Delete();

  level notify("flagbearer_mantled");
  flag_set("flagbearer_mantled");
}

roof_mantle_debug() {
  self endon("death");
  self endon("disconnect");
  level endon("flagbearer_mantled");

  while(self.origin[2] <= 1611) {
    wait(0.05);
  }

  filename = "scriptgen/ber3b_output.gsc";
  file = openfile(filename, "write");

  fprintln(file, "orgs = []\;");
  fprintln(file, "times = []\;");

  lastOrigin = self.origin;
  lastTime = GetTime();
  arrayIndex = 0;

  while(1) {
    if(self.origin != lastOrigin) {
      originPrintStr = "orgs[" + arrayIndex + "] = " + self.origin + "\;";
      fprintln(file, originPrintStr);

      timeDiffSecs = (GetTime() - lastTime) / 1000;
      timePrintStr = "times[" + arrayIndex + "] = " + timeDiffSecs + "\;";
      fprintln(file, timePrintStr);

      lastOrigin = self.origin;
      lastTime = GetTime();

      arrayIndex++;
    }

    wait(0.1);
  }
}
roof_flagbearer_shot(animSpot) {
  flagModel = "viewmodel_russian_flag";
  linkTag = "tag_weapon";

  animname = "player_interactive";
  anime = "outro_playershot";
  interactAnim = level.scr_anim[animname][anime];
  animNotify = "player_shot_anim";

  org = GetStartOrigin(animSpot.origin, animSpot.angles, interactAnim);
  angles = GetStartAngles(animSpot.origin, animSpot.angles, interactAnim);

  hands = spawn_anim_model(animname);
  level.hands = hands;
  hands Hide();
  hands.origin = org;
  hands.angles = angles;
  hands.attachedplayer = self;

  self AllowCrouch(false);
  self AllowProne(false);

  self lerp_player_view_to_tag(hands, "tag_player", 0.5, 1, 20, 20, 30, 10);

  hands Show();
  hands Attach(flagModel, linkTag);

  level notify("flagbearer_shot_start");

  setmusicstate("ANTHEM");

  hands AnimScripted(animNotify, animSpot.origin, animSpot.angles, interactAnim);
  wait(GetAnimLength(interactAnim));

  self Unlink();

  hands Detach(flagModel, linkTag);
  hands Delete();

  self EnableWeapons();
  self DisableWeaponCycling();
  self DisableOffhandWeapons();

  if(is_coop()) {
    array_thread(get_players(), ::coop_player_give_flag_weapon);
  }

  level notify("flagbearer_shot_done");
}

coop_player_give_flag_weapon() {
  self endon("death");
  self endon("disconnect");

  self TakeAllWeapons();
  self EnableWeapons();
  self GiveWeapon("russian_flag");
  self SwitchToWeapon("russian_flag");
  self DisableWeaponCycling();
  self DisableOffhandWeapons();
}

coop_player_take_flag_weapon() {
  self endon("death");
  self endon("disconnect");

  self EnableWeaponCycling();
  self EnableOffhandWeapons();
  self DisableWeapons();
}

roof_outro_aianims(animSpot) {
  anime_playerShot = "outro_playershot";
  anime_sargeIdle = "outro_beckon_idle";
  anime_playerplantflag = "outro_playerplantflag";

  guy = spawn("script_model", animSpot.origin);
  guy Hide();

  guy maps\ber3b_anim::setup_axis_char_model();

  hatModel = "char_ger_wermacht_helm1";
  if(isDefined(guy.hatModel)) {
    if(guy.hatModel != hatModel) {
      guy Detach(guy.hatModel, "");
      guy.hatModel = hatModel;
      guy Attach(guy.hatModel, "");
    }
  } else {
    guy.hatModel = hatModel;
    guy Attach(guy.hatModel, "");
  }

  guy MakeFakeAI();
  guy.team = "axis";

  guy UseAnimTree(#animtree);
  guy.animname = "roof_flagbearer_shooter";
  animRef = level.scr_anim[guy.animname][anime_playerShot];

  weaponModel = "walther";
  guy Attach("weapon_ger_walther_pistol", "tag_weapon_right");

  guy.origin = GetStartOrigin(animSpot.origin, animSpot.angles, animRef);
  guy.angles = GetStartAngles(animSpot.origin, animSpot.angles, animRef);

  level.sarge thread clear_force_color();
  level.sarge.animname = "sarge";
  sarge_animRef = level.scr_anim[level.sarge.animname][anime_playerShot];
  level.sarge.victim = guy;

  actors[0] = guy;
  actors[1] = level.sarge;

  level waittill("flagbearer_shot_start");

  setmusicstate("ANTHEM");

  level.sarge Hide();
  level thread delayed_show_guy(guy, 0.1);

  guy thread german_outro_notetracks();
  level.sarge thread sarge_give_knife();
  level.sarge thread sarge_outro_notetracks("single anim");

  animSpot anim_single(actors, anime_playerShot);

  animSpot thread anim_loop_solo(level.sarge, anime_sargeIdle, undefined, "flagbearer_plant_start");

  level.sarge playsound_generic_facial("Ber3B_IGD_059A_REZN");

  walla_loop = getent("charge_walla", "targetname");
  cheer_sound = getent("charge_on", "targetname");
  walla_loop playLoopSound("ura_loop", 5);

  level waittill("flagbearer_plant_start");

  walla_loop stoploopsound(1);
  cheer_sound playSound("ura_cheer");
  cheer_sound playSound("flag_plant");

  animSpot anim_single_solo(level.sarge, anime_playerplantflag);
}

delayed_show_guy(guy, delay_time) {
  wait(delay_time);
  guy Show();
}

german_outro_notetracks() {
  self waittillmatch("single anim", "fire");
  level thread roof_flagbearer_shot_reaction(self);

  self waittillmatch("single anim", "start_reznov");
  level.sarge Show();

  self waittillmatch("single anim", "detach_pistol");
  self Detach("weapon_ger_walther_pistol", "tag_weapon_right");

  pistol = spawn("script_model", self GetTagOrigin("tag_weapon_right"));
  pistol.angles = self GetTagAngles("tag_weapon_right");
  pistol setModel("weapon_ger_walther_pistol");
}

roof_flagbearer_shot_reaction(shooter) {
  level.sarge thread playsound_generic_facial("Ber3B_IGD_058A_REZN");

  playFXOnTag(level._effect["rifleflash"], shooter, "tag_flash");

  wait(0.075 * GetTimescale());

  level.lastFlagBearer ViewKick(1, shooter.origin);
  playFXOnTag(level._effect["pistol_shelleject"], shooter, "tag_brass");

  VisionSetNaked("ber3b_end", 1);
}

sarge_give_knife() {
  self Detach("weapon_rus_ppsh_smg", "tag_weapon_right");
  self Attach("weapon_rus_reznov_knife", "tag_weapon_right");
}

sarge_outro_notetracks(animNotify, ender) {
  self endon("death");

  if(isDefined(ender)) {
    self endon(ender);
  }

  while(1) {
    self waittill(animNotify, note);

    if(isDefined(note)) {
      if(IsSubStr(note, "timescale_")) {
        timescale = stringToFloat(GetSubStr(note, 10));

        if(isDefined(timescale) && timescale > 0) {
          do_timescale(timescale);
        }
      } else if(note == "glint") {
        playFXOnTag(level._effect["knife_glint"], self, "tag_fx");
      } else if(note == "strike") {
        if(is_mature()) {
          playFXOnTag(level._effect["knife_slash_blood"], self, "tag_fx");
        }
      } else if(note == "stab") {
        self thread outro_stab_fx();
      } else if(note == "pull_out") {
        self thread outro_pullout_fx();
      } else if(note == "pole_sparks") {
        level notify("pole_sparks");
        playFX(level._effect["knife_sparks"], self GetTagOrigin("tag_fx"));
      } else if(note == "flagplant") {
        level notify("player_interact_flag_detach");
      }
    }
  }
}

do_timescale(timescale) {
  SetTimeScale(timescale);
}

outro_stab_fx() {
  forward = anglesToForward((self.victim GetTagAngles("tag_eye")));
  fxTag = "J_Spine4";

  if(is_mature()) {
    playFX(level._effect["knife_slash_blood"], self.victim GetTagOrigin(fxTag), forward);
  }
  self.victim playSound("bullet_large_flesh");
}

outro_pullout_fx() {
  forward = anglesToForward((self GetTagAngles("tag_eye")));
  fxTag = "J_SpineLower";

  if(is_mature()) {
    playFX(level._effect["knife_stab_blood"], self.victim GetTagOrigin(fxTag), forward);
  }

  wait(RandomFloatRange(0.1, 0.2) * GetTimescale());

  if(is_mature()) {
    playFX(level._effect["knife_stab_blood"], self.victim GetTagOrigin(fxTag), (forward * -1));
  }

  self thread outro_knife_blood_drips();
}

outro_knife_blood_drips() {
  level endon("pole_sparks");

  while(1) {
    if(is_mature()) {
      playFXOnTag(level._effect["knife_blood_drip"], self, "tag_fx");
    }
    wait(1.1);
  }
}
roof_flagbearer_plant(animSpot) {
  flagModel = "viewmodel_russian_flag";
  linkTag = "tag_weapon";

  animname = "player_interactive";
  anime = "outro_playerplantflag";
  interactAnim = level.scr_anim[animname][anime];
  animNotify = "player_plant_anim";

  self EnableWeaponCycling();
  self EnableOffhandWeapons();
  self DisableWeapons();

  if(is_coop()) {
    array_thread(get_players(), ::coop_player_take_flag_weapon);
  }

  org = GetStartOrigin(animSpot.origin, animSpot.angles, interactAnim);
  angles = GetStartAngles(animSpot.origin, animSpot.angles, interactAnim);

  hands = spawn_anim_model(animname);
  hands Hide();
  level.hands = hands;
  hands.origin = org;
  hands.angles = angles;
  hands.attachedplayer = self;

  self AllowCrouch(false);
  self AllowProne(false);

  self lerp_player_view_to_tag(hands, "tag_player", 0.5, 1, 20, 20, 10, 10);

  hands Show();
  hands Attach(flagModel, linkTag);

  level notify("flagbearer_plant_start");

  hands thread flag_detach(linkTag, flagModel);
  hands AnimScripted(animNotify, animSpot.origin, animSpot.angles, interactAnim);
  wait(GetAnimLength(interactAnim));

  self Unlink();

  lockOrigin = spawn("script_origin", self.origin);
  lockOrigin.angles = self GetPlayerAngles();
  self PlayerLinkTo(lockOrigin, undefined, 1.0, 20, 20, 20, 0);

  hands Delete();

  level notify("flagbearer_plant_done");
}

flag_detach(linkTag, flagModel) {
  level waittill("player_interact_flag_detach");

  setmusicstate("PLANT_FLAG");

  flag = spawn("script_model", self GetTagOrigin(linkTag));
  flag.angles = self GetTagAngles(linkTag);
  flag setModel(flagModel);

  self Detach(flagModel, linkTag);
}

flagbearer_interact_notetracks(msg) {
  self endon("death");

  while(1) {
    self waittill(msg, notetrack);

    if(notetrack == "end") {
      return;
    }
  }
}
finale_plane(plane_pos, angles_to) {
  self SetPlaneGoalPos(plane_pos, angles_to, 300);

  self playSound("plane_fly_by");

  wait(20);

  if(isDefined(self)) {
    self Delete();
  }
}
injured_walk() {
  level.allow_fall = true;
  level.player_speed = 50;
  level.ground_ref_ent = spawn("script_model", (0, 0, 0));

  self thread player_speed_over_time();
  self thread player_heartbeat();

  self AllowSprint(false);

  self PlayerSetGroundReferenceEnt(level.ground_ref_ent);

  if(is_coop()) {
    players = get_players();
    for(i = 0; i < players.size; i++) {
      players[i] PlayerSetGroundReferenceEnt(level.ground_ref_ent);
    }
  }

  self AllowJump(false);
  self AllowCrouch(false);
  self AllowProne(false);

  self thread limp();
}
player_speed_over_time() {
  while(1) {
    self SetMoveSpeedScale(level.player_speed / 190);
    wait(10);
    level.player_speed--;
    if(level.player_speed < 30) {
      return;
    }
  }
}

player_heartbeat() {
  level endon("player_raising_flag");
  level endon("stop_heart");

  wait 3;
  while(true) {
    if(!flag("fall")) {
      self thread play_sound_on_entity("breathing_heartbeat");
      wait 0.05;
      self PlayRumbleOnEntity("damage_light");
      wait .8;
    }

    wait(0 + randomfloat(0.1));

    if(randomint(50) > level.player_speed) {
      wait randomfloat(1);
    }
  }
}

player_jump_punishment() {
  level endon("player_raising_flag");

  wait 1;

  while(1) {
    wait 0.05;
    if(self IsOnGround()) {
      continue;
    }
    wait 0.2;
    if(self IsOnGround()) {
      continue;
    }
    level notify("stop_stumble");
    wait 0.2;
    self fall();
  }
}

fall() {
  level endon("player_raising_flag");
  level endon("stop_stumble");

  if(!level.allow_fall) {
    return;
  }

  flag_set("fall");

  self setstance("crouch");

  self thread play_sound_on_entity("bodyfall_gravel_large");

  level.ground_ref_ent thread stumble((20, 10, 30), .2, 1.5, true);

  wait .2;

  self PlayRumbleOnEntity("grenade_rumble");

  self AllowStand(false);
  self ViewKick(127, self.origin);
  level notify("slowview", 3.5);

  wait 1.5;
  flag_set("fall");

  self thread recover();

  self play_sound_in_space("sprint_gasp");
  self play_sound_in_space("breathing_hurt_start");
  self play_sound_in_space("breathing_better");

  self play_sound_on_entity("breathing_better");

  flag_clear("fall");

  self AllowStand(true);
  self AllowCrouch(true);
  level notify("recovered");
}

recover() {
  angles = self adjust_angles_to_player((-5, -5, 0));
  level.ground_ref_ent RotateTo(angles, .6, 0.6, 0);
  level.ground_ref_ent waittill("rotatedone");

  angles = self adjust_angles_to_player((-15, -20, 0));
  level.ground_ref_ent RotateTo(angles, 2.5, 0, 2.5);
  level.ground_ref_ent waittill("rotatedone");

  angles = self adjust_angles_to_player((5, 5, 0));
  level.ground_ref_ent RotateTo(angles, 2.5, 2, 0.5);
  level.ground_ref_ent waittill("rotatedone");

  level.ground_ref_ent RotateTo((0, 0, 0), 1, 0.2, 0.8);
}

limp() {
  level endon("player_raising_flag");

  stumble = 0;
  alt = 0;

  while(1) {
    velocity = self GetVelocity();
    player_speed = abs(velocity[0]) + abs(velocity[1]);

    if(player_speed < 10) {
      wait(0.05);
      continue;
    }

    speed_multiplier = player_speed / level.player_speed;

    p = RandomFloatRange(3, 5);
    if(RandomInt(100) < 20) {
      p *= 3;
    }
    r = RandomFloatRange(3, 7);
    y = RandomFloatRange(-8, -2);

    stumble_angles = (p, y, r);
    stumble_angles = vector_multiply(stumble_angles, speed_multiplier);

    stumble_time = RandomFloatRange(.35, .45);
    recover_time = RandomFloatRange(.65, .8);

    stumble++;
    if(speed_multiplier > 1.3) {
      stumble++;
    }

    self thread stumble(stumble_angles, stumble_time, recover_time);

    level waittill("recovered");
  }
}

stumble(stumble_angles, stumble_time, recover_time, no_notify) {
  level endon("player_raising_flag");
  level endon("stop_stumble");

  stumble_angles = self adjust_angles_to_player(stumble_angles);

  level.ground_ref_ent RotateTo(stumble_angles, stumble_time, (stumble_time / 4 * 3), (stumble_time / 4));
  level.ground_ref_ent waittill("rotatedone");

  base_angles = (RandomFloat(4) - 4, RandomFloat(5), 0);
  base_angles = self adjust_angles_to_player(base_angles);

  level.ground_ref_ent RotateTo(base_angles, recover_time, 0, (recover_time / 2));
  level.ground_ref_ent waittill("rotatedone");

  if(!isDefined(no_notify)) {
    level notify("recovered");
  }
}

adjust_angles_to_player(stumble_angles) {
  pa = stumble_angles[0];
  ra = stumble_angles[2];

  rv = AnglesToRight(self.angles);
  fv = anglesToForward(self.angles);

  rva = (rv[0], 0, rv[1] * -1);
  fva = (fv[0], 0, fv[1] * -1);
  angles = vector_multiply(rva, pa);
  angles = angles + vector_multiply(fva, ra);
  return angles + (0, stumble_angles[1], 0);
}
roof_planes_fire_guns_watcher() {
  level waittill("spawnvehiclegroup0");
  wait 0.1;

  il2_1 = getent("il2_1", "targetname");
  il2_2 = getent("il2_2", "targetname");

  il2_1 thread burst1_think();
  il2_2 thread burst2_think();
  il2_1 playSound("plane_fly_by");
  il2_2 playSound("plane_fly_by");
}

burst1_think() {
  self endon("death");

  wait 2;
  plane_gun1 = getent("il2_1", "targetname");
  plane_gun1 transmittargetname();
  SetClientSysState("levelNotify", "start_firing_il2_1_gun");

  self thread plane_fake_fire_loop(5);
  wait 1;
  self thread plane_fake_fire_loop(10);
  wait 0.5;
  self thread plane_fake_fire_loop(5);
  wait 1;
  self thread plane_fake_fire_loop(3);
  wait 1.5;
  self thread plane_fake_fire_loop(3);
  wait 0.75;
  self thread plane_fake_fire_loop(3);
}

burst2_think() {
  self endon("death");

  wait 2;
  plane_gun2 = getent("il2_2", "targetname");
  plane_gun2 transmittargetname();
  SetClientSysState("levelNotify", "start_firing_il2_2_gun");

  self thread plane_fake_fire_loop(5);
  wait 1;
  self thread plane_fake_fire_loop(10);
  wait 1;
  self thread plane_fake_fire_loop(5);
  wait 1;
  self thread plane_fake_fire_loop(3);
  wait 1;
  self thread plane_fake_fire_loop(3);
  wait 0.5;
  self thread plane_fake_fire_loop(3);
}

plane_fake_fire_loop(fire_times) {
  for(i = 0; i < fire_times; i++) {
    playFXOnTag(level._effect["plane_tracers"], self, "tag_gunleft");
    wait 0.07;
    playFXOnTag(level._effect["plane_tracers"], self, "tag_gunright");
    wait 0.1;
  }
}