/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\perks\perk_equipmentping.gsc
***************************************************/

function runequipmentping(var_0, var_1) {
  if(!istrue(level.equipmentpingactive)) {
    return;
  }

  self endon("death");
  self.owner endon("disconnect");
  var_2 = self.owner;
  var_3 = level.uavsettings["uav_3dping"];

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  self.equipping_lastpingtime = var_1;

  if(var_2 scripts\mp\utility\perk::_hasperk("specialty_equipment_ping")) {
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

          if(var_7 scripts\mp\utility\perk::_hasperk("specialty_location_marking")) {
            continue;
          }

          if(isDefined(var_7.outlined)) {
            continue;
          }

          var_8 = scripts\engine\utility::array_add(level.players, self);

          if(isDefined(var_0)) {
            var_8 = scripts\engine\utility::array_add(var_8, var_0);
          }

          var_9 = self.origin + anglestoup(self.angles) * 10;

          if(scripts\engine\trace::ray_trace_passed(var_9, var_7 gettagorigin("j_head"), var_8)) {
            if(!var_7 scripts\mp\utility\perk::_hasperk("specialty_gpsjammer")) {
              thread markasrelaysource(var_2);
            }

            var_4 = 1;
          }
        }

        if(var_4) {
          if(!istrue(self.eyespyalerted)) {
            self.eyespyalerted = 1;
          }

          playfxontagforclients(var_3.fxid_ping, self, "tag_origin", var_2);
          self playsoundtoplayer("ghost_senses_ping", var_2);
          triggerportableradarping(self.origin, var_2, 400, 800);
          wait 3;
        }
      }

      waitframe();
    }

    return;
  }
}

function markdangerzoneonminimap(var_0, var_1) {
  var_0 endon("death_or_disconnect");

  if(!isDefined(var_0) || !scripts\mp\utility\player::isreallyalive(var_0)) {
    return;
  }

  thread markasrelaysource(var_0);
  var_2 = scripts\mp\objidpoolmanager::requestobjectiveid(10);

  if(var_2 == -1) {
    return;
  }

  scripts\mp\objidpoolmanager::objective_add_objective(var_2, "active", var_1.origin, "cb_compassping_eqp_ping", "icon_large");
  scripts\mp\objidpoolmanager::objective_playermask_single(var_2, self);
  thread watchfordeath(var_0);
  wait 3;
  scripts\mp\objidpoolmanager::returnobjectiveid(var_2);
}

function watchfordeath(var_0) {
  self waittill("death_or_disconnect");
  scripts\mp\objidpoolmanager::returnobjectiveid(var_0);
}

function markasrelaysource(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  var_1 = var_0 getentitynumber();

  if(!isDefined(self.relaysource)) {
    self.relaysource = [];
  } else if(isDefined(self.relaysource[var_1])) {
    self notify("markAsRelaySource");
    self endon("markAsRelaySource");
  }

  self.relaysource[var_1] = 1;
  var_0 scripts\engine\utility::ref_143B9(10, "death_or_disconnect");
  self.relaysource[var_1] = 0;
}