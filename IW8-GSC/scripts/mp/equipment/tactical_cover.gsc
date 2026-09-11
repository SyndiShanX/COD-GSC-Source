/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\tactical_cover.gsc
***************************************************/

function tac_cover_init() {
  if(!isDefined(level.taccovercollision)) {
    var0 = getEntArray("tactical_cover_col", "targetname");

    if(isDefined(var0)) {
      level.taccovercollision = var0[0];
    }
  }

  level.ref_139ff = getEntArray("dcover_blocker", "targetname");
  level.ref_139fd = getdvarfloat("scr_tacCover_timeoutOverride", 150);
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

  if(isDefined(var0)) {
    var0 delete();
    return;
  }
}

function tac_cover_on_fired(var0, var1, var2, var3) {
  self.taccoverrefund = 1;
  var4 = physics_createcontents(["physicscontents_player", "physicscontents_solid", "physicscontents_playerclip", "physicscontents_water", "physicscontents_sky", "physicscontents_vehicle"]);
  var5 = tac_cover_ignore_list(self);
  var6 = anglesToForward(self.angles);
  var7 = self.origin + var6 * 32;
  var8 = _calloutmarkerping_handleluinotify_brinventoryslotrequest::ref_12f67(var7, 140, 20);
  var9 = undefined;
  var10 = 0;

  if(ref_139ee(var7)) {
    tac_cover_fire_failed(0);
    return false;
  }

  if(scripts\cp_mp\auto_ascender::updatesixthsensevo(var7)) {
    return false;
  }

  if(scripts\cp\utility\script::updatespecificfobindanger(var7)) {
    return false;
  }

  var4 = scripts\engine\trace::init_gas_trap_cloud();
  var11 = getdvarfloat("scr_tactical_cover_ladder_buffer_radius", 32);
  var12 = scripts\engine\trace::sphere_trace_get_all_results(var7, var7 + (0, 0, 10), var11, var5, var4, 1);

  foreach(var14 in var12) {
    if(isDefined(var14["surfaceflags"])) {
      var15 = 19;
      var16 = 0;
      var16 |= var14["surfaceflags"] == 8;
      var16 |= var14["surfaceflags"] == 2048;
      var16 |= var14["surfaceflags"] == 9 << var15;
      var16 |= var14["surfaceflags"] == 38 << var15;
      var16 |= var14["surfaceflags"] == 39 << var15;

      if(var16) {
        tac_cover_fire_failed(0);
        return false;
      }
    }
  }

  foreach(var19 in var8) {
    var20 = distancesquared(var19.origin, var7);

    if(isDefined(var9) && var10 <= var20) {
      continue;
    }

    var9 = var19;
    var10 = var20;
  }

  if(isDefined(var9)) {
    var22 = var9 scriptabledoorangle();
    var23 = abs(var22) > 65;
    var24 = undefined;

    foreach(var26 in var8) {
      if(var9 _calloutmarkerping_handleluinotify_brinventoryslotrequest::ref_12f68(var26)) {
        var24 = var26;
        break;
      }
    }

    var28 = 1;

    if(isDefined(var24)) {
      var29 = var24 scriptabledoorangle();
      var28 = abs(var29) > 65;
    }

    if(var10 < 1600 && var23 && var28) {
      var30 = ref_139f4(var9);

      if(isDefined(var24)) {
        var30 |= ref_139f4(var24);
      }

      if(!istrue(var30)) {
        tac_cover_fire_failed(1);
        return false;
      }

      var31 = self gettagorigin("j_spinelower");
      var32 = var9.heli_intro_vo_done + (0, 0, 24);
      var33 = physics_raycast(var31, var32, var4, var5, 0, "physicsquery_any", 1);

      if(isDefined(var33) && var33 > 0) {
        tac_cover_fire_failed(1);
        return false;
      }

      var9.tutonplayerkilled = 1;
      self.taccoverrefund = undefined;
      thread ref_139f6(var9, var24, var3, var4);
      scripts\mp\utility\stats::incpersstat("deployableCoverUsed", 1);
      return true;
    } else if(var14 < 6400) {
      tac_cover_fire_failed(1);
      return false;
    }
  }

  var34 = self getplayerangles() * (0, 1, 0);
  var35 = self.origin + (0, 0, 24);
  var36 = anglesToForward(var34);
  var37 = 29.5;
  var38 = var35 + var36 * var37;
  var33 = physics_raycast(var35, var38, var8, var9, 0, "physicsquery_closest", 1);

  if(isDefined(var33) && var33.size > 0) {
    tac_cover_fire_failed();
    return false;
  }

  var39 = undefined;
  var40 = undefined;
  var35 = var38;
  var36 = anglestoright(var34);
  var37 = 55.5;
  var41 = var35 + var36 * var37;
  var33 = physics_spherecast(var35, var41, 2.5, var8, var9, "physicsquery_closest");

  if(isDefined(var33) && var33.size > 0) {
    var42 = var33[0]["shape_position"];
    var39 = var33[0]["fraction"];
  } else {
    var39 = 1;
  }

  var35 = var38;
  var36 = -1 * anglestoright(var34);
  var37 = 55.5;
  var41 = var35 + var36 * var37;
  var33 = physics_spherecast(var35, var41, 2.5, var8, var9, "physicsquery_closest");

  if(isDefined(var33) && var33.size > 0) {
    var42 = var33[0]["shape_position"];
    var40 = var33[0]["fraction"];
  } else {
    var40 = 1;
  }

  if(var40 + var39 < 1) {
    tac_cover_fire_failed();
    return false;
  } else if(var39 < 0.5) {
    var38 += var36 * var37 * (0.5 - var39);
  } else if(var40 < 0.5) {
    var38 += var36 * var37 * (0.5 - var40) * -1;
  }

  var43 = var34;
  var35 = var38;
  var36 = (0, 0, -1);
  var37 = 60;
  var41 = var35 + var36 * var37;
  var44 = combineangles(var43, (0, 0, 90));
  var33 = physics_capsulecast(var35, var41, 2.5, 16.8, var44, var8, var9, "physicsquery_closest");

  if(!isDefined(var33) || var33.size <= 0) {
    tac_cover_fire_failed();
    return false;
  }

  var45 = var33[0]["entity"];

  if(isDefined(var45) && !ref_139f0(var45)) {
    tac_cover_fire_failed();
    return false;
  }

  var46 = var33[0]["shape_position"];
  var42 = var33[0]["position"];
  var47 = var46 - (0, 0, 2.5);
  var48 = ref_139f2(var45);
  var49 = 25.025;
  var50 = pow(var49 * 0.14, 2);
  var51 = var46;
  var52 = distance2dsquared(var51, var42);
  var53 = var46 + anglestoright(var34) * 14.3 * 1.75;
  var54 = distance2dsquared(var53, var42);
  var55 = var46 + anglestoright(var34) * 14.3 * 1.75 * -1;
  var56 = distance2dsquared(var55, var42);
  var57 = [];
  var58 = 0;

  if(var54 <= var50 && var54 < var52 && var54 < var56) {
    var58++;
    var57 = [var51, var55];
  } else if(var56 <= var50 && var56 < var52 && var56 < var54) {
    var58++;
    var57 = [var51, var53];
  } else if(var52 <= var50) {
    var58++;
    var57 = [var55, var53];
  } else {
    var57 = [var51, var55, var53];
  }

  var36 = (0, 0, -1);
  var37 = 8.5;

  foreach(var35 in var57) {
    var41 = var35 + var36 * var37;
    var33 = physics_raycast(var35, var41, var8, var9, 0, "physicsquery_closest", 1);

    if(!isDefined(var33) || var33.size <= 0) {
      continue;
    }

    var45 = var33[0]["entity"];

    if(isDefined(var45) && !ref_139f0(var45)) {
      tac_cover_fire_failed();
      return false;
    }

    var58++;

    if(var58 >= 2) {
      break;
    }
  }

  if(var58 < 2) {
    tac_cover_fire_failed();
    return false;
  }

  self.taccoverrefund = undefined;
  thread tac_cover_spawn(var47, var43, var48, var7, var8);
  scripts\mp\utility\stats::incpersstat("deployableCoverUsed", 1);
  return true;
}

