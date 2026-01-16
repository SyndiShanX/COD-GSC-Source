/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\karma_the_end.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\karma_util;
#include maps\_scene;
#include maps\_objectives;
#include maps\_dialog;
#include maps\_glasses;
#include maps\_music;
#include maps\createart\karma_2_art;
#include maps\_rusher;
#include maps\_anim;
#include maps\_heatseekingmissile;
#include maps\karma_the_end;
#include maps\_vehicle;

init_flags() {
  flag_init("vtol_doors_start_closing");
  flag_init("start_end_sequence");
  flag_init("defalco_stopped");
  flag_init("defalco_vtol_flying_away");
  flag_init("karma_killed");
}

init_spawn_funcs() {
}

skipto_confrontation() {
  skipto_teleport("skipto_the_end");
  level.ai_harper = init_hero_startstruct("harper", "e10_harper_start");
  level.ai_salazar = init_hero_startstruct("salazar", "e10_salazar_start");
  flag_set("start_end_sequence");
}

skipto_getaway() {
  init_heroes(array("harper", "salazar"));
  skipto_teleport("dev_the_end2");
  flag_set("start_end_sequence");
  exploder(2);
}

_give_player_rocket_launcher() {
  level.player giveweapon("fhj18_dpad_sp");
  level.player setactionslot(3, "weapon", "fhj18_dpad_sp");
  level.player givemaxammo("fhj18_dpad_sp");
}

main() {
  level.vh_vtol = getent("defalco_osprey", "targetname");
  flag_wait("start_end_sequence");
  init_heroes(array("harper", "salazar"));
  add_trigger_function("run_escape_scene", ::run_escape_scene);
  level thread defalco_escape();
  exploder(1010);
}

run_escape_scene() {
  if(!flag("escape_ending_started") && !flag("defalco_stopped")) {
    if(isDefined(level.ai_defalco_escort1))
      level.ai_defalco_escort1 delete();

    if(isDefined(level.ai_defalco_escort2))
      level.ai_defalco_escort2 delete();

    flag_waitopen("glasses_bink_playing");
    wait 0.5;
    level thread run_scene("escape_ending");
    level thread run_scene("escape_ending_player");
    set_objective(level.obj_stop_defalco, undefined, "failed");
    setmusicstate("KARMA_DEFALCO_ESCAPED");
  }
}

defalco_escape() {
  level thread player_gets_ahead();
  level.ai_defalco = simple_spawn_single("defalco", ::defalco_escape_defalco);
  level.ai_defalco_escort1 = simple_spawn_single("defalco_escort_left", ::defalco_escape_escort);
  level.ai_defalco_escort2 = simple_spawn_single("defalco_escort_right", ::defalco_escape_escort);
  level.ai_karma = init_hero("karma", ::defalco_escape_karma);
}

player_gets_ahead() {
  level endon("escape_ending_started");
  level endon("escape_ending_first_frame");
  flag_wait("cancel_helipad_pip");
  flag_set("defalco_stopped");
}

defalco_death() {
  level endon("escape_ending_started");
  self waittill("death");
  flag_set("defalco_stopped");
  level notify("stop_naglines");
  level thread queue_players_success_dialog_line();
  level.ai_harper.perfectaim = 1;
  level.ai_harper.ignoreall = 0;
  level.ai_salazar.perfectaim = 1;
  level.ai_salazar.ignoreall = 0;
  set_objective(level.obj_stop_defalco, undefined, "done");
  wait 1.2;

  if(isalive(level.ai_defalco_escort1)) {
    level.ai_defalco_escort1 bloody_death();
    wait 1.8;
  }

  if(isalive(level.ai_defalco_escort2))
    level.ai_defalco_escort2 bloody_death();

  kill_all_enemies();
  setmusicstate("KARMA_DEFALCO_DEAD");
  level.player set_story_stat("DEFALCO_DEAD_IN_KARMA", 1);
  screen_fade_out(1.5);
  wait 2;
  ent = spawn("script_origin", (-306, 7410, -2767));
  ent playloopsound("veh_end_osp_steady", 2);
  level.player thread maps\createart\karma_2_art::vision_set_change("sp_karma2_defalco_walk");
  level thread run_scene("defalco_dead_ending");
  wait 0.2;
  level thread screen_fade_in(0.5);
  level waittill("start_fadeout");
  next_mission(0.5);
}

queue_players_success_dialog_line() {
  level.player queue_dialog("sect_lights_out_fucker_0", 1, undefined, "karma_killed");
}

