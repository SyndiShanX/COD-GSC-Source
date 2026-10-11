/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\cp_claymore.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp\cp_claymore;
#using scripts\cp\cp_deployablebox;
#using scripts\cp\cp_juggernaut;
#using scripts\cp\equipment;
#using scripts\cp\laststand;
#using scripts\cp\utility;
#using scripts\cp\weapon;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\equipment;
#using scripts\cp_mp\equipment_interact;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle_mines;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\stealth\debug;
#namespace cp_claymore;

function claymore_init() {
  level._effect["claymore_explode"] = loadfx("vfx/iw9/core/equipment/vfx_equip_claymore_trigger.vfx");

  while(!isDefined(level.vehicle) || !isDefined(level.vehicle.minetriggerdata)) {
    waitframe();
  }

  minetriggerdata = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataformine("equip_claymore", 1);
  minetriggerdata.triggercallback = &claymore_triggerfromvehicle;
  setdvarifuninitialized(@ "hash_135469cd54831746", 0);
  setdvarifuninitialized(@ "hash_4e07eb392d33f1da", 1000);
  setdvarifuninitialized(@ "hash_fe3f3cd55b08493c", 200);
  setdvarifuninitialized(@ "hash_6a70857a4a8e02f8", 1000);
  setdvarifuninitialized(@ "hash_dd3c99b07675fd4a", 200);
}

function claymore_use(grenade) {
  self endon("death");
  self endon("disconnect");
  grenade endon("death");
  grenade.exploding = 1;
  grenade.owner_name = self.name;
  tableinfo = scripts\cp_mp\equipment::getequipmenttableinfo("equip_claymore");
  grenade.bundle = tableinfo.bundle;
  thread monitordisownedequipment(self, grenade);
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
  plantdata.plantoffsetz = 3;
  plantresult = scripts\cp\equipment::plant(grenade, plantdata);

  if(!istrue(plantresult)) {
    self iprintlnbold("<dev string:x1c>");

    grenade.owner notify("pickup_equipment", grenade.weapon_name);
    grenade delete();
    return;
  }

  linkedparent = grenade getlinkedparent();

  if(isDefined(linkedparent)) {
    grenade explosivehandlemovers(linkedparent);
  }

  grenade.exploding = 0;
  grenade thread claymore_plant();
}

function claymore_plant() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");

  if(isDefined(self.owner) && isPlayer(self.owner)) {
    self.owner endon("disconnect");
  }

  owner = self.owner;
  pickup_str = spawnStruct();
  pickup_str.scriptablename = "brloot_offhand_claymore";
  pickup_str.equipname = level.br_pickups.br_equipname[pickup_str.scriptablename];
  pickup_str.maxcount = self.owner scripts\cp_mp\equipment::getequipmentmaxammo(pickup_str.equipname);
  pickup_str.count = 1;
  pickup_str.origin = self.origin;
  thread makeexplosiveusabletag("tag_use", 1, undefined, pickup_str);

  if(isDefined(self.owner) && isPlayer(self.owner)) {
    weap_name = ter_op(function_240f7f4e57340e8f(), "jup_claymore_cp", "claymore_mp");
    owner onlethalequipmentplanted(self, weap_name);
    thread monitordisownedequipment(owner, self);
  } else {
    level thread add_to_mine_list(self);
  }

  self missilethermal();
  self missileoutline();

  if(isDefined(self.owner) && isPlayer(self.owner)) {
    self setentityowner(owner);
    self setotherent(owner);
  }

  self setnodeploy(1);
  self.headiconid = scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 5, undefined, undefined, undefined, 0.1);
  thread minedamagemonitor();
  thread claymore_explodeonnotify();
  thread claymore_destroyonemp();
  self setscriptablepartstate("plant", "active", 0);
  owner setscriptablepartstate("equipClaymoreFXView", "plant", 0);
  thread claymore_forceclampangles();
  wait self.bundle.var_fc5fafaec60831f9;
  self enableplayermarks("equipment");
  self setscriptablepartstate("arm", "active", 0);
  thread claymore_watchfortrigger();
}

function claymore_forceclampangles() {
  self endon("mine_selfdestruct");
  self endon("death");
  endtime = gettime() + 2000;

  while(endtime > gettime()) {
    yawonly = (0, self.angles[1], 0);
    maxdiff = 15;
    self.angles = anglelerpquat(yawonly, self.angles, maxdiff);
    waitframe();
  }
}