function ref_139f2(var0) {
  if(isDefined(var0)) {
    if(_calloutmarkerping_handleluinotify_enemyrepinged::tugofwar_tank(var0) || _calloutmarkerping_handleluinotify_enemyrepinged::tryspawnweapons(var0) || scripts\mp\gametypes\br_gondola::triggereliminatedoverlay(var0) || scripts\mp\gametypes\br_soa_tower::triggeraddobjectivetext(var0)) {
      return var0;
    }
  }

  return undefined;
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

  foreach(var9 in level.ref_139ff) {
    if(ispointinvolume(var7 + (0, 0, 20), var9)) {
      var7 += (0, 0, -6);
      break;
    }
  }

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

function ref_139ee(var0) {
  if(isDefined(level.turrets)) {
    foreach(var2 in level.turrets) {
      if(!isDefined(var2)) {
        continue;
      }

      var3 = distancesquared(var2.origin, var0);

      if(6400 >= var3) {
        return true;
      }
    }
  }

  if(isDefined(level.arenaflag_showflagoutlineplayer)) {
    foreach(var2 in level.arenaflag_showflagoutlineplayer) {
      if(!isDefined(var2)) {
        continue;
      }

      if(6400 >= distancesquared(var2.origin, var0)) {
        return true;
      }
    }
  }

  return false;
}

function tac_cover_fire_failed(var0) {
  var1 = scripts\engine\utility::ter_op(istrue(var0), "MP/TAC_COVER_PLACE_IN_DOORWAY", "MP/TAC_COVER_CANNOT_PLACE");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]](var1);
  }

  self playsoundtoplayer("iw8_deployable_cover_plant_fail", self);

  if(scripts\mp\equipment::hasequipment("equip_tac_cover")) {
    scripts\mp\equipment::incrementequipmentammo("equip_tac_cover", 1);
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
  var0 _calloutmarkerping_handleluinotify_brinventoryslotrequest::matchslopekey(1, "tac_cover_door");

  if(isDefined(var1)) {
    var1 _calloutmarkerping_handleluinotify_brinventoryslotrequest::matchslopekey(1, "tac_cover_door");
  }

  var10 = scripts\engine\utility::ter_op(var8, (0, 90, 0), (0, -90, 0));
  var11 = (0, 0, -1);
  var12 = var0.heli_intro_vo_done + var11;
  var13 = combineangles(var0.heli_intro, var10);
  var14 = undefined;
  tac_cover_spawn(var12, var13, var14, var2, var3, var0, var1);
}

