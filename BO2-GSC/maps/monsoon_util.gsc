/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\monsoon_util.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_dynamic_nodes;
#include maps\_objectives;
#include maps\_vehicle;
#include maps\_vehicle_aianim;
#include maps\_skipto;
#include maps\_scene;
#include maps\_anim;
#include maps\_dialog;
#include maps\createart\monsoon_art;
#include maps\monsoon_intro;
#include maps\monsoon_wingsuit;
#include maps\monsoon_ruins;
#include maps\monsoon_lab;
#include maps\monsoon_lab_defend;
#include maps\monsoon_celerium_chamber;
#include maps\_challenges_sp;
#include maps\_camo_suit;
#include maps\_metal_storm;
#include maps\_fxanim;

skipto_setup() {
  waittill_textures_loaded();
  load_gumps_monsoon();
  skipto = level.skipto_point;

  if(skipto == "intro") {
    return;
  }
  flag_set("intro_goggles_off");
  level thread maps\createart\monsoon_art::harper_reveal_vision();
  level.player resetplayerviewratescale();

  if(skipto == "harper_reveal") {
    return;
  }
  flag_set("start_level_objectives");

  if(skipto == "rock_swing") {
    return;
  }
  flag_set("jet_stream_launch_obj");
  flag_set("player_equipped_suit");
  flag_set("squad_equipped_suits");
  flag_set("cliff_swing_6_player_done");

  if(skipto == "suit_jump") {
    return;
  }
  flag_set("jet_stream_launch_obj_complete");

  if(skipto == "suit_flying") {
    return;
  }
  level thread maps\createart\monsoon_art::exterior_vision();
  flag_set("wingsuit_player_landed");
  setsaveddvar("r_skyTransition", 1);

  if(skipto == "camo_intro") {
    return;
  }
  flag_set("wingsuit_player_landed");
  flag_set("predator_intro_started");
  flag_set("predator_intro_scene_done");

  if(skipto == "camo_battle") {
    return;
  }
  flag_set("player_reached_helipad");

  if(skipto == "helipad_battle") {
    return;
  }
  flag_set("player_reached_outer_ruins");

  if(skipto == "outer_ruins") {
    return;
  }
  flag_set("player_past_turrets");

  if(skipto == "inner_ruins") {
    return;
  }
  level thread maps\createart\monsoon_art::interior_ruins_vision();
  flag_set("player_reached_temple_entrance");
  flag_set("ruins_door_destroyed");

  if(skipto == "ruins_interior") {
    return;
  }
  if(skipto == "lab") {
    return;
  }
  flag_set("start_asd_battle");
  flag_set("obj_lab_entrance_regroup");
  flag_set("player_at_lab_entrance");
  flag_set("lab_entrance_open");
  flag_set("player_at_clean_room");
  flag_set("lab_clean_room_open");
  flag_set("start_player_asd_anim");
  flag_set("end_player_asd_anim");
  flag_set("asd_tutorial_died");
  flag_set("spawn_lobby_guys");
  flag_set("lab_lobby_doors");

  if(skipto == "lab_battle") {
    return;
  }
  flag_set("start_lift_move_up");
  flag_set("elevator_is_ready");
  flag_set("start_lift_move_down");
  flag_set("lift_at_top");
  flag_set("set_lift_objective");
  flag_set("lift_at_bottom");
  flag_set("spawn_nitrogen_guys");
  flag_set("start_shooting_lift");

  if(skipto == "fight_to_isaac") {
    return;
  }
  flag_set("set_ddm_objective");
  flag_set("start_lab_defend");
  flag_set("player_at_ddm");

  if(skipto == "lab_defend") {
    return;
  }
  flag_set("heroes_fallback");
  flag_set("player_at_ddm");
  flag_set("set_obj_help_isaac");
  flag_set("player_at_isaac");
  flag_set("isaac_defend_start");
  flag_set("lab_defend_done");
  flag_set("start_asd_wall_crash");
  flag_set("lab_lobby_doors");

  if(skipto == "celerium_chamber")
    return;
}

load_gumps_monsoon() {
  if(is_after_skipto("ruins_interior"))
    load_gump("monsoon_gump_interior");
  else
    load_gump("monsoon_gump_exterior");
}

setup_objectives() {
  level.obj_salazar_crosby = register_objective(&"MONSOON_OBJ_SALAZAR_CROSBY");
  level.obj_intro_leap = register_objective(&"MONSOON_OBJ_INTRO_LEAP");
  level.obj_wingsuit_land = register_objective(&"MONSOON_OBJ_WINGSUIT_LAND");
  level.obj_reach_lab = register_objective(&"MONSOON_OBJ_REACH_LAB");
  level.obj_destroy_door = register_objective(&"MONSOON_OBJ_DESTROY_DOOR");
  level.obj_infiltrate_lab = register_objective(&"MONSOON_OBJ_INFILTRATE_LAB");
  level.obj_infiltrate_lower_lab = register_objective(&"MONSOON_OBJ_LOWER_LABS");
  level.obj_open_container = register_objective(&"MONSOON_OBJ_OPEN_CONTAINER");
  level.obj_lab_defend = register_objective(&"MONSOON_OBJ_LAB_DEFEND");
  level.obj_open_vault = register_objective(&"MONSOON_OBJ_OPEN_VAULT");
  level.obj_obtain_celerium = register_objective(&"MONSOON_OBJ_OBTAIN_CELERIUM");
  level.obj_celerium_drive = register_objective(&"MONSOON_OBJ_CELERIUM_DRIVE");
  level.obj_escape_lab = register_objective(&"MONSOON_OBJ_ESCAPE_LAB");
  level.obj_intruder = register_objective("");
  level.obj_lockbreaker = register_objective("");
  level.obj_bruteforce = register_objective("");
  level thread monsoon_objectives();
}

monsoon_objectives() {
  objectives_intro();
  objectives_ruins();
  objectives_lab();
}

objectives_intro() {
  flag_wait("start_level_objectives");
  set_objective(level.obj_salazar_crosby);
  flag_wait("cliff_swing_6_player_done");
  set_objective(level.obj_salazar_crosby, undefined, "done");
  flag_wait("jet_stream_launch_obj");
  set_objective(level.obj_intro_leap, getstruct("obj_squirrel_jump", "targetname").origin, "breadcrumb");
  flag_wait("jet_stream_launch_obj_complete");
  set_objective(level.obj_intro_leap, undefined, "delete");
}

