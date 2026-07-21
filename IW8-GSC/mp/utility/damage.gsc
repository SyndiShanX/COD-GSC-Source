/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\utility\damage.gsc
***********************************************/

get_damageable_player(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.isplayer = 1;
  var_2.isadestructable = 0;
  var_2.entity = var_0;
  var_2.damagecenter = var_1;
  return var_2;
}

get_damageable_sentry(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.isplayer = 0;
  var_2.isadestructable = 0;
  var_2.issentry = 1;
  var_2.entity = var_0;
  var_2.damagecenter = var_1;
  return var_2;
}

get_damageable_grenade(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.isplayer = 0;
  var_2.isadestructable = 0;
  var_2.entity = var_0;
  var_2.damagecenter = var_1;
  return var_2;
}

get_damageable_mine(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.isplayer = 0;
  var_2.isadestructable = 0;
  var_2.entity = var_0;
  var_2.damagecenter = var_1;
  return var_2;
}

get_damageable_player_pos(var_0) {
  return var_0.origin + (0, 0, 32);
}

get_damageable_grenade_pos(var_0) {
  return var_0.origin;
}

istacticaldamage(var_0, var_1) {
  if(!isDefined(var_0))
    return 0;

  if(!isDefined(var_1) || var_1 == "_encstr_A1ED0BA9FF84562B60BA073E83")
    return 0;

  switch (var_0.basename) {
    case "_encstr_BDC9145E757AAF080F8FF0B1DF4A81FD021F45488DC3":
    case "_encstr_8823119675DAFF897F878020BB99612B219D8F":
    case "_encstr_AA830D5B0B32A731FF4BE57F38FD73":
    case "_encstr_AC451696FDC2E7B36BDF407843AF093D9A251FADD789B35B":
      return 1;
    case "_encstr_84661447C3CBFCDDDB636EC17A098B7753F83A0F1859":
    case "_encstr_92EA0A290B32FF88A90170EB":
      return 0;
    default:
      return 0;
  }
}

isfmjdamage(var_0, var_1, var_2) {
  if(istrue(var_2) && unset_relic_dfa(var_0, var_1))
    return 1;

  var_3 = 0;

  if(isDefined(var_1) && scripts\engine\utility::isbulletdamage(var_1)) {
    var_4 = scripts\mp\utility\weapon::getweaponattachmentsbasenames(var_0);

    foreach(var_6 in var_4) {
      if(var_6 == "_encstr_841804CCB635" || var_6 == "_encstr_AB2C084B5F6E68BD22CB") {
        var_3 = 1;
        break;
      }
    }
  }

  return var_3;
}

unset_relic_dfa(var_0, var_1) {
  return var_0 _meth_87B6();
}

isheadshot(var_0, var_1, var_2) {
  if(!validshotcheck(var_1, var_2))
    return 0;

  return var_0 == "_encstr_81CC0586952C91" || var_0 == "_encstr_A6CC076A05751852B3";
}

istorsoshot(var_0, var_1, var_2) {
  if(!validshotcheck(var_1, var_2))
    return 0;

  return var_0 == "_encstr_9ABA05E87F4B70" || var_0 == "_encstr_952B0C65857BBFB80F9FC0B8A75A" || var_0 == "_encstr_9B7A0CF35815C3971660B7CF306B";
}

istorsouppershot(var_0, var_1, var_2) {
  if(!validshotcheck(var_1, var_2))
    return 0;

  return var_0 == "_encstr_9ABA05E87F4B70" || var_0 == "_encstr_952B0C65857BBFB80F9FC0B8A75A";
}

isupperbodyshot(var_0, var_1, var_2) {
  if(!validshotcheck(var_1, var_2))
    return 0;

  switch (var_0) {
    case "_encstr_8B970F1B56991DD758E4D6EB63ED77B239":
    case "_encstr_970110C3DBB4827401D972BD36B0A7CB1D45":
    case "_encstr_A9C30F63CA998ED716E4D67D5D1C0ECAE4":
    case "_encstr_8D9A10260457F8118F7ED3639F75A0BB9BDB":
    case "_encstr_9ABA05E87F4B70":
    case "_encstr_952B0C65857BBFB80F9FC0B8A75A":
    case "_encstr_8B1D10834BA13813E7693FB7D86B8BE80920":
    case "_encstr_BDF80F4495E9F3C9C1387AF15011FA4F83":
    case "_encstr_9B7A0CF35815C3971660B7CF306B":
      return 1;
  }

  return 0;
}

