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

function box_hint_func(var0, var1) {
  var2 = level.boxsettings[var0.box.boxtype];
  return var2.hintstring;
}

function box_activate_func(var0, var1) {
  var0.box notify("captured", var1);
}

function box_createinteraction(var0) {
  var1 = spawnStruct();
  var1.origin = var0.origin;
  var1.targetname = "interaction";
  var1.script_noteworthy = "deployable_box";
  var1.requires_power = 0;
  var1.box = var0;
  var1.spend_type = "null";
  var1.cost = 0;
  scripts\cp\cp_interaction::add_to_current_interaction_list(var1);
  var0.interaction = var1;
  return var0;
}

function begindeployableviamarker(var0, var1, var2, var3, var4, var5, var6) {
  thread watchdeployablemarkerplacement(var1, var0, var2, var3, var4, var5, var6);
  return true;
}

function watchdeployablemarkerplacement(var0, var1, var2, var3, var4, var5, var6) {
  self endon("spawned_player");
  self endon("disconnect");

  if(!isDefined(var2)) {
    return;
  }

  if(!isDefined(var3)) {
    return;
  }

  var2 makecollidewithitemclip(1);
  self notify("deployable_deployed");
  var7 = "cp_used_" + var0;
  var8 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo(var7, self);
  scripts\cp_mp\utility\killstreak_utility::ref_12aa7(var8);

  foreach(var10 in level.players) {
    var10 thread scripts\cp\cp_hud_message::showsplash(var7, undefined, self);
  }

  var2.owner = self;
  var2.weaponname = var3;
  self.marker = var2;
  var12 = scripts\cp\utility::getweapontoswitchbackto();
  var13 = thread scripts\cp\cp_weapons::switchtoweaponreliable(var12, 0);
  self.last_weapon = undefined;

  if(isgrenadedeployable(var0)) {
    self thread[[level.boxsettings[var0].grenadeusefunc]](var2);
    return;
  }

  thread markeractivate(var2, var1, var0, &box_setactive, var4, var5);
}

