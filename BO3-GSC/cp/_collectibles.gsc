/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\_collectibles.gsc
*************************************************/

#using scripts\cp\_challenges;
#using scripts\cp\_objectives;
#using scripts\cp\_util;
#using scripts\cp\gametypes\_save;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\gameobjects_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace collectibles;

function autoexec __init__sytem__() {
  system::register("collectibles", &__init__, &__main__, undefined);
}

function __init__() {
  level.mission_name = getmissionname();
  level.map_name = getrootmapname();
  level.var_3efe1e22 = [];
}

function __main__() {
  level.collectibles = [];
  mdl_collectibles = getEntArray("collectible", "script_noteworthy");
  if(mdl_collectibles.size == 0) {
    return;
  }
  if(!function_148c7e54()) {
    foreach(mdl_collectible in mdl_collectibles) {
      collectible = function_8765a33c(mdl_collectible);
      array::add(level.collectibles, collectible, 0);
    }
    callback::on_spawned(&on_player_spawned);
    callback::on_connect(&on_player_connect);
  } else {
    foreach(mdl_collectible in mdl_collectibles) {
      mdl_collectible hide();
    }
  }
}

function function_37aecd21() {
  if(!isDefined(level.collectibles)) {
    return;
  }
  foreach(collectible in level.collectibles) {
    var_3efe1e22 = level.var_3efe1e22[collectible.mdl_collectible.model];
    if(isDefined(var_3efe1e22)) {
      collectible.trigger.origin = collectible.trigger.origin + var_3efe1e22.offset;
    }
  }
}

function function_93523442(var_977e0f67, radius = 60, offset = (0, 0, 0)) {
  if(!isDefined(level.var_3efe1e22[var_977e0f67])) {
    level.var_3efe1e22[var_977e0f67] = spawnStruct();
  }
  level.var_3efe1e22[var_977e0f67].radius = radius;
  level.var_3efe1e22[var_977e0f67].offset = offset;
}

function private function_148c7e54() {
  return isDefined(level.var_bca96223) && level.var_bca96223 || sessionmodeiscampaignzombiesgame();
}

function on_player_spawned() {
  if(!isDefined(self.var_b3dc8451)) {
    self.var_b3dc8451 = [];
  }
  foreach(collectible in level.collectibles) {
    if(self getdstat("PlayerStatsByMap", level.map_name, "collectibles", collectible.index)) {
      self.var_b3dc8451[collectible.mdl_collectible.model] = 1;
      collectible.mdl_collectible setinvisibletoplayer(self);
      objective_setinvisibletoplayer(collectible.objectiveid, self);
      collectible.trigger setinvisibletoplayer(self);
      continue;
    }
    self.var_b3dc8451[collectible.mdl_collectible.model] = 0;
  }
  self function_3955ccef();
}

function on_player_connect() {
  self thread function_332e2cfd();
}

function function_6ba0709f() {
  self endon("disconnect");
  if(!missionhascollectibles(getrootmapname())) {
    return;
  }
  while(true) {
    level util::waittill_any("checkpoint_save", "_checkpoint_save_safe");
    self function_d100c544();
  }
}

function function_332e2cfd() {
  self endon("disconnect");
  if(!missionhascollectibles(getrootmapname())) {
    return;
  }
  while(true) {
    level waittill("save_restore");
    if(!isDefined(self.var_b3dc8451)) {
      self.var_b3dc8451 = [];
    }
    foreach(collectible in level.collectibles) {
      var_6b074374 = self function_70b41d41(collectible.index);
      has_collectible = self getdstat("PlayerStatsByMap", level.map_name, "collectibles", collectible.index);
      if(isDefined(var_6b074374) && var_6b074374 && (!(isDefined(has_collectible) && has_collectible))) {
        self.var_b3dc8451[collectible.mdl_collectible.model] = 1;
        collectible.mdl_collectible setinvisibletoplayer(self);
        objective_setinvisibletoplayer(collectible.objectiveid, self);
        collectible.trigger setinvisibletoplayer(self);
        self setdstat("PlayerStatsByMap", level.map_name, "collectibles", collectible.index, 1);
        self addrankxpvalue("picked_up_collectible", 500);
        uploadstats(self);
        self function_a8d8b9c7();
        self challenges::function_96ed590f("career_collectibles");
        continue;
      }
      if(!(isDefined(self getdstat("PlayerStatsByMap", level.map_name, "collectibles", collectible.index)) && self getdstat("PlayerStatsByMap", level.map_name, "collectibles", collectible.index))) {
        self.var_b3dc8451[collectible.mdl_collectible.model] = 0;
      }
    }
    self function_a8d8b9c7();
  }
}