objectives_ruins() {
  flag_wait("wingsuit_player_landed");
  set_objective(level.obj_reach_lab, level.harper, "follow");
  flag_wait("predator_intro_started");
  set_objective(level.obj_reach_lab, undefined, "remove");
  flag_wait("predator_intro_scene_done");
  set_objective(level.obj_reach_lab, getent("obj_helipad", "targetname"));
  flag_wait("player_reached_helipad");
  set_objective(level.obj_reach_lab, getent("obj_temple", "targetname"));
  flag_wait("player_reached_temple_entrance");
  set_objective(level.obj_reach_lab, undefined, "remove");
  flag_wait("ruins_door_destroyed");
  set_objective(level.obj_reach_lab, getent("obj_ruins_interior", "targetname"), "breadcrumb");
  flag_wait("obj_lab_entrance_regroup");
  set_objective(level.obj_reach_lab, undefined, "done");
}

objectives_lab() {
  set_objective(level.obj_infiltrate_lab, getstruct("obj_infiltrate_lab"), "breadcrumb");
  flag_wait("player_at_lab_entrance");
  set_objective(level.obj_infiltrate_lab, undefined, "remove");
  flag_wait("lab_entrance_open");
  set_objective(level.obj_infiltrate_lab, getstruct("obj_clean_room"), "breadcrumb");
  flag_wait("player_at_clean_room");
  set_objective(level.obj_infiltrate_lab, undefined, "remove");
  flag_wait("set_lift_objective");
  set_objective(level.obj_infiltrate_lab, getstruct("obj_interior_elevator"), "breadcrumb");
  flag_wait("start_lift_move_up");
  set_objective(level.obj_infiltrate_lab, getstruct("obj_interior_elevator"), "remove");
  flag_wait("elevator_is_ready");
  set_objective(level.obj_infiltrate_lab, undefined, "done");
  set_objective(level.obj_infiltrate_lower_lab, getstruct("obj_elevator_panel"), "breadcrumb");
  flag_wait("start_lift_move_down");
  set_objective(level.obj_infiltrate_lower_lab, undefined, "remove");
  flag_wait("set_ddm_objective");
  set_objective(level.obj_infiltrate_lower_lab, getstruct("obj_ddm_regroup"), "breadcrumb");
  flag_wait("player_at_ddm");
  set_objective(level.obj_infiltrate_lower_lab, undefined, "remove");
  wait 0.1;
  set_objective(level.obj_infiltrate_lower_lab, undefined, "delete");
  flag_wait("set_obj_help_isaac");
  set_objective(level.obj_open_container, getstruct("obj_help_isaac"), "breadcrumb");
  flag_wait("player_at_isaac");
  set_objective(level.obj_open_container, getstruct("obj_help_isaac"), "remove");
  set_objective(level.obj_open_container, undefined, "delete");
  flag_wait("isaac_defend_start");
  set_objective(level.obj_lab_defend);
  flag_wait("lab_defend_done");
  set_objective(level.obj_lab_defend, undefined, "delete");
  flag_wait("set_celerium_door_obj");
  set_objective(level.obj_open_vault, getstruct("obj_player_celerium_door"), "breadcrumb");
  flag_wait("player_triggered_celerium_door");
  set_objective(level.obj_open_vault, getstruct("obj_player_celerium_door"), "remove");
  set_objective(level.obj_open_vault, undefined, "delete");
  flag_wait("set_celerium_chip_obj");
  set_objective(level.obj_celerium_drive, getstruct("obj_celerium_chip"), "breadcrumb");
  wait 0.1;
  objective_setflag(level.obj_celerium_drive, "fadeoutonscreen", 1);
  flag_wait("remove_celerium_breadcrumb");
  set_objective(level.obj_celerium_drive, getstruct("obj_celerium_chip"), "remove");
  flag_wait("celerium_event_done");
  set_objective(level.obj_celerium_drive, undefined, "done");
  flag_wait("isaacs_killers_cleared");
  set_objective(level.obj_escape_lab, getstruct("obj_escape_1"), "breadcrumb");
  flag_wait("spawn_escape_path_guys");
  set_objective(level.obj_escape_lab, getstruct("obj_escape_1"), "remove");
  flag_wait("escape_path_guys_cleared");
  set_objective(level.obj_escape_lab, getstruct("obj_escape_2"), "breadcrumb");
  flag_wait("player_asd_stairs_pos");
  set_objective(level.obj_escape_lab, getstruct("obj_escape_2"), "remove");
  set_objective(level.obj_escape_lab, getstruct("obj_escape_3"), "breadcrumb");
  flag_wait("open_top_stairs_doors");
  set_objective(level.obj_escape_lab, getstruct("obj_escape_3"), "remove");
  flag_wait("top_stairs_guys_cleared");
  set_objective(level.obj_escape_lab, getstruct("obj_escape_4"), "breadcrumb");
  flag_wait("set_briggs_breadcrumb");
  set_objective(level.obj_escape_lab, getstruct("obj_escape_4"), "remove");
  set_objective(level.obj_escape_lab, getstruct("obj_escape_5"), "breadcrumb");
  flag_wait("spawn_briggs_scene");
  set_objective(level.obj_escape_lab, getstruct("obj_escape_5"), "remove");
  flag_wait("briggs_in_position");
  set_objective(level.obj_escape_lab, getstruct("s_brigg_celerium_obj"), "breadcrumb");
  flag_wait("celerium_obj_done");
  set_objective(level.obj_escape_lab, getstruct("s_brigg_celerium_obj"), "remove");
}

level_init_flags() {
  flag_init("show_introscreen_title");
  flag_init("monsoon_gump_interior");
  flag_init("monsoon_gump_exterior");
  flag_init("monsoon_is_raining");
  flag_init("intruder_perk_used");
  flag_init("brute_force_perk_used");
  flag_init("lock_breaker_perk_used");
  flag_init("player_asd_died");
  flag_init("player_asd_stairs_pos");
  maps\monsoon_intro::init_intro_flags();
  maps\monsoon_wingsuit::init_wingsuit_flags();
  maps\monsoon_ruins::init_ruins_flags();
  maps\monsoon_lab::init_lab_flags();
  maps\monsoon_lab_defend::init_lab_defend_flags();
  maps\monsoon_celerium_chamber::init_celerium_flags();
}

