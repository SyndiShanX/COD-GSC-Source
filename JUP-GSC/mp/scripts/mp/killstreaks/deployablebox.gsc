/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\killstreaks\deployablebox.gsc
*******************************************************/

#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#using scripts\mp\damage;
#using scripts\mp\gameobjects;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_util;
#using scripts\mp\killstreaks\deployablebox;
#using scripts\mp\movers;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\shellshock;
#using scripts\mp\utility\dialog;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\script;
#using scripts\mp\utility\weapon;
#namespace deployablebox;

function init() {
  if(!isDefined(level.boxsettings)) {
    level.boxsettings = [];
  }
}

function begindeployableviamarker(streakinfo, lifeid, boxtype, projectileentity, weaponname, damagefuncoverride, deathfuncoverride, var_2deffe8b3af50b42) {
  thread scripts\mp\killstreaks\deployablebox::cleanupdeployablemarkerondisconnect(projectileentity);
  thread watchdeployablemarkerplacement(streakinfo, boxtype, lifeid, projectileentity, weaponname, damagefuncoverride, deathfuncoverride, var_2deffe8b3af50b42);
  return true;
}

function watchdeployablemarkerplacement(streakinfo, boxtype, lifeid, marker, weaponname, damagefunc, deathfunc, timeoutfunc) {
  self endon("spawned_player");
  self endon("disconnect");

  if(!isDefined(marker)) {
    assertmsg("<dev string:x1c>");
    return;
  }

  if(!isDefined(weaponname)) {
    assertmsg("<dev string:x8e>");
    return;
  }

  if(!isreallyalive(self)) {
    marker delete();
  }

  marker makecollidewithitemclip(1);
  self notify("deployable_deployed");
  marker.owner = self;
  marker.weaponname = weaponname;
  self.marker = marker;

  if(isgrenadedeployable(boxtype)) {
    self thread[[level.boxsettings[boxtype].grenadeusefunc]](marker);
    return;
  }

  marker playsoundtoplayer(level.boxsettings[boxtype].deployedsfx, self);
  marker thread markeractivate(streakinfo, lifeid, boxtype, &box_setactive, damagefunc, deathfunc, timeoutfunc);
}

function cleanupdeployablemarkerondisconnect(marker) {
  marker endon("death");
  marker endon("late_missile_stuck");
  marker thread scripts\mp\utility\script::notifyafterframeend("missile_stuck", "late_missile_stuck");
  self waittill("disconnect");
  marker delete();
}

function override_box_moving_platform_death(data) {
  self.isdestroyed = 1;
  self notify("death");
}

function markeractivate(streakinfo, lifeid, boxtype, usedcallback, damagecallback, deathcallback, timeoutcallback) {
  self notify("markerActivate");
  self endon("markerActivate");
  self waittill("missile_stuck");
  owner = self.owner;
  position = self.origin;

  if(!isDefined(owner)) {
    return;
  }

  box = createboxforplayer(boxtype, position, owner);
  data = spawnStruct();
  data.linkparent = self getlinkedparent();

  if(isDefined(data.linkparent) && isDefined(data.linkparent.model) && data.linkparent.model != "") {
    box.origin = data.linkparent.origin;
    grandparent = data.linkparent getlinkedparent();

    if(isDefined(grandparent)) {
      data.linkparent = grandparent;
    } else {
      data.linkparent = undefined;
    }
  }

  data.deathoverridecallback = &override_box_moving_platform_death;
  box thread scripts\mp\movers::handle_moving_platforms(data);
  box.moving_platform = data.linkparent;
  box setotherent(owner);
  waitframe();
  box thread[[usedcallback]](damagecallback, deathcallback, timeoutcallback);
  level callback::callback("killstreak_finish_use", {
    #streakinfo: streakinfo
  });
  self delete();

  if(isDefined(box) && box touchingbadtrigger()) {
    self.isdestroyed = 1;
    box notify("death");
  }
}

function deployableexclusion(parentmodel) {
  if(parentmodel == "mp_satcom") {
    return true;
  } else if(issubstr(parentmodel, "paris_catacombs_iron")) {
    return true;
  } else if(issubstr(parentmodel, "mp_warhawk_iron_gate")) {
    return true;
  }

  return false;
}

function isholdingdeployablebox() {
  curweap = self getcurrentweapon();

  if(isDefined(curweap)) {
    foreach(var_98770f6793c42216 in level.boxsettings) {
      if(getcompleteweaponname(curweap) == var_98770f6793c42216.weaponinfo) {
        return true;
      }
    }
  }

  return false;
}

