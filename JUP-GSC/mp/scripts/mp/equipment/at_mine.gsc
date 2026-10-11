/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\equipment\at_mine.gsc
***********************************************/

#using scripts\common\elevators;
#using scripts\common\utility;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\ent_manager;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\equipment\haywire;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle_mines;
#using scripts\engine\utility;
#using scripts\mp\equipment;
#using scripts\mp\equipment\claymore;
#using scripts\mp\equipment_interact;
#using scripts\mp\hud_message;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\movers;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\spawnlogic;
#using scripts\mp\utility\damage;
#using scripts\mp\utility\equipment;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\script;
#using scripts\mp\utility\weapon;
#using scripts\mp\weapons;
#namespace at_mine;

function at_mine_init() {
  var_f16af5a8c61c30ee = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataformine("equip_at_mine", 1);
  var_f16af5a8c61c30ee.radius = 100;
  var_f16af5a8c61c30ee.triggercallback = &at_mine_vehicle_trigger;

  setdevdvarifuninitialized(@ "hash_e67a08119163320a", 0);
}

function at_mine_use(grenade) {
  self endon("disconnect");
  grenade endon("death");

  if(_hasperk("specialty_rugged_eqp")) {
    grenade.hasruggedeqp = 1;
  }

  grenade.var_e73a396a2a6b1d56 = isDefined(grenade.bundle) && istrue(grenade.bundle.var_2184fb9f1b8593fa);
  grenade scripts\cp_mp\ent_manager::registerspawn(2, &deletemine);
  thread scripts\mp\weapons::monitordisownedgrenade(self, grenade);
  grenade thread at_mine_watch_game_end();
  plantdata = spawnStruct();
  plantdata.throwspeedforward = 100;
  plantdata.throwspeedup = -50;
  plantdata.castdivisions = 3;
  plantdata.castmaxtime = 0.5;
  plantdata.castdetail = 1;
  plantdata.plantmaxtime = 0.5;
  plantdata.plantmaxroll = 15;
  plantdata.plantmindistbeloweye = 12;
  plantdata.plantmaxdistbelowownerfeet = 20;
  plantdata.plantmindisteyetofeet = 45;
  plantdata.plantnormalcos = 0.342;
  grenade setscriptablepartstate("visibility", "show", 0);
  data = spawnStruct();
  data.endonstring = "mine_destroyed";
  data.skipdeath = 1;
  grenade thread scripts\mp\movers::handle_moving_platform_touch(data);
  grenade waittill("missile_stuck", stuckto, hitent, surfacetype, velocity, position, normal);

  if(isDefined(level.var_ca4e08767cbdae12)) {
    canplant = grenade[[level.var_ca4e08767cbdae12]]();

    if(!canplant) {
      scripts\mp\hud_message::showerrormessage("EQUIPMENT/PLANT_FAILED");
      scripts\mp\equipment::incrementequipmentslotammo("primary");
      grenade delete();
      return;
    }
  }

  if(isDefined(stuckto)) {
    if(isent(stuckto) && is_train_ent(stuckto)) {
      grenade.origin += (0, 0, 1.6);
      data.plantedontrain = 1;
      grenade setmissileantilagged(1);
    }

    grenade linkTo(stuckto);
  }

  thread at_mine_plant(grenade, surfacetype);
}

function is_train_ent(hitent) {
  if(isDefined(level.wztrain_info)) {
    foreach(ent in level.wztrain_info.train_array) {
      if(ent == hitent) {
        return true;
      }

      if(isDefined(ent.linked_model) && ent.linked_model == hitent) {
        return true;
      }
    }
  }

  return false;
}

function at_mine_update_danger_zone() {
  if(istrue(level.dangerzoneskipequipment)) {
    return;
  }

  if(isDefined(self.dangerzone)) {
    scripts\mp\spawnlogic::removespawndangerzone(self.dangerzone);
  }

  self.dangerzone = scripts\mp\spawnlogic::addspawndangerzone(self.origin, scripts\mp\spawnlogic::getdefaultminedangerzoneradiussize(), 72, self.owner.team, undefined, self.owner, 0, self, 1);
}

function function_427845ab37c184cd() {
  self endon("mine_destroyed");
  self endon("death");
  self waittill("missile_water_impact");
  self setscriptablepartstate("floats", "show", 0);
  self.hitwater = 1;
}

