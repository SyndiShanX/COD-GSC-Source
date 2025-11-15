/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\ber3_event_steps.gsc
*****************************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\ber3;
#include maps\_anim;
#include maps\ber3_util;
#include maps\_music;
#include maps\_busing;

event_reich_start() {
  warp_players_underworld();
  warp_friendlies("struct_reich_start_friends", "targetname");
  warp_players("struct_reich_start", "targetname");
  thread simple_spawners_level_init();
  thread maps\ber3_event_intro::e1_drones();
  getent("e3_respawn_trigger", "script_noteworthy") notify("trigger");
  level thread e3_init_event();
  level thread e3_objectives();
  level thread maps\ber3_event_intro::add_flag_to_chernov();
}

e3_init_event() {
  level.ready_to_count_deaths = false;
  thread e3_spawn_axis_controller();
  thread e3_init_bunker_friendlies();
  thread e3_panzer_guys_setup();
  pillarClip = getent("e3_pillar_clip", "targetname");
  pillarclip connectpaths();
  pillarclip trigger_off();
}

e3_objectives() {
  wait(2);
  level.ready_to_count_deaths = true;
  obj_struct = getstruct("obj_storm_stag", "targetname");
  objective_add(4, "current", & "BER3_OBJ4", obj_struct.origin);
  getent("e3_trig_end_mission", "targetname") waittill("trigger");
  objective_state(4, "done");
  nextmission();
}

send_friendlies_to_end() {
  getent("e3_friendlies_to_end", "targetname") notify("trigger");
  sargeNode = getnode("e3_sarge_node", "targetname");
  level.sarge setgoalnode(sargeNode);
  level waittill("say_final_vo");
  level.sarge anim_single_solo(level.sarge, "e3_rez_02");
  wait(.5);
  level.sarge anim_single_solo(level.sarge, "out_rez_01");
  level.sarge anim_single_solo(level.sarge, "out_rez_02");
  level.sarge anim_single_solo(level.sarge, "out_rez_04");
}

e3_panzer_guys_setup() {
  guys = getEntArray("e3_panzerguy", "script_noteworthy");
  array_thread(guys, ::add_spawn_function, ::e3_panzer_set_threatgroup);
}

e3_panzer_set_threatgroup() {
  self setthreatbiasgroup("panzer_group");
}

e3_spawn_axis_controller() {
  getent("e3_begin_spawning", "script_noteworthy") waittill("trigger");
  level.sarge set_force_color("b");
  dest_barricades = getEntArray("reich_steps_blocker", "targetname");
  for(i = 0; i < dest_barricades.size; i++) {
    dest_barricades[i] connectpaths();
  }
  trig_axis_group1 = getent("e3_axis_group1", "script_noteworthy");
  trig_axis_group2 = getent("e3_axis_group2", "script_noteworthy");
  trig_axis_group3 = getent("e3_axis_group3", "script_noteworthy");
  level.spawner_notifies = [];
  level.spawner_num = 0;
  level.group1_deaths = 0;
  level.group2_deaths = 0;
  level.group3_deaths = 0;
  level.playerkill = 0;
  level.ready_to_spawn_group2 = false;
  thread wait_to_spawn_group2();
  level.ready_to_spawn_group3 = false;
  level.current_watch_group = 1;
  thread watch_group_deaths();
  thread spawner_notify_manager();
  thread e3_spawn_group(trig_axis_group1, 1);
  level waittill("finished spawning group 1");
  while(!level.ready_to_spawn_group2) {
    wait(.2);
  }
  wait(1.0);
  thread e3_spawn_group(trig_axis_group2, 2);
  while(!level.ready_to_spawn_group3) {
    wait(.2);
  }
  autosave_by_name("ber3_steps_checkpoint");
  wait(1.0);
  thread e3_spawn_group(trig_axis_group3, 3);
}

wait_to_spawn_group2() {
  getent("e3_start_script_movement", "targetname") waittill("trigger");
  level.ready_to_spawn_group2 = true;
}

spawner_notify_manager() {
  level endon("stop stair group 3");
  while(true) {
    wait(.1);
    for(i = 0; i < 2; i++) {
      if(isDefined(level.spawner_notifies[0])) {
        spNotify = level.spawner_notifies[0];
        level notify(spNotify);
        level.spawner_notifies = array_remove(level.spawner_notifies, spNotify);
      }
    }
  }
}