islowerbodyshot(var_0, var_1, var_2) {
  if(!validshotcheck(var_1, var_2))
    return 0;

  switch (var_0) {
    case "_encstr_8ECF0B734B47E3AB67AD07909B":
    case "_encstr_95E80A8D59CCD1F533DBED3A":
    case "_encstr_A91A1025A967F88DCF6A0971613BC8C83F2A":
    case "_encstr_8B1D10834BA13813E7693FB7D86B8BE80920":
    case "_encstr_BACF0FC17D8FB0A0BB52111E2A5F6CE022":
    case "_encstr_BDF80F4495E9F3C9C1387AF15011FA4F83":
      return 1;
  }

  return 0;
}

validshotcheck(var_0, var_1) {
  if(isDefined(var_1)) {
    if(isDefined(var_1.owner)) {
      switch (var_1.code_classname) {
        case "_encstr_97710C6B2DCD1BAF3AD54E4E598E":
        case "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0":
        case "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56":
          return 0;
      }
    }
  }

  switch (var_0) {
    case "_encstr_8D4E0A501FCB898912CB3FA3":
    case "_encstr_9B0D099AD3887D91252954":
    case "_encstr_B45C0E2DFF41B17F437FB870E733FBFF":
    case "_encstr_A1ED0BA9FF84562B60BA073E83":
    case "_encstr_8DED0A21C79B660BC7588981":
      return 0;
  }

  return 1;
}

islethalmeleeweapon(var_0, var_1, var_2, var_3) {
  if(var_3 != "_encstr_8DED0A21C79B660BC7588981")
    return 0;

  if(!isDefined(var_1) || !isPlayer(var_1))
    return 0;

  if(var_1 scripts\mp\heavyarmor::hasheavyarmor())
    return 0;

  if(!scripts\mp\utility\player::is_one_hit_melee_victim_allowed())
    return 0;

  if(scripts\mp\utility\weapon::isfistsonly(var_2.basename))
    return 0;

  if(scripts\mp\utility\weapon::update_health_bar_to_player(var_2))
    return 1;

  if(scripts\mp\utility\weapon::isknifeonly(var_2.basename))
    return 1;

  if(scripts\mp\utility\weapon::isballweapon(var_2))
    return 1;

  if(var_2.basename == "_encstr_8EFF1569EFC2D19BBDD98A026383F355508117FA27C0A2")
    return 1;

  if(scripts\mp\utility\weapon::isaxeweapon(var_2.basename) && var_0 getweaponammoclip(var_2) > 0)
    return 1;

  foreach(var_5 in var_2.attachments) {
    if(scripts\engine\utility::string_starts_with(var_5, "_encstr_B282081385F2F6B9B2D1") || scripts\engine\utility::string_starts_with(var_5, "_encstr_8ADE099C0BB74F1568A515"))
      return 1;
  }

  return 0;
}

attackerishittingteam(var_0, var_1) {
  if(isDefined(var_1) && isDefined(var_1.owner))
    var_1 = var_1.owner;

  if(!level.teambased)
    return 0;
  else if(!isDefined(var_1) || !isDefined(var_0))
    return 0;
  else if(!isDefined(var_0.team) || !isDefined(var_1.team))
    return 0;
  else if(var_0 == var_1)
    return 0;
  else if(scripts\mp\utility\game::getgametype() == "_encstr_AAE507E8423F63C163" && var_0.pers["_encstr_8AEF05472BC2D6"] == var_1.team && isDefined(var_1.teamchangedthisframe))
    return 0;
  else if(scripts\mp\utility\game::getgametype() == "_encstr_AAE507E8423F63C163" && var_0.pers["_encstr_8AEF05472BC2D6"] != var_1.team && isDefined(var_1.teamchangedthisframe))
    return 1;
  else if(isDefined(var_1.scrambled) && var_1.scrambled)
    return 0;
  else if(scripts\mp\utility\player::isplayerproxyagent(var_0, var_1))
    return 0;
  else if(isagent(var_0) && istrue(var_0._id_133D2))
    return 0;
  else if(isagent(var_0) && isDefined(var_0.owner) && var_0.owner == var_1)
    return 0;
  else if(var_0.team == var_1.team)
    return 1;
  else
    return 0;
}

_validateattacker(var_0) {
  if(isagent(var_0) && (!isDefined(var_0.isactive) || !var_0.isactive))
    return undefined;

  if(isagent(var_0) && !isDefined(var_0.classname))
    return undefined;

  return var_0;
}

