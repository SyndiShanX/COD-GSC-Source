/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\equipment\cp_thermite.gsc
***********************************************/

thermite_used(var_0, var_1, var_2) {
  if(isDefined(var_1)) {
    var_3 = var_0;
    var_0 = self launchgrenade("_encstr_99410C4B48C39AB7D0CD95B769DB", var_3.origin, (0, 0, 0));
    var_0.see_equipment_dist = var_3;
    var_0.angles = var_3.angles;
    var_0.owner = self;
    var_0 linkTo(var_3);
    var_0 setscriptablepartstate("_encstr_A1430B84E48B6BF9D91BE83877", "_encstr_BECC055CF3811A", 0);
  }

  var_0.set_car_collision = self.name;
  var_0 thread thermite_watchdisowned();
  var_0 thread thermite_watchstuck(var_1, var_2);
}

thermite_watchstuck(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  var_2 = undefined;

  if(istrue(var_0)) {
    var_3 = _id_13B20();

    if(!istrue(var_3)) {
      thread thermite_delete();
      return;
    }

    if(isDefined(self.see_equipment_dist))
      self.see_equipment_dist delete();
  } else {
    self waittill("_encstr_8DE90E4D31C35370B84D709B4B6DEE42", var_2, var_4);

    if(istrue(var_1))
      _id_13B1F(var_2, var_4);
  }

  level notify("_encstr_8840203B1B679D69DB35F8ED10B3F0578FF2903992BB1D209B5FE0DEF40F9909F38A", self, "_encstr_99410C4B48C39AB7D0CD95B769DB", self.set_car_collision);

  if(isDefined(self.owner)) {
    self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
    self.owner endon("_encstr_81170C244F9CBDE72C01BB99A298");
    self.owner endon("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  }

  self setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_878807108A42A309BB", 0);
  self setscriptablepartstate("_encstr_B2BE0788BAF573592F", "_encstr_878807108A42A309BB", 0);
  self radiusdamage(self.origin, 125, 30, 30, self.owner, "_encstr_9B0D099AD3887D91252954", "_encstr_99410C4B48C39AB7D0CD95B769DB");
  wait 0.5;
  var_5 = 1;

  while(var_5 <= 10) {
    var_6 = var_5 + 1;

    if(scripts\engine\utility::mod(var_6, 2) > 0) {
      self setscriptablepartstate("_encstr_B2BE0788BAF573592F", "_encstr_96620CC9902B070B53D01AB218BB", 0);
      self radiusdamage(self.origin, 125, 25, 10, self.owner, "_encstr_9B0D099AD3887D91252954", "_encstr_B29B0FE0E32573E3A23395B04E6BBF5898");
    } else {
      self setscriptablepartstate("_encstr_B2BE0788BAF573592F", "_encstr_B4270B33B803BC81F58F330D1D", 0);
      self radiusdamage(self.origin, 125, 25, 10, self.owner, "_encstr_9B0D099AD3887D91252954", "_encstr_B29B0FE0E32573E3A23395B04E6BBF5898");
    }

    var_5 = var_6;
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
  _id_13B1F(var_0, var_1);
  return 1;
}

_id_13B1F(var_0, var_1) {
  if(isDefined(var_0)) {
    if(isPlayer(var_0) || isagent(var_0)) {
      if(var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
        if(isDefined(var_1))
          self linkTo(var_0, var_1);
        else
          self linkTo(var_0, "_encstr_820B08D83F32B770488B", (0, 0, 0));

        if(isPlayer(var_0))
          var_0 thread scripts\cp\cp_weapons::enableburnfxfortime(0.6);
      }
    } else if(isDefined(var_1))
      self linkTo(var_0, var_1);
    else
      self linkTo(var_0);
  }
}

thermite_watchdisowned() {
  self endon("_encstr_AD75063D571AE108");
  self.owner scripts\engine\utility::_id_143A6("_encstr_81170C244F9CBDE72C01BB99A298", "_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B", "_encstr_8D820B49520F0EC02DDE6367EC");
  thread thermite_destroy();
}

thermite_destroy() {
  var_0 = self getlinkedparent();

  if(isDefined(var_0) && isPlayer(var_0)) {
    if(istrue(var_0.inlaststand))
      var_0 thread _id_13B1E();
  }

  thread thermite_delete(5);
  self setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_92B1082E2D4B458DC014", 0);
}

thermite_delete(var_0) {
  self notify("_encstr_AD75063D571AE108");
  self.exploding = 1;
  self forcehidegrenadehudwarning(1);
  wait(var_0);
  self delete();
}

thermite_onplayerdamaged(var_0) {
  if(var_0.meansofdeath == "_encstr_A1ED0BA9FF84562B60BA073E83")
    return 1;

  var_0.victim thread scripts\cp\cp_weapons::enableburnfxfortime(0.6);
  return 1;
}

_id_13B1E() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_9B2C134695CB2B43FD60688199333A0BA385D1CEBD");
  self endon("_encstr_9B2C134695CB2B43FD60688199333A0BA385D1CEBD");
  waitframe();
  thread scripts\cp\cp_weapons::enableburnfxfortime(4);
}