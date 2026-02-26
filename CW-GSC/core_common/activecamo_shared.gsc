/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\activecamo_shared.gsc
***********************************************/

#using scripts\core_common\activecamo_shared_util;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\weapons_shared;
#namespace activecamo;

function private autoexec __init__system__() {
  system::register(#"activecamo", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  callback::on_loadout(&on_player_loadout);
  callback::on_weapon_change(&on_weapon_change);

  thread function_265047c1();
}

function on_weapon_change(params) {
  if(is_true(level.var_b219667f)) {
    self function_8d3b94ea(params.weapon, 1);
  } else {
    self function_8d3b94ea(params.weapon, 0);
  }

  if(isDefined(level.var_3993dc8e)) {
    self[[level.var_3993dc8e]](params.weapon);
  }
}

function on_player_death(params) {
  if(game.state != # "playing") {
    return;
  }

  self function_27779784();
}

function function_27779784() {
  if(!isDefined(self) || !isDefined(self.pers) || !isDefined(self.pers[#"activecamo"])) {
    return;
  }

  foreach(activecamo in self.pers[#"activecamo"]) {
    foreach(var_dd54a13b in activecamo.var_dd54a13b) {
      activecamo.weapon = var_dd54a13b.weapon;
      activecamo.baseweapon = function_c14cb514(activecamo.weapon);
      self init_stages(activecamo, 0, 1);
    }
  }
}

function on_player_loadout() {
  self callback::remove_on_death(&on_player_death);
  weapons = self getweaponslist();

  foreach(weapon in weapons) {
    self function_8d3b94ea(weapon, 1);
  }
}

function function_8d3b94ea(weapon, owned, b_has_weapon) {
  weapon = function_94c2605(weapon);
  var_f4eb4a50 = self function_155299d(weapon, b_has_weapon);

  if(isDefined(var_f4eb4a50)) {
    self init_activecamo(weapon, var_f4eb4a50, owned);
  }
}

function init_activecamo(weapon, var_f4eb4a50, owned) {
  if(isDefined(var_f4eb4a50.name)) {
    if(!isDefined(self.pers[#"activecamo"])) {
      self.pers[#"activecamo"] = [];
    }

    if(!isDefined(self.pers[#"activecamo"][var_f4eb4a50.name])) {
      self.pers[#"activecamo"][var_f4eb4a50.name] = {};
    }

    activecamo = self.pers[#"activecamo"][var_f4eb4a50.name];
    activecamo.var_13949c61 = function_8a6ced15(var_f4eb4a50);
    assert(isDefined(activecamo.var_13949c61));
    activecamo.weapon = weapon;
    activecamo.baseweapon = function_c14cb514(activecamo.weapon);

    if(!isDefined(activecamo.var_dd54a13b)) {
      activecamo.var_dd54a13b = [];
    }

    if(!isDefined(activecamo.var_dd54a13b[activecamo.baseweapon])) {
      activecamo.var_dd54a13b[activecamo.baseweapon] = {};
    }

    activecamo.var_dd54a13b[activecamo.baseweapon].weapon = weapon;
    activecamo.var_dd54a13b[activecamo.baseweapon].stagenum = undefined;

    if(!isDefined(activecamo.var_dd54a13b[activecamo.baseweapon].owned)) {
      activecamo.var_dd54a13b[activecamo.baseweapon].owned = 0;
    }

    activecamo.var_dd54a13b[activecamo.baseweapon].owned |= owned;
    self init_stages(activecamo, 0, 0);
    self callback::on_death(&on_player_death);
  }
}

function function_8a6ced15(var_f4eb4a50) {
  var_13949c61 = undefined;

  if(isDefined(var_f4eb4a50.name)) {
    if(!isDefined(level.activecamoinfo)) {
      level.activecamoinfo = [];
    }

    if(!isDefined(level.activecamoinfo[var_f4eb4a50.name])) {
      level.activecamoinfo[var_f4eb4a50.name] = {};
    }

    var_13949c61 = level.activecamoinfo[var_f4eb4a50.name];
    var_13949c61.name = var_f4eb4a50.name;
    var_13949c61.isasync = var_f4eb4a50.isasync;
    var_13949c61.istiered = var_f4eb4a50.istiered;
    var_13949c61.var_ed6f91d5 = var_f4eb4a50.var_ed6f91d5;
    var_13949c61.var_bd863267 = var_f4eb4a50.var_bd863267;
    var_13949c61.istimer = var_f4eb4a50.istimer;
    var_13949c61.var_fa0465c6 = var_f4eb4a50.var_fa0465c6;
    var_13949c61.var_2034fabe = var_f4eb4a50.var_2034fabe;
    var_13949c61.var_9ae5a2b8 = var_f4eb4a50.var_9ae5a2b8;
    var_13949c61.var_5f38b34e = var_f4eb4a50.var_5f38b34e;
    var_d3daabe = 0;

    if(isDefined(var_f4eb4a50.stages)) {
      if(!isDefined(var_13949c61.stages)) {
        var_13949c61.stages = [];
      }

      var_13949c61.statscache = [];

      foreach(key, var_3594168e in var_f4eb4a50.stages) {
        if(is_true(var_3594168e.disabled)) {
          var_d3daabe++;
          continue;
        }

        if(!isDefined(var_13949c61.stages[key - var_d3daabe])) {
          var_13949c61.stages[key - var_d3daabe] = {};
        }

        stage = var_13949c61.stages[key - var_d3daabe];

        if(isDefined(var_3594168e.camooption)) {
          stage.var_19b6044e = function_8b51d9d1(var_3594168e.camooption);
        }

        if(!isDefined(stage.var_19b6044e)) {
          self debug_error("<dev string:x38>" + var_13949c61.name + "<dev string:x3e>" + function_9e72a96(isDefined(var_3594168e.camooption) ? var_3594168e.camooption : "<dev string:x5b>") + "<dev string:x66>" + key);
        } else {
          activecamoname = getactivecamo(stage.var_19b6044e);
          var_7216636e = undefined;

          if(isDefined(activecamoname) && activecamoname != # "") {
            var_7216636e = getscriptbundle(activecamoname);
          }

          if(!isDefined(var_7216636e)) {
            self debug_error("<dev string:x38>" + var_13949c61.name + "<dev string:x78>" + stage.var_19b6044e + "<dev string:x66>" + key);
          } else if(!isDefined(var_7216636e.name) || var_7216636e.name != var_13949c61.name) {
            self debug_error("<dev string:x38>" + var_13949c61.name + "<dev string:xa3>" + stage.var_19b6044e + "<dev string:xb7>" + (isDefined(var_7216636e.name) ? var_7216636e.name : "<dev string:x5b>") + "<dev string:x66>" + key);
          }

          activecamoname = undefined;
          var_7216636e = undefined;
        }

        stage.permanent = var_3594168e.permanent;
        stage.statname = var_3594168e.statname;
        stage.permanentstatname = var_3594168e.permanentstatname;
        stage.var_e2dbd42d = function_54f0afd2(var_3594168e);
        stage.resettimer = isDefined(var_3594168e.resettimer) ? var_3594168e.resettimer : 0;
        stage.resetnotify = var_3594168e.resetnotify;
        stage.resetondeath = var_3594168e.resetondeath;
        stage.var_825ae630 = var_3594168e.var_c43b3dd3;
        stage.var_c33fcb85 = isDefined(var_3594168e.var_c33fcb85) ? var_3594168e.var_c33fcb85 : 0;

        if(isDefined(stage.statname)) {
          if(!isDefined(var_13949c61.statscache[stage.statname])) {
            var_13949c61.statscache[stage.statname] = 1;
          }
        }

        if(isDefined(stage.permanentstatname)) {
          if(!isDefined(var_13949c61.statscache[stage.permanentstatname])) {
            var_13949c61.statscache[stage.permanentstatname] = 1;
          }
        }

        var_1936b16e = getdvarint(#"hash_45e0785aaf2e24af", 0);

        if(var_1936b16e) {
          stage.var_e2dbd42d = var_1936b16e;
        }
      }
    }
  }

  return var_13949c61;
}

function function_37a45562(camoindex, activecamo) {
  foreach(stagenum, stage in activecamo.var_13949c61.stages) {
    if(isDefined(stage) && isDefined(stage.var_19b6044e) && stage.var_19b6044e == camoindex) {
      return stagenum;
    }
  }

  return undefined;
}

function init_stages(activecamo, var_3a8a1e00, isdeath) {
  if(isDefined(activecamo.var_13949c61.stages) && isDefined(activecamo.weapon) && isweapon(activecamo.weapon) && activecamo.weapon.isvalid) {
    weaponoptions = self function_ade49959(activecamo.weapon);
    weaponstage = getactivecamostage(weaponoptions);
    camoindex = getcamoindex(weaponoptions);
    camoindexstage = function_37a45562(camoindex, activecamo);
    var_480d86a = 0;
    var_7491ec51 = 0;

    if(isDefined(activecamo.var_13949c61.var_5f38b34e)) {
      var_480d86a = 1;
      weaponstage = getdvarint(activecamo.var_13949c61.var_5f38b34e, 0);
    } else {
      var_7491ec51 = activecamo.var_dd54a13b[activecamo.baseweapon].owned !== 1;

      if(!var_7491ec51) {
        var_7491ec51 = isDefined(camoindexstage);

        if(var_7491ec51) {
          weaponstage = camoindexstage;
        }
      }
    }

    if(!isDefined(activecamo.stages)) {
      activecamo.stages = [];
    }

    foreach(stagenum, var_62b564ee in activecamo.var_13949c61.stages) {
      if(!isDefined(activecamo.stages[stagenum])) {
        activecamo.stages[stagenum] = {};
      }

      stage = activecamo.stages[stagenum];
      stage.var_62b564ee = var_62b564ee;
      assert(isDefined(stage.var_62b564ee));

      if(!isDefined(stage.var_dd54a13b)) {
        stage.var_dd54a13b = [];
      }

      if(!isDefined(stage.var_dd54a13b[activecamo.baseweapon])) {
        stage.var_dd54a13b[activecamo.baseweapon] = {};
      }

      if(!isDefined(stage.var_dd54a13b[activecamo.baseweapon].statvalue)) {
        stage.var_dd54a13b[activecamo.baseweapon].statvalue = 0;
      }

      reset = 0;

      if(var_3a8a1e00) {
        stage.var_dd54a13b[activecamo.baseweapon].statvalue = 0;
        reset = 1;
      } else if(isdeath) {
        if(is_true(stage.var_62b564ee.var_825ae630) && is_true(stage.var_dd54a13b[activecamo.baseweapon].cleared)) {
          stage.var_dd54a13b[activecamo.baseweapon].statvalue = stage.var_62b564ee.var_e2dbd42d;
        } else if(is_true(stage.var_62b564ee.resetondeath) || stage.var_62b564ee.resettimer > 0) {
          stage.var_dd54a13b[activecamo.baseweapon].statvalue = 0;
          reset = 1;
        }
      }

      if(isDefined(stage.var_62b564ee.permanentstatname)) {
        camo_stat = self stats::get_stat_global(stage.var_62b564ee.permanentstatname);

        if(isDefined(camo_stat) && camo_stat < stage.var_62b564ee.var_e2dbd42d) {
          var_7dfd59c3 = isDefined(stats::function_af5584ca(stage.var_62b564ee.permanentstatname)) ? stats::function_af5584ca(stage.var_62b564ee.permanentstatname) : 0;

          if(var_7dfd59c3 > 0) {
            camo_stat = stage.var_62b564ee.var_e2dbd42d;
            self stats::set_stat_global(stage.var_62b564ee.permanentstatname, camo_stat);
            self stats::set_stat_challenge(stage.var_62b564ee.permanentstatname, camo_stat);
          }
        }

        if(isDefined(camo_stat)) {
          stage.var_dd54a13b[activecamo.baseweapon].statvalue = camo_stat;
        }
      } else if(is_true(stage.var_62b564ee.permanent) && isDefined(stage.var_62b564ee.statname)) {
        camo_stat = self stats::get_stat_global(stage.var_62b564ee.statname);

        if(isDefined(camo_stat)) {
          stage.var_dd54a13b[activecamo.baseweapon].statvalue = camo_stat;
        }
      }

      if(!reset && is_true(stage.var_dd54a13b[activecamo.baseweapon].cleared)) {
        if(is_true(activecamo.var_13949c61.istiered)) {
          if(weaponstage > stagenum) {
            stage.var_dd54a13b[activecamo.baseweapon].statvalue = stage.var_62b564ee.var_e2dbd42d;
          }
        }

        if(is_true(activecamo.var_13949c61.var_2034fabe)) {
          if(isDefined(stage.var_62b564ee.permanentstatname)) {
            if(weaponstage > stagenum) {
              stage.var_dd54a13b[activecamo.baseweapon].statvalue = stage.var_62b564ee.var_e2dbd42d;
            }
          } else if(is_true(stage.var_62b564ee.permanent) && isDefined(stage.var_62b564ee.statname)) {
            if(weaponstage > stagenum) {
              stage.var_dd54a13b[activecamo.baseweapon].statvalue = stage.var_62b564ee.var_e2dbd42d;
            }
          } else if(weaponstage == stagenum) {
            stage.var_dd54a13b[activecamo.baseweapon].statvalue = stage.var_62b564ee.var_e2dbd42d;
          }
        }
      }

      stage.var_dd54a13b[activecamo.baseweapon].cleared = undefined;

      if(var_480d86a) {
        stage.var_dd54a13b[activecamo.baseweapon].statvalue = 0;

        if(weaponstage > stagenum) {
          stage.var_dd54a13b[activecamo.baseweapon].statvalue = stage.var_62b564ee.var_e2dbd42d;
        }
      } else if(var_7491ec51) {
        if(is_true(activecamo.var_13949c61.istiered)) {
          if(weaponstage > stagenum) {
            if(isDefined(stage.var_62b564ee.permanentstatname)) {
              stage.var_dd54a13b[activecamo.baseweapon].statvalue = stage.var_62b564ee.var_e2dbd42d;
            } else if(is_true(stage.var_62b564ee.permanent) && isDefined(stage.var_62b564ee.statname)) {
              stage.var_dd54a13b[activecamo.baseweapon].statvalue = stage.var_62b564ee.var_e2dbd42d;
            }
          }
        }

        if(is_true(activecamo.var_13949c61.var_2034fabe)) {
          if(isDefined(stage.var_62b564ee.permanentstatname)) {
            if(weaponstage > stagenum) {
              stage.var_dd54a13b[activecamo.baseweapon].statvalue = stage.var_62b564ee.var_e2dbd42d;
            }
          } else if(is_true(stage.var_62b564ee.permanent) && isDefined(stage.var_62b564ee.statname)) {
            if(weaponstage > stagenum) {
              stage.var_dd54a13b[activecamo.baseweapon].statvalue = stage.var_62b564ee.var_e2dbd42d;
            }
          } else if(weaponstage == stagenum) {
            stage.var_dd54a13b[activecamo.baseweapon].statvalue = stage.var_62b564ee.var_e2dbd42d;
          }
        }
      }

      if(is_true(activecamo.var_13949c61.isasync)) {
        self thread function_f0d83504(activecamo, stage, stagenum);
      }
    }

    self function_e44edbd1(activecamo);
  }
}

function function_896ac347(oweapon, statname, value) {
  if(!isPlayer(self)) {
    return;
  }

  if(!isDefined(self.pers) || !isDefined(self.pers[#"activecamo"])) {
    return;
  }

  if(!isDefined(oweapon)) {
    assertmsg("<dev string:xd2>");
    return;
  }

  weapon = function_94c2605(oweapon);

  if(!isDefined(weapon)) {
    assertmsg("<dev string:x107>" + function_9e72a96(oweapon.name));
    return;
  }

  activecamoname = self function_b004e227(weapon);

  if(isDefined(activecamoname)) {
    activecamo = self.pers[#"activecamo"][activecamoname];

    if(isDefined(activecamo)) {
      if(isDefined(activecamo.var_13949c61.var_5f38b34e)) {
        return;
      }

      if(!isDefined(activecamo.var_13949c61.statscache[statname])) {
        return;
      }

      activecamo.weapon = weapon;
      activecamo.baseweapon = function_c14cb514(activecamo.weapon);

      if(!isDefined(activecamo.baseweapon)) {
        assertmsg("<dev string:x14d>" + function_9e72a96(activecamo.weapon.name));
        return;
      }

      if(!isDefined(activecamo.var_dd54a13b[activecamo.baseweapon])) {
        assertmsg("<dev string:x19c>" + function_9e72a96(activecamo.baseweapon.name) + "<dev string:x1cd>");
        return;
      }

      if(isDefined(activecamo.stages)) {
        var_7a414d4a = 0;

        foreach(stage in activecamo.stages) {
          if(is_true(stage.var_dd54a13b[activecamo.baseweapon].cleared)) {
            continue;
          }

          lastvalue = stage.var_dd54a13b[activecamo.baseweapon].statvalue;

          if(isDefined(stage.var_62b564ee.permanentstatname) && activecamo.var_dd54a13b[activecamo.baseweapon].owned === 1) {
            if(stage.var_62b564ee.statname == statname) {
              if(self stats::function_dad108fa(stage.var_62b564ee.permanentstatname, value)) {
                stage.var_dd54a13b[activecamo.baseweapon].statvalue = self stats::get_stat_global(stage.var_62b564ee.permanentstatname);
              }
            }
          } else if(isDefined(stage.var_62b564ee.statname)) {
            if(is_true(activecamo.var_13949c61.var_2034fabe)) {
              if(!is_true(activecamo.var_dd54a13b[activecamo.baseweapon].var_8fc208a8)) {
                continue;
              }
            }

            if(is_true(stage.var_62b564ee.permanent) && activecamo.var_dd54a13b[activecamo.baseweapon].owned === 1) {
              if(self stats::function_dad108fa(statname, value)) {
                stage.var_dd54a13b[activecamo.baseweapon].statvalue = self stats::get_stat_global(statname);
              }
            } else if(stage.var_62b564ee.statname == statname) {
              stage.var_dd54a13b[activecamo.baseweapon].statvalue += value;
            }
          }

          var_804a253 = stage.var_dd54a13b[activecamo.baseweapon].statvalue > lastvalue;

          if(var_804a253) {
            var_7a414d4a = 1;
          }

          if(is_true(activecamo.var_13949c61.istiered)) {
            break;
          }
        }

        if(var_7a414d4a) {
          self function_b9119037(activecamo);
        }

        if(statname == # "kills") {
          self function_e2212969(activecamo, value);
        }
      }
    }
  }
}

function function_e2212969(activecamo, value) {
  if(!isDefined(activecamo.var_dd54a13b[activecamo.baseweapon].kills)) {
    activecamo.var_dd54a13b[activecamo.baseweapon].kills = 0;
  }

  newvalue = activecamo.var_dd54a13b[activecamo.baseweapon].kills + value;

  if(activecamo.var_dd54a13b[activecamo.baseweapon].kills < 5 && newvalue >= 5) {
    self function_896ac347(activecamo.weapon, "5th_kill", 1);
  }

  if(activecamo.var_dd54a13b[activecamo.baseweapon].kills < 9 && newvalue >= 9) {
    self function_896ac347(activecamo.weapon, "9th_kill", 1);
  }

  if(activecamo.var_dd54a13b[activecamo.baseweapon].kills < 100 && newvalue >= 100) {
    self function_896ac347(activecamo.weapon, "100th_kill", 1);
  }

  activecamo.var_dd54a13b[activecamo.baseweapon].kills = newvalue;
}

function function_f0d83504(activecamo, stage, stagenum) {
  self setactivecamostage(activecamo.weapon, stagenum, 1, is_true(stage.var_dd54a13b[activecamo.baseweapon].cleared));
}

function function_e44edbd1(activecamo) {
  if(is_true(activecamo.var_13949c61.istiered)) {
    var_e92afc26 = 0;

    for(stagenum = activecamo.stages.size - 1; stagenum >= 0; stagenum--) {
      stage = activecamo.stages[stagenum];

      if(stage.var_62b564ee.var_e2dbd42d > 0 && stage.var_dd54a13b[activecamo.baseweapon].statvalue >= stage.var_62b564ee.var_e2dbd42d) {
        if(var_e92afc26 < stagenum) {
          var_e92afc26 = stagenum;
        }
      }

      if(stagenum < var_e92afc26) {
        stage.var_dd54a13b[activecamo.baseweapon].statvalue = stage.var_62b564ee.var_e2dbd42d;
      }
    }

    self function_b9119037(activecamo);
    return;
  }

  if(is_true(activecamo.var_13949c61.var_2034fabe)) {
    activecamo.var_dd54a13b[activecamo.baseweapon].var_8fc208a8 = 0;
    self function_b9119037(activecamo);
  }
}

function function_b9119037(activecamo) {
  if(!isDefined(activecamo.baseweapon) || !isDefined(activecamo.var_dd54a13b[activecamo.baseweapon])) {
    return;
  }

  if(is_true(activecamo.var_13949c61.istiered)) {
    self function_5d692cf(activecamo);
    return;
  }

  if(is_true(activecamo.var_13949c61.var_2034fabe)) {
    self function_8eac065(activecamo);
  }
}

function function_5d692cf(activecamo) {
  stagenum = 0;
  var_c70461e6 = 0;

  foreach(key, stage in activecamo.stages) {
    if(!isDefined(stage.var_dd54a13b[activecamo.baseweapon])) {
      continue;
    }

    stagenum = key;

    if(stage.var_dd54a13b[activecamo.baseweapon].statvalue >= stage.var_62b564ee.var_e2dbd42d) {
      stage.var_dd54a13b[activecamo.baseweapon].cleared = 1;

      if(activecamo.var_13949c61.var_9ae5a2b8 === 1 && stagenum == activecamo.stages.size - 1) {
        var_c70461e6 = 1;
        break;
      }

      continue;
    }

    break;
  }

  if(var_c70461e6 == 1) {
    var_2cc4646f = 0;

    foreach(key, stage in activecamo.stages) {
      if(!isDefined(stage.var_dd54a13b[activecamo.baseweapon])) {
        continue;
      }

      if(!var_2cc4646f) {
        if(stage.var_62b564ee.var_c33fcb85 === 1) {
          var_2cc4646f = 1;
          stagenum = key;
        } else {
          continue;
        }
      }

      stage.var_dd54a13b[activecamo.baseweapon].statvalue = 0;
      stage.var_dd54a13b[activecamo.baseweapon].cleared = undefined;
    }

    if(var_2cc4646f) {
      set_stage_activecamo(activecamo, stagenum);
    }

    return;
  }

  weaponoptions = self function_ade49959(activecamo.weapon);
  weaponstage = getactivecamostage(weaponoptions);

  if(weaponstage != stagenum || activecamo.var_dd54a13b[activecamo.baseweapon].stagenum !== stagenum) {
    set_stage_activecamo(activecamo, stagenum);
  }
}

function function_8eac065(activecamo) {
  if(!is_true(activecamo.var_dd54a13b[activecamo.baseweapon].var_8fc208a8)) {
    var_8fc208a8 = 1;

    foreach(key, stage in activecamo.stages) {
      if(isDefined(stage.var_62b564ee.permanentstatname)) {
        if(!isDefined(stage.var_dd54a13b[activecamo.baseweapon])) {
          continue;
        }

        if(stage.var_dd54a13b[activecamo.baseweapon].statvalue >= stage.var_62b564ee.var_e2dbd42d) {
          stage.var_dd54a13b[activecamo.baseweapon].cleared = 1;
        }

        if(!is_true(stage.var_dd54a13b[activecamo.baseweapon].cleared)) {
          var_8fc208a8 = 0;
        }

        continue;
      }

      break;
    }

    if(var_8fc208a8) {
      activecamo.var_dd54a13b[activecamo.baseweapon].var_8fc208a8 = 1;
    }
  }

  var_42d9b149 = 0;

  if(is_true(activecamo.var_dd54a13b[activecamo.baseweapon].var_8fc208a8)) {
    for(stagenum = activecamo.stages.size - 1; stagenum >= 0; stagenum--) {
      stage = activecamo.stages[stagenum];

      if(!isDefined(stage.var_dd54a13b[activecamo.baseweapon])) {
        continue;
      }

      if(!is_true(stage.var_dd54a13b[activecamo.baseweapon].cleared) && stage.var_dd54a13b[activecamo.baseweapon].statvalue >= stage.var_62b564ee.var_e2dbd42d) {
        stage.var_dd54a13b[activecamo.baseweapon].cleared = 1;
        var_42d9b149 = stagenum;
        break;
      }
    }

    foreach(key, stage in activecamo.stages) {
      if(isDefined(stage.var_62b564ee.permanentstatname)) {
        continue;
      }

      if(var_42d9b149 == key) {
        continue;
      }

      if(!isDefined(stage.var_dd54a13b[activecamo.baseweapon])) {
        continue;
      }

      stage.var_dd54a13b[activecamo.baseweapon].statvalue = 0;
      stage.var_dd54a13b[activecamo.baseweapon].cleared = undefined;
    }
  }

  weaponoptions = self function_ade49959(activecamo.weapon);
  weaponstage = getactivecamostage(weaponoptions);

  if(weaponstage != var_42d9b149 || activecamo.var_dd54a13b[activecamo.baseweapon].stagenum !== var_42d9b149) {
    set_stage_activecamo(activecamo, var_42d9b149);
  }
}

function set_stage_activecamo(activecamo, stagenum) {
  stage = activecamo.stages[stagenum];

  if(!isDefined(stage)) {
    return;
  }

  activecamo.var_dd54a13b[activecamo.baseweapon].stagenum = stagenum;
  self setactivecamostage(activecamo.weapon, stagenum);

  if(isDefined(stage.var_62b564ee.var_19b6044e)) {
    self setcamo(activecamo.weapon, stage.var_62b564ee.var_19b6044e);
  }

  self debug_print("<dev string:x38>" + activecamo.var_13949c61.name + "<dev string:x1f7>" + stagenum + "<dev string:x207>" + (isDefined(stage.var_62b564ee.var_19b6044e) ? stage.var_62b564ee.var_19b6044e : "<dev string:x219>"));

  self thread function_a80cb651(activecamo, stagenum);
}

function function_a80cb651(activecamo, stagenum) {
  self notify("11ec35d57896d22e");
  self endon("11ec35d57896d22e");
  self endon(#"death");
  stage = activecamo.stages[stagenum];
  weapon = activecamo.weapon;
  baseweapon = function_c14cb514(weapon);

  if(isDefined(stage.var_62b564ee.resetnotify)) {
    resettime = undefined;

    while(true) {
      if(stage.var_62b564ee.resettimer > 0) {
        if(!isDefined(resettime)) {
          resettime = gettime() + stage.var_62b564ee.resettimer;
        }

        waittime = float(resettime - gettime()) / 1000;
        s_result = self waittilltimeout(waittime, stage.var_62b564ee.resetnotify);
      } else {
        s_result = self waittill(stage.var_62b564ee.resetnotify);
      }

      if(s_result._notify == # "timeout") {
        break;
      }

      if(isDefined(s_result.weapon) && baseweapon == s_result.weapon) {
        break;
      }
    }
  } else if(stage.var_62b564ee.resettimer > 0) {
    wait float(stage.var_62b564ee.resettimer) / 1000;
  } else {
    return;
  }

  if(is_true(stage.var_dd54a13b[activecamo.baseweapon].cleared)) {
    return;
  }

  stage.var_dd54a13b[activecamo.baseweapon].statvalue = 0;
  stage.var_dd54a13b[activecamo.baseweapon].cleared = undefined;
  activecamo.weapon = weapon;
  activecamo.baseweapon = baseweapon;
  self init_stages(activecamo, 1, 0);
}

function function_5aa1d2c8(weapon, b_has_weapon) {
  if(b_has_weapon) {
    var_f879230e = self function_8cbd254d(weapon);
  } else {
    var_f879230e = self function_1744e243(weapon);
  }

  activecamoname = function_33ed1149(weapon, var_f879230e);
  return activecamoname;
}

function function_155299d(weapon, b_has_weapon = 1) {
  if(b_has_weapon) {
    camooptions = self function_ade49959(weapon);
  } else {
    camooptions = self getbuildkitweaponoptions(weapon);
  }

  var_f4eb4a50 = function_edd6511(camooptions);

  if(isDefined(var_f4eb4a50)) {
    return var_f4eb4a50;
  }

  activecamoname = self function_5aa1d2c8(weapon, b_has_weapon);

  if(isDefined(activecamoname) && activecamoname != # "") {
    var_f4eb4a50 = getscriptbundle(activecamoname);
  }

  return var_f4eb4a50;
}

function function_b004e227(weapon, b_has_weapon = 1) {
  if(b_has_weapon) {
    camooptions = self function_ade49959(weapon);
  } else {
    camooptions = self getbuildkitweaponoptions(weapon);
  }

  activecamoname = function_5af7df72(camooptions);

  if(isDefined(activecamoname) && activecamoname != # "") {
    return activecamoname;
  }

  activecamoname = self function_5aa1d2c8(weapon, b_has_weapon);
  return activecamoname;
}

function debug_error(message, weapon) {
  if(getdvarint(#"activecamo_debug", 0) > 0) {
    weaponname = "<dev string:x226>";

    if(isDefined(weapon)) {
      weaponname = "<dev string:x22a>" + function_9e72a96(weapon.name);
    }

    self iprintlnbold("<dev string:x238>" + message + weaponname);
    println("<dev string:x259>" + self.playername + "<dev string:x26f>" + message + weaponname);
  }
}

function debug_print(message, weapon) {
  if(getdvarint(#"activecamo_debug", 0) > 0) {
    weaponname = "<dev string:x226>";

    if(isDefined(weapon)) {
      weaponname = "<dev string:x22a>" + function_9e72a96(weapon.name);
    }

    self iprintlnbold("<dev string:x259>" + message + weaponname);
    println("<dev string:x259>" + self.playername + "<dev string:x26f>" + message + weaponname);
  }
}

function function_265047c1() {
  callback::on_connect(&on_player_connect);
  callback::on_disconnect(&on_player_disconnect);
  level.var_630fbd77 = "<dev string:x275>" + 30 + "<dev string:x294>";
  root = "<dev string:x299>" + level.var_630fbd77;
  function_1039ce5c(root);
  thread devgui_think();
  thread function_12e53b2d();
}

function on_player_connect() {
  if(self getentnum() < 4) {
    self thread devgui_player_connect();
  }
}

function on_player_disconnect() {
  if(self getentnum() < 4) {
    self thread devgui_player_disconnect();
  }
}

function devgui_player_connect() {
  if(!isDefined(level.var_630fbd77)) {
    return;
  }

  wait 2;
  root = level.var_630fbd77 + "<dev string:x2a8>";
  players = getplayers();

  for(i = 0; i < players.size; i++) {
    if(players[i] != self) {
      continue;
    }

    thread devgui_add_player_commands(root, players[i].playername, i + 1);
    return;
  }
}

function devgui_player_disconnect() {
  if(!isDefined(level.var_630fbd77)) {
    return;
  }

  root = level.var_630fbd77 + "<dev string:x2a8>";
  cmd = "<dev string:x2b4>" + root + self.playername + "<dev string:x2c6>";
  thread util::add_debug_command(cmd);
}

function devgui_add_player_commands(root, pname, index) {
  add_cmd_with_root = "<dev string:x299>" + root + pname + "<dev string:x294>";
  function_f1d01720(add_cmd_with_root, index);
  function_85cb822d(add_cmd_with_root, index);
  function_de358bfd(add_cmd_with_root, index);
  function_50d79d31(add_cmd_with_root, index);
}

function function_1039ce5c(root) {
  cmd = root + "<dev string:x2cc>" + "<dev string:x2dc>";
  thread util::add_debug_command(cmd);
}

function function_f1d01720(root, index) {
  var_37949de1 = root;

  if(!isDefined(index)) {
    index = 0;
  }

  cmd = root + "<dev string:x2ff>" + "<dev string:x30a>" + index + "<dev string:x340>";
  thread util::add_debug_command(cmd);
  cmd = root + "<dev string:x347>" + "<dev string:x352>" + index + "<dev string:x340>";
  thread util::add_debug_command(cmd);
}

function function_85cb822d(root, index) {
  var_37949de1 = root + "<dev string:x383>";

  if(!isDefined(index)) {
    index = 0;
  }

  activecamos = function_2c48197b();

  foreach(activecamo in activecamos) {
    if(activecamo == # "") {
      continue;
    }

    activecamoname = function_9e72a96(activecamo);
    cmd = var_37949de1 + activecamoname + "<dev string:x38d>" + activecamoname + "<dev string:x3be>" + index + "<dev string:x340>";
    thread util::add_debug_command(cmd);
  }
}

function function_de358bfd(root, index) {
  var_1520a1da = root + "<dev string:x3d9>";

  if(!isDefined(index)) {
    index = 0;
  }

  weapons = [];
  weapons[0] = "<dev string:x3e5>";
  weapons[1] = "<dev string:x3f7>";
  weapons[2] = "<dev string:x40d>";
  weapons[3] = "<dev string:x420>";

  foreach(weapon in weapons) {
    cmd = var_1520a1da + weapon + "<dev string:x433>" + weapon + "<dev string:x3be>" + index + "<dev string:x340>";
    thread util::add_debug_command(cmd);
  }
}

function function_50d79d31(root, index) {
  var_82c49718 = root + "<dev string:x467>";

  if(!isDefined(index)) {
    index = 0;
  }

  stages = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

  foreach(stage in stages) {
    cmd = var_82c49718 + stage + "<dev string:x475>" + stage + "<dev string:x3be>" + index + "<dev string:x340>";
    thread util::add_debug_command(cmd);
  }
}

function devgui_think() {
  self notify("<dev string:x4a7>");
  self endon("<dev string:x4a7>");

  for(;;) {
    wait 0.5;
    reset = 1;
    host = util::gethostplayer();

    switch (getdvarstring(#"hash_3e1bb44a57b02ed8")) {
      case 0:
        reset = 0;
        break;
      case # "debugprints":
        setDvar(#"activecamo_debug", !getdvarint(#"activecamo_debug", 0));
        break;
      case # "reset":
        function_cc5baf7f(&function_58719455);
        break;
      case # "stage_next":
        function_cc5baf7f(&function_3ac4d286, 0);
        break;
      case # "stage_prev":
        function_cc5baf7f(&function_3ac4d286, 1);
        break;
      case # "set_camo":
        function_cc5baf7f(&function_9c361e56, getdvarstring(#"hash_3fe8dd280c325e8"));
        break;
      case # "give_weapon":
        function_cc5baf7f(&function_cc486b05, getdvarstring(#"hash_3fe8dd280c325e8"));
        break;
      case # "set_stage":
        function_cc5baf7f(&function_779a9561, getdvarstring(#"hash_3fe8dd280c325e8"));
        break;
    }

    if(reset) {
      setDvar(#"hash_3e1bb44a57b02ed8", "<dev string:x226>");
      setDvar(#"hash_3fe8dd280c325e8", "<dev string:x226>");
      setDvar(#"hash_324a391b56cb100", "<dev string:x226>");
    }
  }
}

function function_cc5baf7f(callback, par) {
  pid = getdvarint(#"hash_324a391b56cb100", 0);

  if(pid > 0) {
    player = getplayers()[pid - 1];

    if(isDefined(player)) {
      if(isDefined(par)) {
        player[[callback]](par);
      } else {
        player[[callback]]();
      }
    }

    return;
  }

  players = getplayers();

  foreach(player in players) {
    if(isDefined(par)) {
      player[[callback]](par);
      continue;
    }

    player[[callback]]();
  }
}

function function_cc486b05(weaponname) {
  weapon = getweapon(weaponname);
  self giveweapon(weapon);
  self switchtoweapon(weapon);
}

function function_779a9561(stagenum) {
  weapon = self getcurrentweapon();
  weapon = function_94c2605(weapon);
  activecamoname = self function_b004e227(weapon);

  if(isDefined(activecamoname)) {
    activecamo = self.pers[#"activecamo"][activecamoname];

    if(isDefined(activecamo) && isDefined(activecamo.stages) && stagenum < activecamo.stages.size) {
      activecamo.weapon = weapon;
      activecamo.baseweapon = function_c14cb514(activecamo.weapon);

      if(isDefined(activecamo.var_13949c61.var_5f38b34e)) {
        setDvar(activecamo.var_13949c61.var_5f38b34e, stagenum);
      }

      if(is_true(activecamo.var_13949c61.istiered)) {
        foreach(key, stage in activecamo.stages) {
          statcount = 0;

          if(key < stagenum) {
            statcount = stage.var_62b564ee.var_e2dbd42d;
          }

          if(isDefined(stage.var_62b564ee.permanentstatname)) {
            self stats::set_stat_global(stage.var_62b564ee.permanentstatname, statcount);
          } else if(isDefined(stage.var_62b564ee.statname)) {
            if(is_true(stage.var_62b564ee.permanent)) {
              self stats::set_stat_global(stage.var_62b564ee.statname, statcount);
            }
          }

          stage.var_dd54a13b[activecamo.baseweapon].statvalue = statcount;
          stage.var_dd54a13b[activecamo.baseweapon].cleared = undefined;
        }
      } else if(is_true(activecamo.var_13949c61.var_2034fabe)) {
        activecamo.var_dd54a13b[activecamo.baseweapon].var_8fc208a8 = undefined;

        foreach(key, stage in activecamo.stages) {
          statcount = 0;

          if(key < stagenum) {
            statcount = stage.var_62b564ee.var_e2dbd42d;
          }

          if(isDefined(stage.var_62b564ee.permanentstatname)) {
            self stats::set_stat_global(stage.var_62b564ee.permanentstatname, statcount);
          } else if(isDefined(stage.var_62b564ee.statname)) {
            statcount = 0;

            if(key == stagenum) {
              statcount = stage.var_62b564ee.var_e2dbd42d;
            }

            if(is_true(stage.var_62b564ee.permanent)) {
              self stats::set_stat_global(stage.var_62b564ee.statname, statcount);
            }
          }

          stage.var_dd54a13b[activecamo.baseweapon].statvalue = statcount;
          stage.var_dd54a13b[activecamo.baseweapon].cleared = undefined;
        }
      }

      self function_b9119037(activecamo);
    }
  }
}

function function_9c361e56(activecamoname) {
  var_f4eb4a50 = getscriptbundle(activecamoname);
  weapon = self getcurrentweapon();

  if(isDefined(var_f4eb4a50)) {
    self init_activecamo(weapon, var_f4eb4a50, 1);
  }
}

function function_3ac4d286(back) {
  weapon = self getcurrentweapon();
  self function_633fbf17(weapon, back);
}

function function_633fbf17(weapon, back) {
  if(isDefined(weapon)) {
    self function_8d3b94ea(weapon, 1);
    weapon = function_94c2605(weapon);
    activecamoname = self function_b004e227(weapon);

    if(isDefined(activecamoname)) {
      activecamo = self.pers[#"activecamo"][activecamoname];

      if(isDefined(activecamo)) {
        if(isDefined(activecamo.stages)) {
          activecamo.weapon = weapon;
          activecamo.baseweapon = function_c14cb514(activecamo.weapon);

          if(isDefined(activecamo.var_13949c61.var_5f38b34e)) {
            currentstage = getdvarint(activecamo.var_13949c61.var_5f38b34e, 0);
          } else {
            currentstage = isDefined(activecamo.var_dd54a13b[activecamo.baseweapon].stagenum) ? activecamo.var_dd54a13b[activecamo.baseweapon].stagenum : -1;
          }

          if(back) {
            nextstage = (currentstage - 1 + activecamo.stages.size) % activecamo.stages.size;
          } else {
            nextstage = (currentstage + 1) % activecamo.stages.size;
          }

          self function_779a9561(nextstage);
        }
      }
    }
  }
}

function function_58719455() {
  weapon = self getcurrentweapon();
  self function_3d928fb4(weapon);
}

function function_3d928fb4(weapon) {
  if(isDefined(weapon)) {
    self function_8d3b94ea(weapon, 1);
    weapon = function_94c2605(weapon);
    activecamoname = self function_b004e227(weapon);

    if(isDefined(activecamoname)) {
      activecamo = self.pers[#"activecamo"][activecamoname];

      if(isDefined(activecamo)) {
        activecamo.weapon = weapon;
        activecamo.baseweapon = function_c14cb514(activecamo.weapon);
        self function_9fc8a57c(activecamo);
      }
    }
  }
}

function function_9fc8a57c(activecamo) {
  if(isDefined(activecamo)) {
    if(isDefined(activecamo.stages)) {
      foreach(stage in activecamo.stages) {
        self function_dc6014e8(stage);
      }

      if(isDefined(activecamo.var_13949c61.var_5f38b34e)) {
        setDvar(activecamo.var_13949c61.var_5f38b34e, 0);
      }

      self init_stages(activecamo, 1, 0);
    }
  }
}

function function_dc6014e8(stage) {
  if(isDefined(stage.var_62b564ee.permanentstatname)) {
    self stats::set_stat_global(stage.var_62b564ee.permanentstatname, 0);
    return;
  }

  if(isDefined(stage.var_62b564ee.statname)) {
    if(is_true(stage.var_62b564ee.permanent)) {
      self stats::set_stat_global(stage.var_62b564ee.statname, 0);
    }
  }
}

function function_12e53b2d() {
  self notify("<dev string:x4bb>");
  self endon("<dev string:x4bb>");

  while(true) {
    var_f4eb4a50 = undefined;
    waitresult = level waittill(#"liveupdate");

    if(!isDefined(level.activecamoinfo)) {
      continue;
    }

    if(isDefined(waitresult.scriptbundlename)) {
      var_f4eb4a50 = getscriptbundle(waitresult.scriptbundlename);

      if(!isDefined(var_f4eb4a50.name)) {
        continue;
      }

      if(!isDefined(level.activecamoinfo[var_f4eb4a50.name])) {
        continue;
      }

      players = getplayers();

      foreach(player in players) {
        if(!isalive(player)) {
          continue;
        }

        if(!isDefined(player.pers[#"activecamo"][var_f4eb4a50.name])) {
          continue;
        }

        activecamo = player.pers[#"activecamo"][var_f4eb4a50.name];

        if(isDefined(activecamo.weapon)) {
          player init_activecamo(activecamo.weapon, var_f4eb4a50, 1);
        }
      }
    }
  }
}

function function_b008f9e9(weapon) {
  if(!isDefined(level.activecamoinfo)) {
    return;
  }

  if(self getcurrentweapon() != weapon) {
    self switchtoweapon(weapon);
    self waittilltimeout(2, #"weapon_change");
  }

  foreach(var_13949c61 in level.activecamoinfo) {
    var_f4eb4a50 = getscriptbundle(var_13949c61.name);
    self init_activecamo(weapon, var_f4eb4a50, 1);
    waitframe(1);
  }
}