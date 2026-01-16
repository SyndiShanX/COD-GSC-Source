/***************************************************
 * Decompiled by Mjkzy and Edited by SyndiShanX
 * Script: scripts\mp\perks\perk_equipmentping.gsc
***************************************************/

runequipmentping(var_0, var_1) {
  self endon("death");
  self.owner endon("disconnect");
  var_2 = self.owner;
  var_3 = level.uavsettings["uav_3dping"];

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  self.equipping_lastpingtime = var_1;

  if(var_2 scripts\mp\utility::_hasperk("specialty_equipment_ping")) {
    for(;;) {
      var_4 = 0;

      if(gettime() >= self.equipping_lastpingtime + 3000) {
        foreach(var_6 in level.players) {
          if(!scripts\mp\utility::isreallyalive(var_6)) {
            continue;
          }
          if(!var_2 scripts\mp\utility::isenemy(var_6)) {
            continue;
          }
          if(var_6 scripts\mp\utility::_hasperk("specialty_engineer")) {
            continue;
          }
          if(isDefined(var_6.var_C78B)) {
            continue;
          }
          var_7 = scripts\engine\utility::array_add(level.players, self);

          if(isDefined(var_0)) {
            var_7 = scripts\engine\utility::array_add(var_7, var_0);
          }

          var_8 = self.origin + anglestoup(self.angles) * 10;

          if(distance2d(var_6.origin, self.origin) < 300 && scripts\common\trace::ray_trace_passed(var_8, var_6 gettagorigin("j_head"), var_7)) {
            if(!var_6 scripts\mp\utility::_hasperk("specialty_gpsjammer")) {
              var_2 thread markasrelaysource(var_6);
            }

            var_4 = 1;
          }
        }

        if(var_4) {
          if(!scripts\mp\utility::istrue(self.eyespyalerted)) {
            var_2 scripts\mp\missions::func_D991("ch_trait_eye_spy");
            self.eyespyalerted = 1;
          }

          playfxontagforclients(var_3.var_7636, self, "tag_origin", var_2);
          self playsoundtoplayer("ghost_senses_ping", var_2);
          triggerportableradarping(self.origin, var_2, 400, 800);
          wait 3;
        }
      }

      scripts\engine\utility::waitframe();
    }
  }
}

markdangerzoneonminimap(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("disconnect");

  if(!isDefined(var_0) || !scripts\mp\utility::isreallyalive(var_0)) {
    return;
  }
  thread markasrelaysource(var_0);
  var_2 = scripts\mp\objidpoolmanager::requestminimapid(10);

  if(var_2 == -1) {
    return;
  }
  scripts\mp\objidpoolmanager::minimap_objective_add(var_2, "active", var_1.origin, "cb_compassping_eqp_ping", "icon_large");
  scripts\mp\objidpoolmanager::minimap_objective_player(var_2, self getentitynumber());
  var_0 thread watchfordeath(var_2);
  wait 3;
  scripts\mp\objidpoolmanager::returnminimapid(var_2);
}

watchfordeath(var_0) {
  scripts\engine\utility::waittill_any("death", "disconnect");
  scripts\mp\objidpoolmanager::returnminimapid(var_0);
}

markasrelaysource(var_0) {
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
  var_0 scripts\engine\utility::waittill_any_timeout(10, "death", "disconnect");
  self.relaysource[var_1] = 0;
}