/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_deployablebox.gsc
***********************************************/

function init() {
  level.deployable_box_interaction = &init_box_interaction;

  if(!isDefined(level.boxsettings)) {
    level.boxsettings = [];
  }

  level thread scripts\cp\cp_ammo_crate::ammo_crate_init();
  level thread scripts\cp\cp_grenade_crate::grenade_crate_init();
  level thread scripts\cp\cp_armor_crate::armor_crate_init();
  level thread scripts\cp\cp_adrenaline_crate::adrenaline_crate_init();
}

function init_box_interaction() {
  scripts\cp\cp_interaction::register_interaction("deployable_box", "null", undefined, &box_hint_func, &box_activate_func, 0, 0, undefined);
}

function box_hint_func(var_0, var_1) {
  var_2 = level.boxsettings[var_0.box.boxtype];
  return var_2.hintstring;
}

function box_activate_func(var_0, var_1) {
  var_0.box notify("captured", var_1);
}

function box_createinteraction(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0.origin;
  var_1.targetname = "interaction";
  var_1.script_noteworthy = "deployable_box";
  var_1.requires_power = 0;
  var_1.box = var_0;
  var_1.spend_type = "null";
  var_1.cost = 0;
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_1);
  var_0.interaction = var_1;
  return var_0;
}

function begindeployableviamarker(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  thread watchdeployablemarkerplacement(var_1, var_0, var_2, var_3, var_4, var_5, var_6);
  return true;
}

function watchdeployablemarkerplacement(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("spawned_player");
  self endon("disconnect");

  if(!isDefined(var_2)) {
    return;
  }

  if(!isDefined(var_3)) {
    return;
  }

  var_2 makecollidewithitemclip(1);
  self notify("deployable_deployed");
  var_7 = "cp_used_" + var_0;
  var_8 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo(var_7, self);
  scripts\cp_mp\utility\killstreak_utility::ref_12AA7(var_8);

  foreach(var_10 in level.players) {
    var_10 thread scripts\cp\cp_hud_message::showsplash(var_7, undefined, self);
  }

  var_2.owner = self;
  var_2.weaponname = var_3;
  self.marker = var_2;
  var_12 = scripts\cp\utility::getweapontoswitchbackto();
  var_13 = thread scripts\cp\cp_weapons::switchtoweaponreliable(var_12, 0);
  self.last_weapon = undefined;

  if(isgrenadedeployable(var_0)) {
    self thread[[level.boxsettings[var_0].grenadeusefunc]](var_2);
    return;
  }

  thread markeractivate(var_2, var_1, var_0, &box_setactive, var_4, var_5);
}

function override_box_moving_platform_death(var_0) {
  self notify("death");
}

function marker_watchdisownedtimeout() {
  self endon("death");
  marker_watchdisownedtimeoutinternal();

  if(isDefined(self) && !istrue(self.isdestroyed)) {
    thread supportbox_destroy();
    return;
  }
}

function marker_watchdisownedtimeoutinternal() {
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  level endon("game_ended");
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(5);
}

function markeractivate(var_0, var_1, var_2, var_3, var_4, var_5) {
  self notify("markerActivate");
  self endon("markerActivate");
  var_6 = scripts\engine\utility::ref_143AE("missile_stuck", "explode", "death");
  var_7 = self.owner;
  var_8 = self.origin;
  var_9 = level.boxsettings[var_1];
  var_10 = undefined;

  if(var_6 == "explode") {
    var_10 = createboxforplayer(var_1, scripts\engine\utility::drop_to_ground(var_8, 1000), var_7);
  } else if(var_6 == "death") {
    var_10 = createboxforplayer(var_1, scripts\engine\utility::drop_to_ground(var_8, 1000), var_7);
  } else {
    var_10 = self;
  }

  var_10 setscriptablepartstate("effects", "plant", 0);
  var_10 setscriptablepartstate("anims", "closedIdle", 0);
  var_10 setscriptablepartstate("beacon", "active", 0);
  var_10.health = 999999;
  var_10.maxhealth = var_9.maxhealth;
  var_10.angles = self.angles;
  var_10.boxtype = var_1;
  var_10.owner = var_7;
  var_10.team = var_7.team;
  var_10.id = var_9.id;

  if(isDefined(var_9.dpadname)) {
    var_10.dpadname = var_9.dpadname;
  }

  if(isDefined(var_9.maxuses)) {
    var_10.usesremaining = var_9.maxuses;
  }

  var_10.owner.supportbox = var_10;
  thread box_handleownerdisconnect();
  addboxtoownerarray(var_10, var_10.owner);
  supportbox_addowneroutline(var_10);
  var_10[[var_2]](var_10, var_3, var_4, var_5);
  var_11 = level.crafting_table_data[var_1].metal;
  var_12 = 0;

  if(var_7 scripts\cp\cp_persistence::try_take_player_currency(var_11)) {
    return;
  }
}

