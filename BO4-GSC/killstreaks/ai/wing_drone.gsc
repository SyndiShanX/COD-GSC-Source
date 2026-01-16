/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: killstreaks\ai\wing_drone.gsc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\turret_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\vehicle_ai_shared;
#include scripts\core_common\vehicle_death_shared;
#include scripts\core_common\vehicle_shared;
#include scripts\killstreaks\ai\lead_drone;
#include scripts\killstreaks\killstreaks_shared;
#include scripts\killstreaks\remote_weapons;

#namespace wing_drone;

autoexec __init__system__() {
  system::register(#"wing_drone", &__init__, undefined, undefined);
}

__init__() {
  if(!isDefined(level.var_c23a525e)) {
    level.var_c23a525e = {};
    vehicle::add_main_callback("wing_drone", &function_7a81018e);
    clientfield::register("vehicle", "wing_drone_reload", 1, 1, "int");
  }
}

function_7a81018e() {
  self endon(#"death");
  self useanimtree("generic");
  vehicle::make_targetable(self, (0, 0, 0));
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
  self.ai.clipsize = 40;
  self.ai.bulletsinclip = 40;
  defaultrole();
  self.overridevehicledamage = &function_9bbb40ab;
  self thread monitorleader();
}

defaultrole() {
  self vehicle_ai::init_state_machine_for_role("default");
  self vehicle_ai::get_state_callbacks("combat").enter_func = &state_combat_enter;
  self vehicle_ai::get_state_callbacks("combat").update_func = &state_combat_update;
  self vehicle_ai::get_state_callbacks("combat").exit_func = &state_combat_exit;
  self vehicle_ai::get_state_callbacks("death").update_func = &state_death_update;
  self vehicle_ai::add_state("malfunction", &malfunction_enter, &malfunction_update, &malfunction_end);
  vehicle_ai::startinitialstate("combat");
}

malfunction_enter(params) {}

malfunction_update(params) {
  self endon(#"death");
  ang_vel = self getangularvelocity();
  pitch_vel = math::randomsign() * randomfloatrange(200, 250);
  yaw_vel = math::randomsign() * randomfloatrange(200, 250);
  roll_vel = math::randomsign() * randomfloatrange(200, 250);
  ang_vel += (pitch_vel, yaw_vel, roll_vel);
  self setangularvelocity(ang_vel);
  self cancelaimove();
  self setphysacceleration((0, 0, 100 * -1));
  waitresult = self waittilltimeout(randomintrange(4, 6), #"veh_collision");
  self vehicle_ai::set_state("death");
}

malfunction_end(params) {}

monitorleader() {
  self endon(#"death");
  self endon(#"change_state");

  for(;;) {
    if(isDefined(self.leader)) {
      break;
    }

    waitframe(1);
  }

  for(;;) {
    if(!isDefined(self.leader) || !isalive(self.leader)) {
      self vehicle_ai::set_state("malfunction");
      break;
    }

    waitframe(1);
  }
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

state_combat_enter(params) {
  self.protectdest = self.origin;
  self function_a57c34b7(self.origin, 1, 1);
  self thread lead_drone::function_f358791();
}

reload() {
  self laseroff();
  clientfield::set("wing_drone_reload", 1);
  wait 2;
  clientfield::set("wing_drone_reload", 0);
  self.ai.bulletsinclip = self.ai.clipsize;
}

attackthread() {
  self endon(#"death");
  self endon(#"change_state");
  self endon(#"end_attack_thread");

  while(true) {
    if(isDefined(self.leader)) {
      enemy = self.leader.favoriteenemy;

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
    }

    waitframe(1);
  }
}

function_789652f2(origin, owner, innerradius, outerradius, halfheight, spacing) {
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
      point._scoredebug[#"no visibility"].scorename = "<dev string:x38>";

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

function_ede09a4e(leader) {
  protectdest = undefined;
  leader_back = anglesToForward(leader.angles) * -1 * 125;

  if(self.formation == "right") {
    var_7a1bb341 = anglestoright(leader.angles) * 125;
  } else {
    var_7a1bb341 = anglestoright(leader.angles) * -1 * 125;
  }

  var_b4debf4a = leader.origin + leader_back + var_7a1bb341;
  goalpos = self getclosestpointonnavvolume(var_b4debf4a, 2000);

  if(!isDefined(goalpos)) {
    goalpos = leader.origin;
  }

  pos = goalpos + (0, 0, randomintrange(30, 70));
  pos = getclosestpointonnavvolume(pos, "navvolume_small", 2000);

  if(isDefined(pos)) {
    var_3a364b6c = distance(self.protectdest, pos);

    if(var_3a364b6c > 125) {
      protectdest = function_789652f2(pos, leader, 48, 96, 10, 20);

      if(isDefined(protectdest)) {
        self.protectdest = protectdest;
      }
    }
  }

  return protectdest;
}

function_b0c75ada(leader) {
  assert(isDefined(leader));
  distsq = distancesquared(self.origin, self.leader.origin);

  if(distsq <= 125 * 125) {
    return undefined;
  }

  protectdest = undefined;
  leader_back = anglesToForward(leader.angles) * -1 * 125;

  if(self.formation == "right") {
    var_7a1bb341 = anglestoright(leader.angles) * 125;
  } else {
    var_7a1bb341 = anglestoright(leader.angles) * -1 * 125;
  }

  var_b4debf4a = leader.origin + leader_back + var_7a1bb341;
  groundpos = getclosestpointonnavmesh(var_b4debf4a, 10000);

  if(isDefined(groundpos)) {
    self.var_d6acaac4 = groundpos;
    groundpos += (0, 0, randomintrange(30, 70));
    goalpos = getclosestpointonnavvolume(groundpos, "navvolume_small", 2000);
  }

  if(isDefined(goalpos)) {
    queryresult = positionquery_source_navigation(goalpos, 48, 96, 10, 20, "navvolume_small", 20);
    positionquery_filter_sight(queryresult, goalpos, self getEye() - self.origin, self, 0, leader);

    foreach(point in queryresult.data) {
      if(!point.visibility) {

        if(!isDefined(point._scoredebug)) {
          point._scoredebug = [];
        }

        if(!isDefined(point._scoredebug[#"no visibility"])) {
          point._scoredebug[#"no visibility"] = spawnStruct();
        }

        point._scoredebug[#"no visibility"].score = -5000;
        point._scoredebug[#"no visibility"].scorename = "<dev string:x38>";

          point.score += -5000;
      }
    }

    if(queryresult.data.size > 0) {
      vehicle_ai::positionquery_postprocess_sortscore(queryresult);
      self vehicle_ai::positionquery_debugscores(queryresult);

      foreach(point in queryresult.data) {
        if(isDefined(point.origin)) {
          protectdest = point.origin;
          break;
        }
      }
    }
  }

  self.protectdest = protectdest;
  return protectdest;
}

function_5ebe7443() {
  self endon(#"death");

  while(true) {
    if(isDefined(self.protectdest)) {

      recordsphere(self.protectdest, 8, (0, 1, 1), "<dev string:x48>");

        if(isDefined(self.var_d6acaac4)) {

          recordsphere(self.protectdest, 8, (1, 1, 0), "<dev string:x48>");
          recordline(self.protectdest, self.var_d6acaac4, (0, 1, 0), "<dev string:x48>");

        }
    }

    waitframe(1);
  }
}

state_combat_update(params) {
  self endon(#"change_state");
  self endon(#"death");
  self thread function_5ebe7443();
  self thread attackthread();

  for(;;) {
    if(isDefined(self.ignoreall) && self.ignoreall) {
      wait 1;
      continue;
    }

    if(!ispointinnavvolume(self.origin, "navvolume_small")) {
      var_f524eafc = getclosestpointonnavvolume(self.origin, "navvolume_small", 2000);

      if(isDefined(var_f524eafc)) {
        self.origin = var_f524eafc;
      }
    }

    if(!isDefined(self.leader)) {
      wait 1;
      continue;
    }

    if(isDefined(self.leader) && isDefined(self.leader.owner) && isDefined(level.var_fdf0dff2) && ![
        [level.var_fdf0dff2]
      ](self.leader.owner)) {
      wait 1;
      continue;
    }

    protectdest = function_ede09a4e(self.leader);

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

low_health_cb(attacker, weapon) {}