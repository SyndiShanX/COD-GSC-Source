/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_28c33ef10a3cb4a1.gsc
***********************************************/

_id_8FA25CA58F24B519() {
  level endon("game_ended");
  scripts\cp_mp\utility\script_utility::registersharedfunc(24696, "pickedUp", ::_id_F2AC7C7C22F85203);
  _id_47FC06D4BB326007::_id_A414FBF48AE645F4();

  while(!isDefined(level.struct_class_names))
    waitframe();

  _id_CCB720B48A020C23();
  level._id_36C35402E710F1AC = scripts\engine\utility::getStructArray("sniper_breath_position", "script_noteworthy");
  level._id_BAD48E44807A965E = scripts\engine\utility::getStructArray("sniper_retreat_position", "script_noteworthy");
  level._id_7FC2C2A044242167 = scripts\engine\utility::getStructArray("sniper_hide_position", "script_noteworthy");

  if(isDefined(level._id_BAD48E44807A965E)) {
    _id_48A04D995BC94C55 = [];

    foreach(_id_EED2D7932E46B7DF in level._id_BAD48E44807A965E) {
      number = int(_id_EED2D7932E46B7DF.targetname);
      _id_48A04D995BC94C55[number] = _id_EED2D7932E46B7DF;
    }

    level._id_BAD48E44807A965E = _id_48A04D995BC94C55;
  }

  _id_A36A69AE98DA13C5 = scripts\engine\utility::getStruct("boss_spawn_point_1", "script_noteworthy");
  _id_A36A66AE98DA0D2C = scripts\engine\utility::getStruct("boss_spawn_point_2", "script_noteworthy");
  _id_48814951E916AF89::_id_2FC80954FA70D153();
  _id_FC9F12C98D50E169 = _id_A36A69AE98DA13C5.script_stealthgroup;
  _id_FC9F0FC98D50DAD0 = _id_A36A66AE98DA0D2C.script_stealthgroup;
  team = "team_hundred_ninety_five";
  _id_ED330C2F0716E2FC = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF("enemy_mp_boss_rusher", _id_A36A69AE98DA13C5.origin, (0, 0, 0), "absolute", "bosses", "rusherBoss", _id_FC9F12C98D50E169, team, undefined, undefined, undefined, undefined, 0, undefined);
  sniper = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF("enemy_mp_boss_sniper", _id_A36A66AE98DA0D2C.origin, (0, 0, 0), "absolute", "bosses", "sniperBoss", _id_FC9F0FC98D50DAD0, team, undefined, undefined, undefined, undefined, 0, undefined);
  _id_9905B1D4F31FAE17 = getdvarint("dvar_6B52766A74EA9709", 150);
  _id_562A64F6675667D3 = getdvarint("dvar_F58D4F3E6A5D99ED", 6000);
  _id_E3B26A2E4AB74CDD = getdvarint("dvar_93690CA4B9237417", 200);
  _id_C8C3A01F3951F421 = getdvarint("dvar_B7496E37CBB989D3", 3000);
  _id_5A4B66DC00584379 = ["brloot_cartel_deal_documents", "interactable_note_bunker_boss02"];
  _id_ED330C2F0716E2FC _id_D4DB944803F0CD56("rusher", _id_9905B1D4F31FAE17, _id_562A64F6675667D3, _id_5A4B66DC00584379);
  _id_ED330C2F0716E2FC thread _id_7E501C042686296C(sniper);
  _id_ED330C2F0716E2FC thread _id_85DC23401B46CF41();
  _id_ED330C2F0716E2FC thread _id_DBA40250206B75FA();
  _id_ED330C2F0716E2FC.battlechatterallowed = 0;
  _id_6FDEC4723F6EF057 = ["loot_key_biobunker_boss_b_worn", "interactable_note_bunker_boss03"];
  sniper _id_D4DB944803F0CD56("sniper", _id_E3B26A2E4AB74CDD, _id_C8C3A01F3951F421, _id_6FDEC4723F6EF057);
  sniper thread _id_001E6F0A208354FE(_id_ED330C2F0716E2FC);
  sniper thread _id_85DC23401B46CF41();
  sniper.battlechatterallowed = 0;
  level thread _id_EA9FE955BAFEBA30();
  _id_4C770A9A4AD7659C::_id_52004C7A02FCFFD6("player_laststand", ::_id_43324B71FF7E6CF7);
  level _id_84B3824FE55F060D();
  _id_ED330C2F0716E2FC thread _id_9299E0C6FFE82D34();
  level thread _id_1AA55FC8E786E252();
}

_id_A31B62950B381852(name, _id_6C1E83B4BA1C28F5) {
  _id_AED74300DAF62896 = spawnStruct();
  _id_AED74300DAF62896.name = name;
  _id_2FDEB8023287BE67::_id_613E13E7416BFAA5(_id_AED74300DAF62896);
  instance = _id_2FDEB8023287BE67::_id_2E6E2B664DFE3186(name);
  instance.agent = _id_6C1E83B4BA1C28F5;
  instance._id_E2958F412A7425C0 = _id_6C1E83B4BA1C28F5;
  instance._id_9329E0D3CE1D5CA8 = name;
  _id_6C1E83B4BA1C28F5._id_0566868292EE2A1B = instance;
  return instance;
}

_id_84B3824FE55F060D() {
  setDvar("dvar_1F7FC5197974A94F", 1600);
  setDvar("dvar_EAD6FBE92BC47426", 3200);
  level._id_B1149892B2595056 = getdvarint("dvar_1F7FC5197974A94F", 1600);
  level._id_7B10B08DDB3F610F = getdvarint("dvar_EAD6FBE92BC47426", 3200);
}

_id_9299E0C6FFE82D34(delay) {
  level endon("game_ended");
  self endon("death");
  delay = scripts\engine\utility::_id_53C4C53197386572(delay, 0.05);
  _id_985AE874212B863E = [];
  _id_985AE874212B863E["idle"] = ["", 0.0];
  _id_985AE874212B863E["combat"] = ["dmz_boss_rusher_sniper_combat", 1.0];
  _id_6B9A0DBBF039DECE = 1;
  _id_E52F572DFADB149F = 24000;
  _id_0E23B09DE2E27ED9 = 60000;
  wait(delay);
  self._id_0566868292EE2A1B thread _id_65F58F3C394DCF9A::_id_B5BE3A44077AEC21(self._id_0566868292EE2A1B, _id_985AE874212B863E, _id_E52F572DFADB149F, _id_0E23B09DE2E27ED9, _id_6B9A0DBBF039DECE);
}

_id_CCB720B48A020C23() {
  level._id_1608A5948A0BE98D = [];
  level._id_1608A5948A0BE98D["sniper_spawn_soldier_1"] = scripts\engine\utility::getStructArray("sniper_spawn_soldier_1", "script_noteworthy");
  level._id_1608A5948A0BE98D["sniper_spawn_soldier_2"] = scripts\engine\utility::getStructArray("sniper_spawn_soldier_2", "script_noteworthy");
  level._id_1608A5948A0BE98D["sniper_spawn_soldier_3"] = scripts\engine\utility::getStructArray("sniper_spawn_soldier_3", "script_noteworthy");
  level._id_1608A5948A0BE98D["stairwell_reinforce"] = scripts\engine\utility::getStructArray("stairwell_reinforce", "script_noteworthy");
  level._id_1608A5948A0BE98D["boss_spawn_point_1"] = scripts\engine\utility::getStructArray("boss_spawn_point_1", "script_noteworthy");
  level._id_1608A5948A0BE98D["bunker_room_objective"] = scripts\engine\utility::getStruct("bunker_room_objective", "script_noteworthy");
}

