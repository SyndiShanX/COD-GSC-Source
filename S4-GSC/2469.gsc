/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2469.gsc
*************************************************/

_id_1101B() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");

  for(;;) {
    wait 1.0;
    var_0 = _func_0070(level._id_11056);
    var_1 = 1;

    if(isDefined(var_0)) {
      foreach(var_3 in var_0) {
        if(!isDefined(var_3) || !isDefined(var_3._id_1210) || !isDefined(var_3._id_0192) || var_3._id_0192 != self || !isPlayer(var_3._id_0192)) {
          continue;
        }
        if(!_id_DABA(var_3)) {
          continue;
        }
        if(isDefined(var_3._id_1C30._id_4130)) {
          var_4 = var_3._id_1C30._id_4130;
        } else {
          var_4 = var_3._id_02D6;
        }

        if(is_zombie_behind_and_close(var_3, var_4)) {
          _id_B313(var_3, "zmb_vox_behind", 1);
          wait 2.5;
        }
      }
    }
  }
}

_id_DABA(var_0) {
  switch (var_0._id_110B0) {
    case "trickster":
    case "screamer":
    case "juggernaut":
      return 0;
    default:
      return 1;
  }
}

_id_B312() {
  level endon("game_ended");
  self waittill("death");
  self _meth_83F8();
  self playSound("zmb_vox_death", undefined, self);
}

_id_1101A() {
  level endon("game_ended");
  self endon("death");
  thread _id_B312();
  self._id_B860 = 0;

  for(;;) {
    var_0 = randomfloatrange(2, 4);
    var_1 = scripts\engine\utility::_id_108AA(var_0, "attack_hit", "attack_miss", "zombie_non_lethal_damage", "zombie_lc_stunned");
    var_2 = undefined;

    if(!isDefined(self._id_0192) && var_1 != "timeout") {
      return;
    }
    var_3 = self._id_0192;

    if(isDefined(self._id_1C30._id_4130)) {
      var_4 = self._id_1C30._id_4130;
    } else {
      var_4 = self._id_91A3._id_02D6;
    }

    switch (var_1) {
      case "attack_hit":
        if(isPlayer(var_3)) {
          var_5 = scripts\cp\utility::isprotectedbyriotshieldcp(var_3);

          if(var_5[0]) {
            if(var_5[1]) {
              self playsoundtoplayer("zmb_riot_shield_swiped_front_plr", var_3);
              self playsoundtoteam("zmb_riot_shield_swiped_front_npc", var_3.team, var_3);
            } else {
              self playsoundtoplayer("zmb_riot_shield_swiped_back_plr", var_3);
              self playsoundtoteam("zmb_riot_shield_swiped_back_npc", var_3.team, var_3);
            }
          } else {
            self playsoundtoplayer("zmb_swiped_plr", var_3);
            self playsoundtoteam("zmb_swiped_npc", var_3.team, var_3);
          }

          if(self._id_110B0 == "base") {
            var_6 = randomintrange(0, 100);

            if(var_5[0] && istrue(var_3.hasriotshieldww) && isDefined(level.decimator_block_attack_dialogue_chance) && var_6 < level.decimator_block_attack_dialogue_chance) {
              var_3 _id_0720::_id_BEC0(level.decimator_block_attack_dialogue);
            } else {
              var_3 _id_0720::_id_BEC0("zombie_attack", 1);
            }
          }
        }
      case "attack_miss":
        level thread _id_B313(self, "zmb_vox_attack", 1);
        break;
      case "zombie_non_lethal_damage":
        level thread _id_B313(self, "zmb_vox_pain", 0);
        break;
      case "zombie_lc_stunned":
        level thread _id_B313(self, "zmb_vox_elec", 1);
        break;
      case "timeout":
        if(isDefined(self._id_0192)) {
          if(self._id_858B) {
            var_2 = "zmb_vox_crawler";
          } else if(var_4 == "run" || var_4 == "sprint") {
            var_2 = "zmb_vox_sprint";
          } else {
            var_2 = "zmb_vox_amb";
          }

          level thread _id_B313(self, var_2, 0);
        } else if(randomint(100) < 10)
          level thread _id_B313(self, "zmb_vox_amb", 0);

        break;
    }
  }
}

_id_B313(var_0, var_1, var_2) {
  var_0 endon("death");

  if(!isDefined(var_0)) {
    return;
  }
  if(_id_DF3E() && (istrue(var_2) || !istrue(var_0._id_B860))) {
    var_0 _id_B314(var_1);
  }
}

_id_B314(var_0) {
  if(_func_0205(var_0)) {
    self._id_B860 = 1;
    var_1 = _func_0142(var_0);
    self _meth_827E(var_0);
    wait(var_1 / 1000);
    self._id_B860 = 0;
  } else {}
}

_id_A431() {
  for(;;) {
    level._id_A74D = 0;
    wait 0.25;
  }
}

_id_DF3E() {
  if(!isDefined(level._id_A74D)) {
    level thread _id_A431();
  }

  if(level._id_A74D > 4) {
    return 0;
  }

  level._id_A74D++;
  return 1;
}

is_zombie_behind_and_close(var_0, var_1) {
  var_2 = 150;

  switch (var_1) {
    case "walk":
      var_2 = 200;
      break;
    case "run":
      var_2 = 250;
      break;
    case "sprint":
      var_2 = 300;
      break;
    case "super_sprint":
      var_2 = 350;
      break;
  }

  var_3 = distance2dsquared(self.origin, var_0.origin) < var_2 * var_2;
  return var_3 && _id_8565(self, var_0.origin);
}

_id_8565(var_0, var_1) {
  var_2 = var_0 _id_686F(var_1);
  var_3 = var_0.origin[2] - var_1[2];
  return (var_2 < -95 || var_2 > 95) && abs(var_3) < 50;
}

_id_686F(var_0) {
  var_1 = var_0;
  var_2 = self.angles[1] - _id_686E(var_1);
  var_2 = _func_000B(var_2);
  return var_2;
}

_id_686E(var_0) {
  var_1 = vectortoangles(var_0 - self.origin);
  return var_1[1];
}