/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\powers\cp_tactical_cover.gsc
***************************************************/



#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp\cp_movers;
#using scripts\cp\cp_player_battlechatter;
#using scripts\cp\cp_weapons;
#using scripts\cp\damage;
#using scripts\cp\loot_system;
#using scripts\cp\munitions;
#using scripts\cp\points;
#using scripts\cp\utility;
#using scripts\cp\weapon;
#using scripts\cp_mp\auto_ascender;
#using scripts\cp_mp\auto_ascender_solo;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\ent_manager;
#using scripts\cp_mp\equipment;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\scriptable_door_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\sentientpoolmanager;
#namespace cp_tactical_cover;

function tac_cover_init() {
  if(!isDefined(level.taccovercollision)) {
    collisionarr = getEntArray("tactical_cover_col", "targetname");

    if(isDefined(collisionarr)) {
      level.taccovercollision = collisionarr[0];
    }
  }

  level.taccovertriggerblockers = getEntArray("dcover_blocker", "targetname");
  level.taccover_timeout = getdvarfloat(@ "hash_fdeb104ec6908df8", 150);

  setdevdvarifuninitialized(@ "hash_a5a0ca488a1da730", 0);
}

function tac_cover_on_give(ref, slot) {
  self notify("tac_cover_given");

  if(!isDefined(level.taccovercollision)) {
    self iprintlnbold("<dev string:x1c>");
  }
}

function tac_cover_on_take(ref, slot, issuper) {
  self notify("tac_cover_taken");
  self.taccoverrefund = undefined;
}

function tac_cover_used(grenade) {
  waitframe();

  if(isDefined(grenade)) {
    grenade delete();
  }
}

