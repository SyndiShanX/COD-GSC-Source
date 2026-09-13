/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_5fe553eecb367184.gsc
***********************************************/

_id_989DBAE057EC49BE() {
  _id_6CA33D6D1362E2ED("puddletest_trig");
  wait 5;
  _id_5ED33FE490E1736E("puddletest_trig", 1);
}

_id_0C8F0FAA4477FBDE() {
  level._effect["vfx_cp_water_elec"] = loadfx("vfx/iw8_cp/elec/vfx_cp_iw8_water_elec.vfx");
  level._effect["vfx_cp_water_elec_scrn"] = loadfx("vfx/iw8_cp/raid/lava/vfx_electric_damage_screenfx.vfx");
  level._effect["vfx_cp_water_elec_entry"] = loadfx("vfx/iw8_cp/raid/lava/vfx_raid_elec_water_entry.vfx");
}

_id_6CA33D6D1362E2ED(_id_C373894993EAFB58, _id_D7AF7C73E63161C9, _id_C1A134856067DD0B) {
  level endon("game_ended");

  if(!isDefined(level._id_67D4419AB344890A))
    level._id_67D4419AB344890A = [];

  if(!isDefined(level._id_2AF2341028E52B9E))
    level._id_2AF2341028E52B9E = [];

  if(!isDefined(_id_D7AF7C73E63161C9))
    _id_D7AF7C73E63161C9 = 0;

  triggers = getEntArray(_id_C373894993EAFB58, "targetname");
  _id_C1126F25D6EF5D40 = [];
  _id_92D6A743158FF573 = scripts\engine\utility::ter_op(isDefined(_id_C1A134856067DD0B), _id_C1A134856067DD0B, triggers);

  if(isDefined(_id_C1A134856067DD0B)) {
    foreach(trig in triggers)
    trig._id_56DA88886C363207 = 1;
  }

  foreach(ref in _id_92D6A743158FF573) {
    _id_4E4B8559BF1FA1B7 = spawnStruct();
    _id_4E4B8559BF1FA1B7.origin = ref.origin;
    _id_4E4B8559BF1FA1B7.angles = (0, 0, 0);
    ref.vfx = _id_4E4B8559BF1FA1B7;
    _id_C1126F25D6EF5D40[_id_C1126F25D6EF5D40.size] = _id_4E4B8559BF1FA1B7;
  }

  level._id_2AF2341028E52B9E[_id_C373894993EAFB58] = triggers;
  level._id_67D4419AB344890A[_id_C373894993EAFB58] = _id_C1126F25D6EF5D40;
  thread _id_2A1CDEE143451D23(_id_C373894993EAFB58);

  if(istrue(_id_D7AF7C73E63161C9)) {
    level waittill(_id_C373894993EAFB58 + "_puddle_vfx_initted");
    waitframe();
    _id_5ED33FE490E1736E(_id_C373894993EAFB58);
  }
}

_id_E570E7FCB1B057D5(_id_C373894993EAFB58) {
  if(isDefined(level._id_2AF2341028E52B9E) && isDefined(level._id_2AF2341028E52B9E[_id_C373894993EAFB58])) {
    foreach(_id_A451C7030C207AF3 in level._id_2AF2341028E52B9E[_id_C373894993EAFB58])
    _id_A451C7030C207AF3 delete();

    level._id_2AF2341028E52B9E[_id_C373894993EAFB58] = undefined;
  }

  if(isDefined(level._id_67D4419AB344890A) && isDefined(level._id_67D4419AB344890A[_id_C373894993EAFB58])) {
    foreach(fx in level._id_67D4419AB344890A[_id_C373894993EAFB58])
    fx.effect delete();

    level._id_2AF2341028E52B9E[_id_C373894993EAFB58] = undefined;
  }
}

_id_2A1CDEE143451D23(area) {
  foreach(fx in level._id_67D4419AB344890A[area]) {
    fx.effect = spawnfx(level._effect["vfx_cp_water_elec_entry"], fx.origin, (0, randomintrange(1, 360), 0), anglestoup(fx.angles));
    waitframe();
  }

  level notify(area + "_puddle_vfx_initted");
}

_id_9651791B8BB21CBA(area, _id_9ADAD22FB0B39936) {
  level endon("game_ended");
  level endon("stop_electricity_in_" + area);

  for(;;) {
    foreach(_id_A98E2562F9322CAF in _id_9ADAD22FB0B39936)
    wait 0.25;

    wait 0.05;
  }
}

