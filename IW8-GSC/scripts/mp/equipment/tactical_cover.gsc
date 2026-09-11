/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\tactical_cover.gsc
***************************************************/

function tac_cover_init() {
  if(!isDefined(level.taccovercollision)) {
    var_0 = getEntArray("tactical_cover_col", "targetname");

    if(isDefined(var_0)) {
      level.taccovercollision = var_0[0];
    }
  }

  level.ref_139ff = getEntArray("dcover_blocker", "targetname");
  level.ref_139fd = getdvarfloat("scr_tacCover_timeoutOverride", 150);
}

function tac_cover_on_give(var_0, var_1) {
  self notify("tac_cover_given");
}

function tac_cover_on_take(var_0, var_1, var_2) {
  self notify("tac_cover_taken");
  self.taccoverrefund = undefined;
}

function tac_cover_used(var_0) {
  waitframe();

  if(isDefined(var_0)) {
    var_0 delete();
    return;
  }
}

function tac_cover_on_fired(var_0, var_1, var_2, var_3) {
  self.taccoverrefund = 1;
  var_4 = physics_createcontents(["physicscontents_player", "physicscontents_solid", "physicscontents_playerclip", "physicscontents_water", "physicscontents_sky", "physicscontents_vehicle"]);
  var_5 = tac_cover_ignore_list(self);
  var_6 = anglesToForward(self.angles);
  var_7 = self.origin + var_6 * 32;
  var_8 = _calloutmarkerping_handleluinotify_brinventoryslotrequest::ref_12f67(var_7, 140, 20);
  var_9 = undefined;
  var_10 = 0;

  if(ref_139ee(var_7)) {
    tac_cover_fire_failed(0);
    return false;
  }

  if(scripts\cp_mp\auto_ascender::updatesixthsensevo(var_7)) {
    return false;
  }

  if(scripts\cp\utility\script::updatespecificfobindanger(var_7)) {
    return false;
  }

  var_4 = scripts\engine\trace::init_gas_trap_cloud();
  var_11 = getdvarfloat("scr_tactical_cover_ladder_buffer_radius", 32);
  var_12 = scripts\engine\trace::sphere_trace_get_all_results(var_7, var_7 + (0, 0, 10), var_11, var_5, var_4, 1);

  foreach(var_14 in var_12) {
    if(isDefined(var_14["surfaceflags"])) {
      var_15 = 19;
      var_16 = 0;
      var_16 |= var_14["surfaceflags"] == 8;
      var_16 |= var_14["surfaceflags"] == 2048;
      var_16 |= var_14["surfaceflags"] == 9 << var_15;
      var_16 |= var_14["surfaceflags"] == 38 << var_15;
      var_16 |= var_14["surfaceflags"] == 39 << var_15;

      if(var_16) {
        tac_cover_fire_failed(0);
        return false;
      }
    }
  }

  foreach(var_19 in var_8) {
    var_20 = distancesquared(var_19.origin, var_7);

    if(isDefined(var_9) && var_10 <= var_20) {
      continue;
    }

    var_9 = var_19;
    var_10 = var_20;
  }

  if(isDefined(var_9)) {
    var_22 = var_9 scriptabledoorangle();
    var_23 = abs(var_22) > 65;
    var_24 = undefined;

    foreach(var_26 in var_8) {
      if(var_9 _calloutmarkerping_handleluinotify_brinventoryslotrequest::ref_12f68(var_26)) {
        var_24 = var_26;
        break;
      }
    }

    var_28 = 1;

    if(isDefined(var_24)) {
      var_29 = var_24 scriptabledoorangle();
      var_28 = abs(var_29) > 65;
    }

    if(var_10 < 1600 && var_23 && var_28) {
      var_30 = ref_139f4(var_9);

      if(isDefined(var_24)) {
        var_30 |= ref_139f4(var_24);
      }

      if(!istrue(var_30)) {
        tac_cover_fire_failed(1);
        return false;
      }

      var_31 = self gettagorigin("j_spinelower");
      var_32 = var_9.heli_intro_vo_done + (0, 0, 24);
      var_33 = physics_raycast(var_31, var_32, var_4, var_5, 0, "physicsquery_any", 1);

      if(isDefined(var_33) && var_33 > 0) {
        tac_cover_fire_failed(1);
        return false;
      }

      var_9.tutonplayerkilled = 1;
      self.taccoverrefund = undefined;
      thread ref_139f6(var_9, var_24, var_3, var_4);
      scripts\mp\utility\stats::incpersstat("deployableCoverUsed", 1);
      return true;
    } else if(var_14 < 6400) {
      tac_cover_fire_failed(1);
      return false;
    }
  }

  var_34 = self getplayerangles() * (0, 1, 0);
  var_35 = self.origin + (0, 0, 24);
  var_36 = anglesToForward(var_34);
  var_37 = 29.5;
  var_38 = var_35 + var_36 * var_37;
  var_33 = physics_raycast(var_35, var_38, var_8, var_9, 0, "physicsquery_closest", 1);

  if(isDefined(var_33) && var_33.size > 0) {
    tac_cover_fire_failed();
    return false;
  }

  var_39 = undefined;
  var_40 = undefined;
  var_35 = var_38;
  var_36 = anglestoright(var_34);
  var_37 = 55.5;
  var_41 = var_35 + var_36 * var_37;
  var_33 = physics_spherecast(var_35, var_41, 2.5, var_8, var_9, "physicsquery_closest");

  if(isDefined(var_33) && var_33.size > 0) {
    var_42 = var_33[0]["shape_position"];
    var_39 = var_33[0]["fraction"];
  } else {
    var_39 = 1;
  }

  var_35 = var_38;
  var_36 = -1 * anglestoright(var_34);
  var_37 = 55.5;
  var_41 = var_35 + var_36 * var_37;
  var_33 = physics_spherecast(var_35, var_41, 2.5, var_8, var_9, "physicsquery_closest");

  if(isDefined(var_33) && var_33.size > 0) {
    var_42 = var_33[0]["shape_position"];
    var_40 = var_33[0]["fraction"];
  } else {
    var_40 = 1;
  }

  if(var_40 + var_39 < 1) {
    tac_cover_fire_failed();
    return false;
  } else if(var_39 < 0.5) {
    var_38 += var_36 * var_37 * (0.5 - var_39);
  } else if(var_40 < 0.5) {
    var_38 += var_36 * var_37 * (0.5 - var_40) * -1;
  }

  var_43 = var_34;
  var_35 = var_38;
  var_36 = (0, 0, -1);
  var_37 = 60;
  var_41 = var_35 + var_36 * var_37;
  var_44 = combineangles(var_43, (0, 0, 90));
  var_33 = physics_capsulecast(var_35, var_41, 2.5, 16.8, var_44, var_8, var_9, "physicsquery_closest");

  if(!isDefined(var_33) || var_33.size <= 0) {
    tac_cover_fire_failed();
    return false;
  }

  var_45 = var_33[0]["entity"];

  if(isDefined(var_45) && !ref_139f0(var_45)) {
    tac_cover_fire_failed();
    return false;
  }

  var_46 = var_33[0]["shape_position"];
  var_42 = var_33[0]["position"];
  var_47 = var_46 - (0, 0, 2.5);
  var_48 = ref_139f2(var_45);
  var_49 = 25.025;
  var_50 = pow(var_49 * 0.14, 2);
  var_51 = var_46;
  var_52 = distance2dsquared(var_51, var_42);
  var_53 = var_46 + anglestoright(var_34) * 14.3 * 1.75;
  var_54 = distance2dsquared(var_53, var_42);
  var_55 = var_46 + anglestoright(var_34) * 14.3 * 1.75 * -1;
  var_56 = distance2dsquared(var_55, var_42);
  var_57 = [];
  var_58 = 0;

  if(var_54 <= var_50 && var_54 < var_52 && var_54 < var_56) {
    var_58++;
    var_57 = [var_51, var_55];
  } else if(var_56 <= var_50 && var_56 < var_52 && var_56 < var_54) {
    var_58++;
    var_57 = [var_51, var_53];
  } else if(var_52 <= var_50) {
    var_58++;
    var_57 = [var_55, var_53];
  } else {
    var_57 = [var_51, var_55, var_53];
  }

  var_36 = (0, 0, -1);
  var_37 = 8.5;

  foreach(var_35 in var_57) {
    var_41 = var_35 + var_36 * var_37;
    var_33 = physics_raycast(var_35, var_41, var_8, var_9, 0, "physicsquery_closest", 1);

    if(!isDefined(var_33) || var_33.size <= 0) {
      continue;
    }

    var_45 = var_33[0]["entity"];

    if(isDefined(var_45) && !ref_139f0(var_45)) {
      tac_cover_fire_failed();
      return false;
    }

    var_58++;

    if(var_58 >= 2) {
      break;
    }
  }

  if(var_58 < 2) {
    tac_cover_fire_failed();
    return false;
  }

  self.taccoverrefund = undefined;
  thread tac_cover_spawn(var_47, var_43, var_48, var_7, var_8);
  scripts\mp\utility\stats::incpersstat("deployableCoverUsed", 1);
  return true;
}