monsoon_hero_rampage(b_on) {
  if(b_on) {
    self.oldgrenadeawareness = self.grenadeawareness;
    self.grenadeawareness = 0;
    self.ignoresuppression = 1;
    self disable_react();
    self disable_careful();
  } else {
    if(isDefined(self.oldgrenadeawareness)) {
      self.grenadeawareness = self.oldgrenadeawareness;
      self.oldgrenadeawareness = undefined;
    }

    self.ignoresuppression = 0;
    self enable_react();
    self enable_careful();
  }
}

set_squad_blood_impact(str_value) {
  foreach(hero in get_heroes())
  hero bloodimpact(str_value);
}

weaken_ai() {
  self.health = 1;
  self.attackeraccuracy = 10;
}

player_has_silenced_weapon() {
  a_current_weapons = self getweaponslist();

  foreach(weapon in a_current_weapons) {
    if(issubstr(weapon, "silencer"))
      return true;
  }

  return false;
}

player_has_explosive_weapon_equipped() {
  a_wpn_exp[0] = "exptitus6_sp";
  a_wpn_exp[1] = "titus6_sp";
  a_wpn_exp[2] = "rpg_player_sp";
  a_wpn_exp[3] = "afghanstinger_sp";
  a_wpn_exp[4] = "m32_sp";
  a_wpn_exp[5] = "usrpg_player_sp";
  a_wpn_exp[6] = "mgl_sp";

  for(i = 0; i < a_wpn_exp.size; i++) {
    if(self getcurrentweapon() == a_wpn_exp[i]) {
      if(self getammocount(a_wpn_exp[i]))
        return true;
    }
  }

  return false;
}

player_titus_tutorial() {
  self endon("death");
  self endon("tutorial_complete");

  if(self hasweapon("titus6_sp")) {
    while(true) {
      while(self getcurrentweapon() != "titus6_sp")
        wait 0.05;

      screen_message_create(&"MONSOON_TUTORIAL_TITUS");
      self thread _player_titus_tutorial_watch();

      while(self getcurrentweapon() == "titus6_sp")
        wait 0.05;

      self notify("weapon_switched");
      screen_message_delete();
      wait 0.05;
    }
  }
}

_player_titus_tutorial_watch() {
  self endon("weapon_switched");

  while(!self actionslotthreebuttonpressed())
    wait 0.05;

  self notify("tutorial_complete");
  screen_message_delete();
}

setup_camo_suit_ai() {
  if(!issubstr(tolower(self.classname), "camo")) {
    return;
  }
  self ent_flag_init("camo_suit_on");
  self ent_flag_set("camo_suit_on");
  self.camo_sound_ent = spawn("script_origin", self.origin);
  self.camo_sound_ent linkto(self, "tag_origin");
  self playsound("fly_camo_suit_npc_on", self.origin);
  self.camo_sound_ent playloopsound("fly_camo_suit_npc_loop", 0.5);
  self.canflank = 1;
  self.aggressivemode = 1;
  self.moveplaybackrate = 1.3;
  self.a.disablewoundedset = 1;
  self.health = 150;
  self thread camo_emp_behavior();

  if(issubstr(tolower(self.classname), "sniper"))
    self.has_ir = 1;
}

deathfunction_clear_camo() {
  if(self ent_flag_exist("camo_suit_on") && self ent_flag("camo_suit_on")) {
    self toggle_camo_suit(1);
    self playsound("fly_camo_suit_npc_off", self.origin);

    if(isDefined(self.camo_sound_ent)) {
      self.camo_sound_ent stoploopsound(1);
      self.camo_sound_ent delete();
    }
  }
}

camo_emp_behavior() {
  self endon("death");

  while(true) {
    self waittill("doEmpBehavior", attacker, duration);
    self.blockingpain = 1;
    self toggle_camo_suit(1);
    wait(duration);
    self toggle_camo_suit(0);
    self.blockingpain = 0;
  }
}

setup_gasfreeze_ai() {
  self.deathfunction = ::handle_special_ai_death;
}

handle_special_ai_death() {
  handle_gasfreeze_ai_death();
  deathfunction_clear_camo();
  return false;
}

handle_gasfreeze_ai_death() {
  if(self.damagemod != "MOD_GAS")
    return false;

  if(!self ent_flag_exist("camo_suit_on"))
    self setclientflag(10);

  return false;
}

toggle_camo_suit(b_on, b_play_fx) {
  if(!isDefined(b_play_fx))
    b_play_fx = 1;

  if(!issubstr(tolower(self.classname), "camo")) {
    return;
  }
  if(b_on) {
    self setclientflag(12);
    self ent_flag_clear("camo_suit_on");
  } else {
    self clearclientflag(12);
    self ent_flag_set("camo_suit_on");
  }

  if(b_play_fx)
    playfxontag(getfx("camo_transition"), self, "J_SpineLower");
}

lerp_vision(n_lerp_time, n_fov, n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur) {
  if(!isDefined(n_fov)) {
    n_fov = getdvarfloat(#"cg_fov_default");
    n_near_start = 0.1;
    n_near_end = 0.6;
    n_far_start = 1;
    n_far_end = 6;
    n_near_blur = 0;
    n_far_blur = 0;
  }

  self thread lerp_fov_overtime(n_lerp_time, n_fov);
  self thread depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_lerp_time);
  wait(n_lerp_time);
}

setup_challenges() {
  self thread maps\_challenges_sp::register_challenge("nodeath", ::challenge_nodeath);
  self thread maps\_challenges_sp::register_challenge("tituskills", ::challenge_tituskills);
  self thread maps\_challenges_sp::register_challenge("helikill", maps\monsoon_ruins::challenge_helikill);
  self thread maps\_challenges_sp::register_challenge("sentryemp", maps\monsoon_ruins::challenge_sentryemp);
  self thread maps\_challenges_sp::register_challenge("turretkills", maps\monsoon_ruins::challenge_turretkills);
  self thread maps\_challenges_sp::register_challenge("camokills", maps\monsoon_lab::challenge_camo_kills);
  self thread maps\_challenges_sp::register_challenge("freezeasds", maps\monsoon_lab::challenge_freeze_asds);
  self thread maps\_challenges_sp::register_challenge("shieldkills", ::challenge_assault_shield);
  self thread maps\_challenges_sp::register_challenge("playerasd", ::challenge_save_player_asd);
}

