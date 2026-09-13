/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\deployablebox.gsc
****************************************************/

init() {
  if(!isDefined(level.boxsettings))
    level.boxsettings = [];
}

begindeployableviamarker(streakinfo, lifeid, boxtype, _id_DFDBF43603E7958D, weaponname, _id_D6421C0CADE6BA92, _id_79DA2138DECDE7FB, _id_2DEFFE8B3AF50B42) {
  thread cleanupdeployablemarkerondisconnect(_id_DFDBF43603E7958D);
  thread watchdeployablemarkerplacement(streakinfo, boxtype, lifeid, _id_DFDBF43603E7958D, weaponname, _id_D6421C0CADE6BA92, _id_79DA2138DECDE7FB, _id_2DEFFE8B3AF50B42);
  return 1;
}

watchdeployablemarkerplacement(streakinfo, boxtype, lifeid, marker, weaponname, _id_1BA137D944D10B5A, deathfunc, _id_57E5B541FBB5ECAA) {
  self endon("spawned_player");
  self endon("disconnect");

  if(!isDefined(marker)) {
    return;
  }
  if(!isDefined(weaponname)) {
    return;
  }
  if(!scripts\mp\utility\player::isreallyalive(self))
    marker delete();

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
  marker thread markeractivate(streakinfo, lifeid, boxtype, ::box_setactive, _id_1BA137D944D10B5A, deathfunc, _id_57E5B541FBB5ECAA);
}

cleanupdeployablemarkerondisconnect(marker) {
  marker endon("death");
  marker endon("late_missile_stuck");
  marker thread scripts\mp\utility\script::notifyafterframeend("missile_stuck", "late_missile_stuck");
  self waittill("disconnect");
  marker delete();
}

override_box_moving_platform_death(data) {
  self.isdestroyed = 1;
  self notify("death");
}

markeractivate(streakinfo, lifeid, boxtype, _id_055AA0066A9F3E9F, damagecallback, deathcallback, _id_C40683E34FE54EC7) {
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
    _id_971BF05DA97E6DB9 = data.linkparent getlinkedparent();

    if(isDefined(_id_971BF05DA97E6DB9))
      data.linkparent = _id_971BF05DA97E6DB9;
    else
      data.linkparent = undefined;
  }

  data.deathoverridecallback = ::override_box_moving_platform_death;
  box thread scripts\mp\movers::handle_moving_platforms(data);
  box.moving_platform = data.linkparent;
  box setotherent(owner);
  waitframe();
  box thread[[_id_055AA0066A9F3E9F]](damagecallback, deathcallback, _id_C40683E34FE54EC7);

  if(isDefined(level.killstreakfinishusefunc))
    level thread[[level.killstreakfinishusefunc]](streakinfo);

  self delete();

  if(isDefined(box) && box scripts\mp\utility\entity::touchingbadtrigger()) {
    self.isdestroyed = 1;
    box notify("death");
  }
}

deployableexclusion(_id_DB6BBCA31492C586) {
  if(_id_DB6BBCA31492C586 == "mp_satcom")
    return 1;
  else if(issubstr(_id_DB6BBCA31492C586, "paris_catacombs_iron"))
    return 1;
  else if(issubstr(_id_DB6BBCA31492C586, "mp_warhawk_iron_gate"))
    return 1;

  return 0;
}

isholdingdeployablebox() {
  _id_04A8F5643E919524 = self getcurrentweapon();

  if(isDefined(_id_04A8F5643E919524)) {
    foreach(_id_98770F6793C42216 in level.boxsettings) {
      if(getcompleteweaponname(_id_04A8F5643E919524) == _id_98770F6793C42216.weaponinfo)
        return 1;
    }
  }

  return 0;
}

