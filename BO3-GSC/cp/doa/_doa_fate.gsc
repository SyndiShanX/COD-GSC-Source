/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\doa\_doa_fate.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\cp_doa_bo3_enemy;
#using scripts\cp\doa\_doa_arena;
#using scripts\cp\doa\_doa_chicken_pickup;
#using scripts\cp\doa\_doa_dev;
#using scripts\cp\doa\_doa_enemy;
#using scripts\cp\doa\_doa_enemy_boss;
#using scripts\cp\doa\_doa_fx;
#using scripts\cp\doa\_doa_hazard;
#using scripts\cp\doa\_doa_pickups;
#using scripts\cp\doa\_doa_player_utility;
#using scripts\cp\doa\_doa_round;
#using scripts\cp\doa\_doa_score;
#using scripts\cp\doa\_doa_sfx;
#using scripts\cp\doa\_doa_shield_pickup;
#using scripts\cp\doa\_doa_utility;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\util_shared;
#namespace doa_fate;

function init() {
  if(!isDefined(level.doa.var_b1698a42)) {
    level.doa.var_b1698a42 = spawnStruct();
    level.doa.var_b1698a42.types = [];
    level.doa.var_b1698a42.var_9c35e18e = [];
    level.doa.var_b1698a42.arena = "temple";
    level.doa.var_b1698a42.var_64e3261c = "temple";
    level.doa.var_b1698a42.var_f485e213 = "p7_sin_rock_park_07_blue";
    level.doa.var_b1698a42.var_6e3ecc6b = "zombietron_stoneboss";
    level.doa.var_b1698a42.types[level.doa.var_b1698a42.types.size] = 1;
    level.doa.var_b1698a42.types[level.doa.var_b1698a42.types.size] = 2;
    level.doa.var_b1698a42.types[level.doa.var_b1698a42.types.size] = 3;
    level.doa.var_b1698a42.types[level.doa.var_b1698a42.types.size] = 4;
    level.doa.var_b1698a42.var_9c35e18e[level.doa.var_b1698a42.var_9c35e18e.size] = 10;
    level.doa.var_b1698a42.var_9c35e18e[level.doa.var_b1698a42.var_9c35e18e.size] = 11;
    level.doa.var_b1698a42.var_9c35e18e[level.doa.var_b1698a42.var_9c35e18e.size] = 12;
    level.doa.var_b1698a42.var_9c35e18e[level.doa.var_b1698a42.var_9c35e18e.size] = 13;
    level.doa.var_b1698a42.locations = doa_utility::function_4e9a23a9(struct::get_array("doa_fate_loc", "targetname"));
    level.doa.var_b1698a42.var_70a33a0b = doa_utility::function_4e9a23a9(struct::get_array("doa_fate2_loc", "targetname"));
    level.doa.var_b1698a42.types = doa_utility::function_4e9a23a9(level.doa.var_b1698a42.types);
    level.doa.var_b1698a42.var_9c35e18e = doa_utility::function_4e9a23a9(level.doa.var_b1698a42.var_9c35e18e);
    level.doa.var_b1698a42.msgs = [];
    level.doa.var_b1698a42.var_33d94cd7 = 0;
    level.doa.var_b1698a42.msgs[level.doa.var_b1698a42.msgs.size] = newhudelem();
    level.doa.var_b1698a42.msgs[level.doa.var_b1698a42.msgs.size] = newhudelem();
    level.doa.var_b1698a42.msgs[level.doa.var_b1698a42.msgs.size] = newhudelem();
    level.doa.var_b1698a42.msgs[level.doa.var_b1698a42.msgs.size] = newhudelem();
    level.doa.var_b1698a42.var_cadf4b04 = [];
    level.doa.var_b1698a42.var_1bcf76cc = 0;
    for(i = 0; i < level.doa.var_b1698a42.msgs.size; i++) {
      level.doa.var_b1698a42.msgs[i].alignx = "center";
      level.doa.var_b1698a42.msgs[i].aligny = "middle";
      level.doa.var_b1698a42.msgs[i].horzalign = "center";
      level.doa.var_b1698a42.msgs[i].vertalign = "middle";
      level.doa.var_b1698a42.msgs[i].y = level.doa.var_b1698a42.msgs[i].y - (80 - (i * 20));
      level.doa.var_b1698a42.msgs[i].foreground = 1;
      level.doa.var_b1698a42.msgs[i].fontscale = 2.5;
      level.doa.var_b1698a42.msgs[i].color = (1, 0.2, 0);
      level.doa.var_b1698a42.msgs[i].hidewheninmenu = 1;
    }
  }
}

function private function_6162a853(var_26fc4461 = 0) {
  level endon("hash_7b036079");
  time_left = (gettime() + (level.doa.rules.fate_wait * 1000)) + 10000;
  diff = time_left - gettime();
  var_4af4d74c = 0;
  while(diff > 0) {
    if(diff < 8000 && !var_4af4d74c) {
      var_4af4d74c = 1;
      if(!var_26fc4461) {
        level thread doa_utility::function_37fb5c23(&"DOA_FATE_ROOM_CHOOSE_HURRY");
      } else {
        level thread doa_utility::function_37fb5c23(&"DOA_RIGHTEOUS_ROOM_CHOOSE_HURRY");
      }
    }
    players = getplayers();
    allfated = 1;
    for(i = 0; i < players.size; i++) {
      if(!var_26fc4461) {
        if(players[i].doa.fate == 0) {
          allfated = 0;
          break;
        }
        continue;
      }
      if(!(isDefined(players[i].doa.var_2219ffc9) && players[i].doa.var_2219ffc9)) {
        allfated = 0;
        break;
      }
    }
    if(allfated) {
      break;
    }
    diff = time_left - gettime();
    wait(0.1);
  }
  level notify("hash_7b036079");
}

function function_fd0b8976(text, holdtime = 4, color = (1, 0, 0), reset = 0) {
  msg = level.doa.var_b1698a42.msgs[level.doa.var_b1698a42.var_33d94cd7];
  level.doa.var_b1698a42.var_33d94cd7++;
  if(level.doa.var_b1698a42.var_33d94cd7 >= level.doa.var_b1698a42.msgs.size) {
    level.doa.var_b1698a42.var_33d94cd7 = 0;
  }
  msg.alpha = 0;
  msg settext(text);
  msg.color = color;
  msg fadeovertime(1);
  msg.alpha = 1;
  wait(holdtime);
  msg fadeovertime(1);
  msg.alpha = 0;
  if(reset) {
    level.doa.var_b1698a42.var_33d94cd7 = 0;
  }
}

