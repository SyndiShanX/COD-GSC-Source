/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\zombies\_util.gsc
**************************************/

agentclassregister(var_0, var_1) {
  if(isDefined(var_0.model_bodies) && isDefined(var_0.model_heads)) {}

  if(!isDefined(level.agentclasses)) {
    level.agentclasses = [];
  }

  level.agentclasses[var_1] = var_0;
}

agentclassget(var_0) {
  return level.agentclasses[var_0];
}

removeksicon(var_0, var_1, var_2) {
  if(var_2 != 1) {
    var_3 = "ks_icon" + common_scripts\utility::tostring(var_2);
    self setclientomnvar(var_3, 0);
  }
}

zombies_trigger_use_think() {
  self endon("death");
  self endon("zombies_make_unusable");

  while(isDefined(self)) {
    self waittill("trigger", var_0);

    if(!isDefined(self)) {
      continue;
    }
    self notify("player_used", var_0);

    if(isDefined(self.owner)) {
      self.owner notify("player_used", var_0);
    }
  }
}

zombies_make_usable(var_0, var_1) {
  zombies_make_unusable();
  self.trigger = spawn("script_model", self.origin);
  self.trigger.owner = self;
  self.trigger setModel("tag_origin");

  if(isDefined(var_1)) {
    self.trigger.origin = self.trigger.origin + var_1;
  }

  self.trigger linkto(self);
  self.trigger makeusable();
  self.trigger sethintstring(var_0);
  self.trigger thread zombies_trigger_use_think();
}

zombies_make_unusable() {
  self notify("zombies_make_unusable");

  if(isDefined(self.trigger)) {
    self.trigger notify("zombies_make_unusable");
    self.trigger delete();
  }

  self.trigger = undefined;
}

zombies_make_objective(var_0) {
  zombies_make_nonobjective();
  self.objid = maps\mp\gametypes\_gameobjects::getnextobjid();
  objective_add(self.objid, "invisible", (0, 0, 0));
  objective_position(self.objid, self.origin);
  objective_state(self.objid, "active");
  objective_icon(self.objid, var_0);
  objective_team(self.objid, "allies");
  objective_onentity(self.objid, self);
}

zombies_make_nonobjective() {
  if(isDefined(self.objid)) {
    maps\mp\_utility::_objective_delete(self.objid);
    self.objid = undefined;
  }
}

get_character_count(var_0) {
  var_1 = 0;

  foreach(var_3 in level.characters) {
    if(!isalive(var_3)) {
      continue;
    }
    if(isDefined(var_3.agent_type) && var_3.agent_type == var_0) {
      var_1++;
    }
  }

  return var_1;
}

getnumplayers() {
  var_0 = 0;

  if(!isDefined(level.players)) {
    return 0;
  }

  foreach(var_2 in level.players) {
    if(isonhumanteam(var_2)) {
      var_0++;
    }
  }

  return var_0;
}

isonhumanteam(var_0) {
  if(isDefined(var_0.team)) {
    return var_0.team == level.playerteam;
  }

  return 0;
}

isonhumanteamorspectator(var_0) {
  if(isDefined(var_0.team)) {
    if(var_0.team == level.playerteam || var_0.team == "spectator") {
      return 1;
    }
  }

  return 0;
}

iszombieequipment(var_0) {
  return iszombielethal(var_0) || iszombietactical(var_0);
}

iszombielethal(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "contact_grenade_throw_zombies_mp":
    case "contact_grenade_zombies_mp":
    case "frag_grenade_zombies_mp":
    case "frag_grenade_throw_zombies_mp":
      var_1 = 1;
      break;
  }

  return var_1;
}

iszombietactical(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "teleport_throw_zombies_mp":
    case "dna_aoe_grenade_zombie_mp":
    case "distraction_drone_throw_zombie_mp":
    case "distraction_drone_zombie_mp":
    case "explosive_drone_throw_zombie_mp":
    case "explosive_drone_zombie_mp":
    case "dna_aoe_grenade_throw_zombie_mp":
    case "teleport_zombies_mp":
    case "repulsor_zombie_mp":
      var_1 = 1;
      break;
  }

  return var_1;
}

iszombiedistractiondrone(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "distraction_drone_throw_zombie_mp":
    case "distraction_drone_zombie_mp":
      var_1 = 1;
      break;
  }

  return var_1;
}

iszombiednagrenade(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "dna_aoe_grenade_zombie_mp":
    case "dna_aoe_grenade_throw_zombie_mp":
      var_1 = 1;
      break;
  }

  return var_1;
}

playerhasweapon(var_0, var_1) {
  if(iszombieequipment(var_1)) {
    var_2 = getzombieequipmentalternatename(var_1);
    return var_0 hasweapon(var_1) || var_0 hasweapon(var_2);
  }

  return var_0 hasweapon(var_1);
}

getzombieequipmentalternatename(var_0) {
  var_1 = getpreexoequipment(var_0);

  if(!isDefined(var_1)) {
    var_1 = getpostexoequipmentname(var_0);
  }

  return var_1;
}

getpreexoequipment(var_0) {
  switch (var_0) {
    case "frag_grenade_zombies_mp":
      return "frag_grenade_throw_zombies_mp";
    case "contact_grenade_zombies_mp":
      return "contact_grenade_throw_zombies_mp";
    case "explosive_drone_zombie_mp":
      return "explosive_drone_throw_zombie_mp";
    case "distraction_drone_zombie_mp":
      return "distraction_drone_throw_zombie_mp";
    case "dna_aoe_grenade_zombie_mp":
      return "dna_aoe_grenade_throw_zombie_mp";
    case "teleport_zombies_mp":
      return "teleport_throw_zombies_mp";
    default:
      break;
  }

  return undefined;
}

getpostexoequipmentname(var_0) {
  switch (var_0) {
    case "frag_grenade_throw_zombies_mp":
      return "frag_grenade_zombies_mp";
    case "contact_grenade_throw_zombies_mp":
      return "contact_grenade_zombies_mp";
    case "explosive_drone_throw_zombie_mp":
      return "explosive_drone_zombie_mp";
    case "distraction_drone_throw_zombie_mp":
      return "distraction_drone_zombie_mp";
    case "dna_aoe_grenade_throw_zombie_mp":
      return "dna_aoe_grenade_zombie_mp";
    case "teleport_throw_zombies_mp":
      return "teleport_zombies_mp";
    default:
      break;
  }

  return undefined;
}

iszombiekillstreakweapon(var_0) {
  switch (var_0) {
    case "iw5_exominigunzm_mp":
    case "killstreak_uav_mp":
    case "airdrop_sentry_marker_mp":
      return 1;
    default:
      break;
  }

  return 0;
}

getplayerweaponzombies(var_0) {
  var_1 = var_0 getcurrentprimaryweapon();

  if(isDefined(var_0.changingweapon)) {
    var_1 = var_0.changingweapon;
  }

  if(!maps\mp\gametypes\_weapons::isprimaryweapon(var_1)) {
    var_1 = var_0 common_scripts\utility::getlastweapon();
  }

  if(!var_0 hasweapon(var_1)) {
    var_2 = var_0 getweaponslistprimaries();

    if(var_2.size > 0) {
      var_1 = var_2[0];
    }
  }

  return var_1;
}

getzombieweaponlevel(var_0, var_1) {
  var_2 = getweaponbasename(var_1);

  if(!haszombieweaponstate(var_0, var_2)) {
    return 0;
  }

  return var_0.weaponstate[var_2]["level"];
}

haszombieweaponstate(var_0, var_1) {
  return isDefined(var_1) && isDefined(var_0.weaponstate[var_1]);
}

requestzombieagent(var_0, var_1) {
  var_2 = undefined;

  for(;;) {
    var_2 = maps\mp\agents\_agent_common::connectnewagent(var_0, var_1);

    if(isDefined(var_2)) {
      break;
    }

    wait 0.1;
  }

  return var_2;
}

spawnbotagent(var_0, var_1, var_2) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  var_3 = requestzombieagent(var_1.agent_type, var_2);
  var_3 maps\mp\agents\_agents::spawn_agent_player(var_0.origin, var_0.angles);
  return var_3;
}

onspawnscriptagenthumanoid(var_0, var_1, var_2) {
  maps\mp\agents\humanoid\_humanoid::spawn_humanoid(self.animclass, var_0, var_1, var_2);
}

spawnscriptagent(var_0, var_1, var_2) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  var_3 = requestzombieagent(var_1.agent_type, var_2);
  var_3.animclass = undefined;

  if(isDefined(var_1.animclass)) {
    var_3.animclass = var_1.animclass;
  }

  var_3 thread[[var_3 maps\mp\agents\_agent_utility::agentfunc("spawn")]](var_0.origin, var_0.angles);

  if(isDefined(var_0.script_animation)) {
    if(isDefined(level.spawnanimationnotetrackhandlerassigner)) {
      var_4 = var_3[[level.spawnanimationnotetrackhandlerassigner]](var_0);
    } else {
      var_4 = undefined;
    }

    var_5 = isDefined(var_0.script_ghettotag) && var_0.script_ghettotag == "ignoreRealign";
    var_3 thread maps\mp\agents\humanoid\_humanoid_util::scriptedanimation(var_0.origin, var_0.angles, var_0.script_animation, 1, var_4, var_5);
  }

  if(isDefined(var_3) && isDefined(var_1)) {
    var_3 detachall();
    var_3.headmodel = undefined;

    if(isDefined(level.assignzombiemeshoverridefunc) && var_3[[level.assignzombiemeshoverridefunc]]()) {
      return var_3;
    }

    if(isDefined(var_1.model_bodies)) {
      var_6 = randomint(var_1.model_bodies.size);
      var_7 = common_scripts\utility::random(var_1.model_bodies[var_6]);
      var_3 setModel(var_7);

      if(isDefined(var_1.model_heads)) {
        var_3.headmodel = common_scripts\utility::random(var_1.model_heads[var_6]);
        var_3 attach(var_3.headmodel);
      }

      if(isDefined(var_1.model_limbs)) {
        var_3 attachlimb("right_leg", var_1.model_limbs[var_6]);
        var_3 attachlimb("left_leg", var_1.model_limbs[var_6]);
        var_3 attachlimb("right_arm", var_1.model_limbs[var_6]);
        var_3 attachlimb("left_arm", var_1.model_limbs[var_6]);
      }
    }
  }

  return var_3;
}