_id_D4DB944803F0CD56(name, helmethealth, armorhealth, _id_E68854C914287B7C) {
  self._id_47BDE44B1ACEC603 = name;
  self.helmethealth = helmethealth;
  self._id_CFC69E5588A5BED6 = helmethealth;
  self.armorhealth = armorhealth;
  self._id_8790C077C95DB752 = armorhealth;
  self._id_8C5C47F81A1869E5 = _id_24FBEDBA9A7A1EF4::_id_7D0D24665D72F13C;
  self._id_B582B10663B5B2A9 = 0;
  self._id_274D3A7704E351EF = 1;
  self.allowpain = 0;
  self _meth_ AE41FBF799BA43F(1, "entity");
  _id_371B4C2AB5861E62::_id_1C3709E864D4E8D5(1);
  _id_A31B62950B381852(name, self);

  foreach(item in _id_E68854C914287B7C)
  _id_48814951E916AF89::_id_63A043D47490F90D(self, item, undefined, 1, 1);
}

_id_7AFF1F5E65A781D7() {
  level endon("game_ended");
  _id_0566868292EE2A1B = self._id_0566868292EE2A1B;
  _id_47BDE44B1ACEC603 = self._id_47BDE44B1ACEC603;
  _id_EB06BE12D8E1D936 = undefined;

  if(_id_47BDE44B1ACEC603 == "rusher")
    _id_EB06BE12D8E1D936 = self._id_EB06BE12D8E1D936;

  self waittill("death", _id_6181DE250AFA5BB6);

  if(isDefined(_id_6181DE250AFA5BB6) && isDefined(_id_6181DE250AFA5BB6.vehicletype)) {
    if(isDefined(_id_6181DE250AFA5BB6.owner))
      _id_6181DE250AFA5BB6 = _id_6181DE250AFA5BB6.owner;
  }

  if(isDefined(_id_0566868292EE2A1B)) {
    _id_0566868292EE2A1B notify("boss_death");
    _id_0566868292EE2A1B._id_6181D0250AFA3CEC = 1;
    _id_0566868292EE2A1B._id_6181DE250AFA5BB6 = _id_6181DE250AFA5BB6;
    _id_F1E5DD9037C67CD6 = "dmz_boss_rusher_sniper_win";
    _id_54307D62E05248F8 = 1.0;

    if(_id_47BDE44B1ACEC603 == "rusher") {
      _id_F1E5DD9037C67CD6 = "";
      _id_54307D62E05248F8 = 0.0;
    }

    _id_65F58F3C394DCF9A::_id_73F954808739F7BC(_id_0566868292EE2A1B, _id_6181DE250AFA5BB6, _id_F1E5DD9037C67CD6, _id_54307D62E05248F8);
  }

  if(isDefined(_id_6181DE250AFA5BB6) && isDefined(_id_6181DE250AFA5BB6.team)) {
    players = scripts\mp\utility\teams::getteamdata(_id_6181DE250AFA5BB6.team, "players");

    foreach(player in players) {
      if(!isDefined(player._id_8C8050D7D861D06C))
        player._id_8C8050D7D861D06C = 0;

      player._id_8C8050D7D861D06C++;
    }
  }

  if(_id_47BDE44B1ACEC603 == "rusher") {
    level notify("rusherIsKilled");

    if(isalive(_id_EB06BE12D8E1D936)) {
      _id_EB06BE12D8E1D936 thread _id_F05A1A8592BFFDD3("bio_bunker_boss_sniper_rusher_down");
      _id_EB06BE12D8E1D936 thread _id_9299E0C6FFE82D34(30.0);
    }

    _id_A9964D87FA3CC7CC = getEntArray("boss_arena_2nd_clip", "script_noteworthy");

    foreach(clip in _id_A9964D87FA3CC7CC)
    clip delete();
  }
}

_id_563C8928520A0086(sniper) {
  self.radius = 15;
  self.height = 40;
  self.aistate = "idle";
  self._id_C8818686F12F33B6 = 26 + self.radius;
  self._id_B9DC79113497B05B = self.radius + 1;
  self._id_5754D6C3DF1A2B31 = "normal";
  self._id_5CB3CC0C49EE04F1 = 50;
  self._id_FA4CF34A0C3681B8 = 70;
  self._id_4BBA3A58F389E465 = self._id_FA4CF34A0C3681B8;
  self._id_BB57EF5C97F7C107 = gettime() + 1000;
  self._id_0D4AE052F5BDA013 = 1;
  self._id_7A480DEB4960D81E = 16;
  self._id_A853A9004B90B766 = -16;
  self.pathenemyfightdist = 328;
  self._id_7AEBD48DA5B12133 = randomfloatrange(290, 300);
  self._id_F714DCBA7A0B7168 = randomfloatrange(140, 180);
  self._id_93FEFC5DCF9EC592 = 0;
  self._id_F2C71E79C48B6D6B = 0;
  self._id_8B21F2B424F46AF0 = 2.0;
  self._id_B7BDFA418F9F4430 = gettime();
  self._id_BF830B312EB47E30 = gettime();
  self._id_9563742BCC8616C5 = gettime();
  self._id_0725FA7A4D881277 = gettime();
  self._id_2536E610F6EA9C94 = 1.2;
  self._id_67E1D89E2F7C463D = 0.85;
  self._id_7C0157EC8B265F6E = 40;
  self._id_FA4CF34A0C3681B8 = 70;
  self._id_4BBA3A58F389E465 = self._id_FA4CF34A0C3681B8;
  self._id_A9BBCE143412F034 = 80;
  self._id_F5BD7EEB8C658300 = squared(self._id_FA4CF34A0C3681B8);
  self._id_3835F6FBD6173DC9 = squared(self._id_4BBA3A58F389E465);
  self._id_14E53F718BCC4302 = 80;
  self._id_0DFFD7786E2FACCD = 40;
  self.meleechargedistvsplayer = self._id_14E53F718BCC4302;
  self.meleechargedist = 125;
  self.meleebashmaxdistsq = 8100;
  self.meleerangesq = 4096;
  self._id_C2D7CF1CFD42CBBB = 12100;
  self._id_70DD5AB41A229510 = 1;
  self.meleeignoreplayerstance = 1;
  self._id_6E8BC2A1F79B2398 = "walk";
  self._id_D22F6A342517B6F3 = gettime();
  self._blackboard.meleerequested = 0;
  self._blackboard.meleerequestedtarget = undefined;
  self._id_7A480DEB4960D81E = 16;
  self._id_A853A9004B90B766 = -16;
  self._id_D2DE23941E0246F4 = gettime();

  if(getdvarint("dvar_3F8E4D5731E36A4F", 1) == 1)
    self attach("weapon_wm_me_sword01_v2", "TAG_ACCESSORY_LEFT");

  self._id_705E2628D263EE2C = loadfx("vfx/iw9/equipment/smoke_bomb/vfx_smoke_bomb_explosion.vfx");
  _id_23EAD74859674F83::_id_A490D346D97D0167(self._id_FA4CF34A0C3681B8);
  self._id_3942301085D60337 = _id_23EAD74859674F83::_id_CF169A8DE2A0D355;
  self._id_7E006F8C7B898B70 = _id_23EAD74859674F83::_id_E8F9A124778CC606;
  _id_23EAD74859674F83::_id_CF169A8DE2A0D355("run");
  _id_23EAD74859674F83::_id_E8F9A124778CC606(1.0);
  weaponobj = makeweapon("iw9_me_riotshield_mp");
  self giveweapon(weaponobj);
  scripts\mp\riotshield::riotshield_attach(0, scripts\mp\riotshield::riotshield_getmodel());
  self._id_EB06BE12D8E1D936 = sniper;
  self._id_EF3BFD0243258E2F = 1;

  if(getdvarint("dvar_321F9FAB5B53E9EA", 1)) {
    self._id_C57D794B6C67E607 = self.maxhealth + self._id_8790C077C95DB752 + self._id_CFC69E5588A5BED6;
    self._id_A4738C70736D3A61 = ::_id_FC8749072F459798;
    self._id_B2C2CD0993DD3077 = 80;
  }

  _id_1AB711F2A850D248("brloot_weapon_pi_decho_lege_biobunker");
  _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(self, "dropWeapon", 0);
  _id_48814951E916AF89::_id_63A043D47490F90D(self, "brloot_weapon_pi_decho_lege_biobunker", undefined, 1, 1);
}

