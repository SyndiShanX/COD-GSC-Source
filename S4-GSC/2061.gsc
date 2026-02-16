/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2061.gsc
*************************************************/

_id_C9BA() {
  if(isDefined(level.disableambientcorpsespawn) && level.disableambientcorpsespawn) {
    return;
  }
  var_0 = scripts\cp_mp\utility\game_utility::_id_6B2D() == "mp_red_star";
  var_1 = scripts\engine\utility::array_randomize(scripts\engine\utility::getStructArray("mp_scripted_corpse_spawn", "targetname"));
  var_2 = 0;
  scripts\engine\utility::_id_0FDC("deathfx_bloodpool_generic", "vfx/iw8/char/blood/vfx_deathfx_bloodpool_01.vfx");

  if(getdvarint("#x3f72b4d799b71332d", -1) == 0) {
    return;
  }
  for(;;) {
    wait 5;

    foreach(var_4 in var_1) {
      if(istrue(var_4._id_017E)) {
        continue;
      }
      var_5 = scripts\engine\utility::_id_6369(var_4.origin, level.players, undefined, 3, 1000);
      var_6 = 1;

      foreach(var_8 in var_5) {
        if(_func_0202(var_8 getEye(), var_4.origin + (0, 0, 8), 0, var_8, 0)) {
          var_6 = 0;
          break;
        }
      }

      if(var_6) {
        var_10 = (0, 0, 0);

        if(isDefined(var_4.angles)) {
          var_10 = var_4.angles;
        }

        if(istrue(var_0)) {
          var_11 = "_snow";
        } else {
          var_11 = "";
        }

        var_12 = 1;
        var_13 = int(var_4._id_039B);

        if(isDefined(var_4._id_039B) && int(var_4._id_039B) == 0) {
          var_12 = "corpse_body_" + var_4._id_039B;
        } else if(isDefined(var_4._id_039B) && int(var_4._id_039B) > 0) {
          var_12 = "corpse_body_ger_0" + var_4._id_039B;
        } else {
          var_14 = randomint(5) + 1;
          var_12 = "corpse_body_ger_0" + var_14 + var_11;
        }

        var_15 = _func_03C5(var_12, var_4.origin, var_10);

        if(var_2 > getdvarint("#x38d178329a5bf9a7b", 15)) {
          var_15 _meth_869F("nextGenOnly");
        } else {
          playFX(scripts\engine\utility::getfx("deathfx_bloodpool_generic"), var_4.origin + (0, 0, 1));
        }

        var_4._id_017E = 1;
        var_2++;

        if(var_2 >= getdvarint("#x3f72b4d799b71332d", 15)) {
          return;
        }
        break;
      }

      wait 0.5;
    }
  }
}