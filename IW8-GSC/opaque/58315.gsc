/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58315.gsc
***********************************************/

bot_allowed_to_try_last_loadout() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  waitframe();
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  level.are_all_hvts_eliminated = [];
  level.next_drone_cd = ::next_drone_cd;
  level.arena_bot_get_total_gun_ammo = getEntArray("_encstr_AC5014FA937067BC11178861E760C9FB0E682212D9BE", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\engine\utility::array_thread(level.arena_bot_get_total_gun_ammo, ::bot_affirm);
  level.spawnziptie = getdvarint("_encstr_8E401637C69CFA19B2CCC2BAD8D1EBB516E1853B59E68EDC", 15);
}

bot_affirm() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = self;

  for(;;) {
    var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(isagent(var_1)) {
      continue;
    }
    break;
  }

  var_2 = scripts\engine\utility::getStructArray(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = [];

  foreach(var_5 in var_2) {
    if(level.are_all_hvts_eliminated.size >= level.spawnziptie) {
      break;
    }

    if(getdvarint("_encstr_B80419FA96CDD9527BC1C7EFA9530953433E84F3851BD188219883", 0) == 1 && istrue(var_5._encstr_84F915B83FAFE32BC38666FB9BFB7B4EEB4B70D0E32D7B))
      var_6 = thread _testing_ending::_encstr_82F017C37BFB3B65E0678B7040137ED62AE87385A8FF8A3D93(var_5.origin, var_5.angles, 1, "_encstr_87FF21A892BB77E3CFDD8875BD3F0E2923F908B8C997AB3B3FC18060899B53EB8E62E0");
    else
      var_6 = thread _testing_ending::spawnnewagent(var_5.origin, var_5.angles, 1, "_encstr_87FF21A892BB77E3CFDD8875BD3F0E2923F908B8C997AB3B3FC18060899B53EB8E62E0");

    level.are_all_hvts_eliminated = scripts\engine\utility::array_add(level.are_all_hvts_eliminated, var_6);

    if(isDefined(var_5.script_noteworthy))
      var_6.script_noteworthy = var_5.script_noteworthy;

    var_6 bot_capture_koth_zone();
    var_6 bomb_detonator_bomb_type();
    var_3 = scripts\engine\utility::array_add(var_3, var_6);
    var_7 = getEnt(var_5.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(!isDefined(var_7)) {
      continue;
    }
    if(isDefined(var_6.script_noteworthy) && var_6.script_noteworthy == "_encstr_9730122421DC61D1EF7A401F80382B4081D88D67")
      var_6 blueprintcreatingteam(var_7);
    else {
      var_6 setgoalvolumeauto(var_7);

      if(isPlayer(var_1)) {
        var_6 agentsetfavoriteenemy(var_1);
        var_6 getenemyinfo(var_1);
      }
    }

    if(isDefined(level._id_11FFD) && isbuiltinfunction(level._id_11FFD))
      [[level._id_11FFD]](var_6, var_0);
  }
}

bot_capture_koth_zone() {
  self.guid = self getguid();
  self.name = self.guid;
  self.agentname = &"_encstr_A3CF1633A9D613B0CBE007CBC5ED39A79C898BCF914CB9E8";
  self.goalradius = randomintrange(100, 200);
  self.scripted_long_deaths = 0;
  self.agentdamagefeedback = 1;
  _testing_ending::_id_13122(0.5);
  _testing_ending::_id_13123(30);
  scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::_id_1349F("_encstr_83B20F81360389C45B1755530BF2AFD0B8", 2);
  thread boss_wave();
  thread bot_choose_attack_zone();

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "_encstr_8EFD0C67EB089A9BA09BEA53810E") {
    self allowedstances("_encstr_A5AD069B231F0BAF");
    thread boss_fight_combat();
  }

  thread blueprint_maxpermatch();
}

blueprintcreatingteam(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_9B1D0BC7932875276230426AA1");
  self cleargoalvolume();
  self setgoalpos(self.origin);
  thread bot_cache_entrances_to_zones(30.0);
  thread bonus_target_domage();
  scripts\engine\utility::_id_143AA("_encstr_91010E0AEFFA2995BBA97FC82AF23328", "_encstr_B2BE0788BAF573592F", "_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19", "_encstr_91CE0F3102DBEA5A50B550D0737DFA5FFA", "_encstr_995408F398012F656821", "_encstr_82480F0325083BD1D823F849B9E8E5535D");
  self notify("_encstr_85BB067A08A3FAB3");
  self setgoalvolumeauto(var_0);
}

