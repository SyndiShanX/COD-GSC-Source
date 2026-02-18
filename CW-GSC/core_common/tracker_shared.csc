/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\tracker_shared.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\serverfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#namespace tracker;

function init_shared() {
  registerclientfields();
  function_fa884ccf();
}

function private registerclientfields() {
  clientfield::register_clientuimodel("huditems.isExposedOnMinimap", #"hud_items", #"isexposedonminimap", 1, 1, "int", undefined, 0, 0);
  serverfield::register("sf_tracker_spotting", 1, 6, "int");
  clientfield::register("allplayers", "cf_tracker_spotting", 1, 6, "int", &player_spotted, 0, 0);
}

function function_fa884ccf() {
  callback::on_localplayer_spawned(&on_player_spawned);
  callback::function_56df655f(&function_56df655f);
  var_5951c51b = getdvarint(#"hash_451ecc8708eb258d");
  var_5951c51b = var_5951c51b < 0 ? 3 : var_5951c51b;
  level.var_56ba0785 = cos(var_5951c51b);
  var_f2e5ae7 = getdvarint(#"hash_5b0b64262b06c91d");
  level.var_f2e5ae7 = var_f2e5ae7 < 0 ? 7500 : var_f2e5ae7;
  var_398a0413 = getdvarint(#"hash_3f50d960d95b965a");
  level.var_398a0413 = var_398a0413 < 0 ? 2000 : var_398a0413;
  var_5b162bc3 = getdvarint(#"hash_7ae43b6918bd9bac");
  level.var_5b162bc3 = var_5b162bc3 < 0 ? 1000 : var_5b162bc3;
  level.var_8fda87cb = [];
}

function on_player_spawned(localclientnum) {
  if(isbot(self)) {
    return;
  }

  self function_bcc73387(localclientnum);
  wait 0.5;

  if(!isDefined(self)) {
    return;
  }

  if(self hasperk(localclientnum, #"specialty_tracker")) {
    self thread function_8c47bbe5(localclientnum);
  }
}

function function_56df655f(params) {
  if(isDefined(params.localclientnum)) {
    player = function_5c10bd79(params.localclientnum);

    if(isPlayer(player)) {
      player thread function_bcc73387(params.localclientnum, 1);
    }
  }
}

function private function_8c47bbe5(localclientnum) {
  level endon(#"game_ended");
  self endon(#"disconnect", #"shutdown");
  self notify("12cc7fe31edc7db8");
  self endon("12cc7fe31edc7db8");
  self.var_d3fe9463 = undefined;

  while(true) {
    var_4731ce01 = 0;

    if(isalive(self) && self isplayerads()) {
      entnum = function_6777167b(localclientnum);

      if(isDefined(entnum)) {
        ent = getentbynum(localclientnum, entnum);

        if(self function_b6e83a42(localclientnum, ent)) {
          var_4731ce01 = 1;

          if(entnum !== self.var_d3fe9463) {
            self serverfield::set("sf_tracker_spotting", ent getentitynumber() + 1);
            self.var_d3fe9463 = entnum;
          }
        }
      }
    }

    if(isDefined(self.var_d3fe9463) && !var_4731ce01) {
      self.var_d3fe9463 = undefined;

      if(!function_3132f113(self)) {
        self serverfield::set("sf_tracker_spotting", 0);
      }
    }

    if(!isalive(self)) {
      return;
    }

    wait 0.1;
  }
}

function function_b6e83a42(localclientnum, ent) {
  if(!isPlayer(ent)) {
    return false;
  }

  if(!isalive(ent)) {
    return false;
  }

  if(ent hasperk(localclientnum, #"specialty_immunetrackerspotting")) {
    return false;
  }

  if(!isDefined(ent.team) || self.team == ent.team) {
    return false;
  }

  return true;
}

function private spot_target(localclientnum) {
  self notify(#"spot_target");
  self endon(#"death", #"spot_target");
  level endon(#"game_ended");
  var_b117d19 = 0;
  var_cf075ce6 = 0;

  while(true) {
    time = gettime();

    if(isDefined(self.var_ee1cc1c2)) {
      arrayremovevalue(self.var_ee1cc1c2, undefined, 1);

      if(!self.var_ee1cc1c2.size) {
        self.var_ee1cc1c2 = undefined;
      } else {
        localplayer = function_5c10bd79(localclientnum);

        foreach(spotter in self.var_ee1cc1c2) {
          var_b117d19 = time;

          if(spotter.team === localplayer.team) {
            var_cf075ce6 = time;
            break;
          }
        }
      }
    }

    if(var_b117d19 + level.var_398a0413 < time) {
      return;
    }

    if(var_cf075ce6 + level.var_398a0413 >= time) {
      self function_a4f246fb(level.var_5b162bc3);
    }

    waitframe(1);
  }
}

function player_spotted(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(function_1cbf351b(binitialsnap) || fieldname == bwastimejump) {
    return;
  }

  var_f6536836 = self getentitynumber();
  level.var_8fda87cb[var_f6536836] = bwastimejump;

  if(bwastimejump) {
    var_b80b7c6b = bwastimejump - 1;
    newtarget = getentbynum(binitialsnap, var_b80b7c6b);

    if(isPlayer(newtarget)) {
      if(!isDefined(newtarget.var_ee1cc1c2)) {
        newtarget.var_ee1cc1c2 = [];
      }

      newtarget.var_ee1cc1c2[var_f6536836] = self;
      newtarget thread spot_target(binitialsnap);
    }
  }

  if(fieldname) {
    var_2aabed59 = fieldname - 1;
    oldtarget = getentbynum(binitialsnap, var_2aabed59);

    if(isPlayer(oldtarget)) {
      if(!isDefined(oldtarget.var_ee1cc1c2)) {
        oldtarget.var_ee1cc1c2 = [];
      }

      oldtarget.var_ee1cc1c2[var_f6536836] = undefined;

      if(!oldtarget.var_ee1cc1c2.size) {
        oldtarget.var_ee1cc1c2 = undefined;
      }
    }
  }
}

function function_bcc73387(localclientnum, var_540abea5 = 0) {
  if(var_540abea5) {
    waitframe(1);
  }

  players = function_a1ef346b(localclientnum);

  foreach(player in players) {
    val = player clientfield::get("cf_tracker_spotting");
    entnum = player getentitynumber();
    var_db7bdbeb = isDefined(level.var_8fda87cb[entnum]) ? level.var_8fda87cb[entnum] : 0;

    if(val != var_db7bdbeb) {
      player player_spotted(localclientnum, var_db7bdbeb, val);
      continue;
    }

    if(val) {
      player player_spotted(localclientnum, 0, val);
    }
  }
}