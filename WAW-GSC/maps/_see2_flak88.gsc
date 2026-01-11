/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_see2_flak88.gsc
*****************************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_vehicle;
#include maps\_vehicle_aianim;
#include maps\_anim;

main(model, type) {
  level.tanks = [];
  build_template("see2_flak88", model, type);
  build_localinit(::init_local);
  build_deathmodel("german_artillery_flak88_nm", "german_artillery_flak88_nm_destroy");
  build_deathmodel("artillery_ger_flak88_winter", "artillery_ger_flak88_winter_d");
  build_deathmodel("artillery_ger_flak88", "artillery_ger_flak88_d");
  build_shoot_shock("tankblast");
  build_deathfx("explosions/large_vehicle_explosion", undefined, "explo_metal_rand");
  build_life(999, 500, 1500);
  build_team("axis");
  build_mainturret();
  level.flak88_shell_model = "grenade_bag";
  level.flak88_bomb_model = "grenade_bag";
  level.flak88_bomb_model_obj = "grenade_bag";
  level.timersused = 0;
  level.safetyRange = 350;
  load_crew_anims();
  array_levelthread(getEntArray("flakbarrel", "targetname"), ::flakbarrel);
}

init_local() {
  self flak88_init();
}

#using_animtree("generic_human");

load_crew_anims() {
  level.scr_anim["leader"]["fire"] = % ai_88antitank_leader_loadandfire;
  level.scr_anim["leader"]["idle0"] = % ai_88antitank_leader_twitch;
  level.scr_anim["leader"]["idle1"] = % ai_88antitank_leader_idle;
  level.scr_anim["leader"]["idle2"] = % ai_88antitank_leader_idle;
  level.scr_anim["leader"]["idle3"] = % ai_88antitank_leader_idle;
  level.scr_anim["leader"]["idle4"] = % ai_88antitank_leader_idle;
  level.scr_anim["leader"]["turnleft"] = % ai_88antitank_leader_turnleft;
  level.scr_anim["leader"]["turnright"] = % ai_88antitank_leader_turnright;
  level.scr_anim["leader"]["commandleft"] = % ai_88antitank_leader_commandright;
  level.scr_anim["leader"]["commandright"] = % ai_88antitank_leader_commandleft;
  level.scr_anim["passer"]["fire"] = % ai_88antitank_passer_loadandfire;
  level.scr_anim["passer"]["idle0"] = % ai_88antitank_passer_twitch;
  level.scr_anim["passer"]["idle1"] = % ai_88antitank_passer_idle;
  level.scr_anim["passer"]["idle2"] = % ai_88antitank_passer_idle;
  level.scr_anim["passer"]["idle3"] = % ai_88antitank_passer_idle;
  level.scr_anim["passer"]["idle4"] = % ai_88antitank_passer_idle;
  level.scr_anim["passer"]["turnleft"] = % ai_88antitank_passer_turnright;
  level.scr_anim["passer"]["turnright"] = % ai_88antitank_passer_turnleft;
  level.scr_anim["loader"]["fire"] = % ai_88antitank_loader_loadandfire;
  level.scr_anim["loader"]["idle0"] = % ai_88antitank_loader_twitch;
  level.scr_anim["loader"]["idle1"] = % ai_88antitank_loader_idle;
  level.scr_anim["loader"]["idle2"] = % ai_88antitank_loader_idle;
  level.scr_anim["loader"]["idle3"] = % ai_88antitank_loader_idle;
  level.scr_anim["loader"]["idle4"] = % ai_88antitank_loader_idle;
  level.scr_anim["loader"]["turnleft"] = % ai_88antitank_loader_turnleft;
  level.scr_anim["loader"]["turnright"] = % ai_88antitank_loader_turnright;
  level.scr_anim["ejecter"]["fire"] = % ai_88antitank_ejecter_loadandfire;
  level.scr_anim["ejecter"]["idle0"] = % ai_88antitank_ejecter_twitch;
  level.scr_anim["ejecter"]["idle1"] = % ai_88antitank_ejecter_idle;
  level.scr_anim["ejecter"]["idle2"] = % ai_88antitank_ejecter_idle;
  level.scr_anim["ejecter"]["idle3"] = % ai_88antitank_ejecter_idle;
  level.scr_anim["ejecter"]["idle4"] = % ai_88antitank_ejecter_idle;
  level.scr_anim["ejecter"]["turnleft"] = % ai_88antitank_ejecter_turnright;
  level.scr_anim["ejecter"]["turnright"] = % ai_88antitank_ejecter_turnleft;
  level.scr_anim["aimer"]["fire"] = % ai_88antitank_aimer_loadandfire;
  level.scr_anim["aimer"]["idle0"] = % ai_88antitank_aimer_twitch;
  level.scr_anim["aimer"]["idle1"] = % ai_88antitank_aimer_idle;
  level.scr_anim["aimer"]["idle2"] = % ai_88antitank_aimer_idle;
  level.scr_anim["aimer"]["idle3"] = % ai_88antitank_aimer_idle;
  level.scr_anim["aimer"]["idle4"] = % ai_88antitank_aimer_idle;
  level.scr_anim["aimer"]["turnleft"] = % ai_88antitank_aimer_turnright;
  level.scr_anim["aimer"]["turnright"] = % ai_88antitank_aimer_turnleft;
}