createboxforplayer(boxtype, position, owner) {
  _id_86280FEFB94B6B28 = level.boxsettings[boxtype];
  box = spawn("script_model", position - (0, 0, 1));
  box setModel(_id_86280FEFB94B6B28.modelbase);
  box.health = 999999;
  box.maxhealth = _id_86280FEFB94B6B28.maxhealth;
  box.angles = owner.angles;
  box.boxtype = boxtype;
  box.owner = owner;
  box.team = owner.team;
  box.id = _id_86280FEFB94B6B28.id;

  if(isDefined(_id_86280FEFB94B6B28.dpadname))
    box.dpadname = _id_86280FEFB94B6B28.dpadname;

  if(isDefined(_id_86280FEFB94B6B28.maxuses))
    box.usesremaining = _id_86280FEFB94B6B28.maxuses;

  box box_setinactive();
  box thread box_handleownerdisconnect();
  box addboxtolevelarray();
  return box;
}

box_setactive(damagecallback, deathcallback, _id_C40683E34FE54EC7) {
  _id_86280FEFB94B6B28 = level.boxsettings[self.boxtype];
  self.inuse = 0;
  curobjid = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(curobjid == -1) {
    return;
  }
  scripts\mp\objidpoolmanager::objective_add_objective(curobjid, "invisible", (0, 0, 0));

  if(!isDefined(self getlinkedparent()))
    scripts\mp\objidpoolmanager::update_objective_position(curobjid, self.origin);
  else
    scripts\mp\objidpoolmanager::update_objective_onentity(curobjid, self);

  scripts\mp\objidpoolmanager::update_objective_state(curobjid, "active");
  scripts\mp\objidpoolmanager::update_objective_icon(curobjid, _id_86280FEFB94B6B28.shadername);
  scripts\mp\objidpoolmanager::update_objective_setbackground(curobjid, 1);
  self.objidfriendly = curobjid;

  if(level.teambased) {
    if(curobjid != -1)
      scripts\mp\objidpoolmanager::objective_teammask_single(curobjid, self.team);

    box_seticon(self.team, _id_86280FEFB94B6B28.streakname, _id_86280FEFB94B6B28.headiconoffset);

    foreach(player in level.players) {
      if(self.team != player.team) {
        continue;
      }
      if(isDefined(_id_86280FEFB94B6B28.canusecallback) && !player[[_id_86280FEFB94B6B28.canusecallback]](self)) {
        if(isDefined(self.boxiconid))
          scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.boxiconid, player);
      }
    }
  } else {
    if(curobjid != -1)
      scripts\mp\objidpoolmanager::objective_playermask_single(curobjid, self.owner);

    if(!isDefined(_id_86280FEFB94B6B28.canusecallback) || self.owner[[_id_86280FEFB94B6B28.canusecallback]](self))
      box_seticon(self.owner, _id_86280FEFB94B6B28.streakname, _id_86280FEFB94B6B28.headiconoffset);
  }

  self makeusable();
  self setCursorHint("HINT_NOICON");
  self setHintString(_id_86280FEFB94B6B28.hintstring);
  self setusehideprogressbar(1);
  self.isusable = 1;
  self setCanDamage(1);

  if(isDefined(damagecallback))
    self thread[[damagecallback]]();
  else
    thread box_handledamage();

  if(isDefined(deathcallback))
    self thread[[deathcallback]]();
  else
    thread box_handledeath();

  if(isDefined(_id_C40683E34FE54EC7))
    self thread[[_id_C40683E34FE54EC7]]();
  else
    thread box_timeout();

  scripts\mp\sentientpoolmanager::registersentient("Tactical_Ground", self.owner);

  if(isDefined(self.owner))
    self.owner notify("new_deployable_box", self);

  if(level.teambased) {
    foreach(player in level.participants) {
      if(istrue(_id_86280FEFB94B6B28.isteamless))
        _box_setactivehelper(player, 1, _id_86280FEFB94B6B28.canusecallback);
      else
        _box_setactivehelper(player, self.team == player.team, _id_86280FEFB94B6B28.canusecallback);

      if(!isai(player))
        thread box_playerjoinedteam(player);
    }
  } else {
    foreach(player in level.participants)
    _box_setactivehelper(player, isDefined(self.owner) && self.owner == player, _id_86280FEFB94B6B28.canusecallback);
  }

  thread box_playerconnected();
  thread box_agentconnected();

  if(isDefined(_id_86280FEFB94B6B28.ondeploycallback))
    self[[_id_86280FEFB94B6B28.ondeploycallback]](_id_86280FEFB94B6B28);
}

