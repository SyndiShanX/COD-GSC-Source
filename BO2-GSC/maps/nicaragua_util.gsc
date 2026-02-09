/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\nicaragua_util.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_fxanim;
#include maps\_objectives;
#include maps\_skipto;
#include maps\_scene;
#include maps\nicaragua_menendez_rage;
#include maps\_challenges_sp;
#include maps\nicaragua_mason_truck;
#include maps\createart\nicaragua_art;
#include maps\_vehicle;
#include maps\_turret;
#include maps\_dialog;

setup_objectives() {
  level.obj_menendez_observe_menendez = register_objective(&"NICARAGUA_OBJ_MENENDEZ_OBSERVE_MENENDEZ");
  level.obj_menendez_axe = register_objective("");
  level.obj_menendez_shoot_stables_gate_lock = register_objective("");
  level.obj_menendez_save_josefina = register_objective(&"NICARAGUA_OBJ_SAVE_JOSEFINA");
  level.obj_mason_observe_menendez = register_objective(&"NICARAGUA_OBJ_MASON_OBSERVE_MENENDEZ");
  level.obj_mason_up_hill = register_objective(&"NICARAGUA_OBJ_MASON_UP_HILL");
  level.obj_mason_intruder_perk = register_objective("");
  level.obj_mason_clear_the_mission = register_objective(&"NICARAGUA_OBJ_MASON_CLEAR_THE_MISSION");
  level.obj_mason_bruteforce_perk = register_objective("");
  level.obj_mason_splitup_start = register_objective("");
  level.obj_mason_bunker_entrance = register_objective("");
  level.obj_mason_bunker = register_objective(&"NICARAGUA_OBJ_MASON_BUNKER");
  level.obj_mason_lockbreaker_perk = register_objective("");
  level.obj_mason_lockbreaker_machete = register_objective("");
  level.obj_cia_easter_egg = register_objective("");
  level.obj_mason_find_menendez = register_objective(&"NICARAGUA_OBJ_MASON_FIND_MENENDEZ");
  level.obj_mason_bunker_exit = register_objective("");
  level.obj_mason_follow_woods = register_objective("");
}

level_init_flags() {
  flag_init("movie_ended");
  flag_init("play_noriega_arrives");
  flag_init("nicaragua_intro_complete");
  flag_init("menendez_section_done");
  flag_init("menendez_section_playthrough_complete");
  flag_init("menendez_shotgun_challenge_complete");
  flag_init("menendez_speed_run_challenge_updated");
  flag_init("menendez_important_vo");
  flag_init("mason_introscreen");
  flag_init("player_got_molotovs");
  flag_init("player_got_mortars");
  flag_init("player_got_machete");
}

skipto_setup() {
  screen_fade_out(0);
  str_skipto = level.skipto_point;
  load_gumps_nicaragua(str_skipto);
  screen_fade_in(0);

  if(str_skipto == "no_game") {
    return;
  }
  set_character_mason(0);

  if(str_skipto == "mason_intro_briefing") {
    return;
  }
  set_character_menendez();

  if(str_skipto == "menendez_intro") {
    return;
  }
  flag_set("menendez_intro_part2_done");

  if(str_skipto == "menendez_sees_noriega") {
    return;
  }
  flag_set("nicaragua_intro_complete");
  level.player rage_low();

  if(str_skipto == "menendez_hill" || str_skipto == "dev_no_rage_menendez_hill") {
    return;
  }
  if(str_skipto == "menendez_execution" || str_skipto == "dev_no_rage_menendez_execution") {
    return;
  }
  if(str_skipto == "menendez_stables") {
    return;
  }
  if(str_skipto == "menendez_to_mission") {
    return;
  }
  if(str_skipto == "menendez_enter_mission") {
    return;
  }
  set_objective(level.obj_menendez_save_josefina);

  if(str_skipto == "menendez_hallway") {
    return;
  }
  set_objective(level.obj_menendez_save_josefina, undefined, "delete");
  level.player rage_disable();
  flag_set("menendez_section_done");
  update_player_model("c_usa_seal80s_mason_viewhands", "c_usa_seal80s_mason_viewbody");
  flame_vision_enabled();

  if(str_skipto == "mason_intro") {
    return;
  }
  delete_menendez_scenes();
  menendez_spawners_clean_up();
  set_character_mason();
  flag_set("menendez_speed_run_challenge_updated");

  if(str_skipto == "mason_hill") {
    return;
  }
  if(str_skipto == "mason_truck") {
    return;
  }
  if(str_skipto == "mason_donkeykong") {
    return;
  }
  if(str_skipto == "mason_woods_freakout") {
    return;
  }
  if(str_skipto == "mason_to_mission") {
    return;
  }
  if(str_skipto == "mason_bunker") {
    return;
  }
  if(str_skipto == "mason_final_push") {
    return;
  }
  if(str_skipto == "mason_shattered") {
    return;
  }
  if(str_skipto == "mason_outro") {
    return;
  }
  if(str_skipto == "the_belltower") {
    return;
  }
  if(str_skipto == "the_escape_route") {
    return;
  }
  if(str_skipto == "the_landing_zone")
    return;
}

loadout_weapons_store() {
  if(!isDefined(self.loadout_weapons_stored))
    self.loadout_weapons_stored = 0;

  if(!self.loadout_weapons_stored) {
    self take_weapons();
    self.loadout_weapons_list = level.player.weapons_list;
    self.loadout_weapons_info = level.player.weapons_info;
    self.loadout_curweapon = self.curweapon;
    self.loadout_offhand = self.offhand;
    self give_weapons();
    self.loadout_weapons_stored = 1;
  }
}

loadout_weapons_restore() {
  self take_weapons();
  self.weapons_list = self.loadout_weapons_list;
  self.weapons_info = self.loadout_weapons_info;
  self.curweapon = self.loadout_curweapon;
  self.offhand = self.loadout_offhand;
  self give_weapons();
  self.loadout_curweapon = undefined;
  self.loadout_offhand = undefined;
  self.loadout_weapons_list = undefined;
  self.loadout_weapons_info = undefined;
  self.loadout_weapons_stored = undefined;
}

give_menendez_perks(b_for_high_rage) {
  a_perks = [];

  if(isDefined(b_for_high_rage) && b_for_high_rage) {
    a_perks[a_perks.size] = "specialty_bulletaccuracy";
    a_perks[a_perks.size] = "specialty_fastweaponswitch";
    self.a_high_rage_perks = a_perks;
  } else {
    a_perks[a_perks.size] = "specialty_armorvest";
    a_perks[a_perks.size] = "specialty_bulletdamage";
    a_perks[a_perks.size] = "specialty_bulletflinch";
    a_perks[a_perks.size] = "specialty_fastads";
    a_perks[a_perks.size] = "specialty_fastmantle";
    a_perks[a_perks.size] = "specialty_fastmeleerecovery";
    a_perks[a_perks.size] = "specialty_flakjacket";
    a_perks[a_perks.size] = "specialty_stalker";
    a_perks[a_perks.size] = "specialty_unlimitedsprint";
    self.a_low_rage_perks = a_perks;
  }

  assert(a_perks.size < 12, "Max perks exceeded for Menendez. Max perks = " + 12 + ", you have " + a_perks.size);

  for(i = 0; i < a_perks.size; i++)
    self setperk(a_perks[i]);
}

