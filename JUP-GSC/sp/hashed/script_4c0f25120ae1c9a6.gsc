/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_4c0f25120ae1c9a6.gsc
*************************************************/

#using script_72ef6b9f0cf1f55a;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace namespace_6917e6eed10cfc44;

function private autoexec __init__system__() {
  system::register(#"hash_7a72c0b5b88f5ace", #"hash_58f5dc856591d010", &pre_main, undefined);
}

function private pre_main() {
  settings = spawnStruct();
  settings.state = "BottomCenter";
  settings.root = (0, -200, 0);
  settings.step = (0, -35, 0);
  settings.anchorhorz = 1;
  settings.var_949530d3a6b789b3 = 2;
  function_63dc22f0e4afaf41("BottomCenter", settings);
}

function function_bd850d4d3b0d537c(layer, locstring, groupname) {
  assert(isPlayer(self));
  player = self;
  groupname = default_to(groupname, "BottomCenter");

  if(!isDefined(player.var_6917e6eed10cfc44)) {
    player.var_6917e6eed10cfc44 = spawnStruct();
  }

  if(!isDefined(player.var_6917e6eed10cfc44.hint_group)) {
    player.var_6917e6eed10cfc44.hint_group = [];
  }

  if(!isDefined(player.var_6917e6eed10cfc44.hint_group[groupname])) {
    player.var_6917e6eed10cfc44.hint_group[groupname] = [];
  }

  player.var_6917e6eed10cfc44.hint_group[groupname]["prompt_group_" + groupname + "_" + layer] = locstring;
  player function_1517a14bb9c788b5(groupname);
}

function function_8aa54007d532f449(layer, groupname) {
  assert(isPlayer(self));
  player = self;
  groupname = default_to(groupname, "BottomCenter");

  if(!isDefined(player.var_6917e6eed10cfc44)) {
    return;
  }

  if(!isDefined(player.var_6917e6eed10cfc44.hint_group)) {
    return;
  }

  if(!isDefined(player.var_6917e6eed10cfc44.hint_group[groupname])) {
    return;
  }

  if(isDefined(layer)) {
    player.var_6917e6eed10cfc44.hint_group[groupname]["prompt_group_" + groupname + "_" + layer] = -1;
  } else {
    foreach(locstring in player.var_6917e6eed10cfc44.hint_group) {
      player.var_6917e6eed10cfc44.hint_group[groupname][refname] = -1;
    }
  }

  player function_1517a14bb9c788b5(groupname);
}

function function_63dc22f0e4afaf41(groupname, settings) {
  groupname = default_to(groupname, "BottomCenter");

  if(!isDefined(level.var_6917e6eed10cfc44)) {
    assertmsg("prompt_group_setup() called before enginehud_management::pre_main() for '" + groupname + "'");
    return;
  }

  if(!isDefined(level.var_6917e6eed10cfc44.var_2942d2c381b69899)) {
    level.var_6917e6eed10cfc44.var_2942d2c381b69899 = [];
  }

  level.var_6917e6eed10cfc44.var_2942d2c381b69899[groupname] = settings;
}

function private function_1517a14bb9c788b5(groupname) {
  assert(isPlayer(self));
  player = self;
  assert(isDefined(groupname));
  assert(isDefined(player.var_6917e6eed10cfc44));
  assert(isDefined(player.var_6917e6eed10cfc44.hint_group));
  assert(isDefined(player.var_6917e6eed10cfc44.hint_group[groupname]));
  assert(isDefined(level.var_6917e6eed10cfc44.var_2942d2c381b69899[groupname]));
  settings = level.var_6917e6eed10cfc44.var_2942d2c381b69899[groupname];
  var_ed4126f0b51385b9 = -1;

  foreach(refname, locstring in player.var_6917e6eed10cfc44.hint_group[groupname]) {
    isactive = player function_ada0825249682644(refname);

    if(isistring(locstring)) {
      var_ed4126f0b51385b9++;
      position = settings.root + settings.step * var_ed4126f0b51385b9;

      if(!isactive) {
        player function_90de31b2cbef19f9(refname, "scripted_widget_generic_text");
        player function_d28fa5295a04d555(refname, settings.state);
      }

      player function_b52897e8afbb0968(refname, function_8c14a8a658013e4e(locstring));
      player function_f4c37324750dc183(refname, position[0], position[1], settings.anchorhorz, settings.var_949530d3a6b789b3);
      continue;
    }

    if(isactive) {
      player function_fb3c9a259f146781(refname);
    }
  }
}