function createboxforplayer(boxtype, position, owner) {
  assertex(isDefined(owner), "<dev string:xfd>");
  var_86280fefb94b6b28 = level.boxsettings[boxtype];
  box = spawn("script_model", position - (0, 0, 1));
  box setModel(var_86280fefb94b6b28.modelbase);
  box.health = 999999;
  box.maxhealth = var_86280fefb94b6b28.maxhealth;
  box.angles = owner.angles;
  box.boxtype = boxtype;
  box.owner = owner;
  box.team = owner.team;
  box.id = var_86280fefb94b6b28.id;

  if(isDefined(var_86280fefb94b6b28.dpadname)) {
    box.dpadname = var_86280fefb94b6b28.dpadname;
  }

  if(isDefined(var_86280fefb94b6b28.maxuses)) {
    box.usesremaining = var_86280fefb94b6b28.maxuses;
  }

  box box_setinactive();
  box thread box_handleownerdisconnect();
  box addboxtolevelarray();
  return box;
}

function box_setactive(damagecallback, deathcallback, timeoutcallback) {
  var_86280fefb94b6b28 = level.boxsettings[self.boxtype];
  self.inuse = 0;
  curobjid = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(curobjid == -1) {
    return;
  }

  scripts\mp\objidpoolmanager::objective_add_objective(curobjid, "invisible", (0, 0, 0));

  if(!isDefined(self getlinkedparent())) {
    scripts\mp\objidpoolmanager::update_objective_position(curobjid, self.origin);
  } else {
    scripts\mp\objidpoolmanager::update_objective_onentity(curobjid, self);
  }

  scripts\mp\objidpoolmanager::update_objective_state(curobjid, "active");
  scripts\mp\objidpoolmanager::update_objective_icon(curobjid, var_86280fefb94b6b28.shadername);
  scripts\mp\objidpoolmanager::update_objective_setbackground(curobjid, 1);
  self.objidfriendly = curobjid;

  if(level.teambased) {
    if(curobjid != -1) {
      scripts\mp\objidpoolmanager::objective_teammask_single(curobjid, self.team);
    }

    box_seticon(self.team, var_86280fefb94b6b28.streakname, var_86280fefb94b6b28.headiconoffset);

    foreach(player in level.players) {
      if(self.team != player.team) {
        continue;
      }

      if(isDefined(var_86280fefb94b6b28.canusecallback) && !player[[var_86280fefb94b6b28.canusecallback]](self)) {
        if(isDefined(self.boxiconid)) {
          scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.boxiconid, player);
        }
      }
    }
  } else {
    if(curobjid != -1) {
      scripts\mp\objidpoolmanager::objective_playermask_single(curobjid, self.owner);
    }

    if(!isDefined(var_86280fefb94b6b28.canusecallback) || self.owner[[var_86280fefb94b6b28.canusecallback]](self)) {
      box_seticon(self.owner, var_86280fefb94b6b28.streakname, var_86280fefb94b6b28.headiconoffset);
    }
  }

  self makeusable();
  self setCursorHint("HINT_NOICON");
  self setHintString(var_86280fefb94b6b28.hintstring);
  self setusehideprogressbar(1);
  self.isusable = 1;
  self setCanDamage(1);

  if(isDefined(damagecallback)) {
    self thread[[damagecallback]]();
  } else {
    thread box_handledamage();
  }

  if(isDefined(deathcallback)) {
    self thread[[deathcallback]]();
  } else {
    thread box_handledeath();
  }

  if(isDefined(timeoutcallback)) {
    self thread[[timeoutcallback]]();
  } else {
    thread box_timeout();
  }

  scripts\mp\sentientpoolmanager::registersentient("Tactical_Ground", self.owner);

  if(isDefined(self.owner)) {
    self.owner notify("new_deployable_box", self);
  }

  if(level.teambased) {
    foreach(player in level.participants) {
      if(istrue(var_86280fefb94b6b28.isteamless)) {
        _box_setactivehelper(player, 1, var_86280fefb94b6b28.canusecallback);
      } else {
        _box_setactivehelper(player, self.team == player.team, var_86280fefb94b6b28.canusecallback);
      }

      if(!isai(player)) {
        thread box_playerjoinedteam(player);
      }
    }
  } else {
    foreach(player in level.participants) {
      _box_setactivehelper(player, isDefined(self.owner) && self.owner == player, var_86280fefb94b6b28.canusecallback);
    }
  }

  thread box_playerconnected();
  thread box_agentconnected();

  if(isDefined(var_86280fefb94b6b28.ondeploycallback)) {
    self[[var_86280fefb94b6b28.ondeploycallback]](var_86280fefb94b6b28);
  }
}

