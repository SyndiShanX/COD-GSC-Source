/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\player\player_role.gsc
***********************************************/

#using script_3d703ef87a841fe4;
#using scripts\core_common\player\player_loadout;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\system_shared;
#namespace player_role;

function private autoexec __init__system__() {
  system::register(#"player_role", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(!isDefined(world.playerroles)) {
    world.playerroles = [];
  }
}

function get_category_for_index(characterindex) {
  categoryname = getplayerrolecategory(characterindex, currentsessionmode());

  if(isDefined(categoryname)) {
    categoryinfo = getplayerrolecategoryinfo(categoryname);
    assert(isDefined(categoryinfo));

    if(is_true(categoryinfo.enabled)) {
      return categoryname;
    }
  }

  return "default";
}

function get_category() {
  player = self;
  assert(isPlayer(player));
  characterindex = player get();
  assert(is_valid(characterindex));
  return get_category_for_index(characterindex);
}

function function_c1f61ea2() {
  return world.playerroles[self getentitynumber()];
}

function function_965ea244(var_6c93328a = 0, var_f99420aa = 0) {
  var_ba015ed = getplayerroletemplatecount(currentsessionmode());
  var_13711f02 = [];

  for(i = 0; i < var_ba015ed; i++) {
    var_d5557bda = var_6c93328a === 1 || function_f4bf7e3f(i);
    var_e6df8df4 = var_f99420aa === 1 || function_63d13ea3(i);

    if(var_d5557bda && var_e6df8df4) {
      var_13711f02[var_13711f02.size] = i;
    }
  }

  roleindex = var_13711f02[randomint(var_13711f02.size)];
  return roleindex;
}

function function_63d13ea3(characterindex) {
  maxuniqueroles = getgametypesetting(#"maxuniquerolesperteam", characterindex);

  if(maxuniqueroles == 0) {
    return false;
  }

  rolecount = 0;

  foreach(player in level.players) {
    if(player == self) {
      continue;
    }

    playercharacterindex = player get();

    if(isDefined(player.pers[#"team"]) && player.pers[#"team"] == self.pers[#"team"] && playercharacterindex == characterindex) {
      rolecount++;

      if(rolecount >= maxuniqueroles) {
        return false;
      }
    }
  }

  return true;
}

function is_valid(index) {
  if(!isDefined(index)) {
    return false;
  }

  if(currentsessionmode() == 2) {
    return (index >= 0 && index < getplayerroletemplatecount(currentsessionmode()));
  }

  if(getdvarint(#"allowdebugcharacter", 0) == 1) {
    return (index >= 0 && index < getplayerroletemplatecount(currentsessionmode()));
  }

  return index > 0 && index < getplayerroletemplatecount(currentsessionmode());
}

function get() {
  assert(isPlayer(self));
  return self getspecialistindex();
}

function update_fields() {
  self.playerrole = self getrolefields();
}

function set(index, force) {
  player = self;
  assert(isPlayer(player));
  assert(is_valid(index));
  player.pers[#"characterindex"] = index;
  player setspecialistindex(index);

  if(isbot(self) && getdvarint(#"hash_542c037530526acb", 0) && !is_true(force)) {
    self botsetrandomcharactercustomization();
  }

  player update_fields();
  world.playerroles[self getentitynumber()] = index;

  if(getdvarint(#"hash_1f80dbba75375e3d", 0)) {
    if(currentsessionmode() == 2) {
      customloadoutindex = self stats::get_stat(#"selectedcustomclass");
    } else if(currentsessionmode() == 3 && !loadout::function_87bcb1b()) {
      customloadoutindex = 0;
    } else {
      customloadoutindex = self.pers[#"loadoutindex"];
    }

    if(isDefined(customloadoutindex)) {
      self[[level.curclass]]("custom" + customloadoutindex);
    }
  }
}

function clear() {
  player = self;
  assert(isPlayer(player));
  player setspecialistindex(0);
  player.pers[#"characterindex"] = undefined;
  player.playerrole = undefined;
}

function get_custom_loadout_index(characterindex) {
  return getcharacterclassindex(characterindex);
}

function function_97d19493(name) {
  sessionmode = currentsessionmode();
  playerroletemplatecount = getplayerroletemplatecount(sessionmode);

  for(i = 0; i < playerroletemplatecount; i++) {
    prtname = function_b14806c6(i, sessionmode);

    if(prtname == name) {
      return i;
    }
  }

  return undefined;
}

function function_2a911680() {
  if(level.var_d1455682.var_67bfde2a === 1) {
    faction = teams::function_20cfd8b5(self.pers[#"team"]);
    var_cdee2d01 = faction.superfaction;
  }

  character_index = self function_d882da68(var_cdee2d01);
  return character_index;
}