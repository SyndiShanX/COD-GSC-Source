/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\activecamo_shared.gsc
***********************************************/

#include scripts\core_common\activecamo_shared_util;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\weapons_shared;

#namespace activecamo;

autoexec __init__system__() {
  system::register(#"activecamo", &__init__, undefined, undefined);
}

__init__() {
  callback::on_loadout(&on_player_loadout);
  callback::on_weapon_change(&on_weapon_change);

  thread function_265047c1();
}

on_weapon_change(params) {
  if(isDefined(level.var_b219667f) && level.var_b219667f) {
    self function_8d3b94ea(params.weapon, 1);
  } else {
    self function_8d3b94ea(params.weapon, 0);
  }

  if(isDefined(level.var_3993dc8e)) {
    self[[level.var_3993dc8e]](params.weapon);
  }
}

on_player_death(params) {
  if(game.state != "playing") {
    return;
  }

  self function_27779784();
}

function_27779784() {
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

on_player_loadout() {
  self callback::remove_on_death(&on_player_death);
  weapons = self getweaponslist();

  foreach(weapon in weapons) {
    self function_8d3b94ea(weapon, 1);
  }
}

function_8d3b94ea(weapon, owned, b_has_weapon) {
  weapon = function_94c2605(weapon);
  activecamoinfo = weapon_get_activecamo(weapon, b_has_weapon);

  if(isDefined(activecamoinfo)) {
    self init_activecamo(weapon, activecamoinfo, owned);
  }
}

init_activecamo(weapon, activecamoinfo, owned) {
  if(isDefined(activecamoinfo) && isDefined(activecamoinfo.name)) {
    if(!isDefined(self.pers[#"activecamo"])) {
      self.pers[#"activecamo"] = [];
    }

    if(!isDefined(self.pers[#"activecamo"][activecamoinfo.name])) {
      self.pers[#"activecamo"][activecamoinfo.name] = {};
    }

    activecamo = self.pers[#"activecamo"][activecamoinfo.name];
    activecamo.info = function_3aa81e0e(activecamoinfo);
    assert(isDefined(activecamo.info));
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

function_b008f9e9(weapon) {
  if(!isDefined(level.activecamoinfo)) {
    return;
  }

  if(self getcurrentweapon() != weapon) {
    self switchtoweapon(weapon);
    self waittilltimeout(2, #"weapon_change");
  }

  foreach(info in level.activecamoinfo) {
    activecamoinfo = getscriptbundle(info.name);
    self init_activecamo(weapon, activecamoinfo, 1);
    waitframe(1);
  }
}

function_3aa81e0e(activecamoinfo) {
  info = undefined;

  if(isDefined(activecamoinfo) && isDefined(activecamoinfo.name)) {
    if(!isDefined(level.activecamoinfo)) {
      level.activecamoinfo = [];
    }

    if(!isDefined(level.activecamoinfo[activecamoinfo.name])) {
      level.activecamoinfo[activecamoinfo.name] = {};
    }

    info = level.activecamoinfo[activecamoinfo.name];
    info.name = activecamoinfo.name;
    info.isasync = activecamoinfo.isasync;
    info.istiered = activecamoinfo.istiered;
    info.isimpulse = activecamoinfo.isimpulse;
    info.var_ed6f91d5 = activecamoinfo.var_ed6f91d5;
    info.var_bd863267 = activecamoinfo.var_bd863267;
    info.istimer = activecamoinfo.istimer;
    info.var_fa0465c6 = activecamoinfo.var_fa0465c6;
    info.var_2034fabe = activecamoinfo.var_2034fabe;
    info.var_9ae5a2b8 = activecamoinfo.var_9ae5a2b8;
    var_d3daabe = 0;

    if(isDefined(activecamoinfo.stages)) {
      if(!isDefined(info.stages)) {
        info.stages = [];
      }

      foreach(key, var_3594168e in activecamoinfo.stages) {
        if(isDefined(var_3594168e.disabled) && var_3594168e.disabled) {
          var_d3daabe++;
          continue;
        }

        if(!isDefined(info.stages[key - var_d3daabe])) {
          info.stages[key - var_d3daabe] = {};
        }

        stage = info.stages[key - var_d3daabe];

        if(isDefined(var_3594168e.camooption)) {
          stage.var_19b6044e = function_8b51d9d1(var_3594168e.camooption);
        }

        if(!isDefined(stage.var_19b6044e)) {
          self debug_error("<dev string:x38>" + info.name + "<dev string:x3d>" + function_9e72a96(isDefined(var_3594168e.camooption) ? var_3594168e.camooption : "<dev string:x59>") + "<dev string:x63>" + key);
        } else {
          activecamoname = getactivecamo(stage.var_19b6044e);
          var_31567a86 = undefined;

          if(isDefined(activecamoname) && activecamoname != #"") {
            var_31567a86 = getscriptbundle(activecamoname);
          }

          if(!isDefined(var_31567a86)) {
            self debug_error("<dev string:x38>" + info.name + "<dev string:x74>" + stage.var_19b6044e + "<dev string:x63>" + key);
          } else if(!isDefined(var_31567a86.name) || var_31567a86.name != info.name) {
            self debug_error("<dev string:x38>" + info.name + "<dev string:x9e>" + stage.var_19b6044e + "<dev string:xb1>" + (isDefined(var_31567a86.name) ? var_31567a86.name : "<dev string:x59>") + "<dev string:x63>" + key);
          }
        }

        stage.permanent = var_3594168e.permanent;
        stage.statname = var_3594168e.statname;
        stage.permanentstatname = var_3594168e.permanentstatname;
        stage.var_e2dbd42d = isDefined(var_3594168e.var_e2dbd42d) ? var_3594168e.var_e2dbd42d : 0;
        stage.resettimer = isDefined(var_3594168e.resettimer) ? var_3594168e.resettimer : 0;
        stage.resetnotify = var_3594168e.resetnotify;
        stage.resetondeath = var_3594168e.resetondeath;
        stage.var_825ae630 = var_3594168e.var_c43b3dd3;
        stage.var_c33fcb85 = isDefined(var_3594168e.var_c33fcb85) ? var_3594168e.var_c33fcb85 : 0;

        var_1936b16e = getdvarint(#"hash_45e0785aaf2e24af", 0);

        if(var_1936b16e) {
          stage.var_e2dbd42d = var_1936b16e;
        }

      }
    }
  }

  return info;
}

weapon_get_activecamo(weapon, b_has_weapon = 1) {
  activecamoinfo = undefined;

  if(b_has_weapon) {
    weaponoptions = self getweaponoptions(weapon);
  } else {
    weaponoptions = self getbuildkitweaponoptions(weapon);
  }

  camoindex = getcamoindex(weaponoptions);
  activecamoname = getactivecamo(camoindex);

  if(isDefined(activecamoname) && activecamoname != #"") {
    activecamoinfo = getscriptbundle(activecamoname);
  }

  return activecamoinfo;
}

function_37a45562(camoindex, activecamo) {
  foreach(stagenum, stage in activecamo.info.stages) {
    if(isDefined(stage) && isDefined(stage.var_19b6044e) && stage.var_19b6044e == camoindex) {
      return stagenum;
    }
  }

  return undefined;
}

init_stages(activecamo, var_3a8a1e00, isdeath) {
  if(isDefined(activecamo)) {
    if(isDefined(activecamo.info) && isDefined(activecamo.info.stages)) {
      weaponoptions = self getweaponoptions(activecamo.weapon);
      weaponstage = getactivecamostage(weaponoptions);
      camoindex = getcamoindex(weaponoptions);
      camoindexstage = function_37a45562(camoindex, activecamo);
      var_7491ec51 = activecamo.var_dd54a13b[activecamo.baseweapon].owned !== 1;

      if(!var_7491ec51) {
        var_7491ec51 = isDefined(camoindexstage);

        if(var_7491ec51) {
          weaponstage = camoindexstage;
        }
      }

      if(!isDefined(activecamo.stages)) {
        activecamo.stages = [];
      }

      foreach(stagenum, infostage in activecamo.info.stages) {
        if(!isDefined(activecamo.stages[stagenum])) {
          activecamo.stages[stagenum] = {};
        }

        stage = activecamo.stages[stagenum];
        stage.info = infostage;
        assert(isDefined(stage.info));

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
          if(isDefined(stage.info.var_825ae630) && stage.info.var_825ae630 && isDefined(stage.var_dd54a13b[activecamo.baseweapon].cleared) && stage.var_dd54a13b[activecamo.baseweapon].cleared) {
            stage.var_dd54a13b[activecamo.baseweapon].statvalue = stage.info.var_e2dbd42d;
          } else if(isDefined(stage.info.resetondeath) && stage.info.resetondeath || stage.info.resettimer > 0) {
            stage.var_dd54a13b[activecamo.baseweapon].statvalue = 0;
            reset = 1;
          }
        }

        if(isDefined(stage.info.permanentstatname)) {
          camo_stat = self stats::get_stat_global(stage.info.permanentstatname);

          if(isDefined(camo_stat) && camo_stat < stage.info.var_e2dbd42d) {
            var_7dfd59c3 = isDefined(stats::function_af5584ca(stage.info.permanentstatname)) ? stats::function_af5584ca(stage.info.permanentstatname) : 0;

            if(var_7dfd59c3 > 0) {
              camo_stat = stage.info.var_e2dbd42d;
              self stats::set_stat_global(stage.info.permanentstatname, camo_stat);
              self stats::set_stat_challenge(stage.info.permanentstatname, camo_stat);
            }
          }

          if(isDefined(camo_stat)) {
            stage.var_dd54a13b[activecamo.baseweapon].statvalue = camo_stat;
          }
        } else if(isDefined(stage.info.permanent) && stage.info.permanent && isDefined(stage.info.statname)) {
          camo_stat = self stats::get_stat_global(stage.info.statname);

          if(isDefined(camo_stat)) {
            stage.var_dd54a13b[activecamo.baseweapon].statvalue = camo_stat;
          }
        }

        if(!reset && isDefined(stage.var_dd54a13b[activecamo.baseweapon].cleared) && stage.var_dd54a13b[activecamo.baseweapon].cleared) {
          if(isDefined(activecamo.info.istiered) && activecamo.info.istiered) {
            if(weaponstage > stagenum) {
              stage.var_dd54a13b[activecamo.baseweapon].statvalue = stage.info.var_e2dbd42d;
            }
          }

          if(isDefined(activecamo.info.var_2034fabe) && activecamo.info.var_2034fabe) {
            if(isDefined(stage.info.permanentstatname)) {
              if(weaponstage > stagenum) {
                stage.var_dd54a13b[activecamo.baseweapon].statvalue = stage.info.var_e2dbd42d;
              }
            } else if(isDefined(stage.info.permanent) && stage.info.permanent && isDefined(stage.info.statname)) {
              if(weaponstage > stagenum) {
                stage.var_dd54a13b[activecamo.baseweapon].statvalue = stage.info.var_e2dbd42d;
              }
            } else if(weaponstage == stagenum) {
              stage.var_dd54a13b[activecamo.baseweapon].statvalue = stage.info.var_e2dbd42d;
            }
          }
        }

        stage.var_dd54a13b[activecamo.baseweapon].cleared = undefined;

        if(var_7491ec51) {
          if(isDefined(activecamo.info.istiered) && activecamo.info.istiered) {
            if(weaponstage > stagenum) {
              if(isDefined(stage.info.permanentstatname)) {
                stage.var_dd54a13b[activecamo.baseweapon].statvalue = stage.info.var_e2dbd42d;
              } else if(isDefined(stage.info.permanent) && stage.info.permanent && isDefined(stage.info.statname)) {
                stage.var_dd54a13b[activecamo.baseweapon].statvalue = stage.info.var_e2dbd42d;
              }
            }
          }

          if(isDefined(activecamo.info.var_2034fabe) && activecamo.info.var_2034fabe) {
            if(isDefined(stage.info.permanentstatname)) {
              if(weaponstage > stagenum) {
                stage.var_dd54a13b[activecamo.baseweapon].statvalue = stage.info.var_e2dbd42d;
              }
            } else if(isDefined(stage.info.permanent) && stage.info.permanent && isDefined(stage.info.statname)) {
              if(weaponstage > stagenum) {
                stage.var_dd54a13b[activecamo.baseweapon].statvalue = stage.info.var_e2dbd42d;
              }
            } else if(weaponstage == stagenum) {
              stage.var_dd54a13b[activecamo.baseweapon].statvalue = stage.info.var_e2dbd42d;
            }
          }
        }

        if(isDefined(activecamo.info.isasync) && activecamo.info.isasync) {
          self thread function_f0d83504(activecamo, stage, stagenum);
        }
      }

      self function_e44edbd1(activecamo);
    }
  }
}

function_c0fa0ecb(weapon) {
  switch (weapon.statname) {
    case #"tr_midburst_t8":
    case #"sniper_powersemi_t8":
    case #"ar_damage_t8":
    case #"ar_accurate_t8":
    case #"smg_capacity_t8":
    case #"sniper_powerbolt_t8":
    case #"ar_fastfire_t8":
    case #"sniper_quickscope_t8":
    case #"lmg_heavy_t8":
    case #"ar_stealth_t8":
    case #"tr_longburst_t8":
    case #"smg_standard_t8":
    case #"lmg_spray_t8":
    case #"smg_accurate_t8":
    case #"ar_modular_t8":
    case #"smg_fastfire_t8":
    case #"lmg_standard_t8":
    case #"sniper_fastrechamber_t8":
    case #"tr_powersemi_t8":
    case #"smg_handling_t8":
      self stats::function_eec52333(weapon, #"hash_4e43a25a3e77ab5f", 1, self.class_num);
      break;
    default:
      break;
  }
}

function_c1f96c48(weapon) {
  switch (weapon.statname) {
    case #"ar_accurate_t8":
      return #"hash_3d392c6f96aa2ac1";
    case #"ar_fastfire_t8":
      return #"hash_9da725fe15aa048";
    case #"lmg_standard_t8":
      return #"hash_5cf945d7954a39e0";
    case #"pistol_standard_t8":
      return #"hash_1ffb9d5647330a52";
    case #"shotgun_semiauto_t8":
      return #"hash_6ed19b98000fb441";
    case #"smg_accurate_t8":
      return #"hash_4b703056e870752e";
    case #"smg_standard_t8":
      return #"hash_207f20afd71816c";
    default:
      break;
  }

  return undefined;
}

function_938534a8(permanentstatname) {
  var_19ef0b8d = undefined;

  switch (permanentstatname) {
    case #"hash_3d392c6f96aa2ac1":
      var_19ef0b8d = #"camo_active_ar_accurate_base";
      break;
    case #"hash_9da725fe15aa048":
      var_19ef0b8d = #"camo_active_ar_fastfire_base";
      break;
    case #"hash_5cf945d7954a39e0":
      var_19ef0b8d = #"camo_active_lmg_standard_base";
      break;
    case #"hash_1ffb9d5647330a52":
      var_19ef0b8d = #"camo_active_pistol_standard_base";
      break;
    case #"hash_6ed19b98000fb441":
      var_19ef0b8d = #"camo_active_shotgun_semiauto_base";
      break;
    case #"hash_4b703056e870752e":
      var_19ef0b8d = #"camo_active_smg_accurate_base";
      break;
    case #"hash_207f20afd71816c":
      var_19ef0b8d = #"camo_active_smg_standard_base";
      break;
    default:
      break;
  }

  if(isDefined(var_19ef0b8d)) {
    self stats::function_dad108fa(var_19ef0b8d, 1);
  }
}

function_1af985ba(weapon) {
  if(!isplayer(self)) {
    return;
  }

  var_19bbfaaf = function_c1f96c48(weapon);

  if(!isDefined(var_19bbfaaf)) {
    return;
  }

  var_dfcb2df3 = isDefined(stats::function_af5584ca(var_19bbfaaf)) ? stats::function_af5584ca(var_19bbfaaf) : 0;

  if(var_dfcb2df3 > 0) {
    self stats::function_e24eec31(weapon, #"hash_19fbe2645c7f53a7", 1);
    self function_938534a8(var_19bbfaaf);
  }
}

function_cd9deb9e(weapon) {
  if(!isplayer(self)) {
    return;
  }

  var_19bbfaaf = function_c1f96c48(weapon);

  if(!isDefined(var_19bbfaaf)) {
    return;
  }

  var_dfcb2df3 = isDefined(stats::function_af5584ca(var_19bbfaaf)) ? stats::function_af5584ca(var_19bbfaaf) : 0;

  if(var_dfcb2df3 > 0) {
    self stats::function_e24eec31(weapon, #"hash_19fbe2645c7f53a7", 1);
    self function_938534a8(var_19bbfaaf);
  }
}

function_36feaf9e(activecamo, value, weapon) {
  if(!isDefined(activecamo.kills)) {
    activecamo.kills = 0;
  }

  newvalue = activecamo.kills + value;

  if(activecamo.kills < 5 && newvalue >= 5) {
    self function_896ac347(weapon, "5th_kill", 1);
  }

  if(activecamo.kills < 9 && newvalue >= 9) {
    self function_896ac347(weapon, "9th_kill", 1);
  }

  if(activecamo.kills < 100 && newvalue >= 100) {
    self function_896ac347(weapon, "100th_kill", 1);
  }

  activecamo.kills = newvalue;
}

function_896ac347(oweapon, statname, value) {
  if(!isplayer(self)) {
    return;
  }

  if(!isDefined(self.pers) || !isDefined(self.pers[#"activecamo"])) {
    return;
  }

  if(!isDefined(oweapon)) {
    assertmsg("<dev string:xcb>");
    return;
  }

  weapon = function_94c2605(oweapon);

  if(!isDefined(weapon)) {
    assertmsg("<dev string:xff>" + function_9e72a96(oweapon.name));
    return;
  }

  activecamoinfo = weapon_get_activecamo(weapon);

  if(isDefined(activecamoinfo)) {
    activecamo = self.pers[#"activecamo"][activecamoinfo.name];

    if(isDefined(activecamo)) {
      activecamo.weapon = weapon;
      activecamo.baseweapon = function_c14cb514(activecamo.weapon);

      if(!isDefined(activecamo.baseweapon)) {
        assertmsg("<dev string:x144>" + function_9e72a96(activecamo.weapon.name));
        return;
      }

      if(!isDefined(activecamo.var_dd54a13b[activecamo.baseweapon])) {
        assertmsg("<dev string:x192>" + function_9e72a96(activecamo.baseweapon.name) + "<dev string:x1c2>");
        return;
      }

      var_7a414d4a = 0;
      var_5c900b6e = 0;
      var_7cbc8452 = 0;
      var_15838be3 = 0;

      if(isDefined(activecamo.stages)) {
        foreach(stagenum, stage in activecamo.stages) {
          if(isDefined(stage.var_dd54a13b[activecamo.baseweapon].cleared) && stage.var_dd54a13b[activecamo.baseweapon].cleared) {
            if(stage.info.statname === statname) {
              var_5c900b6e = 1;
            }

            continue;
          }

          lastvalue = stage.var_dd54a13b[activecamo.baseweapon].statvalue;

          if(isDefined(stage.info.permanentstatname) && activecamo.var_dd54a13b[activecamo.baseweapon].owned === 1) {
            if(stage.info.statname == statname) {
              if(self stats::function_dad108fa(stage.info.permanentstatname, value)) {
                stage.var_dd54a13b[activecamo.baseweapon].statvalue = self stats::get_stat_global(stage.info.permanentstatname);
              }
            }
          } else if(isDefined(stage.info.statname)) {
            if(isDefined(activecamo.info.var_2034fabe) && activecamo.info.var_2034fabe) {
              if(!(isDefined(activecamo.var_dd54a13b[activecamo.baseweapon].var_8fc208a8) && activecamo.var_dd54a13b[activecamo.baseweapon].var_8fc208a8)) {
                continue;
              }
            }

            if(isDefined(stage.info.permanent) && stage.info.permanent && activecamo.var_dd54a13b[activecamo.baseweapon].owned === 1) {
              if(self stats::function_dad108fa(statname, value)) {
                stage.var_dd54a13b[activecamo.baseweapon].statvalue = self stats::get_stat_global(statname);
              }
            } else if(stage.info.statname == statname) {
              stage.var_dd54a13b[activecamo.baseweapon].statvalue += value;
            }
          }

          var_804a253 = stage.var_dd54a13b[activecamo.baseweapon].statvalue > lastvalue;

          if(var_804a253) {
            var_7a414d4a = 1;

            if(isDefined(activecamo.info.isimpulse) && activecamo.info.isimpulse) {
              var_7cbc8452 = 1;
              self thread function_a6bcf0e2(activecamo);
            }

            if(sessionmodeismultiplayergame()) {
              if(activecamoinfo.name == #"activecamoinfo_t8_darkmatter") {
                if(stagenum == 1 && stage.var_dd54a13b[activecamo.baseweapon].statvalue == 5) {
                  self stats::function_dad108fa(#"hash_51eff59939399dc9", 1);
                } else if(stagenum == 5 && stage.var_dd54a13b[activecamo.baseweapon].statvalue == 5) {
                  self function_c0fa0ecb(weapon);
                }
              } else if(activecamoinfo.name == #"activecamoinfo_t8_gold") {
                if(stagenum == 1 && stage.var_dd54a13b[activecamo.baseweapon].statvalue == 1) {
                  self stats::function_dad108fa(#"hash_354bfe5c140365bf", 1);
                }
              }
            }
          }

          if(isDefined(activecamo.info.istiered) && activecamo.info.istiered) {
            break;
          }
        }

        if(var_7a414d4a) {
          var_15838be3 = self function_b9119037(activecamo);
        }

        if(!var_15838be3 && var_5c900b6e && !var_7cbc8452 && isDefined(activecamo.isimpulse) && activecamo.isimpulse) {
          var_7cbc8452 = 1;
          self thread function_a6bcf0e2(activecamo);
        }
      }

      if(statname == #"kills") {
        self function_36feaf9e(activecamo, value, activecamo.weapon);
      }
    }
  }
}

function_94c2605(weapon) {
  if(isDefined(weapon)) {
    if(level.weaponnone != weapon) {
      activecamoweapon = weapon;

      if(activecamoweapon.inventorytype == "dwlefthand") {
        if(isDefined(activecamoweapon.dualwieldweapon) && level.weaponnone != activecamoweapon.dualwieldweapon) {
          activecamoweapon = activecamoweapon.dualwieldweapon;
        }
      }

      if(activecamoweapon.isaltmode) {
        if(isDefined(activecamoweapon.altweapon) && level.weaponnone != activecamoweapon.altweapon) {
          activecamoweapon = activecamoweapon.altweapon;
        }
      }

      return activecamoweapon;
    }
  }

  return weapon;
}

function_a6bcf0e2(activecamo) {
  self impulseactivecamo(activecamo.weapon);
}

function_f0d83504(activecamo, stage, stagenum) {
  self setactivecamostage(activecamo.weapon, stagenum, 1, isDefined(stage.var_dd54a13b[activecamo.baseweapon].cleared) && stage.var_dd54a13b[activecamo.baseweapon].cleared);
}

function_e44edbd1(activecamo) {
  if(isDefined(activecamo.info.istiered) && activecamo.info.istiered) {
    var_e92afc26 = 0;

    for(stagenum = activecamo.stages.size - 1; stagenum >= 0; stagenum--) {
      stage = activecamo.stages[stagenum];

      if(stage.info.var_e2dbd42d > 0 && stage.var_dd54a13b[activecamo.baseweapon].statvalue >= stage.info.var_e2dbd42d) {
        if(var_e92afc26 < stagenum) {
          var_e92afc26 = stagenum;
        }
      }

      if(stagenum < var_e92afc26) {
        stage.var_dd54a13b[activecamo.baseweapon].statvalue = stage.info.var_e2dbd42d;
      }
    }

    self function_b9119037(activecamo);
  }

  if(isDefined(activecamo.info.var_2034fabe) && activecamo.info.var_2034fabe) {
    activecamo.var_dd54a13b[activecamo.baseweapon].var_8fc208a8 = 0;
    self function_b9119037(activecamo);
  }
}

function_b9119037(activecamo) {
  if(!isDefined(activecamo.baseweapon) || !isDefined(activecamo.var_dd54a13b[activecamo.baseweapon])) {
    return;
  }

  if(isDefined(activecamo.info.istiered) && activecamo.info.istiered) {
    stagenum = 0;

    foreach(key, stage in activecamo.stages) {
      if(!isDefined(stage.var_dd54a13b[activecamo.baseweapon])) {
        continue;
      }

      stagenum = key;

      if(stage.var_dd54a13b[activecamo.baseweapon].statvalue >= stage.info.var_e2dbd42d) {
        stage.var_dd54a13b[activecamo.baseweapon].cleared = 1;

        if(activecamo.info.var_9ae5a2b8 === 1 && stagenum == activecamo.stages.size - 1) {
          var_c70461e6 = 1;
          break;
        }

        continue;
      }

      break;
    }

    if(var_c70461e6 === 1) {
      var_2cc4646f = 0;

      foreach(key, stage in activecamo.stages) {
        if(!isDefined(stage.var_dd54a13b[activecamo.baseweapon])) {
          continue;
        }

        if(!var_2cc4646f) {
          if(stage.info.var_c33fcb85 === 1) {
            var_2cc4646f = 1;
            stagenum = key;
          } else {
            continue;
          }
        }

        stage.var_dd54a13b[activecamo.baseweapon].statvalue = 0;
        stage.var_dd54a13b[activecamo.baseweapon].cleared = undefined;
        stage.resettime = undefined;
      }

      if(var_2cc4646f) {
        return set_stage_activecamo(activecamo, stagenum);
      }
    } else {
      weaponoptions = self getweaponoptions(activecamo.weapon);
      weaponstage = getactivecamostage(weaponoptions);

      if(weaponstage != stagenum || activecamo.var_dd54a13b[activecamo.baseweapon].stagenum !== stagenum) {
        return set_stage_activecamo(activecamo, stagenum);
      }
    }

    return 0;
  }

  if(isDefined(activecamo.info.var_2034fabe) && activecamo.info.var_2034fabe) {
    if(!(isDefined(activecamo.var_dd54a13b[activecamo.baseweapon].var_8fc208a8) && activecamo.var_dd54a13b[activecamo.baseweapon].var_8fc208a8)) {
      var_8fc208a8 = 1;

      foreach(key, stage in activecamo.stages) {
        if(isDefined(stage.info.permanentstatname)) {
          if(!isDefined(stage.var_dd54a13b[activecamo.baseweapon])) {
            continue;
          }

          if(stage.var_dd54a13b[activecamo.baseweapon].statvalue >= stage.info.var_e2dbd42d) {
            stage.var_dd54a13b[activecamo.baseweapon].cleared = 1;
          }

          if(!(isDefined(stage.var_dd54a13b[activecamo.baseweapon].cleared) && stage.var_dd54a13b[activecamo.baseweapon].cleared)) {
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

    if(isDefined(activecamo.var_dd54a13b[activecamo.baseweapon].var_8fc208a8) && activecamo.var_dd54a13b[activecamo.baseweapon].var_8fc208a8) {
      for(stagenum = activecamo.stages.size - 1; stagenum >= 0; stagenum--) {
        stage = activecamo.stages[stagenum];

        if(!isDefined(stage.var_dd54a13b[activecamo.baseweapon])) {
          continue;
        }

        if(!(isDefined(stage.var_dd54a13b[activecamo.baseweapon].cleared) && stage.var_dd54a13b[activecamo.baseweapon].cleared) && stage.var_dd54a13b[activecamo.baseweapon].statvalue >= stage.info.var_e2dbd42d) {
          stage.var_dd54a13b[activecamo.baseweapon].cleared = 1;
          var_42d9b149 = stagenum;
          break;
        }
      }

      foreach(key, stage in activecamo.stages) {
        if(isDefined(stage.info.permanentstatname)) {
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

    weaponoptions = self getweaponoptions(activecamo.weapon);
    weaponstage = getactivecamostage(weaponoptions);

    if(weaponstage != var_42d9b149 || activecamo.var_dd54a13b[activecamo.baseweapon].stagenum !== var_42d9b149) {
      return set_stage_activecamo(activecamo, var_42d9b149);
    }
  }

  return 0;
}

set_stage_activecamo(activecamo, stagenum) {
  setstage = activecamo.stages[stagenum];

  if(!isDefined(setstage)) {
    return false;
  }

  activecamo.var_dd54a13b[activecamo.baseweapon].stagenum = stagenum;
  self setactivecamostage(activecamo.weapon, stagenum);

  if(isDefined(setstage.info.var_19b6044e)) {
    self setcamo(activecamo.weapon, setstage.info.var_19b6044e);
  }

  self debug_print("<dev string:x38>" + activecamo.info.name + "<dev string:x1eb>" + stagenum + "<dev string:x1fa>" + (isDefined(setstage.info.var_19b6044e) ? setstage.info.var_19b6044e : "<dev string:x20b>"));

  self thread function_a80cb651(activecamo, stagenum);
  return true;
}

function_a80cb651(activecamo, stagenum) {
  self notify("4be8cd84d8f00caa");
  self endon("4be8cd84d8f00caa");
  self endon(#"new_stage", #"death");
  stage = activecamo.stages[stagenum];

  if(stage.info.resettimer == 0 && !isDefined(stage.info.resetnotify)) {
    return;
  }

  weapon = activecamo.weapon;

  while(true) {
    if(stage.info.resettimer > 0 && isDefined(stage.info.resetnotify)) {
      stage.resettime = gettime() + stage.info.resettimer;
      s_result = self waittilltimeout(float(stage.info.resettimer) / 1000, stage.info.resetnotify);
    } else if(stage.info.resettimer > 0) {
      stage.resettime = gettime() + stage.info.resettimer;
      wait float(stage.info.resettimer) / 1000;
    } else {
      s_result = self waittill(stage.info.resetnotify);
    }

    baseweapon = function_c14cb514(weapon);

    if(!isDefined(s_result) || !isDefined(s_result.weapon) || baseweapon == s_result.weapon) {
      break;
    }
  }

  activecamo.weapon = weapon;
  activecamo.baseweapon = baseweapon;

  if(isDefined(stage.var_dd54a13b[activecamo.baseweapon].cleared) && stage.var_dd54a13b[activecamo.baseweapon].cleared) {
    return;
  }

  stage.var_dd54a13b[activecamo.baseweapon].statvalue = 0;
  stage.var_dd54a13b[activecamo.baseweapon].cleared = undefined;
  stage.resettime = undefined;
  self init_stages(activecamo, 1, 0);
}

debug_error(message, weapon) {
  if(getdvarint(#"activecamo_debug", 0) > 0) {
    weaponname = "<dev string:x217>";

    if(isDefined(weapon)) {
      weaponname = "<dev string:x21a>" + function_9e72a96(weapon.name);
    }

    self iprintlnbold("<dev string:x227>" + message + weaponname);
    println("<dev string:x247>" + self.playername + "<dev string:x25c>" + message + weaponname);
  }
}

debug_print(message, weapon) {
  if(getdvarint(#"activecamo_debug", 0) > 0) {
    weaponname = "<dev string:x217>";

    if(isDefined(weapon)) {
      weaponname = "<dev string:x21a>" + function_9e72a96(weapon.name);
    }

    self iprintlnbold("<dev string:x247>" + message + weaponname);
    println("<dev string:x247>" + self.playername + "<dev string:x25c>" + message + weaponname);
  }
}

function_265047c1() {
  callback::on_connect(&on_player_connect);
  callback::on_disconnect(&on_player_disconnect);
  level.var_630fbd77 = "<dev string:x261>";
  root = "<dev string:x27f>" + level.var_630fbd77;
  function_1039ce5c(root);
  thread devgui_think();
}

on_player_connect() {
  if(self getentnum() < 4) {
    self thread devgui_player_connect();
  }
}

on_player_disconnect() {
  if(self getentnum() < 4) {
    self thread devgui_player_disconnect();
  }
}

devgui_player_connect() {
  if(!isDefined(level.var_630fbd77)) {
    return;
  }

  wait 2;
  root = level.var_630fbd77 + "<dev string:x28d>";
  players = getplayers();

  for(i = 0; i < players.size; i++) {
    if(players[i] != self) {
      continue;
    }

    thread devgui_add_player_commands(root, players[i].playername, i + 1);
    return;
  }
}

devgui_player_disconnect() {
  if(!isDefined(level.var_630fbd77)) {
    return;
  }

  root = level.var_630fbd77 + "<dev string:x28d>";
  cmd = "<dev string:x298>" + root + self.playername + "<dev string:x2a9>";
  thread util::add_debug_command(cmd);
}

devgui_add_player_commands(root, pname, index) {
  add_cmd_with_root = "<dev string:x27f>" + root + pname + "<dev string:x2ae>";
  pid = "<dev string:x217>" + index;
  function_f1d01720(add_cmd_with_root, index);
  function_85cb822d(add_cmd_with_root, index);
  function_de358bfd(add_cmd_with_root, index);
  function_50d79d31(add_cmd_with_root, index);
}

function_1039ce5c(root) {
  cmd = root + "<dev string:x2b2>" + "<dev string:x2c1>";
  thread util::add_debug_command(cmd);
}

function_f1d01720(root, index) {
  var_37949de1 = root;

  if(!isDefined(index)) {
    index = 0;
  }

  cmd = root + "<dev string:x2e3>" + "<dev string:x2ed>" + index + "<dev string:x322>";
  thread util::add_debug_command(cmd);
  cmd = root + "<dev string:x328>" + "<dev string:x334>" + index + "<dev string:x322>";
  thread util::add_debug_command(cmd);
  cmd = root + "<dev string:x366>" + "<dev string:x370>" + index + "<dev string:x322>";
  thread util::add_debug_command(cmd);
}

function_85cb822d(root, index) {
  var_37949de1 = root + "<dev string:x3a0>";

  if(!isDefined(index)) {
    index = 0;
  }

  activecamos = function_2c48197b();

  foreach(activecamo in activecamos) {
    activecamoname = function_9e72a96(activecamo);
    cmd = var_37949de1 + activecamoname + "<dev string:x3a9>" + activecamoname + "<dev string:x3d9>" + index + "<dev string:x322>";
    thread util::add_debug_command(cmd);
  }
}

function_de358bfd(root, index) {
  var_1520a1da = root + "<dev string:x3f3>";

  if(!isDefined(index)) {
    index = 0;
  }

  weapons = [];
  weapons[0] = "<dev string:x3fe>";
  weapons[1] = "<dev string:x40f>";
  weapons[2] = "<dev string:x425>";
  weapons[3] = "<dev string:x434>";

  foreach(weapon in weapons) {
    cmd = var_1520a1da + weapon + "<dev string:x443>" + weapon + "<dev string:x3d9>" + index + "<dev string:x322>";
    thread util::add_debug_command(cmd);
  }
}

function_50d79d31(root, index) {
  var_82c49718 = root + "<dev string:x476>";

  if(!isDefined(index)) {
    index = 0;
  }

  stages = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

  foreach(stage in stages) {
    cmd = var_82c49718 + stage + "<dev string:x483>" + stage + "<dev string:x3d9>" + index + "<dev string:x322>";
    thread util::add_debug_command(cmd);
  }
}

devgui_think() {
  for(;;) {
    wait 0.5;
    reset = 1;
    host = util::gethostplayer();

    switch (getdvarstring(#"hash_3e1bb44a57b02ed8")) {
      case 0:
        reset = 0;
        break;
      case #"debugprints":
        setdvar(#"activecamo_debug", !getdvarint(#"activecamo_debug", 0));
        break;
      case #"reset":
        function_cc5baf7f(&function_58719455);
        break;
      case #"impulse":
        function_cc5baf7f(&function_382462ff);
        break;
      case #"stage_next":
        function_cc5baf7f(&function_3ac4d286, 0);
        break;
      case #"stage_prev":
        function_cc5baf7f(&function_3ac4d286, 1);
        break;
      case #"set_camo":
        function_cc5baf7f(&function_9c361e56, getdvarstring(#"hash_3fe8dd280c325e8"));
        break;
      case #"give_weapon":
        function_cc5baf7f(&function_cc486b05, getdvarstring(#"hash_3fe8dd280c325e8"));
        break;
      case #"set_stage":
        function_cc5baf7f(&function_779a9561, getdvarstring(#"hash_3fe8dd280c325e8"));
        break;
    }

    if(reset) {
      setdvar(#"hash_3e1bb44a57b02ed8", "<dev string:x217>");
      setdvar(#"hash_3fe8dd280c325e8", "<dev string:x217>");
      setdvar(#"hash_324a391b56cb100", "<dev string:x217>");
    }
  }
}

function_cc5baf7f(callback, par) {
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

function_cc486b05(weaponname) {
  weapon = getweapon(weaponname);
  self giveweapon(weapon);
  self switchtoweapon(weapon);
}

function_779a9561(stagenum) {
  weapon = self getcurrentweapon();
  weapon = function_94c2605(weapon);
  activecamoinfo = weapon_get_activecamo(weapon);

  if(isDefined(activecamoinfo)) {
    activecamo = self.pers[#"activecamo"][activecamoinfo.name];

    if(isDefined(activecamo) && isDefined(activecamo.stages) && stagenum < activecamo.stages.size) {
      activecamo.weapon = weapon;
      activecamo.baseweapon = function_c14cb514(activecamo.weapon);

      if(isDefined(activecamo.info.istiered) && activecamo.info.istiered) {
        foreach(key, stage in activecamo.stages) {
          statcount = 0;

          if(key < stagenum) {
            statcount = stage.info.var_e2dbd42d;
          }

          if(isDefined(stage.info.permanentstatname)) {
            self stats::set_stat_global(stage.info.permanentstatname, statcount);
          } else if(isDefined(stage.info.statname)) {
            if(isDefined(stage.info.permanent) && stage.info.permanent) {
              self stats::set_stat_global(stage.info.statname, statcount);
            }
          }

          stage.var_dd54a13b[activecamo.baseweapon].statvalue = statcount;
          stage.var_dd54a13b[activecamo.baseweapon].cleared = undefined;
        }
      } else if(isDefined(activecamo.info.var_2034fabe) && activecamo.info.var_2034fabe) {
        activecamo.var_dd54a13b[activecamo.baseweapon].var_8fc208a8 = undefined;

        foreach(key, stage in activecamo.stages) {
          statcount = 0;

          if(key < stagenum) {
            statcount = stage.info.var_e2dbd42d;
          }

          if(isDefined(stage.info.permanentstatname)) {
            self stats::set_stat_global(stage.info.permanentstatname, statcount);
          } else if(isDefined(stage.info.statname)) {
            statcount = 0;

            if(key == stagenum) {
              statcount = stage.info.var_e2dbd42d;
            }

            if(isDefined(stage.info.permanent) && stage.info.permanent) {
              self stats::set_stat_global(stage.info.statname, statcount);
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

function_9c361e56(activecamoname) {
  activecamoinfo = getscriptbundle(activecamoname);
  weapon = self getcurrentweapon();

  if(isDefined(activecamoinfo)) {
    self init_activecamo(weapon, activecamoinfo, 1);
  }
}

function_3ac4d286(back) {
  weapon = self getcurrentweapon();
  self function_633fbf17(weapon, back);
}

function_633fbf17(weapon, back) {
  if(isDefined(weapon)) {
    self function_8d3b94ea(weapon, 1);
    weapon = function_94c2605(weapon);
    activecamoinfo = weapon_get_activecamo(weapon);

    if(isDefined(activecamoinfo)) {
      activecamo = self.pers[#"activecamo"][activecamoinfo.name];

      if(isDefined(activecamo)) {
        if(isDefined(activecamo.stages)) {
          activecamo.weapon = weapon;
          activecamo.baseweapon = function_c14cb514(activecamo.weapon);
          currentstage = isDefined(activecamo.var_dd54a13b[activecamo.baseweapon].stagenum) ? activecamo.var_dd54a13b[activecamo.baseweapon].stagenum : -1;

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

function_58719455() {
  weapon = self getcurrentweapon();
  self function_3d928fb4(weapon);
}

function_3d928fb4(weapon) {
  if(isDefined(weapon)) {
    self function_8d3b94ea(weapon, 1);
    weapon = function_94c2605(weapon);
    activecamoinfo = weapon_get_activecamo(weapon);

    if(isDefined(activecamoinfo)) {
      activecamo = self.pers[#"activecamo"][activecamoinfo.name];

      if(isDefined(activecamo)) {
        activecamo.weapon = weapon;
        activecamo.baseweapon = function_c14cb514(activecamo.weapon);
        self function_9fc8a57c(activecamo);
      }
    }
  }
}

function_9fc8a57c(activecamo) {
  if(isDefined(activecamo)) {
    if(isDefined(activecamo.stages)) {
      foreach(stagenum, stage in activecamo.stages) {
        self function_dc6014e8(activecamo, stage, stagenum);
      }

      self init_stages(activecamo, 1, 0);
    }
  }
}

function_dc6014e8(activecamo, stage, stagenum) {
  if(isDefined(stage.info.permanentstatname)) {
    self stats::set_stat_global(stage.info.permanentstatname, 0);
    return;
  }

  if(isDefined(stage.info.statname)) {
    if(isDefined(stage.info.permanent) && stage.info.permanent) {
      self stats::set_stat_global(stage.info.statname, 0);
    }
  }
}

function_382462ff() {
  weapon = self getcurrentweapon();
  self function_14a9eb5b(weapon);
}

function_14a9eb5b(weapon) {
  if(isDefined(weapon)) {
    self function_8d3b94ea(weapon, 1);
    weapon = function_94c2605(weapon);
    activecamoinfo = weapon_get_activecamo(weapon);

    if(isDefined(activecamoinfo)) {
      activecamo = self.pers[#"activecamo"][activecamoinfo.name];

      if(isDefined(activecamo)) {
        activecamo.weapon = weapon;
        activecamo.baseweapon = function_c14cb514(activecamo.weapon);
        self function_a6bcf0e2(activecamo);
      }
    }
  }
}

