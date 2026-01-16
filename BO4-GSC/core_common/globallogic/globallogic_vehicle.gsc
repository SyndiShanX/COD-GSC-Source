/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\globallogic\globallogic_vehicle.gsc
***********************************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\damagefeedback_shared;
#include scripts\core_common\dialog_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\gameobjects_shared;
#include scripts\core_common\gamestate;
#include scripts\core_common\globallogic\globallogic_player;
#include scripts\core_common\globallogic\globallogic_score;
#include scripts\core_common\loadout_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\scoreevents_shared;
#include scripts\core_common\spawner_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\vehicle_shared;
#include scripts\core_common\weapons_shared;
#include scripts\weapons\weapon_utils;

#namespace globallogic_vehicle;

callback_vehiclespawned(spawner) {
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
          util::single_thread(self, func[#"function"], func[#"param1"], func[#"param2"], func[#"param3"], func[#"param4"]);
        }
      }
    }
  }

  self.spawner = spawner;

  if(issentient(self)) {
    self spawner::spawn_think(spawner);
  }

  if(self.vehicletype != #"zm_zod_train") {
    vehicle::init(self);
  }

  self thread function_a8f929b0();
  vehicle::function_e2a44ff1(self);
  self flagsys::set(#"vehicle_spawn_setup_complete");
}

function_a8f929b0() {
  if(isDefined(self.ai_forceslots) && self.ai_forceslots >= 0 && self.ai_forceslots < 2) {
    level flagsys::wait_till("all_players_spawned");
    a_e_players = util::get_players(self.team);

    if(isDefined(a_e_players[self.ai_forceslots])) {
      self.owner = a_e_players[self.ai_forceslots];
    }
  }
}

isfriendlyfire(eself, eattacker) {
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

    if(occupant_team != "free" && occupant_team != "neutral" && (!util::function_fbce7263(occupant_team, eattacker.team) || util::function_9b7092ef(occupant_team, eattacker.team))) {
      return true;
    }
  }

  if(!level.hardcoremode && isDefined(eself.owner) && eself.owner === eattacker.owner && !isDefined(eself.var_20c71d46)) {
    return true;
  }

  return false;
}