function tac_cover_on_fired(ref, slot, objweapon, issuper) {
  if(self isswimming()) {
    tac_cover_fire_failed(0);
    return false;
  }

  self.taccoverrefund = 1;
  contents = physics_createcontents(["physicscontents_characterproxy", "physicscontents_playerclip", "physicscontents_vehicle"]);
  ignorelist = tac_cover_ignore_list(self);
  playerforward = anglesToForward(self.angles);
  targetpos = self.origin + playerforward * 32;
  nearbydoors = scriptable_door_get_in_radius(targetpos, 140, 20);
  closestdoor = undefined;
  closestdistsqrd = 0;

  if(tac_cover_blocked_by_turret(targetpos)) {
    tac_cover_fire_failed(0);
    return false;
  }

  if(scripts\cp_mp\auto_ascender::function_ff57f9acf27bbc3c(targetpos)) {
    return false;
  }

  if(scripts\cp_mp\auto_ascender_solo::ispointnearsoloascenderline(targetpos)) {
    return false;
  }

  contents = scripts\engine\trace::function_2d88cb1f022d0989();
  radius = getdvarfloat(@ "hash_9fa5c4d28ec05069", 40);
  traceresults = scripts\engine\trace::sphere_trace_get_all_results(targetpos, targetpos + (0, 0, 10), radius, level.players, contents, 1);

  foreach(trace in traceresults) {
    if(!isDefined(trace["surfaceflags"])) {
      continue;
    }

    if(trace["surfaceflags"] & 8) {
      return false;
    }
  }

  foreach(door in nearbydoors) {
    distsqrd = distancesquared(door.origin, targetpos);

    if(isDefined(closestdoor) && closestdistsqrd <= distsqrd) {
      continue;
    }

    closestdoor = door;
    closestdistsqrd = distsqrd;
  }

  if(isDefined(closestdoor)) {
    doordegrees = closestdoor scriptabledoorangle();
    isdooropen = abs(doordegrees) > 65;
    doubledoor = undefined;

    foreach(otherdoor in nearbydoors) {
      if(closestdoor scriptable_door_is_double_door_pair(otherdoor)) {
        doubledoor = otherdoor;
        break;
      }
    }

    var_560b069f3a9b36e4 = 1;

    if(isDefined(doubledoor)) {
      var_f5867c54c41d2a4d = doubledoor scriptabledoorangle();
      var_560b069f3a9b36e4 = abs(var_f5867c54c41d2a4d) > 65;
    }

    if(closestdistsqrd < 1600 && isdooropen && var_560b069f3a9b36e4) {
      startpos = self gettagorigin("j_spinelower");
      endpos = closestdoor function_d90515f5e17dbc6f() + (0, 0, 24);
      castresult = physics_raycast(startpos, endpos, contents, ignorelist, 0, "physicsquery_any", 1);

      if(isDefined(castresult) && castresult > 0) {
        tac_cover_fire_failed(1);
        return false;
      }

      closestdoor.isblocked = 1;
      self.taccoverrefund = undefined;
      thread tac_cover_spawn_with_door(closestdoor, doubledoor, issuper, contents);
      return true;
    } else if(closestdistsqrd < 6400) {
      tac_cover_fire_failed(1);
      return false;
    }
  }

  var_ac01a11a5f883c59 = self getplayerangles() * (0, 1, 0);
  caststart = self.origin + (0, 0, 24);
  castdir = anglesToForward(var_ac01a11a5f883c59);
  castdist = 32 - 2.5;
  frontcastend = caststart + castdir * castdist;
  castresult = physics_raycast(caststart, frontcastend, contents, ignorelist, 0, "physicsquery_closest", 1);

  if(isDefined(castresult) && castresult.size > 0) {
    tac_cover_fire_failed();
    return false;
  }

  rightfraction = undefined;
  leftfraction = undefined;
  caststart = frontcastend;
  castdir = anglestoright(var_ac01a11a5f883c59);
  castdist = 58 - 2.5;
  castend = caststart + castdir * castdist;
  castresult = physics_spherecast(caststart, castend, 2.5, contents, ignorelist, "physicsquery_closest");

  if(isDefined(castresult) && castresult.size > 0) {
    hitpos = castresult[0]["shape_position"];
    rightfraction = castresult[0]["fraction"];
  } else {
    rightfraction = 1;
  }

  caststart = frontcastend;
  castdir = -1 * anglestoright(var_ac01a11a5f883c59);
  castdist = 58 - 2.5;
  castend = caststart + castdir * castdist;
  castresult = physics_spherecast(caststart, castend, 2.5, contents, ignorelist, "physicsquery_closest");

  if(isDefined(castresult) && castresult.size > 0) {
    hitpos = castresult[0]["shape_position"];
    leftfraction = castresult[0]["fraction"];
  } else {
    leftfraction = 1;
  }

  if(leftfraction + rightfraction < 1) {
    tac_cover_fire_failed();
    return false;
  } else if(rightfraction < 0.5) {
    frontcastend += castdir * castdist * (0.5 - rightfraction);
  } else if(leftfraction < 0.5) {
    frontcastend += castdir * castdist * (0.5 - leftfraction) * -1;
  }

  castangles = var_ac01a11a5f883c59;
  caststart = frontcastend;
  castdir = (0, 0, -1);
  castdist = 60;
  castend = caststart + castdir * castdist;
  var_188ecaff115cacb7 = combineangles(castangles, (0, 0, 90));
  castresult = physics_capsulecast(caststart, castend, 2.5, 16.8, var_188ecaff115cacb7, contents, ignorelist, "physicsquery_closest");

  if(!isDefined(castresult) || castresult.size <= 0) {
    tac_cover_fire_failed();
    return false;
  }

  hitent = castresult[0]["entity"];

  if(isDefined(hitent) && !tac_cover_can_place_on(hitent)) {
    tac_cover_fire_failed();
    return false;
  }

  var_c72145d539d8d1a1 = castresult[0]["shape_position"];
  hitpos = castresult[0]["position"];
  spawnpos = var_c72145d539d8d1a1 - (0, 0, 2.5);
  var_7a2d144a06a00b97 = tac_cover_get_stuck_to_ent(hitent);
  var_786439b54d66d5f9 = (16.8 - 2.5) * 1.75;
  var_d017352bffc438f8 = pow(var_786439b54d66d5f9 * 0.14, 2);
  caststartcenter = var_c72145d539d8d1a1;
  var_30f5ea3b5bc36327 = distance2dsquared(caststartcenter, hitpos);
  caststartright = var_c72145d539d8d1a1 + anglestoright(var_ac01a11a5f883c59) * (16.8 - 2.5) * 1.75;
  var_a104b4b86ea439f6 = distance2dsquared(caststartright, hitpos);
  caststartleft = var_c72145d539d8d1a1 + anglestoright(var_ac01a11a5f883c59) * (16.8 - 2.5) * 1.75 * -1;
  var_265e28da43deed4f = distance2dsquared(caststartleft, hitpos);
  caststarts = [];
  var_558aadd2c4f2af41 = 0;

  if(var_a104b4b86ea439f6 <= var_d017352bffc438f8 && var_a104b4b86ea439f6 < var_30f5ea3b5bc36327 && var_a104b4b86ea439f6 < var_265e28da43deed4f) {
    var_558aadd2c4f2af41++;
    caststarts = [caststartcenter, caststartleft];
  } else if(var_265e28da43deed4f <= var_d017352bffc438f8 && var_265e28da43deed4f < var_30f5ea3b5bc36327 && var_265e28da43deed4f < var_a104b4b86ea439f6) {
    var_558aadd2c4f2af41++;
    caststarts = [caststartcenter, caststartright];
  } else if(var_30f5ea3b5bc36327 <= var_d017352bffc438f8) {
    var_558aadd2c4f2af41++;
    caststarts = [caststartleft, caststartright];
  } else {
    caststarts = [caststartcenter, caststartleft, caststartright];
  }

  castdir = (0, 0, -1);
  castdist = 6 + 2.5;

  foreach(caststart in caststarts) {
    castend = caststart + castdir * castdist;
    castresult = physics_raycast(caststart, castend, contents, ignorelist, 0, "physicsquery_all", 1);

    if(!isDefined(castresult) || castresult.size <= 0) {
      continue;
    }

    hitent = castresult[0]["entity"];

    if(isDefined(hitent) && !tac_cover_can_place_on(hitent)) {
      tac_cover_fire_failed();
      return false;
    }

    var_558aadd2c4f2af41++;

    if(var_558aadd2c4f2af41 >= 2) {
      break;
    }
  }

  if(var_558aadd2c4f2af41 < 2) {
    tac_cover_fire_failed();
    return false;
  }

  self.taccoverrefund = undefined;
  thread tac_cover_spawn(spawnpos, castangles, var_7a2d144a06a00b97, issuper, contents);
  return true;
}

