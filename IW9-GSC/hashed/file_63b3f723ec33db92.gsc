/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_63b3f723ec33db92.gsc
***********************************************/

_id_D634CFB1BF1B4867() {
  _id_AED74300DAF62896 = spawnStruct();
  _id_AED74300DAF62896.name = "trapper";
  _id_AED74300DAF62896._id_EC2EC5F083DF61CD = ::_id_C3D56FA7478E2954;
  _id_AED74300DAF62896._id_7232C52496C3A94A = ::_id_63A9B674F866F56B;
  _id_AED74300DAF62896._id_4EA49A8926593523 = ::_id_72D87036EF6E0417;
  _id_AED74300DAF62896._id_E68429B39C75B6EE = ::_id_FFFE7F02C6A0DC2A;
  _id_2FDEB8023287BE67::_id_469ECEAE21900C7D(_id_AED74300DAF62896, "main", 1);
  _id_2FDEB8023287BE67::_id_613E13E7416BFAA5(_id_AED74300DAF62896);
  level._effect["vfx_dmz_Wheelson_flashlight"] = loadfx("vfx/iw9/level/mp_dmz_bio_lab/vfx_dmz_wheelson_spotlight.vfx");
}

_id_C3D56FA7478E2954(_id_AED74300DAF62896) {
  _id_AED74300DAF62896._id_BFE291B401A9BF2A = [];

  if(isDefined(level.struct_class_names["script_noteworthy"]["trapper_wheelson_spawn"])) {
    node = level.struct_class_names["script_noteworthy"]["trapper_wheelson_spawn"][0];
    _id_C79916C8DF58D478 = _id_743E6C2D23E7F91F::_id_45D2E44C40437351(node, "trapper_wheelson_path_primary", "trapper_wheelson_path_secondary");
    _id_AED74300DAF62896._id_9E6EB7678F5C7FF3 = _id_C79916C8DF58D478;
  }

  if(!isDefined(level.struct_class_names["script_noteworthy"]["boss_trapper"])) {
    return;
  }
  foreach(node in level.struct_class_names["script_noteworthy"]["boss_trapper"])
  _id_AED74300DAF62896._id_BFE291B401A9BF2A[_id_AED74300DAF62896._id_BFE291B401A9BF2A.size] = node;

  level._id_EF6D0DF4AB0AA251 = getdvarint("dvar_831358870679BA5F", 5000);
  level._id_9F4B8AF2701033E6 = getdvarint("dvar_D4F2D8EAF8DABAAD", 30) * 1000;
  level._id_1B11215654175564 = int(level._id_9F4B8AF2701033E6 * 0.4);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("fusebox", ::_id_2FCAE00B9AB94909);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("wheelson_hack_point", ::_id_B141E6BB0727E356);
  _id_03A246920C9288C4::trophy_init();
  level._id_E7C5EB1E41445C13 = ::_id_1041637B8A27F662;
}

_id_29F107B09CC6178B(_id_D17C5900F5FD0FEA) {
  level endon("game_ended");

  for(;;) {
    _id_D17C5900F5FD0FEA.origin = self.origin;
    scripts\mp\objidpoolmanager::update_objective_position(_id_D17C5900F5FD0FEA.objidnum, _id_D17C5900F5FD0FEA.origin + (0, 0, 15));
    waitframe();
  }
}

_id_ECAFAE0ED671A9BF() {
  level thread _id_72D87036EF6E0417();
}

_id_FFFE7F02C6A0DC2A(loc) {
  _id_BFE291B401A9BF2A = level._id_6A4C9FBD7AA58544["trapper"]._id_BFE291B401A9BF2A;
  _id_C229D93C0BB4F8E8 = _id_BFE291B401A9BF2A[0];

  if(!isDefined(loc))
    loc = _id_C229D93C0BB4F8E8.origin;

  aitype = _id_48814951E916AF89::_id_7F1A2E2EBE0C1693("ar");
  _id_E2958F412A7425C0 = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, loc, (0, 0, 0), "absolute", "bosses", "trapperBoss", undefined, undefined, undefined, "bossArea", 0, 0, 0);

  if(!isDefined(_id_E2958F412A7425C0))
    return undefined;

  _id_BAD46437C216E22F(_id_E2958F412A7425C0);

  if(isagent(_id_E2958F412A7425C0))
    _id_D289B6DD9A3CAB90(_id_E2958F412A7425C0);

  _id_E2958F412A7425C0 _meth_8ABE5A968CC3C220("millghtgr");
  _id_E2958F412A7425C0 setclothtype("vestheavy");
  _id_E2958F412A7425C0 thread _id_EB93FEAA150234E9();
  _id_E2958F412A7425C0._id_0109D6AFBC11C5F9 = getdvarfloat("dvar_6BCE34187F373B8F", 0.6);
  thread _id_61B8B5D3B601698B();
  return _id_E2958F412A7425C0;
}