_id_FC8749072F459798(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon) {
  _id_47FC06D4BB326007::_id_1AB798A528080DB2(einflictor, eattacker, int(idamage), idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon);

  if(isPlayer(eattacker)) {
    if(!isalive(self)) {
      return;
    }
    if(!isDefined(self._id_4540490553264790))
      self._id_4540490553264790 = gettime();

    currenthealth = self.health + self.armorhealth + self.helmethealth;
    _id_4335B4D453C6E781 = currenthealth / self._id_C57D794B6C67E607 * 100;

    if(_id_4335B4D453C6E781 < 0 || _id_4335B4D453C6E781 > 100) {
      return;
    }
    eventname = undefined;
    _id_1C4A45932ED1488A = getdvarint("dvar_59A14D2AD9477748", 10) * 1000;

    if(self._id_B2C2CD0993DD3077 > 0) {
      if(_id_4335B4D453C6E781 <= self._id_B2C2CD0993DD3077) {
        eventname = "boss_reinforcement_";

        switch (self._id_B2C2CD0993DD3077) {
          case 80:
            if(self._id_4540490553264790 < _id_1C4A45932ED1488A)
              eventname = eventname + "left_hard";
            else
              eventname = eventname + "left";

            break;
          case 60:
            eventname = eventname + "right";
            break;
          case 40:
            eventname = eventname + "left_hard";
            break;
          case 20:
            eventname = eventname + "right_hard";
            break;
          default:
            eventname = undefined;
            break;
        }

        self._id_B2C2CD0993DD3077 = self._id_B2C2CD0993DD3077 - 20;
      }
    } else
      eventname = undefined;

    if(isDefined(eventname)) {
      if(isDefined(self._id_E0E153C5C4AA47B7) && gettime() - self._id_E0E153C5C4AA47B7 < _id_1C4A45932ED1488A && !issubstr(eventname, "_hard"))
        eventname = eventname + "_hard";

      thread _id_F05A1A8592BFFDD3("bio_bunker_boss_rusher_player_reinforcement_coming");
      thread _id_D30610B7162215A2(eventname);
      self._id_E0E153C5C4AA47B7 = gettime();
    }
  }
}

_id_7E501C042686296C(sniper) {
  level endon("game_ended");
  self endon("death");
  _id_563C8928520A0086(sniper);
  thread _id_7AFF1F5E65A781D7();
  _id_5213D881F2E26966(self.origin, "stealthVolume_boss_arena_lv1_central", "stealthVolume_boss_arena_lv1");
  _id_120270BD0A747A35::_id_D1E130608E4F8487(self, self.origin, 1);
  thread _id_8EB6EFD0A1326D09();
  self _meth_E64EA2B4E79C4B74(4);
  scripts\engine\utility::waittill_any_2("damage", "start_combat");
  thread _id_F05A1A8592BFFDD3("bio_bunker_boss_rusher_approach_first_time");
  players = _id_E58D7000A2C96232(self._id_D375AD59185E776F);

  if(players.size > 0) {
    _id_AC4C51BF033F6323 = scripts\mp\utility\teams::getteamdata(players[0].team, "players");
    _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_rusher_revealed", _id_AC4C51BF033F6323);
  }

  self clearbtgoal(4);
  self._id_EB06BE12D8E1D936 notify("start_combat");
  thread _id_B46325ABAE5AD373();
  thread _id_B04028D06F64F4C7();
  thread _id_40C5ADD23DCEE24B();
}

_id_8EB6EFD0A1326D09() {
  level endon("game_ended");
  self endon("death");
  self endon("damage");

  for(;;) {
    waitframe();
    players = _id_E58D7000A2C96232(self._id_D375AD59185E776F);

    if(players.size > 0) {
      self notify("start_combat");
      _id_6B9A0DBBF039DECE = 1;
      _id_65F58F3C394DCF9A::_id_5C07A5046A6DC0F4(players[0].team, players[0], level._id_B1149892B2595056, "dmz_boss_rusher_sniper_approach", undefined, _id_6B9A0DBBF039DECE);
      break;
    }
  }
}

_id_D30610B7162215A2(event) {
  level endon("game_ended");
  self endon("death");
  _id_2D9C29F869A29FCA::_id_844DFE93476D59AB(event, self.origin, 128);
}

_id_B04028D06F64F4C7() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    waitframe();

    if(istrue(self._id_93FEFC5DCF9EC592)) {
      self.meleechargedistvsplayer = self._id_0DFFD7786E2FACCD;
      self.disablearrivals = 1;
    } else {
      self.disablearrivals = 0;
      self.meleechargedistvsplayer = self._id_14E53F718BCC4302;
    }

    _id_8B935D4E83A07DA0 = 0;

    if(istrue(self._id_6BB7C58775BF5475))
      _id_8B935D4E83A07DA0 = 1;

    if(!isDefined(self.enemy))
      _id_8B935D4E83A07DA0 = 1;

    if(self._id_93FEFC5DCF9EC592 && self._id_0725FA7A4D881277 < gettime())
      _id_8B935D4E83A07DA0 = 1;

    if(istrue(self._id_A97AC004F00C5DF9))
      _id_8B935D4E83A07DA0 = 1;

    if(_id_8B935D4E83A07DA0) {
      self._id_93FEFC5DCF9EC592 = 0;
      self._id_F2C71E79C48B6D6B = 0;
      self.allowstrafe = 1;
      continue;
    }

    _id_4CC3991A09636F42 = 0;

    if(self.ignoreall)
      _id_4CC3991A09636F42 = 1;

    if(isPlayer(self.enemy) && _id_23EAD74859674F83::_id_A0CC8513F431ED0D(self.enemy))
      _id_4CC3991A09636F42 = 1;

    if(isDefined(self.enemy.is_fast_traveling) || isDefined(self.enemy._id_5AA26DCE2C71AD98))
      _id_4CC3991A09636F42 = 1;

    if(_id_4CC3991A09636F42) {
      scripts\asm\asm_bb::bb_clearmeleetarget();
      self _meth_8A144CB1601C409A();
      continue;
    }

    if(!self._id_F2C71E79C48B6D6B) {
      self.goalradius = 2048;
      self.pathenemyfightdist = 328;
      self.allowstrafe = 1;
      self aisetdesiredspeed(self._id_F714DCBA7A0B7168);
      self clearbtgoal(0);
      self clearbtgoal(1);
      self clearbtgoal(3);
      msg = scripts\engine\utility::waittill_any_timeout_1(10.0, "out_of_bounds");

      if(msg != "out_of_bounds")
        self._id_F2C71E79C48B6D6B = 1;

      continue;
    }

    self clearbtgoal(3);
    _id_8A755B28784E6E3E = undefined;

    if(isDefined(self._id_1E0B2C127D2BE63E))
      _id_8A755B28784E6E3E = self._id_1E0B2C127D2BE63E;
    else if(isDefined(self.enemy) && !_id_23EAD74859674F83::_id_A0CC8513F431ED0D(self.enemy)) {
      if(isDefined(self.enemy scripts\cp_mp\utility\player_utility::getvehicle()))
        _id_8A755B28784E6E3E = self.enemy scripts\cp_mp\utility\player_utility::getvehicle();
      else
        _id_8A755B28784E6E3E = self.enemy;
    }

    if(!isDefined(_id_8A755B28784E6E3E)) {
      self._id_0D4AE052F5BDA013 = 1;
      scripts\asm\asm_bb::bb_clearmeleetarget();
      self _meth_8A144CB1601C409A();
      continue;
    }

    _id_8ADC06D9FDFE6452 = _id_8A755B28784E6E3E.origin;
    _id_3711CDF227CCD51B = distancesquared(_id_8ADC06D9FDFE6452, self.origin);

    if(_id_3711CDF227CCD51B > 62500)
      self._id_C0F027481D84B560 = self.origin;

    _id_F33F587E225DE2AF = _id_D6F2A636B15BC511(_id_8A755B28784E6E3E, _id_8ADC06D9FDFE6452, 10000);

    if(isDefined(_id_F33F587E225DE2AF)) {
      if(istrue(self._id_79C2DE8443D5F950))
        self _meth_79C2DE8443D5F950();

      if(!self._id_93FEFC5DCF9EC592) {
        self._id_93FEFC5DCF9EC592 = 1;
        _id_FBE0F3772393F859(self);
        self._id_0725FA7A4D881277 = gettime() + 7000;
      }

      self notify("chase_enemy");
      self.goalradius = 0;
      self.pathenemyfightdist = 0;
      self.allowstrafe = 0;
      self._blackboard.forcestrafe = 0;

      if(self._id_D22F6A342517B6F3 < gettime()) {
        self._id_D22F6A342517B6F3 = gettime() + 1000;

        if(randomfloatrange(0, 1) < 0.2)
          _id_FBE0F3772393F859(self);
      }

      self aisetdesiredspeed(self._id_7AEBD48DA5B12133);
      self clearbtgoal(0);
      self clearbtgoal(1);
      self clearbtgoal(3);
      self setgoalpos(_id_F33F587E225DE2AF, self.goalradius);
      self._id_0D4AE052F5BDA013 = 0;
      _id_F80179D793B1D373(_id_8A755B28784E6E3E, _id_F33F587E225DE2AF);
    }

    continue;
  }
}