function tac_cover_get_stuck_to_ent(hitent) {
  if(isDefined(hitent)) {
    if(is_train_ent(hitent)) {
      return hitent;
    }
  }

  return undefined;
}

function is_train_ent(hitent) {
  if(isDefined(level.wztrain_info)) {
    foreach(ent in level.wztrain_info.train_array) {
      if(ent == hitent) {
        return true;
      }
    }
  }

  return false;
}

function tac_cover_adjust_for_player_space(spawnpos, spawnangles, contents) {
  frontspace = tac_cover_get_free_space(1, spawnpos, spawnangles, contents, 32);

  if(!isDefined(frontspace)) {
    return spawnpos;
  }

  backspace = tac_cover_get_free_space(0, spawnpos, spawnangles, contents, 32);

  if(!isDefined(backspace)) {
    return spawnpos;
  }

  var_9b7c59cbac03bd88 = min(frontspace, 15);
  forwarddir = anglesToForward(spawnangles);
  newspawnpos = spawnpos + forwarddir * var_9b7c59cbac03bd88;

  foreach(trigger in level.taccovertriggerblockers) {
    if(ispointinvolume(newspawnpos + (0, 0, 20), trigger)) {
      newspawnpos += (0, 0, -6);
      break;
    }
  }

  return newspawnpos;
}