function ref_139f4(var0) {
  self endon("death_or_disconnect");
  self endon("tac_cover_taken");
  level endon("game_ended");
  var1 = var0.angles;
  wait 0.05;
  return var1 == var0.angles;
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
  var7.slot = scripts\mp\equipment::findequipmentslot("equip_tac_cover");
  var7.exploding = 1;
  var7.issuper = scripts\engine\utility::ter_op(var3, 1, undefined);
  var7.superid = level.superglobals.staticsuperdata["super_tac_cover"].id;
  var7 scripts\cp_mp\ent_manager::registerspawn(2, &tac_cover_entmanagerdelete);
  var7 scripts\mp\sentientpoolmanager::registersentient("Tactical_Static", self);
  var7 setentityowner(self);
  var7 setotherent(self);
  var7 setModel("offhand_wm_deployable_cover");

  if(isDefined(var2)) {
    var7.moving_platform = var2;
    var8 = spawnStruct();
    var8.linkparent = var7.moving_platform;
    var8.deathoverridecallback = &ref_139f5;
    var8.validateaccuratetouching = 1;
    var7 thread scripts\mp\movers::handle_moving_platforms(var8);
    thread tac_cover_destroy_on_unstuck();
  }

  var9 = tac_cover_spawn_collision(var7);
  var7 getclosestenemy(var9, level.taccovercollision);
  var7.collision = var9;
  var9.cover = var7;

  if(level.gametype == "br") {
    var7.threatbias = -2000;
  }

  var9.moverdoesnotkill = 1;

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

  scripts\mp\weapons::onequipmentplanted(var7, "equip_tac_cover", &tac_cover_destroy);
  thread scripts\mp\weapons::monitordisownedequipment(self, var7);

  if(var3) {
    thread tac_cover_destroy_on_disowned(var7);
    thread tac_cover_destroy_on_timeout();
  }

  thread tac_cover_destroy_on_game_end();
  thread tac_cover_spawn_internal(var7);
  thread scripts\mp\weapons::outlineequipmentforowner(var7);
  var7 thread scripts\mp\perks\perk_equipmentping::runequipmentping();
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

  var1 = var0.origin + (0, 0, -2);
  var2 = spawn("script_model", var1);
  var2 dontinterpolate();
  var2.angles = var0.angles;
  var2 clonebrushmodeltoscriptmodel(level.taccovercollision);
  var2 linkTo(var0);
  var2 setentityowner(self);

  if(!isDefined(level.ref_139fe)) {
    var2 disconnectPaths();
  }

  return var2;
}