_id_67F179FC98F08D0D() {
  if(gettime() > self._id_D2DE23941E0246F4)
    return 1;
  else
    return 0;
}

_id_40C5ADD23DCEE24B() {
  level endon("game_ended");
  self endon("death");
  _id_37549DAF4AE9CC75 = 0.2;

  for(;;) {
    self waittill("damage");

    if(isDefined(self.enemy)) {
      if(randomfloatrange(0, 1) < _id_37549DAF4AE9CC75)
        _id_FBE0F3772393F859(self);
    }
  }
}

_id_FBE0F3772393F859(agent) {
  _id_E4C0029ABED6F369 = getdvarint("dvar_66E4C20FED2F5B65", 10000);

  if(_id_67F179FC98F08D0D()) {
    _id_BBB46CF9B3984F47 = anglesToForward(agent.angles);
    position = agent.origin + _id_BBB46CF9B3984F47 * 50;
    _id_4E0A3B3F9BEDD99D::_id_CA247899DBBCF9A4(position);
    _id_4E0A3B3F9BEDD99D::_id_D93415244E99E763(position, agent.angles, getdvarint("dvar_37448409E13A1AF7", 1) == 1, 1);
    self._id_D2DE23941E0246F4 = gettime() + _id_E4C0029ABED6F369;
  }
}

_id_D6F2A636B15BC511(target_ent, _id_BF1B72D688BC972D, _id_2057ACE5B545925D) {
  self._id_788DDF5CE6DE796A = undefined;
  _id_F33F587E225DE2AF = getclosestpointonnavmesh(_id_BF1B72D688BC972D);
  _id_E1BBCB81B41FFEFD = distancesquared(_id_F33F587E225DE2AF, _id_BF1B72D688BC972D);

  if(istrue(self._id_1FB8CEE5F3E1B38B) && !ispointinvolume(target_ent.origin, self._id_0B5C268FD0721F06))
    self._id_788DDF5CE6DE796A = 1;
  else if(isPlayer(target_ent) && istrue(target_ent.inlaststand) && !target_ent _meth_F1DCADC8F7C3477C())
    self._id_788DDF5CE6DE796A = 1;
  else if(isDefined(target_ent.classname) && target_ent.classname == "grenade")
    self._id_788DDF5CE6DE796A = 1;
  else if(isPlayer(target_ent) && (target_ent isonladder() || target_ent _meth_9CC921A57FF4DEB5()))
    self._id_788DDF5CE6DE796A = 1;
  else if(!_id_23EAD74859674F83::_id_8C1EBABCC8737D7E(_id_F33F587E225DE2AF, target_ent.origin))
    self._id_788DDF5CE6DE796A = 1;
  else if(_id_E1BBCB81B41FFEFD > 625) {
    _id_AC6B2AECD711A3BC = scripts\mp\agents\scriptedagents::droppostoground(_id_F33F587E225DE2AF, 128);

    if(!isDefined(_id_AC6B2AECD711A3BC)) {
      _id_AC6B2AECD711A3BC = getgroundposition(_id_F33F587E225DE2AF, 1, 128, 0);

      if(!isDefined(_id_AC6B2AECD711A3BC))
        _id_AC6B2AECD711A3BC = _id_F33F587E225DE2AF - (0, 0, 10);
    }

    if(isPlayer(target_ent) && target_ent scripts\cp_mp\utility\player_utility::isinvehicle())
      self._id_788DDF5CE6DE796A = 1;
    else if(isPlayer(target_ent) && (target_ent scripts\cp_mp\utility\player_utility::_id_988138367C74B1F5() || target_ent scripts\cp_mp\utility\player_utility::_id_D474B372046544B0()))
      self._id_788DDF5CE6DE796A = 1;
    else if(istrue(self._id_16CF75FF2BB42685))
      self._id_788DDF5CE6DE796A = 1;
    else if(!ispointonnavmesh(target_ent.origin, self)) {
      if(!_id_23EAD74859674F83::_id_1EA5D1AD97D72DA5(_id_AC6B2AECD711A3BC, target_ent.origin))
        self._id_788DDF5CE6DE796A = 1;
    } else if(!_id_23EAD74859674F83::_id_B5C47115061C80C9(_id_AC6B2AECD711A3BC, target_ent.origin))
      self._id_788DDF5CE6DE796A = 1;
  }

  if(istrue(self._id_788DDF5CE6DE796A)) {
    _id_85E5C0853898D9FA = distancesquared(self.origin, _id_BF1B72D688BC972D);
    _id_21B0311D64CADFA2 = getdvarfloat("dvar_F513A728E552C054", 600);
    _id_6025F24941184817 = squared(_id_21B0311D64CADFA2);
    _id_A9713EFB7E160A71 = vectortoangles(target_ent getshootatpos() - self getshootfrompos());
    _id_4D6B30F5BB963B6B = self getmuzzleangle();
    _id_BB5B91EFDED663B2 = abs(angleclamp180(_id_A9713EFB7E160A71[0] - _id_4D6B30F5BB963B6B[0]));

    if(_id_BB5B91EFDED663B2 > 8 && _id_85E5C0853898D9FA < _id_6025F24941184817) {
      if(!isDefined(self._id_0F577A439EAE7554) || self._id_0F577A439EAE7554 > gettime()) {
        self._id_88710E546EA60EB3 = 0;
        self._id_0F577A439EAE7554 = gettime() + 10000;
      }

      if(!isDefined(self._id_C0F027481D84B560) || distancesquared(target_ent.origin, self._id_C0F027481D84B560) < _id_6025F24941184817) {
        _id_9F9E2C71F3F694DF = _func_767CEA82B001F645(self.origin - target_ent.origin);
        self._id_C0F027481D84B560 = getclosestpointonnavmesh(target_ent.origin + _id_21B0311D64CADFA2 * _id_9F9E2C71F3F694DF);
      }

      _id_F33F587E225DE2AF = self._id_C0F027481D84B560;
      self._id_1132BCDF45CB69F5 = 1;
    } else {
      _id_F33F587E225DE2AF = self.origin;
      self._id_1132BCDF45CB69F5 = undefined;
    }
  }

  return _id_F33F587E225DE2AF;
}