flakcrew_animation_think(flak) {
  self endon("death");
  self endon("crew dismounted");
  flak endon("crew dismounted");
  flak endon("newcrew");
  for(;;) {
    if(flak.turning != "none") {
      self thread flakcrew_playAnim(flak, flak.turning);
    } else {
      self thread flakcrew_playAnim(flak, "idle" + randomint(5));
    }
    self waittill("flakcrew animation done");
  }
}

flakcrew_playAnim(flak, animName) {
  self notify("stop anim");
  self endon("stop anim");
  self endon("death");
  flak endon("death");
  flak endon("crew dismounted");
  tagOrigin = flak getTagOrigin("tag_turret");
  tagAngles = flak getTagAngles("tag_turret");
  if(isalive(self)) {
    self animscripted("scriptedanimdone", tagOrigin, tagAngles, level.scr_anim[self.crewposition][animName]);
    self thread donotetracks_flak88("scriptedanimdone", flak);
    self.allowDeath = 1;
    self waittillmatch("scriptedanimdone", "end");
    self notify("flakcrew animation done");
  }
}

donotetracks_flak88(anime, flak) {
  self endon("stop anim");
  self endon("death");
  flak endon("death");
  flak endon("crew dead");
  flak endon("crew dismounted");
  while(1) {
    self waittill(anime, note);
    switch (note) {
      case "attach":
        self attach_shell();
        break;
      case "detach":
        self detach_shell();
        break;
      case "end":
        break;
      default:
        self detach_shell();
        break;
    }
  }
}

detach_shell() {
  if(self.has_shell) {
    self.has_shell = false;
    self detach(level.flak88_shell_model, "tag_weapon_right");
  }
}

attach_shell() {
  if(!self.has_shell) {
    self.has_shell = true;
    self attach(level.flak88_shell_model, "tag_weapon_right");
  }
}

flakcrew_gunbackinhand(flak) {
  self endon("death");
  flak endon("newcrew");
  flak waittill_any("crew dismounted", "crew dead", "death");
  self detach_shell();
  flak notify("crew dismounted");
  if(!flak isCheap()) {
    self animscripts\shared::placeWeaponOn(self.primaryweapon, "right");
  } else {
    self maps\_drone::drone_show_weapon();
  }
  self.health = self.oldhealth;
  self.oldhealth = undefined;
  wait randomfloatrange(0, 1);
  self stopanimscripted();
}

badplace_when_near() {
  if(level.script == "elalamein") {
    return;
  }
  self endon("death");
  self endon("bomb planted");
  trig = spawn("trigger_radius", self.origin, 0, 200, 200);
  for(;;) {
    trig waittill("trigger");
    badplacename = ("flak_badplace_player_near" + randomint(1000));
    badplace_cylinder(badplacename, 2, self.origin, 250, 300);
    wait 1.8;
  }
}

flak_use_dismount() {
  self waittill("trigger");
  level flak88_dismount_crew(self, true);
}