next_mission(n_fade_time) {
  level notify("level_ending");
  screen_fade_out(n_fade_time);
  wait 0.2;

  nextmission();
}

player_detected() {
  level endon("escape_ending_started");
  self endon("death");

  while(true) {
    if(abs(level.player.origin[2] - self.origin[2]) < 2 && self sightconetrace(level.player geteye(), level.player) > 0.9) {
      n_dist = distance2d(level.player.origin, self.origin);

      if(n_dist < 300)
        level.too_close_for_zoom = 1;

      self notify("player_detected");
      wait 0.05;
      self notify("player_detected");
      return;
    }

    wait 0.05;
  }
}

defalco_reaches_end() {
  level endon("escape_ending_started");
  flag_wait("defalco_reached_end");
  v_eye = level.player geteye();

  foreach(ent in array(level.ai_defalco, level.ai_karma)) {
    if(isalive(ent) && ent sightconetrace(v_eye, level.player) > 0.1) {
      flag_set("defalco_stopped");
      break;
    }
  }

  if(!flag("defalco_stopped")) {
    run_scene_first_frame("escape_ending");

    if(!flag("cancel_helipad_pip"))
      level thread defalco_helipad_pip();

    set_objective(level.obj_stop_defalco, level.ai_defalco, & "KARMA_2_OBJ_3D_DEFALCO", undefined, 0, 0.05);
    exploder(2);
  }
}

#using_animtree("generic_human");

defalco_escape_defalco() {
  self endon("death");
  self.health = 200;
  level endon("escape_ending_started");
  level thread defalco_reaches_end();
  self thread defalco_death();
  self thread player_detected();
  self.overrideactordamage = ::take_player_damage_only;
  self.ignoreall = 1;
  set_run_anim("defalco_escape_run", 1);
  self.moveplaybackrate = 1.8;
  self.a.movement = "run";
  self thread follow_path("defalco_end_path", 1);
  set_objective(level.obj_stop_defalco, self, & "KARMA_2_OBJ_3D_DEFALCO", undefined, 1, 40);
  self waittill_any_array_endon(array("damage", "player_detected"), level, "defalco_stopped");
  flag_set("defalco_stopped");
  self waittill("player_detected");
  self thread kill_me_timer(level.player, 240);

  if(!(isDefined(level.too_close_for_zoom) && level.too_close_for_zoom))
    level thread defalco_zoom(self);

  level notify("stop_naglines");
  set_objective(level.obj_stop_defalco, self, & "KARMA_2_OBJ_3D_DEFALCO", undefined, 1, 0.05);
  self.has_ir = 1;
  self.moveplaybackrate = 1;
  self.anim_defalco_react = % ch_karma_11_ending_defalco_reaction;
  self animcustom(::escort_react);
  self.ignoreall = 0;
  self.ignoreme = 0;
  self setentitytarget(level.player);
  self.favoriteenemy = level.player;
  a_nodes = self findbestcovernodes(2000, self.origin);
  a_bad_nodes = getcovernodearray(level.player.origin, 800);
  a_good_nodes = get_array_of_closest(self.origin, a_nodes, a_bad_nodes);
  self.goalradius = 1000;

  if(a_good_nodes.size > 0)
    force_goal(a_good_nodes[0]);
  else
    set_goal_pos(self.origin);

  wait 3;
  player_seek(1);
}

kill_me_timer(attacker, time) {
  self endon("death");
  wait(time);
  self dodamage(self.health + 100, self.origin, attacker);
}