_box_setactivehelper(player, _id_9B99022817CB2694, _id_86AF96FE008C96EE) {
  if(_id_9B99022817CB2694) {
    if(!isDefined(_id_86AF96FE008C96EE) || player[[_id_86AF96FE008C96EE]](self))
      box_enableplayeruse(player);
    else {
      box_disableplayeruse(player);
      thread doubledip(player);
    }

    thread boxthink(player);
  } else
    box_disableplayeruse(player);
}

box_playerconnected() {
  self endon("death");

  for(;;) {
    level waittill("connected", player);
    childthread box_waittill_player_spawn_and_add_box(player);
  }
}

box_agentconnected() {
  self endon("death");

  for(;;) {
    level waittill("spawned_agent_player", agent);
    box_addboxforplayer(agent);
  }
}

box_waittill_player_spawn_and_add_box(player) {
  player waittill("spawned_player");

  if(level.teambased) {
    box_addboxforplayer(player);
    thread box_playerjoinedteam(player);
  }
}

box_playerjoinedteam(player) {
  self endon("death");
  player endon("disconnect");

  for(;;) {
    player waittill("joined_team");

    if(level.teambased)
      box_addboxforplayer(player);
  }
}

box_addboxforplayer(player) {
  if(self.team == player.team || istrue(level.boxsettings[self.boxtype].isteamless)) {
    box_enableplayeruse(player);
    thread boxthink(player);
  } else {
    box_disableplayeruse(player);

    if(isDefined(self.boxiconid))
      scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.boxiconid, player);
  }
}

box_seticon(player, streakname, _id_86C0DC18EA9CD66A) {
  _id_86280FEFB94B6B28 = level.boxsettings[self.boxtype];
  headicon = scripts\mp\utility\killstreak::getkillstreakoverheadicon(streakname);

  if(isDefined(_id_86280FEFB94B6B28.headicon))
    headicon = _id_86280FEFB94B6B28.headicon;

  if(!scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924())
    self.boxiconid = thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(player, headicon, _id_86C0DC18EA9CD66A, 1);
}

box_enableplayeruse(player) {
  if(isPlayer(player))
    self enableplayeruse(player);

  self.disabled_use_for[player getentitynumber()] = 0;
}

box_disableplayeruse(player) {
  if(isPlayer(player))
    self disableplayeruse(player);

  self.disabled_use_for[player getentitynumber()] = 1;
}

box_setinactive() {
  self makeunusable();
  self.isusable = 0;

  if(isDefined(self.objidfriendly))
    scripts\mp\objidpoolmanager::returnobjectiveid(self.objidfriendly);
}

box_handledamage() {
  _id_86280FEFB94B6B28 = level.boxsettings[self.boxtype];
  scripts\mp\damage::monitordamage(_id_86280FEFB94B6B28.maxhealth, _id_86280FEFB94B6B28.damagefeedback, ::box_handledeathdamage, ::box_modifydamage, 1);
}

box_modifydamage(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;
  _id_702BFC08FABD86CB = damage;
  _id_86280FEFB94B6B28 = level.boxsettings[self.boxtype];

  if(_id_86280FEFB94B6B28.allowmeleedamage)
    _id_702BFC08FABD86CB = scripts\mp\damage::handlemeleedamage(objweapon, type, _id_702BFC08FABD86CB);

  _id_702BFC08FABD86CB = scripts\mp\damage::handlemissiledamage(objweapon, type, _id_702BFC08FABD86CB);
  _id_702BFC08FABD86CB = scripts\mp\damage::handlegrenadedamage(objweapon, type, _id_702BFC08FABD86CB);
  _id_702BFC08FABD86CB = scripts\mp\damage::handleapdamage(objweapon, type, _id_702BFC08FABD86CB, attacker);
  return _id_702BFC08FABD86CB;
}

box_handledeathdamage(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  self.destroyedbydamage = 1;
  _id_86280FEFB94B6B28 = level.boxsettings[self.boxtype];
  _id_3737240CEFE2C793 = scripts\mp\damage::onkillstreakkilled("deployable_ammo", attacker, objweapon, type, damage, _id_86280FEFB94B6B28.scorepopup, _id_86280FEFB94B6B28.vodestroyed);

  if(_id_3737240CEFE2C793)
    attacker notify("destroyed_equipment");
}