function at_mine_plant(grenade, surfacetype) {
  grenade endon("mine_destroyed");
  grenade endon("death");
  grenade setotherent(self);
  grenade setentityowner(self);
  grenade missilethermal();

  if(!istrue(grenade.var_40e5b4307cb6229c)) {
    grenade missileoutline();
  }

  grenade setnodeploy(1);
  grenade setscriptablepartstate("plant", "active", 0);
  self setscriptablepartstate("equipATMineFXView", "plant", 0);
  onequipmentplanted(grenade, "equip_at_mine", &at_mine_delete, isagent(self));
  thread monitordisownedequipment(self, grenade);
  grenade scripts\mp\sentientpoolmanager::registersentient("Lethal_Static", grenade.owner, 1);
  grenade thread minedamagemonitor();
  grenade thread at_mine_watch_detonate();

  if(issharedfuncdefined("emp", "setEMP_Applied_Callback")) {
    grenade[[getsharedfunc("emp", "setEMP_Applied_Callback")]](&at_mine_empapplied);
  }

  if(issharedfuncdefined("emp", "setEMP_Cleared_Callback")) {
    grenade[[getsharedfunc("emp", "setEMP_Cleared_Callback")]](&function_97f28317850da77d);
  }

  grenade scripts\cp_mp\emp_debuff::set_apply_emp_callback(&at_mine_empapplied);
  grenade scripts\cp_mp\equipment\haywire::function_172d848d58051fdf(&function_83d4163604fc28e3);
  grenade function_49197cd063a740ea(&at_mine_destroy);

  if(isDefined(level.elevators)) {
    foreach(elevators in level.elevators) {
      elevators thread scripts\common\elevators::isentitytouchingdoortrigger(grenade);
    }
  }

  grenade at_mine_update_danger_zone();
  armtime = 1.5;

  if(isDefined(grenade.armtime)) {
    armtime = grenade.armtime;
  }

  wait armtime / 2;

  if(istrue(grenade.touchedmovingplatform)) {
    grenade thread at_mine_movingplatform_update();
  }

  wait armtime / 2;
  grenade thread scripts\mp\equipment_interact::remoteinteractsetup(&at_mine_explode_from_player_trigger, 1, 1);
  grenade setscriptablepartstate("arm", "active", 0);
  grenade thread at_mine_watch_trigger();

  if(!(getDvar(@ "ui_gametype", "") == "mines")) {
    grenade thread makeexplosiveusabletag("tag_use", 1);
    thread scripts\mp\weapons::outlineequipmentforowner(grenade);
  }

  iconoffset = 2;
  grenade.headiconid = grenade scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, iconoffset, undefined, undefined, undefined, 0.1, 1);
}

function at_mine_explode_from_player_trigger(owner) {
  thread at_mine_delete(5);

  if(!isDefined(owner)) {
    owner = self.owner;
  }

  self setentityowner(owner);
  self clearscriptabledamageowner();
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("trigger", "neutral", 0);
  self setscriptablepartstate("hacked", "neutral", 0);

  if(!istrue(self.var_e73a396a2a6b1d56)) {
    self setscriptablepartstate("explode", "fromPlayer", 0);
    return;
  }

  self setscriptablepartstate("explode", "fromPlayer_noDamage", 0);
  function_bca6c45b0429de16("fromPlayer");
}

function at_mine_explode_from_vehicle_trigger(vehicle) {
  level endon("game_ended");
  thread at_mine_explode_from_vehicle_trigger_internal();

  if(isDefined(vehicle)) {
    vehicledamage = 200;

    if(istrue(self.var_e73a396a2a6b1d56) && isDefined(self.bundle.var_2910d1d687f9dd6c)) {
      vehicledamage = self.bundle.var_2910d1d687f9dd6c;
    }

    vehicle dodamage(vehicledamage, self.origin, self.owner, self, "MOD_EXPLOSIVE", makeweapon("at_mine_mp"));
    ignoredamageid = vehicle scripts\mp\utility\damage::non_player_add_ignore_damage_signature(self.owner, makeweapon("at_mine_mp"), self, "MOD_EXPLOSIVE");

    if(!istrue(self.var_e73a396a2a6b1d56)) {
      waitframe();
    } else {
      thread function_bca6c45b0429de16("fromVehicle");
      self waittill("damage_done");
    }

    vehicle scripts\mp\utility\damage::non_player_remove_ignore_damage_signature(ignoredamageid);
  }
}