function claymore_watchfortrigger() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");
  contents = physics_createcontents(["physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicle", "physicscontents_glass", "physicscontents_water"]);

  childthread function_68f18447b57f4963();

  while(true) {
    self waittill("trigger_grenade", entarr);
    assert(isDefined(entarr));

    if(istrue(self.stunned)) {
      continue;
    }

    foreach(ent in entarr) {
      if(isDefined(ent.classname)) {
        if(ent.classname == "script_vehicle") {
          if(!scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_shouldvehicletriggermine(ent, self)) {
            continue;
          }

          scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_minetrigger(ent, self);
          break;
        }

        if(isagent(ent) || isPlayer(ent)) {
          if(!isalive(ent)) {
            continue;
          }

          forward = anglesToForward(self.angles);
          up = anglestoup(self.angles);
          cast_offset = ter_op(function_240f7f4e57340e8f(), 4, 0);
          castorigin = self.origin + up * cast_offset;
          ignorelist = get_mine_ignore_list();
          var_ad283a45677a1ea3 = ent gettagorigin("j_mainroot");
          eorigins = [var_ad283a45677a1ea3];
          btwn = castorigin - var_ad283a45677a1ea3;

          if(vectordot(btwn, (0, 0, 1)) >= cast_offset) {
            eorigins[eorigins.size] = ent gettagorigin("j_spineupper");
          } else {
            eorigins[eorigins.size] = ent.origin;
          }

          handled = 0;

          foreach(eorigin in eorigins) {
            btwn = eorigin - self.origin;
            var_cc00b910bd1d69c8 = vectordot(btwn, forward);

            if(var_cc00b910bd1d69c8 > 90) {
              continue;
            }

            var_69211973f7d7bbd6 = vectordot(btwn, up);

            if(abs(var_69211973f7d7bbd6) > 32) {
              continue;
            }

            var_a3d051ef761efd24 = vectorNormalize(btwn);
            var_74876e67651c79a6 = vectordot(var_a3d051ef761efd24, forward);

            if(var_74876e67651c79a6 < 0.86602) {
              continue;
            }

            castresults = physics_raycast(castorigin, eorigin, contents, ignorelist, 0, "physicsquery_closest", 1);

            if(isDefined(castresults) && castresults.size > 0) {
              continue;
            }

            handled = 1;
            thread claymore_trigger(ent);
          }

          if(handled) {
            break;
          }
        }
      }
    }
  }
}

function get_mine_ignore_list() {
  ignorelist = [self];

  if(isDefined(level.dynamicladders)) {
    foreach(struct in level.dynamicladders) {
      ignorelist[ignorelist.size] = struct.ents[0];
    }
  }

  linkedents = self getlinkedchildren(1);

  if(!isDefined(linkedents)) {
    linkedents = [];
  }

  linkedents[linkedents.size] = self getlinkedparent();

  foreach(linkedent in linkedents) {
    if(isDefined(linkedent) && linkedent.classname == "grenade") {
      ignorelist[ignorelist.size] = linkedent;
    }
  }

  return ignorelist;
}

function claymore_trigger(ent) {
  self endon("mine_destroyed");
  self endon("death");
  self.owner endon("disconnect");
  self notify("mine_triggered");
  makeexplosiveunusuabletag();
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("trigger", "active", 0);
  explosivetrigger(ent, self.bundle.claymore_graceperiod);
  thread claymore_explode(self.owner, ent);
}

function claymore_triggerfromvehicle(vehicle, mine) {
  mine endon("mine_destroyed");
  mine endon("death");
  mine.owner endon("disconnect");
  mine notify("mine_triggered");
  mine makeexplosiveunusuabletag();
  mine setscriptablepartstate("arm", "neutral", 0);
  mine setscriptablepartstate("trigger", "active", 0);
  wait mine.bundle.var_da8863dc7605cb83;
  mine thread claymore_explodefromvehicletrigger(vehicle);
}