attachlimb(var_0, var_1) {
  self.limbmodels[var_0] = common_scripts\utility::random(var_1[var_0]);
  self attach(self.limbmodels[var_0]);
}

countlimbs(var_0) {
  for(var_1 = 0; var_0 > 0; var_0 = var_0 - (var_0 & 0 - var_0)) {
    var_1++;
  }

  return var_1;
}

getdismembersoundname() {
  if(checkactivemutator("exo")) {
    return "dismemberExoSound";
  } else {
    return "dismemberSound";
  }
}

onscriptagentkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self.isactive = 0;
  self.hasdied = 0;

  if(isDefined(self.animcbs.onexit[self.aistate])) {
    self[[self.animcbs.onexit[self.aistate]]]();
  }

  var_9 = undefined;

  if(isDefined(self.deathanimstateoverride)) {
    var_9 = self.deathanimstateoverride;
  } else if(self.species == "dog") {
    if(var_3 == "MOD_MELEE" && isDefined(var_1) && isplayer(var_1) && var_1 ishighjumpallowed()) {
      var_10 = vectornormalize(var_1.origin - self.origin);
      var_11 = anglesToForward(self.angles);
      var_12 = anglestoright(self.angles);
      var_13 = vectordot(var_10, var_11);
      var_14 = vectordot(var_10, var_12);

      if(abs(var_13) >= abs(var_14)) {
        if(var_13 >= 0) {
          var_9 = "death_melee_exo_front";
        } else {
          var_9 = "death_melee_exo_back";
        }
      } else if(var_14 >= 0) {
        var_9 = "death_melee_exo_left";
      } else {
        var_9 = "death_melee_exo_right";
      }
    } else {
      var_9 = "death";
    }
  } else if(var_3 == "MOD_MELEE") {
    if(isDefined(var_1) && isplayer(var_1) && var_1 ishighjumpallowed()) {
      var_10 = vectornormalize(var_1.origin - self.origin);
      var_11 = anglesToForward(self.angles);
      var_12 = anglestoright(self.angles);
      var_13 = vectordot(var_10, var_11);
      var_14 = vectordot(var_10, var_12);

      if(abs(var_13) >= abs(var_14)) {
        if(var_13 >= 0) {
          var_9 = "death_melee_exo_front";
        } else {
          var_9 = "death_melee_exo_back";
        }
      } else if(var_14 >= 0) {
        var_9 = "death_melee_exo_left";
      } else {
        var_9 = "death_melee_exo_right";
      }
    } else {
      var_9 = "death_melee_knife";
    }
  } else if(maps\mp\zombies\_mutators::isfullbodymutilation()) {
    if(self.movemode == "run" || self.movemode == "sprint") {
      var_9 = "death_full_body_run";
    } else {
      var_9 = "death_full_body_stand";
    }
  } else if(self.aistate == "idle" || self.aistate == "melee") {
    var_9 = "death_stand";
  } else {
    var_9 = "death_" + self.movemode;
  }

  if(isDefined(self.traversalvector)) {
    moveawayfromtraversalsurface();
  }

  self scragentsetphysicsmode("gravity");
  var_15 = randomint(self getanimentrycount(var_9));
  maps\mp\agents\_scripted_agent_anim_util::set_anim_state(var_9, var_15);
  var_16 = self getanimentry(var_9, var_15);
  var_17 = getdeathanimduration(var_16);

  if(isDefined(self.precloneswapfunc)) {
    [[self.precloneswapfunc]]();
  }

  if(isDefined(var_4) && var_4 == "zombie_vaporize_mp" && common_scripts\utility::fxexists("zombie_death_vaporize")) {
    self.bypasscorpse = 1;
    playFX(common_scripts\utility::getfx("zombie_death_vaporize"), self.origin + (0, 0, 30));
  }

  if(!isDefined(self.bypasscorpse) || !self.bypasscorpse) {
    self.body = self finishagentdamage(var_17);

    if(doimmediateragdollviaweapon(var_4, var_3, var_1)) {
      self.ragdollimmediately = 1;
    }

    var_18 = getragdollwaittime(var_17 * 0.001);
    thread handleragdoll(self.body, var_18, var_16);
  }

  maps\mp\agents\_agent_utility::deactivateagent();
  self notify("killanimscript");
}

doimmediateragdollviaweapon(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    if(var_0 == "repulsor_zombie_mp" || var_0 == "zombie_water_trap_mp") {
      return 1;
    } else if(var_0 == "iw5_exominigunzm_mp" && isDefined(var_1) && var_1 == "MOD_MELEE_ALT") {
      level thread delayphysicsexplosionragdoll(self, var_2);
      return 1;
    }
  }

  return 0;
}

delayphysicsexplosionragdoll(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }
  var_2 = var_1.origin + (0, 0, 30);
  wait 0.1;
  physicsexplosionsphere(var_2, 100, 0, 10, 0);
}

shouldimmediateragdoll() {
  if(maps\mp\zombies\_mutators::isfullbodymutilation()) {
    return 1;
  }

  if(!self isonground() || is_true(self.inairforleap)) {
    return 1;
  }

  if(is_true(self.neverimmediatelyragdoll)) {
    return 0;
  }

  if(isDefined(self.ragdollimmediately) && self.ragdollimmediately) {
    return 1;
  }

  return self.aistate == "traverse" || self.aistate == "scripted";
}

canragdoll(var_0) {
  if(is_true(self.noragdollondeath)) {
    return 0;
  }

  var_1 = getanimlength(var_0);
  var_2 = getnotetracktimes(var_0, "ignore_ragdoll");
  return var_2.size == 0;
}

moveawayfromtraversalsurface() {
  var_0 = 20;
  var_1 = vectortoangles(self.traversalvector);
  var_2 = anglestoup(var_1);
  var_3 = self.origin + var_2 * var_0;
  self setorigin(var_3);
}

getdeathanimduration(var_0) {
  var_1 = getanimlength(var_0);
  var_2 = getnotetracktimes(var_0, "start_ragdoll");

  if(var_2.size > 0) {
    var_1 = var_1 * var_2[0];
  } else {
    var_1 = var_1 * 0.5;
  }

  var_3 = int(var_1 * 1000);
  return var_3;
}

handleragdoll(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!canragdoll(var_2)) {
    return;
  }
  if(shouldimmediateragdoll()) {
    var_0 startragdoll();

    if(var_0 isragdoll()) {
      return;
    }
  }

  wait(var_1);

  if(!isDefined(var_0)) {
    return;
  }
  var_0 startragdoll();

  if(var_0 isragdoll()) {
    return;
  }
  var_3 = getanimlength(var_2);

  if(var_3 > var_1) {
    wait(var_3 - var_1);

    if(!isDefined(var_0)) {
      return;
    }
    var_0 startragdoll();
  }

  if(!var_0 isragdoll()) {
    var_0 delete();
  }
}

getragdollwaittime(var_0) {
  var_1 = 0.2;

  if(self.aistate == "traverse" || self.aistate == "scripted") {
    return var_1;
  }

  return var_0;
}

waitforbadpath() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("bad_path");
    self.bhasnopath = 1;

    if(isDefined(self.distractiondrone)) {
      self.distractiondronebadpathcount++;
    }
  }
}

shouldignoreent(var_0) {
  if(isplayerinlaststand(var_0)) {
    return 1;
  }

  if(isplayerteleporting(var_0)) {
    return 1;
  }

  if(is_true(var_0.zombiesignoreme) && !is_true(self.ignorescamouflage)) {
    return 1;
  }

  if(isDefined(level.shouldignoreplayercallback)) {
    if([[level.shouldignoreplayercallback]](var_0)) {
      return 1;
    }
  }

  if(is_true(var_0.iszomboni) && istrapresistant()) {
    return 1;
  }

  return 0;
}

checkexpiretime(var_0, var_1, var_2) {
  if(isDefined(self.ignoreexpiretime) && self.ignoreexpiretime) {
    return 0;
  }

  var_3 = (gettime() - var_0) / 1000;

  if(var_3 > var_1) {
    if(var_3 > var_2) {
      return 1;
    }
  }

  return 0;
}

locateenemypositions() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    foreach(var_1 in level.participants) {
      if(isonhumanteam(var_1)) {
        self getenemyinfo(var_1);
      }
    }

    wait 0.5;
  }
}

agentemptythink() {
  self endon("death");
  level endon("game_ended");
  self endon("owner_disconnect");

  for(;;) {
    self scragentsetgoalpos(self.origin);
    wait 0.5;
  }
}

onaiconnect() {
  self.agentname = &"ZOMBIES_EMPTY_STRING";
}

zombiewaitingfordeath() {
  return isDefined(self.throttledeath);
}

zombieshouldwaitfordeath(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(var_2 < self.maxhealth) {
    return 0;
  }

  if(!isDefined(level.zmdeaththrottlenetworkframe) || level.zmdeaththrottlenetworkframe != getnetworkframe()) {
    level.zmdeaththrottlenetworkframe = getnetworkframe();
    level.zmdeaththrottlecount = 0;
  }

  if(!isDefined(level.zmdeaththrottlequeue)) {
    level.zmdeaththrottlequeue = 0;
  }

  if(isDefined(self.throttledeathready)) {
    self.throttledeathready = undefined;
    return 0;
  } else if(level.zmdeaththrottlequeue + level.zmdeaththrottlecount + 1 > 4) {
    return 1;
  }

  level.zmdeaththrottlecount++;
  return 0;
}

zombiehandlesuicide() {
  self endon("processDelayDeath");
  self waittill("death");
  level.zmdeaththrottlequeue--;
}