_id_F80179D793B1D373(target_ent, _id_F33F587E225DE2AF) {
  if(istrue(self._id_1132BCDF45CB69F5)) {
    return;
  }
  _id_9BCDD559A1C9E6EF = self pathdisttogoal();
  _id_4A2DA5670D3D99A3 = distance(self.origin, target_ent.origin);
  _id_E11D177570425CD3 = 2 * _id_4A2DA5670D3D99A3;

  if(_id_4A2DA5670D3D99A3 < 600 && _id_4A2DA5670D3D99A3 > self._id_4BBA3A58F389E465 && self canshootenemy() && _id_9BCDD559A1C9E6EF > _id_E11D177570425CD3) {
    self._id_788DDF5CE6DE796A = 1;
    self clearpath();
    self _meth_E64EA2B4E79C4B74(3);
  }
}

_id_5213D881F2E26966(_id_4B091DCA55A95A42, _id_ACBD19D69E515DD9, _id_5380FD355475C5CF) {
  self._id_D375AD59185E776F = level.stealth.hunt_volumes[_id_ACBD19D69E515DD9];
  self._id_0B5C268FD0721F06 = level.stealth.hunt_volumes[_id_5380FD355475C5CF];
  _id_4B091DCA55A95A42 = getclosestpointonnavmesh(_id_4B091DCA55A95A42, self);

  if(!isDefined(_id_4B091DCA55A95A42)) {
    return;
  }
  self._id_4B091DCA55A95A42 = _id_4B091DCA55A95A42;
  self._id_1FB8CEE5F3E1B38B = 1;
}

_id_B46325ABAE5AD373() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    waitframe();

    if(!istrue(self._id_1FB8CEE5F3E1B38B)) {
      continue;
    }
    if(_id_9708FD4CF9C695EF()) {
      self notify("out_of_bounds");
      thread _id_F05A1A8592BFFDD3("bio_bunker_boss_rusher_combat_disengage");
      self._id_0D4AE052F5BDA013 = 0;

      if(isDefined(self.enemy) && isPlayer(self.enemy)) {
        _id_AC4C51BF033F6323 = scripts\mp\utility\teams::getteamdata(self.enemy.team, "players");
        _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("biobunker_boss_rusher_recharging", _id_AC4C51BF033F6323);
      }

      scripts\asm\asm_bb::bb_clearmeleerequest();
      scripts\asm\asm_bb::bb_setisincombat(0);

      if(isalive(self._id_EB06BE12D8E1D936))
        self._id_EB06BE12D8E1D936 thread _id_E80CB8D105A264A9();

      self.stealth_enabled = 0;
      self._id_6BB7C58775BF5475 = 1;
      self.ignoreall = 1;
      self _meth_8A144CB1601C409A();
      self clearbtgoal(0);
      self clearbtgoal(1);
      self clearbtgoal(3);
      self setbtgoalpos(0, self._id_4B091DCA55A95A42);
      self setbtgoalpos(1, self._id_4B091DCA55A95A42);
      self setbtgoalRadius(0, 12);
      self setbtgoalRadius(1, 12);
      self aisetdesiredspeed(self._id_7AEBD48DA5B12133);
      _id_C3F0BA258D2B9698 = 0;

      for(;;) {
        msg = scripts\engine\utility::waittill_any_timeout_4(1, "goal", "bad_path", "goal_reached", "bt_goal");

        if(msg != "timeout") {
          if(msg == "bad_path") {}

          _id_C3F0BA258D2B9698 = 1;
        }

        if(self.helmethealth < self._id_CFC69E5588A5BED6 || self.armorhealth < self._id_8790C077C95DB752 || self.health < self.maxhealth) {
          self.helmethealth = int(min(self._id_CFC69E5588A5BED6, self.helmethealth + self._id_CFC69E5588A5BED6 * 0.1));
          self.armorhealth = int(min(self._id_8790C077C95DB752, self.armorhealth + self._id_8790C077C95DB752 * 0.1));
          self.health = int(min(self.maxhealth, self.health + self.maxhealth * 0.1));
          continue;
        }

        if(_id_C3F0BA258D2B9698 || distance(self.origin, self._id_4B091DCA55A95A42) <= 64) {
          break;
        }
      }

      self clearbtgoal(0);
      self clearbtgoal(1);
      self clearbtgoal(3);
      self.ignoreall = 0;
      self._id_6BB7C58775BF5475 = 0;
      self.stealth_enabled = 1;
      scripts\aitypes\stealth::_id_20BF793DE5175709("idle");
      self aisetdesiredspeed(self._id_F714DCBA7A0B7168);
      self _meth_E64EA2B4E79C4B74(4);

      for(;;) {
        msg = scripts\engine\utility::waittill_any_timeout_2(0.05, "damage", "sniper_damaged");
        players = _id_E58D7000A2C96232(self._id_D375AD59185E776F);

        if(players.size > 0 || msg == "damage" || msg == "sniper_damaged") {
          self clearbtgoal(4);
          break;
        }
      }
    }
  }
}

_id_9708FD4CF9C695EF() {
  if(!istrue(self._id_1FB8CEE5F3E1B38B))
    return 0;

  if(ispointinvolume(self.origin, self._id_0B5C268FD0721F06)) {
    players = _id_E58D7000A2C96232(self._id_0B5C268FD0721F06);

    if(players.size == 0) {
      if(distance(self.origin, self._id_4B091DCA55A95A42) > 64)
        return 1;
    }
  } else {
    players = _id_E58D7000A2C96232(self._id_D375AD59185E776F);

    if(players.size > 0) {
      players = scripts\engine\utility::array_randomize(players);

      if(isDefined(self.enemy) && players[0] != self.enemy) {
        self _meth_8A144CB1601C409A();
        self clearbtgoal(1);
        self clearbtgoal(3);
        self clearbtgoal(0);
        scripts\asm\asm_bb::bb_clearmeleerequest();
        scripts\asm\asm_bb::bb_setisincombat(0);
      }

      _id_23EAD74859674F83::_id_33555FFB3402A9B5(players[0]);
      return 0;
    } else
      return 1;
  }

  return 0;
}

_id_E58D7000A2C96232(volume) {
  players = [];

  foreach(player in level.players) {
    if(isalive(player) && ispointinvolume(player.origin, volume))
      players[players.size] = player;
  }

  return players;
}

