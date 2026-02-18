/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_2c9915120c137848.gsc
***********************************************/

#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ce46999727f2f2b;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_2e9202713de2b353;
#using script_350cffecd05ef6cf;
#using script_40f967ad5d18ea74;
#using script_41fbdfb1149a433e;
#using script_47851dbeea22fe66;
#using script_48e04a393ec6d855;
#using script_4d748e58ce25b60c;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_73ad7687b437e468;
#using script_74a56359b7d02ab6;
#using script_77357b2d180aa2b8;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_a6056a45;

function init() {
  level.doa.var_ecd679f7 = [];
  main();
}

function main() {
  function_e2f97f03();
  level.doa.var_ecd679f7 = [];
}

function function_e2f97f03(context = 0) {
  foreach(item in level.doa.var_ecd679f7) {
    if(!isDefined(item)) {
      continue;
    }

    if(context != 0 && item.context != context) {
      continue;
    }

    if(isDefined(item.var_28a48bb3)) {
      item thread[[item.var_28a48bb3]]();
    }
  }
}

function function_de7fb95(var_c904ca7c, context = 0) {
  var_8f43e5f8 = struct::get_array(var_c904ca7c + "_pressureplate_object", "script_noteworthy");
  var_baf628cc = getEntArray(var_c904ca7c + "_pressureplate_object", "script_noteworthy");
  var_7b8ab46d = arraycombine(var_8f43e5f8, var_baf628cc);

  foreach(target in var_7b8ab46d) {
    action = 0;
    assert(isDefined(target.script_parameters) && isDefined("<dev string:x38>"));
    toks = strtok(target.script_parameters, ";");
    assert(toks.size > 0);

    switch (toks[0]) {
      case # "elevator_brushmodel":
        action = 3;
        var_41157a40 = &function_92bae57c;
        var_4af56c19 = &function_2efb907a;
        break;
      case # "elevator":
        action = 1;
        var_41157a40 = &function_9592df27;
        var_4af56c19 = &function_2efb907a;
        break;
      case # "door":
        action = 2;
        var_41157a40 = &function_8a173823;
        var_4af56c19 = &function_1e0322f;
        break;
    }

    target.type = action;
    target.var_41157a40 = var_41157a40;
    target.var_28a48bb3 = var_4af56c19;
    target.context = context;

    if(isDefined(target.model)) {
      target.script_model = namespace_ec06fe4a::spawnmodel(target.origin, target.model, target.angles, "pressure_plate_object");
    }

    if(target.type == 2) {
      assert(toks.size > 1, "<dev string:x6d>");
      target.doortype = int(toks[1]);
      assert(target.doortype >= 1 && target.doortype <= 3, "<dev string:x99>");
      target.script_model namespace_f63bdb08::function_94c7c0d9(target.doortype, 8, context);
    } else if(target.type == 1 || target.type == 3) {
      if(isDefined(target.script_model)) {
        target.script_model setmovingplatformenabled(1);
      }

      assert(toks.size > 2, "<dev string:xae>");
      target.verticaldistance = int(toks[1]);
      target.var_edf3aca7 = int(toks[2]);

      if(toks.size > 3) {
        switch (toks[3]) {
          case # "loot":
            assert(isDefined(target.target), "<dev string:xde>");
            target.lootitems = struct::get_array(target.target, "targetname");
            assert(target.lootitems.size, "<dev string:x112>");
            break;
        }
      }

      if(toks.size > 4) {
        switch (toks[4]) {
          case # "hash_6b07679758a7acc":
            if(target.lootitems.size > 1) {
              item = target.lootitems[randomint(target.lootitems.size)];
              target.lootitems = [];

              if(!isDefined(target.lootitems)) {
                target.lootitems = [];
              } else if(!isarray(target.lootitems)) {
                target.lootitems = array(target.lootitems);
              }

              target.lootitems[target.lootitems.size] = item;
            }

            break;
        }
      }
    }

    if(isDefined(target.var_41157a40)) {
      target thread[[target.var_41157a40]]();
    }

    if(!isDefined(level.doa.var_ecd679f7)) {
      level.doa.var_ecd679f7 = [];
    } else if(!isarray(level.doa.var_ecd679f7)) {
      level.doa.var_ecd679f7 = array(level.doa.var_ecd679f7);
    }

    level.doa.var_ecd679f7[level.doa.var_ecd679f7.size] = target;
  }
}

