/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_2f2628d802eb2807.gsc
*************************************************/

#using scripts\common\string;
#using scripts\common\utility;
#using scripts\common\vehicle_aianim;
#using scripts\common\vehicle_code;
#using scripts\cp_mp\killstreaks\chopper_gunner;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\gametypes\dmz_samsites;
#using scripts\mp\utility\player;
#using scripts\mp\utility\teams;
#using scripts\mp\vehicles\damage;
#using scripts\mp\weapons;
#using scripts\vehicle\vehicle_common;
#namespace namespace_673092b35aa65d1c;

function function_e09936350b8d90fe() {
  data = spawnStruct();
  data.spawnheli = &function_2d905b603e7888c9;
  data.var_e0fd93cddc4b8912 = &function_595d4ebd73e6b933;
  data.flyaway = &function_5eb66c5c1382fed;
  return data;
}

function function_2d905b603e7888c9(guardvehicle) {
  heli = function_b232793fe47c01b9();
  heli.guardvehicle = guardvehicle;
  heli.task = self;
  heli thread function_282ffb050875ade6(guardvehicle);
  heli thread function_f21d965808c268bb();
  scripts\mp\weapons::function_e00b77a9cb4d8322(heli);
  heli.flaresreservecount = 1;
  heli.flareslive = [];

  if(scripts\engine\utility::issharedfuncdefined("flares", "handleIncomingStinger")) {
    heli thread[[scripts\engine\utility::getsharedfunc("flares", "handleIncomingStinger")]](&function_8fe1775245b13b6f);
  }

  return heli;
}

function private function_b232793fe47c01b9() {
  node = getclosest((self.vehicle.origin + self.end.origin) * 0.5, level.var_77aa416377054823);
  spawnnode = spawnStruct();
  spawnnode.origin = node.origin;
  spawnnode.angles = node.angles;
  spawnnode.vehicletype = "veh_apache_mp_phys";
  spawnnode.modelname = "veh9_mil_air_heli_ahotel64_mp";
  spawnnode.targetname = "boatdrive_apache";

  if(!scripts\cp_mp\vehicles\vehicle_tracking::canspawnVehicle()) {
    scripts\cp_mp\vehicles\vehicle::function_f9aa6f0d46bc950b();
  }

  faildata = spawnStruct();
  heli = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(spawnnode, faildata);
  heli.vehiclename = "veh_apache_mp_phys";
  heli.maxhealth = getdvarint(@ "hash_3e5661644a24771e", 10000);
  heli.health = heli.maxhealth;
  heli.team = "team_hundred_ninety_five";
  heli setvehicleteam("team_hundred_ninety_five");
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance(heli, undefined, heli.team, 1);
  heli scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setCanDamage(1);
  heli.var_9882cd795c6bfaa = 1;
  heli scripts\mp\vehicles\damage::set_pre_mod_damage_callback("veh_apache_mp_phys", &function_57314b27f4592824);
  heli scripts\mp\vehicles\damage::set_post_mod_damage_callback("veh_apache_mp_phys", &function_499e02474dfc9171);
  heli scripts\mp\vehicles\damage::set_death_callback("veh_apache_mp_phys", &function_e6cbc6847a8fb80b);
  heli function_247ad6a91f6a4ffe(1);
  heli.exitnode = node;
  heli scripts\mp\vehicles\damage::set_vehicle_hit_damage_data("veh_apache_mp_phys", 20);

  if(getdvarint(@ "hash_3061dc07aba9108", 1)) {
    heli thread scripts\mp\gametypes\dmz_samsites::function_ff7b51833a73e61();
  }

  return heli;
}

