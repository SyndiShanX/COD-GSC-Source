/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: common_scripts\utility.gsc
**************************************/

scriptPrintln(channel, msg) {
  setprintchannel(channel);
  println(msg);
  setprintchannel("script");
}

debugPrintln(channel, msg) {
  setprintchannel("script_debug");
  println(msg);
  setprintchannel("script");
}

draw_debug_line(start, end, timer) {
  for(i = 0; i < timer * 20; i++) {
    line(start, end, (1, 1, 0.5));
    wait(0.05);
  }
}

waittillend(msg) {
  self waittillmatch(msg, "end");
}

randomvector(num) {
  return (randomfloat(num) - num * 0.5, randomfloat(num) - num * 0.5, randomfloat(num) - num * 0.5);
}

angle_dif(oldangle, newangle) {
  if(oldangle == newangle)
    return 0;

  while(newangle > 360)
    newangle -= 360;

  while(newangle < 0)
    newangle += 360;

  while(oldangle > 360)
    oldangle -= 360;

  while(oldangle < 0)
    oldangle += 360;

  olddif = undefined;
  newdif = undefined;

  if(newangle > 180)
    newdif = 360 - newangle;
  else
    newdif = newangle;

  if(oldangle > 180)
    olddif = 360 - oldangle;
  else
    olddif = oldangle;

  outerdif = newdif + olddif;
  innerdif = 0;

  if(newangle > oldangle)
    innerdif = newangle - oldangle;
  else
    innerdif = oldangle - newangle;

  if(innerdif < outerdif)
    return innerdif;
  else
    return outerdif;
}

vectorScale(vector, scale) {
  vector = (vector[0] * scale, vector[1] * scale, vector[2] * scale);
  return vector;
}

sign(x) {
  if(x >= 0)
    return 1;
  return -1;
}

track(spot_to_track) {
  if(isDefined(self.current_target)) {
    if(spot_to_track == self.current_target)
      return;
  }
  self.current_target = spot_to_track;
}

get_enemy_team(team) {
  assertEx(team != "neutral", "Team must be allies or axis");

  teams = [];
  teams["axis"] = "allies";
  teams["allies"] = "axis";

  return teams[team];
}

clear_exception(type) {
  assert(isDefined(self.exception[type]));
  self.exception[type] = anim.defaultException;
}

set_exception(type, func) {
  assert(isDefined(self.exception[type]));
  self.exception[type] = func;
}

set_all_exceptions(exceptionFunc) {
  keys = getArrayKeys(self.exception);
  for(i = 0; i < keys.size; i++) {
    self.exception[keys[i]] = exceptionFunc;
  }
}

set_flash_duration(time_in_seconds) {
  self.flashduration = time_in_seconds * 1000;
}

cointoss() {
  return randomint(100) >= 50;
}

waittill_string(msg, ent) {
  if(msg != "death")
    self endon("death");

  ent endon("die");
  self waittill(msg);
  ent notify("returned", msg);
}

waittill_multiple(string1, string2, string3, string4, string5) {
  self endon("death");
  ent = spawnStruct();
  ent.threads = 0;

  if(isDefined(string1)) {
    self thread waittill_string(string1, ent);
    ent.threads++;
  }
  if(isDefined(string2)) {
    self thread waittill_string(string2, ent);
    ent.threads++;
  }
  if(isDefined(string3)) {
    self thread waittill_string(string3, ent);
    ent.threads++;
  }
  if(isDefined(string4)) {
    self thread waittill_string(string4, ent);
    ent.threads++;
  }
  if(isDefined(string5)) {
    self thread waittill_string(string5, ent);
    ent.threads++;
  }

  while(ent.threads) {
    ent waittill("returned");
    ent.threads--;
  }

  ent notify("die");
}

waittill_multiple_ents(ent1, string1, ent2, string2, ent3, string3, ent4, string4) {
  self endon("death");
  ent = spawnStruct();
  ent.threads = 0;

  if(isDefined(ent1)) {
    assert(isDefined(string1));
    ent1 thread waittill_string(string1, ent);
    ent.threads++;
  }
  if(isDefined(ent2)) {
    assert(isDefined(string2));
    ent2 thread waittill_string(string2, ent);
    ent.threads++;
  }
  if(isDefined(ent3)) {
    assert(isDefined(string3));
    ent3 thread waittill_string(string3, ent);
    ent.threads++;
  }
  if(isDefined(ent4)) {
    assert(isDefined(string4));
    ent4 thread waittill_string(string4, ent);
    ent.threads++;
  }

  while(ent.threads) {
    ent waittill("returned");
    ent.threads--;
  }

  ent notify("die");
}

