/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3525.gsc
***************************************/

func_98D7() {
  level.func_115ED["ammo_regen"] = spawnStruct();
  level.func_115ED["ammo_regen"].func_118A3 = 1;
  level.func_115ED["ammo_regen"].func_5F36 = 60;
  level.func_115ED["ammo_regen"].func_6369 = "ammo_regen_complete";
  level.func_115ED["super_speed"] = spawnStruct();
  level.func_115ED["super_speed"].func_118A3 = 2;
  level.func_115ED["super_speed"].func_5F36 = 30;
  level.func_115ED["super_speed"].func_6369 = "super_speed_complete";
  level.func_115ED["jugg_squad"] = spawnStruct();
  level.func_115ED["jugg_squad"].func_118A3 = 3;
  level.func_115ED["jugg_squad"].func_5F36 = 15;
  level.func_115ED["jugg_squad"].func_6369 = "jugg_squad_complete";
  var_00 = scripts\mp\utility\game::getscorelimit();
  level.func_D410 = [];
  level.func_D410["axis"] = 0;
  level.func_D410["allies"] = 0;
  level.func_115EC = [];
  level.func_115EC["axis"] = 0;
  level.func_115EC["allies"] = 0;
  level thread watchplayerconnect();
  level thread func_11B02();
  setomnvar("ui_teamstreak_threshold", 4500);
  game["dialog"]["enemy_jugg"] = "enemy_juggernaut";
  game["dialog"]["friendly_jugg"] = "friendly_juggernaut";
}

watchplayerconnect() {
  level endon("game_ended");
  level endon("stop_teamstreaks");

  for(;;) {
    level waittill("connected", var_00);
    var_00 thread func_13AFC();
    var_00 thread func_13B0C();
  }
}

func_13AFC() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("death");

    if(self.team != "spectator") {
      if(!level.func_115EC[self.team]) {
        var_00 = level.func_D410[self.team] - 30;

        if(var_00 <= 0) {
          level.func_D410[self.team] = 0;
        } else {
          level.func_D410[self.team] = level.func_D410[self.team] - 30;
        }

        func_12F3D(self.team, level.func_D410[self.team]);
      }
    }
  }
}

func_13B0C() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("spawned_player");
    wait 1;

    if(self.team != "spectator") {
      self setclientomnvar("ui_teamstreak_score", level.func_D410[self.team]);
    }
  }
}

func_11B02() {
  level endon("game_ended");
  level endon("stop_teamstreaks");

  for(;;) {
    level waittill("update_player_score", var_00, var_01);

    if(!isDefined(var_00)) {
      continue;
    }
    if(!level.func_115EC[var_0.team]) {
      level.func_D410[var_0.team] = level.func_D410[var_0.team] + var_01;
      func_12F3D(var_0.team, level.func_D410[var_0.team]);

      if(level.func_D410[var_0.team] >= 4500) {
        var_02 = isreloading(3);
        var_03 = level.func_115ED[var_02].func_5F36;
        var_04 = level.func_115ED[var_02].func_6369;

        foreach(var_06 in level.players) {
          if(var_6.team != var_0.team) {
            var_06 scripts\mp\utility\game::leaderdialogonplayer("enemy_jugg");
            continue;
          }

          var_06 func_10DF9(var_02, var_03, var_04);
          var_06 scripts\mp\utility\game::leaderdialogonplayer("friendly_jugg");
        }

        level.func_115EC[var_0.team] = 1;
      }
    }
  }
}

isreloading(var_00) {
  var_01 = undefined;

  foreach(var_04, var_03 in level.func_115ED) {
    if(var_3.func_118A3 != var_00) {
      continue;
    }
    var_01 = var_04;
    break;
  }

  return var_01;
}

func_12F3D(var_00, var_01) {
  foreach(var_03 in level.players) {
    if(var_3.team != var_00) {
      continue;
    }
    var_03 setclientomnvar("ui_teamstreak_score", var_01);
  }
}

func_10DF9(var_00, var_01, var_02) {
  thread func_13B7D(var_01, var_02);

  switch (var_00) {
    case "ammo_regen":
      thread func_1E4A(var_02);
      break;
    case "super_speed":
      func_11266(var_02);
      break;
    case "jugg_squad":
      func_A4AE(var_02);
      break;
    default:
      break;
  }
}

func_13B7D(var_00, var_01) {
  self endon("disconnect");
  wait(var_00);
  self notify(var_01);
}

func_1E4A(var_00) {
  self endon("disconnect");
  self endon(var_00);

  for(;;) {
    var_01 = self getcurrentprimaryweapon();
    var_02 = self getweaponammoclip(var_01);

    if(var_02 != weaponclipsize(var_01)) {
      self setweaponammoclip(var_01, var_02 + 1);
    }

    wait 0.5;
  }
}

func_11266(var_00) {
  thread func_13B70(var_00);
  scripts\mp\utility\game::giveperk("specialty_fastreload");
  scripts\mp\utility\game::giveperk("specialty_quickdraw");
  scripts\mp\utility\game::giveperk("specialty_fastoffhand");
  scripts\mp\utility\game::giveperk("specialty_fastsprintrecovery");
  scripts\mp\utility\game::giveperk("specialty_marathon");
  scripts\mp\utility\game::giveperk("specialty_quickswap");
  scripts\mp\utility\game::giveperk("specialty_stalker");
  self.movespeedscaler = 1.2;
  scripts\mp\weapons::updatemovespeedscale();
}

func_13B70(var_00) {
  self endon(var_00);
  self waittill("spawned_player");
  func_11266(var_00);
}

func_A4AE(var_00) {
  var_01 = setclientweaponinfo();
  scripts\mp\killstreaks\juggernaut::givejuggernaut(var_01);
}

setclientweaponinfo() {
  var_00 = [];
  var_0[0] = "juggernaut";
  var_0[1] = "juggernaut_recon";
  var_0[2] = "juggernaut_maniac";
  var_01 = randomint(3);
  return var_0[var_01];
}