_id_EB64334C4CC321C4(_id_ED330C2F0716E2FC) {
  self._id_5F9599E35CBD1BF0 = _id_ED330C2F0716E2FC;
  self._id_F8F0EAA8B59B9B59 = level._id_1608A5948A0BE98D["sniper_spawn_soldier_1"];
  self._id_FD229BE16AFA15DE = level._id_1608A5948A0BE98D["sniper_spawn_soldier_2"];
  self._id_F5DBE30B2FC6A4F3 = level._id_1608A5948A0BE98D["sniper_spawn_soldier_3"];
  level._id_0CE1FFC92CD6AEF3 = level._id_1608A5948A0BE98D["stairwell_reinforce"];
  level._id_9D03360DEB3006A0 = level._id_1608A5948A0BE98D["boss_spawn_point_1"];
  self._id_A4738C70736D3A61 = ::_id_0B83014D3BB0F306;
  self._id_EF3BFD0243258E2F = 1;
  _id_1AB711F2A850D248("brloot_weapon_sn_alpha50_lege_biobunker");
  _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(self, "dropWeapon", 0);
  _id_48814951E916AF89::_id_63A043D47490F90D(self, "brloot_weapon_sn_alpha50_lege_biobunker", undefined, 1, 1);
  _id_48814951E916AF89::_id_63A043D47490F90D(self, "brloot_weapon_sm_mpapa5_lege_biobunker", undefined, 1, 1);
}

_id_0B83014D3BB0F306(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon) {
  _id_47FC06D4BB326007::_id_1AB798A528080DB2(einflictor, eattacker, int(idamage), idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon);

  if(isDefined(self._id_5F9599E35CBD1BF0))
    self._id_5F9599E35CBD1BF0 notify("sniper_damaged");
}

_id_001E6F0A208354FE(_id_ED330C2F0716E2FC) {
  level endon("game_ended");
  self endon("death");
  _id_EB64334C4CC321C4(_id_ED330C2F0716E2FC);
  thread _id_7AFF1F5E65A781D7();
  self._id_C57D794B6C67E607 = self.maxhealth + self._id_8790C077C95DB752 + self._id_CFC69E5588A5BED6;
  self._id_A51512C2048AB572 = self._id_C57D794B6C67E607 * 0.8;
  self._id_28E58EEEC08D4E31 = self._id_CFC69E5588A5BED6 * 0.8;
  self _meth_E64EA2B4E79C4B74(4);
  scripts\engine\utility::waittill_any_2("damage", "start_combat");
  self clearbtgoal(4);
  self._id_5F9599E35CBD1BF0 notify("start_combat");
  _id_BB7CDAD3061D6144();
  _id_FC3D4A40F9EC5E28();
}

_id_E80CB8D105A264A9() {
  level endon("game_ended");
  self endon("death");
  self._id_5F9599E35CBD1BF0 endon("death");
  node = sortbydistance(level._id_36C35402E710F1AC, self.origin)[0];

  while(!_id_531DBCA2F9AB1BAD(node.origin, 64))
    wait 1;

  self allowedstances("crouch");
  wait 5;
  self allowedstances("stand");
  self forcethreatupdate();
}

_id_BB7CDAD3061D6144() {
  thread _id_BB9AD577CECEE13E();
  _id_D1F90EAA6B0D3E17();
}

_id_FC3D4A40F9EC5E28() {
  thread _id_E2213295A8B04A60();
  thread _id_B238FA1A81EC966B();
  thread _id_5A206A9BF4918C94();
  thread _id_8ACF93A7FA858A06();
  _id_5A08D9E4D3719240();
  _id_1AB711F2A850D248("brloot_weapon_sm_mpapa5_lege_biobunker");
  level._id_BAD48E44807A965E = undefined;
}

_id_531DBCA2F9AB1BAD(pos, radius) {
  scripts\stealth\enemy::bt_set_stealth_state("combat");
  self._id_B43F6CAD28078A05 = 1;
  self.ignoreall = 1;
  self.stealth_enabled = 0;
  self._id_5323A94889EFF1DE = 1;
  pos = _id_120270BD0A747A35::_id_61CBC488B27A6E61(pos);
  self _meth_8A144CB1601C409A();
  self clearbtgoal(0);
  self clearbtgoal(1);
  self clearbtgoal(3);
  self setbtgoalpos(0, pos);
  self setbtgoalpos(1, pos);
  self setbtgoalRadius(0, radius);
  self setbtgoalRadius(1, radius);
  _id_120270BD0A747A35::_id_304DA84D9A815C01(pos, radius, 1);
  _id_8C7592E5AA2C8445 = 0;

  for(;;) {
    msg = scripts\engine\utility::waittill_any_timeout_4(15, "goal", "bad_path", "goal_reached", "bt_goal");

    if(msg == "bt_goal") {
      self clearbtgoal(0);
      self clearbtgoal(1);
      self clearbtgoal(3);
    }

    _id_8C7592E5AA2C8445 = distance(self.origin, pos) < radius;

    if(_id_8C7592E5AA2C8445 || msg == "bad_path") {
      break;
    }
  }

  self.ignoreall = 0;
  self.stealth_enabled = 1;
  self._id_5323A94889EFF1DE = 0;
  return _id_8C7592E5AA2C8445;
}

_id_D1F90EAA6B0D3E17() {
  level endon("game_ended");
  self endon("death");
  _id_7E61F1F88B1D002B = getdvarint("dvar_A3396C01025102F1", 99);
  _id_39344E19F5A967D5 = 5;
  _id_FBB9751E34302E44 = _id_7E61F1F88B1D002B;

  while(isalive(self._id_5F9599E35CBD1BF0)) {
    if(_id_FBB9751E34302E44 > 0 && _id_1577A972C5C45972()) {
      node = sortbydistance(level._id_36C35402E710F1AC, self.origin)[0];

      while(!_id_531DBCA2F9AB1BAD(node.origin, 64))
        wait 1;

      self allowedstances("crouch");
      wait(_id_39344E19F5A967D5);
      _id_E1F85754606F0015();
      self.helmethealth = self._id_CFC69E5588A5BED6;
      self.armorhealth = self._id_8790C077C95DB752;
      self.health = self.maxhealth;
      _id_FBB9751E34302E44 = _id_FBB9751E34302E44 - 1;
      self allowedstances("stand");
      self forcethreatupdate();
    }

    scripts\engine\utility::waittill_any_timeout_1(1, "damage");
  }
}

_id_1577A972C5C45972() {
  _id_10A3A1EFF7D055D2 = getdvarfloat("dvar_1D6D312E2B692F3A", 0.95);

  if(self.helmethealth <= self._id_CFC69E5588A5BED6 * _id_10A3A1EFF7D055D2 || self.health <= self.maxhealth * _id_10A3A1EFF7D055D2 || self.armorhealth <= self._id_8790C077C95DB752 * _id_10A3A1EFF7D055D2)
    return 1;

  return 0;
}

_id_BB9AD577CECEE13E() {
  level endon("game_ended");
  self endon("death");
  _id_7EC227003F7CD5BF = 60000;
  _id_D18B118289FCDE07 = gettime() - _id_7EC227003F7CD5BF;
  _id_A18FA89EA968D740 = gettime() - _id_7EC227003F7CD5BF;
  _id_D11AACDDCB136075 = [];
  _id_03CAA1546D28D002 = [];
  self._id_5F9599E35CBD1BF0 scripts\engine\utility::waittill_any_3("damage", "start_combat", "death");

  while(isalive(self._id_5F9599E35CBD1BF0)) {
    if(isDefined(self.enemy)) {
      _id_D11AACDDCB136075 = scripts\engine\utility::array_removedead(_id_D11AACDDCB136075);
      _id_03CAA1546D28D002 = scripts\engine\utility::array_removedead(_id_03CAA1546D28D002);

      if(_id_D11AACDDCB136075.size <= 0 && gettime() > _id_D18B118289FCDE07 + _id_7EC227003F7CD5BF) {
        _id_D11AACDDCB136075 = _id_F638D197A52EB2B9(self._id_F8F0EAA8B59B9B59, 1, 1, "stealthVolume_boss_arena_lv2");
        _id_D18B118289FCDE07 = gettime();
      }

      if(_id_03CAA1546D28D002.size <= 0 && gettime() > _id_A18FA89EA968D740 + _id_7EC227003F7CD5BF) {
        _id_03CAA1546D28D002 = _id_F638D197A52EB2B9(self._id_FD229BE16AFA15DE, 1, 1, "stealthVolume_boss_arena_lv2");
        _id_A18FA89EA968D740 = gettime();
      }
    }

    wait 1;
  }
}