take_menendez_high_rage_perks() {
  foreach(str_perk in self.a_high_rage_perks)
  self unsetperk(str_perk);

  self.a_high_rage_perks = undefined;
}

loadout_perks_store() {
  if(!isDefined(self.loadout_perks_set))
    self.loadout_perks_set = 0;

  if(!self.loadout_perks_set) {
    self.loadout_perk = [];

    for(i = 1; i <= 12; i++)
      self.loadout_perk[i] = getloadoutitem("specialty" + i);

    self.loadout_perks_set = 1;
  }
}

loadout_perks_remove() {
  if(!isDefined(self.loadout_perks_removed))
    self.loadout_perks_removed = 0;

  if(!self.loadout_perks_removed) {
    for(i = 1; i <= 12; i++) {
      str_perk = self.loadout_perk[i];

      if(isDefined(str_perk) && str_perk != "weapon_null" && str_perk != "specialty_null") {
        perk_specialties = strtok(str_perk, "|");

        for(j = 0; j < perk_specialties.size; j++)
          self unsetperk(perk_specialties[j]);
      }
    }

    self.loadout_perks_removed = 1;
  }
}

loadout_perks_restore() {
  if(!isDefined(self.loadout_perks_set))
    self loadout_perks_store();

  for(i = 0; i <= 12; i++) {
    str_perk = self.a_low_rage_perks[i];

    if(isDefined(str_perk) && str_perk != "weapon_null" && str_perk != "specialty_null") {
      perk_specialties = strtok(str_perk, "|");

      for(j = 0; j < perk_specialties.size; j++)
        self unsetperk(perk_specialties[j]);
    }
  }

  self.a_low_rage_perks = undefined;

  for(i = 1; i <= 12; i++) {
    str_perk = self.loadout_perk[i];

    if(isDefined(str_perk) && str_perk != "specialty_null" && str_perk != "weapon_null") {
      perk_specialties = strtok(str_perk, "|");

      for(j = 0; j < perk_specialties.size; j++)
        self setperk(perk_specialties[j]);
    }
  }
}

menendez_give_weapon() {
  self take_weapons();
  str_weapon_1st = "spas_menendez_sp";
  self giveweapon(str_weapon_1st);
  self givemaxammo(str_weapon_1st);
  self switchtoweapon(str_weapon_1st);

  str_weapon_2nd = "ak47_sp";
  self giveweapon(str_weapon_2nd);
  self givemaxammo(str_weapon_2nd);

  self giveweapon("frag_grenade_sp");
  self setweaponammoclip("frag_grenade_sp", 0);
  self giveweapon("machete_sp");
}

load_gumps_nicaragua(str_skipto) {
  if(should_load_josefina_gump(str_skipto)) {
    load_gump("nicaragua_gump_josefina");
    return;
  } else if(should_load_mason_gump(str_skipto)) {
    load_gump("nicaragua_gump_mason");
    return;
  } else if(is_after_skipto("mason_shattered")) {
    load_gump("nicaragua_gump_outro");
    return;
  } else if(is_after_skipto("mason_bunker")) {
    load_gump("nicaragua_gump_bunker");
    return;
  } else if(is_after_skipto("menendez_execution")) {
    load_gump("nicaragua_gump_menendez");
    return;
  } else
    load_gump("nicaragua_gump_lower_village");
}

should_load_josefina_gump(str_skipto) {
  switch (str_skipto) {
    case "mason_intro":
    case "mason_shattered":
    case "menendez_intro":
      b_load_josefina_gump = 1;
      break;
    default:
      b_load_josefina_gump = 0;
      break;
  }

  return b_load_josefina_gump;
}

should_load_mason_gump(str_skipto) {
  switch (str_skipto) {
    case "mason_bunker":
    case "mason_donkeykong":
    case "mason_hill":
    case "mason_intro_briefing":
    case "mason_to_mission":
    case "mason_truck":
    case "mason_woods_freakout":
      b_load_mason_gump = 1;
      break;
    default:
      b_load_mason_gump = 0;
      break;
  }

  return b_load_mason_gump;
}

setup_challenges() {
  wait_for_first_player();
  level.n_molotov_kills = 0;
  level.n_mortar_kills = 0;
  level.player thread maps\_challenges_sp::register_challenge("nodeath", ::challenge_nodeath);
  level.player thread maps\_challenges_sp::register_challenge("menendez_kill_pdf_with_turret", ::challenge_pdf_turret_deaths);
  level.player thread maps\_challenges_sp::register_challenge("menendez_speed_run", ::challenge_menendez_speed_run);
  level.player thread maps\_challenges_sp::register_challenge("menendez_shotgun_kills", ::challenge_menendez_shotgun_kills);
  level.player thread maps\_challenges_sp::register_challenge("mason_molotov_kills", ::challenge_mason_molotov_kills);
  level.player thread maps\_challenges_sp::register_challenge("mason_machete_kills", ::challenge_mason_machete_kills);
  level.player thread maps\_challenges_sp::register_challenge("mason_mortar_kills", ::challenge_mason_mortar_kills);
  level.player thread maps\_challenges_sp::register_challenge("mason_find_clue", ::challenge_mason_find_clue);
  level.player thread maps\_challenges_sp::register_challenge("mason_flip_truck", maps\nicaragua_mason_truck::challenge_mason_flip_truck);
}

challenge_nodeath(str_notify) {
  self waittill("mission_finished");
  n_deaths = get_player_stat("deaths");

  if(n_deaths == 0)
    self notify(str_notify);
}

challenge_pdf_turret_deaths(str_notify) {
  while(!flag("menendez_section_done")) {
    level waittill("pdf_killed_with_turret");
    self notify(str_notify);
  }
}

global_callback_actor_killed_menendez(e_inflictor, e_attacker, n_damage, str_mod, str_weapon, v_hit_direction, str_hit_location, psoffsettime) {
  if(self.team == "axis") {
    if(isDefined(e_attacker) && isPlayer(e_attacker) && isDefined(str_weapon) && str_weapon == "civ_pickup_turret")
      level notify("pdf_killed_with_turret");

    if(isDefined(e_attacker) && isPlayer(e_attacker) && is_shotgun(str_weapon))
      level thread challenge_menendez_shotgun_kills_counter();
  }
}

is_shotgun(str_weapon) {
  if(isDefined(str_weapon)) {
    if(str_weapon == "rottweil72_sp" || str_weapon == "spas_sp" || str_weapon == "spas_menendez_sp")
      return true;
  }

  return false;
}

global_callback_actor_killed_mason(e_inflictor, e_attacker, n_damage, str_mod, str_weapon, v_hit_direction, str_hit_location, psoffsettime) {
  if(self.team == "axis") {
    if(isDefined(str_weapon) && isPlayer(e_attacker) && str_weapon == "molotov_dpad_sp") {
      level.n_molotov_kills++;
      level notify("molotov_kill_recorded");
    }

    if(isDefined(str_weapon) && isPlayer(e_attacker) && str_weapon == "mortar_shell_dpad_sp") {
      level.n_mortar_kills++;
      level notify("mortar_kill_recorded");
    }

    if(isPlayer(e_attacker) && str_weapon == "machete_sp")
      level notify("machete_kill_recorded");
  }
}

