/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_756383447909cfaf.gsc
***********************************************/

_id_4A755326CD53D3B3() {
  _id_AED74300DAF62896 = spawnStruct();
  _id_AED74300DAF62896.armor = getdvarfloat("dvar_60A6F859CC67B71B", 5000);
  _id_AED74300DAF62896.maxdamage = getdvarint("dvar_C35DE7777481DF06", 100);
  _id_AED74300DAF62896._id_BFE291B401A9BF2A = [];
  _id_AED74300DAF62896.name = "pyro";
  _id_AED74300DAF62896._id_649245B52DBF88A9 = getdvarint("dvar_F454D60A0AC05167", 2);
  _id_AED74300DAF62896._id_EC2EC5F083DF61CD = ::_id_9A5C6E540A2F3340;
  _id_AED74300DAF62896._id_E68429B39C75B6EE = ::_id_4108074415ABC816;
  level.br_lootiteminfo["brloot_weapon_sh_vecho_lege"] = spawnStruct();
  level.br_lootiteminfo["brloot_weapon_sh_vecho_lege"].baseweapon = "iw9_sh_vecho";
  level.br_lootiteminfo["brloot_weapon_sh_vecho_lege"].fullweaponname = "iw9_sh_vecho_mp+ammo_12g_db_vecho+bar_sh_hvyshort_p04+bolt_p04+drum_sh_p04+ironsdefault_vecho+lasercyl_hip03+pgrip_p04_vecho+rec_vecho+stock_sh_tactical_p04_vecho";
  level.br_lootiteminfo["brloot_weapon_sh_vecho_lege"].fullweaponobj = makeweaponfromstring(level.br_lootiteminfo["brloot_weapon_sh_vecho_lege"].fullweaponname);
  _id_613E13E7416BFAA5(_id_AED74300DAF62896);
  level._id_02A75E2A44DA2072 = 1;
}

_id_613E13E7416BFAA5(_id_B99F2F7D93950BAC) {
  if(!isDefined(level._id_6A4C9FBD7AA58544))
    level._id_6A4C9FBD7AA58544 = [];

  level._id_6A4C9FBD7AA58544[_id_B99F2F7D93950BAC.name] = _id_B99F2F7D93950BAC;
  level._id_6A4C9FBD7AA58544[_id_B99F2F7D93950BAC.name].instances = [];
}

_id_2E6E2B664DFE3186(name) {
  instance = spawnStruct();
  instance._id_7D8AD21E5DFD7C94 = [];
  instance._id_673ECECEE90D036E = [];
  instance.name = name;
  level._id_6A4C9FBD7AA58544[name].instances[level._id_6A4C9FBD7AA58544[name].instances.size] = instance;
  return instance;
}

_id_9A5C6E540A2F3340(_id_AED74300DAF62896) {
  level._id_C8C9FE6038E69B34 = getdvarint("dvar_6968AB4B0D874C4D", 30) * 1000;
  level._id_AD758BDA532F9152 = int(level._id_C8C9FE6038E69B34 * 0.4);
  _id_AED74300DAF62896._id_BFE291B401A9BF2A = [];

  if(!isDefined(level.struct_class_names["script_noteworthy"]["boss_pyro"])) {
    return;
  }
  foreach(node in level.struct_class_names["script_noteworthy"]["boss_pyro"])
  _id_AED74300DAF62896._id_BFE291B401A9BF2A[_id_AED74300DAF62896._id_BFE291B401A9BF2A.size] = node;

  _id_03A246920C9288C4::trophy_init();
}

_id_B9AF1A95F5D7A50B() {
  _id_4A755326CD53D3B3();
  _id_03A246920C9288C4::trophy_init();
}

_id_4108074415ABC816() {
  if(!istrue(level._id_02A75E2A44DA2072))
    _id_B9AF1A95F5D7A50B();

  aitype = "enemy_cp_boss_pyro";
  _id_E2958F412A7425C0 = self;

  if(!isDefined(_id_E2958F412A7425C0)) {
    return;
  }
  _id_E2958F412A7425C0._id_B582B10663B5B2A9 = 0;
  _id_FB62BCEF7FAB15FB(_id_E2958F412A7425C0);
  weaponname = getcompleteweaponname(_id_E2958F412A7425C0.weapon);

  if(!isDefined(_id_E2958F412A7425C0.weaponinfo[weaponname]))
    _id_E2958F412A7425C0 scripts\common\utility::initweapon(_id_E2958F412A7425C0.weapon);

  _id_E2958F412A7425C0.a.weaponpos["right"] = _id_E2958F412A7425C0.weapon;
  _id_E2958F412A7425C0._id_A4738C70736D3A61 = ::_id_153057A89F66A0F9;
  loc = spawnStruct();
  loc.origin = _id_E2958F412A7425C0.origin;
  loc.angles = (0, 0, 0);

  if(isDefined(_id_E2958F412A7425C0.spawner.script_timer)) {
    _id_E2958F412A7425C0 thread _id_125DAD10F1261289(loc, _id_E2958F412A7425C0.spawner.script_timer);
    return;
  } else
    _id_E2958F412A7425C0 thread _id_5EE2F96997D9F8F5(loc);

  return _id_E2958F412A7425C0;
}

