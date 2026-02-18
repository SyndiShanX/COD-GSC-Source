/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\spy_skill.csc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreaks_shared;
#namespace spy_skill;

function private autoexec __init__system__() {
  system::register(#"spy_skill", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register("allplayers", "victim_entity_num", 28000, 5, "int", &function_a9a10d27, 0, 0);
  clientfield::register("toplayer", "corpse_entity_num", 28000, 5, "int", &function_4e5d4ff3, 0, 0);
  clientfield::register("allplayers", "footsteps_victim_entity_num", 28000, 5, "int", &function_cc526382, 0, 0);
  callback::on_localclient_connect(&on_localclient_connect);
}

function function_a9a10d27(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self.var_54d9d1ec)) {
    self.var_54d9d1ec = [];
  }

  self notify(#"hash_1fe8f1718c04fe6f");
  self.var_54d9d1ec[self.var_54d9d1ec.size] = bwastimejump;
  self thread function_21e56524(fieldname, self.var_54d9d1ec);
}

function on_localclient_connect(localclientnum) {
  if(!isDefined(level.var_f3c7bd5b)) {
    level.var_f3c7bd5b = [];
  }

  objid = util::getnextobjid(localclientnum);
  objective_add(localclientnum, objid, "invisible", #"hash_19462339fa3faabe");
  objective_setprogress(localclientnum, objid, 0);
  objective_setstate(localclientnum, objid, "invisible");
  level.var_f3c7bd5b[localclientnum] = objid;
}

function function_4e5d4ff3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!self function_21c0fa55()) {
    return;
  }

  if(!isDefined(level.var_f3c7bd5b)) {
    level.var_f3c7bd5b = [];
  }

  objid = level.var_f3c7bd5b[fieldname];

  if(!isDefined(objid)) {
    return;
  }

  if(bwastimejump > -1 && bwastimejump < 26) {
    if(isarray(level.var_1305770) && isDefined(level.var_1305770[bwastimejump])) {
      objective_setposition(fieldname, objid, level.var_1305770[bwastimejump]);
    }

    objective_setstate(fieldname, objid, "active");
    return;
  }

  objective_setstate(fieldname, objid, "invisible");
}

function function_9e405bd3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(level.var_df88fad2)) {
    level.var_df88fad2 = [];
  }

  level.var_df88fad2[self.networkid] = self;
}

function function_cc526382(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!self function_21c0fa55()) {
    return;
  }

  var_7f9208ab = bwastimejump;
  self notify(#"hash_702a72528dfed0db");

  if(var_7f9208ab == 26) {
    return;
  } else {
    wait 0.1;
  }

  if(!isDefined(self)) {
    return;
  }

  players = getplayers(fieldname);

  foreach(player in players) {
    if(isDefined(player.var_54d9d1ec) && isDefined(player.var_27a6fded)) {
      if(!isDefined(self.var_71734ec4)) {
        self.var_71734ec4 = [];
      }

      foreach(var_a0375b77 in player.var_54d9d1ec) {
        if(var_a0375b77 == var_7f9208ab && isDefined(player.var_27a6fded[var_a0375b77])) {
          self thread function_74055c74(fieldname, player.var_27a6fded[var_a0375b77]);
          self.var_71734ec4[var_a0375b77] = 1;
          return;
        }

        self.var_71734ec4[var_a0375b77] = 0;
      }
    }
  }

  foreach(var_54e22ca2 in level.var_3866f854) {
    var_27a6fded = var_54e22ca2[var_7f9208ab];

    if(isDefined(var_27a6fded[var_7f9208ab])) {
      self thread function_74055c74(fieldname, var_27a6fded[var_7f9208ab]);
      return;
    }
  }
}