box_handledeath() {
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }
  box_setinactive();
  removeboxfromlevelarray();
  _id_86280FEFB94B6B28 = level.boxsettings[self.boxtype];

  if(!istrue(self.destroyedbydamage)) {
    playFX(_id_86280FEFB94B6B28.deathvfx, self.origin);
    self playSound("mp_killstreak_disappear");
  } else {
    _id_3315665A78E3F5C3 = self.origin + (0, 0, _id_86280FEFB94B6B28.headiconoffset);

    if(isDefined(_id_86280FEFB94B6B28.deathdamagemax)) {
      owner = undefined;

      if(isDefined(self.owner))
        owner = self.owner;

      if(isDefined(_id_86280FEFB94B6B28.explodevfx)) {
        playFX(_id_86280FEFB94B6B28.explodevfx, self.origin);
        self playSound("c4_expl_trans");
      }

      radiusdamage(_id_3315665A78E3F5C3, _id_86280FEFB94B6B28.deathdamageradius, _id_86280FEFB94B6B28.deathdamagemax, _id_86280FEFB94B6B28.deathdamagemin, owner, "MOD_EXPLOSIVE", "support_box_mp");
      thread scripts\mp\shellshock::grenade_earthquakeatposition(self.origin, 1.0);
    }
  }

  self notify("deleting");
  self delete();
}

box_handleownerdisconnect() {
  self endon("death");
  level endon("game_ended");
  self notify("box_handleOwner");
  self endon("box_handleOwner");
  childthread box_watchownerstatus("disconnect");
  childthread box_watchownerstatus("joined_team");
  childthread box_watchownerstatus("joined_spectators");
}

box_watchownerstatus(_id_70687E0CC558A009) {
  self.owner waittill(_id_70687E0CC558A009);
  self.isdestroyed = 1;
  self notify("death");
}

boxthink(player) {
  self endon("death");
  thread boxcapturethink(player);

  if(!isDefined(player.boxes))
    player.boxes = [];

  player.boxes[player.boxes.size] = self;
  _id_86280FEFB94B6B28 = level.boxsettings[self.boxtype];

  for(;;) {
    self waittill("captured", _id_6DFB045EE2B42AAD);

    if(_id_6DFB045EE2B42AAD == player) {
      player playlocalsound(_id_86280FEFB94B6B28.onusesfx);

      if(isDefined(_id_86280FEFB94B6B28.onusecallback))
        player[[_id_86280FEFB94B6B28.onusecallback]](self);

      if(isDefined(self.owner) && player != self.owner && !scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, player))
        self.owner thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_11B17B9125E871A8", undefined, _id_86280FEFB94B6B28.usexp);

      if(isDefined(self.usesremaining)) {
        self.usesremaining--;

        if(self.usesremaining == 0) {
          box_leave();
          break;
        }
      }

      if(isDefined(_id_86280FEFB94B6B28.canuseotherboxes) && _id_86280FEFB94B6B28.canuseotherboxes) {
        foreach(box in level.deployable_box[_id_86280FEFB94B6B28.streakname]) {
          box box_disableplayeruse(player);

          if(isDefined(box.boxiconid))
            scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(box.boxiconid, player);

          box thread doubledip(player);
        }

        continue;
      }

      if(istrue(_id_86280FEFB94B6B28.canreusebox)) {
        continue;
      }
      if(isDefined(self.boxiconid))
        scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.boxiconid, player);

      box_disableplayeruse(player);
      thread doubledip(player);
    }
  }
}

doubledip(player) {
  self endon("death");
  player endon("disconnect");
  player waittill("death");

  if(level.teambased) {
    if(self.team == player.team) {
      if(isDefined(self.boxiconid))
        scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(self.boxiconid, player);

      box_enableplayeruse(player);
    }
  } else if(isDefined(self.owner) && self.owner == player) {
    if(isDefined(self.boxiconid))
      scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(self.boxiconid, player);

    box_enableplayeruse(player);
  }
}

