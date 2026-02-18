/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\zm_platinum_pap_quest.gsc
***********************************************/

#using script_5b190e6124417f5a;
#using script_744259b349d834c7;
#using scripts\core_common\ai\archetype_damage_utility;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm\zm_platinum;
#using scripts\zm_common\ai\zm_ai_utility;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_cleanup_mgr;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_sq;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#namespace zm_platinum_pap_quest;

function init() {
  clientfield::register("scriptmover", "" + # "pap_machine_fx", 1, getminbitcountfornum(3), "int");
  clientfield::register("scriptmover", "" + # "hash_44cce9f2e2fd1c96", 1, getminbitcountfornum(2), "int");
  clientfield::register("world", "" + # "pap_portal_fx", 1, 1, "int");
  clientfield::register("world", "" + # "pap_quest_beam_start", 1, getminbitcountfornum(10), "int");
  clientfield::register("world", "" + # "hash_3fb8ca8c017ba7ac", 1, getminbitcountfornum(10), "int");
  level thread function_cdc6589b();
  level thread function_3c35fb99();
  level thread function_9d367ce1();
  level thread pap_machine_fx();
  level thread function_bf1953a();
  level thread function_f8cbb582();
  level thread function_ca27bef9();
  level thread function_af722d1c();

  level thread function_37597f29();
}

function function_cdc6589b() {
  level endon(#"end_game");
  s_interact = struct::get("s_pap_quest_start_loc");

  if(!isDefined(s_interact)) {
    return;
  }

  var_b015a980 = s_interact zm_unitrigger::create(&function_fadb1cd3, 96, &function_bc741cdd);
  level flag::wait_till_any([# "hash_434bc775e67b7233", #"hash_20afa38b1f1c339e"]);
  zm_unitrigger::unregister_unitrigger(var_b015a980.stub);
}

function function_fadb1cd3(player) {
  if(level flag::get_any([# "hash_7b5643f5ecc16c8f", #"hash_434bc775e67b7233", #"hash_20afa38b1f1c339e"])) {
    self sethintstring("");
    return 0;
  }

  if(isPlayer(player)) {
    self sethintstringforplayer(player, #"hash_117e2ba880722571");
    return 1;
  }
}

function function_bc741cdd() {
  level endon(#"end_game", #"death", #"hash_20afa38b1f1c339e");

  while(true) {
    waitresult = self waittill(#"trigger");
    activator = waitresult.activator;

    if(isPlayer(activator) && !level flag::get(#"hash_7b5643f5ecc16c8f")) {
      s_pap_machine = struct::get("pap_machine_pos");
      playrumbleonposition(#"hash_37961ea533a765a2", s_pap_machine.origin);
      earthquake(0.25, 10, s_pap_machine.origin, 1200);
      level flag::set(#"hash_434bc775e67b7233");
    }
  }
}

function function_3c35fb99() {
  level endon(#"end_game");
  level flag::wait_till_any([# "hash_434bc775e67b7233", #"hash_20afa38b1f1c339e", #"hash_1040acad653a881f"]);
  level.no_powerups = 1;
  level flag::clear("spawn_zombies");
  level flag::clear("zombie_drop_powerups");
  level flag::clear(#"hash_21921ed511559aa3");
  level flag::set(#"pause_round_timeout");
  level flag::set("hold_round_end");
  level flag::clear(#"hash_25372b8b89ab540c");
  level flag::wait_till_any([# "hash_20afa38b1f1c339e", #"hash_1040acad653a881f"]);
  level flag::set("spawn_zombies");
  level flag::clear(#"pause_round_timeout");
  level flag::clear("hold_round_end");
  level flag::wait_till(#"hash_20afa38b1f1c339e");
  level.no_powerups = undefined;
  level flag::set("zombie_drop_powerups");
  level flag::set(#"hash_21921ed511559aa3");
  level flag::set(#"hash_25372b8b89ab540c");
}

function pap_machine_fx() {
  level endon(#"end_game");
  s_pap_machine_fx = struct::get("s_pap_machine_fx");
  level flag::wait_till("start_zombie_round_logic");
  var_748011b3 = util::spawn_model("tag_origin", s_pap_machine_fx.origin, s_pap_machine_fx.angles);
  var_748011b3 clientfield::set("" + # "pap_machine_fx", 1);
  level flag::wait_till_any([# "hash_434bc775e67b7233", #"hash_20afa38b1f1c339e"]);
  var_748011b3 clientfield::set("" + # "pap_machine_fx", 2);
  level flag::wait_till(#"hash_20afa38b1f1c339e");
  var_748011b3 clientfield::set("" + # "pap_machine_fx", 3);
  util::wait_network_frame();
  var_748011b3 clientfield::set("" + # "pap_machine_fx", 0);
}

function function_bf1953a() {
  level endon(#"end_game", #"hash_20afa38b1f1c339e");
  level flag::wait_till("start_zombie_round_logic");
  n_count = 0;
  var_922a1dba = 0;
  var_eb801f6d = struct::get_script_bundle_instances("scene", ["scene_zombie_pap_float", "targetname"]);
  var_eb801f6d = array::sort_by_script_int(var_eb801f6d, 1);

  foreach(var_8a36246d in var_eb801f6d) {
    var_8a36246d thread scene::play("sleep");
    mdl_zombie = var_8a36246d.scene_ents[# "actor 1"];

    if(isDefined(mdl_zombie)) {
      mdl_zombie clientfield::set("" + # "hash_44cce9f2e2fd1c96", 1);
    }

    wait randomfloatrange(0.25, 0.5);
  }

  level flag::wait_till(#"hash_6987b7a102755157");

  foreach(var_8a36246d in var_eb801f6d) {
    var_8a36246d thread scene::play("awake");
    var_922a1dba++;
    n_count++;
    level clientfield::set("" + # "pap_quest_beam_start", n_count);

    if(n_count == 9) {
      wait 0.15;
      level clientfield::set("" + # "pap_quest_beam_start", n_count + 1);
    }

    mdl_zombie = var_8a36246d.scene_ents[# "actor 1"];

    if(isDefined(mdl_zombie)) {
      mdl_zombie clientfield::set("" + # "hash_44cce9f2e2fd1c96", 2);
    }

    if(var_922a1dba == 2) {
      var_922a1dba = 0;
      wait 1;
    }

    wait 0.15;
  }

  wait 0.25;
  level clientfield::set("" + # "pap_quest_beam_start", 0);
  var_67a6506b = struct::get_script_bundle_instances("scene", ["scene_zombie_pap_land", "targetname"]);
  var_67a6506b = array::sort_by_script_int(var_67a6506b, 1);
  n_count = 0;
  level function_22ce4251();

  foreach(var_8a36246d in var_67a6506b) {
    level scene::add_scene_func(var_8a36246d.scriptbundlename, &function_96aac543, "play");
    level scene::add_scene_func(var_8a36246d.scriptbundlename, &function_bcc7802, "done");
    var_8a36246d thread scene::play("land");
    waitframe(1);
    var_eb801f6d[n_count] thread scene::stop(1);
    n_count++;

    if(n_count == 1 || n_count == 2) {
      level clientfield::set("" + # "hash_3fb8ca8c017ba7ac", n_count);
      util::wait_network_frame();
      wait 0.25;
    }

    level clientfield::set("" + # "hash_3fb8ca8c017ba7ac", n_count + 2);
    util::wait_network_frame();
    wait randomfloatrange(0.15, 0.25);
  }

  level flag::set("flag_pap_quest_start_adds");
  level flag::set(#"hash_1040acad653a881f");
}

function function_22ce4251() {
  level endon(#"end_game", #"hash_20afa38b1f1c339e");
  n_max_zombies = zombie_utility::get_zombie_var(#"zombie_max_ai");

  while(true) {
    if(getaiteamarray(level.zombie_team).size < n_max_zombies - 11) {
      return;
    }

    function_904d21fd();
    util::wait_network_frame();
  }
}

function function_904d21fd() {
  actor_array = getaiarchetypearray(#"zombie");
  max_dist = 0;
  var_202d087b = undefined;

  foreach(i, actor in actor_array) {
    if(is_true(actor.var_921627ad) || is_true(actor.var_a950813d) || is_true(actor.var_4df707f6)) {
      actor_array[i] = -1;
    }
  }

  arrayremovevalue(actor_array, -1);
  players = getplayers();

  foreach(player in players) {
    if(player.sessionstate === "spectator") {
      continue;
    }

    while(true) {
      if(!isDefined(player)) {
        break;
      }

      var_3817a6b3 = arraygetfarthest(player.origin, actor_array);

      if(!isDefined(var_3817a6b3)) {
        return;
      }

      if(isalive(var_3817a6b3)) {
        break;
      }

      arrayremovevalue(actor_array, var_3817a6b3);

      if(!actor_array.size) {
        return;
      }

      waitframe(1);
    }

    if(isDefined(var_3817a6b3)) {
      closest_player = arraygetclosest(var_3817a6b3.origin, getplayers());
    }

    if(isDefined(closest_player) && isDefined(var_3817a6b3)) {
      dist = distancesquared(closest_player.origin, var_3817a6b3.origin);

      if(max_dist < dist) {
        max_dist = dist;
        var_202d087b = var_3817a6b3;
      }
    }
  }

  if(!isDefined(var_202d087b)) {
    var_202d087b = array::random(actor_array);
  }

  if(isDefined(var_202d087b)) {
    var_202d087b zm_cleanup::cleanup_zombie(1);

    if(isDefined(var_202d087b)) {
      gibserverutils::annihilate(var_202d087b);
    }
  }
}

function function_96aac543(ents) {
  ai_zombie = ents[# "actor 1"];

  if(isalive(level.var_1ceed659) && isalive(ai_zombie)) {
    namespace_19c99142::function_e8a2d39a(level.var_1ceed659, ai_zombie);
  }
}

function function_bcc7802(ents) {
  ai_zombie = ents[# "actor 1"];

  if(!isalive(ai_zombie)) {
    return;
  }

  ai_zombie endon(#"death");
  ai_zombie.maxhealth = ai_zombie zm_ai_utility::function_b5fe98(level.round_number);
  ai_zombie.health = ai_zombie.maxhealth;
  ai_zombie.ignore_round_spawn_failsafe = 1;
  ai_zombie.ignore_enemy_count = 1;
  ai_zombie.no_powerups = 1;
  ai_zombie.script_string = "find_flesh";
  ai_zombie pathmode("move allowed");
  ai_zombie.ai_state = "zombie_think";
  ai_zombie.zombie_think_done = 1;
  ai_zombie thread function_6a8117ab();
}

function function_b1db8691() {
  level endon(#"end_game", #"hash_20afa38b1f1c339e");
  level flag::wait_till(#"flag_pap_quest_start_adds");
  wait 3;
  n_players = zm_utility::get_number_of_valid_players();
  var_95421a26 = 0;
  var_509132fd = arraycombine(struct::get_array("zone_no_mans_land_1_spawns"), struct::get_array("zone_no_mans_land_2_spawns"));
  var_509132fd = array::filter(var_509132fd, 0, &function_e01b301e);

  switch (n_players) {
    case 1:
    default:
      n_max_active_ai = 5;
      var_a77909d4 = 20;
      break;
    case 2:
      n_max_active_ai = 10;
      var_a77909d4 = 30;
      break;
    case 3:
      n_max_active_ai = 15;
      var_a77909d4 = 45;
      break;
    case 4:
      n_max_active_ai = 20;
      var_a77909d4 = 60;
      break;
  }

  while(var_95421a26 < var_a77909d4) {
    while(getaiarray("pap_quest_ai", "targetname").size >= n_max_active_ai) {
      util::wait_network_frame();
    }

    ai_zombie = undefined;
    spawner = zm_platinum::function_ddc13fd6();

    while(!isDefined(ai_zombie)) {
      ai_zombie = zombie_utility::spawn_zombie(spawner, "pap_quest_ai", array::random(var_509132fd), level.round_number);
      waitframe(1);
    }

    ai_zombie.maxhealth = ai_zombie zm_ai_utility::function_b5fe98(level.round_number);
    ai_zombie.health = ai_zombie.maxhealth;
    ai_zombie.no_powerups = 1;
    ai_zombie.script_string = "find_flesh";
    ai_zombie thread function_6a8117ab();
    var_95421a26++;
    wait randomfloatrange(5, 8);
  }
}

function function_e01b301e(s_loc) {
  if(s_loc.script_noteworthy === "riser_location") {
    return true;
  }

  return false;
}

function function_6a8117ab() {
  self endon(#"death");
  e_trigger = getent("pap_quest_clear_enemy_trigger", "targetname");
  a_players = array::randomize(function_a1ef346b());

  foreach(player in a_players) {
    if(player istouching(e_trigger)) {
      self.favoriteenemy = player;
      return;
    }
  }

  e_player = arraygetclosest(e_trigger.origin, a_players);
  self.favoriteenemy = e_player;
}

function function_8ff08856() {
  level endon(#"end_game", #"hash_20afa38b1f1c339e");
  wait randomintrange(8, 16);
  var_f490e876 = undefined;
  s_spawn_loc = struct::get("s_pap_quest_mechz_spawn");
  var_8a9b34b3 = getent("spawner_bo5_mechz_sr", "targetname");
  var_8a9b34b3.script_forcespawn = 1;

  while(!isDefined(var_f490e876)) {
    var_f490e876 = zombie_utility::spawn_zombie(var_8a9b34b3, "pap_quest_ai", s_spawn_loc);
    waitframe(1);
  }

  var_f490e876.var_126d7bef = 1;
  var_f490e876.ignore_round_spawn_failsafe = 1;
  var_f490e876.b_ignore_cleanup = 1;
  var_f490e876.ignore_enemy_count = 1;
  var_f490e876.no_powerups = 1;
}

function function_f8cbb582() {
  level endon(#"end_game", #"hash_20afa38b1f1c339e");
  level flag::wait_till(#"hash_434bc775e67b7233");
  level thread zm_audio::function_b36aeaf6("papevent");

  foreach(player in getplayers()) {
    player clientfield::set_to_player("" + # "music_underscore", 2);
  }

  level clientfield::set("" + # "pap_portal_fx", 1);
  level.var_7ff7eaf9 = [];
  a_s_loc = array::sort_by_script_int(struct::get_array("s_pap_quest_boss_spawn"), 1);
  var_5e5e4c63 = getent("spawner_bo5_soa", "targetname");
  var_5e5e4c63.script_forcespawn = 1;
  level.var_1ceed659 = undefined;
  wait 0.5;
  var_84a3b2fc = 0;

  switch (getplayers().size) {
    case 1:
    default:
      n_max_active_ai = 2;
      var_37cdfca9 = 1;
      break;
    case 2:
      n_max_active_ai = 3;
      var_37cdfca9 = 1;
      break;
    case 3:
      n_max_active_ai = 4;
      var_37cdfca9 = 2;
      break;
    case 4:
      n_max_active_ai = 4;
      var_37cdfca9 = 2;
      break;
  }

  if(!isDefined(level.var_1ceed659)) {
    level scene::add_scene_func(#"hash_23646276d8565971", &function_5fc5de3e, "play");
    level scene::add_scene_func(#"hash_23646276d8565971", &function_ffe0f421, "done");
    level scene::play(#"hash_23646276d8565971");
    level flag::set(#"hash_6987b7a102755157");
    var_84a3b2fc++;
    wait randomfloatrange(5, 6);
  }

  level scene::remove_scene_func(#"hash_23646276d8565971", &function_5fc5de3e, "play");
  level scene::remove_scene_func(#"hash_23646276d8565971", &function_ffe0f421, "done");

  while(var_84a3b2fc < var_37cdfca9) {
    while(getaiarray("pap_quest_ai_boss", "targetname").size >= n_max_active_ai) {
      util::wait_network_frame();
    }

    ai_boss = undefined;

    while(!isDefined(ai_boss)) {
      ai_boss = zombie_utility::spawn_zombie(var_5e5e4c63, "pap_quest_ai_boss", a_s_loc[0], level.round_number);
      waitframe(1);
    }

    ai_boss thread function_4df61aed(1);
    var_84a3b2fc++;

    if(var_84a3b2fc == var_37cdfca9) {
      break;
    }

    wait randomfloatrange(5, 6);
  }

  array::wait_till(level.var_7ff7eaf9, "death");
  level clientfield::set("" + # "pap_portal_fx", 0);
  level thread zm_audio::function_2354b945("papevent");

  foreach(player in getplayers()) {
    player clientfield::set_to_player("" + # "music_underscore", 3);
  }

  namespace_b574e135::function_8d857888(1);
  level flag::set(#"hash_20afa38b1f1c339e");
}

function function_4df61aed(b_teleport) {
  self notify(#"hash_ccfc536e52dd075");
  a_s_loc = array::sort_by_script_int(struct::get_array("s_pap_quest_boss_spawn"), 1);

  if(is_true(b_teleport)) {
    self forceteleport(a_s_loc[0].origin, a_s_loc[0].angles);
  }

  self clientfield::set("" + # "hash_3e4641a9ea00d061", 0);
  self val::reset(#"hash_2892ab448df38143", "allowdeath");
  self.var_306ee014 = undefined;
  aiutility::removeaioverridedamagecallback(self, &function_5d4aa7f8);

  if(getplayers().size < 3) {
    var_98a21198 = # "hash_4cc53090ca79c51a";
  } else {
    var_98a21198 = # "hash_6cd6ef080cea716b";
  }

  zm_sq::objective_set(#"hash_1c556f45aa40ebef", self, undefined, var_98a21198, undefined, 96);
  self.maxhealth = self zm_ai_utility::function_b5fe98(level.round_number);
  self.var_2e38a54d = 100;
  self.health = self.maxhealth;
  self.var_126d7bef = 1;
  self.ignore_round_spawn_failsafe = 1;
  self.ignore_enemy_count = 1;
  self.no_powerups = 1;

  if(!isDefined(level.var_d1e5ed10)) {
    level.var_d1e5ed10 = 0;
  }

  var_1c583a11 = level.var_d1e5ed10 % 4 + 1;

  if(!isDefined(a_s_loc[var_1c583a11])) {
    var_1c583a11 = 1;
  }

  self namespace_19c99142::function_fc7356e3(self, a_s_loc[var_1c583a11].origin);
  level.var_d1e5ed10++;

  if(!isDefined(level.var_7ff7eaf9)) {
    level.var_7ff7eaf9 = [];
  } else if(!isarray(level.var_7ff7eaf9)) {
    level.var_7ff7eaf9 = array(level.var_7ff7eaf9);
  }

  level.var_7ff7eaf9[level.var_7ff7eaf9.size] = self;
}

function function_5fc5de3e(ents) {
  var_e8cb6c46 = ents[# "actor 1"];

  if(!isalive(var_e8cb6c46)) {
    return;
  }

  level.var_1ceed659 = var_e8cb6c46;
  var_e8cb6c46 clientfield::set("" + # "hash_3e4641a9ea00d061", 1);
  var_e8cb6c46 val::set(#"hash_2892ab448df38143", "allowdeath", 0);
  var_e8cb6c46.var_306ee014 = &function_1a49126a;
  aiutility::addaioverridedamagecallback(var_e8cb6c46, &function_5d4aa7f8);
}

function function_1a49126a(entity) {
  return true;
}

function function_5d4aa7f8(inflictor, attacker, damage, dflags, mod, weapon, var_fd90b0bb, point, dir, hitloc, offsettime, boneindex, modelindex) {
  return false;
}

function function_ffe0f421(ents) {
  var_e8cb6c46 = ents[# "actor 1"];

  if(!isalive(var_e8cb6c46)) {
    return;
  }

  var_e8cb6c46 thread function_4df61aed();
}

function function_ca27bef9() {
  level endon(#"end_game");
  level flag::wait_till(#"hash_20afa38b1f1c339e");
  wait 3;
  level zm_utility::function_9ad5aeb1(1, 1, 0, 0);
}

function function_9d367ce1() {
  level endon(#"end_game");
  level flag::set(#"disable_weapon_machine");
  level flag::wait_till(#"hash_20afa38b1f1c339e");
  function_d18f9441();
  level flag::clear(#"disable_weapon_machine");
}

function private function_d18f9441() {
  var_63a065c3 = struct::get("pap_machine_pos", "targetname");
  a_players = function_a1ef346b();

  foreach(player in a_players) {
    if(distancesquared(var_63a065c3.origin, player.origin) < sqr(500)) {
      player function_bc82f900(#"hash_4daa78d98dde0b61");
    }
  }
}

function function_79e92fb0(zombie_spawner, spawner_int) {
  if(zombie_spawner.script_int === spawner_int) {
    return true;
  }

  return false;
}

function function_af722d1c() {
  level endon(#"end_game");
  var_8b3ab8b4 = struct::get_array("pap_rappel_breadcrumb");
  s_pap_machine = struct::get("pap_machine_pos");
  level flag::wait_till_any(["power_on", #"hash_549c3c7bafb05150", #"hash_434bc775e67b7233", #"hash_20afa38b1f1c339e"]);
  wait 3.5;
  zm_sq::objective_set(#"hash_5c597e863c8de1c8", var_8b3ab8b4, undefined, #"hash_466bc6bf903c0d79", undefined, 96);
  level flag::wait_till_any([# "hash_549c3c7bafb05150", #"hash_434bc775e67b7233", #"hash_20afa38b1f1c339e"]);
  zm_sq::objective_complete(#"hash_5c597e863c8de1c8");
  zm_sq::objective_set(#"hash_512230df2dcdd311", s_pap_machine.origin + (0, 0, 40), undefined, #"hash_466bc6bf903c0d79", undefined, 96);
  level flag::wait_till_any([# "hash_434bc775e67b7233", #"hash_20afa38b1f1c339e"]);
  zm_sq::objective_complete(#"hash_512230df2dcdd311");
  level flag::wait_till(#"hash_20afa38b1f1c339e");
  zm_sq::objective_complete(#"hash_1c556f45aa40ebef");
}

function function_37597f29() {
  util::add_debug_command("<dev string:x38>");
  zm_devgui::add_custom_devgui_callback(&cmd);
}

function cmd(cmd) {
  switch (cmd) {
    case # "hash_4f52dabbc7c7806b":
      level flag::set(#"hash_20afa38b1f1c339e");
      level clientfield::set("<dev string:x90>" + # "pap_portal_fx", 0);
      var_b9deb373 = struct::get_script_bundle_instances("<dev string:x94>", ["<dev string:x9d>", "<dev string:xb7>"]);
      var_f501ee56 = struct::get_script_bundle_instances("<dev string:x94>", ["<dev string:xc5>", "<dev string:xb7>"]);
      var_bc5ea9bc = arraycombine(var_b9deb373, var_f501ee56, 0, 0);
      var_1a4d3aef = struct::get_script_bundle_instances("<dev string:x94>", ["<dev string:xde>", "<dev string:xb7>"]);
      var_bc5ea9bc = arraycombine(var_bc5ea9bc, var_1a4d3aef, 0, 0);

      foreach(var_8a36246d in var_bc5ea9bc) {
        if(var_8a36246d scene::is_playing()) {
          var_8a36246d scene::stop(1);
        }
      }

      for(i = 0; i <= 10; i++) {
        level clientfield::set("<dev string:x90>" + # "hash_3fb8ca8c017ba7ac", i);
        waitframe(1);
      }

      break;
    default:
      break;
  }
}