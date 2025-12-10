/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\margwa.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\archetype_mocomps_utility;
#using scripts\shared\ai\archetype_utility;
#using scripts\shared\ai\margwa;
#using scripts\shared\ai\systems\animation_state_machine_mocomp;
#using scripts\shared\ai\systems\animation_state_machine_notetracks;
#using scripts\shared\ai\systems\animation_state_machine_utility;
#using scripts\shared\ai\systems\behavior_tree_utility;
#using scripts\shared\ai\systems\blackboard;
#using scripts\shared\ai\systems\debug;
#using scripts\shared\ai\systems\gib;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\fx_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\util_shared;
#namespace margwabehavior;

function autoexec init() {
  initmargwabehaviorsandasm();
  spawner::add_archetype_spawn_function("margwa", &archetypemargwablackboardinit);
  spawner::add_archetype_spawn_function("margwa", &margwaserverutils::margwaspawnsetup);
  clientfield::register("actor", "margwa_head_left", 1, 2, "int");
  clientfield::register("actor", "margwa_head_mid", 1, 2, "int");
  clientfield::register("actor", "margwa_head_right", 1, 2, "int");
  clientfield::register("actor", "margwa_fx_in", 1, 1, "counter");
  clientfield::register("actor", "margwa_fx_out", 1, 1, "counter");
  clientfield::register("actor", "margwa_fx_spawn", 1, 1, "counter");
  clientfield::register("actor", "margwa_smash", 1, 1, "counter");
  clientfield::register("actor", "margwa_head_left_hit", 1, 1, "counter");
  clientfield::register("actor", "margwa_head_mid_hit", 1, 1, "counter");
  clientfield::register("actor", "margwa_head_right_hit", 1, 1, "counter");
  clientfield::register("actor", "margwa_head_killed", 1, 2, "int");
  clientfield::register("actor", "margwa_jaw", 1, 6, "int");
  clientfield::register("toplayer", "margwa_head_explosion", 1, 1, "counter");
  clientfield::register("scriptmover", "margwa_fx_travel", 1, 1, "int");
  clientfield::register("scriptmover", "margwa_fx_travel_tell", 1, 1, "int");
  clientfield::register("actor", "supermargwa", 1, 1, "int");
  initdirecthitweapons();
}

function private initdirecthitweapons() {
  if(!isDefined(level.dhweapons)) {
    level.dhweapons = [];
  }
  level.dhweapons[level.dhweapons.size] = "ray_gun";
  level.dhweapons[level.dhweapons.size] = "ray_gun_upgraded";
  level.dhweapons[level.dhweapons.size] = "pistol_standard_upgraded";
  level.dhweapons[level.dhweapons.size] = "pistol_revolver38_upgraded";
  level.dhweapons[level.dhweapons.size] = "pistol_revolver38lh_upgraded";
  level.dhweapons[level.dhweapons.size] = "launcher_standard";
  level.dhweapons[level.dhweapons.size] = "launcher_standard_upgraded";
}

function adddirecthitweapon(weaponname) {
  foreach(weapon in level.dhweapons) {
    if(weapon == weaponname) {
      return;
    }
  }
  level.dhweapons[level.dhweapons.size] = weaponname;
}

