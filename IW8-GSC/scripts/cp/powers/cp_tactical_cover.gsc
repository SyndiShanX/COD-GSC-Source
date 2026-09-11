/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\powers\cp_tactical_cover.gsc
***************************************************/

function tac_cover_init() {
  if(!isDefined(level.taccovercollision)) {
    var0 = getEntArray("tactical_cover_col", "targetname");

    if(isDefined(var0)) {
      level.taccovercollision = var0[0];
      return;
    }

    return;
  }
}

function tac_cover_on_give(var0, var1) {
  self notify("tac_cover_given");
}

function tac_cover_on_take(var0, var1, var2) {
  self notify("tac_cover_taken");
  self.taccoverrefund = undefined;
}

function tac_cover_used(var0) {
  waitframe();

  foreach(var2 in self.offhandinventory) {
    if(isDefined(var2.basename) && var2.basename == "tac_cover_mp") {
      self takeweapon("tac_cover_mp");
    }
  }

  if(isDefined(self.ref_12879)) {
    self switchtoweapon(self.ref_12879);
    self.ref_12879 = undefined;
  }

  if(isDefined(var0)) {
    var0 delete();
    return;
  }
}

function tac_cover_on_fired(var0, var1, var2, var3) {
  self.taccoverrefund = 1;
  var4 = physics_createcontents(["physicscontents_player", "physicscontents_solid", "physicscontents_playerclip", "physicscontents_water", "physicscontents_sky", "physicscontents_vehicle"]);
  var5 = anglesToForward(self.angles);
  var6 = self.origin + var5 * 32;
  var7 = _calloutmarkerping_handleluinotify_brinventoryslotrequest::ref_12f67(var6, 140, 20);
  var8 = undefined;
  var9 = 0;

  foreach(var11 in var7) {
    var12 = distancesquared(var11.origin, var6);

    if(isDefined(var8) && var9 <= var12) {
      continue;
    }

    var8 = var11;
    var9 = var12;
  }

  if(isDefined(var8)) {
    var14 = var8 scriptabledoorangle();
    var15 = abs(var14) > 65;
    var16 = undefined;

    foreach(var18 in var7) {
      if(var8 _calloutmarkerping_handleluinotify_brinventoryslotrequest::ref_12f68(var18)) {
        var16 = var18;
        break;
      }
    }

    var20 = 1;

    if(isDefined(var16)) {
      var21 = var16 scriptabledoorangle();
      var20 = abs(var21) > 65;
    }

    if(var9 < 1600 && var15 && var20) {
      var8.tutonplayerkilled = 1;
      self.taccoverrefund = undefined;
      thread ref_139f6(var8, var16, var3, var4);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("challenges", "onFieldUpgradeEnd")) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("challenges", "onFieldUpgradeEnd")]]("super_tac_cover", 1);
      }

      scripts\cp\agents\agents::incpersstat("deployableCoverUsed", 1);
      return true;
    } else if(var9 < 6400) {
      tac_cover_fire_failed(1);
      return false;
    }
  }

  var22 = tac_cover_ignore_list(self);
  var23 = self getplayerangles() * (0, 1, 0);
  var24 = self.origin + (0, 0, 24);
  var25 = anglesToForward(var23);
  var26 = 29.5;
  var27 = var24 + var25 * var26;
  var28 = physics_raycast(var24, var27, var4, var22, 0, "physicsquery_closest", 1);

  if(isDefined(var28) && var28.size > 0) {
    tac_cover_fire_failed();
    return false;
  }

  var29 = undefined;
  var30 = undefined;
  var24 = var27;
  var25 = anglestoright(var23);
  var26 = 55.5;
  var31 = var24 + var25 * var26;
  var28 = physics_spherecast(var24, var31, 2.5, var4, var22, "physicsquery_closest");

  if(isDefined(var28) && var28.size > 0) {
    var32 = var28[0]["shape_position"];
    var29 = var28[0]["fraction"];
  } else {
    var29 = 1;
  }

  var24 = var27;
  var25 = -1 * anglestoright(var23);
  var26 = 55.5;
  var31 = var24 + var25 * var26;
  var28 = physics_spherecast(var24, var31, 2.5, var4, var22, "physicsquery_closest");

  if(isDefined(var28) && var28.size > 0) {
    var32 = var28[0]["shape_position"];
    var30 = var28[0]["fraction"];
  } else {
    var30 = 1;
  }

  if(var30 + var29 < 1) {
    tac_cover_fire_failed();
    return false;
  } else if(var29 < 0.5) {
    var27 += var25 * var26 * (0.5 - var29);
  } else if(var30 < 0.5) {
    var27 += var25 * var26 * (0.5 - var30) * -1;
  }

  var33 = var23;
  var24 = var27;
  var25 = (0, 0, -1);
  var26 = 60;
  var31 = var24 + var25 * var26;
  var34 = combineangles(var33, (0, 0, 90));
  var28 = physics_capsulecast(var24, var31, 2.5, 16.8, var34, var4, var22, "physicsquery_closest");

  if(!isDefined(var28) || var28.size <= 0) {
    tac_cover_fire_failed();
    return false;
  }

  var35 = var28[0]["entity"];

  if(isDefined(var35) && !ref_139f0(var35)) {
    tac_cover_fire_failed();
    return false;
  }

  var36 = var28[0]["shape_position"];
  var32 = var28[0]["position"];
  var37 = var36 - (0, 0, 2.5);
  var38 = 25.025;
  var39 = pow(var38 * 0.14, 2);
  var40 = var36;
  var41 = distance2dsquared(var40, var32);
  var42 = var36 + anglestoright(var23) * 14.3 * 1.75;
  var43 = distance2dsquared(var42, var32);
  var44 = var36 + anglestoright(var23) * 14.3 * 1.75 * -1;
  var45 = distance2dsquared(var44, var32);
  var46 = [];
  var47 = 0;

  if(var43 <= var39 && var43 < var41 && var43 < var45) {
    var47++;
    var46 = [var40, var44];
  } else if(var45 <= var39 && var45 < var41 && var45 < var43) {
    var47++;
    var46 = [var40, var42];
  } else if(var41 <= var39) {
    var47++;
    var46 = [var44, var42];
  } else {
    var46 = [var40, var44, var42];
  }

  var25 = (0, 0, -1);
  var26 = 8.5;

  foreach(var24 in var46) {
    var31 = var24 + var25 * var26;
    var28 = physics_raycast(var24, var31, var4, var22, 0, "physicsquery_closest", 1);

    if(!isDefined(var28) || var28.size <= 0) {
      continue;
    }

    var35 = var28[0]["entity"];

    if(isDefined(var35) && !ref_139f0(var35)) {
      tac_cover_fire_failed();
      return false;
    }

    var47++;

    if(var47 >= 2) {
      break;
    }
  }

  if(var47 < 2) {
    tac_cover_fire_failed();
    return false;
  }

  self.taccoverrefund = undefined;
  thread tac_cover_spawn(var37, var33, undefined, var3, var4);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("challenges", "onFieldUpgradeEnd")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("challenges", "onFieldUpgradeEnd")]]("super_tac_cover", 1);
  }

  scripts\cp\agents\agents::incpersstat("deployableCoverUsed", 1);
  return true;
}