flak88_init() {
  if(!isDefined(self.script_team)) {
    self.script_team = "axis";
  }
  self thread kill_flak88();
  self thread shoot();
  self.enemyque = [];
  if(isDefined(self.target)) {
    targeted = getEntArray(self.target, "targetname");
    triggerUse = [];
    for(i = 0; i < targeted.size; i++) {
      if(targeted[i].classname == "trigger_use") {
        triggerUse[triggerUse.size] = targeted[i];
      } else if(targeted[i].classname == "script_origin") {
        self.customTarget = targeted[i];
      }
    }
    if(triggerUse.size > 0) {
      self.bombTriggers = [];
      self.bombs = [];
      for(i = 0; i < triggerUse.size; i++) {
        if(isDefined(triggerUse[i].target)) {
          tempBomb = getent(triggerUse[i].target, "targetname");
          if(isDefined(tempBomb)) {
            self.bombTriggers[self.bombTriggers.size] = triggerUse[i];
            self.bombs[self.bombs.size] = tempBomb;
          }
        }
      }
      if((self.bombTriggers.size > 0) && (self.bombs.size > 0)) {
        self thread flak88_explosives();
        self thread badplace_when_near();
      }
    }
  }
  self.turning = "none";
  self thread flak_monitorTurretAngles();
  self thread flak_use_dismount();
  if(isDefined(self.script_flak88)) {
    self spawner_trigger();
  }
}

flak_monitorTurretAngles() {
  self endon("death");
  self endon("crew dismounted");
  prevAngles = (0, 0, 0);
  newAngles = (0, 0, 0);
  for(;;) {
    prevAngles = newAngles;
    newAngles = self getTagAngles("tag_turret");
    if(newAngles[1] < prevAngles[1]) {
      self.turning = "turnright";
    } else if(newAngles[1] > prevAngles[1]) {
      self.turning = "turnleft";
    } else {
      self.turning = "none";
    }
    wait 0.1;
  }
}

flak88_explosives() {
  self endon("death");
  for(i = 0; i < self.bombs.size; i++) {
    self.bombs[i] linkto(self, "tag_turret");
    self.bombs[i] setModel(level.flak88_bomb_model_obj);
  }
  for(i = 0; i < self.bombTriggers.size; i++) {
    self.bombTriggers[i] enablelinkto();
    self.bombTriggers[i] linkto(self, "tag_barrel");
    self thread flak88_explosives_wait(self.bombTriggers[i]);
  }
  self waittill("explosives planted");
  badplace_cylinder("", level.explosiveplanttime, self.origin, 250, 300);
  iprintlnbold(&"SCRIPT_EXPLOSIVESPLANTED");
  for(i = 0; i < self.bombTriggers.size; i++) {
    self.bombTriggers[i] delete();
  }
  bomb = getClosest(get_players()[0] getOrigin(), self.bombs);
  bomb setModel(level.flak88_bomb_model);
  bomb playSound("explo_plant_rand");
  bomb thread loopsound_for_time_or_death("bomb_tick", level.explosiveplanttime);
  for(i = 0; i < self.bombs.size; i++) {
    if(self.bombs[i] == bomb) {
      continue;
    }
    self.bombs[i] delete();
  }
  if(isDefined(self.bombstopwatch)) {
    self.bombstopwatch destroy();
  }
  level.timersused++;
  wait level.explosiveplanttime;
  bomb stoploopsound("bomb_tick");
  level.timersused--;
  if(level.timersused < 1) {
    if(isDefined(self.bombstopwatch)) {
      self.bombstopwatch destroy();
    }
  }
  self notify("death", get_players()[0]);
}

loopsound_for_time_or_death(sound, time) {
  self endon("death");
  self playLoopSound(sound);
  wait time;
  self stoploopsound(sound);
}

loopsound_end_ondeath(sound) {}

flak88_explosives_wait(trigger) {
  self endon("death");
  self endon("explosives planted");
  trigger setHintString(&"SCRIPT_PLATFORM_HINTSTR_PLANTEXPLOSIVES");
  trigger waittill("trigger");
  if(isDefined(trigger.script_noteworthy)) {
    level notify(trigger.script_noteworthy);
  }
  self notify("explosives planted", trigger);
}

