/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\cybercom\_cybercom_gadget_firefly.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_achievements;
#using scripts\cp\cybercom\_cybercom;
#using scripts\cp\cybercom\_cybercom_gadget;
#using scripts\cp\cybercom\_cybercom_util;
#using scripts\cp\gametypes\_battlechatter;
#using scripts\shared\abilities\_ability_player;
#using scripts\shared\abilities\_ability_util;
#using scripts\shared\animation_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\statemachine_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_ai_shared;
#using scripts\shared\vehicle_shared;
#using_animtree("generic");
#namespace cybercom_gadget_firefly;

function init() {
  clientfield::register("vehicle", "firefly_state", 1, 4, "int");
  clientfield::register("actor", "firefly_state", 1, 4, "int");
  scene::add_scene_func("p7_fxanim_gp_ability_firefly_launch_bundle", & on_scene_firefly_launch, "play");
  scene::add_scene_func("p7_fxanim_gp_ability_firebug_launch_bundle", & on_scene_firefly_launch, "play");
}

function main() {
  cybercom_gadget::registerability(2, 8, 1);
  level.cybercom.firefly_swarm = spawnStruct();
  level.cybercom.firefly_swarm._is_flickering = & _is_flickering;
  level.cybercom.firefly_swarm._on_flicker = & _on_flicker;
  level.cybercom.firefly_swarm._on_give = & _on_give;
  level.cybercom.firefly_swarm._on_take = & _on_take;
  level.cybercom.firefly_swarm._on_connect = & _on_connect;
  level.cybercom.firefly_swarm._on = & _on;
  level.cybercom.firefly_swarm._off = & _off;
  level.cybercom.firefly_swarm._is_primed = & _is_primed;
}

function _is_flickering(slot) {}

function _on_flicker(slot, weapon) {}

function _on_give(slot, weapon) {
  self.cybercom.targetlockcb = & _get_valid_targets;
  self.cybercom.targetlockrequirementcb = & _lock_requirement;
  self thread cybercom::function_b5f4e597(weapon);
  self cybercom::function_8257bcb3("base_rifle", 2);
  self cybercom::function_8257bcb3("fem_rifle", 2);
  self cybercom::function_8257bcb3("riotshield", 2);
}

function _on_take(slot, weapon) {}

function _on_connect() {}

function _on(slot, weapon) {
  cybercom::function_adc40f11(weapon, 1);
  self thread spawn_firefly_swarm(self hascybercomability("cybercom_fireflyswarm") == 2);
  self notify("bhtn_action_notify", "firefly_deploy");
  if(isplayer(self)) {
    itemindex = getitemindexfromref("cybercom_fireflyswarm");
    if(isDefined(itemindex)) {
      self adddstat("ItemStats", itemindex, "stats", "used", "statValue", 1);
    }
  }
}

function _off(slot, weapon) {}

function _is_primed(slot, weapon) {}

function ai_activatefireflyswarm(target, var_9bc2efcb = 1, upgraded = 1) {
  self endon("death");
  if(self.archetype != "human") {
    return;
  }
  if(isDefined(var_9bc2efcb) && var_9bc2efcb) {
    type = self cybercom::function_5e3d3aa();
    self orientmode("face default");
    self animscripted("ai_cybercom_anim", self.origin, self.angles, ("ai_base_rifle_" + type) + "_exposed_cybercom_activate");
    self playSound("gdt_firefly_activate_npc");
    self waittillmatch("ai_cybercom_anim");
  }
  if(isarray(target)) {
    foreach(guy in target) {
      if(!isDefined(guy)) {
        continue;
      }
      if(isDefined(guy.archetype) && (guy.archetype == "human" || guy.archetype == "human_riotshield" || guy.archetype == "zombie")) {
        self thread spawn_firefly_swarm(upgraded, guy, 1);
      }
    }
  } else if(isDefined(target)) {
    if(isDefined(target.archetype) && (target.archetype == "human" || target.archetype == "human_riotshield" || target.archetype == "zombie")) {
      self thread spawn_firefly_swarm(upgraded, target);
    }
  }
}