function function_77ed1bae() {
  level notify("hash_e2918623");
  level.doa.fates_have_been_chosen = 0;
  guardian = getent("temple_guardian", "targetname");
  var_526b2f85 = getent("temple_guardian_clip", "targetname");
  guardian.origin = guardian.origin + (vectorscale((0, 0, -1), 1000));
  var_526b2f85.origin = var_526b2f85.origin + (vectorscale((0, 0, -1), 1000));
  level thread doa_pickups::function_c1869ec8();
  level thread doa_utility::clearallcorpses();
  level thread namespace_d88e3a06::function_116bb43();
  level notify("hash_a50a72db");
  locs = struct::get_array("fate_player_spawn", "targetname");
  if(isDefined(locs) && locs.size == 4) {
    foreach(player in getplayers()) {
      spot = locs[player.entnum];
      player namespace_cdb9a8fe::function_fe0946ac(spot.origin);
      player setplayerangles((0, spot.angles[1], 0));
    }
  } else {
    namespace_cdb9a8fe::function_55762a85(namespace_3ca3c537::function_61d60e0b());
  }
  level thread doa_utility::set_lighting_state(3);
  for(i = 0; i < level.doa.var_b1698a42.types.size; i++) {
    type = level.doa.var_b1698a42.types[i];
    loc = level.doa.var_b1698a42.locations[i];
    rock = spawn("script_model", loc.origin + vectorscale((0, 0, 1), 2000));
    rock.targetname = "fate_rock";
    rock.var_103432a2 = rock.origin;
    rock.var_e35d13 = loc.origin;
    rock setModel(level.doa.var_b1698a42.var_f485e213);
    rock.angles = (0, type * 90, 0);
    rock setscale(0.9 + (type * 0.05));
    trigger = spawn("trigger_radius", rock.origin, 0, loc.radius, 128);
    trigger.targetname = "fateTrigger";
    trigger.type = type;
    trigger.rock = rock;
    trigger.id = i;
    trigger thread function_271ba816();
    level.doa.var_b1698a42.var_cadf4b04[level.doa.var_b1698a42.var_cadf4b04.size] = trigger;
    trigger enablelinkto();
    trigger linkto(rock);
  }
  doa_utility::function_390adefe(0);
  level thread doa_utility::function_c5f3ece8(&"DOA_FATE_ROOM", undefined, 6);
  level notify("hash_ba37290e", "fate");
  wait(1);
  level thread doa_utility::function_37fb5c23(&"DOA_FATE_ROOM_CHOOSE");
  level notify("hash_4213cffb");
  wait(4);
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    players[i] freezecontrols(0);
  }
  level thread function_6162a853();
  level thread namespace_3ca3c537::function_a50a72db();
  level notify("hash_3b6e1e2");
  level waittill("hash_7b036079");
  wait(1);
  level thread doa_utility::function_c5f3ece8(&"DOA_FATE_ROOM_DONE");
  wait(5);
  doa_utility::function_44eb090b();
  level.doa.fates_have_been_chosen = 1;
  level.doa.var_b1698a42.var_cadf4b04 = [];
  guardian.origin = guardian.origin + vectorscale((0, 0, 1), 1000);
  var_526b2f85.origin = var_526b2f85.origin + vectorscale((0, 0, 1), 1000);
  level thread doa_utility::set_lighting_state(level.doa.arena_round_number);
}

function private function_7882f69e(trigger) {
  self endon("death");
  level waittill("hash_7b036079");
  trigger notify("hash_fad6c90b");
}

function private function_524284e0() {
  self endon("death");
  level thread function_7882f69e(self);
  note = self util::waittill_any_return("trigger_wrong_match", "trigger_right_match", "trigger_fated", "death");
  self triggerenable(0);
  switch (note) {
    case "trigger_fated": {
      self.rock thread namespace_eaa992c::function_285a2999("fate_impact");
      self.rock thread namespace_eaa992c::function_285a2999("fate_trigger");
      self.rock thread namespace_eaa992c::function_285a2999("fate_impact");
      break;
    }
    case "trigger_right_match": {
      self.rock thread namespace_eaa992c::function_285a2999("fate_impact");
      self.rock thread namespace_eaa992c::function_285a2999("fate_trigger");
      break;
    }
    case "trigger_wrong_match": {
      self.rock thread namespace_eaa992c::function_285a2999("fate_impact");
      break;
    }
  }
  self.rock thread doa_utility::function_a98c85b2(self.rock.var_103432a2, 1.5);
}

