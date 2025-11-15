/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\pel2_util.gsc
*****************************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_anim;

start_teleport_players(start_name, coop) {
  players = get_players();
  if(isDefined(coop) && coop) {
    starts = get_sorted_starts(start_name);
  } else {
    starts = getstructarray(start_name, "targetname");
  }
  assertex(starts.size >= players.size, "Need more start positions for players!");
  for(i = 0; i < players.size; i++) {
    players[i] setOrigin(starts[i].origin);
    if(isDefined(starts[i].angles)) {
      players[i] setPlayerAngles(starts[i].angles);
    } else {
      players[i] setPlayerAngles((0, 0, 0));
    }
  }
  set_breadcrumbs(starts);
}

get_sorted_starts(start_name) {
  player_starts = [];
  player_starts = getstructarray(start_name, "targetname");
  for(i = 0; i < player_starts.size; i++) {
    for(j = i; j < player_starts.size; j++) {
      if(player_starts[j].script_int < player_starts[i].script_int) {
        temp = player_starts[i];
        player_starts[i] = player_starts[j];
        player_starts[j] = temp;
      }
    }
  }
  return player_starts;
}

start_teleport_ai(start_name) {
  friendly_ai = getEntArray("friendly_squad_ai", "script_noteworthy");
  ai_starts = getstructarray(start_name + "_ai", "targetname");
  assertex(ai_starts.size >= friendly_ai.size, "Need more start positions for ai!");
  for(i = 0; i < friendly_ai.size; i++) {
    friendly_ai[i] teleport(ai_starts[i].origin);
  }
}

start_trick_teleport_player() {
  players = get_players();
  orig = getstruct("orig_fake_test", "targetname");
  for(i = 0; i < players.size; i++) {
    players[i] setOrigin(orig.origin);
  }
}

start_teleport(start_name) {
  start_trick_teleport_player();
  start_teleport_ai(start_name);
  start_teleport_players(start_name);
}

set_color_chain(name) {
  color_trigger = getent(name, "targetname");
  assertex(isDefined(color_trigger), "color_trigger: " + name + " isn't defined!");
  color_trigger notify("trigger");
}

set_color_chain_safe(name) {
  color_trigger = getent(name, "targetname");
  color_trigger notify("trigger");
}

trigger_wait_or_timeout(trig_name, time, key) {
  assertex(isDefined(time), "time needs to be defined!");
  if(!isDefined(key)) {
    key = "targetname";
  }
  trig = getent(trig_name, key);
  assertex((trig.classname == "trigger_multiple" || trig.classname == "trigger_lookat"), "trigger must be a trigger_multiple or trigger_lookat to use this function!");
  level thread trigger_wait_or_timeout_helper(trig_name, time, key);
  trigger_wait(trig_name, key);
}

trigger_wait_or_timeout_helper(trig_name, time, key) {
  trig = getent(trig_name, key);
  trig endon("trigger");
  wait(time);
  trig notify("trigger");
}

trig_override(original_trig_name) {
  original_trig = getent(original_trig_name, "targetname");
  assertex((original_trig.classname == "trigger_multiple" || original_trig.classname == "trigger_lookat"), "trigger must be a trigger_multiple or trigger_lookat to use this function!");
  original_trig endon("trigger");
  override_trig = getent(original_trig.target, "targetname");
  override_trig waittill("trigger");
  quick_text(original_trig.targetname + " overridden!", 3, true);
  original_trig notify("trigger");
  override_trig delete();
}

set_color_heroes(color) {
  for(i = 0; i < level.heroes.size; i++) {
    level.heroes[i] set_force_color(color);
  }
}

set_color_allies(color) {
  guys = getAIArray("allies");
  for(i = 0; i < guys.size; i++) {
    guys[i] set_force_color(color);
  }
}

disable_arrivals(arrivals, exits) {
  self.disableArrivals = arrivals;
  self.disableexits = exits;
}

cant_see_any_player() {
  players = get_players();
  for(i = 0; i < players.size; i++) {
    if((self cansee(players[i]))) {
      return false;
    }
  }
  return true;
}

