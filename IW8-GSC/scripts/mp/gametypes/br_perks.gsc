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

function onplayerscore(var0, var1, var2) {
  if(issubstr(var0, "kill") && istrue(level.br_perk_points_enabled)) {
    if(var0 != "last_stand_kill") {
      if(isDefined(var1) && isalive(var1)) {
        if(var1.br_perkpoints < var2.br_perkpoints && var1 scripts\mp\utility\perk::_hasperk("specialty_br_bountyhunter")) {
          giveperkpointstoplayer(var1, var1, var2.br_perkpoints - var1.br_perkpoints);
          var1 scripts\mp\perks\perks::_unsetperk("specialty_br_bountyhunter");
          return;
        }

        var1 iprintlnbold("+1 Perk Point - " + var2.name + " killed");
        perkpointsonkill(var1, var1);
      }
    }

    var3 = scripts\mp\rank::getscoreinfovalue("score_increment");
    return var3;
  }

  return 0;
}

function perkpointsonkill(var0) {
  var1 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var0.team, var0.squadindex);

  foreach(var0 in var1) {
    giveperkpointstoplayer(var0, 1);
  }
}

function perkpointspercentageplayersalive() {
  level endon("game_ended");
  level waittill("infils_ready");
  wait 5;
  var0 = level.maxplayercount;
  var1 = 100 / var0;
  var2 = 5;

  for(;;) {
    wait var2;
    var3 = scripts\mp\utility\game::getlivingplayers().size;
    var4 = (var0 - var3) * var1;

    if(!istrue(var4 == 0)) {
      foreach(var6 in level.players) {
        if(isalive(var6)) {
          giveperkpointstoplayer(var6, var4);
        }
      }
    }

    var0 = var3;
  }
}

function takeperkpointpickup(var0) {
  if(!istrue(level.br_perk_points_enabled)) {
    return;
  }

  var1 = 1;

  if(isDefined(var0.count)) {
    var1 = var0.count;
  }

  if(var0.scriptablename == "brloot_perk_point") {
    perkpointspickup(self);
    return;
  }

  scripts\mp\gametypes\br_pickups::trypickupitem(var0.scriptablename, var1);
}

function perkpointspickup(var0) {
  var1 = getdvarint("scr_br_perk_points_pickup_value", 5);
  giveperkpointstoplayer(var0, var1);
}

function giveperkpointstoplayer(var0, var1) {
  var0.br_perkpoints = clamp(var0.br_perkpoints + var1, 0, 150);

  if(var0.br_perkpoints < 20) {
    var0.perklevel = 0;
    return;
  }

  if(var0.br_perkpoints < 30) {
    var0.perklevel = 1;
    return;
  }

  if(var0.br_perkpoints < 42) {
    var0.perklevel = 2;
    return;
  }

  if(var0.br_perkpoints < 56) {
    var0.perklevel = 3;
    return;
  }

  if(var0.br_perkpoints < 72) {
    var0.perklevel = 4;
    return;
  }

  if(var0.br_perkpoints < 90) {
    var0.perklevel = 5;
    return;
  }

  if(var0.br_perkpoints < 110) {
    var0.perklevel = 6;
    return;
  }

  if(var0.br_perkpoints < 130) {
    var0.perklevel = 7;
    return;
  }

  if(var0.br_perkpoints < 150) {
    var0.perklevel = 8;
    return;
  }
}

function buyperkinslot(var0) {
  if(var0 < self.br_perks.size) {
    var1 = self.br_perks[var0];

    if(var1 < 3) {
      if(self.br_perkpoints < var1 + 1) {
        self iprintlnbold("You can't afford this perk!");
        return;
      }

      self.br_perks[var0]++;

      switch (var0) {
        case 0:
          if(var1 == 0) {
            scripts\mp\utility\perk::giveperk("specialty_hard_shell");
            thread scripts\mp\hud_message::showsplash("br_specialty_hard_shell");
          } else if(var1 == 1) {
            thread scripts\mp\hud_message::showsplash("br_specialty_throwback");
          } else if(var1 == 2) {
            scripts\mp\utility\perk::giveperk("specialty_blastshield");
            thread scripts\mp\hud_message::showsplash("br_specialty_blastshield");
          }

          break;
        case 1:
          if(var1 == 0) {
            scripts\mp\utility\perk::giveperk("specialty_lightweight");
            thread scripts\mp\hud_message::showsplash("br_specialty_lightweight");
          } else if(var1 == 1) {
            scripts\mp\utility\perk::giveperk("specialty_marathon");
            thread scripts\mp\hud_message::showsplash("br_specialty_marathon");
          } else if(var1 == 2) {
            scripts\mp\utility\perk::giveperk("specialty_quieter");
            thread scripts\mp\hud_message::showsplash("br_specialty_quieter");
          }

          break;
        case 2:
          if(var1 == 0) {
            scripts\mp\utility\perk::giveperk("specialty_quickswap");
            thread scripts\mp\hud_message::showsplash("br_specialty_quickswap");
          } else if(var1 == 1) {
            scripts\mp\utility\perk::giveperk("specialty_fastreload");
            thread scripts\mp\hud_message::showsplash("br_specialty_fastreload");
          } else if(var1 == 2) {
            scripts\mp\utility\perk::giveperk("specialty_gung_ho");
            thread scripts\mp\hud_message::showsplash("br_specialty_gung_ho");
          }

          break;
        case 3:
          if(var1 == 0) {
            scripts\mp\utility\perk::giveperk("specialty_boom");
            thread scripts\mp\hud_message::showsplash("br_specialty_boom");
          } else if(var1 == 1) {
            scripts\mp\utility\perk::giveperk("specialty_selectivehearing");
            thread scripts\mp\hud_message::showsplash("br_specialty_selectivehearing");
          } else if(var1 == 2) {
            scripts\mp\utility\perk::giveperk("specialty_tracker");
            thread scripts\mp\hud_message::showsplash("br_specialty_tracker");
          }

          break;
        case 4:
          if(var1 == 0) {
            scripts\mp\utility\perk::giveperk("specialty_holdbreath");
            thread scripts\mp\hud_message::showsplash("br_specialty_holdbreath");
          } else if(var1 == 1) {
            scripts\mp\utility\perk::giveperk("specialty_quickdraw");
            thread scripts\mp\hud_message::showsplash("br_specialty_quickdraw");
          } else if(var1 == 2) {
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