/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\karma_civilians.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\karma_util;
#include maps\_scene;
#include maps\_anim;
#include animscripts\anims;
#include animscripts\utility;
#include animscripts\shared;
#include maps\_drones;

civ_precache() {
  precachemodel("p6_anim_bluetooth_female");
  precachemodel("p6_anim_bluetooth_male");
  precachemodel("p6_anim_cell_phone");
  precachemodel("p6_anim_shopping_bag_red");
  precachemodel("p6_anim_shopping_bag_blue");
  precachemodel("com_metal_briefcase");
  precachemodel("p6_water_bottle");
  precachemodel("ma_cup_smoothie");
  precachemodel("ma_cup_single_closed");
  precachemodel("popcorn_cup_single");
  precachemodel("food_soda_single01");
  precachemodel("food_soda_single02");
}

civ_init() {
  level.a_sp_civs = [];
  level.civ_get_goal_func["ent"]["target"] = ::get_target_ents;
  level.civ_get_goal_func["ent"]["linkto"] = ::get_linked_ents;
  level.civ_get_goal_func["node"]["target"] = ::get_target_nodes;
  level.civ_get_goal_func["node"]["linkto"] = ::get_linked_nodes;
  level.civ_set_goal_func["ent"] = ::set_goal_ent;
  level.civ_set_goal_func["node"] = ::set_goal_node;
  level.civ_init = 1;
  level.a_str_civ_props["phone"][0] = "p6_anim_cell_phone";
  level.a_str_civ_props["drink"][0] = "p6_water_bottle";
  level.a_str_civ_props["drink"][1] = "ma_cup_smoothie";
  level.a_str_civ_props["drink"][2] = "ma_cup_single_closed";
  level.a_str_civ_props["drink"][3] = "popcorn_cup_single";
  level.a_str_civ_props["drink"][4] = "food_soda_single01";
  level.a_str_civ_props["drink"][5] = "food_soda_single02";
}

set_civilian_run_cycle(str_state, anim_override) {
  self.alwaysrunforward = 1;

  if(isDefined(anim_override))
    anime = anim_override;
  else if(isarray(level.scr_anim[self.script_string][self.anim_set][str_state]))
    anime = random(level.scr_anim[self.script_string][self.anim_set][str_state]);
  else
    anime = level.scr_anim[self.script_string][self.anim_set][str_state];

  self.a.combatrunanim = anime;
  self.run_noncombatanim = anime;
  self.walk_combatanim = anime;
  self.walk_noncombatanim = anime;
}

spawn_civs(str_spawn_loc, n_max_spawns, str_starter_loc, n_initial_spawns, str_endon, n_min_spawn_delay, n_max_spawn_delay) {
  level endon("stop_civ_spawns");

  if(isDefined(str_endon))
    level endon(str_endon);

  if(!isDefined(n_initial_spawns))
    n_initial_spawns = 0;

  if(!isDefined(n_min_spawn_delay))
    n_min_spawn_delay = 1.0;

  if(!isDefined(n_max_spawn_delay))
    n_max_spawn_delay = 4.0;

  level.ai_civs = [];
  a_nd_spawn_locs = getnodearray(str_spawn_loc, "targetname");

  if(isDefined(str_starter_loc)) {
    a_nd_patrol_locs = getnodearray(str_starter_loc, "targetname");
    a_nd_initial_locs = arraycombine(a_nd_spawn_locs, a_nd_patrol_locs, 1, 0);
    a_nd_initial_locs = array_randomize(a_nd_initial_locs);
  }

  while(true) {
    if(level.ai_civs.size < n_max_spawns) {
      ai_civ = pick_a_civ();

      if(isDefined(ai_civ)) {
        if(level.ai_civs.size < n_initial_spawns && isDefined(a_nd_initial_locs))
          nd_start = a_nd_initial_locs[level.ai_civs.size];
        else
          nd_start = random(a_nd_spawn_locs);

        ai_civ.targetname = "civilian";
        ai_civ forceteleport(nd_start.origin, nd_start.angles);
        ai_civ thread wander(nd_start);
        level.ai_civs[level.ai_civs.size] = ai_civ;
      }
    }

    if(level.ai_civs.size <= n_initial_spawns)
      wait 0.1;
    else
      wait(randomfloatrange(n_min_spawn_delay, n_max_spawn_delay));
  }
}

