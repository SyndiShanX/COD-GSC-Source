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
  var_0 = scripts\mp\utility::getscorelimit();
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
    level waittill("connected", var_0);
    var_0 thread func_13AFC();
    var_0 thread func_13B0C();
  }
}

func_13AFC() {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    self waittill("death");
    if(self.team != "spectator") {
      if(!level.var_115EC[self.team]) {
        var_0 = level.var_D410[self.team] - 30;
        if(var_0 <= 0) {
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
    level waittill("update_player_score", var_0, var_1);
    if(!isDefined(var_0)) {
      continue;
    }

    if(!level.var_115EC[var_0.team]) {
      level.var_D410[var_0.team] = level.var_D410[var_0.team] + var_1;
      func_12F3D(var_0.team, level.var_D410[var_0.team]);
      if(level.var_D410[var_0.team] >= 4500) {
        var_2 = isreloading(3);
        var_3 = level.var_115ED[var_2].var_5F36;
        var_4 = level.var_115ED[var_2].var_6369;
        foreach(var_6 in level.players) {
          if(var_6.team != var_0.team) {
            var_6 scripts\mp\utility::leaderdialogonplayer("enemy_jugg");
            continue;
          }

          var_6 func_10DF9(var_2, var_3, var_4);
          var_6 scripts\mp\utility::leaderdialogonplayer("friendly_jugg");
        }

        level.var_115EC[var_0.team] = 1;
      }
    }
  }
}

isreloading(var_0) {
  var_1 = undefined;
  foreach(var_4, var_3 in level.var_115ED) {
    if(var_3.var_118A3 != var_0) {
      continue;
    }

    var_1 = var_4;
    break;
  }

  return var_1;
}

func_12F3D(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(var_3.team != var_0) {
      continue;
    }

    var_3 setclientomnvar("ui_teamstreak_score", var_1);
  }
}

func_10DF9(var_0, var_1, var_2) {
  thread func_13B7D(var_1, var_2);
  switch (var_0) {
    case "ammo_regen":
      thread func_1E4A(var_2);
      break;

    case "super_speed":
      func_11266(var_2);
      break;

    case "jugg_squad":
      func_A4AE(var_2);
      break;

    default:
      break;
  }
}

func_13B7D(var_0, var_1) {
  self endon("disconnect");
  wait(var_0);
  self notify(var_1);
}

func_1E4A(var_0) {
  self endon("disconnect");
  self endon(var_0);
  for(;;) {
    var_1 = self getcurrentprimaryweapon();
    var_2 = self getweaponammoclip(var_1);
    if(var_2 != weaponclipsize(var_1)) {
      self setweaponammoclip(var_1, var_2 + 1);
    }

    wait(0.5);
  }
}

func_11266(var_0) {
  thread func_13B70(var_0);
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

func_13B70(var_0) {
  self endon(var_0);
  self waittill("spawned_player");
  func_11266(var_0);
}

func_A4AE(var_0) {
  var_1 = setclientweaponinfo();
  scripts\mp\killstreaks\_juggernaut::givejuggernaut(var_1);
}

setclientweaponinfo() {
  var_0 = [];
  var_0[0] = "juggernaut";
  var_0[1] = "juggernaut_recon";
  var_0[2] = "juggernaut_maniac";
  var_1 = randomint(3);
  return var_0[var_1];
}