function function_9592df27() {
  self.script_model endon(#"death");

  if(isDefined(self.lootitems)) {
    foreach(item in self.lootitems) {
      assert(isDefined(item.script_noteworthy), "<dev string:x14c>");

      switch (item.script_noteworthy) {
        case # "pickup_item":
          if(!isDefined(self.var_152b081b)) {
            self.var_152b081b = [];
          }

          assert(isDefined(item.script_parameters), "<dev string:x171>");
          def = namespace_dfc652ee::function_6265bde4(item.script_parameters);
          assert(isDefined(def), "<dev string:x199>");
          pickupitem = namespace_dfc652ee::itemspawn(def, item.origin, item.angles, undefined, 1);

          if(isDefined(pickupitem)) {
            pickupitem thread namespace_ec06fe4a::function_73d79e7d(self.script_model, 1, (0, 0, 20));
            pickupitem notify(#"hash_2a866f50cc161ca8");

            if(!isDefined(self.var_152b081b)) {
              self.var_152b081b = [];
            } else if(!isarray(self.var_152b081b)) {
              self.var_152b081b = array(self.var_152b081b);
            }

            self.var_152b081b[self.var_152b081b.size] = pickupitem;
          }

          break;
      }
    }
  }

  self.var_cb52058d = self.origin + (0, 0, self.verticaldistance);
  var_d893beb9 = abs(self.verticaldistance);

  while(true) {
    self waittill(#"plate_activated");
    self function_1efdf194(self.var_cb52058d[2], self.var_edf3aca7, var_d893beb9);
    self waittill(#"plate_deactivated");
    self function_1efdf194(self.origin[2], self.var_edf3aca7, var_d893beb9);
  }
}

function function_1efdf194(var_705bb15a, totaltime, totaldist) {
  if(var_705bb15a == self.origin[2]) {
    deltaz = abs(self.origin[2] - self.script_model.origin[2]);
    desiredpos = self.origin;
  }

  if(var_705bb15a == self.var_cb52058d[2]) {
    deltaz = abs(self.script_model.origin[2] - self.var_cb52058d[2]);
    desiredpos = self.var_cb52058d;
  }

  timedelta = math::clamp(deltaz / totaldist * totaltime, 0.05, totaltime);
  self.script_model moveto(desiredpos, timedelta);
}

function function_92bae57c() {
  if(isDefined(self.lootitems)) {
    foreach(item in self.lootitems) {
      assert(isDefined(item.script_noteworthy), "<dev string:x14c>");

      switch (item.script_noteworthy) {
        case # "pickup_item":
          if(!isDefined(self.var_152b081b)) {
            self.var_152b081b = [];
          }

          assert(isDefined(item.script_parameters), "<dev string:x171>");
          def = namespace_dfc652ee::function_6265bde4(item.script_parameters);
          assert(isDefined(def), "<dev string:x199>");
          pickupitem = namespace_dfc652ee::itemspawn(def, item.origin, item.angles, undefined, 1);

          if(isDefined(pickupitem)) {
            pickupitem thread namespace_ec06fe4a::function_73d79e7d(self, 1, (0, 0, 20));
            pickupitem notify(#"hash_2a866f50cc161ca8");

            if(!isDefined(self.var_152b081b)) {
              self.var_152b081b = [];
            } else if(!isarray(self.var_152b081b)) {
              self.var_152b081b = array(self.var_152b081b);
            }

            self.var_152b081b[self.var_152b081b.size] = pickupitem;
          }

          break;
      }
    }
  }

  self.startpos = self.origin;
  self.var_cb52058d = self.origin + (0, 0, self.verticaldistance);
  var_d893beb9 = abs(self.verticaldistance);

  while(true) {
    self waittill(#"plate_activated");
    dest = self.var_cb52058d[2];
    self function_4b059395(dest, self.var_edf3aca7, var_d893beb9);
    self waittill(#"plate_deactivated");
    self function_4b059395(self.startpos[2], self.var_edf3aca7, var_d893beb9);
  }
}

function function_4b059395(var_705bb15a, totaltime, totaldist) {
  if(var_705bb15a == self.startpos[2]) {
    deltaz = abs(self.startpos[2] - self.origin[2]);
    desiredpos = self.startpos;
  }

  if(var_705bb15a == self.var_cb52058d[2]) {
    deltaz = abs(self.origin[2] - self.var_cb52058d[2]);
    desiredpos = self.var_cb52058d;
  }

  timedelta = math::clamp(deltaz / totaldist * totaltime, 0.05, totaltime);
  self moveto(desiredpos, timedelta);
}

function function_2efb907a() {
  if(isDefined(self.var_152b081b)) {
    foreach(item in self.var_152b081b) {
      if(!isDefined(item)) {
        continue;
      }

      item delete();
    }

    self.var_152b081b = undefined;
  }

  if(isDefined(self.trigger)) {
    self.trigger delete();
  }

  if(isDefined(self.script_model)) {
    self.script_model delete();
  }
}

function function_8a173823() {
  self.script_model endon(#"death");
  level.doa.var_b8ef1466[level.doa.var_b8ef1466.size] = self.script_model;

  while(true) {
    self waittill(#"plate_activated");
    self thread namespace_f63bdb08::function_49957ef3(self.script_model, 0);
    self waittill(#"plate_deactivated");
    self thread namespace_f63bdb08::function_4c065330(self.script_model);
  }
}

function function_1e0322f() {
  if(isDefined(self.trigger)) {
    self.trigger delete();
  }

  arrayremovevalue(level.doa.var_b8ef1466, self.script_model);

  if(isDefined(self.script_model)) {
    self.script_model delete();
  }
}