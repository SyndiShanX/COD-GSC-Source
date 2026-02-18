/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_60a2f38d6d37fd6a.csc
***********************************************/

#using script_18910f59cc847b42;
#using script_30c7fb449869910;
#using script_3314b730521b9666;
#using script_38635d174016f682;
#using script_42cbbdcd1e160063;
#using script_64e5d3ad71ce8140;
#using script_67049b48b589d81;
#using script_6b71c9befed901f2;
#using script_71603a58e2da0698;
#using script_75c3996cce8959f7;
#using script_76abb7986de59601;
#using script_77163d5a569e2071;
#using script_771f5bff431d8d57;
#using scripts\core_common\array_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_9fc66ac;

function init() {
  clientfield::register("world", "doa_announce", 1, 11, "int", &function_b9918ac7, 0, 0);
  level thread function_d32819b7();
  level.doa.var_f5ac1256 = array({
    #id: 0, #audio: undefined, #cooldown: 0, #var_2c036085: 0, #roll: 100
  }, {
    #id: 1, #audio: # "hash_5e6e1452ec83a970", #cooldown: 0, #var_2c036085: 0, #roll: 100
  }, {
    #id: 2, #audio: # "hash_2eb0dc04b23c744d", #cooldown: 0, #var_2c036085: 0, #roll: 100
  }, {
    #id: 3, #audio: # "hash_7e54ced7572851c2", #cooldown: 0, #var_2c036085: 0, #roll: 100
  }, {
    #id: 4, #audio: # "hash_651f3b290bc84446", #cooldown: 0, #var_2c036085: 0, #roll: 100
  }, {
    #id: 5, #audio: # "hash_1fc99b8da3b17545", #cooldown: 0, #var_2c036085: 0, #roll: 100
  }, {
    #id: 6, #audio: # "hash_28b747b591669a5d", #cooldown: 0, #var_2c036085: 0, #roll: 100
  }, {
    #id: 7, #audio: # "hash_7c7a787a24f593b9", #cooldown: 0, #var_2c036085: 0, #roll: 100
  }, {
    #id: 8, #audio: # "hash_2e05ff4b6268eb8f", #cooldown: 0, #var_2c036085: 0, #roll: 100
  }, {
    #id: 9, #audio: # "hash_6e6f540341ffa63e", #cooldown: 0, #var_2c036085: 0, #roll: 100
  }, {
    #id: 10, #audio: # "hash_43afff6856f17323", #cooldown: 0, #var_2c036085: 0, #roll: 100
  }, {
    #id: 11, #audio: # "hash_1b1aedb93f9470ac", #cooldown: 0, #var_2c036085: 0, #roll: 100
  }, {
    #id: 12, #audio: # "hash_2ee1c63f7404a4d", #cooldown: 0, #var_2c036085: 0, #roll: 100
  }, {
    #id: 13, #audio: # "hash_2c81ef7c33bb5cf8", #cooldown: 0, #var_2c036085: 0, #roll: 100
  }, {
    #id: 14, #audio: # "hash_3dc9e95c1bb57e9b", #cooldown: 0, #var_2c036085: 0, #roll: 100
  }, {
    #id: 15, #audio: # "hash_7d54a35ebdfd55bd", #cooldown: 0, #var_2c036085: 0, #roll: 100
  }, {
    #id: 16, #audio: # "hash_3a54bd27d22124f0", #cooldown: 0, #var_2c036085: 0, #roll: 100
  }, {
    #id: 17, #audio: # "hash_5b52ce536f868c5e", #cooldown: 0, #var_2c036085: 0, #roll: 100
  }, {
    #id: 18, #audio: # "hash_1f86f42144bb9e8f", #cooldown: 0, #var_2c036085: 0, #roll: 100
  }, {
    #id: 19, #audio: # "hash_1241db745382fb45", #cooldown: 0, #var_2c036085: 0, #roll: 100
  }, {
    #id: 20, #audio: # "hash_160facb2f210d511", #cooldown: 0, #var_2c036085: 0, #roll: 100
  }, {
    #id: 21, #audio: # "hash_6ced3e7dc041cd89", #cooldown: 0, #var_2c036085: 0, #roll: 100
  }, {
    #id: 22, #audio: # "hash_77520fd1edf0a38a", #cooldown: 0, #var_2c036085: 0, #roll: 100
  }, {
    #id: 23, #audio: # "hash_1bf394b62878774b", #cooldown: 0, #var_2c036085: 0, #roll: 100
  }, {
    #id: 24, #audio: # "hash_5067551b940e90b5", #cooldown: 120000, #var_2c036085: 0, #roll: 5
  }, {
    #id: 25, #audio: # "hash_3d81295463455fe", #cooldown: 120000, #var_2c036085: 0, #roll: 5
  }, {
    #id: 26, #audio: # "hash_19ff2f6b0c853b6", #cooldown: 120000, #var_2c036085: 0, #roll: 5
  }, {
    #id: 27, #audio: # "hash_622c69a771466aae", #cooldown: 120000, #var_2c036085: 0, #roll: 5
  }, {
    #id: 28, #audio: # "hash_46f6b3325650d2db", #cooldown: 120000, #var_2c036085: 0, #roll: 5
  }, {
    #id: 29, #audio: # "hash_38c6db33d9b9bb6b", #cooldown: 120000, #var_2c036085: 0, #roll: 5
  }, {
    #id: 30, #audio: # "hash_6c635274e16696bd", #cooldown: 120000, #var_2c036085: 0, #roll: 5
  }, {
    #id: 31, #audio: # "hash_4d2fd562754a4f01", #cooldown: 120000, #var_2c036085: 0, #roll: 5
  }, {
    #id: 32, #audio: # "hash_670e9e1a3893d870", #cooldown: 120000, #var_2c036085: 0, #roll: 5
  }, {
    #id: 33, #audio: # "hash_2b25bf7cb60724a1", #cooldown: 120000, #var_2c036085: 0, #roll: 5
  }, {
    #id: 34, #audio: # "hash_91466a80e98968f", #cooldown: 120000, #var_2c036085: 0, #roll: 5
  }, {
    #id: 35, #audio: # "hash_72a785fee3fe1546", #cooldown: 120000, #var_2c036085: 0, #roll: 5
  }, {
    #id: 36, #audio: # "hash_5dcdc3449e3d853c", #cooldown: 120000, #var_2c036085: 0, #roll: 5
  }, {
    #id: 37, #audio: # "hash_70176ca9d7eadea2", #cooldown: 120000, #var_2c036085: 0, #roll: 5
  }, {
    #id: 38, #audio: # "hash_17c7fe1f6f3a34f0", #cooldown: 120000, #var_2c036085: 0, #roll: 5
  }, {
    #id: 39, #audio: # "hash_4dc16a7fdcca84cc", #cooldown: 120000, #var_2c036085: 0, #roll: 5
  }, {
    #id: 40, #audio: # "hash_5db798a7f60563d7", #cooldown: 120000, #var_2c036085: 0, #roll: 5
  }, {
    #id: 41, #audio: # "hash_459e9ed04815fe9c", #cooldown: 120000, #var_2c036085: 0, #roll: 5
  }, {
    #id: 42, #audio: # "hash_9274c6731fb7feb", #cooldown: 120000, #var_2c036085: 0, #roll: 5
  }, {
    #id: 43, #audio: # "hash_5bf27744a0b10d1e", #cooldown: 120000, #var_2c036085: 0, #roll: 5
  }, {
    #id: 44, #audio: # "hash_1958839e85f66720", #cooldown: 120000, #var_2c036085: 0, #roll: 5
  }, {
    #id: 45, #audio: # "hash_1997e34d69a45b73", #cooldown: 120000, #var_2c036085: 0, #roll: 5
  }, {
    #id: 46, #audio: # "hash_113008b2061dab6b", #cooldown: 120000, #var_2c036085: 0, #roll: 5
  }, {
    #id: 47, #audio: # "hash_2427c3aea88f9fd1", #cooldown: 120000, #var_2c036085: 0, #roll: 5
  }, {
    #id: 48, #audio: # "hash_6175054f39a3e1dd", #cooldown: 120000, #var_2c036085: 0, #roll: 5
  }, {
    #id: 49, #audio: # "hash_37d228f1a7b7933d", #cooldown: 120000, #var_2c036085: 0, #roll: 5
  }, {
    #id: 50, #audio: # "hash_3058c912ba06ce02", #cooldown: 120000, #var_2c036085: 0, #roll: 5
  }, {
    #id: 51, #audio: # "hash_6f7330fa470cb5e8", #cooldown: 120000, #var_2c036085: 0, #roll: 5
  }, {
    #id: 52, #audio: # "hash_5f4f49fa863187fd", #cooldown: 120000, #var_2c036085: 0, #roll: 5
  }, {
    #id: 53, #audio: # "hash_5be1c74545ae242a", #cooldown: 120000, #var_2c036085: 0, #roll: 5
  }, {
    #id: 54, #audio: # "hash_18d7c7d333aa151e", #cooldown: 120000, #var_2c036085: 0, #roll: 5
  }, {
    #id: 55, #audio: # "hash_7742a96850eaf496", #cooldown: 120000, #var_2c036085: 0, #roll: 5
  }, {
    #id: 56, #audio: # "hash_7522904a63119317", #cooldown: 120000, #var_2c036085: 0, #roll: 5
  }, {
    #id: 57, #audio: # "hash_43c91102fff01c96", #cooldown: 120000, #var_2c036085: 0, #roll: 5
  }, {
    #id: 58, #audio: # "hash_4a892234ff034660", #cooldown: 120000, #var_2c036085: 0, #roll: 5
  }, {
    #id: 59, #audio: # "hash_7286e11306aa412f", #cooldown: 0, #var_2c036085: 0, #roll: 100
  }, {
    #id: 60, #audio: # "hash_31e0e727b7ea0fcb", #cooldown: 0, #var_2c036085: 0, #roll: 100
  }, {
    #id: 61, #audio: # "hash_680b8403f9f66646", #cooldown: 0, #var_2c036085: 0, #roll: 100
  }, {
    #id: 62, #audio: # "hash_15428efb31882884", #cooldown: 0, #var_2c036085: 0, #roll: 100
  }, {
    #id: 63, #audio: # "hash_7fb87667c443733d", #cooldown: 0, #var_2c036085: 0, #roll: 100
  }, {
    #id: 64, #audio: # "hash_2ff2890b37cb4b5d", #cooldown: 0, #var_2c036085: 0, #roll: 100
  }, {
    #id: 65, #audio: # "hash_175054f8f6fc7dde", #cooldown: 0, #var_2c036085: 0, #roll: 100
  }, {
    #id: 66, #audio: # "hash_4eb136f9afa3e768", #cooldown: 0, #var_2c036085: 0, #roll: 100
  }, {
    #id: 67, #audio: # "hash_7708cf29dde5f73a", #cooldown: 0, #var_2c036085: 0, #roll: 100
  }, {
    #id: 68, #audio: # "hash_1aaf39243ecd3c87", #cooldown: 0, #var_2c036085: 0, #roll: 100
  }, {
    #id: 69, #audio: # "hash_5bf427da9381b39f", #cooldown: 0, #var_2c036085: 0, #roll: 100
  }, {
    #id: 70, #audio: # "hash_6838acfd05bcf2ab", #cooldown: 0, #var_2c036085: 0, #roll: 100
  }, {
    #id: 71, #audio: # "hash_340c9ca061a5fde2", #cooldown: 0, #var_2c036085: 0, #roll: 100
  }, {
    #id: 72, #audio: # "hash_6020f714caec40ab", #cooldown: 0, #var_2c036085: 0, #roll: 100
  });
  function_32d5e898();
}

