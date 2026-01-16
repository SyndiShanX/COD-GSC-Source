/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_utility_code.csc
*******************************************/

init_session_mode_flags() {
  level.gamemode_public_match = 0;
  level.gamemode_private_match = 1;
  level.gamemode_local_splitscreen = 2;
  level.gamemode_wager_match = 3;
  level.gamemode_theater = 5;
  level.gamemode_league_match = 6;
  level.gamemode_rts = 7;
}

struct_class_init() {
  assert(!isDefined(level.struct_class_names), "level.struct_class_names is being initialized in the wrong place! It shouldn't be initialized yet.");
  level.struct_class_names = [];
  level.struct_class_names["target"] = [];
  level.struct_class_names["targetname"] = [];
  level.struct_class_names["script_noteworthy"] = [];
  level.struct_class_names["script_label"] = [];
  level.struct_class_names["classname"] = [];

  for(i = 0; i < level.struct.size; i++) {
    if(isDefined(level.struct[i].targetname)) {
      if(!isDefined(level.struct_class_names["targetname"][level.struct[i].targetname]))
        level.struct_class_names["targetname"][level.struct[i].targetname] = [];

      size = level.struct_class_names["targetname"][level.struct[i].targetname].size;
      level.struct_class_names["targetname"][level.struct[i].targetname][size] = level.struct[i];
    }

    if(isDefined(level.struct[i].target)) {
      if(!isDefined(level.struct_class_names["target"][level.struct[i].target]))
        level.struct_class_names["target"][level.struct[i].target] = [];

      size = level.struct_class_names["target"][level.struct[i].target].size;
      level.struct_class_names["target"][level.struct[i].target][size] = level.struct[i];
    }

    if(isDefined(level.struct[i].script_noteworthy)) {
      if(!isDefined(level.struct_class_names["script_noteworthy"][level.struct[i].script_noteworthy]))
        level.struct_class_names["script_noteworthy"][level.struct[i].script_noteworthy] = [];

      size = level.struct_class_names["script_noteworthy"][level.struct[i].script_noteworthy].size;
      level.struct_class_names["script_noteworthy"][level.struct[i].script_noteworthy][size] = level.struct[i];
    }

    if(isDefined(level.struct[i].script_label)) {
      if(!isDefined(level.struct_class_names["script_label"][level.struct[i].script_label]))
        level.struct_class_names["script_label"][level.struct[i].script_label] = [];

      size = level.struct_class_names["script_label"][level.struct[i].script_label].size;
      level.struct_class_names["script_label"][level.struct[i].script_label][size] = level.struct[i];
    }

    if(isDefined(level.struct[i].classname)) {
      if(!isDefined(level.struct_class_names["classname"][level.struct[i].classname]))
        level.struct_class_names["classname"][level.struct[i].classname] = [];

      size = level.struct_class_names["classname"][level.struct[i].classname].size;
      level.struct_class_names["classname"][level.struct[i].classname][size] = level.struct[i];
    }
  }
}