function claymore_explodefromvehicletrigger(vehicle) {
  weap_name = ter_op(function_240f7f4e57340e8f(), "jup_claymore_cp", "claymore_mp");
  vehicle dodamage(self.bundle.var_1686cbcbae48a0fe, self.origin, self.owner, self, "MOD_EXPLOSIVE", makeweapon(weap_name));
  ignoredamageid = vehicle scripts\cp\weapon::non_player_add_ignore_damage_signature(self.owner, makeweapon(weap_name), self, "MOD_EXPLOSIVE");
  thread claymore_explode();
  waitframe();

  if(isDefined(vehicle)) {
    vehicle scripts\cp\weapon::non_player_remove_ignore_damage_signature(ignoredamageid);
  }
}

function claymore_explode(attacker, var_95938587db4f6823) {
  self setscriptablepartstate("plant", "neutral", 0);
  self setscriptablepartstate("trigger", "neutral", 0);
  self setscriptablepartstate("explode", "active", 0);
  level.mines[self getentitynumber()] = undefined;
  self setCanDamage(0);
  makeexplosiveunusuabletag();

  if(isDefined(self.useobj)) {
    self.useobj delete();
  }

  self.exploding = 1;
  owner = self.owner;

  if(isDefined(self.owner) && isDefined(owner.plantedlethalequip)) {
    owner.plantedlethalequip = array_remove(owner.plantedlethalequip, self);
  }

  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
  forward = anglestoup(self.angles);
  right = -1 * anglestoright(self.angles);
  up = anglesToForward(self.angles);
  playFX(getfx("claymore_explode"), self.origin, forward, up);
  owner = ter_op(isent(self.owner), self.owner, undefined);

  if(isPlayer(self.owner)) {
    self radiusdamage(self.origin, self.bundle.var_2870c709e5604e6f, getdvarint(@ "hash_6a70857a4a8e02f8"), getdvarint(@ "hash_dd3c99b07675fd4a"), owner, "MOD_EXPLOSIVE", "claymore_radial_mp");
  } else {
    self radiusdamage(self.origin, self.bundle.var_2870c709e5604e6f, getdvarint(@ "hash_4e07eb392d33f1da"), getdvarint(@ "hash_fe3f3cd55b08493c"), owner, "MOD_EXPLOSIVE", "claymore_radial_mp");
  }

  weap_name = ter_op(function_240f7f4e57340e8f(), "jup_claymore_cp", "claymore_mp");
  level notify("grenade_exploded_during_stealth", self.origin, weap_name, self.owner_name);
  nearby_ai = getaiarrayinradius(self.origin, 2048, "axis");

  foreach(ai in nearby_ai) {
    ai aieventlistenerevent("combat", var_95938587db4f6823, self.origin);

    if(isDefined(var_95938587db4f6823) && isPlayer(var_95938587db4f6823)) {
      ai getenemyinfo(var_95938587db4f6823);
    }
  }

  if(isDefined(var_95938587db4f6823) && isPlayer(var_95938587db4f6823) && !function_240f7f4e57340e8f()) {
    var_95938587db4f6823.var_230a3287f9ad2965 = 1;
    var_95938587db4f6823.shouldskipdeathsshield = 1;
  }

  level notify("trigger_reinforcements_if_applicable");
  earthquake(0.45, 0.7, self.origin, 800);
  self detonate();
}

function function_6c884eee24235c94(attacker, var_95938587db4f6823) {
  level.mines[self getentitynumber()] = undefined;
  self setCanDamage(0);
  makeexplosiveunusuabletag();

  if(isDefined(self.useobj)) {
    self.useobj delete();
  }

  self.exploding = 1;
  owner = self.owner;

  if(isDefined(self.owner) && isDefined(owner.plantedlethalequip)) {
    owner.plantedlethalequip = array_remove(owner.plantedlethalequip, self);
  }

  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
  forward = anglestoup(self.angles);
  right = -1 * anglestoright(self.angles);
  up = anglesToForward(self.angles);
  playFX(getfx("claymore_explode"), self.origin, forward, up);
  weap_name = ter_op(function_240f7f4e57340e8f(), "jup_claymore_cp", "claymore_mp");
  level notify("grenade_exploded_during_stealth", self.origin, weap_name, self.owner_name);
  nearby_ai = getaiarrayinradius(self.origin, 2048, "axis");

  foreach(ai in nearby_ai) {
    ai aieventlistenerevent("combat", var_95938587db4f6823, self.origin);

    if(isDefined(var_95938587db4f6823) && isPlayer(var_95938587db4f6823)) {
      ai getenemyinfo(var_95938587db4f6823);
    }
  }

  if(isDefined(var_95938587db4f6823) && isPlayer(var_95938587db4f6823)) {
    var_95938587db4f6823.var_230a3287f9ad2965 = 1;
    var_95938587db4f6823.shouldskipdeathsshield = 1;
  }

  level notify("trigger_reinforcements_if_applicable");
  self detonate();
}