e3_spawn_group(trig_spawner, whichGroup) {
  spawners = getEntArray(trig_spawner.target, "targetname");
  for(i = 0; i < spawners.size; i++) {
    if(!OkTospawn()) {
      wait_network_frame();
    }
    spawners[i] thread e3_stairs_spawner(whichGroup);
    wait_network_frame();
  }
  level notify("finished spawning group " + whichGroup);
}

e3_stairs_spawner(whichGroup) {
  level endon("stop stair group " + whichGroup);
  spawnerNum = level.spawner_num;
  level.spawner_num++;
  self add_spawn_function(::e3_count_axis_deaths, whichGroup);
  while(true) {
    level.spawner_notifies[level.spawner_notifies.size] = "e3 spawn guy " + spawnerNum;
    level waittill("e3 spawn guy " + spawnerNum);
    while(!OkTospawn()) {
      wait_network_frame();
    }
    if(isDefined(self) && self.count <= 0) {
      self.count = 1;
    }
    ai = self Stalingradspawn();
    spawn_failed(ai);
    if(isDefined(ai)) {
      ai waittill("death");
    }
    wait(.25);
  }
}

e3_count_axis_deaths(whichGroup) {
  self waittill("death");
  switch (whichGroup) {
    case 1:
      if(level.current_watch_group == 1) {
        if(isDefined(self.attacker) && isai(self.attacker)) {
          level.group1_deaths++;
        } else if(isDefined(self.attacker) && isplayer(self.attacker)) {
          level.group1_deaths++;
          level.playerkill++;
        }
      }
      break;
    case 2:
      if(level.current_watch_group == 2) {
        if(isDefined(self.attacker) && isai(self.attacker)) {
          level.group2_deaths++;
        } else if(isDefined(self.attacker) && isplayer(self.attacker)) {
          level.group2_deaths++;
          level.playerkill++;
        }
      }
      break;
    case 3:
      if(level.current_watch_group == 3) {
        if(isDefined(self.attacker) && isai(self.attacker)) {
          level.group3_deaths++;
        } else if(isDefined(self.attacker) && isplayer(self.attacker)) {
          level.group3_deaths++;
          level.playerkill++;
        }
      }
      break;
    default:
      return;
  }
}

watch_group_deaths() {
  while(!level.ready_to_count_deaths) {
    wait(1);
  }
  level.sarge thread anim_single_solo(level.sarge, "stairs_rez_01");
  players = get_players();
  group12_death_min = 5 + (players.size * 5);
  group12_pkill_min = (group12_death_min * 0.5);
  group3_death_min = 2 + (players.size * 1);
  group3_pkill_min = (group3_death_min * 0.5);
  trig_axis_group1_kill = getent("e3_axis_group1_kill", "script_noteworthy");
  trig_axis_group2_kill = getent("e3_axis_group2_kill", "script_noteworthy");
  while(level.group1_deaths < group12_death_min) {
    wait(.5);
  }
  while(level.playerkill < group12_pkill_min) {
    wait(.5);
  }
  level notify("stop stair group 1");
  level.ready_to_spawn_group3 = true;
  level.current_watch_group = 2;
  level.playerkill = 0;
  thread e3_friendlies_move_1();
  while(level.group2_deaths < group12_death_min) {
    wait(.5);
  }
  while(level.playerkill < group12_pkill_min) {
    wait(.5);
  }
  level notify("stop stair group 2");
  level.current_watch_group = 3;
  level.playerkill = 0;
  thread e3_friendlies_move_2();
  while(level.group3_deaths < group3_death_min) {
    wait(.5);
  }
  while(level.playerkill < group3_pkill_min) {
    wait(.5);
  }
  level notify("stop stair group 3");
  thread e3_outro_anim_start();
}

e3_friendlies_move_1() {
  trig = getent("e3_stairs_moveup1", "targetname");
  trig notify("trigger");
  level.sarge anim_single_solo(level.sarge, "stairs_rez_02");
}

e3_friendlies_move_2() {
  trig = getent("e3_stairs_moveup2", "targetname");
  trig notify("trigger");
  level.sarge anim_single_solo(level.sarge, "stairs_rez_03");
}

