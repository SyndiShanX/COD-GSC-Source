/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\equipment\cp_at_mine.gsc
***********************************************/



#using scripts\common\utility;
#using scripts\cp\cp_deployablebox;
#using scripts\cp\cp_player_battlechatter;
#using scripts\cp\damagefeedback;
#using scripts\cp\equipment;
#using scripts\cp\utility;
#using scripts\cp\utility\player;
#using scripts\cp\weapon;
#using scripts\cp_mp\equipment;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle_mines;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace cp_at_mine;

function at_mine_init() {
  while(!isDefined(level.vehicle) || !isDefined(level.vehicle.minetriggerdata)) {
    waitframe();
  }

  var_f16af5a8c61c30ee = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataformine("equip_at_mine", 1);
  var_f16af5a8c61c30ee.radius = 100;
  var_f16af5a8c61c30ee.triggercallback = &at_mine_vehicle_trigger;

  setdevdvarifuninitialized(@ "hash_e67a08119163320a", 0);
}

function at_mine_use(grenade) {
  self endon("death");
  self endon("disconnect");
  grenade endon("death");
  grenade.grenade_owner_name = self.name;
  thread monitordisownedequipment(self, grenade);
  grenade thread at_mine_watch_game_end();
  grenade setscriptablepartstate("visibility", "show", 0);
  grenade waittill("missile_stuck", stuckto);

  if(isDefined(stuckto)) {
    grenade linkTo(stuckto);
  }

  thread at_mine_plant(grenade);
}

function at_mine_plant(grenade) {
  grenade endon("mine_destroyed");
  grenade endon("death");

  if(isPlayer(self)) {
    self endon("disconnect");
  }

  if(isPlayer(self)) {
    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(self, #"bc_equipment_action_proxmine");
    grenade setotherent(self);
    grenade setentityowner(self);
  }

  grenade missilethermal();
  grenade missileoutline();
  grenade setnodeploy(1);
  grenade setscriptablepartstate("plant", "active", 0);
  grenade enableplayermarks("equipment");

  if(isPlayer(self)) {
    self setscriptablepartstate("equipATMineFXView", "plant", 0);
    onlethalequipmentplanted(grenade, "equip_at_mine", 1);
    thread monitordisownedequipment(self, grenade);
  } else {
    level thread add_to_mine_list(grenade);
  }

  pickup_str = spawnStruct();
  pickup_str.scriptablename = "brloot_offhand_atmine";
  pickup_str.equipname = level.br_pickups.br_equipname[pickup_str.scriptablename];
  pickup_str.maxcount = grenade.owner scripts\cp_mp\equipment::getequipmentmaxammo(pickup_str.equipname);
  pickup_str.count = 1;
  pickup_str.origin = grenade.origin;
  grenade thread makeexplosiveusabletag("tag_use", 1, undefined, pickup_str);
  grenade thread minedamagemonitor();
  grenade thread at_mine_watch_detonate();
  grenade thread at_mine_watch_emp();
  grenade thread remotedefusesetup();
  grenade thread remotedetonatethink();
  wait 1;
  grenade thread at_mine_watch_trigger();
}

function at_mine_explode_from_player_trigger(owner) {
  thread at_mine_delete(1);

  if(isDefined(owner)) {
    self setentityowner(owner);
    self clearscriptabledamageowner();
  }

  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("trigger", "neutral", 0);
  self setscriptablepartstate("explode", "fromPlayer", 0);
}

function at_mine_explode_from_vehicle_trigger(ent) {
  if(isDefined(ent)) {
    thread at_mine_damage_manually(self.owner, ent);
  }

  thread at_mine_delete(1);
  self setentityowner(self.owner);
  self clearscriptabledamageowner();
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("launch", "neutral", 0);
  self setscriptablepartstate("explode", "fromVehicle", 0);
}

function at_mine_explode_from_notify(attacker) {
  thread at_mine_delete(1);
  self setentityowner(attacker);
  self clearscriptabledamageowner();
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("launch", "neutral", 0);
  self setscriptablepartstate("explode", "fromDamage", 0);
}

function at_mine_destroy(attacker) {
  thread at_mine_delete(1);
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("launch", "neutral", 0);
  self setscriptablepartstate("destroy", "active", 0);
}

function at_mine_delete(deletiondelay) {
  self notify("death");
  level.mines[self getentitynumber()] = undefined;
  self setCanDamage(0);
  makeexplosiveunusuabletag();
  self.exploding = 1;
  owner = self.owner;

  if(isDefined(self.owner) && isDefined(owner.plantedlethalequip)) {
    owner.plantedlethalequip = array_remove(owner.plantedlethalequip, self);
  }

  if(isDefined(self.dangericonent)) {
    self.dangericonent delete();
  }

  if(isDefined(self.useobj)) {
    self.useobj delete();
  }

  if(isDefined(deletiondelay)) {
    wait deletiondelay;
  }

  level notify("grenade_exploded_during_stealth", self.origin, "at_mine_mp", self.grenade_owner_name);

  if(isDefined(self)) {
    self delete();
  }
}

function at_mine_create_player_trigger() {
  trigger = spawn("trigger_rotatable_radius", self.origin, 0, 100, 50);
  trigger.angles = self.angles;
  trigger enablelinkTo();
  trigger linkTo(self);
  trigger hide();
  trigger.mine = self;
  return trigger;
}

function at_mine_watch_player_trigger(trigger) {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");
  self.owner endon("disconnect");
  contents = physics_createcontents(["physicscontents_glass", "physicscontents_water", "physicscontents_item", "physicscontents_vehicle", "physicscontents_missileclip"]);

  while(true) {
    trigger waittill("trigger", ent);

    if(!isDefined(ent)) {
      continue;
    }

    if(!isPlayer(ent) && !isagent(ent)) {
      continue;
    }

    if(isDefined(ent.vehicle)) {
      continue;
    }

    if(!ent scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }

    if(!istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, ent))) {
      continue;
    }

    thread at_mine_player_trigger(ent);
  }
}