function ref_139f2(var_0) {
  if(isDefined(var_0)) {
    if(_calloutmarkerping_handleluinotify_enemyrepinged::tugofwar_tank(var_0) || _calloutmarkerping_handleluinotify_enemyrepinged::tryspawnweapons(var_0) || scripts\mp\gametypes\br_gondola::triggereliminatedoverlay(var_0) || scripts\mp\gametypes\br_soa_tower::triggeraddobjectivetext(var_0)) {
      return var_0;
    }
  }

  return undefined;
}

function tac_cover_adjust_for_player_space(var_0, var_1, var_2) {
  var_3 = tac_cover_get_free_space(1, var_0, var_1, var_2, 32);

  if(!isDefined(var_3)) {
    return var_0;
  }

  var_4 = tac_cover_get_free_space(0, var_0, var_1, var_2, 32);

  if(!isDefined(var_4)) {
    return var_0;
  }

  var_5 = min(var_3, 15);
  var_6 = anglesToForward(var_1);
  var_7 = var_0 + var_6 * var_5;

  foreach(var_9 in level.ref_139ff) {
    if(ispointinvolume(var_7 + (0, 0, 20), var_9)) {
      var_7 += (0, 0, -6);
      break;
    }
  }

  return var_7;
}

function tac_cover_get_free_space(var_0, var_1, var_2, var_3, var_4) {
  var_5 = anglestoleft(var_2);
  var_6 = anglesToForward(var_2);
  var_7 = -1 * var_6;
  var_8 = undefined;

  if(var_0) {
    var_8 = var_6 * var_4;
  } else {
    var_8 = var_7 * var_4;
  }

  var_9 = var_1 + (0, 0, 48);
  var_10 = var_9;
  var_11 = var_9 + var_8;
  var_12 = 2.5;
  var_13 = 29 + var_4;
  var_14 = combineangles(var_2, (0, 0, 90));
  var_3 = var_3;
  var_15 = [self];
  var_16 = "physicsquery_closest";
  var_17 = physics_capsulecast(var_10, var_11, var_12, var_13, var_14, var_3, var_15, var_16);
  var_18 = var_17.size == 0;

  if(var_18) {
    return undefined;
  }

  var_25 = var_17[0]["shape_position"];
  var_26 = distance(var_25, var_9);
  return var_26;
}

