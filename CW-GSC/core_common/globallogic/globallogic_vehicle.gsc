/***********************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\globallogic\globallogic_vehicle.gsc
***********************************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\battlechatter;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\contracts_shared;
#using scripts\core_common\damagefeedback_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\gamestate_util;
#using scripts\core_common\globallogic\globallogic_player;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\loadout_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\weapons_shared;
#using scripts\weapons\weapon_utils;
#namespace globallogic_vehicle;

function callback_vehiclespawned(spawner) {
  if(self.var_dd74f4a9) {
    self.health = self.healthdefault;
  }

  if(isDefined(level.vehicle_main_callback)) {
    if(isDefined(level.vehicle_main_callback[self.vehicletype])) {
      self thread[[level.vehicle_main_callback[self.vehicletype]]]();
    } else if(isDefined(self.scriptvehicletype) && isDefined(level.vehicle_main_callback[self.scriptvehicletype])) {
      self thread[[level.vehicle_main_callback[self.scriptvehicletype]]]();
    }
  }

  if(isDefined(level.a_str_vehicle_spawn_custom_keys)) {
    foreach(str_key in level.a_str_vehicle_spawn_custom_keys) {
      if(isDefined(spawner)) {
        if(isDefined(spawner.(str_key))) {
          str_value = spawner.(str_key);
        }
      } else if(isDefined(self.(str_key))) {
        str_value = self.(str_key);
      }

      a_key_spawn_funcs = level.("a_str_vehicle_spawn_key_" + str_key);

      if(isDefined(str_value) && isDefined(a_key_spawn_funcs[str_value])) {
        foreach(func in a_key_spawn_funcs[str_value]) {
          util::single_thread(self, func[# "function"], func[# "param1"], func[# "param2"], func[# "param3"], func[# "param4"]);
        }
      }
    }
  }

  self.spawner = spawner;

  if(issentient(self)) {
    self spawner::spawn_think(spawner);
  }

  if(self.vehicletype != # "zm_zod_train") {
    vehicle::init(self);
  }

  self thread function_a8f929b0();
  vehicle::function_e2a44ff1(self);
  self flag::set(#"vehicle_spawn_setup_complete");
}

function function_a8f929b0() {
  if(isDefined(self.ai_forceslots) && self.ai_forceslots >= 0 && self.ai_forceslots < 2) {
    level flag::wait_till("all_players_spawned");
    a_e_players = getplayers(self.team);

    if(isDefined(a_e_players[self.ai_forceslots])) {
      self.owner = a_e_players[self.ai_forceslots];
    }
  }
}

function isfriendlyfire(eself, eattacker) {
  if(!isDefined(eattacker)) {
    return false;
  }

  if(isDefined(level.friendlyfire) && level.friendlyfire > 0) {
    return false;
  }

  var_b423c7f3 = 1;

  if(isDefined(eself.var_20c71d46) && isDefined(eself.owner) && eself.owner == eattacker) {
    var_b423c7f3 = 0;
  }

  if(var_b423c7f3) {
    occupant_team = eself vehicle::vehicle_get_occupant_team();

    if(occupant_team != # "none" && occupant_team != # "neutral" && (!util::function_fbce7263(occupant_team, eattacker.team) || util::function_9b7092ef(occupant_team, eattacker.team))) {
      return true;
    }
  }

  if(!level.hardcoremode && isDefined(eself.owner) && eself.owner === eattacker.owner && !isDefined(eself.var_20c71d46)) {
    return true;
  }

  return false;
}

function callback_vehicledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  eattacker = globallogic_player::figureoutattacker(eattacker);
  params = spawnStruct();
  params.einflictor = einflictor;
  params.eattacker = eattacker;
  params.idamage = idamage;
  params.idflags = idflags;
  params.smeansofdeath = smeansofdeath;
  params.weapon = weapon;
  params.var_fd90b0bb = var_fd90b0bb;
  params.vpoint = vpoint;
  params.vdir = vdir;
  params.shitloc = shitloc;
  params.vdamageorigin = vdamageorigin;
  params.psoffsettime = psoffsettime;
  params.damagefromunderneath = damagefromunderneath;
  params.modelindex = modelindex;
  params.partname = partname;
  params.vsurfacenormal = vsurfacenormal;
  params.isselfdestruct = eattacker === self || eattacker === self.owner && self.selfdestruct === 1;
  params.friendlyfire = !params.isselfdestruct && isfriendlyfire(self, eattacker);

  if(!isDefined(self.maxhealth)) {
    self.maxhealth = self.healthdefault;
  }

  if(gamestate::is_game_over()) {
    avoid_damage_in_postgame = !sessionmodeismultiplayergame() && !sessionmodeiswarzonegame();

    if(avoid_damage_in_postgame) {
      return;
    }
  }

  if(!(1 &idflags)) {
    idamage = loadout::cac_modified_vehicle_damage(self, eattacker, idamage, smeansofdeath, weapon, einflictor);
  }

  if(idamage == 0) {
    return;
  }

  if(!isDefined(vdir)) {
    idflags |= 4;
  }

  self.idflags = idflags;
  self.idflagstime = gettime();

  if(self.health == self.maxhealth || !isDefined(self.attackers)) {
    self.attackers = [];
    self.attackerdata = [];
    self.attackerdamage = [];
  }

  if(weapon == level.weaponnone && isDefined(einflictor)) {
    if(isDefined(einflictor.targetname) && einflictor.targetname == "explodable_barrel") {
      weapon = getweapon(#"explodable_barrel");
    } else if(isDefined(einflictor.destructible_type) && issubstr(einflictor.destructible_type, "vehicle_")) {
      weapon = getweapon(#"destructible_car");
    }
  }

  if(smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_GRENADE") {
    idamage *= weapon.vehicleprojectiledamagescalar;
  }

  idamage *= level.vehicledamagescalar;
  idamage *= self getvehdamagemultiplier(self.idflags, smeansofdeath, weapon, eattacker);

  if(isDefined(level.var_c31df7cf) && weapon === level.var_c31df7cf && weapons::isexplosivedamage(smeansofdeath) && isDefined(self.var_f22b9fe4) && self.var_f22b9fe4 > 0) {
    idamage = int(self.healthdefault / self.var_f22b9fe4);
  }

  idamage = weapons::function_74bbb3fa(idamage, weapon, self);
  idamage = int(idamage);
  unmodified = idamage;

  if(isDefined(einflictor.var_e744cea3)) {
    idamage = self[[einflictor.var_e744cea3]](einflictor, eattacker, idamage, self.idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
  }

  if(isDefined(self.overridevehicledamage)) {
    idamage = self[[self.overridevehicledamage]](einflictor, eattacker, idamage, self.idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
  } else if(isDefined(level.overridevehicledamage)) {
    idamage = self[[level.overridevehicledamage]](einflictor, eattacker, idamage, self.idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
  }

  if(isDefined(self.aioverridedamage)) {
    for(index = 0; index < self.aioverridedamage.size; index++) {
      damagecallback = self.aioverridedamage[index];
      idamage = self[[damagecallback]](einflictor, eattacker, idamage, self.idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
    }
  }

  if(self.idflags & 8192 && idamage < unmodified) {
    idamage = unmodified;
  }

  assert(isDefined(idamage), "<dev string:x38>");

  if(idamage == 0) {
    return;
  }

  damageteammates = 0;

  if(!(self.idflags & 8192)) {
    if(self isvehicleimmunetodamage(smeansofdeath)) {
      return;
    }

    if(params.friendlyfire) {
      if(!allowfriendlyfiredamage(einflictor, eattacker, smeansofdeath, weapon)) {
        return;
      }

      damageteammates = 1;
    }
  }

  if(idamage < 1) {
    idamage = 1;
  }

  params.idamage = int(idamage);
  params.idflags = self.idflags;

  if(issentient(self)) {
    self callback::callback(#"on_ai_damage", params);
  }

  self callback::callback(#"on_vehicle_damage", params);
  idamage = int(idamage);

  if(isDefined(eattacker) && isPlayer(eattacker) && isDefined(eattacker.pers)) {
    if(!isDefined(eattacker.pers[# "participation"])) {
      eattacker.pers[# "participation"] = 0;
    }

    if(gamestate::is_state(#"playing")) {
      eattacker.pers[# "participation"]++;
    }
  }

  if(is_true(self.var_39c1458c)) {
    if(isDefined(self.var_3daa0191)) {
      self[[self.var_3daa0191]](einflictor, eattacker, idamage, self.idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
    } else {
      driver = self getseatoccupant(0);

      if(isDefined(driver) && isPlayer(driver) && !isbot(driver)) {
        damagepct = idamage / self.maxhealth;
        damagepct = int(max(damagepct, 3));

        if(isDefined(eattacker) || isDefined(einflictor)) {
          driver addtodamageindicator(damagepct, vdir);
        } else {
          driver addtodamageindicator(damagepct, undefined);
        }
      } else {
        gunner = self getseatoccupant(1);

        if(isDefined(gunner) && isPlayer(gunner) && !isbot(gunner)) {
          damagepct = idamage / self.maxhealth;
          damagepct = int(max(damagepct, 3));

          if(isDefined(eattacker) || isDefined(einflictor)) {
            gunner addtodamageindicator(damagepct, vdir);
          } else {
            gunner addtodamageindicator(damagepct, undefined);
          }
        }
      }
    }
  }

  var_5370b15e = idamage < self.health ? idamage : self.health;
  self globallogic_player::giveattackerandinflictorownerassist(eattacker, einflictor, var_5370b15e, smeansofdeath, weapon, shitloc);

  if(isPlayer(eattacker) && isDefined(level.challenges_callback_vehicledamaged)) {
    self thread[[level.challenges_callback_vehicledamaged]](eattacker, eattacker, idamage, weapon, shitloc);
  }

  selfentnum = self getentitynumber();
  occupants = self getvehoccupants();

  if(isDefined(occupants) && occupants.size > 0) {
    if(smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_PROJECTILE_SPLASH") {
      if(isDefined(self.scriptbundlesettings)) {
        if(!isDefined(self.settings)) {
          self.settings = getscriptbundle(self.scriptbundlesettings);
        }

        if(isDefined(self.settings.var_2cc03de3)) {
          self clientfield::increment("rocket_damage_rumble");
        }
      }
    }
  }

  if(idamage >= self.health && isDefined(einflictor) && einflictor getentitytype() == 4) {
    if(isDefined(self.scriptbundlesettings)) {
      if(!isDefined(self.settings)) {
        self.settings = getscriptbundle(self.scriptbundlesettings);
      }

      if(isDefined(self.settings.var_45b17e9c) && isDefined(vpoint)) {
        var_74d40edb = einflictor getvelocity();

        if(lengthsquared(var_74d40edb) > sqr(50)) {
          var_29edfc10 = vectornormalize(var_74d40edb);
          playFX(self.settings.var_45b17e9c, vpoint, var_29edfc10);
        }
      }
    }
  }

  self finishvehicledamage(einflictor, eattacker, idamage, self.idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname, damageteammates);

  if(isDefined(eattacker) && (!isDefined(params.isselfdestruct) || !params.isselfdestruct) && self.nodamagefeedback !== 1) {
    if(damagefeedback::dodamagefeedback(weapon, einflictor)) {
      eattacker thread damagefeedback::update(smeansofdeath, einflictor, undefined, weapon, self, psoffsettime, shitloc, 0);
    }
  }

  if(getdvarint(#"g_debugdamage", 0)) {
    println("<dev string:x74>" + selfentnum + "<dev string:x80>" + self.health + "<dev string:x8c>" + (isDefined(eattacker.clientid) ? eattacker.clientid : -1) + "<dev string:x9a>" + isPlayer(einflictor) + "<dev string:xb3>" + idamage + "<dev string:xbf>" + shitloc);
  }
}

function callback_vehicleradiusdamage(einflictor, eattacker, idamage, finnerdamage, fouterdamage, idflags, smeansofdeath, weapon, vpoint, fradius, fconeanglecos, vconedir, psoffsettime) {
  idamage = loadout::cac_modified_vehicle_damage(self, eattacker, idamage, smeansofdeath, weapon, einflictor);
  finnerdamage = loadout::cac_modified_vehicle_damage(self, eattacker, finnerdamage, smeansofdeath, weapon, einflictor);
  fouterdamage = loadout::cac_modified_vehicle_damage(self, eattacker, fouterdamage, smeansofdeath, weapon, einflictor);
  self.idflags = idflags;
  self.idflagstime = gettime();
  isselfdestruct = eattacker === self || eattacker === self.owner && self.selfdestruct === 1;
  friendlyfire = !isselfdestruct && isfriendlyfire(self, eattacker);

  if(gamestate::is_game_over()) {
    return;
  }

  if(smeansofdeath == "MOD_PROJECTILE_SPLASH" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_EXPLOSIVE") {
    scalar = weapon.vehicleprojectilesplashdamagescalar;
    idamage = int(idamage * scalar);
    finnerdamage *= scalar;
    fouterdamage *= scalar;

    if(finnerdamage == 0) {
      return;
    }
  }

  idamage *= self getvehdamagemultiplier(self.idflags, smeansofdeath, weapon);
  idamage = int(idamage);

  if(idamage == 0) {
    return;
  }

  if(!(self.idflags & 8192)) {
    if(self isvehicleimmunetodamage(smeansofdeath)) {
      return;
    }

    if(friendlyfire) {
      if(!allowfriendlyfiredamage(einflictor, eattacker, smeansofdeath, weapon)) {
        return;
      }
    }
  }

  if(idamage < 1) {
    idamage = 1;
  }

  self finishvehicleradiusdamage(einflictor, eattacker, idamage, finnerdamage, fouterdamage, self.idflags, smeansofdeath, weapon, vpoint, fradius, fconeanglecos, vconedir, psoffsettime);
}

function callback_vehiclekilled(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
  if(gamestate::is_game_over()) {
    return;
  }

  params = spawnStruct();
  params.einflictor = einflictor;
  params.eattacker = eattacker;
  params.idamage = idamage;
  params.smeansofdeath = smeansofdeath;
  params.weapon = weapon;
  params.vdir = vdir;
  params.shitloc = shitloc;
  params.psoffsettime = psoffsettime;
  params.occupants = self getvehoccupants();
  eattacker = globallogic_player::figureoutattacker(eattacker);

  if(isDefined(eattacker) && isPlayer(eattacker) && !is_true(level.var_7c6454)) {
    globallogic_score::inctotalkills(eattacker.team);
    eattacker thread globallogic_score::givekillstats(smeansofdeath, weapon, self);
  }

  if(isai(eattacker) && isDefined(eattacker.script_owner)) {
    if(eattacker.script_owner.team != self.team) {
      eattacker = eattacker.script_owner;
    }
  }

  if(isDefined(eattacker) && isDefined(eattacker.onkill)) {
    eattacker[[eattacker.onkill]](self);
  }

  if(isDefined(einflictor)) {
    self.damageinflictor = einflictor;
  }

  if(issentient(self)) {
    self callback::callback(#"on_ai_killed", params);
  }

  self callback::callback(#"on_vehicle_killed", params);

  if(isDefined(self.overridevehiclekilled)) {
    self[[self.overridevehiclekilled]](einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
  }

  if(isDefined(einflictor.var_3f9bd15)) {
    self[[einflictor.var_3f9bd15]](einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, params.occupants);
  }

  player = eattacker;

  if(isDefined(eattacker) && isDefined(eattacker.classname) && eattacker.classname == "script_vehicle" && isDefined(eattacker.owner)) {
    player = eattacker.owner;
  }

  if(sessionmodeiscampaigngame()) {
    if(isDefined(player) && isPlayer(player) && isalive(player)) {
      if(weapon.isheavyweapon) {
        battlechatter::heavyweaponkilllogic(eattacker, weapon, undefined);
      } else {
        enemykilled_cooldown = "enemy_killed_vo_" + string(player.team);

        if(level util::iscooldownready(enemykilled_cooldown)) {
          level util::cooldown(enemykilled_cooldown, 4);
          player battlechatter::play_dialog("killenemy", 1);
          level util::addcooldowntime(enemykilled_cooldown, 4);
        }
      }
    }

    if(isDefined(player) && isPlayer(player) && !is_true(self.disable_score_events)) {
      if(!level.teambased || util::function_fbce7263(self.team, player.pers[# "team"])) {
        if(smeansofdeath == "MOD_MELEE" || smeansofdeath == "MOD_MELEE_ASSASSINATE") {
          scoreevents::processscoreevent(#"melee_kill" + self.scoretype, player, self, weapon);
        } else {
          scoreevents::processscoreevent(#"kill" + self.scoretype, player, self, weapon);
        }

        if(isDefined(level.challenges_callback_vehiclekilled)) {
          self thread[[level.challenges_callback_vehiclekilled]](einflictor, player, idamage, smeansofdeath, weapon, shitloc);
        }

        self vehiclekilled_awardassists(einflictor, eattacker, weapon, eattacker.team);
      }
    }

    if(isDefined(eattacker) && (!isDefined(params.isselfdestruct) || !params.isselfdestruct) && (!isDefined(self.nodamagefeedback) || self.nodamagefeedback !== 1)) {
      if(damagefeedback::dodamagefeedback(weapon, einflictor)) {
        eattacker thread damagefeedback::update(smeansofdeath, einflictor, undefined, weapon, self, psoffsettime, shitloc, 0);
      }
    }

    return;
  }

  if(isDefined(level.challenges_callback_vehiclekilled)) {
    self thread[[level.challenges_callback_vehiclekilled]](einflictor, player, idamage, smeansofdeath, weapon, shitloc);
  }

  if(sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) {
    if(isPlayer(player)) {
      vehicleteam = undefined;

      if(isDefined(self.team)) {
        if(self.team != # "neutral") {
          vehicleteam = self.team;
        } else if(isDefined(self.var_37f0c900)) {
          if(self.var_37f0c900.time == gettime()) {
            vehicleteam = self.var_37f0c900.team;
          }

          self.var_37f0c900 = undefined;
        }
      }

      if(isDefined(vehicleteam) && util::function_fbce7263(vehicleteam, player.pers[# "team"])) {
        if(self.weapon.var_62c1bfaa !== 1) {
          player stats::function_a431be09(weapon);

          if(player isinvehicle()) {
            attackervehicle = player getvehicleoccupied();

            if(isDefined(attackervehicle.scriptvehicletype)) {
              player stats::function_7fd36562(attackervehicle.scriptvehicletype, #"destructions", 1);
            }
          }

          if(player hastalent(#"talent_engineer")) {
            scoreevents::processscoreevent(#"hash_78f6e45d08abe0db", player);
            player contracts::increment_contract(#"hash_448a34bf383a87a6", 1);
          }
        }
      }
    }
  }
}

function function_67e86f71(vec) {
  inverse = 0.0568182;
  return (vec[0] * inverse, vec[1] * inverse, vec[2] * inverse);
}

function function_621234f9(eattacker, einflictor) {
  vehicle = einflictor;

  if(!isvehicle(vehicle)) {
    vehicle = eattacker;
  }

  if(isvehicle(vehicle)) {
    if(isDefined(self) && is_true(self.var_6cdeac5e) && is_true(vehicle.var_2b60f92f)) {
      return;
    }

    velocity = function_67e86f71(vehicle getvelocity());
    speedscale = length(velocity) / 30;
    forwardvec = vectornormalize(velocity);
    upvec = (0, 0, 1);
    leftvec = vectornormalize(vectorcross(upvec, forwardvec));
    forwardscale = speedscale * randomfloatrange(50, 65);
    upscale = speedscale * randomfloatrange(35, 55);
    leftscale = speedscale * randomfloatrange(-25, 25);
    force = velocity + forwardvec * forwardscale + upvec * upscale + leftvec * leftscale;
    var_3e6c815d = length(force);
    force = vectornormalize(force) * math::clamp(var_3e6c815d, 5, 250);
    waitframe(2);

    if(isDefined(self)) {
      self startragdoll();
      self launchragdoll(force);
    }
  }
}

function vehiclecrush(eattacker, einflictor) {
  self endon(#"disconnect");

  if(isDefined(level._effect) && isDefined(level._effect[# "tanksquish"])) {
    playFX(level._effect[# "tanksquish"], self.origin + (0, 0, 30));
  }

  self playSound(#"chr_crunch");
  self thread function_621234f9(eattacker, einflictor);
}

function allowfriendlyfiredamage(einflictor, eattacker, smeansofdeath, weapon) {
  if(getdvarint(#"g_vehiclebypassfriendlyfire", 0) != 0) {
    return 1;
  }

  if(is_true(self.skipfriendlyfirecheck)) {
    return 1;
  }

  if(isDefined(self.allowfriendlyfiredamageoverride)) {
    return [[self.allowfriendlyfiredamageoverride]](einflictor, eattacker, smeansofdeath, weapon);
  }

  return 0;
}

function vehiclekilled_awardassists(einflictor, eattacker, weapon, lpattackteam) {
  if(!isDefined(self.scoretype) || self.scoretype == "none") {
    return;
  }

  if(isDefined(self.attackers)) {
    for(j = 0; j < self.attackers.size; j++) {
      player = self.attackers[j];

      if(!isDefined(player)) {
        continue;
      }

      if(player == weapon) {
        continue;
      }

      if(player.team != lpattackteam) {
        continue;
      }

      damage_done = self.attackerdamage[player.clientid].damage;
      time = self.attackerdamage[player.clientid].time;
      meansofdeath = self.attackerdamage[player.clientid].meansofdeath;
      player thread globallogic_score::processassist(self, damage_done, self.attackerdamage[player.clientid].weapon, "assist" + self.scoretype, time, meansofdeath);
    }
  }
}