function on_scene_firefly_launch(a_ents) {
  anim_model = a_ents["ability_firefly_launch"];
  anim_model waittill("firefly_launch_vehicle");
  if(isDefined(anim_model)) {
    origin = anim_model gettagorigin("tag_fx_01_end_jnt");
    angles = anim_model gettagangles("tag_fx_01_end_jnt");
    anim_model delete();
  }
  if(isDefined(self.owner)) {
    if(!isDefined(origin)) {
      origin = self.owner.origin + vectorscale((0, 0, 1), 72);
    }
    if(!isDefined(angles)) {
      angles = self.owner.angles;
    }
    self.owner notify("firefly_intro_done", origin, angles);
  }
}

function initthreatbias() {
  aiarray = getaiarray();
  foreach(ai in aiarray) {
    if(ai === self) {
      continue;
    }
    if(ai.ignorefirefly === 1) {
      ai setpersonalignore(self);
    }
  }
}

function spawn_firefly_swarm(upgraded, targetent, swarms = getdvarint("scr_firefly_swarm_count", 3), swarmsplits = getdvarint("scr_firefly_swarm_split_count", 0)) {
  self endon("death");
  lifetime = getdvarint("scr_firefly_swarm_lifetime", 14);
  splitsleft = swarmsplits;
  offspring = 0;
  firebugs = 0;
  fovtargets = [];
  if(isDefined(targetent) && (isDefined(targetent.is_disabled) && targetent.is_disabled)) {
    targetent = undefined;
  }
  if(!isvehicle(self)) {
    s_anim_pos = spawnStruct();
    s_anim_pos.owner = self;
    if(isplayer(self)) {
      origin = self getEye();
      angles = self getplayerangles();
    } else {
      origin = self gettagorigin("tag_eye");
      angles = self gettagangles("tag_eye");
    }
    frontgoal = origin + (anglesToForward(angles) * 100);
    trace = bulletTrace(origin, frontgoal, 0, undefined);
    if(trace["fraction"] == 1) {
      s_anim_pos.origin = origin;
      s_anim_pos.angles = angles;
      if(upgraded) {
        if(sessionmodeiscampaignzombiesgame() && isworldpaused()) {} else {
          s_anim_pos thread scene::play("p7_fxanim_gp_ability_firebug_launch_bundle");
          self waittill("firefly_intro_done", origin, angles);
        }
      } else {
        if(sessionmodeiscampaignzombiesgame() && isworldpaused()) {} else {
          s_anim_pos thread scene::play("p7_fxanim_gp_ability_firefly_launch_bundle");
          self waittill("firefly_intro_done", origin, angles);
        }
      }
    } else {
      origin = self.origin + vectorscale((0, 0, 1), 72);
      angles = self.angles;
    }
    if(upgraded) {
      lifetime = getdvarint("scr_firefly_swarm_upgraded_lifetime", 14);
      firebugs = getdvarint("scr_firefly_swarm_firebug_count", 1);
    }
    lifetime = lifetime * 1000;
    shelflife = gettime() + lifetime;
    fovtargets = self get_swarm_targetswithinfov(self.origin, self.angles);
  } else {
    shelflife = self.lifetime;
    swarms = 1;
    splitsleft = 0;
    offspring = 1;
    firebugs = (isDefined(self.firebugcount) ? self.firebugcount : 0);
    origin = self.origin;
    angles = self.angles;
  }
  while(swarms) {
    swarm = spawnvehicle("spawner_bo3_cybercom_firefly", origin, angles, "firefly_swarm");
    swarms--;
    if(isDefined(swarm)) {
      if(sessionmodeiscampaignzombiesgame()) {
        swarm setignorepauseworld(1);
      }
      swarm.threatbias = -300;
      if(!isDefined(targetent)) {
        if(fovtargets.size) {
          targetent = cybercom::getclosestto(swarm.origin, fovtargets);
          arrayremovevalue(fovtargets, targetent, 0);
        }
      }
      swarm.swarm_id = level.cybercom.swarms_released;
      swarm.owner = self;
      swarm.team = self.team;
      swarm.lifetime = shelflife;
      swarm.splitsleft = splitsleft;
      swarm.targetent = targetent;
      swarm.isoffspring = offspring;
      swarm.firebugcount = firebugs;
      swarm.firefly = 1;
      swarm.debug = spawnStruct();
      swarm.debug.main = 0;
      swarm.debug.attack = 0;
      swarm.debug.hunt = 0;
      swarm.debug.move = 0;
      swarm.debug.dead = 0;
      swarm initthreatbias();
      swarm.state_machine = statemachine::create("brain", swarm, "swarm_change_state");
      swarm.state_machine statemachine::add_state("init", & swarm_state_enter, & swarm_init, & swarm_state_cleanup);
      swarm.state_machine statemachine::add_state("main", & swarm_state_enter, & swarm_main_think, & swarm_state_cleanup);
      swarm.state_machine statemachine::add_state("move", & swarm_state_enter, & swarm_move_think, & swarm_state_cleanup);
      swarm.state_machine statemachine::add_state("attack", & swarm_state_enter, & swarm_attack_think, & swarm_state_cleanup);
      swarm.state_machine statemachine::add_state("hunt", & swarm_state_enter, & swarm_hunt_think, & swarm_state_cleanup);
      swarm.state_machine statemachine::add_state("dead", & swarm_state_enter, & swarm_dead_think, & swarm_state_cleanup);
      swarm.state_machine statemachine::set_state("init");
      targetent = undefined;
    }
    level notify("cybercom_swarm_released", swarm);
    level.cybercom.swarms_released = level.cybercom.swarms_released + 1;
    level.cybercom.var_12f85dec++;
  }
}

