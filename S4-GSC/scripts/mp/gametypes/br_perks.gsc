/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_perks.gsc
*************************************************/

init() {
  level._id_2A84 = getdvarint("#x32d737c8eca28794c", 0) != 0;

  if(!istrue(level._id_2A84)) {
    return;
  }
}

_id_AB75(var_0, var_1, var_2) {
  if(issubstr(var_0, "kill") && istrue(level._id_2A84)) {
    if(var_0 != "last_stand_kill") {
      if(isDefined(var_1) && isalive(var_1)) {
        if(var_1._id_2A85 < var_2._id_2A85 && var_1 scripts\mp\utility\perk::_hasperk("specialty_br_bountyhunter")) {
          var_1 _id_6FC4(var_1, var_2._id_2A85 - var_1._id_2A85);
          var_1 scripts\mp\perks\perks::_unsetperk("specialty_br_bountyhunter");
          return;
        }

        var_1 iprintlnbold("+1 Perk Point - " + var_2.name + " killed");
        var_1 _id_AFF2(var_1);
      }
    }

    var_3 = scripts\mp\rank::getscoreinfovalue("score_increment");
    return var_3;
  }

  return 0;
}

_id_AFF2(var_0) {
  var_1 = scripts\mp\utility\teams::_id_6DCA(var_0.team, "players");

  foreach(var_0 in var_1) {
    _id_6FC4(var_0, 1.0);
  }
}

_id_AFF3() {
  level endon("game_ended");
  level waittill("infils_ready");
  wait 5;
  var_0 = level._id_9C91;
  var_1 = 100.0 / var_0;
  var_2 = 5.0;

  for(;;) {
    wait(var_2);
    var_3 = scripts\mp\utility\game::_id_6B13().size;
    var_4 = (var_0 - var_3) * var_1;

    if(!istrue(var_4 == 0)) {
      foreach(var_6 in level.players) {
        if(isalive(var_6)) {
          _id_6FC4(var_6, var_4);
        }
      }
    }

    var_0 = var_3;
  }
}

_id_EDCF(var_0) {
  if(!istrue(level._id_2A84)) {
    return;
  }
  var_1 = 1;

  if(isDefined(var_0._id_011A)) {
    var_1 = var_0._id_011A;
  }

  if(var_0._id_CF22 == "brloot_perk_point") {
    _id_AFF4(self);
  } else {
    scripts\mp\gametypes\br_pickups::_id_F752(var_0._id_CF22, var_1);
  }
}

_id_AFF4(var_0) {
  var_1 = getdvarint("#x39aa3f4618730d393", 5.0);
  _id_6FC4(var_0, var_1);
}

_id_6FC4(var_0, var_1) {
  var_0._id_2A85 = clamp(var_0._id_2A85 + var_1, 0, 150);

  if(var_0._id_2A85 < 20) {
    var_0._id_AFD1 = 0;
  } else if(var_0._id_2A85 < 30) {
    var_0._id_AFD1 = 1;
  } else if(var_0._id_2A85 < 42) {
    var_0._id_AFD1 = 2;
  } else if(var_0._id_2A85 < 56) {
    var_0._id_AFD1 = 3;
  } else if(var_0._id_2A85 < 72) {
    var_0._id_AFD1 = 4;
  } else if(var_0._id_2A85 < 90) {
    var_0._id_AFD1 = 5;
  } else if(var_0._id_2A85 < 110) {
    var_0._id_AFD1 = 6;
  } else if(var_0._id_2A85 < 130) {
    var_0._id_AFD1 = 7;
  } else if(var_0._id_2A85 < 150) {
    var_0._id_AFD1 = 8;
  }
}

_id_2DE4(var_0) {
  if(var_0 < self._id_2A86.size) {
    var_1 = self._id_2A86[var_0];

    if(var_1 < 3) {
      if(self._id_2A85 < var_1 + 1) {
        self iprintlnbold("You can't afford this perk!");
      } else {
        self._id_2A86[var_0]++;

        switch (var_0) {
          case 0:
            if(var_1 == 0) {
              scripts\mp\utility\perk::_id_6FC2("specialty_hard_shell");
              thread scripts\mp\hud_message::showsplash("br_specialty_hard_shell");
            } else if(var_1 == 1)
              thread scripts\mp\hud_message::showsplash("br_specialty_throwback");
            else if(var_1 == 2) {
              scripts\mp\utility\perk::_id_6FC2("specialty_blastshield");
              thread scripts\mp\hud_message::showsplash("br_specialty_blastshield");
            }

            break;
          case 1:
            if(var_1 == 0) {
              scripts\mp\utility\perk::_id_6FC2("specialty_lightweight");
              thread scripts\mp\hud_message::showsplash("br_specialty_lightweight");
            } else if(var_1 == 1) {
              scripts\mp\utility\perk::_id_6FC2("specialty_marathon");
              thread scripts\mp\hud_message::showsplash("br_specialty_marathon");
            } else if(var_1 == 2) {
              scripts\mp\utility\perk::_id_6FC2("specialty_quieter");
              thread scripts\mp\hud_message::showsplash("br_specialty_quieter");
            }

            break;
          case 2:
            if(var_1 == 0) {
              scripts\mp\utility\perk::_id_6FC2("specialty_quickswap");
              thread scripts\mp\hud_message::showsplash("br_specialty_quickswap");
            } else if(var_1 == 1) {
              scripts\mp\utility\perk::_id_6FC2("specialty_fastreload");
              thread scripts\mp\hud_message::showsplash("br_specialty_fastreload");
            } else if(var_1 == 2) {
              scripts\mp\utility\perk::_id_6FC2("specialty_gung_ho");
              thread scripts\mp\hud_message::showsplash("br_specialty_gung_ho");
            }

            break;
          case 3:
            if(var_1 == 0) {
              scripts\mp\utility\perk::_id_6FC2("specialty_boom");
              thread scripts\mp\hud_message::showsplash("br_specialty_boom");
            } else if(var_1 == 1) {
              scripts\mp\utility\perk::_id_6FC2("specialty_selectivehearing");
              thread scripts\mp\hud_message::showsplash("br_specialty_selectivehearing");
            } else if(var_1 == 2) {
              scripts\mp\utility\perk::_id_6FC2("specialty_tracker");
              thread scripts\mp\hud_message::showsplash("br_specialty_tracker");
            }

            break;
          case 4:
            if(var_1 == 0) {
              scripts\mp\utility\perk::_id_6FC2("specialty_holdbreath");
              thread scripts\mp\hud_message::showsplash("br_specialty_holdbreath");
            } else if(var_1 == 1) {
              scripts\mp\utility\perk::_id_6FC2("specialty_quickdraw");
              thread scripts\mp\hud_message::showsplash("br_specialty_quickdraw");
            } else if(var_1 == 2) {
              scripts\mp\utility\perk::_id_6FC2("specialty_steadyaimpro");
              thread scripts\mp\hud_message::showsplash("br_specialty_steadyaim");
            }

            break;
          default:
            break;
        }
      }
    }
  }
}