defalco_zoom(ai_defalco) {
  self.bulletcam_death = 0;
  level.player.ignoreme = 1;
  level.player.v_player_before_zoom_ang = level.player getplayerangles();
  level.player.v_player_before_zoom_eye = level.player geteye();
  level.player.v_player_before_zoom_org = level.player.origin;
  level.player_pos_ent = spawn("script_origin", level.player.v_player_before_zoom_eye);
  level.player hideviewmodel();
  level.player disableweapons();
  level.player freezecontrols(1);
  level.player enableinvulnerability();
  level.player hide_hud();
  level.player setclientdvar("cg_cameraUseTagCamera", "1");
  e_cam = spawn_model("p_glo_bullet_tip", level.player.v_player_before_zoom_eye, level.player.angles);
  e_cam hide();
  sndent = spawn("script_origin", (0, 0, 0));
  sndent playloopsound("evt_timeslow_loop", 0.25);
  level.player disableclientlinkto();
  level.player playerlinktoabsolute(e_cam, "tag_origin");
  e_cam zoom_in(1, 0.5, 0.2, 0.3);
  e_cam zoom_in(2, 0.7, 0.2, 0.2);
  e_cam zoom_in(3, 0.85, 0.2, 0.15);
  e_cam zoom_in(4, 1.0, 0.2, 0.5, vectorscale((1, 0, 1), 10.0));
  level.player.ignoreme = 0;
  level.defalco_zoom_done = 1;
  settimescale(1);
  rpc("clientscripts/karma_utility", "screen_flash");
  level notify("zoom_in", 5);
  e_cam delete();
  wait 0.05;
  sndent stoploopsound(1.5);
  delay_thread(3, ::delete_sndent, sndent);
  level.player setorigin(level.player.v_player_before_zoom_org);
  level.player setplayerangles(level.player.v_player_before_zoom_ang);
  level.player showviewmodel();
  level.player enableweapons();
  level.player freezecontrols(0);
  level.player show_hud();
  wait 2;
  level.player disableinvulnerability();
  level.player_pos_ent delete();
}

delete_sndent(ent) {
  ent delete();
}

zoom_in(n_step, n_fraction, n_timescale, n_hold_time, v_offset) {
  if(!isDefined(v_offset))
    v_offset = (0, 0, 0);

  settimescale(1);
  rpc("clientscripts/karma_utility", "screen_flash");
  level notify("zoom_in", n_step);
  update_cam(n_fraction, v_offset);
  wait 0.05;
  settimescale(n_timescale);
  wait(n_hold_time);
}

set_react_anim_time() {
  self endon("death");
  self endon("defalco_reaction_done");

  while(true) {
    level waittill("zoom_in", n_step);

    if(n_step == 1)
      self setanimtime(self.anim_defalco_react, 0);
    else if(n_step == 2)
      self setanimtime(self.anim_defalco_react, 0.2);
    else if(n_step == 3)
      self setanimtime(self.anim_defalco_react, 0.5);
    else if(n_step == 4) {
      self setflaggedanimknoball("defalco_react", self.anim_defalco_react, % root, 1, 0.3, 0.2);
      self setanimtime(self.anim_defalco_react, 0.7);
    } else if(n_step == 5) {
      self setflaggedanimknoball("defalco_react", self.anim_defalco_react, % root, 1, 0.3, 1);
      self setanimtime(self.anim_defalco_react, 0.9);
    }
  }
}

update_cam(n_fraction, v_offset) {
  v_target = level.ai_defalco gettagorigin("j_spine4");
  v_to_end = v_target - level.player.v_player_before_zoom_eye;
  n_vec_length = length(v_to_end);
  v_path = vectornormalize(v_to_end) * (n_vec_length - 40);
  self dontinterpolate();
  self.origin = lerpvector(level.player.v_player_before_zoom_eye, level.player.v_player_before_zoom_eye + v_path, n_fraction) + v_offset;
  self.angles = vectortoangles(v_target - self.origin);
}

kill_all_enemies() {
  kill_spawnernum(52);
  kill_spawnernum(53);
  kill_spawnernum(80);

  foreach(ai in getaiarray("axis"))
  ai thread bloody_death(undefined, randomfloat(2));

  level.player.ignoreme = 1;
  level.ai_harper.ignoreme = 1;
  level.ai_salazar.ignoreme = 1;
  wait 2;
}

defalco_escape_escort() {
  self endon("death");
  level endon("escape_ending_started");
  self.overrideactordamage = ::take_player_damage_only;
  self.ignoreall = 1;
  self.ignoreme = 1;
  wait 0.05;
  self.a.movement = "run";
  set_run_anim("defalco_escape_run", 1);
  self thread follow_path(self.target, 1);
  self.moveplaybackrate = 1.8;
  self waittill_any_array_endon(array("damage"), level, "defalco_stopped", level, "defalco_reached_end");
  clear_run_anim();
  stop_follow_path();

  if(flag("defalco_stopped")) {
    self.moveplaybackrate = 1;

    if(self.targetname == "defalco_escort_left_ai") {
      self.anim_defalco_react = % ch_karma_11_ending_pmc01_reaction;
      self animcustom(::escort_react);
    } else if(self.targetname == "defalco_escort_right_ai") {
      self.anim_defalco_react = % ch_karma_11_ending_pmc02_reaction;
      self animcustom(::escort_react);
    }

    self waittill("defalco_reaction_done");
  }

  self.overrideactordamage = undefined;
  self.ignoreall = 0;
  self.ignoreme = 0;
  self set_goal_pos(self.origin);
  self.favoriteenemy = level.player;
  self thread shoot_at_target(level.player, undefined, 0, 2);
  maps\_rusher::rush();
}