function private function_7512e3d88c4083fa(heli, startingpos) {
  origin = ter_op(isDefined(level.var_f0872e42daf6d4d5), level.var_f0872e42daf6d4d5, heli.origin);
  aitype = scripts\mp\ai_mp_controller::function_7f1a2e2ebe0c1693("ar");
  agent = scripts\mp\ai_mp_controller::ai_mp_requestspawnagent(aitype, origin, heli.angles, "absolute", "mission", "vehicleDriveHeliDriver", undefined, undefined, undefined, self.node.poi, 1, undefined, 0);

  if(!isDefined(agent)) {
    println("<dev string:x1c>");
    return undefined;
  }

  var_b87e69df003b39f5 = heli scripts\common\vehicle_aianim::get_availablepositions();
  agent.script_startingposition = startingpos;
  pos = heli scripts\common\vehicle_aianim::choose_vehicle_position(agent, var_b87e69df003b39f5, 0);
  agent scripts\vehicle\vehicle_common::entervehicle(heli, 1, pos, scripts\common\vehicle_aianim::anim_pos(heli, pos.vehicle_position));
  agent.vehicle_position = pos.vehicle_position;
  agent.goalradius = 10000;
  agent.maxsightdistsqrd = squared(10000);
  agent function_9215ce6fc83759b9(10000);
  agent.ignoreall = 1;
  return agent;
}

function function_c6366a8fc111f210(heli) {
  heli waittill("death");

  if(isDefined(self)) {
    self delete();
  }
}

function function_1659089ce673c063() {
  turret = spawnturret("misc_turret", self gettagorigin("tag_turret"), "chopper_gunner_turret_ballistics_dmz");
  turret setModel("veh9_mil_air_heli_ahotel64_turret");
  turret show();
  turret.angles = self.angles;
  turret.disabled = 0;
  turret.targetstate = undefined;
  turret linkTo(self, "tag_turret");
  turret setturretmodechangewait(0);
  turret setmode("manual");
  turret setdefaultdroppitch(45);
  turret.team = self.team;
  turret.owner = self;
  turret setturretteam(self.team);
  turret setentityowner(self);
  turret.targetent = spawn("script_origin", turret.origin);
  turret settargetentity(turret.targetent);
  self.turret = turret;
  turret.heli = self;
  turret thread function_c6366a8fc111f210(self);
  turret.targetent thread function_c6366a8fc111f210(self);
  return turret;
}

function function_61650f275ef0266f(tag) {
  missilepod = spawn("script_model", self gettagorigin(tag));
  missilepod setModel("ks_chopper_gunner_turret_mp");
  missilepod show();
  missilepod.angles = self.angles;
  missilepod linkTo(self, tag);
  missilepod setotherent(self);
  missilepod.heli = self;
  missilepod thread function_c6366a8fc111f210(self);
  return missilepod;
}

function function_4e9fce9d930cb20b(origin) {
  forwarddot = vectordot(vectorNormalize(origin - self.origin), anglesToForward(self.angles));
  downdot = vectordot(vectorNormalize(origin - self.origin), -1 * anglestoup(self.angles));
  return forwarddot > 0.258819 && downdot > 0 || downdot > 0.95;
}

function function_126e0a76e7532527(origin) {
  forwarddot = vectordot(vectorNormalize(origin - self.origin), anglesToForward(self.angles));
  downdot = vectordot(vectorNormalize(origin - self.origin), -1 * anglestoup(self.angles));
  return forwarddot > 0.4;
}

function function_6034cfedc8242fd6() {
  dist = distance(self.guardvehicle.origin, self.origin);
  return dist < 10000;
}

