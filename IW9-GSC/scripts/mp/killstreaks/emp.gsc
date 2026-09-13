/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\emp.gsc
***********************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("emp", ::tryuseempfromstruct);
}

tryuseemp() {
  streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("emp", self);
  return tryuseempfromstruct(streakinfo);
}

tryuseempfromstruct(streakinfo) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](streakinfo))
      return 0;
  }

  _id_9B1DEB5E9D32BBE3 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_dogesturedeploy(streakinfo, makeweapon("ks_gesture_generic_mp"));

  if(!istrue(_id_9B1DEB5E9D32BBE3))
    return 0;

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](streakinfo))
      return 0;
  }

  thread startemp();

  if(isDefined(level.killstreakfinishusefunc))
    level thread[[level.killstreakfinishusefunc]](self.streakinfo);

  return 1;
}

startemp() {
  level endon("game_ended");
  _id_5FA1E1697A302583 = scripts\cp_mp\utility\killstreak_utility::getkillstreakairstrikeheightent();
  heightoffset = 3000;

  if(isDefined(_id_5FA1E1697A302583))
    heightoffset = _id_5FA1E1697A302583.origin[2] + 500;

  _id_79AD84B5F137AFA8 = level.mapcenter * (1, 1, 0) + (0, 0, heightoffset);
  playFX(scripts\engine\utility::getfx("emp_shockwave"), _id_79AD84B5F137AFA8);
  self playSound("jammer_drone_shockwave");

  foreach(player in level.players) {
    if(!scripts\mp\utility\player::isreallyalive(player)) {
      continue;
    }
    player thread applyempshellshock();
  }

  _id_B0C33D224B825287 = scripts\mp\utility\teams::getenemyteams(self.owner.team);

  foreach(_id_F90358454413407F in _id_B0C33D224B825287)
  destroyactiveobjects(_id_F90358454413407F, self);
}

applyempshellshock() {
  self setscriptablepartstate("emped", "active", 0);
  self playLoopSound("emp_nade_lp");
  thread applyempshellshockvisionset();
  wait 0.5;
  self setscriptablepartstate("emped", "neutral", 0);
  self playSound("emp_nade_lp_end");
  self stoploopsound("emp_nade_lp");
}

applyempshellshockvisionset() {
  visionsetnaked("coup_sunblind", 0.05);
  waitframe();
  visionsetnaked("coup_sunblind", 0);
  visionsetnaked("", 0.5);
}

destroyactiveobjects(team, owner) {
  weapon = "nuke_mp";
  _id_6C845D64BE969CE8 = level.activekillstreaks;
  _id_98FA4B76D957B210 = [[level.getactiveequipmentarray]]();
  _id_34CA454BBEC477F1 = undefined;

  if(isDefined(_id_6C845D64BE969CE8) && isDefined(_id_98FA4B76D957B210))
    _id_34CA454BBEC477F1 = scripts\engine\utility::array_combine_unique(_id_6C845D64BE969CE8, _id_98FA4B76D957B210);
  else if(isDefined(_id_6C845D64BE969CE8))
    _id_34CA454BBEC477F1 = _id_6C845D64BE969CE8;
  else if(isDefined(_id_98FA4B76D957B210))
    _id_34CA454BBEC477F1 = _id_98FA4B76D957B210;

  if(isDefined(_id_34CA454BBEC477F1)) {
    foreach(object in _id_34CA454BBEC477F1) {
      if(isDefined(object))
        object scripts\mp\utility\killstreak::dodamagetokillstreak(10000, owner, owner, team, object.origin, "MOD_EXPLOSIVE", weapon);
    }
  }
}