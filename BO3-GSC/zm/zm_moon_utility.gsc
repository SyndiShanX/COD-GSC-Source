/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_moon_utility.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\audio_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\demo_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\scoreevents_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_bb;
#using scripts\zm\_zm;
#using scripts\zm\_zm_ai_dogs;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_blockers;
#using scripts\zm\_zm_hackables_doors;
#using scripts\zm\_zm_net;
#using scripts\zm\_zm_pers_upgrades_functions;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#using scripts\zm\_zm_zonemgr;
#using scripts\zm\zm_moon;
#using scripts\zm\zm_moon_amb;
#using scripts\zm\zm_moon_gravity;
#using scripts\zm\zm_moon_utility;
#using scripts\zm\zm_moon_wasteland;
#namespace zm_moon_utility;

function init_zombie_airlocks() {
  airlock_buys = getEntArray("zombie_airlock_buy", "targetname");
  for(i = 0; i < airlock_buys.size; i++) {
    airlock_buys[i] thread airlock_buy_init();
  }
  level thread zm_hackables_doors::hack_doors("zombie_airlock_hackable", &moon_door_opened);
  airlock_hacks = getEntArray("zombie_airlock_hackable", "targetname");
  for(i = 0; i < airlock_hacks.size; i++) {
    airlock_hacks[i] thread airlock_hack_init();
  }
  airlock_doors = getEntArray("zombie_door_airlock", "script_noteworthy");
  for(i = 0; i < airlock_doors.size; i++) {
    airlock_doors[i] thread airlock_init();
  }
  level thread init_door_sounds();
  level thread zombie_moon_receiving_hatch_init();
  level thread moon_glass_breach_init();
}

function init_door_sounds() {
  zm_utility::add_sound("lab_door", "zmb_lab_door_slide");
  zm_utility::add_sound("electric_metal_big", "zmb_heavy_door_open");
  zm_utility::add_sound("zmb_heavy_door_open", "zmb_heavy_door_open");
}

function airlock_hack_init() {
  self.type = undefined;
  if(isDefined(self.script_flag) && !isDefined(level.flag[self.script_flag])) {
    if(isDefined(self.script_flag)) {
      tokens = strtok(self.script_flag, ",");
      for(i = 0; i < tokens.size; i++) {
        level flag::init(self.script_flag);
      }
    }
  }
  self.trigs = [];
  targets = getEntArray(self.target, "targetname");
  for(i = 0; i < targets.size; i++) {
    if(!isDefined(self.trigs)) {
      self.trigs = [];
    } else if(!isarray(self.trigs)) {
      self.trigs = array(self.trigs);
    }
    self.trigs[self.trigs.size] = targets[i];
    if(isDefined(targets[i].classname) && targets[i].classname == "trigger_multiple") {
      targets[i] triggerenable(0);
    }
  }
  self setcursorhint("HINT_NOICON");
  self.script_noteworthy = "default";
  self sethintstring(&"ZOMBIE_EQUIP_HACKER");
}

function airlock_buy_init() {
  self.type = undefined;
  if(isDefined(self.script_flag) && !isDefined(level.flag[self.script_flag])) {
    if(isDefined(self.script_flag)) {
      tokens = strtok(self.script_flag, ",");
      for(i = 0; i < tokens.size; i++) {
        level flag::init(self.script_flag);
      }
    }
  }
  self.trigs = [];
  targets = getEntArray(self.target, "targetname");
  for(i = 0; i < targets.size; i++) {
    if(!isDefined(self.trigs)) {
      self.trigs = [];
    } else if(!isarray(self.trigs)) {
      self.trigs = array(self.trigs);
    }
    self.trigs[self.trigs.size] = targets[i];
    if(isDefined(targets[i].classname) && targets[i].classname == "trigger_multiple") {
      targets[i] triggerenable(0);
    }
  }
  self setcursorhint("HINT_NOICON");
  if(isDefined(self.script_noteworthy) && (self.script_noteworthy == "electric_door" || self.script_noteworthy == "electric_buyable_door")) {
    self sethintstring(&"ZOMBIE_NEED_POWER");
  } else {
    self.script_noteworthy = "default";
  }
  self thread airlock_buy_think();
}

