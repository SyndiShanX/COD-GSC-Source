/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_riotshield.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;

init() {
  level.deployedshieldmodel = "t6_wpn_shield_carry_world";
  level.stowedshieldmodel = "t6_wpn_shield_stow_world";
  level.carriedshieldmodel = "t6_wpn_shield_carry_world";
  precachemodel(level.deployedshieldmodel);
  precachemodel(level.stowedshieldmodel);
  precachemodel(level.carriedshieldmodel);
  level.riotshield_placement_zoffset = 26;
  level._effect["riotshield_light"] = loadfx("weapon/riotshield/fx_riotshield_depoly_lights");
  level._effect["riotshield_dust"] = loadfx("weapon/riotshield/fx_riotshield_depoly_dust");
}

trackriotshield() {
  self endon("death");
  self endon("disconnect");
  self.hasriotshield = self hasweapon("riotshield_sp");
  self.hasriotshieldequipped = self getcurrentweapon() == "riotshield_sp";

  if(self.hasriotshield) {
    if(self.hasriotshieldequipped)
      self attachshieldmodel(level.carriedshieldmodel, "tag_weapon_left");
    else
      self attachshieldmodel(level.stowedshieldmodel, "tag_stowed_back");
  }

  for(;;) {
    self waittill("weapon_change", newweapon);

    if(newweapon == "riotshield_sp") {
      if(self.hasriotshieldequipped) {
        continue;
      }
      if(isDefined(self.riotshieldentity))
        self notify("destroy_riotshield");

      if(self.hasriotshield) {
        self detachshieldmodel(level.stowedshieldmodel, "tag_stowed_back");
        self attachshieldmodel(level.carriedshieldmodel, "tag_weapon_left");
      } else
        self attachshieldmodel(level.carriedshieldmodel, "tag_weapon_left");

      self.hasriotshield = 1;
      self.hasriotshieldequipped = 1;
      continue;
    }

    if(self ismantling() && newweapon == "none") {
      continue;
    }
    if(self.hasriotshieldequipped) {
      assert(self.hasriotshield);
      self.hasriotshield = self hasweapon("riotshield_sp");

      if(self.hasriotshield) {
        self detachshieldmodel(level.carriedshieldmodel, "tag_weapon_left");
        self attachshieldmodel(level.stowedshieldmodel, "tag_stowed_back");
      } else
        self detachshieldmodel(level.carriedshieldmodel, "tag_weapon_left");

      self.hasriotshieldequipped = 0;
      continue;
    }

    if(self.hasriotshield) {
      if(!self hasweapon("riotshield_sp")) {
        self detachshieldmodel(level.stowedshieldmodel, "tag_stowed_back");
        self.hasriotshield = 0;
      }
    }
  }
}

startriotshielddeploy() {
  self notify("start_riotshield_deploy");
  self thread watchriotshielddeploy();
}

spawnriotshieldcover(origin, angles) {
  shield_ent = spawn("script_model", origin, 1);
  shield_ent.angles = angles;
  shield_ent setmodel(level.deployedshieldmodel);
  shield_ent setowner(self);
  shield_ent.owner = self;
  shield_ent setscriptmoverflag(0);
  return shield_ent;
}

#using_animtree("mp_riotshield");

