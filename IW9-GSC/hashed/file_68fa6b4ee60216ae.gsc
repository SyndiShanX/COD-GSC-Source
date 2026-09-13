/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_68fa6b4ee60216ae.gsc
***********************************************/

init(aitype) {
  if(scripts\cp\coop_stealth::level_should_run_sp_stealth())
    thread _id_5EEB4BE2B32A5C41();

  if(!isDefined(aitype))
    aitype = self.agent_type;

  if(!_id_18A73A64992DD07D::is_specified_unittype("dog"))
    self.meleechargedistvsplayer = 50;

  if(issubstr(aitype, "_smg")) {} else if(issubstr(aitype, "_ar"))
    self.maxfaceenemydist = 3000;
  else if(issubstr(aitype, "_sniper"))
    self.maxfaceenemydist = 3000;
  else if(issubstr(aitype, "_juggernaut"))
    self.maxfaceenemydist = 3000;
  else if(issubstr(aitype, "_shotgun")) {} else if(issubstr(aitype, "_lmg"))
    self.maxfaceenemydist = 3000;
  else if(issubstr(aitype, "_rpg"))
    self.maxfaceenemydist = 3000;
  else
    self.maxfaceenemydist = 3000;

  self.maxfacenewenemydist = 4000;
  _id_48EA06DBCE62F5B3();
}

_id_5EEB4BE2B32A5C41() {
  self endon("death");

  while(!isDefined(self.stealth))
    waitframe();

  while(!isDefined(self.stealth.funcs))
    waitframe();

  if(getdvarint("dvar_216BEFCB8B10D029", 0) != 0)
    scripts\stealth\utility::set_stealth_func("has_lost_enemy", ::_id_F2C466350F598EAD);
}

_id_CCDAD4E4232D8253() {
  if(scripts\stealth\manager::anyone_in_combat())
    return 1;

  return 0;
}

_id_F2C466350F598EAD() {
  if(_id_CCDAD4E4232D8253()) {
    ctimetolose = 10000;
    _id_7C08DD16FFA22BA8 = 15000;
    cstillrighttheredistsq = 50625;
  } else {
    ctimetolose = 10000;
    _id_7C08DD16FFA22BA8 = 15000;
    cstillrighttheredistsq = 2500;
  }

  _id_6B7BEE46F2C6DA28 = gettime();
  enemy = self.enemy;

  if(isDefined(enemy) && issentient(enemy) && isalive(enemy)) {
    if(enemy.team != "allies")
      return 0;

    _id_B4C04337A6A90C84 = self lastknowntime(enemy);

    if(_id_6B7BEE46F2C6DA28 < _id_B4C04337A6A90C84 + ctimetolose)
      return 0;

    _id_FB806200A8E9A011 = self lastknownpos(enemy);

    if(_id_B4C04337A6A90C84 > 0 && distancesquared(enemy.origin, _id_FB806200A8E9A011) < cstillrighttheredistsq)
      return 0;

    if(_id_6B7BEE46F2C6DA28 < _id_B4C04337A6A90C84 + _id_7C08DD16FFA22BA8 && enemy hastacvis(_id_FB806200A8E9A011))
      return 0;

    if(istrue(self.benemyinlowcover))
      return 0;
  }

  return 1;
}

_id_48EA06DBCE62F5B3() {
  if(getdvarint("dvar_880405187E0BD323", 0) == 0) {
    return;
  }
  if(!istrue(level._id_84B6EFB0B4CDABD5)) {
    return;
  }
  if(self[[self.fnisinstealthcombat]]() || self[[self.fnisinstealthhunt]]()) {
    return;
  }
  self[[self.fnsetstealthstate]]("hunt");
}