players_nearby(spot, range) {
  players = get_players();
  for(i = 0; i < players.size; i++) {
    if(distance(players[i].origin, spot) <= range) {
      return true;
    }
  }
  return false;
}

delete_targetname_ents(name) {
  ents = getEntArray(name, "targetname");
  for(i = 0; i < ents.size; i++) {
    ents[i] delete();
  }
}

delete_noteworthy_ents(name) {
  ents = getEntArray(name, "script_noteworthy");
  for(i = 0; i < ents.size; i++) {
    if(isDefined(ents[i])) {
      ents[i] delete();
    }
  }
}

simple_floodspawn(name, spawn_func) {
  spawners = getEntArray(name, "targetname");
  assertex(spawners.size, "no spawners with targetname " + name + " found!");
  if(isDefined(spawn_func)) {
    for(i = 0; i < spawners.size; i++) {
      spawners[i] add_spawn_function(spawn_func);
    }
  }
  for(i = 0; i < spawners.size; i++) {
    if(i % 2) {
      wait_network_frame();
    }
    spawners[i] thread maps\_spawner::flood_spawner_init();
    spawners[i] thread maps\_spawner::flood_spawner_think();
  }
}

simple_spawn(name, spawn_func) {
  spawners = getEntArray(name, "targetname");
  assertex(spawners.size, "no spawners with targetname " + name + " found!");
  if(isDefined(spawn_func)) {
    for(i = 0; i < spawners.size; i++) {
      spawners[i] add_spawn_function(spawn_func);
    }
  }
  ai_array = [];
  for(i = 0; i < spawners.size; i++) {
    if(i % 2) {
      wait_network_frame();
    }
    if(isDefined(spawners[i].script_forcespawn)) {
      ai = spawners[i] Stalingradspawn();
    } else {
      ai = spawners[i] Dospawn();
    }
    spawn_failed(ai);
    if(isDefined(ai)) {
      ai.targetname = name + "_alive";
    }
    ai_array = add_to_array(ai_array, ai);
  }
  return ai_array;
}

simple_spawn_single(name, spawn_func) {
  spawner = getEnt(name, "targetname");
  assertex(isDefined(spawner), "no spawner with targetname " + name + " found!");
  if(isDefined(spawn_func)) {
    spawner add_spawn_function(spawn_func);
  }
  if(isDefined(spawner.script_forcespawn)) {
    ai = spawner Stalingradspawn();
  } else {
    ai = spawner Dospawn();
  }
  spawn_failed(ai);
  if(isDefined(ai) && !isDefined(ai.targetname)) {
    ai.targetname = name + "_alive";
  }
  return ai;
}

set_ignoreme_on() {
  if(isalive(self)) {
    self.ignoreme = 1;
  }
}

set_ignoreme_off() {
  if(isalive(self)) {
    self.ignoreme = 0;
  }
}

set_ignoresuppression_on() {
  if(isalive(self)) {
    self.ignoresuppression = 1;
  }
}

set_ignoresuppression_off() {
  if(isalive(self)) {
    self.ignoresuppression = 0;
  }
}

set_pacifist_on() {
  if(isalive(self)) {
    self.pacifist = 1;
    self.pacifistwait = 0.05;
  }
}

set_pacifist_off() {
  if(isalive(self)) {
    self.pacifist = 0;
    self.pacifistwait = 20;
  }
}

set_players_ignoreme(ignore_val) {
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i].ignoreme = ignore_val;
  }
}

change_ai_group_goalradii(name, new_radius) {
  assertex(isDefined(name), "ai_group name needs to be defined!");
  guys = get_ai_group_ai(name);
  if(!guys.size) {
    return;
  }
  for(i = 0; i < guys.size; i++) {
    guys[i].goalradius = new_radius;
  }
}

change_noteworthy_goalradii(name, new_radius) {
  guys = get_specific_ai(name);
  for(i = 0; i < guys.size; i++) {
    guys[i].goalradius = new_radius;
  }
}