escort_react() {
  self endon("death");
  self thread print_origin("defalco_reaction_done");
  clear_run_anim();
  stop_follow_path();
  disable_react();
  disable_pain();
  v_to_player = level.player.origin - self.origin;
  n_dot_to_player = vectordot(vectornormalize(v_to_player), anglestoforward(self.angles));

  if(n_dot_to_player < -0.3) {
    v_goal_angles = vectortoangles(v_to_player * -1);
    self thread lerp_position(undefined, v_goal_angles, 1);
    self setflaggedanimknoball("defalco_react", self.anim_defalco_react, % root, 1, 0.3, 1);
    self thread set_react_anim_time();
    self waittillmatch("defalco_react", "end");
    self notify("stop_lerp_position");
  }

  self notify("defalco_reaction_done");
  enable_pain();
  enable_react();
}

print_origin(str_endon) {
  self endon("death");
  self endon(str_endon);

  while(true) {
    maps\_anim::anim_origin_render(self.origin, self.angles);
    maps\_anim::rec_anim_origin_render(self.origin, self.angles);
    wait 0.05;
  }
}

lerp_position(v_goal_pos, v_goal_angles, n_lerp_time) {
  self endon("death");
  self endon("stop_lerp_position");
  timer = new_timer();
  v_start_pos = self.origin;
  v_start_ang = self.angles;

  do {
    n_time = timer timer_wait(0.05);

    if(isDefined(v_goal_pos))
      v_new_pos = lerpvector(v_start_pos, v_goal_pos, n_time / n_lerp_time);
    else
      v_new_pos = self.origin;

    if(isDefined(v_goal_angles))
      v_new_ang = (anglelerp(v_start_ang[0], v_goal_angles[0], n_time / n_lerp_time), anglelerp(v_start_ang[1], v_goal_angles[1], n_time / n_lerp_time), anglelerp(v_start_ang[2], v_goal_angles[2], n_time / n_lerp_time));
    else
      v_new_ang = self.angles;

    self forceteleport(v_new_pos, v_new_ang);
  }
  while(n_time < n_lerp_time);

  self notify("lerp_done");
}

defalco_escape_karma() {
  level endon("escape_ending_started");
  level endon("escape_ending_first_frame");
  self gun_remove();
  self.overrideactordamage = ::take_player_damage_only;
  self.ignoreall = 1;
  self thread karma_death();
  set_run_anim("defalco_escape_run", 1);
  self.moveplaybackrate = 1.8;
  wait 0.05;
  self.a.movement = "run";
  self thread follow_path("karma_end_path", 1);
  flag_wait("defalco_stopped");
  clear_run_anim();
  stop_follow_path();
  self.moveplaybackrate = 1;
  self.anim_defalco_react = % ch_karma_11_ending_karma_reaction;
  self animcustom(::escort_react);
  self waittill("defalco_reaction_done");
  run_scene("defalco_escape_cower_karma");
}

karma_death() {
  level endon("escape_ending_started");
  self waittill("death");
  flag_set("karma_killed");
  wait 2;
  missionfailedwrapper(&"KARMA_2_KARMA_ENDLEVEL_FATAL_SHOT");
}

waittill_any_array_endon(a_notifies, e_ent, str_endon, e_ent2, str_endon2) {
  assert(isDefined(a_notifies[0]), "At least the first element has to be defined for waittill_any_array.");

  if(isDefined(e_ent) && isDefined(str_endon))
    e_ent endon(str_endon);

  if(isDefined(e_ent2) && isDefined(str_endon2))
    e_ent2 endon(str_endon2);

  for(i = 1; i < a_notifies.size; i++) {
    if(isDefined(a_notifies[i]))
      self endon(a_notifies[i]);
  }

  self waittill(a_notifies[0]);
}

_give_player_sniper_weapon() {
  self giveweapon("ballista_karma_sp");
  self switchtoweapon("ballista_karma_sp");
  self givemaxammo("ballista_karma_sp");
  level.player setforceads(1);
  level.player disableweaponfire();
}

player_has_weapon(str_weapon) {
  b_has_weapon = 0;
  a_weapons = self getweaponslist();

  foreach(weapon in a_weapons) {
    if(weapon == str_weapon)
      b_has_weapon = 1;
  }

  return b_has_weapon;
}