stop_flak88_objective(flak) {
  self waittill("trigger");
  flak.remaining_ai_afterstop = 0;
  ai = getaiarray("axis");
  for(i = 0; i < ai.size; i++) {
    if(distance(flat_origin(ai[i].origin), flat_origin(flak.origin)) < 600) {
      ai[i] thread stop_flak88_remainingai(flak);
    }
  }
  if(!flak.remaining_ai_afterstop) {
    flak notify("flakai_cleared");
  }
}

stop_flak88(flak) {
  flak endon("death");
  flak endon("crew dead");
  flak endon("crew dismounted");
  self waittill("trigger");
  flak88_dismount_crew(flak);
}

stop_flak88_remainingai(flak) {
  flak.remaining_ai_afterstop++;
  self waittill("death");
  flak.remaining_ai_afterstop--;
  if(!flak.remaining_ai_afterstop) {
    flak notify("flakai_cleared");
  }
}

spawn_trigger_wait(trigger) {
  trigger waittill("trigger");
  if(isDefined(trigger.script_noteworthy)) {
    level waittill(trigger.script_noteworthy);
  }
  if(isDefined(trigger.script_flakaicount)) {
    count = trigger.script_flakaicount;
    if(isDefined(level.flakaicountmod) && count) {
      count--;
    }
  } else
    count = undefined;
  self notify("spawntriggered", count);
}

spawner_trigger() {
  self endon("death");
  if(!isDefined(self.script_flak88)) {
    return;
  }
  spawn_trigger = false;
  AllTrigs = [];
  AllTrigs = getEntArray("trigger_multiple", "classname");
  trigs2 = [];
  trigs2 = getEntArray("trigger_radius", "classname");
  if(isDefined(trigs2[0])) {
    for(i = 0; i < trigs2.size; i++) {
      AllTrigs[AllTrigs.size] = trigs2[i];
    }
  }
  if(isDefined(AllTrigs[0])) {
    for(i = 0; i < AllTrigs.size; i++) {
      if((isDefined(AllTrigs[i].script_flak88)) && (AllTrigs[i].script_flak88 == self.script_flak88)) {
        if((isDefined(AllTrigs[i].targetname)) && (AllTrigs[i].targetname == "stop flak88")) {
          alltrigs[i] thread stop_flak88_objective(self);
          continue;
        }
        spawn_trigger = true;
        thread spawn_trigger_wait(AllTrigs[i]);
      }
    }
  }
  ents = getspawnerarray();
  spawners = [];
  for(i = 0; i < ents.size; i++) {
    if(!isDefined(ents[i].script_flak88)) {
      continue;
    }
    if(ents[i].script_flak88 == self.script_flak88) {
      spawners[spawners.size] = ents[i];
    }
  }
  if(spawners.size == 0) {
    return;
  }
  crewspawned = false;
  count = 0;
  while(1) {
    numberofguys = undefined;
    if(spawn_trigger) {
      self waittill("spawntriggered", numberofguys);
    }
    self.crewsize = 0;
    self.crewMembers = [];
    if(!isDefined(numberofguys)) {
      numberofguys = spawners.size;
    }
    println("attempting to set up new flakcrew for: ", self.script_flak88);
    count++;
    self notify("newcrew");
    leader = undefined;
    loader = undefined;
    passer = undefined;
    ejecter = undefined;
    aimer = undefined;
    for(i = 0; i < numberofguys; i++) {
      wait_network_frame();
      if(!isDefined(spawners[i])) {
        continue;
      }
      spawners[i].count = 1;
      spawned = undefined;
      if(!self isCheap()) {
        spawned = spawners[i] spawn_ai();
      } else {
        maps\_spawner::dronespawn_setstruct(spawners[i]);
        spawned = dronespawn(spawners[i]);
        if(isDefined(spawned)) {
          spawned thread maps\_drones::drone_fakeDeath();
          spawned.no_death_sink = true;
          spawned.team = "axis";
        }
      }
      if(!spawn_failed(spawned) || self isCheap()) {
        self.crewposition = undefined;
        self.crewsize++;
        self.crewMembers[self.crewMembers.size] = spawned;
        if(!self isCheap()) {
          spawned.goalradius = 768;
          spawned setgoalpos(self.origin);
        }
        spawned.has_shell = false;
        if(!isDefined(loader)) {
          spawned.crewposition = "loader";
          loader = 1;
        } else if(!isDefined(passer)) {
          spawned.crewposition = "passer";
          passer = 1;
        } else if(!isDefined(leader)) {
          spawned.crewposition = "leader";
          leader = 1;
        } else if(!isDefined(ejecter)) {
          spawned.crewposition = "ejecter";
          ejecter = 1;
        } else if(!isDefined(aimer)) {
          spawned.crewposition = "aimer";
          aimer = 1;
        } else {
          if(!self isCheap()) {
            self.crewsize--;
            if(!isDefined(spawned.target)) {
              spawned.goalradius = 800;
              spawned setGoalPos(self.origin);
            } else {
              node = getnode(spawned.target, "targetname");
              if(isDefined(node)) {
                spawned setgoalNode(node);
              }
            }
          }
        }
        if(isDefined(spawned.crewposition)) {
          spawned.oldhealth = spawned.health;
          if(spawned.oldhealth <= 0) {
            spawned.oldhealth = 1;
          }
          spawned.health = 1;
          spawned linkto(self, "tag_turret");
          spawned.anim_disablelongdeath = true;
          if(!self isCheap()) {
            spawned animscripts\shared::placeWeaponOn(spawned.primaryweapon, "none");
          } else {
            spawned maps\_drone::drone_hide_weapon();
          }
          spawned thread flakcrew_animation_think(self);
          spawned thread flakcrew_gunbackinhand(self);
          thread delete_on_newcrew(spawned);
        }
        if(!self isCheap()) {
          level thread flak88_crew_waittill_death(self, spawned);
        } else {
          level thread flak88_crew_waittill_damage(self, spawned);
          self thread flak88_cleanup_after_death();
        }
      }
    }
    self.crewmembers = array_removeDead(self.crewmembers);
    self thread flak88_waittill_crewdead(self.crewmembers);
    self thread think();
    trigs = getEntArray("stop flak88", "targetname");
    for(i = 0; i < trigs.size; i++) {
      if((isDefined(trigs[i].script_flak88)) && (trigs[i].script_flak88 == self.script_flak88)) {
        trigs[i] thread stop_flak88(self);
        break;
      }
    }
    if(!spawn_trigger) {
      break;
    }
  }
}

