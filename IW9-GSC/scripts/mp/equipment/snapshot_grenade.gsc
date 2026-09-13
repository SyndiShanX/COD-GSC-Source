/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\snapshot_grenade.gsc
*****************************************************/

snapshot_grenade_used(grenade, _id_E012E0B70D7D54FA) {
  grenade thread scripts\mp\utility\script::notifyafterframeend("death", "end_explode");
  grenade endon("end_explode");
  grenade thread _id_D69277B486F06D35();

  if(_id_E012E0B70D7D54FA)
    grenade waittill("missile_stuck", position, ent, hitloc, surfacetype, velocity);
  else {
    grenade setotherent(self);
    grenade thread scripts\mp\damage::monitordamage(19, "hitequip", ::snapshot_grenade_handle_fatal_damage, ::snapshot_grenade_handle_damage);
    scripts\cp_mp\emp_debuff::add_emp_ent(grenade);
    grenade scripts\cp_mp\emp_debuff::set_apply_emp_callback(::snapshot_grenade_empapplied);
    grenade thread snapshot_grenade_watch_cleanup();
    grenade waittill("explode", position);
  }

  thread snapshot_grenade_watch_flight(position, grenade._id_37D6F0688AEEF75D);
}

_id_D69277B486F06D35() {
  self endon("death");
  self.owner endon("disconnect");
  self endon("missile_stuck");
  self waittill("missile_water_impact", _id_850FDF3FB1C7EB84, _id_53F81081D4E7F40B, _id_71C76F81EB0C95EE);
  self._id_37D6F0688AEEF75D = 1;
}

snapshot_get_flight_dest(position, direction, ignorelist) {
  direction = (0, 0, 1);
  caststart = position + direction;
  castend = caststart + direction * 137;
  contents = physics_createcontents(["physicscontents_glass", "physicscontents_item", "physicscontents_vehicle", "physicscontents_missileclip"]);
  _id_AA517194E54F048B = physics_raycast(caststart, castend, contents, ignorelist, 0, "physicsquery_closest", 1);

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

entity_movingplatform_update() {
  self endon("death");
  self.velocity = (0, 0, 0);

  for(;;) {
    _id_79D78DD32C9EAA49 = self.origin;
    wait 0.05;
    self.velocity = 20.0 * (self.origin - _id_79D78DD32C9EAA49);
  }
}

snapshot_grenade_watch_flight(position, _id_800EE321B0D045E5) {
  grenade = scripts\mp\utility\weapon::_launchgrenade("snapshot_grenade_mp", position, (0, 0, 0), 100, 1);
  grenade scripts\cp_mp\ent_manager::registerspawn(3, ::snapshot_grenade_delete);
  grenade setotherent(self);
  grenade setscriptablepartstate("beacon", "active", 0);
  grenade setscriptablepartstate("anims", "deploy", 0);
  grenade missilehidetrail();
  grenade.owner = self;
  grenade thread scripts\mp\damage::monitordamage(19, "hitequip", ::snapshot_grenade_handle_fatal_damage, ::snapshot_grenade_handle_damage);
  scripts\cp_mp\emp_debuff::add_emp_ent(grenade);
  grenade scripts\cp_mp\emp_debuff::set_apply_emp_callback(::snapshot_grenade_empapplied);
  grenade thread snapshot_grenade_watch_cleanup();
  grenade endon("death");
  _id_B9E1097FAE6546E7 = scripts\mp\utility\weapon::_launchgrenade("snapshot_grenade_danger_mp", grenade.origin, (0, 0, 0), 100, 1);
  _id_B9E1097FAE6546E7.weapon_name = "snapshot_grenade_danger_mp";
  _id_B9E1097FAE6546E7 linkTo(grenade);

  if(isPlayer(self))
    _id_B9E1097FAE6546E7 hidefromplayer(self);

  grenade thread snapshot_grenade_cleanup_danger_icon(_id_B9E1097FAE6546E7);
  data = spawnStruct();
  data.skipdeath = 1;
  grenade thread scripts\mp\movers::handle_moving_platforms(data);
  mover = spawn("script_model", grenade.origin);
  mover.angles = grenade.angles;
  mover setModel("tag_origin");
  grenade linkTo(mover, "tag_origin", (0, 0, 0), (0, 0, 0));
  grenade thread snapshot_grenade_cleanup_mover(mover);
  waitframe();
  _id_38C153D3F115993E = undefined;

  if(istrue(grenade.touchedmovingplatform))
    grenade thread entity_movingplatform_update();

  _id_12DF9A7DEAD190E8 = (0, 0, 1);
  _id_F0706F7D15D2324D = snapshot_get_flight_dest(position, _id_12DF9A7DEAD190E8, [grenade, _id_B9E1097FAE6546E7]);
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

    if(isDefined(grenade.lastmovingplatform)) {
      _id_38C153D3F115993E = scripts\cp_mp\utility\train_utility::is_moving_platform_train(grenade.lastmovingplatform);

      if(_id_38C153D3F115993E)
        mover linkTo(grenade.lastmovingplatform);
    }

    wait 0.3;

    if(istrue(_id_38C153D3F115993E)) {
      mover unlink();
      _id_F0706F7D15D2324D = _id_F0706F7D15D2324D + grenade.velocity * _id_4F727E6FCE686050;
    }

    if(istrue(_id_800EE321B0D045E5))
      grenade setscriptablepartstate("water", "active", 0);
    else
      grenade setscriptablepartstate("dust", "active", 0);

    grenade setscriptablepartstate("anims", "idle", 0);
    mover moveTo(_id_F0706F7D15D2324D, _id_4F727E6FCE686050, _id_D9936F1AFE54DB08, _id_BAA9727310CC90C1);
    grenade childthread scripts\mp\utility\equipment::watch_flight_collision();
    grenade scripts\engine\utility::waittill_any_timeout_1(_id_4F727E6FCE686050, "collision_with_platform");
  } else {
    mover.angles = _id_24D8B9B1475996E5;
    wait 0.3;
  }

  if(istrue(_id_38C153D3F115993E))
    mover linkTo(grenade.lastmovingplatform);

  _id_AD9018138D388D77 = 0.0;
  wait(_id_AD9018138D388D77);
  grenade setscriptablepartstate("detect", "active", 0);
  grenade setscriptablepartstate("anims", "idle", 0);
  grenade setscriptablepartstate("beacon", "neutral", 0);
  wait 0.5;
  grenade snapshot_grenade_detect();
  grenade thread snapshot_grenade_destroy();
}