function airlock_buy_think() {
  self endon("kill_door_think");
  cost = 1000;
  if(isDefined(self.zombie_cost)) {
    cost = self.zombie_cost;
  }
  while(true) {
    switch (self.script_noteworthy) {
      case "electric_door": {
        level flag::wait_till("power_on");
        break;
      }
      case "electric_buyable_door": {
        level flag::wait_till("power_on");
        self zm_utility::set_hint_string(self, "default_buy_door", cost);
        if(!self airlock_buy()) {
          continue;
        }
        break;
      }
      default: {
        self zm_utility::set_hint_string(self, "default_buy_door", cost);
        if(!self airlock_buy()) {
          continue;
        }
        self moon_door_opened();
        break;
      }
    }
  }
}

function moon_door_opened() {
  self notify("door_opened");
  if(isDefined(self.script_flag)) {
    tokens = strtok(self.script_flag, ",");
    for(i = 0; i < tokens.size; i++) {
      level flag::set(tokens[i]);
    }
  }
  for(i = 0; i < self.trigs.size; i++) {
    self.trigs[i] triggerenable(1);
    self.trigs[i] thread change_door_models();
  }
  zm_utility::play_sound_at_pos("purchase", self.origin);
  all_trigs = getEntArray(self.target, "target");
  for(i = 0; i < all_trigs.size; i++) {
    all_trigs[i] triggerenable(0);
  }
}

function change_door_models() {
  doors = getEntArray(self.target, "targetname");
  for(i = 0; i < doors.size; i++) {
    if(isDefined(doors[i].model) && doors[i].model == "p7_zm_moo_door_airlock_heavy_lt_locked") {
      doors[i] setModel("p7_zm_moo_door_airlock_heavy_lt");
    } else {
      if(isDefined(doors[i].model) && doors[i].model == "p7_zm_moo_door_airlock_heavy_rt_locked") {
        doors[i] setModel("p7_zm_moo_door_airlock_heavy_rt");
      } else if(isDefined(doors[i].model) && doors[i].model == "p7_zm_moo_door_airlock_heavy_single_locked") {
        doors[i] setModel("p7_zm_moo_door_airlock_heavy_single");
      }
    }
    doors[i] thread airlock_connect_paths();
  }
}

function airlock_connect_paths() {
  if(self.classname == "script_brushmodel") {
    self notsolid();
    self connectpaths();
    if(!isDefined(self._door_open) || self._door_open == 0) {
      self solid();
    }
  }
}

function airlock_buy() {
  self waittill("trigger", who, force);
  if(getdvarint("zombie_unlock_all") > 0 || (isDefined(force) && force)) {
    return true;
  }
  if(!who usebuttonpressed()) {
    return false;
  }
  if(who zm_utility::in_revive_trigger()) {
    return false;
  }
  if(who.is_drinking > 0) {
    return false;
  }
  cost = 0;
  upgraded = 0;
  if(zombie_utility::is_player_valid(who)) {
    cost = self.zombie_cost;
    if(who zm_pers_upgrades_functions::is_pers_double_points_active()) {
      cost = who zm_pers_upgrades_functions::pers_upgrade_double_points_cost(cost);
      upgraded = 1;
    }
    if(who zm_score::can_player_purchase(cost)) {
      who zm_score::minus_to_player_score(cost);
      scoreevents::processscoreevent("open_door", who);
      demo::bookmark("zm_player_door", gettime(), who);
      who zm_stats::increment_client_stat("doors_purchased");
      who zm_stats::increment_player_stat("doors_purchased");
      who zm_stats::increment_challenge_stat("SURVIVALIST_BUY_DOOR");
      self.purchaser = who;
      who recordmapevent(5, gettime(), who.origin, level.round_number, cost);
      bb::logpurchaseevent(who, self, cost, self.target, upgraded, "_door", "_purchase");
      who zm_stats::increment_challenge_stat("ZM_DAILY_PURCHASE_DOORS");
    } else {
      zm_utility::play_sound_at_pos("no_purchase", self.origin);
      who zm_audio::create_and_play_dialog("general", "outofmoney");
      return false;
    }
  }
  return true;
}