function function_f21d965808c268bb() {
  self endon("death");
  self endon("flyaway");
  function_1659089ce673c063();
  self.var_bdec9a74b3b2a503 = function_61650f275ef0266f("tag_gun_l");
  self.var_2d5a32b6a40fda8c = function_61650f275ef0266f("tag_gun_r");
  firerate = 0.125;
  accumulatedtime = 0;
  totaltime = 0;
  var_3180e2519441f60a = 40;
  var_9456898cef04f9f8 = var_3180e2519441f60a * firerate;
  var_6faff8a055f809e8 = var_9456898cef04f9f8 / 3;
  var_f1963ad9c17c070f = var_9456898cef04f9f8 - var_6faff8a055f809e8;
  currentmissile = self.var_bdec9a74b3b2a503;
  trackingspeed = getdvarfloat(@ "hash_7301b4fb9b20523d", 375);
  predictiontime = getdvarfloat(@ "hash_1e5806e5fc11f967", 1.33);

  while(self.health > 0) {
    if(!isDefined(self.guardvehicle)) {
      return;
    }

    results = ray_trace(self.origin, self.guardvehicle.origin, [self, self.turret, self.var_bdec9a74b3b2a503, self.var_2d5a32b6a40fda8c, self.guardvehicle]);

    if(distance(results["position"], self.guardvehicle.origin) < 500) {
      self setlookatent(self.guardvehicle);
      var_b46da0e82ed99618 = function_4e9fce9d930cb20b(self.guardvehicle.origin);
      var_7f424c65b880f8ee = function_126e0a76e7532527(self.guardvehicle.origin);

      if(!var_b46da0e82ed99618 && !var_7f424c65b880f8ee) {
        waitframe();
        continue;
      }

      shootturret = undefined;

      if(var_b46da0e82ed99618 && !var_7f424c65b880f8ee) {
        shootturret = 1;
      } else if(!var_b46da0e82ed99618 && var_7f424c65b880f8ee) {
        shootturret = 0;
      } else {
        shootturret = randomfloat(1) > 0.25;
      }

      if(shootturret) {
        shots = 0;
        accumulatedtime = 0;
        totaltime = 0;
        self.turret.targetent.origin = self.guardvehicle.origin;
        velocity = self.guardvehicle vehicle_getvelocity();
        predictedorigin = self.guardvehicle.origin + velocity * 1.75;

        while(shots < var_3180e2519441f60a) {
          if(!isDefined(self.guardvehicle)) {
            return;
          }

          if(totaltime > 5) {
            break;
          }

          if(function_4e9fce9d930cb20b(self.guardvehicle.origin)) {
            results = ray_trace(self.origin, self.guardvehicle.origin, [self, self.turret, self.var_bdec9a74b3b2a503, self.var_2d5a32b6a40fda8c, self.guardvehicle]);

            if(distance(results["position"], self.guardvehicle.origin) < 800) {
              if(totaltime < predictiontime) {
                self.turret.targetent.origin = predictedorigin;
              } else {
                len = min(distance(self.turret.targetent.origin, self.guardvehicle.origin), trackingspeed * level.framedurationseconds);
                diff = vectorNormalize(self.guardvehicle.origin - self.turret.targetent.origin) * len;
                self.turret.targetent.origin += diff;
              }

              if(self.turret turretcantarget(self.turret.targetent.origin)) {
                self.turret snaptotargetentity(self.turret.targetent);
              }

              accumulatedtime += level.framedurationseconds;

              while(accumulatedtime > 0) {
                accumulatedtime -= firerate;
                self.turret shootturret();
                shots++;
              }
            }
          }

          totaltime += level.framedurationseconds;
          waitframe();
        }

        wait 3;
      } else {
        missilepod = self.var_bdec9a74b3b2a503;

        if(currentmissile == self.var_bdec9a74b3b2a503) {
          self.missilefireside = "left";
          self.var_bdec9a74b3b2a503 thread scripts\cp_mp\killstreaks\chopper_gunner::choppergunner_firemissilefx(1);
          missilepod = self.var_bdec9a74b3b2a503;
          currentmissile = self.var_2d5a32b6a40fda8c;
        } else {
          self.missilefireside = "right";
          self.var_2d5a32b6a40fda8c thread scripts\cp_mp\killstreaks\chopper_gunner::choppergunner_firemissilefx(2);
          missilepod = self.var_2d5a32b6a40fda8c;
          currentmissile = self.var_bdec9a74b3b2a503;
        }

        turretviewpos = self.turret gettagorigin("tag_pivot");
        targetpos = self.guardvehicle.origin - self.guardvehicle vehicle_getvelocity() * 0.45;
        var_a437f2b6d33146eb = vectorNormalize(targetpos - turretviewpos);
        missileorigin = missilepod.origin * (1, 1, 0) + (0, 0, turretviewpos[2]);
        missilestart = missileorigin + var_a437f2b6d33146eb * 100;
        missileend = missileorigin + var_a437f2b6d33146eb * 1000;
        missile_ref = "chopper_gunner_proj_dmz";
        missile = scripts\cp_mp\utility\weapon_utility::_magicbullet(makeweapon(missile_ref), missilestart, missileend);
        missile.owner = self;
        wait 0.25;

        if(isDefined(missile)) {
          missile missile_settargetpos(targetpos);
        }

        wait 3;
      }

      continue;
    }

    teammates = getteamdata(self.task.teams[0], "players");

    foreach(player in teammates) {
      if(scripts\mp\utility\player::isaliveandnotinlaststand(player)) {
        results = ray_trace(self.origin, player.origin, [self, self.turret, self.var_bdec9a74b3b2a503, self.var_2d5a32b6a40fda8c, self.guardvehicle]);

        if(distance(results["position"], player.origin) < 100) {
          if(function_4e9fce9d930cb20b(player.origin)) {
            shots = 0;
            accumulatedtime = 0;
            totaltime = 0;
            self.turret.targetent.origin = player.origin;

            while(shots < var_3180e2519441f60a && scripts\mp\utility\player::isaliveandnotinlaststand(player)) {
              if(totaltime > 5) {
                break;
              }

              if(self.health <= 0) {
                return;
              }

              self setlookatent(player);

              if(function_4e9fce9d930cb20b(player.origin)) {
                results = ray_trace(self.origin, player.origin, [self, self.turret, self.var_bdec9a74b3b2a503, self.var_2d5a32b6a40fda8c, self.guardvehicle]);

                if(distance(results["position"], player.origin) < 100) {
                  self.turret.targetent.origin = player.origin;

                  if(self.turret turretcantarget(self.turret.targetent.origin)) {
                    self.turret snaptotargetentity(self.turret.targetent);
                  }

                  accumulatedtime += level.framedurationseconds;

                  while(accumulatedtime > 0) {
                    accumulatedtime -= firerate;
                    self.turret shootturret();
                    shots++;
                  }
                }
              }

              totaltime += level.framedurationseconds;
              waitframe();
            }

            wait 3;
          }
        }

        break;
      }
    }

    waitframe();
  }
}