mount_world_flakcrew(entArray) {
  crew_array = [];
  if(!isDefined(self.crewmembers)) {
    self.crewmembers = [];
    self.crewsize = 5;
  }
  for(i = 0; i < self.crewsize; i++) {
    if(isDefined(self.crewmembers[i])) {
      ASSERTMSG("Trying to set a new crew on a flak 88 with a designated crew!");
      return;
    }
  }
  self notify("newcrew");
  leader = undefined;
  loader = undefined;
  passer = undefined;
  ejecter = undefined;
  aimer = undefined;
  for(i = 0; i < entArray.size; i++) {
    if(!isDefined(entArray[i])) {
      continue;
    }
    self.crewposition = undefined;
    self.crewsize++;
    self.crewMembers[self.crewMembers.size] = entArray[i];
    entArray[i].goalradius = 768;
    entArray[i] setgoalpos(self.origin);
    entArray[i].has_shell = false;
    if(!isDefined(loader)) {
      entArray[i].crewposition = "loader";
      entArray[i].animname = "loader";
      crew_array = array_add(crew_array, entArray[i]);
      loader = 1;
    } else if(!isDefined(passer)) {
      entArray[i].crewposition = "passer";
      entArray[i].animname = "passer";
      crew_array = array_add(crew_array, entArray[i]);
      passer = 1;
    } else if(!isDefined(leader)) {
      entArray[i].crewposition = "leader";
      entArray[i].animname = "leader";
      crew_array = array_add(crew_array, entArray[i]);
      leader = 1;
    } else if(!isDefined(ejecter)) {
      entArray[i].crewposition = "ejecter";
      entArray[i].animname = "ejecter";
      crew_array = array_add(crew_array, entArray[i]);
      ejecter = 1;
    } else if(!isDefined(aimer)) {
      entArray[i].crewposition = "aimer";
      entArray[i].animname = "aimer";
      crew_array = array_add(crew_array, entArray[i]);
      aimer = 1;
    } else {
      self.crewsize--;
      if(!isDefined(entArray[i].target)) {
        entArray[i].goalradius = 800;
        entArray[i] setGoalPos(self.origin);
      } else {
        node = getnode(entArray[i].target, "targetname");
        if(isDefined(node)) {
          entArray[i] setgoalNode(node);
        }
      }
    }
    level thread flak88_crew_waittill_death(self, entArray[i]);
  }
  level anim_reach(crew_array, "idle1", "tag_turret", self);
  for(i = 0; i < crew_array.size; i++) {
    entArray[i].oldhealth = entArray[i].health;
    entArray[i].health = 1;
    entArray[i] linkto(self, "tag_turret");
    entArray[i].anim_disablelongdeath = true;
    entArray[i] animscripts\shared::placeWeaponOn(entArray[i].primaryweapon, "none");
    entArray[i] thread flakcrew_animation_think(self);
    entArray[i] thread flakcrew_gunbackinhand(self);
  }
  self.crewmembers = array_removeDead(self.crewmembers);
  self thread flak88_waittill_crewdead(self.crewmembers);
  self thread think();
  trigs = getEntArray("stop flak88", "targetname");
  for(i = 0; i < trigs.size; i++) {
    if((isDefined(trigs[i].script_flak88)) && (trigs[i].script_flak88 == self.script_flak88)) {
      trigs[i] thread stop_flak88(self);
      break;
    }
  }
}

