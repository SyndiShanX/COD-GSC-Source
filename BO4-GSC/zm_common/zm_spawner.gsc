/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_spawner.gsc
***********************************************/

#include scripts\core_common\activecamo_shared;
#include scripts\core_common\ai\systems\gib;
#include scripts\core_common\ai\zombie_death;
#include scripts\core_common\ai\zombie_shared;
#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\ai_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\demo_shared;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\scene_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_bgb;
#include scripts\zm_common\zm_blockers;
#include scripts\zm_common\zm_camos;
#include scripts\zm_common\zm_equipment;
#include scripts\zm_common\zm_loadout;
#include scripts\zm_common\zm_net;
#include scripts\zm_common\zm_powerups;
#include scripts\zm_common\zm_puppet;
#include scripts\zm_common\zm_quick_spawning;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_stats;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_weapons;

#namespace zm_spawner;

init() {
  level._contextual_grab_lerp_time = 0.3;
  level.zombie_spawners = getEntArray("zombie_spawner", "script_noteworthy");

  if(isDefined(level.use_multiple_spawns) && level.use_multiple_spawns) {
    level.zombie_spawn = [];

    for(i = 0; i < level.zombie_spawners.size; i++) {
      if(isDefined(level.zombie_spawners[i].script_int)) {
        int = level.zombie_spawners[i].script_int;

        if(!isDefined(level.zombie_spawn[int])) {
          level.zombie_spawn[int] = [];
        }

        level.zombie_spawn[int][level.zombie_spawn[int].size] = level.zombie_spawners[i];
      }
    }
  }

  if(isDefined(level.ignore_spawner_func)) {
    for(i = 0; i < level.zombie_spawners.size; i++) {
      ignore = [
        [level.ignore_spawner_func]
      ](level.zombie_spawners[i]);

      if(ignore) {
        arrayremovevalue(level.zombie_spawners, level.zombie_spawners[i]);
      }
    }
  }

  if(!isDefined(level.attack_player_thru_boards_range)) {
    level.attack_player_thru_boards_range = 109.8;
  }

  if(isDefined(level._game_module_custom_spawn_init_func)) {
    [[level._game_module_custom_spawn_init_func]]();
  }

  level thread debug_show_exterior_goals();

}