function private initmargwabehaviorsandasm() {
  behaviortreenetworkutility::registerbehaviortreescriptapi("margwaTargetService", &margwatargetservice);
  behaviortreenetworkutility::registerbehaviortreescriptapi("margwaShouldSmashAttack", &margwashouldsmashattack);
  behaviortreenetworkutility::registerbehaviortreescriptapi("margwaShouldSwipeAttack", &margwashouldswipeattack);
  behaviortreenetworkutility::registerbehaviortreescriptapi("margwaShouldShowPain", &margwashouldshowpain);
  behaviortreenetworkutility::registerbehaviortreescriptapi("margwaShouldReactStun", &margwashouldreactstun);
  behaviortreenetworkutility::registerbehaviortreescriptapi("margwaShouldReactIDGun", &margwashouldreactidgun);
  behaviortreenetworkutility::registerbehaviortreescriptapi("margwaShouldReactSword", &margwashouldreactsword);
  behaviortreenetworkutility::registerbehaviortreescriptapi("margwaShouldSpawn", &margwashouldspawn);
  behaviortreenetworkutility::registerbehaviortreescriptapi("margwaShouldFreeze", &margwashouldfreeze);
  behaviortreenetworkutility::registerbehaviortreescriptapi("margwaShouldTeleportIn", &margwashouldteleportin);
  behaviortreenetworkutility::registerbehaviortreescriptapi("margwaShouldTeleportOut", &margwashouldteleportout);
  behaviortreenetworkutility::registerbehaviortreescriptapi("margwaShouldWait", &margwashouldwait);
  behaviortreenetworkutility::registerbehaviortreescriptapi("margwaShouldReset", &margwashouldreset);
  behaviortreenetworkutility::registerbehaviortreeaction("margwaReactStunAction", &margwareactstunaction, undefined, undefined);
  behaviortreenetworkutility::registerbehaviortreeaction("margwaSwipeAttackAction", &margwaswipeattackaction, &margwaswipeattackactionupdate, undefined);
  behaviortreenetworkutility::registerbehaviortreescriptapi("margwaIdleStart", &margwaidlestart);
  behaviortreenetworkutility::registerbehaviortreescriptapi("margwaMoveStart", &margwamovestart);
  behaviortreenetworkutility::registerbehaviortreescriptapi("margwaTraverseActionStart", &margwatraverseactionstart);
  behaviortreenetworkutility::registerbehaviortreescriptapi("margwaTeleportInStart", &margwateleportinstart);
  behaviortreenetworkutility::registerbehaviortreescriptapi("margwaTeleportInTerminate", &margwateleportinterminate);
  behaviortreenetworkutility::registerbehaviortreescriptapi("margwaTeleportOutStart", &margwateleportoutstart);
  behaviortreenetworkutility::registerbehaviortreescriptapi("margwaTeleportOutTerminate", &margwateleportoutterminate);
  behaviortreenetworkutility::registerbehaviortreescriptapi("margwaPainStart", &margwapainstart);
  behaviortreenetworkutility::registerbehaviortreescriptapi("margwaPainTerminate", &margwapainterminate);
  behaviortreenetworkutility::registerbehaviortreescriptapi("margwaReactStunStart", &margwareactstunstart);
  behaviortreenetworkutility::registerbehaviortreescriptapi("margwaReactStunTerminate", &margwareactstunterminate);
  behaviortreenetworkutility::registerbehaviortreescriptapi("margwaReactIDGunStart", &margwareactidgunstart);
  behaviortreenetworkutility::registerbehaviortreescriptapi("margwaReactIDGunTerminate", &margwareactidgunterminate);
  behaviortreenetworkutility::registerbehaviortreescriptapi("margwaReactSwordStart", &margwareactswordstart);
  behaviortreenetworkutility::registerbehaviortreescriptapi("margwaReactSwordTerminate", &margwareactswordterminate);
  behaviortreenetworkutility::registerbehaviortreescriptapi("margwaSpawnStart", &margwaspawnstart);
  behaviortreenetworkutility::registerbehaviortreescriptapi("margwaSmashAttackStart", &margwasmashattackstart);
  behaviortreenetworkutility::registerbehaviortreescriptapi("margwaSmashAttackTerminate", &margwasmashattackterminate);
  behaviortreenetworkutility::registerbehaviortreescriptapi("margwaSwipeAttackStart", &margwaswipeattackstart);
  behaviortreenetworkutility::registerbehaviortreescriptapi("margwaSwipeAttackTerminate", &margwaswipeattackterminate);
  animationstatenetwork::registeranimationmocomp("mocomp_teleport_traversal@margwa", &mocompmargwateleporttraversalinit, &mocompmargwateleporttraversalupdate, &mocompmargwateleporttraversalterminate);
  animationstatenetwork::registernotetrackhandlerfunction("margwa_smash_attack", &margwanotetracksmashattack);
  animationstatenetwork::registernotetrackhandlerfunction("margwa_bodyfall large", &margwanotetrackbodyfall);
  animationstatenetwork::registernotetrackhandlerfunction("margwa_melee_fire", &margwanotetrackpainmelee);
}

function private archetypemargwablackboardinit() {
  blackboard::createblackboardforentity(self);
  self aiutility::registerutilityblackboardattributes();
  blackboard::registerblackboardattribute(self, "_locomotion_speed", "locomotion_speed_walk", undefined);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_board_attack_spot", undefined, undefined);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_locomotion_should_turn", "should_not_turn", &bb_getshouldturn);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_zombie_damageweapon_type", "regular", undefined);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  self.___archetypeonanimscriptedcallback = &archetypemargwaonanimscriptedcallback;
  self finalizetrackedblackboardattributes();
}

function private archetypemargwaonanimscriptedcallback(entity) {
  entity.__blackboard = undefined;
  entity archetypemargwablackboardinit();
}

function private bb_getshouldturn() {
  if(isDefined(self.should_turn) && self.should_turn) {
    return "should_turn";
  }
  return "should_not_turn";
}