kill_all_ai(allies_only) {
  if(isDefined(allies_only) && allies_only == "allies") {
    ai = getaiarray("allies");
  } else {
    ai = getaiarray();
  }
  for(i = 0; i < ai.size; i++) {
    if(isDefined(ai[i].targetname) && ai[i].targetname == "friendly_squad") {
      continue;
    }
    if(isDefined(ai[i].script_noteworthy) && ai[i].script_noteworthy == "dont_kill_me") {
      continue;
    }
    if(isDefined(ai[i].magic_bullet_shield) && ai[i].magic_bullet_shield) {
      println("stopping magic bullet shield on guy at: " + ai[i].origin + " with export: " + ai[i].export);
      ai[i] stop_magic_bullet_shield();
      wait(0.05);
    }
    ai[i] dodamage(ai[i].health + 10, (0, 0, 0));
    wait(0.1);
  }
}

kill_all_axis_ai(delay) {
  if(!isDefined(delay)) {
    delay = 0.15;
  }
  ai = getaiarray("axis");
  for(i = 0; i < ai.size; i++) {
    if(isalive(ai[i])) {
      ai[i] dodamage(ai[i].health + 10, (0, 0, 0));
      wait(delay);
    }
  }
}

kill_all_axis_ai_bloody(delay) {
  if(!isDefined(delay)) {
    delay = 0.15;
  }
  ai = getaiarray("axis");
  for(i = 0; i < ai.size; i++) {
    if(isalive(ai[i])) {
      self thread bloody_death(true);
      wait(delay);
    }
  }
}

kill_aigroup(name) {
  ai = get_ai_group_ai(name);
  for(i = 0; i < ai.size; i++) {
    if(isDefined(ai[i].magic_bullet_shield) && ai[i].magic_bullet_shield) {
      ai[i] stop_magic_bullet_shield();
    }
    wait(0.05);
    if(isalive(ai[i])) {
      ai[i] dodamage(ai[i].health + 1, (0, 0, 0));
    }
  }
}

kill_noteworthy_group(name) {
  ai = get_specific_ai(name);
  for(i = 0; i < ai.size; i++) {
    ai[i] dodamage(ai[i].health + 10, (0, 0, 0));
  }
}

delete_drones() {
  drones = getEntArray("drone", "targetname");
  for(i = 0; i < drones.size; i++) {
    drones[i] maps\_drones::drone_delete();
  }
}

get_specific_single_ai(name) {
  guys = getEntArray(name, "script_noteworthy");
  assertex(guys.size < 3, "shouldn't have more than 2 of these guys!");
  for(i = 0; i < guys.size; i++) {
    if(isalive(guys[i])) {
      return guys[i];
    }
  }
  return undefined;
}

get_specific_ai(name) {
  guys = getEntArray(name, "script_noteworthy");
  ai_array = [];
  for(i = 0; i < guys.size; i++) {
    if(isalive(guys[i])) {
      ai_array = array_add(ai_array, guys[i]);
    }
  }
  return ai_array;
}

flame_move_target(orig, move_time) {
  orig endon("stop_fakefire_mover");
  targ_1 = orig.origin;
  targ_2 = getstruct(orig.target, "targetname").origin;
  while(1) {
    orig MoveTo(targ_2, move_time);
    orig waittill("movedone");
    orig MoveTo(targ_1, move_time);
    orig waittill("movedone");
  }
}

convert_aiming_struct_to_origin(struct_name) {
  aim_struct = getstruct(struct_name, "targetname");
  orig = spawn("script_origin", aim_struct.origin);
  orig.target = aim_struct.target;
  orig.health = 100000;
  orig.targetname = struct_name + "_converted";
  return orig;
}

get_alive_noteworthy_tanks(name) {
  tanks = getEntArray(name, "script_noteworthy");
  alive_tanks = [];
  for(i = 0; i < tanks.size; i++) {
    if(tanks[i].classname == "script_vehicle" && tanks[i].health > 0) {
      alive_tanks = array_add(alive_tanks, tanks[i]);
    }
  }
  return alive_tanks;
}

keep_tank_alive() {
  assertex(self.classname == "script_vehicle", "keep_tank_alive() must be used with script_vehicles!");
  self.keep_tank_alive = 1;
  self maps\_vehicle::godon();
}

