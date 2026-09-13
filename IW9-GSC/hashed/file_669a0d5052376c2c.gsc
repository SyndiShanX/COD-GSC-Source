/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_669a0d5052376c2c.gsc
***********************************************/

_id_9813640FB9B49E46(bots) {
  if(!isDefined(bots)) {
    return;
  }
  _id_105033A3F589A207 = [];
  _id_7BB9679B97FFC9DF = [];
  _id_E80EF5B65C009B23 = [];

  foreach(bot in bots) {
    switch (bot.spawnpriority) {
      case "high":
        _id_105033A3F589A207 = scripts\engine\utility::array_add(_id_105033A3F589A207, bot);
        break;
      case "mid":
        _id_7BB9679B97FFC9DF = scripts\engine\utility::array_add(_id_7BB9679B97FFC9DF, bot);
        break;
      case "low":
        _id_E80EF5B65C009B23 = scripts\engine\utility::array_add(_id_E80EF5B65C009B23, bot);
        break;
      default:
        _id_7BB9679B97FFC9DF = scripts\engine\utility::array_add(_id_7BB9679B97FFC9DF, bot);
        break;
    }
  }

  _id_686DEDA65062AB0A(_id_105033A3F589A207, "high_priority_bots_spawned");
  thread _id_686DEDA65062AB0A(_id_7BB9679B97FFC9DF, "mid_priority_bots_spawned");
  thread _id_1484A2C2C40EFA4E(_id_E80EF5B65C009B23, "low_priority_bots_spawned");
}

_id_686DEDA65062AB0A(bots, _id_40EA91E2825FA07A) {
  if(!isDefined(bots[0])) {
    return;
  }
  foreach(bot in bots)
  _id_B7F44575CC09DED1(bot);

  if(isDefined(_id_40EA91E2825FA07A))
    level notify(_id_40EA91E2825FA07A);
}

_id_1484A2C2C40EFA4E(bots, _id_40EA91E2825FA07A) {
  if(!isDefined(bots[0])) {
    return;
  }
  level waittill("mid_priority_bots_spawned");

  foreach(bot in bots) {
    while(level.players.size >= level.maxclients)
      wait 5;

    _id_B7F44575CC09DED1(bot);
  }

  if(isDefined(_id_40EA91E2825FA07A))
    level notify(_id_40EA91E2825FA07A);
}

_id_B7F44575CC09DED1(bot) {
  bot._id_E0E1C48A5393D3D1 = _id_5F09F43B4AD28837(bot);

  for(_id_B50060A003DB9B92 = 1; !isDefined(bot._id_E0E1C48A5393D3D1) && _id_B50060A003DB9B92 <= 3; _id_B50060A003DB9B92++) {
    wait 3;
    bot._id_E0E1C48A5393D3D1 = _id_5F09F43B4AD28837(bot);
  }

  if(!isDefined(bot._id_E0E1C48A5393D3D1))
    return undefined;

  while(!isDefined(bot._id_E0E1C48A5393D3D1) || !isDefined(bot._id_E0E1C48A5393D3D1.sessionstate) || bot._id_E0E1C48A5393D3D1.sessionstate != "playing")
    waitframe();

  if(isDefined(bot._id_56ACA941817E8E68) && bot._id_56ACA941817E8E68)
    bot._id_E0E1C48A5393D3D1._id_56ACA941817E8E68 = 1;

  bot thread _id_F6354BDCD37EAD9F();
  level._id_DBF4D97004E64BD5._id_2D3EE106CE5EE967._id_B6A6D335D4F74DFF++;
  return bot;
}