function at_mine_player_trigger(ent) {
  self endon("mine_destroyed");
  self endon("death");
  self.owner endon("disconnect");
  self notify("mine_triggered");
  self.triggeredbyplayer = 1;
  makeexplosiveunusuabletag();
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("trigger", "active", 0);
  dangericonent = _launchgrenade("at_mine_ap_mp", self.origin, (0, 0, 0), 100, 1);
  dangericonent linkTo(self);
  thread at_mine_cleanup_danger_icon_ent(dangericonent);
  dangericonent.weapon_object = makeweapon("at_mine_ap_mp");
  self.dangericonent = dangericonent;
  graceperiod = 0.1;

  if(isPlayer(ent)) {
    graceperiod += 0.5;
  }

  explosivetrigger(ent, graceperiod);
  thread at_mine_watch_flight();
}

function at_mine_watch_trigger() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");

  while(true) {
    self waittill("trigger_grenade", entarr);
    assert(isDefined(entarr));

    if(istrue(self.isdisabled)) {
      continue;
    }

    foreach(ent in entarr) {
      if(ent.classname == "script_vehicle") {
        if(ent scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_isfriendlytomine(self)) {
          continue;
        }

        if(!scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_shouldvehicletriggermine(ent, self)) {
          continue;
        }

        scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_minetrigger(ent, self);
        break;
      }

      if(isagent(ent) || isPlayer(ent)) {
        if(isDefined(ent.vehicle)) {
          continue;
        }

        if(!scripts\cp\utility\player::isreallyalive(ent)) {
          continue;
        }

        thread at_mine_player_trigger(ent);
        break;
      }
    }
  }
}