function tac_cover_adjust_for_player_space(var0, var1, var2) {
  var3 = tac_cover_get_free_space(1, var0, var1, var2, 32);

  if(!isDefined(var3)) {
    return var0;
  }

  var4 = tac_cover_get_free_space(0, var0, var1, var2, 32);

  if(!isDefined(var4)) {
    return var0;
  }

  var5 = min(var3, 15);
  var6 = anglesToForward(var1);
  var7 = var0 + var6 * var5;
  return var7;
}

function tac_cover_get_free_space(var0, var1, var2, var3, var4) {
  var5 = anglestoleft(var2);
  var6 = anglesToForward(var2);
  var7 = -1 * var6;
  var8 = undefined;

  if(var0) {
    var8 = var6 * var4;
  } else {
    var8 = var7 * var4;
  }

  var9 = var1 + (0, 0, 48);
  var10 = var9;
  var11 = var9 + var8;
  var12 = 2.5;
  var13 = 29 + var4;
  var14 = combineangles(var2, (0, 0, 90));
  var3 = var3;
  var15 = [self];
  var16 = "physicsquery_closest";
  var17 = physics_capsulecast(var10, var11, var12, var13, var14, var3, var15, var16);
  var18 = var17.size == 0;

  if(var18) {
    return undefined;
  }

  var25 = var17[0]["shape_position"];
  var26 = distance(var25, var9);
  return var26;
}