zombiedelaydeath(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("death");
  level.zmdeaththrottlequeue++;
  self.throttledeath = getnetworkframe() + int(ceil(level.zmdeaththrottlequeue / 4));
  thread zombiehandlesuicide();

  while(getnetworkframe() < self.throttledeath) {
    waitnetworkframe();
  }

  if(level.zmdeaththrottlenetworkframe != getnetworkframe()) {
    level.zmdeaththrottlenetworkframe = getnetworkframe();
    level.zmdeaththrottlecount = 0;
  }

  self.throttledeath = undefined;
  self.throttledeathready = 1;
  level.zmdeaththrottlequeue--;
  level.zmdeaththrottlecount++;
  self notify("processDelayDeath");
  self dodamage(var_2, var_5, var_1, undefined, var_3, var_4);
}

candie() {
  if(gettime() - self.spawntime <= 0.05) {
    return 0;
  }

  return 1;
}

ispendingdeath(var_0) {
  return isDefined(self.pendingdeath) && self.pendingdeath;
}

zombiependingdeath(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  self notify("zombiePendingDeath");
  self endon("zombiePendingDeath");

  while(isDefined(self) && isalive(self)) {
    self.pendingdeath = 1;

    if(!candie()) {
      wait 0.05;
      continue;
    }

    self.pendingdeath = 0;
    maps\mp\zombies\_zombies::onzombiedamagefinished(var_0, var_1, self.health + 1, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  }
}

enemykilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  level.lastenemydeathpos = self.origin;
  level thread maps\mp\gametypes\zombies::chancetospawnpickup(var_1, self, var_3, var_4);

  if(isDefined(var_1) && isplayer(var_1)) {
    var_1 thread maps\mp\zombies\_zombies_audio::player_kill_zombie(var_6, var_3, var_4, self);

    if(!level.gameended) {
      var_1 maps\mp\_utility::incplayerstat("kills", 1);
      var_1 maps\mp\_utility::incpersstat("kills", 1);
      var_1.kills = var_1 maps\mp\_utility::getpersstat("kills");
      var_1 maps\mp\gametypes\_persistence::statsetchild("round", "kills", var_1.kills);
    }
  }

  if(isDefined(var_1)) {
    var_1 notify("killed_enemy");
  }

  if(isDefined(level.processenemykilledfunc)) {
    self thread[[level.processenemykilledfunc]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  }
}

isinstakill() {
  var_0 = maps\mp\_utility::gameflag("insta_kill");
  return var_0;
}

isplayerinlaststand(var_0) {
  return isDefined(var_0.laststand) && var_0.laststand;
}

isplayerteleporting(var_0) {
  return isDefined(var_0.inteleport) && var_0.inteleport;
}

isplayerinfected(var_0) {
  return isDefined(var_0.infected) && var_0.infected;
}

anyplayerinfected() {
  foreach(var_1 in level.players) {
    if(isplayerinfected(var_1)) {
      return 1;
    }
  }

  return 0;
}

iscrategodmode(var_0) {
  return isDefined(var_0.crategodmode) && var_0.crategodmode;
}

setallignoreme(var_0) {
  if(var_0) {
    self.ignoreme = 1;

    if(!isDefined(self.ignoremecount) || self.ignoremecount < 0) {
      self.ignoremecount = 0;
    }

    self.ignoremecount++;
  } else if(isDefined(self.ignoremecount) && self.ignoremecount > 0) {
    self.ignoremecount--;

    if(self.ignoremecount > 0) {
      return;
    }
    self.ignoreme = 0;
  }
}

setzombiesignoreme(var_0) {
  if(var_0) {
    self.zombiesignoreme = 1;

    if(!isDefined(self.zombiesignoremecount) || self.zombiesignoremecount < 0) {
      self.zombiesignoremecount = 0;
    }

    self.zombiesignoremecount++;
  } else if(isDefined(self.zombiesignoremecount) && self.zombiesignoremecount > 0) {
    self.zombiesignoremecount--;

    if(self.zombiesignoremecount > 0) {
      return;
    }
    self.zombiesignoreme = 0;
  }
}

isspecialround(var_0) {
  if(!isDefined(var_0)) {
    var_0 = level.wavecounter;
  }

  if(var_0 == level.specialroundnumber) {
    return 1;
  }

  return 0;
}

civiliansareenabled() {
  return isDefined(level.zombies_using_civilians) && level.zombies_using_civilians;
}

allowextendedsprint(var_0) {
  var_1 = "specialty_longersprint";

  if(var_0) {
    maps\mp\_utility::giveperk(var_1, 0);
  } else if(maps\mp\_utility::_hasperk(var_1)) {
    maps\mp\_utility::_unsetperk(var_1);
  }
}

playerallowextendedsprint(var_0, var_1) {
  maps\mp\_utility::_playerallow("extendedSprint", var_0, var_1, ::allowextendedsprint, 0);
}

allowlightweight(var_0) {
  var_1 = "specialty_lightweight";

  if(var_0) {
    maps\mp\_utility::giveperk(var_1, 0);
  } else if(maps\mp\_utility::_hasperk(var_1)) {
    maps\mp\_utility::_unsetperk(var_1);
  }
}

playerallowlightweight(var_0, var_1) {
  maps\mp\_utility::_playerallow("lightweight", var_0, var_1, ::allowlightweight, 0);
}

zombieallowallboost(var_0, var_1) {
  maps\mp\_utility::playerallowdodge(var_0, var_1);
  maps\mp\_utility::playerallowpowerslide(var_0, var_1);
  maps\mp\_utility::playerallowhighjump(var_0, var_1);
  playerallowextendedsprint(var_0, var_1);
  playerallowlightweight(var_0, var_1);
}

creditstotokens(var_0) {
  if(!var_0) {
    return 0;
  } else if(var_0 <= 100) {
    return 1;
  } else if(var_0 <= 500) {
    return 5;
  } else if(var_0 <= 1000) {
    return 10;
  } else if(var_0 <= 1500) {
    return 15;
  } else if(var_0 <= 2000) {
    return 20;
  } else {
    return 25;
  }
}

gettokencoststring(var_0) {
  switch (var_0) {
    case 0:
      return &"ZOMBIES_EMPTY_STRING";
    case 1:
      return &"ZOMBIES_USE_TOKEN";
    case 5:
      return &"ZOMBIES_USE_TOKEN_5";
    case 10:
      return &"ZOMBIES_USE_TOKEN_10";
    case 15:
      return &"ZOMBIES_USE_TOKEN_15";
    case 20:
      return &"ZOMBIES_USE_TOKEN_20";
    case 25:
      return &"ZOMBIES_USE_TOKEN_25";
    default:
      return "NEED TOKEN STRING FOR " + var_0 + " TOKENS.";
  }
}

getcoststring(var_0) {
  switch (var_0) {
    case 0:
      return &"ZOMBIES_EMPTY_STRING";
    case 100:
      return &"ZOMBIES_COST_100";
    case 200:
      return &"ZOMBIES_COST_200";
    case 250:
      return &"ZOMBIES_COST_250";
    case 300:
      return &"ZOMBIES_COST_300";
    case 400:
      return &"ZOMBIES_COST_400";
    case 500:
      return &"ZOMBIES_COST_500";
    case 600:
      return &"ZOMBIES_COST_600";
    case 700:
      return &"ZOMBIES_COST_700";
    case 750:
      return &"ZOMBIES_COST_750";
    case 800:
      return &"ZOMBIES_COST_800";
    case 900:
      return &"ZOMBIES_COST_900";
    case 1000:
      return &"ZOMBIES_COST_1000";
    case 1250:
      return &"ZOMBIES_COST_1250";
    case 1500:
      return &"ZOMBIES_COST_1500";
    case 1750:
      return &"ZOMBIES_COST_1750";
    case 2000:
      return &"ZOMBIES_COST_2000";
    case 2500:
      return &"ZOMBIES_COST_2500";
    case 3000:
      return &"ZOMBIES_COST_3000";
    case 4000:
      return &"ZOMBIES_COST_4000";
    case 5000:
      return &"ZOMBIES_COST_5000";
    default:
      return "NEED HINT STRING FOR $" + var_0 + ".";
  }
}

getreducedcost(var_0) {
  switch (var_0) {
    case 0:
      return 0;
    case 100:
      return 0;
    case 200:
      return 100;
    case 250:
      return 100;
    case 300:
      return 200;
    case 400:
      return 200;
    case 500:
      return 250;
    case 600:
      return 300;
    case 700:
      return 300;
    case 750:
      return 300;
    case 800:
      return 400;
    case 900:
      return 400;
    case 1000:
      return 500;
    case 1250:
      return 500;
    case 1500:
      return 750;
    case 1750:
      return 800;
    case 2000:
      return 1000;
    case 2500:
      return 1250;
    case 3000:
      return 1500;
    case 4000:
      return 2000;
    case 5000:
      return 2500;
    default:
      return 500;
  }
}

getincreasedcost(var_0) {
  switch (var_0) {
    case 0:
      return 0;
    case 100:
      return 200;
    case 200:
      return 300;
    case 250:
      return 400;
    case 300:
      return 500;
    case 400:
      return 600;
    case 500:
      return 750;
    case 600:
      return 800;
    case 700:
      return 900;
    case 750:
      return 1000;
    case 800:
      return 1250;
    case 900:
      return 1500;
    case 1000:
      return 1500;
    case 1250:
      return 1750;
    case 1500:
      return 2000;
    case 1750:
      return 2500;
    case 2000:
      return 2500;
    case 2500:
      return 3000;
    case 3000:
      return 4000;
    case 4000:
      return 5000;
    case 5000:
      return 5000;
    default:
      return 1000;
  }
}

zombie_set_eyes(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "tag_eye";
  }

  self.eyefxactive = 1;
  playfxontagnetwork(common_scripts\utility::getfx(var_0), self, var_1);
  thread zombiestopeyeeffectsonnotify(var_0, var_1, "humanoidPendingDeath");
}

zombiestopeyeeffectsonnotify(var_0, var_1, var_2) {
  self notify("zombieStopEyeEffectsOnNotify");
  self endon("zombieStopEyeEffectsOnNotify");
  self endon("death");
  self waittill(var_2);
  stopfxontagnetwork(common_scripts\utility::getfx(var_0), self, var_1);
}