function function_5521aa1c(localclientnum) {
  if(localclientnum != 0) {
    return;
  }

  self notify("11fa0ea36c3aeb7c");
  self endon("11fa0ea36c3aeb7c");

  if(isDefined(level.doa.var_57e2aa98)) {
    stopsound(level.doa.var_57e2aa98);
    level.doa.var_57e2aa98 = undefined;
  }

  level.doa.voqueue = [];

  while(true) {
    if(!isDefined(level.doa.var_57e2aa98)) {
      if(level.doa.voqueue.size) {
        queueitem = level.doa.voqueue[0];
        arrayremoveindex(level.doa.voqueue, 0);

        if(queueitem.localclientnum != localclientnum) {
          continue;
        }

        if(isDefined(queueitem.entity)) {
          level.doa.var_57e2aa98 = queueitem.entity playSound(queueitem.localclientnum, queueitem.line);
        } else {
          level.doa.var_57e2aa98 = playSound(queueitem.localclientnum, queueitem.line);
        }
      }

      wait 0.1;
      continue;
    }

    while(soundplaying(level.doa.var_57e2aa98)) {
      wait 0.2;
    }

    level.doa.var_57e2aa98 = undefined;
    wait 1.2;
  }
}

function function_9a237f2f(localclientnum, voline, entity) {
  if(isDefined(voline)) {
    queueitem = {
      #line: voline, #localclientnum: localclientnum, #time: gettime(), #entity: entity
    };

    if(!isDefined(level.doa.voqueue)) {
      level.doa.voqueue = [];
    } else if(!isarray(level.doa.voqueue)) {
      level.doa.voqueue = array(level.doa.voqueue);
    }

    level.doa.voqueue[level.doa.voqueue.size] = queueitem;
  }
}

