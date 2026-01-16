/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\riotshield.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\scoreevents_shared;
#include scripts\core_common\util_shared;
#include scripts\weapons\weapons;

#namespace riotshield;

init_shared() {
  if(!isDefined(level.weaponriotshield)) {
    level.weaponriotshield = getweapon(#"riotshield");
  }

  level.deployedshieldmodel = #"wpn_t7_shield_riot_world";
  level.stowedshieldmodel = #"wpn_t7_shield_riot_world";
  level.carriedshieldmodel = #"wpn_t7_shield_riot_world";
  level.detectshieldmodel = #"wpn_t7_shield_riot_world";
  level.riotshielddestroyanim = "o_riot_stand_destroyed";
  level.riotshielddeployanim = "o_riot_stand_deploy";
  level.riotshieldshotanimfront = "o_riot_stand_shot";
  level.riotshieldshotanimback = "o_riot_stand_shot_back";
  level.riotshieldmeleeanimfront = "o_riot_stand_melee_front";
  level.riotshieldmeleeanimback = "o_riot_stand_melee_back";
  level.riotshield_placement_zoffset = 26;
  thread register();
  callback::on_spawned(&on_player_spawned);
}

register() {
  clientfield::register("scriptmover", "riotshield_state", 1, 2, "int");
}

watchpregameclasschange() {
  self endon(#"death", #"disconnect", #"track_riot_shield");
  self waittill(#"changed_class");

  if(level.ingraceperiod && !self.hasdonecombat) {
    self clearstowedweapon();
    self refreshshieldattachment();
    self thread trackriotshield();
  }
}

watchriotshieldpickup() {
  self endon(#"death", #"disconnect", #"track_riot_shield");
  self notify(#"watch_riotshield_pickup");
  self endon(#"watch_riotshield_pickup");
  self waittill(#"pickup_riotshield");
  self endon(#"weapon_change");
  println("<dev string:x38>");
  wait 0.5;
  println("<dev string:x72>");
  currentweapon = self getcurrentweapon();
  self.hasriotshield = self hasriotshield();
  self.hasriotshieldequipped = currentweapon.isriotshield;
  self refreshshieldattachment();
}

trackriotshield() {
  self endon(#"death", #"disconnect");
  self notify(#"track_riot_shield");
  self endon(#"track_riot_shield");
  self thread watchpregameclasschange();
  self waittill(#"weapon_change");
  self refreshshieldattachment();
  currentweapon = self getcurrentweapon();
  self.hasriotshield = self hasriotshield();
  self.hasriotshieldequipped = currentweapon.isriotshield;
  self.lastnonshieldweapon = level.weaponnone;

  while(true) {
    self thread watchriotshieldpickup();
    currentweapon = self getcurrentweapon();
    currentweapon = self getcurrentweapon();
    self.hasriotshield = self hasriotshield();
    self.hasriotshieldequipped = currentweapon.isriotshield;
    refresh_attach = 0;
    waitresult = self waittill(#"weapon_change");

    if(waitresult.weapon.isriotshield) {
      refresh_attach = 1;

      if(isDefined(self.riotshieldentity)) {
        self notify(#"destroy_riotshield");
      }

      if(self.hasriotshield) {
        if(isDefined(self.riotshieldtakeweapon)) {
          self takeweapon(self.riotshieldtakeweapon);
          self.riotshieldtakeweapon = undefined;
        }
      }

      if(isvalidnonshieldweapon(currentweapon)) {
        self.lastnonshieldweapon = currentweapon;
      }
    }

    if(self.hasriotshield || refresh_attach == 1) {
      self refreshshieldattachment();
    }
  }
}

isvalidnonshieldweapon(weapon) {
  if(!weapons::may_drop(weapon)) {
    return false;
  }

  return true;
}

startriotshielddeploy() {
  self notify(#"start_riotshield_deploy");
  self thread watchriotshielddeploy();
}

resetreconmodelvisibility(owner) {
  if(!isDefined(self)) {
    return;
  }

  self setinvisibletoall();
  self setforcenocull();

  if(!isDefined(owner)) {
    return;
  }

  for(i = 0; i < level.players.size; i++) {
    if(level.players[i] hasperk(#"specialty_showenemyequipment")) {
      if(level.players[i].team == #"spectator") {
        continue;
      }

      isenemy = 1;

      if(level.teambased) {
        if(!level.players[i] util::isenemyteam(owner.team)) {
          isenemy = 0;
        }
      } else if(level.players[i] == owner) {
        isenemy = 0;
      }

      if(isenemy) {
        self setvisibletoplayer(level.players[i]);
      }
    }
  }
}

resetreconmodelonevent(eventname, owner) {
  self endon(#"death");

  for(;;) {
    waitresult = level waittill(eventname);

    if(isDefined(waitresult.player)) {
      owner = waitresult.player;
    }

    self resetreconmodelvisibility(owner);
  }
}

attachreconmodel(modelname, owner) {
  if(!isDefined(self)) {
    return;
  }

  reconmodel = spawn("script_model", self.origin);
  reconmodel.angles = self.angles;
  reconmodel setModel(modelname);
  reconmodel.model_name = modelname;
  reconmodel linkto(self);
  reconmodel setcontents(0);
  reconmodel resetreconmodelvisibility(owner);
  reconmodel thread resetreconmodelonevent("joined_team", owner);
  reconmodel thread resetreconmodelonevent("player_spawned", owner);
  self.reconmodel = reconmodel;
}

spawnriotshieldcover(origin, angles) {
  shield_ent = spawn("script_model", origin, 1);
  shield_ent.targetname = "riotshield_mp";
  shield_ent.angles = angles;
  shield_ent setModel(level.deployedshieldmodel);
  shield_ent setowner(self);
  shield_ent.owner = self;
  shield_ent.team = self.team;
  shield_ent setteam(self.team);
  shield_ent attachreconmodel(level.detectshieldmodel, self);
  shield_ent useanimtree("generic");
  shield_ent setscriptmoverflag(0);
  shield_ent disconnectpaths();
  return shield_ent;
}

watchriotshielddeploy() {
  self endon(#"death", #"disconnect", #"start_riotshield_deploy");
  waitresult = self waittill(#"deploy_riotshield");
  deploy_attempt = waitresult.is_deploy_attempt;
  weapon = waitresult.weapon;
  self setplacementhint(1);
  placement_hint = 0;

  if(deploy_attempt) {
    placement = self canplaceriotshield("deploy_riotshield");

    if(placement[#"result"]) {
      self.hasdonecombat = 1;
      zoffset = level.riotshield_placement_zoffset;
      shield_ent = self spawnriotshieldcover(placement[#"origin"] + (0, 0, zoffset), placement[#"angles"]);
      item_ent = deployriotshield(self, shield_ent);
      primaries = self getweaponslistprimaries();

      assert(isDefined(item_ent));
      assert(!isDefined(self.riotshieldretrievetrigger));
      assert(!isDefined(self.riotshieldentity));

      if(level.gametype != "<dev string:xab>") {
        assert(primaries.size > 0);
      }

        shield_ent clientfield::set("riotshield_state", 1);
      shield_ent.reconmodel clientfield::set("riotshield_state", 1);

      if(level.gametype != "shrp") {
        self weapons::function_d571ac59(self.lastnonshieldweapon);
      }

      if(!self hasweapon(level.weaponbasemeleeheld)) {
        self giveweapon(level.weaponbasemeleeheld);
        self.riotshieldtakeweapon = level.weaponbasemeleeheld;
      }

      self.riotshieldretrievetrigger = item_ent;
      self.riotshieldentity = shield_ent;
      self thread watchdeployedriotshieldents();
      self thread deleteshieldontriggerdeath(self.riotshieldretrievetrigger);
      self thread deleteshieldonplayerdeathordisconnect(shield_ent);
      self.riotshieldentity thread watchdeployedriotshielddamage();
      level notify(#"riotshield_planted", {
        #player: self
      });
    } else {
      placement_hint = 1;
      clip_max_ammo = weapon.clipsize;
      self setweaponammoclip(weapon, clip_max_ammo);
    }
  } else {
    placement_hint = 1;
  }

  if(placement_hint) {
    self setriotshieldfailhint();
  }
}

riotshielddistancetest(origin) {
  assert(isDefined(origin));
  min_dist_squared = getdvarfloat(#"riotshield_deploy_limit_radius", 0);
  min_dist_squared *= min_dist_squared;

  for(i = 0; i < level.players.size; i++) {
    if(isDefined(level.players[i].riotshieldentity)) {
      dist_squared = distancesquared(level.players[i].riotshieldentity.origin, origin);

      if(min_dist_squared > dist_squared) {
        println("<dev string:xb2>");
        return false;
      }
    }
  }

  return true;
}

watchdeployedriotshieldents() {

  assert(isDefined(self.riotshieldretrievetrigger));
  assert(isDefined(self.riotshieldentity));

    self waittill(#"destroy_riotshield");

  if(isDefined(self.riotshieldretrievetrigger)) {
    self.riotshieldretrievetrigger delete();
  }

  if(isDefined(self.riotshieldentity)) {
    if(isDefined(self.riotshieldentity.reconmodel)) {
      self.riotshieldentity.reconmodel delete();
    }

    self.riotshieldentity connectpaths();
    self.riotshieldentity delete();
  }
}

watchdeployedriotshielddamage() {
  self endon(#"death");
  damagemax = getdvarint(#"riotshield_deployed_health", 0);
  self.damagetaken = 0;

  while(true) {
    self.maxhealth = 100000;
    self.health = self.maxhealth;
    waitresult = self waittill(#"damage");
    attacker = waitresult.attacker;
    damage = waitresult.amount;
    weapon = waitresult.weapon;
    type = waitresult.mod;

    if(!isDefined(attacker)) {
      continue;
    }

    assert(isDefined(self.owner) && isDefined(self.owner.team));

    if(isplayer(attacker)) {
      if(level.teambased && !util::function_fbce7263(attacker.team, self.owner.team) && attacker != self.owner) {
        continue;
      }
    }

    if(type == "MOD_MELEE" || type == "MOD_MELEE_ASSASSINATE") {
      damage *= getdvarfloat(#"riotshield_melee_damage_scale", 0);
    } else if(type == "MOD_PISTOL_BULLET" || type == "MOD_RIFLE_BULLET") {
      damage *= getdvarfloat(#"riotshield_bullet_damage_scale", 0);
    } else if(type == "MOD_GRENADE" || type == "MOD_GRENADE_SPLASH" || type == "MOD_EXPLOSIVE" || type == "MOD_EXPLOSIVE_SPLASH" || type == "MOD_PROJECTILE" || type == "MOD_PROJECTILE_SPLASH") {
      damage *= getdvarfloat(#"riotshield_explosive_damage_scale", 0);
    } else if(type == "MOD_IMPACT") {
      damage *= getdvarfloat(#"riotshield_projectile_damage_scale", 0);
    } else if(type == "MOD_CRUSH") {
      damage = damagemax;
    }

    self.damagetaken += damage;

    if(self.damagetaken >= damagemax) {
      self thread damagethendestroyriotshield(attacker, weapon);
      break;
    }
  }
}

damagethendestroyriotshield(attacker, weapon) {
  self notify(#"damagethendestroyriotshield");
  self endon(#"death");

  if(isDefined(self.owner.riotshieldretrievetrigger)) {
    self.owner.riotshieldretrievetrigger delete();
  }

  if(isDefined(self.reconmodel)) {
    self.reconmodel delete();
  }

  self connectpaths();
  self.owner.riotshieldentity = undefined;
  self notsolid();
  self clientfield::set("riotshield_state", 2);

  if(isDefined(attacker) && attacker != self.owner && isplayer(attacker)) {
    scoreevents::processscoreevent(#"destroyed_shield", attacker, self.owner, weapon);
  }

  wait getdvarfloat(#"riotshield_destroyed_cleanup_time", 0);
  self delete();
}

deleteshieldontriggerdeath(shield_trigger) {
  shield_trigger waittill(#"trigger", #"death");
  self notify(#"destroy_riotshield");
}

deleteshieldonplayerdeathordisconnect(shield_ent) {
  shield_ent endon(#"death", #"damagethendestroyriotshield");
  self waittill(#"death", #"disconnect", #"remove_planted_weapons");
  shield_ent thread damagethendestroyriotshield();
}

watchriotshieldstuckentitydeath(grenade, owner) {
  grenade endon(#"death");
  self waittill(#"damagethendestroyriotshield", #"death", #"disconnect", #"weapon_change", #"deploy_riotshield");
  grenade detonate(owner);
}

on_player_spawned() {
  self thread watch_riot_shield_use();
}

watch_riot_shield_use() {
  self endon(#"death", #"disconnect");
  self thread trackriotshield();

  for(;;) {
    self waittill(#"raise_riotshield");
    self thread startriotshielddeploy();
  }
}

event_handler[grenade_fire] function_4f975761(eventstruct) {
  if(!isplayer(self)) {
    return;
  }

  grenade = eventstruct.projectile;
  weapon = eventstruct.weapon;

  if(grenade util::ishacked()) {
    return;
  }

  switch (weapon.name) {
    case #"explosive_bolt":
    case #"proximity_grenade":
    case #"sticky_grenade":
      grenade thread check_stuck_to_shield();
      break;
  }
}

check_stuck_to_shield() {
  self endon(#"death");
  waitresult = self waittill(#"stuck_to_shield");
  waitresult.entity watchriotshieldstuckentitydeath(self, waitresult.owner);
}