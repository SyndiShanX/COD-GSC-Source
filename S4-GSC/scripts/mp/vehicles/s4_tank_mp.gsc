/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\vehicles\s4_tank_mp.gsc
*************************************************/

s4_tank_mp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("s4_tank", "activate", ::s4_tank_mp_activate);
  scripts\cp_mp\utility\script_utility::registersharedfunc("s4_tank", "spawnCallback", ::s4_tank_mp_spawncallback);
  scripts\cp_mp\vehicles\vehicle_tracking::_id_102C2("s4_tank", 6);
  scripts\cp_mp\vehicles\vehicle_tracking::_id_102C4("s4_tank", 3);
  _id_0A97::_id_C28A(scripts\cp_mp\vehicles\s4_tank::s4_tank_updateheadiconforplayeronjointeam);
  s4_tank_mp_initspawning();
  _id_0AC1::_id_1022A("s4_tank", scripts\cp_mp\vehicles\s4_tank::s4_tank_explode);
}

s4_tank_mp_initspawning() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("s4_tank", 1);
  var_0._id_0E01 = scripts\cp_mp\vehicles\s4_tank::s4_tank_timeout;

  if(scripts\mp\utility\game::getgametype() == "arm") {
    var_0._id_0E02 = 105;
    var_0._id_C69E = level._id_EE45;
  } else
    var_0._id_0E02 = 40;
}

s4_tank_mp_activate(var_0) {
  var_0 thread _id_2462();
  _id_0AC1::_id_10229(var_0);
}

s4_tank_mp_shouldawardattacker(var_0, var_1) {
  if(!isDefined(var_1)) {
    return 0;
  }

  if(level.teambased && var_1.team == var_0.team) {
    return 0;
  }

  if(isDefined(var_0.owner) && var_1 == var_0.owner) {
    return 0;
  }

  return 1;
}

_id_2462() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    if(scripts\mp\utility\teams::_id_8878(self.team)) {
      var_0 = scripts\common\utility::_id_B7BF(self.origin, 3000);

      foreach(var_2 in var_0) {
        var_3 = isDefined(var_2) && var_2 scripts\cp_mp\utility\player_utility::_isalive() && scripts\mp\utility\player::isenemy(var_2);

        if(!var_3) {
          continue;
        }
        var_4 = anglesToForward(var_2 getplayerangles());
        var_5 = scripts\engine\math::_id_178B(var_4, self.origin - var_2.origin);

        if(isDefined(var_5) && var_5 <= 60) {
          if(self _meth_83CD(var_2 getEye(), self) > 0.1) {}

          waitframe();
        }
      }
    }

    wait 0.1;
  }
}

s4_tank_mp_spawncallback(var_0, var_1) {
  scripts\cp_mp\vehicles\s4_tank::s4_tank_initializespawndata(var_0);

  if(!isDefined(var_0._id_E325)) {
    var_0._id_E325 = "place_at_position_unsafe";
  }

  if(!isDefined(var_0._id_DCB0)) {
    var_0._id_DCB0 = 0;
  }

  var_0._id_31F7 = 0;
  var_2 = scripts\cp_mp\vehicles\s4_tank::s4_tank_spawn(var_0, var_1);

  if(isDefined(var_2) && scripts\cp_mp\vehicles\vehicle_spawn::_id_10272()) {
    var_2._id_AAA9 = ::s4_tank_mp_ondeathrespawncallback;
  }

  return var_2;
}

s4_tank_mp_ondeathrespawncallback() {
  thread s4_tank_mp_waitandspawn();
}

s4_tank_mp_waitandspawn() {
  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::_id_6E3F(self);
  var_1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::_id_3D67(var_0, var_1);
  scripts\cp_mp\vehicles\s4_tank::s4_tank_copyspawndata(var_0, var_1);
  var_2 = spawnStruct();
  var_3 = scripts\cp_mp\vehicles\vehicle_spawn::_id_10290("s4_tank", var_1, var_2);

  if(isDefined(var_3)) {
    if(scripts\mp\utility\game::getgametype() == "arm") {
      if(istrue(level._id_DCF1)) {
        scripts\mp\gametypes\arm::_id_1002A(var_3, var_3.team);
      }

      foreach(var_5 in level.players) {
        if(var_5.team == var_3.team) {
          var_5 _id_0A99::_id_D5EA(62, undefined, 5);
        }
      }
    }
  }
}