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
  var0 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("emp_drone", self);
  var1 = empdrone_tryuse(var0);
  wait 0.05;

  if(var1) {
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

function empdrone_tryuse(var0) {
  scripts\cp_mp\killstreaks\killstreakdeploy::ondeploystart(var0);
  var1 = getcompleteweaponname("ks_remote_map_mp");
  var2 = &scripts\cp_mp\killstreaks\killstreakdeploy::waituntilfinishedwithdeployweapon;
  var3 = &empdrone_weapongiven;
  var4 = scripts\cp_mp\killstreaks\killstreakdeploy::switchtodeployweapon(var1, var0, var2, var3);
  scripts\cp_mp\killstreaks\killstreakdeploy::ondeployfinished(var0, istrue(var4));

  if(!istrue(var4)) {
    return false;
  }

  var5 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("empDroneTargeted", "getSelectMapPoint")) {
    var5 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("empDroneTargeted", "getSelectMapPoint")]](var0, 1);
  } else {
    return false;
  }

  if(!isDefined(var5)) {
    return false;
  }

  thread empdrone_createdrone(var0, var5[0].location);
  return true;
}

function empdrone_equipment_wrapper(var0, var1, var2) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("equipment", "takeEquipment")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("equipment", "takeEquipment")]](var1);
  }

  var3 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("emp_drone", self);
  var4 = empdrone_tryuse(var3);

  if(!var4) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("equipment", "giveEquipment")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("equipment", "giveEquipment")]]("equip_empdrone", var1);
      return;
    }

    return;
  }
}

function empdrone_weapongiven(var0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("empDroneTargeted", "startMapSelectSequence")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("empDroneTargeted", "startMapSelectSequence")]](0, 0, undefined, 3);
  } else {
    return false;
  }

  return true;
}

function empdrone_createdrone(var0, var1) {
  self endon("disconnect");
  level endon("game_ended");
  var2 = empdrone_calculatepositions(var1);
  var3 = scripts\cp_mp\utility\weapon_utility::_magicbullet(getcompleteweaponname("emp_drone_proj_mp"), var2.startpos, var2.targetpos, self);
  var3 setentityowner(self);
  var3.owner = self;
  var3.ownerid = self getentitynumber();
  var3.team = self.team;
  var3.streakinfo = var0;
  var3.usedcount = 0;
  var3.superid = level.superglobals.staticsuperdata["super_emp_drone"].id;
  var3 hidepart("j_propeller");
  playFXOnTag(scripts\engine\utility::getfx("vfx/iw8/level/safehouse/vfx_safehouse_finale_drone_wingtip_red_lit.vfx"), var3, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("vfx/iw8/level/safehouse/vfx_safehouse_finale_drone_contrails.vfx"), var3, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("vfx/iw8/level/safehouse/vfx_safehouse_finale_drone_heat_dist.vfx"), var3, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("vfx/iw8_mp/killstreak/vfx_rc_plane_rotor.vfx"), var3, "j_propeller");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("empDroneTargeted", "monitorDamage")) {
    var3 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("empDroneTargeted", "monitorDamage")]](25, "hitequip", &empdrone_handledeathdamage, undefined, 0);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    var3[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](var0.streakname, "Killstreak_Air", self, 0, 1, 25);
  }

  var3 playLoopSound("iw8_rc_plane_engine");
  thread empdrone_timeoutthink();
  thread monitorweaponswitchbr();
  thread empdrone_collidethink();

  if(getdvarint("scr_empDrone_target_test", 0) == 0) {
    thread empdrone_divebombthink(var3);
  } else {
    thread morales_laptop_initted(var3);
  }

  var3 scripts\cp_mp\emp_debuff::set_apply_emp_callback(&empdrone_empapplied);
  return var3;
}

