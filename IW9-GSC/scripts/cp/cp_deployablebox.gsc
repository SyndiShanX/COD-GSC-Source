/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_deployablebox.gsc
***********************************************/

init() {
  level.deployable_box_interaction = ::init_box_interaction;

  if(!isDefined(level.boxsettings))
    level.boxsettings = [];

  level thread scripts\cp\cp_ammo_crate::ammo_crate_init();
  level thread scripts\cp\cp_grenade_crate::grenade_crate_init();
  level thread scripts\cp\cp_armor_crate::armor_crate_init();
  level thread _id_65EC25DA122EFE3C::_id_6444DD7186B01CFC();
  level thread scripts\cp\cp_adrenaline_crate::adrenaline_crate_init();
}

init_box_interaction() {
  _id_71332A5B74214116::register_interaction("deployable_box", "null", undefined, ::box_hint_func, ::box_activate_func, 0, 0, undefined);
}

box_hint_func(_id_DF071553D0996FF9, player) {
  _id_86280FEFB94B6B28 = level.boxsettings[_id_DF071553D0996FF9.box.boxtype];
  return _id_86280FEFB94B6B28.hintstring;
}

box_activate_func(_id_DF071553D0996FF9, player) {
  _id_DF071553D0996FF9.box notify("captured", player);
}

box_createinteraction(box) {
  interaction = spawnStruct();
  interaction.origin = box.origin;
  interaction.targetname = "interaction";
  interaction.script_noteworthy = "deployable_box";
  interaction.requires_power = 0;
  interaction.box = box;
  interaction.spend_type = "null";
  interaction.cost = 0;
  _id_71332A5B74214116::add_to_current_interaction_list(interaction);
  box.interaction = interaction;
  return box;
}

begindeployableviamarker(lifeid, boxtype, _id_DFDBF43603E7958D, weaponname, _id_D6421C0CADE6BA92, _id_79DA2138DECDE7FB, _id_2DEFFE8B3AF50B42) {
  thread watchdeployablemarkerplacement(boxtype, lifeid, _id_DFDBF43603E7958D, weaponname, _id_D6421C0CADE6BA92, _id_79DA2138DECDE7FB, _id_2DEFFE8B3AF50B42);
  return 1;
}

watchdeployablemarkerplacement(boxtype, lifeid, marker, weaponname, _id_1BA137D944D10B5A, deathfunc, _id_57E5B541FBB5ECAA) {
  self endon("spawned_player");
  self endon("disconnect");

  if(!isDefined(marker)) {
    return;
  }
  if(!isDefined(weaponname)) {
    return;
  }
  marker makecollidewithitemclip(1);
  self notify("deployable_deployed");
  _id_F7B6CC6C062A7A43 = "cp_used_" + boxtype;
  streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo(_id_F7B6CC6C062A7A43, self);
  scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(streakinfo);

  foreach(player in level.players)
  player thread scripts\cp\cp_hud_message::showsplash(_id_F7B6CC6C062A7A43, undefined, self);

  marker.owner = self;
  marker.weaponname = weaponname;
  self.marker = marker;
  _id_929E81472980EC28 = scripts\cp\utility::getweapontoswitchbackto();
  success = thread scripts\cp\cp_weapons::switchtoweaponreliable(_id_929E81472980EC28, 0);
  self.last_weapon = undefined;

  if(isgrenadedeployable(boxtype)) {
    self thread[[level.boxsettings[boxtype].grenadeusefunc]](marker);
    return;
  }

  marker thread markeractivate(lifeid, boxtype, ::box_setactive, _id_1BA137D944D10B5A, deathfunc, _id_57E5B541FBB5ECAA);
}

override_box_moving_platform_death(data) {
  self notify("death");
}

marker_watchdisownedtimeout() {
  self endon("death");
  marker_watchdisownedtimeoutinternal();

  if(isDefined(self) && !istrue(self.isdestroyed))
    thread supportbox_destroy();
}

marker_watchdisownedtimeoutinternal() {
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  level endon("game_ended");
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(5);
}