_id_D289B6DD9A3CAB90(agent) {
  self.agent = agent;
  self._id_E2958F412A7425C0 = agent;
  self._id_9329E0D3CE1D5CA8 = "trapper";
  agent._id_0566868292EE2A1B = self;
  agent.fixednode = 1;
  _id_2FDEB8023287BE67::_id_8002B09B8348902C(agent.origin, "ui_map_icon_boss_trapper");
  agent _id_2FDEB8023287BE67::_id_720C3B7ABF4BAAC8("trapper", 1, "brloot_weaponcase_sealion");
  self notify("boss_spawned");
}

_id_1041637B8A27F662(targetplayer) {
  if(getdvarint("dvar_636E99B599195BFD", 0) == 1) {
    if(isDefined(level._id_6A4C9FBD7AA58544["trapper"].instances[0].gunship))
      level._id_6A4C9FBD7AA58544["trapper"].instances[0].gunship thread _id_7B54AD8E54B32612(targetplayer, "gunship_40mm_mp");
  }
}

_id_4A1FAF9C80BC5395(loc) {
  aitype = _id_48814951E916AF89::_id_7F1A2E2EBE0C1693("ar");
  lt = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, loc, (0, 0, 0), "absolute", "bosses", "trapperBossLt", undefined, undefined, undefined, "bossArea", 0, 0, 0);
  _id_A7159F330B9B55D6(lt);
  return lt;
}

_id_BAD46437C216E22F(agent) {
  if(!isDefined(agent)) {
    return;
  }
  weapon = level.br_lootiteminfo["brloot_weapon_ar_mike4_chemist"].fullweaponobj;

  if(getdvarint("dvar_5AE0DD98C0964788", 1) == 1) {
    level._id_C932DCF448D425F1 = level.br_lootiteminfo["brloot_weapon_dm_crossbow_trapper"].fullweaponobj;
    _id_48814951E916AF89::_id_63A043D47490F90D(agent, "brloot_weapon_dm_crossbow_trapper", undefined, 1, 1);
  }

  _id_48814951E916AF89::_id_63A043D47490F90D(agent, "brloot_missile_intel", undefined, 1, 1);
  _id_48814951E916AF89::_id_63A043D47490F90D(agent, ",brloot_valuable_screwdriver_trapper", undefined, 1, 1);
  _id_A664AAD02EE98BD2 = "molotov_mp";
  grenadeammo = getdvarint("dvar_537FA443CE212A8A", 12);
  agent.baseaccuracy = 10.0;
  agent.disablepistol = 1;
  agent _id_371B4C2AB5861E62::_id_C37C4F9D687074FF("body_dmz_opforce_shadow_company_boss_trap", "head_dmz_opforce_shadow_company_boss_trap", weapon, _id_A664AAD02EE98BD2, grenadeammo, undefined, undefined, 1);
  agent scripts\cp_mp\crossbow::initcrossbowusage(weapon);
  agent thread scripts\cp_mp\crossbow::crossbowusageloop(weapon);

  if(getdvarint("dvar_2F83E02F5B876153", 1) == 1)
    _id_48814951E916AF89::_id_63A043D47490F90D(agent, "brloot_plate_carrier_3_comms", undefined, undefined, 1);
}

_id_A7159F330B9B55D6(agent) {
  if(!isDefined(agent)) {
    return;
  }
  agent._id_B582B10663B5B2A9 = 0;
  _id_48814951E916AF89::_id_63A043D47490F90D(agent, "loot_key_trapper_door", undefined, undefined, 1);
  _id_A664AAD02EE98BD2 = "molotov_mp";
  grenadeammo = getdvarint("dvar_537FA443CE212A8A", 12);
  armor = 2000;
  helmet = 5;
  agent.baseaccuracy = getdvarfloat("dvar_298D4EA8B0934E31", 1.2);
  agent _id_371B4C2AB5861E62::_id_C37C4F9D687074FF("body_mp_eastern_velikan_1_1", "head_mp_eastern_velikan_1_1", undefined, _id_A664AAD02EE98BD2, grenadeammo, armor, helmet);
}

_id_7D7110BD34F48C6D(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon) {
  _id_24FBEDBA9A7A1EF4::_id_DFFAC413ED66BCD0(einflictor, eattacker, int(idamage), idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon);
}

