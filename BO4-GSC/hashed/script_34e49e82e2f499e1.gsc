/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_34e49e82e2f499e1.gsc
***********************************************/

#include script_cb32d07c95e5628;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\mp_common\item_world;

#namespace namespace_21c59b5;

autoexec __init__system__() {
  system::register(#"hash_18ce058ad321248f", &__init__, undefined, undefined);
}

autoexec __init() {
  level.var_c30abd0d = (isDefined(getgametypesetting(#"hash_3778ec3bd924f17c")) ? getgametypesetting(#"hash_3778ec3bd924f17c") : 0) && (isDefined(getgametypesetting(#"hash_3a3855c443fb705a")) ? getgametypesetting(#"hash_3a3855c443fb705a") : 0);
  level.var_69167fa4 = (isDefined(getgametypesetting(#"hash_3778ec3bd924f17c")) ? getgametypesetting(#"hash_3778ec3bd924f17c") : 0) && (isDefined(getgametypesetting(#"hash_68f4f3fd681ae3ea")) ? getgametypesetting(#"hash_68f4f3fd681ae3ea") : 0);
  level.var_30c7dc14 = (isDefined(getgametypesetting(#"hash_3778ec3bd924f17c")) ? getgametypesetting(#"hash_3778ec3bd924f17c") : 0) && (isDefined(getgametypesetting(#"hash_6c72667787a1fcc9")) ? getgametypesetting(#"hash_6c72667787a1fcc9") : 0);
}

__init__() {
  level thread function_82141ae4();
  level thread function_920f9a6();
  level thread function_624de77b();
}

function_624de77b() {
  if(!level.var_30c7dc14) {
    var_3382b1fd = getdynentarray(#"hash_65a897c4ba6cd264");
    var_dee87f84 = getdynentarray(#"hash_1418b0814d35f392");
    item_world::function_1b11e73c();

    foreach(var_24f3a953 in var_3382b1fd) {
      setdynentstate(var_24f3a953, 2);
    }

    foreach(var_8f38aad5 in var_dee87f84) {
      setdynentstate(var_8f38aad5, 1);
    }

    item_world::function_4de3ca98();

    foreach(var_24f3a953 in var_3382b1fd) {
      setdynentstate(var_24f3a953, 2);
    }

    foreach(var_8f38aad5 in var_dee87f84) {
      setdynentstate(var_8f38aad5, 1);
    }

    return;
  }

  var_3382b1fd = getdynentarray(#"hash_65a897c4ba6cd264");

  foreach(var_24f3a953 in var_3382b1fd) {
    var_24f3a953.onuse = &function_a25e43f9;
  }
}

function_920f9a6() {
  if(!level.var_69167fa4) {
    pianos = getdynentarray(#"buried_piano");
    item_world::function_1b11e73c();

    foreach(piano in pianos) {
      setdynentstate(piano, 3);
    }

    item_world::function_4de3ca98();

    foreach(piano in pianos) {
      setdynentstate(piano, 3);
    }
  }
}

function_82141ae4() {
  if(!level.var_c30abd0d) {
    var_fff29b0e = getdynentarray(#"t_switch");
    item_world::function_1b11e73c();

    foreach(var_93696d49 in var_fff29b0e) {
      setdynentstate(var_93696d49, 2);
    }

    item_world::function_4de3ca98();

    foreach(var_93696d49 in var_fff29b0e) {
      setdynentstate(var_93696d49, 2);
    }

    return;
  }

  var_fff29b0e = getdynentarray(#"t_switch");

  foreach(var_93696d49 in var_fff29b0e) {
    var_93696d49.onuse = &function_62ef723;
  }
}

function_63f86aa3() {
  if(!(isDefined(self.var_66ac39f3) && self.var_66ac39f3)) {
    self.var_66ac39f3 = 1;
    setdynentstate(self, 2);
    self thread function_dabe7910();
  }
}

function_a9f512c2() {
  var_dee87f84 = getdynentarray(#"hash_1418b0814d35f392");

  foreach(var_8f38aad5 in var_dee87f84) {
    setdynentstate(var_8f38aad5, 1);
  }
}

function_dabe7910() {
  self notify("2a2995dfcd2ea5d3");
  self endon("2a2995dfcd2ea5d3");
  level endon(#"game_ended");
  self endon(#"death");
  wait 104;
  setdynentstate(self, 0);
}

private event_handler[grenade_fire] function_4776caf4(eventstruct) {
  if(level.inprematchperiod) {
    return;
  }

  if(sessionmodeiswarzonegame() && isplayer(self) && isalive(self) && isDefined(eventstruct) && isDefined(eventstruct.weapon)) {
    if(eventstruct.weapon.name === #"hatchet") {
      if(isDefined(eventstruct.projectile)) {
        hatchet = eventstruct.projectile;
        dartboard = getdynent(#"buried_dartboard");

        if(isDefined(dartboard)) {
          player_dist = distance(dartboard.origin, self.origin);

          if(player_dist > 200 && player_dist < 5000) {
            hatchet thread function_34f4460b(self);
          }
        }
      }
    }
  }
}

function_34f4460b(player) {
  if(!isDefined(player) || !isDefined(self)) {
    return;
  }

  level endon(#"game_ended");
  self endon(#"stationary", #"death");
  player endon(#"disconnect", #"death");
  var_3df14205 = getEntArray("trigger_buried_dartboard_bullseye", "targetname");

  if(!isDefined(var_3df14205)) {
    return;
  }

  var_25d0b13d = 0;
  var_e5823d2 = self getvelocity();

  if(!isDefined(var_e5823d2)) {
    return;
  }

  while(!var_25d0b13d && abs(var_e5823d2[0]) > 0 && abs(var_e5823d2[1]) > 0) {
    var_e5823d2 = self getvelocity();

    foreach(dartboard in var_3df14205) {
      if(self istouching(dartboard)) {
        if(isDefined(dartboard.target)) {
          var_e9320407 = dartboard.target;
        }

        var_25d0b13d = 1;
        break;
      }
    }

    waitframe(1);
  }

  if(var_25d0b13d) {
    if(isDefined(var_e9320407)) {
      pianos = getdynentarray(var_e9320407);

      foreach(piano in pianos) {
        piano function_63f86aa3();
      }
    }

    function_a9f512c2();
  }
}

function_55b32a83() {
  if(isDefined(self.target)) {
    spawn_pos = struct::get(self.target, "targetname");
  }

  if(isDefined(spawn_pos)) {
    items = self namespace_65181344::function_fd87c780("zombie_raygun_mk2_itemlist", 1);

    for(i = 0; i < items.size; i++) {
      item = items[i];

      if(isDefined(item)) {
        item.origin = spawn_pos.origin;
        item.angles = spawn_pos.angles;
      }

      waitframe(1);
    }
  }
}

function_a25e43f9(activator, laststate, state) {
  if(!(isDefined(level.var_30c7dc14) && level.var_30c7dc14)) {
    return;
  }

  if(isplayer(activator)) {
    self function_55b32a83();
  }
}

function_62ef723(activator, laststate, state) {
  if(!(isDefined(level.var_c30abd0d) && level.var_c30abd0d)) {
    return;
  }

  if(isDefined(self.var_7dee147e) && self.var_7dee147e) {
    return;
  }

  if(isplayer(activator)) {
    dot = vectordot(anglesToForward(activator.angles), anglesToForward(self.angles));
    distance = distance2d(activator.origin, self.origin);

    if(dot < -0.8 && distance < 24) {
      self.var_7dee147e = 1;
      activator playboast("boast_tambour_tribute");
      activator stats::function_d40764f3(#"tanbor_fudgely_interactions", 1);
      level thread function_274ee8b5(self, activator);
    }
  }
}

function_274ee8b5(dynent, var_8a50fb55) {
  level endon(#"game_ended");

  while(isDefined(var_8a50fb55) && isalive(var_8a50fb55) && !var_8a50fb55 inlaststand() && var_8a50fb55 function_15049d95()) {
    waitframe(1);
  }

  dynent.var_7dee147e = 0;
}