function ref_139ee(var_0) {
  if(isDefined(level.turrets)) {
    foreach(var_2 in level.turrets) {
      if(!isDefined(var_2)) {
        continue;
      }

      var_3 = distancesquared(var_2.origin, var_0);

      if(6400 >= var_3) {
        return true;
      }
    }
  }

  if(isDefined(level.arenaflag_showflagoutlineplayer)) {
    foreach(var_2 in level.arenaflag_showflagoutlineplayer) {
      if(!isDefined(var_2)) {
        continue;
      }

      if(6400 >= distancesquared(var_2.origin, var_0)) {
        return true;
      }
    }
  }

  return false;
}

function tac_cover_fire_failed(var_0) {
  var_1 = scripts\engine\utility::ter_op(istrue(var_0), "MP/TAC_COVER_PLACE_IN_DOORWAY", "MP/TAC_COVER_CANNOT_PLACE");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]](var_1);
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

function ref_139f6(var_0, var_1, var_2, var_3) {
  self endon("death_or_disconnect");
  self endon("tac_cover_taken");
  level endon("game_ended");
  var_4 = anglesToForward(self.angles);
  var_5 = var_0.heli_intro + (0, 90, 0);
  var_6 = anglesToForward(var_5);
  var_7 = vectordot(var_4, var_6);
  var_8 = var_7 > 0;
  var_9 = var_0 scriptabledoorangle();
  var_0 _calloutmarkerping_handleluinotify_brinventoryslotrequest::matchslopekey(1, "tac_cover_door");

  if(isDefined(var_1)) {
    var_1 _calloutmarkerping_handleluinotify_brinventoryslotrequest::matchslopekey(1, "tac_cover_door");
  }

  var_10 = scripts\engine\utility::ter_op(var_8, (0, 90, 0), (0, -90, 0));
  var_11 = (0, 0, -1);
  var_12 = var_0.heli_intro_vo_done + var_11;
  var_13 = combineangles(var_0.heli_intro, var_10);
  var_14 = undefined;
  tac_cover_spawn(var_12, var_13, var_14, var_2, var_3, var_0, var_1);
}