_id_7212355C43BCA9BD(icon) {
  self endon("death");

  for(;;) {
    waitframe();
    icon scripts\cp_mp\utility\game_utility::_id_6E148C8DA2E4DB13(self.origin);
    icon.origin = self.origin;
  }
}

_id_72D87036EF6E0417() {
  _id_0BAA08EA813E9752 = _id_2FDEB8023287BE67::_id_3BCF85FF011D31F8("trapper");

  if(!isDefined(_id_0BAA08EA813E9752)) {
    return;
  }
  _id_A942AE9112CD6BDE = scripts\engine\utility::getStructArray(_id_0BAA08EA813E9752.target, "targetname");
  _id_58C817414D96DE59 = _id_2FDEB8023287BE67::_id_2E6E2B664DFE3186("trapper");
  _id_58C817414D96DE59.nodes = [];

  foreach(node in _id_A942AE9112CD6BDE) {
    if(!isDefined(_id_58C817414D96DE59.nodes[node.script_noteworthy]))
      _id_58C817414D96DE59.nodes[node.script_noteworthy] = [];

    _id_58C817414D96DE59.nodes[node.script_noteworthy][_id_58C817414D96DE59.nodes[node.script_noteworthy].size] = node;
  }

  _id_58C817414D96DE59._id_E2958F412A7425C0 = _id_58C817414D96DE59 _id_FFFE7F02C6A0DC2A(_id_58C817414D96DE59.nodes["boss_trapper_spawn"][0].origin);

  if(!isDefined(_id_58C817414D96DE59._id_E2958F412A7425C0)) {
    return;
  }
  _id_58C817414D96DE59._id_E2958F412A7425C0 _id_5938B1C7E9CF6DDD::go_to_node_set_goal(_id_58C817414D96DE59.nodes["boss_trapper_spawn"]);
  _id_343D58EC0ED77AA9 = level._id_6A4C9FBD7AA58544["trapper"];

  if(getdvarint("dvar_636E99B599195BFD", 0) == 1) {
    _id_51C1B45046E1647C = _id_58C817414D96DE59.nodes["boss_trapper_center"][0].origin;
    level.gunship_speed["move"] = 250;
    level.gunship_speed["rotate"] = 120;
    _id_2136B63785EE0579 = spawn("script_model", _id_51C1B45046E1647C);
    _id_2136B63785EE0579 setModel("tag_origin");
    _id_2136B63785EE0579.angles = (0, 115, 0);
    _id_2136B63785EE0579 hide();
    _id_2136B63785EE0579 thread _id_42CD0B1E55C82AD5();
    _id_2136B63785EE0579 forcenetfieldhighlod(1);

    if(!isDefined(_id_2136B63785EE0579))
      return 0;

    _id_8945C22A67231E20 = randomint(360);
    _id_0234183E65CC4B94 = 11000;
    xoffset = cos(_id_8945C22A67231E20) * _id_0234183E65CC4B94;
    yoffset = sin(_id_8945C22A67231E20) * _id_0234183E65CC4B94;
    zoffset = 15000;
    _id_78AC3C5EF5263D4F = vectorNormalize((xoffset, yoffset, zoffset));
    _id_78AC3C5EF5263D4F = _id_78AC3C5EF5263D4F * zoffset;
    gunship = scripts\cp_mp\killstreaks\gunship::gunship_spawn(_id_58C817414D96DE59._id_E2958F412A7425C0, undefined, _id_8945C22A67231E20, _id_78AC3C5EF5263D4F, undefined, _id_2136B63785EE0579);
    gunship setModel("veh9_mil_air_gunship_small");
    gunship forcenetfieldhighlod(1);
    _id_58C817414D96DE59.gunship = gunship;
  }

  _id_8A28FD9DF2F03764 = _id_743E6C2D23E7F91F::_id_906E0BECC84C065B(_id_343D58EC0ED77AA9._id_9E6EB7678F5C7FF3.path[0].origin, _id_343D58EC0ED77AA9._id_9E6EB7678F5C7FF3);
  _id_8A28FD9DF2F03764.deathcallback = ::_id_C60DF1C5D56157D2;
  interact = _id_268C64DCE68C2A6F(_id_8A28FD9DF2F03764.origin);
  interact._id_8A28FD9DF2F03764 = _id_8A28FD9DF2F03764;
  _id_8A28FD9DF2F03764.interact = interact;
  _id_8A28FD9DF2F03764._id_47BDE44B1ACEC603 = "trapper";
  _id_8A28FD9DF2F03764 thread _id_29F107B09CC6178B(interact);
  _id_8A28FD9DF2F03764._id_F973D23CB4CFC1A7 = ::_id_81C3A22A29059BC5;
  _id_8A28FD9DF2F03764._id_5B07EF3C411C7013 = ::_id_EBE7083B873CFC98;
  _id_8A28FD9DF2F03764._id_0AF81370570C04CA = 8;
  _id_8A28FD9DF2F03764._id_7CFE1B189BCF3CAD = getdvarint("dvar_EABE89E8B533A4A0", 10);
  _id_8A28FD9DF2F03764._id_D04BB72230A5A308 = getdvarint("dvar_1A99D8007C05D39B", 3);
  _id_58C817414D96DE59._id_8A28FD9DF2F03764 = _id_8A28FD9DF2F03764;
  doors = [];

  foreach(doornode in _id_58C817414D96DE59.nodes["boss_trapper_stronghold_doors"]) {
    doors = scripts\cp_mp\utility\scriptable_door_utility::scriptable_door_get_in_radius(doornode.origin, 75, 75);

    foreach(door in doors) {
      door._id_783CE7DF56CE2748 = ::_id_7C4E0B436F035BCD;
      door._id_65513AD5397A67EF = "activity_key_trapper_door_hack";
    }
  }

  _id_5B98B838B32383AC = _id_58C817414D96DE59.nodes["boss_trapper_center"][0].origin;
  _id_4673B0931E86514C = "Boss_Focus_SM_Dmz";
  _id_58C817414D96DE59 scripts\cp_mp\utility\game_utility::_id_6B6B6273F8180522(_id_4673B0931E86514C, _id_5B98B838B32383AC, level._id_EF6D0DF4AB0AA251);
  _id_58C817414D96DE59 scripts\cp_mp\utility\game_utility::_id_6988310081DE7B45();
  _id_58C817414D96DE59 thread _id_2FDEB8023287BE67::_id_3C9B7EA5BE9B4602(_id_58C817414D96DE59._id_E2958F412A7425C0);

  foreach(_id_783CDC78D4C2134A in _id_58C817414D96DE59.nodes["boss_trapper_sentry"]) {
    turret = _id_60E3273DF6B5F7D1::_id_F33B0AFADF9107EB(_id_783CDC78D4C2134A, _id_58C817414D96DE59._id_E2958F412A7425C0.team);
    level._id_B08CAEEDD32CFDAF._id_A4CD5B9AE4A509F4[level._id_B08CAEEDD32CFDAF._id_A4CD5B9AE4A509F4.size] = turret;
  }

  foreach(_id_04EF140C6EA4F1EB in _id_58C817414D96DE59.nodes["boss_trapper_saferoom_trophy"])
  thread _id_03A246920C9288C4::_id_233602CC27D9FCF8(_id_04EF140C6EA4F1EB, 1, 10, 200, _id_371B4C2AB5861E62::_id_30A0D7CA3FAE40CC("merc"));

  _id_58C817414D96DE59.speakers = [];

  foreach(_id_7D2852D02216C876 in _id_58C817414D96DE59.nodes["boss_trapper_speaker"])
  _id_58C817414D96DE59.speakers[_id_58C817414D96DE59.speakers.size] = spawnscriptable("dmz_boss_trapper_speaker", _id_7D2852D02216C876.origin, _id_7D2852D02216C876.angles);

  _id_58C817414D96DE59.fusebox = [];

  foreach(fusebox in _id_58C817414D96DE59.nodes["boss_trapper_fusebox"]) {
    _id_1D544599A3F1FC42 = spawnscriptable("dmz_boss_trapper_fusebox", fusebox.origin, fusebox.angles);
    _id_1D544599A3F1FC42 setscriptablepartstate("fusebox", "disabled", 0);
    _id_58C817414D96DE59.fusebox[_id_58C817414D96DE59.fusebox.size] = _id_1D544599A3F1FC42;
  }

  foreach(_id_88A11E5FF442B1BF in _id_58C817414D96DE59.nodes["boss_trapper_saferoom_spawn"]) {
    aitype = _id_48814951E916AF89::_id_7F1A2E2EBE0C1693("riotshield", 3);
    _id_3138C7EBA9B7AA1F = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, _id_88A11E5FF442B1BF.origin, _id_88A11E5FF442B1BF.angles, "absolute", "bossMinions", "trapperBossMinions", undefined, undefined, undefined, "bossArea", 0, 0, 0);
    _id_58C817414D96DE59._id_E2958F412A7425C0 thread _id_FF2567289DD0152F(_id_3138C7EBA9B7AA1F);
  }
}