challenge_kill_challenge_watch() {
  level.n_camo_kills = 0;
  level.n_shield_kills = 0;
  array_thread(getspawnerarray(), ::add_spawn_function, ::kill_challenge_watch_think);
}

kill_challenge_watch_think() {
  self waittill("death", eattacker, idamage, sweapon);

  if(isDefined(eattacker) && isplayer(eattacker)) {
    if(level.player ent_flag_exist("camo_suit_on") && level.player ent_flag("camo_suit_on")) {
      level notify("camo_death");
      level.n_camo_kills++;
    }

    if(sweapon == "riotshield_sp") {
      iprintln("killed by shield, bam!");
      iprintln(level.n_shield_kills);

      level notify("killed_by_shield");
      level.n_shield_kills++;
    }
  }
}

challenge_nodeath(str_notify) {
  self waittill("mission_finished");
  n_deaths = get_player_stat("deaths");

  if(n_deaths == 0)
    self notify(str_notify);
}

challenge_tituskills(str_notify) {
  level.n_titus_kills = 0;

  while(true) {
    self waittill("weapon_fired", str_weapon);

    if(str_weapon == "exptitus6_sp") {
      a_living_enemies = getaiarray("axis");
      array_thread(a_living_enemies, ::challenge_tituskills_think);
      wait 8;
      level notify("stop_titus_challenge_watch");

      if(level.n_titus_kills >= 4) {
        self notify(str_notify);
        return;
      } else
        level.n_titus_kills = 0;
    }
  }
}

challenge_tituskills_think() {
  level endon("stop_titus_challenge_watch");
  self waittill("damage", damage, attacker, direction, point, type, tagname, modelname, partname, weaponname);

  if(isDefined(weaponname)) {
    if(weaponname == "exptitus6_sp" || weaponname == "exptitus6_bullet_sp" || weaponname == "titus_explosive_dart_sp")
      level.n_titus_kills++;
  }
}

challenge_assault_shield(str_notify) {
  while(true) {
    level waittill("killed_by_shield");
    self notify(str_notify);
  }
}

challenge_save_player_asd(str_notify) {
  flag_wait("player_at_celerium");

  if(flag("brute_force_perk_used") && !flag("player_asd_died"))
    self notify(str_notify);
}

set_rain_level(n_level) {
  if(n_level > 5)
    n_level = 5;

  if(n_level == 0) {
    flag_clear("monsoon_is_raining");
    remove_global_spawn_function("axis", ::_ai_rain_thread);
    level notify("_rain_thread");
    level notify("_rain_drops");
    level notify("_rain_lightning");
    level.player clearclientflag(6);
  } else {
    level thread _rain_thread(n_level);

    if(!flag("monsoon_is_raining")) {
      add_global_spawn_function("axis", ::_ai_rain_thread);
      level thread _rain_drops();
      level thread maps\createart\monsoon_art::_lightning();
    }

    level.player setclientflag(6);
    flag_set("monsoon_is_raining");

    iprintln("rain level: " + n_level);

  }
}

_ai_rain_thread() {
  self endon("death");

  while(true) {
    playfxontag(getfx("ai_rain"), self, "j_spine4");
    playfxontag(getfx("ai_rain_helmet"), self, "j_head_end");
    wait(randomfloatrange(0.1, 0.2));
  }
}

hero_rain_thread() {
  self endon("death");
  self endon("stop_hero_rain");

  while(true) {
    tracedata = bullettrace(self geteye(), self geteye() + vectorscale((0, 0, 1), 500.0), 0, self);

    if(tracedata["fraction"] == 1) {
      playfxontag(getfx("ai_rain"), self, "j_spine4");

      if(self == level.crosby)
        playfxontag(getfx("ai_rain_helmet"), self, "j_head_end");
    }

    wait(randomfloatrange(0.1, 0.2));
  }
}

_rain_thread(n_level) {
  level notify("_rain_thread");
  level endon("_rain_thread");

  if(n_level >= 3)
    level thread _wind_shake();
  else
    level.player stoprumble("tank_rumble");

  n_wait = 0.6 - n_level / 10;

  while(true) {
    if(!flag("intro_goggles_off"))
      playfx(getfx("player_rain_binoc"), level.player getorigin());
    else if(flag("ruins_door_destroyed"))
      playfx(getfx("player_rain_temple"), level.player getorigin());
    else
      playfx(getfx("player_rain"), level.player getorigin());

    wait(n_wait);
  }
}

_wind_shake() {
  level endon("_rain_thread");
  level.weather_wind_shake = 1;

  while(isalive(level.player)) {
    wait(randomfloatrange(8.0, 15.0));

    if(level.weather_wind_shake && level.player getstance() != "prone") {
      n_wind_time = randomfloatrange(2.0, 3.0);
      earthquake(0.1, n_wind_time + 2.0, level.player.origin, 500, level.player);
      level.player playrumblelooponentity("tank_rumble");
      level.player playsound("evt_wind_shake");
      wait(n_wind_time);
      level.player stoprumble("tank_rumble");
    }
  }
}

_rain_drops() {
  level endon("_rain_drops");

  while(isalive(level.player)) {
    tracedata = bullettrace(level.player geteye(), level.player geteye() + vectorscale((0, 0, 1), 500.0), 0, level.player);

    if(tracedata["fraction"] == 1 && !flag("player_flying_wingsuit"))
      level.player setclientflag(6);
    else
      level.player clearclientflag(6);

    wait 1;
  }
}