challenge_menendez_speed_run(str_notify) {
  flag_wait("nicaragua_intro_complete");
  n_time_start = gettime();
  flag_wait("shattered_1_started");
  n_time_done = gettime();
  n_time_completed = (n_time_done - n_time_start) / 1000;
  debug_print_line("completed menendez section in " + n_time_completed + " seconds");
  flag_wait("mason_intro_part2_player_started");
  wait 1;

  if(n_time_completed <= 140)
    self notify(str_notify);

  flag_set("menendez_speed_run_challenge_updated");
}

challenge_menendez_melee_kills(str_notify) {
  while(true) {
    level waittill("menendez_performed_cinematic_melee");
    self notify(str_notify);
  }
}

challenge_menendez_shotgun_kills(str_notify) {
  flag_wait("menendez_shotgun_challenge_complete");
  self notify(str_notify);
}

challenge_menendez_shotgun_kills_counter() {
  n_start_time = gettime();
  self endon("_shotgun_kills_timeout_" + n_start_time);
  self delay_notify("_shotgun_kills_timeout_" + n_start_time, 10);
  n_kill_count = 1;
  level notify("shotgun_death_detected");

  while(true) {
    level waittill("shotgun_death_detected");
    n_kill_count++;

    if(n_kill_count >= 7) {
      debug_print_line("menendez_shotgun_kills_challenge_complete");
      flag_set("menendez_shotgun_challenge_complete");
    }
  }
}

challenge_mason_molotov_kills(str_notify) {
  while(level.n_molotov_kills < 12)
    level waittill("molotov_kill_recorded");

  self notify(str_notify);
}

challenge_mason_machete_kills(str_notify) {
  while(true) {
    level waittill("machete_kill_recorded");
    self notify(str_notify);
  }
}

challenge_mason_mortar_kills(str_notify) {
  while(level.n_mortar_kills < 10)
    level waittill("mortar_kill_recorded");

  self notify(str_notify);
}

challenge_mason_find_clue(str_notify) {
  level waittill("cia_easter_egg_success");
  self notify(str_notify);
}

scene_clear_ai_goals(str_scene_name, delay) {
  if(isDefined(delay) && delay > 0)
    wait(delay);

  a_ai = get_ais_from_scene(str_scene_name);

  if(isDefined(a_ai)) {
    for(i = 0; i < a_ai.size; i++)
      a_ai[i] setgoalpos(a_ai[i].origin);
  }
}

scene_ai_properties(str_scene_name, delay, ai_invulnerable, turn_off_friendly_fire, ignore_ai) {
  if(isDefined(delay) && delay > 0)
    wait(delay);

  a_ai = get_ais_from_scene(str_scene_name);

  if(isDefined(a_ai)) {
    for(i = 0; i < a_ai.size; i++) {
      e_ent = a_ai[i];

      if(isDefined(ai_invulnerable) && ai_invulnerable == 1)
        e_ent.health = 5000;

      if(isDefined(turn_off_friendly_fire) && turn_off_friendly_fire == 1)
        e_ent.nofriendlyfire = 1;

      if(isDefined(ignore_ai) && ignore_ai == 1)
        e_ent.ignoreme = 1;
    }
  }
}

no_player_damage_override(e_inflictor, e_attacker, n_damage, n_flags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, n_model_index, psoffsettime, str_bone_name) {
  if(!isalive(self))
    return n_damage;

  if(e_inflictor == level.player)
    n_damage = 0;

  return n_damage;
}

scene_is_playing(scene_name) {
  return flag(scene_name + "_started") && !flag(scene_name + "_done");
}

global_ai_cleanup_category_set(str_category) {
  add_global_spawn_function("axis", ::spawner_set_cleanup_category, str_category);
  add_global_spawn_function("allies", ::spawner_set_cleanup_category, str_category);
  add_global_spawn_function("neutral", ::spawner_set_cleanup_category, str_category);
}

global_ai_cleanup_category_clear(str_category) {
  remove_global_spawn_function("axis", ::spawner_set_cleanup_category);
  remove_global_spawn_function("allies", ::spawner_set_cleanup_category);
  remove_global_spawn_function("neutral", ::spawner_set_cleanup_category);
}

add_cleanup_ent(str_category, e_add) {
  if(!isDefined(level.a_e_cleanup))
    level.a_e_cleanup = [];

  if(!isDefined(level.a_e_cleanup[str_category]))
    level.a_e_cleanup[str_category] = [];

  level.a_e_cleanup[str_category][level.a_e_cleanup[str_category].size] = e_add;
}

cleanup_ents(str_category, n_wait_min, n_wait_max) {
  if(!isDefined(n_wait_min))
    n_wait_min = 0.05;

  if(!isDefined(n_wait_max))
    n_wait_max = 3.5;

  assert(isDefined(level.a_e_cleanup), "level cleanup variable has not been initialized");
  assert(isDefined(level.a_e_cleanup[str_category]), "level cleanup category '" + str_category + "' is missing");
  a_temp = level.a_e_cleanup[str_category];

  if(isDefined(a_temp)) {
    for(i = 0; i < a_temp.size; i++) {
      if(isDefined(a_temp[i])) {
        if(isai(a_temp[i])) {
          a_temp[i] thread _kill_ai(n_wait_min, n_wait_max);
          continue;
        }

        a_temp[i] delete();
      }
    }
  }

  level.a_e_cleanup[str_category] = undefined;
}

spawner_set_cleanup_category(str_category) {
  add_cleanup_ent(str_category, self);
}

spawn_manager_cleanup(str_script_noteworthy) {
  a_spawn_managers = get_ent_array(str_script_noteworthy, "script_noteworthy");

  for(i = 0; i < a_spawn_managers.size; i++) {
    spawn_manager_kill(a_spawn_managers[i].targetname);
    a_spawn_managers[i] delete();
  }
}

simple_spawn_script_delay(a_ents, spawn_fn, param1, param2, param3, param4, param5) {
  for(i = 0; i < a_ents.size; i++) {
    e_spawner = a_ents[i];

    if(isDefined(e_spawner.script_delay)) {
      level thread spawn_with_delay(e_spawner, spawn_fn, e_spawner, param1, param2, param3);
      continue;
    }

    simple_spawn_single(e_spawner, spawn_fn, e_spawner, param1, param2, param3);
  }
}

spawn_with_delay(e_spawner, spawn_fn, param1, param2, param3, param4, param5) {
  delay = e_spawner.script_delay;
  wait(delay);

  if(isDefined(e_spawner))
    simple_spawn_single(e_spawner, spawn_fn, param1, param2, param3, param4, param5);
}