function empdrone_calculatepositions(var0) {
  var1 = scripts\cp_mp\utility\killstreak_utility::removeextracthelipad();
  var2 = (0, 0, 1500);

  if(isDefined(var1)) {
    var3 = var1.origin[2] + -1500;
    var2 = (0, 0, var3);
  }

  var4 = anglesToForward(self.angles);
  var5 = undefined;
  var6 = 0;
  var7 = 0;
  var8 = 0;

  for(;;) {
    var9 = rotatevector(var4, (0, var7, 0));
    var10 = var2 + var0;
    var5 = var10 - var9 * 4500;
    var11 = (0, 0, 1500);
    var5 += var11;
    var12 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot"]);
    var6 = scripts\engine\trace::ray_trace_passed(var5, var10, undefined, var12);
    var8++;

    if(var6) {
      break;
    }

    if(var8 >= 13) {
      break;
    }

    wait 0.05;
    var7 += 55.3;
  }

  var13 = vectorNormalize(var5 - var10) * 1000 + var10;
  var14 = spawnStruct();
  var14.startpos = var5;
  var14.divebombpos = var13;
  var14.targetpos = var0;
  return var14;
}

function empdrone_timeoutthink() {
  level endon("game_ended");
  self.owner endon("disconnect");
  self endon("death");
  var0 = gettime() * 0.001;
  var1 = var0 + 20;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var1);
  thread empdrone_destroy();
}

function monitorweaponswitchbr() {
  self.owner endon("disconnect");
  self endon("death");
  level scripts\engine\utility::ref_143a5("game_ended", "prematch_cleanup");
  thread empdrone_destroy();
}

function empdrone_collidethink() {
  level endon("game_ended");
  self.owner endon("disconnect");
  self endon("death");
  self waittill("missile_stuck");
  thread empdrone_explode();
}

function empdrone_divebombthink(var0) {
  level endon("game_ended");
  self.owner endon("disconnect");
  self endon("death");
  self missile_settargetpos(var0.divebombpos);
  var1 = 50;

  while(distancesquared(var0.divebombpos, self.origin) > var1 * var1) {
    wait 0.05;
  }

  var2 = anglesToForward(self.angles);
  var3 = distance(var0.targetpos, self.origin);
  var4 = self.origin + var2 * var3;
  var5 = gettime();
  var6 = 0;
  var7 = 0;

  for(;;) {
    wait 0.05;
    var6 = (gettime() - var5) / 1300;
    var6 = clamp(var6, 0, 1);
    var8 = var4 * (1 - var6) + var0.targetpos * var6;
    self missile_settargetpos(var8);
  }
}

function morales_laptop_initted(var0) {}

function empdrone_handledeathdamage(var0, var1, var2) {
  empdrone_givepointsfordeath(var0);
  empdrone_destroy();
}

function empdrone_explode() {
  self playSound("iw8_rc_plane_engine_exp");
  var0 = anglesToForward(self.angles);
  playFX(scripts\engine\utility::getfx("vfx/iw8_mp/perk/vfx_emp_drone_exp_fieldupgrades.vfx"), self.origin, var0);
  empdrone_explodeemp();
  empdrone_delete();
}

function empdrone_destroy() {
  self playSound("recondrone_damaged");
  var0 = anglesToForward(self.angles);
  playFX(scripts\engine\utility::getfx("vfx/iw8_mp/perk/vfx_emp_drone_airexp.vfx"), self.origin, var0);
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

function empdrone_empapplied(var0) {
  var1 = var0.attacker;
  empdrone_givepointsfordeath(var1);
  empdrone_destroy();
}

function empdrone_givepointsfordeath(var0) {
  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var0))) {
    var0 notify("destroyed_equipment");

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "giveUnifiedPoints")) {
      var0 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "giveUnifiedPoints")]]("destroyed_equipment");
      return;
    }

    return;
  }
}

