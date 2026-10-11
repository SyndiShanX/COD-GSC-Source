/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\cp_deployablebox.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp\cp_adrenaline_crate;
#using scripts\cp\cp_ammo_crate;
#using scripts\cp\cp_armor_crate;
#using scripts\cp\cp_grenade_crate;
#using scripts\cp\cp_hostmigration;
#using scripts\cp\cp_hud_message;
#using scripts\cp\cp_outline_utility;
#using scripts\cp\cp_player_battlechatter;
#using scripts\cp\cp_weapons;
#using scripts\cp\interaction;
#using scripts\cp\munitions_crate;
#using scripts\cp\persistence;
#using scripts\cp\points;
#using scripts\cp\utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\utility;
#using scripts\mp\objidpoolmanager;
#namespace cp_deployablebox;

function init() {
  level.deployable_box_interaction = &init_box_interaction;

  if(!isDefined(level.boxsettings)) {
    level.boxsettings = [];
  }

  level thread scripts\cp\cp_ammo_crate::ammo_crate_init();
  level thread scripts\cp\cp_grenade_crate::grenade_crate_init();
  level thread scripts\cp\cp_armor_crate::armor_crate_init();
  level thread scripts\cp\munitions_crate::function_6444dd7186b01cfc();
  level thread scripts\cp\cp_adrenaline_crate::adrenaline_crate_init();
}

function init_box_interaction() {
  scripts\cp\interaction::register_interaction("deployable_box", "null", undefined, &box_hint_func, &box_activate_func, 0, 0, undefined);
}

function box_hint_func(interaction_struct, player) {
  boxconfig = level.boxsettings[interaction_struct.box.boxtype];
  return boxconfig.hintstring;
}

function box_activate_func(interaction_struct, player) {
  interaction_struct.box notify("captured", player);
}

function box_createinteraction(box) {
  interaction = spawnStruct();
  interaction.origin = box.origin;
  interaction.targetname = "interaction";
  interaction.script_noteworthy = "deployable_box";
  interaction.requires_power = 0;
  interaction.box = box;
  interaction.spend_type = "null";
  interaction.cost = 0;
  scripts\cp\interaction::add_to_current_interaction_list(interaction);
  box.interaction = interaction;
  return box;
}

function begindeployableviamarker(lifeid, boxtype, projectileentity, weaponname, damagefuncoverride, deathfuncoverride, var_2deffe8b3af50b42) {
  thread watchdeployablemarkerplacement(boxtype, lifeid, projectileentity, weaponname, damagefuncoverride, deathfuncoverride, var_2deffe8b3af50b42);
  return true;
}

function watchdeployablemarkerplacement(boxtype, lifeid, marker, weaponname, damagefunc, deathfunc, timeoutfunc) {
  self endon("spawned_player");
  self endon("disconnect");

  if(!isDefined(marker)) {
    assertmsg("watchDeployableMarkerPlacement(): No marker entity passed in. The calling script probably needs to be updated.");
    return;
  }

  if(!isDefined(weaponname)) {
    assertmsg("watchDeployableMarkerPlacement(): No weaponName passed in. The calling script probably needs to be updated.");
    return;
  }

  marker makecollidewithitemclip(1);
  self notify("deployable_deployed");
  splashref = "cp_used_" + boxtype;
  streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo(splashref, self);
  scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(streakinfo);

  foreach(player in level.players) {
    player thread scripts\cp\cp_hud_message::showsplash(splashref, undefined, self);
  }

  marker.owner = self;
  marker.weaponname = weaponname;
  self.marker = marker;
  weapontoswitch = getweapontoswitchbackto();
  success = thread scripts\cp\cp_weapons::switchtoweaponreliable(weapontoswitch, 0);
  self.last_weapon = undefined;

  if(isgrenadedeployable(boxtype)) {
    self thread[[level.boxsettings[boxtype].grenadeusefunc]](marker);
    return;
  }

  marker thread markeractivate(lifeid, boxtype, &box_setactive, damagefunc, deathfunc, timeoutfunc);
}

