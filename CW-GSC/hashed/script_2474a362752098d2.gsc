/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_2474a362752098d2.gsc
***********************************************/

#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ce46999727f2f2b;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_2e9202713de2b353;
#using script_350cffecd05ef6cf;
#using script_40f967ad5d18ea74;
#using script_41fbdfb1149a433e;
#using script_47851dbeea22fe66;
#using script_48e04a393ec6d855;
#using script_4d748e58ce25b60c;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_683a55734f15d50e;
#using script_68cdf0ca5df5e;
#using script_73ad7687b437e468;
#using script_74a56359b7d02ab6;
#using script_77357b2d180aa2b8;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_491fa2b2;

function init() {
  namespace_41f5b853::init();
  namespace_f63bdb08::init();
  level.doa.var_f4a69294 = [];
  level.doa.var_b8ef1466 = [];
  level.doa.var_c793b1bb = [];
  level.doa.var_f4a69294[# "green"] = function_f143eef7();
  level.doa.var_f4a69294[# "blue"] = function_f143eef7();
  level.doa.var_f4a69294[# "red"] = function_f143eef7();
  level.doa.var_f4a69294[# "yellow"] = function_f143eef7();
  main();
}

function main() {
  function_df55eb9d();
  level.doa.var_b8ef1466 = [];
  level.doa.var_c793b1bb = [];
  level thread function_bcedb01d();
}

function function_df55eb9d(context = 0, loottype, var_d1b6de15) {
  var_b8ef1466 = level.doa.var_b8ef1466;
  arrayremovevalue(var_b8ef1466, undefined);

  for(i = 0; i < var_b8ef1466.size; i++) {
    item = var_b8ef1466[i];

    if(!isDefined(item)) {
      continue;
    }

    if(context != 0 && item.context != context) {
      continue;
    }

    if(isDefined(var_d1b6de15)) {
      if(item == var_d1b6de15 || item.script_model === var_d1b6de15) {
        continue;
      }
    }

    if(isDefined(loottype)) {
      if(!isDefined(item.loottype)) {
        continue;
      }

      if(isDefined(item.loottype) && item.loottype != loottype) {
        continue;
      }
    }

    item.var_7362caca = 1;

    if(isDefined(item.script_model)) {
      item.script_model delete();
    }

    if(!isstruct(item)) {
      item namespace_ec06fe4a::function_52afe5df();
    }
  }

  level.doa.var_b8ef1466 = [];

  foreach(item in var_b8ef1466) {
    if(!is_true(item.var_7362caca)) {
      level.doa.var_b8ef1466[level.doa.var_b8ef1466.size] = item;
    }
  }

  foreach(item in level.doa.var_c793b1bb) {
    if(!isDefined(item)) {
      continue;
    }

    if(isDefined(item.script_model)) {
      item.script_model delete();
    }

    if(!isstruct(item)) {
      item delete();
    }
  }

  level.doa.var_c793b1bb = [];

  foreach(trigger in level.doa.var_f4a69294) {}
}

function function_bcedb01d() {
  self notify("1242aca585373200");
  self endon("1242aca585373200");
  level endon(#"game_over");

  while(true) {
    wait 0.5;

    foreach(item in level.doa.var_b8ef1466) {
      if(!isstruct(item)) {
        continue;
      }

      if(item.context === 2) {
        continue;
      }

      if(!isDefined(item.script_model)) {
        var_10316202 = 0;

        foreach(player in getplayers()) {
          distsq = distancesquared(player.origin, item.origin);

          if(distsq < sqr(2000)) {
            var_10316202 = 1;
            break;
          }
        }

        if(var_10316202) {
          namespace_1e25ad94::debugmsg("Paging IN Loot (" + item.modelname + ") at " + item.origin);
          var_a1f88ae1 = namespace_ec06fe4a::spawnmodel(item.origin, item.modelname);

          if(!isDefined(var_a1f88ae1)) {
            namespace_1e25ad94::debugmsg("FAILED TO SPAWN MODEL (" + item.modelname + ") at " + item.origin);
            continue;
          }

          var_a1f88ae1 namespace_41f5b853::function_60eeb02c(item);
        }

        continue;
      }

      var_191a010a = 1;

      foreach(player in getplayers()) {
        if(abs(player.origin[2] - item.origin[2]) > 1000) {
          continue;
        }

        distsq = distancesquared(player.origin, item.origin);

        if(distsq < sqr(2800)) {
          var_191a010a = 0;
          break;
        }
      }

      if(var_191a010a) {
        namespace_1e25ad94::debugmsg("Paging OUT Loot (" + item.modelname + ") at " + item.origin);
        item.script_model delete();
      }
    }
  }
}

function function_ebbc302() {
  self notify("2c68158dda09e9d5");
  self endon("2c68158dda09e9d5");
  self endon(#"disconnect");
  assert(isDefined(self.doa), "<dev string:x38>");
  var_2158df5f = level.doa.var_f4a69294[self.doa.color];
  var_2158df5f setteamfortrigger(self.team);
  self clientclaimtrigger(var_2158df5f);
  var_2158df5f.player = self;
  self.doa.var_a594a0d0 = var_2158df5f;

  while(true) {
    wait 0.5;
    closest = undefined;
    items = arraysortclosest(level.doa.var_b8ef1466, self.origin, 1);

    if(items.size) {
      closest = items[0];

      if(isstruct(closest)) {
        closest = closest.script_model;
      }
    }

    if(isDefined(closest)) {
      if(closest !== self.doa.var_96175d8a) {
        deltaz = abs(self.origin[2] - closest.origin[2]);

        if(deltaz > 128) {
          closest = undefined;
        }

        if(isDefined(closest)) {
          distsq = distancesquared(self.origin, closest.origin);

          if(distsq > sqr(1024)) {
            closest = undefined;
          }
        }
      }
    }

    if(isDefined(closest)) {
      if(closest !== self.doa.var_96175d8a || function_dd626f96(closest)) {
        var_2158df5f function_8328d4bc(closest);
      }

      self.doa.var_96175d8a = closest;
      continue;
    }

    function_3bfccb4();
  }
}

function function_3bfccb4() {
  var_2158df5f = self.doa.var_a594a0d0;
  var_2158df5f.origin = self.origin + (0, 0, -30000);
  var_2158df5f.var_806ce8f = undefined;
  var_2158df5f sethintstring(#"");
  var_2158df5f triggerenable(0);
  self.doa.var_96175d8a = undefined;
}

function function_8f5419f1() {
  var_2158df5f = level.doa.var_f4a69294[self.doa.color];
  return self istouching(var_2158df5f) && var_2158df5f.var_806ce8f == self.doa.var_96175d8a;
}

function function_dd626f96(item) {
  if(item.var_d6118311 === 2) {
    return 1;
  }

  if(item.var_d6118311 === 8) {
    return 1;
  }

  if(item.var_d6118311 === 10) {
    return 1;
  }

  return is_true(item.locked);
}

function function_8328d4bc(item) {
  if(!isDefined(item)) {
    return;
  }

  self.origin = item.origin + (0, 0, 24);

  if(isDefined(item.trigger_offset)) {
    self.origin += item.trigger_offset;
  }

  if(!isDefined(item.var_cbff4088)) {
    item.var_cbff4088 = 0;
  }

  if(item.var_cbff4088 == -1) {
    if(getplayers().size <= 2) {
      item.var_cbff4088 = 1;
    } else {
      item.var_cbff4088 = 2;
    }
  }

  if(!isDefined(item.var_950bcf12)) {
    item.var_950bcf12 = item.var_cbff4088;
  }

  self.lastitem = self.var_806ce8f;
  self.var_806ce8f = item;
  self sethintstring(#"hash_bf1faaf9f4ab783");

  switch (item.var_d6118311) {
    case 9:
      self sethintstring(#"hash_116cdb7f4910b48f");
      break;
    case 4:
      if(is_true(level.doa.hardcoremode)) {
        self sethintstring(#"hash_7ee185f0146bd791");
        break;
      }

      fate = item.data;

      if(self.player namespace_1c2a96f9::function_afe89b8c(fate.var_c8386627)) {
        self sethintstring(#"hash_35d21b3088f19ee7");
      } else {
        self sethintstring(#"hash_26f6da6f6ca5dfa4");
      }

      break;
    case 1:
      self sethintstring(#"hash_226d9049ece37c17");
      break;
    case 8:
      if(self.doorstate === 1) {
        self sethintstring(#"hash_7ee185f0146bd791");
      } else {
        self sethintstring(#"hash_1830b9b637fcebaa");
      }

      break;
    case 2:
      if(isDefined(item.var_fc5f2aa0) && isDefined(item.var_fc5f2aa0.var_115ea089) && isDefined(item.var_fc5f2aa0.hintstring)) {
        ent = getent(item.var_fc5f2aa0.var_115ea089, "script_noteworthy");

        if(!isDefined(ent)) {
          item.var_fc5f2aa0.hintstring = item.var_fc5f2aa0.var_e8dff5e5;
          item.var_d6118311 = 1;
        }
      }

      if(isDefined(item.var_fc5f2aa0) && isDefined(item.var_fc5f2aa0.hintstring)) {
        self sethintstring(item.var_fc5f2aa0.hintstring);
      } else if(self.player.doa.score.keys == 0) {
        self sethintstring(#"hash_5c2a90001a3be8b5");
      } else {
        self sethintstring(#"hash_156739736ad89c28");
      }

      break;
    case 5:
    case 7:
      if(is_true(item.locked)) {
        if(self.player.doa.score.keys == 0) {
          self sethintstring(#"hash_2f8c4610353b9754");
        } else {
          self sethintstring(#"hash_692637e6361aa6fd");
        }
      } else {
        self sethintstring(#"hash_7c3502418402b5ea");
      }

      break;
    case 6:
      if(is_true(level.doa.hardcoremode)) {
        self sethintstring(#"hash_7ee185f0146bd791");
        break;
      }

      if(is_true(item.locked)) {
        if(self.player.doa.score.keys == 0) {
          self sethintstring(#"hash_39ebdbb0226b329f");

          if(namespace_ec06fe4a::function_a8975c67()) {
            if(isDefined(self.lastitem) && self.lastitem != self.var_806ce8f) {
              self.player playsoundtoplayer(#"hash_69cbee6dafb05bae", self.player);
            }
          }
        } else if(item.var_cbff4088 > 1 && item.var_cbff4088 != item.var_950bcf12) {
          self sethintstring(#"hash_7b23848ec07aad08");
        } else {
          self sethintstring(#"hash_54b6fea6bd91db7c");
        }
      } else {
        self sethintstring(#"hash_20c1284622784d1d");
      }

      break;
    case 10:
      if(is_true(item.locked)) {
        if(self.player.doa.score.keys == 0) {
          self sethintstring(#"hash_58986e95c81fb59f");
        } else {
          self sethintstring(#"hash_14f6fd1b195d968f");
        }
      } else {
        self sethintstring(#"hash_2eb890855923e721");
      }

      break;
    case 3:
      if(is_true(item.locked)) {
        if(self.player.doa.score.keys == 0) {
          self sethintstring(#"hash_ce3afacfc4ce084");
        } else {
          self sethintstring(#"hash_d0088d8ea0c0b0d");
        }
      } else {
        switch (item.loottype) {
          case 1:
          case 2:
          case 3:
          case 4:
            self sethintstring(#"hash_7dbf76733550293a");
            break;
          case 6:
            self sethintstring(#"hash_4bfbefc2b26dbccf");
            self function_dae4ab9b(0.15);
            break;
          case 12:
            self sethintstring(#"hash_2ae2e0909bc1c560");
            self function_dae4ab9b(0.15);
            break;
          default:
            self sethintstring(#"hash_49306fb46908df39");
            break;
        }
      }

      break;
  }

  self triggerenable(1);
}

function function_f143eef7() {
  usetrigger = namespace_ec06fe4a::spawntrigger("trigger_radius_use", (0, 0, 0), 0, 96, 96);

  if(isDefined(usetrigger)) {
    usetrigger setcursorhint("HINT_NOICON");
    usetrigger callback::on_trigger(&onusecallback);
  }

  return usetrigger;
}

function onusecallback(trigger_struct) {
  profilestart();
  player = trigger_struct.activator;
  targ = self.var_806ce8f;

  if(!isDefined(targ)) {
    profilestop();
    return;
  }

  if(is_true(targ.activated)) {
    profilestop();
    return;
  }

  if(player function_8f5419f1() == 0) {
    profilestop();
    return;
  }

  player function_3bfccb4();
  player.doa.var_af53a5b7 = 1;

  if(isDefined(targ)) {
    switch (targ.var_d6118311) {
      case 2:
        if(isDefined(targ.var_fc5f2aa0)) {
          if(isDefined(targ.var_fc5f2aa0.var_115ea089)) {
            ent = getent(targ.var_fc5f2aa0.var_115ea089, "script_noteworthy");

            if(isDefined(ent)) {
              profilestop();
              return;
            }

            targ.var_fc5f2aa0.completed = 1;
            targ.var_d6118311 = 1;
          }
        } else {
          player playrumbleonentity("door_kick");

          if(player.doa.score.keys == 0) {
            targ namespace_e32bb68::function_3a59ec34("door_locked");
            profilestop();
            return;
          } else {
            player namespace_eccff4fb::function_849a9028();
            player namespace_e32bb68::function_3a59ec34("evt_doa_pickup_key_unlock");
            targ namespace_e32bb68::function_3a59ec34("door_unlocked");
            targ.var_d6118311 = 1;
          }
        }

        namespace_7f5aeb59::function_f8645db3(getdvarint(#"hash_e363c15517e89db", 250));
      case 1:
        level thread namespace_f63bdb08::function_49957ef3(targ, undefined, player);
        break;
      case 8:
        break;
      case 4:
        if(is_true(level.doa.hardcoremode)) {
          profilestop();
          return;
        }

        fate = targ.data;

        if(self.player namespace_1c2a96f9::function_afe89b8c(fate.var_c8386627)) {
          targ namespace_e32bb68::function_3a59ec34("fate_denied");
          profilestop();
          return;
        }

        if(self.player namespace_1c2a96f9::function_e19c55bd() >= 2) {
          var_6b186658 = 1 + (self.player.entnum << 4);
          level clientfield::set("banner_eventplayer", var_6b186658);
          self.player thread function_fe008f40();
          profilestop();
          return;
        }

        targ.activated = 1;
        level thread namespace_1c2a96f9::function_42b0778(targ, player, undefined);
        break;
      case 9:
        if(!isDefined(level.doa.var_182fb75a) && !isDefined(level.doa.var_6f3d327)) {
          targ.activated = 1;
          targ namespace_e32bb68::function_3a59ec34("arcade_coin_insert");
          level thread namespace_41f5b853::function_4d27013d(targ);
        }

        break;
      case 10:
        if(is_true(targ.locked)) {
          assert(targ.var_95b43d0 > 0);
          player playrumbleonentity("door_kick");

          if(player.doa.score.keys == 0) {
            targ namespace_e32bb68::function_3a59ec34("item_locked");
            profilestop();
            return;
          }

          targ.var_95b43d0--;

          if(targ.var_95b43d0 == 0) {
            targ.locked = 0;
          }

          assert(isDefined(targ.var_8cc3e0f9));
          level thread[[targ.var_8cc3e0f9]](player);
          player namespace_eccff4fb::function_849a9028();
          player namespace_e32bb68::function_3a59ec34("evt_doa_pickup_key_unlock");
          var_370ac26d = getdvarint(#"hash_e363c15517e89db", 250);
          namespace_7f5aeb59::function_f8645db3(var_370ac26d);
        }

        profilestop();
        return;
      case 3:
      case 5:
      case 6:
      case 7:
        if(is_true(level.doa.hardcoremode) && targ.var_d6118311 == 6) {
          break;
        }

        if(is_true(targ.locked)) {
          player playrumbleonentity("door_kick");

          if(player.doa.score.keys == 0) {
            targ namespace_e32bb68::function_3a59ec34("item_locked");
            profilestop();
            return;
          }

          player namespace_eccff4fb::function_849a9028();
          player namespace_e32bb68::function_3a59ec34("evt_doa_pickup_key_unlock");

          if(!isDefined(targ.var_cbff4088)) {
            targ.var_cbff4088 = 1;
          }

          assert(targ.var_cbff4088 > 0);
          targ.var_cbff4088--;
          var_370ac26d = getdvarint(#"hash_e363c15517e89db", 250);

          if(targ.var_d6118311 == 6) {
            if(!isDefined(level.doa.var_4ebe1b74)) {
              level.doa.var_4ebe1b74 = 0;
            }

            level.doa.var_4ebe1b74++;

            if(targ.var_cbff4088 > 0) {
              if(namespace_ec06fe4a::function_a8975c67()) {
                player playsoundtoplayer(#"hash_54eea1b8087b2e05", player);
              }
            } else if(targ.var_cbff4088 == 0) {
              if(namespace_ec06fe4a::function_a8975c67()) {
                player playsoundtoplayer(#"hash_477187e7253897bc", player);
              }

              var_370ac26d = getdvarint(#"hash_652d85e0bde549ad", 750);
            }
          }

          if(targ.var_cbff4088 > 0) {
            targ namespace_e32bb68::function_3a59ec34("evt_doa_teleporter_wilds_burst");
            targ namespace_83eb6304::function_3ecfde67("wild_portal_radial_burst");
            targ = undefined;
            break;
          }

          targ namespace_e32bb68::function_3a59ec34("item_unlocked");
          targ.locked = 0;
          namespace_7f5aeb59::function_f8645db3(var_370ac26d);
        }

        targ.activated = 1;
        level thread namespace_41f5b853::function_4d27013d(targ);
        break;
    }
  }

  if(isDefined(targ)) {
    if(isDefined(targ.owner)) {
      targ.owner.activated = 1;
    }

    if(isDefined(targ.spawninfo)) {
      targ.spawninfo.activated = 1;
      arrayremovevalue(level.doa.var_b8ef1466, targ.spawninfo);
      level.doa.var_c793b1bb[level.doa.var_c793b1bb.size] = targ.spawninfo;
    } else {
      targ.activated = 1;
      arrayremovevalue(level.doa.var_b8ef1466, targ);
      level.doa.var_c793b1bb[level.doa.var_c793b1bb.size] = targ;
    }
  }

  profilestop();
}

function function_fe008f40(time = 5) {
  self endon(#"disconnect");
  wait time;
  var_6b186658 = 0 + (self.entnum << 4);
  level clientfield::set("banner_eventplayer", var_6b186658);
}