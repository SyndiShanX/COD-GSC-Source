/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\exploder_shared.gsc
***********************************************/

#include scripts\core_common\fx_shared;
#include scripts\core_common\sound_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\trigger_shared;

#namespace exploder;

autoexec __init__system__() {
  system::register(#"exploder", &__init__, &__main__, undefined);
}

__init__() {
  level._client_exploders = [];
  level._client_exploder_ids = [];
}

__main__() {
  level.exploders = [];
  ents = getEntArray("script_brushmodel", "classname");
  smodels = getEntArray("script_model", "classname");

  for(i = 0; i < smodels.size; i++) {
    ents[ents.size] = smodels[i];
  }

  for(i = 0; i < ents.size; i++) {
    if(isDefined(ents[i].script_prefab_exploder)) {
      ents[i].script_exploder = ents[i].script_prefab_exploder;
    }

    if(isDefined(ents[i].script_exploder)) {
      if(ents[i].script_exploder < 10000) {
        level.exploders[ents[i].script_exploder] = 1;
      }

      if(ents[i].model == "fx" && (!isDefined(ents[i].targetname) || ents[i].targetname != "exploderchunk")) {
        ents[i] hide();
        continue;
      }

      if(isDefined(ents[i].targetname) && ents[i].targetname == "exploder") {
        ents[i] hide();
        ents[i] notsolid();

        if(isDefined(ents[i].script_disconnectpaths)) {
          ents[i] connectpaths();
        }

        continue;
      }

      if(isDefined(ents[i].targetname) && ents[i].targetname == "exploderchunk") {
        ents[i] hide();
        ents[i] notsolid();

        if(isDefined(ents[i].spawnflags) && (ents[i].spawnflags&1) == 1) {
          ents[i] connectpaths();
        }
      }
    }
  }

  script_exploders = [];
  potentialexploders = getEntArray("script_brushmodel", "classname");

  for(i = 0; i < potentialexploders.size; i++) {
    if(isDefined(potentialexploders[i].script_prefab_exploder)) {
      potentialexploders[i].script_exploder = potentialexploders[i].script_prefab_exploder;
    }

    if(isDefined(potentialexploders[i].script_exploder)) {
      script_exploders[script_exploders.size] = potentialexploders[i];
    }
  }

  println("<dev string:x38>" + potentialexploders.size);
  potentialexploders = getEntArray("script_model", "classname");

  for(i = 0; i < potentialexploders.size; i++) {
    if(isDefined(potentialexploders[i].script_prefab_exploder)) {
      potentialexploders[i].script_exploder = potentialexploders[i].script_prefab_exploder;
    }

    if(isDefined(potentialexploders[i].script_exploder)) {
      script_exploders[script_exploders.size] = potentialexploders[i];
    }
  }

  println("<dev string:x69>" + potentialexploders.size);
  potentialexploders = getEntArray("item_health", "classname");

  for(i = 0; i < potentialexploders.size; i++) {
    if(isDefined(potentialexploders[i].script_prefab_exploder)) {
      potentialexploders[i].script_exploder = potentialexploders[i].script_prefab_exploder;
    }

    if(isDefined(potentialexploders[i].script_exploder)) {
      script_exploders[script_exploders.size] = potentialexploders[i];
    }
  }

  println("<dev string:x9b>" + potentialexploders.size);

  if(!isDefined(level.createfxent)) {
    level.createfxent = [];
  }

  acceptabletargetnames = [];
  acceptabletargetnames[#"exploderchunk visible"] = 1;
  acceptabletargetnames[#"exploderchunk"] = 1;
  acceptabletargetnames[#"exploder"] = 1;

  for(i = 0; i < script_exploders.size; i++) {
    exploder = script_exploders[i];
    ent = createexploder(exploder.script_fxid);
    ent.v = [];
    ent.v[#"origin"] = exploder.origin;
    ent.v[#"angles"] = exploder.angles;
    ent.v[#"delay"] = exploder.script_delay;
    ent.v[#"firefx"] = exploder.script_firefx;
    ent.v[#"firefxdelay"] = exploder.script_firefxdelay;
    ent.v[#"firefxsound"] = exploder.script_firefxsound;
    ent.v[#"firefxtimeout"] = exploder.script_firefxtimeout;
    ent.v[#"earthquake"] = exploder.script_earthquake;
    ent.v[#"damage"] = exploder.script_damage;
    ent.v[#"damage_radius"] = exploder.script_radius;
    ent.v[#"soundalias"] = exploder.script_soundalias;
    ent.v[#"repeat"] = exploder.script_repeat;
    ent.v[#"delay_min"] = exploder.script_delay_min;
    ent.v[#"delay_max"] = exploder.script_delay_max;
    ent.v[#"target"] = exploder.target;
    ent.v[#"ender"] = exploder.script_ender;
    ent.v[#"type"] = "exploder";

    if(!isDefined(exploder.script_fxid)) {
      ent.v[#"fxid"] = "No FX";
    } else {
      ent.v[#"fxid"] = exploder.script_fxid;
    }

    ent.v[#"exploder"] = exploder.script_exploder;
    assert(isDefined(exploder.script_exploder), "<dev string:xcc>" + exploder.origin + "<dev string:xe2>");

    if(!isDefined(ent.v[#"delay"])) {
      ent.v[#"delay"] = 0;
    }

    if(isDefined(exploder.target)) {
      e_target = getent(ent.v[#"target"], "targetname");

      if(!isDefined(e_target)) {
        e_target = struct::get(ent.v[#"target"], "targetname");
      }

      org = e_target.origin;
      ent.v[#"angles"] = vectortoangles(org - ent.v[#"origin"]);
    }

    if(exploder.classname == "script_brushmodel" || isDefined(exploder.model)) {
      ent.model = exploder;
      ent.model.disconnect_paths = exploder.script_disconnectpaths;
    }

    if(isDefined(exploder.targetname) && isDefined(acceptabletargetnames[exploder.targetname])) {
      ent.v[#"exploder_type"] = exploder.targetname;
      continue;
    }

    ent.v[#"exploder_type"] = "normal";
  }

  level.createfxexploders = [];

  for(i = 0; i < level.createfxent.size; i++) {
    ent = level.createfxent[i];

    if(ent.v[#"type"] != "exploder") {
      continue;
    }

    ent.v[#"exploder_id"] = getexploderid(ent);

    if(!isDefined(level.createfxexploders[ent.v[#"exploder"]])) {
      level.createfxexploders[ent.v[#"exploder"]] = [];
    }

    level.createfxexploders[ent.v[#"exploder"]][level.createfxexploders[ent.v[#"exploder"]].size] = ent;
  }

  level.radiantexploders = [];
  reportexploderids();

  foreach(trig in trigger::get_all()) {
    if(isDefined(trig.script_prefab_exploder)) {
      trig.script_exploder = trig.script_prefab_exploder;
    }

    if(isDefined(trig.script_exploder)) {
      level thread exploder_trigger(trig, trig.script_exploder);
    }

    if(isDefined(trig.script_exploder_radiant)) {
      level thread exploder_trigger(trig, trig.script_exploder_radiant);
    }

    if(isDefined(trig.script_stop_exploder)) {
      level trigger::add_function(trig, undefined, &stop_exploder, trig.script_stop_exploder);
    }

    if(isDefined(trig.script_stop_exploder_radiant)) {
      level trigger::add_function(trig, undefined, &stop_exploder, trig.script_stop_exploder_radiant);
    }
  }
}

exploder_before_load(num) {
  waittillframeend();
  waittillframeend();
  exploder(num);
}

exploder(exploder_id) {
  if(isint(exploder_id)) {
    activate_exploder(exploder_id);
    return;
  }

  activate_radiant_exploder(exploder_id);
}

exploder_stop(num) {
  stop_exploder(num);
}

exploder_sound() {
  if(isDefined(self.script_delay)) {
    wait self.script_delay;
  }

  self playSound(level.scr_sound[self.script_sound]);
}

cannon_effect() {
  if(isDefined(self.v[#"repeat"])) {
    for(i = 0; i < self.v[#"repeat"]; i++) {
      playFX(level._effect[self.v[#"fxid"]], self.v[#"origin"], self.v[#"forward"], self.v[#"up"]);
      self exploder_delay();
    }

    return;
  }

  self exploder_delay();

  if(isDefined(self.looper)) {
    self.looper delete();
  }

  self.looper = spawnfx(fx::get(self.v[#"fxid"]), self.v[#"origin"], self.v[#"forward"], self.v[#"up"]);
  triggerfx(self.looper);
  exploder_playSound();
}

fire_effect() {
  forward = self.v[#"forward"];
  up = self.v[#"up"];
  firefxsound = self.v[#"firefxsound"];
  origin = self.v[#"origin"];
  firefx = self.v[#"firefx"];
  ender = self.v[#"ender"];

  if(!isDefined(ender)) {
    ender = "createfx_effectStopper";
  }

  firefxdelay = 0.5;

  if(isDefined(self.v[#"firefxdelay"])) {
    firefxdelay = self.v[#"firefxdelay"];
  }

  self exploder_delay();

  if(isDefined(firefxsound)) {
    level thread sound::loop_fx_sound(firefxsound, origin, ender);
  }

  playFX(level._effect[firefx], self.v[#"origin"], forward, up);
}

sound_effect() {
  self effect_soundalias();
}

effect_soundalias() {
  origin = self.v[#"origin"];
  alias = self.v[#"soundalias"];
  self exploder_delay();
  sound::play_in_space(alias, origin);
}

trail_effect() {
  self exploder_delay();

  if(!isDefined(self.v[#"trailfxtag"])) {
    self.v[#"trailfxtag"] = "tag_origin";
  }

  temp_ent = undefined;

  if(self.v[#"trailfxtag"] == "tag_origin") {
    playFXOnTag(level._effect[self.v[#"trailfx"]], self.model, self.v[#"trailfxtag"]);
  } else {
    temp_ent = spawn("script_model", self.model.origin);
    temp_ent.targetname = "exploder_fx";
    temp_ent setModel(#"tag_origin");
    temp_ent linkto(self.model, self.v[#"trailfxtag"]);
    playFXOnTag(level._effect[self.v[#"trailfx"]], temp_ent, "tag_origin");
  }

  if(isDefined(self.v[#"trailfxsound"])) {
    if(!isDefined(temp_ent)) {
      self.model playLoopSound(self.v[#"trailfxsound"]);
    } else {
      temp_ent playLoopSound(self.v[#"trailfxsound"]);
    }
  }

  if(isDefined(self.v[#"ender"]) && isDefined(temp_ent)) {
    level thread trail_effect_ender(temp_ent, self.v[#"ender"]);
  }

  if(!isDefined(self.v[#"trailfxtimeout"])) {
    return;
  }

  wait self.v[#"trailfxtimeout"];

  if(isDefined(temp_ent)) {
    temp_ent delete();
  }
}

trail_effect_ender(ent, ender) {
  ent endon(#"death");
  self waittill(ender);
  ent delete();
}

exploder_delay() {
  if(!isDefined(self.v[#"delay"])) {
    self.v[#"delay"] = 0;
  }

  min_delay = self.v[#"delay"];
  max_delay = self.v[#"delay"] + 0.001;

  if(isDefined(self.v[#"delay_min"])) {
    min_delay = self.v[#"delay_min"];
  }

  if(isDefined(self.v[#"delay_max"])) {
    max_delay = self.v[#"delay_max"];
  }

  if(min_delay > 0) {
    wait randomfloatrange(min_delay, max_delay);
  }
}

exploder_playSound() {
  if(!isDefined(self.v[#"soundalias"]) || self.v[#"soundalias"] == "nil") {
    return;
  }

  sound::play_in_space(self.v[#"soundalias"], self.v[#"origin"]);
}

brush_delete() {
  num = self.v[#"exploder"];

  if(isDefined(self.v[#"delay"])) {
    wait self.v[#"delay"];
  } else {
    wait 0.05;
  }

  if(!isDefined(self.model)) {
    return;
  }

  assert(isDefined(self.model));

  if(!isDefined(self.v[#"fxid"]) || self.v[#"fxid"] == "No FX") {
    self.v[#"exploder"] = undefined;
  }

  waittillframeend();
  self.model delete();
}

brush_show() {
  if(isDefined(self.v[#"delay"])) {
    wait self.v[#"delay"];
  }

  assert(isDefined(self.model));
  self.model show();
  self.model solid();
}

brush_throw() {
  if(isDefined(self.v[#"delay"])) {
    wait self.v[#"delay"];
  }

  ent = undefined;

  if(isDefined(self.v[#"target"])) {
    ent = getent(self.v[#"target"], "targetname");
  }

  if(!isDefined(ent)) {
    self.model delete();
    return;
  }

  self.model show();
  startorg = self.v[#"origin"];
  startang = self.v[#"angles"];
  org = ent.origin;
  temp_vec = org - self.v[#"origin"];
  x = temp_vec[0];
  y = temp_vec[1];
  z = temp_vec[2];
  self.model rotatevelocity((x, y, z), 12);
  self.model movegravity((x, y, z), 12);
  self.v[#"exploder"] = undefined;
  wait 6;
  self.model delete();
}

exploder_trigger(trigger, script_value) {
  trigger endon(#"death");
  level endon("killexplodertridgers" + script_value);
  trigger trigger::wait_till();

  if(isDefined(trigger.script_chance) && randomfloat(1) > trigger.script_chance) {
    if(isDefined(trigger.script_delay)) {
      wait trigger.script_delay;
    } else {
      wait 4;
    }

    level thread exploder_trigger(trigger, script_value);
    return;
  }

  exploder(script_value);
  level notify("killexplodertridgers" + script_value);
}

reportexploderids() {
  if(!isDefined(level._exploder_ids)) {
    return;
  }

  println("<dev string:xfc>");

  foreach(k, v in level._exploder_ids) {
    println(k + "<dev string:x11c>" + v);
  }

}

getexploderid(ent) {
  if(!isDefined(level._exploder_ids)) {
    level._exploder_ids = [];
    level._exploder_id = 1;
  }

  if(!isDefined(level._exploder_ids[ent.v[#"exploder"]])) {
    level._exploder_ids[ent.v[#"exploder"]] = level._exploder_id;
    level._exploder_id++;
  }

  return level._exploder_ids[ent.v[#"exploder"]];
}

createexploder(fxid) {
  ent = fx::create_effect("exploder", fxid);
  ent.v[#"delay"] = 0;
  ent.v[#"exploder"] = 1;
  ent.v[#"exploder_type"] = "normal";
  return ent;
}

activate_exploder(num) {
  num = int(num);
  level notify("exploder" + num);
  client_send = 1;

  if(isDefined(level.createfxexploders[num])) {
    for(i = 0; i < level.createfxexploders[num].size; i++) {
      if(client_send && isDefined(level.createfxexploders[num][i].v[#"exploder_server"])) {
        client_send = 0;
      }

      level.createfxexploders[num][i] activate_individual_exploder(num);
    }
  }

  if(level.clientscripts) {
    if(client_send == 1) {
      activate_exploder_on_clients(num);
    }
  }
}

activate_radiant_exploder(string) {
  level notify("exploder" + string);

  if(isDefined(level.var_13a6af33)) {
    [[level.var_13a6af33]](string);
  }

  activateclientradiantexploder(string);
}

activate_individual_exploder(num) {
  level notify("exploder" + self.v[#"exploder"]);

  if(!level.clientscripts || !isDefined(level._exploder_ids[int(self.v[#"exploder"])]) || isDefined(self.v[#"exploder_server"])) {
    println("<dev string:x122>" + self.v[#"exploder"] + "<dev string:x12e>");

    if(isDefined(self.v[#"firefx"])) {
      self thread fire_effect();
    }

    if(isDefined(self.v[#"fxid"]) && self.v[#"fxid"] != "No FX") {
      self thread cannon_effect();
    } else if(isDefined(self.v[#"soundalias"])) {
      self thread sound_effect();
    }

    if(isDefined(self.v[#"earthquake"])) {
      self thread earthquake();
    }

    if(isDefined(self.v[#"rumble"])) {
      self thread rumble();
    }
  }

  if(isDefined(self.v[#"trailfx"])) {
    self thread trail_effect();
  }

  if(isDefined(self.v[#"damage"])) {
    self thread exploder_damage();
  }

  if(self.v[#"exploder_type"] == "exploder") {
    self thread brush_show();
    return;
  }

  if(self.v[#"exploder_type"] == "exploderchunk" || self.v[#"exploder_type"] == "exploderchunk visible") {
    self thread brush_throw();
    return;
  }

  self thread brush_delete();
}

activate_exploder_on_clients(num) {
  if(!isDefined(level._exploder_ids[num])) {
    return;
  }

  if(!isDefined(level._client_exploders[num])) {
    level._client_exploders[num] = 1;
  }

  if(!isDefined(level._client_exploder_ids[num])) {
    level._client_exploder_ids[num] = 1;
  }

  activateclientexploder(level._exploder_ids[num]);
}

stop_exploder(num) {
  if(level.clientscripts) {
    delete_exploder_on_clients(num);
  }

  if(isDefined(level.createfxexploders[num])) {
    for(i = 0; i < level.createfxexploders[num].size; i++) {
      if(!isDefined(level.createfxexploders[num][i].looper)) {
        continue;
      }

      level.createfxexploders[num][i].looper delete();
    }
  }
}

delete_exploder_on_clients(exploder_id) {
  if(isstring(exploder_id)) {
    deactivateclientradiantexploder(exploder_id);
    return;
  }

  if(!isDefined(level._exploder_ids[exploder_id])) {
    return;
  }

  if(!isDefined(level._client_exploders[exploder_id])) {
    return;
  }

  level._client_exploders[exploder_id] = undefined;
  level._client_exploder_ids[exploder_id] = undefined;
  deactivateclientexploder(level._exploder_ids[exploder_id]);
}

kill_exploder(exploder_string) {
  if(isstring(exploder_string)) {
    killclientradiantexploder(exploder_string);
    return;
  }

  assertmsg("<dev string:x144>");
}

exploder_damage() {
  if(isDefined(self.v[#"delay"])) {
    delay = self.v[#"delay"];
  } else {
    delay = 0;
  }

  if(isDefined(self.v[#"damage_radius"])) {
    radius = self.v[#"damage_radius"];
  } else {
    radius = 128;
  }

  damage = self.v[#"damage"];
  origin = self.v[#"origin"];
  wait delay;
  self.model radiusdamage(origin, radius, damage, damage / 3);
}

earthquake() {
  earthquake_name = self.v[#"earthquake"];
  assert(isDefined(level.earthquake) && isDefined(level.earthquake[earthquake_name]), "<dev string:x182>" + earthquake_name + "<dev string:x194>");
  self exploder_delay();
  eq = level.earthquake[earthquake_name];
  earthquake(eq[#"magnitude"], eq[#"duration"], self.v[#"origin"], eq[#"radius"]);
}

rumble() {
  self exploder_delay();
  a_players = getplayers();

  if(isDefined(self.v[#"damage_radius"])) {
    n_rumble_threshold_squared = self.v[#"damage_radius"] * self.v[#"damage_radius"];
  } else {
    println("<dev string:x1db>" + self.v[#"exploder"] + "<dev string:x1e8>");
    n_rumble_threshold_squared = 16384;
  }

  for(i = 0; i < a_players.size; i++) {
    n_player_dist_squared = distancesquared(a_players[i].origin, self.v[#"origin"]);

    if(n_player_dist_squared < n_rumble_threshold_squared) {
      a_players[i] playrumbleonentity(self.v[#"rumble"]);
    }
  }
}

stop_after_duration(name, duration) {
  wait duration;
  stop_exploder(name);
}

exploder_duration(name, duration) {
  if(!(isDefined(duration) && duration)) {
    return;
  }

  exploder(name);
  level thread stop_after_duration(name, duration);
}