_id_5F09F43B4AD28837(spawndata) {
  bot = undefined;
  bot = addbot(spawndata.name);

  if(!isDefined(bot))
    return undefined;

  _id_F4842A7333F0853B = spawnStruct();
  _id_F4842A7333F0853B.ready = 0;
  _id_F4842A7333F0853B.abort = 0;
  _id_F4842A7333F0853B.difficulty = spawndata.personality;

  if(spawndata.team == "ally")
    spawndata.team = level.player.team;

  bot scripts\mp\bots\bots::bot_set_loadout_class();
  bot scripts\mp\bots\bots::spawn_bot_latent(spawndata.team, undefined, _id_F4842A7333F0853B);
  waitframe();
  bot scripts\mp\teams::createoperatorcustomization(spawndata.operatorref[0], spawndata.operatorref[1]);
  bot _id_99F15ED7E124D086(bot.operatorcustomization.suit);
  bot._id_0FF97225579DE16A = bot._id_0FF97225579DE16A + (level._id_DBF4D97004E64BD5._id_2D3EE106CE5EE967._id_B6A6D335D4F74DFF + 1);
  return bot;
}

_id_F6354BDCD37EAD9F() {
  while(distance(self._id_E0E1C48A5393D3D1.origin, level._id_DBF4D97004E64BD5._id_2D3EE106CE5EE967._id_F9AA74B7F60CE767) > 200) {
    self._id_E0E1C48A5393D3D1 setOrigin(level._id_DBF4D97004E64BD5._id_2D3EE106CE5EE967._id_F9AA74B7F60CE767);
    waitframe();
  }

  self._id_E0E1C48A5393D3D1 _id_390C90207BAC8552();

  while(!self._id_E0E1C48A5393D3D1 isonground())
    waitframe();

  self._id_E0E1C48A5393D3D1 _id_23A85A6F3340BF6F::_id_67D00E6B876C5EE2(scripts\engine\utility::drop_to_ground(self.spawnposition, 10), self._id_6E4BEAAC52CE2B4A);

  if(!isDefined(self._id_F126CE05F58C4329) || !self._id_F126CE05F58C4329) {
    self._id_E0E1C48A5393D3D1 _id_553FB9972F5FCE8A();
    self._id_E0E1C48A5393D3D1 scripts\cp_mp\utility\player_utility::_id_379BB555405C16BB("ftue_bots::ftue_bots_placeBotOnSpawnPoint()");
    self._id_E0E1C48A5393D3D1 botsetflag("suspended", 1);
  }

  self._id_E0E1C48A5393D3D1.armorhealth = 0;
  self._id_E0E1C48A5393D3D1 takeallweapons();
  startingweapon = _id_2669878CF5A1B6BC::buildweapon(self.weapon, undefined, undefined, undefined, -1, undefined, undefined, undefined, 0);
  self._id_E0E1C48A5393D3D1 giveweapon(startingweapon);
  self._id_E0E1C48A5393D3D1 switchtoweapon(startingweapon);
  self._id_E0E1C48A5393D3D1 allowreload(0);
  self._id_E0E1C48A5393D3D1 _id_23A85A6F3340BF6F::_id_F83C33A014EE22FE();
}

_id_390C90207BAC8552() {
  self botsetflag("disable_movement", 1);
  self botsetflag("disable_attack", 1);
  self allowslide(0);
  self._id_4165728871D6465C = 0;
  self._id_BC97ABF5A86E403F = 0;
  self._id_77198B6DA7D57A45 = 0;
  self._id_95EE53CADEB45990 = 0;
  self botsetflag("ignore_nodes", 1);

  foreach(_id_A0185A724941F02F in self._id_3C59090EE220AB3D._id_F0A8822DCC782C9D._id_577F45571C039A54) {
    _id_A0185A724941F02F.enabled = 0;
    _id_A0185A724941F02F._id_10F0B5C52ECE08CE = 0;
  }
}

_id_553FB9972F5FCE8A() {
  if(isDefined(self) && isbot(self))
    scripts\cp_mp\utility\player_utility::_id_A593971D75D82113();
}

_id_03900FD4B3AAA045() {
  if(isDefined(self) && isbot(self))
    scripts\cp_mp\utility\player_utility::_id_6FB380927695EE76();
}