function ref_139f1(var0, var1) {
  var2 = 100;

  if(!isDefined(var1)) {
    var1 = var2;
  }

  var3 = (var1, var1, var1);
  var4 = var0 - var3;
  var5 = var0 + var3;
  var6 = [];
  var7 = physics_createcontents(["physicscontents_item"]);
  var8 = physics_aabbbroadphasequery(var4, var5, var7, var6);

  for(var9 = 0; var9 < var8.size; var9++) {
    var10 = var8[var9];

    if(isDefined(var10.equipmentref)) {
      if(var10.equipmentref == "equip_tac_cover") {
        tac_cover_destroy(var10, undefined, 1);
        var10.ref_11b0d = 1;
      }
    }
  }
}

function tac_cover_destroy(var0, var1, var2) {
  var3 = 0;

  if(!istrue(var1)) {
    var3 = 0.2 + tac_cover_get_destroy_anim_dur();
  }

  var4 = self.maxhealth;

  if(isDefined(self.damagetaken) && self.damagetaken < self.maxhealth) {
    var4 = self.damagetaken;
  }

  if(!isDefined(var4)) {
    var4 = 1250;
  }

  self.owner scripts\cp\vehicles\vehicle_compass_cp::ref_12032("super_tac_cover", int(var4), var0, var2);
  scripts\mp\analyticslog::logevent_fieldupgradeexpired(self.owner, self.superid, int(var4), istrue(var2));
  thread tac_cover_destroy_internal(var3);
  thread tac_cover_delete(var3);
}

function tac_cover_destroy_internal(var0) {
  if(isDefined(self.concussionused)) {
    self.concussionused _calloutmarkerping_handleluinotify_brinventoryslotrequest::matchslopekey(0, "tac_cover_door");
    self.concussionused.connected_vandalize_node = undefined;
  }

  if(isDefined(self.concusspushstart)) {
    self.concusspushstart _calloutmarkerping_handleluinotify_brinventoryslotrequest::matchslopekey(0, "tac_cover_door");
    self.concusspushstart.connected_vandalize_node = undefined;
  }

  if(var0 > 0) {
    self setscriptablepartstate("effects", "destroyStart");
    wait tac_cover_get_destroy_anim_dur();
    self setscriptablepartstate("effects", "destroyEnd");
  }

  if(isDefined(self.collision)) {
    self.collision connectpaths();
    self.collision delete();
    return;
  }
}

function tac_cover_delete(var0) {
  self notify("death");
  level.mines[self getentitynumber()] = undefined;
  var1 = self.owner;

  if(isDefined(var1)) {
    var1 scripts\mp\weapons::removeequip(self);
  }

  if(true) {
    scripts\mp\damage::monitordamageend();
    self thermaldrawdisable();
  }

  if(isDefined(self.collision)) {
    self.collision connectpaths();
    self.collision delete();
  }

  wait var0;
  self delete();
}