function tac_cover_fire_failed(var0) {
  var1 = scripts\engine\utility::ter_op(istrue(var0), "MP/TAC_COVER_PLACE_IN_DOORWAY", "MP/TAC_COVER_CANNOT_PLACE");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]](var1);
  }

  if(soundexists("iw8_deployable_cover_plant_fail")) {
    self playsoundtoplayer("iw8_deployable_cover_plant_fail", self);
    return;
  }
}

function ref_139f3() {
  if(self hasweapon("tac_cover_mp")) {
    self takeweapon("tac_cover_mp");
  }

  var0 = scripts\cp\loot_system::get_empty_munition_slot(self);

  if(isDefined(var0)) {
    scripts\cp\cp_munitions::give_munition_to_slot("deployable_cover", var0);
    return;
  }
}

function tac_cover_entmanagerdelete() {
  thread tac_cover_delete(0);
}

function ref_139f6(var0, var1, var2, var3) {
  self endon("death_or_disconnect");
  self endon("tac_cover_taken");
  level endon("game_ended");
  var4 = anglesToForward(self.angles);
  var5 = var0.heli_intro + (0, 90, 0);
  var6 = anglesToForward(var5);
  var7 = vectordot(var4, var6);
  var8 = var7 > 0;
  var9 = var0 scriptabledoorangle();
  var0 scriptabledoorfreeze(1);

  if(isDefined(var1)) {
    var1 scriptabledoorfreeze(1);
  }

  var10 = scripts\engine\utility::ter_op(var8, (0, 90, 0), (0, -90, 0));
  var11 = (0, 0, -1);
  var12 = var0.heli_intro_vo_done + var11;
  var13 = combineangles(var0.heli_intro, var10);
  var14 = undefined;
  tac_cover_spawn(var12, var13, var14, var2, var3, var0, var1);
}

function tac_cover_spawn(var0, var1, var2, var3, var4, var5, var6) {
  self endon("death_or_disconnect");
  self endon("tac_cover_taken");
  level endon("game_ended");
  wait 0.05;
  var0 = tac_cover_adjust_for_player_space(var0, var1, var4);
  self notify("tac_cover_spawned");
  var3 = istrue(var3);
  var7 = spawn("script_model", var0);
  var7.angles = var1;
  var7.owner = self;
  var7.team = self.team;
  var7.slot = "primary";
  var7.exploding = 1;
  var7.issuper = scripts\engine\utility::ter_op(var3, 1, undefined);
  var7 scripts\cp\utility::make_entity_sentient_cp(var7.owner.team);
  var7 setentityowner(self);
  var7 setotherent(self);
  var7 setModel("offhand_wm_deployable_cover");
  var7.equipmentref = "equip_tac_cover";

  if(isDefined(var2)) {
    var7 linkTo(var2);
    thread tac_cover_destroy_on_unstuck();
  }

  var8 = tac_cover_spawn_collision(var7);
  var7 getclosestenemy(var8, level.taccovercollision);
  var7.collision = var8;
  var8.cover = var7;
  var8.moverdoesnotkill = 1;

  if(isDefined(var5)) {
    if(isDefined(var5.connected_vandalize_node)) {
      tac_cover_destroy(var5.connected_vandalize_node);
    }

    var7.concussionused = var5;
    var5.connected_vandalize_node = var7;
  }

  if(isDefined(var6)) {
    var7.concusspushstart = var6;
    var6.connected_vandalize_node = var7;
  }

  var7.streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("tac_cover", var7.owner);

  if(isDefined(self.taccovers) && self.taccovers.size + 1 > 2) {
    var9 = self.taccovers.size + 1 - 2;
    var10 = self.taccovers;

    for(var11 = 0; var11 < var9; var11++) {
      var12 = var10[var11];
    }
  }

  thread scripts\cp\cp_weapon::monitordisownedequipment(self, var7);
  tac_cover_add_to_list(var7, self);

  if(var3) {
    thread tac_cover_destroy_on_disowned(var7);
    thread tac_cover_destroy_on_timeout();
  }

  thread tac_cover_destroy_on_game_end();
  thread tac_cover_spawn_internal(var7);
}

