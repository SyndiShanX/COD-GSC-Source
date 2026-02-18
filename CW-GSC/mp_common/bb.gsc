/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\bb.gsc
***********************************************/

#using scripts\core_common\bb_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\player\player_loadout;
#using scripts\core_common\system_shared;
#namespace bb;

function private autoexec __init__system__() {
  system::register(#"bb", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  init_shared();
  callback::on_spawned(&on_player_spawned);
  callback::on_player_killed(&on_player_death);
}

function on_player_spawned() {
  self._bbdata = [];
  self._bbdata[# "score"] = 0;
  self._bbdata[# "momentum"] = 0;
  self._bbdata[# "spawntime"] = gettime();
  self._bbdata[# "shots"] = 0;
  self._bbdata[# "hits"] = 0;
}

function function_bf5cad4e(gamemodedata) {
  matchtime = (isDefined(level.var_8a3a9ca4.roundend) ? level.var_8a3a9ca4.roundend : 0) - (isDefined(level.var_8a3a9ca4.roundstart) ? level.var_8a3a9ca4.roundstart : 0);
  firstblood = (isDefined(level.var_8a3a9ca4.firstblood) ? level.var_8a3a9ca4.firstblood : 0) - (isDefined(level.var_8a3a9ca4.roundstart) ? level.var_8a3a9ca4.roundstart : 0);
  alliesscore = isDefined([[level._getteamscore]](#"allies")) ? [[level._getteamscore]](#"allies") : 0;
  axisscore = isDefined([[level._getteamscore]](#"axis")) ? [[level._getteamscore]](#"axis") : 0;
  var_5e25b17b = abs(alliesscore - axisscore);
  gamemodedata = {};
  gamemodedata.gamemode = level.gametype;
  gamemodedata.wintype = isDefined(gamemodedata.wintype) ? gamemodedata.wintype : "NA";
  gamemodedata.matchtime = matchtime;
  gamemodedata.firstblood = firstblood;
  gamemodedata.var_5e25b17b = var_5e25b17b;
  gamemodedata.timeremaining = isDefined(gamemodedata.remainingtime) ? gamemodedata.remainingtime : 0;
  gamemodedata.var_20de6a02 = isDefined(gamemodedata.var_20de6a02) ? gamemodedata.var_20de6a02 : 0;
  gamemodedata.var_be1de2ab = isDefined(gamemodedata.var_be1de2ab) ? gamemodedata.var_be1de2ab : 0;
  function_92d1707f(#"hash_1a63efe7c6121b24", gamemodedata);
}

function function_95a5b5c2(obj_type, label, team, origin, player) {
  if(sessionmodeismultiplayergame()) {
    var_cfad67d4 = ishash(team) ? team : hash(team);

    if(isPlayer(player)) {
      clientid = isDefined(player.clientid) ? player.clientid : -1;
      player function_678f57c8(#"hash_d424efe4db1dff7", {
        #gametime: function_f8d53445(), #objtype: obj_type, #label: label, #team: var_cfad67d4, #playerx: origin[0], #playery: origin[1], #playerz: origin[2], #clientid: clientid
      });
    }
  }
}

function function_c3b9e07f(eattacker, attackerorigin, attackerspecialist, attackerweapon, evictim, victimorigin, victimspecialist, victimweapon, idamage, smeansofdeath, shitloc, death, killstreak) {
  if(!sessionmodeismultiplayergame()) {
    return;
  }

  mpattacks = {};
  mpattacks.gametime = function_f8d53445();

  if(isDefined(eattacker)) {
    mpattacks.attackerspawnid = getplayerspawnid(eattacker);
  }

  if(isDefined(attackerorigin)) {
    mpattacks.attackerx = attackerorigin[0];
    mpattacks.attackery = attackerorigin[1];
    mpattacks.attackerz = attackerorigin[2];
  }

  mpattacks.attackerspecialist = attackerspecialist;
  mpattacks.attackerweapon = attackerweapon;

  if(isDefined(evictim)) {
    mpattacks.victimspawnid = getplayerspawnid(evictim);
  }

  if(isDefined(victimorigin)) {
    mpattacks.victimx = victimorigin[0];
    mpattacks.victimy = victimorigin[1];
    mpattacks.victimz = victimorigin[2];
  }

  mpattacks.victimspecialist = victimspecialist;
  mpattacks.victimweapon = victimweapon;
  mpattacks.damage = idamage;
  mpattacks.damagetype = smeansofdeath;
  mpattacks.damagelocation = shitloc;
  mpattacks.death = death;
  mpattacks.killstreak = killstreak;
  function_92d1707f(#"hash_67e3a427b7ec1819", mpattacks);
}

function on_player_death(params) {
  if(isbot(self)) {
    return;
  }

  if(game.state == # "playing") {
    self commit_spawn_data();
  }
}

function function_6661621a() {
  if(isbot(self)) {
    return;
  }

  assert(isDefined(self._bbdata));

  if(!isDefined(self.class_num)) {
    return;
  }

  if(!sessionmodeismultiplayergame()) {
    return;
  }

  mploadout = spawnStruct();
  mploadout.gametime = function_f8d53445();
  mploadout.spawnid = getplayerspawnid(self);
  primaryweapon = self getloadoutweapon(self.class_num, "primary");
  mploadout.primary = primaryweapon.name;
  primaryattachments = function_285f8efd(primaryweapon);
  mploadout.primaryattachment1 = primaryattachments.attachment0;
  mploadout.primaryattachment2 = primaryattachments.attachment1;
  mploadout.primaryattachment3 = primaryattachments.attachment2;
  mploadout.primaryattachment4 = primaryattachments.attachment3;
  mploadout.primaryattachment5 = primaryattachments.attachment4;
  mploadout.primaryreticle = hash(self getweaponoptic(primaryweapon));
  mploadout.var_813fa3e2 = self function_a83d51c5(self.class_num, 1);
  secondaryweapon = self getloadoutweapon(self.class_num, "secondary");
  mploadout.secondary = secondaryweapon.name;
  secondaryattachments = function_285f8efd(secondaryweapon);
  mploadout.secondaryattachment1 = secondaryattachments.attachment0;
  mploadout.secondaryattachment2 = secondaryattachments.attachment1;
  mploadout.secondaryattachment3 = secondaryattachments.attachment2;
  mploadout.secondaryattachment4 = secondaryattachments.attachment3;
  mploadout.secondaryattachment5 = secondaryattachments.attachment4;
  mploadout.secondaryreticle = hash(self getweaponoptic(secondaryweapon));
  mploadout.var_69054e67 = self function_a83d51c5(self.class_num, 0);
  primarygrenade = self function_826ed2dd();
  mploadout.primarygrenade = primarygrenade.name;
  mploadout.primarygrenadecount = self getloadoutitem(self.class_num, "primarygrenadecount") ? 2 : 1;
  mploadout.specialgrenade = self function_b958b70d(self.class_num, "secondarygrenade");
  mploadout.specialgrenadecount = self getloadoutitem(self.class_num, "secondarygrenadecount") ? 2 : 1;
  fieldupgrade = self loadout::function_18a77b37("specialgrenade");
  mploadout.fieldupgrade = fieldupgrade.name;
  mploadout.tacticalgear = self function_d78e0e04(self.class_num);
  mploadout.killstreak1 = self.killstreak.size < 0 ? 0 : hash(self.killstreak[0]);
  mploadout.killstreak2 = self.killstreak.size < 1 ? 0 : hash(self.killstreak[1]);
  mploadout.killstreak3 = self.killstreak.size < 2 ? 0 : hash(self.killstreak[2]);
  talents = self function_4a9f1384(self.class_num);
  mploadout.var_942f949 = talents.size < 0 ? 0 : talents[0];
  mploadout.talent1 = talents.size < 1 ? 0 : talents[1];
  mploadout.talent2 = talents.size < 2 ? 0 : talents[2];
  mploadout.talent3 = talents.size < 3 ? 0 : talents[3];
  mploadout.talent4 = talents.size < 4 ? 0 : talents[4];
  mploadout.talent5 = talents.size < 5 ? 0 : talents[5];
  wildcards = self function_6f2c0492(self.class_num);
  mploadout.wildcard0 = wildcards.size < 0 ? 0 : wildcards[0];
  mploadout.wildcard1 = wildcards.size < 1 ? 0 : wildcards[1];
  mploadout.var_13573300 = wildcards.size < 2 ? 0 : wildcards[2];

  if(isDefined(self.playerrole) && isDefined(self.playerrole.var_c21d61e9)) {
    var_c0f05cbb = getweapon(isDefined(self.playerrole.var_c21d61e9) ? self.playerrole.var_c21d61e9 : level.weaponnone);
  } else {
    var_c0f05cbb = level.weaponnone;
  }

  mploadout.var_9911e1f2 = var_c0f05cbb.name;
  mploadout.specialistindex = isDefined(self getspecialistindex()) ? self getspecialistindex() : -1;
  function_92d1707f(#"hash_30b542620e21966d", #"mploadouts", mploadout);
}

function commit_spawn_data() {
  if(isbot(self)) {
    return;
  }

  assert(isDefined(self._bbdata));

  if(!isDefined(self._bbdata)) {
    return;
  }

  if(!sessionmodeismultiplayergame()) {
    return;
  }

  specialistindex = isDefined(self getspecialistindex()) ? self getspecialistindex() : -1;
  mpplayerlives = {
    #gametime: function_f8d53445(), #spawnid: getplayerspawnid(self), #lifescore: self._bbdata[# "score"], #lifemomentum: self._bbdata[# "momentum"], #lifetime: gettime() - self._bbdata[# "spawntime"], #name: self.name, #specialist: specialistindex
  };
  function_92d1707f(#"hash_6fc210ad5f081ce8", mpplayerlives);
  self function_6661621a();
}

function function_285f8efd(weapon) {
  var_e38a0464 = spawnStruct();
  var_e38a0464.attachment0 = 0;
  var_e38a0464.attachment1 = 0;
  var_e38a0464.attachment2 = 0;
  var_e38a0464.attachment3 = 0;
  var_e38a0464.attachment4 = 0;
  var_e38a0464.attachment5 = 0;
  var_e38a0464.attachment6 = 0;
  var_e38a0464.attachment7 = 0;

  if(!isDefined(weapon) || weapon.attachments.size == 0) {
    return var_e38a0464;
  }

  var_e38a0464.attachment0 = hash(weapon.attachments[0]);

  if(weapon.attachments.size == 1) {
    return var_e38a0464;
  }

  var_e38a0464.attachment1 = hash(weapon.attachments[1]);

  if(weapon.attachments.size == 2) {
    return var_e38a0464;
  }

  var_e38a0464.attachment2 = hash(weapon.attachments[2]);

  if(weapon.attachments.size == 3) {
    return var_e38a0464;
  }

  var_e38a0464.attachment3 = hash(weapon.attachments[3]);

  if(weapon.attachments.size == 4) {
    return var_e38a0464;
  }

  var_e38a0464.attachment4 = hash(weapon.attachments[4]);

  if(weapon.attachments.size == 5) {
    return var_e38a0464;
  }

  var_e38a0464.attachment5 = hash(weapon.attachments[5]);

  if(weapon.attachments.size == 6) {
    return var_e38a0464;
  }

  var_e38a0464.attachment6 = hash(weapon.attachments[6]);

  if(weapon.attachments.size == 7) {
    return var_e38a0464;
  }

  var_e38a0464.attachment7 = hash(weapon.attachments[7]);
  return var_e38a0464;
}