function claymore_explodeonnotify() {
  self endon("death");

  if(isDefined(self.owner)) {
    self.owner endon("disconnect");
  }

  level endon("game_ended");
  self waittill("detonateExplosive", attacker);
  thread claymore_explode(attacker);
}

function claymore_destroy(destroydelay) {
  if(!isDefined(destroydelay)) {
    destroydelay = 0;
  }

  thread claymore_delete(destroydelay + 0.2);
  wait destroydelay;
  self setscriptablepartstate("destroy", "active", 0);
}

function claymore_destroyonemp() {
  self endon("death");

  if(isDefined(self.owner)) {
    self.owner endon("disconnect");
  }

  level endon("game_ended");

  while(true) {
    self waittill("emp_applied", data);
    attacker = data.attacker;

    if(isDefined(self.owner) && istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker))) {
      attacker notify("destroyed_equipment");
      damagefeedback = "";

      if(istrue(self.hasruggedeqp)) {
        damagefeedback = "hitequip";
      }

      thread claymore_destroy();
    }
  }
}

function claymore_delete(deletiondelay) {
  if(!isDefined(deletiondelay)) {
    deletiondelay = 0;
  }

  self notify("death");

  if(isDefined(self.useobj)) {
    self.useobj delete();
  }

  level.mines[self getentitynumber()] = undefined;
  self setCanDamage(0);
  makeexplosiveunusuabletag();
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
  self.headiconid = undefined;
  self.exploding = 1;
  owner = self.owner;

  if(isDefined(self.owner)) {
    owner.plantedlethalequip = array_remove(owner.plantedlethalequip, self);
  }

  wait deletiondelay;
  self delete();
}