function at_mine_explode_from_vehicle_trigger_internal() {
  thread at_mine_delete(5);
  self setentityowner(self.owner);
  self clearscriptabledamageowner();
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("launch", "neutral", 0);

  if(!istrue(self.var_e73a396a2a6b1d56)) {
    self setscriptablepartstate("explode", "fromVehicle", 0);
    return;
  }

  self setscriptablepartstate("explode", "fromVehicle_noDamage", 0);
}

function at_mine_explode_from_notify(attacker) {
  thread at_mine_delete(5);
  self setentityowner(attacker);
  self clearscriptabledamageowner();
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("launch", "neutral", 0);

  if(!istrue(self.var_e73a396a2a6b1d56)) {
    self setscriptablepartstate("explode", "fromDamage", 0);
    return;
  }

  self setscriptablepartstate("explode", "fromDamage_noDamage", 0);
  function_bca6c45b0429de16("fromDamage");
}

function function_bca6c45b0429de16(explosiontype) {
  switch (tolower(explosiontype)) {
    case #"hash_e483dd32e0fdb810":
      origin = self.origin;
      radius = self.bundle.var_191e2e6f3cadc13a;
      innerdamage = self.bundle.var_6fd49aaa102ebcc;
      outerdamage = self.bundle.var_4464f012994561f1;
      self radiusdamage(origin, radius, innerdamage, outerdamage, self.owner, "MOD_EXPLOSIVE", self.weapon_object);
      break;
    case #"hash_158ce4a7ce3563ff":
    case #"hash_75e0768a682372f0":
      origin = self.origin;
      radius = self.bundle.var_4cb5845b7927cc2a;
      innerdamage = self.bundle.var_72ee10ca4549b81c;
      outerdamage = self.bundle.var_fcc260728eeb1341;
      self radiusdamage(origin, radius, innerdamage, outerdamage, self.owner, "MOD_EXPLOSIVE", self.weapon_object);
      break;
    default:
      return;
  }

  self notify("damage_done");
}

function at_mine_destroy(attacker) {
  self endon("death");
  thread at_mine_delete(5);
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("launch", "neutral", 0);
  self setscriptablepartstate("destroy", "active", 0);
}

function at_mine_delete(deletiondelay) {
  if(istrue(self.isdestroyed) || !isDefined(self)) {
    return;
  }

  self.isdestroyed = 1;
  self notify("death");
  level.mines[self getentitynumber()] = undefined;
  self setscriptablepartstate("hack_usable", "off");
  self setCanDamage(0);
  makeexplosiveunusuabletag();
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
  self.headiconid = undefined;
  self.exploding = 1;

  if(isDefined(self.dangerzone)) {
    scripts\mp\spawnlogic::removespawndangerzone(self.dangerzone);
    self.dangerzone = undefined;
  }

  if(isDefined(self.owner)) {
    self.owner removeequip(self);
  }

  if(isDefined(self.dangericonent)) {
    self.dangericonent delete();
  }

  linkedchildren = self getlinkedchildren();

  if(isDefined(linkedchildren)) {
    foreach(child in linkedchildren) {
      if(isDefined(child) && isDefined(child.equipmentref) && child.equipmentref == "equip_claymore" && !istrue(child.exploding)) {
        child thread scripts\mp\equipment\claymore::claymore_destroy();
      }
    }
  }

  if(isDefined(deletiondelay)) {
    wait deletiondelay;
  }

  scripts\cp_mp\ent_manager::deregisterspawn();

  if(isDefined(self)) {
    self delete();
  }
}

function at_mine_movingplatform_update() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");
  self.attachedvelocity = (0, 0, 0);
  update_interval = 0.2;

  while(true) {
    old_origin = self.origin;
    wait update_interval;
    self.attachedvelocity = 1 / update_interval * (self.origin - old_origin);
  }
}

function is_at_mine_moving(mine) {
  return isDefined(mine) && isDefined(mine.attachedvelocity) && length2dsquared(mine.attachedvelocity) > 0.01;
}