function tac_cover_get_free_space(isfrontcheck, spawnpos, spawnangles, contents, maxcheckdist) {
  leftdir = anglestoleft(spawnangles);
  forwarddir = anglesToForward(spawnangles);
  backwarddir = -1 * forwarddir;
  endoffset = undefined;

  if(isfrontcheck) {
    endoffset = forwarddir * maxcheckdist;
  } else {
    endoffset = backwarddir * maxcheckdist;
  }

  topcenterpos = spawnpos + (0, 0, 48);
  start = topcenterpos;
  end = topcenterpos + endoffset;
  radius = 2.5;
  halfheight = 29 + maxcheckdist;
  angles = combineangles(spawnangles, (0, 0, 90));
  contents = contents;
  ignorelist = [self];
  collectiontype = "physicsquery_closest";
  results = physics_capsulecast(start, end, radius, halfheight, angles, contents, ignorelist, collectiontype);
  isclear = results.size == 0;

  if(getdvarint(@ "hash_a5a0ca488a1da730", 0)) {
    hasanyspace = isclear || results[0]["<dev string:x3b>"] > 0;
    colorstart = ter_op(hasanyspace, (0, 1, 0), (1, 0, 0));
    colorend = ter_op(isclear, (0, 1, 0), (1, 0, 0));
    topleftpos = topcenterpos + leftdir * (29 + maxcheckdist);
    drawstart = topleftpos;
    drawend = topleftpos + endoffset;
    draw_capsule(drawstart, radius, halfheight * 2, angles, colorstart, 0, 500);
    draw_capsule(drawend, radius, halfheight * 2, angles, colorend, 0, 500);
  }

  if(isclear) {
    return undefined;
  }

  shapepos = results[0]["shape_position"];
  dist = distance(shapepos, topcenterpos);
  return dist;
}

function tac_cover_blocked_by_turret(targetpos) {
  if(isDefined(level.turrets)) {
    foreach(turret in level.turrets) {
      if(!isDefined(turret)) {
        continue;
      }

      distsqrd = distancesquared(turret.origin, targetpos);

      if(6400 >= distsqrd) {
        return true;
      }
    }
  }

  return false;
}

function tac_cover_fire_failed(isdoorblocked) {
  errormessage = ter_op(istrue(isdoorblocked), "MP/TAC_COVER_PLACE_IN_DOORWAY", "MP/TAC_COVER_CANNOT_PLACE");

  if(scripts\engine\utility::issharedfuncdefined("hud", "showErrorMessage")) {
    self[[scripts\engine\utility::getsharedfunc("hud", "showErrorMessage")]](errormessage);
  }

  self playsoundtoplayer("iw9_deployable_cover_plant_fail", self);

  if(scripts\cp_mp\equipment::hasequipment("equip_tac_cover")) {
    scripts\cp_mp\equipment::incrementequipmentammo("equip_tac_cover", 1);
  }
}

function tac_cover_entmanagerdelete() {
  thread tac_cover_delete(0);
}

function tac_cover_spawn_with_door(door, doubledoor, issuper, contents) {
  self endon("death_or_disconnect");
  self endon("tac_cover_taken");
  level endon("game_ended");
  assert(isDefined(door), "Must pass in a door entity");
  playerforward = anglesToForward(self.angles);
  var_71ed5ba14eaae576 = door function_bacd2d0acdf8559e() + (0, 90, 0);
  doorforward = anglesToForward(var_71ed5ba14eaae576);
  var_5ac08dec36d1218b = vectordot(playerforward, doorforward);
  issamedirection = var_5ac08dec36d1218b > 0;
  doordegrees = door scriptabledoorangle();
  door val::set("tac_cover_door", "door_frozen", 1);

  if(isDefined(doubledoor)) {
    doubledoor val::set("tac_cover_door", "door_frozen", 1);
  }

  offsetangles = ter_op(issamedirection, (0, 90, 0), (0, -90, 0));
  offsetpos = (0, 0, -1);
  doorpos = door function_d90515f5e17dbc6f() + offsetpos;
  doorangles = combineangles(door function_bacd2d0acdf8559e(), offsetangles);
  var_7422d61f3592ac6e = undefined;
  tac_cover_spawn(doorpos, doorangles, var_7422d61f3592ac6e, issuper, contents, door, doubledoor);
}