function function_21e56524(local_client_num, var_54d9d1ec) {
  level endon(#"game_ended");
  self endon(#"hash_1fe8f1718c04fe6f", #"death");
  var_560db6a = self getentitynumber() % 15;
  var_9426f90f = int(gettime() / 16) % 15;
  self.var_c37910a5 = self.origin;

  if(!isDefined(self.var_10dddc20)) {
    self.var_10dddc20 = [];
  }

  var_d09d444f = var_54d9d1ec;

  while(isDefined(self) && var_d09d444f.size > 0) {
    if(var_9426f90f == var_560db6a) {
      wait 0.24;
    } else {
      self waittilltimeout((15 + var_560db6a - var_9426f90f) % 15 * 0.016, #"death");
    }

    var_9426f90f = int(gettime() / 16) % 15;
    positionandrotationstruct = self function_faf7d71b(local_client_num);

    foreach(var_a0375b77 in var_d09d444f) {
      if(!isDefined(self.var_10dddc20[var_a0375b77])) {
        self.var_10dddc20[var_a0375b77] = 0;
      }

      if(self.var_10dddc20[var_a0375b77] > 40) {
        arrayremovevalue(var_d09d444f, var_a0375b77);
        continue;
      }

      if(isDefined(positionandrotationstruct)) {
        if(!isDefined(self.var_27a6fded)) {
          self.var_27a6fded = [];
        }

        if(!isDefined(self.var_27a6fded[var_a0375b77])) {
          self.var_27a6fded[var_a0375b77] = [];
        }

        index = self.var_10dddc20[var_a0375b77];
        self.var_27a6fded[var_a0375b77][index] = positionandrotationstruct;

        if(isDefined(self.var_71734ec4[var_a0375b77]) && self.var_71734ec4[var_a0375b77]) {
          handle = playFX(local_client_num, positionandrotationstruct.fx, positionandrotationstruct.pos, positionandrotationstruct.fwd);

          if(!isDefined(self.var_9d939573)) {
            self.var_9d939573 = [];
          }

          self.var_9d939573[self.var_9d939573.size] = handle;
        }

        self.var_10dddc20[var_a0375b77]++;
      }
    }
  }
}

function function_faf7d71b(local_client_num) {
  player = self;

  if(is_true(self._isclone)) {
    player = self.owner;
  }

  if(!isDefined(level.var_19d86f63)) {
    level.var_19d86f63 = (0, 0, getdvarfloat(#"perk_tracker_fx_foot_height", 0));
  }

  pos = self.origin + level.var_19d86f63;

  if(!isDefined(self.var_c37910a5)) {
    self.var_c37910a5 = pos;
  }

  if(distancesquared(self.var_c37910a5, pos) > 1024) {
    if(is_true(self.trailrightfoot)) {
      fx = # "hash_18f1b4f6dff39f44";
    } else {
      fx = # "hash_427f0cf6af092813";
    }

    fwd = self getvelocity();

    if(lengthsquared(fwd) < 1) {
      fwd = anglesToForward(self.angles);
    }

    positionandrotation = {
      #fx: fx, #pos: pos, #fwd: fwd
    };
    self.var_c37910a5 = self.origin;
    self.trailrightfoot = !is_true(self.trailrightfoot);
  }

  return positionandrotation;
}

function function_74055c74(local_client_num, var_8aacd418) {
  self endon(#"death", #"hash_702a72528dfed0db");
  self thread function_8c02beb1(local_client_num);

  if(!isDefined(self.var_9d939573)) {
    self.var_9d939573 = [];
  }

  foreach(var_e67d707a in var_8aacd418) {
    if(!isDefined(self)) {
      continue;
    }

    handle = playFX(local_client_num, var_e67d707a.fx, var_e67d707a.pos, var_e67d707a.fwd);
    self.var_9d939573[self.var_9d939573.size] = handle;
    wait 0.1;
  }
}

function function_b2be9a0c(local_client_num, handle) {
  if(!isDefined(self.var_48d473a8)) {
    self.var_48d473a8 = spawnStruct();
    self.var_48d473a8.array = [];
    self.var_48d473a8.index = 0;
  }

  if(handle) {
    servertime = getservertime(local_client_num);
    var_c3dbbcab = spawnStruct();
    var_c3dbbcab.time = servertime;
    var_c3dbbcab.handle = handle;
    index = self.var_48d473a8.index;

    if(index >= 40) {
      index = 0;
    }

    self.var_48d473a8.array[index] = var_c3dbbcab;
    self.var_48d473a8.index = index + 1;
  }
}

function function_8c02beb1(local_client_num) {
  self waittill(#"death", #"hash_702a72528dfed0db");

  if(!isDefined(self.var_9d939573)) {
    return;
  }

  foreach(handle in self.var_9d939573) {
    killfx(local_client_num, handle);
  }

  self.var_9d939573 = undefined;
}