stop_keep_tank_alive() {
  self.keep_tank_alive = 0;
  self notify("stop_friendlyfire_shield");
  self maps\_vehicle::godoff();
}

tank_move(pathstart) {
  level endon("end_current_tank_paths");
  pathpoint = pathstart;
  arraycount = 0;
  pathpoints = [];
  self setspeed(16, 8, 6);
  while(isDefined(pathpoint)) {
    pathpoints[arraycount] = pathpoint;
    arraycount++;
    if(isDefined(pathpoint.target)) {
      pathpoint = getent(pathpoint.target, "targetname");
    } else {
      break;
    }
  }
  for(i = 0; i < pathpoints.size - 1; i++) {
    self setVehGoalPos(pathpoints[i].origin + (0, 0, 0), 0);
    self waittillmatch("goal");
  }
  self setVehGoalPos(pathpoints[pathpoints.size - 1].origin + (0, 0, 0), 1);
}

tank_fire_at_struct(struct_targ, timeout) {
  self endon("death");
  self endon("end_tank_fire_at");
  if(!isDefined(timeout)) {
    timeout = 5;
  }
  self SetTurretTargetVec(struct_targ.origin);
  self waittill_notify_or_timeout("turret_on_target", timeout);
  wait(1);
  self ClearTurretTarget();
  self fireweapon();
}

tank_fire_at_ent(ent_name, timeout) {
  self endon("death");
  self endon("end_tank_fire_at");
  if(!isDefined(timeout)) {
    timeout = 5;
  }
  spot = getent(ent_name, "targetname");
  self SetTurretTargetEnt(spot);
  self waittill_notify_or_timeout("turret_on_target", timeout);
  wait(1);
  self ClearTurretTarget();
  self fireweapon();
}

tank_reset_turret(timeout) {
  self endon("death");
  if(!isDefined(timeout)) {
    timeout = 5;
  }
  forward = anglesToForward(self.angles);
  vec = vectorScale(forward, 1000);
  self SetTurretTargetVec(self.origin + vec);
  self waittill_notify_or_timeout("turret_on_target", timeout);
  self ClearTurretTarget();
}

draw_line_from_ent_to_vec(vec, color) {
  if(!isDefined(color)) {
    color = (1, 0, 0);
  }
  for(;;) {
    line(self.origin, vec, color, 0.9);
    wait(0.05);
  }
}

tank_can_see_ent(seen_ent, tank_ent) {
  success = BulletTracePassed(seen_ent getEye(), tank_ent gettagorigin("tag_flash"), false, undefined);
  return success;
}

veh_stop_at_node(node_name, accel, decel, dont_stop_flag) {
  if(!isDefined(accel)) {
    accel = 15;
  }
  if(!isDefined(decel)) {
    decel = 15;
  }
  vnode = getvehiclenode(node_name, "script_noteworthy");
  vnode waittill("trigger");
  if(!isDefined(dont_stop_flag) || (isDefined(dont_stop_flag) && !flag(dont_stop_flag))) {
    self setspeed(0, accel, decel);
  }
  if(self.vehicletype == "wasp") {
    wait(0.5);
  }
}

goto_retreat_nodes(guys) {
  nodes = getnodearray("node_" + guys[0].script_aigroup, "targetname");
  for(i = 0; i < guys.size && i < nodes.size; i++) {
    guys[i].pacifist = 1;
    guys[i].goalradius = 30;
    guys[i] setgoalnode(nodes[i]);
    guys[i] thread pacifist_till_goal();
  }
}

pacifist_till_goal() {
  self endon("death");
  self waittill("goal");
  self.pacifist = 0;
}

temp_vo_no_anim(guy, sound_alias) {
  level thread temp_vo_no_anim_helper(guy, sound_alias);
}

temp_vo_no_anim_helper(guy, sound_alias) {
  guy endon("death");
  guy playSound(sound_alias, sound_alias + "_sound_done");
}

play_vo(guy, vo_animname, vo_text) {
  level thread play_vo_helper(guy, vo_animname, vo_text);
}