bot_cache_entrances_to_zones(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_85BB067A08A3FAB3");
  wait(var_0);
  self notify("_encstr_995408F398012F656821");
}

bonus_target_domage() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_85BB067A08A3FAB3");

  for(;;) {
    var_0 = scripts\mp\utility\player::getplayersinradius(self.origin, 1000);

    if(var_0.size > 0) {
      self notify("_encstr_82480F0325083BD1D823F849B9E8E5535D");
      var_1 = scripts\engine\utility::random(var_0);
      self agentsetfavoriteenemy(var_1);
      self getenemyinfo(var_1);
      break;
    }

    wait 1;
  }
}

bomb_detonator_bomb_type() {
  if(!ispointonnavmesh(self.origin, self, 1)) {
    var_0 = getclosestpointonnavmesh(self.origin, self);

    if(isDefined(var_0))
      self forceteleport(var_0, self.angles);
  }
}

boss_wave() {
  var_0 = [];
  var_0["_encstr_82EA13A1FBB815B3686F507F12755D371C97F84A63"] = randomintrange(3000, 5000);
  var_0["_encstr_84D714386197BF9331AE78574CBB7F4513E0E251F861"] = randomintrange(3000, 5000);
  var_0["_encstr_93E714415B1637AD2FB0B229E82DE70B89A5ED27D15B"] = randomintrange(3000, 5000);
  var_0["_encstr_881D1914A4AFB1B77336D5CDB92DDBDCBE3B27959BB046CAFAB60E"] = randomintrange(3000, 5000);
  var_0["_encstr_81B7155EABAF23689028E793C1A9220AB5C79FCF0863CB"] = randomintrange(3000, 5000);
  var_0["_encstr_B47B0EB6FC377A8F1547F8C86BCF20E3"] = randomintrange(3000, 5000);
  var_0["_encstr_827F0D259877BE28A58C3B19BF8D48"] = randomintrange(3000, 5000);
  var_0["_encstr_B4BD0A2852BEB385E67DB683"] = randomintrange(2000, 4000);
  var_0["_encstr_AD5C12A052FAD9C26EFAEC9CCA9B58192BD75B0E"] = randomintrange(2000, 4000);
  scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::_id_134B1(var_0);
}

bot_choose_attack_zone() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_9B620D8F0DC07577C551F16A3826BF", var_0, var_1, var_2, var_3);

    if(!scripts\mp\utility\weapon::grenadethrown(var_0)) {
      continue;
    }
    scripts\mp\weapons::grenadeinitialize(var_0, var_1, var_2, var_3);
    self notify("_encstr_97E30EEC9359DC0B19ACBE47D027BDDD");

    if(!isDefined(var_0)) {
      return;
    }
    if(!isDefined(var_0.weapon_name)) {
      return;
    }
    var_0.spawnpos = var_0.origin;

    switch (var_0.weapon_name) {
      case "_encstr_BA730BF8AFF178988293F158B9":
        thread scripts\mp\equipment\molotov::molotov_used(var_0);
        break;
      case "_encstr_83B20F81360389C45B1755530BF2AFD0B8":
        thread scripts\mp\equipment\gas_grenade::gas_used(var_0);
        break;
    }
  }
}

boss_fight_combat() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    if(isDefined(self.enemy) && isPlayer(self.enemy) && (self.enemy isparachuting() || self.enemy isskydiving()))
      _testing_ending::_id_13122(0.2);

    _testing_ending::_id_13122(self.circleclosestarttime.baseaccuracy);
    wait 1;
  }
}