function ref_139f4(var_0) {
  self endon("death_or_disconnect");
  self endon("tac_cover_taken");
  level endon("game_ended");
  var_1 = var_0.angles;
  wait 0.05;
  return var_1 == var_0.angles;
}

function tac_cover_spawn(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("death_or_disconnect");
  self endon("tac_cover_taken");
  level endon("game_ended");
  wait 0.05;
  var_0 = tac_cover_adjust_for_player_space(var_0, var_1, var_4);
  self notify("tac_cover_spawned");
  var_3 = istrue(var_3);
  var_7 = spawn("script_model", var_0);
  var_7.angles = var_1;
  var_7.owner = self;
  var_7.team = self.team;
  var_7.slot = scripts\mp\equipment::findequipmentslot("equip_tac_cover");
  var_7.exploding = 1;
  var_7.issuper = scripts\engine\utility::ter_op(var_3, 1, undefined);
  var_7.superid = level.superglobals.staticsuperdata["super_tac_cover"].id;
  var_7 scripts\cp_mp\ent_manager::registerspawn(2, &tac_cover_entmanagerdelete);
  var_7 scripts\mp\sentientpoolmanager::registersentient("Tactical_Static", self);
  var_7 setentityowner(self);
  var_7 setotherent(self);
  var_7 setModel("offhand_wm_deployable_cover");

  if(isDefined(var_2)) {
    var_7.moving_platform = var_2;
    var_8 = spawnStruct();
    var_8.linkparent = var_7.moving_platform;
    var_8.deathoverridecallback = &ref_139f5;
    var_8.validateaccuratetouching = 1;
    var_7 thread scripts\mp\movers::handle_moving_platforms(var_8);
    thread tac_cover_destroy_on_unstuck();
  }

  var_9 = tac_cover_spawn_collision(var_7);
  var_7 getclosestenemy(var_9, level.taccovercollision);
  var_7.collision = var_9;
  var_9.cover = var_7;

  if(level.gametype == "br") {
    var_7.threatbias = -2000;
  }

  var_9.moverdoesnotkill = 1;

  if(isDefined(var_5)) {
    if(isDefined(var_5.connected_vandalize_node)) {
      tac_cover_destroy(var_5.connected_vandalize_node);
    }

    var_7.concussionused = var_5;
    var_5.connected_vandalize_node = var_7;
  }

  if(isDefined(var_6)) {
    var_7.concusspushstart = var_6;
    var_6.connected_vandalize_node = var_7;
  }

  scripts\mp\weapons::onequipmentplanted(var_7, "equip_tac_cover", &tac_cover_destroy);
  thread scripts\mp\weapons::monitordisownedequipment(self, var_7);

  if(var_3) {
    thread tac_cover_destroy_on_disowned(var_7);
    thread tac_cover_destroy_on_timeout();
  }

  thread tac_cover_destroy_on_game_end();
  thread tac_cover_spawn_internal(var_7);
  thread scripts\mp\weapons::outlineequipmentforowner(var_7);
  var_7 thread scripts\mp\perks\perk_equipmentping::runequipmentping();
}

function tac_cover_spawn_internal(var_0) {
  var_0 endon("death");

  if(1 && false) {
    tac_cover_set_can_damage(var_0, 1);
  }

  if(isDefined(var_0.concussionused)) {
    var_0 setscriptablepartstate("effects", "plantStartDoor", 0);
  } else {
    var_0 setscriptablepartstate("effects", "plantStart", 0);
  }

  wait tac_cover_get_deploy_anim_dur();

  if(1 && !false) {
    tac_cover_set_can_damage(var_0, 1);
  }

  if(isDefined(var_0.concussionused)) {
    var_0 setscriptablepartstate("effects", "plantEndDoor", 0);
    return;
  }

  var_0 setscriptablepartstate("effects", "plantEnd", 0);
}

function tac_cover_spawn_collision(var_0) {
  if(!isDefined(level.taccovercollision)) {
    return;
  }

  var_1 = var_0.origin + (0, 0, -2);
  var_2 = spawn("script_model", var_1);
  var_2 dontinterpolate();
  var_2.angles = var_0.angles;
  var_2 clonebrushmodeltoscriptmodel(level.taccovercollision);
  var_2 linkTo(var_0);
  var_2 setentityowner(self);

  if(!isDefined(level.ref_139fe)) {
    var_2 disconnectPaths();
  }

  return var_2;
}