pick_a_civ(str_type) {
  if(!isDefined(str_type) || !isDefined(level.a_sp_civs[str_type])) {
    a_keys = getarraykeys(level.a_sp_civs);
    str_type = a_keys[randomint(a_keys.size)];
  }

  sp_last = level.a_sp_civs[str_type][level.n_curr_sp_civ[str_type]];
  level.n_curr_sp_civ[str_type]++;

  if(level.n_curr_sp_civ[str_type] >= level.a_sp_civs[str_type].size - 1) {
    level.a_sp_civs[str_type] = array_randomize(level.a_sp_civs[str_type]);

    if(level.a_sp_civs[str_type][0] == sp_last && level.a_sp_civs[str_type].size > 1)
      level.n_curr_sp_civ[str_type] = 1;
    else
      level.n_curr_sp_civ[str_type] = 0;
  }

  sp_civ = level.a_sp_civs[str_type][level.n_curr_sp_civ[str_type]];
  sp_civ.count = 2;

  for(ai_civ = simple_spawn_single(sp_civ); !isDefined(ai_civ); ai_civ = simple_spawn_single(sp_civ))
    wait 1.0;

  return ai_civ;
}

wander(start_target) {
  if(!isDefined(level.civ_init))
    civ_init();

  if(isDefined(self.enemy)) {
    return;
  }
  self endon("death");
  self endon("end_patrol");
  self thread waittill_death();
  self.goalradius = 32;
  self allowedstances("stand");
  self.allowdeath = 1;
  self.script_patroller = 1;
  self.patroller_delete_on_path_end = 1;
  self.disableturns = 1;
  self ent_flag_init("moving_to_goal");
  self ent_flag_init("wander_pause");
  waittillframeend;
  self pushplayer(0);

  if(!isDefined(self.script_string))
    self.script_string = "civ_male";

  self init_anim_set_overrides();
  self civ_spawn_props();

  if(isDefined(level.a_civ_wander_anim_points) && randomint(100) < 45)
    self thread goto_wander_anim_point();

  if(isDefined(start_target) && isstring(start_target)) {
    self.target = start_target;
    assert(isDefined(self.target) || isDefined(self.script_linkto), "Patroller with no target or script_linkto defined.");

    if(isDefined(self.target)) {
      str_link_type = "target";
      ents = self get_target_ents();
      nodes = self get_target_nodes();

      if(ents.size) {
        currentgoal = random(ents);
        str_goal_type = "ent";
      } else {
        currentgoal = random(nodes);
        str_goal_type = "node";
      }
    } else {
      str_link_type = "linkto";
      ents = self get_linked_ents();
      nodes = self get_linked_nodes();

      if(ents.size) {
        currentgoal = random(ents);
        str_goal_type = "ent";
      } else {
        currentgoal = random(nodes);
        str_goal_type = "node";
      }
    }
  } else {
    self.target = start_target.targetname;
    currentgoal = start_target;
    str_link_type = "target";

    if(start_target.type == "Path")
      str_goal_type = "node";
    else
      str_goal_type = "ent";
  }

  assert(isDefined(currentgoal), "Initial goal for patroller is undefined");
  nextgoal = currentgoal;

  while(true) {
    while(isDefined(nextgoal.patrol_claimed))
      wait 0.05;

    currentgoal.patrol_claimed = undefined;
    currentgoal = nextgoal;
    self.currentgoal = currentgoal;
    self notify("release_node");
    assert(!isDefined(currentgoal.patrol_claimed), "Goal was already claimed");

    if(!(isDefined(self.patrol_dont_claim_node) && self.patrol_dont_claim_node) && (isDefined(currentgoal.script_animation) && currentgoal.script_animation != "delete"))
      currentgoal.patrol_claimed = 1;

    self.last_patrol_goal = currentgoal;
    self wander_to_goal(str_goal_type, currentgoal);

    while(self ent_flag("wander_pause")) {
      self waittill("restart_moving_to_goal");
      self wander_to_goal(str_goal_type, currentgoal);
    }

    self ent_flag_clear("moving_to_goal");
    currentgoal notify("trigger", self);

    if(isDefined(currentgoal.script_animation)) {
      stop = "patrol_stop";
      self anim_generic_custom_animmode(self, "gravity", stop);
      wait 1.0;

      switch (currentgoal.script_animation) {
        case "turn180":
          turn = "patrol_turn180";
          self anim_generic_custom_animmode(self, "gravity", turn);
          break;
        case "smoke":
          anime = "patrol_idle_1";
          self anim_generic(self, anime);
          start = "patrol_start";
          self anim_generic_custom_animmode(self, "gravity", start);
          break;
        case "stretch":
          anime = "patrol_idle_1";
          self anim_generic(self, anime);
          start = "patrol_start";
          self anim_generic_custom_animmode(self, "gravity", start);
          break;
        case "checkphone":
          anime = "patrol_idle_1";
          self anim_generic(self, anime);
          start = "patrol_start";
          self anim_generic_custom_animmode(self, "gravity", start);
          break;
        case "phone":
          anime = "patrol_idle_1";
          self anim_generic(self, anime);
          start = "patrol_start";
          self anim_generic_custom_animmode(self, "gravity", start);
          break;
        default:
          self anim_generic(self, currentgoal.script_animation);
          self anim_generic_custom_animmode(self, "gravity", "patrol_start");
          break;
      }
    }

    currentgoals = currentgoal[[level.civ_get_goal_func[str_goal_type][str_link_type]]]();

    if(!currentgoals.size) {
      self notify("reached_path_end");

      if(isDefined(self) && isDefined(self.patroller_delete_on_path_end) && self.patroller_delete_on_path_end) {
        release_claimed_node();
        arrayremovevalue(level.ai_civs, self);
        self notify("patroller_deleted_on_path_end");
        self delete();
      }

      break;
    }

    nextgoal = random(currentgoals);

    if(isDefined(currentgoal.script_int) && isDefined(nextgoal.script_int) && currentgoals.size > 1) {
      while(isDefined(nextgoal.script_int) && currentgoal.script_int == nextgoal.script_int) {
        nextgoal = random(currentgoals);
        wait 0.05;
      }
    }
  }
}