function at_mine_watch_vehicle_trigger() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");
  self.owner endon("disconnect");
  var_eb84e55f9641a972 = [(0, 0, 0), (60, 0, 0), (-60, 0, 0)];
  var_530ea3b256eb4800 = 75;
  var_9aa2b3c8a147d8e = var_530ea3b256eb4800 * var_530ea3b256eb4800;
  var_2e9381e1a66202ee = 30;
  var_c4cf8191f6bab561 = [(0, 0, 0), (22, 0, 0), (-22, 0, 0)];
  var_fa65c6b8ad0e1249 = 96;
  var_687d10fcba24910d = var_fa65c6b8ad0e1249 * var_fa65c6b8ad0e1249;
  var_9787897a564d9409 = 15;

  while(true) {
    bradleys = getactivebradleys();

    if(isDefined(bradleys)) {
      foreach(bradley in bradleys) {
        if(!isDefined(bradley)) {
          continue;
        }

        if(level.teambased) {
          if(bradley.team == self.owner.team) {
            continue;
          }
        } else if(isDefined(bradley.owner) && bradley.owner == self.owner) {
          continue;
        }

        axes = anglestoaxis(bradley.angles);

        foreach(offset in var_eb84e55f9641a972) {
          borigin = bradley.origin;
          borigin += axes["right"] * offset[0];
          borigin += axes["forward"] * offset[1];
          borigin += axes["up"] * offset[2];
          btwn = self.origin - borigin;
          var_4504cce2ad14f2b2 = vectordot(btwn, axes["up"]);

          if(abs(var_4504cce2ad14f2b2) > var_2e9381e1a66202ee) {
            continue;
          }

          var_6602b5e32bb277d4 = btwn - axes["up"] * var_4504cce2ad14f2b2;

          if(lengthsquared(var_6602b5e32bb277d4) > var_9aa2b3c8a147d8e) {
            continue;
          }

          level thread at_mine_vehicle_trigger(bradley, self);
          return;
        }
      }
    }

    remotetanks = level.assaultdrones;

    if(isDefined(remotetanks)) {
      foreach(remotetank in remotetanks) {
        if(!isDefined(remotetank)) {
          continue;
        }

        if(!isDefined(remotetank.streakname) || remotetank.streakname != "pac_sentry") {
          continue;
        }

        if(isDefined(remotetank.owner) && !istrue(scripts\cp_mp\utility\player_utility::playersareenemies(remotetank.owner, self.owner))) {
          continue;
        }

        axes = anglestoaxis(remotetank.angles);

        foreach(offset in var_c4cf8191f6bab561) {
          rtorigin = remotetank.origin;
          rtorigin += axes["right"] * offset[0];
          rtorigin += axes["forward"] * offset[1];
          rtorigin += axes["up"] * offset[2];
          btwn = self.origin - rtorigin;
          var_4504cce2ad14f2b2 = vectordot(btwn, axes["up"]);

          if(abs(var_4504cce2ad14f2b2) > var_9787897a564d9409) {
            continue;
          }

          var_6602b5e32bb277d4 = btwn - axes["up"] * var_4504cce2ad14f2b2;

          if(lengthsquared(var_6602b5e32bb277d4) > var_687d10fcba24910d) {
            continue;
          }

          level thread at_mine_vehicle_trigger(remotetank, self);
          return;
        }
      }
    }

    waitframe();
  }
}

function getactivebradleys() {
  vehicles = [];

  foreach(vehicle_array in level.vehicle.instances) {
    foreach(vehicle in vehicle_array) {
      vehicles[vehicles.size] = vehicle;
    }
  }

  if(isDefined(level.bradley)) {
    vehicles = array_combine(vehicles, level.bradley.activevehicles["total"]);
  }

  if(vehicles.size == 0) {
    return undefined;
  }

  return vehicles;
}

function at_mine_vehicle_trigger(vehicle, mine) {
  mine endon("mine_destroyed");
  mine endon("death");
  mine.owner endon("disconnect");
  mine notify("mine_triggered");
  mine makeexplosiveunusuabletag();
  mine setscriptablepartstate("arm", "neutral", 0);
  mine setscriptablepartstate("trigger", "active", 0);
  wait 0.2;
  mine thread at_mine_explode_from_vehicle_trigger(vehicle);
}