function ref_139f1(var_0, var_1) {
  var_2 = 100;

  if(!isDefined(var_1)) {
    var_1 = var_2;
  }

  var_3 = (var_1, var_1, var_1);
  var_4 = var_0 - var_3;
  var_5 = var_0 + var_3;
  var_6 = [];
  var_7 = physics_createcontents(["physicscontents_item"]);
  var_8 = physics_aabbbroadphasequery(var_4, var_5, var_7, var_6);

  for(var_9 = 0; var_9 < var_8.size; var_9++) {
    var_10 = var_8[var_9];

    if(isDefined(var_10.equipmentref)) {
      if(var_10.equipmentref == "equip_tac_cover") {
        tac_cover_destroy(var_10, undefined, 1);
        var_10.ref_11b0d = 1;
      }
    }
  }
}

function tac_cover_destroy(var_0, var_1, var_2) {
  var_3 = 0;

  if(!istrue(var_1)) {
    var_3 = 0.2 + tac_cover_get_destroy_anim_dur();
  }

  var_4 = self.maxhealth;

  if(isDefined(self.damagetaken) && self.damagetaken < self.maxhealth) {
    var_4 = self.damagetaken;
  }

  if(!isDefined(var_4)) {
    var_4 = 1250;
  }

  self.owner scripts\cp\vehicles\vehicle_compass_cp::ref_12032("super_tac_cover", int(var_4), var_0, var_2);
  scripts\mp\analyticslog::logevent_fieldupgradeexpired(self.owner, self.superid, int(var_4), istrue(var_2));
  thread tac_cover_destroy_internal(var_3);
  thread tac_cover_delete(var_3);
}

function tac_cover_destroy_internal(var_0) {
  if(isDefined(self.concussionused)) {
    self.concussionused _calloutmarkerping_handleluinotify_brinventoryslotrequest::matchslopekey(0, "tac_cover_door");
    self.concussionused.connected_vandalize_node = undefined;
  }

  if(isDefined(self.concusspushstart)) {
    self.concusspushstart _calloutmarkerping_handleluinotify_brinventoryslotrequest::matchslopekey(0, "tac_cover_door");
    self.concusspushstart.connected_vandalize_node = undefined;
  }

  if(var_0 > 0) {
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

function tac_cover_delete(var_0) {
  self notify("death");
  level.mines[self getentitynumber()] = undefined;
  var_1 = self.owner;

  if(isDefined(var_1)) {
    var_1 scripts\mp\weapons::removeequip(self);
  }

  if(true) {
    scripts\mp\damage::monitordamageend();
    self thermaldrawdisable();
  }

  if(isDefined(self.collision)) {
    self.collision connectpaths();
    self.collision delete();
  }

  wait var_0;
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

function tac_cover_set_can_damage(var_0) {
  if(true) {
    if(var_0) {
      var_1 = scripts\mp\utility\perk::_hasperk("specialty_rugged_eqp");
      var_2 = scripts\engine\utility::ter_op(var_1, 1250, 1000);
      var_3 = "hitequip";
      thread scripts\mp\damage::monitordamage(var_2, var_3, &tac_cover_handle_fatal_damage, &tac_cover_handle_damage, 0);
      self thermaldrawenable();
      return;
    }

    scripts\mp\damage::monitordamageend();
    self thermaldrawdisable();
    return;
  }
}

function tac_cover_handle_damage(var_0) {
  var_1 = ref_139ed(var_0);

  if(isDefined(self.owner)) {
    var_2 = max(self.maxhealth - self.damagetaken, 0);
    var_3 = int(min(var_2, var_1));
    self.owner scripts\mp\supers::hide_plunderboxes("super_tac_cover", var_3);
  }

  return var_1;
}

function ref_139ed(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.point;

  if(var_2.basename == "thermite_av_mp") {
    return 200;
  }

  if(scripts\mp\damage::usefaillaststandmsg(var_0.objweapon)) {
    return 0;
  }

  if(var_2.basename == "thermite_bolt_mp") {
    return 83.3333;
  }

  if(var_2.basename == "thermite_xmike109_mp") {
    return 62.5;
  }

  if(var_3 == "MOD_MELEE" || var_3 == "MOD_IMPACT") {
    if(var_3 == "MOD_IMPACT" && var_2.classname == "grenade") {
      return var_4;
    }

    return 333.333;
  }

  if(scripts\mp\utility\weapon::isthrowingknife(var_2.basename)) {
    return 0;
  }

  if(var_2.basename == "iw8_sn_crossbow_mp" && var_3 != "MOD_MELEE") {
    return 0;
  }

  if(var_3 == "MOD_CRUSH" && isDefined(var_0.inflictor) && var_0.inflictor.classname == "script_vehicle") {
    if(isDefined(var_1) && !scripts\mp\weapons::friendlyfirecheck(self.owner, var_1)) {
      return var_4;
    }
  }

  if(isexplosivedamagemod(var_0.meansofdeath)) {
    if(var_2.basename == "semtex_xmike109_mp") {
      return 333.333;
    }

    return 700;
  }

  var_4 = scripts\mp\damage::handleapdamage(var_2, var_3, var_4);
  var_4 = scripts\mp\damage::handleshotgundamage(var_2, var_3, var_4);
  return var_4;
}

function tac_cover_handle_fatal_damage(var_0) {
  var_1 = var_0.attacker;

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_1))) {
    var_1 notify("destroyed_equipment");
    var_1 thread scripts\mp\utility\points::giveunifiedpoints("destroyed_equipment");
    var_1 thread scripts\mp\battlechatter_mp::equipmentdestroyed(self);
  }

  thread tac_cover_destroy(var_1, undefined, 1);
}