_id_F638D197A52EB2B9(spawnpoints, numbers, _id_680350119921155C, _id_A1078A4990D909C2, _id_DCF5E15C58C4152A, destination) {
  team = "team_hundred_ninety_five";
  _id_171F90B9C4C76D44 = "biobunker_boss";
  array = [];

  if(!isDefined(_id_DCF5E15C58C4152A))
    _id_DCF5E15C58C4152A = "enemy_mp_ar_tier2_aq";

  foreach(point in spawnpoints) {
    if(numbers == 0) {
      break;
    }

    soldier = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(_id_DCF5E15C58C4152A, point.origin, (0, 0, 0), "medium", "reinforcements", "biolab", _id_A1078A4990D909C2, team, destination, _id_171F90B9C4C76D44, undefined, undefined, 0, undefined);

    if(istrue(_id_680350119921155C))
      soldier _id_701449195235BE31::_id_7B3877AFD4D12BC9("flashlight_box02");

    array[array.size] = soldier;
    numbers--;
  }

  return array;
}

_id_B238FA1A81EC966B() {
  level endon("game_ended");
  self endon("death");
  self endon("enter_1st_floor");

  for(;;) {
    currenthealth = self.health + self.armorhealth + self.helmethealth;

    if(self.helmethealth <= self._id_28E58EEEC08D4E31) {
      self notify("get_certain_damage");
      self._id_A51512C2048AB572 = self._id_A51512C2048AB572 - self._id_C57D794B6C67E607 * 0.2;
      self._id_28E58EEEC08D4E31 = self._id_28E58EEEC08D4E31 - self._id_CFC69E5588A5BED6 * 0.2;
    } else if(currenthealth <= self._id_A51512C2048AB572) {
      self notify("get_certain_damage");
      self._id_A51512C2048AB572 = self._id_A51512C2048AB572 - self._id_C57D794B6C67E607 * 0.2;
      self._id_28E58EEEC08D4E31 = self._id_28E58EEEC08D4E31 - self._id_CFC69E5588A5BED6 * 0.2;
    }

    self waittill("damage");
  }
}

_id_5A206A9BF4918C94() {
  level endon("game_ended");
  self endon("death");
  self endon("enter_1st_floor");
  _id_AFCC8C0CBE0D1A9A = 90000;

  for(;;) {
    players = _id_AE0ECFC8D3CED29A();

    if(players.size > 0) {
      _id_9DE16F5045AFF16D = distance2dsquared(sortbydistance(players, self.origin)[0].origin, self.origin);

      if(_id_9DE16F5045AFF16D < _id_AFCC8C0CBE0D1A9A) {
        self notify("player_nearby");
        self._id_A51512C2048AB572 = self._id_A51512C2048AB572 - self._id_C57D794B6C67E607 * 0.2;
        self._id_28E58EEEC08D4E31 = self._id_28E58EEEC08D4E31 - self._id_CFC69E5588A5BED6 * 0.2;
        wait 7;
      }
    }

    wait 1;
  }
}

_id_8ACF93A7FA858A06() {
  level endon("game_ended");
  self endon("death");
  volume = level.stealth.hunt_volumes["stealthVolume_boss_arena_lv2_part1"];

  for(;;) {
    if(ispointinvolume(self.origin, volume)) {
      self notify("enter_1st_floor");

      while(!_id_531DBCA2F9AB1BAD(level._id_BAD48E44807A965E[0].origin, 64))
        wait 1;

      break;
    }

    wait 1;
  }
}

_id_5A08D9E4D3719240() {
  level endon("game_ended");
  self endon("death");
  self endon("enter_1st_floor");
  self forcethreatupdate();
  _id_8389747AA1219810 = level._id_BAD48E44807A965E;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_8389747AA1219810.size; _id_AC0E594AC96AA3A8++) {
    _id_E1F85754606F0015();
    self clearbtgoal(4);
    _id_F97CD11D0E401D3D = _id_8389747AA1219810[_id_AC0E594AC96AA3A8].origin;

    while(!_id_531DBCA2F9AB1BAD(_id_F97CD11D0E401D3D, 64))
      wait 1;

    _id_A23B4829F786AF71();
    self _meth_E64EA2B4E79C4B74(4);
    self forcethreatupdate();

    if(_id_AC0E594AC96AA3A8 < _id_8389747AA1219810.size - 1)
      scripts\engine\utility::waittill_any_2("get_certain_damage", "player_nearby");
  }

  self clearbtgoal(4);
  scripts\stealth\enemy::bt_set_stealth_state("combat");
}

_id_1AB711F2A850D248(_id_878AB837C6FE40DF) {
  weapon = level.br_lootiteminfo[_id_878AB837C6FE40DF].fullweaponobj;

  if(isDefined(weapon)) {
    _id_B003E2C45A4BF6F7 = undefined;
    weaponname = undefined;

    if(isDefined(self.weapon)) {
      self takeweapon(self.weapon);
      weaponname = getcompleteweaponname(self.weapon);

      if(isDefined(self.weaponinfo[weaponname])) {
        _id_B003E2C45A4BF6F7 = self.weaponinfo[weaponname].position;
        self.weaponinfo = scripts\engine\utility::array_remove_key(self.weaponinfo, weaponname);
      }
    }

    self.weapon = weapon;
    scripts\common\utility::initweapon(self.weapon);
    _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(self, "weapon", weapon);
    self giveweapon(self.weapon);
    self setspawnweapon(self.weapon);
    self.bulletsinclip = weaponclipsize(self.weapon);
    self.primaryweapon = self.weapon;

    if(isDefined(self.a.weaponpos[_id_B003E2C45A4BF6F7])) {
      weaponname = getcompleteweaponname(self.weapon);
      self.weaponinfo[weaponname].position = _id_B003E2C45A4BF6F7;
      self.a.weaponpos[_id_B003E2C45A4BF6F7] = weapon;
    }
  }
}

_id_AE0ECFC8D3CED29A() {
  aliveplayers = [];

  foreach(player in level.players) {
    if(isalive(player))
      aliveplayers[aliveplayers.size] = player;
  }

  return aliveplayers;
}

_id_A23B4829F786AF71() {
  players = _id_AE0ECFC8D3CED29A();

  if(players.size <= 0) {
    return;
  }
  self.favoriteenemy = sortbydistance(players, self.origin)[0];
}

_id_E1F85754606F0015() {
  forward = anglesToForward(self.angles);
  _id_2C04BF9A8CE4F0B2 = self.origin + anglesToForward(self.angles) * 5 + forward * 20 + (0, 0, 60);
  _id_56EBCB2D4FCB8071 = (0, 0, 200) + forward * randomfloatrange(1, 1.5);
  self launchgrenade("smoke_grenade_mp", _id_2C04BF9A8CE4F0B2, _id_56EBCB2D4FCB8071);
}