_validatevictim(var_0) {
  if(!var_0 scripts\cp_mp\utility\player_utility::_isalive())
    return undefined;

  return var_0;
}

damage_should_ignore_blast_shield(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = scripts\cp_mp\utility\damage_utility::packdamagedata(var_0, var_1, undefined, var_2, var_3, var_4);

  if(!isexplosivedamagemod(var_3) && var_3 != "_encstr_9B0D099AD3887D91252954")
    return 1;

  if(var_3 == "_encstr_911B0C7DA090E9A7F799FD50DD48")
    return 1;

  if(var_3 == "_encstr_84670F0D974DCF124E3F7A931851A1FB9F")
    return 1;

  if(isDefined(var_0) && var_0 == var_1)
    return 1;

  if(var_1 scripts\cp_mp\utility\damage_utility::isstuckdamage(var_6))
    return 1;

  if(scripts\mp\utility\weapon::weaponignoresblastshield(var_2, var_5))
    return 1;

  if(level.gametype == "_encstr_B607038AAB" && isDefined(var_1) && istrue(var_1.isjuggernaut) && isDefined(var_4) && isDefined(var_4.vehiclename))
    return 1;

  return 0;
}

_radiusdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self radiusdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

radiusplayerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isDefined(var_9))
    var_9 = 0;

  var_10 = scripts\engine\trace::create_character_contents();
  var_11 = scripts\engine\trace::create_contents(0, 1, 1, 0, 1, 0);
  var_12 = [];

  foreach(var_14 in level.characters) {
    if(!isDefined(var_14)) {
      continue;
    }
    if(!var_14 scripts\cp_mp\utility\player_utility::_isalive()) {
      var_12[var_12.size] = var_14;
      continue;
    }

    if(var_9 && var_14 == var_5) {
      var_12[var_12.size] = var_14;
      continue;
    }

    if(level.teambased && var_14.team == var_5.team)
      var_12[var_12.size] = var_14;
  }

  var_16 = physics_querypoint(var_5.origin, var_2, var_10, var_12, "_encstr_A1C4111F40CF43E3EE0BC8E002C29B9E07FCA9");

  if(isDefined(var_16) && var_16.size > 0) {
    for(var_17 = 0; var_17 < var_16.size; var_17++) {
      var_18 = var_16[var_17]["_encstr_850E077B0BF30318B9"];
      var_19 = var_16[var_17]["_encstr_9138093063275CD9E27627"];
      var_20 = var_16[var_17]["_encstr_BD260953AA97E3F014279D"];

      if(!isDefined(var_18)) {
        continue;
      }
      var_21 = physics_raycast(var_0, var_20, var_11, undefined, 0, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11");

      if(isDefined(var_21) && var_21.size > 0) {
        continue;
      }
      var_22 = max(var_19, var_1) / var_2;
      var_23 = var_3 + (var_4 - var_3) * var_22;
      var_18 dodamage(var_23, var_0, var_5, var_6, var_7, var_8);
    }
  }
}

hashealthshield(var_0) {
  return isDefined(var_0) && isDefined(var_0.healthshield);
}

gethealthshielddamage(var_0) {
  return int(var_0 * self.healthshieldmod);
}

sethealthshield(var_0) {
  self.healthshield = 1;

  if(!isDefined(self.healthshieldmod))
    self.healthshieldmod = 1;

  var_0 = int(clamp(var_0, 0, 100));
  var_1 = (100 - var_0) / 100;

  if(var_1 < self.healthshieldmod)
    self.healthshieldmod = var_1;
}

clearhealthshield() {
  self.healthshield = undefined;
  self.healthshieldmod = undefined;
}

_suicide(var_0) {
  if(self.sessionstate != "_encstr_877508C1D8C22F2DDC3B") {
    return;
  }
  if(playershoulddofauxdeath(var_0) && !isDefined(self.fauxdead))
    thread scripts\mp\damage::playerkilled_internal(self, self, self, 10000, 0, "_encstr_AB590C99ED78875F650F3951034D", isundefinedweapon(), (0, 0, 0), "_encstr_8BBA05185F8B99", 0, 1116, 1);
  else if(!playershoulddofauxdeath(var_0) && !isDefined(self.fauxdead) && !isDefined(self.vehicle))
    self suicide();
}

_id_13966() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_A5D2156EE8DEE0C15646F5EACD96E6D9FA9359B5DED1CA");
  thread _id_13965();
}