function private margwanotetracksmashattack(entity) {
  players = getplayers();
  foreach(player in players) {
    smashpos = entity.origin + vectorscale(anglesToForward(self.angles), 60);
    distsq = distancesquared(smashpos, player.origin);
    if(distsq < 20736) {
      if(!isgodmode(player)) {
        if(isDefined(player.hasriotshield) && player.hasriotshield) {
          damageshield = 0;
          attackdir = player.origin - self.origin;
          if(isDefined(player.hasriotshieldequipped) && player.hasriotshieldequipped) {
            if(player margwaserverutils::shieldfacing(attackdir, 0.2)) {
              damageshield = 1;
            }
          } else if(player margwaserverutils::shieldfacing(attackdir, 0.2, 0)) {
            damageshield = 1;
          }
          if(damageshield) {
            self clientfield::increment("margwa_smash");
            shield_damage = level.weaponriotshield.weaponstarthitpoints;
            if(isDefined(player.weaponriotshield)) {
              shield_damage = player.weaponriotshield.weaponstarthitpoints;
            }
            player[[player.player_shield_apply_damage]](shield_damage, 0);
            continue;
          }
        }
        if(isDefined(level.margwa_smash_damage_callback) && isfunctionptr(level.margwa_smash_damage_callback)) {
          if(player[[level.margwa_smash_damage_callback]](self)) {
            continue;
          }
        }
        self clientfield::increment("margwa_smash");
        player dodamage(166, self.origin, self);
      }
    }
  }
  if(isDefined(self.smashattackcb)) {
    self[[self.smashattackcb]]();
  }
}

function private margwanotetrackbodyfall(entity) {
  if(self.archetype == "margwa") {
    entity ghost();
    if(isDefined(self.bodyfallcb)) {
      self[[self.bodyfallcb]]();
    }
  }
}

function private margwanotetrackpainmelee(entity) {
  entity melee();
}

function private margwatargetservice(entity) {
  if(isDefined(entity.ignoreall) && entity.ignoreall) {
    return false;
  }
  player = zombie_utility::get_closest_valid_player(self.origin, self.ignore_player);
  if(!isDefined(player)) {
    if(isDefined(self.ignore_player)) {
      if(isDefined(level._should_skip_ignore_player_logic) && [
          [level._should_skip_ignore_player_logic]
        ]()) {
        return;
      }
      self.ignore_player = [];
    }
    self setgoal(self.origin);
    return false;
  }
  targetpos = getclosestpointonnavmesh(player.origin, 64, 30);
  if(isDefined(targetpos)) {
    entity setgoal(targetpos);
    return true;
  }
  entity setgoal(entity.origin);
  return false;
}

function margwashouldsmashattack(entity) {
  if(!isDefined(entity.enemy)) {
    return false;
  }
  if(!entity margwaserverutils::insmashattackrange(entity.enemy)) {
    return false;
  }
  yaw = abs(zombie_utility::getyawtoenemy());
  if(yaw > 45) {
    return false;
  }
  return true;
}

function margwashouldswipeattack(entity) {
  if(!isDefined(entity.enemy)) {
    return false;
  }
  if(distancesquared(entity.origin, entity.enemy.origin) > 16384) {
    return false;
  }
  yaw = abs(zombie_utility::getyawtoenemy());
  if(yaw > 45) {
    return false;
  }
  return true;
}

function private margwashouldshowpain(entity) {
  if(isDefined(entity.headdestroyed)) {
    headinfo = entity.head[entity.headdestroyed];
    switch (headinfo.cf) {
      case "margwa_head_left": {
        blackboard::setblackboardattribute(self, "_margwa_head", "left");
        break;
      }
      case "margwa_head_mid": {
        blackboard::setblackboardattribute(self, "_margwa_head", "middle");
        break;
      }
      case "margwa_head_right": {
        blackboard::setblackboardattribute(self, "_margwa_head", "right");
        break;
      }
    }
    return true;
  }
  return false;
}

function private margwashouldreactstun(entity) {
  if(isDefined(entity.reactstun) && entity.reactstun) {
    return true;
  }
  return false;
}

function private margwashouldreactidgun(entity) {
  if(isDefined(entity.reactidgun) && entity.reactidgun) {
    return true;
  }
  return false;
}

function private margwashouldreactsword(entity) {
  if(isDefined(entity.reactsword) && entity.reactsword) {
    return true;
  }
  return false;
}

function private margwashouldspawn(entity) {
  if(isDefined(entity.needspawn) && entity.needspawn) {
    return true;
  }
  return false;
}

function private margwashouldfreeze(entity) {
  if(isDefined(entity.isfrozen) && entity.isfrozen) {
    return true;
  }
  return false;
}

function private margwashouldteleportin(entity) {
  if(isDefined(entity.needteleportin) && entity.needteleportin) {
    return true;
  }
  return false;
}

function private margwashouldteleportout(entity) {
  if(isDefined(entity.needteleportout) && entity.needteleportout) {
    return true;
  }
  return false;
}

function private margwashouldwait(entity) {
  if(isDefined(entity.waiting) && entity.waiting) {
    return true;
  }
  return false;
}

function private margwashouldreset(entity) {
  if(isDefined(entity.headdestroyed)) {
    return true;
  }
  if(isDefined(entity.reactidgun) && entity.reactidgun) {
    return true;
  }
  if(isDefined(entity.reactsword) && entity.reactsword) {
    return true;
  }
  if(isDefined(entity.reactstun) && entity.reactstun) {
    return true;
  }
  return false;
}