delete_on_newcrew(spawned) {
  spawned endon("death");
  self waittill("newcrew");
  spawned delete();
}

flak88_dismount_crew(flak, used) {
  if(!isDefined(used)) {
    used = false;
  }
  if(isDefined(flak.crewMembers)) {
    for(i = 0; i < flak.crewMembers.size; i++) {
      if(!isDefined(flak.crewMembers[i])) {
        continue;
      }
      flak.crewMembers[i] detach_shell();
      flak.crewMembers[i] unlink();
    }
  }
  if(!used) {
    flak clearTurretTarget();
  }
  flak notify("crew dismounted");
}

flak88_waittill_crewdead(guys) {
  self endon("newcrew");
  level waittill_dead(guys);
  self notify("crew dead");
}

flak88_crew_waittill_damage(flak, crew_member) {
  flak endon("newcrew");
  flak endon("death");
  flak endon("crew dismounted");
  crew_member endon("crew dismounted");
  crew_member waittill("damage", damage, other, direction, origin, damage_type);
  if(!isDefined(crew_member) || damage > crew_member.health) {
    for(i = 0; i < flak.crewsize; i++) {
      if(isDefined(flak.crewMembers[i])) {
        flak.crewMembers[i] doDamage(flak.crewMembers[i].health, flak.crewMembers[i].origin, other);
        flak.crewMembers[i] thread cleanup_drones();
      }
    }
  }
  flak notify("crew dead");
}

flak88_cleanup_after_death() {
  self waittill("death");
  for(i = 0; i < self.crewsize; i++) {
    if(isDefined(self.crewMembers[i])) {
      self.crewMembers[i] thread cleanup_drones();
    }
  }
}

cleanup_drones() {
  wait(3);
  if(isDefined(self)) {
    self delete();
  }
}

flak88_crew_waittill_death(flak, crew_member) {
  flak endon("newcrew");
  flak endon("death");
  flak endon("crew dismounted");
  crew_member endon("crew dismounted");
  isLeader = false;
  if((isDefined(crew_member.crewposition)) && (crew_member.crewposition == "leader")) {
    isLeader = true;
  }
  crew_member waittill("death");
  if(isDefined(crew_member)) {
    crew_member detach_shell();
    crew_member unlink();
  }
  flak.crewsize--;
  if(flak.crewsize <= 0) {
    flak clearTurretTarget();
    flak notify("crew dead");
  } else if(!isLeader) {
    flak clearTurretTarget();
    flak88_dismount_crew(flak);
  }
}