_id_7EBBF93BFB319A7E() {
  if(!istrue(level._id_9267300EFA308E9F)) {
    if(isDefined(level._id_50DEA76F9F897841)) {
      level._id_50DEA76F9F897841 setscriptablepartstate("bunkerdoor_light", "opening", 0);
      wait 3;
      level._id_50DEA76F9F897841 setscriptablepartstate("bunkerdoor_light", "open_with_sound", 0);
    }

    foreach(door in level._id_F64C6EF6F688A407) {
      if(isDefined(door._id_8F7EDDC9C0864A1B)) {
        if(issubstr(door._id_8F7EDDC9C0864A1B, "stairwell_worn"))
          door _meth_80902296B05BE00A();
      }
    }

    level._id_9267300EFA308E9F = 1;
  }
}

_id_1AA55FC8E786E252() {
  level endon("game_ended");
  level waittill("rusherIsKilled");
  _id_7EBBF93BFB319A7E();
  _id_1047A207E101159E = _id_F638D197A52EB2B9(self._id_0CE1FFC92CD6AEF3, 4, 0, "stealthVolume_boss_arena_lv1", "enemy_mp_ar_tier2_aq", self._id_9D03360DEB3006A0[0].origin);

  foreach(soldier in _id_1047A207E101159E)
  soldier thread _id_120270BD0A747A35::_id_A5117518725DA028(soldier, self._id_9D03360DEB3006A0[0].origin, 0, 500, undefined, undefined, undefined, undefined, _id_2D9C29F869A29FCA::_id_CEE3B39981879330);
}

_id_E2213295A8B04A60() {
  level endon("game_ended");
  self endon("death");
  self endon("enter_1st_floor");
  trigger = getEnt("boss_arena_entrance_1", "script_noteworthy");
  trigger waittill("trigger", player);
  _id_F638D197A52EB2B9(self._id_F8F0EAA8B59B9B59, 3, 0, "stealthVolume_boss_arena_lv2_part2");
  self._id_80CDE7832E71CA96 = 1;
  thread _id_40AB366C7015CB72();
  trigger = getEnt("boss_arena_entrance_2", "script_noteworthy");
  trigger waittill("trigger", player);
  _id_F638D197A52EB2B9(self._id_F8F0EAA8B59B9B59, 3, 0, "stealthVolume_boss_arena_lv2_part2");
  thread _id_40AB366C7015CB72();
  trigger = getEnt("boss_arena_entrance_3", "script_noteworthy");
  trigger waittill("trigger", player);
  _id_F638D197A52EB2B9(self._id_FD229BE16AFA15DE, 3, 0, "stealthVolume_boss_arena_lv2_part3");
  thread _id_40AB366C7015CB72();
  trigger = getEnt("boss_arena_entrance_4", "script_noteworthy");
  trigger waittill("trigger", player);
  _id_F638D197A52EB2B9(self._id_FD229BE16AFA15DE, 4, 0, "stealthVolume_boss_arena_lv2_part4");
  _id_F638D197A52EB2B9(self._id_F5DBE30B2FC6A4F3, 2, 0, "stealthVolume_boss_arena_lv2_part4", "enemy_mp_rpg_tier3_aq");
  thread _id_40AB366C7015CB72();
}

_id_40AB366C7015CB72() {
  level endon("game_ended");
  self endon("death");
  self endon("enter_1st_floor");

  if(self._id_80CDE7832E71CA96) {
    thread _id_F05A1A8592BFFDD3("bio_bunker_boss_sniper_player_reinforcement_coming");
    self._id_80CDE7832E71CA96 = 0;
    wait 7;
    self._id_80CDE7832E71CA96 = 1;
  }
}

_id_F2AC7C7C22F85203(instance, player) {
  if(!isDefined(player) || !isalive(player)) {
    return;
  }
  player._id_97145A4DEE744A09 = scripts\mp\objidpoolmanager::requestobjectiveid();

  if(player._id_97145A4DEE744A09 > -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(player._id_97145A4DEE744A09, "current", level._id_1608A5948A0BE98D["bunker_room_objective"].origin, "hud_icon_objective_lock", "icon_regular");
    objective_removeallfrommask(player._id_97145A4DEE744A09);
    objective_showtoplayersinmask(player._id_97145A4DEE744A09);
    objective_addteamtomask(player._id_97145A4DEE744A09, player.team);
    objective_setbackground(player._id_97145A4DEE744A09, 1);
    player thread _id_250D8C7F2BF38F94();
  }
}

_id_250D8C7F2BF38F94() {
  level endon("game_ended");
  id = self._id_97145A4DEE744A09;
  waitframe();

  while(isDefined(self) && _id_2D9D24F7C63AC143::_id_D63A7299C6203BF9(24696))
    waitframe();

  if(isDefined(id))
    scripts\mp\objidpoolmanager::returnobjectiveid(id);
}

_id_EA9FE955BAFEBA30() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("scriptables_ready");

  while(!isDefined(level.struct_class_names))
    waitframe();

  _id_C80FD34F7ADDF0D7 = scripts\engine\utility::getStruct("boss_stair_indicator", "script_noteworthy");
  _id_0E4118BDA122B112 = spawnscriptable("biobunker_bunkerdoor_light", _id_C80FD34F7ADDF0D7.origin, _id_C80FD34F7ADDF0D7.angles);
  level._id_50DEA76F9F897841 = _id_0E4118BDA122B112;
  level._id_50DEA76F9F897841 setscriptablepartstate("bunkerdoor_light", "activated", 0);
  level._id_9267300EFA308E9F = 0;
}

_id_85DC23401B46CF41() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    result = scripts\engine\utility::waittill_any_timeout_1(2, "damage");
    _id_3842297DFB74DBA3 = 0;

    if(result == "damage")
      _id_3842297DFB74DBA3 = _id_F05A1A8592BFFDD3("bio_bunker_boss_" + self._id_47BDE44B1ACEC603 + "_take_damage");
    else if(result == "timeout") {
      switch (self._id_FE5EBEFA740C7106) {
        case 2:
        case 1:
          _id_3842297DFB74DBA3 = _id_F05A1A8592BFFDD3("bio_bunker_boss_" + self._id_47BDE44B1ACEC603 + "_bark_combat");
          break;
        case 3:
          if(self._id_47BDE44B1ACEC603 == "sniper")
            _id_3842297DFB74DBA3 = _id_F05A1A8592BFFDD3("bio_bunker_boss_sniper_bark_combat");

          break;
        case 0:
          _id_3842297DFB74DBA3 = _id_F05A1A8592BFFDD3("bio_bunker_boss_" + self._id_47BDE44B1ACEC603 + "_bark_idle");
          break;
      }
    }

    if(_id_3842297DFB74DBA3)
      _id_3E3E41683DC1BCDD = randomintrange(10, 25);
    else
      _id_3E3E41683DC1BCDD = 2;

    wait(_id_3E3E41683DC1BCDD);
  }
}

_id_DBA40250206B75FA() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    self waittill("chase_enemy");
    _id_F05A1A8592BFFDD3("bio_bunker_boss_rusher_bark_combat");
    wait 15;
  }
}

_id_F05A1A8592BFFDD3(dialog) {
  level endon("game_ended");
  self endon("death");
  _id_CB3339ECE72DBDEB = game["dialog"][dialog];

  if(isDefined(_id_CB3339ECE72DBDEB) && !istrue(self._id_CB78EB299CDFDE4E)) {
    self._id_CB78EB299CDFDE4E = 1;
    self playSound(_id_CB3339ECE72DBDEB);
    length = lookupsoundlength(_id_CB3339ECE72DBDEB);
    wait(length / 1000 + 1.0);
    self._id_CB78EB299CDFDE4E = 0;
    return 1;
  }

  return 0;
}

_id_43324B71FF7E6CF7(params) {
  if(isDefined(self.attacker._id_47BDE44B1ACEC603))
    self.attacker _id_F05A1A8592BFFDD3("bio_bunker_boss_" + self.attacker._id_47BDE44B1ACEC603 + "_player_taken_down");
}