function private margwareactstunaction(entity, asmstatename) {
  animationstatenetworkutility::requeststate(entity, asmstatename);
  stunactionast = entity astsearch(istring(asmstatename));
  stunactionanimation = animationstatenetworkutility::searchanimationmap(entity, stunactionast["animation"]);
  closetime = getanimlength(stunactionanimation) * 1000;
  entity margwaserverutils::margwacloseallheads(closetime);
  margwareactstunstart(entity);
  return 5;
}

function private margwaswipeattackaction(entity, asmstatename) {
  animationstatenetworkutility::requeststate(entity, asmstatename);
  if(!isDefined(entity.swipe_end_time)) {
    swipeactionast = entity astsearch(istring(asmstatename));
    swipeactionanimation = animationstatenetworkutility::searchanimationmap(entity, swipeactionast["animation"]);
    swipeactiontime = getanimlength(swipeactionanimation) * 1000;
    entity.swipe_end_time = gettime() + swipeactiontime;
  }
  return 5;
}

function private margwaswipeattackactionupdate(entity, asmstatename) {
  if(isDefined(entity.swipe_end_time) && gettime() > entity.swipe_end_time) {
    return 4;
  }
  return 5;
}

function private margwaidlestart(entity) {
  if(entity margwaserverutils::shouldupdatejaw()) {
    entity clientfield::set("margwa_jaw", 1);
  }
}

function private margwamovestart(entity) {
  if(entity margwaserverutils::shouldupdatejaw()) {
    if(entity.zombie_move_speed == "run") {
      entity clientfield::set("margwa_jaw", 13);
    } else {
      entity clientfield::set("margwa_jaw", 7);
    }
  }
}

function private margwadeathaction(entity) {}

function private margwatraverseactionstart(entity) {
  blackboard::setblackboardattribute(entity, "_traversal_type", entity.traversestartnode.animscript);
  if(isDefined(entity.traversestartnode.animscript)) {
    if(entity margwaserverutils::shouldupdatejaw()) {
      switch (entity.traversestartnode.animscript) {
        case "jump_down_36": {
          entity clientfield::set("margwa_jaw", 21);
          break;
        }
        case "jump_down_96": {
          entity clientfield::set("margwa_jaw", 22);
          break;
        }
        case "jump_up_36": {
          entity clientfield::set("margwa_jaw", 24);
          break;
        }
        case "jump_up_96": {
          entity clientfield::set("margwa_jaw", 25);
          break;
        }
      }
    }
  }
}

function private margwateleportinstart(entity) {
  entity unlink();
  if(isDefined(entity.teleportpos)) {
    entity forceteleport(entity.teleportpos);
  }
  entity show();
  entity pathmode("move allowed");
  entity.needteleportin = 0;
  blackboard::setblackboardattribute(self, "_margwa_teleport", "in");
  if(isDefined(self.traveler)) {
    self.traveler clientfield::set("margwa_fx_travel", 0);
  }
  self clientfield::increment("margwa_fx_in", 1);
  if(entity margwaserverutils::shouldupdatejaw()) {
    entity clientfield::set("margwa_jaw", 17);
  }
}

function margwateleportinterminate(entity) {
  if(isDefined(self.traveler)) {
    self.traveler clientfield::set("margwa_fx_travel", 0);
  }
  entity.isteleporting = 0;
}

function private margwateleportoutstart(entity) {
  entity.needteleportout = 0;
  entity.isteleporting = 1;
  entity.teleportstart = entity.origin;
  blackboard::setblackboardattribute(self, "_margwa_teleport", "out");
  self clientfield::increment("margwa_fx_out", 1);
  if(entity margwaserverutils::shouldupdatejaw()) {
    entity clientfield::set("margwa_jaw", 18);
  }
}

function private margwateleportoutterminate(entity) {
  if(isDefined(entity.traveler)) {
    entity.traveler.origin = entity gettagorigin("j_spine_1");
    entity.traveler clientfield::set("margwa_fx_travel", 1);
  }
  entity ghost();
  entity pathmode("dont move");
  if(isDefined(entity.traveler)) {
    entity linkto(entity.traveler);
  }
  if(isDefined(entity.margwawait)) {
    entity thread[[entity.margwawait]]();
  } else {
    entity thread margwaserverutils::margwawait();
  }
}

function private margwapainstart(entity) {
  entity notify("stop_head_update");
  if(entity margwaserverutils::shouldupdatejaw()) {
    head = blackboard::getblackboardattribute(self, "_margwa_head");
    switch (head) {
      case "left": {
        entity clientfield::set("margwa_jaw", 3);
        break;
      }
      case "middle": {
        entity clientfield::set("margwa_jaw", 4);
        break;
      }
      case "right": {
        entity clientfield::set("margwa_jaw", 5);
        break;
      }
    }
  }
  entity.headdestroyed = undefined;
  entity.canstun = 0;
  entity.candamage = 0;
}