function function_54bc061f() {
  self endon("death");
  wait(0.1);
  for(;;) {
    self setspeed(self.settings.defaultmovespeed);
    self.current_pathto_pos = getnextmoveposition_tactical();
    if(isDefined(self.current_pathto_pos)) {
      usepathfinding = 1;
      if(self.isonnav === 0) {
        usepathfinding = 0;
      }
      if(self setvehgoalpos(self.current_pathto_pos, 1, usepathfinding)) {
        self thread path_update_interrupt();
        self vehicle_ai::waittill_pathing_done();
      }
    }
    wait(0.5);
  }
}

function path_update_interrupt() {
  self endon("death");
  self endon("near_goal");
  self endon("reached_end_node");
  wait(1);
  while(true) {
    if(isDefined(self.current_pathto_pos)) {
      if(distance2dsquared(self.current_pathto_pos, self.goalpos) > (self.goalradius * self.goalradius)) {
        wait(0.2);
        self notify("near_goal");
      }
    }
    wait(0.2);
  }
}

function getnextmoveposition_tactical() {
  if(self.goalforced) {
    goalpos = self getclosestpointonnavvolume(self.goalpos, 100);
    if(isDefined(goalpos)) {
      if(distancesquared(goalpos, self.goalpos) > (50 * 50)) {
        self.isonnav = 0;
      }
      return goalpos;
    }
    return self.goalpos;
  }
  querymultiplier = 1;
  queryresult = positionquery_source_navigation(self.origin, 80, 500 * querymultiplier, 500, (3 * self.radius) * querymultiplier, self, self.radius * querymultiplier);
  positionquery_filter_distancetogoal(queryresult, self);
  vehicle_ai::positionquery_filter_outofgoalanchor(queryresult);
  self.isonnav = queryresult.centeronnav;
  best_point = undefined;
  best_score = -999999;
  foreach(point in queryresult.data) {
    randomscore = randomfloatrange(0, 100);
    disttooriginscore = point.disttoorigin2d * 0.2;
    point.score = point.score + (randomscore + disttooriginscore);
    if(!isDefined(point._scoredebug)) {
      point._scoredebug = [];
    }
    point._scoredebug[""] = disttooriginscore;
    point.score = point.score + disttooriginscore;
    if(point.score > best_score) {
      best_score = point.score;
      best_point = point;
    }
  }
  self vehicle_ai::positionquery_debugscores(queryresult);
  if(!isDefined(best_point)) {
    return undefined;
  }
  return best_point.origin;
}

function swarm_state_cleanup(params) {
  if(isDefined(self.badplace)) {
    badplace_delete("swarmBP_" + self.swarm_id);
    self.badplace = undefined;
  }
}

function swarm_state_enter(params) {
  wait(0.05);
}

function getenemyteam() {
  if(self.team === "axis") {
    return "allies";
  }
  return "axis";
}