function empdrone_explodeemp() {
  var0 = getcompleteweaponname("emp_drone_non_player_mp");
  var1 = getcompleteweaponname("emp_drone_non_player_direct_mp");
  var2 = [];
  var3 = scripts\cp_mp\emp_debuff::get_emp_ents();

  foreach(var5 in var3) {
    if(var5 == self) {
      continue;
    }

    var6 = var5.owner;

    if(isDefined(var6)) {
      if(var6 != self.owner && !scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var6)) {
        continue;
      }
    }

    var7 = distancesquared(self.origin, var5.origin);

    if(var7 > 640000) {
      continue;
    }

    var8 = var5 scripts\cp_mp\vehicles\vehicle::isvehicle();
    var9 = scripts\cp_mp\vehicles\vehicle_occupancy::ref_141de(var5);

    if(var8 && var9) {
      var10 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var5);

      foreach(var12 in var10) {
        var2 = var12;
      }
    }

    var14 = scripts\engine\utility::ter_op(var7 > 6400, var0, var1);
    var5 dodamage(1, self.origin, self.owner, self, "MOD_EXPLOSIVE", var14);
    var15 = scripts\cp_mp\utility\damage_utility::packdamagedata(self.owner, var5, 1, var14, "MOD_EXPLOSIVE", self, self.origin);
    thread empdrone_applyemp(var15);
  }

  var17 = getcompleteweaponname("emp_drone_player_mp");
  self radiusdamage(self.origin, 80, 120, 80, self.owner, "MOD_EXPLOSIVE", var17);
  var18 = scripts\common\utility::playersinsphere(self.origin, 800);
  var18 = scripts\engine\utility::array_combine_unique(var18, var2);

  foreach(var20 in var18) {
    if(!isDefined(var20)) {
      continue;
    }

    if(!var20 scripts\cp_mp\emp_debuff::can_emp_player()) {
      continue;
    }

    if(var20 != self.owner && !scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var20)) {
      continue;
    }

    var20 dodamage(1, self.origin, self.owner, self, "MOD_EXPLOSIVE", var17);
    var15 = scripts\cp_mp\utility\damage_utility::packdamagedata(self.owner, var20, 1, var17, "MOD_EXPLOSIVE", self, self.origin);
    thread empdrone_applyemp(var15);
  }

  var22 = scripts\common\utility::playersinsphere(self.origin, 2000);
  var22 = scripts\engine\utility::array_combine_unique(var22, var2);

  foreach(var20 in var22) {
    if(!isDefined(var20)) {
      continue;
    }

    if(var20 == self.owner) {
      continue;
    }

    var20 earthquakeforplayer(0.3, 1, self.origin, 2000);
    var20 setclientomnvar("ui_hud_shake", 1);
    var20 playrumbleonpositionforclient("artillery_rumble_light", self.origin);
  }

  self.owner earthquakeforplayer(0.2, 1, self.owner.origin, 2000);
  self.owner setclientomnvar("ui_hud_shake", 1);
  self.owner playrumbleonpositionforclient("artillery_rumble_light", self.origin);
}

function empdrone_applyemp(var0) {
  scripts\cp_mp\emp_debuff::apply_emp_struct(var0);
  var1 = 8;

  if(isPlayer(var0.victim)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
      if(var0.victim != self.owner && var0.victim[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_emp_resist")) {
        var1 = 2;

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "updateDamageFeedback")) {
          self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "updateDamageFeedback")]]("hittacresist");
        }
      }
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("gamescore", "trackDebuffAssist")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("gamescore", "trackDebuffAssist")]](var0.attacker, var0.victim, var0.objweapon.basename);
    }

    if(isDefined(var0.attacker)) {
      var0.attacker scripts\cp\vehicles\vehicle_compass_cp::ref_12021(var0.victim);
    }
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("pers", "incPersStat")) {
    self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("pers", "incPersStat")]]("empDroneHits", 1);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "combatRecordSuperMisc")) {
    self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "combatRecordSuperMisc")]]("super_emp_drone");
  }

  self.usedcount++;
  empdrone_empendearly(var0, var1);

  if(isDefined(var0.victim)) {
    var0.victim scripts\cp_mp\emp_debuff::remove_emp();

    if(isDefined(var0.attacker) && isPlayer(var0.victim)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("gamescore", "untrackDebuffAssist")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("gamescore", "untrackDebuffAssist")]](var0.attacker, var0.victim, var0.objweapon.basename);
        return;
      }

      return;
    }

    return;
  }
}

function empdrone_empendearly(var0, var1) {
  var0.victim endon("death_or_disconnect");
  level endon("game_ended");
  var2 = scripts\engine\utility::waittill_notify_or_timeout_return("emp_cleared", var1);

  if(var2 != "emp_cleared") {
    var0.empremoved = 1;
    return;
  }
}