_id_42CD0B1E55C82AD5() {
  self endon("death");
  _id_25BB708A7D591131 = 10;
  _id_CC5BC42930ABBC4F = level.gunship_speed["rotate"] / 360 * _id_25BB708A7D591131;
  self rotateYaw(self.angles[2] + _id_25BB708A7D591131, _id_CC5BC42930ABBC4F, _id_CC5BC42930ABBC4F, 0);
  _id_DE1A5ABB8AC2A421 = 360 / level.gunship_speed["rotate"];
  _id_31FC5244269DAE18 = _id_DE1A5ABB8AC2A421 * 0.0174533;
  level.gunship_magnitude = _id_31FC5244269DAE18 * 9000;

  for(;;) {
    self rotateYaw(360, level.gunship_speed["rotate"]);
    wait(level.gunship_speed["rotate"]);
  }
}

_id_7B54AD8E54B32612(target, weapon) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");

  for(;;) {
    _id_04F04B15053655BA = weaponmaxammo(weapon);

    while(_id_04F04B15053655BA > 0) {
      _id_01E2777328B6B536 = target gettagorigin("j_spineupper");
      _id_A0A41BA05E16FFE6 = randomint(300) + 50;
      _id_9E5D403038E4C071 = randomint(360);
      x = _id_01E2777328B6B536[0] + _id_A0A41BA05E16FFE6 * cos(_id_9E5D403038E4C071);
      y = _id_01E2777328B6B536[1] + _id_A0A41BA05E16FFE6 * sin(_id_9E5D403038E4C071);
      z = _id_01E2777328B6B536[2];
      point = (x, y, z);
      projectile = magicbullet(makeweapon(weapon), self.origin, point, self.owner);
      _id_04F04B15053655BA--;

      if(_id_04F04B15053655BA == 0) {
        wait 1;
        _id_1AEB3C9F2E6B11B9 = 1;

        while(_id_1AEB3C9F2E6B11B9 > 0) {
          _id_1AEB3C9F2E6B11B9--;
          wait 1;
        }
      }

      wait(weaponfiretime(weapon));
    }

    return;
  }
}