function private function_271ba816(var_26fc4461 = 0) {
  level endon("hash_7b036079");
  self thread function_46575fe6();
  self thread function_524284e0();
  self.rock thread namespace_eaa992c::function_285a2999("glow_blue");
  level waittill("hash_4213cffb");
  wait(randomfloatrange(1, 2.5));
  self.rock thread doa_utility::function_a98c85b2(self.rock.var_e35d13, 1.5);
  self.rock thread namespace_1a381543::function_90118d8c("zmb_fate_rock_spawn");
  wait(1.5);
  self.rock thread namespace_eaa992c::function_285a2999("fate_impact");
  self.rock thread namespace_1a381543::function_90118d8c("zmb_fate_rock_imp");
  objective_add(self.id, "active", self.origin);
  objective_set3d(self.id, 1, "default", "*");
  while(true) {
    self waittill("trigger", guy);
    objective_state(self.id, "done");
    if(!isPlayer(guy)) {
      continue;
    }
    if(!var_26fc4461) {
      if(guy.doa.fate != 0) {
        continue;
      }
    } else if(isDefined(guy.doa.var_2219ffc9) && guy.doa.var_2219ffc9) {
      continue;
    }
    if(!var_26fc4461) {
      guy awardfate(self.type, self.rock);
      self notify("hash_9075e98");
      break;
    } else {
      guy.doa.var_2219ffc9 = 1;
      if(guy.doa.fate == 0) {
        avail = level.doa.var_b1698a42.types;
        players = namespace_831a4a7c::function_5eb6e4d1();
        foreach(player in players) {
          if(player == guy) {
            continue;
          }
          if(player.doa.fate == 0) {
            continue;
          }
          if(player.doa.fate == 10 || player.doa.fate == 1) {
            arrayremovevalue(avail, 1, 0);
          }
          if(player.doa.fate == 11 || player.doa.fate == 2) {
            arrayremovevalue(avail, 2, 0);
          }
          if(player.doa.fate == 12 || player.doa.fate == 3) {
            arrayremovevalue(avail, 3, 0);
          }
          if(player.doa.fate == 13 || player.doa.fate == 4) {
            arrayremovevalue(avail, 4, 0);
          }
        }
        assert(avail.size > 0);
        if(avail.size == 1) {
          fate = avail[0];
        } else {
          fate = avail[randomint(avail.size)];
        }
        guy awardfate(fate, self.rock);
        self notify("hash_9075e98");
      } else {
        if(isDefined(level.doa.var_aaefc0f3) && level.doa.var_aaefc0f3) {
          if(guy.doa.fate == 1) {
            type = 10;
          } else {
            if(guy.doa.fate == 2) {
              type = 11;
            } else {
              if(guy.doa.fate == 3) {
                type = 12;
              } else if(guy.doa.fate == 4) {
                type = 13;
              }
            }
          }
          if(isDefined(type)) {
            guy awardfate(type, self.rock);
            self notify("hash_14fdf5a2");
          } else {
            self thread function_78f27983(guy);
            self notify("hash_fad6c90b");
          }
          allfated = 1;
          foreach(player in getplayers()) {
            if(!isDefined(player.doa) || (!(isDefined(player.doa.var_2219ffc9) && player.doa.var_2219ffc9))) {
              allfated = 0;
              break;
            }
          }
          if(allfated) {
            level notify("hash_7b036079");
          }
        } else {
          if(self.type == 10 && guy.doa.fate == 1) {
            guy awardfate(self.type, self.rock);
            self notify("hash_14fdf5a2");
            level notify("hash_7b036079");
            break;
          } else {
            if(self.type == 11 && guy.doa.fate == 2) {
              guy awardfate(self.type, self.rock);
              self notify("hash_14fdf5a2");
              level notify("hash_7b036079");
              break;
            } else {
              if(self.type == 12 && guy.doa.fate == 3) {
                guy awardfate(self.type, self.rock);
                self notify("hash_14fdf5a2");
                level notify("hash_7b036079");
                break;
              } else {
                if(self.type == 13 && guy.doa.fate == 4) {
                  guy awardfate(self.type, self.rock);
                  self notify("hash_14fdf5a2");
                  level notify("hash_7b036079");
                  break;
                } else {
                  self thread function_78f27983(guy);
                  self notify("hash_fad6c90b");
                  break;
                }
              }
            }
          }
        }
      }
    }
  }
}

function function_b6841741() {
  level thread function_fd0b8976(&"DOA_FATE_FIREPOWER", 4, namespace_831a4a7c::function_fea7ed75(self.entnum));
  self.doa.default_weap = level.doa.var_416914d0;
  self.doa.var_1b58e8ba = 1;
  self namespace_831a4a7c::function_baa7411e(self.doa.default_weap);
}

function function_d30f9791() {
  level thread function_fd0b8976(&"DOA_FATE_FORTUNE", 4, namespace_831a4a7c::function_fea7ed75(self.entnum));
  if(self.doa.multiplier < 2) {
    self namespace_64c6b720::function_126dc996(2);
  }
}

function function_2a2ab6f9() {
  level thread function_fd0b8976(&"DOA_FATE_FEET", 4, namespace_831a4a7c::function_fea7ed75(self.entnum));
  self.doa.default_movespeed = level.doa.rules.var_b92b82b;
  self setmovespeedscale(level.doa.rules.var_b92b82b);
  self thread namespace_eaa992c::function_285a2999("fast_feet");
}

function function_4c552db8() {
  self.doa.var_1b58e8ba = 2;
  level thread function_fd0b8976(&"DOA_FATE_FRIENDSHIP", 4, namespace_831a4a7c::function_fea7ed75(self.entnum));
  self thread namespace_5e6c5d1f::function_d35a405a(level.doa.var_a7cfb7eb, 1);
}

function function_c8508847() {
  level thread function_fd0b8976(&"DOA_FATE_FORCE", 4, namespace_831a4a7c::function_fea7ed75(self.entnum));
  if(self.doa.boosters < 4) {
    self.doa.boosters = 4;
  }
  self thread namespace_eaa992c::function_285a2999("fate2_awarded");
}

function function_47b8a2a2() {
  level thread function_fd0b8976(&"DOA_FATE_FORTITUDE", 4, namespace_831a4a7c::function_fea7ed75(self.entnum));
  if(self.doa.multiplier < 3) {
    self namespace_64c6b720::function_126dc996(3);
  }
  self thread namespace_6df66aa5::function_2016b381();
  self thread namespace_eaa992c::function_285a2999("fate2_awarded");
}

function function_78c32d42() {
  level thread function_fd0b8976(&"DOA_FATE_FAVOR", 4, namespace_831a4a7c::function_fea7ed75(self.entnum));
  self thread namespace_5e6c5d1f::function_d35a405a(level.doa.var_9505395a, 2, 1.5);
  self thread namespace_eaa992c::function_285a2999("fate2_awarded");
}

function function_8c9288de() {
  level thread function_fd0b8976(&"DOA_FATE_FURY", 4, namespace_831a4a7c::function_fea7ed75(self.entnum));
  if(self.doa.bombs < 1) {
    self.doa.bombs = 1;
  }
  self.doa.default_weap = level.doa.var_69899304;
  self namespace_831a4a7c::function_baa7411e(self.doa.default_weap);
  self thread namespace_eaa992c::function_285a2999("fate2_awarded");
}