_id_13965() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_9267112757831660F7B9E95040A75B5C60BD6A");
  self endon("_encstr_9267112757831660F7B9E95040A75B5C60BD6A");

  while(!scripts\mp\utility\player::isreallyalive(self) || self.sessionstate != "_encstr_877508C1D8C22F2DDC3B")
    waitframe();

  _suicide();
}

playershoulddofauxdeath(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  if(istrue(var_0) && scripts\mp\utility\player::isusingremote())
    return 1;

  if(isDefined(level.modeshoulddofauxdeathfunc) && self[[level.modeshoulddofauxdeathfunc]]())
    return 1;

  return 0;
}

isprojectiledamage(var_0) {
  var_1 = "_encstr_878D34DF77C511B0493C5C97D511E1582DC1475FD990B85581C506ABA1E13F109897B3CF253730152AAC0DA766217D18FD0FCF73BFC5";

  if(issubstr(var_1, var_0))
    return 1;

  return 0;
}

non_player_log_attacker_data(var_0, var_1) {
  if(var_0.damage == 0) {
    return;
  }
  if(!isDefined(var_1))
    var_1 = var_0.attacker;

  if(!isDefined(var_1) || !isPlayer(var_1)) {
    var_2 = var_0.inflictor;

    if(isDefined(var_2)) {
      if(isPlayer(var_2))
        var_1 = var_2;
      else
        var_1 = var_2.owner;
    } else
      var_1 = undefined;
  }

  if(!isDefined(var_1) || !isPlayer(var_1)) {
    return;
  }
  if(isDefined(self.owner)) {
    if(!scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_1))
      return;
  } else if(level.teambased && isDefined(self.team) && self.team == var_1.team) {
    return;
  }
  non_player_add_attacker_data(var_0, var_1);
}

non_player_add_attacker_data(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = var_0.attacker;

  var_2 = undefined;
  var_3 = non_player_get_attacker_data(var_1);

  if(!isDefined(var_3)) {
    var_3 = non_player_get_attacker_data(var_1, 1);
    var_2 = gettime();
  }

  var_3.damage = var_3.damage + var_0.damage;
  var_3.objweapon = var_0.objweapon;
  var_3.point = var_0.point;
  var_3.direction = var_0.direction_vec;
  var_3.partname = var_0.partname;
  var_3.meansofdeath = var_0.meansofdeath;
  var_3.lasttimedamaged = gettime();
  var_3.firsttimedamaged = scripts\engine\utility::ter_op(isDefined(var_2), var_2, var_3.firsttimedamaged);

  if(isDefined(var_1) && isPlayer(var_1) && !nullweapon(var_1 getcurrentprimaryweapon()))
    var_3.sprimaryweapon = createheadicon(var_1 getcurrentprimaryweapon());
  else
    var_3.sprimaryweapon = undefined;
}

non_player_get_attacker_data(var_0, var_1) {
  var_2 = undefined;

  if(!isDefined(self.attackerdata) && istrue(var_1))
    self.attackerdata = [];

  if(isDefined(self.attackerdata)) {
    var_3 = var_0.guid;

    if(isDefined(var_3)) {
      var_2 = self.attackerdata[var_3];

      if(isDefined(var_2)) {
        if(var_2.isvalid || level.teambased && var_0.team != var_2.team) {
          var_2 = undefined;
          self.attackerdata[var_3] = undefined;
        }
      }

      if(!isDefined(var_2) && istrue(var_1)) {
        var_2 = spawnStruct();
        var_2.attacker = var_0;
        var_2.team = var_0.team;
        var_2.guid = var_3;
        var_2.isvalid = 1;
        var_2.damage = 0;
        var_2.hitcount = 0;
        var_2.firsttimehit = gettime();
        self.attackerdata[var_3] = var_2;
      }
    }
  }

  return var_2;
}

non_player_clear_attacker_data() {
  self.attackerdata = undefined;
}

