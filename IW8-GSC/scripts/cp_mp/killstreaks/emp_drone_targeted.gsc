/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\killstreaks\emp_drone_targeted.gsc
************************************************************/

function init() {
  level._effect["vfx/iw8/level/safehouse/vfx_safehouse_finale_drone_wingtip_red_lit.vfx"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_finale_drone_wingtip_red_lit.vfx");
  level._effect["vfx/iw8/level/safehouse/vfx_safehouse_finale_drone_contrails.vfx"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_finale_drone_contrails.vfx");
  level._effect["vfx/iw8/level/safehouse/vfx_safehouse_finale_drone_heat_dist.vfx"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_finale_drone_heat_dist.vfx");
  level._effect["vfx/iw8_mp/killstreak/vfx_rc_plane_rotor.vfx"] = loadfx("vfx/iw8_mp/killstreak/vfx_rc_plane_rotor.vfx");
  level._effect["vfx/iw8_mp/perk/vfx_emp_drone_exp_fieldupgrades.vfx"] = loadfx("vfx/iw8_mp/perk/vfx_emp_drone_exp_fieldupgrades.vfx");
  level._effect["vfx/iw8_mp/perk/vfx_emp_drone_airexp.vfx"] = loadfx("vfx/iw8_mp/perk/vfx_emp_drone_airexp.vfx");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("emp_drone_targeted", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("emp_drone_targeted", "init")]]();
    return;
  }
}

function empdrone_beginsuper() {
  self endon("death_or_disconnect");
  self endon("reconDroneEnded");
  self endon("reconDroneUnset");
  thread empdrone_superusethink();
  return true;
}

function empdrone_superusethink() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  var_0 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("emp_drone", self);
  var_1 = empdrone_tryuse(var_0);
  wait 0.05;

  if(var_1) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "superUseFinished")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "superUseFinished")]]();
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "trySayLocalSound")) {
      level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "trySayLocalSound")]](self, "use_emp_drone");
      return;
    }

    return;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "superUseFinished")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "superUseFinished")]](1);
    return;
  }
}

function empdrone_tryuse(var_0) {
  scripts\cp_mp\killstreaks\killstreakdeploy::ondeploystart(var_0);
  var_1 = getcompleteweaponname("ks_remote_map_mp");
  var_2 = &scripts\cp_mp\killstreaks\killstreakdeploy::waituntilfinishedwithdeployweapon;
  var_3 = &empdrone_weapongiven;
  var_4 = scripts\cp_mp\killstreaks\killstreakdeploy::switchtodeployweapon(var_1, var_0, var_2, var_3);
  scripts\cp_mp\killstreaks\killstreakdeploy::ondeployfinished(var_0, istrue(var_4));

  if(!istrue(var_4)) {
    return false;
  }

  var_5 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("empDroneTargeted", "getSelectMapPoint")) {
    var_5 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("empDroneTargeted", "getSelectMapPoint")]](var_0, 1);
  } else {
    return false;
  }

  if(!isDefined(var_5)) {
    return false;
  }

  thread empdrone_createdrone(var_0, var_5[0].location);
  return true;
}

function empdrone_equipment_wrapper(var_0, var_1, var_2) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("equipment", "takeEquipment")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("equipment", "takeEquipment")]](var_1);
  }

  var_3 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("emp_drone", self);
  var_4 = empdrone_tryuse(var_3);

  if(!var_4) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("equipment", "giveEquipment")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("equipment", "giveEquipment")]]("equip_empdrone", var_1);
      return;
    }

    return;
  }
}

function empdrone_weapongiven(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("empDroneTargeted", "startMapSelectSequence")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("empDroneTargeted", "startMapSelectSequence")]](0, 0, undefined, 3);
  } else {
    return false;
  }

  return true;
}

function empdrone_createdrone(var_0, var_1) {
  self endon("disconnect");
  level endon("game_ended");
  var_2 = empdrone_calculatepositions(var_1);
  var_3 = scripts\cp_mp\utility\weapon_utility::_magicbullet(getcompleteweaponname("emp_drone_proj_mp"), var_2.startpos, var_2.targetpos, self);
  var_3 setentityowner(self);
  var_3.owner = self;
  var_3.ownerid = self getentitynumber();
  var_3.team = self.team;
  var_3.streakinfo = var_0;
  var_3.usedcount = 0;
  var_3.superid = level.superglobals.staticsuperdata["super_emp_drone"].id;
  var_3 hidepart("j_propeller");
  playFXOnTag(scripts\engine\utility::getfx("vfx/iw8/level/safehouse/vfx_safehouse_finale_drone_wingtip_red_lit.vfx"), var_3, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("vfx/iw8/level/safehouse/vfx_safehouse_finale_drone_contrails.vfx"), var_3, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("vfx/iw8/level/safehouse/vfx_safehouse_finale_drone_heat_dist.vfx"), var_3, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("vfx/iw8_mp/killstreak/vfx_rc_plane_rotor.vfx"), var_3, "j_propeller");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("empDroneTargeted", "monitorDamage")) {
    var_3 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("empDroneTargeted", "monitorDamage")]](25, "hitequip", &empdrone_handledeathdamage, undefined, 0);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    var_3[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](var_0.streakname, "Killstreak_Air", self, 0, 1, 25);
  }

  var_3 playLoopSound("iw8_rc_plane_engine");
  thread empdrone_timeoutthink();
  thread monitorweaponswitchbr();
  thread empdrone_collidethink();

  if(getdvarint("scr_empDrone_target_test", 0) == 0) {
    thread empdrone_divebombthink(var_3);
  } else {
    thread morales_laptop_initted(var_3);
  }

  var_3 scripts\cp_mp\emp_debuff::set_apply_emp_callback(&empdrone_empapplied);
  return var_3;
}

