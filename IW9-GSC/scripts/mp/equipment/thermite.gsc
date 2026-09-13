/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\thermite.gsc
***********************************************/

thermite_used(grenade, _id_E012E0B70D7D54FA) {
  if(isDefined(_id_E012E0B70D7D54FA)) {
    glgrenade = grenade;
    grenade = scripts\mp\utility\weapon::_launchgrenade("thermite_mp", glgrenade.origin, (0, 0, 0));
    scripts\mp\weapons::grenadeinitialize(grenade, makeweapon("thermite_mp"));
    grenade.glgrenade = glgrenade;
    grenade.angles = glgrenade.angles;
    grenade.glgrenadeparent = self getcurrentweapon();
    grenade linkTo(glgrenade);
    grenade.exploding = 1;
    grenade setscriptablepartstate("visibility", "hide", 0);
  }

  grenade thread thermite_watchdisowned();
  grenade thread thermite_watchstuck(_id_E012E0B70D7D54FA);
}

_id_A27A3D57409F4EA6(grenade) {
  grenade endon("missile_stuck");
  _id_219A2ABCD03A18BA = 0;

  if(scripts\cp_mp\utility\player_utility::_id_988138367C74B1F5())
    _id_219A2ABCD03A18BA = 1;

  grenade waittill("missile_water_impact");

  if(!_id_219A2ABCD03A18BA)
    grenade notify("missile_stuck");
}

thermite_watchstuck(_id_E012E0B70D7D54FA) {
  self endon("death");
  stuckto = undefined;

  if(istrue(_id_E012E0B70D7D54FA)) {
    _id_172FACF3120B4CDE = thermite_watchglstuck();

    if(!istrue(_id_172FACF3120B4CDE)) {
      thread thermite_delete();
      return;
    }

    if(isDefined(self.glgrenade))
      self.glgrenade delete();
  } else {
    self.owner thread _id_A27A3D57409F4EA6(self);
    self waittill("missile_stuck", stuckto);
  }

  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");

  if(!istrue(_id_E012E0B70D7D54FA)) {
    if(isDefined(stuckto)) {
      if(isPlayer(stuckto) || isagent(stuckto))
        thread scripts\mp\weapons::grenadestuckto(self, stuckto);
      else
        thread scripts\mp\equipment::_id_4AF015619E2534BA(stuckto, ::thermite_destroy, 0);
    }
  }

  weaponobj = self.weapon_object;

  if(isDefined(self.glgrenadeparent))
    self.owner scripts\cp_mp\utility\weapon_utility::_id_49967318FBD12317(weaponobj, self.glgrenadeparent);

  thread thermite_watchstucktoterrain();
  self setscriptablepartstate("effects", "impact", 0);
  thermite_doradiusdamage(weaponobj);

  if(!istrue(level.dangerzoneskipequipment) && isDefined(self.owner.team))
    self.dangerzoneid = scripts\mp\spawnlogic::addspawndangerzone(self.origin, 175, 175, self.owner.team, 100, self.owner, 1, self, 1);

  wait 0.5;
  _id_DCBA62AB4B6154ED = makeweapon("thermite_av_mp");
  _id_DCBA5CAB4B6147BB = makeweapon("thermite_ap_mp");

  if(isDefined(self.glgrenadeparent)) {
    self.owner scripts\cp_mp\utility\weapon_utility::_id_49967318FBD12317(_id_DCBA62AB4B6154ED, self.glgrenadeparent);
    self.owner scripts\cp_mp\utility\weapon_utility::_id_49967318FBD12317(_id_DCBA5CAB4B6147BB, self.glgrenadeparent);
  }

  ticks = 1;

  while(ticks <= 10) {
    _id_6B3EE446F2845368 = ticks + 1;

    if(scripts\engine\utility::mod(_id_6B3EE446F2845368, 2) > 0)
      thermite_doradiusdamage(_id_DCBA62AB4B6154ED);
    else
      thermite_doradiusdamage(_id_DCBA5CAB4B6147BB);

    ticks = _id_6B3EE446F2845368;
    wait 0.5;
  }

  thread thermite_destroy();
}