function private function_78f27983(player) {
  level thread function_fd0b8976(&"DOA_FATE_BOOBY_PRIZE", 4, namespace_831a4a7c::function_fea7ed75(self.entnum));
  if(isDefined(player.doa.var_eb1cd159)) {
    player thread doa_pickups::directeditemawardto(player, "zombietron_extra_life");
    var_a72e62b4 = int(player.doa.var_eb1cd159 / 75000);
    if(var_a72e62b4 < 3) {
      var_a72e62b4 = 3;
    }
    if(var_a72e62b4 > 12) {
      var_a72e62b4 = 12;
    }
    items = doa_pickups::spawnubertreasure(player.origin + vectorscale((0, 0, 1), 1000), 1, 75, 0, 0, var_a72e62b4);
    items[0] thread doa_pickups::function_53347911(player);
    player.doa.var_eb1cd159 = 0;
  }
}

function awardfate(type, rock) {
  if(isDefined(rock)) {
    rock thread namespace_eaa992c::function_285a2999("fate_trigger");
    rock thread namespace_1a381543::function_90118d8c("zmb_fate_choose");
  }
  self.doa.fate = type;
  switch (type) {
    case 1: {
      level thread function_17fb777b(self, getweaponworldmodel(level.doa.var_e00fcc77), 2.1, &function_b6841741);
      break;
    }
    case 2: {
      level thread function_17fb777b(self, "zombietron_ruby", 4, &function_d30f9791);
      break;
    }
    case 4: {
      level thread function_17fb777b(self, level.doa.var_f7277ad6, 4, &function_2a2ab6f9);
      break;
    }
    case 3: {
      level thread function_17fb777b(self, level.doa.var_a7cfb7eb, 4, &function_4c552db8);
      break;
    }
    case 10: {
      level thread function_17fb777b(self, "zombietron_statue_fury", 1, &function_8c9288de);
      break;
    }
    case 11: {
      level thread function_17fb777b(self, "zombietron_statue_fortitude", 1, &function_47b8a2a2);
      break;
    }
    case 12: {
      level thread function_17fb777b(self, "zombietron_statue_favor", 1, &function_78c32d42);
      break;
    }
    case 13: {
      level thread function_17fb777b(self, "zombietron_statue_force", 1, &function_c8508847);
      break;
    }
    default: {
      assert(0);
      break;
    }
  }
}

function function_17fb777b(player, model, modelscale, fate_cb) {
  player endon("disconnect");
  if(!isDefined(modelscale)) {
    modelscale = 1;
  }
  origin = player.origin + vectorscale((0, 0, 1), 800);
  object = spawn("script_model", origin);
  object.targetname = "directedFate";
  yaw = randomint(360);
  object.angles = (0, yaw, 25);
  object setModel(model);
  object setscale(modelscale);
  object setplayercollision(0);
  object thread doa_utility::function_a625b5d3(player);
  while(isPlayer(player)) {
    if(object.origin[2] < player.origin[2]) {
      object.origin = player.origin;
      break;
    }
    modz = (player.origin[0], player.origin[1], object.origin[2] - 32);
    object.origin = modz;
    wait(0.05);
  }
  if(isPlayer(player)) {
    object thread namespace_eaa992c::function_285a2999("fate_explode");
    player playrumbleonentity("artillery_rumble");
    if(mayspawnentity()) {
      player playsoundtoplayer("zmb_doa_receive_fate", player);
    }
    player[[fate_cb]]();
  }
  object delete();
}

function private function_46575fe6() {
  level waittill("hash_7b036079");
  if(isDefined(self)) {
    objective_delete(self.id);
    self triggerenable(0);
    level doa_utility::function_d0e32ad0(1);
    if(isDefined(self.rock)) {
      self.rock delete();
    }
    self delete();
  }
}

function function_c631d045() {
  var_de2c598 = undefined;
  candidates = [];
  foreach(player in getplayers()) {
    if(!isDefined(player.doa)) {
      continue;
    }
    if(player.doa.fate == 10) {
      doa_utility::debugmsg(("" + (isDefined(player.name) ? player.name : player getentitynumber())) + "");
      continue;
    }
    if(player.doa.fate == 11) {
      doa_utility::debugmsg(("" + (isDefined(player.name) ? player.name : player getentitynumber())) + "");
      continue;
    }
    if(player.doa.fate == 12) {
      doa_utility::debugmsg(("" + (isDefined(player.name) ? player.name : player getentitynumber())) + "");
      continue;
    }
    if(player.doa.fate == 13) {
      doa_utility::debugmsg(("" + (isDefined(player.name) ? player.name : player getentitynumber())) + "");
      continue;
    }
    candidates[candidates.size] = player;
  }
  foreach(candidate in candidates) {
    damage = (isDefined(candidate.doa.var_eb1cd159) ? candidate.doa.var_eb1cd159 : randomint(100));
    karma = candidate.doa.var_faf30682 * 8000;
    candidate.doa.var_e5be00e0 = damage + karma;
    doa_utility::debugmsg((("" + (isDefined(candidate.name) ? candidate.name : candidate getentitynumber())) + "") + candidate.doa.var_e5be00e0);
    doa_utility::debugmsg("" + damage);
    doa_utility::debugmsg("" + karma);
    if(!isDefined(var_de2c598)) {
      var_de2c598 = candidate;
      continue;
    }
    if(var_de2c598.doa.var_e5be00e0 < candidate.doa.var_e5be00e0) {
      var_de2c598 = candidate;
    }
  }
  return var_de2c598;
}