function at_mine_watch_trigger() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");

  thread function_d9f2aec6c4f8ed31();

  while(true) {
    self waittill("trigger_grenade", entarr);
    assert(isDefined(entarr));

    if(istrue(self.isdisabled)) {
      continue;
    }

    foreach(ent in entarr) {
      if(!isDefined(ent) || !isDefined(ent.classname)) {
        continue;
      }

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

        if(!isreallyalive(ent)) {
          continue;
        }

        thread at_mine_player_trigger(ent);
        break;
      }
    }
  }
}

function function_d9f2aec6c4f8ed31() {
  self endon("<dev string:x1c>");
  self endon("<dev string:x2e>");
  self endon("<dev string:x40>");
  mineowner = self.owner;

  if(!isPlayer(mineowner)) {
    return;
  }

  mineowner notifyonplayercommand("<dev string:x49>", "<dev string:x58>");
  mineowner notifyonplayercommand("<dev string:x49>", "<dev string:x66>");

  while(true) {
    mineowner waittill("<dev string:x49>");
    debuglaunch = getdvarint(@ "hash_e67a08119163320a", 0);

    if(!debuglaunch) {
      continue;
    }

    thread at_mine_player_trigger(mineowner);
  }
}

function at_mine_player_trigger(ent) {
  self endon("mine_destroyed");
  self endon("death");
  self notify("mine_triggered");
  self.triggeredbyplayer = 1;
  makeexplosiveunusuabletag();
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("trigger", "active", 0);
  function_9b1b9f121a84a4a1("at_mine_ap_mp", 100);
  explosivetrigger(ent, 0.1);
  thread at_mine_watch_flight();
}

function function_9b1b9f121a84a4a1(var_5db09cf670b9ec64, fusetime) {
  dangericonent = _launchgrenade(var_5db09cf670b9ec64, self.origin, (0, 0, 0), fusetime, 1);
  dangericonent linkTo(self);
  thread at_mine_cleanup_danger_icon_ent(dangericonent);
  dangericonent.weapon_object = makeweapon(var_5db09cf670b9ec64);
  self.dangericonent = dangericonent;
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

  while(isDefined(self.grenade)) {
    waitframe();
  }

  self delete();
}

function deletemine() {
  at_mine_delete(0);
}

function at_mine_watch_flight() {
  self endon("mine_destroyed");
  self endon("death");
  flighttime = 0.8;

  if(flighttime > 0) {
    flightdir = (0, 0, 1);
    flightdest = self.origin + flightdir * 64;
    contents = physics_createcontents(["physicscontents_glass", "physicscontents_water", "physicscontents_item", "physicscontents_vehicle", "physicscontents_missileclip"]);
    ignorelist = scripts\mp\utility\equipment::get_mine_ignore_list();
    caststart = self.origin;
    castend = flightdest;
    castresults = physics_raycast(caststart, castend, contents, ignorelist, 0, "physicsquery_closest", 1);

    if(isDefined(castresults) && castresults.size > 0) {
      castdist = vectordot(castresults[0]["position"] - caststart, flightdir);
      castdist = max(0, castdist - 1);
      flighttime = 0;
      flightdest = self.origin;

      if(castdist > 0) {
        flighttime = castdist / 64 * 0.8;
        flightdest = self.origin + flightdir * castdist;
      }
    }

    if(is_at_mine_moving(self)) {
      flightdest += self.attachedvelocity * flighttime;
    }

    if(flighttime > 0) {
      flighttimeremaining = flighttime;
      flightdeceltime = flighttimeremaining * 0.81;

      if(is_at_mine_moving(self)) {
        flightdeceltime *= 0.25;
      }

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
      function_9e0f9db6ce29a5a9();
      childthread scripts\mp\utility\equipment::watch_flight_collision();
      waittill_any_timeout_1(flighttime, "collision_with_platform");
      thread at_mine_explode_from_player_trigger();
      return;
    }
  }
}

function function_9e0f9db6ce29a5a9() {
  launchstate = "land";

  if(istrue(self.hitwater)) {
    launchstate = "water";
  }

  self setscriptablepartstate("launch", launchstate, 0);
}