outside_lift_init() {
  m_lift = getent("lift_ruins", "targetname");
  m_lift attach("p6_monsoon_ext_elevator_rain_box", "tag_origin");
  m_lift setmovingplatformenabled(1);
  m_lift.b_top = 1;
  t_use = getent("lift_use_trigger", "targetname");
  t_use enablelinkto();
  t_use linkto(m_lift);
  t_use sethintstring(&"MONSOON_LIFT_PROMPT");
  t_use setcursorhint("HINT_NOICON");
  m_lift.t_hurt = getent("outside_lift_hurt", "targetname");
  m_lift.t_hurt.v_start_org = m_lift.t_hurt.origin;
  m_lift.t_hurt trigger_off();
  m_lift.t_hurt enablelinkto();
  e_exterior_lift_red_light = getent("exterior_lift_red_light", "targetname");
  e_exterior_lift_red_light linkto(m_lift);
  e_exterior_lift_scanner = getent("exterior_lift_scanner", "targetname");
  e_exterior_lift_scanner linkto(m_lift);
  a_m_doors[0] = getent("lift_ruins_door_2_left", "targetname");
  a_m_doors[1] = getent("lift_ruins_door_2_right", "targetname");
  a_m_doors[2] = getent("lift_ruins_door_1_left", "targetname");
  a_m_doors[3] = getent("lift_ruins_door_1_right", "targetname");
  a_m_doors[4] = getent("lift_ruins_window_1_left", "targetname");
  a_m_doors[5] = getent("lift_ruins_window_1_right", "targetname");
  a_m_doors[6] = getent("lift_ruins_window_2_left", "targetname");
  a_m_doors[7] = getent("lift_ruins_window_2_right", "targetname");

  foreach(m_door in a_m_doors) {
    m_door setforcenocull();
    m_door linkto(m_lift);
  }

  m_lift play_fx("lift_light", undefined, undefined, undefined, 1, "tag_origin");
  m_lift.a_top_nodes = getnodearray("lift_top", "targetname");
  m_lift.a_bottom_nodes = getnodearray("lift_bottom", "targetname");
  array_func(m_lift.a_top_nodes, ::node_connect_to_path);
  m_lift.v_lift_top = m_lift.origin;
  m_lift.v_lift_bottom = (m_lift.origin[0], m_lift.origin[1], getstruct("lift_end", "targetname").origin[2]);

  while(!flag("seal_ruins")) {
    t_use sethintstring(&"MONSOON_LIFT_PROMPT");
    t_use waittill("trigger");
    t_use sethintstring("");

    if(flag("seal_ruins")) {
      continue;
    }
    delay_thread(0.05, maps\_camo_suit::data_glove_on, "exterior_lift_push");
    level thread run_scene("exterior_lift_push");
    wait 1;
    level notify("player_used_outside_lift");

    if(m_lift.b_top)
      outside_lift_move_down();
    else
      outside_lift_move_up();
  }

  foreach(model in a_m_doors)
  model delete();

  t_use delete();
  m_lift.t_hurt delete();
  m_lift delete();
}

outside_lift_move_down() {
  m_lift = getent("lift_ruins", "targetname");
  m_lift.t_hurt trigger_on();
  m_lift.t_hurt linkto(m_lift);
  array_func(m_lift.a_top_nodes, ::node_disconnect_from_path);
  m_door_north_l = getent("lift_ruins_door_2_left", "targetname");
  m_door_north_r = getent("lift_ruins_door_2_right", "targetname");
  m_door_north_l unlink();
  m_door_north_r unlink();
  m_door_north_l movey(-60, 2, 0.5);
  m_door_north_r movey(60, 2, 0.5);
  m_door_north_l playsound("evt_lift_close");
  m_door_north_r playsound("evt_lift_close");
  m_door_north_r waittill("movedone");
  m_door_north_l linkto(m_lift);
  m_door_north_r linkto(m_lift);
  m_lift moveto(m_lift.v_lift_bottom, 6, 1.2, 1.2);
  m_lift playsound("evt_lift_start_3d");
  m_lift playloopsound("evt_lift_loop_3d", 1);
  m_lift waittill("movedone");
  m_lift stoploopsound(1);
  m_lift playsound("evt_lift_stop_3d");
  m_door_south_l = getent("lift_ruins_door_1_left", "targetname");
  m_door_south_r = getent("lift_ruins_door_1_right", "targetname");
  m_door_south_l unlink();
  m_door_south_r unlink();
  m_door_south_l movey(60, 2, 0.5);
  m_door_south_r movey(-60, 2, 0.5);
  m_door_north_l playsound("evt_lift_open");
  m_door_north_r playsound("evt_lift_open");
  m_door_south_r waittill("movedone");
  m_door_south_l linkto(m_lift);
  m_door_south_r linkto(m_lift);
  array_func(m_lift.a_bottom_nodes, ::node_connect_to_path);
  m_lift.b_top = 0;
  m_lift.t_hurt unlink();
  m_lift.t_hurt.origin = m_lift.t_hurt.v_start_org;
  m_lift.t_hurt trigger_off();
}

outside_lift_move_up() {
  m_lift = getent("lift_ruins", "targetname");
  array_func(m_lift.a_bottom_nodes, ::node_disconnect_from_path);
  m_door_south_l = getent("lift_ruins_door_1_left", "targetname");
  m_door_south_r = getent("lift_ruins_door_1_right", "targetname");
  m_door_south_l unlink();
  m_door_south_r unlink();
  m_door_south_l movey(-60, 2, 0.5);
  m_door_south_r movey(60, 2, 0.5);
  m_door_south_l playsound("evt_lift_close");
  m_door_south_r playsound("evt_lift_close");
  m_door_south_r waittill("movedone");
  m_door_south_l linkto(m_lift);
  m_door_south_r linkto(m_lift);
  m_lift moveto(m_lift.v_lift_top, 6, 1.2, 1.2);
  m_lift playsound("evt_lift_start_3d");
  m_lift playloopsound("evt_lift_loop_3d", 1);
  m_lift waittill("movedone");
  m_lift stoploopsound(1);
  m_lift playsound("evt_lift_stop_3d");
  m_door_north_l = getent("lift_ruins_door_2_left", "targetname");
  m_door_north_r = getent("lift_ruins_door_2_right", "targetname");
  m_door_north_l unlink();
  m_door_north_r unlink();
  m_door_north_l movey(60, 2, 0.5);
  m_door_north_r movey(-60, 2, 0.5);
  m_door_north_l playsound("evt_lift_open");
  m_door_north_r playsound("evt_lift_open");
  m_door_north_r waittill("movedone");
  m_door_north_l linkto(m_lift);
  m_door_north_r linkto(m_lift);
  array_func(m_lift.a_top_nodes, ::node_connect_to_path);
  m_lift.b_top = 1;
}

use_trigger_on_group_clear(str_group_name, str_trigger_name) {
  t_color = getent(str_trigger_name, "targetname");

  if(isDefined(t_color))
    t_color thread _use_trigger_on_group_clear_think(str_group_name);
}

_use_trigger_on_group_clear_think(str_group_name) {
  self endon("trigger");
  self endon("death");
  waittill_ai_group_cleared(str_group_name);
  self notify("trigger");
}