waittill_any_return(string1, string2, string3, string4, string5) {
  if((!isDefined(string1) || string1 != "death") &&
    (!isDefined(string2) || string2 != "death") &&
    (!isDefined(string3) || string3 != "death") &&
    (!isDefined(string4) || string4 != "death") &&
    (!isDefined(string5) || string5 != "death"))
    self endon("death");

  ent = spawnStruct();

  if(isDefined(string1))
    self thread waittill_string(string1, ent);

  if(isDefined(string2))
    self thread waittill_string(string2, ent);

  if(isDefined(string3))
    self thread waittill_string(string3, ent);

  if(isDefined(string4))
    self thread waittill_string(string4, ent);

  if(isDefined(string5))
    self thread waittill_string(string5, ent);

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

waittill_any(string1, string2, string3, string4, string5) {
  assert(isDefined(string1));

  if(isDefined(string2))
    self endon(string2);

  if(isDefined(string3))
    self endon(string3);

  if(isDefined(string4))
    self endon(string4);

  if(isDefined(string5))
    self endon(string5);

  self waittill(string1);
}

waittill_any_ents(ent1, string1, ent2, string2, ent3, string3, ent4, string4, ent5, string5, ent6, string6, ent7, string7) {
  assert(isDefined(ent1));
  assert(isDefined(string1));

  if((isDefined(ent2)) && (isDefined(string2)))
    ent2 endon(string2);

  if((isDefined(ent3)) && (isDefined(string3)))
    ent3 endon(string3);

  if((isDefined(ent4)) && (isDefined(string4)))
    ent4 endon(string4);

  if((isDefined(ent5)) && (isDefined(string5)))
    ent5 endon(string5);

  if((isDefined(ent6)) && (isDefined(string6)))
    ent6 endon(string6);

  if((isDefined(ent7)) && (isDefined(string7)))
    ent7 endon(string7);

  ent1 waittill(string1);
}

isFlashed() {
  if(!isDefined(self.flashEndTime))
    return false;

  return gettime() < self.flashEndTime;
}

flag(message) {
  assertEx(isDefined(message), "Tried to check flag but the flag was not defined.");
  assertEx(isDefined(level.flag[message]), "Tried to check flag " + message + " but the flag was not initialized.");
  if(!level.flag[message])
    return false;

  return true;
}

flag_init(message) {
  if(!isDefined(level.flag)) {
    level.flag = [];
    level.flags_lock = [];
    if(!isDefined(level.sp_stat_tracking_func))
      level.sp_stat_tracking_func = ::empty_init_func;
  }

  if(!isDefined(level.first_frame))
    assertEx(!isDefined(level.flag[message]), "Attempt to reinitialize existing message: " + message);

  level.flag[message] = false;

  level.flags_lock[message] = false;

  if(!isDefined(level.trigger_flags)) {
    init_trigger_flags();
    level.trigger_flags[message] = [];
  } else
  if(!isDefined(level.trigger_flags[message])) {
    level.trigger_flags[message] = [];
  }

  if(issuffix(message, "aa_")) {
    thread[[level.sp_stat_tracking_func]](message);
  }
}

empty_init_func(empty) {}

issuffix(msg, suffix) {
  if(suffix.size > msg.size)
    return false;

  for(i = 0; i < suffix.size; i++) {
    if(msg[i] != suffix[i])
      return false;
  }
  return true;
}

flag_set(message) {
  assertEx(isDefined(level.flag[message]), "Attempt to set a flag before calling flag_init: " + message);
  assert(level.flag[message] == level.flags_lock[message]);
  level.flags_lock[message] = true;

  level.flag[message] = true;
  level notify(message);

  set_trigger_flag_permissions(message);
}

flag_wait(msg) {
  while(!level.flag[msg])
    level waittill(msg);
}

flag_clear(message) {
  assertEx(isDefined(level.flag[message]), "Attempt to set a flag before calling flag_init: " + message);
  assert(level.flag[message] == level.flags_lock[message]);
  level.flags_lock[message] = false;

  if(level.flag[message]) {
    level.flag[message] = false;
    level notify(message);
    set_trigger_flag_permissions(message);
  }
}

flag_waitopen(msg) {
  while(level.flag[msg])
    level waittill(msg);
}

script_gen_dump_addline(string, signature) {
  if(!isDefined(string))
    string = "nowrite";

  if(!isDefined(level._loadstarted)) {
    if(!isDefined(level.script_gen_dump_preload))
      level.script_gen_dump_preload = [];
    struct = spawnStruct();
    struct.string = string;
    struct.signature = signature;
    level.script_gen_dump_preload[level.script_gen_dump_preload.size] = struct;
    return;
  }

  if(!isDefined(level.script_gen_dump[signature]))
    level.script_gen_dump_reasons[level.script_gen_dump_reasons.size] = "Added: " + string;
  level.script_gen_dump[signature] = string;
  level.script_gen_dump2[signature] = string;
}

array_thread(entities, process, var1, var2, var3) {
  keys = getArrayKeys(entities);

  if(isDefined(var3)) {
    for(i = 0; i < keys.size; i++)
      entities[keys[i]] thread[[process]](var1, var2, var3);

    return;
  }

  if(isDefined(var2)) {
    for(i = 0; i < keys.size; i++)
      entities[keys[i]] thread[[process]](var1, var2);

    return;
  }

  if(isDefined(var1)) {
    for(i = 0; i < keys.size; i++)
      entities[keys[i]] thread[[process]](var1);

    return;
  }

  for(i = 0; i < keys.size; i++)
    entities[keys[i]] thread[[process]]();
}

array_thread4(entities, process, var1, var2, var3, var4) {
  keys = getArrayKeys(entities);
  for(i = 0; i < keys.size; i++)
    entities[keys[i]] thread[[process]](var1, var2, var3, var4);
}

array_thread5(entities, process, var1, var2, var3, var4, var5) {
  keys = getArrayKeys(entities);
  for(i = 0; i < keys.size; i++)
    entities[keys[i]] thread[[process]](var1, var2, var3, var4, var5);
}

remove_undefined_from_array(array) {
  newarray = [];
  for(i = 0; i < array.size; i++) {
    if(!isDefined(array[i]))
      continue;
    newarray[newarray.size] = array[i];
  }
  return newarray;
}

trigger_on(name, type) {
  if(isDefined(name) && isDefined(type)) {
    ents = getEntArray(name, type);
    array_thread(ents, ::trigger_on_proc);
  } else
    self trigger_on_proc();
}

trigger_on_proc() {
  if(isDefined(self.realOrigin))
    self.origin = self.realOrigin;
  self.trigger_off = undefined;
}

trigger_off(name, type) {
  if(isDefined(name) && isDefined(type)) {
    ents = getEntArray(name, type);
    array_thread(ents, ::trigger_off_proc);
  } else
    self trigger_off_proc();
}

trigger_off_proc() {
  if(!isDefined(self.realOrigin))
    self.realOrigin = self.origin;

  if(self.origin == self.realorigin)
    self.origin += (0, 0, -10000);
  self.trigger_off = true;
}

set_trigger_flag_permissions(msg) {
  if(!isDefined(level.trigger_flags)) {
    return;
  }
  level.trigger_flags[msg] = remove_undefined_from_array(level.trigger_flags[msg]);
  array_thread(level.trigger_flags[msg], ::update_trigger_based_on_flags);
}

update_trigger_based_on_flags() {
  true_on = true;
  if(isDefined(self.script_flag_true)) {
    true_on = false;
    tokens = create_flags_and_return_tokens(self.script_flag_true);

    for(i = 0; i < tokens.size; i++) {
      if(flag(tokens[i])) {
        true_on = true;
        break;
      }
    }
  }

  false_on = true;
  if(isDefined(self.script_flag_false)) {
    tokens = create_flags_and_return_tokens(self.script_flag_false);

    for(i = 0; i < tokens.size; i++) {
      if(flag(tokens[i])) {
        false_on = false;
        break;
      }
    }
  }

  [[level.trigger_func[true_on && false_on]]]();
}

create_flags_and_return_tokens(flags) {
  tokens = strtok(flags, " ");

  for(i = 0; i < tokens.size; i++) {
    if(!isDefined(level.flag[tokens[i]])) {
      flag_init(tokens[i]);
    }
  }

  return tokens;
}

init_trigger_flags() {
  level.trigger_flags = [];
  level.trigger_func[true] = ::trigger_on;
  level.trigger_func[false] = ::trigger_off;
}

getstructarray(name, type) {
  assertEx(isDefined(level.struct_class_names), "Tried to getstruct before the structs were init");

  array = level.struct_class_names[type][name];
  if(!isDefined(array))
    return [];
  return array;
}

struct_class_init() {
  assertEx(!isDefined(level.struct_class_names), "level.struct_class_names is being initialized in the wrong place! It shouldn't be initialized yet.");

  level.struct_class_names = [];
  level.struct_class_names["target"] = [];
  level.struct_class_names["targetname"] = [];
  level.struct_class_names["script_noteworthy"] = [];
  level.struct_class_names["script_linkname"] = [];

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
    if(isDefined(level.struct[i].script_linkname)) {
      assertex(!isDefined(level.struct_class_names["script_linkname"][level.struct[i].script_linkname]), "Two structs have the same linkname");
      level.struct_class_names["script_linkname"][level.struct[i].script_linkname][0] = level.struct[i];
    }
  }
}

