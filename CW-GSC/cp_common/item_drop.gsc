/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\item_drop.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#namespace item_drop;

function autoexec main() {
  if(!isDefined(level.item_drops)) {
    level.item_drops = [];
  }

  level thread function_1a93b6b0();
  waitframe(1);
  callback::on_actor_killed(&function_4814ed2e);
}

function function_92cf5632(name, model, callback) {
  if(!isDefined(level.item_drops)) {
    level.item_drops = [];
  }

  if(!isDefined(level.item_drops[name])) {
    level.item_drops[name] = spawnStruct();
  }

  level.item_drops[name].name = name;
  level.item_drops[name].model = model;
  level.item_drops[name].callback = callback;
}

function function_cd458f49(name, dropchance) {
  if(!isDefined(level.item_drops)) {
    level.item_drops = [];
  }

  if(!isDefined(level.item_drops[name])) {
    level.item_drops[name] = spawnStruct();
  }

  level.item_drops[name].name = name;
  level.item_drops[name].var_d8b51b9f = dropchance;
}

function function_2905ed47(name, spawnpoints) {
  if(!isDefined(level.item_drops)) {
    level.item_drops = [];
  }

  if(!isDefined(level.item_drops[name])) {
    level.item_drops[name] = spawnStruct();
  }

  level.item_drops[name].name = name;
  level.item_drops[name].spawnpoints = spawnpoints;
}

function function_4814ed2e(params) {
  if(level.script != "sp_proto_characters" && level.script != "challenge_bloodbath") {
    return;
  }

  if(is_true(self.var_a269c536)) {
    return;
  }

  self.var_a269c536 = 1;
  drop = array::random(level.item_drops);

  if(isDefined(drop.var_d8b51b9f)) {
    drop.var_d8b51b9f = getdvarfloat("<dev string:x38>" + drop.name, 0);
  }

  if(getdvarint(#"hash_5b7b8e527835e75b", 0)) {
    killer = self.var_493d1f73;

    if(isDefined(killer)) {
      if(isDefined(drop.callback)) {
        multiplier = self function_fbd43d2f();

        if(!killer[[drop.callback]](multiplier)) {
          return;
        }
      }

      playsoundatposition(#"hash_24560114c2498b4d", killer.origin);
    }

    return;
  }

  if(isDefined(drop.var_d8b51b9f) && randomfloat(1) < drop.var_d8b51b9f) {
    origin = self.origin + (0, 0, 30);
    newdrop = function_cdd56b7c(drop, origin);
    newdrop.multiplier = self function_fbd43d2f();
    level.var_96d850f9[level.var_96d850f9.size] = newdrop;
    newdrop thread function_31747e4e();
  }
}

function function_fbd43d2f() {
  var_17f6707c = getdvarfloat(#"hash_6e30d1a44f5c3074", 0);

  if(isDefined(self.var_527afdf8)) {
    var_17f6707c = self.var_527afdf8;
  }

  var_5c528a90 = getdvarfloat(#"hash_6e4bbfa44f72d996", 0);

  if(isDefined(self.var_308efffd)) {
    var_5c528a90 = self.var_308efffd;
  }

  if(var_17f6707c < var_5c528a90) {
    return randomfloatrange(var_17f6707c, var_5c528a90);
  }

  return var_17f6707c;
}

function function_1a93b6b0() {
  level.var_96d850f9 = [];
  level flag::wait_till("all_players_spawned");

  while(true) {
    wait 15;

    if(level.var_96d850f9.size < 1 && level.item_drops.size > 0) {
      drop = array::random(level.item_drops);

      if(isDefined(drop.spawnpoints)) {
        origin = array::random(drop.spawnpoints);
        newdrop = function_cdd56b7c(drop, origin);
        level.var_96d850f9[level.var_96d850f9.size] = newdrop;
        newdrop thread function_31747e4e();
      }
    }
  }
}

function function_cdd56b7c(drop, origin) {
  nd = spawnStruct();
  nd.drop = drop;
  nd.origin = origin;
  nd.model = spawn("script_model", nd.origin);
  nd.model setModel(drop.model);
  nd.model thread function_24035033();
  playsoundatposition(#"hash_daa5170584cefa3", origin);
  return nd;
}

function function_24035033() {
  angle = 0;
  time = 0;
  self endon(#"death");

  while(isDefined(self)) {
    angle = time * 90;
    self.angles = (0, angle, 0);
    waitframe(1);
    time += float(function_60d95f53()) / 1000;
  }
}

function function_31747e4e() {
  trigger = spawn("trigger_radius", self.origin, 0, 60, 60);
  self.pickuptrigger = trigger;

  while(isDefined(self)) {
    waitresult = trigger waittill(#"trigger");

    if(waitresult.activator thread pickup(self)) {
      break;
    }
  }

  trigger delete();
}

function pickup(drop) {
  if(isDefined(drop.drop.callback)) {
    multiplier = 1;

    if(isDefined(drop.multiplier)) {
      multiplier = drop.multiplier;
    }

    if(!self[[drop.drop.callback]](multiplier)) {
      return false;
    }
  }

  playsoundatposition(#"hash_24560114c2498b4d", self.origin);
  drop.model delete();
  arrayremovevalue(level.var_96d850f9, drop);
  return true;
}