_id_931679C28A759F96(_id_57C7CAC27D98EAF7, style) {
  if(!isDefined(_id_57C7CAC27D98EAF7._id_E0E1C48A5393D3D1) || !isbot(_id_57C7CAC27D98EAF7._id_E0E1C48A5393D3D1)) {
    return;
  }
  _id_57C7CAC27D98EAF7._id_E0E1C48A5393D3D1 botsetflag("suspended", 0);
  _id_57C7CAC27D98EAF7._id_E0E1C48A5393D3D1 _id_03900FD4B3AAA045();
  _id_57C7CAC27D98EAF7._id_E0E1C48A5393D3D1 scripts\cp_mp\utility\player_utility::_id_985B0973F29DA4F8("ftue_bots::ftue_bots_botMakeEntrance()");

  if(getdvarint("dvar_957C4BDD53678C6F", 0) == 1) {
    _id_57C7CAC27D98EAF7._id_E0E1C48A5393D3D1 _id_23A85A6F3340BF6F::_id_67D00E6B876C5EE2(_id_57C7CAC27D98EAF7._id_E5C38BE28345C687["DEFAULT"][0]);
    _id_57C7CAC27D98EAF7._id_E0E1C48A5393D3D1 _id_9CD34CBD05A34BF2(_id_57C7CAC27D98EAF7._id_E5C38BE28345C687["DEFAULT"][1]);
    _id_57C7CAC27D98EAF7 _id_5827A66F9760A49D();
  } else {
    if(!isDefined(_id_57C7CAC27D98EAF7._id_E5C38BE28345C687) || !isDefined(_id_57C7CAC27D98EAF7._id_E5C38BE28345C687["DEFAULT"])) {
      return;
    }
    if(!isDefined(style)) {
      if(isDefined(_id_57C7CAC27D98EAF7._id_48F38761D158A6F8))
        style = _id_57C7CAC27D98EAF7._id_48F38761D158A6F8;
      else
        style = "default";
    }

    switch (style) {
      case "moving":
        _id_57C7CAC27D98EAF7 _id_F5CE7D12B7B279D3("DEFAULT", undefined, undefined, ::_id_5827A66F9760A49D, _id_57C7CAC27D98EAF7);
        break;
      case "shooting":
        _id_57C7CAC27D98EAF7 _id_F5CE7D12B7B279D3("DEFAULT", undefined, undefined, ::_id_5827A66F9760A49D, _id_57C7CAC27D98EAF7);
        wait 0.5;
        _id_57C7CAC27D98EAF7._id_E0E1C48A5393D3D1 _id_3500675D209F72A2(_id_57C7CAC27D98EAF7._id_81BC7FA5D77599D5);
        break;
      case "parachuting":
        if(isDefined(_id_57C7CAC27D98EAF7._id_D676E6AF83F5EB14))
          _id_57C7CAC27D98EAF7._id_E0E1C48A5393D3D1 _id_5A0202BCB9EE9AF6(_id_57C7CAC27D98EAF7._id_D676E6AF83F5EB14, _id_57C7CAC27D98EAF7._id_E5C38BE28345C687["DEFAULT"][0], _id_57C7CAC27D98EAF7._id_E5C38BE28345C687["DEFAULT"][1], ::_id_5827A66F9760A49D, _id_57C7CAC27D98EAF7);

        break;
      case "teleport":
        _id_57C7CAC27D98EAF7._id_E0E1C48A5393D3D1 _id_23A85A6F3340BF6F::_id_67D00E6B876C5EE2(_id_57C7CAC27D98EAF7._id_E5C38BE28345C687["DEFAULT"][0]);
        _id_57C7CAC27D98EAF7._id_E0E1C48A5393D3D1 _id_9CD34CBD05A34BF2(_id_57C7CAC27D98EAF7._id_E5C38BE28345C687["DEFAULT"][1]);
        _id_57C7CAC27D98EAF7 _id_5827A66F9760A49D();
        break;
      default:
        _id_57C7CAC27D98EAF7 _id_F5CE7D12B7B279D3("DEFAULT", undefined, undefined, ::_id_5827A66F9760A49D, _id_57C7CAC27D98EAF7);
        break;
    }
  }

  if(isDefined(_id_57C7CAC27D98EAF7._id_719183C83135CCBB) && _id_57C7CAC27D98EAF7._id_719183C83135CCBB) {
    return;
  }
  if(isDefined(level._id_DBF4D97004E64BD5._id_2D3EE106CE5EE967._id_3A288A67F7BDBC94))
    wait(level._id_DBF4D97004E64BD5._id_2D3EE106CE5EE967._id_3A288A67F7BDBC94);

  _id_57C7CAC27D98EAF7._id_E0E1C48A5393D3D1 scripts\mp\outline::hudoutline_add_channel_internal("ftue_enemies", 10, "outlinefill_nodepth_red");
  _id_57C7CAC27D98EAF7._id_E0E1C48A5393D3D1 scripts\mp\outline::hudoutline_enable_internal(level.player, "ftue_enemies");
}

