/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\yemen_utility.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_objectives;
#include maps\_vehicle;
#include maps\_scene;
#include maps\_skipto;
#include maps\_dialog;
#include maps\yemen_market;
#include animscripts\shared;

skipto_setup() {
  load_gumps();
  skipto = level.skipto_point;

  if(skipto == "intro") {
    return;
  }
  if(skipto == "speech") {
    return;
  }
  flag_set("player_turn");
  flag_set("player_turns_back");
  flag_set("menendez_exited");

  if(skipto == "market") {
    return;
  }
  level thread maps\yemen_market::vo_market();

  if(skipto == "terrorist_hunt") {
    return;
  }
  if(skipto == "metal_storms") {
    return;
  }
  end_market_vo();

  if(skipto == "morals") {
    return;
  }
  flag_set("morals_start");

  if(skipto == "drone_control") {
    return;
  }
  if(skipto == "hijacked") {
    return;
  }
  if(skipto == "capture")
    return;
}

load_gumps() {
  screen_fade_out(0);

  if(is_after_skipto("morals"))
    load_gump("yemen_gump_outskirts");
  else if(is_after_skipto("terrorist_hunt"))
    load_gump("yemen_gump_morals");
  else if(is_after_skipto("speech"))
    load_gump("yemen_gump_speech");
  else
    load_gump("yemen_gump_speech");

  screen_fade_in(0);
}

give_scene_models_guns(str_scene) {
  a_models = get_model_or_models_from_scene(str_scene);

  foreach(m_guy in a_models)
  m_guy attach("t6_wpn_ar_an94_world", "tag_weapon_right");
}

show_my_gun() {
  while(true) {
    wait 1;
    level thread draw_debug_line(self gettagorigin("tag_flash"), self gettagorigin("tag_eye"), 1);
    print3d(self gettagorigin("tag_flash"), self.animname, (1, 0, 0), 1, 0.1, 60);
  }

}

teamswitch_threatbias_setup() {
  createthreatbiasgroup("player");
  createthreatbiasgroup("yemeni");
  createthreatbiasgroup("yemeni_friendly");
  createthreatbiasgroup("terrorist");
  createthreatbiasgroup("terrorist_team3");
  setthreatbias("player", "yemeni", 2500);
  setthreatbias("player", "yemeni_friendly", 2500);
  setthreatbias("terrorist", "yemeni", 1500);
  setthreatbias("terrorist", "yemeni_friendly", 1500);
  setthreatbias("terrorist_team3", "yemeni", 1500);
  setthreatbias("terrorist_team3", "yemeni_friendly", 1500);
  setthreatbias("yemeni", "terrorist", 1500);
  setthreatbias("yemeni_friendly", "terrorist", 1500);
  setthreatbias("terrorist_team3", "terrorist", -15000);
  setthreatbias("terrorist", "terrorist_team3", -15000);
  setthreatbias("player", "terrorist_team3", 15000);
  setthreatbias("yemeni", "terrorist_team3", 1000);
  setthreatbias("yemeni_friendly", "terrorist_team3", 1000);
  setsaveddvar("g_friendlyfireDist", 0);
}

terrorist_debug_spawnfunc() {
  self endon("death");

  while(true) {
    print3d(self.origin, "T", (1, 0, 0), 1, 1, 1);
    wait 0.05;
  }

}

yemeni_teamswitch_spawnfunc() {
  self.team = "axis";
  self set_fixednode(0);
  self enableaimassist();
}

yemeni_bft_highlight() {
  m_fx_origin = spawn_model("tag_origin", self gettagorigin("J_SpineLower"), (0, 0, 0));
  m_fx_origin linkto(self, "J_SpineLower");
  playfxontag(getfx("friendly_marker"), m_fx_origin, "tag_origin");
  self waittill("death");
  m_fx_origin delete();
}