function empdrone_calculatepositions(var_0) {
  var_1 = scripts\cp_mp\utility\killstreak_utility::removeextracthelipad();
  var_2 = (0, 0, 1500);

  if(isDefined(var_1)) {
    var_3 = var_1.origin[2] + -1500;
    var_2 = (0, 0, var_3);
  }

  var_4 = anglesToForward(self.angles);
  var_5 = undefined;
  var_6 = 0;
  var_7 = 0;
  var_8 = 0;

  for(;;) {
    var_9 = rotatevector(var_4, (0, var_7, 0));
    var_10 = var_2 + var_0;
    var_5 = var_10 - var_9 * 4500;
    var_11 = (0, 0, 1500);
    var_5 += var_11;
    var_12 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot"]);
    var_6 = scripts\engine\trace::ray_trace_passed(var_5, var_10, undefined, var_12);
    var_8++;

    if(var_6) {
      break;
    }

    if(var_8 >= 13) {
      break;
    }

    wait 0.05;
    var_7 += 55.3;
  }

  var_13 = vectorNormalize(var_5 - var_10) * 1000 + var_10;
  var_14 = spawnStruct();
  var_14.startpos = var_5;
  var_14.divebombpos = var_13;
  var_14.targetpos = var_0;
  return var_14;
}

function empdrone_timeoutthink() {
  level endon("game_ended");
  self.owner endon("disconnect");
  self endon("death");
  var_0 = gettime() * 0.001;
  var_1 = var_0 + 20;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_1);
  thread empdrone_destroy();
}

function monitorweaponswitchbr() {
  self.owner endon("disconnect");
  self endon("death");
  level scripts\engine\utility::ref_143A5("game_ended", "prematch_cleanup");
  thread empdrone_destroy();
}

function empdrone_collidethink() {
  level endon("game_ended");
  self.owner endon("disconnect");
  self endon("death");
  self waittill("missile_stuck");
  thread empdrone_explode();
}

function empdrone_divebombthink(var_0) {
  level endon("game_ended");
  self.owner endon("disconnect");
  self endon("death");
  self missile_settargetpos(var_0.divebombpos);
  var_1 = 50;

  while(distancesquared(var_0.divebombpos, self.origin) > var_1 * var_1) {
    wait 0.05;
  }

  var_2 = anglesToForward(self.angles);
  var_3 = distance(var_0.targetpos, self.origin);
  var_4 = self.origin + var_2 * var_3;
  var_5 = gettime();
  var_6 = 0;
  var_7 = 0;

  for(;;) {
    wait 0.05;
    var_6 = (gettime() - var_5) / 1300;
    var_6 = clamp(var_6, 0, 1);
    var_8 = var_4 * (1 - var_6) + var_0.targetpos * var_6;
    self missile_settargetpos(var_8);
  }
}

function morales_laptop_initted(var_0) {}

function empdrone_handledeathdamage(var_0, var_1, var_2) {
  empdrone_givepointsfordeath(var_0);
  empdrone_destroy();
}

function empdrone_explode() {
  self playSound("iw8_rc_plane_engine_exp");
  var_0 = anglesToForward(self.angles);
  playFX(scripts\engine\utility::getfx("vfx/iw8_mp/perk/vfx_emp_drone_exp_fieldupgrades.vfx"), self.origin, var_0);
  empdrone_explodeemp();
  empdrone_delete();
}

function empdrone_destroy() {
  self playSound("recondrone_damaged");
  var_0 = anglesToForward(self.angles);
  playFX(scripts\engine\utility::getfx("vfx/iw8_mp/perk/vfx_emp_drone_airexp.vfx"), self.origin, var_0);
  empdrone_delete();
}

function empdrone_delete() {
  self stoploopsound("iw8_rc_plane_engine");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("challenges", "onFieldUpgradeEnd")) {
    self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("challenges", "onFieldUpgradeEnd")]]("super_emp_drone", self.usedcount);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("dlog", "fieldUpgradeExpired")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("dlog", "fieldUpgradeExpired")]](self.owner, self.superid, self.usedcount, 0);
  }

  self delete();
}

function empdrone_empapplied(var_0) {
  var_1 = var_0.attacker;
  empdrone_givepointsfordeath(var_1);
  empdrone_destroy();
}

function empdrone_givepointsfordeath(var_0) {
  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_0))) {
    var_0 notify("destroyed_equipment");

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "giveUnifiedPoints")) {
      var_0 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "giveUnifiedPoints")]]("destroyed_equipment");
      return;
    }

    return;
  }
}