_id_5827A66F9760A49D() {
  self._id_E0E1C48A5393D3D1 setCanDamage(1);

  if(isDefined(self.shootenabled) && self.shootenabled)
    self._id_E0E1C48A5393D3D1 _id_3500675D209F72A2(self._id_81BC7FA5D77599D5);

  if(isDefined(self._id_4165728871D6465C) && self._id_4165728871D6465C)
    self._id_E0E1C48A5393D3D1 _id_D5F96927E4CF615F();
}

_id_7AE554A22B6A36AE(position, speed, _id_851848D8246B14AA, _id_ABF8BCCF988C7D40, callback, _id_273CFBDE456AB2AF) {
  if(isDefined(self._id_4165728871D6465C))
    self._id_4165728871D6465C = 0;

  thread _id_D25BA7EDA1BF7272(position, speed, _id_851848D8246B14AA, _id_ABF8BCCF988C7D40, callback, _id_273CFBDE456AB2AF);
}

_id_D25BA7EDA1BF7272(position, speed, _id_851848D8246B14AA, _id_ABF8BCCF988C7D40, callback, _id_273CFBDE456AB2AF) {
  self notify("new_move_to_position");
  self endon("death_or_disconnect");
  self endon("new_move_to_position");
  targetposition = getclosestpointonnavmesh(position);
  _id_47BA56FE3A40BD49(0);

  if(isDefined(_id_851848D8246B14AA))
    _id_9CD34CBD05A34BF2(_id_851848D8246B14AA);
  else if(!isDefined(self._id_4165728871D6465C) || !self._id_4165728871D6465C)
    self._id_BC97ABF5A86E403F = 0;

  if(isDefined(speed)) {
    path = [];
    path = self findpath(self.origin, targetposition);
    self botclearscriptgoal();

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < path.size; _id_AC0E594AC96AA3A8++) {
      while(distance2d(self.origin, path[_id_AC0E594AC96AA3A8]) > 20) {
        direction = vectortoyaw(path[_id_AC0E594AC96AA3A8] - self.origin);
        self botsetscriptmove(direction, 0.1, speed);
        wait 0.1;
      }
    }

    self botclearscriptgoal();
  } else {
    result = "";
    _id_00821EABF92AE6D0 = 0;

    while(result != "goal") {
      self botclearscriptgoal();
      self botsetpathingstyle("scripted");
      self botsetscriptgoal(targetposition, 20, "objective");
      result = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();
      _id_00821EABF92AE6D0++;

      if(_id_00821EABF92AE6D0 > 3 && !self._id_4165728871D6465C) {
        _id_23A85A6F3340BF6F::_id_67D00E6B876C5EE2(position);
        result = "goal";
      }
    }
  }

  _id_47BA56FE3A40BD49(1);

  if(isDefined(_id_ABF8BCCF988C7D40))
    _id_9CD34CBD05A34BF2(_id_ABF8BCCF988C7D40);

  if(isDefined(callback)) {
    if(isDefined(_id_273CFBDE456AB2AF))
      _id_273CFBDE456AB2AF thread[[callback]]();
    else
      self thread[[callback]]();
  }

  return 1;
}

_id_F5CE7D12B7B279D3(_id_1DC862996A8F9B46, speed, _id_851848D8246B14AA, callback, _id_273CFBDE456AB2AF) {
  thread _id_A62362913CAEB1CD(_id_1DC862996A8F9B46, speed, _id_851848D8246B14AA, callback, _id_273CFBDE456AB2AF);
}