e3_allies_storm_reich() {
  thread spawn_outro_axis();
  spawner_trigs = getEntArray("e3_finale_allies", "script_noteworthy");
  wait(13);
  for(i = 0; i < spawner_trigs.size; i++) {
    spawners = getEntArray(spawner_trigs[i].target, "targetname");
    array_thread(spawners, ::add_spawn_function, ::e3_reich_stormers_init);
    thread e3_spawn_group(spawner_trigs[i], 10);
    wait(.5);
  }
  allies = getaiarray("allies");
  for(i = 0; i < allies.size; i++) {
    allies[i].grenadeawareness = 0;
    if(isDefined(allies[i].magic_bullet_shield) && allies[i].magic_bullet_shield) {
      continue;
    } else {
      allies[i] thread magic_bullet_shield();
    }
  }
  wait 15;
  level notify("pwn_joyal");
}

e3_reich_stormers_init() {
  self.ignoreall = true;
  self.ignoreme = true;
  self thread magic_bullet_shield();
  self waittill("goal");
  self thread stop_magic_bullet_shield();
  self thread bloody_death(true);
}

spawn_outro_axis() {
  spawners = getEntArray("e3_outro_axis", "script_noteworthy");
  array_thread(spawners, ::add_spawn_function, ::e3_reich_germans_init);
}

e3_reich_germans_init() {
  self.grenadeawareness = 0;
  self thread magic_bullet_shield();
}

e3_outro_anim_start() {
  player_ready = false;
  touch_trig = getent("trig_kill_chernov", "targetname");
  players = getplayers();
  level.sarge anim_single_solo(level.sarge, "stairs_rez_04");
  while(!player_ready) {
    for(i = 0; i < players.size; i++) {
      if(isDefined(players[i]) && players[i] IsTouching(touch_trig)) {
        player_ready = true;
      }
    }
    wait(.1);
  }
  thread kill_all_nazis();
  thread chernov_death_init();
  thread reich_pillar_fall();
}

chernov_death_init() {
  level.sarge disable_ai_color();
  level.chernov disable_ai_color();
  level.sarge.ignoreme = 1;
  level.sarge.pacifist = 1;
  level.sarge.grenadeawareness = 0;
  level.chernov.ignoreme = 1;
  level.chernov.pacifist = 1;
  level.chernov.grenadeawareness = 0;
  flameguy_spawner = getent("e3_flamer", "targetname");
  flameguy_spawner add_spawn_function(::flameguy_init);
  thread e3_play_chernov_death_anim();
  thread e3_allies_storm_reich();
  level waittill("spawn flamethrower");
  wait(3);
  flameguy_spawner stalingradspawn();
}

e3_play_chernov_death_anim() {
  level.chernov endon("death");
  level.sarge = getent("sarge", "script_noteworthy");
  level.sarge.animname = "reznov";
  level.sarge.ignoreall = true;
  level.chernov = getent("chernov", "script_noteworthy");
  level.chernov.animname = "chernov";
  reznode = getnode("node_outro_rez_start", "targetname");
  anode = getnode("ber3_column_collapse", "targetname");
  level.sarge setgoalnode(reznode);
  level.sarge waittill("goal");
  schreck1_start = getstruct("e3_pillar_rocket1_start", "targetname");
  schreck1_end = getstruct(schreck1_start.target, "targetname");
  schreck2_start = getstruct("e3_pillar_rocket2_start", "targetname");
  schreck2_end = getstruct(schreck2_start.target, "targetname");
  thread maps\ber3_event_intro::fire_shrecks(schreck1_start, schreck1_end, 1);
  wait(.5);
  thread maps\ber3_event_intro::fire_shrecks(schreck2_start, schreck2_end, 1);
  wait(1);
  level notify("drop pillar");
  wait(4);
  level notify("spawn flamethrower");
  level.chernov setModel("char_rus_guard_grachev_burn");
  if(isDefined(level.cher_rus_flag)) {
    level.cher_rus_flag delete();
  }
  thread give_chernov_outro_flag();
  level thread chernov_remove_gun();
  anode anim_single_solo(level.chernov, "chernov_in");
  anodeanim_loop_solo(level.chernov, "chernov_loop", undefined, "stop_chernov");
}

chernov_remove_gun() {
  level.chernov.ignoreall = true;
  level.chernov.ignoreme = true;
  wait(0.1);
  level.chernov animscripts\shared::PlaceWeaponOn(level.chernov.primaryweapon, "none");
}