function _box_setactivehelper(player, bactivate, canusefunc) {
  if(bactivate) {
    if(!isDefined(canusefunc) || player[[canusefunc]](self)) {
      box_enableplayeruse(player);
    } else {
      box_disableplayeruse(player);
      thread doubledip(player);
    }

    thread boxthink(player);
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
  if(self.team == player.team || istrue(level.boxsettings[self.boxtype].isteamless)) {
    box_enableplayeruse(player);
    thread boxthink(player);
    return;
  }

  box_disableplayeruse(player);

  if(isDefined(self.boxiconid)) {
    scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.boxiconid, player);
  }
}

function box_seticon(player, streakname, voffset) {
  var_86280fefb94b6b28 = level.boxsettings[self.boxtype];
  headicon = getkillstreakoverheadicon(streakname);

  if(isDefined(var_86280fefb94b6b28.headicon)) {
    headicon = var_86280fefb94b6b28.headicon;
  }

  if(!scripts\cp_mp\utility\game_utility::function_b2c4b42f9236924()) {
    self.boxiconid = thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(player, headicon, voffset, 1);
  }
}

function box_enableplayeruse(player) {
  if(isPlayer(player)) {
    self enableplayeruse(player);
  }

  self.disabled_use_for[player getentitynumber()] = 0;
}

function box_disableplayeruse(player) {
  if(isPlayer(player)) {
    self disableplayeruse(player);
  }

  self.disabled_use_for[player getentitynumber()] = 1;
}

function box_setinactive() {
  self makeunusable();
  self.isusable = 0;

  if(isDefined(self.objidfriendly)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(self.objidfriendly);
  }
}

function box_handledamage() {
  var_86280fefb94b6b28 = level.boxsettings[self.boxtype];
  scripts\mp\damage::monitordamage(var_86280fefb94b6b28.maxhealth, var_86280fefb94b6b28.damagefeedback, &box_handledeathdamage, &box_modifydamage, 1);
}

function box_modifydamage(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;
  modifieddamage = damage;
  var_86280fefb94b6b28 = level.boxsettings[self.boxtype];

  if(var_86280fefb94b6b28.allowmeleedamage) {
    modifieddamage = utility::handlemeleedamage(objweapon, type, modifieddamage);
  }

  modifieddamage = scripts\mp\damage::handlemissiledamage(objweapon, type, modifieddamage);
  modifieddamage = scripts\mp\damage::handlegrenadedamage(objweapon, type, modifieddamage);
  modifieddamage = scripts\mp\damage::handleapdamage(objweapon, type, modifieddamage, attacker);
  return modifieddamage;
}

function box_handledeathdamage(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  self.destroyedbydamage = 1;
  var_86280fefb94b6b28 = level.boxsettings[self.boxtype];
  notifyattacker = scripts\mp\damage::onkillstreakkilled("deployable_ammo", attacker, objweapon, type, damage, var_86280fefb94b6b28.scorepopup, var_86280fefb94b6b28.vodestroyed);

  if(notifyattacker) {
    attacker notify("destroyed_equipment");
  }
}

function box_handledeath() {
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }

  box_setinactive();
  removeboxfromlevelarray();
  var_86280fefb94b6b28 = level.boxsettings[self.boxtype];

  if(!istrue(self.destroyedbydamage)) {
    playFX(var_86280fefb94b6b28.deathvfx, self.origin);
    self playSound("mp_killstreak_disappear");
  } else {
    damagespawnpos = self.origin + (0, 0, var_86280fefb94b6b28.headiconoffset);

    if(isDefined(var_86280fefb94b6b28.deathdamagemax)) {
      owner = undefined;

      if(isDefined(self.owner)) {
        owner = self.owner;
      }

      if(isDefined(var_86280fefb94b6b28.explodevfx)) {
        playFX(var_86280fefb94b6b28.explodevfx, self.origin);
        self playSound("c4_expl_trans");
      }

      radiusdamage(damagespawnpos, var_86280fefb94b6b28.deathdamageradius, var_86280fefb94b6b28.deathdamagemax, var_86280fefb94b6b28.deathdamagemin, owner, "MOD_EXPLOSIVE", "support_box_mp");
      thread scripts\mp\shellshock::grenade_earthquakeatposition(self.origin, 1);
    }
  }

  self notify("deleting");
  self delete();
}

function box_handleownerdisconnect() {
  self endon("death");
  level endon("game_ended");
  self notify("box_handleOwner");
  self endon("box_handleOwner");
  childthread box_watchownerstatus("disconnect");
  childthread box_watchownerstatus("joined_team");
  childthread box_watchownerstatus("joined_spectators");
}

function box_watchownerstatus(notifymsg) {
  self.owner waittill(notifymsg);
  self.isdestroyed = 1;
  self notify("death");
}