_id_5ED33FE490E1736E(area, _id_33F1EFFBAAEB772F) {
  _id_3D2B99F26B9360F3 = level._id_2AF2341028E52B9E[area];
  _id_8EADA13C6F0B01EB = [];

  if(!isDefined(_id_33F1EFFBAAEB772F))
    _id_8EADA13C6F0B01EB = _id_3D2B99F26B9360F3;
  else {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_33F1EFFBAAEB772F; _id_AC0E594AC96AA3A8++) {
      _id_E955E91C2BA734F4 = scripts\engine\utility::random(_id_3D2B99F26B9360F3);
      _id_3D2B99F26B9360F3 = scripts\engine\utility::array_remove(_id_3D2B99F26B9360F3, _id_E955E91C2BA734F4);
      _id_8EADA13C6F0B01EB[_id_8EADA13C6F0B01EB.size] = _id_E955E91C2BA734F4;
    }
  }

  foreach(trig in _id_8EADA13C6F0B01EB) {
    if(istrue(trig._id_56DA88886C363207)) {
      _id_87C0E3C26CEACAE8 = level._id_67D4419AB344890A[area];

      foreach(vfx in _id_87C0E3C26CEACAE8) {
        triggerfx(vfx.effect);

        if(!isDefined(vfx._id_4CF58793CC4F1AD6))
          vfx._id_4CF58793CC4F1AD6 = spawn("script_origin", vfx.origin + (0, 0, 20));

        level thread _id_82C7DF3B0CC7FC5F(vfx._id_4CF58793CC4F1AD6);
      }
    } else {
      if(isDefined(trig.script_flag))
        scripts\engine\utility::exploder(trig.script_flag);

      trig._id_DBE4316E115900D3 = createnavbadplacebyent(trig);

      if(!isDefined(trig._id_4CF58793CC4F1AD6))
        trig._id_4CF58793CC4F1AD6 = spawn("script_origin", trig.origin + (0, 0, 20));

      level thread _id_82C7DF3B0CC7FC5F(trig._id_4CF58793CC4F1AD6);
    }

    trig thread _id_A7F83006EF7FD7B8(area);
  }
}

_id_82C7DF3B0CC7FC5F(_id_9D0652EB5C9BC72B) {
  level endon("game_ended");
  _id_9D0652EB5C9BC72B endon("death");

  while(isDefined(_id_9D0652EB5C9BC72B)) {
    if(soundexists("emt_raid_bubbling_electricity_lp"))
      _id_9D0652EB5C9BC72B playLoopSound("emt_raid_bubbling_electricity_lp");

    wait 5;
  }
}

_id_D1DDBE614C354C9F(area) {
  foreach(fx in level._id_67D4419AB344890A[area])
  fx.effect delete();

  _id_3D2B99F26B9360F3 = level._id_2AF2341028E52B9E[area];

  foreach(trig in _id_3D2B99F26B9360F3) {
    if(isDefined(trig.script_flag))
      scripts\engine\utility::stop_exploder(trig.script_flag);

    if(isDefined(trig._id_DBE4316E115900D3))
      destroynavobstacle(trig._id_DBE4316E115900D3);

    if(isDefined(trig._id_4CF58793CC4F1AD6)) {
      trig._id_4CF58793CC4F1AD6 stoploopsound("emt_raid_bubbling_electricity_lp");
      trig._id_4CF58793CC4F1AD6 delete();
    }
  }

  level notify("stop_electricity_in_" + area);
  _id_2A1CDEE143451D23(area);
}

_id_A7F83006EF7FD7B8(area) {
  level endon("stop_electricity_in_" + area);

  for(;;) {
    self waittill("trigger", ent);

    if(isPlayer(ent)) {
      thread _id_6D8CBAB68D23E670(ent, self);
      thread _id_3034E35EE218B205(ent);
    }
  }
}

_id_6D8CBAB68D23E670(player, trigger) {
  level endon("game_ended");

  if(!istrue(player._id_14EF2878291D78B9)) {
    player._id_14EF2878291D78B9 = 1;
    trigger.armor_piercing = 1;
    player dodamage(15, player.origin, trigger);
    thread _id_37257C344663C658::_id_C927FD013FC6E502(player);
    wait 0.5;
    player._id_14EF2878291D78B9 = 0;
    player._id_12BFB031C0A0EFD8 = 0;
    _id_FCEF8D217A441961 = !isalive(player) || istrue(player.inlaststand);
    player thread _id_37257C344663C658::_id_6C0A9D95EBB14F2A(0);

    if(istrue(_id_FCEF8D217A441961))
      thread _id_07B63C60FAE92999(player, trigger);
  }
}

_id_3034E35EE218B205(player) {
  level endon("game_ended");

  if(!istrue(player._id_B7DB5CCD69188E24)) {
    player._id_B7DB5CCD69188E24 = 1;
    playfxontagforclients(level._effect["vfx_cp_water_elec_scrn"], player, "tag_origin", player);
    fx = spawnfx(level._effect["vfx_cp_water_elec"], player.origin);
    triggerfx(fx);
    wait 2;
    fx delete();
    stopfxontagforclients(level._effect["vfx_cp_water_elec_scrn"], player, "tag_origin", player);
    wait 0.5;
    player._id_B7DB5CCD69188E24 = undefined;
  }
}

_id_07B63C60FAE92999(player, trigger) {
  level endon("game_ended");
  player endon("disconnect");
  player notify("single_watch_for_player_bleeding_out_in_puddle");
  player endon("single_watch_for_player_bleeding_out_in_puddle");

  while(!isDefined(player.dogtag) && istrue(player.inlaststand))
    wait 1;

  if(isDefined(trigger.target) && isDefined(player.dogtag)) {
    destination = scripts\engine\utility::getStruct(trigger.target, "targetname");

    if(isDefined(destination) && distance2d(player.dogtag.origin, trigger.origin) < trigger.struct.radius) {
      player.dogtag.origin = destination.origin;
      player.respawn_forcespawnorigin = destination.origin + (0, 0, 5);
    }
  }
}