give_chernov_outro_flag() {
  cherFlag = spawn("script_model", level.chernov.origin);
  cherFlag setModel("anim_berlin_rus_flag_rolled");
  cherFlag linkto(level.chernov, "tag_inhand", (0, 0, 0), (0, 0, 0));
  level waittill("detach outro flag");
  cherFlag unlink();
}

outro_flag_notify_unlink(guy) {
  level notify("detach outro flag");
}

reznov_fire_at_fake_target() {
  level.sarge.pacifist = 0;
  level.ignoreall = false;
  targ = getent("reznov_target", "targetname");
  level.sarge SetEntityTarget(targ);
}

reznov_outro_anims(guy) {
  level.sarge StopShoot();
  anode = getnode("ber3_column_collapse", "targetname");
  anode anim_single_solo(level.sarge, "chernov_in");
  thread send_friendlies_to_end();
  level notify("say_final_vo");
}

reznov_outro_attach_book(guy) {
  if(!has_diary()) {
    level.sarge Attach("static_berlin_books_diary", "tag_inhand");
  }
}

reznov_outro_detach_book(guy) {
  if(has_diary()) {
    level.sarge detach("static_berlin_books_diary", "tag_inhand");
  }
}

has_diary() {
  size = level.sarge GetAttachSize();
  for(i = 0; i < size; i++) {
    if(level.sarge GetAttachModelName(i) == "static_berlin_books_diary") {
      return true;
    }
  }
  return false;
}

death_flame_fx() {
  tagArray = [];
  tagArray[tagArray.size] = "J_Wrist_RI";
  tagArray[tagArray.size] = "J_Wrist_LE";
  tagArray[tagArray.size] = "J_Elbow_LE";
  tagArray[tagArray.size] = "J_Elbow_RI";
  tagArray[tagArray.size] = "J_Knee_RI";
  tagArray[tagArray.size] = "J_Knee_LE";
  tagArray[tagArray.size] = "J_Ankle_RI";
  tagArray[tagArray.size] = "J_Ankle_LE";
  playFXOnTag(level._effect["flame_death2"], self, "J_SpineLower");
  self StartTanning();
}

kill_all_nazis() {
  getent("e3_axis_group1_kill", "script_noteworthy") notify("trigger");
  axis = getaiarray("axis");
  level waittill("drop pillar");
  for(i = 0; i < axis.size; i++) {
    if(isDefined(axis[i]) && is_active_ai(axis[i])) {
      axis[i] thread bloody_death(true, 4);
    }
  }
}

e3_pillar_FX1n2(guy) {
  exploder(1);
  thread cover_smoke();
  quake_struct = getstruct("e3_pillar_fall_struct", "targetname");
  earthquake(0.5, 1.5, quake_struct.origin, 1024);
  touch_trig = getent("trig_kill_chernov", "targetname");
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    if(players[i] IsTouching(touch_trig)) {
      players[i] thread e3_knock_down();
    }
  }
}

e3_pillar_FX3(guy) {
  exploder(3);
}

e3_pillar_FX4(guy) {
  exploder(4);
}

e3_pillar_FX5(guy) {
  exploder(5);
}

e3_knock_down() {
  self allowstand(false);
  self allowcrouch(false);
  self allowsprint(false);
  self allowprone(true);
  level waittill("spawn flamethrower");
  wait(1);
  self allowstand(true);
  self allowcrouch(true);
  self allowsprint(true);
  self allowprone(true);
}

cover_smoke() {
  fxSpot = spawn("script_model", (1256, 11256, 284));
  fxSpot setModel("tag_origin");
  fxSpot.angles = (0, 270, 0);
  playFXOnTag(level._effect["pillar_cover_smoke"], fxSpot, "tag_origin");
  wait(.5);
  level.chernov animscripts\shared::PlaceWeaponOn(level.chernov.primaryweapon, "none");
}

e3_init_bunker_friendlies() {
  level.sarge anim_single_solo(level.sarge, "e3_rez_01");
  level.sarge anim_single_solo(level.sarge, "e3_rez_03");
  thread bunker1_friendlies();
  thread bunker2_friendlies();
}

bunker1_friendlies() {
  getent("e3_init_bunker1_friendly", "targetname") waittill("trigger");
  guy = get_friendly_by_color("o");
  if(isDefined(guy)) {
    guy set_force_color("r");
    wait(1);
    getent("e3_move_bunker1_friendly", "targetname") notify("trigger");
  }
}

