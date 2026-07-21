/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\perks\perk_equipmentping.gsc
***********************************************/

runequipmentping(var_0, var_1) {
  if(!istrue(level.equipmentpingactive)) {
    return;
  }
  self endon("_encstr_AD75063D571AE108");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_2 = self.owner;
  var_3 = level.uavsettings["_encstr_A16E0B55AFD367DAD988921AC8"];

  if(!isDefined(var_1))
    var_1 = 0;

  self.equipping_lastpingtime = var_1;

  if(var_2 scripts\mp\utility\perk::_hasperk("_encstr_9277192390DBD6AF29C98C894871179B6B284ADA088181832D2067")) {
    for(;;) {
      var_4 = 0;

      if(gettime() >= self.equipping_lastpingtime + 3000) {
        var_5 = scripts\common\utility::playersincylinder(self.origin, 300);

        foreach(var_7 in var_5) {
          if(!scripts\mp\utility\player::isreallyalive(var_7)) {
            continue;
          }
          if(!var_2 scripts\mp\utility\player::isenemy(var_7)) {
            continue;
          }
          if(var_7 scripts\mp\utility\perk::_hasperk("_encstr_A2821B5F1039FB0A6391B3E810112283C158AFA758D63D729D3AFC2564")) {
            continue;
          }
          if(isDefined(var_7.outlined)) {
            continue;
          }
          var_8 = scripts\engine\utility::array_add(level.players, self);

          if(isDefined(var_0))
            var_8 = scripts\engine\utility::array_add(var_8, var_0);

          var_9 = self.origin + anglestoup(self.angles) * 10;

          if(scripts\engine\trace::ray_trace_passed(var_9, var_7 gettagorigin("_encstr_AADA07DBF19A4A81D7"), var_8)) {
            if(!var_7 scripts\mp\utility\perk::_hasperk("_encstr_916914E63856D85AB08DE85EF53B1C6E9A16ADDA5693"))
              var_2 thread markasrelaysource(var_7);

            var_4 = 1;
          }
        }

        if(var_4) {
          if(!istrue(self.eyespyalerted))
            self.eyespyalerted = 1;

          playfxontagforclients(var_3.fxid_ping, self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", var_2);
          self playsoundtoplayer("_encstr_A38D122140F05343EFE3BF687F1DDFB0775BD58F", var_2);
          triggerportableradarping(self.origin, var_2, 400, 800);
          wait 3;
        }
      }

      waitframe();
    }
  }
}

markdangerzoneonminimap(var_0, var_1) {
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(!isDefined(var_0) || !scripts\mp\utility\player::isreallyalive(var_0)) {
    return;
  }
  thread markasrelaysource(var_0);
  var_2 = scripts\mp\objidpoolmanager::requestobjectiveid(10);

  if(var_2 == -1) {
    return;
  }
  scripts\mp\objidpoolmanager::objective_add_objective(var_2, "_encstr_930B07BB1B6B3854FF", var_1.origin, "_encstr_9AF918713A67A6685578C31F83FA90F85F4109BB830F674BAD47", "_encstr_9BD90B2D1BBDE6BEC60B4E76CA");
  scripts\mp\objidpoolmanager::objective_playermask_single(var_2, self);
  var_0 thread watchfordeath(var_2);
  wait 3;
  scripts\mp\objidpoolmanager::returnobjectiveid(var_2);
}

watchfordeath(var_0) {
  self waittill("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  scripts\mp\objidpoolmanager::returnobjectiveid(var_0);
}

markasrelaysource(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 = var_0 getentitynumber();

  if(!isDefined(self.relaysource))
    self.relaysource = [];
  else if(isDefined(self.relaysource[var_1])) {
    self notify("_encstr_A3501299760BFF0D535338688781873F835A0615");
    self endon("_encstr_A3501299760BFF0D535338688781873F835A0615");
  }

  self.relaysource[var_1] = 1;
  var_0 scripts\engine\utility::_id_143B9(10, "_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self.relaysource[var_1] = 0;
}