function tac_cover_deploy_freeze_controls() {
  if(!isDefined(self.taccoverfrozecontrols)) {
    var_0 = scripts\mp\equipment::findequipmentslot("equip_tac_cover");
    scripts\mp\equipment::allow_equipment_slot(var_0, 0, "equip_tac_cover");
    scripts\common\utility::allow_usability(0);
    scripts\mp\utility\player::allow_gesture(0);
    self.taccoverfrozecontrols = var_0;
    return;
  }
}

function tac_cover_deploy_unfreeze_controls() {
  if(isDefined(self.taccoverfrozecontrols)) {
    var_0 = self.taccoverfrozecontrols;
    scripts\mp\equipment::allow_equipment_slot(var_0, 1, "equip_tac_cover");
    scripts\common\utility::allow_usability(1);
    scripts\mp\utility\player::allow_gesture(1);
    self.taccoverfrozecontrols = undefined;
    return;
  }
}

function tac_cover_ignore_list(var_0) {
  var_1 = [var_0];

  if(isDefined(level.grenades)) {
    foreach(var_3 in level.grenades) {
      if(isDefined(var_3)) {
        var_1 = var_3;
      }
    }
  }

  if(isDefined(level.missiles)) {
    foreach(var_6 in level.missiles) {
      if(isDefined(var_6)) {
        var_1 = var_6;
      }
    }
  }

  if(isDefined(level.mines)) {
    foreach(var_9 in level.mines) {
      if(!isDefined(var_9)) {
        continue;
      }

      var_10 = isDefined(var_9.owner) && var_9.owner == var_0;
      var_11 = isDefined(var_9.equipmentref) && var_9.equipmentref == "equip_tac_cover";
      var_12 = isDefined(var_9.equipmentref) && var_9.equipmentref == "equip_ammo_box";

      if(!var_10 && (var_11 || var_12)) {
        continue;
      }

      var_1 = var_9;

      if(isDefined(var_9.collision)) {
        var_1 = var_9.collision;
      }
    }
  }

  return var_1;
}

function ref_139f0(var_0) {
  if(isPlayer(var_0)) {
    return false;
  }

  if(var_0 getnonstick()) {
    return false;
  }

  if(istrue(var_0.mountmantlemodel)) {
    return false;
  }

  if(isDefined(var_0.cover) && isDefined(var_0.cover.equipmentref) && var_0.cover.equipmentref == "equip_tac_cover") {
    return false;
  }

  if(var_0.classname == "misc_turret") {
    return false;
  }

  if(var_0.classname == "script_vehicle") {
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

function tac_cover_destroy_on_disowned(var_0) {
  self endon("death");
  var_0 endon("tac_cover_taken");
  var_0 scripts\engine\utility::ref_143a5("joined_team", "disconnect");
  thread tac_cover_destroy(undefined, undefined, 0);
}

function ref_139f5(var_0) {
  tac_cover_destroy(var_0.attacker, undefined, 0);
}