function tac_cover_spawn_internal(var0) {
  var0 endon("death");

  if(1 && false) {
    tac_cover_set_can_damage(var0, 1);
  }

  if(isDefined(var0.concussionused)) {
    var0 setscriptablepartstate("effects", "plantStartDoor", 0);
  } else {
    var0 setscriptablepartstate("effects", "plantStart", 0);
  }

  wait tac_cover_get_deploy_anim_dur();

  if(1 && !false) {
    tac_cover_set_can_damage(var0, 1);
  }

  if(isDefined(var0.concussionused)) {
    var0 setscriptablepartstate("effects", "plantEndDoor", 0);
    return;
  }

  var0 setscriptablepartstate("effects", "plantEnd", 0);
}

function tac_cover_spawn_collision(var0) {
  if(!isDefined(level.taccovercollision)) {
    return;
  }

  var1 = spawn("script_model", var0.origin);
  var1 dontinterpolate();
  var1.angles = var0.angles;
  var1 clonebrushmodeltoscriptmodel(level.taccovercollision);
  var1 linkTo(var0);
  var1 setentityowner(self);
  var1 disconnectPaths();
  return var1;
}

function tac_cover_destroy(var0, var1) {
  var2 = 0;

  if(!istrue(var0)) {
    var2 = 0.2 + tac_cover_get_destroy_anim_dur();
  }

  var3 = self.maxhealth;

  if(isDefined(self.damagetaken) && self.damagetaken < self.maxhealth) {
    var3 = self.damagetaken;
  }

  self.owner scripts\cp_mp\utility\killstreak_utility::ref_12aa7(self.streakinfo);
  thread tac_cover_destroy_internal(var2);
  thread tac_cover_delete(var2);
}

function tac_cover_destroy_internal(var0) {
  if(isDefined(self.concussionused)) {
    self.concussionused scriptabledoorfreeze(0);
    self.concussionused.connected_vandalize_node = undefined;
  }

  if(isDefined(self.concusspushstart)) {
    self.concusspushstart scriptabledoorfreeze(0);
    self.concusspushstart.connected_vandalize_node = undefined;
  }

  if(var0 > 0) {
    self setscriptablepartstate("effects", "destroyStart");
    wait tac_cover_get_destroy_anim_dur();
    self setscriptablepartstate("effects", "destroyEnd");
  }

  if(isDefined(self.collision)) {
    self.collision delete();
    return;
  }
}

function tac_cover_delete(var0) {
  self notify("death");
  level.mines[self getentitynumber()] = undefined;
  var1 = self.owner;

  if(true) {
    self thermaldrawdisable();
  }

  if(isDefined(self.collision)) {
    self.collision delete();
  }

  wait var0;
  self delete();
}