function supportbox_destroy() {
  self setscriptablepartstate("effects", "destroy", 0);
  self setscriptablepartstate("beacon", "neutral", 0);
  thread supportbox_delete(3);
}

function supportbox_delete(var_0) {
  self notify("death");
  self.isdestroyed = 1;
  self setCanDamage(0);
  supportbox_removeobjectiveicon();
  supportbox_removeowneroutline();
}

function supportbox_addowneroutline() {
  if(true) {
    if(isDefined(self.owner)) {
      self.outlineid = scripts\cp\cp_outline_utility::outlineenableforplayer(self, self.owner, "outline_depth_white", "killstreak_personal");
      return;
    }

    return;
  }
}

function supportbox_removeowneroutline() {
  if(isDefined(self.outlineid)) {
    scripts\cp\cp_outline_utility::outlinedisable(self.outlineid, self);
    return;
  }
}

function supportbox_addobjectiveicon() {
  var_0 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(var_0 == -1) {
    return;
  }

  scripts\mp\objidpoolmanager::objective_add_objective(var_0, "invisible", (0, 0, 0));
  scripts\mp\objidpoolmanager::update_objective_onentity(var_0, self);
  scripts\mp\objidpoolmanager::update_objective_state(var_0, "active");
  scripts\mp\objidpoolmanager::update_objective_icon(var_0, level.boxsettings[self.boxtype].shadername);
  scripts\mp\objidpoolmanager::update_objective_setbackground(var_0, 1);
}

function supportbox_removeobjectiveicon() {
  if(isDefined(self.objectiveiconid)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(self.objectiveiconid);
    return;
  }
}

function createboxforplayer(var_0, var_1, var_2) {
  var_3 = level.boxsettings[var_0];
  var_4 = spawn("script_model", var_1 - (0, 0, 1));
  var_4 setModel(var_3.modelbase);
  var_4.health = 999999;
  var_4.maxhealth = var_3.maxhealth;
  var_4.angles = self.angles;
  var_4.boxtype = var_0;
  var_4.owner = var_2;
  var_4.team = var_2.team;
  var_4.id = var_3.id;
  return var_4;
}

function box_setactive(var_0, var_1, var_2, var_3) {
  var_4 = level.boxsettings[self.boxtype];
  self.inuse = 0;

  if(isDefined(self.owner)) {
    self.owner thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("munitions_box_teammate_used");
    self.owner notify("munitions_used", var_0.boxtype);
    self.owner thread scripts\cp\cp_player_battlechatter::onmunitionboxused(self.boxtype);
  }

  if(isDefined(var_4.deployfunc)) {
    self.owner thread[[var_4.deployfunc]]();
  }

  if(!isDefined(var_4.canusecallback) || self.owner[[var_4.canusecallback]](self)) {
    box_seticon(self.owner, var_4.streakname, var_4.headiconoffset);
  }

  var_0 = box_createinteraction(var_0);

  if(isDefined(var_1)) {
    self thread[[var_1]]();
  } else {
    thread box_handledamage();
  }

  thread box_handledeath();

  if(isDefined(var_3)) {
    self thread[[var_3]]();
  } else {
    thread box_timeout();
  }

  thread box_playerconnected();
  thread box_agentconnected();
  thread boxthink();
}

function _box_setactivehelper(var_0, var_1, var_2) {
  if(var_1) {
    if(!isDefined(var_2) || var_0[[var_2]](self)) {
      box_enableplayeruse(var_0);
    }

    thread boxthink();
    return;
  }

  box_disableplayeruse(var_0);
}

function box_playerconnected() {
  self endon("death");
  level waittill("connected", var_0);
  GscBinSkip4(0x35, var_0);
}

function box_agentconnected() {
  self endon("death");

  for(;;) {
    level waittill("spawned_agent_player", var_0);
    box_addboxforplayer(var_0);
  }
}

function box_waittill_player_spawn_and_add_box(var_0) {
  var_0 waittill("spawned_player");

  if(level.teambased) {
    box_addboxforplayer(var_0);
    thread box_playerjoinedteam(var_0);
    return;
  }
}

function box_playerjoinedteam(var_0) {
  self endon("death");
  var_0 endon("disconnect");

  for(;;) {
    var_0 waittill("joined_team");

    if(level.teambased) {
      box_addboxforplayer(var_0);
    }
  }
}

function box_addboxforplayer(var_0) {
  if(self.team == var_0.team) {
    box_enableplayeruse(var_0);
    thread boxthink();
    box_seticon(var_0, level.boxsettings[self.boxtype].streakname, level.boxsettings[self.boxtype].headiconoffset);
    return;
  }

  box_disableplayeruse(var_0);
}