function private margwapainterminate(entity) {
  entity.headdestroyed = undefined;
  entity.canstun = 1;
  entity.candamage = 1;
  entity margwaserverutils::margwacloseallheads(5000);
  entity clearpath();
  if(isDefined(entity.margwapainterminatecb)) {
    entity[[entity.margwapainterminatecb]]();
  }
}

function private margwareactstunstart(entity) {
  entity.reactstun = undefined;
  entity.canstun = 0;
  if(entity margwaserverutils::shouldupdatejaw()) {
    entity clientfield::set("margwa_jaw", 6);
  }
}

function margwareactstunterminate(entity) {
  entity.canstun = 1;
}

function private margwareactidgunstart(entity) {
  entity.reactidgun = undefined;
  entity.canstun = 0;
  ispacked = 0;
  if(blackboard::getblackboardattribute(entity, "_zombie_damageweapon_type") == "regular") {
    if(entity margwaserverutils::shouldupdatejaw()) {
      entity clientfield::set("margwa_jaw", 8);
    }
    entity margwaserverutils::margwacloseallheads(5000);
  } else {
    if(entity margwaserverutils::shouldupdatejaw()) {
      entity clientfield::set("margwa_jaw", 9);
    }
    entity margwaserverutils::margwacloseallheads(10000);
    ispacked = 1;
  }
  if(isDefined(entity.idgun_damage)) {
    entity[[entity.idgun_damage]](ispacked);
  }
}

function margwareactidgunterminate(entity) {
  entity.canstun = 1;
  blackboard::setblackboardattribute(entity, "_zombie_damageweapon_type", "regular");
}

function private margwareactswordstart(entity) {
  entity.reactsword = undefined;
  entity.canstun = 0;
  if(isDefined(entity.head_chopper)) {
    entity.head_chopper notify("react_sword");
  }
}

function private margwareactswordterminate(entity) {
  entity.canstun = 1;
}

function private margwaspawnstart(entity) {
  entity.needspawn = 0;
}

function private margwasmashattackstart(entity) {
  entity margwaserverutils::margwaheadsmash();
  if(entity margwaserverutils::shouldupdatejaw()) {
    entity clientfield::set("margwa_jaw", 14);
  }
}

function margwasmashattackterminate(entity) {
  entity margwaserverutils::margwacloseallheads();
}

function margwaswipeattackstart(entity) {
  if(entity margwaserverutils::shouldupdatejaw()) {
    entity clientfield::set("margwa_jaw", 16);
  }
}

function private margwaswipeattackterminate(entity) {
  entity margwaserverutils::margwacloseallheads();
}

function private mocompmargwateleporttraversalinit(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity orientmode("face angle", entity.angles[1]);
  entity animmode("normal");
  if(isDefined(entity.traverseendnode)) {
    entity.teleportstart = entity.origin;
    entity.teleportpos = entity.traverseendnode.origin;
    self clientfield::increment("margwa_fx_out", 1);
    if(isDefined(entity.traversestartnode)) {
      if(isDefined(entity.traversestartnode.speed)) {
        self.margwa_teleport_speed = entity.traversestartnode.speed;
      }
    }
  }
}

function private mocompmargwateleporttraversalupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {}

function private mocompmargwateleporttraversalterminate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  margwateleportoutterminate(entity);
}

#namespace margwaserverutils;

function private margwaspawnsetup() {
  self disableaimassist();
  self.disableammodrop = 1;
  self.no_gib = 1;
  self.ignore_nuke = 1;
  self.ignore_enemy_count = 1;
  self.ignore_round_robbin_death = 1;
  self.zombie_move_speed = "walk";
  self.overrideactordamage = &margwadamage;
  self.candamage = 1;
  self.headattached = 3;
  self.headopen = 0;
  self margwainithead("c_zom_margwa_chunks_le", "j_chunk_head_bone_le");
  self margwainithead("c_zom_margwa_chunks_mid", "j_chunk_head_bone");
  self margwainithead("c_zom_margwa_chunks_ri", "j_chunk_head_bone_ri");
  self.headhealthmax = 600;
  self margwadisablestun();
  self.traveler = spawn("script_model", self.origin);
  self.traveler setModel("tag_origin");
  self.traveler notsolid();
  self.travelertell = spawn("script_model", self.origin);
  self.travelertell setModel("tag_origin");
  self.travelertell notsolid();
  self thread margwadeath();
  self.updatesight = 0;
  self.ignorerunandgundist = 1;
}

function private margwadeath() {
  self waittill("death");
  if(isDefined(self.e_head_attacker)) {
    self.e_head_attacker notify("margwa_kill");
  }
  if(isDefined(self.traveler)) {
    self.traveler delete();
  }
  if(isDefined(self.travelertell)) {
    self.travelertell delete();
  }
}