function empdrone_explodeemp() {
  var_0 = getcompleteweaponname("emp_drone_non_player_mp");
  var_1 = getcompleteweaponname("emp_drone_non_player_direct_mp");
  var_2 = [];
  var_3 = scripts\cp_mp\emp_debuff::get_emp_ents();

  foreach(var_5 in var_3) {
    if(var_5 == self) {
      continue;
    }

    var_6 = var_5.owner;

    if(isDefined(var_6)) {
      if(var_6 != self.owner && !scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_6)) {
        continue;
      }
    }

    var_7 = distancesquared(self.origin, var_5.origin);

    if(var_7 > 640000) {
      continue;
    }

    var_8 = var_5 scripts\cp_mp\vehicles\vehicle::isvehicle();
    var_9 = scripts\cp_mp\vehicles\vehicle_occupancy::ref_141DE(var_5);

    if(var_8 && var_9) {
      var_10 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var_5);

      foreach(var_12 in var_10) {
        var_2 = var_12;
      }
    }

    var_14 = scripts\engine\utility::ter_op(var_7 > 6400, var_0, var_1);
    var_5 dodamage(1, self.origin, self.owner, self, "MOD_EXPLOSIVE", var_14);
    var_15 = scripts\cp_mp\utility\damage_utility::packdamagedata(self.owner, var_5, 1, var_14, "MOD_EXPLOSIVE", self, self.origin);
    thread empdrone_applyemp(var_15);
  }

  var_17 = getcompleteweaponname("emp_drone_player_mp");
  self radiusdamage(self.origin, 80, 120, 80, self.owner, "MOD_EXPLOSIVE", var_17);
  var_18 = scripts\common\utility::playersinsphere(self.origin, 800);
  var_18 = scripts\engine\utility::array_combine_unique(var_18, var_2);

  foreach(var_20 in var_18) {
    if(!isDefined(var_20)) {
      continue;
    }

    if(!var_20 scripts\cp_mp\emp_debuff::can_emp_player()) {
      continue;
    }

    if(var_20 != self.owner && !scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_20)) {
      continue;
    }

    var_20 dodamage(1, self.origin, self.owner, self, "MOD_EXPLOSIVE", var_17);
    var_15 = scripts\cp_mp\utility\damage_utility::packdamagedata(self.owner, var_20, 1, var_17, "MOD_EXPLOSIVE", self, self.origin);
    thread empdrone_applyemp(var_15);
  }

  var_22 = scripts\common\utility::playersinsphere(self.origin, 2000);
  var_22 = scripts\engine\utility::array_combine_unique(var_22, var_2);

  foreach(var_20 in var_22) {
    if(!isDefined(var_20)) {
      continue;
    }

    if(var_20 == self.owner) {
      continue;
    }

    var_20 earthquakeforplayer(0.3, 1, self.origin, 2000);
    var_20 setclientomnvar("ui_hud_shake", 1);
    var_20 playrumbleonpositionforclient("artillery_rumble_light", self.origin);
  }

  self.owner earthquakeforplayer(0.2, 1, self.owner.origin, 2000);
  self.owner setclientomnvar("ui_hud_shake", 1);
  self.owner playrumbleonpositionforclient("artillery_rumble_light", self.origin);
}

function empdrone_applyemp(var_0) {
  scripts\cp_mp\emp_debuff::apply_emp_struct(var_0);
  var_1 = 8;

  if(isPlayer(var_0.victim)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
      if(var_0.victim != self.owner && var_0.victim[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_emp_resist")) {
        var_1 = 2;

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "updateDamageFeedback")) {
          self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "updateDamageFeedback")]]("hittacresist");
        }
      }
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("gamescore", "trackDebuffAssist")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("gamescore", "trackDebuffAssist")]](var_0.attacker, var_0.victim, var_0.objweapon.basename);
    }

    if(isDefined(var_0.attacker)) {
      var_0.attacker scripts\cp\vehicles\vehicle_compass_cp::ref_12021(var_0.victim);
    }
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("pers", "incPersStat")) {
    self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("pers", "incPersStat")]]("empDroneHits", 1);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "combatRecordSuperMisc")) {
    self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "combatRecordSuperMisc")]]("super_emp_drone");
  }

  self.usedcount++;
  empdrone_empendearly(var_0, var_1);

  if(isDefined(var_0.victim)) {
    var_0.victim scripts\cp_mp\emp_debuff::remove_emp();

    if(isDefined(var_0.attacker) && isPlayer(var_0.victim)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("gamescore", "untrackDebuffAssist")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("gamescore", "untrackDebuffAssist")]](var_0.attacker, var_0.victim, var_0.objweapon.basename);
        return;
      }

      return;
    }

    return;
  }
}

function empdrone_empendearly(var_0, var_1) {
  var_0.victim endon("death_or_disconnect");
  level endon("game_ended");
  var_2 = scripts\engine\utility::waittill_notify_or_timeout_return("emp_cleared", var_1);

  if(var_2 != "emp_cleared") {
    var_0.empremoved = 1;
    return;
  }
}