function override_box_moving_platform_death(var0) {
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

function markeractivate(var0, var1, var2, var3, var4, var5) {
  self notify("markerActivate");
  self endon("markerActivate");
  var6 = scripts\engine\utility::ref_143ae("missile_stuck", "explode", "death");
  var7 = self.owner;
  var8 = self.origin;
  var9 = level.boxsettings[var1];
  var10 = undefined;

  if(var6 == "explode") {
    var10 = createboxforplayer(var1, scripts\engine\utility::drop_to_ground(var8, 1000), var7);
  } else if(var6 == "death") {
    var10 = createboxforplayer(var1, scripts\engine\utility::drop_to_ground(var8, 1000), var7);
  } else {
    var10 = self;
  }

  var10 setscriptablepartstate("effects", "plant", 0);
  var10 setscriptablepartstate("anims", "closedIdle", 0);
  var10 setscriptablepartstate("beacon", "active", 0);
  var10.health = 999999;
  var10.maxhealth = var9.maxhealth;
  var10.angles = self.angles;
  var10.boxtype = var1;
  var10.owner = var7;
  var10.team = var7.team;
  var10.id = var9.id;

  if(isDefined(var9.dpadname)) {
    var10.dpadname = var9.dpadname;
  }

  if(isDefined(var9.maxuses)) {
    var10.usesremaining = var9.maxuses;
  }

  var10.owner.supportbox = var10;
  thread box_handleownerdisconnect();
  addboxtoownerarray(var10, var10.owner);
  supportbox_addowneroutline(var10);
  var10[[var2]](var10, var3, var4, var5);
  var11 = level.crafting_table_data[var1].metal;
  var12 = 0;

  if(var7 scripts\cp\cp_persistence::try_take_player_currency(var11)) {
    return;
  }
}

function supportbox_destroy() {
  self setscriptablepartstate("effects", "destroy", 0);
  self setscriptablepartstate("beacon", "neutral", 0);
  thread supportbox_delete(3);
}

function supportbox_delete(var0) {
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
  var0 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(var0 == -1) {
    return;
  }

  scripts\mp\objidpoolmanager::objective_add_objective(var0, "invisible", (0, 0, 0));
  scripts\mp\objidpoolmanager::update_objective_onentity(var0, self);
  scripts\mp\objidpoolmanager::update_objective_state(var0, "active");
  scripts\mp\objidpoolmanager::update_objective_icon(var0, level.boxsettings[self.boxtype].shadername);
  scripts\mp\objidpoolmanager::update_objective_setbackground(var0, 1);
}

function supportbox_removeobjectiveicon() {
  if(isDefined(self.objectiveiconid)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(self.objectiveiconid);
    return;
  }
}

function createboxforplayer(var0, var1, var2) {
  var3 = level.boxsettings[var0];
  var4 = spawn("script_model", var1 - (0, 0, 1));
  var4 setModel(var3.modelbase);
  var4.health = 999999;
  var4.maxhealth = var3.maxhealth;
  var4.angles = self.angles;
  var4.boxtype = var0;
  var4.owner = var2;
  var4.team = var2.team;
  var4.id = var3.id;
  return var4;
}

function box_setactive(var0, var1, var2, var3) {
  var4 = level.boxsettings[self.boxtype];
  self.inuse = 0;

  if(isDefined(self.owner)) {
    self.owner thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("munitions_box_teammate_used");
    self.owner notify("munitions_used", var0.boxtype);
    self.owner thread scripts\cp\cp_player_battlechatter::onmunitionboxused(self.boxtype);
  }

  if(isDefined(var4.deployfunc)) {
    self.owner thread[[var4.deployfunc]]();
  }

  if(!isDefined(var4.canusecallback) || self.owner[[var4.canusecallback]](self)) {
    box_seticon(self.owner, var4.streakname, var4.headiconoffset);
  }

  var0 = box_createinteraction(var0);

  if(isDefined(var1)) {
    self thread[[var1]]();
  } else {
    thread box_handledamage();
  }

  thread box_handledeath();

  if(isDefined(var3)) {
    self thread[[var3]]();
  } else {
    thread box_timeout();
  }

  thread box_playerconnected();
  thread box_agentconnected();
  thread boxthink();
}

function _box_setactivehelper(var0, var1, var2) {
  if(var1) {
    if(!isDefined(var2) || var0[[var2]](self)) {
      box_enableplayeruse(var0);
    }

    thread boxthink();
    return;
  }

  box_disableplayeruse(var0);
}

function box_playerconnected() {
  self endon("death");
  level waittill("connected", var0);
  GscBinSkip4(0x35, var0);
}

function box_agentconnected() {
  self endon("death");

  for(;;) {
    level waittill("spawned_agent_player", var0);
    box_addboxforplayer(var0);
  }
}

function box_waittill_player_spawn_and_add_box(var0) {
  var0 waittill("spawned_player");

  if(level.teambased) {
    box_addboxforplayer(var0);
    thread box_playerjoinedteam(var0);
    return;
  }
}

function box_playerjoinedteam(var0) {
  self endon("death");
  var0 endon("disconnect");

  for(;;) {
    var0 waittill("joined_team");

    if(level.teambased) {
      box_addboxforplayer(var0);
    }
  }
}

function box_addboxforplayer(var0) {
  if(self.team == var0.team) {
    box_enableplayeruse(var0);
    thread boxthink();
    box_seticon(var0, level.boxsettings[self.boxtype].streakname, level.boxsettings[self.boxtype].headiconoffset);
    return;
  }

  box_disableplayeruse(var0);
}

function box_seticon(var0, var1, var2) {
  var3 = level.boxsettings[self.boxtype];
  var4 = undefined;

  if(isDefined(var3.headicon)) {
    var4 = var3.headicon;
  }

  self.boxiconid = thread scripts\cp\utility::ent_createheadicon(self, var2, self.team, var4, 0);
}

function box_enableplayeruse(var0) {
  self.disabled_use_for[var0 getentitynumber()] = 0;
}

function box_disableplayeruse(var0) {
  self.disabled_use_for[var0 getentitynumber()] = 1;
}

function box_setinactive() {}

function box_handledamage() {
  var0 = level.boxsettings[self.boxtype];
}

function box_modifydamage(var0) {
  var1 = var0.attacker;
  var2 = var0.objweapon;
  var3 = var0.meansofdeath;
  var4 = var0.damage;
  var5 = var0.idflags;
  var6 = var4;
  var7 = level.boxsettings[self.boxtype];
  return var6;
}

function box_handledeathdamage(var0) {
  var1 = var0.attacker;
  var2 = var0.objweapon;
  var3 = var0.meansofdeath;
  var4 = var0.damage;
  var5 = level.boxsettings[self.boxtype];
  var1 notify("destroyed_equipment");
}

function box_handledeath() {
  self waittill("death");
  scripts\cp\cp_interaction::remove_from_current_interaction_list(self.interaction);

  foreach(var1 in level.players) {
    var1 scripts\cp\cp_interaction::refresh_interaction();
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

  var3 = level.boxsettings[self.boxtype];
  var4 = anglesToForward(self.angles);
  var5 = anglestoup(self.angles);
  playFX(var3.deathvfx, self.origin, var4, var5);
  self playSound("mp_equip_destroyed");
  self notify("deleting");
  self delete();
}

function box_handleownerdisconnect() {
  self endon("death");
  level endon("game_ended");
  self notify("box_handleOwner");
  self endon("box_handleOwner");
  self.owner scripts\engine\utility::ref_143a5("killstreak_disowned", "disconnect");
  self notify("death");
}

function boxthink() {
  var0 = level.boxsettings[self.boxtype];

  for(;;) {
    self waittill("captured", var1);

    if(isPlayer(var1) && var1.team == self.owner.team) {
      var2 = 1;

      if(isDefined(var0.onusecallback)) {
        var2 = var1[[var0.onusecallback]](self);
      }

      if(istrue(var2)) {
        thread ref_12457();
        var1 scripts\cp\utility::playerplaypickupanim("ges_swipe");

        if(isDefined(self.owner) && var1 != self.owner) {
          self.owner thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("munitions_box_teammate_used");

          if(isDefined(var0.ref_120aa)) {
            level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var1, var0.ref_120aa);
          }
        }

        if(isDefined(self.usesremaining)) {
          self.usesremaining--;

          if(self.usesremaining == 0) {
            box_leave();
            break;
          }
        }

        if(isDefined(var0.canuseotherboxes) && var0.canuseotherboxes) {
          foreach(var4 in level.deployable_box[var0.streakname]) {
            box_disableplayeruse(var4, self);
            thread doubledip(var4);
          }

          continue;
        }

        if(istrue(var0.canreusebox)) {}
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

function doubledip(var0) {
  self endon("death");
  var0 endon("disconnect");
  var0 waittill("death");

  if(level.teambased) {
    if(self.team == var0.team) {
      box_seticon(var0, level.boxsettings[self.boxtype].streakname, level.boxsettings[self.boxtype].headiconoffset);
      box_enableplayeruse(var0);
      return;
    }

    return;
  }

  if(isDefined(self.owner) && self.owner == var0) {
    box_seticon(var0, level.boxsettings[self.boxtype].streakname, level.boxsettings[self.boxtype].headiconoffset);
    box_enableplayeruse(var0);
    return;
  }
}

function boxcapturethink(var0) {
  level endon("game_ended");

  while(isDefined(self)) {
    self waittill("trigger", var1);

    if(var1 == var0) {
      self notify("captured", var1);
    }
  }
}

function isfriendlytobox(var0) {
  return level.teambased && self.team == var0.team;
}

function box_timeout() {
  self endon("death");
  level endon("game_ended");
  var0 = level.boxsettings[self.boxtype];
  var1 = var0.lifespan;
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(var1);
  box_leave();
}

function box_leave() {
  waitframe();
  self notify("death");
}

function deleteonownerdeath(var0) {
  wait 0.25;
  self linkTo(var0, "tag_origin", (0, 0, 0), (0, 0, 0));
  var0 waittill("death");
  box_leave();
}

function box_modelteamupdater(var0) {
  self endon("death");
  self hide();

  foreach(var2 in level.players) {
    if(var2.team == var0) {
      self showtoplayer(var2);
    }
  }

  for(;;) {
    level waittill("joined_team");
    self hide();

    foreach(var2 in level.players) {
      if(var2.team == var0) {
        self showtoplayer(var2);
      }
    }
  }
}

function useholdthink(var0, var1) {
  var0 scripts\common\utility::allow_weapon(0);
  var0.boxparams = spawnStruct();
  var0.boxparams.curprogress = 0;
  var0.boxparams.inuse = 1;
  var0.boxparams.userate = 0;
  var0.boxparams.id = self.id;

  if(isDefined(var1)) {
    var0.boxparams.usetime = var1;
  } else {
    var0.boxparams.usetime = 3000;
  }

  var2 = useholdthinkloop(var0);

  if(isalive(var0)) {
    var0 scripts\common\utility::allow_weapon(1);
  }

  if(!isDefined(self)) {
    return 0;
  }

  var0.boxparams.inuse = 0;
  var0.boxparams.curprogress = 0;
  return var2;
}

function useholdthinkloop(var0) {
  var1 = var0.boxparams;

  while(isplayerusingbox(var0, var1)) {
    var1.curprogress += level.frameduration * var1.userate;

    if(isDefined(var0.objectivescaler)) {
      var1.userate = 1 * var0.objectivescaler;
    } else {
      var1.userate = 1;
    }

    if(var1.curprogress >= var1.usetime) {
      return var0 scripts\cp_mp\utility\player_utility::_isalive();
    }

    waitframe();
  }

  return 0;
}

function addboxtoownerarray(var0) {
  if(!isDefined(var0.deployable_box)) {
    var0.deployable_box = [];
  }

  if(!isDefined(var0.deployable_box[self.boxtype])) {
    var0.deployable_box[self.boxtype] = [];
  }

  if(var0.deployable_box[self.boxtype].size >= 2) {
    var1 = 1 + var0.deployable_box[self.boxtype].size - 3;

    foreach(var3 in var0.deployable_box[self.boxtype]) {
      if(var1 > 0) {
        thread supportbox_destroy();
        var1--;
      }
    }
  }

  var0.deployable_box[self.boxtype][self getentitynumber()] = self;
}

function removeboxfromownerarray(var0) {
  if(isDefined(var0)) {
    var0.deployable_box[self.boxtype][self getentitynumber()] = undefined;
    return;
  }
}

function addboxtolevelarray() {
  if(isDefined(level.deployable_box[self.boxtype]) && level.deployable_box[self.boxtype].size > 0) {
    foreach(var1 in level.deployable_box[self.boxtype]) {
      thread supportbox_destroy();
    }
  }

  level.deployable_box[self.boxtype][self getentitynumber()] = self;
}

function removeboxfromlevelarray() {
  level.deployable_box[self.boxtype][self getentitynumber()] = undefined;
}

function isplayerusingbox(var0) {
  return !level.gameended && isDefined(var0) && scripts\cp_mp\utility\player_utility::_isalive() && self useButtonPressed() && !self isonladder() && !self meleeButtonPressed() && var0.curprogress < var0.usetime && (!isDefined(self.teleporting) || !self.teleporting);
}

function isgrenadedeployable(var0) {
  var1 = 0;

  switch (var0) {
    default:
      var1 = 0;
      break;
  }

  return var1;
}

function supportbox_ondeploy(var0) {
  var1 = self getlinkedparent();
  self unlink();
  self.angles = combineangles(self.angles, (0, 90, 0));
  self.origin += anglestoup(self.angles) * 3;

  if(isDefined(var1)) {
    self linkTo(var1);
  }

  thread supportbox_ondeployinternal(var0);
}

function supportbox_ondeployinternal(var0) {
  self endon("death");
  self setscriptablepartstate("anims", "open", 0);
  self setscriptablepartstate("effects", "plant", 0);
  wait var0.deployanimduration;
}

#using_animtree("scriptables");

function supportbox_getdeployanimduration() {
  return getanimlength(%wm_supportbox_ground_open);
}

#using_animtree("");

function supportbox_getcloseanimduration() {
  return getanimlength(%wm_supportbox_ground_close);
}