function tac_cover_spawn(position, angles, stuckto, issuper, contents, door, doubledoor) {
  self endon("death_or_disconnect");
  self endon("tac_cover_taken");
  level endon("game_ended");
  wait 0.05;
  position = tac_cover_adjust_for_player_space(position, angles, contents);
  self notify("tac_cover_spawned");
  issuper = istrue(issuper);
  cover = spawn("script_model", position);
  cover.angles = angles;
  cover.owner = self;
  cover.team = self.team;
  cover.slot = scripts\cp_mp\equipment::findequipmentslot("equip_tac_cover");
  cover.exploding = 1;
  cover.issuper = ter_op(issuper, 1, undefined);
  cover.superid = level.superglobals.staticsuperdata["super_tac_cover"].id;
  cover scripts\cp_mp\ent_manager::registerspawn(2, &tac_cover_entmanagerdelete);
  cover scripts\mp\sentientpoolmanager::registersentient("Tactical_Static", self);
  cover setentityowner(self);
  cover setotherent(self);
  cover setModel("projectile_deployable_cover_opened_v0");

  if(isDefined(stuckto)) {
    cover.moving_platform = stuckto;
    data = spawnStruct();
    data.linkparent = cover.moving_platform;
    data.deathoverridecallback = &tac_cover_on_destroyed_by_mover;
    data.validateaccuratetouching = 1;
    cover thread scripts\cp\cp_movers::handle_moving_platforms(data);
    cover thread tac_cover_destroy_on_unstuck();
  } else if(isDefined(level.wztrain_info)) {
    data = spawnStruct();
    data.deathoverridecallback = &tac_cover_on_destroyed_by_mover;
    cover thread scripts\cp\cp_movers::handle_moving_platforms(data);
  }

  collision = tac_cover_spawn_collision(cover);

  if(isDefined(collision)) {
    cover validatecollision(collision, level.taccovercollision);
    cover.collision = collision;
    collision.cover = cover;
    collision.moverdoesnotkill = 1;
  }

  if(isDefined(door)) {
    if(isDefined(door.blockingcover)) {
      door.blockingcover tac_cover_destroy();
    }

    cover.blockeddoor = door;
    door.blockingcover = cover;
  }

  if(isDefined(doubledoor)) {
    cover.blockeddoubledoor = doubledoor;
    doubledoor.blockingcover = cover;
  }

  scripts\cp\weapon::onequipmentplanted(cover, "equip_tac_cover", &tac_cover_destroy);
  thread scripts\cp\weapon::monitordisownedequipment(self, cover);

  if(issuper) {
    cover thread tac_cover_destroy_on_disowned(self);
    cover thread tac_cover_destroy_on_timeout();
  }

  cover thread tac_cover_destroy_on_game_end();
  thread tac_cover_spawn_internal(cover);
}

function tac_cover_spawn_internal(cover) {
  cover endon("death");

  if(false) {
    cover tac_cover_set_can_damage(1);
  }

  if(isDefined(cover.blockeddoor)) {
    cover setscriptablepartstate("effects", "plantStartDoor", 0);
  } else {
    cover setscriptablepartstate("effects", "plantStart", 0);
  }

  wait tac_cover_get_deploy_anim_dur();

  if(true) {
    cover tac_cover_set_can_damage(1);
  }

  if(isDefined(cover.blockeddoor)) {
    cover setscriptablepartstate("effects", "plantEndDoor", 0);
    return;
  }

  cover setscriptablepartstate("effects", "plantEnd", 0);
}

function tac_cover_spawn_collision(cover) {
  if(!isDefined(level.taccovercollision)) {
    return;
  }

  collision = spawn("script_model", cover.origin);
  collision dontinterpolate();
  collision.angles = cover.angles;
  collision clonebrushmodeltoscriptmodel(level.taccovercollision);
  collision linkTo(cover);
  collision setentityowner(cover);
  collision disconnectPaths();
  return collision;
}

function tac_cover_destroy(immediate, wasdestroyed) {
  deletiondelay = 0;

  if(!istrue(immediate)) {
    deletiondelay = 0.2 + tac_cover_get_destroy_anim_dur();
  }

  dmg = self.maxhealth;

  if(isDefined(self.damagetaken) && self.damagetaken < self.maxhealth) {
    dmg = self.damagetaken;
  }

  if(!isDefined(dmg)) {
    dmg = 1250;
  }

  self.owner scripts\cp_mp\challenges::function_bd59aa7e8cece1ab("super_tac_cover", int(dmg));
  thread tac_cover_destroy_internal(deletiondelay);
  thread tac_cover_delete(deletiondelay);
}