function box_seticon(var_0, var_1, var_2) {
  var_3 = level.boxsettings[self.boxtype];
  var_4 = undefined;

  if(isDefined(var_3.headicon)) {
    var_4 = var_3.headicon;
  }

  self.boxiconid = thread scripts\cp\utility::ent_createheadicon(self, var_2, self.team, var_4, 0);
}

function box_enableplayeruse(var_0) {
  self.disabled_use_for[var_0 getentitynumber()] = 0;
}

function box_disableplayeruse(var_0) {
  self.disabled_use_for[var_0 getentitynumber()] = 1;
}

function box_setinactive() {}

function box_handledamage() {
  var_0 = level.boxsettings[self.boxtype];
}

function box_modifydamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflags;
  var_6 = var_4;
  var_7 = level.boxsettings[self.boxtype];
  return var_6;
}

function box_handledeathdamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = level.boxsettings[self.boxtype];
  var_1 notify("destroyed_equipment");
}

function box_handledeath() {
  self waittill("death");
  scripts\cp\cp_interaction::remove_from_current_interaction_list(self.interaction);

  foreach(var_1 in level.players) {
    var_1 scripts\cp\cp_interaction::refresh_interaction();
  }

  box_setinactive();
  removeboxfromownerarray(self.owner);

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.owner)) {
    self.owner.supportbox = undefined;
  }

  if(isDefined(self.boxiconid) && self.boxiconid != -1) {
    thread scripts\cp\utility::ent_deleteheadicon(self, self.boxiconid);
  }

  var_3 = level.boxsettings[self.boxtype];
  var_4 = anglesToForward(self.angles);
  var_5 = anglestoup(self.angles);
  playFX(var_3.deathvfx, self.origin, var_4, var_5);
  self playSound("mp_equip_destroyed");
  self notify("deleting");
  self delete();
}

function box_handleownerdisconnect() {
  self endon("death");
  level endon("game_ended");
  self notify("box_handleOwner");
  self endon("box_handleOwner");
  self.owner scripts\engine\utility::ref_143A5("killstreak_disowned", "disconnect");
  self notify("death");
}

function boxthink() {
  var_0 = level.boxsettings[self.boxtype];

  for(;;) {
    self waittill("captured", var_1);

    if(isPlayer(var_1) && var_1.team == self.owner.team) {
      var_2 = 1;

      if(isDefined(var_0.onusecallback)) {
        var_2 = var_1[[var_0.onusecallback]](self);
      }

      if(istrue(var_2)) {
        thread ref_12457();
        var_1 scripts\cp\utility::playerplaypickupanim("ges_swipe");

        if(isDefined(self.owner) && var_1 != self.owner) {
          self.owner thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("munitions_box_teammate_used");

          if(isDefined(var_0.ref_120AA)) {
            level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_1, var_0.ref_120AA);
          }
        }

        if(isDefined(self.usesremaining)) {
          self.usesremaining--;

          if(self.usesremaining == 0) {
            box_leave();
            break;
          }
        }

        if(isDefined(var_0.canuseotherboxes) && var_0.canuseotherboxes) {
          foreach(var_4 in level.deployable_box[var_0.streakname]) {
            box_disableplayeruse(var_4, self);
            thread doubledip(var_4);
          }

          continue;
        }

        if(istrue(var_0.canreusebox)) {}
      }
    }
  }
}

function ref_12457() {
  self endon("death");
  self notify("playerboxUseAnimation");
  self endon("playerboxUseAnimation");
  self setscriptablepartstate("anims", "open", 0);
  wait supportbox_getdeployanimduration();
  self setscriptablepartstate("anims", "close", 0);
  wait supportbox_getcloseanimduration();
  self setscriptablepartstate("anims", "closedIdle", 0);
}

function doubledip(var_0) {
  self endon("death");
  var_0 endon("disconnect");
  var_0 waittill("death");

  if(level.teambased) {
    if(self.team == var_0.team) {
      box_seticon(var_0, level.boxsettings[self.boxtype].streakname, level.boxsettings[self.boxtype].headiconoffset);
      box_enableplayeruse(var_0);
      return;
    }

    return;
  }

  if(isDefined(self.owner) && self.owner == var_0) {
    box_seticon(var_0, level.boxsettings[self.boxtype].streakname, level.boxsettings[self.boxtype].headiconoffset);
    box_enableplayeruse(var_0);
    return;
  }
}

function boxcapturethink(var_0) {
  level endon("game_ended");

  while(isDefined(self)) {
    self waittill("trigger", var_1);

    if(var_1 == var_0) {
      self notify("captured", var_1);
    }
  }
}

function isfriendlytobox(var_0) {
  return level.teambased && self.team == var_0.team;
}