play_vo_helper(guy, vo_animname, vo_text) {
  if(!isDefined(guy)) {
    return;
  }
  lookTarget = undefined;
  notifyString = "sound_done";
  guy thread anim_facialFiller(notifyString, lookTarget);
  guy animscripts\face::SaySpecificDialogue(undefined, level.scr_sound[vo_animname][vo_text], 1.0, notifyString);
  guy waittill(notifyString);
}

bloody_death(die, delay) {
  self endon("death");
  if(!is_active_ai(self)) {
    return;
  }
  if(!isDefined(die)) {
    die = true;
  }
  if(isDefined(self.bloody_death) && self.bloody_death) {
    return;
  }
  self.bloody_death = true;
  if(isDefined(delay)) {
    wait(RandomFloat(delay));
  }
  if(!isDefined(self)) {
    return;
  }
  tags = [];
  tags[0] = "j_hip_le";
  tags[1] = "j_hip_ri";
  tags[2] = "j_head";
  tags[3] = "j_spine4";
  tags[4] = "j_elbow_le";
  tags[5] = "j_elbow_ri";
  tags[6] = "j_clavicle_le";
  tags[7] = "j_clavicle_ri";
  for(i = 0; i < 2; i++) {
    random = RandomIntRange(0, tags.size);
    self thread bloody_death_fx(tags[random], undefined);
    wait(RandomFloat(0.1));
  }
  if(die && isDefined(self) && self.health) {
    self DoDamage(self.health + 150, self.origin);
  }
}

bloody_death_fx(tag, fxName) {
  if(!isDefined(fxName)) {
    fxName = level._effect["flesh_hit"];
  }
  playFXOnTag(fxName, self, tag);
}

is_active_ai(suspect) {
  if(isDefined(suspect) && IsSentient(suspect) && IsAlive(suspect)) {
    return true;
  } else {
    return false;
  }
}

players_speed_set(speed, time) {
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i] SetMoveSpeedScale(speed);
  }
  level.current_player_speed = speed;
}

random_vector(offset) {
  new_vec = (RandomIntRange(offset * -1, offset), RandomIntRange(offset * -1, offset), 0);
  return new_vec;
}

spawn_pickup_weapons(weapon_array) {
  for(i = 0; i < weapon_array.size; i++) {
    while(!OkTospawn()) {
      wait(0.05);
    }
    pickup_weapon = spawn(weapon_array[i].weapon_name, weapon_array[i].origin, 1);
    pickup_weapon.angles = weapon_array[i].angles;
    if(isDefined(weapon_array[i].count)) {
      pickup_weapon ItemWeaponSetAmmo(1, 3);
    }
    wait_network_frame();
  }
}

mg_sandbag_cleanup(mg_name, killspawner_num) {
  if(isDefined(killspawner_num)) {
    maps\_spawner::kill_spawnernum(killspawner_num);
  }
  mg = getent(mg_name, "targetname");
  mg_owner = mg getturretowner();
  if(isDefined(mg_owner)) {
    mg_owner dodamage(mg_owner.health + 10, (0, 0, 0));
  }
  mg cleartargetentity();
  mg SetMode("manual");
  mg notify("death");
  mg delete();
}

guzzo_print_3d(message) {
  self endon("death");
  self notify("stop_guzzo_print_3d");
  self endon("stop_guzzo_print_3d");
  while(1) {
    print3d((self.origin + (0, 0, 65)), message, (0.48, 9.4, 0.76), 1, 1);
    wait(0.05);
  }
}

show_alive_ai_count(name) {
  level notify("stop_show_alive_ai_count");
  level endon("stop_show_alive_ai_count");
  while(1) {
    level.extra_info setText(get_specific_ai(name).size + " " + name + " are alive");
    wait(1);
  }
}

show_alive_aigroup_count(name) {
  level notify("stop_show_alive_ai_count");
  level endon("stop_show_alive_ai_count");
  while(1) {
    level.extra_info setText(get_ai_group_sentient_count(name) + " " + name);
    wait(1);
  }
}