function swarm_init(params) {
  self setModel("tag_origin");
  self notsolid();
  self.notsolid = 1;
  self.vehaircraftcollisionenabled = 0;
  self notify("end_nudge_collision");
  self.ignoreall = 1;
  self.takedamage = 0;
  self.goalradius = 36;
  self.goalheight = 36;
  self.good_melee_target = 1;
  self setneargoalnotifydist(48);
  self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
  if(getdvarint("scr_firefly_swarm_debug", 0)) {
    self thread cybercom::draworiginforever();
  }
  self thread swarm_death_wait();
  self thread swarm_split_monitor();
  self clearforcedgoal();
  self setgoal(self.origin, 1, self.goalradius);
  if(!ispointinnavvolume(self.origin, "navvolume_small")) {
    if(isDefined(self.owner)) {
      eye_origin = self.owner getEye();
    } else {
      eye_origin = self.origin;
    }
    pointonnavvolume = self getclosestpointonnavvolume(eye_origin, 100);
    if(isDefined(pointonnavvolume)) {
      if(!self.firebugcount) {
        self clientfield::set("firefly_state", 2);
      } else {
        self clientfield::set("firefly_state", 7);
      }
      self setvehgoalpos(pointonnavvolume, 1, 0);
      self util::waittill_any_timeout(2, "near_goal");
    }
  }
  self thread function_54bc061f();
  if(!(isDefined(self.isoffspring) && self.isoffspring)) {
    enemies = self _get_valid_targets();
    closetargets = arraysortclosest(enemies, self.origin, enemies.size, 0, 512);
    if(closetargets.size == 0) {
      angles = (self.angles[0], self.angles[1], 0);
      frontgoal = self.origin + (anglesToForward(angles) * 240);
      a_trace = bulletTrace(self.origin, frontgoal, 0, undefined, 1);
      hitp = a_trace["position"];
      queryresult = positionquery_source_navigation(hitp, 0, 72, 72, 20, self);
      if(queryresult.data.size > 0) {
        pathsuccess = self findpath(self.origin, queryresult.data[0].origin, 1, 0);
        if(pathsuccess) {
          if(getdvarint("scr_firefly_swarm_debug", 0)) {
            level thread cybercom::debug_circle(queryresult.data[0].origin, 16, 10, (1, 0, 0));
          }
          self clearforcedgoal();
          self setgoal(queryresult.data[0].origin, 1, self.goalradius);
          if(!self.firebugcount) {
            self clientfield::set("firefly_state", 2);
          } else {
            self clientfield::set("firefly_state", 7);
          }
          self util::waittill_any_timeout(5, "near_goal");
        }
      }
    }
  }
  if(isDefined(self.targetent) && isalive(self.targetent)) {
    self.targetent.swarm = self;
    self.state_machine statemachine::set_state("move");
  } else {
    self.state_machine statemachine::set_state("hunt");
  }
}

function swarm_split_monitor() {
  self endon("swarm_is_dead");
  self endon("death");
  wait(3);
  while(self.splitsleft > 0) {
    wait(0.5);
    nearent = self swarm_find_good_target(getdvarint("scr_firefly_swarm_split_radius", 864));
    if(isDefined(nearent)) {
      self thread spawn_firefly_swarm(0, nearent);
      self.splitsleft--;
    }
  }
}

function swarm_attackhumantarget(target) {
  reactionanims = [];
  base = "base_rifle";
  if(isDefined(self.voiceprefix) && getsubstr(self.voiceprefix, 7) == "f") {
    base = "fem_rifle";
  } else if(target.archetype === "human_riotshield") {
    base = "riotshield";
  }
  type = target cybercom::function_5e3d3aa();
  if(type == "") {
    target.swarm = undefined;
    self.targetent = undefined;
    target.var_86386274 = gettime() + 1000;
    self.state_machine statemachine::set_state("main");
    return;
  }
  self thread swarm_monitortargetdeath(target);
  self clientfield::set("firefly_state", 1);
  variant = self.owner cybercom::getanimationvariant(base);
  if(self.firebugcount > 0) {
    self.firebugcount--;
    reactionanims["intro"] = (((("ai_" + base) + "_") + type) + "_exposed_swarm_upg_react_intro") + variant;
    target thread _firebombtarget(self, reactionanims, getweapon("gadget_firefly_swarm_upgraded"));
    target notify("bhtn_action_notify", "fireflyAttack");
    target clientfield::set("firefly_state", 9);
  } else {
    if(target.archetype === "human") {
      reactionanims["intro"] = (((("ai_" + base) + "_") + type) + "_exposed_swarm_react_intro") + variant;
      reactionanims["outro"] = (((("ai_" + base) + "_") + type) + "_exposed_swarm_react_outro") + variant;
    } else {
      reactionanims = [];
    }
    target clientfield::set("firefly_state", 4);
    target thread _reacttoswarm(self, reactionanims, getweapon("gadget_firefly_swarm"));
    target notify("bhtn_action_notify", "fireflyAttack");
  }
  self waittill("attack_stopped");
}