function tac_cover_destroy_on_timeout() {
  self endon("death");
  wait level.ref_139fd;
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
      var1 = scripts\mp\utility\perk::_hasperk("specialty_rugged_eqp");
      var2 = scripts\engine\utility::ter_op(var1, 1250, 1000);
      var3 = "hitequip";
      thread scripts\mp\damage::monitordamage(var2, var3, &tac_cover_handle_fatal_damage, &tac_cover_handle_damage, 0);
      self thermaldrawenable();
      return;
    }

    scripts\mp\damage::monitordamageend();
    self thermaldrawdisable();
    return;
  }
}

function tac_cover_handle_damage(var0) {
  var1 = ref_139ed(var0);

  if(isDefined(self.owner)) {
    var2 = max(self.maxhealth - self.damagetaken, 0);
    var3 = int(min(var2, var1));
    self.owner scripts\mp\supers::hide_plunderboxes("super_tac_cover", var3);
  }

  return var1;
}

function ref_139ed(var0) {
  var1 = var0.attacker;
  var2 = var0.objweapon;
  var3 = var0.meansofdeath;
  var4 = var0.damage;
  var5 = var0.point;

  if(var2.basename == "thermite_av_mp") {
    return 200;
  }

  if(scripts\mp\damage::usefaillaststandmsg(var0.objweapon)) {
    return 0;
  }

  if(var2.basename == "thermite_bolt_mp") {
    return 83.3333;
  }

  if(var2.basename == "thermite_xmike109_mp") {
    return 62.5;
  }

  if(var3 == "MOD_MELEE" || var3 == "MOD_IMPACT") {
    if(var3 == "MOD_IMPACT" && var2.classname == "grenade") {
      return var4;
    }

    return 333.333;
  }

  if(scripts\mp\utility\weapon::isthrowingknife(var2.basename)) {
    return 0;
  }

  if(var2.basename == "iw8_sn_crossbow_mp" && var3 != "MOD_MELEE") {
    return 0;
  }

  if(var3 == "MOD_CRUSH" && isDefined(var0.inflictor) && var0.inflictor.classname == "script_vehicle") {
    if(isDefined(var1) && !scripts\mp\weapons::friendlyfirecheck(self.owner, var1)) {
      return var4;
    }
  }

  if(isexplosivedamagemod(var0.meansofdeath)) {
    if(var2.basename == "semtex_xmike109_mp") {
      return 333.333;
    }

    return 700;
  }

  var4 = scripts\mp\damage::handleapdamage(var2, var3, var4);
  var4 = scripts\mp\damage::handleshotgundamage(var2, var3, var4);
  return var4;
}

function tac_cover_handle_fatal_damage(var0) {
  var1 = var0.attacker;

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var1))) {
    var1 notify("destroyed_equipment");
    var1 thread scripts\mp\utility\points::giveunifiedpoints("destroyed_equipment");
    var1 thread scripts\mp\battlechatter_mp::equipmentdestroyed(self);
  }

  thread tac_cover_destroy(var1, undefined, 1);
}

function tac_cover_deploy_freeze_controls() {
  if(!isDefined(self.taccoverfrozecontrols)) {
    var0 = scripts\mp\equipment::findequipmentslot("equip_tac_cover");
    scripts\mp\equipment::allow_equipment_slot(var0, 0, "equip_tac_cover");
    scripts\common\utility::allow_usability(0);
    scripts\mp\utility\player::allow_gesture(0);
    self.taccoverfrozecontrols = var0;
    return;
  }
}

function tac_cover_deploy_unfreeze_controls() {
  if(isDefined(self.taccoverfrozecontrols)) {
    var0 = self.taccoverfrozecontrols;
    scripts\mp\equipment::allow_equipment_slot(var0, 1, "equip_tac_cover");
    scripts\common\utility::allow_usability(1);
    scripts\mp\utility\player::allow_gesture(1);
    self.taccoverfrozecontrols = undefined;
    return;
  }
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

  if(isDefined(var0.cover) && isDefined(var0.cover.equipmentref) && var0.cover.equipmentref == "equip_tac_cover") {
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
  thread tac_cover_destroy(undefined, undefined, 0);
}

function ref_139f5(var0) {
  tac_cover_destroy(var0.attacker, undefined, 0);
}