init_anim_set_overrides() {
  assert(isDefined(level.scr_anim[self.script_string]), "There is no anim set for " + self.script_string);
  self.disablearrivals = 1;
  self.disableexits = 1;
  a_str_anim_sets = getarraykeys(level.scr_anim[self.script_string]);
  self.anim_set = random(a_str_anim_sets);
  self set_civilian_run_cycle("walk");
  self animscripts\anims::setidleanimoverride(level.scr_anim[self.script_string][self.anim_set]["idle"]);

  if(!isDefined(self.anim_array))
    self.anim_array = [];

  self.anim_array[self.animtype]["turn"]["stand"]["none"]["turn_f_l_45"] = level.scr_anim[self.script_string][self.anim_set]["turn_l"];
  self.anim_array[self.animtype]["turn"]["stand"]["none"]["turn_f_l_90"] = level.scr_anim[self.script_string][self.anim_set]["turn_l"];
  self.anim_array[self.animtype]["turn"]["stand"]["none"]["turn_f_l_135"] = level.scr_anim[self.script_string][self.anim_set]["turn_l"];
  self.anim_array[self.animtype]["turn"]["stand"]["none"]["turn_f_l_180"] = level.scr_anim[self.script_string][self.anim_set]["turn_l"];
  self.anim_array[self.animtype]["turn"]["stand"]["none"]["turn_f_r_45"] = level.scr_anim[self.script_string][self.anim_set]["turn_r"];
  self.anim_array[self.animtype]["turn"]["stand"]["none"]["turn_f_r_90"] = level.scr_anim[self.script_string][self.anim_set]["turn_r"];
  self.anim_array[self.animtype]["turn"]["stand"]["none"]["turn_f_r_135"] = level.scr_anim[self.script_string][self.anim_set]["turn_r"];
  self.anim_array[self.animtype]["turn"]["stand"]["none"]["turn_f_r_180"] = level.scr_anim[self.script_string][self.anim_set]["turn_r"];
  self set_exception("stop_immediate", ::civ_stop_callback);
}

