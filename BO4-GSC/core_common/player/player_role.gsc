/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\player\player_role.gsc
***********************************************/

#include scripts\core_common\player\player_stats;
#include scripts\core_common\system_shared;

#namespace player_role;

autoexec __init__system__() {
  system::register(#"player_role", &__init__, undefined, undefined);
}

__init__() {
  if(!isDefined(world.playerroles)) {
    world.playerroles = [];
  }
}

get_category_for_index(characterindex) {
  categoryname = getplayerrolecategory(characterindex, currentsessionmode());

  if(isDefined(categoryname)) {
    categoryinfo = getplayerrolecategoryinfo(categoryname);
    assert(isDefined(categoryinfo));

    if(isDefined(categoryinfo.enabled) && categoryinfo.enabled) {
      return categoryname;
    }
  }

  return "default";
}

get_category() {
  player = self;
  assert(isplayer(player));
  characterindex = player get();
  assert(is_valid(characterindex));
  return get_category_for_index(characterindex);
}

function_c1f61ea2() {
  return world.playerroles[self getentitynumber()];
}

is_valid(index) {
  if(!isDefined(index)) {
    return 0;
  }

  if(currentsessionmode() == 0) {
    if(isDefined(level.validcharacters)) {
      return isinarray(level.validcharacters, index);
    }

    return 0;
  } else if(currentsessionmode() == 2) {
    return (index >= 0 && index < getplayerroletemplatecount(currentsessionmode()));
  }

  if(getdvarint(#"allowdebugcharacter", 0) == 1) {
    return (index >= 0 && index < getplayerroletemplatecount(currentsessionmode()));
  }

    return index > 0 && index < getplayerroletemplatecount(currentsessionmode());
}

get() {
  assert(isplayer(self));
  return self getspecialistindex();
}

update_fields() {
  self.playerrole = self getrolefields();
}

set(index, force) {
  player = self;
  assert(isplayer(player));
  assert(is_valid(index));
  player.pers[#"characterindex"] = index;
  player setspecialistindex(index);

  if(isbot(self) && getdvarint(#"hash_542c037530526acb", 0) && !(isDefined(force) && force)) {
    self botsetrandomcharactercustomization();
  }

  player update_fields();
  world.playerroles[self getentitynumber()] = index;

  if(currentsessionmode() == 0) {
    customloadoutindex = get_custom_loadout_index(index);
  } else if(currentsessionmode() == 2) {
    customloadoutindex = self stats::get_stat(#"selectedcustomclass");
  } else if(currentsessionmode() == 3) {
    customloadoutindex = 0;
  } else {
    customloadoutindex = self.pers[#"loadoutindex"];
  }

  if(isDefined(customloadoutindex)) {
    result = self[[level.curclass]]("custom" + customloadoutindex);

    if(!isDefined(result)) {
      return 1;
    }

    return result;
  }

  return 0;
}

clear() {
  player = self;
  assert(isplayer(player));
  player setspecialistindex(0);
  player.pers[#"characterindex"] = undefined;
  player.playerrole = undefined;
}

get_custom_loadout_index(characterindex) {
  return getcharacterclassindex(characterindex);
}

function_97d19493(name) {
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