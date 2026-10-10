/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\utility\damage.gsc
***********************************************/

#using script_3583ff375ab3a91e;
#using scripts\common\damage_effects;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\dragonsbreath;
#using scripts\cp_mp\utility\damage_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\damage;
#using scripts\mp\heavyarmor;
#using scripts\mp\supers\super_suppression_rounds;
#using scripts\mp\utility\game;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\player;
#using scripts\mp\utility\weapon;
#namespace damage;

function get_damageable_player(player, playerpos) {
  newent = spawnStruct();
  newent.isplayer = 1;
  newent.isadestructable = 0;
  newent.entity = player;
  newent.damagecenter = playerpos;
  return newent;
}

function get_damageable_sentry(sentry, sentrypos) {
  newent = spawnStruct();
  newent.isplayer = 0;
  newent.isadestructable = 0;
  newent.issentry = 1;
  newent.entity = sentry;
  newent.damagecenter = sentrypos;
  return newent;
}

function get_damageable_grenade(grenade, entpos) {
  newent = spawnStruct();
  newent.isplayer = 0;
  newent.isadestructable = 0;
  newent.entity = grenade;
  newent.damagecenter = entpos;
  return newent;
}

function get_damageable_mine(mine, entpos) {
  newent = spawnStruct();
  newent.isplayer = 0;
  newent.isadestructable = 0;
  newent.entity = mine;
  newent.damagecenter = entpos;
  return newent;
}

function get_damageable_player_pos(player) {
  return player.origin + (0, 0, 32);
}

function get_damageable_grenade_pos(grenade) {
  return grenade.origin;
}

function istacticaldamage(objweapon, smeansofdeath) {
  if(!isDefined(objweapon)) {
    return 0;
  }

  if(!isDefined(smeansofdeath) || smeansofdeath == "MOD_IMPACT") {
    return 0;
  }

  switch (objweapon.basename) {
    case #"hash_34e7a4cd11aed6bc":
    case #"hash_8d8f8ed9825eca03":
    case #"hash_d059dcc3a7f1308a":
    case #"hash_e3575fdd14663ca9":
      return 1;
    case #"hash_36d0be2b0f1c99e":
    case #"hash_5e3fa526a48eaaa5":
      return 0;
    default:
      return 0;
  }
}

function function_4766094b15b00a8(weapon, smeansofdeath, attacker) {
  var_27e27c2e96f2389d = 0;

  if(isbulletweapon(weapon)) {
    if(isDefined(attacker) && attacker scripts\cp_mp\utility\player_utility::player_hasperk("specialty_incendiary")) {
      var_27e27c2e96f2389d = 1;
    }

    if(isDefined(weapon) && scripts\cp_mp\dragonsbreath::function_cfd2e1e48edaf93(weapon)) {
      var_27e27c2e96f2389d = 1;
    }
  }

  return var_27e27c2e96f2389d;
}

function function_e287831520aa308b(weapon, attacker) {
  var_a167b7e09ac43f5e = 0;

  if(isbulletweapon(weapon)) {
    if(isDefined(attacker) && attacker scripts\cp_mp\utility\player_utility::player_hasperk("specialty_explosivebullet")) {
      var_a167b7e09ac43f5e = 1;
    }
  }

  return var_a167b7e09ac43f5e;
}

function isfmjdamage(weapon, smeansofdeath) {
  isfmj = 0;

  if(isDefined(weapon) && isDefined(smeansofdeath) && isbulletdamage(smeansofdeath)) {
    if(getweaponhasperk(weapon, "specialty_armorpiercing")) {
      isfmj = 1;
    }
  }

  return isfmj;
}

function function_73d1d5d600a0cbc3(smeansofdeath, attacker) {
  if(!isDefined(attacker) || !isPlayer(attacker)) {
    return false;
  }

  return isbulletdamage(smeansofdeath) && attacker scripts\mp\supers\super_suppression_rounds::function_1da49fb6441f8ab2();
}

function function_3201a1bc3ff0e482(attacker, victim, smeansofdeath, idflags) {
  var_30d384da73217e13 = function_73d1d5d600a0cbc3(smeansofdeath, attacker);

  if(istrue(var_30d384da73217e13)) {
    if(isPlayer(victim) || isagent(victim)) {
      if(scripts\cp_mp\armor::isbulletpenetration(idflags)) {
        return true;
      }

      if(isDefined(victim.vehicle)) {
        return true;
      }

      if(victim scripts\cp_mp\armor::hasarmor()) {
        return true;
      }

      if(istrue(victim.isjuggernaut)) {
        return true;
      }
    }
  }

  return false;
}