yemeni_watch_player_damage() {
  while(isalive(self)) {
    self waittill("damage", damage, e_attacker);

    if(isplayer(e_attacker)) {
      if(damage >= self.health)
        level notify("player_killed_yemeni");

      level notify("_player_attacked_yemeni_");
      level thread yemeni_player_damage_flag();
    }
  }
}

yemeni_player_damage_flag() {
  flag_set("player_attacked_yemeni");
  level endon("_player_attacked_yemeni_");
  wait 3;
  flag_clear("player_attacked_yemeni");
}

terrorist_teamswitch_spawnfunc() {
  self endon("death");
  self.team = "allies";
  self disableaimassist();
}

terrorist_teamswitch_think() {
  self endon("death");
  self.team = "axis";
  self.favoriteenemy = level.player;
  self enableaimassist();
  self animcustom(::terrorist_teamswitch_reaction);
}

#using_animtree("generic_human");

terrorist_teamswitch_reaction() {
  self endon("death");
  self orientmode("face point", level.player.origin);
  anim_reaction = array( % ai_exposed_backpedal, % ai_exposed_idle_react_b);
  self clearanim( % root, 0.2);
  self setflaggedanimknobrestart("reactanim", random(anim_reaction), 1, 0.2, 1);
  self animscripts\shared::donotetracks("reactanim");
}

detect_player_attacker() {
  level endon("kill_market_vo");

  while(true) {
    self waittill("damage", damage, e_attacker);

    if(isDefined(e_attacker.is_yemeni) && e_attacker.is_yemeni)
      level thread yemeni_fire_at_player_flag();
    else if(isDefined(e_attacker.classname) && e_attacker.classname == "script_vehicle")
      level thread robot_fire_at_player_flag();
    else if(!isDefined(e_attacker.team) && !isDefined("team3") || isDefined(e_attacker.team) && isDefined("team3") && e_attacker.team == "team3")
      level thread terrorist_fire_at_player_flag();
  }
}

yemeni_fire_at_player_flag() {
  level notify("_yemeni_attacked_player_");
  flag_set("yemeni_attacked_player");
  level endon("_yemeni_attacked_player");
  wait 3;
  flag_clear("yemeni_attacked_player");
}

robot_fire_at_player_flag() {
  level notify("_robot_attacked_player_");
  flag_set("robot_attacked_player");
  level endon("_robot_attacked_player_");
  wait 3;
  flag_clear("robot_attacked_player");
}

terrorist_fire_at_player_flag() {
  level notify("_terrorist_attacked_player_");
  flag_set("terrorist_attacked_player");
  level endon("_terrorist_attacked_player_");
  wait 3;
  flag_clear("terrorist_attacked_player");
}

terrorist_player_damage_flag() {
  level notify("_player_attacked_terrorists_");
  wait 2;
  flag_set("player_attacked_terrorists");
  level endon("_player_attacked_terrorists_");
  wait 3;
  flag_clear("player_attacked_terrorists");
}

terrorist_player_death_flag() {
  level notify("_player_killed_terrorists_");
  wait 2;
  flag_set("player_killed_terrorists");
  level endon("_player_killed_terrorists_");
  wait 3;
  flag_clear("player_killed_terrorists");
}

yemeni_teamswitch_radio_callout() {
  a_yemeni_callouts[0] = "Yemeni: Watch your fire, we have a friendly";
  a_yemeni_callouts[1] = "Yemeni: Our agent has been sighted, be careful";
  a_yemeni_callouts[2] = "Yemeni: Check your fire, he's on our side";

  while(true) {
    level waittill("yemeni_detected_farid");
    wait 0.5;
    n_callout_index = randomint(a_yemeni_callouts.size);
    wait 5;
  }
}

temp_vtol_stop_and_rappel() {
  a_rappel_nodes = getvehiclenodearray("vtol_rappel_spot", "script_noteworthy");
  array_thread(a_rappel_nodes, ::temp_vtol_rappel_start);
}