_id_A62362913CAEB1CD(_id_1DC862996A8F9B46, speed, _id_851848D8246B14AA, callback, _id_273CFBDE456AB2AF) {
  movement = self._id_E0E1C48A5393D3D1 _id_D25BA7EDA1BF7272(self._id_E5C38BE28345C687[_id_1DC862996A8F9B46][0], speed, _id_851848D8246B14AA, self._id_E5C38BE28345C687[_id_1DC862996A8F9B46][1]);

  if(!isDefined(movement) || !movement) {
    return;
  }
  self._id_E0E1C48A5393D3D1 _id_E333732833F72059(self._id_E5C38BE28345C687[_id_1DC862996A8F9B46][2]);

  if(isDefined(callback)) {
    if(isDefined(_id_273CFBDE456AB2AF))
      _id_273CFBDE456AB2AF thread[[callback]]();
    else
      self._id_E0E1C48A5393D3D1 thread[[callback]]();
  }
}

_id_5A0202BCB9EE9AF6(_id_FE4C0C27A524B5EE, _id_B8C8D1E68C6C9C94, _id_851848D8246B14AA, callback, _id_273CFBDE456AB2AF) {
  self setOrigin(_id_FE4C0C27A524B5EE);
  _id_47BA56FE3A40BD49(0);
  waitframe();
  self._id_38DF06A438DF2608 = _id_B8C8D1E68C6C9C94;
  thread _id_40E63DD222434655::parachute(0);

  while(self isonground() == 0)
    waitframe();

  wait 1;
  _id_F5CE7D12B7B279D3("DEFAULT", callback, _id_273CFBDE456AB2AF);
}

_id_D5F96927E4CF615F() {
  thread _id_A0FB5734F6CEF381();
}

_id_A0FB5734F6CEF381() {
  self notify("new_reposition_routine");
  self endon("death_or_disconnect");
  self endon("new_reposition_routine");
  self._id_4165728871D6465C = 1;

  while(self._id_4165728871D6465C) {
    wait(3 + randomfloat(3));
    _id_79EB2E15455A1646 = self.origin + (level.player.origin - self.origin) / 2;
    _id_6C53D859D582A421 = getrandomnavpoint(_id_79EB2E15455A1646, 800);
    _id_D25BA7EDA1BF7272(_id_6C53D859D582A421);
  }
}

_id_E333732833F72059(stance) {
  if(isbot(self))
    self botsetstance(stance);
}

_id_47BA56FE3A40BD49(value) {
  if(isbot(self))
    self botsetflag("disable_movement", value);
}

_id_9CD34CBD05A34BF2(target, time) {
  thread _id_32B581A67DC2FB4E(target, time);
}

_id_32B581A67DC2FB4E(target, time) {
  self notify("new_look_at_target");
  self endon("death_or_disconnect");
  self endon("new_look_at_target");

  if(!isDefined(time))
    time = 0.2;

  self._id_BC97ABF5A86E403F = 1;

  while(self._id_BC97ABF5A86E403F) {
    if(!isDefined(target)) {
      break;
    }

    if(isstring(target)) {
      switch (target) {
        case "Player":
          if(!isalive(level.player)) {
            return;
          }
          _id_EE802A36A349579D = level.player getEye() + (randomfloat(0), randomfloat(0), randomfloat(0));
          self botlookatpoint(_id_EE802A36A349579D, time, "script_forced");
          break;
        case "AllyBot_1":
          if(!isalive(level._id_DBF4D97004E64BD5._id_395082021DFC3AE9["stat_BC2F9FE0382C8188"]._id_E0E1C48A5393D3D1)) {
            return;
          }
          _id_EE802A36A349579D = level._id_DBF4D97004E64BD5._id_395082021DFC3AE9["stat_BC2F9FE0382C8188"]._id_E0E1C48A5393D3D1 getEye() + (randomfloat(0), randomfloat(0), randomfloat(0));
          self botlookatpoint(_id_EE802A36A349579D, time, "script_forced");
          break;
      }
    } else if(isvector(target))
      self botlookatpoint(target, time, "script_forced");
    else if(isent(target)) {
      if(!isalive(target)) {
        return;
      }
      self botlookatpoint(target.origin, time, "script_forced");
    }

    wait(time);
  }
}