debug_ai() {
  while(1) {
    axis_ai = GetAiArray("axis");
    allied_ai = GetAiArray("allies");
    if(axis_ai.size + allied_ai.size >= 30) {
      level.ai_info.color = (1, 0, 0);
    } else {
      level.ai_info.color = (1, 1, 1);
    }
    level.ai_info settext("axis: " + axis_ai.size + "allies: " + allied_ai.size + "total: " + (axis_ai.size + allied_ai.size));
    wait 0.6;
  }
}

debug_ai_health() {
  if(GetDvar("guzzo") == "1") {
    spawners = getspawnerarray();
    for(i = 0; i < spawners.size; i++) {
      if(IsSubStr(spawners[i].classname, "actor_axis")) {
        spawners[i] add_spawn_function(::debug_ai_health_spawnfunc);
      }
    }
  }
}

debug_ai_health_spawnfunc() {
  self.health = 25;
}

debug_tank_health() {
  while(1) {
    tanks = getEntArray("script_vehicle", "classname");
    dead_tanks = getEntArray("script_vehicle_corpse", "classname");
    tanks = array_combine(tanks, dead_tanks);
    for(i = 0; i < tanks.size; i++) {
      if(isDefined(tanks[i].keep_tank_alive) && tanks[i].keep_tank_alive == 1) {
        print3d(tanks[i].origin + (0, 0, 70), tanks[i].health, (0.0, 1.0, 0.0), 1, 1, 1);
        if(isDefined(tanks[i].targetname)) {
          print3d(tanks[i].origin + (0, 0, 80), tanks[i].targetname, (0.0, 1.0, 0.0), 1, 1, 1);
        }
      } else if(tanks[i].health > 0) {
        print3d(tanks[i].origin + (0, 0, 70), tanks[i].health, (1.0, 1.0, 0.0), 1, 1, 1);
        if(isDefined(tanks[i].targetname)) {
          print3d(tanks[i].origin + (0, 0, 80), tanks[i].targetname, (1.0, 1.0, 0.0), 1, 1, 1);
        }
      } else {
        if(isDefined(tanks[i].targetname)) {
          print3d(tanks[i].origin + (0, 0, 80), tanks[i].targetname, (1.0, 0.0, 0.0), 1, 1, 1);
        }
      }
    }
    wait(0.05);
  }
}

debug_num_vehicles() {
  while(1) {
    vehicles = getEntArray("script_vehicle", "classname");
    extra_text("vehicles: " + vehicles.size);
    wait(0.5);
  }
}

debug_turret_count() {
  while(1) {
    turrets = getEntArray("misc_turret", "classname");
    level.extra_info setText("turrets: " + turrets.size);
    for(i = 0; i < turrets.size; i++) {
      println("turret[" + i + "] at: " + turrets[i].origin);
      print3d(turrets[i].origin + (0, 0, 30), "*****", (0.0, 1.0, 0.0), 1, 1, 1);
    }
    wait(0.05);
  }
}

draw_goal_radius() {
  while(1) {
    if(GetDvar("guzzo") == "1") {
      guys = GetAiArray();
      for(i = 0; i < guys.size; i++) {
        if(guys[i].team == "axis") {
          print3d(guys[i].origin + (0, 0, 70), string(guys[i].goalradius), (1.0, 0.0, 0.0), 1, 1, 1);
        } else {
          print3d(guys[i].origin + (0, 0, 70), string(guys[i].goalradius), (0.0, 1.0, 0.0), 1, 1, 1);
        }
      }
      wait(0.05);
      continue;
    }
    wait(0.4);
  }
}

draw_ent_locations(ent_array, text, endon_string) {
  if(isDefined(endon_string)) {
    level endon(endon_string);
  }
  while(1) {
    for(i = 0; i < ent_array.size; i++) {
      if(isDefined(ent_array[i].origin)) {
        print3d(ent_array[i].origin + (0, 0, 150), text, (1.0, 0.0, 1.0), 1, 1, 1);
      }
    }
    wait(0.1);
  }
}
debug_script_flag_trigs_print() {
  trigs_with_script_flag = getEntArray("flag_set", "targetname");
  for(i = 0; i < trigs_with_script_flag.size; i++) {
    level thread debug_script_flag_trigs_print_waittill(trigs_with_script_flag[i]);
  }
}
debug_script_flag_trigs_print_waittill(trigger) {
  trigger waittill("trigger");
  println("");
  println("*** trigger debug: trigger with flag: " + trigger.script_flag + " has just been triggered");
}