bunker2_friendlies() {
  getent("e3_init_bunker2_friendly", "targetname") waittill("trigger");
  guy = get_friendly_by_color("o");
  if(isDefined(guy)) {
    guy set_force_color("y");
    wait(1);
    getent("e3_move_bunker2_friendly", "targetname") notify("trigger");
  }
}

get_friendly_by_color(which_color) {
  allies = getaiarray("allies");
  for(i = 0; i < allies.size; i++) {
    if(allies[i] check_force_color(which_color)) {
      return allies[i];
    }
  }
  return undefined;
}

flameguy_init() {
  level.flameguy = self;
  level.flameguy.pacifist = 1;
  level.flameguy.ignoreme = 1;
  level.flameguy.goalradius = 32;
  level.flameguy.dropweapon = false;
  level.flameguy thread magic_bullet_shield();
  level.flameguy setCanDamage(false);
  level.flameguy.anim_disableLongDeath = true;
  flameguy_think();
}

flameguy_think() {
  targ_node = getnode("e3_flamer_pos", "targetname");
  level.flameguy setgoalnode(targ_node);
  level.flameguy waittill("goal");
  targ = getent("flameguy_target", "targetname");
  level.flameguy.pacifist = 0;
  level.flameguy SetEntityTarget(targ);
  wait(.5);
  level.flameguy StopShoot();
  level.flameguy.pacifist = 1;
  wait(1.5);
  level.chernov thread death_flame_fx();
  wait(1.5);
  level.flameguy setCanDamage(true);
  level.flameguy flamer_blow();
}

flamer_blow() {
  wait(2.5);
  if(isalive(self)) {
    self enable_pain();
  }
  earthquake(0.2, 0.2, self.origin, 1500);
  playFX(level._effect["flameguy_explode"], self.origin + (0, 0, 50));
  self.health = 50;
  allies = getaiarray("allies");
  allies[0] magicgrenade(self.origin + (-20, -25, 20), self.origin, 0.01);
  allies[0] magicgrenade(self.origin + (-25, -30, 10), self.origin, 0.01);
  spot = self.origin;
  allies = getaiarray("allies");
  wait 0.1;
  if(isDefined(self) && isDefined(self.health) && self.health > 0) {
    self dodamage(self.health * 10, self.origin);
  }
}

#using_animtree("ber3_reich_pillar");

reich_pillar_fall() {
  level waittill("drop pillar");
  thread rumble_all_players("damage_light");
  pillar = getent("sb_model_column_collapse", "targetname");
  pillar delete();
  anode = getstruct("e3_pillar_fall_struct", "targetname");
  amodel = spawn("script_model", anode.origin, 1);
  amodel setModel(level.scr_model["reich_pillar"]);
  amodel.animname = "reich_pillar";
  amodel useanimtree(level.scr_animtree["reich_pillar"]);
  thread kill_players_under_pillar();
  amodel playSound("explosion");
  setmusicstate("PILLAR");
  anode anim_single_solo(amodel, "pillar_collapse");
  dest_barricades = getEntArray("reich_steps_blocker", "targetname");
  thread rumble_all_players("damage_heavy");
  earthquake(0.4, 3, amodel.origin, 1000);
  for(i = 0; i < dest_barricades.size; i++) {
    dest_barricades[i] delete();
  }
  set_all_players_shock("ber3_outro", 6);
  dest_barricades_brush = getent("e3_reich_steps_blocker_brush", "targetname");
  dest_barricades_brush connectpaths();
  wait(.1);
  dest_barricades_brush delete();
  pillarClip = getent("e3_pillar_clip", "targetname");
  pillarclip trigger_on();
  wait(.1);
  pillarclip disconnectpaths();
  amodel disconnectpaths();
  setbusstate("PILLAR");
}

kill_players_under_pillar() {
  wait(3);
  pillarClip = getent("e3_pillar_deathzone", "targetname");
  players = get_players();
  for(i = 0; i < players.size; i++) {
    if(players[i] istouching(pillarClip)) {
      players[i] enableHealthShield(false);
      players[i] dodamage(players[i].health * 10, players[i].origin);
    } else {
      players[i] setCanDamage(false);
    }
  }
}