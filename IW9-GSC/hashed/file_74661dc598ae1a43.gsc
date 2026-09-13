/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_74661dc598ae1a43.gsc
***********************************************/

_id_FE852F92145C24A6() {
  _id_5BC86A57086A4774::_id_AC97A4F2AB8C2D53("combat", "tryAssignTask", ::_id_F5539669FAF51BC2);
  _id_5BC86A57086A4774::_id_AC97A4F2AB8C2D53("combat", "tryBindObjective", ::_id_F06F2A906262B65C);
}

_id_F5539669FAF51BC2(_id_17953215DD7C5F9B) {
  flag = _id_87E60ED6830D13BC(_id_17953215DD7C5F9B.info._id_1C9CB43BCF3EB16D);
  thread _id_D0F9D3A714C7A5E3(_id_17953215DD7C5F9B, flag);
}

_id_87E60ED6830D13BC(_id_1C9CB43BCF3EB16D) {
  switch (_id_1C9CB43BCF3EB16D) {
    case "kill":
      return "kill_player_";
    case "down":
      return "down_enemy_laststand_";
    default:
      return "post_damaged";
  }
}

_id_09B1529847DF228E(weapon, _id_17953215DD7C5F9B) {
  _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(weapon);
  group = _id_2669878CF5A1B6BC::weapongroupmap(_id_AB501F397D3CD312);
  _id_D20D8147D9D8F723 = "weapon_" + _id_17953215DD7C5F9B.info._id_1C9CB43BCF3EB16D;

  if(_id_17953215DD7C5F9B.info._id_1C9CB43BCF3EB16D == "any" || isDefined(group) && group == _id_D20D8147D9D8F723)
    return 1;
  else
    return 0;
}

_id_2BD81BB8EE30BED8(_id_A20AF37D85939806, attacker, victim) {
  _id_B58F81D02DE4280C = isDefined(attacker) && isPlayer(attacker) && attacker.team == _id_A20AF37D85939806;
  _id_7FBDC91EF38FA447 = isDefined(victim) && (isPlayer(victim) && victim.team != _id_A20AF37D85939806) || isagent(victim);
  return _id_B58F81D02DE4280C && _id_7FBDC91EF38FA447;
}

_id_6D92F87FF87FE83F(_id_17953215DD7C5F9B) {
  level endon("game_ended");
  _id_17953215DD7C5F9B endon("task_end");

  for(;;) {
    level waittill("post_player_damaged", inflictor, attacker, victim, damage, flags, meansofdeath, objweapon, _id_FCDF19E3CDD29669, point, dir, hitloc, offsettime, modelindex, part);

    if(_id_2BD81BB8EE30BED8(_id_17953215DD7C5F9B.team, attacker, victim) && _id_09B1529847DF228E(objweapon, _id_17953215DD7C5F9B))
      _id_5BC86A57086A4774::_id_89B8BCE3BAA45EDC(_id_17953215DD7C5F9B, damage);
  }
}

_id_C93E0A98F146B313(_id_17953215DD7C5F9B) {
  level endon("game_ended");
  _id_17953215DD7C5F9B endon("task_end");

  for(;;) {
    level waittill("post_veh_damaged", inflictor, attacker, victim, damage, objweapon);
    _id_6BF87BCCA01F99EF = isDefined(attacker) && isPlayer(attacker) && attacker.team == _id_17953215DD7C5F9B.team;

    if(_id_6BF87BCCA01F99EF && _id_09B1529847DF228E(objweapon, _id_17953215DD7C5F9B))
      _id_5BC86A57086A4774::_id_89B8BCE3BAA45EDC(_id_17953215DD7C5F9B, damage);
  }
}

_id_D0F9D3A714C7A5E3(_id_17953215DD7C5F9B, flag) {
  level endon("game_ended");
  _id_17953215DD7C5F9B endon("task_end");
  _id_015AD24E2FBEEE5D = _id_17953215DD7C5F9B.info.ref;

  if(flag == "post_damaged") {
    thread _id_6D92F87FF87FE83F(_id_17953215DD7C5F9B);
    thread _id_C93E0A98F146B313(_id_17953215DD7C5F9B);
  } else {
    for(;;) {
      level waittill(flag + _id_17953215DD7C5F9B.team, attacker, victim);

      if(_id_2BD81BB8EE30BED8(_id_17953215DD7C5F9B.team, attacker, victim)) {
        switch (_id_015AD24E2FBEEE5D) {
          case "kill_crouch":
            if(attacker getstance() == "crouch") {
              break;
            }

            continue;
          case "kill_prone":
            if(attacker getstance() == "prone") {
              break;
            }

            continue;
          case "kill_hipfire":
            if(!attacker scripts\mp\utility\player::isplayerads()) {
              break;
            }

            continue;
          case "kill_ads":
            if(attacker scripts\mp\utility\player::isplayerads()) {
              break;
            }

            continue;
          default:
            break;
        }

        _id_5BC86A57086A4774::_id_89B8BCE3BAA45EDC(_id_17953215DD7C5F9B, 1);
      }
    }
  }
}