function margwaenablestun() {
  self.canstun = 1;
}

function private margwadisablestun() {
  self.canstun = 0;
}

function private margwainithead(headmodel, headtag) {
  model = headmodel;
  model_gore = undefined;
  switch (headmodel) {
    case "c_zom_margwa_chunks_le": {
      if(isDefined(level.margwa_head_left_model_override)) {
        model = level.margwa_head_left_model_override;
        model_gore = level.margwa_gore_left_model_override;
      }
      break;
    }
    case "c_zom_margwa_chunks_mid": {
      if(isDefined(level.margwa_head_mid_model_override)) {
        model = level.margwa_head_mid_model_override;
        model_gore = level.margwa_gore_mid_model_override;
      }
      break;
    }
    case "c_zom_margwa_chunks_ri": {
      if(isDefined(level.margwa_head_right_model_override)) {
        model = level.margwa_head_right_model_override;
        model_gore = level.margwa_gore_right_model_override;
      }
      break;
    }
  }
  self attach(model);
  if(!isDefined(self.head)) {
    self.head = [];
  }
  self.head[model] = spawnStruct();
  self.head[model].model = model;
  self.head[model].tag = headtag;
  self.head[model].health = 600;
  self.head[model].candamage = 0;
  self.head[model].open = 1;
  self.head[model].closed = 2;
  self.head[model].smash = 3;
  switch (headmodel) {
    case "c_zom_margwa_chunks_le": {
      self.head[model].cf = "margwa_head_left";
      self.head[model].impactcf = "margwa_head_left_hit";
      self.head[model].gore = "c_zom_margwa_gore_le";
      if(isDefined(model_gore)) {
        self.head[model].gore = model_gore;
      }
      self.head[model].killindex = 1;
      self.head_left_model = model;
      break;
    }
    case "c_zom_margwa_chunks_mid": {
      self.head[model].cf = "margwa_head_mid";
      self.head[model].impactcf = "margwa_head_mid_hit";
      self.head[model].gore = "c_zom_margwa_gore_mid";
      if(isDefined(model_gore)) {
        self.head[model].gore = model_gore;
      }
      self.head[model].killindex = 2;
      self.head_mid_model = model;
      break;
    }
    case "c_zom_margwa_chunks_ri": {
      self.head[model].cf = "margwa_head_right";
      self.head[model].impactcf = "margwa_head_right_hit";
      self.head[model].gore = "c_zom_margwa_gore_ri";
      if(isDefined(model_gore)) {
        self.head[model].gore = model_gore;
      }
      self.head[model].killindex = 3;
      self.head_right_model = model;
      break;
    }
  }
  self thread margwaheadupdate(self.head[model]);
}

function margwasetheadhealth(health) {
  self.headhealthmax = health;
  foreach(head in self.head) {
    head.health = health;
  }
}

function private margwaresetheadtime(min, max) {
  time = gettime() + randomintrange(min, max);
  return time;
}

function private margwaheadcanopen() {
  if(self.headattached > 1) {
    if(self.headopen < (self.headattached - 1)) {
      return true;
    }
  } else {
    return true;
  }
  return false;
}

function private margwaheadupdate(headinfo) {
  self endon("death");
  self endon("stop_head_update");
  headinfo notify("stop_head_update");
  headinfo endon("stop_head_update");
  while(true) {
    if(self ispaused()) {
      util::wait_network_frame();
      continue;
    }
    if(!isDefined(headinfo.closetime)) {
      if(self.headattached == 1) {
        headinfo.closetime = margwaresetheadtime(500, 1000);
      } else {
        headinfo.closetime = margwaresetheadtime(1500, 3500);
      }
    }
    if(gettime() > headinfo.closetime && self margwaheadcanopen()) {
      self.headopen++;
      headinfo.closetime = undefined;
    } else {
      util::wait_network_frame();
      continue;
    }
    self margwaheaddamagedelay(headinfo, 1);
    self clientfield::set(headinfo.cf, headinfo.open);
    self playsoundontag("zmb_vocals_margwa_ambient", headinfo.tag);
    while(true) {
      if(!isDefined(headinfo.opentime)) {
        headinfo.opentime = margwaresetheadtime(3000, 5000);
      }
      if(gettime() > headinfo.opentime) {
        self.headopen--;
        headinfo.opentime = undefined;
        break;
      } else {
        util::wait_network_frame();
        continue;
      }
    }
    self margwaheaddamagedelay(headinfo, 0);
    self clientfield::set(headinfo.cf, headinfo.closed);
  }
}

function private margwaheaddamagedelay(headinfo, candamage) {
  self endon("death");
  wait(0.1);
  headinfo.candamage = candamage;
}