function islethalmeleeweapon(attacker, victim, objweapon, smeansofdeath) {
  if(smeansofdeath != "MOD_MELEE") {
    return false;
  }

  if(!isDefined(victim) || !isPlayer(victim)) {
    return false;
  }

  if(victim scripts\mp\heavyarmor::hasheavyarmor()) {
    return false;
  }

  if(!val::get("one_hit_melee_victim")) {
    return false;
  }

  if(isfistsonly(objweapon.basename)) {
    return false;
  }

  if(ismeleeoverrideweapon(objweapon)) {
    return true;
  }

  if(isknifeonly(objweapon.basename)) {
    return true;
  }

  if(isballweapon(objweapon)) {
    return true;
  }

  if(objweapon.basename == "iw8_defibrillator_mp") {
    return true;
  }

  if(isaxeweapon(objweapon.basename) && attacker getweaponammoclip(objweapon) > 0) {
    return true;
  }

  foreach(attachment in objweapon.attachments) {
    if(string_starts_with(attachment, "bayonet") || string_starts_with(attachment, "tacknife")) {
      return true;
    }
  }

  return false;
}

function attackerishittingteam(victim, attacker) {
  if(isDefined(attacker) && isDefined(attacker.owner)) {
    if(victim == attacker.owner && isDefined(attacker.streakinfo) && isDefined(attacker.streakinfo.streakname) && function_8728f7cf8c005a0(attacker.streakinfo.streakname)) {
      return 1;
    }

    attacker = attacker.owner;
  }

  if(!level.teambased) {
    return 0;
  }

  if(!isDefined(attacker) || !isDefined(victim)) {
    return 0;
  }

  if(!isDefined(victim.team) || !isDefined(attacker.team)) {
    return 0;
  }

  if(victim == attacker) {
    return 0;
  }

  if(scripts\cp_mp\utility\game_utility::isinfectedgametype() && victim.pers["team"] == attacker.team && isDefined(attacker.teamchangedthisframe)) {
    return 0;
  }

  if(scripts\cp_mp\utility\game_utility::isinfectedgametype() && victim.pers["team"] != attacker.team && isDefined(attacker.teamchangedthisframe)) {
    return 1;
  }

  if(isDefined(attacker.scrambled) && attacker.scrambled) {
    return 0;
  }

  if(isplayerproxyagent(victim, attacker)) {
    return 0;
  }

  if(isagent(victim) && istrue(victim.skipfriendlyfire)) {
    return 0;
  }

  if(isagent(victim) && isDefined(victim.owner) && victim.owner == attacker) {
    return 0;
  }

  if(namespace_ad49798629176e96::function_c210e62f0b64cfb1(attacker, victim)) {
    return 0;
  }

  if(victim.team == attacker.team) {
    return 1;
  }

  if(namespace_ad49798629176e96::function_9efae38238e4df66(attacker, victim)) {
    return 1;
  }

  if(function_7cc9753f2f84e883(attacker, victim)) {
    return 1;
  }

  return 0;
}

function function_7cc9753f2f84e883(eattacker, victim) {
  return isDefined(eattacker) && isDefined(victim) && isPlayer(eattacker) && isPlayer(victim) && isDefined(eattacker.var_3e8aeb2a9e8d86d6) && isDefined(victim.var_3e8aeb2a9e8d86d6) && eattacker.var_3e8aeb2a9e8d86d6 == victim.var_3e8aeb2a9e8d86d6;
}

function _validateattacker(eattacker) {
  if(isagent(eattacker)) {
    if(!istrue(eattacker.isactive)) {
      return undefined;
    }

    if(!isDefined(eattacker.classname)) {
      return undefined;
    }
  }

  return eattacker;
}

function _validatevictim(victim) {
  if(!victim scripts\cp_mp\utility\player_utility::_isalive()) {
    return undefined;
  }

  return victim;
}