markeractivate(lifeid, boxtype, _id_055AA0066A9F3E9F, damagecallback, deathcallback, _id_C40683E34FE54EC7) {
  self notify("markerActivate");
  self endon("markerActivate");
  result = scripts\engine\utility::waittill_any_return_3("missile_stuck", "explode", "death");
  owner = self.owner;
  position = self.origin;
  _id_86280FEFB94B6B28 = level.boxsettings[boxtype];
  box = undefined;

  if(result == "explode")
    box = createboxforplayer(boxtype, scripts\engine\utility::drop_to_ground(position, 1000), owner);
  else if(result == "death")
    box = createboxforplayer(boxtype, scripts\engine\utility::drop_to_ground(position, 1000), owner);
  else
    box = self;

  box setscriptablepartstate("effects", "plant", 0);
  box setscriptablepartstate("anims", "closedIdle", 0);
  box setscriptablepartstate("beacon", "active", 0);
  box.health = 999999;
  box.maxhealth = _id_86280FEFB94B6B28.maxhealth;
  box.angles = self.angles;
  box.boxtype = boxtype;
  box.owner = owner;
  box.team = owner.team;
  box.id = _id_86280FEFB94B6B28.id;

  if(isDefined(_id_86280FEFB94B6B28.dpadname))
    box.dpadname = _id_86280FEFB94B6B28.dpadname;

  if(isDefined(_id_86280FEFB94B6B28.maxuses))
    box.usesremaining = _id_86280FEFB94B6B28.maxuses;

  box.owner.supportbox = box;
  box thread box_handleownerdisconnect();
  box addboxtoownerarray(box.owner);
  box supportbox_addowneroutline();
  box[[_id_055AA0066A9F3E9F]](box, damagecallback, deathcallback, _id_C40683E34FE54EC7);
  _id_DE062DAE32F4B236 = level.crafting_table_data[boxtype].metal;
  _id_C317862B1CC1D7DF = 0;

  if(owner scripts\cp\cp_persistence::try_take_player_currency(_id_DE062DAE32F4B236))
    return;
}

supportbox_destroy() {
  self setscriptablepartstate("effects", "destroy", 0);
  self setscriptablepartstate("beacon", "neutral", 0);
  thread supportbox_delete(3);
}

supportbox_delete(_id_CBF7BE4F62A0DDB2) {
  self notify("death");
  self.isdestroyed = 1;
  self setCanDamage(0);
  supportbox_removeobjectiveicon();
  supportbox_removeowneroutline();
}

supportbox_addowneroutline() {
  if(1) {
    if(isDefined(self.owner))
      self.outlineid = scripts\cp\cp_outline_utility::outlineenableforplayer(self, self.owner, "outline_depth_white", "killstreak_personal");
  }
}

supportbox_removeowneroutline() {
  if(isDefined(self.outlineid))
    scripts\cp\cp_outline_utility::outlinedisable(self.outlineid, self);
}