delete_on_death_of(var_0) {
  delete_on_notification(var_0, "death");
}

delete_on_notification(var_0, var_1) {
  self endon("death");
  var_0 waittill(var_1);

  if(isDefined(self)) {
    self delete();
  }
}

isspawnlistreplaceabletype(var_0) {
  return !isDefined(level.modifyspawnlist[var_0]);
}

array_remove_index(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.size - 1; var_2++) {
    if(var_2 == var_1) {
      var_0[var_2] = var_0[var_2 + 1];
      var_1++;
    }
  }

  var_0[var_0.size - 1] = undefined;
  return var_0;
}

arrayremoveundefinedkeephash(var_0) {
  var_1 = [];

  foreach(var_4, var_3 in var_0) {
    if(!isDefined(var_3)) {
      continue;
    }
    if(isnumber(var_4)) {
      var_1[var_1.size] = var_3;
      continue;
    }

    var_1[var_4] = var_3;
  }

  return var_1;
}

isgenericzombie(var_0) {
  if(!isDefined(var_0.agent_type)) {
    return 0;
  }

  if(var_0.agent_type != "zombie_generic") {
    return 0;
  }

  return 1;
}

hasactivemutator(var_0) {
  return isDefined(var_0.activemutators);
}

checkactivemutator(var_0) {
  return isDefined(self.activemutators) && isDefined(self.activemutators[var_0]);
}

resetcharacterindex(var_0) {
  if(!isDefined(level.zmcharacterpool)) {
    return;
  }
  level.zmcharacterpool[level.zmcharacterpool.size] = var_0;
}

selectcharacterindextouse(var_0) {
  if(isDefined(level.zmcharacterpool) && level.zmcharacterpool.size == 0) {
    return -1;
  }

  if(!isDefined(level.zmcharacterpool)) {
    level.zmcharacterpool = [];
    level.zmcharacterpool[level.zmcharacterpool.size] = 0;
    level.zmcharacterpool[level.zmcharacterpool.size] = 1;
    level.zmcharacterpool[level.zmcharacterpool.size] = 2;
    level.zmcharacterpool[level.zmcharacterpool.size] = 3;
    level.zmcharacterpool = common_scripts\utility::array_randomize(level.zmcharacterpool);
  }

  if(!isDefined(var_0)) {
    var_1 = level.zmcharacterpool[level.zmcharacterpool.size - 1];
    level.zmcharacterpool[level.zmcharacterpool.size - 1] = undefined;
    self.characterindex = var_1;
  } else {
    self.characterindex = var_0;
  }

  return self.characterindex;
}

get_player_index(var_0) {
  return var_0.characterindex;
}

get_round_enemy_array() {
  var_0 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");
  var_1 = [];

  foreach(var_3 in var_0) {
    if(var_3.team == level.enemyteam) {
      var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

is_true(var_0) {
  return isDefined(var_0) && var_0;
}

set_player_is_female(var_0) {
  self.isfemale = var_0;
}

get_player_is_female() {
  return self.isfemale;
}

initializecharactermodel(var_0, var_1, var_2, var_3) {
  level.characterassets[var_0]["body"] = var_1;
  level.characterassets[var_0]["viewmodel"] = var_2;

  if(isDefined(var_3) && var_3.size > 0) {
    level.characterassets[var_0]["attachments"] = var_3;
  }
}

setcharactermodel(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!isDefined(var_1) || var_1 == 0) {
    self waittill("spawned_player");
  }

  if(!isDefined(level.characterassets[var_0])) {
    var_0 = "default";
  }

  self detachall();
  self.charactermodel = level.characterassets[var_0]["body"];

  if(!maps\mp\_utility::isjuggernaut()) {
    self setModel(level.characterassets[var_0]["body"]);
  }

  if(isDefined(level.characterassets[var_0]["viewmodel"])) {
    self.characterviewmodel = level.characterassets[var_0]["viewmodel"];

    if(!maps\mp\_utility::isjuggernaut()) {
      self setviewmodel(level.characterassets[var_0]["viewmodel"]);
    }
  }

  if(isDefined(level.characterassets[var_0]["attachments"])) {
    foreach(var_4 in level.characterassets[var_0]["attachments"]) {
      if(issubstr(var_4, "head")) {
        self.characterhead = var_4;
      }

      if(!maps\mp\_utility::isjuggernaut()) {
        self attach(var_4, "", 1);
      }
    }
  }
}

givecustomcharactersdefault(var_0) {
  var_2 = selectcharacterindextouse(var_0);
  var_3 = 1;

  if(var_2 == -1) {
    var_3 = 0;
    var_2 = 0;
    self.characterindex = 0;
  }

  if(var_3) {
    var_1 = "ui_zm_character_" + var_2;
    setomnvar(var_1, self getentitynumber());
    var_4 = "ui_zm_character_" + var_2 + "_alive";
    setomnvar(var_4, 0);
    thread resetcharacterondisconnect(var_1, var_4, var_2);
  }

  setcustomcharacter(var_2, 0);
  setcharacteraudio(var_2);
}

setcharacteraudio(var_0, var_1) {
  self.favorite_wall_weapons_list = [];

  switch (var_0) {
    case 0:
      level.vox maps\mp\zombies\_zombies_audio::zmbvoxinitspeaker("player", "guard_", self, self.characterindex);
      self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = "iw5_maulzm";
      self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = "iw5_mp11zm";
      maps\mp\gametypes\_battlechatter_mp::disablebattlechatter(self);
      break;
    case 1:
      level.vox maps\mp\zombies\_zombies_audio::zmbvoxinitspeaker("player", "exec_", self, self.characterindex);
      self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = "iw5_uts19zm";
      self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = "iw5_m182sprzm";
      maps\mp\gametypes\_battlechatter_mp::disablebattlechatter(self);
      break;
    case 2:
      level.vox maps\mp\zombies\_zombies_audio::zmbvoxinitspeaker("player", "it_", self, self.characterindex);
      self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = "iw5_hbra3zm";
      self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = "iw5_hmr9zm";
      maps\mp\gametypes\_battlechatter_mp::disablebattlechatter(self);
      break;
    case 3:
      if(getzombieslevelnum() < 3 || is_true(var_1)) {
        level.vox maps\mp\zombies\_zombies_audio::zmbvoxinitspeaker("player", "janitor_", self, self.characterindex);
        self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = "iw5_maulzm";
        self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = "iw5_arx160zm";
        maps\mp\gametypes\_battlechatter_mp::disablebattlechatter(self);
      } else {
        level.vox maps\mp\zombies\_zombies_audio::zmbvoxinitspeaker("player", "pilot_", self, self.characterindex);
        self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = "iw5_mp11zm";
        self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = "iw5_arx160zm";
        maps\mp\gametypes\_battlechatter_mp::disablebattlechatter(self);
      }

      break;
  }
}

setcustomcharacter(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = 0;

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  switch (var_0) {
    case 0:
      var_3 = "security";
      break;
    case 1:
      var_3 = "exec";
      break;
    case 2:
      var_3 = "it";
      var_4 = 1;
      break;
    case 3:
      if(getzombieslevelnum() < 3) {
        var_3 = "janitor";
      } else {
        var_3 = "pilot";
      }

      break;
  }

  if(isDefined(var_3)) {
    thread setcharactermodel(var_3, var_1, var_2);
    set_player_is_female(var_4);
  }
}

resetcharacterondisconnect(var_0, var_1, var_2) {
  self waittill("disconnect");
  setomnvar(var_0, -1);
  setomnvar(var_1, 0);
  resetcharacterindex(var_2);
}

flag_link(var_0, var_1) {
  level thread _flag_link(var_0, var_1);
}

_flag_link(var_0, var_1) {
  common_scripts\utility::flag_wait(var_0);
  common_scripts\utility::flag_set(var_1);
}

lerp(var_0, var_1, var_2) {
  var_3 = var_2 - var_1;
  var_4 = var_0 * var_3;
  var_5 = var_1 + var_4;
  return var_5;
}

getnetworkframe() {
  return int(gettime() / 100);
}

waitnetworkframe() {
  waitframe();
  waitframe();
}

playfxontagnetwork(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    return;
  }
  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  thread _playfxontagnetworkinternal(var_0, var_1, var_2, var_3);
}

_playfxontagnetworkinternal(var_0, var_1, var_2, var_3) {
  var_1 endon("death");
  var_1 notify("StopFxOnTagNetwork_" + var_0 + var_2);
  var_1 endon("StopFxOnTagNetwork_" + var_0 + var_2);
  _waittillcandofxevent(var_1);

  if(!isDefined(var_1)) {
    return;
  }
  playFXOnTag(var_0, var_1, var_2);

  if(!var_3) {
    var_1 _entitytrackfx(var_0, var_2, 0);
  }

  var_1 _entityincrementeventcount();
}

playfxontagforclientnetwork(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    return;
  }
  thread _playfxontagnetworkforclientinternal(var_0, var_1, var_2, var_3);
}

_playfxontagnetworkforclientinternal(var_0, var_1, var_2, var_3) {
  var_1 endon("death");
  var_1 endon("StopFxOnTagNetwork_" + var_0 + var_2);
  _waittillcandofxevent(var_1);
  playfxontagforclients(var_0, var_1, var_2, var_3);
  var_1 _entityincrementeventcount();
}

stopfxontagforclientnetwork(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    return;
  }
  thread _stopfxontagnetworkforclientinternal(var_0, var_1, var_2, var_3);
}

_stopfxontagnetworkforclientinternal(var_0, var_1, var_2, var_3) {
  var_1 endon("death");
  var_1 endon("StopFxOnTagNetwork_" + var_0 + var_2);
  _waittillcandofxevent(var_1);
  stopfxontagforclient(var_0, var_1, var_2, var_3);
  var_1 _entityincrementeventcount();
}

stopfxontagnetwork(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    return;
  }
  thread _stopfxontagnetworkinternal(var_0, var_1, var_2);
}