spawn_fn_ai_run_to_target(e_spawner, str_cleanup_category, player_favourate_enemy, aggressive_mode, ignore_surpression) {
  if(isDefined(str_cleanup_category)) {
    spawner_set_cleanup_category(str_cleanup_category);
    str_cleanup_category = undefined;
  }

  self.goalradius = 48;
  self waittill("goal");
  self.goalradius = 2048;
  self entity_common_spawn_setup(e_spawner, str_cleanup_category, player_favourate_enemy, ignore_surpression);
}

spawn_fn_ai_run_to_holding_node(e_spawner, str_cleanup_category, player_favourate_enemy, aggressive_mode, ignore_surpression) {
  self.goalradius = 48;
  self waittill("goal");
  self.fixednode = 1;
  self.aggressivemode = aggressive_mode;
  self entity_common_spawn_setup(e_spawner, str_cleanup_category, player_favourate_enemy, ignore_surpression);
}

spawn_fn_ai_run_to_node_and_die(e_spawner, str_cleanup_category, player_favourate_enemy, aggressive_mode, ignore_surpression) {
  if(isDefined(self.script_noteworthy) && self.script_int > 0) {
    self.animname = "misc_patrol";
    self set_run_anim(self.script_noteworthy);
  }

  self.ignoreall = 1;
  self.goalradius = 48;
  self waittill("goal");
  self entity_common_spawn_setup(e_spawner, str_cleanup_category, player_favourate_enemy, ignore_surpression);

  if(isDefined(self.target)) {
    nd_node = getnode(self.target, "targetname");

    while(isDefined(nd_node.target)) {
      nd_node = getnode(nd_node.target, "targetname");

      for(dist = distance(self.origin, nd_node.origin); dist > 48; dist = distance(self.origin, nd_node.origin)) {
        self setgoalpos(nd_node.origin);
        self.goalradius = 48;
        wait 0.01;
      }
    }
  }

  self delete();
}

entity_common_spawn_setup(e_spawner, str_cleanup_category, player_favourate_enemy, ignore_surpression) {
  if(isDefined(e_spawner))
    self setup_spawner_special_features(e_spawner);

  if(isDefined(str_cleanup_category))
    spawner_set_cleanup_category(str_cleanup_category);

  if(isDefined(player_favourate_enemy) && player_favourate_enemy != 0)
    self.favoriteenemy = level.player;

  if(isDefined(ignore_surpression) && ignore_surpression != 0)
    self.script_ignore_suppression = 1;
}

enemy_damage_override(inflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname) {
  if(isDefined(eattacker) && isDefined(eattacker.i_dont_want_to_hurt_you))
    idamage = 1;

  return idamage;
}

setup_spawner_special_features(e_spawner) {
  if(isDefined(e_spawner.script_health)) {
    self.health = e_spawner.script_health;
    iprintlnbold("Overriding Health");
  }

  if(isDefined(e_spawner.script_int))
    self thread ai_turn_off_hold_node_after_time(e_spawner.script_int);

  if(isDefined(e_spawner.script_float)) {
    self.accuracy = e_spawner.script_float;
    self.script_accuracy = e_spawner.script_float;
  }

  if(isDefined(e_spawner.script_timer) && isDefined(e_spawner.script_string))
    self thread ai_break_holding_node_timer(e_spawner.script_timer, e_spawner.script_string);

  if(isDefined(e_spawner.script_index))
    self.grenadeammo = 0;
}

ai_turn_off_hold_node_after_time(delay) {
  self endon("death");
  wait(delay);
  self.fixednode = 0;
  self.goalradius = 2048;
}

ai_break_holding_node_timer(wait_time, str_target_node) {
  self endon("death");
  wait(wait_time);
  self.fixednode = 0;
  nd_node = getnode(str_target_node, "targetname");
  self.goalradius = 48;
  self setgoalnode(nd_node);
  self waittill("goal");
  self.goalradius = 2048;
}

ai_set_allow_friendly_fire() {
  self.no_friendly_fire_penalty = 1;
  self.ignoreforfriendlyfire = 1;
  self.nofriendlyfire = 1;
}

enemy_ai_disable_grenades(disable_grenades, delay) {
  if(isDefined(delay) && delay > 0)
    wait(delay);

  ai = getaiarray("axis");

  if(isDefined(ai)) {
    for(i = 0; i < ai.size; i++) {
      e_ent = ai[i];

      if(disable_grenades) {
        e_ent.temp_grenade_num = e_ent.grenadeammo;
        e_ent.grenadeammo = 0;
        continue;
      }

      if(isDefined(e_ent.temp_grenade_num))
        e_ent.grenadeammo = e_ent.temp_grenade_num;
    }
  }
}

ai_set_enemy_rage_behaviour(set_rage_behaviour) {
  ai = getaiarray("axis");

  if(isDefined(ai)) {
    for(i = 0; i < ai.size; i++) {
      e_ent = ai[i];

      if(!set_rage_behaviour) {
        e_ent.pathenemyfightdist = 2048;
        e_ent.aggressivemode = 0;
        e_ent.forcechargedsniperdeath = 0;

        if(isDefined(e_ent.temp_grenade_num))
          e_ent.grenadeammo = e_ent.temp_grenade_num;

        continue;
      }

      e_ent ai_rage_behaviour();
    }
  }
}

ai_rage_behaviour() {
  self setgoalentity(level.player);
  self.pathenemyfightdist = 500;
  self.aggressivemode = 1;
  self.forcechargedsniperdeath = 1;
  self.temp_grenade_num = self.grenadeammo;
  self.grenadeammo = 0;
}

lerp_dof_over_time_pass_out(time) {
  incs = int(time / 0.05);
  incnearstart = (0 - 0) / incs;
  incnearend = (650 - 1) / incs;
  incfarstart = (700 - 8000) / incs;
  incfarend = (15000 - 10000) / incs;
  incnearblur = (10 - 6) / incs;
  incfarblur = (7 - 0) / incs;
  current_nearstart = 0;
  current_nearend = 1;
  current_farstart = 8000;
  current_farend = 10000;
  current_nearblur = 6;
  current_farblur = 0;

  for(i = 0; i < incs; i++) {
    self setdepthoffield(current_nearstart, current_nearend, current_farstart, current_farend, current_nearblur, current_farblur);
    current_nearstart = current_nearstart + incnearstart;
    current_nearend = current_nearend + incnearend;
    current_farstart = current_farstart + incfarstart;
    current_farend = current_farend + incfarend;
    current_nearblur = current_nearblur + incnearblur;
    current_farblur = current_farblur + incfarblur;
    wait 0.05;
  }
}

reset_dof() {
  self setdepthoffield(0, 1, 8000, 10000, 6, 0);
}

set_character_menendez() {
  update_player_model("c_mul_menendez_nicaragua_viewhands", "c_mul_menendez_nicaragua_viewbody");
  level.player loadout_weapons_store();
  level.player menendez_give_weapon();
  level.player loadout_perks_store();
  level.player loadout_perks_remove();
  level.player give_menendez_perks();
  level.callbackactorkilled = ::global_callback_actor_killed_menendez;
  level.player.overrideplayerdamage = ::rage_low_player_damage_override;
  setsaveddvar("player_standingViewHeight", 66);
  setsaveddvar("player_meleeHeight", 64);
  setsaveddvar("player_meleeRange", 128);
  setsaveddvar("player_meleeWidth", 64);
  setsaveddvar("player_meleeInterruptFrac", 0.65);
}