function boxthink(player) {
  self endon("death");
  thread boxcapturethink(player);

  if(!isDefined(player.boxes)) {
    player.boxes = [];
  }

  player.boxes[player.boxes.size] = self;
  var_86280fefb94b6b28 = level.boxsettings[self.boxtype];

  for(;;) {
    self waittill("captured", capturer);

    if(capturer == player) {
      player playlocalsound(var_86280fefb94b6b28.onusesfx);

      if(isDefined(var_86280fefb94b6b28.onusecallback)) {
        player[[var_86280fefb94b6b28.onusecallback]](self);
      }

      if(isDefined(self.owner) && player != self.owner && !scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, player)) {
        self.owner thread doscoreevent(#"support", undefined, var_86280fefb94b6b28.usexp);
      }

      if(isDefined(self.usesremaining)) {
        self.usesremaining--;

        if(self.usesremaining == 0) {
          box_leave();
          break;
        }
      }

      if(isDefined(var_86280fefb94b6b28.canuseotherboxes) && var_86280fefb94b6b28.canuseotherboxes) {
        foreach(box in level.deployable_box[var_86280fefb94b6b28.streakname]) {
          box scripts\mp\killstreaks\deployablebox::box_disableplayeruse(player);

          if(isDefined(box.boxiconid)) {
            scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(box.boxiconid, player);
          }

          box thread doubledip(player);
        }

        continue;
      }

      if(istrue(var_86280fefb94b6b28.canreusebox)) {
        continue;
      }

      if(isDefined(self.boxiconid)) {
        scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.boxiconid, player);
      }

      box_disableplayeruse(player);
      thread doubledip(player);
    }
  }
}

function doubledip(player) {
  self endon("death");
  player endon("disconnect");
  player waittill("death");

  if(level.teambased) {
    if(self.team == player.team) {
      if(isDefined(self.boxiconid)) {
        scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(self.boxiconid, player);
      }

      box_enableplayeruse(player);
    }

    return;
  }

  if(isDefined(self.owner) && self.owner == player) {
    if(isDefined(self.boxiconid)) {
      scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(self.boxiconid, player);
    }

    box_enableplayeruse(player);
  }
}

function boxcapturethink(player) {
  level endon("game_ended");

  while(isDefined(self)) {
    self waittill("trigger", triggerer);

    if(isDefined(level.boxsettings[self.boxtype].nousekillstreak) && level.boxsettings[self.boxtype].nousekillstreak && iskillstreakweapon(player getcurrentweapon())) {
      continue;
    }

    if(triggerer == player && useholdthink(player, level.boxsettings[self.boxtype].usetime)) {
      self notify("captured", player);
    }
  }
}

function isfriendlytobox(box) {
  return level.teambased && self.team == box.team;
}

function box_timeout() {
  self endon("death");
  level endon("game_ended");
  var_86280fefb94b6b28 = level.boxsettings[self.boxtype];
  lifespan = var_86280fefb94b6b28.lifespan;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(lifespan);

  if(isDefined(var_86280fefb94b6b28.vogone)) {
    self.owner thread scripts\mp\utility\dialog::leaderdialogonplayer(var_86280fefb94b6b28.vogone);
  }

  box_leave();
}

function box_leave() {
  waitframe();
  self.isdestroyed = 1;
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
  scripts\mp\movers::script_mover_link_to_use_object(player);
  player val::set("useHold", "weapon", 0);
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
    player val::reset_all("useHold");
    scripts\mp\movers::script_mover_unlink_from_use_object(player);
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
    if(!player scripts\mp\movers::script_mover_use_can_link(self)) {
      player scripts\mp\gameobjects::updateuiprogress(config, 0);
      return 0;
    }

    config.curprogress += level.frameduration * config.userate;

    if(isDefined(player.objectivescaler)) {
      config.userate = 1 * player.objectivescaler;
    } else {
      config.userate = 1;
    }

    player scripts\mp\gameobjects::updateuiprogress(config, 1);

    if(config.curprogress >= config.usetime) {
      player scripts\mp\gameobjects::updateuiprogress(config, 0);
      return isreallyalive(player);
    }

    waitframe();
  }

  player scripts\mp\gameobjects::updateuiprogress(config, 0);
  return 0;
}

function addboxtolevelarray() {
  level.deployable_box[self.boxtype][self getentitynumber()] = self;
}

function removeboxfromlevelarray() {
  level.deployable_box[self.boxtype][self getentitynumber()] = undefined;
}

function isplayerusingbox(box) {
  return !level.gameended && isDefined(box) && isreallyalive(self) && self useButtonPressed() && !self isonladder() && !self meleeButtonPressed() && box.curprogress < box.usetime && (!isDefined(self.teleporting) || !self.teleporting);
}

function isgrenadedeployable(boxtype) {
  isgrenade = 0;
  isgrenade = 0;
  return isgrenade;
}