use_trigger_on_group_count(str_group_name, str_trigger_name, n_count, b_weaken) {
  if(!isDefined(b_weaken))
    b_weaken = 0;

  t_color = getent(str_trigger_name, "targetname");

  if(isDefined(t_color))
    t_color thread _use_trigger_on_group_count_think(str_group_name, n_count, b_weaken);
}

_use_trigger_on_group_count_think(str_group_name, n_count, b_weaken) {
  self endon("trigger");
  self endon("death");
  waittill_ai_group_count(str_group_name, n_count);

  if(b_weaken)
    array_func(get_ai_group_ai(str_group_name), ::weaken_ai);

  self notify("trigger");
}

bruteforce_perk_asd() {
  flag_wait("lift_at_bottom");
  run_scene_first_frame("bruteforce_perk_asd_door");
  t_use = getent("trig_asd_player", "targetname");
  t_use sethintstring(&"MONSOON_PLAYER_ASD_HINT");
  t_use setcursorhint("HINT_NOICON");
  t_use trigger_off();
  level.player waittill_player_has_brute_force_perk();
  t_use trigger_on();
  set_objective(level.obj_bruteforce, t_use, "interact");
  t_use waittill("trigger", player);
  level thread maps\monsoon_lab_defend::asd_perk_visor_text();
  set_objective(level.obj_bruteforce, t_use, "remove");
  t_use delete();
  flag_set("brute_force_perk_used");
  vh_asd_player_perk = spawn_vehicle_from_targetname("asd_player_perk");
  delay_thread(0.05, maps\_camo_suit::data_glove_on, "bruteforce_perk");
  level thread run_scene("bruteforce_perk_asd_door");
  run_scene("bruteforce_perk");
  vh_asd_player_perk thread asd_player_think();
  level thread player_asd_vo();
  flag_set("player_asd_rollout");
}

monitor_player_asd_death() {
  self waittill("death");
  flag_set("player_asd_died");
  level thread maps\monsoon_lab_defend::asd_perk_death_visor_text();
}

player_asd_vo() {
  flag_wait("open_asd_door");

  if(!flag("asd_player_vo") && !flag("isaac_defend_start") || !flag("asd_player_vo") && !flag("isaac_defend_start"))
    level.player thread say_dialog("sect_alright_you_little_0", 0.1);
}

asd_player_think() {
  self endon("death");
  self veh_magic_bullet_shield(1);
  self.ignoreme = 1;
  self.ignoreall = 1;
  flag_wait("open_asd_door");
  self thread monitor_player_asd_death();
  level.player playrumbleonentity("damage_heavy");
  flag_wait("player_asd_rollout");
  self maps\_metal_storm::metalstorm_on();
  self thread asd_god_mode_off();
  wait 1;
  self thread player_asd_rumble();
  self.ignoreme = 0;
  self.ignoreall = 0;
  s_asd_player_rollout_spot = getstruct("asd_player_rollout_spot", "targetname");
  self setvehgoalpos(s_asd_player_rollout_spot.origin, 1, 2, 1);
  self waittill_any("goal", "near_goal");
  self maps\_vehicle::defend(self.origin, 128);
  flag_wait("isaac_defend_start");
  s_asd_player_defend_spot = getstruct("asd_player_defend_spot", "targetname");
  self setvehgoalpos(s_asd_player_defend_spot.origin, 1, 2, 1);
  self waittill_any("goal", "near_goal");
  self maps\_vehicle::defend(self.origin, 250);
  flag_wait("heroes_fallback");
  wait 1.5;
  s_player_asd_fallback_pos = getstruct("player_asd_fallback_pos", "targetname");
  self setvehgoalpos(s_player_asd_fallback_pos.origin, 1, 2, 1);
  flag_wait("isaac_is_shot");
  self veh_magic_bullet_shield(1);
  s_player_asd_emp_pos = getstruct("player_asd_emp_pos", "targetname");
  self.origin = s_player_asd_emp_pos.origin;
  self.angles = s_player_asd_emp_pos.angles;
  self.ignoreall = 1;
  self.ignoreme = 1;
  self metalstorm_emped();
  self.ignoreall = 0;
  self.ignoreme = 0;
  flag_wait("isaacs_killers_cleared");
  self maps\_metal_storm::metalstorm_stop_ai();
  self thread metalstorm_weapon_think();
}

asd_god_mode_off() {
  flag_wait("stop_defend_sm_think");
  wait 10;
  self veh_magic_bullet_shield(0);
}

player_door_rumble() {
  if(self.is_big_door) {
    is_big_door = 0;
    n_rumble_distance = 1000;
  } else
    n_rumble_distance = 500;

  while(self.is_moving) {
    n_distance = distance(self.origin, level.player.origin);

    if(n_distance < n_rumble_distance)
      level.player playrumbleonentity("tank_rumble");

    wait 0.05;
  }
}

player_asd_rumble() {
  self endon("death");

  while(true) {
    n_distance = distance(self.origin, level.player.origin);

    if(n_distance < 200)
      level.player playrumbleonentity("tank_rumble");

    wait 0.05;
  }
}

monsoon_light_rumble(guy) {
  level.player playrumbleonentity("damage_light");
}

monsoon_screen_tap_rumble(guy) {
  level.player playrumbleonentity("reload_clipout");
}

monsoon_heavy_rumble(guy) {
  level.player playrumbleonentity("damage_heavy");
}

waittill_input(str_hint, str_buttonpress, str_direction) {
  if(isDefined(str_hint))
    screen_message_create(str_hint);

  wait 0.25;

  if(str_buttonpress == "ltrig_rtrig")
    self _input_both_triggers_pulled();
  else if(str_buttonpress == "ltrig")
    self _input_left_trigger_pulled();
  else if(str_buttonpress == "lstick" || str_buttonpress == "rstick")
    self _input_stick(str_buttonpress, str_direction);
  else
    self _input_button(str_buttonpress);

  if(isDefined(str_hint))
    screen_message_delete();
}

_input_both_triggers_pulled() {
  level endon("input_trigs_detected");
  self endon("stop_input_detection");

  while(true) {
    if(self throwbuttonpressed() && self attackbuttonpressed()) {
      flag_set("input_trigs_detected");
      break;
    }

    wait 0.05;
  }
}

_input_left_trigger_pulled() {
  level endon("input_trigs_detected");
  self endon("stop_input_detection");

  while(true) {
    if(self throwbuttonpressed()) {
      break;
    }

    wait 0.05;
  }
}