snapshot_grenade_detect() {
  owner = self.owner;

  if(!isDefined(owner)) {
    return;
  }
  position = self.origin;
  angles = self.angles;
  _id_7AA1FF687CFC30D1 = snapshot_grenade_createoutlinedata(owner, position);
  _id_AC93BF0580BB0A75 = physics_createcontents(["physicscontents_missileclip", "physicscontents_glass", "physicscontents_water", "physicscontents_item", "physicscontents_vehicle"]);
  _id_F835339FB0E0E6E2 = scripts\common\utility::_id_2D7FD59D039FA69B(position, 380);

  foreach(player in _id_F835339FB0E0E6E2) {
    if(!scripts\mp\utility\player::isreallyalive(player)) {
      continue;
    }
    if(!istrue(scripts\cp_mp\utility\player_utility::playersareenemies(owner, player, 1))) {
      continue;
    }
    if(0) {
      caststart = position;
      castend = player getEye();
      _id_AA517194E54F048B = physics_raycast(caststart, castend, _id_AC93BF0580BB0A75, undefined, 0, "physicsquery_closest", 1);

      if(isDefined(_id_AA517194E54F048B) && _id_AA517194E54F048B.size > 0)
        continue;
    }

    scripts\cp_mp\challenges::_id_B0F754C8A379154E("equip_snapshot_grenade", owner, undefined, 1);
    _id_6A8EC730B2BFA844::_id_5D2504919B717097(owner, player);
    snapshot_grenade_applysnapshot(player, owner, _id_7AA1FF687CFC30D1);
  }

  if(1 && isPlayer(owner))
    triggerportableradarping(position, owner, 380, 500, "specialty_snapshot_immunity");
}

snapshot_grenade_createoutlinedata(owner, position) {
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

  return _id_7AA1FF687CFC30D1;
}