temp_vtol_rappel_start() {
  self waittill("trigger", veh_vtol);
  n_speed = veh_vtol getspeed();
  veh_vtol setspeed(0, 50, 50);
  str_rappel_spawner_targetname = self.script_string + "_rappelers";
  str_rappel_start_targetname = self.script_string + "_start";
  level thread temp_vtol_rappel_guys(str_rappel_start_targetname, str_rappel_spawner_targetname);
  wait 5;
  veh_vtol setspeed(n_speed);
  veh_vtol waittill("goal");
  veh_vtol delete();
}

temp_vtol_rappel_guys(str_struct_starts, str_rappeler) {
  a_start_structs = getstructarray(str_struct_starts, "targetname");
  sp_rappeler = getent(str_rappeler, "targetname");

  foreach(s_rappel_start in a_start_structs) {
    ai_guy = sp_rappeler spawn_ai(1);

    if(isDefined(ai_guy))
      ai_guy thread temp_vtol_rappel_guy(s_rappel_start);

    wait 0.5;
  }
}

temp_vtol_rappel_guy(s_rappel_start) {
  self endon("death");
  s_rappel_end = getstruct(s_rappel_start.target, "targetname");
  nd_goal = getnode(s_rappel_end.target, "targetname");
  m_mover = spawn("script_origin", self.origin);
  self linkto(m_mover);
  m_mover.origin = s_rappel_start.origin;
  m_mover moveto(s_rappel_end.origin, 2, 0.5, 0.5);
  m_mover waittill("movedone");
  self unlink();
  self setgoalnode(nd_goal);
}

spawn_quadrotors_at_structs(str_struct_name, str_noteworthy, b_copy_noteworthy) {
  if(!isDefined(b_copy_noteworthy))
    b_copy_noteworthy = 0;

  a_spots = getstructarray(str_struct_name, "targetname");
  a_qrotors = [];

  foreach(s_spot in a_spots) {
    vh_qrotor = spawn_vehicle_from_targetname("yemen_quadrotor_spawner");
    vh_qrotor.origin = s_spot.origin;
    vh_qrotor.goalpos = s_spot.origin;

    if(isDefined(str_noteworthy))
      vh_qrotor.script_noteworthy = str_noteworthy;
    else if(is_true(b_copy_noteworthy))
      vh_qrotor.script_noteworthy = s_spot.script_noteworthy;

    arrayinsert(a_qrotors, vh_qrotor, a_qrotors.size);
  }

  array_delete(a_spots, 1);
  return a_qrotors;
}

spawn_vtols_at_structs(str_struct_name, str_nd_name) {
  a_spots = getstructarray(str_struct_name, "targetname");

  foreach(s_spot in a_spots) {
    v_vtol = spawn_vehicle_from_targetname("yemen_drone_control_vtol_spawner");

    if(isDefined(str_nd_name) || isDefined(s_spot.target)) {
      if(isDefined(s_spot.target))
        str_nd_name = s_spot.target;

      v_vtol go_path(getvehiclenode(str_nd_name, "targetname"));
      continue;
    }

    v_vtol.origin = s_spot.orign;
    v_vtol.angles = s_spot.angles;
  }
}

init_hero_startstruct(str_hero_name, str_struct_targetname) {
  ai_hero = init_hero(str_hero_name);
  s_start_pos = getstruct(str_struct_targetname, "targetname");
  assert(isDefined(s_start_pos), "Bad Hero setup struct: " + str_struct_targetname);

  if(isDefined(s_start_pos.angles))
    v_angles = s_start_pos.angles;
  else
    v_angles = (0, 0, 0);

  ai_hero forceteleport(s_start_pos.origin, v_angles);
  ai_hero.radius = 32;
  return ai_hero;
}

teleport_ai_to_pos(v_teleport_pos, v_teleport_angles) {
  if(isDefined(v_teleport_angles))
    self forceteleport(v_teleport_pos, v_teleport_angles);
  else
    self forceteleport(v_teleport_pos);

  self setgoalpos(v_teleport_pos);
}

