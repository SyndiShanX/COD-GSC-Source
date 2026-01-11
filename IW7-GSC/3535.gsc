/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3535.gsc
***************************************/

runequipmentping(var_00, var_01) {
  self endon("death");
  self.owner endon("disconnect");
  var_02 = self.owner;
  var_03 = level.uavsettings["uav_3dping"];

  if(!isDefined(var_01)) {
    var_01 = 0;
  }

  self.equipping_lastpingtime = var_01;

  if(var_02 scripts\mp\utility\game::_hasperk("specialty_equipment_ping")) {
    for(;;) {
      var_04 = 0;

      if(gettime() >= self.equipping_lastpingtime + 3000) {
        foreach(var_06 in level.players) {
          if(!scripts\mp\utility\game::isreallyalive(var_06)) {
            continue;
          }
          if(!var_02 scripts\mp\utility\game::isenemy(var_06)) {
            continue;
          }
          if(var_06 scripts\mp\utility\game::_hasperk("specialty_engineer")) {
            continue;
          }
          if(isDefined(var_6.func_C78B)) {
            continue;
          }
          var_07 = scripts\engine\utility::array_add(level.players, self);

          if(isDefined(var_00)) {
            var_07 = scripts\engine\utility::array_add(var_07, var_00);
          }

          var_08 = self.origin + anglestoup(self.angles) * 10;

          if(distance2d(var_6.origin, self.origin) < 300 && scripts\engine\trace::ray_trace_passed(var_08, var_06 gettagorigin("j_head"), var_07)) {
            if(!var_06 scripts\mp\utility\game::_hasperk("specialty_gpsjammer")) {
              var_02 thread markasrelaysource(var_06);
            }

            var_04 = 1;
          }
        }

        if(var_04) {
          if(!scripts\mp\utility\game::istrue(self.eyespyalerted)) {
            var_02 scripts\mp\missions::func_D991("ch_trait_eye_spy");
            self.eyespyalerted = 1;
          }

          playfxontagforclients(var_3.func_7636, self, "tag_origin", var_02);
          self playsoundtoplayer("ghost_senses_ping", var_02);
          triggerportableradarping(self.origin, var_02, 400, 800);
          wait 3;
        }
      }

      scripts\engine\utility::waitframe();
    }
  }
}

markdangerzoneonminimap(var_00, var_01) {
  var_00 endon("death");
  var_00 endon("disconnect");

  if(!isDefined(var_00) || !scripts\mp\utility\game::isreallyalive(var_00)) {
    return;
  }
  thread markasrelaysource(var_00);
  var_02 = scripts\mp\objidpoolmanager::requestminimapid(10);

  if(var_02 == -1) {
    return;
  }
  scripts\mp\objidpoolmanager::minimap_objective_add(var_02, "active", var_1.origin, "cb_compassping_eqp_ping", "icon_large");
  scripts\mp\objidpoolmanager::minimap_objective_player(var_02, self getentitynumber());
  var_00 thread watchfordeath(var_02);
  wait 3;
  scripts\mp\objidpoolmanager::returnminimapid(var_02);
}

watchfordeath(var_00) {
  scripts\engine\utility::waittill_any("death", "disconnect");
  scripts\mp\objidpoolmanager::returnminimapid(var_00);
}

markasrelaysource(var_00) {
  level endon("game_ended");
  self endon("disconnect");
  var_01 = var_00 getentitynumber();

  if(!isDefined(self.relaysource)) {
    self.relaysource = [];
  } else if(isDefined(self.relaysource[var_01])) {
    self notify("markAsRelaySource");
    self endon("markAsRelaySource");
  }

  self.relaysource[var_01] = 1;
  var_00 scripts\engine\utility::waittill_any_timeout(10, "death", "disconnect");
  self.relaysource[var_01] = 0;
}