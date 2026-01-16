/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\globallogic_scriptmover.gsc
***********************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\damage;
#include scripts\core_common\globallogic\globallogic_player;
#include scripts\core_common\weapons_shared;

#namespace globallogic_scriptmover;

function_8c7ec52f(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, iboneindex, imodelindex, spartname, isurfacetype, vsurfacenormal) {
  if(!isDefined(self.attackerdata)) {
    self.attackerdata = [];
  }

  if(!isDefined(self.attackers)) {
    self.attackers = [];
  }

  if(isDefined(self.owner) && !damage::friendlyfirecheck(self.owner, eattacker)) {
    return;
  }

  idamage = weapons::function_74bbb3fa(idamage, weapon, self.weapon);
  idamage = int(idamage);

  if(isDefined(self.var_86a21346)) {
    idamage = self[[self.var_86a21346]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, iboneindex, imodelindex);
  } else if(isDefined(level.var_86a21346)) {
    idamage = self[[level.var_86a21346]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, iboneindex, imodelindex);
  }

  var_5370b15e = idamage < self.health ? idamage : self.health;
  self globallogic_player::giveattackerandinflictorownerassist(eattacker, einflictor, var_5370b15e, smeansofdeath, weapon);
  params = spawnStruct();
  params.einflictor = einflictor;
  params.eattacker = eattacker;
  params.idamage = idamage;
  params.idflags = idflags;
  params.smeansofdeath = smeansofdeath;
  params.weapon = weapon;
  params.vpoint = vpoint;
  params.vdir = vdir;
  params.shitloc = shitloc;
  params.vdamageorigin = vdamageorigin;
  params.psoffsettime = psoffsettime;
  params.iboneindex = iboneindex;
  params.imodelindex = imodelindex;
  params.spartname = spartname;
  params.isurfacetype = isurfacetype;
  params.vsurfacenormal = vsurfacenormal;
  self callback::callback(#"on_scriptmover_damage", params);
  self function_f7f9c3eb(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, iboneindex, imodelindex, spartname, isurfacetype, vsurfacenormal);
}