function claymore_modifieddamage(victim, objweapon, inflictor, meansofdeath, damage) {
  if(!isDefined(inflictor)) {
    return damage;
  }

  if(isnullweapon(objweapon)) {
    return damage;
  }

  if(!function_240f7f4e57340e8f()) {
    return damage;
  }

  if(objweapon != makeweapon("claymore_radial_mp")) {
    return damage;
  }

  if(!isexplosivedamagemod(meansofdeath)) {
    return damage;
  }

  tableinfo = scripts\cp_mp\equipment::getequipmenttableinfo("equip_claymore");
  bundle = tableinfo.bundle;
  dist = distance2d(inflictor.origin, victim.origin);
  ratio = 1 - clamp((dist - bundle.var_97202c494b76611a) / (bundle.var_974316494b9c7870 - bundle.var_97202c494b76611a), 0, 1);
  damage = bundle.var_b168faa90cdf9ee4 + (bundle.var_974316494b9c7870 - bundle.var_97202c494b76611a) * ratio;
  return damage;
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
      thread claymore_trigger(player);
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

function spawn_claymore_group(var_9ea7808f138295b7, var_f8f2ebf05b9af55a, floating, canbepickedup, var_617112b94b09e784, var_5c53eb01a38766b8, var_ed96a661e85f5e5c) {
  if(getdvarint(@ "hash_e87416769abd9b7", 0) != 0) {
    return;
  }

  claymores = getStructArray(var_9ea7808f138295b7, "targetname");
  spawned_claymores = [];

  foreach(spawner in claymores) {
    claymore = spawn_enemy_claymore(spawner.origin, spawner.angles, var_f8f2ebf05b9af55a, floating, canbepickedup, var_617112b94b09e784, var_5c53eb01a38766b8, var_ed96a661e85f5e5c);
    spawned_claymores = array_add(spawned_claymores, claymore);
  }

  return spawned_claymores;
}

function spawn_enemy_claymore(origin, angles, var_f8f2ebf05b9af55a, floating, canbepickedup, var_617112b94b09e784, var_5c53eb01a38766b8, var_ed96a661e85f5e5c) {
  parent = undefined;
  claymore = undefined;
  weap_name = ter_op(function_240f7f4e57340e8f(), "jup_claymore_cp", "claymore_mp");

  if(istrue(floating)) {
    parent = spawn_tag_origin(origin, angles);
    claymore = magicgrenademanual(weap_name, origin + (0, 0, 10), (0, 0, 0));
  } else {
    claymore = magicgrenademanual(weap_name, origin + (0, 0, 10), (0, 0, 10));
  }

  claymore childthread plant_enemy_claymore(origin, angles, var_f8f2ebf05b9af55a, parent, canbepickedup, var_617112b94b09e784, var_5c53eb01a38766b8, var_ed96a661e85f5e5c);
  return claymore;
}

function plant_enemy_claymore(origin, angles, var_f8f2ebf05b9af55a, parent, canbepickedup, var_617112b94b09e784, var_5c53eb01a38766b8, var_ed96a661e85f5e5c) {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");

  if(!isDefined(angles)) {
    angles = (0, 0, 0);
  }

  if(!isDefined(canbepickedup)) {
    canbepickedup = 0;
  }

  if(!isDefined(var_617112b94b09e784)) {
    var_617112b94b09e784 = 1;
  }

  if(!isDefined(var_ed96a661e85f5e5c)) {
    var_ed96a661e85f5e5c = ter_op(function_240f7f4e57340e8f(), 1, 0);
  }

  tableinfo = scripts\cp_mp\equipment::getequipmenttableinfo("equip_claymore");
  self.bundle = tableinfo.bundle;

  if(isDefined(var_5c53eb01a38766b8)) {
    armtime = var_5c53eb01a38766b8;
  } else {
    armtime = self.bundle.var_fc5fafaec60831f9;
  }

  self.angles = angles;
  self.owner = spawnStruct();
  self.owner.angles = angles;
  self.owner.team = "neutral";
  self.team = "neutral";
  self.weapon_object = makeweapon("claymore_mp");
  owner = self.owner;
  weap_name = ter_op(function_240f7f4e57340e8f(), "jup_claymore_cp", "claymore_mp");

  if(!isDefined(self.weapon_name)) {
    self.weapon_name = weap_name;
  }

  if(isDefined(parent)) {
    self.parent = parent;
    thread function_1e994dd89f124753();
  }

  if(istrue(canbepickedup)) {
    thread function_a29e39b6de05a901("tag_use", 1);
    self setHintString(&"COOP_GAME_PLAY/DISABLE_TRAP");
  }

  self missilethermal();
  self missileoutline();
  self setnodeploy(1);
  self.headiconid = scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 5, undefined, undefined, undefined, 0.1);

  if(isDefined(level.var_c91a0e8fe84fb300)) {
    self thread[[level.var_c91a0e8fe84fb300]]();
  } else {
    thread minedamagemonitor();
  }

  thread claymore_explodeonnotify();
  thread claymore_destroyonemp();
  self setscriptablepartstate("plant", "active", 0);
  thread claymore_forceclampangles();

  if(!isDefined(level.var_804a2874c0323da7)) {
    level.var_804a2874c0323da7 = [];
  }

  level.var_804a2874c0323da7[level.var_804a2874c0323da7.size] = self;
  wait armtime;
  self enableplayermarks("equipment");
  self setscriptablepartstate("arm", "active", 0);
  self.equipmentref = "equip_claymore";

  if(istrue(var_617112b94b09e784) && !istrue(canbepickedup)) {
    scripts\cp_mp\equipment_interact::_hacksetup();

    if(istrue(var_ed96a661e85f5e5c)) {
      self.var_7f7645497083ef2b = 1;
      thread function_6cb0cbea56d5fb64();
    }
  }

  if(!function_240f7f4e57340e8f()) {
    thread custom_explode_mine(origin, var_ed96a661e85f5e5c);
  }

  thread enemy_claymore_watchfortrigger(var_f8f2ebf05b9af55a, var_ed96a661e85f5e5c);
  thread function_553142ed1d7441e4();
}