civ_spawn_props() {
  if(isDefined(self.anim_set) && isDefined(level.a_str_civ_props[self.anim_set])) {
    if(self.script_string == "civ_male")
      self attach(random(level.a_str_civ_props[self.anim_set]), "TAG_WEAPON_LEFT");
    else
      self attach(random(level.a_str_civ_props[self.anim_set]), "TAG_WEAPON_RIGHT");
  }

  if(randomint(100) > 60 && self.anim_set != "phone") {
    if(self.script_string == "civ_female")
      self attach("p6_anim_bluetooth_female", "J_Head");
    else
      self attach("p6_anim_bluetooth_male", "J_Head");
  }
}

#using_animtree("generic_human");

civ_stop_callback() {
  n_player_near_dist = 5184;
  n_pathing_fov = cos(45);
  n_dist = distancesquared(self.origin, level.player.origin);
  v_facing = anglestoforward(self.angles);
  v_to_player = vectornormalize(level.player.origin - self.origin);
  n_facing_offset = vectordot(v_facing, v_to_player);

  if(n_dist < n_player_near_dist && n_facing_offset > n_pathing_fov) {
    self ent_flag_set("wander_pause");
    self setgoalpos(self.origin);
    self animscripts\utility::setlookatentity(level.player);
    self orientmode("face point", level.player.origin);
    anim_bump = level.scr_anim[self.script_string][self.anim_set]["bump"];
    self setflaggedanimknoballrestart("bump", anim_bump, % root);
    self animscripts\shared::donotetracks("bump");
    self thread civ_bumped();
  }
}

civ_bumped() {
  n_player_far_dist = 9216;
  n_pathing_fov = cos(45);
  n_timeout = gettime() + 5000;

  while(gettime() < n_timeout) {
    n_dist = distancesquared(self.origin, level.player.origin);
    v_facing = anglestoforward(self.angles);
    v_to_player = vectornormalize(level.player.origin - self.origin);
    n_facing_offset = vectordot(v_facing, v_to_player);

    if(n_dist > n_player_far_dist || n_facing_offset < n_pathing_fov) {
      break;
    }

    wait 1.0;
  }

  self animscripts\utility::stoplookingatentity();
  self orientmode("face default");
  self ent_flag_clear("wander_pause");
  self notify("restart_moving_to_goal");
}

wander_to_goal(str_goal_type, currentgoal) {
  self endon("interrupt_wandering");
  [[level.civ_set_goal_func[str_goal_type]]](currentgoal);
  self ent_flag_set("moving_to_goal");

  if(isDefined(currentgoal.radius) && currentgoal.radius > 0)
    self.goalradius = currentgoal.radius;
  else
    self.goalradius = 32;

  self waittill("goal");
}

assign_wander_anim_points(str_name, str_key) {
  level.a_civ_wander_anim_points = getnodearray(str_name, str_key);
}

goto_wander_anim_point() {
  self endon("death");
  wait(randomfloatrange(10.0, 60.0));
  b_point_found = 0;

  while(!b_point_found) {
    foreach(nd_point in level.a_civ_wander_anim_points) {
      if(!(isDefined(nd_point.patrol_claimed) && nd_point.patrol_claimed) && distancesquared(self.origin, nd_point.origin) < 262144) {
        v_to_point = nd_point.origin - self.origin;
        n_dot = vectordot(v_to_point, anglestoforward(self.angles));

        if(n_dot > 0.2588) {
          b_point_found = 1;
          nd_anim_point = nd_point;
        }

        break;
      }
    }

    if(!b_point_found)
      wait 5.0;
  }

  if(!isDefined(nd_anim_point)) {
    return;
  }
  self notify("interrupt_wandering");
  nd_anim_point.patrol_claimed = 1;
  self ent_flag_set("wander_pause");
  self.nd_curr_goal = nd_anim_point;
  self setgoalnode(nd_anim_point);
  self waittill("goal");
  self orientmode("face angle", nd_anim_point.angles[1]);
  wait(randomfloatrange(5, 20));
  self orientmode("face default");
  self ent_flag_clear("wander_pause");
  nd_anim_point.patrol_claimed = undefined;

  if(self ent_flag("moving_to_goal"))
    self notify("restart_moving_to_goal");
}

waittill_death() {
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }
  release_claimed_node();
}