snapshot_grenade_applysnapshot(victim, attacker, _id_7AA1FF687CFC30D1, duration, _id_3A0FD085FF7FB126, _id_E92F3941BB8721D5) {
  if(!isDefined(_id_3A0FD085FF7FB126))
    _id_3A0FD085FF7FB126 = 0;

  if(!isDefined(duration))
    duration = 1250;

  if(victim scripts\mp\utility\perk::_hasperk("specialty_snapshot_immunity")) {
    attacker _id_5762AC2F22202BA2::updatedamagefeedback("hittacresist");
    victim scripts\mp\perks\perks::_id_5A3FEF8CB39336B8("specialty_tac_resist");
    return 0;
  }

  attacker _id_5762AC2F22202BA2::updatedamagefeedback("");

  if(1) {
    entnum = victim getentitynumber();
    _id_7AA1FF687CFC30D1.targets[entnum] = victim;
    _id_7AA1FF687CFC30D1.endtimes[entnum] = gettime() + duration;

    if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
      victim scripts\mp\outline::hudoutline_add_channel_internal("equipment", 3, "snapshotgrenade");

    if(!isagent(attacker)) {
      if(!level.teambased || _id_3A0FD085FF7FB126)
        _id_7AA1FF687CFC30D1.outlineids[entnum] = scripts\mp\utility\outline::outlineenableforplayer(victim, attacker, "snapshotgrenade", "equipment");
      else if(_id_58BE75C518BF0D40::shouldmodesetsquads())
        _id_7AA1FF687CFC30D1.outlineids[entnum] = scripts\mp\utility\outline::outlineenableforsquad(victim, attacker.team, attacker._id_0FF97225579DE16A, "snapshotgrenade", "equipment");
      else
        _id_7AA1FF687CFC30D1.outlineids[entnum] = _id_6FD4060B24C5926C(victim, attacker.team, "snapshotgrenade", "equipment");
    } else
      _id_7AA1FF687CFC30D1.outlineids[entnum] = _id_6FD4060B24C5926C(victim, attacker.team, "snapshotgrenade", "equipment");

    if(isPlayer(victim) || isbot(victim)) {
      victim scripts\mp\utility\outline::_hudoutlineviewmodelenable("snapshotgrenade", 0);
      victim _id_6D68CFDF0836123C::_id_FA08D1D78CF5CB01();
    }

    _id_7AA1FF687CFC30D1 thread snapshot_grenade_update_outlines();

    if(!istrue(_id_E92F3941BB8721D5))
      attacker _id_74B851B7AA1EF32D::_id_693D12AA2C1C02C5(0, "snapshotTag");
  }

  if(0)
    attacker thread snapshot_grenade_create_marker(victim gettagorigin("j_spineupper"), victim.angles, victim);

  victim.lastsnapshotgrenadetime = gettime();

  if(isagent(attacker)) {
    foreach(agent in scripts\common\utility::_id_2D7FD59D039FA69B(victim.origin, 800, 0)) {
      if(!isDefined(attacker) || !isDefined(attacker.team)) {
        continue;
      }
      if(!isDefined(agent) || !isDefined(agent.team)) {
        continue;
      }
      if(agent.team != attacker.team) {
        continue;
      }
      if(isDefined(agent.fnisinstealthcombat) && istrue(agent[[agent.fnisinstealthcombat]]())) {
        agent getenemyinfo(victim);
        continue;
      }

      agent aieventlistenerevent("player_snapshotted", victim, victim.origin);
    }
  } else if(!istrue(_id_E92F3941BB8721D5)) {
    attacker scripts\mp\damage::combatrecordtacticalstat("equip_snapshot_grenade");
    attacker scripts\mp\utility\stats::incpersstat("snapshotHits", 1);
  }

  return 1;
}

snapshot_grenade_destroy() {
  self setscriptablepartstate("destroy", "active", 0);
  self setscriptablepartstate("beacon", "neutral", 0);
  self setscriptablepartstate("dust", "neutral", 0);
  self setscriptablepartstate("water", "neutral", 0);
  self setscriptablepartstate("detect", "neutral", 0);
  self setscriptablepartstate("anims", "neutral", 0);
  self missilehidetrail();
  thread snapshot_grenade_delete(0.35);
}

snapshot_grenade_delete(delay) {
  self notify("death");
  scripts\cp_mp\ent_manager::deregisterspawn();
  self endon("death");
  self.exploding = 1;
  self setCanDamage(0);

  if(isDefined(delay))
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

      if(damage >= scripts\mp\weapons::minegettwohitthreshold())
        hits = hits + 1;

      if(scripts\mp\utility\damage::isfmjdamage(objweapon, meansofdeath))
        hits = hits * 2;

      damage = hits * 19;
    }
  }

  scripts\mp\weapons::equipmenthit(self.owner, attacker, objweapon, meansofdeath);
  return damage;
}

snapshot_grenade_handle_fatal_damage(data) {
  attacker = data.attacker;

  if(isDefined(attacker) && scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker)) {
    attacker notify("destroyed_equipment");
    attacker scripts\mp\killstreaks\killstreaks::givescoreforequipment(self, data.objweapon);
  }

  thread snapshot_grenade_destroy();
}