function at_mine_empapplied(data) {
  attacker = data.attacker;

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker))) {
    attacker notify("destroyed_equipment");
    attacker scripts\mp\killstreaks\killstreaks::givescoreforequipment(self, undefined, 1);
  }

  if(isPlayer(attacker)) {
    attacker updatedamagefeedback("");
  }

  thread function_416f3f7ada048ff9(attacker);
}

function function_83d4163604fc28e3(data) {
  attacker = data.attacker;

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker))) {
    attacker notify("destroyed_equipment");
    attacker scripts\mp\killstreaks\killstreaks::givescoreforequipment(self);
  }

  if(isPlayer(attacker)) {
    attacker updatedamagefeedback("");
  }

  self notify("detonateExplosive", attacker);
}

function at_mine_watch_detonate() {
  self endon("death");
  self waittill("detonateExplosive", attacker);

  if(isDefined(attacker)) {
    thread at_mine_explode_from_notify(attacker);
    return;
  }

  if(isDefined(self.owner)) {
    thread at_mine_explode_from_notify(self.owner);
    return;
  }

  thread at_mine_destroy();
}

function at_mine_watch_game_end() {
  self endon("mine_destroyed");
  self endon("death");
  level waittill_any_2("game_ended", "bro_shot_start");
  thread at_mine_destroy();
}

function at_mine_damage_vehicle_manually(vehicle) {
  vehicle dodamage(200, self.origin, self.owner, self, "MOD_EXPLOSIVE", makeweapon("at_mine_mp"));
  ignoredamageid = vehicle scripts\mp\utility\damage::non_player_add_ignore_damage_signature(self.owner, makeweapon("at_mine_mp"), self, "MOD_EXPLOSIVE");
  waitframe();

  if(isDefined(vehicle)) {
    vehicle scripts\mp\utility\damage::non_player_remove_ignore_damage_signature(ignoredamageid);
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
      proneclamp = 35;
      crouchclamp = 35;

      if(array_contains_key(level.var_415476758ec47760, objweapon.basename) && array_contains_key(level.equipment.table, level.var_415476758ec47760[objweapon.basename])) {
        equipref = level.var_415476758ec47760[objweapon.basename];
        bundle = level.equipment.table[equipref].bundle;

        if(istrue(bundle.var_2184fb9f1b8593fa)) {
          if(isDefined(bundle.var_dd63a79b1ba26d2e)) {
            crouchclamp = bundle.var_dd63a79b1ba26d2e;
          }

          if(isDefined(bundle.var_95441cbee7fcd786)) {
            proneclamp = bundle.var_95441cbee7fcd786;
          }
        }
      }

      stance = victim getstance();

      if(stance == "prone" || self isswimming()) {
        damage = int(min(damage, proneclamp));
      } else if(stance == "crouch" || self issprintsliding()) {
        damage = int(min(damage, crouchclamp));
      }
    }
  }

  if(isDefined(victim) && victim isdiving()) {
    if(damage >= victim.health) {
      damage = victim.health - 1;
    }
  }

  return damage;
}

function at_mine_cleanup_danger_icon_ent(dangericonent) {
  dangericonent endon("death");
  self waittill("death");
  dangericonent delete();
}

function at_mine_onownerchanged(oldowner) {
  self setscriptablepartstate("hacked", "active", 0);
  at_mine_update_danger_zone();
  sentientpool = self.sentientpool;
  scripts\mp\sentientpoolmanager::unregistersentient(self.sentientpool, self.sentientpoolindex);
  scripts\mp\sentientpoolmanager::registersentient(sentientpool, self.owner, 1);
  makeexplosiveunusuabletag();
  thread monitordisownedequipment(self.owner, self);
  thread outlineequipmentforowner(self);
}

function function_416f3f7ada048ff9(attacker) {
  self endon("death");
  attacker thread scripts\mp\utility\points::doscoreevent(#"hash_61a2d32e72064a0f");
  self.isdisabled = 1;
  self setscriptablepartstate("empd", "active", 0);

  if(!istrue(self.owner.ksempd)) {
    wait 6;
    self.isdisabled = 0;
    self setscriptablepartstate("empd", "neutral", 0);
  }
}

function function_97f28317850da77d(data) {
  self.isdisabled = 0;
  self setscriptablepartstate("empd", "neutral", 0);
}

function function_49197cd063a740ea(callbackfunction) {
  self.elevatordoorsclosecallback = callbackfunction;
}