function function_833dad0d() {
  level notify("hash_e2918623");
  level endon("hash_d1f5acf7");
  guardian = getent("temple_guardian", "targetname");
  var_526b2f85 = getent("temple_guardian_clip", "targetname");
  guardian.origin = guardian.origin + (vectorscale((0, 0, -1), 1000));
  var_526b2f85.origin = var_526b2f85.origin + (vectorscale((0, 0, -1), 1000));
  level thread function_be1e2cfc(guardian, var_526b2f85);
  level.doa.rules.max_enemy_count = 20;
  level thread doa_pickups::function_c1869ec8();
  level thread doa_utility::clearallcorpses();
  level thread namespace_d88e3a06::function_116bb43();
  level notify("hash_a50a72db");
  level thread doa_utility::set_lighting_state(3);
  namespace_cdb9a8fe::function_691ef36b();
  namespace_cdb9a8fe::function_703bb8b2(30);
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    players[i].doa.var_eb1cd159 = 0;
    players[i].doa.var_2219ffc9 = undefined;
  }
  level.doa.var_b1698a42.var_1bcf76cc = 1;
  flag::set("doa_round_active");
  level thread function_b6a1fab3();
  doa_utility::debugmsg("");
  doa_utility::function_390adefe(0);
  level thread doa_utility::function_c5f3ece8(&"DOA_TRIAL_OF_JUDGEMENT", undefined, 6);
  wait(1);
  level thread doa_utility::function_37fb5c23(&"DOA_RIGHTEOUS_ROOM_BATTLE");
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    players[i] freezecontrols(0);
  }
  wait(3);
  level clientfield::set("activateBanner", 1);
  wait(4);
  level thread namespace_3ca3c537::function_a50a72db();
  level notify("hash_3b6e1e2");
  doa_utility::debugmsg("");
  level waittill("hash_cb54277d");
  doa_utility::debugmsg("");
  level clientfield::set("activateBanner", 0);
  flag::clear("doa_round_active");
  level thread doa_utility::function_1ced251e();
  level waittill("hash_852a9fcd");
  doa_utility::debugmsg("");
  doa_utility::function_44eb090b();
  level thread doa_pickups::function_c1869ec8();
  level thread doa_utility::clearallcorpses();
  var_de2c598 = function_c631d045();
  if(!isDefined(var_de2c598)) {
    level notify("hash_43593ce6");
    return;
  }
  doa_utility::debugmsg((("" + (isDefined(var_de2c598.name) ? var_de2c598.name : var_de2c598 getentitynumber())) + "") + var_de2c598.doa.var_e5be00e0);
  for(i = 0; i < level.doa.var_b1698a42.var_9c35e18e.size; i++) {
    type = (10 + var_de2c598.doa.fate) - 1;
    loc = level.doa.var_b1698a42.var_70a33a0b[i];
    rock = spawn("script_model", loc.origin + vectorscale((0, 0, 1), 2000));
    rock.targetname = "doRoomOfJudgement";
    rock.var_e35d13 = loc.origin;
    rock.var_103432a2 = rock.origin;
    rock.angles = loc.angles + vectorscale((0, 1, 0), 90);
    rock setModel(level.doa.var_b1698a42.var_f485e213);
    trigger = spawn("trigger_radius", rock.origin, 0, loc.radius, 128);
    trigger.targetname = "fate2trigger";
    trigger.type = type;
    trigger.rock = rock;
    trigger.id = i;
    trigger thread function_271ba816(1);
    trigger enablelinkto();
    trigger linkto(rock);
    level.doa.var_b1698a42.var_cadf4b04[level.doa.var_b1698a42.var_cadf4b04.size] = trigger;
  }
  locs = struct::get_array("fate_player_spawn", "targetname");
  if(isDefined(locs) && locs.size == 4) {
    foreach(player in getplayers()) {
      spot = locs[player.entnum];
      player namespace_cdb9a8fe::function_fe0946ac(spot.origin);
      player setplayerangles((0, spot.angles[1], 0));
    }
  } else {
    namespace_cdb9a8fe::function_55762a85(namespace_3ca3c537::function_61d60e0b());
  }
  level thread doa_utility::set_lighting_state(3);
  namespace_831a4a7c::function_82e3b1cb();
  doa_utility::debugmsg("");
  doa_utility::function_390adefe(0);
  level thread doa_utility::function_c5f3ece8(&"DOA_RIGHTEOUS_ROOM", undefined, 6);
  if(!(isDefined(level.doa.var_aaefc0f3) && level.doa.var_aaefc0f3)) {
    level thread doa_utility::function_37fb5c23(&"DOA_FATE_ONLY_ONE");
  } else {
    level thread doa_utility::function_37fb5c23(&"DOA_FATE_ALL_WORTHY");
  }
  level notify("hash_4213cffb");
  wait(4);
  foreach(player in getplayers()) {
    player freezecontrols(0);
    player thread namespace_831a4a7c::function_4519b17(0);
  }
  level thread function_6162a853(1);
  doa_utility::debugmsg("");
  level waittill("hash_7b036079");
  doa_utility::debugmsg("");
  level thread doa_utility::function_c5f3ece8(&"DOA_RIGHTEOUS_ROOM_DONE");
  wait(5);
  doa_utility::debugmsg("ROJ Complete");
  level notify("hash_43593ce6");
  doa_utility::function_44eb090b();
}

function function_be1e2cfc(guardian, var_526b2f85) {
  msg = level util::waittill_any("graveofJusticeDone", "player_challenge_failure");
  level clientfield::set("activateBanner", 0);
  level waittill("fade_out_complete");
  if(isDefined(level.doa.boss)) {
    level.doa.boss delete();
  }
  level thread doa_utility::set_lighting_state(level.doa.arena_round_number);
  level.doa.var_aaefc0f3 = 1;
  level.doa.var_b1698a42.var_cadf4b04 = [];
  guardian.origin = guardian.origin + vectorscale((0, 0, 1), 1000);
  var_526b2f85.origin = var_526b2f85.origin + vectorscale((0, 0, 1), 1000);
  level.doa.var_b1698a42.var_1bcf76cc = 0;
  level.doa.rules.max_enemy_count = namespace_3ca3c537::function_b0e9983(namespace_3ca3c537::function_d2d75f5d());
}

function private function_5aaa5a64(shield) {
  self endon("death");
  level endon("hash_cb54277d");
  while(true) {
    self waittill("trigger", guy);
    if(!isalive(guy)) {
      continue;
    }
    if(!isDefined(guy.doa)) {
      continue;
    }
    if(!isDefined(guy.doa.var_d6d294af)) {
      guy.doa.var_d6d294af = 0;
    }
    if(gettime() < guy.doa.var_d6d294af) {
      continue;
    }
    guy.doa.var_d6d294af = gettime() + 3000;
    guy thread namespace_eaa992c::function_285a2999("stoneboss_shield_death");
    shield thread namespace_1a381543::function_90118d8c("zmb_boss_shield_death");
    guy dodamage(guy.health + 500, guy.origin);
  }
}

