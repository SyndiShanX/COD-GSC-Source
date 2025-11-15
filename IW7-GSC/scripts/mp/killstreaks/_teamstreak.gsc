/**************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_teamstreak.gsc
**************************************************/

func_98D7() {
  level.var_115ED["ammo_regen"] = spawnStruct();
  level.var_115ED["ammo_regen"].var_118A3 = 1;
  level.var_115ED["ammo_regen"].var_5F36 = 60;
  level.var_115ED["ammo_regen"].var_6369 = "ammo_regen_complete";
  level.var_115ED["super_speed"] = spawnStruct();
  level.var_115ED["super_speed"].var_118A3 = 2;
  level.var_115ED["super_speed"].var_5F36 = 30;
  level.var_115ED["super_speed"].var_6369 = "super_speed_complete";
  level.var_115ED["jugg_squad"] = spawnStruct();
  level.var_115ED["jugg_squad"].var_118A3 = 3;
  level.var_115ED["jugg_squad"].var_5F36 = 15;
  level.var_115ED["jugg_squad"].var_6369 = "jugg_squad_complete";
  var_00 = scripts\mp\utility::getscorelimit();
  level.var_D410 = [];
  level.var_D410["axis"] = 0;
  level.var_D410["allies"] = 0;
  level.var_115EC = [];
  level.var_115EC["axis"] = 0;
  level.var_115EC["allies"] = 0;
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
      if(!level.var_115EC[self.team]) {
        var_00 = level.var_D410[self.team] - 30;
        if(var_00 <= 0) {
          level.var_D410[self.team] = 0;
        } else {
          level.var_D410[self.team] = level.var_D410[self.team] - 30;
        }

        func_12F3D(self.team, level.var_D410[self.team]);
      }
    }
  }
}

func_13B0C() {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    self waittill("spawned_player");
    wait(1);
    if(self.team != "spectator") {
      self setclientomnvar("ui_teamstreak_score", level.var_D410[self.team]);
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

    if(!level.var_115EC[var_00.team]) {
      level.var_D410[var_00.team] = level.var_D410[var_00.team] + var_01;
      func_12F3D(var_00.team, level.var_D410[var_00.team]);
      if(level.var_D410[var_00.team] >= 4500) {
        var_02 = isreloading(3);
        var_03 = level.var_115ED[var_02].var_5F36;
        var_04 = level.var_115ED[var_02].var_6369;
        foreach(var_06 in level.players) {
          if(var_06.team != var_00.team) {
            var_06 scripts\mp\utility::leaderdialogonplayer("enemy_jugg");
            continue;
          }

          var_06 func_10DF9(var_02, var_03, var_04);
          var_06 scripts\mp\utility::leaderdialogonplayer("friendly_jugg");
        }

        level.var_115EC[var_00.team] = 1;
      }
    }
  }
}

isreloading(param_00) {
  var_01 = undefined;
  foreach(var_04, var_03 in level.var_115ED) {
    if(var_03.var_118A3 != param_00) {
      continue;
    }

    var_01 = var_04;
    break;
  }

  return var_01;
}

func_12F3D(param_00, param_01) {
  foreach(var_03 in level.players) {
    if(var_03.team != param_00) {
      continue;
    }

    var_03 setclientomnvar("ui_teamstreak_score", param_01);
  }
}

func_10DF9(param_00, param_01, param_02) {
  thread func_13B7D(param_01, param_02);
  switch (param_00) {
    case "ammo_regen":
      thread func_1E4A(param_02);
      break;

    case "super_speed":
      func_11266(param_02);
      break;

    case "jugg_squad":
      func_A4AE(param_02);
      break;

    default:
      break;
  }
}

func_13B7D(param_00, param_01) {
  self endon("disconnect");
  wait(param_00);
  self notify(param_01);
}

func_1E4A(param_00) {
  self endon("disconnect");
  self endon(param_00);
  for(;;) {
    var_01 = self getcurrentprimaryweapon();
    var_02 = self getweaponammoclip(var_01);
    if(var_02 != weaponclipsize(var_01)) {
      self setweaponammoclip(var_01, var_02 + 1);
    }

    wait(0.5);
  }
}

func_11266(param_00) {
  thread func_13B70(param_00);
  scripts\mp\utility::giveperk("specialty_fastreload");
  scripts\mp\utility::giveperk("specialty_quickdraw");
  scripts\mp\utility::giveperk("specialty_fastoffhand");
  scripts\mp\utility::giveperk("specialty_fastsprintrecovery");
  scripts\mp\utility::giveperk("specialty_marathon");
  scripts\mp\utility::giveperk("specialty_quickswap");
  scripts\mp\utility::giveperk("specialty_stalker");
  self.movespeedscaler = 1.2;
  scripts\mp\weapons::updatemovespeedscale();
}

func_13B70(param_00) {
  self endon(param_00);
  self waittill("spawned_player");
  func_11266(param_00);
}

func_A4AE(param_00) {
  var_01 = setclientweaponinfo();
  scripts\mp\killstreaks\_juggernaut::givejuggernaut(var_01);
}

setclientweaponinfo() {
  var_00 = [];
  var_00[0] = "juggernaut";
  var_00[1] = "juggernaut_recon";
  var_00[2] = "juggernaut_maniac";
  var_01 = randomint(3);
  return var_00[var_01];
}