_id_FF2567289DD0152F(_id_3138C7EBA9B7AA1F) {
  self endon("death");
  _id_3138C7EBA9B7AA1F waittill("death", attacker);

  if(isDefined(self))
    self.fixednode = 0;
}

_id_EB93FEAA150234E9() {
  self endon("death");
  _id_58C817414D96DE59 = level._id_6A4C9FBD7AA58544["trapper"].instances[0];

  for(;;) {
    if(istrue(_id_58C817414D96DE59.open))
      self playsoundonmovingent("dx_br_dbos_dbli_dbtp_btau");

    if(istrue(_id_58C817414D96DE59._id_63DEB9288D22C14D)) {
      return;
    }
    wait 20;
  }
}

_id_EC6C8E8C2A82999A(scriptable, player) {
  _id_58C817414D96DE59 = level._id_6A4C9FBD7AA58544["trapper"].instances[0];

  if(istrue(_id_58C817414D96DE59._id_63DEB9288D22C14D)) {
    return;
  }
  _id_58C817414D96DE59._id_63DEB9288D22C14D = 1;
}

_id_C60DF1C5D56157D2(inflictor, attacker, damage, idflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, partname) {
  if(istrue(self.destroyed))
    return;
  else
    self.destroyed = 1;

  self notify("death");
  self.health = 1;
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setCanDamage(0);
  self _meth_1CD1EE312FD03BB4(1);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("challenges", "onVehicleKilled"))
    attacker thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("challenges", "onVehicleKilled")]](self, attacker, damage, objweapon);

  scripts\cp_mp\emp_debuff::clear_emp(1);
  scripts\cp_mp\emp_debuff::allow_emp(0);
  _id_81C3A22A29059BC5();
  scripts\mp\outofbounds::clearoob(self, 1);
  scripts\mp\killstreaks\remotetank::_id_6ADD0F629E59F222();
  self.interact setscriptablepartstate("body_damage_medium", "off", 0);
  self.interact setscriptablepartstate("body_damage_heavy", "on", 0);
  self setscriptablepartstate("body_damage_heavy", "on", 0);
  self setscriptablepartstate("turret_damage", "on", 0);
  _id_0DB78384599E4B42 = anglesToForward(self gettagangles("tag_flash"));
  self setturrettargetvec(_id_0DB78384599E4B42 * 500 + (0, -800, 0));
  wait 0.4;
  self _meth_77320E794D35465A("p2p", "pause", 1);
  wait 2.6;
  self._id_E514C9B259186B05 = 0;
}

