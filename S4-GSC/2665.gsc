/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2665.gsc
*************************************************/

_id_CA34(var_0, var_1) {
  if(!istrue(level._id_5561)) {
    return;
  }
  self endon("death");
  self.owner endon("disconnect");
  var_2 = self.owner;
  var_3 = level._id_F902["uav_3dping"];

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  self._id_5590 = var_1;

  if(var_2 scripts\mp\utility\perk::_hasperk("specialty_equipment_ping")) {
    for(;;) {
      var_4 = 0;

      if(gettime() >= self._id_5590 + 3000) {
        var_5 = scripts\common\utility::_id_B7B6(self.origin, 300);

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
          if(isDefined(var_7._id_ACC5)) {
            continue;
          }
          var_8 = scripts\engine\utility::array_add(level.players, self);

          if(isDefined(var_0)) {
            var_8 = scripts\engine\utility::array_add(var_8, var_0);
          }

          var_9 = self.origin + anglestoup(self.angles) * 10;

          if(scripts\engine\trace::ray_trace_passed(var_9, var_7 gettagorigin("j_head"), var_8)) {
            if(!var_7 scripts\mp\utility\perk::_hasperk("specialty_gpsjammer")) {
              var_2 thread _id_9B27(var_7);
            }

            var_4 = 1;
          }
        }

        if(var_4) {
          if(!istrue(self._id_5864)) {
            self._id_5864 = 1;
          }

          _func_019D(var_3._id_6093, self, "tag_origin", var_2);
          self playsoundtoplayer("ghost_senses_ping", var_2);
          _func_0251(self.origin, var_2, 400, 800);
          wait 3;
        }
      }

      waitframe();
    }
  }
}

_id_9B2A(var_0, var_1) {
  var_0 endon("death_or_disconnect");

  if(!isDefined(var_0) || !scripts\mp\utility\player::isreallyalive(var_0)) {
    return;
  }
  thread _id_9B27(var_0);
  var_2 = _id_07F9::_id_C57D(10);

  if(var_2 == -1) {
    return;
  }
  _id_07F9::_id_A867(var_2, "active", var_1.origin, "cb_compassping_eqp_ping", "icon_large");
  _id_07F9::_id_A8A5(var_2, self);
  var_0 thread _id_10B02(var_2);
  wait 3;
  _id_07F9::_id_C799(var_2);
}

_id_10B02(var_0) {
  self waittill("death_or_disconnect");
  _id_07F9::_id_C799(var_0);
}

_id_9B27(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  var_1 = var_0 getentitynumber();

  if(!isDefined(self._id_C2F1)) {
    self._id_C2F1 = [];
  } else if(isDefined(self._id_C2F1[var_1])) {
    self notify("markAsRelaySource");
    self endon("markAsRelaySource");
  }

  self._id_C2F1[var_1] = 1;
  var_0 scripts\engine\utility::_id_108A7(10, "death_or_disconnect");
  self._id_C2F1[var_1] = 0;
}