snapshot_grenade_empapplied(data) {
  if(!isDefined(self.owner)) {
    return;
  }
  attacker = data.attacker;

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker))) {
    attacker notify("destroyed_equipment");
    attacker scripts\mp\killstreaks\killstreaks::givescoreforequipment(self);
  }

  if(isPlayer(attacker))
    attacker _id_5762AC2F22202BA2::updatedamagefeedback("");

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
  self.owner endon("death_or_disconnect");
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

      if(!isDefined(target) || !scripts\mp\utility\player::isreallyalive(target) || gettime() >= endtime) {
        scripts\mp\utility\outline::outlinedisable(outlineid, target);

        if(isDefined(target))
          target scripts\mp\utility\outline::_hudoutlineviewmodeldisable();

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
  self.owner endon("death_or_disconnect");
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
    scripts\mp\utility\outline::outlinedisable(outlineid, target);

    if(isDefined(target) && (isPlayer(target) || isbot(target)))
      target scripts\mp\utility\outline::_hudoutlineviewmodeldisable();
  }
}

_id_6FD4060B24C5926C(_id_F20913FEC7561C5F, _id_00FA3B23D51C2DC7, hudoutlineassetname, prioritygroup) {
  ignorelist = [];
  _id_49971B20AEEA513F = getdvarint("dvar_10EA538E1C6CE567", 1);

  if(istrue(_id_49971B20AEEA513F)) {
    if(scripts\mp\utility\teams::isgameplayteam(_id_00FA3B23D51C2DC7)) {
      playersvisibleto = scripts\mp\utility\teams::getteamdata(_id_00FA3B23D51C2DC7, "players");

      foreach(player in playersvisibleto) {
        if(isDefined(player) && player.sessionstate == "spectator") {
          ignorelist[ignorelist.size] = player;
          player thread _id_3C0EFADA1F34AF5D(_id_F20913FEC7561C5F);
        }
      }
    }
  }

  return scripts\mp\utility\outline::outlineenableforteam(_id_F20913FEC7561C5F, _id_00FA3B23D51C2DC7, hudoutlineassetname, prioritygroup, ignorelist);
}

_id_3C0EFADA1F34AF5D(_id_F20913FEC7561C5F) {
  self endon("disconnect");
  _id_F20913FEC7561C5F endon("disconnect");
  level endon("game_ended");
  _id_16877D5609439072 = _id_F20913FEC7561C5F getentitynumber();

  if(isPlayer(_id_F20913FEC7561C5F) && !isbot(_id_F20913FEC7561C5F))
    _id_16877D5609439072 = _id_F20913FEC7561C5F getxuid();

  self notify("force_disable_outline_" + _id_16877D5609439072);
  self endon("force_disable_outline_" + _id_16877D5609439072);
  self waittill("spawned_player");

  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
    _id_F20913FEC7561C5F scripts\mp\outline::_id_32DFA50C47325ABE(self, "equipment", 1);
  else
    _id_F20913FEC7561C5F hudoutlinedisableforclient(self);
}

snapshot_grenade_create_marker(position, angles, target) {
  marker = spawn("script_model", position);
  marker.angles = angles;

  if(isDefined(target) && 1)
    marker linkTo(target);

  marker setModel("equip_snapshot_marker_mp");
  marker setotherent(self);
  marker setscriptablepartstate("effects", "active", 0);
  marker snapshot_grenade_watch_marker_end_early(self, 3000, target, 1250);

  if(isDefined(marker))
    marker delete();
}

snapshot_grenade_watch_marker_end_early(owner, _id_5659806E75F89695, target, _id_A3ECB02A9821BCEE) {
  self endon("death");
  owner endon("death_or_disconnect");
  level endon("game_ended");
  endtime = gettime() + _id_5659806E75F89695;
  _id_0D723B21125E94BE = scripts\engine\utility::ter_op(1, gettime() + 1250, undefined);

  while(endtime > gettime()) {
    if(isDefined(_id_0D723B21125E94BE)) {
      if(_id_0D723B21125E94BE < gettime()) {
        self unlink();
        _id_0D723B21125E94BE = undefined;
      } else if(!isDefined(target)) {
        self unlink();
        _id_0D723B21125E94BE = undefined;
      } else if(!scripts\mp\utility\player::isreallyalive(target)) {
        self unlink();
        _id_0D723B21125E94BE = undefined;
      }
    }

    waitframe();
  }
}

_id_905247D1B30C84F1() {
  return 3000;
}