_stopfxontagnetworkinternal(var_0, var_1, var_2) {
  var_1 endon("death");
  var_1 notify("StopFxOnTagNetwork_" + var_0 + var_2);
  var_1 endon("StopFxOnTagNetwork_" + var_0 + var_2);
  _waittillcandofxevent(var_1);
  stopFXOnTag(var_0, var_1, var_2);
  var_1 _entitytrackfx(var_0, var_2, 1);
  var_1 _entityincrementeventcount();
}

killfxontagnetwork(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    return;
  }
  _killfxontagnetworkinternal(var_0, var_1, var_2);
}

_killfxontagnetworkinternal(var_0, var_1, var_2) {
  var_1 endon("death");
  var_1 notify("StopFxOnTagNetwork_" + var_0 + var_2);
  var_1 endon("StopFxOnTagNetwork_" + var_0 + var_2);
  _waittillcandofxevent(var_1);
  killfxontag(var_0, var_1, var_2);
  var_1 _entitytrackfx(var_0, var_2, 1);
  var_1 _entityincrementeventcount();
}

_waittillcandofxevent(var_0) {
  var_1 = 0;

  if(!isDefined(var_0.trackedfxdata)) {
    var_0 _entitysetupplayfxnetworkstatus();
  } else if(getnetworkframe() > var_0.trackedfxdata.networkframe) {
    var_0 _entityresetplayfxnetworkstatus();
  }

  while(var_0.trackedfxdata.count >= level.network_max_events || isDefined(var_0.birthtime) && var_0.birthtime == gettime()) {
    waitnetworkframe();
    var_1 = 1;

    if(!isDefined(var_0)) {
      return var_1;
    }

    if(!isDefined(var_0.trackedfxdata)) {
      var_0 _entitysetupplayfxnetworkstatus();
    }

    if(getnetworkframe() > var_0.trackedfxdata.networkframe) {
      var_0 _entityresetplayfxnetworkstatus();
    }
  }

  return var_1;
}

_entitysetupplayfxnetworkstatus() {
  self.trackedfx = [];
  self.trackedfxdata = spawnStruct();
  _entityresetplayfxnetworkstatus();
}

_entityresetplayfxnetworkstatus() {
  self.trackedfxdata.count = 0;
  self.trackedfxdata.networkframe = getnetworkframe();
}

_entityincrementeventcount() {
  self.trackedfxdata.count++;
}

_entitytrackfx(var_0, var_1, var_2) {
  if(!isDefined(level.entswithfx[self getentitynumber()])) {
    level.entswithfx[self getentitynumber()] = self;
  }

  var_3 = 0;

  foreach(var_5 in self.trackedfx) {
    if(var_5.id == var_0 && var_5.tagname == var_1 && var_5.stop == var_2) {
      var_3 = 1;
      break;
    }
  }

  if(!var_3) {
    var_7 = spawnStruct();
    var_7.id = var_0;
    var_7.tagname = var_1;
    var_7.stop = var_2;
    self.trackedfx[self.trackedfx.size] = var_7;

    if(!var_2) {
      thread _entitywatchforstopeffect(var_7);
    }
  }
}

_entitywatchforstopeffect(var_0) {
  self endon("death");
  thread _entitystoptrackingondeath();
  self waittill("StopFxOnTagNetwork_" + var_0.id + var_0.tagname);
  self.trackedfx = common_scripts\utility::array_remove(self.trackedfx, var_0);
}

_entitystoptrackingondeath() {
  self notify("_entityKillFXOnDeath");
  self endon("_entityKillFXOnDeath");
  var_0 = self getentitynumber();
  self waittill("death");
  level.entswithfx[var_0] = undefined;

  if(isDefined(self)) {
    self.trackedfx = undefined;
    self.trackedfxdata = undefined;
  }
}

startfxforlatejoiner(var_0) {
  var_0 endon("disconnect");

  if(var_0 maps\mp\gametypes\_playerlogic::mayspawn()) {
    var_0 waittill("spawned_player");
  } else {
    var_0 waittill("joined_spectators");
  }

  waittillplayersnextsnapshot(var_0);

  if(is_true(var_0.laterjoinereffects)) {
    return;
  }
  var_0.laterjoinereffects = 1;

  foreach(var_2 in level.entswithfx) {
    thread startfxforlatejoineronent(var_0, var_2);
  }
}

startfxforlatejoineronent(var_0, var_1) {
  var_0 endon("disconnect");
  var_1 endon("death");

  if(!isDefined(var_1) || !isDefined(var_1.trackedfx)) {
    return;
  }
  var_2 = [];
  var_3 = var_1.trackedfx.size;

  for(var_4 = 0; var_4 < var_3; var_4++) {
    var_5 = var_1.trackedfx[var_4];
    stopfxontagforclientnetwork(var_5.id, var_1, var_5.tagname, var_0);

    if(!var_5.stop) {
      var_2[var_2.size] = var_5;
    }
  }

  waittillplayersnextsnapshot(var_0);

  if(!level.nextgen) {
    wait 5;
  }

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    var_5 = var_2[var_4];

    if(!isDefined(var_5) || !common_scripts\utility::array_contains(var_1.trackedfx, var_5)) {
      continue;
    }
    playfxontagforclientnetwork(var_5.id, var_1, var_5.tagname, var_0);
  }
}

handlenetworkeffects() {
  thread onplayerconnectfxlatejoiners();
  thread onhostmigratefx();
}

onplayerconnectfxlatejoiners() {
  if(!isDefined(level.entswithfx)) {
    level.entswithfx = [];
  }

  level.network_max_events = 2;

  for(;;) {
    level waittill("connected", var_0);

    if(isbot(var_0)) {
      continue;
    }
    level thread startfxforlatejoiner(var_0);
  }
}

onhostmigratefx() {
  for(;;) {
    level waittill("host_migration_begin");

    foreach(var_1 in level.entswithfx) {
      thread startfxforhostmigrationonent(var_1);
    }
  }
}

startfxforhostmigrationonent(var_0) {
  var_0 endon("death");

  if(!isDefined(var_0) || !isDefined(var_0.trackedfx)) {
    return;
  }
  waittillframeend;
  var_1 = [];
  var_2 = var_0.trackedfx.size;

  for(var_3 = 0; var_3 < var_2; var_3++) {
    var_4 = var_0.trackedfx[var_3];
    stopfxontagnetwork(var_4.id, var_0, var_4.tagname);

    if(!var_4.stop) {
      var_1[var_1.size] = var_4;
    }
  }

  level waittill("host_migration_end");

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    var_4 = var_1[var_3];
    playfxontagnetwork(var_4.id, var_0, var_4.tagname);
  }
}

istrapweapon(var_0) {
  if(isDefined(var_0)) {
    switch (var_0) {
      case "trap_missile_zm_mp":
      case "trap_zm_mp":
      case "zombie_water_trap_mp":
      case "zombie_vaporize_mp":
      case "zombie_trap_turret_mp":
      case "trap_sniper_zm_mp":
        return 1;
      default:
        return 0;
    }
  }

  return 0;
}

getroundtype(var_0) {
  switch (var_0) {
    case "zombie_dog":
      return 1;
    case "zombie_host":
      return 2;
    case "normal":
    default:
      return 0;
  }
}

waittill_enter_game() {
  while(!has_entered_game()) {
    wait 0.05;
  }
}

has_entered_game() {
  return is_true(self.hastraversed);
}

isusetriggerforsingleclient(var_0) {
  return isDefined(var_0.script_index);
}

isusetriggerprimary(var_0) {
  return !isDefined(var_0.script_index) || var_0.script_index == 0;
}

setupusetriggerforclient(var_0, var_1) {
  if(!isDefined(var_0.script_index)) {
    return;
  }
  var_0 common_scripts\utility::trigger_off();
  var_0.claimed = 0;

  foreach(var_3 in level.players) {
    if(var_3 _playerisassignedtousetrigger(var_0)) {
      var_3 thread _playerassignusetrigger(var_0, var_1);
      break;
    }
  }

  thread _onplayerconnectedusetriggerassign(var_0, var_1);
}

_onplayerconnectedusetriggerassign(var_0, var_1) {
  var_0 endon("death");

  for(;;) {
    level waittill("connected", var_2);

    if(var_2 _playerisassignedtousetrigger(var_0)) {
      var_2 _playerassignusetrigger(var_0, var_1);
    }
  }
}

_playerisassignedtousetrigger(var_0) {
  return isDefined(var_0.script_index) && self getentitynumber() == var_0.script_index;
}

_playerassignusetrigger(var_0, var_1) {
  self clientclaimtrigger(var_0);
  var_0 common_scripts\utility::trigger_on();
  var_0 notify("claimed");
  var_0.claimed = 1;
  var_0.claimedby = self;
  thread _playerreleaseusetriggerondisconnect(var_0);
  var_0 thread[[var_1]](self);
}

_playerreleaseusetriggerondisconnect(var_0) {
  var_0 endon("death");
  self waittill("disconnect");

  if(isDefined(self)) {
    self clientreleasetrigger(var_0);
  }

  var_0 common_scripts\utility::trigger_off();
  var_0.claimed = 0;
}

isrippedturretweapon(var_0) {
  return var_0 == "turretheadenergy_mp" || var_0 == "turretheadrocket_mp" || var_0 == "turretheadmg_mp";
}

outofboundswatch(var_0) {
  for(;;) {
    foreach(var_2 in level.players) {
      if(!isDefined(var_2)) {
        continue;
      }
      if(var_2.sessionstate == "spectator" || var_2.sessionstate == "intermission") {
        continue;
      }
      if(var_2 isnoclip()) {
        continue;
      }
      if(!isalive(var_2)) {
        continue;
      }
      var_3 = var_2 maps\mp\zombies\_zombies_zone_manager::getplayerzone();

      if(!isDefined(var_3)) {
        var_4 = !var_0;

        if(var_4) {
          var_2.outofbounds = 1;
          var_2 suicide();
        } else {
          iprintlnbold("Player out of bounds at " + var_2.origin);
          wait 1;
        }
      } else {
        var_2.outofbounds = undefined;
      }

      if(!var_0) {
        wait 0.5;
      }
    }

    waitframe();
  }
}