kill_flak88() {
  notifyString = undefined;
  self waittill("death");
  if(isDefined(level.hitbyplayervehiclethread)) {
    thread[[level.hitbyplayervehiclethread]]();
  }
  ai = getaiarray();
  for(i = 0; i < ai.size; i++) {
    if(!isDefined(ai[i])) {
      continue;
    }
    if(!isalive(ai[i])) {
      continue;
    }
    if(!isDefined(ai[i].script_flak88)) {
      continue;
    }
    if(!isDefined(self.script_flak88)) {
      continue;
    }
    if((isDefined(ai[i].script_flak88)) && (ai[i].script_flak88 == self.script_flak88)) {
      ai[i] unlink();
      if(distance(self.origin, ai[i].origin) <= 350) {
        ai[i] doDamage(ai[i].health, ai[i].origin);
      }
      if(self isCheap()) {
        ai[i] thread cleanup_drones();
      }
    }
  }
  if(isDefined(notifyString)) {
    level notify(notifyString);
  }
  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self.bombstopwatch)) {
    self.bombstopwatch destroy();
  }
  if(level.playervehicle != self) {
    self clearTurretTarget();
  }
  if(isDefined(self.deathsound)) {
    self playSound(self.deathsound);
  }
  if(isDefined(self.deathfx)) {
    level thread maps\_fx::OneShotfx(self.deathfx, self.origin, 0);
  }
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i] enableHealthShield(false);
    radiusDamage(self.origin + (0, 0, 300), 400, 700, 100);
    players[i] enableHealthShield(true);
  }
  level thread maps\_fx::loopfx("damaged_vehicle_smoke", self.origin, .8);
  earthquake(0.25, 3, self.origin, 1050);
  if(isDefined(self.deathmodel)) {
    self setModel(self.deathmodel);
  }
  if(isDefined(self.bombs)) {
    for(i = 0; i < self.bombs.size; i++) {
      if(isDefined(self.bombs[i])) {
        self.bombs[i] delete();
      }
    }
  }
  if(isDefined(self.bombTriggers)) {
    for(i = 0; i < self.bombTriggers.size; i++) {
      if(isDefined(self.bombTriggers[i])) {
        self.bombTriggers[i] delete();
      }
    }
  }
}

shoot_flak(org, no_anim) {
  if(!isDefined(org)) {
    return false;
  }
  if(!isDefined(self)) {
    return false;
  }
  if(self.health <= 0) {
    return false;
  }
  wait 0.2;
  if(isDefined(self.crewMembers) && !isDefined(no_anim)) {
    for(i = 0; i < self.crewMembers.size; i++) {
      if((isDefined(self.crewMembers[i])) && (isDefined(self.crewMembers[i].crewposition))) {
        self.crewMembers[i] thread flakcrew_playAnim(self, "fire");
      }
    }
  }
  self notify("turret_fire");
  wait 0.2;
  return true;
}

think() {
  self endon("death");
  self endon("newcrew");
  if(!isDefined(self.script_accuracy)) {
    self.script_accuracy = .4;
  } else if(self.script_accuracy >= 1.000) {
    self.script_accuracy = .99;
  }
  if((!isDefined(self.script_delay_min)) || (!isDefined(self.script_delay_max))) {
    self.script_delay_min = 4;
    self.script_delay_max = 8;
  }
  if((isDefined(self.script_leftarc)) && (isDefined(self.script_rightarc)) && ((self.script_leftarc + self.script_rightarc) >= 360)) {
    self.script_leftarc = undefined;
    self.script_rightarc = undefined;
  }
  delay_difference = (self.script_delay_max - self.script_delay_min);
  if((!isDefined(self.script_shoottanks)) && (!isDefined(self.script_shootAI))) {
    self.script_shoottanks = 0;
    self.script_shootai = 0;
  }
  if(!isDefined(self.script_shoottanks)) {
    self.script_shoottanks = 1;
  }
  if(!isDefined(self.script_shootAI)) {
    self.script_shootAI = 0;
  }
  if((self.script_shoottanks == 0) && (self.script_shootai == 0)) {
    self.autoTarget = false;
  }
  if(!isDefined(self.autoTarget)) {
    self.autoTarget = true;
  }
  /
  return true;
}