function swarm_attackzombietarget(target) {
  assert(isDefined(target));
  if(!self.firebugcount) {
    target clientfield::set("firefly_state", 4);
  } else {
    target clientfield::set("firefly_state", 9);
  }
  if(self.firebugcount > 0) {
    self.firebugcount--;
    target clientfield::set("arch_actor_fire_fx", 1);
    target.health = 1;
  }
  wait(1);
  if(isDefined(target)) {
    target.swarm = undefined;
  }
  wait(randomintrange(3, 7));
  if(isDefined(target) && isalive(target)) {
    target dodamage(target.health, target.origin, undefined, undefined, "none", "MOD_BURNED");
  }
}

function function_cb5f9a2(target) {
  assert(isDefined(target));
  if(!self.firebugcount) {
    target clientfield::set("firefly_state", 4);
  } else {
    target clientfield::set("firefly_state", 9);
  }
  self thread swarm_monitortargetdeath(target);
  self clientfield::set("firefly_state", 1);
  reactionanims = [];
  if(self.firebugcount > 0 && target.health <= getdvarint("scr_firefly_swarm_warlord_hitpoint_allowed_thresh", 400)) {
    self.firebugcount--;
    target thread _firebombtarget(self, reactionanims, getweapon("gadget_firefly_swarm_upgraded"));
    target notify("bhtn_action_notify", "fireflyAttack");
    target clientfield::set("firefly_state", 9);
  } else {
    target clientfield::set("firefly_state", 4);
    target thread _reacttoswarm(self, reactionanims, getweapon("gadget_firefly_swarm"));
    target notify("bhtn_action_notify", "fireflyAttack");
  }
  self waittill("attack_stopped");
}

function swarm_attackplayertarget(target) {
  self thread fireflyplayereffect(target);
  if(isDefined(self.owner)) {
    attacker = self.owner;
  } else {
    attacker = self;
  }
  target dodamage(getdvarint("scr_swarm_player_damage", 50), target.origin, attacker, self, "none", "MOD_UNKNOWN", 0, getweapon("gadget_firefly_swarm_upgraded"));
}

function swarm_attack_think(params) {
  self endon("swarm_is_dead");
  self endon("death");
  self.debug.attack++;
  self clientfield::set("firefly_state", 1);
  target = self.targetent;
  if(!isDefined(target) || !isalive(target)) {
    self.targetent = undefined;
    self.state_machine statemachine::set_state("main");
    return;
  }
  target notify("hash_f8c5dd60", getweapon("gadget_firefly_swarm"), self.owner);
  if(!self.firebugcount) {
    target clientfield::set("firefly_state", 4);
  } else {
    target clientfield::set("firefly_state", 9);
  }
  if(isDefined(target.archetype)) {
    if(target.archetype == "human" || target.archetype == "human_riotshield") {
      self setgoal(self.targetent.origin + vectorscale((0, 0, 1), 48), 1, self.goalradius);
      badplace_cylinder("swarmBP_" + self.swarm_id, 0, target.origin, 256, 80, "axis");
      self.badplace = 1;
      self swarm_attackhumantarget(target);
    } else {
      if(target.archetype == "zombie") {
        self swarm_attackzombietarget(target);
      } else if(target.archetype == "warlord") {
        self function_cb5f9a2(target);
      }
    }
  } else if(isplayer(target)) {
    self setgoal(self.targetent.origin + vectorscale((0, 0, 1), 48), 1, self.goalradius);
    badplace_cylinder("swarmBP_" + self.swarm_id, 0, target.origin, 256, 80, "axis");
    self.badplace = 1;
    self swarm_attackplayertarget(target);
  }
  self.targetent = undefined;
  self.state_machine statemachine::set_state("main");
  self.debug.attack--;
}

function swarm_monitortargetdeath(target) {
  self endon("death");
  self endon("attack_stopped");
  target waittill("death");
  self notify("attack_stopped");
}