_id_2FCAE00B9AB94909(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  _id_58C817414D96DE59 = level._id_6A4C9FBD7AA58544["trapper"].instances[0];

  if(!istrue(_id_58C817414D96DE59.alerted)) {
    return;
  }
  _id_58C817414D96DE59.alerted = 0;
  _id_7D2852D02216C876 = _id_58C817414D96DE59.speakers[0];
  _id_7D2852D02216C876 setscriptablepartstate("speaker", "off");
  _id_58C817414D96DE59.fusebox[0] setscriptablepartstate("fusebox", "disabled", 0);
}

_id_7C4E0B436F035BCD(player) {
  _id_58C817414D96DE59 = level._id_6A4C9FBD7AA58544["trapper"].instances[0];

  if(istrue(_id_58C817414D96DE59.alerted) || istrue(_id_58C817414D96DE59.open)) {
    return;
  }
  _id_58C817414D96DE59.alerted = 1;
  _id_58C817414D96DE59.open = 1;
  _id_7D2852D02216C876 = _id_58C817414D96DE59.speakers[0];
  _id_7D2852D02216C876 setscriptablepartstate("speaker", "on");
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(_id_58C817414D96DE59._id_8A28FD9DF2F03764.interact.objidnum);
  _id_58C817414D96DE59._id_8A28FD9DF2F03764.interact setscriptablepartstate("wheelson_hack_point", "unusable");
  _id_58C817414D96DE59._id_8A28FD9DF2F03764.interact._id_E8BE8ABA7B9F7DF5 = 0;
  _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("boss_confirmed", player.team);
  _id_58C817414D96DE59.fusebox[0] setscriptablepartstate("fusebox", "active", 0);
  level thread _id_9483E836CD5222E2(_id_58C817414D96DE59);
  level thread _id_C16869C7D679CA38(_id_58C817414D96DE59);
}

_id_9483E836CD5222E2(_id_58C817414D96DE59) {
  wait 240;
  _id_58C817414D96DE59.alerted = 0;
  _id_58C817414D96DE59.speakers[0] setscriptablepartstate("speaker", "off");
  _id_58C817414D96DE59.fusebox[0] setscriptablepartstate("fusebox", "disabled", 0);
}

_id_C16869C7D679CA38(_id_58C817414D96DE59) {
  level endon("game_ended");
  _id_60D75D0AB3FF147C = _id_58C817414D96DE59.nodes["boss_trapper_spawn"][0].origin;
  _id_5C362DCAAA44CDF0 = [];

  for(;;) {
    if(!istrue(_id_58C817414D96DE59.alerted)) {
      return;
    }
    _id_CC976318205A7441 = scripts\common\utility::_id_98A826B6B6D0D118(_id_60D75D0AB3FF147C, 2500, undefined, 3000, 0).size;

    if(_id_CC976318205A7441 < 6) {
      _id_5C362DCAAA44CDF0 = _id_48814951E916AF89::_id_353FECD1549F5F42(_id_60D75D0AB3FF147C, 5000, undefined, 8);

      if(_id_5C362DCAAA44CDF0.size < 4) {
        _id_48814951E916AF89::_id_77ACC10C4823DD8A(6, _id_60D75D0AB3FF147C, "high", "reinforcements", "trapperReinforcements", undefined, undefined, 1);
        wait 10.0;
      }
    }

    wait 20.0;
  }
}

_id_61B8B5D3B601698B() {
  self._id_E2958F412A7425C0 waittill("death", _id_6181DE250AFA5BB6);

  if(isDefined(_id_6181DE250AFA5BB6) && isDefined(_id_6181DE250AFA5BB6.vehicletype)) {
    if(isDefined(_id_6181DE250AFA5BB6.owner))
      _id_6181DE250AFA5BB6 = _id_6181DE250AFA5BB6.owner;
  }

  if(isDefined(_id_6181DE250AFA5BB6) && isDefined(_id_6181DE250AFA5BB6.team)) {
    _id_65F58F3C394DCF9A::_id_202AE29F54B67993(_id_6181DE250AFA5BB6.team, _id_6181DE250AFA5BB6, level._id_B1149892B2595056, "mx_mp_dmz_sealion_trapper_win", 0.0, "mx_mp_dmz_sealion_trapper_win_classic");
    _id_74B5B12BB6514385 = 8.0;
    _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("boss_trapper_confirmed", _id_6181DE250AFA5BB6.team, _id_74B5B12BB6514385);
  }

  scripts\cp_mp\utility\game_utility::_id_AF5604CE591768E1();
  scripts\mp\gameobjects::releaseid();
}