debug_show_exterior_goals() {
  while(true) {
    if(isDefined(level.toggle_show_exterior_goals) && level.toggle_show_exterior_goals) {
      color = (1, 1, 1);
      color_red = (1, 0, 0);
      color_blue = (0, 0, 1);

      foreach(zone in level.zones) {
        foreach(location in zone.a_loc_types[#"zombie_location"]) {
          recordstar(location.origin, color);
        }
      }

      foreach(zone in level.zones) {
        foreach(location in zone.a_loc_types[#"zombie_location"]) {
          foreach(goal in level.exterior_goals) {
            if(goal.script_string == location.script_string) {
              recordline(location.origin, goal.origin, color);
              goal.has_spawner = 1;
              break;
            }
          }
        }
      }

      foreach(goal in level.exterior_goals) {
        if(isDefined(goal.has_spawner) && goal.has_spawner) {
          recordcircle(goal.origin, 16, color);
          continue;
        }

        if(isDefined(goal.script_string) && goal.script_string == "<dev string:x38>") {
          recordcircle(goal.origin, 16, color_blue);
          continue;
        }

        recordcircle(goal.origin, 16, color_red);
      }
    }

    waitframe(1);
  }
}

  function is_spawner_targeted_by_blocker(ent) {
    if(isDefined(ent.targetname)) {
      targeters = getEntArray(ent.targetname, "target");

      for(i = 0; i < targeters.size; i++) {
        if(targeters[i].targetname == "zombie_door" || targeters[i].targetname == "zombie_debris") {
          return true;
        }

        result = is_spawner_targeted_by_blocker(targeters[i]);

        if(result) {
          return true;
        }
      }
    }

    return false;
  }

add_custom_zombie_spawn_logic(func) {
  if(!isDefined(level._zombie_custom_spawn_logic)) {
    level._zombie_custom_spawn_logic = [];
  }

  level._zombie_custom_spawn_logic[level._zombie_custom_spawn_logic.size] = func;
}

zombie_spawn_init() {
  self.targetname = "zombie";
  self.script_noteworthy = undefined;
  self.var_2f68be48 = 1;
  self.var_7cc959b1 = 1;
  self.var_b69c12bc = 1;

  if(isDefined(zm_utility::get_gamemode_var("pre_init_zombie_spawn_func"))) {
    self[[zm_utility::get_gamemode_var("pre_init_zombie_spawn_func")]]();
  }

  self thread zm_audio::play_ambient_zombie_vocals();
  self thread zm_audio::zmbaivox_notifyconvert();
  self.zmb_vocals_attack = "zmb_vocals_zombie_attack";
  self.allowdeath = 1;
  self.force_gib = 1;
  self.is_zombie = 1;
  self allowedstances("stand");
  self.attackercountthreatscale = 0;
  self.currentenemythreatscale = 0;
  self.recentattackerthreatscale = 0;
  self.coverthreatscale = 0;
  self.fovcosine = 0;
  self.fovcosinebusy = 0;
  self.zombie_damaged_by_bar_knockdown = 0;
  self.gibbed = 0;
  self.head_gibbed = 0;
  self.goalradius = 32;
  self.disablearrivals = 1;
  self.disableexits = 1;
  self.grenadeawareness = 0;
  self.badplaceawareness = 1;
  self.ignoresuppression = 1;
  self.suppressionthreshold = 1;
  self.nododgemove = 1;
  self.dontshootwhilemoving = 1;
  self.pathenemylookahead = 0;
  self.holdfire = 1;
  self.chatinitialized = 0;
  self zombie_utility::function_df5afb5e(0);
  self.canbetargetedbyturnedzombies = 1;
  self.var_6d23c054 = 1;

  if(!isDefined(self.zombie_arms_position)) {
    if(randomint(2) == 0) {
      self.zombie_arms_position = "up";
    } else {
      self.zombie_arms_position = "down";
    }
  }

  if(randomint(100) < 25) {
    self.canstumble = 1;
  }

  self zm_utility::disable_react();

  if(!isDefined(level.zombie_health)) {
    level.zombie_health = zombie_utility::ai_calculate_health(zombie_utility::get_zombie_var(#"zombie_health_start"), level.round_number);
  }

  self.maxhealth = int(level.zombie_health * (isDefined(level.var_46e03bb6) ? level.var_46e03bb6 : 1));
  self.health = self.maxhealth;
  self.freezegun_damage = 0;
  self setavoidancemask("avoid none");
  self pathmode("dont move");
  level thread zombie_death_event(self);
  self thread zombie_utility::zombie_gib_on_damage();
  self thread zombie_damage_failsafe();
  self.deathfunction = &zombie_death_animscript;
  self.flame_damage_time = 0;
  self.meleedamage = 60;
  self.no_powerups = 1;

  self zombie_history("<dev string:x45>" + self.origin);

    self.thundergun_knockdown_func = level.basic_zombie_thundergun_knockdown;
  self.tesla_head_gib_func = &zombie_tesla_head_gib;
  self.team = level.zombie_team;
  self.updatesight = 0;

  if(isDefined(level.var_a26e0f74)) {
    self.heroweapon_kill_power = level.var_a26e0f74;
    self.sword_kill_power = level.var_a26e0f74;
  } else {
    self.heroweapon_kill_power = 2;
    self.sword_kill_power = 2;
  }

  if(isDefined(level.var_9c55db3)) {
    self[[level.var_9c55db3]]();
  }

  if(isDefined(zm_utility::get_gamemode_var("post_init_zombie_spawn_func"))) {
    self[[zm_utility::get_gamemode_var("post_init_zombie_spawn_func")]]();
  }

  if(isDefined(level.var_6d8a8e47) && level.var_6d8a8e47) {
    self thread function_3f1243fb();
  }
}

function_3f1243fb() {
  self endon(#"death");
  util::wait_network_frame();
  self thread zombie_utility::makezombiecrawler();
}

function_c8ba0b8e() {
  self endon(#"death");
  self waittill(#"completed_emerging_into_playable_area");
  self zombie_utility::makezombiecrawler();
}

zombie_damage_failsafe() {
  self endon(#"death");

  while(true) {
    wait 0.5;

    if(!isalive(self.enemy) || !isplayer(self.enemy) || !self istouching(self.enemy)) {
      continue;
    }

    e_enemy = self.enemy;
    v_starting_origin = self.enemy.origin;
    var_f2ca854b = self.enemy.health;
    var_65a69eba = undefined;
    var_f3a1b629 = 0;

    while(isalive(self.enemy) && isplayer(self.enemy) && e_enemy == self.enemy && self istouching(self.enemy) && !self.enemy laststand::player_is_in_laststand()) {
      if(distancesquared(v_starting_origin, self.enemy.origin) > 60 * 60) {
        break;
      }

      if(isDefined(self.enemy.hasriotshield) && self.enemy.hasriotshield) {
        if(!isDefined(var_65a69eba)) {
          var_65a69eba = self.enemy damageriotshield(0);
        } else if(self.enemy damageriotshield(0) < var_65a69eba) {
          break;
        }
      } else if(isDefined(var_65a69eba)) {
        var_65a69eba = undefined;
        break;
      }

      if(self.enemy.health < var_f2ca854b) {
        break;
      }

      if(var_f3a1b629 >= 7) {
        self.enemy dodamage(self.enemy.health + 1000, self.enemy.origin, self, self, "none", "MOD_RIFLE_BULLET");
        break;
      }

      wait 0.5;
      var_f3a1b629 += 0.5;
    }
  }
}

should_skip_teardown(find_flesh_struct_string) {
  if(!isDefined(find_flesh_struct_string)) {
    return true;
  }

  if(find_flesh_struct_string === "find_flesh") {
    return true;
  }

  return false;
}

zombie_think() {
  self endon(#"death");
  assert(!self.isdog);
  self.ai_state = "zombie_think";
  find_flesh_struct_string = undefined;

  if(isDefined(level.zombie_custom_think_logic)) {
    shouldwait = self[[level.zombie_custom_think_logic]]();

    if(shouldwait) {
      self waittill(#"zombie_custom_think_done", find_flesh_struct_string);
    }
  } else if(isDefined(self.start_inert) && self.start_inert) {
    find_flesh_struct_string = "find_flesh";
    self thread function_d3b3f8b6();
  } else {
    if(isDefined(self.custom_location)) {
      self thread[[self.custom_location]]();
    } else {
      self thread do_zombie_spawn();
    }

    waitresult = self waittill(#"risen");
    find_flesh_struct_string = waitresult.find_flesh_struct_string;
  }

  self.find_flesh_struct_string = find_flesh_struct_string;

  self.backupnode = self.first_node;
  self thread zm_puppet::wait_for_puppet_pickup();

    self setgoal(self.origin);

  if(!(isDefined(self.start_inert) && self.start_inert)) {
    self pathmode("move allowed");
  }

  self.zombie_think_done = 1;
}

function_d3b3f8b6() {
  self endon(#"death");

  if(isDefined(self.anchor)) {
    self waittill(#"risen");
  }

  self setgoal(self.origin);
  self pathmode("move allowed");
}

zombie_entered_playable() {
  self endon(#"death");

  if(zm_utility::function_21f4ac36()) {
    if(!isDefined(level.var_a2a9b2de)) {
      level.var_a2a9b2de = getnodearray("player_region", "script_noteworthy");
    }
  }

  if(zm_utility::function_c85ebbbc()) {
    if(!isDefined(level.playable_areas)) {
      level.playable_areas = getEntArray("player_volume", "script_noteworthy");
    }
  }

  while(true) {
    if(isDefined(level.var_a2a9b2de)) {
      node = function_52c1730(self.origin, level.var_a2a9b2de, 500);

      if(isDefined(node)) {
        self zombie_complete_emerging_into_playable_area();
        return;
      }
    }

    if(isDefined(level.playable_areas)) {
      foreach(area in level.playable_areas) {
        if(self istouching(area)) {
          self zombie_complete_emerging_into_playable_area();
          return;
        }
      }
    }

    wait 1;
  }
}

zombie_assure_node() {
  self endon(#"death", #"goal");
  level endon(#"intermission");
  start_pos = self.origin;

  if(isDefined(self.entrance_nodes)) {
    for(i = 0; i < self.entrance_nodes.size; i++) {
      if(self zombie_bad_path()) {

        self zombie_history("<dev string:x67>" + self.entrance_nodes[i].origin);
        println("<dev string:x98>" + self.origin + "<dev string:xa6>" + self.entrance_nodes[i].origin);
        level thread zm_utility::draw_line_ent_to_pos(self, self.entrance_nodes[i].origin, "<dev string:xe2>");

          self.first_node = self.entrance_nodes[i];
        self setgoal(self.entrance_nodes[i].origin);
        continue;
      }

      return;
    }
  }

  wait 2;
  nodes = array::get_all_closest(self.origin, level.exterior_goals, undefined, 20);

  if(isDefined(nodes)) {
    self.entrance_nodes = nodes;

    for(i = 0; i < self.entrance_nodes.size; i++) {
      if(self zombie_bad_path()) {

        self zombie_history("<dev string:x67>" + self.entrance_nodes[i].origin);
        println("<dev string:x98>" + self.origin + "<dev string:xa6>" + self.entrance_nodes[i].origin);
        level thread zm_utility::draw_line_ent_to_pos(self, self.entrance_nodes[i].origin, "<dev string:xe2>");

          self.first_node = self.entrance_nodes[i];
        self setgoal(self.entrance_nodes[i].origin);
        continue;
      }

      return;
    }
  }

  self zombie_history("<dev string:xe9>");

    wait 20;
  self dodamage(self.health + 10, self.origin);

  if(isDefined(level.put_timed_out_zombies_back_in_queue) && level.put_timed_out_zombies_back_in_queue && !(isDefined(self.has_been_damaged_by_player) && self.has_been_damaged_by_player)) {
    level.zombie_total++;
    level.zombie_total_subtract++;
  }

  level.zombies_timeout_spawn++;
}

zombie_bad_path() {
  var_29b8f3d0 = self waittilltimeout(2, #"bad_path");

  if(var_29b8f3d0._notify === "bad_path") {
    return true;
  }

  return false;
}

do_a_taunt() {
  self endon(#"death");

  if(self.missinglegs) {
    return 0;
  }

  if(!self.first_node.zbarrier zbarriersupportszombietaunts()) {
    return;
  }

  self.old_origin = self.origin;

  if(getdvarstring(#"zombie_taunt_freq") == "") {
    setdvar(#"zombie_taunt_freq", 5);
  }

  freq = getdvarint(#"zombie_taunt_freq", 0);

  if(freq >= randomint(100)) {
    bhtnactionstartevent(self, "taunt");
    self notify(#"bhtn_action_notify", {
      #action: "taunt"
    });
    tauntstate = "zm_taunt";

    if(isDefined(self.first_node.zbarrier) && self.first_node.zbarrier getzbarriertauntanimstate() != "") {
      tauntstate = self.first_node.zbarrier getzbarriertauntanimstate();
    }

    self animscripted("taunt_anim", self.origin, self.angles, "ai_zombie_taunts_4");
    self taunt_notetracks("taunt_anim");
  }
}

taunt_notetracks(msg) {
  self endon(#"death");

  while(true) {
    waitresult = self waittill(msg);

    if(waitresult.notetrack == "end") {
      self forceteleport(self.old_origin);
      return;
    }
  }
}

should_attack_player_thru_boards() {
  if(self.missinglegs) {
    return false;
  }

  if(isDefined(self.first_node.zbarrier)) {
    if(!self.first_node.zbarrier zbarriersupportszombiereachthroughattacks()) {
      return false;
    }
  }

  if(getdvarstring(#"zombie_reachin_freq") == "") {
    setdvar(#"zombie_reachin_freq", 50);
  }

  freq = getdvarint(#"zombie_reachin_freq", 0);
  players = getplayers();
  attack = 0;
  self.player_targets = [];

  for(i = 0; i < players.size; i++) {
    if(isalive(players[i]) && !isDefined(players[i].revivetrigger) && distance2d(self.origin, players[i].origin) <= level.attack_player_thru_boards_range) {
      self.player_targets[self.player_targets.size] = players[i];
      attack = 1;
    }
  }

  if(!attack || freq < randomint(100)) {
    return false;
  }

  self.old_origin = self.origin;
  attackanimstate = "zm_window_melee";

  if(isDefined(self.first_node.zbarrier) && self.first_node.zbarrier getzbarrierreachthroughattackanimstate() != "") {
    attackanimstate = self.first_node.zbarrier getzbarrierreachthroughattackanimstate();
  }

  bhtnactionstartevent(self, "attack");
  self notify(#"bhtn_action_notify", {
    #action: "attack"
  });
  self animscripted("window_melee_anim", self.origin, self.angles, "ai_zombie_window_attack_arm_l_out");
  self window_notetracks("window_melee_anim");
  return true;
}

window_notetracks(msg) {
  self endon(#"death");

  while(true) {
    waitresult = self waittill(msg);

    if(waitresult.notetrack == "end") {
      self teleport(self.old_origin);
      return;
    }

    if(waitresult.notetrack == "fire") {
      if(self.ignoreall) {
        self val::reset(#"attack_properties", "ignoreall");
      }

      if(isDefined(self.first_node)) {
        var_e3df303a = 8100;

        if(isDefined(level.attack_player_thru_boards_range)) {
          var_e3df303a = level.attack_player_thru_boards_range * level.attack_player_thru_boards_range;
        }

        for(i = 0; i < self.player_targets.size; i++) {
          playerdistsq = distance2dsquared(self.player_targets[i].origin, self.origin);
          heightdiff = abs(self.player_targets[i].origin[2] - self.origin[2]);

          if(playerdistsq < var_e3df303a && heightdiff * heightdiff < var_e3df303a) {
            triggerdistsq = distance2dsquared(self.player_targets[i].origin, self.first_node.trigger_location.origin);
            heightdiff = abs(self.player_targets[i].origin[2] - self.first_node.trigger_location.origin[2]);

            if(triggerdistsq < 2601 && heightdiff * heightdiff < 2601) {
              self.player_targets[i] dodamage(self.meleedamage, self.origin, self, self, "none", "MOD_MELEE");
              break;
            }
          }
        }

        continue;
      }

      self melee();
    }
  }
}

get_attack_spot(node) {
  index = get_attack_spot_index(node);

  if(!isDefined(index)) {
    return false;
  }

  val = getdvarint(#"zombie_attack_spot", 0);

  if(val > -1) {
    index = val;
  }

    self .601 = node;
  self.attacking_spot_index = index;
  node.attack_spots_taken[index] = 1;
  self.attacking_spot = node.attack_spots[index];
  return true;
}

get_attack_spot_index(node) {
  indexes = [];

  if(!isDefined(node.attack_spots)) {
    node.attack_spots = [];
  }

  for(i = 0; i < node.attack_spots.size; i++) {
    if(!node.attack_spots_taken[i]) {
      indexes[indexes.size] = i;
    }
  }

  if(indexes.size == 0) {
    return undefined;
  }

  return indexes[randomint(indexes.size)];
}

zombie_tear_notetracks(msg, chunk, node) {
  self endon(#"death");

  while(true) {
    waitresult = self waittill(msg);

    if(waitresult.notetrack == "end") {
      return;
    }

    if(waitresult.notetrack == "board" || waitresult.notetrack == "destroy_piece" || waitresult.notetrack == "bar") {
      if(isDefined(level.zbarrier_zombie_tear_notetrack_override)) {
        self thread[[level.zbarrier_zombie_tear_notetrack_override]](node, chunk);
      }

      node.zbarrier setzbarrierpiecestate(chunk, "opening");
    }
  }
}

zombie_boardtear_offset_fx_horizontle(chunk, node) {
  if(isDefined(chunk.script_parameters) && (chunk.script_parameters == "repair_board" || chunk.script_parameters == "board")) {
    if(isDefined(chunk.unbroken) && chunk.unbroken == 1) {
      if(isDefined(chunk.material) && chunk.material == "glass") {
        playFX(level._effect[#"glass_break"], chunk.origin, node.angles);
        chunk.unbroken = 0;
      } else if(isDefined(chunk.material) && chunk.material == "metal") {
        playFX(level._effect[#"fx_zombie_bar_break"], chunk.origin);
        chunk.unbroken = 0;
      } else if(isDefined(chunk.material) && chunk.material == "rock") {
        if(isDefined(level.use_clientside_rock_tearin_fx) && level.use_clientside_rock_tearin_fx) {
          chunk clientfield::set("tearin_rock_fx", 1);
        } else {
          playFX(level._effect[#"wall_break"], chunk.origin);
        }

        chunk.unbroken = 0;
      }
    }
  }

  if(isDefined(chunk.script_parameters) && chunk.script_parameters == "barricade_vents") {
    if(isDefined(level.use_clientside_board_fx) && level.use_clientside_board_fx) {
      chunk clientfield::set("tearin_board_vertical_fx", 1);
    } else {
      playFX(level._effect[#"fx_zombie_bar_break"], chunk.origin);
    }

    return;
  }

  if(isDefined(chunk.material) && chunk.material == "rock") {
    if(isDefined(level.use_clientside_rock_tearin_fx) && level.use_clientside_rock_tearin_fx) {
      chunk clientfield::set("tearin_rock_fx", 1);
    }

    return;
  }

  if(isDefined(level.use_clientside_board_fx)) {
    chunk clientfield::set("tearin_board_vertical_fx", 1);
    return;
  }

  wait randomfloatrange(0.2, 0.4);
}

zombie_boardtear_offset_fx_verticle(chunk, node) {
  if(isDefined(chunk.script_parameters) && (chunk.script_parameters == "repair_board" || chunk.script_parameters == "board")) {
    if(isDefined(chunk.unbroken) && chunk.unbroken == 1) {
      if(isDefined(chunk.material) && chunk.material == "glass") {
        playFX(level._effect[#"glass_break"], chunk.origin, node.angles);
        chunk.unbroken = 0;
      } else if(isDefined(chunk.material) && chunk.material == "metal") {
        playFX(level._effect[#"fx_zombie_bar_break"], chunk.origin);
        chunk.unbroken = 0;
      } else if(isDefined(chunk.material) && chunk.material == "rock") {
        if(isDefined(level.use_clientside_rock_tearin_fx) && level.use_clientside_rock_tearin_fx) {
          chunk clientfield::set("tearin_rock_fx", 1);
        } else {
          playFX(level._effect[#"wall_break"], chunk.origin);
        }

        chunk.unbroken = 0;
      }
    }
  }

  if(isDefined(chunk.script_parameters) && chunk.script_parameters == "barricade_vents") {
    if(isDefined(level.use_clientside_board_fx)) {
      chunk clientfield::set("tearin_board_horizontal_fx", 1);
    } else {
      playFX(level._effect[#"fx_zombie_bar_break"], chunk.origin);
    }

    return;
  }

  if(isDefined(chunk.material) && chunk.material == "rock") {
    if(isDefined(level.use_clientside_rock_tearin_fx) && level.use_clientside_rock_tearin_fx) {
      chunk clientfield::set("tearin_rock_fx", 1);
    }

    return;
  }

  if(isDefined(level.use_clientside_board_fx)) {
    chunk clientfield::set("tearin_board_horizontal_fx", 1);
    return;
  }

  wait randomfloatrange(0.2, 0.4);
}

zombie_bartear_offset_fx_verticle(chunk) {
  if(isDefined(chunk.script_parameters) && chunk.script_parameters == "bar" || chunk.script_noteworthy == "board") {
    possible_tag_array_1 = [];
    possible_tag_array_1[0] = "Tag_fx_top";
    possible_tag_array_1[1] = "";
    possible_tag_array_1[2] = "Tag_fx_top";
    possible_tag_array_1[3] = "";
    possible_tag_array_2 = [];
    possible_tag_array_2[0] = "";
    possible_tag_array_2[1] = "Tag_fx_bottom";
    possible_tag_array_2[2] = "";
    possible_tag_array_2[3] = "Tag_fx_bottom";
    possible_tag_array_2 = array::randomize(possible_tag_array_2);
    random_fx = [];
    random_fx[0] = level._effect[#"fx_zombie_bar_break"];
    random_fx[1] = level._effect[#"fx_zombie_bar_break_lite"];
    random_fx[2] = level._effect[#"fx_zombie_bar_break"];
    random_fx[3] = level._effect[#"fx_zombie_bar_break_lite"];
    random_fx = array::randomize(random_fx);

    switch (randomint(9)) {
      case 0:
        playFXOnTag(level._effect[#"fx_zombie_bar_break_lite"], chunk, "Tag_fx_top");
        wait randomfloatrange(0, 0.3);
        playFXOnTag(level._effect[#"fx_zombie_bar_break_lite"], chunk, "Tag_fx_bottom");
        break;
      case 1:
        playFXOnTag(level._effect[#"fx_zombie_bar_break"], chunk, "Tag_fx_top");
        wait randomfloatrange(0, 0.3);
        playFXOnTag(level._effect[#"fx_zombie_bar_break"], chunk, "Tag_fx_bottom");
        break;
      case 2:
        playFXOnTag(level._effect[#"fx_zombie_bar_break_lite"], chunk, "Tag_fx_top");
        wait randomfloatrange(0, 0.3);
        playFXOnTag(level._effect[#"fx_zombie_bar_break"], chunk, "Tag_fx_bottom");
        break;
      case 3:
        playFXOnTag(level._effect[#"fx_zombie_bar_break"], chunk, "Tag_fx_top");
        wait randomfloatrange(0, 0.3);
        playFXOnTag(level._effect[#"fx_zombie_bar_break_lite"], chunk, "Tag_fx_bottom");
        break;
      case 4:
        playFXOnTag(level._effect[#"fx_zombie_bar_break_lite"], chunk, "Tag_fx_top");
        wait randomfloatrange(0, 0.3);
        playFXOnTag(level._effect[#"fx_zombie_bar_break_lite"], chunk, "Tag_fx_bottom");
        break;
      case 5:
        playFXOnTag(level._effect[#"fx_zombie_bar_break_lite"], chunk, "Tag_fx_top");
        break;
      case 6:
        playFXOnTag(level._effect[#"fx_zombie_bar_break_lite"], chunk, "Tag_fx_bottom");
        break;
      case 7:
        playFXOnTag(level._effect[#"fx_zombie_bar_break"], chunk, "Tag_fx_top");
        break;
      case 8:
        playFXOnTag(level._effect[#"fx_zombie_bar_break"], chunk, "Tag_fx_bottom");
        break;
    }
  }
}

zombie_bartear_offset_fx_horizontle(chunk) {
  if(isDefined(chunk.script_parameters) && chunk.script_parameters == "bar" || chunk.script_noteworthy == "board") {
    switch (randomint(10)) {
      case 0:
        playFXOnTag(level._effect[#"fx_zombie_bar_break_lite"], chunk, "Tag_fx_left");
        wait randomfloatrange(0, 0.3);
        playFXOnTag(level._effect[#"fx_zombie_bar_break_lite"], chunk, "Tag_fx_right");
        break;
      case 1:
        playFXOnTag(level._effect[#"fx_zombie_bar_break"], chunk, "Tag_fx_left");
        wait randomfloatrange(0, 0.3);
        playFXOnTag(level._effect[#"fx_zombie_bar_break"], chunk, "Tag_fx_right");
        break;
      case 2:
        playFXOnTag(level._effect[#"fx_zombie_bar_break_lite"], chunk, "Tag_fx_left");
        wait randomfloatrange(0, 0.3);
        playFXOnTag(level._effect[#"fx_zombie_bar_break"], chunk, "Tag_fx_right");
        break;
      case 3:
        playFXOnTag(level._effect[#"fx_zombie_bar_break"], chunk, "Tag_fx_left");
        wait randomfloatrange(0, 0.3);
        playFXOnTag(level._effect[#"fx_zombie_bar_break_lite"], chunk, "Tag_fx_right");
        break;
      case 4:
        playFXOnTag(level._effect[#"fx_zombie_bar_break_lite"], chunk, "Tag_fx_left");
        wait randomfloatrange(0, 0.3);
        playFXOnTag(level._effect[#"fx_zombie_bar_break_lite"], chunk, "Tag_fx_right");
        break;
      case 5:
        playFXOnTag(level._effect[#"fx_zombie_bar_break_lite"], chunk, "Tag_fx_left");
        break;
      case 6:
        playFXOnTag(level._effect[#"fx_zombie_bar_break_lite"], chunk, "Tag_fx_right");
        break;
      case 7:
        playFXOnTag(level._effect[#"fx_zombie_bar_break"], chunk, "Tag_fx_right");
        break;
      case 8:
        playFXOnTag(level._effect[#"fx_zombie_bar_break"], chunk, "Tag_fx_right");
        break;
    }
  }
}

check_zbarrier_piece_for_zombie_inert(chunk_index, zbarrier, zombie) {
  zombie endon(#"completed_emerging_into_playable_area");
  zombie waittill(#"stop_zombie_goto_entrance");

  if(zbarrier getzbarrierpiecestate(chunk_index) == "targetted_by_zombie") {
    zbarrier setzbarrierpiecestate(chunk_index, "closed");
  }
}

check_zbarrier_piece_for_zombie_death(chunk_index, zbarrier, zombie) {
  while(true) {
    if(zbarrier getzbarrierpiecestate(chunk_index) != "targetted_by_zombie") {
      return;
    }

    if(!isDefined(zombie) || !isalive(zombie)) {
      zbarrier setzbarrierpiecestate(chunk_index, "closed");
      return;
    }

    waitframe(1);
  }
}

check_for_zombie_death(zombie) {
  self endon(#"destroyed");
  wait 2.5;
  self zm_blockers::update_states("repaired");
}

player_can_score_from_zombies() {
  if(isDefined(self) && isDefined(self.inhibit_scoring_from_zombies) && self.inhibit_scoring_from_zombies) {
    return false;
  }

  return true;
}

zombie_death_points(origin, mod, hit_location, attacker, inflictor, zombie, team, weapon) {
  if(!isDefined(attacker) || !isplayer(attacker) && !isplayer(attacker.owner)) {
    return;
  }

  if(isDefined(attacker.owner)) {
    player = attacker.owner;
  } else {
    player = attacker;
  }

  if(!player player_can_score_from_zombies()) {
    zombie.marked_for_recycle = 1;
    return;
  }

  zombie thread zm_powerups::function_b753385f(weapon);

  if(isDefined(zombie.deathpoints_already_given) && zombie.deathpoints_already_given) {
    return;
  }

  zombie.deathpoints_already_given = 1;

  if(zm_equipment::is_equipment(zombie.damageweapon)) {
    return;
  }

  death_weapon = player.currentweapon;

  if(isDefined(zombie.damageweapon)) {
    death_weapon = zombie.damageweapon;
  }

  str_event = "death";

  if(isDefined(player)) {
    if(inflictor.subarchetype === #"zombie_wolf_ally") {
      zombie.var_12745932 = 1;
    }

    if(isDefined(zombie.var_69a981e6) && zombie.var_69a981e6) {
      if(isDefined(zombie.var_6a4ce3f7)) {
        player zm_score::add_to_player_score(zombie.var_6a4ce3f7, 1, "", zombie.var_12745932);
      } else {
        player zm_score::add_to_player_score(50, 1, "", zombie.var_12745932);
      }
    }

    player zm_score::player_add_points(str_event, mod, hit_location, zombie, team, death_weapon, undefined, zombie.var_12745932);
  }

  if(isDefined(level.hero_power_update)) {
    level thread[[level.hero_power_update]](player, zombie, str_event);
  }
}

zombie_ragdoll_then_explode(launchvector, attacker) {
  if(!isDefined(self)) {
    return;
  }

  self zombie_utility::zombie_eye_glow_stop();
  self clientfield::set("zombie_ragdoll_explode", 1);
  self notify(#"exploding");
  self notify(#"end_melee");
  self notify(#"death", attacker);
  self.dont_die_on_me = 1;
  self.exploding = 1;
  self.a.nodeath = 1;
  self.dont_throw_gib = 1;
  self startragdoll();
  self setplayercollision(0);
  self zombie_utility::reset_attack_spot();

  if(isDefined(launchvector)) {
    self launchragdoll(launchvector);
  }

  wait 2.1;

  if(isDefined(self)) {
    self ghost();
    self util::delay(0.25, undefined, &zm_utility::self_delete);
  }
}

zombie_death_animscript(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
  team = undefined;

  if(isDefined(self._race_team)) {
    team = self._race_team;
  }

  self zombie_utility::reset_attack_spot();

  if(self check_zombie_death_animscript_callbacks()) {
    return false;
  }

  if(isDefined(level.var_5250bbfe)) {
    self[[level.var_5250bbfe]]();
  }

  self.grenadeammo = 0;

  if(isDefined(self.nuked) && self.nuked) {
    self thread zm_powerups::function_b753385f(weapon);
  } else {
    level zombie_death_points(self.origin, self.damagemod, self.damagelocation, self.attacker, einflictor, self, team, weapon);
  }

  if(isDefined(self.attacker) && isai(self.attacker)) {
    self.attacker notify(#"killed", {
      #victim: self
    });
  }

  if((self.damagemod == "MOD_BURNED" || isDefined(self.var_b364c165) && self.var_b364c165) && self.archetype === #"zombie") {
    self thread flame_corpse_fx();
  }

  if(self.damagemod == "MOD_GRENADE" || self.damagemod == "MOD_GRENADE_SPLASH") {
    level notify(#"zombie_grenade_death", self.origin);
  }

  return false;
}

check_zombie_death_animscript_callbacks() {
  if(!isDefined(level.zombie_death_animscript_callbacks)) {
    return false;
  }

  for(i = 0; i < level.zombie_death_animscript_callbacks.size; i++) {
    if(self[[level.zombie_death_animscript_callbacks[i]]]()) {
      return true;
    }
  }

  return false;
}

register_zombie_death_animscript_callback(func) {
  if(!isDefined(level.zombie_death_animscript_callbacks)) {
    level.zombie_death_animscript_callbacks = [];
  }

  level.zombie_death_animscript_callbacks[level.zombie_death_animscript_callbacks.size] = func;
}

private flame_corpse_fx() {
  if(!isDefined(level.var_d39e8272)) {
    level.var_d39e8272 = 0;
  }

  if(level.var_d39e8272 > 8) {
    return;
  }

  if(isDefined(self.var_fa03f342)) {
    str_clientfield = self.var_fa03f342;
  } else {
    str_clientfield = "flame_corpse_fx";
  }

  self clientfield::set(str_clientfield, 1);
  s_result = self waittilltimeout(10, #"actor_corpse", #"deleted");

  if(isDefined(self)) {
    self clientfield::set(str_clientfield, 0);
  }

  if(s_result._notify == "actor_corpse") {
    if(isDefined(s_result.corpse)) {
      e_corpse = s_result.corpse;
      e_corpse thread function_2cc66();
      e_corpse clientfield::set(str_clientfield, 1);
      e_corpse waittilltimeout(randomfloatrange(1.5, 6), #"death");

      if(isDefined(e_corpse)) {
        e_corpse clientfield::set(str_clientfield, 0);
        e_corpse notify(#"hash_244b83097f062847");
      }
    }
  }
}

private function_2cc66() {
  level.var_d39e8272++;
  s_result = self waittill(#"death", #"hash_244b83097f062847");
  level.var_d39e8272--;
}

damage_on_fire(player, weapon) {
  self endon(#"death", #"stop_flame_damage");
  wait 2;

  while(isDefined(self.is_on_fire) && self.is_on_fire) {
    if(level.round_number < 6) {
      dmg = level.zombie_health * randomfloatrange(0.2, 0.3);
    } else if(level.round_number < 9) {
      dmg = level.zombie_health * randomfloatrange(0.15, 0.25);
    } else if(level.round_number < 11) {
      dmg = level.zombie_health * randomfloatrange(0.1, 0.2);
    } else {
      dmg = level.zombie_health * randomfloatrange(0.1, 0.15);
    }

    if(isalive(player)) {
      self dodamage(dmg, self.origin, player, player, undefined, "MOD_BURNED", 0, weapon);
    } else {
      self dodamage(dmg, self.origin);
    }

    wait randomfloatrange(1, 3);
  }
}

player_using_hi_score_weapon(player) {
  if(isplayer(player)) {
    weapon = player getcurrentweapon();
    return (weapon == level.weaponnone || weapon.issemiauto);
  }

  return false;
}

register_zombie_damage_callback(func) {
  assertmsg("<dev string:x126>");
}

  function zombie_flame_damage(mod, player, weapon) {
    if(mod == "MOD_BURNED") {
      if(!(isDefined(self.is_on_fire) && self.is_on_fire)) {
        self thread damage_on_fire(player, weapon);
      }

      do_flame_death = 1;
      ai = getaiteamarray(level.zombie_team);

      for(i = 0; i < ai.size; i++) {
        if(isDefined(ai[i].is_on_fire) && ai[i].is_on_fire) {
          if(distancesquared(ai[i].origin, self.origin) < 10000) {
            do_flame_death = 0;
            break;
          }
        }
      }

      if(do_flame_death) {
        self thread zombie_death::flame_death_fx();
      }

      return true;
    }

    return false;
  }

is_weapon_shotgun(weapon) {
  return weapon.weapclass == "spread";
}

zombie_explodes_intopieces(random_gibs) {
  if(isDefined(self.no_gib) && self.no_gib) {
    return;
  }

  if(isDefined(self) && isactor(self)) {
    if(!random_gibs || randomint(100) < 50) {
      gibserverutils::gibhead(self);
    }

    if(!random_gibs || randomint(100) < 50) {
      gibserverutils::gibleftarm(self);
    }

    if(!random_gibs || randomint(100) < 50) {
      gibserverutils::gibrightarm(self);
    }

    if(!random_gibs || randomint(100) < 50) {
      gibserverutils::giblegs(self);
    }
  }
}

zombie_death_event(zombie) {
  zombie.marked_for_recycle = 0;
  force_head_gib = 0;
  waitresult = zombie waittill(#"death");
  attacker = waitresult.attacker;
  time_of_death = gettime();

  if(isDefined(zombie)) {
    zombie stopsounds();
  }

  if(isDefined(zombie) && isDefined(zombie.marked_for_insta_upgraded_death)) {
    force_head_gib = 1;
  }

  if(isDefined(zombie) && !isDefined(zombie.damagehit_origin) && isDefined(attacker) && isalive(attacker) && !isvehicle(attacker)) {
    zombie.damagehit_origin = attacker getweaponmuzzlepoint();
  }

  if(isDefined(attacker) && isplayer(attacker) && attacker player_can_score_from_zombies()) {
    if(isDefined(zombie.script_parameters)) {
      attacker notify(#"zombie_death_params", {
        #params: zombie.script_parameters, 
        #var_3ef38c68: isDefined(zombie.completed_emerging_into_playable_area) && zombie.completed_emerging_into_playable_area
      });
    }

    if(isDefined(zombie.b_widows_wine_cocoon) && isDefined(zombie.e_widows_wine_player)) {
      attacker notify(#"widows_wine_kill", {
        #player: zombie.e_widows_wine_player
      });
    }

    if(isDefined(zombie) && isDefined(zombie.damagelocation)) {
      if(zombie zm_utility::is_headshot(zombie.damageweapon, zombie.damagelocation, zombie.damagemod)) {
        attacker.headshots++;
        attacker zm_stats::increment_client_stat("headshots");
        attacker stats::function_e24eec31(zombie.damageweapon, #"headshots", 1);
        attacker zm_stats::increment_player_stat("headshots");
        attacker zm_stats::function_7bc347f6("headshots");
        attacker zm_stats::function_f1a1191d("headshots");
        attacker zm_stats::function_2726a7c2("headshots");
        attacker zm_stats::function_3468f864("headshots");
        attacker zm_stats::increment_challenge_stat(#"zombie_hunter_kill_headshot");
        attacker zm_stats::forced_attachment("boas_headshots");
        attacker zm_stats::registerchand_grow_("headshots");
        attacker thread activecamo::function_896ac347(zombie.damageweapon, #"headshots", 1);
        attacker zm_camos::function_432cf6d(zombie.damageweapon);
      } else {
        attacker notify(#"zombie_death_no_headshot");
      }
    }

    if(isDefined(zombie) && isDefined(zombie.damagemod) && zombie.damagemod == "MOD_MELEE" && isDefined(zombie.damageweapon) && !zm_loadout::is_hero_weapon(zombie.damageweapon)) {
      attacker zm_stats::increment_client_stat("melee_kills");
      attacker zm_stats::increment_player_stat("melee_kills");
      attacker notify(#"melee_kill");
      attacker zm_stats::forced_attachment("boas_melee_kills");
      println("<dev string:x186>");
    }

    attacker demo::add_actor_bookmark_kill_time();
    attacker.kills++;
    attacker zm_stats::increment_client_stat("kills");
    attacker zm_stats::increment_player_stat("kills");
    attacker zm_stats::function_7bc347f6("kills");
    attacker zm_stats::function_3468f864("kills");
    attacker zm_stats::function_f1a1191d("kills");
    attacker zm_stats::function_2726a7c2("kills");
    attacker zm_stats::forced_attachment("boas_kills");
    attacker zm_stats::registerchand_grow_("kills");

    if(isDefined(zombie) && isDefined(zombie.damageweapon)) {
      attacker stats::function_e24eec31(zombie.damageweapon, #"kills", 1);
      attacker thread activecamo::function_896ac347(zombie.damageweapon, #"kills", 1);
      attacker zm_camos::function_7b29c2d2(zombie.damageweapon);
    }

    if(force_head_gib) {
      zombie zombie_utility::zombie_head_gib();
    }
  }

  if(!isDefined(zombie)) {
    return;
  }

  if(isplayer(attacker) && isDefined(attacker.n_health_on_kill)) {
    attacker.health += attacker.n_health_on_kill;

    if(attacker.health >= attacker.maxhealth) {
      attacker zm_utility::set_max_health(1);
    }
  }

  if(isDefined(zombie.nuked) && zombie.nuked) {
    foreach(player in level.activeplayers) {
      if(!isDefined(player)) {
        continue;
      }

      if(isDefined(player.n_health_on_kill)) {
        player.health += player.n_health_on_kill;

        if(player.health >= player.maxhealth) {
          player zm_utility::set_max_health(1);
        }
      }
    }
  }

  level.global_zombies_killed++;

  if(isDefined(zombie.marked_for_death) && !isDefined(zombie.nuked)) {
    level.zombie_trap_killed_count++;
  }

  zombie check_zombie_death_event_callbacks(attacker);
  zombie bgb::actor_death_override(attacker);

  if(!isDefined(zombie)) {
    return;
  }

  name = zombie.animname;

  if(isDefined(zombie.sndname)) {
    name = zombie.sndname;
  }

  bhtnactionstartevent(zombie, "death");
  self notify(#"bhtn_action_notify", {
    #action: "death"
  });
  zombie thread zombie_utility::zombie_eye_glow_stop();

  if(isactor(zombie)) {
    if(isDefined(zombie.damageweapon.dogibbing) && zombie.damageweapon.dogibbing) {
      zombie zombie_explodes_intopieces(0);
    } else if(isDefined(zombie.damageweapon.doannihilate) && zombie.damageweapon.doannihilate || is_weapon_shotgun(zombie.damageweapon) && zm_weapons::is_weapon_upgraded(zombie.damageweapon) || zm_loadout::is_placeable_mine(zombie.damageweapon) || zombie.damagemod === "MOD_GRENADE" || zombie.damagemod === "MOD_GRENADE_SPLASH" || zombie.damagemod === "MOD_EXPLOSIVE") {
      if(isDefined(zombie.damageweapon.doannihilate) && zombie.damageweapon.doannihilate || isDefined(zombie.damagehit_origin) && distancesquared(zombie.origin, zombie.damagehit_origin) < 180 * 180) {
        tag = "J_SpineLower";

        if(isDefined(zombie.isdog) && zombie.isdog) {
          tag = "tag_origin";
        }

        if(isDefined(zombie.var_b69c12bc) && zombie.var_b69c12bc && !(isDefined(zombie.is_on_fire) && zombie.is_on_fire) && !(isDefined(zombie.guts_explosion) && zombie.guts_explosion)) {
          zombie thread zombie_utility::zombie_gut_explosion();
        }
      }
    }

    if(zombie.damagemod === "MOD_GRENADE" || zombie.damagemod === "MOD_GRENADE_SPLASH") {
      if(isDefined(attacker) && isalive(attacker) && isplayer(attacker)) {
        attacker.grenade_multikill_count++;
      }
    }
  }

  if(!(isDefined(zombie.has_been_damaged_by_player) && zombie.has_been_damaged_by_player) && isDefined(zombie.marked_for_recycle) && zombie.marked_for_recycle) {
    level.zombie_total++;
    level.zombie_total_subtract++;
  } else if(isDefined(zombie.attacker) && isplayer(zombie.attacker)) {
    level.zombie_player_killed_count++;

    if(isDefined(zombie.sound_damage_player) && zombie.sound_damage_player == zombie.attacker) {
      zombie.attacker thread zm_audio::create_and_play_dialog(#"kill", #"damage");
    }

    zombie.attacker notify(#"zom_kill", {
      #zombie: zombie
    });
  } else if(zombie.ignoreall && !(isDefined(zombie.marked_for_death) && zombie.marked_for_death)) {
    level.zombies_timeout_spawn++;
  }

  level notify(#"zom_kill");
  level.total_zombies_killed++;
}

check_zombie_death_event_callbacks(attacker) {
  if(!isDefined(level.zombie_death_event_callbacks)) {
    return;
  }

  for(i = 0; i < level.zombie_death_event_callbacks.size; i++) {
    self[[level.zombie_death_event_callbacks[i]]](attacker);
  }
}

register_zombie_death_event_callback(func) {
  if(!isDefined(level.zombie_death_event_callbacks)) {
    level.zombie_death_event_callbacks = [];
  }

  level.zombie_death_event_callbacks[level.zombie_death_event_callbacks.size] = func;
}

deregister_zombie_death_event_callback(func) {
  if(isDefined(level.zombie_death_event_callbacks)) {
    arrayremovevalue(level.zombie_death_event_callbacks, func);
  }
}

attractors_generated_listener() {
  self endon(#"death", #"stop_find_flesh", #"path_timer_done");
  level endon(#"intermission");
  level waittill(#"attractor_positions_generated");
  self.zombie_path_timer = 0;
}

zombie_history(msg) {
  if(!isDefined(self.zombie_history) || 32 <= self.zombie_history.size) {
    self.zombie_history = [];
  }

  self.zombie_history[self.zombie_history.size] = msg;
}

  function filter_spawn_points(point, player, player_dir) {
    if(vectordot(point.origin - player.origin, player_dir) > 0) {
      return true;
    }

    return false;
  }

function_dce9f1a6(spots) {
  pixbeginevent(#"hash_1e53352b53c0ae61");
  players = getplayers();
  var_1cb510f7 = [];

  foreach(player in players) {
    var_1cb510f7[player getentitynumber()] = {
      #player: player, 
      #count: 0, 
      #valid: zombie_utility::is_player_valid(player, 1, 1), 
      #zone: player zm_utility::get_current_zone(1)
    };
  }

  zombies = getaiteamarray(level.zombie_team);
  zombies = array::remove_undefined(zombies);

  foreach(zombie in zombies) {
    if(!isDefined(zombie) || !isalive(zombie)) {
      continue;
    }

    if(isDefined(zombie.last_closest_player) && !isplayer(zombie.last_closest_player)) {
      continue;
    }

    if(isDefined(zombie.last_closest_player)) {
      var_7871921b = zombie.last_closest_player getentitynumber();

      if(!(isDefined(zombie.need_closest_player) && zombie.need_closest_player) && isDefined(var_1cb510f7[var_7871921b]) && isDefined(var_1cb510f7[var_7871921b].valid) && var_1cb510f7[var_7871921b].valid) {
        var_1cb510f7[var_7871921b].count++;
        continue;
      }
    }

    if(isDefined(zombie.completed_emerging_into_playable_area) && zombie.completed_emerging_into_playable_area) {
      zone_name = zombie zm_utility::get_current_zone();
    } else if(isDefined(zombie.spawn_point)) {
      zone_name = zombie.spawn_point.zone_name;
    }

    if(!isDefined(zone_name)) {
      continue;
    }

    foreach(info in var_1cb510f7) {
      if(!(isDefined(info.valid) && info.valid)) {
        continue;
      }

      if(!isDefined(info.zone)) {
        continue;
      }

      var_e6217dda = getarraykeys(info.zone.adjacent_zones);

      if(zone_name == info.zone.name || isinarray(var_e6217dda, hash(zone_name))) {
        info.count++;
      }
    }
  }

  pixendevent();
  waitframe(1);
  pixbeginevent(#"hash_2bc50c04549ba1c3");
  var_e48372c9 = 2147483647;

  foreach(info in var_1cb510f7) {
    if(info.valid && info.count < var_e48372c9) {
      var_e48372c9 = info.count;
      player_info = info;
    }
  }

  a_candidates = [];

  if(isDefined(player_info) && isDefined(player_info.player)) {
    v_player_dir = player_info.player zm_quick_spawning::function_c5ea0b0();

    if(lengthsquared(v_player_dir) > 0) {
      zones = zm_quick_spawning::function_f1ec5df(player_info.player, v_player_dir, 1);

      for(i = 0; i < spots.size; i++) {
        if(isDefined(spots[i].spawned_timestamp) && gettime() - spots[i].spawned_timestamp < 3000) {
          continue;
        }

        if(isDefined(player_info.zone) && spots[i].zone_name === player_info.zone.name) {
          if(!isDefined(a_candidates)) {
            a_candidates = [];
          } else if(!isarray(a_candidates)) {
            a_candidates = array(a_candidates);
          }

          a_candidates[a_candidates.size] = spots[i];
          continue;
        }

        var_6ed4ea9 = 0;

        foreach(zone in zones) {
          var_e6217dda = getarraykeys(zone.adjacent_zones);

          if(zone.name === spots[i].zone_name || isstring(spots[i].zone_name) && isinarray(var_e6217dda, hash(spots[i].zone_name))) {
            if(!isDefined(a_candidates)) {
              a_candidates = [];
            } else if(!isarray(a_candidates)) {
              a_candidates = array(a_candidates);
            }

            a_candidates[a_candidates.size] = spots[i];
            var_6ed4ea9 = 1;
            break;
          }
        }

        if(var_6ed4ea9) {
          continue;
        }

        if(vectordot(spots[i].origin - player_info.player.origin, v_player_dir) > 0) {
          if(!isDefined(a_candidates)) {
            a_candidates = [];
          } else if(!isarray(a_candidates)) {
            a_candidates = array(a_candidates);
          }

          a_candidates[a_candidates.size] = spots[i];
        }
      }
    }

    if(getdvarint(#"hash_72ad1fcf80c5738d", -1) > -1 && level.players[getdvarint(#"hash_72ad1fcf80c5738d", -1)] == player_info.player) {
      foreach(index, spot in a_candidates) {
        record3dtext(index, spot.origin, (0, 1, 0));
      }
    }

  }

  pixendevent();
  player = undefined;

  if(isDefined(player_info)) {
    player = player_info.player;
  }

  return {
    #spot: array::random(a_candidates), 
    #player: player
  };
}

do_zombie_spawn() {
  self endon(#"death");
  spots = [];

  if(isDefined(self._rise_spot)) {
    spot = self._rise_spot;
    self thread do_zombie_rise(spot);
    return;
  }

  if(isDefined(level.use_multiple_spawns) && level.use_multiple_spawns && isDefined(self.script_int)) {
    foreach(loc in level.zm_loc_types[#"zombie_location"]) {
      if(!(isDefined(level.spawner_int) && level.spawner_int == self.script_int) && !(isDefined(loc.script_int) || isDefined(level.zones[loc.zone_name].script_int))) {
        continue;
      }

      if(isDefined(loc.script_int) && loc.script_int != self.script_int) {
        continue;
      } else if(isDefined(level.zones[loc.zone_name].script_int) && level.zones[loc.zone_name].script_int != self.script_int) {
        continue;
      }

      spots[spots.size] = loc;
    }
  } else {
    spots = level.zm_loc_types[#"zombie_location"];
  }

  if(getdvarint(#"scr_zombie_spawn_in_view", 0)) {
    player = getplayers()[0];
    spots = [];
    max_dot = 0;
    look_loc = undefined;

    foreach(loc in level.zm_loc_types[#"zombie_location"]) {
      player_vec = vectornormalize(anglesToForward(player getplayerangles()));
      player_vec_2d = (player_vec[0], player_vec[1], 0);
      player_spawn = vectornormalize(loc.origin - player.origin);
      player_spawn_2d = (player_spawn[0], player_spawn[1], 0);
      dot = vectordot(player_vec_2d, player_spawn_2d);
      dist = distance(loc.origin, player.origin);

      if(dot > 0.707 && dist <= getdvarint(#"scr_zombie_spawn_in_view_dist", 0)) {
        if(dot > max_dot) {
          look_loc = loc;
          max_dot = dot;
        }

        debugstar(loc.origin, 1000, (1, 1, 1));

      }
    }

    if(isDefined(look_loc)) {
      spots[spots.size] = look_loc;

      debugstar(look_loc.origin, 1000, (0, 1, 0));

    }

    if(spots.size <= 0) {
      spots[spots.size] = level.zm_loc_types[#"zombie_location"][0];
      iprintln("no spawner in view");
    }
  }

  if(spots.size == 0) {
    if(!level util::function_88c74107() && !level.gameended) {
      assertmsg("<dev string:x19c>");
    }

    spots = struct::get_array("spawn_location", "script_noteworthy");
  }

  spot = function_20e7d186(spots);
  spot.spawned_timestamp = gettime();
  self.spawn_point = spot;

  if(getdvarint(#"zombiemode_debug_zones", 0)) {
    level.zones[spot.zone_name].total_spawn_count++;
    level.zones[spot.zone_name].round_spawn_count++;
    self.zone_spawned_from = spot.zone_name;
    self thread draw_zone_spawned_from();
  }

  if(isDefined(level.toggle_show_spawn_locations) && level.toggle_show_spawn_locations) {
    debugstar(spot.origin, getdvarint(#"scr_spawner_location_time", 0), (0, 1, 0));
    host_player = util::gethostplayer();
    distance = distance(spot.origin, host_player.origin);
    iprintln("<dev string:x229>" + distance / 12 + "<dev string:x240>");
  }

    if(isDefined(spot.var_c078a32) && getdvarint(#"hash_24e49958fe736182", 0) && (isDefined(self.var_a9b2d989) && self.var_a9b2d989 || isDefined(level.var_d4a79133) && level.var_d4a79133 > 0) && isDefined(level.var_322d0819)) {
      self thread[[level.var_322d0819]](spot, spot.var_c078a32);
      return;
    }

  if(isDefined(level.move_spawn_func)) {
    self thread[[level.move_spawn_func]](spot);
  }
}

function_20e7d186(var_493c4730) {
  assert(var_493c4730.size > 0, "<dev string:x247>");

  if(getdvarint(#"hash_32f24948d4a09f0e", 1)) {
    spawn_info = function_dce9f1a6(var_493c4730);
    var_cf6e6a44 = spawn_info.spot;

    if(isDefined(var_cf6e6a44)) {
      var_cf6e6a44.var_c078a32 = spawn_info.player;
    }
  } else if(isDefined(level.zm_custom_spawn_location_selection)) {
    var_cf6e6a44 = [[level.zm_custom_spawn_location_selection]](var_493c4730);
  }

  if(!isDefined(var_cf6e6a44)) {
    var_cf6e6a44 = function_65439499(array::randomize(var_493c4730));

    if(!isDefined(var_cf6e6a44)) {
      var_cf6e6a44 = array::random(var_493c4730);
    }
  }

  return var_cf6e6a44;
}

function_65439499(spawn_points, var_12af83a0 = 5000) {
  foreach(point in spawn_points) {
    if(isDefined(point.spawned_timestamp) && gettime() - point.spawned_timestamp > var_12af83a0) {
      return point;
    }
  }

  return undefined;
}

draw_zone_spawned_from() {
  self endon(#"death");

  while(true) {
    print3d(self.origin + (0, 0, 64), self.zone_spawned_from, (1, 1, 1));
    waitframe(1);
  }
}

  function do_zombie_rise(spot) {
    self endon(#"death");
    self.in_the_ground = 1;

    if(isDefined(self.anchor)) {
      self.anchor delete();
    }

    self.anchor = spawn("script_origin", self.origin);
    self.anchor.angles = self.angles;
    self linkto(self.anchor);
    self.anchor thread zm_utility::anchor_delete_failsafe(self);

    if(!isDefined(spot.angles)) {
      spot.angles = (0, 0, 0);
    }

    anim_org = spot.origin;
    anim_ang = spot.angles;
    anim_org += (0, 0, 0);
    self ghost();
    self.anchor moveto(anim_org, 0.05);
    self.anchor waittill(#"movedone");
    target_org = zombie_utility::get_desired_origin();

    if(isDefined(target_org)) {
      anim_ang = vectortoangles(target_org - self.origin);
      self.anchor rotateto((0, anim_ang[1], 0), 0.05);
      self.anchor waittill(#"rotatedone");
    }

    self unlink();

    if(isDefined(self.anchor)) {
      self.anchor delete();
    }

    self thread zombie_utility::hide_pop();
    level thread zombie_utility::zombie_rise_death(self, spot);
    spot thread zombie_rise_fx(self);
    substate = 0;

    if(self.zombie_move_speed == "walk") {
      substate = randomint(2);
    } else if(self.zombie_move_speed == "run") {
      substate = 2;
    } else if(self.zombie_move_speed == "sprint") {
      substate = 3;
    }

    self orientmode("face default");
    custom_riseanim = isDefined(self.custom_riseanim) ? self.custom_riseanim : level.custom_riseanim;

    if(isDefined(custom_riseanim)) {
      self animscripted("rise_anim", self.origin, spot.angles, custom_riseanim, "normal");
    } else if(isDefined(level.var_6129f460)) {
      self[[level.var_6129f460]](spot);
    } else {
      self animscripted("rise_anim", self.origin, spot.angles, "ai_zombie_base_traverse_ground_climbout_fast", "normal");
    }

    self zombie_shared::donotetracks("rise_anim", &zombie_utility::handle_rise_notetracks, spot);
    self notify(#"rise_anim_finished");
    spot notify(#"stop_zombie_rise_fx");
    self.in_the_ground = 0;
    self notify(#"risen", {
      #find_flesh_struct_string: spot.script_string
    });
  }

zombie_rise_fx(zombie) {
  if(!(isDefined(level.riser_fx_on_client) && level.riser_fx_on_client)) {
    self thread zombie_rise_dust_fx(zombie);
    self thread zombie_rise_burst_fx(zombie);
  } else {
    self thread zombie_rise_burst_fx(zombie);
  }

  zombie endon(#"death");
  self endon(#"stop_zombie_rise_fx");
  wait 1;

  if(zombie.zombie_move_speed != "sprint") {
    wait 1;
  }
}

zombie_rise_burst_fx(zombie) {
  self endon(#"stop_zombie_rise_fx", #"rise_anim_finished");

  if(isDefined(self.script_parameters) && self.script_parameters == "in_water" && !(isDefined(level._no_water_risers) && level._no_water_risers)) {
    zombie clientfield::set("zombie_riser_fx_water", 1);
    return;
  }

  if(isDefined(self.script_parameters) && self.script_parameters == "in_foliage" && isDefined(level._foliage_risers) && level._foliage_risers) {
    zombie clientfield::set("zombie_riser_fx_foliage", 1);
    return;
  }

  if(isDefined(self.script_parameters) && self.script_parameters == "in_snow") {
    zombie clientfield::set("zombie_riser_fx", 1);
    return;
  }

  if(isDefined(zombie.zone_name) && isDefined(level.zones[zombie.zone_name])) {
    low_g_zones = getEntArray(zombie.zone_name, "targetname");

    if(low_g_zones.size && isDefined(low_g_zones[0].script_string) && low_g_zones[0].script_string == "lowgravity") {
      zombie clientfield::set("zombie_riser_fx_lowg", 1);
    } else {
      zombie clientfield::set("zombie_riser_fx", 1);
    }

    return;
  }

  zombie clientfield::set("zombie_riser_fx", 1);
}

zombie_rise_dust_fx(ai_zombie) {
  ai_zombie endon(#"death");
  wait 2;

  if(!isDefined(self.script_string)) {
    str_fx = "rise_dust";
  } else {
    switch (self.script_string) {
      case #"in_water":
        str_fx = "rise_dust_water";
        break;
      case #"in_snow":
        str_fx = "rise_dust_snow";
        break;
      case #"in_foliage":
        str_fx = "rise_dust_foliage";
        break;
      default:
        str_fx = "rise_dust";
        break;
    }
  }

  t = 0;

  while(t < 5.5) {
    playFXOnTag(level._effect[str_fx], ai_zombie, "J_SpineUpper");
    wait 0.3;
    t += 0.3;
  }
}

zombie_tesla_head_gib() {
  self endon(#"death");

  if(self.animname === "quad_zombie") {
    return;
  }

  if(randomint(100) < zombie_utility::get_zombie_var(#"tesla_head_gib_chance")) {
    wait randomfloatrange(0.53, 1);
    self zombie_utility::zombie_head_gib();
    return;
  }

  zm_net::network_safe_play_fx_on_tag("tesla_death_fx", 2, level._effect[#"tesla_shock_eyes"], self, "J_Eyeball_LE");
}

zombie_complete_emerging_into_playable_area() {
  self.should_turn = 0;
  self.completed_emerging_into_playable_area = 1;
  self.no_powerups = 0;
  self notify(#"completed_emerging_into_playable_area");

  if(isDefined(self.backedupgoal)) {
    self setgoal(self.backedupgoal);
    self.backedupgoal = undefined;
  } else {
    self.var_93a62fe = zm_utility::get_closest_valid_player(self.origin, self.ignore_player, 1);

    if(isDefined(self.var_93a62fe) && (!ai::has_behavior_attribute("scripted_mode") || ai::get_behavior_attribute("scripted_mode") !== 1)) {
      if(isDefined(self.var_93a62fe.last_valid_position)) {
        self setgoal(self.var_93a62fe.last_valid_position);
      } else {
        goalpos = getclosestpointonnavmesh(self.var_93a62fe.origin, 100, self getpathfindingradius());

        if(!isDefined(goalpos)) {
          goalpos = self.origin;
        }

        self setgoal(goalpos);
      }
    } else {
      self setgoal(self.origin);
    }
  }

  self thread function_1446cbd3();
  self thread zm_utility::update_zone_name();
}

function_1446cbd3() {
  self endon(#"death");
  self collidewithactors(1);
  wait 1.5;
  self setfreecameralockonallowed(1);
}

function_45bb11e4(spot) {
  self endoncallback(&function_fe3cb19a, #"death");
  self.var_5535a47d = 1;
  self function_fe3cb19a();
  self.mdl_anchor = util::spawn_model("tag_origin", self.origin, self.angles);
  self ghost();

  if(!isDefined(spot.angles)) {
    spot.angles = (0, 0, 0);
  }

  self.mdl_anchor moveto(spot.origin, 0.05);
  self.mdl_anchor rotateto(spot.angles, 0.05);
  self.mdl_anchor waittill(#"movedone", #"death");
  wait 0.05;
  self.create_eyes = 1;
  self show();

  if(!isDefined(self.var_9ed3cc11)) {
    self.var_9ed3cc11 = self function_e827fc0e();
  }

  self pushplayer(1);
  e_align = isDefined(self.mdl_anchor) ? self.mdl_anchor : spot;

  if(isDefined(self.has_legs) && !self.has_legs || isDefined(self.missing_legs) && self.missing_legs) {
    if(isinarray(scene::get_all_shot_names(spot.scriptbundlename), "crawler")) {
      e_align scene::play(spot.scriptbundlename, "crawler", self);
    } else {
      e_align scene::play(spot.scriptbundlename, self);
    }
  } else if(isinarray(scene::get_all_shot_names(spot.scriptbundlename), "default")) {
    e_align scene::play(spot.scriptbundlename, "default", self);
  } else {
    e_align scene::play(spot.scriptbundlename, self);
  }

  if(isDefined(self.var_9ed3cc11)) {
    self pushplayer(self.var_9ed3cc11);
    self.var_9ed3cc11 = undefined;
  }

  self.var_5535a47d = 0;
  self thread function_2d97cae1();
  self notify(#"risen", spot.script_string);
  self zombie_complete_emerging_into_playable_area();
}

function_2d97cae1() {
  waitresult = self waittilltimeout(1, #"death");
  self function_fe3cb19a();
}

function_fe3cb19a(notifyhash) {
  if(isDefined(self.mdl_anchor)) {
    self.mdl_anchor delete();
    self.mdl_anchor = undefined;
  }
}