_id_125DAD10F1261289(loc, delay) {
  _id_E2958F412A7425C0 = self;
  self endon("death");

  if(isDefined(delay)) {
    wait(delay);
    loc.origin = _id_E2958F412A7425C0.origin;
    loc.angles = (0, 0, 0);
  } else
    _id_E2958F412A7425C0 waittill(_id_E2958F412A7425C0.spawner.script_noteworthy);

  _id_E2958F412A7425C0 _id_5EE2F96997D9F8F5(loc);
}

_id_1CCE3618F05EB5C8(loc) {
  _id_E2958F412A7425C0 = self;
  _id_03A246920C9288C4::_id_233602CC27D9FCF8(loc, 1, 10, 200, "axis");
  _id_E2958F412A7425C0._id_D16A13B262DA0BF6 = loc;
}

_id_5EE2F96997D9F8F5(loc) {
  _id_E2958F412A7425C0 = self;

  if(isDefined(_id_E2958F412A7425C0.spawner)) {
    if(isDefined(_id_E2958F412A7425C0.spawner.script_noteworthy) && issubstr(_id_E2958F412A7425C0.spawner.script_noteworthy, "delay_trophy")) {
      _id_E2958F412A7425C0 thread _id_125DAD10F1261289(loc);
      return;
    }
  }

  _id_E2958F412A7425C0 _id_1CCE3618F05EB5C8(loc);
}

_id_FB62BCEF7FAB15FB(agent) {
  if(!isDefined(agent)) {
    return;
  }
  _id_A664AAD02EE98BD2 = "molotov_mp";
  grenadeammo = getdvarint("dvar_537FA443CE212A8A", 12);
  weapon = level.br_lootiteminfo["brloot_weapon_sh_vecho_lege"].fullweaponobj;
  armor = 666;
  helmet = 10;
  agent._id_668B72F41E87C75A = 1;
  agent._id_D38FB77455B25729 = 4000;
  agent._id_BA2F6374446E1525 = 0;
  agent._id_E6AF4BA7CF5CC852 = 0;
  agent._id_62482B4F67666074 = 10000;
  agent._id_A7AAE99DA4C9E990 = 60000;
  agent._id_2808079B46AE6650 = 3000;
  agent._id_7528BDD4F8EA8811 = 0;
  agent._id_0A83B580F45A7120 = 20000;
  _id_918249FD5219A579 = undefined;
  agent.baseaccuracy = getdvarfloat("dvar_298D4EA8B0934E31", 1.2);
  agent _id_371B4C2AB5861E62::_id_C37C4F9D687074FF("body_sp_opforce_al_qatala_boss_pyro", "head_sp_opforce_al_qatala_boss_pyro", weapon, _id_A664AAD02EE98BD2, grenadeammo, armor, helmet, 1);
  agent _id_720C3B7ABF4BAAC8("pyro", 0, _id_918249FD5219A579);
  agent thread _id_371B4C2AB5861E62::_id_0036613FFB5EBE56(agent);
  agent _meth_8ABE5A968CC3C220("scubagr");
  agent setclothtype("vestheavy");
}

_id_720C3B7ABF4BAAC8(name, _id_B700D8D067B3EEDB, _id_787D4BE10BA144D6) {
  self._id_B582B10663B5B2A9 = 0;
  self._id_685390C6753C2CC7 = istrue(_id_B700D8D067B3EEDB);
  self.battlechatterallowed = 0;
  self._id_47BDE44B1ACEC603 = name;
  self._id_F2A62F02827DAAA5 = 1.0;
  thread _id_2676819F01AE14ED(name, _id_787D4BE10BA144D6);
}

