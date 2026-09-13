/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\equipment\cp_snapshot_grenade.gsc
********************************************************/

snapshot_grenade_used(grenade, _id_E012E0B70D7D54FA) {
  grenade thread scripts\cp\utility::notifyafterframeend("death", "end_explode");
  grenade endon("end_explode");
  grenade setotherent(self);
  grenade thread snapshot_grenade_watch_emp();
  grenade thread snapshot_grenade_watch_cleanup();

  if(istrue(_id_E012E0B70D7D54FA))
    grenade waittill("missile_stuck", position, ent, hitloc, surfacetype, velocity);
  else
    grenade waittill("explode", position);

  thread snapshot_grenade_watch_flight(position);
}

snapshot_get_flight_dest(position, direction) {
  direction = (0, 0, 1);
  caststart = position;
  castend = position + direction * 137;
  contents = physics_createcontents(["physicscontents_glass", "physicscontents_water", "physicscontents_item", "physicscontents_vehicle", "physicscontents_missileclip"]);
  _id_AA517194E54F048B = physics_raycast(caststart, castend, contents, undefined, 0, "physicsquery_closest", 1);

  if(isDefined(_id_AA517194E54F048B) && _id_AA517194E54F048B.size > 0) {
    castend = _id_AA517194E54F048B[0]["position"];

    if(1) {
      _id_64B62CB5DC1E7AF6 = vectordot(castend - caststart, direction);

      if(_id_64B62CB5DC1E7AF6 > 0) {
        if(_id_64B62CB5DC1E7AF6 >= 50)
          _id_64B62CB5DC1E7AF6 = min(_id_64B62CB5DC1E7AF6 - 25, 112);
        else
          _id_64B62CB5DC1E7AF6 = _id_64B62CB5DC1E7AF6 / 2;

        castend = caststart + direction * _id_64B62CB5DC1E7AF6;
      }
    }
  } else
    castend = caststart + direction * 112;

  return castend;
}

snapshot_grenade_watch_flight(position) {
  grenade_owner_name = self.name;
  grenade = scripts\cp\utility::_launchgrenade("snapshot_grenade_mp", position, (0, 0, 0), 100, 1);
  grenade setotherent(self);
  grenade setscriptablepartstate("beacon", "active", 0);
  grenade setscriptablepartstate("anims", "deploy", 0);
  grenade missilehidetrail();
  grenade.owner = self;
  grenade thread snapshot_grenade_watch_emp();
  grenade thread snapshot_grenade_watch_cleanup();
  grenade endon("death");
  _id_B9E1097FAE6546E7 = scripts\cp\utility::_launchgrenade("snapshot_grenade_danger_mp", grenade.origin, (0, 0, 0), 100, 1);
  _id_B9E1097FAE6546E7 linkTo(grenade);
  _id_B9E1097FAE6546E7 hidefromplayer(self);
  grenade thread snapshot_grenade_cleanup_danger_icon(_id_B9E1097FAE6546E7);
  mover = spawn("script_model", grenade.origin);
  mover.angles = grenade.angles;
  mover setModel("tag_origin");
  grenade linkTo(mover, "tag_origin", (0, 0, 0), (0, 0, 0));
  grenade thread snapshot_grenade_cleanup_mover(mover);
  _id_12DF9A7DEAD190E8 = (0, 0, 1);
  _id_F0706F7D15D2324D = snapshot_get_flight_dest(position, _id_12DF9A7DEAD190E8);
  _id_535664EB6AE73D1D = vectordot(_id_F0706F7D15D2324D - position, _id_12DF9A7DEAD190E8);
  _id_24D8B9B1475996E5 = (0, 0, 0);

  if(_id_535664EB6AE73D1D > 0) {
    _id_6D5431D1A1159A70 = _id_535664EB6AE73D1D / 112;
    _id_4F727E6FCE686050 = 0.65 * _id_6D5431D1A1159A70;
    _id_D9936F1AFE54DB08 = _id_4F727E6FCE686050 * 0.19;
    _id_BAA9727310CC90C1 = _id_4F727E6FCE686050 * 0.6;
    _id_B229534034874CEF = 0.3 * _id_6D5431D1A1159A70;
    _id_CA262DE1CD84DEF1 = _id_4F727E6FCE686050 * 0;
    _id_B34668C30F214B1C = _id_4F727E6FCE686050 * 0.35;
    mover rotateTo(_id_24D8B9B1475996E5, _id_B229534034874CEF, _id_CA262DE1CD84DEF1, _id_B34668C30F214B1C);
    wait 0.2;
    grenade setscriptablepartstate("dust", "active", 0);
    grenade setscriptablepartstate("anims", "idle", 0);
    mover moveTo(_id_F0706F7D15D2324D, _id_4F727E6FCE686050, _id_D9936F1AFE54DB08, _id_BAA9727310CC90C1);
    wait(_id_4F727E6FCE686050);
  } else {
    mover.angles = _id_24D8B9B1475996E5;
    wait 0.2;
  }

  _id_AD9018138D388D77 = 0.0;
  wait(_id_AD9018138D388D77);
  grenade setscriptablepartstate("detect", "active", 0);
  grenade setscriptablepartstate("anims", "idle", 0);
  grenade setscriptablepartstate("beacon", "neutral", 0);
  wait 0.5;
  grenade snapshot_grenade_detect();
  level notify("grenade_exploded_during_stealth", grenade, "snapshot_grenade_mp", grenade_owner_name);
  grenade thread snapshot_grenade_destroy();
}