function private margwaheadsmash() {
  self notify("stop_head_update");
  headalive = [];
  foreach(head in self.head) {
    if(head.health > 0) {
      headalive[headalive.size] = head;
    }
  }
  headalive = array::randomize(headalive);
  open = 0;
  foreach(head in headalive) {
    if(!open) {
      head.candamage = 1;
      self clientfield::set(head.cf, head.smash);
      open = 1;
      continue;
    }
    self margwaclosehead(head);
  }
}

function private margwaclosehead(headinfo) {
  headinfo.candamage = 0;
  self clientfield::set(headinfo.cf, headinfo.closed);
}

function private margwacloseallheads(closetime) {
  if(self ispaused()) {
    return;
  }
  foreach(head in self.head) {
    if(head.health > 0) {
      head.closetime = undefined;
      head.opentime = undefined;
      if(isDefined(closetime)) {
        head.closetime = gettime() + closetime;
      }
      self.headopen = 0;
      self margwaclosehead(head);
      self thread margwaheadupdate(head);
    }
  }
}

function margwakillhead(modelhit, attacker) {
  headinfo = self.head[modelhit];
  headinfo.health = 0;
  headinfo notify("stop_head_update");
  if(isDefined(headinfo.candamage) && headinfo.candamage) {
    self margwaclosehead(headinfo);
    self.headopen--;
  }
  self margwaupdatemovespeed();
  if(isDefined(self.destroyheadcb)) {
    self thread[[self.destroyheadcb]](modelhit, attacker);
  }
  self clientfield::set("margwa_head_killed", headinfo.killindex);
  self detach(headinfo.model);
  self attach(headinfo.gore);
  self.headattached--;
  if(self.headattached <= 0) {
    self.e_head_attacker = attacker;
    return true;
  }
  self.headdestroyed = modelhit;
  return false;
}

function margwacandamageanyhead() {
  foreach(head in self.head) {
    if(isDefined(head) && head.health > 0 && (isDefined(head.candamage) && head.candamage)) {
      return true;
    }
  }
  return false;
}

function margwacandamagehead() {
  if(isDefined(self) && self.health > 0 && (isDefined(self.candamage) && self.candamage)) {
    return true;
  }
  return false;
}

function show_hit_marker() {
  if(isDefined(self) && isDefined(self.hud_damagefeedback)) {
    self.hud_damagefeedback setshader("damage_feedback", 24, 48);
    self.hud_damagefeedback.alpha = 1;
    self.hud_damagefeedback fadeovertime(1);
    self.hud_damagefeedback.alpha = 0;
  }
}

function private isdirecthitweapon(weapon) {
  foreach(dhweapon in level.dhweapons) {
    if(weapon.name == dhweapon) {
      return true;
    }
    if(isDefined(weapon.rootweapon) && isDefined(weapon.rootweapon.name) && weapon.rootweapon.name == dhweapon) {
      return true;
    }
  }
  return false;
}

function margwadamage(inflictor, attacker, damage, dflags, mod, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
  if(isDefined(self.is_kill) && self.is_kill) {
    return damage;
  }
  if(isDefined(attacker) && isDefined(attacker.n_margwa_head_damage_scale)) {
    damage = damage * attacker.n_margwa_head_damage_scale;
  }
  if(isDefined(level._margwa_damage_cb)) {
    n_result = [[level._margwa_damage_cb]](inflictor, attacker, damage, dflags, mod, weapon, point, dir, hitloc, offsettime, boneindex, modelindex);
    if(isDefined(n_result)) {
      return n_result;
    }
  }
  damageopen = 0;
  if(!(isDefined(self.candamage) && self.candamage)) {
    self.health = self.health + 1;
    return 1;
  }
  if(isdirecthitweapon(weapon)) {
    headalive = [];
    foreach(head in self.head) {
      if(head margwacandamagehead()) {
        headalive[headalive.size] = head;
      }
    }
    if(headalive.size > 0) {
      max = 100000;
      headclosest = undefined;
      foreach(head in headalive) {
        distsq = distancesquared(point, self gettagorigin(head.tag));
        if(distsq < max) {
          max = distsq;
          headclosest = head;
        }
      }
      if(isDefined(headclosest)) {
        if(max < 576) {
          if(isDefined(level.margwa_damage_override_callback) && isfunctionptr(level.margwa_damage_override_callback)) {
            damage = attacker[[level.margwa_damage_override_callback]](damage);
          }
          headclosest.health = headclosest.health - damage;
          damageopen = 1;
          self clientfield::increment(headclosest.impactcf);
          attacker show_hit_marker();
          if(headclosest.health <= 0) {
            if(isDefined(level.margwa_head_kill_weapon_check)) {
              [
                [level.margwa_head_kill_weapon_check]
              ](self, weapon);
            }
            if(self margwakillhead(headclosest.model, attacker)) {
              return self.health;
            }
          }
        }
      }
    }
  }
  partname = getpartname(self.model, boneindex);
  if(isDefined(partname)) {
    if(isDefined(self.debughitloc) && self.debughitloc) {
      printtoprightln((partname + "") + damage);
    }
    modelhit = self margwaheadhit(self, partname);
    if(isDefined(modelhit)) {
      headinfo = self.head[modelhit];
      if(headinfo margwacandamagehead()) {
        if(isDefined(level.margwa_damage_override_callback) && isfunctionptr(level.margwa_damage_override_callback)) {
          damage = attacker[[level.margwa_damage_override_callback]](damage);
        }
        if(isDefined(attacker)) {
          attacker notify("margwa_headshot", self);
        }
        headinfo.health = headinfo.health - damage;
        damageopen = 1;
        self clientfield::increment(headinfo.impactcf);
        attacker show_hit_marker();
        if(headinfo.health <= 0) {
          if(isDefined(level.margwa_head_kill_weapon_check)) {
            [
              [level.margwa_head_kill_weapon_check]
            ](self, weapon);
          }
          if(self margwakillhead(modelhit, attacker)) {
            return self.health;
          }
        }
      }
    }
  }
  if(damageopen) {
    return 0;
  }
  self.health = self.health + 1;
  return 1;
}