waittillplayersnextsnapshot(var_0) {
  var_0 endon("disconnect");
  var_1 = var_0 getsnapshotindexforclient();

  if(!isDefined(var_1)) {
    return;
  }
  for(;;) {
    waitframe();
    var_2 = var_0 getsnapshotacknowledgedindexforclient();

    if(!isDefined(var_2)) {
      return;
    }
    if(var_2 >= var_1) {
      break;
    }
  }
}

iszombiegamepaused() {
  if(!isDefined(level.zombiegamepaused)) {
    return 0;
  }

  return level.zombiegamepaused;
}

waittillzombiegameunpaused() {
  while(iszombiegamepaused()) {
    waitframe();
  }
}

clearzombiestats(var_0) {
  if(isDefined(level.dlcleaderboardnumber) && level.dlcleaderboardnumber >= 2 && level.dlcleaderboardnumber <= 4) {
    var_1 = "dlc" + level.dlcleaderboardnumber;
    var_0 setcoopplayerdatareservedint(var_1 + "MoneyEarned", 0);
    var_0 setcoopplayerdatareservedint(var_1 + "Kills", 0);
    var_0 setcoopplayerdatareservedint(var_1 + "Revives", 0);
    var_0 setcoopplayerdatareservedint(var_1 + "Rounds", 0);
    var_0 setcoopplayerdatareservedint(var_1 + "TimePlayed", 0);
    var_0 setcoopplayerdatareservedint(var_1 + "Headshots", 0);
    var_0 setcoopplayerdatareservedint(var_1 + "MeleeKills", 0);

    if(level.dlcleaderboardnumber == 2) {
      var_0 setcoopplayerdatareservedint(var_1 + "Civilians", 0);
    }

    if(level.dlcleaderboardnumber == 3) {
      var_0 setcoopplayerdatareservedint(var_1 + "Bombs", 0);
      return;
    }
  } else {
    var_0 setcoopplayerdata("totalRounds", 0);
    var_0 setcoopplayerdata("totalKills", 0);
    var_0 setcoopplayerdata("totalRevives", 0);
    var_0 setcoopplayerdata("totalMoneyEarned", 0);
    var_0 setcoopplayerdata("totalMoneySpent", 0);
    var_0 setcoopplayerdata("totalMagicBox", 0);
    var_0 setcoopplayerdata("totalTraps", 0);
    var_0 setcoopplayerdata("totalHeadshots", 0);
    var_0 setcoopplayerdata("totalMeleeKills", 0);
    var_0 setcoopplayerdatareservedint("totalTimePlayed", 0);
  }
}

writezombiestats() {
  writezombiematchdata();

  foreach(var_1 in level.players) {
    writezombieplayerstats(var_1);
  }
}

writezombiematchdata() {
  foreach(var_1 in level.players) {
    setmatchdata("players", var_1.clientid, "startXp", var_1.assists);
    setmatchdata("players", var_1.clientid, "startKills", var_1.kills);
    setmatchdata("players", var_1.clientid, "startWins", var_1.moneyearnedtotal);
    setmatchdata("players", var_1.clientid, "startLosses", var_1.moneyearnedtotal - var_1.moneycurrent);
    setmatchdata("players", var_1.clientid, "startHits", var_1.magicboxuses);
    setmatchdata("players", var_1.clientid, "startMisses", var_1.trapuses);
    setmatchdata("players", var_1.clientid, "startGamesPlayed", var_1.headshotkills);
    setmatchdata("players", var_1.clientid, "startScore", var_1.meleekills);
    setmatchdata("players", var_1.clientid, "startUnlockPoints", var_1.timeplayed["total"]);
    setmatchdata("players", var_1.clientid, "startDeaths", var_1.numberofdowns);
    setmatchdata("players", var_1.clientid, "startDP", var_1.numberofbleedouts);
    setmatchdata("players", var_1.clientid, "endXp", level.wavecounter);
    setmatchdata("players", var_1.clientid, "endKills", level.doorsopenedbitmask);
    setmatchdata("players", var_1.clientid, "endDeaths", level.players.size);
    setmatchdata("players", var_1.clientid, "endWins", var_1.exosuitround);
    setmatchdata("players", var_1.clientid, "endScore", var_1.numupgrades);
    level.roundtypemap = [];
    level.roundtypemap["normal"] = 0;
    level.roundtypemap["zombie_dog"] = 1;
    level.roundtypemap["zombie_host"] = 2;
    level.roundtypemap["zombie_melee_goliath"] = 3;
    level.roundtypemap["civilian"] = 4;
    level.roundtypemap["zombie_boss_oz"] = 5;
    level.roundtypemap["zombie_boss_oz_stage1"] = 6;
    level.roundtypemap["zombie_boss_oz_stage2"] = 7;

    if(isDefined(level.roundtypemap[level.roundtype])) {
      setmatchdata("players", var_1.clientid, "endUnlockPoints", level.roundtypemap[level.roundtype]);
    }
  }
}

recordplayermatchdataforroundstart(var_0) {
  if(var_0 < 0 || var_0 >= 75) {
    return;
  }
  var_1 = self getentitynumber();
  var_2 = self.origin;
  setmatchdata("zombieRounds", var_0, "playerRounds", var_1, "startPos", 0, int(var_2[0]));
  setmatchdata("zombieRounds", var_0, "playerRounds", var_1, "startPos", 1, int(var_2[1]));
  setmatchdata("zombieRounds", var_0, "playerRounds", var_1, "startPos", 2, int(var_2[2]));
  var_3 = self getweaponslistall();
  var_4 = 1;

  foreach(var_6 in var_3) {
    var_7 = getweaponbasename(var_6);
    var_8 = level.weaponnamemap[var_7];

    if(!isDefined(var_8) && iszombieequipment(var_7)) {
      var_7 = getzombieequipmentalternatename(var_7);

      if(isDefined(var_7)) {
        var_8 = level.weaponnamemap[var_7];
      }
    }

    if(!isDefined(var_8)) {
      continue;
    }
    if(iszombielethal(var_7)) {
      setmatchdata("zombieRounds", var_0, "playerRounds", var_1, "equipment", 0, var_8);
      continue;
    }

    if(iszombietactical(var_7)) {
      setmatchdata("zombieRounds", var_0, "playerRounds", var_1, "equipment", 1, var_8);
      continue;
    }

    var_9 = getzombieweaponlevel(self, var_7);

    if(var_4) {
      var_4 = 0;
      setmatchdata("zombieRounds", var_0, "playerRounds", var_1, "weapons", 0, var_8);
      setmatchdata("zombieRounds", var_0, "playerRounds", var_1, "weaponLevels", 0, var_9);
    } else {
      setmatchdata("zombieRounds", var_0, "playerRounds", var_1, "weapons", 1, var_8);
      setmatchdata("zombieRounds", var_0, "playerRounds", var_1, "weaponLevels", 1, var_9);
    }
  }

  self.roundmoneyearned = 0;
  self.roundmoneyspent = 0;
  self.killsatroundstart = self.kills;
  self.bleedoutsatroundstart = self.numberofbleedouts;
  self.downsatroundstart = self.numberofdowns;
  self.magicboxusesatroundstart = self.magicboxuses;
}

recordplayermatchdataforroundend(var_0) {
  if(var_0 < 0 || var_0 >= 75) {
    return;
  }
  var_1 = self getentitynumber();
  var_2 = self.origin;
  setmatchdata("zombieRounds", var_0, "playerRounds", var_1, "endPos", 0, int(var_2[0]));
  setmatchdata("zombieRounds", var_0, "playerRounds", var_1, "endPos", 1, int(var_2[1]));
  setmatchdata("zombieRounds", var_0, "playerRounds", var_1, "endPos", 2, int(var_2[2]));
  setmatchdata("zombieRounds", var_0, "playerRounds", var_1, "moneyEarned", maps\mp\_utility::clamptoshort(self.roundmoneyearned));
  setmatchdata("zombieRounds", var_0, "playerRounds", var_1, "moneySpent", maps\mp\_utility::clamptoshort(self.roundmoneyspent));
  setmatchdata("zombieRounds", var_0, "playerRounds", var_1, "kills", maps\mp\_utility::clamptoshort(self.kills - self.killsatroundstart));
  setmatchdata("zombieRounds", var_0, "playerRounds", var_1, "printerUses", maps\mp\_utility::clamptobyte(self.magicboxuses - self.magicboxusesatroundstart));
  setmatchdata("zombieRounds", var_0, "playerRounds", var_1, "timesDowned", maps\mp\_utility::clamptobyte(self.numberofdowns - self.downsatroundstart));

  if(self.bleedoutsatroundstart != self.numberofbleedouts) {
    setmatchdata("zombieRounds", var_0, "playerRounds", var_1, "died", 1);
  }
}

recordmatchdataforroundstart(var_0) {
  if(var_0 < 0 || var_0 >= 75) {
    return;
  }
  var_1 = maps\mp\_utility::clamptoshort(maps\mp\_utility::getsecondspassed());
  setmatchdata("zombieRounds", var_0, "startTime", var_1);

  foreach(var_3 in level.players) {
    var_3 recordplayermatchdataforroundstart(var_0);
  }

  level.roundsupplydrops = [];
  level.roundpowerstations = [];
}

recordmatchdataforroundend(var_0) {
  if(var_0 < 0 || var_0 >= 75) {
    return;
  }
  var_1 = maps\mp\_utility::clamptoshort(maps\mp\_utility::getsecondspassed());
  setmatchdata("zombieRounds", var_0, "endTime", var_1);

  foreach(var_3 in level.roundpowerstations) {
    if(var_3 >= 0 && var_3 < 24) {
      setmatchdata("zombieRounds", var_0, "powerStationActivated", var_3, 1);
    }
  }

  var_5 = 0;

  foreach(var_7 in level.roundsupplydrops) {
    var_8 = 1;

    foreach(var_10 in level.cratetypes["airdrop_assault"]) {
      if(var_10.type == var_7) {
        setmatchdata("zombieRounds", var_0, "supplyDrops", var_5, maps\mp\_utility::clamptobyte(var_8));
        var_5++;
        break;
      }

      var_8++;
    }

    if(var_5 >= 2) {
      break;
    }
  }

  foreach(var_14 in level.players) {
    var_14 recordplayermatchdataforroundend(var_0);
  }
}