snapshot_grenade_detect() {
  owner = self.owner;
  position = self.origin;
  angles = self.angles;
  _id_7AA1FF687CFC30D1 = undefined;

  if(1) {
    _id_7AA1FF687CFC30D1 = spawnStruct();
    _id_7AA1FF687CFC30D1.owner = owner;
    _id_7AA1FF687CFC30D1.position = position;
    _id_7AA1FF687CFC30D1.isalive = 1;
    _id_7AA1FF687CFC30D1.targets = [];
    _id_7AA1FF687CFC30D1.endtimes = [];
    _id_7AA1FF687CFC30D1.outlineids = [];
  }

  contents = physics_createcontents(["physicscontents_missileclip", "physicscontents_glass", "physicscontents_water", "physicscontents_item", "physicscontents_vehicle"]);
  _id_103F275BC910AF75 = level.characters;

  if(isDefined(level.drone_turrets))
    _id_103F275BC910AF75 = scripts\engine\utility::array_combine(_id_103F275BC910AF75, level.drone_turrets);

  foreach(player in _id_103F275BC910AF75) {
    if(!isDefined(player)) {
      continue;
    }
    if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }
    if(isPlayer(player)) {
      continue;
    }
    if(isDefined(player._id_EC7F24B7685542B0)) {
      continue;
    }
    if(istrue(player._id_BC1CA118EA17B3E6)) {
      continue;
    }
    _id_8423818ECF85A883 = player.origin - position;
    _id_457471485336C961 = lengthsquared(_id_8423818ECF85A883);

    if(_id_457471485336C961 > 1166400) {
      continue;
    }
    if(0) {
      caststart = position;
      castend = player getEye();
      _id_AA517194E54F048B = physics_raycast(caststart, castend, contents, undefined, 0, "physicsquery_closest", 1);

      if(isDefined(_id_AA517194E54F048B) && _id_AA517194E54F048B.size > 0) {
        continue;
      }
      if(1) {
        entnum = player getentitynumber();
        _id_7AA1FF687CFC30D1.targets[entnum] = player;
        _id_7AA1FF687CFC30D1.endtimes[entnum] = gettime() + 10000;
        _id_7AA1FF687CFC30D1.outlineids[entnum] = scripts\cp\cp_outline_utility::outlineenableforall(player, "snapshotgrenade", "equipment");
        player scripts\cp\cp_outline_utility::_hudoutlineviewmodelenable("snapshotgrenade", 0);
        _id_7AA1FF687CFC30D1 thread snapshot_grenade_update_outlines();
      }

      if(0)
        owner thread snapshot_grenade_create_marker(player gettagorigin("j_spineupper"), player.angles, player);

      continue;
    }

    if(1) {
      entnum = player getentitynumber();
      _id_7AA1FF687CFC30D1.targets[entnum] = player;
      _id_7AA1FF687CFC30D1.endtimes[entnum] = gettime() + 10000;
      _id_7AA1FF687CFC30D1.outlineids[entnum] = scripts\cp\cp_outline_utility::outlineenableforall(player, "snapshotgrenade", "equipment");

      if(isPlayer(player))
        player scripts\cp\cp_outline_utility::_hudoutlineviewmodelenable("snapshotgrenade", 0);

      _id_7AA1FF687CFC30D1 thread snapshot_grenade_update_outlines();
    }

    if(0)
      owner thread snapshot_grenade_create_marker(player gettagorigin("j_spineupper"), player.angles, player);
  }

  if(1)
    triggerportableradarping(position, owner, 1080, 500);
}

snapshot_grenade_destroy() {
  self setscriptablepartstate("destroy", "active", 0);
  self setscriptablepartstate("beacon", "neutral", 0);
  self setscriptablepartstate("dust", "neutral", 0);
  self setscriptablepartstate("detect", "neutral", 0);
  self setscriptablepartstate("anims", "neutral", 0);
  self missilehidetrail();
  thread snapshot_grenade_delete(0.35);
}

snapshot_grenade_delete(delay) {
  self notify("death");
  self endon("death");
  self.exploding = 1;
  self setCanDamage(0);
  wait(delay);
  self delete();
}

