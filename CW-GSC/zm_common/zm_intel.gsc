/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\zm_intel.gsc
***********************************************/

#using script_176597095ddfaa17;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\item_drop;
#using scripts\core_common\item_world;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\zm_ping;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_vo;
#namespace zm_intel;

function private autoexec __init__system__() {
  system::register(#"zm_intel", &preinit, &postinit, undefined, #"content_manager");
}

function preinit() {
  clientfield::register("scriptmover", "" + # "hash_475f3329eaf62eaf", 1, 1, "int");
  clientfield::register("toplayer", "" + # "hash_1a818fdb4337dc5e", 1, 1, "counter");
  clientfield::register("toplayer", "" + # "hash_711c8fee28432b7", 1, getminbitcountfornum(28), "int");
  level.var_238bd723 = struct::get_script_bundle_instances("zmintel");
  level.var_14e8600c = 6;
  level.var_eb704e15 = [];
  level.var_35aa6043 = [];
  level.var_54f9341 = function_9b30a057();
  level.var_731907e8 = level.var_54f9341.size;

  if(!isDefined(level.var_df1d1235)) {
    level.var_df1d1235 = 0;
  }

  callback::on_connect(&on_connect);
  callback::on_spawned(&function_9799c283);
  callback::on_ai_killed(&on_ai_killed);
  callback::on_item_pickup(&function_b0049c2a);
  level thread function_696dd88b();
  level thread function_aa317cfe();

  level thread function_ded2880a();
}

function postinit() {}

function private function_9b30a057() {
  var_ce9ccdf6 = getscriptbundles(#"zmintel");
  var_a2b0b0d1 = [];

  foreach(var_19a3087c in var_ce9ccdf6) {
    if(zm_utility::is_survival()) {
      if(var_19a3087c.var_824079e7 === # "survival" && function_46181f8c(var_19a3087c) && function_fe74d984(var_19a3087c)) {
        if(!isDefined(var_a2b0b0d1)) {
          var_a2b0b0d1 = [];
        } else if(!isarray(var_a2b0b0d1)) {
          var_a2b0b0d1 = array(var_a2b0b0d1);
        }

        if(!isinarray(var_a2b0b0d1, hash(var_19a3087c.name))) {
          var_a2b0b0d1[var_a2b0b0d1.size] = hash(var_19a3087c.name);
        }
      }

      continue;
    }

    if(var_19a3087c.mapname === level.script && function_46181f8c(var_19a3087c) && function_fe74d984(var_19a3087c)) {
      if(!isDefined(var_a2b0b0d1)) {
        var_a2b0b0d1 = [];
      } else if(!isarray(var_a2b0b0d1)) {
        var_a2b0b0d1 = array(var_a2b0b0d1);
      }

      if(!isinarray(var_a2b0b0d1, hash(var_19a3087c.name))) {
        var_a2b0b0d1[var_a2b0b0d1.size] = hash(var_19a3087c.name);
      }
    }
  }

  return var_a2b0b0d1;
}

function function_43abed5a(var_d5fa8477) {
  if(!isDefined(level.var_54f9341)) {
    level.var_54f9341 = function_9b30a057();
  }

  return isDefined(var_d5fa8477) && isinarray(level.var_54f9341, hash(var_d5fa8477));
}

function private function_32b4eecc() {
  var_731907e8 = 0;

  foreach(var_d5fa8477 in level.var_54f9341) {
    if(self function_f0f36d47(var_d5fa8477)) {
      var_731907e8++;
    }
  }

  return var_731907e8;
}

function private function_fe74d984(var_37a01ce0) {
  if(isstring(var_37a01ce0) || ishash(var_37a01ce0)) {
    var_19a3087c = getscriptbundle(var_37a01ce0);
  } else {
    var_19a3087c = var_37a01ce0;
  }

  return true;
}

function private function_46181f8c(var_37a01ce0) {
  if(isstring(var_37a01ce0) || ishash(var_37a01ce0)) {
    var_19a3087c = getscriptbundle(var_37a01ce0);
  } else {
    var_19a3087c = var_37a01ce0;
  }

  if(!isDefined(var_19a3087c.season) || var_19a3087c.season <= level.var_14e8600c) {
    return true;
  }

  return false;
}

function function_88645994(var_6f94d397, var_c14aedb3, var_539eabc0, var_765715e3, var_d5f7338b, var_cb9b032f, var_e082343f, var_3e815633, var_baa9c135) {
  level.var_9ff51719 = var_6f94d397;
  level.var_64d3d5c4 = var_c14aedb3;
  level.var_13ebf509 = var_539eabc0;
  level.var_1e898375 = var_765715e3;
  level.var_b131552c = var_d5f7338b;
  level.var_a62e1750 = var_cb9b032f;
  level.var_bc543de = var_e082343f;
  level.var_fc3c65a7 = var_3e815633;
  level.var_4b66954c = var_baa9c135;
}

function private on_connect() {
  self.var_9d781602 = [];

  if(!isDefined(self.var_e2d764da)) {
    self.var_e2d764da = 0;
  }

  if(!isDefined(self.var_b21b857[# "requiem"])) {
    self.var_b21b857[# "requiem"] = 0;
  }

  if(!isDefined(self.var_b21b857[# "maxis"])) {
    self.var_b21b857[# "maxis"] = 0;
  }

  if(!isDefined(self.var_b21b857[# "omega"])) {
    self.var_b21b857[# "omega"] = 0;
  }
}

function function_9799c283() {
  if(level flag::get(#"spawn_intel_at_start_complete") && !is_true(self.var_d02cff4e)) {
    foreach(var_495fa1f8 in level.var_238bd723) {
      if(isDefined(var_495fa1f8.mdl_intel)) {
        if(isarray(var_495fa1f8.var_de540b3a)) {
          if(self function_f0f36d47(var_495fa1f8.scriptbundlename)) {
            continue;
          }

          arrayremovevalue(var_495fa1f8.var_de540b3a, undefined);

          foreach(var_6a51d7c1 in var_495fa1f8.var_de540b3a) {
            if(isDefined(var_6a51d7c1.var_b09e2381) && self.name != var_495fa1f8.mdl_intel.var_b09e2381) {
              var_6a51d7c1 hidefromplayer(self);

              if(!isDefined(var_6a51d7c1.var_699c6bfb)) {
                var_6a51d7c1.var_699c6bfb = [];
              } else if(!isarray(var_6a51d7c1.var_699c6bfb)) {
                var_6a51d7c1.var_699c6bfb = array(var_6a51d7c1.var_699c6bfb);
              }

              if(!isinarray(var_6a51d7c1.var_699c6bfb, self)) {
                var_6a51d7c1.var_699c6bfb[var_6a51d7c1.var_699c6bfb.size] = self;
              }
            }
          }

          var_495fa1f8.mdl_intel = function_2ba45c94(var_495fa1f8.scriptbundlename, var_495fa1f8.origin, var_495fa1f8.angles, (64, 64, 64), undefined, undefined, self.name, 0);

          if(!isDefined(var_495fa1f8.var_de540b3a)) {
            var_495fa1f8.var_de540b3a = [];
          } else if(!isarray(var_495fa1f8.var_de540b3a)) {
            var_495fa1f8.var_de540b3a = array(var_495fa1f8.var_de540b3a);
          }

          if(!isinarray(var_495fa1f8.var_de540b3a, var_495fa1f8.mdl_intel)) {
            var_495fa1f8.var_de540b3a[var_495fa1f8.var_de540b3a.size] = var_495fa1f8.mdl_intel;
          }

          var_495fa1f8.mdl_intel.var_d86211f5 = 1;
        } else if(self function_f0f36d47(var_495fa1f8.mdl_intel.var_d5fa8477) || isDefined(var_495fa1f8.mdl_intel.var_b09e2381) && self.name != var_495fa1f8.mdl_intel.var_b09e2381) {
          var_495fa1f8.mdl_intel hidefromplayer(self);
        }

        continue;
      }

      if(is_true(var_495fa1f8.script_enable_on_start)) {
        var_495fa1f8 thread function_23255935();
      }
    }

    arrayremovevalue(level.var_35aa6043, undefined);

    foreach(var_db4d0036 in level.var_35aa6043) {
      if(is_true(var_db4d0036.var_d86211f5)) {
        continue;
      }

      if(self function_f0f36d47(var_db4d0036.var_d5fa8477) || isDefined(var_db4d0036.var_b09e2381) && self.name != var_db4d0036.var_b09e2381) {
        var_db4d0036 hidefromplayer(self);

        if(!isDefined(var_db4d0036.var_699c6bfb)) {
          var_db4d0036.var_699c6bfb = [];
        } else if(!isarray(var_db4d0036.var_699c6bfb)) {
          var_db4d0036.var_699c6bfb = array(var_db4d0036.var_699c6bfb);
        }

        if(!isinarray(var_db4d0036.var_699c6bfb, self)) {
          var_db4d0036.var_699c6bfb[var_db4d0036.var_699c6bfb.size] = self;
        }
      }
    }
  }

  self.var_d02cff4e = 1;
}

function function_aa317cfe() {
  level flag::wait_till("start_zombie_round_logic");
  var_80198f58 = struct::get_array("zm_intel_radio_transmission_locations");

  foreach(var_41c6d68b in var_80198f58) {
    if(!isDefined(var_41c6d68b.faction)) {
      var_41c6d68b.faction = isDefined(var_41c6d68b.script_string) ? var_41c6d68b.script_string : "";
    }

    switch (var_41c6d68b.faction) {
      case # "requiem":
        var_bed5445b = # "p9_zm_ndu_radio_transmissions_r";
        var_32edbef9 = # "hash_405e81feb85c5162";
        break;
      case # "maxis":
        var_bed5445b = # "p9_zm_ndu_radio_transmissions";
        var_32edbef9 = # "hash_6fec31948ca2058c";
        break;
      case # "omega":
        var_bed5445b = # "p9_zm_ndu_radio_transmissions_o";
        var_32edbef9 = # "hash_28fec49f37a535b9";
        break;
    }

    if(!isDefined(var_32edbef9)) {
      continue;
    }

    var_41c6d68b.mdl_intel = util::spawn_model(isDefined(var_41c6d68b.model) ? var_41c6d68b.model : var_bed5445b, var_41c6d68b.origin, var_41c6d68b.angles);

    if(isDefined(var_41c6d68b.modelscale) && var_41c6d68b.modelscale != 1) {
      var_41c6d68b.mdl_intel setscale(var_41c6d68b.modelscale);
    }

    var_41c6d68b.mdl_intel.var_32edbef9 = var_32edbef9;
    var_41c6d68b.mdl_intel.var_9be0526e = # "hash_20ea75a25d912949";
    var_41c6d68b.mdl_intel.faction = var_41c6d68b.faction;
    var_41c6d68b.mdl_intel.var_71396476 = 1;
    var_41c6d68b.mdl_intel function_619a5c20();
    var_41c6d68b.mdl_intel zm_ping::function_9e0598bb(6);

    if(isDefined(var_41c6d68b.var_75b8887d) && var_41c6d68b.var_75b8887d != (0, 0, 0)) {
      dimensions = var_41c6d68b.var_75b8887d;
    } else if(isDefined(var_41c6d68b.radius) && var_41c6d68b.radius != 0) {
      dimensions = var_41c6d68b.radius;
    }

    var_41c6d68b.mdl_intel zm_unitrigger::create(&function_8176b2c7, isDefined(dimensions) ? dimensions : (64, 64, 64), &function_a78987b);
    zm_unitrigger::unitrigger_force_per_player_triggers(var_41c6d68b.mdl_intel.s_unitrigger, 1);
    zm_unitrigger::function_89380dda(var_41c6d68b.mdl_intel.s_unitrigger);
  }
}

function function_696dd88b() {
  level flag::wait_till("start_zombie_round_logic");

  foreach(var_495fa1f8 in level.var_238bd723) {
    if(is_true(var_495fa1f8.script_enable_on_start)) {
      var_495fa1f8 thread function_23255935();
    }
  }

  level flag::set("spawn_intel_at_start_complete");
}

function function_23255935(str_targetname) {
  s_intel = self;

  if(isDefined(str_targetname)) {
    s_intel = struct::get(str_targetname);
  }

  var_d5fa8477 = s_intel.scriptbundlename;

  if(!function_43abed5a(var_d5fa8477)) {
    return;
  }

  if(isDefined(s_intel.scriptbundlename) && !isDefined(s_intel.mdl_intel) && !function_1a594d26(var_d5fa8477)) {
    s_bundle = getscriptbundle(s_intel.scriptbundlename);

    if(isDefined(s_bundle.itemspawnentry)) {
      point = function_4ba8fde(s_bundle.itemspawnentry);

      if(isDefined(point.itementry)) {
        foreach(player in getplayers()) {
          if(isDefined(player) && !player function_f0f36d47(var_d5fa8477)) {
            s_intel.mdl_intel = function_2ba45c94(var_d5fa8477, s_intel.origin, s_intel.angles, (64, 64, 64), undefined, undefined, player.name, 0);

            if(!isDefined(s_intel.var_de540b3a)) {
              s_intel.var_de540b3a = [];
            } else if(!isarray(s_intel.var_de540b3a)) {
              s_intel.var_de540b3a = array(s_intel.var_de540b3a);
            }

            if(!isinarray(s_intel.var_de540b3a, s_intel.mdl_intel)) {
              s_intel.var_de540b3a[s_intel.var_de540b3a.size] = s_intel.mdl_intel;
            }

            s_intel.mdl_intel.var_d86211f5 = 1;
          }
        }

        return;
      } else if(isDefined(s_bundle.model)) {
        s_intel.mdl_intel = util::spawn_model(s_bundle.model, s_intel.origin, s_intel.angles);

        if(!isDefined(level.var_35aa6043)) {
          level.var_35aa6043 = [];
        } else if(!isarray(level.var_35aa6043)) {
          level.var_35aa6043 = array(level.var_35aa6043);
        }

        if(!isinarray(level.var_35aa6043, s_intel.mdl_intel)) {
          level.var_35aa6043[level.var_35aa6043.size] = s_intel.mdl_intel;
        }
      }
    } else if(isDefined(s_bundle.model)) {
      s_intel.mdl_intel = util::spawn_model(s_bundle.model, s_intel.origin, s_intel.angles);

      if(!isDefined(level.var_35aa6043)) {
        level.var_35aa6043 = [];
      } else if(!isarray(level.var_35aa6043)) {
        level.var_35aa6043 = array(level.var_35aa6043);
      }

      if(!isinarray(level.var_35aa6043, s_intel.mdl_intel)) {
        level.var_35aa6043[level.var_35aa6043.size] = s_intel.mdl_intel;
      }
    } else {
      return;
    }

    foreach(player in getplayers()) {
      if(player function_f0f36d47(var_d5fa8477)) {
        s_intel.mdl_intel hidefromplayer(player);
      }
    }

    s_intel.mdl_intel.var_d86211f5 = 1;
    s_intel.mdl_intel function_619a5c20();
    s_intel.mdl_intel zm_ping::function_9e0598bb(6);
    s_intel.mdl_intel.var_d5fa8477 = s_intel.scriptbundlename;
    s_intel.mdl_intel.script_flag_true = s_intel.script_flag_true;
    s_intel.mdl_intel.str_faction = s_bundle.var_ad4ad686;
    s_intel.mdl_intel.var_2b372cf6 = s_bundle.var_9be0526e;
    s_intel.mdl_intel.var_9be0526e = s_bundle.var_9be0526e;

    if(isDefined(s_intel.modelscale) && s_intel.modelscale != 1) {
      s_intel.mdl_intel setscale(s_intel.modelscale);

      if(isarray(s_intel.mdl_intel.var_9981940d)) {
        foreach(var_56541b8b in s_intel.mdl_intel.var_9981940d) {
          var_56541b8b setscale(s_intel.modelscale);
        }
      }
    }

    if(!is_true(s_intel.mdl_intel.var_cbbbaf39)) {
      if(isDefined(s_intel.var_75b8887d) && s_intel.var_75b8887d != (0, 0, 0)) {
        dimensions = s_intel.var_75b8887d;
      } else if(isDefined(s_intel.radius) && s_intel.radius != 0) {
        dimensions = s_intel.radius;
      }

      s_intel.mdl_intel zm_unitrigger::create(&function_8176b2c7, isDefined(dimensions) ? dimensions : (64, 64, 64), &function_a78987b);
      zm_unitrigger::unitrigger_force_per_player_triggers(s_intel.mdl_intel.s_unitrigger, 1);
      zm_unitrigger::function_89380dda(s_intel.mdl_intel.s_unitrigger);
    }

    if(isDefined(s_intel.mdl_intel) && isDefined(s_bundle.soundloop)) {
      s_intel.mdl_intel playLoopSound(s_bundle.soundloop);
    }

    s_intel.mdl_intel thread function_6efd4108();
  }
}

function function_2ba45c94(var_d5fa8477, v_pos, v_ang = (0, 0, 0), var_cd038aea, var_d65061b2 = 0, b_play_fx = 0, var_b09e2381, var_7e1bf71f = 2) {
  if(!function_43abed5a(var_d5fa8477)) {
    return;
  }

  s_bundle = getscriptbundle(var_d5fa8477);

  if(isDefined(s_bundle.itemspawnentry)) {
    point = function_4ba8fde(s_bundle.itemspawnentry);

    if(isDefined(point.itementry)) {
      mdl_intel = item_drop::drop_item(0, undefined, 1, 0, point.id, v_pos, v_ang, var_7e1bf71f);
      mdl_intel.var_d5fa8477 = hash(var_d5fa8477);
      mdl_intel.var_cbbbaf39 = 1;
      mdl_intel.var_b09e2381 = var_b09e2381;

      if(!isDefined(level.var_35aa6043)) {
        level.var_35aa6043 = [];
      } else if(!isarray(level.var_35aa6043)) {
        level.var_35aa6043 = array(level.var_35aa6043);
      }

      if(!isinarray(level.var_35aa6043, mdl_intel)) {
        level.var_35aa6043[level.var_35aa6043.size] = mdl_intel;
      }

      foreach(player in getplayers()) {
        if(player function_f0f36d47(var_d5fa8477) || isDefined(mdl_intel.var_b09e2381) && player.name != mdl_intel.var_b09e2381) {
          mdl_intel hidefromplayer(player);

          if(!isDefined(mdl_intel.var_699c6bfb)) {
            mdl_intel.var_699c6bfb = [];
          } else if(!isarray(mdl_intel.var_699c6bfb)) {
            mdl_intel.var_699c6bfb = array(mdl_intel.var_699c6bfb);
          }

          if(!isinarray(mdl_intel.var_699c6bfb, player)) {
            mdl_intel.var_699c6bfb[mdl_intel.var_699c6bfb.size] = player;
          }
        }
      }
    } else {
      mdl_intel = util::spawn_model(isDefined(s_bundle.model) ? s_bundle.model : "tag_origin", v_pos, v_ang);
      mdl_intel function_619a5c20();
      mdl_intel zm_ping::function_9e0598bb(6);
      mdl_intel.var_d5fa8477 = hash(var_d5fa8477);

      if(!isDefined(level.var_35aa6043)) {
        level.var_35aa6043 = [];
      } else if(!isarray(level.var_35aa6043)) {
        level.var_35aa6043 = array(level.var_35aa6043);
      }

      if(!isinarray(level.var_35aa6043, mdl_intel)) {
        level.var_35aa6043[level.var_35aa6043.size] = mdl_intel;
      }

      var_3e4e3c6a = 1;
    }
  } else {
    mdl_intel = util::spawn_model(isDefined(s_bundle.model) ? s_bundle.model : "tag_origin", v_pos, v_ang);
    mdl_intel.var_d5fa8477 = hash(var_d5fa8477);

    if(!isDefined(level.var_35aa6043)) {
      level.var_35aa6043 = [];
    } else if(!isarray(level.var_35aa6043)) {
      level.var_35aa6043 = array(level.var_35aa6043);
    }

    if(!isinarray(level.var_35aa6043, mdl_intel)) {
      level.var_35aa6043[level.var_35aa6043.size] = mdl_intel;
    }

    var_3e4e3c6a = 1;
  }

  if(var_d65061b2) {
    mdl_intel rotate((0, 90, 0));
    mdl_intel bobbing((0, 0, 1), 2, 1.5);
  }

  if(b_play_fx) {
    mdl_intel clientfield::set("" + # "hash_475f3329eaf62eaf", 1);
  }

  if(is_true(var_3e4e3c6a)) {
    s_unitrigger = mdl_intel zm_unitrigger::create(&function_8176b2c7, isDefined(var_cd038aea) ? var_cd038aea : 100, &function_a78987b);
    zm_unitrigger::unitrigger_force_per_player_triggers(s_unitrigger, 1);
    zm_unitrigger::function_89380dda(s_unitrigger);
  }

  if(isDefined(s_bundle.soundloop)) {
    mdl_intel playLoopSound(s_bundle.soundloop);
  }

  mdl_intel thread function_6efd4108();

  return mdl_intel;
}

function private function_6efd4108() {
  if(!isDefined(self)) {
    return;
  }

  self notify("<dev string:x38>");
  self endon("<dev string:x38>");
  self endon(#"death");

  while(true) {
    if(!getdvarint(#"hash_6aad5d3866085387", 0)) {
      waitframe(1);
      continue;
    }

    var_db08e6c3 = "<dev string:x4c>";

    foreach(player in getplayers()) {
      if(isDefined(self.var_b09e2381) && player.name == self.var_b09e2381 || !isDefined(self.var_b09e2381) && !player function_f0f36d47(self.var_d5fa8477)) {
        v_offset = (player getentitynumber() + 1) * (0, 0, -5);
        print3d(self.origin + v_offset, player.name, (0, 1, 0), undefined, 0.2);
      }
    }

    print3d(self.origin, "<dev string:x50>" + function_9e72a96(self.var_d5fa8477), (0, 1, 0), undefined, 0.2);
    circle(self.origin, 40, (0, 1, 0));
    waitframe(1);
  }
}

function function_c1974629(v_target_loc, n_power = 200) {
  if(isstruct(self)) {
    mdl_intel = self.mdl_intel;
  } else {
    mdl_intel = self;
  }

  if(!isDefined(mdl_intel)) {
    return;
  }

  if(!isDefined(v_target_loc) && isDefined(self.target)) {
    target = getent(self.target, "targetname");

    if(!isDefined(target)) {
      target = struct::get(self.target, "targetname");
    }

    v_target_loc = target.origin;
    var_efc184d0 = target.angles;
  }

  assert(isDefined(v_target_loc), "<dev string:x62>" + function_9e72a96(mdl_intel.var_d5fa8477));

  if(is_true(mdl_intel.var_cbbbaf39)) {
    n_time = mdl_intel zm_utility::fake_physicslaunch(v_target_loc, n_power);
    wait n_time;
    mdl_intel.origin = v_target_loc;

    if(isDefined(var_efc184d0)) {
      mdl_intel.angles = var_efc184d0;
    }

    if(isstruct(self)) {
      self.origin = mdl_intel.origin;
      self.angles = mdl_intel.angles;
    }

    return;
  }

  n_time = mdl_intel zm_utility::fake_physicslaunch(v_target_loc, n_power);
  wait n_time;
  mdl_intel.origin = v_target_loc;

  if(isDefined(var_efc184d0)) {
    mdl_intel.angles = var_efc184d0;
  }

  zm_unitrigger::function_47625e58(mdl_intel.s_unitrigger, mdl_intel.origin, mdl_intel.angles);

  if(isstruct(self)) {
    self.origin = mdl_intel.origin;
    self.angles = mdl_intel.angles;
  }
}

function private function_b0049c2a(params) {
  item = params.item;

  if(isPlayer(self) && isDefined(item.var_d5fa8477) && !self function_f0f36d47(item.var_d5fa8477)) {
    self collect_intel(item.var_d5fa8477, item);
  }
}

function private function_8176b2c7(e_player) {
  mdl_intel = self.stub.related_parent;

  if(isDefined(mdl_intel.script_flag_true) && !level flag::get(mdl_intel.script_flag_true)) {
    mdl_intel ghost();
    mdl_intel notsolid();
    mdl_intel function_23a29590();

    if(isarray(mdl_intel.var_9981940d)) {
      array::run_all(mdl_intel.var_9981940d, &ghost);
    }

    return false;
  } else if(isDefined(mdl_intel.script_flag_true) && level flag::get(mdl_intel.script_flag_true)) {
    mdl_intel function_619a5c20();
    mdl_intel solid();
  }

  if(mdl_intel.var_9be0526e === # "hash_20ea75a25d912949" && level flag::get(#"dark_aether_active")) {
    return false;
  }

  if(isDefined(mdl_intel.var_32edbef9)) {
    if(!isDefined(mdl_intel.var_56c62073)) {
      mdl_intel.var_56c62073 = [];
    }

    if(!isDefined(mdl_intel.var_56c62073[e_player.name]) || isDefined(level.var_fa1d4366)) {
      mdl_intel.var_56c62073[e_player.name] = function_2bcfd899(mdl_intel.var_32edbef9, e_player);
    }

    var_d5fa8477 = mdl_intel.var_56c62073[e_player.name];
  } else {
    var_d5fa8477 = mdl_intel.var_d5fa8477;
  }

  if(!isDefined(var_d5fa8477) || e_player function_f0f36d47(var_d5fa8477) || mdl_intel.var_9be0526e === # "hash_20ea75a25d912949" && e_player.var_b21b857[mdl_intel.faction] >= 1) {
    if(isDefined(var_d5fa8477) && is_true(level.var_eb704e15[var_d5fa8477][e_player.name])) {
      return false;
    } else if(mdl_intel.var_9be0526e === # "hash_20ea75a25d912949") {
      if(e_player function_a3e4f9a1(mdl_intel.var_32edbef9)) {
        self sethintstringforplayer(e_player, #"hash_4c0799e45640f98c");
      } else {
        return false;
      }
    } else {
      mdl_intel hidefromplayer(e_player);
      return false;
    }

    return true;
  }

  mdl_intel showtoplayer(e_player);

  if(isarray(mdl_intel.var_9981940d)) {
    array::run_all(mdl_intel.var_9981940d, &showtoplayer, e_player);
  }

  self sethintstringforplayer(e_player, e_player zm_utility::function_d6046228(#"hash_33ae89d6ac634cd3", #"hash_5ab1861040dfa3f9"));
  return true;
}

function private function_a78987b(e_player) {
  self endon(#"death");
  mdl_intel = self.stub.related_parent;

  while(true) {
    s_waitresult = self waittill(#"trigger");
    e_player = s_waitresult.activator;

    if(isDefined(mdl_intel.var_56c62073[e_player.name])) {
      var_d5fa8477 = mdl_intel.var_56c62073[e_player.name];
    } else {
      var_d5fa8477 = mdl_intel.var_d5fa8477;
    }

    if(!isDefined(var_d5fa8477) || !zm_utility::can_use(e_player, 0) || e_player function_f0f36d47(var_d5fa8477)) {
      continue;
    }

    e_player thread collect_intel(var_d5fa8477, mdl_intel);
  }
}

function collect_intel(var_d5fa8477, mdl_intel, var_eac6151d, var_54c59ebe = 0) {
  if(isstring(var_d5fa8477)) {
    var_d5fa8477 = hash(var_d5fa8477);
  }

  var_65679637 = getscriptbundlenames("<dev string:x8d>");
  assert(isinarray(var_65679637, var_d5fa8477), function_9e72a96(var_d5fa8477) + "<dev string:x98>");

  if(!self function_f0f36d47(var_d5fa8477)) {
    var_f83e960b = 1;

    if(mdl_intel.var_9be0526e === # "hash_20ea75a25d912949") {
      self.var_b21b857[mdl_intel.faction]++;
    }
  }

  self function_7e211a10(var_d5fa8477);
  self zm_stats::function_a6b15f2c(var_d5fa8477, 1);
  self function_bc82f900(#"zm_interact_rumble");

  if(!isDefined(self.var_9d781602)) {
    self.var_9d781602 = [];
  } else if(!isarray(self.var_9d781602)) {
    self.var_9d781602 = array(self.var_9d781602);
  }

  if(!isinarray(self.var_9d781602, var_d5fa8477)) {
    self.var_9d781602[self.var_9d781602.size] = var_d5fa8477;
  }

  self notify(#"intel_collected");

  if(is_true(var_f83e960b)) {
    currentprogress = self function_32b4eecc();
    totalprogress = level.var_731907e8;
    self luinotifyevent(#"hash_c587d2e4faec420", 3, var_d5fa8477, currentprogress, totalprogress);
    self playlocalsound(#"hash_68c4c53739928215");
  }

  iprintln("<dev string:xba>" + self getentitynumber() + "<dev string:xc5>" + function_9e72a96(var_d5fa8477));

  level.var_eb704e15[var_d5fa8477][self.name] = 1;

  if(!var_54c59ebe) {
    self function_3f3be625(var_d5fa8477, isDefined(var_eac6151d) ? var_eac6151d : mdl_intel);
  }

  if(isPlayer(self)) {
    level.var_eb704e15[var_d5fa8477][self.name] = undefined;
  }

  if(isarray(level.var_eb704e15[var_d5fa8477])) {
    foreach(var_f619e4d in level.var_eb704e15[var_d5fa8477]) {
      if(is_true(var_f619e4d)) {
        var_71396476 = 1;
        break;
      }
    }
  }

  if(isDefined(mdl_intel) && !is_true(mdl_intel.var_71396476) && !is_true(var_71396476)) {
    if(function_1a594d26(var_d5fa8477) || isDefined(mdl_intel.var_b09e2381) && isDefined(self.name) && mdl_intel.var_b09e2381 == self.name) {
      if(isDefined(mdl_intel.s_unitrigger)) {
        zm_unitrigger::unregister_unitrigger(mdl_intel.s_unitrigger);
      }

      if(isarray(mdl_intel.var_9981940d)) {
        array::delete_all(mdl_intel.var_9981940d);
        mdl_intel.var_9981940d = undefined;
      }

      if(is_true(mdl_intel.var_cbbbaf39)) {
        item_world::consume_item(mdl_intel);
      } else {
        mdl_intel delete();
      }

      return;
    }

    if(isDefined(mdl_intel) && isPlayer(self)) {
      mdl_intel hidefromplayer(self);
    }
  }
}

function function_7e211a10(var_d5fa8477) {
  if(isDefined(level.var_a62e1750)) {
    var_6c41667f = getscriptbundle(level.var_a62e1750);

    if(isarray(var_6c41667f.var_572513bb) && var_6c41667f.var_572513bb.size) {
      foreach(var_ea06eccb in var_6c41667f.var_572513bb) {
        if(var_ea06eccb.season === # "hash_3c8cc59cdaa4bb29") {
          continue;
        }

        if(isDefined(self) && var_d5fa8477 === hash(var_ea06eccb.var_cb9cd317) && !self function_f0f36d47(var_ea06eccb.var_cb9cd317)) {
          if(is_true(level.var_92c52eed)) {
            self zm_stats::increment_challenge_stat(#"hash_607cee7194682397");
            return;
          }

          if(is_true(level.var_ce7af4fa)) {
            self zm_stats::increment_challenge_stat(#"hash_255cd64167fc9d64");
            return;
          }

          if(is_true(level.var_775a83a7)) {
            self zm_stats::increment_challenge_stat(#"hash_2edbb2ffba8d18c2");
            return;
          }

          if(is_true(level.var_f937a06e)) {
            self zm_stats::increment_challenge_stat(#"hash_444372d7b49ca39a");
          }

          return;
        }
      }
    }
  }

  if(isDefined(level.var_fc3c65a7)) {
    var_bd7c92ca = getscriptbundle(level.var_fc3c65a7);

    if(isarray(var_bd7c92ca.var_572513bb) && var_bd7c92ca.var_572513bb.size) {
      foreach(var_71fdaa63 in var_bd7c92ca.var_572513bb) {
        if(var_71fdaa63.season === # "hash_3c8cc59cdaa4bb29") {
          continue;
        }

        if(isDefined(self) && var_d5fa8477 === hash(var_71fdaa63.var_cb9cd317) && !self function_f0f36d47(var_71fdaa63.var_cb9cd317)) {
          if(is_true(level.var_92c52eed)) {
            self zm_stats::increment_challenge_stat(#"hash_1cb9f04cdc593ac2");
            return;
          }

          if(is_true(level.var_ce7af4fa)) {
            self zm_stats::increment_challenge_stat(#"hash_474edef2893daed1");
            return;
          }

          if(is_true(level.var_f937a06e)) {
            self zm_stats::increment_challenge_stat(#"hash_b672726889db04a");
          }

          return;
        }
      }
    }
  }

  if(isDefined(level.var_bc543de)) {
    var_24cb44c7 = getscriptbundle(level.var_bc543de);

    if(isarray(var_24cb44c7.var_572513bb) && var_24cb44c7.var_572513bb.size) {
      foreach(var_edc4bdb7 in var_24cb44c7.var_572513bb) {
        if(var_edc4bdb7.season === # "hash_3c8cc59cdaa4bb29") {
          continue;
        }

        if(isDefined(self) && var_d5fa8477 === hash(var_edc4bdb7.var_cb9cd317) && !self function_f0f36d47(var_edc4bdb7.var_cb9cd317)) {
          if(is_true(level.var_92c52eed)) {
            self zm_stats::increment_challenge_stat(#"hash_6289f0dc7ba983ec");
            return;
          }

          if(is_true(level.var_ce7af4fa)) {
            self zm_stats::increment_challenge_stat(#"hash_57f49fd5e493248f");
            return;
          }

          if(is_true(level.var_775a83a7)) {
            self zm_stats::increment_challenge_stat(#"hash_c3db4d34d330b35");
            return;
          }

          if(is_true(level.var_f937a06e)) {
            self zm_stats::increment_challenge_stat(#"hash_b672726889db04a");
          }

          return;
        }
      }
    }
  }

  if(isDefined(level.var_4b66954c)) {
    var_16642490 = getscriptbundle(level.var_4b66954c);

    if(isarray(var_16642490.var_572513bb) && var_16642490.var_572513bb.size) {
      foreach(var_32d7f225 in var_16642490.var_572513bb) {
        if(var_32d7f225.season === # "hash_3c8cc59cdaa4bb29") {
          continue;
        }

        if(isDefined(self) && var_d5fa8477 === hash(var_32d7f225.var_cb9cd317) && !self function_f0f36d47(var_32d7f225.var_cb9cd317)) {
          if(is_true(level.var_92c52eed)) {
            self zm_stats::increment_challenge_stat(#"hash_4748a07c715661dc");
            return;
          }

          if(is_true(level.var_ce7af4fa)) {
            self zm_stats::increment_challenge_stat(#"hash_56778cda5cdf54df");
            return;
          }

          if(is_true(level.var_775a83a7)) {
            self zm_stats::increment_challenge_stat(#"hash_3464a638f7ae0cf1");
            return;
          }

          if(is_true(level.var_f937a06e)) {
            self zm_stats::increment_challenge_stat(#"hash_43cf01ce2a0622c9");
          }

          return;
        }
      }
    }
  }
}

function function_a2579c2d(map_name) {
  var_e1227fd2 = function_6f647eeb(level.var_a62e1750);
  var_8c4114bc = function_6f647eeb(level.var_fc3c65a7);
  var_a660a64f = function_6f647eeb(level.var_bc543de);
  var_835505eb = function_6f647eeb(level.var_4b66954c);
  var_4fc22493 = var_8c4114bc + var_a660a64f;

  if(map_name === # "zm_tungsten") {
    self function_4bd91776(#"hash_444372d7b49ca39a", var_e1227fd2);
    self function_4bd91776(#"hash_b672726889db04a", var_4fc22493);
    self function_4bd91776(#"hash_43cf01ce2a0622c9", var_835505eb);
    return;
  }

  if(map_name === # "zm_platinum") {
    self function_4bd91776(#"hash_2edbb2ffba8d18c2", var_e1227fd2);
    self function_4bd91776(#"hash_c3db4d34d330b35", var_a660a64f);
    self function_4bd91776(#"hash_3464a638f7ae0cf1", var_835505eb);
    return;
  }

  if(map_name === # "zm_gold") {
    self function_4bd91776(#"hash_255cd64167fc9d64", var_e1227fd2);
    self function_4bd91776(#"hash_474edef2893daed1", var_8c4114bc);
    self function_4bd91776(#"hash_57f49fd5e493248f", var_a660a64f);
    self function_4bd91776(#"hash_56778cda5cdf54df", var_835505eb);
    return;
  }

  if(map_name === # "zm_silver") {
    self function_4bd91776(#"hash_607cee7194682397", var_e1227fd2);
    self function_4bd91776(#"hash_1cb9f04cdc593ac2", var_8c4114bc);
    self function_4bd91776(#"hash_6289f0dc7ba983ec", var_a660a64f);
    self function_4bd91776(#"hash_4748a07c715661dc", var_835505eb);
  }
}

function function_6f647eeb(var_318b924a) {
  var_33bc9fa1 = 0;

  if(isDefined(var_318b924a)) {
    var_71b26808 = getscriptbundle(var_318b924a);

    if(isarray(var_71b26808.var_572513bb) && var_71b26808.var_572513bb.size) {
      foreach(s_intel in var_71b26808.var_572513bb) {
        if(s_intel.season === # "hash_3c8cc59cdaa4bb29") {
          continue;
        }

        var_89052c1 = self function_f0f36d47(s_intel.var_cb9cd317);

        if(var_89052c1) {
          var_33bc9fa1++;
        }
      }
    }
  }

  return var_33bc9fa1;
}

function function_4bd91776(stat_name, desired_value) {
  var_77a3e2b8 = self stats::get_stat(#"playerstatslist", stat_name, #"challengetier");

  if(!isDefined(var_77a3e2b8)) {
    var_77a3e2b8 = 0;
  }

  if(var_77a3e2b8 == 0 && desired_value > self stats::get_stat(#"playerstatslist", stat_name, #"challengevalue")) {
    self stats::set_stat(#"playerstatslist", stat_name, #"challengevalue", 0);
    self zm_stats::increment_challenge_stat(stat_name, desired_value);
  }
}

function function_f0f36d47(var_d5fa8477) {
  assert(isDefined(var_d5fa8477), "<dev string:xd4>");

  if(self zm_stats::function_376778d3(var_d5fa8477) || isinarray(self.var_9d781602, hash(var_d5fa8477))) {
    return true;
  }

  return false;
}

function function_3a2dd570(e_player) {
  if(isPlayer(e_player)) {
    if(!isPlayer(self) && isDefined(self.var_9be0526e) && self.var_9be0526e != # "hash_20ea75a25d912949") {
      self hidefromplayer(e_player);
    }

    e_player clientfield::increment_to_player("" + # "hash_1a818fdb4337dc5e");
    util::wait_network_frame();
  }
}

function function_3f3be625(var_d5fa8477, var_eac6151d) {
  self endon(#"disconnect");

  if(getdvarint(#"hash_4f30c8114ee899d3", 0)) {
    return;
  }

  if(isDefined(var_eac6151d)) {
    var_eac6151d stoploopsound();
    var_eac6151d endon(#"death");
  } else {
    var_eac6151d = self;
  }

  if(self issplitscreen()) {
    foreach(other_player in getplayers()) {
      if(self === other_player) {
        continue;
      }

      if(self isplayeronsamemachine(other_player) && is_true(level.var_eb704e15[var_d5fa8477][other_player.name])) {
        var_1bdc121e = 1;
        break;
      }
    }
  }

  if(isarray(var_eac6151d.var_7e1c3be1) && var_eac6151d.var_7e1c3be1.size && !is_true(var_1bdc121e)) {
    foreach(var_b3130155 in var_eac6151d.var_7e1c3be1) {
      var_eac6151d stopsound(var_b3130155);
    }

    var_eac6151d.var_7e1c3be1 = [];
  }

  s_bundle = getscriptbundle(var_d5fa8477);
  var_eac6151d function_bd78aea0(s_bundle, self);

  if(isarray(s_bundle.var_1ad142ee) && s_bundle.var_1ad142ee.size) {
    if(is_true(s_bundle.var_2a12d36)) {
      foreach(index, var_73a92203 in s_bundle.var_1ad142ee) {
        if(index == s_bundle.var_1ad142ee.size - 1) {
          var_eac6151d function_8a6749e9(var_73a92203.soundevent, self, var_73a92203.var_f35c5951, undefined, var_73a92203.var_5d4b5964, var_1bdc121e);
          continue;
        }

        var_eac6151d thread function_8a6749e9(var_73a92203.soundevent, self, var_73a92203.var_f35c5951, undefined, undefined, var_1bdc121e);
      }
    } else {
      foreach(var_73a92203 in s_bundle.var_1ad142ee) {
        var_eac6151d function_8a6749e9(var_73a92203.soundevent, self, undefined, var_73a92203.var_f35c5951, var_73a92203.var_5d4b5964, var_1bdc121e);
      }
    }

    if(isDefined(var_eac6151d.script_flag_true) && !level flag::get(var_eac6151d.script_flag_true)) {
      var_eac6151d showtoplayer(self);
      var_eac6151d stopsounds();
      util::wait_network_frame();

      if(isDefined(var_eac6151d) && isPlayer(self)) {
        var_eac6151d hidefromplayer(self);
      }
    }
  }

  var_eac6151d function_8f6791a4(s_bundle, self);
}

function private function_8a6749e9(var_9c1ebb19, e_player, var_dcfc156f, var_c736b731, var_70da3e8f, var_1bdc121e) {
  if(!isDefined(self) || !isDefined(e_player)) {
    return;
  }

  if(isPlayer(self)) {
    self endon(#"disconnect");
  } else {
    self endon(#"death");
  }

  if(isPlayer(e_player)) {
    e_player endon(#"disconnect");
  }

  if(isDefined(self.script_flag_true)) {
    if(level flag::get(self.script_flag_true)) {
      level endon(self.script_flag_true);
    } else {
      return;
    }
  }

  if(isDefined(var_9c1ebb19)) {
    if(isDefined(var_dcfc156f)) {
      wait var_dcfc156f;
    }

    if(!is_true(var_1bdc121e)) {
      self playsoundtoplayer(var_9c1ebb19, e_player);

      if(!isDefined(self.var_7e1c3be1)) {
        self.var_7e1c3be1 = [];
      } else if(!isarray(self.var_7e1c3be1)) {
        self.var_7e1c3be1 = array(self.var_7e1c3be1);
      }

      self.var_7e1c3be1[self.var_7e1c3be1.size] = var_9c1ebb19;
    }

    if(zm_vo::function_32464c29()) {
      if(isDefined(var_70da3e8f)) {
        var_2690dae = var_70da3e8f;
      } else {
        var_2690dae = 3;
      }
    } else {
      var_2690dae = float(isDefined(soundgetplaybacktime(var_9c1ebb19)) ? soundgetplaybacktime(var_9c1ebb19) : 0) / 1000;
      var_2690dae = max(var_2690dae, 0.1);
    }

    wait var_2690dae;

    if(isDefined(var_c736b731)) {
      wait var_c736b731;
    }

    if(!is_true(var_1bdc121e)) {
      arrayremovevalue(self.var_7e1c3be1, var_9c1ebb19);
    }
  }
}

function private function_bd78aea0(var_19a3087c, e_player) {
  if(isDefined(self.script_flag_true)) {
    if(level flag::get(self.script_flag_true)) {
      level endon(self.script_flag_true);
    } else {
      return;
    }
  }

  if(isDefined(var_19a3087c.var_348b91fd)) {
    switch (var_19a3087c.var_348b91fd) {
      case # "tape":
        var_27c5b5a9 = # "hash_ea30fff000de600";
        var_42e4e060 = # "hash_aa0fa647067d823";
        break;
      case # "radio":
        var_27c5b5a9 = # "hash_5c60481ce158163d";
        var_42e4e060 = # "hash_274981480733b7d0";
        break;
      default:
        var_27c5b5a9 = # "hash_23e6a36fce4ab6ef";
        var_42e4e060 = # "hash_6e621d4031bf8c5a";
        break;
    }
  }

  if(isDefined(var_27c5b5a9)) {
    self playsoundtoplayer(var_27c5b5a9, e_player);
  }

  self function_3a2dd570(e_player);
  wait 1;

  if(isDefined(self) && isPlayer(e_player) && isDefined(var_19a3087c.var_3bb3493d)) {
    self playsoundtoplayer(var_19a3087c.var_3bb3493d, e_player);
  }
}

function private function_8f6791a4(var_19a3087c, e_player) {
  self function_3a2dd570(e_player);

  if(isDefined(var_19a3087c.var_348b91fd)) {
    switch (var_19a3087c.var_348b91fd) {
      case # "tape":
        var_37b08e30 = # "hash_f315a8d18c2e535";
        break;
      case # "radio":
        var_37b08e30 = # "hash_203997b7ca5c0dd4";
        break;
      default:
        var_37b08e30 = # "hash_6071229013cd6a96";
        break;
    }
  }

  if(isDefined(self) && isPlayer(e_player) && isDefined(var_37b08e30)) {
    self playsoundtoplayer(var_37b08e30, e_player);

    if(isDefined(var_19a3087c.var_3bb3493d)) {
      self stopsound(var_19a3087c.var_3bb3493d);
    }
  }
}

function function_2bcfd899(var_f84ece9f, player) {
  if(isDefined(level.var_fa1d4366)) {
    var_d5fa8477 = level.var_fa1d4366;
    level.var_fa1d4366 = undefined;
    return var_d5fa8477;
  }

  switch (var_f84ece9f) {
    case # "hash_76270a10851f51d8":
      var_bf0df48d = level.var_9ff51719;
      break;
    case # "hash_71c51f24f7f3037d":
      var_bf0df48d = level.var_64d3d5c4;
      break;
    case # "hash_405e81feb85c5162":
      var_bf0df48d = level.var_13ebf509;
      break;
    case # "hash_6fec31948ca2058c":
      var_bf0df48d = level.var_1e898375;
      break;
    case # "hash_28fec49f37a535b9":
      var_bf0df48d = level.var_b131552c;
      break;
    default:
      assertmsg("<dev string:x111>");
      return;
  }

  if(!isDefined(var_bf0df48d)) {
    println("<dev string:x14f>" + var_f84ece9f);
    return;
  }

  var_71b26808 = getscriptbundle(var_bf0df48d);

  if(!isarray(var_71b26808.var_572513bb) || !var_71b26808.var_572513bb.size) {
    return;
  }

  foreach(n_index, var_a36fa2c6 in var_71b26808.var_572513bb) {
    if(var_a36fa2c6.season === # "hash_3c8cc59cdaa4bb29") {
      continue;
    }

    if(isDefined(player)) {
      if(!player function_f0f36d47(var_a36fa2c6.var_cb9cd317) && function_43abed5a(var_a36fa2c6.var_cb9cd317)) {
        if(var_f84ece9f === # "hash_71c51f24f7f3037d") {
          player clientfield::set_to_player("" + # "hash_711c8fee28432b7", n_index);
        }

        return var_a36fa2c6.var_cb9cd317;
      }

      continue;
    }

    if(!function_1a594d26(var_a36fa2c6.var_cb9cd317) && function_43abed5a(var_a36fa2c6.var_cb9cd317)) {
      return var_a36fa2c6.var_cb9cd317;
    }
  }
}

function function_a3e4f9a1(var_f84ece9f) {
  if(isDefined(var_f84ece9f)) {
    switch (var_f84ece9f) {
      case # "hash_76270a10851f51d8":
        var_bf0df48d = level.var_9ff51719;
        break;
      case # "hash_71c51f24f7f3037d":
        var_bf0df48d = level.var_64d3d5c4;
        break;
      case # "hash_405e81feb85c5162":
        var_bf0df48d = level.var_13ebf509;
        break;
      case # "hash_6fec31948ca2058c":
        var_bf0df48d = level.var_1e898375;
        break;
      case # "hash_28fec49f37a535b9":
        var_bf0df48d = level.var_b131552c;
        break;
      default:
        assertmsg("<dev string:x111>");
        return true;
    }
  }

  if(!isDefined(var_bf0df48d)) {
    println("<dev string:x14f>" + var_f84ece9f);
    return true;
  }

  var_71b26808 = getscriptbundle(var_bf0df48d);

  if(!isarray(var_71b26808.var_572513bb) || !var_71b26808.var_572513bb.size) {
    return true;
  }

  foreach(var_a36fa2c6 in var_71b26808.var_572513bb) {
    if(var_a36fa2c6.season === # "hash_3c8cc59cdaa4bb29") {
      continue;
    }

    if(!self function_f0f36d47(var_a36fa2c6.var_cb9cd317)) {
      return false;
    }
  }

  return true;
}

function function_1a594d26(var_d5fa8477) {
  foreach(player in getplayers()) {
    if(!player function_f0f36d47(var_d5fa8477)) {
      return false;
    }
  }

  return true;
}

function private on_ai_killed(params) {
  if(isPlayer(params.eattacker) && (self.zm_ai_category === # "elite" || self.zm_ai_category === # "special")) {
    if(self.subarchetype === # "hash_12fa854f3a7721b9" || self.subarchetype === # "hash_3498fb1fbfcd0cf" || self.subarchetype === # "hash_5653bbc44a034094" || self.subarchetype === # "hash_70162f4bc795092") {
      level.var_df1d1235 += 0.5;
    } else {
      level.var_df1d1235 += 1;
    }
  }

  if((isDefined(level.var_fa1d4366) || (self.zm_ai_category === # "special" || self.zm_ai_category === # "elite") && isPlayer(params.eattacker) && (level.var_df1d1235 >= 4 || math::cointoss(10))) && function_44fcc093(self.origin)) {
    var_44a24b57 = self.origin + (0, 0, 36);

    if(self.archetype === # "avogadro" && level.script === "zm_tungsten") {
      var_44a24b57 += (0, 0, 16);
    }

    level thread function_20c3dbfd(getplayers(), var_44a24b57);
  }
}

function function_20c3dbfd(a_players, var_44a24b57, var_85225c01 = 0, var_7e1bf71f) {
  if(zm_utility::is_survival()) {
    var_16532ad3 = 3;
  } else {
    var_16532ad3 = 1;
  }

  foreach(player in a_players) {
    if((!isDefined(player) || player.var_e2d764da >= var_16532ad3 || is_true(player.var_cfc2f4bc)) && !isDefined(level.var_fa1d4366)) {
      continue;
    }

    var_d5fa8477 = function_2bcfd899(#"hash_76270a10851f51d8", player);
    var_e041507a = player getentitynumber();

    if(isDefined(var_d5fa8477)) {
      v_angles = (0, var_e041507a * 90 + var_85225c01, 0);
      mdl_intel = function_2ba45c94(var_d5fa8477, var_44a24b57, v_angles, (64, 64, 64), undefined, undefined, player.name, var_7e1bf71f);
      player.var_e2d764da++;

      if(isDefined(mdl_intel.itementry)) {
        mdl_intel.itementry.var_4cd830a = 1;
      }

      if(zm_utility::is_survival()) {
        player.var_cfc2f4bc = 1;
      }
    }
  }
}

function private function_44fcc093(v_pos) {
  if(zm_utility::is_survival()) {
    if(ispointonnavmesh(v_pos, 15)) {
      var_b65c6fdd = function_9cc082d2(v_pos, 128);

      if(isDefined(var_b65c6fdd[# "point"]) && namespace_d0ab5955::function_3824d2dc(var_b65c6fdd[# "point"]) && function_39c955d5(var_b65c6fdd[# "point"])) {
        return true;
      }
    }
  } else if(zm_utility::check_point_in_playable_area(self.origin) || is_true(level.var_374c2805)) {
    return true;
  }

  return false;
}

function private function_39c955d5(var_ab528fee) {
  v_trace_start = var_ab528fee + (0, 0, 70);
  trace = physicstraceex(v_trace_start, var_ab528fee);

  if(trace[# "fraction"] < 0.99) {
    return false;
  }

  return true;
}

function function_d0e6ff7a(var_d5fa8477, var_8f788dfa, n_power) {
  s_intel = struct::get(var_d5fa8477, "scriptbundlename");

  if(isDefined(var_8f788dfa)) {
    t_damage = getent(var_8f788dfa, "targetname");
  }

  if(!isDefined(s_intel)) {
    return;
  }

  if(isDefined(t_damage)) {
    t_damage setCanDamage(1);
    s_waitresult = t_damage waittill(#"trigger", #"damage");
  } else if(isDefined(s_intel.mdl_intel)) {
    s_intel.mdl_intel val::set("zmintel", "takedamage", 1);
    s_intel.mdl_intel val::set("zmintel", "allowdeath", 0);
    s_waitresult = s_intel.mdl_intel waittill(#"damage");
  } else {
    return;
  }

  s_intel function_c1974629(undefined, n_power);
  util::wait_network_frame();

  if(isDefined(t_damage)) {
    t_damage delete();
  }
}

function function_ded2880a() {
  util::init_dvar(#"hash_82bcb0445b8db9", "<dev string:x4c>", &function_2ced1cf7);
  util::init_dvar(#"hash_10552bfd7317e7d1", "<dev string:x4c>", &function_2ced1cf7);
  util::init_dvar(#"hash_4bb23fc5179a1812", "<dev string:x4c>", &function_2ced1cf7);
  util::init_dvar(#"hash_6aad5d3866085387", "<dev string:x4c>", &function_2ced1cf7);
  util::add_debug_command("<dev string:x190>");

  foreach(var_d5fa8477 in level.var_54f9341) {
    var_d5fa8477 = function_9e72a96(var_d5fa8477);
    s_bundle = getscriptbundle(var_d5fa8477);

    if(isDefined(s_bundle)) {
      if(isDefined(s_bundle.var_ad4ad686)) {
        str_faction = function_9e72a96(s_bundle.var_ad4ad686);
      } else {
        str_faction = "<dev string:x1e8>";
      }

      if(isDefined(s_bundle.var_9be0526e)) {
        str_type = function_9e72a96(s_bundle.var_9be0526e);
      } else {
        str_type = "<dev string:x1f6>";
      }

      if(isDefined(s_bundle.season)) {
        var_7e4f1bf = "<dev string:x201>" + s_bundle.season;
      } else {
        var_7e4f1bf = "<dev string:x20c>";
      }

      var_2b65c1ac = str_faction + "<dev string:x219>" + str_type + "<dev string:x219>" + var_7e4f1bf + "<dev string:x219>" + var_d5fa8477;
    } else {
      var_2b65c1ac = var_d5fa8477;
    }

    util::add_debug_command("<dev string:x21e>" + var_2b65c1ac + "<dev string:x244>" + var_d5fa8477 + "<dev string:x26d>");
    util::add_debug_command("<dev string:x21e>" + var_2b65c1ac + "<dev string:x272>" + var_d5fa8477 + "<dev string:x26d>");
    util::add_debug_command("<dev string:x21e>" + var_2b65c1ac + "<dev string:x29b>" + var_d5fa8477 + "<dev string:x26d>");
  }
}

function function_2ced1cf7(params) {
  if(params.value === "<dev string:x4c>") {
    return;
  }

  switch (params.name) {
    case # "hash_6aad5d3866085387":
      if(int(params.value)) {
        iprintlnbold("<dev string:x2df>");
      } else {
        iprintlnbold("<dev string:x2f1>");
      }

      break;
    case # "hash_82bcb0445b8db9":
      foreach(player in getplayers()) {
        player thread collect_intel(params.value);
      }

      break;
    case # "hash_10552bfd7317e7d1":
      foreach(s_intel in level.var_238bd723) {
        if(s_intel.scriptbundlename === params.value) {
          v_pos = s_intel.origin;
          break;
        }
      }

      if(!isDefined(v_pos)) {
        var_a3d40366 = struct::get_array("<dev string:x304>");
        s_intel = getscriptbundle(params.value);

        foreach(var_927876a9 in var_a3d40366) {
          if(s_intel.var_9be0526e === # "hash_20ea75a25d912949" && var_927876a9.faction === s_intel.var_ad4ad686) {
            v_pos = var_927876a9.origin;
            break;
          }
        }
      }

      if(isDefined(v_pos)) {
        getplayers()[0] dontinterpolate();
        getplayers()[0] setorigin(v_pos);
      } else {
        iprintlnbold("<dev string:x32d>" + params.value);
      }

      break;
    case # "hash_4bb23fc5179a1812":
      if(function_1a594d26(params.value)) {
        iprintlnbold("<dev string:x349>" + params.value);
      } else {
        iprintln("<dev string:x36c>" + params.value + "<dev string:x376>");
        level.var_fa1d4366 = params.value;
      }

      break;
    default:
      break;
  }

  setDvar(#"hash_82bcb0445b8db9", "<dev string:x4c>");
  setDvar(#"hash_10552bfd7317e7d1", "<dev string:x4c>");
  setDvar(#"hash_4bb23fc5179a1812", "<dev string:x4c>");
}