function airlock_init() {
  self.type = undefined;
  self._door_open = 0;
  targets = getEntArray(self.target, "targetname");
  self.doors = [];
  for(i = 0; i < targets.size; i++) {
    targets[i] zm_blockers::door_classify(self);
    targets[i].startpos = targets[i].origin;
  }
  self thread airlock_think();
}

function airlock_think() {
  while(true) {
    self waittill("trigger", who);
    if(isDefined(self.doors[0].startpos) && self.doors[0].startpos != self.doors[0].origin) {
      continue;
    }
    for(i = 0; i < self.doors.size; i++) {
      self.doors[i] thread airlock_activate(0.25, 1);
    }
    self._door_open = 1;
    while(self moon_airlock_occupied() || (isDefined(self.doors[0].door_moving) && self.doors[0].door_moving == 1)) {
      wait(0.1);
    }
    self thread door_clean_up_corpses();
    for(i = 0; i < self.doors.size; i++) {
      self.doors[i] thread airlock_activate(0.25, 0);
    }
    self._door_open = 0;
  }
}

function airlock_activate(time = 1, open = 1) {
  if(isDefined(self.door_moving)) {
    return;
  }
  self.door_moving = 1;
  self notsolid();
  if(self.classname == "script_brushmodel") {
    if(open) {
      self connectpaths();
    }
  }
  if(isDefined(self.script_sound)) {
    if(open) {
      self playSound("zmb_airlock_open");
    } else {
      self playSound("zmb_airlock_close");
    }
  }
  scale = 1;
  if(!open) {
    scale = -1;
  }
  switch (self.script_string) {
    case "slide_apart": {
      if(isDefined(self.script_vector)) {
        vector = vectorscale(self.script_vector, scale);
        if(open) {
          if(isDefined(self.startpos)) {
            self moveto(self.startpos + vector, time);
          } else {
            self moveto(self.origin + vector, time);
          }
          self._door_open = 1;
        } else {
          if(isDefined(self.startpos)) {
            self moveto(self.startpos, time);
          } else {
            self moveto(self.origin - vector, time);
          }
          self._door_open = 0;
        }
        self thread zm_blockers::door_solid_thread();
      }
      break;
    }
  }
}

function moon_airlock_occupied() {
  is_occupied = 0;
  zombies = getaiarray();
  for(i = 0; i < zombies.size; i++) {
    if(zombies[i] istouching(self)) {
      is_occupied++;
    }
  }
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    if(players[i] istouching(self)) {
      is_occupied++;
    }
  }
  if(is_occupied > 0) {
    if(isDefined(self.doors[0].startpos) && self.doors[0].startpos == self.doors[0].origin) {
      for(i = 0; i < self.doors.size; i++) {
        self.doors[i] thread airlock_activate(0.25, 1);
      }
      self._door_open = 1;
    }
    return true;
  }
  return false;
}

function door_clean_up_corpses() {
  corpses = getcorpsearray();
  if(isDefined(corpses)) {
    for(i = 0; i < corpses.size; i++) {
      if(corpses[i] istouching(self)) {
        corpses[i] thread door_remove_corpses();
      }
    }
  }
}

function door_remove_corpses() {
  if(isDefined(level._effect["dog_gib"])) {
    playFX(level._effect["dog_gib"], self.origin);
  }
  self delete();
}

function zapper_light_green(light_name, key_name) {
  var_e9947991 = getEntArray(light_name, key_name);
  foreach(light in var_e9947991) {
    var_8d53d8ef = "zap_teleport_light_0" + light.script_int;
    exploder::exploder(var_8d53d8ef);
  }
}