release_claimed_node() {
  self notify("release_node");

  if(!isDefined(self.last_patrol_goal)) {
    return;
  }
  self.last_patrol_goal.patrol_claimed = undefined;
}

get_target_ents() {
  array = [];

  if(isDefined(self.target))
    array = getentarray(self.target, "targetname");

  return array;
}

get_target_nodes() {
  array = [];

  if(isDefined(self.target))
    array = getnodearray(self.target, "targetname");

  return array;
}

get_linked_nodes() {
  array = [];

  if(isDefined(self.script_linkto)) {
    linknames = strtok(self.script_linkto, " ");

    for(i = 0; i < linknames.size; i++) {
      ent = getnode(linknames[i], "script_linkname");

      if(isDefined(ent))
        array[array.size] = ent;
    }
  }

  return array;
}

assign_civ_spawners(str_spawnerbase, n_baseindex) {
  if(!isDefined(n_baseindex))
    n_baseindex = undefined;

  if(isDefined(n_baseindex)) {
    n_index = n_baseindex;
    str_spawnername = str_spawnerbase + n_index;
  } else
    str_spawnername = str_spawnerbase;

  a_spawners = getentarray(str_spawnername, "targetname");

  while(a_spawners.size != 0) {
    foreach(sp_civ in a_spawners) {
      if(isDefined(sp_civ.script_string)) {
        str_type = sp_civ.script_string;

        if(!isDefined(level.a_sp_civs[str_type])) {
          level.n_curr_sp_civ[str_type] = 0;
          level.a_sp_civs[str_type] = [];
        }

        level.a_sp_civs[str_type][level.a_sp_civs[str_type].size] = sp_civ;
      }
    }

    if(isDefined(n_index)) {
      n_index++;
      str_spawnername = str_spawnerbase + n_index;
      a_spawners = getentarray(str_spawnername, "targetname");
    } else
      return;
  }
}

assign_civ_drone_spawners(str_spawnername, script_string) {
  a_sp_civs = getentarray(str_spawnername, "targetname");

  foreach(sp_civ in a_sp_civs)
  maps\_drones::drones_assign_spawner(script_string, sp_civ);
}

assign_civ_drone_spawners_by_type(type, script_string) {
  if(!isarray(type))
    a_str_type[0] = type;
  else
    a_str_type = type;

  foreach(str_type in a_str_type) {
    assert(isDefined(level.a_sp_civs[str_type]), "Trying to assign a drone spawner a civ type( " + str_type + " ) that does not exist.");
    a_sp_civs = level.a_sp_civs[str_type];

    foreach(sp_civ in a_sp_civs)
    maps\_drones::drones_assign_spawner(script_string, sp_civ);
  }
}

delete_all_civs() {
  a_m_civs = getentarray("civilian", "targetname");

  foreach(index, m_civ in a_m_civs) {
    if(isalive(m_civ))
      m_civ delete();

    if(index % 20 == 0)
      wait 0.05;
  }
}

delete_civs(str_id, str_key) {
  if(!isDefined(str_key))
    str_key = "targetname";

  n_deleted = 0;
  a_m_civs = getentarray(str_id, str_key);

  foreach(m_civ in a_m_civs) {
    m_civ delete();
    n_deleted++;

    if(n_deleted % 20 == 0)
      wait 0.05;
  }
}

#using_animtree("fakeshooters");