_id_268C64DCE68C2A6F(pos) {
  _id_D17C5900F5FD0FEA = spawnscriptable("dmz_boss_trapper_wheelson", pos, (0, 0, 0));
  _id_D17C5900F5FD0FEA.capturetime = 5;
  _id_D17C5900F5FD0FEA.curorigin = _id_D17C5900F5FD0FEA.origin;
  _id_D17C5900F5FD0FEA.offset3d = (0, 0, 0);
  _id_D17C5900F5FD0FEA scripts\mp\gameobjects::requestid(1, 1, undefined, 1);
  objid = _id_D17C5900F5FD0FEA.objidnum;
  scripts\mp\objidpoolmanager::update_objective_setzoffset(objid, 0);
  scripts\mp\objidpoolmanager::update_objective_position(objid, _id_D17C5900F5FD0FEA.origin + (0, 0, 0));
  scripts\mp\objidpoolmanager::objective_set_play_intro(objid, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(objid, "ui_map_icon_datacenter_hack");
  scripts\mp\objidpoolmanager::update_objective_setbackground(objid, 1);
  scripts\mp\objidpoolmanager::update_objective_state(objid, "current");
  scripts\mp\objidpoolmanager::objective_show_progress(objid, 1);
  scripts\mp\objidpoolmanager::_id_A28E8535E00D34F3(objid);
  scripts\mp\objidpoolmanager::_id_17DB39BD195CC5B1(objid);
  scripts\mp\objidpoolmanager::_id_F21E9B2E78DE984B(objid, 1200, 1300);
  return _id_D17C5900F5FD0FEA;
}

_id_81C3A22A29059BC5() {
  self.interact setscriptablepartstate("wheelson_hack_point", "usable");
  scripts\mp\objidpoolmanager::_id_6AE37618BB04EA60(self.interact.objidnum);
  self.interact._id_E8BE8ABA7B9F7DF5 = 1;
}

_id_EBE7083B873CFC98() {
  if(istrue(self.destroyed)) {
    return;
  }
  scripts\mp\objidpoolmanager::_id_17DB39BD195CC5B1(self.interact.objidnum);
  self.interact setscriptablepartstate("wheelson_hack_point", "unusable");
  self.interact._id_E8BE8ABA7B9F7DF5 = 0;
}

_id_B141E6BB0727E356(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  level endon("game_ended");

  if(state == "usable") {
    instance setscriptablepartstate(part, "unusable_hacking");
    instance.teams = [player.team];
    instance thread _id_DF526E11290EA69F(player);
    wait 1.0;
  }
}

_id_DF526E11290EA69F(hacker) {
  level endon("game_ended");
  _id_C5C6ECF6F8F9C5F5 = 100;
  self.progress = 0;
  _id_90FB369A18926018 = [];
  self.hacker = hacker;
  _id_7273312620004BC3 = scripts\mp\utility\teams::getteamdata(hacker.team, "players");

  for(;;) {
    if(isalive(hacker) && hacker useButtonPressed() && distance2dsquared(self.origin, hacker.origin) < squared(_id_C5C6ECF6F8F9C5F5))
      self.progress = min(self.capturetime, self.progress + level.framedurationseconds);
    else {
      progress = 0;
      self.progress = 0;
      _id_90FB369A18926018 = _id_B682E2AD6573E9D1([], _id_90FB369A18926018, progress);
      scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, progress);
      self setscriptablepartstate("wheelson_hack_point", "usable");
      return;
    }

    progress = self.progress / self.capturetime;
    _id_90FB369A18926018 = _id_B682E2AD6573E9D1(_id_7273312620004BC3, _id_90FB369A18926018, progress);
    scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, progress);

    if(self.progress >= self.capturetime) {
      _id_FD826CED180FCBCD();
      return;
    }

    if(!istrue(self._id_8B5682BB8AAE1441))
      self._id_8B5682BB8AAE1441 = 1;

    waitframe();
  }
}

