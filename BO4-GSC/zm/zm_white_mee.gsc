/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_white_mee.gsc
***********************************************/

#include scripts\core_common\aat_shared;
#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\animation_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\spawner_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\trigger_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\zm\zm_hms_util;
#include scripts\zm\zm_white_perk_pap;
#include scripts\zm_common\util\ai_dog_util;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_behavior;
#include scripts\zm_common\zm_cleanup_mgr;
#include scripts\zm_common\zm_laststand;
#include scripts\zm_common\zm_pack_a_punch_util;
#include scripts\zm_common\zm_player;
#include scripts\zm_common\zm_powerups;
#include scripts\zm_common\zm_round_logic;
#include scripts\zm_common\zm_round_spawning;
#include scripts\zm_common\zm_sq;
#include scripts\zm_common\zm_unitrigger;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_weapons;
#include scripts\zm_common\zm_zonemgr;

#namespace zm_white_mee;

preload() {
  clientfield::register("scriptmover", "" + #"hash_2a3dbcaa79e8e3d6", 20000, 1, "int");
  clientfield::register("scriptmover", "" + #"hash_5e1264789183cde1", 20000, 1, "int");
  clientfield::register("toplayer", "" + #"hash_72a33f6d2cc925c5", 20000, 1, "int");
  clientfield::register("toplayer", "" + #"hash_1df297369e47699a", 20000, 1, "counter");
  clientfield::register("toplayer", "" + #"hash_7d631c764117de1e", 20000, 1, "counter");
  clientfield::register("toplayer", "" + #"hash_f2d0b920043dbbd", 20000, 1, "counter");
  clientfield::register("toplayer", "" + #"delete_model", 20000, 1, "counter");
  callback::on_spawned(&function_ba51762d);
}

init() {
  zm_round_spawning::register_archetype(#"mannequin", &function_f3cef15a, &mee_round_spawn, &function_293e9585, 5);
  level.var_1f856570 = array(function_fd846a91());
  array::thread_all(level.var_1f856570, &spawner::add_spawn_function, &zm_behavior::function_57d3b5eb);

  if(!zm_utility::is_ee_enabled()) {
    getent("ee_head", "targetname") delete();
  }

  level.var_22569770 = getent("e_spy", "targetname");
  level.var_22569770 hide();
  init_quests();
}

init_quests() {
  level flag::init("mee_round");
  level flag::init("mee_projectile_count_reached");
  zm_sq::register(#"mee_projectile", #"step_1", #"mee_projectile_step1", &mee_projectile_step1_setup, &mee_projectile_step1_cleanup);
  level flag::init("mee_melee_count_reached");
  e_partner = getent("mee_2_female", "targetname");
  e_partner hide();
  var_e979d075 = getEntArray("e_mee_2_weeper_final", "targetname");

  foreach(e_model in var_e979d075) {
    e_model hide();
  }

  zm_sq::register(#"mee_melee", #"step_1", #"mee_melee_step1", &mee_melee_step1_setup, &mee_melee_step1_cleanup);
  level flag::init("mee_galvaknuckle_count_reached");
  zm_sq::register(#"mee_galvaknuckle", #"step_1", #"mee_galvaknuckle_step1", &mee_galvaknuckle_step1_setup, &mee_galvaknuckle_step1_cleanup);
  level flag::init("mee_mixed_count_reached");
  zm_sq::register(#"mee_mixed", #"step_1", #"mee_mixed_step1", &mee_mixed_step1_setup, &mee_mixed_step1_cleanup);
  level flag::init(#"hash_502f2e83a538c679");
  level flag::init(#"hash_7346ae8e42a74ce6");
  zm_sq::register(#"jump_scare", #"step_1", #"hash_3203b932029a4e0b", &jump_scare, &jump_scare_cleanup);
  level flag::wait_till(#"all_players_spawned");

  if(zm_utility::is_ee_enabled()) {
    zm_sq::start(#"jump_scare");
  }
}

mee_projectile_step1_setup(var_5ea5c94d) {
  if(!var_5ea5c94d) {
    level flag::wait_till(#"mee_projectile_count_reached");
  }
}

mee_projectile_step1_cleanup(var_5ea5c94d, ended_early) {

  if(getdvarint(#"zm_debug_ee", 0)) {
    if(getdvarint(#"zm_debug_ee", 0)) {
      iprintlnbold("<dev string:x38>");
      println("<dev string:x38>");
    }
  }

    if(level.round_number < 25) {
      level.var_d2fac739 = 29 - level.round_number;
    }
  else if(level.round_number < 60) {
    level.var_d2fac739 = 59 - level.round_number;
  } else {
    level.var_d2fac739 = 0;
  }

  function_61e129a8();
}

mee_melee_step1_setup(var_5ea5c94d) {
  if(!var_5ea5c94d) {
    level flag::wait_till(#"mee_melee_count_reached");
  }
}

mee_melee_step1_cleanup(var_5ea5c94d, ended_early) {

  if(getdvarint(#"zm_debug_ee", 0)) {
    if(getdvarint(#"zm_debug_ee", 0)) {
      iprintlnbold("<dev string:x5e>");
      println("<dev string:x5e>");
    }
  }

    function_800ff39e();
}

mee_galvaknuckle_step1_setup(var_5ea5c94d) {
  if(!var_5ea5c94d) {
    level flag::wait_till(#"mee_galvaknuckle_count_reached");
  }
}

mee_galvaknuckle_step1_cleanup(var_5ea5c94d, ended_early) {
  if(var_5ea5c94d || ended_early) {
    level.var_f5624728 = getplayers()[0];
  }

  s_look = struct::get("mee_3_look_target", "targetname");
  watcher = spawn("script_origin", s_look.origin);

  while(watcher function_7f971d26()) {
    waitframe(1);
  }

  if(getdvarint(#"zm_debug_ee", 0)) {
    if(getdvarint(#"zm_debug_ee", 0)) {
      iprintlnbold("<dev string:x7f>");
      println("<dev string:x7f>");
    }
  }

    level.var_f5624728 clientfield::set_to_player("" + #"hash_72a33f6d2cc925c5", 0);
  watcher delete();
  var_74370e46 = getent("mee3_reward", "targetname");
  level thread trigger::look_trigger(var_74370e46);
  b_saw_the_wth = 0;

  while(!b_saw_the_wth) {
    waitresult = var_74370e46 waittill(#"trigger_look");

    if(waitresult.activator == level.var_f5624728) {
      b_saw_the_wth = 1;
      level.var_f5624728 clientfield::increment_to_player("" + #"hash_1df297369e47699a", 1);
      continue;
    }

    waitframe(1);
  }
}

mee_mixed_step1_setup(var_5ea5c94d) {
  if(!var_5ea5c94d) {
    level flag::wait_till(#"mee_mixed_count_reached");
  }
}

mee_mixed_step1_cleanup(var_5ea5c94d, ended_early) {
  if(var_5ea5c94d || ended_early) {
    level.var_561ae1f8 = 1;
    level.var_e80139f = 4;
    level flag::wait_till(#"mee_mixed_count_reached");
  }

  vec = anglesToForward(level.var_d53f00cb) + (0, 0, 15);
  var_e3f0084a = level.var_de56cee7.attacker magicgrenadeplayer(getweapon(#"eq_frag_grenade"), level.var_81603165 + (0, 0, 2), vec);

  if(getdvarint(#"zm_debug_ee", 0)) {
    if(getdvarint(#"zm_debug_ee", 0)) {
      iprintlnbold("<dev string:xa7>");
      println("<dev string:xa7>");
    }
  }

}

function_7b33625a() {
  if(isinarray(array("MOD_GRENADE", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE", "MOD_BURNED", "MOD_MELEE"), self.mod)) {
    return 0;
  }

  return 1;
}

function_ce7e594b() {
  foreach(player in level.players) {
    if(isplayer(self.attacker) && !isbot(self.attacker)) {
      if(isinarray(array("MOD_GRENADE", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE", "MOD_BURNED"), self.mod)) {
        return false;
      }

      return true;
    }
  }

  return false;
}

function_5b685950() {
  var_8ce4094 = level.var_e80139f === 3;
  zm_weap_chakram_melee_hit_rumblemembers = self.weapon.name === #"galvaknuckles_t8";
  return var_8ce4094 && !zm_weap_chakram_melee_hit_rumblemembers;
}

function_6e0162e8() {
  var_8ce4094 = level.var_e80139f === 2;
  zm_weap_chakram_melee_hit_rumblemembers = self.mod === "MOD_MELEE";
  return var_8ce4094 && !zm_weap_chakram_melee_hit_rumblemembers;
}

function_663fd427() {
  var_8ce4094 = level.var_e80139f === 1;
  zm_weap_chakram_melee_hit_rumblemembers = self function_7b33625a();
  return var_8ce4094 && !zm_weap_chakram_melee_hit_rumblemembers;
}

function_8d3f2364(waitresult) {
  level endon(#"game_ended", #"insanity_mode_triggered");

  if(isDefined(level.var_73d1e054) && level.var_73d1e054) {
    return;
  }

  if(level.var_561ae1f8 <= 0 || level flag::get(#"hash_48039f3a4c1a3248")) {
    return;
  } else if(level.var_e80139f === 0) {
    if(waitresult.mod === "MOD_MELEE") {
      if(waitresult.weapon.name === #"galvaknuckles_t8") {
        level.var_e80139f = 3;
        zm_sq::start(#"mee_galvaknuckle");

        if(getdvarint(#"zm_debug_ee", 0)) {
          if(getdvarint(#"zm_debug_ee", 0)) {
            iprintlnbold("<dev string:xc8>");
            println("<dev string:xc8>");
          }
        }

      } else {
        level.var_e80139f = 2;
        zm_sq::start(#"mee_melee");

        if(getdvarint(#"zm_debug_ee", 0)) {
          if(getdvarint(#"zm_debug_ee", 0)) {
            iprintlnbold("<dev string:xef>");
            println("<dev string:xef>");
          }
        }

      }
    } else if(waitresult function_7b33625a()) {
      level.var_e80139f = 1;
      zm_sq::start(#"mee_projectile");

      if(getdvarint(#"zm_debug_ee", 0)) {
        if(getdvarint(#"zm_debug_ee", 0)) {
          iprintlnbold("<dev string:x10f>");
          println("<dev string:x10f>");
        }
      }

    }
  } else if(!(level.var_e80139f == 4)) {
    if(waitresult function_5b685950() || waitresult function_6e0162e8() || waitresult function_663fd427()) {

      if(getdvarint(#"zm_debug_ee", 0)) {
        if(getdvarint(#"zm_debug_ee", 0)) {
          iprintlnbold("<dev string:x134>");
          println("<dev string:x134>");
        }
      }

      if(getdvarint(#"zm_debug_ee", 0)) {
        if(getdvarint(#"zm_debug_ee", 0)) {
          iprintlnbold("<dev string:x14d>");
          println("<dev string:x14d>");
        }
      }

        playsoundatposition(#"hash_8b7db1eb1a3365b", (0, 0, 0));
      zm_sq::start(#"mee_mixed");
      level.var_e80139f = 4;
      waitresult.attacker zm_audio::create_and_play_dialog("generic", "response_negative");
    }
  }

  level.var_561ae1f8--;

  if(getdvarint(#"zm_debug_ee", 0)) {
    if(getdvarint(#"zm_debug_ee", 0)) {
      iprintlnbold("<dev string:x16d>" + level.var_561ae1f8);
      println("<dev string:x16d>" + level.var_561ae1f8);
    }
  }

    if(level.var_561ae1f8 <= 0) {
      playsoundatposition(#"hash_a24b8d649da9f00", (0, 0, 0));

      if(zm_utility::is_trials()) {
        waitresult.attacker zm_audio::create_and_play_dialog("generic", "response_positive");
        level flag::set(#"hash_7346ae8e42a74ce6");
        return;
      }

      if(level.var_e80139f == 1) {
        waitresult.attacker zm_audio::create_and_play_dialog("generic", "response_positive");
        level flag::set("mee_projectile_count_reached");
        return;
      }

      if(level.var_e80139f == 2) {
        waitresult.attacker zm_audio::create_and_play_dialog("generic", "response_positive");
        level flag::set("mee_melee_count_reached");
        return;
      }

      if(level.var_e80139f == 3) {
        waitresult.attacker zm_audio::create_and_play_dialog("generic", "response_positive");
        level flag::set("mee_galvaknuckle_count_reached");
        level.var_f5624728 = waitresult.attacker;
        return;
      }

      level.var_de56cee7 = waitresult;
      level flag::set("mee_mixed_count_reached");
    }
}

function_e9768f1f() {
  level.var_561ae1f8 = 0;
  level.var_e80139f = 0;
  level.a_mees = getEntArray("dummy", "targetname");
  level.var_561ae1f8 = level.a_mees.size;

  if(level.a_mees.size <= 0) {
    return;
  }

  foreach(m in level.a_mees) {
    if(isDefined(m)) {
      m thread function_6e678915();
      m thread function_edcadf04();
    }
  }
}

function_e32cc1a7(data1, data2) {
  return data1.script_noteworthy == "head";
}

function_a292531e(data1, data2) {
  return data1.script_noteworthy == "body";
}

function_edcadf04() {
  self notify("1bf25477c2dd3455");
  self endon("1bf25477c2dd3455");
  self setCanDamage(1);
  self val::set("quest_mee", "allowDeath", 0);
  self endon(#"death");
  e_head = self;

  if(zm_utility::is_ee_enabled() || level flag::get(#"hash_502f2e83a538c679")) {
    pixbeginevent(#"hash_76daa837c3b1d91b");
    b_player_damaged = 0;

    while(!b_player_damaged) {
      self.health = 999;
      waitresult = self waittill(#"damage");
      b_player_damaged = waitresult function_ce7e594b();

      if(!b_player_damaged) {
        waitframe(1);
      }
    }

    angles = e_head.angles;
    origin = e_head.origin;
    force = vectornormalize(origin - waitresult.position);
    force += (0, 0, randomfloatrange(0.4, 0.6));
    force *= randomfloatrange(0.4, 0.6);
    head_model = "p8_zm_white_mannequin_female_01_head_dyn";

    if(self.male_head) {
      head_model = "p8_zm_white_mannequin_male_01_head_dyn";

      if(self.model == #"c_t8_zmb_dlc3_mannequin_male_damage_head_2") {
        head_model = "c_t8_zmb_dlc3_mannequin_male_damage_head_2_dyn";
      }
    }

    self notsolid();
    createdynentandlaunch(head_model, origin, angles, origin, force);
    var_d569099e = spawn("script_model", e_head.origin);
    var_d569099e thread function_f05235a0();
    level.var_81603165 = e_head.origin;
    level.var_d53f00cb = e_head.angles;

    if(!zm_utility::is_standard()) {
      self function_8d3f2364(waitresult);
    }

    pixendevent();
    self delete();
  }
}

function_f05235a0() {
  self endon(#"death");
  self clientfield::set("" + #"hash_5e1264789183cde1", 1);
  playsoundatposition(#"hash_452b9f142d5f6352", self.origin);
  wait 1;
  self delete();
}

function_303c5d09() {
  if(isDefined(self.var_4073461b)) {
    if(self.var_4073461b == 1) {
      var_bd8043ec = randomintrange(0, 4);

      if(var_bd8043ec == 0) {
        return;
      }

      if(isassetloaded("xmodel", self.model + "_color_0" + string(var_bd8043ec))) {
        self setModel(self.model + "_color_0" + string(var_bd8043ec));
      }
    }
  }
}

function_6e678915() {
  self endon(#"death");

  while(isDefined(self)) {
    for(b_player_in_range = 0; !b_player_in_range; b_player_in_range = 1) {
      wait randomintrangeinclusive(4, 8);
      player = zm_hms_util::function_3815943c();

      if(isDefined(player)) {
        distance = distance(player.origin, self.origin);

        if(player cansee(self) && distance < 240) {}
      }
    }

    if(isDefined(self)) {
      if(math::cointoss(10)) {
        if(math::cointoss(20)) {
          angles = function_794aee3c(player.origin, self);
          self rotateto(angles, 0.1);
        } else {
          for(i = 0; i < 5; i++) {
            if(isDefined(self) && isDefined(player)) {
              angles = function_794aee3c(player.origin, self, 1);
              self rotateto(angles, 1);
              wait 1;
            }
          }
        }
      }

      wait randomintrangeinclusive(4, 8);
    }
  }
}

function_794aee3c(player_pos, e_head, b_tracking = 0) {
  player_pos = (player_pos[0], player_pos[1], 0) + (0, 0, e_head.origin[2]);
  player_vec = player_pos - e_head.origin;
  angles = vectortoangles(player_vec);

  if(b_tracking) {
    x = difftrackangle(angles[0], e_head.angles[0], 0.5, 1);
    y = difftrackangle(angles[1], e_head.angles[1], 0.5, 1);
    z = difftrackangle(angles[2], e_head.angles[2], 0.5, 1);
    angles = (x, y, z);
  }

  return angles;
}

function_61e129a8() {
  level flag::set("mee_round");
  n_next_round = level.round_number + 1;
  b_delayed = 0;

  do {
    if(level flag::get(#"hash_7cc3b03eefb11fc") && !level flag::get(#"crawler_step_complete") || level flag::get(#"hash_6ebb9d0d0539bf68") && !level flag::get(#"hash_7c2ae917559738ec")) {
      b_delayed = 1;
      wait 1;
      continue;
    }

    n_next_round = level.round_number + 1;
    b_delayed = 0;
  }
  while(b_delayed);

  var_898a45da = level.var_45827161[n_next_round];

  if(isDefined(var_898a45da)) {
    zm_round_spawning::function_43aed0ca(n_next_round);
  }

  level.zombie_round_start_delay = 0;
  zm_round_spawning::function_b4a8f95a(#"mannequin", n_next_round, &function_991eb140, &function_bc9a7799, &function_b76df747, &function_e2d1e574, 0);

  if(zm_round_spawning::function_40229072(level.round_number) && !level flag::get("special_round")) {
    level waittill(#"special_round");
  } else if(!level flag::get("begin_spawning")) {
    level waittill(#"begin_spawning");
  }

  zm_hms_util::function_2ba419ee(0);
}

function_991eb140() {
  level flag::set("mee_round");
  level.var_5edd153f = 1;
  callback::on_laststand(&function_1025a301);
  zm_round_spawning::function_5bc2cea1(&zombie_dog_util::function_ed67c5e7);
  level thread zm_audio::sndmusicsystem_playstate("dog_start");
  level thread zm_audio::sndannouncerplayvox(undefined, undefined, "vox_event_robotstart_avoa_0");
}

mee_cleanup() {
  return false;
}

function_1025a301() {
  a_players = getplayers();

  if(a_players.size < 2) {
    level.var_5edd153f = 0;
    zm_hms_util::function_2ba419ee();
  }
}

function_fd846a91() {
  spawner = getent("mannequin_zombie_spawner", "script_noteworthy");
  return spawner;
}

function_bc9a7799(var_d25bbdd5) {
  level flag::clear("mee_round");

  if(isDefined(level.var_5edd153f) && level.var_5edd153f) {
    level thread function_6af32608();
  }

  callback::remove_on_laststand(&function_1025a301);
  zm_round_spawning::function_df803678(&zombie_dog_util::function_ed67c5e7);
  level thread zm_audio::sndmusicsystem_playstate("dog_end");
  level.fn_custom_zombie_spawner_selection = undefined;
  level.zombie_round_start_delay = undefined;
  wait 5;
}

function_b76df747() {
  a_e_players = getplayers();
  n_max = 10;

  switch (a_e_players.size) {
    case 1:
      n_max = 60;
      break;
    case 2:
      n_max = 90;
      break;
    case 3:
    case 4:
      n_max = 120;
      break;
  }

  return n_max;
}

function_e2d1e574() {
  n_time = zm_round_logic::get_zombie_spawn_delay(level.round_number + level.var_d2fac739);
  wait n_time;
}

function_6af32608() {
  if(!zm_utility::is_standard()) {
    drop_point = struct::get("mee_perk_drop");
    var_c9e07c3e = drop_point.origin;
    level.var_dcd1e798 = getent("perk_machine_mover", "targetname");
    level.var_dcd1e798 useanimtree("generic");
    var_2379bb0e = spawn("script_model", var_c9e07c3e);
    var_2379bb0e setModel("zombie_pickup_perk_bottle");
    var_2379bb0e hide();
    level.var_dcd1e798.origin = var_c9e07c3e;
    var_2379bb0e linkto(level.var_dcd1e798, "tag_animate_origin");
    level.var_dcd1e798 thread animation::play("p8_fxanim_zm_white_perk_machine_dummy_fly_in");
    waitframe(2);
    var_2379bb0e show();
    wait 3.5;
    level thread zm_white_perk_pap::function_48acb6ed(var_c9e07c3e);
    playrumbleonposition("zm_white_perk_impact", var_c9e07c3e);
    playrumbleonposition("zm_white_perk_aftershock", var_c9e07c3e);
    level thread zm_powerups::specific_powerup_drop("free_perk", var_c9e07c3e, undefined, 0.1, undefined, 1);
    var_2379bb0e delete();
  }
}

function_2c41e66e(params) {
  if(zombie_utility::get_current_zombie_count() == 1 && level.zombie_total == 0) {
    self thread function_6af32608();
  }
}

function_293e9585() {
  spawner = function_fd846a91();
  spawn_point = array::random(level.zm_loc_types[#"zombie_location"]);
  ai = zombie_utility::spawn_zombie(spawner, spawner.targetname, spawn_point, level.round_number + level.var_d2fac739);

  if(isDefined(ai)) {}

  return ai;
}

mee_round_spawn() {
  ai = function_293e9585();

  if(isDefined(ai)) {
    level.zombie_total--;
    return true;
  }

  return false;
}

function_f3cef15a(var_dbce0c44) {
  var_8cf00d40 = int(floor(var_dbce0c44 / 5));

  if(level.round_number < 20) {
    var_a8ce2d71 = 0.02;
  } else if(level.round_number < 30) {
    var_a8ce2d71 = 0.03;
  } else {
    var_a8ce2d71 = 0.04;
  }

  return min(var_8cf00d40, int(ceil(level.zombie_total * var_a8ce2d71)));
}

function_7f971d26() {
  foreach(player in level.players) {
    if(player cansee(self)) {
      return true;
    }
  }

  return false;
}

function_800ff39e() {
  level endon(#"boss_lockdown", #"game_ended");

  while(level.var_22569770 function_7f971d26()) {
    waitframe(1);
  }

  spawner = getent("weeping_spawner", "script_noteworthy");
  level.e_weeper = zombie_utility::spawn_zombie(spawner, spawner.targetname, undefined, level.round_number);
  level.e_weeper setModel("c_t8_zmb_dlc3_mannequin_male");
  level.e_weeper.var_72411ccf = &function_589845fe;
  level.e_weeper val::set(#"mee_2", "takedamage", 0);
  level.e_weeper val::set(#"mee_2", "ignoreme", 1);
  level.e_weeper.team = #"team3";
  var_83302022 = getent("t_mee_2_activate", "targetname");
  level thread trigger::look_trigger(var_83302022);
  waitresult = var_83302022 waittill(#"trigger_look");
  var_83302022 delete();
  level.e_weeper.var_72411ccf = undefined;
  level.e_weeper thread function_d10bf985();
  level.e_partner = getent("mee_2_female", "targetname");
  level.e_partner show();
  level.var_7b22edab = spawn("script_origin", level.e_partner.origin + (0, 0, 10));

  while(!level.e_weeper is_near("mee_2_follow_trigger")) {
    waitframe(1);
  }

  level.e_partner thread function_6fa00342(level.e_weeper);
  s_goal = struct::get("s_mee_2_goalPos", "targetname");
  level.e_weeper.var_3d366381 = getclosestpointonnavmesh(s_goal.origin, 32);
  level.e_weeper.team = #"allies";
  level.e_weeper zombie_utility::set_zombie_run_cycle("run");
  level.e_weeper.var_72411ccf = &function_589845fe;

  while(!level.e_weeper is_near("mee_2_shed")) {
    waitframe(1);
  }

  level.e_partner notify(#"follow_complete");
  level.e_weeper.var_3d366381 = undefined;
  e_door = getent("mee_2_door", "targetname");
  e_door playSound("zmb_shed_door_open");
  e_door rotateto((0, 202, 0), 1);
  wait 2;
  var_e979d075 = getEntArray("e_mee_2_weeper_final", "targetname");

  while(level.e_weeper function_7f971d26() || level.e_partner function_7f971d26() || var_e979d075[0] function_7f971d26()) {
    waitframe(1);
  }

  if(isDefined(level.e_weeper.kill_brush)) {
    level.e_weeper.kill_brush delete();
  }

  level.e_weeper delete();
  level.var_7b22edab delete();
  level.e_partner show();

  foreach(e_model in var_e979d075) {
    e_model show();
  }

  var_881f5a41 = struct::get("s_mee_2_partner_final", "targetname");
  level.e_partner.origin = var_881f5a41.origin;
  level.e_partner.angles = var_881f5a41.angles;
  var_1d15513c = struct::get("s_mee_2_partner_final_head", "targetname");
  var_1ccba54f = getent("e_mee_2_partner_head", "targetname");
  var_1ccba54f.origin = var_1d15513c.origin;
  var_1ccba54f.angles = var_1d15513c.angles;
  var_c3a00a1a = getent("t_mee_2_shed", "targetname");
  level thread trigger::look_trigger(var_c3a00a1a);
  waitresult = var_c3a00a1a waittill(#"trigger_look");
  var_c3a00a1a delete();
  e_door playSound("zmb_shed_door_close");
  e_door rotateto((0, 340, 0), 1);
  wait 2;
  e_player = waitresult.activator;
  s_reward = struct::get("s_mee_2_reward", "targetname");
  mdl_reward = spawn("script_model", s_reward.origin);
  mdl_reward setModel("p8_zm_gla_heart_zombie");
  mdl_reward movez(5, 1);
  mdl_reward thread powerup_wobble_fx();
  mdl_reward playSound("zmb_shed_powerup_burst");
  s_reward.mdl_reward = mdl_reward;
  s_reward zm_unitrigger::create(&function_ce3168e6);
  s_reward thread function_50aeeeff();
}

function_d10bf985() {
  self endon(#"death");

  while(true) {
    if(isDefined(self.is_inert) && self.is_inert) {
      wait 2;

      if(isDefined(self.is_inert) && self.is_inert) {
        self.kill_brush = spawn("trigger_radius", self.origin, 0, 30, 72);
        self.kill_brush.script_noteworthy = "kill_brush";
        self.kill_brush thread function_d857924d();

        while(isDefined(self.is_inert) && self.is_inert) {
          waitframe(1);
        }

        self.kill_brush delete();
      }
    }

    waitframe(1);
  }
}

function_d857924d() {
  self endoncallback(&function_33e0a5d1, #"death");

  while(true) {
    foreach(player in getplayers()) {
      if(player istouching(self) && player clientfield::get_to_player("zm_zone_out_of_bounds") == 0) {
        player clientfield::set_to_player("zm_zone_out_of_bounds", 1);
        continue;
      }

      if(!player istouching(self) && player clientfield::get_to_player("zm_zone_out_of_bounds") == 1) {
        player clientfield::set_to_player("zm_zone_out_of_bounds", 0);
      }
    }

    waitframe(1);
  }
}

function_33e0a5d1(str_notify) {
  foreach(player in getplayers()) {
    player clientfield::set_to_player("zm_zone_out_of_bounds", 0);
  }
}

function_589845fe(behaviortreeentity) {
  if(function_5ebeab8c() && isDefined(behaviortreeentity.var_3d366381)) {
    behaviortreeentity setgoal(behaviortreeentity.var_3d366381);
    return;
  }

  behaviortreeentity setgoal(behaviortreeentity.origin);
}

function_5ebeab8c() {
  foreach(player in getplayers()) {
    dist = distancesquared(self.origin, player.origin);

    if(dist <= 262144) {
      return true;
    }
  }

  return false;
}

function_ce3168e6(e_player) {
  if(function_8b1a219a()) {
    self sethintstring(#"hash_59a1cf82de6de51");
  } else {
    self sethintstring(#"hash_69320c1b3c0f8fdb");
  }

  return true;
}

function_50aeeeff() {
  self endon(#"death");
  self waittill(#"trigger_activated");
  a_e_players = getplayers();

  foreach(player in a_e_players) {
    player zm_laststand::function_3a00302e();
  }

  self.mdl_reward delete();
  zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
}

powerup_wobble_fx() {
  self endon(#"death");

  if(!isDefined(self)) {
    return;
  }

  self clientfield::set("powerup_fx", 1);
}

is_near(str_info) {
  t_proximity = getent(str_info, "targetname");

  if(isDefined(self)) {
    b_near = self istouching(t_proximity);
    return b_near;
  }

  return 0;
}

function_6fa00342(e_follow) {
  self endon(#"follow_complete");
  level endon(#"preamble_started");

  while(true) {
    var_9d88bc68 = anglesToForward(e_follow.angles);
    var_9d88bc68 = 15 * vectornormalize(var_9d88bc68);
    goal_pos = e_follow.origin - var_9d88bc68;
    goal_pos = getnearestpathpoint(goal_pos, 64);
    level.var_7b22edab.origin = goal_pos + (0, 0, 15);

    if(self function_66a7e20a() && level.var_7b22edab function_66a7e20a()) {
      self ghost();
      self.origin = goal_pos;
      var_6dcf609c = (e_follow.origin[0], e_follow.origin[1], 0) + (0, 0, self.origin[2]);
      var_61e1fa2f = var_6dcf609c - self.origin;
      var_867c9147 = vectortoangles(var_61e1fa2f);
      self.angles = var_867c9147;
      waitframe(1);
      self show();
    }

    waitframe(1);
  }
}

function_66a7e20a() {
  foreach(player in getplayers()) {
    if(player cansee(self)) {
      return false;
    }
  }

  return true;
}

function_ba51762d() {
  self endon(#"disconnect");
  level flag::wait_till("start_zombie_round_logic");
  waitframe(1);
  self clientfield::set_to_player("" + #"hash_72a33f6d2cc925c5", 1);
}

function_c4fbad3() {
  if(zm_utility::is_ee_enabled()) {
    level thread function_4b660ce0();
    level thread function_3117c10();
  }

  level thread function_e9768f1f();
}

function_4b660ce0() {
  level waittill(#"nuke_clock_moved");
  level waittill(#"magic_door_power_up_grabbed");

  if(level.population_count == 15) {

    if(getdvarint(#"zm_debug_ee", 0)) {
      if(getdvarint(#"zm_debug_ee", 0)) {
        iprintlnbold("<dev string:x181>");
        println("<dev string:x181>");
      }
    }

  }
}

function_3117c10() {
  var_28560003 = getEntArray("teddy_bear", "targetname");

  foreach(var_7da32058 in var_28560003) {
    unitrigger_stub = spawnStruct();
    unitrigger_stub.related_parent = var_7da32058;
    unitrigger_stub.origin = var_7da32058.origin;
    unitrigger_stub.angles = var_7da32058.angles;
    unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
    unitrigger_stub.cursor_hint = "HINT_NOICON";
    unitrigger_stub.script_width = 64;
    unitrigger_stub.script_height = 64;
    unitrigger_stub.script_length = 64;
    unitrigger_stub.require_look_at = 0;
    unitrigger_stub.targetname = "teddy_bear_unitrigger";
    unitrigger_stub.hint_string = undefined;
    unitrigger_stub.hint_parm1 = undefined;
    unitrigger_stub.hint_parm2 = undefined;
    unitrigger_stub.e_model = var_7da32058;
    unitrigger_stub.e_model playLoopSound(#"hash_1fd4928ce5489175");
    zm_unitrigger::register_static_unitrigger(unitrigger_stub, &function_15534b78);
    var_7da32058.unitrigger_stub = unitrigger_stub;
  }

  level.meteor_counter = 0;
}

function_15534b78() {
  self endon(#"death");
  waitresult = self waittill(#"trigger");
  player = waitresult.activator;
  self.stub.e_model stoploopsound();
  self.stub.e_model playSound(#"hash_20284b79e543698c");
  level.meteor_counter++;

  if(level.meteor_counter == 3) {
    if(level.musicsystem.currentplaytype < 4) {
      level thread zm_audio::sndmusicsystem_stopandflush();
      waitframe(1);
      level thread zm_audio::sndmusicsystem_playstate("ee_song_main");
    }

    if(getdvarint(#"zm_debug_ee", 0)) {
      if(getdvarint(#"zm_debug_ee", 0)) {
        iprintlnbold("<dev string:x1b6>");
        println("<dev string:x1b6>");
      }
    }

  } else {

    if(getdvarint(#"zm_debug_ee", 0)) {
      if(getdvarint(#"zm_debug_ee", 0)) {
        iprintlnbold("<dev string:x1ef>" + level.meteor_counter + "<dev string:x1fd>");
        println("<dev string:x1ef>" + level.meteor_counter + "<dev string:x1fd>");
      }
    }

  }

  zm_unitrigger::unregister_unitrigger(self.stub);
}

on_player_connect() {
  self thread track_player_eyes();
}

jump_scare(var_a276c861) {
  foreach(player in level.players) {
    player thread track_player_eyes();
  }

  callback::on_connect(&on_player_connect);
}

track_player_eyes() {
  self notify(#"track_player_eyes");
  self endon(#"disconnect", #"track_player_eyes");
  level endon(#"hash_10a56459715cd20e", #"insanity_mode_triggered");
  self thread function_cbeb9a33();
  b_saw_the_wth = 0;
  var_616e76c5 = struct::get("sq_gl_scare", "targetname");
  waitframe(1);
  self clientfield::increment_to_player("" + #"hash_7d631c764117de1e", 1);

  while(!b_saw_the_wth) {
    n_time = 0;

    while(self adsbuttonpressed() && n_time < 90) {
      n_time++;
      waitframe(1);
    }

    if(n_time >= 90 && self adsbuttonpressed() && self zm_zonemgr::entity_in_zone("zone_green_backyard") && is_weapon_sniper(self getcurrentweapon()) && self zm_utility::is_player_looking_at(var_616e76c5.origin, 0.9975, 0, self)) {
      self zm_utility::do_player_general_vox("general", "scare_react", undefined, 100);
      self clientfield::increment_to_player("" + #"hash_f2d0b920043dbbd", 1);
      j_time = 0;

      while(self adsbuttonpressed() && j_time < 5) {
        j_time++;
        waitframe(1);
      }

      b_saw_the_wth = 1;
    }

    waitframe(1);
  }
}

private is_weapon_sniper(w_weapon) {
  if(isDefined(w_weapon.issniperweapon) && w_weapon.issniperweapon) {
    if(weaponhasattachment(w_weapon, "elo") || weaponhasattachment(w_weapon, "reflex") || weaponhasattachment(w_weapon, "holo") || weaponhasattachment(w_weapon, "is")) {
      return false;
    } else {
      return true;
    }
  }

  return false;
}

jump_scare_cleanup(var_a276c861, var_19e802fa) {}

function_cbeb9a33() {
  level waittill(#"insanity_mode_triggered");

  if(isDefined(self)) {
    self clientfield::increment_to_player("" + #"delete_model", 1);
  }
}