thermite_watchglstuck() {
  self.glgrenade endon("death");
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  self.glgrenade waittill("missile_stuck", stuckto, _id_16A48D7056E5C472, surfacetype, velocity, position, normal);

  if(isDefined(stuckto)) {
    if(isPlayer(stuckto) || isagent(stuckto)) {
      if(stuckto scripts\cp_mp\utility\player_utility::_isalive()) {
        if(isPlayer(stuckto))
          thread scripts\mp\weapons::grenadestuckto(self, stuckto);

        if(isDefined(_id_16A48D7056E5C472))
          self linkTo(stuckto, _id_16A48D7056E5C472);
        else
          self linkTo(stuckto, "j_spine4", (0, 0, 0));
      }
    } else if(isDefined(_id_16A48D7056E5C472))
      self linkTo(stuckto, _id_16A48D7056E5C472);
    else
      self linkTo(stuckto);
  }

  return 1;
}

thermite_watchstucktoterrain() {
  self endon("death");
  stuckto = self getlinkedparent();

  while(isDefined(stuckto))
    self waittill("missile_stuck", stuckto);

  self.badplace = createnavbadplacebybounds(self.origin, (125, 125, 125), (0, 0, 0));
}

thermite_doradiusdamage(weaponobj) {
  radius = 125;
  _id_95B523256E906E92 = 25;
  _id_994D66DFA5028629 = 10;
  meansofdeath = "MOD_FIRE";

  if(weaponobj.basename == "thermite_mp") {
    radius = 125;
    _id_95B523256E906E92 = 30;
    _id_994D66DFA5028629 = 30;
  }

  stuckto = self.stuckenemyentity;

  if(isDefined(stuckto)) {
    if(isPlayer(stuckto) && scripts\cp_mp\utility\player_utility::isreallyalive(stuckto)) {
      stuckto dodamage(_id_95B523256E906E92, self.origin, self.owner, self, meansofdeath, weaponobj, "torso_upper");
      stuckto scripts\cp_mp\utility\damage_utility::adddamagemodifier("thermiteStuck", 0, 0, ::thermite_damagemodifierignorefunc);
    } else
      stuckto = undefined;
  }

  self radiusdamage(self.origin, radius, _id_95B523256E906E92, _id_994D66DFA5028629, self.owner, meansofdeath, weaponobj);

  if(isDefined(stuckto))
    stuckto scripts\cp_mp\utility\damage_utility::removedamagemodifier("thermiteStuck", 0);
}

thermite_damagemodifierignorefunc(inflictor, attacker, victim, damage, meansofdeath, objweapon, hitloc) {
  if(!isDefined(inflictor))
    return 1;

  if(!isDefined(inflictor.weapon_name) || inflictor.weapon_name != "thermite_mp")
    return 1;

  if(!isDefined(inflictor.stuckenemyentity) || inflictor.stuckenemyentity != victim)
    return 1;

  return 0;
}

thermite_watchdisowned() {
  self endon("death");
  self.owner scripts\engine\utility::waittill_any_3("joined_team", "joined_spectators", "disconnect");
  thread thermite_destroy();
}

thermite_destroy(_id_6A94CF09AA6E486E) {
  time = 5;

  if(istrue(_id_6A94CF09AA6E486E))
    time = undefined;

  self setscriptablepartstate("effects", "burnEnd", 0);
  thread thermite_delete(time);
}

thermite_delete(_id_CBF7BE4F62A0DDB2) {
  self notify("death");
  self.exploding = 1;

  if(isDefined(self.dangerzoneid)) {
    scripts\mp\spawnlogic::removespawndangerzone(self.dangerzoneid);
    self.dangerzoneid = undefined;
  }

  if(isDefined(self.badplace)) {
    destroynavobstacle(self.badplace);
    self.badplace = undefined;
  }

  self forcehidegrenadehudwarning(1);

  if(isDefined(_id_CBF7BE4F62A0DDB2))
    wait(_id_CBF7BE4F62A0DDB2);

  if(isDefined(self))
    self delete();
}

thermite_onplayerdamaged(data) {
  if(data.meansofdeath == "MOD_IMPACT")
    return 1;

  data.victim.lastburntime = gettime();
  data.victim thread scripts\mp\weapons::enableburnfxfortime(0.6);
  return 1;
}