riotshielddeployanim() {
  self useanimtree(#animtree);
  self setanim( % o_riot_stand_deploy, 1.0, 0.0, 1.0);
  playfxontag(level._effect["riotshield_dust"], self, "tag_origin");
  wait 0.8;
  self.shieldlightfx = playfxontag(level._effect["riotshield_light"], self, "tag_fx");
}

watchriotshielddeploy() {
  self endon("death");
  self endon("disconnect");
  self endon("start_riotshield_deploy");
  self waittill("deploy_riotshield", deploy_attempt);
  self setheldweaponmodel(0);
  self setplacementhint(1);
  placement_hint = 0;

  if(deploy_attempt) {
    placement = self canplaceriotshield("deploy_riotshield");

    if(placement["result"] && riotshielddistancetest(placement["origin"])) {
      zoffset = level.riotshield_placement_zoffset;
      shield_ent = self spawnriotshieldcover(placement["origin"] + (0, 0, zoffset), placement["angles"]);
      shield_ent thread riotshielddeployanim();
      item_ent = deployriotshield(self, shield_ent);
      primaries = self getweaponslistprimaries();

      assert(isDefined(item_ent));
      assert(!isDefined(self.riotshieldretrievetrigger));
      assert(!isDefined(self.riotshieldentity));
      assert(primaries.size > 0);

      self switchtoweapon(primaries[0]);
      self.riotshieldretrievetrigger = item_ent;
      self.riotshieldentity = shield_ent;
      self.riotshieldentity disconnectpaths();
      self thread watchdeployedriotshieldents();
      self thread deleteshieldondamage(self.riotshieldentity);
      self thread deleteshieldmodelonweaponpickup(self.riotshieldretrievetrigger);
      self thread deleteriotshieldonplayerdeath();
      self.riotshieldentity thread watchdeployedriotshielddamage();
    } else {
      placement_hint = 1;
      clip_max_ammo = weaponclipsize("riotshield_sp");
      self setweaponammoclip("riotshield_sp", clip_max_ammo);
    }
  } else
    placement_hint = 1;

  if(placement_hint)
    self setriotshieldfailhint();
}

riotshielddistancetest(origin) {
  assert(isDefined(origin));
  min_dist_squared = getdvarfloat(#"riotshield_deploy_limit_radius");
  min_dist_squared = min_dist_squared * min_dist_squared;
  players = get_players();

  for(i = 0; i < players.size; i++) {
    if(isDefined(players[i].riotshieldentity)) {
      dist_squared = distancesquared(players[i].riotshieldentity.origin, origin);

      if(min_dist_squared > dist_squared) {
        println("Shield placement denied!Failed distance check to other riotshields.");

        return false;
      }
    }
  }

  return true;
}

watchdeployedriotshieldents() {
  assert(isDefined(self.riotshieldretrievetrigger));
  assert(isDefined(self.riotshieldentity));

  self waittill("destroy_riotshield");

  if(isDefined(self.riotshieldretrievetrigger))
    self.riotshieldretrievetrigger delete();

  self.riotshieldentity connectpaths();

  if(isDefined(self.riotshieldentity))
    self.riotshieldentity delete();
}

watchdeployedriotshielddamage() {
  self endon("death");
  damagemax = getdvarint(#"riotshield_deployed_health");
  self.damagetaken = 0;

  while(true) {
    self.maxhealth = 100000;
    self.health = self.maxhealth;
    self waittill("damage", damage, attacker, direction, point, type);
    self useanimtree(#animtree);

    if(type == "MOD_MELEE")
      self setanimknobrestart( % o_riot_stand_melee_front, 1.0, 0.0, 1.0);
    else
      self setanimknobrestart( % o_riot_stand_shot, 1.0, 0.0, 1.0);

    if(!isDefined(attacker) || !isplayer(attacker)) {
      continue;
    }
    assert(isDefined(self.owner) && isDefined(self.owner.team));

    if(type == "MOD_MELEE")
      damage = damage * getdvarfloat(#"riotshield_melee_damage_scale");
    else if(type == "MOD_PISTOL_BULLET" || type == "MOD_RIFLE_BULLET")
      damage = damage * getdvarfloat(#"riotshield_bullet_damage_scale");
    else if(type == "MOD_GRENADE" || type == "MOD_GRENADE_SPLASH" || type == "MOD_EXPLOSIVE" || type == "MOD_EXPLOSIVE_SPLASH" || type == "MOD_PROJECTILE" || type == "MOD_PROJECTILE_SPLASH")
      damage = damage * getdvarfloat(#"riotshield_explosive_damage_scale");
    else if(type == "MOD_IMPACT")
      damage = damage * getdvarfloat(#"riotshield_projectile_damage_scale");

    self.damagetaken = self.damagetaken + damage;

    if(self.damagetaken >= damagemax)
      self damagethendestroyriotshield();
  }
}

damagethendestroyriotshield() {
  self endon("death");
  self.owner.riotshieldretrievetrigger delete();
  self notsolid();
  self setanimknoball( % o_riot_stand_destroyed, % root, 1.0, 0.0, 1.0);
  wait(getdvarfloat(#"riotshield_destroyed_cleanup_time"));
  self.owner notify("destroy_riotshield");
}

deleteshieldondamage(shield_ent) {
  shield_ent waittill("death", attacker);
}

deleteshieldmodelonweaponpickup(shield_trigger) {
  shield_trigger waittill("trigger");
  self notify("destroy_riotshield");
}

deleteriotshieldonplayerdeath() {
  self.riotshieldentity endon("death");
  self waittill("death");
  self notify("destroy_riotshield");
}