function function_282ffb050875ade6(vehicle) {
  self endon("death");
  self endon("flyaway");
  self setmaxpitchroll(20, 20);
  self setneargoalnotifydist(150);
  idletick = 0;
  updaterate = 0.5;

  while(true) {
    wait updaterate;

    if(!isDefined(vehicle)) {
      thread function_5eb66c5c1382fed();
      return;
    }

    veh_speed = vehicle vehicle_getspeed();
    idletick = 0;
    currdist = distance2dsquared(self.origin, vehicle.var_52a27c0888f8eab7);
    self vehicle_setspeed(120, 30, 60);
    thread function_a051d3cda138645(vehicle.previousposition + (0, 0, 1000), 1, vehicle);

    if(function_93b8918609703560()) {
      thread function_5eb66c5c1382fed();
      return;
    }
  }
}

function function_595d4ebd73e6b933() {
  self.vehicle endon("death");
  self endon("task_ended");
  self.vehicle.oldpositions = [self.vehicle.origin, self.vehicle.origin, self.vehicle.origin, self.vehicle.origin];
  maxindex = 3;
  var_b413a5de3aa90b12 = 17.6;
  self.vehicle.currindex = 0;

  while(true) {
    speed = self.vehicle vehicle_getspeed();
    forward = vectorNormalize(self.vehicle.origin - self.vehicle.oldpositions[self.vehicle.currindex]);
    self.vehicle.previousposition = self.vehicle.oldpositions[self.vehicle.currindex];
    self.vehicle.var_52a27c0888f8eab7 = self.vehicle.origin + forward * speed * var_b413a5de3aa90b12 * 6;
    self.vehicle.oldpositions[self.vehicle.currindex] = self.vehicle.origin;
    self.vehicle.currindex = ter_op(self.vehicle.currindex < maxindex, self.vehicle.currindex + 1, 0);
    wait 1;
  }
}

function function_57314b27f4592824(data) {
  attacker = data.attacker;

  if(isDefined(attacker) && isDefined(self.turret)) {
    if(isDefined(attacker.owner)) {
      if(attacker.owner == self) {
        return false;
      }
    }

    return (attacker != self.turret);
  }

  return true;
}

function function_499e02474dfc9171(data) {
  function_d98d121db25032b6(self.health - data.damage);
  return true;
}

function function_e6cbc6847a8fb80b(data) {
  thread function_9f77f0a198fce7a3(data);
  return true;
}

function function_9f77f0a198fce7a3(data) {
  function_6b85c01273c49f4d(150, data.objweapon);
  thread function_ce394773c84e2427();
}

function function_d98d121db25032b6(health) {
  if(health < self.maxhealth) {
    if(health < 300) {
      function_53a0f26f479e5869();
      return;
    }

    if(health > 600) {
      function_779eefb705b4f3d9();
      return;
    }

    function_8d8081e3b0352b3c();
  }
}