snapshot_grenade_handle_damage(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  meansofdeath = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;

  if(scripts\engine\utility::isbulletdamage(meansofdeath)) {
    if(isDefined(objweapon)) {
      hits = 1;
      damage = hits * 19;
    }
  }

  return damage;
}

snapshot_grenade_handle_fatal_damage(data) {
  attacker = data.attacker;

  if(isDefined(attacker) && scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker))
    attacker notify("destroyed_equipment");

  thread snapshot_grenade_destroy();
}

snapshot_grenade_watch_emp() {
  self endon("death");
  self.owner endon("disconnect");
  self waittill("emp_applied", data);
  attacker = data.attacker;

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker)))
    attacker notify("destroyed_equipment");

  thread snapshot_grenade_destroy();
}

snapshot_grenade_watch_cleanup() {
  self endon("death");
  snapshot_grenade_watch_cleanup_end_early();

  if(isDefined(self))
    thread snapshot_grenade_destroy();
}

snapshot_grenade_watch_cleanup_end_early() {
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  level endon("game_ended");

  for(;;)
    waitframe();
}

snapshot_grenade_cleanup_mover(mover) {
  mover endon("death");
  self waittill("death");
  wait 1;
  mover delete();
}

snapshot_grenade_cleanup_danger_icon(_id_B9E1097FAE6546E7) {
  _id_B9E1097FAE6546E7 endon("death");
  self waittill("death");
  _id_B9E1097FAE6546E7 delete();
}

snapshot_grenade_update_outlines() {
  self endon("death");
  self.owner endon("death");
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  level endon("game_ended");

  if(!istrue(self.isalive)) {
    return;
  }
  self notify("update");
  self endon("update");
  thread snapshot_grenade_watch_cleanup_outlines();

  while(self.targets.size > 0) {
    foreach(id, target in self.targets) {
      target = self.targets[id];
      endtime = self.endtimes[id];
      outlineid = self.outlineids[id];

      if(!isDefined(target) || !target scripts\cp_mp\utility\player_utility::_isalive() || gettime() >= endtime) {
        scripts\cp\cp_outline_utility::outlinedisable(outlineid, target);

        if(isDefined(target) && isPlayer(target))
          target scripts\cp\cp_outline_utility::_hudoutlineviewmodeldisable();

        self.targets[id] = undefined;
        self.endtimes[id] = undefined;
        self.outlineids[id] = undefined;
      }
    }

    waitframe();
  }

  thread snapshot_grenade_clear_outlines();
}

snapshot_grenade_watch_cleanup_outlines() {
  self endon("death");
  self endon("update");
  snapshot_grenade_watch_cleanup_outlines_end_early();
  thread snapshot_grenade_clear_outlines();
}

snapshot_grenade_watch_cleanup_outlines_end_early() {
  self.owner endon("death");
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  level endon("game_ended");

  for(;;)
    waitframe();
}

snapshot_grenade_clear_outlines() {
  self notify("death");
  self.isalive = 0;

  foreach(id, target in self.targets) {
    target = self.targets[id];
    outlineid = self.outlineids[id];
    scripts\cp\cp_outline_utility::outlinedisable(outlineid, target);

    if(isDefined(target) && isPlayer(target))
      target scripts\cp\cp_outline_utility::_hudoutlineviewmodeldisable();
  }
}

snapshot_grenade_create_marker(position, angles, target) {
  marker = spawn("script_model", position);
  marker.angles = angles;

  if(isDefined(target) && 1)
    marker linkTo(target);

  marker setModel("equip_snapshot_marker_mp");
  marker setotherent(self);
  marker setscriptablepartstate("effects", "active", 0);
  marker snapshot_grenade_watch_marker_end_early(self, 36000, target, 15000);

  if(isDefined(marker))
    marker delete();
}

snapshot_grenade_watch_marker_end_early(owner, _id_5659806E75F89695, target, _id_A3ECB02A9821BCEE) {
  self endon("death");
  owner endon("death");
  owner endon("disconnect");
  level endon("game_ended");
  endtime = gettime() + _id_5659806E75F89695;
  _id_0D723B21125E94BE = scripts\engine\utility::ter_op(1, gettime() + 15000, undefined);

  while(endtime > gettime()) {
    if(isDefined(_id_0D723B21125E94BE)) {
      if(_id_0D723B21125E94BE < gettime()) {
        self unlink();
        _id_0D723B21125E94BE = undefined;
      } else if(!isDefined(target)) {
        self unlink();
        _id_0D723B21125E94BE = undefined;
      } else if(!target scripts\cp_mp\utility\player_utility::_isalive()) {
        self unlink();
        _id_0D723B21125E94BE = undefined;
      }
    }

    waitframe();
  }
}