switch_player_to_mason(dead_param) {
  level.player_viewmodel = "c_usa_cia_masonjr_armlaunch_viewhands";
  level.player_interactive_model = "c_usa_cia_masonjr_viewbody";
  level.player_camo_viewmodel = "c_usa_cia_masonjr_viewhands_cl";
  level.player setviewmodel(level.player_viewmodel);
}

cleanup(str_value, str_key) {
  if(!isDefined(str_key))
    str_key = "targetname";

  array = getentarray(str_value, str_key);

  foreach(ent in array) {
    if(isDefined(ent.classname) && ent.classname == "script_vehicle") {
      ent.delete_on_death = 1;
      ent notify("death");

      if(!isalive(ent))
        ent delete();

      continue;
    }

    ent delete();
  }
}

turn_off_vehicle_exhaust(veh) {
  veh veh_toggle_exhaust_fx(0);
}

turn_off_vehicle_tread_fx(veh) {
  veh veh_toggle_tread_fx(0);
}

rotate_continuously(rev_per_second, end_on_notify) {
  if(isDefined(end_on_notify))
    level endon(end_on_notify);

  while(true) {
    self rotateyaw(360 * rev_per_second, 1.0, 0.0, 0.0);
    wait 0.9;
  }
}

spawn_func_player_damage_only() {
  self.overrideactordamage = ::take_player_damage_only;
}

take_player_damage_only(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, modelindex, psoffsettime, bonename) {
  if(!isplayer(eattacker))
    idamage = 0;

  return idamage;
}

take_player_damage_only_for_time(n_time) {
  self endon("death");
  self.overrideactordamage = ::take_player_damage_only;
  wait(n_time);
  self.overrideactordamage = undefined;
}

take_player_damage_only_for_scene(str_scene) {
  self endon("death");
  self.overrideactordamage = ::take_player_damage_only;
  scene_wait(str_scene);
  self.overrideactordamage = undefined;
}

get_offset_scale(i) {
  if(i % 2 == 0)
    return i / 2 * -1;
  else
    return i - i / 2 + 0.5;
}

notetrack_drone_shoot(drone_model) {
  if(isDefined(drone_model)) {
    pos = drone_model gettagorigin("tag_flash");
    orient = drone_model gettagangles("tag_flash");
    fwd = anglestoforward(orient);
    magicbullet("an94_sp", pos, pos + fwd * 100);
    drone_model play_fx("drone_weapon_flash", pos, orient, undefined, 1, "tag_flash");
  }
}

end_market_vo() {
  level notify("kill_market_vo");
  dialog_end_convo();
}

do_mason_custom_intro_screen() {
  yemen_custom_introscreen2();
}

yemen_custom_introscreen2(level_prefix, number_of_lines, totaltime, text_color) {
  if(!isDefined(level_prefix))
    level_prefix = "YEMEN_MASON";

  if(!isDefined(number_of_lines))
    number_of_lines = 5;

  if(!isDefined(totaltime))
    totaltime = 14;

  if(!isDefined(text_color))
    text_color = 0;

  luinotifyevent(&"hud_add_title_line", 4, istring(level_prefix), number_of_lines, totaltime, text_color);
  wait 2.5;
}

array_remove(ent, array) {
  new_array = [];

  foreach(elem in array) {
    if(elem != ent)
      new_array[new_array.size] = elem;
  }

  return new_array;
}

array_delete_ai_from_noteworthy(noteworthy, b_los_check) {
  if(!isDefined(b_los_check))
    b_los_check = 0;

  ai_dudes = get_ai_array(noteworthy, "script_noteworthy");

  if(b_los_check) {
    foreach(dude in ai_dudes)
    dude thread ai_delete_when_offscreen();
  } else
    array_delete(ai_dudes);
}