function private _firebombtargetpain(swarm, reactionanims, weapon) {
  self endon("death");
  if(isDefined(swarm)) {
    self dodamage(5, self.origin, swarm.owner, swarm, "none", "MOD_BURNED", 0, weapon, -1, 1);
  }
  if(!self cybercom::function_421746e0()) {
    self waittillmatch("bhtn_action_terminate");
  }
  self notify("firebug_time_to_die", "specialpain");
}

function private _firebombtargetcorpselistener() {
  self waittill("actor_corpse", corpse);
  corpse clientfield::set("arch_actor_fire_fx", 2);
}

function private _firebombtarget(swarm, reactionanims, weapon) {
  self endon("death");
  self.ignoreall = 1;
  self.is_disabled = 1;
  var_c318824b = 0;
  self notify("hash_37486b44", swarm);
  level notify("hash_37486b44", self, swarm);
  if(self cybercom::islinked()) {
    self unlink();
    var_c318824b = 1;
  }
  if(!(isDefined(var_c318824b) && var_c318824b) && isDefined(reactionanims["intro"])) {
    self animscripted("swarm_intro_anim", self.origin, self.angles, reactionanims["intro"]);
    self waittillmatch("swarm_intro_anim");
  }
  self clientfield::set("arch_actor_fire_fx", 1);
  self thread _firebombtargetcorpselistener();
  if(!(isDefined(var_c318824b) && var_c318824b)) {
    self thread _firebombtargetpain(swarm, reactionanims, weapon);
    self util::waittill_any_timeout(getdvarint("scr_firefly_swarm_human_burn_duration", 10), "firebug_time_to_die");
  }
  self clientfield::set("firefly_state", 10);
  if(isDefined(swarm)) {
    swarm notify("attack_stopped", "end");
    if(isDefined(self.voiceprefix) && isDefined(self.bcvoicenumber)) {
      self thread battlechatter::do_sound((self.voiceprefix + self.bcvoicenumber) + "_exert_firefly_burning", 1);
    }
    swarm.owner notify("hash_304642e3");
    self dodamage(self.health, self.origin, swarm.owner, swarm, "none", "MOD_BURNED", 0, weapon, -1, 1);
  } else {
    if(isDefined(self.voiceprefix) && isDefined(self.bcvoicenumber)) {
      self thread battlechatter::do_sound((self.voiceprefix + self.bcvoicenumber) + "_exert_firefly_burning", 1);
    }
    self dodamage(self.health, self.origin, undefined, undefined, "none", "MOD_BURNED", 0, weapon, -1, 1);
  }
}

function private _deathlistener(swarm) {
  while(isDefined(swarm)) {
    self util::waittill_any_timeout(1, "damage");
    if(isDefined(self) && self.health <= 0) {
      self clientfield::set("firefly_state", 10);
      return;
    }
  }
}

function private _corpsewatcher(swarm) {
  swarm endon("death");
  self waittill("actor_corpse", corpse);
  corpse clientfield::set("firefly_state", 10);
}

function function_963f8ef6(match, note, var_1ccbc268, end) {
  self endon("death");
  if(isDefined(end)) {
    self endon(end);
    while(true) {
      if(isDefined(match)) {
        self waittillmatch(match);
      } else {
        self waittill(note);
      }
      self notify(var_1ccbc268, note);
    }
  } else {
    if(isDefined(match)) {
      self waittillmatch(match);
    } else {
      self waittill(note);
    }
    self notify(var_1ccbc268, note);
  }
}