function function_a29e39b6de05a901(tagname, isgrenade) {
  self endon("death");
  self endon("makeExplosiveUnusable");
  owner = self.owner;
  weaponname = self.weapon_name;
  equipmentref = scripts\cp_mp\equipment::function_7f245729fcb6414d(weaponname);

  if(!isDefined(isgrenade)) {
    isgrenade = 0;
  }

  self makeusable();

  if(isgrenade) {
    self enablemissilehint(1);
  } else {
    self setCursorHint("HINT_NOICON");
  }

  self sethinttag(tagname);
  self setuserange(72);
  setexplosiveusablehintstring(self.weapon_name);
  extra = 0;

  while(true) {
    self waittill("trigger", player);

    if(!player scripts\cp_mp\equipment::hasequipment(equipmentref)) {
      player thread scripts\cp_mp\equipment::giveequipment(equipmentref, "primary");
      player scripts\cp_mp\equipment::setequipmentammo(equipmentref, extra);
    }

    player notify("pickup_equipment", weaponname);

    if(isDefined(equipmentref) && player scripts\cp_mp\equipment::hasequipment(equipmentref)) {
      player scripts\cp_mp\equipment::incrementequipmentammo(equipmentref, 1);
    }

    if(isDefined(self.useobj)) {
      self.useobj delete();
    }

    thread deleteexplosive();
    return;
  }
}

function function_1e994dd89f124753() {
  level endon("game_ended");
  self endon("death");
  currentpos = self.origin;

  while(self.origin == currentpos) {
    wait 0.05;
  }

  wait 0.5;
  self.origin = self.parent.origin;
  self.angles = self.parent.angles;
  self linkTo(self.parent, "tag_origin");
}

function function_553142ed1d7441e4() {
  level endon("game_ended");
  self waittill("death");
  scripts\cp\cp_juggernaut::function_84bae1e96a725ec5();
  level.var_804a2874c0323da7 = array_removedead(level.var_804a2874c0323da7);
}

function custom_explode_mine(origin, var_ed96a661e85f5e5c) {
  self endon("clean_custom_explode");
  self endon("deleted_equipment");
  forwardpos = origin + (0, 0, 50) + anglesToForward(self.angles) * 95;
  forwardpos_b = origin + (0, 0, 50) + anglesToForward(self.angles) * 30;
  self waittill("death");

  if(istrue(var_ed96a661e85f5e5c) && istrue(self.ishacked)) {
    attacker = level.player;
  } else {
    attacker = getaiarray("axis")[0];
  }

  radiusdamage(forwardpos_b, 30, 1000, 200, attacker, "MOD_EXPLOSIVE", "claymore_radial_mp");
  radiusdamage(forwardpos, 75, 1000, 20, attacker, "MOD_EXPLOSIVE", "claymore_radial_mp");
}