function announce(localclientnum, var_fa5e0d11) {
  line = level.doa.var_f5ac1256[var_fa5e0d11];
  line.var_2c036085 = gettime() + line.cooldown;
  function_9a237f2f(localclientnum, line.audio);
}

function function_b9918ac7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 0) {
    return;
  }

  if(fieldname != 0) {
    return;
  }

  var_971e1071 = bwastimejump & 15;
  var_fa5e0d11 = bwastimejump >> 4;
  line = level.doa.var_f5ac1256[var_fa5e0d11];

  if(line.var_2c036085 > gettime()) {
    return;
  }

  roll = randomint(100);

  if(roll >= line.roll) {
    return;
  }

  if(var_971e1071 == 15) {
    announce(fieldname, var_fa5e0d11);
    return;
  }

  players = getlocalplayers();

  foreach(player in players) {
    if(!isDefined(player.entnum)) {
      continue;
    }

    var_a10d0ff1 = 1 << player.entnum;

    if(var_a10d0ff1 &var_971e1071 == 0) {
      continue;
    }

    announce(fieldname, var_fa5e0d11);
  }
}

function function_32d5e898(localclientnum = 0) {
  level thread function_5521aa1c(localclientnum);
  util::delay(2, "game_over", &function_5beeba99);

  for(i = 0; i < level.doa.var_f5ac1256.size; i++) {
    assert(i == level.doa.var_f5ac1256[i].id, "<dev string:x38>");
    level.doa.var_f5ac1256[i].var_2c036085 = 0;
  }
}