function private _reacttoswarm(swarm, reactionanims, weapon) {
  self endon("death");
  self thread _corpsewatcher(swarm);
  oldaware = self.badplaceawareness;
  self.badplaceawareness = 0.1;
  self.is_disabled = 1;
  self orientmode("face point", swarm.origin);
  self notify("hash_4457f945", swarm);
  level notify("hash_4457f945", self, swarm);
  if(self cybercom::function_421746e0()) {
    self kill(self.origin, (isDefined(swarm.owner) ? swarm.owner : undefined));
    if(isDefined(swarm)) {
      swarm notify("attack_stopped");
    }
    return;
  }
  if(!isalive(self) || self isragdoll()) {
    return;
  }
  if(isDefined(reactionanims["intro"])) {
    self animscripted("swarm_intro_anim", self.origin, self.angles, reactionanims["intro"]);
    self thread cybercom::stopanimscriptedonnotify("damage", "swarm_intro_anim");
    self waittillmatch("swarm_intro_anim");
  }
  attack = 1;
  while(attack && isDefined(swarm)) {
    self dodamage(5, self.origin, swarm.owner, swarm, "none", "MOD_UNKNOWN", 0, weapon, -1, 1);
    wait(0.05);
    self waittillmatch("bhtn_action_terminate");
    attack = isDefined(swarm) && (!(isDefined(swarm.dying_out) && swarm.dying_out)) && (distancesquared(self.origin + vectorscale((0, 0, 1), 48), swarm.origin)) < (getdvarint("scr_firefly_swarm_attack_radius", 110) * getdvarint("scr_firefly_swarm_attack_radius", 110)) && isalive(self);
  }
  self notify("attack_stopped", "specialpain", "end");
  if(isalive(self) && !self isragdoll()) {
    self clientfield::set("firefly_state", 5);
    self.badplaceawareness = oldaware;
    self.swarm = undefined;
    self orientmode("face default");
    if(isDefined(reactionanims["outro"])) {
      self animscripted("swarm_outro_anim", self.origin, self.angles, reactionanims["outro"]);
      self thread cybercom::stopanimscriptedonnotify("damage", "swarm_outro_anim");
      self waittillmatch("swarm_outro_anim");
    }
    self.is_disabled = undefined;
  }
  if(isDefined(swarm)) {
    swarm notify("attack_stopped", "end");
  }
}

function swarm_delete() {
  if(isDefined(self)) {
    self notify("swarm_is_dead");
    if(isDefined(self.targetent) && !isplayer(self.targetent)) {
      self.targetent clientfield::set("firefly_state", 5);
      self.targetent.swarm = undefined;
      self.targetent.swarm_coolofftime = gettime() + 2000;
    }
    level.cybercom.var_12f85dec--;
    achievements::function_b2d1aafa();
    self swarm_state_cleanup();
    self delete();
  }
}

function swarm_death_wait() {
  self endon("death");
  while(gettime() < self.lifetime) {
    wait(1);
  }
  self.dying_out = 1;
  wait(2);
  self swarm_delete();
}

function swarm_dead_think(params) {
  self notify("swarm_is_dead");
  self endon("death");
  self clearforcedgoal();
  if(!self.firebugcount) {
    self clientfield::set("firefly_state", 5);
  } else {
    self clientfield::set("firefly_state", 10);
  }
  if(isDefined(self.targetent) && !isplayer(self.targetent)) {
    self.targetent clientfield::set("firefly_state", 5);
    self.targetent.swarm = undefined;
    self.targetent.swarm_coolofftime = gettime() + 2000;
  }
  self vehicle::toggle_sounds(0);
  if(isDefined(self.owner)) {
    self.owner notify("bhtn_action_notify", "firefly_end");
  }
  wait(3);
  self swarm_delete();
}

function swarm_main_think(params) {
  self endon("swarm_is_dead");
  self endon("death");
  if(isDefined(self.dying_out) && self.dying_out) {
    self.state_machine statemachine::set_state("dead");
    return;
  }
  self.debug.main++;
  if(!isDefined(self.targetent)) {
    self.state_machine statemachine::set_state("hunt");
  } else {
    if((distancesquared(self.targetent.origin + vectorscale((0, 0, 1), 48), self.origin)) > (getdvarint("scr_firefly_swarm_attack_radius", 110) * getdvarint("scr_firefly_swarm_attack_radius", 110))) {
      self.state_machine statemachine::set_state("move");
    } else {
      self.state_machine statemachine::set_state("attack");
    }
  }
  self.debug.main--;
}

function private _get_valid_targets() {
  humans = arraycombine(getaispeciesarray(self getenemyteam(), "human"), getaispeciesarray("team3", "human"), 0, 0);
  zombies = arraycombine(getaispeciesarray(self getenemyteam(), "zombie"), getaispeciesarray("team3", "zombie"), 0, 0);
  return arraycombine(humans, zombies, 0, 0);
}