_id_B682E2AD6573E9D1(_id_78122E18403A8DC4, _id_90FB369A18926018, progress) {
  _id_5C882C8F7BB9C72A = scripts\engine\utility::array_combine(_id_78122E18403A8DC4, _id_90FB369A18926018);
  _id_F6FD7B0E73C3270C = _id_90FB369A18926018;

  foreach(player in _id_5C882C8F7BB9C72A) {
    if(!isDefined(player)) {
      continue;
    }
    if(!scripts\engine\utility::array_contains(_id_90FB369A18926018, player) && scripts\engine\utility::array_contains(_id_78122E18403A8DC4, player)) {
      if(scripts\mp\objidpoolmanager::_id_CE702E5925E31FC9(self.objidnum, player, 1, 2, &"DMZ/BOSS_TRAPPER_WHEELSON_HACK_PROGRESS")) {
        scripts\mp\objidpoolmanager::objective_pin_player(self.objidnum, player);
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(self.objidnum, player);
        _id_F6FD7B0E73C3270C = scripts\engine\utility::array_add(_id_F6FD7B0E73C3270C, player);
      }

      continue;
    }

    if(scripts\engine\utility::array_contains(_id_90FB369A18926018, player) && !scripts\engine\utility::array_contains(_id_78122E18403A8DC4, player)) {
      scripts\mp\objidpoolmanager::objective_unpin_player(self.objidnum, player);
      scripts\mp\objidpoolmanager::_id_26259BD38697B5AD(self.objidnum, player);
      _id_F6FD7B0E73C3270C = scripts\engine\utility::array_remove(_id_F6FD7B0E73C3270C, player);
    }
  }

  return _id_F6FD7B0E73C3270C;
}

_id_FD826CED180FCBCD() {
  _id_7273312620004BC3 = scripts\mp\utility\teams::getteamdata(self.hacker.team, "players");

  if(isDefined(self.hacker) && !scripts\engine\utility::array_contains(self._id_8A28FD9DF2F03764._id_1329597B4278AFE9, self.hacker.team))
    self._id_8A28FD9DF2F03764._id_1329597B4278AFE9[self._id_8A28FD9DF2F03764._id_1329597B4278AFE9.size] = self.hacker.team;

  self setscriptablepartstate("wheelson_hack_point", "hacked");
  _id_6A8EC730B2BFA844::_id_5E98EB5DE21B3A8C(self.hacker);
  _id_171F90B9C4C76D44 = undefined;

  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913())
    _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(self.hacker.origin, 1);

  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_boss_trapper_door_key_gained", _id_7273312620004BC3, _id_171F90B9C4C76D44);

  foreach(player in _id_7273312620004BC3) {
    player._id_B2FB23E638ADC7D2 = "activity_key_trapper_door_hack";
    objective_removeclientfrommask(self.objidnum, player);
    scripts\mp\objidpoolmanager::objective_unpin_player(self.objidnum, player);
    scripts\mp\objidpoolmanager::_id_26259BD38697B5AD(self.objidnum, player);
  }

  wait 15;
  _id_58C817414D96DE59 = level._id_6A4C9FBD7AA58544["trapper"].instances[0];

  if((istrue(self._id_8A28FD9DF2F03764.destroyed) || istrue(self._id_C2DA5561229D72B9.emp)) && !istrue(_id_58C817414D96DE59.open))
    self setscriptablepartstate("wheelson_hack_point", "usable");
}

_id_63A9B674F866F56B(player, showicon) {
  team = player.team;

  if(!isDefined(self._id_7D8AD21E5DFD7C94))
    self._id_7D8AD21E5DFD7C94 = [];

  if(!isDefined(self._id_E2958F412A7425C0) || !isalive(self._id_E2958F412A7425C0) || self._id_7D8AD21E5DFD7C94.size > 0 && scripts\engine\utility::array_contains(self._id_7D8AD21E5DFD7C94, team))
    return 0;

  if(!istrue(showicon) && scripts\engine\utility::array_contains(self._id_673ECECEE90D036E, team))
    return 0;

  if(istrue(showicon)) {
    scripts\mp\objidpoolmanager::objective_teammask_addtomask(self.objidnum, team);
    self._id_7D8AD21E5DFD7C94 = scripts\engine\utility::array_add(self._id_7D8AD21E5DFD7C94, team);
  }

  self._id_673ECECEE90D036E = scripts\engine\utility::array_add(self._id_673ECECEE90D036E, team);
  players = scripts\mp\utility\teams::getteamdata(team, "players");
  _id_AC4C51BF033F6323 = players;
  _id_171F90B9C4C76D44 = undefined;

  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913())
    _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(self.mapcircle.origin, 1);

  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_trapper_revealed", _id_AC4C51BF033F6323, _id_171F90B9C4C76D44);
  thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("boss_trapper_near", team);
  _id_6B9A0DBBF039DECE = 1;
  _id_65F58F3C394DCF9A::_id_5C07A5046A6DC0F4(team, player, level._id_B1149892B2595056, "mx_mp_dmz_sealion_trapper_approach", 1.0, _id_6B9A0DBBF039DECE);
  return 1;
}