_id_2676819F01AE14ED(name, _id_787D4BE10BA144D6, _id_C026F33AC9E83DEB) {
  self endon("boss_despawn");
  instance = self._id_0566868292EE2A1B;
  self waittill("death", _id_6181DE250AFA5BB6);

  if(isDefined(_id_6181DE250AFA5BB6) && isDefined(_id_6181DE250AFA5BB6.vehicletype)) {
    if(isDefined(_id_6181DE250AFA5BB6.owner))
      _id_6181DE250AFA5BB6 = _id_6181DE250AFA5BB6.owner;
  }

  if(isDefined(instance)) {
    instance notify("boss_death");
    instance._id_6181D0250AFA3CEC = 1;
    instance._id_6181DE250AFA5BB6 = _id_6181DE250AFA5BB6;
  }

  if(isDefined(_id_6181DE250AFA5BB6) && isDefined(_id_6181DE250AFA5BB6.team)) {
    players = scripts\cp\cp_outline_utility::getteamdata(_id_6181DE250AFA5BB6.team, "players");

    foreach(player in players) {
      if(!isDefined(player._id_8C8050D7D861D06C))
        player._id_8C8050D7D861D06C = 0;

      player._id_8C8050D7D861D06C++;
    }
  }
}

_id_F040EFE2F90B41FB() {}

_id_153057A89F66A0F9(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon) {
  if(!istrue(self._id_E6AF4BA7CF5CC852) && isDefined(shitloc) && shitloc == "shield") {
    time = gettime();

    if(!isDefined(self._id_E494707422B1CFE6))
      self._id_E494707422B1CFE6 = time;

    if(isDefined(self._id_F35DE24A74B2DD14) && time - self._id_F35DE24A74B2DD14 > self._id_A7AAE99DA4C9E990) {
      self._id_E494707422B1CFE6 = time;
      self._id_BA2F6374446E1525 = 0;
    }

    self._id_F35DE24A74B2DD14 = time;
    self._id_BA2F6374446E1525 = self._id_BA2F6374446E1525 + idamage;

    if(self._id_BA2F6374446E1525 > self._id_D38FB77455B25729 && time - self._id_E494707422B1CFE6 > self._id_62482B4F67666074) {
      self.bhasthermitestucktoshield = 1;
      self.thermitestuckpains = 4;
      thread _id_0E44C53E48F00CCE(eattacker);
    }
  } else if(self._id_7528BDD4F8EA8811 - gettime() > self._id_0A83B580F45A7120)
    thread _id_0E44C53E48F00CCE(eattacker);

  self.lastattackedtime = gettime();
  _id_24FBEDBA9A7A1EF4::_id_DFFAC413ED66BCD0(einflictor, eattacker, int(idamage), idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon);
}

_id_0E44C53E48F00CCE(attacker) {
  self._id_7528BDD4F8EA8811 = gettime();
  wait 1;
  _id_371B4C2AB5861E62::_id_AE99616202575E39(attacker.origin, "molotov_mp", 128);
  self waittill("ai_forceThrowGrenade_finish");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 2; _id_AC0E594AC96AA3A8++) {
    _id_5B4505D2DCC12BD8 = scripts\engine\utility::_id_6174330574A2A273() * 0.5;
    _id_217CFFEB082DE02A = anglesToForward(self.angles) + (_id_5B4505D2DCC12BD8[0], _id_5B4505D2DCC12BD8[1], 0);
    _id_1E54D7B3480E50C9 = self.origin + _id_217CFFEB082DE02A * 50;
    _id_33071C5CA19FBB3F = self launchgrenade("molotov_mp", _id_1E54D7B3480E50C9, _id_217CFFEB082DE02A + (0, 0, 1));
    _id_33071C5CA19FBB3F.team = self.team;
  }
}

_id_96323C515C3294BF() {
  self endon("death");

  for(;;) {
    if(isDefined(self.lastattackedtime)) {
      if(gettime() - self.lastattackedtime > self._id_2808079B46AE6650 && gettime() - self._id_7528BDD4F8EA8811 > self._id_0A83B580F45A7120) {
        self._id_7528BDD4F8EA8811 = gettime();
        players = scripts\cp\utility::getplayersinradius(self.origin, 1000);
        self.lastattackedtime = undefined;
      }
    }

    wait 0.1;
  }
}

_id_08168A2FFF2FEE79(icon) {
  self endon("death");

  for(;;) {
    waitframe();
    icon scripts\cp_mp\utility\game_utility::_id_6E148C8DA2E4DB13(self.origin);
    icon.origin = self.origin;
  }
}

_id_E63EEF21B7ACD619() {
  _id_B50D9E77221817C0 = self;

  if(!isDefined(_id_B50D9E77221817C0._id_276AC5E84835EA87)) {
    return;
  }
  _id_B50D9E77221817C0 endon("death");
  level endon("game_ended");
  level._id_6ACF5C6209798CBF._id_9559116321E7FD23 = 0;
  _id_B50D9E77221817C0._id_276AC5E84835EA87 waittill("barrelExploded");
  level._id_6ACF5C6209798CBF._id_DF89B78D72D185BE = 1;
  level notify("pyro_interruptLine");
}

_id_E7D3411DB935E99B(pos) {
  self endon("death");
  wait 2;
  self.vehicle_position = pos;
  self.script_startingposition = pos;
}