function function_e2b6464932ab9b06() {
  self endon("mine_triggered");
  self endon("mine_selfdestruct");
  self endon("death");
  self setCanDamage(1);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  attacker = undefined;

  while(true) {
    self waittill("damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, objweapon);

    if(istrue(self.isbeingused)) {
      continue;
    }

    if(isDefined(objweapon) && isDefined(objweapon.basename)) {
      var_e36d0c5378e4855b = objweapon.basename;
      var_e36d0c5378e4855b = strip_suffix(var_e36d0c5378e4855b, "_mp");
      var_e36d0c5378e4855b = strip_suffix(var_e36d0c5378e4855b, "_cp");

      if(type != "MOD_MELEE") {
        switch (var_e36d0c5378e4855b) {
          case #"hash_7a7616547d22d1d4":
          case #"hash_cf4e7cba76f5287f":
          case #"hash_ec99c59936c1a84a":
            continue;
        }
      }

      if(type != "MOD_IMPACT") {
        switch (var_e36d0c5378e4855b) {
          case #"hash_1768b8fe4480e4b":
          case #"hash_8059d93d3568c07":
          case #"hash_1b4881cfd42bb6d8":
          case #"hash_42dcb6ce7ecb709c":
          case #"hash_63d44e71602ef0a0":
          case #"hash_752a9051bc22d228":
          case #"hash_8670ac083666f3a4":
          case #"hash_e042760d17966848":
          case #"hash_e1f6f84e4cd950eb":
          case #"hash_fb36696c0708bf42":
            continue;
        }
      }
    }

    self notify("mine_destroyed");

    if(isDefined(type) && (issubstr(type, "MOD_GRENADE") || issubstr(type, "MOD_EXPLOSIVE"))) {
      self.waschained = 1;
    }

    if(isDefined(idflags) && idflags & 8) {
      self.wasdamagedfrombulletpenetration = 1;
    }

    self.wasdamaged = 1;

    if(isDefined(attacker)) {
      self.damagedby = attacker;
    }

    self notify("detonateExplosive", attacker);
    return;
  }
}

function enemy_claymore_watchfortrigger(var_f8f2ebf05b9af55a, var_ed96a661e85f5e5c) {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("mine_selfdestruct");
  self endon("death");
  scripts\cp\cp_juggernaut::function_91ed8c25c9b88686();

  if(!istrue(var_ed96a661e85f5e5c)) {
    self endon("hacked");
  }

  if(isDefined(self.owner)) {
    self.owner endon("disconnect");
  }

  contents = physics_createcontents(["physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicle", "physicscontents_solid", "physicscontents_glass", "physicscontents_water"]);

  childthread function_68f18447b57f4963(1);

  while(true) {
    var_af3b9624c6ab60 = level.players;

    if(istrue(var_ed96a661e85f5e5c) && istrue(self.ishacked)) {
      var_af3b9624c6ab60 = getaiarrayinradius(self.origin, 500, "axis");
    }

    forward = anglesToForward(self.angles);
    up = anglestoup(self.angles);
    cast_offset = ter_op(function_240f7f4e57340e8f(), 2, 0);
    castorigin = self.origin + up * cast_offset;
    ignorelist = [self];

    if(isDefined(level.dynamicladders)) {
      foreach(struct in level.dynamicladders) {
        ignorelist[ignorelist.size] = struct.ents[0];
      }
    }

    if(istrue(var_f8f2ebf05b9af55a) && !istrue(self.ishacked)) {
      var_af3b9624c6ab60 = array_combine(var_af3b9624c6ab60, getaiarray("allies"));
    }

    playervehicles = [];

    foreach(player in level.players) {
      if(isDefined(player.vehicle)) {
        playervehicles[playervehicles.size] = player.vehicle;
      }
    }

    var_af3b9624c6ab60 = array_combine(playervehicles, var_af3b9624c6ab60);

    foreach(var_548b9f6609ce3883 in var_af3b9624c6ab60) {
      if(!isDefined(var_548b9f6609ce3883) || !isDefined(var_548b9f6609ce3883.classname)) {
        function_586357fa08699f61(castorigin, "<dev string:x29>");

        continue;
      }

      if(isPlayer(var_548b9f6609ce3883) && scripts\cp\laststand::player_in_laststand(var_548b9f6609ce3883) || isagent(var_548b9f6609ce3883) && !isalive(var_548b9f6609ce3883)) {
        function_586357fa08699f61(castorigin, "<dev string:x32>");

        continue;
      }

      isvehicle = var_548b9f6609ce3883.classname == "script_vehicle";

      if(!isvehicle && lengthsquared(var_548b9f6609ce3883 getentityvelocity()) < 10) {
        function_586357fa08699f61(castorigin, "<dev string:x37>");

        continue;
      }

      if(distance2dsquared(var_548b9f6609ce3883.origin, self.origin) > 50625) {
        function_586357fa08699f61(castorigin, "<dev string:x47>");

        continue;
      }

      var_ad283a45677a1ea3 = var_548b9f6609ce3883.origin;

      if(var_548b9f6609ce3883 tagexists("j_mainroot")) {
        var_ad283a45677a1ea3 = var_548b9f6609ce3883 gettagorigin("j_mainroot");
      }

      eorigins = [var_ad283a45677a1ea3];
      btwn = castorigin - var_ad283a45677a1ea3;
      cast_offset = ter_op(function_240f7f4e57340e8f(), 4, 0);

      if(var_548b9f6609ce3883 tagexists("j_spineupper") && vectordot(btwn, (0, 0, 1)) >= cast_offset) {
        eorigins[eorigins.size] = var_548b9f6609ce3883 gettagorigin("j_spineupper");
      } else {
        eorigins[eorigins.size] = var_548b9f6609ce3883.origin;
      }

      foreach(eorigin in eorigins) {
        btwn = eorigin - castorigin;
        var_cc00b910bd1d69c8 = vectordot(btwn, forward);
        dist_min = ter_op(function_240f7f4e57340e8f(), 5, 20);

        if(var_cc00b910bd1d69c8 < dist_min) {
          function_586357fa08699f61(castorigin, "<dev string:x53>");

          continue;
        }

        dist_max = ter_op(isvehicle, 130, 90);

        if(var_cc00b910bd1d69c8 > dist_max) {
          function_586357fa08699f61(castorigin, "<dev string:x5d>");

          continue;
        }

        var_69211973f7d7bbd6 = vectordot(btwn, up);
        var_1697376a5cebb581 = ter_op(isvehicle, 64, 32);

        if(abs(var_69211973f7d7bbd6) > var_1697376a5cebb581) {
          function_586357fa08699f61(castorigin, "<dev string:x65>");

          continue;
        }

        var_a3d051ef761efd24 = vectorNormalize(btwn);
        var_74876e67651c79a6 = vectordot(var_a3d051ef761efd24, forward);

        if(!isvehicle && var_74876e67651c79a6 < 0.86602) {
          function_586357fa08699f61(castorigin, "<dev string:x6e>");

          continue;
        }

        castresults = physics_raycast(castorigin, eorigin, contents, ignorelist, 0, "physicsquery_closest", 1);

        if(getdvarint(@ "hash_135469cd54831746") == 1) {
          debug_results = scripts\engine\trace::internal_create_debug_data(castresults, "<dev string:x7b>", castorigin, eorigin);
          thread scripts\engine\trace::draw_trace(debug_results, (1, 1, 1), 1, 5);
        }

        if(isvehicle) {
          if(!isDefined(castresults) || !castresults.size) {
            function_586357fa08699f61(castorigin, "<dev string:x7f>");

            continue;
          }
        } else if(!castresults.size) {
          thread scripts\cp\cp_claymore::claymore_trigger(var_548b9f6609ce3883);
          return;
        }

        var_781a64fe27be0f73 = 0;

        foreach(result in castresults) {
          if(!isDefined(result["entity"])) {
            continue;
          }

          if(result["entity"] == var_548b9f6609ce3883) {
            var_781a64fe27be0f73 = 1;
          }
        }

        if(isPlayer(var_548b9f6609ce3883)) {
          var_781a64fe27be0f73 = 1;
        }

        if(!var_781a64fe27be0f73) {
          function_586357fa08699f61(castorigin, "<dev string:x9b>");

          continue;
        }

        thread scripts\cp\cp_claymore::claymore_trigger(var_548b9f6609ce3883);
      }
    }

    wait 0.05;
  }
}

function function_6cb0cbea56d5fb64() {
  self waittill("hacked");

  function_586357fa08699f61(self.origin, "<dev string:xd0>");

  self.team = "allies";
  self.ishacked = 1;
  self setscriptablepartstate("hacked", "neutral", 0);
  self setscriptablepartstate("arm", "active", 0);
  pickup_str = spawnStruct();
  pickup_str.scriptablename = "brloot_offhand_claymore";
  pickup_str.equipname = level.br_pickups.br_equipname[pickup_str.scriptablename];
  pickup_str.maxcount = self.owner scripts\cp_mp\equipment::getequipmentmaxammo(pickup_str.equipname);
  pickup_str.count = 1;
  pickup_str.origin = self.origin;
  thread makeexplosiveusabletag("tag_use", 1, undefined, pickup_str);
}

function function_68f18447b57f4963(draw_min) {
  while(true) {
    if(getdvarint(@ "hash_135469cd54831746") == 1) {
      forward = anglesToForward(self.angles);
      up = anglestoup(self.angles);
      cast_offset = ter_op(function_240f7f4e57340e8f(), 4, 0);
      dist_min = ter_op(function_240f7f4e57340e8f(), 5, 20);
      castorigin = self.origin + up * cast_offset;
      thread scripts\stealth\debug::draw_arc(castorigin, -15, 15, self.angles, 130, 1, 15, (1, 1, 0));
      thread scripts\stealth\debug::draw_arc(castorigin, -15, 15, self.angles, 90, 1, 15, (1, 0, 0));

      if(istrue(draw_min)) {
        thread scripts\stealth\debug::draw_arc(castorigin, -15, 15, self.angles, dist_min, 1, 15, (0, 1, 0));
      }
    }

    waitframe();
  }
}

function function_586357fa08699f61(castorigin, text) {
  if(getdvarint(@ "hash_135469cd54831746") == 1) {
    print3d(castorigin, text, undefined, undefined, 0.25);
  }
}

# /