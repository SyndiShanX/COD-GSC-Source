/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\equipment\cp_thermite.gsc
************************************************/

thermite_used(grenade, _id_E012E0B70D7D54FA, _id_D4FBC5BE3B7D6578) {
  if(isDefined(_id_E012E0B70D7D54FA)) {
    glgrenade = grenade;
    grenade = self launchgrenade("thermite_mp", glgrenade.origin, (0, 0, 0));
    grenade.glgrenade = glgrenade;
    grenade.angles = glgrenade.angles;
    grenade.owner = self;
    grenade.classname = "thermite_mp";
    grenade linkTo(glgrenade);
    grenade setscriptablepartstate("visibility", "hide", 0);
  }

  grenade.grenade_owner_name = self.name;
  grenade thread thermite_watchdisowned();
  grenade thread thermite_watchstuck(_id_E012E0B70D7D54FA, _id_D4FBC5BE3B7D6578);
}

thermite_watchstuck(_id_E012E0B70D7D54FA, _id_D4FBC5BE3B7D6578) {
  self endon("death");
  self.ignore_fire_armor_check = 1;
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
    self waittill("missile_stuck", stuckto, _id_16A48D7056E5C472);

    if(istrue(_id_D4FBC5BE3B7D6578))
      thermite_linktostuck(stuckto, _id_16A48D7056E5C472);
  }

  level notify("grenade_exploded_during_stealth", self, "thermite_mp", self.grenade_owner_name);

  if(isDefined(self.owner)) {
    self.owner endon("disconnect");
    self.owner endon("joined_team");
    self.owner endon("joined_spectators");
  }

  thread thermite_watchstucktoterrain();
  self setscriptablepartstate("effects", "impact", 0);
  self setscriptablepartstate("damage", "impact", 0);
  self radiusdamage(self.origin, 125, 30, 30, self.owner, "MOD_FIRE", "thermite_mp");
  wait 0.5;
  ticks = 1;

  while(ticks <= 10) {
    _id_6B3EE446F2845368 = ticks + 1;

    if(scripts\engine\utility::mod(_id_6B3EE446F2845368, 2) > 0) {
      self setscriptablepartstate("damage", "antiVehicle", 0);
      self radiusdamage(self.origin, 125, 25, 10, self.owner, "MOD_FIRE", "thermite_av_mp");
    } else {
      self setscriptablepartstate("damage", "antiPlayer", 0);
      self radiusdamage(self.origin, 125, 25, 10, self.owner, "MOD_FIRE", "thermite_av_mp");
    }

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
  thermite_linktostuck(stuckto, _id_16A48D7056E5C472);
  return 1;
}

thermite_watchstucktoterrain() {
  self endon("death");
  stuckto = self getlinkedparent();

  while(isDefined(stuckto))
    self waittill("missile_stuck", stuckto);

  self.badplace = createnavbadplacebybounds(self.origin, (125, 125, 125), (0, 0, 0));
}

thermite_linktostuck(stuckto, _id_16A48D7056E5C472) {
  if(isDefined(stuckto)) {
    if(isPlayer(stuckto) || isagent(stuckto)) {
      if(stuckto scripts\cp_mp\utility\player_utility::_isalive()) {
        if(isDefined(_id_16A48D7056E5C472))
          self linkTo(stuckto, _id_16A48D7056E5C472);
        else
          self linkTo(stuckto, "j_spine", (0, 0, 0));

        if(isPlayer(stuckto))
          stuckto thread scripts\cp\cp_weapons::enableburnfxfortime(0.6);
      }
    } else if(isDefined(_id_16A48D7056E5C472))
      self linkTo(stuckto, _id_16A48D7056E5C472);
    else
      self linkTo(stuckto);
  }
}

thermite_watchdisowned() {
  self endon("death");
  self.owner scripts\engine\utility::waittill_any_3("joined_team", "joined_spectators", "disconnect");
  thread thermite_destroy();
}

thermite_destroy() {
  stuckto = self getlinkedparent();

  if(isDefined(stuckto) && isPlayer(stuckto)) {
    if(istrue(stuckto.inlaststand))
      stuckto thread thermite_laststand_effects();
  }

  thread thermite_delete(5);
  self setscriptablepartstate("effects", "burnEnd", 0);
}

thermite_delete(_id_CBF7BE4F62A0DDB2) {
  self notify("death");
  self.exploding = 1;

  if(isDefined(self.badplace)) {
    destroynavobstacle(self.badplace);
    self.badplace = undefined;
  }

  self forcehidegrenadehudwarning(1);
  wait(_id_CBF7BE4F62A0DDB2);
  self delete();
}

thermite_onplayerdamaged(data) {
  if(data.meansofdeath == "MOD_IMPACT")
    return 1;

  data.victim thread scripts\cp\cp_weapons::enableburnfxfortime(0.6);
  return 1;
}

thermite_laststand_effects() {
  self endon("disconnect");
  self notify("newBurnFXLaststand");
  self endon("newBurnFXLaststand");
  waitframe();
  thread scripts\cp\cp_weapons::enableburnfxfortime(4);
}