_id_3500675D209F72A2(target) {
  thread _id_A3921EB2329446BE(target);
}

_id_A3921EB2329446BE(target) {
  self notify("new_shoot_routine");
  self endon("death_or_disconnect");
  self endon("new_shoot_routine");
  thread _id_32B581A67DC2FB4E(target);
  wait 1;
  self._id_77198B6DA7D57A45 = 1;

  while(self._id_77198B6DA7D57A45) {
    if(isstring(target)) {
      switch (target) {
        case "Player":
          if(!isalive(level.player)) {
            _id_3A31862196D98146("attack");
            return 1;
          }

          if(level.player sightconetrace(self getEye(), self) < 0) {
            wait 1;
            continue;
          }

          break;
        case "AllyBot_1":
          if(!isalive(level._id_DBF4D97004E64BD5._id_395082021DFC3AE9["stat_BC2F9FE0382C8188"]._id_E0E1C48A5393D3D1)) {
            _id_3A31862196D98146("attack");
            return 1;
          }

          if(level._id_DBF4D97004E64BD5._id_395082021DFC3AE9["stat_BC2F9FE0382C8188"]._id_E0E1C48A5393D3D1 sightconetrace(self getEye(), self) < 0) {
            wait 1;
            continue;
          }

          break;
      }
    } else if(isent(target)) {
      if(!isalive(target)) {
        _id_3A31862196D98146("attack");
        return 1;
      }

      if(target sightconetrace(self getEye(), self) < 0) {
        wait 1;
        continue;
      }
    } else
      return;

    _id_2F0AC1D536D130AD = 0.5 + randomfloat(2);
    thread _id_F37F04AA427D8F84("attack", _id_2F0AC1D536D130AD);
    wait(_id_2F0AC1D536D130AD + 1 + randomfloat(2));
  }
}

_id_A7FC1CE7540E5915(enemies) {
  thread _id_E6311310BBAAA193(enemies);
}

_id_E6311310BBAAA193(enemies) {
  self notify("new_combat_routine");
  self endon("death_or_disconnect");
  self endon("new_combat_routine");
  self._id_95EE53CADEB45990 = 1;

  while(self._id_95EE53CADEB45990) {
    _id_1E14956A236DA6D8 = undefined;

    foreach(enemy in enemies) {
      _id_D1BFF7E80776F894 = level._id_DBF4D97004E64BD5._id_C0271A486AA56405[_func_1823FF50BB28148D(enemy)]._id_E0E1C48A5393D3D1;

      if(!isDefined(_id_D1BFF7E80776F894) || !isalive(_id_D1BFF7E80776F894))
        continue;
      else
        _id_1E14956A236DA6D8 = _id_D1BFF7E80776F894;
    }

    if(!isDefined(_id_1E14956A236DA6D8))
      return 1;

    _id_3500675D209F72A2(_id_1E14956A236DA6D8);
    wait(3 + randomfloat(3));
  }
}

_id_D780D856D7D110A4(_id_A2251D463637F414, _id_8F20FB82370F5F68, _id_90B23EDBB5FCA35C, callback) {
  thread _id_DC9666B56DF67864(_id_A2251D463637F414, _id_8F20FB82370F5F68, _id_90B23EDBB5FCA35C, callback);
}