launch_escape_vehicle(delay) {
  level.vh_vtol.health = 10000;
  level.vh_vtol.overridevehicledamage = ::defalco_escape_vehicle_callback;
  level.vh_vtol.drivepath = 1;

  if(isDefined(level.ai_defalco)) {
    level.ai_defalco hide();
    level.ai_defalco linkto(level.vh_vtol);
  }

  nd_escape_path = getvehiclenode("escape_plane_path_start", "targetname");
  level.vh_vtol.origin = nd_escape_path.origin;
  level.vh_vtol thread go_path(nd_escape_path);
  v_offset = vectorscale((0, 0, 1), 50.0);
  target_set(level.vh_vtol, v_offset);
  maps\_heatseekingmissile::setminimumstidistance(100);
  level.vh_vtol.takedamage = 1;
  return level.vh_vtol;
}

do_vtol_escape(ent) {
  if(!flag("escape_scene_teleport_friends"))
    level thread pip_karma_event("pip_helipad");

  level.vh_vtol = getent("defalco_osprey", "targetname");
  level.vh_vtol endon("death");

  if(isDefined(level.ai_defalco_escort2))
    level.ai_defalco_escort2 delete();

  level thread setup_ambience();
  wait 1;
  maps\karma_the_end::launch_escape_vehicle();
  level thread set_objective_on_vtol();
  level.vh_vtol waittill("reached_end_node");
}

defalco_escape_end_mission(e_ent) {
  level.player set_story_stat("KARMA_CAPTURED", 1);
  next_mission(0.7);
}

defalco_helipad_pip(str_structname, str_scene_name) {
  level notify("stop_naglines");
  dialog_start_convo();
  level thread pip_karma_event("pip_helipad_v2");
  flag_wait("glasses_bink_playing");
  level.player priority_dialog("fari_you_guys_need_to_pic_0");
  level.player priority_dialog("fari_defalco_s_gone_to_a_0");
  level.player priority_dialog("fari_he_will_not_hesitate_0");
  dialog_end_convo();
}

set_objective_on_vtol() {
  level.ai_defalco waittill("death");
  set_objective(level.obj_stop_defalco, level.vh_vtol, & "KARMA_2_OBJ_3D_DEFALCO", undefined, 0, 0.05);
}

defalco_escape_vehicle_callback(einflictor, eattacker, idamage, idflags, type, sweapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname) {
  if(issubstr(tolower(type), "bullet"))
    idamage = 0;
  else if(type == "MOD_EXPLOSIVE" || type == "MOD_PROJECTILE" || type == "MOD_GRENADE")
    idamage = 99999;

  return idamage;
}

setup_ambience() {
  setup_cagelight_fx("cagelight");
  setup_vtol_escape_amb();
  setup_boat_escape_amb();
  flag_wait("vtol_doors_start_closing");
  stop_exploder(1010);
}

setup_cagelight_fx(str_light_targetname) {
  a_cagelights = get_ent_array(str_light_targetname, "targetname");

  foreach(m_light in a_cagelights)
  m_light thread delay_cagelight_fx();
}

delay_cagelight_fx() {
  self script_delay();
  playfxontag(level._effect["light_caution_red_flash"], self, "tag_origin");
}

setup_vtol_escape_amb() {
  nd_v_start_array = getvehiclenodearray("e10_vtol_escape_start_node", "targetname");

  while(true) {
    for(i = 0; i < nd_v_start_array.size; i++) {
      vtol = maps\_vehicle::spawn_vehicle_from_targetname("e10_vtol_escape_spawner");
      vtol thread go_path(nd_v_start_array[i]);
      vtol thread delete_on_end_node();
      playfxontag(level._effect["vtol_exhaust"], vtol, "tag_origin");
      wait(randomintrange(2, 5));
    }

    wait(randomintrange(2, 5));
  }
}

setup_boat_escape_amb() {
  nd_v_start_array = getvehiclenodearray("e10_boat_escape_node", "targetname");

  while(true) {
    for(i = 0; i < nd_v_start_array.size; i++) {
      boat = maps\_vehicle::spawn_vehicle_from_targetname("e10_escape_boat_spawner");
      boat thread go_path(nd_v_start_array[i]);
      boat thread delete_on_end_node();
      wait(randomintrange(2, 5));
    }

    wait(randomintrange(2, 5));
  }
}

delete_on_end_node() {
  self waittill("reached_end_node");
  self delete();
}