supportbox_addobjectiveicon() {
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

supportbox_removeobjectiveicon() {
  if(isDefined(self.objectiveiconid))
    scripts\mp\objidpoolmanager::returnobjectiveid(self.objectiveiconid);
}

createboxforplayer(boxtype, position, owner) {
  _id_86280FEFB94B6B28 = level.boxsettings[boxtype];
  box = spawn("script_model", position - (0, 0, 1));
  box setModel(_id_86280FEFB94B6B28.modelbase);
  box.health = 999999;
  box.maxhealth = _id_86280FEFB94B6B28.maxhealth;
  box.angles = self.angles;
  box.boxtype = boxtype;
  box.owner = owner;
  box.team = owner.team;
  box.id = _id_86280FEFB94B6B28.id;
  return box;
}

box_setactive(box, damagecallback, deathcallback, _id_C40683E34FE54EC7) {
  _id_86280FEFB94B6B28 = level.boxsettings[self.boxtype];
  self.inuse = 0;

  if(isDefined(self.owner)) {
    self.owner thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_DECD39D6AECA5C6C");
    self.owner notify("munitions_used", box.boxtype);
    self.owner thread scripts\cp\cp_player_battlechatter::onmunitionboxused(self.boxtype);
  }

  if(isDefined(_id_86280FEFB94B6B28.deployfunc))
    self.owner thread[[_id_86280FEFB94B6B28.deployfunc]]();

  if(!isDefined(_id_86280FEFB94B6B28.canusecallback) || self.owner[[_id_86280FEFB94B6B28.canusecallback]](self))
    box_seticon(self.owner, _id_86280FEFB94B6B28.streakname, _id_86280FEFB94B6B28.headiconoffset);

  box = box_createinteraction(box);

  if(isDefined(damagecallback))
    self thread[[damagecallback]]();
  else
    thread box_handledamage();

  thread box_handledeath();

  if(isDefined(_id_C40683E34FE54EC7))
    self thread[[_id_C40683E34FE54EC7]]();
  else
    thread box_timeout();

  thread box_playerconnected();
  thread box_agentconnected();
  thread boxthink();
}

_box_setactivehelper(player, _id_9B99022817CB2694, _id_86AF96FE008C96EE) {
  if(_id_9B99022817CB2694) {
    if(!isDefined(_id_86AF96FE008C96EE) || player[[_id_86AF96FE008C96EE]](self))
      box_enableplayeruse(player);
    else {}

    thread boxthink();
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
  if(self.team == player.team) {
    box_enableplayeruse(player);
    thread boxthink();
    box_seticon(player, level.boxsettings[self.boxtype].streakname, level.boxsettings[self.boxtype].headiconoffset);
  } else
    box_disableplayeruse(player);
}

box_seticon(player, streakname, _id_86C0DC18EA9CD66A) {
  _id_86280FEFB94B6B28 = level.boxsettings[self.boxtype];
  headicon = undefined;

  if(isDefined(_id_86280FEFB94B6B28.headicon))
    headicon = _id_86280FEFB94B6B28.headicon;

  self.boxiconid = thread scripts\cp\utility::ent_createheadicon(self, _id_86C0DC18EA9CD66A, self.team, headicon, 0);
}

box_enableplayeruse(player) {
  self.disabled_use_for[player getentitynumber()] = 0;
}

box_disableplayeruse(player) {
  self.disabled_use_for[player getentitynumber()] = 1;
}

box_setinactive() {}

box_handledamage() {
  _id_86280FEFB94B6B28 = level.boxsettings[self.boxtype];
}

box_modifydamage(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;
  _id_702BFC08FABD86CB = damage;
  _id_86280FEFB94B6B28 = level.boxsettings[self.boxtype];
  return _id_702BFC08FABD86CB;
}

box_handledeathdamage(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  _id_86280FEFB94B6B28 = level.boxsettings[self.boxtype];
  attacker notify("destroyed_equipment");
}

box_handledeath() {
  self waittill("death");
  _id_71332A5B74214116::remove_from_current_interaction_list(self.interaction);

  foreach(player in level.players)
  player _id_71332A5B74214116::refresh_interaction();

  box_setinactive();
  removeboxfromownerarray(self.owner);

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self.owner))
    self.owner.supportbox = undefined;

  if(isDefined(self.boxiconid) && self.boxiconid != -1)
    thread scripts\cp\utility::ent_deleteheadicon(self, self.boxiconid);

  _id_86280FEFB94B6B28 = level.boxsettings[self.boxtype];
  forward = anglesToForward(self.angles);
  up = anglestoup(self.angles);
  playFX(_id_86280FEFB94B6B28.deathvfx, self.origin, forward, up);
  self playSound("mp_equip_destroyed");
  self notify("deleting");
  self delete();
}

box_handleownerdisconnect() {
  self endon("death");
  level endon("game_ended");
  self notify("box_handleOwner");
  self endon("box_handleOwner");
  self.owner scripts\engine\utility::waittill_any_2("killstreak_disowned", "disconnect");
  self notify("death");
}

boxthink() {
  _id_86280FEFB94B6B28 = level.boxsettings[self.boxtype];

  for(;;) {
    self waittill("captured", _id_6DFB045EE2B42AAD);

    if(isPlayer(_id_6DFB045EE2B42AAD) && _id_6DFB045EE2B42AAD.team == self.owner.team) {
      success = 1;

      if(isDefined(_id_86280FEFB94B6B28.onusecallback))
        success = _id_6DFB045EE2B42AAD[[_id_86280FEFB94B6B28.onusecallback]](self);

      if(istrue(success)) {
        thread playboxuseanimation();
        _id_6DFB045EE2B42AAD scripts\cp\utility::playerplaypickupanim("iw9_ges_pickup");

        if(isDefined(self.owner) && _id_6DFB045EE2B42AAD != self.owner) {
          self.owner thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_DECD39D6AECA5C6C");

          if(isDefined(_id_86280FEFB94B6B28.onusethanksbc))
            level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(_id_6DFB045EE2B42AAD, _id_86280FEFB94B6B28.onusethanksbc);
        }

        if(isDefined(self.usesremaining)) {
          self.usesremaining--;

          if(self.usesremaining == 0) {
            box_leave();
            break;
          }
        }

        if(isDefined(_id_86280FEFB94B6B28.canuseotherboxes) && _id_86280FEFB94B6B28.canuseotherboxes) {
          foreach(box in level.deployable_box[_id_86280FEFB94B6B28.streakname]) {
            box box_disableplayeruse(self);
            box thread doubledip(self);
          }

          continue;
        }

        if(istrue(_id_86280FEFB94B6B28.canreusebox))
          continue;
      }
    }
  }
}