spawn_static_civs(str_structnames, n_delay_max) {
  if(!isDefined(n_delay_max))
    n_delay_max = 2.0;

  a_keys = getarraykeys(level.a_sp_civs);
  a_civ_types = [];

  foreach(str_type in a_keys) {
    if(!isDefined(level.a_sp_civs[str_type][0].script_percent)) {
      a_civ_types[str_type] = 100;
      continue;
    }

    if(level.a_sp_civs[str_type][0].script_percent > 0.0)
      a_civ_types[str_type] = level.a_sp_civs[str_type][0].script_percent;
  }

  a_civ_types_keys = getarraykeys(a_civ_types);
  a_s_static_locs = getstructarray(str_structnames, "targetname");
  a_static_locs = [];

  for(i = 0; i < a_s_static_locs.size; i++) {
    a_static_locs[i]["origin"] = a_s_static_locs[i].origin;
    a_static_locs[i]["angles"] = a_s_static_locs[i].angles;
    a_static_locs[i]["script_string"] = a_s_static_locs[i].script_string;
    a_static_locs[i]["script_noteworthy"] = a_s_static_locs[i].script_noteworthy;
    a_static_locs[i]["dr_animation"] = a_s_static_locs[i].dr_animation;

    if(isDefined(a_s_static_locs[i].script_float))
      a_static_locs[i]["script_float"] = a_s_static_locs[i].script_float;
  }

  foreach(s_struct in a_s_static_locs)
  s_struct structdelete();

  a_sp_group = [];

  for(i = 0; i < a_static_locs.size; i++) {
    if(!is_mature() && isDefined(a_static_locs[i]["script_noteworthy"]) && a_static_locs[i]["script_noteworthy"] == "dancers") {
      continue;
    }
    if(isDefined(a_static_locs[i]["script_string"]) && isDefined(level.a_sp_civs[a_static_locs[i]["script_string"]]))
      a_sp_group = level.a_sp_civs[a_static_locs[i]["script_string"]];
    else
      a_sp_group = level.a_sp_civs[a_civ_types_keys[randomint(a_civ_types_keys.size)]];

    if(a_sp_group.size > 1)
      sp_spawner = a_sp_group[randomint(a_sp_group.size)];
    else
      sp_spawner = a_sp_group[0];

    m_drone = spawn("script_model", a_static_locs[i]["origin"]);
    m_drone.angles = a_static_locs[i]["angles"];
    m_drone.script_noteworthy = a_static_locs[i]["script_noteworthy"];

    if(isDefined(a_static_locs[i]["script_float"]))
      m_drone.script_float = a_static_locs[i]["script_float"];

    m_drone getdronemodel(sp_spawner.classname);
    m_drone useanimtree(#animtree);
    m_drone delay_thread(randomfloat(n_delay_max), ::civ_loop_anim, level.drones.anims[a_static_locs[i]["dr_animation"]]);

    if(i % 15 == 0)
      wait 0.05;
  }
}

spawn_static_club_civs(str_structnames, n_delay_max, str_male_spawners, str_female_spawners) {
  if(!isDefined(n_delay_max))
    n_delay_max = 2.0;

  a_sp_male = level.a_sp_civs[str_male_spawners];
  a_sp_female = level.a_sp_civs[str_female_spawners];
  a_s_static_locs = getstructarray(str_structnames, "targetname");
  a_s_static_locs = sort_by_script_int(a_s_static_locs, 1);
  a_static_locs = [];

  for(i = 0; i < a_s_static_locs.size; i++) {
    a_static_locs[i]["origin"] = a_s_static_locs[i].origin;
    a_static_locs[i]["angles"] = a_s_static_locs[i].angles;
    a_static_locs[i]["script_string"] = a_s_static_locs[i].script_string;
    a_static_locs[i]["script_noteworthy"] = a_s_static_locs[i].script_noteworthy;
    a_static_locs[i]["dr_animation"] = a_s_static_locs[i].dr_animation;

    if(isDefined(a_s_static_locs[i].script_float))
      a_static_locs[i]["script_float"] = a_s_static_locs[i].script_float;
  }

  foreach(s_struct in a_s_static_locs)
  s_struct structdelete();

  n_male_index_head = 0;
  n_male_num_heads = get_drone_model_array("male", "head").size;
  n_male_index_body = 0;
  n_male_num_bodies = get_drone_model_array("male", "body").size;
  n_female_index_head = 0;
  n_female_num_heads = get_drone_model_array("female", "head").size;
  n_female_index_body = 0;
  n_female_num_bodies = get_drone_model_array("female", "body").size;
  m_head = undefined;
  m_body = undefined;
  sp_spawner = undefined;

  for(i = 0; i < a_static_locs.size; i++) {
    if(!is_mature() && isDefined(a_static_locs[i]["script_noteworthy"]) && a_static_locs[i]["script_noteworthy"] == "dancers") {
      continue;
    }
    if(isDefined(a_static_locs[i]["script_string"]) && a_static_locs[i]["script_string"] == str_male_spawners) {
      m_head = get_drone_model_array("male", "head")[n_male_index_head];
      m_body = get_drone_model_array("male", "body")[n_male_index_body];
      n_male_index_head++;
      n_male_index_body++;

      if(n_male_index_head >= n_male_num_heads)
        n_male_index_head = 0;

      if(n_male_index_body >= n_male_num_bodies)
        n_male_index_body = 0;
    } else if(isDefined(a_static_locs[i]["script_string"]) && a_static_locs[i]["script_string"] == str_female_spawners) {
      m_head = get_drone_model_array("female", "head")[n_female_index_head];
      m_body = get_drone_model_array("female", "body")[n_female_index_body];
      n_female_index_head++;
      n_female_index_body++;

      if(n_female_index_head >= n_female_num_heads)
        n_female_index_head = 0;

      if(n_female_index_body >= n_female_num_bodies)
        n_female_index_body = 0;
    } else if(isDefined(a_static_locs[i]["script_string"]) && a_static_locs[i]["script_string"] == "club_shadow_dancer")
      sp_spawner = level.a_sp_civs["club_shadow_dancer"][0];
    else if(isDefined(a_static_locs[i]["script_string"]) && a_static_locs[i]["script_string"] == "club_bouncer")
      sp_spawner = level.a_sp_civs["club_bouncer"][0];

    m_drone = spawn("script_model", a_static_locs[i]["origin"]);
    m_drone.angles = a_static_locs[i]["angles"];
    m_drone.script_noteworthy = a_static_locs[i]["script_noteworthy"];

    if(isDefined(a_static_locs[i]["script_float"]))
      m_drone.script_float = a_static_locs[i]["script_float"];

    if(isDefined(a_static_locs[i]["script_string"]) && (a_static_locs[i]["script_string"] == str_male_spawners || a_static_locs[i]["script_string"] == str_female_spawners)) {
      m_drone.targetname = m_body;
      m_drone setmodel(m_body);

      if(isDefined(m_drone.script_float)) {
        if(a_static_locs[i]["script_string"] == str_male_spawners)
          m_head = "c_mul_civ_club_male_head" + int(m_drone.script_float);
        else if(a_static_locs[i]["script_string"] == str_female_spawners)
          m_head = "c_mul_civ_club_female_head" + int(m_drone.script_float);
      }

      m_drone attach(m_head, "", 1);
    } else
      m_drone getdronemodel(sp_spawner.classname);

    m_drone useanimtree(#animtree);
    m_drone delay_thread(randomfloat(n_delay_max), ::civ_loop_anim, level.drones.anims[a_static_locs[i]["dr_animation"]]);

    if(i % 15 == 0)
      wait 0.05;
  }
}

civ_loop_anim(anim_loop) {
  self endon("death");

  while(isDefined(self)) {
    self animscripted("drone_idle_anim", self.origin, self.angles, anim_loop);
    self waittillmatch("drone_idle_anim", "end");
  }
}

get_drone_model_array(str_model_gender, str_model_type) {
  a_m_models = [];

  if(str_model_gender == "male") {
    if(str_model_type == "head") {
      a_m_models[0] = "c_mul_civ_club_male_head1";
      a_m_models[1] = "c_mul_civ_club_male_head5";
      a_m_models[2] = "c_mul_civ_club_male_head7";
      a_m_models[3] = "c_mul_civ_club_male_head8";
      a_m_models[4] = "c_mul_civ_club_male_head9";
      a_m_models[5] = "c_mul_civ_club_male_head10";
    } else {
      a_m_models[0] = "c_mul_civ_club_male_jacket_dressshirt_3";
      a_m_models[1] = "c_mul_civ_club_male_longsleeve_vest_2";
      a_m_models[2] = "c_mul_civ_club_male_jacket_rolled_tshirt_1";
      a_m_models[3] = "c_mul_civ_club_male_midsleeve_4";
      a_m_models[4] = "c_mul_civ_club_male_midsleeve_vest_2";
      a_m_models[5] = "c_mul_civ_club_male_longsleeve_3";
      a_m_models[6] = "c_mul_civ_club_male_jacket_tshirt_1";
      a_m_models[7] = "c_mul_civ_club_male_longsleeve_vest_5";
      a_m_models[8] = "c_mul_civ_club_male_midsleeve_3";
      a_m_models[9] = "c_mul_civ_club_male_jacket_rolled_tshirt_2";
      a_m_models[10] = "c_mul_civ_club_male_rolled_dressshirt_vest_1";
      a_m_models[11] = "c_mul_civ_club_male_longsleeve_vest_4";
      a_m_models[12] = "c_mul_civ_club_male_longsleeve_2";
      a_m_models[13] = "c_mul_civ_club_male_jacket_dressshirt_2";
      a_m_models[14] = "c_mul_civ_club_male_longsleeve_1";
      a_m_models[15] = "c_mul_civ_club_male_midsleeve_vest_5";
      a_m_models[16] = "c_mul_civ_club_male_jacket_tshirt_4";
      a_m_models[17] = "c_mul_civ_club_male_rolled_dressshirt_vest_3";
      a_m_models[18] = "c_mul_civ_club_male_jacket_dressshirt_1";
      a_m_models[19] = "c_mul_civ_club_male_jacket_rolled_tshirt_3";
      a_m_models[20] = "c_mul_civ_club_male_midsleeve_vest_1";
      a_m_models[21] = "c_mul_civ_club_male_jacket_tshirt_5";
      a_m_models[22] = "c_mul_civ_club_male_midsleeve_1";
      a_m_models[23] = "c_mul_civ_club_male_rolled_dressshirt_vest_5";
    }
  } else if(str_model_type == "head") {
    a_m_models[0] = "c_mul_civ_club_female_head1";
    a_m_models[1] = "c_mul_civ_club_female_head2";
    a_m_models[2] = "c_mul_civ_club_female_head3";
    a_m_models[3] = "c_mul_civ_club_female_head4";
    a_m_models[4] = "c_mul_civ_club_female_head5";
  } else {
    a_m_models[0] = "c_mul_civ_club_long_dress2_1";
    a_m_models[1] = "c_mul_civ_club_short_dress1_1";
    a_m_models[2] = "c_mul_civ_club_bra_pants_1";
    a_m_models[3] = "c_mul_civ_club_long_dress3_2";
    a_m_models[4] = "c_mul_civ_club_short_dress2_4";
    a_m_models[5] = "c_mul_civ_club_skirt_pants_2";
    a_m_models[6] = "c_mul_civ_club_long_dress2_4";
    a_m_models[7] = "c_mul_civ_club_short_dress1_2";
    a_m_models[8] = "c_mul_civ_club_bra_pants_5";
    a_m_models[9] = "c_mul_civ_club_long_dress1_3";
    a_m_models[10] = "c_mul_civ_club_short_dress2_5";
    a_m_models[11] = "c_mul_civ_club_skirt_pants_1";
    a_m_models[12] = "c_mul_civ_club_long_dress2_5";
    a_m_models[13] = "c_mul_civ_club_short_dress3_2";
    a_m_models[14] = "c_mul_civ_club_bra_pants_4";
    a_m_models[15] = "c_mul_civ_club_long_dress1_2";
    a_m_models[16] = "c_mul_civ_club_short_dress3_3";
    a_m_models[17] = "c_mul_civ_club_skirt_pants_5";
    a_m_models[18] = "c_mul_civ_club_long_dress1_1";
    a_m_models[19] = "c_mul_civ_club_short_dress4_2";
    a_m_models[20] = "c_mul_civ_club_bra_pants_2";
    a_m_models[21] = "c_mul_civ_club_long_dress4_5";
    a_m_models[22] = "c_mul_civ_club_short_dress4_3";
    a_m_models[23] = "c_mul_civ_club_skirt_pants_4";
    a_m_models[24] = "c_mul_civ_club_long_dress3_4";
    a_m_models[25] = "c_mul_civ_club_short_dress1_3";
    a_m_models[26] = "c_mul_civ_club_bra_pants_3";
    a_m_models[27] = "c_mul_civ_club_long_dress3_3";
    a_m_models[28] = "c_mul_civ_club_short_dress4_5";
    a_m_models[29] = "c_mul_civ_club_skirt_pants_3";
    a_m_models[30] = "c_mul_civ_club_long_dress4_1";
    a_m_models[31] = "c_mul_civ_club_short_dress2_1";
    a_m_models[32] = "c_mul_civ_club_long_dress4_2";
    a_m_models[33] = "c_mul_civ_club_short_dress3_4";
  }

  return a_m_models;
}