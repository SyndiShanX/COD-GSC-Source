/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\perks\perk_equipmentping.gsc
***************************************************/

function runequipmentping(var0, var1) {
  if(!istrue(level.equipmentpingactive)) {
    return;
  }

  self endon("death");
  self.owner endon("disconnect");
  var2 = self.owner;
  var3 = level.uavsettings["uav_3dping"];

  if(!isDefined(var1)) {
    var1 = 0;
  }

  self.equipping_lastpingtime = var1;

  if(var2 scripts\mp\utility\perk::_hasperk("specialty_equipment_ping")) {
    for(;;) {
      var4 = 0;

      if(gettime() >= self.equipping_lastpingtime + 3000) {
        var5 = scripts\common\utility::playersincylinder(self.origin, 300);

        foreach(var7 in var5) {
          if(!scripts\mp\utility\player::isreallyalive(var7)) {
            continue;
          }

          if(!var2 scripts\mp\utility\player::isenemy(var7)) {
            continue;
          }

          if(var7 scripts\mp\utility\perk::_hasperk("specialty_location_marking")) {
            continue;
          }

          if(isDefined(var7.outlined)) {
            continue;
          }

          var8 = scripts\engine\utility::array_add(level.players, self);

          if(isDefined(var0)) {
            var8 = scripts\engine\utility::array_add(var8, var0);
          }

          var9 = self.origin + anglestoup(self.angles) * 10;

          if(scripts\engine\trace::ray_trace_passed(var9, var7 gettagorigin("j_head"), var8)) {
            if(!var7 scripts\mp\utility\perk::_hasperk("specialty_gpsjammer")) {
              thread markasrelaysource(var2);
            }

            var4 = 1;
          }
        }

        if(var4) {
          if(!istrue(self.eyespyalerted)) {
            self.eyespyalerted = 1;
          }

          playfxontagforclients(var3.fxid_ping, self, "tag_origin", var2);
          self playsoundtoplayer("ghost_senses_ping", var2);
          triggerportableradarping(self.origin, var2, 400, 800);
          wait 3;
        }
      }

      waitframe();
    }

    return;
  }
}

function markdangerzoneonminimap(var0, var1) {
  var0 endon("death_or_disconnect");

  if(!isDefined(var0) || !scripts\mp\utility\player::isreallyalive(var0)) {
    return;
  }

  thread markasrelaysource(var0);
  var2 = scripts\mp\objidpoolmanager::requestobjectiveid(10);

  if(var2 == -1) {
    return;
  }

  scripts\mp\objidpoolmanager::objective_add_objective(var2, "active", var1.origin, "cb_compassping_eqp_ping", "icon_large");
  scripts\mp\objidpoolmanager::objective_playermask_single(var2, self);
  thread watchfordeath(var0);
  wait 3;
  scripts\mp\objidpoolmanager::returnobjectiveid(var2);
}

function watchfordeath(var0) {
  self waittill("death_or_disconnect");
  scripts\mp\objidpoolmanager::returnobjectiveid(var0);
}

function markasrelaysource(var0) {
  level endon("game_ended");
  self endon("disconnect");
  var1 = var0 getentitynumber();

  if(!isDefined(self.relaysource)) {
    self.relaysource = [];
  } else if(isDefined(self.relaysource[var1])) {
    self notify("markAsRelaySource");
    self endon("markAsRelaySource");
  }

  self.relaysource[var1] = 1;
  var0 scripts\engine\utility::ref_143b9(10, "death_or_disconnect");
  self.relaysource[var1] = 0;
}