function private margwaheadhit(entity, partname) {
  switch (partname) {
    case "j_chunk_head_bone_le":
    case "j_jaw_lower_1_le": {
      return self.head_left_model;
    }
    case "j_chunk_head_bone":
    case "j_jaw_lower_1": {
      return self.head_mid_model;
    }
    case "j_chunk_head_bone_ri":
    case "j_jaw_lower_1_ri": {
      return self.head_right_model;
    }
  }
  return undefined;
}

function private margwaupdatemovespeed() {
  if(self.zombie_move_speed == "walk") {
    self.zombie_move_speed = "run";
    blackboard::setblackboardattribute(self, "_locomotion_speed", "locomotion_speed_run");
  } else if(self.zombie_move_speed == "run") {
    self.zombie_move_speed = "sprint";
    blackboard::setblackboardattribute(self, "_locomotion_speed", "locomotion_speed_sprint");
  }
}

function margwaforcesprint() {
  self.zombie_move_speed = "sprint";
  blackboard::setblackboardattribute(self, "_locomotion_speed", "locomotion_speed_sprint");
}

function private margwadestroyhead(modelhit) {}

function shouldupdatejaw() {
  if(!(isDefined(self.jawanimenabled) && self.jawanimenabled)) {
    return false;
  }
  if(self.headattached < 3) {
    return true;
  }
  return false;
}

function margwasetgoal(origin, radius, boundarydist) {
  pos = getclosestpointonnavmesh(origin, 64, 30);
  if(isDefined(pos)) {
    self setgoal(pos);
    return true;
  }
  self setgoal(self.origin);
  return false;
}

function private margwawait() {
  self endon("death");
  self.waiting = 1;
  self.needteleportin = 1;
  destpos = self.teleportpos + vectorscale((0, 0, 1), 60);
  dist = distance(self.teleportstart, destpos);
  time = dist / 600;
  if(isDefined(self.margwa_teleport_speed)) {
    if(self.margwa_teleport_speed > 0) {
      time = dist / self.margwa_teleport_speed;
    }
  }
  if(isDefined(self.traveler)) {
    self thread margwatell();
    self.traveler moveto(destpos, time);
    self.traveler util::waittill_any_ex(time + 0.1, "movedone", self, "death");
    self.travelertell clientfield::set("margwa_fx_travel_tell", 0);
  }
  self.waiting = 0;
  self.needteleportout = 0;
  if(isDefined(self.margwa_teleport_speed)) {
    self.margwa_teleport_speed = undefined;
  }
}

function margwatell() {
  self endon("death");
  self.travelertell.origin = self.teleportpos;
  util::wait_network_frame();
  self.travelertell clientfield::set("margwa_fx_travel_tell", 1);
}

function private shieldfacing(vdir, limit, front = 1) {
  orientation = self getplayerangles();
  forwardvec = anglesToForward(orientation);
  if(!front) {
    forwardvec = forwardvec * -1;
  }
  forwardvec2d = (forwardvec[0], forwardvec[1], 0);
  unitforwardvec2d = vectornormalize(forwardvec2d);
  tofaceevec = vdir * -1;
  tofaceevec2d = (tofaceevec[0], tofaceevec[1], 0);
  unittofaceevec2d = vectornormalize(tofaceevec2d);
  dotproduct = vectordot(unitforwardvec2d, unittofaceevec2d);
  return dotproduct > limit;
}

function private insmashattackrange(enemy) {
  smashpos = self.origin;
  heightoffset = abs(self.origin[2] - enemy.origin[2]);
  if(heightoffset > 48) {
    return false;
  }
  distsq = distancesquared(smashpos, enemy.origin);
  range = 25600;
  if(distsq < range) {
    return true;
  }
  return false;
}