function zapper_light_red(light_name, key_name) {
  var_e9947991 = getEntArray(light_name, key_name);
  foreach(light in var_e9947991) {
    var_8d53d8ef = "zap_teleport_light_0" + light.script_int;
    exploder::stop_exploder(var_8d53d8ef);
  }
}

function moon_intermission() {
  self closeingamemenu();
  level endon("stop_intermission");
  self endon("disconnect");
  self endon("death");
  self notify("_zombie_game_over");
  self.score = self.score_total;
  self.sessionstate = "intermission";
  self.spectatorclient = -1;
  self.killcamentity = -1;
  self.archivetime = 0;
  self.psoffsettime = 0;
  self.friendlydamage = undefined;
  points = struct::get_array("intermission", "targetname");
  for(i = 0; i < points.size; i++) {
    if(level flag::get("enter_nml")) {
      if(points[i].script_noteworthy == "moon") {
        arrayremovevalue(points, points[i]);
      }
      continue;
    }
    if(points[i].script_noteworthy == "earth") {
      arrayremovevalue(points, points[i]);
    }
  }
  if(!isDefined(points) || points.size == 0) {
    points = getEntArray("info_intermission", "classname");
    if(points.size < 1) {
      println("");
      return;
    }
  }
  self.game_over_bg = newclienthudelem(self);
  self.game_over_bg.horzalign = "fullscreen";
  self.game_over_bg.vertalign = "fullscreen";
  self.game_over_bg setshader("black", 640, 480);
  self.game_over_bg.alpha = 1;
  org = undefined;
  while(true) {
    points = array::randomize(points);
    for(i = 0; i < points.size; i++) {
      point = points[i];
      if(!isDefined(org)) {
        self spawn(point.origin, point.angles);
      }
      if(isDefined(points[i].target)) {
        if(!isDefined(org)) {
          org = spawn("script_model", self.origin + (vectorscale((0, 0, -1), 60)));
          org setModel("tag_origin");
        }
        org.origin = points[i].origin;
        org.angles = points[i].angles;
        for(j = 0; j < getplayers().size; j++) {
          player = getplayers()[j];
          player camerasetposition(org);
          player camerasetlookat();
          player cameraactivate(1);
        }
        speed = 20;
        if(isDefined(points[i].speed)) {
          speed = points[i].speed;
        }
        target_point = struct::get(points[i].target, "targetname");
        dist = distance(points[i].origin, target_point.origin);
        time = dist / speed;
        q_time = time * 0.25;
        if(q_time > 1) {
          q_time = 1;
        }
        self.game_over_bg fadeovertime(q_time);
        self.game_over_bg.alpha = 0;
        org moveto(target_point.origin, time, q_time, q_time);
        org rotateto(target_point.angles, time, q_time, q_time);
        wait(time - q_time);
        self.game_over_bg fadeovertime(q_time);
        self.game_over_bg.alpha = 1;
        wait(q_time);
        continue;
      }
      self.game_over_bg fadeovertime(1);
      self.game_over_bg.alpha = 0;
      wait(5);
      self.game_over_bg thread zm::fade_up_over_time(1);
    }
  }
}

function hacker_location_random_init() {
  hacker_tool_array = [];
  hacker_pos = undefined;
  level.hacker_tool_positions = [];
  hacker = getEntArray("zombie_equipment_upgrade", "targetname");
  for(i = 0; i < hacker.size; i++) {
    if(isDefined(hacker[i].zombie_equipment_upgrade) && hacker[i].zombie_equipment_upgrade == "equip_hacker") {
      if(!isDefined(hacker_tool_array)) {
        hacker_tool_array = [];
      } else if(!isarray(hacker_tool_array)) {
        hacker_tool_array = array(hacker_tool_array);
      }
      hacker_tool_array[hacker_tool_array.size] = hacker[i];
      struct = spawnStruct();
      struct.trigger_org = hacker[i].origin;
      struct.model_org = getent(hacker[i].target, "targetname").origin;
      struct.model_ang = getent(hacker[i].target, "targetname").angles;
      level.hacker_tool_positions[level.hacker_tool_positions.size] = struct;
    }
  }
  if(hacker_tool_array.size > 1) {
    hacker_pos = hacker_tool_array[randomint(hacker_tool_array.size)];
    arrayremovevalue(hacker_tool_array, hacker_pos);
    array::thread_all(hacker_tool_array, &hacker_position_cleanup);
  }
}