writezombieplayerstats(var_0) {
  if(isDefined(level.dlcleaderboardnumber) && level.dlcleaderboardnumber >= 2 && level.dlcleaderboardnumber <= 4) {
    var_1 = "dlc" + level.dlcleaderboardnumber;
    setzombiereservedata(var_0, var_1 + "MoneyEarned", var_1 + "MoneyEarnedBest", var_0.moneyearnedtotal);
    setzombiereservedata(var_0, var_1 + "Kills", var_1 + "KillsBest", var_0.kills);
    setzombiereservedata(var_0, var_1 + "Revives", var_1 + "RevivesBest", var_0.assists);
    setzombiereservedata(var_0, var_1 + "Rounds", var_1 + "RoundsBest", level.wavecounter);
    setzombiereservedata(var_0, var_1 + "TimePlayed", var_1 + "TimePlayedBest", var_0.timeplayed["total"]);
    setzombiereservedata(var_0, var_1 + "Headshots", var_1 + "HeadshotsBest", var_0.headshotkills);
    setzombiereservedata(var_0, var_1 + "MeleeKills", var_1 + "MeleeKillsBest", var_0.meleekills);

    if(level.dlcleaderboardnumber == 2) {
      setzombiereservedata(var_0, var_1 + "Civilians", var_1 + "CiviliansBest", level.civiliansrescued);

      if(isDefined(level.civiliansrescued)) {
        var_2 = var_0 getcoopplayerdatareservedint("civiliansRescued");
        var_2 = var_2 + level.civiliansrescued;
        var_0 setcoopplayerdatareservedint("civiliansRescued", var_2);
      }
    }

    if(level.dlcleaderboardnumber == 3) {
      setzombiereservedata(var_0, var_1 + "Bombs", var_1 + "BombsBest", level.bombsdefused);
    }
  } else {
    setzombieplayerdata(var_0, "totalRounds", "highestRound", level.wavecounter);
    setzombieplayerdata(var_0, "totalKills", "mostKillsGame", var_0.kills);
    setzombieplayerdata(var_0, "totalRevives", "mostRevives", var_0.assists);
    setzombieplayerdata(var_0, "totalMoneyEarned", "mostMoneyEarned", var_0.moneyearnedtotal);
    setzombieplayerdata(var_0, "totalMoneySpent", "mostMoneySpent", var_0.moneyearnedtotal - var_0.moneycurrent);
    setzombieplayerdata(var_0, "totalMagicBox", "mostMagicBox", var_0.magicboxuses);
    setzombieplayerdata(var_0, "totalTraps", "mostTraps", var_0.trapuses);
    setzombieplayerdata(var_0, "totalHeadshots", "mostHeadshotsGame", var_0.headshotkills);
    setzombieplayerdata(var_0, "totalMeleeKills", "mostMeleeKills", var_0.meleekills);
    setzombiereservedata(var_0, "totalTimePlayed", "mostTimePlayed", var_0.timeplayed["total"]);
  }

  var_3 = var_0 getcoopplayerdata("totalGames");
  var_0 setcoopplayerdata("totalGames", var_3 + 1);
}

setzombieplayerdata(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    return;
  }
  var_4 = var_0 getcoopplayerdata(var_1);
  var_0 setcoopplayerdata(var_1, var_4 + var_3);
  var_5 = var_0 getcoopplayerdata(var_2);

  if(var_3 > var_5) {
    var_0 setcoopplayerdata(var_2, var_3);
  }
}

setzombiereservedata(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    return;
  }
  var_4 = var_0 getcoopplayerdatareservedint(var_1);
  var_0 setcoopplayerdatareservedint(var_1, var_4 + var_3);
  var_5 = var_0 getcoopplayerdatareservedint(var_2);

  if(var_3 > var_5) {
    var_0 setcoopplayerdatareservedint(var_2, var_3);
  }
}

setmeleeradius(var_0) {
  self.meleeradius = var_0;
  self.meleeradiussq = var_0 * var_0;
}

playergetem1ammo() {
  return self.pers["em1Ammo"].ammo;
}

playerrecordem1ammo(var_0) {
  self.pers["em1Ammo"].ammo = var_0;
}

playerhasem1ammoinfo() {
  return isDefined(self.pers["em1Ammo"]);
}

playerclearem1ammoinfo() {
  self.pers["em1Ammo"] = undefined;
}

cg_setupstorestrings(var_0) {
  if(!isDefined(var_0.storedescription)) {
    var_0.storedescription = var_0 maps\mp\gametypes\_hud_util::createfontstring("hudbig", 0.75);
    var_0.storedescription maps\mp\gametypes\_hud_util::setpoint("BOTTOM", undefined, 0, -120);
    var_0.storedescription settext("");
  }

  if(!isDefined(var_0.storecost)) {
    var_0.storecost = var_0 maps\mp\gametypes\_hud_util::createfontstring("hudbig", 0.75);
    var_0.storecost maps\mp\gametypes\_hud_util::setpoint("BOTTOM", undefined, 0, -95);
    var_0.storecost settext("");
  }
}

waittilltriggerortokenuse() {
  self endon("death");
  thread watchtokentrigger();
  thread watchtokenuse();
  self waittill("used", var_0, var_1);
  return [var_0, var_1];
}

watchtokentrigger() {
  self endon("used");
  self endon("death");
  self waittill("trigger", var_0);
  self notify("used", var_0, "trigger");
}

watchtokenuse() {
  self endon("used");
  self endon("death");

  if(!level.tokensenabled) {
    return;
  }
  foreach(var_1 in level.players) {
    thread watchtokenuseent(var_1);
  }

  for(;;) {
    level waittill("connected", var_1);
    thread watchtokenuseent(var_1);
  }
}

watchtokenuseent(var_0) {
  watchtokenuseentwait(var_0);

  if(isDefined(var_0)) {
    var_0 cleartokenuseomnvars();
  }
}

watchtokenuseentwait(var_0) {
  self endon("used");
  self endon("death");
  var_0 endon("disconnect");
  var_1 = undefined;

  for(;;) {
    if(is_true(var_0.tokenbuttonpressed) && is_true(self.tokenstringvisible) && isplayeruseent(var_0, self) && var_0 maps\mp\gametypes\zombies::hastoken(self.tokencost)) {
      if(!isDefined(var_1)) {
        var_1 = gettime() + var_0 maps\mp\gametypes\zombies::gettokenusetime();
        var_0 settokenuseomvars();
      }

      if(gettime() >= var_1) {
        var_0.tokenbuttonpressed = 0;
        self notify("used", var_0, "token");
      }
    } else if(isDefined(var_1)) {
      var_1 = undefined;
      var_0 cleartokenuseomnvars();
    }

    waitframe();
  }
}

cleartokenuseomnvars() {
  self setclientomnvar("ui_use_bar_start_time", 0);
  self setclientomnvar("ui_use_bar_end_time", 0);
  self setclientomnvar("ui_use_bar_text", 0);
}

settokenuseomvars() {
  self setclientomnvar("ui_use_bar_start_time", gettime());
  var_0 = gettime() + maps\mp\gametypes\zombies::gettokenusetime();
  self setclientomnvar("ui_use_bar_end_time", var_0);
  self setclientomnvar("ui_use_bar_text", 5);
}

settokencost(var_0) {
  self.tokencost = var_0;
}

tokenhintstring(var_0) {
  if(var_0 && level.tokensenabled) {
    self.tokenstringvisible = 1;
    self settertiaryhintstring(gettokencoststring(self.tokencost));
  } else {
    self.tokenstringvisible = 0;
    self settertiaryhintstring("");
  }
}

enabletokens() {
  level.tokensenabled = getdvarint("tokensEnabled", 0);
}

isplayeruseent(var_0, var_1) {
  var_2 = var_0 playergetuseent(1);
  return isDefined(var_2) && var_2 == var_1;
}

droppostoground(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 18;
  }

  var_2 = var_0 + (0, 0, var_1);
  var_3 = var_0 + (0, 0, var_1 * -1);
  var_4 = self aiphysicstrace(var_2, var_3, self.radius, self.height, 1);

  if(abs(var_4[2] - var_2[2]) < 0.1) {
    return undefined;
  }

  if(abs(var_4[2] - var_3[2]) < 0.1) {
    return undefined;
  }

  return var_4;
}

canmovepointtopoint(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    var_2 = 6;
  }

  if(!isDefined(var_3)) {
    var_3 = self.radius;
  }

  var_4 = (0, 0, 1) * var_2;
  var_5 = var_0 + var_4;
  var_6 = var_1 + var_4;
  return self aiphysicstracepassed(var_5, var_6, var_3, self.height - var_2, 1);
}

getzombieslevelnum() {
  return level.zombiedlclevel;
}

nodeisinspawncloset(var_0) {
  return !isDefined(var_0.zombieszone);
}

areaparallelpipid(var_0, var_1, var_2) {
  return var_0[0] * var_1[1] - var_0[1] * var_1[0] + (var_1[0] * var_2[1] - var_2[0] * var_1[1]) + (var_2[0] * var_0[1] - var_0[0] * var_2[1]);
}

areatriange(var_0, var_1, var_2) {
  return areaparallelpipid(var_0, var_1, var_2) * 0.5;
}

lrtest(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = 0.0;
  }

  var_4 = areaparallelpipid(var_1, var_2, var_0);

  if(var_4 > var_3) {
    return 1;
  }

  if(var_4 < var_3 * -1) {
    return 2;
  }

  return 3;
}

project(var_0, var_1) {
  var_2 = vectordot(var_0, var_1) / lengthsquared(var_1);
  return [var_1 * var_2, var_2];
}

projecttoline(var_0, var_1, var_2) {
  var_0 = var_0 - var_1;
  [var_0, var_4] = project(var_0, var_2 - var_1);
  var_0 = var_0 + var_1;
  return [var_0, var_4];
}