boxcapturethink(player) {
  level endon("game_ended");

  while(isDefined(self)) {
    self waittill("trigger", _id_B25B5C45202C880C);

    if(isDefined(level.boxsettings[self.boxtype].nousekillstreak) && level.boxsettings[self.boxtype].nousekillstreak && _id_2669878CF5A1B6BC::iskillstreakweapon(player getcurrentweapon())) {
      continue;
    }
    if(_id_B25B5C45202C880C == player && useholdthink(player, level.boxsettings[self.boxtype].usetime))
      self notify("captured", player);
  }
}

isfriendlytobox(box) {
  return level.teambased && self.team == box.team;
}

box_timeout() {
  self endon("death");
  level endon("game_ended");
  _id_86280FEFB94B6B28 = level.boxsettings[self.boxtype];
  lifespan = _id_86280FEFB94B6B28.lifespan;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(lifespan);

  if(isDefined(_id_86280FEFB94B6B28.vogone))
    self.owner thread scripts\mp\utility\dialog::leaderdialogonplayer(_id_86280FEFB94B6B28.vogone);

  box_leave();
}

box_leave() {
  waitframe();
  self.isdestroyed = 1;
  self notify("death");
}

deleteonownerdeath(owner) {
  wait 0.25;
  self linkTo(owner, "tag_origin", (0, 0, 0), (0, 0, 0));
  owner waittill("death");
  box_leave();
}

box_modelteamupdater(_id_EF682A37EEF48976) {
  self endon("death");
  self hide();

  foreach(player in level.players) {
    if(player.team == _id_EF682A37EEF48976)
      self showtoplayer(player);
  }

  for(;;) {
    level waittill("joined_team");
    self hide();

    foreach(player in level.players) {
      if(player.team == _id_EF682A37EEF48976)
        self showtoplayer(player);
    }
  }
}

useholdthink(player, usetime) {
  scripts\mp\movers::script_mover_link_to_use_object(player);
  player _id_3B64EB40368C1450::set("useHold", "weapon", 0);
  player.boxparams = spawnStruct();
  player.boxparams.curprogress = 0;
  player.boxparams.inuse = 1;
  player.boxparams.userate = 0;
  player.boxparams.id = self.id;

  if(isDefined(usetime))
    player.boxparams.usetime = usetime;
  else
    player.boxparams.usetime = 3000;

  result = useholdthinkloop(player);

  if(isalive(player)) {
    player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("useHold");
    scripts\mp\movers::script_mover_unlink_from_use_object(player);
  }

  if(!isDefined(self))
    return 0;

  player.boxparams.inuse = 0;
  player.boxparams.curprogress = 0;
  return result;
}

useholdthinkloop(player) {
  config = player.boxparams;

  while(player isplayerusingbox(config)) {
    if(!player scripts\mp\movers::script_mover_use_can_link(self)) {
      player scripts\mp\gameobjects::updateuiprogress(config, 0);
      return 0;
    }

    config.curprogress = config.curprogress + level.frameduration * config.userate;

    if(isDefined(player.objectivescaler))
      config.userate = 1 * player.objectivescaler;
    else
      config.userate = 1;

    player scripts\mp\gameobjects::updateuiprogress(config, 1);

    if(config.curprogress >= config.usetime) {
      player scripts\mp\gameobjects::updateuiprogress(config, 0);
      return scripts\mp\utility\player::isreallyalive(player);
    }

    waitframe();
  }

  player scripts\mp\gameobjects::updateuiprogress(config, 0);
  return 0;
}

addboxtolevelarray() {
  level.deployable_box[self.boxtype][self getentitynumber()] = self;
}

removeboxfromlevelarray() {
  level.deployable_box[self.boxtype][self getentitynumber()] = undefined;
}

isplayerusingbox(box) {
  return !level.gameended && isDefined(box) && scripts\mp\utility\player::isreallyalive(self) && self useButtonPressed() && !self isonladder() && !self meleeButtonPressed() && box.curprogress < box.usetime && (!isDefined(self.teleporting) || !self.teleporting);
}

isgrenadedeployable(boxtype) {
  isgrenade = 0;

  switch (boxtype) {
    default:
      isgrenade = 0;
      break;
  }

  return isgrenade;
}