_input_stick(str_stick, str_direction) {
  level endon("input_lstick_detected");
  self endon("stop_input_detection");
  n_axis = 0;
  n_dot = -0.25;

  if(isDefined(str_direction)) {
    if(str_direction == "forward" || str_direction == "right")
      n_dot = 0.85;

    if(str_direction == "right" || str_direction == "left")
      n_axis = 1;
  }

  while(true) {
    if(str_stick == "lstick")
      stick = self get_normalized_movement(1, 1)[n_axis];
    else
      stick = self get_normalized_camera_movement(1, 1)[n_axis];

    if(stick <= n_dot) {
      break;
    }

    wait 0.05;
  }

  level notify("input_stick_detected");
  flag_set("input_lstick_detected");
}

_input_button(str_button) {
  level endon("input_button_press_detected");
  self endon("stop_input_detection");
  b_input = 0;

  while(!b_input) {
    switch (str_button) {
      case "reload_button":
        if(self usebuttonpressed())
          b_input = 1;

        break;
      case "ads_button":
        if(self throwbuttonpressed())
          b_input = 1;

        break;
      case "attack_button":
        if(self attackbuttonpressed())
          b_input = 1;

        break;
      case "jump_button":
        if(self jumpbuttonpressed())
          b_input = 1;

        break;
    }

    wait 0.05;
  }

  level notify("input_button_press_detected");
}

sway_init() {
  flag_wait("monsoon_gump_exterior");
  a_structs = getstructarray("sway", "targetname");

  foreach(struct in a_structs) {
    e_origin = spawn("script_origin", struct.origin);
    e_origin.m_model = getent(struct.target, "targetname");
    e_origin.m_model _sway_attach_vines();

    switch (e_origin.m_model.model) {
      case "p6_container_yard_light":
        e_origin.m_model attach("p6_container_yard_light_on", "tag_origin");
        e_origin.m_model _sway_fx("light_yard", "tag_light1");
        e_origin.m_model _sway_fx("light_yard", "tag_light2");
        break;
      case "ctl_light_spotlight_generator":
        e_origin.m_model attach("ctl_light_spotlight_generator_on", "tag_origin");
        e_origin.m_model _sway_fx("light_generator", "tag_fx_bulb_1");
        e_origin.m_model _sway_fx("light_generator", "tag_fx_bulb_2");
        e_origin.m_model _sway_fx("light_generator", "tag_fx_bulb_3");
        break;
    }

    e_origin thread _sway_think(struct.script_noteworthy);
    wait 0.05;
  }

  a_models = getentarray("sway", "targetname");

  foreach(model in a_models) {
    model _sway_attach_vines();
    model thread _sway_tree_think();
    wait 0.05;
  }
}

_sway_fx(str_fx_name, str_tag) {
  playfxontag(getfx(str_fx_name), self, str_tag);
}

_sway_tree_think() {
  while(!flag("seal_ruins"))
    self _sway_model(0.4, 0.75);

  self delete();
}