ai_delete_when_offscreen() {
  level.player endon("death");
  self endon("death");
  self endon("delete");
  angle = getdvarint(#"cg_fov");
  cos_angle = cos(angle);
  forward = anglestoforward(level.player.angles);

  for(ai_to_player = vectornormalize(self.origin - level.player.origin); vectordot(forward, ai_to_player) >= cos_angle; ai_to_player = vectornormalize(self.origin - level.player.origin)) {
    wait 0.1;
    forward = anglestoforward(level.player.angles);
  }

  self delete();
}

get_alive_from_noteworthy(noteworthy) {
  ai_array = getentarray(noteworthy, "script_noteworthy");
  new_array = [];

  foreach(ent in ai_array) {
    if(isDefined(ent) && !isspawner(ent))
      new_array[new_array.size] = ent;
  }

  return new_array;
}

get_axis_in_volume(volume) {
  enemies = getaiarray("axis");
  enemies_new = [];

  foreach(enemy in enemies) {
    if(enemy istouching(volume))
      enemies_new[enemies_new.size] = enemy;
  }

  return enemies_new;
}

simple_spawn_script_delay(a_ents, spawn_fn, param1, param2, param3, param4, param5) {
  for(i = 0; i < a_ents.size; i++) {
    e_ent = a_ents[i];

    if(isDefined(e_ent.script_delay)) {
      level thread spawn_with_delay(e_ent.script_delay, e_ent, spawn_fn, param1, param2, param3, param4, param5);
      continue;
    }

    e_ai = simple_spawn_single(e_ent, spawn_fn, param1, param2, param3, param4, param5, 1);

    if(isDefined(e_ent.script_float))
      e_ai.accuracy = e_ent.script_float;
  }
}

spawn_with_delay(delay, e_ent, spawn_fn, param1, param2, param3, param4, param5) {
  wait(delay);
  e_ai = simple_spawn_single(e_ent, spawn_fn, param1, param2, param3, param4, param5);

  if(isDefined(e_ent.script_float))
    e_ai.accuracy = e_ent.script_float;
}

spawn_fn_ai_run_to_target(player_favourate_enemy, str_cleanup_category, aggressive_mode, disable_grenades, ignore_me) {
  self endon("death");

  if(isDefined(ignore_me) && ignore_me == 1)
    self.ignoreme = 1;

  self entity_common_spawn_setup(player_favourate_enemy, str_cleanup_category, 0, disable_grenades);

  self.goalradius = 48;
  self waittill("goal");
  self.aggressivemode = aggressive_mode;
  self.goalradius = 2048;
}

entity_common_spawn_setup(player_favourate_enemy, str_cleanup_category, ignore_surpression, disable_grenades) {
  if(isDefined(player_favourate_enemy) && player_favourate_enemy != 0)
    self.favoriteenemy = level.player;

  if(isDefined(str_cleanup_category))
    spawner_set_cleanup_category(str_cleanup_category);

  if(isDefined(ignore_surpression) && ignore_surpression != 0)
    self.script_ignore_suppression = 1;

  if(isDefined(disable_grenades) && disable_grenades != 0)
    self.grenadeammo = 0;
}

add_cleanup_ent(str_category, e_add) {
  if(!isDefined(level.a_e_cleanup))
    level.a_e_cleanup = [];

  if(!isDefined(level.a_e_cleanup[str_category]))
    level.a_e_cleanup[str_category] = [];

  level.a_e_cleanup[str_category][level.a_e_cleanup[str_category].size] = e_add;
}

cleanup_ents(str_category) {
  if(isDefined(level.a_e_cleanup) && isDefined(level.a_e_cleanup[str_category])) {
    foreach(ent in level.a_e_cleanup[str_category]) {
      if(isDefined(ent))
        ent delete();
    }

    level.a_e_cleanup[str_category] = undefined;
  }
}

spawner_set_cleanup_category(str_category) {
  add_cleanup_ent(str_category, self);
}