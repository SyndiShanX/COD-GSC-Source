/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\ai\zm_ai_bat.gsc
***********************************************/

#include scripts\core_common\ai\blackboard_vehicle;
#include scripts\core_common\ai\systems\ai_interface;
#include scripts\core_common\ai\systems\animation_state_machine_notetracks;
#include scripts\core_common\ai\systems\blackboard;
#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\ai_shared;
#include scripts\core_common\animation_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\spawner_shared;
#include scripts\core_common\statemachine_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\core_common\vehicle_ai_shared;
#include scripts\core_common\vehicle_death_shared;
#include scripts\core_common\vehicle_shared;
#include scripts\zm_common\ai\zm_ai_utility;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_cleanup_mgr;
#include scripts\zm_common\zm_devgui;
#include scripts\zm_common\zm_round_spawning;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_spawner;
#include scripts\zm_common\zm_transformation;
#include scripts\zm_common\zm_utility;

#namespace bat;

class class_726d8173 {
  var healthmultiplier;
  var mover;
  var origin;

  constructor() {
    origin = undefined;
    mover = undefined;
    healthmultiplier = undefined;
  }

}

autoexec __init__system__() {
  system::register(#"bat", &__init__, undefined, undefined);
}

__init__() {
  vehicle::add_main_callback("bat", &function_6c223039);
  spawner::function_89a2cd87(#"bat", &function_141c342b);
  zm_transform::function_cfca77a7(#"spawner_zm_nosferatu", #"hash_791d597ac0457860", undefined, 0, undefined, undefined);
  level thread function_1b029905();
  zm_round_spawning::register_archetype(#"bat", &function_84cd2223, &function_9471b7f9, &function_2e37549f, 25);
  zm_score::function_e5d6e6dd(#"bat", 60);
  clientfield::register("vehicle", "bat_transform_fx", 8000, 1, "int");
  level.bat_spawners = getEntArray("zombie_bat_spawner", "script_noteworthy");

  zm_devgui::function_c7dd7a17("<dev string:x38>");

}

function_6c223039() {
  self useanimtree("generic");
  initblackboard();
  self.b_ignore_cleanup = 1;
  self.var_5dd07a80 = 1;
  self.var_232915af = 1;
  self.var_68139d12 = 1;
  self.nodamagefeedback = 1;
  self vehicle::friendly_fire_shield();
  self enableaimassist();
  self setneargoalnotifydist(25);
  self setdrawinfrared(1);
  self.fovcosine = 0;
  self.fovcosinebusy = 0;
  self.vehaircraftcollisionenabled = 1;
  assert(isDefined(self.scriptbundlesettings));
  self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
  self.goalradius = 999999;
  self.goalheight = 512;
  self.var_ec0d66ce = 0.5 * (self.settings.engagementdistmin + self.settings.engagementdistmax);
  self.var_ff6d7c88 = self.var_ec0d66ce * self.var_ec0d66ce;
  self thread vehicle_ai::nudge_collision();
  var_134ac8f9 = int(zm_ai_utility::function_8d44707e(0));
  var_134ac8f9 *= isDefined(level.var_570d178a) ? level.var_570d178a : 1;
  self.health = int(var_134ac8f9);
  self.maxhealth = int(var_134ac8f9);
  defaultrole();
  target_set(self);
}

function_141c342b() {
  var_134ac8f9 = int(zm_ai_utility::function_8d44707e(0));
  var_134ac8f9 *= isDefined(level.var_570d178a) ? level.var_570d178a : 1;
  self.health = int(var_134ac8f9);
  self.maxhealth = int(var_134ac8f9);
  self disableaimassist();
  self zm_score::function_82732ced();
}

function_ab7568e0() {
  self endon(#"change_state", #"death");

  while(true) {
    if(self function_c48c2d66() && self vehicle_ai::get_current_state() != "transform") {
      self thread vehicle_ai::set_state("transform");
    }

    waitframe(1);
  }
}

private istargetvalid(target) {
  if(!isDefined(target) || !isalive(target)) {
    return false;
  }

  if(isplayer(target) && (target.sessionstate == "spectator" || target.sessionstate == "intermission")) {
    return false;
  }

  if(isDefined(target.ignoreme) && target.ignoreme || target isnotarget()) {
    return false;
  }

  return true;
}

private gettarget() {
  targets = getplayers();
  leasthunted = targets[0];

  for(i = 0; i < targets.size; i++) {
    if(!isDefined(targets[i].hunted_by)) {
      targets[i].hunted_by = 0;
    }

    if(!istargetvalid(targets[i])) {
      continue;
    }

    if(!istargetvalid(leasthunted) || targets[i].hunted_by < leasthunted.hunted_by) {
      leasthunted = targets[i];
    }
  }

  if(istargetvalid(leasthunted)) {
    return leasthunted;
  }
}

private function_1076a2e0() {
  self endon(#"change_state", #"death");

  while(true) {
    if(isDefined(self.ignoreall) && self.ignoreall) {
      wait 0.5;
      continue;
    }

    if(istargetvalid(self.var_c4e19d3)) {
      wait 0.5;
      continue;
    }

    target = gettarget();

    if(!isDefined(target)) {
      self.var_c4e19d3 = undefined;
    } else {
      self.var_c4e19d3 = target;
      self.var_c4e19d3.hunted_by += 1;
      self vehlookat(self.var_c4e19d3);
      self turretsettarget(0, self.var_c4e19d3);
    }

    wait 0.5;
  }
}

private function_776e45e5() {
  self endon(#"change_state", #"death");
  self waittilltimeout(10, #"reached_end_node");

  while(true) {
    players = getplayers();
    var_3ada9d08 = 0;

    foreach(player in players) {
      if(self seerecently(player, 30)) {
        var_3ada9d08 = 1;
        break;
      }
    }

    if(gettime() - self.spawn_time > 10000 && !var_3ada9d08 && !(isDefined(self.var_894194a9) && self.var_894194a9)) {
      self.var_d880e556 = 1;

      if(!level flag::get("special_round")) {
        for(ai = function_2e37549f(1); !isDefined(ai); ai = function_2e37549f(1)) {
          waitframe(1);
        }

        ai.health = self.health;
      }

      self zm_cleanup::cleanup_zombie();
      return;
    }

    wait 1;
  }
}

private initblackboard() {
  blackboard::createblackboardforentity(self);
  self blackboard::registervehicleblackboardattributes();
  ai::createinterfaceforentity(self);
}

defaultrole() {
  statemachine = self vehicle_ai::init_state_machine_for_role("default");
  self vehicle_ai::get_state_callbacks("combat").enter_func = &state_combat_enter;
  self vehicle_ai::get_state_callbacks("combat").update_func = &state_combat_update;
  self vehicle_ai::get_state_callbacks("death").update_func = &state_death_update;
  statemachine statemachine::add_state("transform", &function_9071e5a9, &function_47c795bc, &function_db99ddec);
  self vehicle_ai::call_custom_add_state_callbacks();
  vehicle_ai::startinitialstate("combat");
}

function_9122b0e5() {
  return self ai::get_behavior_attribute("firing_rate");
}

function_607df9c6(ai) {
  if(isDefined(level.var_45827161) && isDefined(level.var_45827161[level.round_number])) {
    ai.var_ba75c6dc = 1;
  }

  if(isDefined(ai.var_e21c1964) && ai.var_e21c1964) {
    return;
  }

  actors = getentitiesinradius(ai.origin, 80, 15);

  foreach(actor in actors) {
    if(actor.team !== level.zombie_team || actor.archetype !== #"zombie") {
      continue;
    }

    actor zombie_utility::setup_zombie_knockdown(ai);
  }

  ai.var_e21c1964 = 1;
  var_cd1cfeed = ai animmappingsearch(#"hash_605e435c80f0d33b");
  pos = physicstrace(ai.origin, ai.origin + (0, 0, -10000), (-2, -2, -2), (2, 2, 2), ai, 1);
  pos = pos[#"position"];

  if(isDefined(level.var_84b2907f)) {
    level thread[[level.var_84b2907f]](ai);
  }

  if(isDefined(var_cd1cfeed)) {
    if(isDefined(pos)) {
      ai animation::play(var_cd1cfeed, pos, ai.angles, 1, 0.2, 0.1, undefined, undefined, undefined, 0);
      return;
    }

    ai animation::play(var_cd1cfeed, ai.origin, ai.angles, 1, 0.2, 0.1, undefined, undefined, undefined, 0);
  }
}

private function_1b029905() {
  while(true) {
    waitresult = level waittill(#"transformation_complete");

    if(waitresult.id === #"hash_791d597ac0457860" && isDefined(waitresult.data)) {
      newai = waitresult.new_ai[0];
      newai.maxhealth *= waitresult.data.healthmultiplier;
      newai.health = newai.maxhealth;
    }

    wait 0.1;
  }
}

function_1fff2d() {
  pos = physicstrace(self.origin, self.origin + (0, 0, -10000), (-2, -2, -2), (2, 2, 2), self, 1);

  if(isDefined(pos) && isDefined(pos[#"position"]) && !isDefined(pos[#"entity"])) {
    pos = pos[#"position"];

    recordline(self.origin, pos, (0, 1, 1), "<dev string:x3e>");
    recordsphere(pos, 8, (0, 1, 1), "<dev string:x3e>");

      posonnavmesh = getclosestpointonnavmesh(pos, 256, 30);

    if(isDefined(posonnavmesh)) {
      pos = physicstrace(posonnavmesh + (0, 0, 70), posonnavmesh + (0, 0, -70), (-2, -2, -2), (2, 2, 2), self, 1);
      pos = pos[#"position"];

      recordline(pos, posonnavmesh, (0, 0, 1), "<dev string:x3e>");
      recordsphere(posonnavmesh, 8, (0, 0, 1), "<dev string:x3e>");

        if(isDefined(pos)) {
          scriptmodel = util::spawn_model("tag_origin", self.origin, self.angles);

          if(isDefined(scriptmodel)) {
            self.ai.var_15916e52 = new class_726d8173();
            self.ai.var_15916e52.pos = pos;
            self.ai.var_15916e52.mover = scriptmodel;
            return true;
          }
        }
    }
  }

  return false;
}

function_c48c2d66() {
  if(isDefined(self.var_d880e556) && self.var_d880e556) {
    return false;
  }

  if(zm_transform::function_abf1dcb4(#"hash_791d597ac0457860")) {
    return false;
  }

  if(!isDefined(self.spawn_time)) {
    return false;
  }

  if(gettime() - self.spawn_time < 3500) {
    return false;
  }

  if(self isplayinganimscripted()) {
    return false;
  }

  if(function_1fff2d()) {
    assert(isDefined(self.ai.var_15916e52));
    return true;
  }

  return false;
}

function_9071e5a9(params) {
  self.takedamage = 0;
  self.var_894194a9 = 1;
}

function_630752f6(notifyhash) {
  if(isDefined(self) && isDefined(self.ai) && isDefined(self.ai.var_15916e52) && isDefined(self.ai.var_15916e52.mover)) {
    self.ai.var_15916e52.mover delete();
    self.ai.var_15916e52 = undefined;
  }
}

private function_88d81715() {
  self endon(#"death");
  wait 1.5;
  self ghost();
}

function_47c795bc(params) {
  self endoncallback(&function_630752f6, #"death", #"state_change");
  assert(isDefined(self.ai.var_15916e52));
  self.ai.var_15916e52.healthmultiplier = self.var_b008e588;
  movepos = self.ai.var_15916e52.pos;
  mover = self.ai.var_15916e52.mover;
  tagorigin = self.origin;
  var_4edd9b4 = self gettagorigin("j_spine4");
  offset = var_4edd9b4 - tagorigin;
  timescale = 0.4;
  movetime = getanimlength(self animmappingsearch(#"par_transform")) * timescale;
  mover enablelinkto();
  self linkto(mover, "tag_origin", offset, (0, 0, 0));
  self asmrequestsubstate(#"hash_4bea3500eb31dd8b");
  self thread function_88d81715();
  acceleration = 0.3;
  mover moveto(self.origin + (0, 0, 30), 0.6, acceleration);
  mover waittill(#"movedone");
  waittime = 0.1;
  wait waittime;
  acceleration = 0.6;
  mover moveto(movepos, movetime, acceleration);
  mover waittill(#"movedone");
  self clientfield::set("bat_transform_fx", 1);
  self.overridevehicledamage = undefined;
  zm_transform::function_9acf76e6(self, #"hash_791d597ac0457860", &function_607df9c6, 0);
  radiusdamage(self.origin, 200, 15, 5, self);
  self.ai.var_15916e52 = undefined;

  if(isDefined(mover)) {
    mover delete();
  }

  wait 1;
  self delete();
}

function_db99ddec(params) {}

state_death_update(params) {
  self endon(#"death");
  self asmrequestsubstate(#"death@stationary");

  if(isDefined(self.var_c4e19d3) && isDefined(self.var_c4e19d3.hunted_by)) {
    self.var_c4e19d3.hunted_by--;
  }

  self vehicle_death::death_fx();
  self val::set(#"zm_ai_bat", #"hide", 2);
  wait 1;
  self delete();
}

state_combat_enter(params) {
  self thread function_1076a2e0();
  self thread function_2b369c9f();
  self thread function_ab7568e0();

  self thread function_66d3e7c2();

}

function_2b369c9f() {
  self endon(#"change_state", #"death");
  self.ai.var_e7d26c0f = 0;

  while(true) {
    if(self.ai.var_e7d26c0f > 3) {
      if(isDefined(level.var_d9f4b654)) {
        self.ai.var_e7d26c0f = 0;
        [
          [level.var_d9f4b654]
        ](self);
      }
    }

    wait 1;
  }
}

function_1c4cd527(origin, owner, innerradius, outerradius, halfheight, spacing) {
  queryresult = positionquery_source_navigation(origin, innerradius, outerradius, halfheight, spacing, "navvolume_small", spacing);
  positionquery_filter_sight(queryresult, origin, self getEye() - self.origin, self, 0, owner);

  foreach(point in queryresult.data) {
    if(!point.visibility) {

      if(!isDefined(point._scoredebug)) {
        point._scoredebug = [];
      }

      if(!isDefined(point._scoredebug[#"no visibility"])) {
        point._scoredebug[#"no visibility"] = spawnStruct();
      }

      point._scoredebug[#"no visibility"].score = -5000;
      point._scoredebug[#"no visibility"].scorename = "<dev string:x47>";

        point.score += -5000;
    }
  }

  if(queryresult.data.size > 0) {
    vehicle_ai::positionquery_postprocess_sortscore(queryresult);
    self vehicle_ai::positionquery_debugscores(queryresult);

    foreach(point in queryresult.data) {
      if(isDefined(point.origin)) {
        goal = point.origin;
        break;
      }
    }
  }

  return goal;
}

function_8550e9be(enemy) {
  protectdest = undefined;

  if(isDefined(enemy)) {
    groundpos = getclosestpointonnavmesh(enemy.origin, 10000);

    if(isDefined(groundpos)) {
      self.var_d6acaac4 = groundpos;
      pos = groundpos + (0, 0, randomintrange(100, 150));
      pos = getclosestpointonnavvolume(pos, "navvolume_small", 2000);

      if(isDefined(pos)) {
        var_3a364b6c = distance(self.origin, pos);

        if(var_3a364b6c > 500) {
          protectdest = function_1c4cd527(pos, enemy, 200, 350, 24, 48);

          if(isDefined(protectdest)) {
            self.var_c8c5a7d3 = protectdest;
          }
        }
      }
    }
  }

  return protectdest;
}

function_66d3e7c2() {
  self endon(#"death");

  while(true) {
    if(isDefined(self.var_c8c5a7d3)) {

      recordsphere(self.var_c8c5a7d3, 8, (0, 0, 1), "<dev string:x3e>");

        if(isDefined(self.var_d6acaac4)) {

          recordsphere(self.var_c8c5a7d3, 8, (0, 1, 0), "<dev string:x3e>");
          recordline(self.var_c8c5a7d3, self.var_d6acaac4, (0, 1, 0), "<dev string:x3e>");

        }
    }

    waitframe(1);
  }
}

state_combat_update(params) {
  self endon(#"change_state", #"death");
  self asmrequestsubstate(#"locomotion@movement");

  for(;;) {
    if(isDefined(self.ignoreall) && self.ignoreall) {
      wait 1;
      continue;
    }

    if(!ispointinnavvolume(self.origin, "navvolume_small")) {
      var_f524eafc = getclosestpointonnavvolume(self.origin, "navvolume_small", 2000);

      if(isDefined(var_f524eafc)) {
        self.origin = var_f524eafc;
      }
    }

    if(!isDefined(self.var_c4e19d3)) {
      self function_a57c34b7(self.origin, 1, 1);
    }

    protectdest = function_8550e9be(self.var_c4e19d3);

    if(isDefined(protectdest)) {
      path = function_ae7a8634(self.origin, protectdest, self);

      if(isDefined(path) && path.status === "succeeded") {
        self.ai.var_e7d26c0f = 0;
        self function_a57c34b7(protectdest, 1, 1);
      } else {
        self.ai.var_e7d26c0f++;
      }
    }

    wait randomintrange(3, 5);
  }
}

function_84cd2223(var_dbce0c44) {
  var_a87aeae6 = 30;
  var_a1737466 = randomfloatrange(0.02, 0.03);
  return min(var_a87aeae6, int(level.zombie_total * var_a1737466));
}

function_9471b7f9() {
  ai = function_2e37549f();

  if(isDefined(ai)) {
    level.zombie_total--;
    return true;
  }

  return false;
}

function_2e37549f(b_force_spawn = 0, var_eb3a8721, n_round_number) {
  if(!b_force_spawn && !function_96578f39()) {
    return undefined;
  }

  if(isDefined(var_eb3a8721)) {
    s_spawn_loc = var_eb3a8721;
  } else if(isDefined(level.var_29a8e07)) {
    s_spawn_loc = [[level.var_29a8e07]]();
  } else if(isDefined(level.zm_loc_types[#"bat_location"]) && level.zm_loc_types[#"bat_location"].size > 0) {
    s_spawn_loc = array::random(level.zm_loc_types[#"bat_location"]);
  }

  if(!isDefined(s_spawn_loc)) {
    return undefined;
  }

  ai = zombie_utility::spawn_zombie(level.bat_spawners[0], undefined, undefined, n_round_number);

  if(isDefined(ai)) {
    ai.check_point_in_enabled_zone = &zm_utility::check_point_in_playable_area;
    ai thread zombie_utility::round_spawn_failsafe();
    ai.origin = s_spawn_loc.origin;

    if(isDefined(s_spawn_loc.angles)) {
      ai.angles = s_spawn_loc.angles;
    }

    if(isDefined(level.var_d9334d8b)) {
      ai thread[[level.var_d9334d8b]](s_spawn_loc);
    }
  }

  return ai;
}

function_96578f39() {
  var_7d706b3f = function_2ffae59e();
  var_1a68bbce = function_133e1e25();

  if(!(isDefined(level.var_2b94ce72) && level.var_2b94ce72) && isDefined(level.var_15747fb1) && level.var_15747fb1 || var_7d706b3f >= var_1a68bbce || !level flag::get("spawn_zombies")) {
    return false;
  }

  return true;
}

function_133e1e25() {
  n_player_count = zm_utility::function_a2541519(level.players.size);

  switch (n_player_count) {
    case 1:
      return 3;
    case 2:
      return 5;
    case 3:
      return 7;
    case 4:
      return 10;
  }
}

function_2ffae59e() {
  var_e7a26429 = getaiarchetypearray(#"bat");
  var_7d706b3f = var_e7a26429.size;

  foreach(ai_bat in var_e7a26429) {
    if(!isalive(ai_bat)) {
      var_7d706b3f--;
    }
  }

  return var_7d706b3f;
}