function hacker_position_cleanup() {
  model = getent(self.target, "targetname");
  if(isDefined(model)) {
    model delete();
  }
  if(isDefined(self)) {
    self delete();
  }
}

function moon_glass_breach_init() {
  level.glass = getEntArray("moon_breach_glass", "targetname");
  array::thread_all(level.glass, &glass_breach_think);
  level.var_4fd08591 = [];
  level.var_4fd08591["bridge_zone"] = 1;
  level.var_4fd08591["generator_exit_east_zone"] = 1;
  level.var_4fd08591["enter_forest_east_zone"] = 1;
  level flag::wait_till("start_zombie_round_logic");
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    players[i] thread check_for_grenade_throw();
  }
}

function glass_gets_destroyed() {
  if(isDefined(self.fxpos_array)) {
    for(i = 0; i < self.fxpos_array.size; i++) {
      if(!isDefined(self.fxpos_array[i].var_3ce053e5)) {
        playFX(level._effect["glass_impact"], self.fxpos_array[i].origin, anglesToForward(self.fxpos_array[i].angles));
        self.fxpos_array[i].var_3ce053e5 = 1;
      }
    }
  }
  if(isDefined(self.script_noteworthy)) {
    if(isDefined(level.var_4fd08591[self.script_noteworthy]) && level.var_4fd08591[self.script_noteworthy]) {
      function_f1daf14e(self.script_noteworthy);
      level.var_4fd08591[self.script_noteworthy] = 0;
    }
    level thread send_client_notify_for_breach(self.script_noteworthy);
    _zones = getEntArray(self.script_noteworthy, "targetname");
    if(isDefined(_zones)) {
      for(i = 0; i < _zones.size; i++) {
        _zones[i].script_string = "lowgravity";
      }
      level thread zm_moon_gravity::zone_breached(self.script_noteworthy);
    }
  }
  util::wait_network_frame();
  if(isDefined(self.model) && self.damage_state == 0) {
    self setModel(self.model + "_dmg");
    self.damage_state = 1;
    return;
  }
  self delete();
}

function wait_for_grenade_explode(player) {
  player endon("projectile_impact");
  self waittill("explode", grenade_origin);
  self thread check_for_grenade_damage_on_window(grenade_origin);
}

function wait_for_projectile_impact(grenade) {
  grenade endon("explode");
  self waittill("projectile_impact", weapon_name, position);
  self thread check_for_grenade_damage_on_window(position);
}

function check_for_grenade_damage_on_window(grenade_origin) {
  radiussqtocheck = 44096;
  for(i = 0; i < level.glass.size; i++) {
    if(level.glass[i].damage_state == 0) {
      glass_destroyed = 0;
      for(j = 0; j < level.glass[i].fxpos_array.size; j++) {
        glass_origin = level.glass[i].fxpos_array[j].origin;
        if(distancesquared(glass_origin, grenade_origin) < radiussqtocheck) {
          glass_destroyed = 1;
          break;
        }
      }
      if(glass_destroyed) {
        level.glass[i] glass_gets_destroyed();
        level.glass[i].damage_state = 1;
      }
    }
  }
}

function check_for_grenade_throw() {
  while(true) {
    self waittill("grenade_fire", grenade, weapname);
    grenade thread wait_for_grenade_explode(self);
    self thread wait_for_projectile_impact(grenade);
  }
}