function at_mine_watch_flight_mover(flighttime) {
  self endon("death");
  self.grenade waittill_any_timeout_2(flighttime, "death", "mine_destroyed");

  if(isDefined(self.grenade)) {
    self moveTo(self.origin, 0.05, 0, 0);
  }

  wait 2;
  self delete();
}

function at_mine_watch_flight() {
  self endon("mine_destroyed");
  self endon("death");
  flighttime = 0.7;

  if(flighttime > 0) {
    flightdir = (0, 0, 1);
    flightdest = self.origin + flightdir * 64;
    contents = physics_createcontents(["physicscontents_glass", "physicscontents_water", "physicscontents_item", "physicscontents_vehicle", "physicscontents_missileclip"]);
    caststart = self.origin;
    castend = flightdest;
    castresults = physics_raycast(caststart, castend, contents, self, 0, "physicsquery_closest", 1);

    if(isDefined(castresults) && castresults.size > 0) {
      castdist = vectordot(castresults[0]["position"] - caststart, flightdir);
      castdist = max(0, castdist - 1);
      flighttime = 0;
      flightdest = self.origin;

      if(castdist > 0) {
        flighttime = castdist / 64 * 0.7;
        flightdest = self.origin + flightdir * castdist;
      }
    }

    if(flighttime > 0) {
      flighttimeremaining = flighttime;
      flightdeceltime = flighttimeremaining * 0.93;
      flighttimeremaining -= flightdeceltime;
      flightacceltime = 0;

      if(flighttimeremaining > 0) {
        flightacceltime = flighttimeremaining * 0;
      }

      mover = spawn("script_model", self.origin);
      mover.angles = vectortoangles(anglesToForward(self.angles) * (1, 1, 0));
      mover setModel("tag_origin");
      self.mover = mover;
      mover.grenade = self;
      self linkTo(mover, "tag_origin", (0, 0, 0), (0, 0, 0));
      mover moveTo(flightdest, flighttime, flightacceltime, flightdeceltime);
      mover thread at_mine_watch_flight_mover(flighttime);
      thread at_mine_watch_flight_effects(flighttime);
      wait flighttime;
      thread at_mine_explode_from_player_trigger();
      return;
    }
  }
}

function at_mine_watch_flight_effects(flighttime) {
  self endon("mine_destroyed");
  self endon("death");
  self setscriptablepartstate("launch", "active", 0);
}

function at_mine_watch_emp() {
  self endon("mine_destroyed");
  self endon("death");
  self.owner endon("disconnect");

  while(true) {
    self waittill("emp_applied", data);
    attacker = data.attacker;

    if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker))) {
      attacker notify("destroyed_equipment");

      if(isPlayer(attacker)) {
        attacker scripts\cp\damagefeedback::updatedamagefeedback("standard");
      }

      thread at_mine_destroy();
    }
  }
}

function at_mine_watch_detonate() {
  self endon("death");
  self.owner endon("disconnect");
  owner = self.owner;
  self waittill("detonateExplosive", attacker);

  if(isDefined(attacker)) {
    thread at_mine_explode_from_notify(attacker);
    return;
  }

  thread at_mine_explode_from_notify(owner);
}

function at_mine_watch_game_end() {
  self endon("mine_destroyed");
  self endon("death");
  level waittill_any_2("game_ended", "bro_shot_start");
  thread at_mine_destroy();
}

function at_mine_damage_manually(attacker, enttodamage) {
  enttodamage endon("death");
  weapon = makeweapon("at_mine_mp");
  waitframe();
  var_fbff02c9c978437f = 200;

  if(isDefined(enttodamage.mine_damage_override)) {
    var_fbff02c9c978437f = enttodamage.mine_damage_override;
  }

  if(isDefined(attacker) && isDefined(self)) {
    enttodamage dodamage(var_fbff02c9c978437f, self.origin, attacker, self, "MOD_EXPLOSIVE", weapon);
    enttodamage notify("damage", var_fbff02c9c978437f, self.origin, attacker, self, "MOD_EXPLOSIVE", weapon);
  }
}