_id_DC9666B56DF67864(_id_A2251D463637F414, _id_8F20FB82370F5F68, _id_90B23EDBB5FCA35C, callback) {
  self endon("death_or_disconnect");

  if(isDefined(_id_90B23EDBB5FCA35C))
    scripts\cp_mp\execution::_giveexecution(_id_90B23EDBB5FCA35C);

  self._id_BC97ABF5A86E403F = 0;
  _id_B8BC5657B0D4DCF9 = vectorNormalize(anglesToForward(_id_A2251D463637F414 getplayerangles()));
  _id_E9B6877D9370D55C = _id_A2251D463637F414.origin - _id_B8BC5657B0D4DCF9 * 30;

  if(distance2d(self.origin, _id_E9B6877D9370D55C) > 20) {
    if(!isDefined(_id_8F20FB82370F5F68))
      _id_8F20FB82370F5F68 = 1;

    _id_D25BA7EDA1BF7272(_id_E9B6877D9370D55C, _id_8F20FB82370F5F68, _id_A2251D463637F414 getEye());
  }

  self botlookatpoint(_id_A2251D463637F414 getEye(), 1);
  self enableexecutionattack();

  while(!self isinexecutionattack()) {
    _id_F37F04AA427D8F84("melee", 3.0);
    wait 3;
  }

  while(self isinexecutionattack())
    waitframe();

  if(isDefined(callback))
    self thread[[callback]]();
}

_id_DEAFDBA8D60E4C3B(_id_71CB2F1FE7EF9720, _id_1FF1FA846AAF925E, _id_EA56D24BF7867C65, callback) {
  thread _id_C0C83D8B47029A95(_id_71CB2F1FE7EF9720, _id_1FF1FA846AAF925E, _id_EA56D24BF7867C65, callback);
}

_id_C0C83D8B47029A95(_id_71CB2F1FE7EF9720, _id_1FF1FA846AAF925E, _id_EA56D24BF7867C65, callback) {
  self endon("death_or_disconnect");
  _id_6ED3B68E54963174 = self getcurrentweapon();
  self takeallweapons();
  _id_25F632C5311F7107 = _id_2669878CF5A1B6BC::buildweapon("iw9_la_rpapa7", undefined, undefined, undefined, -1, undefined, undefined, undefined, 0);
  self giveweapon(_id_25F632C5311F7107);
  self givemaxammo(_id_25F632C5311F7107);
  self switchtoweapon(_id_25F632C5311F7107);

  if(distance2d(self.origin, _id_1FF1FA846AAF925E) > 20)
    _id_D25BA7EDA1BF7272(_id_1FF1FA846AAF925E);

  targetpos = _id_71CB2F1FE7EF9720.origin;

  if(!isDefined(targetpos))
    targetpos = (26816.8, -6044.07, 150.343);

  if(isDefined(_id_EA56D24BF7867C65) && isvector(_id_EA56D24BF7867C65))
    targetpos = targetpos + _id_EA56D24BF7867C65;

  _id_9CD34CBD05A34BF2(targetpos, 4);
  wait 0.5;
  _id_F37F04AA427D8F84("ads", 4);
  _id_4585999B9BC82F8F::_id_CDA6B5416805C105(level._id_DBF4D97004E64BD5.soundevents._id_CB50110314060044);
  wait 0.5;
  _id_71CB2F1FE7EF9720 _id_63002651C12F57E3::_id_4D84A1C381ECE6C0(callback);
  _id_F37F04AA427D8F84("attack", 2);
  wait 1.5;

  if(_id_71CB2F1FE7EF9720.health > 0)
    _id_71CB2F1FE7EF9720 _id_63002651C12F57E3::_id_B9A4D29F4BC73806(callback);

  self takeallweapons();
  self giveweapon(_id_6ED3B68E54963174);
  self givemaxammo(_id_6ED3B68E54963174);
  self switchtoweapon(_id_6ED3B68E54963174);
}

_id_F37F04AA427D8F84(_id_0BAA0B8D939A551B, time) {
  self botpressbutton(_id_0BAA0B8D939A551B, time);
}

_id_3A31862196D98146(_id_0BAA0B8D939A551B) {
  self botclearbutton(_id_0BAA0B8D939A551B);
}

_id_99F15ED7E124D086(_id_ACD43AAE173CBA08) {
  bot = self;

  if(isDefined(bot.suit) && bot.suit == _id_ACD43AAE173CBA08) {
    return;
  }
  bot setsuit(_id_ACD43AAE173CBA08);
  bot.suit = _id_ACD43AAE173CBA08;
  bot _id_0CBB0697DE4C5728::_id_7C62C6C14ABA289B();
}