function glass_breach_think() {
  level endon("intermission");
  self.fxpos_array = [];
  if(isDefined(self.target)) {
    self.fxpos_array = struct::get_array(self.target, "targetname");
  }
  self.health = 99999;
  self.damage_state = 0;
  while(true) {
    self waittill("damage", amount, attacker, direction, point, dmg_type);
    if(isplayer(attacker) && (dmg_type == "MOD_PROJECTILE" || dmg_type == "MOD_PROJECTILE_SPLASH")) {
      if(self.damage_state == 0) {
        self glass_gets_destroyed();
        self.damage_state = 1;
      }
    }
  }
}

function send_client_notify_for_breach(zone) {
  switch (zone) {
    case "bridge_zone": {
      if(!(isDefined(level.audio_zones_breached["1"]) && level.audio_zones_breached["1"])) {
        level clientfield::increment("Az1");
        level.audio_zones_breached["1"] = 1;
        if(level flag::get("power_on")) {
          level thread zm_moon_amb::play_mooncomp_vox("vox_mcomp_breach_start");
        }
      }
      break;
    }
    case "generator_exit_east_zone": {
      if(!(isDefined(level.audio_zones_breached["4a"]) && level.audio_zones_breached["4a"])) {
        level clientfield::increment("Az4a");
        level.audio_zones_breached["4a"] = 1;
        if(level flag::get("power_on")) {
          level thread zm_moon_amb::play_mooncomp_vox("vox_mcomp_breach_labs");
        }
      }
      break;
    }
    case "enter_forest_east_zone": {
      if(!(isDefined(level.audio_zones_breached["4b"]) && level.audio_zones_breached["4b"])) {
        level clientfield::increment("Az4b");
        level.audio_zones_breached["4b"] = 1;
        if(level flag::get("power_on")) {
          level thread zm_moon_amb::play_mooncomp_vox("vox_mcomp_breach_labs");
        }
      }
      break;
    }
  }
}

function function_f1daf14e(str_area) {
  var_af1a2667 = undefined;
  switch (str_area) {
    case "bridge_zone": {
      var_af1a2667 = "fxexp_300";
      break;
    }
    case "generator_exit_east_zone": {
      var_af1a2667 = "fxexp_320";
      break;
    }
    case "enter_forest_east_zone": {
      var_af1a2667 = "fxexp_340";
      break;
    }
  }
  if(isDefined(var_af1a2667)) {
    exploder::exploder(var_af1a2667);
  }
}

function zombie_moon_receiving_hatch_init() {
  hatches = getEntArray("recieving_hatch", "targetname");
  array::thread_all(hatches, &zombie_moon_hatch);
  level thread function_8ceda02();
}

function zombie_moon_hatch() {
  scale = 1;
  level flag::wait_till("power_on");
  self playSound("evt_loading_door_start");
  if(isDefined(self.script_vector)) {
    vector = vectorscale(self.script_vector, scale);
    self moveto(self.origin + vector, 1);
    if(isDefined(self.script_noteworthy) && self.script_noteworthy == "hatch_clip") {
      self thread zm_blockers::disconnect_paths_when_done();
    } else {
      self notsolid();
      self connectpaths();
    }
    wait(1);
    self playSound("evt_loading_door_end");
  }
}

function function_8ceda02() {
  a_nd_traversal = getnodearray("hatch_node", "targetname");
  foreach(node in a_nd_traversal) {
    unlinktraversal(node);
  }
  level flag::wait_till("power_on");
  wait(1);
  foreach(node in a_nd_traversal) {
    linktraversal(node);
  }
}

function sky_transition_fog_settings() {
  players = getplayers();
  if(level flag::get("enter_nml")) {
    for(i = 0; i < players.size; i++) {
      players[i] clientfield::set_to_player("player_sky_transition", 1);
    }
  } else {
    for(i = 0; i < players.size; i++) {
      players[i] clientfield::set_to_player("player_sky_transition", 0);
    }
  }
}