function tac_cover_destroy_on_timeout() {
  self endon("death");
  wait 150;
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

function tac_cover_set_can_damage(var0) {
  if(true) {
    if(var0) {
      var1 = scripts\cp\utility::_hasperk("specialty_rugged_eqp");
      var2 = scripts\engine\utility::ter_op(var1, 1250, 1000);
      var3 = "hitequip";
      thread scripts\cp\cp_weapon::monitordamage(var2, var3, &tac_cover_handle_fatal_damage, &tac_cover_handle_damage, 0);
      self thermaldrawenable();
      return;
    }

    self thermaldrawdisable();
    return;
  }
}

function tac_cover_handle_damage(var0) {
  var1 = var0.attacker;
  var2 = var0.objweapon;
  var3 = var0.meansofdeath;
  var4 = var0.damage;
  var5 = var0.point;

  if(!isDefined(var2)) {
    return var4;
  }

  if(var2.basename == "thermite_av_mp") {
    return 200;
  }

  if(var2.basename == "throwingknife_mp") {
    return 0;
  }

  if(var2.basename == "iw8_sn_crossbow_mp") {
    return 0;
  }

  if(var3 == "MOD_IMPACT" && var2.classname == "grenade") {
    return var4;
  }

  if(var3 == "MOD_CRUSH" && isDefined(var0.inflictor) && var0.inflictor.classname == "script_vehicle") {
    if(isDefined(var1) && !scripts\cp\cp_damage::friendlyfirecheck(self.owner, var1)) {
      if(isDefined(var0.inflictor.vehiclename) && ref_139ef(var0.inflictor.vehiclename)) {
        return var4;
      } else {
        return 0;
      }
    }
  }

  if(isexplosivedamagemod(var0.meansofdeath)) {
    return 700;
  }

  if(var3 == "MOD_MELEE" || var3 == "MOD_IMPACT") {
    var4 = 333.333;
  }

  if(isDefined(var1) && isDefined(self.owner) && var1 == self.owner) {
    var4 *= 1;
  }

  return var4;
}

function tac_cover_handle_fatal_damage(var0) {
  var1 = var0.attacker;

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var1))) {
    if(isPlayer(var1)) {
      var1 thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("destroyed_equipment");
      var1 thread scripts\cp\cp_player_battlechatter::equipmentdestroyed(self);
    }

    var1 notify("destroyed_equipment");
  }

  thread tac_cover_destroy(undefined, 1);
}

function ref_139ef(var0) {
  switch (var0) {
    case "light_tank":
    case "apc_russian":
      return true;
    default:
      break;
  }

  return false;
}

function tac_cover_ignore_list(var0) {
  var1 = [var0];

  if(isDefined(level.grenades)) {
    foreach(var3 in level.grenades) {
      if(isDefined(var3)) {
        var1 = var3;
      }
    }
  }

  if(isDefined(level.missiles)) {
    foreach(var6 in level.missiles) {
      if(isDefined(var6)) {
        var1 = var6;
      }
    }
  }

  if(isDefined(level.mines)) {
    foreach(var9 in level.mines) {
      if(!isDefined(var9)) {
        continue;
      }

      var10 = isDefined(var9.owner) && var9.owner == var0;
      var11 = isDefined(var9.equipmentref) && var9.equipmentref == "equip_tac_cover";
      var12 = isDefined(var9.equipmentref) && var9.equipmentref == "equip_ammo_box";

      if(!var10 && (var11 || var12)) {
        continue;
      }

      var1 = var9;

      if(isDefined(var9.collision)) {
        var1 = var9.collision;
      }
    }
  }

  return var1;
}

function ref_139f0(var0) {
  if(isPlayer(var0)) {
    return false;
  }

  if(var0 getnonstick()) {
    return false;
  }

  if(istrue(var0.mountmantlemodel)) {
    return false;
  }

  if(var0.classname == "misc_turret") {
    return false;
  }

  if(var0.classname == "script_vehicle") {
    return false;
  }

  return true;
}

#using_animtree("scriptables");

function tac_cover_get_deploy_anim_dur() {
  return getanimlength(%wm_deployable_cover_deploy);
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

function tac_cover_destroy_on_disowned(var0) {
  self endon("death");
  var0 endon("tac_cover_taken");
  var0 scripts\engine\utility::ref_143a5("joined_team", "disconnect");
  thread tac_cover_destroy(undefined, 0);
}

function tac_cover_add_to_list(var0) {
  if(!isDefined(var0.taccovers)) {
    var0.taccovers = [];
  }

  var0.taccovers[var0.taccovers.size] = self;

  if(!isDefined(level.taccovers)) {
    level.taccovers = [];
  }

  var1 = self getentitynumber();
  level.taccovers[var1] = self;
}

function tac_cover_remove_from_list(var0, var1) {
  if(isDefined(var0.taccovers)) {
    var2 = [];

    foreach(var4 in var0.taccovers) {
      if(isDefined(var4) && var4 != self) {
        var2 = var4;
      }
    }

    var0.taccovers = var2;
  }

  if(isDefined(level.taccovers)) {
    level.taccovers[var1] = undefined;
    return;
  }
}

function ricochet_bullet(var0, var1, var2, var3) {
  var4 = scripts\engine\math::vector_reflect(var0, var1);
  magicbullet(var3, var2 + var0 * 10, var2 + var0 * 10 + var4);
}