non_player_should_ignore_damage(var_0, var_1, var_2, var_3) {
  if(non_player_should_ignore_damage_signature(var_0, var_1, var_2, var_3))
    return 1;

  if(isDefined(var_1.basename)) {
    if(var_3 != "_encstr_8DED0A21C79B660BC7588981") {
      switch (var_1.basename) {
        case "_encstr_95D71524C4F171FB83E84B7380FB9FFB1F50EA5FB8F33B":
        case "_encstr_95C419518C324FF2C9585B5320E52127B178B0D53020BBB1977817":
        case "_encstr_A22812C4735AC7E2B64317C3CF560A3128DE7D0A":
          return 1;
      }
    }

    if(var_3 == "_encstr_A1ED0BA9FF84562B60BA073E83") {
      switch (var_1.basename) {
        case "_encstr_ACC40CC1F8A321601715CFBFE0EA":
        case "_encstr_81430B218B3F7018458997D78A":
        case "_encstr_9AAE0876FCB7603101DB":
        case "_encstr_92A70ABB8267F5E0D89F6351":
        case "_encstr_99410C4B48C39AB7D0CD95B769DB":
          return 1;
      }
    } else {
      switch (var_1.basename) {
        case "_encstr_B8D30758E3EE7827BA":
        case "_encstr_AD1414DCDC1683CD34DB8EF53B272BE65832CAAFDA0E":
        case "_encstr_AA45132A90AFC77D50D55D1FAD5847CFC7086172BB":
        case "_encstr_81931411E5B039F5EB6F052B97F3C90B617F7BAE0D18":
        case "_encstr_AC451696FDC2E7B36BDF407843AF093D9A251FADD789B35B":
        case "_encstr_AB0B1199B158CD0DAF76C9B2DC0B2395D7B683":
        case "_encstr_A98D0FF0185ABBC537DD8D30B807FF81C1":
          return 1;
      }
    }
  }

  return 0;
}

non_player_add_ignore_damage_signature(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.ignoredamageid))
    self.ignoredamageid = 0;

  if(!isDefined(self.ignoredamagesignatures))
    self.ignoredamagesignatures = [];

  var_4 = self.ignoredamageid;
  self.ignoredamageid++;

  if(isDefined(var_1) && isstring(var_1))
    var_1 = getcompleteweaponname(var_1);

  var_5 = spawnStruct();
  var_5.id = var_4;
  var_5.attacker = var_0;
  var_5.objweapon = var_1;
  var_5.inflictor = var_2;
  var_5.meansofdeath = var_3;
  var_5.checkattacker = isDefined(var_0);
  var_5.checkobjweapon = isDefined(var_1) && !nullweapon(var_1);
  var_5.checkinflictor = isDefined(var_2);
  var_5.checkmeansofdeath = isDefined(var_3);
  self.ignoredamagesignatures[var_4] = var_5;
  return var_4;
}

non_player_remove_ignore_damage_signature(var_0) {
  if(!isDefined(self.ignoredamagesignatures)) {
    return;
  }
  self.ignoredamagesignatures[var_0] = undefined;
}

non_player_clear_ignore_damage_signatures() {
  self.ignoredamagesignatures = undefined;
}

non_player_should_ignore_damage_signature(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.ignoredamagesignatures))
    return 0;

  if(isDefined(var_1) && isstring(var_1))
    var_1 = getcompleteweaponname(var_1);

  foreach(var_5 in self.ignoredamagesignatures) {
    if(!isDefined(var_5))
      return 0;

    if(var_5.checkattacker) {
      if(!isDefined(var_5.attacker)) {
        non_player_remove_ignore_damage_signature(var_5.id);
        continue;
      } else if(!isDefined(var_0))
        continue;
      else if(var_0 != var_5.attacker)
        continue;
    }

    if(var_5.checkobjweapon) {
      if(!isDefined(var_1) || nullweapon(var_1))
        continue;
      else if(var_1 != var_5.objweapon)
        continue;
    }

    if(var_5.checkinflictor) {
      if(!isDefined(var_5.inflictor)) {
        non_player_remove_ignore_damage_signature(var_5.id);
        continue;
      } else if(!isDefined(var_2))
        continue;
      else if(var_2 != var_5.inflictor)
        continue;
    }

    if(var_5.checkmeansofdeath) {
      if(!isDefined(var_3))
        continue;
      else if(var_3 != var_5.meansofdeath)
        continue;
    }

    return 1;
  }

  return 0;
}

islauncherdirectimpactdamage(var_0, var_1, var_2) {
  if(scripts\mp\utility\weapon::isaxeweapon(var_0))
    return 0;

  if(var_0.type != "_encstr_96390B3F9BB7FCA569EBAB6AD5")
    return 0;

  if(istrue(var_2) && var_0.isalternate && isDefined(var_0.underbarrel))
    return 0;

  return var_1 == "_encstr_A1ED0BA9FF84562B60BA073E83" || var_1 == "_encstr_84670F0D974DCF124E3F7A931851A1FB9F" || var_1 == "_encstr_911B0C7DA090E9A7F799FD50DD48";
}