setup_guzzo_hud() {
  level.event_info = NewHudElem();
  level.event_info.alignX = "right";
  level.event_info.x = 100;
  level.event_info.y = 286;
  level.event_info.fontscale = 1.2;
  level.extra_info = NewHudElem();
  level.extra_info.alignX = "right";
  level.extra_info.x = 100;
  level.extra_info.y = 300;
  level.extra_info.sort = -12;
  level.ai_info = NewHudElem();
  level.ai_info.alignX = "right";
  level.ai_info.x = 100;
  level.ai_info.y = 320;
  level.center_info = NewHudElem();
  level.center_info.alignX = "center";
  level.center_info.x = 330;
  level.center_info.y = 90;
  level.center_info.fontscale = 2.0;
  level.center_info.color = (0.9, 0.2, 0.2);
}

quick_text(text, how_long, event) {
  if(!isDefined(how_long)) {
    how_long = 3;
  }
  if(!isDefined(event)) {
    event = true;
  }
  level thread quick_text_thread(text, how_long, event);
}

quick_text_thread(text, how_long, event) {
  level notify("stop_quick_text");
  level endon("stop_quick_text");
  level.center_info setText(text);
  println("quick_text print: " + text);
  wait(how_long);
  level.center_info setText("");
  if(event) {
    level.event_info settext(text);
  }
}

flash_center_text(text) {
  level thread hud_fade(level.center_info, text);
}

event_text(text) {
  level.event_info settext(text);
  println("event_text print: " + text);
}

extra_text(text) {
  level.extra_info settext(text);
  println("extra_text print: " + text);
}

hud_fade(hud_elem, text) {
  flash_count = 0;
  hud_elem.alpha = 0;
  hud_elem setText(text);
  while(1) {
    if((hud_elem.alpha + 0.05) >= 1) {
      hud_elem.alpha = 0;
      flash_count++;
      if((flash_count) > 5) {
        break;
      }
    }
    hud_elem.alpha = hud_elem.alpha + 0.05;
    maps\_spawner::waitframe();
  }
}

drawline_from_ent(ent) {
  self endon("kill_lines");
  color = (0, 255, 0);
  while(1) {
    if(isDefined(ent)) {
      line(self.origin, ent.origin, color);
      wait(0.05);
    } else {
      break;
    }
  }
}

show_tag(ent_name, tag_name, noteworthy) {
  if(isDefined(noteworthy)) {
    ent = getent(ent_name, "script_noteworthy");
  } else {
    ent = getent(ent_name, "targetname");
  }
  while(1) {
    orig = ent gettagorigin(tag_name);
    assertex(isDefined(orig), "tag origin for " + tag_name + " doesn't exist!");
    print3d(orig, "**", (0.0, 1.0, 0.0), 1, 1, 1);
    wait(0.05);
  }
}

start_delete_garbage(left_x, right_x, top_y, bottom_y) {
  deleted_ents = 0;
  ents_to_delete = getEntArray("trigger_once", "classname");
  ents_to_delete_2 = getEntArray("trigger_multiple", "classname");
  ents_to_delete = array_combine(ents_to_delete, ents_to_delete_2);
  println("");
  println("garbage *** cleanup");
  for(i = 0; i < ents_to_delete.size; i++) {
    if((ents_to_delete[i].origin[0] > left_x) && (ents_to_delete[i].origin[0] < right_x) && (ents_to_delete[i].origin[1] < top_y) && (ents_to_delete[i].origin[1] > bottom_y)) {
      println("garbage : deleting ent at: " + ents_to_delete[i].origin);
      ents_to_delete[i] delete();
    }
    deleted_ents++;
  }
  println("garbage: total deleted ents: " + deleted_ents);
}