function override_box_moving_platform_death(data) {
  self notify("death");
}

function marker_watchdisownedtimeout() {
  self endon("death");
  marker_watchdisownedtimeoutinternal();

  if(isDefined(self) && !istrue(self.isdestroyed)) {
    thread supportbox_destroy();
  }
}

function marker_watchdisownedtimeoutinternal() {
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  level endon("game_ended");
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(5);
}

function markeractivate(lifeid, boxtype, usedcallback, damagecallback, deathcallback, timeoutcallback) {
  self notify("markerActivate");
  self endon("markerActivate");
  result = waittill_any_return_3("missile_stuck", "explode", "death");
  owner = self.owner;
  position = self.origin;
  boxconfig = level.boxsettings[boxtype];
  box = undefined;

  if(result == "explode") {
    box = createboxforplayer(boxtype, drop_to_ground(position, 1000), owner);
  } else if(result == "death") {
    box = createboxforplayer(boxtype, drop_to_ground(position, 1000), owner);
  } else {
    box = self;
  }

  box setscriptablepartstate("effects", "plant", 0);
  box setscriptablepartstate("anims", "closedIdle", 0);
  box setscriptablepartstate("beacon", "active", 0);
  box.health = 999999;
  box.maxhealth = boxconfig.maxhealth;
  box.angles = self.angles;
  box.boxtype = boxtype;
  box.owner = owner;
  box.team = owner.team;
  box.id = boxconfig.id;

  if(isDefined(boxconfig.dpadname)) {
    box.dpadname = boxconfig.dpadname;
  }

  if(isDefined(boxconfig.maxuses)) {
    box.usesremaining = boxconfig.maxuses;
  }

  box.owner.supportbox = box;
  box thread box_handleownerdisconnect();
  box addboxtoownerarray(box.owner);
  box supportbox_addowneroutline();
  box[[usedcallback]](box, damagecallback, deathcallback, timeoutcallback);
  item_cost = level.crafting_table_data[boxtype].metal;
  secondary_cost = 0;

  if(owner scripts\cp\persistence::try_take_player_currency(item_cost)) {}
}

function supportbox_destroy() {
  self setscriptablepartstate("effects", "destroy", 0);
  self setscriptablepartstate("beacon", "neutral", 0);
  thread supportbox_delete(3);
}

function supportbox_delete(deletiondelay) {
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
    }
  }
}

function supportbox_removeowneroutline() {
  if(isDefined(self.outlineid)) {
    scripts\cp\cp_outline_utility::outlinedisable(self.outlineid, self);
  }
}

function supportbox_addobjectiveicon() {
  objectiveiconid = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(objectiveiconid == -1) {
    return;
  }

  scripts\mp\objidpoolmanager::objective_add_objective(objectiveiconid, "invisible", (0, 0, 0));
  scripts\mp\objidpoolmanager::update_objective_onentity(objectiveiconid, self);
  scripts\mp\objidpoolmanager::update_objective_state(objectiveiconid, "active");
  scripts\mp\objidpoolmanager::update_objective_icon(objectiveiconid, level.boxsettings[self.boxtype].shadername);
  scripts\mp\objidpoolmanager::update_objective_setbackground(objectiveiconid, 1);
}

function supportbox_removeobjectiveicon() {
  if(isDefined(self.objectiveiconid)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(self.objectiveiconid);
  }
}

function createboxforplayer(boxtype, position, owner) {
  assertex(isDefined(owner), "createBoxForPlayer() called without owner specified");
  boxconfig = level.boxsettings[boxtype];
  box = spawn("script_model", position - (0, 0, 1));
  box setModel(boxconfig.modelbase);
  box.health = 999999;
  box.maxhealth = boxconfig.maxhealth;
  box.angles = self.angles;
  box.boxtype = boxtype;
  box.owner = owner;
  box.team = owner.team;
  box.id = boxconfig.id;
  return box;
}