function damage_should_ignore_blast_shield(attacker, victim, objweapon, smeansofdeath, inflictor, hitloc) {
  if(smeansofdeath == "MOD_GRENADE") {
    return true;
  }

  if(smeansofdeath == "MOD_PROJECTILE") {
    return true;
  }

  if((smeansofdeath == "MOD_FIRE" || isexplosivedamagemod(smeansofdeath)) == 0) {
    return true;
  }

  if(smeansofdeath == "MOD_EXPLOSIVE_BULLET" && (!isDefined(hitloc) || hitloc != "none")) {
    return true;
  }

  if(isDefined(attacker) && attacker == victim && !istrue(victim.var_567daf189be4de79)) {
    return true;
  }

  if(isDefined(attacker) && attacker ismutationgamemodezombie()) {
    return true;
  }

  data = scripts\cp_mp\utility\damage_utility::packdamagedata(attacker, victim, undefined, objweapon, smeansofdeath, inflictor);

  if(victim scripts\cp_mp\utility\damage_utility::isstuckdamage(data) && (!(isDefined(inflictor) && isDefined(inflictor.bundle)) || isDefined(inflictor) && isDefined(inflictor.bundle) && !istrue(inflictor.bundle.var_f09a1a099e0824ef))) {
    return true;
  }

  if(weaponignoresblastshield(objweapon, hitloc)) {
    return true;
  }

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype() && isDefined(victim) && istrue(victim.isjuggernaut) && isDefined(inflictor) && isDefined(inflictor.vehiclename)) {
    return true;
  }

  if(objweapon.var_9d7facbe889e667c == "jup_cp01_sh_aromeo410" && objweapon.modifier == "jup_ammo_410g_vortex") {
    return true;
  }

  if(objweapon.var_9d7facbe889e667c == "jup_jp35_sn_moscar" && objweapon.frontpiece == "jup_jp35_sn_moscar_bar_explode") {
    return true;
  }

  return false;
}

function _radiusdamage(origin, range, maxdamage, mindamage, attacker, meansofdeath, weapon) {
  self radiusdamage(origin, range, maxdamage, mindamage, attacker, meansofdeath, weapon);
}

function radiusplayerdamage(origin, minradius, maxradius, mindamage, maxdamage, attacker, inflictor, meansofdeath, weaponname, ignoreattacker) {
  assert(isDefined(origin) && isDefined(minradius) && isDefined(maxradius) && isDefined(mindamage) && isDefined(maxdamage) && isDefined(attacker) && isDefined(meansofdeath));

  if(!isDefined(ignoreattacker)) {
    ignoreattacker = 0;
  }

  var_f145a993614d298f = scripts\engine\trace::create_character_contents();
  castcontents = scripts\engine\trace::create_contents(0, 1, 1, 0, 1, 0);
  ignorelist = [];

  foreach(character in level.characters) {
    if(!isDefined(character)) {
      continue;
    }

    if(!character scripts\cp_mp\utility\player_utility::_isalive()) {
      ignorelist[ignorelist.size] = character;
      continue;
    }

    if(ignoreattacker && character == attacker) {
      ignorelist[ignorelist.size] = character;
      continue;
    }

    if(level.teambased && character.team == attacker.team) {
      ignorelist[ignorelist.size] = character;
    }
  }

  var_45724690f28d7899 = physics_querypoint(attacker.origin, maxradius, var_f145a993614d298f, ignorelist, "physicsquery_all");

  if(isDefined(var_45724690f28d7899) && var_45724690f28d7899.size > 0) {
    for(i = 0; i < var_45724690f28d7899.size; i++) {
      ent = var_45724690f28d7899[i]["entity"];
      dist = var_45724690f28d7899[i]["distance"];
      point = var_45724690f28d7899[i]["position"];

      if(!isDefined(ent)) {
        continue;
      }

      castresults = physics_raycast(origin, point, castcontents, undefined, 0, "physicsquery_closest");

      if(isDefined(castresults) && castresults.size > 0) {
        continue;
      }

      distratio = max(dist, minradius) / maxradius;
      damage = mindamage + (maxdamage - mindamage) * distratio;
      ent dodamage(damage, origin, attacker, inflictor, meansofdeath, weaponname);
    }
  }
}

function hashealthshield(player) {
  return isDefined(player) && isDefined(player.healthshield);
}

function gethealthshielddamage(damage) {
  assertex(isDefined(self.healthshieldmod), "<dev string:x1c>");
  return int(damage * self.healthshieldmod);
}

function sethealthshield(shieldvalue) {
  self.healthshield = 1;

  if(!isDefined(self.healthshieldmod)) {
    self.healthshieldmod = 1;
  }

  shieldvalue = int(clamp(shieldvalue, 0, 100));
  var_34985a43c94f1829 = (100 - shieldvalue) / 100;

  if(var_34985a43c94f1829 < self.healthshieldmod) {
    self.healthshieldmod = var_34985a43c94f1829;
  }
}

function clearhealthshield() {
  self.healthshield = undefined;
  self.healthshieldmod = undefined;
}