function private function_b963f25(mdl_collectible) {
  mdl_collectible.radius = 60;
  mdl_collectible.offset = vectorscale((0, 0, 1), 5);
  var_3efe1e22 = level.var_3efe1e22[mdl_collectible.model];
  if(isDefined(var_3efe1e22)) {
    mdl_collectible.radius = var_3efe1e22.radius;
    mdl_collectible.offset = mdl_collectible.offset + var_3efe1e22.offset;
  }
  return mdl_collectible;
}

function function_8765a33c(mdl_collectible) {
  mdl_collectible = function_b963f25(mdl_collectible);
  trigger_use = spawn("trigger_radius_use", mdl_collectible.origin + mdl_collectible.offset, 0, mdl_collectible.radius, mdl_collectible.radius);
  trigger_use triggerignoreteam();
  trigger_use setvisibletoall();
  trigger_use usetriggerrequirelookat();
  trigger_use setteamfortrigger("none");
  trigger_use setcursorhint("HINT_INTERACTIVE_PROMPT");
  trigger_use sethintstring(&"COLLECTIBLE_PICK_UP");
  istring = istring(mdl_collectible.model);
  var_837a6185 = gameobjects::create_use_object("any", trigger_use, array(mdl_collectible), (0, 0, 0), istring);
  var_837a6185 gameobjects::allow_use("any");
  var_837a6185 gameobjects::set_use_time(0.35);
  var_837a6185 gameobjects::set_owner_team("allies");
  var_837a6185 gameobjects::set_visible_team("any");
  var_837a6185.mdl_collectible = mdl_collectible;
  var_837a6185.onuse = &onuse;
  var_837a6185.onbeginuse = &onbeginuse;
  var_837a6185.single_use = 1;
  var_837a6185.origin = mdl_collectible.origin;
  var_837a6185.angles = var_837a6185.angles;
  if(isDefined(mdl_collectible.script_int)) {
    var_837a6185.index = mdl_collectible.script_int - 1;
  } else {
    var_837a6185.index = (int(getsubstr(mdl_collectible.model, mdl_collectible.model.size - 2))) - 1;
  }
  return var_837a6185;
}

function onuse(e_player) {
  e_player.var_b3dc8451[self.mdl_collectible.model] = 1;
  self.mdl_collectible setinvisibletoplayer(e_player);
  self gameobjects::hide_waypoint(e_player);
  self.trigger setinvisibletoplayer(e_player);
  if(missionhascollectibles(getrootmapname())) {
    e_player setdstat("PlayerStatsByMap", level.map_name, "collectibles", self.index, 1);
    e_player addrankxpvalue("picked_up_collectible", 500);
    uploadstats(e_player);
    e_player function_8acd43fd(self.index, 1);
    e_player function_a8d8b9c7();
  }
  util::show_event_message(e_player, istring("COLLECTIBLE_DISCOVERED"));
  e_player playsoundtoplayer("uin_collectible_pickup", e_player);
  e_player notify("hash_eb5cc7bc");
  e_player challenges::function_96ed590f("career_collectibles");
}

function onbeginuse(e_player) {}

function function_ccb1e08d(map_name = getrootmapname()) {
  if(!isDefined(map_name)) {
    return;
  }
  var_8a9d11b = 0;
  for(var_a34073af = 0; var_a34073af < 10; var_a34073af++) {
    if(self getdstat("PlayerStatsByMap", map_name, "collectibles", var_a34073af)) {
      var_8a9d11b++;
    }
  }
  return var_8a9d11b;
}

function function_3955ccef() {
  var_8a9d11b = self function_ccb1e08d(getrootmapname());
  var_b95ead22 = getnumberofcollectiblesforlevel(getrootmapname());
  if(var_8a9d11b == var_b95ead22) {
    return true;
  }
  return false;
}

function private function_e1aad2b1() {
  self endon("disconnect");
  self notify("hash_e1aad2b1");
  self endon("hash_e1aad2b1");
  self util::waittill_notify_or_timeout("stats_changed", 2);
  if(isDefined(self) && self hascollectedallcollectibles()) {
    self setdstat("PlayerStatsList", "ALL_COLLECTIBLES_COLLECTED", "statValue", 1);
    self givedecoration("cp_medal_all_collectibles");
    self notify("give_achievement", "CP_ALL_COLLECTIBLES");
  }
}

function function_a8d8b9c7() {
  assert(isPlayer(self));
  if(self function_3955ccef()) {
    self setdstat("PlayerStatsByMap", getrootmapname(), "allCollectiblesCollected", 1);
    self notify("give_achievement", "CP_MISSION_COLLECTIBLES");
  }
  self thread function_e1aad2b1();
}

function function_8acd43fd(var_5c0b5b64, value) {
  self setnoncheckpointdata(("collectibles" + var_5c0b5b64) + "value", value);
}

function function_70b41d41(var_5c0b5b64) {
  return self getnoncheckpointdata(("collectibles" + var_5c0b5b64) + "value");
}

function function_d100c544() {
  foreach(collectible in level.collectibles) {
    self clearnoncheckpointdata(("collectibles" + collectible.index) + "value");
  }
}