playboxuseanimation() {
  self endon("death");
  self notify("playerboxUseAnimation");
  self endon("playerboxUseAnimation");
  self setscriptablepartstate("anims", "open", 0);
  wait(supportbox_getdeployanimduration());
  self setscriptablepartstate("anims", "close", 0);
  wait(supportbox_getcloseanimduration());
  self setscriptablepartstate("anims", "closedIdle", 0);
}

doubledip(player) {
  self endon("death");
  player endon("disconnect");
  player waittill("death");

  if(level.teambased) {
    if(self.team == player.team) {
      box_seticon(player, level.boxsettings[self.boxtype].streakname, level.boxsettings[self.boxtype].headiconoffset);
      box_enableplayeruse(player);
    }
  } else if(isDefined(self.owner) && self.owner == player) {
    box_seticon(player, level.boxsettings[self.boxtype].streakname, level.boxsettings[self.boxtype].headiconoffset);
    box_enableplayeruse(player);
  }
}

boxcapturethink(player) {
  level endon("game_ended");

  while(isDefined(self)) {
    self waittill("trigger", _id_B25B5C45202C880C);

    if(_id_B25B5C45202C880C == player)
      self notify("captured", _id_B25B5C45202C880C);
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
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(lifespan);
  box_leave();
}

box_leave() {
  waitframe();
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
  player _id_3B64EB40368C1450::set("use_hold", "weapon", 0);
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

  if(isalive(player))
    player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("use_hold");

  if(!isDefined(self))
    return 0;

  player.boxparams.inuse = 0;
  player.boxparams.curprogress = 0;
  return result;
}

useholdthinkloop(player) {
  config = player.boxparams;

  while(player isplayerusingbox(config)) {
    config.curprogress = config.curprogress + level.frameduration * config.userate;

    if(isDefined(player.objectivescaler))
      config.userate = 1 * player.objectivescaler;
    else
      config.userate = 1;

    if(config.curprogress >= config.usetime)
      return player scripts\cp_mp\utility\player_utility::_isalive();

    waitframe();
  }

  return 0;
}

addboxtoownerarray(owner) {
  if(!isDefined(owner.deployable_box))
    owner.deployable_box = [];

  if(!isDefined(owner.deployable_box[self.boxtype]))
    owner.deployable_box[self.boxtype] = [];

  if(owner.deployable_box[self.boxtype].size >= 2) {
    _id_4573A8725DD3748E = 1 + owner.deployable_box[self.boxtype].size - 3;

    foreach(box in owner.deployable_box[self.boxtype]) {
      if(_id_4573A8725DD3748E > 0) {
        box thread supportbox_destroy();
        _id_4573A8725DD3748E--;
      }
    }
  }

  owner.deployable_box[self.boxtype][self getentitynumber()] = self;
}

removeboxfromownerarray(owner) {
  if(isDefined(owner))
    owner.deployable_box[self.boxtype][self getentitynumber()] = undefined;
}

addboxtolevelarray() {
  if(isDefined(level.deployable_box[self.boxtype]) && level.deployable_box[self.boxtype].size > 0) {
    foreach(box in level.deployable_box[self.boxtype])
    box thread supportbox_destroy();
  }

  level.deployable_box[self.boxtype][self getentitynumber()] = self;
}

removeboxfromlevelarray() {
  level.deployable_box[self.boxtype][self getentitynumber()] = undefined;
}

isplayerusingbox(box) {
  return !level.gameended && isDefined(box) && scripts\cp_mp\utility\player_utility::_isalive() && self useButtonPressed() && !self isonladder() && !self meleeButtonPressed() && box.curprogress < box.usetime && (!isDefined(self.teleporting) || !self.teleporting);
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

supportbox_ondeploy(_id_86280FEFB94B6B28) {
  parent = self getlinkedparent();
  self unlink();
  self.angles = combineangles(self.angles, (0, 90, 0));
  self.origin = self.origin + anglestoup(self.angles) * 3;

  if(isDefined(parent))
    self linkTo(parent);

  thread supportbox_ondeployinternal(_id_86280FEFB94B6B28);
}

supportbox_ondeployinternal(_id_86280FEFB94B6B28) {
  self endon("death");
  self setscriptablepartstate("anims", "open", 0);
  self setscriptablepartstate("effects", "plant", 0);
  wait(_id_86280FEFB94B6B28.deployanimduration);
}

#using_animtree("scriptables");

supportbox_getdeployanimduration() {
  return getanimlength(%wm_supportbox_ground_open);
}

supportbox_getcloseanimduration() {
  return getanimlength(%wm_supportbox_ground_close);
}