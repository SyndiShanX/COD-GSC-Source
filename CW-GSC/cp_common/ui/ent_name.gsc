/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\ui\ent_name.gsc
***********************************************/

#using script_35ae72be7b4fec10;
#using scripts\core_common\util_shared;
#using scripts\cp_common\gametypes\globallogic_ui;
#namespace entname;

function add(name, team = 1) {
  if(!isDefined(level.var_479cdca1)) {
    level.var_479cdca1 = [];
  }

  var_b40f1dcd = level.var_479cdca1.size == 0;

  if(ishash(team)) {
    if(team == # "axis" || team == # "enemy") {
      team = 2;
    } else {
      team = 1;
    }
  }

  level.var_479cdca1[self getentitynumber()] = {
    #name: name, #team: team
  };

  if(var_b40f1dcd) {
    thread _think();
  }

  self thread function_ef33f38e();
}

function remove() {
  if(isDefined(level.var_479cdca1[self getentitynumber()])) {
    level.var_479cdca1[self getentitynumber()] = undefined;
    self notify(#"hash_3e2d8e6c2f824c2e");

    if(level.var_479cdca1.size == 0) {
      level.var_479cdca1 = undefined;
    }
  }
}

function remove_all() {
  level.var_479cdca1 = undefined;
  level notify(#"hash_5c4bc066a7176a66");
}

function private function_ef33f38e() {
  level endon(#"hash_5c4bc066a7176a66");
  self endon(#"hash_3e2d8e6c2f824c2e");
  self waittill(#"death");
  self thread remove();
}

function private _cleanup(eventstruct) {
  level.var_435c3a22 = undefined;
  function_7a4ff65b("cg_maxActorNameDist", &function_e65ba67);
}

function private _think() {
  level endoncallback(&_cleanup, #"level_restarting");

  for(player = getplayers()[0]; !isDefined(player); player = getplayers()[0]) {
    waitframe(1);
  }

  player endoncallback(&_cleanup, #"death");
  level.var_435c3a22 = [];
  util::init_dvar("cg_maxActorNameDist", 500, &function_e65ba67);
  namespace_61e6d095::create(#"entname", #"hash_1624d8814bab0c71");
  name = # "";
  team = 0;
  namespace_61e6d095::set_text(#"entname", name);
  namespace_61e6d095::set_state(#"entname", team);

  while(isDefined(level.var_479cdca1)) {
    new_name = # "";
    new_team = 0;

    if(isDefined(player.lookatent) && distancesquared(player.origin, player.lookatent.origin) <= level.var_435c3a22[# "cg_maxActorNameDist"]) {
      ent_num = player.lookatent getentitynumber();
      ent_name = level.var_479cdca1[ent_num];

      if(isDefined(ent_name)) {
        new_name = ent_name.name;
        new_team = ent_name.team;
      }
    }

    if(name != new_name) {
      name = new_name;
      team = new_team;
      namespace_61e6d095::set_text(#"entname", name);
      namespace_61e6d095::set_state(#"entname", team);
    }

    waitframe(1);
  }

  namespace_61e6d095::remove(#"entname");
  _cleanup();
}

function private function_e65ba67(dvar) {
  if(dvar.name == # "cg_maxActorNameDist") {
    dvar.value *= dvar.value;
  }

  level.var_435c3a22[dvar.name] = dvar.value;
}