function private function_d654dcd9() {
  level util::waittill_any("boss_of_justice_died", "player_challenge_failure");
  if(isDefined(self)) {
    if(isDefined(self.shield)) {
      if(isDefined(self.shield.trigger)) {
        self.shield.trigger delete();
      }
      self.shield thread namespace_eaa992c::function_285a2999("stoneboss_shield_explode");
      util::wait_network_frame();
      if(isDefined(self) && isDefined(self.shield)) {
        self.shield delete();
      }
    }
    if(isDefined(self)) {
      self delete();
    }
  }
}

function private function_60a14daa(boss) {
  self.boss = boss;
  self endon("death");
  while(true) {
    self rotateto(self.angles + vectorscale((0, 1, 0), 180), 2);
    wait(2);
  }
}

function private function_b1d23a45(boss) {
  level endon("hash_d1f5acf7");
  self thread namespace_eaa992c::function_285a2999("tesla_trail");
  self.angles = vectorscale((0, 0, 1), 180);
  self.trigger = spawn("trigger_radius", self.origin, 0, 30, 50);
  self.trigger.targetname = "boss_shieldThink";
  self.trigger enablelinkto();
  self.trigger linkto(self);
  self.trigger thread function_5aaa5a64(self);
  self.health = 100000;
  self.maxhealth = self.health;
  self.takedamage = 1;
  stage1 = int(self.maxhealth * 0.75);
  stage2 = int(self.maxhealth * 0.25);
  while(self.health > 0) {
    lasthealth = self.health;
    self waittill("damage", damage);
    if(isDefined(self.var_e34a8df9)) {
      self thread namespace_eaa992c::function_285a2999("stoneboss_shield_explode");
      loc = spawnStruct();
      loc.origin = self.origin;
      loc.angles = self.angles;
      if(level.doa.var_b351e5fb >= level.doa.rules.max_enemy_count) {
        doa_utility::function_fe180f6f(3);
        wait(0.05);
      }
      ai = namespace_51bd792::function_fb051310(self.var_e34a8df9, loc, undefined, 0, 1);
      if(isDefined(ai)) {
        ai.spawner = self.var_e34a8df9;
        ai.team = "axis";
        ai.health = 5000;
        ai.maxhealth = ai.health;
        ai.var_2d8174e3 = 1;
        ai thread doa_utility::function_dbcf48a0();
      }
      break;
    } else {
      self.health = self.health - damage;
      if(lasthealth > stage1 && self.health < stage1) {
        self setModel("zombietron_boss_shield_damage_size" + self.org.regenerated);
        self thread namespace_eaa992c::function_285a2999("stoneboss_shield_explode");
      } else if(lasthealth > stage2 && self.health < stage2) {
        self setModel("zombietron_boss_shield_destroyed_size" + self.org.regenerated);
        self thread namespace_eaa992c::function_285a2999("stoneboss_shield_explode");
      }
    }
  }
  if(isDefined(self.trigger)) {
    self.trigger delete();
  }
  if(isDefined(boss)) {
    boss notify("hash_d57cf5a3", self.org);
  }
  if(isDefined(self)) {
    self delete();
  }
}

function private function_4d69c061(org) {
  level endon("hash_d1f5acf7");
  level endon("hash_cb54277d");
  if(!isDefined(org)) {
    return;
  }
  org.regenerated++;
  if(isDefined(org.var_e34a8df9) && org.regenerated > 4) {
    org.regenerated = 4;
  }
  if(org.regenerated > 4) {
    org delete();
    return;
  }
  wait(12 - (getplayers().size * 2));
  shield = spawn("script_model", self.origin);
  shield.targetname = "_shieldRegenerate";
  shield.org = org;
  if(isDefined(org.shield)) {
    if(isDefined(org.shield.trigger)) {
      org.shield.trigger delete();
    }
    org.shield delete();
  }
  org.shield = shield;
  if(isDefined(org.var_e34a8df9)) {
    shield setModel("veh_t7_drone_insanity_elemental");
    shield.var_e34a8df9 = org.var_e34a8df9;
    shield linkto(shield.org, "tag_origin", (0, 164 - (org.regenerated * 8), 60), vectorscale((0, 0, 1), 180));
  } else {
    shield setModel("zombietron_boss_shield_full_size" + org.regenerated);
    shield linkto(shield.org, "tag_origin", (0, 164 - (org.regenerated * 8), 30), vectorscale((0, 0, 1), 180));
  }
  shield thread function_b1d23a45(org.boss);
  org.boss.shields[org.index] = shield;
}

function private function_51f0dd2c() {
  level endon("hash_d1f5acf7");
  level endon("hash_cb54277d");
  var_3fb52dd3 = 20;
  var_7383e7dd = [];
  var_7383e7dd[var_7383e7dd.size] = 0;
  if(level.doa.round_number > 64) {
    var_7383e7dd[var_7383e7dd.size] = 9;
  }
  if(level.doa.round_number > 128) {
    var_7383e7dd[var_7383e7dd.size] = 14;
  }
  if(level.doa.round_number > 192) {
    var_7383e7dd[var_7383e7dd.size] = 4;
  }
  for(i = 0; i < var_3fb52dd3; i++) {
    org = spawn("script_model", self.origin);
    org.targetname = "_bossShield";
    org setModel("tag_origin");
    org thread function_60a14daa(self);
    org thread function_d654dcd9();
    org.index = i;
    org.regenerated = 1;
    shield = spawn("script_model", self.origin);
    shield.targetname = "shield";
    shield.org = org;
    org.shield = shield;
    if(!isinarray(var_7383e7dd, i)) {
      shield setModel("zombietron_boss_shield_full_size1");
      shield linkto(shield.org, "tag_origin", (0, 164, 30), vectorscale((0, 0, 1), 180));
    } else {
      shield setModel("veh_t7_drone_insanity_elemental");
      org.var_e34a8df9 = getent("spawner_meatball", "targetname");
      shield.var_e34a8df9 = org.var_e34a8df9;
      shield linkto(shield.org, "tag_origin", (0, 164, 60), vectorscale((0, 0, 1), 180));
    }
    shield thread function_b1d23a45(self);
    self.shields[self.shields.size] = shield;
    wait(0.2);
  }
  while(true) {
    self waittill("hash_d57cf5a3", org);
    self thread function_4d69c061(org);
  }
}

