/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_3072532951b5b4ae.gsc
***********************************************/

#using script_6f8610e78fdd3440;
#using scripts\core_common\ai\archetype_human;
#using scripts\core_common\ai\archetype_human_locomotion;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flashlight;
#using scripts\core_common\math_shared;
#using scripts\core_common\smart_object;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\stealth\callbacks;
#using scripts\core_common\stealth\corpse;
#using scripts\core_common\stealth\debug;
#using scripts\core_common\stealth\enemy;
#using scripts\core_common\stealth\event;
#using scripts\core_common\stealth\friendly;
#using scripts\core_common\stealth\group;
#using scripts\core_common\stealth\neutral;
#using scripts\core_common\stealth\tac;
#using scripts\core_common\stealth\threat_sight;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\util_shared;
#namespace namespace_77fd5d41;

function scalevolume(ent, vol) {}

function main() {
  function_5ac4dc99("<dev string:x38>", 0);
}

function initstealthfunctions() {
  self.var_d26a48de = &function_e5b8ad1b;
  self.fnsetstealthstate = &setstealthstate;
  self.fnisinstealthidle = &isidle;
  self.fnisinstealthinvestigate = &isinvestigating;
  self.fnisinstealthhunt = &ishunting;
  self.fnisinstealthcombat = &iscombating;
  self.fnstealthupdatevisionforlighting = &updatevisionforlighting;
  self.fnclearstealthvolume = &clearstealthvolume;
  self.fnstealthmusictransition = undefined;
  self.fnupdatelightmeter = undefined;
  self.fnstealthgotonode = &spawner::go_to_node;
  self.var_d28ad254 = &function_36915a04;
  self.var_40dd40ac = &function_7653ca27;
  self.var_ee308dc1 = &function_bf263c90;
  self.var_728f218b = &function_ffdd3cba;
  self.var_e892f39b = &function_589cf326;
  self.bt = spawnStruct();
  self.bt.instancedata = [];
}

function gettaskid(newtask, layer = "task") {
  if(!isDefined(self.bt.taskid)) {
    self.bt.taskid = [];
  }

  if(!isDefined(self.bt.taskid[layer])) {
    if(is_true(newtask)) {
      self.bt.taskid[layer] = 0;
    } else {
      return undefined;
    }
  }

  if(is_true(newtask)) {
    self.bt.taskid[layer]++;
  }

  return self.unique_id + "_" + layer + self.bt.taskid[layer];
}

function ifinstealth(behaviortreeentity) {
  if(!isDefined(self.stealth)) {
    return false;
  }

  if(self.team == "allies") {
    return false;
  }

  if(self.stealth.bsmstate == 3) {
    return false;
  }

  return true;
}

function function_ba0a486b(behaviortreeentity) {
  return gettime() - behaviortreeentity.damagetime <= function_60d95f53();
}

function isidle() {
  return isDefined(self.stealth) && self.stealth.bsmstate == 0;
}

function isinvestigating() {
  return isDefined(self.stealth) && self.stealth.bsmstate == 1;
}

function ishunting() {
  return isDefined(self.stealth) && self.stealth.bsmstate == 2;
}

function iscombating() {
  return isDefined(self.stealth) && self.stealth.bsmstate == 3;
}

function function_9a6e96bd(behaviortreeentity) {
  function_11d3f42d(behaviortreeentity);
  function_3031f40e(behaviortreeentity);
}

function function_4fff0007(behaviortreeentity) {
  function_242c2d67(behaviortreeentity);
  function_bd5f9968(behaviortreeentity);
}

function function_3031f40e(behaviortreeentity) {
  behaviortreeentity.keepclaimednode = 1;

  if(self flashlight::function_47df32b8()) {
    self flashlight::function_7db73593();
  }
}

function function_242c2d67(behaviortreeentity) {
  behaviortreeentity.keepclaimednode = 0;
}

function function_11d3f42d(behaviortreeentity) {
  behaviortreeentity.stealth.reacting = 1;

  if(!is_true(self.stealth.var_527ef51c)) {
    self.stealth.var_7f670ead = 1;
  }
}