_id_C17DEE650B7CBCB2(_id_17953215DD7C5F9B, baseweapon) {
  _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(baseweapon);
  group = _id_2669878CF5A1B6BC::weapongroupmap(_id_AB501F397D3CD312);
  _id_D20D8147D9D8F723 = "weapon_" + _id_17953215DD7C5F9B.info._id_1C9CB43BCF3EB16D;
  return isDefined(group) && group == _id_D20D8147D9D8F723;
}

_id_F4EE103B33981325(_id_17953215DD7C5F9B) {
  foreach(weapon in self.equippedweapons) {
    baseweapon = weapon getbaseweapon();

    if(_id_C17DEE650B7CBCB2(_id_17953215DD7C5F9B, baseweapon))
      return 1;
  }

  return 0;
}

_id_59C1DBDC2AD03AD6(_id_17953215DD7C5F9B, loot) {
  if(!isDefined(loot))
    return 0;

  partname = loot _meth_EC5F4851431F3382();
  state = loot getscriptablepartstate(partname, 1);

  if(!isDefined(state) || state == "hidden")
    return 0;

  scriptablename = _id_7E52B56769FA7774::_id_155B1A2C8879BDA5(loot);

  if(!isDefined(scriptablename) || !_id_7E52B56769FA7774::isweaponpickup(scriptablename))
    return 0;

  baseweapon = tablelookup(level.brloottablename, 1, scriptablename, 8);

  if(baseweapon == "")
    return 0;

  return _id_C17DEE650B7CBCB2(_id_17953215DD7C5F9B, baseweapon);
}

_id_F06F2A906262B65C(_id_17953215DD7C5F9B) {
  _id_1C9CB43BCF3EB16D = _id_17953215DD7C5F9B.info._id_1C9CB43BCF3EB16D;

  if(_id_1C9CB43BCF3EB16D == "kill" || _id_1C9CB43BCF3EB16D == "down" || _id_1C9CB43BCF3EB16D == "any")
    _id_6AC6C7E169458BC4(_id_17953215DD7C5F9B);
  else {
    if(_id_F4EE103B33981325(_id_17953215DD7C5F9B) || _id_59C1DBDC2AD03AD6(_id_17953215DD7C5F9B, self._id_AD30CE892002A2B2)) {
      _id_6AC6C7E169458BC4(_id_17953215DD7C5F9B);
      return;
    }

    items = getlootscriptablearrayinradius(undefined, undefined, self.origin, 20000);
    _id_5BC86A57086A4774::_id_2E55101FFD0D483C(_id_17953215DD7C5F9B, items, ::_id_59C1DBDC2AD03AD6);
  }
}

_id_B6974F3087E0FD6D() {
  bots = [];

  foreach(player in level.players) {
    if(isbot(player) && self.team != player.team)
      bots = scripts\engine\utility::array_add(bots, player);
  }

  return scripts\engine\utility::getclosest(self.origin, bots);
}

_id_6AC6C7E169458BC4(_id_17953215DD7C5F9B) {
  enemy = _id_B6974F3087E0FD6D();

  if(isDefined(enemy)) {
    _id_ED09715E306A1455 = spawnStruct();
    radius = _id_903927D7A35391D9(enemy.origin, self.origin);
    _id_ED09715E306A1455 scripts\cp_mp\utility\game_utility::_id_6B6B6273F8180522("Prop_Circle_Br", enemy.origin, radius);
    _id_ED09715E306A1455 scripts\cp_mp\utility\game_utility::_id_CFD53C8F6878014F(self);
    _id_B8ABADD2C4D56FD8 = spawnStruct();
    _id_B8ABADD2C4D56FD8.item = _id_ED09715E306A1455;
    _id_B8ABADD2C4D56FD8._id_17953215DD7C5F9B = _id_17953215DD7C5F9B;
    self._id_B8ABADD2C4D56FD8 = _id_B8ABADD2C4D56FD8;
    thread _id_9FC4575DE369DA94();
  }
}

_id_9FC4575DE369DA94() {
  self endon("disconnect");
  self._id_B8ABADD2C4D56FD8 endon("objective_removed");

  while(isDefined(self._id_B8ABADD2C4D56FD8)) {
    enemy = _id_B6974F3087E0FD6D();

    if(isDefined(enemy)) {
      _id_98C69318FC764BAA(self._id_B8ABADD2C4D56FD8.item, enemy.origin, self.origin);
      self._id_B8ABADD2C4D56FD8.item scripts\cp_mp\utility\game_utility::_id_6E148C8DA2E4DB13(enemy.origin);
    }

    wait 5.0;
  }
}

_id_903927D7A35391D9(_id_D59ED0E8C57E2DEF, _id_1925D24D0AE333E6) {
  _id_ADE6A63430209A68 = distance2d(_id_D59ED0E8C57E2DEF, _id_1925D24D0AE333E6);

  if(_id_ADE6A63430209A68 > 5000)
    return 3500;
  else if(_id_ADE6A63430209A68 > 2500)
    return 2000;
  else
    return 1500;
}

_id_98C69318FC764BAA(_id_ED09715E306A1455, _id_D59ED0E8C57E2DEF, _id_1925D24D0AE333E6) {
  radius = _id_903927D7A35391D9(_id_D59ED0E8C57E2DEF, _id_1925D24D0AE333E6);
  _id_ED09715E306A1455 scripts\cp_mp\utility\game_utility::_id_4584AD1C0E2C58EC(radius);
}