function private function_cb98790d() {
  level endon("hash_d1f5acf7");
  level endon("hash_cb54277d");
  while(true) {
    level waittill("hash_8817f58");
    foreach(ball in self.shields) {
      if(isDefined(ball)) {
        ball thread namespace_eaa992c::function_285a2999("stoneboss_shield_explode");
        util::wait_network_frame();
        if(isDefined(ball)) {
          ball dodamage(ball.maxhealth, ball.origin);
        }
        wait(0.05);
      }
    }
  }
}

function private function_c492e72d() {
  level endon("hash_d1f5acf7");
  self.health = doa_utility::clamp((level.doa.round_number * 20000) + (getplayers().size * 250000), 250000, 2250000);
  self.maxhealth = self.health;
  self.boss = 1;
  self.takedamage = 0;
  self.shields = [];
  self thread function_51f0dd2c();
  self thread function_cb98790d();
  self thread function_ae21464b();
  self thread function_5c819284();
  level waittill("hash_3b6e1e2");
  self.takedamage = 1;
  stage1 = int(self.health * 0.85);
  stage2 = int(self.health * 0.7);
  stage3 = int(self.health * 0.55);
  var_301961e7 = int(self.health * 0.4);
  var_a16e77e = int(self.health * 0.2);
  if(isDefined(level.doa.dev_level_skipped)) {
    self thread namespace_4973e019::function_76b30cc1();
  }
  while(self.health > 0) {
    lasthealth = self.health;
    self waittill("damage", damage, attacker);
    data = doa_utility::clamp(self.health / self.maxhealth, 0, 1);
    level clientfield::set("pumpBannerBar", data);
    if(isDefined(attacker)) {
      if(!isPlayer(attacker)) {
        if(isDefined(attacker.owner) && isPlayer(attacker.owner)) {
          attacker = attacker.owner;
        }
      }
      if(isDefined(attacker.doa) && isPlayer(attacker)) {
        if(!isDefined(attacker.doa.var_eb1cd159)) {
          attacker.doa.var_eb1cd159 = 0;
        }
        attacker.doa.var_eb1cd159 = attacker.doa.var_eb1cd159 + damage;
        attacker namespace_64c6b720::function_80eb303(int(damage * 0.25), 1);
      }
    }
    if(lasthealth > stage1 && self.health < stage1) {
      self thread namespace_eaa992c::function_285a2999("stoneboss_dmg1");
      self thread namespace_1a381543::function_90118d8c("zmb_stoneboss_damaged");
      level notify("hash_55acdab7");
    } else {
      if(lasthealth > stage2 && self.health < stage2) {
        self thread namespace_eaa992c::function_285a2999("stoneboss_dmg2");
        self thread namespace_1a381543::function_90118d8c("zmb_stoneboss_damaged");
        level notify("hash_55acdab7");
      } else {
        if(lasthealth > stage3 && self.health < stage3) {
          self thread namespace_eaa992c::function_285a2999("stoneboss_dmg3");
          self thread namespace_1a381543::function_90118d8c("zmb_stoneboss_damaged");
          level notify("hash_55acdab7");
        } else {
          if(lasthealth > var_301961e7 && self.health < var_301961e7) {
            self thread namespace_eaa992c::function_285a2999("stoneboss_dmg4");
            self thread namespace_1a381543::function_90118d8c("zmb_stoneboss_damaged");
            level notify("hash_55acdab7");
          } else if(lasthealth > var_a16e77e && self.health < var_a16e77e) {
            self thread namespace_eaa992c::function_285a2999("stoneboss_dmg5");
            self thread namespace_1a381543::function_90118d8c("zmb_stoneboss_damaged");
            level notify("hash_55acdab7");
          }
        }
      }
    }
    doa_utility::debugmsg("" + self.health);
  }
  self thread namespace_eaa992c::function_285a2999("stoneboss_death");
  self thread namespace_1a381543::function_90118d8c("zmb_stoneboss_died");
  self notify("defeated");
  level notify("defeated", self);
  level notify("hash_cb54277d");
}

function private function_ae21464b() {
  level endon("hash_d1f5acf7");
  level endon("hash_cb54277d");
  while(true) {
    wait(randomintrange(10, 20) - (getplayers().size * 1.2));
    self thread namespace_1a381543::function_90118d8c("zmb_boss_sound_minion_summon");
    level notify("hash_55acdab7");
    if(getdvarint("", 0)) {
      self dodamage(int(self.maxhealth * 0.1), self.origin);
    }
  }
}

function private function_5c819284() {
  level endon("hash_d1f5acf7");
  level endon("hash_cb54277d");
  spawn_set = level.doa.arenas[level.doa.current_arena].name + "_enemy_spawn";
  level.doa.current_spawners = level.doa.spawners[spawn_set];
  level.doa.var_3706f843 = [];
  while(true) {
    for(wave = 0; wave < level.doa.spawn_sequence.size; wave++) {
      level waittill("hash_55acdab7");
      if(level flag::get("doa_game_is_over")) {
        return;
      }
      if(!level flag::get("doa_round_active")) {
        return;
      }
      level.doa.current_wave = level.doa.spawn_sequence[wave];
      level thread namespace_cdb9a8fe::function_21a582ff(level.doa.current_wave, "boss_of_justice_died");
    }
  }
}