function function_8d8081e3b0352b3c() {
  self setscriptablepartstate("body_damage_light", "on");
}

function function_779eefb705b4f3d9() {
  self setscriptablepartstate("body_damage_medium", "on");
}

function function_53a0f26f479e5869() {
  self setscriptablepartstate("body_damage_heavy", "on");
}

function function_6b85c01273c49f4d(speed, weaponkilledby) {
  self endon("explode");
  self clearlookatent();
  self notify("crashing");
  self setscriptablepartstate("engine_explosion", "on", 0);
  self setmaxpitchroll(10, 50);
  self vehicle_setspeed(speed, 20, 20);
  self setneargoalnotifydist(100);
  glassdamagestate = "missile_damage";

  if(isDefined(weaponkilledby) && scripts\cp_mp\utility\weapon_utility::isbulletweapon(weaponkilledby)) {
    glassdamagestate = "bullet_damage";
  }

  self setscriptablepartstate("glass", glassdamagestate, 0);
  var_6847739e80fb4e81 = scripts\cp_mp\killstreaks\chopper_gunner::choppergunner_findcrashposition(1250);

  if(!isDefined(var_6847739e80fb4e81)) {
    return;
  }

  self setvehgoalpos(var_6847739e80fb4e81, 0);
  thread scripts\cp_mp\killstreaks\chopper_gunner::choppergunner_spinout(speed);
}

function function_ce394773c84e2427() {
  self notify("explode");

  if(isDefined(self.owner)) {
    self radiusdamage(self.origin, 1000, 200, 200, self.owner, "MOD_EXPLOSIVE", "chopper_gunner_turret_mp");
  }

  self setscriptablepartstate("explode", "on", 0);
  self setscriptablepartstate("explode_smoke", "on", 0);
  wait 0.35;
  function_ac6c07614c22b935();
}

function function_8fe1775245b13b6f(player, missileteam, missiletarget, fxtagoverride) {
  self endon("death");

  while(true) {
    if(!isDefined(missiletarget)) {
      break;
    }

    center = missiletarget getpointinbounds(0, 0, 0);
    curdist = distance(self.origin, center);

    if(curdist < 4000 && missiletarget.flaresreservecount > 0) {
      missiletarget.flaresreservecount--;
      missiletarget thread function_c0afe8bb86f32d06(fxtagoverride);
      newtarget = undefined;

      if(issharedfuncdefined("flares", "deploy")) {
        newtarget = missiletarget[[getsharedfunc("flares", "deploy")]]();
      }

      self.var_afcd53cfa79abccf = 1;
      self missile_settargetEnt(newtarget);
      self notify("missile_pairedWithFlare");
      level notify("flares", player);
      return;
    }

    waitframe();
  }
}

function function_c0afe8bb86f32d06(fxtagoverride) {
  flarestag = "tag_origin";

  if(isDefined(fxtagoverride)) {
    flarestag = fxtagoverride;
  }

  playsoundatpos(self gettagorigin(flarestag), "ks_ac130_flares");
  playFXOnTag(getfx("gunship_flares"), self, flarestag);
}

function function_5eb66c5c1382fed() {
  self endon("death");

  if(istrue(self.var_c1e02d477104abd0)) {
    return;
  }

  self notify("flyaway");
  self.var_c1e02d477104abd0 = 1;
  self vehicle_setspeed(80, 25, 25);
  self setvehgoalpos(self.exitnode.origin, 1);
  self waittill("near_goal");
  function_ac6c07614c22b935();
}

function function_ac6c07614c22b935() {
  scripts\common\vehicle_code::vehicle_deathcleanup();

  if(isDefined(self.turret)) {
    self.turret setentityowner(undefined);
    self.turret delete();

    if(isDefined(self.turret.firetarget)) {
      self.turret.firetarget delete();
    }
  }

  if(isDefined(self.var_bdec9a74b3b2a503)) {
    self.var_bdec9a74b3b2a503 setentityowner(undefined);
    self.var_bdec9a74b3b2a503 delete();
  }

  if(isDefined(self.var_2d5a32b6a40fda8c)) {
    self.var_2d5a32b6a40fda8c setentityowner(undefined);
    self.var_2d5a32b6a40fda8c delete();
  }

  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_deregisterinstance(self);
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}