function _suicide(checkremote, var_1044662d97e67562) {
  if(self.sessionstate != "playing") {
    println("<dev string:x9a>");
    return;
  }

  if(playershoulddofauxdeath(checkremote) && !isDefined(self.fauxdead)) {
    thread scripts\mp\damage::playerkilled_internal(self, self, self, 10000, 0, "MOD_SUICIDE", nullweapon(), (0, 0, 0), "none", 0, 1116, 1);
    return;
  }

  if(!playershoulddofauxdeath(checkremote) && !isDefined(self.fauxdead) && (!isDefined(self.vehicle) || istrue(var_1044662d97e67562))) {
    self suicide();
  }
}

function suicide_on_end_remote() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("stopped_using_remote");
  thread suicide_on_alive();
}

function suicide_on_alive() {
  self endon("disconnect");
  level endon("game_ended");
  self notify("suicide_on_alive");
  self endon("suicide_on_alive");

  while(!isreallyalive(self) || self.sessionstate != "playing") {
    waitframe();
  }

  _suicide();
}

function playershoulddofauxdeath(checkremote) {
  if(!isDefined(checkremote)) {
    checkremote = 1;
  }

  if(istrue(self.isusingcamera)) {
    return false;
  }

  if(istrue(checkremote) && isusingremote() && !islifelimited()) {
    if(self.usingremote != "remote_turret") {
      return true;
    }
  }

  if(isDefined(level.modeshoulddofauxdeathfunc) && self[[level.modeshoulddofauxdeathfunc]]()) {
    return true;
  }

  return false;
}

function isprojectiledamage(meansofdeath) {
  projdamage = "MOD_PROJECTILE MOD_IMPACT MOD_GRENADE MOD_HEAD_SHOT";

  if(issubstr(projdamage, meansofdeath)) {
    return true;
  }

  return false;
}

function non_player_log_attacker_data(data, attacker) {
  if(data.damage == 0) {
    return;
  }

  if(!isDefined(attacker)) {
    attacker = data.attacker;
  }

  if(!isDefined(attacker) || !isPlayer(attacker)) {
    inflictor = data.inflictor;

    if(isDefined(inflictor)) {
      if(isPlayer(inflictor)) {
        attacker = inflictor;
      } else {
        attacker = inflictor.owner;
      }
    } else {
      attacker = undefined;
    }
  }

  if(!isDefined(attacker) || !isPlayer(attacker)) {
    return;
  }

  if(isDefined(self.owner)) {
    if(!scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker)) {
      return;
    }
  } else if(level.teambased && isDefined(self.team) && self.team == attacker.team) {
    return;
  }

  non_player_add_attacker_data(data, attacker);
}

function non_player_add_attacker_data(data, attacker) {
  if(!isDefined(attacker)) {
    attacker = data.attacker;
  }

  firsttimedamaged = undefined;
  attackerdata = non_player_get_attacker_data(attacker);

  if(!isDefined(attackerdata)) {
    attackerdata = non_player_get_attacker_data(attacker, 1);
    firsttimedamaged = gettime();
  }

  attackerdata.damage += data.damage;
  attackerdata.objweapon = data.objweapon;
  attackerdata.point = data.point;
  attackerdata.direction = data.direction_vec;
  attackerdata.partname = data.partname;
  attackerdata.meansofdeath = data.meansofdeath;
  attackerdata.firsttimedamaged = ter_op(isDefined(firsttimedamaged), firsttimedamaged, attackerdata.firsttimedamaged);
  attackerdata scripts\common\damage_effects::updatefirsttimedamaged();
  attackerdata.lasttimedamaged = gettime();
}

function non_player_get_attacker_data(attacker, create) {
  attackerdata = undefined;

  if(!isDefined(self.attackerdata) && istrue(create)) {
    self.attackerdata = [];
  }

  if(isDefined(self.attackerdata)) {
    guid = attacker.guid;

    if(isDefined(guid)) {
      attackerdata = self.attackerdata[guid];

      if(isDefined(attackerdata)) {
        if(attackerdata.isvalid || level.teambased && attacker.team != attackerdata.team) {
          attackerdata = undefined;
          self.attackerdata[guid] = undefined;
        }
      }

      if(!isDefined(attackerdata) && istrue(create)) {
        attackerdata = spawnStruct();
        attackerdata.attacker = attacker;
        attackerdata.team = attacker.team;
        attackerdata.guid = guid;
        attackerdata.isvalid = 1;
        attackerdata.damage = 0;
        attackerdata.hitcount = 0;
        attackerdata.firsttimehit = gettime();
        self.attackerdata[guid] = attackerdata;
      }
    }
  }

  return attackerdata;
}

function non_player_clear_attacker_data() {
  self.attackerdata = undefined;
}

