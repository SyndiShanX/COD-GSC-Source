/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\equipment\thermite.gsc
***********************************************/

thermite_used(var_0, var_1) {
  if(isDefined(var_1)) {
    var_2 = var_0;
    var_0 = scripts\mp\utility\weapon::_launchgrenade("_encstr_99410C4B48C39AB7D0CD95B769DB", var_2.origin, (0, 0, 0));
    scripts\mp\weapons::grenadeinitialize(var_0, getcompleteweaponname("_encstr_99410C4B48C39AB7D0CD95B769DB"));
    var_0.see_equipment_dist = var_2;
    var_0.angles = var_2.angles;
    var_0.see_killstreak_dist = self getcurrentweapon();
    var_0 linkTo(var_2);
    var_0.exploding = 1;
    var_0 setscriptablepartstate("_encstr_A1430B84E48B6BF9D91BE83877", "_encstr_BECC055CF3811A", 0);
  }

  if(isDefined(level.playimpactfx))
    [[level.playimpactfx]](var_0, self);

  var_0 thread thermite_watchdisowned();
  var_0 thread _id_13B21();
  var_0 thread thermite_watchstuck(var_1);
}

thermite_watchstuck(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_1 = undefined;

  if(istrue(var_0)) {
    var_2 = _id_13B20();

    if(!istrue(var_2)) {
      thread thermite_delete();
      return;
    }

    if(isDefined(self.see_equipment_dist))
      self.see_equipment_dist delete();
  } else {
    self waittill("_encstr_8DE90E4D31C35370B84D709B4B6DEE42", var_1, var_3, var_4);
    self.surfacetype = var_4;
  }

  if(isDefined(level._id_132A4) && [[level._id_132A4.make_control_station_interaction]](self)) {
    if(isDefined(level._id_132A4) && isDefined(level._id_132A4.setupmission)) {
      [[level._id_132A4.setupmission]](self);
      return;
    }
  }

  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.owner endon("_encstr_81170C244F9CBDE72C01BB99A298");
  self.owner endon("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");

  if(!istrue(var_0)) {
    if(isDefined(var_1) && isPlayer(var_1))
      thread scripts\mp\weapons::grenadestuckto(self, var_1);
  }

  var_5 = self.weapon_object;

  if(isDefined(self.see_killstreak_dist))
    var_5._id_121D9 = self.see_killstreak_dist;

  thread _id_13B22();
  self setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_878807108A42A309BB", 0);
  _id_13B1D(var_5);

  if(!istrue(level.iscacprimaryweapongroup))
    self.dangerzoneid = scripts\mp\spawnlogic::addspawndangerzone(self.origin, 175, 175, self.owner.team, 100, self.owner, 1, self, 1);

  wait 0.5;
  var_6 = getcompleteweaponname("_encstr_B29B0FE0E32573E3A23395B04E6BBF5898");
  var_7 = getcompleteweaponname("_encstr_A98D0FF0185ABBC537DD8D30B807FF81C1");

  if(isDefined(self.see_killstreak_dist)) {
    var_6._id_121D9 = self.see_killstreak_dist;
    var_7._id_121D9 = self.see_killstreak_dist;
  }

  var_8 = 1;

  while(var_8 <= 10) {
    var_9 = var_8 + 1;

    if(scripts\engine\utility::mod(var_9, 2) > 0)
      _id_13B1D(var_6);
    else
      _id_13B1D(var_7);

    var_8 = var_9;
    wait 0.5;
  }

  thread thermite_destroy();
}