function private function_93b8918609703560() {
  return false;
}

function private function_3ab365a3526e539(point, numpositions, pathradius) {
  var_a1ae74a22938014d = 360 / numpositions;
  positions = [];
  fwd = (1, 0, 0);
  i = 0;

  while(i < 360) {
    altforward = fwd * pathradius;
    rotatedfwd = (cos(i) * altforward[0] - sin(i) * altforward[1], sin(i) * altforward[0] + cos(i) * altforward[1], altforward[2]);
    pos = point + rotatedfwd;
    position = spawnStruct();
    position.origin = pos;
    z = position function_8c04a86613702b7d();
    position.origin = (position.origin[0], position.origin[1], z);
    positions[positions.size] = position;
    i += var_a1ae74a22938014d;
  }

  return positions;
}

function private function_8c04a86613702b7d() {
  heliheight = getgroundposition(self.origin, 128, 10000, 2000) + (0, 0, 1000);
  return heliheight[2];
}

function private function_a051d3cda138645(goal_pos, stopatgoal, vehicle) {
  self endon("death");
  self endon("flyaway");
  self endon("circle");
  self notify("gotopos");
  self endon("gotopos");
  path = function_30401425c3d8874f(goal_pos, vehicle);

  foreach(index, node in path) {
    if(!isDefined(node) || !isDefined(vehicle)) {
      return;
    }

    if(index == path.size - 1) {
      self setvehgoalpos(node, stopatgoal);
    } else {
      self setvehgoalpos(node);
    }

    angle = (self.angles[0], vectortoangles(vehicle.origin - node)[1], self.angles[2]);
    self function_6d14d24a1888c646(angle, 0, 2, 0.5, 0.2, 2, 1);
    self waittill("near_goal");
  }
}

function private function_30401425c3d8874f(goal_pos, vehicle) {
  path = [];
  dir = vectortoangles(goal_pos - self.origin);
  fwd = anglesToForward(dir);
  dist = length(self.origin - goal_pos);
  currpos = self.origin;
  steps = max(dist / 250, 1);

  for(i = 0; i < steps; i++) {
    if(i > 3) {
      break;
    }

    fwddist = 250;
    newpos = currpos + fwd * fwddist;
    ignore = [self, self.turret, self.var_bdec9a74b3b2a503, self.var_2d5a32b6a40fda8c];

    for(heightstep = 0; heightstep < 5; heightstep++) {
      trace = scripts\engine\trace::sphere_get_closest_point(newpos, 400, 0, ignore);

      if(isDefined(trace["hittype"]) && trace["hittype"] != "hittype_none") {
        newpos += (0, 0, 125);
        continue;
      }

      break;
    }

    heliorigin = currpos;

    for(heightstep = 0; heightstep < 5; heightstep++) {
      trace = scripts\engine\trace::sphere_get_closest_point(heliorigin, 400, 0, ignore);

      if(isDefined(trace["hittype"]) && trace["hittype"] != "hittype_none") {
        heliorigin += (0, 0, 125) + fwd * -50;
        continue;
      }

      break;
    }

    trace = scripts\engine\trace::ray_trace(heliorigin, newpos, ignore, undefined, undefined, 1, 1);

    if(isDefined(trace["hittype"]) && trace["hittype"] != "hittype_none") {
      path[path.size] = heliorigin;
    } else {
      path[path.size] = heliorigin;
      path[path.size] = newpos;
    }

    currpos = path[path.size - 1];
  }

  path = function_521e6d5a9479e771(path);
  return path;
}

function function_521e6d5a9479e771(path) {
  thresh = 100;

  foreach(index, node in path) {
    if(index == path.size - 1) {
      break;
    }

    diff = path[index + 1][2] - node[2];

    if(diff > thresh) {
      node += (0, 0, node[2] + diff / 2);
    }
  }

  return path;
}

function function_57dd2a79f8ad4fee(pos) {
  if(!isDefined(level.var_6b278dce447d6034)) {
    return undefined;
  }

  closest = getclosest(pos, level.var_6b278dce447d6034);

  if(isDefined(closest) && distancesquared(closest.origin, pos) <= squared(closest.radius)) {
    return closest;
  }

  return undefined;
}