function private function_b6a1fab3() {
  level endon("hash_d1f5acf7");
  level.doa.var_d0cde02c = undefined;
  var_60de7d19 = namespace_3ca3c537::function_61d60e0b();
  var_9a550361 = var_60de7d19;
  boss = spawn("script_model", var_9a550361);
  boss.targetname = "stoneguardian";
  boss setModel(level.doa.var_b1698a42.var_6e3ecc6b);
  boss thread function_c492e72d();
  level.doa.boss = boss;
  badplace_cylinder("bossJustice", -1, boss.origin, 180, 64, "all");
  loc = level.doa.var_b1698a42.locations[0];
  fury = spawn("script_model", loc.origin);
  fury.targetname = "fury";
  fury setModel("zombietron_statue_fury");
  fury.angles = loc.angles + vectorscale((0, 1, 0), 90);
  fury thread doa_utility::function_783519c1("player_challenge_failure", 1);
  loc = level.doa.var_b1698a42.locations[1];
  force = spawn("script_model", loc.origin);
  force.targetname = "force";
  force setModel("zombietron_statue_force");
  force.angles = loc.angles + vectorscale((0, 1, 0), 90);
  force thread doa_utility::function_783519c1("player_challenge_failure", 1);
  loc = level.doa.var_b1698a42.locations[2];
  var_47bba3bb = spawn("script_model", loc.origin);
  var_47bba3bb.targetname = "fortitude";
  var_47bba3bb setModel("zombietron_statue_fortitude");
  var_47bba3bb.angles = loc.angles + vectorscale((0, 1, 0), 90);
  var_47bba3bb thread doa_utility::function_783519c1("player_challenge_failure", 1);
  loc = level.doa.var_b1698a42.locations[3];
  favor = spawn("script_model", loc.origin);
  favor.targetname = "favor";
  favor setModel("zombietron_statue_favor");
  favor.angles = loc.angles + vectorscale((0, 1, 0), 90);
  favor thread doa_utility::function_783519c1("player_challenge_failure", 1);
  level waittill("hash_cb54277d");
  level.doa.boss = undefined;
  badplace_delete("bossJustice");
  playFX(level._effect["def_explode"], boss.origin + (randomint(120), randomint(120), randomint(120)));
  wait(1);
  level thread doa_utility::function_c5f3ece8(&"DOA_RIGHTEOUS_ROOM_BATTLE_WON");
  for(i = 0; i < 6; i++) {
    playFX(level._effect["def_explode"], boss.origin + (randomint(120), randomint(120), randomint(120)));
    wait(randomfloatrange(0.25, 1.2));
  }
  boss thread doa_utility::function_a98c85b2(boss.origin + vectorscale((0, 0, 1), 2000), 1.75);
  boss thread namespace_eaa992c::function_285a2999("fate_impact");
  boss thread namespace_eaa992c::function_285a2999("stoneboss_death");
  wait(4);
  fury thread doa_utility::function_a98c85b2(fury.origin + vectorscale((0, 0, 1), 2000), 1.75);
  fury thread namespace_eaa992c::function_285a2999("fate_impact");
  fury thread namespace_eaa992c::function_285a2999("fate_launch");
  wait(1);
  force thread doa_utility::function_a98c85b2(force.origin + vectorscale((0, 0, 1), 2000), 1.75);
  force thread namespace_eaa992c::function_285a2999("fate_impact");
  force thread namespace_eaa992c::function_285a2999("fate_launch");
  wait(1);
  var_47bba3bb thread doa_utility::function_a98c85b2(var_47bba3bb.origin + vectorscale((0, 0, 1), 2000), 1.75);
  var_47bba3bb thread namespace_eaa992c::function_285a2999("fate_impact");
  var_47bba3bb thread namespace_eaa992c::function_285a2999("fate_launch");
  wait(1);
  favor thread doa_utility::function_a98c85b2(favor.origin + vectorscale((0, 0, 1), 2000), 1.75);
  favor thread namespace_eaa992c::function_285a2999("fate_impact");
  favor thread namespace_eaa992c::function_285a2999("fate_launch");
  wait(2);
  level notify("hash_852a9fcd");
  boss delete();
  var_47bba3bb delete();
  force delete();
  fury delete();
  favor delete();
}

function function_3caf8e2(endtime) {
  self endon("disconnect");
  lastposition = self.origin;
  stepsize = 20;
  self clientfield::set("fated_boost", 1);
  while(gettime() < endtime) {
    wait(0.2);
    normal = vectornormalize(self.origin - lastposition);
    step = normal * stepsize;
    dist = distance(self.origin, lastposition);
    if(dist < 10) {
      continue;
    }
    steps = int((dist / stepsize) + 0.5);
    for(i = 0; i < steps; i++) {
      self thread function_69ae5d15(lastposition);
      lastposition = lastposition + step;
    }
    var_d4961e33 = self.origin;
  }
  self clientfield::set("fated_boost", 0);
  self notify("hash_c6e7fa2c");
}

function private function_69ae5d15(loc) {
  if(!self isonground()) {
    return;
  }
  if(isDefined(self.doa.vehicle)) {
    return;
  }
  if(!mayspawnfakeentity()) {
    return;
  }
  trigger = spawn("trigger_radius", loc, 9, 36, 64);
  if(!isDefined(trigger)) {
    return;
  }
  trigger endon("death");
  trigger.targetname = "furyhotspot";
  trigger thread doa_utility::function_a625b5d3(self);
  variance = randomfloatrange(0, 3);
  time = 10 + variance;
  trigger thread doa_utility::function_1bd67aef(time);
  timeleft = gettime() + (time * 1000);
  while(gettime() < timeleft) {
    wait(0.05);
    trigger waittill("trigger", guy);
    if(isPlayer(guy)) {
      continue;
    }
    if(!(isDefined(guy.takedamage) && guy.takedamage)) {
      continue;
    }
    if(isDefined(guy.boss) && guy.boss) {
      continue;
    }
    if(isDefined(guy.var_dd70dacd) && guy.var_dd70dacd) {
      continue;
    }
    time = gettime();
    if(isDefined(guy.var_4c8b5b70) && (time - guy.var_4c8b5b70) < 1000) {
      continue;
    }
    guy asmsetanimationrate(0.75);
    guy dodamage(int(guy.maxhealth * 0.3), guy.origin, self, undefined, "none", "MOD_BURNED");
    if(!(isDefined(guy.nofire) && guy.nofire)) {
      guy thread function_9fc6e261();
      guy clientfield::set("burnType", 3);
      guy clientfield::increment("burnZombie");
    }
    guy.var_4c8b5b70 = time;
  }
}

function private function_9fc6e261() {
  self notify("hash_9fc6e261");
  self endon("hash_9fc6e261");
  self waittill("actor_corpse", corpse);
  wait(0.05);
  if(isDefined(corpse)) {
    corpse clientfield::set("burnType", 3);
    wait(0.05);
    if(isDefined(corpse)) {
      corpse clientfield::increment("burnCorpse");
      if(randomint(100) < 50) {
        corpse clientfield::set("enemy_ragdoll_explode", 1);
      }
    }
  }
}