blueprint_maxpermatch() {
  self endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_AD75063D571AE108", var_0);
  level.are_all_hvts_eliminated = scripts\engine\utility::array_remove(level.are_all_hvts_eliminated, self);

  if(isDefined(var_0) && isPlayer(var_0)) {
    var_1 = "_encstr_ABD70578F3D02C";
    var_0 thread scripts\mp\rank::giverankxp(var_1, 100);
    var_0 thread scripts\mp\rank::scoreeventpopup(var_1);
  }

  var_2 = spawnStruct();
  var_2.origin = self.origin;
  var_2.angles = self.angles;
  var_2.dropstruct = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::test_ai_anim();
  var_2.itemsdropped = 0;
  var_2.heightoffset = 0;
  var_2 _encstr_AD8826DA61D6104B139FC638B11E4FFBD81533CB10979E651EB5412A3F700DC1FF6FB0580802461F::chooseandspawnitems(0, 1, "_encstr_B483058670B0B7");
  var_2.heightoffset = var_2.heightoffset + 3;
  var_2 _encstr_AD8826DA61D6104B139FC638B11E4FFBD81533CB10979E651EB5412A3F700DC1FF6FB0580802461F::chooseandspawnitems(1, 1, "_encstr_83A20883C6EA378C2B93");
  var_2.heightoffset = var_2.heightoffset + 3;
  var_3 = bonusobjectivescorecharge();
  var_4 = _encstr_AD8826DA61D6104B139FC638B11E4FFBD81533CB10979E651EB5412A3F700DC1FF6FB0580802461F::_id_11A41(var_3, var_2.dropstruct, var_2.origin, var_2.angles, 0, 1, 0);
  var_2.heightoffset = var_2.heightoffset + 3;
}

bonusobjectivescorecharge() {
  if(!isDefined(level.arena_bot_out_of_ammo))
    bot_br_circle_think();

  return scripts\engine\utility::random(level.arena_bot_out_of_ammo);
}

bot_br_circle_think() {
  level.arena_bot_out_of_ammo = [];
  level.arena_bot_out_of_ammo["_encstr_A1D01398E4C6BDED3AEB7B33330DB03746EBD9C29B"] = "_encstr_A1D01398E4C6BDED3AEB7B33330DB03746EBD9C29B";
  level.arena_bot_out_of_ammo["_encstr_91A915AE025A4778E4F7F848EB68718D02E19EA1DD422B"] = "_encstr_91A915AE025A4778E4F7F848EB68718D02E19EA1DD422B";
  level.arena_bot_out_of_ammo["_encstr_8D2A1562F0B930ED7CAFBFBB6D21171B7AD0F32C57EEF1"] = "_encstr_8D2A1562F0B930ED7CAFBFBB6D21171B7AD0F32C57EEF1";
  level.arena_bot_out_of_ammo["_encstr_AFA92636E3C8C752A5273F2F59415B14C0E96EFCFE80828A76635727B778C179B093628333105342"] = "_encstr_AFA92636E3C8C752A5273F2F59415B14C0E96EFCFE80828A76635727B778C179B093628333105342";
  level.arena_bot_out_of_ammo["_encstr_BED616F65A021F50CCCFF0E82BFCEB914B07FF8AF94BCB3B"] = "_encstr_BED616F65A021F50CCCFF0E82BFCEB914B07FF8AF94BCB3B";
  level.arena_bot_out_of_ammo["_encstr_84E81D13DB7CE0D743294557BB4A312EDF2F9BE0FF1B38FF6A4BC657567253"] = "_encstr_84E81D13DB7CE0D743294557BB4A312EDF2F9BE0FF1B38FF6A4BC657567253";
  level.arena_bot_out_of_ammo["_encstr_BA4719B06BCC7047D359B3CD2EAA895817BF08889F96C9092A3D3D"] = "_encstr_BA4719B06BCC7047D359B3CD2EAA895817BF08889F96C9092A3D3D";
  level.arena_bot_out_of_ammo["_encstr_960D1926A828D0072309D73F334716B668B5ED838190BFD3E277F3"] = "_encstr_960D1926A828D0072309D73F334716B668B5ED838190BFD3E277F3";
  level.arena_bot_out_of_ammo["_encstr_AC671D783B12B7EDC91F150ACC43E745DD41509F6150853097CBB3D0D3EFCD"] = "_encstr_AC671D783B12B7EDC91F150ACC43E745DD41509F6150853097CBB3D0D3EFCD";
}

next_drone_cd(var_0, var_1) {
  var_2 = var_1 * var_1;

  foreach(var_4 in level.are_all_hvts_eliminated) {
    if(!isDefined(var_4)) {
      continue;
    }
    if(distance2dsquared(var_4.origin, var_0) > var_2) {
      level.are_all_hvts_eliminated = scripts\engine\utility::array_remove(level.are_all_hvts_eliminated, var_4);
      var_4 dodamage(var_4.health, var_4.origin, var_4, undefined, "_encstr_B43E114DF4394751269B1FE77BCE299869FFB3");
    }
  }
}