function private _lock_requirement(target) {
  if(isDefined(self.owner) && !self.owner cybercom::targetisvalid(target, getweapon("gadget_firefly_swarm"))) {
    return false;
  }
  if(target.archetype != "human" && target.archetype != "human_riotshield" && target.archetype != "zombie" && target.archetype != "warlord") {
    return false;
  }
  if(target cybercom::cybercom_aicheckoptout("cybercom_fireflyswarm")) {
    return false;
  }
  if(isDefined(target.swarm)) {
    return false;
  }
  if(isDefined(target.var_86386274)) {
    if(target.var_86386274 > gettime()) {
      return false;
    }
    target.var_86386274 = undefined;
  }
  if(isDefined(target.swarm_coolofftime) && gettime() < target.swarm_coolofftime) {
    return false;
  }
  if(isactor(target) && target cybercom::function_78525729() != "stand" && target cybercom::function_78525729() != "crouch") {
    return false;
  }
  return true;
}

function get_swarm_targetswithinfov(origin, angles, var_10a84c6e = getdvarint("scr_firefly_swarm_hunt_radius", 1536), nfor = cos(45)) {
  enemies = self _get_valid_targets();
  closetargets = arraysortclosest(enemies, origin, enemies.size, 0, var_10a84c6e);
  fovtargets = [];
  foreach(guy in closetargets) {
    if(!_lock_requirement(guy)) {
      continue;
    }
    if(util::within_fov(origin, angles, guy.origin, nfor)) {
      fovtargets[fovtargets.size] = guy;
    }
  }
  return fovtargets;
}

function swarm_find_good_target(var_10a84c6e = getdvarint("scr_firefly_swarm_hunt_radius", 1536)) {
  self endon("swarm_is_dead");
  self endon("death");
  enemies = self _get_valid_targets();
  closetargets = arraysortclosest(enemies, self.origin, enemies.size, 0, var_10a84c6e);
  closest = undefined;
  while(closetargets.size > 0) {
    closest = cybercom::getclosestto(self.origin, closetargets, var_10a84c6e);
    if(!_lock_requirement(closest)) {
      arrayremovevalue(closetargets, closest, 0);
      closest = undefined;
      wait(0.05);
      continue;
    }
    if(!isDefined(closest)) {
      break;
    }
    pathsuccess = 0;
    queryresult = positionquery_source_navigation(closest.origin, 0, 128, 128, 20, self);
    if(queryresult.data.size > 0) {
      pathsuccess = self findpath(self.origin, queryresult.data[0].origin, 1, 0);
    }
    if(!pathsuccess) {
      arrayremovevalue(closetargets, closest, 0);
      closest = undefined;
      wait(0.05);
      continue;
    }
    break;
  }
  return closest;
}

function swarm_hunt_think(params) {
  self endon("swarm_is_dead");
  self endon("death");
  self.debug.hunt++;
  self util::waittill_any_timeout(3, "near_goal");
  self clearforcedgoal();
  if(!self.firebugcount) {
    self clientfield::set("firefly_state", 1);
  } else {
    self clientfield::set("firefly_state", 6);
  }
  if(getdvarint("scr_firefly_swarm_debug", 0)) {
    self thread cybercom::debug_circle(self.origin, getdvarint("scr_firefly_swarm_hunt_radius", 1536), 0.1, (1, 1, 0));
  }
  self.targetent = self swarm_find_good_target();
  if(isDefined(self.targetent)) {
    self.targetent.swarm = self;
  }
  self.state_machine statemachine::set_state("main");
  self.debug.hunt--;
}

function swarm_move_think(params) {
  self endon("swarm_is_dead");
  self endon("death");
  self.debug.move++;
  if(!self.firebugcount) {
    self clientfield::set("firefly_state", 2);
  } else {
    self clientfield::set("firefly_state", 7);
  }
  wait(0.5);
  self.goalradius = 12;
  self.goalheight = 12;
  if(!self.firebugcount) {
    self clientfield::set("firefly_state", 3);
  } else {
    self clientfield::set("firefly_state", 8);
  }
  self clearforcedgoal();
  if(isDefined(self.targetent)) {
    self setgoal(self.targetent.origin + vectorscale((0, 0, 1), 48), 1, self.goalradius);
    event = self util::waittill_any_timeout(30, "near_goal");
  }
  self.state_machine statemachine::set_state("main");
  self.debug.move--;
}

function fireflyplayereffect(player) {
  self endon("disconnect");
  player shellshock("proximity_grenade", 2, 0);
}