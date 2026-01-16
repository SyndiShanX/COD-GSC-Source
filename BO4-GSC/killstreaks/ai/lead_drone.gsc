/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: killstreaks\ai\lead_drone.gsc
***********************************************/

#include scripts\core_common\ai\systems\ai_interface;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\targetting_delay;
#include scripts\core_common\turret_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\vehicle_ai_shared;
#include scripts\core_common\vehicle_shared;
#include scripts\core_common\weapons_shared;
#include scripts\killstreaks\killstreaks_shared;
#include scripts\killstreaks\remote_weapons;

#namespace lead_drone;

autoexec __init__system__() {
  system::register(#"lead_drone", &__init__, undefined, undefined);
}

__init__() {
  vehicle::add_main_callback("lead_drone", &function_e8549ef6);
  clientfield::register("vehicle", "lead_drone_reload", 1, 1, "int");
}

private function_e8549ef6() {
  self endon(#"death");
  self useanimtree("generic");
  vehicle::make_targetable(self, (0, 0, 0));
  ai::createinterfaceforentity(self);
  self.health = self.healthdefault;
  self vehicle::friendly_fire_shield();
  self setneargoalnotifydist(40);
  self.damagetaken = 0;
  self.fovcosine = 0;
  self.fovcosinebusy = 0.574;
  self.vehaircraftcollisionenabled = 1;
  self.var_94e2cf87 = 1;
  self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
  self.var_ec0d66ce = 0.5 * (self.settings.engagementdistmin + self.settings.engagementdistmax);
  self.var_ff6d7c88 = self.var_ec0d66ce * self.var_ec0d66ce;
  self.vehaircraftcollisionenabled = 0;
  self.ai.var_88b0fd29 = gettime();
  self.ai.var_54b19f55 = 1;
  self.ai.clipsize = 60;
  self.ai.bulletsinclip = 60;
  defaultrole();
  self.overridevehicledamage = &function_9bbb40ab;
  self thread targetting_delay::function_7e1a12ce(3500);
}

private side_turrets_forward() {
  self turretsettargetangles(1, (10, -90, 0));
  self turretsettargetangles(2, (10, 90, 0));
}

defaultrole() {
  self vehicle_ai::init_state_machine_for_role();
  self vehicle_ai::get_state_callbacks("combat").enter_func = &state_combat_enter;
  self vehicle_ai::get_state_callbacks("combat").update_func = &state_combat_update;
  self vehicle_ai::get_state_callbacks("combat").exit_func = &state_combat_exit;
  self vehicle_ai::get_state_callbacks("death").update_func = &state_death_update;
  vehicle_ai::startinitialstate("combat");
}

state_death_update(params) {
  self endon(#"death");
  death_type = vehicle_ai::get_death_type(params);

  if(!isDefined(death_type)) {
    params.death_type = "gibbed";
    death_type = params.death_type;
  }

  self vehicle_ai::clearalllookingandtargeting();
  self vehicle_ai::clearallmovement();
  self cancelaimove();
  self setspeedimmediate(0);
  self setvehvelocity((0, 0, 0));
  self setphysacceleration((0, 0, 0));
  self setangularvelocity((0, 0, 0));
  self vehicle_ai::defaultstate_death_update(params);
}

function_f358791() {
  self endon(#"death", #"change_state");
  wait 1;

  for(;;) {
    if(isDefined(self.isstunned) && self.isstunned) {
      self.favoriteenemy = undefined;
      waitframe(1);
      continue;
    }

    targets = [];
    targetsmissile = [];
    players = level.players;

    foreach(player in players) {
      if(self cantargetplayer(player)) {
        targets[targets.size] = player;
      }
    }

    tanks = getEntArray("talon", "targetname");

    foreach(tank in tanks) {
      if(self cantargettank(tank)) {
        targets[targets.size] = tank;
      }
    }

    actors = getactorarray();

    foreach(actor in actors) {
      if(self cantargetactor(actor)) {
        targets[targets.size] = actor;
      }
    }

    self.var_dac49144 = function_b2cc6703(targets);
    wait 1;
  }
}

function_b2cc6703(targets) {
  entnum = self getentitynumber();

  for(idx = 0; idx < targets.size; idx++) {
    if(!isDefined(targets[idx].var_629a6b13)) {
      targets[idx].var_629a6b13 = [];
    }

    targets[idx].var_629a6b13[entnum] = 0;

    if(isDefined(targets[idx].type) && targets[idx].type == "dog") {
      update_dog_threat(targets[idx]);
      continue;
    }

    if(isactor(targets[idx])) {
      update_actor_threat(targets[idx]);
      continue;
    }

    if(isplayer(targets[idx])) {
      update_player_threat(targets[idx]);
      continue;
    }

    update_non_player_threat(targets[idx]);
  }

  var_8ec7f501 = undefined;
  highest = -1;

  for(idx = 0; idx < targets.size; idx++) {
    assert(isDefined(targets[idx].var_629a6b13[entnum]), "<dev string:x38>");

    if(targets[idx].var_629a6b13[entnum] >= highest) {
      highest = targets[idx].var_629a6b13[entnum];
      var_8ec7f501 = targets[idx];
    }
  }

  return var_8ec7f501;
}

private update_player_threat(player) {
  entnum = self getentitynumber();
  player.var_629a6b13[entnum] = 0;
  dist = distance(player.origin, self.origin);
  player.var_629a6b13[entnum] -= dist;

  if(isDefined(self.attacker) && player == self.attacker) {
    player.var_629a6b13[entnum] += 100;
  }

  if(isDefined(player.carryobject)) {
    player.var_629a6b13[entnum] += 200;
  }

  if(player weapons::has_launcher()) {
    if(player weapons::has_lockon(self)) {
      player.var_629a6b13[entnum] += 1000;
    } else {
      player.var_629a6b13[entnum] += 500;
    }
  }

  if(player weapons::has_heavy_weapon()) {
    player.var_629a6b13[entnum] += 300;
  }

  if(player weapons::has_lmg()) {
    player.var_629a6b13[entnum] += 200;
  }

  if(isDefined(player.antithreat)) {
    player.var_629a6b13[entnum] -= player.antithreat;
  }

  if(player.var_629a6b13[entnum] <= 0) {
    player.var_629a6b13[entnum] = 2;
  }
}

private update_non_player_threat(non_player) {
  entnum = self getentitynumber();
  non_player.var_629a6b13[entnum] = 0;
  dist = distance(non_player.origin, self.origin);
  non_player.var_629a6b13[entnum] -= dist;

  if(non_player.var_629a6b13[entnum] <= 0) {
    non_player.var_629a6b13[entnum] = 1;
  }
}

private update_actor_threat(actor) {
  entnum = self getentitynumber();
  actor.var_629a6b13[entnum] = 0;
  dist = distance(actor.origin, self.origin);
  actor.var_629a6b13[entnum] -= dist;

  if(isDefined(actor.owner)) {
    if(isDefined(self.attacker) && actor.owner == self.attacker) {
      actor.var_629a6b13[entnum] += 100;
    }

    if(isDefined(actor.owner.carryobject)) {
      actor.var_629a6b13[entnum] += 200;
    }

    if(isDefined(actor.owner.antithreat)) {
      actor.var_629a6b13[entnum] -= actor.owner.antithreat;
    }
  }

  if(actor.var_629a6b13[entnum] <= 0) {
    actor.var_629a6b13[entnum] = 1;
  }
}

private update_dog_threat(dog) {
  entnum = self getentitynumber();
  dog.var_629a6b13[entnum] = 0;
  dist = distance(dog.origin, self.origin);
  dog.var_629a6b13[entnum] -= dist;
}

cantargetplayer(player) {
  if(!isDefined(player)) {
    return false;
  }

  if(!isalive(player) || player.sessionstate != "playing") {
    return false;
  }

  if(player.ignoreme === 1) {
    return false;
  }

  if(isDefined(self.owner) && player == self.owner) {
    return false;
  }

  if(!isDefined(player.team)) {
    return false;
  }

  if(level.teambased && player.team == self.team) {
    return false;
  }

  if(player.team == #"spectator") {
    return false;
  }

  if(!self cansee(player, 2)) {
    return false;
  }

  if(player depthinwater() >= 30 || player isplayerswimming()) {
    return false;
  }

  var_2910def0 = self targetting_delay::function_1c169b3a(player);
  targetting_delay::function_a4d6d6d8(player, int((isDefined(self.targeting_delay) ? self.targeting_delay : 0.05) * 1000));

  if(!var_2910def0) {
    return false;
  }

  return true;
}

cantargettank(tank) {
  if(!isDefined(tank)) {
    return false;
  }

  if(!isDefined(tank.team)) {
    return false;
  }

  if(!util::function_fbce7263(tank.team, self.team)) {
    return false;
  }

  if(isDefined(tank.owner) && self.owner == tank.owner) {
    return false;
  }

  return true;
}

cantargetactor(actor) {
  if(!isDefined(actor)) {
    return false;
  }

  if(!isactor(actor)) {
    return false;
  }

  if(!isalive(actor)) {
    return false;
  }

  if(!isDefined(actor.team)) {
    return false;
  }

  if(!util::function_fbce7263(actor.team, self.team)) {
    return false;
  }

  return true;
}

state_combat_enter(params) {
  self.protectdest = self.origin;
  self function_a57c34b7(self.origin, 1, 1);
  self thread function_f358791();
}

reload() {
  self laseroff();
  clientfield::set("lead_drone_reload", 1);
  wait 2;
  clientfield::set("lead_drone_reload", 0);
  self.ai.bulletsinclip = self.ai.clipsize;
}

attackthread() {
  self endon(#"death", #"change_state", #"end_attack_thread");

  while(true) {
    enemy = undefined;

    if(isDefined(self.var_dac49144)) {
      enemy = self.var_dac49144;
      self.favoriteenemy = self.var_dac49144;
    } else {
      enemy = undefined;
      self.favoriteenemy = undefined;
    }

    if(isDefined(enemy)) {
      self laseron();
      self vehlookat(enemy);

      if(self cansee(enemy)) {
        self turretsettarget(0, enemy);

        while(!self.turretontarget) {
          waitframe(1);
        }

        if(isDefined(enemy)) {
          if(self.ai.bulletsinclip > 0) {
            s_turret = self turret::_get_turret_data(0);

            if(isDefined(s_turret)) {
              minigun = self fireweapon(0, enemy, s_turret.v_offset);
              self.ai.bulletsinclip--;
            }
          } else {
            reload();
          }
        }
      }
    }

    if(!isDefined(self.favoriteenemy)) {
      self laseroff();
    }

    waitframe(1);
  }
}

function_1c4cd527(origin, owner, innerradius, outerradius, halfheight, spacing) {
  queryresult = positionquery_source_navigation(origin, innerradius, outerradius, halfheight, spacing, "navvolume_small", spacing);
  positionquery_filter_sight(queryresult, origin, self getEye() - self.origin, self, 0, owner);

  foreach(point in queryresult.data) {
    if(!point.visibility) {

      if(!isDefined(point._scoredebug)) {
        point._scoredebug = [];
      }

      if(!isDefined(point._scoredebug[#"no visibility"])) {
        point._scoredebug[#"no visibility"] = spawnStruct();
      }

      point._scoredebug[#"no visibility"].score = -5000;
      point._scoredebug[#"no visibility"].scorename = "<dev string:x63>";

        point.score += -5000;
    }
  }

  if(queryresult.data.size > 0) {
    vehicle_ai::positionquery_postprocess_sortscore(queryresult);
    self vehicle_ai::positionquery_debugscores(queryresult);

    foreach(point in queryresult.data) {
      if(isDefined(point.origin)) {
        goal = point.origin;
        break;
      }
    }
  }

  return goal;
}

function_ede09a4e(owner) {
  protectdest = undefined;

  if(isDefined(owner)) {
    groundpos = getclosestpointonnavmesh(owner.origin, 10000);
    groundpos += vectorscale(anglesToForward(owner.angles), randomintrange(100, 200));

    if(isDefined(groundpos)) {
      self.var_d6acaac4 = groundpos;
      pos = groundpos + (0, 0, randomintrange(150, 300));
      pos = getclosestpointonnavvolume(pos, "navvolume_small", 2000);

      if(isDefined(pos)) {
        var_3a364b6c = distance(self.protectdest, pos);

        if(var_3a364b6c > 256) {
          protectdest = function_1c4cd527(pos, self.owner, 32, 256, 48, 48);

          if(isDefined(protectdest)) {
            self.protectdest = protectdest;
          }
        }
      }
    }
  }

  return protectdest;
}

function_5ebe7443() {
  self endon(#"death");

  while(true) {
    if(isDefined(self.protectdest)) {

      recordsphere(self.protectdest, 8, (0, 0, 1), "<dev string:x73>");

        if(isDefined(self.var_d6acaac4)) {

          recordsphere(self.protectdest, 8, (0, 1, 0), "<dev string:x73>");
          recordline(self.protectdest, self.var_d6acaac4, (0, 1, 0), "<dev string:x73>");

        }
    }

    waitframe(1);
  }
}

state_combat_update(params) {
  self endon(#"change_state", #"death");
  self thread function_5ebe7443();
  self thread attackthread();

  for(;;) {
    if(isDefined(self.ignoreall) && self.ignoreall) {
      wait 1;
      continue;
    }

    if(isDefined(self.owner) && isDefined(level.var_fdf0dff2) && ![
        [level.var_fdf0dff2]
      ](self.owner)) {
      wait 1;
      continue;
    }

    if(!ispointinnavvolume(self.origin, "navvolume_small")) {
      var_f524eafc = getclosestpointonnavvolume(self.origin, "navvolume_small", 2000);

      if(isDefined(var_f524eafc)) {
        self.origin = var_f524eafc;
      }
    }

    protectdest = function_ede09a4e(self.owner);

    if(isDefined(protectdest)) {
      self function_a57c34b7(protectdest, 1, 1);
    }

    wait 1;
  }
}

state_combat_exit(params) {
  self notify(#"end_attack_thread");
  self notify(#"end_movement_thread");
  self turretcleartarget(0);
}

function_9bbb40ab(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  if(smeansofdeath == "MOD_TRIGGER_HURT") {
    return 0;
  }

  idamage = vehicle_ai::shared_callback_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);

  if(isDefined(weapon)) {
    if(weapon.dostun && smeansofdeath == "MOD_GRENADE_SPLASH" || weapon.var_8456d4d === #"damageeffecttype_electrical") {
      minempdowntime = 0.8 * (isDefined(self.settings.empdowntime) ? self.settings.empdowntime : 0);
      maxempdowntime = 1.2 * (isDefined(self.settings.empdowntime) ? self.settings.empdowntime : 1);
      self notify(#"emped", {
        #param0: randomfloatrange(minempdowntime, maxempdowntime), 
        #param1: eattacker, 
        #param2: einflictor
      });
    }
  }

  emp_damage = self.healthdefault * 0.5 + 0.5;
  idamage = killstreaks::ondamageperweapon("drone_squadron", eattacker, idamage, idflags, smeansofdeath, weapon, self.maxhealth, &destroyed_cb, self.maxhealth * 0.4, &low_health_cb, emp_damage, undefined, 1, 1);

  if(isDefined(weapon)) {
    if(weapon.name == #"hatchet" && smeansofdeath == "MOD_IMPACT") {
      idamage = self.maxhealth;
    }
  }

  self.damagetaken += idamage;
  return idamage;
}

destroyed_cb(attacker, weapon) {}

low_health_cb(attacker, weapon) {
  if(self.playeddamaged == 0) {
    self killstreaks::play_pilot_dialog_on_owner("damaged", "drone_squadron", self.killstreak_id);
    self.playeddamaged = 1;
  }
}