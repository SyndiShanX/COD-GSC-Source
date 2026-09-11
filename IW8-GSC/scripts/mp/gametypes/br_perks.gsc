/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_perks.gsc
***********************************************/

function init() {
  level.br_perk_points_enabled = getdvarint("scr_br_perk_points", 0) != 0;

  if(!istrue(level.br_perk_points_enabled)) {
    return;
  }
}

function onplayerscore(var_0, var_1, var_2) {
  if(issubstr(var_0, "kill") && istrue(level.br_perk_points_enabled)) {
    if(var_0 != "last_stand_kill") {
      if(isDefined(var_1) && isalive(var_1)) {
        if(var_1.br_perkpoints < var_2.br_perkpoints && var_1 scripts\mp\utility\perk::_hasperk("specialty_br_bountyhunter")) {
          giveperkpointstoplayer(var_1, var_1, var_2.br_perkpoints - var_1.br_perkpoints);
          var_1 scripts\mp\perks\perks::_unsetperk("specialty_br_bountyhunter");
          return;
        }

        var_1 iprintlnbold("+1 Perk Point - " + var_2.name + " killed");
        perkpointsonkill(var_1, var_1);
      }
    }

    var_3 = scripts\mp\rank::getscoreinfovalue("score_increment");
    return var_3;
  }

  return 0;
}

function perkpointsonkill(var_0) {
  var_1 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_0.team, var_0.squadindex);

  foreach(var_0 in var_1) {
    giveperkpointstoplayer(var_0, 1);
  }
}

function perkpointspercentageplayersalive() {
  level endon("game_ended");
  level waittill("infils_ready");
  wait 5;
  var_0 = level.maxplayercount;
  var_1 = 100 / var_0;
  var_2 = 5;

  for(;;) {
    wait var_2;
    var_3 = scripts\mp\utility\game::getlivingplayers().size;
    var_4 = (var_0 - var_3) * var_1;

    if(!istrue(var_4 == 0)) {
      foreach(var_6 in level.players) {
        if(isalive(var_6)) {
          giveperkpointstoplayer(var_6, var_4);
        }
      }
    }

    var_0 = var_3;
  }
}

function takeperkpointpickup(var_0) {
  if(!istrue(level.br_perk_points_enabled)) {
    return;
  }

  var_1 = 1;

  if(isDefined(var_0.count)) {
    var_1 = var_0.count;
  }

  if(var_0.scriptablename == "brloot_perk_point") {
    perkpointspickup(self);
    return;
  }

  scripts\mp\gametypes\br_pickups::trypickupitem(var_0.scriptablename, var_1);
}

function perkpointspickup(var_0) {
  var_1 = getdvarint("scr_br_perk_points_pickup_value", 5);
  giveperkpointstoplayer(var_0, var_1);
}

function giveperkpointstoplayer(var_0, var_1) {
  var_0.br_perkpoints = clamp(var_0.br_perkpoints + var_1, 0, 150);

  if(var_0.br_perkpoints < 20) {
    var_0.perklevel = 0;
    return;
  }

  if(var_0.br_perkpoints < 30) {
    var_0.perklevel = 1;
    return;
  }

  if(var_0.br_perkpoints < 42) {
    var_0.perklevel = 2;
    return;
  }

  if(var_0.br_perkpoints < 56) {
    var_0.perklevel = 3;
    return;
  }

  if(var_0.br_perkpoints < 72) {
    var_0.perklevel = 4;
    return;
  }

  if(var_0.br_perkpoints < 90) {
    var_0.perklevel = 5;
    return;
  }

  if(var_0.br_perkpoints < 110) {
    var_0.perklevel = 6;
    return;
  }

  if(var_0.br_perkpoints < 130) {
    var_0.perklevel = 7;
    return;
  }

  if(var_0.br_perkpoints < 150) {
    var_0.perklevel = 8;
    return;
  }
}

function buyperkinslot(var_0) {
  if(var_0 < self.br_perks.size) {
    var_1 = self.br_perks[var_0];

    if(var_1 < 3) {
      if(self.br_perkpoints < var_1 + 1) {
        self iprintlnbold("You can't afford this perk!");
        return;
      }

      self.br_perks[var_0]++;

      switch (var_0) {
        case 0:
          if(var_1 == 0) {
            scripts\mp\utility\perk::giveperk("specialty_hard_shell");
            thread scripts\mp\hud_message::showsplash("br_specialty_hard_shell");
          } else if(var_1 == 1) {
            thread scripts\mp\hud_message::showsplash("br_specialty_throwback");
          } else if(var_1 == 2) {
            scripts\mp\utility\perk::giveperk("specialty_blastshield");
            thread scripts\mp\hud_message::showsplash("br_specialty_blastshield");
          }

          break;
        case 1:
          if(var_1 == 0) {
            scripts\mp\utility\perk::giveperk("specialty_lightweight");
            thread scripts\mp\hud_message::showsplash("br_specialty_lightweight");
          } else if(var_1 == 1) {
            scripts\mp\utility\perk::giveperk("specialty_marathon");
            thread scripts\mp\hud_message::showsplash("br_specialty_marathon");
          } else if(var_1 == 2) {
            scripts\mp\utility\perk::giveperk("specialty_quieter");
            thread scripts\mp\hud_message::showsplash("br_specialty_quieter");
          }

          break;
        case 2:
          if(var_1 == 0) {
            scripts\mp\utility\perk::giveperk("specialty_quickswap");
            thread scripts\mp\hud_message::showsplash("br_specialty_quickswap");
          } else if(var_1 == 1) {
            scripts\mp\utility\perk::giveperk("specialty_fastreload");
            thread scripts\mp\hud_message::showsplash("br_specialty_fastreload");
          } else if(var_1 == 2) {
            scripts\mp\utility\perk::giveperk("specialty_gung_ho");
            thread scripts\mp\hud_message::showsplash("br_specialty_gung_ho");
          }

          break;
        case 3:
          if(var_1 == 0) {
            scripts\mp\utility\perk::giveperk("specialty_boom");
            thread scripts\mp\hud_message::showsplash("br_specialty_boom");
          } else if(var_1 == 1) {
            scripts\mp\utility\perk::giveperk("specialty_selectivehearing");
            thread scripts\mp\hud_message::showsplash("br_specialty_selectivehearing");
          } else if(var_1 == 2) {
            scripts\mp\utility\perk::giveperk("specialty_tracker");
            thread scripts\mp\hud_message::showsplash("br_specialty_tracker");
          }

          break;
        case 4:
          if(var_1 == 0) {
            scripts\mp\utility\perk::giveperk("specialty_holdbreath");
            thread scripts\mp\hud_message::showsplash("br_specialty_holdbreath");
          } else if(var_1 == 1) {
            scripts\mp\utility\perk::giveperk("specialty_quickdraw");
            thread scripts\mp\hud_message::showsplash("br_specialty_quickdraw");
          } else if(var_1 == 2) {
            scripts\mp\utility\perk::giveperk("specialty_steadyaimpro");
            thread scripts\mp\hud_message::showsplash("br_specialty_steadyaim");
          }

          break;
        default:
          break;
      }

      return;
    }

    return;
  }
}