Target_Kill_Using_Accuracy(flak, target, delay_difference) {
  flak endon("crew dead");
  flak endon("crew dismounted");
  if(!isDefined(target)) {
    return;
  }
  if((target.classname != "script_origin") && (target.health <= 0)) {
    return;
  }
  if(target.classname != "script_origin") {
    if((isDefined(self.autoTarget)) && (self.autoTarget == false)) {
      return;
    }
  }
  if(isSentient(target)) {
    aim_org = target getEye();
    aim_org = aim_org - (0, 0, 20);
  } else if(target.classname == "script_origin")
    aim_org = target.origin;
  else {
    aim_org = (target.origin + (0, 0, 40));
  }
  offset_x = randomfloat(100 - flak.script_accuracy * 100);
  offset_y = randomfloat(100 - flak.script_accuracy * 100);
  offset_z = randomfloat(100 - flak.script_accuracy * 100);
  if(isSentient(target)) {
    offset_x = (offset_x * .3);
    offset_y = (offset_y * .3);
    offset_z = (offset_z * .3);
  } else
    offset_z = (offset_z * .5);
  if(randomint(2) == 0) {
    offset_x = (offset_x * -1);
  }
  if(randomint(2) == 0) {
    offset_y = (offset_y * -1);
  }
  if(randomint(2) == 0) {
    offset_z = (offset_z * -1);
  }
  aim_org = (aim_org + (offset_x, offset_y, offset_z));
  flak thread debug_flak88_drawLines(aim_org);
  flak setTurretTargetVec(aim_org);
  flak waittill_notify_or_timeout("turret_on_target", 3);
  flak clearTurretTarget();
  org = flak gettagorigin("tag_flash");
  vec = aim_org - org;
  final_pos = org + (800 * VectorNormalize(vec));
  trace = bulletTrace(org, final_pos, 0, flak);
  dist = distanceSquared(flak.origin, trace["position"]);
  if(dist < (700 * 700)) {
    return;
  }
  if(issentient(target) && (target.health <= 0 || !sighttracepassed(flak gettagorigin("tag_flash"), aim_org, 0, flak) || dist < (700 * 700))) {
    return;
  }
  if(isDefined(flak.script_startnotify)) {
    flak waittill(flak.script_startnotify);
    flak.script_startnotify = undefined;
  }
  wait(0.3);
  if(distanceSquared(target.origin, flak.origin) < 600 * 600) {
    wait(1.7);
    flak shoot_flak(aim_org);
  } else {
    flak shoot_flak(aim_org, false);
  }
  if(isDefined(delay_difference)) {
    if(delay_difference <= 0) {
      wait flak.script_delay_min;
    } else {
      wait(flak.script_delay_min + randomfloat(delay_difference));
    }
  }
  return;
}

cone_check(flak88, target_org) {
  if((!isDefined(flak88.script_leftarc)) || (!isDefined(flak88.script_leftarc))) {
    return true;
  }
  forwardvec = anglesToForward(flak88.angles);
  orgA = flak88.origin;
  orgB = target_org;
  normalvec = vectorNormalize(orgB - orgA);
  vecdot = vectordot(forwardvec, normalvec);
  if(flak88.script_leftarc == flak88.script_rightarc) {
    if(vecdot > cos(flak88.script_leftarc)) {
      return true;
    }
    return false;
  } else {
    rightvec = anglestoright(flak88.angles);
    rightvecdot = vectordot(rightvec, normalvec);
    if(rightvecdot >= 0) {
      return (vecdot > cos(flak88.script_rightarc));
    } else {
      return (vecdot > cos(flak88.script_leftarc));
    }
  }
}

debug_flak88_drawLines(targetOrg) {
  self notify("stop drawing debug lines");
  self endon("death");
  self endon("stop drawing debug lines");
  return;
  for(;;) {
    line(self.origin + (0, 0, 68), targetOrg, (0.2, 0.5, 0.8), 0.5);
    wait 0.05;
  }
}

shoot() {
  while(self.health > 0) {
    self waittill("turret_fire");
    self fire_flak88();
  }
}

fire_flak88() {
  if(self.health <= 0) {
    return;
  }
}

flakbarrel(flakbarrel) {
  flakbarrel solid();
  flak = getent(flakbarrel.target, "targetname");
  flakbarrel linkto(flak, "tag_barrel");
  flak waittill("death");
  flakbarrel unlink();
}