function tac_cover_destroy_internal(deletiondelay) {
  if(isDefined(self.blockeddoor)) {
    self.blockeddoor val::reset_all("tac_cover_door");
    self.blockeddoor.blockingcover = undefined;
  }

  if(isDefined(self.blockeddoubledoor)) {
    self.blockeddoubledoor val::reset_all("tac_cover_door");
    self.blockeddoubledoor.blockingcover = undefined;
  }

  if(deletiondelay > 0) {
    self setscriptablepartstate("effects", "destroyStart");
    wait tac_cover_get_destroy_anim_dur();
    self setscriptablepartstate("effects", "destroyEnd");
  }

  if(isDefined(self.collision)) {
    self.collision connectpaths();
    self.collision delete();
  }
}

function tac_cover_delete(deletiondelay) {
  self notify("death");
  level.mines[self getentitynumber()] = undefined;
  owner = self.owner;

  if(true) {
    scripts\cp\weapon::monitordamageend();
    self thermaldrawdisable();
  }

  if(isDefined(self.collision)) {
    self.collision connectpaths();
    self.collision delete();
  }

  wait deletiondelay;
  self delete();
}

function tac_cover_destroy_on_timeout() {
  self endon("death");
  wait level.taccover_timeout;
  tac_cover_destroy(undefined, 0);
}

function tac_cover_destroy_on_game_end() {
  self endon("death");
  level waittill("game_ended");
  tac_cover_destroy(undefined, 0);
}

function tac_cover_destroy_on_unstuck() {
  self endon("death");

  while(isDefined(self getlinkedparent())) {
    waitframe();
  }

  tac_cover_destroy(undefined, 0);
}

function tac_cover_set_can_damage(bool) {
  if(true) {
    if(bool) {
      var_307667d0142f2035 = scripts\cp\utility::_hasperk("specialty_rugged_eqp");
      maxhealth = ter_op(var_307667d0142f2035, 1250, 1000);
      damagefeedback = "hitequip";
      thread scripts\cp\weapon::monitordamage(maxhealth, damagefeedback, &tac_cover_handle_fatal_damage, &tac_cover_handle_damage, 0);
      self thermaldrawenable();
      return;
    }

    scripts\cp\weapon::monitordamageend();
    self thermaldrawdisable();
  }
}

function tac_cover_handle_damage(data) {
  damage = tac_cover_adjust_damage(data);

  if(isDefined(self.owner)) {
    remaininghealth = max(self.maxhealth - self.damagetaken, 0);
    var_c738e38fa087114b = int(min(remaininghealth, damage));
  }

  return damage;
}

function tac_cover_adjust_damage(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  meansofdeath = data.meansofdeath;
  damage = data.damage;
  pos = data.point;

  if(objweapon.basename == "thermite_av_mp") {
    return 200;
  }

  if(scripts\cp\weapon::issmallsplashdamage(data.objweapon)) {
    return 0;
  }

  if(objweapon.basename == "thermite_bolt_mp") {
    return 83.3333;
  }

  if(objweapon.basename == "thermite_xmike109_mp") {
    return 62.5;
  }

  if(meansofdeath == "MOD_MELEE" || meansofdeath == "MOD_IMPACT") {
    if(meansofdeath == "MOD_IMPACT" && objweapon.classname == "grenade") {
      return damage;
    }

    return 333.333;
  }

  if(scripts\cp\cp_weapons::isthrowingknife(objweapon.basename)) {
    return 0;
  }

  if(objweapon.basename == "iw9_dm_crossbow_mp" && meansofdeath != "MOD_MELEE") {
    return 0;
  }

  if(meansofdeath == "MOD_CRUSH" && isDefined(data.inflictor) && data.inflictor.classname == "script_vehicle") {
    if(isDefined(attacker) && !scripts\cp\damage::friendlyfirecheck(self.owner, attacker)) {
      return damage;
    }
  }

  if(isexplosivedamagemod(data.meansofdeath)) {
    if(objweapon.basename == "semtex_xmike109_mp") {
      return 333.333;
    }

    return 700;
  }

  damage = scripts\cp\damage::handleapdamage(objweapon, meansofdeath, damage, attacker);
  damage = scripts\cp\damage::handleshotgundamage(objweapon, meansofdeath, damage);
  return damage;
}