fileprint_start(file) {
  filename = file;
  file = openfile(filename, "write");
  level.fileprint = file;
  level.fileprintlinecount = 0;
  level.fileprint_filename = filename;
}

fileprint_map_start(file) {
  file = "map_source/" + file + ".map";
  fileprint_start(file);

  level.fileprint_mapentcount = 0;

  fileprint_map_header(true);
}

fileprint_chk(file, str) {
  level.fileprintlinecount++;
  if(level.fileprintlinecount > 400) {
    wait .05;
    level.fileprintlinecount++;
    level.fileprintlinecount = 0;
  }
  fprintln(file, str);
}

fileprint_map_header(bInclude_blank_worldspawn) {
  if(!isDefined(bInclude_blank_worldspawn))
    bInclude_blank_worldspawn = false;

  assert(isDefined(level.fileprint));

  fileprint_chk(level.fileprint, "iwmap 4");
  fileprint_chk(level.fileprint, "\"000_Global\" flagsactive");
  fileprint_chk(level.fileprint, "\"The Map\" flags");

  if(!bInclude_blank_worldspawn)
    return;
  fileprint_map_entity_start();
  fileprint_map_keypairprint("classname", "worldspawn");
  fileprint_map_entity_end();
}

fileprint_map_keypairprint(key1, key2) {
  assert(isDefined(level.fileprint));
  fileprint_chk(level.fileprint, "\"" + key1 + "\" \"" + key2 + "\"");
}