_sway_think(str_type) {
  assert(isDefined(str_type), "Sway origin has no script_noteworthy set.");
  v_wind_dir = vectortoangles(getdvarvector(#"wind_global_vector"));
  self rotateto(v_wind_dir, 0.05);
  self waittill("rotatedone");
  self.m_model linkto(self);

  while(!flag("seal_ruins")) {
    switch (str_type) {
      case "tree":
        self _sway_model(1, 0.5);
        break;
      case "light":
        self _sway_model(2, 0.5);
        break;
      case "wheels":
        self _sway_model(1, 0.5);
        break;
      case "mounted":
        self _sway_model(1, 0.5);
        break;
    }
  }

  if(isDefined(self.vine_model))
    self.vine_model delete();

  self.m_model delete();
  self delete();
}

_sway_model(n_degree, n_time) {
  n_random = n_time / 2;
  self rotateroll(n_degree, n_time, randomfloatrange(0.05, n_random), randomfloatrange(0.05, n_random));
  self waittill("rotatedone");
  self rotateroll(n_degree * -1, n_time, randomfloatrange(0.05, n_random), randomfloatrange(0.05, n_random));
  self waittill("rotatedone");
}

_sway_attach_vines() {
  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "no_vines")
    return;
  else if(self.model == "t5_foliage_tree_aquilaria01v2_small_no_vines") {
    self.vine_model = spawn_anim_model("aquilaria", self.origin, self.angles);
    self.vine_model linkto(self);
    self.vine_model thread anim_loop(self.vine_model, "vines");
  } else if(self.model == "p6_strangler_fig_tree_no_vines_sway") {
    self.vine_model = spawn_anim_model("strangler", self.origin, self.angles);
    self.vine_model linkto(self);
    self.vine_model thread anim_loop(self.vine_model, "vines");
  }
}

toggle_titus_weapon(ai_actor) {
  if(isDefined(ai_actor.titus)) {
    ai_actor.titus delete();
    ai_actor.titus = undefined;
  } else {
    str_model = getweaponmodel("exptitus6_sp");
    ai_actor.titus = spawn_model(str_model, ai_actor gettagorigin("tag_weapon_left"), ai_actor gettagangles("tag_weapon_left"));
    ai_actor.titus linkto(ai_actor, "tag_weapon_left");
  }
}

add_ai_to_gaz() {
  for(i = 0; i < self.script_int; i++) {
    if(issubstr(self.vehicletype, "wturret") && i == 0) {
      ai_rider = simple_spawn_single("gaz_rider");
      ai_rider vehicle_enter(self, "tag_gunner1");
      continue;
    }

    ai_rider = simple_spawn_single("gaz_rider");
    ai_rider vehicle_enter(self);
  }
}

plant_c4(s_align) {
  if(!isDefined(s_align.script_noteworthy))
    plant_c4_spawn(s_align);
  else {
    ai_enemy = simple_spawn_single("base_activity_enemy");
    ai_enemy attach("t6_wpn_c4_world", "tag_weapon_left");
    ai_enemy thread plant_c4_death();
    ai_enemy endon("death");
    ai_enemy set_allowdeath(1);
    s_align anim_generic_aligned(ai_enemy, "plant_c4_" + s_align.script_noteworthy);
  }
}

plant_c4_death() {
  self endon("c4_planted");
  self waittill("death");
  self detach("t6_wpn_c4_world", "tag_weapon_left");
}

plant_c4_notetrack(ai_enemy) {
  ai_enemy detach("t6_wpn_c4_world", "tag_weapon_left");
  ai_enemy notify("c4_planted");
  m_c4 = spawn_model("t6_wpn_c4_world", ai_enemy gettagorigin("tag_weapon_left"), ai_enemy gettagangles("tag_weapon_left"));
  m_c4 thread plant_c4_think();
}

plant_c4_spawn(s_pos) {
  m_c4 = spawn_model("t6_wpn_c4_world", s_pos.origin, s_pos.angles);
  m_c4 thread plant_c4_think();
  return m_c4;
}

plant_c4_think() {
  level endon("remove_c4");
  self.targetname = "planted_c4";
  self setcandamage(1);
  playfxontag(getfx("c4_blink"), self, "tag_fx");
  self waittill("damage", damage, attacker);
  v_origin = self gettagorigin("tag_fx");
  self playsoundontag("wpn_c4_explode", "tag_fx");
  playfx(getfx("c4_explode"), v_origin);

  if(isDefined(attacker) && isplayer(attacker))
    radiusdamage(v_origin, 200, 300, 50, attacker, "MOD_EXPLOSIVE");
  else
    radiusdamage(v_origin, 200, 300, 50, self, "MOD_EXPLOSIVE");

  wait 0.05;
  physicsexplosionsphere(v_origin, 200, 100, 1);
  earthquake(1.0, 0.5, v_origin, 1000);
  playrumbleonposition("artillery_rumble", v_origin);
  self delete();
}

plant_c4_trigger_think() {
  self endon("death");
  self waittill("trigger");
  a_s_pos = getstructarray(self.target, "targetname");

  foreach(s_pos in a_s_pos)
  level thread plant_c4(s_pos);
}

emergency_light_init() {
  flag_wait("start_player_asd_anim");
  a_light_triggers = get_ent_array("emergency_light_trigger", "targetname", 1);
  a_light_models = get_ent_array("fxanim_emergency_light", "targetname", 1);

  if(a_light_triggers.size != a_light_models.size) {
    if(a_light_triggers.size < a_light_models.size) {
      for(i = 0; i < a_light_models.size; i++) {
        b_found_match = 0;

        for(j = 0; j < a_light_triggers.size; j++) {
          if(a_light_models[i] istouching(a_light_triggers[j]))
            b_found_match = 1;
        }

        if(!b_found_match)
          println("emergency light at " + a_light_models[i].origin + " is missing trigger!");
      }
    } else {
      for(i = 0; i < a_light_triggers.size; i++) {
        b_found_match = 0;

        for(j = 0; j < a_light_models.size; j++) {
          if(a_light_triggers[i] istouching(a_light_models[j]))
            b_found_match = 1;
        }

        if(!b_found_match)
          println("emergency light trigger at " + a_light_triggers[i].origin + " is not using a light!");
      }
    }
  }

  spread_array_thread(a_light_triggers, ::emergency_light_trigger_think, a_light_models);
}

emergency_light_trigger_think(a_light_models) {
  level endon("kill_emergency_lights");
  self endon("death");
  m_light = undefined;
  n_lights_found = 0;
  assert(isDefined(self.script_string), "emergency light trigger at " + self.origin + " is missing a script_string identifier");

  for(i = 0; i < a_light_models.size; i++) {
    if(isDefined(a_light_models[i].script_string) && self.script_string == a_light_models[i].script_string) {
      m_light = a_light_models[i];
      n_lights_found++;
    }
  }

  assert(isDefined(m_light), "emergency_light_trigger_think found no light for trigger at " + self.origin);
  assert(n_lights_found == 1, "emergency_light_trigger_think found " + n_lights_found + " for trigger at " + self.origin + "! There should only be one light per trigger volume");
  n_lights_found = undefined;
  a_light_models = undefined;
  m_light.trigger = self;

  while(isDefined(self)) {
    self waittill("trigger");

    if(!isDefined(level.emergency_light_active))
      level.emergency_light_active = level.player;

    if(level.emergency_light_active != m_light) {
      level notify("new_emergency_light_playing");

      if(isDefined(level.emergency_light_active.trigger)) {
        level.emergency_light_active notify("stop_emergency_light");

        if(isDefined(level.emergency_light_active.trigger.script_delete) && level.emergency_light_active.trigger.script_delete) {
          level.emergency_light_active.trigger delete();
          maps\_fxanim::fxanim_delete(level.emergency_light_active.script_string);
        }
      }

      level.emergency_light_active = m_light;
      wait_network_frame();
      m_light play_fx("fx_mon_emergency_lights", undefined, undefined, "stop_emergency_light", 1, "tag_light_fx", 1);
    }

    level waittill("new_emergency_light_playing");
  }
}

disable_player_weapon(guy) {
  level.player disableweapons();
}

enable_player_weapon(guy) {
  level.player enableweapons();
}

set_low_ready_true(guy) {
  level.player setlowready(1);
}

set_low_ready_false(guy) {
  level.player setlowready(0);
}

play_single_spark(guy) {
  playfxontag(level._effect["single_weld_spark"], guy, "fx_sparks");
}

play_loop_spark(guy) {
  if(guy.targetname == "DDM_1")
    guy play_fx("single_weld_spark_loop", undefined, undefined, "stop_weld_loop_ddm_1", 1, "fx_sparks");
  else
    guy play_fx("single_weld_spark_loop", undefined, undefined, "stop_weld_loop_ddm_2", 1, "fx_sparks");
}

stop_loop_spark(guy) {
  if(guy.targetname == "DDM_1")
    guy notify("stop_weld_loop_ddm_1");
  else
    guy notify("stop_weld_loop_ddm_2");
}

say_squad_dialog(str_ref) {
  if(issubstr(str_ref, "harp"))
    level.harper say_dialog(str_ref);
  else if(issubstr(str_ref, "sala"))
    level.salazar say_dialog(str_ref);
  else if(issubstr(str_ref, "cros"))
    level.crosby say_dialog(str_ref);
  else if(issubstr(str_ref, "sect"))
    level.player say_dialog(str_ref);
}

enemy_dialog_zone(a_vo, end_flag, n_min, n_max) {
  if(!isDefined(n_min))
    n_min = 8;

  if(!isDefined(n_max))
    n_max = 12;

  if(flag(end_flag)) {
    return;
  }
  level endon(end_flag);

  foreach(vo in a_vo) {
    queue_dialog_enemy(vo);
    wait(randomfloatrange(n_min, n_max));
  }
}