_id_13B20() {
  self.see_equipment_dist endon("_encstr_AD75063D571AE108");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.owner endon("_encstr_81170C244F9CBDE72C01BB99A298");
  self.owner endon("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  self.see_equipment_dist waittill("_encstr_8DE90E4D31C35370B84D709B4B6DEE42", var_0, var_1, var_2, var_3, var_4, var_5);
  self.see_equipment_dist.surfacetype = var_2;

  if(isDefined(var_0)) {
    if(isPlayer(var_0) || isagent(var_0)) {
      if(var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
        if(isPlayer(var_0))
          thread scripts\mp\weapons::grenadestuckto(self, var_0);

        if(isDefined(var_1))
          self linkTo(var_0, var_1);
        else
          self linkTo(var_0, "_encstr_8EEC09159F6238030BFA23", (0, 0, 0));
      }
    } else if(isDefined(var_1))
      self linkTo(var_0, var_1);
    else
      self linkTo(var_0);
  }

  return 1;
}

_id_13B22() {
  self endon("_encstr_AD75063D571AE108");
  var_0 = self getlinkedparent();

  while(isDefined(var_0))
    self waittill("_encstr_8DE90E4D31C35370B84D709B4B6DEE42", var_0);

  self.badplace = createnavbadplacebybounds(self.origin, (125, 125, 125), (0, 0, 0));
}

_id_13B1D(var_0) {
  var_1 = 125;
  var_2 = 25;
  var_3 = 10;
  var_4 = "_encstr_9B0D099AD3887D91252954";

  if(var_0.basename == "_encstr_99410C4B48C39AB7D0CD95B769DB") {
    var_1 = 125;
    var_2 = 40;
    var_3 = 40;
  }

  var_5 = self.stuckenemyentity;

  if(isDefined(var_5)) {
    if(isPlayer(var_5) && var_5 scripts\cp_mp\utility\player_utility::_isalive()) {
      if(isDefined(level._id_132A4) && [[level._id_132A4.getheliflyheight]](var_5)) {
        thread thermite_destroy();
        return;
      }

      var_5 dodamage(var_2, self.origin, self.owner, self, var_4, var_0);
      var_5 scripts\cp_mp\utility\damage_utility::adddamagemodifier("_encstr_B6BC0EC35435C0E1CAB3A3D7ABD33EC0", 0, 0, ::_id_13B1C);
    } else
      var_5 = undefined;
  }

  self radiusdamage(self.origin, var_1, var_2, var_3, self.owner, var_4, var_0);

  if(isDefined(var_5))
    var_5 scripts\cp_mp\utility\damage_utility::removedamagemodifier("_encstr_B6BC0EC35435C0E1CAB3A3D7ABD33EC0", 0);
}

_id_13B1C(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_0))
    return 1;

  if(!isDefined(var_0.weapon_name) || var_0.weapon_name != "_encstr_99410C4B48C39AB7D0CD95B769DB")
    return 1;

  if(!isDefined(var_0.stuckenemyentity) || var_0.stuckenemyentity != var_2)
    return 1;

  return 0;
}

thermite_watchdisowned() {
  self endon("_encstr_AD75063D571AE108");
  self.owner scripts\engine\utility::_id_143A6("_encstr_81170C244F9CBDE72C01BB99A298", "_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B", "_encstr_8D820B49520F0EC02DDE6367EC");
  thread thermite_destroy();
}

_id_13B21() {
  self endon("_encstr_AD75063D571AE108");
  level waittill("_encstr_A64211C4E4D70E4E2BB5B0D1C643549B325623");
  thread thermite_destroy();
}

thermite_destroy() {
  thread thermite_delete(5);
  self setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_92B1082E2D4B458DC014", 0);
}

thermite_delete(var_0) {
  self notify("_encstr_AD75063D571AE108");
  self.exploding = 1;

  if(isDefined(self.dangerzoneid)) {
    scripts\mp\spawnlogic::removespawndangerzone(self.dangerzoneid);
    self.dangerzoneid = undefined;
  }

  if(isDefined(self.badplace)) {
    destroynavobstacle(self.badplace);
    self.badplace = undefined;
  }

  self forcehidegrenadehudwarning(1);

  if(isDefined(var_0))
    wait(var_0);

  if(isDefined(self))
    self delete();
}

thermite_onplayerdamaged(var_0) {
  if(var_0.meansofdeath == "_encstr_A1ED0BA9FF84562B60BA073E83")
    return 1;

  var_0.victim.lastburntime = gettime();
  var_0.victim thread scripts\mp\weapons::enableburnfxfortime(0.6);
  return 1;
}