function function_a77649db(onoff, str_name) {
  if(is_true(onoff)) {
    level.var_1d1399b = level.var_5d4c7696;
    function_30f7911(2, str_name);
    return;
  }

  function_f2198fe(level.var_1d1399b);
}

function function_5beeba99() {
  if(isDefined(level.doa.var_72b899ad)) {
    name = level.doa.var_72b899ad.script_noteworthy;
    var_8576a4b1 = level.doa.roundnumber;
    function_30f7911(0, name);
  }
}

function function_2fc07d61() {}

function function_65fcd877() {
  switch (level.doa.world_state) {
    case 0:
      peak = 1;
      break;
    case 4:
      function_30f7911(4);
      function_319e479e();
      break;
    case 5:
      function_30f7911(5);
      break;
    case 1:
      function_30f7911(1);
      break;
  }
}

function function_30f7911(type, str_name = undefined) {
  if(!isDefined(level.var_5d4c7696)) {
    level.var_5d4c7696 = "";
  }

  if(!isDefined(level.var_1d1399b)) {
    level.var_1d1399b = "";
  }

  var_fc7248c7 = undefined;

  switch (type) {
    case 0:
      if(isDefined(str_name)) {
        var_fc7248c7 = "zm_doa_arena_" + str_name;
      } else {
        var_fc7248c7 = "zm_doa_arena_default";
      }

      break;
    case 2:
      if(isDefined(str_name)) {
        var_fc7248c7 = "zm_doa_bonusroom_" + str_name;
      } else {
        var_fc7248c7 = "zm_doa_bonusroom_default";
      }

      break;
    case 4:
      var_fc7248c7 = "zm_doa_overworld";
      break;
    case 5:
      var_fc7248c7 = "zm_doa_dungeon";
      break;
    case 1:
      var_fc7248c7 = "zm_doa_gameover";
      break;
  }

  function_f2198fe(var_fc7248c7);
}

function function_f2198fe(var_fc7248c7) {
  if(level.var_5d4c7696 !== var_fc7248c7) {
    level.var_5d4c7696 = var_fc7248c7;
    forceambientroom(var_fc7248c7);
  }
}

function function_d32819b7() {
  for(i = 1; i < 20; i++) {
    var_ad059c41 = # "hash_3e8aee7efd30e549" + i;
    function_2cca7b47(0, var_ad059c41);
  }
}

function function_319e479e() {
  audio::playloopat(#"hash_144636b68669b310", (1073, 7378, 1229));
  audio::playloopat(#"hash_557b8a7ebb353029", (319, 7216, 1229));
}