projecttolineseg(var_0, var_1, var_2) {
  [var_0, var_4] = projecttoline(var_0, var_1, var_2);

  if(var_4 < 0.0) {
    var_0 = var_1;
  } else if(var_4 > 1.0) {
    var_0 = var_2;
  }

  return [var_0, var_4];
}

disttoline(var_0, var_1, var_2) {
  [var_4, var_5] = projecttoline(var_0, var_1, var_2);
  return distance(var_4, var_0);
}

despawnzombie() {
  self hudoutlinedisable();
  maps\mp\agents\_agent_utility::deactivateagent();
  self notify("killanimscript");
  self notify("death");
  self waittill("disconnect");
  self despawnagent();
}

gameflagexists(var_0) {
  return isDefined(game["flags"][var_0]);
}

isvalidweaponzombies(var_0) {
  return isvalidprimaryzombies(var_0) || isvalidsecondaryzombies(var_0);
}

isvalidprimaryzombies(var_0) {
  switch (var_0) {
    case "iw5_tridentzm":
    case "iw5_linegunzm":
    case "iw5_microwavezm":
    case "iw5_fusionzm":
    case "iw5_dlcgun4zm":
    case "iw5_dlcgun3zm":
    case "iw5_dlcgun1zm":
    case "iw5_rhinozm":
    case "iw5_gm6zm":
    case "iw5_asm1zm":
    case "iw5_sac3zm":
    case "iw5_sn6zm":
    case "iw5_asawzm":
    case "iw5_himarzm":
    case "iw5_lsatzm":
    case "iw5_bal27zm":
    case "iw5_ak12zm":
    case "iw5_arx160zm":
    case "iw5_hmr9zm":
    case "iw5_hbra3zm":
    case "iw5_m182sprzm":
    case "iw5_uts19zm":
    case "iw5_mp11zm":
    case "iw5_maulzm":
    case "iw5_dlcgun2zm":
    case "iw5_em1zm":
      return 1;
    default:
      return 0;
  }
}

isvalidsecondaryzombies(var_0) {
  switch (var_0) {
    case "iw5_exocrossbowzm":
    case "iw5_mahemzm":
    case "iw5_titan45zm":
    case "iw5_rw1zm":
    case "iw5_vbrzm":
      return 1;
    default:
      return 0;
  }
}

isvalidequipmentzombies(var_0) {
  switch (var_0) {
    case "teleport_zombies":
    case "repulsor_zombie":
    case "dna_aoe_grenade_zombie":
    case "distraction_drone_zombie":
      return 1;
    default:
      return 0;
  }
}

pausezombiespawning(var_0) {
  if(!isDefined(level.zombie_pause_spawning_count)) {
    level.zombie_pause_spawning_count = 0;
  }

  if(var_0) {
    level.zombie_pause_spawning_count++;
  } else {
    level.zombie_pause_spawning_count--;
  }
}

instakillimmune() {
  if(is_true(self.fakeplayer)) {
    return 1;
  } else if(isDefined(self.agent_type)) {
    if(self.agent_type == "zombie_melee_goliath" || self.agent_type == "zombie_boss_oz_stage2") {
      return 1;
    }
  }

  return 0;
}

nohitreactions() {
  if(isDefined(self.agent_type)) {
    if(self.agent_type == "zombie_melee_goliath" || self.agent_type == "zombie_boss_oz_stage2") {
      return 1;
    }
  }

  return 0;
}

isdoortrapimmune() {
  if(isDefined(self.agent_type)) {
    if(self.agent_type == "zombie_melee_goliath" || self.agent_type == "zombie_boss_oz_stage2") {
      return 1;
    }
  }

  return 0;
}

istrapresistant() {
  if(isDefined(self.agent_type)) {
    if(self.agent_type == "zombie_melee_goliath" || self.agent_type == "zombie_boss_oz_stage2") {
      return 1;
    }
  }

  return 0;
}

getenemyagents() {
  var_0 = [];
  var_1 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");

  foreach(var_3 in var_1) {
    if(isDefined(level.despawning_agents) && common_scripts\utility::array_contains(level.despawning_agents, var_3)) {
      continue;
    }
    if(is_true(var_3.waitingtodeactivate)) {
      continue;
    }
    if(!isalliedsentient(self, var_3)) {
      var_0[var_0.size] = var_3;
    }
  }

  return var_0;
}

getnumagentswaitingtodeactivate() {
  var_0 = 0;
  var_1 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");

  foreach(var_3 in level.agentarray) {
    if(isDefined(level.despawning_agents) && common_scripts\utility::array_contains(level.despawning_agents, var_3)) {
      var_0++;
      continue;
    }

    if(is_true(var_3.waitingtodeactivate)) {
      var_0++;
    }
  }

  return var_0;
}

getarrayofoffscreenagentstorecycle(var_0) {
  var_1 = [];

  foreach(var_3 in level.players) {
    if(isalive(var_3)) {
      var_4 = var_3 getnearestnode();

      if(isDefined(var_4)) {
        var_1[var_1.size] = var_4;
      }
    }
  }

  var_6 = [];

  foreach(var_8 in var_0) {
    if(var_8 instakillimmune() || issubstr(var_8.agent_type, "ranged_elite_soldier")) {
      continue;
    }
    var_9 = 1;
    var_10 = var_8 getnearestnode();

    if(isDefined(var_10)) {
      foreach(var_4 in var_1) {
        if(nodesvisible(var_10, var_4, 1)) {
          var_9 = 0;
          break;
        }
      }
    }

    if(var_9) {
      var_6[var_6.size] = var_8;
    }
  }

  return var_6;
}

waittill_any_return_parms_no_endon_death(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = spawnStruct();

  if(isDefined(var_0)) {
    childthread waittill_string_parms_no_endon_death(var_0, var_8);
  }

  if(isDefined(var_1)) {
    childthread waittill_string_parms_no_endon_death(var_1, var_8);
  }

  if(isDefined(var_2)) {
    childthread waittill_string_parms_no_endon_death(var_2, var_8);
  }

  if(isDefined(var_3)) {
    childthread waittill_string_parms_no_endon_death(var_3, var_8);
  }

  if(isDefined(var_4)) {
    childthread waittill_string_parms_no_endon_death(var_4, var_8);
  }

  if(isDefined(var_5)) {
    childthread waittill_string_parms_no_endon_death(var_5, var_8);
  }

  if(isDefined(var_6)) {
    childthread waittill_string_parms_no_endon_death(var_6, var_8);
  }

  if(isDefined(var_7)) {
    childthread waittill_string_parms_no_endon_death(var_7, var_8);
  }

  var_8 waittill("returned", var_9);
  var_8 notify("die");
  return var_9;
}

waittill_string_parms_no_endon_death(var_0, var_1) {
  var_1 endon("die");
  self waittill(var_0, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
  var_12 = [];
  var_12[0] = var_0;

  if(isDefined(var_2)) {
    var_12[1] = var_2;
  }

  if(isDefined(var_3)) {
    var_12[2] = var_3;
  }

  if(isDefined(var_4)) {
    var_12[3] = var_4;
  }

  if(isDefined(var_5)) {
    var_12[4] = var_5;
  }

  if(isDefined(var_6)) {
    var_12[5] = var_6;
  }

  if(isDefined(var_7)) {
    var_12[6] = var_7;
  }

  if(isDefined(var_8)) {
    var_12[7] = var_8;
  }

  if(isDefined(var_9)) {
    var_12[8] = var_9;
  }

  if(isDefined(var_10)) {
    var_12[9] = var_10;
  }

  if(isDefined(var_11)) {
    var_12[10] = var_11;
  }

  var_1 notify("returned", var_12);
}

playerallowfire(var_0, var_1) {
  if(!isDefined(self.playerdisablefire)) {
    self.playerdisablefire = [];
  }

  if(!isDefined(var_1)) {
    var_1 = "default";
  }

  if(var_0) {
    self.playerdisablefire = common_scripts\utility::array_remove(self.playerdisablefire, var_1);

    if(!self.playerdisablefire.size) {
      self allowfire(1);
    }
  } else {
    if(!isDefined(common_scripts\utility::array_find(self.playerdisablefire, var_1))) {
      self.playerdisablefire = common_scripts\utility::array_add(self.playerdisablefire, var_1);
    }

    self allowfire(0);
  }
}

iszombieshardmode() {
  return is_true(game["start_in_zmb_hard_mode"]);
}

disablekillstreaks() {
  if(!isDefined(level.disablekillstreaks)) {
    level.disablekillstreaks = 0;
  }

  level.disablekillstreaks++;
}

enablekillstreaks() {
  if(!isDefined(level.disablekillstreaks)) {
    level.disablekillstreaks = 0;
  } else if(level.disablekillstreaks > 0) {
    level.disablekillstreaks--;
  }
}

arekillstreaksdisabled() {
  return isDefined(level.disablekillstreaks) && level.disablekillstreaks > 0;
}

disablepickups() {
  if(!isDefined(level.disablepickups)) {
    level.disablepickups = 0;
  }

  level.disablepickups++;
}

enablepickups() {
  if(!isDefined(level.disablepickups)) {
    level.disablepickups = 0;
  } else if(level.disablepickups > 0) {
    level.disablepickups--;
  }
}

arepickupsdisabled() {
  return isDefined(level.disablepickups) && level.disablepickups > 0;
}

disablewallbuys() {
  if(!isDefined(level.disablewallbuys)) {
    level.disablewallbuys = 0;
  }

  level.disablewallbuys++;
  level notify("disableWallbuysUpdate");
}

enablewallbuys() {
  if(!isDefined(level.disablewallbuys)) {
    level.disablewallbuys = 0;
  } else if(level.disablewallbuys > 0) {
    level.disablewallbuys--;
    level notify("disableWallbuysUpdate");
  }
}

arewallbuysdisabled() {
  return isDefined(level.disablewallbuys) && level.disablewallbuys > 0;
}

setfriendlyfireround(var_0) {
  if(is_true(var_0)) {
    level.friendlyfire = 1;
    level.teamtweaks["fftype"].value = 1;
  } else {
    level.friendlyfire = 0;
    level.teamtweaks["fftype"].value = 0;
  }
}

isfriendlyfireround() {
  return level.friendlyfire == 1;
}