fileprint_map_entity_start() {
  assert(!isDefined(level.fileprint_entitystart));
  level.fileprint_entitystart = true;
  assert(isDefined(level.fileprint));
  fileprint_chk(level.fileprint, "// entity " + level.fileprint_mapentcount);
  fileprint_chk(level.fileprint, "{");
  level.fileprint_mapentcount++;
}

fileprint_map_entity_end() {
  assert(isDefined(level.fileprint_entitystart));
  assert(isDefined(level.fileprint));
  level.fileprint_entitystart = undefined;
  fileprint_chk(level.fileprint, "}");
}

fileprint_end() {
  assert(!isDefined(level.fileprint_entitystart));
  saved = closefile(level.fileprint);
  if(saved != 1) {
    println("-----------------------------------");
    println(" ");
    println("file write failure");
    println("file with name: " + level.fileprint_filename);
    println("make sure you checkout the file you are trying to save");
    println("note: USE P4 Search to find the file and check that one out");
    println("Do not checkin files in from the xenonoutput folder, ");
    println("this is junctioned to the proper directory where you need to go");
    println("junctions looks like this");
    println(" ");
    println("..\\xenonOutput\\scriptdata\\createfx..\\share\\raw\\maps\\createfx");
    println("..\\xenonOutput\\scriptdata\\createart ..\\share\\raw\\maps\\createart");
    println("..\\xenonOutput\\scriptdata\\vision..\\share\\raw\\vision");
    println("..\\xenonOutput\\scriptdata\\scriptgen ..\\share\\raw\\maps\\scriptgen");
    println("..\\xenonOutput\\scriptdata\\zone_source ..\\xenon\\zone_source");
    println("..\\xenonOutput\\accuracy..\\share\\raw\\accuracy");
    println("..\\xenonOutput\\scriptdata\\map_source..\\map_source\\xenon_export");
    println(" ");
    println("-----------------------------------");

    println("File not saved( see console.log for info ) ");
  }
  level.fileprint = undefined;
  level.fileprint_filename = undefined;
}

fileprint_radiant_vec(vector) {
  string = "" + vector[0] + " " + vector[1] + " " + vector[2] + "";
  return string;
}
is_mature() {
  if(level.onlineGame)
    return true;

  return GetDvarInt("cg_mature");
}

is_german_build() {
  if(getDvar("language") == "german") {
    return true;
  }
  return false;
}