function tac_cover_give_new() {
  if(self hasweapon("tac_cover_mp")) {
    self takeweapon("tac_cover_mp");
  }

  var_97ada5e8bebe7579 = scripts\cp\loot_system::get_empty_munition_slot(self);

  if(isDefined(var_97ada5e8bebe7579)) {
    scripts\cp\munitions::give_munition_to_slot("deployable_cover", var_97ada5e8bebe7579);
  }
}

function tac_cover_handle_fatal_damage(data) {
  attacker = data.attacker;

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker))) {
    attacker notify("destroyed_equipment");
    attacker thread scripts\cp\points::doscoreevent(#"destroyed_equipment");
    attacker thread scripts\cp\cp_player_battlechatter::equipmentdestroyed(self);
  }

  thread tac_cover_destroy(undefined, 1);
}

function tac_cover_deploy_freeze_controls() {
  if(!isDefined(self.taccoverfrozecontrols)) {
    slot = scripts\cp_mp\equipment::findequipmentslot("equip_tac_cover");

    if(slot == "primary") {
      val::set("tac_cover_deploy", "equipment_primary", 0);
    } else {
      val::set("tac_cover_deploy", "equipment_secondary", 0);
    }

    val::set("tac_cover_deploy", "usability", 0);
    val::set("tac_cover_deploy", "gesture", 0);
    self.taccoverfrozecontrols = slot;
  }
}

function tac_cover_deploy_unfreeze_controls() {
  if(isDefined(self.taccoverfrozecontrols)) {
    slot = self.taccoverfrozecontrols;
    val::reset_all("tac_cover_deploy");
    self.taccoverfrozecontrols = undefined;
  }
}

function tac_cover_ignore_list(player) {
  ignorelist = [player];

  if(isDefined(level.grenades)) {
    foreach(grenade in level.grenades) {
      if(isDefined(grenade)) {
        ignorelist[ignorelist.size] = grenade;
      }
    }
  }

  if(isDefined(level.missiles)) {
    foreach(missile in level.missiles) {
      if(isDefined(missile)) {
        ignorelist[ignorelist.size] = missile;
      }
    }
  }

  if(isDefined(level.mines)) {
    foreach(mine in level.mines) {
      if(!isDefined(mine)) {
        continue;
      }

      isowner = isDefined(mine.owner) && mine.owner == player;
      istaccover = isDefined(mine.equipmentref) && mine.equipmentref == "equip_tac_cover";
      isweapondrop = isDefined(mine.equipmentref) && mine.equipmentref == "equip_ammo_box";

      if(!isowner && (istaccover || isweapondrop)) {
        continue;
      }

      ignorelist[ignorelist.size] = mine;

      if(isDefined(mine.collision)) {
        ignorelist[ignorelist.size] = mine.collision;
      }
    }
  }

  return ignorelist;
}

function tac_cover_can_place_on(ent) {
  if(isPlayer(ent)) {
    return false;
  }

  if(ent getnonstick()) {
    return false;
  }

  if(istrue(ent.mountmantlemodel)) {
    return false;
  }

  if(isDefined(ent.cover) && isDefined(ent.cover.equipmentref) && ent.cover.equipmentref == "equip_tac_cover") {
    return false;
  }

  if(ent.classname == "misc_turret") {
    return false;
  }

  if(ent.classname == "script_vehicle") {
    return false;
  }

  return true;
}

#using_animtree("scriptables");

function tac_cover_get_deploy_anim_dur() {
  return getanimlength(%wm_spawn_2h_deployable_cover_fire);
}

function tac_cover_get_destroy_anim_dur() {
  return false;
}

function tac_cover_on_fired_super() {
  return tac_cover_on_fired(undefined, undefined, undefined, 1);
}

function tac_cover_on_take_super() {
  tac_cover_on_take(undefined, undefined, 1);
}

function tac_cover_destroy_on_disowned(owner) {
  self endon("death");
  owner endon("tac_cover_taken");
  owner waittill_any_2("joined_team", "disconnect");
  thread tac_cover_destroy(undefined, 0);
}

function tac_cover_on_destroyed_by_mover(data) {
  tac_cover_destroy(undefined, 0);
}