function box_setactive(box, damagecallback, deathcallback, timeoutcallback) {
  boxconfig = level.boxsettings[self.boxtype];
  self.inuse = 0;

  if(isDefined(self.owner)) {
    self.owner thread scripts\cp\points::doscoreevent(#"hash_decd39d6aeca5c6c");
    self.owner notify("munitions_used", box.boxtype);
    self.owner thread scripts\cp\cp_player_battlechatter::onmunitionboxused(self.boxtype);
  }

  if(isDefined(boxconfig.deployfunc)) {
    self.owner thread[[boxconfig.deployfunc]]();
  }

  if(!isDefined(boxconfig.canusecallback) || self.owner[[boxconfig.canusecallback]](self)) {
    box_seticon(self.owner, boxconfig.streakname, boxconfig.headiconoffset);
  }

  box = box_createinteraction(box);

  if(isDefined(damagecallback)) {
    self thread[[damagecallback]]();
  } else {
    thread box_handledamage();
  }

  thread box_handledeath();

  if(isDefined(timeoutcallback)) {
    self thread[[timeoutcallback]]();
  } else {
    thread box_timeout();
  }

  thread box_playerconnected();
  thread box_agentconnected();
  thread boxthink();
}

function _box_setactivehelper(player, bactivate, canusefunc) {
  if(bactivate) {
    if(!isDefined(canusefunc) || player[[canusefunc]](self)) {
      box_enableplayeruse(player);
    }

    thread boxthink();
    return;
  }

  box_disableplayeruse(player);
}

function box_playerconnected() {
  self endon("death");

  while(true) {
    level waittill("connected", player);
    childthread box_waittill_player_spawn_and_add_box(player);
  }
}

function box_agentconnected() {
  self endon("death");

  while(true) {
    level waittill("spawned_agent_player", agent);
    box_addboxforplayer(agent);
  }
}

function box_waittill_player_spawn_and_add_box(player) {
  player waittill("spawned_player");

  if(level.teambased) {
    box_addboxforplayer(player);
    thread box_playerjoinedteam(player);
  }
}

function box_playerjoinedteam(player) {
  self endon("death");
  player endon("disconnect");

  while(true) {
    player waittill("joined_team");

    if(level.teambased) {
      box_addboxforplayer(player);
    }
  }
}

function box_addboxforplayer(player) {
  if(self.team == player.team) {
    box_enableplayeruse(player);
    thread boxthink();
    box_seticon(player, level.boxsettings[self.boxtype].streakname, level.boxsettings[self.boxtype].headiconoffset);
    return;
  }

  box_disableplayeruse(player);
}

function box_seticon(player, streakname, voffset) {
  boxconfig = level.boxsettings[self.boxtype];
  headicon = undefined;

  if(isDefined(boxconfig.headicon)) {
    headicon = boxconfig.headicon;
  }

  self.boxiconid = thread scripts\cp\utility::ent_createheadicon(self, voffset, self.team, headicon, 0);
}

function box_enableplayeruse(player) {
  self.disabled_use_for[player getentitynumber()] = 0;
}

function box_disableplayeruse(player) {
  self.disabled_use_for[player getentitynumber()] = 1;
}

function box_setinactive() {}

function box_handledamage() {
  boxconfig = level.boxsettings[self.boxtype];
}

function box_modifydamage(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;
  modifieddamage = damage;
  boxconfig = level.boxsettings[self.boxtype];
  return modifieddamage;
}

function box_handledeathdamage(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  boxconfig = level.boxsettings[self.boxtype];
  attacker notify("destroyed_equipment");
}

function box_handledeath() {
  self waittill("death");
  scripts\cp\interaction::remove_from_current_interaction_list(self.interaction);

  foreach(player in level.players) {
    player scripts\cp\interaction::refresh_interaction();
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

  boxconfig = level.boxsettings[self.boxtype];
  forward = anglesToForward(self.angles);
  up = anglestoup(self.angles);
  playFX(boxconfig.deathvfx, self.origin, forward, up);
  self playSound("mp_equip_destroyed");
  self notify("deleting");
  self delete();
}

function box_handleownerdisconnect() {
  self endon("death");
  level endon("game_ended");
  self notify("box_handleOwner");
  self endon("box_handleOwner");
  self.owner waittill_any_2("killstreak_disowned", "disconnect");
  self notify("death");
}

function boxthink() {
  boxconfig = level.boxsettings[self.boxtype];

  while(true) {
    self waittill("captured", capturer);

    if(isPlayer(capturer) && capturer.team == self.owner.team) {
      success = 1;

      if(isDefined(boxconfig.onusecallback)) {
        success = capturer[[boxconfig.onusecallback]](self);
      }

      if(istrue(success)) {
        thread playboxuseanimation();
        capturer scripts\cp\utility::playerplaypickupanim("iw9_ges_pickup");

        if(isDefined(self.owner) && capturer != self.owner) {
          self.owner thread scripts\cp\points::doscoreevent(#"hash_decd39d6aeca5c6c");

          if(isDefined(boxconfig.onusethanksbc)) {
            level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(capturer, boxconfig.onusethanksbc);
          }
        }

        if(isDefined(self.usesremaining)) {
          self.usesremaining--;

          if(self.usesremaining == 0) {
            box_leave();
            break;
          }
        }

        if(isDefined(boxconfig.canuseotherboxes) && boxconfig.canuseotherboxes) {
          foreach(box in level.deployable_box[boxconfig.streakname]) {
            box box_disableplayeruse(self);
            box thread doubledip(self);
          }

          continue;
        }

        if(istrue(boxconfig.canreusebox)) {}
      }
    }
  }
}

function playboxuseanimation() {
  self endon("death");
  self notify("playerboxUseAnimation");
  self endon("playerboxUseAnimation");
  self setscriptablepartstate("anims", "open", 0);
  wait supportbox_getdeployanimduration();
  self setscriptablepartstate("anims", "close", 0);
  wait supportbox_getcloseanimduration();
  self setscriptablepartstate("anims", "closedIdle", 0);
}

function doubledip(player) {
  self endon("death");
  player endon("disconnect");
  player waittill("death");

  if(level.teambased) {
    if(self.team == player.team) {
      box_seticon(player, level.boxsettings[self.boxtype].streakname, level.boxsettings[self.boxtype].headiconoffset);
      box_enableplayeruse(player);
    }

    return;
  }

  if(isDefined(self.owner) && self.owner == player) {
    box_seticon(player, level.boxsettings[self.boxtype].streakname, level.boxsettings[self.boxtype].headiconoffset);
    box_enableplayeruse(player);
  }
}

function boxcapturethink(player) {
  level endon("game_ended");

  while(isDefined(self)) {
    self waittill("trigger", triggerer);

    if(triggerer == player) {
      self notify("captured", triggerer);
    }
  }
}

function isfriendlytobox(box) {
  return level.teambased && self.team == box.team;
}

function box_timeout() {
  self endon("death");
  level endon("game_ended");
  boxconfig = level.boxsettings[self.boxtype];
  lifespan = boxconfig.lifespan;
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(lifespan);
  box_leave();
}

function box_leave() {
  waitframe();
  self notify("death");
}

function deleteonownerdeath(owner) {
  wait 0.25;
  self linkTo(owner, "tag_origin", (0, 0, 0), (0, 0, 0));
  owner waittill("death");
  box_leave();
}

function box_modelteamupdater(var_ef682a37eef48976) {
  self endon("death");
  self hide();

  foreach(player in level.players) {
    if(player.team == var_ef682a37eef48976) {
      self showtoplayer(player);
    }
  }

  for(;;) {
    level waittill("joined_team");
    self hide();

    foreach(player in level.players) {
      if(player.team == var_ef682a37eef48976) {
        self showtoplayer(player);
      }
    }
  }
}

function useholdthink(player, usetime) {
  player val::set("use_hold", "weapon", 0);
  player.boxparams = spawnStruct();
  player.boxparams.curprogress = 0;
  player.boxparams.inuse = 1;
  player.boxparams.userate = 0;
  player.boxparams.id = self.id;

  if(isDefined(usetime)) {
    player.boxparams.usetime = usetime;
  } else {
    player.boxparams.usetime = 3000;
  }

  result = useholdthinkloop(player);
  assert(isDefined(result));

  if(isalive(player)) {
    player val::reset_all("use_hold");
  }

  if(!isDefined(self)) {
    return 0;
  }

  player.boxparams.inuse = 0;
  player.boxparams.curprogress = 0;
  return result;
}

function useholdthinkloop(player) {
  config = player.boxparams;

  while(player isplayerusingbox(config)) {
    config.curprogress += level.frameduration * config.userate;

    if(isDefined(player.objectivescaler)) {
      config.userate = 1 * player.objectivescaler;
    } else {
      config.userate = 1;
    }

    if(config.curprogress >= config.usetime) {
      return player scripts\cp_mp\utility\player_utility::_isalive();
    }

    waitframe();
  }

  return 0;
}

function addboxtoownerarray(owner) {
  if(!isDefined(owner.deployable_box)) {
    owner.deployable_box = [];
  }

  if(!isDefined(owner.deployable_box[self.boxtype])) {
    owner.deployable_box[self.boxtype] = [];
  }

  if(owner.deployable_box[self.boxtype].size >= 2) {
    diff = 1 + owner.deployable_box[self.boxtype].size - 3;

    foreach(box in owner.deployable_box[self.boxtype]) {
      if(diff > 0) {
        box thread supportbox_destroy();
        diff--;
      }
    }
  }

  owner.deployable_box[self.boxtype][self getentitynumber()] = self;
}

function removeboxfromownerarray(owner) {
  if(isDefined(owner)) {
    owner.deployable_box[self.boxtype][self getentitynumber()] = undefined;
  }
}

function addboxtolevelarray() {
  if(isDefined(level.deployable_box[self.boxtype]) && level.deployable_box[self.boxtype].size > 0) {
    foreach(box in level.deployable_box[self.boxtype]) {
      box thread supportbox_destroy();
    }
  }

  level.deployable_box[self.boxtype][self getentitynumber()] = self;
}

function removeboxfromlevelarray() {
  level.deployable_box[self.boxtype][self getentitynumber()] = undefined;
}

function isplayerusingbox(box) {
  return !level.gameended && isDefined(box) && scripts\cp_mp\utility\player_utility::_isalive() && self useButtonPressed() && !self isonladder() && !self meleeButtonPressed() && box.curprogress < box.usetime && (!isDefined(self.teleporting) || !self.teleporting);
}

function isgrenadedeployable(boxtype) {
  isgrenade = 0;
  isgrenade = 0;
  return isgrenade;
}

function supportbox_ondeploy(boxconfig) {
  parent = self getlinkedparent();
  self unlink();
  self.angles = combineangles(self.angles, (0, 90, 0));
  self.origin += anglestoup(self.angles) * 3;

  if(isDefined(parent)) {
    self linkTo(parent);
  }

  thread supportbox_ondeployinternal(boxconfig);
}

function supportbox_ondeployinternal(boxconfig) {
  self endon("death");
  self setscriptablepartstate("anims", "open", 0);
  self setscriptablepartstate("effects", "plant", 0);
  wait boxconfig.deployanimduration;
}

#using_animtree("scriptables");

function supportbox_getdeployanimduration() {
  return getanimlength(%wm_supportbox_ground_open);
}

function supportbox_getcloseanimduration() {
  return getanimlength(%wm_supportbox_ground_close);
}