callback_vehicledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  params = spawnStruct();
  params.einflictor = einflictor;
  params.eattacker = eattacker;
  params.idamage = idamage;
  params.idflags = idflags;
  params.smeansofdeath = smeansofdeath;
  params.weapon = weapon;
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

  if(!(1&idflags)) {
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
  } else if(smeansofdeath == "MOD_GRENADE_SPLASH") {
    idamage *= getvehicleunderneathsplashscalar(weapon);
  }

  idamage *= level.vehicledamagescalar;
  idamage *= self getvehdamagemultiplier(smeansofdeath);

  if(isDefined(level.var_c31df7cf) && weapon === level.var_c31df7cf && weapon_utils::isexplosivedamage(smeansofdeath) && isDefined(self.var_f22b9fe4) && self.var_f22b9fe4 > 0) {
    idamage = int(self.healthdefault / self.var_f22b9fe4);
  }

  idamage = weapons::function_74bbb3fa(idamage, weapon, self);
  idamage = int(idamage);
  unmodified = idamage;

  if(isDefined(self.overridevehicledamage)) {
    idamage = self[[self.overridevehicledamage]](einflictor, eattacker, idamage, self.idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
  } else if(isDefined(level.overridevehicledamage)) {
    idamage = self[[level.overridevehicledamage]](einflictor, eattacker, idamage, self.idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
  }

  if(isDefined(self.aioverridedamage)) {
    for(index = 0; index < self.aioverridedamage.size; index++) {
      damagecallback = self.aioverridedamage[index];
      idamage = self[[damagecallback]](einflictor, eattacker, idamage, self.idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
    }
  }

  if(self.idflags&8192 && idamage < unmodified) {
    idamage = unmodified;
  }

  assert(isDefined(idamage), "<dev string:x38>");

  if(idamage == 0) {
    return;
  }

  damageteammates = 0;

  if(!(self.idflags&8192)) {
    if(self isvehicleimmunetodamage(self.idflags, smeansofdeath, weapon)) {
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

  if(isDefined(eattacker) && isplayer(eattacker) && isDefined(eattacker.pers)) {
    if(!isDefined(eattacker.pers[#"participation"])) {
      eattacker.pers[#"participation"] = 0;
    }

    if(gamestate::is_state("playing")) {
      eattacker.pers[#"participation"]++;
    }
  }

  if(!(isDefined(self.var_92043a49) && self.var_92043a49)) {
    driver = self getseatoccupant(0);

    if(isDefined(driver) && isplayer(driver) && !isbot(driver)) {
      damagepct = idamage / self.maxhealth;
      damagepct = int(max(damagepct, 3));
      driver addtodamageindicator(damagepct, vdir);
    } else {
      gunner = self getseatoccupant(1);

      if(isDefined(gunner) && isplayer(gunner) && !isbot(gunner)) {
        damagepct = idamage / self.maxhealth;
        damagepct = int(max(damagepct, 3));
        gunner addtodamageindicator(damagepct, vdir);
      }
    }
  }

  var_5370b15e = idamage < self.health ? idamage : self.health;
  self globallogic_player::giveattackerandinflictorownerassist(eattacker, einflictor, var_5370b15e, smeansofdeath, weapon);

  if(isplayer(eattacker) && isDefined(level.challenges_callback_vehicledamaged)) {
    self thread[[level.challenges_callback_vehicledamaged]](eattacker, eattacker, idamage, weapon, shitloc);
  }

  selfentnum = self getentitynumber();
  self finishvehicledamage(einflictor, eattacker, idamage, self.idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname, damageteammates);

  if(isDefined(eattacker) && (!isDefined(params.isselfdestruct) || !params.isselfdestruct) && self.nodamagefeedback !== 1) {
    if(damagefeedback::dodamagefeedback(weapon, einflictor)) {
      eattacker thread damagefeedback::update(smeansofdeath, einflictor, undefined, weapon, self, psoffsettime, shitloc, 0);
    }
  }

  if(getdvarint(#"g_debugdamage", 0)) {
    println("<dev string:x73>" + selfentnum + "<dev string:x7e>" + self.health + "<dev string:x89>" + eattacker.clientid + "<dev string:x96>" + isplayer(einflictor) + "<dev string:xae>" + idamage + "<dev string:xb9>" + shitloc);
  }

}

callback_vehicleradiusdamage(einflictor, eattacker, idamage, finnerdamage, fouterdamage, idflags, smeansofdeath, weapon, vpoint, fradius, fconeanglecos, vconedir, psoffsettime) {
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

  if(idamage == 0) {
    return;
  }

  if(!(self.idflags&8192)) {
    if(self isvehicleimmunetodamage(self.idflags, smeansofdeath, weapon)) {
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

callback_vehiclekilled(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
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

  if(isDefined(eattacker) && isplayer(eattacker) && !(isDefined(level.var_7c6454) && level.var_7c6454)) {
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

  player = eattacker;

  if(isDefined(eattacker) && isDefined(eattacker.classname) && eattacker.classname == "script_vehicle" && isDefined(eattacker.owner)) {
    player = eattacker.owner;
  }

  if(sessionmodeiscampaigngame()) {
    if(isDefined(player) && isplayer(player) && isalive(player)) {
      if(weapon.isheavyweapon) {
        dialog_shared::heavyweaponkilllogic(eattacker, weapon, undefined);
      } else {
        enemykilled_cooldown = "enemy_killed_vo_" + string(player.team);

        if(level util::iscooldownready(enemykilled_cooldown)) {
          level util::cooldown(enemykilled_cooldown, 4);
          player dialog_shared::play_dialog("killenemy", 1);
          level util::addcooldowntime(enemykilled_cooldown, 4);
        }
      }
    }

    if(isDefined(player) && isplayer(player) && !(isDefined(self.disable_score_events) && self.disable_score_events)) {
      if(!level.teambased || util::function_fbce7263(self.team, player.pers[#"team"])) {
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
  }
}

function_67e86f71(vec) {
  inverse = 0.0568182;
  return (vec[0] * inverse, vec[1] * inverse, vec[2] * inverse);
}

vehiclecrush(eattacker, einflictor) {
  self endon(#"disconnect");

  if(isDefined(level._effect) && isDefined(level._effect[#"tanksquish"])) {
    playFX(level._effect[#"tanksquish"], self.origin + (0, 0, 30));
  }

  self playSound(#"chr_crunch");
  vehicle = einflictor;

  if(!isvehicle(vehicle)) {
    vehicle = eattacker;
  }

  if(isvehicle(vehicle)) {
    velocity = function_67e86f71(vehicle getvelocity());
    speedscale = length(velocity) / 30;
    forwardvec = vectornormalize(velocity);
    upvec = (0, 0, 1);
    leftvec = vectornormalize(vectorcross(upvec, forwardvec));
    forwardscale = speedscale * randomfloatrange(50, 150);
    upscale = speedscale * randomfloatrange(50, 75);
    leftscale = speedscale * randomfloatrange(-25, 25);
    force = velocity + forwardvec * forwardscale + upvec * upscale + leftvec * leftscale;
    var_3e6c815d = length(force);
    force = vectornormalize(force) * math::clamp(var_3e6c815d, 5, 250);
    self launchragdoll(force);
  }
}

getvehicleunderneathsplashscalar(weapon) {
  if(weapon.name == #"satchel_charge") {
    scale = 10;
    scale *= 3;
  } else {
    scale = 1;
  }

  return scale;
}

allowfriendlyfiredamage(einflictor, eattacker, smeansofdeath, weapon) {
  if(getdvarint(#"g_vehiclebypassfriendlyfire", 0) != 0) {
    return 1;
  }

  if(isDefined(self.skipfriendlyfirecheck) && self.skipfriendlyfirecheck) {
    return 1;
  }

  if(isDefined(self.allowfriendlyfiredamageoverride)) {
    return [[self.allowfriendlyfiredamageoverride]](einflictor, eattacker, smeansofdeath, weapon);
  }

  return 0;
}

vehiclekilled_awardassists(einflictor, eattacker, weapon, lpattackteam) {
  pixbeginevent(#"hash_1ec5cd32e99d8672");

  if(!isDefined(self.scoretype) || self.scoretype == "none") {
    return;
  }

  if(isDefined(self.attackers)) {
    for(j = 0; j < self.attackers.size; j++) {
      player = self.attackers[j];

      if(!isDefined(player)) {
        continue;
      }

      if(player == eattacker) {
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

  pixendevent();
}