function non_player_should_ignore_damage(attacker, objweapon, inflictor, meansofdeath) {
  if(non_player_should_ignore_damage_signature(attacker, objweapon, inflictor, meansofdeath)) {
    return true;
  }

  if(isDefined(objweapon.basename)) {
    if(meansofdeath != "MOD_MELEE") {
      switch (objweapon.basename) {
        case #"hash_405f9521b5ee8402":
        case #"hash_807ae3204119bd41":
          return true;
      }
    }

    if(meansofdeath == "MOD_IMPACT") {
      switch (objweapon.basename) {
        case #"hash_435258fc47768fa7":
        case #"hash_4b87af60037f526f":
        case #"hash_4c7de5619284e175":
        case #"hash_56ee829cc162271a":
        case #"hash_5e8f81314553dd36":
        case #"hash_6a2e4f9c54756dc7":
        case #"hash_d6565ec12efca627":
          return true;
      }
    } else {
      switch (objweapon.basename) {
        case #"hash_34e7a4cd11aed6bc":
        case #"hash_aec9c140fca96664":
        case #"hash_b2a8e1829f433bd7":
        case #"hash_c7ce3f77814f7950":
        case #"hash_cac2107b8e726d9d":
        case #"hash_d072a0adddda0068":
          return true;
      }
    }
  }

  return false;
}

function non_player_add_ignore_damage_signature(attacker, objweapon, inflictor, meansofdeath) {
  if(!isDefined(self.ignoredamageid)) {
    self.ignoredamageid = 0;
  }

  if(!isDefined(self.ignoredamagesignatures)) {
    self.ignoredamagesignatures = [];
  }

  id = self.ignoredamageid;
  self.ignoredamageid++;

  if(isDefined(objweapon) && isstring(objweapon)) {
    objweapon = makeweapon(objweapon);
  }

  signature = spawnStruct();
  signature.id = id;
  signature.attacker = attacker;
  signature.objweapon = objweapon;
  signature.inflictor = inflictor;
  signature.meansofdeath = meansofdeath;
  signature.checkattacker = isDefined(attacker);
  signature.checkobjweapon = isDefined(objweapon) && !isnullweapon(objweapon);
  signature.checkinflictor = isDefined(inflictor);
  signature.checkmeansofdeath = isDefined(meansofdeath);
  self.ignoredamagesignatures[id] = signature;
  return id;
}

function non_player_remove_ignore_damage_signature(id) {
  if(!isDefined(self.ignoredamagesignatures)) {
    return;
  }

  self.ignoredamagesignatures[id] = undefined;
}

function non_player_clear_ignore_damage_signatures() {
  self.ignoredamagesignatures = undefined;
}

function non_player_should_ignore_damage_signature(attacker, objweapon, inflictor, meansofdeath) {
  if(!isDefined(self.ignoredamagesignatures)) {
    return false;
  }

  if(isDefined(objweapon) && isstring(objweapon)) {
    objweapon = makeweapon(objweapon);
  }

  foreach(signature in self.ignoredamagesignatures) {
    if(!isDefined(signature)) {
      return false;
    }

    if(signature.checkattacker) {
      if(!isDefined(signature.attacker)) {
        non_player_remove_ignore_damage_signature(signature.id);
        continue;
      } else if(!isDefined(attacker)) {
        continue;
      } else if(attacker != signature.attacker) {
        continue;
      }
    }

    if(signature.checkobjweapon) {
      if(!isDefined(objweapon) || isnullweapon(objweapon)) {
        continue;
      } else if(objweapon.basename != signature.objweapon.basename) {
        continue;
      }
    }

    if(signature.checkinflictor) {
      if(!isDefined(signature.inflictor)) {
        non_player_remove_ignore_damage_signature(signature.id);
        continue;
      } else if(!isDefined(inflictor)) {
        continue;
      } else if(inflictor != signature.inflictor) {
        continue;
      }
    }

    if(signature.checkmeansofdeath) {
      if(!isDefined(meansofdeath)) {
        continue;
      } else if(meansofdeath != signature.meansofdeath) {
        continue;
      }
    }

    return true;
  }

  return false;
}

function islauncherdirectimpactdamage(objweapon, meansofdeath, var_68d17572ef704fa8) {
  if(objweapon.type != "projectile") {
    return false;
  }

  if(istrue(var_68d17572ef704fa8) && objweapon.isalternate && isDefined(objweapon.underbarrel)) {
    return false;
  }

  return meansofdeath == "MOD_IMPACT" || meansofdeath == "MOD_PROJECTILE" || meansofdeath == "MOD_GRENADE" || meansofdeath == "MOD_HEAD_SHOT" && weaponclass(objweapon) == "rocketlauncher";
}