function at_mine_modified_damage(victim, inflictor, objweapon, meansofdeath, damage) {
  if(!isDefined(inflictor)) {
    return damage;
  }

  if(meansofdeath != "MOD_EXPLOSIVE") {
    return damage;
  }

  if(!isDefined(objweapon)) {
    return damage;
  }

  if(isnullweapon(objweapon)) {
    return damage;
  }

  if(objweapon.basename != "at_mine_mp" && objweapon.basename != "at_mine_ap_mp") {
    return damage;
  }

  up = anglestoup(inflictor.angles);
  btwn = inflictor.origin - self getEye();
  var_d14eec85ac39c1cb = vectordot(btwn, up);

  if(var_d14eec85ac39c1cb > 60) {
    return 0;
  }

  btwn = self.origin - inflictor.origin;
  var_f4ef78de9cf3220a = vectordot(btwn, up);

  if(var_f4ef78de9cf3220a > 60) {
    return 0;
  }

  if(objweapon.basename == "at_mine_ap_mp" || istrue(inflictor.triggeredbyplayer)) {
    if(var_d14eec85ac39c1cb >= 0) {
      stance = victim getstance();

      if(stance == "prone") {
        damage = int(min(damage, 35));
      } else if(stance == "crouch") {
        damage = int(min(damage, 55));
      }
    }
  }

  return damage;
}

function at_mine_cleanup_danger_icon_ent(dangericonent) {
  dangericonent endon("death");
  self waittill("death");
  dangericonent delete();
}

function remotedetonatethink() {
  level endon("game_ended");
  self.owner endon("disconnect");
  self endon("death");

  while(true) {
    self waittill("remote_detonate", player);
    thread at_mine_explode_from_player_trigger(player);
  }
}

function remotedefusesetup() {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");
  hintstring = &"PERKS/REMOTE_DEFUSE_HINT";
  var_e213cdc03c01a000 = 0;
  self.useobj = createhintobject(self.origin + anglestoup(self.angles) * 7, "HINT_BUTTON", undefined, hintstring, var_e213cdc03c01a000, undefined, "show", 250, 160, 200, 160);
  self.useobj.owner = self.owner;
  self.useobj.team = self.team;
  self.useobj linkTo(self);

  foreach(player in level.players) {
    self.useobj disableplayeruse(player);
  }

  thread defusethink();
  thread defuseusemonitoring();

  for(;;) {
    self waittill("defused", player);

    if(isPlayer(player)) {
      thread at_mine_explode_from_player_trigger(player);
    }
  }
}

function defuseusemonitoring() {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");

  while(true) {
    wait 0.1;

    foreach(player in level.players) {
      if(player.team == self.team || !player _hasperk("specialty_remote_defuse")) {
        self.useobj disableplayeruse(player);
        continue;
      }

      self.useobj enableplayeruse(player);
    }
  }
}

function defusethink() {
  self endon("restarting_physics");
  usetrigger = self.useobj;
  useent = undefined;

  if(istrue(level.gameended) && !isDefined(usetrigger)) {
    return;
  }

  while(isDefined(self)) {
    usetrigger waittill("trigger", player);

    if(isDefined(self.owner) && player == self.owner) {
      continue;
    }

    player.iscapturingcrate = 1;
    useent = createuseent();
    useent.id = "breach_defuse";
    result = useent useholdthink(player, getdvarfloat(@ "hash_923eecb6e8de167e"));

    if(!isDefined(player)) {
      return;
    }

    if(!result) {
      player.iscapturingcrate = 0;
      continue;
    }

    player.iscapturingcrate = 0;
    self notify("defused", player);
  }
}