function box_timeout() {
  self endon("death");
  level endon("game_ended");
  var_0 = level.boxsettings[self.boxtype];
  var_1 = var_0.lifespan;
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(var_1);
  box_leave();
}

function box_leave() {
  waitframe();
  self notify("death");
}

function deleteonownerdeath(var_0) {
  wait 0.25;
  self linkTo(var_0, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_0 waittill("death");
  box_leave();
}

function box_modelteamupdater(var_0) {
  self endon("death");
  self hide();

  foreach(var_2 in level.players) {
    if(var_2.team == var_0) {
      self showtoplayer(var_2);
    }
  }

  for(;;) {
    level waittill("joined_team");
    self hide();

    foreach(var_2 in level.players) {
      if(var_2.team == var_0) {
        self showtoplayer(var_2);
      }
    }
  }
}

function useholdthink(var_0, var_1) {
  var_0 scripts\common\utility::allow_weapon(0);
  var_0.boxparams = spawnStruct();
  var_0.boxparams.curprogress = 0;
  var_0.boxparams.inuse = 1;
  var_0.boxparams.userate = 0;
  var_0.boxparams.id = self.id;

  if(isDefined(var_1)) {
    var_0.boxparams.usetime = var_1;
  } else {
    var_0.boxparams.usetime = 3000;
  }

  var_2 = useholdthinkloop(var_0);

  if(isalive(var_0)) {
    var_0 scripts\common\utility::allow_weapon(1);
  }

  if(!isDefined(self)) {
    return 0;
  }

  var_0.boxparams.inuse = 0;
  var_0.boxparams.curprogress = 0;
  return var_2;
}

function useholdthinkloop(var_0) {
  var_1 = var_0.boxparams;

  while(isplayerusingbox(var_0, var_1)) {
    var_1.curprogress += level.frameduration * var_1.userate;

    if(isDefined(var_0.objectivescaler)) {
      var_1.userate = 1 * var_0.objectivescaler;
    } else {
      var_1.userate = 1;
    }

    if(var_1.curprogress >= var_1.usetime) {
      return var_0 scripts\cp_mp\utility\player_utility::_isalive();
    }

    waitframe();
  }

  return 0;
}

function addboxtoownerarray(var_0) {
  if(!isDefined(var_0.deployable_box)) {
    var_0.deployable_box = [];
  }

  if(!isDefined(var_0.deployable_box[self.boxtype])) {
    var_0.deployable_box[self.boxtype] = [];
  }

  if(var_0.deployable_box[self.boxtype].size >= 2) {
    var_1 = 1 + var_0.deployable_box[self.boxtype].size - 3;

    foreach(var_3 in var_0.deployable_box[self.boxtype]) {
      if(var_1 > 0) {
        thread supportbox_destroy();
        var_1--;
      }
    }
  }

  var_0.deployable_box[self.boxtype][self getentitynumber()] = self;
}

function removeboxfromownerarray(var_0) {
  if(isDefined(var_0)) {
    var_0.deployable_box[self.boxtype][self getentitynumber()] = undefined;
    return;
  }
}

function addboxtolevelarray() {
  if(isDefined(level.deployable_box[self.boxtype]) && level.deployable_box[self.boxtype].size > 0) {
    foreach(var_1 in level.deployable_box[self.boxtype]) {
      thread supportbox_destroy();
    }
  }

  level.deployable_box[self.boxtype][self getentitynumber()] = self;
}

function removeboxfromlevelarray() {
  level.deployable_box[self.boxtype][self getentitynumber()] = undefined;
}

function isplayerusingbox(var_0) {
  return !level.gameended && isDefined(var_0) && scripts\cp_mp\utility\player_utility::_isalive() && self useButtonPressed() && !self isonladder() && !self meleeButtonPressed() && var_0.curprogress < var_0.usetime && (!isDefined(self.teleporting) || !self.teleporting);
}

function isgrenadedeployable(var_0) {
  var_1 = 0;

  switch (var_0) {
    default:
      var_1 = 0;
      break;
  }

  return var_1;
}

function supportbox_ondeploy(var_0) {
  var_1 = self getlinkedparent();
  self unlink();
  self.angles = combineangles(self.angles, (0, 90, 0));
  self.origin += anglestoup(self.angles) * 3;

  if(isDefined(var_1)) {
    self linkTo(var_1);
  }

  thread supportbox_ondeployinternal(var_0);
}

function supportbox_ondeployinternal(var_0) {
  self endon("death");
  self setscriptablepartstate("anims", "open", 0);
  self setscriptablepartstate("effects", "plant", 0);
  wait var_0.deployanimduration;
}

#using_animtree("scriptables");

function supportbox_getdeployanimduration() {
  return getanimlength(%wm_supportbox_ground_open);
}

#using_animtree("");

function supportbox_getcloseanimduration() {
  return getanimlength(%wm_supportbox_ground_close);
}