set_character_mason(b_restore_loadout) {
  if(!isDefined(b_restore_loadout))
    b_restore_loadout = 1;

  update_player_model("c_usa_seal80s_mason_viewhands", "c_usa_seal80s_mason_viewbody");

  if(b_restore_loadout) {
    level.player loadout_weapons_restore();
    level.player loadout_perks_restore();
    level.callbackactorkilled = ::global_callback_actor_killed_mason;
  }

  level.player.overrideplayerdamage = undefined;
  setsaveddvar("player_standingViewHeight", 60);
  setsaveddvar("player_meleeHeight", 10);
  setsaveddvar("player_meleeRange", 64);
  setsaveddvar("player_meleeWidth", 10);
  setsaveddvar("player_meleeInterruptFrac", 1);
}

update_player_model(str_hands_model, str_body_model) {
  level.player_viewmodel = str_hands_model;
  level.player_interactive_model = str_body_model;
  level.player setviewmodel(str_hands_model);
}

debug_print_line(str_text) {
  str_val = getDvar(#"_id_204C4196");

  if(isDefined(str_val) && str_val != "")
    iprintln(str_text);
}

func_on_notify(str_notify, func, param_1, param_2, param_3, param_4, param_5) {
  assert(isDefined(str_notify), "str_notify is a required parameter for func_on_notify");
  assert(isDefined(func), "func is a required parameter for func_on_notify");
  self thread _func_on_notify(str_notify, func, param_1, param_2, param_3, param_4, param_5);
}

_func_on_notify(str_notify, func, param_1, param_2, param_3, param_4, param_5) {
  if(str_notify != "death")
    self endon("death");

  self waittill(str_notify);
  single_func(self, func, param_1, param_2, param_3, param_4, param_5);
}

spawn_managers_kill_all_active() {
  a_spawn_managers = level.spawn_managers;

  if(a_spawn_managers.size > 0) {
    for(i = 0; i < a_spawn_managers.size; i++) {
      if(is_spawn_manager_enabled(a_spawn_managers[i].targetname))
        spawn_manager_disable(a_spawn_managers[i].targetname);
    }
  }
}

kill_all_ai(n_wait_min, n_wait_max) {
  a_guys = getaiarray();
  array_thread(a_guys, ::_kill_ai, n_wait_min, n_wait_max);
}

kill_ai_group(str_name, n_wait_min, n_wait_max) {
  if(!isDefined(n_wait_min))
    n_wait_min = 0.5;

  if(!isDefined(n_wait_max))
    n_wait_max = 3.5;

  a_guys = get_ai_group_ai(str_name);
  array_thread(a_guys, ::_kill_ai, n_wait_min, n_wait_max);
}

_kill_ai(n_wait_min, n_wait_max) {
  self endon("death");

  if(isDefined(n_wait_min) && isDefined(n_wait_max))
    wait(randomfloatrange(n_wait_min, n_wait_max));

  self bloody_death();
}

timescale_tween(start, end, time, delay, step_time) {
  if(!isDefined(delay))
    delay = 0.0;

  if(!isDefined(step_time))
    step_time = 0.1;

  if(!isDefined(start))
    start = gettimescale();

  num_steps = time / step_time;
  time_scale_range = end - start;
  time_scale_step = 0;

  if(num_steps > 0)
    time_scale_step = abs(time_scale_range) / num_steps;

  if(delay > 0.0)
    wait(delay);

  level notify("timescale_tween");
  level endon("timescale_tween");
  time_scale = start;
  settimescale(time_scale);

  while(time_scale != end) {
    wait(step_time);

    if(time_scale_range > 0)
      time_scale = min(time_scale + time_scale_step, end);
    else if(time_scale_range < 0)
      time_scale = max(time_scale - time_scale_step, end);

    settimescale(time_scale);
  }
}

mason_fail_condition(b_enabled, n_faildist) {
  if(!isDefined(b_enabled))
    b_enabled = 1;

  self notify("fail_disabled");
  self endon("fail_disabled");

  if(!b_enabled) {
    self notify("fail_disabled");
    return;
  }

  if(!isDefined(n_faildist) || n_faildist <= 0) {
    assertmsg("mason_fail_condition: " + n_faildist + " is not a valid numerical distance, must be greater than 0");
    return;
  }

  n_warning = n_faildist * 0.75;

  while(true) {
    n_delta = distance2d(level.player.origin, level.woods.origin);

    if(n_delta < n_warning) {
      wait 1;
      continue;
    } else if(n_delta >= n_warning && n_delta < n_faildist) {
      screen_message_create(&"NICARAGUA_MASON_FAIL_WARNING");
      wait 5;
      screen_message_delete();
    } else if(n_delta >= n_faildist) {
      mason_fail_kill();
      return;
    }
  }
}

mason_fail_kill() {
  setDvar("ui_deadquote", &"NICARAGUA_MASON_FAIL");
  wait 0.5;
  missionfailed();
}

wait_for_scene_to_nearly_complete(str_actor, str_scene, n_time_before_return) {
  if(!isDefined(n_time_before_return))
    n_time_before_return = 2;

  anim_time_check = level.scr_anim[str_actor][str_scene];
  n_anim_time = getanimlength(anim_time_check);
  n_wait_time = n_anim_time - n_time_before_return;
  wait(n_wait_time);
}

nicaragua_custom_introscreen(level_prefix, number_of_lines, totaltime, text_color) {
  luinotifyevent(&"hud_add_title_line", 4, level_prefix, number_of_lines, totaltime, text_color);
  wait 2.5;
}

threat_bias_add(str_bias_group) {
  if(!threatbiasgroupexists(str_bias_group)) {
    createthreatbiasgroup(str_bias_group);
    debug_print_line("new threatbias group created: " + str_bias_group);
  }

  self setthreatbiasgroup(str_bias_group);
}

threat_bias_set(str_bias_group, str_target_group, n_amount) {
  assert(n_amount >= -100 && n_amount <= 100, "threat_bias_set bias value outside range. Use a value between -100 and 100. Your value was " + n_amount);
  n_amount_scaled = int(clamp(n_amount * 20000.0, -2000000, 2000000));
  setthreatbias(str_bias_group, str_target_group, n_amount_scaled);
}

func_spawn_villager_run_to_volume(e_goal) {
  self endon("death");
  self set_goalradius(128);
  self setgoalvolumeauto(e_goal);
  self set_ignoreme(0);
  self.enemyaccuracy = 0.6;
  self waittill("goal");
  self die();
}

setup_scope_view() {
  self hide_hud();
  self hideviewmodel();
  setsaveddvar("cg_drawBreathHint", 0);
  setsaveddvar("cg_drawCrosshair", 0);
  self thread take_and_giveback_weapons("binoculars_scene_complete");
  wait 0.05;
  self enableweapons();
  self giveweapon("binocular_sp");
  self switchtoweapon("binocular_sp");
  self disableweaponfire();
  self allowads(0);
  level clientnotify("scope_on");
  level thread maps\createart\nicaragua_art::blend_exposure_over_time(3, 0.05);
  level.str_default_vision = self getvisionsetnaked();
  o_dichotomy = getent("mason_intro_scope_view", "targetname");
  self playerlinktodelta(o_dichotomy, undefined, 1, 10, 10, 10, 10);
  wait 0.05;
  e_room = get_struct("josephina_window_view", "targetname");
  player_org = self get_eye();
  vec_to_pt = e_room.origin - player_org;
  self setplayerangles(vectortoangles(vec_to_pt));
}

turn_on_scope_vision() {
  wait 0.05;
  self setdepthoffield(0, 650, 700, 15000, 6.5, 1.5);
  default_fov = getdvarfloat(#"cg_fov");
  current_fov = default_fov + 20;
  self setclientdvar("cg_fov", current_fov);
  level.player thread binocular_zoom_in(default_fov);
  level notify("binocular_scope_setup_COMPLETE");
}

binocular_zoom_in(default_fov) {
  level waittill("fade_in_complete");
  wait 2;
  screen_fade_out(0.75);
  self setclientdvar("cg_fov", default_fov);
  self setdepthoffield(0, 650, 700, 15000, 10, 7);
  self allowads(1);
  self setforceads(1);
  wait 0.05;
  screen_fade_in(0.75);
  self thread start_scope_scene();
}

start_scope_scene() {
  depth_of_field_tween(0, 1, 8000, 10000, 6, 0, 2.0);
  wait 0.15;
  depth_of_field_tween(0, 650, 700, 1500, 8, 3.5, 1.0);
  depth_of_field_tween(0, 1, 8000, 10000, 6, 0, 1.0);
  level notify("binoculars_zoomed_in");
}

turn_on_scope_vision_quick() {
  self allowads(1);
  self setforceads(1);
  wait 0.05;
  level notify("binocular_scope_setup_COMPLETE");
}

disable_scope_view() {
  self notify("binoculars_scene_complete");
  self setdepthoffield(0, 1, 8000, 10000, 6, 0);
  self turn_off_scope_vision();
  self takeweapon("binocular_sp");
  self setforceads(0);
  self enableweaponfire();
  level.player show_hud();
  setsaveddvar("cg_drawBreathHint", 1);
  setsaveddvar("cg_drawCrosshair", 1);
  level thread maps\createart\nicaragua_art::blend_exposure_over_time(2.2, 0.05);
  wait 0.05;
}

turn_off_scope_vision() {
  level clientnotify("scope_off");
  self visionsetnaked(level.str_default_vision, 0);
  level.str_default_vision = undefined;
}

start_charging_horse(str_horse_name, str_start_node, delay, n_speed, b_has_spawned) {
  if(isDefined(b_has_spawned) && b_has_spawned) {
    e_horse = getent(str_horse_name, "targetname");

    if(!is_alive(e_horse)) {
      break;
    }

    e_horse ent_flag_clear("pause_animation");
    e_horse notify("start_running");
  } else
    e_horse = maps\_vehicle::spawn_vehicle_from_targetname(str_horse_name);

  e_horse endon("death");

  if(isDefined(delay) && delay > 0)
    wait(delay);

  nd_horse_path_start = getvehiclenode(str_start_node, "targetname");
  e_horse thread go_path(nd_horse_path_start);
  e_horse waittill("reached_end_node");
  e_horse.delete_on_death = 1;
  e_horse notify("death");

  if(!isalive(e_horse))
    e_horse delete();
}

flame_vision_enabled() {
  a_t_triggers = getEntArray("fire_damage_trigger", "script_noteworthy");

  foreach(trigger in a_t_triggers)
  trigger thread flame_vision_trigger_think();
}

flame_vision_trigger_think() {
  level endon("mason_fire_damage_OFF");
  n_burn_time = 1.0;

  while(true) {
    self waittill("trigger", e_guy);

    if(isPlayer(e_guy)) {
      level.player setburn(n_burn_time);
      wait(n_burn_time);
    }
  }
}

_ai_use_turret(e_turret, b_teleport, t_trigger) {
  if(!isDefined(b_teleport))
    b_teleport = 0;

  if(!isalive(self)) {
    return;
  }
  if(isDefined(t_trigger))
    self thread _turret_exit_watcher(t_trigger);

  self.goalradius = 32;
  self change_movemode("sprint");

  if(e_turret maps\_turret::does_turret_need_user()) {
    e_turret setdefaultdroppitch(0);

    if(!e_turret maps\_turret::does_turret_have_user()) {
      if(isDefined(b_teleport) && b_teleport)
        self maps\_turret::use_turret_teleport(e_turret, 1);
      else {
        e_turret set_turret_burst_parameters(1.5, 3.5, 2.5, 3.5);
        self thread maps\_turret::use_turret(e_turret, 1);
        self thread reset_turret_drop_pitch(e_turret);
        e_turret maps\_turret::set_turret_ignore_line_of_sight(1);
      }
    }
  }
}

reset_turret_drop_pitch(e_turret) {
  self waittill("death");

  if(!isDefined(e_turret.script_int))
    n_pitch = -90;
  else
    n_pitch = e_turret.script_int;

  e_turret setdefaultdroppitch(n_pitch);
}

_turret_exit_watcher(t_trigger) {
  self endon("death");
  t_trigger _trigger_wait();
  self maps\_turret::stop_use_turret();
  self.goalradius = 2048;
}

delete_menendez_scenes() {
  delete_scene_all("menendez_intro_part1", 1);
  delete_scene("menendez_intro_part2", 1);
  delete_scene_all("menendez_intro_part2_picture", 1);
  delete_scene_all("noriega_arrives", 1);
  delete_scene_all("noriega_arrives_cuffs", 1);
  delete_scene_all("noriega_arrives_pdf_1", 1);
  delete_scene_all("noriega_arrives_pdf_2", 1);
  delete_scene_all("mh_shot_in_the_back_civs", 1);
  delete_scene_all("mh_civ_carries_civ", 1);
  delete_scene_all("door_death", 1);
  delete_scene_all("execution_loop", 1);
  delete_scene_all("execution_civ_1", 1);
  delete_scene_all("execution_civ_2", 1);
  delete_scene_all("execution_civ_3", 1);
  delete_scene_all("execution_civ_4", 1);
  delete_scene_all("execution_civ_5", 1);
  delete_scene_all("execution_pdf_1", 1);
  delete_scene_all("execution_pdf_2", 1);
  delete_scene_all("execution_pdf_3", 1);
  delete_scene_all("execution_pdf_4", 1);
  delete_scene_all("execution_pdf_5", 1);
  delete_scene_all("execution_escape_1", 1);
  delete_scene_all("execution_escape_2", 1);
  delete_scene_all("execution_escape_3", 1);
  delete_scene_all("execution_escape_4", 1);
  delete_scene_all("execution_escape_5", 1);
  delete_scene_all("axe_attack_pdf_loop", 1);
  delete_scene_all("axe_attack_pdf", 1);
  delete_scene_all("axe_attack_prop", 1);
  delete_scene_all("axe_attack_player", 1);
  delete_scene_all("execution_watchers_idle", 1);
  delete_scene_all("execution_watcher_react_roof", 1);
  delete_scene_all("execution_watcher_react_molotov", 1);
  delete_scene_all("execution_molotv_idle", 1);
  delete_scene_all("execution_molotv_react", 1);
  delete_scene_all("slide_to_cover", 1);
  delete_scene_all("brutality_civ_idle_1", 1);
  delete_scene_all("brutality_pdf_idle_1", 1);
  delete_scene_all("brutality_civ_react_1", 1);
  delete_scene_all("brutality_pdf_react_1", 1);
  delete_scene_all("brutality_civ_idle_2", 1);
  delete_scene_all("brutality_pdf_idle_2", 1);
  delete_scene_all("brutality_civ_react_2", 1);
  delete_scene_all("brutality_pdf_react_2", 1);
  delete_scene_all("barn_doors", 1);
  delete_scene_all("barn_door_player", 1);
  delete_scene_all("balcony_throw", 1);
  delete_scene_all("shattered_1", 1, 1);
}

#using_animtree("critter");

chicken_anim_loop() {
  self endon("deleted");
  self endon("death");
  self.health = 99999;
  self setCanDamage(1);
  self useanimtree(#animtree);
  self thread chicken_anim_death();
  wait(randomfloatrange(0.25, 2.0));

  while(true) {
    rand = randomint(100);
    self clearanim(%root, 0.0);

    if(rand < 35) {
      self setanim(%a_chicken_idle, 1, 0, 1);
      anim_durration = getanimlength(%a_chicken_idle);
    } else if(rand > 35 && rand < 70) {
      self setanim(%a_chicken_idle_a, 1, 0, 1);
      anim_durration = getanimlength(%a_chicken_idle_a);
    } else {
      self setanim(%a_chicken_idle_peck, 1, 0, 1);
      anim_durration = getanimlength(%a_chicken_idle_peck);
    }

    wait(anim_durration);
  }
}

chicken_anim_death() {
  self endon("deleted");
  self waittill("damage");
  self notify("death");
  self clearanim(%root, 0.0);
  rand = randomint(100);

  if(rand < 50) {
    self setanim(%a_chicken_death, 1, 0, 1);
    anim_durration = getanimlength(%a_chicken_death);
  } else {
    self setanim(%a_chicken_death_a, 1, 0, 1);
    anim_durration = getanimlength(%a_chicken_death_a);
  }

  wait(anim_durration);
  level notify("chicken_died");
}

chicken_cleanup() {
  assert(isDefined(self), "Function ran on an undefined chicken!");
  self notify("deleted");
  self delete();
}

timebomb(n_min, n_max) {
  self endon("death");

  if(!isalive(self)) {
    return;
  }
  if(isDefined(n_min) && isDefined(n_max)) {
    if(n_min < n_max)
      wait(randomfloatrange(n_min, n_max));
  }

  self bloody_death();
}

getmasonallies() {
  a_ai_allies = getaiarray("allies");

  if(a_ai_allies.size == 0)
    return undefined;

  a_ai_allies = remove_heroes_from_array(a_ai_allies);
  return a_ai_allies;
}

make_ai_aggressive() {
  self endon("death");
  self.aggressivemode = 1;
  self.canflank = 1;
}

hide_ammo_count() {
  level.player.b_weapons_disabled = 1;
  level.player hide_hud();
}

menendez_cleanup_after_anim() {
  self enableweapons();
}

show_ammo_count() {
  level.player.b_weapons_disabled = undefined;
  level.player show_hud();
}

brutality_scene(n_anim_set, str_align, str_civ, str_pdf, str_trig_idle, str_trig_react, str_vol_civ, b_ignore_pdf) {
  if(isDefined(str_trig_idle))
    trigger_wait(str_trig_idle);

  add_scene_properties("brutality_civ_idle_" + n_anim_set, str_align);
  add_scene_properties("brutality_pdf_idle_" + n_anim_set, str_align);
  ai_civ = simple_spawn_single(str_civ);
  add_generic_ai_to_scene(ai_civ, "brutality_civ_idle_" + n_anim_set);
  ai_pdf = simple_spawn_single(str_pdf);
  add_generic_ai_to_scene(ai_pdf, "brutality_pdf_idle_" + n_anim_set);
  level thread run_scene("brutality_civ_idle_" + n_anim_set);
  level thread run_scene("brutality_pdf_idle_" + n_anim_set);
  ai_pdf thread brutality_done_by_pdf_death(str_trig_react);

  if(isDefined(b_ignore_pdf) && b_ignore_pdf)
    self.ignoreme = 1;

  trigger_wait(str_trig_react);

  if(isalive(ai_civ)) {
    add_scene_properties("brutality_civ_react_" + n_anim_set, str_align);
    add_generic_ai_to_scene(ai_civ, "brutality_civ_react_" + n_anim_set);
    ai_civ thread civ_escape(str_vol_civ);
    level thread run_scene("brutality_civ_react_" + n_anim_set);
  }

  if(isalive(ai_pdf)) {
    add_scene_properties("brutality_pdf_react_" + n_anim_set, str_align);
    add_generic_ai_to_scene(ai_pdf, "brutality_pdf_react_" + n_anim_set);
    level thread run_scene("brutality_pdf_react_" + n_anim_set);
    ai_pdf thread brutality_pdf_final_goal_pos("brutality_pdf_react_" + n_anim_set, b_ignore_pdf);
  }
}

brutality_pdf_final_goal_pos(str_scene, b_ignore_pdf) {
  self endon("death");
  scene_wait(str_scene);
  self setgoalpos(self.origin);

  if(isDefined(b_ignore_pdf) && b_ignore_pdf)
    self.ignoreme = 0;
}

brutality_done_by_pdf_death(str_trig_react) {
  self waittill("death");
  t_react = getent(str_trig_react, "targetname");

  if(isDefined(t_react))
    trigger_use(str_trig_react);
}

civ_escape(str_vol) {
  self endon("death");
  level.n_civilians_saved++;
  self.overrideactordamage = ::brutality_civ_ai_damage_override;
  self set_goalradius(128);
  self set_ignoreme(0);
  self.enemyaccuracy = 0.6;
  v_civ_goal = get_ent(str_vol, "targetname", 1);
  self setgoalvolumeauto(v_civ_goal);
  self waittill("goal");
  self die();
}

brutality_civ_ai_damage_override(e_inflictor, e_attacker, n_damage, n_dflags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, n_model_index, psoffsettime, str_bone_name) {
  if(isDefined(e_inflictor.team) && e_inflictor.team == "axis")
    n_damage = 0;

  return n_damage;
}

achievement_stop_brutality() {
  level endon("menendez_section_done");
  level.n_civilians_saved = 0;

  while(level.n_civilians_saved < 11)
    wait 0.5;

  self giveachievement_wrapper("SP_STORY_99PERCENT");
}

menendez_spawners_clean_up() {
  delete_spawners_by_classname("actor_Ally_Cartel_Assault_Base");
  delete_spawners_by_classname("actor_Ally_Cartel_Launcher_Base");
  delete_spawners_by_classname("actor_Ally_Cartel_LMG_Base");
  delete_spawners_by_classname("actor_Ally_Cartel_Shotgun_Base");
  delete_spawners_by_classname("actor_Ally_Cartel_SMG_Base");
  delete_spawners_by_classname("actor_Ally_Cartel_Sniper_Base");
  delete_spawners_by_classname("actor_Enemy_PDF_Nicaragua_Assault_Base");
  delete_spawners_by_classname("actor_Enemy_PDF_Nicaragua_Launcher_Base");
  delete_spawners_by_classname("actor_Enemy_PDF_Nicaragua_LMG_Base");
  delete_spawners_by_classname("actor_Enemy_PDF_Nicaragua_Shotgun_Base");
  delete_spawners_by_classname("actor_Enemy_PDF_Nicaragua_SMG_Base");
  delete_spawners_by_classname("actor_Enemy_PDF_Nicaragua_Sniper_Base");
}

delete_spawners_by_classname(str_classname) {
  a_spawners = getEntArray(str_classname, "classname");

  foreach(sp_ai in a_spawners)
  sp_ai delete();
}

make_friendlies_ignore_grenades() {
  self endon("death");
  self.grenadeawareness = 0;
}

random_shuffle(a_items) {
  b_done_shuffling = undefined;
  item = a_items[a_items.size - 1];

  while(!(isDefined(b_done_shuffling) && b_done_shuffling)) {
    a_items = array_randomize(a_items);

    if(a_items[0] != item)
      b_done_shuffling = 1;

    wait 0.05;
  }

  return a_items;
}

say_dialog_and_waittill_death(str_vo) {
  self endon("death");
  self maps\_dialog::say_dialog(str_vo);
  self waittill("death");
}

nicaragua_interstial_movie(str_movie) {
  flag_clear("movie_ended");
  play_movie(str_movie, 0, 0, undefined, 1);
  flag_set("movie_ended");
}

destructibles_in_area(str_area) {
  e_area = getent(str_area, "script_noteworthy");
  a_script_models = getEntArray("script_model", "classname");

  foreach(m_script in a_script_models) {
    if(_model_is_exempt(m_script) || !m_script istouching(e_area)) {
      continue;
    }
    if(isDefined(m_script.destructibledef))
      m_script thread destructible_damage_logic();
  }
}

destructible_damage_logic() {
  self endon("death");
  self.b_already_damage_by_player = 0;

  while(true) {
    self waittill("damage", n_damage, e_inflictor);

    if(isDefined(e_inflictor) && e_inflictor == level.player) {
      if(isDefined(self.b_already_damage_by_player) && self.b_already_damage_by_player)
        self dodamage(self.health, self.origin);

      self.b_already_damage_by_player = 1;
    }

    wait 0.05;
  }
}

fxanim_deconstructions() {
  fxanim_deconstructions_for_menendez_side();
  fxanim_deconstructions_for_mason_side1();
  fxanim_deconstructions_for_mason_side2();
}

fxanim_deconstructions_for_menendez_side() {
  fxanim_deconstruction_with_existence_check("fxanim_bridge_drop");
  fxanim_deconstruction_with_existence_check("fxanim_barn_explode_01");
  fxanim_deconstruction_with_existence_check("fxanim_barn_explode_02");
  fxanim_deconstruction_with_existence_check("fxanim_sunshade_reed");
  fxanim_deconstruction_with_existence_check("fxanim_gate_crash");
}

fxanim_deconstruction_with_existence_check(str_fxanim_model) {
  a_fxanim_models = getEntArray(str_fxanim_model, "targetname");

  if(a_fxanim_models.size > 0)
    fxanim_deconstruct(str_fxanim_model);
}

fxanim_deconstructions_for_mason_side1() {
  fxanim_deconstruct("fxanim_watertower_river");
  fxanim_deconstruct("fxanim_hut_river");
  fxanim_deconstruct("fxanim_porch_explode");
  fxanim_deconstruct("fxanim_hut_explode");
  fxanim_deconstruct("fxanim_hut_explode_watertower");
  fxanim_deconstruct("fxanim_trough_break_1");
  fxanim_deconstruct("fxanim_trough_break_2");
  fxanim_deconstruct("fxanim_truck_fence");
}

fxanim_deconstructions_for_mason_side2() {
  fxanim_deconstruct("fxanim_archway");
  fxanim_deconstruct("fxanim_fountain");
}

model_removal_through_model_convert_system(area) {
  model_restore_area(area);
  model_delete_area(area);
}

convert_mason_models() {
  model_convert_area("mason_hill_1");
  model_convert_area("mason_hill_2");
  model_convert_area("mason_mission");
  model_convert_area("mason_bunker");
  model_convert_area("mason_final_push");
  model_convert_area("mason_outro");
}

courtyard_truck_spawn_func() {
  self makevehicleusable();
  self.takedamage = 0;
  self thread maps\_turret::enable_turret(1);
  self playSound("evt_gate_truck_approach");
  self waittill("wait_in_town");
  flag_init("truck_in_town");
  flag_set("truck_in_town");
  self setspeed(0);
  self setbrake(1);
  autosave_by_name("truck_is_in_town");
}

func_spawn_truck_gunner() {
  self endon("death");
  self magic_bullet_shield();
  trigger_wait("trig_gunner_death");
  self stop_magic_bullet_shield();
  self bloody_death();
}

func_spawn_truck_driver() {
  self endon("death");
  self magic_bullet_shield();
  vh_truck = getent("cartel_courtyard_truck", "targetname");
  vh_truck waittill("reached_end_node");
  self stop_magic_bullet_shield();
}

set_mason_truck_burst_parameters(n_turret_index) {
  switch (getdifficulty()) {
    case "easy":
      n_x = randomfloatrange(-24, 24);
      n_y = randomfloatrange(-24, 24);
      n_z = randomfloatrange(40, 64);
      n_fire_min = 3;
      n_fire_max = 5;
      n_wait_min = 1.5;
      n_wait_max = 3;
      n_fire_time = -1;
      break;
    case "hard":
      n_x = randomfloatrange(-8, 8);
      n_y = randomfloatrange(-8, 8);
      n_z = randomfloatrange(40, 64);
      n_fire_min = 5;
      n_fire_max = 7;
      n_wait_min = 1.0;
      n_wait_max = 1.5;
      n_fire_time = -1;
      break;
    case "fu":
      n_x = 0;
      n_y = 0;
      n_z = 40;
      n_fire_min = 6;
      n_fire_max = 8;
      n_wait_min = 0.5;
      n_wait_max = 1.0;
      n_fire_time = -1;
      break;
    default:
      n_x = randomfloatrange(-16, 16);
      n_y = randomfloatrange(-16, 16);
      n_z = randomfloatrange(40, 64);
      n_fire_min = 3;
      n_fire_max = 5;
      n_wait_min = 1.0;
      n_wait_max = 1.5;
      n_fire_time = -1;
      break;
  }

  v_offset = (n_x, n_y, n_z);
  self maps\_turret::set_turret_burst_parameters(n_fire_min, n_fire_max, n_wait_min, n_wait_max, n_turret_index);
  return v_offset;
}