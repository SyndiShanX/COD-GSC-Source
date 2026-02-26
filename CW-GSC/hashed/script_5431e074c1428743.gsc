/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_5431e074c1428743.gsc
***********************************************/

#using script_3626f1b2cf51a99c;
#using script_52da18c20f45c56a;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\bb;
#using scripts\cp_common\gametypes\battlechatter;
#using scripts\cp_common\ui\prompts;
#using scripts\cp_common\util;
#namespace namespace_9c83b58d;

function private autoexec __init__system__() {
  system::register(#"hash_7e93e9089f28804f", &preinit, undefined, undefined, #"actions");
}

function private preinit() {
  if(!isDefined(level.takedowns)) {
    function_5ac4dc99("<dev string:x38>", "<dev string:x4a>");

    function_5ac4dc99("<dev string:x4e>", 0);

    function_5ac4dc99("<dev string:x62>", 0);

    function_5ac4dc99("<dev string:x7a>", 0);

    function_5ac4dc99("<dev string:x92>", 0);

    level.takedowns = spawnStruct();
    level.takedowns.takedowns = [];
    level.takedowns.callbackoverride = [];
    function_4cb18218();
    animation::add_global_notetrack_handler("death", &function_64852b21, 0);
    animation::add_global_notetrack_handler("ragdoll", &function_caa295ea, 0);
    animation::add_global_notetrack_handler("start_ragdoll", &function_caa295ea, 0);
    actions::action_register("takedown", &function_69bc40d4);
    function_cd140ee9("player_useRadius", &function_c30fad9a);
    function_cd140ee9("ai_corpseSynch", &function_c30fad9a);

    function_cd140ee9("<dev string:xa3>", &function_c30fad9a);

    function_cd140ee9("<dev string:x4e>", &function_c30fad9a);

    function_cd140ee9("<dev string:x62>", &function_c30fad9a);

    function_cd140ee9("<dev string:x38>", &function_c30fad9a);

    function_cd140ee9("<dev string:x7a>", &function_c30fad9a);

    function_cd140ee9("<dev string:x92>", &function_c30fad9a);
  }
}

function private function_c30fad9a() {
  foreach(player in getplayers()) {
    if(!isDefined(player.takedown)) {
      player.takedown = spawnStruct();
    }

    if(!isDefined(player.takedown.victim)) {
      player.takedown.victim = [];
    }

    if(!isDefined(player.takedown.debug)) {
      player.takedown.debug = spawnStruct();
    }

    player.takedown.debug.debug_actions = getdvarint(#"debug_actions", 0) ? 1 : undefined;
    player.takedown.debug.var_e2adb106 = getdvarint(#"hash_65ef9879f3b39ad5", 0) ? 1 : undefined;
    player.takedown.debug.var_b47c9f89 = getdvarint(#"hash_38e86dc5164822fe", 0) ? 1 : undefined;
    player.takedown.debug.var_8dbd3c70 = getdvarint(#"hash_576712f5a0d594b3", 0) || getdvarint(#"debug_stealth", 0) ? 1 : undefined;

    if(is_true(player.takedown.debug.debug_actions)) {
      player thread actions::function_d661f822();
    } else {
      player notify(#"hash_2eaf8be0116c39a9");
    }

    player.takedown.var_70354814 = getdvarstring(#"hash_5ec5a0d2ff65ae51", "<dev string:x4a>");
    player thread function_ac7d52ad(player.takedown.debug.var_8dbd3c70);

    player.takedown.use_radius = getdvarfloat(#"player_useradius");
    player.takedown.ai_corpsesynch = getdvarint(#"ai_corpsesynch", 0);
  }
}

function private function_4cb18218() {
  var_223ffdd1 = getscriptbundlenames("takedown");

  foreach(bundle_name in var_223ffdd1) {
    level function_8528a766(bundle_name);
  }
}

function private function_8528a766(bundle_name) {
  takedown = getscriptbundle(bundle_name);

  if(!isDefined(takedown)) {
    return;
  }

  assert(takedown.type == "<dev string:xb4>");
  assert(isDefined(level.takedowns));
  var_1d5a6fd3 = spawnStruct();
  var_1d5a6fd3.scenes = [];

  if(isDefined(takedown.scenes)) {
    foreach(scene in takedown.scenes) {
      if(isDefined(scene.scene) && scene.scene != "") {
        var_1d5a6fd3.scenes[var_1d5a6fd3.scenes.size] = scene.scene;
      }
    }
  }

  if(var_1d5a6fd3.scenes.size > 0) {
    var_1d5a6fd3.name = takedown.name;
    var_1d5a6fd3.prompt = isDefined(takedown.prompt) ? takedown.prompt : undefined;
    var_1d5a6fd3.combat = is_true(takedown.combat) ? 1 : undefined;
    var_1d5a6fd3.var_72a597df = is_true(takedown.var_72a597df) ? 1 : undefined;
    var_1d5a6fd3.sprint = is_true(takedown.sprint) ? 1 : undefined;
    var_1d5a6fd3.notsprint = is_true(takedown.notsprint) ? 1 : undefined;
    var_1d5a6fd3.slide = is_true(takedown.slide) ? 1 : undefined;
    var_1d5a6fd3.notslide = is_true(takedown.notslide) ? 1 : undefined;

    if(isDefined(takedown.action)) {
      actions = strtok(takedown.action, " ,");

      foreach(actionname in actions) {
        var_1d5a6fd3.actions[actionname] = 1;
      }
    }

    var_1d5a6fd3.var_ad61bf60 = isDefined(takedown.yawrange) && takedown.yawrange < 180 ? anglesToForward((0, isDefined(takedown.yaw) ? takedown.yaw : 0, 0)) : undefined;
    var_1d5a6fd3.var_8f4fda5a = isDefined(takedown.yawrange) && takedown.yawrange < 180 ? cos(takedown.yawrange) : undefined;
    var_1d5a6fd3.var_4c067ed7 = isDefined(takedown.minrange) && takedown.minrange > 0 ? sqr(takedown.minrange) : undefined;
    var_1d5a6fd3.var_6465622a = isDefined(takedown.maxrange) ? sqr(takedown.maxrange) : undefined;
    var_1d5a6fd3.minheight = isDefined(takedown.minheight) ? takedown.minheight : undefined;
    var_1d5a6fd3.maxheight = isDefined(takedown.maxheight) ? takedown.maxheight : undefined;
    var_1d5a6fd3.trace = is_true(takedown.trace) ? 1 : undefined;
    var_1d5a6fd3.traceheight = is_true(takedown.trace) ? takedown.traceheight : undefined;
    var_1d5a6fd3.stancestand = is_true(takedown.stancestand) ? 1 : undefined;
    var_1d5a6fd3.stancecrouch = is_true(takedown.stancecrouch) ? 1 : undefined;
    var_1d5a6fd3.stanceprone = is_true(takedown.stanceprone) ? 1 : undefined;
    level.takedowns.takedowns[takedown.name] = var_1d5a6fd3;
    level.takedowns.maxrange = max(isDefined(level.takedowns.maxrange) ? level.takedowns.maxrange : 0, isDefined(takedown.maxrange) ? takedown.maxrange : 0);
    return;
  }

  assertmsg("<dev string:xc0>" + takedown.name + "<dev string:xcf>");
}

function private player_init() {
  assert(isPlayer(self));

  if(!isDefined(self.takedown)) {
    if(!isDefined(self.takedown)) {
      self.takedown = spawnStruct();
    }

    if(!isDefined(self.takedown.debug)) {
      self.takedown.debug = spawnStruct();
    }

    self.takedown.disabled = undefined;
    self.takedown.disable_drop = undefined;
    self.takedown.victim = [];
    function_c30fad9a();
  }
}

function private function_69bc40d4(action) {
  self endon(action.ender);
  self player_init();
  self thread function_e3bc3dc9(action);
  var_3f34aa83 = self actions::function_83bde308(action, "melee");

  if(is_true(var_3f34aa83)) {
    self actions::function_8488e359();
    return self function_3bab44ea(action);
  }

  return 0;
}

function function_3bab44ea(action, fullbody, var_a2ca14bc) {
  self endon(fullbody.ender);

  if(is_true(self.takedown.disabled)) {
    return false;
  }

  if(function_f8af9078(fullbody.name)) {
    return false;
  }

  if(isalive(self.takedown.victim[fullbody.name])) {
    victim = self.takedown.victim[fullbody.name];
    scene = self.takedown.scene[fullbody.name];

    if(isDefined(victim) && isDefined(scene)) {
      self notify("takedown_monitor_generic_" + fullbody.name);

      if(isDefined(level.takedowns.callbackoverride[fullbody.name])) {
        self thread[[level.takedowns.callbackoverride[fullbody.name]]]();
      } else {
        self thread function_7395fe24(fullbody, var_a2ca14bc, victim, scene);
      }

      return true;
    }
  }

  return false;
}

function function_7395fe24(action, fullbody, victim, scene) {
  self endoncallback(&function_cee18456, action.ender);

  if(!is_true(self.takedown.debug.var_b47c9f89)) {
    self function_7a061b23(0, undefined);
  }

  self.takedown.weapon = self getcurrentweapon();
  self.takedown.var_e62b225a = self action_utility::function_1a2a3654();
  self.takedown.start_origin = self.origin;
  self.in_melee_death = 1;
  self flag::set("in_action");
  self val::set(#"action", "takedamage", 0);

  if(!isalive(victim)) {
    self actions::function_942d9213();
    return;
  }

  if(isDefined(victim)) {
    self.takedown.attempt_victim = victim;
    victim notify(#"takedown_begin");
    victim.var_310c1596 = victim spawner::function_461ce3e9();
    victim action_utility::function_71180c30(1);
    victim prompts::remove(#"melee");
    victim util::remove_cursor_hint();
    victim.in_melee_death = 1;

    if(isDefined(level.var_ab828d57)) {
      victim util::delay(0.1, undefined, level.var_ab828d57);
    }

    victim ai::look_at(undefined, 0);
    victim util::delay(0.5, "takedown_executed", &action_utility::function_71180c30, 0);

    if(isDefined(level.var_b19e4f0a)) {
      victim util::delay(1, undefined, level.var_b19e4f0a, "ally_damaged", "ally_hurt_peripheral", self, 50, 500);
    }

    victim.animname = "generic";
  }

  self action_utility::function_b0190b65(action);
  self action_utility::function_c0f7b46e(fullbody, 1);
  self action_utility::function_e2fcacb2(10);

  if(actions::function_1028d928(action.name, "grab")) {
    self.takedown.var_67582ca5 = victim;
    self function_6940d001(action, scene, 0.25, "grab");
  }

  self thread function_7ef965ed(action);
  self function_7a061b23(1, undefined);
  victim thread function_970b3d76(action, scene, self);
}

function function_cee18456(parms) {
  if(parms == # "hash_20dda4a52ba67955") {
    self thread takedown_cleanup();
  }
}

function function_6940d001(action, scene, time, var_9386e7ce) {
  victim = self.takedown.victim[action.name];
  assert(isalive(victim));
  self action_utility::allow_weapon(0);
  scene_root = victim function_4c0949f2(self, scene);
  var_86b37828 = self.takedown.takedown[action.name].name;

  if(time > 0) {
    wait time;
  }

  self util::delay(0.2, undefined, &function_1c85708e);

  if(self actions::function_ae44e21b(action, "melee")) {
    if(isweapon(self.takedown.var_e62b225a)) {
      self action_utility::function_b56ad054();
      self actions::function_3af7d065(1, var_9386e7ce);
    }
  }
}

function function_1c85708e() {
  self.var_6639d45b action_utility::function_30b535ff(0);
}

function function_41abe76e(action) {
  assert(isPlayer(self));
  now = gettime();

  if((isDefined(self.takedown.var_e38a7cb3) ? self.takedown.var_e38a7cb3 : -1) == now) {
    return self.takedown.var_41abe76e;
  }

  self.takedown.var_41abe76e = 1;
  stance = self getstance();

  if(!isalive(self)) {
    self.takedown.var_41abe76e = 0;
  } else if(isDefined(self getlinkedent())) {
    self.takedown.var_41abe76e = 0;
  } else if(is_true(self.takedown.disabled)) {
    self.takedown.var_41abe76e = 0;
  } else if(stance == "prone") {
    self.takedown.var_41abe76e = 0;
  } else if(self isthrowinggrenade()) {
    self.takedown.var_41abe76e = 0;
  } else if(self getcurrentweapon().name == "none") {
    self.takedown.var_41abe76e = 0;
  } else if(stance !== "stand") {
    if(!self isstanceallowed("stand")) {
      self.takedown.var_41abe76e = 0;
    } else {
      startz = 5;
      endz = startz + 0.1;
      traceresult = playerphysicstrace(self.origin + (0, 0, startz), self.origin + (0, 0, endz));

      if(traceresult[2] < self.origin[2] + endz) {
        box(self.origin + (0, 0, startz), (-15, -15, 0), (15, 15, 70), 0, (1, 0, 0), 1, 1, 1);

        self.takedown.var_41abe76e = 0;
      }
    }
  }

  self.takedown.var_e38a7cb3 = now;
  return self.takedown.var_41abe76e;
}

function function_e3bc3dc9(action) {
  self notify("takedown_monitor_generic_" + action.name);
  self endoncallback(&function_7d4b1333, action.ender, #"death", #"disconnect", "takedown_monitor_generic_" + action.name);
  self.takedown.var_bf0ca7db[action.name] = 0;
  var_ac859813 = "take_down";

  if(isDefined(level.takedowns.var_ac859813) && isDefined(level.takedowns.var_ac859813[action.name])) {
    var_ac859813 = level.takedowns.var_ac859813[action.name];
  }

  while(true) {
    waitframe(1);

    if(isDefined(self.takedown.victim[action.name]) && self.takedown.allow_melee) {
      self function_db07e398(action.name, undefined);
    }

    if(level flag::get("hold_context_melee")) {
      self function_7a061b23(1, action.name);
      level flag::wait_till_clear("hold_context_melee");
    }

    if(!self function_41abe76e(action)) {
      self function_7a061b23(1, action.name);
      continue;
    }

    var_ebd06be2 = self function_5ca78f5a(action);

    if(isDefined(var_ebd06be2)) {
      self function_db07e398(action.name, var_ebd06be2[0]);
      self.takedown.scene[action.name] = var_ebd06be2[1];
      self.takedown.takedown[action.name] = var_ebd06be2[2];

      if(!self.takedown.var_bf0ca7db[action.name] && self.var_2cb06cc6.name == "root") {
        var_22a9143 = actions::function_1028d928(action.name, "grab");
        var_86b37828 = self.takedown.takedown[action.name].name;
        var_6e051 = self.takedown.takedown[action.name].prompt;
        self.takedown.victim[action.name] prompts::create(#"melee", var_6e051);
        self.takedown.victim[action.name] prompts::function_a4cf2cde({
          #tag: "j_spine4"});
        self.takedown.victim[action.name] prompts::function_92127496(1);
        self.takedown.victim[action.name] prompts::function_44d7831a(#"melee", 0);
        self.takedown.victim[action.name] prompts::function_8f5eb0a6(#"melee", 0);
        self.takedown.victim[action.name] prompts::function_d03d79d6(#"melee", 0);
        self.takedown.victim[action.name] prompts::function_4cb5d3a1(#"melee", 0);
        self.takedown.victim[action.name] prompts::function_dcf99fad(#"melee", 1);
        self.takedown.victim[action.name] prompts::function_3171730f(#"melee", #"actions");
        self.takedown.victim[action.name] prompts::function_68782902(#"melee", 1000);
        self.takedown.victim[action.name] prompts::function_b95d71cd(#"melee", 180);
        self.takedown.victim[action.name] prompts::create(#"melee_hold", #"hash_4759bc1b8324047c");
        self.takedown.victim[action.name] prompts::function_46df0bc7(#"melee", 5);
        self.takedown.victim[action.name] prompts::function_44d7831a(#"melee_hold", 0);
        self.takedown.victim[action.name] prompts::function_8f5eb0a6(#"melee_hold", 0.1);
        self.takedown.victim[action.name] prompts::function_d03d79d6(#"melee_hold", 0.2);
        self.takedown.victim[action.name] prompts::function_a4a9acfc(#"melee_hold", &function_3cadc363);
        self.takedown.victim[action.name] prompts::function_4cb5d3a1(#"melee_hold", 0);
        self.takedown.victim[action.name] prompts::function_dcf99fad(#"melee_hold", 1);
        self.takedown.victim[action.name] prompts::function_3171730f(#"melee_hold", #"actions");
        self.takedown.victim[action.name] prompts::function_68782902(#"melee_hold", 1000);
        self.takedown.victim[action.name] prompts::function_b95d71cd(#"melee_hold", 180);
        self thread takedown_prompt_monitor(action, var_86b37828);
        self.takedown.var_bf0ca7db[action.name] = 1;
      }

      self function_7a061b23(0, action.name);

      if(is_true(self.takedown.debug.debug_actions) && isentity(var_ebd06be2[0]) && isDefined(var_ebd06be2[1])) {
        debugstar(var_ebd06be2[0].origin + (0, 0, 30), 1, (1, 0, 0), var_ebd06be2[1], 0.1);
      }
    } else {
      self function_db07e398(action.name, undefined);
      self function_7a061b23(1, action.name);
    }

    foreach(key, value in self.takedown.victim) {
      if(!isDefined(value)) {
        self function_db07e398(key, undefined);
      }
    }
  }
}

function private function_3cadc363(prompt_struct) {
  assert(isPlayer(prompt_struct.player));

  if(self.player_actions.enabled[#"body_shield"] === 0) {
    return 0;
  }

  return isweapon(prompt_struct.player action_utility::function_1a2a3654());
}

function private function_7d4b1333(var_201c5b1f) {
  if(var_201c5b1f != # "death" && var_201c5b1f != # "disconnect") {
    self function_7a061b23(1, undefined);
  }
}

function takedown_prompt_monitor(action, var_d426470, var_72612ea0) {
  assert(isPlayer(self));
  self notify("takedown_prompt_monitor" + (isDefined(var_d426470) ? var_d426470 : "_") + (isDefined(var_72612ea0) ? var_72612ea0 : "_"));
  self endon("takedown_prompt_monitor" + (isDefined(var_d426470) ? var_d426470 : "_") + (isDefined(var_72612ea0) ? var_72612ea0 : "_"));
  self endon(action.ender);

  while(true) {
    if(!isDefined(self.takedown.victim) || self.takedown.victim.size == 0 || is_true(self.in_melee_death)) {
      self function_db07e398(action.name, undefined, self.in_melee_death);
      return;
    }

    waitframe(1);
  }
}

function function_146a3d56(enemy) {
  assert(isPlayer(self));
  return vectornormalize(enemy.var_97e2c0da.check_origin - self getplayercamerapos());
}

function function_5ca78f5a(action) {
  assert(isPlayer(self));
  now = gettime();
  result = undefined;

  if((isDefined(self.takedown.var_8630163b) ? self.takedown.var_8630163b : -1) != now) {
    self.takedown.potential_victims = function_e45cbe76(self.origin, level.takedowns.maxrange, "axis");
    self.takedown.var_8630163b = now;
  }

  if(self.takedown.potential_victims.size > 0) {
    fwd = anglesToForward(self getplayerangles());
    var_e3cd155d = vectornormalize((fwd[0], fwd[1], 0));
    playereye = self getplayercamerapos();
    best_dot = -1;

    foreach(enemy in self.takedown.potential_victims) {
      if(!isalive(enemy)) {
        continue;
      }

      if(is_true(enemy.var_c681e4c1)) {
        continue;
      }

      if(enemy.takedamage === 0) {
        continue;
      }

      if(enemy.species !== # "human") {
        continue;
      }

      if(enemy.player_actions.enabled[#"takedown"] === 0) {
        continue;
      }

      victim_scene = function_3c43bd2a(action, enemy, self);

      if(isDefined(enemy.var_7b026ceb)) {
        if(distance2dsquared(enemy.origin, self.origin) > sqr(enemy.var_7b026ceb)) {
          continue;
        }
      }

      if(isDefined(victim_scene.scene)) {
        dir = self function_146a3d56(enemy);
        dot = vectordot(fwd, dir);

        if(dot > best_dot) {
          best_dot = dot;

          if(isDefined(enemy.var_ab101371)) {
            victim_scene.scene = enemy.var_ab101371;
          } else if(isDefined(enemy.var_d3f0031c) || isDefined(enemy.var_59212ad0)) {
            var_ee55055 = -0.707107;
            victimfwd = anglesToForward(enemy.angles);
            playerdelta = vectornormalize(self.origin - enemy.origin);
            dot = vectordot(playerdelta, victimfwd);
            useprompt = # "hash_6a4c1594be34b79f";

            if(enemy.awarenesslevelcurrent != "combat") {
              useprompt = # "hash_6d8033f0ef3722c9";
            }

            if(isDefined(enemy.var_d3f0031c) && dot <= var_ee55055) {
              victim_scene.scene = enemy.var_d3f0031c;

              if(isDefined(enemy.var_4f8ed4b2) && isDefined(enemy.var_3e95b88f)) {
                useprompt = enemy.var_4f8ed4b2;
              }
            } else if(isDefined(enemy.var_59212ad0) && dot >= var_ee55055) {
              victim_scene.scene = enemy.var_59212ad0;

              if(isDefined(enemy.var_f535b314) && isDefined(enemy.var_3e95b88f)) {
                useprompt = enemy.var_f535b314;
              }
            }

            if(isDefined(enemy.var_3e95b88f.prompts) && isstruct(enemy.var_3e95b88f.prompts[#"melee"])) {
              enemy prompts::function_263320e2(#"melee", useprompt);
            }
          }

          if(isDefined(self.takedown.var_70354814) && self.takedown.var_70354814 != "<dev string:x4a>" && isDefined(getscriptbundle(self.takedown.var_70354814))) {
            victim_scene.scene = self.takedown.var_70354814;
          }

          result = [enemy, victim_scene.scene, victim_scene.takedown];
        }
      }
    }
  }

  return result;
}

function function_3c43bd2a(action, victim, player) {
  assert(isPlayer(player));
  assert(isai(victim));
  resultscene = undefined;
  var_bf2073bc = undefined;
  victim function_8c04a084(player);

  foreach(takedown in level.takedowns.takedowns) {
    validplayer = player function_be279d34(action, takedown, victim);

    if(validplayer) {
      validvictim = victim function_c943b729(action, takedown, player);

      if(validvictim) {
        resultscene = self function_945b4efe(takedown);
        var_bf2073bc = takedown;
        break;
      }
    }
  }

  return {
    #scene: resultscene, #takedown: var_bf2073bc
  };
}

function function_be279d34(action, takedown, enemy) {
  assert(isPlayer(self));
  assert(isDefined(takedown));

  if(isDefined(takedown.actions) && !is_true(takedown.actions[action.name])) {
    return false;
  }

  if((isDefined(self.health) ? self.health : 0) <= 0) {
    return false;
  }

  if(self isthrowinggrenade()) {
    return false;
  }

  if(is_true(self.takedown.debug.var_e2adb106)) {
    return false;
  }

  dir = self function_146a3d56(enemy);
  dir_2d = vectornormalize((dir[0], dir[1], 0));

  if(vectordot(dir_2d, anglesToForward((0, self getplayerangles()[1], 0))) < 0.7) {
    return false;
  }

  if(!is_true(takedown.sprint) && self issprinting()) {
    return false;
  }

  if(!is_true(takedown.notsprint) && !self issprinting()) {
    return false;
  }

  if(!is_true(takedown.slide) && self issliding()) {
    return false;
  }

  if(!is_true(takedown.notslide) && !self issliding()) {
    return false;
  }

  return true;
}

function function_c943b729(action, takedown, player) {
  assert(isactor(self));

  if(!(isDefined(takedown) && isDefined(player))) {
    return false;
  }

  if(isentity(self.vehicle)) {
    return false;
  }

  distsqr = distancesquared(player.origin, self.origin);
  combat = self function_2ae12730(player);

  if(!is_true(takedown.combat) && combat) {
    return false;
  }

  if(!is_true(takedown.var_72a597df) && !combat) {
    return false;
  }

  if(isDefined(takedown.var_4c067ed7) && distsqr < takedown.var_4c067ed7) {
    return false;
  }

  if(isDefined(takedown.var_6465622a) && distsqr > takedown.var_6465622a) {
    return false;
  }

  switch (blackboard::getstructblackboardattribute(self, "_stance")) {
    case # "stand":
      if(!is_true(takedown.stancestand)) {
        return false;
      }

      break;
    case # "crouch":
      if(!is_true(takedown.stancecrouch)) {
        return false;
      }

      break;
    case # "prone":
      if(!is_true(takedown.stanceprone)) {
        return false;
      }

      break;
    default:
      return false;
  }

  if(isDefined(takedown.var_ad61bf60) && isDefined(takedown.var_8f4fda5a)) {
    headfwd = anglestoright(self gettagangles("j_head")) * -1;
    feetfwd = anglesToForward(self.angles);
    bodyfwd = lerpvector(headfwd, feetfwd, 0.5);
    worlddir = rotatepoint(takedown.var_ad61bf60, (0, vectortoyaw(bodyfwd), 0));

    if(vectordot(worlddir, self.var_97e2c0da.var_fe50a481) < takedown.var_8f4fda5a) {
      return false;
    }
  }

  deltaz = self.origin[2] - player.origin[2];

  if(isDefined(takedown.minheight) && deltaz < takedown.minheight) {
    return false;
  }

  if(isDefined(takedown.maxheight) && deltaz > takedown.maxheight) {
    return false;
  }

  if(is_true(takedown.trace)) {
    zoffset = (0, 0, 24);

    if(isDefined(takedown.traceheight)) {
      zoffset = (0, 0, takedown.traceheight);
    }

    start = player.origin + zoffset;
    end = self.var_97e2c0da.check_origin + zoffset;
    radius = 0;
    trace = physicstrace(start, end, (radius * -1, radius * -1, radius * -1), (radius, radius, radius), self.var_a08ba405, 32 | 1, 32768 | 8388608);

    if(trace[#"fraction"] < 1) {
      if(is_true(player.takedown.debug.debug_actions)) {
        line(start, end, (0.8, 0.25, 0.25), 1, 1, 1);
      }

      return false;
    }
  }

  return true;
}

function function_a4e4cef5(action_name, player) {
  assert(isPlayer(player));

  if(!isDefined(self.var_234d269) || self.var_234d269 != gettime()) {
    self.var_b87cdd12 = 1;
    playerfwd = anglesToForward(player getplayerangles());
    playereye = player getplayercamerapos();
    delta = self getEye() - playereye;
    distclamp = math::clamp(distance(self getEye(), playereye) - 30, 0, 120);
    dotcheck = 0.5 + 0.44 * (distclamp / 150 - 30);

    if(vectordot(vectornormalize(delta), playerfwd) < dotcheck) {
      self.var_b87cdd12 = 0;
    }

    self.var_234d269 = gettime();
  }

  return self.var_b87cdd12;
}

function function_5169db86() {
  assert(isPlayer(self));

  if(isDefined(self.takedown.scene_root)) {
    return self.takedown.scene_root;
  }

  scene_root = spawnStruct();
  scene_root.origin = self.origin;
  scene_root.angles = self.angles;
  return scene_root;
}

function function_dce515a6(guy, modelname, var_cf230c0, attach_tag, var_5f373dfe, var_a18e300c, aitype) {
  assert(isPlayer(self));
  assert(isDefined(attach_tag) == isDefined(var_cf230c0));

  if(isDefined(attach_tag)) {
    assert(attach_tag.size == var_cf230c0.size);
  }

  if(!isDefined(aitype)) {
    aitype = guy.aitype;
  }

  if(!is_true(var_a18e300c)) {
    if(isalive(guy) && guy !== self.takedown.body) {
      if(isDefined(self.takedown.body) && !self.takedown.body action_utility::function_30b535ff(0)) {
        if(isDefined(self.takedown.body.magic_bullet_shield)) {
          self.takedown.body util::stop_magic_bullet_shield();
        }

        self.takedown.body delete();
        self.takedown.body = undefined;
      }

      self.takedown.body = guy;
    } else if(isDefined(self.takedown.body) && isDefined(modelname) && self.takedown.body.modelname !== modelname) {
      self.takedown.body setModel(modelname);
      self.takedown.body.modelname = modelname;
    }
  }

  if(!isDefined(self.takedown.body) || is_true(var_a18e300c)) {
    bodymodel = spawn("script_model", self.origin);
    bodymodel.angles = self.angles;
    bodymodel.team = "axis";
    bodymodel.animname = "generic";
    bodymodel setModel(modelname);
    bodymodel.modelname = modelname;
    bodymodel.ai_type = aitype;
    bodymodel action_utility::function_77af90aa(var_cf230c0, attach_tag);
    bodymodel useanimtree("generic");
    bodymodel action_utility::function_30b535ff(1);
    self.takedown.body = bodymodel;
  }

  if(isDefined(var_5f373dfe)) {}

  return self.takedown.body;
}

function function_4c0949f2(player, scene) {
  assert(isPlayer(player));
  entid = self getentitynumber();

  if(!isDefined(player.takedown.scene_root)) {
    player.takedown.scene_root = spawnStruct();
  }

  scene_root = player.takedown.scene_root;

  if(isDefined(self.var_1f1bd6ed)) {
    scene_root.origin = self.var_1f1bd6ed;
  } else if(isDefined(player.takedown.edge_origin[entid])) {
    scene_root.origin = player.takedown.edge_origin[entid];
  } else {
    scene_root.origin = self.origin;
  }

  if(isDefined(self.var_598a8a9)) {
    scene_root.angles = self.var_598a8a9;
  } else if(isDefined(player.takedown.edge_angles[entid])) {
    scene_root.angles = player.takedown.edge_angles[entid];
  } else {
    scene_root.angles = (0, vectortoyaw(scene_root.origin - player.origin), 0);
  }

  scene_root.scriptbundlename = scene;
  scene_root.script_play_multiple = 1;
  scene_root.script_ignore_active_scene_check = 1;
  return scene_root;
}

function function_970b3d76(action, scene, player) {
  if(isalive(self)) {
    if(self scene::function_c935c42()) {
      [[self._scene_object._o_scene]] - > stop();
    }

    self stopanimscripted();
  }

  if(!isalive(self)) {
    player actions::function_942d9213();
    return;
  }

  if(is_true(player.takedown.takedown[action.name].var_72a597df)) {
    player stats::function_dad108fa(#"hash_62a55a4c32087c2d", 1);
  }

  bb::function_cd497743("takedown", player);
  player endon(action.ender);
  self notify(#"start_context_melee");
  player flag::set("takedown_active");
  player notify(#"takedown_cleanup");
  self prompts::remove(#"melee_hold");
  self prompts::function_86eedc();
  waittillframeend();
  player thread actions::function_c004e236("carry_body");
  groundpos = util::ground_position(player.origin, 16, 64, player);
  player thread takedown_cleanup(action, [action.ender, "takedown_cleanup"], groundpos, player.takedown.stance[action.name]);
  scene_root = self function_4c0949f2(player, scene);
  player.var_edbc8698 = self;
  self.og_maxsightdistsqrd = self.maxsightdistsqrd;
  self.var_4285accc = self.newenemyreactiondistsq;
  self.og_battlechatter = self.battlechatter;
  self.og_allowdeath = self.allowdeath;
  self.allowantigrav = 0;
  self.dontmelee = 1;
  self.maxsightdistsqrd = 1;
  self.fixednode = 0;
  self.ignoreme = 1;
  self.ignoreall = 1;
  self.newenemyreactiondistsq = 0;
  self.allowdeath = 0;
  self.a.disablepain = 1;
  self.allowpain = 0;
  self battlechatter::function_2ab9360b(0);
  self.var_e690137d = scene;
  self.remove_from_animloop = 1;

  if(isDefined(level.var_e3f5eafc)) {
    self clientfield::set("spy_camera_remove_highlight", 1);
  }

  self notify(#"takedown_executed");

  if(isDefined(self) || isalive(self)) {
    self util::delay(5, "takedown_cleanup", &function_9e3a2c7f, self);
    scene_root action_utility::scene_play(scene, player, self);
    player thread action_utility::function_d76eed10(action);
    function_64852b21(self);
  }

  player notify(#"takedown_cleanup");
  player notify(#"hash_1c024a9ada1dc600");
  waitframe(1);
  player actions::function_942d9213();
  player action_utility::function_e2fcacb2(3);
  player flag::clear("in_action");
}

function function_7a061b23(enabled, action_name) {
  if(!isDefined(self.takedown.var_9871533)) {
    self.takedown.var_9871533 = [];
    self.takedown.var_d4da26de = 0;
    self.takedown.allow_melee = 1;
  }

  if(isDefined(action_name) && !isDefined(self.takedown.var_9871533[action_name])) {
    assert(self.takedown.var_9871533.size <= 31);
    self.takedown.var_9871533[action_name] = self.takedown.var_9871533.size;
  }

  bitmask = 0;

  if(isDefined(action_name)) {
    bitmask = 1 << self.takedown.var_9871533[action_name];
  } else {
    foreach(bitindex in self.takedown.var_9871533) {
      bitmask |= 1 << bitindex;
    }
  }

  if(enabled) {
    self.takedown.var_d4da26de &= ~bitmask;
  } else {
    self.takedown.var_d4da26de |= bitmask;
  }

  var_b381ae79 = !self.takedown.var_d4da26de;
  self.takedown.allow_melee = var_b381ae79;
  var_32d84328 = var_b381ae79;
  curweap = self getcurrentweapon();

  if(curweap.name == # "knife_loadout" && is_true(self.var_31df4786)) {
    var_32d84328 = 1;
  }

  if(is_true(self.takedown.var_f75c6733) == var_32d84328) {
    return;
  }

  if(!is_true(var_32d84328)) {
    self val::set(#"hash_791e389c6b7a4657", "allow_melee", 0);
  } else {
    self val::reset(#"hash_791e389c6b7a4657", "allow_melee");
  }

  self.takedown.var_f75c6733 = var_32d84328;
}

function function_f8af9078(action_name) {
  if(isDefined(action_name)) {
    if(!isDefined(self.takedown.var_9871533) || !isDefined(self.takedown.var_9871533[action_name])) {
      return true;
    }

    bitmask = 1 << self.takedown.var_9871533[action_name];
    return ((self.takedown.var_d4da26de &bitmask) == 0);
  }

  return self.takedown.var_d4da26de == 0;
}

function function_64852b21(guy) {
  if(!isDefined(guy)) {
    return;
  }

  player = getplayers()[0];
  guy.skipdeathanim = 1;
  guy.noragdoll = 1;
  guy pushplayer(0);
  guy thread action_utility::function_91639a4c(0);

  if(isDefined(level.var_ab828d57)) {
    guy util::delay(0.1, undefined, level.var_ab828d57);
  }

  guy.allowdeath = 1;
  guy.diequietly = 1;
  guy util::stop_magic_bullet_shield();

  if(isDefined(guy.stealth)) {
    guy.stealth.override_damage_auto_range = 60;
  }

  if(isalive(guy)) {
    guy kill((0, 0, 0), player, player);
  }

  if(!is_true(guy.var_caa295ea) && isDefined(player.takedown) && isDefined(guy.origin)) {
    player.takedown.kill_origin = guy.origin;
  }
}

function function_caa295ea(guy) {
  player = getplayers()[0];

  if(!isDefined(guy) && isDefined(player.takedown.kill_origin)) {
    foreach(corpse in getcorpsearray(player.origin, 500)) {
      if(is_true(corpse.var_caa295ea)) {
        continue;
      }

      if(corpse isragdoll()) {
        continue;
      }

      corpseorigin = corpse.origin;

      if(is_true(player.takedown.ai_corpsesynch)) {
        corpseorigin = corpse getcorpsephysicsorigin();
      }

      if(isDefined(corpseorigin) && distancesquared(corpseorigin, player.takedown.kill_origin) < sqr(60)) {
        corpse startragdoll();
        corpse.var_caa295ea = 1;
      }
    }
  } else if(isDefined(guy) && !is_true(guy.var_caa295ea)) {
    if(isai(guy)) {}

    guy startragdoll();
    guy.var_caa295ea = 1;
  }

  player.takedown.kill_origin = undefined;
}

function function_8c04a084(player) {
  now = gettime();

  if((isDefined(self.var_9959f16e) ? self.var_9959f16e : -1) != now) {
    if(!isDefined(self.var_97e2c0da)) {
      self.var_97e2c0da = {};
    }

    tag = "tag_origin";
    tagangles = self gettagangles(tag);
    tagpos = self gettagorigin(tag);
    tagright = anglestoright(tagangles);
    tagfwd = anglesToForward(tagangles);
    var_b6db82af = player.origin - tagpos;
    var_b6db82af = (var_b6db82af[0], var_b6db82af[1], 0);
    var_b6db82af = vectornormalize(var_b6db82af);
    dotup = abs(vectordot(tagfwd, (0, 0, 1)));

    if(dotup > 0.7) {
      tagfwd = vectornormalize((tagright[0], tagright[1], 0));
    } else {
      tagfwd = vectornormalize((tagfwd[0], tagfwd[1], 0));
    }

    entfwd = anglesToForward(self.angles);

    if(vectordot(var_b6db82af, entfwd) > vectordot(tagfwd, entfwd)) {
      tagfwd = entfwd;
    }

    tagright = vectorcross(tagfwd, (0, 0, 1));
    self.var_97e2c0da.var_fe50a481 = var_b6db82af;
    self.var_97e2c0da.dot_forward = vectordot(tagfwd, var_b6db82af);
    self.var_97e2c0da.dot_right = vectordot(tagright, var_b6db82af);
    self.var_97e2c0da.height = self.origin[2] - player.origin[2];
    self.var_97e2c0da.height_abs = abs(self.var_97e2c0da.height);
    self.var_97e2c0da.check_origin = self gettagorigin(tag);
    self.var_97e2c0da.distsq = distancesquared(self.var_97e2c0da.check_origin, player getplayercamerapos());
    self.var_9959f16e = now;
  }

  return self.var_97e2c0da;
}

function function_945b4efe(takedown, advance) {
  assert(isPlayer(self));

  if(!isDefined(self.takedown.scene_deck)) {
    self.takedown.scene_deck = [];
  }

  if(!isDefined(self.takedown.scene_deck[takedown.name]) || self.takedown.scene_deck[takedown.name].size == 0) {
    if(isDefined(takedown.scenes)) {
      self.takedown.scene_deck[takedown.name] = array::randomize(arraycopy(takedown.scenes));
    }
  }

  deck = self.takedown.scene_deck[takedown.name];

  if(!isDefined(deck)) {
    return undefined;
  }

  result = deck[deck.size - 1];

  if(is_true(advance)) {
    deck[deck.size - 1] = undefined;
  }

  return result;
}

function takedown_cleanup(action, var_949a9f8b, originalorigin, var_d8ba335a) {
  self notify(#"hash_7ef80ca5708348b8");
  self endon(#"hash_7ef80ca5708348b8");
  assert(isPlayer(self));

  if(isDefined(originalorigin)) {
    if(!isarray(originalorigin)) {
      originalorigin = [originalorigin];
    }

    self waittill(originalorigin);
  }

  self action_utility::function_44a46209(var_d8ba335a);
  self val::reset_all(#"action");
  var_8bd3d2f2 = self.takedown.attempt_victim;

  if(isalive(var_8bd3d2f2) && isDefined(var_8bd3d2f2.var_310c1596) && !self flag::get("body_shield_active")) {
    var_8bd3d2f2 thread spawner::go_to_node(var_8bd3d2f2.var_310c1596);
    var_8bd3d2f2.var_310c1596 = undefined;
  }

  if(isalive(self.var_edbc8698) && !is_true(self.var_edbc8698.var_69defa17)) {
    self.var_edbc8698 stopanimscripted();
    self.var_edbc8698 kill(self.origin, self, self);
    self.var_edbc8698 = undefined;
  }

  if(isDefined(var_949a9f8b)) {
    self function_945b4efe(self.takedown.takedown[var_949a9f8b.name], 1);
  }

  self.in_melee_death = undefined;
  self flag::clear("takedown_active");
}

function function_9e3a2c7f(guy) {
  if(isDefined(guy)) {
    if(isalive(guy)) {
      if(isDefined(guy.magic_bullet_shield)) {
        guy util::stop_magic_bullet_shield();
      }

      println("<dev string:xe8>");
    }
  }
}

function function_7ef965ed(action) {
  self waittill(action.ender);
  self function_7a061b23(1, action.name);
  self function_db07e398(action.name, undefined);
}

function function_db07e398(action_name, new_victim, var_c9453f35) {
  if(isDefined(self.takedown.victim[action_name]) && self.takedown.victim[action_name] !== new_victim) {
    self.takedown.victim[action_name] prompts::remove(#"melee");

    if(!is_true(var_c9453f35)) {
      self.takedown.victim[action_name] prompts::remove(#"melee_hold");
    }

    self.takedown.var_bf0ca7db[action_name] = 0;
  }

  self.takedown.victim[action_name] = new_victim;
}

function function_a3b724c6(force_silent) {
  assert(isPlayer(self));

  if(!isDefined(self.takedown)) {
    self.takedown = {};
  }

  self.takedown.force_silent = is_true(force_silent) ? 1 : undefined;
}

function function_2ae12730(player) {
  assert(isPlayer(player));
  assert(isactor(self));

  if(is_true(player.takedown.force_silent)) {
    return false;
  }

  return self.awarenesslevelcurrent == "combat";
}

function private function_ac7d52ad(show) {
  self notify("<dev string:x13b>");
  self endon("<dev string:x13b>");
  self endon(#"death", #"disconnect");

  if(!is_true(show)) {
    return;
  }

  color = (1, 1, 0);
  found_color = (0.9, 0, 0);

  while(true) {
    waitframe(1);
    corpses = [];

    if(isDefined(level.fngetcorpsearrayfunc)) {
      corpses = [[level.fngetcorpsearrayfunc]]();
    } else {
      corpses = getentarraybytype(17);
    }

    guys = getactorteamarray("<dev string:x14f>");

    foreach(corpse in corpses) {
      corpseorigin = corpse getcorpsephysicsorigin();
      var_1157b993 = corpse function_6c7f19df();

      if(isDefined(level.stealth)) {
        if(isDefined(level.stealth.additional_corpse) && isDefined(level.stealth.additional_corpse[self getentitynumber()])) {
          corpseorigin = corpse.origin;
        }
      }

      line(corpse.origin, corpseorigin);
      print3d(corpseorigin, "<dev string:x157>", (1, 1, 1), 1, 0.25, 1, 1);
      line(corpse.origin, var_1157b993);
      print3d(var_1157b993, "<dev string:x161>", (1, 1, 1), 1, 0.25, 1, 1);
      print3d(corpse.origin + (0, 0, 10), "<dev string:x169>", (1, 1, 1), 1, 0.25, 1, 1);

      if(isDefined(corpse.found)) {
        print3d(corpseorigin + (0, 0, 20), "<dev string:x173>");
      }

      if(isDefined(level.stealth.corpse.dists)) {
        foreach(guy in guys) {
          if(!isDefined(guy.stealth)) {
            continue;
          }

          if(!isDefined(guy.fnisinstealthcombat) || guy[[guy.fnisinstealthcombat]]()) {
            continue;
          }

          dist = distancesquared(corpseorigin, guy.origin);

          if(dist < sqr(level.stealth.corpse.dists[#"detect_dist"])) {
            line(guy.origin, corpseorigin, found_color);
            continue;
          }

          if(dist < sqr(level.stealth.corpse.dists[#"sight_dist"])) {
            line(guy.origin, corpseorigin, color);
          }
        }
      }
    }
  }
}