function function_bd5f9968(behaviortreeentity) {
  behaviortreeentity.stealth.reacting = undefined;
  self.stealth.var_7f670ead = undefined;
  behaviortreeentity notify(#"hash_22ca87c523f21d6d");
}

function function_3b8bcbc7(behaviortreeentity) {
  if(self.team == "axis") {
    return true;
  }

  return false;
}

function stealth_shouldfriendly(behaviortreeentity) {
  if(self.team == "allies") {
    return true;
  }

  return false;
}

function stealth_initfriendly(behaviortreeentity) {
  self namespace_32a4062b::main();
  return true;
}

function stealth_terminatefriendly(behaviortreeentity) {
  self.stealth = undefined;
}

function stealth_shouldneutral(behaviortreeentity) {
  if(self.team == "neutral") {
    return true;
  }

  return false;
}

function stealth_initneutral(behaviortreeentity) {
  self namespace_578db516::main();
  return true;
}

function isinlight(lightvalue) {
  if(!isDefined(lightvalue)) {
    return !is_true(level.is_dark);
  }

  return lightvalue >= 0.5;
}

function updatevisionforlighting() {}

function function_6a7ad1cf(behaviortreeentity) {
  if(is_true(self.flashlight.transition)) {
    if(!isDefined(self.var_3ed929ba) && self getblackboardattribute("_flashlight") === "flashlight_out") {
      foreach(player in getplayers()) {
        if(self getthreatsight(player) > 0) {
          return false;
        }
      }
    }

    return true;
  }

  return false;
}

function function_dcb14105(behaviortreeentity) {
  if(is_true(self.flashlight.out)) {
    if(isalive(self)) {
      self setblackboardattribute("_flashlight", "flashlight_out");

      if(isDefined(self.var_710f0e6e)) {
        self[[self.var_710f0e6e]](1);
      }
    }
  } else {
    self setblackboardattribute("_flashlight", "flashlight_stow");

    if(isDefined(self.fnstealthflashlightdetach)) {
      self[[self.fnstealthflashlightdetach]]();
    }
  }

  self.flashlight.transition = undefined;
}

function stealth_enemy_getbsmstate(behaviortreeentity) {
  switch (self.stealth.bsmstate) {
    case 0:
      return "Stealth_Idle";
    case 1:
      return "Stealth_Investigate";
    case 2:
      return "Stealth_Hunt";
    case 3:
      return "Stealth_Combat";
  }
}

function stealth_reacter_updateeveryframe(behaviortreeentity) {
  if(self.stealth.var_4df71901 === gettime()) {
    return true;
  }

  self stealth_enemy::proximity_check();

  switch (self.stealth.bsmstate) {
    default:
      idle_update(self);
      break;
  }

  self.stealth.var_4df71901 = gettime();
  return true;
}

function stealth_enemy_updateeveryframe(behaviortreeentity) {
  if(self.stealth.var_4df71901 === gettime()) {
    return true;
  }

  var_e8c7dd7e = level flag::get("react_to_dynolights");

  if(var_e8c7dd7e && !isDefined(self.lightmeter)) {
    namespace_979752dc::update_light_meter();
    var_e8c7dd7e = 0;
  }

  self updatelightbasedflashlight(self.stealth.bsmstate, 0.5);

  if(var_e8c7dd7e) {
    entnum = self getentitynumber();
    frametime = level.frameduration;
    assert(isDefined(frametime));

    if(gettime() / frametime % 5 == entnum % 5) {
      namespace_979752dc::update_light_meter();
    }
  }

  self function_d19483ee();
  self namespace_cc4354b9::corpse_sight();
  self ai::look_at(self.cqb_target);
  return stealth_reacter_updateeveryframe(behaviortreeentity);
}

function stealth_neutral_updateeveryframe(behaviortreeentity) {
  return stealth_reacter_updateeveryframe(behaviortreeentity);
}

function function_55c47950(var_7a44d7c, event) {
  if(self ai::has_behavior_attribute("stealth")) {
    switch (event) {
      case 0:
        self.awarenesslevelcurrent = "unaware";
        self ai::set_behavior_attribute("stealth", 1);
        break;
      case 1:
        self.awarenesslevelcurrent = "low_alert";
        self ai::set_behavior_attribute("stealth", 1);
        break;
      case 2:
        self.awarenesslevelcurrent = "high_alert";
        self ai::set_behavior_attribute("stealth", 1);
        break;
      case 3:
        self.awarenesslevelcurrent = "combat";
        self ai::set_behavior_attribute("stealth", 0);
        break;
    }
  }
}

function enterstealthstate(var_7a44d7c, event) {
  exitstealthstate(self.stealth.bsmstate);

  if(self.stealth.bsmstate !== var_7a44d7c) {
    self.stealth.var_9b6cd53f = gettime();
  }

  self.stealth.bsmstate = var_7a44d7c;
  self function_55c47950(var_7a44d7c, event);

  switch (var_7a44d7c) {
    case 0:
      idle_init(self);
      break;
    case 1:
      investigate_init();
      break;
    case 2:
      hunt_init();
      break;
    case 3:
      combat_init();
      break;
  }
}

function exitstealthstate(var_7a44d7c) {
  switch (var_7a44d7c) {
    case 0:
      idle_terminate(self);
      break;
    case 1:
      investigate_terminate();
      break;
    case 2:
      hunt_terminate();
      break;
    case 3:
      combat_terminate();
      break;
  }
}

function isdonewithsearchmove(instancedata) {
  curtime = gettime();

  if(curtime > instancedata.starttime + 500 && (!isDefined(self.pathgoalpos) || distance2dsquared(self.pathgoalpos, self.origin) < 4) && !self.isarriving && !isDefined(self.ai.doortoopen)) {
    if(!isDefined(self.stealth.var_627b2039)) {
      return true;
    }

    var_16922a23 = self.stealth.var_627b2039;

    if(!isvec(var_16922a23)) {
      var_16922a23 = var_16922a23.origin;
    }

    if(distance2dsquared(self.origin, var_16922a23) < 3600 && sqr(var_16922a23[2] - self.origin[2]) < 5184) {
      return true;
    }

    if(!isDefined(instancedata.numfails)) {
      instancedata.numfails = 0;
    }

    instancedata.numfails++;
    instancedata.starttime = curtime;

    if(instancedata.numfails >= 10) {
      return true;
    }
  }

  return false;
}

function private function_d19483ee() {
  entnum = self getentitynumber();
  range = isDefined(self.var_1c936867) ? self.var_1c936867 : 850;
  cosfov = 0.866;

  foreach(player in getplayers()) {
    if(!isDefined(player.stealth)) {
      continue;
    }

    if(!isDefined(player.stealth.var_f6c2537d)) {
      player.stealth.var_f6c2537d = [];
    }

    player.stealth.var_f6c2537d[entnum] = undefined;

    if(range <= player.maxvisibledist && self flashlight::function_51dea76e(player)) {
      player.stealth.var_f6c2537d[entnum] = self;
    }

    arrayremovevalue(player.stealth.var_f6c2537d, undefined, 1);
  }
}

function private function_7c7868e8() {
  if(ishunting()) {
    return self flashlight::function_3aec1b7();
  }

  return self flashlight::function_b8090745();
}

function updatelightbasedflashlight(state, var_2fd642f) {
  if(self isinscriptedstate()) {
    return;
  }

  if(gettime() == self.stealth.starttime) {
    return;
  }

  lightmeter = self.lightmeter;

  if(getdvarint(#"hash_55b967be4d026006", 0)) {
    lightmeter = 0;
  }

  var_3b69096c = self function_7c7868e8();
  var_4da08689 = var_3b69096c;

  if(isDefined(self.flashlightoverride)) {
    var_4da08689 = self.flashlightoverride;
  } else if(is_true(self.noflashlight)) {
    var_4da08689 = 0;
  } else if(isDefined(lightmeter)) {
    var_86c3b867 = 0.1;

    if(var_3b69096c) {
      if(lightmeter > var_2fd642f + var_86c3b867) {
        var_4da08689 = 0;
      }
    } else {
      var_4da08689 = lightmeter < var_2fd642f;
    }
  } else {
    var_4da08689 = is_true(level.is_dark);
  }

  if(self flag::get("flashlight_on")) {
    var_4da08689 = 1;
  } else if(self flag::get("flashlight_off")) {
    var_4da08689 = 0;
  }

  if(var_3b69096c != var_4da08689) {
    if(ishunting()) {
      self flashlight::function_8d59ee47(var_4da08689);
      return;
    }

    self flashlight::function_9b7441d1(var_4da08689);
  }
}

function idle_updatestyle(instancedata) {
  self stealth_enemy::setpatrolstyle_base();
  instancedata.nextstylechecktime = gettime() + randomintrange(500, 2000);

  if(isDefined(self.stealth.patrol_moveplaybackrate)) {
    self.moveplaybackrate = self.stealth.patrol_moveplaybackrate;
    return;
  }

  self.moveplaybackrate = 1;
}

function function_efc17e1a(behaviortreeentity) {
  codegoal = self function_4794d6a3();

  if(isDefined(codegoal.goalangles) && !self haspath() && (self ai::get_behavior_attribute("demeanor") === "patrol" || self ai::get_behavior_attribute("demeanor") === "alert")) {
    if(absangleclamp180(self.angles[1] - codegoal.goalangles[1]) > 45) {
      return true;
    }
  }

  return false;
}

function function_fe3c7909(behaviortreeentity) {
  return function_6f8594d4(50);
}

function function_6f8594d4(var_b7d36d34) {
  if(isDefined(self.stealth.corpse.ent) && distancesquared(self.stealth.corpse.ent.origin, self.origin) < sqr(var_b7d36d34)) {
    if(!is_true(self.stealth.corpse.ent.var_f03da639)) {
      self.stealth.corpse.ent.var_f03da639 = 1;
      return true;
    }
  }

  return false;
}

function function_ff473d5(behaviortreeentity) {
  if(!btapi_shouldarriveexposed(behaviortreeentity)) {
    return false;
  }

  return function_6f8594d4(100);
}

function function_26e16543(behaviortreeentity) {
  return is_true(self.stealth.bidlecurious);
}

function function_6c404960(behaviortreeentity) {
  if(function_5bfdfc9d()) {
    return false;
  }

  if(self stealth_shouldinvestigate(behaviortreeentity) || self stealth_shouldhunt(behaviortreeentity)) {
    if(self function_efc17e1a(behaviortreeentity)) {
      return false;
    }

    return true;
  }

  return false;
}

function function_96903634(behaviortreeentity) {
  return is_true(self.stealth.var_ca926557);
}

function function_ffdd3cba(mode, target, tag, duration, sethealth, ignorefirstshotwait) {
  if(namespace_979752dc::get_stealth_state() != "normal") {
    return false;
  }

  self.stealth.var_ca926557 = 1;
  self thread function_d346f1cf();
  return true;
}

function function_d346f1cf() {
  self notify("b478fa11a5368c9");
  self endon("b478fa11a5368c9");
  self endon(#"death", #"stop_shoot_at_target");
  level waittill(#"stealth_event");
  self ai::stop_shoot_at_target();
}

function function_589cf326(target) {
  self.stealth.var_ca926557 = 0;
}

function function_e73fe99(behaviortreeentity) {
  if(!isDefined(self.stealth)) {
    return false;
  }

  if(self.awarenesslevelcurrent !== "unaware") {
    self.stealth.var_e39ea5e7 = undefined;
  }

  if(is_true(self.stealth.var_e39ea5e7)) {
    return true;
  }

  return false;
}

function function_5db27177(behaviortreeentity) {
  self.stealth.var_e39ea5e7 = undefined;
}

function idle_updatecurious(behaviortreeentity) {
  target = undefined;
  var_d37db7af = 0;

  foreach(player in getplayers()) {
    threatsight = self getthreatsight(player);

    if(!isDefined(target) || threatsight > var_d37db7af) {
      target = player;
      var_d37db7af = threatsight;
    }
  }

  threatsight = var_d37db7af;
  var_85153501 = 0.25;

  if(self.stealth.bidlecurious) {
    var_9f0689a6 = 2000;

    if(threatsight >= var_85153501) {
      self.stealth.curiousstarttime = gettime();
    }

    if(gettime() > self.stealth.curiousstarttime + var_9f0689a6) {
      if(threatsight < var_85153501 * 0.9) {
        self.stealth.bidlecurious = 0;
        self.stealth.idlecurioustarget = undefined;
      }
    }

    return;
  }

  if(threatsight >= var_85153501 && !is_true(self.stealth.bidlecurious) && ai::function_5e5653d3()) {
    self.stealth.bidlecurious = 1;
    self.stealth.idlecurioustarget = target;
    self.stealth.curiousstarttime = gettime();
    self namespace_979752dc::set_patrol_react(target.origin, "small");
  }
}

function updatesightstate(sightstate) {
  assert(!iscombating());

  if(level flag::get("stealth_spotted")) {
    sightstate = "hunt";
  }

  var_839ed558 = !isDefined(self.stealth.threat_sight_state);

  if(!var_839ed558) {
    switch (self.stealth.threat_sight_state) {
      case # "combat_hunt":
        var_839ed558 = sightstate != "hunt" && sightstate != "combat_hunt";
        break;
      case # "spotted":
        var_839ed558 = sightstate != "combat" && sightstate != "spotted";
        break;
      case # "hidden":
        var_839ed558 = sightstate != "idle" && sightstate != "unaware" && sightstate != "hidden";
        break;
      default:
        var_839ed558 = self.stealth.threat_sight_state != sightstate;
        break;
    }
  }

  if(var_839ed558) {
    self stealth_enemy::set_sight_state(sightstate);
  }
}

function idle_init(behaviortreeentity) {
  taskid = behaviortreeentity gettaskid(1, "idle");
  self.bt.instancedata[taskid] = spawnStruct();
  self.favoriteenemy = undefined;
  self.dontattackme = 1;
  self.shootposoverride = undefined;
  self.stealth.reachedinvestigate = 0;
  self thread namespace_cc4354b9::corpse_clear();
  idle_updatestyle(self.bt.instancedata[taskid]);
  self.combatmode = "no_cover";

  foreach(player in getplayers()) {
    if(!isDefined(player.stealth)) {
      continue;
    }

    if(!isDefined(player.stealth.spotted_list)) {
      continue;
    }

    player.stealth.spotted_list[self.unique_id] = undefined;
  }

  self.diequietly = 1;
  self clearenemy();
  self.stealth.bidlecurious = 0;
  self.bt.instancedata[taskid].curiousstarttime = -1;
  self thread stealth_enemy::set_alert_level("reset");
  self stealth_event::event_escalation_clear();

  if(isDefined(self.stealth.funcs[# "hidden"])) {
    self namespace_b2b86d39::stealth_call_thread("hidden");
  }

  if(isDefined(self.stealth.last_goal)) {
    if(isDefined(self.fnstealthgotonode) && isDefined(self.stealth.last_goal)) {
      if(!isvec(self.stealth.last_goal)) {
        self thread[[self.fnstealthgotonode]](self.stealth.last_goal);
      } else {
        self namespace_979752dc::set_goal(self.stealth.last_goal, undefined, 32);
      }
    }
  }

  self.gunposeoverride_internal = "gun_down";
}

function idle_update(behaviortreeentity) {
  self endon(#"idle_terminate");
  taskid = behaviortreeentity gettaskid(0, "idle");

  if(is_true(self.stealth.blind)) {
    self updatesightstate("blind");
  } else {
    self updatesightstate("hidden");
  }

  if(isDefined(self.stealth.active_sense_funcs)) {
    foreach(func in self.stealth.active_sense_funcs) {
      self[[func]]();
    }
  }

  curtime = gettime();

  if(curtime >= self.bt.instancedata[taskid].nextstylechecktime) {
    idle_updatestyle(self.bt.instancedata[taskid]);
  }

  idle_updatecurious(self.bt.instancedata[taskid]);
  self function_f7659f0d();
  return true;
}

function idle_terminate(behaviortreeentity) {
  self notify(#"idle_terminate");
  taskid = behaviortreeentity gettaskid(0, "idle");
  self.diequietly = 0;
  self.stealth.bidlecurious = undefined;
  self.stealth.idlecurioustarget = undefined;
  self.stealth.var_667f860f = undefined;
  self.stealth.var_46f4d537 = undefined;

  if(self.stealth.bsmstate != 1) {
    self.cqb_target = undefined;
  }

  self namespace_979752dc::save_last_goal();
  self.last_set_goalnode = undefined;
  self.last_set_goalent = undefined;
  self.moveplaybackrate = 1;
  self.bt.instancedata[taskid] = undefined;
}

function function_f7659f0d() {
  if(self.stealth.bidlecurious && isDefined(self.stealth.idlecurioustarget)) {
    self.cqb_target = self lastknownpos(self.stealth.idlecurioustarget);
    return;
  }

  var_26b3b46a = 0;

  foreach(player in getplayers()) {
    threat = self getthreatsight(player);

    if(threat > 0.1) {
      self.cqb_target = self lastknownpos(player);
      var_26b3b46a = 1;
      break;
    }
  }

  if(!var_26b3b46a) {
    self.cqb_target = undefined;
  }
}

function stealth_shouldinvestigate(behaviortreeentity) {
  if(self.stealth.bsmstate == 1) {
    return true;
  }

  return false;
}

function findclosestlospointwithin(pod, var_72cc3c18, var_465a4fd5, vol, scriptgoalpos, var_f9817e78, var_caa9db69) {
  if(isDefined(vol)) {
    pos = namespace_206491b4::findclosestlospointwithinvolume(vol, var_72cc3c18, var_465a4fd5, isDefined(pod) ? pod.usedpoints : undefined, 48);

    if(isDefined(pos) && isDefined(var_caa9db69) && var_caa9db69 && !investigate_sanitycheckinitialpos(var_72cc3c18, pos)) {
      return undefined;
    }

    return pos;
  } else if(var_f9817e78 > 64 && isDefined(scriptgoalpos)) {
    pos = namespace_206491b4::findclosestlospointwithinradius(scriptgoalpos, var_f9817e78, var_72cc3c18, var_465a4fd5, isDefined(pod) ? pod.usedpoints : undefined, 48);

    if(isDefined(pos) && isDefined(var_caa9db69) && var_caa9db69 && !investigate_sanitycheckinitialpos(var_72cc3c18, pos)) {
      return undefined;
    }

    return pos;
  }

  return getrandomnavpoint(var_72cc3c18, 200);
}

function investigate_sanitycheckinitialpos(investigatepos, searchpos) {
  var_f578e91a = vectornormalize(investigatepos - self.origin);
  var_ea982379 = searchpos - self.origin;
  var_de013700 = length(var_ea982379);

  if(var_de013700 > 256) {
    var_ea982379 /= var_de013700;

    if(vectordot(var_ea982379, var_f578e91a) < -0.5) {
      return false;
    }
  }

  return true;
}

function investigate_getcorpseoffsetpos(corpsepos) {
  var_c1edb9e5 = corpsepos - self.origin;
  offsetpos = corpsepos - vectornormalize(var_c1edb9e5) * 32;
  offsetpos = getclosestpointonnavmesh(offsetpos, 500);
  return offsetpos;
}

function investigate_getinitialpos() {
  shouldupdate = 1;
  event = self.stealth.investigateevent;

  if(isDefined(self.stealth.investigate_point)) {
    if(isvec(self.stealth.investigate_point)) {
      pos = getclosestpointonnavmesh(self.stealth.investigate_point, 500);
    } else if(isDefined(self.stealth.investigate_point.origin)) {
      pos = getclosestpointonnavmesh(self.stealth.investigate_point.origin, 500);
    } else {
      pos = self.origin;
    }

    if(!isDefined(pos)) {
      pos = self.stealth.investigate_point;
    }

    var_39725a4e = vectornormalize(self.goalpos - self.origin);
    dirfacing = anglesToForward(self.angles);
    var_93a2516c = vectornormalize(pos - self.origin);

    if(isPlayer(event.entity) && !isPlayer(self.stealth.investigate_entity)) {
      shouldupdate = 1;
    } else if(vectordot(var_39725a4e, var_93a2516c) < 0 && vectordot(dirfacing, var_93a2516c) < 0) {
      shouldupdate = 1;
    } else if(event.typeorig == "saw_corpse") {
      shouldupdate = 1;
    } else if(shouldupdate && distancesquared(self.goalpos, pos) < sqr(300)) {
      shouldupdate = 0;
    }
  }

  if(shouldupdate) {
    var_5f25f38e = level.stealth.investigate_volumes[self.script_stealthgroup];
    groupdata = stealth_group::getgroup(self.script_stealthgroup);
    pod = stealth_group::group_findpod(groupdata, self);
    assert(isDefined(pod));
    var_ca361e0e = 0;
    var_f6fb36e9 = 0;
    var_d5379974 = 0;

    if(isDefined(pod.investigateoriginguy) && pod.investigateoriginguy == self || pod.members[0] == self) {
      var_ca361e0e = 1;
    } else if(distancesquared(self.origin, event.investigate_pos) < 16384) {
      var_d5379974 = 1;
    } else if(pod.members.size > 1 && pod.members[1] == self) {
      var_f6fb36e9 = 1;
    }

    searchpos = undefined;

    if(var_ca361e0e) {
      if(event.typeorig == "saw_corpse" || distance2dsquared(self.origin, event.investigate_pos) < 4096) {
        searchpos = event.investigate_pos;

        if(event.typeorig == "saw_corpse") {
          searchpos = investigate_getcorpseoffsetpos(searchpos);
        }

        if(isDefined(var_5f25f38e)) {
          var_2279f286 = self findlastpointonpathwithinvolume(searchpos, var_5f25f38e);

          if(isDefined(var_2279f286)) {
            searchpos = var_2279f286;
          }
        }
      }

      if(event.typeorig == "sight" && isDefined(event.entity) && self cansee(event.entity)) {
        searchpos = event.entity.origin;
      }

      if(!isDefined(searchpos)) {
        searchpos = findclosestlospointwithin(pod, event.investigate_pos, event.investigate_pos, var_5f25f38e, self.scriptgoalpos, self.goalradius, 1);

        if(!isDefined(searchpos)) {
          if(isDefined(var_5f25f38e)) {
            searchpos = self findlastpointonpathwithinvolume(event.investigate_pos, var_5f25f38e);
          }

          if(!isDefined(searchpos)) {
            searchpos = findclosestlospointwithin(pod, event.investigate_pos, self.origin, var_5f25f38e, self.scriptgoalpos, self.goalradius, 1);
          }

          if(!isDefined(searchpos)) {
            searchpos = self.origin;
          }
        }
      }
    } else if(var_f6fb36e9) {
      f = randomfloatrange(0.7, 0.85);
      searchpos = vectorlerp(self.origin, event.investigate_pos, f);
      searchpos = findclosestlospointwithin(pod, searchpos, searchpos, var_5f25f38e, self.scriptgoalpos, self.goalradius);
    } else if(!var_d5379974) {
      searchpos = findclosestlospointwithin(pod, event.investigate_pos, self.origin, var_5f25f38e, self.scriptgoalpos, self.goalradius);
    }

    if(isDefined(searchpos) && !investigate_sanitycheckinitialpos(event.investigate_pos, searchpos)) {
      searchpos = undefined;
    }

    if(!isDefined(searchpos)) {
      searchpos = investigate_getuninvestigatedpos();
    } else {
      stealth_group::pod_addusedpoint(pod, searchpos);
    }

    if(isvec(searchpos)) {
      searchpos = util::ground_position(searchpos, 100);
    } else if(!smart_object::function_1631909f(searchpos)) {
      searchpos.origin = util::ground_position(searchpos.origin, 100);
    }

    self.stealth.var_627b2039 = searchpos;
    return searchpos;
  }
}

function investigate_getuninvestigatedpos() {
  groupdata = stealth_group::getgroup(self.script_stealthgroup);
  pod = stealth_group::group_findpod(groupdata, self);

  if(isDefined(pod.investigateoriginguy) && pod.investigateoriginguy == self) {
    searchpos = undefined;

    if(isDefined(pod.volume)) {
      searchpos = self findlastpointonpathwithinvolume(pod.origin, pod.volume);
    }

    if(!isDefined(searchpos)) {
      searchpos = getclosestpointonnavmesh(pod.origin, 500);
    }

    pod.investigateoriginguy = undefined;
  } else {
    searchpos = stealth_group::group_getinvestigatepoint(self);
  }

  return searchpos;
}

function setinvestigateendtime() {
  investigatemintime = 15;
  investigatemaxtime = 20;

  if(isDefined(self.stealth.corpse)) {
    investigatemintime = 25;
    investigatemaxtime = 35;
  }

  if(isDefined(self.stealth.investigatemintime)) {
    investigatemintime = self.stealth.investigatemintime;
  }

  if(isDefined(self.stealth.investigatemaxtime)) {
    investigatemaxtime = self.stealth.investigatemaxtime;
  }

  self.stealth.investigateendtime = gettime() + randomintrange(investigatemintime, investigatemaxtime) * 1000;
  self.stealth.var_3bf603d9 = undefined;
}

function function_c8d4ba1() {
  var_fec323b3 = 5;
  var_3af586f1 = 10;

  if(isDefined(self.stealth.var_fec323b3)) {
    investigatemintime = self.stealth.var_fec323b3;
  }

  if(isDefined(self.stealth.var_3af586f1)) {
    investigatemaxtime = self.stealth.var_3af586f1;
  }

  self.stealth.var_3bf603d9 = gettime() + randomintrange(var_fec323b3, var_3af586f1) * 1000;
}

function investigate_shouldfacedecentdirectionwhenidle() {
  return !is_true(self.limitstealthturning);
}

function function_d004e2c7(event) {
  self.stealth.investigateevent = event;
  self.stealth.investigateevent_time = gettime();
  self setinvestigateendtime();
  self.stealth.binitialinvestigate = 0;
  investigate_setreaction(event);

  if(!self isinscriptedstate()) {
    if(is_true(self.stealthforcegundown)) {
      self.gunposeoverride_internal = "gun_down";
    } else {
      self.gunposeoverride_internal = "ready";
    }
  }

  self.stealth.investigate_point = self investigate_getinitialpos();

  if(isDefined(self.stealth.investigate_point)) {
    faceangles = self namespace_206491b4::function_24b5e32(self.stealth.investigate_point);
    self namespace_979752dc::set_goal(self.stealth.investigate_point, faceangles);
  }
}

function investigate_init() {
  assert(isDefined(self.stealth.investigateevent));
  event = self.stealth.investigateevent;
  self.stealth.investigate_severity = event.type;
  self.stealth.investigate_entity = event.entity;
  self smart_object::function_a59dc8a8(self.smart_object);
  self.script_forcegoal = 0;
  updatesightstate("investigate");
  self.diequietly = 1;
  investigate_setreaction(event);
  self setinvestigateendtime();
  self.stealth.binitialinvestigate = 1;

  if(!self isinscriptedstate()) {
    if(is_true(self.stealthforcegundown)) {
      self.gunposeoverride_internal = "gun_down";
    } else {
      self.gunposeoverride_internal = "ready";
    }
  }

  self.stealth.investigate_point = self investigate_getinitialpos();

  if(isDefined(self.stealth.investigate_point)) {
    faceangles = self namespace_206491b4::function_24b5e32(self.stealth.investigate_point);
    self namespace_979752dc::set_goal(self.stealth.investigate_point, faceangles);
  }
}

function investigate_setreaction(event) {
  var_7137846d = "small";

  if(event.typeorig == "bulletwhizby" || event.typeorig == "grenade danger") {
    var_7137846d = "medium";
  } else if(event.typeorig == "footstep_sprint") {
    if(isDefined(event.entity) && isPlayer(event.entity) && event.entity stealth_threat_sight::player_is_sprinting_at_me(self)) {
      var_7137846d = "medium";
    }
  } else if(event.typeorig == "sight" && self.alertlevel == "high_alert" && self namespace_979752dc::function_d58e1c1c()) {
    var_7137846d = "small_medium";
  }

  self namespace_979752dc::set_patrol_react(event.investigate_pos, var_7137846d);
}

function function_2640a26c(forced) {
  if(is_true(forced) || isDefined(self.stealth.var_3bf603d9) && gettime() >= self.stealth.var_3bf603d9) {
    if(!is_true(forced) && isDefined(self.smart_object)) {
      if(distancesquared(self.smart_object.origin, self.goalpos) > sqr(self.goalradius)) {
        goal = self.smart_object smart_object::get_goal();
        self namespace_979752dc::set_goal(goal, undefined, goal.goalradius);
      } else {
        return 0;
      }
    }

    if(self.stealth.bsmstate == 2) {
      self hunt_getpos();
      return;
    }

    if(!self function_76431493()) {
      self function_11ad9ad4();
    }
  }
}

function function_76431493() {
  if(isDefined(self.stealth.investigateendtime) && gettime() >= self.stealth.investigateendtime) {
    self util::delay(0.05, undefined, &setstealthstate, "idle");
    return true;
  }

  return false;
}

function investigate_updateeveryframe(behaviortreeentity) {
  self updatesightstate("investigate");

  if(isDefined(self.stealth.active_sense_funcs)) {
    foreach(func in self.stealth.active_sense_funcs) {
      self[[func]]();
    }
  }

  self function_2640a26c();
  return true;
}

function investigate_setupruntocorpse(instancedata, pos, var_5fda80c8) {
  self namespace_979752dc::set_patrol_style("combat", var_5fda80c8, pos, "medium");
  instancedata.nextstylecheck = gettime() + 100;
  instancedata.nextstylecheckdist = 256;
  instancedata.nextstylecheckinterval = 100;
}

function investigate_move_init(behaviortreeentity) {
  taskid = behaviortreeentity gettaskid(1);
  self.fovforward = self.alertlevelint <= 2;
  curtime = gettime();
  instancedata = spawnStruct();
  instancedata.starttime = curtime;
  instancedata.cqbtargetnexttwitchtime = curtime + randomintrange(2000, 4000);
  self.bt.instancedata[taskid] = instancedata;
  typeorig = self.stealth.investigateevent.typeorig;
  hashtype = hash(self.stealth.investigateevent.type);

  switch (hashtype) {
    case # "investigate":
      style = self.awarenesslevelcurrent == "unaware" ? "patrol" : "alert";
      self namespace_979752dc::set_patrol_style(style);
      break;
    default:
      self namespace_979752dc::set_patrol_style("alert");
      break;
  }

  if(typeorig == "saw_corpse") {
    if(isDefined(self.stealth.corpse.ent)) {
      instancedata.nextcorpsechecktime = curtime + 200;
    }
  } else if(typeorig == "grenade danger") {
    self.grenadeawareness = 1;
    self.grenadereturnthrowchance = 0;
    return;
  }

  if(!isDefined(self.stealth.var_627b2039)) {
    self function_11ad9ad4(self.bt.instancedata[taskid]);
  }

  self.disablelookdownpath = 1;
  instancedata.enablelookdownpathtime = curtime + 2000;
}

function investigate_move_setaimtarget(instancedata, targetpos, eventtype) {
  assert(isDefined(targetpos));
  t = 5000;

  if(isDefined(eventtype)) {
    switch (eventtype) {
      case # "sight":
        t = 1000;
        break;
      case # "light_killed":
      case # "glass_destroyed":
        t = 3000;
        break;
    }
  }

  self.cqb_target = targetpos;
  instancedata.cqbtargetendtime = gettime() + t;
}

function function_11ad9ad4(instancedata) {
  self.stealth.var_3bf603d9 = undefined;
  groupdata = stealth_group::getgroup(self.script_stealthgroup);
  pod = stealth_group::group_findpod(groupdata, self);

  if(is_true(self.stealth.binitialinvestigate)) {
    goalpos = investigate_getinitialpos();
  } else {
    goalpos = investigate_getuninvestigatedpos();
    groupdata = stealth_group::getgroup(self.script_stealthgroup);
    pod = stealth_group::group_findpod(groupdata, self);

    if(isDefined(pod.needsupdate)) {
      arrayremovevalue(pod.needsupdate, self);
    }
  }

  if(isDefined(pod.needsupdate)) {
    arrayremovevalue(pod.needsupdate, self);
  }

  if(isDefined(pod.investigateoriginguy) && pod.investigateoriginguy == self) {
    pod.investigateoriginguy = undefined;
  }

  if(isDefined(goalpos)) {
    self.stealth.investigate_point = goalpos;
    faceangles = undefined;
    self.stealth.var_627b2039 = goalpos;

    if(self.stealth.binitialinvestigate && isDefined(instancedata)) {
      instancedata.numfails = 0;
      typeorig = self.stealth.investigateevent.typeorig;

      if(typeorig == "saw_corpse" || typeorig == "found_corpse") {
        investigate_setupruntocorpse(instancedata, goalpos, 1);
      } else if(typeorig == "bulletwhizby" || typeorig == "grenade danger") {
        self namespace_979752dc::set_patrol_style("cqb");
        faceangles = self namespace_206491b4::function_24b5e32(goalpos);
      } else {
        self namespace_979752dc::set_patrol_style("alert");
        lookpos = self.stealth.investigateevent.look_pos;

        if(!isDefined(lookpos)) {
          lookpos = self.stealth.investigateevent.investigate_pos;
        }

        investigate_move_setaimtarget(instancedata, lookpos, typeorig);
        faceangles = self namespace_206491b4::function_24b5e32(goalpos);
      }
    } else {
      self namespace_979752dc::set_patrol_style("alert");
      self.moveplaybackrate = 1;
      faceangles = self namespace_206491b4::function_24b5e32(goalpos);
    }

    self namespace_979752dc::set_goal(goalpos, faceangles, 24);
  }
}

function setuprandomlooktarget(instancedata) {
  var_c43fd60f = 400;
  instancedata.cqbtwitching = 1;
  instancedata.cqbtwitchend = gettime() + var_c43fd60f;
  instancedata.cqbtwitchstate = 0;

  if(math::cointoss()) {
    instancedata.cqbtwitchdir = 1;
    return;
  }

  instancedata.cqbtwitchdir = -1;
}

function resetcqbtwitch(instancedata) {
  instancedata.cqbtargetnexttwitchtime = gettime() + randomintrange(2000, 4000);
  instancedata.cqbtwitching = undefined;
  instancedata.cqbtwitchend = undefined;
  instancedata.cqbtwitchstate = undefined;
  instancedata.cqbtwitchdir = undefined;
}

function updaterandomlooktarget(instancedata, targetdist) {
  var_c43fd60f = 400;
  var_78075333 = 1000;
  var_51efeda2 = 20;
  facingdir = anglesToForward(self.angles);
  curtime = gettime();
  assert(isDefined(instancedata.cqbtwitchstate));

  switch (instancedata.cqbtwitchstate) {
    case 0:
      t = (instancedata.cqbtwitchend - curtime) / var_c43fd60f;

      if(t > 0) {
        angle = var_51efeda2 * (1 - sin(t * 90)) * instancedata.cqbtwitchdir;
        self.cqb_target = self.origin + rotatepoint(facingdir, (0, angle, 0)) * targetdist;
        break;
      } else {
        instancedata.cqbtwitchend = curtime + var_78075333;
        instancedata.cqbtwitchstate++;
      }
    case 1:
      if(curtime < instancedata.cqbtwitchend) {
        self.cqb_target = self.origin + rotatepoint(facingdir, (0, var_51efeda2 * instancedata.cqbtwitchdir, 0)) * targetdist;
        break;
      } else {
        instancedata.cqbtwitchend = curtime + var_c43fd60f;
        instancedata.cqbtwitchstate++;
      }
    case 2:
      t = (instancedata.cqbtwitchend - curtime) / var_c43fd60f;

      if(t > 0) {
        angle = var_51efeda2 * sin(t * 90) * instancedata.cqbtwitchdir;
        self.cqb_target = self.origin + rotatepoint(facingdir, (0, angle, 0)) * targetdist;
      } else {
        resetcqbtwitch(instancedata);
      }

      break;
  }
}

function investigate_move_updateaimtarget(instancedata) {
  curtime = gettime();

  if(isDefined(instancedata.cqbtargetendtime)) {
    if(isDefined(self.cqb_target)) {
      metotarget = self.cqb_target - self.origin;
      var_40b6f5f3 = isDefined(self.stealth.patrol_react_magnitude) || isDefined(self.stealth.breacting);

      if(curtime > instancedata.cqbtargetendtime || !var_40b6f5f3 && abs(self.angles[1] - vectortoyaw(metotarget)) > 50) {
        self.cqb_target = undefined;
        instancedata.cqbtargetendtime = undefined;
        instancedata.cqbtargetnexttwitchtime = curtime + randomintrange(2000, 4000);
      }
    } else {
      instancedata.cqbtargetendtime = undefined;
      instancedata.cqbtargetnexttwitchtime = curtime + randomintrange(2000, 4000);
    }
  }

  if(!isDefined(instancedata.cqbtargetendtime)) {
    facingdir = anglesToForward(self.angles);
    var_4b9400c1 = 0;

    foreach(player in getplayers()) {
      if(self getthreatsight(player) > 0) {
        var_4b9400c1 = 1;
        resetcqbtwitch(instancedata);
        self.cqb_target = self lastknownpos(player);
        break;
      }
    }

    if(!var_4b9400c1) {
      var_c43fd60f = 400;
      var_78075333 = 1000;
      var_51efeda2 = 20;

      if(isDefined(instancedata.cqbtwitching)) {
        updaterandomlooktarget(instancedata, 500);
        return;
      }

      if(isDefined(instancedata.cqbtargetnexttwitchtime) && curtime > instancedata.cqbtargetnexttwitchtime) {
        instancedata.cqbtwitching = 1;
        instancedata.cqbtwitchend = curtime + var_c43fd60f;
        instancedata.cqbtwitchstate = 0;

        if(math::cointoss()) {
          instancedata.cqbtwitchdir = 1;
        } else {
          instancedata.cqbtwitchdir = -1;
        }

        updaterandomlooktarget(instancedata, 500);
        return;
      }

      self.cqb_target = undefined;
    }
  }
}

function private function_d6c9b118() {
  if(isDefined(level.stealth.var_f67fe42c)) {
    return;
  }

  level.stealth.var_f67fe42c = [];
  level.stealth.var_f67fe42c[0] = [ &aiutility::function_865ea8e6, &aiutility::function_865ea8e6, &aiutility::function_865ea8e6];
  level.stealth.var_f67fe42c[2] = [ &hunt_move_init, &hunt_move, &hunt_move_terminate];
  level.stealth.var_f67fe42c[1] = [ &investigate_move_init, &investigate_move, &investigate_move_terminate];
  level.stealth.var_f67fe42c[3] = [ &aiutility::function_865ea8e6, &aiutility::function_865ea8e6, &aiutility::function_865ea8e6];
}

function function_36915a04(behaviortreeentity) {
  behaviortreeentity function_ed7c3705("stealth");

  if(archetypehuman::function_30579259(behaviortreeentity)) {
    var_24a76e36 = behaviortreeentity function_f206a7f(1);
    behaviortreeentity.var_4f6f8942 = !var_24a76e36;
  }

  if(!isDefined(self.stealth)) {
    return true;
  }

  assert(!isDefined(self.bt.var_98919459));
  self.bt.var_98919459 = behaviortreeentity gettaskid(1, "move");
  self.bt.instancedata[self.bt.var_98919459] = self.stealth.bsmstate;
  function_d6c9b118();
  [[level.stealth.var_f67fe42c[self.stealth.bsmstate][0]]](behaviortreeentity);
  behaviortreeentity ai::function_fc7bd6c7();
  return true;
}

function function_7653ca27(behaviortreeentity) {
  if(self flag::get("in_action")) {
    return 1;
  }

  if(!isDefined(self.stealth)) {
    namespace_2dd2c4d8::function_3b9e6ead(behaviortreeentity, "turn@stealth");
    return 1;
  }

  assert(isDefined(self.bt.var_98919459));

  if(self.bt.instancedata[self.bt.var_98919459] != self.stealth.bsmstate) {
    [[level.stealth.var_f67fe42c[self.bt.instancedata[self.bt.var_98919459]][2]]](behaviortreeentity);
    [[level.stealth.var_f67fe42c[self.stealth.bsmstate][0]]](behaviortreeentity);
    self.bt.instancedata[self.bt.var_98919459] = self.stealth.bsmstate;
  }

  updateresult = [[level.stealth.var_f67fe42c[self.stealth.bsmstate][1]]](behaviortreeentity);

  if(updateresult) {
    namespace_2dd2c4d8::function_3b9e6ead(behaviortreeentity, "turn@stealth");
  }

  return updateresult;
}

function function_bf263c90(behaviortreeentity) {
  behaviortreeentity function_ed7c3705("none");

  if(!isDefined(self.stealth)) {
    behaviortreeentity ai::function_f6060793();
    return true;
  }

  assert(isDefined(self.bt.var_98919459));
  [[level.stealth.var_f67fe42c[self.bt.instancedata[self.bt.var_98919459]][2]]](behaviortreeentity);
  self.bt.instancedata[self.bt.var_98919459] = undefined;
  self.bt.var_98919459 = undefined;
  behaviortreeentity ai::function_f6060793();
  return true;
}

function function_445c5acf(behaviortreeentity) {
  behaviortreeentity function_f206a7f(0, behaviortreeentity.var_4f6f8942);
  behaviortreeentity.var_4f6f8942 = undefined;

  if(!isDefined(self.stealth)) {
    return true;
  }

  self.stealth.bexaminerequested = undefined;
  self namespace_cc4354b9::corpse_clear();
  return true;
}

function investigate_move(behaviortreeentity) {
  taskid = behaviortreeentity gettaskid();

  if(isDefined(self getlinkedent())) {
    return true;
  }

  if(self.stealth.investigateevent.typeorig == "grenade danger") {
    return true;
  }

  curtime = gettime();
  instancedata = self.bt.instancedata[taskid];
  groupdata = stealth_group::getgroup(self.script_stealthgroup);
  pod = stealth_group::group_findpod(groupdata, self);
  assert(isDefined(pod));

  if(isDefined(pod.needsupdate) && array::contains(pod.needsupdate, self)) {
    goalpos = investigate_getuninvestigatedpos();
    goalorigin = goalpos;

    if(isDefined(goalpos)) {
      if(!isvec(goalorigin)) {
        goalorigin = goalorigin.origin;
      }

      arrayremovevalue(pod.needsupdate, self);
      faceangles = undefined;
      var_16721ebf = self.stealth.investigateevent.typeorig;

      if(var_16721ebf == "saw_corpse" || var_16721ebf == "found_corpse") {
        investigate_setupruntocorpse(instancedata, goalorigin, 0);
      } else {
        var_ff42b0fb = gettime() > instancedata.starttime;
        demeanor = "alert";
        reaction = "small";

        if(var_16721ebf == "bulletwhizby" || self ai::get_behavior_attribute("demeanor") == "combat") {
          demeanor = "cqb";
          reaction = "medium";
        }

        if(is_true(self.stealth.binitialinvestigate) && isDefined(self.pathgoalpos) && distancesquared(self.pathgoalpos, goalorigin) < 576) {
          var_ff42b0fb = 0;
        }

        namespace_979752dc::set_patrol_style(demeanor, var_ff42b0fb, goalorigin, reaction);
        lookpos = self.stealth.investigateevent.look_pos;

        if(!isDefined(lookpos)) {
          lookpos = self.stealth.investigateevent.investigate_pos;
        }

        investigate_move_setaimtarget(instancedata, lookpos, var_16721ebf);
        faceangles = namespace_206491b4::function_24b5e32(goalorigin);
        instancedata.nextcorpsechecktime = undefined;
      }

      self namespace_979752dc::set_goal(goalpos, faceangles);
    }
  }

  if(isDefined(instancedata.nextcorpsechecktime) && curtime > instancedata.nextcorpsechecktime) {
    if(isDefined(self.stealth.corpse.ent)) {
      corpsepos = self.stealth.corpse.ent namespace_979752dc::getcorpseorigin();
      corpsepos = self investigate_getcorpseoffsetpos(corpsepos);
      self namespace_979752dc::set_goal(corpsepos);
      instancedata.nextcorpsechecktime = curtime + 200;
    } else {
      instancedata.nextcorpsechecktime = undefined;
    }
  }

  if(isDefined(instancedata.enablelookdownpathtime) && curtime > instancedata.enablelookdownpathtime) {
    self.disablelookdownpath = undefined;
    instancedata.enablelookdownpathtime = undefined;
  }

  if(isalive(getplayers()[0])) {
    target = getplayers()[0];

    if(self cansee(target)) {
      assert(issentient(target));
      investigate_move_setaimtarget(instancedata, self lastknownpos(target) + (0, 0, 32), "sight");
    }
  }

  investigate_move_updateaimtarget(instancedata);

  if(isdonewithsearchmove(instancedata)) {
    return true;
  }

  if(isDefined(instancedata.nextstylecheck) && curtime >= instancedata.nextstylecheck) {
    checkdist = 512;

    if(isDefined(instancedata.nextstylecheckdist)) {
      checkdist = instancedata.nextstylecheckdist;
    }

    if(self getpathlength() > checkdist) {
      interval = 1000;

      if(isDefined(instancedata.nextstylecheckinterval)) {
        interval = instancedata.nextstylecheckinterval;
      }

      instancedata.nextstylecheck = gettime() + interval;
    } else {
      self namespace_979752dc::set_patrol_style("alert");
      instancedata.nextstylecheck = undefined;
    }
  }

  return true;
}

function investigate_move_terminate(behaviortreeentity) {
  taskid = behaviortreeentity gettaskid();
  self.fovforward = 0;

  if(is_true(self.stealth.binitialinvestigate)) {
    self.stealth.binitialinvestigate = 0;
    self.stealth.investigateendtime = undefined;
  }

  self.bt.instancedata[taskid] = undefined;
  self.cqb_target = undefined;
  self.disablelookdownpath = undefined;
  function_cb942647();
}

function function_cb942647() {
  if(!isDefined(self.stealth.investigateevent) || !isDefined(self.stealth.investigateevent.investigate_pos)) {
    return;
  }

  heightdifference = self.stealth.investigateevent.investigate_pos[2] - self.origin[2];

  if(heightdifference > 75) {
    self.var_920617c1 = "stealth_investigate_height_high";
    return;
  }

  self.var_920617c1 = "stealth_investigate_height_default";
}

function investigate_lookaround_init(behaviortreeentity) {
  taskid = behaviortreeentity gettaskid(1);
  data = spawnStruct();
  data.failsafetimeout = gettime() + 8000;

  if(isDefined(self.stealth.scriptedinitialinvestigatedelay)) {
    data.initialinvestigatetime = gettime() + self.stealth.scriptedinitialinvestigatedelay * 1000;
    self.stealth.scriptedinitialinvestigatedelay = undefined;
  }

  self.bt.instancedata[taskid] = data;
  timeout = 8000;
  self namespace_979752dc::set_goal(self namespace_979752dc::function_133b86af());
  self namespace_979752dc::set_patrol_style("alert");
  self.stealth.binvestigatelookaround = 1;

  if(!is_true(self.stealth.binitialinvestigate) && !isDefined(self.stealth.investigateendtime)) {
    setinvestigateendtime();
  }

  if(!isDefined(self.stealth.var_3bf603d9) || gettime() > self.stealth.var_3bf603d9) {
    function_c8d4ba1();
  }

  return true;
}

function investigate_lookaround(behaviortreeentity) {
  taskid = behaviortreeentity gettaskid();

  if(!isDefined(self.bt.instancedata[taskid].failsafetimeout) || gettime() > self.bt.instancedata[taskid].failsafetimeout) {
    return false;
  }

  if(is_true(self.stealth.binitialinvestigate)) {
    if(isDefined(self.bt.instancedata[taskid].initialinvestigatetime) && gettime() < self.bt.instancedata[taskid].initialinvestigatetime) {
      return true;
    }
  }

  groupdata = stealth_group::getgroup(self.script_stealthgroup);
  pod = stealth_group::group_findpod(groupdata, self);

  if(isDefined(pod) && isDefined(pod.needsupdate) && array::contains(pod.needsupdate, self)) {
    arrayremovevalue(pod.needsupdate, self);
    return true;
  }

  foreach(player in getplayers()) {
    if(self getthreatsight(player) > 0.05 && self namespace_979752dc::function_d58e1c1c() && self.alertlevel != "high_alert") {
      return false;
    }
  }

  return true;
}

function investigate_lookaround_terminate(behaviortreeentity) {
  taskid = behaviortreeentity gettaskid();
  self.bt.instancedata[taskid] = undefined;
  self.stealth.binvestigatelookaround = 0;
  return true;
}

function investigate_targetedlookaround(behaviortreeentity) {
  var_26b3b46a = 0;

  foreach(player in getplayers()) {
    if(self getthreatsight(player) > 0.05) {
      self.cqb_target = self lastknownpos(player);
      var_26b3b46a = 1;
      break;
    }
  }

  if(var_26b3b46a) {
    return true;
  }

  if(isDefined(self.cqb_target)) {
    groupdata = stealth_group::getgroup(self.script_stealthgroup);
    pod = stealth_group::group_findpod(groupdata, self);
    pod stealth_group::pod_updateinvestigateorigin(self, self.cqb_target);
  }

  return false;
}

function investigate_terminate() {
  self namespace_979752dc::set_goal(self.origin);
  self.diequietly = 0;
  self.stealth.investigate_point = undefined;
  self.stealth.investigate_severity = undefined;
  self.stealth.investigate_entity = undefined;
  self.stealth.var_56d82ea8 = undefined;
  self.stealth.investigateevent = undefined;
  self.stealth.binitialinvestigate = undefined;
  self.stealth.binvestigateoutofrange = undefined;
  self.stealth.investigateendtime = undefined;
  self.stealth.var_627b2039 = undefined;
  self.stealth.investigateevent_time = undefined;
  self.moveplaybackrate = 1;
  self.cqb_target = undefined;
  self function_f2887688();
  self namespace_cc4354b9::corpse_clear();
  return true;
}

function stealth_shouldhunt(behaviortreeentity) {
  if(self.stealth.bsmstate == 2) {
    return true;
  }

  return false;
}

function hunt_shouldinvestigateorigin(pod, guy) {
  foreach(group in level.stealth.groupdata.groups) {
    foreach(var_dff5abf9 in group.pods) {
      if(var_dff5abf9 == pod) {
        continue;
      }

      if(var_dff5abf9.state == 2 && isDefined(var_dff5abf9.borigininvestigated) && distance2dsquared(pod.origin, var_dff5abf9.origin) < 576) {
        pod.borigininvestigated = 1;
        return false;
      }
    }
  }

  closestguy = pod stealth_group::pod_getclosestguy(pod.origin);
  return isDefined(closestguy) && closestguy == guy;
}

function hunt_updateregiontoclear() {
  if(!isDefined(self.stealth.cleardata) || !isDefined(self.stealth.cleardata.curregion)) {
    if(!isDefined(self.script_stealth_region_group) || !isDefined(level.stealth.hunt_stealth_group_region_sets[self.script_stealth_region_group]) || level.stealth.hunt_stealth_group_region_sets[self.script_stealth_region_group].size == 0) {
      return;
    }

    region = self namespace_5cd4acd8::getregionforpos(self.origin);

    if(!isDefined(region)) {
      return;
    }

    if(!isDefined(self.stealth.cleardata)) {
      self.stealth.cleardata = spawnStruct();
    }

    cleardata = self.stealth.cleardata;
    cleardata.prevregion = [];
    cleardata.prevregion[0] = region;
    cleardata.prevregion[1] = region;
    cleardata.isinregion = 0;
    self namespace_5cd4acd8::huntassigntoregion(region);
    assert(isDefined(region.route_points));
    cleardata.curroutepoint = self namespace_5cd4acd8::findcurposonroute(self.origin, region.route_points);
    cleardata.brouteforward = 1;
  }
}

function hunt_clearroomdata() {
  if(isDefined(self.stealth.cleardata)) {
    if(isDefined(self.stealth.cleardata.curregion)) {
      namespace_5cd4acd8::huntdecaiassignment(self.stealth.cleardata.curregion);
    }

    self.stealth.cleardata = undefined;
  }
}

function hunt_finddoorbetween(var_c27b6fd6, var_b034cb49) {
  foreach(link in var_c27b6fd6.region_links) {
    if(link.region == var_b034cb49) {
      doororigin = link.transition_to_point.origin;

      for(i = 0; i < var_b034cb49.route_points.size; i++) {
        if(distancesquared(var_b034cb49.route_points[i].origin, doororigin) < 4) {
          return i;
        }
      }
    }
  }
}

function hunt_getnextclearpos() {
  assert(isDefined(self.stealth.cleardata));
  cleardata = structcopy(self.stealth.cleardata);
  var_355a0ab5 = cleardata.curroutepoint;
  var_22016eea = structcopy(self.stealth.cleardata.curregion);
  var_6e87d6b2 = 0;
  smartobj = undefined;

  for(numtries = 0; numtries < 2; numtries++) {
    result = self namespace_5cd4acd8::findnextpointofinterest(self.origin, cleardata.curregion, cleardata.curroutepoint, cleardata.brouteforward);

    if(isDefined(result)) {
      smartobj = result[0];
      cleardata.curroutepoint = result[1];

      if(var_6e87d6b2) {
        self namespace_5cd4acd8::huntunassignfromregion(var_22016eea);
        self.stealth.cleardata = structcopy(cleardata);
        self namespace_5cd4acd8::huntassigntoregion(cleardata.curregion);
      }

      return self function_4efdd16b(smartobj);
    }

    if(numtries == 1) {
      break;
    }

    curregion = cleardata.curregion;
    cleardata.curregion = self namespace_5cd4acd8::huntgetnextregion(cleardata.curregion);
    cleardata.curroutepoint = 0;
    cleardata.brouteforward = 1;

    if(curregion != cleardata.curregion) {
      var_3a454b3a = hunt_finddoorbetween(curregion, cleardata.curregion);

      if(isDefined(var_3a454b3a)) {
        cleardata.curroutepoint = var_3a454b3a;
      } else {
        cleardata.curroutepoint = self namespace_5cd4acd8::findcurposonroute(self.origin, cleardata.curregion.route_points);
      }

      if(cleardata.curroutepoint > cleardata.curregion.route_points.size * 0.5) {
        cleardata.brouteforward = 0;
      }

      var_6e87d6b2 = 1;
    }
  }

  fallback = var_355a0ab5;
  var_5857f222 = var_355a0ab5 + 1;
  var_74350fc8 = self.stealth.cleardata.curregion.route_points.size;

  if(var_6e87d6b2) {
    self namespace_5cd4acd8::huntunassignfromregion(var_22016eea);
    self.stealth.cleardata = structcopy(cleardata);
    self namespace_5cd4acd8::huntassigntoregion(cleardata.curregion);
    fallback = cleardata.curroutepoint;
    var_5857f222 = cleardata.curroutepoint + 1;
    var_74350fc8 = cleardata.curregion.route_points.size;

    if(cleardata.curroutepoint > var_74350fc8 * 0.5) {
      fallback = var_74350fc8 - 1;
      var_5857f222 = fallback - 1;
    }
  }

  cleardata = self.stealth.cleardata;

  if(cleardata.brouteforward) {
    cleardata.curroutepoint += 1;

    if(cleardata.curroutepoint >= cleardata.curregion.route_points.size) {
      cleardata.curroutepoint = 0;
    }
  } else {
    cleardata.curroutepoint -= 1;

    if(cleardata.curroutepoint < 0) {
      cleardata.curroutepoint = cleardata.curregion.route_points.size - 1;
    }
  }

  cleardata.curregion.route_points[fallback].angles = undefined;

  if(var_5857f222 >= 0 && var_5857f222 < var_74350fc8) {
    cleardata.curregion.route_points[fallback].angles = vectortoangles(cleardata.curregion.route_points[var_5857f222].origin - cleardata.curregion.route_points[fallback].origin);
  }

  cleardata.curregion.route_points[fallback].var_4ff89bee = gettime() + 5000;
  return cleardata.curregion.route_points[fallback];
}

function hunt_getpos() {
  if(isDefined(self.stealth.var_d4a1eb27) && isDefined(self.stealth.var_b997a50) && gettime() < self.stealth.var_d4a1eb27) {
    return self.stealth.var_b997a50;
  }

  groupdata = stealth_group::getgroup(self.script_stealthgroup);
  pod = stealth_group::group_findpod(groupdata, self);
  searchpos = undefined;

  if(isDefined(self.stealth.script_nexthuntpos)) {
    searchpos = self.stealth.script_nexthuntpos;
    self.stealth.script_nexthuntpos = undefined;
    self hunt_clearroomdata();
  }

  if(!isDefined(searchpos) && isDefined(pod) && isDefined(pod.origin) && !isDefined(pod.borigininvestigated)) {
    if(hunt_shouldinvestigateorigin(pod, self)) {
      searchpos = pod.origin;
      pod.borigininvestigated = 1;
      self hunt_clearroomdata();
    }
  }

  if(!isDefined(searchpos)) {
    self hunt_updateregiontoclear();

    if(isDefined(self.stealth.cleardata)) {
      searchpos = self hunt_getnextclearpos();
    } else if(isDefined(pod) && isDefined(pod.investigatepoints)) {
      searchpos = stealth_group::group_getinvestigatepoint(self, level.stealth.hunt_volumes[self.script_stealthgroup]);
    }
  }

  if(!isDefined(searchpos) && getplayers().size > 0) {
    searchpos = getplayers()[0].origin;
  }

  var_88427393 = isvec(searchpos) ? searchpos : searchpos.origin;
  navpoint = getclosestpointonnavmesh(var_88427393);

  if(isDefined(navpoint)) {
    self.stealth.var_b997a50 = navpoint;
  } else {
    self.stealth.var_b997a50 = var_88427393;
  }

  self.stealth.var_d4a1eb27 = gettime() + 500;

  if(isDefined(searchpos)) {
    self namespace_979752dc::set_goal(searchpos);
  }

  return searchpos;
}

function hunt_init() {
  self.combatmode = "no_cover";
  self stealth_enemy::set_sight_state("hunt");
  self stealth_enemy::set_alert_level("combat_hunt");
  self smart_object::function_a59dc8a8(self.smart_object);
  self namespace_979752dc::set_patrol_style("cqb");
  self namespace_979752dc::set_goal_radius(30);
  self flashlight::function_229440d2();
  self.stealth.binitialhunt = 1;
  self.diequietly = 1;
  self.allowturn45 = 1;
  self.last_set_goalnode = undefined;
  self.last_set_goalent = undefined;
  groupdata = stealth_group::getgroup(self.script_stealthgroup);
  pod = stealth_group::group_findpod(groupdata, self);
  assert(isDefined(pod));

  if(isDefined(pod.borigininvolume) && !pod.borigininvolume) {
    assert(isDefined(level.stealth.hunt_volumes[self.script_stealthgroup]));
    self namespace_979752dc::set_goal(level.stealth.hunt_volumes[self.script_stealthgroup]);

    if(isDefined(self.script_combatmode)) {
      self.combatmode = self.script_combatmode;
    } else {
      self.combatmode = "cover";
    }
  } else {
    hunt_getpos();
  }

  if(!self isinscriptedstate()) {
    if(is_true(self.stealthforcegundown)) {
      self.gunposeoverride_internal = "gun_down";
      return;
    }

    self.gunposeoverride_internal = "ready";
  }
}

function hunt_updateeveryframe(behaviortreeentity) {
  return true;
}

function hunt_initialdelay_init(behaviortreeentity) {
  taskid = behaviortreeentity gettaskid(1, "Hunt_Delay");
  self.bt.instancedata[taskid] = randomintrange(500, 1500);
}

function hunt_initialdelay(behaviortreeentity) {
  taskid = behaviortreeentity gettaskid(0, "Hunt_Delay");

  if(!behaviortreeentity haspath() && isDefined(self.bt.instancedata[taskid])) {
    self.bt.instancedata[taskid] -= function_60d95f53();

    if(self.bt.instancedata[taskid] <= 0) {
      return true;
    }
  }

  return false;
}

function hunt_initialdelay_terminate(behaviortreeentity) {
  taskid = behaviortreeentity gettaskid(0, "Hunt_Delay");
  self.bt.instancedata[taskid] = undefined;
}

function hunt_cqbtargetupdate(instancedata) {
  groupdata = stealth_group::getgroup(self.script_stealthgroup);
  pod = stealth_group::group_findpod(groupdata, self);

  if(isDefined(pod.target)) {
    curtime = gettime();

    if(self cansee(pod.target) || self getthreatsight(pod.target) > 0.1) {
      self.cqb_target = pod.target.origin;
      instancedata.cqbtargettime = curtime;
      return true;
    } else if(issentient(pod.target) && (isDefined(self.stealth.btargetlastknown) || isDefined(instancedata.cqbtargettime) && curtime - instancedata.cqbtargettime < 2000)) {
      self.cqb_target = self lastknownpos(pod.target);
      return true;
    }
  }

  self.cqb_target = undefined;
  return false;
}

function hunt_shouldhunker(behaviortreeentity) {
  groupdata = stealth_group::getgroup(self.script_stealthgroup);
  pod = stealth_group::group_findpod(groupdata, self);
  assert(isDefined(pod));

  if(is_true(pod.bhunkering)) {
    return true;
  }

  return false;
}

function function_84d939b2(behaviortreeentity) {
  if(hunt_shouldhunker(behaviortreeentity)) {
    taskid = behaviortreeentity gettaskid(0, "Hunt_Delay");

    if(!(isDefined(taskid) && isDefined(self.bt.instancedata[taskid]))) {
      hunt_initialdelay_init(behaviortreeentity);
    }

    if(hunt_initialdelay(behaviortreeentity)) {
      hunt_initialdelay_terminate(behaviortreeentity);
      return true;
    } else {
      return false;
    }
  }

  return false;
}

function function_25281284(behaviortreeentity) {
  taskid = behaviortreeentity gettaskid(0, "Hunt_Hunker");

  if(!(isDefined(taskid) && isDefined(self.bt.instancedata[taskid]))) {
    hunt_hunker_init(behaviortreeentity);
  }

  hunt_hunker(behaviortreeentity);
  return true;
}

function hunt_hunker_init(behaviortreeentity) {
  taskid = behaviortreeentity gettaskid(1, "Hunt_Hunker");
  curtime = gettime();
  instancedata = spawnStruct();
  instancedata.nextcoverchecktime = curtime + randomintrange(4000, 6000);
  self.bt.instancedata[taskid] = instancedata;
  self.stealth.hunthunkerlastexposetime = curtime;
  self namespace_979752dc::set_patrol_style("cqb");
  goalinfo = behaviortreeentity function_4794d6a3();

  if(!isDefined(goalinfo.node) && !isDefined(goalinfo.goalvolume)) {
    groupdata = stealth_group::getgroup(self.script_stealthgroup);
    pod = stealth_group::group_findpod(groupdata, self);

    if(isDefined(self.script_combatmode)) {
      self.combatmode = self.script_combatmode;
    } else {
      self.combatmode = "cover";
    }

    if(isDefined(pod.origin)) {
      node = self findcovernodeatlocation(pod.origin, 512, 80);
    } else {
      node = self findcovernodeatlocation(self.origin, 512, 80);
    }

    if(isDefined(node)) {
      if(!isDefined(self.node) || self.node != node) {
        self namespace_979752dc::set_goal(node);
      }
    }
  }
}

function hunt_hunker(behaviortreeentity) {
  taskid = behaviortreeentity gettaskid(0, "Hunt_Hunker");

  if(!isDefined(self.bt.instancedata[taskid])) {
    return;
  }

  curtime = gettime();

  if(curtime > self.bt.instancedata[taskid].nextcoverchecktime && !self haspath()) {
    groupdata = stealth_group::getgroup(self.script_stealthgroup);
    pod = stealth_group::group_findpod(groupdata, self);
    var_caa00405 = randomint(3) < 1;
    node = self findcovernodeatlocation(pod.origin, 512, 80);

    if(isDefined(node)) {
      var_1aeebe30 = 0;

      if(!isDefined(self.node) || self.node != node) {
        var_1aeebe30 = !self namespace_979752dc::set_goal(node);
      }

      if(var_1aeebe30) {
        self.bt.instancedata[taskid].nextcoverchecktime = curtime + 500;
      } else {
        self.bt.instancedata[taskid].nextcoverchecktime = curtime + randomintrange(4000, 6000);
      }
    } else {
      self.bt.instancedata[taskid].nextcoverchecktime = curtime + randomintrange(2000, 4000);
    }
  }

  hunt_cqbtargetupdate(self.bt.instancedata[taskid]);
  return 1;
}

function hunt_hunker_terminate(behaviortreeentity) {
  taskid = behaviortreeentity gettaskid(0, "Hunt_Hunker");

  if(isDefined(taskid)) {
    self.bt.instancedata[taskid] = undefined;
  }
}

function hunt_hunker_shouldexpose(behaviortreeentity) {
  var_f877c541 = 5000;
  assert(isDefined(self.stealth.hunthunkerlastexposetime));

  if(gettime() > self.stealth.hunthunkerlastexposetime + var_f877c541) {
    return true;
  }

  return false;
}

function hunt_hunker_expose_init(behaviortreeentity) {
  taskid = behaviortreeentity gettaskid(1);
  instancedata = spawnStruct();
  instancedata.endtime = gettime() + 4000;
  instancedata.nextpostime = 0;
  instancedata.nextposidx = 0;
  self.bt.instancedata[taskid] = instancedata;
  self.stealth.btargetlastknown = 1;
}

function hunt_hunker_expose(behaviortreeentity) {
  taskid = behaviortreeentity gettaskid();
  curtime = gettime();
  instancedata = self.bt.instancedata[taskid];

  if(curtime > instancedata.endtime) {
    return true;
  }

  return true;
}

function hunt_hunker_expose_terminate(behaviortreeentity) {
  taskid = behaviortreeentity gettaskid();
  self.cqb_target = undefined;
  self.bt.instancedata[taskid] = undefined;
  self.stealth.btargetlastknown = undefined;
  self.stealth.hunthunkerlastexposetime = gettime();
}

function hunt_isincover(behaviortreeentity) {
  if(!isDefined(self.node)) {
    return false;
  }

  var_f4bdb145 = 16;

  if(isDefined(self.pathgoalpos)) {
    if(distancesquared(self.pathgoalpos, self.origin) > var_f4bdb145) {
      return false;
    }
  } else if(self.keepclaimednodeifvalid) {
    var_f4bdb145 = 3600;
  } else {
    var_f4bdb145 = 225;
  }

  if(distance2dsquared(self.node.origin, self.origin) > var_f4bdb145) {
    return false;
  }

  return true;
}

function hunt_active_terminate(behaviortreeentity) {
  self function_f2887688();
}

function hunt_move_init(behaviortreeentity) {
  taskid = behaviortreeentity gettaskid(1);
  curtime = gettime();
  instancedata = spawnStruct();
  self.bt.instancedata[taskid] = instancedata;
  instancedata.starttime = curtime;
  self.stealth.var_627b2039 = self.stealth.var_b997a50;
  instancedata.numfails = 0;
  smartobj = self.smart_object;

  if(isDefined(smartobj)) {
    self namespace_979752dc::set_goal_radius(12);
  } else {
    self namespace_979752dc::set_goal_radius(37);
  }

  self namespace_979752dc::set_patrol_style("cqb");
  self.disablelookdownpath = 1;
  instancedata.enablelookdownpathtime = curtime + 2000;
}

function hunt_sidechecks(instancedata) {
  var_843ecdc0 = 36;
  var_2be49714 = 36;
  var_bea9b15e = 36;
  curtime = gettime();
  var_22766aeb = 2000;

  if(isDefined(instancedata.cornerchecknode) && curtime >= instancedata.cornerchecknodestarttime + var_22766aeb) {
    instancedata.cornerchecknode = undefined;
    instancedata.cornerchecknodestarttime = undefined;
    self aimatposik(undefined);
    self namespace_979752dc::set_patrol_style("cqb");
    self.disablelookdownpath = undefined;
  }

  if(!isDefined(instancedata.cornerchecknode) && !is_true(self.isarriving) && self.lookaheaddist > 32 && self getpathlength() > 128) {
    lookaheadpos = self getposonpath(var_843ecdc0);
    meforward = anglesToForward(self.angles);
    var_273da0db = getnodesinradius(lookaheadpos, var_bea9b15e, 0, 60, "Cover");

    if(var_273da0db.size > 0) {
      foreach(node in var_273da0db) {
        if(!doesnodeallowstance(node, "stand")) {
          continue;
        }

        var_3456f49c = node.origin - self.origin;

        if(vectordot(var_3456f49c, meforward) < 0) {
          continue;
        }

        anglediff = angleclamp180(node.angles[1] - self.angles[1]);

        if(anglediff > 0 && node.type != "Cover Right") {
          continue;
        } else if(anglediff < 0 && node.type != "Cover Left") {
          continue;
        }

        var_c86d779 = anglesToForward(node.angles);
        dot = vectordot(var_c86d779, meforward);

        if(dot > 0.5 || dot < -0.5) {
          continue;
        }

        if(stealth_debug::debug_enabled()) {
          sidedir = anglesToForward(node.angles);
          circle(lookaheadpos, var_bea9b15e, (0, 1, 0), 1, 0, 1);
          box(node.origin, (-16, -16, 0), (16, 16, 8), node.angles[1], (1, 1, 0), 1, 0, 1);
          line(lookaheadpos, lookaheadpos + sidedir * var_2be49714, (0, 1, 1), 1, 0, 1);
        }

        if(abs(angleclamp180(self.angles[1] - node.angles[1])) < 45) {
          continue;
        }

        if(vectordot(self.lookaheaddir, var_3456f49c) > 32) {
          continue;
        }

        instancedata.cornerchecknode = node;
        instancedata.cornerchecknodestarttime = curtime;
        break;
      }
    }
  }

  if(isDefined(instancedata.cornerchecknode)) {
    cornerchecknode = instancedata.cornerchecknode;

    if(stealth_debug::debug_enabled()) {
      box(cornerchecknode.origin, (-16, -16, 0), (16, 16, 8), cornerchecknode.angles[1], (1, 1, 0), 1, 0, 1);
    }

    checkpos = undefined;
    var_ffe01b4a = anglestoaxis(cornerchecknode.angles);
    var_e531995e = var_ffe01b4a.right;

    if(cornerchecknode.type == "Cover Left") {
      var_e531995e = -1 * var_e531995e;
    }

    var_f74021a7 = 20;
    cornerpos = cornerchecknode.origin + var_f74021a7 * var_ffe01b4a.forward + var_f74021a7 * var_e531995e;
    var_3dcee9ed = self.origin - cornerchecknode.origin;

    if(vectordot(var_3dcee9ed, var_e531995e) < var_f74021a7) {
      checkpos = cornerpos;
    } else {
      checkpos = self.origin + rotatepoint((128, 0, 0), cornerchecknode.angles);
    }

    if(stealth_debug::debug_enabled()) {
      line(cornerchecknode.origin, checkpos, (1, 1, 0), 1, 0, 1);
    }

    self aimatposik(checkpos);
    self namespace_979752dc::set_movement_speed(30);
    self.disablelookdownpath = 1;
  }
}

function hunt_move(behaviortreeentity) {
  taskid = behaviortreeentity gettaskid();
  instancedata = self.bt.instancedata[taskid];
  curtime = gettime();
  var_13e10c61 = isDefined(self.smart_object);

  if(var_13e10c61) {
    self function_4efdd16b(self.smart_object);
  }

  if(isdonewithsearchmove(instancedata)) {
    return true;
  }

  if(hunt_shouldhunker() == 1 || self namespace_979752dc::function_b0c91323(1)) {
    if(var_13e10c61) {
      self function_f2887688();
    }

    return true;
  }

  if(isDefined(instancedata.enablelookdownpathtime) && curtime > instancedata.enablelookdownpathtime) {
    self.disablelookdownpath = undefined;
    instancedata.enablelookdownpathtime = undefined;
  }

  if(isDefined(self.pathgoalpos) && var_13e10c61 && self getpathlength() < 56) {
    smartobj = self.smart_object;
    self aimatposik(smartobj.origin + rotatepoint((128, 0, 0), smartobj.angles));
  } else {
    self hunt_sidechecks(instancedata);
  }

  if(isDefined(self.stealth.cleardata) && isDefined(self.stealth.cleardata.curregion)) {
    self namespace_5cd4acd8::hunttrytoenterregionvolume(self.stealth.cleardata.curregion);
  }

  hunt_cqbtargetupdate(instancedata);
  return true;
}

function hunt_move_terminate(behaviortreeentity) {
  taskid = behaviortreeentity gettaskid();
  self.bt.instancedata[taskid] = undefined;

  if(isDefined(self.stealth.breacting)) {
    self.stealth.binitialhunt = 1;
  } else {
    self.stealth.binitialhunt = undefined;
  }

  self.cqb_target = undefined;
  self.disablelookdownpath = undefined;
  self aimatposik(undefined);
}

function function_ea5fc830(behaviortreeentity) {
  if(isDefined(self.stealth.var_fbfca183) && self.stealth.var_fbfca183 != self.stealth.bsmstate) {
    function_df9a9513(behaviortreeentity);
  }

  self.stealth.var_fbfca183 = self.stealth.bsmstate;

  switch (self.stealth.var_fbfca183) {
    case 1:
      return investigate_lookaround_init(behaviortreeentity);
    case 2:
      return hunt_lookaround_init(behaviortreeentity);
  }

  return 0;
}

function function_470c948e(behaviortreeentity) {
  if(isDefined(self.stealth.var_fbfca183) && self.stealth.var_fbfca183 != self.stealth.bsmstate) {
    function_df9a9513(behaviortreeentity);
  }

  if(!isDefined(self.stealth.var_fbfca183)) {
    function_ea5fc830(behaviortreeentity);
  }

  switch (self.stealth.var_fbfca183) {
    case 1:
      return investigate_lookaround(behaviortreeentity);
    case 2:
      return hunt_lookaround(behaviortreeentity);
  }

  return 0;
}

function function_df9a9513(behaviortreeentity) {
  switch (self.stealth.var_fbfca183) {
    case 1:
      return investigate_lookaround_terminate(behaviortreeentity);
    case 2:
      return hunt_lookaround_terminate(behaviortreeentity);
  }

  self.stealth.var_fbfca183 = undefined;
}

function hunt_lookaround_init(behaviortreeentity) {
  taskid = behaviortreeentity gettaskid(1, "Hunt_LookAround");
  timeout = 8000;
  instancedata = spawnStruct();
  instancedata.endtime = gettime() + timeout;
  self.bt.instancedata[taskid] = instancedata;

  if(isDefined(self.stealth.script_huntlookaroundduration)) {
    instancedata.endtime = gettime() + self.stealth.script_huntlookaroundduration;
  }

  self namespace_979752dc::set_goal_radius(36);

  if(is_true(self.stealth.script_skiplookaroundanim)) {
    if(isDefined(self.stealth.script_huntlookaroundduration)) {
      self.stealth.binvestigatelookaround = 0;
    }
  } else {
    self.stealth.binvestigatelookaround = 1;
  }

  return true;
}

function hunt_lookaround(behaviortreeentity) {
  taskid = behaviortreeentity gettaskid(0, "Hunt_LookAround");

  if(isDefined(self.stealth.binitialhunt)) {
    return true;
  }

  if(gettime() > (isDefined(self.bt.instancedata[taskid].endtime) ? self.bt.instancedata[taskid].endtime : 0)) {
    return false;
  }

  if(!isDefined(self.stealth.binvestigatelookaround)) {
    return true;
  }

  if(self namespace_979752dc::function_b0c91323()) {
    self namespace_979752dc::function_ab75abf3();
    return true;
  }

  var_b0938e0c = isDefined(self.cqb_target);
  var_f3541bde = hunt_cqbtargetupdate(self.bt.instancedata[taskid]);

  if(!var_b0938e0c && isDefined(self.cqb_target) && var_f3541bde) {
    self.stealth.binvestigatelookaround = undefined;
    targetpos = self.cqb_target;

    if(!isvec(self.cqb_target)) {
      targetpos = self.cqb_target.origin;
    }

    self namespace_979752dc::set_patrol_react(targetpos, "small");
  }

  return true;
}

function hunt_lookaround_terminate(behaviortreeentity) {
  taskid = behaviortreeentity gettaskid(0, "Hunt_LookAround");
  self.bt.instancedata[taskid] = undefined;
  self.stealth.binvestigatelookaround = undefined;

  if(!self haspath()) {
    self hunt_getpos();
  }

  return true;
}

function hunt_terminate() {
  self.stealth.binitialhunt = undefined;
  self.stealth.hunthunkerlastexposetime = undefined;
  self.stealth.var_627b2039 = undefined;
  self.diequietly = 0;
  self.moveplaybackrate = 1;
  self.allowturn45 = undefined;
  self hunt_clearroomdata();
  self.cqb_target = undefined;
  self namespace_979752dc::set_goal(self.origin);
  self flashlight::function_ac53d0fb();
  return true;
}

function function_4efdd16b(smartobj) {
  if(smartobj === self.smart_object) {
    return;
  }

  self smart_object::set(smartobj);
  self thread function_b927bc45(smartobj);
  self namespace_979752dc::set_goal_radius(16);
  return smartobj;
}

function function_b927bc45(smartobj) {
  self notify("458850aa791fb2ad");
  self endon("458850aa791fb2ad");
  self endon(#"death", #"hash_6b1e2ef3367a9c8b", #"hash_5eea84497843d6f7");
  self waittill(#"goal");
  waitframe(1);

  while(is_true(self.isarriving)) {
    waitframe(1);
  }

  if(smartobj === self.smart_object && smart_object::can_use(self.smart_object) && distancesquared(self.origin, self.smart_object.origin) <= sqr(self.goalradius + 1)) {
    self function_4adeb7ed(self.smart_object);
  }
}

function function_5bfdfc9d() {
  if(isDefined(self.var_3ed929ba) && !self ishunting()) {
    if(self.var_3ed929ba != self flashlight::function_b8090745()) {
      return true;
    }
  }

  return false;
}

function function_4adeb7ed(smartobj) {
  self notify("20a47696d306d324");
  self endon("20a47696d306d324");
  self endon(#"death");
  self notify(#"hash_335827d811ed5f67");
  smartobj smart_object::play(self);

  if(self.stealth.bsmstate !== 3) {
    self function_2640a26c(1);
  }

  self function_f2887688();
}

function function_f2887688() {
  self smart_object::function_bd54ea4c();
  self smart_object::function_a59dc8a8(self.smart_object);
  self notify(#"hash_6b1e2ef3367a9c8b");
}

function function_e6aa814a() {
  self endon(#"death");
  wait 0.5;

  while(is_true(self.stealth.reacting)) {
    waitframe(1);
  }

  if(isDefined(self.fnstealthflashlightdetach)) {
    self[[self.fnstealthflashlightdetach]]();
  }
}

function combat_init() {
  self.dontattackme = 0;
  self.diequietly = 0;
  self.bisincombat = 1;

  if(self flashlight::function_3aec1b7()) {
    self flashlight::function_ac53d0fb();
  }

  if(self flashlight::function_47df32b8()) {
    self thread function_e6aa814a();
  }

  self ai::look_at(undefined);
  self namespace_979752dc::clear_movement_speed();
  self namespace_979752dc::set_goal_radius(undefined);
  self stealth_event::event_escalation_clear();
  self function_94575fdf();

  if(isDefined(self.script_combatmode)) {
    self.combatmode = self.script_combatmode;
  } else {
    self.combatmode = "cover";
  }

  stealth_enemy::set_sight_state("combat");
  enemypos = self.origin;
  goalvolume = level.stealth.combat_volumes[self.script_stealthgroup];

  if(isDefined(goalvolume)) {
    self namespace_979752dc::set_goal(goalvolume, undefined, -1);
  } else if(isDefined(level.stealth.combat_goalradius) && isDefined(level.stealth.combat_goalradius[self.script_stealthgroup])) {
    self namespace_979752dc::set_goal(self.scriptgoalpos);
    self namespace_979752dc::set_goal_radius(level.stealth.combat_goalradius[self.script_stealthgroup]);
  }

  self forceupdategoalpos();

  if(isDefined(self.stealth.funcs[# "spotted"])) {
    self namespace_b2b86d39::stealth_call_thread("spotted");
  }

  self.grenadeawareness = self.var_13c8de0c;
  self.gunposeoverride_internal = undefined;

  if(self flashlight::function_47df32b8()) {
    self flashlight::function_9b7441d1(0);
  }

  return true;
}

function combat_terminate() {
  self namespace_979752dc::set_goal(self.origin);
  self namespace_979752dc::function_6a3b08d0();
  return true;
}

function clearstealthvolume() {
  if(isDefined(level.stealth.combat_volumes[self.script_stealthgroup]) && self iscombating() || isDefined(level.stealth.hunt_volumes[self.script_stealthgroup]) && self ishunting()) {
    self namespace_979752dc::set_goal(self.origin);
  }
}

function function_e5b8ad1b() {
  if(isDefined(self.script_stealthgroup)) {
    groupdata = stealth_group::getgroup(self.script_stealthgroup);
    stealth_group::group_removefrompod(groupdata, self);
  }
}

function setstealthstate(statename, e) {
  if(!level flag::get("stealth_enabled") || !isDefined(self.stealth)) {
    return;
  }

  if(!isalive(self)) {
    return;
  }

  switch (statename) {
    case # "idle":
      self.dontattackme = 1;
      self.diequietly = 1;

      if(is_true(self.stealth.blind)) {
        self stealth_enemy::set_sight_state("blind");
      } else {
        self stealth_enemy::set_sight_state("hidden");
      }

      self function_e5b8ad1b();
      self enterstealthstate(0, e);
      self notify(#"stealth_idle");
      break;
    case # "investigate":
      e endon(#"entitydeleted");

      if(e.type == "cover_blown") {
        self.stealth.bcoverhasbeenblown = 1;
      }

      if(self.stealth.bsmstate == 1) {
        if(self.alertlevel == "high_alert" && e.typeorig == "sight" && self namespace_979752dc::function_d58e1c1c()) {
          function_d004e2c7(e);
        } else {
          if(isPlayer(self.stealth.investigate_entity) && !isPlayer(e.entity) && e.typeorig != "saw_corpse") {
            break;
          }

          if(isDefined(self.stealth.investigate_severity)) {
            if(self.stealth.investigateevent.typeorig == "saw_corpse" && e.typeorig == "found_corpse" && e.entity == self.stealth.investigate_entity) {
              break;
            }

            importancediff = stealth_event::event_severity_compare(self.stealth.investigate_severity, e.type);

            if(importancediff >= 0) {
              self.stealth.investigate_severity = e.type;
              self.stealth.investigate_entity = e.entity;
              self.stealth.investigateevent = e;
            }

            curtime = gettime();
            bupdate = importancediff > 0 || curtime > self.stealth.investigateevent_time || distancesquared(e.investigate_pos, self.origin) < distancesquared(self.stealth.investigateevent.investigate_pos, self.origin);

            if(bupdate) {
              groupdata = stealth_group::getgroup(self.script_stealthgroup);
              pod = stealth_group::group_findpod(groupdata, self);
              existingpod = stealth_group::group_trytojoinexistingpod(groupdata, pod, 1, self, e.investigate_pos);

              if(isDefined(existingpod)) {
                pod = existingpod;
              }

              if(isDefined(pod)) {
                pod stealth_group::pod_updateinvestigateorigin(self, e.investigate_pos);
              }

              self.stealth.investigateevent_time = curtime;
            }

            self.stealth.investigateendtime = undefined;
          }
        }
      } else {
        if(e.type == "cover_blown") {
          stealth_group::group_eventcoverblown(self.script_stealthgroup, self, e);
        } else {
          stealth_group::group_eventinvestigate(self.script_stealthgroup, self, e);
        }

        self.stealth.investigateevent = e;
        self.stealth.investigateevent_time = gettime();
        self enterstealthstate(1, e);
        self notify(#"stealth_investigate");
      }

      break;
    case # "hunt":
      self.stealth.bcoverhasbeenblown = 1;
      stealth_group::group_eventhunt(self.script_stealthgroup, self);
      self enterstealthstate(2, e);
      self notify(#"stealth_hunt");
      break;
    case # "combat":
      if(self.stealth.bsmstate != 3) {
        var_d6b5966 = isDefined(e) && e.typeorig == "damage" && self.allowpain && !self isinscriptedstate();

        if(isDefined(e) && !var_d6b5966) {
          magnitude = "small";
          var_bed01a48 = hash(e.typeorig);

          switch (var_bed01a48) {
            case # "proximity":
              magnitude = "small_medium";
              break;
            case # "projectile_impact":
            case # "ally_damaged":
            case # "bulletwhizby":
            case # "ally_killed":
            case # "gunshot":
              magnitude = "medium";
              break;
            case # "explode":
            case # "grenade danger":
              magnitude = "large";
              break;
            case # "light_killed":
            case # "attack":
            case # "combat":
              if(distancesquared(e.investigate_pos, self.origin) < 40000) {
                magnitude = "medium";
              }

              break;
          }

          enemy = self.enemy;

          if(!isDefined(enemy) && isDefined(e.entity) && issentient(e.entity)) {
            enemy = e.entity;
          }

          if(magnitude == "small" && isDefined(enemy)) {
            if(self cansee(enemy)) {
              magnitude = "medium";
            } else if(e.typeorig == "sight") {
              magnitude = "small_medium";
            }
          }

          self namespace_979752dc::set_patrol_style("combat", 1, e.investigate_pos, magnitude);
        } else {
          self namespace_979752dc::set_patrol_style("combat");
        }

        if(isDefined(e) && var_d6b5966 && self flashlight::function_b8090745()) {}
      }

      self.stealth.bcoverhasbeenblown = 1;
      enemy = undefined;

      if(isDefined(e) && isDefined(e.entity)) {
        if(issentient(e.entity) && e.entity.team == self.team) {
          if(isDefined(e.entity.enemy) && issentient(e.entity.enemy)) {
            self copyenemyinfo(e.entity);
          }
        } else {
          enemy = e.entity;
        }
      }

      stealth_group::group_eventcombat(self.script_stealthgroup, self, enemy);
      self enterstealthstate(3, e);
      self notify(#"stealth_combat");
      break;
  }
}

function ifshoulddosmartobject(behaviortreeentity) {
  smartobj = self.smart_object;

  if(!isDefined(smartobj)) {
    return false;
  }

  if(isDefined(self.disablesmartobjects)) {
    return false;
  }

  if(is_true(self.isarriving)) {
    return false;
  }

  zdiff = self.origin[2] - smartobj.origin[2];

  if(zdiff * zdiff > 5184) {
    return false;
  }

  if(distance2dsquared(self.origin, smartobj.origin) > 225) {
    return false;
  }

  return true;
}

function dosmartobject_init(behaviortreeentity) {
  taskid = behaviortreeentity gettaskid(1, "smart_object");
  smartobj = self.smart_object;

  if(!isDefined(smartobj)) {
    return false;
  }

  if(!isDefined(self.bt.instancedata[taskid])) {
    self.bt.instancedata[taskid] = spawnStruct();
    self.bt.instancedata[taskid].disableautolookat = self.disableautolookat;
    self.bt.instancedata[taskid].smart_object = self.smart_object;
  }

  if(self.bt.instancedata[taskid].smart_object === self.smart_object && is_true(behaviortreeentity.var_c48f9f7d)) {
    return true;
  }

  smartobj thread smart_object::play(behaviortreeentity);
  self.disableautolookat = 1;
  return true;
}

function dosmartobject(behaviortreeentity) {
  taskid = behaviortreeentity gettaskid(0, "smart_object");

  if(self.bt.instancedata[taskid].smart_object !== self.smart_object || !isDefined(behaviortreeentity.var_c48f9f7d)) {
    return false;
  }

  return true;
}

function dosmartobjectterminate(behaviortreeentity) {
  taskid = behaviortreeentity gettaskid(0, "smart_object");
  self.disableautolookat = self.bt.instancedata[taskid].disableautolookat;
  self.bt.instancedata[taskid] = undefined;
  return true;
}